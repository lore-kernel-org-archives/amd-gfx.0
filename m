Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B19C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 14:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32B4A10E183;
	Fri, 20 May 2022 14:49:42 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2087.outbound.protection.outlook.com [40.107.101.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73B7710E183
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 14:49:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7URQFpkfgc6Mm5RtMoiXgvWu1K3PHK1qkz5zToSNL6dISkPn60jkmbYDfvWPFwUBpc6YHgPBAlgzxadoV46GIDCnWBrR3TfoHCIIvGp6wyPhoDltBGQ5xR0ebX9TorgAxGXxd8H3YQYYgRREHDLcS0fVLJQlg2//PLtFMsADLnI3ukfF/gyTnuodSBKm1m/Au0yCnYJ6CIQxz90s5WVcaKbQlT2wbbBq8WOIL9ZybNrjXe4fFoGVs2J0NWrY/CHrqO+HzDnSsyCR5D+LY7mV74F6AZRAQb+7QatHM4BLIEc+P3k5pDd3t8odnRJUS8N2MhsfudccvEpvIcAwjdyHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3iSSeCyDlXqhavnDKQdQyKaLt1BzqVLASazmV3TaE0=;
 b=NCB8OUTHY3StBVoh/anhUbJbruG/0yXxenafcwGQ2I8e/KNDEE/9jikOoPwP8fu0fnBgfdNOXnC8GAUk2NWePUHzuaXDm6LhNyw0y9gpJZFwM0OKRwsSKkRIkUaLeN8W+Hywfw5fsy1nsqzi8K5Pg3mp/afQGCXSoJCOXDfXoOb160lAPm/UzqP7PiXrI5YsyvnvunZ9OTw/q1Zgw4cZZ7cYn992KfJ3yLxPUHdNvMvemXbccP0Z4ItY8yLPM0Y1WnuRlvupbPi4BQesNowbFLCDdGYz8bXnCjmaaODOp1m24SH4r+eFMkav5USWpJz9xuBgG5oTeMPC7JgLPcMIyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3iSSeCyDlXqhavnDKQdQyKaLt1BzqVLASazmV3TaE0=;
 b=QF5QjuGOGSDg/TpekuA7NjgHaZ/oiXeRK03AH2oGPgHASwFC83ZXeukGcRjGxmwdvDJmWA0A8H5SqlEghZZTAVJT/CMuaf72pBQzc8qu3cG5CzBfaxCf13segdS9GpMUTiDPGwqYJmWnFGNUt4kjb1eHwRdP4mGosD6o2K+EC6w=
Received: from BYAPR12MB3094.namprd12.prod.outlook.com (2603:10b6:a03:db::23)
 by MN2PR12MB3549.namprd12.prod.outlook.com (2603:10b6:208:107::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 20 May
 2022 14:49:38 +0000
Received: from BYAPR12MB3094.namprd12.prod.outlook.com
 ([fe80::b08e:4c04:5879:dbf]) by BYAPR12MB3094.namprd12.prod.outlook.com
 ([fe80::b08e:4c04:5879:dbf%4]) with mapi id 15.20.5250.021; Fri, 20 May 2022
 14:49:38 +0000
From: "Slivka, Danijel" <Danijel.Slivka@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: Skip init fbdev if virtual_display is enabled
Thread-Topic: [PATCH] drm/amdgpu: Skip init fbdev if virtual_display is enabled
Thread-Index: AQHYbB+SK0uoad3LWUmZOOWrvQVkA60nwwaAgAAFOeCAAAxlAIAAAqww
Date: Fri, 20 May 2022 14:49:37 +0000
Message-ID: <BYAPR12MB30941FC0900BB87D03F2C20898D39@BYAPR12MB3094.namprd12.prod.outlook.com>
References: <20220520075932.186691-1-danijel.slivka@amd.com>
 <CADnq5_P8p5zKiW20xek0M0DVs+YRDX6qcy+b01NWXP_NUs9O5Q@mail.gmail.com>
 <BYAPR12MB3094F87BED21F64FE5BD4C4798D39@BYAPR12MB3094.namprd12.prod.outlook.com>
 <CADnq5_PArQi9FdOufwO7XnHXf85euPN_H_3hvqyJYUW47nHFCg@mail.gmail.com>
In-Reply-To: <CADnq5_PArQi9FdOufwO7XnHXf85euPN_H_3hvqyJYUW47nHFCg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=81a8f669-66e3-4a1b-8fc8-98c05db3dc78;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-20T14:42:07Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc7d2c71-fe7a-4436-2452-08da3a6ff6a5
x-ms-traffictypediagnostic: MN2PR12MB3549:EE_
x-microsoft-antispam-prvs: <MN2PR12MB354904A1D80E6891F06FE26B98D39@MN2PR12MB3549.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sDYph2pvevZ6mxq74vTEYLe27GyK61wsCsrT+evofwIBZh0jdbVw8XN/UzWTpd9JAUaMGNSCbCWTAyCSkY0wKzWojpVVvTpPcmUEWoz+S2s2I5/bGJtm8ppDbeuI3E3fofxkyJ/hsoPt4ZCVduvknuZlSYiwMALJVz4jy4wlvvQzS4dbbDyyS/n6dB/7LQBlGRUrsP7c12NumpRcX2P1/UzK+tSFPaKc5wgTJQU7X2oK1+dzvDFSibUyjL4UPJyk9Q5VyFJkDd72gBll7+tX5SSCzIbtsfYsPthB/NUZacHvOwcKPIvMz5+ivlw7nYJu3WhK6fay380hGD6kHutqF/keXUheCR4wB5mVLToVQgyZeEjAdy8xS+SgcEH6dUb7CZn4M8ZCXSFwiI7vNbdnX7XBBqBkGGcBpOi1jTrhhugwiQEIV0WX1KcdkCTZRup/cN7rAOcWCk4FEBrykRR59HXDmZgFkCLnAZba6YM/IJj50CvLwsuBusTML9eQ8cDfZlIriLPd7GW20RXTGth1Qut4qm4vBNECQs0f7SbymUe/eb4mZj8t+lwRkzZPHEyHNXgAgVmuckfevsQCnrgRc3wlbxWaga8s1olYnAko0Y9P4I4XSPM/yeUV7rBSPyavfBKUoRWu54npbaui7R8cuDOEo6EW0eID0qf67ieQAni4YzJ4iGa+ESlRAlTg1hLN3yF8SG7crVrEFtqeJd3wQg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3094.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(186003)(8936002)(508600001)(53546011)(52536014)(71200400001)(66446008)(64756008)(38070700005)(66556008)(26005)(33656002)(55016003)(5660300002)(4326008)(76116006)(8676002)(7696005)(86362001)(6916009)(66476007)(66946007)(2906002)(316002)(9686003)(6506007)(83380400001)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEcrc3pwcnRRZC9xbUVpamw4NG1vVllDL3p5NDk4ZWlXeEp4Tmtra01BS1RZ?=
 =?utf-8?B?TGoxdC9YbFZPWlB6RjhMOHQ5d01hdjVwVStaODVpTUNmWGF4N2wxUHoyVlAw?=
 =?utf-8?B?TmY5OGpHdHNRcVpjLzhBdzNsQkJaeG5hajJCQjRaUitJYzFTTSsweEwyVEl4?=
 =?utf-8?B?NkFNNjNGQUY3M1NFSEVzRjhwakhvUnV0TVJ1UHBlOWRydHltTEtXOWNiaWJM?=
 =?utf-8?B?Z25ySWsxY2pKWkZHK3crc1RPWEVBb3ZQZ0EwRXh5eFhZYklVaStOSUNST2FP?=
 =?utf-8?B?blRQNFhnMlo3V3QwaXR1RThaNnZBcVdjaXFTNWlMLzV3YnBSbCs2Zk9INFhF?=
 =?utf-8?B?VXpUYVdWd09HNkJrQkFJT2JOYUdWZ3NGUUgveHdrTkpBMTFoTXdpQUk4Q0Z4?=
 =?utf-8?B?NGF5aTQwWG15clBBRFJIMHZDajl6VmdCZnZtN0dHZmRRQjlCcnJFQmdKL09J?=
 =?utf-8?B?K2hMVTBRNC8zREVkR3o0b20vZHFkaCsyUGF5dDdmMWZ2cVVlN2UwbmdRRWZF?=
 =?utf-8?B?SnBDVTBJckpFR09PaituaXNCUWIyOG9TTDVCRkZrSk1XM2ZScFlsc01IZkJw?=
 =?utf-8?B?a3prR3NqeDVOc0ZSdFFTb3lHSm5wRm5xYVFnTStYNVBKMlpMdEYvRHgxam5P?=
 =?utf-8?B?YXo2ZnpiZzJYZVZ5cThOeUtuV0w1dFFSZFlJbG5oa25lZ3hoQnJvOEdUMHBQ?=
 =?utf-8?B?cUhrR1UyTlp4WTFObU9raWN4cXVsMVhoc09EcDhoY1VIVkVtQjNia1p1d3hJ?=
 =?utf-8?B?bWw4aFVkUjkva2Y1NWQxdThmSTBWNWwxUzBMc2pOL0hBckZUdm1PTS9rdytB?=
 =?utf-8?B?NFNqUVhleW1ySUUyejRrTnBRK0lUdmhKQldReHhhaGxFSEc0OXpkbkRaMGk5?=
 =?utf-8?B?Q2pRSlRFcjY1RnFoSEJWRUI1aXN6ZndZeUgzTTVIbWQ5TFlLbTJ0djhSUDI5?=
 =?utf-8?B?MmpMZDZhN3JZVkZCMGk4UEp2WDV2alA0TXNaVGdoTzlCUmJPaURvQXhsTHlU?=
 =?utf-8?B?MkZtNjlnZ3BkWEpoaTFkYXVlSi9ESTgxOUpYL2w2eXVvK2NYNkZWM0RYNStH?=
 =?utf-8?B?dGVyWXovcTBoRkJoM0YvQjRiV0ttc0F3ZmU4VkoxVWNqOFplcEVSeEh6K3dk?=
 =?utf-8?B?Vkw3K2hSenFWSjYyR3VNNlpkUFJWdTVhRnB6TURIQmdJV3NyRlRKdE1iYW1N?=
 =?utf-8?B?bm84enRWZ2x2RzdzMkNYdkdMbzROVU13cC9nS0VUZTZYZjFrVFZTaFdCNTRQ?=
 =?utf-8?B?OUphNDZ0Q1czaUVQTk1tMFZiQlBqNGZWTEcxRzBVaHJrYzhCRU9jREIxQkJv?=
 =?utf-8?B?NGZyQzVKSmJKSnVXaEk1MlVaNzFUZE8wYUJObXpqMG9Tbm51UnMvM3lZanIr?=
 =?utf-8?B?L3YvaTJscWRFWW1FSW55Y1lra3ZVUUc4TVpXd2xXOUpqREtGQkY0NGNDamcv?=
 =?utf-8?B?ejlLSC9tL1ZOQmZNVy9wcWloNk9pRTBsanZhdEhDNzQ0WGFHN05OY3J1dzBT?=
 =?utf-8?B?UWdVekVLZURvM25WUkRkSDJvclZMSk9YRnR5dVVXTUpjbmk3T0t2aHV0Tzdj?=
 =?utf-8?B?SXNONUZNLzNsYm42czAyQ0tXVEFQb1JEeENGTjB5MkMrQ0h1UHZ4MVZhZGhx?=
 =?utf-8?B?d2RtOW5LYnN2LzlQelNPUFQ5ZXJjQlh2eW96dXBUWHZtZWVsaDZTQlRJeEtn?=
 =?utf-8?B?UjdXN2lQcjlQQldOM0FqR004bnhBRGpLWW5IVXhvdnZaQjduTExZd1lPZkhu?=
 =?utf-8?B?a3QvOVFLN0hiUUxzNnlLREZjSE8vYmNQWGZyTDFXQ1RaNjRCbXcyWUJnNDBv?=
 =?utf-8?B?cDZqZkp3dUtvRVlDMXpRNlVsZm9sOTdhTkJnMzZHaFNnMklBQW44Y09rV3N3?=
 =?utf-8?B?T3ZXdHpCVk5tbVkrdC9sUHM1VlY4REUvbWVJL0c4cXV5eWdUUGx6c1RFKzFZ?=
 =?utf-8?B?eVVrb0VHK3JlMzZJV1RZT0JiTDBJaGdITUxMaHFHM0NldTFhYmlOdWdQZDNQ?=
 =?utf-8?B?TG5EVFBsc3QyTmViSW1oM21VczBzTGRqUCtaQmlyODRIZUlRVlV4eEhWMkJV?=
 =?utf-8?B?UTNHZEpxaFVZeU1DSnAzUUlJVE16T2Q3VlFxQWRyUkJLeFQ3RllydjQzRU5t?=
 =?utf-8?B?dUlHeW81a2hiQ20wZnhXNytjeHAxcE5acmZKWjBlVXRLdlh6NmRmQUZwN1NL?=
 =?utf-8?B?c3dKMTdBV2tBaFJWYlNZUlhJR0QzVDJxQis5T2ZFVEltS2R6MEp6UGxYNXAr?=
 =?utf-8?B?eTJuKzR1OGxTWUZvaEx0ZXhSVU9MdFovb3RTSXZvYllMQ00wd2M2V0RYVjBm?=
 =?utf-8?Q?34BZEjqF2otB8HW475?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3094.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7d2c71-fe7a-4436-2452-08da3a6ff6a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 14:49:37.9520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aza77xwI9mPM1K6keWtK1BrJ21f5gtQKyXJXKC9PcJiJyOYmEUQherlYLxjkY44RoS9+TyrE22X6dPGH2caVCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3549
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkJ1dCBmb3IgdmlydHVhbCBkaXNw
bGF5IGVuYWJsZWQgd2UgYXJlIG5vdCB1c2luZyBkaXNwbGF5IGNhcGFiaWxpdHkgc28gc2hvdWxk
bid0IGl0IGJlIGNvbnNpZGVyZWQgYXMgaHcgd2l0aG91dCBEQ0UuDQoNCkJSLA0KRGFuaWplbCBT
bGl2a2ENCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFsZXggRGV1Y2hlciA8
YWxleGRldWNoZXJAZ21haWwuY29tPg0KU2VudDogRnJpZGF5LCBNYXkgMjAsIDIwMjIgNDozMyBQ
TQ0KVG86IFNsaXZrYSwgRGFuaWplbCA8RGFuaWplbC5TbGl2a2FAYW1kLmNvbT4NCkNjOiBhbWQt
Z2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPg0KU3ViamVjdDogUmU6IFtQ
QVRDSF0gZHJtL2FtZGdwdTogU2tpcCBpbml0IGZiZGV2IGlmIHZpcnR1YWxfZGlzcGxheSBpcyBl
bmFibGVkDQoNCk9uIEZyaSwgTWF5IDIwLCAyMDIyIGF0IDEwOjEyIEFNIFNsaXZrYSwgRGFuaWpl
bCA8RGFuaWplbC5TbGl2a2FAYW1kLmNvbT4gd3JvdGU6DQo+DQo+IFtBTUQgT2ZmaWNpYWwgVXNl
IE9ubHkgLSBHZW5lcmFsXQ0KPg0KPiBIaSwNCj4NCj4gQmFzZWQgb24gdGhlIGNvZGUgd2Ugc2hv
dWxkbid0IGluaXQgdGhlIGZiZGV2IG9uIGh3IHdpdGhvdXQgRENFOg0KDQpUaGF0IGNvbW1lbnQg
bWVhbnMgZG9uJ3QgaW5pdCBmYmRldiBvbiBjaGlwcyB3aXRob3V0IGRpc3BsYXkgaGFyZHdhcmUg
KGVpdGhlciByZWFsIG9yIHZpcnR1YWwpLiAgRS5nLiwgaWNlbGFuZCBvciBNSTEwMC4NCg0KQWxl
eA0KDQo+DQo+ICAgICAgICAgLyoNCj4gICAgICAgICAgKiAxLiBkb24ndCBpbml0IGZiZGV2IG9u
IGh3IHdpdGhvdXQgRENFDQo+ICAgICAgICAgICogMi4gZG9uJ3QgaW5pdCBmYmRldiBpZiB0aGVy
ZSBhcmUgbm8gY29ubmVjdG9ycw0KPiAgICAgICAgICAqLw0KPiAgICAgICAgIGlmIChhZGV2LT5t
b2RlX2luZm8ubW9kZV9jb25maWdfaW5pdGlhbGl6ZWQgJiYNCj4gICAgICAgICAgICAgIWxpc3Rf
ZW1wdHkoJmFkZXZfdG9fZHJtKGFkZXYpLT5tb2RlX2NvbmZpZy5jb25uZWN0b3JfbGlzdCkpIHsN
Cj4gICAgICAgICAgICAgICAgIC8qIHNlbGVjdCA4IGJwcCBjb25zb2xlIG9uIGxvdyB2cmFtIGNh
cmRzICovDQo+ICAgICAgICAgICAgICAgICBpZiAoYWRldi0+Z21jLnJlYWxfdnJhbV9zaXplIDw9
ICgzMioxMDI0KjEwMjQpKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBkcm1fZmJkZXZfZ2Vu
ZXJpY19zZXR1cChhZGV2X3RvX2RybShhZGV2KSwgOCk7DQo+ICAgICAgICAgICAgICAgICBlbHNl
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGRybV9mYmRldl9nZW5lcmljX3NldHVwKGFkZXZf
dG9fZHJtKGFkZXYpLCAzMik7DQo+ICAgICAgICAgfQ0KPg0KPiBGb3IgdmlydHVhbGl6YXRpb24g
d2UgYWx3YXlzIHVzZSB2aXJ0dWFsX2Rpc3BsYXkgYW5kIGRvZXNu4oCZdCBoYXZlIHRoZSBodyBE
Q0UgZm9yIHRoYXQgcmVhc29uIHNldHRpbmcgdXAgZmJkZXYgc2hvdWxkIGJlIHNraXBwZWQuDQo+
DQo+DQo+IEJSLA0KPiBEYW5pamVsIFNsaXZrYQ0KPg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2Vu
dDogRnJpZGF5LCBNYXkgMjAsIDIwMjIgMzozMCBQTQ0KPiBUbzogU2xpdmthLCBEYW5pamVsIDxE
YW5pamVsLlNsaXZrYUBhbWQuY29tPg0KPiBDYzogYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogU2tp
cCBpbml0IGZiZGV2IGlmIHZpcnR1YWxfZGlzcGxheSBpcw0KPiBlbmFibGVkDQo+DQo+IE9uIEZy
aSwgTWF5IDIwLCAyMDIyIGF0IDM6NTkgQU0gRGFuaWplbCBTbGl2a2EgPGRhbmlqZWwuc2xpdmth
QGFtZC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSW4gY2FzZSB2aXJ0YXVsX2Rpc3BsYXkgaXMgZW5h
YmxlZCB0aGVyZSBpcyBubyBodyBEQ0Ugc28gbmVlZCB0bw0KPiA+IHNraXAgc2V0dGluZyB1cCBm
YmRldi4NCj4NCj4gV291bGRuJ3QgeW91IHRoZW9yZXRpY2FsbHkgc3RpbGwgd2FudCBmYmRldiBl
dmVuIGlmIGl0IGlzIHZpcnR1YWw/DQo+DQo+IEFsZXgNCj4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IERhbmlqZWwgU2xpdmthIDxkYW5pamVsLnNsaXZrYUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgfCAxICsNCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gPiBpbmRleCAzYjlkYzE4MDNiZTkuLjhkMDNlZWM0
OWVlZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZHJ2LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMN
Cj4gPiBAQCAtMjA5NSw2ICsyMDk1LDcgQEAgc3RhdGljIGludCBhbWRncHVfcGNpX3Byb2JlKHN0
cnVjdCBwY2lfZGV2ICpwZGV2LA0KPiA+ICAgICAgICAgICogMi4gZG9uJ3QgaW5pdCBmYmRldiBp
ZiB0aGVyZSBhcmUgbm8gY29ubmVjdG9ycw0KPiA+ICAgICAgICAgICovDQo+ID4gICAgICAgICBp
ZiAoYWRldi0+bW9kZV9pbmZvLm1vZGVfY29uZmlnX2luaXRpYWxpemVkICYmDQo+ID4gKyAgICAg
ICAgICAgIWFkZXYtPmVuYWJsZV92aXJ0dWFsX2Rpc3BsYXkgJiYNCj4gPiAgICAgICAgICAgICAh
bGlzdF9lbXB0eSgmYWRldl90b19kcm0oYWRldiktPm1vZGVfY29uZmlnLmNvbm5lY3Rvcl9saXN0
KSkgew0KPiA+ICAgICAgICAgICAgICAgICAvKiBzZWxlY3QgOCBicHAgY29uc29sZSBvbiBsb3cg
dnJhbSBjYXJkcyAqLw0KPiA+ICAgICAgICAgICAgICAgICBpZiAoYWRldi0+Z21jLnJlYWxfdnJh
bV9zaXplIDw9ICgzMioxMDI0KjEwMjQpKQ0KPiA+IC0tDQo+ID4gMi4yNS4xDQo+ID4NCg==
