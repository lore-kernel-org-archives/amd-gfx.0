Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C47C678D4
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 15:26:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A012710E107;
	Thu,  2 Mar 2023 15:26:29 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D08B10E107
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 15:26:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3Jqbl2kblvYSDR7SazhYk7a5lHDmRX7fTZji+EGGAzyGr5v0LBTrhBnz7G3xMOMHpw9biJzq5i9msVtK/lKPGu616I7+8bKQ/K/lG5wghAvCiw667dkACPFgP02obknhXpBzqqbtOs4i2j3wflV2xlnTkdlaZgG6ZTTNB6AXVtv3u/HWNI6pcUJZyqKv23/tGEz8KriFprVjlp14wsMI1mcpvCE26H9lEsiZ/EhgFJZgEvxABBUBNu+YV5+vsIlbyZM7ckZI4MeUjG096SbyB9/N9HDQDbxQyO6Tfc/BsHxuEiSlLPfZcIcK7TzQsKiV2rNj6OfT+xbVeg1X7cfXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8urtixxXtf8VVQyrxQAJs+4tutXzUvUYcIg5pKvwKQ=;
 b=PX3J0JCAGCxAWuVcnZJQrnDCugi5VS2rrF5dSafjHBprSTu7ZR14eQv7ytuH+iPYnBPs7foXwtBxJD5HjW7Hq1tZfP7pyRGTCNltVDLTDLYqnUlFnnq0mMMuHXBMwySysSwiEBv+83hUlG9bbNmnN7jlhmKq3W7FdLpmhzhAZ/lXxFb8TTFZDf1n5VqehBsAeZwiLXB53NJ7NZltXKuzsPcEKZhGnBeG9VVKh5YwB912fAouBOliBVHnCQj+vv82qZ6H7WBy1lMZ5ml7bz9fXBgeOs3KfiU6AUkC0lqrW6HLqmPsuEi1SCortO6hZ+7mipkv/Bzi43yjuBI+HoBAxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8urtixxXtf8VVQyrxQAJs+4tutXzUvUYcIg5pKvwKQ=;
 b=Y2P568+7ZgumNZlOaeE1o8NT2jDnPDRroJPP3mCIfQ86+g1jQiQDd3eh2FMvskUw8oHyQrKcwo40ZQ3Ey7ckB/3UscIxwsCtuL3hn+7tke233tkLbxylYVMlqcaNtFjNj+NH+WZuyAIx+NrF0wD+AuTHveAI2TCl7/ZPhBfnW2o=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 15:26:26 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::4e0d:adcd:8547:2ff6]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::4e0d:adcd:8547:2ff6%9]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 15:26:26 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: disable cstate properly for driver reloading
 scenario
Thread-Topic: [PATCH] drm/amdgpu: disable cstate properly for driver reloading
 scenario
Thread-Index: AQHZTNSNPQx9NP+0VU64Q6uaYJ4O667nKA6AgAAM3gCAAAH2gIAAAsgAgABhpnA=
Date: Thu, 2 Mar 2023 15:26:25 +0000
Message-ID: <BL1PR12MB51446EF4033480FC8BB6F82BF7B29@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230302065835.3905147-1-evan.quan@amd.com>
 <47d45518-bad2-0855-170c-31022ada6dae@amd.com>
 <DM6PR12MB26199B972F0D02381059933EE4B29@DM6PR12MB2619.namprd12.prod.outlook.com>
 <f72fe6fd-8d41-b99d-fd0c-d893e2d5e158@amd.com>
 <DM6PR12MB261981BCAAB3ECAC82031921E4B29@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB261981BCAAB3ECAC82031921E4B29@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-02T15:26:18Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a4c57553-c362-4157-a92b-c340524cc554;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-02T15:26:18Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 6487bf52-67b3-4d01-b8be-88cd06b2ffbd
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CY8PR12MB7195:EE_
x-ms-office365-filtering-correlation-id: c157fb46-da3f-4a93-49d7-08db1b327cd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cE8SWbPyBSrYS6iA2DC43Mc8z92IjX47a0ccJGBIMQTKucLSQK98agLE1WgdKKkzSZMOGOC6hJdH0goWObiz+nFp/WAfiC92qsPvrBhGqnIrwqh7qQQc5WNUcbnuPNacHR4kbR8teSKhTBvTIFOFD+m54cV6S6ETfGgvVe42VJKg1T9Mc4kkc/gI7HgBpeh5bTwwK7nw2IfjY+g2tVWa1wLht5cHObcOB72r5xd2Dsa8dPyG6XR4CIdeZs6dxQrz9aviJkbJtOS6GEBA+uzPW7nkXeuvaYTANUf1M31QauLee9qMLHDBvQ8sOin0GHgrO+m/R22tZMEdVyJCFvdE9AfYZyp7MiJgFRerWwIn9Y77gicVpCG17shrUsQ9bCNiVaeAE2B5RXjrtDOGgkTFdSxPCftWIGEeS13xKpY4fIlOr4ZV3DJsU2eSRFYRVEJhT/rh2pVn8NS1iGfzdN1R1EaPDoz2RbZSO92O7ft4wK7qb02mLhcuCmUkY99K70zp7hKkkURQ5Z/CPWzhao34NjE0Ypo9AePoGvPmX8Z/R1frMeLz0x17c5vniaYJWT0IFYefQiGt1OQF0VQzDCOoM9hpLIgigve9zNB7elvQBW8sa1R9AddzF0Kc79xWaBLmM4bEIuEhjmi4lZlmTlBFl2NAG7ABVQn92nGGX7L/vM1Cf8PCYCSzAl/pLqX6gHNzLiZTXYZcrltZ4wRhXIaSHA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199018)(86362001)(33656002)(52536014)(9686003)(66446008)(186003)(76116006)(53546011)(55016003)(8676002)(64756008)(66556008)(66476007)(66946007)(8936002)(41300700001)(110136005)(122000001)(478600001)(7696005)(71200400001)(6506007)(5660300002)(26005)(316002)(38100700002)(38070700005)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SE4wUnhjcUNCNDlPOVA3Z1QreitkZmhyTDhUMVVPNHVlTjFGdUFISWYzS2ha?=
 =?utf-8?B?c2FzMExYUFRkY29ad2FhY2ZtdkRObGZIRFh5M1NITmJtajBvNGdUZHlRT25n?=
 =?utf-8?B?cXBhUmtHQ0xLckpXQWZJUU1iaHNqQktFZmhLYmxhUEROUkl1V3RhQjVLOE1U?=
 =?utf-8?B?QkkrMU0vZDlhajRIbkFmNTRVVmYyWUZKOTZlbFpzcitaT283Z1FJM3RnRDRw?=
 =?utf-8?B?TDFzb1BQY3diV2g4ZXYxTGxtRUlRblFNN1YwWHNlV1luaUI0VUZZalhKeVJP?=
 =?utf-8?B?RjhGQTFGa2xTMk5OR1JnWmdtRUh4ZzJ6dDRLSHRDVHA4VDFjdm9kcVZRQU1s?=
 =?utf-8?B?cFlxWWpUY0dvUDRmRllHeWpkSGZOTklzV01TUHhMT0JnbjU3T21BS1lpRjJ5?=
 =?utf-8?B?dHJ1dEdkTlVrL1M2ZHJFdG5NWm1TRHNDdmdiS1Y1ZmhxaGRHMnBMSWY4R1ph?=
 =?utf-8?B?bVFSc29XYWEzOEgvcWlGaFk3bXhoUGQzaTNEMU5ORVNUQVl1QU5GT1JhTE1m?=
 =?utf-8?B?ZWNFNE5nSXEzTzEwWngrNVpETHNwRkZsZmk1ZmFKLzNDOFFRUThkclBXZUN5?=
 =?utf-8?B?ZitoUjB0REVSaFU3cS9UcU8zS1JKSlFVZ0Fqd1Q1d1JCUENjcjF3ZDFSZ2xB?=
 =?utf-8?B?Y1pZRzNUSExLbVV0V0NrNzhoQm9Ub2FBVDNORkhvelBad1p1Qlp1L25EWERJ?=
 =?utf-8?B?Wml2cThSYjFqQkpDK0Z2TTlmdW9ObFZLS1ptdmhzY09aeERPcnUyTlBRZnNy?=
 =?utf-8?B?M09PQ3BOYTk2WmtFdXY0ODdJekVqbXRJN3RaeFdrbjZLWTdoUEYzZnh5d2sy?=
 =?utf-8?B?bnFjLytBbGpIdDZqYTlPd05RS1hMZHpLN0l6a0t2UVZpQlYxUVJ2ZU4xY2l3?=
 =?utf-8?B?Z3BrdmFqaXZ4UmdMVGlLVGJuVUNqV1R5b281Zk92RVFocytJRXlrVzVJRTBM?=
 =?utf-8?B?a0FhMDAvOGhzajAvcDBnTnFyQjV4ZzVObjl4UDN0TU90cmpQMnB0L0hhSGtV?=
 =?utf-8?B?cUM0WHFhdlU4WGZoZ2ZwL3RkQ2VzT2hEZEZzNktKM3YxK3BJN010N3JnTnA1?=
 =?utf-8?B?QVNJYVBNVnMxOCtROXVmMTQ3TTZCWmU0NG1wa2hSemVYd2xFMjJQaTFIaVlz?=
 =?utf-8?B?RjZ0dmN6RFh5QzdDVGZwa1M5VkkxeUwzMWdEY1VZaElFODlpaVB3RWNGYkN4?=
 =?utf-8?B?dDY1d2tPU0l5bmg5MXNkUWJIRzBCR2RJT2NpcTVOODJMQVp1VEZPM3hyTlB1?=
 =?utf-8?B?QW9WakZrUWg0ejJHN0tTMm5rdkZPNE42dk4wZWtGNkg0MThSdXg2Y0k4aTNZ?=
 =?utf-8?B?STd5SHAvbm5NeUlqTDl4eHlXWWg1RTFaSGdtakJGQ1dodEJPU3ZhWnZXUkVx?=
 =?utf-8?B?bFVWL2tsUXRPZEgyZnhRUTNTV2RpQTNZdWhwajZWa1A0aHlGaitSR21nMEwv?=
 =?utf-8?B?UUtPQ3M1NnYvYzh6eC96SlRGcmNpWUNsZHBqWkhtUnlBLzlTeGxDYmY5WUwv?=
 =?utf-8?B?UnZBMVdWUTczODJFT0IzTDYyeUxnWUt2Y3A0cVFmM3RtM3F1amsrbDdrb29W?=
 =?utf-8?B?TUkrOFpUSzYrVUxSWnNMMGJCeWt4YjBzQnBzYk96TFNTM294a1habUZMQndo?=
 =?utf-8?B?VDcvRWhzbXJWVFlkVWowNWFHOU5zQ29zV2ZOZXpiSGZSMGtCUVE1YTd1ckYw?=
 =?utf-8?B?TzlNeTBHblVyNnpXZ3BxY0JPQmM5LzRhVGNveS95U0ovcGlvNTA1WUJZYXpu?=
 =?utf-8?B?VDhKaHI4YmJqTzk0NmZxOU9aU2NXWWpaZmY0dVN1U1gxWlIwTVhLbGk2TWNC?=
 =?utf-8?B?dk1kd0MwNU9nN3ZXekhCQVJVdi92TXNEb1ljeHBvRG9tV2Zveis2MnViR3k4?=
 =?utf-8?B?SmEyaG90SWNFcTlXbjM1RVlpU1RmLzJ1WW0vZGU0RE1TVFVsRGZDVGRVOUk5?=
 =?utf-8?B?U0RQdkh3MmJCWlJaTHk4b2ovWEpoelRlc0VadDFNTnNCdnlNWEpCUDBsVHNM?=
 =?utf-8?B?UVFSSmowZnhEdjRNdkxzYi9sYzRlTDhZUkdYQzIzRGNLQk1EZ1VqbkNLcjk4?=
 =?utf-8?B?azhld0ZMak8yVVZoY0dsWjNJYmJkOGdkMXZTdkM4a0p4ZDd4U3VWTW9WcHBk?=
 =?utf-8?Q?TebA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c157fb46-da3f-4a93-49d7-08db1b327cd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 15:26:25.9215 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EqaV2I7frISXa3jcI+ARoKgixWYkR45nDAv/H6XkGzk44ZVLWV16LATTT0HD6GGl8xWEBq37F0vCvo+KEMuinQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7195
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+DQo+IFNlbnQ6
IFRodXJzZGF5LCBNYXJjaCAyLCAyMDIzIDQ6MzEgQU0NCj4gVG86IExhemFyLCBMaWpvIDxMaWpv
LkxhemFyQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsNCj4gRGV1Y2hl
ciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBSRTog
W1BBVENIXSBkcm0vYW1kZ3B1OiBkaXNhYmxlIGNzdGF0ZSBwcm9wZXJseSBmb3IgZHJpdmVyDQo+
IHJlbG9hZGluZyBzY2VuYXJpbw0KPiANCj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVy
YWxdDQo+IA0KPiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9t
OiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiA+IFNlbnQ6IFRodXJzZGF5LCBN
YXJjaCAyLCAyMDIzIDU6MjEgUE0NCj4gPiBUbzogUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5j
b20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+IENjOiBEZXVjaGVyLCBBbGV4
YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRD
SF0gZHJtL2FtZGdwdTogZGlzYWJsZSBjc3RhdGUgcHJvcGVybHkgZm9yIGRyaXZlcg0KPiA+IHJl
bG9hZGluZyBzY2VuYXJpbw0KPiA+DQo+ID4NCj4gPg0KPiA+IE9uIDMvMi8yMDIzIDI6NDMgUE0s
IFF1YW4sIEV2YW4gd3JvdGU6DQo+ID4gPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gR2VuZXJh
bF0NCj4gPiA+DQo+ID4gPg0KPiA+ID4NCj4gPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+ID4+IEZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+ID4gPj4g
U2VudDogVGh1cnNkYXksIE1hcmNoIDIsIDIwMjMgNDoyOCBQTQ0KPiA+ID4+IFRvOiBRdWFuLCBF
dmFuIDxFdmFuLlF1YW5AYW1kLmNvbT47IGFtZC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zw0KPiA+ID4+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+DQo+ID4gPj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogZGlzYWJsZSBjc3Rh
dGUgcHJvcGVybHkgZm9yIGRyaXZlcg0KPiA+ID4+IHJlbG9hZGluZyBzY2VuYXJpbw0KPiA+ID4+
DQo+ID4gPj4NCj4gPiA+Pg0KPiA+ID4+IE9uIDMvMi8yMDIzIDEyOjI4IFBNLCBFdmFuIFF1YW4g
d3JvdGU6DQo+ID4gPj4+IEdwdSByZXNldCBtaWdodCBiZSBuZWVkZWQgZHVyaW5nIGRyaXZlciBy
ZWxvYWRpbmcuIFRvIGd1YXJkDQo+ID4gPj4+IHRoYXQoZ3B1DQo+ID4gPj4+IHJlc2V0KSB3b3Jr
LCBkZiBjc3RhdGUgbmVlZHMgdG8gYmUgZGlzYWJsZWQgcHJvcGVybHkuDQo+ID4gPj4+DQo+ID4g
Pj4+IFNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+DQo+ID4gPj4+
IENoYW5nZS1JZDogSTVjMDc0YzI2NWMwYjA4YTY3YjY5MzRhZTFhZDlhYTNmZWQyNDU0NjENCj4g
PiA+Pj4gLS0tDQo+ID4gPj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYyB8IDkgKysrKysrKysrDQo+ID4gPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2Vy
dGlvbnMoKykNCj4gPiA+Pj4NCj4gPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiA+ID4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiA+ID4+PiBpbmRleCA1MWJiZWFhMWYzMTEuLjNjODU0
NDYxZWYzMiAxMDA2NDQNCj4gPiA+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jDQo+ID4gPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYw0KPiA+ID4+PiBAQCAtMjgxNiw2ICsyODE2LDE1IEBAIHN0YXRpYyBp
bnQNCj4gPiA+Pj4gYW1kZ3B1X2RldmljZV9pcF9maW5pX2Vhcmx5KHN0cnVjdA0KPiA+ID4+IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4gPj4+ICAgIAlhbWRncHVfZGV2aWNlX3NldF9wZ19zdGF0
ZShhZGV2LA0KPiBBTURfUEdfU1RBVEVfVU5HQVRFKTsNCj4gPiA+Pj4gICAgCWFtZGdwdV9kZXZp
Y2Vfc2V0X2NnX3N0YXRlKGFkZXYsDQo+IEFNRF9DR19TVEFURV9VTkdBVEUpOw0KPiA+ID4+Pg0K
PiA+ID4+PiArCS8qDQo+ID4gPj4+ICsJICogR2V0IGRmIGNzdGF0ZSBkaXNhYmxlZCBwcm9wZXJs
eSBvbiBkcml2ZXIgdW5sb2FkaW5nLg0KPiA+ID4+PiArCSAqIFNpbmNlIG9uIHRoZSBzdWNjZWVk
aW5nIGRyaXZlciByZWxvYWRpbmcsIGdwdSByZXNldCBtaWdodA0KPiA+ID4+PiArCSAqIGJlIHJl
cXVpcmVkLiBBbmQgY3N0YXRlIGRpc2FibGVkIGlzIGEgcHJlcmVxdWlzaXRlIGZvcg0KPiA+ID4+
PiArCSAqIHRoYXQoZ3B1IHJlc2V0KS4NCj4gPiA+Pj4gKwkgKi8NCj4gPiA+Pj4gKwlpZiAoYW1k
Z3B1X2RwbV9zZXRfZGZfY3N0YXRlKGFkZXYsIERGX0NTVEFURV9ESVNBTExPVykpDQo+ID4gPj4+
ICsJCWRldl93YXJuKGFkZXYtPmRldiwgIkZhaWxlZCB0byBkaXNhbGxvdyBkZiBjc3RhdGUiKTsN
Cj4gPiA+Pj4gKw0KPiA+ID4+DQo+ID4gPj4gVGhpcyBsb29rcyBtb3JlIGxpa2UgYSBmaXJtd2Fy
ZSBidWcuIERyaXZlciBzZW5kcyB0aGUgVW5sb2FkDQo+ID4gPj4gbWVzc2FnZSB0bw0KPiA+IEZX
Lg0KPiA+ID4+IEluIHRoYXQgY2FzZSBGVyBzaG91bGQgZGlzYWJsZSBhbGwgZmVhdHVyZXMgaW5j
bHVkaW5nIEMtc3RhdGUuDQo+ID4gPiBEcml2ZXIgZG9lcyBub3Qgc2VuZCB0aGUgVW5sb2FkIG1l
c3NhZ2UuIFdlIHdhbnQgUE1GTSBhbGl2ZSBhbmQNCj4gPiA+IHJlYWR5DQo+ID4gZm9yIGhhbmRs
aW5nIHBvc3NpYmxlIGdwdSByZXNldCBvbiByZWxvYWRpbmcuDQo+ID4gPg0KPiA+DQo+ID4gQWN0
dWFsbHksIHNvYzIxX25lZWRfcmVzZXRfb25faW5pdCBjb2RlIGl0c2VsZiBoYXMgYSBidWcuIFBT
UCB3b24ndA0KPiA+IGdldCB1bmxvYWRlZCBieSBkZWZhdWx0IG9uIHJpbmcgZGVzdHJ1Y3Rpb24u
IEV2ZW4gaWYgUFNQIHN0b3BzLCBpdA0KPiA+IGNvdWxkIGp1c3Qga2VlcCB0aGUgaGVhcnRiZWF0
IHZhbHVlIGFzIG5vbi16ZXJvIChqdXN0IHRoYXQgaXQgd29uJ3QNCj4gaW5jcmVtZW50KS4NCj4g
Pg0KPiA+IFByb2JhYmx5LCB0aGF0IG5lZWRzIHRvIGJlIGZpeGVkIGZpcnN0IHJhdGhlciB0aGFu
IGtlZXBpbmcgUE1GVyBhbGl2ZQ0KPiA+IGZvciBhIHJlc2V0Lg0KPiBBcyBJIHJlbWVtYmVyZWQs
IHRoZSBjaGFuZ2UoYXNpYyByZXNldCBkdXJpbmcgcmVsb2FkaW5nKSBzZWVtZWQNCj4gaW50cm9k
dWNlZCB0byBhZGRyZXNzIHNvbWUgc3Jpb3YgaXNzdWVzLg0KPiBARGV1Y2hlciwgQWxleGFuZGVy
IG1pZ2h0IHNoYXJlIG1vcmUgYmFja2dyb3VuZHMgYWJvdXQgdGhpcy4NCj4gVG8gYmUgaG9uZXN0
LCBJJ20gbm90IGEgZmFuIG9mIHRoaXMocGVyZm9ybSBhc2ljIHJlc2V0IGR1cmluZyByZWxvYWRp
bmcpLg0KDQpJJ20gb3BlbiB0byBkb2luZyBpdCBhIGJldHRlciB3YXkuICBXZSBkaWQgaXQgZm9y
IHR3byByZWFzb25zOg0KMS4gb2Z0ZW4gdGltZXMgdGhlIGRldmljZSB3YXMgbGVmdCBpbiBhIHdl
aXJkIHN0YXRlIGFmdGVyIHRoZSBkcml2ZXIgdW5sb2FkL1ZNIGtpbGxlZC4gRXRjLiAgV2UgbmVl
ZGVkIGEgd2F5IHRvIHB1dCB0aGUgZGV2aWNlIGludG8gYSBrbm93biBnb29kIHN0YXRlIHNvIHRo
ZSBkcml2ZXIgY291bGQgcmUtaW5pdGlhbGl6ZSBpdC4gIFBsdXMsIElJUkMsIG9uIHNvbWUgb2Yg
dGhlIG9sZGVyIEFTSUNTLCBvbmNlIHRoZSBTTVUgb3IgUFNQIGZpcm13YXJlIHdhcyBsb2FkZWQs
IHRoZXJlIHdhcyBubyB3YXkgdG8gcmVsb2FkIGl0IHdpdGhvdXQgYSByZXNldCBzbyB5b3UgbmVl
ZGVkIG9uZSBhbnl3YXkuICBUaGlzIGlzIGxhcmdlbHkgd2h5IHdlIGhhdmUgdG8gcmVzZXQgZm9y
IFM0IGFzIHdlbGwuDQoyLiBTb21lIGxhcmdlIHNlcnZlcnMgZGlkbid0IHBvd2VyIG9mZiBQQ0kg
ZGV2aWNlcyBvbiByZWJvb3RzIHRvIHNhdmUgdGltZS4gIFRoaXMgbGVmdCB0aGUgZGV2aWNlcyB3
aXRoIHdoYXRldmVyIHN0YXRlIHRoZXkgaGFkIGJlZm9yZSB0aGUgc3lzdGVtIHdhcyByZWJvb3Rl
ZCB3aGljaCBsZWQgdG8gZHJpdmVyIGluaXRpYWxpemF0aW9uIHByb2JsZW1zIG9uIHN1YnNlcXVl
bnQgYm9vdHMgYmVjYXVzZSB0aGUgZGV2aWNlIHdhcyBpbiBhbiB1bmtub3duIHN0YXRlLg0KDQpJ
ZiB0aGVyZSBpcyBhIGJldHRlciB3YXkgdG8gaGFuZGxlIHRoZXNlIHNpdHVhdGlvbnMsIEknbSBh
bGwgZm9yIGl0Lg0KDQpBbGV4DQoNCg0KPiANCj4gRXZhbg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+
IExpam8NCj4gPg0KPiA+ID4gQlINCj4gPiA+IEV2YW4NCj4gPiA+Pg0KPiA+ID4+IFRoYW5rcywN
Cj4gPiA+PiBMaWpvDQo+ID4gPj4NCj4gPiA+Pj4gICAgCWFtZGdwdV9hbWRrZmRfc3VzcGVuZChh
ZGV2LCBmYWxzZSk7DQo+ID4gPj4+DQo+ID4gPj4+ICAgIAkvKiBXb3JrYXJvdWQgZm9yIEFTSUNz
IG5lZWQgdG8gZGlzYWJsZSBTTUMgZmlyc3QgKi8NCg==
