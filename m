Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57E9C9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 15:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F44410E614;
	Wed, 23 Sep 2026 15:13:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jMD0JsnC";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012068.outbound.protection.outlook.com
 [40.107.200.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBA7710E415
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 15:12:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBDsrgSpU8KuNcfiGLoRbP96YsbCYPjTU1zIdaGvNgyqVSMVnrgqetZK6gGQRY2X9XVXMV3c+KK0azFNGnOaGPwB1D/s9Kg8VlzQSjfXq92+W2gsNl5zfv5/MvzUXp7jprMCbv666t33jsYqCqLD218C+aLmuD6RVsKpPwpEaYtT+VZ9nLMqhd4HAu7dXQ70Dl4gfTNW9mW3H5CZC+MaZt9v6TKlu8Hj1QFJa63iM+n0BAU8jYH4Mm56QOLx4Ui44zbXREnclewUGQM4m/ibbsNeCXPpa+/FrdkcbGteYYAn+HmSstGk/IiKs6vrIjWEbpjKe87ih7zGDxnKNkA4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S96E+LFdeZNQuvPlMwyXl+wsGUZExz3ESP5KCyHYH7E=;
 b=FOjBqYyMit1umb2ktE8nkht5SfW1xbvKKGQ8VYCj0GCVCc504YCIZWNy8j3CKVjFXP+fS2PZEsW9ehbVzXeCifRymo7W95iTxY7XuHca0WBjclc7zfDWKNR7qC9U3xLDYW2UamyJyay7xwnOxqibXbcTJ/rgWFMtN5B2NUI3WEMqGkDylpgLecmATEJxHN61uXHgBBYT5tiX2iIcDzK/04FKatxr5ApnGUgJp7Y7FD8Jcmpo/npTzj+WtkFnY2Cj8y+zcOW1Vr+ui7zyC5KNSLrEbWQGSxe3Tvp+i1mNGyBdowCLUpAPMJhFuy1GswPu4JUH0HO6ifnBC2j1Oqizrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S96E+LFdeZNQuvPlMwyXl+wsGUZExz3ESP5KCyHYH7E=;
 b=jMD0JsnCVwPZ8NqvDIXDWrbBYAVRecVOh/nU9Z6rGAI8yQzUqkeNONsQww6hOJQfMZpw9IhzaexB3zcVq3JL+RnZ5nsO51FaHd2OzBfvgfDM9tx2BaoQoiZ8aCgsrNyzje8qb7E+OIyy3OCG/IguTRu494tVF9ZNkCn0JSE7f3U=
Received: from BY5PR03CA0003.namprd03.prod.outlook.com (2603:10b6:a03:1e0::13)
 by DS5PPF482CFEB7D.namprd12.prod.outlook.com (2603:10b6:f:fc00::64a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 15:12:50 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::5) by BY5PR03CA0003.outlook.office365.com
 (2603:10b6:a03:1e0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Wed,
 23 Sep 2026 15:12:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:12:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:12:41 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:12:41 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 10:12:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lin Cao <lincao12@amd.com>, Yifan Zha <Yifan.Zha@amd.com>, Frank Min
 <Frank.Min@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/12] drm/amdgpu: Add GFX FW list to PSP_15_0_3 under SRIOV
Date: Wed, 23 Sep 2026 11:12:24 -0400
Message-ID: <20260923151226.2778589-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923151226.2778589-1-alexander.deucher@amd.com>
References: <20260923151226.2778589-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|DS5PPF482CFEB7D:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe3a696-c5fe-4aa8-d76f-08df19852216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fExiM45tyByaWalxY7QOZ8mBcuEs/Ba3LiTNKKD4768QGBwaeKgUWy1vTK0J/pa+18MXi1nwV6WwSfrDGSvstILAb4AJmSv+EPcm6cVEll25b+JHdgI4rnHpOZDuQk1nn6ucy+SJ6oNHCw6A5mSWY54QRTcp8rNU7K32CPvlxtUuXAXOV6ZusysPdOd7W3YWM+1cqAzWXvkhJF9VhaKKIsxz6GBZJrsdMoqRydAsXs6085gz3Nt/GmXJrpGDR5rULtZMYmu4NYAaqm5i2eFtMCW5/cm8gDtmqzaNFo2T06AX2tLNGQJqyiEX9sMsS55PAG4ddY1NJ7FBE48MtuRthroBqznuvcYh+WFdgMwNZQWNBvLVLYEedmS0/ufbUTp2BSYj2qyVw0iBIItneCd033I8CvWt/odNfOR8vvZVitZMknS1gQ/bPjmYnETcZmIwEq18TXxSk+uSut0RQ+k7PwN6curvJMJffPV+M2bfnGWzCKrRlxdCsjk7ydbG3RWTMMlA24TSlrMBcsoIa7S5qxx/tvPp3tBVItJLAKVTYNMA2TkxTvPsx4JplQ2XIAcRb75LpSjejpPO7/jm/pS5GMC6md0GW0jFz9iY32XHmK/PRz4siKK/Fy7Fe5o3QdASAvnxm0YQUNhMJMwKSc1ueLoKeFQ21Uah9JyXwh6SFP0P13ganjI1ZEm9e6AQrfjmMTCGyqTAiEH7CSqLDx24rw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C31XAOFtgswnYNUn2ZaW9LX2hWUoeqV6y2zyGUTV8YK3sqTwNZhPfPLNSYpBErg6v5lU0x0ia8Ppd6WhUwu6LIBY7f7PSBNaNob4SzS8KBBYh5EMU+uWpzgD77NDCavUSJReXpOSWySx83uCPYNyqJmVIU9VwXQqik0BvTExu3svLxOpyJpJKCs/j/1dJYeaCU728xA4+SIYLR8iFCnYy4atZvFerad4zpQPviIHd8s1VIkg8iTT9PXNfz6rvhjxp6Dy60HtUpBVek97EsL/gdfAUddnRN3r+JXuTR5mjp3ZL1eSS1nugS0sWUIprHgPHqgKKMK6DQ0wKdhpNEpL+8UPEkjzP52yfbgLHWMsERcktViVo/jcfCtt42yeHPiLDJYb+2RQsF12mJeQuEZWo0m3ojfA263FgQgCUkozZMzw77Oxl03uSfHkBRyNCofi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:12:50.1903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe3a696-c5fe-4aa8-d76f-08df19852216
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF482CFEB7D
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lin Cao <lincao12@amd.com>

[Why]
Under SRIOV VF, GFX firmware are required to loaded.

[How]
Add GFX FW list.
FW contains:
PFP ucode, PFP data P0-P1
ME ucode, ME data P0-P1
MEC ucode, MEC data P0-P7
MES SCH ucode and data
MES KIQ ucode and data

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
Signed-off-by: Lin Cao <lincao12@amd.com>
Reviewed-by: Frank Min<Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 56116bcd0a3a8..ba36260b41b69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -174,6 +174,9 @@ static int psp_init_sriov_microcode(struct psp_context *psp)
 	case IP_VERSION(13, 0, 12):
 		ret = psp_init_ta_microcode(psp, ucode_prefix);
 		break;
+	case IP_VERSION(15, 0, 3):
+		adev->virt.autoload_ucode_id = AMDGPU_UCODE_ID_CP_MES1_DATA;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -4010,6 +4013,8 @@ static int psp_load_non_psp_fw(struct psp_context *psp)
 			     IP_VERSION(11, 0, 12) ||
 		     amdgpu_ip_version(adev, MP0_HWIP, 0) ==
 			     IP_VERSION(15, 0, 0) ||
+			amdgpu_ip_version(adev, MP0_HWIP, 0) ==
+				 IP_VERSION(15, 0, 3) ||
 		     amdgpu_ip_version(adev, MP0_HWIP, 0) ==
 			     IP_VERSION(15, 0, 5) ||
 		     amdgpu_ip_version(adev, MP0_HWIP, 0) ==
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 681a9904a79e5..8b08297e4a8a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1369,6 +1369,29 @@ bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev, uint32_t ucode_i
 			return false;
 		else
 			return true;
+	case IP_VERSION(15, 0, 3):
+		if (ucode_id == AMDGPU_UCODE_ID_CP_RS64_PFP
+			|| ucode_id == AMDGPU_UCODE_ID_CP_RS64_ME
+			|| ucode_id == AMDGPU_UCODE_ID_CP_RS64_MEC
+			|| ucode_id == AMDGPU_UCODE_ID_CP_RS64_PFP_P0_STACK
+			|| ucode_id == AMDGPU_UCODE_ID_CP_RS64_PFP_P1_STACK
+			|| ucode_id == AMDGPU_UCODE_ID_CP_RS64_ME_P0_STACK
+			|| ucode_id == AMDGPU_UCODE_ID_CP_RS64_ME_P1_STACK
+			|| ucode_id == AMDGPU_UCODE_ID_CP_RS64_MEC_P0_STACK
+			|| ucode_id == AMDGPU_UCODE_ID_CP_RS64_MEC_P1_STACK
+			|| ucode_id == AMDGPU_UCODE_ID_CP_RS64_MEC_P2_STACK
+			|| ucode_id == AMDGPU_UCODE_ID_CP_RS64_MEC_P3_STACK
+			|| ucode_id == AMDGPU_UCODE_ID_CP_RS64_MEC_P4_STACK
+			|| ucode_id == AMDGPU_UCODE_ID_CP_RS64_MEC_P5_STACK
+			|| ucode_id == AMDGPU_UCODE_ID_CP_RS64_MEC_P6_STACK
+			|| ucode_id == AMDGPU_UCODE_ID_CP_RS64_MEC_P7_STACK
+			|| ucode_id == AMDGPU_UCODE_ID_CP_MES
+			|| ucode_id == AMDGPU_UCODE_ID_CP_MES_DATA
+			|| ucode_id == AMDGPU_UCODE_ID_CP_MES1
+			|| ucode_id == AMDGPU_UCODE_ID_CP_MES1_DATA)
+			return false;
+		else
+			return true;
 	default:
 		/* lagacy black list */
 		if (ucode_id == AMDGPU_UCODE_ID_SDMA0
-- 
2.55.0

