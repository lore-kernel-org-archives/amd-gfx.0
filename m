Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8543C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EFC061507
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7EFC061507
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 241DC6ED7E;
	Fri,  1 Oct 2021 14:41:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BDF26ED7E
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 14:41:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEOiWE7TsmbQV1rkf7Z1yJn73vp1UbzF3tY3kf00cZRPe9gzmWiTrIwnjXuIbT9MRUjf/WSfmt/P0ZD4cqsIha8x43nHHVnfJTY9aRPZwJI9XBjOsM6S9YX3ti98yih4EBgKpIzbP9KPZpXe0JRcgV0z2jFECnNCrhQwJBjjd9MY4Umd6d8zTImQg5IZcQb8Eys9jxv7CjeikydIeQhLM/OGsRYMDIKQq4XuU87vKa1a2+1QyR1pLl1qNPZyB/3/zOpcfG6jvCMoyKi/TihkbvinaxEEqKvBCeraOmRRkgvfSEskUBAsovuRb9KM2wk76Qu4idwDGHT+K8Q/yAI+Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPRTphed+jhVICLihAaVAMu2qCOlLmOR/PLsxWef70c=;
 b=bQfEeCWAkUsI3/nZM0zHHfCefM5iKtRsPzPc7jb7ZkvsrVJUpgITAHJaoyAOti11miVl5VYZX/93OXr1D5soAuSj6UyQD/YqYJt7TjgwNhfVGmt0EB6aeRE5iyzYdKWYBUAUT1NaaGzhEvUxKMd/Acg0hsYlonSpK2RTTrr2m8NVKjHCAQHMMy3FZjn8KcTLwHgZr0STcoV4kQFoOQ/e2MooHr2e/Rv/RPrg5kpiQwNi460vHWW7nPa6lYSK/KAxI5SizNxZZPAb/gBRJcdSHvDyg1Et0MZ/RdrXMlm8G9IZLoWJwhEvOvQUfeRWqNaWstZkiATLoWNPltrsli3z8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPRTphed+jhVICLihAaVAMu2qCOlLmOR/PLsxWef70c=;
 b=v8q5Fr/GOS9cXWpE1XCbTki3P5Nk9/PRFsPpfWfs9cz+fvNeagoEjM7w+kDJKm2Z1s/7v3TW81Et3VdhO3r37Xvz1jLM6SqP3eQUTxR68AmUMsmXuJ2uo7N7MbXfPyHqWUrWtgFsCt4yW0PJ2heqDWtLWj0+ZI6mqJl+1a0aq9U=
Received: from MWHPR04CA0064.namprd04.prod.outlook.com (2603:10b6:300:6c::26)
 by BL1PR12MB5127.namprd12.prod.outlook.com (2603:10b6:208:31b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Fri, 1 Oct
 2021 14:41:20 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::6f) by MWHPR04CA0064.outlook.office365.com
 (2603:10b6:300:6c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Fri, 1 Oct 2021 14:41:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 14:41:19 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 1 Oct 2021
 09:41:15 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Aric Cyr <aric.cyr@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>
Subject: [PATCH 05/14] drm/amd/display: Fix 3DLUT skipped programming
Date: Fri, 1 Oct 2021 22:36:11 +0800
Message-ID: <20211001143620.192679-6-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211001143620.192679-1-solomon.chiu@amd.com>
References: <20211001143620.192679-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0203cf0-b0a2-4094-6837-08d984e98857
X-MS-TrafficTypeDiagnostic: BL1PR12MB5127:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5127DDF7A4E18FD746B0CD2497AB9@BL1PR12MB5127.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:207;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: al3oFDAB2o9R1ICpwMYpr3tT8LgZpEj2hA8aVLa4mG9XVY8mCrLFTt3gTyman9T5yUy5b4WCAxFdC1UP2ftLWkfH4mGTYwaRQKwUoThKuiKzRArtmr6nUc3jbgsHmaKplL52AyT/ORBV5eKzvkcvOtfs9lzxPTrLM80qPyzV+vcKw3QoWKKdtjaaWSnM18uIPLuPW9x000FmCNa/PBr49Lv/XyiU/o5Zw47jIgIwnt1V8vPMmesVGWLdrgvo+sBnC6ul2eTsxNlYoa61p3CjZ+OHPSIUOQPgSf3cjWOvJbHUwViCILXZ3Ne1grKYAgJj+1uTmrv3K6z7Xr8q7aST6kJWyTYRkafp4fYDxQvNZBMZuGUdkzr27qnlbXBtI5HPyEwiVDrN9pIs7A5qHNIhcKmsbN43dVVB1hLHWG2uIFziQf1FUBtn94ie1afjnA2rf0DOmIPVV4Dp+dUnpm07c46u5nOx3q1TGJarNuhDIIAjk2wkcqUEBqYEmI16iDmdMAbiJh/Hg2YaHY6BieCl+PmBPP0SF+FveEqlIdzqW9DrpjamHSIdv609hUh4L1Qzhj9H0Wg6XrjceFLjbWTy6ulUncd+NSLVM44KWbP1yvTgioTuwSsIdv6OXyhhuK/exj6j4HpMtnM0m2pneic+qVDC8q26e0wuPxDB7dse3KaLUpVrc0VywFXSsTajZz3t+c+K+ggIqU+JXHUC/HOrMXrXgsHJdJ+L5pQU9ZkLqvo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(186003)(16526019)(82310400003)(426003)(36756003)(86362001)(54906003)(8936002)(356005)(7696005)(81166007)(1076003)(26005)(6916009)(5660300002)(336012)(6666004)(508600001)(83380400001)(2616005)(4326008)(70206006)(44832011)(8676002)(70586007)(47076005)(2906002)(36860700001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 14:41:19.7794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0203cf0-b0a2-4094-6837-08d984e98857
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5127
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

From: Aric Cyr <aric.cyr@amd.com>

[Why]
3DLUT not updated due to missing condition

[How]
Check if 3DLUT update is needed


Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 0f0440408a16..8e0bcd4fd000 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2187,6 +2187,9 @@ static enum surface_update_type det_surface_update(const struct dc *dc,
 			update_flags->bits.gamma_change = 1;
 	}
 
+	if (u->lut3d_func || u->func_shaper)
+		update_flags->bits.lut_3d = 1;
+
 	if (u->hdr_mult.value)
 		if (u->hdr_mult.value != u->surface->hdr_mult.value) {
 			update_flags->bits.hdr_mult = 1;
@@ -2200,6 +2203,7 @@ static enum surface_update_type det_surface_update(const struct dc *dc,
 
 	if (update_flags->bits.input_csc_change
 			|| update_flags->bits.coeff_reduction_change
+			|| update_flags->bits.lut_3d
 			|| update_flags->bits.gamma_change
 			|| update_flags->bits.gamut_remap_change) {
 		type = UPDATE_TYPE_FULL;
-- 
2.25.1

