Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA35BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B88061A58
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9B88061A58
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CA016E837;
	Fri, 19 Nov 2021 19:44:18 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2044.outbound.protection.outlook.com [40.107.96.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DB266E457
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 19:44:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOPOZ0BEhX2rno/cK3qX6kAan9GQbamdseaJKvazfhUHM8N1niqy7gYumG8LbsVd61TZdvmPKJpCG/ErxGqoZE2l6R6bMrgmeoHh4tIqlN8gH0Rsl2D47/iQwLwG8lCKpEmwiblC1V7EzcTl/pMVaJtG6ueRqqEkDavSh0IR/IKNdTFi55wAPE/B4j586r2hBG1EhjqTcu1/rcUZnT1gm5plIOVHgJ3hgZz+9ffYkvVnaef96Vjjs+Enz/jtRP3vnJtLXnOxmVWYvOzMyHkLiQQDSAiWPLe9/DwxMExHguSOzn5d4NpQ/d8isv0KPirlUeUpniaLtWdQ9QgENOXcXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIYTdfCYc7Xwy/c5emTYmWidDIvJq/WgxqOVwqaP4Hs=;
 b=JcbJOEYdsxk+wvXO7T58ze2l4blqBooXa506RfYMTpZoNonccYpgPPDFuGmJA4Os5nxKtW1p+M7xszRLITaS8WlMdlkd2juGvX+GLYxcpEFiM2/YIETA8rb2LY5BWjxaRX9jg3cwyat8lrkDmVQ9ceGwTUlJgdmFBPsWhpqhwc9FnS2Ox1EIEAICeiXIbTTe4n2YYVFEVWf/IymwlsOGzjhBBT7744K/jnHPJxagFsECQmWL4Q73bW03iobTyfdaN8wmtKISetkcqu8p6WP+tT7N1d/ZOiMqXV8wr5kIc8Kt+dJldX28/fKSxscoTp9JPB/XE+l5tNmIRwqtZaS6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIYTdfCYc7Xwy/c5emTYmWidDIvJq/WgxqOVwqaP4Hs=;
 b=XVpMHRNmuYhvt2OtFu3p3lbDJ+GxJU3Xj+nz2XP7HDtBqsvFWncBRHA83imSfnWPlbGYjYWmVDRgOlDLUBjJNWLGaruM6XuejSxMl9OUPeYEEn4Yht7QfEnTYM7TMkSPPNGDy2a0ypiPvX5JDAYYPsVbsSvhp69fgAsNH2HVdIg=
Received: from MW4PR03CA0106.namprd03.prod.outlook.com (2603:10b6:303:b7::21)
 by CY4PR12MB1655.namprd12.prod.outlook.com (2603:10b6:910:11::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 19:44:14 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::74) by MW4PR03CA0106.outlook.office365.com
 (2603:10b6:303:b7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20 via Frontend
 Transport; Fri, 19 Nov 2021 19:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 19:44:13 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 13:44:05 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/16] drm/amd/display: 3.2.163
Date: Fri, 19 Nov 2021 14:43:39 -0500
Message-ID: <20211119194339.97573-17-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119194339.97573-1-qingqing.zhuo@amd.com>
References: <20211119194339.97573-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef6986af-253e-4e02-3585-08d9ab94f717
X-MS-TrafficTypeDiagnostic: CY4PR12MB1655:
X-Microsoft-Antispam-PRVS: <CY4PR12MB16557027A4C416DF7F3CDA9CFB9C9@CY4PR12MB1655.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CzNf1ThTTxsFGEAgrGArtvsve3LXPxZd27uZygEK4YnWkCarylQ65WVP30LyE0q+RNmWZSpF/CpXYAUl/9ZgyCqrBF7LDwU41sUoDr+t0grRR3t86nEwk8AkcIXtB2I26zJhBlEOp0fdt4eFkBO5foQcXrMpvveKEZXAORVQavmTs/JGoIHf8eEHaCMrxbuh4KWytEVgCt2droCEU9YVfNDX8q3R57z55tn+KnFSKPLxR2oaQANpGyvPWzn9gLqlaDDZhttdy+m+VqHnTUwleZRzWUbnwYVk58YsbYZ5PYY427y7nd4LoyrE41iSSGefkudJhAIMncRGymfYjRxhPCDEbCb4J4xLVqAZQtZnT7w1n4zTpryhV4FIcA3aImWnlGky71Jv84W8zDCRJs7v3FxQWLCr2/vpifP0roCnM+/r9m+48FLrEY0GSBnBwnYTHMEfWPQGe/e4kofgi8uq5O2lM8Z6Q4Q6iiGun8LwBf2HQJrwqSGp3ubuoBgGqRqBvYYYkYBCxyKVc1HooCwxBHpagnuUTlHQ9Cc9CoMQ3M6lxDqYdonXrC7TAsjBKAgocpgwGET0MM/sHalogLe59FDdl45VOzqwsilIPMlLMzdOLPcNzdN0hVe84GkQ2oSPlX+X2WSvnMaZspFJ2byT2itDQAHVX1iKpMN8rEsDYp1mNMnv+yOaQl2IC88ns03GhtrjiGZkutZJJfktoFTZjwz5GdXjFAlP5oWKrQ+xXFs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(4326008)(2906002)(54906003)(81166007)(1076003)(26005)(508600001)(36860700001)(336012)(316002)(44832011)(6666004)(2616005)(426003)(6916009)(70586007)(70206006)(186003)(16526019)(8936002)(47076005)(83380400001)(356005)(5660300002)(36756003)(86362001)(8676002)(82310400003)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 19:44:13.6969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6986af-253e-4e02-3585-08d9ab94f717
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1655
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following:
- FW promotion to 0.0.94
- Enable seamless boot for DCN301
- Improvements in bandwidth validation
- Fixes in flags update, link encoder assignments, DSC, ODM combine and more

Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a43583c6e90e..c14e7db3f69d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.162"
+#define DC_VER "3.2.163"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

