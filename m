Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA260CDB474
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 04:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA4E710E579;
	Fri, 20 Oct 2023 04:20:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A018F10E580
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 04:20:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVY7vqEM/WTAChQTWjzANYCMyaFk0mJqI/POJH/CWcv7ya5urmwtLcyR4s7Wos6BgTjlQeZd+gd7iKgAFV7G9Y+AkdIr93BPd447CHbGypH7W5RI4rJ0zwMhutRZhScgl5Lwh4w5hdmSmHmDs/wSwueCAKXsM4dqOtAo6sengaKd6W4dTPn3HsCG60VdmJh5CEE9KKKdWQ3GO9fPWl+3jkghtXIYSCgGdvzvcQRioC9Tq4PrW3e2ODT3SD5CTai5ViYz8CdlsJ4waelON8PEE6FxLEYuzd2WJDI1wLcBPprMLjrRUjuBJhxJpShRDdXcWf1yxL0NzHTAFENhnYwTag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rd6Cxc5zjggYIYXn+bEFGgEcCLK5GR9HuJBWAg93ni8=;
 b=OPSLrnvU0Kt87YZVgrM7MwBlm0quVIOeyXkIcs992Mv6lEnaqr4UaasymeyDh1DzOgIDxitgGcBCc9q14JSdNZvFYe6inWCWHv9FR9YECATDSWZQCvcnzuBXWmeTDtK8M/ypIa/yBtt7y7AJ9U/VNeAa1Eu8abxxQ2sGfRHli6tWgWtliver290IVriYT99wNHhiYIWWSsEbtlSDJZKyqGybSmR771RGlCCANH9BcoroZgKXY9UfRH4W6fLrkdYC8uimvwaGXdAT8CIOyId3UAh8l7L5r+rP3jg3dPZK2w6s1XErrhHChbDjEqSwrAtObr9xhfg58kDSWzFUftSanA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rd6Cxc5zjggYIYXn+bEFGgEcCLK5GR9HuJBWAg93ni8=;
 b=1F5aQsUgiYn1yf7cZPOkO1zMq3bF2FPj8cDPQWrfUcwQ6iLSuI+foZM4hL9dVGjrcjrkY1jpGhUNaTio+m91zkoKpZmP/ZiZvHbb95/iH+nzMOioqUgySsLa72etw/0SieQONUKo8dx3uoVd8lxFj2E/QiDfViU2p9xyDl514S0=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 04:20:36 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::c08b:f17e:eb8b:d410]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::c08b:f17e:eb8b:d410%5]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 04:20:35 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add timeout for sync wait
Thread-Topic: [PATCH] drm/amdgpu: Add timeout for sync wait
Thread-Index: AQHaAm7+nHDwKAlieUmKhTbGRRO27rBRR0cAgAC6iUA=
Date: Fri, 20 Oct 2023 04:20:35 +0000
Message-ID: <PH0PR12MB541706EEBD2E608C36E897FD8FDBA@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20231019093103.100939-1-Emily.Deng@amd.com>
 <260b5793-68bf-4a65-b4db-594184572c1a@amd.com>
In-Reply-To: <260b5793-68bf-4a65-b4db-594184572c1a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=df906734-a50f-4d69-acfd-ee3101286857;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-20T03:13:04Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|SA0PR12MB4461:EE_
x-ms-office365-filtering-correlation-id: 5ccd35de-38f4-4aa2-c28d-08dbd123e844
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PqjapcFGIa18xBJxLLpeu1Wa6c7tH4aKqiaymu5fs+eJij3f6/VaXkMk/QmMHWCyzun9cXJhiJkUntM1JJbOxOCrGyIsHTv0E1OHQjHH6ikXkseT5W36HcUTNG9kESz+Z2HvK+CAqGdsSdeA3GC17hXsMVtw8Wkea7BtibWT4lcvQHiikePPi/SOY5v+owKuqhuECdI9K6KDPHYsqLD8q0gMR3dJkVTwuvTtR8L1X+mRrv2gHEUAU7fQRlnbyYY8DKx5daboQzO5gmlo+nrB+ykpalbmJfAzcEHmFhP1ikJLyfgSty+Be0+g0fBPCvnTVTfC9Xt6kBXQS/DfGzw4uk1uShaiGyuVxBvvHE6ZPodBa8pR9skp/GWLVspG0ddvQTQb9/gWg9GWiAqCP/dAHnOyN949gQgUofO5gYmlRQRhc0QZeBM2zU9vGw1rfFd3E3AEWIpVpZJYY5BA+zn0x0cQsdZmcpads/gJFX4IlH1UQyIRzJAadiDvMGDBRKC2a03cbvgrbTr+OjF61ZtEtMY0VXvR+gFzgoF5qhgxnwCvIEMOn0D9X5i6aX7x+dKyW/tY4HI+YMx2lPeuH5M5PM6Bfb/Ri7Om6GVvz2SspJBNrYyEMVob1BwCjDhr+k6Q
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(55016003)(26005)(6506007)(7696005)(71200400001)(9686003)(83380400001)(41300700001)(8676002)(8936002)(52536014)(5660300002)(2906002)(4001150100001)(478600001)(76116006)(64756008)(66446008)(110136005)(66476007)(66556008)(66946007)(316002)(122000001)(86362001)(38100700002)(33656002)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WU9raDhCeEFwc1F2OENIYllZSVRoM1hGZ1orN3NJaVhtaW9vQUcxQTVzZFZY?=
 =?utf-8?B?NkprSGJOcURUZmFSWk9QbDdSanNqZDhsMGYyekNrckNDUUdiUXRUVVpCelFY?=
 =?utf-8?B?ZVV4QXRaZHFaU1VubjQxcWNHRTY2OVJueUMrU1FaSVdOcXdyTnEyVGUvdGxW?=
 =?utf-8?B?SHMwSkNmbjJVc1UxeUpwY2pkME5EMDk5WjZ0SWpnYklmWk92N2xyS3U2aldv?=
 =?utf-8?B?Y3FWYnloTis5VDhxM05YOTVNQUhxdTEvZmU3aTgyMk9KK2NWSFcwWDE5aFNs?=
 =?utf-8?B?NzNBYjg4TUdDaFVQTFJBWkxKSFR3T3lGVVJ2OURQL1JrbFlNMGR5MHIxNHVp?=
 =?utf-8?B?eUhsMElBSVZWY3ZKTEltZ1lQbE5zMFhFNjFCaERDZ2R4UDhqOWN1VWJoc09I?=
 =?utf-8?B?VXM1dmYvam1DZ3diNE5pcXFSQThQbG9ORDJycExBUXRRRmZKL1BOaWczUmZB?=
 =?utf-8?B?OS80c2U4Q2NvWFhaVHZMcFE3SmEvVklaMTZHa2drOVBJRjRFVkhWUGVkSWJP?=
 =?utf-8?B?SHdCWXBpZTF0dngydmhMd0k4WHcyN3BkNjNzTXBhVlVMRXZBTEdBK2ZJS2FW?=
 =?utf-8?B?VTM4RDlkWHkvRHVMR3NQaUtUbjMrc0Izc2tsSitTZHNXbGpzQnVESWRGa3JV?=
 =?utf-8?B?T1gyN0RyMkNqT09kMG0yalNXc2Z0T2sybUJ6WWQwSkd2YnNsU1lIb2hySjFm?=
 =?utf-8?B?S28yQXoydXdSeEUwQUlGUm5VS2ovbmRZMjhLTUtrcXY5cW5RZVoyVE1kVXE2?=
 =?utf-8?B?VGdZMVhOaDloemQvZXpuS1RRR0ZnVXo1S1V5ZmdOVTFwcEEzcmcwTVpGQUVJ?=
 =?utf-8?B?RVlDZkNRVGI1OHUvTnA3bDk2cmlPeDA0TXlhaEFoYStTenZGNlMxSUxjOUpS?=
 =?utf-8?B?eWxvL2laUiszazV6aGRZQVFHVVRoR3lGVnZmK2pTRVZBMmlBOGRZUDRMTk5p?=
 =?utf-8?B?NDgxUnFkY2VQOUVXTFYxeDZJZ0F2aUl5UmlxUHZpWnRyYVpaU2h4aWo1MWlU?=
 =?utf-8?B?enV2cnM5ZjJPSEZsMXVMRXMrRS9wOS9UTi9ITGw4eTRsbDFXeWoxQzE4cnVa?=
 =?utf-8?B?b29oTjcySmFFM1NjbVZid0FmMFJSVFcxNzJmQlFjdHdDdUdrc1JBVkcrbmV0?=
 =?utf-8?B?eThJRmR3bnpQeWdEaXpzYUErVVFST1VlemNGNlA2eFYxNmVXNEVodnVBUml6?=
 =?utf-8?B?VzJiTmNkUmhQSGRDcUFEelhsajJJeDM0dXBsNy9PbWZjc1NpZjgyVi9hM2dz?=
 =?utf-8?B?UEF4VTBjcnFCMkdOTmE4c0FHemdHQ2RrcUxGYzRJKzFYdy9YWWxlbE0rT05Q?=
 =?utf-8?B?UmdQbVRBalpmL1Nyc0sybG8xRUF0VGdRNW5wK3k3YjJuTGdqZ2dxRUtMSU05?=
 =?utf-8?B?QmpiVnl3dWs5cVNzSllYUDhDelZldGE1UEQrUE1lbDJJdEdicytiS0Vtb1hO?=
 =?utf-8?B?b0FwUytvbkdSQnlYWjJ2WWN6cENDaUpGWDQwbE9rQnp6Lzg2cmxEZWtFaExs?=
 =?utf-8?B?MFprdEtGUnQyTG5WcUhHREM4UklzSVpFWldVKzY5emM5NzErSmgzcmFsVzJh?=
 =?utf-8?B?YmtERjJZK1ZzcHp0K3VTaXphb3MwUU1JNjYyd0tBS1RUWUNjR0lHOXlwbnAz?=
 =?utf-8?B?V09tb3N4NzhybEZ2cm5vYkhvUDhyYXJaa3p3YXJSelIrc2pxZGJyMmNwM2NR?=
 =?utf-8?B?WEYybmF4RGJvOFBGWlBabWdHOWNsd25NaWFKbDdmam45ZU1iWHFyNFBmVXJl?=
 =?utf-8?B?VUUrVDhSZUZsKzA3R1gxbCtUMzZCblBDYjNqL29sUmllK2theHZSUXdYbW5i?=
 =?utf-8?B?b2VRaWtFWG5xNld5aHlrMVdQUEFUZHd1T0xYZ1ZlcitMdTVBeWQzdHNiNnBX?=
 =?utf-8?B?c0NDSEh4clVuZUgxL1pNcHNuTHRYeTdsWXN5WEZGbmpKSDhPc1hTelB0eGZT?=
 =?utf-8?B?K0Uyc0JkRUZ1NmlmdlFSVWZrSThTdFB3NmJpR05NRSt1Sk1oeDh5ZDJGTnNy?=
 =?utf-8?B?RGZJV1ZBRGlaZmdnM3l3WjNIS2RzTjBaRlg2WExCQUZYT1hnaW1EcTVOK0lF?=
 =?utf-8?B?ZFF5YnpRSTIzRW9iNFpzdkw0S0cxV0l6U0FjR1Q0TTBMMi81T1lsWjc4SmRn?=
 =?utf-8?Q?n64A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccd35de-38f4-4aa2-c28d-08dbd123e844
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 04:20:35.3897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gbYozjfM816d4bnO/lSEIgHawuPXc77pQVf/1csxAUmKQabGF/Lie65p5IpdTFK/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEZlbGl4LA0KICAgICBZZXMs
IHdpbGwgY29ycmVjdCB0aGUgZGVzY3JpcHRpb24uIFdpbGwgYWRkIGFub3RoZXIgcGF0Y2ggdG8g
aGFuZGxlIHRoZSByZXR1cm4gZm9yIHN5bmMgd2FpdC4NCg0KRW1pbHkgRGVuZw0KQmVzdCBXaXNo
ZXMNCg0KDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEt1ZWhsaW5nLCBG
ZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj5TZW50OiBGcmlkYXksIE9jdG9iZXIgMjAs
IDIwMjMgMTI6MDUgQU0NCj5UbzogRGVuZywgRW1pbHkgPEVtaWx5LkRlbmdAYW1kLmNvbT47IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+U3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2Ft
ZGdwdTogQWRkIHRpbWVvdXQgZm9yIHN5bmMgd2FpdA0KPg0KPk9uIDIwMjMtMTAtMTkgMDU6MzEs
IEVtaWx5IERlbmcgd3JvdGU6DQo+PiBJc3N1ZTogRGVhZCBoZWFwcGVuIGR1cmluZyBncHUgcmVj
b3Zlcg0KPj4NCj4+IFs1NjQzMy44Mjk0OTJdIGFtZGdwdSAwMDAwOjA0OjAwLjA6IGFtZGdwdTog
R1BVIHJlc2V0IGJlZ2luIQ0KPj4gWzU2NTUwLjQ5OTYyNV0gSU5GTzogdGFzayBrd29ya2VyL3U4
MDowOjEwIGJsb2NrZWQgZm9yIG1vcmUgdGhhbiAxMjANCj5zZWNvbmRzLg0KPj4gWzU2NTUwLjUy
MDIxNV0gICAgICAgVGFpbnRlZDogRyAgICAgICAgICAgT0UgICAgICA2LjIuMC0zNC1nZW5lcmlj
ICMzNH4yMi4wNC4xLQ0KPlVidW50dQ0KPj4gWzU2NTUwLjU0Mjg4M10gImVjaG8gMCA+IC9wcm9j
L3N5cy9rZXJuZWwvaHVuZ190YXNrX3RpbWVvdXRfc2VjcyINCj5kaXNhYmxlcyB0aGlzIG1lc3Nh
Z2UuDQo+PiBbNTY1NTAuNTY2MzEzXSB0YXNrOmt3b3JrZXIvdTgwOjAgICBzdGF0ZTpEIHN0YWNr
OjAgICAgIHBpZDoxMCAgICBwcGlkOjINCj5mbGFnczoweDAwMDA0MDAwDQo+PiBbNTY1NTAuNTkx
MzE4XSBXb3JrcXVldWU6IGtmZF9yZXN0b3JlX3dxIHJlc3RvcmVfcHJvY2Vzc193b3JrZXINCj4+
IFthbWRncHVdIFs1NjU1MC42MTEzOTFdIENhbGwgVHJhY2U6DQo+PiBbNTY1NTAuNjE4Njk4XSAg
PFRBU0s+DQo+PiBbNTY1NTAuNjI0OTY4XSAgX19zY2hlZHVsZSsweDJiNy8weDVmMCBbNTY1NTAu
NjM1NDE2XQ0KPj4gc2NoZWR1bGUrMHg2OC8weDExMCBbNTY1NTAuNjQ1MDkwXSAgc2NoZWR1bGVf
dGltZW91dCsweDE1MS8weDE2MA0KPj4gWzU2NTUwLjY1NzA5Nl0gID8gYW1kZ3B1X3ZtX2JvX3Vw
ZGF0ZSsweDQ2ZS8weDY2MCBbYW1kZ3B1XQ0KPj4gWzU2NTUwLjY3MzI0NV0gIGRtYV9mZW5jZV9k
ZWZhdWx0X3dhaXQrMHgxYTIvMHgxZTANCj4+IFs1NjU1MC42ODY4MThdICA/IF9fcGZ4X2RtYV9m
ZW5jZV9kZWZhdWx0X3dhaXRfY2IrMHgxMC8weDEwDQo+PiBbNTY1NTAuNzAyNzI4XSAgZG1hX2Zl
bmNlX3dhaXRfdGltZW91dCsweDExNy8weDE0MA0KPj4gWzU2NTUwLjcxNjMwMV0gIGFtZGdwdV9z
eW5jX3dhaXQrMHg2Mi8weGEwIFthbWRncHVdIFs1NjU1MC43MzA2NTRdDQo+PiBhbWRncHVfYW1k
a2ZkX2dwdXZtX3Jlc3RvcmVfcHJvY2Vzc19ib3MrMHg1OWUvMHg3NzAgW2FtZGdwdV0NCj4+IFs1
NjU1MC43NTE2NjhdICA/IG5ld2lkbGVfYmFsYW5jZSsweDI5OC8weDQ5MCBbNTY1NTAuNzYzOTM2
XQ0KPj4gcmVzdG9yZV9wcm9jZXNzX3dvcmtlcisweDQyLzB4MjcwIFthbWRncHVdIFs1NjU1MC43
ODAxODNdDQo+PiBwcm9jZXNzX29uZV93b3JrKzB4MjFmLzB4NDQwIFs1NjU1MC43OTIxOTNdICB3
b3JrZXJfdGhyZWFkKzB4NTAvMHgzZjANCj4+IFs1NjU1MC44MDMxNjVdICA/IF9fcGZ4X3dvcmtl
cl90aHJlYWQrMHgxMC8weDEwIFs1NjU1MC44MTU5MzRdDQo+PiBrdGhyZWFkKzB4ZWUvMHgxMjAg
WzU2NTUwLjgyNTM0Ml0gID8gX19wZnhfa3RocmVhZCsweDEwLzB4MTANCj4+IFs1NjU1MC44MzY1
NDhdICByZXRfZnJvbV9mb3JrKzB4MmMvMHg1MCBbNTY1NTAuODQ3MjYyXSAgPC9UQVNLPiBbDQo+
PiAxOTM1LjIxNTUwMl0gQ2FsbCBUcmFjZToNCj4+IFsgMTkzNS4yMjI4MjddICA8VEFTSz4NCj4+
IFsgMTkzNS4yMjkxMjFdICBfX3NjaGVkdWxlKzB4MjNkLzB4NWEwIFsgMTkzNS4yMzk1ODNdDQo+
PiBzY2hlZHVsZSsweDRlLzB4YzAgWyAxOTM1LjI0ODk4M10gIHNjaGVkdWxlX3RpbWVvdXQrMHgx
MDMvMHgxNDAgWw0KPj4gMTkzNS4yNjEwMDJdICBfX3dhaXRfZm9yX2NvbW1vbisweGFlLzB4MTUw
IFsgMTkzNS4yNzMwMDhdICA/DQo+PiB1c2xlZXBfcmFuZ2Vfc3RhdGUrMHg5MC8weDkwIFsgMTkz
NS4yODU1NDZdDQo+PiB3YWl0X2Zvcl9jb21wbGV0aW9uKzB4MjQvMHgzMCBbIDE5MzUuMjk3ODEz
XQ0KPj4gX19mbHVzaF93b3JrLmlzcmEuMCsweDE3NS8weDI4MCBbIDE5MzUuMzEwNjExXSAgPw0K
Pj4gd29ya2VyX2RldGFjaF9mcm9tX3Bvb2wrMHhjMC8weGMwIFsgMTkzNS4zMjQ0MzZdDQo+PiBm
bHVzaF9kZWxheWVkX3dvcmsrMHgzMS8weDUwIFsgMTkzNS4zMzY0NTVdDQo+PiBrZmRfc3VzcGVu
ZF9hbGxfcHJvY2Vzc2VzKzB4OTYvMHgxNTAgW2FtZGdwdV0gWyAxOTM1LjM1MzQyOV0NCj4+IGtn
ZDJrZmRfc3VzcGVuZCsweGI4LzB4ZTAgW2FtZGdwdV0gWyAxOTM1LjM2NzQ2OV0NCj4+IGtnZDJr
ZmRfcHJlX3Jlc2V0KzB4ODEvMHhmMCBbYW1kZ3B1XSBbIDE5MzUuMzgyMDM2XQ0KPj4gYW1kZ3B1
X2FtZGtmZF9wcmVfcmVzZXQrMHgxYS8weDMwIFthbWRncHVdIFsgMTkzNS4zOTgxNTZdDQo+PiBh
bWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyLmNvbGQrMHgyMTAvMHhjZjIgW2FtZGdwdV0gWyAxOTM1
LjQxNjcyMl0NCj4+IGFtZGdwdV9qb2JfdGltZWRvdXQrMHgxOWYvMHgxZTAgW2FtZGdwdV0gWyAx
OTM1LjQzMjM2N10NCj4+IGRybV9zY2hlZF9qb2JfdGltZWRvdXQrMHg2Zi8weDEyMCBbYW1kX3Nj
aGVkXSBbIDE5MzUuNDQ4NzkyXQ0KPj4gcHJvY2Vzc19vbmVfd29yaysweDIyYi8weDNkMCBbIDE5
MzUuNDYwODA2XQ0KPndvcmtlcl90aHJlYWQrMHg1My8weDQyMA0KPj4gWyAxOTM1LjQ3MTc3N10g
ID8gcHJvY2Vzc19vbmVfd29yaysweDNkMC8weDNkMCBbIDE5MzUuNDg0MzA3XQ0KPj4ga3RocmVh
ZCsweDEyYS8weDE1MCBbIDE5MzUuNDkzOTkzXSAgPyBzZXRfa3RocmVhZF9zdHJ1Y3QrMHg1MC8w
eDUwIFsNCj4+IDE5MzUuNTA2NTEzXSAgcmV0X2Zyb21fZm9yaysweDIyLzB4MzANCj4NCj5Mb29r
aW5nIGF0IHRoZSB0aW1lIHN0YW1wcywgdGhpcyBzZWVtcyB0byBiZSBhIG1hc2gtdXAgb2YgdHdv
IGRpZmZlcmVudCBsb2dzLiBJDQo+dGhpbmsgeW91J3JlIHRyeWluZyB0byBzaG93IGhvdyBhIHJl
c3RvcmVfcHJvY2Vzc2VzIHdvcmtlciBpcyBzdHVjayBvbiBhIGZlbmNlLA0KPmFuZCB0aGF0J3Mg
Y2F1c2luZyBrZ2Qya2ZkX3ByZV9yZXNldCB0byBoYW5nIHdoZW4gaXQgdHJpZXMgdG8gZmx1c2gg
dGhlIHdvcmsuDQo+DQo+VGhlIGZlbmNlIGl0J3MgaGFuZ2luZyBvbiBpcyBwcm9iYWJseSBzb21l
dGhpbmcgcmVsYXRlZCB0byBhIHBhZ2UgdGFibGUgdXBkYXRlDQo+dGhhdCBnb3QgY2F1Z2h0IHVw
IGluIHRoZSBHUFUgaGFuZy4gQWRkaW5nIGEgdGltZW91dCBoZXJlIHNlZW1zIHJlYXNvbmFibGUu
DQo+VGhlcmUgbWF5IGJlIGFub3RoZXIgcHJvYmxlbSwgYmVjYXVzZQ0KPmFtZGdwdV9hbWRrZmRf
Z3B1dm1fcmVzdG9yZV9wcm9jZXNzX2JvcyBpZ25vcmVzIHRoZSByZXR1cm4gdmFsdWUgb2YNCj5h
bWRncHVfc3luY193YWl0LiBXZSBzaG91bGRpIHByb2JhYmx5IGhhbmRsZSB0aGUgdGltZW91dCBn
cmFjZWZ1bGx5IHdpdGggYQ0KPiJnb3RvIHZhbGlkYXRlX21hcF9mYWlsIi4NCj4NCj5SZWdhcmRz
LA0KPiAgIEZlbGl4DQo+DQo+DQo+Pg0KPj4gSXQgaXMgYmVjYXVzZSB0aGUgYW1kZ3B1X3N5bmNf
d2FpdCBpcyB3YWl0aW5nIGZvciB0aGUgYmFkIGpvYidzIGZlbmNlLA0KPj4gYW5kIG5ldmVyIHJl
dHVybiwgc28gdGhlIHJlY292ZXIgY291bGRuJ3QgY29udGludWUuDQo+Pg0KPj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IEVtaWx5IERlbmcgPEVtaWx5LkRlbmdAYW1kLmNvbT4NCj4+IC0tLQ0KPj4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5jIHwgMTYgKysrKysrKysrKysr
Ky0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3N5bmMuYw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5jDQo+
PiBpbmRleCBkY2Q4YzA2NmJjMWYuLmM5MjI4NjdjNTY3NSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMNCj4+IEBAIC00MDYsOSArNDA2LDE5IEBAIGlu
dCBhbWRncHVfc3luY193YWl0KHN0cnVjdCBhbWRncHVfc3luYyAqc3luYywNCj5ib29sIGludHIp
DQo+PiAgICAgIGludCBpLCByOw0KPj4NCj4+ICAgICAgaGFzaF9mb3JfZWFjaF9zYWZlKHN5bmMt
PmZlbmNlcywgaSwgdG1wLCBlLCBub2RlKSB7DQo+PiAtICAgICAgICAgICAgciA9IGRtYV9mZW5j
ZV93YWl0KGUtPmZlbmNlLCBpbnRyKTsNCj4+IC0gICAgICAgICAgICBpZiAocikNCj4+IC0gICAg
ICAgICAgICAgICAgICAgIHJldHVybiByOw0KPj4gKyAgICAgICAgICAgIHN0cnVjdCBkcm1fc2No
ZWRfZmVuY2UgKnNfZmVuY2UgPSB0b19kcm1fc2NoZWRfZmVuY2UoZS0NCj4+ZmVuY2UpOw0KPj4g
Kw0KPj4gKyAgICAgICAgICAgIGlmIChzX2ZlbmNlKSB7DQo+PiArICAgICAgICAgICAgICAgICAg
ICByID0gZG1hX2ZlbmNlX3dhaXRfdGltZW91dChlLT5mZW5jZSwgaW50ciwgc19mZW5jZS0NCj4+
c2NoZWQtPnRpbWVvdXQpOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgaWYgKHIgPT0gMCkNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgciA9IC1FVElNRURPVVQ7DQo+PiArICAgICAg
ICAgICAgICAgICAgICBpZiAociA8IDApDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiByOw0KPj4gKyAgICAgICAgICAgIH0gZWxzZSB7DQo+PiArICAgICAgICAgICAgICAg
ICAgICByID0gZG1hX2ZlbmNlX3dhaXQoZS0+ZmVuY2UsIGludHIpOw0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgaWYgKHIpDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBy
Ow0KPj4gKyAgICAgICAgICAgIH0NCj4+DQo+PiAgICAgICAgICAgICAgYW1kZ3B1X3N5bmNfZW50
cnlfZnJlZShlKTsNCj4+ICAgICAgfQ0K
