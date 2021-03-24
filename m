Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48563C433C1
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 14:43:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D57DC619FC
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 14:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D57DC619FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86DD66EA10;
	Wed, 24 Mar 2021 14:43:16 +0000 (UTC)
X-Greylist: delayed 318 seconds by postgrey-1.36 at gabe;
 Wed, 24 Mar 2021 14:37:21 UTC
Received: from smtprelay.hostedemail.com (smtprelay0143.hostedemail.com
 [216.40.44.143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AE816EA10
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 14:37:21 +0000 (UTC)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave03.hostedemail.com (Postfix) with ESMTP id EAC55181A349A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 14:32:03 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay06.hostedemail.com (Postfix) with ESMTP id 32F09182244EB;
 Wed, 24 Mar 2021 14:32:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hill42_1e033b52777b
X-Filterd-Recvd-Size: 4973
Received: from [192.168.1.159] (unknown [47.151.137.21])
 (Authenticated sender: joe@perches.com)
 by omf11.hostedemail.com (Postfix) with ESMTPA;
 Wed, 24 Mar 2021 14:31:59 +0000 (UTC)
Message-ID: <382fd12d804ac8e2693f92cf649c4f038f9c022e.camel@perches.com>
Subject: Re: [PATCH] amdgpu: fix gcc -Wrestrict warning
From: Joe Perches <joe@perches.com>
To: Arnd Bergmann <arnd@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>,  Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter
 <daniel@ffwll.ch>
Date: Wed, 24 Mar 2021 07:31:58 -0700
In-Reply-To: <20210323130430.2250052-1-arnd@kernel.org>
References: <20210323130430.2250052-1-arnd@kernel.org>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 24 Mar 2021 14:43:15 +0000
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
Cc: Jinzhou Su <Jinzhou.Su@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, 2021-03-23 at 14:04 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> =

> gcc warns about an sprintf() that uses the same buffer as source
> and destination, which is undefined behavior in C99:
> =

> drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c: In function 'amdgpu_se=
curedisplay_debugfs_write':
> drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c:141:6: error: 'sprintf'=
 argument 3 overlaps destination object 'i2c_output' [-Werror=3Drestrict]
> =A0=A0141 |      sprintf(i2c_output, "%s 0x%X", i2c_output,
> =A0=A0=A0=A0=A0=A0|      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> =A0=A0142 |       securedisplay_cmd->securedisplay_out_message.send_roi_c=
rc.i2c_buf[i]);
> =A0=A0=A0=A0=A0=A0|       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c:97:7: note: destination=
 object referenced by 'restrict'-qualified argument 1 was declared here
> =A0=A0=A097 |  char i2c_output[256];
> =A0=A0=A0=A0=A0=A0|       ^~~~~~~~~~
> =

> Rewrite it to remember the current offset into the buffer instead.
> =

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> =A0drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 3 ++-
> =A01 file changed, 2 insertions(+), 1 deletion(-)
> =

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> index 834440ab9ff7..69d7f6bff5d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> @@ -136,9 +136,10 @@ static ssize_t amdgpu_securedisplay_debugfs_write(st=
ruct file *f, const char __u
> =A0		ret =3D psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__SEND=
_ROI_CRC);
> =A0		if (!ret) {
> =A0			if (securedisplay_cmd->status =3D=3D TA_SECUREDISPLAY_STATUS__SUCCE=
SS) {
> +				int pos =3D 0;
> =A0				memset(i2c_output,  0, sizeof(i2c_output));
> =A0				for (i =3D 0; i < TA_SECUREDISPLAY_I2C_BUFFER_SIZE; i++)
> -					sprintf(i2c_output, "%s 0x%X", i2c_output,
> +					pos +=3D sprintf(i2c_output + pos, " 0x%X",
> =A0						securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_bu=
f[i]);
> =A0				dev_info(adev->dev, "SECUREDISPLAY: I2C buffer out put is :%s\n", =
i2c_output);

Perhaps use a hex output like:

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_securedisplay.c
index 9cf856c94f94..25bb34c72d20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
@@ -97,13 +97,12 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struc=
t file *f, const char __u
 	uint32_t op;
 	int i;
 	char str[64];
-	char i2c_output[256];
 	int ret;
 =

 	if (*pos || size > sizeof(str) - 1)
 		return -EINVAL;
 =

-	memset(str,  0, sizeof(str));
+	memset(str, 0, sizeof(str));
 	ret =3D copy_from_user(str, buf, size);
 	if (ret)
 		return -EFAULT;
@@ -139,11 +138,9 @@ static ssize_t amdgpu_securedisplay_debugfs_write(stru=
ct file *f, const char __u
 		ret =3D psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__SEND_ROI=
_CRC);
 		if (!ret) {
 			if (securedisplay_cmd->status =3D=3D TA_SECUREDISPLAY_STATUS__SUCCESS) {
-				memset(i2c_output,  0, sizeof(i2c_output));
-				for (i =3D 0; i < TA_SECUREDISPLAY_I2C_BUFFER_SIZE; i++)
-					sprintf(i2c_output, "%s 0x%X", i2c_output,
-						securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf[i]=
);
-				dev_info(adev->dev, "SECUREDISPLAY: I2C buffer out put is :%s\n", i2c_=
output);
+				dev_info(adev->dev, "SECUREDISPLAY: I2C buffer output is: %*ph\n",
+					 (int)TA_SECUREDISPLAY_I2C_BUFFER_SIZE,
+					 securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf);
 			} else {
 				psp_securedisplay_parse_resp_status(psp, securedisplay_cmd->status);
 			}


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
