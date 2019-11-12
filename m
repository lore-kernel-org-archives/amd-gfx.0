Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD903C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7A212184C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A212184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 681076EA3A;
	Tue, 12 Nov 2019 00:34:04 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800080.outbound.protection.outlook.com [40.107.80.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9206E6EA35
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 00:34:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+snKFs+KzUWd2NtneRnE0aKXao031n8fGy3Sy5XZII8nFfPifLx3YBCZg3220HVfm+VvUyCx3qfHz7OnjlaOmOh8o3aClVQuOv056Ic1A/9CZumYXWyrWw+A3HyevesLPsnOKwcVkhQv/6NL35/HK6pweTMb6SXrjuTqujB/6jB5w2JklAu42r1yCZHBITF/sxmXIa03ETxW59doBnzDupJPIGUSPM0sTa5jI7IBZYhdxM+gJzW4rv7mJEzimMx7jTsm0AQjXAv2Zdq89JMZQEZEVjAMh1A9Bx3Fwh0jwn1Cu1JjlUbgon7arBEoyVOxlRt+twN2r4hhve9pl2N9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1omkqF2zsCZt9bR801ZhU6S38SUlO2v3sXnsO18+Uk=;
 b=XeRrMTFSQe4Sdo7ceV7N0AAhdHtL2JNupftx1Jdeeg6uhuyK1qMMHLPm7Ud4OuT2IXqbTSgbrSFgcOsurPX9WvHZaMKeAjR5kPMKBNJjFSC5g4ru/jupw4EezNmBWgPt5W53oYm631nUG5abfHHmqyx7JNw3kLhTJZznGBnwLAnQnnlZ2izv0otcLutyiNZez8VcsAKVCahC4KR+OYVCgb4myXvYDAvJGf6kmKj9OFVwdZYLNkmbzlRgkIqbbeMSSqcS6vCS6NpJGCXHl+Px7WwKvPOOX/OGCH7XJfwn55A1WhHeHugP475gGIB8BPHQOySfPhJcpEWzV559ew3NXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2554.namprd12.prod.outlook.com (52.132.180.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 00:34:02 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 00:34:02 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 24/30] drm/amd/display: Don't spin forever waiting for DMCUB
 phy/auto init
Date: Mon, 11 Nov 2019 19:33:18 -0500
Message-Id: <20191112003324.8419-25-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 75f4a01e-b5e8-4b11-278a-08d7670803de
X-MS-TrafficTypeDiagnostic: MW2PR12MB2554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB255455BCC7AA3C8029D43C8E98770@MW2PR12MB2554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(189003)(199004)(76176011)(6916009)(81166006)(81156014)(386003)(8676002)(478600001)(6506007)(51416003)(52116002)(2870700001)(25786009)(14444005)(2906002)(186003)(2361001)(3846002)(316002)(66066001)(47776003)(50466002)(4326008)(26005)(66946007)(6116002)(36756003)(1076003)(8936002)(48376002)(50226002)(54906003)(2616005)(305945005)(486006)(5660300002)(6512007)(14454004)(2351001)(446003)(6486002)(6666004)(99286004)(66556008)(476003)(66476007)(11346002)(86362001)(6436002)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2554;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GjIErT/t5MlQVJT9wbT+9g4l0GR5lUd1ufY4nowjE0JofyJMGyCHRSfYKSrlP8PzKceiDdfaNvrBl3Cny6gOkGWY3L7FEvX+AV7RUXBJDufYdTHOEwVcL2nXGHN9c/sI35x5DZvaEOo3dDcp8k1iSCDi9pS3k66NO0kiJrnQ3CGJCRCsD6zSJzRyIv3eKC6mIuvybuSTgkgNE93SGv02Ttfih509MjESZGvKREKH1OhyYku3iyHhP3AKSy8UUHYY5Iq5Qlrz5tQlqPS7lXeSD9w8q3c3dN9r7AfPtVS+2Vs91U0qYJ6PEij6gXvtXJdNY3+0AiTb3AV/IpQ5Otzm/ZdoF6eqGBwUwSy7ifUqqvozcalVanYSEBARKbDpKIhaZKKMUQD3oa5slv27hBk9scpFkYeMyDNh/ZfYaCbAQ7oHneeJJKxBlnoTVl8/SPNZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f4a01e-b5e8-4b11-278a-08d7670803de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 00:34:02.0563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +w/0e7UDVgElaO/jeOWv+I7w4YDdPRCH5c6+77JIjeb2Ru/uKn6vRSqf5pQ+BEWSupOjqoPyqwYvzLQeXB/mAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2554
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1omkqF2zsCZt9bR801ZhU6S38SUlO2v3sXnsO18+Uk=;
 b=HFURm5T2xz8KBcn+qS5RTdQyOVmwgMxu+CiJ+8JM07wsA80RBEHuEksOMJHTTrzSedGUZP6jvprqL06HF8AyhIuQGnK/0JqIfZSWGFzfSkLIBUF9Kng8Eyk5Pr92XsssxlEkcupKfeQmDTPOTez3HliKi556bHbQ7SV3R4m658A=
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
Cc: Sun peng Li <Sunpeng.Li@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112003318.W8HjqH3EjCMXgoynq6PRxGG2zA8yIRoQyhf4ZXhfWGA@z>

RnJvbTogTmljaG9sYXMgS2F6bGF1c2thcyA8bmljaG9sYXMua2F6bGF1c2thc0BhbWQuY29tPgoK
W1doeV0KSXQncyBhbiBpbnRlcmZhY2UgdmlvbGF0aW9uIHRvIHVzZSBpbmZpbml0ZSBsb29wcyB3
aXRoaW4gRE1VQgpzZXJ2aWNlIGZ1bmN0aW9ucyBhbmQgd2UnbGwgbG9jayB1cCB0aGUga2VybmVs
IGJ5IGRvaW5nIHNvLgoKW0hvd10KUmV2ZXJ0IHRoZSBmdW5jdGlvbiBiYWNrIHRvIGl0cyBpbnRl
bmRlZCBmdW5jdGlvbmFsaXR5LgpNb3ZlIHRoZSBpbmZpbml0ZSBsb29wcyBpbnRvIERDL0RNIGFz
IG5lY2Vzc2FyeS4KClNpZ25lZC1vZmYtYnk6IE5pY2hvbGFzIEthemxhdXNrYXMgPG5pY2hvbGFz
LmthemxhdXNrYXNAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IFN1biBwZW5nIExpIDxTdW5wZW5nLkxp
QGFtZC5jb20+CkFja2VkLWJ5OiBSb2RyaWdvIFNpcXVlaXJhIDxSb2RyaWdvLlNpcXVlaXJhQGFt
ZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX2RtdWJfc3J2LmMg
ICAgfCA2ICsrKystLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJf
c3J2LmMgfCA5ICsrLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDkg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RjX2RtdWJfc3J2LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfZG11Yl9z
cnYuYwppbmRleCA2MWNlZmUwYTM3OTAuLjc0ZmZlNTNlYjQ5ZCAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX2RtdWJfc3J2LmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RjX2RtdWJfc3J2LmMKQEAgLTExMiw4ICsxMTIsMTAgQEAgdm9p
ZCBkY19kbXViX3Nydl93YWl0X3BoeV9pbml0KHN0cnVjdCBkY19kbXViX3NydiAqZGNfZG11Yl9z
cnYpCiAJc3RydWN0IGRjX2NvbnRleHQgKmRjX2N0eCA9IGRjX2RtdWJfc3J2LT5jdHg7CiAJZW51
bSBkbXViX3N0YXR1cyBzdGF0dXM7CiAKLQlzdGF0dXMgPSBkbXViX3Nydl93YWl0X2Zvcl9waHlf
aW5pdChkbXViLCAxMDAwMDAwKTsKLQlpZiAoc3RhdHVzICE9IERNVUJfU1RBVFVTX09LKQorCXN0
YXR1cyA9IGRtdWJfc3J2X3dhaXRfZm9yX3BoeV9pbml0KGRtdWIsIDEwMDAwMDAwKTsKKwlpZiAo
c3RhdHVzICE9IERNVUJfU1RBVFVTX09LKSB7CiAJCURDX0VSUk9SKCJFcnJvciB3YWl0aW5nIGZv
ciBETVVCIHBoeSBpbml0OiBzdGF0dXM9JWRcbiIsCiAJCQkgc3RhdHVzKTsKKwkJQVNTRVJUKDAp
OworCX0KIH0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL3Ny
Yy9kbXViX3Nydi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJf
c3J2LmMKaW5kZXggNWFlMTkwNmZmMWIxLi42MGM1NzRhMzljNmEgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL3NyYy9kbXViX3Nydi5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kbXViL3NyYy9kbXViX3Nydi5jCkBAIC00MDAsMTkgKzQwMCwx
NCBAQCBlbnVtIGRtdWJfc3RhdHVzIGRtdWJfc3J2X3dhaXRfZm9yX3BoeV9pbml0KHN0cnVjdCBk
bXViX3NydiAqZG11YiwKIAlpZiAoIWRtdWItPmh3X2luaXQgfHwgIWRtdWItPmh3X2Z1bmNzLmlz
X3BoeV9pbml0KQogCQlyZXR1cm4gRE1VQl9TVEFUVVNfSU5WQUxJRDsKIAotLyoJZm9yIChpID0g
MDsgaSA8PSB0aW1lb3V0X3VzOyBpICs9IDEwKSB7CisJZm9yIChpID0gMDsgaSA8PSB0aW1lb3V0
X3VzOyBpICs9IDEwKSB7CiAJCWlmIChkbXViLT5od19mdW5jcy5pc19waHlfaW5pdChkbXViKSkK
IAkJCXJldHVybiBETVVCX1NUQVRVU19PSzsKIAogCQl1ZGVsYXkoMTApOwotCX0qLwotCXdoaWxl
ICghZG11Yi0+aHdfZnVuY3MuaXNfcGh5X2luaXQoZG11YikpIHsKLQkJQVNTRVJUKGkgPD0gdGlt
ZW91dF91cyk7Ci0JCWkgKz0gMTA7Ci0JCXVkZWxheSgxMCk7CiAJfQogCi0JcmV0dXJuIERNVUJf
U1RBVFVTX09LOworCXJldHVybiBETVVCX1NUQVRVU19USU1FT1VUOwogfQogCiBlbnVtIGRtdWJf
c3RhdHVzIGRtdWJfc3J2X3dhaXRfZm9yX2lkbGUoc3RydWN0IGRtdWJfc3J2ICpkbXViLAotLSAK
Mi4yNC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
