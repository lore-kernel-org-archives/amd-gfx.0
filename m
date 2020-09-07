Return-Path: <SRS0=05a7=CQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320A2C43461
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2020 09:01:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B306F208C7
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2020 09:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="my69akkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B306F208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33DEF6E3FB;
	Mon,  7 Sep 2020 09:01:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FC736E3FB
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2020 09:01:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUO5idN8yEQGH2mwpUkJcUsU/xIWHa8QkveRU6xd9ZcPexKAoFd/ycamg7swcZh+efWUaEwANeb63NT907m9ZrcTSuXtXK+Kzv9TSZ0cvF84yc9V7E9ZacGivObMUI1aEn+jcFN5r6XXhgYYfs6EbVvGL0iyPWnR+2utXH/pTk82jPlap8IgXiWtHvT0/j1Rb2++4tHerMBfNOcIbj3o6yAg9O+YObDP83qDFSzUe4DVqYh4+j/xfCrj6DVb0WNBugE4x8k6amBznCAN6OuzS7BD9yhrorxIOlTMyExUyeuJZp9H/3h6+V9j6V5jjzUAfD4X0KTRBRExUla2MR65Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nz1m2vGkaINZHM0HUien09C8VPs64kiNiDuCCFLmG+k=;
 b=NmOgzTmpSmqmQdqWnNRAImbtZekco4xq422BlVGvGYpjg9XYTd9TFpdatA+yWEOZaXUVQ6oyGo8l1qyazh78+EbBtwf9emdAX1ON3O/bn7QN5oU68dL3ebWhQYyMnKUFGCOs3r28XPiBq+kga2VjVqWj4r16mYX3DG7xjgZ6XnaTPu5OzkaLp8d44C0OrjgDMG6KZTF7XiN5Y/y4ZKPxoFKI/QUR8GJhzGLVVm0yajM0hEF4r/cOZ9CD8fao164cAYlhx/kfvEHX4eIn13Fpt3zgAudrvYDDowVyTKOxAlAahXv6/ff4zIS8GPCAl+xhSugQ5Y6AcU9aepglPUvJLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nz1m2vGkaINZHM0HUien09C8VPs64kiNiDuCCFLmG+k=;
 b=my69akkSfN80Y7n0uA5TNu9UTZwHK6EoUoPvKBQXXKd+tj7dz1Qx+thzNfEnqlYjysBBcnJTIrDW/aGzit1sIGfDgJG5WbHj+PZWrgYgp1WQanJGygYV/Yete/wNAlLoI8gZmVoUSW4JBMSGNFK9S2IXz//TYUce00Hmz7n1ppI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0026.namprd12.prod.outlook.com (2603:10b6:4:52::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Mon, 7 Sep 2020 09:01:51 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 09:01:51 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amd/pm: drop dead code
Date: Mon,  7 Sep 2020 17:01:23 +0800
Message-Id: <20200907090126.2542-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HK2PR02CA0155.apcprd02.prod.outlook.com
 (2603:1096:201:1f::15) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0155.apcprd02.prod.outlook.com (2603:1096:201:1f::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Mon, 7 Sep 2020 09:01:49 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ceeda15-25ea-4f6c-b787-08d8530ca900
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0026:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00260B8AA28EF908E52FFAAEE4280@DM5PR1201MB0026.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6s+j77AnNFoWigHFkgzm+6gcOn0SJ3MhrRhzGE5uNAwjlea+72MeQTMwxNGXcbqis7BWoQFoo706ftNBr+747bDzLyOiEEcj4yCYaVIbX2pSSjexDf12y1vs9UyMu8k1Q0ebciUawfYo2jtzyvmJEP9kRk38GwcnctjFybTzqSJhzep2IqhczmYdn6oMiZVFYLSaWHfEdB78UBObUw3v19M4H6eBZkr0HzeVEpnB68SNq2ExHosoBM1Q6J9/TKivGZeKN+lgMOb94+xxUbqwCeRNF3Mn+5sGqSTuQofHGhgWB8qKPC+DdihYGhGZwV7rUo9FB8dir1ZRPwHMWktOZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(6666004)(186003)(16526019)(6486002)(26005)(2906002)(6916009)(7696005)(4326008)(36756003)(66476007)(66556008)(8676002)(316002)(66946007)(8936002)(52116002)(54906003)(83380400001)(2616005)(1076003)(956004)(4744005)(5660300002)(86362001)(478600001)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: V5t4ejyU5Ht8Et7HBic5pAfDPO7P698hAafDsEaHJzDDycAdxRePtjAxuvBMs+X1Mupdz0Q7rjY73uVdCxbFytA/1nU3M9BHQ3kzTlyzpsGz3Nuh5ohGNq9RrpDZdCQxa28X9lduTnkNVe+2mGvFFLwizMMpEIRCN1cmTs0e6TQKttTx1U8QO+e0PqdguoavCVCsjFRyzczd56qzZa+BRbrZILd0VK5MjCKFBquL3tU4GSAGw+cnTsYbdUTk8PTgWFrYyDwstPCLoM5kDpXSCtZpYX50vH33CAfz9xnJZaFD5ev/s9Pl+jX5l0ogeUw3L2OZsifRT90zboLEf8zTHb8g2xjmqzfN0nLiBpup3YiIxYzldlaaC4yKVl/PTSBuCK3SZfhQyShex0PtkpcI7vNdMjpyok+P9bJHt/hdEvqmqM/0gim+Nz1whbWPIu+tKQtsorYUX7s0qazbWSAQuPAFhh/5jRfZj5y5mhM9Jx0HYmDV2k/JNmAFBcm8UgrB7eZm1+g2fb0OU15n6gOX2sUimyaa3zAPsJDRG28MZE/uKPwmN5ZQSUuyhzDJp2lu41IWsJLNPJIbgxZuLyjSeK+3Wwtbw6FFjdwHBix6t4DRZ27ZPnr1I8UoZpGoM8Jo1+/ZAS40BrPMkr/1VyOuOA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ceeda15-25ea-4f6c-b787-08d8530ca900
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2020 09:01:51.6322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03Fck0Iiz9gp9UmCfmFBoD1KoXXGLrXZp8okFY24gzGZcXbeLTbhZXXwhiId7+dz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0026
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
Cc: alexander.deucher@amd.com, ray.huang@amd.com, Evan Quan <evan.quan@amd.com>,
 Changfeng Zhu <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Raven never goes to swsmu path. So "adev->smu.ppt_funcs" will be
always false.

Change-Id: Ia55ad97bcf9ecf135a9bd795f36a5b521d718b20
Signed-off-by: Evan Quan <evan.quan@amd.com>
Tested-by: Changfeng Zhu <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index c5f2216e59c4..99ccabcc135e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -592,9 +592,6 @@ void pp_rv_set_wm_ranges(struct pp_smu *pp,
 	if (pp_funcs && pp_funcs->set_watermarks_for_clocks_ranges)
 		pp_funcs->set_watermarks_for_clocks_ranges(pp_handle,
 							   &wm_with_clock_ranges);
-	else if (adev->smu.ppt_funcs)
-		smu_set_watermarks_for_clock_ranges(&adev->smu,
-				&wm_with_clock_ranges);
 }
 
 void pp_rv_set_pme_wa_enable(struct pp_smu *pp)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
