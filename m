Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9E3C77B61
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 13:28:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 784B610E2EA;
	Mon, 10 Apr 2023 13:28:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E099010E2EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 13:28:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxQLYpes0BPxtV6igA22/6BASdeZDkoMCRHnrWRU235/EK7deYng1cFKoRxKEP3f1I6wNFR81B6JzRi8txLQutxkH79IA5Ufc3h3g6SaLhabHs0SLFTsR44iRl9gktxY8GVqCB90GoPRecLcStv/1scNuvceqDhcd9gHZF4b+XWYvcAqNSVrPUqPHeY8Nh/4g4HAybBX/lUoBC+J2tCnxZm+/l4CDeb4LqYHomcoCSrSX8UJj6sAXpnx+jfVrCiHBsl70YG/DM5A2bAMUXDHvR5eGXtx/ya26RcJMbvgJ2o1BFYAmckhCNO5t6wuh9+QQPc+RVuW1iTKSDlNQEPo7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7P7vjmHMakywO7Q6dy4i53kGS7vp54OsipMpNcsAbM0=;
 b=GPZros7g/ZTd1Ioi6JX9zQp3N4xVra7HJg5uf6bn5OLghuBxP/PsWFj3iBYCM4VvTcglpoFVxfGGSfNOjtRLAXPqpBe5hFsLJ9SvV+IOFO3PRNWi4mTLe2FuVU4m1gGPpH8nX9nXYRHz9d0Rc0TZsOgu78Z4qLi7XB1CAu3zDWZWvsLRk2O92wIMiCvuGq/tV16P5DYGY0hnEl6DH6f5SWZpqiaiHIHBZkWixy9sJzXei3yWSU7MXvGS8PZwRimsTknzMeVr84kZORUbDl0NXjHpVYffhfpCcCnQ1wge3Wql6h0L3nzh1uM4gICwCi6p4Y0tyh6utvl+yaqUSjcXRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7P7vjmHMakywO7Q6dy4i53kGS7vp54OsipMpNcsAbM0=;
 b=V5ZZRveo/Kigx0BxdJwcN60G44mt4Ke9x5Wfnd3Z8WF6wyDLK6Qt+nGso9AfYDjFy8GqjGr05MivrnNkDeQFiiya8Cr2h/nDtCRJJQJvg3BHOrm2aZcqJWeX/DcpJMzY0ujSXPIZXlb7FnJjWqf0LicDGJhvmz3wF7NzcN5F840=
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 13:28:04 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::9365:edd0:6096:4ffc]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::9365:edd0:6096:4ffc%9]) with mapi id 15.20.6277.036; Mon, 10 Apr 2023
 13:28:04 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/display : Log DP link training downspread info
Thread-Topic: [PATCH] drm/amd/display : Log DP link training downspread info
Thread-Index: AQHZaxh+yvisb5IQHkClfF+XmxTFpa8khQUAgAAEp+A=
Date: Mon, 10 Apr 2023 13:28:04 +0000
Message-ID: <MN2PR12MB41284FBF1FD952DAECFBD65590959@MN2PR12MB4128.namprd12.prod.outlook.com>
References: <20230409192108.1505595-1-srinivasan.shanmugam@amd.com>
 <da95d95c-d189-a747-b281-eb42d24b5cb6@amd.com>
In-Reply-To: <da95d95c-d189-a747-b281-eb42d24b5cb6@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-10T13:28:01Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c52aff81-f291-4ea1-972d-976016d85c6e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4128:EE_|CH3PR12MB8658:EE_
x-ms-office365-filtering-correlation-id: 16548334-d48f-471d-4b50-08db39c76a00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UqS49LR5S/QOmSUnD0Dqqr1l96/l0dPU4V3u2UJe1Rbce+8QXBRirr3hhdBMGrR+Y4XUHOJpC8NUPOf6zxNRkBP6Os4COtAW6FojfrbPbtVIfOxpJD+5n/+p8rIwWvt42HmtWKXkAZjqeriwuIUY+UcQIkfJ4Ny2E9uqMoBDGBe17iSeLRLDnk1Jy8u85XleNiKM3muHup6JGN1dEqt3Pc6CbIz5rxkEr0rZRSkA/cBPNbWx3cEFzG/gaaSqiEpMFUQ8gnUgSWyTyvmweVNss+TpYSZkqFQAx0onBPzpBeGEUdTKQszwmU41WlRkYJw4XA5IoWBk6jlZnZrhs+12AbPEQOUphPN5+kFJLa63+7ofoPJlQ4XhHYHcfySATenTPU1TnCENvs7kkA3watTWreyyQz2iiZfgPOvhODaMJ4OYuW4a4+QK01YnEoEnPcgSIZ5lWSeKT/ez4PJ54DHQo3IqlNEhuKcEknfRdtpquPlU35GMaKtZbRTGfbpEQJ/b+5ZulgpISlez/OcwXfHCkDgOYAUYAkalq5LNPIgeTR+AwSTlJeEERpd6ndWz1p+g34l9kKqEs17Xdx07PNK/Epa2sgcJ9OnfFWVf0I7tabt7v7/fNRU7Z5jwCEhRVWl1eOtBgVLOH7o0f9DfG7ZD4A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199021)(110136005)(6636002)(122000001)(478600001)(33656002)(9686003)(26005)(6506007)(71200400001)(7696005)(921005)(41300700001)(316002)(66446008)(66556008)(66476007)(64756008)(4326008)(53546011)(186003)(83380400001)(76116006)(66946007)(52536014)(38100700002)(2906002)(5660300002)(38070700005)(86362001)(55016003)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amxMSnIxakh3Y3ZyM3pDU3c0bjJCYXA1VmVaMzhDQjNzdWhJTUN2aEp2Mlhq?=
 =?utf-8?B?VnR4TWN3NjR0RCtwYlBYNEFWWmJmRGs0NE44Y2lPTnBKQjc0U1M1U1NyNnMy?=
 =?utf-8?B?RjZsQ0N1RnYvZGE0RFQxMzlUamJRMTllT2QrMEljM1U1djRBdFJwbUJxV0Fk?=
 =?utf-8?B?VkpVMXVMUWlacVJJSW9zYWpqUDErY2Z5NVhnV2w0V3JpcWNIYWtFWUdSWUVq?=
 =?utf-8?B?SGZXc3REeXN5b2sxVnU3dUM4V1RYVmxoUFpUQzhlTHpwRXU5QnVBTGxMWWhv?=
 =?utf-8?B?UDJ6VE5veTRlNGhBcGxKTkM1VEtiQjdMaW92YUFobjVjbi9EZWxDWENUcm15?=
 =?utf-8?B?Vm9iOVdyZks1SDd5TktXK2R3b0NZUVpoSjliNXQ4QXNHdUFFTGVTN3kyNDFS?=
 =?utf-8?B?enkwTjVQajdNR1pMTzlaZ0dkUGU0cGk3dUc5TzJudUlKSElibXBHVWpuem1l?=
 =?utf-8?B?UThMcHY4SlkzUG03ckN4VTlndUQvSnVUU1N6ZWFTc0s3ZUdSMDN3VW9rMkJo?=
 =?utf-8?B?bkhJZ1RUdFhlbzIrcHdiMy9kb2tkeEQrUzdIT01pNnVEVit6VERmOEk1TkVO?=
 =?utf-8?B?SFdMaGFyeXRYTjJGN0dpMmN5dzZLSHlQQmwzWWc2TkhWejdnTlJJdE9RRC9C?=
 =?utf-8?B?OU1vS2YzSzVBUWpjZHZJSWh3Z1NYN3dSTnp5VjFlcnRuUVI2cTJGWmRLRDU2?=
 =?utf-8?B?QVQ0ZGR1NS9CckhLNy9SV3l2emNVNHJUVUM2UVRBakx4Tnc5S0tkYlp6UkVU?=
 =?utf-8?B?dGwvS0RrMWU4eDc2TVJOM0VHWE5uUldjdFMrZTNGeU9qTmxWa1pkOVY0UW5C?=
 =?utf-8?B?Z3RPSnJXK2R0SCtUMFB5Wnk2WG16Q2xJNWJWZWM4SENQZDNaM0duTFE5YVUx?=
 =?utf-8?B?TlB0cnNUdnZ2Y1k4YUFocVk4a0dHNW1CQkY1M1NVRENybTZ2WUNZUVFFOVlP?=
 =?utf-8?B?UFY1ZjlwbTVoTTFycXIvQnFiUk1pZ2piRm1aS1A1RkxZUC9PU3ozNEUxOW5r?=
 =?utf-8?B?L1Q0MjNBckUyY3VkMkRWczNURDRqQ05SaHBra0ZwWjBJMjA4djJaUDFqVk9u?=
 =?utf-8?B?K1ZGVTJJNUZmalUxNlVDQU1SWmxmK3NoSjBLblNGTHdOTHUwNFJ0czlDdnI5?=
 =?utf-8?B?T0dhSHhNK2lpYk9ja1MraHBodFJHeDBmaG95U21TZmx3bWFRV0lpM2huTGhF?=
 =?utf-8?B?R0tPZU9VQjh4S3pMTFhIbC9sUjNmOWc0VGRLUnNLOTFOT1p3S2orTFlab2tQ?=
 =?utf-8?B?by9FMTVqRzlMaWZTRnprYWUzdnUvSFpTVHVRdzBYTjNYN29Sc1F2ajMxWFF3?=
 =?utf-8?B?OWlJYmk0aFVQZVNrTGN6Mmp6d3FLWFZYN3loMk9veEhZZU5NR2I0SVNnczJO?=
 =?utf-8?B?TVhyc0NESFdWcHg2a0RWQXZsdDB6aXlGS2t5UzVnbnhVMlJKdlJuRlExSTMx?=
 =?utf-8?B?M1NDZ3BQaWxiTmR2N0NZakw3eEFSNytRYmNKWFMyNDJUYmNyMFhjd1k0Mmpx?=
 =?utf-8?B?a3Z6dXhpeUwzaEZvL1BCalIxbURlZXJqT3EwOXc4VnZZZzU5aTh0L0pVc01h?=
 =?utf-8?B?VVhseDA2S29GcSsrZDFuUFk3bUFsbWt1akRxK1ppZ2xPdld5aUFMQXpwTWNr?=
 =?utf-8?B?dGg0WFdJK2l1ZkhkRWp2dm95amI1UGZwYzE1UERweW5ITms1akI3VHNaWFFr?=
 =?utf-8?B?ZUViZzdmQUpya0hIRm12T2UrdVVuK1VnZXNmUDdiYjN6OTZBL1FnbW8zUHhK?=
 =?utf-8?B?VmZuNGF2MXlDdHhzWFd5VGRXUVhIbExjMGpSNkdKNitscm9pRFhpMHdRTHBH?=
 =?utf-8?B?Uk1JQkMxOE1Vclpzd1hqR2JzWjlVQ3ljdytaY3FWZUkwRCtPUGw3Q0d4aXZG?=
 =?utf-8?B?TGRpQktWUkY2VlVzTG8ydjV2SXFoMXdhSVRNaWszUUt0RnB3dnVxVGs3eXU0?=
 =?utf-8?B?ZS9pdEFqNE1GYjIvNG5DOUtoa3VZVGxrcFFEQWpYcENwMWFzSkhaOXZrdXlv?=
 =?utf-8?B?ZVV5ODZSSmsvbmdLV0h6VW0xL0d1bGpDYmRTeHJ5OGNPL29NOVJZbnExamlr?=
 =?utf-8?B?K2pFTUlkWHh0Z21CbVh4NGdubTZMc2o1cFZRdGVFWkpmUWUrYXBQdzhRT3Q1?=
 =?utf-8?Q?yWcw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16548334-d48f-471d-4b50-08db39c76a00
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2023 13:28:04.2548 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H6oYpc+5eqOPV/us7i+oGyllRZnmYp1nBRMnCVWbkSw/LdXKntz6/8ilDkgKrSyWIgQl9Nt+Ea5ab0IX//pKzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8658
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoYW5rcyBhIGxvdCBBdXJhYmlu
ZG8hIG11Y2ggYXBwcmVjaWF0ZSBmb3IgeW91ciBoZWxwIGluIHJldmlld2luZyB0aGlzIHBhdGNo
Lg0KDQpCZXN0IHJlZ2FyZHMsDQpTcmluaQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogUGlsbGFpLCBBdXJhYmluZG8gPEF1cmFiaW5kby5QaWxsYWlAYW1kLmNvbT4gDQpTZW50
OiBNb25kYXksIEFwcmlsIDEwLCAyMDIzIDY6MzkgUE0NClRvOiBTSEFOTVVHQU0sIFNSSU5JVkFT
QU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+OyBXZW50bGFuZCwgSGFycnkgPEhhcnJ5
LldlbnRsYW5kQGFtZC5jb20+OyBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxv
QGFtZC5jb20+OyBMaSwgU3VuIHBlbmcgKExlbykgPFN1bnBlbmcuTGlAYW1kLmNvbT47IERldWNo
ZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZC9kaXNwbGF5
IDogTG9nIERQIGxpbmsgdHJhaW5pbmcgZG93bnNwcmVhZCBpbmZvDQoNCg0KDQpPbiA0LzkvMjAy
MyAzOjIxIFBNLCBTcmluaXZhc2FuIFNoYW5tdWdhbSB3cm90ZToNCj4gVXBkYXRlIHRoZSBleGlz
dGluZyBsb2cgd2l0aCBEUCBMVCBkb3duc3ByZWFkIGluZm86DQo+IA0KPiBbRG93bnN0cmVhbSBk
ZXZpY2VzIHNoYWxsIHN1cHBvcnQgZG93biBzcHJlYWRpbmcgb2YgdGhlIGxpbmsgY2xvY2suDQo+
IFRoZSBkb3duLXNwcmVhZCBhbXBsaXR1ZGUgc2hhbGwgZWl0aGVyIGJlIGRpc2FibGVkICgwLjAl
KSBvciB1cCB0byANCj4gMC41JSwgYXMgd3JpdHRlbiBieSB0aGUgdXBzdHJlYW0gZGV2aWNlIHRv
IHRoZSBET1dOU1BSRUFEX0NUUkwgDQo+IHJlZ2lzdGVyIChEUENEIDAwMTA3aCkuIFRoZSBtb2R1
bGF0aW9uIGZyZXF1ZW5jeSByYW5nZSBzaGFsbCBiZSAzMCB0byANCj4gMzMga0h6XQ0KPiANCj4g
QmVzaWRlcywgZml4IGNoZWNrcGF0Y2ggd2FybmluZzoNCj4gDQo+IENIRUNLOiBBbGlnbm1lbnQg
c2hvdWxkIG1hdGNoIG9wZW4gcGFyZW50aGVzaXMNCj4gDQo+IENjOiBNYXJpbyBMaW1vbmNpZWxs
byA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCj4gQ2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJy
eS53ZW50bGFuZEBhbWQuY29tPg0KPiBDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+DQo+
IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IFNyaW5pdmFzYW4gU2hhbm11Z2FtIDxzcmluaXZhc2FuLnNoYW5tdWdhbUBhbWQuY29t
Pg0KPiAtLS0NCj4gICAuLi4vZGlzcGxheS9kYy9saW5rL3Byb3RvY29scy9saW5rX2RwX3RyYWlu
aW5nLmMgICB8IDE0ICsrKysrKysrLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0
aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgDQo+IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2xpbmsvcHJvdG9jb2xzL2xpbmtfZHBfdHJhaW5pbmcuYyAN
Cj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvbGluay9wcm90b2NvbHMvbGlua19k
cF90cmFpbmluZy5jDQo+IGluZGV4IDcwZmMwZGRmMmQ3ZS4uMmQwNjdhNGE4NTE3IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvbGluay9wcm90b2NvbHMvbGlu
a19kcF90cmFpbmluZy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9s
aW5rL3Byb3RvY29scy9saW5rX2RwX3RyYWluaW5nLmMNCj4gQEAgLTE1NjAsOSArMTU2MCwxMCBA
QCBib29sIHBlcmZvcm1fbGlua190cmFpbmluZ193aXRoX3JldHJpZXMoDQo+ICAgCWogPSAwOw0K
PiAgIAl3aGlsZSAoaiA8IGF0dGVtcHRzICYmIGZhaWxfY291bnQgPCAoYXR0ZW1wdHMgKiAxMCkp
IHsNCj4gICANCj4gLQkJRENfTE9HX0hXX0xJTktfVFJBSU5JTkcoIiVzOiBCZWdpbm5pbmcgbGlu
ayglZCkgdHJhaW5pbmcgYXR0ZW1wdCAldSBvZiAlZCBAIHJhdGUoJWQpIHggbGFuZSglZClcbiIs
DQo+IC0JCQlfX2Z1bmNfXywgbGluay0+bGlua19pbmRleCwgKHVuc2lnbmVkIGludClqICsgMSwg
YXR0ZW1wdHMsIGN1cl9saW5rX3NldHRpbmdzLmxpbmtfcmF0ZSwNCj4gLQkJCWN1cl9saW5rX3Nl
dHRpbmdzLmxhbmVfY291bnQpOw0KPiArCQlEQ19MT0dfSFdfTElOS19UUkFJTklORygiJXM6IEJl
Z2lubmluZyBsaW5rKCVkKSB0cmFpbmluZyBhdHRlbXB0ICV1IG9mICVkIEAgcmF0ZSglZCkgeCBs
YW5lKCVkKSBAIHNwcmVhZCA9ICV4XG4iLA0KPiArCQkJCQlfX2Z1bmNfXywgbGluay0+bGlua19p
bmRleCwgKHVuc2lnbmVkIGludClqICsgMSwgYXR0ZW1wdHMsDQo+ICsJCQkJICAgICAgIGN1cl9s
aW5rX3NldHRpbmdzLmxpbmtfcmF0ZSwgY3VyX2xpbmtfc2V0dGluZ3MubGFuZV9jb3VudCwNCj4g
KwkJCQkgICAgICAgY3VyX2xpbmtfc2V0dGluZ3MubGlua19zcHJlYWQpOw0KPiAgIA0KPiAgIAkJ
ZHBfZW5hYmxlX2xpbmtfcGh5KA0KPiAgIAkJCWxpbmssDQo+IEBAIC0xNjQwLDkgKzE2NDEsMTAg
QEAgYm9vbCBwZXJmb3JtX2xpbmtfdHJhaW5pbmdfd2l0aF9yZXRyaWVzKA0KPiAgIAkJCQlicmVh
azsNCj4gICAJCX0NCj4gICANCj4gLQkJRENfTE9HX1dBUk5JTkcoIiVzOiBMaW5rKCVkKSB0cmFp
bmluZyBhdHRlbXB0ICV1IG9mICVkIGZhaWxlZCBAIHJhdGUoJWQpIHggbGFuZSglZCkgOiBmYWls
IHJlYXNvbjooJWQpXG4iLA0KPiAtCQkJX19mdW5jX18sIGxpbmstPmxpbmtfaW5kZXgsICh1bnNp
Z25lZCBpbnQpaiArIDEsIGF0dGVtcHRzLCBjdXJfbGlua19zZXR0aW5ncy5saW5rX3JhdGUsDQo+
IC0JCQljdXJfbGlua19zZXR0aW5ncy5sYW5lX2NvdW50LCBzdGF0dXMpOw0KPiArCQlEQ19MT0df
V0FSTklORygiJXM6IExpbmsoJWQpIHRyYWluaW5nIGF0dGVtcHQgJXUgb2YgJWQgZmFpbGVkIEAg
cmF0ZSglZCkgeCBsYW5lKCVkKSBAIHNwcmVhZCA9ICV4IDogZmFpbCByZWFzb246KCVkKVxuIiwN
Cj4gKwkJCSAgICAgICBfX2Z1bmNfXywgbGluay0+bGlua19pbmRleCwgKHVuc2lnbmVkIGludClq
ICsgMSwgYXR0ZW1wdHMsDQo+ICsJCQkgICAgICBjdXJfbGlua19zZXR0aW5ncy5saW5rX3JhdGUs
IGN1cl9saW5rX3NldHRpbmdzLmxhbmVfY291bnQsDQo+ICsJCQkgICAgICBjdXJfbGlua19zZXR0
aW5ncy5saW5rX3NwcmVhZCwgc3RhdHVzKTsNCj4gICANCj4gICAJCWRwX2Rpc2FibGVfbGlua19w
aHkobGluaywgJnBpcGVfY3R4LT5saW5rX3Jlcywgc2lnbmFsKTsNCj4gICANCj4gDQoNClJldmll
d2VkLWJ5OiBBdXJhYmluZG8gUGlsbGFpIDxhdXJhYmluZG8ucGlsbGFpQGFtZC5jb20+DQo=
