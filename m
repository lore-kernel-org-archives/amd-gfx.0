Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51209C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6E2961406
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E2961406
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 817056EE38;
	Fri, 14 May 2021 07:42:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 534BD6EE36
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 07:42:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBBMoRI2Xefton2zKWqrk2PkbURQfUK6qVklesd4Ui21FH8s6X58vjsn67TSoHG0hrWARWOplFBQTQmPdnffS0M5glkqQKpmrXrvoHQ5bhTv4+XZtKvCcUbb3Pp754xv2jVPbHLlP6a7RMxHMtFCilL3YI4h18g1Yt21WDtRxLes51LROwt55b4oCBU/08fvrmOSHihRU0BFMUGlNC1S+KHvXJpL7qaYzNDjSbhHmGn4kE+lB2eT0QjV6ZlRlI3Iy3r4HQya5eMHvSSRzj23xR+t6sd/FjxvPX59IGJwrD9HPNzTvBvQ3qOjZf7JZKfhW4/yIx7Jq8jAjz8TT2Yfjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJV7U3Lraj7WpuAeTkdYzdwCM5FNGcnuUtzmcIGh/Bg=;
 b=AWjyyYrvICgCw3+8otRajyXXqH0yUt+zk4nukP1EM2e+RWmmrBb31qkKhIE0PydWOd75OieXbzlhlljt7Criq4Gp7uyk9ln5ceIP5TqpiPQB2b9Yho5BwmsMpFzvw1F2SB28FrsEu3xtmi3I+z00vm8KFaEReVNgegkRlNUj8U9ZBJQ9c4AoGJasM19aeXtpkssRV2ZsFTPLlYhqiqyyFT2GRMrWhRXv8NgRfPkTmhOwPWdccxn8i/d/z9vRJ7lLgcN1LRmEML5iycLTjhi4KRnXAU6ivfLIAmm324rCwdslM03OulqGyqhT/hOu+Nl0I+wS4sE58WJQ/M3MbIyrZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJV7U3Lraj7WpuAeTkdYzdwCM5FNGcnuUtzmcIGh/Bg=;
 b=NMjylCUcudexL2f6wkjYp9unBCFPOsunslCETASzALbKwbeeBK6z6JkhOMiuTZUlAYMnDGIOGgNBoQ7LNMDgAneQVB2bc2zMBJsH/eW0Z4yj3tBfP1sw1QHhtErMGITjmmF+cl8QQD423r5NMDmcs8G07LlyhwhlV2f2ho+8IYM=
Received: from DM6PR02CA0051.namprd02.prod.outlook.com (2603:10b6:5:177::28)
 by DM6PR12MB3065.namprd12.prod.outlook.com (2603:10b6:5:3c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 14 May
 2021 07:42:43 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::fc) by DM6PR02CA0051.outlook.office365.com
 (2603:10b6:5:177::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 14 May 2021 07:42:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 14 May 2021 07:42:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:42:42 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:42:42 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 14 May 2021 02:42:40 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 
 John Clements <John.Clements@amd.com>
Subject: [PATCH 4/6] drm/amdgpu: switch to cached fw flags for mem training cap
Date: Fri, 14 May 2021 15:42:31 +0800
Message-ID: <1620978153-4564-4-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620978153-4564-1-git-send-email-Hawking.Zhang@amd.com>
References: <1620978153-4564-1-git-send-email-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90fafa98-69ed-4e66-2c25-08d916abdbce
X-MS-TrafficTypeDiagnostic: DM6PR12MB3065:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3065A0DE13EDECDF80A3B388FC509@DM6PR12MB3065.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C5I2+AkOldMQkdWdly2OjW4bhsJG9lMvAIQiNxzIWOa61rS+5bHGhNM0vjXIy5qtzp8VpO/KwoecATc32hKMTi0gsFkdI5sMtlKjQbRZKt3paAGzMxXGHDhaqrj4BBk1naAFo7Q9S2puSPnV3DrfDR6hSnInUU3YEylAgh1FcaYyIx0DZ+4A6AoI2/XyD6BdeizT+DWXmk+o0ZkPSHif/caNlQwrPhhl6tZmXIahtNy2BZXRPU7J3wwwfjMQcp8uzdMIZq/WgKq8qYmnAXgczK9zyqiIS+lu1WkLzRHkuK45hDz4RnJ44naYSXEwkhJLD1ZmCoWkTDJRi66Re8TDfB0fCS5oakpVV/84S33YnLWMAIQIXjBeYv71L9IwUqIIGwve2Sm2eRmTpOdoClxFCUbiVKBa/R3WXd5vO3NNSXOm8xw2PsUW2+ePwuzDmQ5vWsFIjMSUjvVz89NbAlp4xie5GutCHSrMt5Av0Q8iRga/85MH7ZjqOH3BWzPc4IKzdRMo6QDnYGy51O1IRJKcwK5cPSWZGN1rRTHTLBmeQqzBVESQYHdFW89W7vH1ER7JYI4g9veR0qpFPwp8saJkkQOkTUCTuyp/qTISDlO0NXG9K9ncxwIN46SM/nD2oKifVwkXsph8/k72jFVaCP3WQXT3MPyeBvRW4khugUIpw179YCKN7+Mr7usNu4D9LrRr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(46966006)(36840700001)(8936002)(70586007)(36860700001)(47076005)(82310400003)(86362001)(5660300002)(186003)(82740400003)(336012)(81166007)(36756003)(426003)(2906002)(478600001)(6636002)(316002)(2616005)(26005)(70206006)(6666004)(110136005)(83380400001)(7696005)(356005)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 07:42:43.1637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90fafa98-69ed-4e66-2c25-08d916abdbce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3065
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

Check cached firmware_flags to determin whether
two stage mem training is supported or not.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 66 ++++--------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          |  5 +-
 3 files changed, 11 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 9f25db0..cfd009a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -595,67 +595,19 @@ int amdgpu_atomfirmware_get_gfx_info(struct amdgpu_device *adev)
 }
 
 /*
- * Check if VBIOS supports GDDR6 training data save/restore
+ * Helper function to query two stage mem training capability
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Return true if two stage mem training is supported or false if not
  */
-static bool gddr6_mem_train_vbios_support(struct amdgpu_device *adev)
-{
-	uint16_t data_offset;
-	int index;
-
-	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
-					    firmwareinfo);
-	if (amdgpu_atom_parse_data_header(adev->mode_info.atom_context, index, NULL,
-					  NULL, NULL, &data_offset)) {
-		struct atom_firmware_info_v3_1 *firmware_info =
-			(struct atom_firmware_info_v3_1 *)(adev->mode_info.atom_context->bios +
-							   data_offset);
-
-		DRM_DEBUG("atom firmware capability:0x%08x.\n",
-			  le32_to_cpu(firmware_info->firmware_capability));
-
-		if (le32_to_cpu(firmware_info->firmware_capability) &
-		    ATOM_FIRMWARE_CAP_ENABLE_2STAGE_BIST_TRAINING)
-			return true;
-	}
-
-	return false;
-}
-
-int amdgpu_mem_train_support(struct amdgpu_device *adev)
+bool amdgpu_atomfirmware_mem_training_supported(struct amdgpu_device *adev)
 {
-	int ret;
-	uint32_t major, minor, revision, hw_v;
-
-	if (gddr6_mem_train_vbios_support(adev)) {
-		amdgpu_discovery_get_ip_version(adev, MP0_HWID, &major, &minor, &revision);
-		hw_v = HW_REV(major, minor, revision);
-		/*
-		 * treat 0 revision as a special case since register for MP0 and MMHUB is missing
-		 * for some Navi10 A0, preventing driver from discovering the hwip information since
-		 * none of the functions will be initialized, it should not cause any problems
-		 */
-		switch (hw_v) {
-		case HW_REV(11, 0, 0):
-		case HW_REV(11, 0, 5):
-		case HW_REV(11, 0, 7):
-		case HW_REV(11, 0, 11):
-		case HW_REV(11, 0, 12):
-			ret = 1;
-			break;
-		default:
-			DRM_ERROR("memory training vbios supports but psp hw(%08x)"
-				  " doesn't support!\n", hw_v);
-			ret = -1;
-			break;
-		}
-	} else {
-		ret = 0;
-		hw_v = -1;
-	}
+	u32 fw_cap;
 
+	fw_cap = adev->mode_info.firmware_flags;
 
-	DRM_DEBUG("mp0 hw_v %08x, ret:%d.\n", hw_v, ret);
-	return ret;
+	return (fw_cap & ATOM_FIRMWARE_CAP_ENABLE_2STAGE_BIST_TRAINING) ? true : false;
 }
 
 int amdgpu_atomfirmware_get_fw_reserved_fb_size(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
index 5d83729..8be95d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
@@ -36,7 +36,7 @@ int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev);
 int amdgpu_atomfirmware_get_gfx_info(struct amdgpu_device *adev);
 bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev);
 bool amdgpu_atomfirmware_sram_ecc_supported(struct amdgpu_device *adev);
+bool amdgpu_atomfirmware_mem_training_supported(struct amdgpu_device *adev);
 int amdgpu_atomfirmware_get_fw_reserved_fb_size(struct amdgpu_device *adev);
-int amdgpu_mem_train_support(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 7e7d833..8419338 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1583,11 +1583,8 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 	bool mem_train_support = false;
 
 	if (!amdgpu_sriov_vf(adev)) {
-		ret = amdgpu_mem_train_support(adev);
-		if (ret == 1)
+		if (amdgpu_atomfirmware_mem_training_supported(adev))
 			mem_train_support = true;
-		else if (ret == -1)
-			return -EINVAL;
 		else
 			DRM_DEBUG("memory training does not support!\n");
 	}
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
