Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38634C54EBC
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 19:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 902DD10E1C2;
	Tue, 10 Jan 2023 19:40:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C16A610E1C2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 19:40:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOrk7lH5fRjPjQK+pUEjuqFLwX7kIz07HOlBX06GBM+Gq1H0lj+rtCsBcI7fb1KLWSXLO/lNgdUihvdZHvZD202c8vClCHvHCvlt5byR53A8KtKMRqfONgwfvFqHSBYN1wsyaJWKEDTuO6+3FP0VwXNiNzq/C1prwQN0/pSyhcRdFpGG2Og833RRYBE9nJBMI/Wna3p46yHTpB1IpJ8KTQHpVih6WYGtcoH5u6pf4CTQkGvHmupt9UOx3gWRF+h/w+Gvds8AhnoG/etRkajXivej0fObp/nNAGBjlGF6/2/k+SjpQx4HX11esySDcgvCny2UaOPZA3Vcvs9jpFPs5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJq8cCWwbRnX8oAbAWZK98aIErkxXWynm+xA939j4IA=;
 b=CmxC1b6EQAAq2b9iN4lM8Oh8AUf8dSvcL7DdBtecWGh+i4V72ejCXI91lPCvB81ILrFlcoyxRKYN4nllVoX7EsQG9c8BQfb6LDfzracvjpep6lZCpGlw0vqFMhUvfw6bDc6dbrxz6mJ1Wihs6RFUGdjEQuev98gOOJyTWlSahXROIpQOB3ysx4hqloCfZ1V7QD8NF9/o0R9fz9hmY+uAhiSOwoEo9YriayAdcbEyXb0JRwmnvERj/2eDPC+R9RRjUhxBuLintr2xzzxMh/O39xgsdsuIX7oXyiL4dGymfgWdSB4nrGesZr2tnzItrtVoTXcJzlo3VJrtz4jX9DWYHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJq8cCWwbRnX8oAbAWZK98aIErkxXWynm+xA939j4IA=;
 b=qqqb9ztUE5naV3i8VicEln0dkgYZFNt8n1ZtU1oHNC4DlsyOU4wwfekMCUH2xgOs4HBwBIF4xVrhDi9Emk9GeUDiB1dQGU7VT32I4JAXRAG/vshOEIdlMnKYuQfAYLlFxhrV19JMjH9LQn5sXL8QtJzK5wTmh6+G+eB2/Ayx5Bg=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 19:40:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%7]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 19:40:31 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd: Only load TA microcode for psp v12_0 once
Thread-Topic: [PATCH] drm/amd: Only load TA microcode for psp v12_0 once
Thread-Index: AQHZJSf3X7xKujxrxEWZ3EiMNpcrVa6YCWaAgAAC3TA=
Date: Tue, 10 Jan 2023 19:40:30 +0000
Message-ID: <MN0PR12MB6101F4E129A260830E72B2BEE2FF9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230110191547.5042-1-mario.limonciello@amd.com>
 <CADnq5_M1z0j1559YkadccZ-d3MAw1K7ZZb-gJeyrykdQgn=utg@mail.gmail.com>
In-Reply-To: <CADnq5_M1z0j1559YkadccZ-d3MAw1K7ZZb-gJeyrykdQgn=utg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-10T19:40:29Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6a9663dc-96b2-47cb-bcb7-46e4bcaf22f0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-10T19:40:29Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: ee30a24f-ad54-413a-8128-5881d0527e25
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|PH7PR12MB5596:EE_
x-ms-office365-filtering-correlation-id: ce07a0ea-a95d-4b2d-19fd-08daf3428886
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FL95gVGINE6Dc9ypEpCSpnI7ZO+Pm+YEQ1RF6M2vW4XP7+v+EJyfGx8fldGZPJP1JEiqV0URvLHdtdS+6UoniRAyl83OziMyb7dOH3lKZoIibiN60j1EaOdvEEf4auHyI3rCwwRnQwvEWKgk6bGSXfA+HSpqdjdYhZd9lmyk4cn2sQgyhPhUm/5s3+lSy23shM+mdS5X4HhvkSzOMuW0vTcQuqJBHiZtL2ynzYRUhNDpsVt2v0bPMBWCRaS9XEGLVKuxlDc2C7oZcKsbP4uJlNdt68UBFFMFV1mDBdxR/dGSNYNjJoN36ZnRdcFGm5uRBVaIPQq8E7tRO2czK0sOd/eNcRvBpO3Uls95tI9BCEIfAcK3oXT4ujfaWiWmhTbVmmsTIhLVGVoB4VBbWWL+yyxEG3Dy5oHnFedAiCM1QlZHuvOe5Zg3zX87+syGW3TKt8884eap5OfkQJSgozxBQeDnvkxFyH8mvE2e6sjBiaDqWLf5brr1CNJaUs1k5YpKu4PotXeuM98Xm5yECqHGPn244xnKoaWzoqKIVjgkDgIoDjFyXSll9Qx/ckbtrTHeS/psmqTukdTXMP3O40qoCWqnS7byM0oZJZC7hG0BqnjB2wsENTPuq/KslBUTFypkFpKO12vlS8x/vH+2WiGHcml5uu3BqtjtDX7mgBtuDST34MsgUIm4whbvvVZ9dEYbezYpRUKDx6kCHf5dH7tqPw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199015)(38070700005)(33656002)(6916009)(71200400001)(7696005)(316002)(55016003)(86362001)(122000001)(9686003)(38100700002)(186003)(53546011)(26005)(8936002)(2906002)(76116006)(478600001)(6506007)(5660300002)(66946007)(52536014)(66446008)(83380400001)(66476007)(66556008)(41300700001)(4326008)(64756008)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0RGTmg0U1BDOFFiRzNsOWpvM0plK0d6N3Z1NzZ6a0o4b1JRT3FTd0swNDhC?=
 =?utf-8?B?OTFOcGVYK3d6WjM5azdFQXdkQmZtVFQxekRrWThRd3l0VW5wN29WMkl1Zi9J?=
 =?utf-8?B?QXFOVnhBcFd3ckFYWi92UVBnVHJuQS84dWNCMGJ4V3B1c1dLRGk2YzJYbjc3?=
 =?utf-8?B?T2VpVm5meFVtMkRwbmovQzV4YmxsQ20zNzRJTmpQUloyc3FvY2hqRkVSQ3R4?=
 =?utf-8?B?UTlSdm1kbVZpb05qaDFueU5UdXlxUzg4bTZTUkVjVkVKVmRrbUhkdGNubW9G?=
 =?utf-8?B?eld4K0lzQm9uY1pPZDRYYnlIaHpQdnJ3a3dXU2ZnUzNjQTlUTUtuQmlVblVS?=
 =?utf-8?B?bzhzOVg4SzZOVlZkVnBEWllDQ0RBWEM0US9XSXVzNHF5VE1DNUphQ3cxRzJF?=
 =?utf-8?B?WWJIY1ozTmNPN0NXSk9kSTlDUGJ0Mis1Q2xFcUU4UnZqMWpKRmtESFNrd2Nx?=
 =?utf-8?B?U3JCbXhXbGJ3NW03SGZrK1VUeXorQWgycUJRVVZIdXBrWVhiTzI2NlgyUnIz?=
 =?utf-8?B?SDAyK0xZczF4Q2FRcXFpM2xjdlZaQmIrSFBVcXB1NlJsMFFKbFFmSDJyeEpn?=
 =?utf-8?B?OEVWdFR5dk1LaW9mUDdpQ2x6aXZ5cUtPY25BK0FwdDZFTFprb3IwZlJTbFRr?=
 =?utf-8?B?eEFaZEFtcXlNblloVUV3U1V3a2hWUWNwWTUzSE5YSUp6Rzc3Z0lRQnNZdGZG?=
 =?utf-8?B?OEhqak5GR3lYaFo2ZVpRZ3ZJYVRpR1FSSFJhWTRUMzMzeUdaQ09IU252NGZT?=
 =?utf-8?B?ZXJieTNsOUlZSGE2ZXIwSGZWa1FzR1Rla2pLdEU3ZTFVS2hvY296N2dicHIx?=
 =?utf-8?B?c1ZxdFNWL3lmK0oxbThPUHNzY083VWV6VE1JQTNJRmpHMGgyZUc1TDJoN0FE?=
 =?utf-8?B?VGJXd01rM2hNZVJEOGhwT2JYVklmTjhpNFZNcDlBUWt3ZE1EWTE0K0Y0VFVI?=
 =?utf-8?B?ZEpoK2t1bEMzQXcweG5SUDYySkpJMVlwZFlZcnFIcGUxYUFZQ3ppY05wOVJa?=
 =?utf-8?B?b0hOUGRyZEFaR2lNc2hhSy9kU2M1SXJkTU9tR0I4WHRRcVYra0Q1TUxuS2lO?=
 =?utf-8?B?SGJLRHhNVXFQT21MYTJiNWZBNnBZVmNXcFk2WDV4V1RjdkpvMW9ieE43Rlpp?=
 =?utf-8?B?R3BFa2dyOThqRDhVZlVSaVRESjJyK2ZJdmZVYjJzazlOVmJpdnRjamhNbUtE?=
 =?utf-8?B?cGwyOEtaejErOHVRYlJKQWlEdElvZkJUT3B2QThoelRIZGZ0azNOWjZZNGdR?=
 =?utf-8?B?OGNVNzdndzRWMS92WkNxYjRwRkMyWDFEUXMwRHliUE5DWW1kVnlZTktEZmNs?=
 =?utf-8?B?RFcvaERFQ3M5bXc4SDRYM3dSclJSRWF3dElWYVRaNUxKUHoycXdJZWQ2VCtD?=
 =?utf-8?B?Qm1iZ0ZzT2VOY01rVzhMc2Fqb2JuZDZSTEhJSU5rSHUvWWpjbGlZUTVCeTlk?=
 =?utf-8?B?VTFQQjY3WDlxWHg5bEhiOE1zNVhTcS9IQksycDFpYndMUU5vZjh0WnRKUHV1?=
 =?utf-8?B?UDFJQ3h6dFdHTzg0N2FoWXB0UnNmYlc2SW05dExwcUs1cjNEdmY4Qkd3UEw0?=
 =?utf-8?B?RlhnWlUrZ3lIVDh0MjlIOWxKclpjSHhNRFRIYWZwWUZmRUZGRHNCWnI5cTQ0?=
 =?utf-8?B?RmVZU0ptbkVmR29ML0h6bWdJTXY2cXpYV09BZnhjK3JzejU0RTJFdm9naWww?=
 =?utf-8?B?Mm5nU0wyd0lNditqT1hwaVlXQzdTN0VQNmpiRTJzSlhZNDNzQngzZXJzWmh5?=
 =?utf-8?B?UlZjVHhXQm5yUHRXdUZSUVNnRnF1WHNQR1Z0NE41YkQyZ3RsTFhlZWVVS3Vn?=
 =?utf-8?B?QkJOVFJiOStGVENlbHUxQkoyM2YxUlRyWHB6Z1VxVUJpNG9DZWRQdnhWQ243?=
 =?utf-8?B?cVZBNzFRay9iaFg1Rk5rV3pIUEtUL20rc0wrRUR6WmdYOFR4cTJ6VUw1VTBH?=
 =?utf-8?B?bk9mUlAxM2d5VUYxRitNQzZxS0ZtdDl4N1JiM0ZIM3Q4ak13TmE5WWQ4TWNl?=
 =?utf-8?B?WWlvSlpvaVVZcWE0c3k2ZU4rVXcvdDBPZ3IvUFZsN09Zb0pwYUFFY2JSWWZK?=
 =?utf-8?B?MXlsMmFkcmhwTlptdGxlbGYzbGxORVQ3K1NXMzMycnJ6emZNVDhkRzFpK0hQ?=
 =?utf-8?Q?qLzQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce07a0ea-a95d-4b2d-19fd-08daf3428886
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 19:40:30.9915 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wIL+wCb88kHLznDHw8y4TbRPcFJkpHgyEXSfI67DcljaqzmoVLzD1sqq6cJ7yhh0nk+ZOO4pIIHz7uXtbuovsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5596
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29t
Pg0KPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDEwLCAyMDIzIDEzOjI5DQo+IFRvOiBMaW1vbmNp
ZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kOiBPbmx5
IGxvYWQgVEEgbWljcm9jb2RlIGZvciBwc3AgdjEyXzAgb25jZQ0KPiANCj4gT24gVHVlLCBKYW4g
MTAsIDIwMjMgYXQgMjoxNiBQTSBNYXJpbyBMaW1vbmNpZWxsbw0KPiA8bWFyaW8ubGltb25jaWVs
bG9AYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBEdXJpbmcgcmViYXNlIGZyb20gcGF0Y2ggc2Vy
aWVzIGFjY2lkZW50YWxseSBlbmRlZCB1cCB3aXRoIHR3byBjYWxscw0KPiA+IHRvIGxvYWQgVEEg
bWljcm9jb2RlIGZvciBwc3AgdjEyXzAuIE9ubHkgb25lIGlzIG5lZWRlZCwgc28gcmVtb3ZlIHRo
ZQ0KPiA+IHNlY29uZC4NCj4gPg0KPiA+IEZpeGVzOiBmMWVmZWQ0MDFiYWRiICgiZHJtL2FtZDog
UGFyc2UgYm90aCB2MSBhbmQgdjIgVEEgbWljcm9jb2RlDQo+IGhlYWRlcnMgdXNpbmcgc2FtZSBm
dW5jdGlvbiIpDQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxp
bW9uY2llbGxvQGFtZC5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4
YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiANCj4gSSdsbCBzcXVhc2ggdGhpcyBpbnRvIGYxZWZl
ZDQwMWJhZGIuDQoNCllvdSBtZWFuIHdoZW4geW91IHNlbmQgaXQgdXAgZm9yIGRybS1uZXh0PyAg
QXQgbGVhc3QgZm9yIGFtZC1zdGFnaW5nLWRybS1uZXh0IGl0DQpzaG91bGQgcHJvYmFibHkgYmUg
aXQncyBvd24gc2VwYXJhdGUgY29tbWl0IHRob3VnaCBzdGlsbCByaWdodD8NCg0KPiANCj4gQWxl
eA0KPiANCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX3YxMl8w
LmMgfCAzIC0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjEyXzAuYw0KPiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92MTJfMC5jDQo+ID4gaW5kZXggZTgyYTBj
MmJmMWZhYS4uZmNkNzA4ZWFlNzVjYyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9wc3BfdjEyXzAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3BzcF92MTJfMC5jDQo+ID4gQEAgLTU1LDkgKzU1LDYgQEAgc3RhdGljIGludCBwc3BfdjEy
XzBfaW5pdF9taWNyb2NvZGUoc3RydWN0DQo+IHBzcF9jb250ZXh0ICpwc3ApDQo+ID4gICAgICAg
ICBhbWRncHVfdWNvZGVfaXBfdmVyc2lvbl9kZWNvZGUoYWRldiwgTVAwX0hXSVAsIHVjb2RlX3By
ZWZpeCwNCj4gc2l6ZW9mKHVjb2RlX3ByZWZpeCkpOw0KPiA+DQo+ID4gICAgICAgICBlcnIgPSBw
c3BfaW5pdF9hc2RfbWljcm9jb2RlKHBzcCwgdWNvZGVfcHJlZml4KTsNCj4gPiAtICAgICAgIGlm
IChlcnIpDQo+ID4gLSAgICAgICAgICAgICAgIHJldHVybiBlcnI7DQo+ID4gLSAgICAgICBlcnIg
PSBwc3BfaW5pdF90YV9taWNyb2NvZGUocHNwLCB1Y29kZV9wcmVmaXgpOw0KPiA+ICAgICAgICAg
aWYgKGVycikNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIGVycjsNCj4gPg0KPiA+IC0tDQo+
ID4gMi4yNS4xDQo+ID4NCg==
