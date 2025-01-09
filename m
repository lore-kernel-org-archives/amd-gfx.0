Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0372AE77188
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 03:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8B9810E2B8;
	Thu,  9 Jan 2025 03:07:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C6iX2TOF";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D203810E2B8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 03:07:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKgZdwoBtiV9XcI6R+wis8ddJkKqRkrNqkXWobcHDGufoKbFPXzNgRjKg567xjD78xXh6Gr5PH4vmbUX5Kvq9CIMiA2aUMaM30oK3K78ltLRwcE8ow2cw95coQ/185wjccjQyY8NpAqsMz9rzrxOnJ1gW/n3Poy4PFOJe1cTlTSOb1Uka30tJJQ02EDn2BX8PEbRhDeNqHDymAWSUu7Rby7TCf3p87CQ5JAGvTiR7JHwfWh6UQvLHiYqAj4qtj9BkK8LhrlsfOv0ZKLLKyVhO9r9Z1LBTyfd39my++U3WtHyEPUzQCAmtW/fEpIaYuanHOK9GbgL+Xoeqwp1/juqXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtABbT8AaJw1orBHcuSwFbgA2dCIJwV88ShQvIzazgA=;
 b=t6wfgF0GuwwNnN2F29fIW4IjzKvopAWiTyY7BjSg/D7qpys1jZrph2rPUV4zQy8QEDePQVMDExchSIvOTx/ZiVrhOqcLLQUomgIyP/Do0TJjUP3/KGs2hiXEc0hTKg8ad4dfY3ujZOZ6EhkkqHqz6brVwY/bq05SFam300N61TvSHYZDwL36J7iixWHqX69WMIkUzARFOJYzEMJef9XuQZaWtyI3MDzaT+IcpmXDca6EwKZlGsaiq4//gBSk4f6jCEKaFuuKLl1pLTrpJki+Nhm9PUKxXbtVkFtkeGWNwl4zfqvhvWNBjMN2+oCAxw8hqrSvhfnCFDrkZAZ6HUpPtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtABbT8AaJw1orBHcuSwFbgA2dCIJwV88ShQvIzazgA=;
 b=C6iX2TOFnKtlKiZ8SiStDaqSnJxbl6LkzK5Gq5vVZNgrNFlG54w8h3QblddwdD6bzbpbYbZNrsRyKzcORoOium3UGyXfxm80a7HjmRftemgFaq3CNlb7Fnm57IB8oG18PEywdvUTkYOqUKM+2cQI+mOVjeawvNhidYZSG0yCcYU=
Received: from SA9P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::13)
 by SJ2PR12MB9242.namprd12.prod.outlook.com (2603:10b6:a03:56f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 03:07:49 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:25:cafe::8d) by SA9P221CA0008.outlook.office365.com
 (2603:10b6:806:25::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Thu,
 9 Jan 2025 03:07:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 03:07:49 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Jan
 2025 21:06:48 -0600
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>,
 <Xiaojian.Du@amd.com>, Tim Huang <tim.huang@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH 7/7] drm/amdgpu: add support for PSP IP version 14.0.5
Date: Thu, 9 Jan 2025 11:01:33 +0800
Message-ID: <20250109030133.3887086-7-tim.huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250109030133.3887086-1-tim.huang@amd.com>
References: <20250109030133.3887086-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|SJ2PR12MB9242:EE_
X-MS-Office365-Filtering-Correlation-Id: ae3f6f3e-5c7a-49a6-e031-08dd305accd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gwxL120OtmR+dhOD8wwbyR9VbplVB4zDJo5QTFJdVxsFfD11ERrHyzwtw2DW?=
 =?us-ascii?Q?sAvvwrXi1DjLvPftijnkdZ6dONqICjQftV81IvvB7b9idSGKcm/mhFX30XFh?=
 =?us-ascii?Q?Q3dyXNIocRjjhmYkcdztlH88nsmVpHjG68SiEKfDiBBs10drX0HFpceCYdtG?=
 =?us-ascii?Q?SFVeBvaz+hqIJGDb9uRFLLmMiNWc0lMqdJ3UZv0VOkKdZbbh0+3kYmu4kCgW?=
 =?us-ascii?Q?CXMtxCAVIlFVbkBFSZLB9/Q/98Ip5Ih6Sm1O+TIj4IbVcanFT3SB1WCAfXOa?=
 =?us-ascii?Q?hcF/Lh120t/tbI5Oi49rDEajjI83mVfFY0IVepLnhRnBO7STL2KfFmqN5bpp?=
 =?us-ascii?Q?kiT1cOPlbvpsygUejY8P0soW5qYmj7gxVI5mKrcpQ3CcWO7Y/y3ABeQb/AO4?=
 =?us-ascii?Q?ymoqTHdKOFWSgyc1bE6qZV6ZVMn+6onFrFJkwtb/praHmfw+2OPO2y/TG65C?=
 =?us-ascii?Q?nbNfijtqN4o0w1M+pecRsHVCmrz56jJm+d+YLqqQvDjW7hEXbwz84wpWqfqP?=
 =?us-ascii?Q?nZJ+8BdJ+MWIy6ADyNsztrqU5sC38AJp6L2lctIfa0y2j+pyaex8dRqmTz3t?=
 =?us-ascii?Q?M0ZiWNc2GV/hyEw+069mAyyV7sCUYslILTlItm0dat4OLCfh2iwzZIyK1rP+?=
 =?us-ascii?Q?+jjCXZsoTl1HhRGsKHIHwyYKipaUzhQOCSdYT4uFnLKwSHbSxNVSJ17oRlfo?=
 =?us-ascii?Q?D4Qo6nTn+bHwUkDXJAiQaO2NuAM1+kuLf+uVnYsj/6dvrzZH71cNpmLCSkiw?=
 =?us-ascii?Q?dtqKDml0Mai9ESnkca8xEc+YdQrAuykfpSPobm3UOflF3H0bPLUQU0MoE3Qf?=
 =?us-ascii?Q?PPn7ysvqLNQfmKaaIUcTUtXbYBKNEm4j7PJMEZI7cHbt9cs6LYtJkbN9dhFI?=
 =?us-ascii?Q?7A+jfZ/T2PVM1zyJLwvRQHQWkMZH8WbiqRCVaOHLQ4p3R+mBJjSQR3iMc7R/?=
 =?us-ascii?Q?VupnmuDVhO4R3PlDfmdsOeC1LcGECeJQ485575B4B6+oGgo9fgMUjj2Us+nU?=
 =?us-ascii?Q?kL2vgRD8TbwuVESpu7SzgllHY1tqsIHf2gOwBU1lkfqLTOULpe5c/Bb5AGuz?=
 =?us-ascii?Q?Bnqc7CjBZoUzbn8h7zeYcGnbb0IlhDuWajxiLpQyZS+5qdVFZyIqS80sGzLa?=
 =?us-ascii?Q?rLi6uqBfcc0Caj0YBAYilgm5qmZSiEDwrMYxFP6ZIAq4+8YJd+SbzMd+pyKJ?=
 =?us-ascii?Q?C8EhAmv68QcXiwU6w37ZpBRFrU8rf5oPVlnJh5p1vsPBkCzcxfKoh1Y6XIl/?=
 =?us-ascii?Q?T/TwNTkXlAzvkGHvSWrFD9KwqelLivA+eDnsL8ioohIWLkMX46P/aYrRg9j3?=
 =?us-ascii?Q?zSLjRP81f4ZdZPL+gQUieFHC/2yxEZAtxZiLaEVplutHEw4n+wpJs3ewxmkn?=
 =?us-ascii?Q?jx+N/RNsc6O+gHfOZBu70kp/c5DoozVZOm6Befy/ZjK3tpdJm5W1iNmBiB1N?=
 =?us-ascii?Q?LbL2Hvcn+Zg1/7h2HvNcz/UNdhQ4+XfcpurBTO7vM23hqUpnBycJhDFK4svV?=
 =?us-ascii?Q?moZS0/fE7JM9quo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 03:07:49.7193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3f6f3e-5c7a-49a6-e031-08dd305accd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9242
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

This initializes PSP IP version 14.0.5.

Signed-off-by: Tim Huang <tim.huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  4 ++++
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c        | 10 ++++++++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 60c340274543..06bd9ac28870 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2031,6 +2031,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(14, 0, 2):
 	case IP_VERSION(14, 0, 3):
+	case IP_VERSION(14, 0, 5):
 		amdgpu_device_ip_block_add(adev, &psp_v14_0_ip_block);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 010c038b33ab..e6b19721b9b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -246,6 +246,10 @@ static int psp_early_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(14, 0, 3):
 		psp_v14_0_set_psp_funcs(psp);
 		break;
+	case IP_VERSION(14, 0, 5):
+		psp_v14_0_set_psp_funcs(psp);
+		psp->boot_time_tmr = false;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
index 4d33c95a5116..7c49c3f3c388 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
@@ -35,6 +35,8 @@ MODULE_FIRMWARE("amdgpu/psp_14_0_2_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_2_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_3_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_3_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_14_0_5_toc.bin");
+MODULE_FIRMWARE("amdgpu/psp_14_0_5_ta.bin");
 
 /* For large FW files the time to complete can be very long */
 #define USBC_PD_POLLING_LIMIT_S 240
@@ -72,6 +74,14 @@ static int psp_v14_0_init_microcode(struct psp_context *psp)
 		if (err)
 			return err;
 		break;
+	case IP_VERSION(14, 0, 5):
+		err = psp_init_toc_microcode(psp, ucode_prefix);
+		if (err)
+			return err;
+		err = psp_init_ta_microcode(psp, ucode_prefix);
+		if (err)
+			return err;
+		break;
 	default:
 		BUG();
 	}
-- 
2.43.0

