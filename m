Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE30105F7AE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 14:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFE9A10EC6A;
	Fri, 13 Mar 2026 14:28:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LokghPq7";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A1BC10EC6A
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 14:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YP9HiWO5ICPPh1LJyXM7HimixX791i8Meb26FBM3izknFy/9s/VU/DBT9vY+82nxlA4k0SisA0xR3cp7kI7/507/TiFgRqVby/Yg8/YHDZtNavUCEUh1yjN5welsQQ+LpmyWzbDk7BjreBXKSjexn2ThT0jVnE5xdrNMLp8k/xnz6AFG1eL2znENGjYBMBYhMbRIFOh2FE4OPXTKy18mMNtoaKbYcXV+LERI6EOzRA5RDChH1ahOA79EFg6skuUfSnA/tpJXP02WuQ1qhvj9RByJqft7VicpcDzQSe+24g640upcpoUKlMOwN2iIh5h7hogG2cwghC7qwFAPrc7A4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bf4LTvUM95rxYMz87xKIAKr3GM2AFOfwD7O5/+gEc3g=;
 b=bVgGe/8g9q1KKUXqEvjJXudVOYj9wpPZ+dGztMvNzToSLhz56n8VruPy5jt+k65NI3/EU/TeWKe6v7TTQqSV+KUVeVmUSrLr1sC/UjtwRsADu5Jm6tRMaGboh6fwkqo5ACv7j6+k82dYgK43Ae2lVUWAtfM/5iOYM8cRePZJNfO4vFWKWEII5ZgaIVMUYBKqyfszM5PhWFwSpI1B3Pl4q9F+xocllYfiCpoioB/HT0E8HtMkFrEnLpkdctnqqV27QLcrhJLxLc7Kp80aMvEp/iw+c+LlzGHem8iTWWkVwCwB84Jk3OKJaq6SVOh7YD7LzLp+YMYSRBjVQSN3o5o8rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bf4LTvUM95rxYMz87xKIAKr3GM2AFOfwD7O5/+gEc3g=;
 b=LokghPq7V21rCc9mBniIPY5WRiqsLGh/sP5dhX3AP2ZzYm2MzzWgyS4FOhqucsXCwddX0PX2K76Xt6ZkjGuC5wzSS9v+Nuv+vfuA8wOytGxhU6BUo9SVpxAE5F8BNp27IFGKkYa6m3uuDj7XeGLKXZNkAS6b3ZNLM6yzWsReIkQ=
Received: from SA0PR12MB7462.namprd12.prod.outlook.com (2603:10b6:806:24b::5)
 by MW4PR12MB7213.namprd12.prod.outlook.com (2603:10b6:303:22a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Fri, 13 Mar
 2026 14:28:50 +0000
Received: from SA0PR12MB7462.namprd12.prod.outlook.com
 ([fe80::dccd:b6c:87ab:8b5f]) by SA0PR12MB7462.namprd12.prod.outlook.com
 ([fe80::dccd:b6c:87ab:8b5f%6]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 14:28:50 +0000
From: "Pan, Ellen" <Yunru.Pan@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Dan
 Carpenter <dan.carpenter@linaro.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Remove dead negative offset check in
 amdgpu_virt_init_critical_region()
Thread-Topic: [PATCH] drm/amdgpu: Remove dead negative offset check in
 amdgpu_virt_init_critical_region()
Thread-Index: AQHcsiOrvlrzTQoY8U+g3BlornGcCbWshvZQ
Date: Fri, 13 Mar 2026 14:28:50 +0000
Message-ID: <SA0PR12MB7462B909C38FD973C870125FE945A@SA0PR12MB7462.namprd12.prod.outlook.com>
References: <20260312132456.1839323-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260312132456.1839323-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-13T14:28:11.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR12MB7462:EE_|MW4PR12MB7213:EE_
x-ms-office365-filtering-correlation-id: 2245dd05-24b0-46f8-a41b-08de810cd84a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 4EUXgGoFbvOPnvsj1xZcuZRNutnuUCnRJudvtohR0qikJyVCfnDi/8GJzijumFYIKnTqHFkH9kHis4HtwKgske09w+Sux9kz0c5QmPEYa6U2UltUXcoEGjD/EXGo+2oSyAZjQv7jLUseolS13SkosIyuy9Pui8ZtVK6mqRVZNVK71Kb5VxdTrU/OreG+nuhBOxl5bgEAP5hal/U19xxd+rLhGE9E1dv6cpLAkHHCXH2puIiFLF7pT/E9TOFn6scoaZR5q+r+5eQLCxj0n9az49qp95dly+QUNVrE8WtBHofUdSsGPPzfTFzy13aLQ4ZWVCTyKjxH3CgGwqMSX9t5GOR9uu/AlsX+bf0KEFCqdDWTQkzC3RcpweNMtyLRjxKZ/JXgpIuLea6ij7JcoVfWATAQRBLPucH9aPOnPgvS9NUraG8atp+V27Y26APoDEMiRhp5+I7ovoSxoRwJrBi+BGZUQkYaJrFWcipxFXZICibdaKHIGT0ZIS4zTRDG8gkAz/Y2uXG5JrXG6hpT0+hDE6DYAHcSwH7ngXWCEJEXRAlcG1pF8NGDQQD5mnCVEu4h+zwqEPy/RMKqgJARgrJze/XeJUj1qvaVfUt84Zcozpvz8s3DnkiBBoVcGZ5OspN21+KiIc3qLKOV+TAI6tSmBRO39Wqfl+Ly7J208BfpFZ9l2Yhamx4eZTJL2HBiYLndsUpzQFq9RX9ejTlN112Yft5p0A+yGrLtkWoypgCbd0CO9HIPrTqIoZHmWc/yFAzF1K4Cduk4ka23nMs4iOxndIemWCzcGuES9FGQttTYBFA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7462.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzZ5Vlhzb2JBT0dFSnRwcDF2QmlPT29IYkVaTytzN2xNTmFaK1pIc0JiMWty?=
 =?utf-8?B?NTAyYU1mQ2FNN0Nhd0EzVDJ6YTdNZlowREg3dmVNZTBaRjdxcG1DdmdwUlQ0?=
 =?utf-8?B?V3JTZXplM0d5R1VKWDdicjJlMVZodHY0UFJtQlh1YXdQdU1hT3FoT3pmN0Vo?=
 =?utf-8?B?Q0RoUlQ5V0xUT3VVU3pvSmY5Z0R4ZVpZdzhvVEFqMVp4bmN1T1BYNVZBWVll?=
 =?utf-8?B?cUN5R2ozQUZDUFJoYzZoU2l5a1RwTDk5T2tsRnpvSmRicmhycmZZU1JhVEVO?=
 =?utf-8?B?NEJtWmw2NjhCZjQwc1RMOTY5Q1lzdHVwSzJjK2tQREJvWENKblpNaHlKeU1Y?=
 =?utf-8?B?OWFtbVJ2Z1J2SXJnUHp6RzhFaFNuZ1BDMzcrRUtEQTlaU0xhR2Q3WC9WN3hM?=
 =?utf-8?B?WU1yVFBMazRPNlBnTEJwMzVxaVJsSXJidisvYlhESVRidWlnMFVWRG9aclhs?=
 =?utf-8?B?b2Z4dk9kMEY2di9BZUJITlh6cjV0YXl1UTErb1F0VkVMZUI0aE5idUNrdTF1?=
 =?utf-8?B?UUVSeWxvTWx6VWlDKzI4K2JEM2tiTEl5Qi9FUS94ZDlsRS94UEo5N2VXT3VU?=
 =?utf-8?B?UDRZZjZEN01ibGprbHdCWE0yOEVvQ0Y5b1IvVU01a1VOVWRIMjBpR3hMYkJW?=
 =?utf-8?B?dkwram9zemo5NW8rU01FcExKTGY4Ym9QWDdTNStyaE95NXZtdkRhUm4zeDU1?=
 =?utf-8?B?cnlEcTBwdXBOMFJ6OVJERTQyTWdEY1ZqZmlPenZmUXZ5VWR6Y3J5d1RZQnAz?=
 =?utf-8?B?K09wNSs5NnRVUHVHSUpTWW5IL3l0NGdjOGVxYlo4UW1LSlUrZFplOGFvVVF5?=
 =?utf-8?B?SEw0Q29QVnk1TDBBTVptTHVVN0liSzZVRGhIaW5jeWo2aUFMMFNvQjRxNEgv?=
 =?utf-8?B?eEJ4STdNR0JoUHRveGk0Y3l3NmtXYitUdmpzMWpuTjZFUDhiZlp3bGxOUUc2?=
 =?utf-8?B?WnNOTGl1UmlKRWgvQjJWM1ZzcGtPNEhvanVseExsaCsreXJ3OGdtTW95b2ZB?=
 =?utf-8?B?bXNlMzdxQjF4RDB2REUzemhqN0svUCthYkFzdkpjd1gyb1J4eWE5ZTArM0Nn?=
 =?utf-8?B?ZzJ1Q0VPVzNQVWlHWUs3cTJnZWNmNHhBR2FoSi9UOUJ3eUJ2NE9FSUx6cnM0?=
 =?utf-8?B?Nk9kRG9xRXJ5dHRybVc1OHQ0Q2pQU3ROd2ExSWV0Tm52cGpHYmR5Rmp4QmhX?=
 =?utf-8?B?TDg4UmRCZHNBWTV0UkxSQUc4WW9XWVY1UVZKdVdSYzE3NHZkc1JXMEQ1QmVk?=
 =?utf-8?B?NlZDL2hLNmFkZ1cwdjN3RkcrZE40OE1PR2MxMWpqVVVxU3dIR2pTbzA5K2p6?=
 =?utf-8?B?SGtZWTRvc3p2M1hVQXczdkQ5a0xEY1dXbjM4RjVyOVEzRjdqb1Z2RytRdjRJ?=
 =?utf-8?B?d3FIa0VmTHp4L2o3VFBpYnkyR3I5RmlZSEdmZDlOejl4T0Z5UkpJRFZKcnE1?=
 =?utf-8?B?RjRrSzZFUjZsWTNOQ3N4NE5URVM3K0hoRlVZeDNHVnZmVmJBRTIvWFpKSHNO?=
 =?utf-8?B?UGpzWndWRk9LVWNSMTlNS3NVTlcyM09kMnV6MHhlQ2hxS0pCY2hPK2VhYksy?=
 =?utf-8?B?S096TG1rcm5uL1ZjL3FRRTNDRlh2a1VudU9TYXpZbHR4YWJCRXQwbEg4ME9l?=
 =?utf-8?B?WmpIUlJ1aE1VbFNLT1NUK28rS2JOa0tmM1R2UDlWMVF4N1JFb1BzL1h1UnV4?=
 =?utf-8?B?T2F3MHQ3NVlGODdXNzQ2NDZ1WVVicHQ4eDlYV24ycmNrdkZ6d0Z4aTlyV04y?=
 =?utf-8?B?a3BCLzlwMXJNNjdpOUY5OWtiaTJUdG5oZ0lOQTBCeWkyeVdsUWpoakg3alBk?=
 =?utf-8?B?TEFYQTE1bHJxYkVEelQyMFEzWnRlSXZ6QlRGK3ZFanViUGYrakNqUWJFTW8z?=
 =?utf-8?B?SDhnRUxFaGtVaXMxemV5RGZNQnk5VlM2eHJaTU5HWlp2eGc1bUJibDN1SVl6?=
 =?utf-8?B?U0VCT2dVVWorZFlHS2I5N1YydUVFRTB4N1QwR3V0aVhKa1ZZWU1lS3pRY1h6?=
 =?utf-8?B?L01HTit0SklGOHJoTENBRVV1UG9YYUd0aVpobUR6THZ2c0VORERtNEc5eTNi?=
 =?utf-8?B?QktpL21oMjRlazk0WWJmSk1rc0xLekY1RUlOQ0FqQnRvVG1lQjNaUmZhRk94?=
 =?utf-8?B?ZEJPdlhhSi9CVVlwWktUZm1WcEVxVHl1dXRubC9XUGVrTjg5d24vZHJtZjkx?=
 =?utf-8?B?YkZtb3RWWStITGMvQ0xBM0h3b3MvdGY0aXFkbXQvY2Fkc1dTV1RFcHFTWHh5?=
 =?utf-8?B?L056cVlJV0I0V0loVVdHbm1pdTRMdlhPUzNGb00xNFlTZ1Q3VENiZmJyZVI1?=
 =?utf-8?Q?NezhPXhC2MR+uVAEjp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2245dd05-24b0-46f8-a41b-08de810cd84a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 14:28:50.1252 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iQ3xtAnok0D16mm9d0L8XUlkUYDdcJ3xRRZ/RrsCovTw5ZM9zohyQju9JOggvAE5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7213
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KUmV2aWV3ZWQtYnk6ICBFbGxlbiBQYW4gPHl1bnJ1LnBhbkBhbWQuY29tPg0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklOSVZB
U0FOLlNIQU5NVUdBTUBhbWQuY29tPg0KU2VudDogVGh1cnNkYXksIE1hcmNoIDEyLCAyMDI2IDk6
MjUgQU0NClRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsg
RGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KQ2M6IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFT
QU4uU0hBTk1VR0FNQGFtZC5jb20+OyBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQGxpbmFy
by5vcmc+OyBQYW4sIEVsbGVuIDxZdW5ydS5QYW5AYW1kLmNvbT47IExhemFyLCBMaWpvIDxMaWpv
LkxhemFyQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IFJlbW92ZSBkZWFk
IG5lZ2F0aXZlIG9mZnNldCBjaGVjayBpbiBhbWRncHVfdmlydF9pbml0X2NyaXRpY2FsX3JlZ2lv
bigpDQoNCmFtZGdwdV92aXJ0X2luaXRfY3JpdGljYWxfcmVnaW9uKCkgc3RvcmVzIGluaXRfaGRy
X29mZnNldCBhcyB1NjQuDQpUaGUgc3Vic2VxdWVudCBjaGVjayBmb3IgaW5pdF9oZHJfb2Zmc2V0
IDwgMCBpcyB0aGVyZWZvcmUgYWx3YXlzIGZhbHNlLg0KDQpEcm9wIHRoZSB1bnJlYWNoYWJsZSB2
YWxpZGF0aW9uIGFuZCByZWx5IG9uIHRoZSBleGlzdGluZw0KY2hlY2tfYWRkX292ZXJmbG93KCkg
YW5kIFZSQU0gZW5kIGJvdW5kcyBjaGVjayBmb3Igb2Zmc2V0IHZhbGlkYXRpb24uDQoNClRoaXMg
cmVzb2x2ZXMgdGhlIFNtYXRjaCB3YXJuaW5nIGFib3V0IGNvbXBhcmluZyBhbiB1bnNpZ25lZCB2
YWx1ZSBhZ2FpbnN0IHplcm8uDQoNCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
aXJ0LmM6OTUzIGFtZGdwdV92aXJ0X2luaXRfY3JpdGljYWxfcmVnaW9uKCkgd2FybjogdW5zaWdu
ZWQgJ2luaXRfaGRyX29mZnNldCcgaXMgbmV2ZXIgbGVzcyB0aGFuIHplcm8uDQoNCkZpeGVzOiAw
NzAwOWRmNjQ5NGQgKCJkcm0vYW1kZ3B1OiBJbnRyb2R1Y2UgU1JJT1YgY3JpdGljYWwgcmVnaW9u
cyB2MiBkdXJpbmcgVkYgaW5pdCIpDQpDYzogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBs
aW5hcm8ub3JnPg0KQ2M6IEVsbGVuIFBhbiA8eXVucnUucGFuQGFtZC5jb20+DQpDYzogTGlqbyBM
YXphciA8bGlqby5sYXphckBhbWQuY29tPg0KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRl
dWNoZXJAYW1kLmNvbT4NCkNjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBTcmluaXZhc2FuIFNoYW5tdWdhbSA8c3Jpbml2YXNhbi5z
aGFubXVnYW1AYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92aXJ0LmMgfCA1IC0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDUgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuYw0KaW5kZXggZjAxZjM4NTA5MTA4
Li4wN2YwZjE3YmFkNDkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdmlydC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmly
dC5jDQpAQCAtOTUwLDExICs5NTAsNiBAQCBpbnQgYW1kZ3B1X3ZpcnRfaW5pdF9jcml0aWNhbF9y
ZWdpb24oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQogICAgICAgIGlmIChhZGV2LT52aXJ0
LnJlcV9pbml0X2RhdGFfdmVyICE9IEdQVV9DUklUX1JFR0lPTl9WMikNCiAgICAgICAgICAgICAg
ICByZXR1cm4gMDsNCg0KLSAgICAgICBpZiAoaW5pdF9oZHJfb2Zmc2V0IDwgMCkgew0KLSAgICAg
ICAgICAgICAgIGRldl9lcnIoYWRldi0+ZGV2LCAiSW52YWxpZCBpbml0IGhlYWRlciBvZmZzZXRc
biIpOw0KLSAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KLSAgICAgICB9DQotDQogICAg
ICAgIHZyYW1fc2l6ZSA9IFJSRUczMihtbVJDQ19DT05GSUdfTUVNU0laRSk7DQogICAgICAgIGlm
ICghdnJhbV9zaXplIHx8IHZyYW1fc2l6ZSA9PSBVMzJfTUFYKQ0KICAgICAgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOw0KLS0NCjIuMzQuMQ0KDQo=
