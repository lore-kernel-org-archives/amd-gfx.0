Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33C4C4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 19:09:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E09424813
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 19:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="p2+tmngo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E09424813
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83778883A9;
	Wed, 28 Oct 2020 19:09:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7C2D89D8D
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 19:09:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ax7eVZbPX4vvWfCZPJd6NdJ8m2cp+9xAHx0PfmQwnNp41YGhllWkm1Exe7G2IKa1TDriPXTyZIcHrbPDbPhDMwljODYlcrMAFxL15r0n5Mz8a1DCHu/IwKmlAmwqsyiDusSnLVlzJ1QK4m3UJcrsywUlyGKY0eIMAfzN6lL4TFO3qTT0eaN8bT1XDyE3ziCXOJ7JgXjL7jy4yToNDySFlloAzntibnR9a73l6MfkZ2oNhYc2PyEfNSKP4Nx+0brpOrb7cbCuLzEFB0mUdAceJnXQirkH1/Uy25sdt2OmOAMSwa24w8ikCu22UrYqYcQUMPFRrMA/U4mWuRHmKZPhwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39w98aZNRIeCsKio/w/awokSO5RpcDqPbsZWIDzuHqw=;
 b=jXMwxFqGG4gtjtvnxAlyERGnagpfQHdaIqKiaGzmbBd6oEk9gU8mOB5Jt1GS5wa7fhe5hD5FuTh1NVWBp0u/UrQNFIafZzvQP0Vg94hsmGmqcApC8fEstGdp37lSxSL+Gohn0XjnbbcXH/HpdtKyAMMLKR8UHb+E3R9QsHV+jkEqc7NWDi0iICOWA3B7ukCuEjMn3lUihSiivCjUWeqS183OeliK0HCy96x8SoF+tPevdXxnzq10Y+AyMynQd+En8i0qiRtV6UKEfsC1bxqDzxHov4zetUqiYMd2QPbPcxE9PvGhsJ/cmSjJbGNzxnwxbv7sw6Vcw2ytcCCKBgmLSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39w98aZNRIeCsKio/w/awokSO5RpcDqPbsZWIDzuHqw=;
 b=p2+tmngo318YKb75jO+21URMk44TF8qkb9RekzwFtxXTIBppwN+uQfjVLDbuTjkBYrhB6GJRcqF0uO+mqUHWBbPmKrD20ntc44C0biQoM+M3QLtC30cFJVsTM+py/A2H3b5qPT2pZE9eNpx3I/DDuCle06C33VkS/q5meS0ZB8A=
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN6PR12MB2717.namprd12.prod.outlook.com (2603:10b6:805:68::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Wed, 28 Oct
 2020 19:09:33 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::d436:e21c:e4e8:7deb]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::d436:e21c:e4e8:7deb%5]) with mapi id 15.20.3499.019; Wed, 28 Oct 2020
 19:09:33 +0000
From: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>
To: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add kernel parameter to force no xgmi
Thread-Topic: [PATCH] drm/amdgpu: Add kernel parameter to force no xgmi
Thread-Index: AQHWrTpgGfh0nq2AlkyvVjTAPFsimamtG0GA///hMACAAGPLIA==
Date: Wed, 28 Oct 2020 19:09:33 +0000
Message-ID: <SA0PR12MB44307151BBED365DF7BB440AFD170@SA0PR12MB4430.namprd12.prod.outlook.com>
References: <20201028145502.2703-1-alex.sierra@amd.com>
 <7d27dd5f-e178-188a-6537-6b4d6d31b205@gmail.com>
 <4306b2ef-736c-57a3-4110-6fb953fb76d4@amd.com>
In-Reply-To: <4306b2ef-736c-57a3-4110-6fb953fb76d4@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-28T19:09:22Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c02c7b08-14b4-4429-8c65-00006aa234db;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-28T19:09:00Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 90bd994b-765a-4af2-aa6e-0000cd87d3f1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-28T19:09:30Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: b6f0a81a-89eb-4143-bd76-0000bffc21b1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.77.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 078aa9ba-9269-4857-9a1f-08d87b750123
x-ms-traffictypediagnostic: SN6PR12MB2717:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB27177E79E947041348AC7930FD170@SN6PR12MB2717.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o0q+Bx81LtIj2eLXGqGpb5habHVn/MH46XW5pxBKCvOKAYFG2cDQz69DTGc712GYdeBv52NOGCSzPzA19RGwf0GcjeCbUjS1Dp/4n6Rxs/fTho6UiQ+udhbvlraYV7uFGMKDnSH/Kpl6DAXLmr+bEuTjzqPC2hizalHbyjAYD0DgcOJPGDWQaHgdFlHjYGr9OjR5VuYR8ki2Dm2w9lzPe3n7tq0BDoXRa3CRLh5yhD84E1Vupglk8s6tsHv7z4X05Q2O7bsHFGZIc0/PD+/Rwc7IUEdWY6ZsTnfxiG21DYpj2hWJFHQ9uxRUnSguFbK2seHCefzYb0jPwOOuW/s3QNyYjlhgrckz+JloRu2Xc4BjNr9HkyA4vM4eJuHF2H+YAKXTTHXfisE65f5Zd+ZdaQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(7696005)(53546011)(52536014)(76116006)(26005)(8936002)(6506007)(8676002)(9686003)(66946007)(71200400001)(64756008)(110136005)(45080400002)(66476007)(66446008)(5660300002)(66556008)(478600001)(33656002)(966005)(316002)(186003)(86362001)(83380400001)(2906002)(66574015)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Nv7TTmk1rwdI38d2TcmhtwqmZNIivZ0RxANBGzgk6UJuRHXApLKv5yqqXN2wyDOpCe0O1tdnU2fCxmZyk5IKgyXYdGZi79en90jgPOVJZJ7joirY41MzB9t9i0ZOBYdwZkflXkafotVRQKN/b/ZCleirhF4LPrbqcGyvWEUwvAnuyRqqqcoRSqsvmeOS3fVIbenOahDD0EGGH8ubbp8eG3htZrgIZaUbOgHQEMn3BDfgtXw3S7nFlw5vXXFXFFRCNKfpkjqmQoyVPF2jlhINS5c0bfkeqz+DtF9318fth5bLuuy4G0EX7tU2HH6Ksvj5TQ10E66jVi6HKfETNSYHR6U00hrteL5TXSdZVPDck4eWlRCIBXlkq4oFGgSc0rKK3rSgHRWTwRMpeVnNgb4FqGo/rizBy6S5b7mIqusSHHI2mPezQQdabtuNtEUTtFa6E3Qu/RFymftmhpc/MW7lkBH+8Jh/k5Otxs8rzweDuf16fFGlMh3sQb15Wl+HJbXw2wHKFM4DAWDxHaAjb+TDq3DSeNNu+NroM87DP9+ISKxm7SDJ5zJ4WOpnkfWANeVgA5b3aZWHEaKkl2lSvAGywH4LjaWsle2INqweVSR7oZMT814wCYAa0D9ehs0iJ56jbrXGpGT5w9Am1kH5PJtSxA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078aa9ba-9269-4857-9a1f-08d87b750123
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 19:09:33.2051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RMOb6f9EyCA2QJMasMBmykHTrkpbVWUAZzJqV1RedrJgO8v3I8Mj4EcwxoAtQzGptAxl6l4bPRdP3WlQO+voxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2717
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

W0FNRCBQdWJsaWMgVXNlXQ0KDQpQbGVhc2UgaWdub3JlIHRoaXMgcGF0Y2gsIGl0IHNob3VsZCBi
ZSBpbiBhIGRpZmZlcmVudCBicmFuY2guIEFzIFBDSWUgcDJwIGlzIG5vdCBzdXBwb3J0ZWQgaW4g
dXBzdHJlYW0uDQoNClJlZ2FyZHMsDQpBbGV4IFNpZXJyYQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVz
a3RvcC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBTaWVycmEgR3VpemEsIEFsZWphbmRybyAoQWxleCkN
Cj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDI4LCAyMDIwIDE6MDkgUE0NCj4gVG86IEtvZW5p
ZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBhbWQtDQo+IGdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogQWRk
IGtlcm5lbCBwYXJhbWV0ZXIgdG8gZm9yY2Ugbm8geGdtaQ0KPiANCj4gDQo+IE9uIDEwLzI4LzIw
MjAgOTo1OCBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToNCj4gPiBBbSAyOC4xMC4yMCB1bSAx
NTo1NSBzY2hyaWViIEFsZXggU2llcnJhOg0KPiA+PiBCeSBlbmFibGluZyB0aGlzIHBhcmFtZXRl
ciwgdGhlIHN5c3RlbSB3aWxsIGJlIGZvcmNlZCB0byB1c2UgcGNpZQ0KPiA+PiBpbnRlcmZhY2Ug
b25seSBmb3IgcDJwIHRyYW5zYWN0aW9ucy4NCj4gPg0KPiA+IEJldHRlciBuYW1lIHRoYXQgYW1k
Z3B1X3hnbWkgd2l0aCBhIGRlZmF1bHQgdmFsdWUgb2YgZW5hYmxlZC4NCj4gPg0KPiA+IE9yIG1h
eWJlIGFkZCBhbm90aGVyIGJpdCB2YWx1ZSBmb3IgYW1kZ3B1X3ZtX2RlYnVnIGluc3RlYWQuDQo+
IA0KPiBBY2sNCj4gDQo+IFJlZ2FyZHMsDQo+IEFsZXggU2llcnJhDQo+IA0KPiA+DQo+ID4NCj4g
Pj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogQWxleCBTaWVycmEgPGFsZXguc2llcnJhQGFtZC5jb20+
DQo+ID4+IC0tLQ0KPiA+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaMKg
wqDCoMKgwqDCoMKgIHwgMSArDQo+ID4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kZXZpY2UuYyB8IDIgKy0NCj4gPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2Rydi5jwqDCoMKgIHwgOSArKysrKysrKysNCj4gPj4gwqAgMyBmaWxlcyBjaGFuZ2Vk
LCAxMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPiA+PiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+ID4+IGluZGV4IGJhNjVkNGYyYWI2Ny4uMzY0NWYw
MGU5ZjYxIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHUuaA0KPiA+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPiA+
PiBAQCAtMTg4LDYgKzE4OCw3IEBAIGV4dGVybiBpbnQgYW1kZ3B1X2Rpc2NvdmVyeTsNCj4gPj4g
wqAgZXh0ZXJuIGludCBhbWRncHVfbWVzOw0KPiA+PiDCoCBleHRlcm4gaW50IGFtZGdwdV9ub3Jl
dHJ5Ow0KPiA+PiDCoCBleHRlcm4gaW50IGFtZGdwdV9mb3JjZV9hc2ljX3R5cGU7DQo+ID4+ICtl
eHRlcm4gaW50IGFtZGdwdV9mb3JjZV9ub194Z21pOw0KPiA+PiDCoCAjaWZkZWYgQ09ORklHX0hT
QV9BTUQNCj4gPj4gwqAgZXh0ZXJuIGludCBzY2hlZF9wb2xpY3k7DQo+ID4+IMKgIGV4dGVybiBi
b29sIGRlYnVnX2V2aWN0aW9uczsNCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiA+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYw0KPiA+PiBpbmRleCAxZmU4NTBlMGE5NGQuLjBhNWQ5N2E4NDAx
NyAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYw0KPiA+PiBAQCAtMjI1Nyw3ICsyMjU3LDcgQEAgc3RhdGljIGludCBhbWRncHVfZGV2aWNl
X2lwX2luaXQoc3RydWN0DQo+ID4+IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4+IMKgwqDCoMKg
wqAgaWYgKHIpDQo+ID4+IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGluaXRfZmFpbGVkOw0KPiA+
PiDCoCAtwqDCoMKgIGlmIChhZGV2LT5nbWMueGdtaS5udW1fcGh5c2ljYWxfbm9kZXMgPiAxKQ0K
PiA+PiArwqDCoMKgIGlmICghYW1kZ3B1X2ZvcmNlX25vX3hnbWkgJiYgYWRldi0NCj4gPmdtYy54
Z21pLm51bV9waHlzaWNhbF9ub2RlcyA+DQo+ID4+ICsxKQ0KPiA+DQo+ID4gTWhtLCB0aGlzIHdp
bGwgbW9zdCBsaWtlbHkgY2F1c2UgcHJvYmxlbXMuIFlvdSBzdGlsbCBuZWVkIHRvIGFkZCB0aGUN
Cj4gPiBkZXZpY2UgdG8gdGhlIGhpdmUgYmVjYXVzZSBvdGhlcndpc2UgR1BVIHdvbid0IHdvcmsu
DQo+IA0KPiBXaGF0IGtpbmQgb2YgcHJvYmxlbXM/IFNvIGZhciwgSSBoYXZlIHZhbGlkYXRlZCB0
aGlzIHVzaW5nIGEgc3lzdGVtIHdpdGgNCj4gbXVsdGlwbGUgZGV2aWNlcyBhbmQgcnVubmluZyAu
L3JvY21fYmFuZHdpZHRoX3Rlc3QgLXQuIFdpdGggYW5kIHdpdGhvdXQNCj4gdGhlIHBhcmFtZXRl
ciBzZXQuDQo+IA0KPiBSZWdhcmRzLA0KPiBBbGV4IFNpZXJyYQ0KPiANCj4gPg0KPiA+IEFwYXJ0
IGZyb20gdGhhdCBzb3VuZHMgbGlrZSBhIGdvb2QgaWRlYSBpbiBnZW5lcmFsLg0KPiA+DQo+ID4g
Q2hyaXN0aWFuLg0KPiA+DQo+ID4+IMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfeGdtaV9hZGRf
ZGV2aWNlKGFkZXYpOw0KPiA+PiDCoMKgwqDCoMKgIGFtZGdwdV9hbWRrZmRfZGV2aWNlX2luaXQo
YWRldik7DQo+ID4+IMKgIGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZHJ2LmMNCj4gPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2
LmMNCj4gPj4gaW5kZXggNGI3OGVjZmQzNWY3Li4yMjQ4NTA2N2NmMzEgMTAwNjQ0DQo+ID4+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiA+PiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gPj4gQEAgLTE2MCw2ICsx
NjAsNyBAQCBpbnQgYW1kZ3B1X2ZvcmNlX2FzaWNfdHlwZSA9IC0xOw0KPiA+PiDCoCBpbnQgYW1k
Z3B1X3RteiA9IDA7DQo+ID4+IMKgIGludCBhbWRncHVfcmVzZXRfbWV0aG9kID0gLTE7IC8qIGF1
dG8gKi8NCj4gPj4gwqAgaW50IGFtZGdwdV9udW1fa2NxID0gLTE7DQo+ID4+ICtpbnQgYW1kZ3B1
X2ZvcmNlX25vX3hnbWkgPSAwOw0KPiA+PiDCoCDCoCBzdHJ1Y3QgYW1kZ3B1X21ncHVfaW5mbyBt
Z3B1X2luZm8gPSB7DQo+ID4+IMKgwqDCoMKgwqAgLm11dGV4ID0gX19NVVRFWF9JTklUSUFMSVpF
UihtZ3B1X2luZm8ubXV0ZXgpLA0KPiA+PiBAQCAtNTIyLDYgKzUyMywxNCBAQCBtb2R1bGVfcGFy
YW1fbmFtZWQocmFzX2VuYWJsZSwNCj4gPj4gYW1kZ3B1X3Jhc19lbmFibGUsIGludCwgMDQ0NCk7
DQo+ID4+IMKgIE1PRFVMRV9QQVJNX0RFU0MocmFzX21hc2ssICJNYXNrIG9mIFJBUyBmZWF0dXJl
cyB0byBlbmFibGUNCj4gKGRlZmF1bHQNCj4gPj4gMHhmZmZmZmZmZiksIG9ubHkgdmFsaWQgd2hl
biByYXNfZW5hYmxlID09IDEiKTsNCj4gPj4gwqAgbW9kdWxlX3BhcmFtX25hbWVkKHJhc19tYXNr
LCBhbWRncHVfcmFzX21hc2ssIHVpbnQsIDA0NDQpOw0KPiA+PiDCoCArLyoqDQo+ID4+ICsgKiBE
T0M6IGZvcmNlX25vX3hnbWkgKHVpbnQpDQo+ID4+ICsgKiBGb3JjZXMgbm90IHRvIHVzZSB4Z21p
IGludGVyZmFjZSAoMCA9IGRpc2FibGUsIDEgPSBlbmFibGUpLg0KPiA+PiArICogRGVmYXVsdCBp
cyAwIChkaXNhYmxlZCkuDQo+ID4+ICsgKi8NCj4gPj4gK01PRFVMRV9QQVJNX0RFU0MoZm9yY2Vf
bm9feGdtaSwgIkZvcmNlIG5vdCB0byB1c2UgeGdtaQ0KPiBpbnRlcmZhY2UiKTsNCj4gPj4gK21v
ZHVsZV9wYXJhbV9uYW1lZChmb3JjZV9ub194Z21pLCBhbWRncHVfZm9yY2Vfbm9feGdtaSwgaW50
LA0KPiAwNjAwKTsNCj4gPj4gKw0KPiA+PiDCoCAvKioNCj4gPj4gwqDCoCAqIERPQzogc2lfc3Vw
cG9ydCAoaW50KQ0KPiA+PiDCoMKgICogU2V0IFNJIHN1cHBvcnQgZHJpdmVyLiBUaGlzIHBhcmFt
ZXRlciB3b3JrcyBhZnRlciBzZXQgY29uZmlnDQo+ID4+IENPTkZJR19EUk1fQU1ER1BVX1NJLiBG
b3IgU0kgYXNpYywgd2hlbiByYWRlb24gZHJpdmVyIGlzIGVuYWJsZWQsDQo+ID4NCj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gYW1kLWdmeCBtYWls
aW5nIGxpc3QNCj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gaHR0cHM6Ly9uYW0x
MS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlz
dHMuDQo+IGZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC0NCj4gZ2Z4
JmFtcDtkYXRhPTA0JTdDMDElN0NhbGV4LnNpZXJyYSU0MGFtZC5jb20lN0M2YTJlMzQ0MjdmYjQ0
OTg2NQ0KPiA5MTIwOGQ4N2I2YzhjMDUlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgz
ZCU3QzAlN0MwJTdDNjMNCj4gNzM5NTA1MzQ1NzM0NzYzMyU3Q1Vua25vd24lN0NUV0ZwYkdac2Iz
ZDhleUpXSWpvaU1DNHdMakF3TUQNCj4gQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3
aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCZhbXA7c2RhdGE9DQo+IHMyaFhWQVZGdEhKc05OQndoenpL
RGpNbEVqRVM5dU5HYllpNkdkZUQ1Y2MlM0QmYW1wO3Jlc2VydmVkPTANCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
