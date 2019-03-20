From: Stephen Hines <srhines@google.com>
Subject: Re: Clang warning in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
Date: Wed, 20 Mar 2019 08:32:35 -0700
Message-ID: <CAAzmS6-pyH7TJ1A5i8J16ioZDCvwJb+kfu7Et-LnNNmyGnmabA@mail.gmail.com>
References: <20190320005406.GA16412@archlinux-ryzen> <SN6PR12MB280017BDAB60B61088B221C287410@SN6PR12MB2800.namprd12.prod.outlook.com>
 <20190320043440.GA23335@archlinux-ryzen> <63518f1f-b808-77b0-aac6-ee1ece669c4b@amd.com>
 <CAAzmS6_LL1bveq0HaHMqE-T2ciuZu=zd4HOFfwW99P1n0cmakA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAzmS6_LL1bveq0HaHMqE-T2ciuZu=zd4HOFfwW99P1n0cmakA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "clang-built-linux@googlegroups.com" <clang-built-linux@googlegroups.com>
List-Id: amd-gfx.lists.freedesktop.org

Resending as plain-text to rest of list.

Steve

On Wed, Mar 20, 2019 at 7:58 AM Stephen Hines <srhines@google.com> wrote:
>
> Why are there 2 different enums for this same thing at all? By casting, y=
ou are reducing type safety in the kernel, which can cause bugs later (shou=
ld the two enums diverge in encoding). In my opinion, the proper solution i=
s to remove one of the enums or provide an explicit helper that does the co=
nversion (along with assertions for handling any unexpected cases). The hel=
per function should not be doing a direct cast, since a bug could change th=
e integer value of one (or both) of these enums so that they don't match up=
.
>
> Thanks,
> Steve
>
> On Wed, Mar 20, 2019 at 2:37 AM Koenig, Christian <Christian.Koenig@amd.c=
om> wrote:
>>
>> Am 20.03.19 um 05:34 schrieb Nathan Chancellor:
>> > On Wed, Mar 20, 2019 at 01:31:27AM +0000, Pan, Xinhui wrote:
>> >> these two enumerated types are same for now. both of them might chang=
e in the future.
>> >>
>> >> I have not used clang, but would  .block_id =3D  (int)head->block fix=
 your warning? If such change is acceptable, I can make one then.
>> >>
>> >> Thanks
>> >> xinhui
>> >>
>> >>
>> >> -----Original Message-----
>> >> From: Nathan Chancellor <natechancellor@gmail.com>
>> >> Sent: 2019=E5=B9=B43=E6=9C=8820=E6=97=A5 8:54
>> >> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian=
 <Christian.Koenig@amd.com>; Zhou, David(ChunMing) <David1.Zhou@amd.com>; P=
an, Xinhui <Xinhui.Pan@amd.com>
>> >> Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; l=
inux-kernel@vger.kernel.org; clang-built-linux@googlegroups.com
>> >> Subject: Clang warning in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> >>
>> >> Hi all,
>> >>
>> >> The introduction of this file in commit dbd249c24427 ("drm/amdgpu: ad=
d amdgpu_ras.c to support ras (v2)") introduces the following Clang
>> >> warnings:
>> >>
>> >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:544:23: warning: implicit con=
version from enumeration type 'enum amdgpu_ras_block' to different enumerat=
ion type 'enum ta_ras_block' [-Wenum-conversion]
>> >>                          .block_id =3D  head->block,
>> >>                                       ~~~~~~^~~~~
>> >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:545:24: warning: implicit con=
version from enumeration type 'enum amdgpu_ras_error_type' to different enu=
meration type 'enum ta_ras_error_type' [-Wenum-conversion]
>> >>                          .error_type =3D head->type,
>> >>                                        ~~~~~~^~~~
>> >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:549:23: warning: implicit con=
version from enumeration type 'enum amdgpu_ras_block' to different enumerat=
ion type 'enum ta_ras_block' [-Wenum-conversion]
>> >>                          .block_id =3D  head->block,
>> >>                                       ~~~~~~^~~~~
>> >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:550:24: warning: implicit con=
version from enumeration type 'enum amdgpu_ras_error_type' to different enu=
meration type 'enum ta_ras_error_type' [-Wenum-conversion]
>> >>                          .error_type =3D head->type,
>> >>                                        ~~~~~~^~~~
>> >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:650:26: warning: implicit con=
version from enumeration type 'enum amdgpu_ras_block' to different enumerat=
ion type 'enum ta_ras_block' [-Wenum-conversion]
>> >>                  .block_id =3D info->head.block,
>> >>                              ~~~~~~~~~~~^~~~~
>> >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:651:35: warning: implicit con=
version from enumeration type 'enum amdgpu_ras_error_type' to different enu=
meration type 'enum ta_ras_error_type' [-Wenum-conversion]
>> >>                  .inject_error_type =3D info->head.type,
>> >>                                       ~~~~~~~~~~~^~~~
>> >> 6 warnings generated.
>> >>
>> >> Normally, I would sent a fix for this myself but I am not entirely su=
re why these two enumerated types exist when one would do since they have t=
he same values minus the prefix. In fact, the ta_ras_{block,error_type} val=
ues are never used aside from being defined. Some clarification would be ap=
preciated.
>> >>
>> >> Thank you,
>> >> Nathan
>> > Hi Xinhui,
>> >
>> > Yes, explicitly casting these six spots to int would resolve this
>> > warning.
>>
>> Another question is if it is such a good idea to just silence the warnin=
g?
>>
>> Maybe add a amdgpu_ras_error_to_ta() helper to do this casting?
>>
>> When the enums drift away from each other then we can still add warnings
>> to that helper to make sure we don't accidentally cast invalid values
>> around.
>>
>> Regards,
>> Christian.
>>
>> >
>> > Thank you for the quick response!
>> > Nathan
>>
>> --
>> You received this message because you are subscribed to the Google Group=
s "Clang Built Linux" group.
>> To unsubscribe from this group and stop receiving emails from it, send a=
n email to clang-built-linux+unsubscribe@googlegroups.com.
>> To post to this group, send email to clang-built-linux@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msg=
id/clang-built-linux/63518f1f-b808-77b0-aac6-ee1ece669c4b%40amd.com.
>> For more options, visit https://groups.google.com/d/optout.
