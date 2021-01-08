Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75738C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AC7D23A9C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC7D23A9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B2D76E8D7;
	Fri,  8 Jan 2021 21:50:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E686F6E8D0
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 21:50:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnBb1rBRjxZOtUL4sKIKRVsaO/u91LBqk0d8BSEqX79E9L792/7iT/1A0e+y1OCWVOMCR97n6CdE2E4IF132XfOExVEB6SjL3MeHDWda2PPRNCXq450w6J+cBggPr4MIvTGOhniPTlV8yH5cv/RZduJCJcUUn2MhK8o8OM07YtRg4KeZnYudnMttVNHQnbzhcK+6lrhuZQdFXpK7M+ocPgODwCt1bC7gn6i6NUUrow7DDs81Zh60xrvsmp9P/X7sytxlYMhA0ULW2w8kwBtuthC4wLEZqiR3VG8fdX3UIfYuDaAvw4JOAl/ZkenTDzofdiCZQJN+Zi1s2faKNFzXWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzFCUsVzvJnS03jHctu6zIsCQ5+XzJ7T72huWvfV5rA=;
 b=UKofs5BNKioFvy44gz48zisSOlB4wTQ9WTYryjCmTnaYeCCXTgWfMIV13i1Webxv7NMItbbYmy5NkpoAMAI5duJROCWJnZIgXp7hmmFmPw2kEjsg7p821eb0ZhwEwMgAJAfEiQcImSo/uShMnqof4Ku3OWiz/remmzzNjcZpzD2KHS1K4FHJUVHCusQq6uVAiaW4Ac2ZbkmzCy94vsYCeCGjP1KT8r2ofF5JImq20j25abMy2kYC/MEUDpBKDbFs7BAbnMJMukmh6ENIH/R/dfMqh2YONzmdY2hisCAryTU6pAEtb5fvP00Q7CK+Hj6Z+PmD74HPKQgU9gJzo8tGIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzFCUsVzvJnS03jHctu6zIsCQ5+XzJ7T72huWvfV5rA=;
 b=RErKX76xkpyq9k2uBeI+lBbsmXpnBSY4MytKXsQxvg4TPYUqw+jvLJnpBk4PEaMdBINg/OvQalLAGa33ETteSxB3Z/hZm6AIbiuDELnTkjOxdZpam2kpLa3mQmHLFWDotUuODVpIURUBYo3rKwWAN8inxP7GZewDPfq/Sejhx2s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Fri, 8 Jan
 2021 21:50:37 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540%12]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 21:50:37 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/21] drm/amd/display: HUBP_IN_BLANK for DCN30
Date: Fri,  8 Jan 2021 16:49:51 -0500
Message-Id: <20210108215007.851249-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
References: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:691c:c3e7:a457:38d0]
X-ClientProxiedBy: BN6PR19CA0063.namprd19.prod.outlook.com
 (2603:10b6:404:e3::25) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:691c:c3e7:a457:38d0)
 by BN6PR19CA0063.namprd19.prod.outlook.com (2603:10b6:404:e3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Fri, 8 Jan 2021 21:50:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4be0fc2d-f551-426c-a98e-08d8b41f6edf
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1882EACE462ABEB287B21F4B98AE0@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t6V4HsW900tdPdBLVCs9bOKQkZZzMFQp9RWYBwLwkKSCxYI6Izh12LSLRuGeV7SjNPzaC10NRPgNCe+UNoa1LRMp920xJmjJLXCmmC3ZMsdUPuUEhNF+Cr3Ig6x45quXekEc39NX/yPF6vSb/4IbftO2Mi8ouhTcjOxEAKmVk1VSGpD+0zAM/CNLrHN/SkligWfJ0D4OZjnDS05EW4e1Ph5HVF1i0X+Pc8mpvs0/au9r67ICFPvDZXi6QgtFhu370Z09tvFzocyXFsQ0KpSFaQMci8t1RNYqm5/HG37KZazNirch7Mp2r8gehIdy9OEMg36f47kkQAAoTfTle64Ia2FSH3tH8rEZUynXUpbVNJ7VCZ9XzTiqdjHHFzObFFpkcATPBp/fG244EydPXFsdSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(5660300002)(6512007)(478600001)(86362001)(66476007)(6486002)(4326008)(52116002)(6916009)(66946007)(66556008)(8676002)(1076003)(16526019)(36756003)(2906002)(6666004)(316002)(54906003)(6506007)(186003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qZwo3/3+BfQZCZruT8PUZLwKCXQjs01ngvLP4I+dsiGrO57D9qUqUZqP+Ml6?=
 =?us-ascii?Q?y2RwwXncOMQiU16zhFaKBamSB1U/4QrJOsOl8i1XhB6AmLuxw7nilk/Th6XV?=
 =?us-ascii?Q?C3ySnJF+xMKxl+tIhR4nyBtnXwK8KD2uSyffm/BchIV4UT7PjmnqKGtbfs+/?=
 =?us-ascii?Q?i9dOaBl/TO9G9moeIzNDVlAWYx+sCiwCw3/4mcG+IctzuZ4GkUaQpbb41hO1?=
 =?us-ascii?Q?zwnkFppj0FMzFxmBHEFjQ3r2WGUcFEhCMsES6ZWBB/mCDb0N2NCLFZCd2Tvk?=
 =?us-ascii?Q?9zgWbR5cbLEW4E48VXH9c0Lzx6Sfx9zhpe3hHijX9izfVYGxMgz5KeAiXob0?=
 =?us-ascii?Q?EevgCrdx9I1LIKuRoeLOWA5ZB9BJ2jVyswgLXzM2ZqyxurTFHHXPgJXs/+/Q?=
 =?us-ascii?Q?LtMqYWJ8rDI5c4QlUWTHL65Ohn1haQwTjMvwhq0+veTblwxQLQoFQkUkGNUL?=
 =?us-ascii?Q?Uiw40e1i28Fv2UV1UL1xSIDK05/CL2Y8yhL0UwpaYYXYZwumHYbHHP1Dyi1U?=
 =?us-ascii?Q?9kHAfFopk1J6fLeFzUY7Xrw4vofrIWs78Lt7zoayXG+eOzp4RsJp/kWOf277?=
 =?us-ascii?Q?FsqmjmiN8pNGmD4rS6N69aApXR6S5YWrMV7yczxLERRsQHOKpWpD8HnrixYO?=
 =?us-ascii?Q?G2ZhF1iV8Qy7I6L1gd0rEyAlWyNn/c6iHaAm5XV55GH4FVkHawlNsdJLwghN?=
 =?us-ascii?Q?8wVOmV/7ZfBjFR9lRQ3SjKn4M7JJiDFMxF6+QO3sWEjLtmlxgqj1jYLwCfHj?=
 =?us-ascii?Q?1n97mtB4UAY/2LC66SwEpyyJWwxLZKL70piVmrx71FXd8/BRmRDifXaHhyWk?=
 =?us-ascii?Q?jQVqF5eQF1q3Dxf1Pm5gor8HjSHg7uOcA6Pj70VNEF5gSiYY9gY7fS3hXz45?=
 =?us-ascii?Q?N+CvhYs0VQJQnkhfVb0IZbTuE4LOwgXktTscxJC08T2FSKnnVT0afFIMcYcb?=
 =?us-ascii?Q?VgGP7l0eKx3TKQ/7L+frtao71OL2bgWeV6Cosczqe9gQMRAEJ/9kRHNw3eUC?=
 =?us-ascii?Q?q4WdEkqqLOI9LxGRUs94uSDx3ol0/NUgUDm4SXKEaylNnix9wIJZ8ZrvMQOB?=
 =?us-ascii?Q?6o8aONMM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 21:50:36.8163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be0fc2d-f551-426c-a98e-08d8b41f6edf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkVb3q2P+RZwRaydJytoTKJZcJOBjasrC1a51AR8nKu6U7v1i9uy/9jtiywG25yydhniYr5qaIO4jUZbaaFi4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Wesley Chalmers <Wesley.Chalmers@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
Shift/mask for HUBP_IN_BLANK is currently missing.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h
index 5fa150f34c60..705fbfc37502 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h
@@ -62,6 +62,7 @@
 	HUBP_SF(HUBP0_DCHUBP_CNTL, HUBP_NO_OUTSTANDING_REQ, mask_sh),\
 	HUBP_SF(HUBP0_DCHUBP_CNTL, HUBP_VTG_SEL, mask_sh),\
 	HUBP_SF(HUBP0_DCHUBP_CNTL, HUBP_DISABLE, mask_sh),\
+	HUBP_SF(HUBP0_DCHUBP_CNTL, HUBP_IN_BLANK, mask_sh),\
 	HUBP_SF(HUBP0_DCSURF_ADDR_CONFIG, NUM_PIPES, mask_sh),\
 	HUBP_SF(HUBP0_DCSURF_ADDR_CONFIG, PIPE_INTERLEAVE, mask_sh),\
 	HUBP_SF(HUBP0_DCSURF_ADDR_CONFIG, MAX_COMPRESSED_FRAGS, mask_sh),\
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
