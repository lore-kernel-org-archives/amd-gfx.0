Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB5EC369A1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 07:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C21E389C29;
	Tue,  8 Apr 2025 07:22:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HxsGkv35";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F2BA89C29
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 07:22:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxJgQVOkv2lmkL+nW27g490WDUNu8UZ8pFQMwSPID3pSNwvJr8czvyb//HBKh6XclQUMqO5BfqrU7LRu5++ziSQDToupKP1/SB1QEodHg/Z2IBNP736xTRuJA71zQPU7XOiSlJx6Ayvk8MtumowatRGZeAXQdnebp8RPenBv7ufqDxatWmdwfU1NEz0RImGoKuHIugplnPnUyojsbzsArb/J0Dpu6+ZBg9bMnvkLHCYoaVFZyheou1+AyPYfbV9XqmtED1UlD3dAW66c0KPYFQ8jaoRkv2FK/00FfJC3buHarVI2gwespkJlXYhGSf6YIUS7MMgAnZtAsfk4XlTzXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QeMD9wdN/mQg3jPxp88R/FBmKBOpFrJTwUZlRxR2F4=;
 b=KJQnVdEqTu+AHUmrDTmHIg6DIOcsgNYHJCM588rQMPZZZrD74IXfZUgCOlHSC5cOP5LogzcfGa0EDo/hMylbt9qaqi2WnCxpqVyPqs9o7B8vM+L8KSa+Q8CV3Y8bwNHHKMriKqiKQKQQighFr6geWywEAAd0RTZYqMphzhebRpjgbGc9RhTfLGQ3ivs2onUDvj7GA0scjBWriG+hnwrHhnGlM7akr8wJ1GWfRu8YRr1k+Mf/3+CRLfDRTpHxYDq/zj1aiReAnwrW+5VGTSmC93qHALUL/RVfNHk6zdIj118woeTMo2/h/gDI4MBwhM1imgRH+yWqG93iIrfmhzd82Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QeMD9wdN/mQg3jPxp88R/FBmKBOpFrJTwUZlRxR2F4=;
 b=HxsGkv35NPG9fU33P9GPVj3R+mT61QGi5ZobsNWuJ1xkwttX/8QrDInAXM8N9kTES0/RPwi0TDz73/DNkQlADhAFeWJIShUv0yyzGlTw1KlrLoKm2VC/ux7uz7Ck8Gx7uEilqE2PS7t+AskKRee6VsuPC2MjrDl8KWDyjbRYPe4=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by PH0PR12MB8029.namprd12.prod.outlook.com (2603:10b6:510:26c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 07:22:53 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%3]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 07:22:53 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix the comment to avoid warning
Thread-Topic: [PATCH] drm/amdgpu: Fix the comment to avoid warning
Thread-Index: AQHbpHc/GwmZvsJrnUqtgS5IqH1iCrOZZJSA
Date: Tue, 8 Apr 2025 07:22:52 +0000
Message-ID: <IA0PR12MB8208B50D9728C742A40F863F90B52@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20250403072910.555319-1-sunil.khatri@amd.com>
 <cc217826-180b-491d-aa49-0dff073b8f99@amd.com>
In-Reply-To: <cc217826-180b-491d-aa49-0dff073b8f99@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=38b6a7e3-0d95-4bca-8d93-bfe85b2e7096;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-08T07:20:50Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|PH0PR12MB8029:EE_
x-ms-office365-filtering-correlation-id: 81dc6d67-e816-4088-82ff-08dd766e2cf1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Z3NmNkhqeE1PMnJKUEZiQVk1MURLUTZjc2xHdDNMWEtYMGxvK2YvSVEraGRs?=
 =?utf-8?B?K0lHOE16emk1dzF0UTlaZXVGbWpUMVB3QmlrME80YTZRMGZjMU9LbjdhVlQ0?=
 =?utf-8?B?TmtjdVRHcVI1Rll5QWdtcS80RFpmMElNc0lmK3M0MUYxbU1hQkp6Q0ZvaXk5?=
 =?utf-8?B?SnR0TWJSVi83STZKd2hJT3IydlorOHBxNlBOMUJ1UkhXakF0WEV0ckFkNnZy?=
 =?utf-8?B?TVd4dzNBaFhVRk9YaHEzM2VRVGpIMFBlR1EzSGlORkgwczhrOFFEM3B0TTBN?=
 =?utf-8?B?a0xxaDBVUm1ubXllNVZ2aHhqaHYvcEVJSER3QjFtbEk0MExRYnZ2Z2NmZStq?=
 =?utf-8?B?ZDRJeE1lWmllaHluUmw0clNlQWdoSXkzTmxFeGtTVWc4SlRVWTVWUkJETDN3?=
 =?utf-8?B?cUZOYVZ3WnliNW9wUzRBTEZhNVl4by81S1pnSUNnc1dDbjdOVDdFY3AyVVZY?=
 =?utf-8?B?UFZhdWpVcXhQN20yUGVPNHltWk5FVW5GWE1sRHpqNkJKSHpsUnVRSXIxYVZR?=
 =?utf-8?B?THVWcmRndXFNM1JXUFQ1V0ZtNG5LUkpQOGFsTXQvSG9JRVgxL0w1Y0szODdi?=
 =?utf-8?B?RHZtNXlURDJiUVBlNlpGUEROL0tTeDRxZWRad1NsbUtKNUJHZDZsNU5haFcw?=
 =?utf-8?B?WkhQci9tWVQ3SnFwZXpIMHk4S1lTSW1za2tGOWNyRWExRitnNnVrY0Z5WUFR?=
 =?utf-8?B?dmVNUWFXeUFyV2hNSW1Bc1JGSGhGdFAyUHhSZi8rRHRDSStKOXBXRVEwR2lI?=
 =?utf-8?B?eFNnQ1dxaFg3V3ovbFpvZnBRL0dkUVpqL3djV3BlWU9WWFplaCtlNkpPSlJE?=
 =?utf-8?B?VlRFcjdtK3R5bEZhekVNN29tNkJYQmxPczFIVFcxMmcvVVRxNzJiOGc4SnFp?=
 =?utf-8?B?Sy94Ymlrb1V6b21xU09jS2thSkVJeUF6M01QTEVlMGhKNml6Mkt1R2UvS3Bz?=
 =?utf-8?B?QVB6S2VwVXdMK0xlWDRkcTI1RzNXaGkrSXp6dTFwVWFnV2h5K1JKdmpaUzlm?=
 =?utf-8?B?TzNkUW9aMGtSbllaeStBeDJnUlBHaDJCeDdqNHA1UU1tOEZEOGVXS0R5UjVU?=
 =?utf-8?B?cGZZQWE3KytVeVZSOHJDQmlweU1oaTRkZmlPbGxMSHpENlJMTUJZcjZqdXpy?=
 =?utf-8?B?M1VuYTVyU1Z6cm5GdkgxOUdiT1YzYjYxb1ExbzZjZC95bHZ5T0xUQ3pDK0lF?=
 =?utf-8?B?R0lZODZlWEYrRUlHUkhBWnV6R29Pdi9DN1RHdUxXcDZvclN2Sk1UZUJ3Qldu?=
 =?utf-8?B?S3RyYytKcnBwVTQvYlIxOFY5dCtId2prV3lsSHJRRHY2RkxVTU9rUU5Id3V0?=
 =?utf-8?B?MjZtd1VsQ0E4QUhMaUJYc1o0MUxBVGNVRUdxK25wbzdEcGw1UkdNSkZMRHFI?=
 =?utf-8?B?SVdrTThkVkplNnBtSE1RY2htRHZXTWZyaGNFbDlSWEJIVGRlM0xXbXhuT0hN?=
 =?utf-8?B?U2d5c01nZitoMXRhbE1YRFQ4U1NJN2JWZ3dqclVwcDBvTnptS2RrMGtpYURK?=
 =?utf-8?B?bzZMNHVvWVByMjRhQ1dNUjd6ODMzREJrdmlQdmNiN3d0T2gwb0NjY2pQcE9M?=
 =?utf-8?B?MTVVY2FZZ0hrZHJOd3JEMFoyTTE1TWFNcE1xOGNIUFJDWGlZZmJIWnhuRk1p?=
 =?utf-8?B?UVE5WjJNTC81d2JZYysyaTJPUlhIaUluQTNrR1MxMm1KNmRrYVZjeDBITDVJ?=
 =?utf-8?B?K2ZCcVNiMnRoWFhQd0lCcTFaWTJEekxSYy9weGJyanpOK2wxTjRieVlSZkRB?=
 =?utf-8?B?b2s1MEtVWUYxL0NLR3Nab0l3SytNTWxNM3BYVFFYZ0pwYW5uOW9COUN6emRz?=
 =?utf-8?B?MDlnWXpLNFdxRDEvaFRXcGViekJPaWhxK08xU2RKcGp3cXlyamJENW43OWtX?=
 =?utf-8?Q?KGpFWi9IgOEnn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MllGTXc1SjNDQnFLNVU1NXdRUWRUNThyYU40bEZ2MlB2RFE1VGZsWG9uWUZZ?=
 =?utf-8?B?bG9qWDI0eVg1T0dvQ29GNnQ0S3RBcVpYMFhFZEl3OFlqd3gvWG1IUGtrNy9m?=
 =?utf-8?B?VW12Z1FYUlBXUnBBdVRWS3UrS0J6OWpKQUt0UVpDK2Jwb1dKNndqQ2c5ZGc2?=
 =?utf-8?B?K0RVMGlGbDRkajNoTldoUy9UNXY1TzlrbzVXWGpTNklFeTZaSHlDcit3cHVO?=
 =?utf-8?B?TWJjSUY4Q3UzaWtNS1N4dlNad1RMbC9zZ01Ud25JUlp6SDh3My9WWmJGTk82?=
 =?utf-8?B?aS9UcWJEQUhQckF2UUs3d0ZwckgvZHRaOWczTDlVN28xVTViUy8yNy8zdHBN?=
 =?utf-8?B?NW5SWjhZdzF0VGEraDRETGpOaFJXeTAwZ3FMUzZMdkdiV3BPYVpXaytiQkFO?=
 =?utf-8?B?TU9ZVmJmSXJHOHYraFhML0pjbkNQUFJIQ3BpalJVZ3RhVmFIejQ4UzQ4ZGph?=
 =?utf-8?B?NFJHbGsreFg2MXliSkwvSUtFRUZ3b1I5bDhYTVIreXJCc2p0ZmpEcUh1dk1t?=
 =?utf-8?B?blNTa0k5MGdmTzV4UEN5Q2xlVHVxMzdxNk4zMzdTUVJET3pKMTdBNVJ1RThC?=
 =?utf-8?B?VURFcEFwYUl3dXJMTUZ6S0dSVkxtMXF5d3pYS3NsTVRmMTA5MTc5RDhMTE9a?=
 =?utf-8?B?R1ZyNDJkSlJIekFlOXp3VHRyWG9aRlM1Z3E3Y0NyTFVKMkZrLzJvOHVrd2ho?=
 =?utf-8?B?Snd0YmFPS1BSYkVCcW5HdDlXem9CY05WdC84cmFLWTZWc01mdzNWNkNibS8y?=
 =?utf-8?B?c1BzdHhiVGdXR21Xa3doVzZSM2RvMzAvYi9UVU9QY3k1VDlCMXRjMzFzNFlY?=
 =?utf-8?B?WXJQQU9EcXg4SnhMbnlrd1ZDZ2FZUWR3RlNRU0h3V2hjN2ZjMjVkWVV5TFNP?=
 =?utf-8?B?R2xRMHB5WUN2NGsvRHJiYUpxV3drclBDWWxxbkxCWEU0SFl0TkwyMzZIWEs5?=
 =?utf-8?B?czNGcEZrcGFVRVVYcVhiTjEvZUNTWWYwS3d5NEdsRUZ6aW1oQXdrRTdvYjJ2?=
 =?utf-8?B?K09ySW5XWDlCZVlaV1k3UXZpZ2loM3JSVWxyNDh2N1M3VDJyNHo0dlFyNDdD?=
 =?utf-8?B?WHBXVFczRzg1VXBDVFdKdy9kOEszOFZkYTZUazErQVdPbk5tN0pCNGJuYXBQ?=
 =?utf-8?B?eXlXeTdhdWFscjNscDJqUWE0SHVDODFqeFhrc0xuTHRDTUJFMk43OE1NWnJx?=
 =?utf-8?B?VTFhcGNKL0VFSm1kblE1NTBXeGl0b2srbEl3U3NnTXFzUFVnMHNvUVgxM0wy?=
 =?utf-8?B?MlhSUEZ0bG5EUUhuU3A3MjNmK2Z2a0pHSEw0Zm1Vc0FENUdUWitVNGtXZW9S?=
 =?utf-8?B?bzNWTEJuTk9VdzZoQlQ0d0ZXWldWdFNycU9heURaM05FSXB5d0Q3cU1nOTRs?=
 =?utf-8?B?aStZOWRpcTdYcHV4My90L0FwUHhHQWdCbi82R1BnekVEVEw5eVVNSHhyYkRx?=
 =?utf-8?B?QWU5UFI1L3NjOTdRbUI0SUMxTVhyYWQ3VDhUWlhFMk9ERnR1dHpFejRtOTJW?=
 =?utf-8?B?WDZzRDlxWUVjNytCcGVaNlV5bnlUeEYycjIrcTBwK3labzNnbnh0UVFiMWpu?=
 =?utf-8?B?L1J2K1d1VHdHNFRVZG41RzRrWUFaZVkzVDN3dVZxTFVCb25UQ2o5ZlRzMUdW?=
 =?utf-8?B?ekQvaDFNUHNTNjV2amhxUkIwcTFMZ3pGMHVlbjN6YUY1ZWRCaFZ6NzNEWFF1?=
 =?utf-8?B?U0JPUXpNNlNBS1BwbUIyMWdlVmdsclJtb0kvd2VuQzV3MUZ3TWJYekZod1ph?=
 =?utf-8?B?ZE5mLzlsME03STNoWFZKQUZEUTlYSjVZb2pSV2RUems0MTE4WUhCbjZXRmc2?=
 =?utf-8?B?MGhJaG5QTU1Hb0ZPLzgwS090T2p3R2xPRFNVWEV4ZFowd2YxMEFQa3g4cVVU?=
 =?utf-8?B?bXBUcWEybHNHbVBaa2VFdE82ZVVHeTE5VXRPV3F3Uk1zYm5zeG1LU3ZHZHJy?=
 =?utf-8?B?ZisxeXhyMEIzUzRCVzhPTzJXeXBCZTBrQjMwbjRWR0FoRnVjZnc2OGFSQzZO?=
 =?utf-8?B?Sk5XeTBMY25DZ0ZseGlZbDlzR2daU1NFQ0VQQ1JMNjNHSWJLK2o5TlFvenZq?=
 =?utf-8?B?WjhydHhJaWM1SllHQWc3V2YzZjBHZjlvNmR3MHFyU0hzYmFPVXRMN3ZPTE5R?=
 =?utf-8?Q?ibag=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81dc6d67-e816-4088-82ff-08dd766e2cf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 07:22:52.8577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4cnPjllcK3c0JQgMCdDTenGqwuEL2/0vHSNIbGJccCfeAGLnT2byrdV+7VctUTm/dCO86iFkkzT5OpSHdaCW6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8029
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
Cg0KVGhpcyB3YXMgc3VibWl0dGVkIG11Y2ggYmVmb3JlIGh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVk
ZXNrdG9wLm9yZy9wYXRjaC82MzkwMDQvDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBC
ZWhhbGYgT2YgQ2hyaXN0aWFuIEvDtm5pZw0KU2VudDogVGh1cnNkYXksIEFwcmlsIDMsIDIwMjUg
MjozMyBQTQ0KVG86IEtoYXRyaSwgU3VuaWwgPFN1bmlsLktoYXRyaUBhbWQuY29tPjsgYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBGaXgg
dGhlIGNvbW1lbnQgdG8gYXZvaWQgd2FybmluZw0KDQpBbSAwMy4wNC4yNSB1bSAwOToyOSBzY2hy
aWViIFN1bmlsIEtoYXRyaToNCj4gRml4IHRoZSBiZWxvdyBjb21tZW50IHdhcm5pbmcNCj4gZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3NkbWEuYzo1NDE6DQo+IHdhcm5pbmc6IEZ1
bmN0aW9uIHBhcmFtZXRlciBvciBzdHJ1Y3QgbWVtYmVyICdhZGV2Jw0KPiBub3QgZGVzY3JpYmVk
IGluICdhbWRncHVfc2RtYV9yZWdpc3Rlcl9vbl9yZXNldF9jYWxsYmFja3MnDQo+DQo+IFNpZ25l
ZC1vZmYtYnk6IFN1bmlsIEtoYXRyaSA8c3VuaWwua2hhdHJpQGFtZC5jb20+DQoNClJldmlld2Vk
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQoNCj4gLS0t
DQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc2RtYS5jIHwgMSArDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zZG1hLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfc2RtYS5jDQo+IGluZGV4IDBhOTg5M2ZlZTgyOC4uYzNjNmYwMzE5MGM4IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc2RtYS5jDQo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zZG1hLmMNCj4gQEAgLTUz
MSw2ICs1MzEsNyBAQCBib29sIGFtZGdwdV9zZG1hX2lzX3NoYXJlZF9pbnZfZW5nKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X3Jpbg0KPg0KPiAgLyoqDQo+ICAgKiBh
bWRncHVfc2RtYV9yZWdpc3Rlcl9vbl9yZXNldF9jYWxsYmFja3MgLSBSZWdpc3RlciBTRE1BIHJl
c2V0IGNhbGxiYWNrcw0KPiArICogQGFkZXY6IFBvaW50ZXIgdG8gdGhlIEFNREdQVSBkZXZpY2UN
Cj4gICAqIEBmdW5jczogUG9pbnRlciB0byB0aGUgY2FsbGJhY2sgc3RydWN0dXJlIGNvbnRhaW5p
bmcgcHJlX3Jlc2V0IGFuZCBwb3N0X3Jlc2V0IGZ1bmN0aW9ucw0KPiAgICoNCj4gICAqIFRoaXMg
ZnVuY3Rpb24gYWxsb3dzIEtGRCBhbmQgQU1ER1BVIHRvIHJlZ2lzdGVyIHRoZWlyIG93biBjYWxs
YmFja3MgZm9yIGhhbmRsaW5nDQoNCg==
