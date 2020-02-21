Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23728C35658
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED9102067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TorS28i8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9102067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 478986F4A4;
	Fri, 21 Feb 2020 16:03:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76CFA6F4A0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:03:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CR5bVTroHiOY6uHqfmoI4PNIPPYbkRZZD3snr8Yfp90KyLOFJT0jWPmY3/R70ypMAozs7etqxAUDw7UWyYnnzHLmshVbWhOWGMlxmGdleKbX0Rdbind/52HdbmI0Lv9Ms8RpqxuZ+yh0Tr/eCe2ruKSNW1aHn5pFq/z+EQm2zmfGWtNQOtM96pz1IjLTL8irQhqV9aglzEVsf2Ij60onENvByfB3vTVfWJGK9Js1lL89vXcsms347ZygA+bBU5M2cwIXsACszS94+ygOnindSz2Xf9MGg9qOGDFPq0JFdvQVxZx8eC20dxy3uywLmYJj+yrZSGBl3VAEeXoTkyZC3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnzgZZiydK3zQ+6dzxk6KAnJqwNiIWWk+21/CGFOdE4=;
 b=PcG+ZmBtCjf0X/sCOKrNkHP5V/d/UN408EzxoKURrevEisC3dYSDeSmGIfCGneOJEyPxukN1uLZjFLdwpykDiuAcNWq53a0mmudf++lJeDKVkQESU0Y++5l9z/dFuplew3Mn82oL16VIm2Isxv/C49TyLkX0B30BqKskWnV2pOsgmWfpRmZ5JphY6donA9QyiBQXr0yDBGiwZOYJBgQWgFOd8hyCIznfuRx7B99t6pwkYVvqbIeqn45HUVlvkeZRx7yW6N8ZIMVWKPaR0gmDSjMbDawqWFBfASbqpUXM5xE2wos6mtqavT2X/3QQHTiyvXlN1uu7OEWODjrNngS1RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnzgZZiydK3zQ+6dzxk6KAnJqwNiIWWk+21/CGFOdE4=;
 b=TorS28i8rsPfoE4M1iDYBAEKK2lrPa62lKmKW1Z6b7sdbqEfFwvxJqb93+uQKBQAJM6k2jRTw8BeZnjSbKNSRoDVzRKZqtMtNWiLrnBHrJ+7f+RenPDhw9uahIa3aTDH632wYGdtweIVix5RM3XQEONyl5lfeoJRzd9Q/tOMTDk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:03:55 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:03:55 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/35] drm/amd/display: System crashes when add_ptb_to_table()
 gets called
Date: Fri, 21 Feb 2020 11:03:00 -0500
Message-Id: <20200221160324.2969975-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:03:53 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: edaf92bb-d7dc-433c-a988-08d7b6e7a632
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2572330D88DEC8E9AB4364B898120@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(1076003)(5660300002)(36756003)(2906002)(8936002)(86362001)(8676002)(6486002)(81156014)(81166006)(7696005)(52116002)(4326008)(6666004)(316002)(186003)(26005)(6916009)(16526019)(54906003)(2616005)(66476007)(66556008)(66946007)(956004)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jfuHHUPnHi/cZb1JxEfcJAqY+KFLvruZj4RIt3LBfqUzws/UjEYpN08eqk0cPPd3/jkJhYGlLPKtbRkSU66UvsxVDJVlrvnPN6XX+B/qMmuIdfTfikMmAD150+uU3ViFIjfuc36KAb1zmVG3suoADzYh5POAzZlvMyEAvPwpxOTS77rxMHE95DaRYIwmmkMw6Du1Y/2xjrmUVFRFhsehtFd1oDKXan6EbN36a60+N8DQdiniTnoWUZChjYK4BAtBnDNITXG95ltTnWNvWekXLJopoYJ0344Bw6U9XxUctwX8qMcEBylbWZTMZTNCQMdgMsM/ULaoDpPRgAZY2Y21QAzSqvZoVIwS+Tq03VLzEWtYuuM2O0EzS2/eN3MuQO4aKWtyZakABsCnz1OzeSqZb4Ou/ussU9ahzA60+/YOvh48T3E+9X14E9BuH9i752uW
X-MS-Exchange-AntiSpam-MessageData: Ha/GDD8aor7Oc3q39K5hwrvhf/9StcypgTA04l2PXzZSqnRPtSE1yLvBlqDC58jl9udNkyQO8JDZnKUrDWnxhq7GLeO8vo0RwKLGI6GJiLopwPhaqnb5b9xhuNDw8EiZdoK+OwynrWuEzUd5IhHp2g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edaf92bb-d7dc-433c-a988-08d7b6e7a632
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:03:54.0581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2Rm3mxKp5vaZZDiU2rSNiiIe+jp2m52WWldVyoKq25aIrXJbAQKBpUywVgce82HpEJyf3uCyyiPlvREipRXYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, Rodrigo.Siqueira@amd.com,
 Peikang Zhang <peikang.zhang@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Peikang Zhang <peikang.zhang@amd.com>

[Why]
Unused VMIDs were not evicted correctly

[How]
1. evict_vmids() logic was fixed;
2. Added boundary check for add_ptb_to_table() and
   clear_entry_from_vmid_table() to avoid crash caused by array out of
   boundary;
3. For mod_vmid_get_for_ptb(), vimd is changed from unsigned to signed
   due to vimd is signed.

Signed-off-by: Peikang Zhang <peikang.zhang@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/modules/vmid/vmid.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/vmid/vmid.c b/drivers/gpu/drm/amd/display/modules/vmid/vmid.c
index f0a153704f6e..00f132f8ad55 100644
--- a/drivers/gpu/drm/amd/display/modules/vmid/vmid.c
+++ b/drivers/gpu/drm/amd/display/modules/vmid/vmid.c
@@ -40,14 +40,18 @@ struct core_vmid {
 
 static void add_ptb_to_table(struct core_vmid *core_vmid, unsigned int vmid, uint64_t ptb)
 {
-	core_vmid->ptb_assigned_to_vmid[vmid] = ptb;
-	core_vmid->num_vmids_available--;
+	if (vmid < MAX_VMID) {
+		core_vmid->ptb_assigned_to_vmid[vmid] = ptb;
+		core_vmid->num_vmids_available--;
+	}
 }
 
 static void clear_entry_from_vmid_table(struct core_vmid *core_vmid, unsigned int vmid)
 {
-	core_vmid->ptb_assigned_to_vmid[vmid] = 0;
-	core_vmid->num_vmids_available++;
+	if (vmid < MAX_VMID) {
+		core_vmid->ptb_assigned_to_vmid[vmid] = 0;
+		core_vmid->num_vmids_available++;
+	}
 }
 
 static void evict_vmids(struct core_vmid *core_vmid)
@@ -57,7 +61,7 @@ static void evict_vmids(struct core_vmid *core_vmid)
 
 	// At this point any positions with value 0 are unused vmids, evict them
 	for (i = 1; i < core_vmid->num_vmid; i++) {
-		if (ord & (1u << i))
+		if (!(ord & (1u << i)))
 			clear_entry_from_vmid_table(core_vmid, i);
 	}
 }
@@ -91,7 +95,7 @@ static int get_next_available_vmid(struct core_vmid *core_vmid)
 uint8_t mod_vmid_get_for_ptb(struct mod_vmid *mod_vmid, uint64_t ptb)
 {
 	struct core_vmid *core_vmid = MOD_VMID_TO_CORE(mod_vmid);
-	unsigned int vmid = 0;
+	int vmid = 0;
 
 	// Physical address gets vmid 0
 	if (ptb == 0)
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
