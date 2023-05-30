Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDA8C7EE23
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 18:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7C3E10E3F7;
	Tue, 30 May 2023 18:37:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 654EA10E3F7
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 18:37:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bd8kRu4UWjL2XJCkhrlpvyAWmfbnUhIGTivqmtQTdPEvs437wNdvc4JE2Kt7lhK+xZ4mIy5mVHYrHMRD0qgsgD8jIyPhNkaIDmB0OgHFwMN3ijWdf70GHoLBn+aZTzePSAV9/y4K54j5X6VsQZm1/BvdiADNbJTH3/vadRfUqW+HjcdFK3m2h5g2DBnLM3xVnyLm9GHwjQyMbQE+F5rLGQ5Lr4Btp9OpopMcnXStOzl4tLaYQbVPlomPmrS6+va70toC3NklHLAoke+2DnfgpjHuBnEvvqx+p6k/2an6gKPX/FMoM1cSxcv3lPaDqIi/JQ/jwG6NP3bUjTQQ1Yo48A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E05+lWm+N7yLD/o8m7Q9OXIUwL1Hu0TJ57hdzIIjFsU=;
 b=fgV3htvHmrqn+iw7PdWJymcZJv81V1m67xNn4riOLv0//yfDaXBWbDtql9S2NOE+dAgVpWW6g+cFLFxCQAib9p1LxOZ0qgOKQNb1VEEdnmYGmhh/7bgcfY0PBs9btr3iKhyQG6JLPtRp4lCzccfGazGf6G+Jp31/L5iJUhaVPw1gNWFVh6goWt93Exdg2jJGlb3FXuIJdj0DFjZARIz/HWG2hxq2XDTKrH5JO6KEepruuBaEbC+xvDAKnyV5Xfo0uKHxu9IS3rZGT/INdOud+tg6f/KuQkTs31XUqS0bDffnchKYCYUbQ+COOlD20/cuyHKybpfdS51r8N1H7gbFMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E05+lWm+N7yLD/o8m7Q9OXIUwL1Hu0TJ57hdzIIjFsU=;
 b=kAX5SbPKLHGMBXfCGP4eiP2phzefICvS/JwL/Ti7SzSAd1jsEAZUvpySz9qEb+b5/lk5JhlygL/TvqSg8m0zqXKUtcBmt9pnh2/bW8MfLgC+vHQirkhfI/6BJ9J1XvYHxGo7VK6AED4tsG63dg3Ox3avIeIAS94PKbwWobenyOw=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB5862.namprd12.prod.outlook.com (2603:10b6:8:79::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.16; Tue, 30 May 2023 18:37:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527%5]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 18:37:39 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: =?utf-8?B?UmFmYWVsIMOBdmlsYSBkZSBFc3DDrW5kb2xh?= <rafael@espindo.la>, Alex
 Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 1/2] drm/amd: Disallow s0ix without BIOS support again
Thread-Topic: [PATCH 1/2] drm/amd: Disallow s0ix without BIOS support again
Thread-Index: AQHZkx+fEuCfTGHpmkuMETcUQUBT869zH0GAgAAATXCAAAPzAIAAASeA
Date: Tue, 30 May 2023 18:37:39 +0000
Message-ID: <MN0PR12MB61011F391B26F7AB87D30D99E24B9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230530175301.231070-1-mario.limonciello@amd.com>
 <CADnq5_M8XdDsyn0q-mM4CfFoMHH6g54VP_SG4cNztEYAwwB_hg@mail.gmail.com>
 <MN0PR12MB610183E9EC20D68FE3670D24E24B9@MN0PR12MB6101.namprd12.prod.outlook.com>
 <87ilc9acyl.fsf@espindo.la>
In-Reply-To: <87ilc9acyl.fsf@espindo.la>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1328bbe3-0c8c-4640-a93c-cff78d203354;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-30T18:35:04Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DS7PR12MB5862:EE_
x-ms-office365-filtering-correlation-id: 7d557cd8-01e0-4c4d-59cf-08db613cf21e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rCV9yeiNOw7gFfwRodlZASe/rfmT9WMUMUvxLAGWE3c+LlCrK7fUYiwx05mee/xJCyxgEr5mUV5G/kwFRgqVWRRqHsf9t1tj712tF54Z7xOU/g5iFlt0VtYxSGfGgyu2xjxnuA0w/QyonZiWDg8bMUNV1MFC7FXpA75F5VeTW9WCyaCIDGOFmnsw9Fs8ZUQsB6BPVaQfffV7o/ENPIKL7+QU2q0S78hD8Rq88ITGwbqHOkFJIS96Eft8rTR0jKaqyW5HpKVrPWkTur8P5rAL4w9aFxpSEHThOtoaphNkvvC/Kh/DNZHeaIJzGvjsIfiCNaTZIWl+BFWVInBhRZL8AQc/VkY5DnouRrieqsjb2vgYFT2NZXbi5TBrklTWv1pI6x0NGyDCeueSP6pzC4q05TP5NfVDoLcpM/1mjhcCQ4/UIDcEvvlzbx2ZkF6iXljE3SpXpB7HRVuHwM5LIWA8IW0C7xW+z4oLwEmRrw0d69ybeBYdYlhSHdFo3zcMdYBSe0/p9vzhWethXgMIpmB5PDnZ8xxGBrMqVLBmLUt5gJCOKlsASXQxscjH+4scm5CKNZlp2q1dKgOUZ4sayen7zflZxIoC4DcBQCGjnxQK4/aNnyQzyLk63yqyF11VwtgS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199021)(122000001)(41300700001)(7696005)(26005)(83380400001)(38070700005)(66574015)(6506007)(2906002)(9686003)(53546011)(186003)(33656002)(86362001)(966005)(38100700002)(55016003)(52536014)(5660300002)(66556008)(8676002)(66476007)(8936002)(76116006)(66946007)(4326008)(66446008)(64756008)(110136005)(478600001)(71200400001)(66899021)(316002)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzZpZ2plamdVRWE4ZWhSSU9JVDRMUTZKeEk3MWJCcVFhbnNwOHhUNi9senJs?=
 =?utf-8?B?cFpzeXlMcDVFNGlPL3lic3I0Z043S0RlTW9tQXJWeXYrbDBXRXNFOW5hcTBx?=
 =?utf-8?B?SklleXNlMG5pek53ZFZ4NU5SbVNzRldUZC9OMlZ0Vi9RYjZrNUxRZ3FKNnpz?=
 =?utf-8?B?ZzZQVWdwajVqalNRK3U0R0J0VGRCMjk2dS8rVVdGY3l4dDhicklFU3JrQ29I?=
 =?utf-8?B?MFJUajh4REFSK1dXeVNNY1dSY1YyTk1PMUVENm1WeVlmSlkwUERoY2tnSEEz?=
 =?utf-8?B?djdkNzhOR1kveGNzT0N3RWVOOVkwckxRNDAzN1pLUmFmU1RXNWl3clhySFpP?=
 =?utf-8?B?dHdNbWJHZGR2SWcxTkFBbWpCVkJFdG9Xa255UjFQQVhJeng0bEllTnNhbGgz?=
 =?utf-8?B?STh6N211a2ViSUZ4VXJXeXlNUk45RWpMYnZKc05wWDU5U096b2VIN2htU2pZ?=
 =?utf-8?B?dGNzaCtsU0pYZkU5MEFwcHdCTjlWK09yYUVUcG02by8wTzl2VHpQcWdMakdQ?=
 =?utf-8?B?aXBqRjBhazY2SnlsMUJJKy9oVzF5NHAyTHVNL0FZK2xOREUxdGQ3UEx1K2x5?=
 =?utf-8?B?dTg2amMzNkZESXZPVWl1OWJNY2Q1NmhKR3lFU00zTXNzYUs1bDhjcDFmb2dH?=
 =?utf-8?B?R2Z0Ymh1UEVjV1AxYm1la2FRZ1huY0dzekJsWWt6eENaOWxuangwM0NsL0Zr?=
 =?utf-8?B?M0ZFSWpkdnJaZWx6aEk3Z0ZDakVLelJDNkRxeDdlamZsN1pvdXJqcXJZUHVo?=
 =?utf-8?B?K0tPRDNseE5mL0Nocm9vcXhMQkhSYkRwNmxxQ1M3eDRCUzRlVjhJZjRJbWY4?=
 =?utf-8?B?VWl4SmxOUE1SaVZ3cXhZanZnczl4R2h6ekZiak1rTU4rL1BmNEo1VFRTaWNG?=
 =?utf-8?B?aGNSM3N6ZVhZWWF4dTdQV1pVdXlnMEJxaEsrNFJnOTFRTkF0djhMbWRPMU9n?=
 =?utf-8?B?WXM3emhjbXNQK1puUFdkTmhFSFZIT3V4Tko3c3ZLN1A1Sjh6WUhDc2tvamYy?=
 =?utf-8?B?VGpQcFNXaFBKZVNZUEVmbm15RnNrMGE5dktncnA2NVl2QXBOaWswbmxrYXd0?=
 =?utf-8?B?RFM3endEY0dTT0JKZW9xZmJOQzJxdnBTMklaZ3FvQnljV3lmM1R3ak1IZVJi?=
 =?utf-8?B?T3E3aGR5dk1RL2w5MVhOanN4d3IyVW80dHRVUTNsVUJSUGkzK3BRemJrZ2gr?=
 =?utf-8?B?c3pyNG84b3JjaTloMjlrNzFYZ3pBczIxYkVNQmV2NW1Jc0VUT1p5S0M2K2ZH?=
 =?utf-8?B?WElLRURiYWwrZDNINk05bVFldnBjMXBSWndVN2FibVUrRjdWaHJERmhJUGto?=
 =?utf-8?B?Vk1TbXQ0dzBnMG9INS91K2xZTVhNWjE0U1RmaWx2WnlHYXBiS0dFR2JhQUtq?=
 =?utf-8?B?VW5qMFZadlRBaDZ5czR1TkVTMllkWFM0SDZIbmYraWRJUzkvRXZoZFpLU3hT?=
 =?utf-8?B?ZUxmcXdXdDl0U0ZDTUpiUis2NUdLZDZxcnNOYS9hb3l0cXZkT3BmaGVhbFZ3?=
 =?utf-8?B?OVVlYkZsR05aZzFZa2FRSjJpSEVWNDZOR2hqYmxZNVF5eFYvZ1JURGdYMFBj?=
 =?utf-8?B?aVVqcmZXK3d1OGtkUDAySlNEWmphdHBOaGRzVzhoMUZvd3BlTUpQUWhTNVBa?=
 =?utf-8?B?NitsdFBWWXVRb1ovejZsSGFpN1FPK2hzb3M1SnJRd21RRm55QTBBdHp6V3Uy?=
 =?utf-8?B?S2txWXdQaGlGWGFzUzdkN0ZFSFQ1dWtsY2RNZ1AzUDhSeWFJcGZUTUprRXF0?=
 =?utf-8?B?ZTk0OXdBZkJaVUlVY3JGVEtCakFuNDFUbTZybGFqdXFsT3JpRm0xTHNHdVRM?=
 =?utf-8?B?aEFUSis1SjRSTG5HUFh0bHpVT1QxMDU5cEtzYVhtWEhvZ3VsWUc3bkVSVlAy?=
 =?utf-8?B?dWEybmhJRmZLNUE2SVN3SWJwSjdGVy8yL2twaVhRbVVSZEM2K1Fzb3VITm51?=
 =?utf-8?B?YW1rVVJjOHRPZEhSOFFyMFJCTGllcHVUSGVrWHorUEVHM1dieEpWK1hYUUhR?=
 =?utf-8?B?OUN1R2VaZjlZM0laRmNmNWNTNGswd2ErNVIzSnE3b2l6bDZCaVpuOEtzVGlD?=
 =?utf-8?B?VHVoK2dkZjNjTDk5NlAxSUFDYmxJS2JpbUFveHhYeWpDOVZOcUNCdUg4RzZR?=
 =?utf-8?Q?ltAw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d557cd8-01e0-4c4d-59cf-08db613cf21e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 18:37:39.1111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VZ68WzBQaeOLmZw9iJagcrZUPIK18JQfwO/LFU12JQ+oRPYJJM8E447bC4GFrMHpU/717XMG+mE0YjajbFSDGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gQXMgZmFyIGFzIEkga25vdyB0
aGUgIm5vIFMzIGlmIFNNVCBvZmYiIGlzIGp1c3QgYW4gb2RkaXR5IG9mIHRoZQ0KPiBwYXJ0aWN1
bGFyIEJJT1MgSSBnb3Qgb24gdGhlICJCNTUwSSBBT1JVUyBQUk8gQVgiLg0KDQpJbiB0aGF0IGNh
c2UsIG1heWJlIHRoZSBtZXNzYWdlIHNob3VsZCBiZSBkb3duZ3JhZGVkIHRvIElORk8sIGFuZA0K
b25seSBzaG93biBpbiB0aGUgY2FzZSB0aGF0IHMzIGlzIG5vdCBzdXBwb3J0ZWQgb24gQVBVcy4g
IFRoaXMgd2lsbA0KbmFycm93IGl0IHF1aXRlIGEgYml0IHRoZW4uDQoNCj4NCj4gQWxzbywgd2hh
dCBoYXMgY2hhbmdlZCB0aGF0IHdvdWxkIHByZXZlbnQgdGhlIHNhbWUgaXNzdWUgSSB3YXMgaGl0
dGluZw0KPiBiZWZvcmU/Og0KPg0KPiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJt
L2FtZC8tL2lzc3Vlcy8yMzY0I25vdGVfMTczNTQyMg0KPg0KDQpUaGlzIGNvbW1pdCBpbiA2LjM6
DQpjYTQ3NTE4NjYzOTcgKCJkcm0vYW1kOiBEb24ndCBhbGxvdyBzMGl4IG9uIEFQVXMgb2xkZXIg
dGhhbiBSYXZlbiIpDQoNCj4gQ2hlZXJzLA0KPiBSYWZhZWwNCj4NCj4gIkxpbW9uY2llbGxvLCBN
YXJpbyIgPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+IHdyaXRlczoNCj4NCj4gPiBbQU1EIE9m
ZmljaWFsIFVzZSBPbmx5IC0gR2VuZXJhbF0NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+PiBGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4N
Cj4gPj4gU2VudDogVHVlc2RheSwgTWF5IDMwLCAyMDIzIDE6MTYgUE0NCj4gPj4gVG86IExpbW9u
Y2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4NCj4gPj4gQ2M6IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBSYWZhZWwgw4F2aWxhIGRlIEVzcMOtbmRvbGENCj4g
Pj4gPHJhZmFlbEBlc3BpbmRvLmxhPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gZHJt
L2FtZDogRGlzYWxsb3cgczBpeCB3aXRob3V0IEJJT1Mgc3VwcG9ydA0KPiBhZ2Fpbg0KPiA+Pg0K
PiA+PiBPbiBUdWUsIE1heSAzMCwgMjAyMyBhdCAxOjUz4oCvUE0gTWFyaW8gTGltb25jaWVsbG8N
Cj4gPj4gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+IHdyb3RlOg0KPiA+PiA+DQo+ID4+ID4g
Y29tbWl0IGNmNDg4ZGNkMGFiNyAoImRybS9hbWQ6IEFsbG93IHMwaXggd2l0aG91dCBCSU9TIHN1
cHBvcnQiKQ0KPiA+PiBzaG93ZWQNCj4gPj4gPiBpbXByb3ZlbWVudHMgdG8gcG93ZXIgY29uc3Vt
cHRpb24gb3ZlciBzdXNwZW5kIHdoZW4gczBpeCB3YXNuJ3QNCj4gPj4gZW5hYmxlZCBpbg0KPiA+
PiA+IEJJT1MgYW5kIHRoZSBzeXN0ZW0gZGlkbid0IHN1cHBvcnQgUzMuDQo+ID4+ID4NCj4gPj4g
PiBUaGlzIHBhdGNoIGhvd2V2ZXIgd2FzIG1pc2d1aWRlZCBiZWNhdXNlIHRoZSByZWFzb24gdGhl
IHN5c3RlbSBkaWRuJ3QNCj4gPj4gPiBzdXBwb3J0IFMzIHdhcyBiZWNhdXNlIFNNVCB3YXMgZGlz
YWJsZWQgaW4gT0VNIEJJT1Mgc2V0dXAuDQo+ID4+ID4gVGhpcyBwcmV2ZW50ZWQgdGhlIEJJT1Mg
ZnJvbSBhbGxvd2luZyBTMy4NCj4gPj4gPg0KPiA+PiA+IEFsc28gYWxsb3dpbmcgR1BVcyB0byB1
c2UgdGhlIHMyaWRsZSBwYXRoIGFjdHVhbGx5IGNhdXNlcyBwcm9ibGVtcyBpZg0KPiA+PiA+IHRo
ZXkncmUgaW52b2tlZCBvbiBzeXN0ZW1zIHRoYXQgbWF5IG5vdCBzdXBwb3J0IHMyaWRsZSBpbiB0
aGUgcGxhdGZvcm0NCj4gPj4gPiBmaXJtd2FyZS4gYHN5c3RlbWRgIGhhcyBhIHRlbmRlbmN5IHRv
IHRyeSB0byB1c2UgYHMyaWRsZWAgaWYgYGRlZXBgIGZhaWxzDQo+ID4+ID4gZm9yIGFueSByZWFz
b24sIHdoaWNoIGNvdWxkIGxlYWQgdG8gdW5leHBlY3RlZCBmbG93cy4NCj4gPj4gPg0KPiA+PiA+
IFRvIG1ha2UgdGhpcyB0aGUgYmVoYXZpb3IgZGlzY292ZXJhYmxlIGFuZCBleHBlY3RlZCwgcmV2
ZXJ0IGNvbW1pdA0KPiA+PiA+IGNmNDg4ZGNkMGFiNyAoImRybS9hbWQ6IEFsbG93IHMwaXggd2l0
aG91dCBCSU9TIHN1cHBvcnQiKSBhbmQgb2ZmZXINCj4gPj4gPiBhIG1lc3NhZ2UgaWYgU01UIGFw
cGVhcnMgdG8gYmUgZGlzYWJsZWQuDQo+ID4+ID4NCj4gPj4gPiBDYzogUmFmYWVsIMOBdmlsYSBk
ZSBFc3DDrW5kb2xhIDxyYWZhZWxAZXNwaW5kby5sYT4NCj4gPj4gPiBMaW5rOg0KPiA+Pg0KPiBo
dHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi92Ni4xL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1DQo+ID4+IC9hbWRncHVfYWNwaS5jI0wxMDYwDQo+ID4+ID4gQ2xvc2VzOiBo
dHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy8yNTk5DQo+ID4+
ID4gU2lnbmVkLW9mZi1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFt
ZC5jb20+DQo+ID4+ID4gLS0tDQo+ID4+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9hY3BpLmMgfCAxNiArKysrKysrKysrKysrKy0tDQo+ID4+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAxNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+PiA+DQo+ID4+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3BpLmMNCj4gPj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwaS5jDQo+ID4+ID4gaW5kZXggM2E2
YjJlMjA4OWY2Li5hMzUyM2QwM2Q3NjkgMTAwNjQ0DQo+ID4+ID4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FjcGkuYw0KPiA+PiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3BpLmMNCj4gPj4gPiBAQCAtMjgsNiArMjgsNyBAQA0KPiA+
PiA+ICAjaW5jbHVkZSA8bGludXgveGFycmF5Lmg+DQo+ID4+ID4gICNpbmNsdWRlIDxsaW51eC9w
b3dlcl9zdXBwbHkuaD4NCj4gPj4gPiAgI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4g
Pj4gPiArI2luY2x1ZGUgPGxpbnV4L3NjaGVkL3NtdC5oPg0KPiA+PiA+ICAjaW5jbHVkZSA8bGlu
dXgvc3VzcGVuZC5oPg0KPiA+PiA+ICAjaW5jbHVkZSA8YWNwaS92aWRlby5oPg0KPiA+PiA+ICAj
aW5jbHVkZSA8YWNwaS9hY3RibC5oPg0KPiA+PiA+IEBAIC0xNDczLDYgKzE0NzQsMTMgQEAgdm9p
ZCBhbWRncHVfYWNwaV9yZWxlYXNlKHZvaWQpDQo+ID4+ID4gICAqLw0KPiA+PiA+ICBib29sIGFt
ZGdwdV9hY3BpX2lzX3MzX2FjdGl2ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gPj4g
PiAgew0KPiA+PiA+ICsjaWZkZWYgQ09ORklHX1g4Ng0KPiA+PiA+ICsgICAgICAgaWYgKCFzY2hl
ZF9zbXRfYWN0aXZlKCkpIHsNCj4gPj4gPiArICAgICAgICAgICAgICAgZGV2X3dhcm5fb25jZShh
ZGV2LT5kZXYsDQo+ID4+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIlNNVCBpcyBk
aXNhYmxlZCBieSB0aGUgQklPUy5cbiINCj4gPj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAiVG8gdXNlIHN1c3BlbmQtdG8tcmFtIGVuYWJsZSBTTVQgaW4gQklPUyBzZXR1cC5cbiIp
Ow0KPiA+PiA+ICsgICAgICAgfQ0KPiA+PiA+ICsjZW5kaWYNCj4gPj4NCj4gPj4gV2lsbCB0aGlz
IGdlbmVyYXRlIGEgc3B1cmlvdXMgd2FybmluZyBvbiBwbGF0Zm9ybXMgdGhhdCBhcmUgbmF0aXZl
bHkgbm9uLQ0KPiBTTVQ/DQo+ID4NCj4gPiBZZWFoOyBpdCBjb3VsZC4gIEknbSBub3Qgc3VyZSBo
b3cgd2UgY2FuIHJlbGlhYmx5IGRldGVjdCB0aGlzLiAgSSB0aG91Z2h0IGFib3V0DQo+IGxvb2tp
bmcgZm9yDQo+ID4gdGhlICdodCcgZmxhZywgYnV0IHRoYXQgcHJvYmFibHkgd291bGRuJ3Qgd29y
ayBmb3IgdGhpcyBjYXNlLg0KPiA+DQo+ID4gQXJlIHRoZXJlIEFNRCBaZW4gQ1BVcyBvciBBUFVz
IHRoYXQgYXJlIG5vbi1TTVQ/ICBDb3VsZCBnYXRlIHRoZQ0KPiBzY2hlZF9zbXRfYWN0aXZlKCkN
Cj4gPiBjaGVjayB0byBvbmx5IHJ1biB3aGVuIGl0J3MgYW4gQU1EIHg4NiBaZW4gU29DLg0KPiA+
DQo+ID4+DQo+ID4+IEFsZXgNCj4gPj4NCj4gPj4gPiAgICAgICAgIHJldHVybiAhKGFkZXYtPmZs
YWdzICYgQU1EX0lTX0FQVSkgfHwNCj4gPj4gPiAgICAgICAgICAgICAgICAgKHBtX3N1c3BlbmRf
dGFyZ2V0X3N0YXRlID09IFBNX1NVU1BFTkRfTUVNKTsNCj4gPj4gPiAgfQ0KPiA+PiA+IEBAIC0x
NDk5LDE2ICsxNTA3LDIwIEBAIGJvb2wgYW1kZ3B1X2FjcGlfaXNfczBpeF9hY3RpdmUoc3RydWN0
DQo+ID4+IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4+ID4gICAgICAgICAgKiBTMGl4IGV2ZW4g
dGhvdWdoIHRoZSBzeXN0ZW0gaXMgc3VzcGVuZGluZyB0byBpZGxlLCBzbyByZXR1cm4gZmFsc2UN
Cj4gPj4gPiAgICAgICAgICAqIGluIHRoYXQgY2FzZS4NCj4gPj4gPiAgICAgICAgICAqLw0KPiA+
PiA+IC0gICAgICAgaWYgKCEoYWNwaV9nYmxfRkFEVC5mbGFncyAmIEFDUElfRkFEVF9MT1dfUE9X
RVJfUzApKQ0KPiA+PiA+ICsgICAgICAgaWYgKCEoYWNwaV9nYmxfRkFEVC5mbGFncyAmIEFDUElf
RkFEVF9MT1dfUE9XRVJfUzApKSB7DQo+ID4+ID4gICAgICAgICAgICAgICAgIGRldl93YXJuX29u
Y2UoYWRldi0+ZGV2LA0KPiA+PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJQb3dl
ciBjb25zdW1wdGlvbiB3aWxsIGJlIGhpZ2hlciBhcyBCSU9TIGhhcyBub3QgYmVlbg0KPiA+PiBj
b25maWd1cmVkIGZvciBzdXNwZW5kLXRvLWlkbGUuXG4iDQo+ID4+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIlRvIHVzZSBzdXNwZW5kLXRvLWlkbGUgY2hhbmdlIHRoZSBzbGVlcCBt
b2RlIGluIEJJT1MNCj4gPj4gc2V0dXAuXG4iKTsNCj4gPj4gPiArICAgICAgICAgICAgICAgcmV0
dXJuIGZhbHNlOw0KPiA+PiA+ICsgICAgICAgfQ0KPiA+PiA+DQo+ID4+ID4gICNpZiAhSVNfRU5B
QkxFRChDT05GSUdfQU1EX1BNQykNCj4gPj4gPiAgICAgICAgIGRldl93YXJuX29uY2UoYWRldi0+
ZGV2LA0KPiA+PiA+ICAgICAgICAgICAgICAgICAgICAgICAiUG93ZXIgY29uc3VtcHRpb24gd2ls
bCBiZSBoaWdoZXIgYXMgdGhlIGtlcm5lbCBoYXMgbm90IGJlZW4NCj4gPj4gY29tcGlsZWQgd2l0
aCBDT05GSUdfQU1EX1BNQy5cbiIpOw0KPiA+PiA+IC0jZW5kaWYgLyogQ09ORklHX0FNRF9QTUMg
Ki8NCj4gPj4gPiArICAgICAgIHJldHVybiBmYWxzZTsNCj4gPj4gPiArI2Vsc2UNCj4gPj4gPiAg
ICAgICAgIHJldHVybiB0cnVlOw0KPiA+PiA+ICsjZW5kaWYgLyogQ09ORklHX0FNRF9QTUMgKi8N
Cj4gPj4gPiAgfQ0KPiA+PiA+DQo+ID4+ID4gICNlbmRpZiAvKiBDT05GSUdfU1VTUEVORCAqLw0K
PiA+PiA+IC0tDQo+ID4+ID4gMi4zNC4xDQo+ID4+ID4NCg==
