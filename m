Return-Path: <SRS0=z8aj=BF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C87C433DF
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Jul 2020 11:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BFBB206D8
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Jul 2020 11:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tV5ASAh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BFBB206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12BEF89EB8;
	Sun, 26 Jul 2020 11:45:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F80089EB8
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Jul 2020 11:45:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3fDByMnqASRVS1nUPKRxejTgh7LaOQ5YhxUrktpt9man7/S6sEEJFUgk9NZgBo3eTm+eik6QI7F0FRxx2UWSsu0gHw5qE/NaILwpfcr2Qe9mNqka8Q+VQwxdU3BBGCQrZoS/W3nsvK3XN43zGM0ICvPvk513+M+4EbkvZK1TwsMP17wtwupxmnLRzq/NuhHThBiYf3OxLp4w8Y09WZbAmRUiHGLT01dkFmI/YqKkIlbYVNisukQWu4jF61gbCpGdK/nKKeQRYAkEWGmANxYENvIzH6UhU6CztOqJy/Ow6lhOBM93+StLjIpIwg3CuteQXnW/NJ34cVBTDH32kTyog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAZDTjwCGvlo15vLWkoKthG2cLET0z9N3SYltrYWLy4=;
 b=YyKA4L30xiu7uELgpldGpnX64cQ4yFkiw+n6Mf8RFus2rb8b+eV6WoDcWrsVKl2wlnhY45pnfC/ixxB1f6LPy7syXOUVlF1l12KkKpnJeifvUDzeOrW7xmO3sm8XtLE3fInTAbv/Af2sAi08Uu7olsS50iPcP+ZWmfItbC3qgtRwZR6UrCkPFWuP39VTqPoJdEnM4hKXd2whoBfEtXWrVXhF32MFbuVNCy+xAvuuXt5F6pkSpOtTNj3jDHwJj7orDOUvylEvy7ST0PzavjtBiMgMCBqT4BEo2fWkZTy1GYn5mdJ/Yix30Qt2V/SuDIVp4jfCn55lrgljWBDKBGJL8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAZDTjwCGvlo15vLWkoKthG2cLET0z9N3SYltrYWLy4=;
 b=tV5ASAh4w7iImnSCCgNA6/JLjcQ1yv8hPZ+aubMd2wImJVpFA5QoY3HV0F8T4v59NfDnk16RY6dsfKwLwy5ftFkRd0Xd909bhXmJ1Sf19A3lR+CufwKTGtWJw1sD6DLdxicfIj+TEZVk2SGOfOVn+ldqVAiIsmGhTOL9ygmXtVY=
Received: from MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 by BL0PR12MB2340.namprd12.prod.outlook.com (2603:10b6:207:4d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Sun, 26 Jul
 2020 11:45:33 +0000
Received: from MN2PR12MB4175.namprd12.prod.outlook.com
 ([fe80::ad86:4e5e:66b8:3045]) by MN2PR12MB4175.namprd12.prod.outlook.com
 ([fe80::ad86:4e5e:66b8:3045%9]) with mapi id 15.20.3216.028; Sun, 26 Jul 2020
 11:45:33 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/powerplay: update driver if file for
 sienna_cichlid
Thread-Topic: [PATCH] drm/amd/powerplay: update driver if file for
 sienna_cichlid
Thread-Index: AQHWYZ5dPyx82Z/doES+mtxqNLpd5akaR2gA
Date: Sun, 26 Jul 2020 11:45:33 +0000
Message-ID: <558F78FB-76EC-4668-9366-860F5560D01F@amd.com>
References: <20200724093921.409691-1-likun.gao@amd.com>
In-Reply-To: <20200724093921.409691-1-likun.gao@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=3be290b3-4094-4273-b240-0000548dd781;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-26T11:44:56Z; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7c37bcb9-a9c5-4de9-7407-08d8315967d1
x-ms-traffictypediagnostic: BL0PR12MB2340:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB23408A750AE0D12E56FE0FD58E750@BL0PR12MB2340.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vAGXjL+kp+Nqp+Wzpwd7QI2VgVx249G15mF1OPWCkon0nt95JYtjxjc/RrkIwwb+iS66HzkYN7cmcNRatmI2HbEgJ/180wvyqF0e7VMjBtSOqt3YDXIWUTgflYglNyuBpt2d7hpgaZFflfg4Ht6SYhowEhjCD01XAZYsiX4Bw1haYa9F+8zKy80kZqSA+D7wePTZDXBluy+2Arw9cVNJfI/qrBt1DzbaOTeio3Aj8Xt6WSzsdB8p6+UZViACYCIBHbSRR3kDAclo2WbV36/lRMtK+KD3Vv7Rad92j4d8EPUnmmFfY0N6px9QDsuoCGy6N+cjHagyhNKAV2uwIbkUyw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4175.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(66556008)(66946007)(66446008)(66476007)(64756008)(5660300002)(6512007)(8676002)(86362001)(6506007)(19627235002)(91956017)(110136005)(478600001)(316002)(54906003)(76116006)(186003)(6486002)(4326008)(71200400001)(36756003)(15650500001)(8936002)(2616005)(26005)(83380400001)(2906002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 9FkRA6yCxxnwDmrpP9iL4xoyuRpdMt4vTajHCpq3nWZTVruQ30y+UVnrYaVHCeDTzF5FBG3KTo1JuOngvkj/hDJu5jT2O3JKbFXlId3q41yea99s0BUgJIzgVS0K0SuaQ3LvveDDSD+/vGn/zPtMnwtwZXv6AObxQ4cudCpuDJa/vVz8+VCUDtlZk45A8WwWv60mnR7OzOSwgIE+/Ud+QbwlzZzD3ggL6HX1iOfupz5H/1oKDLkrjVDRRcJ0/PXJNuwN6SKZepkCeF+hQVf1rVKyZNyGaJiWJsMCtnCUEsfp38830RGaBSqLxE2/QECdoR9GdijTKzjTR1auQL5EScSIxgED/ufEeJyjlEoMNXgdbX7azIbUJC65PuPROoaKNYqfYjjxb2Skx6wOf0Tn6/pceFB3qbHb15DsdSQ3Lgg1m7BdTWnyv6ZdLFISsrt5BK4/a/UFKv2U26pVXHIByst1N6zxVB330OJs7BgUemowtoei+gQgi0ys3UbHRNrq
Content-ID: <3E2CD11755EE99489A4C232F8BE98BC2@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4175.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c37bcb9-a9c5-4de9-7407-08d8315967d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2020 11:45:33.4285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dYXNRSNdGDVCX6w5v0F24J5a80nnoi81xKDKeQ6KVG7iHlT1l/7e1ZXLKWC6HlA2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2340
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
Cc: "Chen, Jiansong \(Simon\)" <Jiansong.Chen@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpS
ZXZpZXdlZC1ieTogS2VubmV0aCBGZW5nIDxrZW5uZXRoLmZlbmdAYW1kLmNvbT4NCg0KDQrvu7/l
nKggMjAyMC83LzI0IOS4i+WNiDU6MznvvIzigJxHYW8sIExpa3Vu4oCdPExpa3VuLkdhb0BhbWQu
Y29tPiDlhpnlhaU6DQoNCiAgICBGcm9tOiBMaWt1biBHYW8gPExpa3VuLkdhb0BhbWQuY29tPg0K
DQogICAgVXBkYXRlIHNpZW5uYV9jaWNobGlkIGRyaXZlciBpZiBoZWFkZXIgYW5kIHJlbGF0ZWQg
ZmlsZXMuDQogICAgU3VwcG9ydCBuZXcgc211IG1ldHJpY3MgZm9yIHByZSAmIHBvc3REUyBmcmVx
dWVuY3kuDQoNCiAgICBTaWduZWQtb2ZmLWJ5OiBMaWt1biBHYW8gPExpa3VuLkdhb0BhbWQuY29t
Pg0KICAgIENoYW5nZS1JZDogSTU0NDYyNTZmZDcwODJhMWQ1MWRmNGFkZTM4MjhiZjVmYTFlYTNl
N2YNCiAgICAtLS0NCiAgICAgLi4uL2luYy9zbXUxMV9kcml2ZXJfaWZfc2llbm5hX2NpY2hsaWQu
aCAgICAgIHwgMjEgKysrKysrKysrKysrKy0tLS0tLQ0KICAgICBkcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9pbmMvc211X3YxMV8wLmggfCAgMiArLQ0KICAgICAuLi4vZHJtL2FtZC9wb3dl
cnBsYXkvc2llbm5hX2NpY2hsaWRfcHB0LmMgICAgfCAxMSArKysrKysrLS0tDQogICAgIDMgZmls
ZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQoNCiAgICBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL3NtdTExX2RyaXZlcl9p
Zl9zaWVubmFfY2ljaGxpZC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL3Nt
dTExX2RyaXZlcl9pZl9zaWVubmFfY2ljaGxpZC5oDQogICAgaW5kZXggYjIyMzJlMjRkODJmLi5h
YTI3MDhmY2NiNmQgMTAwNjQ0DQogICAgLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBs
YXkvaW5jL3NtdTExX2RyaXZlcl9pZl9zaWVubmFfY2ljaGxpZC5oDQogICAgKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL3NtdTExX2RyaXZlcl9pZl9zaWVubmFfY2ljaGxp
ZC5oDQogICAgQEAgLTI3LDcgKzI3LDcgQEANCiAgICAgLy8gKioqIElNUE9SVEFOVCAqKioNCiAg
ICAgLy8gU01VIFRFQU06IEFsd2F5cyBpbmNyZW1lbnQgdGhlIGludGVyZmFjZSB2ZXJzaW9uIGlm
DQogICAgIC8vIGFueSBzdHJ1Y3R1cmUgaXMgY2hhbmdlZCBpbiB0aGlzIGZpbGUNCiAgICAtI2Rl
ZmluZSBTTVUxMV9EUklWRVJfSUZfVkVSU0lPTiAweDMzDQogICAgKyNkZWZpbmUgU01VMTFfRFJJ
VkVSX0lGX1ZFUlNJT04gMHgzNA0KDQogICAgICNkZWZpbmUgUFBUQUJMRV9TaWVubmFfQ2ljaGxp
ZF9TTVVfVkVSU0lPTiA1DQoNCiAgICBAQCAtOTY4LDkgKzk2OCwxNSBAQCB0eXBlZGVmIHN0cnVj
dCB7DQoNCiAgICAgdHlwZWRlZiBzdHJ1Y3Qgew0KICAgICAgIHVpbnQzMl90IEN1cnJDbG9ja1tQ
UENMS19DT1VOVF07DQogICAgLSAgdWludDE2X3QgQXZlcmFnZUdmeGNsa0ZyZXF1ZW5jeTsNCiAg
ICAtICB1aW50MTZfdCBBdmVyYWdlRmNsa0ZyZXF1ZW5jeTsNCiAgICAtICB1aW50MTZfdCBBdmVy
YWdlVWNsa0ZyZXF1ZW5jeSAgOw0KICAgICsNCiAgICArICB1aW50MTZfdCBBdmVyYWdlR2Z4Y2xr
RnJlcXVlbmN5UHJlRHM7DQogICAgKyAgdWludDE2X3QgQXZlcmFnZUdmeGNsa0ZyZXF1ZW5jeVBv
c3REczsNCiAgICArICB1aW50MTZfdCBBdmVyYWdlRmNsa0ZyZXF1ZW5jeVByZURzOw0KICAgICsg
IHVpbnQxNl90IEF2ZXJhZ2VGY2xrRnJlcXVlbmN5UG9zdERzOw0KICAgICsgIHVpbnQxNl90IEF2
ZXJhZ2VVY2xrRnJlcXVlbmN5UHJlRHMgIDsNCiAgICArICB1aW50MTZfdCBBdmVyYWdlVWNsa0Zy
ZXF1ZW5jeVBvc3REcyAgOw0KICAgICsNCiAgICArDQogICAgICAgdWludDE2X3QgQXZlcmFnZUdm
eEFjdGl2aXR5ICAgIDsNCiAgICAgICB1aW50MTZfdCBBdmVyYWdlVWNsa0FjdGl2aXR5ICAgOw0K
ICAgICAgIHVpbnQ4X3QgIEN1cnJTb2NWb2x0YWdlT2Zmc2V0ICA7DQogICAgQEAgLTk4OCw2ICs5
OTQsNyBAQCB0eXBlZGVmIHN0cnVjdCB7DQogICAgICAgdWludDE2X3QgVGVtcGVyYXR1cmVMaXF1
aWQwICAgIDsNCiAgICAgICB1aW50MTZfdCBUZW1wZXJhdHVyZUxpcXVpZDEgICAgOw0KICAgICAg
IHVpbnQxNl90IFRlbXBlcmF0dXJlUGx4ICAgICAgICA7DQogICAgKyAgdWludDE2X3QgUGFkZGlu
ZzE2ICAgICAgICAgICAgIDsNCiAgICAgICB1aW50MzJfdCBUaHJvdHRsZXJTdGF0dXMgICAgICAg
Ow0KDQogICAgICAgdWludDhfdCAgTGlua0RwbUxldmVsOw0KICAgIEBAIC0xMDA2LDggKzEwMTMs
MTAgQEAgdHlwZWRlZiBzdHJ1Y3Qgew0KICAgICAgIHVpbnQxNl90IEF2ZXJhZ2VEY2xrMEZyZXF1
ZW5jeSAgOw0KICAgICAgIHVpbnQxNl90IEF2ZXJhZ2VWY2xrMUZyZXF1ZW5jeSAgOw0KICAgICAg
IHVpbnQxNl90IEF2ZXJhZ2VEY2xrMUZyZXF1ZW5jeSAgOw0KICAgIC0gIHVpbnQxNl90IFZjbkFj
dGl2aXR5UGVyY2VudGFnZSA7IC8vcGxhY2UgaG9sZGVyLCBEYXZpZCBOLiB0byBwcm92aWRlIGZ1
bGwgc2VxdWVuY2UNCiAgICAtICB1aW50MTZfdCBwYWRkaW5nMTZfMjsNCiAgICArICB1aW50MTZf
dCBWY25BY3Rpdml0eVBlcmNlbnRhZ2UgIDsgLy9wbGFjZSBob2xkZXIsIERhdmlkIE4uIHRvIHBy
b3ZpZGUgZnVsbCBzZXF1ZW5jZQ0KICAgICsgIHVpbnQ4X3QgIFBjaWVSYXRlICAgICAgICAgICAg
ICAgOw0KICAgICsgIHVpbnQ4X3QgIFBjaWVXaWR0aCAgICAgICAgICAgICAgOw0KICAgICsNCiAg
ICAgfSBTbXVNZXRyaWNzX3Q7DQoNCiAgICAgdHlwZWRlZiBzdHJ1Y3Qgew0KICAgIGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvc211X3YxMV8wLmggYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvc211X3YxMV8wLmgNCiAgICBpbmRleCA0Mjlm
NWFhODkyNGEuLjk1MDRmOTk1NGZkMyAxMDA2NDQNCiAgICAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9pbmMvc211X3YxMV8wLmgNCiAgICArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9pbmMvc211X3YxMV8wLmgNCiAgICBAQCAtMzAsNyArMzAsNyBAQA0KICAg
ICAjZGVmaW5lIFNNVTExX0RSSVZFUl9JRl9WRVJTSU9OX05WMTAgMHgzNg0KICAgICAjZGVmaW5l
IFNNVTExX0RSSVZFUl9JRl9WRVJTSU9OX05WMTIgMHgzMw0KICAgICAjZGVmaW5lIFNNVTExX0RS
SVZFUl9JRl9WRVJTSU9OX05WMTQgMHgzNg0KICAgIC0jZGVmaW5lIFNNVTExX0RSSVZFUl9JRl9W
RVJTSU9OX1NpZW5uYV9DaWNobGlkIDB4MzMNCiAgICArI2RlZmluZSBTTVUxMV9EUklWRVJfSUZf
VkVSU0lPTl9TaWVubmFfQ2ljaGxpZCAweDM0DQogICAgICNkZWZpbmUgU01VMTFfRFJJVkVSX0lG
X1ZFUlNJT05fTmF2eV9GbG91bmRlciAweDINCg0KICAgICAvKiBNUCBBcGVydHVyZXMgKi8NCiAg
ICBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc2llbm5hX2NpY2hs
aWRfcHB0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zaWVubmFfY2ljaGxpZF9w
cHQuYw0KICAgIGluZGV4IGRjYzVkMjVhNzg5NC4uZjY0YTFiZTk0Y2I4IDEwMDY0NA0KICAgIC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NpZW5uYV9jaWNobGlkX3BwdC5jDQog
ICAgKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc2llbm5hX2NpY2hsaWRfcHB0
LmMNCiAgICBAQCAtNzAsNiArNzAsOCBAQA0KICAgICBGRUFUVVJFX01BU0soRkVBVFVSRV9EUE1f
RkNMS19CSVQpIHwgXA0KICAgICBGRUFUVVJFX01BU0soRkVBVFVSRV9EUE1fRENFRkNMS19CSVQp
KQ0KDQogICAgKyNkZWZpbmUgU01VXzExXzBfN19HRlhfQlVTWV9USFJFU0hPTEQgMTUNCiAgICAr
DQogICAgIHN0YXRpYyBzdHJ1Y3QgY21uMmFzaWNfbXNnX21hcHBpbmcgc2llbm5hX2NpY2hsaWRf
bWVzc2FnZV9tYXBbU01VX01TR19NQVhfQ09VTlRdID0gew0KICAgICBNU0dfTUFQKFRlc3RNZXNz
YWdlLFBQU01DX01TR19UZXN0TWVzc2FnZSwgICAgICAgICAgICAgICAgIDEpLA0KICAgICBNU0df
TUFQKEdldFNtdVZlcnNpb24sUFBTTUNfTVNHX0dldFNtdVZlcnNpb24sICAgICAgICAgICAgICAg
MSksDQogICAgQEAgLTQ0MywxMyArNDQ1LDE2IEBAIHN0YXRpYyBpbnQgc2llbm5hX2NpY2hsaWRf
Z2V0X3NtdV9tZXRyaWNzX2RhdGEoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsDQogICAgICp2YWx1
ZSA9IG1ldHJpY3MtPkN1cnJDbG9ja1tQUENMS19EQ0VGQ0xLXTsNCiAgICAgYnJlYWs7DQogICAg
IGNhc2UgTUVUUklDU19BVkVSQUdFX0dGWENMSzoNCiAgICAtKnZhbHVlID0gbWV0cmljcy0+QXZl
cmFnZUdmeGNsa0ZyZXF1ZW5jeTsNCiAgICAraWYgKG1ldHJpY3MtPkF2ZXJhZ2VHZnhBY3Rpdml0
eSA8PSBTTVVfMTFfMF83X0dGWF9CVVNZX1RIUkVTSE9MRCkNCiAgICArKnZhbHVlID0gbWV0cmlj
cy0+QXZlcmFnZUdmeGNsa0ZyZXF1ZW5jeVBvc3REczsNCiAgICArZWxzZQ0KICAgICsqdmFsdWUg
PSBtZXRyaWNzLT5BdmVyYWdlR2Z4Y2xrRnJlcXVlbmN5UHJlRHM7DQogICAgIGJyZWFrOw0KICAg
ICBjYXNlIE1FVFJJQ1NfQVZFUkFHRV9GQ0xLOg0KICAgIC0qdmFsdWUgPSBtZXRyaWNzLT5BdmVy
YWdlRmNsa0ZyZXF1ZW5jeTsNCiAgICArKnZhbHVlID0gbWV0cmljcy0+QXZlcmFnZUZjbGtGcmVx
dWVuY3lQb3N0RHM7DQogICAgIGJyZWFrOw0KICAgICBjYXNlIE1FVFJJQ1NfQVZFUkFHRV9VQ0xL
Og0KICAgIC0qdmFsdWUgPSBtZXRyaWNzLT5BdmVyYWdlVWNsa0ZyZXF1ZW5jeTsNCiAgICArKnZh
bHVlID0gbWV0cmljcy0+QXZlcmFnZVVjbGtGcmVxdWVuY3lQb3N0RHM7DQogICAgIGJyZWFrOw0K
ICAgICBjYXNlIE1FVFJJQ1NfQVZFUkFHRV9HRlhBQ1RJVklUWToNCiAgICAgKnZhbHVlID0gbWV0
cmljcy0+QXZlcmFnZUdmeEFjdGl2aXR5Ow0KICAgIC0tDQogICAgMi4yNS4xDQoNCg0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
