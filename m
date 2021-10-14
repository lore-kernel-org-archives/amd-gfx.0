Return-Path: <SRS0=AM0C=PC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA5BC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Oct 2021 17:45:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DA5561037
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Oct 2021 17:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5DA5561037
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7A9F6E593;
	Thu, 14 Oct 2021 17:45:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A1406E591
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Oct 2021 17:45:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bypOy0+HZiVeG/Wseo9P6BTb2aHArrEV223IQuH0x5eCIK1Z5jmjx6U/v0VYd26fP0lN1KGBRaIfJ8DalZOYhOp7ALo3MYoKCJ5omAhHzkiCOQ14JjG3/DrXAMbp9/y7yQys7Ccv6RxnUsd+977FcBqu7BiB55JoZBvb+YLMyF46jyvk9q0F7kW8NgpR/V0/oG7DW0JBdGq9MU8ztej0AXiHk4JxhD5ZevY/myZEjxxeG2tMdXlTWWrDzkH8n7K6Ngzy9h522mVdqjLxsNjy3h0Zfk4fW2zinl/Zeh0FnaAHJZng636axmT0SUOZMF7gpNS9VeOUQvmZJknQzuGoWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxUbqESeGn01Ii10kx9K45lmrlc0JP0Z+beGTa4ZSqg=;
 b=LKyHOawu/be7YcygeNzt0f3vvujLYpuBb36lTL+xp6sShsJYyGI9737AR/pm7yWNJB26BNrbXplTUzYPefzJEBjygsZJIwiUraUJYPdYiB8bxwR79phr9o1wdoCwfE0tYVU4PBY6THuNA/idrbzmSrJQqHMJqi6plSBGUhn536XczYrXSpflDLJhMv8bNTI2udj6R9AKbfQMRtT2UUGXvLcWpuYGSRZgrYZPfmrmtyW1Cn7L0rMl9x/0HtA7jnHG6AnsMJipCMkzfAiVDr2LzgX66lgV48BltChCSoDq2rfqTbJp108Xokif+WxCD06wiVOH3d7sgvNGkBzR0nmuhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxUbqESeGn01Ii10kx9K45lmrlc0JP0Z+beGTa4ZSqg=;
 b=Y1mDWD+nR8N9z2LUWGMnp5uLjRnpk2REIpJQO/uW3KnOhVgg18rS+NLWWyiGp6FOh1Ck2RgvBskC5Zsnmyo0BLLsk6Mmb+oEdu6W+PSJ0gT0zwQBIdhXLRMZxfFacbOv3i1KguNdu/ZCZ2Wd8grjGnhrtPD0DuyU0WJ4gu0C8Cs=
Received: from DM3PR12CA0049.namprd12.prod.outlook.com (2603:10b6:0:56::17) by
 BY5PR12MB5014.namprd12.prod.outlook.com (2603:10b6:a03:1c4::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.14; Thu, 14 Oct 2021 17:45:08 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::92) by DM3PR12CA0049.outlook.office365.com
 (2603:10b6:0:56::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Thu, 14 Oct 2021 17:45:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Thu, 14 Oct 2021 17:45:07 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 14 Oct
 2021 12:45:06 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Sean.Keely@amd.com>, Jonathan Kim
 <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: map gpu hive id to xgmi connected cpu
Date: Thu, 14 Oct 2021 13:44:54 -0400
Message-ID: <20211014174454.3342996-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d0ccae0-5c16-423d-269d-08d98f3a5cc3
X-MS-TrafficTypeDiagnostic: BY5PR12MB5014:
X-Microsoft-Antispam-PRVS: <BY5PR12MB50147D2BA0EE1934E8FB583785B89@BY5PR12MB5014.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /hHyMO7WwpTgokqujmsZ7UzSekuibXTlcEhOazWhinVZfA1oTkdwAmHaNzEALkEuTj7oVNh9whw/IEVj7T4K8ho9D8uT7oMllnTKapF1jJHi3MTtDkcjlNVKjHupwkXVHInbAzoSMTTd/2TCyAzZM3ptgqqRWLQUJgYW2xrnzsaomywVms1mnuYr/aTNL5ietOhKy/OXM5zWSVO6lhyv6AJk7GpoYHIY7GgQfLozpufcj26IP1KAffSlUGR0E4tlX5XqeAO+tjNiBV4bn6yN90olm+QqM9/1Fed2LLus766iCOmdck7WRrUJYQgldJb0B+Hp2TJeLZbyMhwPNTPhKnoSyIpjorTIrYao5pHhN5h/Wkf2rVgkE7FmhcAjwJzws36aa6NtKb7o7m7bsYpvEALOKAUWWfCnfqdWqQPcc+Pc67mM4ZY+do1qxJFFf0MO8PFz8KkI7Xseo0P4IezENbbcUu6bN2XXb1R4fFQBcG7Ar7ULkYgDpdcN4xImCiWvQ1lSyBSQ4tSqpVErC1vmaO4X9bV/HCW2St4Yoe59yvIRV/oi+uQKk1hjm6cP6Tc1E0HEVzBzmfxnKsZPHAh12OCQ3wooeaNM75SwHMnCfLq/mtghZnSuXiqZheXoH/ZwSVSMrifUOQ9ejOM5TOZ8VFqQZukPhgxtdj6zdhMWGEJ0tVtmMSuw2tsxpzd21ajDox3roO1i26hzV3V7go/5GZEEpxnaSPTaJMYOwd9ZVPc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8936002)(2616005)(86362001)(7696005)(336012)(83380400001)(81166007)(36756003)(47076005)(6666004)(44832011)(4326008)(8676002)(508600001)(26005)(36860700001)(356005)(54906003)(2906002)(1076003)(316002)(82310400003)(5660300002)(186003)(16526019)(6916009)(70206006)(426003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 17:45:07.6014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0ccae0-5c16-423d-269d-08d98f3a5cc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5014
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

ROCr needs to be able to identify all devices that have direct access to
fine grain memory, which should include CPUs that are connected to GPUs
over xGMI. The GPU hive ID can be mapped onto the CPU hive ID since the
CPU is part of the hive.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 98cca5f2b27f..d04c48dfd72b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1296,6 +1296,27 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 
 	proximity_domain = atomic_inc_return(&topology_crat_proximity_domain);
 
+	adev = (struct amdgpu_device *)(gpu->kgd);
+
+	/* Include the CPU in xGMI hive if xGMI connected by assigning it the hive ID. */
+	if (gpu->hive_id && adev->gmc.xgmi.connected_to_cpu) {
+		int i;
+
+		for (i = 0; i < proximity_domain; i++) {
+			struct kfd_topology_device *to_dev =
+						kfd_topology_device_by_proximity_domain(i);
+
+			if (!to_dev)
+				continue;
+
+			if (to_dev->gpu)
+				break;
+
+			to_dev->node_props.hive_id = gpu->hive_id;
+			break;
+		}
+	}
+
 	/* Check to see if this gpu device exists in the topology_device_list.
 	 * If so, assign the gpu to that device,
 	 * else create a Virtual CRAT for this gpu device and then parse that
@@ -1457,7 +1478,6 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 		dev->node_props.max_waves_per_simd = 10;
 	}
 
-	adev = (struct amdgpu_device *)(dev->gpu->kgd);
 	/* kfd only concerns sram ecc on GFX and HBM ecc on UMC */
 	dev->node_props.capability |=
 		((adev->ras_enabled & BIT(AMDGPU_RAS_BLOCK__GFX)) != 0) ?
-- 
2.25.1

