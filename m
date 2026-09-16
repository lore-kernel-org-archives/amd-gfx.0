Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9116CC982C4
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 08:44:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C9F110E8C5;
	Wed, 16 Sep 2026 08:44:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nX5batnY";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010015.outbound.protection.outlook.com
 [52.101.193.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9290C10E8C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 08:44:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZI5oAVcguLq0YmOVLshtVnfbw2YBKT9aqt1ZI5nSS/JUJnk1vnvpQwb+xse15iYCJ0saKsu6aqr/uvl9KYfLfq8MXCzrOMnT15OCpoHR6fT4BGOCz1jNr4/J/HIdIwRSyfr15djrFspnMY3lTVIpWZFsFTfzsDhMOQGKmT1t9KOlVSbYTvXMvvKEsSbTC7DIoNCFTgZBf+qe+Boas/IDtoDxzDUhDGdLpGkx03bUA76Tz11eNsjNa4OQk4RuBgy5q+pxynjFLgFAwbH/q6BtkvaonYLS8QiEtVfhmX6mNxZFtO+dl8U7+ZD9gioAA/b/wVdpmQiOpOh2/EVa3jKWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qT2BnjgkkZMaY5j/DOd7mqzakn3VjvlvVhjikVn4pEI=;
 b=xQp3n0HPoFxTXxrkPPgwbevAtLwlG2OgLcPpYhzZsQaNjvtLuKPDxa7aQ+edWjLuBIYc8z/xNgCKW3XMXCDfpn7yhb5Nx09r6m3qoDfmTmIkT7O8tIA2x4bQCF6K7R2//u5Jnnxq9Awi57XTTZNaZ+oJc0QErjiKXcVD0EimQvXKK8wAWUE6g2vtVrWRFjrFJ3u/sndY7gFy/cvt3mqt0y9LzVuqQNdVFNY5A34KeZim4+xipxFIDMVKlFZlNliIIFhlYU9cCnpdLlXJUSqMX3aF1MF9tMgyXPRkvLAlU/DyPhaRX8Nt+Zt0ujM6NlO+HqdhBf1UjqQf5aupj3Fwrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qT2BnjgkkZMaY5j/DOd7mqzakn3VjvlvVhjikVn4pEI=;
 b=nX5batnYeUVt6dT/TC0qneULj0eI8qvgfx/H1i9/vfLAn00vRN7CTD5GfFNGG7UM43C5yAJnzsetL7iYH/apxhR0PAf6Kr4w0PMEmJXBYM6tyQyA7ZDMSaGI3vsV9fJJly9q1+iT1cTYdi7Fv/f40gNWj2tGfst1YS8sAL4Vix8=
Received: from CH0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:610:b0::6)
 by DS0PR12MB8044.namprd12.prod.outlook.com (2603:10b6:8:148::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 08:44:35 +0000
Received: from BN2PEPF0000A803.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::8f) by CH0PR03CA0001.outlook.office365.com
 (2603:10b6:610:b0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Wed,
 16 Sep 2026 08:44:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A803.mail.protection.outlook.com (10.167.245.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 08:44:34 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 16 Sep 2026 03:44:32 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <Yifan1.Zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH] drm/amdkfd: Clear user_pages after freeing the array
Date: Wed, 16 Sep 2026 16:44:19 +0800
Message-ID: <20260916084419.2404075-2-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916084419.2404075-1-perry.yuan@amd.com>
References: <20260916084419.2404075-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A803:EE_|DS0PR12MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bcaa183-cda7-40b6-8696-08df13cebbf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: zr1lXa2maRx9O+fb1WilAFod4drS9zhDBNY6TvaSXVaJqHwkxlh1SXvd/S2vTc+qjt5K0uO3Ko+tV96pueL9NUrc4jibqoIMs56lJTS6P1GEN8Mw6dbK7Qw0q1BEjtZWwd7rDLrKJRL4uIBs/wMuEZF2P4dSOs33NoqdO7Z44AFOO9BJ7/Q+lKKRlu2Dy5kPTjkkK4NCfxgBtiMITQvJY1j4Yi1J8pZcgjEkP7t3gorwtJFJ8Re6/kRMnmGIj6gvTrUMLzwnVIFcUscTjgBw/CbR6SqNV8zAi+pKETtJh37SJW0/riKwqXAcD/45Dhtn8BNcF8LtVl3t9/RjN/4bh/Lh+LulztqOV5JyPY3u9PSCJh+2VMbLD88esznHVQengdhScMF8lvW9JpRfDdiwH98n3ukmZxcmL8SH/dNSphzWqZvlhdO63SLmrfceI7EriikC4l/+5KDyQTIa1TSOguimGSkr29zaUBukT2sS4ueP8PMTbCjYMaItoqs3oOJbq5Min4SmGrPE3CXIf4Y/2a6LWNj6726zjY6t/dHaLb8F85YGmFPH8xhZNsL+lp0sJh/+N8dX+kOyotdVuvdTym7GEmHrMoiWz2lMxgK77kIHzG11mq3+7m69GkHrFubi3SqPbNSOqMja1u9lcpNXVF878IFkWGLTHYGlPVRM/Wwp4WutYW7rayaUAJjI/EOSmm0OV8JOVUOU2hFFwcOx/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z6zbRURq3s/+pnSxLGjidS+qgAahc3KUkS7vzkP2yiW9lUthpRwsMAiPIdGRjEudhg1kdr2D7iLPwS58ipBof1Nz2U1Gzbx10In1RfJZWhBkCefI+oKAKUUdEYysYxbpLtTvQkFyY7nE1Pla2bzRqfv96u0falDXtgiYFRFsCHR/Iq5kshFl7wtyB0G4Cjzj3Z4Ht1OFGoyUfjrLziaQWMG8BrtOxhSyHUVqMP8u78B/j5J2ie2oec3UPlmTYXgzqA3dcexUFpaskv1vta7eFSTUzvuEW5DLPQcO+2XHOrRWKitfnDC/YlN3yDk6OLmatmrIV8UpCDrOroj/U6GAKPJPM3EmSSPlVW8l1GGDGf5fzXc92tVI9/Ut5WGjOQweLWWOhQ+th6KVfemvNsyYIb50NCAt8hJMvP1lSKyz79DtZvtMgC9awWNVhhFmJThl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 08:44:34.6952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bcaa183-cda7-40b6-8696-08df13cebbf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A803.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8044
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

Set mem->user_pages to NULL after freeing the temporary page-pointer
array in amdgpu_amdkfd_gpuvm_free_memory_of_gpu().

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index eb09d6f3430b..ead3b01ac808 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2068,6 +2068,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 					mem->bo->tbo.ttm->num_pages);
 			kvfree(mem->user_pages);
 		}
+		mem->user_pages = NULL;
 #endif
 	}
 
-- 
2.34.1

