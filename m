Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65890C87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 11:58:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8EBE10E2D4;
	Mon,  4 Aug 2025 11:58:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A/+cIbAY";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 634AC10E2D4
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 11:58:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSi75YE7cECL8Wi9vaWqNmPN9WCgTCNmoT75a427RxwynkC3XRnRSOA9VM3BSDvN19q6rD7askiBLWfhUBBEi9P16i0Spk8h49FHHYX5qCcmi/yWb3+I2AQIuC2b3JgGOWmQp/tGq2FL3Rxhrmf7IWelK12ZPBKI9X52x5xAlnGJH38psvT34U4dxT4mRPyfsZYUNC739/EUUV7ZBlo8x1G8UHKKm4sEF2prvCaKaG27zKPOa8NX9vkfd25AQR9qJ+muxrLjV8ftpgBnqtrZr6V9g2gM8bX8J7DZYHUcCwYnRHZeskJgJJINcZeG/scoo2P+qv8qJKv3VKSfJ1eqIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fi7G7J+DEZa1fHhKCfbEKmb70ETpgTtfU02JnNxYhY=;
 b=AST/3qtrU2b434Zje0GlfsSKn2EoLDdbQyxhQXY4TfAFplTUzZPtx4B+HfXfuO7ZUUKAweVLt8iam1gOLMFhdxq3IF977ty97OmSJ12f3b1YzQyIu4FOD2xs37cFy7Rjrssxrc+r1lsrC9W+BHmXmoQd6+DpuQ+atV+hJ9ViJpbKQeHJhbbtVZG36/hZGQDn7wnKxcOA1qI5njJHKJiaZ/mPweUDfIbf9/t42JpV/Zkglr44/f2n4pIw4gmTz0oUsP2QfhHAJi0CI6URZDYC0HbhZDNWiA0NDr+IISeIDNBVHr/lCsSn9uEvmKRMUylHJ4FUhdnwen6Hi4vn9hoKhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fi7G7J+DEZa1fHhKCfbEKmb70ETpgTtfU02JnNxYhY=;
 b=A/+cIbAYN59Qy6nfYx7vGN754mumWiY/ffnBYb52SFUBV7j6TVtXUbl8WrEKLsgUUzOTSaF/vOw8qsWY6two9lNrXiY8738DGW5a6FxysdrIndncUJWMO3uybYI5D0fVbKeV+3n9LhX0lkBOX7Vl0A7Apr4oloCqJg8l+Gr75uw=
Received: from BN0PR04CA0203.namprd04.prod.outlook.com (2603:10b6:408:e9::28)
 by DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 11:58:34 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:e9:cafe::34) by BN0PR04CA0203.outlook.office365.com
 (2603:10b6:408:e9::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Mon,
 4 Aug 2025 11:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 11:58:33 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 06:58:31 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <jinhuieric.huang@amd.com>
Subject: [PATCH 2/4] drm/amd/pm: Add unique ids for SMUv13.0.6 SOCs
Date: Mon, 4 Aug 2025 17:28:06 +0530
Message-ID: <20250804115808.1758735-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250804115808.1758735-1-lijo.lazar@amd.com>
References: <20250804115808.1758735-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|DM4PR12MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: a66a040e-d57c-4fd1-4fc7-08ddd34e3c76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ppYlIduxZh8/x9tus3YkRDWoD2tSloE896SD/ZycsNL/fjjfDgvmbGG6oK9L?=
 =?us-ascii?Q?1iQCvcRkOmJw4IbOrv/cXAq5cEgTpZ5swkxVNY2+tJdBmTbqtCLdm9dH6wvx?=
 =?us-ascii?Q?LObWcLRNc+8Wqg9uffCBYVeTFvcRkK991nsO4tBj+F9i7DS68fuITX+TbT+I?=
 =?us-ascii?Q?z0wNQnBRu3Kur1Gv1OQljWu4kfmXj3CrnW8iCivxn5lxknXiL12wY0fPG6mr?=
 =?us-ascii?Q?X/U9f/5SMbzer5J3SFlFQTMrs9QjUlSTS0QePpxuzyAev7xZGC4gUWSzsmOg?=
 =?us-ascii?Q?qQeYWRQOjANz9zGaeYkw1a2b//D8TQgVaQJWUL+stDKd+WFO8y41Kup7GIQC?=
 =?us-ascii?Q?/8LUF0ycv/iMUpp+bER4AtPFBhAXn4rBrQnJkWOxn/sBpd/2uG5e4W9sJcsQ?=
 =?us-ascii?Q?LaVVOJ5Qkq33G8QGQCohAI73XhgEGpijSm/TCOy9uy6ShvlOKmXDHpriWe3d?=
 =?us-ascii?Q?PqYtVlh7l57fzOYdh+VliuCqIbL4DTOXVPjl3I3R3jh90PartU+URJa0kFUf?=
 =?us-ascii?Q?IDTCMhygfhU+TayGWk00DzntvjpHt7kUKJX2yMs4cdCcSGcNMzdul9/K7XJ7?=
 =?us-ascii?Q?SnjsRfjLG9XbMbICrN/mKBkoZW8GzPpetRAZtJiC4a0nkQdlaO3q3V6mKuKZ?=
 =?us-ascii?Q?SMXhG4ABqtslEqToVaSYMSVwBqrULQ4myyffHTrUcCMDjGLwLbmM3EdyP5QJ?=
 =?us-ascii?Q?bsWSWC3uml0drJcd99Xc4S7O0Ek2+1DDbKVCCImBlmrhWEsl782uFKn13ly6?=
 =?us-ascii?Q?OAUlwEoopXgBXji/m5qKRrE9V9jJMSAJ8jSWnCNylBEHmLMVcnETzDadaaac?=
 =?us-ascii?Q?ifcxDG+dp06TzGgObcilUYOc6b+7aQxr3ULjn2NEUX5mBz0V3O7bpVktE0tp?=
 =?us-ascii?Q?lWnbqdmRjLP2Z32THoe8Og35gf/ShIqJ+DxPDG8jOCl5ZymGyPkgrGRPTgqT?=
 =?us-ascii?Q?lWlsAavQnlDuJhDJacWdLkKOCYHx6DIryaqLolGj9G3NAWJw23DCzUE+D2/0?=
 =?us-ascii?Q?kaOuVA8p92fN5/TgwVzDkJmkcgfVcqw/D6zTRRwElJcKX2Uw6GfyNPytJf/O?=
 =?us-ascii?Q?da8ZzHPvgIv5EIJsaCwYDk1BWivZSwh1dOyVVN2ad/H69FOF3QUODkahNsdj?=
 =?us-ascii?Q?OVT7Iwa3WoLDb/ABAhMV+TXgg/Z3P5DaSsb6HZ5va7Nugc38Pdk2A+UsTllo?=
 =?us-ascii?Q?tOrTC9592Li33dPWPL4LIJ0a7x7jHzEowZvqRvStG0Ezc759vy0mR4Q0Mmv5?=
 =?us-ascii?Q?8G5uoKZCoYwo8ZC//TUaygoNOi+udBDB9+1z5GH0bE4nnu4JCouC+H1/I4wO?=
 =?us-ascii?Q?p9bRfx1DM9ea7spccsFhB4vLRTbSh6Fv+qkfn7pICURLKw/csskcPu2E1CvR?=
 =?us-ascii?Q?iLH67gbbDaEvjUU4OQONh2lnv04EMQhMkMJ4h8GL0KsEWwZPRjIIRYyMNQoi?=
 =?us-ascii?Q?LY5pl4pXZX6K7tnkBhJYzCDZbdzlcQD4gUiLcWDn0aIVjZD7VPRx8Vn9i3PA?=
 =?us-ascii?Q?cMKKiVes1/SVtY345MoPuxzCbJa8klzNUjQu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:58:33.1346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a66a040e-d57c-4fd1-4fc7-08ddd34e3c76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5771
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

Fetch and store the unique ids for AIDs/XCDs in SMUv13.0.6 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 9cc294f4708b..1a954e676cb6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -803,7 +803,7 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 	struct PPTable_t *pptable =
 		(struct PPTable_t *)smu_table->driver_pptable;
 	int version = smu_v13_0_6_get_metrics_version(smu);
-	int ret, i, retry = 100;
+	int ret, i, retry = 100, n;
 	uint32_t table_version;
 	uint16_t max_speed;
 	uint8_t max_width;
@@ -865,6 +865,23 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 		pptable->PublicSerialNumber_AID =
 			GET_METRIC_FIELD(PublicSerialNumber_AID, version)[0];
 
+		amdgpu_device_set_uid(smu->adev->uid_info, AMDGPU_UID_TYPE_SOC,
+				      0, pptable->PublicSerialNumber_AID);
+		n = ARRAY_SIZE(metrics_v0->PublicSerialNumber_AID);
+		for (i = 0; i < n; i++) {
+			amdgpu_device_set_uid(
+				smu->adev->uid_info, AMDGPU_UID_TYPE_AID, i,
+				GET_METRIC_FIELD(PublicSerialNumber_AID,
+						 version)[i]);
+		}
+		n = ARRAY_SIZE(metrics_v0->PublicSerialNumber_XCD);
+		for (i = 0; i < n; i++) {
+			amdgpu_device_set_uid(
+				smu->adev->uid_info, AMDGPU_UID_TYPE_XCD, i,
+				GET_METRIC_FIELD(PublicSerialNumber_XCD,
+						 version)[i]);
+		}
+
 		pptable->Init = true;
 		if (smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS))) {
 			ret = smu_v13_0_6_get_static_metrics_table(smu);
-- 
2.49.0

