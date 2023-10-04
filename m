Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADD1E8FDC2
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 00:56:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3210110E008;
	Wed,  4 Oct 2023 00:56:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2FCC10E008
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 00:56:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyyDvNWcr0NHrtR+N10fVba5PKyQbAabpg+IYugL1Xd//fUn0t0vXeefJDv2O50hDfVH70OxXL4E4wKRENZ9T3zaQXYHR0G+68gJPhH0/C8jZ/2lpyoaXKqK5zs75Kosf9Zc97Ea/34kYCShfJj/e45B9M2PbRBPZixZyupkpROBMx7RyoT7/82Sjz+ixtL4oSdLQ7ExSEGU3CV5tXwwRTmd4UwL3uegvbaJzvQSoJH4irwFj5mewQHa5A+3IkR8nqyKsTUXgNIvt7EsUjUo+LzsSw3QNcrGDWiIeWHnLxtsrIxoWheZPk/+sxtY4ns/tpKXmFN8ZqVUDElANzirfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmosV5IhY5YUmO5zOUFYZ/h2B0xQXadePjQFOK/CXsU=;
 b=dLydF/AnHE+MDLYvsBktkPWtTOUCjjVgGrhIde2ebNpehVpbW9puveSd2wtzEF2u65RLFUYb13mRaaprJpMbPWDwY1GqOzfF8e5vpT9N86lq0sN8x38N1rMeHBWNKBeMmWbX8GbpPY4aJmD/QWdfGSdDIo4VCw8Ly/9p10Goktm/4wwUHXAxj4fV04N1ghQv7Wx5RKQhx1BkaN7WddHm92H++xoMoYjHq7LTB461US9QrtFdrpww93hE7fVPSA2gkd4xsul1UVQjvWY0alrMb3oaC/I5mgckQ6MCahk6cAYfdi05Lwn936oIYViDnkER38lanYTT9qGSkp/gX35wiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmosV5IhY5YUmO5zOUFYZ/h2B0xQXadePjQFOK/CXsU=;
 b=v31l7MCDv5iMpA+dLsHAY67ZwFMlW4SmD+/B7GalzI11y8DLtoNgB3X9XGG4TsMYQtIxH6zVb8IabMVvsfgi0AiLGGbEOUh/a+WoQetemsTQZysBdOG2uf5c+uPx4plac+SY66HAd4UzJ+EH6vl5NcpnBCfWK/0h1pXSeVcUlO4=
Received: from BLAPR03CA0094.namprd03.prod.outlook.com (2603:10b6:208:32a::9)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Wed, 4 Oct
 2023 00:56:37 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::84) by BLAPR03CA0094.outlook.office365.com
 (2603:10b6:208:32a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Wed, 4 Oct 2023 00:56:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 00:56:37 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 19:56:36 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/6] drm/amdgpu: Add flag to enable indirect RLCG access for
 gfx v9.4.3
Date: Tue, 3 Oct 2023 20:56:11 -0400
Message-ID: <20231004005616.108476-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 46eae541-7fb6-4428-b74d-08dbc474c36e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cIGoFmm3W599sRCBSMirLw0V2T2g0a6fokK21RxQuh14uasROGCNwMlJmdGFMDBZmEXxuzK/aPX0fkQb/bUQJsxk+eX7YhItHf2XTRmlcOHi7Lk6SIbuf6SckmNRdDaEQ6k1XipruKVu+DWPPU/1uuZmOTvVxLVD6hYEi1D2TRA7bdkRtk1wLnRot1Ug12VMozW1JNOc/SvTv8WGHW7opi2YYYJeFltkyZE3J8ik7mdfnNqNGR16OkHdMIdKpGaIH2KRo0pLBW/B0RBtzXQoQUXFLviM6HDGjelnbxc1l3H2v5msCE+Q8FPBfHa7d4a39UeUw/ES7h+utjPkQtgblkazv6iYKFJkonidUap5ODUOEx2V33lxdAn1O780HOy8HNEckSgtMxUz/GNm2R0uJ1UlSQLM/qPNUzuBBwrWnvdnOu9K3cwwD1bSkC6uj3La/Invgvo61dEK/t9JsQl8UDnba0E7/TiDq8Vx5NDDRp/ZCgdl+yv5ApsMHwjXhz74627viLbt4QDF7EjRaOfXpea2ukTCjfFrlSuMpc9kckCJNoFF2ftsdPPXfJBtkFXJo/ti64lp/k6rRdf0eOMmlBk92Ij+Txb4FGJTprBDc0V8IVbkr2l3BLaAR81YZRr7BGGmJP2S8KMs1Nkit7YNARhuOQjf4DnVNJg1+i2I+ffs+LCbveYHBNErPDfWBIZR9J1z8ZEAc/GJ6brgk2OUyE5a/CGDxYRq0fn9RejKnNFahk6HKw43OHv/NOvxsan0G6CHMZBStj7pXMiTNNpHBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799009)(40470700004)(36840700001)(46966006)(16526019)(4744005)(2906002)(5660300002)(8936002)(8676002)(26005)(2616005)(41300700001)(1076003)(316002)(40480700001)(54906003)(36756003)(70206006)(6916009)(70586007)(40460700003)(4326008)(7696005)(6666004)(83380400001)(356005)(478600001)(36860700001)(336012)(426003)(81166007)(82740400003)(86362001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 00:56:37.6651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46eae541-7fb6-4428-b74d-08dbc474c36e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185
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
Cc: lijo.lazar@amd.com, davis.ming@amd.com, victorchengchi.lu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The "rlcg_reg_access_supported" flag is missing. Add it back in.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index fbfe0a1c4b19..e7543bc49ee5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1102,6 +1102,7 @@ static void gfx_v9_4_3_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
 		reg_access_ctrl->grbm_idx = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regGRBM_GFX_INDEX);
 		reg_access_ctrl->spare_int = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPARE_INT);
 	}
+	adev->gfx.rlc.rlcg_reg_access_supported = true;
 }
 
 static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
-- 
2.34.1

