Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D811C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 04:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1D9310F153;
	Fri,  8 Apr 2022 04:02:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CAA810F152
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 04:02:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOxSs64yjF8aA20ng6HitQ1BQ1wWOyp+UtbJynbTHMiOqWDyjwLZ66ICu4eRWg++gx13CedvyGNA9wTQfuCmeixiXKM4n1blCGLVsbPvyKYcvYDnzWII/a8lZ7Cs+pVuYJzpwySmInNp3NNG7B6sCR5KTry1jC2kfq/sAwqvF8Btg4ll86IEvqX5b9NHQ3ig/La6LCJibCwY4q0Ey1xxHoY2EenOqGlWOvDMM3AxHInuFNOjy0F5Jb+0vlx0OAZwtryAoBReJvAPWwVj5tTzIXoDbLP1JOt7qPsqGYjLeq12a2nuVsUfKlz/hAYSbv2j981D+oKnCSVnzhXCJZ68eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4F4q2uYncz/s7ku5XQtwBjDMhtOiJwV3GAd/5BccWyw=;
 b=eNwZ7ujKyvfXA5zzK2ctXJuC+M/CdpKNTfAEhxN9Ieht66vFHekMvcv3zCBARCUPGq8nSJP+JqnxU9rZT/80Ms9H6zEeUz3YVHYsy0xrEnKD10L3NXUs3kalTGaCjYRuvkPWctG1l4ker2nfxxAAyFJ0AR0M+AHtVxS+Lv/fFgV7X1ddqhYYtAcAiguMcUYbyQDDC0UD68OzErjc+vCiFn5s1W3+c0UDtsS6ohHbb1mtgbqsWiQ/qwNGrEixfAV6oE34CJKBdpkXLXY+zasBqvjQJzeSQkG02CzAyGHfM6X8CJNPwHoHfLPGZgPIjajSfdhjfpTjOAvGtOMZDD002g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4F4q2uYncz/s7ku5XQtwBjDMhtOiJwV3GAd/5BccWyw=;
 b=JdJ8Yq4KemkX8DqNkYukXn5H9LRdnHfylMDH2gMbh9YBDu0xr0Fh0/qicL5knffCxF2cz70z0SbUkP6K0e/27zQ9aAqH6IRiFHYhFpK+U0ydAQBJQBqxykbuM6f9GzNrgAA5+Zl97W+CW35uzAlgUZfLxABiO9+BLm/IZ8T7N4A=
Received: from BN9PR03CA0916.namprd03.prod.outlook.com (2603:10b6:408:107::21)
 by SA0PR12MB4352.namprd12.prod.outlook.com (2603:10b6:806:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 04:02:44 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::e3) by BN9PR03CA0916.outlook.office365.com
 (2603:10b6:408:107::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22 via Frontend
 Transport; Fri, 8 Apr 2022 04:02:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 04:02:43 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 7 Apr
 2022 23:02:41 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Use flexible array member
Date: Fri, 8 Apr 2022 09:32:24 +0530
Message-ID: <20220408040224.125878-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cb2a999-e7a8-413a-974e-08da1914a214
X-MS-TrafficTypeDiagnostic: SA0PR12MB4352:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4352D0CDE90782052E6FF8C597E99@SA0PR12MB4352.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1pIFJ1KVUJuqDBK0gqz/s4aqMmDziNva4oZ9+Feu6dVaALy9vZa9mfpheOzTP3RvDEylSXlG9GTLxemMWm/S7L7r+w9lstd9SrpwbQxhO2ZJV2goJ8kPqv3i/9yqzi1c/0534AlD6jNwHOawhisy6FNazsZelmI0E9xR872+eLDoLuL3Ypzvo8cdX9/cVWvM8A7yzEsFQCCTYHkHy2ql9+I0k58VzJ30YzOCFdplkHWLbljH0+9v1dRwhHHX4vbzkfbPEUwNhXePGKlbDA9vrea651y6ZK2w6TK6aIRmvdl4/lp2g7nQ8/lYtqz3mRVxIbkrex6/qIyMbHy7g5zjDQj+5VlWFtkMsS7+kkFikScjLlwVCClK0inLg4ls16uDrvK79RMICCXOizZNNL4OVV35zlEwyCWjXsQIHJDq/6I78+WGzrQpxbwbVEd2cXnANASdTHy3wYAxoWl2gGxqAVvFlA0Jhytkj+DBNrQu7FFGmr5pl7PUuL+DQgAX43zhhXTo1VvesBTn8L+AT9or3z8uFUg4OGPQaYMu2lenRlY9R2mClWPkQeADV3Hwd18uOxY37AzWVgzZe9gi+SWrhH4oZNWRKNPVWkH/CFRGSmwsmQmJpmJOxxTIEKZOh10I6yBy6AXnt2VBzxSNS6GwcXQJfrcG7Ml3Uq6/eS7nyee1lV9Q1onxuL4aohTM2cUtNun6buHSxHU1m6bWlTDVCEUVOYJIbQDsXOHFKJzwiIs9cqMRWvDTFJ+kKJm+z4aLjLSPz9xBSIMyxH6iDyfhjCAzZ5iSOcULY1vkNkD/JW8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(186003)(426003)(1076003)(26005)(70206006)(16526019)(8676002)(70586007)(4326008)(336012)(966005)(81166007)(47076005)(40460700003)(2906002)(6666004)(86362001)(7696005)(5660300002)(8936002)(508600001)(44832011)(2616005)(36756003)(83380400001)(356005)(82310400005)(36860700001)(316002)(6916009)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 04:02:43.5020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb2a999-e7a8-413a-974e-08da1914a214
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4352
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use flexible array member in ip discovery struct as recommended[1].

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
 drivers/gpu/drm/amd/include/discovery.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 5a182288391b..b577fa1d7ecc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -430,7 +430,7 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
                                 }
                         }
 next_ip:
-			ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
+			ip_offset += sizeof(*ip) + sizeof(uint32_t) * (ip->num_base_address);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/include/discovery.h b/drivers/gpu/drm/amd/include/discovery.h
index a486769b66c6..b25026c3ec96 100644
--- a/drivers/gpu/drm/amd/include/discovery.h
+++ b/drivers/gpu/drm/amd/include/discovery.h
@@ -93,7 +93,7 @@ typedef struct ip
 	uint8_t harvest : 4;      /* Harvest */
 	uint8_t reserved : 4;     /* Placeholder field */
 #endif
-	uint32_t base_address[1]; /* variable number of Addresses */
+	uint32_t base_address[]; /* variable number of Addresses */
 } ip;
 
 typedef struct die_header
-- 
2.25.1

