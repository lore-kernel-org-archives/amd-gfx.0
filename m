Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDB3C47077
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 07:36:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EC0D10E135;
	Thu, 18 Jan 2024 07:36:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BD9210E135
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 07:36:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2D3afyyxnaFLwtD8nK6giGujEh1nRRJ+DgaDRG/+tP+7N+TUQwvhyFiYWrmyigMEcxxQA7bd1FiVYSh/SptiwXRL38u6/qbuJdHOuqPxGkFCzAQo1IgQdGBWa8DOSXgUMnHQWrbIf8i1OkyLM6jGp//OEUup9wdsnBIFE/sU2x0BbhwMQRNpEaiORCgn3FxtstLUih7MQ4D4WpSLiT+GRY8vYZRjvOqDdahhMGvTz8ftShY1Wd63wn6g8nV5YfAgsfyheGIusauga1Zr8/WJ2WDkOPwvO9F6E3aHXc3Mj/vSyiQiI6lDZW7lAhIbqMRTVm87aElXUxajnH+nIjYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0S7uuuwR7IQFArDIviwFs3jtNp98jO/MwZ4Eo5SVh8=;
 b=VwiOZtZtsuehg1I0mzkrEWZKnkdbstiwBGkujuMcVZARSaykqzxHbemy3k24lqUymeT7IjZacVmgQThr/DPLy9GWKuM92LnVXYTRqMbLmzidMSEfosXuU/YZPoLlHXG2yHm+uIyDuAYDLzX6RyuNtlsFUeaTmBjak42+eDyszIAKQGYBEytm/WQuuJfUa36NNu31SP1L3Mo5tBGUXFaxmUr6WvPBVYG0mFu47FGPF/Ivz4kQj8lGwarIJ0+wCPQThjW62tJktzlnDe71JkSYeSuUaGfhYv0RpnYNrBmHhiBxoGKnp8oJlnetbtvHV/5vVR7TiLjgj9pwrH3VYRn0Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0S7uuuwR7IQFArDIviwFs3jtNp98jO/MwZ4Eo5SVh8=;
 b=f7oQAYicTpOaikr+e1kZ6JO4ss2dR5DWtvB14flo1YwFzjMrPtnvvP+YXs7xe3C/BP41pn4bS2f5TeF1qiqy0WPwlKajczUAZ4ZFYY1HMxbngqE815Mt+siWfpn/i79apB9VkTojd3BI7byaWtOqRkHoc0xRI9f51JGPuLEOz4E=
Received: from MN2PR20CA0012.namprd20.prod.outlook.com (2603:10b6:208:e8::25)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 07:36:01 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:e8:cafe::44) by MN2PR20CA0012.outlook.office365.com
 (2603:10b6:208:e8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Thu, 18 Jan 2024 07:36:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 07:36:01 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 01:35:55 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] Revert "drm/amd/pm: smu v13_0_6 supports ecc info by
 default"
Date: Thu, 18 Jan 2024 15:35:40 +0800
Message-ID: <20240118073541.107391-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|BL3PR12MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 992b6f98-c91a-44e4-38d5-08dc17f81e9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XbDoxCcJz7E68nzmsiSt1Dk8FEcscUgieIhtPnjxqypjxumINZUjDi1soaWw0mbrLO8TztF68wlv6r65u9d4Agspx3Z6OcoVXIIRlA/Vi0RCv2inq8NZXg5jov/t/96oUAfJjGjZGmLM+ct1K8kdj0EmogfrKL0lV0WWXotMHb8yetiGtsblc3bGrF3C9mv0yv1/8CEkoZGVjhMOG02EAOYTMY7bbPv6KEhX/Fwz2S2VrjOzVf0LmuZxlPgobg61gb4R+JQzpbHMJqbFI/iSOWdiX16+4LUfBeosgwvR3nOZyls89WpVdQhZWvXvNOD2n+/bPysjt6i1iSSNA6KAxddCYoiTn7Ro6m7MN2rFz89t/qm3/2dZRaEOkamHRhW+0ICj3BDgs1R/pBSSIvdRWSZonzUzXHrcz58OMMWigqjtoZEej+EWw3HkfegQu8MggwDF1kfcbGOiNrfKsNRrxIkRbR9e0Z2Y7jNjNWBcBaC3BdZhfRQaNZXlxzBK9cDGstFCzddQNH63apq5/yysXTLhaqoxI79Ut7/3shAvXQmBL7V/B8nrmRU6EuepsE1TB21JpIW/lB9FcysAg5DMcSREjCshOBujXGJsifLLH43Ngp3mDJOJzsj9tVWw5MVhw0LS9U8CUPFyWk2x5VL8BNOh+eHRwwJOx48z/dWyEElhUbwpPQuIuVGXRKtqU+n12b1Qc7bm77JnNKJi1maoaB/zmDPJBSjcbADGi3+rJH0RCesD9LALChh4f/XdEMXEmxTJVgxahpMIAxr7iZ4Dcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799012)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(86362001)(478600001)(36756003)(426003)(47076005)(26005)(336012)(356005)(81166007)(82740400003)(2616005)(83380400001)(1076003)(16526019)(36860700001)(4326008)(7696005)(5660300002)(6916009)(8676002)(316002)(2906002)(6666004)(8936002)(41300700001)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:36:01.2207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 992b6f98-c91a-44e4-38d5-08dc17f81e9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit affdce050ab4119a3cdf74d7faa8f1eb30f6f6aa.
We use debug mode flag instead of this interface.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Change-Id: I49eae821ce352d542143d68c05802634b4bf469d
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 952a983da49a..6d8fdf8c538c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3034,13 +3034,6 @@ static int smu_v13_0_6_select_xgmi_plpd_policy(struct smu_context *smu,
 	return ret;
 }
 
-static ssize_t smu_v13_0_6_get_ecc_info(struct smu_context *smu,
-			void *table)
-{
-	/* Support ecc info by default */
-	return 0;
-}
-
 static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	/* init dpm */
 	.get_allowed_feature_mask = smu_v13_0_6_get_allowed_feature_mask,
@@ -3095,7 +3088,6 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.i2c_init = smu_v13_0_6_i2c_control_init,
 	.i2c_fini = smu_v13_0_6_i2c_control_fini,
 	.send_hbm_bad_pages_num = smu_v13_0_6_smu_send_hbm_bad_page_num,
-	.get_ecc_info = smu_v13_0_6_get_ecc_info,
 };
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
-- 
2.34.1

