Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6A3C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 08:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABA37610C9
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 08:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ABA37610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 369E889C1F;
	Wed, 13 Oct 2021 08:30:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DCAE89C1F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 08:30:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ah/w3DEzH8nG0iPsvceGxS0uB0VZmXZ+DXQwsZlh/C2TLqemfqhG9Fv+TiwidUaF0HevdXVSgETcQgeAIToDNBDl8YWFpBKcsqofz3TnrCaDlC7gDPnwVljb0mZD+a/IzKb1QfdOmpS/gw2zr15INwZob3v3zJGQSbc+9ncNNOW/NOvDKOWLdOlKwsz+jzPCLw9bV7XexwUjGoGCnSXHqrs9y3e5//O7LkYnYkoYsWox/htFGq0YfAFRzd/PrEJYQrgpI12kFpml8byOk0M1+XXnzBXDgvV4dpVs8aLDLDPRawd0GEQGRpTShNkDQqoybel/4Ibb/48TnhZeSM+2Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/0kkJVOpGGeYqLN6KWz1PaJnFcfk+SYxaL88JXpoMg=;
 b=aaO2u6sqPJdimG2RiD4gQ+rW0x6i1HmXz7T6YdyCsuNHsepaitmehornTmWxHsVJWZtf3fOenL5av5N8YE1Oc0u20kzt1lbuFBF51xBMCz46Z0e3W1RTctnrf+KvAxg+PjZGOYJQeqkHfENF7yfDyUdROE4DHULZ+VO1jryIVBsz2DOtf3/kKjYv37QrYKzETU98sYrGIUZz9YzkDIQgwYdU/U5ANKsIX/ghQh/B4oeRvCeBgzjg4/xUVelimKhrtYmSQxXGI96ieFeb6ZVG6HstzXbG3aKdtNYoFinqu+HXatD4nLeSBKHcJRRzlmxP48CXe/Z4cXoEMmmEENxgYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/0kkJVOpGGeYqLN6KWz1PaJnFcfk+SYxaL88JXpoMg=;
 b=GQoMSM/lNirdiLv5E9+02xAsbnBGwRF8nRke9Zqp3foCBa0xP1e4Bq6R5spBEwo6p3mBALE297F3Cd56MQgBNqA8rg4u9Z/Qub8tS8SgNWzl/SMgfNJjHkoABlokPuhuV3OgRDpxEpQ5O3NnFeXWhWUPswSJXWzXib7cASr8v7w=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM5PR12MB1243.namprd12.prod.outlook.com (2603:10b6:3:74::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.20; Wed, 13 Oct 2021 08:30:15 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 08:30:15 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Fix a __user pointer dereference in
 create_signal_event
Thread-Topic: [PATCH] drm/amdkfd: Fix a __user pointer dereference in
 create_signal_event
Thread-Index: AQHXwASs7AJubac3xECmiNeO3/ccTKvQkn+AgAAEuyA=
Date: Wed, 13 Oct 2021 08:30:15 +0000
Message-ID: <DM6PR12MB4250BC19A5517C93BC4F956AFBB79@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20211013073334.987240-1-lang.yu@amd.com>
 <8b450b74-0e16-5527-f50c-1490d20d62e4@amd.com>
In-Reply-To: <8b450b74-0e16-5527-f50c-1490d20d62e4@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-13T08:30:11Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=0d662c72-0a2d-4869-b283-89691769219b;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86e207b3-fd62-4879-0421-08d98e23aec3
x-ms-traffictypediagnostic: DM5PR12MB1243:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1243CBAFCCB2485DEFD76B80FBB79@DM5PR12MB1243.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pm6LIzCDg3ErNu1S1ArNz8SHP61kZ3GFqi+jvEWeQthXBlmcIQC4Ow2WTEGH+L4KP4rltVa3fQTC5aFKAWUpXIkF/Rin2cpOn/5zPB8jBvVlWM548PTnapVBSn2+yCv+ySBRTwseNuGy4L1X1lSNBp3EONuO8t+E4ykgooyT1iItXiGvgnyzzexEzwt2riI0+uL/Vgak7d3i2lVb01Wiu2fDuQi6XokN4nY4vXdGJ6jNqu/HQZdz9Zc4yeiMAaVa3MEOGeI5hsqpqCmxUpCeXSssnqIKR51WmTukhMdHIKNHZ7uotS6gIZ7ArCjdPbefhtEQdzFKXW9cz9s4SmRTYUU6xeGRgXSN+gdUgxJU3pfcnhplGAa0YADYC5DLG34FTGKn7mPCIjo47gO3jDxVgx4SIIei/zBkZdlElTHgETa9NSX6Q4Hs+/v8DmioMO4TQcm9EmIu8SEvmGov9rH/wZ3LwORRFuFhqtfqxSteBOXs+G6lbuiKRjbN+VvOsvqedEEAkYwo1oLe1UphVhXEoImnzMp0rGcM20EGbt3578p6kIXd6GGJB/l5Pp+Epnprcei2vW8RS+NZJ1m2UKCvjfgUacEvkuXubYAHPYuxKjVlYNRQNoHX6NJRV/4HgeZaPYAu9/6HAcqZP7YwCZ3nD0TxHJGWISYa60kxczibfVJbhch2lQvodgm3xiFB7IVHbotQJZNlK8o4Uyz8S1Cy9zWnH5M5J2jsi1Y5ALNKFB9Uqa8oxMULylnNt8xGXIrK4q9XrCSpaMFneV/ZNV1dq+ed/r61JSWcdtia7xHUwA4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(6636002)(83380400001)(33656002)(110136005)(9686003)(76116006)(6506007)(4326008)(8676002)(26005)(966005)(54906003)(38100700002)(122000001)(38070700005)(55016002)(66476007)(71200400001)(8936002)(66946007)(5660300002)(86362001)(52536014)(66446008)(66556008)(7696005)(316002)(64756008)(508600001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTRtSFJEdHVNYWxVM2Nab20zYzhSeU1aMk1OZ29EVXIyN2VDV0xDSExCNVB0?=
 =?utf-8?B?RXJKYjd5ejZKM01wNjFrdnRGSmVhcmY5UFErQnpEdTVWczA2U0tvTTBqRkUr?=
 =?utf-8?B?WU51MXdDSFZpTHZEMGYrb2hKdnBVb2VTTSs0SHk1bnhlS0Fnam10eVVvVFNu?=
 =?utf-8?B?SFlvQTRvdE9YbDYzcFlxQldtNmlNa3RrR3A0ODZFYVdCQlZscGUrU1lHMXBT?=
 =?utf-8?B?R1RHL05aZXpwR3dWNmpZV2txS3M0OEJLNUxUdjZLSlZIYlpaMjhSVHRjaEdx?=
 =?utf-8?B?SE1BNm9ldXpDUkExSkNhTnN4djFUNXpYMnhQSzJvUlQ2bXIrNG84NWVFdk41?=
 =?utf-8?B?R0d2YklMZXhUYm9yRWNpWThTb3JLNDdrakswc2ZLL1lWSXYrZGI3VEtRZ0xq?=
 =?utf-8?B?cWhxVlZVcVFNdHFCekpaeGNVbFIvaTR4bTluOXVXaTd0NXB6amx6L01LSnlz?=
 =?utf-8?B?STZuckU2Tks4eFZhTnMybVJUOGg3cGMwV2VLNWRRd0VMa3Y3NEFSNUpMSk5H?=
 =?utf-8?B?T1FScDBmSE9NTWllN1d5QVlCallGdkZmSEtHVTkzQ0ZhNzRaSDRpalNST2Jo?=
 =?utf-8?B?NUV5elFVS1pBNGx6a045M1NwWEVqRmRpbFJ6SVlqSDRCQ292SW1tbXFFcmN5?=
 =?utf-8?B?QXZVN2h2bHhEeWJKOEdRR0duejRUUTFpbG9zSVBHeURPY0hoUXhUdXlkYjhM?=
 =?utf-8?B?Q1VqZ1VTeTAveHJjYXR6cDR5OG1FL3hUTThuRDlDOE9hNHU1NnZyaXR0UTEr?=
 =?utf-8?B?MWFVSlZpMzF4Wno4anFFT1hRb000dEYreXF2enpZVFM2azQwVy9ubXB1WjY1?=
 =?utf-8?B?STFNWEhIdEJHeEJKM2E5QUkyQytiOWNIbjFvTXl1d1gwalhRNGVjeHlyOTJi?=
 =?utf-8?B?SkVhdFlua3RmdnpSRUZSV3FzT0FZVktUaitOWmJNMUVzejVsaFVtb3FFMWcy?=
 =?utf-8?B?UVhnU1dBUW5zdWNVMWU3TmVnT1dOVXM4aHMrUFBuMzAzT3VvVmxBMWRUK3Qv?=
 =?utf-8?B?NVBuNGVVRXRXWDVhZlZWT0xPWDNGaFYySldIMjBOL1BzeGluclZQOHBib3FO?=
 =?utf-8?B?c29sRjRESXRKSnVGM01LRnFaQ2NmOEdVRllkWG1yWEhSRlV1ZnlFNWJMOFpr?=
 =?utf-8?B?cVF0QnJsa3Fob1I2TWpiYmYvUmZWTGVZc0tYemlvbGVSQWZUOE51VElybHFU?=
 =?utf-8?B?L2lja3hnVkRpZDduR0xLK1VxVDRnWW51N0hzcWh1b2tPdklxUlpKK2plNnhQ?=
 =?utf-8?B?aW1hVU9MbzlGVkJSeU93Q2xRQ0ZwV1FmdVd2WkErQUNYSEJ6N0JiWkcwS1pH?=
 =?utf-8?B?dUpJczJzb2IvcnRkVlFSbzBFdGxQaVlJSENEcWdMSDFjWHdjb21MTHlnVWVN?=
 =?utf-8?B?T00zclRzQjd2Tkltenl6YU94bnE0cy9jUmJEMk5xbHkvWUhxRHlTK1U0U1lr?=
 =?utf-8?B?anNsTkRLZXNybk1iRGk3dG9HeXN1NHZSV2hHaTFPd0RiUnVaRks4UVBiSlhi?=
 =?utf-8?B?Zlk1bWpMYStWRml5MlM2TGlUTjRLNncwNWN5ekEzZTNBQUpud2pKQnN1eW9z?=
 =?utf-8?B?UCtFZzkvd2QzUUdxK3NhQUk5TFhlZ3ROYUNGUVIwalV3ckdvdTBvb09Ga29Y?=
 =?utf-8?B?WSswbHJhc0RmQUo1TFlYWFowRnJYTWxPZ1luaGxiNjlJSG9SZXBKNk9IS3dG?=
 =?utf-8?B?MlNkZ3RJL3VEWCtxdGZzS1VmVDIzaW5EZ0tPenJwdXVCOFdxamZadVM4ZHJG?=
 =?utf-8?Q?1+cPVqhKYi/c0tB0kC1lfayGBM9a8xdkAc1ZEcC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e207b3-fd62-4879-0421-08d98e23aec3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 08:30:15.4202 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GLvTTqPSS/Ipgpe3QwonrgfEo+sNPoTspRoE9wwyUhcxZhFuHtGjoFDPRH1mEnsnGcNwmE+O9AxzZWaJixpK8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1243
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+U2VudDogV2VkbmVz
ZGF5LCBPY3RvYmVyIDEzLCAyMDIxIDQ6MDcgUE0NCj5UbzogWXUsIExhbmcgPExhbmcuWXVAYW1k
LmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBLdWVobGluZywNCj5GZWxpeCA8
RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj5DYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5k
ZXIuRGV1Y2hlckBhbWQuY29tPjsgSHVhbmcsIFJheQ0KPjxSYXkuSHVhbmdAYW1kLmNvbT4NCj5T
dWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1ka2ZkOiBGaXggYSBfX3VzZXIgcG9pbnRlciBkZXJl
ZmVyZW5jZSBpbg0KPmNyZWF0ZV9zaWduYWxfZXZlbnQNCj4NCj4NCj4NCj5PbiAxMC8xMy8yMDIx
IDE6MDMgUE0sIExhbmcgWXUgd3JvdGU6DQo+PiBXZSBzaG91bGQgbm90IGRlcmVmZXJlbmNlIF9f
dXNlciBwb2ludGVycyBkaXJlY3RseS4NCj4+IGh0dHBzOi8veWFyY2hpdmUubmV0L2NvbXAvbGlu
dXgvdXNlcl9wb2ludGVycy5odG1sDQo+Pg0KPj4gRml4ZXM6IDQ4MmYwNzc3NWNmNQ0KPj4gKCJk
cm0vYW1ka2ZkOiBTaW1wbGlmeSBldmVudCBJRCBhbmQgc2lnbmFsIHNsb3QgbWFuYWdlbWVudCIp
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTGFuZyBZdSA8bGFuZy55dUBhbWQuY29tPg0KPj4gLS0t
DQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9ldmVudHMuYyB8IDIgKy0NCj4+
ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9ldmVudHMuYw0KPj4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZXZlbnRzLmMNCj4+IGluZGV4IDNlZWE0
ZWRlZTM1NS4uNzRkM2JkY2ZlMzQxIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2V2ZW50cy5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfZXZlbnRzLmMNCj4+IEBAIC0yMDEsNyArMjAxLDcgQEAgc3RhdGljIGludCBjcmVhdGVf
c2lnbmFsX2V2ZW50KHN0cnVjdCBmaWxlDQo+PiAqZGV2a2ZkLA0KPj4NCj4+ICAgCXAtPnNpZ25h
bF9ldmVudF9jb3VudCsrOw0KPj4NCj4+IC0JZXYtPnVzZXJfc2lnbmFsX2FkZHJlc3MgPSAmcC0+
c2lnbmFsX3BhZ2UtPnVzZXJfYWRkcmVzc1tldi0NCj4+ZXZlbnRfaWRdOw0KPg0KPlRoaXMgaXMg
aW50ZXJlc3RpbmcuIEkgdGhvdWdodCB0aGlzIHdvdWxkbid0IGRlcmVmZXJlbmNlLg0KPg0KPlNl
ZSBoZXJlIC0NCj4NCj5odHRwczovL2VuLmNwcHJlZmVyZW5jZS5jb20vdy9jL2xhbmd1YWdlL29w
ZXJhdG9yX21lbWJlcl9hY2Nlc3MNCj4NCj4iSWYgdGhlIG9wZXJhbmQgaXMgYW4gYXJyYXkgaW5k
ZXggZXhwcmVzc2lvbiwgbm8gYWN0aW9uIGlzIHRha2VuIG90aGVyIHRoYW4gdGhlDQo+YXJyYXkt
dG8tcG9pbnRlciBjb252ZXJzaW9uIGFuZCB0aGUgYWRkaXRpb24sIHNvICZhW05dIGlzIHZhbGlk
IGZvciBhbiBhcnJheSBvZiBzaXplDQo+TiAob2J0YWluaW5nIGEgcG9pbnRlciBvbmUgcGFzdCB0
aGUgZW5kIGlzIG9rYXksIGRlcmVmZXJlbmNpbmcgaXQgaXMgbm90LCBidXQNCj5kZXJlZmVyZW5j
ZSBjYW5jZWxzIG91dCBpbiB0aGlzIGV4cHJlc3Npb24pIg0KDQpUaGFua3MgZm9yIHlvdXIgY2xh
cmlmaWNhdGlvbiBhYm91dCB0aGlzLiBJIGdvdCBpdC4NCg0KUmVnYXJkcywNCkxhbmcNCg0KPlRo
YW5rcywNCj5MaWpvDQo+DQo+DQo+PiArCWV2LT51c2VyX3NpZ25hbF9hZGRyZXNzID0gcC0+c2ln
bmFsX3BhZ2UtPnVzZXJfYWRkcmVzcyArDQo+PiArZXYtPmV2ZW50X2lkOw0KPj4gICAJcHJfZGVi
dWcoIlNpZ25hbCBldmVudCBudW1iZXIgJXp1IGNyZWF0ZWQgd2l0aCBpZCAlZCwgYWRkcmVzcyAl
cFxuIiwNCj4+ICAgCQkJcC0+c2lnbmFsX2V2ZW50X2NvdW50LCBldi0+ZXZlbnRfaWQsDQo+PiAg
IAkJCWV2LT51c2VyX3NpZ25hbF9hZGRyZXNzKTsNCj4+DQo=
