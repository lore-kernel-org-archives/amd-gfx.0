Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26340C432C3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01BDA20865
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01BDA20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 923176E2C7;
	Mon,  2 Dec 2019 17:35:16 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820054.outbound.protection.outlook.com [40.107.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42D8A6E2C7
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bv5KtAy3UIsHZv+jYrWbpK8QGAWVGyHOMw6qYlSyxBRKr68rglEfTxZXaPgEOYIfNaUNNV8jvYTcLj9qZVfB35oD0JrNS2n/Qw3I6BUUNN//SLzu9Lqb3eftu0ZlVsyjtvb4VV7sAuivpazanVAJDlNoJfZsgTqDjHaCEBU0W+RRJ3L2BjLVFp21VNXYJnfhReUJPf/Kd8knME/VQO5gdAe7zzZJ3PGO0wZkB7timQnLIuNObbccpiDJi+bFoZEDAx9ip8RTzvfWaVl6lGKml/pSbIJuVS8JVqzk8Gs9854U5F07fjy6toVZ4lRXZNgNeXf3Osf9tsSmYu2DXeoyXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znbA3gAtpm9Jgg/7sP8m1mXjerEyVUQhN1BVzGonM5M=;
 b=f55YTdablwCpdStbEbk3r+8a+BhxoTqDRZDuIk967B6YxUUqfb3XX0qPBiFrhrW+vj2GnkB1ujbO/1OiyD6ihFtS+4PAetDxLgB0Hg0581EX8xdwv77cyzDfKyXZ4Uq5Cjt/EobZWZ04b2+FxIcx+s0YV7gGEARIuSH5LxFt5DQVCwzlSw5S/KQmssnFG4aaIaZCOBIHdENpLSJOsdsLuucYOMX0OICkFCMKD+nLHL2ZrjPmMwooSCTovU+iLQ+1ca14gC7+kDF4g+K4iRAR/NnSsAz1w7hITwVPKJPwOqDRwIcMlQdMP/8g/34hFTHsPIM8/iwcDkCjJ54sv8hhGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2802.namprd12.prod.outlook.com (20.176.27.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:09 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:09 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 24/51] drm/amd/display: Reset steer fifo before unblanking the
 stream
Date: Mon,  2 Dec 2019 12:33:38 -0500
Message-Id: <20191202173405.31582-25-sunpeng.li@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 035054ed-9395-4c87-c33b-08d7774dfa8a
X-MS-TrafficTypeDiagnostic: BN7PR12MB2802:|BN7PR12MB2802:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB28020DE5D7C1287ECD73C6F982430@BN7PR12MB2802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
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
X-Microsoft-Antispam-Message-Info: 0Gx8quNmS0zgelZvra1N2sJtmSOawwfORPP0RKJ6q/lsmzowBjBK5cs5SVZlQxxVMTYlDEgkg6liFXJvPXKD9nt/gAMZmk1Q+m1DbR9lxAp9JKtYLRkOGKuQV3jsUrpqrj/WC5PNWMv3usPSZtj74ShC34Pc5+9tpPFfuxgt3sFqQ7aV/17d+09cijLKKKovjoIYYq/LOv5X3rv4YyYa+JH1CUjXUng0oIV8OZpUXJ6w3ekLKf8/xqrC06j8YFiwuDs3FnXmN0s7h3QCGJRhDAKEONuBzX2EWtQ/ZmFiCtFAlO2QGHA/lYn2PP/TeWkyR0SRXLx28k170Qz5ANVXn4csHiQZkcidShRiNSQBs9lWzFCmlnfZ4Q/k1sbb1LxWawxdVpW45S7FqFYuzmJjZAWXDd+3iQ8nnDz2Wq217KJCu3kH9CtLlNp4xzDBZTuZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 035054ed-9395-4c87-c33b-08d7774dfa8a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:09.8817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2Xq1HnJxKfMiQ0mPEbcgC+L6X+rhfBZdRvEPF1bAJdb+Jpnn95jYl4kus7G2JyX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2802
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znbA3gAtpm9Jgg/7sP8m1mXjerEyVUQhN1BVzGonM5M=;
 b=OdgDL1OKiPPH/bUTV6wPenSg8iWd4bZeBh0e1mzIPmPzNzXP9MRfkGzrs0+gwelJVdLDefXPhg6Y7by++8+HCiwNc7WbSpV2tE1pmL+BHh7Qo2E/ZMvd2itKpwyWFqBsk19Uc5W56QuxGgYVjfT1Rrdxyn3xe8ZiA5CbgENQSXQ=
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
 rodrigo.siqueira@amd.com, Nikola Cornij <nikola.cornij@amd.com>,
 harry.wentland@amd.com, bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogTmlrb2xhIENvcm5paiA8bmlrb2xhLmNvcm5pakBhbWQuY29tPgoKW3doeV0KRHVyaW5n
IG1vZGUgdHJhbnNpdGlvbiBzdGVlciBmaWZvIGNvdWxkIG92ZXJmbG93LiBRdWl0ZSBvZnRlbiBp
dApyZWNvdmVycyBieSBpdHNlbGYsIGJ1dCBzb21ldGltZXMgaXQgZG9lc24ndC4KCltob3ddCkFk
ZCBzdGVlciBmaWZvIHJlc2V0IGJlZm9yZSB1bmJsYW5raW5nIHRoZSBzdHJlYW0uIEFsc28gYWRk
IGEgc2hvcnQKZGVsYXkgd2hlbiByZXNldHRpbmcgZGlnIHJlc3luYyBmaWZvIHRvIG1ha2Ugc3Vy
ZSByZWdpc3RlciB3cml0ZXMKZG9uJ3QgZW5kIHVwIGJhY2stdG8tYmFjaywgaW4gd2hpY2ggY2Fz
ZSB0aGUgSFcgbWlnaHQgbWlzcyB0aGUgcmVzZXQKcmVxdWVzdC4KClNpZ25lZC1vZmYtYnk6IE5p
a29sYSBDb3JuaWogPG5pa29sYS5jb3JuaWpAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IFRvbnkgQ2hl
bmcgPFRvbnkuQ2hlbmdAYW1kLmNvbT4KQWNrZWQtYnk6IExlbyBMaSA8c3VucGVuZy5saUBhbWQu
Y29tPgotLS0KIC4uLi9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfc3RyZWFtX2VuY29k
ZXIuYyAgfCAxMiArKysrKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kY24yMC9kY24yMF9zdHJlYW1fZW5jb2Rlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2RjbjIwL2RjbjIwX3N0cmVhbV9lbmNvZGVyLmMKaW5kZXggYmUwOTc4NDAxNDc2
Li45YjcwYTFlN2I5NjIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kY24yMC9kY24yMF9zdHJlYW1fZW5jb2Rlci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY24yMC9kY24yMF9zdHJlYW1fZW5jb2Rlci5jCkBAIC00ODgsMTUgKzQ4OCwy
MyBAQCB2b2lkIGVuYzJfc3RyZWFtX2VuY29kZXJfZHBfdW5ibGFuaygKIAkJCQlEUF9WSURfTl9N
VUwsIG5fbXVsdGlwbHkpOwogCX0KIAotCS8qIHNldCBESUdfU1RBUlQgdG8gMHgxIHRvIHJlc2V0
IEZJRk8gKi8KKwkvKiBtYWtlIHN1cmUgc3RyZWFtIGlzIGRpc2FibGVkIGJlZm9yZSByZXNldHRp
bmcgc3RlZXIgZmlmbyAqLworCVJFR19VUERBVEUoRFBfVklEX1NUUkVBTV9DTlRMLCBEUF9WSURf
U1RSRUFNX0VOQUJMRSwgZmFsc2UpOworCVJFR19XQUlUKERQX1ZJRF9TVFJFQU1fQ05UTCwgRFBf
VklEX1NUUkVBTV9TVEFUVVMsIDAsIDEwLCA1MDAwKTsKIAorCS8qIHNldCBESUdfU1RBUlQgdG8g
MHgxIHRvIHJlc2V0IEZJRk8gKi8KIAlSRUdfVVBEQVRFKERJR19GRV9DTlRMLCBESUdfU1RBUlQs
IDEpOworCXVkZWxheSgxKTsKIAogCS8qIHdyaXRlIDAgdG8gdGFrZSB0aGUgRklGTyBvdXQgb2Yg
cmVzZXQgKi8KIAogCVJFR19VUERBVEUoRElHX0ZFX0NOVEwsIERJR19TVEFSVCwgMCk7CiAKLQkv
KiBzd2l0Y2ggRFAgZW5jb2RlciB0byBDUlRDIGRhdGEgKi8KKwkvKiBzd2l0Y2ggRFAgZW5jb2Rl
ciB0byBDUlRDIGRhdGEsIGJ1dCByZXNldCBpdCB0aGUgZmlmbyBmaXJzdC4gSXQgbWF5IGhhcHBl
bgorCSAqIHRoYXQgaXQgb3ZlcmZsb3dzIGR1cmluZyBtb2RlIHRyYW5zaXRpb24sIGFuZCBzb21l
dGltZXMgZG9lc24ndCByZWNvdmVyLgorCSAqLworCVJFR19VUERBVEUoRFBfU1RFRVJfRklGTywg
RFBfU1RFRVJfRklGT19SRVNFVCwgMSk7CisJdWRlbGF5KDEwKTsKIAogCVJFR19VUERBVEUoRFBf
U1RFRVJfRklGTywgRFBfU1RFRVJfRklGT19SRVNFVCwgMCk7CiAKLS0gCjIuMjQuMAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
