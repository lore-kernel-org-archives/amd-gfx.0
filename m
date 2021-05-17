Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA19DC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B895A601FC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B895A601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6485F6E9BD;
	Mon, 17 May 2021 14:57:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61D636E9C2
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 14:57:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpZRH0v0A9sZ2IoAJ4QBvg9h7kEXJFxJw7UBW3NVG41QGH0vrPQ2aEO8TOkL+Bxd4CIHNfJb7d7RT4G33CwcaoMIOjelPnImEmuK9tXtR0zuIWCRYQ4uuZm6zH4XLgAp+9pMXft9D83Bn4mugtGeCZ1swCDHEp7PHbMh/TOKWMc8fN+gamEsPGVlcmpKjp1JWWCFbxQws2I1VPr3Zngizhsu1CeD9Z2WWf45cfS3N42Z+ln6Y4isBqyimqgHhXBKv6FjUI1vpPGMCT13TZcrefD4y+4ELWHjldI6RmhM6Thmk/WoOzDh7RfBwvrgvasJvBnv3gBPRGMcs+kqH7COwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aI0VTAk7VXZo7Nk6f09LLca8COpjEKIQKLAvUnIAex4=;
 b=lL120g2lJtZ0tuUkcKkZF7a8ojWeQy0FhvI3C1D6ZJe7gRyZkIqHLsp4s+1bbjGnxLf+dB4qseixggf++VUJUeNg5H9jid3pdnFgWAqp0zayRTR4ElvhZCaI07mifT6fxfeFC0UCKw5Wsk4z7b4v9gOWLC7q63i8Ecv4HdVbgxWnDNp+K94wDIIayvOeoEy+dbG4JNjHFwH+Q3aVN7uXKaQfUonrpvvnDSM7ByHntmdl0AYqzWBbQbeW2MCzlvpPYrMjddtVh3Iz13yAxfkN3g88SEqX6lu+6tsz3uWMISuc1HoIMUDWaPz7z/U8bAuZpvK2XhAlpYU2DAEQr6qLUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aI0VTAk7VXZo7Nk6f09LLca8COpjEKIQKLAvUnIAex4=;
 b=0bitsGgUktFjHIWAoW/VEdppBjS0jduAadlhPT0dI8uOTzad56DxdxGhKTOM4qy1PS9UD0n4b+CxX1MOfBbbG6/5IABnxWSnjPjKIMc61yQk4GFawsfL5A9pfelmio+NmsbmIczBOy9j+/rWYwsPksVSfJ/jKki5mZBb1Hi7guI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB3257.namprd12.prod.outlook.com (2603:10b6:5:184::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Mon, 17 May 2021 14:57:20 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3%3]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 14:57:20 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: remove unsued vcn_v3_0_hw_fini
Date: Mon, 17 May 2021 10:57:08 -0400
Message-Id: <1621263428-8631-2-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621263428-8631-1-git-send-email-James.Zhu@amd.com>
References: <1621263428-8631-1-git-send-email-James.Zhu@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::7) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YT1PR01CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.4108.31 via Frontend Transport; Mon, 17 May 2021 14:57:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d81d6bd-c5db-4682-005d-08d9194411fb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3257:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3257160565D926418369E92BE42D9@DM6PR12MB3257.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: biiZM9jvdpwNNpmrz5XaerxHWLqyp+oivBxfg2Zca1jqCskdT9rtnN9iOeUQAy/qKZSHz+oowk/aUU5ASx59vCBvHUX7KZNK8UOT9VEbIJwphIaysqzMct3+zaRW256Be6FkP7Limn9U4c7aXi+8IrYOO9OKuohNdVUEAY/DBWdxQ0ZtpTbt4IEaJC+dwLArVDAHxQMhubaSs+XtZXXdPHcTROXJ0ns8hlzDS8rrKC59k/sE9uLdB6RtOW3gkUcLMM1AdWb5MHl5jpGHmfHal/NZZ+sKXlIYj7jGYDdBQBYFY53iKX/b96d56gn6hpMD1y+PCj4hGIdMPymn+LIZSx3tHqYBvs77F55lZ3fxT4VBo36rGnT2mdFkOyKP/RrMqjk6HjsbUq8ZX99PUsdH/IehtkD2vL59xdipGc8BiA6TIm6bhLxBw243bwPm4xED3si1Gi/nyVL/xAdq3412kNnEsrNDfcdybl8D6ogNPGJIJE0gHl9SqSoO2tenuIuCIBaW+EpQxGBE1rABqmIeQVbJwIe71Li3RyZ0kpe4OnmEHoN2AoS+sxXvdxUO3UHZmvEc8Vjh3Xd9mks+8f8apxqBbe9uJhKZIqFSDPm2KJyewTKEUoAuc+iNrNRhp26F7A6x4sjk7hdJy0JEC2Z5UQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39850400004)(396003)(136003)(346002)(366004)(8936002)(4744005)(66946007)(66476007)(66556008)(7696005)(478600001)(36756003)(6666004)(186003)(6486002)(16526019)(86362001)(316002)(4326008)(2906002)(26005)(38350700002)(38100700002)(956004)(2616005)(8676002)(6916009)(5660300002)(52116002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6f7poXml59iWWvU52aRcIAL0yfnBkbkd9fx+ar6tbPe/6MmQaAUFSeGxJlTV?=
 =?us-ascii?Q?PKrudtCewtnsK5v/m3AJvpHe3+SI223yZ9ls+N6PIDy/disY8HL8nPYixcoc?=
 =?us-ascii?Q?vQoGeG0MQTs03I/30eerh3epPb9p+/KLgRz6HtYHLYhtMz4XSIDr4ajHbm/e?=
 =?us-ascii?Q?dRmaw5r16u7RWdRzNW81axwNAZSLkYqgHvZKqPU3ShlvAJ0TAvRpSCvRMCCR?=
 =?us-ascii?Q?Rd8/H1tyA6ADO29TpF8VRyHS5kTDbegf6gKZHIj9XrXF527Zoy9XsyqFHUj+?=
 =?us-ascii?Q?M7K10ZT8h8f5tgJFSIsO4kpNaj0fHmrQmvsbNnW26t1ocv48QHezEfhs7Gyq?=
 =?us-ascii?Q?u8LLTSKgEXigq57epP3UkmMrSCwF+S0LfF3Y2rJR7xVFD+CjM5KeTLE5ys4a?=
 =?us-ascii?Q?212dUfA8i61pz2BcG6yOs7Hh7JCBHpViHqGbk9o1kXYzYXEqeOoZPWdwwdRX?=
 =?us-ascii?Q?5XizF84tdPWJHdTJ0hRO6gW4arMuGJI1HED1I/In0FbkIZ5M/1C8DMvLI+gB?=
 =?us-ascii?Q?jVxzfk6UP94xB7fr+u/dCsZTXX71veSoDOXAzUZB878xJplGWtOElkxrt0WM?=
 =?us-ascii?Q?+MT+EddDtTK8qpTOmEtCxWgELIGcB3Zkbh4ASbS0rxcFYNNO/SEe/jQmb96/?=
 =?us-ascii?Q?QfrteKt1dWFb6b9BhW3jFbEO99vRZm7adlu3nPiSt616R7tbLMtqE5TF3IUP?=
 =?us-ascii?Q?w8dtSpUxscYjyQYgqt1ONc/qi+bkozP3ylzJXJzYHrgQH+eNCo53g2QglQAZ?=
 =?us-ascii?Q?SD1z7JOkDIoc2yIIPtpHeJPxe1ubB7ju6Bw5tAHxTxPreMmaaIRnyKJDICo3?=
 =?us-ascii?Q?Kt/9VuikUuSfImx7dYCmq+EoGIjf+iR1EJw+1jHaZQMqm7MB8RLyI71saIDp?=
 =?us-ascii?Q?V2zovRRndXSO4n8mZEUIVMWz+dxXhqc/MuKNNbX6u4jAxhOiFpQWTDKEUhoT?=
 =?us-ascii?Q?dzxe6bECvCcyfp3XBBHhV20Uuda4t9NSJQzosWczA3MbhTOi2lwTzuM64N/r?=
 =?us-ascii?Q?PhRj4zg/9YE2Wsk/IQa4xADQU+0Ueq0Tt46uWHidEJRCP1/UNoGjk8n9dbs7?=
 =?us-ascii?Q?50Bka8a6wCUu0/WvVD7X+sDio0U6DwRghnF/YtSOur7Em9J92h6+TGuv2+VC?=
 =?us-ascii?Q?CXvvTf7aEyGmCy5BbbxugDX/C5Bk5yMLlPL4zW/aBrznoOXwNCqsn/HnOTnN?=
 =?us-ascii?Q?xqucV6Vi1Ls/yTUNSsQt5MN5K1EkyUPin1CBjIrFOvQLbIlrsrwm6Z85bSSn?=
 =?us-ascii?Q?EtevWvT/ybnG9t5UluD1HBldkf7kQ8ThQarm3g3bDkBVhKneNmQZj3dh3F8W?=
 =?us-ascii?Q?hiYtNy51KtFeUN8rf7RJuxz+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d81d6bd-c5db-4682-005d-08d9194411fb
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 14:57:20.2067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26zYN0OZzUpae9R3cZHBB25iQfnAySGlgWepjHHUtJM7vOnhEctkkNoRhA8VOyGr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3257
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Removed unsued vcn_v3_0_hw_fini when enhanced
common amdgpu_vicn_suspend is applied.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index cf165ab..e7505ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -411,10 +411,6 @@ static int vcn_v3_0_suspend(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	r = vcn_v3_0_hw_fini(adev);
-	if (r)
-		return r;
-
 	r = amdgpu_vcn_suspend(adev);
 
 	return r;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
