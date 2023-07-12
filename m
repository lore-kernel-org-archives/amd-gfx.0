Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798FCEB64DD
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1012510E5AA;
	Wed, 12 Jul 2023 17:13:22 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E6EF10E5A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:13:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFQHKC5lxNpsxLFRUGUe4FdTpml5qkNA/0lt2o+6cIMBVwTXkgBq15OUaUWM75vJCEbb0eObSLrLhyYm6HfCFQINwEVOr1TrckYygnmUavfPHhkS7fNltmPYbNhfgHUrc1cqHfjHvG6/ykyR1QiKGX1s2Wzn4kc9DwDCNaJGzxpduaAW4b5mcj79te41xKRh8Ebgu01zbTAA7ZonyztG/paC53XoanGI5TPb+ELjtmqki6jWRqHptJzWIPEYP7Zy5IrOhp5uggaFjCbqvbRziQBlkyiS908RrjM+jHbxS94V+zHwC8TiPqsfZPR0wJ3Turv5vsDQ2AIpMm1EbrCz5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KjiosPDLkWU2lf/EIV4fRDSCn4hiSkw7skNhJXcgcw=;
 b=nv2qlkAdApREaO7I9QlODrLfXLoK6rcoE0loBRvttn3PG7K/dyA6j2HqmKt0lfaA/Kd5j3k47JKuwiEa+yJJX6LnveZDbYHNnXJQZEdkY2O7kISePqbkly1faNEYJyB9Dsg3QzL8vXMQ7+A06c6PJuC+XfTxAXe5ROZDUTxiRuikn9dWIXwoDdDB6nzBqdYvmuO7pSMWD2AZl30nnmYjtkbJonrmixJCzr0CADLJKPIxpnSeMRuvhp5EoNp93F6kpp+1NclFW7LuKGlMCGg+2zINpMSOAjQJft5Z3ifbh/FO0rKnqE4P+YOKIJqAo2wv7C2auasjwOqYbW0OrQC8DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KjiosPDLkWU2lf/EIV4fRDSCn4hiSkw7skNhJXcgcw=;
 b=NTScOVb6cw5vOESnqVX2hxOx3bunc9fdiiSEne2rWBvo0xzZuW7K9Dy0bpzuMB1ME0P1jzSARHqF4gUXgyzCM652QgYqquIw22Ba2aiM26T23FODXXHZuf66VYmKVo9CxbrgneTZLZfICq1tCiXvsiDywdBWcLtB6EKlivEHvH8=
Received: from BN0PR08CA0004.namprd08.prod.outlook.com (2603:10b6:408:142::22)
 by CY8PR12MB8268.namprd12.prod.outlook.com (2603:10b6:930:6c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 12 Jul
 2023 17:13:15 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::50) by BN0PR08CA0004.outlook.office365.com
 (2603:10b6:408:142::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 17:13:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:13:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:13:08 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:13:05 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/33] drm/amd/display: Skip enabling DMCUB when using
 emulation
Date: Thu, 13 Jul 2023 01:11:14 +0800
Message-ID: <20230712171137.3398344-11-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT028:EE_|CY8PR12MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: 00671fa2-ff1f-45cf-1f17-08db82fb47b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UQOKzBMY3Qk3ptGtBMawAVpeXuDOxq7c3Rt7b4BpuHKfAcsBPA3DufBf8lzgpqzrXxV+Xl+ZJrQXCrU/1LB61StLGIrNmF/oqSbxVGxD09+nDJn7PCB7DnrbhcXsEzTta4S15umm9vxOdCVcatEuDrwnKeFBto8JQLlL69UlgOJeL5j4qqc1T6Se/hpQVxhlV7Cxb8d0zIB5JbjIsBQll57TXx2AIvinCbSdIRoo/VluZiXPrP7k7Ew2QSqgkgLXYcUl5+VxLZd/Tk0ndFOZW7yFFm/J3HLiND8zfX90v4Ew1VLpoK4Oca52PeMLlJGj9qFNxvDjqSAcAkScuP1koLgMoZ04P9PyXq3Mko81ou89E24EhXx/IZ8aSobHcFOVKRF6x8QFN0Y6U7sxyRBFe5eDwGu9WRhehNEKNUhrH1lQTrP96krUFZAlMHJkCS2hXEd6xiE9Ocv/B0YcAGHGiZ863rZLPXbeaJVs793P+wpo9zQfpgIr6avXs/t5nnrJKOscLpot6SMg0WCMF8r4syDIk/Lj88Xo61H85TqET/9f4F0oqi89Lc1/4WfV7lyvnVsPOj3oXwmyv7ISI0FTpa7U86ji3TlBsyrzNB/l/L6onwFIYn95tYC2PI6+R/IjQNrPKJX/kuaTwI8vWwunie3VhFeCbt5skTKaNDW+bV1xX1+wUUB8RzeWEkcyJPRB8I6pLGbD/rtu8/8FfzHZEAfXNJtZLgUIvPy6WGgh6qMOUsCsyygkEpNLXZFs5F4Jbju0MUnMHLfby7tu9QGWtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(36840700001)(46966006)(40470700004)(82740400003)(1076003)(356005)(81166007)(426003)(336012)(26005)(83380400001)(2616005)(47076005)(186003)(40480700001)(36860700001)(8936002)(2906002)(8676002)(40460700003)(5660300002)(70586007)(36756003)(6666004)(478600001)(7696005)(6916009)(4326008)(70206006)(86362001)(54906003)(316002)(41300700001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:13:15.3977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00671fa2-ff1f-45cf-1f17-08db82fb47b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8268
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
Cc: stylon.wang@amd.com, Alan Liu <haoping.liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Taimur Hassan <syed.hassan@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <syed.hassan@amd.com>

[Why & How]
Shouldn't be touching path for HW DMCUB when emulating.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Taimur Hassan <syed.hassan@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index bdaf43892f47..3253162e3701 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -639,11 +639,11 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 	if (dmub->hw_funcs.enable_dmub_boot_options)
 		dmub->hw_funcs.enable_dmub_boot_options(dmub, params);
 
-	if (dmub->hw_funcs.skip_dmub_panel_power_sequence)
+	if (dmub->hw_funcs.skip_dmub_panel_power_sequence && !dmub->is_virtual)
 		dmub->hw_funcs.skip_dmub_panel_power_sequence(dmub,
 			params->skip_panel_power_sequence);
 
-	if (dmub->hw_funcs.reset_release)
+	if (dmub->hw_funcs.reset_release && !dmub->is_virtual)
 		dmub->hw_funcs.reset_release(dmub);
 
 	dmub->hw_init = true;
-- 
2.34.1

