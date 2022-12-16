Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47847C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Dec 2022 12:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74CE810E012;
	Fri, 16 Dec 2022 12:12:19 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF9E710E012
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Dec 2022 12:12:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRTNTsP1ayjbMhjlsZxfjfTBLIpkuYyaRI/RxV/GVgTlvdoekfFQbcrh6T0mKDTHNqXv8tAujF1r5BJWn2Lz7Cn8b33AoAOye5E4hQJoIfoBLFx100LBB0/1/2NtRMG5uVmkxb6MSzyJkTqMjAXHt0/Rrzxhj11jd4RI9TJpfzfJdQXJVV4ECzFRueDpr+D7s+SIw2LniXWxBI9R3LikTgoz90H7UpByba8vLAOXxFtAjWz6VNUXavCLanDtA7Kiw8l4kkJxnD501uM25TYeVbJ6eOymf4hLI1U0zdscJzP39rhq0MH08PbM0JG3lCS0qcPBDvTkjlrGi4ZIiKdKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWXgAmA7nvjDpJ0x5fH6CfH+mkIZxSNONQjxWEt6xsM=;
 b=bHFv5UwjAfDNMgv7QRk6H+O4jj2hJ1+0vvVClg1sVFI1u1TlEbjzQWivjAYIzaoUzD9gTrHEw2Atejl0whks25lDOLvu87hzcOOHmdV3pfPomVEZP0pGUl+QOrI0aoQwDqvrgb2mFgvem+MHrCJ5gsdycyr2SUhMU3/jSDYSYCXyUGoGWg70hqLbkS4HsdHULrLbqbrhXnlFNTO75707uo9p/fdcy8LbwKsclcTIzbn1soqMhJIDPaPNKSptHjKxeHxAon2lyMxNKn8tgS5GErzUleC1X9clvkxyClwanrJPmxLz54XHFFukFaQ8Cj2sEPhDY/uY9bTJbn0ZIcab2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWXgAmA7nvjDpJ0x5fH6CfH+mkIZxSNONQjxWEt6xsM=;
 b=xRoJ83sfcRjH+OxrAsGSoNJ8kRk8IfZBXvSjTB38WJPgWR7C/IiB+slGbGAC++7RtnbejKeGzDYz8bk+s/F4W0nZY5MSZmqP7axmg/yRxMZTzkbSITqNUzArlCYQmXjpPiTjofjLTGHPThmv/Nfgn/rbaG4rnxZlGQ2BHcg+0Yw=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by CH3PR12MB8075.namprd12.prod.outlook.com (2603:10b6:610:122::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Fri, 16 Dec
 2022 12:12:07 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::31bc:96a4:74c0:4726]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::31bc:96a4:74c0:4726%6]) with mapi id 15.20.5924.015; Fri, 16 Dec 2022
 12:12:07 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Paneer
 Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fixed bug on error when uninstalling amdgpu
Thread-Topic: [PATCH] drm/amdgpu: Fixed bug on error when uninstalling amdgpu
Thread-Index: AQHZEPomz0Ay72JamUWJNQvmd1P5zq5wNMUAgAA4JjA=
Date: Fri, 16 Dec 2022 12:12:07 +0000
Message-ID: <CH2PR12MB42150EFAE5A7DDEBBCC5B25CFCE69@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20221216025621.176460-1-YiPeng.Chai@amd.com>
 <4cb9ed9d-310b-b226-895a-a7346c0cf67a@gmail.com>
In-Reply-To: <4cb9ed9d-310b-b226-895a-a7346c0cf67a@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-16T12:10:50Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8cde0165-7784-4ff1-94df-1f0cc77b7b6d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-16T12:12:03Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 7a926b11-9c81-4501-babf-6f30fe509a93
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|CH3PR12MB8075:EE_
x-ms-office365-filtering-correlation-id: b43ad02a-643e-4b0e-5a6c-08dadf5ec065
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZxkXuDMkGcRNDrCiFx8FE8nIzMFmh6269SMDlmb1g8YunVLYrDOsIJOHvOCDYxoihuaa4tiZ8xTphRCMaLR32MKHT1R3b8MREOXkif4cPKIEPjlLUft1s2txyr+8Ig2m1JFJlZ68eZSr5ydrVwJJxcUUpqAJ4yC7dbOVQFxNXEcnRhNvBfNB9Zjvd/zUcU03DE3v9pnbWfI0shIxY9t1MHL5k4FUlxyxwbt2kU/TQoJA0v7Sbw+UFwCm0ByZqt/MiHO1xpbTrP8BYSQIdDLAl7juGaseUgCQdyEgF58AmPRI5CwbyPpo8WrQPjSGP/NJIwWjIkvWFU6R1FroZ40OUHCCqMnplEgPIU7qgsBTYsuvJDVXNDhFXQ3MSJ4UOygcG5l0MOBdkIyW8YH/KXaIGLkNOt60JpuGsZCMN4iZWH2JeH4p3D366L77zQnJ9fXYpoknZX6tptW7mCwaRIdIJK/+rBMgaKbCp8lOjmIn/Fie5tRGjEzA3EmivrtknPVcVCborsh6oIIVnzE1Qz8zczqno/zgwrmWsWW8IdDvbmJa97jrMF1B4TyGx4whOc91nhyPsbZKrlq7kLo+gJaLu+KvQdXi5qfulLpouQ1gV/LCY+WtQFZ7VhcUuG3HG+QOHi052oNp7Lrxsmpmpd5h5Q1h6PbFI4m7ehDPzXX7r0lz5zoTA6wYoCGaYM8EE53bgs7IpzouGonyQ5/6EZaUpw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(451199015)(66446008)(2906002)(4326008)(66476007)(8676002)(38100700002)(53546011)(76116006)(64756008)(186003)(66574015)(6506007)(54906003)(316002)(33656002)(66556008)(86362001)(6636002)(26005)(41300700001)(5660300002)(8936002)(52536014)(66946007)(9686003)(7696005)(55016003)(38070700005)(478600001)(110136005)(71200400001)(83380400001)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzJ6ZHM2VjJwbHhlZDZUZ0sxNUgvLzd4SHNIcEVyUnNtbXpNRFg5QU9LRTd0?=
 =?utf-8?B?dS8xV3hQZUdoQjJjVm9Xa3FsQk02RlYyYlk5YlNMd3hxTFBobE5sRk5VZzVE?=
 =?utf-8?B?VjA0a0V4Sjl5Tm05OXAzdTVDNlFyS1hreDVwMUZlOS9SL1VRaU1PcmxVZEZQ?=
 =?utf-8?B?SmVZUnE1ZjRTNXJ1VnBvQ1BtODBrSWZ5WTI5dThQUFBPeXBudDF5em15SzRQ?=
 =?utf-8?B?RkVrenhaNmtSQnFLYzVQSjhpVG1KWWp0QkdRMzVQZlpMWWVOc1FMRVJZbTk3?=
 =?utf-8?B?UXhkYklIRlBDa1dubGYwOTJPUlp6elFGbUlCcklHak9FOWFrcG0zdzZCOU85?=
 =?utf-8?B?ZGx5YU1VNnV5QWJrSzludEpackdmNDl2RGNtaUZ6WWFvOUdrdWJMeU9lMlU0?=
 =?utf-8?B?ZkI5NS9SVVdFZTBIT0dwVHYrWU9Yd2lzRkcvOEkzY2E2VHM2cHcxWjhVNmNv?=
 =?utf-8?B?b3h2VDlWdlFTQ3RsY2Rlbkw3YWNQeVAzWjVFdTFnYlZkTE4xMG5VWGdVT0tF?=
 =?utf-8?B?dUVibE8xbDk0cEdvT2xKZkRiK0FMVnpjanZBcTdVL3lOWjBTOFhIL09DR1E0?=
 =?utf-8?B?c1p5OXMxVXpBcGx0QjkxdEI3Q3ZCSTFoUGd1bUVTb2JXeFpyK0F4MllYbTZj?=
 =?utf-8?B?RDNHVmsrdXRrZU5zYXZYSmw0K1dIYVVZTHV1bmdxVGRHRTB3R05QdGZVWkls?=
 =?utf-8?B?YVI4QVV5b3h6cmRWSEJGbHpaQTFOU2NBVWsvcjIyT0xzWGsxZGdvQUZTWWxy?=
 =?utf-8?B?OWw3N0MyUGdRSzFsM1NVeXFuSjdSbTJhUXVaZkJ6ZDdXajE4QVdZOERCRXM1?=
 =?utf-8?B?ckR5dGRER0d5ZzV0OWEzdDVVcVBoSGE5a0FKNkx5QlNtRjFmOEtWVU5SVmdB?=
 =?utf-8?B?VTlIaHhOZTk3ZVNXQ3RwaGQyZTBrMEhIYTZlY0FYOG5Id3Z6V3J0d3B5WnZG?=
 =?utf-8?B?OGJCYzE1WkRDRXFNMHIwSDRZWGtzVUU0MlRVSVJ0bGErZVBBNVNCSmFNbmk2?=
 =?utf-8?B?RjcwamEwSDd3cVZOaHFCOHd0NWUyRThNV0JTOVJLb1kvRnRya21lek5VK2JF?=
 =?utf-8?B?T08zZkgycmZYQ3F2QjNOMHVraktNNzVQWmJLZjJJdU44VEhqNnpsc2VnYXcv?=
 =?utf-8?B?aGJ3dXV6UGJNcnpSSHJDSUU1S2pEQzZPcEZvWTlGV1BhazJOSE9CemFXOXNk?=
 =?utf-8?B?MmtzVXcxcFZmUjlTdFZSTHZEY3F1YnNRZS9DNG01Z2d3SDAzcnFLWjR2ZFZo?=
 =?utf-8?B?WlMxR1hpVzdHSFQ3K0NPeEdFZktGS25jQlNvZnRwZGVSVWU3SWhHeEkvRzVi?=
 =?utf-8?B?UkZYZ3BsdmVSTm1TSlNiRjZOVkRicFMxMDYyQzQxdVVZQzROd2gyd29XV0hL?=
 =?utf-8?B?bzlWL2dMUWlMc2o4S0c4di9pNUQ0S01XNEhjbXdhdjIrZGMzRWVReURNajVF?=
 =?utf-8?B?cUdhaFQ2WkdnSWxwRXYrN0lKSUpIaVI4cEdmaHI0Z2I3cmV0UVFBOG5WN0pL?=
 =?utf-8?B?N25IRHRTNVYwaXRNSVYyOW1NMUdZank1Y3hHMTJNSnJVWHl6LzlQU29oeUwy?=
 =?utf-8?B?NVJaSDNjNGdDSnh1ck5oU0RtNU54VzJrTWdUZWFBaS9kZy8xTUllQmNmcGNU?=
 =?utf-8?B?U0ViMnV4TFB0QUhSd3laOE9NWk5kODdXYmZqbC82bE1WMkV2QmViSXVvMTlN?=
 =?utf-8?B?Q01peU1MYU1wZW9Qb1VSalpVbmFkNG9PMkwvbGxvQ3FabU8rUDNzdzIxM0k1?=
 =?utf-8?B?U01HOGRna0lqWENZWk50QXVTOVZnRzFWMEJkWDNPTkY0WWFBV2ZGSWlxRE9D?=
 =?utf-8?B?SzNndFZNc3pzeTNvaHJpSFZ4SVhESmcwQ05zK3RhUGczSDJ3RklnUUR1YzJ0?=
 =?utf-8?B?b1czc0hrSWZ2cWZMOW5nZjVyQStaTGpZRjhyUDJ1VG1zVEZpY1pmQ2w1UTJ2?=
 =?utf-8?B?RnNFVldmSUlJbkQ5VVp5V2FqQm44Qy9SS2lhdklLWktWWXB6MW9vc2JidVVI?=
 =?utf-8?B?MGw0cGFid1ZUblg1c2kyODVVcVl0VVVaUFQxSTdFbHVyZXNpeXR6UFp2OVJU?=
 =?utf-8?B?VXBRQnRrdnpyTTZEbEp6SlVObkRCNldYZWNKdlJtOFJlY0xzMmE1YldNT0ZN?=
 =?utf-8?Q?ymAAT9rOYuwxOh2r7NgvrVl9y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b43ad02a-643e-4b0e-5a6c-08dadf5ec065
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 12:12:07.3821 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d51Fl+3mYH+qwaDt0AxOpomGOoPRj/+kCUZs6HWOxZPKN+coVVhvScHLKft6vkn0sbYXpKbzx4ZhmNtGODAbnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8075
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCk9LLCBJIHdpbGwgdXBkYXRlIHN1
YmplY3QgbGluZS4gIFRoYW5rcyENCg0KDQotLS0tLS0tLS0tLS0tLS0tLQ0KQmVzdCBSZWdhcmRz
LA0KVGhvbWFzDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBDaHJpc3RpYW4g
S8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gDQpTZW50OiBGcmlkYXks
IERlY2VtYmVyIDE2LCAyMDIyIDQ6NTAgUE0NClRvOiBDaGFpLCBUaG9tYXMgPFlpUGVuZy5DaGFp
QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgUGFuZWVyIFNlbHZhbSwg
QXJ1bnByYXZpbiA8QXJ1bnByYXZpbi5QYW5lZXJTZWx2YW1AYW1kLmNvbT4NCkNjOiBaaG91MSwg
VGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFt
ZC5jb20+OyBDaGFpLCBUaG9tYXMgPFlpUGVuZy5DaGFpQGFtZC5jb20+DQpTdWJqZWN0OiBSZTog
W1BBVENIXSBkcm0vYW1kZ3B1OiBGaXhlZCBidWcgb24gZXJyb3Igd2hlbiB1bmluc3RhbGxpbmcg
YW1kZ3B1DQoNCkFtIDE2LjEyLjIyIHVtIDAzOjU2IHNjaHJpZWIgWWlQZW5nIENoYWk6DQo+IEZp
eGVkIGJ1ZyBvbiBlcnJvciB3aGVuIHVuaW5zdGFsbGluZyBhbWRncHUuDQo+IFRoZSBlcnJvciBt
ZXNzYWdlIGlzIGFzIGZvbGxvd3M6DQo+IFsgIDMwNC44NTI0ODldIGtlcm5lbCBCVUcgYXQgZHJp
dmVycy9ncHUvZHJtL2RybV9idWRkeS5jOjI3OCENCj4gWyAgMzA0Ljg1MjUwM10gaW52YWxpZCBv
cGNvZGU6IDAwMDAgWyMxXSBQUkVFTVBUIFNNUCBOT1BUSQ0KPiBbICAzMDQuODUyNTEwXSBDUFU6
IDIgUElEOiA0MTkyIENvbW06IG1vZHByb2JlIFRhaW50ZWQ6IEcgICAgICAgIFcgSU9FICAgICA1
LjE5LjAtdGhvbWFzICMxDQo+IFsgIDMwNC44NTI1MTldIEhhcmR3YXJlIG5hbWU6IEFTVVMgU3lz
dGVtIFByb2R1Y3QgTmFtZS9QUklNRSBaMzkwLUEsIA0KPiBCSU9TIDIwMDQgMTEvMDIvMjAyMSBb
ICAzMDQuODUyNTI2XSBSSVA6IA0KPiAwMDEwOmRybV9idWRkeV9mcmVlX2Jsb2NrKzB4MjYvMHgz
MCBbZHJtX2J1ZGR5XSBbICAzMDQuODUyNTM1XSBDb2RlOiANCj4gMDAgMDAgMDAgOTAgMGYgMWYg
NDQgMDAgMDAgNDggOGIgMGUgODkgYzggMjUgMDAgMGMgMDAgMDAgM2QgMDAgMDQgMDAgDQo+IDAw
IDc1IDEwIDQ4IDhiIDQ3IDE4IDQ4IGQzIGUwIDQ4IDAxIDQ3IDI4IGU5IGZhIGZlIGZmIGZmIDww
Zj4gMGIgMGYgMWYgDQo+IDg0IDAwIDAwIDAwIDAwIDAwIDBmIDFmIDQ0IDAwIDAwIDQxIDU0IDU1
IDQ4IDg5IGY1IDUzIFsgIDMwNC44NTI1NDldIA0KPiBSU1A6IDAwMTg6ZmZmZjlhZmFjMTdiYmNi
OCBFRkxBR1M6IDAwMDEwMjg3IFsgIDMwNC44NTI1NTZdIFJBWDogDQo+IDAwMDAwMDAwMDAwMDAw
MDAgUkJYOiBmZmZmOGRhY2QzN2ZkNzc4IFJDWDogMDAwMDAwMDAwMDAwMDAwMCBbICANCj4gMzA0
Ljg1MjU2M10gUkRYOiBmZmZmOGRhY2QzN2ZkN2EwIFJTSTogZmZmZjhkYWNkMzdmZDNiOCBSREk6
IA0KPiBmZmZmOGRhYzY3MmE1ZjgwIFsgIDMwNC44NTI1NzBdIFJCUDogZmZmZjhkYWNkMzdmZDNh
MCBSMDg6IA0KPiAwMDAwMDAwMDAwMDAwMDAxIFIwOTogMDAwMDAwMDAwMDAwMDAwMCBbICAzMDQu
ODUyNTc3XSBSMTA6IA0KPiBmZmZmOGRhYzY4MTg1NTAwIFIxMTogZmZmZjlhZmFjMTdiYmQwMCBS
MTI6IGZmZmY4ZGFjNjcyYTVmODAgWyAgDQo+IDMwNC44NTI1ODRdIFIxMzogZmZmZjhkYWM2NzJh
NWZlMCBSMTQ6IGZmZmY4ZGFjZDM3ZmQzODAgUjE1OiANCj4gZmZmZjhkYWM2NzJhNWY4MCBbICAz
MDQuODUyNTkwXSBGUzogIDAwMDA3ZjBmYTliMzBjNDAoMDAwMCkgDQo+IEdTOmZmZmY4ZGFkYjY0
ODAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMCBbICAzMDQuODUyNTk4XSBDUzogIDAw
MTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzIFsgIDMwNC44NTI2MDRd
IENSMjogMDAwMDdmNGJmMWExYmE1MCBDUjM6IDAwMDAwMDAxMDhjNTgwMDQgQ1I0OiAwMDAwMDAw
MDAwMzcwNmUwIFsgIDMwNC44NTI2MTFdIERSMDogMDAwMDAwMDAwMDAwMDAwMCBEUjE6IDAwMDAw
MDAwMDAwMDAwMDAgRFIyOiAwMDAwMDAwMDAwMDAwMDAwIFsgIDMwNC44NTI2MThdIERSMzogMDAw
MDAwMDAwMDAwMDAwMCBEUjY6IDAwMDAwMDAwZmZmZTBmZjAgRFI3OiAwMDAwMDAwMDAwMDAwNDAw
IFsgIDMwNC44NTI2MjVdIENhbGwgVHJhY2U6DQo+IFsgIDMwNC44NTI2MjldICA8VEFTSz4NCj4g
WyAgMzA0Ljg1MjYzMl0gIGRybV9idWRkeV9mcmVlX2xpc3QrMHgyYS8weDYwIFtkcm1fYnVkZHld
IFsgIA0KPiAzMDQuODUyNjM5XSAgYW1kZ3B1X3ZyYW1fbWdyX2ZpbmkrMHhlYS8weDE4MCBbYW1k
Z3B1XSBbICAzMDQuODUyODI3XSAgDQo+IGFtZGdwdV90dG1fZmluaSsweDFmOS8weDI4MCBbYW1k
Z3B1XSBbICAzMDQuODUyOTI1XSAgDQo+IGFtZGdwdV9ib19maW5pKzB4MjIvMHg5MCBbYW1kZ3B1
XSBbICAzMDQuODUzMDIyXSAgDQo+IGdtY192MTFfMF9zd19maW5pKzB4MjYvMHgzMCBbYW1kZ3B1
XSBbICAzMDQuODUzMTMyXSAgDQo+IGFtZGdwdV9kZXZpY2VfZmluaV9zdysweGM1LzB4M2IwIFth
bWRncHVdIFsgIDMwNC44NTMyMjldICANCj4gYW1kZ3B1X2RyaXZlcl9yZWxlYXNlX2ttcysweDEy
LzB4MzAgW2FtZGdwdV0gWyAgMzA0Ljg1MzMyN10gIA0KPiBkcm1fZGV2X3JlbGVhc2UrMHgyMC8w
eDQwIFtkcm1dIFsgIDMwNC44NTMzNTJdICANCj4gcmVsZWFzZV9ub2RlcysweDM1LzB4YjAgWyAg
MzA0Ljg1MzM1OV0gIGRldnJlc19yZWxlYXNlX2FsbCsweDhiLzB4YzAgWyAgDQo+IDMwNC44NTMz
NjRdICBkZXZpY2VfdW5iaW5kX2NsZWFudXArMHhlLzB4NzAgWyAgMzA0Ljg1MzM3MF0gIA0KPiBk
ZXZpY2VfcmVsZWFzZV9kcml2ZXJfaW50ZXJuYWwrMHhlZS8weDE2MA0KPiBbICAzMDQuODUzMzc3
XSAgZHJpdmVyX2RldGFjaCsweDQ0LzB4OTAgWyAgMzA0Ljg1MzM4Ml0gIA0KPiBidXNfcmVtb3Zl
X2RyaXZlcisweDU1LzB4ZTAgWyAgMzA0Ljg1MzM4N10gIA0KPiBwY2lfdW5yZWdpc3Rlcl9kcml2
ZXIrMHgzYi8weDkwIFsgIDMwNC44NTMzOTNdICBhbWRncHVfZXhpdCsweDExLzB4NjkgDQo+IFth
bWRncHVdIFsgIDMwNC44NTM1NDBdICBfX3g2NF9zeXNfZGVsZXRlX21vZHVsZSsweDE0Mi8weDI2
MA0KPiBbICAzMDQuODUzNTQ4XSAgPyBleGl0X3RvX3VzZXJfbW9kZV9wcmVwYXJlKzB4M2UvMHgx
OTANCj4gWyAgMzA0Ljg1MzU1NV0gIGRvX3N5c2NhbGxfNjQrMHgzOC8weDkwIFsgIDMwNC44NTM1
NjJdICANCj4gZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NjMvMHhjZA0KPg0KPiBT
aWduZWQtb2ZmLWJ5OiBZaVBlbmcgQ2hhaSA8WWlQZW5nLkNoYWlAYW1kLmNvbT4NCg0KVGhlIHN1
YmplY3QgbGluZSBzaG91bGQgcHJvYmFibHkgcmVhZCAid2hlbiB1bmxvYWRpbmcgYW1kZ3B1Iiwg
YnV0IGFwYXJ0IGZyb20gdGhhdCBnb29kIGNhdGNoLg0KDQpSZXZpZXdlZC1ieTogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cmFtX21nci5jIHwgMiArLQ0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMgDQo+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMNCj4gaW5kZXggMGI1OThiNTEw
YmQ4Li5lYjYzMzI0YzMwZDIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92cmFtX21nci5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92cmFtX21nci5jDQo+IEBAIC04MjksNyArODI5LDcgQEAgdm9pZCBhbWRncHVfdnJh
bV9tZ3JfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gICAJCWtmcmVlKHJzdik7
DQo+ICAgDQo+ICAgCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShyc3YsIHRlbXAsICZtZ3ItPnJl
c2VydmVkX3BhZ2VzLCBibG9ja3MpIHsNCj4gLQkJZHJtX2J1ZGR5X2ZyZWVfbGlzdCgmbWdyLT5t
bSwgJnJzdi0+YmxvY2tzKTsNCj4gKwkJZHJtX2J1ZGR5X2ZyZWVfbGlzdCgmbWdyLT5tbSwgJnJz
di0+YWxsb2NhdGVkKTsNCj4gICAJCWtmcmVlKHJzdik7DQo+ICAgCX0NCj4gICAJZHJtX2J1ZGR5
X2ZpbmkoJm1nci0+bW0pOw0K
