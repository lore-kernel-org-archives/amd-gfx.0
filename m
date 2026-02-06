Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC4BEB28EC
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 08:35:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7121B10E041;
	Fri,  6 Feb 2026 08:35:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q6qtpCQi";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010003.outbound.protection.outlook.com [52.101.85.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 601B510E041
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 08:35:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jb23Ph4nK7zEK3YDiwwU/zxDtukPcdJWuiCuwrSJspa5NdxDAXzIagl2lDUIqWbBwyCV6SgAZ6BihBdCR0r21tQDOZbxl1A2bMKf5qf4pYhOAzMHyadG6xA4/EWFchpXpy0Ei0LTf+pj4XwoTLhtAHXu9Ac1li6T1WBWNmIDfPlXtsyWZcOC7PDhpGbGc+dDCSbaE7SwMHTduXoCbMMHULXwwhmQPr73CgRfhPsXxtY1UQwzzvlsN0tbw1xJB9XVjdh41nV7kLW8vxAPPiLAkS4Mi6YXX0rdVcdkv+7YOVjmZ0mbfaDL7EfqeccbhAqs9IDp1Xsf3RSjgcNNGaRLMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2R9NYPgcpg1mMZp0oCDXvEaq5rpRHRZOZrnvUtQErcs=;
 b=cx2LOtaNvmys9PACwBpjy4zZP90tnpy6hunA41izMtrZfbJaMPQCOClmRSLsVLZjx0tPP57lCgHahe5NlcFI3mVCsjWMjSkX6y/1RDUQPzuL53owBlXsZEarhXtTPojAvfsUgwbQN4gbiUqOBQ9LfK9LVgVoPfYmAhwrDfDbZeV3s2upiReQdOy7chbnq0RHmwQxGK63L/1FmpTLZv0wfVGNaGxhoeINeSsgbxLciYanGt9fe6RxwJTn8yPoxHBejADaPwP0x8NGWk0wFaxs7fBrsEPnewiXUDVPsmRj5rs+IMdEt75W+g27xLB1LcFVx19o3uahJ71KXZgRMbLKfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2R9NYPgcpg1mMZp0oCDXvEaq5rpRHRZOZrnvUtQErcs=;
 b=q6qtpCQiIxd+lV2UYQoREmh+6knocCqJ+AjiH7Sb1gsEQDzrihD4hbqAEaE0k1KZon8Z+Er0LnIyQLTw+fus8MWeV1Ij1fCNRLe1w7DJkGdCGgz03ENJHi6nCoSzo+JEWVAW1nED13VcGcppsFDJJ4kDDIqFGHKGvU4xNC7XSTA=
Received: from PH8P220CA0051.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:2d9::34)
 by DS4PR12MB9769.namprd12.prod.outlook.com (2603:10b6:8:2a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 08:35:30 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:510:2d9:cafe::35) by PH8P220CA0051.outlook.office365.com
 (2603:10b6:510:2d9::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 08:35:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.0 via Frontend Transport; Fri, 6 Feb 2026 08:35:29 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 02:35:27 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Use U64 for accumulation counter
Date: Fri, 6 Feb 2026 16:35:06 +0800
Message-ID: <20260206083506.4134755-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|DS4PR12MB9769:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eef20d7-445b-4249-b7c6-08de655aaf67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TJjdoJw4+yd/N9H1yzUC1RzUsXu8k1P5lQjXsxnO1aewxQut4FAM5vDzzt07?=
 =?us-ascii?Q?+d3jYiqAnev2wf3asJzam0W3DHF4HZJh8WXNetlMQXu5121D0al0mV+OyzlR?=
 =?us-ascii?Q?9l1dVvBsO4JaU86NeeopfO+beRy/EylF7mB50LZp6673flQvkcmMsfEZWl6K?=
 =?us-ascii?Q?/+uBsj1/7QeDKEldDBatMZjdRqNUaJqvAhN8wJbnK/weL0UV433OJbTFSSw2?=
 =?us-ascii?Q?IVtSAKaIyaH12KMEvNrqd9aSvC50FkhkZbDCOqrbUU1u1noXv9yYnqz1IEC8?=
 =?us-ascii?Q?pfbqFQTQKyBZFAE1GzIC9dRfrbmjCWNR8UAZdqtDIc5sX2zb3weS9cUEbrAr?=
 =?us-ascii?Q?nzTS5HkZgFRYgVuAEhvVpsaQKrqzgzdh7AJCB7CYQt1/RfF1n9hMfs8hDXpY?=
 =?us-ascii?Q?SEat/ww3VZXiLhAkxSDPNjnziOSkPxx3FhO4Ii3+ry09unx6gAijdWM9t5PA?=
 =?us-ascii?Q?ltJzSVNjkDnJZmAx7oEYve4EM+iNB2NDJIci6hwnMB5vekRGrIBKOPEjElux?=
 =?us-ascii?Q?JduQyiQEA8MebALKaGQlao6m/0hf7lbWmJnBbsIzRhinWyt8ciWjy2+WHhSc?=
 =?us-ascii?Q?bBvyIOepdGBNv346rlQwV30D6oZOgPyiJOIDDWcVhiTWRfZ3tjmNF8wvPL3g?=
 =?us-ascii?Q?uvk8i87uJL8Hobp8Y600ARFyi/t2hg6P4Sb4BT0SdR/E6GFfjcph/gbHVeS0?=
 =?us-ascii?Q?+tiRg0RP26Y16hcVqv/7GUcWJW0+7rDZ2BwnJYzTMlnszH5VoMSdtoRKY5aE?=
 =?us-ascii?Q?BUJSL+Pbeja7pP9USxwu1pZVNTdScRG2yPfT2uISk+cjNH9YzhyEYeQvZmnG?=
 =?us-ascii?Q?aUCCm88/pJfypfoXlQapDvTAytFLB32oR6CZxChac49W9i8GEnQ1DACYJO9X?=
 =?us-ascii?Q?ramARsOEpQuMnycQP6Qp9Y7aYMgDGzhb6+vYnGATJnlG3qV7IVrBuihMthxd?=
 =?us-ascii?Q?K7+KTAGPdlxfux9Jx2Xf5lUmLdtRfv80ahn2c0cpDKrA6mxsL3gG0Oq1W8ko?=
 =?us-ascii?Q?Ofoejl1/injCi1O+TxX1wlRq20iHrJ0RDtdbfQt/g/4tOVy82tkeTglrVT8A?=
 =?us-ascii?Q?GWJkZiIYZV49lkjjuzUo5kp4xOxRFh3u+aDv/4hZEFDwgA0+leYYUT0WH/uZ?=
 =?us-ascii?Q?l2gB5yUns8tL35cFQRcVXdecM69nithcKP31KqHhuBiL2L6/fbqkRgPdiRQx?=
 =?us-ascii?Q?PYXmQJpgXe7jh3H2B4dyaYflW565cr1PtViekFjP+CciGhcz5JBqCR5VbrUp?=
 =?us-ascii?Q?Ka22SIYnZDDrCoAwvBzg6s4ytd2mNSZ3naoIX+XGOM8lJ8B+CPfdR5OvqQMM?=
 =?us-ascii?Q?iHxK4Vy0/JSkPHVzxm4lgaMrfUpZ9D6ccxk8l7+25XGa0NghdgsMpfYkFet4?=
 =?us-ascii?Q?mlxX5chOWF8eGZaGG8+Hwta1nm8qrUjhk0pgimp+7SN35cbMA1hdF/x770aN?=
 =?us-ascii?Q?jkc3B7ZIi6cZyV1/TuvUm9f/ZaGd2mBzkq96TXjp3Kx8w36l6w5+nwcFppTq?=
 =?us-ascii?Q?9jAhvPV7z71uFJeGr/IXN2RRJUCph1PuU4MZtzFacSlHQMvU3ko3tWH7pIpq?=
 =?us-ascii?Q?vE5cZU+EnvgJgJ6OxFKkf7E3zY0QW0LbB/69m4GxzWo7pWDwiKHKfmMXJtl4?=
 =?us-ascii?Q?HsoqRX8YTA+cv1EePI80004Y07JMEcrK6Pqd8zBchbxmdmSYn4+l3h1FYdNE?=
 =?us-ascii?Q?tVjCyA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TV4vwktjEfptqAzEUtifyQDEiJUUPkDA1DMfce1B/hYAochx+1q5aSCGkrGvke/CPghZvR83WhpKYu75tCRkLPKjksCOXV6NEthHtiAPaobMrJbP23ZeXsDMp4o9mrcuZOHQcJiQph04Nnwovw6ykA1IFcOjCDpT7Sg1+YQgLjEhl6zBITgvdA1TjYUmccYu5Plvb4eIQhpes8Js15yHe+DqOldt68XAkdCDnkuWg9iSrdUn1vFhWUIUY4RyURPQZsr94nNDwhdeLXaO69WoCDvS8yNgpiIDzvD0muyx/ZoS7ZuXLie4eNAsm6ZZdKf/28I2+8fyMGMmVjfxhHwZQcCfYxYzn56RQ7JbgdPGSYMiS5Ydv5l5mPeYZ4/xHBPjkEdQNVwx4R4GkSQGAfWc3sub1evGzFk5uqe+3K9CnVtSMQUn2gF0m6gAYAIKkmHX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 08:35:29.6753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eef20d7-445b-4249-b7c6-08de655aaf67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9769
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

Use U64 for accumulation counter in gpu metrics for smu_v13_0_6 and
smu_v13_0_12

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 07d4cb6562b0..ffb06564f830 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -140,7 +140,7 @@ extern const struct ras_smu_drv smu_v13_0_12_ras_smu_drv;
 	SMU_SCALAR(SMU_MATTR(SYSTEM_CLOCK_COUNTER), SMU_MUNIT(TIME_1),         \
 		   SMU_MTYPE(U64), system_clock_counter);                      \
 	SMU_SCALAR(SMU_MATTR(ACCUMULATION_COUNTER), SMU_MUNIT(NONE),           \
-		   SMU_MTYPE(U32), accumulation_counter);                      \
+		   SMU_MTYPE(U64), accumulation_counter);                      \
 	SMU_SCALAR(SMU_MATTR(PROCHOT_RESIDENCY_ACC), SMU_MUNIT(NONE),          \
 		   SMU_MTYPE(U32), prochot_residency_acc);                     \
 	SMU_SCALAR(SMU_MATTR(PPT_RESIDENCY_ACC), SMU_MUNIT(NONE),              \
-- 
2.46.0

