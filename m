Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C41EE0212
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:01:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 747C410E219;
	Thu, 14 Sep 2023 02:01:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C8C010E219
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:01:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLDDrfNeKBpTgJpWZhghcBxOprT0sPPlpUUbwC3SdVshQFGTvov3wW/3S4V0Byv6LPd8hhEqNJzWrnwj2jUst9Acl8vUfoFN39G6tg5TKf21uPshxtOb07Qx+SQ/l74tMv9od/S0+uMnP0igwIOGgfDlBkRTgsJA/0/Jyw7LmkuhaCJEyf1maj0Xn4PYMgs5neVywX5mOBStvr8CwtRlGLGp1XS7cmIdC0yv5g6byMhLpPEwuZo5oYs8TWfFIr4KW+S62vgpQx/uqIK7PCi8L5RnFn+WYZF2xB76HP1GZUhTjmbApCSbcQFJsaXTs9qGuGvOzsuxTQdgRBBWEVnfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LS59MO9hHNWxXAKtiUaLc400cICVMp9bDFoX3xhv/C8=;
 b=WAGF3rnHIbqJ9Uerwf03Th91t3a7bhuk8BxepFkSWvZtZOXZ+UrT4RgfkN9C8Vdl3KTCaHw9O6YuYWBpwnVsHTc1xg4JOgVjnV7zgQ0NTFb/QTP6SJcuVI7J4+L6XI6CcHd+r5zdmaqKCUF5fp82+JAqNzZW8I5YhVM7YHgecLS6+NeTN0sHuxT0hh9YFXANT5TSJEdPFRyZl/o/4DGqAxB5OG0FoOAyjCuASEYFtsICYVWiqaeRwwtzsw6cCHYQKMklmbyq/pVc4hNRLOcJ5Q3wqVqsbooC1ybFJXUCbEe6sHKUzOvWI1J/JJ5XRxGu7nrfjOt5kTurQL21WHBYhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LS59MO9hHNWxXAKtiUaLc400cICVMp9bDFoX3xhv/C8=;
 b=OMuBg/5zHVCo0y9P2rbBOWGkWrDxpgA1sAeTrWAl7RWIlSEymzRwQdGCsyMnHNWAWpz4uouNfIVF2EJPLWrg5liPCqfuqaKTIGGiZkid7KyV7TBThJQexlrvFPqDXIc6FhTYxcOkbvN0u9l1KJMlFk74rJHUyhafhaO70vhonWE=
Received: from BY5PR17CA0020.namprd17.prod.outlook.com (2603:10b6:a03:1b8::33)
 by BY5PR12MB4274.namprd12.prod.outlook.com (2603:10b6:a03:206::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 02:01:29 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::a2) by BY5PR17CA0020.outlook.office365.com
 (2603:10b6:a03:1b8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Thu, 14 Sep 2023 02:01:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 02:01:28 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:01:26 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/28] drm/amd/display: Add DCN35 case for dc_clk_mgr_create
Date: Wed, 13 Sep 2023 19:59:59 -0600
Message-ID: <20230914020021.2890026-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
References: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|BY5PR12MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: e4180766-5e99-448d-d583-08dbb4c6826e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bg/6OEPJd68J9ShZAHc24Hh+H/7mHInXlUZA28vRHLtw6IRAAzpLinF5bOS56zrrWtFRQ4GN8LSinclR1+C/qdR3H7D3YX54v59i6kruOYytaFXaV2ZfhY5IvqUBLYQM4Eunjt/pu69U1iG8+DTicWFXzed6fY47sH4aFuP5BWuxwv1yG0L6rIT3ruJ+3+K9mRKoD+hZDH+9Pk9lK4M0qvDGPwiyA70b6jGfFv7Tg9PZ+xNBtL3K6j6fURbov5AO1mJVMTaksSUatQ+tHYrq0D97LzIcuCx9DahojWVg9RDgsyvVScH8JekoiUEDtQ6UFP8v4KAy3XOXh4mtij0GN8lHPqFZFiKSbTWYh+qY1IIx5Y6jAJbawJreGxfDRsdEDMH/fjffV0kZMkw25vyy7AI+dH4TEIR1anS+oTd5NbyTsHNsKSJ1o4N/BSJXkQJnik9DLDHKEzxDQFvx6oACnrI6D7m+PkufoXGl2B3XvzXBE+ayjPJYXXo5lseC/X383F1UhAJSh4OaKAY1bnV3rB6API7pYz1evueT/VxK83RjUS4+jk30xLqIiB+Iz2Py2IA4KWO4bpSaPeysTeJevpA+k94Bzwiysb8vmDicLoakB3G4574unnGCDX5QXsQcsautryEUIeGunyPAaPJJA1RVzGQ0PodZ2pYgNP2PPen3hC//s+JqRnhq9PAkl5LTe5Dr5BXwJZ5qaIj4UlKwkSz2zqw/DZyTipzVQehH29M12DTwl949rnhfey0pGV2W05FX1g3T5V3wZhkCxKlIjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(1800799009)(186009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(6666004)(36756003)(86362001)(40460700003)(356005)(82740400003)(40480700001)(36860700001)(81166007)(336012)(2616005)(1076003)(426003)(2906002)(26005)(478600001)(5660300002)(8936002)(4326008)(8676002)(47076005)(41300700001)(16526019)(54906003)(6916009)(70206006)(316002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:01:28.7258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4180766-5e99-448d-d583-08dbb4c6826e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4274
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

Add DCN35 case for dc_clk_mgr_create.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index c0a2d21200ed..3e73c4e59d40 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -355,6 +355,19 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 	}
 	break;
 
+	case AMDGPU_FAMILY_GC_11_5_0: {
+		struct clk_mgr_dcn35 *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
+
+		if (clk_mgr == NULL) {
+			BREAK_TO_DEBUGGER();
+			return NULL;
+		}
+
+		dcn35_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
+		return &clk_mgr->base.base;
+	}
+	break;
+
 #endif /* CONFIG_DRM_AMD_DC_FP - Family RV */
 	default:
 		ASSERT(0); /* Unknown Asic */
-- 
2.40.1

