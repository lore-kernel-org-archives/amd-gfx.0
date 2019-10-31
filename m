Return-Path: <SRS0=0yA7=YY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24EBCA9EC9
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 00:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14CC2067D
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 00:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14CC2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 842CF6EBC1;
	Thu, 31 Oct 2019 00:17:57 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820084.outbound.protection.outlook.com [40.107.82.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DAA06EBC1
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2019 00:17:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CN/WkyJhono8iWHNeea2TEI7z37x2xGQo4r5NWzZG0g+kZQSHULrkKotp+UQBqrNZBsy2X7LQWFlR0+7Lr18gAxVA7Lg9obrmuIJ5A0m0y2icwLKDqXsr30w5wcgklUjYhzEQHDpHWVEEICLC9zN6YLW5MlfjqZxhcJo/WK+Cbtmc7hw25bm7vnvweV4/QGVkrAHaL9rDwoHYVqSTuilrBeoJAmIQ0Uliu5qvvNN5TiVV8kC8GS5roTz1HF0+xysi4R8UiBhL5LL2fgIZPe2cztOsi2BKFUzQ5RkZDaQRV/2jU9acP2Mjo6lRffAxKJ5OQxc9TDmmdAutQ7UoSfOoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuuAyFpRf7y9CnC2AbhhCdaxxEUn2ZD0Jt5JX8Md9iI=;
 b=UDBzRmMBEyjcIDoSUwGw2mtW52mIgDAPehSJ5U5eiADkXGoc027w3oXdMgRm8e64VE85a0zde1AaFpeTxb9dB6Uik8mp5XK+2Mh5GTgs41vhPgHgtftqCeonziI0Lf0FlmvNFUvCa+emRYa6i4Ov6bom8S++rQ/0T3+lEaRWQAOrxqTl+BHIiXpfRN/QfR1nxl0G9UphnAyC4/4vEM5dLsT55fzuqqGFzUhrJ5jbn+PXDQsm+CD89RvrXS43ukNFhjklQqEVGUxfLhQgBHu9ZeuVB+FfzXh97yuDpWaesR9OBoZk+vvs9g7qpronp02xti0cS6oAESchVoAjuvaJZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB2747.namprd12.prod.outlook.com (20.176.116.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Thu, 31 Oct 2019 00:17:55 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::b411:7d2c:8848:1f6e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::b411:7d2c:8848:1f6e%7]) with mapi id 15.20.2387.028; Thu, 31 Oct 2019
 00:17:55 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdkfd: only keep release_mem function for Hawaii
Thread-Topic: [PATCH 2/3] drm/amdkfd: only keep release_mem function for Hawaii
Thread-Index: AQHVj4CkSMtAMFLs5U2ND/zZPFxaww==
Date: Thu, 31 Oct 2019 00:17:55 +0000
Message-ID: <20191031001739.10764-2-Yong.Zhao@amd.com>
References: <20191031001739.10764-1-Yong.Zhao@amd.com>
In-Reply-To: <20191031001739.10764-1-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTBPR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::28) To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2cbfc0e3-134a-4077-ea4c-08d75d97c68c
x-ms-traffictypediagnostic: DM6PR12MB2747:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB27476139B8C0CF166B197BE3F0630@DM6PR12MB2747.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:389;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(189003)(199004)(99286004)(66556008)(66476007)(6512007)(6506007)(486006)(6916009)(66946007)(64756008)(66446008)(76176011)(71190400001)(71200400001)(2351001)(102836004)(305945005)(386003)(3846002)(6116002)(2906002)(5640700003)(4326008)(7736002)(52116002)(14444005)(8936002)(66066001)(2501003)(316002)(6436002)(50226002)(25786009)(86362001)(6486002)(14454004)(256004)(36756003)(5660300002)(446003)(476003)(2616005)(81156014)(26005)(11346002)(186003)(1076003)(478600001)(8676002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2747;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IfUKHa0cfdc5/7RcCPWY9FyWU9nvD3Pf7gLrLCFm6duPAgZGO7nlb62PxSOw+R2Jvj5qnvzwI6y7a9aP0+sMIcOLw5hHov8jjFAkujD5Ywo3LRD508wZrgd6ILaW0rwxXJyidM+UA+Zv9GwLFOsAeUv1dTecLrsqKmXWMaA5ECib0aXIl2BKQwnIdZE6feabU1Uj9eG6XxyBRayUSFIawnmMjbll/OeQ5CliyCS6AIIz2zUvjksWe0B2i9yS7/TkrvDuRzyQbroskNRABBsayiq/BEkoaSYgLzRw/2tmi0ibEa3Ofha2pPF1WUspO3EUbLDeOXud+3xjeV3S+EB0Oi/IxMeuvfSvjbEu7hyqoDvsJQsBnCzY9Y+w+91zRvOSp1irIodz6XFdqyqPMnar0korTGh/Uepm+UXhukPS9WaJExjA8RpDfEEGY0rXojXM
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbfc0e3-134a-4077-ea4c-08d75d97c68c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 00:17:55.0762 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KLfsGfnP3l0feNyu+dZEqbVk/mhBjoFGQLc/ulHkFLfB+6+yausmtBrReikOm6BS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2747
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuuAyFpRf7y9CnC2AbhhCdaxxEUn2ZD0Jt5JX8Md9iI=;
 b=L32eGc8nOnK47tWE7FTTDt0dCH9ktS+rZxQIECGXKbD4zLRcUdwSPcsFhxE4ghnCRA2V77ald9gGfUidED16mHrpBq/77xoyy7gADhHzSIkhxF2ikah7sbhW+VDJlvOUCjE085akJZiL7RSAVY/rQyZEWvuTbetCcsYO6wdgHRg=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
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
Cc: "Zhao, Yong" <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191031001755.g2-rpLCS5X3-xAjhFLroaMsqSOyW2gJN57TO3IWq1bA@z>

cmVsZWFzZV9tZW0gd29uJ3QgYmUgdXNlZCBhdCBhbGwgb24gR0ZYOSBhbmQgR0ZYMTAsIHNvIGRl
bGV0ZSBpdC4KCkNoYW5nZS1JZDogSTEzNzg3YThhMjliODNlNzUxNmM1ODJhNzQwMWYyZTE0NzIx
ZWRmNWYKU2lnbmVkLW9mZi1ieTogWW9uZyBaaGFvIDxZb25nLlpoYW9AYW1kLmNvbT4KLS0tCiAu
Li4vZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJuZWxfcXVldWVfdjEwLmMgfCAzNSArKy0tLS0t
LS0tLS0tLS0tLS0tCiAuLi4vZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJuZWxfcXVldWVfdjku
YyAgfCAzMyArKy0tLS0tLS0tLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDY0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9rZXJuZWxfcXVldWVfdjEwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfa2VybmVsX3F1ZXVlX3YxMC5jCmluZGV4IGFlZDMyYWI3MTAyZS4uYmZkNjIyMWFjYWU5IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfa2VybmVsX3F1ZXVlX3Yx
MC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJuZWxfcXVldWVfdjEw
LmMKQEAgLTI5OCwzNyArMjk4LDYgQEAgc3RhdGljIGludCBwbV9xdWVyeV9zdGF0dXNfdjEwKHN0
cnVjdCBwYWNrZXRfbWFuYWdlciAqcG0sIHVpbnQzMl90ICpidWZmZXIsCiAJcmV0dXJuIDA7CiB9
CiAKLQotc3RhdGljIGludCBwbV9yZWxlYXNlX21lbV92MTAodWludDY0X3QgZ3B1X2FkZHIsIHVp
bnQzMl90ICpidWZmZXIpCi17Ci0Jc3RydWN0IHBtNF9tZWNfcmVsZWFzZV9tZW0gKnBhY2tldDsK
LQotCVdBUk5fT04oIWJ1ZmZlcik7Ci0KLQlwYWNrZXQgPSAoc3RydWN0IHBtNF9tZWNfcmVsZWFz
ZV9tZW0gKilidWZmZXI7Ci0JbWVtc2V0KGJ1ZmZlciwgMCwgc2l6ZW9mKHN0cnVjdCBwbTRfbWVj
X3JlbGVhc2VfbWVtKSk7Ci0KLQlwYWNrZXQtPmhlYWRlci51MzJBbGwgPSBwbV9idWlsZF9wbTRf
aGVhZGVyKElUX1JFTEVBU0VfTUVNLAotCQkJCQlzaXplb2Yoc3RydWN0IHBtNF9tZWNfcmVsZWFz
ZV9tZW0pKTsKLQotCXBhY2tldC0+Yml0ZmllbGRzMi5ldmVudF90eXBlID0gQ0FDSEVfRkxVU0hf
QU5EX0lOVl9UU19FVkVOVDsKLQlwYWNrZXQtPmJpdGZpZWxkczIuZXZlbnRfaW5kZXggPSBldmVu
dF9pbmRleF9fbWVjX3JlbGVhc2VfbWVtX19lbmRfb2ZfcGlwZTsKLQlwYWNrZXQtPmJpdGZpZWxk
czIudGNsMV9hY3Rpb25fZW5hID0gMTsKLQlwYWNrZXQtPmJpdGZpZWxkczIudGNfYWN0aW9uX2Vu
YSA9IDE7Ci0JcGFja2V0LT5iaXRmaWVsZHMyLmNhY2hlX3BvbGljeSA9IGNhY2hlX3BvbGljeV9f
bWVjX3JlbGVhc2VfbWVtX19scnU7Ci0KLQlwYWNrZXQtPmJpdGZpZWxkczMuZGF0YV9zZWwgPSBk
YXRhX3NlbF9fbWVjX3JlbGVhc2VfbWVtX19zZW5kXzMyX2JpdF9sb3c7Ci0JcGFja2V0LT5iaXRm
aWVsZHMzLmludF9zZWwgPQotCQlpbnRfc2VsX19tZWNfcmVsZWFzZV9tZW1fX3NlbmRfaW50ZXJy
dXB0X2FmdGVyX3dyaXRlX2NvbmZpcm07Ci0KLQlwYWNrZXQtPmJpdGZpZWxkczQuYWRkcmVzc19s
b18zMmIgPSAoZ3B1X2FkZHIgJiAweGZmZmZmZmZmKSA+PiAyOwotCXBhY2tldC0+YWRkcmVzc19o
aSA9IHVwcGVyXzMyX2JpdHMoZ3B1X2FkZHIpOwotCi0JcGFja2V0LT5kYXRhX2xvID0gMDsKLQot
CXJldHVybiBzaXplb2Yoc3RydWN0IHBtNF9tZWNfcmVsZWFzZV9tZW0pIC8gc2l6ZW9mKHVuc2ln
bmVkIGludCk7Ci19Ci0KIGNvbnN0IHN0cnVjdCBwYWNrZXRfbWFuYWdlcl9mdW5jcyBrZmRfdjEw
X3BtX2Z1bmNzID0gewogCS5tYXBfcHJvY2VzcwkJCT0gcG1fbWFwX3Byb2Nlc3NfdjEwLAogCS5y
dW5saXN0CQkJPSBwbV9ydW5saXN0X3YxMCwKQEAgLTMzNiwxMyArMzA1LDEzIEBAIGNvbnN0IHN0
cnVjdCBwYWNrZXRfbWFuYWdlcl9mdW5jcyBrZmRfdjEwX3BtX2Z1bmNzID0gewogCS5tYXBfcXVl
dWVzCQkJPSBwbV9tYXBfcXVldWVzX3YxMCwKIAkudW5tYXBfcXVldWVzCQkJPSBwbV91bm1hcF9x
dWV1ZXNfdjEwLAogCS5xdWVyeV9zdGF0dXMJCQk9IHBtX3F1ZXJ5X3N0YXR1c192MTAsCi0JLnJl
bGVhc2VfbWVtCQkJPSBwbV9yZWxlYXNlX21lbV92MTAsCisJLnJlbGVhc2VfbWVtCQkJPSBOVUxM
LAogCS5tYXBfcHJvY2Vzc19zaXplCQk9IHNpemVvZihzdHJ1Y3QgcG00X21lc19tYXBfcHJvY2Vz
cyksCiAJLnJ1bmxpc3Rfc2l6ZQkJCT0gc2l6ZW9mKHN0cnVjdCBwbTRfbWVzX3J1bmxpc3QpLAog
CS5zZXRfcmVzb3VyY2VzX3NpemUJCT0gc2l6ZW9mKHN0cnVjdCBwbTRfbWVzX3NldF9yZXNvdXJj
ZXMpLAogCS5tYXBfcXVldWVzX3NpemUJCT0gc2l6ZW9mKHN0cnVjdCBwbTRfbWVzX21hcF9xdWV1
ZXMpLAogCS51bm1hcF9xdWV1ZXNfc2l6ZQkJPSBzaXplb2Yoc3RydWN0IHBtNF9tZXNfdW5tYXBf
cXVldWVzKSwKIAkucXVlcnlfc3RhdHVzX3NpemUJCT0gc2l6ZW9mKHN0cnVjdCBwbTRfbWVzX3F1
ZXJ5X3N0YXR1cyksCi0JLnJlbGVhc2VfbWVtX3NpemUJCT0gc2l6ZW9mKHN0cnVjdCBwbTRfbWVj
X3JlbGVhc2VfbWVtKQorCS5yZWxlYXNlX21lbV9zaXplCQk9IDAsCiB9OwogCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfa2VybmVsX3F1ZXVlX3Y5LmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfa2VybmVsX3F1ZXVlX3Y5LmMKaW5kZXggM2I1Y2Ey
YjFkN2E2Li5mMGU0OTEwYTg4NjUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9rZXJuZWxfcXVldWVfdjkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfa2VybmVsX3F1ZXVlX3Y5LmMKQEAgLTMzNiwzNSArMzM2LDYgQEAgc3RhdGljIGludCBw
bV9xdWVyeV9zdGF0dXNfdjkoc3RydWN0IHBhY2tldF9tYW5hZ2VyICpwbSwgdWludDMyX3QgKmJ1
ZmZlciwKIAlyZXR1cm4gMDsKIH0KIAotCi1zdGF0aWMgaW50IHBtX3JlbGVhc2VfbWVtX3Y5KHVp
bnQ2NF90IGdwdV9hZGRyLCB1aW50MzJfdCAqYnVmZmVyKQotewotCXN0cnVjdCBwbTRfbWVjX3Jl
bGVhc2VfbWVtICpwYWNrZXQ7Ci0KLQlwYWNrZXQgPSAoc3RydWN0IHBtNF9tZWNfcmVsZWFzZV9t
ZW0gKilidWZmZXI7Ci0JbWVtc2V0KGJ1ZmZlciwgMCwgc2l6ZW9mKHN0cnVjdCBwbTRfbWVjX3Jl
bGVhc2VfbWVtKSk7Ci0KLQlwYWNrZXQtPmhlYWRlci51MzJBbGwgPSBwbV9idWlsZF9wbTRfaGVh
ZGVyKElUX1JFTEVBU0VfTUVNLAotCQkJCQlzaXplb2Yoc3RydWN0IHBtNF9tZWNfcmVsZWFzZV9t
ZW0pKTsKLQotCXBhY2tldC0+Yml0ZmllbGRzMi5ldmVudF90eXBlID0gQ0FDSEVfRkxVU0hfQU5E
X0lOVl9UU19FVkVOVDsKLQlwYWNrZXQtPmJpdGZpZWxkczIuZXZlbnRfaW5kZXggPSBldmVudF9p
bmRleF9fbWVjX3JlbGVhc2VfbWVtX19lbmRfb2ZfcGlwZTsKLQlwYWNrZXQtPmJpdGZpZWxkczIu
dGNsMV9hY3Rpb25fZW5hID0gMTsKLQlwYWNrZXQtPmJpdGZpZWxkczIudGNfYWN0aW9uX2VuYSA9
IDE7Ci0JcGFja2V0LT5iaXRmaWVsZHMyLmNhY2hlX3BvbGljeSA9IGNhY2hlX3BvbGljeV9fbWVj
X3JlbGVhc2VfbWVtX19scnU7Ci0KLQlwYWNrZXQtPmJpdGZpZWxkczMuZGF0YV9zZWwgPSBkYXRh
X3NlbF9fbWVjX3JlbGVhc2VfbWVtX19zZW5kXzMyX2JpdF9sb3c7Ci0JcGFja2V0LT5iaXRmaWVs
ZHMzLmludF9zZWwgPQotCQlpbnRfc2VsX19tZWNfcmVsZWFzZV9tZW1fX3NlbmRfaW50ZXJydXB0
X2FmdGVyX3dyaXRlX2NvbmZpcm07Ci0KLQlwYWNrZXQtPmJpdGZpZWxkczQuYWRkcmVzc19sb18z
MmIgPSAoZ3B1X2FkZHIgJiAweGZmZmZmZmZmKSA+PiAyOwotCXBhY2tldC0+YWRkcmVzc19oaSA9
IHVwcGVyXzMyX2JpdHMoZ3B1X2FkZHIpOwotCi0JcGFja2V0LT5kYXRhX2xvID0gMDsKLQotCXJl
dHVybiAwOwotfQotCiBjb25zdCBzdHJ1Y3QgcGFja2V0X21hbmFnZXJfZnVuY3Mga2ZkX3Y5X3Bt
X2Z1bmNzID0gewogCS5tYXBfcHJvY2VzcwkJPSBwbV9tYXBfcHJvY2Vzc192OSwKIAkucnVubGlz
dAkJPSBwbV9ydW5saXN0X3Y5LApAQCAtMzcyLDEyICszNDMsMTIgQEAgY29uc3Qgc3RydWN0IHBh
Y2tldF9tYW5hZ2VyX2Z1bmNzIGtmZF92OV9wbV9mdW5jcyA9IHsKIAkubWFwX3F1ZXVlcwkJPSBw
bV9tYXBfcXVldWVzX3Y5LAogCS51bm1hcF9xdWV1ZXMJCT0gcG1fdW5tYXBfcXVldWVzX3Y5LAog
CS5xdWVyeV9zdGF0dXMJCT0gcG1fcXVlcnlfc3RhdHVzX3Y5LAotCS5yZWxlYXNlX21lbQkJPSBw
bV9yZWxlYXNlX21lbV92OSwKKwkucmVsZWFzZV9tZW0JCT0gTlVMTCwKIAkubWFwX3Byb2Nlc3Nf
c2l6ZQk9IHNpemVvZihzdHJ1Y3QgcG00X21lc19tYXBfcHJvY2VzcyksCiAJLnJ1bmxpc3Rfc2l6
ZQkJPSBzaXplb2Yoc3RydWN0IHBtNF9tZXNfcnVubGlzdCksCiAJLnNldF9yZXNvdXJjZXNfc2l6
ZQk9IHNpemVvZihzdHJ1Y3QgcG00X21lc19zZXRfcmVzb3VyY2VzKSwKIAkubWFwX3F1ZXVlc19z
aXplCT0gc2l6ZW9mKHN0cnVjdCBwbTRfbWVzX21hcF9xdWV1ZXMpLAogCS51bm1hcF9xdWV1ZXNf
c2l6ZQk9IHNpemVvZihzdHJ1Y3QgcG00X21lc191bm1hcF9xdWV1ZXMpLAogCS5xdWVyeV9zdGF0
dXNfc2l6ZQk9IHNpemVvZihzdHJ1Y3QgcG00X21lc19xdWVyeV9zdGF0dXMpLAotCS5yZWxlYXNl
X21lbV9zaXplCT0gc2l6ZW9mKHN0cnVjdCBwbTRfbWVjX3JlbGVhc2VfbWVtKQorCS5yZWxlYXNl
X21lbV9zaXplCT0gMCwKIH07Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeA==
