Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFEAC433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A0E761456
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A0E761456
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26ACD6EE40;
	Fri,  7 May 2021 14:59:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4D8F6EE40
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 14:59:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhF+03xvc3wuL57QQTEwXRcwd55keU7CnGzdIN0gmqTwtpf/UFvWTC3ufXlHu3mQmXgJU/c335mLhdRfIHrmM4CUT28oHzBmelyu8WJIV9UBhcxe4ymPt23HfjTfkFKuReaQXOEMEEbVZ1lKWG01xBDhi54eCXYH4NSmpLlOiZF/y2kyIOHA74dq/BALht/mOy3XDsrFM/XMJkKvJLESq/pCpd95dH6LHB0RZfXQ/plUqA5dDIBuSWbDC3GfROdkw5H/OpYxNcea/zmSSwvlSNH+oxAA6MobqZ+B8c4+7OSvLSWew9iSJbBymJfm3iwYwx1ilfr4CzWnHp4QJ676Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjqWZoAUWSOvJzIKHQEwuSCzIpl900psNvPQnNzuHyI=;
 b=cnw77sD3eLKjntILoCyXQqjMaOFhhxD3S4r8PUb25VGZit1uCD2ONwKw5ugsfJlB51C6nAbARXk5fmAKeUUb9koZ39VJ53FiAdwpEBmPNOrbLqZBg8i+erwACC0aK9FSCqQE09fPQSjCZQDBmrvAHYEoAQaZANleAOWwmK474gFmE+nxzCSpr0ZyCYY2tf8XMpGJJRIzNtwJamwWOU2hSKbNxjUZ0wlKH7dxNEHOKaBKStem9hGyKpkQb7EId6JLstNxSJT/kOaCbXKG5mXJcNM1sdoGdz74ehF0ehgoRw9EvWBcFSsfdSAahnUTji4CrcKinIMN4ortU42JaYAJlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjqWZoAUWSOvJzIKHQEwuSCzIpl900psNvPQnNzuHyI=;
 b=YzY7sQ2pUPMJEFMB2hgyWbYezEXRN0xpz8qm1G12Rh9TMTT6xXxhp3k4KBvI3pk3ej7o1NY6f1OQfffTxaGqUjNTtrIa/VNd8HZjhgtyntre5o09/sofbmiDluXLbw38uAk8Jy4tHBxan3f5DaLgZCER9LK3hkWo0ZTFYWWdBjs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM5PR12MB1786.namprd12.prod.outlook.com (2603:10b6:3:112::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Fri, 7 May 2021 14:59:01 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4087.044; Fri, 7 May 2021
 14:59:01 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/14] drm/amd/display: Update DPRX detection.
Date: Fri,  7 May 2021 22:58:09 +0800
Message-Id: <20210507145822.248029-2-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210507145822.248029-1-stylon.wang@amd.com>
References: <20210507145822.248029-1-stylon.wang@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR04CA0045.apcprd04.prod.outlook.com
 (2603:1096:202:14::13) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR04CA0045.apcprd04.prod.outlook.com (2603:1096:202:14::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 14:58:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70e18ae2-620f-4227-a58e-08d91168a633
X-MS-TrafficTypeDiagnostic: DM5PR12MB1786:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB178670A5DC03985A3BAE7F98FF579@DM5PR12MB1786.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +LPdUEC84nB6/Y3kE0htNCEsvqzG2J3rfYGswCcJ0ugZF4ROPrSCK2HazhDMIZTLIEHo+y5++Dl+rvH2+1KgmEBldgE0+jFIkkM6RdFSCqzbkgxa3Zlz/AWMR56gwhrtU8q/yUnorBXIVgQ0wYf+PPdabUr/gNMn/RaGDbVx6wofzAQm5x7ytO45LoAf4oZCdgNw3gCbESpzXwBv1lVw0UeJMR18OM6XSMN6LxdsEQ7eIZzAGz3pYfU+xvgzF6Tm8pyYzEQ3EM2KKQVk4Tsc5Ta0o2b50TqVUdWMCNksloK2aTNQG4q0ktdOBwbyowbzYFYJBQ9K0nydRVrsNh4NfiXuoQP+omGNlpdoMH1rgqYukFimZbRQBbrMNSLTidCjOtfe3St6sfcynq/IzaBgrwpZOFZSkxKsBua3bEZSP/lago3JRZI7sKUNMPwWwrkx0FiL+zmTyz3KSMLSWlg21x6plieQuIQaJdba7mlgud4wxhf7BWxLfRUdzxbWtNj+JHf+RnKZYQFIas8gxcfHqvignxy2oJloniHJ+jmwX74chLqCwWz10Kv7X6zUpaoNxh3MRLQzqq7dymzj+sTcal41M+jYu8iwCrSF+je76hHs1LItEyR3Q9id2wATdXZ6NIFxwL1lGKnvXhmvHaeL1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(66556008)(66476007)(66946007)(6486002)(54906003)(83380400001)(26005)(6666004)(16526019)(86362001)(956004)(38350700002)(38100700002)(316002)(4326008)(186003)(478600001)(2906002)(6916009)(5660300002)(52116002)(7696005)(8936002)(1076003)(8676002)(36756003)(2616005)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SVWa3j44hIsdE4z3njJpKUz+s3YA1XFq6FAM+/w8fyWD0iXC+sApIjh+VMEf?=
 =?us-ascii?Q?p5SoZOPxNeZxBtfdFMb6CPROIOdNvuiYeaF7mGVyTeGC+T9StIY4+dgrPsLf?=
 =?us-ascii?Q?4H1F3jQqiix0A7tJKYehhW32vh3KtUi6/jyozqAFchcSMiGJnsL+W8NvayBQ?=
 =?us-ascii?Q?WBYDQmuw6zrsAsKYNRycvweoKPErqb6qW3li26UEqqDZ1U4MaMkYYq5XYuGB?=
 =?us-ascii?Q?sRacKwxMQpRE3VWmWOOsubLqOndwEW+JsARedSZ2Q5ts3UuHXyesA2R8ceyY?=
 =?us-ascii?Q?QKB/cWNf/N5nll1SRWKjrhHlVdyyXD5uOUFXb0CGqjLl+5COg6XZ3wCdiVgL?=
 =?us-ascii?Q?EoH51hQaQCJ/VNNpeTM9r6ciFy16uqKbLBPXXUSZRW+z7wXBdG8Ht7+PYhia?=
 =?us-ascii?Q?OzLaHm1mppjtjgP+weJb5xdpE9OzvHk1mgALtzkEPVbTXuypm7fV5OqIOmK+?=
 =?us-ascii?Q?W/qeKKhpNE4CZ2kl6NHD0kDa8CZQk2pBTQ++8e5B9O6kgV6+H8bzG4Rp1MX3?=
 =?us-ascii?Q?1gOpnR3tq5yPbgV/aISIqZG3zOTeHeYSgcha0JblnwErl+8/PP22EBaxBRm4?=
 =?us-ascii?Q?i/+Bg1pM2p7rXSBg1bxyukG5Rn/PDbCBP+KzvU1wkirl6QJ4QKYnbtkZe7Vv?=
 =?us-ascii?Q?rRHqnQaPeIncSlTr05/8rfgvvHzxqOm27Y24w6Ncz2zs7jhr4qA9oFe+GjX5?=
 =?us-ascii?Q?RBmIEHT5PDNFM0Qd3ciY49Oq3c8f+VY+hZGr4GeOvOhppRhsk52e7RFodKha?=
 =?us-ascii?Q?tKrCZ6w0sAGsHfczEu550pNccEiTerMpDWw7cxSDk+2looiigU6fDvmJT5ms?=
 =?us-ascii?Q?0DAZtqOmk9X3313G1H4LrlI7S8nFGJIvZVonj7ZIbh8oPxiHcs3+o8Ou5H2o?=
 =?us-ascii?Q?9CMw5pPccyBQ8zZ6vVjoWiRnpUoj4FYvu0FNCSons7mKzPSNx7O3GwHmJPm8?=
 =?us-ascii?Q?zk51MU1aHxq4asFO7tGcLzl60hroj/WMAY1X/SHXfbFkYaY+GSRBpX8adGW8?=
 =?us-ascii?Q?tfqZBBWPAqS0yrED98EoBoqopqwZu0ZjRE+GQuxmSJsU/LXtRgsLPUS9fSgj?=
 =?us-ascii?Q?7471sKlXBepoO7GpyYSCjvDNh5+tmzG/ietU5yJZ7XHCFHBJpDATKaxMYzmS?=
 =?us-ascii?Q?NQlJ28YHJQRNKhdUU4uTKpFtALiU6+i57+UN/ydqrvvqwCO10o0TsHMnN8Zf?=
 =?us-ascii?Q?MFUdN690AWCSRH+DcK5oJ4/DcXCGeVVcWGLBF5SnfwfbPA1S+rUUOK6lHhWl?=
 =?us-ascii?Q?7VtybbPVIiT3ctjVwgFl1X4y5DOfw2kV3oAoJo6OoxgZWArToYZ1ktcCu6Xo?=
 =?us-ascii?Q?UnWgdUAz5U5H+LFDxVikVv27?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e18ae2-620f-4227-a58e-08d91168a633
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 14:59:01.3778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfzoMtLH/E+Nsnw/Jmat+9nhOIEpS3GdOJKLEpWSsk1QOmYH3ktD3IXjKWzEGIBgx7PJBBtiGkh5R6jkewIWpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1786
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
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com,
 Jimmy Kizito <Jimmy.Kizito@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
Some extra provisions are required during DPRX detection for links which
lack physical HPD and AUX/DDC pins.

[How]
Avoid attempting to access nonexistent physical pins during DPRX
detection.

Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 27 ++++++++++++++++---
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 3fb0cebd6938..a2e7747ee387 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -247,6 +247,16 @@ bool dc_link_detect_sink(struct dc_link *link, enum dc_connection_type *type)
 		link->dc->hwss.edp_wait_for_hpd_ready(link, true);
 	}
 
+	/* Link may not have physical HPD pin. */
+	if (link->ep_type != DISPLAY_ENDPOINT_PHY) {
+		if (link->hpd_status)
+			*type = dc_connection_single;
+		else
+			*type = dc_connection_none;
+
+		return true;
+	}
+
 	/* todo: may need to lock gpio access */
 	hpd_pin = get_hpd_gpio(link->ctx->dc_bios, link->link_id,
 			       link->ctx->gpio_service);
@@ -432,8 +442,18 @@ bool dc_link_is_dp_sink_present(struct dc_link *link)
 static enum signal_type link_detect_sink(struct dc_link *link,
 					 enum dc_detect_reason reason)
 {
-	enum signal_type result = get_basic_signal_type(link->link_enc->id,
-							link->link_id);
+	enum signal_type result;
+	struct graphics_object_id enc_id;
+
+	if (link->is_dig_mapping_flexible)
+		enc_id = (struct graphics_object_id){.id = ENCODER_ID_UNKNOWN};
+	else
+		enc_id = link->link_enc->id;
+	result = get_basic_signal_type(enc_id, link->link_id);
+
+	/* Use basic signal type for link without physical connector. */
+	if (link->ep_type != DISPLAY_ENDPOINT_PHY)
+		return result;
 
 	/* Internal digital encoder will detect only dongles
 	 * that require digital signal
@@ -955,7 +975,8 @@ static bool dc_link_detect_helper(struct dc_link *link,
 
 		case SIGNAL_TYPE_DISPLAY_PORT: {
 			/* wa HPD high coming too early*/
-			if (link->link_enc->features.flags.bits.DP_IS_USB_C == 1) {
+			if (link->ep_type == DISPLAY_ENDPOINT_PHY &&
+			    link->link_enc->features.flags.bits.DP_IS_USB_C == 1) {
 				/* if alt mode times out, return false */
 				if (!wait_for_entering_dp_alt_mode(link))
 					return false;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index fc5622ffec3d..5196df1ebad1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -113,6 +113,7 @@ struct dc_link {
 	/* TODO: Rename. Flag an endpoint as having a programmable mapping to a
 	 * DIG encoder. */
 	bool is_dig_mapping_flexible;
+	bool hpd_status; /* HPD status of link without physical HPD pin. */
 
 	bool edp_sink_present;
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
