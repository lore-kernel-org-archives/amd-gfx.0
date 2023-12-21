Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11400C46CCD
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Dec 2023 20:41:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A83710E703;
	Thu, 21 Dec 2023 20:41:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C27810E703
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Dec 2023 20:41:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKr6aPwfdFbyyVklsKZSVisahnyPLgrkCAiSYRyKv/71zc/NrhA1yGDw1B2o8HGl2QkwWzyVOVFc6HTSr1eB+9BDk3Wlz/e2Y/EUjHLhLGcYF2t/xNoveKHxXn0f6ZgjQUiOQogW2TKypjMTMnfdiXkclW8rE3KWo3r9AoO9rLVFORRqfzCamDN9tO1XxphvbR/RQPeQP+I8tTd0zvhoJjchAYOvly95axDFISyHyoyoF6Lk142FNk0NePwHO2DdOkidp8gD+zOA6fGS48/30xyDG3gP72kYiqEqPZliyUGkam9G0JneLhASxAGZcNPSUD78yy3ppxVb+T6aKQglOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGqcQw23/nY9gE0/ysf7Or5MUPupQ6iann94ehUTbY4=;
 b=by1p37tBKCBLvExfu5rLLd2dze8VuIArP3zOvULRme64itfNCRfm11ffnaam2YxM5OEehtj9qacK0v754LtB35A71jG3+QqBEcHWMg3aLSyh7BLT6UIbWlqsXAfn7p6FmxiVj5lxgcsVVC1xxMU0IldGA/ZDcZutMEOOPUyY3V5Bw7Xgqb5Ut0SyvTy/jeOYOQqhIFKfp7nEgucOgkTGSihFMksFWkI3DTFphynviQwbcoynQgTo0mljU8lcyZWsmPqPZn24sdWfSIciYzOFZ9DMqI0mblzbPDphwaG2GtFKv3HE5EIwX76cCvR8C7y9FxMhEShVk7wo5PLU0G3+tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGqcQw23/nY9gE0/ysf7Or5MUPupQ6iann94ehUTbY4=;
 b=dXBs4pNQpNqQdfk2hWn9MTZbw+r88XZUAQ18wWR8nzz9E0v+e/xu7NgK8iInZSFyiKuatkI2rrDP4o4MH+Lo3Hr1q+jHEyHXyK23teOyebIbMYE7a728z6xaNjf+by9RqBXLl22bHmPSqZ+PECd3qjgaQa0B15M6EKSLqiWZyA8=
Received: from PH7PR17CA0045.namprd17.prod.outlook.com (2603:10b6:510:323::10)
 by SJ0PR12MB5438.namprd12.prod.outlook.com (2603:10b6:a03:3ba::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 20:41:55 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::16) by PH7PR17CA0045.outlook.office365.com
 (2603:10b6:510:323::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21 via Frontend
 Transport; Thu, 21 Dec 2023 20:41:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 20:41:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 14:41:54 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 14:41:54 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 21 Dec 2023 14:41:54 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/display: Move fixpt_from_s3132 to amdgpu_dm
Date: Thu, 21 Dec 2023 15:41:51 -0500
Message-ID: <20231221204151.98967-2-harry.wentland@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221204151.98967-1-harry.wentland@amd.com>
References: <20231221204151.98967-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|SJ0PR12MB5438:EE_
X-MS-Office365-Filtering-Correlation-Id: 715d7b9b-0861-4996-2337-08dc026544f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BwyWiEDiF+gZP1rfbGX9hxtGL+BP1iHCitqZU9rsG6DZzJ3HdJZgi6oA4pDGGvMfLKr7Ktg1o7a9jcsdEp1HVT5ICSJwlN8/fYbGvFl301t4neZIvibE+pusmyWf3zSw72Z1kWwiUjCX3GqFgZy4g8DJ1q+X6DpjGZVvZMI/Yv5Jfb0rdzMZv0sbziMyC0/wzC7Vf8gJruhlAqaBQjPqViW58AxxNkGf9mpI7zHdF/noA9FrKBmQOyulZvGgoROo0BpaGizyKTM0yABMgqqA5iFvJqKTIhSFUAgv7EjSpZs1VRsWGbioHcpbPgXUMpSeTcRZZLIKDEb72tJYGsuWkTJ7nLLrx7ptJPHbldKi2eBaoGIsYlroH0e1IpRZsrZJ57Vh7eHyoCKKdhy7smD2rZmUcNpAB2qReEyOQye5aV+QREUj0+4c0Opq8SolE6p1Uk7UZZLpBM1pMnvMoQArDauOSi0YkavnGossnUsOtxuvN+TzugGzUq/jXQJ29pTKCS3NQvwlDT3jAZGa9zwEpNQmNTFTAprR8Ylb8AXpk4Udiiq0leJVJfAbOURPcypNtkyQYvqVOFu7rgmx10wjKtV0CgG9jrnnvCwmqJfRj/Y6/1GAca9bXbnKDV5iixrT3lLyy0Jven5Wlslw/IczMwOCKFqPtr8Ird1c7gfohJxBIneRheHlYFcZCu4YeY2O19f71imhEnQ9X31SGp+oPdTR8naq1/CsR77FZXG8OuspfJi2jUebGSNgFOLjHE4zcGHA2M6DlFcOf8HSoKYF+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(46966006)(40470700004)(36840700001)(47076005)(5660300002)(2906002)(44832011)(86362001)(82740400003)(41300700001)(356005)(81166007)(36860700001)(70586007)(70206006)(2616005)(40480700001)(1076003)(6916009)(26005)(426003)(336012)(316002)(6666004)(36756003)(478600001)(40460700003)(8936002)(8676002)(83380400001)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 20:41:55.1076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 715d7b9b-0861-4996-2337-08dc026544f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5438
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
Cc: Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Other environments don't like the unary minus operator on
an unsigned value.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c    | 18 +++++++++++++++---
 .../gpu/drm/amd/display/include/fixed31_32.h   | 12 ------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 36bf65a8cd6e..9b527bffe11a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -85,6 +85,18 @@ void amdgpu_dm_init_color_mod(void)
 	setup_x_points_distribution();
 }
 
+static inline struct fixed31_32 amdgpu_dm_fixpt_from_s3132(__u64 x)
+{
+	struct fixed31_32 val;
+
+	/* If negative, convert to 2's complement. */
+	if (x & (1ULL << 63))
+		x = -(x & ~(1ULL << 63));
+
+	val.value = x;
+	return val;
+}
+
 #ifdef AMD_PRIVATE_COLOR
 /* Pre-defined Transfer Functions (TF)
  *
@@ -430,7 +442,7 @@ static void __drm_ctm_to_dc_matrix(const struct drm_color_ctm *ctm,
 		}
 
 		/* gamut_remap_matrix[i] = ctm[i - floor(i/4)] */
-		matrix[i] = dc_fixpt_from_s3132(ctm->matrix[i - (i / 4)]);
+		matrix[i] = amdgpu_dm_fixpt_from_s3132(ctm->matrix[i - (i / 4)]);
 	}
 }
 
@@ -452,7 +464,7 @@ static void __drm_ctm_3x4_to_dc_matrix(const struct drm_color_ctm_3x4 *ctm,
 	 */
 	for (i = 0; i < 12; i++) {
 		/* gamut_remap_matrix[i] = ctm[i - floor(i/4)] */
-		matrix[i] = dc_fixpt_from_s3132(ctm->matrix[i]);
+		matrix[i] = amdgpu_dm_fixpt_from_s3132(ctm->matrix[i]);
 	}
 }
 
@@ -1136,7 +1148,7 @@ amdgpu_dm_plane_set_color_properties(struct drm_plane_state *plane_state,
 	uint32_t shaper_size, lut3d_size, blend_size;
 	int ret;
 
-	dc_plane_state->hdr_mult = dc_fixpt_from_s3132(dm_plane_state->hdr_mult);
+	dc_plane_state->hdr_mult = amdgpu_dm_fixpt_from_s3132(dm_plane_state->hdr_mult);
 
 	shaper_lut = __extract_blob_lut(dm_plane_state->shaper_lut, &shaper_size);
 	shaper_size = shaper_lut != NULL ? shaper_size : 0;
diff --git a/drivers/gpu/drm/amd/display/include/fixed31_32.h b/drivers/gpu/drm/amd/display/include/fixed31_32.h
index 84da1dd34efd..d4cf7ead1d87 100644
--- a/drivers/gpu/drm/amd/display/include/fixed31_32.h
+++ b/drivers/gpu/drm/amd/display/include/fixed31_32.h
@@ -69,18 +69,6 @@ static const struct fixed31_32 dc_fixpt_epsilon = { 1LL };
 static const struct fixed31_32 dc_fixpt_half = { 0x80000000LL };
 static const struct fixed31_32 dc_fixpt_one = { 0x100000000LL };
 
-static inline struct fixed31_32 dc_fixpt_from_s3132(__u64 x)
-{
-	struct fixed31_32 val;
-
-	/* If negative, convert to 2's complement. */
-	if (x & (1ULL << 63))
-		x = -(x & ~(1ULL << 63));
-
-	val.value = x;
-	return val;
-}
-
 /*
  * @brief
  * Initialization routines
-- 
2.43.0

