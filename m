Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79274C28CF5
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 04:04:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B300510E285;
	Wed, 26 Jan 2022 04:03:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA79610E285
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 04:03:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwXuyvNbU1K4S72tzcw/V+sIVaxfWTMJwi/MWa46+r4zaGaKVElrXjzicNyVW4xBuo7sBDSTliDR8p0E5YbAkxIFUAEyAjyZIGZXXcKmq6n+T/vm/wRUrFLSxnNB7wszQdosa0zsbK2Ebu9WIhEa8l2d3r+tuilAkRl1cAcP9lM9CbPF8NPXPzx00h3UWdZmrgau9yLNHbsc/813t+tySNYZ8O9hMTbYqKZPKwIW6fGJMBDlbMXEb3RGQJ2yRbqL9e5Zap3wWUw2/HbEzgI2I0yY3TxtNWsdae0VY15xrTT6WAOctsKceoYHxRXcuQ9x17kJUE0duQE4PuZtqVJapA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwM7407lUXoovnpRGelcK6RYupegXLfudhTqsHNTRN0=;
 b=CtYBrttdqaKTNr+3xQGvVQE+i7YzO1cGRe9GZrHp7Mrfoep6l2/fxwm1x3kml5upTV/iXiwnpgrA99eeCqdXEoxBf5R6FQwwAui8XLRuZoBEi0R5Lhk38NV6QLiOnSWM8btX/N3FSs2/EkY4xm9On0YhWgGWdn4UoYLb3BOs660Vw3JyYf/nhvsMspia6NaMMYCxO8pI+6gwdF6nLgg7tdOZ9gOeQixhFeZ3N0Y4uneKa5rtHCdli2VEjj6PUplxcO05y7tq06NRHuxyxh790GGzVUe0Ir1PU3Dydf300roIykqPgGQEecKnkE8s/I5vLXDMJfpWmpAI6i41pSj6LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwM7407lUXoovnpRGelcK6RYupegXLfudhTqsHNTRN0=;
 b=iaUOGN2yzJrl8h3IghVg10TOx+XNovgrmuI+MuCC6npShwnc9R3ZkaZLib90ViDnxivdZGHkdPuFHIBLJMyWeQdgUWmy2Y+WDwTuz+Nltg4z9o3Ai3U7pTXsxwpd7ZqcsBzuxk18EU+FR1mjWz09dp6xlJgVvYWAxg+AuQkXHvw=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 BN8PR12MB3137.namprd12.prod.outlook.com (2603:10b6:408:48::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.15; Wed, 26 Jan 2022 04:03:56 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639%6]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 04:03:56 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 2/2] drm/amd/pm: fix the deadlock observed on
 performance_level setting
Thread-Topic: [PATCH 2/2] drm/amd/pm: fix the deadlock observed on
 performance_level setting
Thread-Index: AQHYEcmNLjQQtHZwvEmZ6y9lha9wgqxz3rAAgADOegA=
Date: Wed, 26 Jan 2022 04:03:56 +0000
Message-ID: <DM6PR12MB26192863EEA51BD8DBA3B356E4209@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220125085614.101348-1-evan.quan@amd.com>
 <20220125085614.101348-2-evan.quan@amd.com>
 <CADnq5_NU+65__oY3P4V06FfpRkHesgL2v5YmOtQTYswSJr9T+g@mail.gmail.com>
In-Reply-To: <CADnq5_NU+65__oY3P4V06FfpRkHesgL2v5YmOtQTYswSJr9T+g@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-26T04:03:54Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d8dd12d2-6029-4d01-9f73-4db361721887;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccb5ef82-8267-43af-cee1-08d9e080dff0
x-ms-traffictypediagnostic: BN8PR12MB3137:EE_
x-microsoft-antispam-prvs: <BN8PR12MB313774FF11C65602BA131AD3E4209@BN8PR12MB3137.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4lLbZyvLE0ayPB3hTUBskJmuvG0Iq7wgSF4zzaLWfItDgVVxVjWvqtkaOzrcI+uS1D99RXNpAJoJ3sm4fJAEt8fDJ/gW+fdW86PTKAMt306re9oNyN6BpaJcN5fKFamlMentQ0/mm+3OSM/OaxqZl/H2WfFFmNyXGG9RR6f0f8BZqg28Gp2Aqnb7z77unYnhGLuen52Hinz+OhFnFG8DqrVzlbC+qO8jZhq35CDriDfw69dCeTdYgQ1Bp06fOQna5BPTQ0gQB44dBV3UdhmkbV0Gl9Qy3/jpqPXg5cmP11kcC4D1KnEXWEZ5i5R+oaKARsIajZGcf+1cJRak8gswHTgWUAmQIlP+6YgK4byIE3b9xDOgBXz8k1Hpu52BsaL/B3NCIyuy6INunewuHiZYnUYveTahk8UtY3hROgC26zx4Wb3ycYxPdz79Wg+ohK9sak/51CZXtfkYcPsW/S/ri5/4GCXaDDGHIuqReNSrPSRHQSUnYl+bFWuKSWwnx299VuPBGTv/+jPu9PGQx+NbvNyh70EeAbwh3anZKDCxFNEo3ib5T2jhNZQlT4eSc/Hw5splyd6yG1rRbUZABUzSU5It8Svq4ybt7KVf8KmuUFeaubDTYUYOMmHk+e+eFWdMPDkZTDNALae+eKGS/Xb42gL6TkwvxhXSGgwam/BQTCQ5bwsojwPOxcQzXxRTENqMVKcnfP5imyiny+CxCYb+/w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(26005)(38100700002)(66946007)(2906002)(76116006)(66446008)(52536014)(64756008)(66476007)(8676002)(8936002)(33656002)(66556008)(5660300002)(55016003)(4326008)(71200400001)(86362001)(9686003)(7696005)(6506007)(38070700005)(54906003)(316002)(508600001)(6916009)(83380400001)(53546011)(122000001)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VW8rZU5laS9wbi8wdUR5NkdJazd1aStqRlRBRW1IRCtMRHhjaGx1bFVxZHkw?=
 =?utf-8?B?R0hIUDJ3U0VtR29QVlByb2lCNHBVOHJWa0t1bEptS29FVnROVTFqK0pldXdK?=
 =?utf-8?B?VFRiekhtZWV3RGJlZFF2NmxyQ3pBelBpUkNlb1NLNmNXd0pWTGlqOHFFSkE0?=
 =?utf-8?B?ZjB6VGhkNDBRT0NseE1qNHhsTjFjbHRuNjNOd1Y1NmRwdVMva3ltRUc5dGNN?=
 =?utf-8?B?WnpMRWpzN0hNODZrYnRRMTBmbXQ3bjZTWmlGbnRndmtiVFZXQ1pqM2E3OWxh?=
 =?utf-8?B?QWhneVZGdmhlUTdqME9rTzRUWEJNU2lXRVVwdGdFWWtDVkhMSDA2RmFPV2lF?=
 =?utf-8?B?emFoTVBzVytPd3oxcUdmK1BHSGk3d0t3S0Fud2ttQklOUEM4YnFoTjA4dTY5?=
 =?utf-8?B?ckpEZE4yRmVpU3kyNUx4ekI4R1pSRDF4Skd2b09ocW1ZbXZLdFd1OHZuZFpm?=
 =?utf-8?B?VkFLdnlMQUVrc3ZkTSt4UVZxbXp6cVNpVGRhSFJHRmpibGQ5RDhkYndsSktt?=
 =?utf-8?B?a3NCWHQzRjk1NmYxb1NTNXc0dzk2Q0Uwc0FMSktTT01SQVR4Q3dVbVFPekhT?=
 =?utf-8?B?UnQxdUYyTk9RYXhQdlM4Rjk1ckpJaXBnZFUrMjNKNnZLejYzQktlT0ljeS9l?=
 =?utf-8?B?Q1F5TnNQSldqa2tIRjB5MndSM1N2MDBLYnZsaDBwRzUrVkQ5ZFkzTVJPU2dD?=
 =?utf-8?B?RFQzQkp0QjVBenV2SWtLN0YvRS9kbG9WVnEwN216WTc5SXcxaExqbndXUWJi?=
 =?utf-8?B?UDBXbkttbkRhS0JCNmNXd2c1V1YzL3ljOElpZjFvOFh6OEdBbTY4OGlrdkJJ?=
 =?utf-8?B?clVhRU9RUklLcS9GblVhV3k4K0IwZ09BU2dTbUNJSkJReElvZnNvaGMrVUl0?=
 =?utf-8?B?Z0VqM0VxWXpvaE1vclhTMVNoQnRYTWtZYXRqY1FSZURLWjFwY2xTN214VU0r?=
 =?utf-8?B?SGM0VHlyYWs2UE1VUTdvcm52OHUvajlLUWpNeFIvY3F2Wmszc2F1NHIrcmV6?=
 =?utf-8?B?SkgwV1o4TzNkVFpPUEZlK0I5YU1nZlU1SlRuSm80cXMxbHFNdEJHVVY4UWFS?=
 =?utf-8?B?Q3BtS0JwTHBlVXZVNFEvbEx5YVF2MlNxS1JwaFoyS1FtTDdCeEtxbEtwWXRy?=
 =?utf-8?B?QU5GeFdpU3ZvYnlTaFBCNEtzUW9ibTM4cTNGbnM3THN3NUdlWVBqbWh6akFt?=
 =?utf-8?B?ajF2eWozY2lCdnNKUFNTNXFURXl2YWt4OFNOczk2S2JWMjREcDgrTHNoU1R2?=
 =?utf-8?B?bDZ6aG1jTmMyQ3ozTlluMWJjalVLSFBSUEt2ZndBeTNIbnZSQVZaR1ZENEZH?=
 =?utf-8?B?V0xDbkZOeXovOGVsS2JSUWFjZkl4MEVHbDdnSzlaWEdBcjVKTkU2RnVtT3kv?=
 =?utf-8?B?RTA4NFBkTEpWN05KZjVaM3k0L1BBenNZYkM2US9iR0JjejJXdnB0WnZNak1F?=
 =?utf-8?B?c3NlM0FjcktPQTdPbjRVbTVvVW00YU4rNEQzSHBMVEtBWGtsWThybDlQb0py?=
 =?utf-8?B?NGJnaWJ0bGFGWW1kL2UybW1KaEZZVXJFOE5MSjdZYUtzTUJpMEV0eWhvcEZ2?=
 =?utf-8?B?K0s0TjY0OWhGb2pYNWtKQlp4YUlsaWxGMnNGdHQ5UWZWaVpXeGVzTDdWd0hj?=
 =?utf-8?B?VmJQZ1ZuSjNwakFYYkZCOGRmalJjbm9VR2hOU3hFZ2UycVpjOGRZOWt1Qlpt?=
 =?utf-8?B?NFcrR3ZCMmVMdzJENVdGTExNaWtpeXJoZVF5ZGcvSnhDRnNhb0lMUG0yK2Nr?=
 =?utf-8?B?MWU0ZGdmMXc2bkNSQ3paT0dwUlZ1WkdGVlZjQlFyOE1GckVpZU9KWnJtaktL?=
 =?utf-8?B?TVBGK0I0ZGZlTnVlcGthdXJlTlloU0hIV21UN0dmYVVyZUpkdGhXWDZaam81?=
 =?utf-8?B?NG4ybkhsVTBwN0oyVTVmejdJQnBVRzJjei8ybzh4Tm9JVTl3L05pMzNRUEVa?=
 =?utf-8?B?MmQ1V25SaENRTGU5N1MyNytIVGY1QmZibXgxSWlVczJjRVpLZStPdW1FTFpW?=
 =?utf-8?B?eTJqUm5yK081TTRGK3FkY1VVU1BibVI0K3AvK0hIdVF1R1JxZS9ZZVhyeFN2?=
 =?utf-8?B?Q1F0QjJnRTEyTElkRUhtcXF4TVdOV1VzMUxTczMwelBVK1ZXRngvQitkYmh4?=
 =?utf-8?Q?CalM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb5ef82-8267-43af-cee1-08d9e080dff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 04:03:56.6234 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J0dY/BeWR1Xw+0PM+pVtTEeLHdM9fhI5k6dkp6MdxyV5LDR52xN4RbFmh9OeHJyz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3137
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIEphbnVhcnkgMjUsIDIwMjIgMTE6MzUgUE0NCj4gVG86IFF1YW4sIEV2YW4gPEV2
YW4uUXVhbkBhbWQuY29tPg0KPiBDYzogYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZz47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGRybS9hbWQvcG06IGZpeCB0aGUgZGVh
ZGxvY2sgb2JzZXJ2ZWQgb24NCj4gcGVyZm9ybWFuY2VfbGV2ZWwgc2V0dGluZw0KPiANCj4gT24g
VHVlLCBKYW4gMjUsIDIwMjIgYXQgMzo1NyBBTSBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29t
PiB3cm90ZToNCj4gPg0KPiA+IFRoZSBzdWItcm91dGluZShhbWRncHVfZ2Z4X29mZl9jdHJsKSB0
cmllZCB0byBvYnRhaW4gdGhlIGxvY2sNCj4gPiBhZGV2LT5wbS5tdXRleCB3aGljaCB3YXMgYWN0
dWFsbHkgaG9sZCBieQ0KPiBhbWRncHVfZHBtX2ZvcmNlX3BlcmZvcm1hbmNlX2xldmVsLg0KPiA+
IEEgZGVhZGxvY2sgaGFwcGVuZWQgdGhlbi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEV2YW4g
UXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+DQo+ID4gQ2hhbmdlLUlkOiBJZDY5MjgyOTM4MWRlZGM2
MzgwZjU0NjRkNzQxMDdkNjk2ZjdhYmNhMQ0KPiANCj4gSSB0aGluayBpbiB0aGUgbG9uZyB0ZXJt
LCB3ZSBzaG91bGQgZml4IHVwIHRoZSBsb2dpYyB0byBhbGxvdyB1cyB0byBrZWVwIHRoZSBsb2Nr
DQo+IGFjcm9zcyB0aGUgd2hvbGUgZnVuY3Rpb24sIGJ1dCBmb3Igbm93LA0KW1F1YW4sIEV2YW5d
IEFncmVlZC4gQnV0IEkgaGF2ZSBub3QgZmlndXJlZCBvdXQgd2hhdCdzIHRoZSBwcm9wZXIgd2F5
IHRvIGRvIHRoYXQuIEluIG15IG9waW5pb24gd2UgY291bGQgZWl0aGVyIGVuZm9yY2UgYSBkaWZm
ZXJlbnQgbG9jayBpbnNpZGUgdGhlIGZ1bmN0aW9uLg0KT3Igd2UgbW92ZSB0aGlzIGludGVyZmFj
ZSBzb21ld2hlcmUgdXBwZXIgbGF5ZXIoZS5nLiBhbWRncHVfZGV2aWNlLmMpIGFuZCBhZGQgc29t
ZSBsb2NrIHByb3RlY3Rpb25zIHRoZXJlLg0KQnV0IGFzIHlvdSBzYWlkLCBsZXQncyBsYW5kIHRo
aXMgYSB0ZW1wb3JhcnkgZml4IGZvciBub3cuDQoNCkJSDQpFdmFuDQo+IA0KPiBSZXZpZXdlZC1i
eTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiANCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfZHBtLmMgfCA1MA0KPiA+ICsrKysr
KysrKystLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRp
b25zKCspLCAzMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL3BtL2FtZGdwdV9kcG0uYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9h
bWRncHVfZHBtLmMNCj4gPiBpbmRleCA1ZmMzMzg5M2E2OGMuLmVmNTc0Yzk2YjQxYyAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9kcG0uYw0KPiA+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X2RwbS5jDQo+ID4gQEAgLTY5MiwyNSArNjky
LDE2IEBAIHZvaWQgYW1kZ3B1X2RwbV9zZXRfcG93ZXJfc3RhdGUoc3RydWN0DQo+IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsDQo+ID4gICAgICAgICAgICAgICAgIGFtZGdwdV9kcG1fY29tcHV0ZV9jbG9j
a3MoYWRldik7ICB9DQo+ID4NCj4gPiAtc3RhdGljIGVudW0gYW1kX2RwbV9mb3JjZWRfbGV2ZWwN
Cj4gPiBhbWRncHVfZHBtX2dldF9wZXJmb3JtYW5jZV9sZXZlbF9sb2NrZWQoc3RydWN0IGFtZGdw
dV9kZXZpY2UNCj4gKmFkZXYpDQo+ID4gK2VudW0gYW1kX2RwbV9mb3JjZWRfbGV2ZWwNCj4gYW1k
Z3B1X2RwbV9nZXRfcGVyZm9ybWFuY2VfbGV2ZWwoc3RydWN0DQo+ID4gK2FtZGdwdV9kZXZpY2Ug
KmFkZXYpDQo+ID4gIHsNCj4gPiAgICAgICAgIGNvbnN0IHN0cnVjdCBhbWRfcG1fZnVuY3MgKnBw
X2Z1bmNzID0gYWRldi0+cG93ZXJwbGF5LnBwX2Z1bmNzOw0KPiA+ICAgICAgICAgZW51bSBhbWRf
ZHBtX2ZvcmNlZF9sZXZlbCBsZXZlbDsNCj4gPg0KPiA+ICsgICAgICAgbXV0ZXhfbG9jaygmYWRl
di0+cG0ubXV0ZXgpOw0KPiA+ICAgICAgICAgaWYgKHBwX2Z1bmNzLT5nZXRfcGVyZm9ybWFuY2Vf
bGV2ZWwpDQo+ID4gICAgICAgICAgICAgICAgIGxldmVsID0gcHBfZnVuY3MtPmdldF9wZXJmb3Jt
YW5jZV9sZXZlbChhZGV2LQ0KPiA+cG93ZXJwbGF5LnBwX2hhbmRsZSk7DQo+ID4gICAgICAgICBl
bHNlDQo+ID4gICAgICAgICAgICAgICAgIGxldmVsID0gYWRldi0+cG0uZHBtLmZvcmNlZF9sZXZl
bDsNCj4gPiAtDQo+ID4gLSAgICAgICByZXR1cm4gbGV2ZWw7DQo+ID4gLX0NCj4gPiAtDQo+ID4g
LWVudW0gYW1kX2RwbV9mb3JjZWRfbGV2ZWwNCj4gYW1kZ3B1X2RwbV9nZXRfcGVyZm9ybWFuY2Vf
bGV2ZWwoc3RydWN0DQo+ID4gYW1kZ3B1X2RldmljZSAqYWRldikgLXsNCj4gPiAtICAgICAgIGVu
dW0gYW1kX2RwbV9mb3JjZWRfbGV2ZWwgbGV2ZWw7DQo+ID4gLQ0KPiA+IC0gICAgICAgbXV0ZXhf
bG9jaygmYWRldi0+cG0ubXV0ZXgpOw0KPiA+IC0gICAgICAgbGV2ZWwgPSBhbWRncHVfZHBtX2dl
dF9wZXJmb3JtYW5jZV9sZXZlbF9sb2NrZWQoYWRldik7DQo+ID4gICAgICAgICBtdXRleF91bmxv
Y2soJmFkZXYtPnBtLm11dGV4KTsNCj4gPg0KPiA+ICAgICAgICAgcmV0dXJuIGxldmVsOw0KPiA+
IEBAIC03MjUsMjMgKzcxNiwxNiBAQCBpbnQNCj4gYW1kZ3B1X2RwbV9mb3JjZV9wZXJmb3JtYW5j
ZV9sZXZlbChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgQU1EX0RQTV9GT1JDRURfTEVWRUxfUFJPRklMRV9NSU5f
U0NMSyB8DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFNRF9E
UE1fRk9SQ0VEX0xFVkVMX1BST0ZJTEVfTUlOX01DTEsgfA0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBBTURfRFBNX0ZPUkNFRF9MRVZFTF9QUk9GSUxFX1BFQUs7
DQo+ID4gLSAgICAgICBpbnQgcmV0ID0gMDsNCj4gPg0KPiA+ICAgICAgICAgaWYgKCFwcF9mdW5j
cy0+Zm9yY2VfcGVyZm9ybWFuY2VfbGV2ZWwpDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiAw
Ow0KPiA+DQo+ID4gLSAgICAgICBtdXRleF9sb2NrKCZhZGV2LT5wbS5tdXRleCk7DQo+ID4gLQ0K
PiA+IC0gICAgICAgaWYgKGFkZXYtPnBtLmRwbS50aGVybWFsX2FjdGl2ZSkgew0KPiA+IC0gICAg
ICAgICAgICAgICByZXQgPSAtRUlOVkFMOw0KPiA+IC0gICAgICAgICAgICAgICBnb3RvIG91dDsN
Cj4gPiAtICAgICAgIH0NCj4gPiArICAgICAgIGlmIChhZGV2LT5wbS5kcG0udGhlcm1hbF9hY3Rp
dmUpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+DQo+ID4gLSAgICAg
ICBjdXJyZW50X2xldmVsID0gYW1kZ3B1X2RwbV9nZXRfcGVyZm9ybWFuY2VfbGV2ZWxfbG9ja2Vk
KGFkZXYpOw0KPiA+IC0gICAgICAgaWYgKGN1cnJlbnRfbGV2ZWwgPT0gbGV2ZWwpIHsNCj4gPiAt
ICAgICAgICAgICAgICAgcmV0ID0gMDsNCj4gPiAtICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+
ID4gLSAgICAgICB9DQo+ID4gKyAgICAgICBjdXJyZW50X2xldmVsID0gYW1kZ3B1X2RwbV9nZXRf
cGVyZm9ybWFuY2VfbGV2ZWwoYWRldik7DQo+ID4gKyAgICAgICBpZiAoY3VycmVudF9sZXZlbCA9
PSBsZXZlbCkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4NCj4gPiAgICAgICAg
IGlmIChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9SQVZFTikgew0KPiA+ICAgICAgICAgICAgICAg
ICBpZiAoIShhZGV2LT5hcHVfZmxhZ3MgJiBBTURfQVBVX0lTX1JBVkVOMikpIHsgQEANCj4gPiAt
NzU1LDEwICs3MzksOCBAQCBpbnQgYW1kZ3B1X2RwbV9mb3JjZV9wZXJmb3JtYW5jZV9sZXZlbChz
dHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+ICAg
ICAgICAgaWYgKCEoY3VycmVudF9sZXZlbCAmIHByb2ZpbGVfbW9kZV9tYXNrKSAmJg0KPiA+IC0g
ICAgICAgICAgIChsZXZlbCA9PSBBTURfRFBNX0ZPUkNFRF9MRVZFTF9QUk9GSUxFX0VYSVQpKSB7
DQo+ID4gLSAgICAgICAgICAgICAgIHJldCA9IC1FSU5WQUw7DQo+ID4gLSAgICAgICAgICAgICAg
IGdvdG8gb3V0Ow0KPiA+IC0gICAgICAgfQ0KPiA+ICsgICAgICAgICAgIChsZXZlbCA9PSBBTURf
RFBNX0ZPUkNFRF9MRVZFTF9QUk9GSUxFX0VYSVQpKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1
cm4gLUVJTlZBTDsNCj4gPg0KPiA+ICAgICAgICAgaWYgKCEoY3VycmVudF9sZXZlbCAmIHByb2Zp
bGVfbW9kZV9tYXNrKSAmJg0KPiA+ICAgICAgICAgICAgICAgKGxldmVsICYgcHJvZmlsZV9tb2Rl
X21hc2spKSB7IEBAIC03ODAsMTcgKzc2MiwxOSBAQCBpbnQNCj4gPiBhbWRncHVfZHBtX2ZvcmNl
X3BlcmZvcm1hbmNlX2xldmVsKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBTURfUEdf
U1RBVEVfR0FURSk7DQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiArICAgICAgIG11dGV4X2xvY2so
JmFkZXYtPnBtLm11dGV4KTsNCj4gPiArDQo+ID4gICAgICAgICBpZiAocHBfZnVuY3MtPmZvcmNl
X3BlcmZvcm1hbmNlX2xldmVsKGFkZXYtPnBvd2VycGxheS5wcF9oYW5kbGUsDQo+ID4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxldmVsKSkNCj4gPiAtICAg
ICAgICAgICAgICAgcmV0ID0gLUVJTlZBTDsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgbGV2ZWwpKSB7DQo+ID4gKyAgICAgICAgICAgICAgIG11dGV4
X3VubG9jaygmYWRldi0+cG0ubXV0ZXgpOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVJ
TlZBTDsNCj4gPiArICAgICAgIH0NCj4gPg0KPiA+IC0gICAgICAgaWYgKCFyZXQpDQo+ID4gLSAg
ICAgICAgICAgICAgIGFkZXYtPnBtLmRwbS5mb3JjZWRfbGV2ZWwgPSBsZXZlbDsNCj4gPiArICAg
ICAgIGFkZXYtPnBtLmRwbS5mb3JjZWRfbGV2ZWwgPSBsZXZlbDsNCj4gPg0KPiA+IC1vdXQ6DQo+
ID4gICAgICAgICBtdXRleF91bmxvY2soJmFkZXYtPnBtLm11dGV4KTsNCj4gPg0KPiA+IC0gICAg
ICAgcmV0dXJuIHJldDsNCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4gPiAg
aW50IGFtZGdwdV9kcG1fZ2V0X3BwX251bV9zdGF0ZXMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsDQo+ID4gLS0NCj4gPiAyLjI5LjANCj4gPg0K
