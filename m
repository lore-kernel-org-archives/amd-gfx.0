Return-Path: <SRS0=MAwf=YZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CFBCA9ECF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 15:13:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35CCD21734
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 15:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35CCD21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE6626F820;
	Fri,  1 Nov 2019 15:13:12 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730078.outbound.protection.outlook.com [40.107.73.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F9886E22F
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2019 15:13:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H21QVJhH+zpoDHOHpPEggxv1Yh53l+iH9GFwW+pnxSnBcAmnG1e0ttdMlJ5z3YWQ7QYfte++6dOcofDI7J7/FFUQD49didDy1NEkdXQQc29FHWegeO8YIbnQSzLq7FdKQpiVLPgov4eKAX/lTC3wMmXrano3uUCDW1rAueZLVtTHw2v3rjl321AHoyfWL0A3ujZJwBIUej2LDetHR8hhHrbO5x40xHYyenR5NDAYCPypAY2dDamrnzhDbHNq5p5U9jET6p5KMoMmz0ur5o828qcSK6WyjvalTaItEKZSSFuOAA936xHKbM9be7x5EqyyooaAEI/PD9PtB9hPc615IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EM1MlPVVpcIBinPJ2yhs99B1ivskP70n5EZJbym9FqM=;
 b=FQ9IbdQYi1xioL7JXVhJWml/y1PTwKyzHgdNphrDx/c8vaD4HBc4VHipIC/OTXWgO/0BqJWTksIxiXOlCvssRD0fxdT53rEmfyt6NsYNGvF4ekXTefnAtb2pp1hOkfZeQMOLYKr7veZY0KYizxM1QfDhdjn5JHtV+eQtXp7TcP7wfBuPjNTzkrtDxVnTCdnLr5i2p/Fssra/b4S4t/QiZEmsKR0yVuwxhnB2sbjdD+G7mmqdtpmHGOjkNQZfmBbhzGbnb1kxB6ja01XBsyZeWWWdPHO49lY+5kdZ4bvtKYRIBVeSX9U50YkhLPnnucrEDUVw2xskP1VtSNWjR88dOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN6PR1201MB0228.namprd12.prod.outlook.com (10.174.115.135) by
 BN6PR1201MB0068.namprd12.prod.outlook.com (10.174.113.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Fri, 1 Nov 2019 15:13:09 +0000
Received: from BN6PR1201MB0228.namprd12.prod.outlook.com
 ([fe80::f894:3184:4c1:10e5]) by BN6PR1201MB0228.namprd12.prod.outlook.com
 ([fe80::f894:3184:4c1:10e5%11]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 15:13:09 +0000
From: Harry Wentland <hwentlan@amd.com>
To: "neil@neil.mayhew.name" <neil@neil.mayhew.name>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Show resolution correctly in mode validation
 debug output
Thread-Topic: [PATCH] drm/amdgpu: Show resolution correctly in mode validation
 debug output
Thread-Index: AQHVj1WAxIZ7lKfuT0q6lVf9vKs7rqd2bw+A
Date: Fri, 1 Nov 2019 15:13:09 +0000
Message-ID: <e970ad7b-3ca6-a6a4-ebf0-83b5f6b3b153@amd.com>
References: <20191030185837.8766-1-neil@neil.mayhew.name>
In-Reply-To: <20191030185837.8766-1-neil@neil.mayhew.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
x-clientproxiedby: YTXPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::14) To BN6PR1201MB0228.namprd12.prod.outlook.com
 (2603:10b6:405:57::7)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d3abe447-d51c-4850-84cc-08d75ede010c
x-ms-traffictypediagnostic: BN6PR1201MB0068:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN6PR1201MB0068FCC9720B347162F3F5A88C620@BN6PR1201MB0068.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(199004)(189003)(81156014)(66476007)(66946007)(446003)(6306002)(81166006)(2501003)(476003)(8676002)(6512007)(66556008)(2906002)(11346002)(2616005)(8936002)(6436002)(66446008)(256004)(6486002)(31696002)(64756008)(229853002)(14444005)(305945005)(7736002)(31686004)(486006)(4001150100001)(25786009)(966005)(36756003)(316002)(110136005)(66066001)(76176011)(65806001)(65956001)(6246003)(386003)(58126008)(14454004)(6506007)(53546011)(52116002)(102836004)(3846002)(26005)(6116002)(71200400001)(5660300002)(186003)(71190400001)(99286004)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1201MB0068;
 H:BN6PR1201MB0228.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bXzmCp944142karCwcsqZdT0z+ChYQYyEfRT+qqpk1oS7fIYbmHXc+jvIQX+p15jk47OPEha/EdziMiG3TkL46Jl/fb9QGGLBeF/gGodxQOGqmk3hHud/dlJRg+vHsr2REswdWSUPQcvJLPopvIHkxQ1OgjzuYDegqSUneQB9hKAmDchE8LuZtvubE2hy9jvoenZtyGEy1ZulJvNeEU07pDB7F4yDt/mEK8IGdtMNuUWNiFY6yzQptwpbiOhnc1l+LuZi8l7kAIMVjji38KzyHCu7B7twdKtMgKgSA0H4eRoZKl5ZffJDy/n2BzUF1c1axt4Viy3FhFhVBWC1qHlCY5jZCCc64ElJ5ckfDXHdCKRnOi+pCnAqHUFR2UIslCvhT4G/OxJhskKxeLM8hSj0sbqeYW8nYxWNpCadeeoi9upFhCB0DXxmk1K6+5JiiZ0HC+wWolIh6V+wk/xNuth/11UqDwZG7ZBhTPJK3vmU24=
x-ms-exchange-transport-forked: True
Content-ID: <6F55EE5392AC304B8DEE3D8AE71CF424@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3abe447-d51c-4850-84cc-08d75ede010c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 15:13:09.1791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +k6YkzkP+zl0ccqL/Qyy4lUalXedG5ByZSzZj9LSfYh4+bBseGrxZJ060w4iB/3TJJLuuSagQB82ciagRwK24Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0068
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EM1MlPVVpcIBinPJ2yhs99B1ivskP70n5EZJbym9FqM=;
 b=hvwycv9GA0+6oRPTAEJf6Xe4FrzbdVJ3hIc+By2xuTo93tUWBxiLt6ynZxALnnaqD6acEIf/4dcMdq+Hohh8brAh7p2fLaPnozb8MIRd/RKjAr1v0XU40mwdRNP3vCxath2A35/mlyyN/oF4/FLRQAomqFW4Ca7a0GBWpDaGlpA=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191101151309.b2ric17gVpucZ-dAAVTMLO9-pTzntSFWOmPhxVtSzxU@z>

T24gMjAxOS0xMC0zMCAyOjU4IHAubS4sIG5laWxAbmVpbC5tYXloZXcubmFtZSB3cm90ZToNCj4g
RnJvbTogTmVpbCBNYXloZXcgPG5laWxAbmVpbC5tYXloZXcubmFtZT4NCg0KVGhpcyByZXF1aXJl
cyB5b3VyIFNpZ25lZC1vZmYtYnkuIFNlZSBbMV0uDQoNCldpdGggdGhhdCBmaXhlZCB5b3VyIGNo
YW5nZSBsb29rcyBnb29kIGFuZCBpcw0KUmV2aWV3ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJy
eS53ZW50bGFuZEBhbWQuY29tPg0KDQpZb3UgY2FuIHNpbXBseSByZXBseSB0byB0aGlzIGVtYWls
IHdpdGggeW91ciBTaWduZWQtb2ZmLWJ5IGFuZCBJIGNhbiBhZGQNCml0IHdoZW4gbWVyZ2luZywg
b3IgeW91IGNhbiBzZW5kIGEgdjIgcGF0Y2ggd2l0aCB5b3VyIFNpZ25lZC1vZmYtYnkuDQoNClsx
XQ0KaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC92NC4xNy9wcm9jZXNzL3N1Ym1pdHRp
bmctcGF0Y2hlcy5odG1sI3NpZ24teW91ci13b3JrLXRoZS1kZXZlbG9wZXItcy1jZXJ0aWZpY2F0
ZS1vZi1vcmlnaW4NCg0KSGFycnkNCg0KPiANCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMNCj4gaW5kZXggYTUyZjBiMTNh
MmM4Li5mODAyYzc4NGU2ZjYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYw0KPiBAQCAtNDExNCw4ICs0MTE0LDggQEAgZW51
bSBkcm1fbW9kZV9zdGF0dXMgYW1kZ3B1X2RtX2Nvbm5lY3Rvcl9tb2RlX3ZhbGlkKHN0cnVjdCBk
cm1fY29ubmVjdG9yICpjb25uZWMNCj4gIAkJcmVzdWx0ID0gTU9ERV9PSzsNCj4gIAllbHNlDQo+
ICAJCURSTV9ERUJVR19LTVMoIk1vZGUgJWR4JWQgKGNsayAlZCkgZmFpbGVkIERDIHZhbGlkYXRp
b24gd2l0aCBlcnJvciAlZFxuIiwNCj4gLQkJCSAgICAgIG1vZGUtPnZkaXNwbGF5LA0KPiAgCQkJ
ICAgICAgbW9kZS0+aGRpc3BsYXksDQo+ICsJCQkgICAgICBtb2RlLT52ZGlzcGxheSwNCj4gIAkJ
CSAgICAgIG1vZGUtPmNsb2NrLA0KPiAgCQkJICAgICAgZGNfcmVzdWx0KTsNCj4gIA0KPiANCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
