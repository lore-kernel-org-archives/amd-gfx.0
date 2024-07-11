Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D34C3DA45
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jul 2024 23:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D83E910E04D;
	Thu, 11 Jul 2024 23:20:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IoMLzd64";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07D9F10E04D
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jul 2024 23:20:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VH7osOqzTwhHqWWjzjDXoMPuYXa1WjO5DBFqY6RvHOP3cVU1g4ilMiSRiBVf2xp3BIbAKVjdOpQBQyxMhUIZSaP0P7FtqsZrsSfjdkmy/RtWKliUe3AeGXS/+lOsBGTCR6uYxwx63fCOy98rtP6QKIUcg+UDPTEkbvANCx33hMcxExnGOFHZvZrXoxf/5Y6mJi3qFn8CV0MfmlPLohlfM8ifl0jafrwxahwXmz/A6ZINayyz94paSgvkIEMAs8FDOaBFbJF8VIBlfjkM5f7U03zUx5za5hkZIr27JGT7VjtJN6CsJKQsNIK1Lunz0ItYp3fXNtgb6jZ6GjLveC4xew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRBRDuk09D/LTiS1+3QdNX0WS4v6//TuqMzZF9yv1IM=;
 b=yqB23uZ4XWSXYjWD2VXjxCFjScWimvz8P3YzGNoVEm1ONvyrc++m/Ip4nUEFN6c6SOA1RN1YTvH5waEUDTu1XXjlWnzpqq1sPUoINYlEvjURhGiDG/IxLeRDIanEvZPBAPPZOtWWpCktiYx5atl4M5TUgcOgpDDx3w6dY0VRPNEHEtLrXsd7gfGpFV+ycWvDs8YmKIejH1fGGMgOKEcrWLNKfVLn31SoLC3p05zq36o8HNttLHs/NKj7uTSPDFVFZ9MDpzh2bro97nw0WZa/80bjd3Q8SRNQh/I/IEFQ6CrTQXjkPEE7qruOLd14M9DAiaaY37EYpOulmWybtNBmVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRBRDuk09D/LTiS1+3QdNX0WS4v6//TuqMzZF9yv1IM=;
 b=IoMLzd64VhU231waWX9Wp+AKOD1+newKT1rsJze2xezHbman97ZyHqYMLtJ02BRaF/WGvOWwFfZEVcO919x3A6gFcZyxxGkj7aw2M3fbWt+OwHoT64rTUeXVy2e/mJvVyiGK33xQreUPfvd6+QKPzl1nBF/UYtep87WAUjdLQLw=
Received: from BN7PR02CA0028.namprd02.prod.outlook.com (2603:10b6:408:20::41)
 by LV3PR12MB9143.namprd12.prod.outlook.com (2603:10b6:408:19e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 23:20:15 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:408:20:cafe::29) by BN7PR02CA0028.outlook.office365.com
 (2603:10b6:408:20::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22 via Frontend
 Transport; Thu, 11 Jul 2024 23:20:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 23:20:14 +0000
Received: from vengutta-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 18:20:13 -0500
From: Venkata Narendra Kumar Gutta <vengutta@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <mlimonci@amd.com>, <benjamin.chan@amd.com>, <king.li@amd.com>,
 <bin.du@amd.com>, <vengutta@amd.com>, <pratap.nirujogi@amd.com>
Subject: [PATCH v0 0/1] Add MFD support for ISP I2C bus
Date: Thu, 11 Jul 2024 16:19:58 -0700
Message-ID: <20240711231959.272993-1-vengutta@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|LV3PR12MB9143:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d296633-e6a1-41b7-be69-08dca20004ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l9mynwMgiPqQSRz4s6tRb08gkke1BXQw0uqrvuW5vBbEr3FUAos+L2wNrpcn?=
 =?us-ascii?Q?hhFff52hp13kUK/8cNP7WRGbO6mo7XA+5C/Fb1NYNoisEDhHFKmMF2rHKEEI?=
 =?us-ascii?Q?/V/ybY8/AwUEWa643hdu9ico7mcI28/Vim0DYdJ/YSY6SEYH17kNsYuwTaZo?=
 =?us-ascii?Q?emnaWsNUFFuKfVDjgz6ibU206J2vknGGdJ/+rVw+tM2hZ7c9gwvR7NzfRj5p?=
 =?us-ascii?Q?SaIutxg9riGCVpsIs6w9YOhExWiji5Iv2FCIDF+ub4LTVFJgaaNyhncYoc3I?=
 =?us-ascii?Q?35PNG9pW+jIAkXTjd79sOQReLMcfUP9UkFuG6huCBwQmxaY6rwOFXb5VEwbv?=
 =?us-ascii?Q?mT3V8nbcMw7cTYxITZdYdpa1EzyQPM6NSVkIe6/seUisQtnrlM4HoiP8pLvI?=
 =?us-ascii?Q?VZu8AtlLZ/7ReiukeFHn1b1C/hCfJ8/8liQMnNOAcvrB1MNuA26elkoNTtVc?=
 =?us-ascii?Q?JBBp8djNFJ6WTxykcXJ+PumKni2A5SOkwUiy2OEPaI0dskfz3VQv7WnGZaRa?=
 =?us-ascii?Q?5HQgGqHAorAoQKqhyBGWtgzzby2ZWmoUpn184mCKWb5QPI2N1PUiL1pQQpoA?=
 =?us-ascii?Q?D9NlNw9CPUWBBzrVfhK4w8dGyEjTmYN08IXI+n1j4uhukChmVJ+0KlnngVC2?=
 =?us-ascii?Q?0NWQ7DTp/QvkUvJijLMjFZ7fNU7L/rKUk77uDuTW0iQ1leuJG5eq3UPUiu7L?=
 =?us-ascii?Q?FvfUNA08HAbZD364IUeLPnSUa4Wpvo7CCnpWiKidS0PR3ORNAo8ccvkTcntg?=
 =?us-ascii?Q?mQWLrEQDmfZHTFb5Fca6laHkwNRvt1LGRi47Ezzx1XTXHjJjUmjFEzukUXNl?=
 =?us-ascii?Q?nlry0hDWyO1Oy4XA7JO0r6xUZy6sQtm4HA0tE5CDR0EqK7EDSJ3/xskE5mIN?=
 =?us-ascii?Q?vCh4qCq0vjy94RC3zyD89S0ogQW01P/sWt3RjbUzrvWOCwS6jmqQgzIgjtxY?=
 =?us-ascii?Q?iLbyuNnxqMbBP7ubFttdgCeDPBMV1JbW0HxRrTIvIHBM17iN3FVxnpWwbgx+?=
 =?us-ascii?Q?A0qic+vBAOtQjfThkHo1UR9FsbFW5KxU989a0wBzqZKuxM0iSQtmV+0+p2gi?=
 =?us-ascii?Q?D0jGG+M/CcOUVSaAB593b9wcnT43nt3Xk9mjPp+XgO46W+P7TvtD8xeUYlr5?=
 =?us-ascii?Q?9NDZRK9TsD1aDHIGyAoOrgw6Q1C6AxKThsx0g16SvBSvVPARDhWu/FZf3YTg?=
 =?us-ascii?Q?2eooRyfol6W2jHw2I4jNLl1r1Hw2HvT2varweArWr3mwnMwkuo0CNZuHE+ZD?=
 =?us-ascii?Q?2PBLdwcesxsFNKgnQrPd/5nc0W8mjSCpJrlTaM/emfDKhRaN07p66bsqhqw3?=
 =?us-ascii?Q?VWXAv7BgmW1eECYm3joOgr9G203z0d1/ic+fT/cVymLyJnqVEblmMm7XLvvL?=
 =?us-ascii?Q?LL1EDYIRTlveUAceuXYVtcKmF8dvpXquRhsUGyLPj6jX5Cp+VturLdbjN9RY?=
 =?us-ascii?Q?a/GaFR7DGi0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 23:20:14.5179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d296633-e6a1-41b7-be69-08dca20004ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9143
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

The camera sensors in the system are connected via the ISP I2C bus.
The ISP I2C bus is another IP block that shares the hardware resources with the AMDGPU.
Just like the ISP device the ISP I2C bus also can't be enumerated via ACPI mechanism,
since it's memory map is a subset of the AMDGPU memory map.
So use the MFD approach to get the ISP I2C bus registered.

In this patch, I've added the support for ISP I2C bus cell and it's corresponding
resources and also some of the resources needed by the camera sensor that come under
ISP device memory map.


Venkata Narendra Kumar Gutta (1):
  Add MFD support for ISP I2C bus

 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h |  1 +
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c | 57 +++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h | 12 ++++++
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 57 +++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h | 11 +++++
 5 files changed, 114 insertions(+), 24 deletions(-)

-- 
2.34.1

