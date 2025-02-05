Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB1BC02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 07:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D464810E741;
	Wed,  5 Feb 2025 07:50:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bUVPm8wC";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C127C10E741
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 07:50:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DU+6eKo/fWM4TH3T9+gLgfytpK3090DAh4Elkjq+0wJg/QIfUQAohrqt1DwEWF9a6SPSSN0DFigSR2/tO6Qsrv6MOjsU5zBsRiKXla0Gw6DDqSHg3eWkFFrGKcFpbZ3q3nzqtL3e0lPw0v+bUr546k+5DqtVUmeNcEOf6/PFKrd8OQIRWpCr0u9DomPR12pcPZgKW8tiYIYQfjwxTT7l709BMAqvH1fHPrMt+1trXhqnNtzXBPYpZUWuERaY9zSRJyjKv9BZO0iUa2iFpPG/lWJwig82zWgZk9G7/DYqs6CnbCHfRiOc03Z2nUmdpBSNBlKga3CV+wigfknZyFVU7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gI7DcH9eMuF8u90fJ15NShdDucQMKvMN2PHEe7oE00=;
 b=UTlxL+iropVJURy1dZmuyJQGktsPcmDF5ut3B7kgkTlFeX3uUciLzoAg6W8n8+HeyIWGfGIpMj7xg2MlSNTil76yWam37xrUUYkC2haAcGT+NobIbx8yEhpdYl6cmDSQATnKwXZNlub7Mj7pJjLHOMxprLATC12YduIAzJA1eBGtPlkZHpFNzzk8KEnH5jpGf6ca/AU+edk+9jvoE8XGC9GcncCew/KUsrMxPZQiYvKz585ak+h50qyWT4fQKTJubf16DzsiE/2kDtcEcE+Fl4nSHzazpQriCjjouRI6IGzJfeolX53SHm2/dseWMJKyUKgMpEVqucgjYxPx1TS4aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gI7DcH9eMuF8u90fJ15NShdDucQMKvMN2PHEe7oE00=;
 b=bUVPm8wCHe99XZf3MVoR1MiDG7s6x/zfVZ1NUOP/WphpteYnxfTgjNjZy4P7hNnIELDbBU6gFIYB72aIJ0ofsGkDyyDfVqRXpYwgnJ5SKp38yo5QW3vY7q2XdpX6p88I6qo2EzVmt5pIaNhcPEOMr9QZhRe1/dZRzrW7UqOksGQ=
Received: from MW4PR03CA0020.namprd03.prod.outlook.com (2603:10b6:303:8f::25)
 by DM4PR12MB7574.namprd12.prod.outlook.com (2603:10b6:8:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 07:50:53 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::5) by MW4PR03CA0020.outlook.office365.com
 (2603:10b6:303:8f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 07:50:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 07:50:52 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 01:50:51 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amdgpu: refine smu send msg debug log format
Date: Wed, 5 Feb 2025 15:50:35 +0800
Message-ID: <20250205075035.2170125-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|DM4PR12MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c07e667-72a1-4831-5d1a-08dd45b9d0d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jFHkt5T1G4KazwGg4aeTGXFqtgBfGyBkiJ6t98ELQI+RUCklPyfVOETobMh2?=
 =?us-ascii?Q?WWEm7x1nKMtjWfESHADGfGR4WnJri+UyskbIEAlzKfP0CA+B+h+lJolJFhZC?=
 =?us-ascii?Q?2FRa1cwA+i8b2n9k6hDnxHh8imuzdtqrWnIGtNptCC5DNIwmHFOVzIYobDde?=
 =?us-ascii?Q?6XtuJxmFQSOTlh3+HCEf9mpiaOLpVrP0VVq9I4zvxhEsFVTDia/dKN/mtdgU?=
 =?us-ascii?Q?s7yoze0mVZIoVFMdf4aVO55qEF5IPxgSZoxjJ0CxwDccaFeWBabKlhHnhqDY?=
 =?us-ascii?Q?84ol1bF3Wk+NGkgEZB1fbwGkF4pzclJAFm61v2BF9s3veKDJlutH8EqRUPCO?=
 =?us-ascii?Q?90/rdcaJb9r673KEyCLyfMFvkK+H2Gf5W7Zs8uebtjiqyYjbWxb2KAXTq7gq?=
 =?us-ascii?Q?rrOIyXZfvHC8bf1dle/GFvAPviO2QpCxx4rH8g6lT2n9IRqwkgjg24V9XirM?=
 =?us-ascii?Q?d98HyQRRdaYcCx50bFnwSHDPSZou/UpKJHXUay+1cWfx2Gd1ZPs50STPVU82?=
 =?us-ascii?Q?z4hNYrgwpqQh+x32QkPVUu0dtr2bY/qji4EkENhZOJ59hOTRixtwz1apcuuQ?=
 =?us-ascii?Q?X1sTu4TgCDZUVgHJovB9F8AjI7HyvfseFzLUP9kSV0uyUTcLzrwCL/MgCLPW?=
 =?us-ascii?Q?8WNwzfcPA5C4bc+jrCWWPyrZir4O/VCRmhwJKIZpwq3oR4fS1ZHMpioYZu0/?=
 =?us-ascii?Q?0lwww9m0VFPxAsI+dEKGY3KuVgBbnEyyhjLanBm/NqQGX3Drnv+Acfw5+1h4?=
 =?us-ascii?Q?8Sl06cWFFFk2HOcj6I6TYRrA8d+lBSERa8i8rteI/AQnWzgXPOnywnM+h7sq?=
 =?us-ascii?Q?T03yJHrAaLQOBAqJDYrIAZOWuGJDn3SP0cDnY35zjdYvgEEzF+mh7SGwxYmG?=
 =?us-ascii?Q?IPgVTolZqNJdXqjwIERjkBS2zGfFytokOjteDDGODDDpDVg3hC0JpSH7lqa6?=
 =?us-ascii?Q?0AkWJJD+2epZq/KFxlTH2qgHYIoc52vowwxWIIjfV/AmyuK2BsuVid1YQMzb?=
 =?us-ascii?Q?kmzhLVLyy0ArffdgHM7vyWygoki4YLe2FmcXReEEwALm26t8I12Rx7l4qez9?=
 =?us-ascii?Q?J36YVxuNNz6GeCWVTPGZiDnXIwubUDimVvJp63U0Zzvo42G750NmNQLAQWrn?=
 =?us-ascii?Q?4UkMbx8O4arkKdUK5WMZBNtYuY3uzyiX/kU5AeZ00xbfJVbbd3Jw7OviMTso?=
 =?us-ascii?Q?psDr9coEQzbzz5i8Z0RUXnk42rdVZf2OVaPrryEXhM12zNrLRMpL+J807nvX?=
 =?us-ascii?Q?Sk1QsOC7XclRwVROmmFZwqlCEBBaL+WQzqNgS0+griwG0GqAQBpFdIAoOzL/?=
 =?us-ascii?Q?ypmzqNdM6uA3QRw7fh5gNhYbqmO2ep3p8hmxvOlRFrIMdBEFlEYwi70FnB8Q?=
 =?us-ascii?Q?CuRub9XHhva7btsriztbsDKWeai8UVstoaACbu1GpO2ghYw6MiB1piZBi9QB?=
 =?us-ascii?Q?L/xxOotkJhT9YXG0ltHJYWX8x9yEkyaBH96vD2UxHUrXui/NMfjIORnOmIDn?=
 =?us-ascii?Q?wwGtsWNCv6sW+GQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 07:50:52.9564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c07e667-72a1-4831-5d1a-08dd45b9d0d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7574
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

remove unnecessary line breaks.

[   51.280860] amdgpu 0000:24:00.0: amdgpu: smu send message: GetEnabledSmuFeaturesHigh(13) param: 0x00000000, resp: 0x00000001,                        readval: 0x00003763

Fixes: a364c014a2c1 ("drm/amd/pm: enable amdgpu smu send message log")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 9f55207ea9bc..d834d134ad2b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -459,8 +459,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 	}
 	if (read_arg) {
 		smu_cmn_read_arg(smu, read_arg);
-		dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x, resp: 0x%08x,\
-			readval: 0x%08x\n",
+		dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x, resp: 0x%08x, readval: 0x%08x\n",
 			smu_get_message_name(smu, msg), index, param, reg, *read_arg);
 	} else {
 		dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x, resp: 0x%08x\n",
-- 
2.34.1

