Return-Path: <SRS0=FRS3=EE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFC4C55179
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2020 18:08:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E9D20825
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2020 18:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PRVOWNBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E9D20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D1956E02A;
	Thu, 29 Oct 2020 18:08:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 981886E02A
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2020 18:08:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYUGsZJWFxAwSY7stA3kY1sJvzBV2pIVEWXt/kLmaPyytupxTGLNIJZPJoLrOL5H/AyJUFtZ+dLLpzpSw0HdsF4WbdeUDvf5myI+DAiPAUpgwFbcunuzWCLB4kjWzgp53v9h1Bd9QOrnhzrkZG9Gl9ixJSI2Z4pdBaPRGqOJllXKMKgxTWMd/79u6RPkBCrHzORWeNHBzmRMigKtsL5bBoolmC6mFQMYY2XZF8DKhU0l4xCsdN1g97xcGKbp5jrRqKp1FRjknQd1Jyomh/YBonN3jOI9Z0jOq9QAI/SGT+OY4oiCZkRfL7fW4DTA5WMIuVQjI4Kf9fJr3QgVIIDUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcYWaorYKV2rj5SmesV7yjTDNza7gP/u8tYs1GNvU74=;
 b=PQB4fmaBef4cFPiFIiVrstXL8FBjbgYKWf+wAQW+B3RqyXt2/L6lQE3CfdiWHEhHvD2rGLp/Bs/wLSRkh/d0ueeHuOrYKlKrVrNCPXZssMcOnGOMeMcRIh6txp/e+nnBVkBohI30EXGui+DdF4svkqFO5ZYvZh9aRSbgfKUAIEvxMDie3szAVZsYvFH+Qy/D8cmF/EAT15InXJDpyOnWEwjsndIcMdTpbj56RgntxNh2+Q7MAZAMt7VKgcnmxgPr3NvpF4kXcDFH0ggcOE6V9u5yE/T8k+Mh7gGCXCSg4mLYyX5sk8u0csyQdthkdyuieu0Ql+gJ6M39WTefwBgSjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcYWaorYKV2rj5SmesV7yjTDNza7gP/u8tYs1GNvU74=;
 b=PRVOWNBZ9Er/ucDU1hl3VMmR+R4rVfQn93+M0CwMK96FE07iDwwWeJSWo+XaxFtxKy32GyP1f0Yn2CeDSdi9btBN3ito/MbgUleaOwRpCtOB6d/PWoLzoUBLF0J3Xg+V6vTvbDDGAQC0ZP+OBn6OY8/lOS/1bITwQguQs3xO5lQ=
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2512.namprd12.prod.outlook.com (2603:10b6:802:31::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 29 Oct
 2020 18:08:17 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::d436:e21c:e4e8:7deb]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::d436:e21c:e4e8:7deb%5]) with mapi id 15.20.3499.028; Thu, 29 Oct 2020
 18:08:17 +0000
From: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add kernel parameter to force no xgmi
Thread-Topic: [PATCH] drm/amdgpu: Add kernel parameter to force no xgmi
Thread-Index: AQHWrTpgGfh0nq2AlkyvVjTAPFsimamtG0GA///hMACAAGPLIIABc1MAgAAOmmA=
Date: Thu, 29 Oct 2020 18:08:17 +0000
Message-ID: <SA0PR12MB4430999FE12FC5A9F201A571FD140@SA0PR12MB4430.namprd12.prod.outlook.com>
References: <20201028145502.2703-1-alex.sierra@amd.com>
 <7d27dd5f-e178-188a-6537-6b4d6d31b205@gmail.com>
 <4306b2ef-736c-57a3-4110-6fb953fb76d4@amd.com>
 <SA0PR12MB44307151BBED365DF7BB440AFD170@SA0PR12MB4430.namprd12.prod.outlook.com>
 <47fceadf-fe94-e35c-b8af-ec97b3563008@amd.com>
In-Reply-To: <47fceadf-fe94-e35c-b8af-ec97b3563008@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-29T18:08:13Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=bf3bb140-ec01-4c9d-be99-0000fb93dae6;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-29T18:08:06Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 93532346-81e4-4512-b611-0000f6c0919c
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-29T18:08:15Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: c77c20a0-b4fd-4030-baaa-0000d3d54b07
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.77.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 62df5e1d-dcce-4e56-63a8-08d87c359c82
x-ms-traffictypediagnostic: SN1PR12MB2512:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR12MB2512B37630D412FE8FDA4A58FD140@SN1PR12MB2512.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e1bWtvxLpX3iD6i2Nhg6iSawOI0ppV/QzoptwqtqmkHcvV6wpO8/cqzYprWXIcvpWkIKq897Ka2eZwoGdkeq0wx25nHf1r6cZIs8MUCwImX0Ql1qe3RQsluPYN5WFlG73uLsQpvR3lJiT4xSX8rAE40qBxzhKrzlqo2DHuSw/j59KksNI2QbWZnhipKTGogFLaz8dXxdxvnEo8XeSy5H1QyZa62rSAZW7ZiUuTL8mngOoG23bvZOGZE774YDLHmsBD8OwsADajyTulDGpnmWykvc+PY4dvmsuetFJ+ahGrYNGtY0pR24WeEjQKjYm1xkUpK5cW/xAPJboAAKlnUiOvCdrdRrNG20Jo7r9TB0aVec4h4+Glr62Hf8XLVIChSfjANIZF0Ll57XwUu2o7gYSg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(186003)(52536014)(26005)(8936002)(2906002)(83380400001)(5660300002)(45080400002)(66556008)(64756008)(55016002)(76116006)(8676002)(66946007)(66446008)(110136005)(66476007)(316002)(7696005)(966005)(53546011)(6506007)(4001150100001)(478600001)(86362001)(71200400001)(66574015)(33656002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: FhODTGsfTDDRFB1OPejSX7uuc29ZOFbSCgjrJG//RKgQ2SbEZV4ngYFQ5BrIoE25dFjru1fm8SNhSnWO1RyQInvQvHdNZVI88TmGaPlY2q51PkmI/qO8e2Y73D2niUolHj9h1jkbxJywmQ0inTQ1wB4UgXWUSvvhuAUJrJgeINCyNOwj58D4saIT8rY0BmZKjxJL1dYgDvTOKX/3AkO7iU+T91lIDb0upKDUaZChAHyOPTbGYnrh6LszvSWmOzvt0hHZXlofM1jWJR/IDyJ7d6ujRFKlvszlpMIb/qvPtzs04gxBxK4cLT6Dz4+8N/k5GwWXaZL5zUoHpVJ0gixI/qRYo+EqTt3X6m4NxVdKM1OcFMGpRvvrximmyHVU4yeEjDPbRi0yct7JPPQCY5eeLz/rhcWex3vbmvKcvQ7Bw/B07sgB+kFcgcWL91r1pJAYvcwMYT5gRDxOZWsd3RqHsQ8zRSnPD+wt9BtshQWvI33MDPNsGGtraLAFpgpI7CNm+3RE9zkDlqVLZaHeKbG3fvGa7LFRj3U2hPsdZagjNKkkdqihrf3+f6VFDbrAfrnjuDacizUTAuDteFYGD+iUJhhQPp7ECd5ehU6jJfSVAtqHlnBHSmOvaznq0Ea85GbTmQP6Z7qqabS3/vyhnw45sw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62df5e1d-dcce-4e56-63a8-08d87c359c82
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 18:08:17.3000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EC0ct4rxPTuB9SbOG6+ifsqjAqiYsz0ry8NVeMRV4RJXjwZF13SZl8PZjbc1JShAmf8JxIN+2sKsSk3MGSExjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2512
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

W0FNRCBQdWJsaWMgVXNlXQ0KDQpXaWxsIGRvIEx1YmVuLiBUaGFua3MgZm9yIHRoZSByZWNvbW1l
bmRhdGlvbi4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUdWlrb3Ys
IEx1YmVuIDxMdWJlbi5UdWlrb3ZAYW1kLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIg
MjksIDIwMjAgMTI6MTUgUE0NCj4gVG86IFNpZXJyYSBHdWl6YSwgQWxlamFuZHJvIChBbGV4KSA8
QWxleC5TaWVycmFAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+IDxDaHJpc3RpYW4uS29l
bmlnQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBBZGQga2VybmVsIHBhcmFtZXRlciB0byBmb3JjZSBubyB4
Z21pDQo+IA0KPiBPbiAyMDIwLTEwLTI4IDE1OjA5LCBTaWVycmEgR3VpemEsIEFsZWphbmRybyAo
QWxleCkgd3JvdGU6DQo+ID4gW0FNRCBQdWJsaWMgVXNlXQ0KPiA+DQo+ID4gUGxlYXNlIGlnbm9y
ZSB0aGlzIHBhdGNoLCBpdCBzaG91bGQgYmUgaW4gYSBkaWZmZXJlbnQgYnJhbmNoLiBBcyBQQ0ll
IHAycCBpcw0KPiBub3Qgc3VwcG9ydGVkIGluIHVwc3RyZWFtLg0KPiANCj4gTm8gcHJvYmxlbSwg
YnV0IGlmIHlvdSBkbyBhZGQgaXQgZWxzZXdoZXJlLCBwbGVhc2UgdXNlIHNvbWV0aGluZyBtb3Jl
DQo+IHNwZWNpZmljLCBsaWtlDQo+IA0KPiAJYW1kZ3B1X3hnbWlfcDJwDQo+IA0KPiBhcyB0aGUg
KHBvc2l0aXZlLWNvbnRyb2xsZWQpIGZsYWcsIHNpbmNlIG1vcmUgZ2VuZXJpYyBmbGFncyBjb3Vs
ZCBiZSBhZGRlZA0KPiBsYXRlciwgdG8gY29udHJvbCBhIG1vcmUgZW5jb21wYXNzaW5nIGJlaGF2
aW91ci4NCj4gDQo+IFJlZ2FyZHMsDQo+IEx1YmVuDQo+IA0KPiA+DQo+ID4gUmVnYXJkcywNCj4g
PiBBbGV4IFNpZXJyYQ0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+
IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9u
IEJlaGFsZiBPZg0KPiA+PiBTaWVycmEgR3VpemEsIEFsZWphbmRybyAoQWxleCkNCj4gPj4gU2Vu
dDogV2VkbmVzZGF5LCBPY3RvYmVyIDI4LCAyMDIwIDE6MDkgUE0NCj4gPj4gVG86IEtvZW5pZywg
Q2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBhbWQtDQo+ID4+IGdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTog
QWRkIGtlcm5lbCBwYXJhbWV0ZXIgdG8gZm9yY2Ugbm8NCj4gPj4geGdtaQ0KPiA+Pg0KPiA+Pg0K
PiA+PiBPbiAxMC8yOC8yMDIwIDk6NTggQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6DQo+ID4+
PiBBbSAyOC4xMC4yMCB1bSAxNTo1NSBzY2hyaWViIEFsZXggU2llcnJhOg0KPiA+Pj4+IEJ5IGVu
YWJsaW5nIHRoaXMgcGFyYW1ldGVyLCB0aGUgc3lzdGVtIHdpbGwgYmUgZm9yY2VkIHRvIHVzZSBw
Y2llDQo+ID4+Pj4gaW50ZXJmYWNlIG9ubHkgZm9yIHAycCB0cmFuc2FjdGlvbnMuDQo+ID4+Pg0K
PiA+Pj4gQmV0dGVyIG5hbWUgdGhhdCBhbWRncHVfeGdtaSB3aXRoIGEgZGVmYXVsdCB2YWx1ZSBv
ZiBlbmFibGVkLg0KPiA+Pj4NCj4gPj4+IE9yIG1heWJlIGFkZCBhbm90aGVyIGJpdCB2YWx1ZSBm
b3IgYW1kZ3B1X3ZtX2RlYnVnIGluc3RlYWQuDQo+ID4+DQo+ID4+IEFjaw0KPiA+Pg0KPiA+PiBS
ZWdhcmRzLA0KPiA+PiBBbGV4IFNpZXJyYQ0KPiA+Pg0KPiA+Pj4NCj4gPj4+DQo+ID4+Pj4NCj4g
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IFNpZXJyYSA8YWxleC5zaWVycmFAYW1kLmNvbT4NCj4g
Pj4+PiAtLS0NCj4gPj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaMKg
wqDCoMKgwqDCoMKgIHwgMSArDQo+ID4+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jIHwgMiArLQ0KPiA+Pj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kcnYuY8KgwqDCoCB8IDkgKysrKysrKysrDQo+ID4+Pj4gwqAgMyBmaWxlcyBj
aGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+Pj4NCj4gPj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgNCj4gPj4+PiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+ID4+Pj4gaW5kZXggYmE2NWQ0
ZjJhYjY3Li4zNjQ1ZjAwZTlmNjEgMTAwNjQ0DQo+ID4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1LmgNCj4gPj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHUuaA0KPiA+Pj4+IEBAIC0xODgsNiArMTg4LDcgQEAgZXh0ZXJuIGludCBhbWRn
cHVfZGlzY292ZXJ5Ow0KPiA+Pj4+IMKgIGV4dGVybiBpbnQgYW1kZ3B1X21lczsNCj4gPj4+PiDC
oCBleHRlcm4gaW50IGFtZGdwdV9ub3JldHJ5Ow0KPiA+Pj4+IMKgIGV4dGVybiBpbnQgYW1kZ3B1
X2ZvcmNlX2FzaWNfdHlwZTsNCj4gPj4+PiArZXh0ZXJuIGludCBhbWRncHVfZm9yY2Vfbm9feGdt
aTsNCj4gPj4+PiDCoCAjaWZkZWYgQ09ORklHX0hTQV9BTUQNCj4gPj4+PiDCoCBleHRlcm4gaW50
IHNjaGVkX3BvbGljeTsNCj4gPj4+PiDCoCBleHRlcm4gYm9vbCBkZWJ1Z19ldmljdGlvbnM7DQo+
ID4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYw0KPiA+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
DQo+ID4+Pj4gaW5kZXggMWZlODUwZTBhOTRkLi4wYTVkOTdhODQwMTcgMTAwNjQ0DQo+ID4+Pj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4+Pj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4+Pj4g
QEAgLTIyNTcsNyArMjI1Nyw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RldmljZV9pcF9pbml0KHN0
cnVjdA0KPiA+Pj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4+Pj4gwqDCoMKgwqDCoCBpZiAo
cikNCj4gPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBpbml0X2ZhaWxlZDsNCj4gPj4+PiDC
oCAtwqDCoMKgIGlmIChhZGV2LT5nbWMueGdtaS5udW1fcGh5c2ljYWxfbm9kZXMgPiAxKQ0KPiA+
Pj4+ICvCoMKgwqAgaWYgKCFhbWRncHVfZm9yY2Vfbm9feGdtaSAmJiBhZGV2LQ0KPiA+Pj4gZ21j
LnhnbWkubnVtX3BoeXNpY2FsX25vZGVzID4NCj4gPj4+PiArMSkNCj4gPj4+DQo+ID4+PiBNaG0s
IHRoaXMgd2lsbCBtb3N0IGxpa2VseSBjYXVzZSBwcm9ibGVtcy4gWW91IHN0aWxsIG5lZWQgdG8g
YWRkIHRoZQ0KPiA+Pj4gZGV2aWNlIHRvIHRoZSBoaXZlIGJlY2F1c2Ugb3RoZXJ3aXNlIEdQVSB3
b24ndCB3b3JrLg0KPiA+Pg0KPiA+PiBXaGF0IGtpbmQgb2YgcHJvYmxlbXM/IFNvIGZhciwgSSBo
YXZlIHZhbGlkYXRlZCB0aGlzIHVzaW5nIGEgc3lzdGVtDQo+ID4+IHdpdGggbXVsdGlwbGUgZGV2
aWNlcyBhbmQgcnVubmluZyAuL3JvY21fYmFuZHdpZHRoX3Rlc3QgLXQuIFdpdGggYW5kDQo+ID4+
IHdpdGhvdXQgdGhlIHBhcmFtZXRlciBzZXQuDQo+ID4+DQo+ID4+IFJlZ2FyZHMsDQo+ID4+IEFs
ZXggU2llcnJhDQo+ID4+DQo+ID4+Pg0KPiA+Pj4gQXBhcnQgZnJvbSB0aGF0IHNvdW5kcyBsaWtl
IGEgZ29vZCBpZGVhIGluIGdlbmVyYWwuDQo+ID4+Pg0KPiA+Pj4gQ2hyaXN0aWFuLg0KPiA+Pj4N
Cj4gPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X3hnbWlfYWRkX2RldmljZShhZGV2KTsN
Cj4gPj4+PiDCoMKgwqDCoMKgIGFtZGdwdV9hbWRrZmRfZGV2aWNlX2luaXQoYWRldik7DQo+ID4+
Pj4gwqAgZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYu
Yw0KPiA+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+ID4+
Pj4gaW5kZXggNGI3OGVjZmQzNWY3Li4yMjQ4NTA2N2NmMzEgMTAwNjQ0DQo+ID4+Pj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+ID4+Pj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+ID4+Pj4gQEAgLTE2MCw2ICsx
NjAsNyBAQCBpbnQgYW1kZ3B1X2ZvcmNlX2FzaWNfdHlwZSA9IC0xOw0KPiA+Pj4+IMKgIGludCBh
bWRncHVfdG16ID0gMDsNCj4gPj4+PiDCoCBpbnQgYW1kZ3B1X3Jlc2V0X21ldGhvZCA9IC0xOyAv
KiBhdXRvICovDQo+ID4+Pj4gwqAgaW50IGFtZGdwdV9udW1fa2NxID0gLTE7DQo+ID4+Pj4gK2lu
dCBhbWRncHVfZm9yY2Vfbm9feGdtaSA9IDA7DQo+ID4+Pj4gwqAgwqAgc3RydWN0IGFtZGdwdV9t
Z3B1X2luZm8gbWdwdV9pbmZvID0gew0KPiA+Pj4+IMKgwqDCoMKgwqAgLm11dGV4ID0gX19NVVRF
WF9JTklUSUFMSVpFUihtZ3B1X2luZm8ubXV0ZXgpLA0KPiA+Pj4+IEBAIC01MjIsNiArNTIzLDE0
IEBAIG1vZHVsZV9wYXJhbV9uYW1lZChyYXNfZW5hYmxlLA0KPiA+Pj4+IGFtZGdwdV9yYXNfZW5h
YmxlLCBpbnQsIDA0NDQpOw0KPiA+Pj4+IMKgIE1PRFVMRV9QQVJNX0RFU0MocmFzX21hc2ssICJN
YXNrIG9mIFJBUyBmZWF0dXJlcyB0byBlbmFibGUNCj4gPj4gKGRlZmF1bHQNCj4gPj4+PiAweGZm
ZmZmZmZmKSwgb25seSB2YWxpZCB3aGVuIHJhc19lbmFibGUgPT0gMSIpOw0KPiA+Pj4+IMKgIG1v
ZHVsZV9wYXJhbV9uYW1lZChyYXNfbWFzaywgYW1kZ3B1X3Jhc19tYXNrLCB1aW50LCAwNDQ0KTsN
Cj4gPj4+PiDCoCArLyoqDQo+ID4+Pj4gKyAqIERPQzogZm9yY2Vfbm9feGdtaSAodWludCkNCj4g
Pj4+PiArICogRm9yY2VzIG5vdCB0byB1c2UgeGdtaSBpbnRlcmZhY2UgKDAgPSBkaXNhYmxlLCAx
ID0gZW5hYmxlKS4NCj4gPj4+PiArICogRGVmYXVsdCBpcyAwIChkaXNhYmxlZCkuDQo+ID4+Pj4g
KyAqLw0KPiA+Pj4+ICtNT0RVTEVfUEFSTV9ERVNDKGZvcmNlX25vX3hnbWksICJGb3JjZSBub3Qg
dG8gdXNlIHhnbWkNCj4gPj4gaW50ZXJmYWNlIik7DQo+ID4+Pj4gK21vZHVsZV9wYXJhbV9uYW1l
ZChmb3JjZV9ub194Z21pLCBhbWRncHVfZm9yY2Vfbm9feGdtaSwNCj4gaW50LA0KPiA+PiAwNjAw
KTsNCj4gPj4+PiArDQo+ID4+Pj4gwqAgLyoqDQo+ID4+Pj4gwqDCoCAqIERPQzogc2lfc3VwcG9y
dCAoaW50KQ0KPiA+Pj4+IMKgwqAgKiBTZXQgU0kgc3VwcG9ydCBkcml2ZXIuIFRoaXMgcGFyYW1l
dGVyIHdvcmtzIGFmdGVyIHNldCBjb25maWcNCj4gPj4+PiBDT05GSUdfRFJNX0FNREdQVV9TSS4g
Rm9yIFNJIGFzaWMsIHdoZW4gcmFkZW9uIGRyaXZlciBpcw0KPiBlbmFibGVkLA0KPiA+Pj4NCj4g
Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gPj4g
YW1kLWdmeCBtYWlsaW5nIGxpc3QNCj4gPj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj4gPj4NCj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/
dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuDQo+ID4+IGZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4l
MkZsaXN0aW5mbyUyRmFtZC0NCj4gPj4NCj4gZ2Z4JmFtcDtkYXRhPTA0JTdDMDElN0NhbGV4LnNp
ZXJyYSU0MGFtZC5jb20lN0M2YTJlMzQ0MjdmYjQ0OTg2NQ0KPiA+Pg0KPiA5MTIwOGQ4N2I2Yzhj
MDUlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjMNCj4gPj4N
Cj4gNzM5NTA1MzQ1NzM0NzYzMyU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdM
akF3TUQNCj4gPj4NCj4gQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2
TW4wJTNEJTdDMzAwMCZhbXA7c2RhdGE9DQo+ID4+DQo+IHMyaFhWQVZGdEhKc05OQndoenpLRGpN
bEVqRVM5dU5HYllpNkdkZUQ1Y2MlM0QmYW1wO3Jlc2VydmVkPTANCj4gPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiA+IGFtZC1nZnggbWFpbGluZyBs
aXN0DQo+ID4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPiBodHRwczovL25hbTEx
LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0
DQo+ID4gcy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtDQo+IGdm
eCZhbXA7ZGF0YT0wNCU3QzAxJTdDbHUNCj4gPg0KPiBiZW4udHVpa292JTQwYW1kLmNvbSU3Q2Vk
ZDQ3OWY0OTVmZjQyYzMwNTk0MDhkODdiNzUwNzBiJTdDM2RkODk2DQo+IDFmZTQ4OA0KPiA+DQo+
IDRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzczOTUwODk4ODI5NjYzNzUlN0NVbmtu
b3duJTcNCj4gQ1RXRnBiR1pzDQo+ID4NCj4gYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlq
b2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uDQo+IDAlM0QNCj4gPg0KPiAlN0Mx
MDAwJmFtcDtzZGF0YT1LM0FLRDV0YnI4MndWTVpES2xDaVZPMVAzTWtWJTJGeXJ5cXhGM0t5T2wx
DQo+IHVVJTNEJmFtcA0KPiA+IDtyZXNlcnZlZD0wDQo+ID4NCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
