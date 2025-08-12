Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D72ECA0EC4
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 19:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 362D210E635;
	Tue, 12 Aug 2025 19:13:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TXgadYZ3";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1882910E3E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 19:13:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmrzZSPwuqGVsQvV6P5fbmPvEVbuWCXJ76z7Xy81sc1sJN9wRYnLDFgXOOGOM0fyoD3M1i5BTovQA3az74afuIIZc6pvgLx5amkGGMZ66eLwv/Jb6qxavxsIMpaKxfMS/m2nuPVrLCyMljY80M05nBp8T0B1GRnoRXJyAMaIC4mc7A3ssk+jZSoJwwa1i70BLtf4cP43D5W2+ZsfS0MCGqYbMQHzPaycN0MxsMkPq6xm8WNcPQvPIHVxd99u+CuC8IaB5P8rzz8Lk+7NxISV5r9RdhHG0GCPNZns60v8KWOZ0b8gmnkFarSp9rx+/thd4PNvoOoDeXN0dR38NbAy1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrXC1lpa/DBFokReoH5yKM3camsaRa0qtZqcjrfdPP0=;
 b=Cr3JWuR4Ph3rF82hY8dRKilppMLxZJ0Xh8ZyYdyH/2T7QaYUHgxp+V6dMgDKmFTqHxhv3FDZAgVQCIwBC8TLAnEYw0P2fwVvau4Szeb0alun1PlvgBCULkspujDKbKhmUUwPj+F12H4lZId+UbNyT2e9F0bpjArqa7fHv+09qHZcN3wKqE4cmremMXUOdWjubuXt41s19KPPihNkBjlzZbu6OZplm37oMj3pXso8uDA5/Qd7FoVgcI7URaw8l8sA4qTmmJCI3qZxrsUR6iLkY6R4HCFsLg+O05fCMvqWFjnAgnvGq8e5BCcNphn3PxEmN5SPiks5re+0MOU8LTaGvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrXC1lpa/DBFokReoH5yKM3camsaRa0qtZqcjrfdPP0=;
 b=TXgadYZ3+JVfiTi/2yczjrEfZdyI1BHTUm/ijm4m1r6qGTWLBeHYJuQsVyeBZcGLbw5nuR+r4PDHSfeapDzb/yrhP84hacYkQ6VoMcRq7+JbaFSFyB/PNbof+6+4FXorS6ijR189quOP2Qya6L1iGg7vZB9ZtWUmm+XUYNdfTfw=
Received: from SJ2PR07CA0023.namprd07.prod.outlook.com (2603:10b6:a03:505::9)
 by PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Tue, 12 Aug
 2025 19:12:50 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:505:cafe::d0) by SJ2PR07CA0023.outlook.office365.com
 (2603:10b6:a03:505::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.14 via Frontend Transport; Tue,
 12 Aug 2025 19:12:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 19:12:49 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 14:12:48 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>
Subject: [PATCH v13] Add CRIU support for amdgpu dmabuf 
Date: Tue, 12 Aug 2025 15:12:27 -0400
Message-ID: <20250812191231.3534982-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: f8bd27e0-0cc9-42a9-ceae-08ddd9d43a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l96NZ7Q9LAHC+ZMy5YxbovotXzUy/Ky9SnIwaak5x2GY+IehqrxMJPJqvuMB?=
 =?us-ascii?Q?g23VWtXSVsieyGB4xxr/7aVP0mtXUXP6cHhBB1dMzVAQaWztEaW0YJVEPnuo?=
 =?us-ascii?Q?ex5vmd1YpSIg1fQfCyJwza0AjJPrNLcanrdaf7PQntYs3yKZ9QCmu6VcOpTn?=
 =?us-ascii?Q?i2+5JpKksQxVNm3KU9u5Ukf4aXh7QJbIwJ6hQd9oWNpi1PnuPh/49kaXtlre?=
 =?us-ascii?Q?HWl+YV+dbU/1gVefPHx02b/OUE3uAw5+98rMgRngzojiBTDKiI7/RGjBaIeN?=
 =?us-ascii?Q?MdDSPVB0FEvY4FxwltkqwbAidPp+ZyUbY8PBhilTG3XQpuCiaPRHDV4Ddr98?=
 =?us-ascii?Q?DxSPYewKS6EBIt2wO4DM5A/EKzSZyYDNcJNY2XiEwcWmj55+G5j14EdfVEqC?=
 =?us-ascii?Q?d48QBLM8B3PbIRw7AaFFVknj6m6sj0TmXDr4r/980pbDRUEqdvFmPv4H2ovq?=
 =?us-ascii?Q?siJfyUb4Bv0kIy55b/Ourfzbpm6f4/ObpLaO1fdd4FPoS+IA44cgkpgIsXto?=
 =?us-ascii?Q?qAPtr0azLJOfKtCIzspCy5khYH3QtyjXGjJo2IAsq/M8lOv/74nCKrspdSqN?=
 =?us-ascii?Q?3Pu9ErtDwxvRe1PJakoPsYSbbh9VrVDPmXaq80C08u92wvNkioY6Q2ND2eFG?=
 =?us-ascii?Q?LivKff4wQzUJBdU59fXwxc/NU1lxp3Urx45RDcoSwaCMnrJYhhZU38qAIlr+?=
 =?us-ascii?Q?OrIpojTretI9VS/Yge04n5zzyqTuI66TcdgH9jl2A9pF1TpGq6j3a4+kCFsn?=
 =?us-ascii?Q?xOp9+P+k/yqkEhTFnwnbvBa+Itj5kma6ZOqGoKW6W56K3rYWwK9/C1nMp2sp?=
 =?us-ascii?Q?WtmKEVE8deHtsoduADTnmx96EjBN+5RCzFpbLQ2oOdtRxBTnzhmpu5WB1TH5?=
 =?us-ascii?Q?w2PwLu9MaAxSZZ2c9Ll4/r0uA1Cj4N980dH8SwI5S0SXXO9YB5k8k7QxA4kV?=
 =?us-ascii?Q?ABwpXk3n1jA90PCM/xhTzM8pzigNddW6W2fAi6P3d2/bnmWkMsjsSr1X8MZM?=
 =?us-ascii?Q?hxJIv9EhQxHGi1CjAL25w8Xq1QFlXklJC4Xoedi32Yfi4cycXF/cC5kP+T3N?=
 =?us-ascii?Q?cy0VqjTfnZQYw8ebWONt0F/rPZCRkHhr2x8VdKCWTlhsluBYIYoanzRTIMPc?=
 =?us-ascii?Q?EllMOaNa+JNumATHSXkxySLL7/YRjO1H5LazALltJhUE6Z3WDlIdTSEQnyWY?=
 =?us-ascii?Q?PIx9nEm3vH1dsqle8pDwOed1QrflxEd/zTPShoMtlmf5RqDLpm2oAzqRluY9?=
 =?us-ascii?Q?9lPtGqwdmJhjod4n2jXsL0M7bziupac56BLfBbykByJ7ObbqGU8bYOAI4vPo?=
 =?us-ascii?Q?W2ve3iYs1O3jczhFf4BaEK2ObLYKs1/R/bydZVXgdVa+ga+e73rmW5PB8tpr?=
 =?us-ascii?Q?zlXWKYJtkR82xgOuw4v99RH/Hh/NxOFJOfdu3xyRjOXEr70o7Pnkfk+bHLKj?=
 =?us-ascii?Q?GLdRkw6awRI9/4NTqvE+50HZs6/8sAbYCTLgqW+SsyivWU8xok8zrfxTmoio?=
 =?us-ascii?Q?Dz95JOQMTZwOInORX52Dro4KU1oMpDDOpbX82TgsT0SzL+rf9r5B7lkVRg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 19:12:49.3358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bd27e0-0cc9-42a9-ceae-08ddd9d43a96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699
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

This v13 adds an additional patch to allow gem_create_ioctl to use
wipe_on_release flag.

Accompanying CRIU changes:
https://github.com/checkpoint-restore/criu/pull/2613


