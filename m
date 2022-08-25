Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EB4C64990
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 14:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD6C610E33C;
	Thu, 25 Aug 2022 14:49:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9C9810E33C
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 14:49:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=in+vdGXpTdnfr5gBJdze1cdPlmlD84NezGZcm2XfoUYeYNzItxZm53kuTHEKkKq7QtNdZ9d6Wx4qgtGSg3whP/uS4cEtC+1P0Y49gH9l6Zvun+9ag/OBmkyoVEU7/Jt2SW9jwcs3oRXwrq27IRxRCthrvXg3O0/Tw8fa4z4RIXJ/ZnrMQNHDPWiPgUJxazH8pr9UT5Ey4Gz7mIp0wlIWSEQ+OmU4ENRHWBLKZoVqCZsrWmPbdu+bqRKb0GGqwT5a8gHBkG6Doa4Q1a112VKZvBTOwm12LoQSjbdvZZo57tYikmNMiWt76f3d4LLBp2cMYPrzKzJC2raD8SXTZg95Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arLhg4iXPHrOnVAxw2EAbqpl+3bW+ztINsm/nFaDzwk=;
 b=OChxYi8BwSdp4aDzoNCsFRc2HW1vwVfi8T6kOuM2Ml1vtifU4SHA0WZfWvazmR23g1PmlBYpWhg3xx1hPDwqvagTf/DF2YaODE8DOj5d26H3Rx+6+XPtGUAuUTR1dwuvWOA6XfiKJV1KeQ7DTYxpzvMoR+ynsKokLchdCxSRua3XrZKr+4lirqcaRWugPP7gLpxsoCWPrHtzrlXO0O6Abh8+ZjojL8ngZJY35nqSxfR2pBBJBFbNiIKd+9a4IK6MWFIp07B6UIEKjVpNu/af1UQpfk+zlQumVzpSglCFHeltox8kvm8L7voJssRn9WL7Hqkz/WKYxDY8CpvG3dL1dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arLhg4iXPHrOnVAxw2EAbqpl+3bW+ztINsm/nFaDzwk=;
 b=qNX1TajZT0ouJ5sykCLFQIcYFnWKLlSfmcgOc1Vpk+ClZZDCw/n0wtSqwLMP5XceUIT9Gk4Fp+B38M0UNqQvdnFjmggWi1Jz5pGZo5Z7d91YBTnTznCgHE54zA7VdSDYVv3qzwH869nP4zgsXAbaRZzMvz60OKl4DBo5jnPcF9g=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 14:49:02 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::98a9:195a:29f5:dcc9]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::98a9:195a:29f5:dcc9%6]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 14:49:02 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: Fix page table setup on Arcturus
Thread-Topic: [PATCH] drm/amdgpu: Fix page table setup on Arcturus
Thread-Index: AQHYtj8zMk3i2rTxGE2jwEc3+nh4xq2/ocmAgAATPyA=
Date: Thu, 25 Aug 2022 14:49:02 +0000
Message-ID: <BL3PR12MB64251CF377D41A059954E76BEE729@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20220822155217.911506-1-mukul.joshi@amd.com>
 <CADnq5_OGYxgEVOahp9wAvoVmhHDazhZwERK2s+x-gc43114URg@mail.gmail.com>
In-Reply-To: <CADnq5_OGYxgEVOahp9wAvoVmhHDazhZwERK2s+x-gc43114URg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-25T14:49:00Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e0ff519f-425e-457f-b1a6-037e68933c67;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90dc2be8-9304-43be-2fdf-08da86a8f36f
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e+w/oc6uyfNQWoAekSxS+svKA/leLNlcgj2lUfp/QfJepF1KER8IJmZOICILwDeVosQlfGl7YOvTf8D5qW5ueGY8ahW4eLX7q6BXCexcFQpVIE/K0WVaZoiHDyidbTm5T2BXjmak/YB2DFioLNBPjzK13DqLtG0rSgAWQ4iYFmOAUQtsYiqEAa0Yp7tBFXY/j50MWXq6poCFfokCYcJ4dx/KBTtyuXq6LEsdQTp/9PNk1AnNPHK4O0MAmH2lFwZUppcM8E9v1vLK6r0MMffrWAdT3aCCcRJu+c7Ja+2wWMAIWkbVF9yL7OwQaqbkf7zKC0dMIf5mKM5RvflIPXxT4aLTi9Jg8lqkRIY2ZQ62QqTS5RiZqZkSsmPf/kya4/8Otyhsi1d/AyPZ9j6ymCSo/4WgcgS+1dt3nbRcwsBjWi+C/Hm+x+qxoPwWL5QJhHeJdPjONs6Mb/0J6GiTW2/OVsuDcYRFy2BYCc+H1gdoM6jMf9zenzgv2b9BhiVqBmEccqKZ0LV86DLfIK/0KBJy+C4uNRdvB4if7nnK1+gfIpgncpJRPfMOf3rYvh3w/YJ1QH4//soHu+gP7JCGBmxu9ai5xLsBe3SqLDfodkE6UQdWhUbecqBU/AAiwUSBaeBHFjPhj762FFG5yWLt0MRklvNFZ7RmARcBVzR7a2AkVqRPMIaqirdZDtZZPQjFOsKg37M8V85jI1fXeSK/iYQ5lpNao25doiM3K4hOAdWbJiOjVKnBWm+7LDeOCZpIi2O6HE2ywF/oNWpreCULGsQGlQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(53546011)(83380400001)(478600001)(41300700001)(6506007)(7696005)(26005)(2906002)(9686003)(33656002)(52536014)(186003)(86362001)(66556008)(38100700002)(5660300002)(66446008)(8936002)(122000001)(316002)(38070700005)(6916009)(55016003)(71200400001)(64756008)(76116006)(66476007)(4326008)(66946007)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1VxdnNzR2ZtQTBCWnNVV1M3SG9YdW1zbG9NV2JQQU5NSXZWT1hWR2Z4Skpp?=
 =?utf-8?B?SlNxSkVoY3ptdzBTSmErd3NQMC9VYnN6SmRjQ0RmclUxWmwrUWpRMFFiSEZr?=
 =?utf-8?B?elg2TjBGQ1N4NVRucE9xdW1PVDNHWUZqYVZlWldxMnR3RWVtSlNGa2k2ckwr?=
 =?utf-8?B?bHpsVDc1QVRSUGd5ay9hMGF5ZFB0ZE1RTGRicG5GUlppMk9TUGxEZWxSZjVI?=
 =?utf-8?B?NjcvVWNJSkxTT2NNTjVVa0JRT1dLN0czMVVNeFZFQ3dOdHNwZHBabytvTHVC?=
 =?utf-8?B?RUdwVUxEb2ttMDZmRlNjT3F4aG9pRHYwMGhyM0dHWTQ2RE4raFlHd2VXQUhV?=
 =?utf-8?B?TGt6MjhJR09Mck9tVzlETExkQm5VR3M5SkZoUmlIYjF3VjlCYmxXOHViZks1?=
 =?utf-8?B?aXVxbU8zTzFNNTdsWDdNYmZoTmtBcWIxa05iMStSRzFUMDJpcWo1OUhQRndJ?=
 =?utf-8?B?Zmt6V241MGQveUpGd2pudzJ0VGF4STdkcGUzWUpvZWtDN21zd1EyM05rZTdS?=
 =?utf-8?B?bk1lMDVrSE1hdHhMMGlhSG5PSVdoZ3BhNEs3OHhjd1FRVVZ3dFhuTytoQkhQ?=
 =?utf-8?B?VEhUVUtNTGJKd01GNWI5WEpJc2d6SXhTZEQwUTRObENaTEV0S1JTYUovM1Vx?=
 =?utf-8?B?Yi9ITEg0dnZEL1BSc0JyVUhqamJpalAwNHpldE9vUWtwTG1RWU5rRm5MODdq?=
 =?utf-8?B?bDZFa2pJL3RlODVDUXh5SHJiQXBLMWE3OUQyb2N2elk1SHFiM2dhWCsrdVpN?=
 =?utf-8?B?b21ITW1wMTdZR3hzcGtseGZDRDBSNmFhQzdvSVJ2eEVGc2x6UTk4UnFnYXZa?=
 =?utf-8?B?QXhlVlB2QkJwZVEzMlVON0IvUjczRzhVTjRzN2tSR2RPejdpU3dyZk82MVlB?=
 =?utf-8?B?clFIbFpONzBPZWFQZEZjdUxzblFmUmtOTW4xSDZsMEdJWnY3bTJGWTI0dmlC?=
 =?utf-8?B?TWoyUklSUG9UODZ5MkNyeitaaVBJQWdBMkRrc215RkZ0dStsYzJnNXJ4U2Fh?=
 =?utf-8?B?V2Z6VTBrclNBUEZ6NG5ITU5JdW5PRzdtS3cwNnppbStHSUNLaTBkdG5DYkVV?=
 =?utf-8?B?T1VCaEhpenUweGtiSEcrY201ZlNidTZCQTY2akdIRGs5cE92eXlOcFNrSWxu?=
 =?utf-8?B?YWhCT1EwbUcycFpXWTNyM0tJRmJ3NlRpbG5ta3lKajMxdGo1disvUjNsNy9R?=
 =?utf-8?B?Vlk4YVpLVWRYMHlwcGFOckFlK3A2SFFkOWdKUFlIQm1UaGI5cEp4Qnk4Y3Nw?=
 =?utf-8?B?NkRtL2lHSnBBeHFmS0s0aXdKYkFQY2ZyNW9LV2xWVzJVckc3UjNocEdmZ20z?=
 =?utf-8?B?L3RBOHNydW1UVlVXWEhQTU9ZViswSGp6a3FjR2dLZmhleXRjSndIdjVYR2Nx?=
 =?utf-8?B?bnY0azJSUXZ1UUNiazltVzZGRUJGUzIyVjZLSDZ4THhBRDZhb2MxT3Z4WnFT?=
 =?utf-8?B?QWovdUxtTkNsbFBJV1FONVIxb29xeTNBUGw4T01qSHlVNktJQXlQcHZ5aUR6?=
 =?utf-8?B?TFhOMUhwcXc4Z0R0VmRCVGp5STNiUVAvOGg4MXJzbDNQSGN5NzllUktWRHRH?=
 =?utf-8?B?NjJXcWZqeit1RTdzOXpDVmlJWFo3Z0x1Sk9FNnpTcnFDYTF4ZEVicnZpcW9B?=
 =?utf-8?B?MjVYYUxLSzJKMXBpM2VzcU5QbzVDTFg4cmk1aytBRzZTTmd1WUJrRXZScEFW?=
 =?utf-8?B?SjVVYnRvcUF4UHIvU05mZm45R1drQ29jOTI4OVE2Ymt5TFZFdzhnTldKTUhz?=
 =?utf-8?B?bjZ4MVAwcGdsNVlpOS9EclhIRXZ0dWh3Zk9FV053SGhJeWFHSFB1U3UyelVv?=
 =?utf-8?B?elBCVEtqdXFMdElubGNrTUVvcElGSWIxN1RCY1duVlNESjJOSUI4bmpPT29Q?=
 =?utf-8?B?Qm1YMGtrbWR6d1pTdmo1bTVXMk4yNGhZbnhQQVlIZWFmajNJc05vNFJzUjNE?=
 =?utf-8?B?eDZJcDZmUHRVTUxHa1MzN0dEWCtOaU43OEJnekp6S0lHdVBKK0JIZVBqYmYz?=
 =?utf-8?B?RXhzbGdsTTFGR0VqM2VSR1B3bkd3L2Z4N1Qvb0hJOWM5aWNoallnWlNQNFBM?=
 =?utf-8?B?RnlCOTVtTnFyWU95K0hOTkF2ZjJzZS9sOU9oMmRaVzBLbWpONUVZZFJZYVBS?=
 =?utf-8?Q?uXYs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90dc2be8-9304-43be-2fdf-08da86a8f36f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 14:49:02.2812 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uIBCO2fEZtTG7bAFi6AhTLN16IH5n7OuucH/7XPQenytyc9VJRcsXwem89nYkL1TTEOzhgmnldHGLnXnom9aXw==
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29t
Pg0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDI1LCAyMDIyIDk6MzMgQU0NCj4gVG86IEpvc2hp
LCBNdWt1bCA8TXVrdWwuSm9zaGlAYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IEZpeCBwYWdlIHRh
YmxlIHNldHVwIG9uIEFyY3R1cnVzDQo+IA0KPiBbQ0FVVElPTjogRXh0ZXJuYWwgRW1haWxdDQo+
IA0KPiBPbiBNb24sIEF1ZyAyMiwgMjAyMiBhdCAxMTo1MyBBTSBNdWt1bCBKb3NoaSA8bXVrdWwu
am9zaGlAYW1kLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBXaGVuIHRyYW5zbGF0ZV9mdXJ0aGVy
IGlzIGVuYWJsZWQsIHBhZ2UgdGFibGUgZGVwdGggbmVlZHMgdG8gYmUNCj4gPiB1cGRhdGVkLiBU
aGlzIHdhcyBtaXNzaW5nIG9uIEFyY3R1cnVzIE1NSFVCIGluaXQuIFRoaXMgd2FzIGNhdXNpbmcN
Cj4gPiBhZGRyZXNzIHRyYW5zbGF0aW9ucyB0byBmYWlsIGZvciBTRE1BIHVzZXItbW9kZSBxdWV1
ZXMuDQo+ID4NCj4gDQo+IERvIG90aGVyIG1taHViIGltcGxlbWVudGF0aW9ucyBuZWVkIGEgc2lt
aWxhciBmaXg/ICBJdCBsb29rcyBsaWtlIHNvbWUgb2YNCj4gdGhlbSBhcmUgbWlzc2luZyBzaW1p
bGFyIGNoYW5nZXMuDQo+IA0KDQpJIGFtIG5vdCBzdXJlIGlmIHRoZXJlIGlzIGEgcGxhbiB0byBl
bmFibGUgdHJhbnNsYXRlX2Z1cnRoZXIgb24gb3RoZXIgQVNJQ3MuDQpGb3Igbm93LCBpdHMgb25s
eSBlbmFibGVkIGZvciBBcmN0dXJ1cywgQWxkZWJhcmFuIGFuZCBSYXZlbi4NCklmIHdlIHBsYW4g
dG8gZW5hYmxlIGl0IG9uIG90aGVyIEFTSUNzLCB0aGVuIHllcyB0aGUgb3RoZXIgbW1odWIgaW1w
bGVtZW50YXRpb25zDQp3b3VsZCBuZWVkIHNpbWlsYXIgY2hhbmdlcy4NCg0KUmVnYXJkcywNCk11
a3VsDQoNCj4gQWxleA0KPiANCj4gPiBGaXhlczogMmFiZjI1NzNiMWM2OSAoImRybS9hbWRncHU6
IEVuYWJsZSB0cmFuc2xhdGVfZnVydGhlciB0byBleHRlbmQNCj4gVVRDTDIgcmVhY2giDQo+ID4g
U2lnbmVkLW9mZi1ieTogTXVrdWwgSm9zaGkgPG11a3VsLmpvc2hpQGFtZC5jb20+DQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuYyB8IDEyICsrKysr
KysrKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9t
bWh1Yl92OV80LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3Y5XzQu
Yw0KPiA+IGluZGV4IDZlMDE0NWIyYjQwOC4uNDQ1Y2IwNmI5ZDI2IDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuYw0KPiA+IEBAIC0yOTUsOSArMjk1LDE3
IEBAIHN0YXRpYyB2b2lkDQo+ID4gbW1odWJfdjlfNF9kaXNhYmxlX2lkZW50aXR5X2FwZXJ0dXJl
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiA+IHN0YXRpYyB2b2lkIG1taHViX3Y5XzRf
c2V0dXBfdm1pZF9jb25maWcoc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4gKmFkZXYsIGludCBodWJp
ZCkgIHsNCj4gPiAgICAgICAgIHN0cnVjdCBhbWRncHVfdm1odWIgKmh1YiA9ICZhZGV2LT52bWh1
YltBTURHUFVfTU1IVUJfMF07DQo+ID4gKyAgICAgICB1bnNpZ25lZCBpbnQgbnVtX2xldmVsLCBi
bG9ja19zaXplOw0KPiA+ICAgICAgICAgdWludDMyX3QgdG1wOw0KPiA+ICAgICAgICAgaW50IGk7
DQo+ID4NCj4gPiArICAgICAgIG51bV9sZXZlbCA9IGFkZXYtPnZtX21hbmFnZXIubnVtX2xldmVs
Ow0KPiA+ICsgICAgICAgYmxvY2tfc2l6ZSA9IGFkZXYtPnZtX21hbmFnZXIuYmxvY2tfc2l6ZTsN
Cj4gPiArICAgICAgIGlmIChhZGV2LT5nbWMudHJhbnNsYXRlX2Z1cnRoZXIpDQo+ID4gKyAgICAg
ICAgICAgICAgIG51bV9sZXZlbCAtPSAxOw0KPiA+ICsgICAgICAgZWxzZQ0KPiA+ICsgICAgICAg
ICAgICAgICBibG9ja19zaXplIC09IDk7DQo+ID4gKw0KPiA+ICAgICAgICAgZm9yIChpID0gMDsg
aSA8PSAxNDsgaSsrKSB7DQo+ID4gICAgICAgICAgICAgICAgIHRtcCA9IFJSRUczMl9TT0MxNV9P
RkZTRVQoTU1IVUIsIDAsDQo+IG1tVk1MMlZDMF9WTV9DT05URVhUMV9DTlRMLA0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaHViaWQgKiBNTUhVQl9JTlNUQU5DRV9SRUdJU1RF
Ul9PRkZTRVQNCj4gPiArIGkpOyBAQCAtMzA1LDcgKzMxMyw3IEBAIHN0YXRpYyB2b2lkDQo+IG1t
aHViX3Y5XzRfc2V0dXBfdm1pZF9jb25maWcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGlu
dCBodWJpZCkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFTkFCTEVf
Q09OVEVYVCwgMSk7DQo+ID4gICAgICAgICAgICAgICAgIHRtcCA9IFJFR19TRVRfRklFTEQodG1w
LCBWTUwyVkMwX1ZNX0NPTlRFWFQxX0NOVEwsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgUEFHRV9UQUJMRV9ERVBUSCwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBhZGV2LT52bV9tYW5hZ2VyLm51bV9sZXZlbCk7DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgbnVtX2xldmVsKTsNCj4gPiAgICAgICAgICAgICAg
ICAgdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIFZNTDJWQzBfVk1fQ09OVEVYVDFfQ05UTCwNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSQU5HRV9QUk9URUNUSU9OX0ZB
VUxUX0VOQUJMRV9ERUZBVUxULCAxKTsNCj4gPiAgICAgICAgICAgICAgICAgdG1wID0gUkVHX1NF
VF9GSUVMRCh0bXAsIFZNTDJWQzBfVk1fQ09OVEVYVDFfQ05UTCwgQEANCj4gPiAtMzIzLDcgKzMz
MSw3IEBAIHN0YXRpYyB2b2lkIG1taHViX3Y5XzRfc2V0dXBfdm1pZF9jb25maWcoc3RydWN0DQo+
IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGludCBodWJpZCkNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBFWEVDVVRFX1BST1RFQ1RJT05fRkFVTFRfRU5BQkxFX0RFRkFVTFQs
IDEpOw0KPiA+ICAgICAgICAgICAgICAgICB0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgVk1MMlZD
MF9WTV9DT05URVhUMV9DTlRMLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFBBR0VfVEFCTEVfQkxPQ0tfU0laRSwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBhZGV2LT52bV9tYW5hZ2VyLmJsb2NrX3NpemUgLSA5KTsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBibG9ja19zaXplKTsNCj4gPiAgICAgICAgICAg
ICAgICAgLyogU2VuZCBuby1yZXRyeSBYTkFDSyBvbiBmYXVsdCB0byBzdXBwcmVzcyBWTSBmYXVs
dCBzdG9ybS4gKi8NCj4gPiAgICAgICAgICAgICAgICAgdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAs
IFZNTDJWQzBfVk1fQ09OVEVYVDFfQ05UTCwNCj4gPg0KPiA+IFJFVFJZX1BFUk1JU1NJT05fT1Jf
SU5WQUxJRF9QQUdFX0ZBVUxULA0KPiA+IC0tDQo+ID4gMi4zNS4xDQo+ID4NCg==
