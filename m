Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499A0D3B9A9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 07:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E17AF10E67B;
	Wed, 10 Dec 2025 07:14:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fRFOIUs+";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013020.outbound.protection.outlook.com
 [40.107.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B74310E67A
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 07:14:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTjCtD7Ylx75nZjmGE4ACmL0EF5xtZ+IXDGkjPwTGXnuV6JKGVt08Bc+VFwLNcPs8qL4QgkRpu1uyz9rkIagTqamNPQiStUwG+PvfkZTYtYPnE7lb9mjQjhCrPKAg/HtfSGVlQNcM9Pf5X+ZjRreE3QzhafXZgU8X3WoS3L11L4wsml5cve+i38ialvJN4uz2wvi/dW3LBAX3F+oBfFFO2sVigDVJWWJ5y0reaVxWYh2u8yeZ3UaYi4EZGF4ps8jdwXOF011CJ9ksTYy9Dp/y60mN474kKYadcFz+Bm5MXlqhbr5cwUuCOorsMXI1SGPnc7hyOW2i+pv4ioTs/ShzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Bqfls0NHxmnZabetozJaAPJyrK2E4ylGulHUhPQW60=;
 b=Xf0mD+CsIOQ1p29SrznQMkMrRoFM5W0b0lwt4HoiM33MTqoGIFhzha+jPFHXV6UhivxYNov/WNnKNMaJg/w8L5I3h/+yIN/rTmfeSPy9QQ17MpAgeOoSJ3tgkiSmEbcOdOaP8BdM/PjQla+Tz/d6VQXnTB3jY0B0/KLoyf6EcnZwyTWeSgW13MS9QvhlvFqwZiBqZqkmogTybNX8NZpbOWRsLoNTV/uVhLsYqPTe/y+/wCnIIF/nTaNeWba7ufrSIszoGmu96+AGnk/YBEhff7sG2HqDBndBZteQ2JNqSnnc1uhzlvINLmd9XKZSknDo6tL7osKv0p+4RstzqPKCtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Bqfls0NHxmnZabetozJaAPJyrK2E4ylGulHUhPQW60=;
 b=fRFOIUs+sgyK8UddF6r/W9NbHtPtF/sPVXpGru+9tfWwNAuspJajpqyOjgpXzxlBIUKopq3KqlnO4Jr9wsT2MxDsRM4JpSutzzn1fGmsfTKZXujVRB4CTkMjYU9SxMu/qWbcZcazP0uMgrVrZ1jrVTyvoXq1nZyq9m4XE5UH3YE=
Received: from SA1P222CA0131.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::12)
 by SN7PR12MB7297.namprd12.prod.outlook.com (2603:10b6:806:2ad::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 07:14:28 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:3c2:cafe::6d) by SA1P222CA0131.outlook.office365.com
 (2603:10b6:806:3c2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.8 via Frontend Transport; Wed,
 10 Dec 2025 07:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 07:14:28 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 01:14:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Flush TLB on all XCCs on GFX 12.1
Date: Wed, 10 Dec 2025 02:13:55 -0500
Message-ID: <20251210071415.19983-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|SN7PR12MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 808bff9d-efbd-47ee-b7fe-08de37bbc1c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g81nOvByXPSiaw5S8XE+5Tf08Fs3i2kXoC8L5Z1CFKdHWu/3saTx/UfWsYvp?=
 =?us-ascii?Q?KEn+E0BoAm9MxiRrmk2FK2xV3mKCZUqlYXX3M5whDiV4E10n5EwVnmBzyJJ1?=
 =?us-ascii?Q?eGOngR9+GVW/RELPHmsbvSIqyZpiqqs9d1cJnBZa0XLEgIcwjG0A6bpLQxLm?=
 =?us-ascii?Q?QWJWSpMPoM1pXTaTOkXWlADUtwAtLTMhIf2q4MAfblO+Jyh2MHpor4K1BIJf?=
 =?us-ascii?Q?KdiniiNdMLh3rfXTGeqPyOBeQDRoK6S7Z5A1lvXeBGbYeWW1y1bFWDp5Y9HW?=
 =?us-ascii?Q?NkpccJi0oYGjqOT7L+F6ibj0pOXT15qcrByurTf30nKH3ND+TKdWuJGscdq0?=
 =?us-ascii?Q?+d8ofUHxK2J0zrnv0PN6yY4zPC5inWEikPN59ujRf/F9uU+AmSTaBiZ2bbd+?=
 =?us-ascii?Q?Nf0E5DL7x5p65aYQkb+k7KRcf9CfbSLCnlHyfdKKQlwvH4/ili05Sky5rQl+?=
 =?us-ascii?Q?W4CvKzZaW9MMZ0PFaUKfUc1Vmio58b5hYhEuycxzOOXdT8w/BhQUmCrRXktZ?=
 =?us-ascii?Q?Q7N3uOxwQKPR7C1hgUrYL1qN+vh/bVoAW7GhQHZ5+CZpgDm8hZ/FEqM94hLA?=
 =?us-ascii?Q?Cq+Ww/63hCTz0uEZpF9bO74GAuzs7Adwe+Kyg4MsRIpN9N/Yq1XYV0LGH2W0?=
 =?us-ascii?Q?PG+HI7xZhQrFXXCmmZvQZeNjCBR8pKjSca+YYso+Of4P0ndokfaaTRbFkv1J?=
 =?us-ascii?Q?gEgubDNXQ6AwwKFRENSgYqaU030178iSOE/ffWrla7N/8UjPqgjR6qRC7Ry2?=
 =?us-ascii?Q?D9JbEIXQraq35eJfsc0p97QPfuaun4k/OzakMFt0sK+aSBDzLhIgXsO1hu/1?=
 =?us-ascii?Q?6siWeJdWuFpQZvibQptHJIf8yyaMImGxx4BkiRpp5gYfMD3r9pCS8egGqS5X?=
 =?us-ascii?Q?nZ3EeItiz7+PQWWbtdcEPPxhlme+9G4hSy9XeCD3WPDhc1QXD70GZr1wW36d?=
 =?us-ascii?Q?2C4+35grSDI5JXk9neQRDPtJta4yFKosqDYO9QuaIUF1qPkQICr9E6oSn9Ci?=
 =?us-ascii?Q?8z3D7LW0sHVuJSskyIVqjLbOTOro6O92ETjTsowjl4u9kNk6tFFJqQSt/em4?=
 =?us-ascii?Q?dVN3L7roDrjbNKygb1xkWr0eXxX9yHgXi6poKKSl+ih9SyIhw7xVlEm2TIMi?=
 =?us-ascii?Q?9aW6WgFknBLuETeifCZOq+UZoju6Xik0xPl9cSgjOGwaDZelNjMp46nZrqXd?=
 =?us-ascii?Q?y3J6YQI9vHQ9j87TTAr/AG8b/glbN14tM2zfABD+Ogbu5pEFFatiR2ScnnXv?=
 =?us-ascii?Q?cLIFJowX1Vs7WA2U76rfNJCHn00D+Yi++7a2FbnbZL3Hh12gxcgrm6beZeGk?=
 =?us-ascii?Q?piTDYNR6TRVjyo8IjiAdj2l5dq82aelnxYxDVDEBDwaor6HTD9P+FOGULGdM?=
 =?us-ascii?Q?S7QUOeLew9dFSrfeCMj9f4VCH7HMLW9eGM0gaImxeT83ZXzv7m0niY/PL7nt?=
 =?us-ascii?Q?5nAkIu8gkatM3QgrXKjb5qIZm7zO5hdg5iKbceWdFj4R0mgzzlPHwzeYzLsv?=
 =?us-ascii?Q?tgaRqaT5mm6p+0lsUQpmMBc6ygZSKsiggrQuKdSkN0drqlu63c3GwqkXJIal?=
 =?us-ascii?Q?wt1bXzm8VYnme3zNipQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:14:28.1550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 808bff9d-efbd-47ee-b7fe-08de37bbc1c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7297
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

From: Mukul Joshi <mukul.joshi@amd.com>

Currently, the driver code is flushing TLB on XCC 0 only.
Fix it by flushing on all XCCs within the partition.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 77746dd9faa15..fa46b0089e8dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -361,7 +361,7 @@ static void gmc_v12_1_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 				gmc_v12_1_flush_gpu_tlb(adev, vmid, i,
 							flush_type);
 		} else {
-			gmc_v12_1_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB(0),
+			gmc_v12_1_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB(inst),
 						flush_type);
 		}
 	}
-- 
2.52.0

