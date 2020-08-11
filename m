Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D929C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 03:36:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F064206DA
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 03:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KxIBd+pM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F064206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4EF96E06B;
	Tue, 11 Aug 2020 03:36:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA2B86E06B
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 03:36:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JH3fYyTXWEWs6uXFMMa6G7YCrLJpa6gfAuFxyYhfjBvn1gRuJ2lqhAgSbU53DT/u8EVSGASSUYUYH7lYt0UuFgYout3OWUrQyLJR1wuvdFUBAHTUri6aPwylcBV04DaPO3hfNTBGNWy/wnegYlEXZ0XMfJ2d7iQW53TfymkOx77GdplL5IcAgkiBq33RgFInUDSbFmZz+HnC5d3/mstN1Pho2Dsrn5wpRKWWSvP8zd5+qRW/NHPOD90onx72o3ByT6hHNQe46WJDmcZfIISLRwKS6rWX/6GWVsTbTynIppC7/n2KaMaURDXzVNzd8TYq6aDyNXPK3XJaPtqqjn/T5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2ECVEOmtuUJqso/Aj2DHair9KVRQipPLcJN5wJC980=;
 b=bd1LYux2eJ3YMLkW1xOLHarVvyrkqIOoa1M8T4RQJivTGorNdXYbbPRTbbUzuHL42qRdjegJlztGwJJ6XSATEZn8+wNxWw2AsctR9zlsUFos9xw9ix5GQ6fQlwR7voFDNZHvyaYGAWDm+i4D4UoyNmxGGtCduTZR0XPQmY67cUmCj8GCMWDciryF2ANF+e9DF1qgoNyWptl7zj618GcI2vBTHNPJIp5PS4aUhmb+TFFq8Vo5CQUk1kzLJQjMDF5R+5RABpQf1Y/VqTWVFHqFzz7XTgXMJ9kZyzz+0aeEEIYGJQSiwO2bdO0y/Ij5fENVEiHaUQct6ncrLolfP+n+xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2ECVEOmtuUJqso/Aj2DHair9KVRQipPLcJN5wJC980=;
 b=KxIBd+pMM7c8LtjyOH5sBw9fiYyjkbTx1N6HKcFxI25SjCN8GOAZA+P+lo1OlGpmwq9dw8Nh0wkRYNyPohSAdnsSA6XA41mlKEFRHT24PBdB4ghVh9IzzLpHrsPcrcxFttq1uF5L5cwA30YTw4KymAXVlHI+8vgV9RB82RWg+4c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2891.namprd12.prod.outlook.com (2603:10b6:5:188::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.18; Tue, 11 Aug 2020 03:36:15 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3261.022; Tue, 11 Aug 2020
 03:36:15 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/powerplay: update the metrics table cache
 interval as 1ms
Date: Tue, 11 Aug 2020 11:35:55 +0800
Message-Id: <20200811033556.1004-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HKAPR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:203:c8::9) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HKAPR03CA0004.apcprd03.prod.outlook.com (2603:1096:203:c8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.5 via Frontend Transport; Tue, 11 Aug 2020 03:36:13 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4454fa14-46e8-4ddc-6bd9-08d83da7b348
X-MS-TrafficTypeDiagnostic: DM6PR12MB2891:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB289151CCB98F3739C0311FC3E4450@DM6PR12MB2891.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H/ldEBidwDI3xsWnS9zXxYIzyS/cUPZt54+oMrv9/vUAUwSGteip9QQX8+B8nWHN2Zzp+pVxxuyM+PTiAznp8dQCBUDEa417zF44wDE0twn5gcii9HQr+II4cj8qUTLf6Wb6TzUAuo9euHBd9BD8h3X7uMotLpbGEr5lLo3iSKeNzEDqBEyvabVfII8DW2ATxkQ52JJ4NCYOB6j+UR8Aq/iwbbASvzdNkKitdC9alkgk1PNrecpeXxFJK+TIA3MnreUtMjy56jwFwErm6v9ICsWyUNyE4pjfuKEVvihY0OqcaIqcJu1hCUhigLbSUuVxZgBNKlvaZvXxIaap4vs41g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(8676002)(19627235002)(16526019)(186003)(26005)(36756003)(478600001)(956004)(83380400001)(5660300002)(2616005)(52116002)(8936002)(7696005)(4326008)(44832011)(6486002)(316002)(1076003)(86362001)(6666004)(66946007)(66556008)(66476007)(6916009)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: aK/cdPlab8cRGlL7QDjO7GwIJeA9VC14Z6rj44nDaE+86TQPM+yvL9YW0jHrMsR+XWljzsWxHZ6T5RdObhR2gjb0/Dpd3S+WyQoeQNFkXHMUt3gqwitITzeBSJg8qpldAME0WIPkwAqBl9sNSEr2sG3rfd1LB0TMkkB/4tlZi+n7v/A/04uSh1WK1A89X2a7xP422BRx/g0wVgBV1go6rAFRN2aM0D3RAyxJpsRPkM9EsNchYsquPnvnW6bL8/OCcOxo9lSEd+vhAckCQrPxTkF4z7AsF7wlyD8/nB/xKkdyTdHAYBv/F8r1K1tu8yYy82XH+qeNipGpRc6pdoCrI9UQ9fFixt5/Vp12HmprApaXy2GYPoj343Az5elVzeLjSScj6GXiscIVedqXhCVfbmcBPFbQ22Q+sa9bsOrMwop4i2+qqK7FlHBO3H+Z/qPbWISvbeuO7hN7gXK+67+9pzqEQoaz+ImvYvu6FIn8is1EktL9q9Yca1Kw+a1PHFLxgU4uDa8M7w8DHRpvEmlmSIp0RxnqT/p1B027VIoqnf+vdvMxqgv+rmT5nOqRoBIBzGr1BTZVS4atfjsmmNbP5ayaoDj5ZL6L0qGc8IGRZtzCyZBxMcNCMMob/HqsvEeaPc81JqYUJ0Gq74fSU8AA2w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4454fa14-46e8-4ddc-6bd9-08d83da7b348
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 03:36:15.2314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUXlCx1yQhMZja3Niz8sCeesrgI+adAburKtl7r/yOSnhtNaUuKSENRtJeM1o0mO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To make the setting same as Arcturus/Navi1x/Sienna_Cichlid.

Change-Id: I7ea721bf5872023f1ab39c3827fb9c6fd05877cc
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 2 +-
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
index c70c30175801..f0680dd58508 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
@@ -1272,7 +1272,7 @@ static int vega12_get_metrics_table(struct pp_hwmgr *hwmgr,
 
 	if (bypass_cache ||
 	    !data->metrics_time ||
-	    time_after(jiffies, data->metrics_time + HZ / 2)) {
+	    time_after(jiffies, data->metrics_time + msecs_to_jiffies(1))) {
 		ret = smum_smc_table_manager(hwmgr,
 					     (uint8_t *)(&data->metrics_table),
 					     TABLE_SMU_METRICS,
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index c9f402edc0d6..da84012b7fd5 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
@@ -2082,7 +2082,7 @@ static int vega20_get_metrics_table(struct pp_hwmgr *hwmgr,
 
 	if (bypass_cache ||
 	    !data->metrics_time ||
-	    time_after(jiffies, data->metrics_time + HZ / 2)) {
+	    time_after(jiffies, data->metrics_time + msecs_to_jiffies(1))) {
 		ret = smum_smc_table_manager(hwmgr,
 					     (uint8_t *)(&data->metrics_table),
 					     TABLE_SMU_METRICS,
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 8a8e6033f71f..c50c4547fea9 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -139,7 +139,7 @@ static int renoir_get_metrics_table(struct smu_context *smu,
 
 	if (bypass_cache ||
 	    !smu_table->metrics_time ||
-	    time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(100))) {
+	    time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
 		ret = smu_cmn_update_table(smu, SMU_TABLE_SMU_METRICS, 0,
 				(void *)smu_table->metrics_table, false);
 		if (ret) {
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
