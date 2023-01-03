Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56309C3DA7D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 19:17:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D129710E4B2;
	Tue,  3 Jan 2023 19:17:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBBE710E4B2
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 19:17:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIqqmspXVu++ub93CAa8jcjMISU5rsChQQJUE6ZrRYCyRF4tDX/LQefKFGTyOMj900k5zEKYlS1zaNLgYL1zBbwdpLi6BMxC/907DXCRf4+QT9RhNA36OnglTUuKJ4Ak9wA7OOXmLrXUXCJYMrNTlPVsWQVfpxVo9KWyUNpZ+Qaw7bUngv7dZwXN+A6f1wWb6w/R3dhNPKqDPnke0Pr8B6awHwg3/IgGO2AobGIgZ0pcmDt8K+67BbW2JFslZYc6Y9bvYnm7NZYG1baQ9p6pObcr+AmBbfbBbGl+41TP5W2hc+/THOzhspg3TjYJtQayeJKt5anoJGuuT8NH6eBoZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lN2e17GnF7VWrSVakSJQ8qmf+atrhzqJ9/PaxZ+6z10=;
 b=dH85v390q8mXOfkYDFPtGBP3sycQudt+DNkuivmAzyGfK5GLoHRB9RTBIou2ZJrHNvC7OvojbkCXwviU+nE/8NP+DZhgWAKuIFfIS0dwcs9qCzIJqIop6QFHKd+LGi2X43W8D4rOM8jHbzWMZO6O6gYgFQLvpdC3ATOqCETslFflZMzK/WcuXLgDRlhlSouEZk+9FN9oElHxHbe4OK3fso83SkTHjZUEeG5dyp8CanptJ/Xo07yAuSWGqQ/WvPOtida3nniqVlZae8EZLwcraYZZeQJLTnUPPq9V0nyABnAubBK/vEXcqRk6fzCUJCOtm1qrJlQrn6dYxRSTprnVXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lN2e17GnF7VWrSVakSJQ8qmf+atrhzqJ9/PaxZ+6z10=;
 b=RT6HNJk9jBLJHKBrvu1gJX3SnNP2+gkZCxIJvd8TQ8y1CICEw2azW2MLYSbDzW/mv1DeyBSvLuOL7K2QGc/AnuTWRSVcP7a++eewfO0yodwa0z6lo3SZBfbLaYw60I8nlmAlCO0WCMTt8qpwIJCxYpJimujxzWAp2zK+ONbsf/0=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by PH7PR12MB5711.namprd12.prod.outlook.com (2603:10b6:510:1e2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 19:17:06 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::3fbd:bad3:3f81:dc35]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::3fbd:bad3:3f81:dc35%8]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 19:17:06 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Sharma, Shashank"
 <Shashank.Sharma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [RFC 1/7] drm/amdgpu: UAPI for user queue management
Thread-Topic: [RFC 1/7] drm/amdgpu: UAPI for user queue management
Thread-Index: AQHZFwYFMcwWgY+iQ0uqXzsdFBemE66NFLgAgAAMm7A=
Date: Tue, 3 Jan 2023 19:17:06 +0000
Message-ID: <CH0PR12MB5372BF7A0FAE2CAC070D2AB9F4F49@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-2-shashank.sharma@amd.com>
 <97583f26-81be-f6e5-ac62-45a3bca40e43@amd.com>
In-Reply-To: <97583f26-81be-f6e5-ac62-45a3bca40e43@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ffe3e1a1-8585-4f56-83de-8f81b33b3bfa;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-03T19:15:04Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|PH7PR12MB5711:EE_
x-ms-office365-filtering-correlation-id: a6a458cc-8240-4b91-f39c-08daedbf1a8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N0jdHmlVyh9xY4Nbe/zHr4jD/MNPhZuPvIgwarIQX9GDq4C3197Kxtl5xXE6ofssq6V4Az35QLGrwxM6ubClxkJPUb6UCGEuEMcslkeXafaimeJdq7wWFPZy/2NXGtJYpMuipyFy7X1synaWmaB24GtQwf7fZsaT9OdH4ZYYxflSTfH6NB/0bndFE1++l1Aqe2Ady8yjoRq6jPbDRntVXQ5OkmPmm2qqXZILYyQKuIomMuywY3PikC6fXMAeCHE4krcutJsXEEEQyMFvES0Oq7dY8s/cAUMjTp0xvs5T4PPfavUOVx0WPnOKvyxI+S/ZGlrshUM4XrOBS/3EKLqDgNBVF//UCYU+31DgEmZaX71g1vcPbCKh9jqiyPlWrd1aLg04Y6PcjTNfNmC+ipUw9oLXY8cmkk/KenF8PfuhAn5QVzay/CkqFQNNzzU5y8KRVcN1bcWw8kkKGptsba++FR1q7XNI09rBfN0QH1/Ku0qrUtvCZ/EOOML5+u5U+Zjn2yfHmykXi8dg+6gSmU+KksouZGBNjsqqSJ5/PboCsKO/bdP6Fnaz3Xt7z4txBQsvPx80+u+JgCbvncmKzI+AxqZBb2ACmaYr7aO7L1apTOQYkmtfY2VM3jEK4w+2wgP1sjKS0RkXdoP6Af9gUGStq56u44ULAYQX0XEyyG5lm6VmS7z2Qw16dUQDDJ4S1e3WbMd74u7Vr3ZQN7tE6KVM9GVwjHWvik0PKRFyCDT+0qo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199015)(64756008)(316002)(66556008)(66946007)(66476007)(8676002)(66446008)(4326008)(76116006)(5660300002)(122000001)(54906003)(110136005)(4001150100001)(2906002)(53546011)(6506007)(38070700005)(71200400001)(55016003)(83380400001)(33656002)(86362001)(52536014)(478600001)(8936002)(41300700001)(9686003)(38100700002)(26005)(186003)(7696005)(22166006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zk9PQ0VWMlNnYUJNaUd4bzRGRmlER1RxU3RKK1M2M2xmcWQ0aWsvUVVSWW5k?=
 =?utf-8?B?L1cxRW9mNDZsdWNsTTlxdjAyUUFwcFFkeEdEcDNFTWpGZW1LZ1ppTHJHNlU5?=
 =?utf-8?B?UUVyZ2FZZDFtT1Q5Q1dic0UwQ3c3UXBXeWZYS0xzblhMb1p1ZzZ4VE9FcFI3?=
 =?utf-8?B?RUtHdkY4VHRQZTJqUnU0NUN1SHZ2VTBWYXFzRHB4cEZPWHhDWS9ic2MyaXM4?=
 =?utf-8?B?bjF0U2xMcTR2MUhsRk5BZ0VEV3dVVklrcXhnT2hmTnpndzRuc0Z1UXNLeVYr?=
 =?utf-8?B?VE5mSFZDU2tmWDFxL0N6emd3dXhkUjRMbFV3cU8zOGkxZkVXQXVqcmp0Qnd0?=
 =?utf-8?B?bUVkODc4MklrTHJ6QVBWNlozMlM4d1VYcHNjUmx0L2N1UDVKSUlqaTFxbmZy?=
 =?utf-8?B?Y3dDZEZ5Mk52SzJZMDdJWlk0Q200VE5xbGl4MGpkOTJ1WVVCMVBuQ3BjVkx3?=
 =?utf-8?B?QUFOK1ZQWUZXZTRXWnRTOXU2blZzRmtSWGNsdlVFbHI0a0dKblh3UHh2Wkg4?=
 =?utf-8?B?WU1KbGRGVEgrV0RvN0JQRURhbDg1YTZHWjZLdlJsK3U0aDhYNWxuaTUvWXJv?=
 =?utf-8?B?eWU5dzNZYjhFOHBaTlpEK3YvOFdzWUUvVTI3MXZOOXYrdlh3c0VwbmxTMjl2?=
 =?utf-8?B?d1dUUFB5Sllta2ZROHcrZ21HQnZ4dVVzR3paOGptRlhWcHpqSUtoTmhNUFY0?=
 =?utf-8?B?dVBYUmlycjk1WmtJZ2Yrd3M2V0d3K1h0N3puZzNlYXlURDlyeVEzZmZSWEdD?=
 =?utf-8?B?b0dzUk9pZU5STU1mR3RiZnI5dk9jVjE5Sm9sN015K1RWdjhtRGhPdE9xemJ6?=
 =?utf-8?B?OFdZbXA1R0xFZ3gzdFhaMnp5Y2h1eko4KzNzbXprbHpuOTdJT0dYaW1NeGE0?=
 =?utf-8?B?d2hsMXplMW41WUx2ekplTERZLzhBOWFyNEJ3eDNsRTNpSmZ6S0g0WUdhUnVJ?=
 =?utf-8?B?ZWR0UUFKOFRjSU9TL1RkNndsMFFXenAxV0N5YXp3S1NRajBZa0tTOVNmNUFC?=
 =?utf-8?B?azQ5MlZVZVBITGNaNjFnTTdLZTN0RVBSaVdKMUhoNlhDZWw0b2ZWTk5NK0JU?=
 =?utf-8?B?UzYrZVJvQ0NMbFB1YW5Qekl6R2RmRThhUlZKOFZJQ3ViWitTNjZMSVJVOUVP?=
 =?utf-8?B?SG0zMVJHTk1vRTVsUmZ0b09ieFBvc1NQbVRRdXVVUFpXQnhsWndPSWJaSjE2?=
 =?utf-8?B?Q3RXcEltSmlCZkZ6d2o0QlphdHREcjdPR0s5STU0YkdQbUxkMUFzUy8vNVVn?=
 =?utf-8?B?YVIzYk8zZy95NVRSVURrUVlOY1prbUJjdkcySTZxK2JqOVlXajJwTytCb0VR?=
 =?utf-8?B?d0lPa2RDdkpDOEx0U1pQa1hlV0E1Zk5RdDVYVFFhOFBlSDlNamRQWW9JUlRX?=
 =?utf-8?B?Y1VmMW4rejhJc0JUMkhiZ3NCRTNWSUJOMkQwbFp6ekIzemozOFZnT3NjSTV4?=
 =?utf-8?B?MWlBSEVvdUdFdzBxT1lJd1JOTHgrVFlzWitLT2w1TzVsdmo4Rmo1WW5ZdStX?=
 =?utf-8?B?WWJKbmJOMnZjeCtrWjJqVko0VE9WR3hNYmt5TjRUQ1piM2hIZnNyV2tFZEFa?=
 =?utf-8?B?cDk4WEp6Zi9GWFMrVkZsU1UvbWxtNFBCdmVzTURqalBuNkQ4L0g2ejRJbWIv?=
 =?utf-8?B?djNiR2lta1psMXhKQzBIR3djUVJlSjZaMUZiaEVjOEZPLy9Lb004NlNabERz?=
 =?utf-8?B?eUczT3pEanUrNXB5U3BXSGk4bGx5QU5Wb3hwZ0NhZ3oyR1E1cVRBQ0wzYWhj?=
 =?utf-8?B?VG1jNzZUZ0FBSWhaZ1ZpVE9SUCtKeUhvK0NQamVNejcrT0U0SUhZNTYyRTJq?=
 =?utf-8?B?dHdsSlhKYm9pQVZOUTd6WnVRdGFKem5WN0MwQTlDUFV1WHoyTjY2ZWFVamdH?=
 =?utf-8?B?aEdsZzk2T1V2YkZtaHpESFExS1pLZzdaeEtuK0FDcG9TWTRtcXMwK0pTaHdT?=
 =?utf-8?B?NlJaUU9SSW96M0c4TXFZeUdoVVNhbCtrK3NnVFI2M2laeXdpQmVSaldHUTM2?=
 =?utf-8?B?dHpHV1dTZVQ4b2hDcHowbnFTa3NEZWZxTTVSV3pIb2EzZ094ZDU5eHZIK05h?=
 =?utf-8?B?MXNkQmE1TGZEQzJYUzZocXdhSVFrM2poVnNRRHROM1EwWkp4ZS8veHl4WVIz?=
 =?utf-8?Q?4dhc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a458cc-8240-4b91-f39c-08daedbf1a8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 19:17:06.5572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: clAlrw7zSewf9V9OGfW6PFSQWeZPj9PqHSHLtSLXgDUJhlYeCVY7LPRS7yV24f2+l0cGzRsEZl2kVdoG+GFwYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5711
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Yadav, Arvind" <Arvind.Yadav@amd.com>,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhzYWttdCAgaGFzICB0aGUgIGlu
dGVyZmFjZXMgZm9yIGNvbXB1dGUgdXNlciBxdWV1ZS4gRG8gd2Ugd2FudCBhIHVuaWZ5IEFQSSBm
b3IgYm90aCAgZ3JhcGhpYyBhbmQgY29tcHV0ZSAgPw0KDQpSZWdhcmRzDQpTaGFveXVuLmxpdQ0K
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3Vu
Y2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEZlbGl4IEt1ZWhsaW5nDQpT
ZW50OiBUdWVzZGF5LCBKYW51YXJ5IDMsIDIwMjMgMTozMCBQTQ0KVG86IFNoYXJtYSwgU2hhc2hh
bmsgPFNoYXNoYW5rLlNoYXJtYUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBL
b2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgWWFkYXYsIEFydmlu
ZCA8QXJ2aW5kLllhZGF2QGFtZC5jb20+OyBQYW5lZXIgU2VsdmFtLCBBcnVucHJhdmluIDxBcnVu
cHJhdmluLlBhbmVlclNlbHZhbUBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtSRkMgMS83XSBkcm0v
YW1kZ3B1OiBVQVBJIGZvciB1c2VyIHF1ZXVlIG1hbmFnZW1lbnQNCg0KQW0gMjAyMi0xMi0yMyB1
bSAxNDozNiBzY2hyaWViIFNoYXNoYW5rIFNoYXJtYToNCj4gRnJvbTogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPg0KPiBUaGlzIHBhdGNoIGludG9yZHVjZXMgbmV3
IFVBUEkvSU9DVEwgZm9yIHVzZXJtb2RlIGdyYXBoaWNzIHF1ZXVlLiBUaGUNCj4gdXNlcnNwYWNl
IGFwcCB3aWxsIGZpbGwgdGhpcyBzdHJ1Y3R1cmUgYW5kIHJlcXVlc3QgdGhlIGdyYXBoaWNzIGRy
aXZlcg0KPiB0byBhZGQgYSBncmFwaGljcyB3b3JrIHF1ZXVlIGZvciBpdC4gVGhlIG91dHB1dCBv
ZiB0aGlzIFVBUEkgaXMgYQ0KPiBxdWV1ZSBpZC4NCj4NCj4gVGhpcyBVQVBJIG1hcHMgdGhlIHF1
ZXVlIGludG8gR1BVLCBzbyB0aGUgZ3JhcGhpY3MgYXBwIGNhbiBzdGFydA0KPiBzdWJtaXR0aW5n
IHdvcmsgdG8gdGhlIHF1ZXVlIGFzIHNvb24gYXMgdGhlIGNhbGwgcmV0dXJucy4NCj4NCj4gQ2M6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gQ2M6IENocmlzdGlh
biBLb2VuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBT
aGFzaGFuayBTaGFybWEgPHNoYXNoYW5rLnNoYXJtYUBhbWQuY29tPg0KPiAtLS0NCj4gICBpbmNs
dWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaCB8IDUyICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDUyIGluc2VydGlvbnMoKykNCj4NCj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oDQo+IGIvaW5jbHVkZS91YXBp
L2RybS9hbWRncHVfZHJtLmggaW5kZXggMGQ5M2VjMTMyZWJiLi5hM2QwZGQ2ZjYyYzUNCj4gMTAw
NjQ0DQo+IC0tLSBhL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oDQo+ICsrKyBiL2luY2x1
ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oDQo+IEBAIC01NCw2ICs1NCw3IEBAIGV4dGVybiAiQyIg
ew0KPiAgICNkZWZpbmUgRFJNX0FNREdQVV9WTSAgICAgICAgICAgICAgICAgICAgICAgMHgxMw0K
PiAgICNkZWZpbmUgRFJNX0FNREdQVV9GRU5DRV9UT19IQU5ETEUgIDB4MTQNCj4gICAjZGVmaW5l
IERSTV9BTURHUFVfU0NIRUQgICAgICAgICAgICAweDE1DQo+ICsjZGVmaW5lIERSTV9BTURHUFVf
VVNFUlEgICAgICAgICAgICAgMHgxNg0KPg0KPiAgICNkZWZpbmUgRFJNX0lPQ1RMX0FNREdQVV9H
RU1fQ1JFQVRFIERSTV9JT1dSKERSTV9DT01NQU5EX0JBU0UgKyBEUk1fQU1ER1BVX0dFTV9DUkVB
VEUsIHVuaW9uIGRybV9hbWRncHVfZ2VtX2NyZWF0ZSkNCj4gICAjZGVmaW5lIERSTV9JT0NUTF9B
TURHUFVfR0VNX01NQVAgICBEUk1fSU9XUihEUk1fQ09NTUFORF9CQVNFICsgRFJNX0FNREdQVV9H
RU1fTU1BUCwgdW5pb24gZHJtX2FtZGdwdV9nZW1fbW1hcCkNCj4gQEAgLTcxLDYgKzcyLDcgQEAg
ZXh0ZXJuICJDIiB7DQo+ICAgI2RlZmluZSBEUk1fSU9DVExfQU1ER1BVX1ZNICAgICAgICAgRFJN
X0lPV1IoRFJNX0NPTU1BTkRfQkFTRSArIERSTV9BTURHUFVfVk0sIHVuaW9uIGRybV9hbWRncHVf
dm0pDQo+ICAgI2RlZmluZSBEUk1fSU9DVExfQU1ER1BVX0ZFTkNFX1RPX0hBTkRMRSBEUk1fSU9X
UihEUk1fQ09NTUFORF9CQVNFICsgRFJNX0FNREdQVV9GRU5DRV9UT19IQU5ETEUsIHVuaW9uIGRy
bV9hbWRncHVfZmVuY2VfdG9faGFuZGxlKQ0KPiAgICNkZWZpbmUgRFJNX0lPQ1RMX0FNREdQVV9T
Q0hFRCAgICAgICAgICAgICAgRFJNX0lPVyhEUk1fQ09NTUFORF9CQVNFICsgRFJNX0FNREdQVV9T
Q0hFRCwgdW5pb24gZHJtX2FtZGdwdV9zY2hlZCkNCj4gKyNkZWZpbmUgRFJNX0lPQ1RMX0FNREdQ
VV9VU0VSUSAgICAgICAgICAgICAgIERSTV9JT1coRFJNX0NPTU1BTkRfQkFTRSArIERSTV9BTURH
UFVfVVNFUlEsIHVuaW9uIGRybV9hbWRncHVfdXNlcnEpDQo+DQo+ICAgLyoqDQo+ICAgICogRE9D
OiBtZW1vcnkgZG9tYWlucw0KPiBAQCAtMjg4LDYgKzI5MCw1NiBAQCB1bmlvbiBkcm1fYW1kZ3B1
X2N0eCB7DQo+ICAgICAgIHVuaW9uIGRybV9hbWRncHVfY3R4X291dCBvdXQ7DQo+ICAgfTsNCj4N
Cj4gKy8qIHVzZXIgcXVldWUgSU9DVEwgKi8NCj4gKyNkZWZpbmUgQU1ER1BVX1VTRVJRX09QX0NS
RUFURSAgICAgICAxDQo+ICsjZGVmaW5lIEFNREdQVV9VU0VSUV9PUF9GUkVFIDINCj4gKw0KPiAr
I2RlZmluZSBBTURHUFVfVVNFUlFfTVFEX0ZMQUdTX1NFQ1VSRSAgICAgICAgKDEgPDwgMCkNCg0K
V2hhdCBkb2VzICJzZWN1cmUiIG1lYW4gaGVyZT8gSSBkb24ndCBzZWUgdGhpcyBmbGFnIHJlZmVy
ZW5jZWQgYW55d2hlcmUgaW4gdGhlIHJlc3Qgb2YgdGhlIHBhdGNoIHNlcmllcy4NCg0KUmVnYXJk
cywNCiAgIEZlbGl4DQoNCg0KPiArI2RlZmluZSBBTURHUFVfVVNFUlFfTVFEX0ZMQUdTX0FRTCAg
ICgxIDw8IDEpDQo+ICsNCj4gK3N0cnVjdCBkcm1fYW1kZ3B1X3VzZXJxX21xZCB7DQo+ICsgICAg
IC8qKiBGbGFnczogQU1ER1BVX1VTRVJRX01RRF9GTEFHU18qICovDQo+ICsgICAgIF9fdTMyICAg
ZmxhZ3M7DQo+ICsgICAgIC8qKiBJUCB0eXBlOiBBTURHUFVfSFdfSVBfKiAqLw0KPiArICAgICBf
X3UzMiAgIGlwX3R5cGU7DQo+ICsgICAgIC8qKiBHRU0gb2JqZWN0IGhhbmRsZSAqLw0KPiArICAg
ICBfX3UzMiAgIGRvb3JiZWxsX2hhbmRsZTsNCj4gKyAgICAgLyoqIERvb3JiZWxsIG9mZnNldCBp
biBkd29yZHMgKi8NCj4gKyAgICAgX191MzIgICBkb29yYmVsbF9vZmZzZXQ7DQo+ICsgICAgIC8q
KiBHUFUgdmlydHVhbCBhZGRyZXNzIG9mIHRoZSBxdWV1ZSAqLw0KPiArICAgICBfX3U2NCAgIHF1
ZXVlX3ZhOw0KPiArICAgICAvKiogU2l6ZSBvZiB0aGUgcXVldWUgaW4gYnl0ZXMgKi8NCj4gKyAg
ICAgX191NjQgICBxdWV1ZV9zaXplOw0KPiArICAgICAvKiogR1BVIHZpcnR1YWwgYWRkcmVzcyBv
ZiB0aGUgcnB0ciAqLw0KPiArICAgICBfX3U2NCAgIHJwdHJfdmE7DQo+ICsgICAgIC8qKiBHUFUg
dmlydHVhbCBhZGRyZXNzIG9mIHRoZSB3cHRyICovDQo+ICsgICAgIF9fdTY0ICAgd3B0cl92YTsN
Cj4gK307DQo+ICsNCj4gK3N0cnVjdCBkcm1fYW1kZ3B1X3VzZXJxX2luIHsNCj4gKyAgICAgLyoq
IEFNREdQVV9VU0VSUV9PUF8qICovDQo+ICsgICAgIF9fdTMyICAgb3A7DQo+ICsgICAgIC8qKiBG
bGFncyAqLw0KPiArICAgICBfX3UzMiAgIGZsYWdzOw0KPiArICAgICAvKiogQ29udGV4dCBoYW5k
bGUgdG8gYXNzb2NpYXRlIHRoZSBxdWV1ZSB3aXRoICovDQo+ICsgICAgIF9fdTMyICAgY3R4X2lk
Ow0KPiArICAgICBfX3UzMiAgIHBhZDsNCj4gKyAgICAgLyoqIFF1ZXVlIGRlc2NyaXB0b3IgKi8N
Cj4gKyAgICAgc3RydWN0IGRybV9hbWRncHVfdXNlcnFfbXFkIG1xZDsNCj4gK307DQo+ICsNCj4g
K3N0cnVjdCBkcm1fYW1kZ3B1X3VzZXJxX291dCB7DQo+ICsgICAgIC8qKiBRdWV1ZSBoYW5kbGUg
Ki8NCj4gKyAgICAgX191MzIgICBxX2lkOw0KPiArICAgICAvKiogRmxhZ3MgKi8NCj4gKyAgICAg
X191MzIgICBmbGFnczsNCj4gK307DQo+ICsNCj4gK3VuaW9uIGRybV9hbWRncHVfdXNlcnEgew0K
PiArICAgICBzdHJ1Y3QgZHJtX2FtZGdwdV91c2VycV9pbiBpbjsNCj4gKyAgICAgc3RydWN0IGRy
bV9hbWRncHVfdXNlcnFfb3V0IG91dDsNCj4gK307DQo+ICsNCj4gICAvKiB2bSBpb2N0bCAqLw0K
PiAgICNkZWZpbmUgQU1ER1BVX1ZNX09QX1JFU0VSVkVfVk1JRCAgIDENCj4gICAjZGVmaW5lIEFN
REdQVV9WTV9PUF9VTlJFU0VSVkVfVk1JRCAyDQo=
