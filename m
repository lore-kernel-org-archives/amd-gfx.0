Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47824C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 13:21:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEB0810EE8B;
	Wed, 25 May 2022 13:21:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A618910EE8B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 13:21:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqVTEhkPvjDm8yawJGjbcPwCJGT/GCulTaEq8ke+YvZ+kFWLkGfK6fiknNB7ZcB2Wk+XV0rGyFJyJYaVj2D2GJOFnswtmbgi2DBrYWvRghRVzIZIZFVDgIGGhoZYoegTPfM0Ff+QZ3aT6HOyUBMVgEJegwB0JRSIIbhtkgG2mttLSNLgwe4FaX/S5dp1/DYtXnbXqtzfnjRM//mayMXdViGyNq75/2kUDQGnqbEUH/NEx2xoyNGq0nIdQZhRSqIAi6W1YYkfIxYYJczngAyGs7AAeMB/U2Nzn3k/O2NMRx0I+rvapYuG/2ptLZODJ+aYCVfwBd8mMyPl1Vm5zPyWiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTnFxlBY7qcWhommfyTe8Gs3Y1I2NHqUCyhCb2rCz1Q=;
 b=SgKOn7KquwyRjlIREfMI+VhhPgqYoK9eJwNZbeXfLeWtsxCsOvZRufQpkt87BeyalXJSfqD9V3E3fNu3avY7WXHQWaDcMG1WMsquhv1NPAYNU5gOtqecBq/AI89Icys1zAHzZIp/+6Bg1Nsi9WZ4kkvYIZvriu5uAariHNwGtyGFPDJbl2PHjLDoD20tk+fKkHLpnx1IHfwp1EEf9rP7jARZU1IiOhTNuDHScKv/Twj9ueSteF19hu/M2iNItqCc41+2r7ldKtM3jgUIza61GFMlbEHRMg/45eKBg7+mnEVqIV1VpWH/kk6OCQsttMbHRZdr9bWc5bwKlSM0/NhHAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTnFxlBY7qcWhommfyTe8Gs3Y1I2NHqUCyhCb2rCz1Q=;
 b=hS5R5MQWlupYC0a2fNNZOp7zc9NBcXQ8pD2c4q8gG06+j+7+Qrvok6gCQVFVuK7JI/uwGVWqEx66USv08RtzmNAg0VbsJy1GlL+w5DQmxmhVQZM5Z/ErYPlcEigxYg1EeXYSoYNSE/wOnp69kMrpZQ29//md6u++ltd9BoJmXKo=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by DM5PR12MB1212.namprd12.prod.outlook.com (2603:10b6:3:74::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Wed, 25 May
 2022 13:21:51 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::d504:b18d:6b58:cf8d]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::d504:b18d:6b58:cf8d%5]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 13:21:51 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIFJldmlldyB2MyAyLzJdIGRybS9hbWRncHU6IHByaW50?=
 =?gb2312?Q?_umc_correctable_error_address?=
Thread-Topic: [PATCH Review v3 2/2] drm/amdgpu: print umc correctable error
 address
Thread-Index: AQHYb/40K2NUEuNeckG/IUAH7kY+aa0viL2AgAALR2o=
Date: Wed, 25 May 2022 13:21:51 +0000
Message-ID: <BL1PR12MB5334F2D1B8D4B5FED3AACFD79AD69@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20220525061047.26529-1-Stanley.Yang@amd.com>
 <20220525061047.26529-2-Stanley.Yang@amd.com>
 <0333920f-7db9-404f-7f15-acd2204586fc@amd.com>
In-Reply-To: <0333920f-7db9-404f-7f15-acd2204586fc@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-25T13:19:02.7261415Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f447b049-d728-46ec-8b01-08da3e51878e
x-ms-traffictypediagnostic: DM5PR12MB1212:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1212002584D94A48CFC4D3199AD69@DM5PR12MB1212.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8jbCzFYbi//dsABqqt+7YkbVieZj8JeKW/NS52gtAh4J0qWUsOOLnqMqswhbHYl6EAtcQtdo+I9y+fqUUV6rxZEEkSOJTqT1+Ot07mdgRhHiyt2S5jiyJ422qzuO4uZWImAuCgjP7IpQcozAQDfZ+7Cvr2ib+Zusbjpq6wRCOPOSITCTooDG8G0Xio6WOIWT9+oNjmjSF6iwNZjN5/uE+5X1Lpca9OzBegNb/iEoTEdlvieHZeQj4qZ71ZkG3kInBnSfpkuHIkuQpoZc02CHNosJC3sOswCYxbOqU4nSbv78XhN/czCvHcwJ1ozz7zVpAyremq683+QBBt7tYg5BmkcT1J8ZrkZ5opjdE/HFCTe7thbGfMdnDuH/wWbd5DxTVxcLKJe/ksblI/gb9g2nkH2nYySP4r/WHn/nOVCJSbsxCIuZViB4+pYaRphguK/AMge8ZXLGHVEycReby5YYSoarkQcGsKAc7XdZpbTAoAzM1w0K9AYVv3hsf6s6vwjMnVtQXxn5BD+mZ+H12ohLnmuD6tLhxpojQmhCBzZAeYJh/jtGNN1ra2ElWPDIl2K5NCFogCFLdWMfie9yACFbwWZzAD8ZVlRx8lrJ3gRNstCSAEn8D4NCOvZa60jA2ZxkLNs629NqrDoIv8z6MxIuUSclevRSpxhdShLtDmbgjvdpWl7Tr2RK0AZYrniFovEBCAp6oJltiVMrFFwcaPzEpw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(38100700002)(122000001)(9686003)(26005)(38070700005)(83380400001)(86362001)(186003)(66556008)(64756008)(6636002)(52536014)(66946007)(91956017)(53546011)(316002)(76116006)(66446008)(66476007)(224303003)(55016003)(5660300002)(6506007)(71200400001)(2906002)(7696005)(33656002)(110136005)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?QUN3YUFwSWxnbjMyZmxNTEUyNlhSV0gxMEtCUVdxUmZpKzRBSFdsazA2YXlD?=
 =?gb2312?B?UDlpWU00T1lWeGFNNC9MUlVsVUFaNGdWc2Zub00zeU15L1poSFRya2NyT2Rx?=
 =?gb2312?B?Z0lUd0F6clFGanRFa3U5bU5lTWF1VzYxQWVaL0RqS2VYV0YwbkRCaldVNUdQ?=
 =?gb2312?B?ZWJyMTlwR09Gem56bFA5YWgwdDFubVVlbE1DQWx0dERwNXpCVzBUSnQ4SHRl?=
 =?gb2312?B?bWtjWlJORG5uSUppZ2djOSs0Uk5pbFBIbTRCLzFpcGVIc2pITDAwQnRpYTFi?=
 =?gb2312?B?eXRicFZkZjh3K0dmWGdYOHdyZHhjTEIxNGJ2cVY4aWtsVWFGYUtPcTlhTVd5?=
 =?gb2312?B?TVdYajBXanczaHJnLzZnMWpTSURGU3VTOGxEUzF1Tzd4ajQ1bGl2dmtxaSs5?=
 =?gb2312?B?WndKV0Urc0RTTkxvUHRCaThvenRiNVlGSnpDQ0FQOTQ5UlUrVGY1OUVUOVoy?=
 =?gb2312?B?eGd1QkVZZW5IM3N5R1VuTnBZOVdFcHVvQzc1Q1JiTzNiQzRCdG4xWkhrcW40?=
 =?gb2312?B?eTJOZnpjeGQwTEpvNjVWdG5aR2VrVStYYlNvRWJTRXpieXhhWXc0QjhtWm5C?=
 =?gb2312?B?R3oybW5jOEN6T21CK1RQZGlwSy9JT29oK3l0VHFZOElQVEQ1QmgyR3NxU3Zu?=
 =?gb2312?B?eEEwUzAzWlp3TkhSMSttdEFKaXhxcmdkYUdHNnhnSHRseCtHSzRmd2ZYVWsx?=
 =?gb2312?B?WUZ0NUJTb2NIZDNoNkdUem9kOXJEZUxlOTVvSlJOZk0xYUJTbmI0ZW1pZHlF?=
 =?gb2312?B?N25SaWVOY3VSUTJCY2ozVWNMeWlvRlhRbmVLakdBVkJWWVFlNmM0dURRRVoz?=
 =?gb2312?B?Yi96Y2plMDV2TEZJUENSanVyaUdxRU5GSFo5eThpamxiWmhyeWh1OUZpOVVt?=
 =?gb2312?B?Ni8zalhvMkw4dFFKWkN5UitiSEJkZzlNamVPN2VRa0JjMXpxaUxyWXFkRHZq?=
 =?gb2312?B?ZVd4T3AxMnR4bHdaeDZIMXFHVHlvNkdscnBEVDJYNk5CbmZFaGpYcDl3Q1lw?=
 =?gb2312?B?KzM1WnhGNHQrR0ttVXI5WDFnd0I4dStVM2NpQXdOTnFvMU5SV0UvRk92ZHhN?=
 =?gb2312?B?cWNhUXpydHYyRjE2RTBabVRjRXNuNW44TDB1UWh5aVRMdWY1V3lKMTJyZ0Vn?=
 =?gb2312?B?ZnJRZm1iOVNzMXhMMUhDZ3NDQWRYZkl1QlRQZG9lZ2FTSGlqZlZGQ1dqcUVV?=
 =?gb2312?B?UTlzNUpUWDVKM1dWQjBKMmxkSlNGM2ZlcTlqcjNCZEZGbXN5RmRPSS9FYVRF?=
 =?gb2312?B?MkJqNGMvRVgyUTllL2ErYUpmTExQRGpiZnlna1B2YjBtU01UV3EwYWE2YjI2?=
 =?gb2312?B?UnoxMGl6bVVJZ25jSkNtWk4zQXpjVDVGelJBNEUzWEF2Ry9YU3pLenpUSFBY?=
 =?gb2312?B?MlRFd3MzV0xsZGdzZTd3WjVaNkM5UnJYQXBaMnJKRTlKRnJkbUJmNFVkRmxn?=
 =?gb2312?B?TzloSHl4cVl6Mks1K2xBUGZsZXN2L1ZFTm5vblpJREdVeDNiL21YZDZUYXpW?=
 =?gb2312?B?OGh1eEdrSE9IVnAzNk5WSUxNb2ZCZjk0M3hVaDk3TE5WZGhKaDZBSlY0TU1m?=
 =?gb2312?B?a2llajBBb3lqVDJZK1h1cVM1UStLcVNJOFhvY0VLM0VmM01obGIrN0Z2dTJF?=
 =?gb2312?B?czZ0QU1NOWUyb25Pc3BCa1NGN2lYVE5jNExWSmpuZmtGMFdXRFNiNkdCaXBw?=
 =?gb2312?B?SjlqRVJmOGNqNUcrTWk3Z1RpZDdsNG81TER4TlRzUlZJRXZhSTEzWnNjMmNy?=
 =?gb2312?B?MjBwN29jdDlVT3FPRmtGTURQL0k2M3htYU5nUHVBY1J4Y2o4UlNsd0ppci9X?=
 =?gb2312?B?bmZuUjRoYmlCelpwNVNKNDJsMUtoVjM1WFVQZ2lMR1EycjFvWmZGS2gxZXpo?=
 =?gb2312?B?WmVYR1Y5QXliTlgvV3JnbjU4UWhLcTJHQlVLcXhycFN6TkE0cExVUnBZM09L?=
 =?gb2312?B?dFFRTHFvVjBrR3RjRmpHaUwzZ0hwQXJROTJ2MzFBQXJkY3hOb0VIUmV0TWlm?=
 =?gb2312?B?TmcvcDJyekFWMHMzQkRmTDVaSTlOM1dBakR2WXVnNzFTU0ZjOVZhTlhPV1J2?=
 =?gb2312?B?UFE2Wm1EUEVVcm5pZEVCWHljMlN5bTVnOXMwbkdQdVZwVTFrUGd1OGZuL29D?=
 =?gb2312?B?MWNlTGZvSVpPeDBEUWVDdWJCMVNPRjI2M0RubU10K0htQ1hmWWd2bitZdnQx?=
 =?gb2312?B?S0xQczQrZ2VaRGJvbnZRV3dhbGVSSXlEeDN1ZTRMUlNad1BGZkhjbGE0QmdX?=
 =?gb2312?B?eloweVZxSlNKYjBCM3hCT1VLNktDbE82d3VSa0MvNnI4V29TbGtYZVVVY2Uv?=
 =?gb2312?B?SVJ0ekxJZm5PN2tIbHoxYmU5anFJRHQ3cVp5K3JzK1JFSjIvakpHT3NpV0d3?=
 =?gb2312?Q?3BgVrsMGFcfQ7zlM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5334F2D1B8D4B5FED3AACFD79AD69BL1PR12MB5334namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f447b049-d728-46ec-8b01-08da3e51878e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 13:21:51.3260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LfJID+WZL0xgBpsV68PkQt7IaoEosn2B5R53bqvN3rYTlKJ1RCdRv/kRKnF3fEI5CuQL+zx0CS+ZT7yMqQj0Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1212
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

--_000_BL1PR12MB5334F2D1B8D4B5FED3AACFD79AD69BL1PR12MB5334namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KW0FNRCBPZmZpY2lhbCBVc2Ug
T25seSAtIEdlbmVyYWxdDQoNCreivP7IyzogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNv
bT4NCsjVxto6INDHxtrI/SwgMjAyMsTqNdTCMjXI1SDPws7nODozOA0KytW8/sjLOiBZYW5nLCBT
dGFubGV5IDxTdGFubGV5LllhbmdAYW1kLmNvbT4sIGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnIDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4sIFpoYW5nLCBIYXdraW5nIDxIYXdr
aW5nLlpoYW5nQGFtZC5jb20+LCBaaG91MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT4sIFF1YW4s
IEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPg0K1vfM4jogUmU6IFtQQVRDSCBSZXZpZXcgdjMgMi8y
XSBkcm0vYW1kZ3B1OiBwcmludCB1bWMgY29ycmVjdGFibGUgZXJyb3IgYWRkcmVzcw0KDQoNCk9u
IDUvMjUvMjAyMiAxMTo0MCBBTSwgU3RhbmxleS5ZYW5nIHdyb3RlOg0KPiBDaGFuZ2VkIGZyb20g
VjE6DQo+ICAgICAgICByZW1vdmUgdW5uZWNlc3Nhcnkgc2FtZSByb3cgcGh5c2ljYWwgYWRkcmVz
cyBjYWxjdWxhdGlvbg0KPg0KPiBDaGFuZ2VkIGZyb20gVjI6DQo+ICAgICAgICBtb3ZlIHJlY29y
ZF9jZV9hZGRyX3N1cHBvcnRlZCB0byB1bWNfZWNjX2luZm8gc3RydWN0DQo+DQo+IFNpZ25lZC1v
ZmYtYnk6IFN0YW5sZXkuWWFuZyA8U3RhbmxleS5ZYW5nQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuaCAgICAgICB8ICA1ICsrDQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdW1jX3Y2XzcuYyAgICAgICAgIHwgNTAgKysrKysr
KysrKysrKysrKysrLQ0KPiAgIC4uLi9kcm0vYW1kL3BtL3N3c211L3NtdTEzL2FsZGViYXJhbl9w
cHQuYyAgICB8ICAxICsNCj4gICAzIGZpbGVzIGNoYW5nZWQsIDU0IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcmFzLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmgN
Cj4gaW5kZXggMjhlNjAzMjQzYjY3Li5iZjVhOTUxMDRlYzEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmgNCj4gQEAgLTMzMyw2ICszMzMsMTEgQEAgc3RydWN0
IGVjY19pbmZvX3Blcl9jaCB7DQo+DQo+ICAgc3RydWN0IHVtY19lY2NfaW5mbyB7DQo+ICAgICAg
ICBzdHJ1Y3QgZWNjX2luZm9fcGVyX2NoIGVjY1tNQVhfVU1DX0NIQU5ORUxfTlVNXTsNCj4gKw0K
PiArICAgICAvKiBEZXRlcm1pbmUgc211IGVjY3RhYmxlIHdoZXRoZXIgc3VwcG9ydA0KPiArICAg
ICAgKiByZWNvcmQgY29ycmVjdGFibGUgZXJyb3IgYWRkcmVzcw0KPiArICAgICAgKi8NCj4gKyAg
ICAgaW50IHJlY29yZF9jZV9hZGRyX3N1cHBvcnRlZDsNCj4gICB9Ow0KPg0KPiAgIHN0cnVjdCBh
bWRncHVfcmFzIHsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Vt
Y192Nl83LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91bWNfdjZfNy5jDQo+IGluZGV4
IDYwNjg5MmRiZWExYy4uYmY3NTI0ZjE2YjY2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS91bWNfdjZfNy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3VtY192Nl83LmMNCj4gQEAgLTExOSw2ICsxMTksMjQgQEAgc3RhdGljIHZvaWQgdW1jX3Y2
XzdfZWNjX2luZm9fcXVlcnlfY29ycmVjdGFibGVfZXJyb3JfY291bnQoc3RydWN0IGFtZGdwdV9k
ZXZpY2UNCj4gICAgICAgICAgICAgICAgKmVycm9yX2NvdW50ICs9IDE7DQo+DQo+ICAgICAgICAg
ICAgICAgIHVtY192Nl83X3F1ZXJ5X2Vycm9yX3N0YXR1c19oZWxwZXIoYWRldiwgbWNfdW1jX3N0
YXR1cywgdW1jX3JlZ19vZmZzZXQpOw0KPiArDQo+ICsgICAgICAgICAgICAgaWYgKHJhcy0+dW1j
X2VjYy5yZWNvcmRfY2VfYWRkcl9zdXBwb3J0ZWQpICAgICAgew0KPiArICAgICAgICAgICAgICAg
ICAgICAgdWludDY0X3QgZXJyX2FkZHIsIHNvY19wYTsNCj4gKyAgICAgICAgICAgICAgICAgICAg
IHVpbnQzMl90IGNoYW5uZWxfaW5kZXggPQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBhZGV2LT51bWMuY2hhbm5lbF9pZHhfdGJsW3VtY19pbnN0ICogYWRldi0+dW1jLmNoYW5uZWxf
aW5zdF9udW0gKyBjaF9pbnN0XTsNCj4gKw0KPiArICAgICAgICAgICAgICAgICAgICAgZXJyX2Fk
ZHIgPSByYXMtPnVtY19lY2MuZWNjW2VjY2luZm9fdGFibGVfaWR4XS5tY2FfY2V1bWNfYWRkcjsN
Cj4gKyAgICAgICAgICAgICAgICAgICAgIGVycl9hZGRyID0gUkVHX0dFVF9GSUVMRChlcnJfYWRk
ciwgTUNBX1VNQ19VTUMwX01DVU1DX0FERFJUMCwgRXJyb3JBZGRyKTsNCj4gKyAgICAgICAgICAg
ICAgICAgICAgIC8qIHRyYW5zbGF0ZSB1bWMgY2hhbm5lbCBhZGRyZXNzIHRvIHNvYyBwYSwgMyBw
YXJ0cyBhcmUgaW5jbHVkZWQgKi8NCj4gKyAgICAgICAgICAgICAgICAgICAgIHNvY19wYSA9IEFE
RFJfT0ZfOEtCX0JMT0NLKGVycl9hZGRyKSB8DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgQUREUl9PRl8yNTZCX0JMT0NLKGNoYW5uZWxfaW5kZXgpIHwNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPRkZTRVRfSU5fMjU2Ql9CTE9DSyhlcnJf
YWRkcik7DQo+ICsNCj4gKyAgICAgICAgICAgICAgICAgICAgIC8qIFRoZSB1bWMgY2hhbm5lbCBi
aXRzIGFyZSBub3Qgb3JpZ2luYWwgdmFsdWVzLCB0aGV5IGFyZSBoYXNoZWQgKi8NCj4gKyAgICAg
ICAgICAgICAgICAgICAgIFNFVF9DSEFOTkVMX0hBU0goY2hhbm5lbF9pbmRleCwgc29jX3BhKTsN
Cj4gKw0KDQpVTUMgYWRkcmVzcyB0byBQQSBjb252ZXJzaW9uIGlzIGNvbW1vbiByZWdhcmRsZXNz
IG9mIFVFL0NFIGVycm9yDQphZGRyZXNzZXMuIFlvdSBtYXkgd2FudCB0byBwYWNrIGl0IGluIGEg
c21hbGwgZnVuY3Rpb24uDQoNClJlZ2FyZGxlc3MsDQogICAgICAgIEFja2VkLWJ5OiBMaWpvIExh
emFyIDxsaWpvLmxhemFyQGFtZC5jb20+DQoNClRoYW5rcywNCkxpam8NClN0YW5sZXk6IFRoZXNl
IGxpbmVzIGFyZSBpbmRlZWQgcmVkdW5kYW50LiBJJ2xsIG1ha2UgYSBwYXRjaCB0byBzaW1wbGlm
eSBpdC4NCg0KUmVhZ2FyZHMsDQpTdGFubGV5DQoNCg0KPiArICAgICAgICAgICAgICAgICAgICAg
ZGV2X2luZm8oYWRldi0+ZGV2LCAiRXJyb3IgQWRkcmVzcyhQQSk6IDB4JWxseFxuIiwgc29jX3Bh
KTsNCj4gKyAgICAgICAgICAgICB9DQo+ICAgICAgICB9DQo+ICAgfQ0KPg0KPiBAQCAtMjUxLDcg
KzI2OSw5IEBAIHN0YXRpYyB2b2lkIHVtY192Nl83X2VjY19pbmZvX3F1ZXJ5X3Jhc19lcnJvcl9h
ZGRyZXNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2DQo+DQo+ICAgc3RhdGljIHZvaWQgdW1j
X3Y2XzdfcXVlcnlfY29ycmVjdGFibGVfZXJyb3JfY291bnQoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdWludDMyX3QgdW1jX3JlZ19vZmZzZXQsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nICplcnJvcl9jb3VudCkNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxv
bmcgKmVycm9yX2NvdW50LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdWludDMyX3QgY2hfaW5zdCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHVtY19pbnN0KQ0KPiAgIHsNCj4gICAg
ICAgIHVpbnQzMl90IGVjY19lcnJfY250X3NlbCwgZWNjX2Vycl9jbnRfc2VsX2FkZHI7DQo+ICAg
ICAgICB1aW50MzJfdCBlY2NfZXJyX2NudCwgZWNjX2Vycl9jbnRfYWRkcjsNCj4gQEAgLTI5NSw2
ICszMTUsMzEgQEAgc3RhdGljIHZvaWQgdW1jX3Y2XzdfcXVlcnlfY29ycmVjdGFibGVfZXJyb3Jf
Y291bnQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICAgICAgICAgICAgICAgICplcnJv
cl9jb3VudCArPSAxOw0KPg0KPiAgICAgICAgICAgICAgICB1bWNfdjZfN19xdWVyeV9lcnJvcl9z
dGF0dXNfaGVscGVyKGFkZXYsIG1jX3VtY19zdGF0dXMsIHVtY19yZWdfb2Zmc2V0KTsNCj4gKw0K
PiArICAgICAgICAgICAgIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IGVycl9h
ZGRyLCBzb2NfcGE7DQo+ICsgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBtY191bWNfYWRk
cnQwOw0KPiArICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgY2hhbm5lbF9pbmRleDsNCj4g
Kw0KPiArICAgICAgICAgICAgICAgICAgICAgbWNfdW1jX2FkZHJ0MCA9DQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFNPQzE1X1JFR19PRkZTRVQoVU1DLCAwLCByZWdNQ0FfVU1DX1VN
QzBfTUNVTUNfQUREUlQwKTsNCj4gKw0KPiArICAgICAgICAgICAgICAgICAgICAgY2hhbm5lbF9p
bmRleCA9DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPnVtYy5jaGFubmVs
X2lkeF90YmxbdW1jX2luc3QgKiBhZGV2LT51bWMuY2hhbm5lbF9pbnN0X251bSArIGNoX2luc3Rd
Ow0KPiArDQo+ICsgICAgICAgICAgICAgICAgICAgICBlcnJfYWRkciA9IFJSRUc2NF9QQ0lFKCht
Y191bWNfYWRkcnQwICsgdW1jX3JlZ19vZmZzZXQpICogNCk7DQo+ICsgICAgICAgICAgICAgICAg
ICAgICBlcnJfYWRkciA9IFJFR19HRVRfRklFTEQoZXJyX2FkZHIsIE1DQV9VTUNfVU1DMF9NQ1VN
Q19BRERSVDAsIEVycm9yQWRkcik7DQo+ICsNCj4gKyAgICAgICAgICAgICAgICAgICAgIC8qIHRy
YW5zbGF0ZSB1bWMgY2hhbm5lbCBhZGRyZXNzIHRvIHNvYyBwYSwgMyBwYXJ0cyBhcmUgaW5jbHVk
ZWQgKi8NCj4gKyAgICAgICAgICAgICAgICAgICAgIHNvY19wYSA9IEFERFJfT0ZfOEtCX0JMT0NL
KGVycl9hZGRyKSB8DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQURE
Ul9PRl8yNTZCX0JMT0NLKGNoYW5uZWxfaW5kZXgpIHwNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBPRkZTRVRfSU5fMjU2Ql9CTE9DSyhlcnJfYWRkcik7DQo+ICsNCj4g
KyAgICAgICAgICAgICAgICAgICAgIC8qIFRoZSB1bWMgY2hhbm5lbCBiaXRzIGFyZSBub3Qgb3Jp
Z2luYWwgdmFsdWVzLCB0aGV5IGFyZSBoYXNoZWQgKi8NCj4gKyAgICAgICAgICAgICAgICAgICAg
IFNFVF9DSEFOTkVMX0hBU0goY2hhbm5lbF9pbmRleCwgc29jX3BhKTsNCj4gKw0KPiArICAgICAg
ICAgICAgICAgICAgICAgZGV2X2luZm8oYWRldi0+ZGV2LCAiRXJyb3IgQWRkcmVzcyhQQSk6IDB4
JWxseFxuIiwgc29jX3BhKTsNCj4gKyAgICAgICAgICAgICB9DQo+ICAgICAgICB9DQo+ICAgfQ0K
Pg0KPiBAQCAtMzk1LDcgKzQ0MCw4IEBAIHN0YXRpYyB2b2lkIHVtY192Nl83X3F1ZXJ5X3Jhc19l
cnJvcl9jb3VudChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjaF9pbnN0KTsNCj4gICAg
ICAgICAgICAgICAgdW1jX3Y2XzdfcXVlcnlfY29ycmVjdGFibGVfZXJyb3JfY291bnQoYWRldiwN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dW1jX3JlZ19vZmZzZXQsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgJihlcnJfZGF0YS0+Y2VfY291bnQpKTsNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmKGVycl9kYXRhLT5jZV9jb3Vu
dCksDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY2hfaW5zdCwgdW1jX2luc3QpOw0KPiAgICAgICAgICAgICAgICB1bWNfdjZfN19xdWVycnlf
dW5jb3JyZWN0YWJsZV9lcnJvcl9jb3VudChhZGV2LA0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bWNfcmVnX29mZnNldCwNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJihl
cnJfZGF0YS0+dWVfY291bnQpKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG0vc3dzbXUvc211MTMvYWxkZWJhcmFuX3BwdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9z
d3NtdS9zbXUxMy9hbGRlYmFyYW5fcHB0LmMNCj4gaW5kZXggOWNkZmVlYTU4MDg1Li5jN2UwZmVj
NjE0ZWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMv
YWxkZWJhcmFuX3BwdC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211
MTMvYWxkZWJhcmFuX3BwdC5jDQo+IEBAIC0xODgzLDYgKzE4ODMsNyBAQCBzdGF0aWMgc3NpemVf
dCBhbGRlYmFyYW5fZ2V0X2VjY19pbmZvKHN0cnVjdCBzbXVfY29udGV4dCAqc211LA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgIGVjY19pbmZvX3Blcl9jaGFubmVsLT5tY2FfY2V1bWNfYWRkciA9
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlY2NfdGFibGUtPkVjY0luZm9fVjJb
aV0ubWNhX2NldW1jX2FkZHI7DQo+ICAgICAgICAgICAgICAgIH0NCj4gKyAgICAgICAgICAgICBl
Y2NpbmZvLT5yZWNvcmRfY2VfYWRkcl9zdXBwb3J0ZWQgPTE7DQo+ICAgICAgICB9DQo+DQo+ICAg
ICAgICByZXR1cm4gcmV0Ow0KPg0K

--_000_BL1PR12MB5334F2D1B8D4B5FED3AACFD79AD69BL1PR12MB5334namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:=CB=CE=CC=E5;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:DengXian;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;" a=
lign=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"col=
or:black">=B7=A2=BC=FE=C8=CB</span></b><b><span lang=3D"EN-US" style=3D"fon=
t-family:&quot;Calibri&quot;,sans-serif;color:black">:</span></b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
> Lazar,
 Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
</span><b><span style=3D"color:black">=C8=D5=C6=DA</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black">
</span><span style=3D"color:black">=D0=C7=C6=DA=C8=FD</span><span lang=3D"E=
N-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">, 20=
22</span><span style=3D"color:black">=C4=EA</span><span lang=3D"EN-US" styl=
e=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">5</span><span =
style=3D"color:black">=D4=C2</span><span lang=3D"EN-US" style=3D"font-famil=
y:&quot;Calibri&quot;,sans-serif;color:black">25</span><span style=3D"color=
:black">=C8=D5</span><span style=3D"font-family:&quot;Calibri&quot;,sans-se=
rif;color:black">
</span><span style=3D"color:black">=CF=C2=CE=E7</span><span lang=3D"EN-US" =
style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">8:38<br>
</span><b><span style=3D"color:black">=CA=D5=BC=FE=C8=CB</span></b><b><span=
 lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:b=
lack">:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&q=
uot;,sans-serif;color:black"> Yang, Stanley &lt;Stanley.Yang@amd.com&gt;, a=
md-gfx@lists.freedesktop.org
 &lt;amd-gfx@lists.freedesktop.org&gt;, Zhang, Hawking &lt;Hawking.Zhang@am=
d.com&gt;, Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;, Quan, Evan &lt;Evan.Quan@a=
md.com&gt;<br>
</span><b><span style=3D"color:black">=D6=F7=CC=E2</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black"> Re: [PATCH Review v3 2/2] drm/amdgpu: print umc
 correctable error address<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><br>
<br>
On 5/25/2022 11:40 AM, Stanley.Yang wrote:<br>
&gt; Changed from V1:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remove unnecessary same row =
physical address calculation<br>
&gt; <br>
&gt; Changed from V2:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; move record_ce_addr_supporte=
d to umc_ecc_info struct<br>
&gt; <br>
&gt; Signed-off-by: Stanley.Yang &lt;Stanley.Yang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; |&nbsp; 5 ++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/umc_v6_7.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; | 50 ++++++++++++++++++-<br>
&gt;&nbsp;&nbsp; .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c&nbsp;&nbsp;&nbs=
p; |&nbsp; 1 +<br>
&gt;&nbsp;&nbsp; 3 files changed, 54 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ras.h<br>
&gt; index 28e603243b67..bf5a95104ec1 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
&gt; @@ -333,6 +333,11 @@ struct ecc_info_per_ch {<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; struct umc_ecc_info {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ecc_info_per_ch ecc[M=
AX_UMC_CHANNEL_NUM];<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Determine smu ecctable whether support<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * record correctable error address<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int record_ce_addr_supported;<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; struct amdgpu_ras {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/a=
md/amdgpu/umc_v6_7.c<br>
&gt; index 606892dbea1c..bf7524f16b66 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c<br>
&gt; @@ -119,6 +119,24 @@ static void umc_v6_7_ecc_info_query_correctable_e=
rror_count(struct amdgpu_device<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *error_count +=3D 1;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; umc_v6_7_query_error_status_helper(adev, mc_umc_status,=
 umc_reg_offset);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ras-&gt;umc_ecc.record_ce_addr_supported)&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t err_addr, soc_=
pa;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t channel_index =
=3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.channel_idx_tbl[umc_inst * adev-&gt;u=
mc.channel_inst_num + ch_inst];<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err_addr =3D ras-&gt;um=
c_ecc.ecc[eccinfo_table_idx].mca_ceumc_addr;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err_addr =3D REG_GET_FI=
ELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* translate umc channe=
l address to soc pa, 3 parts are included */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc_pa =3D ADDR_OF_8KB_=
BLOCK(err_addr) |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AD=
DR_OF_256B_BLOCK(channel_index) |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OF=
FSET_IN_256B_BLOCK(err_addr);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The umc channel bits=
 are not original values, they are hashed */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SET_CHANNEL_HASH(channe=
l_index, soc_pa);<br>
&gt; +<br>
<br>
UMC address to PA conversion is common regardless of UE/CE error <br>
addresses. You may want to pack it in a small function.<br>
<br>
Regardless,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Acked-by: Lijo Lazar &lt;lijo.la=
zar@amd.com&gt;<br>
<br>
Thanks,<br>
Lijo<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">Stanley: These lines are indeed redundant. I'll make a pat=
ch to simplify it.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">Reagards,<br>
Stanley<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, =
&quot;Error Address(PA): 0x%llx\n&quot;, soc_pa);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -251,7 +269,9 @@ static void umc_v6_7_ecc_info_query_ras_error_addr=
ess(struct amdgpu_device *adev<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void umc_v6_7_query_correctable_error_count(struct =
amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t umc_reg_offset,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned lo=
ng *error_count)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned lo=
ng *error_count,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ch=
_inst,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t um=
c_inst)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ecc_err_cnt_sel, ec=
c_err_cnt_sel_addr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ecc_err_cnt, ecc_er=
r_cnt_addr;<br>
&gt; @@ -295,6 +315,31 @@ static void umc_v6_7_query_correctable_error_coun=
t(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *error_count +=3D 1;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; umc_v6_7_query_error_status_helper(adev, mc_umc_status,=
 umc_reg_offset);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t err_addr, soc_=
pa;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mc_umc_addrt0;=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t channel_index;=
<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc_umc_addrt0 =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_ADD=
RT0);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; channel_index =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.channel_idx_tbl[umc_inst * adev-&gt;u=
mc.channel_inst_num + ch_inst];<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err_addr =3D RREG64_PCI=
E((mc_umc_addrt0 + umc_reg_offset) * 4);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err_addr =3D REG_GET_FI=
ELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* translate umc channe=
l address to soc pa, 3 parts are included */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc_pa =3D ADDR_OF_8KB_=
BLOCK(err_addr) |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AD=
DR_OF_256B_BLOCK(channel_index) |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OF=
FSET_IN_256B_BLOCK(err_addr);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The umc channel bits=
 are not original values, they are hashed */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SET_CHANNEL_HASH(channe=
l_index, soc_pa);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, =
&quot;Error Address(PA): 0x%llx\n&quot;, soc_pa);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -395,7 +440,8 @@ static void umc_v6_7_query_ras_error_count(struct =
amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ch_inst);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; umc_v6_7_query_correctable_error_count(adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_reg_offset,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &amp;(err_data-&gt;ce_count));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &amp;(err_data-&gt;ce_count),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; ch_inst, umc_inst);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; umc_v6_7_querry_uncorrectable_error_count(adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_reg_offset,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;(err_data-&gt;ue_count)=
);<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
&gt; index 9cdfeea58085..c7e0fec614ea 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
&gt; @@ -1883,6 +1883,7 @@ static ssize_t aldebaran_get_ecc_info(struct smu=
_context *smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_inf=
o_per_channel-&gt;mca_ceumc_addr =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_table-&gt;EccInfo_V2[i].mca_ce=
umc_addr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; eccinfo-&gt;record_ce_addr_supported =3D1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; <o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB5334F2D1B8D4B5FED3AACFD79AD69BL1PR12MB5334namp_--
