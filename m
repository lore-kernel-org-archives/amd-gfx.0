Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D786CCF9FF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 07:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C24910E2AE;
	Fri, 31 Oct 2025 07:06:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j8kHus+z";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013012.outbound.protection.outlook.com
 [40.93.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C59610E2AE
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 07:06:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+RllEYxfN2ZE9FrvFv5veDbJQW/PZ7OeaA4TYi9HT/cJCAtIh+rlmmI68bvb5KNFhA9Bd0WjWciB/52gXuGFFv5ZxSLtu8Fj1YXkKs7YIW7Ddk70eY0qfHH/TwpXzilAhkuEmjbUepPRuUj9bclmhQBxp3oekuNKRKfmpja2Bl0ekn9562s7nsF21MNL3nYnzLqOw/YSPJ/92TcVE8++2/RAppW98VmI+EO0Fd4A/lx/SRmb9Z0ModLFgHCp7PLzozpiz9v7P7A8qgmR4PrbgjsWOtSG0ML3TFa/g+4WqUybjMFsoFXW0OJNvnNAKPqh9tVR8styPewWRBslw3pYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFicq2uE04PhN01KVmD9bSHbHCTEathFCfZoIVtbGdw=;
 b=o8S2IIoYFAO7FhqvUR6qmNk3RJVZu9wJcykiOj2Xoyu9HznJyG9nCyEeSy05wGkSbAy+Toi1o3uFESeeHBQu3OXOZLGy0hIeU/Tr+6AhR3eJf5JhJRE8+hRtopa06RITU+Onmvd81Fgjfn3QaMpCcPXeXKcwsWjmecbYGFPHPVEA8sT5nHmWjJpkFN6UW/FIyACRxrN08KGMGpQXUoX/U8ZuNzgLLMZCmkFJEBzgYYiWSO+VbReH1XtXjETWt77ygvdmvm6GgjNhH8cL+F2Mbz89NCWO4MXH+sXQlO+9fqr/7Un4pMExa9Emp84d2wIk7OruLXwCyiCfJPcAQ/YoAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFicq2uE04PhN01KVmD9bSHbHCTEathFCfZoIVtbGdw=;
 b=j8kHus+zxkDVA+zQD1HqQhot+KqoqXgx1zS45qptVc3MBER3sw2/eOlEAtgzSQqGQ1cqDd7UilnYO3ElietKrsBbavC/2tFonJifT+rT4uPN7zDfnNd+ol2r2dddgwoXy5mRMyW9kTIaW6jBDYGn0ejAZjSXsRr/RIBSMpJjDwc=
Received: from PH8P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::27)
 by BL3PR12MB6403.namprd12.prod.outlook.com (2603:10b6:208:3b3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 07:06:00 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::31) by PH8P223CA0022.outlook.office365.com
 (2603:10b6:510:2db::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 07:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 07:05:59 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 31 Oct
 2025 00:05:56 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add ras ip block name
Date: Fri, 31 Oct 2025 15:04:35 +0800
Message-ID: <20251031070435.2612918-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251031070435.2612918-1-YiPeng.Chai@amd.com>
References: <20251031070435.2612918-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|BL3PR12MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: a37fbb04-bea5-4507-9367-08de184bf1fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NQIjeLwNKVsXpRa1yVlFkPOK66+VXj2bQ5hq9ImsolzxqD+aQ01jRFmCus8I?=
 =?us-ascii?Q?j9saYVF3onbiRtjwGlOgBsd9LkYDOREdRvVAFRP+r9Q9RRyi+DU+XI4jVm4h?=
 =?us-ascii?Q?nmfjWw4ejlaf6CqX2wHRqOzgg1c8njQ7M7Pi7alFSoYIAII9UFQTsA+74q0v?=
 =?us-ascii?Q?rp/WnRFnu7m78hP8YQfizez+tBmF0t3YItGLLPakkLuH8QHOO3WShbRTzD9p?=
 =?us-ascii?Q?bYZNx4t1DRIs9BBTe1zDLBvXV4Hzzna1ZdFiI0Lmz2epnWT9W+HQb+9i0gub?=
 =?us-ascii?Q?RubGKtsWwzXUipp1dqZClkLk9GSnDNaliJg24YSXC3tmgDuneOOREYBsy0Qx?=
 =?us-ascii?Q?vBuq8142c6JiWkmHNQ6+GSiDzKrCs3nHWsftOmefGzxXg6bp6/Q4Ln0/ZkK2?=
 =?us-ascii?Q?Y18vRd58KzsYJFl72U2JyC1rVy7AjEm3RL0tll6ZlmJZ09bGT4rCI5BxsyoY?=
 =?us-ascii?Q?NnJJ4ZsZPik3ZMEhib2Ehh7RrssoBILtErtbAwdk/XTjLbBd1Ad9VlAShSRV?=
 =?us-ascii?Q?eKk8Y+FNQdpLzniiVizUx4NDLm+wyIRQCC4YGBpiZgLlpz4k7cXRNjAeH6T9?=
 =?us-ascii?Q?gfAG8aZSu+kpIzwFm/aLDj4sP16hLKjzpNT5Fa29cymySYDCNk5RsVmu0jjw?=
 =?us-ascii?Q?PCssm4jMhDejcPmikfBJcdBCdjbI2NUMne7AfKN8ZXcUUDSh9yYJq6j6aThl?=
 =?us-ascii?Q?E0ZbaqKbEEtP1RftQP415Yv4KVlTuMglvpNXgsP1QtCOEhYRYQLfAcU0SVtf?=
 =?us-ascii?Q?AHCLlF/s6CtmtI/zzS/p+JWTq1uQDeM7aBuxGUJzJsI9xe26uVEU7FTRWGog?=
 =?us-ascii?Q?VTJCWIdWQlzwPUkrGQJ6HgLZBRKuISnZ8g485M6F4SZX7hbhEpBzbmwIDt6w?=
 =?us-ascii?Q?n6CaT1vLBo5PYbKVqy3RuU/ri9mUprma3gNMn5Gg8GnlU3VADRPIBd29tVNT?=
 =?us-ascii?Q?wtCHm5GMBCB6rm+anaG8PBKG0J162GMV3kiey8eCFFBiN1Qu/GsZOGq4oTA3?=
 =?us-ascii?Q?0vi99pkRQm0EzcM5gITc+EM0XApJ/aelEumu+663eWWUZ5AXL++yRTvVqYYh?=
 =?us-ascii?Q?H0DPcXTRdkytH8Rr6VKPyyz7FskRmRhxfGx+E/kZhku355lkfM9UEClHs+C0?=
 =?us-ascii?Q?TUlkg572LKjelkq516Jvq0A3dvwDNwL48E/RVXDZDXnxMKj3FeKpaN6tVs92?=
 =?us-ascii?Q?jEx4vQEI3Uf09u4xvBh3gc4PvagYLDH3fMrDvny7eVorF0WAZ5fSGO4Klypw?=
 =?us-ascii?Q?p9v90hKzb7v8pmxS72mBNmPzMOoExqbPPxWt7EMcQnWDAI5peCeh4Lqii4lz?=
 =?us-ascii?Q?G5l4kMdMMaAp38TjhQc75ceBifS+asF5ELFhzyluxGF1xw0ZLVtmH9tTUn6u?=
 =?us-ascii?Q?kLRtH2ZJ50GP/S0zrNUOFBD5+5Pg9azus+3IisuAT/A1+WNuzhQue0zKQAk1?=
 =?us-ascii?Q?yE/eHIdiE+LX1M0TbVRCVr3n8i010ngPYWKETQPqSVKpSogxR9Hdjbd9Ug3T?=
 =?us-ascii?Q?Cr+L6u+viIUt61P90CjFmeWHb6r0six+kO6sUzvUJsheOeyexnS44AijXFh6?=
 =?us-ascii?Q?XvuSRqiLSBc9cdjF33I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 07:05:59.4093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a37fbb04-bea5-4507-9367-08de184bf1fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6403
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

Add ras ip block name.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3dced3db91db..eee4b79a9a17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2519,6 +2519,7 @@ static const char *ip_block_names[] = {
 	[AMD_IP_BLOCK_TYPE_VPE] = "vpe",
 	[AMD_IP_BLOCK_TYPE_UMSCH_MM] = "umsch_mm",
 	[AMD_IP_BLOCK_TYPE_ISP] = "isp",
+	[AMD_IP_BLOCK_TYPE_RAS] = "ras",
 };
 
 static const char *ip_block_name(struct amdgpu_device *adev, enum amd_ip_block_type type)
-- 
2.34.1

