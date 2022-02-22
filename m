Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BC4C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 05:56:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A972D10EB15;
	Tue, 22 Feb 2022 05:56:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F55510EB15
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 05:56:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOlR7P/iGIxqnTMNCqwBiQ/4dVS0QJCaMjgkvCa17hFSqS2eT2Rnq4Gfgw1UkoB/dRTMpKdu2BtGYDTq9CsXf8u7Nu9T+4qL63EgXLDgqUdBSggDd1QUmjCPDNGMHUGEPHQhqT64vViTmyXAROE+GmYbwnerzHaxp4eqdy98qNTCdkctSUh8CJOL8WeMGU5KqLPR7yZ6Sr8dtiDtBfebPwO1cP5DvlS+bOwgAzjKWQ1FFILw4utimi8ccZiB96c5zk4+ZXn/I9eYbz85eklhDRW1UYXoubi9jzhYZqg7LzQTgz474MPku+7gPU3AtKKuhV/HLCY5EdATX5sD5lBZag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyvCNMCz+Wbi8ZrLqgzzz/ocHUjjgfG6PSKgKFTc9GE=;
 b=dE7+552V/9XuY67iBCwUVZiyo51kyJQ54dGxfaxmNOZqmJ1x4gQX1jSMwJdZmMg5GsHiQO5E5yQCF1rXaxrLhZP8SF1rHKOhYeo0KDsfYGjVXc7rsAwfb83V83hx1kjxnn5iQGbdrhaA39ihsvPmpls+xiAecLAunmGu9sWQw2c5SNYNaeDLEcaC2nHF8jofS3a54PmKiSKJZIFsJEPozow9Dmu8/NDYS5MlRFMpP+BbQ+9IuaYPznia3qPKh7TqfxxipfPiye3Z6TzT5rmnvJSK/+nelwZLAz5T4hoMlMe70vIU8YFnASNI03GyDnDyJgv44QFNx4aIONtslyoc2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyvCNMCz+Wbi8ZrLqgzzz/ocHUjjgfG6PSKgKFTc9GE=;
 b=4u/WMouHs1FYlixLM9lQDUE/nNxSqSyrBM5BPjVCb53iNYobJCJshJ2QD48TuAwz/kTe6EWbzC68eNnXOsNhY+KsCis+AboHAYxLkzUvLB55o3CAtQRnuV63zkP82uR+NpsNM8sbU/CH51soYfHGIVZ9+yW2NBmI3hQl5fntWFU=
Received: from BN6PR12MB1187.namprd12.prod.outlook.com (2603:10b6:404:1b::19)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 05:56:17 +0000
Received: from BN6PR12MB1187.namprd12.prod.outlook.com
 ([fe80::28:9df5:e8a4:a6a0]) by BN6PR12MB1187.namprd12.prod.outlook.com
 ([fe80::28:9df5:e8a4:a6a0%6]) with mapi id 15.20.5017.021; Tue, 22 Feb 2022
 05:56:17 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/display: add GTT domain support for dcn 3.1.5
Thread-Topic: [PATCH] drm/amd/display: add GTT domain support for dcn 3.1.5
Thread-Index: AQHYJwvu21KUdhtei0y7aKE+cR5Kq6yeEFUAgAA/jQCAAMKyMA==
Date: Tue, 22 Feb 2022 05:56:17 +0000
Message-ID: <BN6PR12MB1187D7EF090B930E8F3FF824C13B9@BN6PR12MB1187.namprd12.prod.outlook.com>
References: <20220221101451.809067-1-yifan1.zhang@amd.com>
 <CADnq5_N9cAnrcJLN57BA0q2_=Mcr4bDCynkmNyYWPMGpy7kieQ@mail.gmail.com>
 <d6c977a1-ce77-a7a8-b55b-6c07628a430e@gmail.com>
In-Reply-To: <d6c977a1-ce77-a7a8-b55b-6c07628a430e@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-22T05:56:13Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=a86fc03e-859f-4d38-b7af-a251984c9b52;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-22T05:56:13Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: f7593e8b-1c0d-4fd2-be18-16cb386adfd5
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cda831e9-81c2-4888-19ef-08d9f5c80ae6
x-ms-traffictypediagnostic: DM6PR12MB4297:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4297C3EBF1A3615611D91230C13B9@DM6PR12MB4297.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tQ7/NRpXcmY6bjuFYJRXJQbwT2mBnW6S7gc4URBRWHvAAWBP+gnt/jMi+bWt61Yk14HbkXd7HsBCB8PFj6Hb7MqzfLWvkodU5NvbLA3OXTmIWYVlDYPpasFPjrz3CNi55rpNo7f80B07UQantRXLzkr7xRpHS9fhh4/ji4VfBRoq0CB/8QcspJ+A+H3/c42Ez2aCrVpI67h1FxERjQrQG0Eg2+6I37hMVVID+yvovSVdlJhYLL6StBSWiV7NB55vGfTqRIhQsUEZGPqyWplsre8PxF1hHXm9UsV91klnconKUDBMuv5M8AphElg1F9bIXUa5PEl88qo6mnqchBYHhGzDgS24DKn3TeAWCzlSyT0LYhIz06Xf7Q1kDl5XV9YHVaiV3ld8vdIgjmeZXnatXJF0N+5Uy3ddfT0u7Ay8cZ52y0xQt8WKLeckNN5ZMKBwcioAxUBk5W5ucg9Yf3RAijJu7achAPZ1Ir4pe3kp5N62f07PutcF8RRiG4g+Ccc4ZEeFg3QPPx1KnJzwhOWWrHCtl7gkezg100/lU5URfEmiNv+/5fSADiG59arGTZA3NBlHkHBVl7RxyhWruoBfkSTAAchRbwmr+GXcEoOqkd3t5DY2XzSv3SeUdVgKyxIDnTRNIlVWVkmuCbKP3g3gCrebBTEgKxAJEWJi2D7xQIt7Zrbcg176j9Er80oeKU/VomgQLFniFrKv1+xvGocEmg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1187.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(26005)(66476007)(66946007)(76116006)(9686003)(66556008)(7696005)(6506007)(53546011)(86362001)(54906003)(110136005)(508600001)(71200400001)(64756008)(316002)(66446008)(8676002)(122000001)(38070700005)(83380400001)(4326008)(38100700002)(55016003)(52536014)(5660300002)(8936002)(33656002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3hZcW81L0psSGZlN0V2YTlTbUlHZmdKNXdRVVVXUThGUHpjWnJQSkFxT2ph?=
 =?utf-8?B?dzF2RWM3Q1RTcUJoeTB4L1pFSjFCSklLaktYd2dDcWZJYndIQkowaDM5VjV3?=
 =?utf-8?B?VnA1Mk5MTzNoVkpOdml1UmtvY2FCb1B2bVNSV1E3Y3F4TkU0eFpwcGpCaTBT?=
 =?utf-8?B?Ni8xaTNrR0R1R3AvZG44UHBjVTZhcDAwUmE2WDEyWmVDM0Y2R0tLUHlkZkFw?=
 =?utf-8?B?M3NjL2tIUS84MDArcjdIMEdGMEI1RmwxZ3g3VnptclhlMDEyYjFnT0xvUU8v?=
 =?utf-8?B?b3diVGN2bnJSL00wSDNDNGt4MTZaV2NpVXFWZ2x6K2dGREpYRmhDd1dJNWM4?=
 =?utf-8?B?ZmN6bG1PMHJYNmNVQUVqZkpJQ0ZWTkJHUm14WlBxcjB5ZU1lMzU0SW40WU9F?=
 =?utf-8?B?WmNUNlpmLzU1N2VVZG00MEhxOEROYUNpeUl3dXUvanhrMzZibGw5RVRQVXhm?=
 =?utf-8?B?eVB6bzFtK29BU3JMUnVndmFUUEVvMjA4NnZvUW05ZWUzQW9DbGVMdGhVYmJx?=
 =?utf-8?B?NXc3eks2c0c2OTZKYjlQT2JhbGhSbWdPTE9JeXpEcmJYRnhDU09Jb3pEQ0g1?=
 =?utf-8?B?UlZWOG1WRkM0ZlNYQWpEZWFMQVFHYXJlSW5Mek43WDI3MVE5R3pydFc1NEtT?=
 =?utf-8?B?RTRkdmFEQjhUR0VFcTVFbEJsK1dZZnV0c0FsRVpnNlZpNDZscjdaKzhleWFU?=
 =?utf-8?B?a1o2d0VUSkJXNkxPTlBGcnNuZ1VqQ05PYytaVDRFN3lTaXhFRDN0a1BDNTlM?=
 =?utf-8?B?UEhZRHd4bzFQTFZQWUo5OVdQRExwOXlSMTE0TWh2TFhvanpCYjRWd0dnWXNr?=
 =?utf-8?B?UC9lV0c5WGpjTEZGL3ZWL2pId3FOZTNZM2ZLZVo3WEdwUjlXQlVCc3pzdTJ4?=
 =?utf-8?B?N2U0UHFkdUhUeEtPait3WWIwM0ZaQTY2Qk54SE9ablFwa0lOK3FKVW1ueFRV?=
 =?utf-8?B?STNpSTZyK3NTM1FPNmJNQlU3ekZkYmd0bjNJaURxUzZMUnlHWUgzcWNQQisr?=
 =?utf-8?B?YlpLdTF0MkRtWFRkYUhwVWdScXJuSHBSempXT052blpXNi9pNjNub3M0UTg1?=
 =?utf-8?B?anNCeHkwTnVuWnNpbUFIWVEvRlE3bUNGRnQzUkUyOWZ4SzZDVFlZTkRkRGJC?=
 =?utf-8?B?cmNHRzg1TXhDZm5Ec0R6dHhNR2RBdmxhbkJjdmxVdDkzU3RyMlp4SThtT0t5?=
 =?utf-8?B?bHRIQ0VzK2VoV3NxU1Buc1hWRUo4NGlzU0czalVHeTdaYUk4QkZnL0x0US8y?=
 =?utf-8?B?WXJFQXVLbEorZmlrRnpOa1lCWExVbmtxRVo0MmRPelkxOEROMzZzampyNFRZ?=
 =?utf-8?B?UTFFeW5YSmNwM1ZpK21sVWdRMVFIek5za3RYbFlNTXZZZFVPV2duZElYamxC?=
 =?utf-8?B?VFlKK1VLenR0Zm5zRWZOYnpZVmZMOVpmbDNHVVg3OGlUeXhrYzdTNE96aHBo?=
 =?utf-8?B?WXZiSWJEWCtUUFdjNXNwWDBrYThvOGtSRHRRaGRBWHppampHcmFWbFhMcG9E?=
 =?utf-8?B?bDA3K1NPck56enZDOXlGSmJuVi9vWkhVU29kbG5YUXljMHNDdnFNWWh3TndJ?=
 =?utf-8?B?S2dLOUphZlVtekhQU1dndW5IQWpGeXA2QW5ObHhMeVY0Um5BM3FaSjhyZEJT?=
 =?utf-8?B?OWpncXB4L1JZSDYwNk5kZCs1ZUFNN2pBSVdiaTFwbkZGdlowZmwvbWlrV211?=
 =?utf-8?B?Q0h5Y09hYXZJemg2QzUwNGN2MG1OSDlSYzBWV3M2ZnU2bkZFZ0h6S1k4dUkw?=
 =?utf-8?B?YVNPTHJDN0lGL3kwVGl5ajdkZzNvVm5rTTV2MSsrNXdrUDk3am5MR2NNcjl4?=
 =?utf-8?B?Y1VkU3JaLzNVS3Q4SGE3THV2bmJ5NE5meUdNZGVUM1lpUkVkQ1p0VUJicytN?=
 =?utf-8?B?dmdLODB2SHdLdmdsOEtKa1dtNVpiNVZhU0xVeWhRc0o2c09BSEgxbzRqUDV4?=
 =?utf-8?B?TzczbzkyUmZOb0dmK3BGTzZVS29YQ29jaU5GQ2RBdWJRK2NNL3hLVEhmeUlx?=
 =?utf-8?B?aUxrOVlIK2E4cmRqU2p5Qzh2alVkbWdQd1lFUERCNGNuUEpSOWIwREV0VllH?=
 =?utf-8?B?b2VtL0hGWUdWeXRsSTlPbjAyUHh1emk0cUQrN1ZodjFPOGVOdjhZOXR3cGZZ?=
 =?utf-8?Q?JINM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1187.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda831e9-81c2-4888-19ef-08d9f5c80ae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 05:56:17.2408 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yCfhAdwntV5Q2BXZGowK/3R9zoHUx1/TTwGfLbNiHOG1gOajfpXsXA/YRIezoov4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Yin,
 Tianci \(Rico\)" <Tianci.Yin@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgQ2hyaXN0aWFuLA0KDQpXZSdkIGxpa2UgdG8g
ZW5hYmxlIGRpc3BsYXkgUy9HIG9ubHkgZm9yIEFQVXMgd2hpY2ggaGF2ZSBzbWFsbGVyIFZSQU0u
IElmID49IElQX1ZFUlNJT04oMywgMSwgMCkgaXMgdXNlZCwgbmV3IGRHUFVzIHdpbGwgYmUgaW5j
bHVkZWQuIFRoYXQncyBub3Qgb3VyIGludGVudGlvbi4NCg0KQlJzLA0KWWlmYW4NCg0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVp
Y2h0enVtZXJrZW5AZ21haWwuY29tPiANClNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDIyLCAyMDIy
IDI6MTUgQU0NClRvOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT47IFpoYW5n
LCBZaWZhbiA8WWlmYW4xLlpoYW5nQGFtZC5jb20+DQpDYzogTGksIFN1biBwZW5nIChMZW8pIDxT
dW5wZW5nLkxpQGFtZC5jb20+OyBZaW4sIFRpYW5jaSAoUmljbykgPFRpYW5jaS5ZaW5AYW1kLmNv
bT47IFdlbnRsYW5kLCBIYXJyeSA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT47IGFtZC1nZnggbGlz
dCA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBk
cm0vYW1kL2Rpc3BsYXk6IGFkZCBHVFQgZG9tYWluIHN1cHBvcnQgZm9yIGRjbiAzLjEuNQ0KDQoN
Cg0KQW0gMjEuMDIuMjIgdW0gMTU6Mjcgc2NocmllYiBBbGV4IERldWNoZXI6DQo+IE9uIE1vbiwg
RmViIDIxLCAyMDIyIGF0IDU6MTUgQU0gWWlmYW4gWmhhbmcgPHlpZmFuMS56aGFuZ0BhbWQuY29t
PiB3cm90ZToNCj4+IEZyb206ICJUaWFuY2kuWWluIiA8dGlhbmNpLnlpbkBhbWQuY29tPg0KPj4N
Cj4+IHRoaXMgcGF0Y2ggYWRkcyBHVFQgZG9tYWluIHN1cHBvcnQgZm9yIGRjbiAzLjEuNQ0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IFRpYW5jaS5ZaW4gPHRpYW5jaS55aW5AYW1kLmNvbT4NCj4+IFNp
Z25lZC1vZmYtYnk6IFlpZmFuIFpoYW5nIDx5aWZhbjEuemhhbmdAYW1kLmNvbT4NCj4+IC0tLQ0K
Pj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jIHwgMSArDQo+
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jIA0KPj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jDQo+PiBpbmRleCA5NzA5MzY4YjQ5
MTUuLjg4ZWUxMjI0NTQxYyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kaXNwbGF5LmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kaXNwbGF5LmMNCj4+IEBAIC01MjMsNiArNTIzLDcgQEAgdWludDMyX3QgYW1kZ3B1
X2Rpc3BsYXlfc3VwcG9ydGVkX2RvbWFpbnMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgY2FzZSBJUF9WRVJTSU9OKDMsIDAsIDEpOg0KPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgIGNhc2UgSVBfVkVSU0lPTigzLCAxLCAyKToNCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICBjYXNlIElQX1ZFUlNJT04oMywgMSwgMyk6DQo+PiArICAg
ICAgICAgICAgICAgICAgICAgICBjYXNlIElQX1ZFUlNJT04oMywgMSwgNSk6DQo+IFNob3VsZCBh
bHNvIGFkZCAzLjEuNiBhcyB3ZWxsPw0KDQpJJ20gcmVhbGx5IHdvbmRlcmluZyBpZiB0aGF0IGNo
ZWNrIHNob3VsZG4ndCBiZSBzb21ldGhpbmcgbGlrZSA+PSBJUF9WRVJTSU9OKDMsIDEsIDApIGlu
c3RlYWQuDQoNCkNocmlzdGlhbi4NCg0KPg0KPiBBbGV4DQo+DQo+DQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBkb21haW4gfD0gQU1ER1BVX0dFTV9ET01BSU5fR1RUOw0KPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgZGVmYXVsdDoNCj4+IC0tDQo+PiAyLjI1LjENCj4+DQo=
