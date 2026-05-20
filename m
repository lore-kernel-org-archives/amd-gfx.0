Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82244CD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 07:14:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1746D10EF1E;
	Wed, 20 May 2026 07:14:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2ja6FbLc";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013053.outbound.protection.outlook.com
 [40.93.201.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97CAD10EF1E
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 07:14:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kO6lvN3YKxdNtGXu+t0V3ZONBZAFa8ErDxNn14CarYeLWNg4L8hY5gytYR32O2fa60wi5im8uKMh0pf7e9FZfyv2LRxV63mnuW17ddOWWgqfcw4l/3RbyGKlZ5TaOwKQ7YFTFPq5yPS8m1+qowdGsiWJKF3Q/JXSV0R1cb2dGkvYx87p1OFcTQUo4N1FD5BnnvV5u4UiJ8FIeSWsSMGa2ZEx2IqvKzLODM0wBzvibRJjDZ6ZQNv0mt7xsRi4fGyNbDUVwRRXNp85c6VuVRB+tumexZfPn5yRRlIqL1ZMqITkcAfrIeT0ThBzO8JJSuVcq95ORD4wi3BTQlwE/yL0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5o12BzTuV7TaWYLy8vnkLewiFb6o+QxHl9zTMtpey8=;
 b=TCiUspVT5Rgbi3ECyFQN38dFbMBVjH/ovO6NR7wzm8q+6VakOzq36Gzwftk7OEs4r1fv7/bHaqqdjaC8OsWuYqUd9T7b8GLb4cOrXjz61i8lnzcHfCZQaScP36amtgTIelVYrT9pQahxFZH/xKqJLlBdbcmT+iUTqcBcoyb2Tr3LTU+sKkdfgcNCsWzyVGVDjGbPsGzCC4QZKwqcgopbV3513de0OuZ+LuErdv1YUIG3hsdGxqFqwyMDyTF1Drbp3I7ulHNp7VrlINBwC/3wyrACW5Fx1hyABcrkbPufLtR4y8NCtc7UBQthM+NUsHO+wTgDBe5H0E/2xXO8kbKBPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5o12BzTuV7TaWYLy8vnkLewiFb6o+QxHl9zTMtpey8=;
 b=2ja6FbLccoRBU7vx09gxDjo4MAOkpjTJSLfwRY61NcuRURI2hxn6mbFRnvTRVg27z1oP/QvQ7Sh7rG703/IMkEMFaL0aIYgNqyhU0n+1fRXO1M5y1WFF4nqO+yS8bGSh3mu2TeFkLlsuNTqzARQySLIfu+s+sqS0M9dd3Umg/jA=
Received: from BL1PR13CA0259.namprd13.prod.outlook.com (2603:10b6:208:2ba::24)
 by CY3PR12MB9607.namprd12.prod.outlook.com (2603:10b6:930:103::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Wed, 20 May
 2026 07:14:01 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::50) by BL1PR13CA0259.outlook.office365.com
 (2603:10b6:208:2ba::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 07:14:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 07:14:00 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 20 May
 2026 02:13:56 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>,
 <christian.koenig@amd.com>, <David.YatSin@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: check per pdd sigbus delay time
Date: Wed, 20 May 2026 15:13:36 +0800
Message-ID: <20260520071336.1573860-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520071336.1573860-1-yifan1.zhang@amd.com>
References: <20260520071336.1573860-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|CY3PR12MB9607:EE_
X-MS-Office365-Filtering-Correlation-Id: adb3e979-bce7-4830-18cc-08deb63f5dfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|30052699003|36860700016|376014|1800799024|56012099003|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: Z6ce8si5H0efExt/Ve41zChkTHWY1bNF2sY/eQ95qqt114B8hsEtYFbA31Z9l0HaenaQ0W9oaLMN5hTDruVkuhgIrzIrBJDDU9ImYBEAFl9Kqg1xGT6UuW2ucFqSQeOIm/Mv924oD3z36p5P4lxg8gUgubqzGGiNTjTj0+mDqFzk2adVBcKIWlr5R7Y/bspaIJ80FZeUtDJwWVGuB79wo86XkCg8pCFjSxUcMNxcXNhtV0dW8/RiO4EH4LCJQ/x7gnNeyDOEuGPf28IWSMhq+qOaaEG0gJ87BeNK6sheins0slEnQp6MqVCqLTorw1a4jo9zL9YgIzhgVcnLKaHTs9Yp5DXiZIgU4D7t6QfLXdEZMCyJoLhDDB5ezK+2WaHKcmvKRE4X8IpfVna16xtndqsce0VcYZCTzqYiFXFxXbK7D33ckFvfYgadTboTyPBpLW3lvB6OmCXVq+om46+7f5JH4aaNoUtMV79NS4hKILpCwv33IHAtJVcaAF4J5MhjKR3rGpMYpfv7Gl3/icYOUkZFgkZ143FaNPH5w7SC+LIikyoiDtaxfWTJ9ujHQfjyWaiR8ZXA3ZfjPusp0bv2uJoLPsKn1DIFuzPL/XORPwPF4r6r4NMOqhFgklTAjQ8CtZ2bDeWBM1e90TLpnsn0Jh7rCLErOdlBoduZsNGt7xXPq8dNG6xg+6m9qmVxRjN6r9LhWYU8lRoXtvoEUwsrTbbX24IEdxSKsX7LuOjtKSw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(30052699003)(36860700016)(376014)(1800799024)(56012099003)(18002099003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iaCj8lGzbD+HHG7CeQdIh3wTQNmjBqeTRrOio0H8yvgsuIBhH0sEMDgISH/57ptqcaqoPGB0O3w8uSqgOQmRgt3Vme+OzsVmanbembXIoQHQ2Pi1mAllNTYInt1YrL/SmDytntw8irak6v5GARid49vIOj6rK5bn60RlslklzDR3ZEZwCCaMMGCFvqbcOmWK1QzB5MT7hnTcHFp5kKwld4qs2tB5tjQ1AqbTXQd+ntLm/Wuyi2DTu5cGcK5BTCvfTBh7C2IQrv6yjB8aaEtxSDfUF9OcD39qu9ZGJw0ffJ7FiqJJ6DJgEpFZrNPNg3UzBVz0j/bOFPcKFnW/knBE+f+w3vOxxA+jDxusJsaIbz+3QlltXETCfc16YP1PZ//7SXg2wbGjQo+YGVddQsl9s3j6qOWZYh6VboRiNStQ6sHc8CCoc/7voLhgbyHWUfsd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 07:14:00.8690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adb3e979-bce7-4830-18cc-08deb63f5dfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9607
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

This patch is to check per pdd sigbus delay time.

Fixes: f207b038bc38 (drm/amdgpu: add ioctl to handle RAS poison error)

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 8b4e0a208e86..69fed7e5b122 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1388,7 +1388,7 @@ static void kfd_signal_sigbus_delayed_fn(struct work_struct *work)
  * Rationale: if the app has explicitly opted in on any GPU it uses, it
  * wants the chance to handle the error in userspace.
  */
-static u32 kfd_get_sigbus_delay_ms(struct kfd_process *p)
+static u32 kfd_get_sigbus_delay_ms(struct kfd_process *p, struct kfd_node *dev)
 {
 	u32 result = 0;
 	int i;
@@ -1399,7 +1399,7 @@ static u32 kfd_get_sigbus_delay_ms(struct kfd_process *p)
 		struct amdgpu_fpriv *drv_priv;
 		u32 v;
 
-		if (!pdd || !pdd->drm_file)
+		if (!pdd || !pdd->drm_file || pdd->dev != dev)
 			continue;
 		if (amdgpu_file_to_fpriv(pdd->drm_file, &drv_priv))
 			continue;
@@ -1420,7 +1420,7 @@ static u32 kfd_get_sigbus_delay_ms(struct kfd_process *p)
 static void kfd_signal_sigbus_with_delay(struct kfd_node *dev,
 					 struct kfd_process *p)
 {
-	u32 delay_ms = kfd_get_sigbus_delay_ms(p);
+	u32 delay_ms = kfd_get_sigbus_delay_ms(p, dev);
 	struct kfd_sigbus_delayed_work *dw;
 
 	if (delay_ms == AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED) {
-- 
2.43.0

