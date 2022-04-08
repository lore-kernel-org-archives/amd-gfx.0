Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC66C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 17:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C411D10F0FB;
	Fri,  8 Apr 2022 17:27:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9045010F0FB
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 17:27:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNOYDy1KP+UWc48r0i9v7BDkdUloW6tpsbgHMYNRymqf/s5gUNu4MdTuP83smKQY8SzzTjLbCXVBx4K9QdM1tkOmgW6lefd0FtWrppGuTshdro5jg536r4X2LGvgBIuHnjGH9y4ngie41Iqu1Abi51qOXktsvVwRGtwgqaf0J56wOVVyBlPRP03nlGB28oYp9WjPrCdsNUDY6oXLxlTAFvp/cRPI1AYwkjT36SNj7ZdM5HBip8SzLGxmjCztGXETvL+To9kjxHEi5BG8BvjX5EdS5bg0CuMl6DDCCWMi8muded8hdbr8EjEWjpfN7SgVFHV04sFxxGTRPCoWiphNCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLMqutnSJeLEGyBywPxg1BVAnV7NSTvRkksVFPgkpBg=;
 b=TqYt1B/fGhyIVzAuymAgdEMJNTgS0yowsajMU4qsCZ4LhhVPcjAEoKHv4vzsZKohpAXK7Sr3ryxmEnjJvd2NVxkfu0b1yxLheEqHqZunYcp45YZAs4xhLL+OPA0c47Ne0P49NQInwPlB2IFQSsh64yChLnwsTdDXwTkqRCNqXQWK7urNdYKgh+zh/DtzPs9ui53LRavqXDSpBKVlClD5kH4t6VAhOxssI8NtEJNgklyZUJBouvqP2Z+5ItOqZE5n5+2xEy4UvT1t/3xDNmJjNcsRp4iqR0bxlNeFKTVJ/zVpDD2boQJG99/WGrJydoVT6o1pphIB0+9QbWgtS62V5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLMqutnSJeLEGyBywPxg1BVAnV7NSTvRkksVFPgkpBg=;
 b=EhDVUBH0KXtRxKskkoxz91oQWvXHsR0W7VA//gOiF7u7KudwBQnT9lrfwlmyr+IgcupEzA7YCVsjrrZTuk5hH2V+M9w5K/itIrA13ysnevpM1FR2wb58NvqefrGBQ4fqIwv9wDUTYfEK3B+sJmpWZdjvGZCiNnVLGPtxcTJnXwI=
Received: from DS7PR05CA0013.namprd05.prod.outlook.com (2603:10b6:5:3b9::18)
 by DM6PR12MB3369.namprd12.prod.outlook.com (2603:10b6:5:117::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 17:27:37 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::ca) by DS7PR05CA0013.outlook.office365.com
 (2603:10b6:5:3b9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.12 via Frontend
 Transport; Fri, 8 Apr 2022 17:27:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 17:27:37 +0000
Received: from lnxpromo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 12:27:36 -0500
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/20] drm/amd/display: ensure PSR force_static flag can
 always be set
Date: Fri, 8 Apr 2022 13:18:58 -0400
Message-ID: <20220408171911.601615-8-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
References: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6cab7f4-b000-4616-8f20-08da198513a9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3369:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3369009CE1C4E21BE4BEFE5AFCE99@DM6PR12MB3369.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gr18BnbSc278hnlQy924+JC9J+Rg+rJMhBZQymIdoSLrfMVDNW+8eG3GicmpMB19AwdS7zdfUxQqnw+81SDRSke2Dt7bZS6o2k5T0GR+vFcpDc5b4u8yv+/Gmnm9/kDtS8SXIldEMfCFJcKibuglZaMJ/JXf86AduboS4i0sZ6CX6cyZfcsAckYBH82LkLZh0O6NPj44tzK7puwOLDSI7miQEqg2mF+RV6FrQ89CJZdoXlWLua8ocqLAkGm48akhpOOql9dspIep5UQarM6kVs9mAXZ0kXlEu49TM2eeYgEIkAjG55kgUvWrQqTdaQPu3A85mr0OjIZ6TCuu3H9xddKrIgd1ctto4Ca384Fqt+35nsXtUyMv1jy0X490vDE0AadOmPP1KHEoCNxwriKMHyCj+O/wdYNsYUK8UpNMWoIj/T6Z/J9jfe13Nyb+yLBCS2ZCY5RCNvrevS9iio0gwvBbtc6ib0JduVPRm+blgR+ur4fJqr5nTVXJVDmlB2I+xTJMvc+UAgS2nI5oFxfAJT5bEJlP8ALTVU/wZIDnfpHbKuNoiUeoMRInTnNksIkbn3/8Laj12u4nPEKbccr1VOEwvqNAxWfy8LUH0pdbxIVyYYLnzlhu2Mtw21FFRwLjl2AlQi6upUVlCMubvkwOZXUaL2jykn9xZ1b1DY01h81nuiSYAu0Dh2DFgT1nC7eIfjaY8/YG9tepB1aS6+vESw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(83380400001)(5660300002)(86362001)(47076005)(6916009)(8936002)(36860700001)(82310400005)(54906003)(426003)(336012)(1076003)(186003)(26005)(36756003)(16526019)(2906002)(508600001)(70206006)(70586007)(8676002)(316002)(4326008)(6666004)(40460700003)(2616005)(356005)(7696005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:27:37.6477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6cab7f4-b000-4616-8f20-08da198513a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3369
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
Cc: stylon.wang@amd.com, Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Nicholas Choi <Nicholas.Choi@amd.com>,
 harry.vanzylldejong@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>

[HOW&WHY]
Make sure psr_force_static() can always be called regardless of
psr_allow_active value.

Reviewed-by: Harry Vanzylldejong <USER DID NOT SET AN EMAIL>
Reviewed-by: Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>
Reviewed-by: Nicholas Choi <Nicholas.Choi@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index c1a727ff8b1d..b625b46ae96c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3092,6 +3092,10 @@ bool dc_link_set_psr_allow_active(struct dc_link *link, const bool *allow_active
 			psr->funcs->psr_set_power_opt(psr, link->psr_settings.psr_power_opt, panel_inst);
 	}
 
+	if (psr != NULL && link->psr_settings.psr_feature_enabled &&
+			force_static && psr->funcs->psr_force_static)
+		psr->funcs->psr_force_static(psr, panel_inst);
+
 	/* Enable or Disable PSR */
 	if (allow_active && link->psr_settings.psr_allow_active != *allow_active) {
 		link->psr_settings.psr_allow_active = *allow_active;
@@ -3102,8 +3106,6 @@ bool dc_link_set_psr_allow_active(struct dc_link *link, const bool *allow_active
 #endif
 
 		if (psr != NULL && link->psr_settings.psr_feature_enabled) {
-			if (force_static && psr->funcs->psr_force_static)
-				psr->funcs->psr_force_static(psr, panel_inst);
 			psr->funcs->psr_enable(psr, link->psr_settings.psr_allow_active, wait, panel_inst);
 		} else if ((dmcu != NULL && dmcu->funcs->is_dmcu_initialized(dmcu)) &&
 			link->psr_settings.psr_feature_enabled)
-- 
2.32.0

