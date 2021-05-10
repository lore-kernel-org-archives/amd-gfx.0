Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49002C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 12:43:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5FF861184
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 12:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5FF861184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B64589235;
	Mon, 10 May 2021 12:43:11 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2064.outbound.protection.outlook.com [40.107.101.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56F3A89235
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 12:43:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChnVA3Ag4mHa2eLE1QxyoSGWftelffxYuP8Ekh14kwt1kiUdfVvKKj3vGe8Wu5VsONrsm3ETWPvK756tmF5wBHWmsOf8JVpKxNIe2nIUL1x32TiiWeEQNTwAdPJ3LKHF0ElsQkv0VI95D7DmqMTPVh5QSP6R5T+OUj0A/5+61cBMPKVp+af7pAtPtJy5k5EqoQ6dAtrt9A20tPV3z3up3CQ8j9zReWVY4SwBaDjOsX1eN49rYKmqHrcwIJE1Qjr3Z67hkXLlLnifXq8hExwPfhfUqLONTWeYL8+TREB2dMqGONtAGogPBsaSSM12r1kHfoywIjl9ilbplpDUGoNNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AaMxoiXZfx2rLDjoKV8nrQdHSCzR4LrORH1Jfh/itI=;
 b=kCvATpeyZrA9tw52XjCihrEWxT5Qk3mWpkJyp0QF8aAzKz3nS7224by74ddHnqo+s1MWApki16S33Qq6x5/ihE65BGv+p+jOF7YjoEJr5K20fD7LzchWfoeckIPBOo1sY6BAWeAK5S+QYKg+bp68md9fpMaRs7BsdHoC6oUqnBp+OmhK+J7EQ0OHrmRmZ2bdKlzn8NVqvf8HXwN8nsbmYS5qL3BMe31BH5u7f6uN2a4gxU5OII6BAeIuxPDGKF6Bdp+SE9ncvDWUDGtt3nWuoqgGq6piFhNkDvWGVQzdHkKFSyYq7mCFXZCiV4PzcFwVFJE0GQSlxgptNxMUUDKy3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AaMxoiXZfx2rLDjoKV8nrQdHSCzR4LrORH1Jfh/itI=;
 b=tIW9Gpvp+4ckLS9sQCuch70+9u9D0dXgY2D6TIaZLtgvF/fhdPQyuzup+zKB7vACnUtTK5cbwxydVdYz8gKTwjWawXqqmq9e90ek+ZyjO3AoVLoA27aGfsxfVwZC1+kbdHBcLBQHby6NAPohB0Kr8Z19IMzhn9um+HUPi9HSH5w=
Received: from DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) by
 DM4PR12MB5375.namprd12.prod.outlook.com (2603:10b6:5:39a::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.27; Mon, 10 May 2021 12:43:09 +0000
Received: from DM4PR12MB5133.namprd12.prod.outlook.com
 ([fe80::cdbd:bd79:d9b2:ed90]) by DM4PR12MB5133.namprd12.prod.outlook.com
 ([fe80::cdbd:bd79:d9b2:ed90%7]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 12:43:09 +0000
From: "Shih, Jude" <Jude.Shih@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu/display: fix build when
 CONFIG_DRM_AMD_DC_DCN is not defined
Thread-Topic: [PATCH 3/3] drm/amdgpu/display: fix build when
 CONFIG_DRM_AMD_DC_DCN is not defined
Thread-Index: AQHXQ4C7kRlUxq54DUSDFpNV705i9qrcrMmQ
Date: Mon, 10 May 2021 12:43:09 +0000
Message-ID: <DM4PR12MB513393D543F0492048827A62F7549@DM4PR12MB5133.namprd12.prod.outlook.com>
References: <20210507203642.552770-1-alexander.deucher@amd.com>
 <20210507203642.552770-3-alexander.deucher@amd.com>
In-Reply-To: <20210507203642.552770-3-alexander.deucher@amd.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-10T12:43:00Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=7ab6cb4c-1670-4208-91fb-e8bb5b631e3b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [219.85.181.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef1b3285-2f99-4f09-0800-08d913b12a72
x-ms-traffictypediagnostic: DM4PR12MB5375:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB53756489AA27DEB3348538E2F7549@DM4PR12MB5375.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:519;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TrQZjpUrWXaFKcraHWXXgK8XIqUyZz4dlBQbqcAJApl7BbdeSiYQpCWJTq4UaSsVxMymfq3rTTnqD4X8lz0xDxgPOINZho+WKbwI2KDB7cO+AAqOEj9FnGhe7PHEaVW7b0/dOeB3rISpaXAGVgY80fVeUX/0awFqeSyA/74cyxtwZXg7+TAkEhlZXFdhRmscYcDV7Y84kFcIzWdUCfiuuGQDPLLwkWvIRfhL1SLuekSz9X4LtLiq14vUN9oTfeIaaZjb+HbVSJO4xrcw1qKVIHl+kj7QGPhen3JtlPikTweh047wPpZJiOGQl6bZFocavXEkQlczP5kq/099ptPjeK3vbGoJVSlbjgJ9vhwnzuRBnHzop1io/qF5AT/1A6d94DdSP23NBPaB3jVvxEnm3b8vYIHmeCWCbTyH1xlTACRoBQI8dpDCvldyD8wdcVaMpYUl68j9KntGpW9LyArBRLqGR335pLMcoNAJO7ejSo/qzzDKrq8m/QdXGjcddpgNei6XuhVsYTj5CrtMmao6F+V5OY72dZWvn4OwDX6HCAjUpo6Oa5SdiGhXn1KfmCiFDZJOppRLBATQyDvXl6HjXW7G3RnDBPyZ3uWTDfyJ4YM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39850400004)(26005)(316002)(2906002)(66446008)(66476007)(66556008)(66946007)(76116006)(186003)(122000001)(38100700002)(64756008)(83380400001)(6506007)(71200400001)(8676002)(53546011)(110136005)(7696005)(86362001)(33656002)(52536014)(478600001)(8936002)(55016002)(9686003)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?aXZ2NjhGYS9Kd0hIQmdLNSt1UEZhVVB3aHhZeDhFTGtiZWlFbEJyWGhOeEtR?=
 =?utf-8?B?d3R1S25LTkc4LzQrVFJVOTNPZjA3c3NoNU5tQU1HWDM3cHo3WUx0eWFwVndG?=
 =?utf-8?B?VlFSZHZTeU5qZjVPWTk1QUpWY3dmb0R1SDdSUlVuZGZGeDBSUWZwc2JSdURW?=
 =?utf-8?B?SUxWcFZoUjh2Q0ZiQU9adUFnaXFTd2pWUXpsZi9ENDdjNE03VGdVOFNsSDV0?=
 =?utf-8?B?c295T3BIVkxXRHdUQ01DdVJkakpiZzdnekMvbGVDVW9UYjNlRzZJTzFiRkpk?=
 =?utf-8?B?eithbU1hWmFRcWlnZmlWcUxZcmhJc1Btek5FU1hxM00vWlEwdWNGTFlQTjg4?=
 =?utf-8?B?WUpYQ0l5UXA4NUgvT1Z0YWdRTzRJN1JXVU1saTczVWxXYWwwSHVIWVZ0enpy?=
 =?utf-8?B?YkZQZzZySHF2MjhoWU0wZitKUzF2S1JiSWljVE94RnpsZWVFcjVzRllmdi90?=
 =?utf-8?B?ZHVYYTJKTGNGV2h0c3pISkV4R25yK08zb3JQQVNsQmxkOVF5d3g4VEppN2E1?=
 =?utf-8?B?L1k2Y3FyblJoSVdqRFVKT1BPS05KR3VGY0NZMlVwdzFWNGtEZ05YbHJxOW1u?=
 =?utf-8?B?Q2JaTEFLMUVFdXJyVC8vY0Q1R0ZoUFhNZWJ2WFlUMzBzUW1pQ1BjRW9RcFgr?=
 =?utf-8?B?cHQ1NTZiWXZVbTJwL1RVK2tjQTEzdzdwNWFhblY3K2Z2cUozUGFWd2NsWFdO?=
 =?utf-8?B?eEcyZVNyN09hWm9NRXFNM0lsRTliVHN6QXNnSStDM0JiUzY2dmZ4dXBzeVVC?=
 =?utf-8?B?NWIyTGdFRDV4WFpoa0lGRGM5T0RjbmxsZUNqWW5zOVBFMEJSdUN3OFREUHA1?=
 =?utf-8?B?NmRFVGdWeno1enJXa1pYdzZSOWU5M2YzclZkUGF1VFBpWUFQS1hFeTJjMnBv?=
 =?utf-8?B?MmEwM2FGSlRhS2N3V3JXbW9oTVVlSWRHT09GMldhL3VKSkZ3VnBXdUVvajA1?=
 =?utf-8?B?OURQRkszc1p0QmRMam11dGlaS1UwZEcrdEx5UStkQXpVdWFtdEFqU1loaG50?=
 =?utf-8?B?RWhYTTVRL3dhc2JEY0tFZENKMnJpY2xOakdvMXcvcXFHMUE0cE5DeDE4Z1Rp?=
 =?utf-8?B?OVNoUUY0di9taCtYbElScVB1b0xTVlVIOUVvd1BLZkoxSWtpYTVYWDdVTlUx?=
 =?utf-8?B?NjRCVCttL1RUN0ZDZWh1d2xDVnU3aHU2K0ZSejlGVFBpSkdLcWVlT0d0VnR2?=
 =?utf-8?B?S3dVVkVnb25OOU5jMkNoVTM0VGc2Rm1UUkcwZmhqc0RnRTlIc2lGOHBWaHZL?=
 =?utf-8?B?SUxnV1JqQXVEQ1oyS05xREdLYXJsQ1hIQTZ1UHczQmFUU2hFNnJCNlZMaGlu?=
 =?utf-8?B?OEMvZVhjLzBpWmpmbG9XUjB0SWRmR0JmU3N6SHZidkVJTmNYMFZnQlJIN1Js?=
 =?utf-8?B?dlpLS2ZldEZlSnN3bmhoUXNGWGh1c3I0c01LUmJFb3JZUlN3QyttL3pXVXJ2?=
 =?utf-8?B?ZHRkYWxxbk5wVWsyNTdRSmN1YVFTWlkvN0E3RHFZWlNhM01BNGNPUmlmSXNi?=
 =?utf-8?B?N2RMNWQ2N0RWK3ZyVTlOWmpZamZ3eWhDelZiTFpzeVFDUjlrY2E0Tkg3eFlD?=
 =?utf-8?B?KzdJSVZSZVZsYXJiOGlMR2t2TXpmcUltMzFzclNZd0JoUjVCb25aeXhmZ2xn?=
 =?utf-8?B?ZWo0VDB1S2lwemoxNGlaNjRDT05ZTHI2R3NwNWhGa09MUzFLWDkwcFZoZjdK?=
 =?utf-8?B?Z3pheTB6bEZkekJaNURMajJ4Tm90a1VaekRUTEpJTFlSYUZSdUl3a0taT2tk?=
 =?utf-8?Q?vyXYRhzUOs1+6SGociwb7F0MW3NzRG/77hs+F7s?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1b3285-2f99-4f09-0800-08d913b12a72
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 12:43:09.1124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mi11YDxeFDovZLaF2icshmGp7v3bA+/byKOuTSIEIfQFoRs/H5EKWqz2ZR51sgSwZx02IEIveBYZ1HwlAa68Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5375
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpS
ZXZpZXdlZC1ieTogSnVkZSBTaGloIDxzaGVuc2hpaEBhbWQuY29tPg0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPiANClNlbnQ6IFNhdHVyZGF5LCBNYXkgOCwgMjAyMSA0OjM3IEFNDQpUbzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+OyBTaGloLCBKdWRlIDxKdWRlLlNoaWhAYW1kLmNvbT4NClN1
YmplY3Q6IFtQQVRDSCAzLzNdIGRybS9hbWRncHUvZGlzcGxheTogZml4IGJ1aWxkIHdoZW4gQ09O
RklHX0RSTV9BTURfRENfRENOIGlzIG5vdCBkZWZpbmVkDQoNCkZpeGVzOg0KZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmM6IEluIGZ1bmN0
aW9uIOKAmGFtZGdwdV9kbV9pbml0aWFsaXplX2RybV9kZXZpY2XigJk6DQpkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYzozNzI2Ojc6IGVy
cm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhyZWdpc3Rlcl9vdXRib3hf
aXJxX2hhbmRsZXJz4oCZOyBkaWQgeW91IG1lYW4g4oCYcmVnaXN0ZXJfaHBkX2hhbmRsZXJz4oCZ
PyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0NCiAzNzI2IHwgICBpZiAo
cmVnaXN0ZXJfb3V0Ym94X2lycV9oYW5kbGVycyhkbS0+YWRldikpIHsNCiAgICAgIHwgICAgICAg
Xn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KICAgICAgfCAgICAgICByZWdpc3Rlcl9ocGRf
aGFuZGxlcnMNCg0KRml4ZXM6IDc3YTQ5YzQ1ODkzMSAoImRybS9hbWQvZGlzcGxheTogU3VwcG9y
dCBmb3IgRE1VQiBBVVgiKQ0KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPg0KQ2M6IEp1ZGUgU2hpc2ggPEp1ZGUuU2hpaEBhbWQuY29tPg0KLS0t
DQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDIg
KysNCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYw0KaW5kZXggNzdiZGU1NGM5
NTE1Li44ZWU5YzAzYmYyNmMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jDQpAQCAtMzcxOCw2ICszNzE4LDcgQEAgc3RhdGljIGlu
dCBhbWRncHVfZG1faW5pdGlhbGl6ZV9kcm1fZGV2aWNlKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQ0KIAkJCWdvdG8gZmFpbDsNCiAJCX0NCiANCisjaWYgZGVmaW5lZChDT05GSUdfRFJNX0FN
RF9EQ19EQ04pDQogCS8qIFVzZSBPdXRib3ggaW50ZXJydXB0ICovDQogCXN3aXRjaCAoYWRldi0+
YXNpY190eXBlKSB7DQogCWNhc2UgQ0hJUF9TSUVOTkFfQ0lDSExJRDoNCkBAIC0zNzMxLDYgKzM3
MzIsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9kbV9pbml0aWFsaXplX2RybV9kZXZpY2Uoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQogCWRlZmF1bHQ6DQogCQlEUk1fREVCVUdfS01TKCJVbnN1
cHBvcnRlZCBBU0lDIHR5cGUgZm9yIG91dGJveDogMHglWFxuIiwgYWRldi0+YXNpY190eXBlKTsN
CiAJfQ0KKyNlbmRpZg0KIA0KIAkvKiBsb29wcyBvdmVyIGFsbCBjb25uZWN0b3JzIG9uIHRoZSBi
b2FyZCAqLw0KIAlmb3IgKGkgPSAwOyBpIDwgbGlua19jbnQ7IGkrKykgew0KLS0gDQoyLjMwLjIN
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
