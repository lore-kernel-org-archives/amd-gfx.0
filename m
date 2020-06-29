Return-Path: <SRS0=Kvqq=AK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01B0C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 12:35:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B24E823CD4
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 12:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Un9yjQ9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24E823CD4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A91D89F31;
	Mon, 29 Jun 2020 12:35:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA54B89F31
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 12:35:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5YwW0gtAddLJd3yi6WjvqZEVfMFVd7mx4hUdPKp6wmYS7Jul9Q1vBXteoh/GGgbMLUimMSSYzIRQhXwNWwAem7jzjaGH3ygJ6jqnFeHCjfsADXud5rL5xUBy2zErkOcBTe3wz4yRxN4h+X6GhcOs5H+PjXunnRGfV3XuyN/snk4uNs+plgNGRwEo5BhCP9fO2TKbiG6pAjGioHf/3WZA+NZTUrydFlSXzRwcmfnIQRIKsLyeFve/nZSNhepIbgeOBGJmJFfat2f+vB5oClVvKi15g/7ByVrjs80ozSUszuDqcv9QwDJl7ETFdtILFO/s1Srd5rwo6t/XnaA4Fm4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3HPqJpMr+HD+UtFPi9kDA9K5eGmlfFjxhCQrtIPUvA=;
 b=ioLsx+8O1PrWe91mJTIN9uDC7wLaPVWAvYuacanFWeyjNuIxBievpH02ifBRzQnARFtdez1V0Ec5yOONw/Spo+1IYrDi2GsO2g+wXyGDLmcMSQPWcn1VWnFDr1cnggqLw0By4wsZZZO4iBPksxw1PdTY8HNSpONYCCiwDoyG07uX2kzf4uhw8BJh9a7Wu1zNhvXRT8GLCoToikXMJxmnjQnrTKUifeIZP7Rfz/CWQVkzM5UJV0DzPJwdAiLiLL2wnbEOwTMqixTpmgSUDbBsdQji7VY33xLTewAeHQIXnTHp+w0fAFB3276yRU2Y3HFgUAaXvcuBMCBgIeZ1lUolSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3HPqJpMr+HD+UtFPi9kDA9K5eGmlfFjxhCQrtIPUvA=;
 b=Un9yjQ9ZlFtFAZKq/tHmlTTsLaqrfP2sNlRORRWE22ooafix7So7cfmV+BrxE1H7HpssI8Y+MBLfw1E5fiFiysUZ30GVsV+Di6ehFJpyWnvSdZIHA2+oLiWJBa6atJJdfPxF5vs0HIplGugHRTfCOWsm5TiX57K+X78vSQiDwMI=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB4089.namprd12.prod.outlook.com (2603:10b6:5:213::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Mon, 29 Jun
 2020 12:35:41 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648%3]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 12:35:41 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix compile warning in amdgpu_fru_read_eeprom
Thread-Topic: [PATCH] drm/amdgpu: Fix compile warning in amdgpu_fru_read_eeprom
Thread-Index: AQHWTg6wOnOSS3DB9USE4UrWxAOyQqjvgkCAgAAAYnCAAALngIAAAEvA
Date: Mon, 29 Jun 2020 12:35:41 +0000
Message-ID: <DM6PR12MB3721970740F9380319133483856E0@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200629121313.18064-1-kent.russell@amd.com>
 <ade43f8c-6ea1-ea69-d173-323e1d1f1867@gmail.com>
 <DM6PR12MB3721818B463CF5BE7BFD5F72856E0@DM6PR12MB3721.namprd12.prod.outlook.com>
 <10dc15f9-4657-12bb-70ba-fa44ea137c88@amd.com>
In-Reply-To: <10dc15f9-4657-12bb-70ba-fa44ea137c88@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-29T12:34:57Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=20487ee6-d3be-45c2-b0e3-000038f3988a;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-06-29T12:34:50Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: ab2f365f-6336-4393-a239-0000b620b33d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-06-29T12:35:39Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: ae89a7a5-e4f8-4ef7-8f4e-0000677e9fa4
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2d37dc01-e9c0-43e5-87bb-08d81c28ef64
x-ms-traffictypediagnostic: DM6PR12MB4089:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB40890D53D7EB073CCAE85220856E0@DM6PR12MB4089.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:663;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OEu1GyDuemVMHx79Fn39nZg0QkCdcoeGV2dS2+zES4UFp4Q/6SCxLa5jKkWUh+bgrzl7q8IDD1zZPVEjwTT8rnfo1YW/VSQQm5QSAJptzBf139A5A3aunEwEjNAFtBwJsWRIMVu2Ts3nrOeDmmszzRf+OcaCOVBBEeI86/HiYxLJTJV8G7v8VYg5YrLglNDTingK3efufSoO+UIlZhxOuv93OxYGITbhv4uWaImgMPFe0Dkb4Z2cZEa3njCkCQqeRcA7KnwgjfALP936F8KpVetAfeMCkpYIXc6aFab/zIbU+kuJhkXEI7vTqlIBjs2lcuWBDATnc4oIROp0iBt60A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(33656002)(52536014)(478600001)(86362001)(66446008)(5660300002)(2906002)(66476007)(66946007)(8676002)(71200400001)(66574015)(6506007)(7696005)(8936002)(64756008)(55016002)(9686003)(83380400001)(26005)(186003)(110136005)(76116006)(316002)(66556008)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 5deQ++qlzYeuKf5HxFdLFVlHY0SemwsBdSLWLsKMI1ZK0zqpnf9oXux/XVepWiwbqMc3q/h2syl7zln67QIyGukYekCad5ewUh5clmORb3KeLxLwxcbPmXEI0RieQgAvzrgRD6XnypEpekDFTD4X7WqofKVgt2jOW+KwP0Mg+APaz1V53v1L+AL1IeHJrEd7N1/YF9tC2EfccoHuh7q3wkXV4KaEIQQXtK3gEcoCa+x8vsno8Le+OnF2Aapr5EFiIZTFa+WeKYPwsbi3bOHWjqa/HbLkHbX5ALJJzvE/l0UAvmf07qH5mKmKoqFjOlLVZz5yYZ6RTzSFJkfiLBgXzFrELzTH+6yGEwnIC2bYDfOfGgH/DMvu1VidnEbsae6chy9LcMTpaSllKxBNgzzsmgMiMg6cofUYsMmAWXsSUNpsfZDqozVGe52YfZgWz3FobkPfIOgtf0N0oPzD03XahCdsK8Y4LJHkDusPH8TVGIgTzAdw/rZkLsaf2Lacpbo7
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d37dc01-e9c0-43e5-87bb-08d81c28ef64
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 12:35:41.2968 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gWTpaQr+c3eMCpqiY8xagSNfux8gAjjVvdr9aPWqQnaVgmkJ94MpKqntUQtLl+ewywX/dH7aqIMKMiCGmbCyQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4089
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

W0FNRCBQdWJsaWMgVXNlXQ0KDQpUaGFua3MgZm9yIG1ha2luZyBtZSBsb29rIGF0IGl0IGNyaXRp
Y2FsbHkgKHNvbWV0aGluZyBJIHNob3VsZCBkbyBtb3JlIGFmdGVyIHJldHVybmluZyBmcm9tIDIg
d2Vla3MgdmFjYXRpb24pLiBOaXJtb3kgZml4ZWQgdGhlIGlzc3VlIGJ5IHVzaW5nIGEgc3RhdGlj
IGRlZmluZSBpbiBoaXMgIiBkcm0vYW1kZ3B1OiBsYWJlbCBpbnRlcm5hbGx5IHVzZWQgc3ltYm9s
cyBhcyBzdGF0aWMiIHBhdGNoIGFuZCBJIHdhcyBqdXN0IGluIGF1dG9waWxvdCB0cnlpbmcgdG8g
Zml4IHRoZSBJbnRlbCBrYm90IGVycm9yIGVtYWlsIHRoYXQgSSByZWNlaXZlZCB3aGlsZSBhd2F5
LCBub3QgYWN0dWFsbHkgcmVhbGl6aW5nIHRoYXQgaXQgd2FzIGZpeGVkIGFuZCBJIHdhcyBicmVh
a2luZyBhbmQgdW5icmVha2luZyBpdCBkdXJpbmcgcmViYXNpbmcuIFRoaXMgdGhyZWFkIGNhbiBi
ZSBpZ25vcmVkLiBUaW1lIGZvciBzb21lIGNvZmZlZS4NCg0KIEtlbnQNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktv
ZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBNb25kYXksIEp1bmUgMjksIDIwMjAgODoyOSBBTQ0KPiBU
bzogUnVzc2VsbCwgS2VudCA8S2VudC5SdXNzZWxsQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBGaXggY29t
cGlsZSB3YXJuaW5nIGluDQo+IGFtZGdwdV9mcnVfcmVhZF9lZXByb20NCj4gDQo+IE9rLCB0aGVu
IHdoeSBkb2VzIGl0IGZpeCBhIHdhcm5pbmcgaWYgd2UgbWFrZSBpdCBub24tc3RhdGljPw0KPiAN
Cj4gSWYgdGhlIGZ1bmN0aW9uIHVzZWQgaXQgY29tcGlsZWQgdW5kZXIgc29tZSAjaWZkZWYgdGhl
biB3ZSBzaG91bGQgcHJvYmFibHkNCj4ganVzdCBjb21waWxlIHRoaXMgdW5kZXIgI2lmZGVmIGFz
IHdlbGwuDQo+IA0KPiBDaHJpc3RpYW4uDQo+IA0KPiBBbSAyOS4wNi4yMCB1bSAxNDoyMCBzY2hy
aWViIFJ1c3NlbGwsIEtlbnQ6DQo+ID4gW0FNRCBQdWJsaWMgVXNlXQ0KPiA+DQo+ID4gSXQncyB1
c2VkIHJlcGVhdGVkbHkgaW4gdGhlIGFtZGdwdV9mcnVfZ2V0X3Byb2R1Y3RfaW5mbyBmdW5jdGlv
biwgYnV0IG9ubHkNCj4gaW4gdGhhdCBmdW5jdGlvbiB3aGljaCBpcyBpbiB0aGUgYW1kZ3B1X2Zy
dV9lZXByb20uYyBmaWxlLiBXaGlsZSBpdCBjb3VsZCBiZQ0KPiB0aGVvcmV0aWNhbGx5IGJlIHVz
ZWQgZWxzZXdoZXJlLCBpdCBpc24ndCBjdXJyZW50bHkgYW5kIGFueSBvdGhlciB1c2FnZSB3b3Vs
ZA0KPiBiZSBiZXN0IGNvbnRhaW5lZCBpbiB0aGUgYW1kZ3B1X2ZydV9lZXByb20uYyBmaWxlLg0K
PiA+DQo+ID4gICBLZW50DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
Pj4gRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5j
b20+DQo+ID4+IFNlbnQ6IE1vbmRheSwgSnVuZSAyOSwgMjAyMCA4OjE3IEFNDQo+ID4+IFRvOiBS
dXNzZWxsLCBLZW50IDxLZW50LlJ1c3NlbGxAYW1kLmNvbT47DQo+ID4+IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IEZp
eCBjb21waWxlIHdhcm5pbmcgaW4NCj4gPj4gYW1kZ3B1X2ZydV9yZWFkX2VlcHJvbQ0KPiA+Pg0K
PiA+PiBBbSAyOS4wNi4yMCB1bSAxNDoxMyBzY2hyaWViIEtlbnQgUnVzc2VsbDoNCj4gPj4+IFRo
aXMgZml4ZXMgdGhlIG1pc3NpbmctcHJvdG90eXBlcyB3YXJuaW5nIGZvciB0aGUNCj4gPj4+IGFt
ZGdwdV9mcnVfcmVhZF9lZXByb20gZnVuY3Rpb24uIFNpbmNlIHdlIGRlY2xhcmUgaXQgaW4gdGhl
IGhlYWRlciwNCj4gPj4+IHdlIGNhbiBtYWtlIGl0IHVuLXN0YXRpYw0KPiA+PiBXZWxsIGlzIGl0
IHVzZWQgaW4gZGlmZmVyZW50IGZpbGVzPyBPdGhlcndpc2Ugd2UgbWlnaHQganVzdCBoYXZlDQo+
ID4+IHVudXNlZCBjb2RlIGluIHRoZSBtb2R1bGUgd2hpY2ggY2FuIHBvdGVudGlhbGx5IHJhaXNl
IGEgd2FybmluZyBhcyB3ZWxsLg0KPiA+Pg0KPiA+PiBDaHJpc3RpYW4uDQo+ID4+DQo+ID4+PiBT
aWduZWQtb2ZmLWJ5OiBLZW50IFJ1c3NlbGwgPGtlbnQucnVzc2VsbEBhbWQuY29tPg0KPiA+Pj4g
UmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiA+Pj4gQ2hh
bmdlLUlkOiBJMmI5NDE5MzY1Y2I4YjM4YmNmYjY1ODJkZjUzYjk2YzgzODYxZDZjZg0KPiA+Pj4g
LS0tDQo+ID4+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZnJ1X2VlcHJv
bS5jIHwgMiArLQ0KPiA+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Zy
dV9lZXByb20uaCB8IDIgKysNCj4gPj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVwcm9tLmMNCj4gPj4+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZydV9lZXByb20uYw0KPiA+Pj4gaW5kZXggZTgxMWZlY2M1
NDBmLi42OGVkMTZlNGQ4YmUgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZnJ1X2VlcHJvbS5jDQo+ID4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZnJ1X2VlcHJvbS5jDQo+ID4+PiBAQCAtNDgsNyArNDgsNyBAQCBz
dGF0aWMgYm9vbCBpc19mcnVfZWVwcm9tX3N1cHBvcnRlZChzdHJ1Y3QNCj4gPj4gYW1kZ3B1X2Rl
dmljZSAqYWRldikNCj4gPj4+ICAgIAlyZXR1cm4gZmFsc2U7DQo+ID4+PiAgICB9DQo+ID4+Pg0K
PiA+Pj4gLXN0YXRpYyBpbnQgYW1kZ3B1X2ZydV9yZWFkX2VlcHJvbShzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwNCj4gPj4+IHVpbnQzMl90IGFkZHJwdHIsDQo+ID4+PiAraW50IGFtZGdwdV9m
cnVfcmVhZF9lZXByb20oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90DQo+ID4+
PiArYWRkcnB0ciwNCj4gPj4+ICAgIAkJCSAgIHVuc2lnbmVkIGNoYXIgKmJ1ZmYpDQo+ID4+PiAg
ICB7DQo+ID4+PiAgICAJaW50IHJldCwgc2l6ZTsNCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZnJ1X2VlcHJvbS5oDQo+ID4+PiBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVwcm9tLmgNCj4gPj4+IGluZGV4IGYyOWE4
NjExZDY5Yi4uZjQwMjRmMWQ2NmM5IDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2ZydV9lZXByb20uaA0KPiA+Pj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZydV9lZXByb20uaA0KPiA+Pj4gQEAgLTI0LDYgKzI0LDgg
QEANCj4gPj4+ICAgICNpZm5kZWYgX19BTURHUFVfRlJVX0VFUFJPTV9IX18NCj4gPj4+ICAgICNk
ZWZpbmUgX19BTURHUFVfRlJVX0VFUFJPTV9IX18NCj4gPj4+DQo+ID4+PiAraW50IGFtZGdwdV9m
cnVfcmVhZF9lZXByb20oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90DQo+ID4+
IGFkZHJwdHIsDQo+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgY2hh
ciAqYnVmZik7DQo+ID4+PiAgICBpbnQgYW1kZ3B1X2ZydV9nZXRfcHJvZHVjdF9pbmZvKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KTsNCj4gPj4+DQo+ID4+PiAgICAjZW5kaWYgIC8vIF9fQU1E
R1BVX1BST0RJTkZPX0hfXw0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
