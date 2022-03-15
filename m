Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9DFC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 07:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF48110E410;
	Tue, 15 Mar 2022 07:07:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 049CF10E410
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 07:07:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bk5EnJ7P2ICvzSLWFyXHkOc376Qo/cVGKmUvaZA9l5N9/qAtyhpUgwQETmTlSMTpEP9aVcz0PaNkcVY6sfPHKB3QdwkDI9j/eRkJQBk14thUw/NxTd6DcGQLUiIPbTJId8JAd35D0o8vF8DaOPXBD1thJ7b+bV7G46ANIMKlUc+iSfar0m3hFiNg1D1pJ8OenUFv8gcBMKuuzFHx2y/9q99R/PG56oXycAHYWoNt52G/Zje+buVRg4rVSlPZvNW4CvlR3bSrmnXf5wGllKpfvu6wkf5ONp9w8JA2wViY91I3FCHqx8n1CP4rFur0N0txvHiaJzIlNGYr9TmswRFVoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e35Aq1zwrVxhDk5o4aQMcEOS1wI8UW8onaApRvLIzuk=;
 b=AxF25/UpxTDc/S0MKTTXBTVCuaitkdfREpesSP1uqT1U6vQg6waedgxJyDF0ZY6hd8eJENd54U60Agl5luX5j1cYdbcGsrKRMMHEV/akq5VA9cr7HoSlU2I1tZwp10XXZD4QO03LDYI7aZUIVip7XL/2k3nZqH4220GayrskDKtnDhzckgj0Dr40gkKT+j5UMaPs1axB9PxZLOnpz/lIG4p8N1OSTEbDJ2NT1SyTjJdgm5H7YwEHTEc3+vOQ6a2Fucm0BgSHXKp/Gd+/JoAFDV2Grvk+iauALCJUw3QAKlRg9QOoEAX/dy3vHf3De8UVHWpRFjukOj75Lyx7Ia4f4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e35Aq1zwrVxhDk5o4aQMcEOS1wI8UW8onaApRvLIzuk=;
 b=cDD69KtT+0gu2eg65QhbADga8nMzBMPxbJpTJZqS6SpNj6zzsaVkG/aKzCjZjiNjz5ldOA82s9O/JMSd9eFZHpwxkArw2wBCVrkR1cdk1Tz8PXUWYKjDu/2WT6WuqyAwL9Mcyfh2MypChZMkjY+seVFYfY/VgsibowdQSOgz0ec=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by BN6PR12MB1763.namprd12.prod.outlook.com (2603:10b6:404:107::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 07:07:35 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 07:07:34 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: add utcl2 RAS poison functions for
 Aldebaran
Thread-Topic: [PATCH 2/3] drm/amdgpu: add utcl2 RAS poison functions for
 Aldebaran
Thread-Index: AQHYN3GmE9fMh3tCMUygOm3tK5tAy6y+oQqAgAFmP9A=
Date: Tue, 15 Mar 2022 07:07:34 +0000
Message-ID: <DM5PR12MB1770C7A7061902C1F8874573B0109@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220314070326.21828-1-tao.zhou1@amd.com>
 <20220314070326.21828-2-tao.zhou1@amd.com>
 <5ddd921e-1345-526c-2fbe-3662fd8a05f0@amd.com>
In-Reply-To: <5ddd921e-1345-526c-2fbe-3662fd8a05f0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-15T07:05:44Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=78e708f4-19f8-4296-a2f7-41037375d231;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-15T07:07:30Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: e331f89c-768d-4cdf-affc-12546f2fdf29
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdbabac1-e148-47a3-3208-08da06527b14
x-ms-traffictypediagnostic: BN6PR12MB1763:EE_
x-microsoft-antispam-prvs: <BN6PR12MB176302B056EBD52D897D2ACEB0109@BN6PR12MB1763.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AgTtuk/oWAQH+ckOfWdMZJP7K3RF99paxwgLa7N7URrMeZBpHxSmtc3i3B7L3DPK2A45GeIh78gtcBeP7cTwKeV/b0UZEkwL9orSAdR8al66WbqYlIm9Mj0COCLiwrVfHC7TvD5Y0Ke/mGTh1J4551bqU2OEbmadl+xN5o7ZotAFNfpyMPAVGCAW+mZoSXSDCuLzgaXsC2+9u5zJRD4kdVzIavmwmiRMQzBKYLm8bKXqALKa5p01mIKfjQbFYBfcG4j3XBUU5b4tPrYut5yEw9X0aL7zz7dXTlxadI4iRJaDNeqA2GVATF915HLis1jhv94/gASvvRx0Bf9w8vqIAmZg04Yne50FzlSB77/W68yCoVf0HS19II7wm4rff/Eql6sxeP90svg9Adcgz2leOQulQRCo1R4njV+kdWCWzOWSEjRGwsUnc/TAs2TfX14BDdlNKibATZ5ilnnoAXNBCAezWlaeB/RxMYhz8GHRL4eoS55ik90d42OAartXn/uxRM1vkbN0sSFMyblwrvNT1GzDPufSzmd/AR/HIhD1+aZ/0tdJ6t+l3/uTHQf1RKx25pJdWGlsZOq+pKF5CYXs1Rz3pjzshMKbJJ4ELZEn323C2ZC7BAhrGKKEZuxivdkuv9FKnMw9ZNP98Hk0ODQLHdXSSSV5E0dItqd+WfdXeCtOVmVh4dDkS95tgjourTkNhZGGySPdMLd+lnanG5FfrA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(26005)(83380400001)(38070700005)(8676002)(71200400001)(508600001)(110136005)(66446008)(66946007)(66556008)(6636002)(316002)(66476007)(76116006)(64756008)(7696005)(53546011)(6506007)(38100700002)(5660300002)(8936002)(122000001)(33656002)(2906002)(86362001)(55016003)(52536014)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWw1ZlNLc0cxbGM1anhZc2ErcU9iQzhLRjUzY2duaU9aMTF2SnNVUmp5NE9k?=
 =?utf-8?B?b2ZrUE9oMjFxTENYQ1MweDF3RWM4ZC81M3lGZnV4RDJuQkFaTHJXUHA0YkFm?=
 =?utf-8?B?cHFXaWR4SDVNdFJ1RGtSRTRPYVdlVFlmN3pCemxETWFmanFMMVZIWXEzK2pn?=
 =?utf-8?B?cnpFQWtWeUIzUUpLQnlqUXZqcXorVmVNci9VRy9ZNDB5MWZtd3FQYlFUZk5Y?=
 =?utf-8?B?Wnp3NWJYTmwrc29vR1o3TUVYNUtFNi9tdkk3QVNQWUVZLzBXLzJNdkVwazZ1?=
 =?utf-8?B?aitpMnlOU0Y4M1ZhdDhzSVJlaHczUnhPQzhiT1kyaXVTT1FUVHY3ZHdNSEVx?=
 =?utf-8?B?WWppUlR3UXRkcHJhSmRkRUl3RlRFNm4wMFFLQUxMYUkzVXRDZ0lZOFpkTS92?=
 =?utf-8?B?b1Q5V09rOG16UG9FMjg0QlkrU1Nrb0JIZ0N6ektwT1NIejVsQ0JKRmllS0I3?=
 =?utf-8?B?Wi9KclBsN2ZNOXFXUTJ0Z1h5b3hCV0x1QVpBNE5KdmRBbzE1eHhXMXc5Z3VX?=
 =?utf-8?B?SDkvbURRdWdtVXovWGhPb2s1R3FISlFxTURQM1BWWlBOTXFOZUczWGo3VVhS?=
 =?utf-8?B?UHl3Tm9GRUo3c2h3RFVXK2FFUlRTTEplWTNVZndlOWlKS0NodjhGbWNMZUV2?=
 =?utf-8?B?T1lQOFhkdE42RmtaUXlpS00vdHB2V0ppTS80L2JVOEpoVmxsOHVjaDlIUWZL?=
 =?utf-8?B?THJEcFRMV1BvdlU5amYvdzN3OWxEQ21QbGovZldtRjJvUUZINjhaSDkvRTQy?=
 =?utf-8?B?R3VtL1lMV1ZxOVExSkFtMkxVUnVuNnNIbHlUQ3U1RVFQQkdyelpVQ2lFSmtk?=
 =?utf-8?B?MjU1L2IvT0dYVzM2dVZnaXNKNWZoNFh3ajRtNVphQmhCVDN0UUZOTXJnSW5E?=
 =?utf-8?B?bVdNc3RUVUJyNDFjbFlKMGdhVThrMDFuaHpMTmJrdHFQWnJheDBFcnBvajNS?=
 =?utf-8?B?UitCaFE1NFYzbGNaZkhwV2tBNGVpcXFpKytMckZSOTVaOVdpOHVnbk5vMmRK?=
 =?utf-8?B?SjZReXM0Q3pkZTdlRkhJaXZnZTA3TjNlaUh6ZU1VaktNOTJaRVNqYUowUlk4?=
 =?utf-8?B?by9xaCtKSlc0K2xoVndzUVJxeHh4b1FmNmRsZlkyUmI4d2lxSjFUZllML3li?=
 =?utf-8?B?UHk2ZVR2S1ZERXlOTWJIRUhDUEJJajdndU14bmVuMmludjhNay9aMTZlTFAw?=
 =?utf-8?B?VXcrRWNiak1rR0tJSFFYSFRjRDdDN1o0LzZhSUdIYUNOdFlNaDVaSFdCOXFL?=
 =?utf-8?B?QitONUt2OGVTWGgwc0I4Sm1FUzgwRzZlRkh0U25XK0FkLzNvalpOSWFmelJP?=
 =?utf-8?B?U2lqUkFaRE4wV2ZGckZRTkVVOW4wS1kxQXA5Tk83a3pqcHhuUTZMU2ZobC80?=
 =?utf-8?B?L0VycmlPYlgzM2NER1pnL2hwak5aQjQ4a3BIWFNoV0x6NW93ZkYvTEtiMWpX?=
 =?utf-8?B?VzdrbVZTUDFFM2JPN1lNNENyWDVZc1FsY2YzN3VNbHc5dDdKZStIenNicnBv?=
 =?utf-8?B?cUsyOEVubDhrRGRVcTBjWWpPQXcrSjZ4ck1yaEJGSHp6UUtzSEJ4OWNZWmsx?=
 =?utf-8?B?QW5KQ3pCUS9zWk5FU2hNbDVqUVJZTzhqWXNid1lnOWtta0ZYZDFtNE1aM3Vi?=
 =?utf-8?B?emNOOUVLdThLeXg4QVRLamJYY1FDSHliTzVpaVhCZXhjbUg5bG5yL2dsbmZn?=
 =?utf-8?B?cHc2WDdmOVJDRk1FRjhYc1NVZXJ0ZUszbGQ1U0FQK2JLZ2psODlBZWM1SUFS?=
 =?utf-8?B?NDJ4ZFpXTTUva1ZEVzdRWGtlZ1RleFZ5VVQybVdxRGxPMUtIcXZIMGMxZUZy?=
 =?utf-8?B?NTF2UVBER1Rrei9PYlorWU9YL0NWV3JtOHM0Z1BId08xZkRzQWpNMWdkdUNn?=
 =?utf-8?B?M0tvU1lsZ2ErWmpjYU9GdGJVT1Fld0FHQkQ4OXJINnh4b3cveERyOW5yU0xw?=
 =?utf-8?Q?RgqSW77oao3iL9fb39/hV9i/XNlTpKMS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbabac1-e148-47a3-3208-08da06527b14
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 07:07:34.6477 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0+on4DOS+3nS0UDdNrY8G1XuFCgIrH2Jag0/7xGRxJ/e9Zfrm5adQA0iok4hTKw4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1763
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBNYXJjaCAxNCwgMjAyMiA1OjQ0IFBNDQo+IFRvOiBaaG91MSwgVGFvIDxUYW8uWmhvdTFA
YW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaGFuZywNCj4gSGF3a2lu
ZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgWWFuZywgU3RhbmxleQ0KPiA8U3RhbmxleS5ZYW5n
QGFtZC5jb20+OyBDaGFpLCBUaG9tYXMgPFlpUGVuZy5DaGFpQGFtZC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggMi8zXSBkcm0vYW1kZ3B1OiBhZGQgdXRjbDIgUkFTIHBvaXNvbiBmdW5jdGlv
bnMgZm9yDQo+IEFsZGViYXJhbg0KPiANCj4gDQo+IA0KPiBPbiAzLzE0LzIwMjIgMTI6MzMgUE0s
IFRhbyBaaG91IHdyb3RlOg0KPiA+IEFkZCBoZWxwIGZ1bmN0aW9ucyB0byBjaGVjayBhbmQgY2xl
YXIgUkFTIHV0Y2wyIHBvaXNvbiBzdGF0dXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUYW8g
WmhvdSA8dGFvLnpob3UxQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gICAuLi4vZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZF9hbGRlYmFyYW4uYyAgfCAyOA0KPiArKysrKysrKysrKysrKysrKyst
DQo+ID4gICAuLi4vZ3B1L2RybS9hbWQvaW5jbHVkZS9rZ2Rfa2ZkX2ludGVyZmFjZS5oICAgfCAg
MyArKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2FtZGtmZF9hbGRlYmFyYW4uYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2FtZGtmZF9hbGRlYmFyYW4uYw0KPiA+IGluZGV4IGM4OTM1ZDcxODIwNy4uZWJkN2Qz
NmQwOTliIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hbWRrZmRfYWxkZWJhcmFuLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfYW1ka2ZkX2FsZGViYXJhbi5jDQo+ID4gQEAgLTIzLDYgKzIzLDMwIEBADQo+ID4g
ICAjaW5jbHVkZSAiYW1kZ3B1X2FtZGtmZC5oIg0KPiA+ICAgI2luY2x1ZGUgImFtZGdwdV9hbWRr
ZmRfYXJjdHVydXMuaCINCj4gPiAgICNpbmNsdWRlICJhbWRncHVfYW1ka2ZkX2dmeF92OS5oIg0K
PiA+ICsjaW5jbHVkZSAic29jMTUuaCINCj4gPiArI2luY2x1ZGUgImdjL2djXzlfNF8yX3NoX21h
c2suaCINCj4gPiArDQo+ID4gK3N0YXRpYyBib29sIGtnZF9hbGRlYmFyYW5faXNfcmFzX3V0Y2wy
X3BvaXNvbihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiArCQkJdWludDE2X3QgY2xp
ZW50X2lkKQ0KPiA+ICt7DQo+ID4gKwl1aW50MzJfdCBzdGF0dXMgPSAwOw0KPiA+ICsJc3RydWN0
IGFtZGdwdV92bWh1YiAqaHViOw0KPiA+ICsNCj4gPiArCWlmIChjbGllbnRfaWQgIT0gU09DMTVf
SUhfQ0xJRU5USURfVVRDTDIpDQo+ID4gKwkJcmV0dXJuIGZhbHNlOw0KPiA+ICsNCj4gDQo+IFN0
YXR1cyBjaGVjayBpcyBub3QgcmVsYXRlZCB0byBpbnRlcnJ1cHQuIElzIElIIGNsaWVudCBpZCBu
ZWVkZWQgaGVyZT8NCg0KW1Rhb10gSSdsbCByZW1vdmUgdGhlIGNoZWNrIGZvciBjbGllbnRfaWQg
c2luY2UgaXQgaGFzIGJlZW4gY2hlY2tlZCBpbiB2bSBmYXVsdCBoYW5kbGVyLg0KDQo+IA0KPiBU
aGFua3MsDQo+IExpam8NCj4gDQo+ID4gKwlodWIgPSAmYWRldi0+dm1odWJbQU1ER1BVX0dGWEhV
Ql8wXTsNCj4gPiArCXN0YXR1cyA9IFJSRUczMihodWItPnZtX2wyX3Byb19mYXVsdF9zdGF0dXMp
Ow0KPiA+ICsJcmV0dXJuIFJFR19HRVRfRklFTEQoc3RhdHVzLCBWTV9MMl9QUk9URUNUSU9OX0ZB
VUxUX1NUQVRVUywNCj4gRkVEKTsgfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQga2dkX2FsZGVi
YXJhbl91dGNsMl9mYXVsdF9jbGVhcihzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiA+ICsqYWRldikg
ew0KPiA+ICsJc3RydWN0IGFtZGdwdV92bWh1YiAqaHViID0gJmFkZXYtPnZtaHViW0FNREdQVV9H
RlhIVUJfMF07DQo+ID4gKw0KPiA+ICsJaHViID0gJmFkZXYtPnZtaHViW0FNREdQVV9HRlhIVUJf
MF07DQo+ID4gKwlXUkVHMzJfUChodWItPnZtX2wyX3Byb19mYXVsdF9jbnRsLCAxLCB+MSk7IH0N
Cj4gPg0KPiA+ICAgY29uc3Qgc3RydWN0IGtmZDJrZ2RfY2FsbHMgYWxkZWJhcmFuX2tmZDJrZ2Qg
PSB7DQo+ID4gICAJLnByb2dyYW1fc2hfbWVtX3NldHRpbmdzID0ga2dkX2dmeF92OV9wcm9ncmFt
X3NoX21lbV9zZXR0aW5ncywNCj4gPiBAQCAtNDEsNSArNjUsNyBAQCBjb25zdCBzdHJ1Y3Qga2Zk
MmtnZF9jYWxscyBhbGRlYmFyYW5fa2ZkMmtnZCA9IHsNCj4gPiAgIAkuZ2V0X2F0Y192bWlkX3Bh
c2lkX21hcHBpbmdfaW5mbyA9DQo+ID4NCj4gCWtnZF9nZnhfdjlfZ2V0X2F0Y192bWlkX3Bhc2lk
X21hcHBpbmdfaW5mbywNCj4gPiAgIAkuc2V0X3ZtX2NvbnRleHRfcGFnZV90YWJsZV9iYXNlID0N
Cj4ga2dkX2dmeF92OV9zZXRfdm1fY29udGV4dF9wYWdlX3RhYmxlX2Jhc2UsDQo+ID4gLQkucHJv
Z3JhbV90cmFwX2hhbmRsZXJfc2V0dGluZ3MgPQ0KPiBrZ2RfZ2Z4X3Y5X3Byb2dyYW1fdHJhcF9o
YW5kbGVyX3NldHRpbmdzDQo+ID4gKwkucHJvZ3JhbV90cmFwX2hhbmRsZXJfc2V0dGluZ3MgPQ0K
PiBrZ2RfZ2Z4X3Y5X3Byb2dyYW1fdHJhcF9oYW5kbGVyX3NldHRpbmdzLA0KPiA+ICsJLmlzX3Jh
c191dGNsMl9wb2lzb24gPSBrZ2RfYWxkZWJhcmFuX2lzX3Jhc191dGNsMl9wb2lzb24sDQo+ID4g
KwkudXRjbDJfZmF1bHRfY2xlYXIgPSBrZ2RfYWxkZWJhcmFuX3V0Y2wyX2ZhdWx0X2NsZWFyDQo+
ID4gICB9Ow0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUva2dk
X2tmZF9pbnRlcmZhY2UuaA0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2tnZF9r
ZmRfaW50ZXJmYWNlLmgNCj4gPiBpbmRleCAyZjYwY2YzNWE0NDQuLjc4NDAwNDc5MTkzZSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUva2dkX2tmZF9pbnRlcmZh
Y2UuaA0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9rZ2Rfa2ZkX2ludGVy
ZmFjZS5oDQo+ID4gQEAgLTI5MSw2ICsyOTEsOSBAQCBzdHJ1Y3Qga2ZkMmtnZF9jYWxscyB7DQo+
ID4gICAJCQlpbnQgKndhdmVfY250LCBpbnQgKm1heF93YXZlc19wZXJfY3UpOw0KPiA+ICAgCXZv
aWQgKCpwcm9ncmFtX3RyYXBfaGFuZGxlcl9zZXR0aW5ncykoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsDQo+ID4gICAJCQl1aW50MzJfdCB2bWlkLCB1aW50NjRfdCB0YmFfYWRkciwgdWludDY0
X3QgdG1hX2FkZHIpOw0KPiA+ICsJYm9vbCAoKmlzX3Jhc191dGNsMl9wb2lzb24pKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LA0KPiA+ICsJCQl1aW50MTZfdCBjbGllbnRfaWQpOw0KPiA+ICsJ
dm9pZCAoKnV0Y2wyX2ZhdWx0X2NsZWFyKShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7DQo+
ID4gICB9Ow0KPiA+DQo+ID4gICAjZW5kaWYJLyogS0dEX0tGRF9JTlRFUkZBQ0VfSF9JTkNMVURF
RCAqLw0KPiA+DQo=
