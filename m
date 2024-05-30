Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31202C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 03:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38FAC10E319;
	Thu, 30 May 2024 03:47:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KlbeXoQe";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6F1411AFF4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 03:47:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOKByA9XYnK5ZKW5p+p7T8YQNpIT7SQPU4NWoAtaSpO0Y4uLe3eapU1SmaJhviB1fNv3yvUHmFCPEklX67gxHbsPW28t7+BH39INRpGOuF7RLZJm3F24Ud5+5mRk1iF+rHNVk1yPFUM8I8i743XxTkNiuIrhyCGSr9t2UfrGx0usMixhDJwAFe3s6U3mKUZGWa9+lfOPW16lT46sq0c9CF9dZTpGn19/z7vgPSqOdAWoSHtfPPmEXF7Z5P5uYPRkh+ogQFGAwu9Hx814kibbgGVPwtYHkEZU08zXTOpG0vPl7RgozZEuHFVRRjabqPKgKRxRcsHban8H5L9JnvjKHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwIe7/okQAWUqut6VxmlbiKarKUvSBgfc0QEJA4omyQ=;
 b=bsg36bn34jhN0WM5l/Q4UYAlRPbUByNhCjyZG0eKpRhRd5U3NUToWFr82f1sRJmwnekD+HwHNkugHkVVy26wqSimjEx8QYEr6U4mwd/28WATaoVG+XfCDLL4ZC4qvfwe1xv13jwsoXMaV+KCTIg09bG3ITQc15cU2BpLd1IDGVqITLZo5mGA9JujXSWKDed3FKQSBNlcEbPRF25vd6ynEMwiPFlm/tkFIaE2is6/40iH0bXv8/2QY2PfkF61kXQhZF5uqbR91fEb4QlkjJt9q6i0qUrelYAFvPl/E3hDFrbJU/7PrG8BPA1dazrfW91WhxmiQWqXz0LyMj+tcc0v6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwIe7/okQAWUqut6VxmlbiKarKUvSBgfc0QEJA4omyQ=;
 b=KlbeXoQeTeC8L9rarwHv3j8w/pnQ1v3DAXvPZkVUw++cBwwb7HesKJHl5PiPxHmlmN2VmLl6bDBS/qZRPH6DzZFgK3PtmMgMNG3dMJXwvG5WpBh4JYkwY3Ok5j422GqO8P23kvcR5UPdUhO5v/+kTwHhYrKx7iBrDDUBiWv0xzQ=
Received: from MW4PR03CA0276.namprd03.prod.outlook.com (2603:10b6:303:b5::11)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 30 May
 2024 03:47:37 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:b5:cafe::12) by MW4PR03CA0276.outlook.office365.com
 (2603:10b6:303:b5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28 via Frontend
 Transport; Thu, 30 May 2024 03:47:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 03:47:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 May
 2024 22:47:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 May
 2024 22:47:02 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 29 May 2024 22:46:55 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, <jonathan.kim@amd.com>,
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 1/8] drm/amdgu: fix Unintentional integer overflow for mall
 size
Date: Thu, 30 May 2024 11:46:54 +0800
Message-ID: <20240530034654.2341118-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b8918f1-95b3-4c88-0471-08dc805b3eff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tD/eLg5cXpuHxXrNzNmukM9c5rm4Rnl7BHc5dXxhF4Mmvn2ixzzHxuuABYfv?=
 =?us-ascii?Q?7UfRyxWrrTSLPRAk8aljMcn4YyykCsjXZE69rcZeRptHUW1V6dabrfYqpOnc?=
 =?us-ascii?Q?llWtKSxhVGVITP3ytZsJKSFYnAVF4viS0L+rhQoLKueJQ372Jyd/n5X7CiQC?=
 =?us-ascii?Q?mB3uLyYeZ+tXwR3IR5wga0M42Y2J47Y5KrNrL958Qjw82NT1IodeIogbiYVn?=
 =?us-ascii?Q?2WgT1tyeWzKj/dwsCy6hr6Hiz6GTMBC9Yo+ezRwqau5+oQ2ThygJaxnPcIlq?=
 =?us-ascii?Q?WD8e6F2HCKzuED5iqcqWoLefQbBn1IQwm9+o71Fj4exLdregh1/kdSaLKbpo?=
 =?us-ascii?Q?IPvtQPe/xxTc2ume+yqKnrjkZOD4557/+F47BU/ogxtHHiwTFt0JMlm+zEeT?=
 =?us-ascii?Q?6UYHRSOiWa60mxNDCaWJV7qrZlqJq9poExXobkCqV8gUaUift+BpMPi1S1PO?=
 =?us-ascii?Q?xfcuBLDNOdyOZ4XxGYOILo2kNLf8vTmMomDV6pOZVsysm5QXnebU8r1X8OLh?=
 =?us-ascii?Q?SWE8/DQ7ClsanGujq6begbmUgZyMsc3LMlvG5FkA0JaL6Hn3GT8mEhHK2mYt?=
 =?us-ascii?Q?rgD93OYKcIHP1BQkX3LvdXvKlI0lqcpryHpZbg+VyIiKeLlDVU3ZHhecSZAt?=
 =?us-ascii?Q?euEzGUL2g96Vw/awSoM06zzR431ZXFNt0qWMegl/Mi25jhpAQ/PljZRBe5Z9?=
 =?us-ascii?Q?iTEzEIv0Cc0T3pKzYne6703+VWPC9mW6+28CtRx4hr3a1tr4AvyUHVRBhO0U?=
 =?us-ascii?Q?6tBHy3i8xe+iX1KAoOsHcBjNiqrfg7mQLLK0GT1d56SV4XrwvUVAYDBdLQAw?=
 =?us-ascii?Q?wE/esn8AkRx2NIUd4CEabk9Kq8p3HokELz2uualI61AUXauIrQdugGXTKJuS?=
 =?us-ascii?Q?0F1JfZ+9FVvAtSDpaxiXynMiSSlmmJ8Et2WFmsi08/aDShUClHHcPkLV15Y0?=
 =?us-ascii?Q?wb2/0SH8hZktJpQ+ArKv/cYQHMmy+fFKZZdyypCPX/860o0jKSPCLcfrpR/J?=
 =?us-ascii?Q?cLVwyNGy12E21ZYLch/L0vzGQsyDT3CZOdS0ooWNZrm1BkK3IQAi8yjdHIwX?=
 =?us-ascii?Q?VtKjFc30YyNnuoaeHU+Ogo17wy1VnVBlJXTOCfeOmBBjw7jdsJlyecjzclWe?=
 =?us-ascii?Q?l/cB02gw3rr5dPu5TunQ+nyRlwOiXRWK/PcRc44Zv/4+DneRCC/6cmVxud3a?=
 =?us-ascii?Q?DkPstvLorHhXJc3cDFRQERuPR+fwop9MHxPzw5jBagjNKjf5PStTFTcKpBd1?=
 =?us-ascii?Q?kiUWqSw9PndcpUIyfdQExFgPj8ox3Y+y+9WRzFW7759c91x1yspCEqi3doQS?=
 =?us-ascii?Q?AX7C0FZyiiL0Yz2OTSqPKEgZTq1ElgdbyZIRVK94fh/gmsp+F1oUDDLFv17I?=
 =?us-ascii?Q?RPHwMXmQYPX/B7X5jfVBasD+pmLi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 03:47:36.5172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8918f1-95b3-4c88-0471-08dc805b3eff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
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

Potentially overflowing expression mall_size_per_umc * adev->gmc.num_umc with type unsigned int (32 bits, unsigned)
is evaluated using 32-bit arithmetic,and then used in a context that expects an expression of type u64 (64 bits, unsigned).

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 98e8f30824c3..9e0cfe06c8b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1639,7 +1639,7 @@ static int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev)
 		break;
 	case 2:
 		mall_size_per_umc = le32_to_cpu(mall_info->v2.mall_size_per_umc);
-		adev->gmc.mall_size = mall_size_per_umc * adev->gmc.num_umc;
+		adev->gmc.mall_size = (uint64_t)mall_size_per_umc * adev->gmc.num_umc;
 		break;
 	default:
 		dev_err(adev->dev,
-- 
2.25.1

