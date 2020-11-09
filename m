Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AD7C2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 08:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EF022084C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 08:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CM4gwEJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF022084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93CCC894E3;
	Mon,  9 Nov 2020 08:17:25 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700040.outbound.protection.outlook.com [40.107.70.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9ECE894E3
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 08:17:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lB6kTP6Sv6dRO/kmsZuNIliF4gqI5Uo0LQ3p5kllPH6QRveXes91B+k8iLbuhnoDn4grNJajUSr3G+1xdIa9vKvB7YjqwQRIi0lvTb8xaqQ5E4nF15ifPmmncBDRGoLbf/MrtkQbEjuqsl90SqFR66lE+Uj0k60NFOrEATuwmDfbnizvlyjZIdwO+V9vgafVygv5KWQ1+CyUWl+XE2xk6dR3ie5oXNoQoQEHaZSo0/QzVzwGBFhAjhr5aCx5d1YJ3Iu1J7iiY45iGyxgY9gqLg5iEGoB4wY4Fk/vlfS13I+rHRt9sAnpctnuAIzgzzai7SzTClPPwaB352o9dQrgHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CCZbVhvvT2/NEbEg3ic5XgR6PfOXMLnS4afohcC6aY=;
 b=lep7SaVkc5kkYRjhCwMzdp7MEp94seLJBJrvLg87H7SO2qeV2BqgMXCvxJCCvI6ajQvekOhhba063+tjd9pSeVIWDIGrLgWUfhFHik0Q8C5j1+WKsFO4GNuj47IBKKr04YousDFWlMQqo3mJitHhzhizDNSdyd4tPW+tMBG9LGBfGTRvVuhvFBqCCNF5ztvL2UtC/Mt1Ax4+GiwL5o06GoIycxfk9Z642r7KmOAVccl0d20JFOqSal1ncCSRAEXwzBQrCmXytuQvLxbChZ6tzvr0iBIfxvQZKJLGFNE+CJtTKG9RJBx1p08+cjJ/hIIhfD6BYYBWZI6gSj1Z09z7og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CCZbVhvvT2/NEbEg3ic5XgR6PfOXMLnS4afohcC6aY=;
 b=CM4gwEJZ9TtC9JD6t0JMw1dGAgUdOL4boPWt1HP+ZptD9EUoh6ZH6oxER5Jr1xqIUaXw0P7APvfkNgY3xFZ1MuPxZzVIopCXK+DMet2bPnWa48mjI7H4mt5y75M17p+485Ppxa7R3rE06BFCK1ABejekOM8LprJA5JhpUyOqxRA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3274.namprd12.prod.outlook.com (2603:10b6:5:182::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.24; Mon, 9 Nov 2020 08:17:21 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%8]) with mapi id 15.20.3541.022; Mon, 9 Nov 2020
 08:17:21 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] drm/amdgpu: switch to use smuio callbacks for AI family
Date: Mon,  9 Nov 2020 16:16:51 +0800
Message-Id: <20201109081652.1964-4-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201109081652.1964-1-Hawking.Zhang@amd.com>
References: <20201109081652.1964-1-Hawking.Zhang@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:202:16::13) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-System-Product-Master.amd.com (58.247.170.242) by
 HK2PR02CA0129.apcprd02.prod.outlook.com (2603:1096:202:16::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 08:17:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4c84696b-86e7-4635-54ed-08d88487e1b4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3274:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB32749CCAFDC73A170825F8BFFCEA0@DM6PR12MB3274.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nodx5xZ8waFMAVw8UEzfZOxwqX4gHX8SljIqK+f/QTE9VqDbXoK+eqqyFfyvYxd/hLcU8q3BOPbvFhYD3cSY9j82oI7sNF1MO+TtwdPDlgrZng9GwbGp1HeFzTKtknCPB4d+QtVl13iFRGYPwxHEFLPy3M9yOPTsM7IkNJjivqseeXxbNBYv8Yq/QbdOGhIWt27A+eprVlbACuwn0hkWSiPvEsTudIQQBUfTGBqliDyxwmUYyQpQ+SacB8rZfhRC8NEg06j/M3vzC+SB6bcRjCAyQjKYCh6FYSY7aKgS/oJx1nOHLvA4OX9D2vVC2+14jaS6m7HXIJZU1SBWwcqzRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(66476007)(66556008)(316002)(66946007)(6916009)(5660300002)(8676002)(8936002)(4326008)(1076003)(26005)(2906002)(86362001)(83380400001)(6486002)(2616005)(478600001)(956004)(186003)(16526019)(52116002)(6666004)(36756003)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4QyNWUtlKE/8pcZfJ3ZhDw9wTFuqRjP1rt9EpUWzUwiW7bs2nF7L1W5fqdc0tm+pAqa0zHEkX1bTM+A0Xqv93Cr2ADBh/ZqW7jSAZeTViakUKnGJS5zzwkic95D/KnLI/FpNwxmGfyQLQ7l8UJERu4tcz8ea/BODDhWVh+UwDntSOSyp677CSKC/Db9kzDr1JtUuCTvr630L+xvgM8g32MGne83wwuKmiXnYIAudmohGiPHxMhlF4hzcVeenANdMBFD/Tggji6k3L9RkPP7TnilX/HyAxyf1wK4yIOU65zkJZL8md01ywof2shw6/d6HjiuYXwkDFQjKLorjtmSKtC0OmYqxobJLR9NGvPC56aRxq55U9bS+/MQ7Au/w5hSuJmUOkrx8NZDUIQRBbCoV20Ja/kzGidanCu+V/Ol7iuUZzspkcW6/UYbXSSTWKFyROpQq74DVLycD+uLVjLKDns+8UuOGeYfM4PLj4YoRqu2bzR4AueXvSQO3fKJaSMNeS5BCgB8cJC/lYCtp78W7jJo3rky5wSK8H9dzvsBh9yOZ2laLkQ8oO9fIdbO5Uj/NqpuwStjbDa4NmiiRrm9Bulrp+4E9MvHt8ETbHp9HKUFklADToICGoEWVOclupH5XQH96W2piunLAC0URv+bt6g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c84696b-86e7-4635-54ed-08d88487e1b4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 08:17:21.6641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P61YXtR96MVZiWGc3fknE04izrh9L0G+M0Yq7OcIYAQF8rJrB5zFKfhfQ+RFzcfvmrp7ESO6vlSO4CtPX3JnhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3274
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Switch to smuio callbacks: use smuio v9_0 callbacks
for Vega10/12, smuio v11_0 callbacks for Vega20/Arcturus.
APUs don't support enable/disable rom clock gating and
also don't support read bios from rom. So APU flag check
is needed in clock gating callbacks and asic funciton
for read bios from rom to prevent access unknown offset
on APU.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 57 ++++++++++----------------------------
 1 file changed, 14 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 5b79ce9..7d3788c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -42,8 +42,6 @@
 #include "sdma1/sdma1_4_0_offset.h"
 #include "hdp/hdp_4_0_offset.h"
 #include "hdp/hdp_4_0_sh_mask.h"
-#include "smuio/smuio_9_0_offset.h"
-#include "smuio/smuio_9_0_sh_mask.h"
 #include "nbio/nbio_7_0_default.h"
 #include "nbio/nbio_7_0_offset.h"
 #include "nbio/nbio_7_0_sh_mask.h"
@@ -71,6 +69,8 @@
 #include "jpeg_v2_0.h"
 #include "vcn_v2_5.h"
 #include "jpeg_v2_5.h"
+#include "smuio_v9_0.h"
+#include "smuio_v11_0.h"
 #include "dce_virtual.h"
 #include "mxgpu_ai.h"
 #include "amdgpu_smu.h"
@@ -91,12 +91,6 @@
 #define HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK		0x00020000L
 #define mmHDP_MEM_POWER_CTRL_BASE_IDX	0
 
-/* for Vega20/arcturus regiter offset change */
-#define	mmROM_INDEX_VG20				0x00e4
-#define	mmROM_INDEX_VG20_BASE_IDX			0
-#define	mmROM_DATA_VG20					0x00e5
-#define	mmROM_DATA_VG20_BASE_IDX			0
-
 /*
  * Indirect registers accessor
  */
@@ -296,17 +290,10 @@ static bool soc15_read_bios_from_rom(struct amdgpu_device *adev,
 	dw_ptr = (u32 *)bios;
 	length_dw = ALIGN(length_bytes, 4) / 4;
 
-	switch (adev->asic_type) {
-	case CHIP_VEGA20:
-	case CHIP_ARCTURUS:
-		rom_index_offset = SOC15_REG_OFFSET(SMUIO, 0, mmROM_INDEX_VG20);
-		rom_data_offset = SOC15_REG_OFFSET(SMUIO, 0, mmROM_DATA_VG20);
-		break;
-	default:
-		rom_index_offset = SOC15_REG_OFFSET(SMUIO, 0, mmROM_INDEX);
-		rom_data_offset = SOC15_REG_OFFSET(SMUIO, 0, mmROM_DATA);
-		break;
-	}
+	rom_index_offset =
+		adev->smuio.funcs->get_rom_index_offset(adev);
+	rom_data_offset =
+		adev->smuio.funcs->get_rom_data_offset(adev);
 
 	/* set rom index to 0 */
 	WREG32(rom_index_offset, 0);
@@ -718,6 +705,12 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 	else
 		adev->df.funcs = &df_v1_7_funcs;
 
+	if (adev->asic_type == CHIP_VEGA20 ||
+	    adev->asic_type == CHIP_ARCTURUS)
+		adev->smuio.funcs = &smuio_v11_0_funcs;
+	else
+		adev->smuio.funcs = &smuio_v9_0_funcs;
+
 	adev->rev_id = soc15_get_rev_id(adev);
 
 	switch (adev->asic_type) {
@@ -1511,24 +1504,6 @@ static void soc15_update_drm_light_sleep(struct amdgpu_device *adev, bool enable
 		WREG32(SOC15_REG_OFFSET(MP0, 0, mmMP0_MISC_LIGHT_SLEEP_CTRL), data);
 }
 
-static void soc15_update_rom_medium_grain_clock_gating(struct amdgpu_device *adev,
-						       bool enable)
-{
-	uint32_t def, data;
-
-	def = data = RREG32(SOC15_REG_OFFSET(SMUIO, 0, mmCGTT_ROM_CLK_CTRL0));
-
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_ROM_MGCG))
-		data &= ~(CGTT_ROM_CLK_CTRL0__SOFT_OVERRIDE0_MASK |
-			CGTT_ROM_CLK_CTRL0__SOFT_OVERRIDE1_MASK);
-	else
-		data |= CGTT_ROM_CLK_CTRL0__SOFT_OVERRIDE0_MASK |
-			CGTT_ROM_CLK_CTRL0__SOFT_OVERRIDE1_MASK;
-
-	if (def != data)
-		WREG32(SOC15_REG_OFFSET(SMUIO, 0, mmCGTT_ROM_CLK_CTRL0), data);
-}
-
 static int soc15_common_set_clockgating_state(void *handle,
 					    enum amd_clockgating_state state)
 {
@@ -1551,7 +1526,7 @@ static int soc15_common_set_clockgating_state(void *handle,
 				state == AMD_CG_STATE_GATE);
 		soc15_update_drm_light_sleep(adev,
 				state == AMD_CG_STATE_GATE);
-		soc15_update_rom_medium_grain_clock_gating(adev,
+		adev->smuio.funcs->update_rom_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		adev->df.funcs->update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
@@ -1568,8 +1543,6 @@ static int soc15_common_set_clockgating_state(void *handle,
 				state == AMD_CG_STATE_GATE);
 		soc15_update_drm_light_sleep(adev,
 				state == AMD_CG_STATE_GATE);
-		soc15_update_rom_medium_grain_clock_gating(adev,
-				state == AMD_CG_STATE_GATE);
 		break;
 	case CHIP_ARCTURUS:
 		soc15_update_hdp_light_sleep(adev,
@@ -1607,9 +1580,7 @@ static void soc15_common_get_clockgating_state(void *handle, u32 *flags)
 		*flags |= AMD_CG_SUPPORT_DRM_LS;
 
 	/* AMD_CG_SUPPORT_ROM_MGCG */
-	data = RREG32(SOC15_REG_OFFSET(SMUIO, 0, mmCGTT_ROM_CLK_CTRL0));
-	if (!(data & CGTT_ROM_CLK_CTRL0__SOFT_OVERRIDE0_MASK))
-		*flags |= AMD_CG_SUPPORT_ROM_MGCG;
+	adev->smuio.funcs->get_clock_gating_state(adev, flags);
 
 	adev->df.funcs->get_clockgating_state(adev, flags);
 }
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
