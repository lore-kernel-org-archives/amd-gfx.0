Return-Path: <SRS0=Gnzf=YR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C59CA9EAF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 06:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BB4A21655
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 06:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB4A21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AF2A6E0DB;
	Thu, 24 Oct 2019 06:24:38 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790059.outbound.protection.outlook.com [40.107.79.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADF6F6E0DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2019 06:24:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chB3OjL7VnYlfsvvplS/C5RiTUH069IK8i08kwHAPwwsxIVA7MrCpP0NkurkGQYh3RBbaVD34Bevq4FeH3hVz1N6BZO3t1QyDAvy227+xgFcITBNy7/6NlqEwRuI2BawsY8hB/twJe2PT4+1tX5YSw71oTOMW1gdLOicnD94/vq1ezdLd8Nh5X/hLM+WljvWGoud5FihFJtltjA6kB6vVEQhFd1Nqf4If0H2gUzurp6B3Ks3AsDNuEAQmntrSyKzLWBi+uR3b+imWilFCTsCEUavSxf+O8c+4xE2lGX/v2+/sovLyYr32p5TtpDleKvl4PLf6odsfx7cMQgLPLaRdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HnrK8OVeiO6a68+FXdj5E4lAH8c0GLbdLYtWtFm5oA=;
 b=fWjhl0tmJGFFJdsKn8DVXrGtjDBLnPUSzXYxQ9KTZk02SCd8wwhXVtzkWIv2QHBYDYgKr7f4sM/YjHBenTsJTDbEgMJER/Op3pqaD39Na9kj8g701vdlS79A358BZoSKkgt4utL313swb97pdQSjrwRS8AbBTHqo0ga6I1s+lORdiYCfqEoNe1XXMFvIQqUadZ0Bsqdg7UgBwXlWv2jfC5CKIKUCueI3l8ItSiIJ4H8KHOKYZlVuUO9dt6Yw/5DcDU17ldXekKX+Y+C51vx6HeHWVLScjh038/71RMnNvCRRcjDZU3Ew2yZOTTm0A+9ZtyOn99NkCdRIa5r8J9lEvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3856.namprd12.prod.outlook.com (10.255.237.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Thu, 24 Oct 2019 06:24:34 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::435:bdca:bac1:a26d]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::435:bdca:bac1:a26d%5]) with mapi id 15.20.2367.022; Thu, 24 Oct 2019
 06:24:34 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/powerplay: correct current clock level label for
 Arcturus
Thread-Topic: [PATCH] drm/amd/powerplay: correct current clock level label for
 Arcturus
Thread-Index: AQHVijOzz1U47lcEPUabQ2bBkWzWWg==
Date: Thu, 24 Oct 2019 06:24:34 +0000
Message-ID: <20191024062404.21825-1-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0019.apcprd04.prod.outlook.com
 (2603:1096:203:36::31) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef58f8f7-2720-4148-9948-08d7584ad606
x-ms-traffictypediagnostic: MN2PR12MB3856:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB38565B6FA6CEC4F2AE92C0D6E46A0@MN2PR12MB3856.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:497;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(66446008)(5640700003)(2351001)(6512007)(486006)(64756008)(66556008)(66946007)(36756003)(14454004)(66066001)(5660300002)(71200400001)(478600001)(71190400001)(1076003)(6506007)(99286004)(186003)(6436002)(316002)(386003)(26005)(102836004)(52116002)(6486002)(86362001)(2501003)(2616005)(81156014)(81166006)(2906002)(256004)(54906003)(50226002)(8676002)(7736002)(6916009)(305945005)(4326008)(8936002)(6116002)(476003)(66476007)(25786009)(3846002)(14444005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3856;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /FM44zO1X8v7BW/e/t800pGpyCZmcairSOSx6fnqqy3adgmv9TsDbjxEVl21wS9xoMLSOv7UcCcLLiC8OdPg9Va+BbE4Nsh8+yW6Pyv0hvbjppI19emdrJO9qTh2UM0rhNsmYHMcjblGTtHJLX6ofHv+Nwffos+gims3Yf6BJTEW+/oXL+xKY/oi3u7JQ1fE2CsCmlzWvrusizw2E1bxAggCvFEgQ1UHJPsym9Bk/TX4BHtwlmuqlg0ICKPGqyTZ9GZq1DOtdudoLMOqHpn3fZ0yMkJ4IE8xIpTbfnX8Q7JKQ/h9okLz2zbeI8Ay/1gvLvmI3eqmaIEGxEXdXpPCR2XSUmNfmKLaGOPAGxqhqRNoA4PbUAppL4kH2ZjSuljduvLgbjH60EJ/B2LHOLy/whW2NLIIhW8BrPfLQuZc+CRw2uNf7mRklKQCQD30D9t4
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef58f8f7-2720-4148-9948-08d7584ad606
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 06:24:34.1753 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jGCQvD82mCcbVAaa93yaJwjyWJFvwnYzEd8ZN9hywyHzlISnqmvR99J/6gc5Knze
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3856
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HnrK8OVeiO6a68+FXdj5E4lAH8c0GLbdLYtWtFm5oA=;
 b=k9d7gnArHYfNBbFPPO+k9WFnl077fDTU728nUNgCZlLJBI0o1yy0kIEotmLu+7qFwC7ZF5E0MO83YZpO8JI/i0L6qGp7YkggD/+cXIM8iFVywjahDs4+hGcEMzgmIJ6n5WfKzgIzBXhNWdOmY6NahbL0vmE0mR8NiBdu6BidoNo=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
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
Cc: "Li, Candice" <Candice.Li@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191024062434.3enBLbLmuZ0UHtKVBVpLC4BYMA8W-rakjqIwaz-LxIM@z>

Rm9yIGRwbSBkaXNhYmxlZCBjYXNlLCBpdCdzIGFzc3VtZWQgdGhlIG9ubHkgb25lIHN1cHBvcnQg
Y2xvY2sKbGV2ZWwgaXMgYWx3YXlzIGN1cnJlbnQgY2xvY2sgbGV2ZWwuCgpDaGFuZ2UtSWQ6IEk1
Y2MyYjdlODJhZjg4OGRjNWU4MjY4NTk3ZWU3NjFlOWUxYTI2ODU1ClNpZ25lZC1vZmYtYnk6IEV2
YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvYXJjdHVydXNfcHB0LmMgfCAyNCArKysrKysrKysrKysrLS0tLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9hcmN0dXJ1c19wcHQuYwppbmRleCAxYmNjNWFiMjg3M2QuLmZjYzli
NmQyNGU4ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYXJjdHVy
dXNfcHB0LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0
LmMKQEAgLTY3MCwxMiArNjcwLDE3IEBAIHN0YXRpYyBpbnQgYXJjdHVydXNfcHJpbnRfY2xrX2xl
dmVscyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwKIAkJCXJldHVybiByZXQ7CiAJCX0KIAorCQkv
KgorCQkgKiBGb3IgRFBNIGRpc2FibGVkIGNhc2UsIHRoZXJlIHdpbGwgYmUgb25seSBvbmUgY2xv
Y2sgbGV2ZWwuCisJCSAqIEFuZCBpdCdzIHNhZmUgdG8gYXNzdW1lIHRoYXQgaXMgYWx3YXlzIHRo
ZSBjdXJyZW50IGNsb2NrLgorCQkgKi8KIAkJZm9yIChpID0gMDsgaSA8IGNsb2Nrcy5udW1fbGV2
ZWxzOyBpKyspCiAJCQlzaXplICs9IHNwcmludGYoYnVmICsgc2l6ZSwgIiVkOiAldU1oeiAlc1xu
IiwgaSwKIAkJCQkJY2xvY2tzLmRhdGFbaV0uY2xvY2tzX2luX2toeiAvIDEwMDAsCi0JCQkJCWFy
Y3R1cnVzX2ZyZXFzX2luX3NhbWVfbGV2ZWwoCisJCQkJCShjbG9ja3MubnVtX2xldmVscyA9PSAx
KSA/ICIqIiA6CisJCQkJCShhcmN0dXJ1c19mcmVxc19pbl9zYW1lX2xldmVsKAogCQkJCQljbG9j
a3MuZGF0YVtpXS5jbG9ja3NfaW5fa2h6IC8gMTAwMCwKLQkJCQkJbm93IC8gMTAwKSA/ICIqIiA6
ICIiKTsKKwkJCQkJbm93IC8gMTAwKSA/ICIqIiA6ICIiKSk7CiAJCWJyZWFrOwogCiAJY2FzZSBT
TVVfTUNMSzoKQEAgLTY5NSw5ICs3MDAsMTAgQEAgc3RhdGljIGludCBhcmN0dXJ1c19wcmludF9j
bGtfbGV2ZWxzKHN0cnVjdCBzbXVfY29udGV4dCAqc211LAogCQlmb3IgKGkgPSAwOyBpIDwgY2xv
Y2tzLm51bV9sZXZlbHM7IGkrKykKIAkJCXNpemUgKz0gc3ByaW50ZihidWYgKyBzaXplLCAiJWQ6
ICV1TWh6ICVzXG4iLAogCQkJCWksIGNsb2Nrcy5kYXRhW2ldLmNsb2Nrc19pbl9raHogLyAxMDAw
LAotCQkJCWFyY3R1cnVzX2ZyZXFzX2luX3NhbWVfbGV2ZWwoCisJCQkJKGNsb2Nrcy5udW1fbGV2
ZWxzID09IDEpID8gIioiIDoKKwkJCQkoYXJjdHVydXNfZnJlcXNfaW5fc2FtZV9sZXZlbCgKIAkJ
CQljbG9ja3MuZGF0YVtpXS5jbG9ja3NfaW5fa2h6IC8gMTAwMCwKLQkJCQlub3cgLyAxMDApID8g
IioiIDogIiIpOworCQkJCW5vdyAvIDEwMCkgPyAiKiIgOiAiIikpOwogCQlicmVhazsKIAogCWNh
c2UgU01VX1NPQ0NMSzoKQEAgLTcxNyw5ICs3MjMsMTAgQEAgc3RhdGljIGludCBhcmN0dXJ1c19w
cmludF9jbGtfbGV2ZWxzKHN0cnVjdCBzbXVfY29udGV4dCAqc211LAogCQlmb3IgKGkgPSAwOyBp
IDwgY2xvY2tzLm51bV9sZXZlbHM7IGkrKykKIAkJCXNpemUgKz0gc3ByaW50ZihidWYgKyBzaXpl
LCAiJWQ6ICV1TWh6ICVzXG4iLAogCQkJCWksIGNsb2Nrcy5kYXRhW2ldLmNsb2Nrc19pbl9raHog
LyAxMDAwLAotCQkJCWFyY3R1cnVzX2ZyZXFzX2luX3NhbWVfbGV2ZWwoCisJCQkJKGNsb2Nrcy5u
dW1fbGV2ZWxzID09IDEpID8gIioiIDoKKwkJCQkoYXJjdHVydXNfZnJlcXNfaW5fc2FtZV9sZXZl
bCgKIAkJCQljbG9ja3MuZGF0YVtpXS5jbG9ja3NfaW5fa2h6IC8gMTAwMCwKLQkJCQlub3cgLyAx
MDApID8gIioiIDogIiIpOworCQkJCW5vdyAvIDEwMCkgPyAiKiIgOiAiIikpOwogCQlicmVhazsK
IAogCWNhc2UgU01VX0ZDTEs6CkBAIC03MzksOSArNzQ2LDEwIEBAIHN0YXRpYyBpbnQgYXJjdHVy
dXNfcHJpbnRfY2xrX2xldmVscyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwKIAkJZm9yIChpID0g
MDsgaSA8IHNpbmdsZV9kcG1fdGFibGUtPmNvdW50OyBpKyspCiAJCQlzaXplICs9IHNwcmludGYo
YnVmICsgc2l6ZSwgIiVkOiAldU1oeiAlc1xuIiwKIAkJCQlpLCBzaW5nbGVfZHBtX3RhYmxlLT5k
cG1fbGV2ZWxzW2ldLnZhbHVlLAotCQkJCWFyY3R1cnVzX2ZyZXFzX2luX3NhbWVfbGV2ZWwoCisJ
CQkJKGNsb2Nrcy5udW1fbGV2ZWxzID09IDEpID8gIioiIDoKKwkJCQkoYXJjdHVydXNfZnJlcXNf
aW5fc2FtZV9sZXZlbCgKIAkJCQljbG9ja3MuZGF0YVtpXS5jbG9ja3NfaW5fa2h6IC8gMTAwMCwK
LQkJCQlub3cgLyAxMDApID8gIioiIDogIiIpOworCQkJCW5vdyAvIDEwMCkgPyAiKiIgOiAiIikp
OwogCQlicmVhazsKIAogCWRlZmF1bHQ6Ci0tIAoyLjIzLjAKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==
