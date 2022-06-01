Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB93C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 01:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C9C110E2A6;
	Wed,  1 Jun 2022 01:59:55 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2049.outbound.protection.outlook.com [40.107.102.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3519C10E2A6
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 01:59:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIVX10B34GUW5xdUseEhOy8Fz+bC0zmaWhouNCoHt1AiyQMVzFlrV+z0sH7o44pdc672CrdPAfCLuZztH3y/acKcoQ5We4wmFah/PD5C6Mz36yb6KQnjsJL8SxT/NGM2znggW3wfg+xV9W75BL2B/n+ozx5wM/Q7/BhbhZmW/pOkCD3w6/dihm9jNX90fA2+OHsdN1bCIYvZ0Pt22IISD2/2L448nMcrBvNLl0j3VAkOQ1qlVxvn3P6eKAXn/x/fCOsK8dJf0Oxwxj3fI3B+RaW/RNV9dMI1L2/WhGRhXAReM3z1Vi4DDCZEuPbKoILx+xTMTAEKHjyml+mTDdU7ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogpL4xbGYCTjGh/KS4oup9GUoWSpzf/TV+H/We69RyI=;
 b=nWl1/4BBjRNP5o/6UyGLQJH+bt3f0uq9GKmmzoJpMDq1WsMhkjxINBV8GFs5mbaksERZd9dGoQ9jR2Wg+Vk0KRxQcZcny016VBDBCke5xGz2wYUqj+WvqaysL7H4sqvK3j73d1mJjluT7a6E9w0wezxUXOp2FbnkKwHRpNQs9Ea+FIIjlbMV53aXyj+DLu+JrfXdB8VNlXDm7fGxPJLSJ8N9+UgLeDoTnoIXCfTEaCi1yoqYz+Z2OKOvnv+mrIeNrpvpp+JHzDzCzgOIqRPrNKNAAb0R0HDO0uU3+EACq9Lb7b7UZ6Mb7/UNWxsThCOkw0zLAZNUHi08SO0XfL5RuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogpL4xbGYCTjGh/KS4oup9GUoWSpzf/TV+H/We69RyI=;
 b=PxNVzdmYsuNW7S9OqrO0rTKH4mjwVubyuwQBfndWNgBLge3rbIrYxMu+saKc+bERLcXVVd7FDtM464sBEU8TwhebWAB6LrWu0R8TOYrRlMmj/LQSmhnDcujY1NCG1ZsNPt7yfjOVeFNiM0gnFuj+VNUhMoyH7nlcvxkRDiqxwgw=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 BN6PR12MB1698.namprd12.prod.outlook.com (2603:10b6:404:106::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Wed, 1 Jun 2022 01:59:51 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::95af:3466:5c5f:1202]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::95af:3466:5c5f:1202%2]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 01:59:51 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: convert
 sienna_cichlid_populate_umd_state_clk() to use IP version
Thread-Topic: [PATCH] drm/amdgpu: convert
 sienna_cichlid_populate_umd_state_clk() to use IP version
Thread-Index: AQHYb9yDIDlFyur6Dkqvx2drhEVQU605hsCAgABP4lA=
Date: Wed, 1 Jun 2022 01:59:50 +0000
Message-ID: <DM5PR12MB2469BEC143A465529B751D1AF1DF9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220525020926.1951685-1-alexander.deucher@amd.com>
 <CADnq5_M-UonUf0Kxy=_64q4DREsGqOes4XAk2M5_bzF4CZi+Jw@mail.gmail.com>
In-Reply-To: <CADnq5_M-UonUf0Kxy=_64q4DREsGqOes4XAk2M5_bzF4CZi+Jw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54ce3fa7-170c-408e-3442-08da43726a04
x-ms-traffictypediagnostic: BN6PR12MB1698:EE_
x-microsoft-antispam-prvs: <BN6PR12MB16981DCC9940186AE035F500F1DF9@BN6PR12MB1698.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ICsoDXvxwSIAG50hZkIucpUD/hTMMpKziHYV7zDLRUvdGbHTQHzM+f+30c9OVSg0CdZ6kXN6Mc2XGUdChLGX0zJK5bJ52v9fIB9KCa/oow/ub/CXc8lbodXHfl1sAxu2idzBtnHLAYudvhYlgFLX7wEckj9gfeMNOrRLI6kHJQYN3ST4TyLTUGt9nZlpegnsLdQPwLISeO/sBVjz2sgusDnF9y/xaoZRWGg0AaUijYdQCQxDja8DyoA7vTikO9Wa/rSRkeu6dogwOx8vRHhyFVraeuYJPTkzz1lRVkYhexdVoedCswY3nfsOUWUARf+k7XQF3/fQpOBoaim+E7uZRfYB/HpB5R3e1hKSjKoFJ4P48hKKDW2cuNSeBQLboEqnEnyeG++6g8eFv2TMPUrwmVZDrfXPMV1yXtOITSxgPzvZ5RHs+9kS1jvEvS/pPLFP2Lv5MOPSuGwmBOmzvLaVd35EZxm3qy+taaKmBqSEw7VWlTFhCCSqChEOJ5DNGXAk/KAQq757f0s4CwSkb3Z+EC1EmuaVu3VN5rpW1LXEro5N1+vd/Q3woh2dO770CPCVAsazZX6L0Y1yH6lJEFnUcCmD2b+UeeWYmF+WzechwPe+YK2yNFNT/rzrTa2InlmRDdMcimkcEadDmSPvs9CMIVRc+j9QQBhDF5fFWYsfESYS/VQe22y20YRueQmG8kqq3SoO2TZXpvTcOu1a9DyTig==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(71200400001)(33656002)(508600001)(53546011)(26005)(76116006)(7696005)(66946007)(9686003)(2906002)(6506007)(186003)(8936002)(86362001)(52536014)(5660300002)(83380400001)(110136005)(316002)(122000001)(38070700005)(6636002)(55016003)(8676002)(66446008)(4326008)(66556008)(66476007)(64756008)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZldyZlF1Qmh0Q05BYzVXRnRkV2hUV0x5NENUQWZJSFAxVERvZFFUTS9zMWVr?=
 =?utf-8?B?U3BlcVd6R2NTZ254T2R5SjRtdmdiMmJPOUliWERzYWdOalNnTGJCakRQb3ZE?=
 =?utf-8?B?a0ZrNElXMkExSFh0dHl5d2NEbW5OWkRsUTJrOEErZlVxL0psWFROcEhiWTB0?=
 =?utf-8?B?dXM3ZkM5RDRYVlRRaFNmaE1wbDh1aGhvOFZLb3dtMmt0MHg3U3BKMDcySG41?=
 =?utf-8?B?NzZCZXNmWG9XSUJjZXphOGRDMVlZTFEvTXpYNDNHV01MQUdKZUhZdFFyTEVk?=
 =?utf-8?B?ZUN4YmpTNVRqNjFidlFKTDMyQVUvRXJQQjJuVlkzL1JVdkpaeHM1M2Y5WFQ1?=
 =?utf-8?B?S0tpRkwxU1JRSGZhY1piZnM2S1phSlMyUktFNWE0ZDVTaTNRZ0V2SlR6anVM?=
 =?utf-8?B?bkxBcHY0R0QySkZ2R2VST2hoU2VpdHl2QkZnRk9QUXFjK1FGN2dvVDI4VFZv?=
 =?utf-8?B?YWhRNEJnZks4WkgrWGJJLzUzaFR4b01VNnBHRUJwM2Q0WHpzOGptNmQvZTdF?=
 =?utf-8?B?K29FckJZUFJWTlNnOUNkQVlqTERobWN6cGFXZ2hYaGV0TGgvUkxTYk5LaVNP?=
 =?utf-8?B?Qm9hMUJYL2NwbXVhbWRNbDdZZVdsbUg0NUFwYkc0eVVNRWhJQVU5RDNGbmdD?=
 =?utf-8?B?cWp3WTZzV1RxdjZQUEdGYzdjZjVnd2Y1M2xSYWdTN3ZFeHFFRTdwUnROMnZr?=
 =?utf-8?B?L1ZVcThCQTNmZlpVQmRWNGpJMk91aklvUzZ4ZnE1MzFzYnVPWU9qYlFUK05v?=
 =?utf-8?B?VHVDVFhUL1dnb1lEdTMxUm9FZ0tyeXVpUWJmVnE2VFI4YlFWTHZMalRQTnpp?=
 =?utf-8?B?NjBDWE81YnprdUZ2MjV3Mk9KRm1UN0ovYjd3N1VsWDFGVVZXVGNsMXAyMnlV?=
 =?utf-8?B?ZnptbFhJQWV3NTdpUmI0KzUvSm81QXhqVmhGYW5QQ2htaXRVR3VkaU15K1h2?=
 =?utf-8?B?ZHpHTzNpV0JDQ1A0ZWtaRE9DUWtCekpndVRGY01ENVdkWlUxVXd4bDQ5WnF0?=
 =?utf-8?B?NEJ5Y21oQ1o3UkxnRmU2MWpYc1VTUHdmSStReTArQytVUFFNYncyNXZVNExN?=
 =?utf-8?B?WnR4bVN0TWprQ3EzeG9Fb2YwZnNUWkoyd2lWanp2ek5LV2JsZ2hkZGpPVEZp?=
 =?utf-8?B?YWhwaUFqdTRuSDJxbzA5WXFWWmc4d0VpaXpaWVhGWVlHb2xxSmhONFBIVDkr?=
 =?utf-8?B?alkvTlBNY3o3KzJsTEJvRjNuT3FEOG9HY292YUwwaDE4dmpKUjk3eVcyclhs?=
 =?utf-8?B?RVcwRXFWL3IvMjJXVng4WkhadWZGQVhRNHdmYTdrRW9uZ0kwQmUwM0pnd2NU?=
 =?utf-8?B?MHkvTUdTVjVTWGhYRzNObGNhZ1UzYzY1WUIvVlZReE9yK3ljc3psVnlRQmtQ?=
 =?utf-8?B?N3JSR1NxQkhLZ1pVcXpMWVVnbWVYSEdlRnVTUDgwUEU1VzZYaFVWcWRYcFN6?=
 =?utf-8?B?dmluOGJGcVlIbTJCK0prUGcvQnI4SjlVLy92SFV3Z1pNRVBoVXVTN3lGVzFa?=
 =?utf-8?B?ZUtVbkx0bnEzTGFYRjVhU0gwZ0tmSVY4eXpJR2ZxaE9BVFFpeEVPS24wTC9F?=
 =?utf-8?B?dEN3OUN2U0RaTjJtMk1rdEtaL1pMVHRMNVVnQWM4NFBIVWtsTzB5OXpWazBH?=
 =?utf-8?B?RWtibmRrZTJqTUVCTGhnMHA4TXJsVHk3NUFDbXRSWlMvYnZJTHdGc2w0amgx?=
 =?utf-8?B?RXpnYWd3a3BPSEN3am1la1FOT2doQlU5R0lCUFFqWnN0aXM4L250ekxsbUJ4?=
 =?utf-8?B?UVN5TXNGQllPU0MrV3o5dHRxSUd2aHJkd1JMZ09CTFhkWUdRdUxpdUxmdGty?=
 =?utf-8?B?MG9TU2c2OExYbFZZTFNJVm4rN3JaQ0FoeElzZExpTlI3Q2VFZTROejJNdlhC?=
 =?utf-8?B?L3RRR1NNUUZNNFprT25JZW9qaXF2L2hBNlYxbEZxcVcvcGEzRUVJTUMvTUJv?=
 =?utf-8?B?QWdTR3BwcDkxOXE3bklZOGpFaVZKaGk3WGFnWHJ3eHdtLzlocGNoRkJQSExt?=
 =?utf-8?B?a0IvQXBEWVRJNWh4b2thVUdOOFFjSlZqSitLVTNQZS9QZk1oZG43WEJ5QW1q?=
 =?utf-8?B?VStSM3lTQVo0Y1BnY3htdUd5ckNQeHE2eDh5Y3dGWXh0UWFhNDM0VVp6NzVy?=
 =?utf-8?B?eFJ6UVQzcEpqZGRIczg5ZjdHMzdLV290Z0Evb25uZHhVdWFQak1iUWZSZ2ll?=
 =?utf-8?B?dXdBbDhTLy9VdEFRQmpvY0tZNm9GSU5zNzVNN2xSWlZWckh0L08xOHYzbkd6?=
 =?utf-8?B?aDJlRktnNlhwYkJtTWF3YmtUckNORHJsSVpaU1U4a3NtN1daWWlxdyttVlg5?=
 =?utf-8?B?cmdjU1JLUHp4anZvWjRZWE5WdHBHNTFMa2dtMlFyT293Z2pGNGRvZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ce3fa7-170c-408e-3442-08da43726a04
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 01:59:50.9870 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 37abiw0aa6QLigZQ9KU0Vg5/Ou3BYpTXurLpWgOxMFYm7mTWf941kj+1iclaIk+L2awp9AhRWd95ElYjV8fpfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1698
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

UmV2aWV3ZWQtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0KDQpSZWdhcmRz
LA0KR3VjaHVuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxh
bWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQWxleCBE
ZXVjaGVyDQpTZW50OiBXZWRuZXNkYXksIEp1bmUgMSwgMjAyMiA1OjEzIEFNDQpUbzogRGV1Y2hl
ciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KQ2M6IGFtZC1nZnggbGlz
dCA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBk
cm0vYW1kZ3B1OiBjb252ZXJ0IHNpZW5uYV9jaWNobGlkX3BvcHVsYXRlX3VtZF9zdGF0ZV9jbGso
KSB0byB1c2UgSVAgdmVyc2lvbg0KDQpQaW5nPw0KDQpPbiBUdWUsIE1heSAyNCwgMjAyMiBhdCAx
MDowOSBQTSBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+IHdyb3RlOg0K
Pg0KPiBSYXRoZXIgdGhhbiBhc2ljIHR5cGUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1
Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gLS0tDQo+ICAuLi4vZ3B1L2RybS9h
bWQvcG0vc3dzbXUvc211MTEvc2llbm5hX2NpY2hsaWRfcHB0LmMgICAgfCAxMCArKysrKy0tLS0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPg0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9zaWVubmFf
Y2ljaGxpZF9wcHQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvc2llbm5h
X2NpY2hsaWRfcHB0LmMNCj4gaW5kZXggNzhmM2Q5ZTcyMmJiLi44NzE0MzVjY2EzYzEgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvc2llbm5hX2NpY2hs
aWRfcHB0LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9zaWVu
bmFfY2ljaGxpZF9wcHQuYw0KPiBAQCAtMTQ2NCwxOSArMTQ2NCwxOSBAQCBzdGF0aWMgaW50IHNp
ZW5uYV9jaWNobGlkX3BvcHVsYXRlX3VtZF9zdGF0ZV9jbGsoc3RydWN0IHNtdV9jb250ZXh0ICpz
bXUpDQo+ICAgICAgICAgcHN0YXRlX3RhYmxlLT5zb2NjbGtfcHN0YXRlLm1pbiA9IHNvY190YWJs
ZS0+bWluOw0KPiAgICAgICAgIHBzdGF0ZV90YWJsZS0+c29jY2xrX3BzdGF0ZS5wZWFrID0gc29j
X3RhYmxlLT5tYXg7DQo+DQo+IC0gICAgICAgc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUpIHsNCj4g
LSAgICAgICBjYXNlIENISVBfU0lFTk5BX0NJQ0hMSUQ6DQo+IC0gICAgICAgY2FzZSBDSElQX05B
VllfRkxPVU5ERVI6DQo+ICsgICAgICAgc3dpdGNoIChhZGV2LT5pcF92ZXJzaW9uc1tNUDFfSFdJ
UF1bMF0pIHsNCj4gKyAgICAgICBjYXNlIElQX1ZFUlNJT04oMTEsIDAsIDcpOg0KPiArICAgICAg
IGNhc2UgSVBfVkVSU0lPTigxMSwgMCwgMTEpOg0KPiAgICAgICAgICAgICAgICAgcHN0YXRlX3Rh
YmxlLT5nZnhjbGtfcHN0YXRlLnN0YW5kYXJkID0gU0lFTk5BX0NJQ0hMSURfVU1EX1BTVEFURV9Q
Uk9GSUxJTkdfR0ZYQ0xLOw0KPiAgICAgICAgICAgICAgICAgcHN0YXRlX3RhYmxlLT51Y2xrX3Bz
dGF0ZS5zdGFuZGFyZCA9IFNJRU5OQV9DSUNITElEX1VNRF9QU1RBVEVfUFJPRklMSU5HX01FTUNM
SzsNCj4gICAgICAgICAgICAgICAgIHBzdGF0ZV90YWJsZS0+c29jY2xrX3BzdGF0ZS5zdGFuZGFy
ZCA9IFNJRU5OQV9DSUNITElEX1VNRF9QU1RBVEVfUFJPRklMSU5HX1NPQ0NMSzsNCj4gICAgICAg
ICAgICAgICAgIGJyZWFrOw0KPiAtICAgICAgIGNhc2UgQ0hJUF9ESU1HUkVZX0NBVkVGSVNIOg0K
PiArICAgICAgIGNhc2UgSVBfVkVSU0lPTigxMSwgMCwgMTIpOg0KPiAgICAgICAgICAgICAgICAg
cHN0YXRlX3RhYmxlLT5nZnhjbGtfcHN0YXRlLnN0YW5kYXJkID0gRElNR1JFWV9DQVZFRklTSF9V
TURfUFNUQVRFX1BST0ZJTElOR19HRlhDTEs7DQo+ICAgICAgICAgICAgICAgICBwc3RhdGVfdGFi
bGUtPnVjbGtfcHN0YXRlLnN0YW5kYXJkID0gRElNR1JFWV9DQVZFRklTSF9VTURfUFNUQVRFX1BS
T0ZJTElOR19NRU1DTEs7DQo+ICAgICAgICAgICAgICAgICBwc3RhdGVfdGFibGUtPnNvY2Nsa19w
c3RhdGUuc3RhbmRhcmQgPSBESU1HUkVZX0NBVkVGSVNIX1VNRF9QU1RBVEVfUFJPRklMSU5HX1NP
Q0NMSzsNCj4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiAtICAgICAgIGNhc2UgQ0hJUF9CRUlH
RV9HT0JZOg0KPiArICAgICAgIGNhc2UgSVBfVkVSU0lPTigxMSwgMCwgMTMpOg0KPiAgICAgICAg
ICAgICAgICAgcHN0YXRlX3RhYmxlLT5nZnhjbGtfcHN0YXRlLnN0YW5kYXJkID0gQkVJR0VfR09C
WV9VTURfUFNUQVRFX1BST0ZJTElOR19HRlhDTEs7DQo+ICAgICAgICAgICAgICAgICBwc3RhdGVf
dGFibGUtPnVjbGtfcHN0YXRlLnN0YW5kYXJkID0gQkVJR0VfR09CWV9VTURfUFNUQVRFX1BST0ZJ
TElOR19NRU1DTEs7DQo+ICAgICAgICAgICAgICAgICBwc3RhdGVfdGFibGUtPnNvY2Nsa19wc3Rh
dGUuc3RhbmRhcmQgPSBCRUlHRV9HT0JZX1VNRF9QU1RBVEVfUFJPRklMSU5HX1NPQ0NMSzsNCj4g
LS0NCj4gMi4zNS4zDQo+DQo=
