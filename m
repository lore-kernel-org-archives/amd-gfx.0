Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B660BC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CB2620801
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2M8Qyp09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB2620801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84B136E46F;
	Mon,  8 Jun 2020 04:59:34 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690043.outbound.protection.outlook.com [40.107.69.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B69DB6E45E
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:59:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i14Bc4BmFu+EvJ6ztQpTtnIEe2XcC6z8ZPQK98DB9u8QFA06wP6aLSOO0zBO84650ctHwZ6Q/AuPru/MX1ziGrv2Wz+ObR6K/Ir50iaiti8pnuy13hKgtAXeK0RZcFiMO/X3M6U8CfgkRsWczXXW48SJbWjO67dQ8ymWPufCFBAGkD4iYarGoBo7OdK2Afw4Q3+DH6ApQWguKMPiHdQXGEc04U4T0u60rAker6arkrKdgac/d66R48xtNo/hbOjxFAMnkjcphFRSouJL2MmdbJ33NqJ+DIaErv3iicCHQxKCxYXQBqZvZ2oFmmJ0J7nuAXgxXqTAcAOqqBx0oDKPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyXsXrvOYtVSB3D7EO1VvT7122j9UiUvYFeenBUnJH8=;
 b=njuC39r4tSwLdzVZRBTWu7Ih4QV0qM17rIVeJRK/GLqWHnzI3z4FK8PqtOF8+o7Du2M2p8qZob53Gi/1Ir0n4SUe4OuQhYMUqek/PZF24r8jiSPH1CDOBrxBVAIjXtQ47y1zAeYSEMxuYCIPZOAnlfqyZ/WYGPvHKvkQXtsgYxhd31vJDUkLFcILFMFAIzJGKxr2tjqG5vgSnM/dGgtTErAR2WOyHa5RBV81h5bxonBH0+OP7xBT65BH4e8+NWhbjmMhWEBJ+XkVPrneXvUnbIwudH66J9u+sNmKbHuHnOTdT/yg8AyyhHPcgFAbV4LKgx8QRb1J3OiZOOXMNUGoMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyXsXrvOYtVSB3D7EO1VvT7122j9UiUvYFeenBUnJH8=;
 b=2M8Qyp09BIFzNHNKmt7Uw0jbKu6T0mD450/+k2aGo1YbWNHf6lU512EEWXrtUyRHLH1W/Zr62EDRdV/06kjE09cLNndct3XL0dIaDLIdeMGbr5fnzTMqK1X0Vgzr3cgCHZsSaEo7oZafQ/tdJbWyoYlf3usy+xxHOXs9eGu/CP8=
Received: from DM6PR01CA0002.prod.exchangelabs.com (2603:10b6:5:296::7) by
 BN6PR12MB1458.namprd12.prod.outlook.com (2603:10b6:405:d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Mon, 8 Jun 2020 04:59:31 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::5d) by DM6PR01CA0002.outlook.office365.com
 (2603:10b6:5:296::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Mon, 8 Jun 2020 04:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 04:59:31 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:30 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:30 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Jun 2020 23:59:29 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/28] drm/amd/display: Fix incorrect dcn1 bandwidth
 calculations
Date: Mon, 8 Jun 2020 00:59:01 -0400
Message-ID: <20200608045926.17197-4-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608045926.17197-1-qingqing.zhuo@amd.com>
References: <20200608045926.17197-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966005)(83380400001)(5660300002)(86362001)(426003)(4326008)(186003)(6916009)(82740400003)(82310400002)(336012)(81166007)(26005)(356005)(36756003)(6666004)(1076003)(54906003)(8676002)(2906002)(70586007)(44832011)(316002)(70206006)(47076004)(8936002)(2616005)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e2e4b5c-96bc-41ce-a8a4-08d80b68bad0
X-MS-TrafficTypeDiagnostic: BN6PR12MB1458:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1458472322B1C67D5D6B5AC6FB850@BN6PR12MB1458.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: izAakuyvIQelGruKtqR7SG2tIPMo+OsF2hKr/kzm6h82tcuS/tZXXlnTPnqE1avFySS6vPWWt8stXuD3MI8hsSItl3f4FqhZJBup4JLa5xx/0RLtko55SkutnVf2tYMU8nSEVMjsL7dkaUlCEd+0XBda9J1mgNnEp8M2DvKvz+49/9a2r1wQOo2yoX3+zd531/sm9oaEOC488ie2WwD0fb7gBiGRNfnHSTsLr7YRVIS/SOmL5rJrsANEGXgMo2REexIpa+AAjItV3NHxCS/F4fJj+GjAqrQgwPEzICn/vgsvbyznfioIMu6KoXK+D2Q7pfsInNgo/ENmpXJ73weXgCLH1XN6W0txoU6QTsXh/XbylEC/IJr+bTWtGnbis3tRo+//OoHutNr3jUmPKrJcMg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 04:59:31.0816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2e4b5c-96bc-41ce-a8a4-08d80b68bad0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1458
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Michael Strauss <michael.strauss@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Typos cause bandwidth calculation errors, one
of which can cause infinite loop on dcn1 with eDP

Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.c b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.c
index 1ef0074302c5..41284e263325 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.c
@@ -805,7 +805,7 @@ void mode_support_and_system_configuration(struct dcn_bw_internal_vars *v)
 
 					if (v->pte_enable == dcn_bw_yes && v->dcc_enable[k] == dcn_bw_yes) {
 						v->time_for_meta_pte_without_immediate_flip = dcn_bw_max3(
-								v->meta_pte_bytes_frame[k] / v->prefetch_bandwidth[k],
+								v->meta_pte_bytes_frame[k] / v->prefetch_bw[k],
 								v->extra_latency,
 								v->htotal[k] / v->pixel_clock[k] / 4.0);
 					} else {
@@ -814,7 +814,7 @@ void mode_support_and_system_configuration(struct dcn_bw_internal_vars *v)
 
 					if (v->pte_enable == dcn_bw_yes || v->dcc_enable[k] == dcn_bw_yes) {
 						v->time_for_meta_and_dpte_row_without_immediate_flip = dcn_bw_max3((
-								v->meta_row_bytes[k] + v->dpte_bytes_per_row[k]) / v->prefetch_bandwidth[k],
+								v->meta_row_bytes[k] + v->dpte_bytes_per_row[k]) / v->prefetch_bw[k],
 								v->htotal[k] / v->pixel_clock[k] - v->time_for_meta_pte_without_immediate_flip,
 								v->extra_latency);
 					} else {
@@ -827,7 +827,7 @@ void mode_support_and_system_configuration(struct dcn_bw_internal_vars *v)
 					v->lines_for_meta_and_dpte_row_without_immediate_flip[k] =dcn_bw_floor2(4.0 * (v->time_for_meta_and_dpte_row_without_immediate_flip / (v->htotal[k] / v->pixel_clock[k]) + 0.125), 1.0) / 4;
 					v->maximum_vstartup = v->maximum_vstartup - 1;
 
-					if (v->lines_for_meta_pte_without_immediate_flip[k] < 8.0 && v->lines_for_meta_and_dpte_row_without_immediate_flip[k] < 16.0)
+					if (v->lines_for_meta_pte_without_immediate_flip[k] < 32.0 && v->lines_for_meta_and_dpte_row_without_immediate_flip[k] < 16.0)
 						break;
 
 				} while(1);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
