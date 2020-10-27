Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3078C4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55DBC21D24
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N+RDlwhh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55DBC21D24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F16C6EC56;
	Tue, 27 Oct 2020 20:53:05 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700079.outbound.protection.outlook.com [40.107.70.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93F306EC59
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 20:52:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpfioHx2eHQmJ7RuxiB0J10LvrMFobrGovxAOa0iWYRf0D6j5/wL2zaQnb9q+A0nt4vP0C7u5vq+U1NYIK42rqlA4jOy491qDOkbgEOkDaj1hhPXr3u8A+ElBbRHG1qWD87zZYazRh24DnubT/ID8WG/1dz7yfQW3ELg0jcEqBh2E7bSdchuXjMz2OrkyE0xCCCp30Pup6tEtIB25/EqVppmcA8Id7WPllHSS6UrHnu3MD1/sxGsvS1IH5f31aFANx7mWwN6B1wN9RJlecd/+kY0r/5FlrmD9DNZFhRucsbbwmrLuPRtP97PRpqxG7cpfTm7jlBAfE03ADWaBscTdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+WOfhydoPNQL/xS3Z+ZqUB7O2GZ/nAmzznQ5m8osmM=;
 b=Wldn8ThmMyBk3qjUrjTRhKegYKZ+fpfZnKCN96SiEZ+y4fB22TPgtE3eXQG0b07wDlBHHgITIbcK7gR+2J2W5kM2pW04uVQ2o6Vs72JHCqOFtWsliAfzNrwHDf0WmOZdxRa82ODk/74mFHFpUYRvrQJdsR6MY1nEp5BtSqaK1iEl2nNbIcs+xxUXi05x8I4TVLWUDmW6BnQXcRF1JRtwYOGmfWHbTPrNYk0m+BTV85nZRzojieRmR9eEFLjmzItYiQdQKUk/kOHfqKVe1VDrqX7RG2GXHvfKq6BF6CFE9c9Y3ChtUGVM9ZJRvRuHCi9XbuIyKTcm+I6edjh+4GOEBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+WOfhydoPNQL/xS3Z+ZqUB7O2GZ/nAmzznQ5m8osmM=;
 b=N+RDlwhh/88wr0dtShInhZ2Lwz2PKTGZABWICuGGpcBSKgeyepTI2nyKEBz1CjjTedPx6OGyELPUd2dL6Wu31TnpII7vt/Jfq9Uuffms3XHbWIZUaW6ju6s2fXmQnq/F97fxH8dIAVBJzYGFgvJO9M8kYHpsZU+ADWbe8fgcfko=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 20:52:58 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 20:52:58 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/25] drm/amd/display: 3.2.109
Date: Tue, 27 Oct 2020 16:52:18 -0400
Message-Id: <20201027205234.8239-10-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027205234.8239-1-qingqing.zhuo@amd.com>
References: <20201027205234.8239-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To DM5PR12MB1884.namprd12.prod.outlook.com
 (2603:10b6:3:10d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 20:52:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 885c4139-9d26-4a0b-97a5-08d87aba44b6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB359580099118C6A674A17FFAFB160@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AJ1TzVRvJ+kcZHef6SmeM/BrHh5cx4USOtpvNOzS8VWUOQzA4d57sGoSVzrF38FPZ+VttHuFj6lgmpZdCRIEdtvsZDGf+ykXb9A9Un2KE8zaBIU57BlRTk2/mf6cm3jEErqBtp/MHATSXcy9JRqcAk44udbTQEiHVm7/96HXJ6NaPWK9h6j/H79Bw8IwHuOXY9E6f9dLy1iuGgfSzXwsFdoEKOA38YMprobg4aW8S7IIBJK8RSL//02G0iDI4bwgVlAqSyRUhlUdkcjYkzCNtlDkSOW+2sWqSoUdGAaLMFkLrpKaphlTnOMpzB/fKealJxNW+N9xyepj1IMcyuuyRBzUZB13bur8Irrx1MkihqFgGNe7L4Pqp8aVJnbxn4dD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(6506007)(2906002)(26005)(66556008)(16526019)(186003)(6666004)(2616005)(6916009)(52116002)(956004)(4744005)(66946007)(316002)(1076003)(69590400008)(44832011)(8676002)(478600001)(66476007)(5660300002)(4326008)(86362001)(36756003)(6512007)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 6Pb7LnnNfAx2D4bZQX8L8rHKMRfbk1IsEtdiOsivt3M25ZyFsKIxCldWVENHrLRDK7JqlsEjD0WM2goumkWejtMJpQO91TE1EdwrKYgNs313wJAjBm2AjLq9IfCKV5uKiAIa50ZY70OrEFXmTvq8+kx1kBswF3FyNm17UNFPq0Ii/6RCt/2QLWpDSBc0RI2bcnLEkUU6gYw1yKYR5gEmhwlEA8H83Y754qFYpGJnaW6XcDyrf9x188Iry/hxcjErMY05mTxBbiGLgfX0UOJfJXHy5E80sQ+Q5yQWeZXhRNoWu0YVPOqaCbInU72XRGvU/WNY1SgTDSgtohD8mZb2tcr+02h/eqR/kaYvZwQQlL9scakTA7bNB/UcDmUq3onNs7ORqjH+kriGG7/VNdGJyJW0VM/QWo8AzQy/IScn/BM7q5XfE4gwSutAcroKOg4RKVs0PFBuIyXQpBusVBOgF4dEC/M2QXtDemJ3AeMt82NPgfxM1rB9c0GF2JUJWN1UKnRKc1/eSuBigp5riBXbBnskgr2F5tokAtJYAB1zlRVC+uR4umREEXXDHSk3nSlBJR44logHevVslD/J3BMtes/AW57ZwK6IXUR0Qc6VFCCdUUCa3Snd3AGCMyvcFAZiL761HSMUsi6iH6DGIwzYAg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885c4139-9d26-4a0b-97a5-08d87aba44b6
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 20:52:51.0476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjpHIbFS8hOtTtr2KAinl49SMmiW3K6HhjA/cvYv3QxQNE4DJH8eYFO/A/ax4YcB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c74be6dafafc..273963e8e61a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.108"
+#define DC_VER "3.2.109"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
