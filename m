Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F880C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 06:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 545B660E9B
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 06:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 545B660E9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C496E6EDEB;
	Fri, 24 Sep 2021 06:32:03 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2066.outbound.protection.outlook.com [40.107.102.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24D906EDEB
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 06:32:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYAO0+K+TFUIqq7uMThG1jXn2dGNvoqKAqjSSFU8wG05+HcJ6x6dLveV3EVqXm0gPkp4F9YmzeqBh3LJqk31r+ZW3ElvuLUcpwYyu+pyDd1ft7vFO1E9gR7N70LyuiCfEqpG2dt2zuYCDZ8KLkq1esgg1lRvis5jcp1mUAuyAVI2evbbfBGB9ec/OVCfljoy88XNgJn+kcGqJGoKKhBEe68oDD+kf4tjV41C2LQ01ZYxnsd0p2e4ixR3G8mENz6sZ51iUEY+W4Tq+eThrrclR+dyBb+ob+w+GHoEyIryYUHIXsbRqsScXDu0uCdpEWFVkKZctm7L0wHTjtaLHLOQSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=oWY7LX8xoXcs2ippWqJgKLN0nQuC4nHurv5qexSY+oI=;
 b=cS6gjkbRgh2ucrsxm3G5zjbEy75rgaPGv+0D7dKJiZWQMaAYGRnm/ZUCx/710zybSPYNdmFvqA6qG3xgvDrxBIlEF6oj0UxMleMofHsjc3JRcLFYqRzlMNiHb2S9fPpep/Nyvpv/jp3SL+iLkbIXvHFGJ9oLYQFXm3tJ+WYuCbfncrb/2masIGcxT9II0Ga7QFxvZpJU7zS5AQtK95gd6MRdc45b9aheoGarzzqsxKIi9y57pwfTGW5+TC1RvKYWA3K0XNPc1vqhQf/SFIP8a3dE+zBVSY/gjll6vBrLfAw9A58LkrnYt3p6ptzrD4Y4lpJWGJyUtVl6wX3Rx9BkYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWY7LX8xoXcs2ippWqJgKLN0nQuC4nHurv5qexSY+oI=;
 b=pjvqNJgzyECQnwks/uld6PpHWO6HE8e2uX9puz8NtyfV5ci6NuYcuNK1ihmzHyCR32ECDCtq/VK19mAJnEqKJLEU9geKoe6E7xcV6neoyXN3EY59nvcStwVLulyjZuObCLmQ8Jx2XYShJ6UI6qG/iQXTrpdOPng7TpiXtFvcWno=
Received: from MWHPR22CA0045.namprd22.prod.outlook.com (2603:10b6:300:69::31)
 by CH2PR12MB5515.namprd12.prod.outlook.com (2603:10b6:610:34::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Fri, 24 Sep
 2021 06:32:00 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::c) by MWHPR22CA0045.outlook.office365.com
 (2603:10b6:300:69::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Fri, 24 Sep 2021 06:31:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 06:31:59 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 01:31:56 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: John Clements <john.clements@amd.com>, Candice Li <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: Update PSP TA Invoke to use common TA context as
 input
Date: Fri, 24 Sep 2021 14:31:44 +0800
Message-ID: <20210924063144.31230-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c950d528-719b-4bc2-373c-08d97f250331
X-MS-TrafficTypeDiagnostic: CH2PR12MB5515:
X-Microsoft-Antispam-PRVS: <CH2PR12MB5515C758C3AB07A32EBB8D9591A49@CH2PR12MB5515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:288;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4haxOeO2Xe9aP/gMBkPA22zs5ixO82VdxZyCnfnjPTFfOSVEuvhshbGRC7izGo2xHOn/z57bmmeehqfJYBUIGwbBLrn2XRpwqJNbKejL9Cr3RMyxuFDsWiuwx/oa+KN8fwfqFYL2XMlt4NrMPAPqSv4sYPKyqKi9AirKRBhEZmwaipzxf3CpoJIRs7vVhDleM83aJAW1h8Fb/BCW9EE8VO0a69KUE9XaIoOBdF0LD2IGrFQ9V5fKceVVGm5oHUddjyM+etS7so0E+3KLxte4sIuEk2hjiAOoi5kmCzM8sa+4zsfgOsW2GSiT3jBrTDkfsmAJR9o+oLnlBbeDLKsz1z0sL6/Oq1ItT1meXs3o5sHURdcGWx6T1b64qz3EdgffZ9fM+rnTTzj0fV5G+/xw4LkR3vIqX44A6ID83FCm84BrUTzeNoZNW9hD6MofNLIZXzLTTzj7fJ4fKWvYpATZLiM5aQepaELnWvPNik1Gdn2OAp1dm6qSQYn9vYK7LtjaEwhWwmaGWqKP384RdJ3t9rk9F7rGxx/bMS4R2MIPxMjxuITtVcgm/VRBcZbSR3RCh8gimmZQeBYtplVi6BkK2EIg2JievizL5TdZJ6qK43KuwH5XJ2CLnlDb9Hsbwm6sYTW67iwCNLKdfBJGVp/H1uE0LrVDdcikKtdP6Ej+RnSuzWqv7MRTMDI6zXhL9abIavppuuUw4zGa5aXyZLAGcBWb8mXZw4RytFiNcfg1z0s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(426003)(70206006)(508600001)(54906003)(70586007)(36860700001)(82310400003)(6916009)(5660300002)(26005)(36756003)(16526019)(186003)(1076003)(316002)(2616005)(81166007)(83380400001)(8676002)(2906002)(7696005)(6666004)(8936002)(15650500001)(4326008)(336012)(356005)(44832011)(47076005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 06:31:59.2171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c950d528-719b-4bc2-373c-08d97f250331
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5515
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

Updated invoke to use new common TA structure similarily to load/unload.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 55ffc3da89ced2..17d09771be3ee0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -938,12 +938,12 @@ static void psp_prep_ta_invoke_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 
 static int psp_ta_invoke(struct psp_context *psp,
 		  uint32_t ta_cmd_id,
-		  uint32_t session_id)
+		  struct ta_context *context)
 {
 	int ret;
 	struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
 
-	psp_prep_ta_invoke_cmd_buf(cmd, ta_cmd_id, session_id);
+	psp_prep_ta_invoke_cmd_buf(cmd, ta_cmd_id, context->session_id);
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd,
 				 psp->fence_buf_mc_addr);
@@ -989,7 +989,7 @@ static int psp_xgmi_unload(struct psp_context *psp)
 
 int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 {
-	return psp_ta_invoke(psp, ta_cmd_id, psp->xgmi_context.context.session_id);
+	return psp_ta_invoke(psp, ta_cmd_id, &psp->xgmi_context.context);
 }
 
 int psp_xgmi_terminate(struct psp_context *psp)
@@ -1291,7 +1291,7 @@ int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-	ret = psp_ta_invoke(psp, ta_cmd_id, psp->ras_context.context.session_id);
+	ret = psp_ta_invoke(psp, ta_cmd_id, &psp->ras_context.context);
 
 	if (amdgpu_ras_intr_triggered())
 		return ret;
@@ -1551,7 +1551,7 @@ int psp_hdcp_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-	return psp_ta_invoke(psp, ta_cmd_id, psp->hdcp_context.context.session_id);
+	return psp_ta_invoke(psp, ta_cmd_id, &psp->hdcp_context.context);
 }
 
 static int psp_hdcp_terminate(struct psp_context *psp)
@@ -1643,7 +1643,7 @@ int psp_dtm_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-	return psp_ta_invoke(psp, ta_cmd_id, psp->dtm_context.context.session_id);
+	return psp_ta_invoke(psp, ta_cmd_id, &psp->dtm_context.context);
 }
 
 static int psp_dtm_terminate(struct psp_context *psp)
@@ -1777,7 +1777,7 @@ int psp_rap_invoke(struct psp_context *psp, uint32_t ta_cmd_id, enum ta_rap_stat
 	rap_cmd->cmd_id = ta_cmd_id;
 	rap_cmd->validation_method_id = METHOD_A;
 
-	ret = psp_ta_invoke(psp, rap_cmd->cmd_id, psp->rap_context.context.session_id);
+	ret = psp_ta_invoke(psp, rap_cmd->cmd_id, &psp->rap_context.context);
 	if (ret)
 		goto out_unlock;
 
@@ -1899,7 +1899,7 @@ int psp_securedisplay_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 
 	mutex_lock(&psp->securedisplay_context.mutex);
 
-	ret = psp_ta_invoke(psp, ta_cmd_id, psp->securedisplay_context.context.session_id);
+	ret = psp_ta_invoke(psp, ta_cmd_id, &psp->securedisplay_context.context);
 
 	mutex_unlock(&psp->securedisplay_context.mutex);
 
-- 
2.17.1

