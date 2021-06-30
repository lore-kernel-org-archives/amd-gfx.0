Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF76C11F67
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 00:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B280961D1C
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 00:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B280961D1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C9406E909;
	Wed, 30 Jun 2021 00:25:17 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2059.outbound.protection.outlook.com [40.107.96.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDEF36E909
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 00:25:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcZ4uHAC8mFuTgtgPgu9W510Ho8DkkNUsK2nLWif3nr9SohLprk9//d+ypUOYV2FRfoYP+4rbljR9yn5J18UZhoRfcD+FdQ2mpdoxsfaIrTpOFUjkJLR1UzxIkJ44CU2wU2U+lq1iIB6YjO70xn7xMNtjKCLUUyIcwvcs0XWsayzzAmP8ZPanujFtMIzD6lYvT0zaLLe9UdQMvGppVi+Kx1CRefMAeD/sBK0bwJyIiwCts41b8XtXR2ETgXkZ/F4puRqVcuseDLcOG/Aa/l833Ezyu7ipCtoMJrUV4aVf1AFLcstIj+Xr3Hm8zM5kqcdvUiCS/iwNYpEIfrshzEphA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bguCM/Nj7zIBHeK30UiaXBZhvdCBqjtE1bGFSOPHm3E=;
 b=LeC5h5CyE1ZfAYc/uJy3MDjT2aKl1aDHXaYsN7yABesK7aL0qsAixrdwhbdLMVv1H6T8Mb69Cif4iZB/xyf8Cqqnu4TgxzckHscNyxnL2xh5YR5V7JNdVYAsTONcClzNsA9Zi7TFxfBnYObwZukxNRzXsgwnGEljqo4zjwPVvowlBNrwUqexhsDOtiX0h5P3l57isYQCSNLnGxWZWLS6U3z7jsivXJarLMAclwABBQDZhHysv2sdJly3ibDf+HdeXsmuVaeda0gk65v/uun5cAJhOly98D53O3H3PG2HcN0pIWMXKFCn7ufuS52qZTIESvbCzGZ2st+jPAfUspbyHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bguCM/Nj7zIBHeK30UiaXBZhvdCBqjtE1bGFSOPHm3E=;
 b=cTqQq8m7V317GP9JOq3i9Z7jTHaVYhF3Te4pVfykXEuszQlR5pAfWjYHvkWjBKU1mGjG7q2Ntn2ltnSwF+D+FmnJRu1lZmTPhw7P8173Z8L/EC+F2RJCGWXYdpnoj5Sqrz87WMIRz/8ct3ov/yZkTqkmpOMUbPb6N6Xnd2ATb+I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5256.namprd12.prod.outlook.com (2603:10b6:208:319::8)
 by BL1PR12MB5080.namprd12.prod.outlook.com (2603:10b6:208:30a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 30 Jun
 2021 00:25:11 +0000
Received: from BL1PR12MB5256.namprd12.prod.outlook.com
 ([fe80::c990:f31b:1e0f:cdba]) by BL1PR12MB5256.namprd12.prod.outlook.com
 ([fe80::c990:f31b:1e0f:cdba%6]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 00:25:11 +0000
From: Mukul Joshi <mukul.joshi@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Conditionally reset SDMA RAS error counts
Date: Tue, 29 Jun 2021 20:24:51 -0400
Message-Id: <20210630002451.13214-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTBPR01CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::26) To BL1PR12MB5256.namprd12.prod.outlook.com
 (2603:10b6:208:319::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mukjoshi-dev.amd.com (165.204.55.251) by
 YTBPR01CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 00:25:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 309c798c-c317-47b8-16a4-08d93b5d85c7
X-MS-TrafficTypeDiagnostic: BL1PR12MB5080:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB50808D71891C40F6B49A5307EE019@BL1PR12MB5080.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0YeyOl1d6kjMAAo0qs9Svk/+ANphdP46kx9hqz9g6iB+gQ+an9g0veHAUvomi7Zjv28X6a3Ik14z8ugsJbVibd1uEZzZ7hHJsUY0j5ff6Vrt8bRjeriOdnn4iX2o6vLRcqg91HO7FxrMF5FQi7JJe4qV7s4+zJmqAa1IBmG8KTInfzG3FgJK99UiJTtIv928okdhjJ7G/kwl+M1TGrfa73LLJytMw5j7JWWeRasciNS3Ll/2y6RBMC2qqCEVJmvZpCthD8zcZmw8RRRxPHg/RSO63lnxLN8uJ7y9f6JnIMTdncIHGFPrXGjBiXQGSO4faKCnart9Bl8YbIKCZQXmpqKAm2ZuTuMZawdC3juqzQIhW8ttyY1Za6bOdpB29IzqNkNSGHTmYxy9IU2Sc/0lZb9lIx6NJxC0Ifd8sIM8SeGlRfDLDpXDtZgOOvHnf2KOWNaP0ien3aFEu/r7zqPQiWRR8t3FXToIvlkUIH64OO+bmbhvi6hkSxXw3tGzWAKFxJkf6d+qxegoygZTgLAdJCr0ReFKc/wCLoHXlh3l7gS6rc+m1FcKYBCh9Qdcv82OKIPsccf7CdCDM+rKuBU+HorZQH47/yLUOeW51uo68NyN9QvQS23wSy7R42WOiwitcMr75CDbVuYTac+iWcuVT4b837y3kOKWFd+ctXkm3VNEPV4OjTSv+FvpPtGZDIAM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(5660300002)(83380400001)(66946007)(8676002)(52116002)(4326008)(7696005)(8936002)(2906002)(66476007)(66556008)(478600001)(6916009)(16526019)(186003)(26005)(6486002)(2616005)(44832011)(38350700002)(36756003)(6666004)(316002)(1076003)(4744005)(86362001)(38100700002)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WluO2NRqcvYdVVI9Im0/8l90RabuS6kj8s1flt5VVY8N3hRWnf0V1d9Gfjvj?=
 =?us-ascii?Q?FWyEEgtv7Fo/OpEvBn17YzMh0gXzZLapN0cX4xCaQzeZwTaQkG4J4hRP75/F?=
 =?us-ascii?Q?f6+A+u2PBSTKTRqLfXB/YUzepOSc00wTUUztQi+1EQH/I/+aTcJ47JazRLPp?=
 =?us-ascii?Q?obFG5nE9kWZLL1AfSWlf3RZnAW7ih0BvDSYHhazrarZQ65Cr2T/zXvlFiPkY?=
 =?us-ascii?Q?z6iPFeSD819Gkwo97m3OOxLs+Mg0ETbLNQFkHamZ/cQ99/d40G5O7PUN9h/K?=
 =?us-ascii?Q?RjWrskDWnyDhx25T40RqKcbJRQQxvnQTZN6PD+5c71e8cH4plnBKyzyqP8Ba?=
 =?us-ascii?Q?Q+b2+n61egr8xCgVDZdoS6HX1d+Ei0Yqe8W2VvFMR6cUpzt9fJ3gw+HKiL9S?=
 =?us-ascii?Q?bbrbSjyhNGmcPgd6nlBTd2LBhgUPQkEBb0YY+XaHNKhBfMu3th+97ztN4qTN?=
 =?us-ascii?Q?DEmQzAYq0jLw579AeRxIzUj5hF1Ei1B5e/kHWvPHhvxN08+3c/zpLlKTqFZT?=
 =?us-ascii?Q?DN8S/5iA8YMIswFNN/MoiYXgqrZocSH3ojNSE6H/ssOBLnxjRKTpNzYcJdLi?=
 =?us-ascii?Q?BJGIN+RLsgrsTJ9Zz6+IWgE+Uq7iA8RESLBI0KMhbqAugRz8kUEePpHgVAu4?=
 =?us-ascii?Q?NWF7tIuj2M4B2X50GgaRPhdpaf+z36nH5fiSwdfnCh4cZ5u4Hd/OGH44FJkT?=
 =?us-ascii?Q?+Ota69cM7wh56/cj3OfEknz3LTWTOSPLdaNZGvDzZ3JsHbleVYonEbTmcZUZ?=
 =?us-ascii?Q?f65NHqOCcHlF3UsmzOl9N/+zNvssMOn1T0YuhwfEYaeVkHzfQOFXNMQZ4ccj?=
 =?us-ascii?Q?chHTxLwmmjOG8QaxM1uaUqBCjzfiM7SuKBe+ZjG/rzYo4gD1K8hIXX2HVC42?=
 =?us-ascii?Q?mxsqZXRhR0O8ijxAvCOSR1cfbMcg+1hXqdwxH3jHhi0iXgeuTU1oQwt/qDYX?=
 =?us-ascii?Q?5tobTOe3bFM3Sk9vVgT5166jHN2WOWYBL1Oea0PbLr9GUOjSa8oWHBsLAjir?=
 =?us-ascii?Q?9sLnEXqltWVCyIwVdX0kvr1zNQTAvycDZh/O29ZdXQ3X0qKuzPKHKH4Ln36D?=
 =?us-ascii?Q?LwXa3PNDLit4TYqb5FLAJXxpXWJt3baN4et/TuuTdk5JqlpzxUGiebf8zkxO?=
 =?us-ascii?Q?KfYsOP4hJFBcJCchl1BzutxSdp2i/u+3bmPJn909FwMlTRDYPWgPMGxcyMm2?=
 =?us-ascii?Q?WgvFcTWKSVZEpyqqzHOWcq4yRYFNOsfb3g+odGDR/hSgpKUipS3v/0Ig5ilA?=
 =?us-ascii?Q?0OyT1J2MiXxYUdvFvOqzHo8kmyYjyXI/EzpqH5hg+obcOL3Dq2KsMY1DVZKw?=
 =?us-ascii?Q?Amn4Mv/YGRro+I2atx+G5rzh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 309c798c-c317-47b8-16a4-08d93b5d85c7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 00:25:11.4081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1R33iHBiM8CFqvCuKDekOjhqRY3Srt7cdvUCGw1+HJToVqLfYPcbEnFLxMDV0lhesxAhnX14CNN5Ezr2ZS3oGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5080
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, john.clements@amd.com,
 Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reset SDMA RAS error counts during init only if persistent
EDC harvesting is not supported.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index f6881d99609b..8931000dcd41 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1896,8 +1896,11 @@ static int sdma_v4_0_late_init(void *handle)
 
 	sdma_v4_0_setup_ulv(adev);
 
-	if (adev->sdma.funcs && adev->sdma.funcs->reset_ras_error_count)
-		adev->sdma.funcs->reset_ras_error_count(adev);
+	if (!amdgpu_persistent_edc_harvesting_supported(adev)) {
+		if (adev->sdma.funcs &&
+		    adev->sdma.funcs->reset_ras_error_count)
+			adev->sdma.funcs->reset_ras_error_count(adev);
+	}
 
 	if (adev->sdma.funcs && adev->sdma.funcs->ras_late_init)
 		return adev->sdma.funcs->ras_late_init(adev, &ih_info);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
