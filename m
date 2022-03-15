Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0873C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 07:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4947C10E420;
	Tue, 15 Mar 2022 07:49:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60D6C10E420
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 07:49:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kto2VwfHMu4aTZSTEFPY/Ip1Q4R1Mzpqdp2JqxhvHXeWxdhwcEgxyFZ9r9kIMp699PRjG1QK6C5D1BIgaYaI/CyWUZXZBdHUnnAanK8HC6N4dn/rnwqUGn7HFR8Mfc55uqVX6IXxknPNOpuYTxyJCdCvi8CtNaJ3HHhTJjmVCSFT0DD3aqgIwEEvgGbWhGAq7wjkven8l2QypEryoZf8of1LrLscJiRyKnIpQ1pjfzkPoFW8p5ylu5J9DJMJBNPXQ0G6juKKzmVKV34u2yM50oZei2YKBoBxU/v7X7mAL60EyKxoRGG9ZYkllYpyOC9zwMo2RWM1XQqGy6gWwj2exA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MR//QRVH8V4yoQex4I5/Hv4LZ5L2nwpJt31J0fEhMMU=;
 b=LItSC8vQK5nkPAAxeoHWs5vatTpiiQI5wgPdp+z6ZjtzTicoNGGQNk6FENjdznOm9md7AId6UQ01hXO45Kellb0IIiTpqwTqazPyLNquCS5DSpkqZ+zloRdWQH4j7+IsK4FnU/+KD27xFoMTHIYe4499xTSi649GXX821/cDDCGa5Cv0uPkTQRH9r5IgbdvKMM+b/A0RPWpbymSH7qTVCVr8JKWTsPsORSvS/gbfIM4ldZhIFC4OUgqyHc+R+Yyo2wuYPLNrF7mzEqRiJzjwRHBWRS8wR1eLNVUQdXFAA3fjgdQS+quiuh9akyigScXpVIsG4DCbi/0hkz13H/aMOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MR//QRVH8V4yoQex4I5/Hv4LZ5L2nwpJt31J0fEhMMU=;
 b=elXiNxsFBTvwy9Xzglv+z5yA97LW86ChqRQc71cWUaLWcemskmFvQIQi2SmwOlbkSQN8y8xuEM9U0bLDC+LlTmJzOwcWHnpbkVUCMEMo9NosFByAW1x9bqdTWhJ45M0RX8+Zu1kMK5dKR2+yH28OiBNkJWMP6/fiseu9KH8fXYM=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 SN1PR12MB2382.namprd12.prod.outlook.com (2603:10b6:802:2e::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.25; Tue, 15 Mar 2022 07:49:18 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::c5cf:8668:2fc7:afc4]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::c5cf:8668:2fc7:afc4%7]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 07:49:18 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: prevent memory wipe in suspend/shutdown
 stage
Thread-Topic: [PATCH 1/2] drm/amdgpu: prevent memory wipe in suspend/shutdown
 stage
Thread-Index: AQHYODu29UFycqNJM02xe4RARgqnPazADeoAgAACTxA=
Date: Tue, 15 Mar 2022 07:49:18 +0000
Message-ID: <DM5PR12MB2469B5FF271B5553D419AA46F1109@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220315070913.9046-1-guchun.chen@amd.com>
 <5931e547-fa64-854d-a212-1ce214f4e8e5@amd.com>
In-Reply-To: <5931e547-fa64-854d-a212-1ce214f4e8e5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66a33818-6622-4b82-a311-08da06584f60
x-ms-traffictypediagnostic: SN1PR12MB2382:EE_
x-microsoft-antispam-prvs: <SN1PR12MB2382580D545D6E75E261F309F1109@SN1PR12MB2382.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z20yt1zNPDhZENjKq47A320xhNfT5TyALkmkgtWqpCfC6fdQNIVVvYmCgEs/fcSgfLkpA/hwUw8uG/XP7EwSjd+mko7Z+YZQOdX7yv++NnTEqZIWS/cuP/faHS617dxhHp52vdPDjqSoab2uBDOkkxbv1uz5OTFakLYi4po7yEFJ30kBdL3rXX7Qxw5ConUeHQEG6E7RArXEwSgGuJMRQoRvtV1c03ziu4s5JQYHm6PtndwC+pkOHkgRUYY/P00XHSDfJHEwshqhlkD4nzncmnvkOAaf4fE7T6fie2i/GfkqfWKUOCmtArnVQj9lJggyCCnWRMLpGemcnhpgYWFkcF7bDIdOtQP3fXzJoa3CxwlSdEFkfvo45UqeTPDDuhb+ZQf1hGb9NrJyYGS5ktFwfPfHO+VL8bYMy2I+tizdiupxuBonToMFkW8sRsPP6FWgdeQ71282W9q+MA4epCuuuWoqkpyvAmWCq8OdXcpBTgE98DTMyXWW/pVA3Un8+Y4FEuYv+u7gmb9F0qO7ZWwXTo4NuXStou0Dr9/PJqZTZ2JiAYdX/FwFrkuUqT3ANcmOwi2roPr50cc3aoll3ixw5g2A+by/cXO61e4x72+jAaOy51l/416gDkJYcnlMYeYOn89tvyGo1znSd8VNb7VUr3JEAejLb0VormuBrBXl074KsiD5wASL+QtM4vYVvR3qF7DtX/LFcBrCC0LjL60Iig==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(122000001)(110136005)(6636002)(316002)(8936002)(6506007)(2906002)(9686003)(7696005)(38070700005)(76116006)(53546011)(508600001)(66556008)(8676002)(66446008)(33656002)(64756008)(66476007)(66946007)(186003)(86362001)(26005)(55016003)(15650500001)(66574015)(5660300002)(71200400001)(52536014)(83380400001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUM3TTNNaXJOcE1LUER3bFlORTkrd2I2OUdsYTFWSU9pT0k1QzdveUd6QmJs?=
 =?utf-8?B?WDNTa3Nrekx6cEZUUXVDWUprUWhnenF1bDhMVzRVUytVbmFTcEFtdXJVeUFM?=
 =?utf-8?B?dVJjSkE4b2M2UlZmMlNyaEhqMHAzNUVpNm1STHB1UUZZQnd3Sm8zd20yRUNk?=
 =?utf-8?B?R3dEaUJ0NVBGenRmeHUwZTNSUWY2bEJKMkRTNTloR2hqV3V6b1EwcU5tYVRp?=
 =?utf-8?B?UTlEVW13L1BLMFFjMXplRkpxR0pveVNxWk9rYWdSa1hobmlCV2wxcGphVVdE?=
 =?utf-8?B?MytkRDlSR1I2TlpSQUpZenloSTViRVlGKzFVanRycm1yYUtFOUdPU1l2Qmpk?=
 =?utf-8?B?Mkt0cS94NWExa3FTdjZTNS9wbXBzaUpxV0p0YlpPRDFENkpIbldIaVhUVUdr?=
 =?utf-8?B?VnE4WEhZNDZ6dXd1YjJFMCs1M2V1YWYrSXBLSk9NSmhaYUNKWGVENWhtL2lz?=
 =?utf-8?B?ZjhXUENaMWpOdDFDcHFUSHhLdndVTXVCam9vU3BtV3VJSm84N0NCb1VVNjg0?=
 =?utf-8?B?M1JTUHlzL3NNVVRlZWFTY2xBRnRNaFpqR1hNbnhGbzR6dnFLbkdJZm1QUkQ2?=
 =?utf-8?B?TUptNjRMOTg2Q0xyU0p3bjR1QnVYdVZhUmt4aXpWUHQ1eVRYSHZUODNJU3lU?=
 =?utf-8?B?cGwxS3IzSjNLRUptQkwyTzhYN1pQUFpJamxiUGZ3NE41RStpWnVsWTc2M0Fm?=
 =?utf-8?B?U3cwb0N1aS9pbmFhbFQvckFuWkFGem8rV0J0K25OQjhLM2UwUnlodmdMaDRi?=
 =?utf-8?B?U3JZTEdySjlJYUVCUlZxVXNwVWY4Q3MwWHlzYXVsUnpPcFo3UEhHVU1Dc0l2?=
 =?utf-8?B?ZTl4WDJBR0VwdjhSVEFNcUVLdCtHblZrRjRSZUZOb1B3SWNTazZBZ1p2am9F?=
 =?utf-8?B?MDVlU25mR3VxTElrSm1iVUdjVkE0Z1dvTEFWVi8wcnV0WUlQUktOaFJpVlla?=
 =?utf-8?B?bStDTXlYZlpaWktHL0pCanpXR3ErN2ZyQytxWDUxVWtqbC9rdklpbFRVdzM3?=
 =?utf-8?B?U0lwNk1Hdmt1UHhJeHRIV3RabStMTUxNakNmc3N1OFBaR0dFVGNaWFJJYVZW?=
 =?utf-8?B?Wk5aMEJnOTZKR2psVjk0ekFna1puRDJIVDF4NTZKTlJhM1lsUnhILzF4aG9C?=
 =?utf-8?B?bjcvcUpkcGtXMjdLLzNuNGpTRHV5UEdxVDc5ck1CRmUwZFhrK1pPTm9wME5B?=
 =?utf-8?B?S0NZazhtbTlubEF2VUw1OVAyZllxUGtJYklkYUpzSFk3cW1qaDBqcnZ2NklV?=
 =?utf-8?B?STBuNnpVbStkdkRZcXVjVTlyeU5JcSt5ZlJBZXhxZ1NxNXFZWXZ2MkhacG5T?=
 =?utf-8?B?dWN4S201eEF6R3VhcnlnZlBvUmh2UGQ0cC9DOFE1MHZpYXN5TVdHbXZLaFk4?=
 =?utf-8?B?SVcyMXlZdzAwMzNjVTVrMUxneHBCMk9MRGQwMUZXNXBITDJlWVdWSHdERkhs?=
 =?utf-8?B?U0VEVW1wVlFxKzRvdG4wQmNtQlFBU3ZKZ251Zy9MalBjSkN5cm11K0pxTjBt?=
 =?utf-8?B?SUl2czg4aHE4eDltS1c4ck80NXVtekpDa0VMbDh1TWVjZnRZeVM4MmliZU5X?=
 =?utf-8?B?a0lMTW04QW1qQkRqMk4zS3ByOUR6eHRhNmtvd1M3TDlBZ1E0QlJiZjVIa2FT?=
 =?utf-8?B?M0FkUldLWHRyenRhVTJOMGR5bURCODhRT0hHSjBENDlsVk1GLzNzdnU1bHVY?=
 =?utf-8?B?S002YkNsMnRvcWFiYTdtRUY4ZCtZcy9OVkhjdkk1cHJpV3QxZ0xwaUZtZXAv?=
 =?utf-8?B?a09va1N4WHM5OU8vMUFlWkF1anJZamRtMDZMdkNURWpVRXlxZUMwYkhyZmNu?=
 =?utf-8?B?dTFZL3U1OExIdnNpdzcwc0dOTzZYQ1FqK3B5K2ViSm95WVRqMFNPdm1HNHg2?=
 =?utf-8?B?a1pkNmVaWXpIZnhId3BZbXNWWlI4K21EbEd4NWYwSDdjS2o4ODZlSXVzcUxP?=
 =?utf-8?Q?+B9+zRN7vPG/eazsl40+UDWM47IYV6tp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a33818-6622-4b82-a311-08da06584f60
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 07:49:18.4499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qEqOQc8+suFPUgPmsCmPJluf9ZUoPYlEbOhN1sFhYp7djc99GUL26LdpD33rof5Fd/aJKsacwQW5uJpVnwNlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2382
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

SSB1c2VkIHR3byB0YWJzIGluIFZJTS4gTGV0IG1lIHVwZGF0ZSB0aGlzIGxhdGVyLg0KDQpSZWdh
cmRzLA0KR3VjaHVuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLb2VuaWcs
IENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPiANClNlbnQ6IFR1ZXNkYXksIE1h
cmNoIDE1LCAyMDIyIDM6MzUgUE0NClRvOiBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5j
b20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgWmhhbmcsIEhhd2tpbmcgPEhhd2tp
bmcuWmhhbmdAYW1kLmNvbT47IFBhbiwgWGluaHVpIDxYaW5odWkuUGFuQGFtZC5jb20+OyBEZXVj
aGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpTdWJqZWN0OiBSZTog
W1BBVENIIDEvMl0gZHJtL2FtZGdwdTogcHJldmVudCBtZW1vcnkgd2lwZSBpbiBzdXNwZW5kL3No
dXRkb3duIHN0YWdlDQoNCg0KDQpBbSAxNS4wMy4yMiB1bSAwODowOSBzY2hyaWViIEd1Y2h1biBD
aGVuOg0KPiBPbiBHUFVzIHdpdGggUkFTIGVuYWJsZWQsIGJlbG93IGNhbGwgdHJhY2UgaXMgb2Jz
ZXJ2ZWQgd2hlbiBzdXNwZW5kaW5nIA0KPiBvciBzaHV0dGluZyBkb3duIGRldmljZS4gVGhlIGNh
dXNlIGlzIHdlIGhhdmUgZW5hYmxlZCBtZW1vcnkgd2lwZSBmbGFnIA0KPiBmb3IgQk9zIG9uIHN1
Y2ggR1BVcyBieSBkZWZhdWx0LCBhbmQgc3VjaCBCT3Mgd2lsbCBnbyB0byBtZW1vcnkgd2lwZSAN
Cj4gYnkgYW1kZ3B1X2ZpbGxfYnVmZmVyLCBob3dldmVyLCBiZWNhdXNlIHJpbmcgaXMgb2ZmIGFs
cmVhZHksIGl0IGZhaWxzIA0KPiB0byBjbGVhbiB1cCB0aGUgbWVtb3J5IGFuZCB0aHJvdyB0aGlz
IGVycm9yIG1lc3NhZ2UuIFNvIGFkZCBhIA0KPiBzdXNwZW5kL3NodXRkb3duIGNoZWNrIGJlZm9y
ZSB3aXBwaW5nIG1lbW9yeS4NCj4NCj4gW2RybTphbWRncHVfZmlsbF9idWZmZXIgW2FtZGdwdV1d
ICpFUlJPUiogVHJ5aW5nIHRvIGNsZWFyIG1lbW9yeSB3aXRoIHJpbmcgdHVybmVkIG9mZi4NCj4N
Cj4gRml4ZXM6IGU3ZTdjODdhMjA1ZCgiZHJtL2FtZGdwdTogV2lwZSBhbGwgVlJBTSBvbiBmcmVl
IHdoZW4gUkFTIGlzIA0KPiBlbmFibGVkIikNCj4gU2lnbmVkLW9mZi1ieTogR3VjaHVuIENoZW4g
PGd1Y2h1bi5jaGVuQGFtZC5jb20+DQoNCkp1c3Qgb25lIG5pdCBiZWxvdywgYnV0IHRoZSBwYXRj
aCBpcyBhbnl3YXkgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4uDQoNCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X29iamVjdC5jIHwgNCArKystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X29iamVjdC5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9vYmplY3QuYw0KPiBpbmRleCAyM2M5YTYwNjkzZWUuLmVkMWExOWJlNGE1NCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYw0KPiBAQCAtMTI4
NCw2ICsxMjg0LDcgQEAgdm9pZCBhbWRncHVfYm9fZ2V0X21lbW9yeShzdHJ1Y3QgYW1kZ3B1X2Jv
ICpibywgdWludDY0X3QgKnZyYW1fbWVtLA0KPiAgICAqLw0KPiAgIHZvaWQgYW1kZ3B1X2JvX3Jl
bGVhc2Vfbm90aWZ5KHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8pDQo+ICAgew0KPiArCXN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gYW1kZ3B1X3R0bV9hZGV2KGJvLT5iZGV2KTsNCj4g
ICAJc3RydWN0IGRtYV9mZW5jZSAqZmVuY2UgPSBOVUxMOw0KPiAgIAlzdHJ1Y3QgYW1kZ3B1X2Jv
ICphYm87DQo+ICAgCWludCByOw0KPiBAQCAtMTMwMyw3ICsxMzA0LDggQEAgdm9pZCBhbWRncHVf
Ym9fcmVsZWFzZV9ub3RpZnkoc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibykNCj4gICAJCWFt
ZGdwdV9hbWRrZmRfcmVtb3ZlX2ZlbmNlX29uX3B0X3BkX2JvcyhhYm8pOw0KPiAgIA0KPiAgIAlp
ZiAoYm8tPnJlc291cmNlLT5tZW1fdHlwZSAhPSBUVE1fUExfVlJBTSB8fA0KPiAtCSAgICAhKGFi
by0+ZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFURV9WUkFNX1dJUEVfT05fUkVMRUFTRSkpDQo+ICsJ
CSEoYWJvLT5mbGFncyAmIEFNREdQVV9HRU1fQ1JFQVRFX1ZSQU1fV0lQRV9PTl9SRUxFQVNFKSB8
fA0KPiArCQlhZGV2LT5pbl9zdXNwZW5kIHx8IGFkZXYtPnNodXRkb3duKQ0KDQpXaGF0IGVkaXRv
ciBhbmQgc2V0dGluZ3MgYXJlIHlvdSB1c2luZz8NCg0KV2hlbiB5b3UgaGF2ZSBhIG11bHRpLWxp
bmUgY29uZGl0aW9uIHRvIGFuIGlmIHRoZSBuZXh0IGxpbmUgc2hvdWxkIHN0YXJ0IGFmdGVyIHRo
ZSAoIG9mIHRoZSBwcmV2aW91cyBsaW5lLCBidXQgdGhpcyBoZXJlIGlzIHVzaW5nIHR3byB0YWJz
IGluc3RlYWQuDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4gICAJCXJldHVybjsNCj4gICAN
Cj4gICAJaWYgKFdBUk5fT05fT05DRSghZG1hX3Jlc3ZfdHJ5bG9jayhiby0+YmFzZS5yZXN2KSkp
DQoNCg==
