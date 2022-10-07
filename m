Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18AEC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Oct 2022 21:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E62D10E2EF;
	Fri,  7 Oct 2022 21:38:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C94C810E2EF
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Oct 2022 21:38:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFZIRTniTruB2JpL4ixNdZe6aOrqfcL446ORr9KJ+7CTjZnh/PgWf9lF4IDlf2coO9F20OhJ8PBq4Z555ifHdAjJVwB7kdPQf6UQEUvbG3pComVxohevwfXAn4DR05rMobFl7bby88ozghrkLwRGnIdrZK8jivlI2/JDPKJU+cmJ1KobsTFF84qYR0CFB5en+LAfh5BnMTf0/WlHHKqvQ+8Ha/uehgh+QfxuPkkP1R4zNHD1TH0m7exLY382xAgG3jD6lctzpWzxB30fyaATXWXvVL3E/z7kSn+GGuMUKjeHBZiMQnE98NP1vOSySgxAUbhaV27H08+nknztBS3MRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kl2EIiVDYiBexkm/Xn+Fg0HQulN/eKSFazFAi1LB/tU=;
 b=CYrLHXN5UZQe0N1IuEp2Liakhgaa4zW63e85lfq4V8gfjJlsF+SqKmRZuc8vPHrrrj0ZNs+YXeCYOds1ko+NU3e80RK6AkfauOe3HrUCaYbNpl4xYqWOhRE6jJWZVdBvGu2JcCVJQfZrdy9yh5kgPNV9YNkwt/pKcVmSrY3rXqEg2PFmCvhEMk+nZdHF9Sn0lCUgaYCv5/9clYhqp1RW5MegpN3AEMTNfe0KrWhsFgl76xyERgVQh+Gf8RsMXN7+ndI2tQBoU/JRszRQRrTqndSayCPJ9VoFQ6lq5XXk3jJjoEfPbNo2C5RTD6McqC19Rjo4SBo2+B/DmxYNTaN3Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kl2EIiVDYiBexkm/Xn+Fg0HQulN/eKSFazFAi1LB/tU=;
 b=chZ2JaJIcDYvsqZJvXFjU0uvtnU/8tNTUvTiez5WZl+Kw7696SCQNbkVr3LP2t/IkLJ6iHHch8+9/qLjqeYA8F3+QzKVGpZc2+RiGXWGzGoNtF5GKKfIFvoIXwwlJ0uQGBkB3+pKMN1OkDUFLFpcZfl9KiqkqK9gRhFZl2jsYyA=
Received: from MN2PR12MB2957.namprd12.prod.outlook.com (2603:10b6:208:100::14)
 by CY8PR12MB7266.namprd12.prod.outlook.com (2603:10b6:930:56::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Fri, 7 Oct
 2022 21:38:05 +0000
Received: from MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::228b:1a06:f715:e460]) by MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::228b:1a06:f715:e460%2]) with mapi id 15.20.5676.036; Fri, 7 Oct 2022
 21:38:05 +0000
From: "Zhang, Bokun" <Bokun.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: Fix SDMA engine resume issue under SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Fix SDMA engine resume issue under SRIOV
Thread-Index: AQHY2a6uQhYbBBF2wkSY+KsfG9dMZ64BqlbAgAAdsgCAAaO9cA==
Date: Fri, 7 Oct 2022 21:38:05 +0000
Message-ID: <MN2PR12MB29576D21D9A925F7F075D42EF45F9@MN2PR12MB2957.namprd12.prod.outlook.com>
References: <20221006180838.5132-1-Bokun.Zhang@amd.com>
 <MN2PR12MB2957F0AE3227749B07AAB7A4F45C9@MN2PR12MB2957.namprd12.prod.outlook.com>
 <CADnq5_OJN5cGu0Uaph2_A7XOSCUY9XgKNKyQTmRvY4+yy4sFTw@mail.gmail.com>
In-Reply-To: <CADnq5_OJN5cGu0Uaph2_A7XOSCUY9XgKNKyQTmRvY4+yy4sFTw@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-07T21:38:03Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3cc648ae-2be8-42b0-8885-cb51c362e1b9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-07T21:38:03Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 6668ea90-fd45-4d43-9100-65ef61744267
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB2957:EE_|CY8PR12MB7266:EE_
x-ms-office365-filtering-correlation-id: 1787c3c1-e54c-4216-bbc2-08daa8ac383a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bsbSyrI6xfAJlQ2Zs0UjQsDv4GPcbgRK4+FCJHPFZMUHJoW/hebmJk7MWWUu9RerWhipImYqag2iSAqfmH0PpbEbYidhLSU7C3gUvxzVnDZ7xjSOJeIn2iTZMUzWsNjPUni8vdeJ8S+MwAYdVstxglqZR5m+qNSAg6xNCjgWpDk1/+MyE4zbkqJxfjy4qEe+ZBk4EQjZAjYds7Ild4YTGIxPNzNtTF27QznsHsupX9p4Hr2xJ3/CWu9zuu6VpaYJfClFOfiOu7CvuXfiVtEdI1DsWt63AT9E4kNapCwyaQzvgdo/hYa8C3QFoWXuL0er2zisf/PEYANpdYL0HfSU2/kuzRmd4TaGJPqS9ZGoR87HFLdfodZXbJ3MdA4yWgzo5ALLPh8iAuo/JyM9MN6bm9/N7/ZEoog9YW0rCycFXXwTEIkzG4c1i33I0BeNT40SEsIhR2qBpX/PrC4mMmyr4i444rfjNvkw8ihUkBJ/3RaHuNbyUweEAWRBz7s0RoOjg4SNxEKgHuZw+Uthr/qnVD70uW4HxnL5IJBGEK+K3C6iA27EyfUYCdhn3Z2ukOaBDAa1xSYA0AJ0llsgAGq0aQyROIJjFU5oloKMEfuQno8u2ii5z0otffjzuZVVxKRfojp+FCPHPkJFAATPYbllzkQh83/1pp6z7giLXvqDGtKljnIC7cjOUaI3rKd4e9uFR4O0LTgMyS8cRYadoCHL62jrD/cF7PvHpAs/nPSa6AHHoiG/kmmtRvfNQM5uJPGS5wjQf2t6QjAYfQfgdXC+EQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2957.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199015)(52536014)(55016003)(8676002)(2906002)(66556008)(66476007)(5660300002)(64756008)(76116006)(66946007)(41300700001)(8936002)(66446008)(53546011)(71200400001)(478600001)(6916009)(7696005)(26005)(9686003)(6506007)(316002)(54906003)(4326008)(86362001)(33656002)(38100700002)(83380400001)(38070700005)(186003)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REQ0WFRjVDVpN1phbzcyRUdrQTgxMi9RVWhwL20rSEtkaHgweTN2RS9XbVd3?=
 =?utf-8?B?c1hvRTNFeDNMT3l3OVV5ZFBMeUhlOVBYRk1uSjg3ZGh5eTRhNkdoODZuc1Rq?=
 =?utf-8?B?TkhSMk92ZVZiOWN1S3d5R2FnZmRUY01HQXREWjlrNk4xQUxCcitTeVAvUUtm?=
 =?utf-8?B?cHd0T29Pckd5UXd3NUcwQU9KWUxMNFE5R1VFYW9ZOFUzeWFSQkpNQThhY2gw?=
 =?utf-8?B?RVYrV1cvVVVzVEhrbnNNY1RLMXhLSEtYZzN3WTlRcy9xcjl5VU5UbzBkMHdZ?=
 =?utf-8?B?OHBQcWFzOFNlSDQxOHoyN3l3TEMwQmlHcW9EMTZSSjhKWlQ3NWgzRVdsczVi?=
 =?utf-8?B?LytlZzc5dENPcklzRUZtN1BLeTdVZEIxdjZ0YlVCczh2d0ZFODAxRzFROCtB?=
 =?utf-8?B?UG55M0gzS1QvZkg0R2V3QXo1SzBJV25kODFUekVJbnYvWlVlZXdidWh2UTdG?=
 =?utf-8?B?OG50OGY1UW41dzFrVEpjRjVERUdhV3BWRG92YzFBaG9oak5rOVNsN2kxOE1J?=
 =?utf-8?B?V2NpNVUwNnphNXIvME82VElXOGZDRXhrVm1zMzV5S04vYjdHbUxmL1RKQmI5?=
 =?utf-8?B?SGdTSVBaTWVzRGdJemhDNTFIUjJSVVU2ZU9ldXRpOUg0R3JPMXdSdGJTU1Vv?=
 =?utf-8?B?UUoybStBdy9Ud2ttY1dxbnZadFJwVDVKdHhUU2o5WUdRZnp2TTg4YUh0a1dk?=
 =?utf-8?B?NmFyOVpHMnJmUE12UlU1UnRyTnJDZExxUURKN2k3YWl2S0V4eHZMZnBtVWxs?=
 =?utf-8?B?b3hNaU1aeHcza0NYSVM3ZkhLVkhGSENmeE1QL0QwMW1wTlZVYmdZLzdvMHYx?=
 =?utf-8?B?amNwTEFtNmlQTmFYL3BnVXdBKzdUeVhJcmVLNXBHb2tJdnlGNUZMajcrZWpM?=
 =?utf-8?B?dVF6OHhIS05EeHdoQmVveFB1bkZyQ2M0U2YrNU1lcXFQbFVFaVNIZ09qWEhm?=
 =?utf-8?B?aDBMRzBvOU9Tc2pWYWlucUFwaU9xZHNjYmVLNDFZZ0ozYm5sQTFkZ2JaejI4?=
 =?utf-8?B?bm1rTGZtUTVDbTExOHA2bkFhSXdKdmR4Z2dYSVhGZnpwMzBjVlBaTkJJMXA0?=
 =?utf-8?B?Vi91YWVKaEI0MjNKb0hVQ1FwUlQvR0E2eEtTdmxlQk5oY3BobzY4SEs0b1cr?=
 =?utf-8?B?TVE3Q0k4djRTTlFSTVpqai95bk9UNVArbmlCUU1OS2hQWExyRHhMRDhMZCt3?=
 =?utf-8?B?aG9XSnZQakV1TzVTY0doN1h5WkdCZXN2OXhSS0tZSmMweS8vdVMzdEVsWXBK?=
 =?utf-8?B?MTNsSVloTGhrbTllYlJHQkVwR0hLU0E0SFVpTlU0L05WU1lOWVFETzBWQkNG?=
 =?utf-8?B?aDJVazlOUFhGb3JKVE1lM1hLMExmS05IcmdoNXQzWWhMaFBDU1lKa1hzTjg1?=
 =?utf-8?B?OURSemFlUklYWjVnTkJlend3SVl5WG5HSWl6aURJNzg1ZGp4K29UQ1JtVC8v?=
 =?utf-8?B?dE1NeHhCWEJlcTlHYm12a1B4ZWtmYlVOSXFPRDhFSXNVU01nSlFJeUdOYWZD?=
 =?utf-8?B?dGNMVHJYUmwvYzNaM09yK2wzL0dnRU9KUXVob09GTUcyc1dYSElRQ0JLSVBZ?=
 =?utf-8?B?Tm8rWlBaOEMzNG12V3JzMGtocHhMaURtVVFYUXVBQmxWblNnR0dWMnBEY2Y2?=
 =?utf-8?B?bnJJNG9RaEFuc1JHRkJxL0h4V0RBWGRDckN5NG9tajd3YmNjeUhlWlc4RXY0?=
 =?utf-8?B?YXBuWkRsYll6UFdNYU5HUG9wMFBrU0ZMMEJFZDc5WVpuV2wzVkhUakRGTnFH?=
 =?utf-8?B?R3Nrc0MxRzVVUE5YbFJuTXVwWE1ReGQrSE5JbGpmM01aMDBwR1dUS1JraEJn?=
 =?utf-8?B?RnUyajNGc3NYVTEzUFpOQlNvWmxJalNOU3VVcHg5dllRK3V5aEFzS01IWDVw?=
 =?utf-8?B?R0k1aHVqeGJxSlBIK2dkbTVlYXU5dk52Mk43WGwwTDhON2duczdhTUtvSU1u?=
 =?utf-8?B?Z1Z6Rk1Sak5kUkxJQUE2dCtDNUpsZXA4U0cxQXAva1c4SGJRN0hzeHFVL2Jz?=
 =?utf-8?B?UTl1Smx0UGptanZZOUNGZGFJOGdMQ1lkQm5SNVNTYzN2eHZHR1grTXBIc2d1?=
 =?utf-8?B?ZDdCcmZnSGZkMHYxcFh3V0QzelF6bFhqTjBWdnJvV1RNZGdqbU9UcHE3S3lk?=
 =?utf-8?Q?di6s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1787c3c1-e54c-4216-bbc2-08daa8ac383a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 21:38:05.7248 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nS/DqxBZLvL7z17kivCE28MIF18od0/bl2PAzEia6tbeEUDbXtd3PNqGQjppjONY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7266
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Jiang,
 Jerry \(SW\)" <Jerry.Jiang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRlc3RlZC1ieTogQm9rdW4sIFpo
YW5nIDxCb2t1bi5aaGFuZ0BhbWQuY29tPg0KDQpUaGlzIHBhdGNoIGlzIGJldHRlciBzaW5jZSBp
dCBleHRyYWN0ZWQgdGhlIHVuc2V0IGNvZGUgYW5kIG9ubHkgZXhlY3V0ZSBpdCBpbiB0aGUgU1JJ
T1Ygcm91dGluZS4NCkkgaGF2ZSB0ZXN0ZWQgaXQgd2l0aCBtdWx0aS1WRi4NCg0KVGhhbmtzIQ0K
DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhk
ZXVjaGVyQGdtYWlsLmNvbT4gDQpTZW50OiBUaHVyc2RheSwgT2N0b2JlciA2LCAyMDIyIDM6NTYg
UE0NClRvOiBaaGFuZywgQm9rdW4gPEJva3VuLlpoYW5nQGFtZC5jb20+DQpDYzogTGl1LCBNb25r
IDxNb25rLkxpdUBhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPjsgRGVuZywgRW1pbHkgPEVtaWx5LkRlbmdAYW1kLmNvbT47IEtvZW5pZywgQ2hy
aXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogRml4IFNETUEgZW5naW5l
IHJlc3VtZSBpc3N1ZSB1bmRlciBTUklPVg0KDQpPbiBUaHUsIE9jdCA2LCAyMDIyIGF0IDI6MTEg
UE0gWmhhbmcsIEJva3VuIDxCb2t1bi5aaGFuZ0BhbWQuY29tPiB3cm90ZToNCj4NCj4gW0FNRCBP
ZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQo+DQo+IEhleSBndXlzLA0KPiAgICAgUGxlYXNl
IGhlbHAgcmV2aWV3IHRoaXMgcGF0Y2ggZm9yIHRoZSBzdXNwZW5kIGFuZCByZXN1bWUgaXNzdWUu
DQo+ICAgICBJIGhhdmUgdGVzdGVkIGl0IHdpdGggbXVsdGktVkYgZW52aXJvbm1lbnQsIEkgdGhp
bmsgaXQgaXMgb2suDQoNClNlZW1zIGEgbGl0dGxlIGhhY2t5LCBidXQgSSB0aGluayB0aGF0J3Mg
dGhlIGxlYXN0IGludHJ1c2l2ZSBmb3Igc3RhYmxlLiAgSG93IGFib3V0IHRoZSBhdHRhY2hlZCBw
YXRjaGVzPw0KDQpBbGV4DQoNCg0KPg0KPiBUaGFua3MhDQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IEJva3VuIFpoYW5nIDxCb2t1bi5aaGFuZ0BhbWQuY29tPg0KPiBT
ZW50OiBUaHVyc2RheSwgT2N0b2JlciA2LCAyMDIyIDI6MDkgUE0NCj4gVG86IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBaaGFuZywgQm9rdW4gPEJva3VuLlpoYW5nQGFtZC5j
b20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogRml4IFNETUEgZW5naW5lIHJlc3Vt
ZSBpc3N1ZSB1bmRlciBTUklPVg0KPg0KPiAtIFVuZGVyIFNSSU9WLCBTRE1BIGVuZ2luZSBpcyBz
aGFyZWQgYmV0d2VlbiBWRnMuIFRoZXJlZm9yZSwNCj4gICB3ZSB3aWxsIG5vdCBzdG9wIFNETUEg
ZHVyaW5nIGh3X2ZpbmkuIFRoaXMgaXMgbm90IGFuIGlzc3VlDQo+ICAgd2l0aCBub3JtYWwgZGly
dmVyIGxvYWRpbmcgYW5kIHVubG9hZGluZy4NCj4NCj4gLSBIb3dldmVyLCB3aGVuIHdlIHB1dCB0
aGUgU0RNQSBlbmdpbmUgdG8gc3VzcGVuZCBzdGF0ZSBhbmQgcmVzdW1lDQo+ICAgaXQsIHRoZSBp
c3N1ZSBzdGFydHMgdG8gc2hvdyB1cC4gU29tZXRoaW5nIGNvdWxkIGF0dGVtcHQgdG8gdXNlDQo+
ICAgdGhhdCBTRE1BIGVuZ2luZSB0byBjbGVhciBvciBtb3ZlIG1lbW9yeSBiZWZvcmUgdGhlIGVu
Z2luZSBpcw0KPiAgIGluaXRpYWxpemVkIHNpbmNlIHRoZSBEUk0gZW50aXR5IGlzIHN0aWxsIHRo
ZXJlLg0KPg0KPiAtIFRoZXJlZm9yZSwgd2Ugd2lsbCBjYWxsIHNkbWFfdjVfMl9lbmFibGUoZmFs
c2UpIGR1cmluZyBod19maW5pLA0KPiAgIGFuZCBpZiB3ZSBhcmUgdW5kZXIgU1JJT1YsIHdlIHdp
bGwgY2FsbCBzZG1hX3Y1XzJfZW5hYmxlKHRydWUpDQo+ICAgYWZ0ZXJ3YXJkcyB0byBhbGxvdyBv
dGhlciBWRnMgdG8gdXNlIFNETUEuIFRoaXMgd2F5LCB0aGUgRFJNDQo+ICAgZW50aXR5IG9mIFNE
TUEgZW5naW5lIGlzIGVtcHRpZWQgYW5kIGl0IHdpbGwgZm9sbG93IHRoZSBmbG93DQo+ICAgb2Yg
cmVzdW1lIGNvZGUgcGF0aC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQm9rdW4gWmhhbmcgPEJva3Vu
LlpoYW5nQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2Rt
YV92NV8yLmMgfCAxMyArKysrKysrKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NkbWFfdjVfMi5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NkbWFfdjVfMi5jDQo+IGluZGV4IGYxMzZmZWM3YjRmNC4uM2VhZjFhNTczZTczIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzIuYw0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzIuYw0KPiBAQCAtMTM1NywxMiArMTM1
NywxOSBAQCBzdGF0aWMgaW50IHNkbWFfdjVfMl9od19maW5pKHZvaWQgKmhhbmRsZSkgIHsNCj4g
ICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqKWhhbmRsZTsNCj4NCj4gLSAgICAgICBpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0KPiAt
ICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+IC0NCj4gKyAgICAgICAvKg0KPiArICAgICAgICAq
IFVuZGVyIFNSSU9WLCB0aGUgVkYgY2Fubm90IHNpbmdsZS1taW5kZWRseSBzdG9wIFNETUEgZW5n
aW5lDQo+ICsgICAgICAgICogSG93ZXZlciwgd2Ugc3RpbGwgbmVlZCB0byBjbGVhbiB1cCB0aGUg
RFJNIGVudGl0eQ0KPiArICAgICAgICAqIFRoZXJlZm9yZSwgd2Ugd2lsbCByZS1lbmFibGUgU0RN
QSBhZnRlcndhcmRzLg0KPiArICAgICAgICAqLw0KPiAgICAgICAgIHNkbWFfdjVfMl9jdHhfc3dp
dGNoX2VuYWJsZShhZGV2LCBmYWxzZSk7DQo+ICAgICAgICAgc2RtYV92NV8yX2VuYWJsZShhZGV2
LCBmYWxzZSk7DQo+DQo+ICsgICAgICAgaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkgew0KPiAr
ICAgICAgICAgICAgICAgc2RtYV92NV8yX2VuYWJsZShhZGV2LCB0cnVlKTsNCj4gKyAgICAgICAg
ICAgICAgIHNkbWFfdjVfMl9jdHhfc3dpdGNoX2VuYWJsZShhZGV2LCB0cnVlKTsNCj4gKyAgICAg
ICB9DQo+ICsNCj4gICAgICAgICByZXR1cm4gMDsNCj4gIH0NCj4NCj4gLS0NCj4gMi4zNC4x
