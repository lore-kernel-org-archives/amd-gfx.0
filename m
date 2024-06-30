Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1600BC3065A
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jun 2024 14:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B278910E0C6;
	Sun, 30 Jun 2024 14:41:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2JfzKZHd";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D83E10E0C6
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jun 2024 14:41:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjZSkZfMscMg7gM3OyLdwcfA4zPwExKXLc62+tSPGV9fhRYoRX0Od9vYPezDoT74OaSG3LYBmuLb09D4qry3K+zlPyPnrvcv7no1sRUByBTZFVZay+kv2qi1QHuiPIbSNoEFypDt3727QVD/M+lCU3OIXBXHNSkmW7moYsRxZDZ1xWE+rwBBxNraF97T/q+ymh9b/UvdrwfA6kfi/LPJQdVjOZ1mN0RMlzfuOAI4+k1Hu4RiQ/kKfezxQ+X8+EAp6lm5I5PNT3YI5S73LWQiColmXvdkHrgnUvIlmjtIFRF4blwsEaOtjaloGTnUlH7yttuGBUWoZ+CPg9IavGpMmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kXmpidraeb4eg1uMXXpZWNKTO38ZJe1Na9prD5EVnM=;
 b=LTgpn8RCLPis8z5P9Zz5AkNdFkLTm2OZwCYOKWoF9+j/gXja67qbMff46WfrvroX59vrF7VdZyA9rmJOR+YSTc3ZPy3COayVFDtu/AM0E02m9rbxU30uTUQbGiBiB3IwuK7Jn8H399jLy3t88EOQR81WrBq7tl+7XHp1klBab+2He7G3xb2st/whiiEHFy+O2fjqTJHFN3ZMba+meb1zWl/rMI7lU+Mo5Mbk/u+KENupknwZZcs2nQ3qvojZLthFZb2XV16RHYdBf5wPd7QUTn4kk0L4OQ84Vpq6YkWkNfAoH9x6S2aX/RejOk3ki+aHtcFq+4q+W8gPa9geOx0j0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kXmpidraeb4eg1uMXXpZWNKTO38ZJe1Na9prD5EVnM=;
 b=2JfzKZHd1MX0UZX9wn5KtMi8gt0zXg5U+YaRzewJInYZOxK9E3EHkuDBsc5Aw1Hv7Nuood+teZkrGUl3QhrdZ7yhwTvgzXc/PZGHwvkEMjLHPsuAeAbrtqUO65qUuA96ff1eJVMQA5xY5uKQBHwiZ/ektN6fxE2PzXGXW5z/Stw=
Received: from SA9PR13CA0043.namprd13.prod.outlook.com (2603:10b6:806:22::18)
 by DS7PR12MB6046.namprd12.prod.outlook.com (2603:10b6:8:85::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Sun, 30 Jun
 2024 14:40:54 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::a3) by SA9PR13CA0043.outlook.office365.com
 (2603:10b6:806:22::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.18 via Frontend
 Transport; Sun, 30 Jun 2024 14:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Sun, 30 Jun 2024 14:40:54 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 30 Jun
 2024 09:40:52 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Tim Huang
 <Tim.Huang@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>, "Veerabadhran
 Gopalakrishnan" <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH 5/7] drm/amdgpu: add GC IP v11.5.2 to GC 11.5.0 family
Date: Sun, 30 Jun 2024 22:38:34 +0800
Message-ID: <20240630143836.2015991-5-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240630143836.2015991-1-Tim.Huang@amd.com>
References: <20240630143836.2015991-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|DS7PR12MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: 026f7182-b615-4995-815d-08dc9912a57f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ox+IZ2aFus3Vn6nXoBixS8URbzStMrg+me7S87RCwD2amd/GirVcwACSY9MO?=
 =?us-ascii?Q?Vp9Fccn+IQDjBn2KrTr5sgLvFWZg45+6C/ZAfP/akU8Z6NRLmf3CRzXMX/JA?=
 =?us-ascii?Q?tX7TVeZCPqK9EkeMYoTYc9hdZsevZQDHzCqm1C4Fr88txLIFvDKeffR53V7U?=
 =?us-ascii?Q?F05fGRibnhDBINMZDpxv/M0t7gRAsLSJS5BJQBTfBWVpI1wxXqlDyGyQCIXX?=
 =?us-ascii?Q?XRkZZfmKB8MchpbO6bKuK017A2Ot1NEjyJCjIoPtPC3FNDcjJgkmzuhtUe+V?=
 =?us-ascii?Q?M1s4CyYZapkGqkeCYV81kVtARMmqK9EHD22Jb6SDisM8OAzyHHGrMIxWqSO5?=
 =?us-ascii?Q?AdALxu0EcJUIbt/7vZo9gQ8WZmRwCRPmR7SmP+TSuDBbgD3BDyF1fpoTwdXL?=
 =?us-ascii?Q?/qdkfLetL1w2Ec5bCik1NuWKv2oOggvVx/bJQbmZ/EtwMD+q2BO36SIJrtKp?=
 =?us-ascii?Q?7yikpjy2SEqjhF6BVDpDfbg+FLHrjbWNozyrLG2qim6DVD+5ALUN6xGfHtVN?=
 =?us-ascii?Q?dBtmBA3PCvNxOUs5DSbj2IINljhGJVZXDpZl8o1pK+U8FP8KHJdm1arP7CXf?=
 =?us-ascii?Q?gcQrMBrYx+7x7/8O/Zqjo/oHZZjYZWN5RkIDQKqdQbNsNjcsx8YQhvjGudVI?=
 =?us-ascii?Q?jLeesZyEPAduri9OhR8rBBEHSFmWZ41BaBGmwkVA0XEdjZ/UlMOHSiUXk9z1?=
 =?us-ascii?Q?zYOIrcoaFBRqaJr7q7FsssptUBAkSOuEorLEwsX38coRnTYof+Ud2lZYL/rQ?=
 =?us-ascii?Q?IRuKmVNTQn8uPrNsaq06g0EokyDpN6cMYPQOZf5WnjCPUJvCIH1DQJgNu3CE?=
 =?us-ascii?Q?JiT5jVYMWZHHr+l4EURvJpqHEWJO3xT4q69+tem0GfnOddFvIuBsK8JD2Iqx?=
 =?us-ascii?Q?okwSJGGUprZtHoczkKOptRu8PBAP3MWxe/010UJD9DOndIMAFPHtwhWxe1zY?=
 =?us-ascii?Q?HnArkOiEsuy8HQnobcnH0T7THd28E3EbO+Je4AURbiMdjlMDcVcdbVrVwYHp?=
 =?us-ascii?Q?m/Yb+mcwzefmpAd/7TmCWgMhqocx5Iu3YX5z71Jn6j6eKuPIldmrVoW27l8B?=
 =?us-ascii?Q?LcXtfKGNevzOCmN66Gq5Y8dG3SBZu1nELcuiSzBEI+OawCR7U/iLjuaF5j9t?=
 =?us-ascii?Q?4BwPcESAQdZZxvredmb9wJat7O1/zSbjEVdlitZOuYeng3YvoItN7dTFzidr?=
 =?us-ascii?Q?IcfwIksNTYXWNSI0vRM6UOTpjflMe3OMlXPkET7YdyokzPLJCQMEl2Aumhj+?=
 =?us-ascii?Q?JPq5WtWOG7sic5QmZRPd/LyCh3feLpFRgvxyhfdS/J1own4kwNxJC6nRWTxq?=
 =?us-ascii?Q?GMjr4SYes82Xg1yB9/CuPeSvLqzM293B8XH8xG58C0mUcveeZB276VD22Psj?=
 =?us-ascii?Q?usNQx61iG3/KG0E96xfCnGQ89ML62ZJZc8/WHddk718A6ducZIoSRnb1owzt?=
 =?us-ascii?Q?dqbuxS/TY02Yy2UhOmHELAAqi6m3BESf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 14:40:54.4044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 026f7182-b615-4995-815d-08dc9912a57f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6046
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

This patch is to add GC 11.5.2 to GC 11.5.0 family.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index df753ebfd109..39f29de6ed36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1808,6 +1808,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 4):
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
+	case IP_VERSION(11, 5, 2):
 		amdgpu_device_ip_block_add(adev, &soc21_common_ip_block);
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -1861,6 +1862,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 4):
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
+	case IP_VERSION(11, 5, 2):
 		amdgpu_device_ip_block_add(adev, &gmc_v11_0_ip_block);
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -2152,6 +2154,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 4):
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
+	case IP_VERSION(11, 5, 2):
 		amdgpu_device_ip_block_add(adev, &gfx_v11_0_ip_block);
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -2323,6 +2326,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 4):
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
+	case IP_VERSION(11, 5, 2):
 		amdgpu_device_ip_block_add(adev, &mes_v11_0_ip_block);
 		adev->enable_mes = true;
 		adev->enable_mes_kiq = true;
@@ -2632,6 +2636,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
+	case IP_VERSION(11, 5, 2):
 		adev->family = AMDGPU_FAMILY_GC_11_5_0;
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -2656,6 +2661,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 4):
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
+	case IP_VERSION(11, 5, 2):
 		adev->flags |= AMD_IS_APU;
 		break;
 	default:
-- 
2.43.0

