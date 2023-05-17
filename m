Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C51C77B7D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 04:43:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8EBA10E00C;
	Wed, 17 May 2023 04:43:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C919E10E00C
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 04:43:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlTbGa8bld19FGIfbj6gWUlT/rw8oufo4Ocd0b5LgHeSMUQfsRnnqfTQ2d/HI+yxBpjVW3jbSuKKs4RBFTpMrAx1gGPf4/mMovE+JVAV+k10ESV8lRZbWQG4dg6rPIPd5D+BADR0hdcoMOyWT+mG0mY342ClqcblN+IzQYZW6lr2uEiOlyzM+eEGSzlOeChfbs3DO3qrdl5BMvJbqbOeR5ho79XNI6KbEpfKIXVdf/2SP0mX0raVhLlzM8gjDHQQz6j5GOGkVdUbzw2vtsrW7M2R8II56NmEHqv3bhVtaPyN2stEk7bQPczgq9Kea7q9DFLehphVKmPGQXs73DuiJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKAKh/hyBeKxQcmBpEFF+TW6IdXHTKrCmSSYzCPb5ck=;
 b=CVIYVJ6reLadk/kzcI3yzEyxUc+K+A12KX5AbHi9+UrpD7dSa4cAT/ZEyGKbVZFwLDa0ByAJfhuOm6Lh9fCOruh4iuu++4SM/j1liIPrNLkSl7s1miZ8cORlXdYxnYr0U2PTHKSil2AhDxTOfsY6tbGOHn0OL9NXTMDLdcX5vE/AsVyEiJ19vaXRRLYAaI0V4HBVdHbZnQVtxTGT2AOzHqWuIHwHoMIiQSyvA2YQLko/qSvkOnbyKrXHDbFe1aPVKuSDoUj6pBTJLmG3wC4kjCBEA+MsUp44qP+brw3TIaaFfxK0tbbN9JiI7yphLy8p8+Z9KoFf161Luzz1uaOqng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKAKh/hyBeKxQcmBpEFF+TW6IdXHTKrCmSSYzCPb5ck=;
 b=EVb0RZci57C4b7JH15JypZq/Qs9t4w7vXznlsq+uc0SN/b4YcRn1mhMjUBnsMCysi5XAJ95erhOtat7ckX4Nw48HOWlgIp8v8AE5f9PZmLluITdsD4PrXrJzxOSloMGRHZsX7IxqjNhMDYgD9hWnrWL/erdjZiu8yQ9+YNQ28CI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS0PR12MB7948.namprd12.prod.outlook.com (2603:10b6:8:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 04:43:34 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::db02:3271:73cf:2431]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::db02:3271:73cf:2431%6]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 04:43:33 +0000
Message-ID: <89d0c8be-d118-1b02-0406-835557d712b1@amd.com>
Date: Wed, 17 May 2023 10:13:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 0/3] Fix DCN 3.1.4 hangs on s2idle entry
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230516233420.2087-1-mario.limonciello@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230516233420.2087-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::16) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DS0PR12MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: 60808338-1d8f-4ee5-14f3-08db56914501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 425QCLZzpSfWAOD21aBqogOqMivc8LyjrZjZYrfPRTZmgfUkyWHC57aCIL1z7+jGTR9TEm+i35Jjj6PA5ou8SlXrxHBHS+S7Z6H8hiUcdNE/tFdz5NVYspFXLlvIdwwwji1VNsI+ljiUL8iDh3rcfNiRrOpNXb+cwCFgVgHvxcMD2ejwH/Qtgpcpvm/nFDkEpR6KEEpn0AjhJPF7as4md3Ry227PK2DBTbQbkqaGBHOQfyLHOSCXHJNbJQo1AVI4XJ+aAsyQaVYkOrVW3DJI99EUSMf7XzNBODnrwwPClc6N/GB0StuxasVFgUpY9BOdZpLDAlaWlt0mF5oxiZD5YDbADbgIVmBWaB/kSF2hxoZjumdl4t8tjOUgCVa6DNoK/KzFl9LO/can73mIphbsD6Q1+EApCA5cHErYB60o+YrWdoibW/WtmC+SaHxGRgPJcnitbn6dWcMj7BMgiBbinXTnuQ2YrXKoGv/ZHgHI8d0Axmt4kkuHS3VSitmmyy2K+jKXjemuZuMGF5rJXy7eIDw4c92jD4efYWzp6VtYoXUpnE94xOW9Y4VmTulFXPPsdzeob4lnWSsV5pg1RLnhMc2qCWXPSPyjyth8T+bIejyk2Kme0poEoS/sitkRm2ViiwOC5TUQnZUkejo25S+pag==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199021)(5660300002)(41300700001)(36756003)(2906002)(2616005)(83380400001)(86362001)(31696002)(38100700002)(26005)(186003)(6512007)(6506007)(8676002)(8936002)(53546011)(66556008)(66476007)(31686004)(66946007)(478600001)(6486002)(6666004)(316002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dSt6UkpVcTdOSFFCbk40OWdtUnQ3Rjg5VmF5bXdSUzJPZnQvOUh2V0Z6WjB2?=
 =?utf-8?B?ZGxNWDJqVTFLRjQwSmtqUzd2UDhxVmpXVXVhaEdDQWxJaFo2L3d0ZTRUVFI5?=
 =?utf-8?B?a2t5QkNqdlNnZDVMVWFCWk5YR09QT2dZZ28vYzVQK1VYZzI1VjRDdWZ6Mk4x?=
 =?utf-8?B?V1Jmclp1SGRpajN6V0kvdkFpdUM3UEdwL01ld3BzYkJsTWQ5UmNmNUhCOG9R?=
 =?utf-8?B?czFDVG1HUEdxNGtTNFlkZUV4d0liajNRb0w0b3NBa3lGWVgwWEdPZ2NJeXdE?=
 =?utf-8?B?ajV0Y21EV1pJZFRoZTFaQi9XTkRHV0pLOXE4c2ZLeFFUK1JwWURqUHFwdWJM?=
 =?utf-8?B?ekx4NS9XNkt2T1lNQWliMGYwdU9PeUQxbU9IUnpRV01LYmJaNDE5MjlNbXov?=
 =?utf-8?B?RUpyd3VzNXEvNXdNVkRhMGM5MDloM09sZUhkbGdINklsa3dpV3hyTTRIVXJS?=
 =?utf-8?B?WEpBczFTQlU4UHdSRWNvUjZFaitzM1NLVjJsbTdFRzZ4MG5CWnhReGI4MmZk?=
 =?utf-8?B?N0JQb3FTZFlOVHdKU2ZjNTl3ajROMTNCQUduYVZTYVl6aVM1MlY4T0ZyNXBn?=
 =?utf-8?B?cnN3QU9UaGd1K3hpWWtNUXNHZ3dIaG9SRkh4bnR4RURYdjFDZ0ZFcDM0MEFO?=
 =?utf-8?B?WDJ2alpldHh4NWZGd1kreklCb3dUTytzTzZFSVRjRFJIUHJwRDJZQVJ4TUNB?=
 =?utf-8?B?T0ZRbEEyRWt1VXVYb3Y0RDJnWWNjMWtBOW5JRG9DZkRTd3JFZ1pQYW9oNnRD?=
 =?utf-8?B?UGliODhEWUkxYnc0ZkZ4VTBUS1o0YzJ5YXRlMlpWWTBUbjVkMlRKOVh6c0JS?=
 =?utf-8?B?UnBwZWMxQXhITFNFNFBTbmxJcXNtbDNzdDFxVEN0ckM5S2JGaUExUXdEbnNU?=
 =?utf-8?B?ZzM3RUhwRUJTQmY1WmZKUDBxL3RLa0lhakdvN1NvSFQ3YVA5SWZWckFSNGpR?=
 =?utf-8?B?bkZVZjQ3YTlrZjZabkw4Znk2OVNhWU4yVWcyK21mblBWS0Z6eUM0dGhSVWhk?=
 =?utf-8?B?VDllUi9hcm9icHVCbnFxVjMwYkIrWjg3SGlWaXBjZUNNU29LNk15d3VYNUQx?=
 =?utf-8?B?YWdIUldSME1TTlR3b1VZUldMV1pCV3FBVWJkR2VnMlRWejduaWs2Z29TS3pj?=
 =?utf-8?B?ZWQ3VUVBVmVpMkgzUmtWMWlmWEtzbS9DNWc1ZXpmcTBqa2NLTFhzV1pqaElu?=
 =?utf-8?B?QmFnWjFmQWxzdGZNbFkvU3ppZ1NKYjhiTzU4eTV6b0htRmJQT0QzZWdjSWxh?=
 =?utf-8?B?cTZ5UkxqNUhGaW5MbUdhem44a2hKSWlhRXNOU1dPS2pMNnBVbTA2UDFpWnBo?=
 =?utf-8?B?ZFVoUm1rajhLSHJCcGhCaFlGbExneDcyWkhuREhkT0dGK3ZOVmI0N3NxL0tR?=
 =?utf-8?B?cmtUMTFmYzcvTlRVK0szd2FHT2VIbk5abXJzNWtLWE1GZTF2dlZYRFQ1UXJC?=
 =?utf-8?B?eUVMUCtnZWhzT3pMZXE3TEYxRHY4RUErSEU1WVFkYTlIbXpSTml5MU51a0Fj?=
 =?utf-8?B?Y2J2cXYxVHprcVorUnA0OHJJRUR1Z3RRYk9BNys4MXR0d2p3bXNsenVpQkFP?=
 =?utf-8?B?UWtVUExQU2Jyb09PMzdPWkowR2JqUDhUWUtUSUxjNDd0Tmx6OG1FSkJvVGd6?=
 =?utf-8?B?RlZveUhDV3VCMkxDN3BaTmptRVJiU09mYm1hR3RQS01TUW9YQXhqMWtqRW15?=
 =?utf-8?B?ZUZidThQalp3eUs2Z0FZL3dHWEpEVUZVQWdvWFBJYk5BZENxZ0s2c0pVeFlR?=
 =?utf-8?B?UnlFYy80RVpmeFNZUk9sVkwyNUhkWUw4OHpiSEdTSzNCeWtXZXE4eGxlejlk?=
 =?utf-8?B?UXUyNFVJR0c1b3Vic1hKdUY0L2IyZHQ0MWwvaFIraWlXUFJ3cm5nWGR5MjVo?=
 =?utf-8?B?K1FyVkpvcUovSUU2MTFFanBnRSsxRlNESzhMWkpjN3U1cWZxNVk3akFONU1V?=
 =?utf-8?B?TWt3SjU3QjNSaFo2VXJiQkhaSGh4bFNRd3VnaUM1cDZJcXYvQllkUEVZN3B2?=
 =?utf-8?B?MzRtVWRwTThlNXJuZU4rNjIvSnIxelJrNDFzMnNKZGo1UCtvRm1mWi9GamFI?=
 =?utf-8?B?QkZjZXo0VTkvSFAyZ0ZOUE5XS2Z6V2xyYzBKc0gwcC9pVkNKOXVTM0NNVXJ3?=
 =?utf-8?Q?qg3gFWX4JBH0PFLix5xR1Ntoe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60808338-1d8f-4ee5-14f3-08db56914501
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 04:43:33.5517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38k8+KLBPnOx2caQjIBgMnE8oEW4wGMoXPcbAh7VwWwnTQX3YAKdbAyP/qE2EWTy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7948
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
Cc: anson.tsao@amd.com, Juan.Martinez@amd.com, richard.gong@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/17/2023 5:04 AM, Mario Limonciello wrote:
> DCN 3.1.4 s2idle entry will hang
> occasionally on s2idle entry, but only if running Wayland and only
> when using `systemctl suspend`, not `echo mem | tee /sys/power/state`.
> 
> This happens because using `systemctl suspend` will cause the screen
> to lock right before writing mem into /sys/power/state.
> 

A couple of things on this since this mentions systemctl suspend -

1) If in s2idle, it's supposed to immediately signal and not schedule 
delayed work

3964b0c2e843334858da99db881859faa4df241d drm/amdgpu: complete gfxoff 
allow signal during suspend without delay

2) RLC is never stopped on GFX 10 or greater.

Wondering if the code hides something else because of the timing.

Thanks,
Lijo

> This causes a delayed GFXOFF entry to be scheduled right before s2idle
> entry.  If the workqueue doesn't get processed before the RLC is turned
> off the system is hung. Even if the workqueue *does* get processed, there
> is a race between the APU microcontrollers and driver for whether GFX
> is actually powered off when RLC is turned off.
> 
> To avoid this issue, flush the workqueue on s2idle entry and ensure that
> GFX is really in GFXOFF before any sensitive register accesses occur.
> 
> Mario Limonciello (3):
>    drm/amd: Flush any delayed gfxoff on suspend entry
>    drm/amd: Poll for GFX core to be off
>    drm/amd: Skip RLC suspend for s0ix on PSP 13.0.4 and 13.0.11
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 18 ++++++++++++++++
>   drivers/gpu/drm/amd/include/amd_shared.h   |  1 +
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  |  4 ++--
>   4 files changed, 46 insertions(+), 2 deletions(-)
> 
