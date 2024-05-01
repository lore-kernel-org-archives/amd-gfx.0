Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59333C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D193E1130CE;
	Wed,  1 May 2024 07:20:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ULVQpckC";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 826E21130CE
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:20:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXtmk7nn5NZIU2Vzu7qfa5G1O8Cll0Y2W1h8+e7/oesK2VVwtDbx0HQVqc/Ztg/2uA8aZnn24gCrM9moMItxPU9cC2J5HBamZum1WdEItggc7yBGd1rlXHtJ7aHp9Wi7bAN2x8QG63YJ+OXxb5NfGQpf1sOcMBS8r3RZg5bRKtEe6tIeJX6NHDVIZDPTMze/ZGpXcQhHaX2x2rPntiln/aQzBfeQ0fMbk3x9awblO1wPztLJ6MqlRLxFic+4ycNY+L3lZu55RpdtSH3RxdoJ2UEYw6vdd/6FIFb0kYZQxdWSQ+8NQ3lEMoL60xkiH/kau4RkUEkUt6d7zfYC0/u0Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VDCd+mfmrMO9of7KWQ9AuBPC/d2CG+GHfYMXgRufrg=;
 b=UBzARAHehDhcqImvc/1IeQmtJizKTWGVBiB5APvNBqoERnWJ0kyGfQpR5bgpvjJoAl1s+6xZDEyMWqSaAwEZfNHRLmVVJsbVGFFsv974nkXiEFCxJfx9kLTni2QlwD/HES2YCi8DCZP67eOvyEukXP/4BR86rJg5KCWiDFgoQw8oiPbUHfszy7tQPMgCOWfFX0NURimodoM+KUPfHSb0lr2MNg+CXuzpPKo9OpkVfX7drB7HRsJmq43+H6bFXJKCKdH0IBpL+flWpsns0o8+cIXc2MvfRnuuMB0WyVJYr1iiDm25xOYxIJ1HxiOgwxUoTFgLZGR8YY5FWiiMdwUvuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VDCd+mfmrMO9of7KWQ9AuBPC/d2CG+GHfYMXgRufrg=;
 b=ULVQpckC3v8krBs5mqQQmieQdCWCZ9vfIUXwOpyL3k5nidsfAkeksY/wLI4YC5R99GVe0vd7nOrTwgiCpWmG7B7fnkhHY1siZDxmimkICgTcwiXIJAueRmOFlzHl8AetSTGINt42wHxvbdZpzgrzvnN0Ntm+TMO/4V4eXBETrIs=
Received: from SN6PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:805:106::27) by DM4PR12MB6613.namprd12.prod.outlook.com
 (2603:10b6:8:b8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 07:20:10 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:805:106:cafe::94) by SN6PR2101CA0017.outlook.office365.com
 (2603:10b6:805:106::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.24 via Frontend
 Transport; Wed, 1 May 2024 07:20:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 07:20:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:20:09 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:20:09 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:20:01 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 31/45] drm/amd/display: Fix Coverity INTERGER_OVERFLOW within
 construct_integrated_info
Date: Wed, 1 May 2024 15:16:37 +0800
Message-ID: <20240501071651.3541919-32-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|DM4PR12MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: 333a64e5-fea6-4a29-a591-08dc69af22d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400014|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QtwvQWCGh/7kdJo8+huQ9Kl9MnuG6AJhuBARjGFPZc0qmaa5S9lX5LhRzeHH?=
 =?us-ascii?Q?Gbve1jKLqgiLKWjNaI2oM1CVH+0fBZW9PdPravUkeuJ2f0kgKD4PgRvqs0bJ?=
 =?us-ascii?Q?vEYnzoLrX2AEON9UJPUVxB9NQGxjZ44Saf62P2ADmnyRVCth0FiohLCvW0Nl?=
 =?us-ascii?Q?cuxKqSPmkVtG79VaWQ7lEUO84eygMFIQwSGNIRnhbVNjOwCorYasa1L20zO2?=
 =?us-ascii?Q?UfnfdI928W2rHQjJvezESIjWCWn6I9hKzjSY7wy2vOvVw6y3p8/Gl1RYEbEC?=
 =?us-ascii?Q?FEyCFFeF3Dnd2FoGmklZ53zusZSIefF+Zxrq2CWCFJQmZKxBhjVWCwjS1lWX?=
 =?us-ascii?Q?0gMjYib9KCJmXZb5xOAp1PJ9wsMnjXdS7MEqrxOk8u3+mdW2sjrxTWklLXEi?=
 =?us-ascii?Q?SrBdBx227ocmkq7u+ZnFjbti1C/nlghMYH2aMAx9vLuB20bWjSuJCv3KodPm?=
 =?us-ascii?Q?meEG7CXTnAdgg+sumn3T3yIxjNefAqyMoC8gOU4tirZiUyAjfkrRGrfLh49x?=
 =?us-ascii?Q?oePLJdeSJjos5yN767wUp4IqylI/IKcn3PeSfaZgRCBTtyra1ql+G0SRn7o8?=
 =?us-ascii?Q?peTjIzRUSNu4CVVe5xkaX92aggebzi34YSh5FCL0Aqg6iB7Cb4cglkG/9oMo?=
 =?us-ascii?Q?VnhkqyDAO6PSlT1RzsDMRxTyihOooyLypwBYpIQzxvDOWjONgCa+m7VNqdC8?=
 =?us-ascii?Q?H3YwmaYH7FWEboqICYJQrV/r5vDq8yFyHZg4qUUKBjyfDppIttr9eDz9arei?=
 =?us-ascii?Q?00O6ezdQUYSfyGfUcP3X3zhf14g3wouHGwUpOv8dl45oFIZGpAXVO4H7ZZHd?=
 =?us-ascii?Q?fn6XJIHaFAQZjaWBV2cOG/io9+rmYbLcrpqzKvhsv1QNh9B8ZHRu9FkBMO9O?=
 =?us-ascii?Q?ugRoE3guUnCFyR0V3wkg4PEMV1SBgES86wIKDJZM8a+WAE6DMWl8FNe9WuGd?=
 =?us-ascii?Q?6R++ra1b9XbIYmMfziv6ZmqJPMSp7IxyZDLBF62L9jeWYbvB0V44ONT6cc5a?=
 =?us-ascii?Q?ZRLzH8EPvmsoIDUJhb1RC+qG1Sv+ep2bntEV16d3J4hK9sTcrWeMrgWPsTto?=
 =?us-ascii?Q?l2bV7dXjxvUKVVPLlyGjg18rTTX2ni5XIkf+/Uk3wCYJCYY+/73ksM8jQxwS?=
 =?us-ascii?Q?pnZe9bEHTJONPVOGnxyT5/I5f/vhgAZoBoj/Urw4CxqaDKvUTA/woVVsbtjk?=
 =?us-ascii?Q?OrYilQd90ohk5oQFbxCBNC5pUM9SbsOffg0g7oKCSByINGJ1tQS2jbPwnZCE?=
 =?us-ascii?Q?2zwn9sy3dUH/VEx5KyjlRF32Szre2lnnn+pW2QdAddSbsMBlGpeRlimDQpb4?=
 =?us-ascii?Q?SL0UjkoG2/l2ig4N2hn3NCaFE2CQb3zyW/48nLtO3ZKGdOvtIJ9K7dheipYW?=
 =?us-ascii?Q?44c2QHJvUZAQ44BTJt1+fJ4Pjb6r?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:20:10.3828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 333a64e5-fea6-4a29-a591-08dc69af22d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6613
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

From: Hersen Wu <hersenxs.wu@amd.com>

[Why]
For substrcation, coverity reports integer overflow
warning message when variable type is uint32_t.

[How]
Change varaible type to int32_t.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  | 4 ++--
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index bc16db69a663..25fe1a124029 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -2551,8 +2551,8 @@ static enum bp_result construct_integrated_info(
 
 	/* Sort voltage table from low to high*/
 	if (result == BP_RESULT_OK) {
-		uint32_t i;
-		uint32_t j;
+		int32_t i;
+		int32_t j;
 
 		for (i = 1; i < NUMBER_OF_DISP_CLK_VOLTAGE; ++i) {
 			for (j = i; j > 0; --j) {
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 4d7006fdf345..0d8498ab9b23 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -3003,8 +3003,11 @@ static enum bp_result construct_integrated_info(
 	struct atom_common_table_header *header;
 	struct atom_data_revision revision;
 
-	uint32_t i;
-	uint32_t j;
+	int32_t i;
+	int32_t j;
+
+	if (!info)
+		return result;
 
 	if (info && DATA_TABLES(integratedsysteminfo)) {
 		header = GET_IMAGE(struct atom_common_table_header,
-- 
2.34.1

