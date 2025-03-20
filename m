Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF927C36001
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 07:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C79D10E598;
	Thu, 20 Mar 2025 07:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3HhOquhT";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9BA010E598
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 07:04:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJe7r4sNa4FJKidX/b9IM/4bGAZXj+XukAI2nIV8m6Lany/XjetNunlMGH6tRLix0LomOWhMIYeg6onOnroRslWaltHb050bQiTuyRWXroW3cyQTPFXHgJ5y3VtQdI5Pej8inKo02KQ2v4QbOKc6OoCkzTNzJUnKRc1rr76gEHNMiEq92+XWeLW6oH9VuYhMzPuW8M/oHJQUL1iU8hUJMrV7aNsPWEauX64mFdQKT1LuKRhNZz/0AC/vOq5hekAql2il7HcbCxehsU9iTN0IGoqa3EBGmWYIFNU94hd+bLFUDtRPmL1JVHs7e59/YuDkyPdeaP8LTapRphm2xM2Z5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlnO19vQIbC5sFvo9Isu3d8BERgDNZDFIoZDO4Xx9e0=;
 b=UBk1cNs/2ak6eiWGgSiLNQDpVyVtaQ4hFVX7u9OBe+AUHrOKlRjti9Toc/gmqRBmmLZAlJBjpk/M6PTOH+HMy/P5o7YrBnVvrcs1Wmw9sKABqgcmeMqCrzUob+SW83tb2PmFEG9uPNqarfaZR+b6Bkd5uw8GZAKiSAZtBFVmTtheh2cLDJQuAMWksGTo8OiRb6kpBiTFZB0jsRXwU0+fWk+2u2YNbYzeFGPT+E5Ir08ayh7Nj4ieWNtrh+3uR3ahA58Ks7XDMmCPNGzeieJF+Mm1EpbkP+3QQwyJM3XBHHDATP50ARY9VXYUhI4ioAdBNNXCI0TNKtgEhMc+JQoQAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlnO19vQIbC5sFvo9Isu3d8BERgDNZDFIoZDO4Xx9e0=;
 b=3HhOquhTH76LvQcR1fEuROu2z598dwV2Eikp0JADlBZW4DcmBT0gL2566YqyOJs3yCprfwbNDRY7k7aZ1gABYKGL2mmISzvcDjuTPJwgVhSR9jVwZ5jguoAMmzgY9sQPTPkg43LJfQd/jNotLFeGiyFns1d9tOUQxllxyDxvToo=
Received: from SJ0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:a03:33a::35)
 by SN7PR12MB7854.namprd12.prod.outlook.com (2603:10b6:806:32b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 07:04:44 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::50) by SJ0PR03CA0030.outlook.office365.com
 (2603:10b6:a03:33a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Thu,
 20 Mar 2025 07:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 07:04:42 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 02:04:39 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 2/2] drm/amd/pm: Remove unnecessay UQ10 to UINT conversion
Date: Thu, 20 Mar 2025 15:04:21 +0800
Message-ID: <20250320070421.1266690-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250320070421.1266690-1-asad.kamal@amd.com>
References: <20250320070421.1266690-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|SN7PR12MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c4557c1-eb56-4d99-741a-08dd677d7d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wp3yTwQVAON+p8bjdoUAhMHB64nQnvSZZGdnZ8zUVpsvplzdY5M1sIo5Obvv?=
 =?us-ascii?Q?Q0Yx8eOL0GdqN722H+glQgPPQ9yiT3VXOLiT4WZXpsmBgEaRQ7krlpB6k7B6?=
 =?us-ascii?Q?00iUvHqCQfpGebi6vOSCDpRmmAgLcsb8kf2FO53gwWROh0UHHEs2tBIozP2V?=
 =?us-ascii?Q?DYjfhzZjcI2nRwf90FBx6+9Y998kkQmCXVGD5zccHJMUp2CC0TJ+eLTXWS57?=
 =?us-ascii?Q?kuq1afAZPqDaM6rt91dW51JRyCtcQ0cLDFqvJ/Znz7FbawUqIgKTOg2CNbgD?=
 =?us-ascii?Q?+ZRMDUA+n0ud62B5iS/Aa9t1kkkBIl0+SVLOwpWcg6msLiMcupIOhI5sTtas?=
 =?us-ascii?Q?wdapKjlKfzPji7NSDBrrSOaGw+dc4ghxVcQv1JftiZ6sCouJRsJFcxee+vGd?=
 =?us-ascii?Q?kDLw4c8ck+HvWMaeldDQxF4zX9sGjWDG/zBZ4aXPruRqlsHh1aTeirIJ/bRC?=
 =?us-ascii?Q?+DOCgegToBUT3UDoJgLINjgPYL9+IwdRKuEn1RWrFlgYvJsK0dPMSbfOnE1I?=
 =?us-ascii?Q?eArIOIFaRO6+O6Ce35QBSgwcfb8tl7thdI747eSPuHOCFelfcZeMQ06kwN05?=
 =?us-ascii?Q?/aLdMAmQrQWNDL7DcIU80MaoqVnN8ZdoxAZtt4tGxkt4x7c3gJlqAO3icSO8?=
 =?us-ascii?Q?Xo6Ntsc0wzUWxYBND8++o+UpCum6n4pjOo7y4p600Q0VL3L+idwqzhiKlKLK?=
 =?us-ascii?Q?WFmv7aCZlJDAfh+TfKXJatp2as43nts0eYBPMTzLSrWLagLVZRmwxW9wowYp?=
 =?us-ascii?Q?onbqkAE9Sp5KuSrkRxuO76ra9oMGqdQrsuN3cS5UK7WbcxwJXSlf5p1AsCvw?=
 =?us-ascii?Q?4kTtukA4iq+pdjHWHIPBCJErbPr6XIjzYoZVwfonJHKA3nHjuMZDUN91i4xy?=
 =?us-ascii?Q?IG3Wak/eWBvZYLdHbifvUuNN+EXUDR+OiWMvsTiMJJfO8W6ZHi7J1TnankAo?=
 =?us-ascii?Q?W+Bhe3LHoHPNKzxplO2zWlKPEKwxbJgei6zp8gFxN/WGi+IgKmZxu4kGE2Nu?=
 =?us-ascii?Q?WyUxJbD3nAPJYH4gbOSxwsemgZeJQvc5VVyP0pVXGm/7t6Xv9LzcvyPnAA96?=
 =?us-ascii?Q?CXPTOlP2Jh1ix1fME+spRY9QUvLMv7fZh3fYs7gz76aGLe/Nq7oe3iz0tqXD?=
 =?us-ascii?Q?kbSn1jz7vgTscHPhTjKScxapHKRRwdN5A30nXj9pmo4c3O6pEtYEDMOPlvoU?=
 =?us-ascii?Q?8fiZMPTXgFP4O1xjnBGOxecU0z8J4PKNX7pTqLD1XqbWpzu7QFzMR9bBkWHB?=
 =?us-ascii?Q?op0tRM2ZMN3190RQHPdpD1ud9qLLr6NO2pfhIl6flEOnxqgRe+TLyF30SYyy?=
 =?us-ascii?Q?/HhBLK95T3219EUD0CUAZNkAYHd+84JOGNOliq6RIZJL+9hJbWv13ql9h4hm?=
 =?us-ascii?Q?bOMxmuLzqZN9Cnw34DUQx396akM8kHXPJ7AlntMXCt/DadLfjr94JNYytcOJ?=
 =?us-ascii?Q?089JWyO5SWAa9yrBbOVvCcGbHBarXUUag3EH5wO0MsnOKf36tzD1GIUtqTlz?=
 =?us-ascii?Q?mciGoaCeBedbsDE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 07:04:42.0826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4557c1-eb56-4d99-741a-08dd677d7d00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7854
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

Few of the metrics data for smu_v13_0_12 has not been reported
in Q10 format, remove UQ10 to UINT conversion for those

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 12ee8d07d0c8..5d4437e413cc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -488,8 +488,8 @@ ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table)
 		}
 	}
 
-	gpu_metrics->xgmi_link_width = SMUQ10_ROUND(metrics->XgmiWidth);
-	gpu_metrics->xgmi_link_speed = SMUQ10_ROUND(metrics->XgmiBitrate);
+	gpu_metrics->xgmi_link_width = metrics->XgmiWidth;
+	gpu_metrics->xgmi_link_speed = metrics->XgmiBitrate;
 
 	gpu_metrics->firmware_timestamp = metrics->Timestamp;
 
-- 
2.46.0

