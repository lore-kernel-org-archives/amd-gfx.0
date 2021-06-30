Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8396DC11F65
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 11:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CABD613EE
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 11:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CABD613EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 032576E98C;
	Wed, 30 Jun 2021 11:17:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29D246E98C
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 11:17:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cygd63hC4E8h6IeIOhjlTkhNxEHdJ682JamQly0O7MAI5LaUXEY3kn03hlfrn10fApTwGsJB8qX5Xq6/dx+EfxZ97Giy1VjGgAkF4udVTSOoIkNKRNcSWz60qnknx7o5tl1PXDZqjZ3mhoaST67OySO3nOiaZ89QP9jwK8ndKUzvV7mmWKqS+flzl6Ju3IHRBVxM95KR/jUsmg8lypEGB4QuYG2E6ZGf4R0u7ZyBCrsVfG92Bg50h9GksIHH6ypMm63BYnJ/Cma0wpVUQCc/ZfFvo15MWzt/KUGAffHCaEuTY8jzGlOkMEdRVN6tk9RltDBCPiAhrgxS0CpjhnuADw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TVGJwW7bC5Un/hPXMIU8JmA1aUbNk3VH/jP5FvMYfg=;
 b=j6dVjvvBallHk5HvpVZxG2c7KcwfKTVZhBW2/FmWo/hrw6gSgcKvFC8aLYX3/BlRjbwBKLF972WAEkEKye/uyGn9fu6ijKB4u8Vp5DcwFJUEjR6r1a7NkxHki86sdLqrY1oKPGSv0+sZtJwDr+qLRWAbu/8Z/L6CNX6Z/fmgikJCzFxT+RQyybp7QCXdurhO+JH2GFf79N1Zkpy3j5f/8eNDseGGQPKqgGUiH1+Y+E/zTObrK2bnJLuccYReTWbDYSDSDT0qesIyh2OgSnu70f+4jCXxqX1d1W9gDxMEggiaQa2VIbfdP4uBpVUHbd+X4EY8XSKJP3PLHibMJ8HV7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TVGJwW7bC5Un/hPXMIU8JmA1aUbNk3VH/jP5FvMYfg=;
 b=xKe+/va80Pez4geqzF9zyPB+XgDCz6oNzt88T7z2ynY4+FuazJ/bAiGXWpEa9la7/Bb55fBZhnCXtV0lWYYJhkMd9fTTBi6rKiJJ1Mjq2nuEwZsfdXapU2h0JUzlHa9KoPJ24PhoO4nC6oye9xwIplUvrBcwWJ9vR82I2MzkqAw=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Wed, 30 Jun
 2021 11:17:39 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::d9d7:2d92:acc3:e3c3]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::d9d7:2d92:acc3:e3c3%3]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 11:17:39 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Wang, YuBiao" <YuBiao.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: Read clock counter via MMIO to reduce
 delay (v4)
Thread-Topic: [PATCH 1/1] drm/amdgpu: Read clock counter via MMIO to reduce
 delay (v4)
Thread-Index: AQHXbZgjyw4N2Vyxl0GwG8mHBUfpOKssZwSAgAAAyYA=
Date: Wed, 30 Jun 2021 11:17:39 +0000
Message-ID: <BL1PR12MB5269971F41887FB1BC96558A84019@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <20210630101012.2006307-1-YuBiao.Wang@amd.com>
 <93f00743-d94f-41de-c0a1-9b6b2391e74e@gmail.com>
In-Reply-To: <93f00743-d94f-41de-c0a1-9b6b2391e74e@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-30T11:17:38Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=8f8a449c-8768-40ec-9afb-88f79c0b8c75;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70c2fd95-33cb-4e09-a7c4-08d93bb8ac0c
x-ms-traffictypediagnostic: BL1PR12MB5192:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB51923027390C7B1FE1C8FAEA84019@BL1PR12MB5192.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dAkHhkDFIhN/D+B3cAh75QpZeru5oz/AtBaHGRtLEbeQ6dDMrPu/bWCa5l/jFGOiuVeCAKQG6x+Ts6gdVrprVVVhdrNYx9WQT+RA/WuBuMcx2V5oaY3aGGMLlhkVdm5Nnh/kau7J4OtTJfqN/kuvdHUxwrHI2PRGgucTRqmX2VDI/seSl7gxiAZdfU4tvxo3VQW4dr84FR9+g5fb1KrFs/JW9m1NExE+wtpP0UPaDA9XWhh6NVgNGy8KEd7EwBR0/TFu0/TkciLxu9EEDWSdCCeZtWE8yDovidDi39njYG6M+nj6u/YdNQQfSkC+KM/4HRFokAwxlITx3LJNrOzEmoTp7hDbG+Vv5gOegvXPd3MELCTVRrDIdPQDo09XTTZ/jNz+kfYVz61ka2VSjprqzIEQ55/0Sz/55NmZVGV6kDAb07Mcfq9UHgZxOqIqs7q4RqHVFqi+B/7Lqy3vbozS7fSxgyRc0blUOJ+5l0wxGCnrg09IPxsKEZR/joe9nmjA0Nm65piGlMpYVARQn3TJnbcXWVGU6UJLbehiEl8N1ai/rgIXClFR/4OF4OYxsZrFnT/+P1GIlkhYb0QU7dtqASNxyJivSC9jIeMSS4jAp5++SxCVCx9PwURsTqWTxW/VTZ+PqShC+j4BdbpBkgAC/w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(66574015)(8936002)(54906003)(66446008)(9686003)(4326008)(64756008)(66556008)(33656002)(316002)(76116006)(66946007)(55016002)(83380400001)(5660300002)(71200400001)(8676002)(110136005)(122000001)(66476007)(38100700002)(478600001)(52536014)(7696005)(53546011)(6506007)(186003)(2906002)(26005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmI3anJrcmRScFVEbTNGTExDeXB2WC9GVC80MjZoazZ6cFFnY0tsaS9DamQx?=
 =?utf-8?B?YjJaOWxIT0ZnQ0Z2d0tPSFpXL3dzUDJpVHUyVUx5U3BnNGtxYjJrdEQyWVpM?=
 =?utf-8?B?K0hOcXdxRk1BTkpVTWYxbFN6THV4T1kzZXJTRnRWekI1S3NzekhhRjZpNHUx?=
 =?utf-8?B?K210Qk1wQ1J4a2NtSzZRUmViVkVKYTVqV005THNLZEFWTVRMeklEOGlKUzk4?=
 =?utf-8?B?SkdlNUVGV0xqbGkrclYyM25lb2FKODdXYzEyaXA4U3N3WkJzQ0pqelcxREd6?=
 =?utf-8?B?aTZJZnpibXY0NUJ6dzRGYmlYWHppVDlDQ0k5UmtPNzBLM2Q5cVBEQXoyTnZv?=
 =?utf-8?B?cjV2amRWUHdoTUhaRzAzNWhwSnJsMUVIUkZ0bTE2cmV0eVI0ZklsamVvQlBq?=
 =?utf-8?B?c2MyYUQySk9iS3BRUDZ4eEpoVndrWHZPQytFNU5pSTZKblpvMVpXSnZrYzBO?=
 =?utf-8?B?MmxSdW1KdXlhNUZaWkdKSjd2ei9xMFlYTmp4bTRVNVVmVDZBcG9nNmYvc2Yw?=
 =?utf-8?B?NGdMY0N5NlpKQ1VTNndDYnVaODNrQyt2L2Q3Y0FpRmlIOGNvNGV4amFsSHJm?=
 =?utf-8?B?UVRHc3BrRFJzM2lLc21DWDVuclY2U00wMmloZ2g3VndzM0hrTUVZVGF2Y2FY?=
 =?utf-8?B?ZUdwWnpxUVNoUGJXbFlEb0FzQjUvNGd6ZXQ4eEo1QXNkeVJiYlE4TWdnUmlM?=
 =?utf-8?B?eG45UEtXanNQejY4SHhDWUZnR21rVERQSUxkQWRHbVRsUUwrOHViZUIzSUx3?=
 =?utf-8?B?cGEwbDVPUjVDY2duaCtKcVJNeWJXZkpXVjJyaTdUT0w0TWQ2R1ZjM2IrRWcz?=
 =?utf-8?B?TTd4NzB3Vmd3OGw2dnRwVHNjamV6dmpoRUlzQklqR0tybkw5QXZyVU4zK1VV?=
 =?utf-8?B?SndWcjRsb3BsR2Yycm5tbFBCcnpRRU1xTDNHalhSK0dyOUQxT0JZbVNnY24v?=
 =?utf-8?B?bXZzWk1LRVRBMStCdnVUakkzN0ZhdmNiaXpKY1NySXl4RU00RHU0WldKb2tw?=
 =?utf-8?B?cHBPTGphd3locVdGOGRIcHMzaUZsSEZvVXdFVitkVjlGcENscUdhNDVlSUJr?=
 =?utf-8?B?K1hDeTBtS3doRE9IbFUxZXFCTUMwUUxaZkpPWDNZdXZQdVBLbjFYK1RSQ1My?=
 =?utf-8?B?OU1BY3VqRnM4cUQwNktOZG5jVGNGOWV6MkJtOXloNUc5VjR0TUxtMlpwUVBh?=
 =?utf-8?B?SWJiWDBWSXVyWXl5Zi9hUGk3dDh4eVNrcEtXS2xRZ0NUaWRRakxpU05pVUgx?=
 =?utf-8?B?eEJwT05TMmhtTkFrbC9zbWF1OUcyRmxaSjRUWGZKTkVGaExYdS9tVUovYkZk?=
 =?utf-8?B?SitTUkYvSWdHVDVtcWdyS0Nuc296UnN3eld5VlVJYUp6K1VqTXVscU44UXl0?=
 =?utf-8?B?dWMvdHgzWGhRWHEvVURSeHdXOU5pWWtLSGpwYkdGaVlXQ1VDZjZDbllEcWc5?=
 =?utf-8?B?akZUd3NEZlNyZExnalVpSEJibW42S3dqYmdKU3dZYndCTGJQSnh6VjRPNXVE?=
 =?utf-8?B?OTF4VVRpQkxLemZrUXBWSVVhRnE2WHFvZHFFdGNqQldMYWk5ZmR6RGV1UDg3?=
 =?utf-8?B?RTBpekpyKy9CbXFDSVhRTUNxOHZZLzlXcDNxR0thYmV1V0x2TUhjK3dlRzZI?=
 =?utf-8?B?ZEZXaVFkb0FhREZDVkFsM0VDZFk3bWdGZnREMG1tQnY3QVcxYjNEYjRERG9W?=
 =?utf-8?B?ODR2bmJZU0kyUnNLMGFpZjNBSzB6WmViV1h6aGFxSlFvaUJkbkoralBIVFl2?=
 =?utf-8?Q?/SSlrJwGHJFf1Q0hpNegGzvwKw7BmOoL8Jd8b6U?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c2fd95-33cb-4e09-a7c4-08d93bb8ac0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 11:17:39.4704 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: al203c/Ws6B5BRPMXb/SW2swLIIaURytpwDlcKHclG5iz0o7NKh/jFHlsO2deI25
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5192
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Xiao,
 Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>, "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>,
 "Tuikov, 
 Luben" <Luben.Tuikov@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KPj4gQW5kIGEgcHJlZW1wdF9lbmFibGUoKTsgaGVy
ZS4gVGhpcyB3YXkgdGhlIGNyaXRpY2FsIHNlY3Rpb24gaXMgYWxzbyBub3QgaW50ZXJydXB0ZWQg
YnkgYSB0YXNrIHN3aXRjaC4NCg0KRG8geW91IG1lYW4gcHV0IGEgInByZWVtcHRfZGlzYWJsZSgp
IiBoZXJlID8gDQoNClRoYW5rcyANCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQpNb25rIExpdSB8IENsb3VkLUdQVSBDb3JlIHRlYW0NCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5j
b20+IA0KU2VudDogV2VkbmVzZGF5LCBKdW5lIDMwLCAyMDIxIDc6MTUgUE0NClRvOiBXYW5nLCBZ
dUJpYW8gPFl1Qmlhby5XYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zw0KQ2M6IEdyb2R6b3Zza3ksIEFuZHJleSA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT47IFhp
YW8sIEphY2sgPEphY2suWGlhb0BhbWQuY29tPjsgWHUsIEZlaWZlaSA8RmVpZmVpLlh1QGFtZC5j
b20+OyBDaGVuLCBIb3JhY2UgPEhvcmFjZS5DaGVuQGFtZC5jb20+OyBXYW5nLCBLZXZpbihZYW5n
KSA8S2V2aW4xLldhbmdAYW1kLmNvbT47IFR1aWtvdiwgTHViZW4gPEx1YmVuLlR1aWtvdkBhbWQu
Y29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgUXVh
biwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFu
LktvZW5pZ0BhbWQuY29tPjsgTGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29tPjsgWmhhbmcsIEhh
d2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8xXSBk
cm0vYW1kZ3B1OiBSZWFkIGNsb2NrIGNvdW50ZXIgdmlhIE1NSU8gdG8gcmVkdWNlIGRlbGF5ICh2
NCkNCg0KQW0gMzAuMDYuMjEgdW0gMTI6MTAgc2NocmllYiBZdUJpYW8gV2FuZzoNCj4gW1doeV0N
Cj4gR1BVIHRpbWluZyBjb3VudGVycyBhcmUgcmVhZCB2aWEgS0lRIHVuZGVyIHNyaW92LCB3aGlj
aCB3aWxsIGludHJvZHVjZSANCj4gYSBkZWxheS4NCj4NCj4gW0hvd10NCj4gSXQgY291bGQgYmUg
ZGlyZWN0bHkgcmVhZCBieSBNTUlPLg0KPg0KPiB2MjogQWRkIGFkZGl0aW9uYWwgY2hlY2sgdG8g
cHJldmVudCBjYXJyeW92ZXIgaXNzdWUuDQo+IHYzOiBPbmx5IGNoZWNrIGZvciBjYXJyeW92ZXIg
Zm9yIG9uY2UgdG8gcHJldmVudCBwZXJmb3JtYW5jZSBpc3N1ZS4NCj4gdjQ6IEFkZCBjb21tZW50
cyBvZiB0aGUgcm91Z2ggZnJlcXVlbmN5IHdoZXJlIGNhcnJ5b3ZlciBoYXBwZW5zLg0KPg0KPiBT
aWduZWQtb2ZmLWJ5OiBZdUJpYW8gV2FuZyA8WXVCaWFvLldhbmdAYW1kLmNvbT4NCj4gQWNrZWQt
Ynk6IEhvcmFjZSBDaGVuIDxob3JhY2UuY2hlbkBhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyB8IDEzICsrKysrKysrKystLS0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIA0KPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jDQo+IGluZGV4IGZmN2U5ZjQ5MDQw
ZS4uOTM1NTQ5NDAwMmExIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjEwXzAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEw
XzAuYw0KPiBAQCAtNzYwOSw3ICs3NjA5LDcgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfc29mdF9y
ZXNldCh2b2lkICpoYW5kbGUpDQo+ICAgDQo+ICAgc3RhdGljIHVpbnQ2NF90IGdmeF92MTBfMF9n
ZXRfZ3B1X2Nsb2NrX2NvdW50ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAgew0K
PiAtCXVpbnQ2NF90IGNsb2NrOw0KPiArCXVpbnQ2NF90IGNsb2NrLCBjbG9ja19sbywgY2xvY2tf
aGksIGhpX2NoZWNrOw0KPiAgIA0KPiAgIAlhbWRncHVfZ2Z4X29mZl9jdHJsKGFkZXYsIGZhbHNl
KTsNCj4gICAJbXV0ZXhfbG9jaygmYWRldi0+Z2Z4LmdwdV9jbG9ja19tdXRleCk7DQo+IEBAIC03
NjIwLDggKzc2MjAsMTUgQEAgc3RhdGljIHVpbnQ2NF90IGdmeF92MTBfMF9nZXRfZ3B1X2Nsb2Nr
X2NvdW50ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAgCQkJKCh1aW50NjRfdClS
UkVHMzJfU09DMTUoU01VSU8sIDAsIG1tR09MREVOX1RTQ19DT1VOVF9VUFBFUl9WYW5nb2doKSA8
PCAzMlVMTCk7DQo+ICAgCQlicmVhazsNCj4gICAJZGVmYXVsdDoNCj4gLQkJY2xvY2sgPSAodWlu
dDY0X3QpUlJFRzMyX1NPQzE1KFNNVUlPLCAwLCBtbUdPTERFTl9UU0NfQ09VTlRfTE9XRVIpIHwN
Cj4gLQkJCSgodWludDY0X3QpUlJFRzMyX1NPQzE1KFNNVUlPLCAwLCBtbUdPTERFTl9UU0NfQ09V
TlRfVVBQRVIpIDw8IDMyVUxMKTsNCg0KSWYgeW91IHdhbnQgdG8gYmUgZXh0cmEgc3VyZSB5b3Ug
Y291bGQgYWRkIGEgcHJlZW1wdF9kaXNhYmxlKCk7IGhlcmUuDQoNCj4gKwkJY2xvY2tfaGkgPSBS
UkVHMzJfU09DMTVfTk9fS0lRKFNNVUlPLCAwLCBtbUdPTERFTl9UU0NfQ09VTlRfVVBQRVIpOw0K
PiArCQljbG9ja19sbyA9IFJSRUczMl9TT0MxNV9OT19LSVEoU01VSU8sIDAsIG1tR09MREVOX1RT
Q19DT1VOVF9MT1dFUik7DQo+ICsJCWhpX2NoZWNrID0gUlJFRzMyX1NPQzE1X05PX0tJUShTTVVJ
TywgMCwgbW1HT0xERU5fVFNDX0NPVU5UX1VQUEVSKTsNCj4gKwkJLyogQ2FycnlvdmVyIGhhcHBl
bnMgZXZlcnkgNCBHaWdhIHRpbWUgY3ljbGVzIGNvdW50cyB3aGljaCBpcyByb3VnaGx5IDQyIHNl
Y3MgKi8NCj4gKwkJaWYgKGhpX2NoZWNrICE9IGNsb2NrX2hpKSB7DQo+ICsJCQljbG9ja19sbyA9
IFJSRUczMl9TT0MxNV9OT19LSVEoU01VSU8sIDAsIG1tR09MREVOX1RTQ19DT1VOVF9MT1dFUik7
DQo+ICsJCQljbG9ja19oaSA9IGhpX2NoZWNrOw0KPiArCQl9DQoNCkFuZCBhIHByZWVtcHRfZW5h
YmxlKCk7IGhlcmUuIFRoaXMgd2F5IHRoZSBjcml0aWNhbCBzZWN0aW9uIGlzIGFsc28gbm90IGlu
dGVycnVwdGVkIGJ5IGEgdGFzayBzd2l0Y2guDQoNCkJ1dCBlaXRoZXIgd2F5IHRoZSBwYXRjaCBp
cyBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
Pg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQo+ICsJCWNsb2NrID0gKHVpbnQ2NF90KWNsb2Nr
X2xvIHwgKCh1aW50NjRfdCljbG9ja19oaSA8PCAzMlVMTCk7DQo+ICAgCQlicmVhazsNCj4gICAJ
fQ0KPiAgIAltdXRleF91bmxvY2soJmFkZXYtPmdmeC5ncHVfY2xvY2tfbXV0ZXgpOw0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
