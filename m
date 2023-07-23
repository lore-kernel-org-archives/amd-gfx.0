Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AD7C001DC
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jul 2023 07:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2D1010E061;
	Sun, 23 Jul 2023 07:05:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC75210E061
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jul 2023 07:05:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSFx6FNaHrAoH8hicEsVwnYKJAdpkfiTT7NS/IHWjXEeSyRwu1I4Y5frZIlU2PhmNxFTr6el+u1GPwzYwke15DAMlJQITKk2n2wYtBDLnuifvEQllumoW6KhOSHbpC3XB0pOZmyvfcO3akSQQ+Bv/EtjXd112ahZovHXvzED4YFooZGCR9E9U1RBRLRS9TTIAr2425Wvw+Mp0eR4GKGq9kgBKjMDhLuKhVkQDsbI78qUjtcnBPEFgVHa1lWaecekQd34BTiFe7S/vmQR97Z/yXPeTWpcAZemMAyRKH5HOGHloRR/HCO8ajvljFTALzcbWyz36Us5cn8QK3mBcxnCUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UgYw7IQg5f5HoKGBOr9E8kF8h5JKLuj/96QVP1RALg=;
 b=Npsp2/ZFBIpLnuWQBZtleV4+UAQ6eZ72iwfySvPti3XvlorWtepz5trA53CNRrgN6DQDBRSPU17jGHUc7vfSSepmE39X7tUVQs0XP4DYKvDC1ec8lJsZtr2CFiy/uQ2pWKeJTG2WVYOKPxORy6UGfvl0GYrhDi1u4VSFQ0CbR9PApaCl0mDl5mm+WHpt5TL34Iz3uyoePm8e3WmjM5E973iQE063zza3C4shs1Vq0yDk7VL/Pvk01Zr7k9WjTaj3+PbNmm1AQjlIqpWLhdNpvWQ+YIcDB5jOrmsYMnBXEyGwU+JAMiABSPouxwTpqmrT2w4p0vqrql35adQqkTOYCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UgYw7IQg5f5HoKGBOr9E8kF8h5JKLuj/96QVP1RALg=;
 b=a3ZlsXrRBVWodk8g4mf7r0wN46SLEHmwRV07E1bUIv/71LUk/k1OFeAmVZ9wKOZKDp+vWr8hCzBHIZRMJMSnyV1dFO0Sk9EoRbY68XX588O9ngXUJHYg/o13CN1ROgfDUZAQjrXP7cSB9F1abG8MqxYkCrFai26YVOhHOqCEKz8=
Received: from MW4P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::7)
 by PH0PR12MB7469.namprd12.prod.outlook.com (2603:10b6:510:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Sun, 23 Jul
 2023 07:05:47 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::68) by MW4P222CA0002.outlook.office365.com
 (2603:10b6:303:114::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31 via Frontend
 Transport; Sun, 23 Jul 2023 07:05:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Sun, 23 Jul 2023 07:05:46 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 23 Jul
 2023 02:05:44 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Update min() to min_t() in 'amdgpu_info_ioctl'
Date: Sun, 23 Jul 2023 12:35:27 +0530
Message-ID: <20230723070527.2024673-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT061:EE_|PH0PR12MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b96f199-d4d6-4650-2361-08db8b4b3d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c3NDZlYblOIxxh0hMXoZoeZBYdJjGXKx5m25Dw3/ZuWyIAjWGgtgHAUU83SM8ctyZ6ScbDUiIuHEK5hVcohJ6m9PoxSD/Dadt7lKKhl3WbGkARalH0rNNjERafRtIu/FShK8KUSHYSMadBTdVc21PrBibjSU+NqqvdJSSz7PplzCtF+zMZhiKhqM3PeCcsfb6s22YQ7CmT571wOaec/66G/0NzmzmrG9LdIgJjuQM4TOvT/wHjzf3i32nQ0nG5ojzO9IhaskKlaLgqLOtknlHQypwJ2dMvePFfbaHSbaLFu3dw6m3w4r7Lfv33ZDHZZzq4q+2rn4WxZZquQnRUt6sNTPjKI1hCZOqmC/3f4YOlSKFoHC34Q8T5IftNjf7xwSZZ/BUP0+tiJVDuGScExkl5guVetCS7n0EQmjSCC+mUz1Q4se2GJkcJoF57moLkGqZW2BoEBx7TGsBM/1xidwf3wPVQn4KtRQn7Xfm9bBrR5VFrSHrEShT4s31gnSX0L1BAs/TFEFLbkJ+2M9Wkj9q8npuVu1uuQNBKuv5c2SZGJ0fOBB9C3u+EIC/Y6y0v2yH6U9Eqt4GfePbBo1TEc9mGtZUd+PlIBMC9ltYLj+O6zfkMhvS7Y1pD3LXPAkjJ6CLWpXNcYF/a3xwbKJ7eipnNVlQ0ZGLDt/YF14+HvBiR/qZLWQ1rZ2yuL3E6aYOvOFa3fEz4ErDitCwBnWo1l0NeX8555HYwGGnF5uto70k1oJrOQ21M2KUGaWNjRp4sLkigGsgzUVUv5hIQhROaGeOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(86362001)(82740400003)(40480700001)(356005)(40460700003)(81166007)(110136005)(478600001)(6636002)(4326008)(41300700001)(316002)(70206006)(70586007)(5660300002)(54906003)(44832011)(8676002)(8936002)(16526019)(6666004)(7696005)(2906002)(26005)(186003)(336012)(1076003)(83380400001)(36756003)(36860700001)(66574015)(47076005)(426003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 07:05:46.9988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b96f199-d4d6-4650-2361-08db8b4b3d62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7469
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following:

WARNING: min() should probably be min_t(size_t, size, sizeof(ip))
+               ret = copy_to_user(out, &ip, min((size_t)size, sizeof(ip)));

And other style fixes:

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
WARNING: Missing a blank line after declarations

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 12f3c7ad7d04..631c5ab3f7dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -557,6 +557,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			crtc = (struct drm_crtc *)minfo->crtcs[i];
 			if (crtc && crtc->base.id == info->mode_crtc.id) {
 				struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
+
 				ui32 = amdgpu_crtc->crtc_id;
 				found = 1;
 				break;
@@ -575,7 +576,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		if (ret)
 			return ret;
 
-		ret = copy_to_user(out, &ip, min((size_t)size, sizeof(ip)));
+		ret = copy_to_user(out, &ip, min_t(size_t, size, sizeof(ip)));
 		return ret ? -EFAULT : 0;
 	}
 	case AMDGPU_INFO_HW_IP_COUNT: {
@@ -721,17 +722,18 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 				    ? -EFAULT : 0;
 	}
 	case AMDGPU_INFO_READ_MMR_REG: {
-		unsigned n, alloc_size;
+		unsigned int n, alloc_size;
 		uint32_t *regs;
-		unsigned se_num = (info->read_mmr_reg.instance >>
+		unsigned int se_num = (info->read_mmr_reg.instance >>
 				   AMDGPU_INFO_MMR_SE_INDEX_SHIFT) &
 				  AMDGPU_INFO_MMR_SE_INDEX_MASK;
-		unsigned sh_num = (info->read_mmr_reg.instance >>
+		unsigned int sh_num = (info->read_mmr_reg.instance >>
 				   AMDGPU_INFO_MMR_SH_INDEX_SHIFT) &
 				  AMDGPU_INFO_MMR_SH_INDEX_MASK;
 
 		/* set full masks if the userspace set all bits
-		 * in the bitfields */
+		 * in the bitfields
+		 */
 		if (se_num == AMDGPU_INFO_MMR_SE_INDEX_MASK)
 			se_num = 0xffffffff;
 		else if (se_num >= AMDGPU_GFX_MAX_SE)
@@ -896,7 +898,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		return ret;
 	}
 	case AMDGPU_INFO_VCE_CLOCK_TABLE: {
-		unsigned i;
+		unsigned int i;
 		struct drm_amdgpu_info_vce_clock_table vce_clk_table = {};
 		struct amd_vce_state *vce_state;
 
-- 
2.25.1

