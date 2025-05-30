Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8B4C5AD49
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 13:37:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D37F810E81F;
	Fri, 30 May 2025 13:37:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Chl7HPq5";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D28510E81F
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 13:37:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSUhYbKpY4zF80zdodIhoQ5r1z+5zVRzr9gHqZZ8zptLcxUVlwmQwJEhfnxxA1WiXnM0ah5M8bRz2Tf2M/WLHugZYYey4jrJfAxOKU75GpRQOO07tgSCqM0wCbyTLegPbwz3XmqTRCxyEjlgERzeh/pEbPf+a/gDSIOI1LWK45wmYesouHpS2R5hLe9XKg8+EuU0xQDdUEt2HXDzDJ4d825WjrcKcUUX5DHcB2DSiGB5RH5sa5gN35IT625iyzI3o9YwLNdtmMXEc1FEsHpEPllMLQW44ZsDNIO5KLLekuTeLpbZeSdGKjpWOXk2qZ0w0B47e2qV8DG+2kauvMyP1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfYDqIPTy5p+K4RGhwFHQxesvy2fk1UqCi/RcgifnEw=;
 b=oHepIiTEfixCW55rqeIfqjWrJJKaHjgEKwCg4xttS9YLsxo5B5mNUi+FwBZwFkWQ/yi6XHHnyHrUTEvHw3ixsGw6jpAZm6tYRmH5H71fZOnir5YgWCslDxYALielTCiCDptuCy00tSqbtdnrRa+I5PfoZsBtsIcMQqz5zAbNYVK8/JUtudNKpK2jzzRSYLut6ZCTkxwvR9pFDnsIoOPnZ8OO0fLyJmQxLfBRnlHivuZCcG8Q7Z4c6anuknS7a1Eg8iHsqadhhHkHJ3M4AHewNGfaGRPvJt51Gd+seZFIUF96O+Xxz+rLtXksdokeumak4QZtmWp/y4r+3EadQojN3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfYDqIPTy5p+K4RGhwFHQxesvy2fk1UqCi/RcgifnEw=;
 b=Chl7HPq5k27YAp/WXqKYfxKO9qc4BbD+OSvhOzHoMHBOmYPNlo550v1glA4PCv3eZZ5eNa6vosbnXGA9xtiYRI53kGJPwcjCga/s/e4VAmzfdkP84Nc/ym7oZXKStOOxiZTe2VNztGz6P/YKANG+XTxGmrSLVdCmXf9NSi7lcx4=
Received: from SA1P222CA0036.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::21)
 by DS5PPF7671D5CC0.namprd12.prod.outlook.com (2603:10b6:f:fc00::653)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 30 May
 2025 13:37:32 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:806:2d0:cafe::4) by SA1P222CA0036.outlook.office365.com
 (2603:10b6:806:2d0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Fri,
 30 May 2025 13:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 13:37:31 +0000
Received: from codemachine.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 08:37:30 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Enable IFWI update support for PSPv14.0.2 and
 v14.0.3
Date: Fri, 30 May 2025 21:37:18 +0800
Message-ID: <20250530133718.559659-1-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|DS5PPF7671D5CC0:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c1e142-f541-4f52-f388-08dd9f7f20ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?74PmeTasU+CjSN/bAbNWMjSurTMnpa40b8zsfk4p9v3ZFuz43TDwrjoFzbxo?=
 =?us-ascii?Q?mEslGCGi0im/U0RaD1tN1HqthF+790f2RYPyyoHTA+lLjE7kj5DjlFWNbv9p?=
 =?us-ascii?Q?1v5gVGJycI/3Y2EUMUyCFleR6y97Zw+NxCVE2cvjjnEym5BJgJlchzjUWB3J?=
 =?us-ascii?Q?q4m2A+L90HIdKldyYWrogSVqTBoLW6TSUrJev6k0HBVJU30UL32dA8VAnpEp?=
 =?us-ascii?Q?BYa+q81GNEeAY1R9zqE7CqIrZpYD1mC0lBEFLf6U4+WLseiv5q5AXcTliuPN?=
 =?us-ascii?Q?dEBmsM1lNJQtpuw+3NJDqltfzT9i3/iXWgpi01pIZDyj06CkllKRJHfDwexQ?=
 =?us-ascii?Q?T+1bFVadd8MiZVT4vq3FFsZ7Dq6BqhG9ZtOLaWjK7LMzL7hfYQJ4EBvT2uQe?=
 =?us-ascii?Q?5NeI6msJcueh9CrwgZ64K2RL5ryvAysg7ZWnFNFc6NlSZiSBcl2GZXnrIrzs?=
 =?us-ascii?Q?sFnC7moJ2H9YxZGviR82oaI0atuMSY0nxFE9RVmz2/m2vZUO9QhoE90zz2Tn?=
 =?us-ascii?Q?Duyw4YUBdaaIs/yfjE/ziKDKfzrW4UA6kPFWgWWk8e1FCy39z8zF6ybhP6go?=
 =?us-ascii?Q?672zLxlyLgwCnZnbNr9GXF2kCtK+v9ICLjiZZfJMBhoa38HeT5tNxSjiTTwc?=
 =?us-ascii?Q?Km+uUKIkdVo6aByjlc4/EYdN7RkYuBK5LzlZGiW58tqVDoC8k3WgSg+xcYuZ?=
 =?us-ascii?Q?DIzwcRBF89fBB+JvkdzvzKEhssnUsjYSBLykt5YlZS7GjtWhgHaoAs6THRui?=
 =?us-ascii?Q?cympmcTCMzo5XxS9Pit5XVM6dPnNV8znbB2LXOS66Z8Nbb4H0wFvOEIhnMbL?=
 =?us-ascii?Q?wFKFkZonRfBQO1m0GlSzy2a86sB7DSwZ19fQ5yNnkcRc0Qg1v7UPov5fD3Kh?=
 =?us-ascii?Q?LLFqyTSvAYUqwK+DDgrijBSXlw20Ldu0Sy7+zhS06oavrxdgY3EjJzwr8wzT?=
 =?us-ascii?Q?N3DuoJAEKNb8BsIv24h4hmWY3S50m1UsOplRJGeDsLZl6jL4UE7ysdtlxp/e?=
 =?us-ascii?Q?EX1470/LFUNOmxpcL/6ZhqQ9q++wc2ZXJyUb1Hd1hrWwFAnc+v7Sn6aSRwWf?=
 =?us-ascii?Q?B2ooiQzh/gyNbxVDGlocg8YkE/qdrVVOMCmQXf82J5FrUC1AYEdSG34kWg1r?=
 =?us-ascii?Q?L52VfMsaoezjKbZsDUAokmys4gq2vkgxXtvJCQL5b3RA030ff63KPe5p5M6d?=
 =?us-ascii?Q?rbptO+Bw9sYAGXzbiCFzWkjZmy3G9i68EoUAX0vkXwf3WdWAZEtKZg3TLVvE?=
 =?us-ascii?Q?VL2vFpR6ejkytyMGnG3wmZp6le2iAFBxm7A93gnA9XtrAsmZKufgLGqjlSBI?=
 =?us-ascii?Q?Xh+i4UFQ8a1EnMxEuNoVJZF8pe0OWN1Ulj6WSrKu2DnZ7/uZ82VnNTKNzmL8?=
 =?us-ascii?Q?uFTVbEc8XR0pmwQljkOA4O1s2TfaJqN83p25863FG2rNrO23pcKYYb2gjf4K?=
 =?us-ascii?Q?vdBsX99Ly+Bur9BkHFOFUJEpdX1ps/5vz6ZCSO1rfcrtHbIK+6jNf0RH83pn?=
 =?us-ascii?Q?9rD067UISddEtpt0I9X3mUuy/TNdnbzYL2eI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 13:37:31.9058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c1e142-f541-4f52-f388-08dd9f7f20ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7671D5CC0
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

Make the psp_vbflash and psp_vbflash_status available in sysfs.

v2: make it available for v14.0.2 as well (hawking)

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index dd37264f1ec9..aaec3f1f8af0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -252,6 +252,7 @@ static int psp_early_init(struct amdgpu_ip_block *ip_block)
 		break;
 	case IP_VERSION(14, 0, 2):
 	case IP_VERSION(14, 0, 3):
+		adev->psp.sup_ifwi_up = !amdgpu_sriov_vf(adev);
 		psp_v14_0_set_psp_funcs(psp);
 		break;
 	case IP_VERSION(14, 0, 5):
-- 
2.34.1

