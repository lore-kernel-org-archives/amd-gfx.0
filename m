Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29F1C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 21:49:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 656E110E208;
	Fri, 18 Mar 2022 21:49:13 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2048.outbound.protection.outlook.com [40.107.101.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0D5D10E208
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 21:49:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mG/KLaK37OePCcfOjos6oTgIqaGc8mStoIAkOzvkaAWKjqzWT7eu54wWsx7kcIx4BdyFdbJ4XZp/ynxBkwjACxYiNcwwLzQR4DQ7P3Y+881pyAcVDhlPtkZOLWtzKK4H+/4eKK5SCxj0eK4QtbiNNaigI5ozcccn6al4pjXycwdg88ZCmgh7XOw7grg955wCM9eIqEyQG5p8oeTbN0fVqDJvkfmoXWHsMxn89IMmW84idtAV7NO7BxR7JXfMpx70KvcgKS//sEuVSHoU2QURcJsKAZEKOViCynCy9UgdKa8D7uKoBRqzkhQiAsZU0KoctOWkRnsP2oYn8sUZWcwmjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2LhvyTrq0owFOk79K+h4h9EVtCdzsyI8BytNshdBxc=;
 b=BG93Ayj7P6yoP/sFhya++CQIoefCS2xuk3tqKvPpnDQ4ho9+AhXqUS2v7tqSBjSVI+4KXnCHF6MAZ1MM7VTGprNofgReQn1TLBbu9Hq47wcbMdL1fCufvSOeRNOAfMi3Ff+d9xpWu8UkRUGiVyR6bW5keUNERqR875r1Mapu2eJkypCogD4sONEg95r093k83f+FPWsPam+F238Dx6xQsoXnmULy904Qz65AG3boSzu1fNa+e9QJKApspPgdYuSLxv86+weeiP7quD0amf4nAINIAyGDvEIA+g9okcha2DMHh97u3hjG4qVybH7ItAr5DGo6oY0Sl9Sb2QOXaVJ7Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2LhvyTrq0owFOk79K+h4h9EVtCdzsyI8BytNshdBxc=;
 b=bEhyYZAi24w8T6Dn/r58EAj8C18KSA8rLI6XWvxIZJWqriPoX5XV1mKaFmPmmyKmwA8jxepfKkH1weAPzbJ6WyKRlY5jzN0efvvhHL491Z3okal8z0bIsPWHjbp9+jhWTKy5maVMobu0mkMwxIzlHrR4FpmKGCZ3nw0egBt45Ms=
Received: from BN0PR04CA0171.namprd04.prod.outlook.com (2603:10b6:408:eb::26)
 by MN2PR12MB3040.namprd12.prod.outlook.com (2603:10b6:208:ce::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 21:49:09 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::3e) by BN0PR04CA0171.outlook.office365.com
 (2603:10b6:408:eb::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18 via Frontend
 Transport; Fri, 18 Mar 2022 21:49:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Fri, 18 Mar 2022 21:49:08 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 18 Mar
 2022 16:49:06 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/13] drm/amd/display: FEC check in timing validation
Date: Fri, 18 Mar 2022 15:47:51 -0600
Message-ID: <20220318214800.3565679-5-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220318214800.3565679-1-alex.hung@amd.com>
References: <20220318214800.3565679-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f7c4bef-b5e6-4ec1-600b-08da0929217f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3040:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB304062310FCCFEDE7CA020BCF7139@MN2PR12MB3040.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rn30VUh6gdQVoF/VjH5D5oLx/PXcS8v9KFo0+vbc1EWmQ0G9mcTvnX7Ob5XpxJQe75CXnkcSfCuTC5YM6TnMe9cDL/7MGd0nzx64vm0hEbdPVBuGEen7CRSKvp/AtzS7n7xeBz3dy+MsBU8ANqigwyQd88dXE/1GlB12iuHinhJxpogluZtzOgr/4pOrtqIBu1V//ip5m0odzTJDvFKzDGn7Ja/QSzkaaqcBXVgOl0YkIxR21OJRjquFczj+pOJKjUMV25vLVOdqLZYCiu7JadkXModI/hm2aE4AYfGVYDLB7ShbIVGSkz/k1beABFie8NN9hlGqCuUeIasOlE2gUsqV4PqXXkb6CGm8Y1gsR4Z5rsCx2AVnhcUt8LU4ccrF08UfEFaNTcwjuNRkIWctrZqcs+l00QwarNaO3tlLgRMgaRNJwJj6GhP90JbpWyGmXctwjN2JHOAI8tBy+3fW0N0cwA+DzVSP1URf5aTlL8MPhcg0Vb/XbEqUsiEb53NsZU+2IFVC2HkCnHq5KYV6F3AWVs7o1VESwgCPW1sRgAesuVpwpsmbTlO7vP1BxuSRvufbSuNL8REw9usywKbS6/HMlSGXtsQOF2B0lE62BlqExf5pYP0abaKxTAJ8OVFXFcoJf2fb2fBDo5cUm+cyhTId+LaGvPG8ST+rp5a/fl0BevKjDSLu6um9x1BbdTxVb5t8152OyFX1Vy+xrE5stw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(81166007)(36756003)(40460700003)(16526019)(426003)(336012)(86362001)(186003)(26005)(47076005)(83380400001)(1076003)(2616005)(36860700001)(508600001)(8676002)(8936002)(5660300002)(70586007)(4326008)(70206006)(4744005)(7696005)(2906002)(316002)(44832011)(356005)(82310400004)(54906003)(6916009)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 21:49:08.6026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7c4bef-b5e6-4ec1-600b-08da0929217f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3040
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Chiawen Huang <chiawen.huang@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chiawen Huang <chiawen.huang@amd.com>

[Why]
disable/enable leads fec mismatch between hw/sw fec state.

[How]
check fec status to fastboot on/off.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chiawen Huang <chiawen.huang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f6e19efea756..75f9c97bebb0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1496,6 +1496,10 @@ bool dc_validate_boot_timing(const struct dc *dc,
 	if (!link->link_enc->funcs->is_dig_enabled(link->link_enc))
 		return false;
 
+	/* Check for FEC status*/
+	if (link->link_enc->funcs->fec_is_active(link->link_enc))
+		return false;
+
 	enc_inst = link->link_enc->funcs->get_dig_frontend(link->link_enc);
 
 	if (enc_inst == ENGINE_ID_UNKNOWN)
-- 
2.35.1

