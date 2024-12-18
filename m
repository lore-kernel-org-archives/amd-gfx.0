Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C43E7718A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2024 12:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3B6910E071;
	Wed, 18 Dec 2024 12:08:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0sTEd5E4";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2E3410E071
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2024 12:08:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWfN1iD3eSmSSvMtzNMEd/zic4wbKGAuOz6+sM67ZWkLJJ78mlBjNac9QWBz28BzHJMcq3IThH+u42/WB4IGK5be/wfDrFnzrdaA7cMUYJ1twE4IY2pgCvrXvXtsQqh+V69a98UNKZhyfhRps26Cx34TDvK4xn4uUxWz1WrRgZrXd46uuVmms6erpNgmmb8qnCX7+BUqp8qzfILKLuIGMZ6RNOMMr9foO/Vou8eglgRizoO7qddwJCs/u1hMFm6FWaj/mCa4ov5TfHYKaSIZMJPBNOFNw74HFKM32wHBKKXWQnVrmrmXRn2KuxC0j5/AWqnuyRW4Q0VDxN/xeKKD4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faSW4UIxYzUOBdxKwCKRTMoPHkA0fUTuxzCSc7bxXr8=;
 b=DQSaqIjCNonrMZW5sMSmgj0MSLgiaioo6dBMwg4STHebSSz3lOeazR6SfV4Ej8RfJMvkCMUYAa4cJRolp9sm1QXm5FZ/6bYvpjpaHWksHcPBM8IIuGSmoPmcywwfIA8FCIM9ungkpo4BEh7VMsJnP3gByoGXasPgQiPDZ+LXAAQIVLJN8mVRCrt6W72O3nSG9fkrXu1UkxrYssM+LQEGhSX8V4meN4aMajhzSeFHgJPyrRv5aB7MP9xPb08MzQ+YhX8bDCggpVBD5X1wnxxXYUpSd0R5yDqU0M9lXCLLNTbq5AlAQlfcP6sicN4D+mgtXoBq5d2RSSeGb/DcdLJ6GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faSW4UIxYzUOBdxKwCKRTMoPHkA0fUTuxzCSc7bxXr8=;
 b=0sTEd5E4wnlWMAVR/TT1V0tNz6Q3dLIBUvNc4ylO+3MaxEOm4cOuyrFtC5zxfCgQx2puP+dXqxdYnC9SldNDOuM1yCZzxY9AAYPvcdhz/47f3/TIVb+qV17q82gCyrIdAqN1DZVEvYjRB0ifsmRP+DR5BSocBwIVrLna/9Ullfw=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by DS0PR12MB8343.namprd12.prod.outlook.com (2603:10b6:8:fd::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.21; Wed, 18 Dec 2024 12:08:29 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::1f8c:661:11b5:86fc]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::1f8c:661:11b5:86fc%5]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 12:08:29 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Driver needn't request RLC safe mode for gfx
 MGCG
Thread-Topic: [PATCH] drm/amdgpu: Driver needn't request RLC safe mode for gfx
 MGCG
Thread-Index: AQHbUR73FYci6euwKEeTZp3RkeOtpbLrrXYAgAAx4zA=
Date: Wed, 18 Dec 2024 12:08:29 +0000
Message-ID: <PH7PR12MB6000159E6235705351DC4F3AFB052@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20241218073154.843863-1-Prike.Liang@amd.com>
 <cd449c1c-7885-451e-8b15-7f8fd9f84217@amd.com>
In-Reply-To: <cd449c1c-7885-451e-8b15-7f8fd9f84217@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d1a8701c-18dd-42e3-85d8-bbc5e5eda0ce;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-18T11:34:27Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|DS0PR12MB8343:EE_
x-ms-office365-filtering-correlation-id: 1bcff2cf-2fd2-4ae1-afce-08dd1f5caf5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?eWVWZFRDMW9CUEgxSG9UZEkyM1NmS2E5VTZ6WE5SeURaUjROTklvN3dWYXlr?=
 =?utf-8?B?RUtubWdkV3VJVDluVkJ4RlB0dmNQQ3VtM0ZDTlVNN2JhVjJEc3k4WXhLeC9N?=
 =?utf-8?B?ZkphNm15M3VtU1VoQmltendOcGpIaXo4S0V0RWxDeTlLQVd3aG8xeUFvdzVr?=
 =?utf-8?B?WmpPMzFlOEM5bnFPczZxcUpuTG1iYnVZK2piZkwvQk9EaUR2WjVGVTluZHJa?=
 =?utf-8?B?WlFaOUwvUk9hdE1VNnE3R1p6MDZWV29IK2dSMk9vNmdEZ0IwVnQ0OVRJb2JS?=
 =?utf-8?B?eHBlSjN4Wm9oaHBKdFNhL1d3Rm1aZXhLNlpzVjgvTWF2U082eklzVWwxeEZ5?=
 =?utf-8?B?aTBEY2RMbWVFdTRlTmlhemw0NUVtaUIveDNFRlE4WG53NnVrZU8wdXVueGF6?=
 =?utf-8?B?eG5PNVdtOXZSV1J1SStVK2l2dTA3QmtoV1hnSnZLVUtXeURqTkE1MUFVRG11?=
 =?utf-8?B?MnFsNVRYK3Q4OWFKOGlub0U1SW8veFRQa1E5MUVGYUo5djhFazRnWnpOdXVS?=
 =?utf-8?B?MEExeDdkUVVUZFFWeFJDR1h6bUlUN2ltaTk0NDZkWVdxK0tYSXk2RGtQclVE?=
 =?utf-8?B?dTVyN094RzNpSldzdlJVUlBBMmVxa1JZSVpRdTFsVk1DMUU3Nzg2T3gzVjQ3?=
 =?utf-8?B?a0lUTm1hUThKaS9sYy9NQnZjMkJUWHVxY0hTQ2huYStFQmRRYzFMbmNxbXc1?=
 =?utf-8?B?RXFhS1VPQUxWQ1dmb0ZWbFJGc3FYQmsyaS80UHAwbCs2NEVJTDdWQzM0bWFH?=
 =?utf-8?B?a1lnL1U1WVhGeVFCZFlQT2UyVWkwUGY0TlNSK0xtaXBHTTN6emRGR1Eva0xa?=
 =?utf-8?B?Y29IaCtTaW5sMm9Dc0xVYjJiT2s4UWdUSXBWbHZ1ZUZ0RnpRUmxFSzJXQzNh?=
 =?utf-8?B?d1NPSzdoenlQbFJqbXJsNHp1Umd1UDBLUTZSYk90VmtQL2x2M2o1YlN4bGx6?=
 =?utf-8?B?dDJmR2tLV3o5TkJUeW5DVjdnMUN5QXhpWlZHUVBkM3A4d2h4NldKK2l3aXBE?=
 =?utf-8?B?bkMxcUp4UW1EMGFuN2s5aEpuaWU0MVBVOWtCbXRQR0NwNGpvRUFvYXFaU1dq?=
 =?utf-8?B?QWkwYTZKNUlDdzU5SWJVQTJjVThUek9IenFTZUJ4Y0JTTTlpMUs0ZThFbW5I?=
 =?utf-8?B?a1FtWHFYRjhiOSt5dTQxM21aSDEzSGVJZHJvVEZkckR0eVg3SGowRCs2Y0F5?=
 =?utf-8?B?V2I5RkQyWlAybkxzK04zWkNnbXJTb2w4UFN4aDV2VTVyT21Gaklqajg0bStU?=
 =?utf-8?B?UzRRcnNKL0QzelIxWC9WSE45MGh0WmtkcTdyemtXMzFXMk1qM0VEZTVSN2Zj?=
 =?utf-8?B?T1JzODEyT0lkUmNoWXNNREYyYlowYVV0aU04Q1ptWnQzTnZUdXVDeFk4cEQ3?=
 =?utf-8?B?WUZJdnVpbFQ1VnNmeUZJaWtuTkhiQ2hFeFhuWGtsajRSS00zQ0hLYzBnbHBK?=
 =?utf-8?B?THU0aWRBcTkxYmpMcWVNREViMjNGZmgwbXF2aDJVdWFqZGcyR2g1d1pzaDA0?=
 =?utf-8?B?b2l1NGZXOVpnM01BV1E4bmU4UHZZZnJUblBaNWQra1NkM0hNL3ZXK3FpMzlL?=
 =?utf-8?B?Q3JiVlExR1RwdFhsUmliR1JjL1RxclZQRDBXRzZxeEQ2SmlxZUpZTXdGdWdk?=
 =?utf-8?B?cXlTb3RVbE45T1E4VE9uMnk4VXdpd0F0a0dWT3J2TEhPUUVybDlXV3RpMElj?=
 =?utf-8?B?b2dTVW5oSmFoQ3dveEdzYllxWWtFY2FBeHFCTmREVnFRQldzQzFXbkpUZHF1?=
 =?utf-8?B?TlRoOWZZWFRkQnBYZzcxM0d1bTA2dUNpRnhaNXNKZFN1RXVhYnNHaEtLcnov?=
 =?utf-8?B?SVpXaU0zWTVYWXhkank3V1ByYVZZZWZiQ0NqN09iamk5K2ZDb2RvUk9nMzRT?=
 =?utf-8?B?WmswVnJTSFlYODNWSHQvSXMvR09rakFtNFhlSWEvOUNQOHFvbDkvd0huQUFV?=
 =?utf-8?Q?xkQ2eha8VsfuI782gQhjuv5Bl12LgoGg?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RktqV0tmcEowdUxVMzArT1p4SmtuOEtybEpvM2M3KzFiaitzV011dUtyZkVU?=
 =?utf-8?B?NG1qTDY5Y3haSm0zWmVGU0lnNGUwK2JOZnVaOWpqRlM3UmNsN01mN05TSGlR?=
 =?utf-8?B?SDRPcjUrekY3K2dPWWNzdDZ4OG1sRmxDZ3BaeSt0RTEvSnZkWG5BVU1XYWpy?=
 =?utf-8?B?Z1E5WEpzNXN1clY1SCtHMHcwbXNBeFpidkFxWmhQK3RsbUh2ckxRd2lOTjZy?=
 =?utf-8?B?dU9COC9VUTRIVVUwYzhCckM3eDVXdVlwUDd3cnJyL1J0Y2tEVm8xd3FPMmZL?=
 =?utf-8?B?ajB1Q00wQkJKSExyRmtxak5iWnlXNmFyazQyOHJ0TlNTOXUrRUpxVVQzd1pK?=
 =?utf-8?B?TW8rL1BRM3VFRWFyc3ZFQWNGaWUxb0pvejd0S2dHZ3o4SEdsR25UaWtCN3R5?=
 =?utf-8?B?UzlYMkh6WW0xTGM2RVZLOXhkSnB4cUFLb2VYUWpTbWZyOHp5S0RlcWxtNWJi?=
 =?utf-8?B?bXF2TFVSS3ZpdjRHbGZ3OFdrU3pEQzFZbEZHUWNsRnJ5Y3RyL2M5NGR5VzdW?=
 =?utf-8?B?TzNQYUhnZ2xYVXVvb1lzREh1T0RNcUNEMGQyNDQ0aVhJYkg2YVJZanphb2lF?=
 =?utf-8?B?Wk5GUmxlRUkvM3BWVkJPZHhlZ014dHI5aFBwcUViTVJuK0pXRFlvYXIrbUxN?=
 =?utf-8?B?bGNqb2lvSUNYeS9BZzJmZmYvTVNOaVc4ZDZvMXBwbWtsRWRmMHlibWZmeEx4?=
 =?utf-8?B?ZHhkZGxKdGFDNndzQVhDQ3EvcitXdGVyY25tendWVXJvNjNCMU1tR2xLenBt?=
 =?utf-8?B?VUdUQ05EWW9zK2x6cDJVVnVRMUs3bG02MmNYMjZzakk3YVJXcGRIdmdPVWtx?=
 =?utf-8?B?RjI1bGpPSEF4R3R0RHdEVUNodG0zcjVTK1dpbmhJdDB4aWVFMlYrVzRtMUZS?=
 =?utf-8?B?SklyODRGMm1UQkp0ZzE3NmtJYWZEVEtnN1loRnpNVUcxeUpTUWRDSU1QcmtN?=
 =?utf-8?B?VWlSYktucUxhQ2R3eW5mRHpxOCtQQWpZcVRyZFdoNkVFTWlPRngwZWFtWlBu?=
 =?utf-8?B?V3A1bVJjVlA2MjVCdHpzRXlCT1dpVGFEdlV3WEhQWmJaVCtCQUtDNDBhUFlG?=
 =?utf-8?B?alNRcWVPUVdIR3hpQTFKbnA1aEhXVm1ZUkNBMHBIUHBIcmRkRE0vdkZ6OEpK?=
 =?utf-8?B?d0xGMVY5aFRISitCUEF5bTE0aXFGeFJtSXRnZ3dEZzgyd2VCU2JaSklLME1u?=
 =?utf-8?B?NUlVeEVFUDlwN0xzOHlNR3hFdVY2NXVzeGZUckI5c1FCUzhabU5kTEVOL09P?=
 =?utf-8?B?cGdIRGlNWW8yVlpnc2tXUDlFYW9NZithUHVvYjNTVEgyczM0Qk5uVEd6MTRi?=
 =?utf-8?B?K212djFVK0Q0eVFZUFVFNUF3dGZ5TzM3YnlkZkF0QThPbVJpWnhtQ2RjaUE0?=
 =?utf-8?B?cnhTK1pIVHN0RUxaUC9Vd0NzWGhzT1kraTBqdlVsaVFqbUJyU1dIM3J4djQv?=
 =?utf-8?B?bW1QT2MzYXp5dW9tU2daNkNsYXNKdXJFRE9ETUNBYWlHME92MXo4U0ZST1NK?=
 =?utf-8?B?SmlJNHd3bzBwb1pZVkpzVkdHNUVKN29vbXdMMERid3RxVGZFYnorenhrMXVJ?=
 =?utf-8?B?NWJ5UGcyekJvYmkyelBObHRnM2ZyZGhVY3hSZ2EwSk9jQnpzNmQ1WEZuNWM2?=
 =?utf-8?B?Z3ZRS2wwRDZVODd5Q2M0V2JVaFd1WldwQ3BFL1FiN3JjZTlrc0t0R2hmbjJu?=
 =?utf-8?B?QXdudmFhVDJ3cjc2aTBHRTlNdzdnSTVyZ0N5SmxhSk8vOVpnRmlEZ3JyTllq?=
 =?utf-8?B?WFFoenQydGw1bFVLNXczWStCczF3LzZtWFVtMWZiNURMdkpYUTZHaXRpdzhK?=
 =?utf-8?B?dk9RQlA0bkI3Q2pnT0dkRXR2TUFlRnBqL2lnZ2lxV3lMRmZ1RktyeVpScVl6?=
 =?utf-8?B?Vk80bVk4U0xXS25WK1ZCVmdvUkFRUWNyQndYaEhUSnZVTHhyVlB0QmNlVk9t?=
 =?utf-8?B?dERpaGt0SWNtVVl5NzhXNkl1K0s1QUxvdXNOQ2oyVE04THl5bjlPL1BqQitm?=
 =?utf-8?B?MElHUGRiSnJPL1c0TVNpT0NuQ2RyaW5va0NGSDRoTklXQVJyOFhCSEY4ZE9s?=
 =?utf-8?B?YVlEMHlDTURadDYwNCttTGFKTXJLT3gzQlZyZHpQVFR4RjBXcitSSzEzTldG?=
 =?utf-8?Q?4i94=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bcff2cf-2fd2-4ae1-afce-08dd1f5caf5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 12:08:29.6025 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sh6knHNplpR7tuKOhqD7jAnl1qD4N/067eym+eTpcdT8PbITqBUf+pxkHvbm82DN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8343
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
Cg0KPiBGcm9tOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIERlY2VtYmVyIDE4LCAyMDI0IDQ6MzYgUE0NCj4gVG86IExpYW5nLCBQcmlrZSA8UHJp
a2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IERyaXZlciBuZWVkbid0IHJlcXVlc3QgUkxDIHNhZmUg
bW9kZSBmb3IgZ2Z4DQo+IE1HQ0cNCj4NCj4NCj4NCj4gT24gMTIvMTgvMjAyNCAxOjAxIFBNLCBQ
cmlrZSBMaWFuZyB3cm90ZToNCj4gPiBJbiBhY2NvcmRhbmNlIHdpdGggdGhlIE1HQ0cgSFcgc2Vx
dWVuY2UsIHRoZXJlIGlzIG5vIG5lZWQgZm9yIHRoZQ0KPiA+IGRyaXZlciB0byByZXF1ZXN0IHNh
ZmUgbW9kZSBiZWZvcmUgZW5hYmxpbmcgR0ZYIE1HQ0cuIEZvcg0KPiA+IEdGWDEwIGFuZCBsYXRl
ciB2ZXJzaW9ucywgbWFpbnRhaW5pbmcgc2FmZSBtb2RlIGlzIGFjY2VwdGFibGUgZm9yIEdGWA0K
PiA+IE1HQ0c7IG90aGVyd2lzZSwgdGhlcmUgd2lsbCBiZSBhbiBpbmNyZWFzZWQgb3ZlcmhlYWQg
ZHVyaW5nIHNhZmUgbW9kZQ0KPiA+IGVudHJ5IGFuZCBleGl0IHdoZW4gZW5hYmxpbmcgb3RoZXIg
R0ZYIGNsb2NrIGdhdGluZy4gU28gbm93IHRoaXMNCj4gPiBjaGFuZ2Ugb25seSBhcHBseSBnZng5
IGFuZCBnZng4LCBhbmQgd2l0aG91dCBwb2xsaW5nIHNhZmUgbW9kZSwgdGhlDQo+ID4gdGltZSBy
ZXF1aXJlZCBmb3IgR0ZYIE1HQ0cgZW50cnkgYW5kIGV4aXQgd2lsbCBiZSByZWR1Y2VkIG9uIEdG
WDkgYW5kDQo+ID4gR0ZYOCBzeXN0ZW1zLg0KPiA+DQo+DQo+IFRoZSBvbmx5IHBsYWNlIHRoZXNl
IGdldCBjYWxsZWQgaXMgKnVwZGF0ZV9nZnhfY2xvY2tfZ2F0aW5nKCkuIFNvIGl0J3MgYmV0dGVy
IHRvIGtlZXANCj4gYSBzaW5nbGUgc2FmZSBtb2RlL2VudHJ5IGV4aXQgZm9yIHRoYXQgcmF0aGVy
IHRoYW4ga2VlcGluZyBpdCBzZXBhcmF0ZWx5IGZvciBlYWNoDQo+IGZ1bmN0aW9uIGNhbGwgd2l0
aGluIHRoYXQuDQo+DQpZZXMsIHBvbGxpbmcgdGhlIHNhZmUgbW9kZSBzdGF0dXMgcmVzcGVjdGl2
ZWx5IHdpbGwgaGF2ZSBvdmVyaGVhZCBvbiB0aGUgR0ZYIGNsb2NrIGdhdGluZy4gRXZlbiB0aG91
Z2ggbWdjZyBhZnRlciBnZng5IGRvZXMgbm90IHJlcXVpcmUgc2FmZSBtb2RlLCAqdXBkYXRlX2dm
eF9jbG9ja19nYXRpbmcoKSBjYW4gdW5pZm9ybWx5IGVudGVyIHNhZmUgbW9kZSBiZWZvcmUgYWxs
IGNsb2NrIGdhdGluZyBmb3IgdGhlIHNha2Ugb2YgY29kZSBzaW1wbGljaXR5IGFuZCByZWR1Y2lu
ZyB0aGUgdGltZSB3YWl0aW5nIGZvciBzYWZlIE1vZGUgYnkgb3RoZXIgY2xvY2sgZ2F0aW5nLg0K
DQo+IEZvciBnZnhfdjguMCwgc29tZWhvdyByZWZlcmVuY2Ugc2VxdWVuY2VzIHVzZSBSTEMgc2Fm
ZSBtb2RlIGVudHJ5L2V4aXQgZm9yDQo+IE1HQ0cuDQo+DQpUaGFuayB5b3UgZm9yIGJyaW5naW5n
IHRoaXMgdXAuIEkgd2VudCBiYWNrIGFuZCBkb3VibGUtY2hlY2tlZCB0aGUgR0ZYOCBNR0NHIGVu
YWJsZSBzZXF1ZW5jZSByZWZlcmVuY2UgY29kZSBhbmQgc2VlbXMgdGhhdCBpdCByZXF1aXJlcyBz
YWZlIG1vZGUgZW50cnkgYXMgd2VsbC4gSSdsbCBmb2xsb3cgdXAgd2l0aCB0aGUgUkxDIHRlYW0g
dG8gY29uZmlybSB0aGlzLg0KDQpSZWdhcmRzLA0KICAgIFByaWtlDQoNCj4gVGhhbmtzLA0KPiBM
aWpvDQo+DQo+ID4gU2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5j
b20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMg
fCA0IC0tLS0NCj4gPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIHwgNCAt
LS0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgOCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jDQo+ID4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jDQo+ID4gaW5kZXggYWY3M2Y4NTUyN2I3
Li42OTAyMzVkYWZlYzEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3Y4XzAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
OF8wLmMNCj4gPiBAQCAtNTYzOSw4ICs1NjM5LDYgQEAgc3RhdGljIHZvaWQNCj4gPiBnZnhfdjhf
MF91cGRhdGVfbWVkaXVtX2dyYWluX2Nsb2NrX2dhdGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiAgew0KPiA+ICAgICB1aW50MzJfdCB0ZW1wLCBkYXRhOw0KPiA+DQo+ID4gLSAgIGFtZGdw
dV9nZnhfcmxjX2VudGVyX3NhZmVfbW9kZShhZGV2LCAwKTsNCj4gPiAtDQo+ID4gICAgIC8qIEl0
IGlzIGRpc2FibGVkIGJ5IEhXIGJ5IGRlZmF1bHQgKi8NCj4gPiAgICAgaWYgKGVuYWJsZSAmJiAo
YWRldi0+Y2dfZmxhZ3MgJiBBTURfQ0dfU1VQUE9SVF9HRlhfTUdDRykpIHsNCj4gPiAgICAgICAg
ICAgICBpZiAoYWRldi0+Y2dfZmxhZ3MgJiBBTURfQ0dfU1VQUE9SVF9HRlhfTUdMUykgeyBAQCAt
DQo+IDU3MzQsOCArNTczMiw2DQo+ID4gQEAgc3RhdGljIHZvaWQgZ2Z4X3Y4XzBfdXBkYXRlX21l
ZGl1bV9ncmFpbl9jbG9ja19nYXRpbmcoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYNCj4g
PiAgICAgICAgICAgICAvKiA3LSB3YWl0IGZvciBSTENfU0VSREVTX0NVX01BU1RFUiAmDQo+IFJM
Q19TRVJERVNfTk9OQ1VfTUFTVEVSIGlkbGUgKi8NCj4gPiAgICAgICAgICAgICBnZnhfdjhfMF93
YWl0X2Zvcl9ybGNfc2VyZGVzKGFkZXYpOw0KPiA+ICAgICB9DQo+ID4gLQ0KPiA+IC0gICBhbWRn
cHVfZ2Z4X3JsY19leGl0X3NhZmVfbW9kZShhZGV2LCAwKTsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0
YXRpYyB2b2lkIGdmeF92OF8wX3VwZGF0ZV9jb2Fyc2VfZ3JhaW5fY2xvY2tfZ2F0aW5nKHN0cnVj
dA0KPiA+IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGRpZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92OV8wLmMNCj4gPiBpbmRleCA0YjUwMDZkYzNkMzQuLjZkZWM1MzgzYmExNyAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+ID4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KPiA+IEBAIC00OTY0
LDggKzQ5NjQsNiBAQCBzdGF0aWMgdm9pZA0KPiA+IGdmeF92OV8wX3VwZGF0ZV9tZWRpdW1fZ3Jh
aW5fY2xvY2tfZ2F0aW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ICB7DQo+ID4gICAgIHVp
bnQzMl90IGRhdGEsIGRlZjsNCj4gPg0KPiA+IC0gICBhbWRncHVfZ2Z4X3JsY19lbnRlcl9zYWZl
X21vZGUoYWRldiwgMCk7DQo+ID4gLQ0KPiA+ICAgICAvKiBJdCBpcyBkaXNhYmxlZCBieSBIVyBi
eSBkZWZhdWx0ICovDQo+ID4gICAgIGlmIChlbmFibGUgJiYgKGFkZXYtPmNnX2ZsYWdzICYgQU1E
X0NHX1NVUFBPUlRfR0ZYX01HQ0cpKSB7DQo+ID4gICAgICAgICAgICAgLyogMSAtIFJMQ19DR1RU
X01HQ0dfT1ZFUlJJREUgKi8NCj4gPiBAQCAtNTAzMCw4ICs1MDI4LDYgQEAgc3RhdGljIHZvaWQN
Cj4gZ2Z4X3Y5XzBfdXBkYXRlX21lZGl1bV9ncmFpbl9jbG9ja19nYXRpbmcoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYNCj4gPiAgICAgICAgICAgICAgICAgICAgIFdSRUczMl9TT0MxNShHQywg
MCwgbW1DUF9NRU1fU0xQX0NOVEwsIGRhdGEpOw0KPiA+ICAgICAgICAgICAgIH0NCj4gPiAgICAg
fQ0KPiA+IC0NCj4gPiAtICAgYW1kZ3B1X2dmeF9ybGNfZXhpdF9zYWZlX21vZGUoYWRldiwgMCk7
DQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0aWMgdm9pZCBnZnhfdjlfMF91cGRhdGVfM2RfY2xvY2tf
Z2F0aW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+ID4gKmFkZXYsDQoNCg==
