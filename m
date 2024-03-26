Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F773C6FD1F
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 15:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E92B610EC41;
	Tue, 26 Mar 2024 15:52:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ipzjdxpa";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F22A510EC41
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 15:52:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nj1iP0n+ithiHUJXv7+le+UHfcsgqW/4N0AJ5HpDoC2U+A4BhJQDQLjB1ZeuoznNhvKPBWPTtAe40a1eAMWxL2XlgpTOeUjevEylyQyewuTaOX4DcKoMYFGyKKXwc820E7IoLyWRoh6ei/u8Pjrcwc9LLarvdQQbpptoxBBino2WCWrPvlICAdmpLJ+CB1cAWbE7HXAVdkvMwGdMzVXOVZNVsb4jEpOpYXRG1XV04Dg3FBQAuIHSirjKVrj0KxpTQ9GhrmQ6x0LiAzsBaM74rr5tdwHVsMrKh2RgpPKKZ70CLe4Or6TJwTU8MoridBxuSsYQgUIryGd5F1COgRQSKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e85l+gLB/0+P06/dotFNtCzTaldAJMlQKPZXn4Yv4tw=;
 b=ajoUA/uKJg8Y/UUSuKll25jyVk0wqeRHt82t4HxiUCd2dByKKV53FEitfnScmT9GMuO97JssPFKkoHCowYS+aQNTHfMvQ3bs3+8ZHV8MUsISQJ0e0h+isgF+3bcDtgczBWSxXg2RSXCWxKvkvHTKoXp98EIKfMt5fkKeklcTB4XDJ2DAfTJSWrMz60JibTx6RvrX/lRXXpuIM3mJDMRIkRIPVf0OywNh+KG/iQLS5fEBFkCihc2nmBujW7PT4dQZOWknOUGipsT0HqyvEKqDQvsSBRcApOvsSmBoaFTvJKEv+qwxjmJeO9AXuIXtJqtQpKWFqZUgukAzfQNycGIanw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e85l+gLB/0+P06/dotFNtCzTaldAJMlQKPZXn4Yv4tw=;
 b=IpzjdxpaxzPmhidtlKbKzYKD60IQltzvqtb2yK/XbUIiWqZE2KVIbN7wYodI6Yp1fonruEUyYR+J/6F/fZb/DJt+/hfJ0cKqRAa198oCVqpHEg3vVpjnQxpFmi00vMoi2zUk2CExlLY+WMu79TnJpyIMT/gOP4f0ZIfErPgM7es=
Received: from DM6PR02CA0144.namprd02.prod.outlook.com (2603:10b6:5:332::11)
 by SJ0PR12MB6880.namprd12.prod.outlook.com (2603:10b6:a03:485::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 15:52:19 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::4f) by DM6PR02CA0144.outlook.office365.com
 (2603:10b6:5:332::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 15:52:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 15:52:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 26 Mar
 2024 10:52:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: always allocate cleared VRAM for GEM
 allocations
Date: Tue, 26 Mar 2024 11:52:03 -0400
Message-ID: <20240326155203.5246-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326155203.5246-1-alexander.deucher@amd.com>
References: <20240326155203.5246-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SJ0PR12MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 96637077-de08-42ef-91eb-08dc4dacb769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 25OM3pkvCtKyu0pni0Uoaog21/XpXEKGBoUO3FcDeb/sMntZl6bEsOcKgw/lDBTjMao8Nl8B1hdlgo15lHpoChMtpziTLkJ2bYH51ylEYbE7F1nmLEBayGUUazzL0X6/s5GrrYr4MchI4a7NpSjEgbviklUIpU0ZYrJbvOOhGtbXDAJ27IBwY4tTDR1k+OfrViFgP7IIbv9UGe+mFT38F8IZQIFUjTEIo6st1y7xkh8eESuhpEaMi49bfkXTaMGdwJcPn/04DZTlJUEDSedMYVGhk2LKEcd+NsyZNqnDMAMjK0iKy29/oc3Ag1+S/tmGSjtyZ9braDmyhURzdcljWtnE3nsLZHzFKrUMrZSOFBHtRudpTjauu4cSOE+/WEXHHxSpEcSyFtWwtJ3ETvmHy58PHRrfXGo7wUrzY3lFo0rBo7a22W1sMEVPAD+/EmG4WixncmXN/t6Nv+GtwPucYlV9dF1LQlk/rxI4tYzfA8GxXgWngo0Ul8LYPBIjlnUP2CaiWPX+uwuZK6UFqbGDEBgHFzq0foq2JJK90A3gp/pdoMBu8ZlIvR4NmB4bcMfpubauBNBl71uMyfr7giQ94PTGfOVP2YiVgJR1NLMwnMdcV0VlOIEvjaPQIyYFUuE0+g1X9RvEs0Zg/C3kX3k1cOuFF4FBBDDA0bPysiJdDVZHwAa8sQmv0BSigSu6PaWezvzrCC09PPclgyyjvjmEeHTCf4n9Rk035uqZ93axd7kmqsFMYVJGAIOgWQc15tzi
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 15:52:18.5224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96637077-de08-42ef-91eb-08dc4dacb769
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6880
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

This adds allocation latency, but aligns better with user
expectations.  The latency should improve with the drm buddy
clearing patches that Arun has been working on.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 6bbab141eaae..cecaacc1affe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -346,6 +346,10 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 		return -EINVAL;
 	}
 
+	/* always clear VRAM */
+	if (args->in.domains & AMDGPU_GEM_DOMAIN_VRAM)
+		flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
+
 	/* create a gem object to contain this object in */
 	if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
 	    AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
-- 
2.44.0

