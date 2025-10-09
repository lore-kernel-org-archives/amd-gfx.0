Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48738CCD184
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 19:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0F3F10EAFF;
	Thu,  9 Oct 2025 19:12:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FO9KRggb";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012055.outbound.protection.outlook.com
 [40.107.200.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA7BD10EAFF
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 19:12:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7zaxCtD3iK5IeGUfYfV9nMH4Q60a9FUmYfIcFl6Ss8MG9dA0QuB8+dn13P6fCixKt3TsqUp9JCMgehIFH2a6qlvC3srA3Y1pdNsBid/qJZN3IeFUq3IU27w15lN3VYgaRQa2jaRMXD+34UoRPS+9O2PK7mY9k6oOamhsQCLaT8gzvE0R+xudbABxQEg4zC8OMTzbScAHKfEOJZsppROCKGFFitcU/fOHSdnC/gXmQ0uAcRVfRR0Wn21ernwYK6GDTQgKn8gWZQsAa/F4doJlTpDqmKQQsNqjV5wBDjsHI1o/ZUOdvJXMr7t4AUlPpOHrqnGZA0pfLhmd1khRLGmSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iy9sqxzvQkeutJzQV+aKU35A2pRpXJjHF3kyqm0XBHA=;
 b=co86ji8tXGnOAJV3tGSRJSnQWLeVtaYvhMzUIEgFUM9Y1czcO8PBwh+d9JYboBLXNPdrvFuJDl2NHImoIdDFFyczbuG3YdmLdMNnCiGt0SwGRWiLn9WMA0nXuaPpBN9/gQE847oM/lTPDHy/a8RSrmdG+REUFNHhrnfrUz8a081RfPK9EjB5yX0jaJxwrGW32egnJam4c7rOkcq5PDiWfl6UEFer13HAjHoF9rz/jWhqIUufW17pwVaYPi0d5wqke8Y49Gu9kG1CtijonBWDqYT30X8v8OxFO80ELNTePfUteOfq2cUVlDlZIxRFL+8QIVhWF17i6zxAAFdpRPSNaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iy9sqxzvQkeutJzQV+aKU35A2pRpXJjHF3kyqm0XBHA=;
 b=FO9KRggb/UfWZiTb6bI/eV7i+/HRQ16NFRz2R0sYUp7GviI8VQqlSNplPVM+0LagwTw+ubE/GnBL5egNnTg8askM1N/EjMi3dHoxHLCKjLam2e8uWKBlFXk9/2A3ZVeNLP7/kHgODuahGIxoaMAlyi+Zg2FkDVfJ+R6XQQhqAew=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 19:12:02 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8%4]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 19:12:02 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Liu,
 Shaoyun" <Shaoyun.Liu@amd.com>, 
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Lin, Amber"
 <Amber.Lin@amd.com>
Subject: RE: [PATCH 4/6] drm/amdgpu: enable suspend/resume all for gfx 12
Thread-Topic: [PATCH 4/6] drm/amdgpu: enable suspend/resume all for gfx 12
Thread-Index: AQHcOU2FdF/4iiDUr02BrRB6B5FImLS6LbYAgAAAgEA=
Date: Thu, 9 Oct 2025 19:12:02 +0000
Message-ID: <CY8PR12MB7435D9C384805E93F25FDEFE85EEA@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20251009184929.1038298-1-jonathan.kim@amd.com>
 <20251009184929.1038298-5-jonathan.kim@amd.com>
 <CADnq5_OrEiFhqZFKUgspbjYGY5tXWn_iSK5Jz6pO8XWPJgTCsg@mail.gmail.com>
In-Reply-To: <CADnq5_OrEiFhqZFKUgspbjYGY5tXWn_iSK5Jz6pO8XWPJgTCsg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-09T19:10:53.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|BY5PR12MB4130:EE_
x-ms-office365-filtering-correlation-id: 07c85889-228f-4288-4e77-08de0767baa4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dUZkVFRzMytEczZsbXdUQUdHdjJpdU1JZkZGK01lL2xnbnE4WHB2SUJuUXgv?=
 =?utf-8?B?ais5Q1NhZmRVNlRsMEd0TmYwcW95VjRjOFYybmFPenIzaVh0NWtmd2VORE9D?=
 =?utf-8?B?dWNHci95MnZORmZTVFg4bHdvTXpONVlSNjFRZnMzUnRyTUY0NS9IaW9Fa0Fl?=
 =?utf-8?B?ZGlxLzc0SEpQc0djSWg3OENzQk82cG5RZWhoMFVrczNsdjV2bXFWOGpJZW9n?=
 =?utf-8?B?RHZlRlVUMVZ3N0dLaERuTTJqaWk5Y2dpaElIYnc0UDgxSGdPcTFQK096UnBY?=
 =?utf-8?B?TG5qclVqakxJMXhIYTViWVczbFI1R3duSHZwcW0rRTM4NWpBejdYSU16Rit6?=
 =?utf-8?B?YmpOMzV5WGo4c3NLdVVzWXN1WjBBU1ljNW92Zjh1ZFlJUXRHQVRRaW5YS1N3?=
 =?utf-8?B?TnNGYnFrdTllbzgzQSttRDBhVzRjeW0yeHZKRnNLU2ZpeEdXa2YzZHVrZll3?=
 =?utf-8?B?WVB6WllIbEVDMElXRm1uTno1SktvdVd5RjZBTzZKTGY5aXNUYnFSbjB2WWpq?=
 =?utf-8?B?b09uVDQrUFZQcmRCMTNMYWhySlI1ZG5URklaS244TER6QjJIK3RmOUt5MjZs?=
 =?utf-8?B?UllaSFJDb21maGcwRDVBM0gyV3YraDdGaHhkU3FLRk5JcW1FVXVoMU5DcGIy?=
 =?utf-8?B?MHJ2UCtCV3BkVDNwL3U0Wko1MFNvZDRZS1JnSGJHMHlHOWFjaWJheEhpY3RC?=
 =?utf-8?B?VWxDRHU3Y0tNZ0ZDUThwZk5yUStjZzA5RnQ3czNKWk4rZjAzU0QrcUw5N0Ru?=
 =?utf-8?B?RlBoZDB5UTFTQUpOYTZ4Zk9wOXZ2aGd5QUxtdWhsbDJqZ0o0cHVqOTdJNFQy?=
 =?utf-8?B?d0FlOTdUOHhDdGRJUXJ5NlkzNUlGVXRzZGZNdUpzVm5mckJyMWdQUVBGV2Ry?=
 =?utf-8?B?c3M4bFRFNGFhdlhLTFh6Nmg5L2FmWE90SVBLVlA0ckJnbmpxSHUrdk5SMzYx?=
 =?utf-8?B?NUVud3N0NXoyZ0piN2V0ZTBWcmpRb3gyRk9UbUV0NUFMclBDRHZQVmVUbk5B?=
 =?utf-8?B?eU9kRGhtU2pqVUk0Z0d1ZnZYMktHdldtY01SdkxYQVh3eFBYbW1hUWRjOFRv?=
 =?utf-8?B?SEVZY0UrT0tnSzl3M01yOXpjNDB2RjRTUDA2OXZSR1B1bCthYjk2RFV2MVBV?=
 =?utf-8?B?a2VaTVVzRy9qU3NYSzZJSmxNR1ZzTWhlTUhiWXByeHUzMkk1UEdFUWRrWmJu?=
 =?utf-8?B?MHlRTW9ZVEJnQ2ZhWHpxdW5HbFdmUXgzUWlLSG9nTUdoZW56bnA0aHBKMEYx?=
 =?utf-8?B?ekNZU3VFSlFvLzh3UUdMMmZrY3RkNXBMSDFwbGJmNzdVVmswQTFqQUZDdkpp?=
 =?utf-8?B?Wk9xVnpLYXl3cmFGeTgxaGI2RGgxcjErTmlmRkNEa0l5T0tZYUU1Y3QwWC9S?=
 =?utf-8?B?MzBSSDN1TG4vN0liV0w3aWVqZmd2YWJ6cXZzNlV1eHJBRE5TV2N2MTZEWVpD?=
 =?utf-8?B?N1ZjZkFob3lwdlFHSmREQzV1N3JySzZ2OU9iOVh1ODRXUm5LNXJ4UWp4WnBu?=
 =?utf-8?B?d1QzN1JhajlyUVFid1N2SzBqOUpzRVU3TUxnQ2ZNelhOOENteXBBN1h6K2ZV?=
 =?utf-8?B?YXpNR3hkMVA1ZGFyLzllTkVEQ1AySkt6citGZ1pkcHNkWXFTczVpcStYTnhM?=
 =?utf-8?B?UXRUdEpKMXlXS0VTdDRFMGZXM2oxY2pSUEhSaW5VSjFhR3M5U0x3V3BrN1hP?=
 =?utf-8?B?dUhiSE1ER0kwUjNJTFcvdjYxNXZybUJRMUozTmNIUXZtVG5FY3krQUU2elV6?=
 =?utf-8?B?VUpQczdvTFIrQU96TFhHaGs2dTJwOW9pZ0lDc0swRDFwNkMzTUttWTlIUmxy?=
 =?utf-8?B?ODQxSW5XWXJiS0NQRkFSYlljVWxiQUdrUFVUbWtrbjhzOHZ4LzlobTVaOU1n?=
 =?utf-8?B?dm9tMEtPb2xFZ1ZueWpjMnBEaHB3SVV5ZG9MNTdvcVRMU2ZqNURpdmFXclkr?=
 =?utf-8?B?bXRHY3NwOG9WdmZwV2tqaThyd3EzZTdFdWZobzVyQUlNelMyc3BSeVpKTysw?=
 =?utf-8?B?bm9MMWY4NWpkSEcvNk95a2F2L3VCWnZHVnVuemVScW5TQlFmMkFGZmtJSi9T?=
 =?utf-8?Q?POBGXx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGI0NXVQMXM3Tm91bVluTkd6eTNOVDNRNllQZFpUNkoyL1Vxb0M4N3JFMFUz?=
 =?utf-8?B?UGg5aThTRkx6Wlk5aW03SWdIYTcwbHhOb1NXdGQ0S21mN2ZzbDhySXQrMEx5?=
 =?utf-8?B?N0MwaGNhQ0QxTHV0MGtiVkdycmRoVzlnbU9uSDZQZlFDSDdBYlZMQUVWVDBu?=
 =?utf-8?B?VWhzQUV2OXljWlZGNWVzZ0tQSWM0bUJtYXhWV1o3V2VFOFY4WUtqVmVIWG9y?=
 =?utf-8?B?YzBSZUtoMWZxTmJaa1I5N0xjcnlybm95YzEwNlJnZGtIUXo5c1Z0Q2VJL1pm?=
 =?utf-8?B?S01NOHJleU8rQy9aWmhUeVVES00zSkFFNXBkRmlROTZLVHhJT25oTWJwOFR2?=
 =?utf-8?B?QmVRVzF4M242NUdTK2srZ2hTZGFEV0hRSUwxazFtSHVGL1dXTVBIK2hKZjkr?=
 =?utf-8?B?eTF1Zzd5WlNDMVpnV3VDZmw2TDhlay92b2Y0SVRPa2ZXcnFzSTdqVDBrK2Iz?=
 =?utf-8?B?QUhLaEpKenNhSHFHVHpqUWxHQTh3TUkvMHczRnBGK2FIVTlpblgxOVV3NjJj?=
 =?utf-8?B?VThDZ3BhalF3cVJXL0d3UnQ1bW5WRFR6ai9JOEtlVklDZ3VCWWVqSFlxTjRG?=
 =?utf-8?B?YzFzYXpkclVwWWdBU3hlZkpuYWlhSlBUakIwVy9VdVlDbVc5NndGSUI5M0U1?=
 =?utf-8?B?cWI5ZkUraE05UDVWcFZ6d0RjNVNMMkdxTmtwMGFNTC9vN0NkWlQxMjgyaXdF?=
 =?utf-8?B?NTF2ZkNScExsU0hXbWkxdXRvVEtUUHg0UEFSZ2ZPa0QvUHZ4a3lvMkJMa3Nn?=
 =?utf-8?B?RUM3QWF1WUs0aXlOWG41Rm5Ickk5c1hMa0ZFZzIxQmtYNTJZMy9uTTAvRmZR?=
 =?utf-8?B?dnZvbm52WXJYOTA3ZGVIY0FlQXc2S0djV1RXQTVRRk01YmViOGJSUUtmMVEz?=
 =?utf-8?B?TXFJdi95TjYzbGZlMXVpTjBDRStIYnJRekF5dHBPUkVCUFI2SVVWeldwb3JK?=
 =?utf-8?B?c3JjaTNSRmM1aXV5TXlPZVNvZGZSenVLVzJXK0MrU09seWwwVW5tWTA4MXJO?=
 =?utf-8?B?MC9MaDVTK3BKMW9sMWFFNTJvaGZ5NXY3b0sycE9aejdYbmVCM3pJMDhEOUFP?=
 =?utf-8?B?YXo1V25pQitmc2tuL1FZRDZGTnhBMkhYdE5CSE5mZlE2MW1CYy96bm9XMXB1?=
 =?utf-8?B?RWR1MzNFSXpIQ0pBSElPNG0xc0N5Tkw2OGUxbXBJOGR3M2dneWVyMWdYTmhl?=
 =?utf-8?B?ZHlKb0hZRXBJOWNaYkd1dmdPWWlNQVVEL3hRMGhURDVkL1kvamIySkhiN3h6?=
 =?utf-8?B?UWZzUzNCRUovcWwyVWVsak5iU1haZzlZY0c4Z1pQSXByVFgvRVh4bVhpRDRH?=
 =?utf-8?B?eXI5UHoyNVNFcVFQYnBhalhqZVBYeGJqMnVCc2VTL0NlUW5JNkxrZUxFZ0oz?=
 =?utf-8?B?b014YVVhQ0pXNEY3MGxQUkNkeFVDTHp2UHU2OTl5a2pxcHl0a1B3L2c1dmpR?=
 =?utf-8?B?LzA3TkFjaGlOYWtjckJ1OEpFQ2IxR0FmNnNXaWJTeUZRTGZubk1iWHIxZUFG?=
 =?utf-8?B?SHVONVZHT2dEUEFYWGxDNWJSSmlYZmE4RzR0SEZKSEp6SXc1L1d4Z2VxbFBP?=
 =?utf-8?B?RGFRNnk2V01XR1JJOHIvbDVVWmh2R0Rsd0k4OUhYZzdMVW1PNkNZU2VEUUl6?=
 =?utf-8?B?UWhxRUNPTG8rSjZlYUxvQ0ZXYzJnc09RTmlpUTdjeER3QXd1NFM1eTMreDhw?=
 =?utf-8?B?WmZ5OEJ3S0I1TGMvaXZqdTRKZzNLZkw2Y09ZQ05SYjhhanV6SnBLRjVSbHZl?=
 =?utf-8?B?VzJMUVVLMkZnVnZZRlN4TzhJa0dTL3FSZElTdExJY0g2QjBqSGFWbVo1WVRv?=
 =?utf-8?B?eUNtMFY1SDMxVWFTT3Bpa0xoQUxvYnkxTDZ3Mld0L1kvaEc3OGFGSk9rWmFZ?=
 =?utf-8?B?cGkxSGlJSEs2dGxWUXV0aEh3Vms2SVlpN255cHh3bXhWSGJCbGJ5MlRJM1BV?=
 =?utf-8?B?RmhGZVNGa2NmZVJNSCtaZmMyWlhlZE15WlE1UE0vaXFaV2VJWjd5cWpLTHZD?=
 =?utf-8?B?a1RNbjFvUG9KdmYzTnRIMTVORE5rV1VpK3FLMGNoWEpiaXg0Z0l3OXIzWWpZ?=
 =?utf-8?B?b01zT3lONnlUSnVsRzh1REYvUkkrVzJvdEhRQmNiMFJWNXlGSC9FWFB0ZndH?=
 =?utf-8?Q?2+NI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c85889-228f-4288-4e77-08de0767baa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 19:12:02.7159 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h+nA9xLEodF32Sk294+BGcdqZlCI49gKU3fYga5c88Ihe1ZSygWmyQIloxV2/Y5U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4IERl
dWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIg
OSwgMjAyNSAzOjA5IFBNDQo+IFRvOiBLaW0sIEpvbmF0aGFuIDxKb25hdGhhbi5LaW1AYW1kLmNv
bT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5k
ZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBMaXUsIFNoYW95dW4gPFNoYW95dW4u
TGl1QGFtZC5jb20+Ow0KPiBLYXNpdmlzd2FuYXRoYW4sIEhhcmlzaCA8SGFyaXNoLkthc2l2aXN3
YW5hdGhhbkBhbWQuY29tPjsgTGluLCBBbWJlcg0KPiA8QW1iZXIuTGluQGFtZC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggNC82XSBkcm0vYW1kZ3B1OiBlbmFibGUgc3VzcGVuZC9yZXN1bWUg
YWxsIGZvciBnZnggMTINCj4NCj4gT24gVGh1LCBPY3QgOSwgMjAyNSBhdCAyOjUw4oCvUE0gSm9u
YXRoYW4gS2ltIDxqb25hdGhhbi5raW1AYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBTdXNwZW5k
L3Jlc3VtZSBhbGwgZ2FuZ3MgaGFzIGJlZW4gYXZhaWxhYmxlIGZvciBHRlgxMiBmb3IgYSB3aGls
ZSBub3cNCj4gPiBzbyBlbmFibGUgaXQuDQo+DQo+IElzIHRoaXMgdHJ1ZSBmb3IgYWxsIHJlbGVh
c2VkIGdmeDEyIE1FUyBmaXJtd2FyZXM/ICBJZiBzbywNCj4gQWNrZWQtYnk6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCg0KWWVzIHRoaXMgaGFzIGJlZW4gYXZhaWxh
YmxlIGZvciBhbGwgb2YgR0ZYIDEyIGZvciBhIHdoaWxlLg0KDQpKb24NCg0KPg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gS2ltIDxqb25hdGhhbi5raW1AYW1kLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21lcy5jIHwgMTEgKysr
Ky0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfbWVzLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbWVzLmMN
Cj4gPiBpbmRleCAxYWYzZGRiNmY2NWMuLmIyZjg3YmMyOWYwMCAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbWVzLmMNCj4gPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbWVzLmMNCj4gPiBAQCAtNjk4LDE0ICs2OTgsMTEg
QEAgaW50IGFtZGdwdV9tZXNfaW5pdF9taWNyb2NvZGUoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsIGludCBwaXBlKQ0KPiA+ICBib29sIGFtZGdwdV9tZXNfc3VzcGVuZF9yZXN1bWVfYWxs
X3N1cHBvcnRlZChzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiAqYWRldikNCj4gPiAgew0KPiA+ICAg
ICAgICAgdWludDMyX3QgbWVzX3JldiA9IGFkZXYtPm1lcy5zY2hlZF92ZXJzaW9uICYNCj4gQU1E
R1BVX01FU19WRVJTSU9OX01BU0s7DQo+ID4gLSAgICAgICBib29sIGlzX3N1cHBvcnRlZCA9IGZh
bHNlOw0KPiA+DQo+ID4gLSAgICAgICBpZiAoYW1kZ3B1X2lwX3ZlcnNpb24oYWRldiwgR0NfSFdJ
UCwgMCkgPj0gSVBfVkVSU0lPTigxMSwgMCwgMCkgJiYNCj4gPiAtICAgICAgICAgICBhbWRncHVf
aXBfdmVyc2lvbihhZGV2LCBHQ19IV0lQLCAwKSA8IElQX1ZFUlNJT04oMTIsIDAsIDApICYmDQo+
ID4gLSAgICAgICAgICAgbWVzX3JldiA+PSAweDYzKQ0KPiA+IC0gICAgICAgICAgICAgICBpc19z
dXBwb3J0ZWQgPSB0cnVlOw0KPiA+IC0NCj4gPiAtICAgICAgIHJldHVybiBpc19zdXBwb3J0ZWQ7
DQo+ID4gKyAgICAgICByZXR1cm4gKChhbWRncHVfaXBfdmVyc2lvbihhZGV2LCBHQ19IV0lQLCAw
KSA+PSBJUF9WRVJTSU9OKDExLCAwLCAwKQ0KPiAmJg0KPiA+ICsgICAgICAgICAgICAgICAgYW1k
Z3B1X2lwX3ZlcnNpb24oYWRldiwgR0NfSFdJUCwgMCkgPCBJUF9WRVJTSU9OKDEyLCAwLCAwKSAm
Jg0KPiA+ICsgICAgICAgICAgICAgICAgbWVzX3JldiA+PSAweDYzKSB8fA0KPiA+ICsgICAgICAg
ICAgICAgICBhbWRncHVfaXBfdmVyc2lvbihhZGV2LCBHQ19IV0lQLCAwKSA+PSBJUF9WRVJTSU9O
KDEyLCAwLCAwKSk7DQo+ID4gIH0NCj4gPg0KPiA+ICAvKiBGaXggbWUgLS0gbm9kZV9pZCBpcyB1
c2VkIHRvIGlkZW50aWZ5IHRoZSBjb3JyZWN0IE1FUyBpbnN0YW5jZXMgaW4gdGhlIGZ1dHVyZQ0K
PiAqLw0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4NCg==
