Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B869DCD8C9D
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2026 14:23:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 519D310F490;
	Mon,  8 Jun 2026 14:23:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z+lShV59";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010066.outbound.protection.outlook.com [52.101.46.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52C0D10F480
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2026 14:23:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNt3Iswzb9Dqixc7RjxJrynwRzWtsPUE3zvDb9K1JovE3yIDFH3Ic6UxYJUuP8R75imhB2XX3ohhGH71z9BViXP2ab79Oz9aWOnNUuGZ5OFdtj3gTd7+edSPnFHOOJRS3iFY/TQhGppd7t2rZTf31XVl3PGbmN3sAxbz05kWKVZvYmOEuTgQWuM2RL8yJqq0Mn6m1YomLbTMoHAmwAlkZcRo6NWWIcmODi5stKnn24pel5l39gB15u/QVcrSOYSdY4dIxdmvmPpKQO0k4+YWSn7gR/9rZbSQdTBub0AZLrAHA/rw8j6XIgrid3C6O0wdp25m2EAWVvR3zxAqMxubrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDNvCfFVj1ZtSteM1BiprSEjWbPAUxnNj6h8BiPmmWQ=;
 b=JsV9j9pcMtDvl9vrJeZJixiHf+Kbc9NIqwFfuOsiPdqqtVE99jdFTi11K604Ig1cB4gqbPQpXyw8SN5812wRf4IBnp4EPEXN7ZLBe4Q9msTeRfa/ZGttdYvtHfQurv0zLo/150zX9nPU75gqkeLoXeKaG+e0K6ZNwLig51sE2JXYMTD7RyXPKD6XJ7tGpX3r8CJkfcXAaqQkFY9YnwDks4jRrQdJElGUVD5tdvq8Mc7Lho09uVUpTcTTXd1GL6OWbsUo16kt7U3wFdcvRixVTYEKkU2gpprfdnjgEHwjqZE+ebztRFfOTS8NMdd3H9XnSFVwhy0s+ZlwwGwvINGSyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDNvCfFVj1ZtSteM1BiprSEjWbPAUxnNj6h8BiPmmWQ=;
 b=z+lShV59iajUON1EaXx/XsEvQSgI7lQi3uwW6oLiTz1VQFmgN+HOdPUd4/ilwAh7lQ+1nWcPo+fRXJ1LGPsf8uEWpsSsaZnr9OZgmJn40ePEmuD9G1FOGjOet3uwT91reWjJ+Kc1ZrYYYCdqMnTJwWGuLeQgEcWlVhwFH9G690Q=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Mon, 8 Jun 2026
 14:23:28 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 14:23:28 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v9 05/11] drm/amdgpu/uapi: Define kernel event types for
 EVENTFD subscriptions
Thread-Topic: [PATCH v9 05/11] drm/amdgpu/uapi: Define kernel event types for
 EVENTFD subscriptions
Thread-Index: AQHc83bTYB+JYmPNNUqKZP1yNFVZkbYv9UGAgATIMWA=
Date: Mon, 8 Jun 2026 14:23:28 +0000
Message-ID: <IA0PR12MB82081E035F163C33BB251039901C2@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260603163350.2678309-1-srinivasan.shanmugam@amd.com>
 <20260603163350.2678309-6-srinivasan.shanmugam@amd.com>
 <c5c81981-492b-45b2-8000-76d734d4c11c@amd.com>
In-Reply-To: <c5c81981-492b-45b2-8000-76d734d4c11c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-08T14:22:07.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|DS0PR12MB6656:EE_
x-ms-office365-filtering-correlation-id: 8f031942-04c9-4cdf-7d91-08dec5698289
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|56012099006|22082099003|18002099003|4143699003|11063799006;
x-microsoft-antispam-message-info: 4KCiVcEQCZiIw/1Jt3A1PiCiOf2mLfwdjGq4fHnhj2VxMGcG9lgc5nv23UA68TSJaKINfy61UiO0qjtOoY5gV9RE+1czNSC1TvulDwbc8UIJ3BP4hguB7ft7ZgjmjrthOD1znlWzCflHpAI4O2ozmkLx3/LeOCnh2EUPZEOZjvhN0MjahIvQwiAk4hx6xuaUlv9vkDvtJ5y4PXvL6/7XgdMRfakt2tKIvoKx4T0LbJ5RqUubNI6QxmePeCgixTIIxrE98zm0rm8bkiduwEMdhnUzB0ymfZ6xB0K/dEknpeezcwEMGdLW4whmNjPWqALnqdHRHvsw/RUXFXVavoiySzyibXuGySjCqvaJFmVzr+Btdrp5t6FwaNuA/bjqGG+s81p1+fvUpEq+CdfzWXDvDMkND6NMQGlboOXcYzngLOgy9t9rfVh1iU4Hrd7cLnzHFZl14rRqUDsBzUqnTl/WqXMBcsRKqvFpuLtQdmAv0rJFDPNkjrCYSf7hepFwprNf/VJOx19iE+oHhIOfyScx7JIUMfGvQ5wKAI3tGhMqBdz/twgLiL4WIsWP2Jv4YGAWMJDpNDLK3UzNchb9PXbz8UhfT4fCYHF70JM76g9TfQrP7MFJOi4oMd8MStAvkMU2zc7S8WxhRJCtRyqCCdJUTbEzNx/z2IzP2iWYS2hEKLDxiLMV7+WCgjzBC/SU+PUveOFDkOXXReMfzQa/DyNsptTQ/B64poroFxYtlrye0RW8n+lkJ7e/x6iH6mMPQO+8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlliQ056Y3dRRVN6M0YrVnBwQ2diNWgvMEllWWdKRTZwWE03eWMvMVR0VDFP?=
 =?utf-8?B?akNmY21VOU1BVkVqNlJLRGp4QWMraTdodzVTRkpzUGd2anVmYUh5cmczZ3cw?=
 =?utf-8?B?Q2tJNWUxUEEwNlJZUWtIeGNLbzROMlN3ZVFualV0TG1xUUcwUUZ0eW41MGUw?=
 =?utf-8?B?NjhBYnhpU1lXU0YyTmRUTHlpQU9wVExBSGo0NS9WRjh4d3JFZmEwMll1YVUv?=
 =?utf-8?B?MzJoeEF1QTcrWkdXQWpXcDRMdzV5T0ZzS0tqakp6TzMyS1htQjdDdmFHSlA4?=
 =?utf-8?B?MDVnZUtRVUFjcmdoN1dybkJvWGpFaDVDSEZlOWVLNldYLzNXSFFkdDdUdWVr?=
 =?utf-8?B?cjNXL1Z3TGlLWit1aTR5S3AvRlVmcHJMSXFTQm1reXlDdlZDQm5nOXQ1T3dl?=
 =?utf-8?B?MlkwT2VtSjcvS3dFNWszb3ZEeUVLbUVyakJBZXRxRTdsY3J3bnNhc2pQNG5Q?=
 =?utf-8?B?RnRqWVZWMGdBb2NEb1VHekVYZ3o1czlVd0VYeVdGK3NTSjhmVDNpNktrT0l0?=
 =?utf-8?B?dDR4M0ZKZzZZUkJEOHY0bjJBTUJBcmtGOHNJV0hPRWV0WmNwbjNNd0QzbnZj?=
 =?utf-8?B?Y0hQSkJCSldJQU1IY3hZNkQrd2ZEeHpIR0pRL21zRU1qM2xMWnc4NHZYWVZD?=
 =?utf-8?B?c3VtcWc4MjREeW5MSFk0SWd1YloxVmdWb2lXMyswUkFGTkxFdjNrOTNORzBm?=
 =?utf-8?B?eXJzTk5PYVFNYkpabDV5Q0tXM2NRNm5KZklkaGl1YmNhZm8zYW8vNDY1WFRl?=
 =?utf-8?B?TFlxM2hieEtBMFJRRGlrb3RxV1BuUHhsQnZsOUVNdVdWT0Y1TzlqSDdOdTYw?=
 =?utf-8?B?ZW5XQnZ4ZU9LMXZFWnF6c0FGY1N6QldLSTR5VXpBWE9pUy8rVEllbVlnYlJY?=
 =?utf-8?B?Y1VQUDJraVhDK2EwRXUxU0FkbndYYVM0YVI1bXlPTG5IZW5xejhwcS9XRGFP?=
 =?utf-8?B?RXVZSjkvQnBDZHFDVmMyY1cvWk1rWWtzU29hNmFwbEpwSzh4WG9VQ2tCQUJK?=
 =?utf-8?B?dXRYQTEwdmtOb0g2NG52VWFhOHo3QUxBNWxJZ1d1RXFSVG4zQWJXTm42cWpC?=
 =?utf-8?B?UlhiOEhLbVZLaEU4NFFORUVXc3hONHZFVUV6OWVTQ1pRNEQrcUVEM0VVbUpX?=
 =?utf-8?B?ZVVGQWhydzhqOHJRY2UzQXZnRHQvMDlTRTB4SHZ1dGtkQTVHaEdGUURvMjl0?=
 =?utf-8?B?NUhIRWt0S056ZlJobTJGM3ZUeGd0dzRUajRvb1hoUERYVFZPTDM3RGZuZXQ1?=
 =?utf-8?B?OEFNcjZGdmJRUlFpbkwzbWZnOVJlY3dxUnVRc3NEVTN5K1FlcHJ1NmxudEVD?=
 =?utf-8?B?Ny9qSy9KcTBJM21HdmMzOEFKdmZTWmxyWGh0alF0S05KT0JRWnIvVVF4enFG?=
 =?utf-8?B?Ui9GYXJ1aWFNRVpvRmpNQlljQ3FXMkhvMnNEUmFubFJ1NllraEpabFFLMGxY?=
 =?utf-8?B?SEhkSlBtOUFlcXE0UXgvSklVSVhyeVZPTFFaeGpaS0h4bHhNaWtZZWQrTC9Z?=
 =?utf-8?B?RURQVm5pMFZWUkVqNit0Um1SUGNBUzJWaHdJdWFOalZrWjlKYUtRdXhPV3Rj?=
 =?utf-8?B?blkvMG9wdTRCWW1LM1JGN1dSc2ViR21SSEhXM2NFbWlDYUF2SEJRTEIxMEw4?=
 =?utf-8?B?a2k0MDliRGFVVU5Kakgzb3Z5Uk85VWhoMzFJVFh6emhHR3pqYzVWSnp3YlpK?=
 =?utf-8?B?Qmt4cTI2V0dZS0NPV0N1V1N1S1pIWVNLbkNZcktNVEh0SCttZ2o4aXJZcVdv?=
 =?utf-8?B?NGZ0ajU3dVZUSEQ3RmU5ZGUzOHloM21rVUZIcStVckVBY080eG1nMWJqSHN6?=
 =?utf-8?B?QWRqN3hZL25xT2Fpekh6eDkxSG51VS9kcDNGWG9qUjZSbnJ1MW4veS9xRjBO?=
 =?utf-8?B?b3RMbS8wZS9nN2lBdGgwS2o2YW5CNFFVTnRRa09yUXVNUE80Mm5wcUhQNnNa?=
 =?utf-8?B?N3ZPNHpGQTc4QlpMOGo5MGRtVzI5L1B3Mkl2eTNCY3dnNEppbTdMa3NwZUI3?=
 =?utf-8?B?azZQd0NTL2NaRE94K1dUenZVZys2ZTNwQStqNHFkbzlvVjgvdDlRbWxYWE00?=
 =?utf-8?B?YVdCWktIek5oUTlnUkw3emxuUktWODRNOFh2bG1JaTd2SkRnbFB0SXZvc1ZQ?=
 =?utf-8?B?eml3RjVxUGQ2UTU5MUZnSVVKK3NMR2I4cE9HVmZjU0pUNmhrRFpDbk8yak14?=
 =?utf-8?B?Uk5BWmszQUFEeXJsSVdFMWpnWThOTXdFRU5EWjdBbnJYdXkwY0NGMWFDWXhl?=
 =?utf-8?B?VVU0S2RjcEFOMW1KZXhZb2ZZUmEwWDNXU0dyQnR2Q2VTZTZvdEpjWG9HZzg3?=
 =?utf-8?Q?pz+iZQGBidvqFtY1y6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f031942-04c9-4cdf-7d91-08dec5698289
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 14:23:28.5449 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /9CQXcspXAU59u8wYojxpiRzQCjiSDpAUoHgN4V2BLNeJRJkLxf8c11IJVZcwJW3bGcb8VDupdS3+PHebcRLAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656
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

QU1EIEdlbmVyYWwNCg0KSGkgQ2hyaXN0aWFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+
DQo+IFNlbnQ6IEZyaWRheSwgSnVuZSA1LCAyMDI2IDY6NTEgUE0NCj4gVG86IFNIQU5NVUdBTSwg
U1JJTklWQVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47DQo+IERldWNoZXIsIEFs
ZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgMDUvMTFdIGRybS9hbWRn
cHUvdWFwaTogRGVmaW5lIGtlcm5lbCBldmVudCB0eXBlcyBmb3INCj4gRVZFTlRGRCBzdWJzY3Jp
cHRpb25zDQo+DQo+IE9uIDYvMy8yNiAxODozMywgU3Jpbml2YXNhbiBTaGFubXVnYW0gd3JvdGU6
DQo+ID4gVGhlIGN1cnJlbnQgRVZFTlRGRCBVQVBJIGRlc2NyaWJlcyBzdWJzY3JpcHRpb25zIHVz
aW5nIGENCj4gPiB1c2Vyc3BhY2UtZGVmaW5lZCBldmVudF9pZCBhbmQgcmVzZXJ2ZXMgcXVldWVf
aWQgZm9yIGZ1dHVyZSB1c2UuDQo+ID4NCj4gPiBUaGF0IG5vIGxvbmdlciBtYXRjaGVzIHRoZSBp
bnRlbmRlZCByZW5kZXItbm9kZSBldmVudCBtb2RlbC4gVXNlcnNwYWNlDQo+ID4gc2hvdWxkIHN1
YnNjcmliZSB0byBrZXJuZWwtZGVmaW5lZCBldmVudCB0eXBlcywgd2hpbGUgdGhlIGtlcm5lbCBr
ZWVwcw0KPiA+IGNvbnRyb2wgb2YgZXZlbnQgc2VtYW50aWNzIGFuZCBzaWduYWxpbmcgc291cmNl
cy4NCj4gPg0KPiA+IEFkZCBhIHNoYXJlZCBVQVBJIGVudW0gZm9yIEFNREdQVSBFVkVOVEZEIGV2
ZW50IHR5cGVzIGFuZCB1cGRhdGUgdGhlDQo+ID4gRVZFTlRGRCBpb2N0bCBkb2N1bWVudGF0aW9u
IHRvIGRlc2NyaWJlIHN1YnNjcmlwdGlvbnMgYXMgbm90aWZpY2F0aW9uLW9ubHkuDQo+ID4NCj4g
PiBxdWV1ZV9pZCByZW1haW5zIHBhcnQgb2YgdGhlIFVBUEkgYW5kIGlzIG5vdyB1c2VkIHRvIGRp
c3Rpbmd1aXNoDQo+ID4gcXVldWUtc2NvcGVkIHN1YnNjcmlwdGlvbnMgZnJvbSBHUFUvZGV2aWNl
LXNjb3BlZCBzdWJzY3JpcHRpb25zLg0KPiA+DQo+ID4gVVNFUlFfRU9QLCBRVUVVRV9SRVNFVCwg
YW5kIFNDUkFUQ0ggbWF5IHVzZSBxdWV1ZV9pZCBmb3INCj4gPiBxdWV1ZS1zcGVjaWZpYyBzdWJz
Y3JpcHRpb25zLiBNRU1PUllfRVhDRVBUSU9OIGlzIGN1cnJlbnRseSBHUFUtc2NvcGVkDQo+ID4g
YW5kIHJlcXVpcmVzIHF1ZXVlX2lkID0gMC4NCj4gPg0KPiA+IENjOiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+ID4gQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTcmluaXZhc2FuIFNoYW5t
dWdhbSA8c3Jpbml2YXNhbi5zaGFubXVnYW1AYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jIHwgIDYgKysrLS0tDQo+ID4gIGluY2x1
ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oICAgICAgICAgICB8IDI1ICsrKysrKysrKysrKysrKysr
KystLS0tLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCA5IGRlbGV0
aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9rbXMuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2tt
cy5jDQo+ID4gaW5kZXggY2QxMjdhMjcxYzE5Li43NWZjM2E3NGRiMjggMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jDQo+ID4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jDQo+ID4gQEAgLTY0Myw3ICs2NDMs
NyBAQCBpbnQgYW1kZ3B1X2V2ZW50ZmRfaW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9p
ZA0KPiAqZGF0YSwNCj4gPiAgICAgaWYgKCFmcHJpdikNCj4gPiAgICAgICAgICAgICByZXR1cm4g
LUVJTlZBTDsNCj4gPg0KPiA+IC0gICBpZiAoYXJncy0+ZmxhZ3MgfHwgIWFyZ3MtPmV2ZW50X2lk
IHx8IGFyZ3MtPmV2ZW50ZmQgPCAwKQ0KPiA+ICsgICBpZiAoYXJncy0+ZmxhZ3MgfHwgIWFyZ3Mt
PmV2ZW50X3R5cGUgfHwgYXJncy0+ZXZlbnRmZCA8IDApDQo+ID4gICAgICAgICAgICAgcmV0dXJu
IC1FSU5WQUw7DQo+ID4NCj4gPiAgICAgLyoNCj4gPiBAQCAtNjU2LDExICs2NTYsMTEgQEAgaW50
IGFtZGdwdV9ldmVudGZkX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZvaWQNCj4gKmRh
dGEsDQo+ID4gICAgIHN3aXRjaCAoYXJncy0+b3ApIHsNCj4gPiAgICAgY2FzZSBEUk1fQU1ER1BV
X0VWRU5URkRfT1BfQklORDoNCj4gPiAgICAgICAgICAgICByZXR1cm4gYW1kZ3B1X2V2ZW50ZmRf
YmluZCgmZnByaXYtPmV2ZW50ZmRfbWdyLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGFyZ3MtPmV2ZW50X2lkLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGFyZ3MtPmV2ZW50X3R5cGUsDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgYXJncy0+ZXZlbnRmZCk7DQo+ID4gICAgIGNhc2UgRFJNX0FN
REdQVV9FVkVOVEZEX09QX1VOQklORDoNCj4gPiAgICAgICAgICAgICByZXR1cm4gYW1kZ3B1X2V2
ZW50ZmRfdW5iaW5kKCZmcHJpdi0+ZXZlbnRmZF9tZ3IsDQo+ID4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBhcmdzLT5ldmVudF9pZCwNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFyZ3MtPmV2ZW50X3R5cGUsDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhcmdzLT5ldmVudGZkKTsNCj4gPiAg
ICAgZGVmYXVsdDoNCj4gPiAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgNCj4gPiBiL2luY2x1ZGUvdWFwaS9k
cm0vYW1kZ3B1X2RybS5oIGluZGV4IDYzY2RlNDQ4N2M0Ny4uM2RmZmQ5ZTU4MWExDQo+ID4gMTAw
NjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgNCj4gPiArKysgYi9p
bmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaA0KPiA+IEBAIC0yMDcsMjggKzIwNyw0MSBAQCB1
bmlvbiBkcm1fYW1kZ3B1X2dlbV9jcmVhdGUgew0KPiA+ICAgICBzdHJ1Y3QgZHJtX2FtZGdwdV9n
ZW1fY3JlYXRlX291dCAgICAgICAgb3V0Ow0KPiA+ICB9Ow0KPiA+DQo+ID4gK2VudW0gZHJtX2Ft
ZGdwdV9ldmVudF90eXBlIHsNCj4gPiArICAgRFJNX0FNREdQVV9FVkVOVF9UWVBFX0lOVkFMSUQg
PSAwLA0KPg0KPiBXaGF0IGV4YWN0bHkgaXMgdGhlIGludmFsaWQgZXZlbnRfdHlwZT8NCg0KSU5W
QUxJRCB3YXMgbm90IGludGVuZGVkIHRvIGJlIGEgcmVhbCBldmVudC4gSXQgd2FzIG9ubHkgdGhl
cmUgdG8gcmVzZXJ2ZSB2YWx1ZSAwLg0KU2luY2UgdGhlIGtlcm5lbCBhbHJlYWR5IHJlamVjdHMg
MCwgdGhlIGVudW0gZW50cnkgaXMgdW5uZWNlc3NhcnkuIEkgd2lsbCByZW1vdmUgaXQuDQoNClRo
YW5rcyEsDQpTcmluaQ0KDQoNCg0K
