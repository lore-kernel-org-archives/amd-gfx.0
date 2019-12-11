Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563CAC3F68F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:34:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFA52077B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wQBYbYXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFA52077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB65A6EB94;
	Wed, 11 Dec 2019 15:34:22 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760088.outbound.protection.outlook.com [40.107.76.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED3436EB91
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:34:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsuNr5PzKIDjKRwXJCvvZcEjofvf0Z8As/aniTzJ5Vdtb2OX9tHkrMkm/xHl8MziB6QpE2rJaP1gF0mtJJuEMTIUQYxtm31020IoA9R7DkWCzwUHvJe88sM5Q+BhDzU+M3mRL026GdM17WKrVwIYaLDA8epNJFbs79yfxck7JpwvAWaq4Q6P0dimRT5wTfdEyDTPx0mBiV+Anytc2tBFqSVeITkg3Xs5awTU3lLxR3HJo8Cna7CAqfiSZ1STHDnYLMR3emP7o4yCIOGosECkJiu5/xCA5l5x3QzeAa9bA2LqJr7QpqQMSbQ6F3lZwqU5Rq+pWLrAQcTHrjfDIiPfvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfHF4zzgsn1Mh0tbcxt6H8GNMXyVy2G7z6r7pJ8ShgU=;
 b=OCgEsOaFCuCWXGuBuhPIxo09e8u041iHM3GIQe7wcBADEJbYATSMq6IrixuyDdGx+e9V+MKmj7Rro3U/4MgCKaJUDpmkIZf2/j+ksM6nanSSOIE/olVH5PSgEFzPUfzmAFThyC2YS+ELHNK++lTkXzPkFi4QAyN1bVGSXH50SW9s8MG9tdor+rirt0mWQUycd1W+pUGyXcl7lpw3knzcBZzdyhCc5X8knR+B7u7MPYE/ESJTWptNqTlu9c6AV+/tn6B0w+Zy5yz7VF9epFQaQwntZsCWx0y0p8qeJQUOPa2qq/CTFeLIY79j8qPeXZB8W76AqiF9uJHS8n5MqSyhpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfHF4zzgsn1Mh0tbcxt6H8GNMXyVy2G7z6r7pJ8ShgU=;
 b=wQBYbYXbn4HdajOQRzqKUixJAoXy35a9C3qAhnMnThftGfDYEFwJwmaLYZI8Gm5fnRxXJ0CHfw8hwnpbjYjv9tNjCTTIE8l6/OvetJ8GdrOipIG8TGH7tDJvDjvlpRmBaXK8QUMsSLezR6dPKrAsyEoj6kWGyHzzDT0sIVKUYfU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2491.namprd12.prod.outlook.com (52.132.183.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:34:18 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:34:18 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 38/39] drm/amd/display: Do not handle linkloss for eDP
Date: Wed, 11 Dec 2019 10:32:52 -0500
Message-Id: <20191211153253.2291112-39-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d352c097-d48c-44ad-e199-08d77e4f8576
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:|MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2491182698E42F8846E5140E985A0@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(6512007)(6916009)(8936002)(5660300002)(2906002)(6666004)(86362001)(52116002)(2616005)(478600001)(66476007)(316002)(186003)(8676002)(81156014)(81166006)(54906003)(36756003)(4326008)(1076003)(26005)(66946007)(66556008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2491;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PVSmUXM4/+LoEgcITUKgYsZAY1Uk3a2RkuKZwX+r8MC4KgglxT2z1S5RY9tZsQNX4i4Yb/CI7DfTDQbDQRKBAWQNKKPxdMuA15UjcbEr2auHUcfHq5XIjIipoEDvBi/9o6qO44W4NemElRypcHx2mJOGCvm+8hxpqRvNJ6dusAHbtzbisnMis4o3yB76zf4Vu6RvwRkl63mtG1CbN1YIVNOCqK9qj5+2ZAa9OkbG9+6yMFE1dqmlKTIjkkVmnF7M1rg/tV2KQUPXrLRQg6TLMAywjfLN4i6U3jpLBLb25t7Q5FYCO7BFvAVWTMyHrnso5yxROvBucSwRT2CIkOOOPXA7st1vf1CZ8rMlm6FNyTXd6Y5F/eMB9+OSMz5TNctBeeWdawFtVLnNx+W/clUCvxTgSmmYdJMMZe6hPnL+AhNcqEaVTiJAGpEUqyApmzZH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d352c097-d48c-44ad-e199-08d77e4f8576
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:50.4640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2RZSW5yUGw2P9DR7TJXuvIUJCIJXTOu7o9dtE/471sqxd79miGKWsmzitKFGhFhhkJghX2QI0RgnSvTbnBKYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Harry.Wentland@amd.com, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Why]
eDP is internal link and link loss is unexpected.
It is typically going to be PSR related errors, which is
handled separately.

[How]
Check for eDP and skip check for link loss

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 42aa889fd0f5..38b0f4347383 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2854,10 +2854,12 @@ bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd
 	/* For now we only handle 'Downstream port status' case.
 	 * If we got sink count changed it means
 	 * Downstream port status changed,
-	 * then DM should call DC to do the detection. */
-	if (hpd_rx_irq_check_link_loss_status(
-		link,
-		&hpd_irq_dpcd_data)) {
+	 * then DM should call DC to do the detection.
+	 * NOTE: Do not handle link loss on eDP since it is internal link*/
+	if ((link->connector_signal != SIGNAL_TYPE_EDP) &&
+		hpd_rx_irq_check_link_loss_status(
+			link,
+			&hpd_irq_dpcd_data)) {
 		/* Connectivity log: link loss */
 		CONN_DATA_LINK_LOSS(link,
 					hpd_irq_dpcd_data.raw,
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
