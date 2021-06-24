Return-Path: <SRS0=QFXE=LS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2B2C49EA7
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jun 2021 06:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601D2613CB
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jun 2021 06:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601D2613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DFB46EA6B;
	Thu, 24 Jun 2021 06:48:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0226D6EA0A
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Jun 2021 06:47:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lO2BjDPL3wnyiNC3itZNgppVfEb4G7b7cbmNmHSWgWVlJ2y3j7MD7eQrE9nny6DIEyyxYGjp/ZRRazrZUU4+Lmk4i22cXMtjg/tl+4nVLIQ6pEQoqTEhnJNXU6LjU+m2cGm/WGEYSqJ7dQgjHmpW8vP2vPjScwxZ6fPGXOs8wMVNrRTOVRwGPfvuqQ1A/TCmEbFovTUqkPjbkd9xRbINH7Mj1GxffnZD4X5rxqkcMpAmOh4suIzx5i38h2yoBfPpnHBqY0hYReMMDSUp3qX5EeWZ5pAE8fUcCHMNfNlYz3myfX3gDW+OXadac8u7O5lgx+ovKeKk1XuUVFQz35T0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/cPbrmLLu0DPG/+H6FeGsmJ3TS3KATSWmc682BXExA=;
 b=KCYzgFRHsSMHAJbBI9QmajwAxDQTSukl9LxAmxBe19C17JK3RVpbUjkoedkSLwYsmehmvPryJm/d4fEbGT36eq5CSu/lHVfASiPK/dwyPpjWT47+jofoHR/KtVfCZmjdI7rfJcdRWqeRVjFrCVvbRbtSWoUAeUMvP3bbgtyZFHKYKMuLPylVUkHg4aPJvBrN4Lh7WGTYWqUuP2flB0LAK/5jWExUCdZAKEqA3ItQddFJMaLsxHbE0nDfPSkQEa/IPO9+d17g/8XGNQPf+sUSh/3aBmk/lrIPTnC8QtT0+7Dy/HnwH4HDZFyLQOiBThvRt8acxG9MDr+KREN6ljRxKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/cPbrmLLu0DPG/+H6FeGsmJ3TS3KATSWmc682BXExA=;
 b=XrQ+Xnpt2QFP9L+pYWDrXlpLskIJU+Qo+ie9miWGl5/2g3R+rjjihYobD6x99Hlh/MGb3PEv1+cE2WWLzrcbV0GkX0uQxM1puwprwRfGoLMeT/LDVK4QAlWQpmFEh4N5hK7I+PLzO7Gp2sPjRrp0YdHOWgFWpAPAeHLzOM6OemI=
Received: from MW3PR06CA0028.namprd06.prod.outlook.com (2603:10b6:303:2a::33)
 by MN2PR12MB3903.namprd12.prod.outlook.com (2603:10b6:208:15a::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Thu, 24 Jun
 2021 06:47:43 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::3) by MW3PR06CA0028.outlook.office365.com
 (2603:10b6:303:2a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend
 Transport; Thu, 24 Jun 2021 06:47:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 06:47:42 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 24 Jun
 2021 01:47:40 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: add function to show psp_gfx_cmd name via id
Date: Thu, 24 Jun 2021 14:47:23 +0800
Message-ID: <20210624064724.77436-2-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210624064724.77436-1-lang.yu@amd.com>
References: <20210624064724.77436-1-lang.yu@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f1931b2-4122-42d6-df91-08d936dbf790
X-MS-TrafficTypeDiagnostic: MN2PR12MB3903:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3903ACF2E096DAB7B34BA0C0FB079@MN2PR12MB3903.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fKwUdzBCW9sSA1c57/s/glzy5fJMX6FoPswSwbbZ4Qaqih1fKicAz2LRsxWBUu3nKWODqgXrtLRLlB6/PPNJIkJJ9xqKlZvMF/AQ67CXIHZt/D29oqibbN6+5bnaM8pJsz9ybLQQSXxVpmb+RKx9I15rOafnzl51i05LalkV3yqkuZntbjUdX5pzSnL1F4FK1eaRURvEkvcezfUtPlyI05cUPIupmpBdtei+ipjcO0Pr2I+V/CNKVEpOxUAd4j8BEt3p8wyNl7Jlsro5SMZXi5N9bAkB6dMJjzlj/LsZ9vFe3n6nX37y65fdkHn0z+Mfw3h6Z+oT+xHdnUOxlj9ni0sX9VZzHDWnzx/XF0+1qWyC9lFK2R+75Bs6lq4ijfHKFigIk19BNiAuGIzOfcdswGtGpptgCZWGQdj8xwq9MWkFcgA2Oe6Z61U3QIgBlVTyYEAym5ApubToRF6hSCqYH5IB4v6iKtfsdKrPmn8FMMUUEW+UrRIVpcvhr8cp97n9ZuQzrAIBqQSrorwGYe9AYFbuevxZlXAY6OWCFHrYlFnQHJMzrWflAsqQwQGdiDpBOV0GxeEBZOVaiET0tqpVI6qeUSYsEmODVdssclATzzug2qw9HMz0qEba1Wo8smdTCwNRKzXjMOg12rSm5WVOuS+KOijBlPCprZEts6Kx1Aovw1t3ml1bVhObapP755iY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(36840700001)(46966006)(44832011)(426003)(47076005)(86362001)(336012)(5660300002)(316002)(36756003)(8676002)(26005)(16526019)(7696005)(4326008)(186003)(82740400003)(8936002)(6666004)(2616005)(2906002)(1076003)(70586007)(70206006)(54906003)(356005)(81166007)(6916009)(478600001)(82310400003)(83380400001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 06:47:42.7171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1931b2-4122-42d6-df91-08d936dbf790
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3903
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Implement function psp_gfx_cmd_show to show cmd name
via cmd id.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 38 +++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 40da29d8ec1e..ff26185b1485 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -353,6 +353,44 @@ int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
 	return -ETIME;
 }
 
+static const char *psp_gfx_cmd_show(enum psp_gfx_cmd_id cmd_id)
+{
+	switch (cmd_id) {
+	case GFX_CMD_ID_LOAD_TA:
+		return "LOAD_TA";
+	case GFX_CMD_ID_UNLOAD_TA:
+		return "UNLOAD_TA";
+	case GFX_CMD_ID_INVOKE_CMD:
+		return "INVOKE_CMD";
+	case GFX_CMD_ID_LOAD_ASD:
+		return "LOAD_ASD";
+	case GFX_CMD_ID_SETUP_TMR:
+		return "SETUP_TMR";
+	case GFX_CMD_ID_LOAD_IP_FW:
+		return "LOAD_IP_FW";
+	case GFX_CMD_ID_DESTROY_TMR:
+		return "DESTROY_TMR";
+	case GFX_CMD_ID_SAVE_RESTORE:
+		return "SAVE_RESTORE_IP_FW";
+	case GFX_CMD_ID_SETUP_VMR:
+		return "SETUP_VMR";
+	case GFX_CMD_ID_DESTROY_VMR:
+		return "DESTROY_VMR";
+	case GFX_CMD_ID_PROG_REG:
+		return "PROG_REG";
+	case GFX_CMD_ID_GET_FW_ATTESTATION:
+		return "GET_FW_ATTESTATION";
+	case GFX_CMD_ID_LOAD_TOC:
+		return "ID_LOAD_TOC";
+	case GFX_CMD_ID_AUTOLOAD_RLC:
+		return "AUTOLOAD_RLC";
+	case GFX_CMD_ID_BOOT_CFG:
+		return "BOOT_CFG";
+	default:
+		return "UNKNOWN CMD";
+	}
+}
+
 static int
 psp_cmd_submit_buf(struct psp_context *psp,
 		   struct amdgpu_firmware_info *ucode,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
