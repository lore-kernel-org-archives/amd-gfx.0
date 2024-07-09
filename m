Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DBAC2BD09
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jul 2024 06:02:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 893BB10E47A;
	Tue,  9 Jul 2024 06:02:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vzKcp4N/";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D85CC10E47A
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jul 2024 06:02:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJQ28AMBsohvtzzrS1cUL+Kv1Csc9DbqzNt4gnBxUu3L7y0pPGS1T3GxAKUmUXwEnS6OKpbicdw+NFyyDO2RbRZ9bZODmJxsw29PfhbtFzyMZpNjJJfbWdwJRM6j9kJHMmCWGGo6RS1tn6q04rs0kaE2WGwihGEKGVE1khgLnb+e+NL9IyRIqKp+5S39t8Q8urC4FcNvSxabIQCPivMHVS6Cyw6w9LasWgIei6YokTXjC+FlCTIaJesOWMz1I1gIJ45z1vi3JUmcAZHR7KTpR1t+///MnOuPHHVoRowO2taw8eTo8icvzwsSgLechvylNaOy1bH741AebTC/tqvvhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRzDhhERgD6mMsD+zgpdPkpG81pEued6BCHnVDLjFbo=;
 b=n+W5xw85vZF8OR6mSWYoeQZGIQXqMN6Y9I57EslRCqqwWFx3wjonGRFFyv/de2h4756N0+3LO4KgfqF6sxpN292Zeex533wlRfTseEBnmTQbQuSQz3y3GvV5LtbHR1SWsCBHYW8lAZeocjeD+VkyHYybCM19vHHnvd7qFpUJtk/SIbSTnoCvszSr8Sjv2LZmttjDwDNGaVUvsVeoH103IqaqofvIvX3mLOC91ASOUVCIoNgwJzZ/BDngYNmVWF7qFvbqXxPiPN6FzM676DjVtMAIHpmwLbz/u/IFF30bN4mBvYPoNUFXNhct9MoAQjx62Ows2X4YuD+NFrNtLFg3lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRzDhhERgD6mMsD+zgpdPkpG81pEued6BCHnVDLjFbo=;
 b=vzKcp4N/yxQxvTkSyRAjK6YViZsF4QhYevf8//GZvZcc1X8cnGTfuAm5TYkpCEIofKekUNmus0p/STH3cCqjmqpEF/YzmpGzRVh4NZrZY1PeBPF1hBkOkXFw8TskNg62Raf8J0/RrPQ/nmDhX+xraR4CbuC5c26wTTW8YdHCSXM=
Received: from DS7PR05CA0058.namprd05.prod.outlook.com (2603:10b6:8:2f::11) by
 SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.34; Tue, 9 Jul 2024 06:01:57 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::f3) by DS7PR05CA0058.outlook.office365.com
 (2603:10b6:8:2f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.18 via Frontend
 Transport; Tue, 9 Jul 2024 06:01:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Tue, 9 Jul 2024 06:01:56 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Jul
 2024 01:01:52 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: avoid repeatedly executing gpu ras reset
Date: Tue, 9 Jul 2024 14:00:42 +0800
Message-ID: <20240709060042.53689-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|SN7PR12MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 32577ba7-0593-4e19-72b3-08dc9fdca398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QKWZzC6I+exPECzDlz3zC6BCRyS8FkYPqcJgl0APmwGAf4wL52lLCQ5G+jON?=
 =?us-ascii?Q?ULtGsDW6BpoYnftKWvPXgpNjrOwDR6k/NUjUDPOsFZWU1363FwH7FBdnd6h9?=
 =?us-ascii?Q?ZbKwFiITxqK6HBZHB0l8hnXAdANI0/uzsdVDeS6wS8RkM1lVuQ7ml2y4lZ+b?=
 =?us-ascii?Q?6EaxSvTaigAud9fFNFiycYmvH943KAtil3sK3Das4AdBexr+JLiScJ4OZc6Y?=
 =?us-ascii?Q?14SLOTi3wzmJh3XhimExPXam6leZ7S8FgJGOl/IdtEHo5h1U0P3kOb/kpoYL?=
 =?us-ascii?Q?HCQ0uKiJ7jLF9g5QN4h80BiM+ULDEWWezVkDDhRjIz8ZlRzXZUq9n8V3TPfH?=
 =?us-ascii?Q?/UA+Zu/CmjZg2L9ftBDAjIWXgNm4SGmASeC7jdCauzk4u4+8252nr8IKgmgE?=
 =?us-ascii?Q?aNNDiwacxARtWc3GtAwtSronnkdsp1I94R6d7pLxILzLyho2gOWM3eJm7ni8?=
 =?us-ascii?Q?3o6d/o5oD4NxOPE7biVbkIwqvWxafwT/t4Q6TDI90p7oWF2f1YNAfvtwiGwz?=
 =?us-ascii?Q?wiOrpS4jIFlcN5y5Cc72yGcZuAvbEjE15+8hxOL1TlAqJxdJoYWteHI7DP6j?=
 =?us-ascii?Q?D+Hi+z59Xk00Vb1aKJ+xPtrOrHYBRqsUHwNYM1hlIFTiROO0gTsnJpruxEIe?=
 =?us-ascii?Q?brZ9dngTsVp/jAp1QvCrcdW3aItjAT5wWRnL2ryuUrUOEizecSpUVtQYq/qZ?=
 =?us-ascii?Q?FTpUNH7fw64VFGLsTYQeyR6mZsECvqyaBWHp/Burg4JJ4v1oE/jjZpg3CCGF?=
 =?us-ascii?Q?yCsbTMPrxgHJZXm+4Q3rbUTiv2WZ1LfxJK/9FOU/xN7szOqdaHoGv6V8RlIH?=
 =?us-ascii?Q?pu150gclGAAmB+ZKQlAiH29irScLWCyJPXe7LWsMkdC3zSUXWABvcRNnW2UC?=
 =?us-ascii?Q?bYMpcP7qa4QcDn+g7dn9bLT+9vRpxdeqzzvgPiO+RwTWilaro9xwQ2fWj5bJ?=
 =?us-ascii?Q?tmAlxFGNfbAS/IO07GrUQlIw8ntlOSbdypMTMXz3c2C0gtrvcnBddrxed04U?=
 =?us-ascii?Q?nLmcKhciZxiL7b6rQ+18uZVZDCdFrH4HqQ4DRjClNNgJdaCavqYGIVs165Fs?=
 =?us-ascii?Q?jKNblUURQJOMXjzqGRZzSmC7Gbax/YR6sYEek6qPlqeUbds6bEiRK5By06pj?=
 =?us-ascii?Q?UcreyD9B9Gz+YzsjAu+0XUxH+QdBxv2qechzc8FRChvQjoUj7pimdocMf+k7?=
 =?us-ascii?Q?BV5FIHRjfvVYa7QbdXSZWGQZ9+c5y84QNqxH8k/yxIWrexKBRSnVZfGUVTfA?=
 =?us-ascii?Q?fYkqf8SqmWCJ1qT9orV4gWkSSF/QEmkQz2StgRwLBbuZ76KYN09xkVPdVBF1?=
 =?us-ascii?Q?vbJWIx+fe5lDQiJ2TXYVjebKBxbYqIWu1RPJ3hzOHtTjdPprmhcu7aBF3KQg?=
 =?us-ascii?Q?6hCnsq43tjfEffBb1ajZHeeg/CIgIUpiZcdeOzF3GBvfdlGc14jqRECcSHt8?=
 =?us-ascii?Q?mjpE8HiRG5AwqpDAMiEjBa1ih6HhAP17?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 06:01:56.4035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32577ba7-0593-4e19-72b3-08dc9fdca398
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7228
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

When a gpu in hive is performing ras reset, other
gpus in hive do not need to schedule recovery work
to reset the gpu.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 34226ae010c7..cbb4d6ccc420 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2489,6 +2489,7 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 	struct amdgpu_device *adev = ras->adev;
 	struct list_head device_list, *device_list_handle =  NULL;
 	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
+	struct amdgpu_ras *tmp_ras;
 
 	if (hive) {
 		atomic_set(&hive->ras_recovery, 1);
@@ -2499,11 +2500,19 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 		 * as part of recovery.
 		 */
 		list_for_each_entry(remote_adev, &hive->device_list,
-				    gmc.xgmi.head)
+				    gmc.xgmi.head) {
+			tmp_ras = amdgpu_ras_get_context(remote_adev);
+			/* When a gpu in hive is performing ras reset, other
+			 * gpus in hive do not need to schedule recovery work
+			 * to reset the gpu.
+			 */
+			atomic_set(&tmp_ras->in_recovery, 1);
+
 			if (amdgpu_ras_get_fed_status(remote_adev)) {
 				amdgpu_ras_set_fed_all(adev, hive, true);
 				break;
 			}
+		}
 	}
 	if (!ras->disable_ras_err_cnt_harvest) {
 
@@ -2556,6 +2565,15 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 
 		amdgpu_device_gpu_recover(ras->adev, NULL, &reset_context);
 	}
+
+	if (hive) {
+		list_for_each_entry(remote_adev, &hive->device_list,
+						gmc.xgmi.head) {
+			tmp_ras = amdgpu_ras_get_context(remote_adev);
+			atomic_set(&tmp_ras->in_recovery, 0);
+		}
+	}
+
 	atomic_set(&ras->in_recovery, 0);
 	if (hive) {
 		atomic_set(&hive->ras_recovery, 0);
-- 
2.34.1

