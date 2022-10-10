Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567AFC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Oct 2022 06:46:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 626CB10E18A;
	Mon, 10 Oct 2022 06:46:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 162A210E18A
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Oct 2022 06:46:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJa9il2Mn7KSznAR76UwjV8uLAeDD726RX6H6OXPGgNhbrzHK46Yhx+6BEejPbbDlBu0EWTkyDKwIyhcC0CKWaeSrDlmAhJbT4cWv9XmmoMd9G14YjtVsQ2a7Imr/uxslGYm+jS31XIF4s2ztvo8rLXEU/E6KS9sPSDCBnm92a+vcWNILiWZZPdbWCDmyZce8LYJlaEi5UGvCsU9z+mbkoa7mwBqTuYbLJSfLgWxTsNT8ektd46nLv8JSrnAB3ix8nOfBiBm9iEh0BRPU7HWpxw1Miv8bl0p7N4AkBwlmcifcUf30z7QLov7P8MSEKF7lXNyIyf8PJfOz2/9w8JzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLrnXjuRDWy1gjsSf8fx/W2x9O+Gsz2RV4RcRwQbyVc=;
 b=TcSEFTUuXVvbC/ZO8+zuCRBU5m1IeE6/+OXxlm2HjLS1+bg1aIUbOg2DQmGlU7iM1eQt+SeD2k6BNe2eirUszqhxjlLn0f8LHB5EBtKylQFp1wljkAV6sOkEgVRkkV2dgZqlyy+mNsHcpZHepetwOhADga9M8kSFOGiznzn5bjz8aLWiLVb9f2Y7vPs+OO7nLKLc8jvONDZEURIsc3r1PMLsI0pnXqFTrgA4+WjfLduDqcIcItLrJNQft8e4opcPrPq8U9qEw33jAHBv+tIPG/V84h3fxMBBdpwQH0RAiggFgkU8MpItu8cATpGXCxmfKvH6cHRUfUCn7wLIF/j0ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLrnXjuRDWy1gjsSf8fx/W2x9O+Gsz2RV4RcRwQbyVc=;
 b=Zu71Pu6Vqs6xaJAiRWYglu+kxgoRjAImnhz4SP25d+CMY8ReNe9887CrMejL/K7/mm3rHyOTDbDa11SLJZBylFDMUWtdW6lzzZhUe6Y28nA9KIGCGD6m2Gno3leTeSz06FSB7LAlTrKBuLHTE8xQqn6Uo9RO8X4VdR8ca2EYX7A=
Received: from BN0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:408:e6::31)
 by LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 06:46:51 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::2e) by BN0PR03CA0026.outlook.office365.com
 (2603:10b6:408:e6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 06:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 06:46:51 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 10 Oct
 2022 01:46:49 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Update umc v8_10_0 headers
Date: Mon, 10 Oct 2022 14:46:28 +0800
Message-ID: <20221010064628.14410-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT051:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: b626936a-bcc2-451f-2062-08daaa8b362a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jtgmblW/9W/EVXmvAGrBvAEz1WmCTgsOK9Cq/1b27dVS5dI9DcopKPJm6sBdh7ejCj3O1VA8VNYdZtZp4nm7A5pFb1nAUxzl/fBQIOHjQWYfe9vHybeRBHUvTAzMGgL0rElGNNQbk1ikWjZQ5qTW/3dZm1a54Eip444GAme+xXYDezfbtlgJgt8GMYpptZK8bca8fNARIqxYCTEHFgYmMPRlCPP3QzGEAR+cQXsFTNsFHD3ujuftEPIeCQB5yxYdMA9H6X6v6DNPnHy+FBSG4jpFhdTZpmSVS5NL/+vf//QYMi9UjuzBgQiLz+JQRLogvzQ5RsqVCnBrRns9YV36bBVMdWLdMuieg2zonnn67WPEZO1Xz0JnzdjoFMN36W+uvJJRB1HZvileagtCbzkfwN5v4iQYrN7OUarBkeSdwzwRyAd4Doe767Vl90pal/9dIz6afCCXSMr56F5JxzFmQo9EOB6QKpFuVpJ3ut12HHhnKJFETr+mda+t3KUPi0jv87SfpgPyjfx4OavE+8czW0AqeQMNWhWGPtU/lA1axud1RxEPc5V1TFn6z2zLejbx9a3lZWSe/1h4dIPy1nwrsCWGXtvXatu8rT6TRTogiNtaS2xj8RPYQvzo3IHSrPv+AnXEc89WqjJGn7bVXSGa0ysAPVnhENmmQr48uoDjA0/ICH76/Q9uQmpzAltB3OF26x0OiI4f+akp3FX+4q8ZQY99Wi4w6Ja8Wn5olWa/3BNQf0ZSFvVmk+A/m4xr82RiQ5RxOy9M67ybs3IatLStW/98t8v3tu5jgTRZMiaqPzk1zFGsz2qc62MVAWBFkDSY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199015)(40470700004)(36840700001)(46966006)(82740400003)(81166007)(36756003)(47076005)(336012)(356005)(82310400005)(6666004)(7696005)(2616005)(478600001)(1076003)(426003)(16526019)(36860700001)(2906002)(26005)(8676002)(186003)(70586007)(70206006)(86362001)(40480700001)(4326008)(44832011)(19627235002)(41300700001)(8936002)(40460700003)(5660300002)(316002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 06:46:51.1784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b626936a-bcc2-451f-2062-08daaa8b362a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847
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

Add GeccCtrl offset and mask to umc v8_10_0 headers.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_10_0_offset.h  | 2 ++
 drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_10_0_sh_mask.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_10_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_10_0_offset.h
index b798cf5a2c39c8..38adde3cae5ac5 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_10_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_10_0_offset.h
@@ -29,5 +29,7 @@
 #define regMCA_UMC_UMC0_MCUMC_STATUST0_BASE_IDX  2
 #define regMCA_UMC_UMC0_MCUMC_ADDRT0             0x03c4
 #define regMCA_UMC_UMC0_MCUMC_ADDRT0_BASE_IDX    2
+#define regUMCCH0_0_GeccCtrl                     0x0053
+#define regUMCCH0_0_GeccCtrl_BASE_IDX            2
 
 #endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_10_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_10_0_sh_mask.h
index bd99b431247f3e..4dbec524f9434c 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_10_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_10_0_sh_mask.h
@@ -90,5 +90,8 @@
 #define MCA_UMC_UMC0_MCUMC_ADDRT0__ErrorAddr__SHIFT        0x0
 #define MCA_UMC_UMC0_MCUMC_ADDRT0__Reserved__SHIFT         0x38
 #define MCA_UMC_UMC0_MCUMC_ADDRT0__ErrorAddr_MASK          0x00FFFFFFFFFFFFFFL
+//UMCCH0_0_GeccCtrl
+#define UMCCH0_0_GeccCtrl__UCFatalEn__SHIFT                0xd
+#define UMCCH0_0_GeccCtrl__UCFatalEn_MASK                  0x00002000L
 
 #endif
-- 
2.17.1

