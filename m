Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809D1C2BA15
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 06:34:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08F9610E58B;
	Tue, 18 Jun 2024 06:34:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z6WyJ25J";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25A6D10E589
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 06:34:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Glk+jTGad6SbYUBYfvB2HEC/XMxavEFd4tQ9oBjnjaraU7i3SqpwMC0xJfnjX9GFP2HzZpanjjrAoXe57/65ikv/Z0jOf4pZhCx7t9ze5+FOmkIYLryTkowXmoip5/gNUHGlSSuha2I+UWxfpc2nSoB6MHur8IRq0KibGGz0w4ZO4+5B0hCDGyRElPwK4GVflvCmBFOPl8FnAkcV9keYFX5r79xVP/NY2klWH7s7hvSRkg+7FgMkdVZNrjIj3uLMBQwYU0PqhO1ia5quGyt+Iua4y1bFxsD/MLT5WCcD86xOkPzmHIJKapTPJ6YFa2hF3F/Bg+hiivaYQ/LPXaP5Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pCPrchZdwSUNRq15+FPY5nncDcmBMaGEC5QYxr2gIc=;
 b=V49u7TponvwYV6nsvAynnO6K6XbbxVplFioj7dZq+XuFtQ4KGF+f6b5i2HMHtuCTonYbjVGrtwoE3+X5y2+RnhoHhe8A96A/WqWlQsQuBFarYkaU35ysNpvgSBr+vfWVDFVEUfnckr3u/g6VYlOSDgLGjcyoYdDDpvO+lyqHhkT8ieC+rPOXa5qojhxEQJyzmF7DPlLl9p88EWAhqt+4omHLmwes9mBbgmRh7SenVFIicZezQPuEswB41QDB2fDCMuhdaxOAoOdX6Oi5e11VRmJb2abWkoLaW32S9IBkF0EHg8LwSV1MZAc3Qt4YqjVS/r1KwsECTCbAPbORwzWc/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pCPrchZdwSUNRq15+FPY5nncDcmBMaGEC5QYxr2gIc=;
 b=z6WyJ25J0pHFmt54rTJ4/VCOXlSYqc8alxoa/FeLT/Yx0KApH+khe+p350HsE5IUvnikU9oXLqrT8ZhiSOFneh6yMQ3WH8DQW6m7P9dp/yBL1/pYRFlrA5CwkjNMhJiVe5eeDsEePUQ1SgTe6lFk0ATyDAt1wYYYmiMMMsf2qKk=
Received: from SA1P222CA0148.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::14)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 06:34:39 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:3c2:cafe::df) by SA1P222CA0148.outlook.office365.com
 (2603:10b6:806:3c2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 06:34:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 06:34:39 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 01:34:36 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: add completion to wait for ras reset to
 complete
Date: Tue, 18 Jun 2024 14:33:58 +0800
Message-ID: <20240618063359.304293-4-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618063359.304293-1-YiPeng.Chai@amd.com>
References: <20240618063359.304293-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: d48d16df-a640-4228-fb48-08dc8f60badd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|376011|82310400023|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?73Z7K6ptLoVCvwu+Yhls6uDaeSgvxRyawDV107i8rvQqTuwwBJPXS2A7XwOE?=
 =?us-ascii?Q?jSHpLONfyQp8meTl5r3rHsMHHw8MbB+SbUvGm23RCw+bFk8Cc8N0GyXuqutS?=
 =?us-ascii?Q?GuHMNkEzInJYHaWlBWmO7EMGLeWTrefcYsVOkCBs/yOCCDCl64fOKxS/Bj7T?=
 =?us-ascii?Q?GLGcMVHMsl1nM0JGOFrLLAXVO8zQaI+V3Vt1Sm9tAKlxO7KuZbjuUDPrjzy8?=
 =?us-ascii?Q?EqZDfgKJaN7Zd/5MRpiE45njyvZjYyzzZmVZWcfqM+dGEuTLpHtOD/lIMHio?=
 =?us-ascii?Q?dsxqCN17SJ6tBG/QYZ2QDTchsrJTFajLGCuPYAcDvjAxb3Gz34dfgYi7+8T3?=
 =?us-ascii?Q?WLRvZAIruMVvhNjvc30kuU7sYqknDCxVmkpiHYCHYYWKWYJjIsspeWXLhCO5?=
 =?us-ascii?Q?pJL5zCHHlkSoo7xjz26ljWBX7mOpHoqj9hypj9ZR63nzlzLrD7zgESgZuqf5?=
 =?us-ascii?Q?Wt+glk/WxTUDZXeEWI1QgvTBn6FaNkux0Mf6RIJK02neiAckrAcGFvQltAY2?=
 =?us-ascii?Q?SWzvqPcqu5DiutheUiHwAEM8VdzIERSUqCW5NkX95xgWgaTC+7XZmNSWIGKN?=
 =?us-ascii?Q?X4ldTw7YSmF0P9GQwk0vbqcNpcqDZDnCbtxAjdhE//cBRcZD0XcIEZ3dRHo1?=
 =?us-ascii?Q?ucTAUN9vNqGWbjxAtDokggSNxEIPdtdTHSEvCFh8qqHPib3rNwGRaU21rFrr?=
 =?us-ascii?Q?X2w37hYJoXIpE+dSIoNSHLDR8qGPYdFpJgMo6zRAhsfsBy9rW877hG8MkRKw?=
 =?us-ascii?Q?K/YkXv2UwwZw883eZw9Ox4hSOGCO9ihCLgMb73JqPZrGPngS4kr1JcghKCIK?=
 =?us-ascii?Q?Aofy8LBYvsTsazc1ULG3hxdDgAHyW7BDW/4kBo48bKhQjsQ6qIO6Ga2tbHwQ?=
 =?us-ascii?Q?Bc+D1+kFLuJ/kIGMhwRHFlc7cw2pCRkdp1zIZhwfLGu56yFteEjsr5gIMr05?=
 =?us-ascii?Q?D+PsLgfNtkokUjwPonr8+K2HKBS4/9h629XtW1BM54TRpB8T0vZHj4mlPUhj?=
 =?us-ascii?Q?3Xp4iMXYafH5SsJsdwL/RABBhsR2qNHpcvtMLk5jNR1nsBCCcJt6/Db4slgG?=
 =?us-ascii?Q?tlfIOvqRvipASlR+A7BieI87I3fzaNzx4zTOjwx+ElQJ0nPSu+/Nzpp3euxU?=
 =?us-ascii?Q?hmsnmOf52mhF1qppkJejcQ/QfwQ+xrC4RsReQ+hkD/7GAAx4YCAaSw4u6Bvk?=
 =?us-ascii?Q?R7Xaz2M0yW8XCGfSHOVuGEpoGNeDjKp/a8/8weWxwsy/O7Yh8jlGoETwc/w5?=
 =?us-ascii?Q?Xnq3kAI4Omj0lQi+0YlnSgpee9NVdnvpWZ6XUD0wE2MDFvp2GwcFWc99JMM1?=
 =?us-ascii?Q?FL3nLUSJY5ggSn1rQoQhhR7SLK4EHOqKQ2Iow3iSyg5t+jAktEIA/N+T5aKA?=
 =?us-ascii?Q?rr/pSeaJV3OhwkrWUQ25wXcVHC2rmhwF9f3glLPoy3pcMN7Y2A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 06:34:39.3572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d48d16df-a640-4228-fb48-08dc8f60badd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377
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

Add completion to wait for ras reset to complete.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 898889600771..7f8e6ca07957 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -124,6 +124,8 @@ const char *get_ras_block_str(struct ras_common_if *ras_block)
 
 #define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100  //ms
 
+#define MAX_RAS_RECOVERY_COMPLETION_TIME  120000 //ms
+
 enum amdgpu_ras_retire_page_reservation {
 	AMDGPU_RAS_RETIRE_PAGE_RESERVED,
 	AMDGPU_RAS_RETIRE_PAGE_PENDING,
@@ -2518,6 +2520,8 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 		atomic_set(&hive->ras_recovery, 0);
 		amdgpu_put_xgmi_hive(hive);
 	}
+
+	complete_all(&ras->ras_recovery_completion);
 }
 
 /* alloc/realloc bps array */
@@ -2911,10 +2915,16 @@ static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *adev,
 
 		flush_delayed_work(&con->page_retirement_dwork);
 
+		reinit_completion(&con->ras_recovery_completion);
+
 		con->gpu_reset_flags |= reset;
 		amdgpu_ras_reset_gpu(adev);
 
 		*gpu_reset = reset;
+		if (!wait_for_completion_timeout(&con->ras_recovery_completion,
+				msecs_to_jiffies(MAX_RAS_RECOVERY_COMPLETION_TIME)))
+			dev_err(adev->dev, "Waiting for GPU to complete ras reset timeout! reset:0x%x\n",
+				reset);
 	}
 
 	return 0;
@@ -3041,6 +3051,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 		}
 	}
 
+	init_completion(&con->ras_recovery_completion);
 	mutex_init(&con->page_rsv_lock);
 	INIT_KFIFO(con->poison_fifo);
 	mutex_init(&con->page_retirement_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 91daf48be03a..b47f03edac87 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -537,6 +537,7 @@ struct amdgpu_ras {
 	DECLARE_KFIFO(poison_fifo, struct ras_poison_msg, 128);
 	struct ras_ecc_log_info  umc_ecc_log;
 	struct delayed_work page_retirement_dwork;
+	struct completion ras_recovery_completion;
 
 	/* Fatal error detected flag */
 	atomic_t fed;
-- 
2.34.1

