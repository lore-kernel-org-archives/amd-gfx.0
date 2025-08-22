Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B250CCA0EEB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 19:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50A1910E17B;
	Fri, 22 Aug 2025 19:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SKDjEPNy";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 067AB10E17B
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 19:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPCGi4PCulpEtQsfsRR8uu+N40C6UUPwzQDpTWZ+N+LswrtEAMwChxmrT77yw2BSv8Dc2xeVkXYU5VUI3I6DRzASDCZAQpfnWNxyNT5rzMhtgomFdRaX3JchTCjjZZZ9nXHuiRpXi2GndRvr8FYCZBZxVQEeEi4XczBs2hRzpOozHvu4g4VN6IekdXrCojswQgX6fX96xAGYSxDtCMe+N+oYjgfQAClGbz/Ei3VBuK9ntLmBHbHeIwu+4YTYWGgnLUUBDYlYYjphPPIp/MIJUIm6M9JUNRtgTQswdNiAK0XHp8NqaEawg2BNqSynbUAsQfgcOG9NmE3/Ml4TmC7tYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vUPQYevm8aarw0rU5TIkn9y0R2XZpN8EaavuSmUoio=;
 b=LNUEjn0iIggZvV2VIl9Zf+Hfr9JNfBYIN25slQKVDQJWnTNU7BOCbP75Mjkf6uW9OPHtqA/TwJXRjm3VEQ188bnhW89tICHpJqmcsMc5arZFIQc2TMcmTjKo5swGzNuBMV5qxveCDPX3UIn7okIblulhCdcuFXgddHrMANsIdQOlKuKaLEQbQbTWe49lRGB2OThyOUDwhPRl5orrA1K0JHcCFLJyDhUHFYhf69vi7Vk8uE1WtI0Ya51g28FqRsfXHVa6mipFzHtsMvcBRkRGIA1HxQCgqlubz/L4uYZfO2h40dwgrUvpACkj/rFNTMdKr5keOwMdbuTaEXZpOV2cMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vUPQYevm8aarw0rU5TIkn9y0R2XZpN8EaavuSmUoio=;
 b=SKDjEPNygWmHznlj3Lw9Gi5DKawcg/NmsR4JVXeLa3Pb9ESSAAbOJWPb3ZTcOwn2XPpYKkfrwaH93mTpnwE0rNI6XVwKEmiXaV8PhzW7UKtTsb4Nn5MuRjrONroWUEC/9TrWcpGR5c/6p9kQkCrv3AoYzm3PA+elLUGQPMOqh1o=
Received: from SJ0PR05CA0010.namprd05.prod.outlook.com (2603:10b6:a03:33b::15)
 by LV8PR12MB9451.namprd12.prod.outlook.com (2603:10b6:408:206::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 19:48:12 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:33b:cafe::45) by SJ0PR05CA0010.outlook.office365.com
 (2603:10b6:a03:33b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.8 via Frontend Transport; Fri,
 22 Aug 2025 19:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.0 via Frontend Transport; Fri, 22 Aug 2025 19:48:11 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 14:48:04 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>
Subject: [PATCH v15] Add CRIU support for amdgpu dmabuf
Date: Fri, 22 Aug 2025 15:47:45 -0400
Message-ID: <20250822194749.362771-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|LV8PR12MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: 438102bf-ba08-47a0-33fb-08dde1b4d3e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b1O0hU1cYdK87CTpF4DtMhsMLuUTlVQAANIccoKiQTxcRJr8zfCTKN9cPgKf?=
 =?us-ascii?Q?Asd4GhywelBpI0m0N2TG1fBF1m/6mTVDtNzrywGQjLYdickyr7Z70ibgKhjQ?=
 =?us-ascii?Q?KWZBqJqLwvVJvc0cn8rKE4j5OJqgKZcm6csFQzMlXs1Ctz2dpZ7lGgPjvi3L?=
 =?us-ascii?Q?D2MvjVcu9e2DPJHhSL/rmCJ+/H7sPTQ7zQ2XykHoqmv3cdx3tiTPxEQL5Bhq?=
 =?us-ascii?Q?skkPrTFCOF3wZFuEcT+iLpEIbx25aDWveBzKFRWoZLG2kSLNmxfMQRoZxZH8?=
 =?us-ascii?Q?tyPzP9yFpoTqxDOi7ozgW8MoUS3w1tUz/G1DiWr1Ej48MfAnBKm6jy46+LLA?=
 =?us-ascii?Q?Sk/jLHMSPkXr63zsvZXdlG9HLFU6xj4gcOuNevqY0QqKacXsBc0BMG4a1qa2?=
 =?us-ascii?Q?kDLQMdNgxzHwqFTX4ZvoW+iyB6DlefBCTWwQRuYQvpSMmrXG3BI3kO3T//Kz?=
 =?us-ascii?Q?5OGAXYPG9bTt8a+KwcMPWnb1wEqur83CJ6W9DOWNa+u48zKkYZLSPGCnRHJt?=
 =?us-ascii?Q?3jXScE8HNhwQg2bPZ0Ll7g0UZGhn6Rz0hzQIGHlgh5X3pcj/esPkxgfs7BTV?=
 =?us-ascii?Q?qPlcStG1z5snMV9X/JjornIcMtWiki8g+nyQVHuN42I6FvkZyp7KyOki+2UG?=
 =?us-ascii?Q?lkZldsiS8uLp2hlyH+//lINLXUInwxgMyLKvsztk5CxaV6rupYk6j7C/dtS1?=
 =?us-ascii?Q?+4KzdBIP5f3jo6m13C77cGJa/ggvcyMy0G81imJZWSSWd1wKxqCoaJwIlQcg?=
 =?us-ascii?Q?CnhuLZoDwTg0VTOWZYjimdqIORBBZQBTeViLhU5JJ+fYxbk9AW9ckq1hvNVA?=
 =?us-ascii?Q?kg/qKp7AzQnJ14p7AWdh+D+Tiz1os0ClieWyNC7YBUfwR4c844ls6B9ogjzh?=
 =?us-ascii?Q?FLxHEnMYKzXQJdUgTT+ErYz7MG3GNfXsKpupEaYOBS52T/jLXJDVctOdQErg?=
 =?us-ascii?Q?oKiyOCt3Bkg9wwwgf+W6vOvSYjGhjhAQMAUC4irUxXs70kw37vQsVCMfZmNX?=
 =?us-ascii?Q?29K/cOFXAdDpyHo8p5qmIgnwIFy/slQ8YwaQu+MK/ihfj4ZQhQmeszIsgCXX?=
 =?us-ascii?Q?TXGw8wtPIHfFOXXjiLE3poIKqEu5xiHohHe4lJ4YP99shyvQWQ/8vwCa8JrM?=
 =?us-ascii?Q?rlaN/msun5FHELDsb+S8pBUhvDiwnzlKqeuRyYbWx/4z/IV7hpfCjRsGAHP4?=
 =?us-ascii?Q?+qVDC1M1PO2Gk65ELKjzWHp6/x3p3D7BWo+RidCVcSNZtYC4XEiduPxL2fYx?=
 =?us-ascii?Q?2mT1QBPSFCK0c7xH7LCsOwidaXnW1FE4+Zlc9wCk7Z+nJ+TlJO20hiMflAP1?=
 =?us-ascii?Q?KgTzhrWSawQcl1kzj1ojkWBxh+kFuodaOdwWhYMq6OfdYmhm+CFf5FDVrS4n?=
 =?us-ascii?Q?MiHBPd6GmLcx5wfgOHy4yzU79OzTTMVuQL5zHJmYMsZ16i8gbfTTXcIKIQov?=
 =?us-ascii?Q?xEBCsIUHLoPS/vAeF1qL649mT8wZQJ/8RJia6enGbYcHWh5GGGPeDpKIvKfx?=
 =?us-ascii?Q?b7yip+yxWU7PU8pT9Xyeh9cBJfYwM7pNYYMk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 19:48:11.9342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 438102bf-ba08-47a0-33fb-08dde1b4d3e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9451
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

This v15 makes some adjustments to the uapi.

Accompanying CRIU changes:
https://github.com/checkpoint-restore/criu/pull/2613


