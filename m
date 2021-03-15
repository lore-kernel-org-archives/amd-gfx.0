Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B84C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:22:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD5D64E61
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD5D64E61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEF25899EA;
	Mon, 15 Mar 2021 11:22:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55733899EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 11:22:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2jwpuGi1UCAjGr/XCILOYYuz+wf/uDeU2QELNi5loNvZaEU2KjsTCGTxJEmCJMYVXFf9/ST5X+DM0WAulKoER4QlnKtY1y1bFM6hXmRClCCNg4vsz/rsS38auaQSvXoO0uB18OUHmpMGMPFxdaPofQ3/5rfbGNUtADalTfIuLEl1z2MK58db/fxHA57nF2ci8K85ggx07Vi/UHAL0TV9kcAyooo4pJO2lljo/B8IWY1r0qgQ2cbU05OeJDkgw4gC19iXF9OazKEEi5yYtSZruaOmrOdhaXglfaUXFP9FUj0ykC4McwA1namEs/stpQRZJ5SwGHPJwcVS3cxTwH0Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+oSMJkD2p4JgN145PRn/CCRpCZOb6D8zsPfQdqfy84=;
 b=NIvCaxGaZFXXLPipVmbu8w+5dcunD89DsQ7OAhYXuPjX65RhP/L3RaOOK7ZoTcxGIKerCyeDMjdPU3ps1e0s0LxnlFmOcU2l5y4JywgLMg4Y5eKCHxqYNRsX5PtFaFFaBtOHlevrMH9WSF7UNVCOwQy3wVaDkAP+2kmqcY/KkvpU+CtzEufjFssAcjNz22kkOzbW2Q5NyK2gFhj6GSXHWxrLhN/82rvi8nP7DIA5lWBjV9X+KcTzO+73KBb1gBUM7FncmATq36kZ1TbpPaSWf1q/M27JtjyRlpeLlpq0DoPyghfW3jor3iJz9suJKMle/wskuu0r5vAEEb2viAgxxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+oSMJkD2p4JgN145PRn/CCRpCZOb6D8zsPfQdqfy84=;
 b=gyCyv2szycONuf4f9TJY09b9ZU00RzjKzpO+LcAhaOK42WOuhZeSVtB/yR/Qp54e8vPqpWc/yyLP4hUAFRPdOT7MRFDnwYG4QUtVGYyXDRq8m0OGFUYxgH3ynD/GAiMSehD1ffyFP49tqi4JLmv8CITEC/KHy48CSVjlYia+9bA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) by
 DM6PR12MB4617.namprd12.prod.outlook.com (2603:10b6:5:35::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 11:22:45 +0000
Received: from DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7]) by DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:22:45 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/23] drm/amd/display: Bypass sink detect when there are no
 eDPs connected
Date: Mon, 15 Mar 2021 09:39:54 +0800
Message-Id: <20210315014010.16238-8-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210315014010.16238-1-solomon.chiu@amd.com>
References: <20210315014010.16238-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::12) To DM6PR12MB2604.namprd12.prod.outlook.com
 (2603:10b6:5:4d::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.2 via Frontend Transport; Mon, 15 Mar 2021 11:22:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d6732689-407e-464f-4f0d-08d8e7a4a80c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4617:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB461781862F81B2C52AE95676976C9@DM6PR12MB4617.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Yi2NE5evq0WaoD+2jxA1gO6hfpmgo8V1K5n+pse+QgjezN+iNH/EiYY84nzdBR41lG/OqtfpnvzI7KANQ9nzGPjTMJ/z0/7OY39dbn2q1g5B6mC5knzXceFCG+w1Y1QmmRLbSxr1sKs4cW2A35YVICI9p/atvkMK8DaLrY1cAXeGuRbdTSlUd7P5BhTPU2qTr3GXsST8FtjSuZ4dNah0t6oyW6J4Rhd55CvrqQhwC63vH6bvVjS+UAyT83mFVxPHJOkdNKA6zRNrxzN8kFYHrzXnub7EntKIVo1gVUT4KbulnU5eVkzKztpIFhMQCDKrfV5suY5AvipbG5/QaalK6DlZ8llYw+nW+3OubQPxeuNPAeaCTsnP9quV6vtwWYao8/PhaIoUUriU0TMHSeaPT8htmKRWxUR93A0SnPJiGUJaWVOQRI1+itEPVwceVz/195QVhY0j2bGYHRtRhL/D+q45TTpIZutQQ6RV8tXvuj0rpnAfIBn8zWMvhR4krAdW4bzxWsycOpfsCoh6UrZ9Y84K1ShB3MwqTn1VGXEVA0yoTQFFl3PTf++FSpfzcfQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2604.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(8676002)(6666004)(54906003)(8936002)(52116002)(4326008)(86362001)(5660300002)(316002)(186003)(16526019)(26005)(83380400001)(2616005)(2906002)(6486002)(6512007)(66946007)(66556008)(36756003)(6916009)(956004)(44832011)(66476007)(6506007)(478600001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bs+/euS73cCDfHPTthYYlJAWlm5v+buRaAgfH1nBLMGIcph10sYUPyh9bnlt?=
 =?us-ascii?Q?infZ9gODNPTi9Sgj2IgHmE6iHLbh22c8UVGkw6mU44kzmt4+aPvy5Wcth4V+?=
 =?us-ascii?Q?2ORLfOONKVbhgw2uI1W+BZsxG45yhF7xcdFOyzZ6kuB2Bvhh8VtT383YopE/?=
 =?us-ascii?Q?15OturEx2+3jfZ52nTQiKgRBaI9/vuRidUTd6YzssvlbzyuOpyvn+zbCiM41?=
 =?us-ascii?Q?mcwsr1gdgybkNNECjSJy4sDkoPv2EcmyzwTVkX447oYX10Bc/ggQKYR2FPyG?=
 =?us-ascii?Q?cpTrMmNlKNwjk3rXcQJ+YgT3b9zOKJY7bDtwI2yfNMsOf5bMdHffTiXDWuLv?=
 =?us-ascii?Q?CiHQelZcAFAgxujrjTZCq28NWpp2GgWhENSdKYrxkef5Hc+mnfA7cRQWTjSs?=
 =?us-ascii?Q?k7NUZI1YJiKbVH+hhxmyVkUmScyxDPbwFWMViQ0RWe699/3J+k2GJNi7ombE?=
 =?us-ascii?Q?4lrxUEY/FNRGgCijsupAhpGpSvH0P59AcnybyIMJy33fBT3oW6h1uXJIpT1k?=
 =?us-ascii?Q?kERoHdGcvUQ9SaYJDn5dYo0GKd6YpdNIbsl7VN7wXilR3EzoEU2dC1QDYFJg?=
 =?us-ascii?Q?WOfDpSZgpMATA6ezK+ys7FD83UOwDFZAl7YlicYBHcS04urufqVRaRRMRPAt?=
 =?us-ascii?Q?C3oUEB55nfeoYMcPZycTRDbr/E/LjUWL+FDTi4QC6i9FiLjbhthvHBzW6pyX?=
 =?us-ascii?Q?P00AqmqOqT2CNg8vbBnBfzpUbKmfeQ5lAlJ++m7GwPEXnCoSp/m5ve5aD9ln?=
 =?us-ascii?Q?ASGRWQohjglcD1THXVyo004F4hWLCpzB8ES1V/EAhXxYVVFYJ4HyUKXSaeWc?=
 =?us-ascii?Q?X9K0RBvbcXimxYK+8YiEEI1pczIdTfcD9lpFdjJWIPoBaX5l3OmVU7bsR3fr?=
 =?us-ascii?Q?pQmpjuO+hFbEY+qplM6XANIwWO0tm2B7cU9OsGkjIQ1VHenF182yU2h1+tA0?=
 =?us-ascii?Q?h3kfFjFdA7P0S9jtn3NVOOwRintssuy19bE8d0LL9xiWxfdLPki3keN0CPNL?=
 =?us-ascii?Q?OZ6METcZ8K/GhVoc4DajIasYORmzP9s3QInJ6jT6YuzuPruEIxtkZ3+pOrua?=
 =?us-ascii?Q?vEPDeaJZgXuMVVXDh3KFts7c0NTcwOImFQd6Tf1BDTR/ygnRQtHZT0SVd/D7?=
 =?us-ascii?Q?l//dijEKWmJ3XWtuteGb5oTXoxa/8oG77pj0im9Mj+isOALJA8l1Cd43i2jr?=
 =?us-ascii?Q?jJXsaCXz0OoUmIVgoG4RSa9agNMXgoERi5N9RDdj8fMpq0Pbw0YKxIlUliUI?=
 =?us-ascii?Q?6ydKG5VNIuwbh0oHLh90aEDmj636gvJPFBgfWIQvagY8gW4R9TN3YkjVcjVe?=
 =?us-ascii?Q?mvgKZOuGNHW/F4ro5gJLO0AbmokmkYFw8Eo+QiytKozfDw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6732689-407e-464f-4f0d-08d8e7a4a80c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 11:22:45.5545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGpsKLEGym9rVc1TJPOIiJOGVYtENFCaGPjl7TSCResMhBotn5GraUseyDwu387jmj1ovffSZ+qKrcgPuaybNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4617
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
Cc: Eryk.Brol@amd.com, Jake Wang <haonan.wang2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Solomon Chiu <solomon.chiu@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jake Wang <haonan.wang2@amd.com>

[How & Why]
Check DC config to determine if there are any eDPs connected. If there
are no eDPs connected, bypass sink detect when querying eDP presence.

Signed-off-by: Jake Wang <haonan.wang2@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 3dc49964ea7f..dffd150180ec 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1096,20 +1096,19 @@ static void detect_edp_presence(struct dc *dc)
 {
 	struct dc_link *edp_links[MAX_NUM_EDP];
 	struct dc_link *edp_link = NULL;
+	enum dc_connection_type type;
 	int i;
 	int edp_num;
-	bool edp_sink_present = true;
 
 	get_edp_links(dc, edp_links, &edp_num);
 	if (!edp_num)
 		return;
 
-	if (dc->config.edp_not_connected) {
-			edp_sink_present = false;
-	} else {
-		enum dc_connection_type type;
-		for (i = 0; i < edp_num; i++) {
-			edp_link = edp_links[i];
+	for (i = 0; i < edp_num; i++) {
+		edp_link = edp_links[i];
+		if (dc->config.edp_not_connected) {
+			edp_link->edp_sink_present = false;
+		} else {
 			dc_link_detect_sink(edp_link, &type);
 			edp_link->edp_sink_present = (type != dc_connection_none);
 		}
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
