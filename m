Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004ECC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 21:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AECDB60E9B
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 21:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AECDB60E9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 442266EA8C;
	Fri, 29 Oct 2021 21:04:03 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2082.outbound.protection.outlook.com [40.107.95.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE0B66EA8B
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 21:04:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+bxh/IX2zsGeI33DxZQt8A/lQJlmfkmp/cs/IxwMNM359JXbJdMgKXid2Vb3I/9fm3nhz9NCNtnhl6Ql86VAitssLE5I+RuvD/pSXXxiFhwF95wPDbrWUnMsRspzbfXmCTWWCRZ8rC1aUpOM8iafk01DA4PHQY+ruhRIekmBsAQO9eWqptJVfap2zzfuYLxNbd5H+W/U+dAUvarkFq/z+0rqMDOeueiOdDBIi6wn7xne9a5V8K8fRIZNqRKuD+G4qxwkfMEZrxjzD8qdGycH7TzLrJNJKL/k8sfUKMzjwkA7b9r+EI/+MQaKeahsArgFh2yL32Ge+txccA806ab2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4Rf5vafp3/j4n4Ok6T2dOw4ufN6UsXQh77XdBY7ugo=;
 b=fCqwX1wHqaY/YaR2ca7dZNNw/htl4eDLs9En4hS3N5McwRegC49HI6Zr9qZUKRan7Tu0aNGjiQvAnPlPvgNKNvevPbrlA18b2RstFTQdf/Bf8MvoF5Om00EnPNzG1Vngw4PHom4wjvubkajfcPL111V1BFcVAPtKtBNoPuJ0ATp9hSAf3uujFkx6rGGJQu6KunsiCZ+yvl1JBu0T+oBju2tRYhn3ElP7n+oN2akXsxgUgiOZe1m7lE9SvhRtjo6YCTowkOpaeiM70GACp7uoFTwIf8xH46oTdWITNtzRFe57FIKe5TDPbK+HWkxtewNJ45ddJrZnmeGXdHTMJ1AJ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4Rf5vafp3/j4n4Ok6T2dOw4ufN6UsXQh77XdBY7ugo=;
 b=tSuEVGmCbIdja1nADXjZQUvgOPumuy626HVcjH+SQKLP+qqM4rHEdDGAYhERoTdRtOa9Edf3PQ+U9Hxu9gtZQ45wauedEjQ5C09/yGdC1kIfiDZKgov5HxfOPLwEuqgVFKjHzb++bv2iXapEdpjoMg0F6DizNHiCyjUA0TXLhCg=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 21:03:59 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea%6]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 21:03:59 +0000
Message-ID: <0ba94bc5-3049-1e38-241b-f58f47cb166e@amd.com>
Date: Fri, 29 Oct 2021 16:03:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] drm/amdgpu/pm: drop pp_power_profile_mode support for
 yellow carp
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20211029153343.17437-1-mario.limonciello@amd.com>
 <CADnq5_MYeJF38_-FzHU7GPwhDpUiZwMQQ+naOpgXsTig_42D_A@mail.gmail.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_MYeJF38_-FzHU7GPwhDpUiZwMQQ+naOpgXsTig_42D_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR18CA0026.namprd18.prod.outlook.com
 (2603:10b6:208:23c::31) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
Received: from [10.254.54.68] (165.204.77.11) by
 MN2PR18CA0026.namprd18.prod.outlook.com (2603:10b6:208:23c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Fri, 29 Oct 2021 21:03:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89dec24f-bea2-4de2-a722-08d99b1fa0f4
X-MS-TrafficTypeDiagnostic: SA0PR12MB4349:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4349B25FB922A4235B3F8B29E2879@SA0PR12MB4349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:24;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a0/2Gk2r5+EJcoyTKX6FD1UFAMRV9M6gF2ifT/wUyY8WwIg+Dqzx8ylPy8/YuS0qj6Z5ItSDoEvxRfI1PaakeeNvPOfwYztmT+FKvlyDCFwA2klHNbG14559jfBFShU4dgRxuWymchOGp9AU95MOaaIC25kSpvYFGUAmJM5bu/flsVR6kGjsEcmFa9t/l8vmchfqWLDJWP8bAZCHx6uIRAR3ZoRcuUCGBEVJ1D7TIORyWflAGOGfe0i4GlW2I/SJYuo0YQSepMCblJZMFAfKgpmhuke01lpHSYL/kIWiCLe3Ul6I6VDRPEZ68PYPEKe0/a5V5ks4YLDFAYFpIwXPWnAonO8Kbb+QTEsEmHu6FHpkyRSW7lBFRt0D89p5QnbMSQShN1aI5vwoZMNpFVeEWcxuVGW/fANd7Y948NhCUJl8wAOljDy+U06bIWES5/1ZTXNMkfZPMbcXcnAddcKzIA8YfPbK7/noQRKS8Poo4AEG1JMNwswH4dzhgXE9iN4x3ANe0FwEFaefRkTJK7T9n+/fn8v3WbL/dbjlnxAKVUhDjbC26yCqg5jDarG6VR0oQSrKEE1rY3ZI7h8av/PdGZYBxkQhu3sseH8oI4WGfVxBGL6XbcuVTpCtzvoGJeVzSBIhOVFTRmlPwZWN3fkgUwWcz/sOECXFq2+fmGietNAcpWRvIXb8kG52pL3yu8UY9IefvvXfUUy5cHzcEnccCRfRBattiRHx2qnr9rX0kJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4510.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(38100700002)(956004)(2906002)(31696002)(31686004)(4326008)(53546011)(66556008)(6486002)(508600001)(66476007)(19627235002)(186003)(16576012)(8936002)(8676002)(36756003)(2616005)(86362001)(66946007)(26005)(83380400001)(316002)(6666004)(6916009)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3pHSjJzdWZRdU1BV3Bzdm50S1lJb1dBYnBaam8wN2pRZjhURE52VlA4M2RH?=
 =?utf-8?B?NVk5bTVZOUxhem8wd245b3RrK1dRUEREM2JZYUpzOFZnbjI2THJNaEZUZ25I?=
 =?utf-8?B?cXgwUG5KZkwyZUJJQkZTQ3FJTWg4cDFwak5rSmdGM1laSC9LazVscHJQQ1ZE?=
 =?utf-8?B?aStyQ3BsOG1tK3YxSHZ6TWFHL29uY2xIZEFjTUNzcnVTTWRHNWE3ZUlYUTJZ?=
 =?utf-8?B?U1IvMFRMT0w3MkllNW5vWE1MbnZyUjBRWVB0Y0dSTXk2aVVwUG9mUTQ2YVJG?=
 =?utf-8?B?QVd6VGpaaWNWWGh5dlZVWStaOS9zbE1janVhdVNqN3RwUHJKeUZ4dmU5UDgr?=
 =?utf-8?B?M3FNK2RuQnEwTEFrZnNQbG1jaVZ0VmJmODJYU0EzN1I3cDMrZVFMaGNoeVB3?=
 =?utf-8?B?aG5BY2s5SkhBZnYzRVBWNElpdDFzZkV3cE9Rc2RsNW5oQVZtaFFRTFc2WUtw?=
 =?utf-8?B?aEViVzRtUjBqcDRxa1hGTkpaM3oydGpNRVJmMHVzdzJCUFdrMGtsaHpMUGM5?=
 =?utf-8?B?MnNKR1VFYlUxRTlZWGg2bndHNUFhbXVQbFR5ckF6MXVGLzNVUStxK1NwNVVZ?=
 =?utf-8?B?THlvNDVxVTkwNGpsY2MvU2RZTkI5UGJxdXR5cklVUEpnYmdzWkJYWUJnZDl0?=
 =?utf-8?B?M3BoN0dZeTNxdUQ4b1cxZlByVncycDZnSWpxNS9KY2daaG9jdXdZOUlvUE5l?=
 =?utf-8?B?OUo2b3RMT1kwRWkzMzB5aHQzZG0vbXBRbFJGS3FCUTRWdnYyaTR4K05sYnhX?=
 =?utf-8?B?SFNPSEtBTy9MM3VuOWYzOFdzQWVseHNDVysxdDhtNHpLaERKRE8rSDkrVmdM?=
 =?utf-8?B?WEtPUWQyV1NEc0ZTZjlIR3BDcmppRXU5ek1PZnlLd2J6QlR0TXliSWFQaTZY?=
 =?utf-8?B?bldscXB2OFhLR2VRT251S25pbXV4d2hqR0Q3VGd6OGF5emM0QWJyTGMzVkV0?=
 =?utf-8?B?K1MwdVFWV2RtTDZsdk44cFd5WThaM254WU9DekFCNWJyVjFPck55MFN1OHR0?=
 =?utf-8?B?aGprQ3FhYUxzV29lcnJ1cXJ0R2ozekhrcVh6TTFuZTlsMUhDSmp3SDcybjJE?=
 =?utf-8?B?b1FsMnkwT1lqNG9VbDhHSGpDbmVNRFc0b1g3cW5XcmZock5ycy80TWErZnkz?=
 =?utf-8?B?THNJL2gzR1hjMEl6MXZQT3ErNzZReDVmU29HeC84MmluS2dpWm00Q1ZYQ1kw?=
 =?utf-8?B?Y3pDTUVlRWtVRHhzMml0MEhEL2o3dmRDbCtnM28yc2JwTEF2bTBlSW1saGtX?=
 =?utf-8?B?ZWRwSHNUc2JJWjBVQVA5dGpxek8xcEdldC9VTlNaSzlyelFkdU4vMGxBMmNN?=
 =?utf-8?B?aFZXVkZTKzNFZVdEQnppUHpBNi9tYk1jTGRwd0NWei9ONXlTMk4xYm9BR25p?=
 =?utf-8?B?a3diT2pDcjY5aStLUnZaRDV1QkxrNGFmNktYTmZiR1hGK09rRXNYVERQL2FS?=
 =?utf-8?B?TkhlRE9SY3NVR2RlckNuQ1Q3TXhNR1lveGRGY0l6M3hoK1NzQW9ZdVQrd1hF?=
 =?utf-8?B?MGlxQ3VTOGp6VC85YjFidDJoNVhic285MlJTcU45bFc0S2d6NU9GWkRwcUdE?=
 =?utf-8?B?eE9zdHFUdm1xaDJlYjNDMktydk1kQkdwVlUvZkZxbDZNU3FibXE0RWFUUTUx?=
 =?utf-8?B?aDlGZVVXRXNqQVRvWmJVU0ZCc3hUZHJnRThnZXZLQ3pqT2lyVTZFazh3Mzlu?=
 =?utf-8?B?ZGhHQkFvYjg1N05mbGVTMCtua2ZLTUx3S1JZajR5cFpDWE9hSGw1QVJ3ZWhu?=
 =?utf-8?B?K0JiNXo5MXRUNzV1azJFd0FvNG9mWTJHZGpMNFZKSXpaNWlVU3FHZ29MdEky?=
 =?utf-8?B?MGU3T0dyK0N5eXRmU0NURndiRGdxZFllbUhJNUg2SnZEL3FWYk02SFp2dDRl?=
 =?utf-8?B?M2RZNzZ2bVlIR1JvaUhhQnI2cjBtZVI0cVYvSnRMRHlrenBPVW8zM3FsOXBk?=
 =?utf-8?B?MzlRdFg3cDM5RU9MU2hxL1VCa1NMSzN6U3lmaVZwb2UwKzBCYXJ5ZmxvWFNE?=
 =?utf-8?B?WXRERW1McWNVeWV4TjRPYmR0QVdCT2xwcFptRFJtSnRzSm4yWk9PamYxNzI3?=
 =?utf-8?B?bzhWZmZMU001TzRLQXIzVk9RUFlpK2JwcUdmN2NIUjJNYnF1d1N2U0MycUZQ?=
 =?utf-8?B?am5KbmZublk5VlRvUy9nTW1ZSmRKTkhPbnh5cjZVVGN0MGVZRjBOVGE5L05E?=
 =?utf-8?Q?bnYmqUeaVrT8qsSI2fIaUVM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89dec24f-bea2-4de2-a722-08d99b1fa0f4
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 21:03:59.7530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27OHhqSu08+6L7dbxC9pnn2VjZRKgTbDD3vgTNRYeHKJFXM3kPBesPW4N8b131EzJ+M/au0j2/y9nTdPF46ahQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4349
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

On 10/29/2021 15:57, Alex Deucher wrote:
> On Fri, Oct 29, 2021 at 11:34 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> This was added by commit bd8dcea93a7d ("drm/amd/pm: add callbacks to
>> read/write sysfs file pp_power_profile_mode") but the feature was
>> deprecated from PMFW.  Remove it from the driver.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Probably want something like the following too:
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index c255b4b8e685..c1b8ed9f7ba8 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2092,6 +2092,9 @@ static int default_attr_update(struct
> amdgpu_device *adev, struct amdgpu_device_
>          } else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
>                  if (!(asic_type == CHIP_VANGOGH || asic_type ==
> CHIP_SIENNA_CICHLID))
>                          *states = ATTR_STATE_UNSUPPORTED;
> +       } else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
> +               if (asic_type == CHIP_YELLOW_CARP)
> +                       *states = ATTR_STATE_UNSUPPORTED;
>          }
> 
>          switch (asic_type) {
> 
> So we don't expose the sysfs knob on the YC, but that can be a follow
> up patch if you want.

I guess for now something like that makes sense.  I'll send a follow up.

> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> 
>> ---
>> Changes from v1->v2:
>>   * Drop changes to RN and VGH as the deprecation is only in YC.
>>   * Leave PPSMC_MSG_ActiveProcessNotify message but mark deprecated
>>   * Rename PPSMC_MSG_SPARE0 to align to the name used by PMFW (PPSMC_MSG_SPARE)
>>
>>   .../gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h    |  4 +-
>>   .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 87 -------------------
>>   2 files changed, 2 insertions(+), 89 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
>> index 1d3447991d0c..fc9198846e70 100644
>> --- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
>> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
>> @@ -51,7 +51,7 @@
>>   #define PPSMC_MSG_PowerUpVcn                    0x07 ///< Power up VCN; VCN is power gated by default
>>   #define PPSMC_MSG_SetHardMinVcn                 0x08 ///< For wireless display
>>   #define PPSMC_MSG_SetSoftMinGfxclk              0x09 ///< Set SoftMin for GFXCLK, argument is frequency in MHz
>> -#define PPSMC_MSG_ActiveProcessNotify           0x0A ///< Set active work load type
>> +#define PPSMC_MSG_ActiveProcessNotify           0x0A ///< Deprecated (Not to be used)
>>   #define PPSMC_MSG_ForcePowerDownGfx             0x0B ///< Force power down GFX, i.e. enter GFXOFF
>>   #define PPSMC_MSG_PrepareMp1ForUnload           0x0C ///< Prepare PMFW for GFX driver unload
>>   #define PPSMC_MSG_SetDriverDramAddrHigh         0x0D ///< Set high 32 bits of DRAM address for Driver table transfer
>> @@ -63,7 +63,7 @@
>>   #define PPSMC_MSG_SetHardMinSocclkByFreq        0x13 ///< Set hard min for SOC CLK
>>   #define PPSMC_MSG_SetSoftMinFclk                0x14 ///< Set hard min for FCLK
>>   #define PPSMC_MSG_SetSoftMinVcn                 0x15 ///< Set soft min for VCN clocks (VCLK and DCLK)
>> -#define PPSMC_MSG_SPARE0                        0x16 ///< Spared
>> +#define PPSMC_MSG_SPARE                         0x16 ///< Spare
>>   #define PPSMC_MSG_GetGfxclkFrequency            0x17 ///< Get GFX clock frequency
>>   #define PPSMC_MSG_GetFclkFrequency              0x18 ///< Get FCLK frequency
>>   #define PPSMC_MSG_AllowGfxOff                   0x19 ///< Inform PMFW of allowing GFXOFF entry
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>> index a403657151ba..8215bbf5ed7c 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>> @@ -64,7 +64,6 @@ static struct cmn2asic_msg_mapping yellow_carp_message_map[SMU_MSG_MAX_COUNT] =
>>          MSG_MAP(PowerDownVcn,                   PPSMC_MSG_PowerDownVcn,                 1),
>>          MSG_MAP(PowerUpVcn,                     PPSMC_MSG_PowerUpVcn,                   1),
>>          MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,                1),
>> -       MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,          1),
>>          MSG_MAP(PrepareMp1ForUnload,            PPSMC_MSG_PrepareMp1ForUnload,      1),
>>          MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddrHigh,        1),
>>          MSG_MAP(SetDriverDramAddrLow,           PPSMC_MSG_SetDriverDramAddrLow,         1),
>> @@ -135,14 +134,6 @@ static struct cmn2asic_mapping yellow_carp_table_map[SMU_TABLE_COUNT] = {
>>          TAB_MAP_VALID(CUSTOM_DPM),
>>          TAB_MAP_VALID(DPMCLOCKS),
>>   };
>> -
>> -static struct cmn2asic_mapping yellow_carp_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
>> -       WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,         WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
>> -       WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,                WORKLOAD_PPLIB_VIDEO_BIT),
>> -       WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,                   WORKLOAD_PPLIB_VR_BIT),
>> -       WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,              WORKLOAD_PPLIB_COMPUTE_BIT),
>> -       WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,               WORKLOAD_PPLIB_CUSTOM_BIT),
>> -};
>>
>>   static int yellow_carp_init_smc_tables(struct smu_context *smu)
>>   {
>> @@ -543,81 +534,6 @@ static int yellow_carp_set_watermarks_table(struct smu_context *smu,
>>          return 0;
>>   }
>>
>> -static int yellow_carp_get_power_profile_mode(struct smu_context *smu,
>> -                                               char *buf)
>> -{
>> -       static const char *profile_name[] = {
>> -                                       "BOOTUP_DEFAULT",
>> -                                       "3D_FULL_SCREEN",
>> -                                       "POWER_SAVING",
>> -                                       "VIDEO",
>> -                                       "VR",
>> -                                       "COMPUTE",
>> -                                       "CUSTOM"};
>> -       uint32_t i, size = 0;
>> -       int16_t workload_type = 0;
>> -
>> -       if (!buf)
>> -               return -EINVAL;
>> -
>> -       for (i = 0; i <= PP_SMC_POWER_PROFILE_CUSTOM; i++) {
>> -               /*
>> -                * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT.
>> -                * Not all profile modes are supported on yellow carp.
>> -                */
>> -               workload_type = smu_cmn_to_asic_specific_index(smu,
>> -                                                              CMN2ASIC_MAPPING_WORKLOAD,
>> -                                                              i);
>> -
>> -               if (workload_type < 0)
>> -                       continue;
>> -
>> -               size += sysfs_emit_at(buf, size, "%2d %14s%s\n",
>> -                       i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
>> -       }
>> -
>> -       return size;
>> -}
>> -
>> -static int yellow_carp_set_power_profile_mode(struct smu_context *smu,
>> -                                               long *input, uint32_t size)
>> -{
>> -       int workload_type, ret;
>> -       uint32_t profile_mode = input[size];
>> -
>> -       if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
>> -               dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
>> -               return -EINVAL;
>> -       }
>> -
>> -       if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
>> -                       profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
>> -               return 0;
>> -
>> -       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>> -       workload_type = smu_cmn_to_asic_specific_index(smu,
>> -                                                      CMN2ASIC_MAPPING_WORKLOAD,
>> -                                                      profile_mode);
>> -       if (workload_type < 0) {
>> -               dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on YELLOWCARP\n",
>> -                                       profile_mode);
>> -               return -EINVAL;
>> -       }
>> -
>> -       ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
>> -                                   1 << workload_type,
>> -                                   NULL);
>> -       if (ret) {
>> -               dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
>> -                                       workload_type);
>> -               return ret;
>> -       }
>> -
>> -       smu->power_profile_mode = profile_mode;
>> -
>> -       return 0;
>> -}
>> -
>>   static ssize_t yellow_carp_get_gpu_metrics(struct smu_context *smu,
>>                                                  void **table)
>>   {
>> @@ -1238,8 +1154,6 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
>>          .read_sensor = yellow_carp_read_sensor,
>>          .is_dpm_running = yellow_carp_is_dpm_running,
>>          .set_watermarks_table = yellow_carp_set_watermarks_table,
>> -       .get_power_profile_mode = yellow_carp_get_power_profile_mode,
>> -       .set_power_profile_mode = yellow_carp_set_power_profile_mode,
>>          .get_gpu_metrics = yellow_carp_get_gpu_metrics,
>>          .get_enabled_mask = smu_cmn_get_enabled_32_bits_mask,
>>          .get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
>> @@ -1261,6 +1175,5 @@ void yellow_carp_set_ppt_funcs(struct smu_context *smu)
>>          smu->message_map = yellow_carp_message_map;
>>          smu->feature_map = yellow_carp_feature_mask_map;
>>          smu->table_map = yellow_carp_table_map;
>> -       smu->workload_map = yellow_carp_workload_map;
>>          smu->is_apu = true;
>>   }
>>
>> base-commit: b785098f70a5ed2488becbdd5921054053034439
>> --
>> 2.25.1
>>

