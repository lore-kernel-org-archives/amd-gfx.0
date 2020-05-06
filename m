Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781B4C28CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 19:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EC9D20747
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 19:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC9D20747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 116128955D;
	Wed,  6 May 2020 19:36:33 +0000 (UTC)
Received: from smtprelay.hostedemail.com (smtprelay0224.hostedemail.com
 [216.40.44.224])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BF9B6E8C9;
 Wed,  6 May 2020 19:01:47 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay04.hostedemail.com (Postfix) with ESMTP id 9A33D180A7340;
 Wed,  6 May 2020 19:01:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: kiss33_6657176918f26
X-Filterd-Recvd-Size: 5441
Received: from XPS-9350.home (unknown [47.151.136.130])
 (Authenticated sender: joe@perches.com)
 by omf11.hostedemail.com (Postfix) with ESMTPA;
 Wed,  6 May 2020 19:01:43 +0000 (UTC)
Message-ID: <006e29037a9314fb286a5d6d84905bce99cef6c7.camel@perches.com>
Subject: Re: [PATCH] drm/amdgpu: allocate large structures dynamically
From: Joe Perches <joe@perches.com>
To: Arnd Bergmann <arnd@arndb.de>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David
 (ChunMing) Zhou" <David1.Zhou@amd.com>,  David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 John Clements <john.clements@amd.com>
Date: Wed, 06 May 2020 12:01:41 -0700
In-Reply-To: <20200505140208.284473-1-arnd@arndb.de>
References: <20200505140208.284473-1-arnd@arndb.de>
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 06 May 2020 19:36:31 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Guchun Chen <guchun.chen@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, 2020-05-05 at 16:01 +0200, Arnd Bergmann wrote:
> After the structure was padded to 1024 bytes, it is no longer
> suitable for being a local variable, as the function surpasses
> the warning limit for 32-bit architectures:
> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:587:5: error: stack frame size of 1072 bytes in function 'amdgpu_ras_feature_enable' [-Werror,-Wframe-larger-than=]
> int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
>     ^
> 
> Use kzalloc() instead to get it from the heap.
[]
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
[]
> @@ -588,19 +588,23 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
>  		struct ras_common_if *head, bool enable)
>  {
>  	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> -	union ta_ras_cmd_input info;
> +	union ta_ras_cmd_input *info;
>  	int ret;
>  
>  	if (!con)
>  		return -EINVAL;
>  
> +        info = kzalloc(sizeof(union ta_ras_cmd_input), GFP_KERNEL);

Spaces were used for indentation here not a tab.
It might be useful to run your proposed patches through checkpatch

Is this an actual bug fix as the previous use didn't
zero unused info members?

> +	if (!info)
> +		return -ENOMEM;
> +
>  	if (!enable) {
> -		info.disable_features = (struct ta_ras_disable_features_input) {
> +		info->disable_features = (struct ta_ras_disable_features_input) {
>  			.block_id =  amdgpu_ras_block_to_ta(head->block),
>  			.error_type = amdgpu_ras_error_to_ta(head->type),
>  		};
>  	} else {
> -		info.enable_features = (struct ta_ras_enable_features_input) {
> +		info->enable_features = (struct ta_ras_enable_features_input) {
>  			.block_id =  amdgpu_ras_block_to_ta(head->block),
>  			.error_type = amdgpu_ras_error_to_ta(head->type),
>  		};
> @@ -609,26 +613,33 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
>  	/* Do not enable if it is not allowed. */
>  	WARN_ON(enable && !amdgpu_ras_is_feature_allowed(adev, head));
>  	/* Are we alerady in that state we are going to set? */
> -	if (!(!!enable ^ !!amdgpu_ras_is_feature_enabled(adev, head)))
> -		return 0;
> +	if (!(!!enable ^ !!amdgpu_ras_is_feature_enabled(adev, head))) {

And trivia:

The !! uses with bool seem unnecessary and it's probably better
to make amdgpu_ras_is_feature_enabled to return bool.

Maybe something like:
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 538895cfd862..05c4eaf0ddfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -526,16 +526,16 @@ void amdgpu_ras_parse_status_code(struct amdgpu_device* adev,
 }
 
 /* feature ctl begin */
-static int amdgpu_ras_is_feature_allowed(struct amdgpu_device *adev,
-		struct ras_common_if *head)
+static bool amdgpu_ras_is_feature_allowed(struct amdgpu_device *adev,
+					  struct ras_common_if *head)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
 	return con->hw_supported & BIT(head->block);
 }
 
-static int amdgpu_ras_is_feature_enabled(struct amdgpu_device *adev,
-		struct ras_common_if *head)
+static bool amdgpu_ras_is_feature_enabled(struct amdgpu_device *adev,
+					  struct ras_common_if *head)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
@@ -560,7 +560,7 @@ static int __amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 	 */
 	if (!amdgpu_ras_is_feature_allowed(adev, head))
 		return 0;
-	if (!(!!enable ^ !!amdgpu_ras_is_feature_enabled(adev, head)))
+	if (!(enable ^ amdgpu_ras_is_feature_enabled(adev, head)))
 		return 0;
 
 	if (enable) {
@@ -609,7 +609,7 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 	/* Do not enable if it is not allowed. */
 	WARN_ON(enable && !amdgpu_ras_is_feature_allowed(adev, head));
 	/* Are we alerady in that state we are going to set? */
-	if (!(!!enable ^ !!amdgpu_ras_is_feature_enabled(adev, head)))
+	if (!(enable ^ amdgpu_ras_is_feature_enabled(adev, head)))
 		return 0;
 
 	if (!amdgpu_ras_intr_triggered()) {



_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
