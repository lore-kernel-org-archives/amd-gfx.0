Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82952EB64DD
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 08:56:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCDEF10E490;
	Thu,  6 Jul 2023 08:56:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 054B910E490
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 08:56:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIlgAgVAZ58sNP0QJJkMfokU+HFNVRXkfcoRNSdk+w/lCbVKqaqdqwB/Dig0uIIEBwBfmvGKG1yX1F0m99JwM69cZqjDSNlpd5ezRAPdLmoSaXu6AmQT+9QRNhaqIVKmCPaYluGbjk3Ttb7btByNf8TkWS+y6SxgKG9B8LySe7UD/pAV24o/vTtG55j1MU+ciCnK/xOmvSPvWzDNNW8qY0ri2T7wlEzwhdSS1NS7IqD1X1W25y9Fluk7DXgGvDk/TEmpdSKKb3KwHraw0ruiiQFT0N2jja0/QuPZo6AehoJyLRGd4eE+8r3UuU3KR59W9JCBThksbfxeh8LWQaoFzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkWh9rP9D2Zmj9PJP0hO3YBW8k4t2VaMUCFqoJPw6eg=;
 b=lrfcAR3u1rMnLrVMSPs1nJKNiuCZfmAKzfypREAte6Ir/VtyqCYRuYr1RtHiQXHsXUeF9kdfpFxlNHtUS6gteT8+UOd7VmdyweJjLisMhYZ32pZfafn7kuVGS0tn+HYXgny63JJWG7wVkm705P1Dgzbw5p0xwlsKFyZ/2ruyrE3fiPmYOC5xfF9OaaWlmZZg88tUkOgnkCW7i6oY7htJqbmlB5ROOb80JtP8I8xA/TuiCbtjV0cjV9Xd9lHJt1eRgHkF4rcCRjh67vEPqX70CFfDIhTic0+GknMaslQ603c5fCTDJg1eIsNduULoJOKTZ3az7/CXWIvQHs2FocFgNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkWh9rP9D2Zmj9PJP0hO3YBW8k4t2VaMUCFqoJPw6eg=;
 b=zA5iVNFBH5rJKt0ZM95t96OxBv0Nzayiqr4dEkOYl08bLMrz68OeD7MwlhDVrfzRKx/lQ97hdcLC8KPGYQDYI+3Z4k7+U/Z699UmARlS81MbF8pUNzbH9u3TL1yIxOre65E1UVo2BD56Pdq7iQyLdN37G72XyPyNm0Bb9GOCe4w=
Received: from DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22)
 by SJ2PR12MB8181.namprd12.prod.outlook.com (2603:10b6:a03:4f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 08:56:25 +0000
Received: from DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::9737:fa90:99cf:733d]) by DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::9737:fa90:99cf:733d%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 08:56:25 +0000
From: "Chen, Horace" <Horace.Chen@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Liu, Leo"
 <Leo.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Clear VCN cache when hw_init
Thread-Topic: [PATCH] drm/amdgpu: Clear VCN cache when hw_init
Thread-Index: AQHZo3tUybEeAAOzBEanpdJnRep6zq+jR7wAgAhnTICAAL/JgIAAE0CA
Date: Thu, 6 Jul 2023 08:56:25 +0000
Message-ID: <DM4PR12MB50728D2B5807050C843AB6FEE12CA@DM4PR12MB5072.namprd12.prod.outlook.com>
References: <20230620132950.1121406-1-horace.chen@amd.com>
 <9c19a828-15ed-c37a-2c07-acf29f489541@amd.com>
 <1fb0cf4f-3ea4-cd0a-64e9-9d6f22e968f3@amd.com>
 <723872f2-b6cc-2ef6-2168-fc855f3dd7b8@amd.com>
In-Reply-To: <723872f2-b6cc-2ef6-2168-fc855f3dd7b8@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e3a5cb93-3b6b-4834-b8f5-f36af75f6acd;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-06T08:33:18Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5072:EE_|SJ2PR12MB8181:EE_
x-ms-office365-filtering-correlation-id: 90ec756c-3d06-4ba5-b04e-08db7dfee114
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BBNWF5RIp44ylAiVelun/63zUkfHyzlp+IEBkv5JHzaZZqRJbhqw74xmPWDOkS/N6sj/kP0e8YMj2uE1y2tNSKvjldq7i0dGqKr33x3hhQ5x7/Z60e8tMVv+7z2sYGzgTadRkn98pGf1tSL0xHNYdfhxHWGlTfnwnTst6bnLuQbtwQ2cUzgoIfQSPoxeGx54aqCcM+88NQIrtiZJZV61sdKEhe3mhY1geIzix4q6H9DP0YbDzoDZHgh/5A1q5gsYiJqB+o+IiqySIoYIkU+U9d3LLJqD0XBtXDGcLcY6vdHzZtXijrie5V8may4yr7AGpuG8Px4wna5QYhDv2qc2Qj3FNwNuJLrPxjv3UwT1aPM2F1IbcsRkOd4LBYjVr7moQz7GyRkX2F/6qWO2eZRm/ZYXI2y5683UsgJXo08wCRDS72f88fg5TohBnp8YHayDo6zSRLlhdB61cmfRvdi8MvBpFyE8NE1CUmDN/mkV7QLZVswxHZUrUQKl6thkcMi8SvHQKs8pkNgYHTb4Rc0Tfs6Rspn3UIIH/Imj54xQoi4zGnu48NESBILScRugJ1MHxV5DLCBUI6bPUWX6GZDxDODauCAuKxw2F6Ee1SKX9fvZxgvSzaf/IRiFDGML3aMT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(186003)(41300700001)(7696005)(38100700002)(66574015)(53546011)(26005)(6506007)(122000001)(83380400001)(71200400001)(9686003)(55016003)(38070700005)(54906003)(86362001)(66556008)(478600001)(316002)(2906002)(64756008)(66476007)(4326008)(76116006)(66446008)(8936002)(8676002)(66946007)(33656002)(110136005)(52536014)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0RYSmtnVC9KT2UvSis0aDlkTGU5VmgwQXdnY0dHdXo2Wnl1anY2SERyWGFW?=
 =?utf-8?B?NFh6TzA4cURmZDNhVVlRenlhWjlmU2c2akVxTnhYMkx0VmdwYjU0UXZjSm5l?=
 =?utf-8?B?UUYrWmNidVcyZnB3ZkRYeUdSUWJKbERndDd0N2daVURnSTB2V2lOLy9zUUE4?=
 =?utf-8?B?djhOQ0N0NGRHd0lhTTRpQmJNSUJtcHlqczNHSXRzaWsramZtdjR1bTJteDU2?=
 =?utf-8?B?NUVxQmdISUQzVmw1MXBvYWVvSXlEbzREYnpuNm5tcWNSakpuc0lCeUszejdo?=
 =?utf-8?B?RHJFTUdlWEJNYWJmMW0wTVRJbjJ1cVJQbmM3K3JoS1FFdDNrdndaMXR1eTht?=
 =?utf-8?B?VmlKSDA4UTUwOStKNERSQnVib1F3TFlLS3huMmVLQ3BuUkFpTTNrOUZWVDQ4?=
 =?utf-8?B?cWhUaW1YMjdERnp5bi9rUlFFRGlpT1lrM2ZuK0t2bno3M01CNWJhZk9nOE1T?=
 =?utf-8?B?UWJQT3FCeDlTbEVhZHNta2hmT3pXNmcwZ05uZjAvYjBYREdiUnBVeTVNcldo?=
 =?utf-8?B?T3hzdExzVWR3VTRRcXMrbGQyL21EazJ3S0VPcisrMUFHSEZWRDM1aklpcE5D?=
 =?utf-8?B?M2VaUUJmU3c5WXJCeTFxeFB3K0RDUzlCZUxwM3dKemhmaVl1NUpLTEszdm9H?=
 =?utf-8?B?NHN3Q3F4ekZPTE5zMTJFWExIUVBpLzZpeU04UnFvd2NzSmt3ZmVBbEMzOTBv?=
 =?utf-8?B?cEFLeFpVTVdWNDhXNUp4eEkrakh2Q0ZuM05RMmhxbGFQZmJPZGpyVVJUV1M2?=
 =?utf-8?B?Q2x5c0FXdk1qczdveDNneW9LdVlnblh3NmF6c2tMMHc4RnZ5ZFFucFRUbjBI?=
 =?utf-8?B?b0FYS25IVit4RHBjL2VkSzdQRHE5elhiR2U2aU90eGxsejBNbWZmQmhNZGIv?=
 =?utf-8?B?eWJ5clY5d0xOY1ZSRC9rR3I0bGlmbjF1cVN1RnRTcmtMc3RhNUF3TlIvQnpn?=
 =?utf-8?B?bm9WMEdobUZ3aXR6OVhJZWdhblhpMUxralgzbFM4Nm9CMHlwZk5DTFBzRlNS?=
 =?utf-8?B?a2lBS3NnaWZ1NEtJK09hNHFaQXRiUmJOZmt1dnZkdDJmSzZaTnN2M2xsdkpt?=
 =?utf-8?B?Q2o3Rkc2Vy9tYzR4eDVreWE5b3V5cmIzNVd4UTFCU2JDUGZuRC9seEJqdzNw?=
 =?utf-8?B?OGNaeVBrbEFGRlBlaWtjZnJHeVR2SExEZW9JeXNwM0ppRlJwQVpHZFBUZDdB?=
 =?utf-8?B?aVFyL0FKWW5rVFQ3SWl3dlR0bEtRTEthOEdZb0VqWFM4dUFhRDhHTUNneTl1?=
 =?utf-8?B?N0YyUWdoOFBESHgxbjJJWkt1QkJWYzZvSE5icVh1clF6WS81aG1pbG4wU1B2?=
 =?utf-8?B?MzBrZmlORWNPVnZLcUFZcDlKd0oyblExT2plbmNMMGZjWnJlMmxrUXFNNWpy?=
 =?utf-8?B?dEIwb3ZqdTMxazQybUZwRHMwbG12U2FlM3htcU0rdFh5TjNpaE5pT2pBdUhj?=
 =?utf-8?B?eXlpUHo3aEM1QTAzYTErbERNOXJheGdHVkVSWlF5NkF6d3BJOXQrVUE3Q1Mw?=
 =?utf-8?B?TnU1Rm5lZFg0UFdWeUh3QXZ0RHBQeS9RSTFnUm5MYTlWNXNwQkJ3MlVVMmcw?=
 =?utf-8?B?bUxPSVVOS0J6MWxuME5RY3VIekwxaWtmUXNJOVh0c0dzcWJZZzlzMkR0RHVV?=
 =?utf-8?B?SkJlczlXUTdlVUhlOWM1RUNSOWZja0p4dTc5SjNjRGlIaEl2WDF1UlpCbUxG?=
 =?utf-8?B?Wkc0VmlEeW1pVjV1bkM1eFRZOFNLbnNEY2l3TGI2ZVRmSGFSSUFQRjhzNWth?=
 =?utf-8?B?SEZRVUlJVi9VdnFRWlFIc2JaOEZ0ZEg3cnlVK1lySW5SQzROSTl5OUduZ2w0?=
 =?utf-8?B?bzcwZGRjS2syaGlEaVdlU2o2bHI4TTAzdk0wZ0VzVXRwQVhDS2pCTWdwenVl?=
 =?utf-8?B?aFBPTW1Zanp3THNoWmJYY1o1VlJsN3dlM3B3V0lQMDlOZGM1TUI3aUNQeVYr?=
 =?utf-8?B?bE1GY09sN0JaYlczNzFFZWRTNVlYbHhDcFRhWlkwempDbGd4QkRPUk1FTXJ0?=
 =?utf-8?B?SzhhTk1DdHpWaHNrZXU0TFhyaTRJL1N6L1pCVnZZTjlTRENvRWtWUEtmbVFY?=
 =?utf-8?B?d1BUK25HUkFyTWhvb0V5U2ZPYnN3NzFyRTc1U3RCU3hNdWRCekpOSmNCeXZO?=
 =?utf-8?Q?36d0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ec756c-3d06-4ba5-b04e-08db7dfee114
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 08:56:25.3961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sSRqV2YxunuV9N94y59Kw9Ioxen87yJZ8z/t+z2qmL790ymje9MgrhcCr7A4Z07M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8181
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Liu,
 Monk" <Monk.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIENocmlzdGlhbiAmIExlbywN
Cg0KU29ycnksIG1pc3NlZCBMZW8ncyBlbWFpbC4NCg0KQ3VycmVudGx5IFNSLUlPViBWRiBkb2Vz
bid0IGhhdmUgc3VzcGVuZC9yZXN1bWUgdXNlIGNhc2UgYW5kIHRoaXMgY29kZSBpcyBpbiB2Y25f
djRfMF9zdGFydF9zcmlvdigpIHdoaWNoIHdpbGwgb25seSBjYWxsZWQgYnkgU1ItSU9WIGNvZGUg
cGF0aC4gU28gY3VycmVudGx5IHdlIHdpbGwgbm90IGhpdCB0aGUgc3VzcGVuZC9yZXN1bWUgaXNz
dWUgZXZlbiB3aXRoIHRoaXMgcGF0Y2guDQoNCkFib3V0IHdoeSB0aGlzIHBhdGNoIGlzIG5lY2Vz
c2FyeToNCiAgICBCZWNhdXNlIFNSLUlPViB1c2VzIEZMUiBpbnN0ZWFkIG9mIG1vZGUgMSByZXNl
dCBhcyB0aGUgZGVmYXVsdCByZXNldCBtZXRob2QsIGFuZCBGTFIgd2lsbCBub3QgcmVzZXQgVlJB
TSBkdXJpbmcgdGhlIGNvbW1vbiByZXNldC4gU28gaWYgdGhlcmUgaXMgc29tZSBiYWQgZGF0YSBp
biB0aGUgY2FjaGUsIGl0IHdpbGwgY2F1c2UgVkYgY29udGludWVzIHRvIGZhaWwgYWZ0ZXIgcmVz
ZXQuICBXZSBoYXZlIHNvbWUgdGVzdCBjYXNlKHN1Y2ggYXMgZGF0YSBwb2lzb24pIHdoaWNoIG1h
eSBoaXQgdGhpcyBpc3N1ZS4NCg0KSWYgd2FudCB0byBiZSBzYWZlciBpbiBjYXNlIHdlIG1heSBh
ZGQgc3VzcGVuZC9yZXN1bWUgY2FzZSBpbiB0aGUgZnV0dXJlOg0KICAgIGhvdyBhYm91dCBhZGQg
YSAiaWYgKGFtZGdwdV9pbl9yZXNldChhZGV2KSkiIGNoZWNrIHRvIG1ha2Ugc3VyZSB3ZSBvbmx5
IGNsZWFyIGNhY2hlIGluIHRoZSByZXNldCBkb21haW4/DQoNClRoYW5rcyAmIFJlZ2FyZHMsDQpI
b3JhY2UuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLb2VuaWcsIENocmlz
dGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KU2VudDogVGh1cnNkYXksIEp1bHkgNiwg
MjAyMyAzOjI0IFBNDQpUbzogTGl1LCBMZW8gPExlby5MaXVAYW1kLmNvbT47IENoZW4sIEhvcmFj
ZSA8SG9yYWNlLkNoZW5AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpD
YzogUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBYaWFvLCBKYWNrIDxKYWNrLlhpYW9AYW1kLmNvbT47
IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBMaXUsIE1vbmsgPE1vbmsu
TGl1QGFtZC5jb20+OyBYdSwgRmVpZmVpIDxGZWlmZWkuWHVAYW1kLmNvbT47IENoYW5nLCBIYWlK
dW4gPEhhaUp1bi5DaGFuZ0BhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdw
dTogQ2xlYXIgVkNOIGNhY2hlIHdoZW4gaHdfaW5pdA0KDQpTaW5jZSB0aGlzIHBhdGNoIHdhcyBh
bHJlYWR5IHB1c2hlZCBwbGVhc2UgcmV2ZXJ0IGl0IHVudGlsIHdlIGhhdmUgYSB0ZWNobmljYWwg
Y29uc2VudCBvbiB3aHkgdGhpcyBzaG91bGQgYmUgbmVjZXNzYXJ5Lg0KDQpSZWdhcmRzLA0KQ2hy
aXN0aWFuLg0KDQpBbSAwNS4wNy4yMyB1bSAyMTo1NyBzY2hyaWViIExlbyBMaXU6DQo+IFdoYXQg
Q2hyaXN0aWFuIHNheXMgaXMgY29ycmVjdCwgZXNwLiBkdXJpbmcgdGhlIHBsYXliYWNrIG9yIGVu
Y29kZSwNCj4gd2hlbiBzdXNwZW5kL3Jlc3VtZSBoYXBwZW5zLCBpdCB3aWxsIHNhdmUgdGhlIEZX
IGNvbnRleHQsIGFuZCBhZnRlcg0KPiByZXN1bWUsIGl0IHdpbGwgY29udGludWUgdGhlIGpvYiB0
byB3aGVyZSBpdCBsZWZ0IGR1cmluZyB0aGUgc3VzcGVuZC4NCj4gV2lsbCB0aGlzIGFwcGx5IHRv
IFNSSU9WIGNhc2U/IFNpbmNlIHRoZSBjaGFuZ2VzIG9ubHkgd2l0aGluIHRoZSBTUklPVg0KPiBj
b2RlLCBwbGVhc2UgbWFrZSBzdXJlIHRoYXQgYWxzbyBwbGVhc2Ugc3BlY2lmeSB0aGUgU1JJT1Yg
ZnJvbSB5b3VyDQo+IHBhdGNoIHN1YmplY3QgYW5kIGNvbW1pdCBtZXNzYWdlLg0KPg0KPiBSZWdh
cmRzLA0KPg0KPiBMZW8NCj4NCj4NCj4gT24gMjAyMy0wNi0zMCAwNzozOCwgQ2hyaXN0aWFuIEvD
tm5pZyB3cm90ZToNCj4+IEFtIDIwLjA2LjIzIHVtIDE1OjI5IHNjaHJpZWIgSG9yYWNlIENoZW46
DQo+Pj4gW1doeV0NCj4+PiBWQ04gd2lsbCB1c2Ugc29tZSBmcmFtZWJ1ZmZlciBzcGFjZSBhcyBp
dHMgY2FjaGUuIEl0IG5lZWRzIHRvIGJlDQo+Pj4gcmVzZXQgd2hlbiByZXNldCBoYXBwZW5zLCBz
dWNoIGFzIEZMUi4gT3RoZXJ3aXNlIHNvbWUgZXJyb3IgbWF5IGJlDQo+Pj4ga2VwdCBhZnRlciB0
aGUgcmVzZXQuDQo+Pg0KPj4gV2VsbCB0aGlzIGRvZXNuJ3QgbWFrZSBzZW5zZSBhdCBhbGwuDQo+
Pg0KPj4gVGhlIGZ1bGwgY29udGVudCBvZiBhZGV2LT52Y24uaW5zdFtpXS5jcHVfYWRkciBpcyBz
YXZlZCBhbmQgcmVzdG9yZWQNCj4+IGR1cmluZyBzdXNwZW5kL3Jlc3VtZSBhbmQgSUlSQyBHUFUg
cmVzZXRzIGFzIHdlbGwuDQo+Pg0KPj4gU2VlIGZ1bmN0aW9ucyBhbWRncHVfdmNuX3N1c3BlbmQo
KSBhbmQgYW1kZ3B1X3Zjbl9yZXN1bWUoKS4NCj4+DQo+PiBQbGVhc2UgbGV0IExlbydzIHRlYW0g
dGFrZSBhIGxvb2sgYXQgdGhpcyBhbmQgcmV2aWV3IHRoZSBjaGFuZ2UNCj4+IGJlZm9yZSBpdCBp
cyBjb21taXR0ZWQuDQo+Pg0KPj4gUmVnYXJkcywNCj4+IENocmlzdGlhbi4NCj4+DQo+Pj4NCj4+
PiBTaWduZWQtb2ZmLWJ5OiBIb3JhY2UgQ2hlbiA8aG9yYWNlLmNoZW5AYW1kLmNvbT4NCj4+PiAt
LS0NCj4+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92NF8wLmMgfCAzICsrKw0K
Pj4+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPj4+DQo+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92NF8wLmMNCj4+PiBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92NF8wLmMNCj4+PiBpbmRleCBiNDhiYjUyMTI0ODguLjJk
YjczYTk2NDAzMSAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92
Y25fdjRfMC5jDQo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3Y0XzAu
Yw0KPj4+IEBAIC0xMjkyLDYgKzEyOTIsNyBAQCBzdGF0aWMgaW50IHZjbl92NF8wX3N0YXJ0X3Ny
aW92KHN0cnVjdA0KPj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+Pj4gICAgICAgICAgICAgICBj
YWNoZV9zaXplKTsNCj4+PiAgICAgICAgICAgICBjYWNoZV9hZGRyID0gYWRldi0+dmNuLmluc3Rb
aV0uZ3B1X2FkZHIgKyBvZmZzZXQ7DQo+Pj4gKyAgICAgICAgbWVtc2V0KGFkZXYtPnZjbi5pbnN0
W2ldLmNwdV9hZGRyICsgb2Zmc2V0LCAwLA0KPj4+IEFNREdQVV9WQ05fU1RBQ0tfU0laRSk7DQo+
Pj4gICAgICAgICAgIE1NU0NIX1Y0XzBfSU5TRVJUX0RJUkVDVF9XVChTT0MxNV9SRUdfT0ZGU0VU
KFZDTiwgaSwNCj4+PiAgICAgICAgICAgICAgIHJlZ1VWRF9MTUlfVkNQVV9DQUNIRTFfNjRCSVRf
QkFSX0xPVyksDQo+Pj4gICAgICAgICAgICAgICBsb3dlcl8zMl9iaXRzKGNhY2hlX2FkZHIpKTsg
QEAgLTEzMDcsNiArMTMwOCw4IEBADQo+Pj4gc3RhdGljIGludCB2Y25fdjRfMF9zdGFydF9zcmlv
dihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4+PiAgICAgICAgICAgICBjYWNoZV9hZGRy
ID0gYWRldi0+dmNuLmluc3RbaV0uZ3B1X2FkZHIgKyBvZmZzZXQgKw0KPj4+ICAgICAgICAgICAg
ICAgQU1ER1BVX1ZDTl9TVEFDS19TSVpFOw0KPj4+ICsgICAgICAgIG1lbXNldChhZGV2LT52Y24u
aW5zdFtpXS5jcHVfYWRkciArIG9mZnNldCArDQo+Pj4gQU1ER1BVX1ZDTl9TVEFDS19TSVpFLCAw
LA0KPj4+ICsgICAgICAgICAgICBBTURHUFVfVkNOX1NUQUNLX1NJWkUpOw0KPj4+ICAgICAgICAg
ICBNTVNDSF9WNF8wX0lOU0VSVF9ESVJFQ1RfV1QoU09DMTVfUkVHX09GRlNFVChWQ04sIGksDQo+
Pj4gICAgICAgICAgICAgICByZWdVVkRfTE1JX1ZDUFVfQ0FDSEUyXzY0QklUX0JBUl9MT1cpLA0K
Pj4+ICAgICAgICAgICAgICAgbG93ZXJfMzJfYml0cyhjYWNoZV9hZGRyKSk7DQo+Pg0KDQo=
