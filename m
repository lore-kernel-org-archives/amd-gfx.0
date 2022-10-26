Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3E2C38A02
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 00:50:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFEBD10E1EC;
	Wed, 26 Oct 2022 00:50:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EA4910E1EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 00:50:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTwhe/HZ3lZbUgUAqufwmSJfysI/2GPihZh+55lhaz9Ul+WllorSUI4putTE+KqqowjF1WbMenE+ugwYF6IgljWbwOJ+i4Kd+H5GCDJu9EdWkMU47lUGuIFzNiZnxkkyLAQs6EAah4UMC7b9ALPJre9RAt1yWU5hvY1RRyz6d9YCe3EIoPcggHtZmqZRUaURy98hW9BopBEODmL8tLWb9KA6OBsfgJpeY942Z9pe6QbrdCC4nWdJ88lkQgcXQobLRqWVZFXvygOPDlDwklYRIvKiSd11Fp9zx3U0gWRQhPYNy01/bgEaQyikLIF+0BEPEJFKmD4ZcPBBX000nrfJVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rloyoEIYHEnqRzhGVEpIRlYZw3eoKyfTizG8/yvGww4=;
 b=KPtinxAMACMWhnJ5P/vloP4bxwc7gqDWtx1X6kTwWBzT/pgsL99jgC/vc3DbyJEgTlrh0u2wM8zdJyDJ6uOc5uEA/W0Sb7WWnfmzJK0ItlapglILcxkij/rULYmAdI+jKX2Vkbpibh+/u/UioSsqdpq1e6fayON6m6CNR/gFRI1y/2fEvTv2f72kSFEecsKcQj242wCYbh74bhLjhRN6JecLd7hxIIgO7vyz3GcVVRE3npAojAUs+/ACWDDQancea4B7hDwChokqgTTp8ynw0pCxAqN7+MMNJ8SyAv1DX6RssGKccU6dZCOIVxoYana81HsNQi8lLPytdhHQr9Bs5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rloyoEIYHEnqRzhGVEpIRlYZw3eoKyfTizG8/yvGww4=;
 b=4HCHxV+KdoQa4L+pr6wfsR8jjJBXtHqiIMD5XTj/93UETjPatSLehsOsN0rDxjSnuN2l9ii7C/+/lvzpyDR6kmeMtcMAllF4wK78aegjxBrPy/3XF6WXhvhOLzXt8mAEMg1OTwGfsd9jOFcuexgG79MCxnbTNLoI0qPifv+05nI=
Received: from MW4PR04CA0261.namprd04.prod.outlook.com (2603:10b6:303:88::26)
 by PH0PR12MB7093.namprd12.prod.outlook.com (2603:10b6:510:21d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 00:50:09 +0000
Received: from CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::bf) by MW4PR04CA0261.outlook.office365.com
 (2603:10b6:303:88::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Wed, 26 Oct 2022 00:50:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT106.mail.protection.outlook.com (10.13.175.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Wed, 26 Oct 2022 00:50:08 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 19:50:06 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Optimize RAS TA initialzation and TA unload
 funcs
Date: Wed, 26 Oct 2022 08:49:54 +0800
Message-ID: <20221026004954.26131-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT106:EE_|PH0PR12MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb36087-5071-41a9-8cf9-08dab6ec080d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C68AjoVoId2s7BcuYwf94y2Rmz06Ts/BqgD3j0ff0YbKwuviKMgVVIIom9X0QTFaGCfyAQXy0mOrEGxPRO13Hp2+N2Dko4/f0E5tZL6+OaWYYeWKPWp3MyYc539NBtq0oSCGob6hs5F25CwFTlSC9YJmV0jN1Oeb9I/uKNeg8atjhw/WI9Yu2Yqej+GO8UriKqZxTR04pzc29qnhcvUCNlTPg7Cp3ZCEb9v7JP9uUoxXtNmOZNpMAOvOCOO4fzAFEOr4DaEmx2exkvRmnc9EN9f0PrbM1FkwPAGWkEfwNk/FpJF3+JQDaNSgwK5RHKQXOez2vgaRG7JQhgtaSCy3ROslnR+2rdvMd38jFJ+t+Z/zLayXCbghrHDQ2wAt0BY7KnqS13vMcSk83veIKxySEJH22Kks6QXtXI96JlfRoXVhvpq0anFcK4uHOPH0m6M28GeuopTXJs0yqevhOtZKFAdmVb2/FiD5MfehSD1liL3XdTmceZzdIEiu165txIIM5rT93WJUllECGqn7Wiqy++CQF+4YAp+xrHwQNhOmzz6jjIRTC+yxFMnB0C7V2h95oNfW2n7R9MpS82Aw+cx9n8vM4oSd+1lZO/5HmHHavCnNDGmVhwJF+Pdw08CIY3l83tzGaDa9IqnEeOd7YJ/J9yjDji+/UkcqIyRESAOeLTejjpO7hElw1/f+t0ejW98CRzauY93rzJhgtzrvRS6kgSThMoWuOOafIDklkTxbb0OHg2HwVjF0VT1FwDgnrfWM/XTySeGqnouOK8YDyA/R0t67QRj62PtNvs1AWfzmYqxUYPrh1F3o54N3wYS8ln+O
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(36756003)(82740400003)(70586007)(186003)(426003)(83380400001)(16526019)(4326008)(70206006)(2906002)(8676002)(8936002)(5660300002)(6916009)(41300700001)(86362001)(316002)(40480700001)(2616005)(7696005)(44832011)(81166007)(26005)(40460700003)(356005)(47076005)(336012)(6666004)(36860700001)(478600001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 00:50:08.8426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb36087-5071-41a9-8cf9-08dab6ec080d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7093
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. Save TA unload psp response status
2. Add RAS TA loading status check for initialzaiton
3. Drop RAS context teardown to allow RAS TA to be reloaded

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index effa7df3ddbfa4..643810c4148120 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -988,6 +988,8 @@ int psp_ta_unload(struct psp_context *psp, struct ta_context *context)
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
 
+	context->resp_status = cmd->resp.status;
+
 	release_psp_cmd_buf(psp);
 
 	return ret;
@@ -1560,6 +1562,11 @@ static int psp_ras_initialize(struct psp_context *psp)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
+	if (psp->ras_context.context.initialized) {
+		dev_warn(adev->dev, "RAS WARN: TA has already been loaded\n");
+		return 0;
+	}
+
 	if (!adev->psp.ras_context.context.bin_desc.size_bytes ||
 	    !adev->psp.ras_context.context.bin_desc.start_addr) {
 		dev_info(adev->dev, "RAS: optional ras ta ucode is not available\n");
@@ -1610,7 +1617,7 @@ static int psp_ras_initialize(struct psp_context *psp)
 	psp->ras_context.context.mem_context.shared_mem_size = PSP_RAS_SHARED_MEM_SIZE;
 	psp->ras_context.context.ta_load_type = GFX_CMD_ID_LOAD_TA;
 
-	if (!psp->ras_context.context.initialized) {
+	if (!psp->ras_context.context.mem_context.shared_buf) {
 		ret = psp_ta_init_shared_buf(psp, &psp->ras_context.context.mem_context);
 		if (ret)
 			return ret;
@@ -1631,7 +1638,6 @@ static int psp_ras_initialize(struct psp_context *psp)
 	else {
 		if (ras_cmd->ras_status)
 			dev_warn(psp->adev->dev, "RAS Init Status: 0x%X\n", ras_cmd->ras_status);
-		amdgpu_ras_fini(psp->adev);
 	}
 
 	return ret;
-- 
2.17.1

