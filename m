Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9ECC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:51:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF1E461184
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1E461184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DBEC6E218;
	Fri, 14 May 2021 04:51:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 709A56E218
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 04:51:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/tPFBX+eiXt8dc4QzIY8v864Ou4ouBicDu57at3MQGXzpX9oJERWYquTPtsYZ049IuTUD8iXxeHLB6sIotcSEPcePbSfKYAI4Eu114JRkPqVzZGSwxI57TvRfjyD1QY89wvU4A6kEUCXK9xBUbXv1QQCY64mlM+HnzdWPsQr3Y1UVnkjCHmEnljrltauZfyNrlr38WIu0Gm5Ze5xPaln3jhESAKVASGDgRz/GxypMqukkbVm6IqJrnw7ZW/Gzz0R6Mz4tgTUlAAn9rMBCho7aL/6XonhEowUuSbwquspWKfLI7Qcxn+y3e6OWxdbpeMcWi0XZm6ELfCvw/Kv2rGyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enKrDzO6/xajuAASzjZUh8I/vjLQlCy5N3RDOrDQbm4=;
 b=duRvy4hKgsSi4cuV0h4vVTJhJ4u4dzr7HrPOF/8CHgt1ViTAlcOxovXIHxlu3XNUOyn06x+xwbKirJOCx/aKl/rsXYwQ35UO3qY8RMcNhAk76nnv2EsYmZMq5wiShP6QTUrKnAKwYoGL5MAIws0NxkRav9NuQPOXH3LQqhDYuYCNJ9JfVD6bs/6xQA6ieMDMORqViabg5C9tuB5NoCAH4ldxyc+spAKnYypFwd1hcZR84eU+a03uAgVO+c8asVY0F1gO0/K6pV92Dz10Vp2SLu0Zf+7CP3yHEsW3sJRPjkSiHc7KFCkHSdWLmK3pKsX+8ozIlPJ6MOXkJC1LKst8DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enKrDzO6/xajuAASzjZUh8I/vjLQlCy5N3RDOrDQbm4=;
 b=5E0Pml/2JzYahhLFGBVFQmciF+0xpuhmA+z19D9opjsAr8SKDZlcLAR5GvKDiKRFyMxryDxgXOu+MUk8JuTEY/dM/qmbb2/UXFB1fj00FJQqnJqwLOJgRUBPaJyJLM9F2z8x3MkqNxQwP+oYAbHTM2p3kXF6gSjNRZyitmPUhwQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM6PR12MB3129.namprd12.prod.outlook.com (2603:10b6:5:3b::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Fri, 14 May 2021 04:50:59 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4108.035; Fri, 14 May 2021
 04:50:59 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/20] drm/amd/display: determine dp link encoding format from
 link settings
Date: Fri, 14 May 2021 12:49:52 +0800
Message-Id: <20210514045003.3069681-10-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514045003.3069681-1-stylon.wang@amd.com>
References: <20210514045003.3069681-1-stylon.wang@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Fri, 14 May 2021 04:50:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6798a904-9bca-4d13-6720-08d91693de27
X-MS-TrafficTypeDiagnostic: DM6PR12MB3129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3129F949C09F27D813AD5E5AFF509@DM6PR12MB3129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jD+SnVCFp63iKlBUOPMv0wsLJ0zvrwFZyUSrvGdKbBIGRk1OPVLngILxJZOTSyaTU1lvaKk130CBlzwj4sULffHdyHTLZHIZJz6Tljgp0F5wL9GMeRZf67SCsIKxgb6RPGDXDJdu+iLywDI6MU0uYBEuOafwrzE/2gjLkjnpFYP612CZkETwYS9cZMdjR5PjvMlR+29ukkPoNZi0ZmRbaIH+RC7qf6yDRaZjLh2Lse3OX7DolurBiqhoZ+6c5lwF8cwpWwFn9OJI7+Yzl3g2ULm/r6Un42nOpLBUj4R6RZGM6C6QrOVU7wPqAALa36EJu6UbNTO8NcbudmQNagpNhmRSwV5VdwPhh9bbrBQjmBWkg8z/VgbNotr1j1suDQfYASKfjHxiYAuVhr75rRjd1ayUJmYES0nSVUlpZnO5rNYh9J6425Y3p5EqZ5VM9KFbbV/67CMMr+9MHLwpFfjVgIdJ7NgxwTeIZanlLxqKkQNzRkdBY8vKonOer7fLwvLG0Vy7K1fBYn5ine7fRzCKK3EG/1PByAxkeFbKqWi+d8ginR4nntqucPV3OR0cFUQgrAPlUerTWIzXnfapGqEkSuW+U3LVPtMAXojypSP3Z6RAPx9hBMdJ6BeVpO+CR0aMn7Sa13ZaK7xazU9M/+iKi9FMkvWnKlejFqGUYU4MD1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(8676002)(316002)(478600001)(26005)(956004)(86362001)(54906003)(7696005)(4326008)(38350700002)(2616005)(6916009)(1076003)(44832011)(38100700002)(186003)(66556008)(66476007)(66946007)(16526019)(6486002)(6666004)(8936002)(52116002)(5660300002)(36756003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tGBnF/VNlScr9s0DlWv7XVhg32BSnj19KYwCPLy13OTL0U93s2ey2ao4WgTh?=
 =?us-ascii?Q?ad5lK4et9EYTFVTMYZyqj6ER7kKOFr77Eq+iAnAIkzWDfgxpJn4k25Eh252p?=
 =?us-ascii?Q?lisuzgO4jwJW73+L8vrkAXZg25sQn0IkZrGUw80Dk/Zx28MUrhCiTmnZjpuE?=
 =?us-ascii?Q?3KLFgQYFx8a1A8bjCHgyLG3d+nNDP8Y8BJ6MZ33MkS0YWsRuAXGz2rhoh64n?=
 =?us-ascii?Q?8w9/VDfRUrkkRqZ2kufGV9XwshKwB+prdjhUkk0SD1hS+bU0WVaa8WT/seS1?=
 =?us-ascii?Q?on4opD35xHIPNDHEGODH4/UkPsqLJIC4jSOS2U2J3lMLTmN1YbiOaE5K82hY?=
 =?us-ascii?Q?skuXK4qjp/vhxvkmu2UrS/1sxdLR2ID59FhlyTZOwgjGbZDDFVMLOBtrJY6E?=
 =?us-ascii?Q?v/hYRzgt9daZlk7KrRH91uOWN6NtBZIl8TZNGf+rWPQBkz94VFgUqvhZJzFx?=
 =?us-ascii?Q?XUkI2yaCquQrkBrrUP0fE+420WFvSTzbyuw5SqYGIcFbF7M7Mwdv9EnaYMyo?=
 =?us-ascii?Q?nMNggSNF3X/I+CFwmPY5DVb7nvmFFzxwnrK/m7vFCPmZFgszkrgOuH1GmhFl?=
 =?us-ascii?Q?wyZiSPSIOSoL7SHUkYqjl2oM6LY8dDQ0S4MA7bCjKQqIMZWYsdN7mHNmQ5Xi?=
 =?us-ascii?Q?pThyWldkeXycRBTF/Z8gGePNLvPWEz7+VRs8YmRTD7v142Xr+MrMAzOtaF7i?=
 =?us-ascii?Q?7tOHTUtRY757XGZA5PavECJ0nRH980tbKDIAfwxzsmtLn2EqDtkQSh14Z+JB?=
 =?us-ascii?Q?nRMW4DW8ruCFHa7lNQKvIkcmZZ6sJb2RBJDhNomN2+bwVsnlYUe/VA70OkUQ?=
 =?us-ascii?Q?yfqgaXfv5ongYCeFz/bpDH+T0I6UBK1WtQSNS1VAcxSQe1kyJL/kNmMZYPBh?=
 =?us-ascii?Q?W6v/r+EiVMhAE0YKVnGzrJM+1FauPWg7+58bYh5PLKxTiSNY4c6KRBqyZ+7Z?=
 =?us-ascii?Q?8A/V6WHMgXk8pjRpwU+f8XcVAX1V0MRT7kMQaAoRy9cSzugERq5IOUmn8Cx+?=
 =?us-ascii?Q?pe569jqydJhbAv5jyPjzmy+euHoDtbe5Sp+kM+ZX8VifymgVbwNdonQP4CPx?=
 =?us-ascii?Q?jwB9AxEixog3gr7mOvu0eNMOMTzS8sN0dfyGtTQq+K63g8zqpZjh3ueHbsfT?=
 =?us-ascii?Q?bQcJZGopNsbrGodj6KcAtypgi2eA+EhXqUQCOrLAlT4/qXKNSN7IpNCvv7A1?=
 =?us-ascii?Q?k8BfzpHV2zuM50vpEgqg1RLAro8+3YlVg5VFtONPBP7yqhYsNzk7HOGCj0p8?=
 =?us-ascii?Q?f6ReZC8Fx4ICfzCIf7hQlHxR984k9pe4XxKGN0CJITEam27ksoG9Nlmy90hQ?=
 =?us-ascii?Q?y6Mygc8s7DMbMY15HeN7nM47nn8SW1UYPhTXANxtJk5Agg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6798a904-9bca-4d13-6720-08d91693de27
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 04:50:59.4662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vUpFp+GoeszEaw0mgp0v05XRIpAD6VH7kRt4dAaW0lnNszg/PNtkrFlo0N/mCe31bpUOBtFQlw1QF1rt39O3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3129
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, George Shen <George.Shen@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[how]
Implement a function that determines link encoding format
based on the link settings passed in.

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 7 +++++++
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h     | 5 +++++
 drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h  | 1 +
 3 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 69d511717828..396ac89a3c0e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -4870,4 +4870,11 @@ bool is_edp_ilr_optimization_required(struct dc_link *link, struct dc_crtc_timin
 	return false;
 }
 
+enum dp_link_encoding dp_get_link_encoding_format(const struct dc_link_settings *link_settings)
+{
+	if ((link_settings->link_rate >= LINK_RATE_LOW) &&
+			(link_settings->link_rate <= LINK_RATE_HIGH3))
+		return DP_8b_10b_ENCODING;
+	return DP_UNKNOWN_ENCODING;
+}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index fcfde2e04292..1948cd9427d7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -98,6 +98,11 @@ enum dc_dp_training_pattern {
 	DP_TRAINING_PATTERN_VIDEOIDLE,
 };
 
+enum dp_link_encoding {
+	DP_UNKNOWN_ENCODING = 0,
+	DP_8b_10b_ENCODING = 1,
+};
+
 struct dc_link_settings {
 	enum dc_lane_count lane_count;
 	enum dc_link_rate link_rate;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index 428842511c03..ffc3f2c63db8 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -105,4 +105,5 @@ enum link_training_result dp_check_link_loss_status(
 		struct dc_link *link,
 		const struct link_training_settings *link_training_setting);
 
+enum dp_link_encoding dp_get_link_encoding_format(const struct dc_link_settings *link_settings);
 #endif /* __DC_LINK_DP_H__ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
