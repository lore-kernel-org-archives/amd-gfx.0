Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49921C432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2968320848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2968320848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECE3B6E2B0;
	Mon,  2 Dec 2019 17:35:11 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800050.outbound.protection.outlook.com [40.107.80.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 678936E2BD
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXOwRs9deS8MM6Lf4RZ2OOQ7X7aVEwbMrbrFO/9HMl5TcQFue7zCSv5rjPTbgUH4+f7N2gSyAJ5vH9qPQxf0RQGV1yGOEQgEA2dt6XlFOHyCL52ljzj+OY+Jv9n2ApNFeaK3ssJW00sMaAvwBEUFlDMgzepmHzcDAAUmXEgjI0MM4N/rWP/cylqPBSwHCuAzGZv81Zw1oorsoD1DtnbYWWQbVzNaefKcg30ihuVqHMO/wokORCnuMLdS/gL8KFDs7B3xI1gN/Oel4rV5A5CsGieqrtgkBNED70ovxMamDzJgMwSUSs+XXo33p9afd2alQV99JgYR0rI1qyiVWcVwmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8J10G/7kZS9V1jDxYMRYxsu5T/VV8DCRDYwGBY11qU=;
 b=QF5TN+GBLzPz9hgLxDhnQ6yB/2oJq+KQkOOTARenfDC9KMojhA9fqmuyVOHH7NgEbP6dOUt5107fR+VaO4pIOHQzSr8Ka198xAeQzSH/VTtRyIbxit0m2cesjW/NLr2Lh+jr45tKRW0LXzWLOa6sz0Pv5xdqFqOa+MWIaacku1mcQXpJumuePhnht2MCHmy8w2+NLNsvV5Qo4nepoB6TjsJA1lhjvZEoQMH2fx0j4vugIhV6ZLf16Rj0ozPJiXYjt3/qSi1bEctggMOr+TagRIy/oQUzC4oUOdGm/ITblhtbIR+A7wZGZPBZ4phCIhNFDckGnLszCwMo1XbVOfTOag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2610.namprd12.prod.outlook.com (20.176.26.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:09 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:09 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 23/51] drm/amd/display: fix dml20 min_dst_y_next_start
 calculation
Date: Mon,  2 Dec 2019 12:33:37 -0500
Message-Id: <20191202173405.31582-24-sunpeng.li@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: bde91c0c-733c-46cb-e380-08d7774df9f0
X-MS-TrafficTypeDiagnostic: BN7PR12MB2610:|BN7PR12MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2610CF8BC991EDD09C8607CC82430@BN7PR12MB2610.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(189003)(199004)(76176011)(6666004)(51416003)(52116002)(6512007)(66476007)(66556008)(316002)(50226002)(5660300002)(6916009)(81166006)(26005)(2616005)(99286004)(386003)(6506007)(1076003)(8936002)(11346002)(305945005)(446003)(81156014)(186003)(9686003)(6436002)(4326008)(8676002)(6486002)(7736002)(66946007)(54906003)(48376002)(50466002)(86362001)(6116002)(2351001)(3846002)(2906002)(25786009)(36756003)(66066001)(2870700001)(2361001)(14454004)(478600001)(47776003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2610;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+uZtqR64ZvB6hojWwO1hlnp4RSjmCTLzXHWBItUsEfSOt5Sg8zEltj36zGldCfXb2+ZV0etLmUmYc6Grb2dgMAnpTRhXvZSEUJSKoyhI6GyZmlsIfMVkYNdTjy7pmjOqHS0kaibykE/Y0/IBe1FjFNNZF8YZJljBDCM2wXsLviJCaKiCbfhvbqEyi8pBjfVui4nz6+XD2kiHiu1CH4NOeLO7ENSv8UY58ONFED253SzA21SW6s4QTIFGK0sfvL9aXXVDMJU7kCqotlnrPy7IBHylWrUZh7VyJvZ6j4m+OTUCKPZ95tRGE9dA7kOXIo910o4Iil357IcpthGNk6XrgI6zy72WWsBjdLMPzCQI1uV3nPC4d8gonIO5OHi1Sa4kty7HhugovZ+2M09C6DOA5CTHNqt8aBmO/VGxd4fgiELUDgA1N4u5B8KGE+rskaA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde91c0c-733c-46cb-e380-08d7774df9f0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:08.9932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNd7DOWrQHRGMXXDltYK+mc5FJjT4SDu54V8wNGbKRsMRlRmFUwcqgo+lWPRa/og
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2610
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8J10G/7kZS9V1jDxYMRYxsu5T/VV8DCRDYwGBY11qU=;
 b=ysYcpYP2n3OgLD8R6AvFw1uN2QdKGiwT0xjvbURUQghNugczchSsr7Y2U6HRl+WN8E5QohHPnb64gmUzzz41GVcBsmcvmI8EMXL2Ti6V8zeslbguGoY6XHj3jsMr7Xi3qUhVPPFMvPTCi9Wnc5UDm2nDPNE1Bi7Sr9z8LpUmtBg=
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
 rodrigo.siqueira@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 harry.wentland@amd.com, bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogRG15dHJvIExha3R5dXNoa2luIDxEbXl0cm8uTGFrdHl1c2hraW5AYW1kLmNvbT4KCkJy
aW5nIHRoaXMgY2FsY3VsYXRpb24gaW4gbGluZSB3aXRoIEhXIHByb2dyYW1taW5nIGd1aWRlLgoK
U2lnbmVkLW9mZi1ieTogRG15dHJvIExha3R5dXNoa2luIDxEbXl0cm8uTGFrdHl1c2hraW5AYW1k
LmNvbT4KUmV2aWV3ZWQtYnk6IFRvbnkgQ2hlbmcgPFRvbnkuQ2hlbmdAYW1kLmNvbT4KQWNrZWQt
Ynk6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgotLS0KIC4uLi9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RtbC9kY24yMC9kaXNwbGF5X3JxX2RsZ19jYWxjXzIwLmMgIHwgMyArLS0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2RjbjIwL2Rpc3BsYXlfcnFfZGxnX2Nh
bGNfMjAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvZGNuMjAvZGlzcGxh
eV9ycV9kbGdfY2FsY18yMC5jCmluZGV4IDJjNzQ1NWUyMmE2NS4uOWRmMjRlY2VjY2VjIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2RjbjIwL2Rpc3BsYXlf
cnFfZGxnX2NhbGNfMjAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1s
L2RjbjIwL2Rpc3BsYXlfcnFfZGxnX2NhbGNfMjAuYwpAQCAtOTI5LDggKzkyOSw3IEBAIHN0YXRp
YyB2b2lkIGRtbDIwX3JxX2RsZ19nZXRfZGxnX3BhcmFtcyhzdHJ1Y3QgZGlzcGxheV9tb2RlX2xp
YiAqbW9kZV9saWIsCiAJbWluX2RzdF95X3R0dV92YmxhbmsgPSBtaW5fdHR1X3ZibGFuayAqIHBj
bGtfZnJlcV9pbl9taHogLyAoZG91YmxlKSBodG90YWw7CiAJZGxnX3ZibGFua19zdGFydCA9IGlu
dGVybGFjZWQgPyAodmJsYW5rX3N0YXJ0IC8gMikgOiB2Ymxhbmtfc3RhcnQ7CiAKLQlkaXNwX2Rs
Z19yZWdzLT5taW5fZHN0X3lfbmV4dF9zdGFydCA9ICh1bnNpZ25lZCBpbnQpICgoKGRvdWJsZSkg
ZGxnX3ZibGFua19zdGFydAotCQkJKyBtaW5fZHN0X3lfdHR1X3ZibGFuaykgKiBkbWxfcG93KDIs
IDIpKTsKKwlkaXNwX2RsZ19yZWdzLT5taW5fZHN0X3lfbmV4dF9zdGFydCA9ICh1bnNpZ25lZCBp
bnQpICgoZG91YmxlKSBkbGdfdmJsYW5rX3N0YXJ0ICogZG1sX3BvdygyLCAyKSk7CiAJQVNTRVJU
KGRpc3BfZGxnX3JlZ3MtPm1pbl9kc3RfeV9uZXh0X3N0YXJ0IDwgKHVuc2lnbmVkIGludCkgZG1s
X3BvdygyLCAxOCkpOwogCiAJZG1sX3ByaW50KCJETUxfRExHOiAlczogbWluX2RjZmNsa19taHog
ICAgICAgICAgICAgICAgICAgICAgICAgPSAlMy4yZlxuIiwKLS0gCjIuMjQuMAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
