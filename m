Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E94C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 02:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7576310E259;
	Thu, 28 Apr 2022 02:53:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C99E10E259
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 02:53:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAr70BKCj5fLBwSrXS9d64RnB7/T9K6S4eXMbWH5EpNTitWdex6hBWiEXQ4LIJC5NSUucyb7Y8jbWHYf2IGpsk9hUIAkvTsaWbn58oEBpWGZI+Nc07la82BG7DKow/NI+e2x91vYXCStOoqfXAJa7gVS/zGKp/bFLNq4CllTKaWg+aId4Z9aV62zn+VrJlZTe23SSGoxRekFlIG0USpYBJV1v9ciuybe1Di033lQ3Bw3URtVCo0zh7n9OqzxAS6Mcv9hz7dD8Rt1qge+zXUlyWpA18Opp+6GuC6+1h1f+QGuAcIfLDOAObSbqw8A5vk5IvKXiJ1Y2obBsrRwmKn41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMhHmzx7MClSszV784AWv1m8PZHpTxxrvEyLD0xpfOg=;
 b=myaYQTKBh9/RjVX0l+N6SRMKaFRRkNs6EKU1EA+r0odF3oUtV0Djs+2FRCk+ZaInSHBSSA9ANhuHYOR+cz2+Gac/Mqfu+iVCyHb7Bo2f06EskqrMcc9ixrtmvXI7w1NEZSMSohOnoxvjgiLPwB5nUYwLr3Uf5bidUuCgsySwe1WHlUHk73xBHbpHw313FVIjwD9ZOv6dMS4nmx50J7OiP5eVBHXzx7Dhp3hS09A98mEzABlXakpChKtRb4y/+EIvPHaCGRWs4nckELLkN9BEChgAj85dlMLMlcxfLHgRBN6IWV1oD+kLdj77K/5aZuT/H3/pUiUeOcFhQV1Fb3CetQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMhHmzx7MClSszV784AWv1m8PZHpTxxrvEyLD0xpfOg=;
 b=UCKZB/B6nGbL6mTFMa4wGQcm62+sjj8j+Mh5U2WPiBO0lv/T8cQUj6hT9+uRb/mCQGcNUICxLQujV2xSTw9En4FcZOBZ80I4MAhzyMbNsxREQxVLgnxKB2jvWb74irA/u5InPSq7WQcizh9bMDcFy0FVmU0nks9hZu6hkMPQFWI=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 BYAPR12MB3493.namprd12.prod.outlook.com (2603:10b6:a03:dd::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Thu, 28 Apr 2022 02:53:34 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::6010:8573:5565:6410]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::6010:8573:5565:6410%7]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 02:53:34 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>, 
 "Quan, Evan" <Evan.Quan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: disable runtime pm on several sienna cichlid
 cards(v2)
Thread-Topic: [PATCH] drm/amdgpu: disable runtime pm on several sienna cichlid
 cards(v2)
Thread-Index: AQHYWiFgKh2ZoB4Ipk6h8ORUKNd92a0Do4+AgABKxgCAAAITAIAAsN2g
Date: Thu, 28 Apr 2022 02:53:34 +0000
Message-ID: <DM5PR12MB2469C6A88D7AA5D63772E5ACF1FD9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220427102659.23579-1-guchun.chen@amd.com>
 <DM6PR12MB2619F4B2E3CDA10FC4B93946E4FA9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <CADnq5_OaOhGjTRNDhBYq2wL7njk0REgGjpm4XLeTSDf2nOoYUw@mail.gmail.com>
 <c0520bb5-fc82-2507-40d4-bbf35e673155@amd.com>
In-Reply-To: <c0520bb5-fc82-2507-40d4-bbf35e673155@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe5140e5-6f1d-47de-f08f-08da28c2493f
x-ms-traffictypediagnostic: BYAPR12MB3493:EE_
x-microsoft-antispam-prvs: <BYAPR12MB349331DF6FCCF5818F1C10B1F1FD9@BYAPR12MB3493.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hWYb4wdIHceZciL2/B6FxC/U3ubys/zeKtuS1Suv3+MWMsEbfrfCDY2knCRnBQiVx2o+SQ1uL6xTgm9E5va0gENIctFbpKo5whApogn/YIZe4fV86iRMuB6vykNalVRybVzD02/v/yZknp0zXjXGWIo9fNGB3N1T0OmVggWMAeT1CrjcNEnG5WGiBmXRE5t9FtfyeKOR9ASd0GZ6SxssA7QxZ8cntavXW1PFTnm60xo9LuBmNTiUP0Kc46zoAzgm5/wA/CTv0dYvmaYi6Teih8uGO+VDqJtwmF+4+WEGOJiR5md8h3ti1xgkQMrmdaFTZRBmbuSiUuUsxOfuPbkRJs/1p7Ku/dNDdwG/JMAg5MhocswFxqgwODCvCTeHE+GiopOM9zR601C0tE1qeEi4EFNPzeMH3nGwk1YovIqdbuvTKgprfqoxmCwvrj+SCSlGW59r+LEK7eZlhlitJpmTbRHUp3iXDLv4HSFiMHEtZu5ov2I68TKkPXzavGW3ViQC+E/yQSzzv2iJZAvV9cIhFWcjAhwXTvwFsV6YTH6hIl9FIhHjwJ18VV05u+J9H+PFtSx96GnSYkDS26wWEu8Yzez3fLfIYRUSB9n//NgFjtcwy64B1zJTqjJKoQSNLDZ6DsRKVB+GDS88HpT0FEKBra8w4MVH4Z3ON6IG68MC8Kz+hLPxaPExR3DhJ1NE1IQN3UD9XG7l0TPURoGApm0c6g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(122000001)(38070700005)(7696005)(38100700002)(186003)(86362001)(8936002)(54906003)(52536014)(5660300002)(55016003)(6636002)(71200400001)(83380400001)(110136005)(6506007)(53546011)(508600001)(2906002)(8676002)(33656002)(26005)(4326008)(9686003)(76116006)(66476007)(66556008)(66946007)(66446008)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlU0cVYzY3lKMStiRWRCVDl1QkRjNGJjN0ZXc2ZrekdWTWtUVi90S0JmUllF?=
 =?utf-8?B?NXhTTHJiOEhsaXdOSCtqN3plYmFKKzRwV3V5ZEFia0ZsN1VuNHV3T1dVZ0U0?=
 =?utf-8?B?Z3A0ZHYrekdyeDNnSnlkNkdJN1JkMlRNM2J1NS9xWGhTSyszZUFKRmFJSGFi?=
 =?utf-8?B?ckw5cGJKMnI4QjZ4a1ppN3R0SmN5N2VDVW8zTkdLUytQQ1BVSnpVS2ZtakVH?=
 =?utf-8?B?QUNqc3NNSWNLYkFBWDJ6NUQwZ29KMkwxd0loYTQ0c3RaOTVQMTA4WGZnNEF1?=
 =?utf-8?B?b056OTVzc01oYkZ3MXR3SStsLzM4bnpRZTVqck9nQ214L0RadUM4c0x3eU1E?=
 =?utf-8?B?WTl0Tk1sUmpvTzVkaitQVDIycnp5THdZL3E4eTZBZy9Vb0VlQzFKQm9ySEo0?=
 =?utf-8?B?TW11RjQ3cDM1YU11Q25XREp3cmU3b1V3Z1pqb1N4VUF4Zk1vMUUrYjVRT01C?=
 =?utf-8?B?N2FQSmJESTBoZzVNdG5adWIyMmt2Y2lYU1ZqS3ZHS0dSM1pDUWdjd3FjU3R3?=
 =?utf-8?B?cWFSQVZpUFh2TE02VUJrRjI3ZDAwQTVPVDk0cElheno4a1BDZ2tPNEZPNUR2?=
 =?utf-8?B?OFZKN3phRW1yOGxCdHV1bDRTS21rR2NUVExHMWg2RjBnZ2NxM2lpRk9rdTJ3?=
 =?utf-8?B?R3JMcHRxWkduenlIYUg2a0ljN2p1N3I0c1d4NFQ5NS9icXgwUFVZU2EwcHZS?=
 =?utf-8?B?Sk9yUUx2azUyeW9SckhmRmxkRVJEZ1l5MkpUTDJ2bHZFNkYyTGQ3VitraGlQ?=
 =?utf-8?B?T1Jja3VjWmhwaVhRWjBHWkR0SmpGL3dNeDM3M2VSV1E5QUdDaDdsZDNCdEJ4?=
 =?utf-8?B?UGxMYXpqZUJLY2R2SzJxbS9lVC9tWHVnSUJ6OWtkMVE0OVAxUSswN1dpdUtL?=
 =?utf-8?B?cEkwQmV6bzhrVW1ZT0E0NUhHZmo3M244emR4M0MyN09hU1kwNGw4NkpPQlE0?=
 =?utf-8?B?WWNxcEM4cm1vTGVBOGt2MVFzTHRDVW11Ym1GVTZVK1p0UXpBVFFseU45TE8r?=
 =?utf-8?B?K3VwcjgyK2JqWXpJc3NpNWdkWnVsWW5JSVBkV1ExSGJIc3Vzc0JDbmFPekZH?=
 =?utf-8?B?Q2s1aVFsY0ZhK3lMcDR3aXIyR1J6eHZFRmVwNjQzdUp1RS9BU1g4NTF5YnB4?=
 =?utf-8?B?WUxhWXJvNlpPWld2Q1BXN0gxNkdqaCtLbk9UYm1YYVp1UWllU0hISzZmVWk0?=
 =?utf-8?B?a0dWcEF0YzNSZWVNS0VSMjdtY1ZEWXFzRisrQUxQeGVaSGh1M3FBeC84V3dq?=
 =?utf-8?B?NDJmZzlIRVhYTERHMGs0MlhVQVYzckFxYWJ2cFArY3lWMFJsUlNJSSs2Nmkr?=
 =?utf-8?B?cGdTcU1aaFJwNWRBUWZYRWdCNjhoOGttZHErNzhEOFJRdHZuMnhwbCtMZ1dR?=
 =?utf-8?B?NVE4dlBIR2l4NklpZW9hbFdyd21kYVNjNGJKNmVHclBVY0lkWklHbFp3Sjlu?=
 =?utf-8?B?eGhTenZOT3g1WXcvbUFyQ0tTTkZra1dGK2h3bUlZanFpZlRXZ0lzOE5zTk5H?=
 =?utf-8?B?N0l0SmMxZmJnSUUxenh3eitMMXhBSHVZY2ZsZk1BVzV3a2U5TTdoWEthRHpp?=
 =?utf-8?B?dnNyOGp3d1RqTFpyMTlXL0x2WmRFdVJvenI4NVlMbXdNODNCZU5qMW1aVTJH?=
 =?utf-8?B?czFxeEpuSU5iOWNNcFFteDk0aTBabTc2bCsybDdjSWhjbGNsdFVwSExLZ3A1?=
 =?utf-8?B?MW9RcXEvNERNeVB1dFZsUlpzOGk5RFNLQjEzWGJSL2RMTDlIZVMzRVIvY1c4?=
 =?utf-8?B?THlSaXVkUXF6Q2hEWmx2THU3dFpSNVpQT2NRaStpdkFiN25RNmZZRXRpZWNw?=
 =?utf-8?B?bnFVWUN3MHo5STNJa2JjOTFzSGNFZGVLTmsyWGtoREJySHNzeXY4T0lROFpZ?=
 =?utf-8?B?c3g0Y1ZJeFFQTXVIVFNJelZ5UytLVFI1ZFlwY3gvYlZOWXlZcGJQSHBTVGpa?=
 =?utf-8?B?VkxsekNTTlBBd0xYQlE5bVNxSDJnUW5jcGhQWmF5VnZvSGVvNzVxYlpobCtE?=
 =?utf-8?B?cU1NU3Y1ekI0L25obDF5Wm9PYVE5VkJxWkhGS1dVRHo0M0N4VFBpeW9LNEVl?=
 =?utf-8?B?U05EVUpaaW53R1RMNHR3NVJpNGdyREVzWEVvcWhYRU05RTlzTlVGUFpiRkps?=
 =?utf-8?B?QlAzaFN5Zlg0MzBWSjA2elFpSlVqNUpjNWJNR0lCNDVRNFkzQ1VBVm50NG5t?=
 =?utf-8?B?WkZuWldlNjEvdk5hYTBvQ2I5RHliUk1uN0hocmwwM1J1NGkyTUlNbHlNY3Fi?=
 =?utf-8?B?OWJQSzRNa1lRUTNKV0tWanI3dy9VVEc1QUx5R0crVmpsYWhLT2ZOTks1eHVm?=
 =?utf-8?B?YzVyajVXSTY2YXNlOGJ5RUF1RStVNE5zS2hlMU5IajJSVC9OYXZoQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5140e5-6f1d-47de-f08f-08da28c2493f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 02:53:34.3727 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yfuiS5DXuosqSB4M5w50iL+jr7uX3WvMhclqs3AySwhURsyg//4EwMEBrTEihi+lSzLNxsyFvTz7E/oh8xH0/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3493
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
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SSBoYXZlIHN1Ym1pdHRlZCB0aGlzIHBhdGNoIHRvIGFtZC1zdGFnaW5nLWRybS1uZXh0IGJyYW5j
aC4gU2hhbGwgSSBuZWVkIHRvIGltcHJvdmUgaXQ/DQoNClJlZ2FyZHMsDQpHdWNodW4NCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFt
ZC5jb20+IA0KU2VudDogVGh1cnNkYXksIEFwcmlsIDI4LCAyMDIyIDEyOjE4IEFNDQpUbzogQWxl
eCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+OyBRdWFuLCBFdmFuIDxFdmFuLlF1YW5A
YW1kLmNvbT4NCkNjOiBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+OyBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2Vu
aWdAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBEZXVj
aGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpTdWJqZWN0OiBSZTog
W1BBVENIXSBkcm0vYW1kZ3B1OiBkaXNhYmxlIHJ1bnRpbWUgcG0gb24gc2V2ZXJhbCBzaWVubmEg
Y2ljaGxpZCBjYXJkcyh2MikNCg0KDQoNCk9uIDQvMjcvMjAyMiA5OjQwIFBNLCBBbGV4IERldWNo
ZXIgd3JvdGU6DQo+IE9uIFdlZCwgQXByIDI3LCAyMDIyIGF0IDc6NDIgQU0gUXVhbiwgRXZhbiA8
RXZhbi5RdWFuQGFtZC5jb20+IHdyb3RlOg0KPj4NCj4+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkg
LSBHZW5lcmFsXQ0KPj4NCj4+DQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
Pj4gRnJvbTogQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPg0KPj4+IFNlbnQ6IFdl
ZG5lc2RheSwgQXByaWwgMjcsIDIwMjIgNjoyNyBQTQ0KPj4+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZzsgS29lbmlnLCBDaHJpc3RpYW4gDQo+Pj4gPENocmlzdGlhbi5Lb2VuaWdA
YW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyANCj4+PiBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBMYXphciwgTGlq
byANCj4+PiA8TGlqby5MYXphckBhbWQuY29tPjsgUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5j
b20+DQo+Pj4gQ2M6IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT4NCj4+PiBTdWJq
ZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IGRpc2FibGUgcnVudGltZSBwbSBvbiBzZXZlcmFsIHNp
ZW5uYSANCj4+PiBjaWNobGlkDQo+Pj4gY2FyZHModjIpDQo+Pj4NCj4+PiBEaXNhYmxlIHJ1bnRp
bWUgcG93ZXIgbWFuYWdlbWVudCBvbiBzZXZlcmFsIHNpZW5uYSBjaWNobGlkIGNhcmRzLCANCj4+
PiBvdGhlcndpc2UgU01VIHdpbGwgcG9zc2libHkgZmFpbCB0byBiZSByZXN1bWVkIGZyb20gcnVu
dGltZSBzdXNwZW5kLiANCj4+PiBXaWxsIGRyb3AgdGhpcyBhZnRlciBhIGNsZWFuIHNvbHV0aW9u
IGJldHdlZW4ga2VybmVsIGRyaXZlciBhbmQgU01VIA0KPj4+IEZXIGlzIGF2YWlsYWJsZS4NCj4+
Pg0KPj4+IGFtZGdwdSAwMDAwOjYzOjAwLjA6IGFtZGdwdTogR0VDQyBpcyBlbmFibGVkIGFtZGdw
dSAwMDAwOjYzOjAwLjA6IA0KPj4+IGFtZGdwdTogU0VDVVJFRElTUExBWTogc2VjdXJlZGlzcGxh
eSB0YSB1Y29kZSBpcyBub3QgYXZhaWxhYmxlIA0KPj4+IGFtZGdwdSAwMDAwOjYzOjAwLjA6IGFt
ZGdwdTogU01VIGlzIHJlc3VtaW5nLi4uDQo+Pj4gYW1kZ3B1IDAwMDA6NjM6MDAuMDogYW1kZ3B1
OiBTTVU6IEknbSBub3QgZG9uZSB3aXRoIHlvdXIgY29tbWFuZDoNCj4+PiBTTU5fQzJQTVNHXzY2
OjB4MDAwMDAwMEUgU01OX0MyUE1TR184MjoweDAwMDAwMDgwIGFtZGdwdSANCj4+PiAwMDAwOjYz
OjAwLjA6IGFtZGdwdTogRmFpbGVkIHRvIFNldERyaXZlckRyYW1BZGRyIQ0KPj4+IGFtZGdwdSAw
MDAwOjYzOjAwLjA6IGFtZGdwdTogRmFpbGVkIHRvIHNldHVwIHNtYyBodyENCj4+PiBbZHJtOmFt
ZGdwdV9kZXZpY2VfaXBfcmVzdW1lX3BoYXNlMiBbYW1kZ3B1XV0gKkVSUk9SKiByZXN1bWUgb2Yg
SVAgDQo+Pj4gYmxvY2sgPHNtdT4gZmFpbGVkIC02MiBhbWRncHUgMDAwMDo2MzowMC4wOiBhbWRn
cHU6IA0KPj4+IGFtZGdwdV9kZXZpY2VfaXBfcmVzdW1lIGZhaWxlZCAoLTYyKQ0KPj4+DQo+Pj4g
djI6IHNlcGVyYXRlIHRvIGEgZnVuY3Rpb24uDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBHdWNo
dW4gQ2hlbiA8Z3VjaHVuLmNoZW5AYW1kLmNvbT4NCj4+PiAtLS0NCj4+PiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyB8IDE0ICsrKysrKysrKysrKysrDQo+Pj4gICAx
IGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYw0KPj4+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jDQo+Pj4gaW5kZXggMjYyOTM4ZjBkZmRiLi4xYmY4
ZmY3MWI2YjUgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2ttcy5jDQo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2tt
cy5jDQo+Pj4gQEAgLTQzLDYgKzQzLDE3IEBADQo+Pj4gICAjaW5jbHVkZSAiYW1kZ3B1X2Rpc3Bs
YXkuaCINCj4+PiAgICNpbmNsdWRlICJhbWRncHVfcmFzLmgiDQo+Pj4NCj4+PiArc3RhdGljIHZv
aWQgYW1kZ3B1X3J1bnRpbWVfcG1fcXVpcmsoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpIHsN
Cj4+PiArICAgICAvKg0KPj4+ICsgICAgICAqIEFkZCBiZWxvdyBxdWlyayBvbiBzZXZlcmFsIHNp
ZW5uYV9jaWNobGlkIGNhcmRzIHRvIGRpc2FibGUNCj4+PiArICAgICAgKiBydW50aW1lIHBtIHRv
IGZpeCBFTUkgZmFpbHVyZXMuDQo+Pj4gKyAgICAgICovDQo+Pj4gKyAgICAgaWYgKCgoYWRldi0+
cGRldi0+ZGV2aWNlID09IDB4NzNBMSkgJiYgKGFkZXYtPnBkZXYtPnJldmlzaW9uIA0KPj4+ICs9
PQ0KPj4+IDB4MDApKSB8fA0KPj4+ICsgICAgICAgICAoKGFkZXYtPnBkZXYtPmRldmljZSA9PSAw
eDczQkYpICYmIChhZGV2LT5wZGV2LT5yZXZpc2lvbiANCj4+PiArID09DQo+Pj4gMHhDRikpKQ0K
Pj4+ICsgICAgICAgICAgICAgYWRldi0+cnVucG0gPSBmYWxzZTsNCj4+PiArfQ0KPj4+ICsNCj4+
IFtRdWFuLCBFdmFuXSBCZXR0ZXIgdG8gbW92ZSB0aGlzIHRvIA0KPj4gc2llbm5hX2NpY2hsaWRf
Y2hlY2tfYnhjb19zdXBwb3J0KCkuIEFzIGxvbmcgYXMgc211X2JhY28tPnBsYXRmb3JtX3N1cHBv
cnQgaXMgc2V0IGFzIGZhbHNlIHRoZXJlLCB0aGUgcnVucG0gd2lsbCBiZSBkaXNhYmxlZCBhY2Nv
cmRpbmdseSBJIHRoaW5rLg0KPiANCj4gR29vZCBwb2ludC4gIFdlIHByb2JhYmx5IHdhbnQgdG8g
ZGlzYWJsZSBCQUNPIGVudGlyZWx5IG9yIGVuYWJsZSB0aGUgDQo+IHdvcmthcm91bmQgYmVjYXVz
ZSBCQUNPIGNvdWxkIGFsc28gYmUgdXNlZCBmb3IgYSBHUFUgcmVzZXQgaW4gc29tZSANCj4gY2Fz
ZXMuICBUaGVuIG9ubHkgZGlzYWJsZSBydW50aW1lIHBtIGlmIEJBQ08gd2lsbCBiZSB1c2VkLiAg
Qk9DTyANCj4gc2hvdWxkIHN0aWxsIHdvcmsgZmluZSBmb3IgZXhhbXBsZS4NCj4gDQoNCkFzIGZh
ciBhcyBJIHJlbWVtYmVyLCB0aGUgV0EgcHJvcG9zYWwgc3RpbGwgd2FudHMgdG8gcmV0YWluIEJB
Q08gYXMgYSByZXNldCBtZXRob2QuDQoNClRoYW5rcywNCkxpam8NCg0KPiBBbGV4DQo+IA0KPj4N
Cj4+IEVpdGhlciB3YXkgdGhlIHBhdGNoIGlzIHJldmlld2VkLWJ5OiBFdmFuIFF1YW4gPGV2YW4u
cXVhbkBhbWQuY29tPg0KPj4NCj4+IEJSDQo+PiBFdmFuDQo+Pj4gICB2b2lkIGFtZGdwdV91bnJl
Z2lzdGVyX2dwdV9pbnN0YW5jZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4+PiAgIHsN
Cj4+PiAgICAgICAgc3RydWN0IGFtZGdwdV9ncHVfaW5zdGFuY2UgKmdwdV9pbnN0YW5jZTsgQEAg
LTE4MCw2ICsxOTEsOSBAQCANCj4+PiBpbnQgYW1kZ3B1X2RyaXZlcl9sb2FkX2ttcyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwgdW5zaWduZWQgbG9uZyANCj4+PiBmbGFncykNCj4+PiAgICAg
ICAgICAgICAgICAgKi8NCj4+PiAgICAgICAgICAgICAgICBpZiAoYWRldi0+aXNfZndfZmIpDQo+
Pj4gICAgICAgICAgICAgICAgICAgICAgICBhZGV2LT5ydW5wbSA9IGZhbHNlOw0KPj4+ICsNCj4+
PiArICAgICAgICAgICAgIGFtZGdwdV9ydW50aW1lX3BtX3F1aXJrKGFkZXYpOw0KPj4+ICsNCj4+
PiAgICAgICAgICAgICAgICBpZiAoYWRldi0+cnVucG0pDQo+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICBkZXZfaW5mbyhhZGV2LT5kZXYsICJVc2luZyBCQUNPIGZvciBydW50aW1lIA0KPj4+IHBt
XG4iKTsNCj4+PiAgICAgICAgfQ0KPj4+IC0tDQo+Pj4gMi4xNy4xDQo=
