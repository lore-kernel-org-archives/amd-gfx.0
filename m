Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5891EC2BB84
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:42:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1FE1208E4
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0mMPgHmX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FE1208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 625576EB16;
	Wed, 16 Sep 2020 19:42:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF8EB6EB16
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 19:42:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jg0fdHy4KTrGx2Ndm5KHTrNXs/v7y6rv5mCBc1eqgg1mdS1b3Fh9urqZX/oVYMtlLxLZe/cSr6HmS+IonkSfO7hZAgiu55hJeO6veLPGA7WrxZEeUEsHS2CIjnfzhYEvmMpNs7GWmnxwnB3AhN7xXjSdH18VO9dxv5dprfgCsh5NNz1bBRnCL9FaDEjTmG/lhkjt7DaaIpg/PkbSZRaoDYLbtAJyqz+LEVgst5eZJklaNR9eVbXBubl24sKCMi81m3i05VDEZ3e1WrbwC44vdfb8tu+pgrGNM2MT9PzOnLblgp0TDHJfFLiRcGhg1UplcF6gC62ox++RCELVccjfMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQc2/6cmn8Luhb2U4jK6/yzI8lAafQx5fbsY10sreUs=;
 b=PgOEtn0cmoIO3OVcKGDOxVuEmX4Bl0dR2+4JO2IS38sq7Vo/yNvsYYb/AzSITWkU8nm7kV9JDLNazOzBUddcT8glC8kdsAP5ObLyltrCYQjeYp/RKg7/5HUS6vGcZXaZKu4FDv1q8/HHUOQadK6/Un8jhanXsj3Mu1Ej2hHlcsnPW0zU1GFMISb1sSgP3q78ks/6/TYthyheJJF5cygBBWXE603l7tZaVYNV5M593M7yUjignNJOQDQqV04rAYDW4g/6SYQFgYgRPwxHTB8k153GhXrvW2UT06r1kmBH/XmGFg52FdFDh68EfUp5aUMedf1h711R/uhfJN24u445Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQc2/6cmn8Luhb2U4jK6/yzI8lAafQx5fbsY10sreUs=;
 b=0mMPgHmX/lk9E7/UfkZzVd5RcgqLOwD1TZUR8JZcGQtqgMIuFPYhiBbh46vei3x4JzZIHfrI0aE9kVXFuLOiU5ZxHmQI6CBsl6TQQ3KIEHFL/tmwxqLGoFoVRn5x/dGX2vRDvlrtz/GpMJb5+4Sy1/mSDCycPENWYTbvm4zJSE0=
Received: from DM5PR20CA0016.namprd20.prod.outlook.com (2603:10b6:3:93::26) by
 MWHPR12MB1758.namprd12.prod.outlook.com (2603:10b6:300:10f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 16 Sep
 2020 19:36:43 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::45) by DM5PR20CA0016.outlook.office365.com
 (2603:10b6:3:93::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend
 Transport; Wed, 16 Sep 2020 19:36:43 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 19:36:43 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 14:36:42 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 16 Sep 2020 14:36:42 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/15] drm/amd/display: allow DP RX to use more cr aux rd
 interval delay
Date: Wed, 16 Sep 2020 15:36:30 -0400
Message-ID: <20200916193635.5169-11-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916193635.5169-1-qingqing.zhuo@amd.com>
References: <20200916193635.5169-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1583803e-bc8c-491a-6e90-08d85a77d754
X-MS-TrafficTypeDiagnostic: MWHPR12MB1758:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1758C24FF39C9048122B83E4FB210@MWHPR12MB1758.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Ekq5O485pZOYVRTrG5uFXnxcqbdJt7psOEv6p7/uShhJgYURwfmb36gmM+n27lH1M8CEXpV7B1PHcfypRQbZkd8Wp2wjARUbnw3wx+PdoU8UB0O/aoCZ0fONxXcG4ZnJnTCNVDbv9g4ysOVV2hSQMihY0ldGyVg+qu+8I0Zx1T308FbgzyESyEcyPSV5rNxuiPw7K3nZUWuO+coQNkinmZc/yLN7pDKuwiywXzLfGUM1Kc9xv+VI6D7/0Xu+/+bMFLZy8XuAGqb1qFXT0BLXOvjk5/IJpmWydruDwRgQOvLSN0cpU7cuz9OspUj9ETfcxENiNwuujRgpzh5vwlqHGen02KQrndf9HZSb4MuWSAwY59MGhO5PcJn7bn4FRC26lhPgFrkPmG8wkUe9zwnxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(136003)(346002)(376002)(396003)(46966005)(8676002)(2906002)(82310400003)(8936002)(36756003)(316002)(2616005)(356005)(47076004)(186003)(4326008)(83380400001)(54906003)(478600001)(426003)(26005)(82740400003)(81166007)(44832011)(336012)(6666004)(1076003)(86362001)(6916009)(70586007)(70206006)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 19:36:43.2338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1583803e-bc8c-491a-6e90-08d85a77d754
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1758
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Regression is caused by previous change with attempt to correct the
extended cr aux rd interval delay due to mis interpretation of the DP specs.
I4b4f508e30e5218ffeb7e40cc19e6dc54357361e
The change turns out not working well with certain RXs.
So we decided to keep the cr aux rd interval logic as before.

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 47fb09f41bfb..232d77721ad9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -49,6 +49,23 @@ static struct dc_link_settings get_common_supported_link_settings(
 		struct dc_link_settings link_setting_a,
 		struct dc_link_settings link_setting_b);
 
+static uint32_t get_cr_training_aux_rd_interval(struct dc_link *link,
+		const struct dc_link_settings *link_settings)
+{
+	union training_aux_rd_interval training_rd_interval;
+	uint32_t wait_in_micro_secs = 100;
+
+	memset(&training_rd_interval, 0, sizeof(training_rd_interval));
+	core_link_read_dpcd(
+			link,
+			DP_TRAINING_AUX_RD_INTERVAL,
+			(uint8_t *)&training_rd_interval,
+			sizeof(training_rd_interval));
+	if (training_rd_interval.bits.TRAINIG_AUX_RD_INTERVAL)
+		wait_in_micro_secs = training_rd_interval.bits.TRAINIG_AUX_RD_INTERVAL * 4000;
+	return wait_in_micro_secs;
+}
+
 static uint32_t get_eq_training_aux_rd_interval(
 	struct dc_link *link,
 	const struct dc_link_settings *link_settings)
@@ -1251,7 +1268,7 @@ static void initialize_training_settings(
 	if (overrides->cr_pattern_time != NULL)
 		lt_settings->cr_pattern_time = *overrides->cr_pattern_time;
 	else
-		lt_settings->cr_pattern_time = 100;
+		lt_settings->cr_pattern_time = get_cr_training_aux_rd_interval(link, link_setting);
 
 	if (overrides->eq_pattern_time != NULL)
 		lt_settings->eq_pattern_time = *overrides->eq_pattern_time;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
