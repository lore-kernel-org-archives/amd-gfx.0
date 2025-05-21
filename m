Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E40C54E65
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 10:14:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B35E10E7A0;
	Wed, 21 May 2025 10:14:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AmXkJNNP";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C840610E7A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 10:13:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTMDbJtOPiXupbGCva9SvYn3+SFpV536j47eqNP7OsHNhH2xj6lXP1/5Yt+sPf5/zFVDGjGwTntJdP5SDsH3llUppMnnwYOAujj24XeXlYPQcZqlIzC6eaMZR6RSXv7tjNL1UdVmw9qpy47ZRq8crvkfqq93Hbk9ay2TQbyWDZTsf4GIWXSLtiaik8SiGV2sOYusjxcRLhbdQrjJalaB+qbPM7Ld5rjHdr9RUDgrF/FIajlMtYrQY03f0geUHhdkSvX/GMWZHGP9bYPhyop/G24Jg5+RTS1qyIj32t5BZkaXfOFLs49DW7+bvQ45PLHZOCT7tqoWAmt1vYyitiI9fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzWbaFLRNpt6HY+6OLEtk9v8ftqhECR5TfuPxfz+Tco=;
 b=iI2kuuByoACk0yY66gbqw09QqKjVdz0Ipf/HKjR2qqTH0xtYC8Awj9MDJseBYQ2UFBsssPSuNUXHQfiygPG1WxtbjwmiptOcDKUfG5Ao9FyBRa7CY62OYQnr9Ve/5cIeNRlUiRvydwivYLBU4IqfHCGydgSX0c4An9sD4SIfjdfR+Feic+k+GWGB5RxdUtKOqe7tIE49z1Ui7ToF711K5YJP6JpTMXGcUKpkb8OrMqR/RnVoEXsGCcuILqQiZ6uzp1zST01CoyDjgJRz3rXDNwqWoCPE752Ksiyi5sa9J52z3RLI7C4pBYcMOR42LxX3PjOkmHiQzKy/v9WjBqbZWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzWbaFLRNpt6HY+6OLEtk9v8ftqhECR5TfuPxfz+Tco=;
 b=AmXkJNNPRJ91x9M4E63K7i33+3AGKG7O3qq5JBtb1C7yKSkKYPe6h3lCBRVVsScoMf61+Skl/EQRq1EF2U+89crP7rxUtBA0wZaQx49g3t1hCakC4zle9JEn7PL9aZqm/v3T0sPfuu8M4NoGlwaz+P5urjo4kGrgIKgvstOwT38=
Received: from BL1PR13CA0261.namprd13.prod.outlook.com (2603:10b6:208:2ba::26)
 by PH0PR12MB7011.namprd12.prod.outlook.com (2603:10b6:510:21c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 10:13:53 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::e) by BL1PR13CA0261.outlook.office365.com
 (2603:10b6:208:2ba::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.16 via Frontend Transport; Wed,
 21 May 2025 10:13:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 10:13:53 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 05:13:51 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Philip.Yang@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH] amd/amdkfd: fix a kfd_process ref leak
Date: Wed, 21 May 2025 18:12:54 +0800
Message-ID: <20250521101254.831862-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|PH0PR12MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: 195488c0-3dbd-4622-9c98-08dd98503058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WO+cOyzWYjQfFGzOQbv9S/5a/pUPACM8/Bvm0IjSwGjiOzdk8B8/9ZTfpLn0?=
 =?us-ascii?Q?iscXzqS7yokgajVaDuZJolRZSCEdFskM6jeFMeJCYtwbZUZG6rihL6m5MSQJ?=
 =?us-ascii?Q?GrrgA+e/cBhPT+THDirVi7XzQ8LhupOi2/qS9WtKG6/EcxERx8ohEW5fdvgd?=
 =?us-ascii?Q?/tg3/V3kFn1KrwXys4QrRyKViDfcE2Plev5zlr3OIXQBCJCfBy9YdjFDCBiU?=
 =?us-ascii?Q?24s3Y8WHSnfNQxtCDoJ9eDa7IknbgBKR6PlqsG15uVuU7vYUA17WLy/qJNI7?=
 =?us-ascii?Q?NYT59o/3TJxp3vFJ0be7YfCWNRWp0mTftHQRORoMb3TDGfVKvrjVWh/uLWca?=
 =?us-ascii?Q?nNKr0EaelKshxorvynKMcWRAYll3PeQBt4bdpydV2gWA/I6+0aZSU9AzoGGO?=
 =?us-ascii?Q?NCOUuDOLLpDAc2Civdqel3CUuRsWdDqDsm+dC3xMSrbUs6VxMY2rzjPvgSQy?=
 =?us-ascii?Q?GTkPFsGZ0uCI6jG0xU82XBdOipIL1IxjZeVLLAHdMlaQ6vjc/cR+Ih54eFfK?=
 =?us-ascii?Q?EDLAJRzt9YpIR9BpFtOHWCcfaSY9REIPGbmu8Q7mSoHKT3cBa3B7nOR0Hc0j?=
 =?us-ascii?Q?XlsHON2F5zE5EfCE4Ve4s8UTJXo8SR/BTK30DmOUcd2Hvg3iH1piLkBknb4B?=
 =?us-ascii?Q?KrxNV8xkBMzBYIZuNLXdwH8o7l25HA3/+9tkF2bV8HN22l/Df6kk9Rld2cbQ?=
 =?us-ascii?Q?EJksV5VoFQemciUUXW2ufsjXffiJEb/80u9n3jpBqRV7S6tt+XB9/0732TeK?=
 =?us-ascii?Q?PEkfThH4rGY7uRhOaJK85fkDLpsoJFdx8d9KxDBn3RTFoBDmEPtkztg6UTJA?=
 =?us-ascii?Q?+IlskLsAmbBAH8zI1d6DuHv6eV9ZbPI8cQZYffjF7BfeRJedc0a+bzU5RLxa?=
 =?us-ascii?Q?kt9rUYi5Q16XWbkLZmRw1PPIbPmGGvTslJcPES8G97+sD8FMmkCKvAK3EzVq?=
 =?us-ascii?Q?rWcyKTdt69+D3Ip7yCLixJy8LxA8yRJeOp6YZp4SjDVHY+e4tzJ4F2BuidW2?=
 =?us-ascii?Q?k34wF46u/L0iowIdXyig/UgOhm3Pi8Kk2NWi+hIApq+jC9ZUF0Q8TwS/Gv4E?=
 =?us-ascii?Q?SApEpqFxrKVHBvMwIFiy4m7pRRpR6JugUBaEakkhmT8VtTArsuQMGM4ndg9c?=
 =?us-ascii?Q?yKNloimZ5SXD+gv34rIYi2n1j9EmdTPmYSMEj3NN7cpGqGPG5F+HoHhtTvQJ?=
 =?us-ascii?Q?7W3NDwmRE6X3cn29ej0xHu7M0QqgPqvubEUM6iF9lcZYZm1O6cUfrnTjmYgc?=
 =?us-ascii?Q?JjdDs4F8uJZYamqQhKM+cqmrWjpV4gEEQuZ2xz0zcgXKS+xLWfOt8AVMWW+s?=
 =?us-ascii?Q?LrxPMoMV1CrLseuJYBObZgIhMaIP+wO/Oqw7p8t9SoekKrgMMEVY3HLo+rRo?=
 =?us-ascii?Q?eZr52KFkCALmHJK9QCc/U/1VFDgL5cHROT2z9U/P+EBUcFAj4u/AhUKb8BoB?=
 =?us-ascii?Q?4NuSdQrkfwC1N3rUIBf0sdzNGDe8e9LVBjYT4nDgGDJa2BxMLhH6LW9AnTn1?=
 =?us-ascii?Q?l3mK3eHRiqxtx06yO6dEXro+Rotg8D30IRcf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 10:13:53.1973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 195488c0-3dbd-4622-9c98-08dd98503058
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7011
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

This patch is to fix a kfd_prcess ref leak.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index e54e708ed82d..2b294ada3ec0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1350,6 +1350,7 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
 	user_gpu_id = kfd_process_get_user_gpu_id(p, dev->id);
 	if (unlikely(user_gpu_id == -EINVAL)) {
 		WARN_ONCE(1, "Could not get user_gpu_id from dev->id:%x\n", dev->id);
+		kfd_unref_process(p);
 		return;
 	}
 
-- 
2.43.0

