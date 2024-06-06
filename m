Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA19BC27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41E3610EB11;
	Thu,  6 Jun 2024 21:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2ro/saCd";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D82110EB10
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:59:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHu+uW4iVopECrWfKcemgcRtRwZHaKG4VMzjQ61DXkVTD0iX89UsICBQsgt2pXUVvW7BJ3DjrdFqU7YMDEp9w6xzBNMOBzYbBt8HpEHY3dl/YHXd7HQ9LUh9AVkyQBdBsWF5I/2kPuwXXdD7CIY9hieAyM336hkrLWlaN9QnDqQNpzelRXCPlT02TatIFDn+7Gq3hTanRCsWQa1kVY+dQFSy/Ul6HH38Z2HBNXY8My035faofmI3Iwv3ITGrsIfN49vMbuyGXlvvBCRgaO4uW8fAzIiCBK1kR4J1Sf2R/M2Vb9x9qOqAp4xljI4mBcMWMagySu6kVwXD3kix1RL/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wndA79wPuD7E0hu2Gq+8LmwGkajg7F/EUeYqSjhxKb0=;
 b=FbJDW2DszBjFN+K4GTqgPlbY4v/Is2fLWWUc/Hv3d2sqXe1UkEIenrkW7tEfEPR6vDCbjKumMmCiPK7wveJFlInyfj7F6Vu5DQwtB3L528d369UkzDHWM+iig4KWJn50kW1wt73/XkSyXGfDu9WriJIPz0SFAd/nNlN0VRdgkx3l7e7poYgQr93AjreLKEg70Kuo+PUglZsGYmb8/Srp7w0N0slHwkoCNoQFtXedLUTFg61L2uuoVzbaN5XCR+KHozguvhyjUA+ZlgYkPSmB79aSmL1BEjFQzW9WFyOQuIjAn7bCspv5OUb0OEAZr97J2b4mY45JFUEeIZ1V83pgHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wndA79wPuD7E0hu2Gq+8LmwGkajg7F/EUeYqSjhxKb0=;
 b=2ro/saCd2HUXSkn3UlEKkPh9PF7BbsCjHuewsEFm+ZxoCgYppbxqqu6GemtjC/GrZFMjRUhxu4Hglg8f0J9bnkHOZLwG7EnAbQdPfolXcMYI7PPxGU3hI1Ov08AOJA5xiPas5WpWvXdqgMQL3I5af4f4At83euuz5pNJZQvQofo=
Received: from MN2PR15CA0054.namprd15.prod.outlook.com (2603:10b6:208:237::23)
 by DS0PR12MB7948.namprd12.prod.outlook.com (2603:10b6:8:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 6 Jun
 2024 21:59:07 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::6e) by MN2PR15CA0054.outlook.office365.com
 (2603:10b6:208:237::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.19 via Frontend
 Transport; Thu, 6 Jun 2024 21:59:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:59:07 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:59:05 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Dillon Varone <dillon.varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 59/67] drm/amd/display: Block SubVP if hardware rotation is
 used in DML2.1
Date: Thu, 6 Jun 2024 17:56:24 -0400
Message-ID: <20240606215632.4061204-60-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|DS0PR12MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: 06caaa29-2d92-4440-1f70-08dc8673e35d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/1Oxfdzo2NsSnjDEDQKPECKcA4/LWjLq+aT9pZeZlFZhovXHY1DRAzefP1e6?=
 =?us-ascii?Q?JS8BHfHJR1DNNp+VFDgV0gvmviVQ3Gu2S+8nHWmG/EdnisDpNwb84bV/ZNz0?=
 =?us-ascii?Q?WB5a8yyx7VFi2I0Rai9gD1kVN54cAGgz3ymw3RFokKvm8A9YL8pmY1WzKy1m?=
 =?us-ascii?Q?E0D9j9aBKzb8LRKCTRVvAPWVi67tXyCjS+8R+MCVq1K0OuOHYM+Qt/MfRFLH?=
 =?us-ascii?Q?cDIoZqy9sc+YzdIQtevTh+1ERy4YsGLD/nW4Ekb1DoHHn2we7u3HeOD15TNG?=
 =?us-ascii?Q?LE2tiUNrhVfIu3dDwzwqahtqKW2bGUgvnOA69WuE1fydcRqeSc5+92u+f5/E?=
 =?us-ascii?Q?eqLN139UInJzSD/e4s1O858keVcAHMrsEuMG3yeHC6WB5Zs0m/sAv6hkx5fS?=
 =?us-ascii?Q?b0n/YrfTkGktU6ARGZ7t3z36foR5kxgFSiw7JJhEA2fmjYgP3TznCwb35qCz?=
 =?us-ascii?Q?DXvrorCqoy8DkTlhT3kjkwJ+GDaoBWFUWaPN6+k0H2Ht3m0woa1oSsPXHA2a?=
 =?us-ascii?Q?K68IbKnpF2Ix5Wy6VYBO4fuDmfdcVGb8nE6JPqa5G3ybuXlDMWkbvv8N18u1?=
 =?us-ascii?Q?MsmfOE7wNk19HthcaabpcHJRBqSRk3V3wt+oEpdC8K5uKNZEBHHAF2FWF3oi?=
 =?us-ascii?Q?N5/K8tKt7sxSVGxkBbmOQTvyYXseABo9eEEK3awHCpd1zYz/mKeEI0bLDBaD?=
 =?us-ascii?Q?f/NwM83XURNPG9j6roTQhkgxEuybf+/zZyFqdGPnB+L5TpqjeV7oXqkkfNz8?=
 =?us-ascii?Q?6aYkmoIa52PoEZQv31LHV/AevaJ6+AVm/p1VZn+IymsFXmWbJfwbymuir25y?=
 =?us-ascii?Q?W+aJ25yxJ+F2JO0dhwTNBqlaBIqi4o233C7Kb+FhFG0nxp3NNJYkXE49kXgJ?=
 =?us-ascii?Q?FVnezkR/2zORfkXKPy40FbXxgh+MYFSGTh0hpUq7Yhh5/evfbUV/nh5rN9kq?=
 =?us-ascii?Q?Jxl2/RrEbzmEblxsR+EI12nwNxCWZ4blPrGOBP49aGURmacmcHYTmH6l5ORo?=
 =?us-ascii?Q?S9CBcKtZEZBrQRybxiYFDB/Z+dcswbt4w3s/eOd6GrpHNDycpTN/gFYVDUX5?=
 =?us-ascii?Q?PRDf2ApHcyGanq5hHOJU1Kc/iGQ8WLZsHEFV4/Npc7gjUDf8ZFjQ+1XOQr/3?=
 =?us-ascii?Q?BZWfJBZB5FSKPuPczInrAKPJar2rLmpYvdGT25d+1iQ8W71AnCPyusWRQC87?=
 =?us-ascii?Q?p67R0MTrL6jYD7eBISbOQhSPJh0M9j8WKcLJ/fB9ljpL09LMdJx34zWqjii7?=
 =?us-ascii?Q?zLx6NAWx8WNtcAVl+CgtxWhz65kXcZxunuUN702b7bGLSqmyOmuFRqmFw+/b?=
 =?us-ascii?Q?rzjv6KjVCbqwQ/2xBmEawRZ+fv+tC4bPYqafmin39KfDauwp8KwsNqZoN3G8?=
 =?us-ascii?Q?/UkM79NMDpj0SiG2PeuvXUvX6ZuyrpNL0f71PNq1GoQBb44i4g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:59:07.3034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06caaa29-2d92-4440-1f70-08dc8673e35d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7948
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
SubVP is not supported when hardware rotation is in use.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 .../display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c   | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index 2e8c836bc632..7272a04b9d1d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -929,7 +929,8 @@ static bool all_timings_support_svp(const struct dml2_pmo_instance *pmo,
 
 			/* check recout height covers entire otg vactive, and single plane */
 			if (num_planes_per_stream[plane_descriptor->stream_index] > 1 ||
-					!plane_descriptor->composition.rect_out_height_spans_vactive) {
+					!plane_descriptor->composition.rect_out_height_spans_vactive ||
+					plane_descriptor->composition.rotation_angle != dml2_rotation_0) {
 				return false;
 			}
 		}
-- 
2.34.1

