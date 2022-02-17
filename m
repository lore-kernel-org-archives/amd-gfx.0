Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BCAC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 02:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB7C710E606;
	Thu, 17 Feb 2022 02:46:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E9F010E701
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 02:46:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+8gkslYlv5KrPP/d2bOblBICfsCaw/EoUJ93qla5xMznBY97dxcfCxVJF/twPapoUfNnoOcVcH8lCQ7LGayKioOb7Uzzj9dY4hNSfgRs/YYwu6+X1SZAu0tD8WhItIl+7Hx9AtydDgoa5rsM/Z49G14L7NL6DqEt/azJSkIPi/n3pUIhxZtZcIJz0z/n3XTnjrBWEc7vIbs1bjOgW9i6MfPl/a6+CN20dB68Wmzyi5wKDpCz8NVyeIrE4uWZNPQUMSHNLipEOYkEg6oFk9BDyhDRXPesq/gGQlVAXQn/CYse/J86s3Etq3gezbkxNb0RpfGVf32m+fw/cY8SVFKLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wK2W6UF3EvXtawYcutF0GD1fXJQy5BhKtonGWouWZac=;
 b=WIKTwkMMoZ/GYC5PU6IK3ntlonM1nnF+XCHZGXQYrhxiWev6N0blYruK/YYwg2SzTtMaMRuioAPXbr0r49/Xipj6sHmlCpvl1Isgvoyf3NfXzpReKmQeJdXdYfIs7D2tugwNIBJ7V/sHzZ3T/vV0/2MtF/KgCu9pU95HUxESEojgJLgXBHLcVTxqY1vIB+MkLOgCn0/eYfwb3hKsQU3Tc3IPqLTfN3ZwR6avlezvwI74wX4CqkMzYaA1AggNlXrQ981OmfdmXuGaW78o5sYXqQPdKRNQDwLpja9X8pAunkm52GdmV+nFBMW+R0ZSpZzs2oxjai0PIWEVcuY17jj7mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wK2W6UF3EvXtawYcutF0GD1fXJQy5BhKtonGWouWZac=;
 b=s8QdGFb7Xer/18Cu+zMjmTym9xQKwst3I49IIKExNtCd8ECvGr6KMVvuH8zFnA9JydiLv2w2pyD8Drs+iK2M8a8+FAgdt9mGgLdECaHoOzwrlbN+LV7tk97f6uoWYB+4WrOhpdfU4nEaTUbrn87ojiLMyHWMfXbbWbLcYrV3psc=
Received: from CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17)
 by BN6PR12MB1586.namprd12.prod.outlook.com (2603:10b6:405:f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Thu, 17 Feb
 2022 02:46:31 +0000
Received: from CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::f0bc:3a8f:2662:931a]) by CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::f0bc:3a8f:2662:931a%3]) with mapi id 15.20.4995.015; Thu, 17 Feb 2022
 02:46:31 +0000
From: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Grodzovsky, 
 Andrey" <Andrey.Grodzovsky@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: fill scheduler with device ptr
Thread-Topic: [PATCH 2/2] drm/amdgpu: fill scheduler with device ptr
Thread-Index: AQHYIwYD44oLMlhV4UuTPSBXnmAnIqyWB3uAgAEAK/A=
Date: Thu, 17 Feb 2022 02:46:31 +0000
Message-ID: <CH0PR12MB5156D41524A4F2C3458FD5A9F8369@CH0PR12MB5156.namprd12.prod.outlook.com>
References: <20220216072223.8394-1-Jiawei.Gu@amd.com>
 <20220216072223.8394-2-Jiawei.Gu@amd.com>
 <6ea78726-4121-a01a-57d1-76d496e6bcc8@amd.com>
In-Reply-To: <6ea78726-4121-a01a-57d1-76d496e6bcc8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-17T02:46:28Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7cd8a926-35f1-42e9-a87a-dca3c2bd0ef2;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-17T02:46:28Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 8affa937-a1df-4b1e-b7a4-b8ad4c1e368a
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70e6ad48-98d1-4848-f101-08d9f1bfb45e
x-ms-traffictypediagnostic: BN6PR12MB1586:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1586AA15A9D249F0837B74A0F8369@BN6PR12MB1586.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oVzm+ygQRZOY4uJ1NC+Co7O6ctT8kehABchF2Lonkypoi9VBEr4CeL7G1L6V5LGmdogcEUZjuC97OUW2Cd8twzgfxCjSEBAyHoFfL3k658+34TuIDdGQwH30XhOCQ5V7UV3cSKUYAuU5911e4XMg5BXdc0Socu3GdyMHPywpQwSbPxlZbYatWXa+vv1IBpCcqMg7LJoeMp7B9w+/1b4Py65VFNOJMd+Wx+vB5MgtjB1+ZNbuoc5q3Padx3cDWJ5Bj1CRs2I0MXmduoqQAOhLB47e3u+6FWUDMgNVuFbZaeTz1uyBWD8Sb7fgAHmTFY5LOAoZY3t40JrK/ygkzEcgEpaRBggffuEScLOpxsHygUEaXmNzLFlLrgcbE5DKb24cAVwbt9yfH3roWlzteJsu5Gkrzx0/DklU32Ac4knJvQTpx/HVdY026m3Eq6uo07GoF9i75eVjO+slr+nEy7Vfc3Gs5Rni38qJMigteoMMIWFV9E7RHacdXcCfeo+Rw6PW48I4+B0uZHGxnSuqrS5tdab6mMzgnaHWJbGJDtcW3v5y8ikHdRt/1r3w/yaKPSGiNgmutdHpzZ+v2s+LpgG/0TqdtcdP9MpSO4IJ5hjkVnv4dcsxVJzsiQiF++Il97dRzBwEsW7fAnlw/mLcuhPr6sEFw3u9Q1Q24tDVqPtULatu7k7YO7OOtdRB7WAzEUPPb1Q/V80h63RI6HjxMmNo3A7W7MMuvwlYO0W+8IiQ6mU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(33656002)(53546011)(5660300002)(7696005)(71200400001)(55016003)(9686003)(8936002)(52536014)(83380400001)(508600001)(6506007)(186003)(86362001)(26005)(122000001)(38100700002)(2906002)(64756008)(921005)(66446008)(66946007)(66476007)(66556008)(8676002)(76116006)(6636002)(316002)(110136005)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWp5dnoyZzhIOWZ4dnJxclBvQXNnelhtZjU0ODNJNzVEZ1Aya051bjN4VFZ0?=
 =?utf-8?B?STVoMG9MZHBaL1lJQ3Rndlh4UDlpYmRpcHd6REFvb2VsK1hHY2tiUTlUaVZa?=
 =?utf-8?B?U1poellkQjZibUl1SUhYYkk5djlxSVNzcHNZeTR1UVBJcDJiR2FIQnk5ZEtS?=
 =?utf-8?B?WDRQOVd3ek1hTDNHWnRYNkxFK2VHQUZSc29wdFpJeXVZeVVBWS9vMkdlV0M2?=
 =?utf-8?B?MGhCMXh6c21CY3NROVVubjlYeU8xL3hTWkJZRlZFcHBsN1VuK0VoYkpNRXQ1?=
 =?utf-8?B?c25HOHdzNVZ1bGN4d2VXUmhweVhybVp2aWk2NWFsMVNUdGFXRTYybFV6MGVS?=
 =?utf-8?B?NlNPb0NaWFlpOFN4TjgwazN5dzdwQzhKKzRmSHFFWUJXa0NVa0tjcFI2dWhy?=
 =?utf-8?B?Z1Nld0xmcUlGS2N0bHFlQWlzQjBVMEdUV0l6UkxkTE9IQnNnTGVuUzVBY1dD?=
 =?utf-8?B?dU1vd0Y1d1FyZWhSZzdrL3pDeHRGOTE0QjBHRUozVXk0ZGNBOFZjY2FuNzF0?=
 =?utf-8?B?TFdYRytRK1FrK3M5Y3Blb3kxc1gvQTdSSytCcXhVTFpWbG1rWnhzeDlvVlBQ?=
 =?utf-8?B?eUxmVEdPVysreDFlcDRTbGRERkozK3JXZUtLZ2xSOHFFVFN2NVNIRWp1aVk5?=
 =?utf-8?B?SnFNSmZVemdjNFkzQWRteVhLNXNZbzE1cmFDQ3c4cHJRNGZrSEdPaUJ3V0gv?=
 =?utf-8?B?SndSeWQrcjIzSFRIT20vKzFBQXo2WFBVVW5FWm1JYU5QcVFscm84MmZPSFQv?=
 =?utf-8?B?TU9MSTl3L2ZvZE9BZzVlK1paK0JBZTMzbTNWemZISnJObUkxb0hlL1pORFY5?=
 =?utf-8?B?RnppQVhwd2NnSGxFL000ajBLSmZXdUhIRkdxWEltcUVmdk8wbDdiYU80UGdK?=
 =?utf-8?B?SzRQYlIxdHNRcXVyNUJseUZ5QmFxU0prd1A0L3dVaUl1NVJhd3BXK093M2Y3?=
 =?utf-8?B?T0VQejBUbVRUcmVPQmtpR0ZscFRtdk9IdzRJK1FWYlZVeWNWT29ScUJIZUR4?=
 =?utf-8?B?TkJPczRWM0svbDNiM0tXbEpFUS8rb0Y2b2l5ZGY0MXRsRUpFMUcxSit5U3pV?=
 =?utf-8?B?bTN0V0hjNVMvdzZpQmhDckNmRFc4blNKN3VrSTFsRnlVTWVHTWJlaHRSTFBZ?=
 =?utf-8?B?YmxRT1pUNXVNakhHVlhVTUFJS3FTY0taaEEzNG1uT0VVZWN6R3dzdURRQkhS?=
 =?utf-8?B?V05QNm1TYmt6YUtzZ3FLOW9EelR3M1RLcnYrakFibW1QWnZEd2lMMUF1MWpl?=
 =?utf-8?B?Zkp0WkFYNlpsdUtNWEJnLzhnZlZtOVZnOUxkT2wxS29LbEJWMHByZHU5Tk9X?=
 =?utf-8?B?dUlQRjR5b3FTTW9lWHNBMTRwc2ZUY1BTamlKazd3OUQ2aUdSaVdsdUhuQkx4?=
 =?utf-8?B?bDNsRWwwWXcrWHpGZzJwUGs4R0V4OUJBenBJYWtNelIzMGtjLzU5Z1AwUE41?=
 =?utf-8?B?T2d4eUxjSlA4SE1OVDRXb2MyT3dNUGdLSGVxUDV0dkFKR09jRS83R1N2TmZp?=
 =?utf-8?B?MHArVTl0d0hLUFMxOE81SWVnM3ZMbmd2MTJjQ3pTT2pqVDdySU1DSGI5ME1I?=
 =?utf-8?B?bldMSXhuNFpRS1NQcDArTWNUcnBXc1BmeVQ4UTh1V0tVTlp1MllNZkpjMUR3?=
 =?utf-8?B?RHhOc3lSd1lQcDRrR3RMUURMRTI2OFNHQ2liZDZTdU1KcG4vd2tUQnVvUHpV?=
 =?utf-8?B?Sm03WWEyTGpSTEVSMFZaQ2VpR0pxVlVyTXEvUytVTXMvRGY3Vk1yUkoxSW5x?=
 =?utf-8?B?N3JpR1lkc0ZMQS95T05sdWxqM29JZlhvQ2EwR1R3WjJZckY3aWM0RUNJZjR6?=
 =?utf-8?B?TUJIUFBpZU1JeDZYR0QzazBDU0I2VGF1UFVlQ1FLOEt2WlhQNjRjRm1MSlNj?=
 =?utf-8?B?cUZISUtEMklYNmpXRStnMU1QN09Ob0YvVjhJWFVYdTQ2NEh5Znp4WW1kN3Q5?=
 =?utf-8?B?dWVOYXJiK3hmUjRuZVR0Z0ZLaVFTNnRBSzkzekU1d2d2T25FZGNZUE1DWElV?=
 =?utf-8?B?Z0JKREkxUnRlWHFMM2xhR0VnOGQ4Q0srWXNiQzFSSFRnaHQzQk5UbTNIWjhF?=
 =?utf-8?B?MFdQWHlHaTgrREJOMlBwUWVWMXowS1FmUnFaOTluRjJhNzFiVGdtcC9zd1ZP?=
 =?utf-8?B?MmdxcWZDMmpRYmoxSW5kcWpLRnR4QzdZbG1ScFJUTjZIblVyVnBxeWxESVAy?=
 =?utf-8?Q?h/b7eGoHBloJsCBVuObfv1M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e6ad48-98d1-4848-f101-08d9f1bfb45e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 02:46:31.5085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ikERD7fvUv/rdnlTFsv6Gb8U+2bK9g1e797zD45yAAIkQ7ZV4jxauAy/7ZkWtqTVmHR0bsYKVQFpccApynukg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1586
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgQ2hyaXN0aWFuLA0KDQpNeSBzYW1lIGNvbmNl
cm4gaXMgdGhhdCBhbiBhZGRpdGlvbmFsIHBhcmFtZXRlciBtYXkgYWZmZWN0cyBvdGhlciBkcml2
ZXJzIHdoaWNoIHdhbnQgdG8gdXNlIHB1YmxpYyBkcm1fc2NoZWRfaW5pdCgpLCBhbmQgSSB3YW50
IHRvIHJlZHVjZSB0aGUgc2NvcGUgb2YgYWZmZWN0aW9uLg0KV2lsbCBpdCBhdm9pZCBwb3RlbnRp
YWwgY29tcGF0aWJpbGl0eSBpc3N1ZXMgaWYgd2Uga2VlcCB0aGUgaW50ZXJmYWNlIHVuY2hhbmdl
ZCBhbmQgbGV0IGRyaXZlciBmaWxsIGRldmljZSBwb2ludGVyIGJ5IGl0c2VsZj8NCg0KQW5kIERS
TV9ERVZfRVJST1IoKSBwcmludCBpcyBmaW5lIHdpdGggTlVMTCBkZXZpY2UgcG9pbnRlciwgdGhl
cmUncyBhIE5VTEwgcG9pbnRlciBjaGVjayBpbnNpZGUgb2YgaXQgYWxyZWFkeS4NCg0KQmVzdCBy
ZWdhcmRzLA0KSmlhd2VpDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLb2Vu
aWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPiANClNlbnQ6IFdlZG5lc2Rh
eSwgRmVicnVhcnkgMTYsIDIwMjIgNzoxNyBQTQ0KVG86IEd1LCBKaWFXZWkgKFdpbGwpIDxKaWFX
ZWkuR3VAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBHcm9kem92c2t5
LCBBbmRyZXkgPEFuZHJleS5Hcm9kem92c2t5QGFtZC5jb20+OyBMaXUsIE1vbmsgPE1vbmsuTGl1
QGFtZC5jb20+OyBEZW5nLCBFbWlseSA8RW1pbHkuRGVuZ0BhbWQuY29tPjsgQ2hlbiwgSG9yYWNl
IDxIb3JhY2UuQ2hlbkBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGRybS9hbWRn
cHU6IGZpbGwgc2NoZWR1bGVyIHdpdGggZGV2aWNlIHB0cg0KDQoNCg0KQW0gMTYuMDIuMjIgdW0g
MDg6MjIgc2NocmllYiBKaWF3ZWkgR3U6DQo+IE5vdyBzY2hlZHVsZXIgY29udGFpbnMgZGV2aWNl
IHB0ci4gQWRkIGl0IHNvIHNjaGVkdWxlciBwcmludGluZyBjYW4gYmUgDQo+IG1vcmUgcmVhZGVy
LWZyaWVuZGx5IHVuZGVyIG11bHRpcGxlIEdQVSBzY2VuYXJpby4NCj4NCj4gU2lnbmVkLW9mZi1i
eTogSmlhd2VpIEd1IDxKaWF3ZWkuR3VAYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMgfCAxICsNCj4gICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9mZW5jZS5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9mZW5jZS5jDQo+IGluZGV4IDQ3ODdjYjNhY2FlZC4uZGE1Mzk4M2M5M2Y5IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYw0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYw0KPiBAQCAtNTA2LDYgKzUw
Niw3IEBAIGludCBhbWRncHVfZmVuY2VfZHJpdmVyX2luaXRfcmluZyhzdHJ1Y3QgYW1kZ3B1X3Jp
bmcgKnJpbmcsDQo+ICAgCQlicmVhazsNCj4gICAJfQ0KPiAgIA0KPiArCXJpbmctPnNjaGVkLmRl
diA9IGFkZXYtPmRldjsNCg0KVGhhdCBzaG91bGQgcHJvYmFibHkgYmUgYSBwYXJhbWV0ZXIgdG8g
ZHJtX3NjaGVkX2luaXQoKSBpbnN0ZWFkIGFuZCBJJ20gbm90IHN1cmUgd2hhdCBoYXBwZW5zIGlu
IHRoZSBwcmludCB3aGVuIHRoaXMgaXMgTlVMTC4NCg0KU28gbWFrZSBzdXJlIHRvIHVwZGF0ZSBh
bGwgb3RoZXIgZHJpdmVycyB3aGljaCB3YW50IHRvIHVzZQ0KZHJtX3NjaGVkX2luaXQoKSBhcyB3
ZWxsLg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQo+ICAgCXIgPSBkcm1fc2NoZWRfaW5pdCgm
cmluZy0+c2NoZWQsICZhbWRncHVfc2NoZWRfb3BzLA0KPiAgIAkJCSAgIG51bV9od19zdWJtaXNz
aW9uLCBhbWRncHVfam9iX2hhbmdfbGltaXQsDQo+ICAgCQkJICAgdGltZW91dCwgc2NoZWRfc2Nv
cmUsIHJpbmctPm5hbWUpOw0K
