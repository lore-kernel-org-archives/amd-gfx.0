Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29DAC433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 03:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69068611B0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 03:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69068611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08F886E9EA;
	Thu,  8 Apr 2021 03:41:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C9746E9EA
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 03:41:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lD4Gd+fjnRyUpN2MaAbK7Pf5boP73Kh52Fb0yHOwig+YEIXdN3ooqpj9377GTYYzrdCclN8fHD6cgu8fLwQsn0zl/SOR1SP1vQy5BtF7QunU4C/4UQJSpq6+ocJW9eGw2U0jH8addQ4G3c6OwVmnm/X3+znSNxLkZQNuv0FfUP5dZQ3eBtZ/aONqj+JwtLluS3NBjvE62zW/sN6zOKgprkD9NbXMwA+3aOU6mzai3X7wgiGjCzQBEzklkpo4Il4BCJleKle2uobsvxz7fY4QjQ3ZQq30MhTynMq5zwPxNN9NCpAOzzxxSnMAERJ4ULv5hbL8GVqmcosT5K+Kjov4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaOetsdtGfIN1zLU6cvvFEgyJz9gUpus/6z9X3+BghY=;
 b=hmU7V5wEAETnjNfj7QpFkZfmhonhrfyVQVy0e9/TuMuNFy28HGWCQwAIb4L7Gb61uKsdeA6V0CF18gwwrK1mAbwyjS5AXUg1lQ9Lx/c892CFS6OflwHofLlNszX4JAFrmYuIZzORdEgBkFT92nHtlZy9OGcSX10GMtO0sQT4z0Web2KbEDSZdxc9jWh84K8vigzxt/5ymcwgLipsYQx/JKxqdFWoQO5OlWHNMV23nYsgs3EAw12K+rb3KXx8CNB+3SsV2ESxOnOa/LlIePz/9kF8mY9XETSpl7Cg0bGLbohkoeYkn9aMq8quQaqkaiypbLkib7mcp1KShYhPrnl2WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaOetsdtGfIN1zLU6cvvFEgyJz9gUpus/6z9X3+BghY=;
 b=dHO4siNhHGY+xnEEuHgW4o4O3M0os9eXXnfWYX9p2Fr65tu8VA/7LB1s7DGFaiDttPo+iCsnG5wbedcCT43zZn5KnES7ikBOFt+b+CEY3mFNSSKNdwoYFV4rf3R5sMY1AyTNo2jWj2v+AehD8khZBNEz0EYa6HH4lc/sgBfG6jM=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 8 Apr
 2021 03:41:31 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 03:41:31 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Sun, Charles" <Charles.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [0001-increase-time-out-2s-send-msg-to-smu.patch] drm/amd/pm:
 increase time out value when sending msg to SMU
Thread-Topic: [0001-increase-time-out-2s-send-msg-to-smu.patch] drm/amd/pm:
 increase time out value when sending msg to SMU
Thread-Index: AQHXLCfes+YXDhgaAk27zxktCrj20qqp+XJO
Date: Thu, 8 Apr 2021 03:41:31 +0000
Message-ID: <MN2PR12MB4488AC669777EF0CAEC82839F7749@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210408033234.960661-1-charles.sun@amd.com>
In-Reply-To: <20210408033234.960661-1-charles.sun@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-08T03:41:31.070Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75870098-b968-4070-2d5c-08d8fa403332
x-ms-traffictypediagnostic: MN2PR12MB4486:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4486F37B7CF8CD0F6A3D871FF7749@MN2PR12MB4486.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VCwJcSsm3xQxUPZM2sVWO3IQWu57KtwEniA7RNFhodNl5pmFw79yeoyPWyEkavsoXgb4+8KK0G0VyGvvUomRpCucwG1X7QJ32AVhB/cis9sHaJ44hczHKWJhVkmtRqp9Thw6RjD/w305NvzWRV8J6Fj1oi3ZVZjnjqru3bFgK9hxHUHQGvQadlhz4CvxbQqDxO3d9KmDxFeNGGQrMfdmpPDgyVcF6hCfplxM8QIZfNkw164Llio4pnCAjB1C2OgtBMU+MtG0SCdWbo0anfNPoDwiapVERmPfqSxiBeudkLcse97YMjoFIyyU5JOaO+Ol7N22/OAUzj5n+G2W7q54fh1LY5XyaJqd0FprbcIsJ8G9ixLHjrLEETYrePpywFN/5s8vz/MdzCt5EAZ2ltGAKGL6a38uvLhJl6IKFa97qk80176fT/BH9YJD+VFYgqNH3hkEjOelrxNSnjnGDB1drJ/OVOsc2diPizqnh+Tdzp/xVV6thrMM+/51VhTQWyU+2c9DycxS22fH+vd6WWT9Up5LWS1bQY+ddvI9BuQhxpFF8sQ7KPpvrNnHgnDDs3j2y0767LVlUdrnC0d9LqveVqJxRLd6pjPMrz+8LVMqSZuPid3HDGnPjzDB0W/oPrumznmwN3f6KXTl/nKThHgkzL2jdA8OzW5cXkTl/1OQ2N8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(83380400001)(8676002)(8936002)(4326008)(66476007)(110136005)(9686003)(19627405001)(26005)(55016002)(316002)(33656002)(478600001)(7696005)(76116006)(86362001)(5660300002)(66446008)(64756008)(66556008)(52536014)(186003)(66946007)(71200400001)(53546011)(38100700001)(54906003)(6506007)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?bG4yL1d2REgvcXdhd2tKTm1YdWFodUpCc0xmM29Ic2FzcXY2UEtKL29kQUVt?=
 =?utf-8?B?V2p1NSt4ZXdUdk9CZ1BieHJ4SHJsUGpHV2lHeHVFZlk4RDJ5b2pBSTY5RGtO?=
 =?utf-8?B?N2RtZ1VQYjZXajBhM1NqTzBob2RrQWZrVDBIcVBwR3dzS1Y4Uno4SlprOGRM?=
 =?utf-8?B?dmJRRXVad2ZOSE5TcnhENTF0ZkZSak5YL0RQaGNabXFLSFhEak5ZdGN2Wkpx?=
 =?utf-8?B?dk5Gb0ordW40MzJreG1OSkw0djllWjc0VXgxOXM0SHRENEtoWUszZm1zOFVR?=
 =?utf-8?B?UGd0dWtkWmtVdHZETUlUdjRnZnZJcGg2am1Hc3pQZnBXR3FnV1YvWUxwVDQ5?=
 =?utf-8?B?ZUYrcHllK0FBWFB3dnVZY3lTOFkwZ3RrYXBVRExYTW5odWQ1VzZhVjhuNGkr?=
 =?utf-8?B?eHMvamFiQUl1dHNWeDVSYUQ5M29haXZGSFp2R2w4SElMdVVhZktQTWNyQlNU?=
 =?utf-8?B?aTYwRDdhcFQ5RFJ1NDVZZWlVUzBqdGVsbVlHUnp5NW9mb1F5VXRMMU5OZkx4?=
 =?utf-8?B?YkpiaUhSSjFkOTRtYVZMcjdYODdNNW1hSkdGU3NhcGhJN2ZQYWs2SWJlRWgz?=
 =?utf-8?B?WEZ1Mk81TW5xOXhlVEdoajRFalZoNVovSzlVOS83OFNtYTgrT0k0SWxwWnk0?=
 =?utf-8?B?dUJkSWxzbGFRaUozWGYzbFZ1U3ROQmRNUHozdVJheWVzd0t4SWN6by83SUs2?=
 =?utf-8?B?aFRhMlJIdm9FN1dxVk1vcjdkMUViaGw3NFEyRXdIMEJ2aDA4bFJJdHhBUUcw?=
 =?utf-8?B?WXBCaEtEVStpVlhXTmc5a3llTDhEYnRHbys1T1dieG9Nd2Zld1h1WU1yUTBl?=
 =?utf-8?B?ZlJ1V2dncm5pU2NueEU4d3ltb0F1Q1FIZjBmR2hOUHVLS0sxeW43L3J0RkJZ?=
 =?utf-8?B?azJTMzl0MS9tKzVFakFmdGJOU1NrblQ1ekxrWTVlQWlvK3ZqS2I4aDJCaWlY?=
 =?utf-8?B?ZUE0emNvamJmckczVlp0ZjZKTTJSei9PK1ppaDM3ZENsd2tuS1hrSnVwOWNG?=
 =?utf-8?B?OTZSWDQ2aG0rb3BWVDFybTUxVm56WDNZOW4xcDFtWXZZSGpMNVJhbDB3WjlU?=
 =?utf-8?B?RDdtMXFaUVRXamlnS1Npc1REdVpZc2VXbW1BYkFHN3lPNVppc3FqMHhXZnpv?=
 =?utf-8?B?elZBeVZ6VXFhaG9HZTJ6T0ZmR1V2MmJsaGV4YWVhclBqMXVYcWR2bExRb3Ey?=
 =?utf-8?B?ZTJFc0hLTGw1VmJvNlI5cGQrdUo2L0xXckVCVjN1SDRaa2FPMktmck5kaXVG?=
 =?utf-8?B?WG1LWjdaRmxQaHBnVG0yTWFPS0FJWDdONUVCS3F4MFRWU3pGMVhHQ1hpZUFY?=
 =?utf-8?B?emhSalg2NUwxS2xGYWcxTGJhSWtpdlNCM1ZsODJlODZvdVNBUWRRM0dTMXBF?=
 =?utf-8?B?OEU3aHcrNlBYTVJmM3ZJSzFydFZXNFZDa05zalc3UWxXbWJjWEhUY21kdU96?=
 =?utf-8?B?Z0pDcXQ0VWRHajlUV3hQOVl4eHhPUUNLK0lzajBkY2pFeFZUMm1oUDc3Q3kr?=
 =?utf-8?B?N2VTK2VvU1F1eEQrNG5DcHZPNDVWMXdMZ1BhMWdtcGxIVGVqQnhYd24zb2Rq?=
 =?utf-8?B?TDdDMW15QysvU3ZnRVJuSFFyRlZxdTVUU2dIQlA4eUt4QjR2SWlhN0xPT21j?=
 =?utf-8?B?Nk9uc3FFSm5WMG0rMDZoeDM4QVpvVDNsa2NhelNseWZEd3Y0K05LalBheklS?=
 =?utf-8?B?SkdSR0FQRnZtb0dlNjU3ZEdMc3RuclRVczc2RUFRTDJQdnhtZkJDczRkbHZP?=
 =?utf-8?Q?iwhj3K/eMuldYT9lEy5Ov4eIdKka1pXZROobtkS?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75870098-b968-4070-2d5c-08d8fa403332
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 03:41:31.5627 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y7ejRmJixVJ4P5etjlzDIO1X3Azd1/gVdrtm3ZPW1i/aSiWiVbQnQCxuJMj+8J07nlFcOuwhPR5yI7LfzH2i4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486
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
Cc: "Su, Jinzhou \(Joe\)" <Jinzhou.Su@amd.com>, "Liu, Zhan" <Zhan.Liu@amd.com>
Content-Type: multipart/mixed; boundary="===============0918977714=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0918977714==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488AC669777EF0CAEC82839F7749MN2PR12MB4488namp_"

--_000_MN2PR12MB4488AC669777EF0CAEC82839F7749MN2PR12MB4488namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpZ
b3Ugd3JvdGUgdGhlIHBhdGNoLCBpdCBzaG91bGQgYmUgc2lnbmVkLW9mZi1ieSB5b3UsIG5vdCBt
ZSDwn5mCICBFLmcuLA0KDQpTaWduZWQtb2ZmLWJ5OiBDaGFybGVzIFN1biA8Y2hhcmxlcy5zdW5A
YW1kLmNvbT4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpGcm9tOiBTdW4sIENo
YXJsZXMgPENoYXJsZXMuU3VuQGFtZC5jb20+DQpTZW50OiBXZWRuZXNkYXksIEFwcmlsIDcsIDIw
MjEgMTE6MzIgUE0NClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyA8YW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmc+DQpDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIu
RGV1Y2hlckBhbWQuY29tPjsgTGl1LCBaaGFuIDxaaGFuLkxpdUBhbWQuY29tPjsgU3UsIEppbnpo
b3UgKEpvZSkgPEppbnpob3UuU3VAYW1kLmNvbT47IFN1biwgQ2hhcmxlcyA8Q2hhcmxlcy5TdW5A
YW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4N
ClN1YmplY3Q6IFswMDAxLWluY3JlYXNlLXRpbWUtb3V0LTJzLXNlbmQtbXNnLXRvLXNtdS5wYXRj
aF0gZHJtL2FtZC9wbTogaW5jcmVhc2UgdGltZSBvdXQgdmFsdWUgd2hlbiBzZW5kaW5nIG1zZyB0
byBTTVUNCg0Kd2hlbiBkbyBTMyBzdHJlc3MsIGxvdyByYXRlIHRoYXQgUG93ZXJVcFZjbiBtZXNz
YWdlIHdpbGwgZ2V0IHJlc3BvbnNlDQptb3JlIHRoYW4gMXMsIHNvIGhlcmUgaW5jcmVhc2UgdGhl
IHRpbWVvdXQgdG8gMnMNCg0KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVf
Y21uLmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdV9jbW4u
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211X2Ntbi5jDQppbmRleCBiNzI1ZjI2
MzA5MmIuLmRjN2QyZTcxYWE2ZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
c3dzbXUvc211X2Ntbi5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdV9j
bW4uYw0KQEAgLTc5LDcgKzc5LDcgQEAgc3RhdGljIHZvaWQgc211X2Ntbl9yZWFkX2FyZyhzdHJ1
Y3Qgc211X2NvbnRleHQgKnNtdSwNCiBpbnQgc211X2Ntbl93YWl0X2Zvcl9yZXNwb25zZShzdHJ1
Y3Qgc211X2NvbnRleHQgKnNtdSkNCiB7DQogICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiA9IHNtdS0+YWRldjsNCi0gICAgICAgdWludDMyX3QgY3VyX3ZhbHVlLCBpLCB0aW1lb3V0
ID0gYWRldi0+dXNlY190aW1lb3V0ICogMTA7DQorICAgICAgIHVpbnQzMl90IGN1cl92YWx1ZSwg
aSwgdGltZW91dCA9IGFkZXYtPnVzZWNfdGltZW91dCAqIDIwOw0KDQogICAgICAgICBmb3IgKGkg
PSAwOyBpIDwgdGltZW91dDsgaSsrKSB7DQogICAgICAgICAgICAgICAgIGN1cl92YWx1ZSA9IFJS
RUczMl9TT0MxNShNUDEsIDAsIG1tTVAxX1NNTl9DMlBNU0dfOTApOw0KLS0NCjIuMjUuMQ0KDQo=

--_000_MN2PR12MB4488AC669777EF0CAEC82839F7749MN2PR12MB4488namp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgc3R5bGU9
ImRpc3BsYXk6bm9uZTsiPiBQIHttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO30gPC9zdHls
ZT4NCjwvaGVhZD4NCjxib2R5IGRpcj0ibHRyIj4NCjxwIHN0eWxlPSJmb250LWZhbWlseTpBcmlh
bDtmb250LXNpemU6MTFwdDtjb2xvcjojMDA3OEQ3O21hcmdpbjo1cHQ7IiBhbGlnbj0iTGVmdCI+
DQpbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldPGJy
Pg0KPC9wPg0KPGJyPg0KPGRpdj4NCjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBDYWxpYnJpLCBB
cmlhbCwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9yOiByZ2Io
MCwgMCwgMCk7Ij4NCllvdSB3cm90ZSB0aGUgcGF0Y2gsIGl0IHNob3VsZCBiZSBzaWduZWQtb2Zm
LWJ5IHlvdSwgbm90IG1lIDxzcGFuIGlkPSLwn5mCIj7wn5mCPC9zcGFuPiZuYnNwOyBFLmcuLDwv
ZGl2Pg0KPGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IENhbGlicmksIEFyaWFsLCBIZWx2ZXRpY2Es
IHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPg0KPGJy
Pg0KPC9kaXY+DQo8ZGl2IHN0eWxlPSJmb250LWZhbWlseTogQ2FsaWJyaSwgQXJpYWwsIEhlbHZl
dGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+
DQpTaWduZWQtb2ZmLWJ5OiBDaGFybGVzIFN1biAmbHQ7Y2hhcmxlcy5zdW5AYW1kLmNvbSZndDs8
YnI+DQo8L2Rpdj4NCjxkaXYgaWQ9ImFwcGVuZG9uc2VuZCI+PC9kaXY+DQo8aHIgc3R5bGU9ImRp
c3BsYXk6aW5saW5lLWJsb2NrO3dpZHRoOjk4JSIgdGFiaW5kZXg9Ii0xIj4NCjxkaXYgaWQ9ImRp
dlJwbHlGd2RNc2ciIGRpcj0ibHRyIj48Zm9udCBmYWNlPSJDYWxpYnJpLCBzYW5zLXNlcmlmIiBz
dHlsZT0iZm9udC1zaXplOjExcHQiIGNvbG9yPSIjMDAwMDAwIj48Yj5Gcm9tOjwvYj4gU3VuLCBD
aGFybGVzICZsdDtDaGFybGVzLlN1bkBhbWQuY29tJmd0Ozxicj4NCjxiPlNlbnQ6PC9iPiBXZWRu
ZXNkYXksIEFwcmlsIDcsIDIwMjEgMTE6MzIgUE08YnI+DQo8Yj5Ubzo8L2I+IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnICZsdDthbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyZndDs8
YnI+DQo8Yj5DYzo8L2I+IERldWNoZXIsIEFsZXhhbmRlciAmbHQ7QWxleGFuZGVyLkRldWNoZXJA
YW1kLmNvbSZndDs7IExpdSwgWmhhbiAmbHQ7Wmhhbi5MaXVAYW1kLmNvbSZndDs7IFN1LCBKaW56
aG91IChKb2UpICZsdDtKaW56aG91LlN1QGFtZC5jb20mZ3Q7OyBTdW4sIENoYXJsZXMgJmx0O0No
YXJsZXMuU3VuQGFtZC5jb20mZ3Q7OyBEZXVjaGVyLCBBbGV4YW5kZXIgJmx0O0FsZXhhbmRlci5E
ZXVjaGVyQGFtZC5jb20mZ3Q7PGJyPg0KPGI+U3ViamVjdDo8L2I+IFswMDAxLWluY3JlYXNlLXRp
bWUtb3V0LTJzLXNlbmQtbXNnLXRvLXNtdS5wYXRjaF0gZHJtL2FtZC9wbTogaW5jcmVhc2UgdGlt
ZSBvdXQgdmFsdWUgd2hlbiBzZW5kaW5nIG1zZyB0byBTTVU8L2ZvbnQ+DQo8ZGl2PiZuYnNwOzwv
ZGl2Pg0KPC9kaXY+DQo8ZGl2IGNsYXNzPSJCb2R5RnJhZ21lbnQiPjxmb250IHNpemU9IjIiPjxz
cGFuIHN0eWxlPSJmb250LXNpemU6MTFwdDsiPg0KPGRpdiBjbGFzcz0iUGxhaW5UZXh0Ij53aGVu
IGRvIFMzIHN0cmVzcywgbG93IHJhdGUgdGhhdCBQb3dlclVwVmNuIG1lc3NhZ2Ugd2lsbCBnZXQg
cmVzcG9uc2U8YnI+DQptb3JlIHRoYW4gMXMsIHNvIGhlcmUgaW5jcmVhc2UgdGhlIHRpbWVvdXQg
dG8gMnM8YnI+DQo8YnI+DQpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgJmx0O2FsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20mZ3Q7PGJyPg0KLS0tPGJyPg0KJm5ic3A7ZHJpdmVycy9ncHUvZHJt
L2FtZC9wbS9zd3NtdS9zbXVfY21uLmMgfCAyICstPGJyPg0KJm5ic3A7MSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pPGJyPg0KPGJyPg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211X2Ntbi5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9zd3NtdS9zbXVfY21uLmM8YnI+DQppbmRleCBiNzI1ZjI2MzA5MmIuLmRjN2QyZTcxYWE2
ZiAxMDA2NDQ8YnI+DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdV9jbW4u
Yzxicj4NCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211X2Ntbi5jPGJyPg0K
QEAgLTc5LDcgKzc5LDcgQEAgc3RhdGljIHZvaWQgc211X2Ntbl9yZWFkX2FyZyhzdHJ1Y3Qgc211
X2NvbnRleHQgKnNtdSw8YnI+DQombmJzcDtpbnQgc211X2Ntbl93YWl0X2Zvcl9yZXNwb25zZShz
dHJ1Y3Qgc211X2NvbnRleHQgKnNtdSk8YnI+DQombmJzcDt7PGJyPg0KJm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2ID0gc211LSZndDthZGV2Ozxicj4NCi0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgdWludDMyX3QgY3VyX3ZhbHVlLCBpLCB0aW1lb3V0ID0gYWRldi0mZ3Q7dXNlY190aW1l
b3V0ICogMTA7PGJyPg0KKyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB1aW50
MzJfdCBjdXJfdmFsdWUsIGksIHRpbWVvdXQgPSBhZGV2LSZndDt1c2VjX3RpbWVvdXQgKiAyMDs8
YnI+DQombmJzcDs8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsgZm9yIChpID0gMDsgaSAmbHQ7IHRpbWVvdXQ7IGkrKykgezxicj4NCiZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBjdXJfdmFsdWUgPSBSUkVHMzJfU09DMTUo
TVAxLCAwLCBtbU1QMV9TTU5fQzJQTVNHXzkwKTs8YnI+DQotLSA8YnI+DQoyLjI1LjE8YnI+DQo8
YnI+DQo8L2Rpdj4NCjwvc3Bhbj48L2ZvbnQ+PC9kaXY+DQo8L2Rpdj4NCjwvYm9keT4NCjwvaHRt
bD4NCg==

--_000_MN2PR12MB4488AC669777EF0CAEC82839F7749MN2PR12MB4488namp_--

--===============0918977714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0918977714==--
