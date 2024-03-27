Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F9DC54E67
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Mar 2024 06:25:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 501EA10F8A2;
	Wed, 27 Mar 2024 06:25:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hrRAgZ1S";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2105.outbound.protection.outlook.com [40.107.237.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 116F510F8A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 06:25:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnSBRakMeUPLQmx+V1x4kTO1pcw78Nuey+GIay6UsNPAz8RzC8LdQU0FQPZv+gz7OUnrJPoFDr4eqbKi+CBL4HTMv7LAcic71CNY3oyycwF/OypyzDKVMYaZQwjMIbGpiqv36RULg499ybUzjfzJxaaryF3TkIeDrIzot1dO9YOmswYVBctuNBzhrPpQFxnWjz2gpxzGA1ik9A5Q4kEnwQrwhtubsvtRQNeAZIPKfaOIsJo885Is8gP4JgsxnTg3uqIrlDSDsE18cTaAdbjzRROiDKQMDIo31P6fJHAgC1Bg0zWv3KScoERFHJfgRB+sGuKBN4XlFBIjx+qzc+etNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTElnvzCCqOA1h+H0VCZAe6MtJgVwxlAn2tjZSCBgvU=;
 b=BbYVp0vtXpQ/Z7aADk0P6rXafRN9gBHo37EzpXINd2NnvaXfh/zRR0nnwENw6lG9ZX0nPSl83etDoHFiCcIH256LX4GS3EUzDpc5QDOiQ5oDJMGhLurQBXn4Ka75iOLCSiUVm2Ljts1+VVzOM6ilb6lnTwp+sn0t9/5kPyMmWuol50U+/yfc2Jo+TJ8G1LEcnyKO8lHrcLe8y4cj0hsbSuWGoV7o5MJLUmqOoT+k6ZUmXmzlhu66vqpSsMSN9inLs0QJq9gXzomyDWijmn0bcAYwAOIZ7QILQCoz5DcUEGuxN3vyIUfZxFJ46bE8Te+YmX8gLjJs0azDqJUs4Kk95A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTElnvzCCqOA1h+H0VCZAe6MtJgVwxlAn2tjZSCBgvU=;
 b=hrRAgZ1Sv/DzXybsakNRfFdkQKX7y7LUKi0zJH/E8RlQSeiWCSy3nbtyQGXzB/tVbyU6txtohMhaZCITKBlVnABXU0EF7VB6JeeGV+vvhl1FCbJbc0ERMlpeC7FHtIxUWIqGntpUJlg+2S685qt6qcN9f3VWRSvq/qWr18RK9eE=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 06:25:05 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7409.028; Wed, 27 Mar 2024
 06:25:05 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: make amdgpu device attr_update() function
 more efficient
Thread-Topic: [PATCH] drm/amdgpu: make amdgpu device attr_update() function
 more efficient
Thread-Index: AQHaf1xyQlwU68fc8USDr4IZubGvErFLH1MAgAAAMoA=
Date: Wed, 27 Mar 2024 06:25:04 +0000
Message-ID: <PH7PR12MB5997455AE0AD21ABFD9E1C8A82342@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240326090255.77211-1-kevinyang.wang@amd.com>
 <2c6fe582-abb3-40dd-8591-5040697eadf3@amd.com>
In-Reply-To: <2c6fe582-abb3-40dd-8591-5040697eadf3@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=51e8c089-128e-4efd-89b9-865aadabdda4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-27T06:22:20Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CH3PR12MB7690:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U8AJYCaM+K/bJ23FC/+WYkld6BqkIaIP81Xxa08Ns2v7R35EsRDJpByyV+k4WrYGWQsOAhipU73IXvMizhh5Q+IIzVKvkHPy0nWWgGPcTDg/Gd7WTluJSEJQfYxrLb+gjvzmGpYjJp+zRbHGDJNeMl2v9apvj6wqsFuMSwz9FwEZ8RJ5DBjKEoQVPUO/ePTHglSe5ZHGp+VyX9bAH2+0fY/iXGcAh8fbg/3eSaawm5rKHYYQrOQsbBd3bh3zz5WRW8eUK2jmJR5dK6WyBiird6WZ3iMyGwMu05qVt7DrFNTThcfYz4lucOd4yZziP5Tp/ATxFwVymmJaYGcUtHu6z6+2VxiOnWz7N/HZmoN5Pp8ksVJmU87oXYRD2Og6kp72mGQCI4aOhpBgtAizW9wNxrQFx8Brl/p0Am1u1+dyLJ5Xc+8pRgj257B3EQ3xz+0qr/4NKd5A7atli6zVyiuof4fKaYuNfXVN2ADfwPArLy1iB+ypX/LzHjup59yrUSbE8bSRwzkvGBT7pjf0tAoSeLve7qX2CXvp0MYBaSVgI6YJm1Zw1IiifR2p/OfgFs+XDDCpKyIZRNvBNh3PtjylIbXn2R5YOFOs/hXXnQNA65TmS0HuwXJ9gEimfLP4TVsv428TwNlb5F6riG6kFtLDN4tKw+/tcH2FWMIh65JT7aQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEw2L2ZhQUszVUxET09LOFZ6RHZ1OElUc1ZBZWh3Tk8wWHFQME04d0xCNmNU?=
 =?utf-8?B?K1lJZ3NhS3NtRGc4NXdDQk5sVUlPZVZyOVNDSklzOTdFK3IzOVlSRFVYQUg0?=
 =?utf-8?B?cjVuOWMwVC9YUndlMVRCelRCdnNZdWtvL1N5UnVidDFILys0R1UwQVlSTDgx?=
 =?utf-8?B?cU1wNldoM1NBb1p0YUZSa1FpNFc4aDVwWGdKTHd6eGxieU40dHMvbW8reGJu?=
 =?utf-8?B?b2R0U3lET1dBVzRoVUhkOUNuaEF3bjVLZWlXblVBenkzelZpbXZ4eC8wNU9U?=
 =?utf-8?B?azVxdWdIdWRRbHhlQWdoMmpCTjdiTHFsQWJ2eHZzSmxGanBnY1c2M0VtWXFl?=
 =?utf-8?B?c1VQbm1jTEpMOVY3eXZsdUVYQ2pWQUpHSm1LTm54VjRKN3licFNaNGVYOGxQ?=
 =?utf-8?B?MGt0bm5OMHMwUnEvdTd5MnJiajd0d3FaK3RHV3I0Mmh4RVkyNHQ4SXJOaU5U?=
 =?utf-8?B?cVdsOFFiU0hmSWNiS1A1eUN3SWx2SW9iemxpbksyZVpqekh2NVQ3cER6dUlI?=
 =?utf-8?B?RjJYQmlJNGJqNCt2aW9wRmc5WDFXU0svSVFDN3pzREt4OFdnM2g3T0laZzM4?=
 =?utf-8?B?Q2pucWJwK05UdlY3VkxrTnhvTys2R0M1Q0xIRHZtMWVHNUZjN0ZrL0lseW1k?=
 =?utf-8?B?VC9GL0FjcXpLUEhuazhmY0xDVUt5NWpydnVNck4rU2RBRDcxZkhHMUlxRmFs?=
 =?utf-8?B?cFRCWk9qemlvTFQ3MlNqTGlZeEMzWlRKOEZhcSsrRUpJanpzeDdPUHkzMS9Y?=
 =?utf-8?B?L3Y2aGl2VjUzMlZGcVMyWVN6TG0vbGlVdUhSL0FNNy9UWTV2YmZHZk5WdzJV?=
 =?utf-8?B?NFFNMUhCNUJFdGRMNjZtczdRNW1ZRmZjaHlYY3lualNkV0NZMEdXTmpXSm1Z?=
 =?utf-8?B?WE56MC9xRDV4clBhcnZzSWRkRHBBZytYanVzYTRPT0dJY1N5dEpkT25Fdy85?=
 =?utf-8?B?ZythWG51bE9yWEZKYjdOMFNZME9mU3Z2UHM2YnVHMTM0OGt4eERMVkdLUVpO?=
 =?utf-8?B?NjFMMFU3VHAvaTZueUx2end1b0ZKdmJKVjZpa1hBanZVVytXcHZhd2ZFa296?=
 =?utf-8?B?UXpYclJwNmo1b0VhTnQ3dmN0NEFGcnk3Y012QXJOMHV4TlRETlZUbk4zbjdH?=
 =?utf-8?B?dkdCVXB1amJreTYwZmM2YlhyL2V4TW1RRnV1UlNaMWhFL3VHU05uY09sTTNX?=
 =?utf-8?B?aHdwNUhOVFkvTkdtN3E1OWpwN2gvL3BXS1p3d1dhanhNVGdTUjF2TVN5RVZ5?=
 =?utf-8?B?M2ZkOHZYTEg3VDM5cndzcm04OGtFWmc2ZkxQUmJ2d3JxYkR6djBkaHJPb2lI?=
 =?utf-8?B?aTcvekRkTE1UNzVCUkhwczZnU3RPY0Rlem5pTlhmdzBZZkErRkxKdlp3R2JK?=
 =?utf-8?B?cDRCb01SS0JPV3RJVXFBOE9DZG5leENERHc3a2Q3cXdzVjNIOUZjc0t0MzV5?=
 =?utf-8?B?Unc5dEVucGJKTHczODlXdzZLRldOU2xWcy9mR3ZYaU1FWm1wck94M1R1UlRR?=
 =?utf-8?B?MHh2Sy91WHVuQkxYUmNiMlliMUVBbU5mbVVCbzlSMzVXbG5aWDFKTnBJbERJ?=
 =?utf-8?B?OSt0OFIrOVNuTzVkSFl6Q0RyQkh5ZUhlNFJGZmpvZGk0dHRidWNxM2ZWQU5N?=
 =?utf-8?B?MU52WUh6SGtTM3NIOGtXSmxQMG4vUlBxazFzVGM5ejNHL0VzVWMvckExZHFq?=
 =?utf-8?B?ZENUZXBIYmlwOS9OVzA1VFc3aER0bFZWOTZrY2RQNGt3THE0YmtCQXVZc1VB?=
 =?utf-8?B?MU1yRWd5M2I2UFA2UWRmL0ZsRDU5ZUNaYW1SazdQRnlPczRVYTloMzZ4NmJi?=
 =?utf-8?B?VTBaYklzS3E1NHF5bTJjaG14S2taMkhVcVRnOU1ueXFhMnp6K3BSUGxhNjly?=
 =?utf-8?B?SVRyVWw4UVRsQWRCZlEyUTg5ZTdQVFFKWnordHFwNm9aY2RVYWczaEY1WGs5?=
 =?utf-8?B?TGYreDFHcHkrZWl1aGI0WkI0TnROUWQ5ZlgxY2dMQ2phaWlnZUw1d05VZm5Q?=
 =?utf-8?B?Yk1sZWRTSVJmWndLUTQzKzc3Ty80aVJZbjg3U05ZNTJSdFAxTW0yZ1dYU3hT?=
 =?utf-8?B?R3YrM0xveFY3QXBFdVMrYURnZ1R4MDg2aW1ucmcrV3BLL3F3VnRjUHpkU1Vu?=
 =?utf-8?Q?BqP4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ff7186-e44c-4233-fedf-08dc4e26a42c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 06:25:04.9514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: spgXKzaj+lLcc3sM7F8WpYEDm7niaym9sponV8f303FqlXLVyHkkvwt12aGPSBQ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KU2VudDogV2Vk
bmVzZGF5LCBNYXJjaCAyNywgMjAyNCAyOjIyIFBNDQpUbzogV2FuZywgWWFuZyhLZXZpbikgPEtl
dmluWWFuZy5XYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6
IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5k
ZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0v
YW1kZ3B1OiBtYWtlIGFtZGdwdSBkZXZpY2UgYXR0cl91cGRhdGUoKSBmdW5jdGlvbiBtb3JlIGVm
ZmljaWVudA0KDQoNCg0KT24gMy8yNi8yMDI0IDI6MzIgUE0sIFlhbmcgV2FuZyB3cm90ZToNCj4g
YWRkIGEgbmV3IGVudW1lcmF0aW9uIHR5cGUgdG8gaWRlbnRpZnkgZGV2aWNlIGF0dHJpYnV0ZSBu
b2RlLCB0aGlzDQo+IG1ldGhvZCBpcyByZWxhdGl2ZWx5IG1vcmUgZWZmaWNpZW50IGNvbXBhcmVk
IHdpdGggJ3N0cmNtcCcgaW4NCj4gdXBkYXRlX2F0dHIoKSBmdW5jdGlvbi4NCj4NCj4gU2lnbmVk
LW9mZi1ieTogWWFuZyBXYW5nIDxrZXZpbnlhbmcud2FuZ0BhbWQuY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMgICAgIHwgIDQgKy0tDQo+ICBkcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL2luYy9hbWRncHVfcG0uaCB8IDQxDQo+ICsrKysrKysrKysrKysrKysr
KysrKysrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9w
bS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYw0KPiBpbmRleCA4NWU5
MzU1NTZkN2QuLjA0ZjUzZjI2NjdmZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9hbWRncHVfcG0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9w
bS5jDQo+IEBAIC0yMjI2LDE2ICsyMjI2LDE2IEBAIHN0YXRpYyBpbnQgZGVmYXVsdF9hdHRyX3Vw
ZGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV9kZXZpY2VfDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgbWFzaywgZW51bSBhbWRncHVf
ZGV2aWNlX2F0dHJfc3RhdGVzICpzdGF0ZXMpICB7DQo+ICAgICAgIHN0cnVjdCBkZXZpY2VfYXR0
cmlidXRlICpkZXZfYXR0ciA9ICZhdHRyLT5kZXZfYXR0cjsNCj4gKyAgICAgZW51bSBhbWRncHVf
ZGV2aWNlX2F0dHJfdHlwZSB0eXBlID0gYXR0ci0+dHlwZTsNCj4gICAgICAgdWludDMyX3QgbXAx
X3ZlciA9IGFtZGdwdV9pcF92ZXJzaW9uKGFkZXYsIE1QMV9IV0lQLCAwKTsNCj4gICAgICAgdWlu
dDMyX3QgZ2NfdmVyID0gYW1kZ3B1X2lwX3ZlcnNpb24oYWRldiwgR0NfSFdJUCwgMCk7DQo+IC0g
ICAgIGNvbnN0IGNoYXIgKmF0dHJfbmFtZSA9IGRldl9hdHRyLT5hdHRyLm5hbWU7DQo+DQo+ICAg
ICAgIGlmICghKGF0dHItPmZsYWdzICYgbWFzaykpIHsNCj4gICAgICAgICAgICAgICAqc3RhdGVz
ID0gQVRUUl9TVEFURV9VTlNVUFBPUlRFRDsNCj4gICAgICAgICAgICAgICByZXR1cm4gMDsNCj4g
ICAgICAgfQ0KPg0KPiAtI2RlZmluZSBERVZJQ0VfQVRUUl9JUyhfbmFtZSkgICAgICAgICghc3Ry
Y21wKGF0dHJfbmFtZSwgI19uYW1lKSkNCj4gKyNkZWZpbmUgREVWSUNFX0FUVFJfSVMoX25hbWUp
ICAgICAgICAgICAgICAgICh0eXBlID09IGRldmljZV9hdHRyX3R5cGVfXyMjX25hbWUpDQo+DQo+
ICAgICAgIGlmIChERVZJQ0VfQVRUUl9JUyhwcF9kcG1fc29jY2xrKSkgew0KPiAgICAgICAgICAg
ICAgIGlmIChnY192ZXIgPCBJUF9WRVJTSU9OKDksIDAsIDApKQ0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvYW1kZ3B1X3BtLmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL3BtL2luYy9hbWRncHVfcG0uaA0KPiBpbmRleCBlZWM4MTZmMGNiZjkuLjE1NzMzMGMzNzli
ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvYW1kZ3B1X3BtLmgN
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvYW1kZ3B1X3BtLmgNCj4gQEAgLTQz
LDggKzQzLDQ4IEBAIGVudW0gYW1kZ3B1X2RldmljZV9hdHRyX3N0YXRlcyB7DQo+ICAgICAgIEFU
VFJfU1RBVEVfU1VQUE9SVEVELA0KPiAgfTsNCj4NCj4gK2VudW0gYW1kZ3B1X2RldmljZV9hdHRy
X3R5cGUgew0KDQpQcmVmZXIgaWQgaW5zdGVhZCBvZiB0eXBlLiBUaGF0IGFzaWRlLA0KDQpSZXZp
ZXdlZC1ieTogTGlqbyBMYXphciA8bGlqby5sYXphckBhbWQuY29tPg0KDQpUaGFua3MsDQpMaWpv
DQoNCltrZXZpbl06DQpZZXMsIGFncmVlZCwgdGhlIG5hbWUgJ2F0dHJpYnV0ZSBpZCcgaXMgYmV0
dGVyIG9uIHRoaXMgY2FzZS4NCg0KQmVzdCBSZWdhcmRzLA0KS2V2aW4NCg0KPiArICAgICBkZXZp
Y2VfYXR0cl90eXBlX191bmtub3duID0gLTEsDQo+ICsgICAgIGRldmljZV9hdHRyX3R5cGVfX3Bv
d2VyX2RwbV9zdGF0ZSA9IDAsDQo+ICsgICAgIGRldmljZV9hdHRyX3R5cGVfX3Bvd2VyX2RwbV9m
b3JjZV9wZXJmb3JtYW5jZV9sZXZlbCwNCj4gKyAgICAgZGV2aWNlX2F0dHJfdHlwZV9fcHBfbnVt
X3N0YXRlcywNCj4gKyAgICAgZGV2aWNlX2F0dHJfdHlwZV9fcHBfY3VyX3N0YXRlLA0KPiArICAg
ICBkZXZpY2VfYXR0cl90eXBlX19wcF9mb3JjZV9zdGF0ZSwNCj4gKyAgICAgZGV2aWNlX2F0dHJf
dHlwZV9fcHBfdGFibGUsDQo+ICsgICAgIGRldmljZV9hdHRyX3R5cGVfX3BwX2RwbV9zY2xrLA0K
PiArICAgICBkZXZpY2VfYXR0cl90eXBlX19wcF9kcG1fbWNsaywNCj4gKyAgICAgZGV2aWNlX2F0
dHJfdHlwZV9fcHBfZHBtX3NvY2NsaywNCj4gKyAgICAgZGV2aWNlX2F0dHJfdHlwZV9fcHBfZHBt
X2ZjbGssDQo+ICsgICAgIGRldmljZV9hdHRyX3R5cGVfX3BwX2RwbV92Y2xrLA0KPiArICAgICBk
ZXZpY2VfYXR0cl90eXBlX19wcF9kcG1fdmNsazEsDQo+ICsgICAgIGRldmljZV9hdHRyX3R5cGVf
X3BwX2RwbV9kY2xrLA0KPiArICAgICBkZXZpY2VfYXR0cl90eXBlX19wcF9kcG1fZGNsazEsDQo+
ICsgICAgIGRldmljZV9hdHRyX3R5cGVfX3BwX2RwbV9kY2VmY2xrLA0KPiArICAgICBkZXZpY2Vf
YXR0cl90eXBlX19wcF9kcG1fcGNpZSwNCj4gKyAgICAgZGV2aWNlX2F0dHJfdHlwZV9fcHBfc2Ns
a19vZCwNCj4gKyAgICAgZGV2aWNlX2F0dHJfdHlwZV9fcHBfbWNsa19vZCwNCj4gKyAgICAgZGV2
aWNlX2F0dHJfdHlwZV9fcHBfcG93ZXJfcHJvZmlsZV9tb2RlLA0KPiArICAgICBkZXZpY2VfYXR0
cl90eXBlX19wcF9vZF9jbGtfdm9sdGFnZSwNCj4gKyAgICAgZGV2aWNlX2F0dHJfdHlwZV9fZ3B1
X2J1c3lfcGVyY2VudCwNCj4gKyAgICAgZGV2aWNlX2F0dHJfdHlwZV9fbWVtX2J1c3lfcGVyY2Vu
dCwNCj4gKyAgICAgZGV2aWNlX2F0dHJfdHlwZV9fdmNuX2J1c3lfcGVyY2VudCwNCj4gKyAgICAg
ZGV2aWNlX2F0dHJfdHlwZV9fcGNpZV9idywNCj4gKyAgICAgZGV2aWNlX2F0dHJfdHlwZV9fcHBf
ZmVhdHVyZXMsDQo+ICsgICAgIGRldmljZV9hdHRyX3R5cGVfX3VuaXF1ZV9pZCwNCj4gKyAgICAg
ZGV2aWNlX2F0dHJfdHlwZV9fdGhlcm1hbF90aHJvdHRsaW5nX2xvZ2dpbmcsDQo+ICsgICAgIGRl
dmljZV9hdHRyX3R5cGVfX2FwdV90aGVybWFsX2NhcCwNCj4gKyAgICAgZGV2aWNlX2F0dHJfdHlw
ZV9fZ3B1X21ldHJpY3MsDQo+ICsgICAgIGRldmljZV9hdHRyX3R5cGVfX3NtYXJ0c2hpZnRfYXB1
X3Bvd2VyLA0KPiArICAgICBkZXZpY2VfYXR0cl90eXBlX19zbWFydHNoaWZ0X2RncHVfcG93ZXIs
DQo+ICsgICAgIGRldmljZV9hdHRyX3R5cGVfX3NtYXJ0c2hpZnRfYmlhcywNCj4gKyAgICAgZGV2
aWNlX2F0dHJfdHlwZV9feGdtaV9wbHBkX3BvbGljeSwNCj4gKyAgICAgZGV2aWNlX2F0dHJfdHlw
ZV9fcG1fbWV0cmljcywNCj4gKyAgICAgZGV2aWNlX2F0dHJfdHlwZV9fY291bnQsDQo+ICt9Ow0K
PiArDQo+ICBzdHJ1Y3QgYW1kZ3B1X2RldmljZV9hdHRyIHsNCj4gICAgICAgc3RydWN0IGRldmlj
ZV9hdHRyaWJ1dGUgZGV2X2F0dHI7DQo+ICsgICAgIGVudW0gYW1kZ3B1X2RldmljZV9hdHRyX3R5
cGUgdHlwZTsNCj4gICAgICAgZW51bSBhbWRncHVfZGV2aWNlX2F0dHJfZmxhZ3MgZmxhZ3M7DQo+
ICAgICAgIGludCAoKmF0dHJfdXBkYXRlKShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3Ry
dWN0IGFtZGdwdV9kZXZpY2VfYXR0ciAqYXR0ciwNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
IHVpbnQzMl90IG1hc2ssIGVudW0gYW1kZ3B1X2RldmljZV9hdHRyX3N0YXRlcyAqc3RhdGVzKTsg
QEANCj4gLTYxLDYgKzEwMSw3IEBAIHN0cnVjdCBhbWRncHVfZGV2aWNlX2F0dHJfZW50cnkgew0K
Pg0KPiAgI2RlZmluZSBfX0FNREdQVV9ERVZJQ0VfQVRUUihfbmFtZSwgX21vZGUsIF9zaG93LCBf
c3RvcmUsIF9mbGFncywgLi4uKSAgICAgICBcDQo+ICAgICAgIHsgLmRldl9hdHRyID0gX19BVFRS
KF9uYW1lLCBfbW9kZSwgX3Nob3csIF9zdG9yZSksICAgICAgICAgICAgICBcDQo+ICsgICAgICAg
LnR5cGUgPSBkZXZpY2VfYXR0cl90eXBlX18jI19uYW1lLCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBcDQo+ICAgICAgICAgLmZsYWdzID0gX2ZsYWdzLCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBcDQo+ICAgICAgICAgIyNfX1ZBX0FSR1NfXywgfQ0KPg0K
