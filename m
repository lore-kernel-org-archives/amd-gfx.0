Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77964C43465
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 22:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ECD020878
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 22:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qAsZrz1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECD020878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79A3D6E0DF;
	Thu, 17 Sep 2020 22:13:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 800106E0CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 22:13:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JscMZSjIJh/pncXFUeKlULHR87TS6c3qv2t3pAOlCYEHDgD/wCJpJ61yYEPm9SqSn0kuR9+J1FOg4+Q0knhZcKG+QKjFCxvo7Pp/d169WVA3BneMn78qia4Pr9IUa6NwzYU4rzoj9QAS2WPaoOv88JMzSgUGoCXxGeD8zf/2RyUYlCTsK8YRtuGVZyaBmIKqtb/EnqdT/teBpBmVwn4e07/y67qHlDjKWVgu+lGOrnjl7F7rQSKYulY7bWT66ElZoL6Truhtccsf7sPq85Mbvzy/OgW8yWIpdHe/+/yx6wnfc+Od+2UtAGlHtz8lAyO53p2hHARwiTh9WcidU1NZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcLLOq49/ICj9YB7zbhnz0rFbo4bO742PxfwL4aOXkY=;
 b=bPDmZt2mq4y5SIYpx64TH4gvtxahhwIupd1GNka73Fg+8Od0adU5TBtuUYFDbykinNugRMy4XTXyKW8z/p0uyExUWxY21D1NXMp6R7wA070Ei9gzTMdhvirtcCSZB9Cqm0HJpc0Fl6Tbm32bgxpHWGh3ks/NxNUScVgDq/eCjDXD7YxYEUWF0jgImMss8GvUhJWAl7nZiSSSqRsh7BtMuOFaI1a7qwttjdCdyxQ425rN2inQoIe/SXQgXT9/rhg6jtkT1A2uTdZRsbQf9iRhXx74fT/noElL3oh8CSk3Vok14kOSw5vuJT4N8QZVcFCCIJjndESPJ46JB/Ki7dVmLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcLLOq49/ICj9YB7zbhnz0rFbo4bO742PxfwL4aOXkY=;
 b=qAsZrz1t4IGql7Xsj/uerFxiaVr6g7/WjecFToiPDqbNTgaIOQWc2g5HtOBGEKgrIGYLBKP9d1Zuned38UqvOQWy9vqSTghJIxu8IdLLXGssUfn7ynGQongWGhx9AK6rRo8yGXulHEDMZgxJfhy////VV+H88T1Bvn9B6euCYLc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4988.namprd12.prod.outlook.com (2603:10b6:5:16a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 17 Sep
 2020 22:13:36 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933%3]) with mapi id 15.20.3391.015; Thu, 17 Sep 2020
 22:13:36 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/1] Convert to using devm_drm_dev_alloc() (v2)
Date: Thu, 17 Sep 2020 18:13:23 -0400
Message-Id: <20200917221324.520327-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.28.0.394.ge197136389
X-ClientProxiedBy: YT1PR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::40)
 To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.55.250) by
 YT1PR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Thu, 17 Sep 2020 22:13:36 +0000
X-Mailer: git-send-email 2.28.0.394.ge197136389
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3e980854-30aa-48bf-3dbc-08d85b56ec3f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4988:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB498889C1E7BD385D6F414535993E0@DM6PR12MB4988.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:353;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wvqMVd7JAj1w9N3ZpgoWA5hqLKCTmC/wZN9tgNhVuOKopf6kFbSr2oyKazLBOT2P7Y73+WVXhoMBQmc4BcfM+M77bHBkWu75FNKNjYOalxuLsrbh3Y7EtDFX+QKswdwar4HPJkKCgBDMretlMGeay6R7LgGREWJDT8Ug173Nzz2U10TnNQ84iJUEV9MFW8VvyPfrLZqJcFLUHKOdH43fx0t4qQf3prdP/9BM8WRVZI9sd6sTf2Gnwq5NihJAeLk9s7nNEf+NXW/CuSAuSFSY8CHjHImpBwSv849CTzf09ObnITdEpa42qfVg5+ZHdRbIH5ylSox+HldQVPt2JGybdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(36756003)(66556008)(66476007)(66946007)(4744005)(478600001)(5660300002)(6486002)(1076003)(4326008)(83380400001)(54906003)(6666004)(8676002)(2906002)(26005)(86362001)(186003)(16526019)(2616005)(8936002)(44832011)(6916009)(956004)(7696005)(52116002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 3hSYd0UYkoSN43tjaYQxSI05VS9+PHmdzir71fHQlRYESIhc2MNpBFuML2RVC+jq/55cmMLDzETEi0fUIkCnZIXsmNwIOyXW24dcdbhWoPyAJxq7slO/EErvGsifZSpsItR/iFWbsrzpoXiLOs1SzEizZUeieyEFm5n76gJ47/5tnW3PP9e1nnFCtIsx4tY0sWqVIzTAcM+5hDNNKbaxpd4atj4t0cReahDiNPkdGhLPdZuO8Z6VIQuoX1MhXT21+41IVFPlI1N0CMXgGaURWr4ggW1T7bnvzWht5C50ZeWKrOEv5MsSFwt6tg6Z29coikA9QNR1od27fT30voEgSwKnuISVzRe8lf0l+v8W+OXZjDVAv/7DxUHqn5SC3eDQ3u3vGvCm/7NHE5mv3PSuJtETnYTC4V7CbY8mrDQA84rneENWKWd9suziBHpCdzqO10tKpIlIby9lAzIRzlI+SLRRdPvSsjALDiUHCj9JkSpdugOo70X6L7V2wVxss1I6GxQWSRbohpCXLig0hpuQ4v7PBEDgkZ3mt9CwC0g3JaeLMD/QflynR65brkMF/I30XFuYu3JpRonqZuKMFW0vMyftZsyT7dKrpbhEP+1fbQ0QaTKlRGifT26VAAMqThk8r8ReaJ42WE62CxDWmeme4w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e980854-30aa-48bf-3dbc-08d85b56ec3f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 22:13:36.4236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nU5iEQhV73VRmZf1sUIluZqeuCEULyEjb72PrxebK55iepuolRmI+XIYWPUKU6N0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4988
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is based on top of Daniel's documentation
patch and it applies cleanly onto amd-staging-drm-next.
I'm also running this live.

This version removes explicit drm_dev_put(), as it seems
that devres acts as a garbage collector.

Luben Tuikov (1):
  drm/amdgpu: Convert to using devm_drm_dev_alloc() (v2)

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

-- 
2.28.0.394.ge197136389

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
