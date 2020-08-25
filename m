Return-Path: <SRS0=LR/f=CD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ADBC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 11:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1804D20706
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 11:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S5SNkkbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1804D20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D865B6E8D7;
	Tue, 25 Aug 2020 11:19:36 +0000 (UTC)
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 494966E8D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 11:19:36 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PBJW8v189042;
 Tue, 25 Aug 2020 11:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=mTCr95d0NZjFPC9ktSGkHcFYuKT7BceascC3y5ODfrA=;
 b=S5SNkkbk528kG/1a0HzhIUKCbR4RMWHR5z3EW/mv9kxQl3E6Dc9eDTc+H3UwcaM/bO7q
 u47j7bht9BYJCvNyZ67GB2h/hHuCkdQVHuir9vCC0I32y1L17wkzh1JiwoT+XCgGHrxI
 WOulXODkXqY+/yZmEuNyCKqKtwOrFZFrR27N8fnneFM+p9oEy9Wx/D4I7vSBIyZpfgTZ
 0foK4E/VN/9XO2g0ElALVLyaiUZRKiQKGVmbmBkn8v3/okHPk1wBrbH4y39az0USwJ85
 FgrHJIPXFblaEkF7ixXnvcQPxHDrPgLPR0APrGJgj8qruYyjMBG2zrGwqDIhxWO3w+vh Bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 333w6trd3h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 25 Aug 2020 11:19:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PBEkuX144847;
 Tue, 25 Aug 2020 11:19:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 333r9jrqtj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Aug 2020 11:19:31 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07PBJUS3029454;
 Tue, 25 Aug 2020 11:19:30 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 25 Aug 2020 04:19:30 -0700
Date: Tue, 25 Aug 2020 14:19:22 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/cik: fix buffer overflow in
 cik_get_register_value()
Message-ID: <20200825111922.GB285523@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200825111843.GA285523@mwanda>
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008250085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008250086
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
Cc: Frederick Lawler <fred@fredlawl.com>, David Airlie <airlied@linux.ie>,
 Marek =?utf-8?B?T2zFocOhaw==?= <marek.olsak@amd.com>,
 kernel-janitors@vger.kernel.org, Wenhui Sheng <Wenhui.Sheng@amd.com>,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Bjorn Helgaas <bhelgaas@google.com>, Evan Quan <evan.quan@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The values for "se_num" and "sh_num" come from the user in the ioctl.
They can be in the 0-255 range but if they're more than
AMDGPU_GFX_MAX_SE (4) or AMDGPU_GFX_MAX_SH_PER_SE (2) then it results in
an out of bounds read.

I split this function into to two to make the error handling simpler.

Fixes: aca31681b1a5 ("drm/amdgpu: used cached gca values for cik_read_register")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/amd/amdgpu/cik.c | 195 ++++++++++++++++---------------
 1 file changed, 103 insertions(+), 92 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 7e71ffbca93d..91ebfa485333 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1042,100 +1042,108 @@ static const struct amdgpu_allowed_register_entry cik_allowed_read_registers[] =
 	{mmPA_SC_RASTER_CONFIG_1, true},
 };
 
+static int cik_get_register_value_indexed(struct amdgpu_device *adev,
+					  u32 se_num, u32 sh_num,
+					  u32 reg_offset, u32 *value)
+{
+	unsigned se_idx = (se_num == 0xffffffff) ? 0 : se_num;
+	unsigned sh_idx = (sh_num == 0xffffffff) ? 0 : sh_num;
 
-static uint32_t cik_get_register_value(struct amdgpu_device *adev,
-				       bool indexed, u32 se_num,
-				       u32 sh_num, u32 reg_offset)
-{
-	if (indexed) {
-		uint32_t val;
-		unsigned se_idx = (se_num == 0xffffffff) ? 0 : se_num;
-		unsigned sh_idx = (sh_num == 0xffffffff) ? 0 : sh_num;
-
-		switch (reg_offset) {
-		case mmCC_RB_BACKEND_DISABLE:
-			return adev->gfx.config.rb_config[se_idx][sh_idx].rb_backend_disable;
-		case mmGC_USER_RB_BACKEND_DISABLE:
-			return adev->gfx.config.rb_config[se_idx][sh_idx].user_rb_backend_disable;
-		case mmPA_SC_RASTER_CONFIG:
-			return adev->gfx.config.rb_config[se_idx][sh_idx].raster_config;
-		case mmPA_SC_RASTER_CONFIG_1:
-			return adev->gfx.config.rb_config[se_idx][sh_idx].raster_config_1;
-		}
+	if (se_idx >= AMDGPU_GFX_MAX_SE ||
+	    sh_idx >= AMDGPU_GFX_MAX_SH_PER_SE)
+		return -EINVAL;
+
+	switch (reg_offset) {
+	case mmCC_RB_BACKEND_DISABLE:
+		*value = adev->gfx.config.rb_config[se_idx][sh_idx].rb_backend_disable;
+		return 0;
+	case mmGC_USER_RB_BACKEND_DISABLE:
+		*value = adev->gfx.config.rb_config[se_idx][sh_idx].user_rb_backend_disable;
+		return 0;
+	case mmPA_SC_RASTER_CONFIG:
+		*value = adev->gfx.config.rb_config[se_idx][sh_idx].raster_config;
+		return 0;
+	case mmPA_SC_RASTER_CONFIG_1:
+		*value = adev->gfx.config.rb_config[se_idx][sh_idx].raster_config_1;
+		return 0;
+	}
 
-		mutex_lock(&adev->grbm_idx_mutex);
-		if (se_num != 0xffffffff || sh_num != 0xffffffff)
-			amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff);
+	mutex_lock(&adev->grbm_idx_mutex);
+	if (se_num != 0xffffffff || sh_num != 0xffffffff)
+		amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff);
 
-		val = RREG32(reg_offset);
+	*value = RREG32(reg_offset);
 
-		if (se_num != 0xffffffff || sh_num != 0xffffffff)
-			amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
-		mutex_unlock(&adev->grbm_idx_mutex);
-		return val;
-	} else {
-		unsigned idx;
-
-		switch (reg_offset) {
-		case mmGB_ADDR_CONFIG:
-			return adev->gfx.config.gb_addr_config;
-		case mmMC_ARB_RAMCFG:
-			return adev->gfx.config.mc_arb_ramcfg;
-		case mmGB_TILE_MODE0:
-		case mmGB_TILE_MODE1:
-		case mmGB_TILE_MODE2:
-		case mmGB_TILE_MODE3:
-		case mmGB_TILE_MODE4:
-		case mmGB_TILE_MODE5:
-		case mmGB_TILE_MODE6:
-		case mmGB_TILE_MODE7:
-		case mmGB_TILE_MODE8:
-		case mmGB_TILE_MODE9:
-		case mmGB_TILE_MODE10:
-		case mmGB_TILE_MODE11:
-		case mmGB_TILE_MODE12:
-		case mmGB_TILE_MODE13:
-		case mmGB_TILE_MODE14:
-		case mmGB_TILE_MODE15:
-		case mmGB_TILE_MODE16:
-		case mmGB_TILE_MODE17:
-		case mmGB_TILE_MODE18:
-		case mmGB_TILE_MODE19:
-		case mmGB_TILE_MODE20:
-		case mmGB_TILE_MODE21:
-		case mmGB_TILE_MODE22:
-		case mmGB_TILE_MODE23:
-		case mmGB_TILE_MODE24:
-		case mmGB_TILE_MODE25:
-		case mmGB_TILE_MODE26:
-		case mmGB_TILE_MODE27:
-		case mmGB_TILE_MODE28:
-		case mmGB_TILE_MODE29:
-		case mmGB_TILE_MODE30:
-		case mmGB_TILE_MODE31:
-			idx = (reg_offset - mmGB_TILE_MODE0);
-			return adev->gfx.config.tile_mode_array[idx];
-		case mmGB_MACROTILE_MODE0:
-		case mmGB_MACROTILE_MODE1:
-		case mmGB_MACROTILE_MODE2:
-		case mmGB_MACROTILE_MODE3:
-		case mmGB_MACROTILE_MODE4:
-		case mmGB_MACROTILE_MODE5:
-		case mmGB_MACROTILE_MODE6:
-		case mmGB_MACROTILE_MODE7:
-		case mmGB_MACROTILE_MODE8:
-		case mmGB_MACROTILE_MODE9:
-		case mmGB_MACROTILE_MODE10:
-		case mmGB_MACROTILE_MODE11:
-		case mmGB_MACROTILE_MODE12:
-		case mmGB_MACROTILE_MODE13:
-		case mmGB_MACROTILE_MODE14:
-		case mmGB_MACROTILE_MODE15:
-			idx = (reg_offset - mmGB_MACROTILE_MODE0);
-			return adev->gfx.config.macrotile_mode_array[idx];
-		default:
-			return RREG32(reg_offset);
-		}
+	if (se_num != 0xffffffff || sh_num != 0xffffffff)
+		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	mutex_unlock(&adev->grbm_idx_mutex);
+	return 0;
+}
+
+static uint32_t cik_get_register_value(struct amdgpu_device *adev,
+				       u32 reg_offset)
+{
+	unsigned idx;
+
+	switch (reg_offset) {
+	case mmGB_ADDR_CONFIG:
+		return adev->gfx.config.gb_addr_config;
+	case mmMC_ARB_RAMCFG:
+		return adev->gfx.config.mc_arb_ramcfg;
+	case mmGB_TILE_MODE0:
+	case mmGB_TILE_MODE1:
+	case mmGB_TILE_MODE2:
+	case mmGB_TILE_MODE3:
+	case mmGB_TILE_MODE4:
+	case mmGB_TILE_MODE5:
+	case mmGB_TILE_MODE6:
+	case mmGB_TILE_MODE7:
+	case mmGB_TILE_MODE8:
+	case mmGB_TILE_MODE9:
+	case mmGB_TILE_MODE10:
+	case mmGB_TILE_MODE11:
+	case mmGB_TILE_MODE12:
+	case mmGB_TILE_MODE13:
+	case mmGB_TILE_MODE14:
+	case mmGB_TILE_MODE15:
+	case mmGB_TILE_MODE16:
+	case mmGB_TILE_MODE17:
+	case mmGB_TILE_MODE18:
+	case mmGB_TILE_MODE19:
+	case mmGB_TILE_MODE20:
+	case mmGB_TILE_MODE21:
+	case mmGB_TILE_MODE22:
+	case mmGB_TILE_MODE23:
+	case mmGB_TILE_MODE24:
+	case mmGB_TILE_MODE25:
+	case mmGB_TILE_MODE26:
+	case mmGB_TILE_MODE27:
+	case mmGB_TILE_MODE28:
+	case mmGB_TILE_MODE29:
+	case mmGB_TILE_MODE30:
+	case mmGB_TILE_MODE31:
+		idx = (reg_offset - mmGB_TILE_MODE0);
+		return adev->gfx.config.tile_mode_array[idx];
+	case mmGB_MACROTILE_MODE0:
+	case mmGB_MACROTILE_MODE1:
+	case mmGB_MACROTILE_MODE2:
+	case mmGB_MACROTILE_MODE3:
+	case mmGB_MACROTILE_MODE4:
+	case mmGB_MACROTILE_MODE5:
+	case mmGB_MACROTILE_MODE6:
+	case mmGB_MACROTILE_MODE7:
+	case mmGB_MACROTILE_MODE8:
+	case mmGB_MACROTILE_MODE9:
+	case mmGB_MACROTILE_MODE10:
+	case mmGB_MACROTILE_MODE11:
+	case mmGB_MACROTILE_MODE12:
+	case mmGB_MACROTILE_MODE13:
+	case mmGB_MACROTILE_MODE14:
+	case mmGB_MACROTILE_MODE15:
+		idx = (reg_offset - mmGB_MACROTILE_MODE0);
+		return adev->gfx.config.macrotile_mode_array[idx];
+	default:
+		return RREG32(reg_offset);
 	}
 }
 
@@ -1151,8 +1159,11 @@ static int cik_read_register(struct amdgpu_device *adev, u32 se_num,
 		if (reg_offset != cik_allowed_read_registers[i].reg_offset)
 			continue;
 
-		*value = cik_get_register_value(adev, indexed, se_num, sh_num,
-						reg_offset);
+		if (indexed)
+			return cik_get_register_value_indexed(adev, se_num, sh_num,
+						reg_offset, value);
+
+		*value = cik_get_register_value(adev, reg_offset);
 		return 0;
 	}
 	return -EINVAL;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
