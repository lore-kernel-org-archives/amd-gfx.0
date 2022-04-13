Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190ACC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Apr 2022 17:43:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABDAD10E073;
	Wed, 13 Apr 2022 17:43:39 +0000 (UTC)
Received: from na01-obe.outbound.protection.outlook.com
 (mail-eus2azon11021017.outbound.protection.outlook.com [52.101.57.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A99710E073
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 17:33:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dzip8o4Zp+pvtR57Tga9ffkIrPUAcM0NV20YIgh/UD9nyQMnXkvytPLSpSsEHIQob1Z8CDcSQ4uBCbKiEcCr8YJ5akDl8tzlZ1yts+2kYvc+sHIf+6sd4zDhJYRN2lh6znMBHwUfBCEYdUeGuAu8pRTlLNzgL98y66R/JKvWqZT3/KjsTPEFFNr590KQDQ6iBaX848uLcZLA44W9b4lLgWrnH0noGDWDebqvrsbpNmYyDg+/f1eC+6MKhBrfq+DQO4VaP/ffmfPk6oqkZLBK0ASQJP9KisiGaV4MVc/X6gSXh+vA8huRhnBw181MOCjK+hzD3ohG8df4+eJnz3fYbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jonTiQwHIJz5zYgJdhf5C5V0dRMFmEFimG35pJwymvQ=;
 b=kNGSww7Vj3BJ7NkVs0zQe9x9EFu86LFsdvVmt4/oWbvc3d6SBJw8MNSSrJTAs62ZXSu4CkB8mZIJWmyGdU4BwHdF3g539Jf17rbEILCcUqWqxyRWctdGcTGK0rmqMk4bttueflUr1s6dQDxUvWjauFoZp4dbKcBs24VIUnvv0Tr/f4BHQjLiJj5/9T+G1iJ+0Nj37rAtM6FtRYbFmmzGOGGSXhRN6O+rDnKrIG62oMZZOD9U57/GtUdARbyTAqbyxDLML6FXOpmt/3+CWIk3HEDx27reeK+GqBa3znTDXrW62+ipTASZekP+FU1qTGJevq4lBgbIMytu/MG+2kER+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jonTiQwHIJz5zYgJdhf5C5V0dRMFmEFimG35pJwymvQ=;
 b=cnJdcu66iqTZCHb5zXPxa2Zg7DYV6qipm4OteXXfMANnH7sAkoJvuv2PsE13Foqr/9IPqfkgt2EKjnbuB3o8ad1OegUxNHlurAmYWJgIorJ6ixFMstRID00Th0oNKTelZF5WFsHhNuD3E+Rfg9r6N1JzJKrXSnpwwB5ivkXgjY4=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by MN0PR21MB3049.namprd21.prod.outlook.com (2603:10b6:208:371::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.6; Wed, 13 Apr
 2022 17:33:41 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ac09:6e1b:de72:2b2f]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ac09:6e1b:de72:2b2f%9]) with mapi id 15.20.5186.008; Wed, 13 Apr 2022
 17:33:41 +0000
From: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To: Alex Deucher <alexdeucher@gmail.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH] drm/amd/amdgpu: Not request init data for MS_HYPERV with
 vega10
Thread-Topic: [PATCH] drm/amd/amdgpu: Not request init data for MS_HYPERV with
 vega10
Thread-Index: AQHYTlEnMA0y0gwc0EWKYw7xpXrW2KzsUi0AgAHIXbA=
Date: Wed, 13 Apr 2022 17:33:40 +0000
Message-ID: <PH0PR21MB30254636E4F4B8C5BD7D57FBD7EC9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220411135939.906700-1-yongqiang.sun@amd.com>
 <f06ce5e3-158b-88a8-06f0-53b88c4fad45@molgen.mpg.de>
 <CADnq5_PSZX+11meHYn9CR3A4LiseGo30TwbkOuPgTQsfbYxmCg@mail.gmail.com>
 <88760cd1-d1ed-8952-d061-15e238b2ec57@molgen.mpg.de>
 <CADnq5_MdSn0_X6Bqd-Ljv_QzVpgtBYXUkkALEdFasCiiXx=o7g@mail.gmail.com>
In-Reply-To: <CADnq5_MdSn0_X6Bqd-Ljv_QzVpgtBYXUkkALEdFasCiiXx=o7g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3ddda117-b79d-4a54-bb7e-9d2d19907814;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-04-13T17:26:18Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f86c378-82c2-4033-2a69-08da1d73c03a
x-ms-traffictypediagnostic: MN0PR21MB3049:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <MN0PR21MB30498B910CFD6D266436CD48D7EC9@MN0PR21MB3049.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2CoBBlXEAcX6ZvPiluY9b6+VDVmGlavV+T7Vf6Lu0C2HvsBBsHv2IvizwVKloLonvr8UjocShvcgKb8Mh9nj2PTvHGXZnHva9oViWTGiDdhrhgpIXQn1/eJltjXsF9ZXTzoiHp0vbML2hVmLjj/hvP3FN/+B0p69TTCQWGyl3HIxvtc2Myc3j8AKvkGS5p3qz7NcOsBsbIFh+Iac0uE5F+ybq1hkQWyeLJh8TPhk/OaODQslACXQq/eFyOrJxV5+t1o5BjXacHTlkEU2pffBZQWcKCOAE01yPMQRT9qmlDEzUhQJWZac4epb+iXokuehRgJFln8FVJnht1z5wbywyG606HmNkhx0X3AB3P1tC3U2CeZh9gONh+gKdhkPyG1Ip30FKl5ANQ+6rlJpNPuUyqxFyIEGBJ+b34gEhfWNV9NIPwQasVmwwv04Q05uSErKXGjX+0koIDxxdlwMQ45fNjFeUfrTcObAxLEGLvsbCYgoxFYWyN8ydKQVry0cTQ6fhc+W9QkWZRv/jyRrsb1BqC5/6VfekvYqFGZIE0+cZ/yFYAoOHQJRvnIPzYxvpxNrJD2PxJbxECZEPzcr8KVKRTSe9+8zOLusAIE+4HqJh3UJjFMHMWgBa6xUi5kMt7h4oWpzuum0pNtyj7YuusWX9acqjlTHlijj0NifHLrqB0oW0HlxePgNQgbMUauwMJRr4Qdr4oRDrFQ7V0yixY2bOaNEhaD4BbS5PqSeQZNjsMbvSxPaZfMjbErx65lsGeo+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR21MB3025.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(451199009)(38100700002)(508600001)(122000001)(7416002)(53546011)(8990500004)(82960400001)(316002)(83380400001)(7696005)(10290500003)(6506007)(82950400001)(2906002)(186003)(110136005)(5660300002)(38070700005)(66946007)(9686003)(8936002)(52536014)(54906003)(26005)(8676002)(4326008)(76116006)(66446008)(55016003)(64756008)(66476007)(66556008)(71200400001)(33656002)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFhpL01ZeDBRS2V4UDZacytDVnV3ZlBGQ3IxZUwyY25yTGxPNmlIVlBkYmdl?=
 =?utf-8?B?dEZjeTNwaS9LT0FKbGl3U3k5aHB3UjkwSVViSlA4SndRWXRKVWswdjdva1pW?=
 =?utf-8?B?aFRUcGFyN0JKSU9lUXcxWFQrM01TcEZ0c0Q2bjMyUjJ0Rkd4SU1vd1NWSUFQ?=
 =?utf-8?B?N2hpMXU0ckxUU3BsUFZMRjJEMXlQOHNoZlhJTUJxYXpZd3RGRzFZaGU1ZWVZ?=
 =?utf-8?B?UE1Zc2xFOXdIcDhuV0lTU2pydkJGa3Z3Y3g4ZUFTckNMb21tbjJ6RmlBTHVw?=
 =?utf-8?B?N0FoTm1xTkh5L3R5QnNBTUdOcW40ZytGa2ZJTjlqLzI4UUU1SEJ1YzFtRVVp?=
 =?utf-8?B?OFU2Z0VISkEyb0tjVUlMaEZ5d244N0hyMTlZZnh0cGVZOCsraWpMNHBRSXRR?=
 =?utf-8?B?L0trUVpPVUFhVVBOSE9xd1NaamZhb0VZNkJjT0dWRC9CVHNRa3ovV2NGT1ZW?=
 =?utf-8?B?bEhrMUxMNFcrcXVPZzkwTzJJWHcxSHk4MTkyNUVLYzZCZkw4N0ZLVDIranpC?=
 =?utf-8?B?dGp4YkduallrS2FVSWtKeG9KdEpPOUtMSGs4YWEzQk4zUEUxZ2l6RjJIY2tt?=
 =?utf-8?B?Q2oxbFhOZEVlZWpCb3Q3Yzhxd0lISTdMUXFlb1Y4dStlNGJEdUwxbitvbkdl?=
 =?utf-8?B?Rnk2US9aeEFYWENOc0FwSkI5V05PWjFEbTQwOFYwR2VZYUs4U3g5MFpYZExF?=
 =?utf-8?B?UGhzZlJXWm5zYTFZWHQ1dEhMY1NCNlJWaDhCT09rNnREYVZlN2t1alViQ1Ry?=
 =?utf-8?B?ckVTMHRoeXgrdDhqSldXL2ZhRmV6eGg3SE1VUVdBb01tbGRmR0Rad3M5MFl6?=
 =?utf-8?B?N2JuRzlJazFzbmxqQTl1RVUxbEx5NjVJK200M0Q0UDJSTkFXcktHcUVNZVhx?=
 =?utf-8?B?YWNMQmxwdkNpWVpyVENRdkhKczNTc3FiMXB4T0RPbUNwU0hTVFFhUnBCdzRt?=
 =?utf-8?B?RGhCSFBDbzIzbTZwK2t1WkJEdnlmcmdPdll4amlFY3dkNVg3V1plT1d1RWVp?=
 =?utf-8?B?YzhRYlZySDFvak5vdlpOazJYL1BTalp4K1JEVU0vbWhLa0R3VmJxbkVxRzFx?=
 =?utf-8?B?NjFWbk50Ty9MT2ZNUzRZdmYxeWUzRUZDaUFHQ01LOXlENnYwMFJXQ2RrVjZR?=
 =?utf-8?B?VjNya3hFdXNuaGVRL0tFOU1xQUhiMU9hb2k3K3MrK0JLaFpGdTlMWS9XYlJr?=
 =?utf-8?B?YTB2aFgvRHQ4S0pTL1JkUWdpanRUdy92TjdBYmErcmhqTjI5eVdodmU1Qm9y?=
 =?utf-8?B?RklZWDhjb0RaeEVxQndkMmxWbWMzZHRuY3dxbUZzWHVUc1JSMkdLQ3RkTm5p?=
 =?utf-8?B?V2xBMmY2OENNTERsdXF6a2h3UHFuRFcvUDRGNm5HZkhsWHFZc1kvbjBrWDlM?=
 =?utf-8?B?eG1RaDFHR09haUhha2x6NmVOYTlFRGthcE5sZGlvWVVPU1ZnTnVpeEpRYitS?=
 =?utf-8?B?NUgxMHFPSjFuZWthVzUrYmZyWHFSZzhBZVpsVEVMd1U1TjZuelp1Y0ltRjJz?=
 =?utf-8?B?ZWNZZ0NtWlA1dGhIUS8rcmlSNGxYaTRYRFdEKy94dVVYOFBiR3FlL1BkWmtV?=
 =?utf-8?B?RHpKQS9mZzR0VWxzTEZXSHRvNVJlb0d2aG1rSThOQmRqZ0RiMDRIaldCT0Yv?=
 =?utf-8?B?SGc1M0N4eGpTYnFHNjhzM3I5OTlhY2xXWldVQy9VRUI0dU9QRUozU3AyNmJE?=
 =?utf-8?B?OXc2TGpETThNamhQQ09RVEVwZ2ErNXhjaXB5cUhSLzFhM0hSQnVqbXlqUVY5?=
 =?utf-8?B?ZnNpazVTRVh5T0tHcUtudGhHT0Y2MHF0Q0FpUG1SMGUvY20zbnNnemFnT0Fr?=
 =?utf-8?B?WTBLVzdSbktyVXRxNmFTVVFaM0Zxclk5bGl1K2FCSyt6NG9DQisxbWQwZXds?=
 =?utf-8?B?SzFYelluNjlqM09aQkNINEtYaW1rNGRyZmV5MFhidTdOWG5DTkxVUmJhaEFR?=
 =?utf-8?B?YVdGWU1CWmVZKzE2Z3E4WUkzTDRSOXpSRUtYb2dnaHBMRHdSQ3RhRGc0amFR?=
 =?utf-8?B?VnJ2RDltcHkyMU5hU0ZOaE1SMWhPcVlNTDdhd3BieTgwd0ZvU0VTMVVWUXBz?=
 =?utf-8?B?MmZZYmtPU0hYZGxBdmZHc3FrbEk4NUdyV3o2Z00vTDV5NVk3eWpIeTdNekFn?=
 =?utf-8?B?NDAySHlmM0hXcFZURmo2ZWk5amxrdTdRVDJ3YlBjZEpSMXhFcFdGY3dTZjFi?=
 =?utf-8?B?bERuVGJLT1BxQ1NOUHU5b1oxREVBQXNJcWV0eW8vdXdMMmh0OVA1SzhIRFRt?=
 =?utf-8?B?RDBCbkEraTR6N1Y1bDJsL0pSZkdsTUVnMFRreFNXMFp3R3Rjek9yL1NpN2lw?=
 =?utf-8?B?Tnl4Z0dHeU4weDk2NldrbVlvK0NVNXl2ZXE4K01IZW1mRk9rV0dkWDEvZHJl?=
 =?utf-8?Q?Hch28Phi43y8M7co=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f86c378-82c2-4033-2a69-08da1d73c03a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 17:33:40.8728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fRzbDEVJt2cQuwISG0wG21Coznf51O33zidim4Co03NE4GpPF2ITAmpnPA5eeeYU5YrVv0+w+g76kh/7V2yKZOMaKBpcv7c3zvD8zRzCf3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3049
X-Mailman-Approved-At: Wed, 13 Apr 2022 17:43:34 +0000
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
Cc: X86 ML <x86@kernel.org>, "Luo, Zhigang" <zhigang.luo@amd.com>,
 Jingwen Chen <jingwen.chen2@amd.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Yongqiang Sun <yongqiang.sun@amd.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "monk.liu" <monk.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+IFNlbnQ6IFR1ZXNkYXks
IEFwcmlsIDEyLCAyMDIyIDc6MTMgQU0NCj4gDQo+IE9uIFR1ZSwgQXByIDEyLCAyMDIyIGF0IDQ6
MDEgQU0gUGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4gd3JvdGU6DQo+ID4NCj4g
PiBbQ2M6ICt4ODYgZm9sa3NdDQo+ID4NCj4gPiBEZWFyIEFsZXgsIGRlYXIgeDg2IGZvbGtzLA0K
PiA+DQo+ID4NCj4gPiB4ODYgZm9sa3MsIGNhbiB5b3UgdGhpbmsgb2YgYWx0ZXJuYXRpdmVzIHRv
IGFjY2VzcyBgWDg2X0hZUEVSX01TX0hZUEVSVmANCj4gPiBmcm9tIGBhcmNoL3g4Ni9pbmNsdWRl
L2FzbS9oeXBlcnZpc29yLmhgIHdpdGhvdXQgYW55IHByZXByb2Nlc3NvciBpZmRlZi1lcnk/DQo+
IA0KPiBJIGRvbid0IHJlYWxseSBzZWUgd2hhdCBwcm9ibGVtIHRoYXQgc29sdmVzLiAgWDg2X0hZ
UEVSX01TX0hZUEVSViBpcw0KPiBhbiBYODYgdGhpbmcuICBXaHkgZG8gd2UgbmVlZCBhIHByb2Nl
c3NvciBhZ25vc3RpYyB3YXkgdG8gaGFuZGxlIGl0Pw0KPiBBbnkgY29kZSByZWxhdGVkIHRvIHRo
YXQgaXMgWDg2IHNwZWNpZmljLg0KPiANCj4gQWxleA0KDQpUcnkgdXNpbmcgaHZfaXNfaHlwZXJ2
X2luaXRpYWxpemVkKCkgd2l0aG91dCBhbnkgI2lmZGVmJ2VyeS4gIElmDQpDT05GSUdfSFlQRVJW
IGlzIGRlZmluZWQsIGl0IHdpbGwgdGVsbCB5b3UgaWYgeW91IGFyZSBydW5uaW5nIGFzIGEgZ3Vl
c3QNCm9uIEh5cGVyLVYgb24geDg2L3g2NCBvciBvbiBBUk02NC4gIElmIENPTkZJR19IWVBFUlYg
aXMgbm90IGRlZmluZWQsDQppdCB3aWxsIHJldHVybiAiZmFsc2UiLg0KDQpZb3UnbGwgbmVlZCB0
byAjaW5jbHVkZSA8YXNtL21zaHlwZXJ2Lmg+Lg0KDQpNaWNoYWVsDQoNCj4gDQo+ID4NCj4gPg0K
PiA+IEFtIDExLjA0LjIyIHVtIDE4OjI4IHNjaHJpZWIgQWxleCBEZXVjaGVyOg0KPiA+ID4gT24g
TW9uLCBBcHIgMTEsIDIwMjIgYXQgMTE6MjggQU0gUGF1bCBNZW56ZWwgd3JvdGU6DQo+ID4NCj4g
PiBb4oCmXQ0KPiA+DQo+ID4gPj4gQW0gMTEuMDQuMjIgdW0gMTU6NTkgc2NocmllYiBZb25ncWlh
bmcgU3VuOg0KPiA+ID4+PiBNU19IWVBFUlYgd2l0aCB2ZWdhMTAgZG9lc24ndCBoYXZlIHRoZSBp
bnRlcmZhY2UgdG8gcHJvY2Vzcw0KPiA+ID4+PiByZXF1ZXN0IGluaXQgZGF0YSBtc2cuDQo+ID4g
Pj4NCj4gPiA+PiBTaG91bGQgc29tZSBIeXBlci1WIGZvbGtzIGJlIGFkZGVkIHRvIHRoZSByZXZp
ZXdlcnMgbGlzdCB0b28/DQo+ID4gPj4NCj4gPiA+Pj4gQ2hlY2sgaHlwZXJ2aXNvciB0eXBlIHRv
IG5vdCBzZW5kIHRoZSByZXF1ZXN0IGZvciBNU19IWVBFUlYuDQo+ID4gPj4NCj4gPiA+PiBQbGVh
c2UgYWRkIGEgYmxhbmsgbGluZSBiZXR3ZWVuIHBhcmFncmFwaHMuDQo+ID4gPj4NCj4gPiA+Pj4g
U2lnbmVkLW9mZi1ieTogWW9uZ3FpYW5nIFN1biA8eW9uZ3FpYW5nLnN1bkBhbWQuY29tPg0KPiA+
ID4+PiAtLS0NCj4gPiA+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zp
cnQuYyB8IDEyICsrKysrKysrKystLQ0KPiA+ID4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+Pj4NCj4gPiA+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmMNCj4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jDQo+ID4gPj4+IGluZGV4IDkzM2M0MWY3N2M5
Mi4uNTZiMTMwZWM0NGE5IDEwMDY0NA0KPiA+ID4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdmlydC5jDQo+ID4gPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92aXJ0LmMNCj4gPiA+Pj4gQEAgLTIzLDYgKzIzLDEwIEBADQo+ID4gPj4+
DQo+ID4gPj4+ICAgICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gPiA+Pj4NCj4gPiA+Pj4g
KyNpZmRlZiBDT05GSUdfWDg2DQo+ID4gPj4+ICsjaW5jbHVkZSA8YXNtL2h5cGVydmlzb3IuaD4N
Cj4gPiA+Pj4gKyNlbmRpZg0KPiA+ID4+PiArDQo+ID4gPj4+ICAgICNpbmNsdWRlIDxkcm0vZHJt
X2Rydi5oPg0KPiA+ID4+Pg0KPiA+ID4+PiAgICAjaW5jbHVkZSAiYW1kZ3B1LmgiDQo+ID4gPj4+
IEBAIC03MjEsOCArNzI1LDEyIEBAIHZvaWQgYW1kZ3B1X2RldGVjdF92aXJ0dWFsaXphdGlvbihz
dHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldikNCj4gPiA+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICBicmVhazsNCj4gPiA+Pj4gICAgICAgICAgICAgICAgY2FzZSBDSElQX1ZFR0ExMDoNCj4g
PiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICBzb2MxNV9zZXRfdmlydF9vcHMoYWRldik7DQo+
ID4gPj4+IC0gICAgICAgICAgICAgICAgICAgICAvKiBzZW5kIGEgZHVtbXkgR1BVX0lOSVRfREFU
QSByZXF1ZXN0IHRvIGhvc3Qgb24gdmVnYTEwICovDQo+ID4gPj4+IC0gICAgICAgICAgICAgICAg
ICAgICBhbWRncHVfdmlydF9yZXF1ZXN0X2luaXRfZGF0YShhZGV2KTsNCj4gPiA+Pj4gKyNpZmRl
ZiBDT05GSUdfWDg2DQo+ID4gPj4+ICsgICAgICAgICAgICAgICAgICAgICAvKiBub3Qgc2VuZCBH
UFVfSU5JVF9EQVRBIHdpdGggTVNfSFlQRVJWKi8NCj4gPiA+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgIGlmIChoeXBlcnZpc29yX2lzX3R5cGUoWDg2X0hZUEVSX01TX0hZUEVSVikgPT0gZmFsc2Up
DQo+ID4gPj4+ICsjZW5kaWYNCj4gPiA+Pg0KPiA+ID4+IFdoeSBndWFyZCBldmVyeXRoaW5nIHdp
dGggQ09ORklHX1g4Nj8gKElmIGl04oCZcyBuZWVkZWQsIGl0IHNob3VsZCBiZSBkb25lDQo+ID4g
Pj4gaW4gQyBjb2RlLikNCj4gPiA+DQo+ID4gPiBYODZfSFlQRVJfTVNfSFlQRVJWIG9ubHkgYXZh
aWxhYmxlIG9uIHg4Ni4NCj4gPg0KPiA+IFNvcnJ5LCBJIG1pc3NlZCB0aGUgWDg2IGRlcGVuZGVu
Y3kgd2hlbiBxdWlja2x5IGxvb2tpbmcgYXQgdGhlIEh5cGVyLVYNCj4gPiBzdHViIElPTU1VIGRy
aXZlciBgZHJpdmVycy9pb21tdS9oeXBlcnYtaW9tbXUuY2AsIGJ1dCBtaXNzZWQgdGhhdA0KPiA+
IGBIWVBFUlZfSU9NTVVgIGhhcyBgZGVwZW5kcyBvbiBIWVBFUlYgJiYgWDg2YC4NCj4gPg0KPiA+
DQo+ID4gS2luZCByZWdhcmRzLA0KPiA+DQo+ID4gUGF1bA0KPiA+DQo+ID4NCj4gPiA+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgLyogc2VuZCBhIGR1bW15IEdQVV9JTklUX0RBVEEg
cmVxdWVzdCB0byBob3N0IG9uIHZlZ2ExMCAqLw0KPiA+ID4+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBhbWRncHVfdmlydF9yZXF1ZXN0X2luaXRfZGF0YShhZGV2KTsNCj4gPiA+Pj4g
ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiA+Pj4gICAgICAgICAgICAgICAgY2Fz
ZSBDSElQX1ZFR0EyMDoNCj4gPiA+Pj4gICAgICAgICAgICAgICAgY2FzZSBDSElQX0FSQ1RVUlVT
Og0KPiA+ID4+DQo+ID4gPj4NCj4gPiA+PiBLaW5kIHJlZ2FyZHMsDQo+ID4gPj4NCj4gPiA+PiBQ
YXVsDQo=
