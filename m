Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E260C3DA59
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jul 2024 02:32:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32DE410E54C;
	Tue, 16 Jul 2024 02:32:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uZ/CATB3";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52A5D10E544
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 02:31:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkYfL50chvVhoTJkVQxGnqQZhpa9jtRLQGfkJhxivJN3PJaqk/3+uXSVoe8HNubFQ7Iosg9DASJRAqulbAYjMRjUm2oOOgDM7nv32RKIt2iAkD2WZKoh8GuDLKPLg82sWCEHVUnuYz4vo0ENWhwVhJ50C6ng3HBDGC5H/UaNhm6zqTJpshCUsFpD9ypvGzAIkXhPB54eEllx1VHEN9YV2+TGr7141kq69nR5XZGkJFzsR/GH+Ojb5p6KtaiAX5mQUCaH681WaCpVii+5jMyc4W8Xu6wDzVkuITQh2LJAWoFsWrFklG68cGR5e7Sb8SM6adIV0QQn2dt+r7l+ilyyJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWtYNieAMYZ2B1y8AdhRvjgD/Aq3KJt7+PngDcVJT3w=;
 b=IUBvne9Imo+Y32IBuzGgIjlFbdepH5YB7a6l8OtmuDDvGSwvQsyD2d8FOu3wuinLfWfp0arRCw/gon2egZPZTXhj6mQ6VvUcB+e8ekPpIebJU1rFK4PXSufYb2Ctg/viTx3szUpeDJHx0fHayt1xUYrzIPnAy/UVQ6+cKzbIsXefg2HRa45eCQgbhj17cBgQfzVAGbSCbpEcR8F6Du0aZmBEIrTGgFEOL6Kx69R8pKlRsn7U5QBUVOURbvsfS78X51+0yeRLDlWabTLu5uhkakNXyaPaqYXyiPkYRKEMEcKYBbzi7kvS5NUmpp4Q2HJkmcaFAztt+moz8pPWTIoZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWtYNieAMYZ2B1y8AdhRvjgD/Aq3KJt7+PngDcVJT3w=;
 b=uZ/CATB3kGlynUKxpVIBDa1mfO+O4rYMEGpBkLpNGcDqs8+GRmp4MhgZlOoO84Z4cyfkMvqOst10TCCyvJegStPev3/v39q6i43XXnNhCKfWmubc+/Iw0om3LWK9QbpUKeGHN3N//EO9U7epwAln+t6ZN2rrgtlDYpiks3nuPWY=
Received: from BN0PR04CA0012.namprd04.prod.outlook.com (2603:10b6:408:ee::17)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 02:31:54 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:ee:cafe::bb) by BN0PR04CA0012.outlook.office365.com
 (2603:10b6:408:ee::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Tue, 16 Jul 2024 02:31:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Tue, 16 Jul 2024 02:31:54 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 21:31:53 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <Roman.Li@amd.com>, 
 <Alex.Hung@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 5/6] Documentation/gpu: Remove undocumented files from
 dcn-blockshubbub.h
Date: Mon, 15 Jul 2024 20:27:27 -0600
Message-ID: <20240716023022.100811-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716023022.100811-3-Rodrigo.Siqueira@amd.com>
References: <20240716023022.100811-3-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|MN2PR12MB4487:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c31b7b-b48a-4d9f-ad50-08dca53f7516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?guA1K5F8NYx3vT2cVaEtJ9j/1lZAgmJv25Lw6f3L9hK/1m9/A16NSg73pqYk?=
 =?us-ascii?Q?HtxLNJ6NUPg7JHHFJtNB62r7wVA0oHy1SIj8iBj451pS6KjNJxKuv4hMU30i?=
 =?us-ascii?Q?hO8pT5+BVhN9yKIbjlLO8W5YK0B92LNKJUE50QHaNGOI0RY9Z+24FSW52mwh?=
 =?us-ascii?Q?xnY2VT7Tcxn9lS1XjEAyEw7CFKcqdai1nrx2pmV4Z1rJ6iin8q1DGMvUnDj2?=
 =?us-ascii?Q?8yL1TGoVKFUqU42o7K+fcn9inYDsVAyh+whXDyyeXScdhwn1RkacJGKxLkWs?=
 =?us-ascii?Q?OjD/BpiIYFcREJFYOQDTPpsp5V7cnAFJT87lNqKPldSpNdbSTIWhxNjBeSgg?=
 =?us-ascii?Q?on121XzHa+7sT0nFQSkk76XkT9EnSenVaDaKyYwmWk/IZrgcImRpBucNKrRN?=
 =?us-ascii?Q?huRe7RmZuMXetNCIVmAGVGEyaCAnTrm/letlOlZlCg0KqLr7D4z3VbEB4Mi5?=
 =?us-ascii?Q?qUGFH0BpnPRZyTNlIe9uOaEvvMzGYlMbqnF5jJlMQONPblNqFoYt+ujMlaFZ?=
 =?us-ascii?Q?svY1llosJpSyfR2l/tNNR1gX8k43fWNdv3874HNSD+jVojwJN3akwl+8oIiC?=
 =?us-ascii?Q?4W0B4WSy/FLrFtnUAe4l2uC6mCFXQwZKHF8n8HdSA2BAa5yW6silLaNBLLEb?=
 =?us-ascii?Q?Ob1YfnZxYRAbRMXR/XFI0R3rUW0ifyYotTcE5MHTQIQ5/L3LQl9PcpSKzJKE?=
 =?us-ascii?Q?duk2/m9CIjDCWD529iL2BbhQrkoN/TyONwLXjugCAiC3ShnsP5YTO4xBi+lS?=
 =?us-ascii?Q?LEddBQ5suZe3zuhQzH7aHXSiDX+I8+L/8cfcrL8oWDTk4QPW73PbCFL8wiyl?=
 =?us-ascii?Q?4g3cwl7IfbMOfTFLwHf9WVSLwsdoS4m4kvAOvFz88oMdFrgrnSzPxOkg5hST?=
 =?us-ascii?Q?aITU+Yaux8H6akuGMpI6xVyAMMu1qQ/b69Wu4YiM7xrV+xGBY1KVuRrvzfjE?=
 =?us-ascii?Q?W03KU3VVe3+pkCfXMvuLJnr7FF5aIgG2ExicUswv4mDc9UJVhqNhmXwQ7FXb?=
 =?us-ascii?Q?rbae9elWGZlJrjmUfYil26m8uxCdC8VgjN76Uz9vZOjTDTSrRS/SVbUzA2Ph?=
 =?us-ascii?Q?A0taxgGprhNPu7jOaeD3vN8/EM/OppHfLxtvVfOf5H3fHRws/mGyoD2mFh8k?=
 =?us-ascii?Q?Mityf5nZC4d5tH5wpGz5DQuxXNsKCc27gFC7QBGNJ0lbDf7X6+wS6J3jw/UA?=
 =?us-ascii?Q?YF7AXk1VRZYDUCzoiF7kPzxPxnstUd1GGbQ72LUganIU3RIEWXhgiD8cxNtp?=
 =?us-ascii?Q?yctuZXbGA7IAf41O0kRm5fiZ7nvcxV7RVOxdJuwcMHKpeTczM5uFF+QQdiSw?=
 =?us-ascii?Q?O0eHKFDIgTMUpx35smKIB8g0BvWmsnhGy6w21DKVZ75VhJpK+3SvBF6dKABJ?=
 =?us-ascii?Q?35Ywt8y/cHIjmU2J3EeVsEeiaxZ4Sg2N7y8HMCJEVdm+1fpDJep3OSs/teYT?=
 =?us-ascii?Q?N9ERUB72uUZpqmen2cehPKT/Ly4k4giI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 02:31:54.5085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c31b7b-b48a-4d9f-ad50-08dca53f7516
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
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

The dchubbub.h and hubp.h do not have any meaningful documentation; for
this reason, this commit removes those files from the dcn-blocks
documentation.

Cc: Alex Deucher <alexander.deucher@amd.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 Documentation/gpu/amdgpu/display/dcn-blocks.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/gpu/amdgpu/display/dcn-blocks.rst b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
index 00bc0607e98c..f80df596ef5c 100644
--- a/Documentation/gpu/amdgpu/display/dcn-blocks.rst
+++ b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
@@ -11,18 +11,12 @@ DCHUBBUB
 .. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
    :doc: overview
 
-.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
-   :internal:
-
 HUBP
 ----
 
 .. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
    :doc: overview
 
-.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
-   :internal:
-
 DPP
 ---
 
-- 
2.43.0

