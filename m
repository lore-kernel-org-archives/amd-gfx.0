Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854E0CD1284
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Apr 2024 08:35:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA48810FB53;
	Tue,  2 Apr 2024 08:35:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KvNswaa3";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2119.outbound.protection.outlook.com [40.107.92.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D16CC10FB52
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Apr 2024 08:35:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+GCDPtQVV5qy5ZRBngN25c91CSJK5lcP+us/86wTchYqzcPrI6sXQ7pRRQxLmuiDJX8dUKJOlZ/Aj4CDVgApYzqBKMdRdJZ77lSucKW3w2QIGl+eowWTauHF4LaKzZjxUMxTEtK65Nml8hvg8duddC7icVmlzmL+ZlSBOVwg22cG1dXEnJQeXY6IG0q7sIcWlhGatZi16hql2MHOFo+Ue05qRKOio6mwMwbWHfqO4n/mSiiz7Z32GbxKZF8TdDa7qI3KQG3Gq3YeB/TXUw4OOQhK4fCE+b4DrqYeILqhA9fvh+Urko8uOC+LmsXWcxEEmimjXDoO9HbCU89FUEyiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozOdfk/1OwND6J9Czt85p31g+AfvhKQqKUHH66jpkkA=;
 b=LI23Pf0wjLZD5EGa75RE/wiGQJ4665BoZmBqjy2UVoQA4PuJkDGoYzrIeeFRZXxNnap6evcsEigtm4ZDfcyfIIJLyYAYRFTm+P5atQCyymywkJHSKpta+VkmE0SdJdMWGa+rQbXtfZyJ6njiWev8f/CE6vNAeWrpsTZ1HpodY2rjlPGDfTzsU7PEMFJPp20CxXNQf+Fl3y9ou9ls3q3Uu0xvfX09uBRr6nKuS1WsS25CmI3uX2FpUPFO7upLSQdOKi5ui1QAUKWw+oPaEFBh2+2TMDqgHsM0+6xngoxfSjb7RCD+4l+IoeDX0gCdh5urGwA5FMnhoVpMmrQFNWZgZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozOdfk/1OwND6J9Czt85p31g+AfvhKQqKUHH66jpkkA=;
 b=KvNswaa3lvF3XIEGhSY5yf6AWMyETuRNAXJG4nd06oThUS+7jt4D85dkf58cNq5YWqk3D0vPEF2D0pxL1m545Yd1ypUAxkYKGDbn2JRcP8uUMxTAfFIpp78t7RVFJzumLoFyCXoAGDjWx2KYabZOk8ugdbi3dZQWShM6UF9bfcM=
Received: from SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14)
 by DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 08:35:28 +0000
Received: from SA1PR12MB6680.namprd12.prod.outlook.com
 ([fe80::43e8:58fd:8ed7:2bd7]) by SA1PR12MB6680.namprd12.prod.outlook.com
 ([fe80::43e8:58fd:8ed7:2bd7%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 08:35:28 +0000
From: "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: clear set_q_mode_offs when VM changed
Thread-Topic: [PATCH] drm/amdgpu: clear set_q_mode_offs when VM changed
Thread-Index: AQHahMhJnZp5mugIDEGhi4TMR2TSFLFUodsAgAADPqA=
Date: Tue, 2 Apr 2024 08:35:28 +0000
Message-ID: <SA1PR12MB6680D43F47AD24B03AFC4941E93E2@SA1PR12MB6680.namprd12.prod.outlook.com>
References: <20240402063737.2935698-1-zhenguo.yin@amd.com>
 <1fbcd7b2-d152-4931-a7c7-2cc82ff9b543@amd.com>
In-Reply-To: <1fbcd7b2-d152-4931-a7c7-2cc82ff9b543@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7dd809f4-0ca5-4b6c-8df4-0c9f4385a1ec;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-02T08:25:33Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6680:EE_|DM4PR12MB7527:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c9vXEW1QaYF/eZAUVbxQyHDzcwmuWk1S2FfVAvRSZaW9+bhDgFnajBOPFo9lgwBZKohzCto5jXVsEK3GdBrkyYsYGCL7ZbA16fwa/wWR4OUjeh+1Xn123MNydfNwWq1LJ0ZpwWLIzAOaRU2qRbnBnisn2H9YFZ10cpr9YRzLUEUeIEzALAABhZuZCwFsHqE2B/v5i2Z2vixlNsK1XLDAVGkHQCSYjRawikBa6YWitdQ5m1eKLHY4oQmOjCl3LiFbebw6HffPFHLiCK5sF7gtleD0mvAzCQATI+xWZWIiGLvvDa9DUwi//3GmXbPaK+fRzj3kVPdcJwknAjlCE05Ztft2j7/D+mq92yqxEw//JRfXwUzwmvq1IuFHj9Xs3JQVyRo/T6b+4BR0zVHUnUvONLW1Cy//0He0gi/Mi186rCZ6MNXW/Yu6emFzkzzWtff0xa4mGfALccNgfxSVEJfhIHFnMuFsoJzrLdBLhwXz4LH2QcmoPpj8FKi7ylErcysiH0cb5lv8ACvbKL5unvkPeAAWUYRpqlRbRQCX438aphZy5ttkj6iTK6F298oi8YGbl8asKWmArpj8lkNO67NGi6/f1kiQffSrEl+zC+0lvl3jFwTWQYaT6zHKvIit8zjbaVqRnRt97ggg+ROZjd5xBv9izi5MuwgVYG2SjjIJKpE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB6680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aU95dDdFVGNEVnU1ODJhZVZsR3g1czduNmpoc2VMNDlxQ2F3OVJReVF4b1p3?=
 =?utf-8?B?L2JKL0dJZDVmVHFDcHpqNCttSHE2cXAxM0Y4N0NMb1JaVWdpbmJJNmFjOHQy?=
 =?utf-8?B?QWhOY1FFZ2dSWlYrTVdkblk0Q25hdUs5Ly9TQ0hDbDNmTWxycFhzbEM0RlM3?=
 =?utf-8?B?T2RZOGkzNnl5VzFqcmZ3dzMvL1RFSUxySXAzQjBNTEEyc1B2Y3o3QnRFazBk?=
 =?utf-8?B?a0FzcU4wakd4SkoxTVJ3elBvQlcxbjl6ZWxqVWJ0SzdEWWlLZU4vMDFtbGt0?=
 =?utf-8?B?UFIzeGxyY1cxcS9yakZuNk1xaEovYU54YWdZVFV6UlF1RnlYS0hRYWFBUEV0?=
 =?utf-8?B?MGxPbEdFK1djWWFOSklHZDRBQVorZDZWNHNORER1QVI5d3BvQVBzTXQrVk5E?=
 =?utf-8?B?cVZKQmFtdUYxczJLeXhrV0MyZjlCNzROaXN2MkJsTkV0NU9VTUg3dlFwRzJS?=
 =?utf-8?B?cnRVSUROUHZKc1NyU1dWUEQwa2kxY3FJRlA4SnVZK2doNGprdXp6Uy9acS9F?=
 =?utf-8?B?bnhPN0dGd3BVNHlHQmRiMml5L0E2MStDV2JzOWlrdlpzNFdDbTQyUHB2L21R?=
 =?utf-8?B?dkYrdFFtVmtEa3NtSXhGWUFTVGl3Ny9RampNZWlSZlJ6cGlKSkVvVVNHU2Zk?=
 =?utf-8?B?aXhMWm9Yc2pUSTI0cG9HV0grbmZPMFp3YjBRSTczOGp2N2Jnb0FZc3pQa3BD?=
 =?utf-8?B?c1FkS3RUWmlQSC9CbzF0TVVzOHc0aG5WNHBLSXNpMXhocURFak1DK3FGVi9W?=
 =?utf-8?B?YVNnNlcxRzhrWDJqMTlob05BUmExNFhUQ21WNThtVU9PRjFrblBzMW1mbXZK?=
 =?utf-8?B?UzJuTEl3eUc3M2FtV3lXQ3lJMklBSFdvc2w4SVRZTkFTWmFZeEdkczJFMTFP?=
 =?utf-8?B?b2hGVHB6S05Ec3B5OXhzWWFqYndpU2VtWDN4R29SeGFHdTg2S0lZdFVCL3lw?=
 =?utf-8?B?Vnp4eEJES0h0ZUhEVDRRVjV1MzY5M2g0c01ZNFlPbnc2b20wZldKb2xRa3NW?=
 =?utf-8?B?VUFOYTZvVnMvblBRSy9LamhsYkNLVGt2cDZYKzBCc3EzL2gwSEFSQnJpNEdV?=
 =?utf-8?B?bzZVOGpqSjlsY0J0THRickxZQ0JHaU96dnZkb1U0SGs0eGY5NTU3Vnk0eDVz?=
 =?utf-8?B?STRPcWY1MnRjZTlvY21EOWVTZTJxRGh0dElNbUw3N296OWJTbXNKY0JmcnR3?=
 =?utf-8?B?RG9tNGpBSHlUcmdUaTREREhXZGxqMGJUbEkvamt1T1lScTArVnlQSGJXNlN0?=
 =?utf-8?B?cEZKSWNsYjhjWXFVSmdsd1QveGdERFpKRUV5YlFyOGtDeVFNTkl3QUlWTGtq?=
 =?utf-8?B?NXlSWGpKd1lFRVpRNFZFK2lvdmlycTRFbG42bnVWWTZWK2p6OGxOa21tT2xI?=
 =?utf-8?B?ZUJTNGR3Sk40dHIyS21lMFhqY1JPc1oxc21IWE1CbFlad0htendHWXZ6SzlI?=
 =?utf-8?B?QStYbGxVMEpkVGlSamlpTHZHY1NLdUFUd0lwWVY5Y2hvbFhPTDc0ZzhTWGxQ?=
 =?utf-8?B?QVk3dU5XYkIzcVhDVVgzQ1VRU1VCR2V2MVNoR3IrQ3BpNXFOL0p2cUR3cnNL?=
 =?utf-8?B?dnpFUlp0aUI0S0ZKTnkzd21wbnFjOWVmdGxOamtWRXNDLzNCbjh4akhrc3Az?=
 =?utf-8?B?LzRzSDg5dW11WnRBWFl6RGJHYnNYNHNVYTBRNGNtQnpZVjQxSkdYSUY4bTQ0?=
 =?utf-8?B?Sm5DZVE2emtaeTRpQVVtdDhWKytyL0Z6bjlZTkNVa0RDMys2UzFYYnB6UFhH?=
 =?utf-8?B?ZHhSVWdOeGUyUFlCYmo3eVEvWC9EWGxMNWZVRTFYR3VmQm9jSWV5NUFUT3I1?=
 =?utf-8?B?TFRnT0laQTVVc05hT084OTFkZ3FVZzdKY2ZZVUJrckFSWENYaGF1SmxJUitF?=
 =?utf-8?B?VUxTcGluaUg4Z2VVelk5bTlFRHFYOTl2SXUxSVlQOVdkUE1EQ0tlSVJQNHpU?=
 =?utf-8?B?QVBuUjMvWW1hc2FYRS9UdlNjTEtuN1hVODhqaWRZODZtSFZsMSs1N09BRmxH?=
 =?utf-8?B?bGtsS2UxaHRqUEZvdDdJSXlYSVRrV1drTXR2NEgyRWpWamlVaWgzZEc1UjMv?=
 =?utf-8?B?NFpHdkQ1dHdDL2NsRTdxTzdhUlJVZVRjT1VDaHplOVJnVnNQcDJUZ3NJUlpq?=
 =?utf-8?Q?4ZHE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0107d9b-cd13-4377-7374-08dc52efd99b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 08:35:28.0978 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1BXJXTuGcg0CA9Hg5IW4QUfPinir+DBhxK8kH9WTW4/8DZuFQ9J9RP8ZkQ+W4pfRVtoiV2ED1CLDcbLEu6udkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClllYWgsIEkgYWdyZWUuICBCdXQg
SSBoYXZlIG5vIGlkZWEgd2hpY2ggcGxhY2UgaXMgYmV0dGVyLg0KDQpCZXN0LA0KWmhlbmd1bw0K
Q2xvdWQtR1BVIENvcmUgdGVhbSwgU1JEQw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NClNlbnQ6
IFR1ZXNkYXksIEFwcmlsIDIsIDIwMjQgNDoxNCBQTQ0KVG86IFlpbiwgWmhlbkd1byAoQ2hyaXMp
IDxaaGVuR3VvLllpbkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNj
OiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpTdWJqZWN0
OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBjbGVhciBzZXRfcV9tb2RlX29mZnMgd2hlbiBWTSBj
aGFuZ2VkDQoNCkFtIDAyLjA0LjI0IHVtIDA4OjM3IHNjaHJpZWIgWmhlbkd1byBZaW46DQo+IFtX
aHldDQo+IHNldF9xX21vZGVfb2ZmcyBkb24ndCBnZXQgY2xlYXJlZCBhZnRlciBHUFUgcmVzZXQs
IG5leHRpbmcgU0VUX1FfTU9ERQ0KPiBwYWNrZXQgdG8gaW5pdCBzaGFkb3cgbWVtb3J5IHdpbGwg
YmUgc2tpcGVkLCBoZW5jZSB0aGVyZSBoYXMgYSBwYWdlIGZhdWx0Lg0KPg0KPiBbSG93XQ0KPiBW
TSBmbHVzaCBpcyBuZWVkZWQgYWZ0ZXIgR1BVIHJlc2V0LCBjbGVhciBzZXRfcV9tb2RlX29mZnMg
d2hlbg0KPiBlbWl0dGluZyBWTSBmbHVzaC4NCj4NCj4gRml4ZXM6IDhkYWQ5YzA2MjM1NSAoImRy
bS9hbWRncHU6IHdvcmthcm91bmQgdG8gYXZvaWQgU0VUX1FfTU9ERQ0KPiBwYWNrZXRzIHYyIikN
Cj4gU2lnbmVkLW9mZi1ieTogWmhlbkd1byBZaW4gPHpoZW5ndW8ueWluQGFtZC5jb20+DQoNCkdv
b2QgY2F0Y2gsIHllYWggaXQgcHJvYmFibHkgZG9lc24ndCBtYWtlIG11Y2ggc2Vuc2UgdG8gZXhl
Y3V0ZSB0aGlzIGFmdGVyIGEgVk0gZmx1c2guDQoNClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQoNCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMV8wLmMgfCAxICsNCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92MTFfMC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMV8wLmMN
Cj4gaW5kZXggN2E5MDYzMThlNDUxLi5jMTFjNjI5OTcxMWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5jDQo+IEBAIC01NDY1LDYgKzU0NjUsNyBAQCBzdGF0aWMg
dm9pZCBnZnhfdjExXzBfcmluZ19lbWl0X3ZtX2ZsdXNoKHN0cnVjdCBhbWRncHVfcmluZyAqcmlu
ZywNCj4gICAgICAgLyogTWFrZSBzdXJlIHRoYXQgd2UgY2FuJ3Qgc2tpcCB0aGUgU0VUX1FfTU9E
RSBwYWNrZXRzIHdoZW4gdGhlIFZNDQo+ICAgICAgICAqIGNoYW5nZWQgaW4gYW55IHdheS4NCj4g
ICAgICAgICovDQo+ICsgICAgIHJpbmctPnNldF9xX21vZGVfb2ZmcyA9IDA7DQo+ICAgICAgIHJp
bmctPnNldF9xX21vZGVfcHRyID0gTlVMTDsNCj4gICB9DQo+DQoNCg==
