Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBDBCDB466
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 04:05:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B313F10E16F;
	Thu, 25 Jun 2026 04:05:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lVqc0HXI";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1103710E140
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 04:05:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDHePoLD1h2uctc5tS0bQs79LI0gJilI4zRdT8LT2dQOseKgu204Yt8qxyxDvEYHUPnxEja8/t0gxHgsP1Lgsxk9Pklr275GAC7Pjl5SDvSZCJZdp+Yi42hbIcxByh5yXv1RDHB4PifY01zsCFIK6F+QhetIHSqOR6YsxG6g2CCQJN2/iaMcXUitLeR8Eo/rhkgpKAJ8s2bgZhkdDwdEhx9xXWxefNHhKZyIRPGH9oUt9MVEMv1xm6+5MA6FMcbxNcdJ6HcXDR33h9OfWknSZSfkRqbiw2SafGchZn+D/GNKOzR2xdOsX9br7b/ZtuvLT35keXLIjt1wZ63H3FnYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeKckDZuPmagkTHK6EfL9zcSXiD3khO0roU6TRL3yHk=;
 b=gA8I37R31EcHKBRcHFvAzhFAAmE0V3CIADjr8hsSug9H99ydRJJz/CTlUAuK+wS77f4z8XxtZ0pRh4Y/CCrWcOenw1NWJcr47oWp6IWFWyYbqPWLCsUopp9r3oeyChVpq0JcGkROoVTJn+sSOmXTofkZQqsnmfQCnRkpH1aXLoXXoiu+eUS5a5tmup5DAJmbaJWjJAa5b7bcogp9t2B5nBV7PinXmrcBfeQXl7A8HWlOCh+gxMcxY3CDLzvcgMHHqMYr5HJCgD84SpBDIUgQb+jFAnRPUxdiRR4g8/QR7tOVZaTCETlr6zNgkL+MuUCatpAqB109qLFQr1l18gb8TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeKckDZuPmagkTHK6EfL9zcSXiD3khO0roU6TRL3yHk=;
 b=lVqc0HXIlUCsBbzP0iJFrQztvOLsnofPnEDIR3tF3qXu2nOJMMUGVEWtUr/V0FN+s9at66CuIDHck7FnlxYIwfHcrfGu7Oq5Q3JwmXwpG+ZnW/b7spuqm2zfERt4GYO9mBzr2HZxLeut6UMy9eWASLaoUHwXkjWDv14qcgD/5M8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 04:04:57 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.21.0113.015; Thu, 25 Jun 2026
 04:04:56 +0000
Content-Type: multipart/alternative;
 boundary="------------hwvtQKsnReO5gH2T86lNNk5e"
Message-ID: <6ddacf96-8f89-4554-824c-8a7a496fb8bf@amd.com>
Date: Thu, 25 Jun 2026 09:34:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] drm/amdgpu: move struct amdgpu_mqd and helpers
 into header file
To: "Soltani, Shahyan" <Shahyan.Soltani@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260622195729.181216-1-shahyan.soltani@amd.com>
 <20260622195729.181216-5-shahyan.soltani@amd.com>
 <8f135ee0-7d1d-4af2-aa89-36fb2265a66d@amd.com>
 <aa6d3b80-fff5-4cb3-a613-c67804edcc5f@amd.com>
 <efdcaa38-edcd-4ff4-b9ae-7b9fa28574c7@amd.com>
 <MN2PR12MB2863D13DB0659F43F1BCD689F5ED2@MN2PR12MB2863.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <MN2PR12MB2863D13DB0659F43F1BCD689F5ED2@MN2PR12MB2863.namprd12.prod.outlook.com>
X-ClientProxiedBy: MA5PR01CA0271.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21d::8) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|PH8PR12MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 007f476a-2a28-4110-6419-08ded26eeb06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|11063799006|5023799004|4143699003|56012099006|6133799003|8096899003;
X-Microsoft-Antispam-Message-Info: ybi2CQ0yiCHWPGoYzu6A3K26y3qxbPXDd7smAnNBIS2z0i1+yT2skc94aMjkefsAl1B3qegkHaHXZWggIZBOaWX8trR72/sMqEZ9Ko9lJZ3Tl8fPVfRvMm9NQATR1H01Ef0E8Fdmn2WJdxZHO+Q/0Bzg0IqnYHJoDY1HJBluBCjuyAGW+qRbkgOuEcUgskGzXLNxIFyQM27hQSMu3gbf3IB30F0lY+Qkkcn9FYaskZqq5TNaW4oF8VuKUPY9me4pfXeIdQGCobAEFARNbRe/lPWwypyj2k8OeULztbCQnngqr/baLL1Z/ScuwrbOzn/iCablIBtmx7BXF4ik1kfKfXmVglwspXThRaTRV9DzGeW3VinYnj9mGhamiiQOUXUo+NM3Dw/xdShZumUegRA3scSuxfoTNW37QnXsStFRL9nXhNjCVD0XAD+6Ov/BpqJtc9eVx+YgaI09Vk6zKZdhcN7DyPtGg4BD9AGrRX6qyEFA9HmTJ6I5ZNR8E6QwNON1vvk6xlKikdDLhr/htF5MbLeA8yAS+PA6togQ/XPikkQ5u14jsQUAjcUHkcxMpPMpnpPHHg/HAe54CP8uZVNKFviiLZ4nS9CL9Lp/8xnPfFI4ZN6tDnHPJGepZuF9NlBGGfgFqxCUgkwxFdd03rjfQpp0K3VrJrSdR4EuhiJUzGk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(5023799004)(4143699003)(56012099006)(6133799003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3dFaEkyOWZ5Ryt6L3ltS05BSTdoRW9KUU9yYWM0WWFEWHkxdHNHbTdmMENY?=
 =?utf-8?B?MnNlNEk4YmJtbjhwa0dKN1l6Vk0wa1EyS3UwVXZ2aWZIeDN6VjFTNUJib2Rk?=
 =?utf-8?B?TzluVWx0YXNhVkd6MnpIMGVYd3AraEpNd1IrMGNNWDkvU1Q3RHBNRGhGdllM?=
 =?utf-8?B?LytFUGxabyt2bGdXelU0RVNZcVd0clc1a0RrVVZvaXRDUjBkUERnTVQ2WGZH?=
 =?utf-8?B?NUNiNThYY1dnYkNtMitQVW05SXhCdlpSUEJ2SHlIVlU5OURJYTN2c3ZzbERj?=
 =?utf-8?B?bFUvQ1oyazdWYmNJVWR6VkVoK0VyZnlzQ2ROL1ZWMWpyaWcxbnBXcHphUGlO?=
 =?utf-8?B?LzhEcm9XNjZRTk5nNXA2bnVFd2VOTEZKalFEY2ZkNEN6NXJtZk1MczgwOVpE?=
 =?utf-8?B?cjArQVN2WFMrZ1JIb3VVMmV6cTJZT01oMElkaFVvSHJlTFBRaFJETWhvZ2tL?=
 =?utf-8?B?ZGVCczJMV2xqQmNlOFk3d2VibkNyT2lhTXNHRE5LREt2M3d4SGVWeEhqa2xq?=
 =?utf-8?B?Vk5jd3lGT09iMVl1RTFDOXg2SE45UVljZ3pZYWFxRFp3cVRabFZxTGhFUXNh?=
 =?utf-8?B?MzIzOThPYm83NE1RUkpqeG9WVTJYaXJndVZTdWM1Z1NUM1VpV2RtWHp5dmJw?=
 =?utf-8?B?c3BCTEtLa1crWXRnZFFXS25DQW9YemZaR0krMmF1eDlhT3JlaUN3VE9aSi9H?=
 =?utf-8?B?WjdrN1RnYVMvemYybUlLNUlPalcvamZhYlJDNXBrTFZpMStQdzQ5ODhIQnFi?=
 =?utf-8?B?eE9ack5iSTU1T3YzTVF2cldjSEt4Y1lJaHZRNXNLSDFuVk1OQzI0NTFuWlFO?=
 =?utf-8?B?YkJHQjVQMUpXMHgrVEVtYnVxSG1iV01VTk01d2ZnRWVpUUZ5bWpJbkkydjRI?=
 =?utf-8?B?ejljazJQOEJvWmV1TklwVU8yU0tMME4vY2lCMDlibWJzMTNPL1pqY3dMUFFW?=
 =?utf-8?B?Z0p1UjZsdzhVcDN3VzFGenloc2hCdXh3TG1zSm9aNnk2NGloWlpVM1NTMWh3?=
 =?utf-8?B?U1ZBVHd0L1VQUGVmM0VybUV3Y1czR1Byb2VPUUpiN0ZOZ1ZtekplajVUQ2xh?=
 =?utf-8?B?ZDNOUFlYZ2NiZ2tKTmZDbFNUUFBSSVJWUzdGblk5MkZBYmQvMHFOdUFUdzFU?=
 =?utf-8?B?NzI1bFBrZW52R2VCL0ZQbTNNdndRZngzM3NzOVNTMnB2VTZGTHVuTU1KYU5u?=
 =?utf-8?B?NU9JREVOZ3Q1S1dJUFdRL1dVTElXbm9lRVMwb2NUcmV0NmxEVVErMXBMNXo1?=
 =?utf-8?B?YVRWR2dRZlE5alp3MVlpRC9WVjR5anRiVllKeU13NGVQemxMSHhVUFc3MWUy?=
 =?utf-8?B?dDFiSXArRGxUK3dGblBMQmtNeEpBQWRRU2RpQ1hVWlUzQUp6TmtnbjR0cncx?=
 =?utf-8?B?OFB3OUc1VFVUd01nVUdGYlNlT1FBUmNWOXlMM3djOEJ1bjRrY0U3VlFYalEr?=
 =?utf-8?B?WUxiVSt4WkNJd1dIdW1sSTl5d1FaRHhxWlBYUk56QkprUk02T1J0WDFkaDI2?=
 =?utf-8?B?ak1xTGVkUWxOZGF0aGtpWWxTcHRGNWdnUUNWRTNNelFRUERhTmwzTFNCcWRL?=
 =?utf-8?B?YlFOSHg3VnFFQzhBV0JKUkRBRUFnZVhlZGRtOUw3MUdnbkJueFFjaTdYZllH?=
 =?utf-8?B?UE5Oc2VhTjdWQ0w2NDQ0Z3dkcTcya1ZFakRIeDBFQWROZlFxc2E2bytNWHN1?=
 =?utf-8?B?Z1RHT3NWRkMxbnFjOVYydlNQZ3ovWURwWkMwLytXZGp4SVpPYUxuc3c5Qnh3?=
 =?utf-8?B?cHBvQllDajFDcE5qZVZUSjdMY1Z6SzFKeURNQ0k5djkxcHpJcm1YQ1J1K0Zz?=
 =?utf-8?B?Z1h2VFNPS0hBVktWSVgzV3BONjZsVk5pOVdVTGxxeDUxclNyZUZpb0NiM0Nl?=
 =?utf-8?B?aXBTQlhwL1VZcjJZSUtGYkcvazE1YU9Wdm9Xdk9hU3JsNk1RWlY4NUFwQ1ds?=
 =?utf-8?B?Q0JwMTgrcFRWWEVRSEc3RWlHNVpaSlZWM1ZXWDg3R3dTbEJyTkphQWR1VXVm?=
 =?utf-8?B?WlFmL0NNVFAveldQQktTNXg0SzlsTFBjY1MxZ2M5cnNxVDFicjhYMURVcDZv?=
 =?utf-8?B?QU9TM1dNeUpNcEtqaGZyUUF3cnd6eElPNnpaMDgyaXo0K1F6b0l3T0xLYUtO?=
 =?utf-8?B?dHJQOWNSMzErRGRFNktXb3dEaDhKMDZMVzViN2xnLzdVTHJHZHBLZ1Z3V3py?=
 =?utf-8?B?WXhnMnlPUWxhdC9uZm5RVCsxeUFiU0NpcHBjSFgwT3QwejVBWkEybUc0SFFW?=
 =?utf-8?B?b2E3UTA0UnlaRVpyNEZZOGFjelQ3eDZYQWdUUklBbVhqUXZhYXR2c3JoRlBn?=
 =?utf-8?B?cTlnMU5FOThrb0tTZEF4L0p6TXNWRFYxM0JlTlRURDlwZW1xRi8xUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 007f476a-2a28-4110-6419-08ded26eeb06
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 04:04:56.7975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/oZ3S/V1Pbm+HsE5IgFzAEr7KQIxLwZFzf+5C+Palt+ZsYOpRMWm6XL4fl8oqAFPEjNQuNVtX4AFL/a0tvyvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940
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

--------------hwvtQKsnReO5gH2T86lNNk5e
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 24-06-2026 11:03 pm, Soltani, Shahyan wrote:
> AMD General
>
> > I remember one thing, if you moved them from amdgpu.h and again added it
> > via include "amdgpu_mes.h", there seems to be less benefit of it as its
> > always there in amdgpu.h. Just check if there is a possibility if that
> > include could be removed totally and include amdgpu_mes.h explicitly
> > only where its needed.
> >
> > Regards
> > Sunil khatri
>
> Hi Sunil,
>
> I looked into removing amdgpu_mes.h as you asked, however struct
> amdgpu_device needs these by value:
>
> struct amdgpu_mes mes;
> struct amdgpu_mqd mqds[AMDGPU_HW_IP_NUM];
>
> Because of this amdgpu.h needs the complete definition so as far as I 
> know I'm
> unable to drop the include here and use something like a forward 
> declaration.

See if it could be fixed by making some changed else its ok.


Regards
Sunil Khatri

>
> Thanks,
> Shahyan
> ------------------------------------------------------------------------
> *From:* Khatri, Sunil <Sunil.Khatri@amd.com>
> *Sent:* Wednesday, June 24, 2026 9:10 AM
> *To:* Koenig, Christian <Christian.Koenig@amd.com>; Soltani, Shahyan 
> <Shahyan.Soltani@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>; Khatri, Sunil <Sunil.Khatri@amd.com>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>
> *Subject:* Re: [PATCH v3 4/8] drm/amdgpu: move struct amdgpu_mqd and 
> helpers into header file
>
> On 24-06-2026 06:29 pm, Khatri, Sunil wrote:
> >
> > On 23-06-2026 02:34 pm, Christian König wrote:
> >> On 6/22/26 21:57, Shahyan Soltani wrote:
> >>> Move struct amdgpu_mqd_prop, struct amdgpu_mqd, and helpers from the
> >>> monolithic amdgpu.h
> >>> into existing amdgpu_mes.h file.
> >>>
> >>> This is part of the ongoing effort to reduce the size of amdgpu.h
> >>> into their own respective
> >>> separate headers.
> >>>
> >>> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> >> Reviewed-by: Christian König <christian.koenig@amd.com>
> >>
> >> @Sunil can you take a look at that as well? Just to keep you updated
> >> on all userqueue stuff.
> > LGTM,
> > Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
> >
> > Regards
> > Sunil Khatri
> >>
> >> Thanks,
> >> Christian.
> >>
> >>> ---
> >>> Following v2's feedback struct amdgpu_mqd and helpers were moved into
> >>> the existing amdgpu_mes.h instead of creating a new amdgpu_mqh.h file
> >>> ---
> >>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 48
> >>> +------------------------
> >>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 46 
> ++++++++++++++++++++++++
> >>>   2 files changed, 47 insertions(+), 47 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >>> index 61608acc0393..ca86cef62f44 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >>> @@ -96,7 +96,6 @@
> >>>   #include "amdgpu_doorbell.h"
> >>>   #include "amdgpu_amdkfd.h"
> >>>   #include "amdgpu_discovery.h"
> >>> -#include "amdgpu_mes.h"
> >>>   #include "amdgpu_umc.h"
> >>>   #include "amdgpu_mmhub.h"
> >>>   #include "amdgpu_gfxhub.h"
> >>> @@ -115,6 +114,7 @@
> >>>   #include "amdgpu_eviction_fence.h"
> >>>   #include "amdgpu_wb.h"
> >>>   #include "amdgpu_ip.h"
> >>> +#include "amdgpu_mes.h"
> I remember one thing, if you moved them from amdgpu.h and again added it
> via include "amdgpu_mes.h", there seems to be less benefit of it as its
> always there in amdgpu.h. Just check if there is a possibility if that
> include could be removed totally and include amdgpu_mes.h explicitly
> only where its needed.
>
> Regards
> Sunil khatri
> >>>   #include "amdgpu_sa.h"
> >>>   #include "amdgpu_uid.h"
> >>>   #include "amdgpu_video_codecs.h"
> >>> @@ -609,44 +609,6 @@ struct amd_powerplay {
> >>>                         (rid == 0x01) || \
> >>>                         (rid == 0x10))))
> >>>   -enum amdgpu_mqd_update_flag {
> >>> -       AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE = 1,
> >>> -       AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE = 2,
> >>> -       AMDGPU_UPDATE_FLAG_IS_GWS = 4, /* quirk for gfx9 IP */
> >>> -};
> >>> -
> >>> -struct amdgpu_mqd_prop {
> >>> -    uint64_t mqd_gpu_addr;
> >>> -    uint64_t hqd_base_gpu_addr;
> >>> -    uint64_t rptr_gpu_addr;
> >>> -    uint64_t wptr_gpu_addr;
> >>> -    uint32_t queue_size;
> >>> -    bool use_doorbell;
> >>> -    uint32_t doorbell_index;
> >>> -    uint64_t eop_gpu_addr;
> >>> -    uint32_t hqd_pipe_priority;
> >>> -    uint32_t hqd_queue_priority;
> >>> -    uint32_t mqd_stride_size;
> >>> -    bool allow_tunneling;
> >>> -    bool hqd_active;
> >>> -    uint64_t shadow_addr;
> >>> -    uint64_t gds_bkup_addr;
> >>> -    uint64_t csa_addr;
> >>> -    uint64_t fence_address;
> >>> -    bool tmz_queue;
> >>> -    bool kernel_queue;
> >>> -    uint32_t *cu_mask;
> >>> -    uint32_t cu_mask_count;
> >>> -    uint32_t cu_flags;
> >>> -    bool is_user_cu_masked;
> >>> -};
> >>> -
> >>> -struct amdgpu_mqd {
> >>> -    unsigned mqd_size;
> >>> -    int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
> >>> -            struct amdgpu_mqd_prop *p);
> >>> -};
> >>> -
> >>>   struct amdgpu_pcie_reset_ctx {
> >>>       bool in_link_reset;
> >>>       bool occurs_dpc;
> >>> @@ -1034,14 +996,6 @@ struct amdgpu_device {
> >>>       struct amdgpu_kfd_dev        kfd;
> >>>   };
> >>>   -/*
> >>> - * MES FW uses address(mqd_addr + sizeof(struct mqd) +
> >>> 3*sizeof(uint32_t))
> >>> - * as fence address and writes a 32 bit fence value to this address.
> >>> - * Driver needs to allocate at least 4 DWs extra memory in 
> addition to
> >>> - * sizeof(struct mqd). Add 8 DWs and align to AMDGPU_GPU_PAGE_SIZE
> >>> for safety.
> >>> - */
> >>> -#define AMDGPU_MQD_SIZE_ALIGN(mqd_size)
> >>> AMDGPU_GPU_PAGE_ALIGN(((mqd_size) + 32))
> >>> -
> >>>   static inline uint32_t amdgpu_ip_version(const struct
> >>> amdgpu_device *adev,
> >>>                        uint8_t ip, uint8_t inst)
> >>>   {
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> >>> index 5255360353f4..7b4cfb5c8f83 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> >>> @@ -438,6 +438,52 @@ struct amdgpu_mes_funcs {
> >>>                     struct mes_inv_tlbs_pasid_input *input);
> >>>   };
> >>>   +enum amdgpu_mqd_update_flag {
> >>> +    AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE = 1,
> >>> +    AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE = 2,
> >>> +    AMDGPU_UPDATE_FLAG_IS_GWS = 4, /* quirk for gfx9 IP */
> >>> +};
> >>> +
> >>> +struct amdgpu_mqd_prop {
> >>> +    uint64_t mqd_gpu_addr;
> >>> +    uint64_t hqd_base_gpu_addr;
> >>> +    uint64_t rptr_gpu_addr;
> >>> +    uint64_t wptr_gpu_addr;
> >>> +    uint32_t queue_size;
> >>> +    bool use_doorbell;
> >>> +    uint32_t doorbell_index;
> >>> +    uint64_t eop_gpu_addr;
> >>> +    uint32_t hqd_pipe_priority;
> >>> +    uint32_t hqd_queue_priority;
> >>> +    uint32_t mqd_stride_size;
> >>> +    bool allow_tunneling;
> >>> +    bool hqd_active;
> >>> +    uint64_t shadow_addr;
> >>> +    uint64_t gds_bkup_addr;
> >>> +    uint64_t csa_addr;
> >>> +    uint64_t fence_address;
> >>> +    bool tmz_queue;
> >>> +    bool kernel_queue;
> >>> +    uint32_t *cu_mask;
> >>> +    uint32_t cu_mask_count;
> >>> +    uint32_t cu_flags;
> >>> +    bool is_user_cu_masked;
> >>> +};
> >>> +
> >>> +struct amdgpu_mqd {
> >>> +    unsigned mqd_size;
> >>> +    int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
> >>> +            struct amdgpu_mqd_prop *p);
> >>> +};
> >>> +
> >>> +/*
> >>> + * MES FW uses address(mqd_addr + sizeof(struct mqd) +
> >>> 3*sizeof(uint32_t))
> >>> + * as fence address and writes a 32 bit fence value to this address.
> >>> + * Driver needs to allocate at least 4 DWs extra memory in 
> addition to
> >>> + * sizeof(struct mqd). Add 8 DWs and align to AMDGPU_GPU_PAGE_SIZE
> >>> for safety.
> >>> + */
> >>> +#define AMDGPU_MQD_SIZE_ALIGN(mqd_size)
> >>> AMDGPU_GPU_PAGE_ALIGN(((mqd_size) + 32))
> >>> +
> >>>   #define amdgpu_mes_kiq_hw_init(adev, xcc_id) \
> >>>       (adev)->mes.kiq_hw_init((adev), (xcc_id))
> >>>   #define amdgpu_mes_kiq_hw_fini(adev, xcc_id) \
--------------hwvtQKsnReO5gH2T86lNNk5e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 24-06-2026 11:03 pm, Soltani,
      Shahyan wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:MN2PR12MB2863D13DB0659F43F1BCD689F5ED2@MN2PR12MB2863.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <div>
        <div style="font-family: Calibri; text-align: left; color: rgb(0, 0, 255); margin-left: 5pt; font-size: 10pt;">
          AMD General</div>
        <br>
      </div>
      <div style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        &gt; I remember one thing, if you moved them from amdgpu.h and
        again added it<br>
        &gt; via include &quot;amdgpu_mes.h&quot;, there seems to be less benefit
        of it as its<br>
        &gt; always there in amdgpu.h. Just check if there is a
        possibility if that<br>
        &gt; include could be removed totally and include amdgpu_mes.h
        explicitly<br>
        &gt; only where its needed.<br>
        &gt;&nbsp;<br>
        &gt;&nbsp;Regards<br>
        &gt;&nbsp;Sunil khatri</div>
      <div style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        Hi Sunil,</div>
      <div style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        I looked into removing amdgpu_mes.h as you asked, however struct</div>
      <div style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        amdgpu_device needs these by value:</div>
      <div style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        struct amdgpu_mes mes;</div>
      <div style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        struct amdgpu_mqd mqds[AMDGPU_HW_IP_NUM];</div>
      <div style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        Because of this amdgpu.h needs the complete definition so as far
        as I know I'm</div>
      <div style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        unable to drop the include here and use something like a forward
        declaration.</div>
    </blockquote>
    <p>See if it could be fixed by making some changed else its ok.&nbsp;</p>
    <p><br>
      Regards<br>
      Sunil Khatri</p>
    <blockquote type="cite" cite="mid:MN2PR12MB2863D13DB0659F43F1BCD689F5ED2@MN2PR12MB2863.namprd12.prod.outlook.com">
      <div style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        Thanks,</div>
      <div style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        Shahyan</div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font face="Calibri, sans-serif" style="font-size:11pt" color="#000000"><b>From:</b> Khatri,
          Sunil <a class="moz-txt-link-rfc2396E" href="mailto:Sunil.Khatri@amd.com">&lt;Sunil.Khatri@amd.com&gt;</a><br>
          <b>Sent:</b> Wednesday, June 24, 2026 9:10 AM<br>
          <b>To:</b> Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>;
          Soltani, Shahyan <a class="moz-txt-link-rfc2396E" href="mailto:Shahyan.Soltani@amd.com">&lt;Shahyan.Soltani@amd.com&gt;</a>;
          <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Khatri, Sunil
          <a class="moz-txt-link-rfc2396E" href="mailto:Sunil.Khatri@amd.com">&lt;Sunil.Khatri@amd.com&gt;</a><br>
          <b>Cc:</b> Deucher, Alexander
          <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
          <b>Subject:</b> Re: [PATCH v3 4/8] drm/amdgpu: move struct
          amdgpu_mqd and helpers into header file</font>
        <div>&nbsp;</div>
      </div>
      <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
            <div class="PlainText"><br>
              On 24-06-2026 06:29 pm, Khatri, Sunil wrote:<br>
              &gt;<br>
              &gt; On 23-06-2026 02:34 pm, Christian König wrote:<br>
              &gt;&gt; On 6/22/26 21:57, Shahyan Soltani wrote:<br>
              &gt;&gt;&gt; Move struct amdgpu_mqd_prop, struct
              amdgpu_mqd, and helpers from the <br>
              &gt;&gt;&gt; monolithic amdgpu.h<br>
              &gt;&gt;&gt; into existing amdgpu_mes.h file.<br>
              &gt;&gt;&gt;<br>
              &gt;&gt;&gt; This is part of the ongoing effort to reduce
              the size of amdgpu.h <br>
              &gt;&gt;&gt; into their own respective<br>
              &gt;&gt;&gt; separate headers.<br>
              &gt;&gt;&gt;<br>
              &gt;&gt;&gt; Signed-off-by: Shahyan Soltani
              <a class="moz-txt-link-rfc2396E" href="mailto:shahyan.soltani@amd.com">&lt;shahyan.soltani@amd.com&gt;</a><br>
              &gt;&gt; Reviewed-by: Christian König
              <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a><br>
              &gt;&gt;<br>
              &gt;&gt; @Sunil can you take a look at that as well? Just
              to keep you updated <br>
              &gt;&gt; on all userqueue stuff.<br>
              &gt; LGTM,<br>
              &gt; Reviewed-by: Sunil Khatri
              <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a><br>
              &gt;<br>
              &gt; Regards<br>
              &gt; Sunil Khatri<br>
              &gt;&gt;<br>
              &gt;&gt; Thanks,<br>
              &gt;&gt; Christian.<br>
              &gt;&gt;<br>
              &gt;&gt;&gt; ---<br>
              &gt;&gt;&gt; Following v2's feedback struct amdgpu_mqd and
              helpers were moved into<br>
              &gt;&gt;&gt; the existing amdgpu_mes.h instead of creating
              a new amdgpu_mqh.h file<br>
              &gt;&gt;&gt; ---<br>
              &gt;&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp; |
              48 <br>
              &gt;&gt;&gt; +------------------------<br>
              &gt;&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |
              46 ++++++++++++++++++++++++<br>
              &gt;&gt;&gt; &nbsp; 2 files changed, 47 insertions(+), 47
              deletions(-)<br>
              &gt;&gt;&gt;<br>
              &gt;&gt;&gt; diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
              &gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
              &gt;&gt;&gt; index 61608acc0393..ca86cef62f44 100644<br>
              &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
              &gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
              &gt;&gt;&gt; @@ -96,7 +96,6 @@<br>
              &gt;&gt;&gt; &nbsp; #include &quot;amdgpu_doorbell.h&quot;<br>
              &gt;&gt;&gt; &nbsp; #include &quot;amdgpu_amdkfd.h&quot;<br>
              &gt;&gt;&gt; &nbsp; #include &quot;amdgpu_discovery.h&quot;<br>
              &gt;&gt;&gt; -#include &quot;amdgpu_mes.h&quot;<br>
              &gt;&gt;&gt; &nbsp; #include &quot;amdgpu_umc.h&quot;<br>
              &gt;&gt;&gt; &nbsp; #include &quot;amdgpu_mmhub.h&quot;<br>
              &gt;&gt;&gt; &nbsp; #include &quot;amdgpu_gfxhub.h&quot;<br>
              &gt;&gt;&gt; @@ -115,6 +114,7 @@<br>
              &gt;&gt;&gt; &nbsp; #include &quot;amdgpu_eviction_fence.h&quot;<br>
              &gt;&gt;&gt; &nbsp; #include &quot;amdgpu_wb.h&quot;<br>
              &gt;&gt;&gt; &nbsp; #include &quot;amdgpu_ip.h&quot;<br>
              &gt;&gt;&gt; +#include &quot;amdgpu_mes.h&quot;<br>
              I remember one thing, if you moved them from amdgpu.h and
              again added it <br>
              via include &quot;amdgpu_mes.h&quot;, there seems to be less benefit
              of it as its <br>
              always there in amdgpu.h. Just check if there is a
              possibility if that <br>
              include could be removed totally and include amdgpu_mes.h
              explicitly <br>
              only where its needed.<br>
              <br>
              Regards<br>
              Sunil khatri<br>
              &gt;&gt;&gt; &nbsp; #include &quot;amdgpu_sa.h&quot;<br>
              &gt;&gt;&gt; &nbsp; #include &quot;amdgpu_uid.h&quot;<br>
              &gt;&gt;&gt; &nbsp; #include &quot;amdgpu_video_codecs.h&quot;<br>
              &gt;&gt;&gt; @@ -609,44 +609,6 @@ struct amd_powerplay {<br>
              &gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (rid == 0x01) || \<br>
              &gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (rid == 0x10))))<br>
              &gt;&gt;&gt; &nbsp; -enum amdgpu_mqd_update_flag {<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE = 1,<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE =
              2,<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_UPDATE_FLAG_IS_GWS = 4, /*
              quirk for gfx9 IP */<br>
              &gt;&gt;&gt; -};<br>
              &gt;&gt;&gt; -<br>
              &gt;&gt;&gt; -struct amdgpu_mqd_prop {<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint64_t mqd_gpu_addr;<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint64_t hqd_base_gpu_addr;<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint64_t rptr_gpu_addr;<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint64_t wptr_gpu_addr;<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint32_t queue_size;<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; bool use_doorbell;<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint32_t doorbell_index;<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint64_t eop_gpu_addr;<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint32_t hqd_pipe_priority;<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint32_t hqd_queue_priority;<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint32_t mqd_stride_size;<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; bool allow_tunneling;<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; bool hqd_active;<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint64_t shadow_addr;<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint64_t gds_bkup_addr;<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint64_t csa_addr;<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint64_t fence_address;<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; bool tmz_queue;<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; bool kernel_queue;<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint32_t *cu_mask;<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint32_t cu_mask_count;<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; uint32_t cu_flags;<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; bool is_user_cu_masked;<br>
              &gt;&gt;&gt; -};<br>
              &gt;&gt;&gt; -<br>
              &gt;&gt;&gt; -struct amdgpu_mqd {<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; unsigned mqd_size;<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; int (*init_mqd)(struct amdgpu_device
              *adev, void *mqd,<br>
              &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_mqd_prop *p);<br>
              &gt;&gt;&gt; -};<br>
              &gt;&gt;&gt; -<br>
              &gt;&gt;&gt; &nbsp; struct amdgpu_pcie_reset_ctx {<br>
              &gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool in_link_reset;<br>
              &gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool occurs_dpc;<br>
              &gt;&gt;&gt; @@ -1034,14 +996,6 @@ struct amdgpu_device {<br>
              &gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_kfd_dev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd;<br>
              &gt;&gt;&gt; &nbsp; };<br>
              &gt;&gt;&gt; &nbsp; -/*<br>
              &gt;&gt;&gt; - * MES FW uses address(mqd_addr +
              sizeof(struct mqd) + <br>
              &gt;&gt;&gt; 3*sizeof(uint32_t))<br>
              &gt;&gt;&gt; - * as fence address and writes a 32 bit
              fence value to this address.<br>
              &gt;&gt;&gt; - * Driver needs to allocate at least 4 DWs
              extra memory in addition to<br>
              &gt;&gt;&gt; - * sizeof(struct mqd). Add 8 DWs and align
              to AMDGPU_GPU_PAGE_SIZE <br>
              &gt;&gt;&gt; for safety.<br>
              &gt;&gt;&gt; - */<br>
              &gt;&gt;&gt; -#define AMDGPU_MQD_SIZE_ALIGN(mqd_size) <br>
              &gt;&gt;&gt; AMDGPU_GPU_PAGE_ALIGN(((mqd_size) + 32))<br>
              &gt;&gt;&gt; -<br>
              &gt;&gt;&gt; &nbsp; static inline uint32_t
              amdgpu_ip_version(const struct <br>
              &gt;&gt;&gt; amdgpu_device *adev,<br>
              &gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t ip, uint8_t
              inst)<br>
              &gt;&gt;&gt; &nbsp; {<br>
              &gt;&gt;&gt; diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h <br>
              &gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
              &gt;&gt;&gt; index 5255360353f4..7b4cfb5c8f83 100644<br>
              &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
              &gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
              &gt;&gt;&gt; @@ -438,6 +438,52 @@ struct amdgpu_mes_funcs
              {<br>
              &gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
              mes_inv_tlbs_pasid_input *input);<br>
              &gt;&gt;&gt; &nbsp; };<br>
              &gt;&gt;&gt; &nbsp; +enum amdgpu_mqd_update_flag {<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE = 1,<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE = 2,<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; AMDGPU_UPDATE_FLAG_IS_GWS = 4, /* quirk
              for gfx9 IP */<br>
              &gt;&gt;&gt; +};<br>
              &gt;&gt;&gt; +<br>
              &gt;&gt;&gt; +struct amdgpu_mqd_prop {<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint64_t mqd_gpu_addr;<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint64_t hqd_base_gpu_addr;<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint64_t rptr_gpu_addr;<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint64_t wptr_gpu_addr;<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint32_t queue_size;<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; bool use_doorbell;<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint32_t doorbell_index;<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint64_t eop_gpu_addr;<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint32_t hqd_pipe_priority;<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint32_t hqd_queue_priority;<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint32_t mqd_stride_size;<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; bool allow_tunneling;<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; bool hqd_active;<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint64_t shadow_addr;<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint64_t gds_bkup_addr;<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint64_t csa_addr;<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint64_t fence_address;<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; bool tmz_queue;<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; bool kernel_queue;<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint32_t *cu_mask;<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint32_t cu_mask_count;<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; uint32_t cu_flags;<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; bool is_user_cu_masked;<br>
              &gt;&gt;&gt; +};<br>
              &gt;&gt;&gt; +<br>
              &gt;&gt;&gt; +struct amdgpu_mqd {<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; unsigned mqd_size;<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; int (*init_mqd)(struct amdgpu_device
              *adev, void *mqd,<br>
              &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_mqd_prop *p);<br>
              &gt;&gt;&gt; +};<br>
              &gt;&gt;&gt; +<br>
              &gt;&gt;&gt; +/*<br>
              &gt;&gt;&gt; + * MES FW uses address(mqd_addr +
              sizeof(struct mqd) + <br>
              &gt;&gt;&gt; 3*sizeof(uint32_t))<br>
              &gt;&gt;&gt; + * as fence address and writes a 32 bit
              fence value to this address.<br>
              &gt;&gt;&gt; + * Driver needs to allocate at least 4 DWs
              extra memory in addition to<br>
              &gt;&gt;&gt; + * sizeof(struct mqd). Add 8 DWs and align
              to AMDGPU_GPU_PAGE_SIZE <br>
              &gt;&gt;&gt; for safety.<br>
              &gt;&gt;&gt; + */<br>
              &gt;&gt;&gt; +#define AMDGPU_MQD_SIZE_ALIGN(mqd_size) <br>
              &gt;&gt;&gt; AMDGPU_GPU_PAGE_ALIGN(((mqd_size) + 32))<br>
              &gt;&gt;&gt; +<br>
              &gt;&gt;&gt; &nbsp; #define amdgpu_mes_kiq_hw_init(adev,
              xcc_id) \<br>
              &gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev)-&gt;mes.kiq_hw_init((adev),
              (xcc_id))<br>
              &gt;&gt;&gt; &nbsp; #define amdgpu_mes_kiq_hw_fini(adev,
              xcc_id) \<br>
            </div>
          </span></font></div>
    </blockquote>
  </body>
</html>

--------------hwvtQKsnReO5gH2T86lNNk5e--
