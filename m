Return-Path: <SRS0=m9pB=DM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF73BC4363D
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2020 14:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6071A20776
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2020 14:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Nhsx+9xo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6071A20776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7CBD89CF8;
	Mon,  5 Oct 2020 14:41:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 129DF89CF8
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2020 14:41:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHRtDXW2U5XZfaimuU4LchW4fiXw1fagJuOr93YdOln5jL8iiIwxONIMIBT23Jih47t2V57Tt0R77YHb1SSpShAScy2+7egysFhnW221HdL1nr1SXRwyto67WrRydDpaBL3QpuP3WJbRcpOCe5BXgNM3/Q12qNEEyCmlyPHO3BUlkzoKF59s5mPiLmp1tmqu3N7PPi5x0lnvA1P1jQ2nMpYAkEMAdOF/rVxWZHRqWKOswnN2VAXCWZJZ1ZoLOX4wJc59pjmXwIs0t+bYSs8ZMqt0wp7jpOTDhNJwftNg713N7X4JiHboibFHBroyzsrBVauo3n3QqdDGrWRWQiHsag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asLZ7eqQ2VLIq96i1VI0X7KEpURtmBi98Sc3+G+SNw8=;
 b=bK4348fpYQPd9PHelyJ6QK3RAQ/T+dcvuv/1VaXoDKTgwkNEcJ1HnUQdFX9QBsFTUnPKTffhi+RyrbttvJWSRalBIx50mcqGibDtiKQmSMyFaaEC066Ru7A+c/tnQ7Kn6JmpwT8IXjPs+/GM5N+gkjdDxjSJt9Qnl8W7EQvXf7EOewzfIhv5SZn2XEIMmrRJSGUPgncFzIwx27006DA+f7loST5hf3kbtUulbVddoiNUmOJx8ySAuE3LQl8+hDpf4QHGAYS6DxIiurFmqj13HqRnXvL/vFs3/Dm9j5MQatcYrJoVxokREkup3aXnSy024+ZGA7AOlnEVk1adhUQl6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asLZ7eqQ2VLIq96i1VI0X7KEpURtmBi98Sc3+G+SNw8=;
 b=Nhsx+9xopGBo4bk51VYfnZaSjnlEL423Y/zc5kC0OwZ6/Leks36dMi82eiKcSUrFLHZkxQcfCAqk89ghWNHUWa6UogUufiV/n1hDt3e6fZnAjSDTcsU9lhxGtbrv1A+D7iGc+ke7jx2awZB85zeLDEHX9qzAN7u7ca/+d6Pl3gk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN6PR12MB2781.namprd12.prod.outlook.com (2603:10b6:805:67::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Mon, 5 Oct
 2020 14:41:32 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::2008:7638:5c9:7169]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::2008:7638:5c9:7169%8]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 14:41:31 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: align frag_end to covered address space
Date: Mon,  5 Oct 2020 09:40:59 -0500
Message-Id: <20201005144059.14765-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM5PR06CA0044.namprd06.prod.outlook.com
 (2603:10b6:3:5d::30) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 DM5PR06CA0044.namprd06.prod.outlook.com (2603:10b6:3:5d::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.37 via Frontend Transport; Mon, 5 Oct 2020 14:41:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7d07647a-21f3-4cdc-42eb-08d8693cc02b
X-MS-TrafficTypeDiagnostic: SN6PR12MB2781:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB278188D450B279DE27821949FD0C0@SN6PR12MB2781.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mvJgSjiHvJeySNfU2mS1j1BIJ0URHT//pWSmUgV3iTr14WlnZA9fOeTsLzP69a7y35NgiPfvlRyCNDPYZuUQ2icEDUFXW/C4yNJnBe7NKckNnARL8k5Y6iK9tkBYnYEzwatXSODNcdvuueeu1ULYcvB7k9JWNhaGLoVZUVJ6xiz9BKlYg2KQhNmlLoamSR1Ewl/tjnh/oYgtDfrzLXwDvbZtTVN3rfmkpZ8a8Rww2gh/J5uCgf+xr72nnD7boVptFPxshDW8nJp4ibK+3POnbXdc+VEtuPqxK4908AkHSNQ8wI4OqcOu/WOPX/GBEWyXLRCtesV6d4TAIZcWuOhV2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(8936002)(7696005)(8676002)(2906002)(86362001)(956004)(6916009)(2616005)(6666004)(66946007)(66476007)(26005)(66556008)(83380400001)(5660300002)(16526019)(66574015)(186003)(6486002)(36756003)(54906003)(44832011)(478600001)(52116002)(1076003)(4744005)(4326008)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: OW4t5uwOsqofHa94QhN27SPu9mO3f/itwq7gGvoMY4A8SK+mwi76p3zxsEgBK+LHkEf9ZurB3RzK36LlfOWf/Aelso1ZxoWF9HSPBBbQuLqoyDEHngUbTJnFHHPD3cxBfi0v8KnBCBR8WMRnRGEmGTLB8FDy63oQc5LU6yoYFgDWtkRWZvJy4rCAfbGDfRxmwQXzRytbizHso3jyc7X/q2LocRi3UoYfvdcuKjsciSp1C9FzIDqLVV4FvHzNCkwI5nQpb3VcQxeJKP0vOrWDBfpj8x04gDZtcePDyl2OqvrvWHI9KP4FhKsLFrXxvr6Bdmg5Hm7/Ah72FBqsXsHSGQsyQCFGPZER09B5h9TsqROQA0eCfo8nw3FxxDV/CPUNBpd3OtnVeNKunBDjTTELcAJfdG6+LWmrrS8UHePj5Ps47zMwWWzqUkGV2RD94wEwieJW7Dpc1j8EklAcursugXsgA2eINtIkqLbXwxAyR/rsPTXDoloAoIwqnhyE1vzMlzTZPuBXs6Bj218MuqNDejCKpuYCcRy6xxI19R3ZRihe8cDyKf7wPwdqcq1GBNkF0MJEHiNeCuEDKFMz1KQ1WxTln+IDYd8mErOVKsKt47gsdIHTDHW5qWEmWLJ02wL4YIghbZkOphZWkILwlNEPuQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d07647a-21f3-4cdc-42eb-08d8693cc02b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2020 14:41:31.8658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egMKeKcZ2XKX1P4/O7bOxJ8EdZcDW52mgxMcjwpK53AdrSrDxo5+yQsDHIVHOw4dnXw7AA2ZgLithuTQt7j43w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2781
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
Cc: Alex Sierra <alex.sierra@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

YWxpZ24gZnJhZ19lbmQgdG8gdGhlIG5leHQgcGQgd2hlbiB0aGVyZSBhcmUgbm8KcGFnZSB0YWJs
ZSBlbnRyaWVzIG9uIHRoZSBjdXJyZW50IHBkZS4KClNpZ25lZC1vZmYtYnk6IEFsZXggU2llcnJh
IDxhbGV4LnNpZXJyYUBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtLmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwppbmRleCBiNDE1MTdkMGYwMGMuLjNjZDk0
OWFhZDUwMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKQEAgLTE1MDIs
NiArMTUwMiw4IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzKHN0cnVjdCBhbWRn
cHVfdm1fdXBkYXRlX3BhcmFtcyAqcGFyYW1zLAogCiAJCQlwdCA9IGN1cnNvci5lbnRyeS0+YmFz
ZS5ibzsKIAkJCXNoaWZ0ID0gcGFyZW50X3NoaWZ0OworCQkJZnJhZ19lbmQgPSBtYXgoZnJhZ19l
bmQsIEFMSUdOKGZyYWdfc3RhcnQgKyAxLAorCQkJCSAgIDFVTEwgPDwgc2hpZnQpKTsKIAkJfQog
CiAJCS8qIExvb2tzIGdvb2Qgc28gZmFyLCBjYWxjdWxhdGUgcGFyYW1ldGVycyBmb3IgdGhlIHVw
ZGF0ZSAqLwotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
