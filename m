From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: Clang warning in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
Date: Wed, 20 Mar 2019 08:44:50 -0700
Message-ID: <20190320154450.GA20310@archlinux-ryzen>
References: <20190320005406.GA16412@archlinux-ryzen>
 <SN6PR12MB280017BDAB60B61088B221C287410@SN6PR12MB2800.namprd12.prod.outlook.com>
 <20190320043440.GA23335@archlinux-ryzen>
 <63518f1f-b808-77b0-aac6-ee1ece669c4b@amd.com>
 <CAAzmS6_LL1bveq0HaHMqE-T2ciuZu=zd4HOFfwW99P1n0cmakA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAzmS6_LL1bveq0HaHMqE-T2ciuZu=zd4HOFfwW99P1n0cmakA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Hines <srhines@google.com>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "clang-built-linux@googlegroups.com" <clang-built-linux@googlegroups.com>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Mar 20, 2019 at 07:58:09AM -0700, Stephen Hines wrote:
> Why are there 2 different enums for this same thing at all? By casting, you
> are reducing type safety in the kernel, which can cause bugs later (should
> the two enums diverge in encoding). In my opinion, the proper solution is
> to remove one of the enums or provide an explicit helper that does the
> conversion (along with assertions for handling any unexpected cases). The
> helper function should not be doing a direct cast, since a bug could change
> the integer value of one (or both) of these enums so that they don't match
> up.
> 
> Thanks,
> Steve
> 

Indeed, I would suggest something like this (if this was to be a build
time error, this would need to be a macro instead of a function):

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index a71668b8a7d0..451478cf4f35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -541,13 +541,13 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 
 	if (!enable) {
 		info.disable_features = (struct ta_ras_disable_features_input) {
-			.block_id =  head->block,
-			.error_type = head->type,
+			.block_id =  amdgpu_ras_block_to_ta(head->block),
+			.error_type = amdgpu_ras_error_to_ta(head->type),
 		};
 	} else {
 		info.enable_features = (struct ta_ras_enable_features_input) {
-			.block_id =  head->block,
-			.error_type = head->type,
+			.block_id =  amdgpu_ras_block_to_ta(head->block),
+			.error_type = amdgpu_ras_error_to_ta(head->type),
 		};
 	}
 
@@ -647,8 +647,8 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 {
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
 	struct ta_ras_trigger_error_input block_info = {
-		.block_id = info->head.block,
-		.inject_error_type = info->head.type,
+		.block_id = amdgpu_ras_block_to_ta(info->head.block),
+		.inject_error_type = amdgpu_ras_error_to_ta(info->head.type),
 		.sub_block_index = info->head.sub_block_index,
 		.address = info->address,
 		.value = info->value,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 7a35316baab0..c8576ab6e057 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -197,6 +197,64 @@ static inline int amdgpu_ras_reset_gpu(struct amdgpu_device *adev,
 	return 0;
 }
 
+static inline enum ta_ras_block
+amdgpu_ras_block_to_ta(enum amdgpu_ras_block block)
+{
+	switch (block) {
+	case AMDGPU_RAS_BLOCK__UMC:
+		return TA_RAS_BLOCK__UMC;
+	case AMDGPU_RAS_BLOCK__SDMA:
+		return TA_RAS_BLOCK__SDMA;
+	case AMDGPU_RAS_BLOCK__GFX:
+		return TA_RAS_BLOCK__GFX;
+	case AMDGPU_RAS_BLOCK__MMHUB:
+		return TA_RAS_BLOCK__MMHUB;
+	case AMDGPU_RAS_BLOCK__ATHUB:
+		return TA_RAS_BLOCK__ATHUB;
+	case AMDGPU_RAS_BLOCK__PCIE_BIF:
+		return TA_RAS_BLOCK__PCIE_BIF;
+	case AMDGPU_RAS_BLOCK__HDP:
+		return TA_RAS_BLOCK__HDP;
+	case AMDGPU_RAS_BLOCK__XGMI_WAFL:
+		return TA_RAS_BLOCK__XGMI_WAFL;
+	case AMDGPU_RAS_BLOCK__DF:
+		return TA_RAS_BLOCK__DF;
+	case AMDGPU_RAS_BLOCK__SMN:
+		return TA_RAS_BLOCK__SMN;
+	case AMDGPU_RAS_BLOCK__SEM:
+		return TA_RAS_BLOCK__SEM;
+	case AMDGPU_RAS_BLOCK__MP0:
+		return TA_RAS_BLOCK__MP0;
+	case AMDGPU_RAS_BLOCK__MP1:
+		return TA_RAS_BLOCK__MP1;
+	case AMDGPU_RAS_BLOCK__FUSE:
+		return TA_RAS_BLOCK__FUSE;
+	default:
+		WARN(1, "amdgpu_ras_block_to_ta fell through with a value of %d\n", block);
+		return TA_RAS_BLOCK__UMC;
+	}
+}
+
+static inline enum ta_ras_error_type
+amdgpu_ras_error_to_ta(enum amdgpu_ras_error_type error)
+{
+	switch (error) {
+	case AMDGPU_RAS_ERROR__NONE:
+		return TA_RAS_ERROR__NONE;
+	case AMDGPU_RAS_ERROR__PARITY:
+		return TA_RAS_ERROR__PARITY;
+	case AMDGPU_RAS_ERROR__SINGLE_CORRECTABLE:
+		return TA_RAS_ERROR__SINGLE_CORRECTABLE;
+	case AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE:
+		return TA_RAS_ERROR__MULTI_UNCORRECTABLE;
+	case AMDGPU_RAS_ERROR__POISON:
+		return TA_RAS_ERROR__POISON;
+	default:
+		WARN(1, "amdgpu_ras_error_to_ta fell through with a value of %d\n", error);
+		return TA_RAS_ERROR__NONE;
+	}
+}
+
 /* called in ip_init and ip_fini */
 int amdgpu_ras_init(struct amdgpu_device *adev);
 void amdgpu_ras_post_init(struct amdgpu_device *adev);

> On Wed, Mar 20, 2019 at 2:37 AM Koenig, Christian <Christian.Koenig@amd.com>
> wrote:
> 
> > Am 20.03.19 um 05:34 schrieb Nathan Chancellor:
> > > On Wed, Mar 20, 2019 at 01:31:27AM +0000, Pan, Xinhui wrote:
> > >> these two enumerated types are same for now. both of them might change
> > in the future.
> > >>
> > >> I have not used clang, but would  .block_id =  (int)head->block fix
> > your warning? If such change is acceptable, I can make one then.
> > >>
> > >> Thanks
> > >> xinhui
> > >>
> > >>
> > >> -----Original Message-----
> > >> From: Nathan Chancellor <natechancellor@gmail.com>
> > >> Sent: 2019年3月20日 8:54
> > >> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <
> > Christian.Koenig@amd.com>; Zhou, David(ChunMing) <David1.Zhou@amd.com>;
> > Pan, Xinhui <Xinhui.Pan@amd.com>
> > >> Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org;
> > linux-kernel@vger.kernel.org; clang-built-linux@googlegroups.com
> > >> Subject: Clang warning in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > >>
> > >> Hi all,
> > >>
> > >> The introduction of this file in commit dbd249c24427 ("drm/amdgpu: add
> > amdgpu_ras.c to support ras (v2)") introduces the following Clang
> > >> warnings:
> > >>
> > >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:544:23: warning: implicit
> > conversion from enumeration type 'enum amdgpu_ras_block' to different
> > enumeration type 'enum ta_ras_block' [-Wenum-conversion]
> > >>                          .block_id =  head->block,
> > >>                                       ~~~~~~^~~~~
> > >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:545:24: warning: implicit
> > conversion from enumeration type 'enum amdgpu_ras_error_type' to different
> > enumeration type 'enum ta_ras_error_type' [-Wenum-conversion]
> > >>                          .error_type = head->type,
> > >>                                        ~~~~~~^~~~
> > >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:549:23: warning: implicit
> > conversion from enumeration type 'enum amdgpu_ras_block' to different
> > enumeration type 'enum ta_ras_block' [-Wenum-conversion]
> > >>                          .block_id =  head->block,
> > >>                                       ~~~~~~^~~~~
> > >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:550:24: warning: implicit
> > conversion from enumeration type 'enum amdgpu_ras_error_type' to different
> > enumeration type 'enum ta_ras_error_type' [-Wenum-conversion]
> > >>                          .error_type = head->type,
> > >>                                        ~~~~~~^~~~
> > >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:650:26: warning: implicit
> > conversion from enumeration type 'enum amdgpu_ras_block' to different
> > enumeration type 'enum ta_ras_block' [-Wenum-conversion]
> > >>                  .block_id = info->head.block,
> > >>                              ~~~~~~~~~~~^~~~~
> > >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:651:35: warning: implicit
> > conversion from enumeration type 'enum amdgpu_ras_error_type' to different
> > enumeration type 'enum ta_ras_error_type' [-Wenum-conversion]
> > >>                  .inject_error_type = info->head.type,
> > >>                                       ~~~~~~~~~~~^~~~
> > >> 6 warnings generated.
> > >>
> > >> Normally, I would sent a fix for this myself but I am not entirely sure
> > why these two enumerated types exist when one would do since they have the
> > same values minus the prefix. In fact, the ta_ras_{block,error_type} values
> > are never used aside from being defined. Some clarification would be
> > appreciated.
> > >>
> > >> Thank you,
> > >> Nathan
> > > Hi Xinhui,
> > >
> > > Yes, explicitly casting these six spots to int would resolve this
> > > warning.
> >
> > Another question is if it is such a good idea to just silence the warning?
> >
> > Maybe add a amdgpu_ras_error_to_ta() helper to do this casting?
> >
> > When the enums drift away from each other then we can still add warnings
> > to that helper to make sure we don't accidentally cast invalid values
> > around.
> >
> > Regards,
> > Christian.
> >
> > >
> > > Thank you for the quick response!
> > > Nathan
> >
> > --
> > You received this message because you are subscribed to the Google Groups
> > "Clang Built Linux" group.
> > To unsubscribe from this group and stop receiving emails from it, send an
> > email to clang-built-linux+unsubscribe@googlegroups.com.
> > To post to this group, send email to clang-built-linux@googlegroups.com.
> > To view this discussion on the web visit
> > https://groups.google.com/d/msgid/clang-built-linux/63518f1f-b808-77b0-aac6-ee1ece669c4b%40amd.com
> > .
> > For more options, visit https://groups.google.com/d/optout.
> >
