Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCEAC48BDF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55CB3611B0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CB3611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D87F26EDB2;
	Thu, 10 Jun 2021 16:29:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3B956ED8A
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 16:29:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqafS7NwGllCjWAh80cibOTjYoLWUpM5s9h/lgjRzqRH7avxHRD5NXs66IwzLxjw8b/P9vokaI+rKwZGXqbRVnqwYewMEr/oOMxr6IERsce7DBR0JHMP9pjA/IYoKYOYQsB6ViB+MTfsXyIxNXDuPM7lQAYabqu3ojv83v+dHBYsAcOGivK9py4YTQT/YwKteL/kZk18sVXXmgl/oxYLoalJYOY/ZRfF+O21dgbbxVnqyuhXvot9Wajg2tQzjc8eoQjujvy4/4YZrZdNFf4Pa1wMAEo3fS1HgujVth5lnXqy4wFSPOgYj56LfcJWOAGCdrSazjEMv8Cujk/nxTn5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyj5qiGFkSp+FqQ3QnCDWjb6hsrA1iq/3rZR0mgBE6c=;
 b=ZpMwKhHqW0oF5QrtORMR5e8esdVeDrbEgyfk0uCaY61A8OLMXOApgew8FdSK25SSBf27O6TRDd94VOHFpvKeYvyulGTVZWb3p/AZurzzVtbYjOGDbxJjc/5lWHrgbWlW7C9EZr6TjnZVHaIq2DZzwkni5GFB13RFBewBtMcGma2tld12Wo1oD/5bTq9RL2etuJXAIHEevJS9lDJBi0ynbY2Xc/yMhKoxjiSujyCvC1jyWP5kQAaZptsDxDrCPMn2sLQWmBU7N+gsuQastX3aTP0moTbnQlzODt44o0BC/tnjFnhsyEcheRaUcc7KlkxqnZ7MLmfjClL4hP8eiVaeaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyj5qiGFkSp+FqQ3QnCDWjb6hsrA1iq/3rZR0mgBE6c=;
 b=WVIlsCptsNKt1uf39LG6etvckrmSjwmUwWk8fhjv04FnjUOEHMwYVD0IdEIRs1EjO8+1iTME3hfqlGS8FXc8BoXddY9yhanWSkCnTYWX3wwhC8zCMhfPBsDfjjuUb0KQg+x4MYez5V54RZCoT4k4ghKXBGflTODhYTfp7/G6xHw=
Received: from MWHPR15CA0041.namprd15.prod.outlook.com (2603:10b6:300:ad::27)
 by CY4PR12MB1589.namprd12.prod.outlook.com (2603:10b6:910:e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Thu, 10 Jun
 2021 16:29:28 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::68) by MWHPR15CA0041.outlook.office365.com
 (2603:10b6:300:ad::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Thu, 10 Jun 2021 16:29:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 16:29:27 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:26 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 09:29:26 -0700
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 10 Jun 2021 11:29:25 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/24] drm/amd/display: Read LTTPR caps first on hotplug
Date: Thu, 10 Jun 2021 12:28:25 -0400
Message-ID: <20210610162838.287723-12-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610162838.287723-1-Anson.Jacob@amd.com>
References: <20210610162838.287723-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec669290-7191-4cb3-5810-08d92c2ceaa8
X-MS-TrafficTypeDiagnostic: CY4PR12MB1589:
X-Microsoft-Antispam-PRVS: <CY4PR12MB15891CC9A61B3D95A5BCAE1BEB359@CY4PR12MB1589.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iJWrEJMt5Bct8LtZt1Mx0JcQ6w5CfLOql7c1hsVC4jc3TjzSyq186AxVfwbdzLBgyR1+R6vTPl2mTseVuhWWhFZZdFRoxJnO9vlkene8+3Ya89V+4cT9aEw7t+ggEQfSkKyJZXb75ZspYi4TvnNzYTyHqKwa8g+ttUhfJG/4QfloKpZk55TcK1jhow+UcTzqhymBRV1wXFHNq6sm5mIE6yflxtHpXXjeJG8BDoD/0/l8pttOM/4uo5pake09wc1vkCFUEk61imOtF3q/6vQq41pbKoFNq8zBXjg/A6FWioUQuKJYJ0HwKa7aIMEnyn1GWSc4l93BMWm0V1ldtDtGntE9TsfFF1PGs8U6EMnGCm6orwp1PCtmDvu67bDwOvJsfXYxumPW2E0q99FAkSS5Hh8rmqjiwByoJc2H2F7eycYL8ZLBN7r1ZI1HplSdIiUSdsqFRzyEOwClm1fMKG+fj1CDBv4K6fwx8gfK4HeY+7bAC4n7Dkpe2SSG6eMqpn0XSvb1/aQhIso78z4F0zRHIQeiN0wYtQEHkCnYuvFG18KeEtqWU88XNC2wdW8bHQK2beVfM0OtGcnoabNmOpjWSA5E895AfC3L9onddyA0IJwHr8APZ7025RJmZgss+vbtSjbBJKiLLduZVA6xj6Fs6mnxHfgasyp+5ssk89S4/fLVNTyEIrgBlT6NznZIC8Ls
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(346002)(136003)(376002)(396003)(46966006)(36840700001)(47076005)(7696005)(36756003)(83380400001)(26005)(356005)(81166007)(8676002)(70206006)(2906002)(8936002)(186003)(82740400003)(478600001)(4326008)(54906003)(70586007)(86362001)(2616005)(82310400003)(336012)(316002)(426003)(5660300002)(6916009)(1076003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 16:29:27.5200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec669290-7191-4cb3-5810-08d92c2ceaa8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1589
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
A new SCR for the DP2.0 spec requires that LTTPR caps be the first thing
read from DPCD upon hotplug.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 65 ++++++++++---------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 7024589791fe..0e2741cd5f26 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3660,38 +3660,6 @@ static bool retrieve_link_cap(struct dc_link *link)
 	dc_link_aux_try_to_configure_timeout(link->ddc,
 			LINK_AUX_DEFAULT_LTTPR_TIMEOUT_PERIOD);
 
-	status = core_link_read_dpcd(link, DP_SET_POWER,
-				&dpcd_power_state, sizeof(dpcd_power_state));
-
-	/* Delay 1 ms if AUX CH is in power down state. Based on spec
-	 * section 2.3.1.2, if AUX CH may be powered down due to
-	 * write to DPCD 600h = 2. Sink AUX CH is monitoring differential
-	 * signal and may need up to 1 ms before being able to reply.
-	 */
-	if (status != DC_OK || dpcd_power_state == DP_SET_POWER_D3)
-		udelay(1000);
-
-	dpcd_set_source_specific_data(link);
-	/* Sink may need to configure internals based on vendor, so allow some
-	 * time before proceeding with possibly vendor specific transactions
-	 */
-	msleep(post_oui_delay);
-
-	for (i = 0; i < read_dpcd_retry_cnt; i++) {
-		status = core_link_read_dpcd(
-				link,
-				DP_DPCD_REV,
-				dpcd_data,
-				sizeof(dpcd_data));
-		if (status == DC_OK)
-			break;
-	}
-
-	if (status != DC_OK) {
-		dm_error("%s: Read dpcd data failed.\n", __func__);
-		return false;
-	}
-
 	/* Query BIOS to determine if LTTPR functionality is forced on by system */
 	if (bios->funcs->get_lttpr_caps) {
 		enum bp_result bp_query_result;
@@ -3778,6 +3746,39 @@ static bool retrieve_link_cap(struct dc_link *link)
 		dc_link_aux_try_to_configure_timeout(link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
 
 
+	status = core_link_read_dpcd(link, DP_SET_POWER,
+			&dpcd_power_state, sizeof(dpcd_power_state));
+
+	/* Delay 1 ms if AUX CH is in power down state. Based on spec
+	 * section 2.3.1.2, if AUX CH may be powered down due to
+	 * write to DPCD 600h = 2. Sink AUX CH is monitoring differential
+	 * signal and may need up to 1 ms before being able to reply.
+	 */
+	if (status != DC_OK || dpcd_power_state == DP_SET_POWER_D3)
+		udelay(1000);
+
+	dpcd_set_source_specific_data(link);
+	/* Sink may need to configure internals based on vendor, so allow some
+	 * time before proceeding with possibly vendor specific transactions
+	 */
+	msleep(post_oui_delay);
+
+	for (i = 0; i < read_dpcd_retry_cnt; i++) {
+		status = core_link_read_dpcd(
+				link,
+				DP_DPCD_REV,
+				dpcd_data,
+				sizeof(dpcd_data));
+		if (status == DC_OK)
+			break;
+	}
+
+
+	if (status != DC_OK) {
+		dm_error("%s: Read receiver caps dpcd data failed.\n", __func__);
+		return false;
+	}
+
 	{
 		union training_aux_rd_interval aux_rd_interval;
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
