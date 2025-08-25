Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771C9CA0FE7
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 19:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 035A710E231;
	Mon, 25 Aug 2025 19:49:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z54QsBgN";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA6A910E231
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 19:49:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUOBhued3lQSQ+5QaElRD+FjKL0uObcrOnpYi2CaHQzflhokUGuEgJFcGoq3izV8KczYf150eo3HzgDwaaBmq7BsoF08Gisc9IKCnfQZQczkmJVoJPC264v90xocM1kUZ4G14hU5/cQThTRMg+4v6EhttEC5eJv6YG85zQVGujy3OHuLJ3PdviKlxhpcute+iXbQSoNCaWRci1vaJtjLoSSJrGW1XwqZqhPMclAEQjn7BefOOg3o/bC5aZd16GXFTSxJbDKe9djFBI1YB8/1S+s6dYu5gXuLRTfhfEqhkJKkMMvKzNjgWLjDIlX/yujtYn7C2sncWd9oLGxRJBxgRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2I+S9spG1Y+pNBaDRwVwpkc+i2kNueCojcAgjK9a9Y=;
 b=mC2uzQwc0P0ZPrDqmqvqhmgiuEok65DhmXewgwyJa7HNZlimPJM8IZEEckSrMIm2GILx52iirND0EsGRzXh7tG8y/Wn1fgJoQznhX1LNTFUjDa1GJK7Ko+rWCOJFi58Wdr735mjGOdurEzr3pkFvAtNdrI2wazRhl42m4dNlFMQrI6jtOVpat3iQj6Djl9Ig0Hct+loXcELpj0oybTCFRXi+SPxxgKyIe3QPIy0gVScY5dgU3KGBfxNP+xcFHbABBWmyA2bkRb/J7LyZ3BajrroD5G4YMbgM6o+/7SbyjrRfOuip76akyILp7Q/4SxoWmB/Asump+5nn3SBQCi1vxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2I+S9spG1Y+pNBaDRwVwpkc+i2kNueCojcAgjK9a9Y=;
 b=Z54QsBgNqBS6BRZ36klzFmNEoB9ot5ykRP5qK6L/qK6qPXs7p4EDncctcLQ81TrOWXmS/4hoLDOpsHhWSRRh3sv+ctg+na+8byn5+qwScdXf/9aHjumEzQSajdMm/YEiqtGaRcSrVjCD93gGYeFiVCy66lLFTXzbqfzsYKVemis=
Received: from SJ0PR13CA0040.namprd13.prod.outlook.com (2603:10b6:a03:2c2::15)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Mon, 25 Aug
 2025 19:49:53 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::75) by SJ0PR13CA0040.outlook.office365.com
 (2603:10b6:a03:2c2::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11 via Frontend Transport; Mon,
 25 Aug 2025 19:49:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.0 via Frontend Transport; Mon, 25 Aug 2025 19:49:51 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 14:49:50 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <simona@ffwll.ch>,
 <mripard@kernel.org>, <tzimmermann@suse.de>
Subject: [PATCH v16] Add CRIU support for amdgpu dmabuf
Date: Mon, 25 Aug 2025 15:49:32 -0400
Message-ID: <20250825194936.899825-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b5d86c5-5d7b-4e0a-c548-08dde4108ea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jdw6cmfPhesktI6Ehyzxuwn4JwwQqF7es2NTZBB0vmXGgpSBf+8fu62vn6iX?=
 =?us-ascii?Q?QC0JSk2AmPKRUtPpKxow+dlt/PRTcvr1YbdkTKTrfFHseJ9XkLyUr8ClJRDw?=
 =?us-ascii?Q?TLeSJyOeCXmvm/p65pErIN2QjAwDfPtl/UBN9SKRjSRAm2kUoEfu7g/bR1o6?=
 =?us-ascii?Q?INRtwKFQ006ICouq/mCjTaTlqNtVHFqnUNBe+QVlLBLrLYox2QzbKGaHWjZD?=
 =?us-ascii?Q?64UdhDCZmimMqw2lCY0uHCpjbBBOVLwMJ78XgUb+ZJ5/Vzsl+vDq285G/aUR?=
 =?us-ascii?Q?YBfZIDaEiyKOyuFd0HAEjCpmYMiYlHjQiz6WdSfOo6QN4zJUSgfZFWG6TQQq?=
 =?us-ascii?Q?nOmoUb+ypwrgyBYXS1ggHkL75XQQeDztjbYeV92gxuQEtcbiFEaGmOsyxTBo?=
 =?us-ascii?Q?H27ODwgoy55ZPO3JXybcY9ENAqhu6tF/I54J1jVc53U2Wo8RWJWNdp644qUU?=
 =?us-ascii?Q?hD6UlUqRfDd0cKYi1MtoVnQ7T76c5csPsOgVN+6gUb5Ry2tjWey5zb8YK/6V?=
 =?us-ascii?Q?X6Mx+fSXN3BdVzDj2aLB4gQnHm461AaAopqIgr/vfaVm766qp5wFJm2NyKMM?=
 =?us-ascii?Q?bdQfIZ8XQ6UANMjUvXu/2hK3qI2gkgHPc3+nSynOcPKn5zOZURHuXVl8EKVZ?=
 =?us-ascii?Q?ckpu2HCjq8H14Ua62HvwBCf01LAcLysnBkdrm/XmHA4y3yxEnCr4rd4JcdYj?=
 =?us-ascii?Q?9oSWgtXtvLIxyZDiRIIgme/f/j1xTpq0iY8b0bVDSXLUX3TWvyH475UUScyQ?=
 =?us-ascii?Q?VgXaeXUQ0JoCV+DUpC3tMAk1KvC6uBp3xgDwDHF3bZlVdV5g6EB2TrdbxSYX?=
 =?us-ascii?Q?VgEAO1bhYd4kIy93eCTOpwqWvBQ+RWMeZSMWbPc/dL+ocRp3be6TJEH1rdJ0?=
 =?us-ascii?Q?xnKiWNrRs3UIIBQ+N8XCfet2zOQ9qWhbCBGzlfO5tBdnRhwrot775Sm/yjl4?=
 =?us-ascii?Q?DE2m3qnQhpTgjpKk6p3J89Jf4629r7oFxIqCSTHZeRBHd7Hlp1iIS14jDyBc?=
 =?us-ascii?Q?kebz2MKr+ByGXjsrQP5bEl1SmPyN+NliM5HIIubVxdB8jeSVdpAIxrKbYnPr?=
 =?us-ascii?Q?pZ+fSbUhQ1Je72hNxWUT4arUXkGcN83vTmpUK0fzXil0IDrR2b/YE8brjV+W?=
 =?us-ascii?Q?riqE3FQjG6XB0Ikurq6Zh2y9E1iYe+dD4+1OB983PnjjVB6UpK/A2e65ak3R?=
 =?us-ascii?Q?Q6JG5TV17JNutUWq3cNYOfmlLQGx7cBkVMfSwskj3dLTZCRDEHYYCFCusAxS?=
 =?us-ascii?Q?Ra2D//iK4S6YhcuOP9vSqzU/y4CLDXlSv6WWsKL2A7G52wFhuJlLmLwpP4Rh?=
 =?us-ascii?Q?kEgSzK1e3yAW2sDGHgtCX4UBRhNvyXDGEDFxxSb1uPY1yQBpHQGu+ota8TOT?=
 =?us-ascii?Q?vtsmSX+4gjPcV4QhbFQsPU/b9SwT9lI/W+GuIvsa2gzvK4+B5C1etGBfZRkA?=
 =?us-ascii?Q?9igQ0tvAE44sRHzmKQbGazurlEI+ECdgdvhY9GscuJjfFPgW4pGFukiHOBv9?=
 =?us-ascii?Q?cVXRN0wLDO8IfWy4Gbrm4OHNJwgM5avIUxx3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 19:49:51.7882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5d86c5-5d7b-4e0a-c548-08dde4108ea5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326
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

This v16 reworks the op ioctl mapping


