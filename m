Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BECEC77B7F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 09:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2BCC10E28F;
	Mon, 23 Jun 2025 09:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mn7Qdzq2";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E56A810E28F
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 09:05:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1pY9sweUqEGbpQ7pIH8jDKU9J6B0Vu+bfSwTlwESQ0wr/BmVIfIfc42hGyvL9pEtL+L62X8LfQFZANwYzzTVCgenBN9NP7UlfHWDmAbEFKKVdJnbfieV6BtGXyXQxpnq+95/aWUfKI0H4RBlGT+fT30/x0OVZ6xt2i68o0/hm/nQAai2DVfyk1gqbmlilnm2tUTnXNGJmU8eUwqDVJmRi6F7WS2g+aQ66EPom91L2OAX8qaZ8JSxSkA9DLeAoNWPS8RyLPJiFAoNqUsSNzOZmIlpA15oI3Pzg7d7d7oPJmQNbgL4FDTVhMUc1kYqQ+SxDQCCfwV/Q3uu9rwFHwXDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoFPUZE8emlg1RABpEiaWTZ2lf5y+Nvg2nWbjr6nlKo=;
 b=j+Q1IlNAE6PpeqCbtz5AVTatwBOzPq6J3sK0xIIIh78XxLvgWDYJMWi9LY7bnbNaWPwZjYyLTU10yQonRS+q7bwi5dS1YQXABWs6dRMgHo8CegmY5jMnlj6Y/gx2NwfsfsUX7omQ0b22/sGfCRCJlhk++3DkjQwvTHEOgAIHEfhGW0cthY6HV4YTCSG8DgXP3rs2LgJUZnXSJxDnBRv3mEnkcPsL97iGOsSGOJPk+T0lPC3ObQMpI/qe8yqk3jbq8VozkFUCpKGJ1wLu98Pyr4sDhK1H4Cuf7Ft/wBXQnnqMQ23kD41oxIlzPg+eBOROS+5NtQ7G/NZGyl1+yQ+5/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoFPUZE8emlg1RABpEiaWTZ2lf5y+Nvg2nWbjr6nlKo=;
 b=mn7Qdzq2oCcTPnpQBuldcKlzvLiU3d3PbhfZhBjWCDw9aizEbcmGf0AoKf2NIYhY5/pNUHoEZKWO4jXuvN0xCdwSm6XF3TJ+tjdYKluF+RP1D2+Nka8pZwHmqQppfm6ksm7pl1GoFUn3WbXZAU1f3YNf+KaI/k1W6HWrS4vZEu0=
Received: from SJ0PR13CA0038.namprd13.prod.outlook.com (2603:10b6:a03:2c2::13)
 by MN0PR12MB6078.namprd12.prod.outlook.com (2603:10b6:208:3ca::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Mon, 23 Jun
 2025 09:05:03 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::60) by SJ0PR13CA0038.outlook.office365.com
 (2603:10b6:a03:2c2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.15 via Frontend Transport; Mon,
 23 Jun 2025 09:05:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.1 via Frontend Transport; Mon, 23 Jun 2025 09:05:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 04:04:57 -0500
Received: from jessevm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 23 Jun 2025 04:04:52 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add user queue instance count reporting for
 gfx11
Date: Mon, 23 Jun 2025 17:04:39 +0800
Message-ID: <20250623090439.3811614-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623090439.3811614-1-jesse.zhang@amd.com>
References: <20250623090439.3811614-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|MN0PR12MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f85aa16-2563-4b18-6d1f-08ddb2350a44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wsk1ghW/Y5WAVtqqKKcFpQOyY4vFjLMMs+DCGYL7tVvCS01RbKJlFAXxwe/W?=
 =?us-ascii?Q?K1D7m7L9DnxKLPtitkvVvkC/AyzbXsSblU+DOchK3U51jzbFR2KisvQeJ16E?=
 =?us-ascii?Q?frCLJs+9NGxSC80P2Dnbg/9tuwxr8nvrF3ZorXLm1nDt+Qw6mFPtFzmkB9B9?=
 =?us-ascii?Q?Y57fSq4m2V/XQC0x30L6lwkQvPdpq9+8vmHkLXpkv2rIoXu6RTaYJTTfQdSb?=
 =?us-ascii?Q?yfM9544q0ctKOhF3Q07jzW+s9r6f1pthCbsxLwhmgv90ZCS+GXqXnh061JOH?=
 =?us-ascii?Q?hhcFg8LAIJ71urdRIEJeZhy40CHqcMLBwoMxhk52nAoaBew2KKfhg4PscPS7?=
 =?us-ascii?Q?/e2Tbkk7F9cwdxdvmIWOPBl8z4FhiKSQBmQLN+Aplljwss+Y50zvezxqbKa7?=
 =?us-ascii?Q?zNa9W4WPguL9x6F+wQ6KXLKX3soTJthi5rpVXjUUS6ZLXGu7KViq/xHlH1C3?=
 =?us-ascii?Q?Owyu+lOpVs5kt5eeFottHVRoPEnlsI4twObuhpzfIYnWAk/UXDrc6ddiWjiH?=
 =?us-ascii?Q?CzeLNew0zI6c8hFZ7rxovBx2lJlIvIUqlqglCBGTP5zZ/H0OG+iNa029AwCp?=
 =?us-ascii?Q?oLfrYGPSYq13pLFWiQimLml/W1u+LrMRJSCBoFk8MtC4rdynMOpYQTnp+114?=
 =?us-ascii?Q?wimgDT00napBdko/9q/ZYCcQzhegrJPrS00/ovQpDm1jZ+PeMjeFUaYdrWne?=
 =?us-ascii?Q?BSGti2dv3r8+x9mbgdct5mD8KiLwHWl0YBfYbpRwZJjLkCxVUPRHlPHRw0fI?=
 =?us-ascii?Q?h5ECw2w4OZQK2+6WUJvba9+qIL9X0unkfv8ZRRgc7KG7CcV8qrdnbfnK5FFX?=
 =?us-ascii?Q?//REtbTkxvfa3MoGSWiI1q3v/dy2eR2aKhPX92s5gg5RP9vfiUR0V/60YDiE?=
 =?us-ascii?Q?n2ql+QcLGDvsuWJR7H1PBPC1c8pKrH45tdnUeSfy7l97h/R8clWFSqrBcPz0?=
 =?us-ascii?Q?WLcHAqk7w/xvo3suusJGO3qDOhDcGx1ZdD4oRvuKJAKZjCA0hIsv2Rm2t893?=
 =?us-ascii?Q?hn7bmTJ9Gr1VRV73gvrVGzFyuC20pmZ+5fgE3cfDhGEWsNr0Wl0LkxiAqBQ/?=
 =?us-ascii?Q?7V3SE1EJF0z3fzBgJM5BS4HpanOEBLGL6DpMPpauJNIyZG+kRp9y4mzUdsDA?=
 =?us-ascii?Q?yoXIgDQL/hWZv6YptMRjNu9pWrACQ/ZND77SRoPDthrKjBnfuSbWrEF89avi?=
 =?us-ascii?Q?8QJPzcsHg26cH90ZjqrdFb87pQt5vWTGQXaG7a9RB3Ilu8jN1i6hzb8EtR4i?=
 =?us-ascii?Q?FN3qRGLkKIDObjIVM7cVyu6ZqJxUIKiZiBxRc8zMt1xgDg+xIUYV1/dvVI5L?=
 =?us-ascii?Q?lsLXEtDzflmcbpj5AUlelcoTOGnJA/f5nFytHDiSBvurEdhWEEobrW6e53BH?=
 =?us-ascii?Q?5jiaFiL+IZe8FtKqT3XTrW8ML7c8yBvExFxHA2kX7TDHU/cvR+1qiKAmqCFq?=
 =?us-ascii?Q?lBrZVTc5A2AQt0oEPT0tKjmrxTw1G2MhgaCS2MKAu5LeOiZIK/NVXikB5Lnh?=
 =?us-ascii?Q?QzH4yry5m9mWXlueEJ4bbh3t8xg3kZk6Jj8S?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 09:05:03.0407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f85aa16-2563-4b18-6d1f-08ddb2350a44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6078
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

Initialize the number of available user queue instances for GFX11 hardware
when user queues are enabled (!disable_uq).

This sets:
- userq_gfx_instances to GFX11_NUM_GFX_RINGS
- userq_compute_instances to AMDGPU_MAX_COMPUTE_RINGS

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ec9b84f92d46..775036146d5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5226,6 +5226,11 @@ static int gfx_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 						  AMDGPU_MAX_COMPUTE_RINGS);
 	}
 
+	if (!adev->gfx.disable_uq) {
+		adev->gfx.userq_gfx_instances = GFX11_NUM_GFX_RINGS;
+		adev->gfx.userq_compute_instances = AMDGPU_MAX_COMPUTE_RINGS;
+	}
+
 	gfx_v11_0_set_kiq_pm4_funcs(adev);
 	gfx_v11_0_set_ring_funcs(adev);
 	gfx_v11_0_set_irq_funcs(adev);
-- 
2.34.1

