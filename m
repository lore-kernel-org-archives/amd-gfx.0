Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FDAC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70B8E2184C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B8E2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0BF66EA2C;
	Tue, 12 Nov 2019 00:33:54 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800059.outbound.protection.outlook.com [40.107.80.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E21D6EA2D
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 00:33:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5AjCnBCsjaWW4zaDHNF6kRvZ60CVmsS43soyLxcW9l5wZOz0llexU6lXvi7e20bKSe0CSRwFbGUHL3LmicltV2WX3Ok8ffgqqdOr5qTPN/ICseypZrO6tWhMQSUUVJ+b46KRsaRnQPCQ+N9voStxI+f1O0ukieVjefaZ2DTwRUco1XrjJWb58TkgTHTfN+m9x6yyaScVLYM2OUdeT0vDLHoUtr0snsLT+0UrnUsIp1Nk4V7FEB3fgeKnhVDJi0g4FDDpnIOjJwwZu4QYinl6sJMqSEfmXxQwr+0E6p0fGbmeVowXVebrxH/uUVE4hYWjjnG7bX+NZtYwAJrk9DcHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E71dxHJjIN5yTTebCBA02hCdsnpb0iCF1hAvs/bGApc=;
 b=CN1achILvzZbqtrraryjx6rS37D2FJv8jl5s2gJpS9kSkYozXCI6HDW4+JHwMfeTsijBjuvyR3fn+av7o4udZUvLzhvKFjWPso7VOzkRCkPVFwWGpHF/zirD5ShPIpkPMMEzg081DR8z9gBmeE5E1CxaO1MIZC4k1ReklT0J5AOdq0Oyyrs3kukhg3ymFwsYMJr2WCIP32583lwegiCb26fH/fCPZyHOsjUPBV3ktsEjxi6Jzwd7Ug3fl7xMrf6AuKpc/saDkw9QSJXMitFUAmEk0Jw8vOBkt/1XXW6a3dzr3kgmb/VIO+KuYM6YaBBt25cAuHvUlfS8azt3/YlFuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2554.namprd12.prod.outlook.com (52.132.180.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 00:33:52 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 00:33:52 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/30] drm/amd/display: Add DMUB service function check if hw
 initialized
Date: Mon, 11 Nov 2019 19:33:04 -0500
Message-Id: <20191112003324.8419-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112003324.8419-1-Rodrigo.Siqueira@amd.com>
References: <20191112003324.8419-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 72bb29e1-7862-41e8-49d3-08d76707fe0d
X-MS-TrafficTypeDiagnostic: MW2PR12MB2554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25545BD30994387653C0C74298770@MW2PR12MB2554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(189003)(199004)(76176011)(6916009)(81166006)(81156014)(386003)(8676002)(478600001)(6506007)(51416003)(52116002)(2870700001)(25786009)(2906002)(186003)(2361001)(3846002)(316002)(66066001)(47776003)(50466002)(4326008)(26005)(66946007)(6116002)(36756003)(1076003)(8936002)(48376002)(50226002)(54906003)(2616005)(305945005)(486006)(5660300002)(6512007)(14454004)(2351001)(446003)(6486002)(6666004)(99286004)(66556008)(476003)(66476007)(11346002)(86362001)(6436002)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2554;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EIyBvZzie7s+zamo+Ea+fnkd9VhXQQ5yU84TF0b9KuMlddUQa3wSCJ9zNPBWNA9wo+TjY7Nq05Pbpw8xW2vdBJ3hYSWAZH/z5AttvEkYQdr8wHqvKTRlMNWpF7bqP0o4IycHDznFZTPNOV4U0YWuqwgg09Dm9jNLh5HOZ1Gnaxj6+B/fQPyPbVkQvmL3ptQlrZOmGpMmhWjyyutOcfpnHRnyGSP5GOn2lflN3Aelxb9X6l8UP6jukkXJMtmB40YQNuHmJ8QbqfVSlBFvXAEft36l5d8GbUGDLePut6mNxh+8FZf33zkL1sNY7EVpfChOZDv3FSX+rVNCRYa291FqwMxDtL76KWx4KfLAorTiSYJqjdwiq5oXVFu5VZ5MNXkqL4dMas3cedUyP3f7lraicgsx4mSCUJvN+nJsCI0UBJW6jBC1X23LLqBttwHPzdfF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72bb29e1-7862-41e8-49d3-08d76707fe0d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 00:33:52.2659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/JaeH+RNzH5Y5tMr/egXE9orXVehidP/5udO+sFpwc/N2Rliz1B7ijjSjSPOHQA3Kcqxt++NJjub2jWI4q1iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2554
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E71dxHJjIN5yTTebCBA02hCdsnpb0iCF1hAvs/bGApc=;
 b=JY0l1IFCym4MXE0Hf9e02qpIVUcAKY2mKl52yEAtpvNh0XZOp3avNiwqdPX5WsJqroyNG2HytFKOEJhhIuDZKUg/wn7K5S6GsCPtt9DMJqAmcNfCryTAcT2af8svXSouv0ntApulMLAqgpqRXOiSgAuYlJeP3GN/RPh1n85UWOc=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
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
Cc: Tony Cheng <Tony.Cheng@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112003304.VYo6ihD8DJ8S3kLXGxlQ2AU7K2uE9jB_RnIzSpqnvCU@z>

RnJvbTogTmljaG9sYXMgS2F6bGF1c2thcyA8bmljaG9sYXMua2F6bGF1c2thc0BhbWQuY29tPgoK
W1doeV0KV2Ugd2FudCB0byBhdm9pZCByZXByb2dyYW1taW5nIHRoZSBjYWNoZSB3aW5kb3cgd2hl
biBwb3NzaWJsZS4KCldlIGRvbid0IG5lZWQgdG8gd29ycnkgYWJvdXQgaXQgZm9yIFMzIGJ1dCB3
ZSAqZG8qIG5lZWQgdG8gd29ycnkgYWJvdXQKaXQgZm9yIFM0IHJlc3VtZS4KCkRNIGNhbiBjaGVj
ayB3aGV0aGVyIGhhcmR3YXJlIHNob3VsZCBiZSByZWluaXRpYWxpemVkIG9yIHN0b3JlIHNvZnR3
YXJlCnN0YXRlIHdoZW4gZ29pbmcgdG8gUzQgdG8ga25vdyB3aGV0aGVyIHdlIG5lZWQgdG8gcmVw
cm9ncmFtIGhhcmR3YXJlLgoKW0hvd10KQWRkIGhlbHBlcnMgdG8gdGhlIERNVUIgc2VydmljZSB0
byBjaGVjayBoYXJkd2FyZSBpbml0aWFsaXphdGlvbiBzdGF0ZS4KCkRNIHdpbGwgaG9vayBpdCB1
cCBsYXRlci4KClNpZ25lZC1vZmYtYnk6IE5pY2hvbGFzIEthemxhdXNrYXMgPG5pY2hvbGFzLmth
emxhdXNrYXNAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IFRvbnkgQ2hlbmcgPFRvbnkuQ2hlbmdAYW1k
LmNvbT4KQWNrZWQtYnk6IFJvZHJpZ28gU2lxdWVpcmEgPFJvZHJpZ28uU2lxdWVpcmFAYW1kLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9pbmMvZG11Yl9zcnYuaCAg
IHwgMTEgKysrKysrKysrKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL3NyYy9k
bXViX2RjbjIwLmMgfCAgNSArKysrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIv
c3JjL2RtdWJfZGNuMjAuaCB8ICAyICsrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11
Yi9zcmMvZG11Yl9zcnYuYyAgIHwgMTQgKysrKysrKysrKysrKysKIDQgZmlsZXMgY2hhbmdlZCwg
MzIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kbXViL2luYy9kbXViX3Nydi5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIv
aW5jL2RtdWJfc3J2LmgKaW5kZXggYWE4ZjAzOTY2MTZkLi43NmU4MDEzODMwM2IgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL2luYy9kbXViX3Nydi5oCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL2luYy9kbXViX3Nydi5oCkBAIC0yNTIs
NiArMjUyLDggQEAgc3RydWN0IGRtdWJfc3J2X2h3X2Z1bmNzIHsKIAogCWJvb2wgKCppc19zdXBw
b3J0ZWQpKHN0cnVjdCBkbXViX3NydiAqZG11Yik7CiAKKwlib29sICgqaXNfaHdfaW5pdCkoc3Ry
dWN0IGRtdWJfc3J2ICpkbXViKTsKKwogCWJvb2wgKCppc19waHlfaW5pdCkoc3RydWN0IGRtdWJf
c3J2ICpkbXViKTsKIAogCWJvb2wgKCppc19hdXRvX2xvYWRfZG9uZSkoc3RydWN0IGRtdWJfc3J2
ICpkbXViKTsKQEAgLTM4MCw2ICszODIsMTUgQEAgZW51bSBkbXViX3N0YXR1cyBkbXViX3Nydl9j
YWxjX2ZiX2luZm8oc3RydWN0IGRtdWJfc3J2ICpkbXViLAogZW51bSBkbXViX3N0YXR1cyBkbXVi
X3Nydl9oYXNfaHdfc3VwcG9ydChzdHJ1Y3QgZG11Yl9zcnYgKmRtdWIsCiAJCQkJCSBib29sICpp
c19zdXBwb3J0ZWQpOwogCisvKioKKyAqIGRtdWJfc3J2X2lzX2h3X2luaXQoKSAtIHJldHVybnMg
aGFyZHdhcmUgaW5pdCBzdGF0ZQorICoKKyAqIFJldHVybjoKKyAqICAgRE1VQl9TVEFUVVNfT0sg
LSBzdWNjZXNzCisgKiAgIERNVUJfU1RBVFVTX0lOVkFMSUQgLSB1bnNwZWNpZmllZCBlcnJvcgor
ICovCitlbnVtIGRtdWJfc3RhdHVzIGRtdWJfc3J2X2lzX2h3X2luaXQoc3RydWN0IGRtdWJfc3J2
ICpkbXViLCBib29sICppc19od19pbml0KTsKKwogLyoqCiAgKiBkbXViX3Nydl9od19pbml0KCkg
LSBpbml0aWFsaXplcyB0aGUgdW5kZXJseWluZyBETVVCIGhhcmR3YXJlCiAgKiBAZG11YjogdGhl
IGRtdWIgc2VydmljZQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rt
dWIvc3JjL2RtdWJfZGNuMjAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL3Ny
Yy9kbXViX2RjbjIwLmMKaW5kZXggMjM2YTQxNTZiYmUxLi44OWZkMjc3NThkZDUgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL3NyYy9kbXViX2RjbjIwLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJfZGNuMjAuYwpAQCAt
MTIyLDYgKzEyMiwxMSBAQCB2b2lkIGRtdWJfZGNuMjBfc2V0X2luYm94MV93cHRyKHN0cnVjdCBk
bXViX3NydiAqZG11YiwgdWludDMyX3Qgd3B0cl9vZmZzZXQpCiAJUkVHX1dSSVRFKERNQ1VCX0lO
Qk9YMV9XUFRSLCB3cHRyX29mZnNldCk7CiB9CiAKK2Jvb2wgZG11Yl9kY24yMF9pc19od19pbml0
KHN0cnVjdCBkbXViX3NydiAqZG11YikKK3sKKwlyZXR1cm4gUkVHX1JFQUQoRE1DVUJfUkVHSU9O
M19DVzJfQkFTRV9BRERSRVNTKSAhPSAwOworfQorCiBib29sIGRtdWJfZGNuMjBfaXNfc3VwcG9y
dGVkKHN0cnVjdCBkbXViX3NydiAqZG11YikKIHsKIAl1aW50MzJfdCBzdXBwb3J0ZWQgPSAwOwpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJfZGNu
MjAuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL3NyYy9kbXViX2RjbjIwLmgK
aW5kZXggNDEyNjlkYTQwMzYzLi5lMWJhNzQ4Y2E1OTQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kbXViL3NyYy9kbXViX2RjbjIwLmgKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJfZGNuMjAuaApAQCAtNTUsNiArNTUsOCBAQCB1
aW50MzJfdCBkbXViX2RjbjIwX2dldF9pbmJveDFfcnB0cihzdHJ1Y3QgZG11Yl9zcnYgKmRtdWIp
OwogCiB2b2lkIGRtdWJfZGNuMjBfc2V0X2luYm94MV93cHRyKHN0cnVjdCBkbXViX3NydiAqZG11
YiwgdWludDMyX3Qgd3B0cl9vZmZzZXQpOwogCitib29sIGRtdWJfZGNuMjBfaXNfaHdfaW5pdChz
dHJ1Y3QgZG11Yl9zcnYgKmRtdWIpOworCiBib29sIGRtdWJfZGNuMjBfaXNfc3VwcG9ydGVkKHN0
cnVjdCBkbXViX3NydiAqZG11Yik7CiAKIGJvb2wgZG11Yl9kY24yMF9pc19waHlfaW5pdChzdHJ1
Y3QgZG11Yl9zcnYgKmRtdWIpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RtdWIvc3JjL2RtdWJfc3J2LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11
Yi9zcmMvZG11Yl9zcnYuYwppbmRleCAyMjllYWI3Mjc3ZDEuLjJkNjNhZTgwYmRhOSAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJfc3J2LmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJfc3J2LmMKQEAgLTc2
LDYgKzc2LDcgQEAgc3RhdGljIGJvb2wgZG11Yl9zcnZfaHdfc2V0dXAoc3RydWN0IGRtdWJfc3J2
ICpkbXViLCBlbnVtIGRtdWJfYXNpYyBhc2ljKQogCQlmdW5jcy0+c2V0X2luYm94MV93cHRyID0g
ZG11Yl9kY24yMF9zZXRfaW5ib3gxX3dwdHI7CiAJCWZ1bmNzLT5pc19zdXBwb3J0ZWQgPSBkbXVi
X2RjbjIwX2lzX3N1cHBvcnRlZDsKIAkJZnVuY3MtPmlzX3BoeV9pbml0ID0gZG11Yl9kY24yMF9p
c19waHlfaW5pdDsKKwkJZnVuY3MtPmlzX2h3X2luaXQgPSBkbXViX2RjbjIwX2lzX2h3X2luaXQ7
CiAKIAkJaWYgKGFzaWMgPT0gRE1VQl9BU0lDX0RDTjIxKSB7CiAJCQlmdW5jcy0+YmFja2Rvb3Jf
bG9hZCA9IGRtdWJfZGNuMjFfYmFja2Rvb3JfbG9hZDsKQEAgLTIzNCw2ICsyMzUsMTkgQEAgZW51
bSBkbXViX3N0YXR1cyBkbXViX3Nydl9oYXNfaHdfc3VwcG9ydChzdHJ1Y3QgZG11Yl9zcnYgKmRt
dWIsCiAJcmV0dXJuIERNVUJfU1RBVFVTX09LOwogfQogCitlbnVtIGRtdWJfc3RhdHVzIGRtdWJf
c3J2X2lzX2h3X2luaXQoc3RydWN0IGRtdWJfc3J2ICpkbXViLCBib29sICppc19od19pbml0KQor
eworCSppc19od19pbml0ID0gZmFsc2U7CisKKwlpZiAoIWRtdWItPnN3X2luaXQpCisJCXJldHVy
biBETVVCX1NUQVRVU19JTlZBTElEOworCisJaWYgKGRtdWItPmh3X2Z1bmNzLmlzX2h3X2luaXQp
CisJCSppc19od19pbml0ID0gZG11Yi0+aHdfZnVuY3MuaXNfaHdfaW5pdChkbXViKTsKKworCXJl
dHVybiBETVVCX1NUQVRVU19PSzsKK30KKwogZW51bSBkbXViX3N0YXR1cyBkbXViX3Nydl9od19p
bml0KHN0cnVjdCBkbXViX3NydiAqZG11YiwKIAkJCQkgIGNvbnN0IHN0cnVjdCBkbXViX3Nydl9o
d19wYXJhbXMgKnBhcmFtcykKIHsKLS0gCjIuMjQuMAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4
