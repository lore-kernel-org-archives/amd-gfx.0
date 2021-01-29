Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5FBC433E9
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBA8964E00
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA8964E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5DEF6EC25;
	Fri, 29 Jan 2021 21:28:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5548F6EC20
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 21:28:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bU7C7MfMoWOEo/nOmnTinA5UfLlPP3kHmrqsrGftUEbWITo+DIP2yo+QYp6MdAl5slF/Ngo52zIz4D1yLEY4+Jsmc3w3JDkpf9kSpIrKZvao/dggT52bG8K3tpoKxmcFzIk6gE13t3cPwk8rWYlWPzXZNoiL7Krr8zrVmjzq0KTNeEmPouVCq9kJZbm/3n98O45PbLzkyJp+ELc09sSxuxx87aWBCRte+lmBrrJ7QUGtoaU2JF7aiC0tb7thv2MhjDhHZSvUz0d0xbxHkD0FIYit+5Gl4lv4z725960Ye7FjA6Nz/xfZ0hK2oAOHPjUQCr+i38OwsC0ArocgOf42zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJ0ad+07+MxQLM6WxOMFbxBMhtT1/+5DwjXFKy8L978=;
 b=Jpx7jPzDOnyzWrrsQCuXsxo+c+tECQtpS7ccy6b+aWuZEUB0X6Wpzt8CZ0UwFdRyFtSsopR+7pYWAIWI++Zo9tkpWPiEApUz28IgQPTZkLaJ8vgXlQO1J8sgjg/Y+0dhcFtxCYnk1w19ZmgRbgE0mkK+NyUex1US+ZtjYsSJzKVmBdfSU5hxp8EQZiUcEaC83oiaSveQLGLmnagjWnZzDPErx1IxBQm3/QbIFXHdS4rPEIe2t0S7bTNBFoUXwqK8KGktZPTKBtAefyUIrsgDp+dRGHsOhSRaK3LY5WiMpC4vuXm9dpWDi6eH4f+CeMNGw+5HvIhlrh1BWrJdCmyUHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJ0ad+07+MxQLM6WxOMFbxBMhtT1/+5DwjXFKy8L978=;
 b=WZrNYRWkxrWOpGjWSsd+EvMOzOsRSYvhsQF+AfZz5RnlGBF6eAdBPWWvoUGqBRFGauyjbO6VVxBvMA2D7aEWQeD+Z5oqHc0XMU2fEBhRe89kh7D2YkIYbXvdHTqzljHqpGpE+6VEs7wK19PV7RK3wcyRLX7HvuaSlIx20lkV2dY=
Received: from BN6PR03CA0080.namprd03.prod.outlook.com (2603:10b6:405:6f::18)
 by CY4PR12MB1605.namprd12.prod.outlook.com (2603:10b6:910:f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 29 Jan
 2021 21:28:06 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:6f:cafe::11) by BN6PR03CA0080.outlook.office365.com
 (2603:10b6:405:6f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Fri, 29 Jan 2021 21:28:05 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 21:28:04 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:03 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:03 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 29 Jan 2021 15:28:02 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/27] drm/amd/display: Add null pointer check to
 is_dig_enabled func
Date: Fri, 29 Jan 2021 16:27:29 -0500
Message-ID: <20210129212752.38865-5-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129212752.38865-1-Anson.Jacob@amd.com>
References: <20210129212752.38865-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39f6d021-7b15-42eb-e9f7-08d8c49cc32f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1605:
X-Microsoft-Antispam-PRVS: <CY4PR12MB160582768CF3D8EC4838540EEBB99@CY4PR12MB1605.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /y3+YCAnhLKjkoUISvNd5LV0AYyqGugNHCyL05gbgcbuC7Gvmrzp063yw/mAl3uhbLBdN2pptdxSPSvBrpe+uHqMj3zyd1nQ0vsFDhgMygVMrQ3RnIXPN9hhZsBwIGYBbsiBBk7yUKSNVa61qq6/SO0n/1FWaZOkwM+h4vrLPLshZUYbf3jhPM0JmNKuJDpr9SdZIyqeyyxwvHKY9W7tD1ho65TqAXN/71b6XS0m0ta1u6B+vd2ZYjysHn1s23PMkWoIRR8k2kyrx2PfV70/vGV22btHLp2g+DBDZJnrR6qx8kq3bDoAuV3XGIAbSvGtXVrijuiylv+8JA/AtEIPOy84A0cd6RfvMexZMZlc4RH6w7K16nrW59NdEGTbiKIUoX6N0+XO/5UPGi4YEZqX/ZkW99v5hsi3v1V0+uqhkQAYSOck3fVtK5U0s3TI2qTjBCfiCgS26ZvYepf8eh9UdUcMRV63Y/YyA1v5bNtgn57LdHuWhN40PjB2eJFS5EN6Q4s8wK/P7m/k6+cXnzK/H/4M7d8SOIbJcun4MxBm3ptsUkesqnlZ5eR1OpkVg3oK6AYyN7KwcBqYhW7ugrN3aQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(46966006)(426003)(7696005)(4326008)(316002)(336012)(6666004)(2616005)(478600001)(54906003)(26005)(83380400001)(186003)(47076005)(8936002)(8676002)(82740400003)(356005)(1076003)(81166007)(6916009)(86362001)(82310400003)(70586007)(70206006)(36756003)(5660300002)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 21:28:04.1124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f6d021-7b15-42eb-e9f7-08d8c49cc32f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1605
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
Cc: Sung Lee <Sung.Lee@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Michael Strauss <michael.strauss@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Safeguarding as pointer may be null in diagnostic environment

Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Reviewed-by: Sung Lee <Sung.Lee@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index 991b9c5beaa3..aadb801447a7 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -75,7 +75,8 @@ int vg_get_active_display_cnt_wa(
 		const struct dc_link *link = dc->links[i];
 
 		/* abusing the fact that the dig and phy are coupled to see if the phy is enabled */
-		if (link->link_enc->funcs->is_dig_enabled(link->link_enc))
+		if (link->link_enc->funcs->is_dig_enabled &&
+				link->link_enc->funcs->is_dig_enabled(link->link_enc))
 			display_count++;
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
