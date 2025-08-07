Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EF0C87FCF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 14:01:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECD0010E855;
	Thu,  7 Aug 2025 14:01:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iFzoHies";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA61510E855
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 14:01:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1lihPmd1ibHv+vfSlTOmul7gFxDT0lbPYLZdyS1gkdU+R7Qn9dXgvXk2zu8wBtFfXJrQU2+CEFTAAXExyZX/1hcsnbWYnKNXuQp7tW03DD4uhsSTx93TMAwaIiU/xM3pGbYp8MR4QCqjFwCxkDaIUOfnCx/qn4iYCiq3P/l8rQrsYdjNtNc/onen3tIM92UMSBC9DAzIclK5LilZxMAGuacc7JROWQr9mHEQgYVG5fOgcVcVmVGvarO5BFJ77Xl9GmPc78krCydVrXjYMCulT0b32fUvc4dWi9usb6WQfrqIbGeowujTeiT7+8pbMb6ZiSFxK11d8KZqBEXbMfAJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlOxP0cK/RUC8IJbHK9Guc8KayJ6pF1TCLSjNoQzSmM=;
 b=eZJlxOABIHeR1Pq7XZIChTOqh0sh+fJ+ezNJBRD6qxs77Rtjs7CAHqH8zlDYOZir0vmo66xkHUMADHW6ElDnAgUzfFp6aHnzyHK0eMUpYujx4CK28FXozJdtCXsJrXL0ial1wI4/Ymbi0xxJWySIGPx9coijxJUG6yGjDUxT7St1ZTFKKWbR9WqY/x3tWJqi4Y7kXGpfzbNsht8Gf2LuFSijQdcE07f6WGLYzbO44U+IIAXNE4PNBoIJBZ+JX5FXDAGcT88N0T0HkMVKQK8j9a3n5seXupyTtWGb6leuegIVRpRMhtn9EjAu4ZeqQo2nZIoMz3MPC/fnH70VH0mQxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlOxP0cK/RUC8IJbHK9Guc8KayJ6pF1TCLSjNoQzSmM=;
 b=iFzoHieslTNEnbdGbIlytHUEE0FYUwMcubFlfGRmz/pLrVZq2wA7kI/+po82/50eNns3XLvlU1Zmyv9QTsSiVrJjInLyjeZyHaboIRMRtoDctnxf4ngFKUFu63gqjQn9bOjzqRc8C4Kd4nS2sot8XMvB0vlxLJYwuz/vgoXbiVI=
Received: from BY3PR03CA0006.namprd03.prod.outlook.com (2603:10b6:a03:39a::11)
 by DS7PR12MB5791.namprd12.prod.outlook.com (2603:10b6:8:76::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Thu, 7 Aug
 2025 14:01:08 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::63) by BY3PR03CA0006.outlook.office365.com
 (2603:10b6:a03:39a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.15 via Frontend Transport; Thu,
 7 Aug 2025 14:01:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Thu, 7 Aug 2025 14:01:07 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 09:01:05 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>
Subject: [PATCH v10] Add CRIU support for amdgpu dmabuf
Date: Thu, 7 Aug 2025 10:00:48 -0400
Message-ID: <20250807140051.2377470-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|DS7PR12MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: 1350a830-9a2a-456d-6f85-08ddd5badb39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B8NdiYtSvffAuOlmoA+puW9cqx6czeTjSJnNl958DnsxzvofHrGdXPCSQsga?=
 =?us-ascii?Q?o4b1W98esGvqbrYU53yGlIxqbq1PXNUJYUQqQyRCUy23uppfnYdgb67lbYng?=
 =?us-ascii?Q?GG1MLptVn/4p6i9VTrwj7Yei5Yit5+FxlvHrnNd3kl6YkOv4lklRQN2XNTEr?=
 =?us-ascii?Q?Jzb0CDxkorD9J9z/V4LH/jmStjlN6nhMR39MMx+ViwBEWFURJE9WAkmmkQxn?=
 =?us-ascii?Q?KAdB/Z391LAy1NX4/jceQQmBTalE2cLcb3mwiJUAHYZF2qwkG6E9ZxcN7qNe?=
 =?us-ascii?Q?g6H3GcOENlC2Er8U5Ca3RU6HCZMZAZU7bbC4aCcOpPFoTQ6QDkT9FMZ6ikWI?=
 =?us-ascii?Q?b+GiPVkpdAIhf6oe1DBdlt8gTk7VTjLnsPiDm2a0LXWqyyQhJR2OQS74fF8g?=
 =?us-ascii?Q?1DNH3lCv4TOZ+WrsOyIfHAJL3rn4d00ol9I0IKNeKTxa+KaUzzB53bBPSKNi?=
 =?us-ascii?Q?x3nLhO1zbFBDvMIIBdtyfbSly2pJmGD7jK3Z80EetF4GNw7ePqlOht1Nxdxl?=
 =?us-ascii?Q?kpLnHKucZ3Nw8rx+9j8n2sIxE+CzIO29s1BaNRX4ZW68/tXfnaU7BuFpxtLK?=
 =?us-ascii?Q?FELFdWcgvoFEPpE2a14m2ULzz2I0io9SEIgPN94iru840RN+7CX23MjlQ8Yc?=
 =?us-ascii?Q?aSBwEF8nshRlTFs9AbE+IvlCnUARkVMB8+haQWMJcRZs/bwcu/ag4ApDvMV+?=
 =?us-ascii?Q?mXmJRM2xa0m2ZH9/gAcmFaxwgqMr4VQzAhu0leYYEZKZ4DRgde7F/gkZaJ0n?=
 =?us-ascii?Q?mRPpxCMezd1C8jo/dvlh5PFcPHd0mZIq4fDriobpVo2BTPGuBgNiBhslrwV0?=
 =?us-ascii?Q?u2Dyr1/HuqHBOmyfJTtMOZqEAblxJGApsuCHIlxnlv4CBA9RgplGirPqdIS1?=
 =?us-ascii?Q?fUAJ+ZJ5r0HSjoEputLIJwu7wnPBSWzQGccW6nG9VMj1Qof4CMR0X5LDJBii?=
 =?us-ascii?Q?Ag9CC6rZhRiq3rf/WIHk1PD++rzSNu5hQHfaoVZzL3zizA5gswLxSQSNQpPZ?=
 =?us-ascii?Q?tCq9MH90kKHl0VcGBlJK7Upw1N2bCfixT5p2asFZ1dgp1MuvEwmpTtQobm0R?=
 =?us-ascii?Q?2+3iC8imi7ltxSL6hSO6dY/kFjSG0Nls6TU/Fd6Q6bgO8aLcYfb19DgQ6s74?=
 =?us-ascii?Q?G/LPFJj3y8BVrrJeXsrM7gQQnqY7WM1IQ0swi11Qj14AM08phWBIJIkFivzW?=
 =?us-ascii?Q?4wHuodPoqt3xI/fDS+AX3/a1REmucINZCpNDGQLwmEdsEM6Aa89RCAHjV8p9?=
 =?us-ascii?Q?5oQWIeyNUiLbJXYpDnwzRWCJXbAFfqf5+ef++LtHqqvNWwX7Zwa+B5jAY/Px?=
 =?us-ascii?Q?bCXUN/CIBpxkOfQ85HGtfqh98sQ/gB7IH+eKLIMwdhpwIGIR6w/5PbpnRyak?=
 =?us-ascii?Q?QFzlnKFAIVxW/qNzk0aO3/lZo8z6BBZnj8ZzVWbo5k70PStsOCj4HS+JVU4w?=
 =?us-ascii?Q?o/zp8mMexihF2ev7laA9PIy+OuNLENcvciFJdZ9kIipzZ0xUVPGDVuJwWHOT?=
 =?us-ascii?Q?Ph7w8Mru/F0ZzI4mNyg61RlPvV+sKOVwjnw1AThpaW6fSkRXYW91H/ussQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 14:01:07.2668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1350a830-9a2a-456d-6f85-08ddd5badb39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5791
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

This patch series adds support for CRIU checkpointing of processes that
share memory with the amdgpu dmabuf interface.

This v10 moves the ioctls out of their own fie, and into amdgpu_gem.c

Accompanying CRIU changes:
https://github.com/checkpoint-restore/criu/pull/2613


