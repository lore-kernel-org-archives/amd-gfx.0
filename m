Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE552CF2561
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 23:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C8D410E541;
	Tue, 18 Nov 2025 23:00:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tWwRawpY";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013049.outbound.protection.outlook.com
 [40.107.201.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45BA510E541
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 23:00:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YN4cqErzW3S+0wJw382tyxZaa4yxVYX/KsLJHzjaGW8Wcb/TLvANZdAQys3nNulOpZzDZPau6L5N1RUR0nQr0sE71dFLs3R87JYhgAr192jtOmbHzj13xE5yfGp1URzbogZSWvCkSGL5UO+FYW2HqSvxMUpg5xTpaMf2XOqsC6n6jE4cZ/8rmuEgbkG9w/xNp22R99ihPHxd6uu3Me2SWV1IBKIpK0nR07MaRUwzwaxU0u4oBv0FhUCxngfrMmEx6fIymzXs1s4ILelAmqc4dfu23co+zFf9XQmi7Pa1U+usxmzG7jQz9j5dmGpR0J2lMSsBnLYW6yGWxqX48vhYfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4/67yeh79xIGPXZ9eEtZuTtepIZD+SsX+o86fszMhY=;
 b=TeHV4rHeXsct6ja48kPJgZFWrrSPppQYLYaGAzYcgmnKsR4FSg3O7Ip3ltTTF6DT2ezVcg+X2AnGwU6AqaSqZnfaZXBNIQRp8HAmCNMmNFJx/kPvEu5PIRUoNXeIObQ/oFLmi/BoZYXvpL+GuygyuSWSKiRTg+DjT106V2rPX3wW21xXaamDmxS1wqrr3nSREXZ3nur2W4MwvzmqxZTSXM3rrRW6955UIAOYcjwcOKDxY1tIMYtUO0798u/mVwZ4QQKta4UwCN5Rv3KZ3yAJddR4fDXI6BksCMc+G695roZUVm2aBUTEnldjcbpeMqf/ApFhaQZLnm1RoUsS0yGyyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4/67yeh79xIGPXZ9eEtZuTtepIZD+SsX+o86fszMhY=;
 b=tWwRawpYGvvSWI6colkF1z/XExqNmSqe9mQQZ8o87GFgfMKKxG0llevAytmmiEcc3uHLEjP9cun+8FLBEBbrVcHURWbG+oouknIG6X4W0oflMBn0E9z+4JdJQ5i6xp9LRGLp4+r518dVSl3DTSkS73bbTXhzu0mCUqh7cp/Pp9I=
Received: from CH0PR08CA0019.namprd08.prod.outlook.com (2603:10b6:610:33::24)
 by DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.22; Tue, 18 Nov 2025 23:00:12 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::e1) by CH0PR08CA0019.outlook.office365.com
 (2603:10b6:610:33::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 23:00:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 23:00:11 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 15:00:10 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Use ih v7_0 ip block for ih v7_1
Date: Tue, 18 Nov 2025 17:59:55 -0500
Message-ID: <20251118225956.3613357-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|DS7PR12MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: a729c62f-1b65-431e-052b-08de26f63a23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Tfx+dVUHSfHssdyEz0kd3Hgo4vfX5k6LH97sSDwdqot/IwdSk+RDDhwSldxd?=
 =?us-ascii?Q?rajAc0RiV4bbxDiId5jQZiSGbN9gonc1p0WLXQCtjRjQ3OHLZjs58NGcsIX7?=
 =?us-ascii?Q?gctQQOhEkBvRf1y2OuEaIMCMKgFx18kOleyz8YhkJBkSBfumFsX0rquIt+YG?=
 =?us-ascii?Q?clMbRJt3ZsQbkKluaENHOTuqTyyW65CTLNbi/hU9MMr7FKdMuR0yJgO37VJp?=
 =?us-ascii?Q?wj8VvIpMzh7fUR+Ur0RyVy5VrlxlbXO8PKfAWk0OtLwiI6ZfmB5/Oq7ETq2i?=
 =?us-ascii?Q?GpswB5jVMHzzuQZWLFTB5h/wv1rskL3nOPjcXgRNrngJXidOg9p9NjlC4w1+?=
 =?us-ascii?Q?dMxWa9y28sdhbj3+IUhPDQVyS3MXYOgYbBWZi81l4/yVXeHBCBpcS+tBZ7V+?=
 =?us-ascii?Q?Y/3slugWUyGtWlge45LUJqyi5sbpxBh4VabcoHG/M10vJSP0AWH0l+g9nfxY?=
 =?us-ascii?Q?vfnaVF05XkBm/0sRnUwRsGVzZ9AtkpNVrkbEqWWjf5tmm6ECSZ0puOmkFF+g?=
 =?us-ascii?Q?gcQetUav+8jALgZLTQZcJrzkOnDYyS67C1sLwbrhN0DLYWRfhpwmpEzyb57+?=
 =?us-ascii?Q?9Kh5/+Do71gcs6Cr30YJI2o1M1+JPlmv6cN3lDe3X/+KubTcDxKG+cbjVocr?=
 =?us-ascii?Q?cS53sX+FOy4Fr8eME3HIypebH8TCBibS5x2oNHon7FbsvUufLtDwAsKLigFB?=
 =?us-ascii?Q?lVlgBzt/bB9YUSrrhUV9r5VbsqCIv0+nJoRulKRwzIWCjmeoDiXa+N8HWUd0?=
 =?us-ascii?Q?DhmH56q//JDYUyTaO5PIPVgJ3lMhLtnp9geVsvAe9d4bepO//uU1wx1K+xEV?=
 =?us-ascii?Q?7XOQljAF5nmkdY68a+VBff49rhpS3aSDHyAWEeCA6V9C3nTz5eZ5/UhBll9f?=
 =?us-ascii?Q?ACyw18C7a0P/yzS1Vl/3I6MlyxOEVznBCBnVc3xF0wRhD3mNkng5+J3Dqt1c?=
 =?us-ascii?Q?UjSnu6T/Z6BAIYHCy0KOt4kdjBN2vTXfmj5xtfgO5uAfSlHXsUkpYkhMSqmB?=
 =?us-ascii?Q?8Bo7yq9ccI4h/wu0y/NR0TBSGCWL1qqycYjNZtv4+Ff7XYkxt2uHcS7YFDe9?=
 =?us-ascii?Q?kcnyBj3pDIK4hespKYaj4b4RKOJgPPi1geGANQlo6ubktnquRByX8XNyYru0?=
 =?us-ascii?Q?DmCnHxzkez9bYL3bVPBawIua0khBaX7QqNd7ynuTV6t1A/Uf5Mc+c6HJujjA?=
 =?us-ascii?Q?X28C13zHFgXyRSFB+HQKyQu45YDS+tmRwc2tYtFd9/A3daAaao1PLXQxq6AG?=
 =?us-ascii?Q?pnWAOVmwmTT7lrO6q5YF+RwmSgLAWjNe7FQ5Rny8yTy5fJefFxP/RYePUoMj?=
 =?us-ascii?Q?ZYJleiSKBF0JfITVfjQoWnTQ0LosfNrg07/2e64/CZ9yR0HsrnqExaqbm9h/?=
 =?us-ascii?Q?KuwtcDHvlhDCxL7Wn8Rdy3FAyVdrdY4fSS1T5egBunIAc577o4y3Hvs4YhDt?=
 =?us-ascii?Q?d75DlAEMxUlioM/AQJ714tbeBG87wdcf+SBS1aUFjDi9e0rULcL3sFffk5se?=
 =?us-ascii?Q?qThlH8vqpEHyBK5gxY6MW+dXb7/WBItVH41Wc3kg6Q/Is5bLiuWaQwMhTMh7?=
 =?us-ascii?Q?1W40mygRyyaMRse9REY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 23:00:11.1633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a729c62f-1b65-431e-052b-08de26f63a23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

ih v7_1 and ih v7_0 share the same ip block implementation

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index b184e183c1398..6311b66259b7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2088,6 +2088,7 @@ static int amdgpu_discovery_set_ih_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &ih_v6_1_ip_block);
 		break;
 	case IP_VERSION(7, 0, 0):
+	case IP_VERSION(7, 1, 0):
 		amdgpu_device_ip_block_add(adev, &ih_v7_0_ip_block);
 		break;
 	default:
-- 
2.51.1

