Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6307ACA0EDB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 19:13:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0373910E3D9;
	Tue, 12 Aug 2025 19:13:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PJnZNNie";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB81610E3D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 19:12:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9DqAWc0NtelJ++pNmE5pEPc7ThLq9mBuwh5W0C8lA+zn9IDuuBBH6fE/QvY7m/06Z7aF4AHFxJOJtNL4HiHkrruKiN646br5Pc3kueGw56tTp6dg9gjbZ0m/lv9UUGdQR41yNhCuouw86n7QnVec5KUh6WFtx3uRPeEqxTYsOnuBbwOlmLRfIcCwFSRYKj1wyiZ5MrqeuD8KuUwcErgF9OCpL862y2DS23Uhv3nWg3sIoui/7XE/299WxZ2Q4i1uVAEAbkuDcVmRfU8lXFlxffOdmcWMPP8KeJaheGyMiGWz2PVOzmA505SdvKyrcH8uhUcheqVI5j08AcXlZ1H5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNwtEsxj6l/tgLpVAYjhf8yRSWDgsrpZCAh9++qajCE=;
 b=qArfMMKrR9lHf0XCQKupZDo8yat4g/k/1zp29pzbyRfKEpzw1XPK+ecddJgS2n02+oAmDptlada75UvWwu91kQaK90b6/J8P5kc9ktPmSQ1hM8LSm8aY5HtiIIxW4y4ZSsVhs8WMsgsdazNN2DEtGjmb+jpWN9WkrJv9p7MR/NsYJ/AvtDsQEGiLv5p7XDjFdFncYyVqyCaTHqIj0mf8CAGR/kItFFb7nu79lepGdtYJkxqpx46lRpFW5KnGE+oNjwhnxamGLAvrgc79PZVKfLGjX6hI2SNfEPe1LeO0G2bB+AneIt2T8D/eU75lwMlJG/PoZ/mJp0S2ylgryyITgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNwtEsxj6l/tgLpVAYjhf8yRSWDgsrpZCAh9++qajCE=;
 b=PJnZNNiedSbjEts5f5pEgL0xZN6NZ2n+mHl7VqbjkZ8Hcd3n6BXu3G2fR2bMOIYXbDa0Kzc2pFLtf3bycJoFacp+pzDuc1Gk4y+5jpyw3VSb01M5752n32l3pqQIPGedNntRJauG4oLoxyCeZ3gnoFitWEFpeakq1XVFM8G3sVA=
Received: from SJ0PR05CA0027.namprd05.prod.outlook.com (2603:10b6:a03:33b::32)
 by DS0PR12MB8270.namprd12.prod.outlook.com (2603:10b6:8:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 19:12:55 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:33b:cafe::3c) by SJ0PR05CA0027.outlook.office365.com
 (2603:10b6:a03:33b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.14 via Frontend Transport; Tue,
 12 Aug 2025 19:12:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 19:12:54 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 14:12:53 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>, David Francis
 <David.Francis@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v13 4/4] drm/amdgpu: Allow kfd CRIU with no buffer objects
Date: Tue, 12 Aug 2025 15:12:31 -0400
Message-ID: <20250812191231.3534982-5-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812191231.3534982-1-David.Francis@amd.com>
References: <20250812191231.3534982-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|DS0PR12MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c7d0ff1-aaa9-4b32-7aeb-08ddd9d43dc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eNSDwww5WMPfALef6pUM376oVZhQ4RoNzaxsPo8rybqGdPOZBDnRsnt+z7PG?=
 =?us-ascii?Q?/NleVuidiT1Y8ziMn1syf6pN3VFRCb/4WDXBkaJjpoHdwHhFr5dhIgwtCXWm?=
 =?us-ascii?Q?kqPFMebE2GRoLFianKjl0Yg/Yy9UWeuob9UB8uUJ+w0kWqhUHLWCvbQIl5qv?=
 =?us-ascii?Q?z0bwW2sudoXB/TK2N5etpWD+M+XtsHkiq++HUfhtvTXwc7awjbpd8sDfBlqP?=
 =?us-ascii?Q?isu1etp75orCo7DgQN4oSTqdayiYnx47qDHdYVln9OayGaS3xbc13OWc/UsQ?=
 =?us-ascii?Q?fb3sNCYN68x2hXqoPZTLZDsE8gvKJ9sjqxosOTab7x7b5fKgkQzyihRXaMxS?=
 =?us-ascii?Q?78qUneCGaVB+akdRx5K/TUeP6s4TEFJ6IqBFqiO3+42h/AyqaQSVwQunSifH?=
 =?us-ascii?Q?TCrRWjLEx4DnNZEsrQLG3k7S9x/rJSsw6d5sqh7nPbZTVWHK067YYD6wpGaz?=
 =?us-ascii?Q?BhL1/0bAPK3TqMFE6mZvOzE9PYBa1E92SOfCgFsGXP4ubjCPb+rlpCjgW1Dw?=
 =?us-ascii?Q?ZYuMfesq9KmxTUyjkm76vkSUaFCNi0frgJvAfOkx6YZkUzr4ripmh3sTEoIh?=
 =?us-ascii?Q?hgwhDLi6am3HkRayv6IeCS/v6BJTzAIjxxQxy/3ZSdhfTN5725ee4tcFpmFD?=
 =?us-ascii?Q?FArxSJwIouWBEwUZOOgs7HkoUGdgVT9TcZE4Py1N5OVE9WJvc9PGt4HIiWfO?=
 =?us-ascii?Q?hnf4x+kzgx2xgs+uyZ9eZ0WQumEg7ipV1JIyqpn7I8TLYoxAlDybbHwfg2Ps?=
 =?us-ascii?Q?2PYdwyePFJxAAah81P/PIQCGBJYfJE8AlN2uZZLLmNCIXWhd6/KEpOJkKV5U?=
 =?us-ascii?Q?9qIJ6XT96eISVNOmrINlxOVBzKDrmnb6mX8BKzIa9czFjgb0q/hgqPKE+p2H?=
 =?us-ascii?Q?7JnyFMSS8Q1P7/z7m5a9XY5Jp23jEe9tLkwyKiVDwVI1Jmt99KBY6zd9VrHI?=
 =?us-ascii?Q?3pc2A10gWGb5YQgBiIBGwi+pvIwbkJ6gNt9H1GgKQtXKEot06uordY+SZTSC?=
 =?us-ascii?Q?tOvk2NobK9+2YlwETjsMpqsjF0xXzS25xYBwAxPfmgLodTy76CldI8ilrpb4?=
 =?us-ascii?Q?3tpdJwK/aRpnMuFlHMRCMkpnZFnGidTGgHO9IrJTomcbNRx9HQqTX9vNqvys?=
 =?us-ascii?Q?T9Y7L6Y9ctLYZgyVE8I4FVVpWxw1SnkWZrqnw8HicVX8Re3usa93tWgou7Se?=
 =?us-ascii?Q?s1/IMmYhuv6QwcwZhW353u31vbRTycQqZkmO1ST1cNlrw9iRyRsDjINGGVde?=
 =?us-ascii?Q?DFcrQl1zdPQdNQX6wSAr5B3f22G9aV6IEs90jAvog+msTMxLfZF+jvnryc5+?=
 =?us-ascii?Q?Oo5UuyBLZYtFVvQ1bo+sWgjJAJ2kEZtC/U9Cj5UQosqTNZhA61k85JQXJTxp?=
 =?us-ascii?Q?lMADvI23vqM+V49j3vkjBLFBHoMryICuUWK97vk2Ayxu+v4vj+vNJwSF4bhf?=
 =?us-ascii?Q?sqdz22fa9H1Q0/SQr7jsu9hs/y7ILAHzspOjCWmBMs7RgzTM+34UxunIsRBU?=
 =?us-ascii?Q?ABsGQ0EvA6HSpkN2QlM4zL79XR0C7LRg729J?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 19:12:54.7911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7d0ff1-aaa9-4b32-7aeb-08ddd9d43dc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8270
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

The kfd CRIU checkpoint ioctl would return an error if trying
to checkpoint a process with no kfd buffer objects.

This is a normal case and should not be an error.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 828a9ceef1e7..f7f34b710d3e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2566,8 +2566,8 @@ static int criu_restore(struct file *filep,
 	pr_debug("CRIU restore (num_devices:%u num_bos:%u num_objects:%u priv_data_size:%llu)\n",
 		 args->num_devices, args->num_bos, args->num_objects, args->priv_data_size);
 
-	if (!args->bos || !args->devices || !args->priv_data || !args->priv_data_size ||
-	    !args->num_devices || !args->num_bos)
+	if ((args->num_bos > 0 && !args->bos) || !args->devices || !args->priv_data ||
+	    !args->priv_data_size || !args->num_devices)
 		return -EINVAL;
 
 	mutex_lock(&p->mutex);
-- 
2.34.1

