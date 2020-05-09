Return-Path: <SRS0=XXlo=6X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A76C28CBC
	for <amd-gfx@archiver.kernel.org>; Sat,  9 May 2020 04:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D75ED21473
	for <amd-gfx@archiver.kernel.org>; Sat,  9 May 2020 04:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pQuUPB76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75ED21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 559206E2DA;
	Sat,  9 May 2020 04:34:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1C206E2DA
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 May 2020 04:34:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8SJ5LzpYDnbKSu6GcmvhbKMCZSjniKwhewq/f7TQKfGkwsaKdJ8qaFOVIvbgcNRZFvi+0fMyMRy6zNA4c2KEGOp3INgqbfG/v2K30g4RcbaMhTpyv1BQcMsER68LYnrx6GNwIzUBow27k+nwREXIwGm5/JAuOfhPCTHpVGgdbgTLuPWefkSVNMHlxmr+JHyZapMGyAIJWJH8wU5D02t2yOpX5vh6iHbi0s/BxoVrVAvzHBbIFrnIHFFPhlR+RLxq9lZCAIeDIP9ylxsO191e0a5GLfJxiFxn20hpjnLA3xpft4H68rAsopXRWu5cyJcMNa9PnWIVoVrL1l9rtWlxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBYAAn6Z3+M5M5qWoHk7qPTZfSMxTDVR8FaqYsBwm0I=;
 b=VaVTAV5ca8nll1hJeJb6iVwAKfKIcQ1TZH8oKq1tINHXI5JnmBV8T5mxXlJXZvyZtg75hlx0hdW3jmyqj6YqkmJ8d8KZS/kqul+SmPu8mNiSuIL6ZJ555h4T1kScwppNoEyubEcp6J0n5GHHdyygTjvCLJsQ5ZGerl1JDn2Z7s0s3QQc7Ocd10w/b6GsM7JZub5gMgwGHVBlcLzna2rH14EZzUzj5nwLAqN8BVpotMS5piXKiN/9Zrs77XApBETkhYDCXjGhb/L0hfxf6maSun6sLGANi/rchKk6rSDdSkngP/q/Kj5YKm/tOwwl1y3o2wbIq8kUCohTjfsag3fAfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBYAAn6Z3+M5M5qWoHk7qPTZfSMxTDVR8FaqYsBwm0I=;
 b=pQuUPB760aIgunUkrqpLIykkySAo4cw321G+o9AGVIV14D6y1O7Yrg3HEr0BjAEVSDxllm69Ibaf33BjRo9BRXt+6Xhg486fCwkT0muNbPuDwjhFZsZ7gUKT+/+/J9Jxua4IZdfVgGIfqWRcVE+GIPOYKTos0XcC+KEKhTeVSbI=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3193.namprd12.prod.outlook.com (2603:10b6:5:186::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.29; Sat, 9 May 2020 04:34:00 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2958.035; Sat, 9 May 2020
 04:34:00 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: decode the ctxid for SMC to host IH
Thread-Topic: [PATCH 1/2] drm/amdgpu: decode the ctxid for SMC to host IH
Thread-Index: AQHWJR/kKIVObS3R9U2b6oA9P5FpUKieA3AAgAEoEtA=
Date: Sat, 9 May 2020 04:33:59 +0000
Message-ID: <DM6PR12MB2619000589CAA0F9B3D07222E4A30@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200508100253.12839-1-evan.quan@amd.com>
 <4d132c20-5c5e-946b-91bd-1d7739ed884f@gmail.com>
In-Reply-To: <4d132c20-5c5e-946b-91bd-1d7739ed884f@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=bee67152-5487-4f3a-91d0-0000a33527f3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-09T04:32:43Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ee4b4301-b076-456e-33f9-08d7f3d231cb
x-ms-traffictypediagnostic: DM6PR12MB3193:|DM6PR12MB3193:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3193E80248321C966541884CE4A30@DM6PR12MB3193.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 03982FDC1D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vc3U121HsKDO/bAWna6XmCTDOolKZJN4U9aRExStVm17gurZGKZ5UagSzFKY80KM2sjqNRecSTNo0APui0RQlrOyS1Tl2RILdvIESDcZ/+EbFbXeaQuxqEw8xRdqmk9w5QWi6SMU4lgKrWJzaRUs0MeNxcQhPPT7cQp355guBhcSr0qJoc/ZDFTJgSorWWnA+QAa/s8Tr1W2VF4dqPPqs1mWUWwczukRNy/HpX0NjaaCTzaXgl1dRwfxEDR+WIgR8PsW67Kvjt1z3ZUgsC/yvSUpiU5A9/mTnj2zaEhV2wmQftTAkU+3+KjlTOWJCxyIgt/TNptBShZDBaTzWLkFiDkBa8j9EIul+0rlTaM16nHvjK3tTB73p/onfFWbdj0KAsL4dKwoNf5AfiAQ41B+Xra2HNfBfZi05WN+iQikTPLip3EUdTjACNRlcZZ3dmnMddEEOs47jNAhxsEufPTZJe//qVUaqowE6xgUQhV0dKJJ/hwN0WNDbI7qtjv41GQRh1//x26JGTH60ApTrDl1/A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(33430700001)(64756008)(478600001)(66556008)(52536014)(66476007)(9686003)(66446008)(186003)(8936002)(55016002)(8676002)(4326008)(7696005)(86362001)(5660300002)(33440700001)(110136005)(316002)(26005)(6506007)(53546011)(76116006)(66574014)(33656002)(71200400001)(66946007)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: cI9z7EtWreIMBLHfjp6nboDTFhHkm6cCbz8dxAxdvrMfST5PPqYSSMjvXG4qJeNGIqAQL2GQPBTrvGBiT7bgzhPLMRlClG3vod3Lc+/xOlAe32oylw/5VFLBp8QlAKOpFuthrsl9/y7gQTxEdkxvYQONI0hW1pASDB1wtwfbDfiUQ4p+UEwxDM4Mipb891bH7kvidvp69zdS5jgjvqyOLp8U3kw1jHiUW/PL0iqCoDfER8ptHvXB6QDvz6gO7A20fok46Msmse9e7/rDaa+XUH7xRViSbPC/JVL864voIY/t4SbFsicpoGvxS/osyZ+WiFHgo8mgBvpHkcN7l4zoBQEfD0M8XwCPDHsQSxPUeER8bRuw5Le8HtwYuGrO0KO+TgLSLf2KEdkz6rtW8gxomhjlB+YAHsolp+cyqin5OcCSXzGXil8vpU8AQGcttas45uIVpcxhOnPGXYEXVRXVST4+V2ugASe8sPczJmhAAae5fwJltBqPXdjKR88J1kqo
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4b4301-b076-456e-33f9-08d7f3d231cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2020 04:33:59.9817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xSXA07PXaSg6ypaEjidNX06CsQbsv5Cnv23b2niloL9V9lWlV4gBEOhhDKBrrljH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3193
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpP
Sy4gUmVhc29uYWJsZS4gV2lsbCB1cGRhdGUgdGhlIHBhdGNoZXMuDQoNCkJSLA0KRXZhbg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcu
bGVpY2h0enVtZXJrZW5AZ21haWwuY29tPg0KU2VudDogRnJpZGF5LCBNYXkgOCwgMjAyMCA2OjUz
IFBNDQpUbzogUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0KQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJA
YW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBkcm0vYW1kZ3B1OiBkZWNvZGUgdGhl
IGN0eGlkIGZvciBTTUMgdG8gaG9zdCBJSA0KDQpBbSAwOC4wNS4yMCB1bSAxMjowMiBzY2hyaWVi
IEV2YW4gUXVhbjoNCj4gRHJpdmVyIG5lZWRzIHRoYXQgdG8gdGVsbCB0aGUgZGlmZmVyZW50IGV2
ZW50cyByYWlzZWQgZnJvbSBTTUMuDQoNCk5BSywgdGhlIGN0eGlkIGlzIGZpbGxlZCBpbiBieSB0
aGUgU01DIGFuZCBub3QgYnkgdGhlIElILiBXZSBvbmx5IGRlY29kZSBmaWVsZHMgaGVyZSB3aGlj
aCBhcmUgZmlsbGVkIGluIGJ5IHRoZSBJSC4NCg0KSnVzdCB1c2Ugc3JjX2RhdGFbMF0gd2hlbiB5
b3UgbmVlZCBzb21lIFNNQyBzcGVjaWZpYyBiaXRzLg0KDQpDaHJpc3RpYW4uDQoNCj4NCj4gQ2hh
bmdlLUlkOiBJMGU0NGUyMjUyNzE4MmZiYjQ1YTJkYjRmYzNiMWNkNzNmYjE3YmEzMw0KPiBTaWdu
ZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXJxLmggfCAxICsNCj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9uYXZpMTBfaWguYyAgfCAxICsNCj4gICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS92ZWdhMTBfaWguYyAgfCAxICsNCj4gICAzIGZpbGVzIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2lycS5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5o
DQo+IGluZGV4IDdiMTc2MmIxYzU5NS4uOTY1ODc1YjhiZjkzIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXJxLmgNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5oDQo+IEBAIC01NSw2ICs1NSw3IEBAIHN0cnVjdCBh
bWRncHVfaXZfZW50cnkgew0KPiAgIHVuc2lnbmVkIHRpbWVzdGFtcF9zcmM7DQo+ICAgdW5zaWdu
ZWQgcGFzaWQ7DQo+ICAgdW5zaWduZWQgcGFzaWRfc3JjOw0KPiArdW5zaWduZWQgY3R4aWQ7IC8q
IGZvciBTTUMgdG8gSG9zdCBpbnRlcnJ1cHQgKi8NCj4gICB1bnNpZ25lZCBzcmNfZGF0YVtBTURH
UFVfSVJRX1NSQ19EQVRBX01BWF9TSVpFX0RXXTsNCj4gICBjb25zdCB1aW50MzJfdCAqaXZfZW50
cnk7DQo+ICAgfTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25h
dmkxMF9paC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2loLmMNCj4g
aW5kZXggZjk3ODU3ZWQzYzdlLi45MzJkYzNlYWJiZTIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L25hdmkxMF9paC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L25hdmkxMF9paC5jDQo+IEBAIC00NzAsNiArNDcwLDcgQEAgc3RhdGljIHZvaWQg
bmF2aTEwX2loX2RlY29kZV9pdihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gICBlbnRy
eS0+dGltZXN0YW1wX3NyYyA9IGR3WzJdID4+IDMxOw0KPiAgIGVudHJ5LT5wYXNpZCA9IGR3WzNd
ICYgMHhmZmZmOw0KPiAgIGVudHJ5LT5wYXNpZF9zcmMgPSBkd1szXSA+PiAzMTsNCj4gK2VudHJ5
LT5jdHhpZCA9IGR3WzRdOw0KPiAgIGVudHJ5LT5zcmNfZGF0YVswXSA9IGR3WzRdOw0KPiAgIGVu
dHJ5LT5zcmNfZGF0YVsxXSA9IGR3WzVdOw0KPiAgIGVudHJ5LT5zcmNfZGF0YVsyXSA9IGR3WzZd
Ow0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMN
Cj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMTBfaWguYw0KPiBpbmRleCA0MDdj
NjA5M2MyZWMuLmU0NmQxZjlmNjJjYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdmVnYTEwX2loLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
dmVnYTEwX2loLmMNCj4gQEAgLTQ2MCw2ICs0NjAsNyBAQCBzdGF0aWMgdm9pZCB2ZWdhMTBfaWhf
ZGVjb2RlX2l2KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiAgIGVudHJ5LT50aW1lc3Rh
bXBfc3JjID0gZHdbMl0gPj4gMzE7DQo+ICAgZW50cnktPnBhc2lkID0gZHdbM10gJiAweGZmZmY7
DQo+ICAgZW50cnktPnBhc2lkX3NyYyA9IGR3WzNdID4+IDMxOw0KPiArZW50cnktPmN0eGlkID0g
ZHdbNF07DQo+ICAgZW50cnktPnNyY19kYXRhWzBdID0gZHdbNF07DQo+ICAgZW50cnktPnNyY19k
YXRhWzFdID0gZHdbNV07DQo+ICAgZW50cnktPnNyY19kYXRhWzJdID0gZHdbNl07DQoNCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
