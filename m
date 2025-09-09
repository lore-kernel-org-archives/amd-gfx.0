Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAB1CAC585
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 05:50:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1856B10E10B;
	Tue,  9 Sep 2025 05:50:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C7gz4FG3";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E750010E10B
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 05:50:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqBC1Wcms8nz8fMAFL+xHcwDfYUjY655zrY8dbfXjLMHgaxYZGbu/vdlaGzjfy1SGIb6QKd+GnzmxMO5l4VfOgh4FreBcVlPhxBBiPWnA/q9d1+v49WmR9fj3w4J3uo6y0/rEptgXZtGeMmYmtKgyKT/GxFhbq2u8Az7kMjeSiMvnoRtAi5j1NSzPegdq+8QKFfuHYNt4ZOTV2mWlzf617+KjQJNt9ZrMUkVx5zR810Hr/kt0fNCN9G7+X0hlXVUsZ4/DgMQay7g5ir374TH/CilyluOzVd4HiynlVCSrlax6pCphT8VVeUpnPJtS21FbTE8s1T7B+JiPypMdCBfzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLr5OOn6oUVemFUuftGUgK+W4aADpWUxfaOcHpFjJKg=;
 b=lKx74wY1PS5kKvZr3E+9P3qi1i1+Iwk3mWUV680ll3hUOnZ62TMgZ/tSZV0CJyk7tqINDPNQwi55QDFG9l91E7TZUBQHP8oglNJwNo18SaWxDTukotyvOoEt24BgVykQpAZTAqypYF9pUiokgEme5OB8QaAMGsHKlFOD+Nok03ETsXSZB3EQ7VI6OR+pBMEev0IscnZqO8tosbl6OvXRX6R73pIWWPHAgnNBxlwGckk6R4wYv1MQoKddTexcO8bEURigXbV0Jo1KhHRePDnud4ajlXcY53fvs1j9U3To0CklxYe6uHjZGFdijYoHhLpOTFF3nc2XWrMIp/UinnNrXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLr5OOn6oUVemFUuftGUgK+W4aADpWUxfaOcHpFjJKg=;
 b=C7gz4FG3Ydu7tvb4LdRJkkSTIzJmhTmJRsCDVDzohJpSZntw4EPJzwEbb/dFPxhEeuk91bUOL8FwQj+worosNEFanZEMGo1MafSU8EZJ+kD0uvSh/AhOpeZlddyrYrxXJiQARvpCiUKRA+hn+DcPmByD1KUxK090n3x8utx16Hg=
Received: from MN2PR08CA0024.namprd08.prod.outlook.com (2603:10b6:208:239::29)
 by SJ0PR12MB8137.namprd12.prod.outlook.com (2603:10b6:a03:4e5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 05:49:59 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:208:239:cafe::37) by MN2PR08CA0024.outlook.office365.com
 (2603:10b6:208:239::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 05:49:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Tue, 9 Sep 2025 05:49:58 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 22:49:53 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH v3 0/7] Add field encoding to gpu metrics fields
Date: Tue, 9 Sep 2025 11:17:30 +0530
Message-ID: <20250909054933.2911159-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|SJ0PR12MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: 28826cf4-7c68-4586-cf4c-08ddef64b5b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yB75/urZkvw2P7Na3QVtCr5nhK1mNV0grZgHDjZlWfxUuWxcvJoDTVefuW7D?=
 =?us-ascii?Q?dhkUmQAOKyzZd3roTUxaLucGx6ppbbrW4LI5UyVc6h4V3f9/TUZPIoTeKVc3?=
 =?us-ascii?Q?JU2vxkUxijVEmSyqud+c2GS1J3MwuHNRCaXXFJmF7MST6w3MOOEAPLGmAL+s?=
 =?us-ascii?Q?hfb4tfdevZt+u1nK7NyPMRodHehN7LdDJpwLybV2kN0UeXdeNJd+nlBM3Sc+?=
 =?us-ascii?Q?Dn3p4BpRN+lGYkds3fbxAnd/J/xxSPn6Lc7odZoItZipc0cWBcZvkAwfe21B?=
 =?us-ascii?Q?mNyf8eYc1IVbVSPv+OzlMWbW2nDPsocSacY1GyxPr8LrsEqPen3yVQxp/e/W?=
 =?us-ascii?Q?yBo/1tkmmrdX96PNWDKoc1Ew5s3UTb0jkuT9RhdqQmhTyG4egJKgZi9+TL/D?=
 =?us-ascii?Q?Iv+gDjK/asP6P+sf2vQAzUZ8p1cKzyBNH4/Z/67s4zVLqKx26ZJ6ZjR7LWrl?=
 =?us-ascii?Q?jsb7J9GhqrdyOG/nHbwRdi9ThZTPhy7j/J21QcPL+knbhV0g0uTi+PQlzXsB?=
 =?us-ascii?Q?iW8PsWTzsyqp9+wEyF0PwoHiRuqfBeMh34ajTkMqkmr2Dl/tGzVxnP8KHcgN?=
 =?us-ascii?Q?9NwocmyaeVbO473x9XnsTRdqp6HXaylJZBnNdGE3PPBU0PGdwxd940gNXBkk?=
 =?us-ascii?Q?kSFDSqsjYVLIDZypbz9h7FqfB8qK23DWPd8YpQ2vqhnIBbzxUp4AFhZ0p+a4?=
 =?us-ascii?Q?Afz9GZFgSybaAH6GHvPIfMX72PsK88x+SWN2T0tYQDwZk3wsxfFvayDZWHiq?=
 =?us-ascii?Q?UO26X2O8259yY9lVa/4Xxkme2ioQGuJ+yXUkPNtWAb6PVM2RiTLHWXbyec9Z?=
 =?us-ascii?Q?2pbVfHxrat//2rMvV3X3z5XVcANGGgPDD3GJelKBrNGhNDYgnQMnnYpI3Kwy?=
 =?us-ascii?Q?H0g2Aw6P9GJ5sLd76eYO0/XcZs6x/PvwWamShWU5YCytb/3yuAI7X1sGTTpG?=
 =?us-ascii?Q?T/vyKNb0HqaqHs76J5m5iFaaNsMhwCGhrbcUla1DeEr6fm6i8hnqX+4lrVcq?=
 =?us-ascii?Q?u7E7+kzo4acx0/ruv0prsKRu819gCoCXP7zbI48sXzbND2YUVdSAbW42jJ7F?=
 =?us-ascii?Q?5Nd2upOvixp8snJTTzdpL1DZCtAZpWqwapIUiU/8pUkEC4LuiRgk7Wvag6tG?=
 =?us-ascii?Q?yoqDBquTQYw1gXfU+W8lOXxIraOKShAkfDZ+0mirua/FaCdKqeCPvMEXtGRd?=
 =?us-ascii?Q?c5pzfIEd6u7K9tmjxaYVCIFESTWFz2ubLBpJ8rfH5mMDlRMIuQlIB933pMvd?=
 =?us-ascii?Q?YMitLOxOTH4+IYNIwqSg3+n2ZoRmIAsMlKU0K7PXLlbXppUy67FxrL2I93et?=
 =?us-ascii?Q?P0BrUUkisUdqNGg1u05Rl7rp7Ianzp5djNwSFjnzY/Gu4demTM58WJgoBOF2?=
 =?us-ascii?Q?sZUV44psu/xeMox/gp72em15vyAp0AFH+5wBGqjrnMJkFUibcBPoYU4dUz71?=
 =?us-ascii?Q?PBFd7CRwe946q1A3koNTzFsaq7m5xTGcvcBWXbAkTN1mkPuWd9ol5FPPcc7K?=
 =?us-ascii?Q?uPdXt9ogde1ZDZEVRZ+XsK34okCSnWDlqdBs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 05:49:58.0554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28826cf4-7c68-4586-cf4c-08ddef64b5b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8137
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

Currently, gpu_metrics is exported a binary blob with the defintion provided by means of a structure
and version. Though providing the version works well for backward compatiblity, it doesn't work the
other way for tools like amd-smi. Installing a driver with a newer definition of gpu_metrics
sometimes could break compatibility with the older version of amd-smi. Even if newer fields are
added towards the end, a change in datatype of existing field or an increase of size in an array
element will break the compatiblity.

To address this, add field encoding before each metrics field. Each field is designated an attribute
id, and along with that the type (only integral ones are used currently), unit and number of
instances are encoded. Thus an older amd-smi tool may skip any unknown attribute field, and move to
the next attribute. This encoding scheme doesn't take care of elements that are not valid always -
say member_field[3] is not valid under certain conditions in an array member member_field[10]. Hence
this still keeps the design of having all invalid elements initialized to 0xFFs.

Lijo Lazar (7):
  drm/amdgpu/pm: Add definition for gpu_metrics v1.9
  drm/amd/pm: Add helper functions for gpu metrics
  drm/amd/pm: Use gpu metrics 1.9 for SMUv13.0.6
  drm/amd/pm: Use gpu metrics 1.9 for SMUv13.0.12
  drm/amd/pm: Add schema v1.1 for parition metrics
  drm/amd/pm: Update SMUv13.0.6 partition metrics
  drm/amd/pm: Update SMUv13.0.12 partition metrics

 .../gpu/drm/amd/include/kgd_pp_interface.h    | 123 ++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c |  94 +++++------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 140 ++++++++--------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  | 156 +++++++++++++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  62 +++++++
 5 files changed, 450 insertions(+), 125 deletions(-)

-- 
2.49.0

