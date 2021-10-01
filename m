Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D8AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:37:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 420EB61381
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 420EB61381
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFFDA6ED18;
	Fri,  1 Oct 2021 14:37:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64A266ED18
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 14:37:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRusn4E9FEg6DllzukUsZYkaFBZ9U9SCiTvW1E0dIsMDJDY61I2ag/ULX6Z3GhkOgiyXL9JVoYkmUbsJjDLZy78lsWUj9flSYyA9uXKW4qJ8+NC4jk3GrSv4BRWWA/BeZUbDgviYI9tNk+Plh4mjerfM+hNOtfl2n0lvqyoxzeTrt39/KCXZ5skxyLUeJqMT/knSSYggNcj0i1q97NCdVHsKXZBgbjPFq7Te4ohPH5qJOIVrTUpLTLn3md50WsM74aiszImpNr0R5tX92LmIdGG95V//JtluYkFe+ABQC09U1kAtZcBBHX6RtrGkM5DuS3hTrxbYsBweLJkdCGNZEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dURdMKmZPZv+NveP0BhmWzZbCQfzSVmlWwdVeli/q7o=;
 b=lORdZXJiGFs1Y58HiSpoFrVNEuFqi0HCCSqm9RKBsI7V3GTfsSDKqFUU81GjiQ8J94wpyS5rZw+Sp+qrOWDjK7J8oygzyN1AS36662F97AUHeNVkozpV10vda1Js4pEqNvm2WxCVkUqnWXGvZq+EoAiGBlgYmXu7khVq6Oz26w5LuLfNt8swMrWoR6cPUAnY0CvUnvDgKVNJS2GnIMMoflhY/CmSsU3GrJNaqc2ZPMAMOOBE93AaTyRSxwrHmBORakmzd2JhFpU/mA6yuCagJx9eau68OPFK+ciGkFWoBli8r58nH1xHersL3FCtXsSsmW8vpTaElGanEo0SE4hclA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dURdMKmZPZv+NveP0BhmWzZbCQfzSVmlWwdVeli/q7o=;
 b=ChkBgmFrOeiS3fIQ03j4HHBAdL//c7Thd4feQncvwX5QwvXl3vIT6BS926VeueoIJfOTHD5ZCC2PeAMYT5URgPgxGzlLYstlxqP55vE+l1Te6AEm6qYXrH7Tl693pUh6p/av0Q0b7W1NJLKbvLueTIy43FXNclfgjsvvgJnFv1g=
Received: from BN9PR03CA0240.namprd03.prod.outlook.com (2603:10b6:408:f8::35)
 by CH0PR12MB5345.namprd12.prod.outlook.com (2603:10b6:610:d4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Fri, 1 Oct
 2021 14:37:08 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::71) by BN9PR03CA0240.outlook.office365.com
 (2603:10b6:408:f8::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19 via Frontend
 Transport; Fri, 1 Oct 2021 14:37:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 14:37:08 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 1 Oct 2021
 09:37:04 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Wyatt Wood
 <wyatt.wood@amd.com>, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Subject: [PATCH 01/14] drm/amd/display: Prevent using DMUB rptr that is
 out-of-bounds
Date: Fri, 1 Oct 2021 22:36:07 +0800
Message-ID: <20211001143620.192679-2-solomon.chiu@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 173b0af3-fd60-47c9-33c0-08d984e8f277
X-MS-TrafficTypeDiagnostic: CH0PR12MB5345:
X-Microsoft-Antispam-PRVS: <CH0PR12MB534551DC08534D691D8BC62B97AB9@CH0PR12MB5345.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DqYnQbAI54VZj1WXVXacPyH711WgxMj0v7gnbQJgEsfbavZ98EBv77fToLh09iAFeFaZXoHeKm6Qor9MkR6viVrHeuhm8C+J6yCsQROI/omGWH3BABJeqTEVLe7vaIAjL9/XJdtFgJbZ1Urz4/cjJtTOV7B57Vjv+6yE/q1YoLCLW9VzO2M8QhlIXfGe1ok6LBfGd4aik41OfDWKtvk57y067giA8l68fGkdCRvGEcSxu+rIUltLbGxlTRn58naY+4aBwRKAxnUpsw1c9pLiL5QXdwSchx8vB8D6DuzneverQNFKpk5wEqhIoIMlYtJYpNXSikXS7FtSwhMpF6xtsx4aOBZaRb3OoqvoEwd8FAG6N6QxT0LQk559XELn1ioBBPvvMCcpf33vgwnVO8Lw5CC19qG9uVKU2guami/lLTQ8tr3B5eWogTBAw/uH5wskG72/1cFm4wosoXn04sY/PHKwNQOy3yP/0lEX06F1BJf/YFK0diuubR5nt/vF8fRN9NI/CSCr2gYOO1AWBSTSmg07XTxUCF52o+KmowjRpvJpIuiIOzXBdT7GkM2ipqw1L2+ez6Izn1/6VhlY5cAiS2SRXG6c1hh8LCtB+MHnhlEylrc0VbvDyGtrX17wduk8qx1QXMgT1rLvTEPX1szEOrcbNRoK3cXwfjxwrafd9br5MZ8MKX8RzMNYM8Y3D4hmYT7/MGtouorT9cLNbihwWcn7zzn07smkYQTIX1A7xkA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(16526019)(36860700001)(186003)(8936002)(70586007)(70206006)(8676002)(336012)(426003)(4326008)(6916009)(44832011)(1076003)(36756003)(2906002)(5660300002)(2616005)(47076005)(7696005)(26005)(86362001)(82310400003)(54906003)(508600001)(316002)(356005)(81166007)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 14:37:08.4393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 173b0af3-fd60-47c9-33c0-08d984e8f277
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5345
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

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
Running into bugchecks during stress test where rptr is 0xFFFFFFFF.
Typically this is caused by a hard hang, and can come from HW outside
of DCN.

[How]
To prevent bugchecks when writing the DMUB rptr, fist check that the
rptr is valid.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h     |  1 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index ef324fc39315..efb667cf6c98 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -84,6 +84,7 @@ enum dmub_status {
 	DMUB_STATUS_QUEUE_FULL,
 	DMUB_STATUS_TIMEOUT,
 	DMUB_STATUS_INVALID,
+	DMUB_STATUS_HW_FAILURE,
 };
 
 /* enum dmub_asic - dmub asic identifier */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index a6188d067d65..77c67222cabd 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -655,13 +655,19 @@ enum dmub_status dmub_srv_wait_for_phy_init(struct dmub_srv *dmub,
 enum dmub_status dmub_srv_wait_for_idle(struct dmub_srv *dmub,
 					uint32_t timeout_us)
 {
-	uint32_t i;
+	uint32_t i, rptr;
 
 	if (!dmub->hw_init)
 		return DMUB_STATUS_INVALID;
 
 	for (i = 0; i <= timeout_us; ++i) {
-			dmub->inbox1_rb.rptr = dmub->hw_funcs.get_inbox1_rptr(dmub);
+		rptr = dmub->hw_funcs.get_inbox1_rptr(dmub);
+
+		if (rptr > dmub->inbox1_rb.capacity)
+			return DMUB_STATUS_HW_FAILURE;
+
+		dmub->inbox1_rb.rptr = rptr;
+
 		if (dmub_rb_empty(&dmub->inbox1_rb))
 			return DMUB_STATUS_OK;
 
-- 
2.25.1

