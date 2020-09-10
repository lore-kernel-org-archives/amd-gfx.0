Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F18C07548
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DD9A21D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xIwLHNWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD9A21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C1A26E957;
	Thu, 10 Sep 2020 13:47:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C35026E959
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmBdOz/TxzNJIMGmltDEt79dAedxGWVzAeAK8FmjigCp1j/ftbbxrjFjs9GjH/Gz0Y3xt4NlOVqvQ8FxaLYcaOGJlfNqmslB7gi1g3rQ+8y685XZbEf/pFIBqoNnxbXKqJJ6QUt0HHRT/ekmsfAmbzUrA7ecTTRxaDAC/jMGrv8rnPS1q9z3aa3uIOLAyOkBu6b3/z3IE7N+bbo8WzkZ659JuRvknxUa+ZM6O2TvSq+isO78fTKkWd4vqR1jeARRIjgFdrZQaydo8A347+NQio5iN8KpU2NAH3IVVwB4K9RZhbFP9Nu7+7mJpExVP3dLXS6JwQCv7nmWIr3wZ5aAjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGBpFfzC+uWNtGuijEdvg4GfMLH38oMauNPg7oSKeNw=;
 b=auJws4U1LMRe67Mj3Xu8YSLyptDop5dU+D3iYFfZv88kDpG75upEDeBy1AssTApwDoK3iMT1E5slKhcQpYA77lq8an/RShuldoJrAHs+aJZjylogTRBwHwkn9lkkWQfh0FgJDYuuqqlHItD8roBmrP7tSZtQMEFW7HRLncnD8efu+pJyvQGRqEnZt4fZ7Va7pZzV5S7FmCy5BauatuXQKtuUdOxtQL+ZEVUtsva16Stn2IKS/B+gXNjrVWiZOIR5XvYcyp1grtZ4skuAtKGj0zyir1ehNosaUhDNNEwoFGRb5PaWKJLIpfgOOvAjDKyJIy26gxDI7e450xSpfvqwPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGBpFfzC+uWNtGuijEdvg4GfMLH38oMauNPg7oSKeNw=;
 b=xIwLHNWpDBRw5R1b91tisQ0VwxXAbkNx0ZKtwgQLUpIqG+viato6oZ3CKXbfbsfKbpq1GojC+4MKr71GVscByQgqZV2sL+Kn1yDoxFhA+fWg+BGhd/5+YcBhvxq+ax/KH2rJZXb4ZGf9HyoiN+ekobV3n2KClA3osjTdVW7uHIU=
Received: from BN6PR2001CA0031.namprd20.prod.outlook.com
 (2603:10b6:405:16::17) by CY4PR12MB1846.namprd12.prod.outlook.com
 (2603:10b6:903:11b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 13:47:39 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::ea) by BN6PR2001CA0031.outlook.office365.com
 (2603:10b6:405:16::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:39 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:39 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:38 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:38 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/42] drm/amd/display: Don't use DRM_ERROR() for DTM add
 topology
Date: Thu, 10 Sep 2020 09:47:03 -0400
Message-ID: <20200910134723.27410-23-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f212834-d879-4c19-3188-08d855901573
X-MS-TrafficTypeDiagnostic: CY4PR12MB1846:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1846F54F0E7DE94EF1E3ED828B270@CY4PR12MB1846.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8S9zcdEdICRvfMMfxjYlpN8YCNyHPKPKhwf0VY6H4SBen2IXoAmJtBf4XglvhToCBtr1WcbZCAYf4v4zDLfPZQUZdEC9xplNgDHf8Ur1I1nVUvs2OHKDy6W+/4ZO7zPk2n8+MOS2TdxHOdNIFuNBQNEt+TEI832vWJMS8TBwhk97lnlYymIIcEQtNfFWck8JiEtmE/VraCBUb6jFRxKwgKues/cM+k0aT9KGEiP+PBQImJUpF5kVB3PDuLMhnjF0T0VUkB5OYDl6B16DIz1ZwrahQ2+r1XhpMDoIR05K8itGykY61Opk3WA3G7p02TYFeHVztCZ/ywoaOO1W4MJvD5SOqADxmj4xEb1aieg9gaZatW09AsNriDsgsL/tZDQIDRqDC6Ehc7L00DjtT8t0Yg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(46966005)(478600001)(82310400003)(70206006)(26005)(83380400001)(44832011)(6916009)(356005)(81166007)(5660300002)(54906003)(70586007)(36756003)(47076004)(86362001)(82740400003)(336012)(8936002)(186003)(1076003)(316002)(4326008)(2616005)(426003)(8676002)(2906002)(6666004)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:39.6017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f212834-d879-4c19-3188-08d855901573
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1846
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

[Why]
Previously we were only calling add_topology when hdcp was being enabled.
Now we call add_topology by default so the ERROR messages are printed if
the firmware is not loaded.

This error message is not relevant for normal display functionality so
no need to print a ERROR message.

[How]
Change DRM_ERROR to DRM_INFO

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index fb1161dd7ea8..3a367a5968ae 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -88,7 +88,7 @@ enum mod_hdcp_status mod_hdcp_add_display_to_topology(struct mod_hdcp *hdcp,
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
 	if (!psp->dtm_context.dtm_initialized) {
-		DRM_ERROR("Failed to add display topology, DTM TA is not initialized.");
+		DRM_INFO("Failed to add display topology, DTM TA is not initialized.");
 		display->state = MOD_HDCP_DISPLAY_INACTIVE;
 		return MOD_HDCP_STATUS_FAILURE;
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
