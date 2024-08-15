Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F809C5320D
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 22:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3643710E557;
	Thu, 15 Aug 2024 22:45:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uH4zGJj4";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D42C10E550
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 22:45:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMfz+oLvNOXXCjz+KWjEO5hM8ab8fvoQ+a+f2yGE1Py8s3Lacg37NtB/J7/76IRmh1UZzQw0YONIFVRWBhGN//adJU82dwUwud2qL9GtBpYLbreQMX5fDvIHIs7Pv27hC/rphbZzYFlH7PNAD73OH7kaIMggSu1Brj98x+8ZruEsouxOflauOl0hy+YGQ/7K7+iFtE6+mA3yfQm5c7cCXm0V+XZUGR3fAiAFsez4B90ylCeYR0+ZZpWux2a/CkJEEmSzQzIvllO/w+/dHGlOzVncC6vj8ozGB9p0jO74F4PzZsWpS81GnJY42Vrs0zvwB2e3Oa/sYHL2zxl4ukQ+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DAMb39ruAfpm1eccjuZHjLMyd4icfdwI1TvWrywrUY=;
 b=V5t4oGUNd/SW0Ipr+0MOLwfWVa+BBR3UJXRMNx6QqZIDJtMrGMUX49hRxU2skaWhaqcWQtmgKOMv/HC07JvYZFWbE+JSfSgJnxB2ycP+mgphIFaE/wKQUKYq6TILZE3MM0DdBXbibtctx+IuePW1S8R7XpICbgdm9okvfO5t2/IT5RtRXQuXtuYeZdUGURYkv82+c/TSTsbu0PmmFJsAA1Fe2eon+aRWJ8eaUDHaBW68GzHruTBFHwBJ5vjWRG66280eqE+FT0S3d86xI8Ic0Um7XN7LgjmXYCbdyCUDcvTZ5F00qdkQH3JCodHDWFiLZJyshcl/hJC98SZDbSr6rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DAMb39ruAfpm1eccjuZHjLMyd4icfdwI1TvWrywrUY=;
 b=uH4zGJj4TSWfCnyIESSUvzcuPHDa9WEmlQb7p1cpwX6hVaQF/lLwfhJUOnPYVSZT+EBNjshOvP7spsKA29InP8j4oy+H32IoygWt1+pMWEquPCkx9oBK0+dOCkK017JdRqoP1WctXRae5EUsmoLuleUvKs97HnDPMRD8voVGgZI=
Received: from BN0PR03CA0048.namprd03.prod.outlook.com (2603:10b6:408:e7::23)
 by SJ0PR12MB8116.namprd12.prod.outlook.com (2603:10b6:a03:4ec::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 22:45:43 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::4e) by BN0PR03CA0048.outlook.office365.com
 (2603:10b6:408:e7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Thu, 15 Aug 2024 22:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 22:45:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 17:45:43 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 15 Aug 2024 17:45:42 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Ilya Bakoulin
 <Ilya.Bakoulin@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 08/13] drm/amd/display: Fix construct_phy with MXM connector
Date: Thu, 15 Aug 2024 18:45:20 -0400
Message-ID: <20240815224525.3077505-9-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815224525.3077505-1-Roman.Li@amd.com>
References: <20240815224525.3077505-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SJ0PR12MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ced1318-2222-48f2-c6f3-08dcbd7bfee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EWdTDPVoUEFp6ikY+Oqo9USsLlp2XVxvXM3rkZ10f5uQWe8wrw4PfOvYGL7t?=
 =?us-ascii?Q?lK6l0BWO1LPne6r/PK04x2j3ZDOQKSx9N0qeJT1pS/3gLoqJKGS4hcSlcnlS?=
 =?us-ascii?Q?f4rtxaq4lYo+gu9F+lBHCSzRywgLBEEAXXokhTD19Ppt6k/IHriowR3bHSNv?=
 =?us-ascii?Q?afyL66NTHYDMwZZSsu2Z2z9vUxMooOBT/JraeHF1u/QGs/3rw01wBJnfHnGC?=
 =?us-ascii?Q?GKDdGAthsPLraSXBr4fzXT6xAYiwtC0d/s1Lw/d9II3fAwKaNwdNgETyJ5xN?=
 =?us-ascii?Q?oFq/Z7j7uQUKioDSHTpVhclA0+eI9dd6copusREZprEzCFIwOLnpzA/RcdD0?=
 =?us-ascii?Q?bw3KJB66KCOgaQbTSjEy7HQnAX68aiNB/Is9laqz0MXAZOfnsuAcJOLZjmtV?=
 =?us-ascii?Q?ZQXFefVHqJyS4VVxudp4BzPqMRhXBbz2YNnrwyT4Y/jAsO6ynB4f8ZgBSb5O?=
 =?us-ascii?Q?TsY7o/kPqDvbEfMLIJ5tDfGRSpk+I3YfTokH7FNU+Ug4SQDGKgh+9DGLKijd?=
 =?us-ascii?Q?3GZjp3c9n0wDOS3MFUTSgC/JsoJYE3wCZU8pGU7K4DJIt/cK6l4C5WjL/ZqI?=
 =?us-ascii?Q?wusM0oiWCeYEOn9pTntuf3AzC43978KYy3l+C6PNnywwYhXyZ/4aDz4Q/3w1?=
 =?us-ascii?Q?lIxHKrX1bjpIEjQJVktKTPqASwi2V0VOqyy6ZeVp0YrvfX/fXqPthg6EGsTT?=
 =?us-ascii?Q?nfKi7A2P7FRfwnjWokv/ktTecaGvyv0Hmj/6FW6JSpErYe0pcq7VNoVy1rAy?=
 =?us-ascii?Q?nAXnEEAvJtn8VsY7Nuoegetsg7hY6MAxTMTBCj85wTKYIKm0/H0GpDtvwrA0?=
 =?us-ascii?Q?GiW5xu61aw3lZLBOxl9dZTvMqKSfaYyLySh5D7eGSxtijeQKxiiNsx/OTee9?=
 =?us-ascii?Q?97OCqhstBQHx3Caq01GzKXk94NodMpWUiNWwrmhQgTsTKINQR0yWFrBd2P1U?=
 =?us-ascii?Q?G//EV6qzcrMoKULtXFg1jJ94kB7u/VibofVLLPY2vZNUpLzOoMeV4XASvYxh?=
 =?us-ascii?Q?yVNbdFvnND/QfG4YmvR7ylZX/cGwf6UT/GwybT/9Q7lH/bYVFJ4uVX6crtYV?=
 =?us-ascii?Q?LmeHCZEkRwCUJ5zmi9YjTWkyZo820jLQFBX+6P5bQw58TLnQO97rx/TPEFnM?=
 =?us-ascii?Q?4fIzUSS5Ploy39JZizStjH3kmju8rpDJTuxpm+eVCTSqsTIp1tJGS8hIyOWW?=
 =?us-ascii?Q?qk81khrLKazQdtfQnFJQfFaAF6kJhXxgnPWjIi6GrGOw1KXVlaaWdvuSZm8I?=
 =?us-ascii?Q?VmaIAcIinfbpgVHA1JnpONiQRyg8pVUOlewHVZcZuJgbRXjqaGQ+UVA+vICr?=
 =?us-ascii?Q?O6GfCNN+P/pYE+wllndf+ARXeOIlwj/UTrGSjMm3sno2LEqs9ErK0wajDM/S?=
 =?us-ascii?Q?Cv0XN6+2dctnLH+soHPAZqbfZG0VSeuDQZXFZg3LrqMS13HU/nS8jOq7slD/?=
 =?us-ascii?Q?QArrtNNG3aHFHI45F98vII9po741OpW3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 22:45:43.4150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ced1318-2222-48f2-c6f3-08dcbd7bfee6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8116
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

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why/How]
The call to construct_phy will fail in cases where connector type is
MXM, and the dc_link won't be properly created/initialized.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_factory.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 8246006857b3..85fd6e422238 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -524,6 +524,7 @@ static bool construct_phy(struct dc_link *link,
 		link->connector_signal = SIGNAL_TYPE_DVI_DUAL_LINK;
 		break;
 	case CONNECTOR_ID_DISPLAY_PORT:
+	case CONNECTOR_ID_MXM:
 	case CONNECTOR_ID_USBC:
 		link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
 
-- 
2.34.1

