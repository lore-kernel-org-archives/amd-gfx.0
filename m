Return-Path: <SRS0=TGuI=LZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77119C11F64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 11:37:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35C756147D
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 11:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C756147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAA2B6E199;
	Thu,  1 Jul 2021 11:37:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2041.outbound.protection.outlook.com [40.107.96.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 829916E13A
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jul 2021 11:37:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLeyKtRccBTys01bYqVu+LDn0P/Qe8jbyxdqGBFvDmywujFk2h2fK96p5lr/ye5OPPDd90N0Hs8lb8VrpsGv73GeYlJrEaUrqh+qVO9slxW7Idiym4B0z8w9t6n3Zh79zzwjJMbEnOG4mFRJDvJ2V31h0S1hyx1M8w0P5WYyYm4GcP7OvB07G9SF0C7zWcmY+Be3/qlY1I0XvbN5VFxKYehKzTfY/55Xwn3V3NuIun1UgsunjPihHmYyQmMhc1e1izqOGwWMVvcVTIqSSjFLbzzeldSjfGqkN1xafnI1ak+6MVmHFVOw8bcs4Tf6yyNNDSz57wLMDwBTq/XbcGzCtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RCG2fXKZgTrrXX17SWSYl5r6IOc8qYsbw/5UWWndGA=;
 b=RlixZzunw+djiyZf3JfuSaFbA722Dm6aYYUF9q58QBz+NV9fqRz81vU2+tJbQ01uMxI2gOu5xVjyBIf1qTRl43muJjusYIJbfvEeO/e1WoM4pTpQG7zLKMyi2HBptxHXGQ8SXUUmfX9IyCL1hWo1UWnGewSk2CL3hIZOjFlZajny+S4g3CdFxccytd9/dpGsOFEVXfvtx7UqP4k5k5Crbz/hqXq2tfKF5nh548vWkmkIz10DN8U/rt+xzAyu2LU25YN+du/3zmSSz1cIVASiXShk6/BuxvTojBNzUXAkNRFnTl+ImXuZ3xCjRkepzwMbjepfj+2ShAwCXKfXxHxpdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RCG2fXKZgTrrXX17SWSYl5r6IOc8qYsbw/5UWWndGA=;
 b=NFC/tOPcAhoMpiKOgKAyexEzOgnn/xmS87Q3Qsjmxr5kUTANsibMLGLIvm+HXF0ACWi54S2FWJPpXqszE1X2/EtmvTNkc1PYVS9vEQsqN98BOreZ/ZwQ1+A7V6c0NgJc3F0oy+aCGx1FCVdwwqes1tJqbGlsLA7dnUEM7xrkYmw=
Received: from DM4PR12MB5086.namprd12.prod.outlook.com (2603:10b6:5:389::9) by
 DM4PR12MB5085.namprd12.prod.outlook.com (2603:10b6:5:388::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22; Thu, 1 Jul 2021 11:37:46 +0000
Received: from DM4PR12MB5086.namprd12.prod.outlook.com
 ([fe80::e499:4d1a:65e7:f167]) by DM4PR12MB5086.namprd12.prod.outlook.com
 ([fe80::e499:4d1a:65e7:f167%3]) with mapi id 15.20.4287.023; Thu, 1 Jul 2021
 11:37:46 +0000
From: "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Liu, Aaron" <Aaron.Liu@amd.com>
Subject: RE: [PATCH] drm/amd/pm: drop smu_v13_0_1.c|h files for yellow carp
Thread-Topic: [PATCH] drm/amd/pm: drop smu_v13_0_1.c|h files for yellow carp
Thread-Index: AQHXblOP2r+hP9pSDkaRB88gxdxaaastz8kAgAAK4lA=
Date: Thu, 1 Jul 2021 11:37:46 +0000
Message-ID: <DM4PR12MB50866897841D584DF5766FE89F009@DM4PR12MB5086.namprd12.prod.outlook.com>
References: <20210701083121.10437-1-Xiaomeng.Hou@amd.com>
 <db7e299f-902a-847c-f159-77be315aea69@amd.com>
In-Reply-To: <db7e299f-902a-847c-f159-77be315aea69@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Aaron.Liu@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-01T11:37:41Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=5ff20c6e-842a-411d-9e4e-7d2388fa70bc;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 766be75f-bae5-404a-a069-08d93c84a5fe
x-ms-traffictypediagnostic: DM4PR12MB5085:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5085B30921B27A75012E8BD59F009@DM4PR12MB5085.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QOfQhTX3zQdkngwV2RKwc8SRE274Grxyi8GboOe6YLDvHf4gSZGAIMsNXBBHqKveNDMeWa7zzrNSVxxeakvgZ3Sg2sZVtQX/hdr818FBbobDmU1fQECb+r8JTCtDP4+W+6dL5t7OrUxpQu/1TMth1C6monUckxk8NgsSorK83ECkZaD0CZ0xaSmzFf6/pdioYgapA7qLoEd9hP74aJ1CEn8juUYWDiMhzfNpyyErN1sIbur5kpv2Wb7klABsas1Pa4vTrUS7/B0Jy4TTvmsjqyEA43QdGVYymCEHaOQBend9GCxJm5JSEvoBLuPfgu9hUMy3f6Gzl8zCSmE6rYGOLqxbXPOHVeVpMlz5MANl0MVn7BvUcyS+1kvbzAipQD3FyCbza2ir9exJYQb5LsdMNLGzu1Vqvjqmj5ztsBHozKQNPaXGMRwlw1PHyn4dDMVcJpNV4mxAxBYuMk5cyZnf2hJ0XUVjbSavViZ5RGC0AmV23oQAUsQNsKnJvV6WqDVXqvyhLB2ij7Wg7P+c5pPQlauHYKzVomKAD6GhzM6xOEjwI+3NRCWuHTUGEIHcfTrtymKYsHDo5Iwmc1sv0KwN1lt73/FKvi42/Z1QDjWiVYDMZk2EQrR8qYC0w/bHY3X/nkgNDCfX119ki7J6KrieNg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5086.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(2906002)(86362001)(6506007)(8676002)(478600001)(26005)(110136005)(8936002)(316002)(4326008)(7696005)(5660300002)(52536014)(9686003)(71200400001)(6636002)(33656002)(122000001)(66556008)(186003)(64756008)(66446008)(66946007)(76116006)(83380400001)(55016002)(38100700002)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YW5UNzRTbnJoWTZ1dVlrLy9oRDFMcW1xR3oySkUweEgrKzk0dXQxaERHVkVK?=
 =?utf-8?B?dFFja1VXaXdGcDl2Mk9mYldCMGxuYXRhR1pHMmlDUm01Nmw2U0FyNEVlaEh1?=
 =?utf-8?B?RnlzbUxpYzJKbG1uQVhrTUJ2NW84SUN1c3VWTitIWmtqUWw2SkUvSWkxck8v?=
 =?utf-8?B?SitpWXV0SDVYVmo1d3dwb1U3UnhvK1IySmlUYkVZTkVyT1NGejl5aXpzK1JB?=
 =?utf-8?B?ZXJqT3Q4SzgzdUtYRWs5dEtzeWVBeENYaldIcDJCbitUeklmL1FQN3Ezc0s2?=
 =?utf-8?B?N2JWMUpOMjU3SWZOZVE1NXlrNEpZMzlBQ0pFMlVDQTkzWHRqSHkyRWdWY2hL?=
 =?utf-8?B?SklyK0Q3Uzh2UFdzNlJNVVNFMXZGZ20wSVk4OFBXRmtFVlhRY21sMHdDdVhC?=
 =?utf-8?B?MXpveHdhaEFsa0Z5YmVzdzg5aEt4RWVoOUNrM1JyUlFHUmF1aloxeGhXcjVp?=
 =?utf-8?B?NXcweEFkbHpBVG45YVVmM0U3S1c3bFJEZGlHeVFzZ0dkOXR1eWtCMVR4VThG?=
 =?utf-8?B?eDRjcE8zejF5ZFRjY2tCeHI4TUxvbWZ0S2pVTEFxT1Awc1VkSFA5VkQ1ZzZx?=
 =?utf-8?B?UUsyeXZNSWdKN3pQK1NwSnFidUluM0hKZDIvL0o4QzNZdFNPR21KcmV5RWRj?=
 =?utf-8?B?RUJSNzMvUkh1UmFEWjJEdGUrUlp1MHVGdGg1OGVkMlROVmJGcTllMi9yTC96?=
 =?utf-8?B?NkcwZXRpclVRYzFBU0czbGdMS0dESmIzU0YyM1JlZWhTSHVmbVh2TkQ5KzZQ?=
 =?utf-8?B?bFh6ME5wTUcwOVA0S0dOMEZhWW5aY2diRU9nK1krTHA0QXNjVHcwdGUvT2Y1?=
 =?utf-8?B?M25VLzZ4UGxQdGp2RWlwMmpoYllzOExqMGl3L1AvTkxMc1doWlFmOXNVNjN1?=
 =?utf-8?B?aW5jeVZ2MXNwcjJRaGg2eUMwR0NzWDVqVVJkM3c3VWpuMEdvbjJFbkRZRzM2?=
 =?utf-8?B?UkpYeTdHTGpHbW9sQmxYN0xsdVk4dG5La0F6VFdLSzhHeEp6R0VYZUtXRStV?=
 =?utf-8?B?bVhqRUkrbFRUK0FBWndBb0RoKzl1bHY3WnJXMVlCUEUxVnFTM3ZUWTB0M0hW?=
 =?utf-8?B?dWVLV3BVZUQwMlVIWjNiTWh5MVpHakNDQU41c2liUC9YNmE4b0NsVE8rczhN?=
 =?utf-8?B?NlRMVFNpeUpFTzBwbVBQall0dnRTbmcwMWE1akx6MWlCMTd5RmZ1Z0Z2cDBu?=
 =?utf-8?B?NjhWdm5oeEgwZnFnRi9kUE4wSTFDTmEvS25oRmVvR3JLUllrVHAzYmVzcUN4?=
 =?utf-8?B?RGo0anNxSnlPc0RaMGNhWWpJbGFuWU11L1V6b0N0a0UramJHTk5kMy82Nmtx?=
 =?utf-8?B?eDd6SzVPNnYvU3E0Zm81SWlRWUxxZVFQVkVuMWZsLzZIekt6YjBWMkhoVEJr?=
 =?utf-8?B?MnVwQ0Nma2FoYUprUzltOFJBOEtjaGRHR1ovTVhrWTVydy9RRTh5SGxxQTBN?=
 =?utf-8?B?dTdlT1I4N0g3Tkc2OVNrV0tXV0MweUV4enRtb05mUzdFZjFBM2dVbWZIdHND?=
 =?utf-8?B?WUNTT2taa3dKVytwVkUrdk1Lcm9HdG1PdXAzeHlSNHpsVGRuN3NzaC9EV25h?=
 =?utf-8?B?TllrbVBZK2lFajhwRmxheHdwYUlOUWxIY0lwd0tuSEhFTUVRTlpiYTRoTlFU?=
 =?utf-8?B?OEg4Z0ZkTGlJay9hREg0SkNMakFYcEYrMlIrUlVRYTZYWDJRYkxLZ29uWFl0?=
 =?utf-8?B?WlNwclZqYnZmY004NHBmS1hKUE1TZTNsd0dxTVhlTTJLaDlUeXI1cTBhaklp?=
 =?utf-8?Q?nMjK3hn69nJNG7ZUURnA/s1fFqGqoPnzKNGPELT?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5086.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 766be75f-bae5-404a-a069-08d93c84a5fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2021 11:37:46.6738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O1gBL5TvEPa/J3e/35uJNLpjkFvXl4IThKq+dhFJRFRLpqbEzvRW0ztbNMoWhFU6GmTrZKhYOUm3UpYzI2ZJQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5085
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
Cc: "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

>
>-----Original Message-----
>From: Lazar, Lijo <Lijo.Lazar@amd.com> 
>Sent: Thursday, July 1, 2021 4:51 PM
>To: Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>
>Subject: Re: [PATCH] drm/amd/pm: drop smu_v13_0_1.c|h files for yellow carp
>
>One minor comment below.
>
>Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>
>
>On 7/1/2021 2:01 PM, Xiaomeng Hou wrote:
>> Since there's nothing special in smu implementation for yellow carp, 
>> it's better to reuse the common smu_v13_0 interfaces and drop the 
>> specific smu_v13_0_1.c|h files.
>> 
>> Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/inc/smu_v13_0.h        |   1 +
>>   drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h      |  57 ----
>>   drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile   |   2 +-
>>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  26 ++
>>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c  | 311 ------------------
>>   .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  39 ++-
>>   6 files changed, 59 insertions(+), 377 deletions(-)
>>   delete mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h
>>   delete mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c
>> 
>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h 
>> b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
>> index 6119a36b2cba..3fea2430dec0 100644
>> --- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
>> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
>> @@ -26,6 +26,7 @@
>>   #include "amdgpu_smu.h"
>>   
>>   #define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF
>> +#define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x03
>>   #define SMU13_DRIVER_IF_VERSION_ALDE 0x07
>>   
>>   /* MP Apertures */
>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h 
>> b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h
>> deleted file mode 100644
>> index b6c976a4d578..000000000000
>> --- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h
>> +++ /dev/null
>> @@ -1,57 +0,0 @@
>> -/*
>> - * Copyright 2020 Advanced Micro Devices, Inc.
>> - *
>> - * Permission is hereby granted, free of charge, to any person 
>> obtaining a
>> - * copy of this software and associated documentation files (the 
>> "Software"),
>> - * to deal in the Software without restriction, including without 
>> limitation
>> - * the rights to use, copy, modify, merge, publish, distribute, 
>> sublicense,
>> - * and/or sell copies of the Software, and to permit persons to whom 
>> the
>> - * Software is furnished to do so, subject to the following conditions:
>> - *
>> - * The above copyright notice and this permission notice shall be 
>> included in
>> - * all copies or substantial portions of the Software.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>> EXPRESS OR
>> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>> MERCHANTABILITY,
>> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT 
>> SHALL
>> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>> DAMAGES OR
>> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>> OTHERWISE,
>> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
>> OR
>> - * OTHER DEALINGS IN THE SOFTWARE.
>> - *
>> - */
>> -#ifndef __SMU_V13_0_1_H__
>> -#define __SMU_V13_0_1_H__
>> -
>> -#include "amdgpu_smu.h"
>> -
>> -#define SMU13_0_1_DRIVER_IF_VERSION_INV 0xFFFFFFFF -#define 
>> SMU13_0_1_DRIVER_IF_VERSION_YELLOW_CARP 0x3
>> -
>> -/* MP Apertures */
>> -#define MP0_Public			0x03800000
>> -#define MP0_SRAM			0x03900000
>> -#define MP1_Public			0x03b00000
>> -#define MP1_SRAM			0x03c00004
>> -
>> -/* address block */
>> -#define smnMP1_FIRMWARE_FLAGS		0x3010024
>> -
>> -
>> -#if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3)
>> -
>> -int smu_v13_0_1_check_fw_status(struct smu_context *smu);
>> -
>> -int smu_v13_0_1_check_fw_version(struct smu_context *smu);
>> -
>> -int smu_v13_0_1_fini_smc_tables(struct smu_context *smu);
>> -
>> -int smu_v13_0_1_get_vbios_bootup_values(struct smu_context *smu);
>> -
>> -int smu_v13_0_1_set_default_dpm_tables(struct smu_context *smu);
>> -
>> -int smu_v13_0_1_set_driver_table_location(struct smu_context *smu);
>> -
>> -int smu_v13_0_1_gfx_off_control(struct smu_context *smu, bool 
>> enable); -#endif -#endif diff --git 
>> a/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile 
>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
>> index 9b3a8503f5cd..d4c4c495762c 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
>> @@ -23,7 +23,7 @@
>>   # Makefile for the 'smu manager' sub-component of powerplay.
>>   # It provides the smu management services for the driver.
>>   
>> -SMU13_MGR = smu_v13_0.o aldebaran_ppt.o smu_v13_0_1.o 
>> yellow_carp_ppt.o
>> +SMU13_MGR = smu_v13_0.o aldebaran_ppt.o yellow_carp_ppt.o
>>   
>>   AMD_SWSMU_SMU13MGR = $(addprefix 
>> $(AMD_SWSMU_PATH)/smu13/,$(SMU13_MGR))
>>   
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c 
>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> index a3dc7194aaf8..cbce982f2717 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> @@ -41,6 +41,8 @@
>>   
>>   #include "asic_reg/thm/thm_13_0_2_offset.h"
>>   #include "asic_reg/thm/thm_13_0_2_sh_mask.h"
>> +#include "asic_reg/mp/mp_13_0_1_offset.h"
>> +#include "asic_reg/mp/mp_13_0_1_sh_mask.h"
>
>If the offsets are same, are these files still needed or can they be not included/dropped completely?

Yes, I noticed the offsets/masks are actually same between mp_13_0_1/2, I am not sure if we could drop the header files completely, or I just not include them in this patch? @Liu, Aaron, do you have any comment? Are these header files there for future possible distinction?

Regards,
Matthew 
>
>Thanks,
>Lijo
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
