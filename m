Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FFFF99C64
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 20:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D970710EA52;
	Fri, 17 Apr 2026 20:38:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UBQMSjmk";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013017.outbound.protection.outlook.com
 [40.93.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62E2910E123
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 20:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5amUWTvBIuodjbkdxySPH0y+RoESZ2uJ6Gya47Kd8PX/ni+XJtsg8+1j2f2soNteg4Nk1J+oo6XKY4/wXhpokDCpnh37QVKMK9u7IBlOKoGK7+CESttOWmnwdCw3AOuCTvdl9jiJ+kP+Y+SCQYcEsW3om8Nw7sStL7oO60wGoE3OWJ3fWzksr4/GpehrAx/DEv94e5dH1xY7MQW6OV6jGPo8701XHv1VDOOOUFoDnNWdu6sEZZlrz26PixmqNNfoK3YuyLMc6B5byZT/wDipDg00N62SUMcZndrMxwENfDDt+HORFSB+gIXqhOdpB4eSAjtXC/SrcNjKuZvuH8Hwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QDiMrr4uCS5+jqLpCOTBkBTrMFAAWldOLW0iL8dKb8=;
 b=xC0n+3BRZzKqNm45BSTJAb8xMXNCCC+ZAbO3z6j6DTSMf68sPAM6Go6WkCzGg95kxSJQsSAw1/hOgxBZG+RZG4qC+9ToEQb1AsCyjMyRVkc83bWrhr+tNwwlQaQeJwAA6OR0w3ZhUOQ9wp7hPTB5fDV0y0nwxWdY6xF2iOuwVUL3rhrQfD8JI5hEr+9S/OVIwLrHwGzmBcD+HJrI9bEP40qTi0yw0ZgF6aDlLa9EmMU3dQ2daVjocXX4L6DL+6H1PPYSq73qkLJfVuTnHgPOjPiCcSw7w2gMc1NtL5SlP4pc4fIdI403/lE2jJZHco/B8oCF3pWD2Ni+JOv6KpxIFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QDiMrr4uCS5+jqLpCOTBkBTrMFAAWldOLW0iL8dKb8=;
 b=UBQMSjmke4BQnKynH0nbVmaK+Mum6L6iNJJe4yZDEen6Bw6e7WoDiNe5AzAMIIvEWIseFqn03vZCfPigmFVF916XXBf8sNKQ/AgR2vu1v2TXzwgkc7mmwMCOa4n6RwG+vtKqJSQg3Eb9xhjRZZ2ynMPkItYzccNb4GNcbo5QeNo=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by SN7PR12MB8002.namprd12.prod.outlook.com (2603:10b6:806:34b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Fri, 17 Apr
 2026 20:38:11 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::43e3:7eec:f4e2:b0e7]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::43e3:7eec:f4e2:b0e7%6]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 20:38:11 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>, "Hung, Alex"
 <Alex.Hung@amd.com>
CC: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, 
 Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>
Subject: RE: [PATCH] drm/amd/display: Restore analog connector support
Thread-Topic: [PATCH] drm/amd/display: Restore analog connector support
Thread-Index: AQHczSkSAz+YeurBNEmIvdcjRUjlorXh1iKAgAAfRICAAbMZAIAAEBMA
Date: Fri, 17 Apr 2026 20:38:11 +0000
Message-ID: <CY8PR12MB8193997DCD572A8595EDC60089202@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20260415224150.1807020-1-Roman.Li@amd.com>
 <b6e52939-5593-4874-a8d0-010594d6a637@amd.com>
 <CAFF-SiWw6vJR3uKO3Zw7XrmfF2Vx35dJRVMVviCu2gzhuT6RKw@mail.gmail.com>
 <2356837.vFx2qVVIhK@timur-hyperion>
In-Reply-To: <2356837.vFx2qVVIhK@timur-hyperion>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-04-17T20:33:50.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|SN7PR12MB8002:EE_
x-ms-office365-filtering-correlation-id: e1bafc43-aec2-4b27-86f5-08de9cc13dfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: dDRC1HtzAqDHUFbag+ds1KOC/dIRgoqRc1HEjda6RZudqekmwrDjbuU6V8b5XU7xHiB+So0bM1dLaVSZM4MkHmoy93e0NVXFaMsDj4oeKWFWWiIokz9hDhotA4+uRSYz4CX+tMMAgDG+UVBRTzI3sWldEDdyY/JspYq1G9TTGgKXHnnwfZGE2nYxKRbvCDzhMBrrZXXrFqs+/twXMvzkJZzMNqJvNwG7ywxIyzBUSuwjOoKbZIu4xQIZh/drKFzFUQ7XDkcTP/bEjv9e9P/yIMV7bs3yefm6LruI3TMpSUVes2ukG+qRoXZS5WjE6oJ9qMKpWJr4G2rGcIC5T2YIt5vWmZEQjkrV2BEmA1dO7OKaVJHU00ccz27np2u7GOXL5TtMUyQ46Of+b0za7BftWftbUf7V63XtaUqaz5IucpQXrXNl3orSOJutqrO3KZOYMmR9N4LOgpvQtN4zBbEqTAVciQ48FOKOOF5ag0uHFlotUK+LLWf8YD23OWbo6Fc3GCcMDl4w3Ea2KaVAVCG/Vti0b66zlAiOldV1EbwhwJYLCL/DpoO6SqRnzfF+ycRHm3jkMyeB7+WqYKXuHUfo9hSHBXNsA+vnco797nowyy9hK3VQ8HjIcBupsnU6FLkoeZe26YYEVGmlWCd1257sQrhQGN2+5FJ6ndJ4c9aMuO0NRPwlUbDgUJnehz0fkr4jwcC0+LL8YmnSABaSMOxF+y6d3EtbJkKaN9XiEul+IyFOAQNR0djXAeMk8bsODR2A9+D4diQf+BGAkzMk2r4yUKQZXmQE8AKu9o9SYxuhoM0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8193.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFE1dTUwcVl4elg3cU9VT3dhMXA2djBIZkkvZHhlS3ZjeDBEV1ZTdjBValNk?=
 =?utf-8?B?NE1Qb1VCTHpLQzVsZ01SUWV5VHY3NzRtUHBrK3RZbWhEL2dEcnd5K2RwcW01?=
 =?utf-8?B?MVhUZ21peUJnS1U4SUNTOS80Q1Z3VlE2dXJuVzh0VzlmNU5uMmIzeEFtNS9N?=
 =?utf-8?B?YVg4K3F5aVowUFFGRDhTMmFhUW4zMGYweG0yZTdDNEtnTzVsUUtEUW9wMXM3?=
 =?utf-8?B?N1BTa1FaWXJZbFgxbXlNVm03bnBhL0VINmlqMlJZVXhISXZvb2hZRXNmNnFk?=
 =?utf-8?B?K21reSt2c0xrbW1QK1dyUVZ5UFpqY1A5d1g1Rk50bkZMelRQL1lIT2gxM0Ja?=
 =?utf-8?B?U0ViMDBnTzZxRVo2eXRJbUxNa3ZaeXN1aVV3U25uOFU4d3NITnJtOVNTVUlE?=
 =?utf-8?B?YmxvdUFXYjRycVNYVlBFbkJJRVQvRnUvclZYZ1l5bXl4TmNvZVlDMTJyTXZB?=
 =?utf-8?B?U05BTWlTaEtRdnF3dGdET0d4UWFMaEVMQUx5SkJ0cUQ3Rk13Vmg2Zys1Y0hq?=
 =?utf-8?B?bHdIcEppczlVcjlwVDdpZWR6aFUydXdTMGNneEpnN1dVdnNMbEZ1NVdvbWdI?=
 =?utf-8?B?Qmd5NDBDV0hDRSt3Q0xWcC9NWjlmTXpkVXdDTjk3OVA0T3pzV3NkMkNJNnpR?=
 =?utf-8?B?MmtpVkxhMVMvS05PQUcyUXlzZjhKbjd3eC9NQmg2QjVOYThXK3Q3cDdueDJQ?=
 =?utf-8?B?amNIVUlRckY3WEllQjNMOXBDQVl0RFNQaVpvb21GYTg5Sk1FRkZvVWswRm9X?=
 =?utf-8?B?V2N5Zmg5dE9XbW84em1xS0lBMkZUamZjMjRqbDhhZitkdXBRaklySzJLako1?=
 =?utf-8?B?SmdhZ3pYNjc3RTRtMWxneEtFQS8ydFVJV2c1TlZKYlFsbzlvdjhFZDdWbU9s?=
 =?utf-8?B?czcrcGNPMjRhbUFjMGRvL3ZCR3V1ZENKLzR4K2RtMk1oQnFqVG1jMUx4YWZs?=
 =?utf-8?B?VW5oS0kzazc2NTBKSkRDVWxmRW5RaUtncm9CdXhRNVRtWitqdUhvZ0R5Ukpl?=
 =?utf-8?B?Wk9mRGVmOURWcjlkcVl0bTJhUS9IekpLUmlONGREbDA3NFV2OGk0bHU0UGc0?=
 =?utf-8?B?cTE1Z2dLUU9wVU9ITG1UNWpaL1J1OURFSTRsQStYRit4ejVmeWo3NEZHdVJv?=
 =?utf-8?B?SUdRU3BaZ2EybUxsb3I2d2plNXlKQ1BhSEQ2bE11UnV1T0dMR3JMS0o1Tmhh?=
 =?utf-8?B?MmRyeUtvWngrUFBwOU8vSGRPQ0RuN0l3czY5ZnJGL2djLzAxUXJ3QWRJbjVG?=
 =?utf-8?B?SmZ6SURkY1VuRzROZXhzcDdDQy9WL1BaMnBGVzlxTWE5Q1owNFNyNi9GdkFx?=
 =?utf-8?B?OXUvaGNXU0VoZDdNUzRtV2hVOUV1R3ZRbjdmVmgyRDFsSWRxV1RhViswK3Nz?=
 =?utf-8?B?MUdLY3pjL1JORG5KUERRZzRncHlQVk1BREJQMUNob2pXd3ZjMXJ4RHdSbmgv?=
 =?utf-8?B?ZE1VSDJpMHRidEhBZms5ZFpPNndFaFdYTWlmc2ZTc0IwYTljYkQvODJkVnVt?=
 =?utf-8?B?UGdTWGoremRoVm9mT0FjMlo0Yzd4SGNmOUhCVUtjVlNNdHZUMkpmNlJLT215?=
 =?utf-8?B?clM2Mk1wcm1kbHg3dmVjYTRBeXZ4cktWMys4VXJ0M2JoRmN3SlFzTnB6N243?=
 =?utf-8?B?alJvRGNhY0FZZldxang5TGFSckhNYVFaVDNoZlA5cjJTeTFrUXl5clNsaXlB?=
 =?utf-8?B?YTMyMEMrTklhc2VVc1ROSHRFL1p0bGxrVGQ5d21CWkdlR0dDdGk4U3BYd0N5?=
 =?utf-8?B?SGNSY1NBb2xBYXlmN0hsOWhOYVZDTXZObUprckRLalZBVG82ejRDZ29tdGJJ?=
 =?utf-8?B?aG5vK0ZjZzJCUXdPSk1VaDB3WUxBQzZORU9KeE1KTTJwYUJvUVFFQjFCS0Z4?=
 =?utf-8?B?d1dNWVFwaUxXTjhwcGhkVlhkV0xKaXhUZ016a0VzekQ4Uk54dkdvL01ZWjNs?=
 =?utf-8?B?bHh6ZlRhNjQ5NEVWdS9LbVpOaW5Pcmp6YnliWUdrRVVsWmRINW1lNHpVeXQw?=
 =?utf-8?B?aEtnb3hkVnlBUUVXcWo3T055MkhyTlZXbTIzTU1rQlFRdmpZMUFKb0F0K2Fh?=
 =?utf-8?B?a3V5TTIxamVwUU5UMlJQb0IxVlhzbkJDbExBYXgrRjhwT0FXR0s5NTNNbFZw?=
 =?utf-8?B?Um55YVN5VXNONE9ZQVRjdDk0QU5lcVNvTUlKQzhVMUptbGV4WUo4ZC9OY0tQ?=
 =?utf-8?B?V2U4NlhOV3F1YnNkKzgzKzI0WHIyQjQwOXljNXhWMmd2aHhEejVIc3c2Q1Vm?=
 =?utf-8?B?dzRzamhqa2NWeHhYZUc5WHBKL3h2UTRTMUp4eUJGYmV3amF1SE9ra0lqbWZv?=
 =?utf-8?Q?x6QW35Hj4qHFBDV9BS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bafc43-aec2-4b27-86f5-08de9cc13dfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 20:38:11.5126 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iTNRNIHcFGSx+dBZEUv2kpMe/+JL1WCuCwvTpLND4aegMlcThKN5dCNF43XyiNG3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8002
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

W1B1YmxpY10NCg0KSGkgVGltdXIsDQoNClRoYW5rcyBmb3Igc2hhcmluZyB0ZXN0IHJlc3VsdHMu
DQpJIHdpbGwgc2VuZCBWMiBzaG9ydGx5Lg0KDQpUaGFua3MsDQpSb21hbg0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFRpbXVyIEtyaXN0w7NmIDx0aW11ci5rcmlzdG9m
QGdtYWlsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBBcHJpbCAxNywgMjAyNiAzOjM2IFBNDQo+IFRv
OiBIdW5nLCBBbGV4IDxBbGV4Lkh1bmdAYW1kLmNvbT4NCj4gQ2M6IExpLCBSb21hbiA8Um9tYW4u
TGlAYW1kLmNvbT47IGFtZC1nZnggbGlzdCA8YW1kLQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsNCj4g
V2VudGxhbmQsIEhhcnJ5IDxIYXJyeS5XZW50bGFuZEBhbWQuY29tPjsgTGksIFN1biBwZW5nIChM
ZW8pDQo+IDxTdW5wZW5nLkxpQGFtZC5jb20+OyBQaWxsYWksIEF1cmFiaW5kbyA8QXVyYWJpbmRv
LlBpbGxhaUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL2Rpc3BsYXk6
IFJlc3RvcmUgYW5hbG9nIGNvbm5lY3RvciBzdXBwb3J0DQo+DQo+IEhpLA0KPg0KPiBUZXN0ZWQg
dGhpcyBvbiB0aGUgZm9sbG93aW5nOg0KPiBIRCA3ODcwIFhUIC0gd29ya3MNCj4gUjkgMjgwWCAo
VGFoaXRpKSAtIHdvcmtzDQo+IFI5IDM4MFggKFRvbmdhKSAtIHdvcmtzDQo+IEExMC03ODUwSyAo
S2F2ZXJpKSAtIGJyb2tlbg0KPg0KPiBJdCBzZWVtcyB0aGF0IHNvbWUgb3RoZXIgY2h1bmtzIG9m
IGNvZGUgd2VyZSByZW1vdmVkIHdoaWNoIHdlcmUgbmVjZXNzYXJ5IGZvcg0KPiBleHRlcm5hbCBE
UCBicmlkZ2UgZW5jb2RlcnMgdG8gd29yayBwcm9wZXJseS4gVGhvc2Ugd2lsbCBuZWVkIHRvIGJl
IGFkZGVkIGJhY2sNCj4gdG9vLCBvdGhlcndpc2Ugd2UgcmVncmVzcyBLYXZlcmkgQVBVcy4NCj4N
Cj4gQmVzdCByZWdhcmRzLA0KPiBUaW11cg0KPg0KPg0KPiBPbiBUaHVyc2RheSwgQXByaWwgMTYs
IDIwMjYgNzozODozOeKAr1BNIENlbnRyYWwgRXVyb3BlYW4gU3VtbWVyIFRpbWUgVGltdXINCj4g
S3Jpc3TDs2Ygd3JvdGU6DQo+ID4gSGksDQo+ID4NCj4gPiBJJ2xsIHRlc3QgdGhpcyBvbiBhIGZl
dyBkaWZmZXJlbnQgb2xkIEdQVXMgYW5kIGdldCBiYWNrIHRvIHlvdS4NCj4gPg0KPiA+IFRoYW5r
cywNCj4gPiBUaW11cg0KPiA+DQo+ID4gQWxleCBIdW5nIDxhbGV4Lmh1bmdAYW1kLmNvbT4gZXp0
IMOtcnRhIChpZMWRcG9udDogMjAyNi4gw6Fwci4gMTYuLCBDc8O8IDE3OjQ2KToNCj4gPiA+IFJl
dmlld2VkLWJ5OiBBbGV4IEh1bmcgPGFsZXguaHVuZ0BhbWQuY29tPg0KPiA+ID4NCj4gPiA+IE9u
IDQvMTUvMjYgMTY6NDEsIFJvbWFuLkxpQGFtZC5jb20gd3JvdGU6DQo+ID4gPiA+IEZyb206IFJv
bWFuIExpIDxSb21hbi5MaUBhbWQuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBbV2h5XQ0KPiA+ID4g
PiBUaGUgYW5hbG9nIGNvbm5lY3RvciBzdXBwb3J0IHdhcyBhY2NpZGVudGFsbHkgcmVtb3ZlZCwg
Y2F1c2luZyBhDQo+ID4gPiA+IGNyYXNoIHdoZW4gY29ubmVjdGluZyBhbiBhbmFsb2cgbW9uaXRv
ci4NCj4gPiA+ID4NCj4gPiA+ID4gW0hvd10NCj4gPiA+ID4gVGhpcyBwYXRjaCByZXN0b3JlcyB0
aGUgZnVuY3Rpb25zIGFuZCBwb2ludGVycyByZXF1aXJlZCBmb3IgcHJvcGVyDQo+ID4gPiA+IGFu
YWxvZyBhbmQgRFAgYnJpZGdlIGVuY29kZXIgc3VwcG9ydCBvbiBsZWdhY3kgR1BVcy4NCj4gPiA+
ID4NCj4gPiA+ID4gRml4ZXM6IDY2NzE1ZmMwZWNmZCAoImRybS9hbWQvZGlzcGxheTogU3luYyBk
Y240MiB3aXRoIERDDQo+ID4gPiA+IDMuMi4zNzMiKQ0KPiA+ID4gPiBDYzogVGltdXIgS3Jpc3TD
s2YgPHRpbXVyLmtyaXN0b2ZAZ21haWwuY29tPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSb21h
biBMaSA8Um9tYW4uTGlAYW1kLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+DQo+ID4gPiA+ICAg
Li4uL2FtZC9kaXNwbGF5L2RjL2h3c3MvZGNlMTEwL2RjZTExMF9od3NlcS5jIHwgNTMNCj4gKysr
KysrKysrKysrKysrKysrKw0KPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA1MyBpbnNlcnRpb25z
KCspDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQNCj4gPiA+ID4gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvaHdzcy9kY2UxMTAvZGNlMTEwX2h3c2VxLmMNCj4gPiA+DQo+ID4g
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9od3NzL2RjZTExMC9kY2UxMTBfaHdz
ZXEuYw0KPiA+ID4NCj4gPiA+ID4gaW5kZXggNTI3M2NhMDlmZTEyLi5lNzZhYmM4NzdmNGEgMTAw
NjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9od3NzL2Rj
ZTExMC9kY2UxMTBfaHdzZXEuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvaHdzcy9kY2UxMTAvZGNlMTEwX2h3c2VxLmMNCj4gPiA+ID4gQEAgLTY3Nyw2ICs2
NzcsNDggQEAgZGNlMTEwX2RhY19lbmNvZGVyX2NvbnRyb2woc3RydWN0IHBpcGVfY3R4DQo+ID4g
Pg0KPiA+ID4gKnBpcGVfY3R4LCBib29sIGVuYWJsZSkNCj4gPiA+DQo+ID4gPiA+ICAgICAgIGJp
b3MtPmZ1bmNzLT5lbmNvZGVyX2NvbnRyb2woYmlvcywgJmVuY29kZXJfY29udHJvbCk7DQo+ID4g
PiA+DQo+ID4gPiA+ICAgfQ0KPiA+ID4gPg0KPiA+ID4gPiArc3RhdGljIHZvaWQNCj4gPiA+ID4g
K2RjZTExMF9leHRlcm5hbF9lbmNvZGVyX2NvbnRyb2woZW51bQ0KPiA+ID4gPiArYnBfZXh0ZXJu
YWxfZW5jb2Rlcl9jb250cm9sX2FjdGlvbg0KPiA+ID4NCj4gPiA+IGFjdGlvbiwNCj4gPiA+DQo+
ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkY19saW5rICpsaW5r
LA0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZGNfY3J0Y190
aW1pbmcgKnRpbWluZykgew0KPiA+ID4gPiArICAgICBzdHJ1Y3QgZGMgKmRjID0gbGluay0+Y3R4
LT5kYzsNCj4gPiA+ID4gKyAgICAgc3RydWN0IGRjX2Jpb3MgKmJpb3MgPSBsaW5rLT5jdHgtPmRj
X2Jpb3M7DQo+ID4gPiA+ICsgICAgIGNvbnN0IHN0cnVjdCBkY19saW5rX3NldHRpbmdzICpsaW5r
X3NldHRpbmdzID0NCj4gPiA+DQo+ID4gPiAmbGluay0+Y3VyX2xpbmtfc2V0dGluZ3M7DQo+ID4g
Pg0KPiA+ID4gPiArICAgICBlbnVtIGJwX3Jlc3VsdCBicF9yZXN1bHQgPSBCUF9SRVNVTFRfT0s7
DQo+ID4gPiA+ICsgICAgIHN0cnVjdCBicF9leHRlcm5hbF9lbmNvZGVyX2NvbnRyb2wgZXh0X2Nu
dGwgPSB7DQo+ID4gPiA+ICsgICAgICAgICAgICAgLmFjdGlvbiA9IGFjdGlvbiwNCj4gPiA+ID4g
KyAgICAgICAgICAgICAuY29ubmVjdG9yX29ial9pZCA9IGxpbmstPmxpbmtfZW5jLT5jb25uZWN0
b3IsDQo+ID4gPiA+ICsgICAgICAgICAgICAgLmVuY29kZXJfaWQgPSBsaW5rLT5leHRfZW5jX2lk
LA0KPiA+ID4gPiArICAgICAgICAgICAgIC5sYW5lc19udW1iZXIgPSBsaW5rX3NldHRpbmdzLT5s
YW5lX2NvdW50LA0KPiA+ID4gPiArICAgICAgICAgICAgIC5saW5rX3JhdGUgPSBsaW5rX3NldHRp
bmdzLT5saW5rX3JhdGUsDQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICAgICAgICAvKiBVc2Ug
c2lnbmFsIHR5cGUgb2YgdGhlIHJlYWwgbGluayBlbmNvZGVyLCBpZS4gRFAgKi8NCj4gPiA+ID4g
KyAgICAgICAgICAgICAuc2lnbmFsID0gbGluay0+Y29ubmVjdG9yX3NpZ25hbCwNCj4gPiA+ID4g
Kw0KPiA+ID4gPiArICAgICAgICAgICAgIC8qIFdlIGRvbid0IGtub3cgdGhlIHRpbWluZyB5ZXQg
d2hlbiBleGVjdXRpbmcgdGhlDQo+ID4gPiA+ICsgU0VUVVANCj4gPiA+DQo+ID4gPiBhY3Rpb24s
DQo+ID4gPg0KPiA+ID4gPiArICAgICAgICAgICAgICAqIHNvIHVzZSBhIHJlYXNvbmFibHkgaGln
aCBkZWZhdWx0IHZhbHVlLiBJdCBzZWVtcw0KPiA+ID4gPiArIHRoYXQNCj4gPiA+DQo+ID4gPiBF
TkFCTEUNCj4gPiA+DQo+ID4gPiA+ICsgICAgICAgICAgICAgICogY2FuIGNoYW5nZSB0aGUgYWN0
dWFsIHBpeGVsIGNsb2NrIGJ1dCBkb2Vzbid0DQo+ID4gPiA+ICsgd29yayB3aXRoDQo+ID4gPg0K
PiA+ID4gaGlnaGVyDQo+ID4gPg0KPiA+ID4gPiArICAgICAgICAgICAgICAqIHBpeGVsIGNsb2Nr
cyB0aGFuIHdoYXQgU0VUVVAgd2FzIGNhbGxlZCB3aXRoLg0KPiA+ID4gPiArICAgICAgICAgICAg
ICAqLw0KPiA+ID4NCj4gPiA+ID4gKyAgICAgICAgICAgICAucGl4ZWxfY2xvY2sgPSB0aW1pbmcg
PyB0aW1pbmctPnBpeF9jbGtfMTAwaHogLyAxMCA6DQo+ID4gPiAzMDAwMDAsDQo+ID4gPg0KPiA+
ID4gPiArICAgICAgICAgICAgIC5jb2xvcl9kZXB0aCA9IHRpbWluZyA/IHRpbWluZy0+ZGlzcGxh
eV9jb2xvcl9kZXB0aCA6DQo+ID4gPiBDT0xPUl9ERVBUSF84ODgsDQo+ID4gPg0KPiA+ID4gPiAr
ICAgICB9Ow0KPiA+ID4gPiArICAgICBEQ19MT0dHRVJfSU5JVChkYy0+Y3R4KTsNCj4gPiA+ID4g
Kw0KPiA+ID4gPiArICAgICBicF9yZXN1bHQgPSBiaW9zLT5mdW5jcy0+ZXh0ZXJuYWxfZW5jb2Rl
cl9jb250cm9sKGJpb3MsDQo+ID4gPiA+ICZleHRfY250bCk7DQo+ID4gPiA+ICsNCj4gPiA+ID4g
KyAgICAgaWYgKGJwX3Jlc3VsdCAhPSBCUF9SRVNVTFRfT0spDQo+ID4gPg0KPiA+ID4gPiArICAg
ICAgICAgICAgIERDX0xPR19FUlJPUigiRmFpbGVkIHRvIGV4ZWN1dGUgZXh0ZXJuYWwgZW5jb2Rl
ciBhY3Rpb246DQo+ID4gPiAweCV4XG4iLCBhY3Rpb24pOw0KPiA+ID4NCj4gPiA+ID4gK30NCj4g
PiA+ID4gKw0KPiA+ID4gPiArc3RhdGljIHZvaWQNCj4gPiA+ID4gK2RjZTExMF9wcmVwYXJlX2Rk
YyhzdHJ1Y3QgZGNfbGluayAqbGluaykgew0KPiA+ID4gPiArICAgICBpZiAobGluay0+ZXh0X2Vu
Y19pZC5pZCkNCj4gPiA+ID4gKw0KPiA+ID4NCj4gPiA+DQo+IGRjZTExMF9leHRlcm5hbF9lbmNv
ZGVyX2NvbnRyb2woRVhURVJOQUxfRU5DT0RFUl9DT05UUk9MX0REQ19TRQ0KPiBUVVAsDQo+ID4g
PiBsaW5rLA0KPiA+ID4NCj4gPiA+IE5VTEwpOw0KPiA+ID4NCj4gPiA+ID4gK30NCj4gPiA+ID4g
Kw0KPiA+ID4gPg0KPiA+ID4gPiAgIHN0YXRpYyBib29sDQo+ID4gPiA+ICAgZGNlMTEwX2RhY19s
b2FkX2RldGVjdChzdHJ1Y3QgZGNfbGluayAqbGluaykNCj4gPiA+ID4gICB7DQo+ID4gPiA+DQo+
ID4gPiA+IEBAIC0zMzc2LDYgKzM0MTgsMTUgQEAgdm9pZCBkY2UxMTBfZW5hYmxlX3RtZHNfbGlu
a19vdXRwdXQoc3RydWN0DQo+ID4gPg0KPiA+ID4gZGNfbGluayAqbGluaywNCj4gPiA+DQo+ID4g
PiA+ICAgICAgIGxpbmstPnBoeV9zdGF0ZS5zeW1jbGtfc3RhdGUgPSBTWU1DTEtfT05fVFhfT047
DQo+ID4gPiA+DQo+ID4gPiA+ICAgfQ0KPiA+ID4gPg0KPiA+ID4gPiArc3RhdGljIHZvaWQgZGNl
MTEwX2VuYWJsZV9hbmFsb2dfbGlua19vdXRwdXQoDQo+ID4gPiA+ICsgICAgICAgICAgICAgc3Ry
dWN0IGRjX2xpbmsgKmxpbmssDQo+ID4gPiA+ICsgICAgICAgICAgICAgdWludDMyX3QgcGl4X2Ns
a18xMDBoeikgew0KPiA+ID4gPiArICAgICBsaW5rLT5saW5rX2VuYy0+ZnVuY3MtPmVuYWJsZV9h
bmFsb2dfb3V0cHV0KA0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgbGluay0+bGlua19l
bmMsDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICBwaXhfY2xrXzEwMGh6KTsgfQ0KPiA+
ID4gPiArDQo+ID4gPiA+DQo+ID4gPiA+ICAgdm9pZCBkY2UxMTBfZW5hYmxlX2RwX2xpbmtfb3V0
cHV0KA0KPiA+ID4gPg0KPiA+ID4gPiAgICAgICAgICAgICAgIHN0cnVjdCBkY19saW5rICpsaW5r
LA0KPiA+ID4gPiAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBsaW5rX3Jlc291cmNlICpsaW5r
X3JlcywNCj4gPiA+ID4NCj4gPiA+ID4gQEAgLTM1MTMsOCArMzU2NCwxMCBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IGh3X3NlcXVlbmNlcl9mdW5jcw0KPiA+ID4NCj4gPiA+IGRjZTExMF9mdW5jcyA9
IHsNCj4gPiA+DQo+ID4gPiA+ICAgICAgIC5lbmFibGVfbHZkc19saW5rX291dHB1dCA9IGRjZTEx
MF9lbmFibGVfbHZkc19saW5rX291dHB1dCwNCj4gPiA+ID4gICAgICAgLmVuYWJsZV90bWRzX2xp
bmtfb3V0cHV0ID0gZGNlMTEwX2VuYWJsZV90bWRzX2xpbmtfb3V0cHV0LA0KPiA+ID4gPiAgICAg
ICAuZW5hYmxlX2RwX2xpbmtfb3V0cHV0ID0gZGNlMTEwX2VuYWJsZV9kcF9saW5rX291dHB1dCwN
Cj4gPiA+ID4NCj4gPiA+ID4gKyAgICAgLmVuYWJsZV9hbmFsb2dfbGlua19vdXRwdXQgPQ0KPiA+
ID4gPiArIGRjZTExMF9lbmFibGVfYW5hbG9nX2xpbmtfb3V0cHV0LA0KPiA+ID4gPg0KPiA+ID4g
PiAgICAgICAuZGlzYWJsZV9saW5rX291dHB1dCA9IGRjZTExMF9kaXNhYmxlX2xpbmtfb3V0cHV0
LA0KPiA+ID4gPiAgICAgICAuZGFjX2xvYWRfZGV0ZWN0ID0gZGNlMTEwX2RhY19sb2FkX2RldGVj
dCwNCj4gPiA+ID4NCj4gPiA+ID4gKyAgICAgLnByZXBhcmVfZGRjID0gZGNlMTEwX3ByZXBhcmVf
ZGRjLA0KPiA+ID4gPg0KPiA+ID4gPiAgIH07DQo+ID4gPiA+DQo+ID4gPiA+ICAgc3RhdGljIGNv
bnN0IHN0cnVjdCBod3NlcV9wcml2YXRlX2Z1bmNzIGRjZTExMF9wcml2YXRlX2Z1bmNzID0gew0K
Pg0KPg0KPg0KDQo=
