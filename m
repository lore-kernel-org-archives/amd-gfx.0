Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC98AC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jun 2022 03:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5396710E956;
	Thu, 16 Jun 2022 03:36:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C119910FAC4
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 03:36:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZU/VV3xq0ppEg5jCZ/0Y0xxRJkjCYTZwIyN1pEVtIyE0BKVevTEeCP6IiZFbYZLwJNI6qcVE5vaAAPrJkCHU+bUvG/qw+XO5RH+HsTmM24FrLPHYyyGh1I+p/wPdhu5QctKBzLjuxAQLl8XPvinI6laF1gTFGPkHCvP3A2JP7+NGLk6c27ShDHTQeO2pVUrvw5pGnsIzJiSx5T+XAy9dsY9XRzHqfZ8zbKJHKSuJqY+LvlqpqWrFtFQ+NIZYFNw3nLH30y0f6EfkXXoqD+PicAMyqJdVOhWIktz/h1gYxU5ConERYA7zcaap1pnr+lnDBRtE9f9/6tJDQGbeKY/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBEhQQuaVGjQ02gNznshBOHdt6RneQX+ZuYq0okzEpk=;
 b=ajNxf6bgHmbVxnj/kDxQYvBfkmO06IK6vmjMzG5LKfaQ1lUvlK1lGV1s4busZUg+RBXWdaYEfOEh1te/d3I0JbYEqq6NoCXviFc03S0b7Km8cDr8rngwSx/t/5HChybelH/bKmcGYu45ol28CLmy70qOTWR+suFW89o/cd+AeajiVQHGWBzzRcvBIEJL0NZeHu9j7z96ETmIKv5SUd44YVvcgp9WktugADcB9ePBZ5jUfzWjiBO3ieHwUolJJOzLX3214iS/CPdkxGLPzsHRMzio7uRNGD1CTV0MiNsbQJVq04NrwqUwgLWbQ7wGahzAVMs5wSq8cMJDBOb2vw2+2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBEhQQuaVGjQ02gNznshBOHdt6RneQX+ZuYq0okzEpk=;
 b=JMZnkj8wzerED5xFDmtD2wgY9fVhAMDJibFxD9s7nCo/fRdl07MspiSrZ3YHZc17s3BN9XdiJTD77oh9ZiNzs1/EKmP7XbNkbFeU3V66FB/iCA/o6oN7ptgkuvYlXh1IZb4nmzILxE+U9TFEhSsZhjyJlOHDaLi42xk/SCr7Bj0=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.14; Thu, 16 Jun 2022 03:36:51 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::8022:6c38:2e9f:6c9b]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::8022:6c38:2e9f:6c9b%6]) with mapi id 15.20.5332.022; Thu, 16 Jun 2022
 03:36:51 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd: Don't show warning on reading vbios values for
 SMU13 3.1
Thread-Topic: [PATCH] drm/amd: Don't show warning on reading vbios values for
 SMU13 3.1
Thread-Index: AQHYf/oxOpVTXD3PqEqxQO9NiVSuLq1RXdgAgAAFrTA=
Date: Thu, 16 Jun 2022 03:36:51 +0000
Message-ID: <DM6PR12MB2619BCDB033015C60FC6953BE4AC9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220614142220.19188-1-mario.limonciello@amd.com>
 <CADnq5_PrgkeJvrGoYPNCEe3J1gYFB5G94W-j1yaCRViKGm9Stg@mail.gmail.com>
In-Reply-To: <CADnq5_PrgkeJvrGoYPNCEe3J1gYFB5G94W-j1yaCRViKGm9Stg@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-16T03:36:47Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=28d5e772-52c0-4605-83d2-0ecec245d606;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 314f4603-0cd5-4773-8dd9-08da4f49734d
x-ms-traffictypediagnostic: MN2PR12MB4343:EE_
x-microsoft-antispam-prvs: <MN2PR12MB43434A559107D5E306CB65D4E4AC9@MN2PR12MB4343.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: maYXnBi2vSZgYv3SRgYxFgKMUJAq2+jNttUXx41gkA98POOfHRqsnUn9FE5Dy3Mfz9+RsrTfIkTEtvk9CoE4jyq/HBtRwbqWKqCD0Z8SknejhrVofUUEbb3eBswHT2q+OBqMdu/ggbfOGWq/vm92oDNcJItD9q4bmt0PUE3XU0MPHLtgQYVEwhA4JOa9BilBR6TxvyS4UUatfe5Pcjj9gxnCVyNKLH83iptyCDpfYPBrZkNcGSd4/NpcyOPyHy8wQcU03nD1bwMHmXx8oKq7l72ZIFxQqr4pJWZikqmaqFW4mk+FQTm6dwRxzmanCR2g59TCKXWcYSMs1Bp7ebep/7fqzeb/3f4STVZ83jQKVPaVZJ127eHxxR9Qpq4nyfMEd+Wa04bBgqWDBoh9wZd7kwFKXlRm+vdaVE3Mv3HthSzGKWYbHekp8VoBdM4602cj9/C3KetQe+foqOBbrO5mRQ0rcai3hsvI6/JtSCTXbn2st4MFQ+T1Cj9uZIJgrWL7sgIoLVohIss2m4nCAPRCyK19wIJzoLYE/B7KcquP5dr4ijWfU056vMcbvEwlWZXVQjNKSGp62f2frFDoa0BFJz8VUmzjfx2Zb4nC8fA3JlpvUHUw1lsnReX9DUktxffK0kGGGtQVHSCehn96ULWv9mNiXqWtYEOJE3e4TxbT5gBLAdaCGrOYih7FlC70ZypYjsTavZ+z72IsQqJL5/z1Ew==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(186003)(86362001)(6506007)(122000001)(38070700005)(26005)(7696005)(83380400001)(38100700002)(55016003)(52536014)(6636002)(71200400001)(8676002)(53546011)(4326008)(508600001)(64756008)(2906002)(9686003)(66556008)(66476007)(66946007)(110136005)(8936002)(76116006)(316002)(66446008)(5660300002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFd3L1lINXozVDhiMEFJSENQR2FDb3R3cmVPUTgwYUt3UTZxS0FRZ1QrNFZB?=
 =?utf-8?B?S21jOGJVdVQ2QmdITjY5QmlhbHNOamJJbHBxUVIyWkNFNlIxWFFRZ1BHdnBj?=
 =?utf-8?B?bEUzVHhpd3NTZGJvOEdNVTZoZkRoanFQd1plQWVsTEo3dkhDWldsSlRhR2F6?=
 =?utf-8?B?Z3ZHNHFmcjhzOHJ5Tlc3YmxrKyt5Z3BnaXpWVXVvM0dPa2lqeHZrdWJ4VVVW?=
 =?utf-8?B?NHNLTXVLWTdnODgvbEVJdnFURjNONldlRHZNTERhaUx6QVpjWVdHM2Q0RTV2?=
 =?utf-8?B?cUlsVDRnaUptekNHWVpZY3NzVG5OdDdpdTlsSStCODB4NktVR2MrcUJab3Qw?=
 =?utf-8?B?MXVLNWtuVTRKL0tLaDFlNUxhUC9LZGhUcXNyMXNMS3lKRS9SdXU5VkJiMTZO?=
 =?utf-8?B?TmdVdytOeU1uMmthWis4QXFkSERTZmw4MDA4dzNDT1BzdjBjamRMNnFzTG5l?=
 =?utf-8?B?WDdYSlYwR1NmMlBSOXNmTUlVUThPVlFPQzJyNk5MOW45eGVPZTV3SlRaU244?=
 =?utf-8?B?c2F1K2pwYlN1SlNTbHhWdmQrekJQVUtnS3RRM2EzWEZyN3R5MWFocFZmWGs2?=
 =?utf-8?B?NGM2QTJiOEpOeEwzL2YyU3FMb1Zvd3hYQ0o1OUhCeUJ0UUVRRTAwMk04Z0ZF?=
 =?utf-8?B?UVpyZ1BEblVnVDZkdUNZbmVYeEFGVVZNdzRsdXg2WUNaOTlzVW1DMWtRSWRl?=
 =?utf-8?B?TkRZeEN2WExVWWVpKzJwSEdsY1VVWkVLejlkZm9ya2c1SENnU1pJZDkwNUxk?=
 =?utf-8?B?VUlyWjc0d3pIRjZIRExEOUowOC90WHBWNU83dy8zSzhlVzhERlZ2cnhUQlp5?=
 =?utf-8?B?SGFWU3ZjL0hsN29oQ0k5dmRJdHN0eHIwb29vMno2TlFSSjh6clh4b3Y1SEdl?=
 =?utf-8?B?ZUZ3bnppSGZDM0pEd1JmTUNIdWZPY1pkNm9Uazh0N0IwUkdKcy9JSFNDMGpS?=
 =?utf-8?B?RmZhMmZsd2xuZWRRb0g3S1VFOURmTTIwd25NbHYrN0wybjNxb3RzWksrWkFJ?=
 =?utf-8?B?bkhtT1pXSDY0MnBvZG9McGtSWk9PRzdoTC9hdWpJM2VTTE8yNis2NmgyWFAv?=
 =?utf-8?B?MzdPN2JPVFh5VE84REpGZmV4MlpxcmFWSHA1K1RYSnNjZHdrYmpaT2owQVVo?=
 =?utf-8?B?alNYakhkTGswdWQycHRVdU5HQ3FUMkRpWG05R2hxUHZZZUg1TURWNjdjYkJx?=
 =?utf-8?B?SkhOV2w4Sk41S2ZzZUZJcUlxeit1VzVhRHdIZWlyWldCUkkxKzZCbkhoNjMv?=
 =?utf-8?B?dmZhU1BaYlBCMlBsOVF2UCsrUGRRTTkyVEhiNnNpRmFGYXY2ZFU3ZnFIY0l5?=
 =?utf-8?B?ZTU4WEJHQ2xkT1QvK0IxQUZxMW5UVldTVlNCYmc2bk1DQnpkU3VDOWZWQ2FO?=
 =?utf-8?B?MWJnT3NaSXkwN3ZoZFJVUDV1Z2lVNzQ4QWlvWDhhZG8zbGF0YnorSWJ3cDg5?=
 =?utf-8?B?NHBucHJiNTdXZkRWcXdWQUx5Z1IyRXFKaTZEaCs5WkUzQ0FBTHY5RWJOT2J2?=
 =?utf-8?B?b09YSGR1WWZsUkVMR2Z5Wndvd0JCZ1kvcEVmMG51SUJrT1VGdFJBMTlyTEU4?=
 =?utf-8?B?UEJhcGpaUUh5Z0ZJN3JhaVJHUU4rajliNU5zSStYWHcrTWZuSGZMMXM4NmZC?=
 =?utf-8?B?UEQxT0RpbVFIaE9lbW00RHZnN1pURCtSYkEraWQzWDNDSUI3dmF4S2FFOTNL?=
 =?utf-8?B?UzFTbFNLdXp2OGtIQWQ1SkdZN01rWjRMVnBGUHJRbmFjOENjcWE2NUdVbDJq?=
 =?utf-8?B?Wk92WnFicjBCTXZkckprTmM1VGJENkp5U2tWSVRtb1IwZkptZHZiOUhLZ3ll?=
 =?utf-8?B?aWZxSC85dGI2N1J2UTNFQVp5R2VpWlJtcmU5QnRkVE9HQW5JbnpwQjV5Wlcx?=
 =?utf-8?B?cDkrZnBERElzaU1jbmExanJwTG5JNE02dWdxOHNhcCtDTXhoNSt3dkJ2ODdK?=
 =?utf-8?B?SnZqdjU4RmtZNmpTTm5OSkdKS0dITHNMYkd3bGdNSkJlcWh2Mzg1OHM2cStD?=
 =?utf-8?B?czduSERBNjUyRFdzR2hqekg2bWppTlQ0YTRRZGJ1ZHNYWG9vYkJBdTNnWS9T?=
 =?utf-8?B?UFRwWllUanRCUVpWZkp5QmRJTzkxWkJ0Qy9ucVZXSndCQityRzdZd0UyeXpp?=
 =?utf-8?B?anRabHdOTkQ4ZGREVUFVRFBBWEZNaXBQWUpzamtnVVpwTEV4c00ydmxJRGZO?=
 =?utf-8?B?OEk1Vk12dEoxaGFmVW1uWDBwWEJaQWNzMHRFbFMxd2xrWmhubXhzMHJobUI3?=
 =?utf-8?B?U05qSVlIdDVSZzB2VzdIbW52UkdMejI4dWFHYWM2YXMzdVdtWm40L1lDWGo2?=
 =?utf-8?Q?CIPftLuPRZ2rKaKWQE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 314f4603-0cd5-4773-8dd9-08da4f49734d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 03:36:51.1547 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BeX2NE+cj57S/ePXB5Roisej4+UxMwomtnMX8Cw5gSDOIrq5sMRQBuS6ri0QVoTk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoYW5rcyBmb3IgdGhlIGZpeC4g
WWVzLCB0aGUgc3VwcG9ydCBmb3IgQVBVcyB3YXMgbWlzc2luZyBmcm9tIHRoZSByZWxldmFudCBj
b2RlLg0KSSB0aGluayB5b3UgY2FuIGp1c3QgZHJvcCB0aGUgcGllY2Ugb2YgY29kZSBiZWxvdy4N
Ci8vLy8vLy8vLy8vLy8NCmVsc2Ugew0KICAgICAgICAgICAgICAgICAgICAgICAgZGV2X3dhcm4o
c211LT5hZGV2LT5kZXYsICJVbmV4cGVjdGVkIGFuZCB1bmhhbmRsZWQgdmVyc2lvbjogJWQuJWRc
biIsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAodWlu
dDMyX3QpZnJldiwgKHVpbnQzMl90KWNyZXYpOw0KICAgICAgICAgICAgICAgIH0NCi8vLy8vLy8v
Ly8vLy8NCkVpdGhlci13YXkgdGhlIHBhdGNoIGlzIHJldmlld2VkLWJ5OiBFdmFuIFF1YW4gPGV2
YW4ucXVhbkBhbWQuY29tPg0KDQpCUg0KRXZhbg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiBGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDog
VGh1cnNkYXksIEp1bmUgMTYsIDIwMjIgMTE6MTIgQU0NCj4gVG86IExpbW9uY2llbGxvLCBNYXJp
byA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IFF1YW4sIEV2YW4NCj4gPEV2YW4uUXVhbkBh
bWQuY29tPjsgRmVuZywgS2VubmV0aCA8S2VubmV0aC5GZW5nQGFtZC5jb20+DQo+IENjOiBhbWQt
Z2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIXSBkcm0vYW1kOiBEb24ndCBzaG93IHdhcm5pbmcgb24gcmVhZGluZyB2YmlvcyB2YWx1
ZXMNCj4gZm9yIFNNVTEzIDMuMQ0KPiANCj4gT24gVHVlLCBKdW4gMTQsIDIwMjIgYXQgMTA6MjIg
QU0gTWFyaW8gTGltb25jaWVsbG8NCj4gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4gU29tZSBBUFVzIHdpdGggU01VMTMgYXJlIHNob3dpbmcgdGhlIGZvbGxvd2lu
ZyBtZXNzYWdlOg0KPiA+IGBhbWRncHUgMDAwMDo2MzowMC4wOiBhbWRncHU6IFVuZXhwZWN0ZWQg
YW5kIHVuaGFuZGxlZCB2ZXJzaW9uOiAzLjFgDQo+ID4NCj4gPiBUaGlzIHdhcm5pbmcgaXNuJ3Qg
cmVsZXZhbnQgZm9yIHNtdSBpbmZvIDMuMSwgYXMgbm8gYm9vdHVwIGluZm9ybWF0aW9uDQo+ID4g
aXMgcHJlc2VudCBpbiB0aGUgdGFibGUuDQo+ID4NCj4gPiBGaXhlczogNmE3MzQ1NDM1MGMwICgi
ZHJtL2FtZC9wbTogY29ycmVjdCB0aGUgd2F5IGZvciByZXRyaWV2aW5nDQo+ID4gYm9vdHVwIGNs
b2NrcyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9u
Y2llbGxvQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dz
bXUvc211MTMvc211X3YxM18wLmMgfCAyICsrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3
c211L3NtdTEzL3NtdV92MTNfMC5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211
L3NtdTEzL3NtdV92MTNfMC5jDQo+ID4gaW5kZXggZjE4Zjk2MDVlNTg2Li4wZTU5YWIyMTkyYmYg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVf
djEzXzAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211
X3YxM18wLmMNCj4gPiBAQCAtNzMxLDYgKzczMSw4IEBAIGludCBzbXVfdjEzXzBfZ2V0X3ZiaW9z
X2Jvb3R1cF92YWx1ZXMoc3RydWN0DQo+IHNtdV9jb250ZXh0ICpzbXUpDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgc211LT5zbXVfdGFibGUuYm9vdF92YWx1ZXMudmNsayA9IHNtdV9pbmZv
X3YzXzYtDQo+ID5ib290dXBfdmNsa18xMGtoejsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICBzbXUtPnNtdV90YWJsZS5ib290X3ZhbHVlcy5kY2xrID0gc211X2luZm9fdjNfNi0NCj4gPmJv
b3R1cF9kY2xrXzEwa2h6Ow0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHNtdS0+c211X3Rh
YmxlLmJvb3RfdmFsdWVzLmZjbGsgPQ0KPiA+IHNtdV9pbmZvX3YzXzYtPmJvb3R1cF9mY2xrXzEw
a2h6Ow0KPiA+ICsgICAgICAgICAgICAgICB9IGVsc2UgaWYgKChmcmV2ID09IDMpICYmIChjcmV2
ID09IDEpKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+IA0KPiBJ
IGRvbid0IGtub3cgaWYgRXZhbiBoYXMgYW55IGNvbW1lbnRzLCBidXQgaXQgbWlnaHQgYmUgYmV0
dGVyIHRvIGp1c3QgcmV0dXJuIGlmDQo+ICgoZnJldiA9PSAzKSAmJiAoY3JldiA8IDIpKS4gIEkn
bSBub3Qgc3VyZSBvZmYgaGFuZCB3aGljaCBzbXVfaW5mbyB0YWJsZQ0KPiB2ZXJzaW9ucyB3ZSBt
aWdodCBydW4gaW50by4gIEV2YW4gb3IgS2VubmV0aCB3b3VsZCBrbm93IHdoaWNoIHNtdV9pbmZv
DQo+IHRhYmxlIHZlcnNpb25zIGFyZSB2YWxpZCBvbiB3aGljaCBTTVUgMTMueCAgYXNpY3MuDQo+
IA0KPiBBO2V4DQo+IA0KPiANCj4gPiAgICAgICAgICAgICAgICAgfSBlbHNlIGlmICgoZnJldiA9
PSA0KSAmJiAoY3JldiA9PSAwKSkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHNtdV9p
bmZvX3Y0XzAgPSAoc3RydWN0IGF0b21fc211X2luZm9fdjRfMA0KPiA+ICopaGVhZGVyOw0KPiA+
DQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0K
