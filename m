Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EAAC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D942620768
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ddE7lgKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D942620768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB43B6E25C;
	Thu, 13 Aug 2020 21:35:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A166F6E142
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 21:35:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxvIQ2woVCYirKpVv0aybXGh9sFS6eBq5hcPkAJKtcU8EHhQKc0/Dlmpt8/GCprX+YM3hBkG8li+7eiwCiAarVgeaVDxmzyM27awPIgcDao1cBbXqNHcB7/8CkziszYOGyNvDEvZyJSBXUvEyvtjfDAhPZt9dkGEc8hL5UnwvwHr38AcvOXqiDy6xFR+SMbQadFAwztK/pq/CKfAbpkcyPY2MMozRpA4FiYCYYplWc/M/skbA8Vbri1GwugYcDTor9mw73o7dVg9/xAFm1pZ/1jIxYavi9bvz83Sq5D/9dC7oYfXfIgTuq0EtIHCbMU8NaNstteFQLqoLvWJ0QvdvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUoOFt2kMbD8sLyph/vxjny+hIzqYDI1C01lEkA2TMU=;
 b=LM7xectwN1r3Rez5hDAxYMM3H5HNE8zvZfpNULOYS4vyAf6Na5vjOqVxArYyBsDqx6Jjk7uLzxNZXJUODi/U7Cwdw6hs8BRs+/TOtfhEHlsA3WA9gtVDhmk7NzJ8x6qx9adBiseXLb/ca6KP5AUGHPkF0NZRRJB39+ndRdwVzggPp8J5iW65zhgvn+t4AGqUvPjBEo8cmbP2TsMWJmygM7vjg9zYPtmM8EGaJd/goexyGYC0bVLzXxDcTWlOYdAdm6mGkUkh/xWbiUUQ/UeZkThlOIfs+YZmzN0SF0PAEHGuJ0GcFrs7N+ND012WosrCn2qblSUDHiBL0t101a5URw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUoOFt2kMbD8sLyph/vxjny+hIzqYDI1C01lEkA2TMU=;
 b=ddE7lgKDj7gyFj/d5PPoiHjt2sUpy2FfZteAQITkqlAEaty7O7Gtl89DYaGRwNQFOYy94wojh7ABpuOQqW3Cpr5dTHkOheWozSpxUcVsDHYvgTcJPhRIjJODr6IoEPbTaYSB3kCYir+RXGyZlbFXrvcOOil0kKHcydOCMLlBOcA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Thu, 13 Aug 2020 21:35:28 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7%9]) with mapi id 15.20.3283.016; Thu, 13 Aug 2020
 21:35:28 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/17] drm/amd/display: create a function to decide mst link
 settings
Date: Thu, 13 Aug 2020 17:33:44 -0400
Message-Id: <20200813213356.1606886-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813213356.1606886-1-Rodrigo.Siqueira@amd.com>
References: <20200813213356.1606886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::18) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::2db6) by
 YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Thu, 13 Aug 2020 21:35:27 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2607:fea8:56e0:6d60::2db6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d190b9aa-c3af-4191-8476-08d83fd0cc03
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB135569648D17605DA0290A9298430@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lddm7g2OI5NeQIkVNVYHPFB8XVI15F4Fb5Sve5yWk5F4/zVlFN3Cl+KT0DRb8mHdJltqICvO+NyyZiA8QV0mI2HaA6j2hVCOX6I4n96cKz6o3peKro27ggfTg6wgnyfrxBraU2sJOjPtzUKi2mAcCPNkmcqi7MwbtQb6Nwe/BgfZaxZY8+pRJTUNiv2rQJxWJ0hc+FNAS0nD+ojbkOx8aB8sbN5R2HKdp4peQ122QCjeQpBXYu9WjslfENo7m3Ew27W5sC0y3zJxQ23eQhA+xbFx5wZVbBeTgx24bf5g+kIR70ws8wCkO1YnLBTdr6VrgOgxB/rVIC2qOTmKWPFEzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(2616005)(6512007)(83380400001)(6486002)(4326008)(316002)(478600001)(1076003)(6916009)(66476007)(66556008)(36756003)(52116002)(66946007)(2906002)(6506007)(8676002)(6666004)(54906003)(16526019)(8936002)(5660300002)(186003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Dz7zoycOQEXwf6wYpmSOwvl9xyw/x1XFKhvAGBraxtpNf5dTtEUG/IMO5RiEMa7A28cOUIvk0XSDQdfr5Sayml3f0nhpELfONOaE5jioFKMfB13lwIb3eKSyt9iHtS/7LVbLiN5gig3nYw9MCoNyh7ftpdRhr/n/yPK2g0Gj+poFPW/vvXyn1qrmaQTZX3ds4WNssAX+3z1SKoTrFC+Llyjj8G8D/cdj+gCSCnmTamyBU5E7EzZgz3kSultQI+q7ygdxxZ8dlmLUY9AQHZitlhD8TNyUyax5rF9tmV73KsQz3cVAYvEMRm8seeYgh/5LYgghPyILPL5w5FNhKoj2Wcwl+63+a3sgM0zFrdNyg/RVpzECRF4VvC+VcIcph2EQNYRl0C5yIXUH33KGQtPjcE7dWOMwFjWKX5k1zgJx+TYnJlwTsXgTlJJT3/hcJrY3DqmDjYG5NmVN8fjMOTQrGjvi74NOExlKXWYzNzl5TpLxu0185YTGNjt4wJalUI1Xije5SE86R/w5mEksjQaVRcXinGXR6tZcGOHJQMf6UCks8lwPSCsEgla1WHeO0ND9UhMxguWdi1YoyBbI4b6kfSpAoGW1ckJKM79tcjIdtgUqq/kZQh2eYxzFIFwcPzWGnvEYqK3l7s199Dskbd5Q80Xknpq8mDBFDEH1yT1Exi3smVhDUmj/XJypUeLY+IUL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d190b9aa-c3af-4191-8476-08d83fd0cc03
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 21:35:28.3107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5kcrW+Y3hBCsPYk6Arqz8l2h07rrSUZTvjXhGvejjAbX00t9KSaHYPY/5qQ1YPvWx9TFRG4PsW/HklODbmWrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Aurabindo.Pillai@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
create a dedicated function to make mst link settings decision, so that
the policy's decision is made in a unified place.

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 1032551f84fc..e8d968af6af3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2431,6 +2431,12 @@ static bool decide_edp_link_settings(struct dc_link *link, struct dc_link_settin
 	return false;
 }
 
+static bool decide_mst_link_settings(const struct dc_link *link, struct dc_link_settings *link_setting)
+{
+	*link_setting = link->verified_link_cap;
+	return true;
+}
+
 void decide_link_settings(struct dc_stream_state *stream,
 	struct dc_link_settings *link_setting)
 {
@@ -2456,11 +2462,9 @@ void decide_link_settings(struct dc_stream_state *stream,
 	 * TODO: add MST specific link training routine
 	 */
 	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
-		*link_setting = link->verified_link_cap;
-		return;
-	}
-
-	if (link->connector_signal == SIGNAL_TYPE_EDP) {
+		if (decide_mst_link_settings(link, link_setting))
+			return;
+	} else if (link->connector_signal == SIGNAL_TYPE_EDP) {
 		if (decide_edp_link_settings(link, link_setting, req_bw))
 			return;
 	} else if (decide_dp_link_settings(link, link_setting, req_bw))
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
