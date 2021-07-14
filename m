Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A482FC11F66
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 15:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70C47610A7
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 15:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C47610A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E96F6E417;
	Wed, 14 Jul 2021 15:25:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DE1E6E413
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 15:25:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obEgJO43hln/zKvl064fIMhAqk5qZNfCuxLADt1C0QPS6mxY9SSH3aahHFswY8CVHKNGM0bK3fjUeLl+cM4X3oeFuTnExQFbsnH+zmWYTunUgNQ2S1BO+Q/gin0W6hFntBg/uWIWfQz9kHLLnJJ7gWZ6ueIj8MoT9NFUqZwbnf0Q95vPs4pXNW94pLYcN88GiqG3MHqjDM/pElvDvVmSNvQfya72d/MZiZidEnnsMHiUHkdtsWLCJXF0HiP0tOiyliOqKnzpJBQaca1VOsDX0EHkQdfubQFIq4YTtG1Wzt0GcO/z00PhhA8QyOdLbtzeXblvES42bpUPFJxvtF9rdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkXAwOJj+mIlFi0mQvFOs4aHsTFQVGQ3edN6QRX4uN0=;
 b=JopmdOhbQHSa3oKx2WxX3pCc/AzBusGL7hHv/tdRM41NDUxpcC5OzivgLG3EToJfQDtJUuhTfSsyliJkTSsth3eBvx0xHDazRaBh9JWPfV68vCC3CT+EnMvkX6+NyMRjp2luODO8H1NWWaQ2RfTVtcjj4nxf+9oZzs+C2qdMy10FAe5I4XDxiyhnlVJvBE1fvDU6OiyFKPd1TddWYQYastzvFGia/gnGEJBN15oqXx0bleOnCkdB6CXJmR24+hswuy8Cb5g74wmSvZqDStmiCdunaU9yE0zeRE5EwWXW5y0CLYgUQ/3AgSNE+/9AMrLzHuN6ZseIFB9d3hiZk0QmTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkXAwOJj+mIlFi0mQvFOs4aHsTFQVGQ3edN6QRX4uN0=;
 b=d8DGNpr8rfSI+w5EgnNM462Dj0SIFngkcnkk3Ar9KgXbz8DaG7Trds3UW2uqZPa7qYJZewS+D6dxMvErIH3UyzReS0jsvNIQ9lgPY7Vrl3hHTGGjQR8vucT4NrhwDPKUubMNA6w0qM0SWdF8bnD1ocWOo0TEtxgjAKAAs2u82mo=
Received: from DM5PR16CA0023.namprd16.prod.outlook.com (2603:10b6:3:c0::33) by
 MWHPR12MB1744.namprd12.prod.outlook.com (2603:10b6:300:111::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 14 Jul
 2021 15:25:55 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::72) by DM5PR16CA0023.outlook.office365.com
 (2603:10b6:3:c0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Wed, 14 Jul 2021 15:25:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 15:25:54 +0000
Received: from ozeng-develop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 14 Jul
 2021 10:25:51 -0500
From: Oak Zeng <Oak.Zeng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: Change a few function names
Date: Wed, 14 Jul 2021 10:25:43 -0500
Message-ID: <1626276343-3552-4-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626276343-3552-1-git-send-email-Oak.Zeng@amd.com>
References: <1626276343-3552-1-git-send-email-Oak.Zeng@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 019aaaf0-5b8b-4363-8e36-08d946dbac33
X-MS-TrafficTypeDiagnostic: MWHPR12MB1744:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1744439050764A6F27AFC7C880139@MWHPR12MB1744.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PmlpQnUN/iuUYa1SkRdxmkcj/WkrPJOJc7otU27HM6Gv44T0cgLl5xicbifDfMtxftWPCJI4kTfXO77u3RQq3liAOG7WeERKbxLKRQ0YKE4+7Lzh13mHmC2/ep2jSd2bOYPUCriHJ3Ee4VH9zYYp4NVB6bSTYuu4krCJyVf3nfBgLntr3BHJZXk1nFpbeYJeGvQ0WXj4L/1yKIYHt79cmoq988nRBuda40kuaO79u21aGK9QwyT4BzYzBt1OAnAZI2nvpQFnW67jV/o1msc5hkblRmWwyo4RuLekiM7hScrSEE6qVBZU8diHTficMOzOAi6WEZk01b20e8HtebcCrmT8tbrg5QHbHYPPGcML91E0DSzzW5r2VKoaz3hyoynRWiwk292b0ojn/Pm11eYm3U3WT6zT2CHvrUTto3+co+kTiuiU+gm3MMiJeXZvZ8EFGkty0JiXmcoepFi0clgyAiGyNR+6K62UJ6a2Km0ZY7tfgVfS9S1Dhrea8qpmbZDXuWAsWLbP2HJzKT4WtY3QiYhvNpX0PIi79xxw4HzsDQEjZyPDQ08ZAEXfUjMEUb0N949332OSPQokrrSTaOil+PMNcxqJtNJNdmzbTiZzLpuoS+nh8FxDCFoFwQ6yeXKykjrRmXCBl4n+dIBOxcG3h4Gst0YE/1WQ99pB5akOnRcT9VkdcVjLgFOJ/AbUZQ5qXXMymlVfUMY0Snq6nFFv8Hm/R5O+BrKmaWI2LOOnef4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(36840700001)(46966006)(26005)(81166007)(5660300002)(316002)(54906003)(86362001)(82740400003)(356005)(186003)(70586007)(2616005)(16526019)(47076005)(336012)(70206006)(7696005)(426003)(82310400003)(8676002)(83380400001)(6916009)(6666004)(36860700001)(478600001)(8936002)(36756003)(2906002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 15:25:54.9438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 019aaaf0-5b8b-4363-8e36-08d946dbac33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1744
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
Cc: feifei.xu@amd.com, Felix.Kuehling@amd.com, leo.liu@amd.com,
 Oak Zeng <Oak.Zeng@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Function name "psp_np_fw_load" is not proper as people don't
know _np_fw_ means "non psp firmware". Change the function
name to psp_load_non_psp_fw for better understanding. Same
thing for function psp_execute_np_fw_load.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index d9ddb2c..8d1e2b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2351,7 +2351,7 @@ static int psp_prep_load_ip_fw_cmd_buf(struct amdgpu_firmware_info *ucode,
 	return ret;
 }
 
-static int psp_execute_np_fw_load(struct psp_context *psp,
+static int psp_execute_non_psp_fw_load(struct psp_context *psp,
 			          struct amdgpu_firmware_info *ucode)
 {
 	int ret = 0;
@@ -2387,7 +2387,7 @@ static int psp_load_smu_fw(struct psp_context *psp)
 		}
 	}
 
-	ret = psp_execute_np_fw_load(psp, ucode);
+	ret = psp_execute_non_psp_fw_load(psp, ucode);
 
 	if (ret)
 		DRM_ERROR("PSP load smu failed!\n");
@@ -2442,14 +2442,14 @@ int psp_load_fw_list(struct psp_context *psp,
 	for (i = 0; i < ucode_count; ++i) {
 		ucode = ucode_list[i];
 		psp_print_fw_hdr(psp, ucode);
-		ret = psp_execute_np_fw_load(psp, ucode);
+		ret = psp_execute_non_psp_fw_load(psp, ucode);
 		if (ret)
 			return ret;
 	}
 	return ret;
 }
 
-static int psp_np_fw_load(struct psp_context *psp)
+static int psp_load_non_psp_fw(struct psp_context *psp)
 {
 	int i, ret;
 	struct amdgpu_firmware_info *ucode;
@@ -2488,7 +2488,7 @@ static int psp_np_fw_load(struct psp_context *psp)
 
 		psp_print_fw_hdr(psp, ucode);
 
-		ret = psp_execute_np_fw_load(psp, ucode);
+		ret = psp_execute_non_psp_fw_load(psp, ucode);
 		if (ret)
 			return ret;
 
@@ -2565,7 +2565,7 @@ static int psp_load_fw(struct amdgpu_device *adev)
 	if (ret)
 		goto failed;
 
-	ret = psp_np_fw_load(psp);
+	ret = psp_load_non_psp_fw(psp);
 	if (ret)
 		goto failed;
 
@@ -2765,7 +2765,7 @@ static int psp_resume(void *handle)
 	if (ret)
 		goto failed;
 
-	ret = psp_np_fw_load(psp);
+	ret = psp_load_non_psp_fw(psp);
 	if (ret)
 		goto failed;
 
@@ -2863,7 +2863,7 @@ int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
 	ucode.mc_addr = cmd_gpu_addr;
 	ucode.ucode_size = cmd_size;
 
-	return psp_execute_np_fw_load(&adev->psp, &ucode);
+	return psp_execute_non_psp_fw_load(&adev->psp, &ucode);
 }
 
 int psp_ring_cmd_submit(struct psp_context *psp,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
