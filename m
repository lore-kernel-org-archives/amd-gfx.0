Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EE1C432C3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9A7220848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A7220848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 550C56E2AF;
	Mon,  2 Dec 2019 17:35:01 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800049.outbound.protection.outlook.com [40.107.80.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30D596E2A5
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmM3ax5WEwPoTvIctTNuGXsYGH+TVVOIGzAmYymCkCNB4UKGDkhvtVYhYbjnbd5CbvKh6o4cI1VIvMfMa6TtszARR3XMX3TOLYYaca7RVjxPjj3/ubxPDnjq+jjRKJk1/Axf6+FnyIdGg7zPNyfHUsdb3RQqO5D1S02cuS+0Wra+zd3iiyP5gsn0D6c0S9Yq3oNReo0WFTbEYquDDQbrM/psecKkmgrfGK5g0cLXfdzPQ1zSzjYJktdzywpjDJd70EqVMyVkh6OuyfoLxzUNRgehTntHPUjJ7nLNxj4BOyxGbgbzRHAqYeTQe7cPoPbFJ/t6hfXDqLZJMDGLWkEwGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DULw7FqmwnSqOW6SAcKYrF9eT9rMEuRI/gkIeBqmSqI=;
 b=O0F/b6zoCc7U8Xx6O6NNNLcUarDY8tG1qilhuy7QG0os6MFzvtKMUpvSRclf5jfVudtjKhVZlgGGu2AC55vVXE5fULZ4YNh+SsPrSpdfFZrlqLB++eWyJRoUh01tAwmkwMG2D52VEM57vQ6Gna6bpoUJmlDJ07+2wO0KMRLemzrwc39finoYWnTVbjGuSOpsCSMFAkdxvHh49PWlrN4mnUYH76iMO7J+VqjN9o+laf/s6HACLSSBytD8+OPFL4b1pc28nYvFs2YGCOz8L3eSxOO/RMf0SwBpzYhXv+WyMn+whwwJKlp3pzwOCQkypyIgfrQA8RYCeaJSbtSVKGAQgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2610.namprd12.prod.outlook.com (20.176.26.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:34:58 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:34:58 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/51] drm/amd/display: Add DMCUB__PG_DONE trace code enum
Date: Mon,  2 Dec 2019 12:33:24 -0500
Message-Id: <20191202173405.31582-11-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202173405.31582-1-sunpeng.li@amd.com>
References: <20191202173405.31582-1-sunpeng.li@amd.com>
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To BN7PR12MB2593.namprd12.prod.outlook.com
 (2603:10b6:408:25::23)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f5aae6bc-9c71-49d0-3598-08d7774df28a
X-MS-TrafficTypeDiagnostic: BN7PR12MB2610:|BN7PR12MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2610C8ADB5FC99F7C4BF317582430@BN7PR12MB2610.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(189003)(199004)(76176011)(6666004)(51416003)(4744005)(52116002)(6512007)(66476007)(66556008)(316002)(50226002)(5660300002)(6916009)(81166006)(26005)(2616005)(99286004)(386003)(6506007)(1076003)(8936002)(11346002)(305945005)(446003)(81156014)(186003)(9686003)(6436002)(4326008)(8676002)(6486002)(7736002)(66946007)(54906003)(48376002)(50466002)(86362001)(6116002)(2351001)(3846002)(2906002)(25786009)(36756003)(66066001)(2870700001)(2361001)(14454004)(478600001)(47776003)(101420200001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2610;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 97bqa39JWGumz8iKwsfUkke90ka8qEdau08/qprZqIfwY40rvJ940auJWARAHIWtRBOW5XH15agXy/m8ATc6Lx97yj66IFV0PicW+I3dP/FFfZQ5vvrmO6Gf4RapIa5ylcLBKkHxnumnLLd6WmbT0r8QZVTFMQpLCCrPLp4+6XPLiJ5KZ4O/7txnBhSwLtMh60hHjlpQ8Uutpz7w0/q37Oc86TMYcXMIDm2xf+EqziDqc2EdxgUjIwOdTX0+witYr59xSb0elNUqUGhaPz8JwY0abI581EtHlQSarxI6KgvFeK2j/jFWQQrr/mMExgEaqWN6p88OZ8oYuD9uyRQwMZqtUfhpuDC72lTYtdlFJB2O3ePRZQYjyNNxAufFbIvs6BtvsfLhYTmnuSYhNg4LUAkwso2AORaKH1LMo5oTxNCSLbsyvIGWHqiHdE+AKmAF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5aae6bc-9c71-49d0-3598-08d7774df28a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:34:56.6023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82a1rBTj25IB11xIUd0k/f1iNDhGLw7CHVoDfDEGD7wg/+f7kXDlaPRdIC07fJSr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2610
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DULw7FqmwnSqOW6SAcKYrF9eT9rMEuRI/gkIeBqmSqI=;
 b=iJizPep9u2+lZAG8X9JbyoX9V8s54q86peN1FkvND5dW2tq/Je5DeaIzsBglfR7OyCo9tMBHrq/Sw8OzsZX7PSmX+y8nO02UGo8u7aAYejxnu5fzR+rXjmbaN2tmxE+5UnK4V2OND3QXwy6Yd5piciP+q0w4bVdtUCyV5CTnvzM=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sunpeng.Li@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Leo Li <sunpeng.li@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 rodrigo.siqueira@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>,
 harry.wentland@amd.com, bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogWW9uZ3FpYW5nIFN1biA8eW9uZ3FpYW5nLnN1bkBhbWQuY29tPgoKU2lnbmVkLW9mZi1i
eTogWW9uZ3FpYW5nIFN1biA8eW9uZ3FpYW5nLnN1bkBhbWQuY29tPgpSZXZpZXdlZC1ieTogVG9u
eSBDaGVuZyA8VG9ueS5DaGVuZ0BhbWQuY29tPgpBY2tlZC1ieTogTGVvIExpIDxzdW5wZW5nLmxp
QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvaW5jL2RtdWJf
dHJhY2VfYnVmZmVyLmggfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL2luYy9kbXViX3RyYWNl
X2J1ZmZlci5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvaW5jL2RtdWJfdHJh
Y2VfYnVmZmVyLmgKaW5kZXggYjBlZTA5OWQ4YTZlLi42YjNlZTQyZGIzNTAgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL2luYy9kbXViX3RyYWNlX2J1ZmZlci5o
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL2luYy9kbXViX3RyYWNlX2J1
ZmZlci5oCkBAIC00NSw2ICs0NSw3IEBAIGVudW0gZG11Y2JfdHJhY2VfY29kZSB7CiAJRE1DVUJf
X0RNQ1VfSVNSX0xPQURfRU5ELAogCURNQ1VCX19NQUlOX0lETEUsCiAJRE1DVUJfX1BFUkZfVFJB
Q0UsCisJRE1DVUJfX1BHX0RPTkUsCiB9OwogCiBzdHJ1Y3QgZG1jdWJfdHJhY2VfYnVmX2VudHJ5
IHsKLS0gCjIuMjQuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
