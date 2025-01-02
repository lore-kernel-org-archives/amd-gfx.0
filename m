Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CEBE77188
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2025 15:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC2B610E719;
	Thu,  2 Jan 2025 15:01:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T0pqapUF";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D11C710E716
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2025 15:01:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duUxH8+3a+j8XM9SUiZix01ae0Xr+CGr2qM8csz0sbduYhhHg4b0Dkj/vX+piCijYWLzKleBNPfwuCezlaInAJSuG4gSolJHVypZuXAuN71jb8gBhvBtIlhlTdhIDdDaQieqtcwKSY+WxVuX/7Ez65TGhlXCGk6q3xwMhy0vyFwepCMLBvQxRcWczFb4prRfPzObyaQfgtn59e15eCdK6vxayYA1rgbZutdiRtWmeUDiSGHVeeeiR6xYNqgSXlpwb9/KF8aBd0rnPBQMSvGjvmwaCZRaYkGpnz0tKL9W6+tPOH0m7qVK5gMw0u7lV7CG96YARB+4EnRlVEYuYUHZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQsUIk4hrUfQFI5JRh97XK7LVQVB/9VPgvkQ6A1Ie/8=;
 b=u/NRdy7lhUlk1OngULoXfJbPs/gHTZiA+LouXcyfo752rW95RZI5eSwC1+PvPxg/evvDx7WPJUDp8ryYvYvlV0KygM60Pf87RX8xgxLdnnWyiiM/LG0BeGrNVR/pILdpcjiJoYBHnsiGuaixqUV9rmg+jIctJiZUCwRjZ8jjggWnWiQq67kXTHb2nEd11bM1z4RA2xUkYdIo6Raet9hPocBqvY6Em9rWRp0QaET4mv3Y35F49MNjIsIVYDZsJujaoGOM687bgtzhAflxNGzrKdu3ZMjzcKYyZXlnJDbjnMsqpWPM70Ybtfs3yo9q18MudZcKl43re7e63Ly7GPI6BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQsUIk4hrUfQFI5JRh97XK7LVQVB/9VPgvkQ6A1Ie/8=;
 b=T0pqapUFs7593UTcry6WRtLC5LoYR/9W3TWbI1NjBcV0ghyBBnR3CfnwFYUAHCVazgQdIbsML6/m2WIWvydw+O1HCG7I0nDWV2MeOggD8v8SUHMd06VK+bmcnRHfIjOjL5s9u6O07c/EenvEuO6/pCM9SsdkfousmF1GyGaCGW4=
Received: from CH5PR05CA0024.namprd05.prod.outlook.com (2603:10b6:610:1f0::29)
 by DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 2 Jan
 2025 15:01:34 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::46) by CH5PR05CA0024.outlook.office365.com
 (2603:10b6:610:1f0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.5 via Frontend Transport; Thu, 2
 Jan 2025 15:01:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 15:01:34 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Jan
 2025 09:01:33 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kent Russell <kent.russell@amd.com>
Subject: [PATCH] drm/amdgpu: Remove unnecessary NULL check
Date: Thu, 2 Jan 2025 10:01:24 -0500
Message-ID: <20250102150124.1323685-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|DM4PR12MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c4dd473-93dd-4ab9-b81d-08dd2b3e594e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8ubK3+/lJwLlscvoaKXcBG+v28j7QgXs+UPOyMRNIR9KqyFrsS72gWlkg/Nn?=
 =?us-ascii?Q?frb5mkkw5WCLU7QvjCvDdDPgb3rhuE1mXdc1wER2OohxJv1n09zsxNQC0cwQ?=
 =?us-ascii?Q?9+kPGBB11TACkSy+FzCgkV+OpSHCok9ndVXC0yDi1YZowos/tfSgkXbEE6mQ?=
 =?us-ascii?Q?jFb1B+x/zGYeFSmS465XyoC6Md1GbSclJ29by0KuigHKjTHz0Btdn0u6ugRg?=
 =?us-ascii?Q?R8pqzmSWXEL5VwAyjUEHS5a0gE4aO7Kzzs+FcJ1k7+ayqf1HOgYv+pCNKJQV?=
 =?us-ascii?Q?lS5WrAUqKxE4abH5GzlPHQOSt9rsk1DlwVWT2IjZLLZRBQN9MqmyOG6G8Ed6?=
 =?us-ascii?Q?W562AgdbV2PNZ9faDLVVJ2G83TZMdW/AbuM8QGkEQrlRJTIBvHLaYy5cDUZS?=
 =?us-ascii?Q?GW9at7rPczGqiiZrpjLJpjKoJSMGYPuDLjNY0GvlFuFBZQM8+Fr9HmO0/DhC?=
 =?us-ascii?Q?U382HpRNvlJVXcSi+64LoYrRksWdoxPQ9t6gwNf/gsu5u68RahNmLv/TuOvS?=
 =?us-ascii?Q?9YNvue8n4AFhZ1ZAAP21hbD20syYZ4/J4eQBx8GeSfUQEquIxbRUNibnOmU7?=
 =?us-ascii?Q?Nhu8sipoDsFfNnNA3fUb4VxZjP8eXzG6bRnO4s2ybYTJBHbNc0zg2L8I7Jzy?=
 =?us-ascii?Q?0qeQXjquXf8fzhb2BkDZ5SsiX9J+ZH2oIvzwevQ4pdw21En/X/FSeZ8gvfWK?=
 =?us-ascii?Q?pusFGLuw4ma0lkncsOaKz7xYKutaqYgzuhh9dV5+plDF2fkxpyziKb1cVlt0?=
 =?us-ascii?Q?Zi1JUk2FGBPtH5mtJM1PGLQcviu7fqO6IiTVEK6NM+LKoPsgM9UoPxn2EfRp?=
 =?us-ascii?Q?EKe3LIBnujs17rATtrCVPXFExF7BasAjXhC9S+ZL3kqKBfND1VptbKgiTm0w?=
 =?us-ascii?Q?9l4JquD84fyfaw8kvQ16Hg+v+Tdlhoz+cnoz1FS7L9eGyPCER4eEcnelRxov?=
 =?us-ascii?Q?R+IgYmhIMyBcXwAgaB1GPb7419OHzX1SlhOmMGiuw8ADR+z6u92sues0BwMS?=
 =?us-ascii?Q?DaUGNTsAKqbd0/t4VLFOl7/wOzbvZFWGwxiBAPgqLe1hf89zJAUlybrL2+DB?=
 =?us-ascii?Q?uT2z/5KfHoVfmry6XlZS68TIyvf+hCBHYc2WLEAnfgD11gyitKNsqpCq2Smw?=
 =?us-ascii?Q?B97K9xCNC3yfeBrPCGg7kqvQZtoZLjbRvyaaaUnsYCCZOiiVoc74wqLevj9X?=
 =?us-ascii?Q?/nAzFneNtGCnpjzSqzVCQLOsQ0iSMfmVhGPBc1CBVLYrpyG0s2usuVVG5fh1?=
 =?us-ascii?Q?CdGl5mcQc9CvnmHXOVhqHCd0B9RwGrgfDTYcdFQjj9pStCKf7gd5IRbumc3s?=
 =?us-ascii?Q?ugdfHrepLqkNuUVLPXjHBb7wDVtFkSB+kVUqcvtxe6gBci1NmEQ09HMDCwgx?=
 =?us-ascii?Q?I7edZ/vD/JUPOmX2eKG2vDpZsT8OulldUTOmx/APbxWrkJGD1h/NfALFeEct?=
 =?us-ascii?Q?pxE9Vz+67XE6AuUe71FcDNEqR6iw5IX3/d8lhKRO5orZTL2Zhw5wf1DbHcC1?=
 =?us-ascii?Q?Mdro5TxXnDg+hQs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 15:01:34.1682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4dd473-93dd-4ab9-b81d-08dd2b3e594e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6063
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

container_of cannot return NULL, so it is unnecessary to check for
NULL after gem_to_amdgpu_bo, which just is a container_of call

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 7edccb675921..a1691ed717da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -196,10 +196,8 @@ static void amdgpu_gem_object_free(struct drm_gem_object *gobj)
 {
 	struct amdgpu_bo *aobj = gem_to_amdgpu_bo(gobj);
 
-	if (aobj) {
-		amdgpu_hmm_unregister(aobj);
-		ttm_bo_put(&aobj->tbo);
-	}
+	amdgpu_hmm_unregister(aobj);
+	ttm_bo_put(&aobj->tbo);
 }
 
 int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
-- 
2.43.0

