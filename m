Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCDFC2D0A3
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 06:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A175206FB
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 06:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sFWFB824"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A175206FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 500606E128;
	Thu, 12 Nov 2020 06:18:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FF886E128
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 06:18:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NElvwpzxDqYHW8f5m3juyf0oM8lvv8VVE1YTr1Ogqu9Fhw+Vgu4Qjz27rTTI1v3HnnYM/Rcx20zKfMVCMJr5FvQlEYVhS581chfJ1LWgN5UiDvmS+RbMB858fXFJJrGXIqOaAP9sB6GmOAbmz9i8ayaFRZX+EM2pFj+EE8QO1rLOL3QOg6fUXOgQ18TkpHE77ucmm2TWpkmS+IygVjFV2jrt2OnmNUWMSdEqKjyrKs/EpQ8I8sIrwOXU/mu+QAdw2EBpJELBFmDPx9KOw1UtVRfyY0AjT5zDO8iGaIB2UwyksmJrJQ5Hwy1sLD76SsBfV/cLxiP7Gv/7lJzDkwV5qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAN9cZb+e1kQBACqxwUz7B+1wMaAmdYwH21aCQdPUro=;
 b=f6yGY2rhtlqUC4k+xtdawSHGg7lT/W6Pw84DZWOWkckYJKMIxaE0hOtt2lCHL5UMjtZMx0z8k8KHPF/lhqo6MI61cPjFaT/oiN1sNkeHuYS+fKkVMUW9Ml6U7EfcirMSrPq3t1yBdTbC/PHEhvZdCH2/mcA+CgZZUAgJySpZCzMu9OuuIN6hmVq0ifZpviPzfqcSoI3xTEo9nOZVukMwS25xC/9absSScuumoDJ6+/k2/L3FJuT5h23cTsobyg67ihTxafALqlPsVrUovOmIK7rSYHX7f6WUBWgRtw2NZ0832eFcZFAjq9VbiVe+NVWihQxy7OiCvE9bFXBLjPc1hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAN9cZb+e1kQBACqxwUz7B+1wMaAmdYwH21aCQdPUro=;
 b=sFWFB824nUz0AAx1nINsx8JddHZkxoOA3NcEpbOiUIagWnaotwyMPcLEgoSFxmci1wedXcKyO8r1Q8UVD7qDx0/RSeDQ835ECpHs7UUc+321zvM3pn78I6+CFOPA6K06HZ3E/Fnb819hjHYFojHjfek/L8tNev21F3pqJ/zjk9w=
Received: from BL0PR12MB2433.namprd12.prod.outlook.com (2603:10b6:207:4a::25)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 06:18:27 +0000
Received: from BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::f82c:5e14:7caf:8f13]) by BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::f82c:5e14:7caf:8f13%6]) with mapi id 15.20.3541.023; Thu, 12 Nov 2020
 06:18:27 +0000
From: "Chauhan, Madhav" <Madhav.Chauhan@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/8] drm/amdgpu: drop leading zeros from the gmc9 fault
 address
Thread-Topic: [PATCH 2/8] drm/amdgpu: drop leading zeros from the gmc9 fault
 address
Thread-Index: AQHWsel0FTXKspwvsUuF9sOe5iMOyqnEDhvA
Date: Thu, 12 Nov 2020 06:18:26 +0000
Message-ID: <BL0PR12MB243330CCE0F8AE2680CF4B3A9CE70@BL0PR12MB2433.namprd12.prod.outlook.com>
References: <20201103135837.39693-1-christian.koenig@amd.com>
 <20201103135837.39693-2-christian.koenig@amd.com>
In-Reply-To: <20201103135837.39693-2-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-12T06:18:18Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=fcab921a-ca49-4b7c-b655-00008ae903aa;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-12T06:18:12Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 399acc6e-42f4-4813-a988-0000f802da30
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-12T06:18:24Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: e9b8798a-5bde-4669-b674-0000ae599d73
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [122.179.56.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7be0e4a0-7727-43be-16ac-08d886d2c47e
x-ms-traffictypediagnostic: MN2PR12MB4175:
x-microsoft-antispam-prvs: <MN2PR12MB41758FDB2F22269DA1A834739CE70@MN2PR12MB4175.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LYZL/GA8voeRmscKPqqdN0a7pc8FZqTX0iFhnDxIuXO2DEQyao1CMdsdzWYQFbr0AflxczDRgqW7tJN+7oVQoLV5y8Y/hCJsTrxcsoUJlFBWPrcy9pJgmk0dP7hQhKNCtJUpqrc9V+cFF+ZZHhE23vpWGsy+GsoehTcLO0wcluqH+APHhVgKTwz7Ss4WXIj3N3A40p1S9Oki27mwFeOtoW8MGvjGwhOxyi8w1fPpf2cCmbpHkocHllT0HNc9rqZmWpWDi4qNja3xRCFhz9ifb79asUeX9ujlUHKqQ+Y+XY1QNDIn3TwPz4Ljayu2k87x6Tne4SXaU7v5ayWtrDvjM+A+JacLRvv5q+JZQ9fc6Ik=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(66574015)(316002)(86362001)(478600001)(66476007)(66946007)(33656002)(66556008)(64756008)(66446008)(83380400001)(8676002)(966005)(6506007)(7696005)(53546011)(76116006)(71200400001)(5660300002)(55016002)(8936002)(45080400002)(52536014)(9686003)(110136005)(26005)(186003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: +Rec16znZvTRScW3Es87lb2gZAUHvVhBCPWSnAhTJpQ6JMWDyPbfnIr8tigSia/VYOKOpzKJtCRqMTHCmJq6B/Hw64K7DOU0o3lv7qtlJAT0cwaBZ5Uap9+j3CbEt3QbZH4aEoUX5k8mTjsJxuydpNnHgWRI64MGuIOWuA+NG4LtxNTPX2Zc0ArCxX8aUHatWxYvqNCNi7wxoB6oCcKVJB3AvSGevVx+XLOPjAygZyCYEAajCMwGfUDHLPxWcH3tSDwjMeb/1/pxgBuIjMCgTWcUgqAwafmyg2aPS9LMtuZyoN8LBhHKoj0DkuTg5SkqnjuKyrGObGfU25ev5cuQqbyxgTl47kxdX7sM6ANTQ9cyDj7Ka/1naE35Ujy/t3J/TrkyvKPomFtwsd63kvQSs8Kz/reojtrSmC2/M0kR7MII+22LeeYE7PJLjbi7LmROxkfr7TG8Z09kzga/mIMPfN37ibT+AtuXrhhtU6aQ9Tq4CCvzs9NmJscC1BNlsxwaq4sVoR76JeiDoqgUKseBU3kkPmaBxawl1gjAfZTuJxOp1r4fqcbF1rvxEecM11M6fYd9Sg4Fo++miXSGHi9l9s9XFzecftNAWAfTltDk2wh5Cv6isWYm2U4DQeSSK6rt1Y17RTvw4PIc+nIgyUnO9Q==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be0e4a0-7727-43be-16ac-08d886d2c47e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 06:18:27.0037 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DEIu3e+bE/I6u5TW3p2CrCv8PlTW77IB3hnRFRij9cio5426HvaYwh2jDcrG8Uo93/0x0QD/sBIsWv9JRP1SqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1k
LWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9m
IENocmlzdGlhbiBLw7ZuaWcNClNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDMsIDIwMjAgNzoyOSBQ
TQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBbUEFUQ0ggMi84
XSBkcm0vYW1kZ3B1OiBkcm9wIGxlYWRpbmcgemVyb3MgZnJvbSB0aGUgZ21jOSBmYXVsdCBhZGRy
ZXNzDQoNClRoZSBhZGRyZXNzIHNwYWNlIGlzIG9ubHkgNDhiaXQsIG5vdCA2NGJpdC4gQW5kIHRo
ZSBWTUhVQnMgd29yayB3aXRoIHNpZ24gZXh0ZW5kZWQgYWRkcmVzc2VzLg0KDQpMb29rcyBmaW5l
IHRvIG1lLCBSZXZpZXdlZC1ieTogTWFkaGF2IENoYXVoYW4gPG1hZGhhdi5jaGF1aGFuQGFtZC5j
b20+DQoNClJlZ2FyZHMsDQpNYWRoYXYNCg0KU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ21jX3Y5XzAuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dtY192OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jDQppbmRl
eCAwYzM0MjFkNTg3ZTguLmU4NmVmMGMzNjU5NiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dtY192OV8wLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dtY192OV8wLmMNCkBAIC01NTcsNyArNTU3LDcgQEAgc3RhdGljIGludCBnbWNfdjlfMF9wcm9j
ZXNzX2ludGVycnVwdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCiAJCWVudHJ5LT5zcmNf
aWQsIGVudHJ5LT5yaW5nX2lkLCBlbnRyeS0+dm1pZCwNCiAJCWVudHJ5LT5wYXNpZCwgdGFza19p
bmZvLnByb2Nlc3NfbmFtZSwgdGFza19pbmZvLnRnaWQsDQogCQl0YXNrX2luZm8udGFza19uYW1l
LCB0YXNrX2luZm8ucGlkKTsNCi0JZGV2X2VycihhZGV2LT5kZXYsICIgIGluIHBhZ2Ugc3RhcnRp
bmcgYXQgYWRkcmVzcyAweCUwMTZsbHggZnJvbSBjbGllbnQgJWRcbiIsDQorCWRldl9lcnIoYWRl
di0+ZGV2LCAiICBpbiBwYWdlIHN0YXJ0aW5nIGF0IGFkZHJlc3MgMHglMDEybGx4IGZyb20gDQor
Y2xpZW50ICVkXG4iLA0KIAkJYWRkciwgZW50cnktPmNsaWVudF9pZCk7DQogDQogCWlmIChhbWRn
cHVfc3Jpb3ZfdmYoYWRldikpDQotLQ0KMi4yNS4xDQoNCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcNCmh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24u
b3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1h
aWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDQlN0MwMSU3Q21hZGhhdi5jaGF1
aGFuJTQwYW1kLmNvbSU3Qzg0YzZjNWEyYzM1ZjQ4YmVmNDI3MDhkODgwMDA5MzhhJTdDM2RkODk2
MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzQwMDA4NzI4MDMwMjYxMSU3
Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16
SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT1hdGxXc2Fs
UWIzSWcwTXJLVkplempqc3hnNUlaTHluR2lIZkRGbFdLd3UwJTNEJmFtcDtyZXNlcnZlZD0wDQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
