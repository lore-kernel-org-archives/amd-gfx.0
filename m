Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3BDC432C3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:34:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99B5920848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B5920848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 482F16E29E;
	Mon,  2 Dec 2019 17:34:59 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe49::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2120E6E296
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:34:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5wlJaW406FrrBqok2nr8wRTaWdRetSxOQf1x5dnib3mhm+IAVMD9motwzvC6IKXesMb/vAhRBUV43eWqfRXhDLQxX4yVKLF6G/DauzI8b7XADS9/8qM8nqsY0Wl7/FcFO6ymnd//iQ2NzOrtfz5OR8z5I8YGMlTQ0G3Xc0XjmyF856a9AhbgRLtL5tCJUoLZpCWMEHszLatmd+zPzfWCMx7QXT/KLLKKc50RK9NZ9iyxyHeeywT2zGBg3mgBeRacJi41suTFEjYvyV0wUI4Ps3BW4HUdSIO/LP8yz0ckporZH/mrImatu6eb9u6xceB+ciFQQ7pE//VTNWuZUWOSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldoerg8YiMr9ydj+gmMqm+VqDa1EOMrBn0ejm8Rgs7o=;
 b=G5DRiSt5AK2upXHnzFwg4hc95U797QttzYsMvr3HZkxzTtr0Sj/1116MVhl3dnC8HSB4WPg1aEjgSvhbc63MlwfAYLMCd/LGJMmlwnnxc2w4B3Pp8bbm8HmK5wUhznbZkYShc37ruw6LficGGTKsy7fmYmKJXZSJbQ6LvFfcQFAgzbOGOBoXuHrxCRh6PzQS/qpRL3BS2QsvKarTxQQTQKcKD5H9Fqiae1PSf0b599hY5zRLS3v5r9y2m92koN//cOLD8eREvgwuav7v/mDjldWY1LGCTmy14H3+RLHGr9yaf3wcuU2DcUu0b7I62sG2T80uL4YQ+qIS8bH9TThL7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2610.namprd12.prod.outlook.com (20.176.26.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:34:54 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:34:54 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/51] drm/amd/display: Map DSC resources 1-to-1 if numbers of
 OPPs and DSCs are equal
Date: Mon,  2 Dec 2019 12:33:19 -0500
Message-Id: <20191202173405.31582-6-sunpeng.li@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5f4da4d0-a3b7-4c78-de9c-08d7774defd3
X-MS-TrafficTypeDiagnostic: BN7PR12MB2610:|BN7PR12MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2610B572662AAE633342CACC82430@BN7PR12MB2610.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
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
X-Microsoft-Antispam-Message-Info: gC4F2PUuerazcAPzQL6BkDHYCqXpKl2comiv+wGCuAineSTSCMfVAQfGU2Iv1lsXfNDIO7YFXDpQchO+qhsS42yKIjygsNiS8gf/1ApL/qDGows9bv8jAAI7ct2o6oxSlp3cGaucQQf5d0iBZp3E3QU6x1pu+vn8wWvss+yEJMe1KCgw6zoaO9w6r2+qlu23/ZEQFR3EZSd559Fp7oNjtWZ4n3h/0MGGgNbalLaqZ1FLcr0AEcutNCtOyUJ8XUTPKPN+s8o8uHtGkmJEpiVgI1PnpMDoODTTM5OL1/jaoKxxFMsTaE85FsUaISfZ4OpKHHZOi/Kh2igummSiUqy4cdptCmQL/gc8XDf0aeEDNGGXcwTsYhjPMfaCKsI+a/zdZLblIE0Jydhjnwo91Dxd2hPohcX3TARRwNveiSZ30VCYh4ipHS4ivufDZrpfNuEP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4da4d0-a3b7-4c78-de9c-08d7774defd3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:34:51.8939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJt53FEoZjmEPrsCngR+UVpMTbGCcNudGaRcOR2SxBUresGALngClSnAqmPbFp4H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2610
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldoerg8YiMr9ydj+gmMqm+VqDa1EOMrBn0ejm8Rgs7o=;
 b=tbEK6F0/cu8C2/faB2IRqW06gg34XPKcCOieo+AfxQv9ZwKQpgmYgH0b61n09OkIWbU7VTQDJLtSpP7PeObdbINgcJfePWylw2O2hFNTvtngmBCWWbLQfyKnpF9Yk9OmaoY28UlfITbyIugEpsQuHxw/7itMnZSEUh1olwsqgLI=
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
Cc: Leo Li <sunpeng.li@amd.com>, harry.wentland@amd.com,
 rodrigo.siqueira@amd.com, Nikola Cornij <nikola.cornij@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogTmlrb2xhIENvcm5paiA8bmlrb2xhLmNvcm5pakBhbWQuY29tPgoKW3doeV0KT24gQVNJ
Q3Mgd2hlcmUgbnVtYmVyIG9mIERTQ3MgaXMgdGhlIHNhbWUgYXMgT1BQcyB0aGVyZSdzIG5vIG5l
ZWQKZm9yIERTQyByZXNvdXJjZSBtYW5hZ2VtZW50LiBNYXBwcGluZyAxLXRvLTEgZml4ZXMgbW9k
ZS1zZXQtIG9yIFMzLQotcmVsYXRlZCBpc3N1ZXMgZm9yIHN1Y2ggcGxhdGZvcm1zLgoKW2hvd10K
TWFwIERTQyByZXNvdXJjZXMgMS10by0xIHRvIHBpcGVzIG9ubHkgaWYgbnVtYmVyIG9mIE9QUHMg
aXMgdGhlIHNhbWUKYXMgbnVtYmVyIG9mIERTQ3MuIFRoaXMgd2lsbCBzdGlsbCBrZWVwIG90aGVy
IEFTSUNzIHdvcmtpbmcuCkEgZm9sbG93LXVwIHBhdGNoIHRvIGZpeCBtb2RlLXNldCBpc3N1ZXMg
b24gdGhvc2UgQVNJQ3Mgd2lsbCBiZQpyZXF1aXJlZCBpZiB0ZXN0aW5nIHNob3dzIGlzc3VlcyB3
aXRoIG1vZGUgc2V0LgoKU2lnbmVkLW9mZi1ieTogTmlrb2xhIENvcm5paiA8bmlrb2xhLmNvcm5p
akBhbWQuY29tPgpSZXZpZXdlZC1ieTogRG15dHJvIExha3R5dXNoa2luIDxEbXl0cm8uTGFrdHl1
c2hraW5AYW1kLmNvbT4KQWNrZWQtYnk6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgotLS0K
IC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMgICB8IDEz
ICsrKysrKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24y
MC9kY24yMF9yZXNvdXJjZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIw
L2RjbjIwX3Jlc291cmNlLmMKaW5kZXggZGE3YTkyZmMwOTA5Li4yYWE2YzBiZTQ1YjQgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJj
ZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNv
dXJjZS5jCkBAIC0xNDU4LDEzICsxNDU4LDIwIEBAIGVudW0gZGNfc3RhdHVzIGRjbjIwX2J1aWxk
X21hcHBlZF9yZXNvdXJjZShjb25zdCBzdHJ1Y3QgZGMgKmRjLCBzdHJ1Y3QgZGNfc3RhdGUKIAog
c3RhdGljIHZvaWQgYWNxdWlyZV9kc2Moc3RydWN0IHJlc291cmNlX2NvbnRleHQgKnJlc19jdHgs
CiAJCQljb25zdCBzdHJ1Y3QgcmVzb3VyY2VfcG9vbCAqcG9vbCwKLQkJCXN0cnVjdCBkaXNwbGF5
X3N0cmVhbV9jb21wcmVzc29yICoqZHNjKQorCQkJc3RydWN0IGRpc3BsYXlfc3RyZWFtX2NvbXBy
ZXNzb3IgKipkc2MsCisJCQlpbnQgcGlwZV9pZHgpCiB7CiAJaW50IGk7CiAKIAlBU1NFUlQoKmRz
YyA9PSBOVUxMKTsKIAkqZHNjID0gTlVMTDsKIAorCWlmIChwb29sLT5yZXNfY2FwLT5udW1fZHNj
ID09IHBvb2wtPnJlc19jYXAtPm51bV9vcHApIHsKKwkJKmRzYyA9IHBvb2wtPmRzY3NbcGlwZV9p
ZHhdOworCQlyZXNfY3R4LT5pc19kc2NfYWNxdWlyZWRbcGlwZV9pZHhdID0gdHJ1ZTsKKwkJcmV0
dXJuOworCX0KKwogCS8qIEZpbmQgZmlyc3QgZnJlZSBEU0MgKi8KIAlmb3IgKGkgPSAwOyBpIDwg
cG9vbC0+cmVzX2NhcC0+bnVtX2RzYzsgaSsrKQogCQlpZiAoIXJlc19jdHgtPmlzX2RzY19hY3F1
aXJlZFtpXSkgewpAQCAtMTUwNSw3ICsxNTEyLDcgQEAgc3RhdGljIGVudW0gZGNfc3RhdHVzIGFk
ZF9kc2NfdG9fc3RyZWFtX3Jlc291cmNlKHN0cnVjdCBkYyAqZGMsCiAJCWlmIChwaXBlX2N0eC0+
c3RyZWFtICE9IGRjX3N0cmVhbSkKIAkJCWNvbnRpbnVlOwogCi0JCWFjcXVpcmVfZHNjKCZkY19j
dHgtPnJlc19jdHgsIHBvb2wsICZwaXBlX2N0eC0+c3RyZWFtX3Jlcy5kc2MpOworCQlhY3F1aXJl
X2RzYygmZGNfY3R4LT5yZXNfY3R4LCBwb29sLCAmcGlwZV9jdHgtPnN0cmVhbV9yZXMuZHNjLCBp
KTsKIAogCQkvKiBUaGUgbnVtYmVyIG9mIERTQ3MgY2FuIGJlIGxlc3MgdGhhbiB0aGUgbnVtYmVy
IG9mIHBpcGVzICovCiAJCWlmICghcGlwZV9jdHgtPnN0cmVhbV9yZXMuZHNjKSB7CkBAIC0xNjk3
LDcgKzE3MDQsNyBAQCBib29sIGRjbjIwX3NwbGl0X3N0cmVhbV9mb3Jfb2RtKAogCX0KIAluZXh0
X29kbV9waXBlLT5zdHJlYW1fcmVzLm9wcCA9IHBvb2wtPm9wcHNbbmV4dF9vZG1fcGlwZS0+cGlw
ZV9pZHhdOwogCWlmIChuZXh0X29kbV9waXBlLT5zdHJlYW0tPnRpbWluZy5mbGFncy5EU0MgPT0g
MSkgewotCQlhY3F1aXJlX2RzYyhyZXNfY3R4LCBwb29sLCAmbmV4dF9vZG1fcGlwZS0+c3RyZWFt
X3Jlcy5kc2MpOworCQlhY3F1aXJlX2RzYyhyZXNfY3R4LCBwb29sLCAmbmV4dF9vZG1fcGlwZS0+
c3RyZWFtX3Jlcy5kc2MsIG5leHRfb2RtX3BpcGUtPnBpcGVfaWR4KTsKIAkJQVNTRVJUKG5leHRf
b2RtX3BpcGUtPnN0cmVhbV9yZXMuZHNjKTsKIAkJaWYgKG5leHRfb2RtX3BpcGUtPnN0cmVhbV9y
ZXMuZHNjID09IE5VTEwpCiAJCQlyZXR1cm4gZmFsc2U7Ci0tIAoyLjI0LjAKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
