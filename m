Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36CAC17440
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 20:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE70321872
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 20:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE70321872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E4246E500;
	Tue, 12 Nov 2019 20:14:34 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800044.outbound.protection.outlook.com [40.107.80.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 174EF6E500
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 20:14:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofPMMUVrtZ7vIeU8CWajyIdGuEQq+E9q/NKv9/IMFfHwPFrH0mwZ2UpUjYQtzRptMJu7At5zVz3XsLsW6uhkbMdtWAmUW/8CAoCG9fJebZ9nXuPy3UAdk8Nf/QR2XZfEVIb9hI1sDbYLNju6zP0tR3uRk6JK+Ri6EgmwdQFPM/V57N5iayndPKIwwJ4xbtETgqj7yRzvBjl3OdVZwzzKDbOKOM9ntehmU3txw0j3zvhCIR/PJMMfxLFm8g9eZjz5x2uHTPCGgHurjAPwMC15JKHnjIqNpNmOfu/WH4vBJEEp7afMWTaEMpy4ahQo5y0+24UmHVyOOuowd6YQx4PITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOD1sM4DrRSc/BIgxLd4MVKRXxYjlBGKjvIryTKQ2po=;
 b=Ut/4aLcc8Zctw8BZZEot3cfNQGTT8fGwTJJE+efm+W0QIDBfbwgpH2gxJ5HjG2oGc7v0hZ/x5E06Vk1tueXwFRWC6vEhVMKA2Vi5/u5NZ4acuI4OyTw5nenssw9jPA6pnuU1wK0eMjuTQPCtCvu/49PgQ8YMXULxQm2PF5VGbZyeOBDPhh75RlacNttuPfOJqRnWvW0bCsPbf1qm0nmIgUOIvwaQGzCPBeGfPYyOBhA72e0R3RyM1WwR0Z6SzRhifJLElnF7bF2j2T6sMMFKEG6HUXi57g3s41/prjcNDHQpPyqiXnWO3l5nu5gjoYv6ojpFwa9SfMOHslgTbcj1yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB0054.namprd12.prod.outlook.com (10.172.77.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 20:14:31 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::449d:52a8:2761:9195]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::449d:52a8:2761:9195%5]) with mapi id 15.20.2451.023; Tue, 12 Nov 2019
 20:14:30 +0000
Subject: Re: [PATCH 1/2] drm/amd/display: Return correct error value
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
 mikita.lipski@amd.com, amd-gfx@lists.freedesktop.org, harry.wentland@amd.com
References: <20191112151628.8267-1-mikita.lipski@amd.com>
 <f2eed143-4767-81b2-2de9-e89631c7bd5a@amd.com>
From: Harry Wentland <hwentlan@amd.com>
Autocrypt: addr=hwentlan@amd.com; keydata=
 mQENBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAG0J0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPokBNwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2uQENBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAGJAR8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <32a164bd-9472-c990-eb67-36141a4f6b0f@amd.com>
Date: Tue, 12 Nov 2019 15:14:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <f2eed143-4767-81b2-2de9-e89631c7bd5a@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::23) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3ab3b74a-79b6-47f9-04f8-08d767aced1f
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0054:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB005490AC0136388C44311CDB8C770@CY4PR1201MB0054.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(54094003)(199004)(189003)(47776003)(6486002)(36756003)(65806001)(25786009)(66066001)(6512007)(8936002)(6436002)(4326008)(446003)(31686004)(229853002)(81156014)(81166006)(3846002)(2870700001)(6116002)(316002)(58126008)(11346002)(2906002)(65956001)(14454004)(99286004)(5660300002)(8676002)(486006)(2616005)(476003)(52116002)(6506007)(386003)(76176011)(6636002)(7736002)(2486003)(23676004)(186003)(305945005)(478600001)(26005)(6246003)(66556008)(66476007)(50466002)(66946007)(31696002)(4001150100001)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB0054;
 H:CY4PR1201MB0230.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UQSx1E5x6YQu4NdLuQbzO6O2LaphqX3/Bvv9HR0m4lFIsvkr4tvYXq5NX/roR1WlaRig8ZOtXNuneMdwgioJdUHdm2wjGiUvRgE11YeRwy0/YHzqq2WNmkaCFYadhy5eclId149VE6VZsKDzDw8SoYSeYR1eZWXRhTkmxp7CIxVPDxgwkwIIArnpVxZ9aDrAiX6Elst/8UQWxGsNNZfYRFaWail3Whe8WcU640VbJdy4CATtEBlWVNGtfGDbuVEMZd3MPfEqLq2137umPGyidN9YEGXoiIBHgmKFcYTIKxzgCH4NGxCyF0tK15OZhc9pXmMa7Ysfpgz+9d9nN82oB2v0sgbUM9dkM4X4IIP+Ffk9AkDiYiafweD7BNjmmlaygNHFaUVMSO4yIx3KTCUIBMY6NgAGC/XTv+hj4nfH8mbnqgyAwMhgyGiHND2Uwu9k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab3b74a-79b6-47f9-04f8-08d767aced1f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 20:14:30.8012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7r113LzVjO5YxQwVO+u9OCpwXq/Gb/CHmw1vkgaCTOau01Tus2cJHcp6zLekGyUcIpcK+08awDanH8Kd4NHkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0054
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOD1sM4DrRSc/BIgxLd4MVKRXxYjlBGKjvIryTKQ2po=;
 b=h6N/Pfy+elsac+530ZasyLw/qA2XF3Xk/knZzekWMD6R5+1rkeUU8twzYwVfwIQRoOipUcmNeWtOEPAdFJwFLX95aWkJv67bjW4OMMBOXaz9UZRtX7lclEC3+Dq52vEmPpEoVGSDmKZAgOhq6RHEgOCDMrmU1X4FHzeH3vOmh1Q=
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
Cc: alexander.deucher@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112201428.QNwPYD9-qIoLZ4O1JsNnKH2sDOF3_mGw4i5cZBuMMLU@z>

T24gMjAxOS0xMS0xMiAxMTowOCBhLm0uLCBLYXpsYXVza2FzLCBOaWNob2xhcyB3cm90ZToKPiBP
biAyMDE5LTExLTEyIDEwOjE2IGEubS4sIG1pa2l0YS5saXBza2lAYW1kLmNvbSB3cm90ZToKPj4g
RnJvbTogTWlraXRhIExpcHNraSA8bWlraXRhLmxpcHNraUBhbWQuY29tPgo+Pgo+PiBbd2h5XQo+
PiBUaGUgZnVuY3Rpb24gaXMgZXhwZWN0ZWQgdG8gcmV0dXJuIGluc3RhbmNlIG9mIHRoZSB0aW1p
bmcgZ2VuZXJhdG9yCj4+IHRoZXJlZm9yZSB3ZSBzaG91bGRuJ3QgYmUgcmV0dXJuaW5nIGJvb2xl
YW4gaW4gaW50ZWdlciBmdW5jdGlvbiwKPj4gYW5kIHdlIHNob3VsZG4ndCBiZSByZXR1cm5pbmcg
emVybyBzbyBjaGFuZ2luZyBpdCB0byAtMS4KPj4KPj4gU2lnbmVkLW9mZi1ieTogTWlraXRhIExp
cHNraSA8bWlraXRhLmxpcHNraUBhbWQuY29tPgo+IAo+IEkgd29uZGVyIGlmIHNvbWUgb2YgdGhl
c2Ugd2VyZSBpbnRlbnRpb25hbCBmb3IgcmV0dXJuaW5nIDAuIFRoZXNlIGxpbmVzCj4gd2VyZSBv
cmlnaW5hbGx5IGludHJvZHVjZWQgZm9yIGVuYWJsaW5nIHNlYW1sZXNzIGJvb3Qgc3VwcG9ydCB3
aXRoIGVEUAo+IGFuZCBJIHRoaW5rIHlvdSdyZSBndWFyYW50ZWVkIHRvIGhhdmUgdGhvc2UgcmVz
b3VyY2VzIGFzIGluc3RhbmNlIDAuCj4gCgpUaGF0IHNvdW5kcyBsaWtlIGFuIGluY29ycmVjdCB3
YXkgb2YgaGFuZGxpbmcgdGhpcy4gTWlraXRhLCBjYW4geW91CmNoZWNrLCB0aG91Z2gsIHdpdGgg
dGhlIG9yaWdpbmFsIGF1dGhvcnMgKEFudGhvbnk/KSBvZiB0aGlzIGZ1bmN0aW9uIGFuZAptYWtl
IHN1cmUgeW91IGdldCBhbiBhY2sgZnJvbSB0aGVtPwoKSWYgdGhlcmUncyBubyBvYmplY3Rpb25z
IGZyb20gQW50aG9ueSB5b3UgY2FuIGFkZCBteQpSZXZpZXdlZC1ieTogSGFycnkgV2VudGxhbmQg
PGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+CgpIYXJyeQoKPiBOaWNob2xhcyBLYXpsYXVza2FzCj4g
Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19yZXNv
dXJjZS5jIHwgNiArKystLS0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9jb3JlL2RjX3Jlc291cmNlLmMKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvY29yZS9kY19yZXNvdXJjZS5jCj4+IGluZGV4IDg5YjVmODZjZDQwYi4uNzVjYzU4ZWNm
NjQ3IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9k
Y19yZXNvdXJjZS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3Jl
L2RjX3Jlc291cmNlLmMKPj4gQEAgLTE4NjYsNyArMTg2Niw3IEBAIHN0YXRpYyBpbnQgYWNxdWly
ZV9yZXNvdXJjZV9mcm9tX2h3X2VuYWJsZWRfc3RhdGUoCj4+IMKgwqDCoMKgwqAgaW5zdCA9IGxp
bmstPmxpbmtfZW5jLT5mdW5jcy0+Z2V0X2RpZ19mcm9udGVuZChsaW5rLT5saW5rX2VuYyk7Cj4+
IMKgIMKgwqDCoMKgwqAgaWYgKGluc3QgPT0gRU5HSU5FX0lEX1VOS05PV04pCj4+IC3CoMKgwqDC
oMKgwqDCoCByZXR1cm4gZmFsc2U7Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gLTE7Cj4+IMKg
IMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IHBvb2wtPnN0cmVhbV9lbmNfY291bnQ7IGkrKykg
ewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHBvb2wtPnN0cmVhbV9lbmNbaV0tPmlkID09IGlu
c3QpIHsKPj4gQEAgLTE4NzgsMTAgKzE4NzgsMTAgQEAgc3RhdGljIGludAo+PiBhY3F1aXJlX3Jl
c291cmNlX2Zyb21faHdfZW5hYmxlZF9zdGF0ZSgKPj4gwqAgwqDCoMKgwqDCoCAvLyB0Z19pbnN0
IG5vdCBmb3VuZAo+PiDCoMKgwqDCoMKgIGlmIChpID09IHBvb2wtPnN0cmVhbV9lbmNfY291bnQp
Cj4+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1
cm4gLTE7Cj4+IMKgIMKgwqDCoMKgwqAgaWYgKHRnX2luc3QgPj0gcG9vbC0+dGltaW5nX2dlbmVy
YXRvcl9jb3VudCkKPj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsKPj4gK8KgwqDCoMKg
wqDCoMKgIHJldHVybiAtMTsKPj4gwqAgwqDCoMKgwqDCoCBpZiAoIXJlc19jdHgtPnBpcGVfY3R4
W3RnX2luc3RdLnN0cmVhbSkgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHBpcGVfY3R4
ICpwaXBlX2N0eCA9ICZyZXNfY3R4LT5waXBlX2N0eFt0Z19pbnN0XTsKPj4KPiAKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
