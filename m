Return-Path: <SRS0=bavc=6T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4916C47257
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 14:50:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4B6B206B9
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 14:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B6B206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A17436E5D1;
	Tue,  5 May 2020 14:50:32 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A68D6E351
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2020 14:07:25 +0000 (UTC)
Received: from localhost.localdomain ([149.172.19.189]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N49Qd-1j5KPS3F33-0107Nn; Tue, 05 May 2020 16:02:11 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Hawking Zhang <Hawking.Zhang@amd.com>,
 John Clements <john.clements@amd.com>
Subject: [PATCH] drm/amdgpu: allocate large structures dynamically
Date: Tue,  5 May 2020 16:01:52 +0200
Message-Id: <20200505140208.284473-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:TSc6c1YhMkCs/1m6SAPJGzLtfTJo7NH6Kjg0A5Q4anVbFFYTPN5
 1czvuDksXTPHuVVr43jFu9sB5c2K9U6ytyW55vWyZ4r7H0ZUmFKe76IuD5mBKMJUf1MmwPe
 tlZvkffxNQkE68Ei2SmM2ddGqT4IuwdBy7H+4QdwPa2l1iB61k6gKOkn+y+Hiaa/z4D32XR
 4c8iHqP3q0nR2voq6Q9XQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b6bmVYOZz1A=:NAI4iCE0teAzIdNCKCFMCT
 87ZQakcJjcUm+73CmCAa1BFfhPtOK/t+4lI1jOuBWK93HxAiY0jRIhMVAgak+ngIw5B9b03wb
 HdXnYJSQuSO/nkYsJBsYScyqRgnuB5n79UgJ/Iq3SVI26RpJMVaWbonDRac63zQZmSTSr97gA
 +oZcWZHLf1eB9oV0MPs2YLUFrfQAGmRlvDvRj05xjAGT+TVwdcg6sCbnG+orL2saSalc3yPCp
 K30+z6fZcI1u0FLite+tTRawB4Panf+IoYM7BieIytkLMLVJmZUrMpRp6KaOJyOVl1tHQDCS6
 yVaoeFjpbO3D7WN6jalbe4kdUOMDXXWNJxY4+7XfH0b1TUdFDWn1oelDxiFV093RdbFAtuA3I
 tYnux1qe7knOLPijqMSi5to91FWzPmicvUp8ZAmw760B6a7Fh8wZaElobinNkKvIIBMbNMdrI
 SHIoSXNdpAzwVKCW+XiadS4lGTMcN5TcqFYjAahawwGkgsNPADtbBeh3hYZvHe2LN2ji6ekQi
 jOPoE25LUUYfNOqzuUSK37lCUyu2wULLXIBhe4RQdH3r7nsJZEQOKuVgZegWiyHixFZ1i8NLV
 ikrRdufir6RY7Kqn4y17Z4HA9OAYFYv8x7+E9bAAjt7/M/vLLzinhXYOcMLmYfW1m/ZHaTJ/h
 YgSPR8hinDU+3cruHJq5LaSaoRedbVbrpQlAF8wdc07F9cpK7b7f5HSaO631zh0W38/VhgMKZ
 Lpq9uo5xGdKYHoxnbp0uxzSEXnEkwJCbESA9HDSNrBeJS9q7QVn7jdjK79Gop2Y3jnT5ZEfDW
 HvVTBAIri1C7j581qGfUEnfWiVCTgWPil6xOr4C6XuDmR3uHLA=
X-Mailman-Approved-At: Tue, 05 May 2020 14:50:31 +0000
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
Cc: Arnd Bergmann <arnd@arndb.de>, Guchun Chen <guchun.chen@amd.com>,
 Tao Zhou <tao.zhou1@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After the structure was padded to 1024 bytes, it is no longer
suitable for being a local variable, as the function surpasses
the warning limit for 32-bit architectures:

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:587:5: error: stack frame size of 1072 bytes in function 'amdgpu_ras_feature_enable' [-Werror,-Wframe-larger-than=]
int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
    ^

Use kzalloc() instead to get it from the heap.

Fixes: a0d254820f43 ("drm/amdgpu: update RAS TA to Host interface")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 31 +++++++++++++++++--------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 538895cfd862..7348619253c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -588,19 +588,23 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 		struct ras_common_if *head, bool enable)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	union ta_ras_cmd_input info;
+	union ta_ras_cmd_input *info;
 	int ret;
 
 	if (!con)
 		return -EINVAL;
 
+        info = kzalloc(sizeof(union ta_ras_cmd_input), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
 	if (!enable) {
-		info.disable_features = (struct ta_ras_disable_features_input) {
+		info->disable_features = (struct ta_ras_disable_features_input) {
 			.block_id =  amdgpu_ras_block_to_ta(head->block),
 			.error_type = amdgpu_ras_error_to_ta(head->type),
 		};
 	} else {
-		info.enable_features = (struct ta_ras_enable_features_input) {
+		info->enable_features = (struct ta_ras_enable_features_input) {
 			.block_id =  amdgpu_ras_block_to_ta(head->block),
 			.error_type = amdgpu_ras_error_to_ta(head->type),
 		};
@@ -609,26 +613,33 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 	/* Do not enable if it is not allowed. */
 	WARN_ON(enable && !amdgpu_ras_is_feature_allowed(adev, head));
 	/* Are we alerady in that state we are going to set? */
-	if (!(!!enable ^ !!amdgpu_ras_is_feature_enabled(adev, head)))
-		return 0;
+	if (!(!!enable ^ !!amdgpu_ras_is_feature_enabled(adev, head))) {
+		ret = 0;
+		goto out;
+	}
 
 	if (!amdgpu_ras_intr_triggered()) {
-		ret = psp_ras_enable_features(&adev->psp, &info, enable);
+		ret = psp_ras_enable_features(&adev->psp, info, enable);
 		if (ret) {
 			amdgpu_ras_parse_status_code(adev,
 						     enable ? "enable":"disable",
 						     ras_block_str(head->block),
 						    (enum ta_ras_status)ret);
 			if (ret == TA_RAS_STATUS__RESET_NEEDED)
-				return -EAGAIN;
-			return -EINVAL;
+				ret = -EAGAIN;
+			else
+				ret = -EINVAL;
+
+			goto out;
 		}
 	}
 
 	/* setup the obj */
 	__amdgpu_ras_feature_enable(adev, head, enable);
-
-	return 0;
+	ret = 0;
+out:
+	kfree(info);
+	return ret;
 }
 
 /* Only used in device probe stage and called only once. */
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
