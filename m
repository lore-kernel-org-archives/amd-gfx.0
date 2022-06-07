Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0A8C43334
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 00:37:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C256F12A600;
	Tue,  7 Jun 2022 00:37:36 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2052.outbound.protection.outlook.com [40.107.212.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FF1612A5FF
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 00:37:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5aYbeAa+qiZ/xEyHUpQwY/1B7M8Gu7I96SvfyGOoV8fXANz19LN05aLGrLI8xtP5VT4eMECWAF2yRq8K0hMX/xjNm944pi7EKFpq5hG9YNZ8+Ntgaxs/zKF2sHyrkToSy0v4wCpN/xQlKFEaMrmPZRI4HC0h9u/auBl9e2u75rpevs757HCRXdNtVHtKFRJj8rCsikP8oOVNTM9ItOILqttWyBNIGn/jUvTlqVAJuky5TA/gp8rX1mBRVfzBK2PcYXHMb4ZWquM4Hhe/FRDXKXwmd6MExt7JU9xVdxAwTvuxj7KFkHrtBMXJMwWpS6OzYxa9IZzxIX7SlXblyuwzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HV4RYIuCY/lUp4P//ax0NGwjaXsThr2LHVOA4Q7uO94=;
 b=SQh4ck85D7SkJVPyT5l/yTKHnbunMixjqp+yyUt7LPnL2szQoQO2GbwSQSKWks6IiV7KGEmjRDCLldCyyJ8iXl+kWwdCoep5VeK7xyvPp50xy6m/w36HmtGa8fAGRjRSb4hJR0L+CEOvFVNRkRDAlERbAkH86ef2Npgf3dxOa9f6PpvFqWvc388SW6pLXJa4Jb4OO1ErqYA/PtWQMR4+9AQV7JJInwHjFAu0JGjT917h4P6dx3IY7W6C5jIlJ6OdhutgSeI4St9Ah/M0JZ3Lpgf6FMdj+fLUyW7T6XqXAiclM3c4FJkRzbskSKqeHhwziTPOHMl1XGEhkBRPYy56NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HV4RYIuCY/lUp4P//ax0NGwjaXsThr2LHVOA4Q7uO94=;
 b=qCxiM/L8R+Ir6aOBFbH1rvUhDHAKOitlWFl1IERoSTZ/boyIssxAiOX5YvXl0eENFsz/wltE0aWyX097OFw3IQJ3lmNYkCi2zN2KEdYP9Ws/9nVSrhtyDGvVCQiCG4xtot7DI/TCULpQZb9IBoCGDAqpLMcl9kJ8y+7dGsxeSq0=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3001.namprd12.prod.outlook.com (2603:10b6:5:116::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Tue, 7 Jun 2022 00:37:32 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::95af:3466:5c5f:1202]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::95af:3466:5c5f:1202%2]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 00:37:32 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: simplify amdgpu_ucode_get_load_type()
Thread-Topic: [PATCH] drm/amdgpu: simplify amdgpu_ucode_get_load_type()
Thread-Index: AQHYb9yGQsuuyyQ3ZEOeE20TTR3GGa1CyfAAgABjzMA=
Date: Tue, 7 Jun 2022 00:37:32 +0000
Message-ID: <DM5PR12MB24699A9737F0FFD9543C0900F1A59@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220525020926.1951685-1-alexander.deucher@amd.com>
 <20220525020926.1951685-3-alexander.deucher@amd.com>
 <CADnq5_OcqxGKYYfOXVoH4so3Wqa2R3TSTARXb7+-8SCJEq7p=A@mail.gmail.com>
In-Reply-To: <CADnq5_OcqxGKYYfOXVoH4so3Wqa2R3TSTARXb7+-8SCJEq7p=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67c0620c-b9fa-4009-87b6-08da481de8b8
x-ms-traffictypediagnostic: DM6PR12MB3001:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3001379B519871F085EEEA78F1A59@DM6PR12MB3001.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 90dOUDEjka1LWLbu06Gau/pV9ceTS5ohmKgznmWAIc6tkEoDFWYGD3UBveeKbxye5thqy/YgS5vj45iQjYNs6DapLqO2zF2VLAdxS0yUN21O0f7Z9/aNJJTGxTLl9PmKs5ra9rjavwKlR6j9ROBi6VsJ8rNqYF9uCPZKZGL2HCsIB5G7mAmzwjQblh6+2bdg+QXBS5RINfsaX66K35vrs/+P5kdQuM1VFfGTZGywYOQzvSryGuJ6ubO9VwCvhw26zB4/AdLBA4HKtsYySx/CQyQzAgYyo4OXD/w3ZD64bvaRUKF8m5LsJFGqO/mnYoOq3JMT95ajwXgar3wwYDm8cg5CJXa7hIKwzJU/sDu/bll8ciRRTOc3uaPve+4I70yGk2xoGzPhTfSJpA4wzh+t8QW8bCtgvhBNQP5ciKq9WrQLdQ+GO5O1bnGbISNYq9PD8ZFkao0c1O3BJYGYBe3YBSSjthup9Od+fjI9VGY3iyCyeN7EjYXY+HVrWeSkNM/WPmiTaHvNq4XNDneFb69vlRiNii/8i90WqwwSrfpfnZr3H84g3FOw7lPSLKrhxFZfFWMA2J93YLN6F2rTFA0UZqr1ZO+0cd17wz1ffRjmNIi3J/O260cVLog3w7PN+Vl/KyWLUvwEEBm23V0OU7a9TdzCst5q854S2/qSNiF1pl1zQCGSn4j+t7oJCTaONZ3ZP+urVkCZj4GnJaqMalxgHQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(86362001)(38100700002)(508600001)(52536014)(316002)(55016003)(83380400001)(33656002)(186003)(2906002)(53546011)(110136005)(6636002)(7696005)(6506007)(9686003)(71200400001)(122000001)(5660300002)(8676002)(4326008)(8936002)(64756008)(66446008)(66946007)(66556008)(66476007)(76116006)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3FIY1RubW1CeEp6bXV6a0R3QXBBbENYUHVMMzN5ckdLdmxiSytVYXpiaXBx?=
 =?utf-8?B?S005VFlNa296czdNWEhhY2QrbGt4SWhXeFFmSy9UMC9XNEtEdjN5SnBvMFlR?=
 =?utf-8?B?KzRuVFcxUU1ZUHFvVExWVlFKV3Q2UzRMN2ZzQWIyUVc4bDhPNXp5OEJqeHNr?=
 =?utf-8?B?UHAvZDlsanUrQjZYL25kM1BkZ3pnUG1wd1IzdUFvMEhHYnZXeERPWUlERklx?=
 =?utf-8?B?M0JyRE1FdndNZnVIUk5aUFBRMXZvTkxOT3dPQnMzMXVQUWhublRQRVYwdURi?=
 =?utf-8?B?OHdyaGZKSmRSTVA2QUlFM29LZktKNU4vV0w1Q1laL1VreS9wSEVaM1E1djVk?=
 =?utf-8?B?aU4wRW9rc0FZUmI2V2ZrQ1VlWEgvT1JQUlU5UkhGZWhaN0ZiRXFBMHp5MC9v?=
 =?utf-8?B?MDdHYmFrNWFaUVUvVEk5REJWanJ1Wkl5cm9qY2t5T3Y0aTE4ajUvQ2ZPVEJy?=
 =?utf-8?B?OHBDTFF2ZWVkR2FhK3lSdS9QTXh5bkpOaE1NRElDSUZMRmVhZy90MHZwSjkw?=
 =?utf-8?B?NjlSajlvM0U5cExBcS9Mem8zVm15M0VVbmVONml4NUlUNlU2NFZxU0pYa1RK?=
 =?utf-8?B?MWt6UnZPS0hDSDhFbVZpa05IYU1ubG02SVJPZ1FTbjFVb2Zqa2haQlgrL2VD?=
 =?utf-8?B?akpibnkrRkQ4UGRhbGE1eWhQa2RxTmNVYmhDbHYzV2NxYWxNQWhnOWhrUTJH?=
 =?utf-8?B?R01mN0JtSFBIdUw2MUtjNXhlOUE2MUc0QnN4ejl2N0hwTmxVaEN5U3Z1MnEw?=
 =?utf-8?B?VnlneEdBdDgxUm9WTHg4TllUMi9nRmtJdjZXR2l0bWhEZDdlZUNKclRvT1NX?=
 =?utf-8?B?L092aWphYk1HcEFYVWpENGNoNXg2Z1VEK0grY1dBaWZ0OXo0QWswclZnZTBq?=
 =?utf-8?B?cmZ6MmUxRlhiOE0rOHpzUzY5dkpwajFJWS9DakdUSXBCb0lsNEluaFFTZnVG?=
 =?utf-8?B?V1JZNnV5elIwUlYwMmRkbE9hT3Rha1hhZlNhQmRSbzdTd2pYSm1YSU0yYks3?=
 =?utf-8?B?OVFId0NXdm5RN3BxbjNLZ3BEZ2JPL2sxTkxOYW84OStnR2RhTHRJeCtXZUNT?=
 =?utf-8?B?Q3Y5RUVSWHdDZlg3cGc5elIxdnpDaDJPTE9yZkVZU2s0dHN5bzlFaGkwZnRq?=
 =?utf-8?B?L2dPanptZDBJQUpjWUdja3JGK0w2TEtuSDBsS1RJZmJ6MUNGTnlvRGFFOTM4?=
 =?utf-8?B?RldRaXRObnhvVGJJVndlNW5GOSswZE1QdUlwWEdRclZhU3I3RFRWTnYrNVNB?=
 =?utf-8?B?bmluOHdjcDUvTzFaZVFUbmxDVkRMOTFFQXo4TXdqQ1BwektoVHZac0d1MWk1?=
 =?utf-8?B?MC96bVA2aHJISHpWSEVYSkJwUWorTW9qY3BlZnovSFlMVWlXdytpK1ArVVZl?=
 =?utf-8?B?VHRJRjFScE8zbmZxUEM5bHZkZHlHZnUxQmpjdE83Tlk2dVRadXlEVzFyRGlD?=
 =?utf-8?B?UWFFWk5QNjlCWkZ4YXE2TTIvTjNXcFAvRU8rU2MzT2JQNFdqejN1emduM1l3?=
 =?utf-8?B?TXVjRUNQZW1DcW91RHJpUFRXcDNqelhCK254TXd0Y0U0d3FMK1hyUThvUkhJ?=
 =?utf-8?B?VHM2ZHdlcGQrbElKYUdLNUh5QURORWt1WDZEUzcrZ2h3OEFhYzZTbmJacU9o?=
 =?utf-8?B?T1NtbUxpeWNvU2pTcHExVGtzSWRIcjNQRjFhZWtzU1d5b2kzUS9wOENDMVkz?=
 =?utf-8?B?TUQyZG96U0lkbThBNHQ0WVVrK2ttOGZiN2dtM2wvajhjMFd1NkxwZExRVG5Z?=
 =?utf-8?B?blNHaEJXZDlKQklHSDlUM3FVZEJFNjhsb3loeHBORW5vNUpDUTB5MkZaRk9r?=
 =?utf-8?B?MVlSWkNRYU4yM29VMVJEelhMMVBCL0gvYnVYKzJLd3dtQys1R2pDbXlnWUZ2?=
 =?utf-8?B?eXFiNjYwSWp1Smh0UWpVVWJPbEVxYnMzTmJTY0dvTHdyYzB1Sk00Rng2bEZt?=
 =?utf-8?B?dXV3TjJUbmhubnNrbE42cWxlVWNiTitEdnRsQ3JNNDRoOEpmRS9XUGRGWU5j?=
 =?utf-8?B?dXhudlVWZUZjMmNBSytsQisxaEQ0T25rSE5lbk1YaERKRytLcUdUN2tRUDB4?=
 =?utf-8?B?WlA4VlZBRkx3SE96UDZDRi9qaE1NNkNGOVhZK3pEYzlHcktNMHNTbXJVZitS?=
 =?utf-8?B?ck5yRjZwZ1pDbWtVYUdWc0gyQTVzOGtCelZ1Q09oNmNMTWhEWU5NR2VxYUlX?=
 =?utf-8?B?MkhhYmdnK1RCRlNNZ2Q1bGdQZXMwUkNBUWlJSjh4bTZWRy9GQ01TckJqcy8x?=
 =?utf-8?B?WmxLZm9jMkZ1emg2clp3bWRLdmJsRytadVUwZjByVi8wMEU5Yit6ODVUSC9l?=
 =?utf-8?B?aVdhUk5aYitiYkRELys2QVFKUk1zOGU0VGNzUUtVNHkzaTUxUDNsQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c0620c-b9fa-4009-87b6-08da481de8b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 00:37:32.1849 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EiHSh2EujxRHo4n1cNoRvv5YmOoZQDHeyBMn/cTp97Y7H+1/T6NNT0xBqq/jYBrYFO+ndZmh95NOtn9fU6YPDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3001
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
ZXVjaGVyDQpTZW50OiBUdWVzZGF5LCBKdW5lIDcsIDIwMjIgMjo0MCBBTQ0KVG86IERldWNoZXIs
IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4IGxpc3Qg
PGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJt
L2FtZGdwdTogc2ltcGxpZnkgYW1kZ3B1X3Vjb2RlX2dldF9sb2FkX3R5cGUoKQ0KDQpQaW5nPw0K
DQpBbGV4DQoNCk9uIFR1ZSwgTWF5IDI0LCAyMDIyIGF0IDEwOjA5IFBNIEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4gd3JvdGU6DQo+DQo+IFRoaXMgaXMgdGhlIHNhbWUg
YXMgdGhlIGRlZmF1bHQgY2FzZSwgc28gZHJvcCB0aGUgZXh0cmEgbG9naWMuDQo+DQo+IFNpZ25l
ZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdWNvZGUuYyB8IDIwIC0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjAgZGVsZXRpb25zKC0pDQo+DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdWNvZGUuYyAN
Cj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdWNvZGUuYw0KPiBpbmRleCBm
ZmE0YzBkMjA3ZGIuLmMzMTI1NzdkZjU5NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Vjb2RlLmMNCj4gQEAgLTQ4NiwyNiArNDg2LDYgQEAgYW1kZ3B1X3Vjb2Rl
X2dldF9sb2FkX3R5cGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGludCBsb2FkX3R5cGUp
DQo+ICAgICAgICAgY2FzZSBDSElQX1BPTEFSSVMxMjoNCj4gICAgICAgICBjYXNlIENISVBfVkVH
QU06DQo+ICAgICAgICAgICAgICAgICByZXR1cm4gQU1ER1BVX0ZXX0xPQURfU01VOw0KPiAtICAg
ICAgIGNhc2UgQ0hJUF9WRUdBMTA6DQo+IC0gICAgICAgY2FzZSBDSElQX1JBVkVOOg0KPiAtICAg
ICAgIGNhc2UgQ0hJUF9WRUdBMTI6DQo+IC0gICAgICAgY2FzZSBDSElQX1ZFR0EyMDoNCj4gLSAg
ICAgICBjYXNlIENISVBfQVJDVFVSVVM6DQo+IC0gICAgICAgY2FzZSBDSElQX1JFTk9JUjoNCj4g
LSAgICAgICBjYXNlIENISVBfTkFWSTEwOg0KPiAtICAgICAgIGNhc2UgQ0hJUF9OQVZJMTQ6DQo+
IC0gICAgICAgY2FzZSBDSElQX05BVkkxMjoNCj4gLSAgICAgICBjYXNlIENISVBfU0lFTk5BX0NJ
Q0hMSUQ6DQo+IC0gICAgICAgY2FzZSBDSElQX05BVllfRkxPVU5ERVI6DQo+IC0gICAgICAgY2Fz
ZSBDSElQX1ZBTkdPR0g6DQo+IC0gICAgICAgY2FzZSBDSElQX0RJTUdSRVlfQ0FWRUZJU0g6DQo+
IC0gICAgICAgY2FzZSBDSElQX0FMREVCQVJBTjoNCj4gLSAgICAgICBjYXNlIENISVBfQkVJR0Vf
R09CWToNCj4gLSAgICAgICBjYXNlIENISVBfWUVMTE9XX0NBUlA6DQo+IC0gICAgICAgICAgICAg
ICBpZiAoIWxvYWRfdHlwZSkNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIEFNREdQ
VV9GV19MT0FEX0RJUkVDVDsNCj4gLSAgICAgICAgICAgICAgIGVsc2UNCj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIEFNREdQVV9GV19MT0FEX1BTUDsNCj4gICAgICAgICBjYXNlIENI
SVBfQ1lBTl9TS0lMTEZJU0g6DQo+ICAgICAgICAgICAgICAgICBpZiAoIShsb2FkX3R5cGUgJiYN
Cj4gICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPmFwdV9mbGFncyAmIEFNRF9BUFVfSVNfQ1lB
Tl9TS0lMTEZJU0gyKSkNCj4gLS0NCj4gMi4zNS4zDQo+DQo=
