Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF869C30653
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jul 2024 10:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B9B810EA7B;
	Thu,  4 Jul 2024 10:16:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PZCl+huJ";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E54B10EA7B
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jul 2024 10:16:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Af/fzggguPWDz60zL+X5ICH/tqdCQBpDpJnuVnoT1JnRLERW1esufx9bPrQkhU7huFPCJa5y4X1vhaU++G+Qo2xqyzldx4VQrgaw5FBHoxrC7MOhSWWvzt/JJ/BecbnannUHujY+2o7lBBc0Ab20rjIsmpXcBP3mmaHvKqegoGlJwjOTcBDRh+3RGX5rQPDcdaVt5a1+TqXhGDNa10AJhhZCIkTPi6bPQtFcxhbIs6gjoIeS8JJFd9TVa3jqxArRXlTc4bHqv6/Tg4ccihdEja4kJ0EeqhtfqKPlR3oXV9aI9sgZZVSfP9S3L/FWRsOj1D0bCZnlk78b5PnIfQY47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S47rrT/kyA5AVyo4MfztJwQv9/6COK3JvgwYxt4sB/w=;
 b=GBn1NsOah2nlRvYYpgAdBuHWrpMb2ft/Z13nZ2cCEG+47CIQC91+OpZ0wUK3/ZIBA25yxU1ZlUS5PryE4kzdUTLCoQvXl6oi1bupXiwfVHT87j7nVlaGKrjztY51VOwlGmYtdBSlnReGzIBhA875LT6u87Wbq6t8bHF7NfFzih5WZP8i1tQr+nCNdqi5Pz0hU7T9WXrL9er0y9qBVRAw9K1jQO3XPnntvXFYNY/Z0XOro1L9mSNMhFdoUdGMR6Wfs0LyqW5d+mIUKsugZUVQr7+cw265OE4IXPKrPKnxB+MNKsGVFCGoz4G8FpbwZS4lJe7+gzF0mGTxqFZT//j51Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S47rrT/kyA5AVyo4MfztJwQv9/6COK3JvgwYxt4sB/w=;
 b=PZCl+huJF3LLWdOsqKwz6pekVVkwxByRX+ftUR1PWr83oyBn3ua4RwOQCZa0A35F7TtgwF59EBkPV2Hq+fi7DoVZv0k6HsBhK4CJ4kW/AqzBI1yUuObJ4RGzYEwG3uYw1roIFQXs7TdeDmPJWvzX6JuOetoyj+RAyKqi2Xtbdwc=
Received: from SJ0PR05CA0046.namprd05.prod.outlook.com (2603:10b6:a03:33f::21)
 by PH7PR12MB6696.namprd12.prod.outlook.com (2603:10b6:510:1b3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Thu, 4 Jul
 2024 10:16:13 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:33f:cafe::b) by SJ0PR05CA0046.outlook.office365.com
 (2603:10b6:a03:33f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.8 via Frontend
 Transport; Thu, 4 Jul 2024 10:16:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.1 via Frontend Transport; Thu, 4 Jul 2024 10:16:13 +0000
Received: from x570-ryzen9-5900x.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 05:16:09 -0500
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <saleemkhan.jamadar@amd.com>,
 <leo.liu@amd.com>, <sathishkumar.sundararaju@amd.com>,
 <veerabadhran.gopalakrishnan@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: enable dpg for vcn and jpeg on GC 11_5_2
Date: Thu, 4 Jul 2024 15:44:36 +0530
Message-ID: <20240704101436.2303041-1-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|PH7PR12MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: 95fdb1ef-df31-496d-6afa-08dc9c125579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sM0dQ2y44hLhcaacGhTw3AwIznDR9kAmMt3WHr0Eym/PfOsft97hPc3VY6Du?=
 =?us-ascii?Q?OrK2lPycOdHTIVlsHLlu9r9BHgxfw8VVq49JhD9gEWSIM8SFTB22pU/cORXA?=
 =?us-ascii?Q?Dh7mAipUYEErMLPCLcTDv8O9MrRZxCl50yIesN3MV/nPLupl3lpC82kDoD2D?=
 =?us-ascii?Q?CvRiJwxP4cqzrEMIsobxu4cSROvGmEUvd51aMzr6W7HgMkyO7SuPFxzHlJ8i?=
 =?us-ascii?Q?RA7mc/1eIS+8oHKoeX5KlmIvrfG7z8v9G+dkHMwS8jzXeOYQ1lWe2VVUa6CJ?=
 =?us-ascii?Q?voZWVSeZeam3TIDa+mtBmX8c4CufbdPF0/mNG3YDIwbWwBpHIQygaIle+sDR?=
 =?us-ascii?Q?+ZyfxeWSBJmMD/B3bZ+qdmUcZH0sVA4WWVHyJD3LxiboCYdJ5inBw2JhJzU0?=
 =?us-ascii?Q?rzBCnFTA/gqq+IbKxz/oE5HUqurAGlIssYTS6j+TVQm2QsJC3FmpDpBJuRgv?=
 =?us-ascii?Q?/8tKuJNu2oMjJTOPP0A5Z9tX/tCU6uLmY6HDTKUerWm9EsPHyo0kplNWvMwN?=
 =?us-ascii?Q?UrPaVQtQuNxBmWQiWzo/U/Ixg9DUlToOdF5touzIA4HtmmEyTiqGCetqXvI+?=
 =?us-ascii?Q?X1ke7ZXbJqbxTkv/BD8s8fLLyXnxe+xvuSSJx2OdMaPjN3ezLvAqv1gWRMR2?=
 =?us-ascii?Q?uP8erCiRoY/HxUN70SAO4lgXOlHuwNVtsep6h/YKm3N16fjo9qrdPOquwGXK?=
 =?us-ascii?Q?7x7ELirlv4C8nh13nw5ZBlnrHRleoN6i8FsFIibWPhc0MtmLEVchwo6a80JE?=
 =?us-ascii?Q?8XAEPo14gz0zLCsLNC0yZIkmh8miKbbKvhKegSofKNMSu+zukgBeAomcR7Ar?=
 =?us-ascii?Q?6lDOC7zkJ4alGEsOttU8FXcuta/mDkbRTm2uOAVL2S2iwrNHF45Xy1dooHGk?=
 =?us-ascii?Q?r811HKM0RQvSzo7/DZl4p3U9qD66cj9RUoOABsvuYNV/43IpD4PRKhjl4P2b?=
 =?us-ascii?Q?wrL69qtJgH1vfQrx55xF8Wf5krSuuGVgBC2MZhNMj9u8EpYhc6bmhDu3D7tv?=
 =?us-ascii?Q?WbOxtmCkelgQzl5NF6iXWf/cKeDn3ViAEHrVVdJ264Cg+dfsfRUcmrqjU6ir?=
 =?us-ascii?Q?4/qlH7+EWZz6V1/6dyrsEZW6DkSs/B+jhBgML/z2hnV5NICWRowEbYQBk4qP?=
 =?us-ascii?Q?s2yl5BzyG4WDHzd4n2ZH06p5vyBj3PjkrAwjmB7ypKjgjaTZq2DYBjlI+Wb8?=
 =?us-ascii?Q?PJA2YiWLmamph57rIQeTXFfmIq+Q0R75Ow0zEBkuq/5Ku/At3X2sUMfDAxgl?=
 =?us-ascii?Q?ZPia7HgBv5y8qATZzzNlo8qjd7FSI7Mk0Q0DTDl1eHEMbpg5O37WuOYaA2uo?=
 =?us-ascii?Q?nhxx6/w5fgjff9oE08IjE4V1avtqg4rZDMpJXSluZBTjDrEHZfqzEV2MeAwA?=
 =?us-ascii?Q?MQyl09j8EtyAzyIuyNX4L1pGvLWMP71w1sTAgWthDKwzWMMoR3bUB1VmZ/to?=
 =?us-ascii?Q?Mpr9cEARmqoEmApn8sex0jyluPThlUfd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 10:16:13.5726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95fdb1ef-df31-496d-6afa-08dc9c125579
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6696
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

DPG mode is enabled for vcn and jpeg on VCN v4_0_5

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 6cc86d13f32a..d30ad7d56def 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -774,7 +774,9 @@ static int soc21_common_early_init(void *handle)
 			AMD_CG_SUPPORT_IH_CG |
 			AMD_CG_SUPPORT_BIF_MGCG |
 			AMD_CG_SUPPORT_BIF_LS;
-		adev->pg_flags = AMD_PG_SUPPORT_VCN |
+		adev->pg_flags = AMD_PG_SUPPORT_VCN_DPG |
+			AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_JPEG_DPG |
 			AMD_PG_SUPPORT_JPEG |
 			AMD_PG_SUPPORT_GFX_PG;
 		adev->external_rev_id = adev->rev_id + 0x40;
-- 
2.25.1

