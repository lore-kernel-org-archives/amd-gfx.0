Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0456C3DA6E
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Jan 2024 02:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A40E10E6AE;
	Sat,  6 Jan 2024 02:18:30 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86AAF10E6AE
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Jan 2024 02:18:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAqpt8C/ywb1hVjSD9u/4uwdGS/xZa00ScxABeix1c+wXlsALe16jscW91rqJrxS4YnA8D/UYOjEuCe6sEaBrfztPat8D14A9MgxXnIEKz/NvCBg7hB9EmV80gNf3WGOtasVITeVcivelh3jOz/V7k8XJuS+VzQqNTQbdE0xAZgSMFBaOQVXnGJP3bWXp1T8CKGURVB06CtwYpmkBztEA0T9WGL8Q/K6ruNfYOHcVGIlwj0iFKReSegagQJL5eLYnU30uhDPX0Knpr+6kwKAjvvsPANB9LrptwaSmxpgO7sNkgdQJdx1RAWzB33c72/NWYBEGBIm0h6oPYCE3Dm3vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NI8yZ5g4xAO1P3BR5mv4Wu99IbjfnPuZi2oke9ZRoo=;
 b=jVWaaji6Rq+43HSil65bCV9ZPEymAqZNhC9fPbZFUMyWv/nDta+4ZZ9lXBOugwvNt1REGACiL62Y8L0zAJkyQNEKoJX2Isesdq3+C5zgbGcEBbh2niKwqLxOeVXnjc5QgCmqhAEsHZYFRWecdR/yAZZZHXXbhO9jXvkGozSfs1YG6Y8T2gtGz1NE0cGjY0wtH9bFkLkTmHZ2tl+YOSiVBOUBumEbZ95Mde9I6Nmwyv8xvDDGk8a9+cNlS31yTaVsY95Yw7Z3g0A7Y/EgyXhupF2LaGuXf/GcpDLuuvPuZ5UbdeakSMz/nkdZY+WXGBsVDZYmThDmyD1qX5wXhq+1bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NI8yZ5g4xAO1P3BR5mv4Wu99IbjfnPuZi2oke9ZRoo=;
 b=fVwoioNQT0huANk974ZbII/c4lw2bXh/OwM3FG7THm/glVb+UjH0ArjfouDIhySeYA0UXIsDVRotlcvEJudaY/cN4fGXjHL/3a3/ywFxFYBrK1wmJwsvW9RyefkIFpv+/oaGkRk0K3s3q2jU/3wIFKwIk/sZAM3skI3oTYKVtKA=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by MW4PR12MB5666.namprd12.prod.outlook.com (2603:10b6:303:188::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Sat, 6 Jan
 2024 02:18:25 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790%4]) with mapi id 15.20.7135.023; Sat, 6 Jan 2024
 02:18:25 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: fix avg vs input power reporting on smu7
Thread-Topic: [PATCH 1/4] drm/amdgpu: fix avg vs input power reporting on smu7
Thread-Index: AQHaLgs7kEUY9oyF30W2L3mxCkZM97DLY5IAgADNMJA=
Date: Sat, 6 Jan 2024 02:18:24 +0000
Message-ID: <PH7PR12MB59971770A92FF6024C42C44282652@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231213212729.1965153-1-alexander.deucher@amd.com>
 <CADnq5_MkzcTThbTdGqeOw6ffCSRDhk=LMENkriF_iavGO3fZiQ@mail.gmail.com>
In-Reply-To: <CADnq5_MkzcTThbTdGqeOw6ffCSRDhk=LMENkriF_iavGO3fZiQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|MW4PR12MB5666:EE_
x-ms-office365-filtering-correlation-id: 23b9f46b-876b-4ad0-e669-08dc0e5dc306
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fKx07uEzES40Nk3x3jCg1st2bbC53iJYoamLivNGy0DWSd6oYBAcopL4EiwlF9C4tBOCul0lKQGl0I+DyDeIrVvqhF9L8+24VhhHiK2EElIjYGadzy86JVOiyO4gjdK/ldbLX0uTkRsTCMrtQ+aaGh9gnmAgeN3p7ojfFkFp0KOhHEeF7CLCiXiq8CXo4TL7h01ZPBhDmIspKd14GJgTwimwoILPfk5yQCoBiHHjHhaSr7G4kzP3ORYVkE54WFSmBHepffg2mYySdFzk+kXlAqggzosLKVYqXIxD3ratcfkXeJJLpoYU7GSml2cVmSaoWUZZh5k1vs0GXnNr85yfxlhznmxW3uRJOSz3yQk7qHdK6VMAcKWl3FEC0TONxK/jYssDr6B6rFKzKVjkIJ8Q6V8fo4QA+HVQyRBTeDO6zw8frgbv/hsfFRgqqBooYHL7qXeAf2mCXS6njMYCDKwsnkVAuadeKULgEa4w72gIaaLh/Vri8tVLNK/c4TVlEbySzk5DFYvFQb2GpYwrLglWgOqZNRHhuFGVI3NRCTH4sBotfjq5y0RtNcQdeZTaFcsHwFR6Nf1jtueuge2GKmwJ40LaYdGK4S8b1Jjjd0xUOtX1VBqyaDSvhX4zjD3xScdd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(9686003)(53546011)(26005)(38100700002)(122000001)(5660300002)(316002)(8676002)(52536014)(4326008)(64756008)(66556008)(66476007)(66446008)(6506007)(7696005)(2906002)(8936002)(71200400001)(478600001)(110136005)(6636002)(41300700001)(76116006)(33656002)(66946007)(86362001)(38070700009)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QThPVWVNd2h3c3lqOGJTWTdENzdjVGZCelNaWkVicUlJLzRBUk9ZOHhpNklB?=
 =?utf-8?B?MVRSQVpoaWpFMFBoRElXQ1RUWHZRNmFpbm44Z3VDcUlZMERCUTZ6MWhXVkVI?=
 =?utf-8?B?bys4YW1sUUxmR3pvSDMraGlhY3F0NDhodGxSUzdhZU45enFIWkgyeVBOZUVB?=
 =?utf-8?B?dFRoamlSeGRsZ2pkUHE1OUdrTndBV3JNR0tWUVZDczdUYk9waGdrOUN5UG9U?=
 =?utf-8?B?U2tjNzQrTUFLWEtkUFBCRlhyZXFhT0lWamdRVHc1STJjTHpjaTJwb1J0UlFn?=
 =?utf-8?B?VXZSa0Y4ZjN2dUxHR0lWTHJkcmxZZjNkOVpnVG5lVG9oU1ViVkJiWSt2eFBl?=
 =?utf-8?B?QlFvc0k5Z1hMVC9MR3FnTDArWnpGTkN1Mk9iL0F4bnVzdXRZVU1CVUxNYkJY?=
 =?utf-8?B?YmszV2dRV3dnc3d0S3gxUUluWVdld0xZc1VCd29SZUE2M3B2Vjd4bnk3TlFG?=
 =?utf-8?B?eTV4YVFXbXp0aXh1ajV3c2RxbE1Zbm9GWmhMTnNKVXZ2U3lvSHlPTGpzVnB3?=
 =?utf-8?B?TytXbUoxcVFzNVp4aU1iMi8zVEp2a0t4ZkxQcjRtVEFuR1lMRFNqbXM0OWI0?=
 =?utf-8?B?QmR4cXZVdEcrdUxBVjkxMVB6bTdNVHkzbWg2WDNxZmZHZXdOcVJucllWQ1VB?=
 =?utf-8?B?RGt6dkZJYm9FR1VpQ1JhaHVqdXJsVFIwS0VuMElySWk2SDE5eU1NbURvS28v?=
 =?utf-8?B?K1YvVjN1RVVNVmt6TncxUUdYRTY5YldjK3ErTjJPUXVKZWdZeTlvNXVKb3Nk?=
 =?utf-8?B?WlRpVEo1aE4wY1JmK094d1NyS2ZtYS9zQ1RrNDRhMS90K1F1T0RVNmdqK2wv?=
 =?utf-8?B?VWwxYWhYR0ZOalcxOXREWkxRWitYSWhWRU9BK1VWSGh0bzBKMitDeGh2K2dE?=
 =?utf-8?B?RUQzUU9Tc0JCLzJQOGhCbG0vbjlWVy9pSVM4TFc3K1ZVMWpnQXlZc3lMNERi?=
 =?utf-8?B?Q09mc2FOQm5qTnNLZlVONVNOSjBYRmM0WURiRTNxa2Vmb21QL2Exc3RZdWFo?=
 =?utf-8?B?YytVZUVQWk9SbXFJdzNzc2JzWWpERU5Kby90SXZJWFIxanMyd0FqMS9EbnlJ?=
 =?utf-8?B?Uk5mTjQzS2lPSHJncFdFUGRRSlNKMkdZc1MwMVhYMTBVZEdYWkc5OEFwZXV4?=
 =?utf-8?B?aG9BMjVNTGQvZDBkUFpNUmZBRjMzdEd3STY5SzJmVjdqTXV2eXRjL1hDWlBn?=
 =?utf-8?B?YW45T00vZUJMb05XYVJNVHdIdG91TTVaK3hKNVdQMWc2RmY3bVpGdi8xdEhC?=
 =?utf-8?B?QTV3Y3gvRGNWbFI0NStxNmtlcWhqRjI4WHVudVBkRjlTSWJadEorUU80MEY5?=
 =?utf-8?B?QVo1UksxL1JYdXNJaUVhZy9XaFBsZVRGR1FXNUdSaC9rR3k0WXlhdVdBQ3VS?=
 =?utf-8?B?c3JtV1hOYnQvcXEybXkrMldaSTNYd2xlak94MzRpRSt5dDhpeHdRRkN4L3kw?=
 =?utf-8?B?aGRmK3JBUjRQcFZQeG5wTHhiTlVJbThHSExvaXdsVWsyaHp2ZDFFRTM4K0NE?=
 =?utf-8?B?SFNEay8zeG42REpHZDlpVC9QbnpnYW9DTGN0eUN5L1NxT0hiU2Jwb00zVXpq?=
 =?utf-8?B?M0kzOW1aVmZoRERpU3ArTW85QVVSS1hhUUVESENxaktoVEdzanE3cWFzaEhM?=
 =?utf-8?B?QmhOQzBKaG8zeE5DQWNJcW9wNEdZVUFSMXorRXVlczdtS0MrMWtEYTJqQUhC?=
 =?utf-8?B?clZjL255ME5yOEFNTFlGL3pxTXFkT0ZpN01MWnJBVHI0R1RWUFI1NWNtSjFm?=
 =?utf-8?B?MDhqaG8wZVN0OTJER2xKcEVnK1ZUZlBUYTJkWVB2NlpRLzMrekNnMlY0OUZl?=
 =?utf-8?B?bTBrRW55RW00MzEzWHY1Szh3NVRkM3M5a0h0Q29rcjgzSlBCTXJieTZoVVRH?=
 =?utf-8?B?N2dJSWROVys3L1lNblNKdU9Pc1JLT1owUTZHOFJQMTZJWUVJYUJPUERrVmlt?=
 =?utf-8?B?ZndjU01URFh4U1dZQU5sK25vM3FuMnJXUW1BL0N0MDJHblBzcW9FbWR6Y1Er?=
 =?utf-8?B?OTVVN2piQldzM1NaMkl0WVRSYTU0MWFaWWxvUHpHd1lmNW1JUXU0Wmo4WnVV?=
 =?utf-8?B?Ny9iN0tROElsT3J6cEdReUF3M0ZHejlCanF6YkJBcjRWYzJYWlhjYjdodkw3?=
 =?utf-8?Q?aR94=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b9f46b-876b-4ad0-e669-08dc0e5dc306
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2024 02:18:24.6094 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KHnEN9RCOJvKUl58kvNtMYMjAtgE76adXg6pQKF+FPbnn6vepRIZi7+sNf8i1OoQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5666
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

U2VyaWVzIGlzDQpSZXZpZXdlZC1ieTogWWFuZyBXYW5nIDxrZXZpbnlhbmcud2FuZ0BhbWQuY29t
Pg0KDQpCZXN0IFJlZ2FyZHMsDQpLZXZpbg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24g
QmVoYWxmIE9mIEFsZXggRGV1Y2hlcg0KU2VudDogRnJpZGF5LCBKYW51YXJ5IDUsIDIwMjQgMTA6
MDMgUE0NClRvOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+
DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0gg
MS80XSBkcm0vYW1kZ3B1OiBmaXggYXZnIHZzIGlucHV0IHBvd2VyIHJlcG9ydGluZyBvbiBzbXU3
DQoNClBpbmcgb24gdGhpcyBzZXJpZXM/DQoNCkFsZXgNCg0KT24gV2VkLCBEZWMgMTMsIDIwMjMg
YXQgNDo1NeKAr1BNIEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4gd3Jv
dGU6DQo+DQo+IEhhd2FpaSwgQm9uYWlyZSwgRmlqaSwgYW5kIFRvbmdhIHN1cHBvcnQgYXZlcmFn
ZSBwb3dlciwgdGhlIG90aGVycyANCj4gc3VwcG9ydCBjdXJyZW50IHBvd2VyLg0KPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IC0t
LQ0KPiAgLi4uL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9zbXU3X2h3bWdyLmMgfCAx
NyANCj4gKysrKysrKysrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL3Bvd2VycGxheS9od21nci9zbXU3X2h3bWdyLmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21nci5jDQo+IGluZGV4IDExMzcyZmNjNTljOC4u
YTJjN2IyZTExMWZhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2Vy
cGxheS9od21nci9zbXU3X2h3bWdyLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9w
b3dlcnBsYXkvaHdtZ3Ivc211N19od21nci5jDQo+IEBAIC0zOTk1LDYgKzM5OTUsNyBAQCBzdGF0
aWMgaW50IHNtdTdfcmVhZF9zZW5zb3Ioc3RydWN0IHBwX2h3bWdyICpod21nciwgaW50IGlkeCwN
Cj4gICAgICAgICB1aW50MzJfdCBzY2xrLCBtY2xrLCBhY3Rpdml0eV9wZXJjZW50Ow0KPiAgICAg
ICAgIHVpbnQzMl90IG9mZnNldCwgdmFsX3ZpZDsNCj4gICAgICAgICBzdHJ1Y3Qgc211N19od21n
ciAqZGF0YSA9IChzdHJ1Y3Qgc211N19od21nciANCj4gKikoaHdtZ3ItPmJhY2tlbmQpOw0KPiAr
ICAgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gaHdtZ3ItPmFkZXY7DQo+DQo+ICAg
ICAgICAgLyogc2l6ZSBtdXN0IGJlIGF0IGxlYXN0IDQgYnl0ZXMgZm9yIGFsbCBzZW5zb3JzICov
DQo+ICAgICAgICAgaWYgKCpzaXplIDwgNCkNCj4gQEAgLTQwMzgsNyArNDAzOSwyMSBAQCBzdGF0
aWMgaW50IHNtdTdfcmVhZF9zZW5zb3Ioc3RydWN0IHBwX2h3bWdyICpod21nciwgaW50IGlkeCwN
Cj4gICAgICAgICAgICAgICAgICpzaXplID0gNDsNCj4gICAgICAgICAgICAgICAgIHJldHVybiAw
Ow0KPiAgICAgICAgIGNhc2UgQU1ER1BVX1BQX1NFTlNPUl9HUFVfSU5QVVRfUE9XRVI6DQo+IC0g
ICAgICAgICAgICAgICByZXR1cm4gc211N19nZXRfZ3B1X3Bvd2VyKGh3bWdyLCAodWludDMyX3Qg
Kil2YWx1ZSk7DQo+ICsgICAgICAgICAgICAgICBpZiAoKGFkZXYtPmFzaWNfdHlwZSAhPSBDSElQ
X0hBV0FJSSkgJiYNCj4gKyAgICAgICAgICAgICAgICAgICAoYWRldi0+YXNpY190eXBlICE9IENI
SVBfQk9OQUlSRSkgJiYNCj4gKyAgICAgICAgICAgICAgICAgICAoYWRldi0+YXNpY190eXBlICE9
IENISVBfRklKSSkgJiYNCj4gKyAgICAgICAgICAgICAgICAgICAoYWRldi0+YXNpY190eXBlICE9
IENISVBfVE9OR0EpKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gc211N19nZXRf
Z3B1X3Bvd2VyKGh3bWdyLCAodWludDMyX3QgKil2YWx1ZSk7DQo+ICsgICAgICAgICAgICAgICBl
bHNlDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRU9QTk9UU1VQUDsNCj4gKyAg
ICAgICBjYXNlIEFNREdQVV9QUF9TRU5TT1JfR1BVX0FWR19QT1dFUjoNCj4gKyAgICAgICAgICAg
ICAgIGlmICgoYWRldi0+YXNpY190eXBlICE9IENISVBfSEFXQUlJKSAmJg0KPiArICAgICAgICAg
ICAgICAgICAgIChhZGV2LT5hc2ljX3R5cGUgIT0gQ0hJUF9CT05BSVJFKSAmJg0KPiArICAgICAg
ICAgICAgICAgICAgIChhZGV2LT5hc2ljX3R5cGUgIT0gQ0hJUF9GSUpJKSAmJg0KPiArICAgICAg
ICAgICAgICAgICAgIChhZGV2LT5hc2ljX3R5cGUgIT0gQ0hJUF9UT05HQSkpDQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgIHJldHVybiAtRU9QTk9UU1VQUDsNCj4gKyAgICAgICAgICAgICAgIGVs
c2UNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHNtdTdfZ2V0X2dwdV9wb3dlciho
d21nciwgKHVpbnQzMl90IA0KPiArICopdmFsdWUpOw0KPiAgICAgICAgIGNhc2UgQU1ER1BVX1BQ
X1NFTlNPUl9WRERHRlg6DQo+ICAgICAgICAgICAgICAgICBpZiAoKGRhdGEtPnZyX2NvbmZpZyAm
IFZSQ09ORl9WRERHRlhfTUFTSykgPT0NCj4gICAgICAgICAgICAgICAgICAgICAoVlJfU1ZJMl9Q
TEFORV8yIDw8IFZSQ09ORl9WRERHRlhfU0hJRlQpKQ0KPiAtLQ0KPiAyLjQyLjANCj4NCg==
