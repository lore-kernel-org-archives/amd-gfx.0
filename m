Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F32606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Q8Y+5Zoj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30FE810F964;
	Wed, 21 Oct 2026 06:27:51 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 847D810F964
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:27:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcEiOI9xHAcavNO/wSJiciWgwWdZjUD9G+YZ0CS/ges0wXfYOblzIcWNuxiYBFTzVEazaCs9cz6vnhSISOCx42ow+OZoH/30UrtssvGOtIsEPjr3/B/xLAA3iG4w9tN4PgqfDWleo9lJnhlmzYOZeTdsqBQmENJ8ryRdEAUPlC+ws+CQ/HAYDGqjD78NWOxqoPsqMjppa6PHhydk/u0RQjetXP+/h0GhA4UMZ4h6z0cFTvez1EjTykRDB5srbS4ncVssHMFImuQJGjT1V9WCRf0Z5pkePVfoF0OobEGeaLoiTHZQrADM0wo46QVX6Kieey1uIYXcPzoiA6ow0GNQKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vA7FUUS0tjJTsCdVkQdcgkmoBH7zBHmXBvUt3nT8dAc=;
 b=xUoeraScJPD1epoQ98K//K5AheZZw2VigGxX2P2hkSvcIDFsdYO5wGWE+CqKclRhI4pieT8RBufaGH/tBQCmWvslVWbZSgfVA4DgNhqRYFcgR1sZuBhrZNIVVRrbd8q4VDxrMln31L8Q+XS45zX7eU+a6ZoQayBw/VQlG/cGZaANf876LKO+s+en2qGNbgQ31zCvViL73mM2Y2SktjB0URy1RghvBxLhT8saSIBFaTzGG7WE8Zwg/sbVf2m0NzY91v7MTZp9EpbCokFgVXsAKJEpeO59ucsV/9dV4cyrrKlcTnjqhOaDaZQbYdfA8R0qswCl8w2zHJsMA0xVz+VMmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vA7FUUS0tjJTsCdVkQdcgkmoBH7zBHmXBvUt3nT8dAc=;
 b=Q8Y+5Zojfyqth8XMpu/ZtWL2sORWWGX1uefeOttSQcihVH7ytgS3eO5UKXMw9dpDhmun6+XBLLpwxl/CQBRHmfcqoBy147lgmdDdNTfeo0bMZjlALNK6ACvNAfAzS0ZejGhl/Dy40NjeMgCGiCxWVI74LxEwilERx9ZerjCgAmo=
Received: from BN9PR03CA0320.namprd03.prod.outlook.com (2603:10b6:408:112::25)
 by IA0PPFB6B4D32F9.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 06:27:42 +0000
Received: from BN1PEPF00018547.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::90) by BN9PR03CA0320.outlook.office365.com
 (2603:10b6:408:112::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.18 via Frontend Transport; Wed,
 21 Oct 2026 06:27:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018547.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:27:42 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:27:41 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:27:37 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 37/49] drm/amd/display: Update alt-ch size calc to handle MPO
 + ODM correctly
Date: Wed, 21 Oct 2026 14:22:43 +0800
Message-ID: <20261021062519.674697-38-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018547:EE_|IA0PPFB6B4D32F9:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bbd9dbd-535b-4e6c-91db-08df2f3c6996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: z+BgZ3Tc0Pf0OASfVrs83jCYAyTzPOPZltSJ8fOc5pPNkPwPQvkGfcSvQoKjWWysq/qFkdcMMfTw7+P16QoHNHovYylMHF1vXB8qJoFSWPcBKDgAPUpQ0scxZFIC/Y2MDhh1mE0lkf2i8MXxzhk/nQXd5uR2O8E2FiV2xtR3GAil1LA59Eawhy2dfA3FxmxbuH15NMbWnW2PGg8FZEudO2d0OL4FTMxOldt1wtQprtCX1+LFoz6QtAyII+NosHpAxIFvl8istPNUni+/OP/KhHenjunGYt7mFMl0Goqi8AHmgecV8xEN+b9jVjS19fmw0ODllYkg/+15zJ3Q5YriJO44TmGXhGF+txvz13e/2Ey4suWRs5ushFpJmNLKdGk/JjGPo8qpuhfVHj4Wo8HAkrPiBSZmEd3k0QRMNH/O7+h8oR99QJc5DcIxzi27rdMlznw8orTmL5iEotWJPHcZVEtKhZ2oxO5zxxmYtsqeJMPZknWv26sQJ69GBuey4tsxtjwKJKMFqMfje6cnwqmmCzO0A/7r+f5imwhnl4lTe9RSBb+MJs8t0eAflrOf6qdGKN0icMB8dJwf9dP9BM3dYGo4D7UN8pSmoTsUCmPgKKAQLeCF/uB4Tw7HH94ZlyHxj/3pqcQJfcse9U5i30eRB2BbCWJPexWBzbvnq40LFJ+LnoDZ+QbzsjlKHuNfPblq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZLamMd6HnnZfNNY8O/Tr4WHasy4JGiurVjwuOjIvG69mVZY483hAayJvJRbCiLPcohFV7nY8z512kxb3cHy7mmqbBIQfGSfKo3qVccthyKnb3p24JbD8gGT+1SS9ySPUc1QQ1wcNdPGvLNiDyvtWW+skE5jv3tk0v4YO0B2vUALhURpkcQcJ0cPHBp1IKbcNFeqq/EKYQ5In2dop8wPerKdLGSMzPNj4RTq2SvvHtD0A+GUc2PIwC39qurffHA4rT+dvJ3kctMqok0T7ObFrgtB3nlItDP6gxGsvU/vz0xO553UApqHKl2J+PnU1QEGV68Gz37MWBN0O+SW2ZoDobtmFKhDhTQi+NkoqLPdHiXsz2akjpZpEVGKCQ5T08z5SpeyXiFfz3GZXsKCBrypGxtuYJpsYJMf6Mrg184Ztmlj6HM0KfXSBrsGJkAXZIrlK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:27:42.5492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbd9dbd-535b-4e6c-91db-08df2f3c6996
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018547.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFB6B4D32F9
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
In the alt-ch size calc, the copy width/height should be min of
the odm slice pixels and the entire viewport (not divided by number
of DPP). This is because for MPO the entire plane could be in a single
ODM slice (i.e., driven by just a single DPP) if the viewport is smaller
than the ODM slice pixels.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c       | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
index 485ad96f64b1..b3a2858281ec 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
@@ -260,9 +260,10 @@ static unsigned int calculate_max_mem_size_per_plane_per_dpp(const struct dml2_c
 	odm_slice_pixels = (double)h_active / odm_combine_factor * h_ratio + (odm_combine_factor == 3 ? 2 : 0);
 
 	/* Unaligned copy region dimensions (in pixels / lines) prior to tile alignment.
-	 * Also divide vp_widht/height by NoOfDPP for MPC combine scenarios (i.e., MPC split within an ODM slice). */
-	copy_width = vertical_access ? copy_src_lines : (unsigned int)math_ceil(math_min2(odm_slice_pixels, vp_width / p->NoOfDPP[plane_idx]));
-	copy_height = vertical_access ? (unsigned int)math_ceil(math_min2(odm_slice_pixels, vp_height / p->NoOfDPP[plane_idx])) : copy_src_lines;
+	 * No need to divide vp width/height by NoOfDPP. The entire viewport could be within a single ODM slice if less than the odm slice pixels
+	 * (e.g., multi-plane scenario with ODM combine). */
+	copy_width = vertical_access ? copy_src_lines : (unsigned int)math_ceil(math_min2(odm_slice_pixels, vp_width));
+	copy_height = vertical_access ? (unsigned int)math_ceil(math_min2(odm_slice_pixels, vp_height)) : copy_src_lines;
 
 	return calculate_tile_aligned_size(copy_width, copy_height, tile_width, tile_height, byte_per_pixel);
 }
-- 
2.43.0

