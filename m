Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2FCC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 10:53:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26FDA64F45
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 10:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26FDA64F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8F8989C0D;
	Wed, 17 Mar 2021 10:52:59 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2073.outbound.protection.outlook.com [40.107.100.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9438689C0D
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 10:52:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMhurHVkPvTUX165MMnSwkKVIQ+rERjaS0yqDnchHxBzz0sgcHG7EqB4EgYhi/GnfTCbsCcKpogCbBX/Phk4KFLoIj8Mo6d3zbQ0WgNtYwbGnLUmCaX9o4YdXMI1g8XiMk3Y0yt7XoAKcmJr8dTolkUrDVcs4FT7anQMIN04Omm8/JnqAFwmlZZYjBeK5HueQVPHPyzdUysiEK/mPZ3bWAA+NBgpHpKVU67g69RSRA1zxl1YCkH8GlSPN0+yk+XfSIbaG4h+fkg4E58+cGqY89jBIYw3T1nZ/eZ8yNVgnjvnhTMNVs7/1LLH88UGlDG/0ZwLwU9+sf50flrAlAo9dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4HD+fRplBCHB5ztOaeS0UIx5DhCXMvF1m5zyC31EC4=;
 b=QBGn8p1Cn1a95rvpCn3YeLcjm6GWOlwoTCFpWyhXMlY9qp7X30rtdJ1kPe5he2oOLNbcF27e6KexQc4gzmPA9OMSJYHODppSv7TAqq6p2+aVxVO3+nrboavOaYecCYFb9x5bke4DG6TAf1vxuRrjIItjXdfxW7Nhf1wld1t8cp+9kmf4DlWKNpGOp4oqUOW42hopa6NTTVFn5w7j7rKc8LlN+/4QscNfyQZkfN+9AX3/CqEZY/kmvcLlu6zs7Yn0CMaj/mMevIVNVeRyxyYsW7SlO9QlVFhi2M84xhkvkjD17ytIZfgrlkuD7IRXRjZMmmtVOynR2p7IxGL175hMuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4HD+fRplBCHB5ztOaeS0UIx5DhCXMvF1m5zyC31EC4=;
 b=KvqBF66gr7vdOEMzaFn+U3E6T4X4SUH2cgry4/P/5f7KrJKjOh27drY37oE4pLNgrEZwu4OMuKHdUb0QKVKMaa5oRUgVzyBuyoskG4bw4Xz5xhiFGx2lYpmrn8+QJFyWbpjnBNIxFfdnhTCyHzHnjQmBR5K/NxxoRPZEqTkkqoA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR1201MB2470.namprd12.prod.outlook.com (2603:10b6:903:d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Wed, 17 Mar
 2021 10:52:56 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 10:52:56 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: harry.wentland@amd.com
Subject: [PATCH 1/1] drm/amd/display: use GFP_ATOMIC in
 dcn20_resource_construct
Date: Wed, 17 Mar 2021 11:52:39 +0100
Message-Id: <20210317105239.70617-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
X-Originating-IP: [217.86.96.184]
X-ClientProxiedBy: AM4PR0701CA0006.eurprd07.prod.outlook.com
 (2603:10a6:200:42::16) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.96.184) by
 AM4PR0701CA0006.eurprd07.prod.outlook.com (2603:10a6:200:42::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.11 via Frontend
 Transport; Wed, 17 Mar 2021 10:52:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 41a4827f-f436-40e1-88f9-08d8e932d26b
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB247068FEE68E5736DBBDB5418B6A9@CY4PR1201MB2470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:568;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L58TvrpYuqxlOzi+e0tfk++u92s4WGD62UHMn4aWSasjOvRjpumu3jHDL14MZvCxiP+j9pSTINCHoGVlJfq4EjeI0Lln8HGFJQR0QpVfZJIIC5KeWUVd30/93gFDG1jdSByQh33kFf6oEJzFACaEYTvzmis27OTSpdxM75j12zvxjRy2hojftugKHywjS27v5QVq1Gb09HUhqNzIeq5KajE+Q8rSKHW4zJKEvtVhWM/Ck8Jungt/zBLvmR6a6DsCaY9n6nQj9sbHbb1ftAAM8t71WytfeHOX3oD1eNYfIZNscBC88/dfOwsk+pt+iTkLxbgFYAS7MCGGbrZoXWnSBU/7s8kV4y+TxcXQIv2bl9G6ZhMl1hIvVcROFvPD12Lz3QSGCrEYMVt+VTRek0a86AZ09w3v1Ixaw5eYuzLC+cndM42gfu+deQZeYhBqfHk1Jodg/IXmuQsmdbMjtFXbR+6kJ1sdkRsppbgQdoSuxdge+IJmxo6H3qknLnfB+hOHYMFZt/dzCLqF7GHdnuuBMH/7PqI4Vc8yML9XzpWmDN0BGbcr2jWd2gcXUyMR79pb1J34XVvmreRy5BjMZU9sL0nIDPR1x103Z4tSiqdTIqRo6A1avfNSON7Opaa+Dopb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(5660300002)(6512007)(966005)(6636002)(66946007)(66476007)(52116002)(44832011)(66556008)(478600001)(1076003)(86362001)(8676002)(2616005)(83380400001)(4326008)(6506007)(2906002)(316002)(956004)(16526019)(186003)(36756003)(26005)(6486002)(34206002)(37006003)(8936002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DsN5MOFiBrXCzKA5BwZNpeETqSmjouep4O4W2a5SOB47a57tfD4fQR8PFqV0?=
 =?us-ascii?Q?I8URtef7hvpj9jBs2JcjzlcZ0KPaZFxRdb6+EUgnJ4TKu8YmxTHZ3Y6sU4xt?=
 =?us-ascii?Q?8ZC1UfbJlfPv8xdCp+MVEkgQfHTSHhTWw7sPoNe+IcOoP2qEzWuC5V4Fa9Pw?=
 =?us-ascii?Q?9JbwghT8hkC5DaGNp6KnLDyN+SNdltcoa3mJED3fKcxwVZcKloxNsFq/WmRK?=
 =?us-ascii?Q?kk9D4ttQKc8PSaERSb3gR726VNhuvKmLqhb0DomX9p5+JhRUGVDuJpq9vWPQ?=
 =?us-ascii?Q?8KadnVBXtvWWbOeOdqZBseIusGoFv9CO0DNzXRpdYL+iqfZA324clM9Ze+qm?=
 =?us-ascii?Q?DGshaKc1+iIPC1DkNmG2MerYBAWg6cCd1McFMPQQ9vriIBpv6JPT8RZNxKwA?=
 =?us-ascii?Q?bpaII61roFQx48xWT4IqWcbZNoWYPVt813STV6cjNdZgRIa1TsCa9ccsaY4Y?=
 =?us-ascii?Q?G49rOfee/WrPc1RgAGoHGV87hsMcJrJXxQIVJcxDM6ZsDRy5BuVZPCZcN5AK?=
 =?us-ascii?Q?w7rk8ikgMe03mu0yRV8HY5seEoW2HIRUJBjy+uZwL3IIgwtl7EAU8BvZRoLd?=
 =?us-ascii?Q?+HqV3l4QmaT5fOI+uZGHlpun8e7AF0xM1MOfT2USq2qieC9s1jOkJ8DPhzo2?=
 =?us-ascii?Q?+eDfRsX3lTx/tJSB9BmEjRpsp2OCqoCtObtZhi0/5sWNO9rU1YBUHvzoYb9K?=
 =?us-ascii?Q?YLVADdlZdSSfG0bZyqO1U5M6pWCJG1ga+6st+8/WcGP4+W1ZedL/et2PPkzm?=
 =?us-ascii?Q?z1rMPCah3Bdi3s0L45yk08qMxq66bDZNEcebrbvMLYmd4hbP7mXV5OfnGE3L?=
 =?us-ascii?Q?Nuf9JT72IoeLwijpY2ekMr7Aov6LogbLD3ijzatwrm59L5gwJqbQPSkuqv60?=
 =?us-ascii?Q?D4P6kajAvyzc3CDRDevdz4hyjUPNoBnRCdGdZkW5l/5vuQGGSMveoQdxZhuR?=
 =?us-ascii?Q?ijs1tWAnxVVmX2B2w3kUqW249wrSSdqUQUJYbfbooCJhyVsHTj8/fp2PUtik?=
 =?us-ascii?Q?Dxwp1HRpjPJaHWlQLdlI95ju6diCrItzeDR3vrrnQfh8pJMj0MBMqqlLT+Q7?=
 =?us-ascii?Q?ZPDJbYNSyXu9RYbgnc34/U+oXrunWi2NrDOKds5yTj5n8Z6vFxRQIXWYw/Tt?=
 =?us-ascii?Q?zWoszky8dt3Oq2+HXDsKl1QjM2IMzG4w1tEDZwequgbB7Q8rtHmwgR/l9WIW?=
 =?us-ascii?Q?Tmc5OGZsn/FMy8Df83DATEV5CUMEYfY6DU2tyePf1Qb50btTngkPFFiL3Bt2?=
 =?us-ascii?Q?G7UcMtuKkRLkwZhnnywg3R26ysDArlBthwlJx04UXmw3t7awTz1qF75+BQqa?=
 =?us-ascii?Q?hu04OiYsr8dX6on+hAaqsx6r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a4827f-f436-40e1-88f9-08d8e932d26b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 10:52:56.3363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dN0LEe3UPHtCSEjrT0RZHAVgeM5Ai9vJwOrn84Rce0pN/lB8RiyTVPvpu91rTFSnuD3lADl1zh6xKa5xJrJ6Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2470
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace GFP_KERNEL with GFP_ATOMIC as dcn20_resource_construct()
can't sleep.

Partially fixes: https://bugzilla.kernel.org/show_bug.cgi?id=212311
as dcn20_resource_construct() also calls into SMU functions which does
mutex_lock().

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c |  6 ++---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c |  2 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 26 +++++++++----------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
index 4e87e70237e3..874b132fe1d7 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
@@ -283,7 +283,7 @@ struct abm *dce_abm_create(
 	const struct dce_abm_shift *abm_shift,
 	const struct dce_abm_mask *abm_mask)
 {
-	struct dce_abm *abm_dce = kzalloc(sizeof(*abm_dce), GFP_KERNEL);
+	struct dce_abm *abm_dce = kzalloc(sizeof(*abm_dce), GFP_ATOMIC);
 
 	if (abm_dce == NULL) {
 		BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
index 4f864501e046..8cd841320ded 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
@@ -1133,7 +1133,7 @@ struct dmcu *dcn10_dmcu_create(
 	const struct dce_dmcu_shift *dmcu_shift,
 	const struct dce_dmcu_mask *dmcu_mask)
 {
-	struct dce_dmcu *dmcu_dce = kzalloc(sizeof(*dmcu_dce), GFP_KERNEL);
+	struct dce_dmcu *dmcu_dce = kzalloc(sizeof(*dmcu_dce), GFP_ATOMIC);
 
 	if (dmcu_dce == NULL) {
 		BREAK_TO_DEBUGGER();
@@ -1154,7 +1154,7 @@ struct dmcu *dcn20_dmcu_create(
 	const struct dce_dmcu_shift *dmcu_shift,
 	const struct dce_dmcu_mask *dmcu_mask)
 {
-	struct dce_dmcu *dmcu_dce = kzalloc(sizeof(*dmcu_dce), GFP_KERNEL);
+	struct dce_dmcu *dmcu_dce = kzalloc(sizeof(*dmcu_dce), GFP_ATOMIC);
 
 	if (dmcu_dce == NULL) {
 		BREAK_TO_DEBUGGER();
@@ -1175,7 +1175,7 @@ struct dmcu *dcn21_dmcu_create(
 	const struct dce_dmcu_shift *dmcu_shift,
 	const struct dce_dmcu_mask *dmcu_mask)
 {
-	struct dce_dmcu *dmcu_dce = kzalloc(sizeof(*dmcu_dce), GFP_KERNEL);
+	struct dce_dmcu *dmcu_dce = kzalloc(sizeof(*dmcu_dce), GFP_ATOMIC);
 
 	if (dmcu_dce == NULL) {
 		BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c
index 62cc2651e00c..8774406120fc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c
@@ -112,7 +112,7 @@ struct dccg *dccg2_create(
 	const struct dccg_shift *dccg_shift,
 	const struct dccg_mask *dccg_mask)
 {
-	struct dcn_dccg *dccg_dcn = kzalloc(sizeof(*dccg_dcn), GFP_KERNEL);
+	struct dcn_dccg *dccg_dcn = kzalloc(sizeof(*dccg_dcn), GFP_ATOMIC);
 	struct dccg *base;
 
 	if (dccg_dcn == NULL) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 2307b3517821..25f8dd5db080 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1106,7 +1106,7 @@ struct dpp *dcn20_dpp_create(
 	uint32_t inst)
 {
 	struct dcn20_dpp *dpp =
-		kzalloc(sizeof(struct dcn20_dpp), GFP_KERNEL);
+		kzalloc(sizeof(struct dcn20_dpp), GFP_ATOMIC);
 
 	if (!dpp)
 		return NULL;
@@ -1124,7 +1124,7 @@ struct input_pixel_processor *dcn20_ipp_create(
 	struct dc_context *ctx, uint32_t inst)
 {
 	struct dcn10_ipp *ipp =
-		kzalloc(sizeof(struct dcn10_ipp), GFP_KERNEL);
+		kzalloc(sizeof(struct dcn10_ipp), GFP_ATOMIC);
 
 	if (!ipp) {
 		BREAK_TO_DEBUGGER();
@@ -1141,7 +1141,7 @@ struct output_pixel_processor *dcn20_opp_create(
 	struct dc_context *ctx, uint32_t inst)
 {
 	struct dcn20_opp *opp =
-		kzalloc(sizeof(struct dcn20_opp), GFP_KERNEL);
+		kzalloc(sizeof(struct dcn20_opp), GFP_ATOMIC);
 
 	if (!opp) {
 		BREAK_TO_DEBUGGER();
@@ -1158,7 +1158,7 @@ struct dce_aux *dcn20_aux_engine_create(
 	uint32_t inst)
 {
 	struct aux_engine_dce110 *aux_engine =
-		kzalloc(sizeof(struct aux_engine_dce110), GFP_KERNEL);
+		kzalloc(sizeof(struct aux_engine_dce110), GFP_ATOMIC);
 
 	if (!aux_engine)
 		return NULL;
@@ -1196,7 +1196,7 @@ struct dce_i2c_hw *dcn20_i2c_hw_create(
 	uint32_t inst)
 {
 	struct dce_i2c_hw *dce_i2c_hw =
-		kzalloc(sizeof(struct dce_i2c_hw), GFP_KERNEL);
+		kzalloc(sizeof(struct dce_i2c_hw), GFP_ATOMIC);
 
 	if (!dce_i2c_hw)
 		return NULL;
@@ -1209,7 +1209,7 @@ struct dce_i2c_hw *dcn20_i2c_hw_create(
 struct mpc *dcn20_mpc_create(struct dc_context *ctx)
 {
 	struct dcn20_mpc *mpc20 = kzalloc(sizeof(struct dcn20_mpc),
-					  GFP_KERNEL);
+					  GFP_ATOMIC);
 
 	if (!mpc20)
 		return NULL;
@@ -1227,7 +1227,7 @@ struct hubbub *dcn20_hubbub_create(struct dc_context *ctx)
 {
 	int i;
 	struct dcn20_hubbub *hubbub = kzalloc(sizeof(struct dcn20_hubbub),
-					  GFP_KERNEL);
+					  GFP_ATOMIC);
 
 	if (!hubbub)
 		return NULL;
@@ -1255,7 +1255,7 @@ struct timing_generator *dcn20_timing_generator_create(
 		uint32_t instance)
 {
 	struct optc *tgn10 =
-		kzalloc(sizeof(struct optc), GFP_KERNEL);
+		kzalloc(sizeof(struct optc), GFP_ATOMIC);
 
 	if (!tgn10)
 		return NULL;
@@ -1334,7 +1334,7 @@ static struct clock_source *dcn20_clock_source_create(
 	bool dp_clk_src)
 {
 	struct dce110_clk_src *clk_src =
-		kzalloc(sizeof(struct dce110_clk_src), GFP_KERNEL);
+		kzalloc(sizeof(struct dce110_clk_src), GFP_ATOMIC);
 
 	if (!clk_src)
 		return NULL;
@@ -1440,7 +1440,7 @@ struct display_stream_compressor *dcn20_dsc_create(
 	struct dc_context *ctx, uint32_t inst)
 {
 	struct dcn20_dsc *dsc =
-		kzalloc(sizeof(struct dcn20_dsc), GFP_KERNEL);
+		kzalloc(sizeof(struct dcn20_dsc), GFP_ATOMIC);
 
 	if (!dsc) {
 		BREAK_TO_DEBUGGER();
@@ -1574,7 +1574,7 @@ struct hubp *dcn20_hubp_create(
 	uint32_t inst)
 {
 	struct dcn20_hubp *hubp2 =
-		kzalloc(sizeof(struct dcn20_hubp), GFP_KERNEL);
+		kzalloc(sizeof(struct dcn20_hubp), GFP_ATOMIC);
 
 	if (!hubp2)
 		return NULL;
@@ -3396,7 +3396,7 @@ bool dcn20_mmhubbub_create(struct dc_context *ctx, struct resource_pool *pool)
 
 static struct pp_smu_funcs *dcn20_pp_smu_create(struct dc_context *ctx)
 {
-	struct pp_smu_funcs *pp_smu = kzalloc(sizeof(*pp_smu), GFP_KERNEL);
+	struct pp_smu_funcs *pp_smu = kzalloc(sizeof(*pp_smu), GFP_ATOMIC);
 
 	if (!pp_smu)
 		return pp_smu;
@@ -4042,7 +4042,7 @@ struct resource_pool *dcn20_create_resource_pool(
 		struct dc *dc)
 {
 	struct dcn20_resource_pool *pool =
-		kzalloc(sizeof(struct dcn20_resource_pool), GFP_KERNEL);
+		kzalloc(sizeof(struct dcn20_resource_pool), GFP_ATOMIC);
 
 	if (!pool)
 		return NULL;
-- 
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
