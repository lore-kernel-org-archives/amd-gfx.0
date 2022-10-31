Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FEFC38A02
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 08:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 553E710E13B;
	Mon, 31 Oct 2022 08:10:35 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C76B10E13B
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 08:10:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ei23DafKPXW2ACth9RKRP7lBQkk6J2z72w/zYZTQz77vHkx1/W1yYucYZ8jHchHioI575iwj0N1OdQjhihbRNQprK7qnWT0LSKAGqDuBYVtxduaeAxxdOJBbjGUoWOFyEXJU6GdAlYHGrZGe3Jj+Mf42S7bLjvPCuqqqvKSFWmbCsHGzMv/PZumEBeHRB5/4tACWx08MqzOsKjNZ8P8QwtnwftPfS3OvNSV2RjeH5snXAOs0XrgEgoukXgNozPNc2B2VTmxzNOJh1Gn1OUFURTp13Q1fHhNaRKNJdH5h//F13qezxg2t/pKLg4OisEviKRQ1a9VVXmdMYLbEsNUTtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSXTLiDNpl5EBMpd6j7spmAihdn10WJYl+H4dc3mraE=;
 b=fHvcw84N0AOHrTdbuwZHF1qKddrlRcgMZqQ56ae9yWBVSMlSeat3A1iywBmtVvU7/ncBRi44Mq+F4iFIKMaJgj35RV18PvqdrgtLcscLsLoFlk1RLFIoc6Nbtynu9JNUDshAAmcUu6MaX7ciQO+Nxk0oz0tnamRX3l9ksPWYqH6oJV1C6BXif6Gu4uKeqhW1SrIgtLKzbbhmqtoF8TKoUmmtOxfAC7XPRuHiTKWy5KSOqRkzIJHPz6zOXHuKcZaVOwfHThDRUWktZp36yHHVhfska4ar0/wvUNcPDAmm0rXmi9IOOR3pMVCeu8oR5vGGS0uESuRxn/yKZB/XzZjhzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSXTLiDNpl5EBMpd6j7spmAihdn10WJYl+H4dc3mraE=;
 b=Ygf+LTFyG65/9tzfnVCVcuQX9UL40ff5cfP3jeEJfgonF/sTdGLNDRxS/TfV97xMd8Y+1n+PCa0d/5ps0dMyGJHV6kzLJLaJSF5UU9geb8uZDCBkySHBikhiodivCYA+ysItvsXV/Ag4kT7RAISVZ29wbGXNsWEp7CpUOg6mHCE=
Received: from DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) by
 DS7PR12MB5862.namprd12.prod.outlook.com (2603:10b6:8:79::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.16; Mon, 31 Oct 2022 08:10:30 +0000
Received: from DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::9fe:10b1:7abb:dc01]) by DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::9fe:10b1:7abb:dc01%9]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 08:10:30 +0000
From: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdgpu: Introduce gfx software ring (v8)
Thread-Topic: [PATCH 1/5] drm/amdgpu: Introduce gfx software ring (v8)
Thread-Index: AQHY4tFCdUm7wr+3I0+LjZYSG5hW9q4XYJkAgAACvoCAEMVRUA==
Date: Mon, 31 Oct 2022 08:10:30 +0000
Message-ID: <DS7PR12MB6333440FFC7D991888A2D4A3F4379@DS7PR12MB6333.namprd12.prod.outlook.com>
References: <20221018090815.2662321-1-jiadong.zhu@amd.com>
 <4046cec7-88a1-d91d-9553-678d5165d308@daenzer.net>
 <a4e05017-ac7d-9872-dfad-257be85d1572@amd.com>
In-Reply-To: <a4e05017-ac7d-9872-dfad-257be85d1572@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=82dd2b16-9eaa-43c1-a4dc-1c7719e2ecdd;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-31T07:05:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6333:EE_|DS7PR12MB5862:EE_
x-ms-office365-filtering-correlation-id: 4a7ea282-05fc-4824-107b-08dabb17606d
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NhC8UUGFTDK32Mh8iwEXUiaZkZEjDUtpvItcbzarSsR+m/0X2hqBcxplQWNfj4EeIn/Rnb/4mDdYlW0C5lt4wFwRo1qjDYqqcL5LlN0lCCyDKbyARhiHa/K77PgKfSCYNAS3i/eir/zgn6sZvMU4nlZs78zMArSw7JsATYBwOjCjgEgNbtCJR73mYIzhqZ1T31UXPXQumcfldbyVEitRHhtfNS+hmLMlURwIA6fgN2afRNM4aYKGao4Nezx7blQF1W7j5ZjLsyNokkHCw6Z4LxQ0UtsghJlOMWRNRQWbH4hA7tTS8wS6M4R0QvZuJTsvzkZichpM804Lxe5sKynVrdZL3djwhfbklf7gCe5Ylm7KGRgz2QMIeg2/5IISH5dxr22LNgLqWdaEiJTE3oNmWJylab71g75eXFoIXVeDvBy81TMdzR3Z1tpZTu7453f9ZppyPTXwwsngw3+2km4GYCizOkz6ll7TAgQZ6yidUkfDMjZYXD17ZUWDeyZbAioO44eEcGzDB8iCUNFQdfFkqoJUcr8gsPp2LbUvDrzEQspkKMkB2q1rn2bJaT4dv/JXZbDgq2c/J8BwXQvFyCJBFz8G0JwB69Gp3Yo2D21zba9xbyDqNMhIw6Wy7zGozUjLoBvQs6DB82ApKzF0qc3g0j/ekMlZxIdMDzoUQQo4Kk6JOQiFgYVecj3LcA609NJHvIeu2eJjitd9IafeRTKpv9GL7l6hatuLittXZbC0z/xAco4/wSLkT6vxZSVnRi0q1cP9BAQb+J4idHH+axVbVg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6333.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199015)(122000001)(6506007)(7696005)(38100700002)(53546011)(478600001)(8936002)(41300700001)(9686003)(26005)(55016003)(33656002)(316002)(66446008)(52536014)(76116006)(66946007)(64756008)(54906003)(110136005)(4326008)(66476007)(8676002)(66556008)(71200400001)(83380400001)(66574015)(4001150100001)(2906002)(186003)(5660300002)(86362001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cW9tdHA5K2F0cDdKME53WWFyVEc5ZTkxdld6UmpQaXg1cHg4OFZCdzY1RzE0?=
 =?utf-8?B?YWt0YmdQK09HakI2SkdRS0lIWEhvN05RTXFKeTRMK3JHRTQrRXFoSlM1OWVm?=
 =?utf-8?B?VzFWZzRBNDV0MW1tOXVoMGxZRzlGVnpFQWd0YmRGY3pUVFpSc0ppSnh5T3d3?=
 =?utf-8?B?eGgwVUNqbFVlTGcrVmZ4Qlo4ckxLelJRaFNwcm50S3NPY3U1c3RvY21DNDJi?=
 =?utf-8?B?ZThObXFGeHhxOFN6NGV6Y1Ewbkc3Ti85dFFXRnBEVCtSQ1R6T09odVVhRlVY?=
 =?utf-8?B?Z2o1TzF4c3M3R1J6RlhGTWYvWE5MMU1hYU4vckZWVzJDcmYyYmk2NXY0MlQy?=
 =?utf-8?B?V2JyaE1FYUFTMVpKK3ZCemtTNkxyZG4wQUFuaitRTk1tRjhvWjNUdGxIckZ2?=
 =?utf-8?B?aVlheWlwN2NDWXdxaCtPc2pvaWd4TTROMERBR3BjUEpUeUg0L04vazliWlk4?=
 =?utf-8?B?bGZQbDl2K0FDS0p0T1E1UWlWUUMzbnI2TkgwTmdVVTZod2NWTVdLc0ZKN2Nu?=
 =?utf-8?B?eU1LM1l3Umk1N1JQMnh0R2NydW5TMUdJQ0s5NlV3NXVSTFpNbVo5Z3BWSHJw?=
 =?utf-8?B?d3pNRUFGcG9pZkh4SWVodFgvNEFDS1ZJL2pwOCtSK2dOL0ttNHVNZE83VnJU?=
 =?utf-8?B?M1V6UDlLcXVSUEJqOTFtejN2OU9lSU1hdmdGK1grU1dQem9ZU1NBZFlGNFlM?=
 =?utf-8?B?MVpvWmhvSEdacmpkZlpoQ3R4WUEvVm9RUStMVWpqUTR2MEdCeXlxM0xhRzlR?=
 =?utf-8?B?NnZzVlNjUVNldEZxNzBUa3V4dnY4Q0JiV3ZWN1FJaUFUbUVXY3BoU0E2OTZG?=
 =?utf-8?B?Q044eTVRazNIMVZWdEIvMVhDUk1ia256SzRFdVltTmdaN1JPZFovaVhtL0dp?=
 =?utf-8?B?MTlvNkt2MmZyVWJBTi9VdE5nTjhsNUkxVUtNb3h5V1NER3ExSU5jaFk0R1JT?=
 =?utf-8?B?NEpZazVQRXlidS9RcUxmNWJ5dVJ6WjhlbytZakF5aFdJWGxoY0c0MHhxdXpa?=
 =?utf-8?B?VDBYMmtORDJOTXA4U1BPR3hicmVVQXhERjFCb0l2QkxRRDd4MXFSUXE5aVFF?=
 =?utf-8?B?Uk5VNW5yeXZjY01WUjVUN3JuYklrLzhPWjROeVdES3lpelNGVDE0ZlZBUUpj?=
 =?utf-8?B?d3IrNFFDVklERUUxemNzVXV6Wkx1dkE2S29xdGt6cjBadXg4SnYzSys1MURy?=
 =?utf-8?B?aHFZb2NKTWE4K2FKSDdZa1JwUitTMWdSOERaYWpmalZpeC9PeXJsVHFKSXox?=
 =?utf-8?B?R0RzcVBNMEVZbmR2VmNva2RUQzVTTzQ1ZjBJVm5SM0Jzd1FqejhLc29zSG9N?=
 =?utf-8?B?bDJ4RFJQZ3dhUWpxOTB6L1UzbzNpNSs1YUVwdmNTalZDczBrL0FBR3JlWXFY?=
 =?utf-8?B?SHlRaGlXWGJ3MnM2eDFsN3hsMXUzRVNmamo3ZFE0U2ZwSSsxNkltcXkrSzdU?=
 =?utf-8?B?cWlZcER3VC9xN1RvTWQrNjJ4NXJqN0xJbnphUUVSQi8wZWtGa2llTEJhWTQ3?=
 =?utf-8?B?akFkalEzRGdIdzZaMEFDZitWaGJPVzg4azh5ZWM5blhYUnlMVGkrWTJYemNi?=
 =?utf-8?B?eWZ0Z0p1Tkc5a2lxeHBNeENSY3gxZldjUDdWNnorS3dwWTA4L0tnVk1tMWtw?=
 =?utf-8?B?K1ZHd0NTRVFUYUp2dENMYzV3aTFQRXFlWENab2diQ0Z2NGRkRkhyRXdxT1Ri?=
 =?utf-8?B?WUljUlIycjVqUmFJbXp5SmNuK3p4SEs0cHZ0TWRhSXpLemZTZFFrUEhjRTEw?=
 =?utf-8?B?eTBidkVLajdKL1lRbHlRazU2UHd3M0p3dHpUSnlGeEVJTDBrUUxlVmV0WVNN?=
 =?utf-8?B?SlRMMS90b1JQMlBodkNvelM0M25vd3JiKzE4RmNrL0YxMlZ4L2ZmcW0wY2lR?=
 =?utf-8?B?cjBxWWtzb0NRRzR1Rm4zdUJGdTBibkh0WUtBMFJZME1BSkZ5R3oxdTdJdDNG?=
 =?utf-8?B?VGs2SG4vc1VRTHNaY2dieThiMmFzNEgrQ0sxY0JWNEl1anJheDN3VVYxR3Bs?=
 =?utf-8?B?V3NCVnJKbWszOElacDh6MWszZmUzRmJ4bzdUOExLTHh2WmlXQ1ZNeHhHOGNS?=
 =?utf-8?B?enJ2V1RUMytpek5wWTJyUXNrdkRUbkZNcVVDVWljNGpzQjRqK00vMCtsV0JF?=
 =?utf-8?Q?IJeZdu73iOUQr8/3gxNmyVFTa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7ea282-05fc-4824-107b-08dabb17606d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 08:10:30.2280 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rHYcL7kjYbA74AKMROHLCh0gzj4PX1nvE3eu1SMvJxS+Hcc2ycU6g/I8gBy92Vb90GhzaFLaSapiROAE5/DhpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862
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
Cc: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Grodzovsky,
 Andrey" <agrodzov@amdcloud.onmicrosoft.com>, "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE1pY2hlbCwNCg0KU29ycnkg
Zm9yIHRoZSBsYXRlIHJlc3BvbnNlLiBJdCBpcyBtb3JlIGxpa2VseSB0aGUgbnVsbCBwb2ludGVy
IGlzIHJhaXNlZCBmcm9tIGZ1bmN0aW9uIGFtZGdwdV9yaW5nX3ByZWVtcHRfaWIgYXMgcHJlZW1w
dF9pYiBpcyBub3QgYXNzaWduZWQuDQoNCkNvdWxkIHlvdSBoYXZlIGEgY2hlY2sgcHJlZW1wdF9p
YiAgaXMgc2V0IGluIGdmeF92OV8wLmMgZnJvbSB0aGUgcGF0Y2ggImRybS9hbWRncHU6IE1vZGlm
eSB1bm1hcF9xdWV1ZSBmb3JtYXQgZm9yIGdmeDkgKHY0KSIuDQoNCiINCi4uLg0KLnByZWVtcHRf
aWIgPSBnZnhfdjlfMF9yaW5nX3ByZWVtcHRfaWIsDQoiDQoNCkJ0dywgV2hpY2ggYnJhbmNoIG9m
IGttZCBhcmUgeW91IGNoZXJyeS1waWNrPyBNYXliZSBteSBjb2RlIGJhc2UgaXMgdG9vIG9sZC4N
CkkgdHJpZWQgdXNpbmcgd2F5bGFuZCBvbiB1YnVudHUgMjAuMDQgYW5kIG5vdCByZXByb2R1Y2Vk
IHRoZSBjcmFzaC4NCg0KVGhhbmtzLA0KSmlhZG9uZw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4N
ClNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDIwLCAyMDIyIDEwOjU5IFBNDQpUbzogTWljaGVsIETD
pG56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD47IFpodSwgSmlhZG9uZyA8SmlhZG9uZy5aaHVAYW1k
LmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogR3JvZHpvdnNreSwgQW5k
cmV5IDxBbmRyZXkuR3JvZHpvdnNreUBhbWQuY29tPjsgSHVhbmcsIFJheSA8UmF5Lkh1YW5nQGFt
ZC5jb20+OyBUdWlrb3YsIEx1YmVuIDxMdWJlbi5UdWlrb3ZAYW1kLmNvbT4NClN1YmplY3Q6IFJl
OiBbUEFUQ0ggMS81XSBkcm0vYW1kZ3B1OiBJbnRyb2R1Y2UgZ2Z4IHNvZnR3YXJlIHJpbmcgKHY4
KQ0KDQpBbSAyMC4xMC4yMiB1bSAxNjo0OSBzY2hyaWViIE1pY2hlbCBEw6RuemVyOg0KPiBPbiAy
MDIyLTEwLTE4IDExOjA4LCBqaWFkb25nLnpodUBhbWQuY29tIHdyb3RlOg0KPj4gRnJvbTogIkpp
YWRvbmcuWmh1IiA8SmlhZG9uZy5aaHVAYW1kLmNvbT4NCj4+DQo+PiBUaGUgc29mdHdhcmUgcmlu
ZyBpcyBjcmVhdGVkIHRvIHN1cHBvcnQgcHJpb3JpdHkgY29udGV4dCB3aGlsZSB0aGVyZQ0KPj4g
aXMgb25seSBvbmUgaGFyZHdhcmUgcXVldWUgZm9yIGdmeC4NCj4+DQo+PiBFdmVyeSBzb2Z0d2Fy
ZSByaW5nIGhhcyBpdHMgZmVuY2UgZHJpdmVyIGFuZCBjb3VsZCBiZSB1c2VkIGFzIGFuDQo+PiBv
cmRpbmFyeSByaW5nIGZvciB0aGUgR1BVIHNjaGVkdWxlci4NCj4+IE11bHRpcGxlIHNvZnR3YXJl
IHJpbmdzIGFyZSBib3VuZCB0byBhIHJlYWwgcmluZyB3aXRoIHRoZSByaW5nIG11eGVyLg0KPj4g
VGhlIHBhY2thZ2VzIGNvbW1pdHRlZCBvbiB0aGUgc29mdHdhcmUgcmluZyBhcmUgY29waWVkIHRv
IHRoZSByZWFsIHJpbmcuDQo+Pg0KPj4gdjI6IFVzZSBhcnJheSB0byBzdG9yZSBzb2Z0d2FyZSBy
aW5nIGVudHJ5Lg0KPj4gdjM6IFJlbW92ZSB1bm5lY2Vzc2FyeSBwcmludHMuDQo+PiB2NDogUmVt
b3ZlIGFtZGdwdV9yaW5nX3N3X2luaXQvZmluaSBmdW5jdGlvbnMsIHVzaW5nIGd0dCBmb3Igc3cg
cmluZw0KPj4gYnVmZmVyIGZvciBsYXRlciBkbWEgY29weSBvcHRpbWl6YXRpb24uDQo+PiB2NTog
QWxsb2NhdGUgcmluZyBlbnRyeSBkeW5hbWljYWxseSBpbiB0aGUgbXV4ZXIuDQo+PiB2NjogVXBk
YXRlIGNvbW1lbnRzIGZvciB0aGUgcmluZyBtdXhlci4NCj4+IHY3OiBNb2RpZnkgZm9yIGZ1bmN0
aW9uIG5hbWluZy4NCj4+IHY4OiBDb21iaW5lIHNvZnR3YXJlIHJpbmcgZnVuY3Rpb25zIGludG8g
YW1kZ3B1X3JpbmdfbXV4LmMNCj4gSSB0ZXN0ZWQgcGF0Y2hlcyAxLTQgb2YgdGhpcyBzZXJpZXMg
KHNpbmNlIENocmlzdGlhbiBjbGVhcmx5IG5hY2tlZCBwYXRjaCA1KS4gSSBoaXQgdGhlIG9vcHMg
YmVsb3cuDQoNCkFzIGxvbmcgYXMgeW91IGRvbid0IHRyeSB0byByZXNldCB0aGUgR1BVIHlvdSBj
YW4gYWxzbyB0ZXN0IHBhdGNoIDUuDQpJdCdzIGp1c3QgdGhhdCB3ZSBjYW4ndCB1cHN0cmVhbSB0
aGUgc3R1ZmYgbGlrZSB0aGlzIG9yIHRoYXQgd291bGQgYnJlYWsgaW1tZWRpYXRlbHkuDQoNClJl
Z2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4NCj4gYW1kZ3B1X3N3X3JpbmdfaWJfYmVnaW4rMHg3MC8w
eDgwIGlzIGluIGFtZGdwdV9tY2JwX3RyaWdnZXJfcHJlZW1wdCBhY2NvcmRpbmcgdG8gc2NyaXB0
cy9mYWRkcjJsaW5lLCBzcGVjaWZpY2FsbHkgbGluZSAzNzY6DQo+DQo+ICAgICAgIHNwaW5fdW5s
b2NrKCZtdXgtPmxvY2spOw0KPg0KPiB0aG91Z2ggSSdtIG5vdCBzdXJlIHdoeSB0aGF0IHdvdWxk
IGNyYXNoLg0KPg0KPg0KPiBBcmUgeW91IG5vdCBhYmxlIHRvIHJlcHJvZHVjZSB0aGlzIHdpdGgg
YSBHTk9NRSBXYXlsYW5kIHNlc3Npb24/DQo+DQo+DQo+IEJVRzoga2VybmVsIE5VTEwgcG9pbnRl
ciBkZXJlZmVyZW5jZSwgYWRkcmVzczogMDAwMDAwMDAwMDAwMDAwMA0KPiAjUEY6IHN1cGVydmlz
b3IgaW5zdHJ1Y3Rpb24gZmV0Y2ggaW4ga2VybmVsIG1vZGUNCj4gI1BGOiBlcnJvcl9jb2RlKDB4
MDAxMCkgLSBub3QtcHJlc2VudCBwYWdlIFBHRCAwIFA0RCAwDQo+IE9vcHM6IDAwMTAgWyMxXSBQ
UkVFTVBUIFNNUCBOT1BUSQ0KPiBDUFU6IDcgUElEOiAyODEgQ29tbTogZ2Z4X2hpZ2ggVGFpbnRl
ZDogRyAgICAgICAgICAgIEUgICAgICA2LjAuMisgIzENCj4gSGFyZHdhcmUgbmFtZTogTEVOT1ZP
IDIwTkYwMDAwR0UvMjBORjAwMDBHRSwgQklPUyBSMTFFVDM2VyAoMS4xNiApDQo+IDAzLzMwLzIw
MjANCj4gUklQOiAwMDEwOjB4MA0KPiBDb2RlOiBVbmFibGUgdG8gYWNjZXNzIG9wY29kZSBieXRl
cyBhdCBSSVAgMHhmZmZmZmZmZmZmZmZmZmQ2Lg0KPiBSU1A6IDAwMTg6ZmZmZmJkNTk0MDczYmRj
OCBFRkxBR1M6IDAwMDEwMjQ2DQo+IFJBWDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6IGZmZmY5OTNj
NGE2MjAwMDAgUkNYOiAwMDAwMDAwMDAwMDAwMDAwDQo+IFJEWDogMDAwMDAwMDAwMDAwMDAwMCBS
U0k6IDAwMDAwMDAwMDAwMDAwMDAgUkRJOiBmZmZmOTkzYzRhNjJhMzUwDQo+IFJCUDogZmZmZjk5
M2M0YTYyZDUzMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiAwMDAwMDAwMDAwMDAwMDAwDQo+
IFIxMDogMDAwMDAwMDAwMDAwMDAwMCBSMTE6IDAwMDAwMDAwMDAwMDAwMDAgUjEyOiAwMDAwMDAw
MDAwMDAwMTE0DQo+IFIxMzogZmZmZjk5M2M0YTYyMDAwMCBSMTQ6IDAwMDAwMDAwMDAwMDAwMDAg
UjE1OiBmZmZmOTkzYzRhNjJkMTI4DQo+IEZTOiAgMDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpm
ZmZmOTkzZWYwYmMwMDAwKDAwMDApDQo+IGtubEdTOjAwMDAwMDAwMDAwMDAwMDANCj4gQ1M6ICAw
MDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0KPiBDUjI6IGZmZmZm
ZmZmZmZmZmZmZDYgQ1IzOiAwMDAwMDAwMTk1OWZjMDAwIENSNDogMDAwMDAwMDAwMDM1MDZlMCBD
YWxsDQo+IFRyYWNlOg0KPiAgIDxUQVNLPg0KPiAgIGFtZGdwdV9zd19yaW5nX2liX2JlZ2luKzB4
NzAvMHg4MCBbYW1kZ3B1XQ0KPiAgIGFtZGdwdV9pYl9zY2hlZHVsZSsweDE1Zi8weDVkMCBbYW1k
Z3B1XQ0KPiAgIGFtZGdwdV9qb2JfcnVuKzB4MTAyLzB4MWMwIFthbWRncHVdDQo+ICAgZHJtX3Nj
aGVkX21haW4rMHgxOWEvMHg0NDAgW2dwdV9zY2hlZF0NCj4gICA/IGRlcXVldWVfdGFza19zdG9w
KzB4NzAvMHg3MA0KPiAgID8gZHJtX3NjaGVkX3Jlc3VibWl0X2pvYnMrMHgxMC8weDEwIFtncHVf
c2NoZWRdDQo+ICAga3RocmVhZCsweGU5LzB4MTEwDQo+ICAgPyBrdGhyZWFkX2NvbXBsZXRlX2Fu
ZF9leGl0KzB4MjAvMHgyMA0KPiAgIHJldF9mcm9tX2ZvcmsrMHgyMi8weDMwDQo+ICAgPC9UQVNL
Pg0KPiBbLi4uXQ0KPiBub3RlOiBnZnhfaGlnaFsyODFdIGV4aXRlZCB3aXRoIHByZWVtcHRfY291
bnQgMSBbLi4uXQ0KPiBbZHJtOmFtZGdwdV9qb2JfdGltZWRvdXQgW2FtZGdwdV1dICpFUlJPUiog
cmluZyBnZnhfbG93IHRpbWVvdXQsDQo+IHNpZ25hbGVkIHNlcT0xNDg2NCwgZW1pdHRlZCBzZXE9
MTQ4NjUgW2RybTphbWRncHVfam9iX3RpbWVkb3V0DQo+IFthbWRncHVdXSAqRVJST1IqIFByb2Nl
c3MgaW5mb3JtYXRpb246IHByb2Nlc3MgZmlyZWZveC5kcGtnLWRpIHBpZCAzNTQwIHRocmVhZCBm
aXJlZm94OmNzMCBwaWQgNDY2NiBhbWRncHUgMDAwMDowNTowMC4wOiBhbWRncHU6IEdQVSByZXNl
dCBiZWdpbiENCj4NCj4NCg0K
