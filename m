Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C652BC43215
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A43CD2084F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43CD2084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F22766E2B2;
	Mon,  2 Dec 2019 17:35:08 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720044.outbound.protection.outlook.com [40.107.72.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 655736E290
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQuLDJJpFLeeuiQnb1Fgwm7lJ4svsK9/G05TEwh3zd207EExlQ46oMWjwqwwKUH//DONsVfIoNc7A4w2vvE+KCxuStnfKPXVJNTPsKA0fbMZRRkXGiHU+hZYCh8tA16m6va30EacvZcXAAFFlPzGaSNVY97vwxePDNuT0g1VBc8HWDfSemIq20uOrannHTM3YAgszqAUKHzeYaOyc1/1nl4AxL7n10TiqPf6umnNUYAFHc6fpmLVeu8o36U1ETY3ffR0z+Dp3lv7SCoBh2s7++cLp4LHoLCDSfQmvv0L7+6kRbAIDsEtDzXcJaiTFOA8Dp0hPreuje5Plnom/5K0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QvmsZOE1PPhHWe+q9OI2CHj93cyIBz/c7efSSTDYv8=;
 b=dRr85bWdFTK0eEGtbmret3ddR8JzGoVGN032TOv69bYL1EwL+vjcHy+wv5DNbs7KZu2D3v9XLQ6tVYu+SVgpil+p4TuPFMYV3OUqtms/5M9SQZfLw5I0WCJf9KqrMRfn2FCTiByLtjHnhIgIZslVZeyvpAPrN7DRqAAX1LbFZG1DlS7DM8eYeFJ0iGfwrKLmVf7X2w/qM+LHRay3ZxA7levJvOG4XPiRYfYve4/zF/Xe3iLaNinxnVv6eDDrmDliU8x61HG9So+0kwr5ZzUOtxsrJX9wcIqrhBTot6xdQ7BoeAfChU1N4e3Ti5O2EDrqZWKymDF3iz1qNgwcDzG/kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2802.namprd12.prod.outlook.com (20.176.27.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:00 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:00 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/51] drm/amd/display: Program CW5 for tracebuffer for dcn20
Date: Mon,  2 Dec 2019 12:33:27 -0500
Message-Id: <20191202173405.31582-14-sunpeng.li@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4130e086-b509-4105-5d2a-08d7774df43e
X-MS-TrafficTypeDiagnostic: BN7PR12MB2802:|BN7PR12MB2802:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2802E96C0851381E27D7615982430@BN7PR12MB2802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:364;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(189003)(199004)(81166006)(81156014)(86362001)(6486002)(9686003)(6506007)(2870700001)(478600001)(386003)(76176011)(5660300002)(51416003)(186003)(1076003)(52116002)(3846002)(6116002)(47776003)(2616005)(26005)(66946007)(66066001)(25786009)(316002)(446003)(11346002)(14454004)(66476007)(66556008)(48376002)(8676002)(50226002)(305945005)(6512007)(36756003)(2906002)(14444005)(99286004)(6666004)(7736002)(2351001)(54906003)(4326008)(2361001)(6916009)(6436002)(50466002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2802;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0RyHp24/AHzgE595+khMIYkInqAtONEGzwExG9DvJAFaKnDvqL2QYg+K1XEg6mQVIn+Y/zysXcMOjcXrTA0SzVbwQj/AKh047N0u7LXgYlWwzxjucgWP29Dz/f6U+DaK+DcVft9Jcsff1vhqrtG1VTava53ze3nhzaSxGSNDT+KsV7gkZH/+utxbFutBeX+3Hx2ikW9t5MohXJGruXUO3+YcQgYl95zleoyfGzVYq00+LYhgnbTSF0sxcEQwK5LQQyENhqZMtINyhb86HOCE6ywESbHNDbLDcs7Ff7Qja9cQQSaYNm7X4cgLpNZqJTbFUN0f2RqAA++aG+n1+awmpBCI35K8H82qddfjkXsxhl+3mKMJhvdMtugrsJmFmU47oEmUeLN/W9V1kTIs9psPM+Uo2nO59Q9mNJojQ/5V3ZPrTqsE5+D1EO8HTToaNj2M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4130e086-b509-4105-5d2a-08d7774df43e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:34:59.2907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3Dq8cdaKSho8znU8mAtGbOgf0OmJE0Qv16oi5/jA7M8eNcybtPau6fkP5lJxCVc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2802
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QvmsZOE1PPhHWe+q9OI2CHj93cyIBz/c7efSSTDYv8=;
 b=dCnXu3ZePN7krW64GObF9duVEw9C/jx0ppOZM8/dYa065T73QmDk85hVN3dHn+QkT1TM5rRKRw+DIquBKnbG3oJIlR1WCUmGaspvNVTe6ngu9NO7gQR65SW+tyEe49qN4FJ9OID2WyojOn+iSjrjC+I5mIAxxzpGTHjGLvXBMYs=
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
 rodrigo.siqueira@amd.com, harry.wentland@amd.com, bhawanpreet.lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogTmljaG9sYXMgS2F6bGF1c2thcyA8bmljaG9sYXMua2F6bGF1c2thc0BhbWQuY29tPgoK
W1doeV0KT24gZGNuMjEgdGhpcyBpcyBwcm9ncmFtbWVkIGZvciB0cmFjZWJ1ZmZlciBzdXBwb3J0
IGJ1dCBpc24ndCBiZWluZwpwcm9ncmFtbWVkIG9uIGRjbjIwLgoKRE1DVUIgZXhlY3V0aW9uIGhp
dHMgYW4gdW5kZWZpbmVkIGFkZHJlc3MgNjUwMDAwMDAgb24gdHJhY2VidWZmZXIKYWNjZXNzLgoK
W0hvd10KUHJvZ3JhbSBDVzUuCgpTaWduZWQtb2ZmLWJ5OiBOaWNob2xhcyBLYXpsYXVza2FzIDxu
aWNob2xhcy5rYXpsYXVza2FzQGFtZC5jb20+ClJldmlld2VkLWJ5OiBUb255IENoZW5nIDxUb255
LkNoZW5nQGFtZC5jb20+CkFja2VkLWJ5OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9zcmMvZG11Yl9kY24yMC5jIHwgNyAr
KysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJfZGNuMjAuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kbXViL3NyYy9kbXViX2RjbjIwLmMKaW5kZXggNmI3ZDU0NTcy
YWEzLi4zMDJkZDNkNGI3N2QgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kbXViL3NyYy9kbXViX2RjbjIwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RtdWIvc3JjL2RtdWJfZGNuMjAuYwpAQCAtOTksNiArOTksMTMgQEAgdm9pZCBkbXViX2RjbjIw
X3NldHVwX3dpbmRvd3Moc3RydWN0IGRtdWJfc3J2ICpkbXViLAogCVJFR19TRVRfMihETUNVQl9S
RUdJT040X1RPUF9BRERSRVNTLCAwLCBETUNVQl9SRUdJT040X1RPUF9BRERSRVNTLAogCQkgIGN3
NC0+cmVnaW9uLnRvcCAtIGN3NC0+cmVnaW9uLmJhc2UgLSAxLCBETUNVQl9SRUdJT040X0VOQUJM
RSwKIAkJICAxKTsKKworCVJFR19XUklURShETUNVQl9SRUdJT04zX0NXNV9PRkZTRVQsIGN3NS0+
b2Zmc2V0LnUubG93X3BhcnQpOworCVJFR19XUklURShETUNVQl9SRUdJT04zX0NXNV9PRkZTRVRf
SElHSCwgY3c1LT5vZmZzZXQudS5oaWdoX3BhcnQpOworCVJFR19XUklURShETUNVQl9SRUdJT04z
X0NXNV9CQVNFX0FERFJFU1MsIGN3NS0+cmVnaW9uLmJhc2UpOworCVJFR19TRVRfMihETUNVQl9S
RUdJT04zX0NXNV9UT1BfQUREUkVTUywgMCwKKwkJICBETUNVQl9SRUdJT04zX0NXNV9UT1BfQURE
UkVTUywgY3c1LT5yZWdpb24udG9wLAorCQkgIERNQ1VCX1JFR0lPTjNfQ1c1X0VOQUJMRSwgMSk7
CiB9CiAKIHZvaWQgZG11Yl9kY24yMF9zZXR1cF9tYWlsYm94KHN0cnVjdCBkbXViX3NydiAqZG11
YiwKLS0gCjIuMjQuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
