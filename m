Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89985EC01B6
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 09:44:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2542610E3F5;
	Mon, 23 Mar 2026 09:44:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zMtmvyOL";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013056.outbound.protection.outlook.com
 [40.93.196.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1337910E3F5
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 09:44:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkVgYwB7vDRgCG8lKHTZFqwwSgA5v6gGWKvDWPxTnzk+423Oc+0WJXQEhfvUAddHr3xMnzM3hP2f1TiZWg13acNdWZwbQxapIXvWDUyC6/iVVLJ1pjLl9zacz8SAZnFoyeKavB899qnbO9mExM1Jl8+U4X1iZAkFiJukS0Xt5/yrAHw+fYtyQSeBDVcjBYDrKXxlP+DEcqxGr4CRe3FeCvyzHIRZA2cdRucScNX1aVvSATjv+ECoLDU2YEkB8QsxdyQoK/SSsBNJJfu3CcwRO9Vz3vLJN5yp6iaupl6u6hpxb+LIrpxkx0HytWvPTxsJdLNeZVm+NzV/ZWb1IGvYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=op4DIJhml6pbkH2v/4dxfYhXmvuafbIpwyZb2Tevffw=;
 b=KxQdwBHNfc8b1FGFaTDJp+tbONAaFZwLKABYNoorFruPzciN7bddYj93fefoj1N65+Ro/DDi+IrwXbUjliPaWJ0CuN6wF2odw24NWpTfS1BQzvlRTlcSHSQ8J6BcILEHBeRD2KXd2eS669lMmp/C5HLj/1rIL+mduxESruoaPFSdS+lAZK2/NQWB9D9ALbc5t2nbxSZAzuaGZRTNvJya1bQnor8XTK4LgPiY3DNYNPPYAxvkJgBsQAF5KsVn3Y6Ovu7zQxDM++6EP6MrPUiVadysnTBA/B2AsnJXaoPCQG1E05T9QCtaEXPlIriIyuD2yLjj0B4tW1vgm0C/cXaF8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=op4DIJhml6pbkH2v/4dxfYhXmvuafbIpwyZb2Tevffw=;
 b=zMtmvyOLTcJ3ElJQ3UwTJsBclvKCZkZFCXVMowUAJfRL8EJbXxYDJAxeM5gftB/ZqbqFgnu35Y7eff7lL6ioFvVwvbFOee41wzAvZtJ3bKofgwjxU086xoZRZdwwXWnC8fvJWT8kTQIVKEB4JK5PEZWw86NeiqMQJjdANNLlhu0=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by SA1PR12MB8119.namprd12.prod.outlook.com (2603:10b6:806:337::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 09:44:45 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%2]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 09:44:45 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/userq: fix the old userq fence dereference
Thread-Topic: [PATCH] drm/amdgpu/userq: fix the old userq fence dereference
Thread-Index: AQHcuEVpvSife0n75kOa77VSU8eTMLW3K8mAgASw0/A=
Date: Mon, 23 Mar 2026 09:44:45 +0000
Message-ID: <PH7PR12MB6000613B66D410B2B58350E4FB4BA@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260320084140.3329888-1-Prike.Liang@amd.com>
 <a4e7335b-1488-4d06-b1c9-329e5bbdd889@amd.com>
In-Reply-To: <a4e7335b-1488-4d06-b1c9-329e5bbdd889@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-23T09:22:36.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|SA1PR12MB8119:EE_
x-ms-office365-filtering-correlation-id: 3d07ff3b-a8dc-45eb-e188-08de88c0d0dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: YAQOp0NJ0mOCyQyMhxEvgNADVbnLGd+NCBHwjCiFaKl7AcVpXIE6RO89jt3ONTkxEeeQfGKH6oaT0kin9u5G4tk6V/YNIWNsjqHLsJ49+7MalDOHtcAJUdzbseQqF28WHgQNTOcBztbtX30IRl/DPNpg6vrPiOnFGGfr+W6KzIMDkvdsRhgjSWtd5iuU0050QH9VhtRLEkWqljRE4D88q361CH7Kal86Tp2SE5FK8c8MAWf0UNLl39K8auJh4j0PukKKDn4LnaDSv7z92sqrokbOzs4blfj4Ge5M7pUvGxA0lUg4dA6CuC4mL+nZuV3G1JbUBHmMk7Bov7vhx2oP9zyxofXfXoMJUyoy5LTKPO8d/kHg4qZ/9lVe9yOHapRDbLpyTJsDjN7TFnkxqGR6prTyYdor0hZrRp62FjyBSXKElQLhJC9YLM0fIQ7AlnwVdsrYSMrqu6jyXwzoCpneslAfEUOGmU1i8/pB+U6Bb/q8t+0smCyLivh42TRq3EhnevK5+1uD26Hd48ELbMf0xj9vQB/U5kQ8ucWCd0GnrP+7ASUVyLJUZi+qdbTT76LTaLjlAvIZugzNN8GqaOmcHEvRKrgOAB/JQZrV2Y7iXKlR571owC0JffWkaSKQ6cFKSQqou1aNSQMKexPKK7z8CaSjGT4vmeeFgWSX1+dIa1YbQQmNPRrlJS2i6opAmTuzGpCemu+7h+gi7TzbEhGBfhv362CZNX+lhTPavZan5PSZnBUIXqG8sjYAKIXVHrD9YsHx9G0F6acbXj2eoONYulpYXnZEynA5fm267+OC+bw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzllQVU2VytWdTN0WXBLTUZjbklkUEVNcEUrbyswcnpsSHhJVGVoVUEycUZ3?=
 =?utf-8?B?L2Jpak1kV2gzaXlWQk9lWWtZZWxDRGEvTStQNWVJME9sVnlTTU9XMTFBOTJJ?=
 =?utf-8?B?OEIwYzI1emxycittd1VZSW5VY1ZCM3NobmtwenphK2g5NUV0SUhudDlBVko4?=
 =?utf-8?B?K1ZXZHF1VDJEdVVHVFR5dWZCOUhtS2w3MnBsNU5GNmxmNGo3V1hXdWZYdU5L?=
 =?utf-8?B?TVNXbmxlcUJxblNkemdEaWNUOFV3NDJzYmIvbmJxTjdpakROK1duUjVTdmhs?=
 =?utf-8?B?SzNBczBsbHdDWUdGU2lWSHQ5QXBpVmxzVE1NTTBBdVN4K0kwSXZlVUprL0t2?=
 =?utf-8?B?SURCLzBNR1I3SXkvc3ovWGJjQTBIb3UyNHkvVTBEREpTeldFdXUweXZrdW9K?=
 =?utf-8?B?aDlDVnVMMW1FQUtjWTU3MWNCSmUvcmE4d1VrWU5RRTBZMlZTcEJubVVSSVQw?=
 =?utf-8?B?ZWIxcHdRTkNPZVhRd00wakNtNzdiYVgyUjFRd0JXc08wZTdTN1ZkOWNQUVE5?=
 =?utf-8?B?WFoyVlRkR3NVWk53d3Bjb3hpdzBUYUQreDRncThmaEZscmR5QXM0YTR0Y1FQ?=
 =?utf-8?B?QU9YN2lNQzNQR2k5Z0J5TGt2OFNDUEUrNTBlOGpxNHkrdlkwTVdKcFRzWnZw?=
 =?utf-8?B?Kzd1eGdBTFVBMzlnRkxqUUczeG1samg0UlhuWVkzamRYSnF2Mlo2Q1U0K0hF?=
 =?utf-8?B?ZE9xVUxiQVJHaURaL01PVWR4TzQwTDZwcGwyL0wvdU1pd0JnOG5uNVNOL0pK?=
 =?utf-8?B?L3ZpOW9CVVk0TE4zVmE1TWRXK3UrYVREdnpBS1U2b2F4ZjNUaTBja0dJT1FX?=
 =?utf-8?B?bitrdG5QRWZVWTFFK3NWSEx2MUYzRTU0Uk9jeEtzNVVkQmNaVkRDUC9OcGYr?=
 =?utf-8?B?T043dk1wWVVodVh6RjdjcCtNeUk3K0Jtb083MHRvWFBEbHQ4QXBqQ0plMDMx?=
 =?utf-8?B?MnpFTjZoVFZOZjBhS2VVOHhkNGJSWlZLTnRwRFdNeG9uTk5jY0ZDTXdpb1Q0?=
 =?utf-8?B?RXh5clFKU2diRUxXZVhKS00zL2FtSEJ5STdxaXNUU3h1Q2NIVEN6cE5aa0RC?=
 =?utf-8?B?MnJIYkZ6blNqN1hxb1ZBVDR3RHRJdFg4K09JY2RaZVk4Vi9FNk4xaWxmdzYx?=
 =?utf-8?B?UlNCMWpoUUdBc3lMT1JybnNOSjZpSG1yS3BWUFpyK2JScWwySUxuRHNYa0Vy?=
 =?utf-8?B?Y3EvNElXUDNtSHVwV2MvS1ZyWVN3NkhnWlluV25hYUg4Q3pEMW5RYmxUdENC?=
 =?utf-8?B?dUlOUmxNYlpGcWVtSGVKemFndHpwaVE1bUZiUW1rQmRWa3p1RmtkV0JXZWNz?=
 =?utf-8?B?dSt3bDlwdEVyeEtJM3RoK1ZBdW1kUlpiWUgxVUhLdDFIT1l3M0k4WTNRZjFh?=
 =?utf-8?B?Ri9DcnpuV1BwWWhFZzlma3p3cngzMWJDR08rQlFBT1ZxNEhNdVh3NmptcndS?=
 =?utf-8?B?MEl2ZGpnb1hJTUd6bndtemtoTVVSSVM0SjZEQkdHeFpwVC8wZVZSdjc5L0xI?=
 =?utf-8?B?ZWVGaXliVnMvL3p3UzdOeWdHYm4xeHhXWmljU0J3UzRRT0NtUmlLZFROVEV6?=
 =?utf-8?B?RnBTWlg5YnRURE81ZHFnWWVlSzZHbytNOGxwaEx0UlBNYmdQdEYrNFY3T1py?=
 =?utf-8?B?Zk13aHdWUDhINkJHWVRTdDFWNURUV0xaMll2UWNKWEZrQ3FPYUo3ODBWOWU1?=
 =?utf-8?B?enlPaDlUQkZ5aW1sSDU1Y25uYzhqMGJod0NEVlRWT01jRHFrNEhTeVhPOGht?=
 =?utf-8?B?clJSKzQwQ2tIclFKSUlxRnRYK3dlanNIdWI0bmZ2WStiUVpTTVJMYmVrQ1l2?=
 =?utf-8?B?NTJVU0F1OUJlWXRIc29GSVAvN3RLRFJvZGY2Y3QzUkdNcXFQWjVaSkdrelJ5?=
 =?utf-8?B?MFpGM2p6aUFUeHBOdlkyKzcrTkMySW5hVWpXTnZpblBPZ1hpdVJsM1RUVVF1?=
 =?utf-8?B?VG9FSkdIWFVWazE2czZVQnVjaXRIaktaZ2hnU3dOVnVTQStCcitiY2pHK0Iz?=
 =?utf-8?B?ZVVlZ1U1em5BUnlxbzlUaVhyYy9FQXlrWFRLZ0M4RW5peHVTZDJ6UnBJaWht?=
 =?utf-8?B?aTNFZW9uMk03OXoyTEg4aUV5d1djTTV5VEpXeXF4ZXpxc0k0VUQrdHArd0sr?=
 =?utf-8?B?QytIY2c4MUNJclVtbTFydUZFY1dsZ2dVOWZpUzhFc292bklXZTFkaHcyRDd0?=
 =?utf-8?B?cmZTOEZyZ3lJRTJ0Tmg4VTV2dUVhYWtySGZ3SnJIYnZNNm9jUktuWElJZ0ND?=
 =?utf-8?B?dmZleGYrR0ZEV3BySEdSc3lIb0tiY1lGbzJkYmUrUEdTUjhyQXlvMHZicHpy?=
 =?utf-8?Q?UsSvcGjcuAcwfvPSGP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d07ff3b-a8dc-45eb-e188-08de88c0d0dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 09:44:45.2039 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /lWoJ1jQ6IoIeYqu+hVJiQO4FriZ1OyqiToIZw5dhx8dcmcvV3cntKve4xgVZ1V7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8119
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

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT4NCj4gU2VudDogRnJpZGF5LCBNYXJjaCAyMCwgMjAyNiA1OjQ1IFBNDQo+IFRvOiBMaWFu
ZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1L3VzZXJxOiBmaXggdGhlIG9sZCB1
c2VycSBmZW5jZSBkZXJlZmVyZW5jZQ0KPg0KPg0KPg0KPiBPbiAzLzIwLzI2IDA5OjQxLCBQcmlr
ZSBMaWFuZyB3cm90ZToNCj4gPiBJdCBuZWVkcyB0byBkcm9wIHRoZSBvbGQgdXNlcnEgZmVuY2Ug
ZGVyZWZlcmVuY2UsIG90aGVyd2lzZSBpdCBjYW4ndA0KPiA+IGJlIHdhbGtlZCBkdXJpbmcgZnJl
ZWluZyB0aGUgcXVldWUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQcmlrZSBMaWFuZyA8UHJp
a2UuTGlhbmdAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3VzZXJxX2ZlbmNlLmMgfCAxNiArKysrKysrKysrKysrKy0tDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycV9mZW5jZS5j
DQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnFfZmVuY2UuYw0K
PiA+IGluZGV4IDlkZjYyZjcxZjI3Yy4uZjFhY2Q3ODVjMjdkIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycV9mZW5jZS5jDQo+ID4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxX2ZlbmNlLmMNCj4gPiBAQCAt
MTA1LDkgKzEwNSwyMSBAQCBpbnQgYW1kZ3B1X3VzZXJxX2ZlbmNlX2RyaXZlcl9hbGxvYyhzdHJ1
Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiAgICAgZ2V0X3Rhc2tfY29tbShmZW5jZV9k
cnYtPnRpbWVsaW5lX25hbWUsIGN1cnJlbnQpOw0KPiA+DQo+ID4gICAgIHhhX2xvY2tfaXJxc2F2
ZSgmYWRldi0+dXNlcnFfeGEsIGZsYWdzKTsNCj4gPiAtICAgciA9IHhhX2VycihfX3hhX3N0b3Jl
KCZhZGV2LT51c2VycV94YSwgdXNlcnEtPmRvb3JiZWxsX2luZGV4LA0KPiA+IC0gICAgICAgICAg
ICAgICAgICAgICAgICAgZmVuY2VfZHJ2LCBHRlBfS0VSTkVMKSk7DQo+ID4gKyAgIHN0cnVjdCBh
bWRncHVfdXNlcnFfZmVuY2VfZHJpdmVyICpvbGQ7DQo+ID4gKw0KPiA+ICsgICBvbGQgPSBfX3hh
X3N0b3JlKCZhZGV2LT51c2VycV94YSwgdXNlcnEtPmRvb3JiZWxsX2luZGV4LA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgZmVuY2VfZHJ2LCBHRlBfS0VSTkVMKTsNCj4gPiAgICAgeGFf
dW5sb2NrX2lycXJlc3RvcmUoJmFkZXYtPnVzZXJxX3hhLCBmbGFncyk7DQo+ID4gKw0KPiA+ICsg
ICBpZiAoeGFfaXNfZXJyKG9sZCkpIHsNCj4gPiArICAgICAgICAgICByID0geGFfZXJyKG9sZCk7
DQo+ID4gKyAgIH0gZWxzZSBpZiAob2xkKSB7DQo+ID4gKyAgICAgICAgICAgLyogRG9vcmJlbGwg
aW5kZXggd2FzIHJldXNlZDogZHJvcCB0aGUgcmVwbGFjZWQgZHJpdmVyJ3MgcmVmICovDQo+ID4g
KyAgICAgICAgICAgYW1kZ3B1X3VzZXJxX2ZlbmNlX2RyaXZlcl9wdXQob2xkKTsNCj4NCj4gV2hh
dD8gV2h5IGlzIGEgZG9vcmJlbGwgaW5kZXggcmUtdXNlZCB3aGlsZSB0aGVyZSBpcyBzdGlsbCBh
biB1c2VycSBmZW5jZSBkcml2ZXIgZm9yIGl0DQo+IGFyb3VuZD8NCkFzIHRvIHRoZSBjdXJyZW50
IHVzZXJxIGRvb3JiZWxsIGluZGV4IGNhbGN1bGF0aW9uIHRoZXJlIHNvbWV0aW1lcyBjYW4gaGF2
ZSBhIHNhbWUgZG9vcmJlbGwgaW5kZXggZm9yIHRoZSB0d28gZGlmZmVyZW50IHVzZXJxIGR1cmlu
ZyBlYWNoIHF1ZXVlIGNyZWF0aW9uIHByb2Nlc3MuIFRoZXJlIG1heSBuZWVkIHRvIGhhbmRsZSB0
aGUgb2xkIGZlbmNlIHdoaWNoIGhhc24ndCBiZWVuIHNpZ25hbGVkIHdoZW4gYSBuZXcgZmVuY2Ug
c3RvcmVkIGF0IHRoZSBzYW1lIGRvb3JiZWxsIGluZGV4Lg0KDQo+IFRoYXQgZG9lc24ndCBtYWtl
IHRvIG11Y2ggc2Vuc2UuDQo+DQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4NCj4NCj4gPiArICAg
ICAgICAgICByID0gMDsNCj4gPiArICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICByID0gMDsN
Cj4gPiArICAgfQ0KPiA+ICAgICBpZiAocikNCj4gPiAgICAgICAgICAgICBnb3RvIGZyZWVfc2Vx
NjQ7DQo+ID4NCg0K
