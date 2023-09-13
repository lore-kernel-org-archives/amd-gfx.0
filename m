Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B22EE3F39
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 00:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4F1210E0CF;
	Wed, 13 Sep 2023 00:54:00 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37D2710E0CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 00:53:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARNMd9Q25K5ov8Zi7AQ91eheEt2/5OjEd9LHIW/N5fdKE6wBwZPTLrS/4lyFV/WYmJB3kAuRqOGxD86TlCDZDVsz3giTE76Ddb6470OrzaEk3tMdAE905cVSNw4ajowBZ3wuw1KFAsV7tj+w2aQGFX2FWlZmAbdS5sW5Akg0t4qSQL7FTJ2ZCU2cCiYHtqybyXNu2XE81QLzUkPhib6FNZzy4U1rq0yoclleRm1f/i7aUA2fC9nJIFv81H7ANM2rKQGFDq26jVM/OVS0WFzPhZ1fFOlHzo26Fnoa4S7EQ7ygwgaH0p79XwmfVd61fxfBDdY4kFaJLu67T5KaCKq2Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltTctI8vX5piSACS2S/k/nK0A8ybng+qnpZrjBxa1eQ=;
 b=oZI8tu8cKn52dhv73fcvNDdaCJjhiHXC/IvKS9FnYOha2+xmk8JOpfYZTfaaFOFcrQN1D6pg9cHkti4k1Jcr9HuAcvVS2y9W1/qVcpsA/9fITuRCo7TLvH9JDaxBSV7eEF6TcpGUX1G2EOJHRE4xHYdhvJ8A6+spjmBbFtRc6DpQ15Ig7PjhHpbX47eX2XhANHMYpKSU5smMThzMhxuJELouwvCTFbpbqGOP2V6KjDHV35M6/5RU+X27xq+HQoo+D6Hwh7Ufuf2v3S4BrjgQNbtetU/0i+dsLS3uQtttN0eBQug7j+kOBntVzv6jXUZ5b1Qq3cPEveo8ivTShMxqjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltTctI8vX5piSACS2S/k/nK0A8ybng+qnpZrjBxa1eQ=;
 b=L7UQs2f0p6PMSz44fv6e8LD+x0fusb5OVxqL8aTB6lyaSoEUB5tS+z0m07StqoriDA7RIFXDwxjlgKcfNu81NV9ooN2UOiwP+ZiZKS8WdYiYvigLtsXPrHKZ9D0p8Kp3f8ox2nmnini9iz8+6wE99aue75//N3X13mKdP7F5zY4=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Wed, 13 Sep
 2023 00:53:55 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::31b9:4cc2:1b9a:3989]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::31b9:4cc2:1b9a:3989%4]) with mapi id 15.20.6745.030; Wed, 13 Sep 2023
 00:53:55 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: fix add queue process context clear for hsa
 non-init cases
Thread-Topic: [PATCH] drm/amdkfd: fix add queue process context clear for hsa
 non-init cases
Thread-Index: AQHZ5XMkxEqviQodZ0qOUDkc78dhGrAX6YeAgAAErIA=
Date: Wed, 13 Sep 2023 00:53:55 +0000
Message-ID: <CY8PR12MB7435E5A7985CB9D26AF0D64C85F0A@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20230912121721.3035694-1-Jonathan.Kim@amd.com>
 <97d7d655-66b8-e117-471e-0785affeb660@amd.com>
In-Reply-To: <97d7d655-66b8-e117-471e-0785affeb660@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=8cd54291-552a-4981-aa21-1b5f0be8aee9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-09-13T00:53:30Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|IA1PR12MB7616:EE_
x-ms-office365-filtering-correlation-id: ec758fe9-9ead-47c4-367b-08dbb3f3e832
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7PbqOaWA63bf7Z+PBqXTmK2ix1Z4ipBvPQYACUCPIntmcIw9SWB+gl19CZKiyKJLo2mcCZP4lekqwpqTH1Rrzq99sv6JlYnHetADkJxSBmkXZT3DdxYsDGpOPjSvKJu7F8NqUyNp2GYJkQGB0969Eq1kdiDjGiaFLoKoBao7N5wQAanUBb5srCRTnYRYumIKQj8Y8v6fVYQUEDoyQRJKTLXkRhh5QLyrPAnfPcMtisXrPhpoPqB+ZqEkxLy9isinxaBo2KPipL1h0gOT4JEcIFcKyDJO29ePQe6EXc0YYmV08pV4yBQ1nf4hy5nc42n/WN4HWMIPlOIoizoyk4ZGsv0VJYdPLkEa+SYuxPWdf+wXLWsfzG0ScOkDfXAhhNR39Z+8Bl1jnL2WTGzhfGA0/KJXHiEeBJnjxn5Csd/HaE2Xc3IzKGQ0gnROMeUZvVL/01HD49R/pGYo0RI/neMz0Mx7X1CeZXEemqYj+Fkgw/EdYpOOIoZULiaMlC7vXbuNn23uVDP6Dy4R8qldWfIgEciBcbO/k9fFfiIUdAgeQvZkEku02qvZ5sOiQ55KFjYDA4xCmrWY2Z1jiM20/FSz3RnuDZuyQCSWWR/iQt9vYhd2PBRz7/n7v3j5084jvzqM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(39860400002)(366004)(346002)(1800799009)(186009)(451199024)(5660300002)(122000001)(6506007)(7696005)(71200400001)(53546011)(2906002)(86362001)(33656002)(55016003)(38070700005)(38100700002)(76116006)(9686003)(478600001)(83380400001)(66476007)(4326008)(66446008)(8676002)(66946007)(8936002)(110136005)(66556008)(41300700001)(64756008)(52536014)(54906003)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEpoOGtqdUpORVJXTy92M3NzTE1HYkRLWTB2V3pnWjZSeWRMT0ZUVnJGWlVX?=
 =?utf-8?B?ZFVWNHplZjVaVkVneTAyczFqQlJoWTNBdWYwRDlZRlRHbDVpVzQ1QW5ncDFB?=
 =?utf-8?B?bEp3YUd3OFE5emcxY2FKb2RlV1MrV0YzOE1jSW5lZDA1Sk9ta0tGdGs2UXlo?=
 =?utf-8?B?QzltaUQxdWUxeTN5a05BMFNINGtzZk96c1NPdld0dFp1RVFYMDJMVHk2Ritn?=
 =?utf-8?B?NEZkWEhRZnA1bGc3aTMvZSthekhRSFJoa1VuWWVNWm0yc3hYQk9CQ2ppSU1F?=
 =?utf-8?B?TTZKbVU4anZoSkswU2gyZG1QN0w3SktTT0tWaS82SE02alZSei9XcExHMUc3?=
 =?utf-8?B?cDd2SXBKa1pnbjFJc1VjVXBvYlRteld4MVBDbU9zUmg1d2g0RUFrbDFLb0tW?=
 =?utf-8?B?a3U0T056ekp5Zmd0dlpsQnVuWXRVWlN0Q1ZHZ3JPUi9CUHBPdS9mVlM1UHZ3?=
 =?utf-8?B?dXdIbVZhVXV2akxLU3MvWkVFSEJadmVqSldoenA3cGRCS2txQWxoclJDSHBs?=
 =?utf-8?B?TDNiK0NkS3ZLTG9GYU9OMFpRcDRkMFA3S3BCa0p2ZjZWR1VsYUhDelN1aDRH?=
 =?utf-8?B?MmpDbXpPTmdqSjUyNnNUdzVqbC9PckRlbnBUY0NsZ3k5bGs4YlBTaUU3SThO?=
 =?utf-8?B?MlpjT3hud1BYeHNhbmRqWjd1R3VGMU9Ycm8yazBXRXJhRUtuN0JEMWQwVG1B?=
 =?utf-8?B?aEdwQzZ4RjhKQ1JMTkEyTnIveVpHdUJxM2Niby9tKzMwdUJ2S0hGTTdzaFRW?=
 =?utf-8?B?WXFIV0xQYXA4QmpwWlplcnQ2bllUVHdZdmc3Z0xpNUlSaGhBbjZnL3NWbUkx?=
 =?utf-8?B?bXRXbVhWcFpXVlE2akdmbEdxejFlZ2habVZaTWgxQjNEMEJrNVZxM3ptcCtn?=
 =?utf-8?B?T2tic0ZsdWhqOFE4UHJoU3VSbExEZUpyZHA0UVFvNlRMS1g5WjdWa1lIdkl0?=
 =?utf-8?B?ci9CdW02OGhkU3NKRGJwMzBlK1BXUDFOdDJBbXB4LzRRTVU5blZRc1RIQ1Bn?=
 =?utf-8?B?cVJDYXFzcUVzMGpHL0pJVGFLQWdvODVMVkZTY3ZvMHhvc1VnTVBEUy8xeTFY?=
 =?utf-8?B?MW5NbE1IdmhjNnV1OGV5SG84T1NMdHJFVTdhR3JZQ2poL3dIa09ZME5IcU14?=
 =?utf-8?B?cnRUdnhJZDVrOFA4elAzaFdjckNvbG1hMkJEMFBaWWhOOE5PeUp0VFo3UzNk?=
 =?utf-8?B?aDZ6MkJ0a1NUUC9Tc0RqRUhwYUxQZkdpTU0xU2gybGxTRFd3SFNzRDhDR1VL?=
 =?utf-8?B?bms2b1dIQ1FoaVBDckZGK0t2Rmg2akhMbWdhNXRiZ0srMDlVRVJ3NHZDTXhp?=
 =?utf-8?B?RUJUdGViV1lEdHkxQzcwRkZvRHVoTmhHS2k3WllPenllSFh0ZFZVU1loTVR5?=
 =?utf-8?B?NU92RlFXS2ZUV0FtL2toOEcxcnRhNTJiYjIybHRNSHlRZDBKak8zd1FYb09V?=
 =?utf-8?B?U0FXc2NTWVpJYk42aDJRdTQ4NmhlcnkyRm9vNWtncTNZWDEwZjk1T2RjNFE3?=
 =?utf-8?B?N3dnY1VSZXN4WWVvV1loSmpiSTJ4QU5wSmtXSDd6UXJSbnlnM0d1emlmQ2dl?=
 =?utf-8?B?UG92cjhFZjd6elNJU3FQajh0Q05ncjlDTjhkcllmWHdySFJNbXdtUnhESjJk?=
 =?utf-8?B?SVlZY1FlcUtqODdRZ2tKL0t0Q2hGUFdvdHlsZUVVTVl4ellyNjR0L3BGakVX?=
 =?utf-8?B?WTViK2o1NWoxcHJZZHpkektieFordStuK1J4N2RHeThPYVhHaTlIQ2FIY1E2?=
 =?utf-8?B?dlRwNHlVMUp4eW1TYjU0ZVVhbVppMXRNSVdKckl3YkdSVjBsRWcyaVpobGl5?=
 =?utf-8?B?eUkxSVllaEZSR2FZdjJIMGpURm4zVk53UW5hLzBYZUkyNlFzV3pDMTMrejd3?=
 =?utf-8?B?RU9NRnJHUG1VWm1QLzlkN3FRRWJlV3pYcEdBcTRqZjg5Mjk3MTdWUFVIOXp0?=
 =?utf-8?B?VzZnQWtYZ244WGd5akR3cXhkZWdLeW1oUHhwK0tlbzBFVFYvYWpacXFxMlcz?=
 =?utf-8?B?T0IxcHJNVEprZHFGU3dDcFZGWFR0dW93YXY3eWhIc3M1cnR3QjJIZy82ZUdO?=
 =?utf-8?B?d29DaHhJV20rUWM5N0ZsdlB4ajdRVVJtM2Y1dUxZZ2YxVWRYWllUUkhaRUpO?=
 =?utf-8?B?d2VCM3paMXVyMTIvSUR4V052RmNSb0Qzdk9zbVNyMk9SNXRYaWdqd0lPRGJh?=
 =?utf-8?Q?WHE9PoqLg+blx2BPYFXxyQs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec758fe9-9ead-47c4-367b-08dbb3f3e832
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 00:53:55.6889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J+MfWnXOO+z9GJtN0wkrTnGy3ONJT6XlP2aziHcFU8weylA0s1lJdGJT0h+QsMas
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616
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
Cc: "Ji, Ruili" <Ruili.Ji@amd.com>,
 "JinHuiEricHuang@amd.com" <JinHuiEricHuang@amd.com>, "Guo,
 Shikai" <Shikai.Guo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLdWVobGlu
ZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRl
bWJlciAxMiwgMjAyMyA4OjM2IFBNDQo+IFRvOiBLaW0sIEpvbmF0aGFuIDxKb25hdGhhbi5LaW1A
YW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBKaSwgUnVpbGkg
PFJ1aWxpLkppQGFtZC5jb20+OyBHdW8sIFNoaWthaSA8U2hpa2FpLkd1b0BhbWQuY29tPjsNCj4g
SmluSHVpRXJpY0h1YW5nQGFtZC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGtm
ZDogZml4IGFkZCBxdWV1ZSBwcm9jZXNzIGNvbnRleHQgY2xlYXIgZm9yIGhzYQ0KPiBub24taW5p
dCBjYXNlcw0KPg0KPiBPbiAyMDIzLTA5LTEyIDg6MTcsIEpvbmF0aGFuIEtpbSB3cm90ZToNCj4g
PiBUaGVyZSBhcmUgY2FzZXMgd2hlcmUgSFNBIGlzIG5vdCBpbml0aWFsaXplZCB3aGVuIGFkZGlu
ZyBxdWV1ZXMNCj4NCj4gVGhpcyBzdGF0ZW1lbnQgZG9lc24ndCBtYWtlIHNlbnNlIHRvIG1lLiBJ
ZiBIU0EgaXMgbm90IGluaXRpYWxpemVkLCBpdA0KPiBtZWFucyB1c2VyIG1vZGUgaGFzbid0IG9w
ZW5lZCB0aGUgS0ZEIGRldmljZS4gU28gaXQgY2FuJ3QgY3JlYXRlIHF1ZXVlcy4NCj4gV2hhdCBk
byB5b3UgcmVhbGx5IG1lYW4gaGVyZT8NCg0KSSBtZWFudCB0aGUgY2FsbCB0byBydW50aW1lIGVu
YWJsZSBlLmcuIEtGRCB0ZXN0IGNhbiBhZGQgYSBxdWV1ZSB3aXRob3V0IHJ1bnRpbWUgZW5hYmxl
IGNhbGwuDQoNClRoYW5rcywNCg0KSm9uDQoNCj4NCj4gUmVnYXJkcywNCj4gICAgRmVsaXgNCj4N
Cj4NCj4gPiAgIGFuZA0KPiA+IHRoZSBBRERfUVVFVUUgQVBJIHNob3VsZCBjbGVhciB0aGUgTUVT
IHByb2Nlc3MgY29udGV4dCBpbnN0ZWFkIG9mDQo+ID4gU0VUX1NIQURFUl9ERUJVR0dFUi4NCj4g
Pg0KPiA+IFRoZSBvbmx5IHRpbWUgQUREX1FVRVVFLnNraXBfcHJvY2Vzc19jdHhfY2xlYXIgaXMg
cmVxdWlyZWQgaXMgZm9yDQo+ID4gZGVidWdnZXIgdXNlIGNhc2VzIGFuZCBhIGRlYnVnZ2VkIHBy
b2Nlc3MgaXMgYWx3YXlzIHJ1bnRpbWUgZW5hYmxlZA0KPiA+IHdoZW4gYWRkaW5nIGEgcXVldWUu
DQo+ID4NCj4gPiBUZXN0ZWQtYnk6IFNoaWthaSBHdW8gPHNoaWthaS5ndW9AYW1kLmNvbT4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBLaW0gPGpvbmF0aGFuLmtpbUBhbWQuY29tPg0KPiA+
IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9t
YW5hZ2VyLmMgfCA2ICsrKystLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYw0KPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jDQo+ID4gaW5kZXggNmQwN2E1
ZGQyNjQ4Li43NzE1OWIwM2E0MjIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMNCj4gPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYw0KPiA+IEBAIC0yMjcs
OCArMjI3LDEwIEBAIHN0YXRpYyBpbnQgYWRkX3F1ZXVlX21lcyhzdHJ1Y3QNCj4gZGV2aWNlX3F1
ZXVlX21hbmFnZXIgKmRxbSwgc3RydWN0IHF1ZXVlICpxLA0KPiA+ICAgICBxdWV1ZV9pbnB1dC50
YmFfYWRkciA9IHFwZC0+dGJhX2FkZHI7DQo+ID4gICAgIHF1ZXVlX2lucHV0LnRtYV9hZGRyID0g
cXBkLT50bWFfYWRkcjsNCj4gPiAgICAgcXVldWVfaW5wdXQudHJhcF9lbiA9ICFrZmRfZGJnX2hh
c19jd3NyX3dvcmthcm91bmQocS0+ZGV2aWNlKTsNCj4gPiAtICAgcXVldWVfaW5wdXQuc2tpcF9w
cm9jZXNzX2N0eF9jbGVhciA9IHFwZC0+cHFtLT5wcm9jZXNzLQ0KPiA+ZGVidWdfdHJhcF9lbmFi
bGVkIHx8DQo+ID4gLQ0KPiBrZmRfZGJnX2hhc190dG1wc19hbHdheXNfc2V0dXAocS0+ZGV2aWNl
KTsNCj4gPiArICAgcXVldWVfaW5wdXQuc2tpcF9wcm9jZXNzX2N0eF9jbGVhciA9DQo+ID4gKyAg
ICAgICAgICAgcXBkLT5wcW0tPnByb2Nlc3MtPnJ1bnRpbWVfaW5mby5ydW50aW1lX3N0YXRlID09
DQo+IERFQlVHX1JVTlRJTUVfU1RBVEVfRU5BQkxFRCAmJg0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgKHFwZC0+cHFtLT5wcm9jZXNzLQ0KPiA+ZGVidWdf
dHJhcF9lbmFibGVkIHx8DQo+ID4gKw0KPiBrZmRfZGJnX2hhc190dG1wc19hbHdheXNfc2V0dXAo
cS0+ZGV2aWNlKSk7DQo+ID4NCj4gPiAgICAgcXVldWVfdHlwZSA9IGNvbnZlcnRfdG9fbWVzX3F1
ZXVlX3R5cGUocS0+cHJvcGVydGllcy50eXBlKTsNCj4gPiAgICAgaWYgKHF1ZXVlX3R5cGUgPCAw
KSB7DQo=
