Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0AFEE20A3
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 13:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FD6B10E6FA;
	Fri,  6 Feb 2026 13:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0hNvh0S5";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010005.outbound.protection.outlook.com
 [40.93.198.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 722A310E6F1
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 13:36:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+JkKIIoROO5LurymRFz/2ixlkNue9h4MZWts5jA9V+3Vsy6HLcMp7/mGVi2N6te08lSjAxBH2/HQeQyLEznx02lX2vKCo6smBKFcZ4YEeQLFeilGWLabtp+S2li/N0r+ybJLz+ckKRLEKPRfoRPIuLzZFyigF5Dk7ea/QcqIwziKxfk4S+4JJ15QvF5tJvwiCYkxQcwmg42/8EyATrqNTmV3hI+sBtB90Kiax5IU0Lm5eHdolKe6VNOKabMK0Wjwb+L0aiKwWdnqHnBJVwAJFCObHVhUMx82D9DmGzYg9cIxq1X/zx4kDewGn5K20A/LAxzPX4pcYkO24jmnAp6AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQ/r6F//Lkv/+r9iJL45Q1YRrqNMibnrHDBYlvZFoYM=;
 b=Qt0ah59h7KA9eX/oJ+fbbRufL3EwJG1UbsguXWHZTVg+MKmnXnEGos1hiC7rHXizb/HE8CruHivl0k8PmggEr9cmSRQ/s+tUIGtR+KTqq/J8gGt/txV9qVVVO2NTA8trZ6JJHUlezcDPnQRR5+rBuophGOViIpoJgw+6iUXZvTeinMb1nNQMyozwpL/nrC+FWr5/IWo9JYQLeNTRvZSJOMGCd1x72JXpb6bfInDolBt+lRzS6j6NMREKTZ0kpWnyBkqj7TKLSTFmFQAVT590WBqQsPp3SnFPoCu4AzZ6mfCDkXcwGgdOcbAF8urjx9QX2SaqRE+vXfo6pMivBplXBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQ/r6F//Lkv/+r9iJL45Q1YRrqNMibnrHDBYlvZFoYM=;
 b=0hNvh0S57CROTK0NLKF7yWTBTUPXMbfDZwD7uVbFM1JRfFh3GTsFtF29OjUIMZAVRem8vfPXokLQtoVQWIJD/kvbV5yLRHo3FGXHDnMM/1EK/N+cWZPr2KBVrg54yPp6Cjvh+vlfW7RDlYT1P3B3/Rd0U14Sq0bFWksJvclfVyQ=
Received: from SN7P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::24)
 by MW4PR12MB6681.namprd12.prod.outlook.com (2603:10b6:303:1e1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 13:36:24 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:124:cafe::46) by SN7P222CA0026.outlook.office365.com
 (2603:10b6:806:124::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Fri,
 6 Feb 2026 13:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 13:36:24 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 07:36:21 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v4 01/11] drm/amdgpu: Load TA ucode for PSP 15_0_0
Date: Fri, 6 Feb 2026 13:35:57 +0000
Message-ID: <20260206133607.91047-1-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|MW4PR12MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: dac21302-4899-4cea-c716-08de6584b8ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RFqGTVdG6+aOQ8S8mCrAaS9iLuiD/rPhVu+XeSvudfNu+nyhscHNfbp7AS0t?=
 =?us-ascii?Q?91XXU75+5Z6Klm3HO1jx2zOptajWiA6FEERwsTyajoy9S0EvQQGOUruDAFT1?=
 =?us-ascii?Q?Mmzf8KUyqd6QkeP5ALnrwa0MX7kdb1dffv1K5j7H2VGaF5vP1/AZvA2Bmr+Y?=
 =?us-ascii?Q?wWUIndLb6XLZa1DlJ1EKyC6kcuTJ82a0G7M1QZyrnBibBoE/FaHZ/6P7zflR?=
 =?us-ascii?Q?X868Vy6Ijn/M33JCtsdj1uGfIXR5+/YeUJN/P8/TVDDWuUV1VQKbZd3Yd8jq?=
 =?us-ascii?Q?o1gije7OeGdG6rnj/IA9JZCbZM0F+TT6tLtCD8S9LaHijtRYIov5pnL1b57t?=
 =?us-ascii?Q?ReW+oOvrBzlAe+6uzOpofxh2nHRS4tRHCB3UmYWF5eQHqt6jhJeEGq/jWT9M?=
 =?us-ascii?Q?q7y8gBiuHu9jpMD+ODbUgUcR6ZnXTaFOXOulCCaUoQQqi/vxskZMQN4ZdZY6?=
 =?us-ascii?Q?FDKwBEV5fKjCorw8yxkaa+YJdYaCxafmT7f2nIueoQ4QzcZtdfIOfcK79+7D?=
 =?us-ascii?Q?gGr8uM1hets9OgF3lLmkLczL2bTMKGWBoh7s+Mdk7oJ0efUICdtF4YtvoUTu?=
 =?us-ascii?Q?ful1BwQC6Ne7ItzK/1qiRmIT4piST1eYaWcvfjSafritdkemfZfq4+ppNpnL?=
 =?us-ascii?Q?Dr8gTkjlErNTHrf8LCFAqQSFkEynIqk87Gn+1GmTV3u3GPzl0lg2G5F91hGr?=
 =?us-ascii?Q?4Kv/qezRD3QxRGC4WoMZBbru/vKaInhQf4xR+f5DmVauEcHjF0SBXOp+k8mL?=
 =?us-ascii?Q?ltV+ejsFQFUjfAA+C7Msg+RnOGRgG2jcnzzlGsmrJR6gauPzMgoyeGIiUxw4?=
 =?us-ascii?Q?zUZ/3/JdrPBu1IP1q2Lc5vdMUxvNGr+cKrxF7QoOKqLm11IcQEBiFwclhh6S?=
 =?us-ascii?Q?kBZ+1XiWRZLW3FGIWItEZf6WdX6kgGjrHkVP2ncyBBBBq4THgkBoZIH2/74P?=
 =?us-ascii?Q?4R6+FcKj3jZJhQJrPns6vSuh8N1UYqL4SYGV1s3btCa6qK+ScJApp4Zox8DW?=
 =?us-ascii?Q?DNTt7psvFPPJrg+G/kVvygd+pRePBpLEdhDUTAQX0muYK4WSFIV2YftNqSOW?=
 =?us-ascii?Q?t9khAIQdMhhOi99iiUXNbGypj7MwvS9xM0TrylWXrxPkEoRpBFGOXdtnkW43?=
 =?us-ascii?Q?rKjmCERjXlSpTm+BCrQjqpaXh4zJb7gzWmH4JsZdGTgMp7psuwjcLbuGsv/E?=
 =?us-ascii?Q?jfAUqr2ljYHXgx5AhpBWR7L3AMjPzB/JBas7VoKGF0/+ZL57Q0YmfqnKQau9?=
 =?us-ascii?Q?HPCPN6lI5bJAcvRdbapdXBE3mwUiqLxPgQqx3PuHL9+5pqqpfyZixW9JkRDu?=
 =?us-ascii?Q?Slqdx88IR6QiEq4q/dX/Tf4624SeAX3WTz75+e36nRK+J+0/Y/Xgl5K2qf80?=
 =?us-ascii?Q?I9nVz1ztPFjQOALAvnHOnHcAnTM76ttX8YE3pq0wHLGyxLsKvvM2VViFIZrx?=
 =?us-ascii?Q?93nsbIsMmdU84jYsQS9VlIffHMAI/C77qqwyUFBmVhq/YalAL63kczOyDvma?=
 =?us-ascii?Q?DNIdEDr8zrLMt2l09TGS51EndZv7HtBjLXqON0EpUB9sVKsj0++a94IsdRTL?=
 =?us-ascii?Q?3tPd4eB0xIDKwyddNt4d29aHox1DZcmzM71d9QSmclNtWK9jz3G3rLt+hCYl?=
 =?us-ascii?Q?XOmifAz6iKshLCxnxSTbDYoCmJ/Kjv8tYFbcQAhLxXKMfxv2QjsD5es5CQfP?=
 =?us-ascii?Q?Cy8y/Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fe+dGZXtORak2ZR4g1J/Zm7mCPxE+VVJkiPhcK/hmyIvWZqzGTUYQYwqfKuXuRelMkuVfmND8X6jwrkl3JLnEzOssPXv7plurp2YkituJorXhphSr8hfOwbxW6nr/1iJPn9Ioax50+XIDzuNRPrIh29PynKTA+v67NNKXaJqFxb99EY/VCDL1Xo//bwGthdVXBhvmf7Qc9USVdiVAAyMPtGPVtGB983wOdOpCct47tXq7XNHxfcneU5NkQ7sKp2/rDngtuNOFgNrPJBrGa1zjXln2W37vlRjl+3bYC5Uyd5idbHcB7BI2ZT2r0e4Bgk0o7rAj5XBcmWqeSN5cqiBUt9LimEXE99lP9Uf1vbpfcFGU1PutsRf/hJCG9Lwgl78cR6MN/WOAC0KHdh5gmKeAraXeHMh3greLs3pZ8DWlV+f54y5GNeKMLTQ8Uvw/FjX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 13:36:24.3177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dac21302-4899-4cea-c716-08de6584b8ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6681
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

TOC and TA both are required

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
index 3aca293e2f0c..723ddae17644 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
@@ -45,6 +45,10 @@ static int psp_v15_0_0_init_microcode(struct psp_context *psp)
 	if (err)
 		return err;
 
+	err = psp_init_ta_microcode(psp, ucode_prefix);
+	if (err)
+		return err;
+
 	return 0;
 }
 
-- 
2.43.0

