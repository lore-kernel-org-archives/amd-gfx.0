Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DA2C6FD1C
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 02:14:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 294CA10E157;
	Fri, 24 Mar 2023 02:14:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FAB610E157
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 02:14:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDzdG2I+FYS8k0297BepCxScvm/acM8VX6RaRUdtFOKasvtFEshfcSaV6bVdA8W10xIkpBObN2JCibSP/WRrNM6EtZYMN0dYfeFnnRjeRyGa0tnG+eX5Rg2ElEpOb3DsiFKeq6YZPu+haq0O8NXa3QNMXZ8WX7qbJBA89zGg8eT+OH+SsAR9SOCISH5qMU4LbvzOTZ4+grGXnqQVftiRwjlMy262lpAf8rh9lyMEXh6VdlCETz1mTVfeChmi6nD95bdTW1XfoOjQHrDlj9b9M/Z6S7I9J2bxI2LEtlC4grEpIaCuX4Ssu9OMjKs/wHXaoUEFZ79P1eift16O9FR86Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOJRh4c5U05rFvtL6U0eabErr/MSU2wfEZjuqfHTAnU=;
 b=bIgA8iSyRYVpjZro9MxBr8FZOkn1c9oRkXaAWFHg5Aho1bpLY3kxqWbs+9nJ1OVHF6rPPcoocd51i/D35y0+SxW6md5O4Y9fhwIhXMJvfi4cbMG2r/SZWYIs30LWIwOrqFFUMHgFJEtfyfh/7z5KXyhNkBKBqrlAGMG65iVSDwZ14yrkiZQquH4EMJrLk3b4NELzKgeSrcZ614dNfFrKSka78mmm4YCwrpXX6ZfeXr8VbSKDRyFNo5zck6ryS+46CLXOgzwYtptgSQy0/3c14Clf+9ymaxl8WhhDQMm25DGUB9YgF6qQGEfCEwCdHFH64wV512LB+57xzgfy/XZsow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOJRh4c5U05rFvtL6U0eabErr/MSU2wfEZjuqfHTAnU=;
 b=R5ZWPihxQI4H9OW13WVy1xqbp0Nyh824qrcI4n8ltvkJh1BCzvsMvVZrzXlVE49o00nPfe/EO1mM8C7ZbGh35gOsOEpblvfFvAqfRR+jGWJnYFmg2GFaICEG22lk0R7XVdvRAhp8KxNX8Q6pbyTnmuUexvj2MX5djMawSspFbg0=
Received: from DM6PR12MB3531.namprd12.prod.outlook.com (2603:10b6:5:18b::10)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 02:14:16 +0000
Received: from DM6PR12MB3531.namprd12.prod.outlook.com
 ([fe80::cf43:4080:4a5c:c4af]) by DM6PR12MB3531.namprd12.prod.outlook.com
 ([fe80::cf43:4080:4a5c:c4af%3]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 02:14:16 +0000
From: "Yang, WenYou" <WenYou.Yang@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: [v1,2/3] drm/amd/pm: send the SMT-enable message to pmfw
Thread-Topic: [v1,2/3] drm/amd/pm: send the SMT-enable message to pmfw
Thread-Index: AQHZXa62E63Jmup+5UyLvzaltxOqqq8JMO6Q
Date: Fri, 24 Mar 2023 02:14:15 +0000
Message-ID: <DM6PR12MB35314CE6F4D56A83E34E134BFD849@DM6PR12MB3531.namprd12.prod.outlook.com>
References: <20230322054808.1555230-3-WenYou.Yang@amd.com>
 <2c8c7a2a-566d-22a7-dc9b-5e08fbaf726c@amd.com>
In-Reply-To: <2c8c7a2a-566d-22a7-dc9b-5e08fbaf726c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-24T02:14:13Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=00c10e8e-5f8b-4679-8af9-ed0f543079cf;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3531:EE_|PH7PR12MB7283:EE_
x-ms-office365-filtering-correlation-id: 3e42ba7a-8e76-478b-209d-08db2c0d77cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MhIoDCn+bwOWf04IBJRjJaB+9FG5VDZWNicvdfXEyWcqaFACV/RGkiVnTGpWaQAyPXkd1P+mS5kCVUQj/iAMuxr65qvm0k8i+nVoyBH6AWdJ7t0+MxyXhMEpT7Y3h6JVVhwzMHbifpqAsvZg2Kveb0ndgyw35loRHJMOulLG28iLy1oZwmw+K34224eGntQrY9T+r9rFhMLOULPJj2XxoE5NXYla9cM1C3iYus8Tli8QWKF+9rNA1AluXlYsuOEGC606YxU6nzgT6tDu1dBm6BmGeD86oHjTUp7bil8+ksec4gPvZN/Dw5BzVUVjrba2ekNx3F04RSJKN2zP/BciR/Rxc091jFuB9O5WVC2SGVvDMGaCR9EOmwSfmvmbC+Pcx9sv5KkLUdKLAEBdfEYQ3sPojKFsHqGJ0Xh4FNQYkxyd4i6cvHEYVdSRRD0vCi230wfdkcunVjTOgA7q6KP3w4ApXqeAmXePlNzYyZ9HAE4S1yZQN6JZ2JkNJGKGcOJckr5xBWQZqUuvUKv/Oy3qrD+ZfieeBxwaIhOaUK2prHhNe3ASKg4uPvJoA9kAjXEsUc/uG+eSb0ARJSgVTLOPBh2/ugEAeCPPKE8xf+2txMlqtz5Wu5XtbxD3BQTPv4MJqyQd5OMwMG+cD9R5sDy8QkkA6WE4FK9odgoIsC1tffTEemtVCX+N8Wc2JSipv0ImBOLU9d6MsxjcqrXzEGbnzg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3531.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199018)(8936002)(52536014)(76116006)(66446008)(64756008)(66476007)(66946007)(41300700001)(66556008)(4326008)(8676002)(86362001)(33656002)(38070700005)(122000001)(53546011)(38100700002)(26005)(6506007)(9686003)(55016003)(83380400001)(186003)(478600001)(54906003)(71200400001)(6636002)(110136005)(7696005)(2906002)(316002)(15650500001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHdNdzl1NVJVd1M3dFJiNWpxT1BkbWJWVXJyMnpqcGJnMDcxUFQwOHoxajRT?=
 =?utf-8?B?WGFMQm12S1BUOUsySTZSOVZNcVF6YWNFRHNoZEZvZmJ2dDd2ME5SWHR6VnBV?=
 =?utf-8?B?cTk2MG0yeVh3SWV1STdSYndjVjk2MnlvTjJzYUZDUHVkV0NzVnlCN1FaRzVR?=
 =?utf-8?B?ZTRzS0FGbFVhL3luRnBMdnRDS1BhQjEyYnNGTU56S2pqc2dVdnlDU1ZVZGxP?=
 =?utf-8?B?b2ZuTTVsVGFrYkI0V0lxUnVQYTVxMzM0ZG0rcEhNc2tGUFBKdjAyMEhCTTRk?=
 =?utf-8?B?TkxxQy9wOEpsUHBmYmtpRXlTTjUxanZ3aUpQdEhCZGlzQWJvT1FObElRalRI?=
 =?utf-8?B?L3YzQU9tUS9qb2M3SUY1UkxMbHRTdG41SGozaWpmR1gyR2x5VmErOXBGSGFn?=
 =?utf-8?B?TVc4aXFwTVBoaUFTSDl1NWtndWRuSGZXWjV2U3JuNXk0U0IxSTFSWDBEQ3dl?=
 =?utf-8?B?WGVzL1JrRkhJNUw0dW1henlIYmE1TXgxMCtYTURDMEt4V2R4OEFpeXlZOEd3?=
 =?utf-8?B?MGZ3cjZGT29aU1A4UEZOTnR1WTdWZnNZR3V6MDg3S0dOT0U0OXNYd2JHRFl2?=
 =?utf-8?B?ZXMxOGcxa29mYUVTNTBPN0ExN2VENGVSb05IUFVtUy94ZFNuakJqVEVyOCto?=
 =?utf-8?B?T0FCdGFaRkdIRnVlWG12c2tqbHJQcTVIUmFFWDJ2T3ZNRHZkYkpTempEeGkr?=
 =?utf-8?B?L1VQNXF5VnQyM1NKTjJSWm0yeVRYQ2lOamo1dVlJNVlWNzNpZnM5ZVc2S0tX?=
 =?utf-8?B?WnpjU1lhSVhTVWFMU3hrbXIzN1R6T1M5WGZhbC93RTNhaXZKSHdJaGlDUkVz?=
 =?utf-8?B?T3lHUTJycG5YWUlIOEI5WHZOOHRJTHU4R1F5N2FpYWQyZ3R6eFNtdkd1QTYx?=
 =?utf-8?B?dWlPWExzSk84TnlGWDVSaEFUUTU4SGVrSXVpQjY2bTB3RDZQVkFvUHVRSHZ2?=
 =?utf-8?B?RjBuY0QwZy9xQXFBQTFYUGU2dCtnbklubmRyUW00ai9HbWlWMVJXYWxZaHg5?=
 =?utf-8?B?TUp0Z3BKbk5PSjQyUFBFT3JHQTE1TUpOOHk5S1ZKNUs3MTRPayszZ0JhS0Ji?=
 =?utf-8?B?YmJGbGZhQkpKcmVoaTJKODRVWHdJUTlwVS95dTFhV2pndTJrNVNuc3AwQXFj?=
 =?utf-8?B?dU82UGcwTjc0MCtjK2pWdmpvR0JRdXdHUFI3aVBrQ0sycEZXeWtpV0MvM09l?=
 =?utf-8?B?TVVSSExPVEVHdGpIUlhKZ212elZxYW9FK2JLdFlhVzFpNUMvbjEvRVhzZFpr?=
 =?utf-8?B?Snl1ZERBQXNuQVB3WDZCMXJtYm9VVDlPbElMT3JkZTJWMWNqazlMV3ZLbUJt?=
 =?utf-8?B?R1Q5WHNmZUtyYm9JT1BhMkRVQkRQNGdjaUlwSHVrYzlzaStOTTgxaU1tNERI?=
 =?utf-8?B?OE5PVG83QUUxUUhtZGJwbWxJZEV0eDNmTjlEVzZ2eUxtTk9YSE9aN0tmY0s0?=
 =?utf-8?B?d2lZdGdDaWpYalY1cGJKN21MN2lPQXdBbm5aVnNyTmRmZHRZV0psMFN5TlU4?=
 =?utf-8?B?eFJ5czh2end6aDMzR2Vxb1lUQlVNa0tycE5vcVQ5SGVWQ0I0MlhlYUR1cWVK?=
 =?utf-8?B?SzRpRG9sSy9qTHc3UHl1aWVIaWxVbFFoKzRNamlZY0FjYTNvZ0trYktqSXhq?=
 =?utf-8?B?a2hVUXp4MS85WE1ZT1h6NEFxRlk4dWFBZmg1YXNQSmhUdmlmK3czenVvR1gw?=
 =?utf-8?B?LzlJNGdoSzVuL0NIZmZZNEMxWlJBbHRLaitOQmczQmRrUnVzRjIyQndPRW1z?=
 =?utf-8?B?Mld0VTlOV3lUaysyMzVQcUpsMkZURktoUDlDYS9rZklIK09wRGtpSUI3Z0FC?=
 =?utf-8?B?ODFRNzl2NUJxUjN0a21ML0ZaMGNLOGZYYU96RTZWbStxTE1aaDYyaFB0Z3pI?=
 =?utf-8?B?a3hBTFhJZHFvaUdSb2hkKzBaVzhuUjVOckJLME43TUx2YWF0eHdDNDJZZGlJ?=
 =?utf-8?B?cmpScHZ1OGtDVFFZeC9ZczlYaGVOejZydUxvY2hlczJnWS8zMVQ3bUxOS0NB?=
 =?utf-8?B?UzVyQVE1Q2xRTjBBQVdxMllkQnlTV05MS3p3bThNM0JpQnd4M1NEdlFqWkVB?=
 =?utf-8?B?NkgzOENaWGVNNnc2L2NuUVFrUjJqM3ZOQzFTVStqRE1GOS9Yclh1dTgwb1Nl?=
 =?utf-8?Q?mIFWyhgc5yIHxdh3Lyi5p8Jl9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3531.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e42ba7a-8e76-478b-209d-08db2c0d77cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 02:14:15.8873 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NiBGDBfyWZcCEmBlJyxPQXVPZfGGs9hKEZdJxlnFnynN5b58bYL8uNB83EKNfgNokU7TjHbjVRNX8kKNt0GpXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283
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
Cc: "Li, Ying" <YING.LI@amd.com>, "Liang,
 Richard qi" <Richardqi.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVs
bG9AYW1kLmNvbT4NCj4gU2VudDogRnJpZGF5LCBNYXJjaCAyNCwgMjAyMyAxOjQyIEFNDQo+IFRv
OiBZYW5nLCBXZW5Zb3UgPFdlbllvdS5ZYW5nQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIN
Cj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA8Q2hy
aXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgUGFuLCBYaW5odWkgPFhpbmh1aS5QYW5AYW1kLmNvbT4N
Cj4gQ2M6IExpLCBZaW5nIDxZSU5HLkxJQGFtZC5jb20+OyBMaXUsIEt1biA8S3VuLkxpdTJAYW1k
LmNvbT47IGFtZC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgTGlhbmcsIFJpY2hhcmQg
cWkgPFJpY2hhcmRxaS5MaWFuZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW3YxLDIvM10gZHJt
L2FtZC9wbTogc2VuZCB0aGUgU01ULWVuYWJsZSBtZXNzYWdlIHRvIHBtZncNCj4gDQo+IE9uIDMv
MjIvMjAyMyAwMDo0OCwgV2VueW91IFlhbmcgd3JvdGU6DQo+ID4gV2hlbiB0aGUgQ1BVIFNNVCBz
dGF0dXMgY2hhbmdlIGluIHRoZSBmbHksIHNlbnQgdGhlIFNNVC1lbmFibGUgbWVzc2FnZQ0KPiA+
IHRvIHBtZncgdG8gbm90aWZ5IGl0IHRoYXQgdGhlIFNNVCBzdGF0dXMgY2hhbmdlZC4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFdlbnlvdSBZYW5nIDxXZW5Zb3UuWWFuZ0BhbWQuY29tPg0KPiA+
IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMgICAg
IHwgNDENCj4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9w
bS9zd3NtdS9pbmMvYW1kZ3B1X3NtdS5oIHwgIDUgKysrDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQs
IDQ2IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9z
d3NtdS9hbWRncHVfc211LmMNCj4gPiBpbmRleCBiNWQ2NDc0OTk5MGUuLjVjZDg1YTlkMTQ5ZCAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jDQo+
ID4gQEAgLTIyLDYgKzIyLDcgQEANCj4gPg0KPiA+ICAgI2RlZmluZSBTV1NNVV9DT0RFX0xBWUVS
X0wxDQo+ID4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2NwdS5oPg0KPiA+ICAgI2luY2x1ZGUgPGxp
bnV4L2Zpcm13YXJlLmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvcGNpLmg+DQo+ID4NCj4gPiBA
QCAtNjksNiArNzAsMTQgQEAgc3RhdGljIGludCBzbXVfc2V0X2Zhbl9zcGVlZF9ycG0odm9pZCAq
aGFuZGxlLA0KPiB1aW50MzJfdCBzcGVlZCk7DQo+ID4gICBzdGF0aWMgaW50IHNtdV9zZXRfZ2Z4
X2NncGcoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsIGJvb2wgZW5hYmxlZCk7DQo+ID4gICBzdGF0
aWMgaW50IHNtdV9zZXRfbXAxX3N0YXRlKHZvaWQgKmhhbmRsZSwgZW51bSBwcF9tcDFfc3RhdGUN
Cj4gPiBtcDFfc3RhdGUpOw0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgc210X25vdGlmaWVyX2NhbGxi
YWNrKHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIsIHVuc2lnbmVkDQo+ID4gK2xvbmcgYWN0aW9u
LCB2b2lkICpkYXRhKTsNCj4gPiArDQo+ID4gK2V4dGVybiBzdHJ1Y3QgcmF3X25vdGlmaWVyX2hl
YWQgc210X25vdGlmaWVyX2hlYWQ7DQo+ID4gKw0KPiA+ICtzdGF0aWMgc3RydWN0IG5vdGlmaWVy
X2Jsb2NrIHNtdF9ub3RpZmllciA9IHsNCj4gPiArCS5ub3RpZmllcl9jYWxsID0gc210X25vdGlm
aWVyX2NhbGxiYWNrLCB9Ow0KPiA+ICsNCj4gPiAgIHN0YXRpYyBpbnQgc211X3N5c19nZXRfcHBf
ZmVhdHVyZV9tYXNrKHZvaWQgKmhhbmRsZSwNCj4gPiAgIAkJCQkgICAgICAgY2hhciAqYnVmKQ0K
PiA+ICAgew0KPiA+IEBAIC02MjUsNiArNjM0LDggQEAgc3RhdGljIGludCBzbXVfc2V0X2Z1bmNz
KHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+ICphZGV2KQ0KPiA+ICAgCXJldHVybiAwOw0KPiA+ICAg
fQ0KPiA+DQo+ID4gK3N0YXRpYyBzdHJ1Y3Qgc211X2NvbnRleHQgKmN1cnJlbnRfc211Ow0KPiA+
ICsNCj4gPiAgIHN0YXRpYyBpbnQgc211X2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQ0KPiA+ICAg
ew0KPiA+ICAgCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2
aWNlICopaGFuZGxlOw0KPiBAQA0KPiA+IC02NDUsNiArNjU2LDcgQEAgc3RhdGljIGludCBzbXVf
ZWFybHlfaW5pdCh2b2lkICpoYW5kbGUpDQo+ID4gICAJbXV0ZXhfaW5pdCgmc211LT5tZXNzYWdl
X2xvY2spOw0KPiA+DQo+ID4gICAJYWRldi0+cG93ZXJwbGF5LnBwX2hhbmRsZSA9IHNtdTsNCj4g
PiArCWN1cnJlbnRfc211ID0gc211Ow0KPiA+ICAgCWFkZXYtPnBvd2VycGxheS5wcF9mdW5jcyA9
ICZzd3NtdV9wbV9mdW5jczsNCj4gPg0KPiA+ICAgCXIgPSBzbXVfc2V0X2Z1bmNzKGFkZXYpOw0K
PiA+IEBAIC0xMTA1LDYgKzExMTcsOCBAQCBzdGF0aWMgaW50IHNtdV9zd19pbml0KHZvaWQgKmhh
bmRsZSkNCj4gPiAgIAlpZiAoIXNtdS0+cHB0X2Z1bmNzLT5nZXRfZmFuX2NvbnRyb2xfbW9kZSkN
Cj4gPiAgIAkJc211LT5hZGV2LT5wbS5ub19mYW4gPSB0cnVlOw0KPiA+DQo+ID4gKwlyYXdfbm90
aWZpZXJfY2hhaW5fcmVnaXN0ZXIoJnNtdF9ub3RpZmllcl9oZWFkLCAmc210X25vdGlmaWVyKTsN
Cj4gPiArDQo+ID4gICAJcmV0dXJuIDA7DQo+ID4gICB9DQo+ID4NCj4gPiBAQCAtMTEyMiw2ICsx
MTM2LDggQEAgc3RhdGljIGludCBzbXVfc3dfZmluaSh2b2lkICpoYW5kbGUpDQo+ID4NCj4gPiAg
IAlzbXVfZmluaV9taWNyb2NvZGUoc211KTsNCj4gPg0KPiA+ICsJcmF3X25vdGlmaWVyX2NoYWlu
X3VucmVnaXN0ZXIoJnNtdF9ub3RpZmllcl9oZWFkLCAmc210X25vdGlmaWVyKTsNCj4gPiArDQo+
ID4gICAJcmV0dXJuIDA7DQo+ID4gICB9DQo+ID4NCj4gPiBAQCAtMzI0MSwzICszMjU3LDI4IEBA
IGludCBzbXVfc2VuZF9oYm1fYmFkX2NoYW5uZWxfZmxhZyhzdHJ1Y3QNCj4gPiBzbXVfY29udGV4
dCAqc211LCB1aW50MzJfdCBzaXplKQ0KPiA+DQo+ID4gICAJcmV0dXJuIHJldDsNCj4gPiAgIH0N
Cj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgc211X3NldF9jcHVfc210X2VuYWJsZShzdHJ1Y3Qgc211
X2NvbnRleHQgKnNtdSwgYm9vbA0KPiA+ICtlbmFibGUpIHsNCj4gPiArCWludCByZXQgPSAtRUlO
VkFMOw0KPiA+ICsNCj4gPiArCWlmIChzbXUtPnBwdF9mdW5jcyAmJiBzbXUtPnBwdF9mdW5jcy0+
c2V0X2NwdV9zbXRfZW5hYmxlKQ0KPiA+ICsJCXJldCA9IHNtdS0+cHB0X2Z1bmNzLT5zZXRfY3B1
X3NtdF9lbmFibGUoc211LCBlbmFibGUpOw0KPiA+ICsNCj4gPiArCXJldHVybiByZXQ7DQo+ID4g
K30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgc210X25vdGlmaWVyX2NhbGxiYWNrKHN0cnVjdCBu
b3RpZmllcl9ibG9jayAqbmIsDQo+ID4gKwkJCQkgdW5zaWduZWQgbG9uZyBhY3Rpb24sIHZvaWQg
KmRhdGEpIHsNCj4gPiArCXN0cnVjdCBzbXVfY29udGV4dCAqc211ID0gY3VycmVudF9zbXU7DQo+
ID4gKwlpbnQgcmV0ID0gTk9USUZZX09LOw0KPiANCj4gVGhpcyBpbml0aWFsaXphdGlvbiBpcyBw
b2ludGxlc3MsIGl0J3MgY2xvYmJlcmVkIGluIHRoZSBuZXh0IGxpbmUuDQoNClllcywgYWNjZXB0
Lg0KPiANCj4gPiArDQo+ID4gKwlyZXQgPSAoYWN0aW9uID09IFNNVF9FTkFCTEVEKSA/DQo+ID4g
KwkJCQlzbXVfc2V0X2NwdV9zbXRfZW5hYmxlKHNtdSwgdHJ1ZSkgOg0KPiA+ICsJCQkJc211X3Nl
dF9jcHVfc210X2VuYWJsZShzbXUsIGZhbHNlKTsNCj4gDQo+IEhvdyBhYm91dCB0aGlzIGluc3Rl
YWQsIGl0IHNob3VsZCBiZSBtb3JlIHJlYWRhYmxlOg0KPiANCj4gCXJldCA9IHNtdV9zZXRfY3B1
X3NtdF9lbmFibGUoc211LCBhY3Rpb24gPT0gU01UX0VOQUJMRUQpOw0KDQpBY2NlcHQuDQo+IA0K
PiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXQgPSBOT1RJRllfQkFEOw0KPiA+ICsNCj4gPiArCXJl
dHVybiByZXQ7DQo+IA0KPiBIb3cgYWJvdXQgaW5zdGVhZDoNCj4gDQo+IAlkZXZfZGJnKGFkZXYt
PmRldiwgImZhaWxlZCB0byAlc2FibGUgU01UOiAlZFxuIiwgYWN0aW9uID09DQo+IFNNVF9FTkFC
TEVEID8gImVuIiA6ICJkaXMiLCByZXQpOw0KPiANCj4gCXJldHVybiByZXQgPyBOT1RJRllfQkFE
IDogTk9USUZZX09LOw0KPiANCg0KQWNjZXB0Lg0KDQpUaGFua3MgDQpXZW55b3UNCg0KPiA+ICt9
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvaW5jL2FtZGdw
dV9zbXUuaA0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvYW1kZ3B1X3Nt
dS5oDQo+ID4gaW5kZXggMDk0NjljNzUwYTk2Li43YzY1OTRiYmE3OTYgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvYW1kZ3B1X3NtdS5oDQo+ID4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvYW1kZ3B1X3NtdS5oDQo+ID4gQEAg
LTEzNTQsNiArMTM1NCwxMSBAQCBzdHJ1Y3QgcHB0YWJsZV9mdW5jcyB7DQo+ID4gICAJICogQGlu
aXRfcHB0YWJsZV9taWNyb2NvZGU6IFByZXBhcmUgdGhlIHBwdGFibGUgbWljcm9jb2RlIHRvDQo+
IHVwbG9hZCB2aWEgUFNQDQo+ID4gICAJICovDQo+ID4gICAJaW50ICgqaW5pdF9wcHRhYmxlX21p
Y3JvY29kZSkoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpOw0KPiA+ICsNCj4gPiArCS8qKg0KPiA+
ICsJICogQHNldF9jcHVfc210X2VuYWJsZTogU2V0IHRoZSBDUFUgU01UIHN0YXR1cw0KPiA+ICsJ
ICovDQo+ID4gKwlpbnQgKCpzZXRfY3B1X3NtdF9lbmFibGUpKHN0cnVjdCBzbXVfY29udGV4dCAq
c211LCBib29sIGVuYWJsZSk7DQo+ID4gICB9Ow0KPiA+DQo+ID4gICB0eXBlZGVmIGVudW0gew0K
