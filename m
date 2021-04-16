Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A274DC43460
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6926E610FC
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6926E610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A8F66EB8D;
	Fri, 16 Apr 2021 14:34:36 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680072.outbound.protection.outlook.com [40.107.68.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61D9A6E084
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 14:34:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gs3fCa0szUs8+PkfftKCnLPD5cqm/Lx17+hz0FDEnYNANuqWCAIX7TspduJfv7HNFVzZW5ZS5HdV0bVnDdieULQsjqNhdLb98znZp+Ymd1Yu2eEXkUs10HuxKUvD63ipU294dMqd19kAUM/cmVlyzToMoame/rnEO8mUHIEMg7Q+pVK5nj1/hc3L0jjdV1ZejPAvAAk6xCVEcw6NVdyc+I4WmUikq/cTdkySKY+IP8XAQYWyfp87UiSCNd29LQ7yWn9xZFP0BZeyBM/qZA/258YsksXCzMTTMB/Q865RPQYYABvyHbnuL9eNdWHoP+YmTbJiRQRLNDW14WddxxPVMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8S3MNtnRYiEajaHoumIem4z5ZQimloxxeDu+YMVD3g=;
 b=l0CPbBfdlm03+UFpGqJ3QpodMNbI9oB1RpC5eRAqWdtkaH/XaHJF+r84QtO0wp81c/HHCv9tLDcRefZ6HBTeXLcVmK3Pl2mJjsEG1P//cdMrXEVOxnQobwJYPhvCSfAGI2RTDjJYAkZLqHBtOVUen5JBtmXzv909Gbbe3Dzx8grTCvvU3XwRmqOv9dSyVslnwKz09SMmqnVtv1AQPu0z8NFKbpORqkLavgDcRhKVeTGLd8eel1sawppsryhmTiwL/T4P4JBL12Kw45sFdyVJc2Aw0+7AjgneUf5wasGkYkOPXekPvbRgdFB/33j8GhgPdjYmhMIMGj8adfaIMLxGKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8S3MNtnRYiEajaHoumIem4z5ZQimloxxeDu+YMVD3g=;
 b=ypjju5+s0TTvKXLdyfGGE7iDobaWiqpOCdKv68iIhkSPfMV9bxeb/e3sOrB1RROFyfFeUkX2NEOPFvvyjFYanybiIs+YGBT/8lK+fDmUHAgbugqAmyM/w1/DwkYTTpjcGD6YWF5Mbfq1frK/ow4gQaQ8fqxucc1mJkqcilQsAkA=
Received: from BN9PR03CA0918.namprd03.prod.outlook.com (2603:10b6:408:107::23)
 by CH0PR12MB5155.namprd12.prod.outlook.com (2603:10b6:610:ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 14:34:27 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::37) by BN9PR03CA0918.outlook.office365.com
 (2603:10b6:408:107::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Fri, 16 Apr 2021 14:34:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:34:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Apr
 2021 09:34:26 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via
 Frontend Transport; Fri, 16 Apr 2021 09:34:26 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/19] drm/amd/display: add handling for hdcp2 rx id list
 validation
Date: Fri, 16 Apr 2021 10:34:02 -0400
Message-ID: <20210416143417.611019-5-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416143417.611019-1-aurabindo.pillai@amd.com>
References: <20210416143417.611019-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ee0cb7a-6f1c-4e10-f9a1-08d900e4bd08
X-MS-TrafficTypeDiagnostic: CH0PR12MB5155:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5155A060263C1D18D0872D3A8B4C9@CH0PR12MB5155.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6GK9WD465lNAjMYYEBY9Wqch72FHSCyNVFnZ00g2My6MvwIB7fYPzyH2FUukC1qReqTcSC5ItuQseXmM8EeM5FlPW+lcgYLp7d523QCe9FYJkIOtOUHKVmHalJmoZG3T7gYKYwxHvWuiDbj0Iz/tBc9GHe55QvTf6bCqJd7+z1mQQ1Au02x+t4cjjPoWkwmDm38Hl9w+Jwl7X/2BaVtyiJKh+3NDP369f8KAGwjoh/C0Gj0oVdMELk1p4ACZhEOYT8ceT5JvO6hyXJufv3Z26ETR7Xfk20MXN2udg+4YUAAb6nwY3LY18/cKOb2E2A+jakQfpXu7GmZF8JJyM8OgUpsadqCfq3Z8muetzMDgX/dwb5oZHJa8r5IVwyI8kXsdIkCjaGr/d5rnexHJxUv9TgA/JqdS/S/8Du6XTmYcZkSts73XLoUz5UBnBpAtD8lKtsVK5Ah4uDOZDZJKUYWx5iKvNjKuqCiLjZqn/GGjfhKVdYNzJKibc4QiIu8ToJ4gkjHzJ2+l16spjAX3SEpvN7/BJmU4KgWnwjELGd6xJGGUh9SR1F0I7bVHLASGclns0JaVucykV+PaCSwjqb8gt8VepQSsBDENl72FoNo0u3Sz0WPQ6uehdjzsLplyEjpsRyKjx9oaT6qqby6L4wVyKYii8Yo5dVre0H/UAEa8OJkfvXkdMh5xYWEtRD50jetA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(36840700001)(46966006)(47076005)(2906002)(26005)(478600001)(36756003)(4326008)(8936002)(336012)(426003)(86362001)(6916009)(1076003)(7696005)(186003)(5660300002)(2616005)(356005)(70206006)(316002)(36860700001)(82740400003)(82310400003)(83380400001)(44832011)(6666004)(70586007)(8676002)(81166007)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:34:27.3211 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee0cb7a-6f1c-4e10-f9a1-08d900e4bd08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5155
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
Cc: "Dingchen \(David\) Zhang" <dingchen.zhang@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Dingchen (David) Zhang" <dingchen.zhang@amd.com>

[why]
the current implementation of hdcp2 rx id list validation does not
have handler/checker for invalid message status, e.g. HMAC, the V
parameter calculated from PSP not matching the V prime from Rx.

[how]
return a generic FAILURE for any message status not SUCCESS or
REVOKED.

Signed-off-by: Dingchen (David) Zhang <dingchen.zhang@amd.com>
Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index 9d7ca316dc3f..26f96c05e0ec 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -791,6 +791,8 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_rx_id_list(struct mod_hdcp *hdcp)
 			   TA_HDCP2_MSG_AUTHENTICATION_STATUS__RECEIVERID_REVOKED) {
 			hdcp->connection.is_hdcp2_revoked = 1;
 			status = MOD_HDCP_STATUS_HDCP2_RX_ID_LIST_REVOKED;
+		} else {
+			status = MOD_HDCP_STATUS_HDCP2_VALIDATE_RX_ID_LIST_FAILURE;
 		}
 	}
 	mutex_unlock(&psp->hdcp_context.mutex);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
