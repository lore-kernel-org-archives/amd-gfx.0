Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE64C4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 06:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42E6F10E704;
	Wed, 13 Dec 2023 06:15:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDDB810E705
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 06:15:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UR4F600q6bdqwVZvnKQj5spoiyRsuH4I8M3E611RLMaL6E1nb2qiGH43NaWts/yBPnjsDZ0Gfgh/5XnHEWuuqffR/48fgdq1jyCKg4dYtUbXgM/xoAARAof4kvDucrQpFGz6uiPjeD/NbX4RDKDj2tkUIfiRJcs8ctIO7n+oKxjwqwB79BKBVqaQIOfgRXD0CdKGpLGIh8GAsVAVQQ0+xh91pN5KBN0UHgRM5PW1nm+F1IJC4MFbZl6xm+33qB2Be32Q8jfi1ujK0TqekJbqN1AV8Z8KypW/LhIEy536/ZKiLkXDxKB/P/1IrlpwI7cT+Ylf5RRBp5UicWBIpMtw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0wo51wdMztdOfeXtrajkoHXAtYQr5BUr/hGw7e2Yvc=;
 b=apCn4ZSVn+oNoXUC9h3n1E2iiHdM5nEko/bJgkyHpPLCj2K1RC1XLTl+KxVlJgmzM9QQRd7ndwj5OeNeFkcFWyzvaRTWVzlv8sgguqVwRUmgtKxpJqYokX3QAREsmYPCWJMkYuFjGMjH+qE+YG9M7884V3dWvrYDEuqLJiMHF8iwj20R3brJoONkds9a97EowOpwS1W19jPt3GlysSMLK6ea3todaAkb/OdpXyvjVkthm3rnuBqBONjO75tZK6pNIdGZTg07ZiM9ElTfA127qiFmU5BwQtGcuvpjCaOyJAKR7xXFlacgxtx2LppxUlJ1TCKyQOq0Mz4I0mrFphdamA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0wo51wdMztdOfeXtrajkoHXAtYQr5BUr/hGw7e2Yvc=;
 b=Sh4Xs1i0wdW6Nh3q3YwtDHNt2toLEXoq0UK8jCZWjXcrqTSo8Yl5Ts20KVQ6/gDVARk+tt/+3ypqwrdY2fmxahMOpuwwauzDSsccT4yu7QZQJrTjKlRUKtM2mGziwgxHF0bOWAtY9RgDURB6khv5CsB6jktUbAvHWyB9vvmgdrg=
Received: from MW4PR04CA0261.namprd04.prod.outlook.com (2603:10b6:303:88::26)
 by SJ2PR12MB8978.namprd12.prod.outlook.com (2603:10b6:a03:545::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 06:15:22 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:88:cafe::df) by MW4PR04CA0261.outlook.office365.com
 (2603:10b6:303:88::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 06:15:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.8 via Frontend Transport; Wed, 13 Dec 2023 06:15:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:15:21 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 00:15:17 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/25] drm/amd/display: [FW Promotion] Release 0.0.197.0
Date: Wed, 13 Dec 2023 14:12:26 +0800
Message-ID: <20231213061227.1750663-25-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231213061227.1750663-1-Wayne.Lin@amd.com>
References: <20231213061227.1750663-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|SJ2PR12MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: 017b88ce-0a5f-4af8-9dc0-08dbfba2e3be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1t4NcNR4qayMB45m2fTcI1n31qN0HPNR0gxvWl7+tOvlwEIwtOxM6a1EU3kxQiJe/C1yK0fw2F6wqxROlLkio9Z7yzIrrBqEa+z8tSjv28C2J9TTapRm93pEd/ppykrB/0XOUcZnNX7pK2W+/abiz9TceaN9W5MIRvnlQ3y2B1syL0r9RbiHKjbb/lwE2Kj2xKp8rIaD4TiMXprYE4PMY0CazQYPCttC6HkT5ckdwNfsbsqbvJRPJpe7gT//AU+oZcw8Epxkt5uCbQzE/Bb3QUNM0nVh2lKdNQprLUkvACUou8e3R7QlYKtAQEr+TXh2ZLDC97h3+pueTJcg0q6oPz41Uh1jnNXWD3GuXtZQWrFVUvBrleePXw8fvvZtVKS0WgvJiN4MD1TeboHcbslJvnCa6UfiXImrR7PwZAHXravYSTDZTklUGXrKc/gTtWzET8ojwLsqk7SzwTmeelzzKXDtgrmBYCheR+M+BR8OT+3LL9lUW+W9tCMIao4MKg5O303qS+8B4tHSsYyMLRwqM29hOR0rDV4TKRAJMvqbmhD5Mgigvw52Zo1OsSzxcMxZUMpVXiJLWMU7EpO9fjSOrNhbvO6amYl+GE8iBeE2hGOQETzDFM9pIvEj0I+yWkRLcfxQhuV+jz7RU9PT55mqTMulubL1th4+fkmOdgGntEfzbVvl2glLPUeF4nFHkJH491IvBBFcjGrM5mu4q7g8fBboW7k2qf9gE141lSETJHo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(40470700004)(36840700001)(46966006)(40460700003)(26005)(426003)(86362001)(83380400001)(1076003)(2616005)(7696005)(47076005)(36860700001)(8676002)(8936002)(5660300002)(4326008)(41300700001)(478600001)(2906002)(6666004)(316002)(336012)(6916009)(54906003)(70586007)(70206006)(36756003)(82740400003)(356005)(81166007)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 06:15:22.5844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 017b88ce-0a5f-4af8-9dc0-08dbfba2e3be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8978
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Anthony Koo <anthony.koo@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <anthony.koo@amd.com>

 - Remove unused dmub_fw_boot_options flag

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Anthony Koo <anthony.koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 3c092064c72e..c64b6c848ef7 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -653,7 +653,7 @@ union dmub_fw_boot_options {
 		uint32_t gpint_scratch8: 1; /* 1 if GPINT is in scratch8*/
 		uint32_t usb4_cm_version: 1; /**< 1 CM support */
 		uint32_t dpia_hpd_int_enable_supported: 1; /* 1 if dpia hpd int enable supported */
-		uint32_t usb4_dpia_bw_alloc_supported: 1; /* 1 if USB4 dpia BW allocation supported */
+		uint32_t reserved0: 1;
 		uint32_t disable_clk_ds: 1; /* 1 if disallow dispclk_ds and dppclk_ds*/
 		uint32_t disable_timeout_recovery : 1; /* 1 if timeout recovery should be disabled */
 		uint32_t ips_pg_disable: 1; /* 1 to disable ONO domains power gating*/
-- 
2.37.3

