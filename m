Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCD1E8783D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 15:13:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 951B110E6AA;
	Tue,  3 Feb 2026 15:13:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PvxMIshT";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010015.outbound.protection.outlook.com
 [52.101.193.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D01110E6AA
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 15:13:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYTl/mUa1GBl3wdWL/Sw+mSdAA09xTvqjLuBM3uUWctrQ4LJQ9wZVKM09ulYWqU/xf0zgphhn960WExvztHdWWoJQcS6atwDIOZm1G0LCH8EQvb9cgt9B61anLT4mzE+9MM3XTwEVM0JCvJtW8x2dEkRTCQKGlF23fLSKyH4P/DvIFGPQK1me+6Z+MDxhFTxG26a8UFjLAKPWHZ9IAlor9p66zrr56SIE/Y6ZIWUUWAf/b/ZRLeSiiXg5ZLShvH2ozrL3g/qIkloegvnAPWOF5Re1Pn9tuHzP8zOJ+PViFqgZoPY6fTMfk59z/8CV19gtLm6JIfMcFMO0yMOOlw0nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/6nhuPOtepZZ6Bxtcy8BXp7QhmfxOwqP1ZBIvEKQlc=;
 b=DKzmnTAIYJctZnMmoT7x7QJB90PE9U+ROGrplzCebMpnpw4gwrBzepUdQJPinIr/VgMKBrocCwcd2r+800r1xnm5iyGBu0Do/CGAFdNxn3NWCha5+aIuc9Bxdq6P7PJ7sSSL9+Y+CqyPXmlUpVYGiFN44T+SESwTHxHlLt7jj9tUnvBXqgmyyPPFhtuKcsRNgcaZ4AzPlxjsDxO3TIwwi/eDyXqn6zpfv8BIzFpS1ZjnEjf30cIes5D8fXFtkbOh7i4b69A+o9USikPu/rj38ei/CDQKfqKHHQKb+6FOAh0se8UXoWLV62t524RIX9CgYavLAN/bt4bnMCxHFOlzkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/6nhuPOtepZZ6Bxtcy8BXp7QhmfxOwqP1ZBIvEKQlc=;
 b=PvxMIshTfycVKz0M1VtlbaFQeGhXAqo7EkcfdgE33JiT2XuXCPSScntWLJWNOYYbCAd/YNJvPrGEKTpWfLcAzP7R683UoBVryGMigw940V/6wn6PO5nosjrBHRtS/OnWpBCX6xxHy6CeQ372B7flH+o/x7NzLxdFCyJqunk8oZs=
Received: from SJ0PR03CA0120.namprd03.prod.outlook.com (2603:10b6:a03:333::35)
 by IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:13:33 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::10) by SJ0PR03CA0120.outlook.office365.com
 (2603:10b6:a03:333::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 15:13:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 15:13:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 09:13:31 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 09:13:31 -0600
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 07:13:23 -0800
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 08/16] drm/amd/display: Parse all extension blocks for VSDB
Date: Tue, 3 Feb 2026 23:01:50 +0800
Message-ID: <20260203151229.3673042-9-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
References: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|IA1PR12MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d4d2395-f22c-4c62-1677-08de6336cbe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c8zDjdkjrdiG+tDbpWj2/DJGh3kqUuAHc9N8PLgblDWikHN6/obCQINW2wrG?=
 =?us-ascii?Q?wzOT3rfNVbg3vQSzr5gKp1/FpFzSPJoJj0wIXNHIlJjkuVX5ZnSGOz/cN/rb?=
 =?us-ascii?Q?puhUm67wscD1WuBcwYSBkwnsFXVPbOJzirxelU9bRMgx7m38k54ydE2gmJe6?=
 =?us-ascii?Q?bwufLJ2Ks+thNQr/GDrk2sYkV4yYNE/hqOMGqSzKaLmMJ8zMUhgajviBgCFl?=
 =?us-ascii?Q?efgABrGnqNGyPiLtFeiRYjxig8o4QwNKLBsnwEs0WD6k2dvKMr3T0cHUQFh2?=
 =?us-ascii?Q?guOvxjHoV+TW9olL6qw8pa5lEgUUyil208aP9cYQ0dGx42C2Dx1mwxMv6dDF?=
 =?us-ascii?Q?LJfx+lJRcXT9YYrvix12XWyb7OgskWq3qH0NjIKKpj0vn+FMKUJfzkJuZLQO?=
 =?us-ascii?Q?P2DfVXsVWYZRdyxysNy6+gw/FXL1S24WDvEyWcZtOWAttnDdX+VCbIoIBycC?=
 =?us-ascii?Q?scY84q3IRsLwBEuf3uJ/3gZ7ZL3W0TfTp/LHJmRP+scDc+ZnviurFGhCo72m?=
 =?us-ascii?Q?xHkXvWpz/CdE56FS17QFnIGwgjPvRazOqd6BOyGmSHl01ErYu09Ya/Gz66du?=
 =?us-ascii?Q?gMye8edakAKi+J9JOltVJ6J5Y8TIilujBK2bjDRO1vn7g8VVSRc1ZFLuZf4j?=
 =?us-ascii?Q?lhGG16fGTxJHIGmGw+MQXT/DV9nW2EYppeV2VcFrWMcfnUazJByAa7Shs3g0?=
 =?us-ascii?Q?E+QRU2KZ+fsob8LmA2rMijVaZeuEkLpstY/uYsBU9/8aIUSdx8jBPolu7Uip?=
 =?us-ascii?Q?RcM+gaU8QeOjwJ+RSm4AJEWrTo+x4XNEmVfJX4PR18CN9EIkoNcoS9lXXteU?=
 =?us-ascii?Q?AxFRSY/yf6jLranJJiW6FOjf6VJCxByNW6qkhrxf5d4LnnUOqX4EOYroupKT?=
 =?us-ascii?Q?WDNvCx6DgNSEz9+4dcBBXE9PDV4AAJ7+BDHn1skOhbTzSxl6mHsuT+XTiJvI?=
 =?us-ascii?Q?2aG2UQpE8TCuBugTTLbs65NQIMlQFE/ZfO21g+swhDeRrVnp9lQJrQkza7Ve?=
 =?us-ascii?Q?RzE5F8GrYQ8FpovDDNVsnUy3VXf6lzruL+EoHlpYkcdONVVkNlb098Ud9RGI?=
 =?us-ascii?Q?dQFyYYDO9IFwyi55c9LpCOf+f7hxiQTszIJw5UaCWOXSGKvv6klyiXk6+O/B?=
 =?us-ascii?Q?h8N92e1i4+jRtJy9Ag69Vvmpl7kqwfaU/0b9V0MWdTq9oWiqWujgq4V8pse6?=
 =?us-ascii?Q?ItP98dmifcp4JMZpSkOAVKWo2DKCgNMMxHGN0DSbA9rrioa2NNK6yITpOhM5?=
 =?us-ascii?Q?DOlzXHyCIHgJKJmc8M+2H2KzF7qQAj0Dumq/lRnvTKB1Q4cTsbCvq1cmu6Fd?=
 =?us-ascii?Q?yQX4Kuatb5+QyMYW5D7/fMJbJX8zZve2qgm7jL/XfUcAlHFkhmHf3Ka03Q05?=
 =?us-ascii?Q?lCajcihGDp7YbC5NxbrLfT2A00ztO6U5/h2fsB5iBaJQqLweDM0aAPrVX8Gq?=
 =?us-ascii?Q?/olJm1HYkAqpiopbjmNIzljwsDfVp9mZzHHCP+T8r2SRlC6sQWY54X/iEJNo?=
 =?us-ascii?Q?iL3VpmkZja31cyhqPydf/cTk8lhFbk4x7tdAwM77mrH5YuF7QjvNUlbuR446?=
 =?us-ascii?Q?ha8VL90TfwZps65d0sG/VZ8e/GBF6JoOv15t5EPmxvN1FXwzGPi8KNEPgGAI?=
 =?us-ascii?Q?GjSl202iqPrcnsYCM0x73fNKMN2lGG4wXXHob0idRqY6aHOahZvsph/RtVT4?=
 =?us-ascii?Q?QgII9g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a8cDt9FPo7zOkPeJEVyk766V1+0pQ17gPXe5wXZMhkNHUf23u0v3T60/Gea2vdvjBsnRzHoK/oTLUl4RDujHjZq+IjYLJ9QqUDKYS4sUA0WJ7ruJEUgl6bNZ4UkD58zCo+lQGdarw2Lc+K7OpiZjGOnbty4+aP6hV6ZqxDdt9b3PQFdTgMmVdCyuUHqC5jh7xIQba8cFOFLDJWDo1aHre8tXRqlXggcCCFWD5PpkOlbm2B0//0HyjfDEqK49kw5f8o5NGAG0HbySBfkHAtvKMsW98JAm7YfZxJGaPdtX4Np8ZMOAZnJ1Cc7ZKgEZYLXc2VD9BpSTuUvkJOybQTFWj3Imi7heeNk8ly9bkCwe31jt4n+vyN4oKKuGD1TGbVHPiPkWWzbMR080kPs+xqiuzHEaUgbugC+ftDbClwmC5eQ2JqfG1TgZmE8WAcqAezz9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:13:33.2264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4d2395-f22c-4c62-1677-08de6336cbe5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616
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

From: Ray Wu <ray.wu@amd.com>

[Why]
VSDB parsing loop only searched within the first extension block.
If the VSDB was located in a subsequent extension block,
it would not be found.

[How]
Calculate the total length of all extension blocks (EDID_LENGTH *
edid->extensions) and use that as the loop boundary, allowing the
parser to search through all available extension blocks.

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b9e8ea4396b5..7af538adac46 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13135,6 +13135,7 @@ static int parse_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 	u8 *edid_ext = NULL;
 	int i;
 	int j = 0;
+	int total_ext_block_len;
 
 	if (edid == NULL || edid->extensions == 0)
 		return -ENODEV;
@@ -13146,7 +13147,8 @@ static int parse_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 			break;
 	}
 
-	while (j < EDID_LENGTH - sizeof(struct amd_vsdb_block)) {
+	total_ext_block_len = EDID_LENGTH * edid->extensions;
+	while (j < total_ext_block_len - sizeof(struct amd_vsdb_block)) {
 		struct amd_vsdb_block *amd_vsdb = (struct amd_vsdb_block *)&edid_ext[j];
 		unsigned int ieeeId = (amd_vsdb->ieee_id[2] << 16) | (amd_vsdb->ieee_id[1] << 8) | (amd_vsdb->ieee_id[0]);
 
-- 
2.43.0

