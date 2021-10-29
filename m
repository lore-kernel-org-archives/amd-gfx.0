Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F35AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE73261175
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DE73261175
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C5266E157;
	Fri, 29 Oct 2021 15:15:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDD156E150
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 15:15:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctZQADheTh0dmkSGd5II5zCjq7dsQ1NdAIkDodoB+oAJsMH7jZWoVIWI3t++KhkLvGt91LnkRMcHXfZGCfyhVdmOrMWEAkBWc8FYzvLOmhsv112r1Y/waClya/vXIu+b9lKku5+PuCL1Sz+9LaJUU1By82qibg8Onw3ZRw3PH00DEm7A+Sjd8w5vVMmCrbaNwOWCfISIk4g0VS7SDkktBaio+6884w5ArCfYSNJYR3RwVBDLlLvIrbrARc9lnLxbpC2u83XKPxImdqDiOib4VsmBu7CUhpRV1SH7Irsrwp8+UBiL/uDPh5ZxhvDCDUHPYCEN+ssep8JIkl6RTzxAWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/11rfL58MtZSn2BjBnCIr3C6J1SEGkBWIOHDCfqPJs=;
 b=BvL0FaCMfN8OfBtdyHy9i1UWX+QPZPYIgUn/aMgUEWgKS+XBrpexTi7XecUXbiT/mnpIbucl5tlDSq+PGRQkV7pcNkJCJ6lCcyrFjpw2cgyTA85fIEVXY+IlTJqIcK0AdVQ4nNPI7p9iDWCFtGIDHcK0aLl3aPBS+fORhRbwjL4Jf8PQwKFMNrBHr/By6j9gC4U7ckOeAuLxVcE79Jtp4ui9bF+qpZkfmxUEhfkjMt1LE5SquacO50Byg4jUbf74tXnAz46K0Kw3XAonv0A1+J/42cLQb8DrIM2zrij/cHJhh3qFUb2yuSYeFL2YDH+N//RTtLqbphGKTzcoFUjtoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/11rfL58MtZSn2BjBnCIr3C6J1SEGkBWIOHDCfqPJs=;
 b=jhRuS5i2cmEFfvFEQ0Ehl2uJ0DGJN1iZESqf1oS2idFgWgxzw7NBKL3nrXg52/45Xj867PQGP+/GuwzdJPgakwoBDCojDVrP2GXmUK7J0gZFTSqVhg/p/7Zu2Tz1rCdUGRiVjGeayhB/6+5JSmUF+v8LJkhIbx5EQ4Z0SsAzZzA=
Received: from BN9PR03CA0926.namprd03.prod.outlook.com (2603:10b6:408:107::31)
 by BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 15:15:24 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::4) by BN9PR03CA0926.outlook.office365.com
 (2603:10b6:408:107::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Fri, 29 Oct 2021 15:15:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 15:15:22 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 10:15:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 08:15:21 -0700
Received: from elite-desk-aura.lan (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Fri, 29 Oct 2021 10:15:20 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Jake Wang <haonan.wang2@amd.com>, "Nicholas
 Kazlauskas" <Nicholas.Kazlauskas@amd.com>
Subject: [PATCH 11/14] drm/amd/display: Added new DMUB boot option for power
 optimization
Date: Fri, 29 Oct 2021 11:14:53 -0400
Message-ID: <20211029151456.955294-12-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211029151456.955294-1-aurabindo.pillai@amd.com>
References: <20211029151456.955294-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28411813-4b36-4adf-d40b-08d99aeeed36
X-MS-TrafficTypeDiagnostic: BY5PR12MB4209:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4209D3942E9A2AFB57482CBF8B879@BY5PR12MB4209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UqZJyqXvTPrZCny6EKxr+ubMNI60BnQXFas2VRbJRDFdbi3Q9L5KkJgVPZ9bfOuMaRyiZEnJPlHMKHaT7m++75nhQY8SN1OyjXDPtVRSiR4jI0Kwmkz5vFO00N6xQvMvUGH5RDLTGamwIblGTELEyoCDf6Nd/mopCMnChpOazZ3OecoRidQ2Tmorjz8S9PNr538TqNw9rC0Zd0ycTkc/3fSilSNLVSGJH3qBFcjscD6oYmRRRzuWNgyxDmmkS0akxc4BaR6MbXENGKo7D41/ZA4Ul+Vqw28oc94xeMGwzbWdCPM9UE1mlHntTy4qzQ8QlmV2hn7OLsSQeVaxywRRTa8eY7T0EcsCk6KBeHeNDpfzwtxUs+7NZbUylAciwrEDX/6LfMeiUDxHTc37iEm0X2vBaT+xxgcy3KtKREJERq+hFR/eY7hHNwzpkDVi+8DYWWy8hBjxBFOZa64KS6l5sr0p0fFq5YbYBHbyxcU2tDxDMIS41LNe6yKUanz7Jk/PDvSuA1KQfWFa8DEOu5/jl5BaeWdb7PvqTlgt9JJ6ofAYII4Mm+KmC1wj7ceC0ne12a4fScKI8ExBaslf0f72b68UAFApzGf2rsSXXYFbXfVXA179eoJOaV4xypbFB4ZPwj2V1+j84x1UMpy4ZMjdRxsT2Nc0VwbOH8zmHSnh4Wqu8XSIYw7Z6/E1PYAMiwrb4r3Ll7yOiAQ6ffQAKjF2xiypcPaCxIgxE+d1iotvvKqRyeL5GaBp8idPTesl1oDOrcPDivlmJgFo9JezQGmIIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(54906003)(26005)(426003)(8676002)(2906002)(2616005)(36756003)(70206006)(336012)(83380400001)(86362001)(47076005)(70586007)(44832011)(4326008)(5660300002)(186003)(356005)(8936002)(82310400003)(6916009)(508600001)(1076003)(6666004)(316002)(81166007)(36860700001)(117716001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 15:15:22.1893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28411813-4b36-4adf-d40b-08d99aeeed36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4209
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

From: Jake Wang <haonan.wang2@amd.com>

[Why]
During Z10, root clock gating and memory low power registers needs to
to be restored if optimization is enabled in driver.

[How]
Added new DMUB boot option for root clock gating and memory low power.

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Jake Wang <haonan.wang2@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h       | 1 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 717c0e572d2f..cd204eef073b 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -238,6 +238,7 @@ struct dmub_srv_hw_params {
 	bool load_inst_const;
 	bool skip_panel_power_sequence;
 	bool disable_z10;
+	bool power_optimization;
 	bool dpia_supported;
 	bool disable_dpia;
 };
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 10ebf20eaa41..fa0569174aec 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -340,6 +340,7 @@ void dmub_dcn31_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmu
 	boot_options.bits.z10_disable = params->disable_z10;
 	boot_options.bits.dpia_supported = params->dpia_supported;
 	boot_options.bits.enable_dpia = params->disable_dpia ? 0 : 1;
+	boot_options.bits.power_optimization = params->power_optimization;
 
 	boot_options.bits.sel_mux_phy_c_d_phy_f_g = (dmub->asic == DMUB_ASIC_DCN31B) ? 1 : 0;
 
-- 
2.30.2

