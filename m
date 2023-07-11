Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E68EB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jul 2023 19:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41C2210E42A;
	Tue, 11 Jul 2023 19:52:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D174010E42A
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jul 2023 19:51:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJeWGVqe9IWArioNlZu09CCsdGtTk1R4a23xABGEXCqUYvMrNtMDbgGh1spiU7KORRQ+Vz2GAbze2VCKua0TMPCI25iwIrK+eLSvDnhHjtsHJ+VC+H5R0w1lWeSq5EXsUsTnjJCQnoXVDS6c7ePLTRUlsBa/BY1cG+/MWR3wBqLijcEfktz7hORIR4dNcXmlfwcsm75ERUAg1Jky/aV3AcQfSQmVBWUkDyWwLbz9shxBTlI+Ci4cxth0liIH4g4RZyIDIIsrx4EbHuQB0VO/2uuI7hPmhMzjZNQtkQdOgs+RdqnC/4Ns3gFMYU9mDDw7ksdDml0SsZICxykX4kwkHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SgBJ/gJKr3c4GCS5RFQHIw8lCjEYG0mWs5QJ20/R08=;
 b=As8V89ruj0V3jM3XeGSAcb1Thx0T9b5o4U0GaUwfmKztchO+0qsaTwL+DI6BDWRiZ1sHVU7tIk9HtU5naV0e1SMESk+XHJs9cFeYB/v58yXZbTLctZOquILK6Y/KbKIetBmdcvV7nmguNnRag/mK6L17iSiQIf66kPlWQMA/jkc0Hj4dZHEOxgFJkWyf9N6a8HxSXZp0jaaPaGWTpLpxZcXnXoGJ/E1VdB2B+t1XAmpmhSX/F/St+6dPHYRQl+ypDXSPcMT0otNPb9W07CoHyZpqtFCqdYx/3iTRCQrqSrOtCz7lPj632Z50SwQVUlcS9J8tZMTahWQLzpVSz8ofAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SgBJ/gJKr3c4GCS5RFQHIw8lCjEYG0mWs5QJ20/R08=;
 b=GN0Vzd0j0nCG23UwhDIsBfn0+oo0dV2SLz/XBXkzLqy67ElkkNgo+hHJFFp6RR8i1BRt042cA5+qvIAzddQadlc5J5EaOLy8SVxX6C8K14XQ99eXaJGt5L6s9TXQ+jWc8NCtmWfgA+HkfjOVFakmWj4w5kU5O3M/GVXnd0plIQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB4518.namprd12.prod.outlook.com (2603:10b6:208:266::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Tue, 11 Jul
 2023 19:51:50 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 19:51:49 +0000
Message-ID: <435820e9-1680-3687-4930-bf7ea5967568@amd.com>
Date: Tue, 11 Jul 2023 15:51:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 04/10] drm/amdgpu: create GFX-gen11 usermode queue
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-5-shashank.sharma@amd.com>
 <56fbaa22-285f-1030-1822-36d542de4ecd@amd.com>
 <c87cd5f9-b940-0bad-6cfe-c8640693b426@amd.com>
 <e669c8cd-9fc2-73c6-c8f0-140695f17156@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <e669c8cd-9fc2-73c6-c8f0-140695f17156@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN2PR12MB4518:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e2ee614-77df-4dfa-b8b2-08db8248440f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6Wuu8kRe6BRS8QrH7fpSPdD5eEDDndZk+qXFTVANwO/Nb5I3g0UcGl2CSgdBqEH/xfGeoE6bCrPzDPOkkajnIQLhRnL8+VYxI0ab57yA3ZhRjmIV2pxk7tQ/b/n0modPFXbhW4yHH99YQNF3+Rdn/YM7nVVmxb969pseUma16pl9yqnJrZauFqdl8qf6W9RZLmFC26TPGFwuP4ZDPsQhBUJf7W6jNm2IP+LRXsIF34E7ky6dg7rieswjg2ku7lSnAo1OQ1Nc3odkpD4p8kE339l+pIITnQAhIxgt9yKLNkk7YoEmG+1v8ewz6ahH+5HaO4ZxBG9H2Kl4i9cj8ztZbX3UgGHN75NwXogYJRCrov9mBV1qed6KiA7Jde0quGsFYKFWHr99z8i2I+vGBoqPSGqjXBhOW1zd+HYNugrxLGjBI8BNHc1YcfmOcdtIYRBTwT7jhEesxBkad86+RnhxuaJvvZ9vq/XF3/QMBNKaM4IWk5EF8AYMifPjAKTd8b3IAcKKQmQjGhUaFMbWs81MYEK2DMGrzwsMMZkTqkpvbKJ7M19w2X/11haVMlnA+mX+N2kVhmiMHmBFagBauYq7qZ7aHqUT2/JqM7USpjfAJ5LJEBOoUE3lp1vDUPgangsj2MAFpzvTcCNnLtXawCXPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199021)(36916002)(6486002)(38100700002)(26005)(6506007)(83380400001)(53546011)(66574015)(2616005)(36756003)(186003)(6512007)(4326008)(2906002)(31696002)(316002)(41300700001)(66556008)(66946007)(31686004)(44832011)(86362001)(66476007)(8936002)(8676002)(5660300002)(110136005)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVhWWnVOWEtaU2F5U1hqZnEyRFZ4U0ppMEZDRmM0Wk0zK1cxMFZoZXJhRWlK?=
 =?utf-8?B?RTE0WVd6YUNqYk9pdE9DM0NlL1U0dVl2S3kvNzJmSWtlWkI3MGlNRVE3WnFi?=
 =?utf-8?B?YUFQN1FGeG1LMTV4dUFWMXNQN0NrY1JtUlZ6S1kxMW9WaEloSXJkNTNqclZk?=
 =?utf-8?B?c0JkYURxdG9tL3ZBNCtSRzNSN2xIRHg1UkF1Z2FSQlFIUENRQUN5dXFEVVo0?=
 =?utf-8?B?NEVnRnlJSU5nRmZnVzV4SEMva25WbmYvSjVFMTR3RGlva3ZXeFQ0YzB2QXdQ?=
 =?utf-8?B?b3JaWFFTM0pGU1Jsd1RTRDQ3anJHVWxrMXFlek1JUG9NZi9nT1d5ZjZvSXBw?=
 =?utf-8?B?RHVrVDJtQWpuLzhOK2U0Qlpta3ptUWFRcm5iN3QydXBHN0dHakZUNXgzZWVj?=
 =?utf-8?B?Ni9zUFhIQ1VCY2ErdlIrSDA0dWhnMXdHb3JwYXNoR1hpVGl2NWNXVE9UMmJn?=
 =?utf-8?B?YVdkU09MQkVJd2QwQ1RDYTNhekJXRDlqMTBOVTVucUltbUh6NllhN01POTB2?=
 =?utf-8?B?YzRtclpwSVByT2V4SWZNVE1UQXV1ZU1mckJ1NXRVeEZ3MVF3Rityb3RVTW1r?=
 =?utf-8?B?aTExTUxOMm8xQmxMSkRySHZ2dE1qWVhqQTNnTzFYMEtUMS90cE5xM3F6VjUz?=
 =?utf-8?B?N3lBMWNqYXdoZ0NkNTNxWEUzcnJrWFowVFlTeGsyWWNFdDQxNC9kVCs4MFVD?=
 =?utf-8?B?aWVKN2IzTVNIdzNSRVdkUktyOXVWbnp2MWNCblpIUXY5SC92dDdZaGMrd3R0?=
 =?utf-8?B?cWRaYVFPZDI3aEJxVFBkTHVWdTdJeFlVaExPVjJPQUpUTkdCZ1VFQ3VSUnlB?=
 =?utf-8?B?MEhQQXI1WC9uWE8vbERBMUJUb05pb0pGbHBqdFczRGEzR1h3VUdLVVQ0VGRX?=
 =?utf-8?B?QTJmTEpDbGNoQ3dXWDBiUWRNMG5kbG5vUVdxSi9VajMyTnZBV1J3aG9WTW9n?=
 =?utf-8?B?NTg5ZE0xR0FjYXhxdnN3YVRjSEozbUxMVFA3QXVOdCtYT3UrQjZ1UlZvYnl6?=
 =?utf-8?B?Q0tMODFUMzIzU25VQ21WSVlzeDJ2UTF6cDNqa0h5eFRlV1lLK3JMSDJtRWFi?=
 =?utf-8?B?WDBCOFpCQUl3YytJTElxSDFXUjNnYlNoZ3ozeGdKeVhCdnNlSmJQcGlvLzBh?=
 =?utf-8?B?NFdyZnpIWGMxWnN2bGRYNEZZY0JFRUdSV0JsblRpeDdocTc4bXJRa2FNZUxQ?=
 =?utf-8?B?cUp5bGpuZ3lEdEsyUnZlN3Q5TDVOaXl2WFpzaUlOVkt6dGhGckJRMlNpR09j?=
 =?utf-8?B?cmVNNmtacDVGdU94WExOUHdaS0pLWiszTnVtL2EzVHFTR1FudEdFQ0xacks0?=
 =?utf-8?B?ZXExaUd1WVdoMzZlbjNrVlZ0elB2YmQ2ZTNhdEVxZndlbFl1K0llSzZuWnc0?=
 =?utf-8?B?c3hsOHd4Wi9CQTNXMUxBVFBRNTRjWXRvT3pqSVhiYXI3SlVSZnZ5RlRHSVpl?=
 =?utf-8?B?cUxUZERQZDZtWm9mTmw0V3ZGK0sxNGs1OU1NbUdJQ0k3eUNlYUU0ZHdPRjdV?=
 =?utf-8?B?ekoxRVkyME9BK2RMcnB3Uk5BVUFNdkpCK3A2ZFpkdmU3RGRrL3FZNHRQajVM?=
 =?utf-8?B?bWtVM24rNGxXd05HU2pjZjFTNmtMMS9ZTWx4YUxYRUtlWkgzbmRIaG1pTDRZ?=
 =?utf-8?B?amtIQmMwbUpzdnFIZlA2aFNrcU1HZ0lxeDF1WkkxVkFpUTFPS3R6eVZiYkNC?=
 =?utf-8?B?UE1KalBsbkpBSFh0Wno2YzN1UC9WQTRDYW5kZkVVbGtRQXk4TXVFWW5KaitF?=
 =?utf-8?B?QXRDNk85aU00Sms1WDZETzR3dWJURHJVQzhObHgyTGNTSzI5NGRyTTRSVUdR?=
 =?utf-8?B?L0NqVkhGTXkraXQvMW00MGxQRUhLbmlvRGFXR3MrTUc1MTE0dlNOdjh2RXFJ?=
 =?utf-8?B?Q2hqdmwzT3BjK2dRUFlGMTFYNzVxcHhLZGhPZm01Ry91RnRqRVUrZHNtUlo4?=
 =?utf-8?B?ZDQvVzREb1B0WFE1aGE3dWxScWVabWFacHVoc0RlNUd2V0J2NHBSMUY0YjZT?=
 =?utf-8?B?a21HQUtEam5TUDFnUGZrRi80S1d3NVNZR1FLN1VCaVBnbnFoOG5FaG81RWpE?=
 =?utf-8?B?L0VIN1d0U1VGZUNDTE5idVptRkJEb1FOMTM3TkNhdGFVY1pXUnd3L0xObFNS?=
 =?utf-8?Q?tnX/QVseOgvl5IMPl+Ctdtlqk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2ee614-77df-4dfa-b8b2-08db8248440f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 19:51:49.6616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /X9uMg5tlLIOmGCSAtIyfVXYaPiJqd2d/u6GrfB29QIGuRAdcVMqemZeEb0yuWKXfGeAp9IRofE981bveBROaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4518
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-07-06 09:39, Christian König wrote:
> Am 06.07.23 um 15:37 schrieb Shashank Sharma:
>>
>> On 06/07/2023 15:22, Christian König wrote:
>>> Am 06.07.23 um 14:35 schrieb Shashank Sharma:
>>>> A Memory queue descriptor (MQD) of a userqueue defines it in
>>>> the hw's context. As MQD format can vary between different
>>>> graphics IPs, we need gfx GEN specific handlers to create MQDs.
>>>>
>>>> This patch:
>>>> - Introduces MQD handler functions for the usermode queues.
>>>> - Adds new functions to create and destroy userqueue MQD for
>>>>    GFX-GEN-11 IP
>>>>
>>>> V1: Worked on review comments from Alex:
>>>>      - Make MQD functions GEN and IP specific
>>>>
>>>> V2: Worked on review comments from Alex:
>>>>      - Reuse the existing adev->mqd[ip] for MQD creation
>>>>      - Formatting and arrangement of code
>>>>
>>>> V3:
>>>>      - Integration with doorbell manager
>>>>
>>>> V4: Review comments addressed:
>>>>      - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
>>>>      - Align name of structure members (Luben)
>>>>      - Don't break up the Cc tag list and the Sob tag list in commit
>>>>        message (Luben)
>>>> V5:
>>>>     - No need to reserve the bo for MQD (Christian).
>>>>     - Some more changes to support IP specific MQD creation.
>>>>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 16 ++++
>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 73 
>>>> +++++++++++++++++++
>>>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
>>>>   3 files changed, 96 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> index e37b5da5a0d0..bb774144c372 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> @@ -134,12 +134,28 @@ int amdgpu_userq_ioctl(struct drm_device 
>>>> *dev, void *data,
>>>>       return r;
>>>>   }
>>>>   +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
>>>> +
>>>> +static void
>>>> +amdgpu_userqueue_setup_gfx(struct amdgpu_userq_mgr *uq_mgr)
>>>> +{
>>>> +    int maj;
>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
>>>> +
>>>> +    /* We support usermode queue only for GFX V11 as of now */
>>>> +    maj = IP_VERSION_MAJ(version);
>>>> +    if (maj == 11)
>>>> +        uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
>>>> +}
>>>> +
>>>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, 
>>>> struct amdgpu_device *adev)
>>>>   {
>>>>       mutex_init(&userq_mgr->userq_mutex);
>>>>       idr_init_base(&userq_mgr->userq_idr, 1);
>>>>       userq_mgr->adev = adev;
>>>>   +    amdgpu_userqueue_setup_gfx(userq_mgr);
>>>>       return 0;
>>>>   }
>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> index c4940b6ea1c4..e76e1b86b434 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> @@ -30,6 +30,7 @@
>>>>   #include "amdgpu_psp.h"
>>>>   #include "amdgpu_smu.h"
>>>>   #include "amdgpu_atomfirmware.h"
>>>> +#include "amdgpu_userqueue.h"
>>>>   #include "imu_v11_0.h"
>>>>   #include "soc21.h"
>>>>   #include "nvd.h"
>>>> @@ -6486,3 +6487,75 @@ const struct amdgpu_ip_block_version 
>>>> gfx_v11_0_ip_block =
>>>>       .rev = 0,
>>>>       .funcs = &gfx_v11_0_ip_funcs,
>>>>   };
>>>> +
>>>> +static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr 
>>>> *uq_mgr,
>>>> +                      struct drm_amdgpu_userq_in *args_in,
>>>> +                      struct amdgpu_usermode_queue *queue)
>>>> +{
>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>> +    struct amdgpu_mqd *mqd_gfx_generic = 
>>>> &adev->mqds[AMDGPU_HW_IP_GFX];
>>>> +    struct drm_amdgpu_userq_mqd_gfx_v11_0 mqd_user;
>>>> +    struct amdgpu_mqd_prop userq_props;
>>>> +    int r;
>>>> +
>>>> +    /* Incoming MQD parameters from userspace to be saved here */
>>>> +    memset(&mqd_user, 0, sizeof(mqd_user));
>>>> +
>>>> +    /* Structure to initialize MQD for userqueue using generic MQD 
>>>> init function */
>>>> +    memset(&userq_props, 0, sizeof(userq_props));
>>>> +
>>>> +    if (args_in->mqd_size != sizeof(struct 
>>>> drm_amdgpu_userq_mqd_gfx_v11_0)) {
>>>> +        DRM_ERROR("MQD size mismatch\n");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    if (copy_from_user(&mqd_user, u64_to_user_ptr(args_in->mqd), 
>>>> args_in->mqd_size)) {
>>>> +        DRM_ERROR("Failed to get user MQD\n");
>>>> +        return -EFAULT;
>>>> +    }
>>>> +
>>>> +    /* Create BO for actual Userqueue MQD now */
>>>> +    r = amdgpu_bo_create_kernel(adev, mqd_gfx_generic->mqd_size, 
>>>> PAGE_SIZE,
>>>> +                    AMDGPU_GEM_DOMAIN_GTT,
>>>> +                    &queue->mqd.obj,
>>>> +                    &queue->mqd.gpu_addr,
>>>> +                    &queue->mqd.cpu_ptr);
>>>> +    if (r) {
>>>> +        DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
>>>> +        return -ENOMEM;
>>>> +    }
>>>
>>> Using amdgpu_bo_create_kernel() for the MQD is most likely not a 
>>> good idea in the long term, but should work for now.
>>>
>> I was a bit curious about this, the scope of this MQD object is 
>> kernel internal and used for queue mapping only, userspace doesn't 
>> know much about it. Do you still think we should not create a kernel 
>> object for it ?
>
>
> Well we should use a kernel BO. But amdgpu_bo_create_kernel() not only 
> creates a kernel BO but also pins it! And that is problematic because 
> it allows userspace to do a deny of service attach on the kernel module.
>
> What we need is an eviction fence, e.g. what KFD is already using. 
> Then the BO is created similar to how VM page tables are created, 
> maybe even using the same reservation object.

KFD doesn't currently use eviction fences on MQDs. Those are pinned. I 
guess you could treat the MQDs more like we treat page tables. They are 
allocated in kernel mode but protected with fences rather than pinning.

I'm not sure if MES needs to be able to access MQDs while queues are not 
mapped. If that's the case, pinning can't be avoided.

Regards,
   Felix


>
> But for a test this here is probably ok.
>
> Christian.
>
>>
>> - Shashank
>>
>>> Probably best to add a comment here that this needs to be improved.
>>>
>>> Apart from that looks good to me,
>>> Christian.
>>>
>>>> +    memset(queue->mqd.cpu_ptr, 0, mqd_gfx_generic->mqd_size);
>>>> +
>>>> +    /* Initialize the MQD BO with user given values */
>>>> +    userq_props.wptr_gpu_addr = mqd_user.wptr_va;
>>>> +    userq_props.rptr_gpu_addr = mqd_user.rptr_va;
>>>> +    userq_props.queue_size = mqd_user.queue_size;
>>>> +    userq_props.hqd_base_gpu_addr = mqd_user.queue_va;
>>>> +    userq_props.mqd_gpu_addr = queue->mqd.gpu_addr;
>>>> +    userq_props.use_doorbell = true;
>>>> +
>>>> +    r = mqd_gfx_generic->init_mqd(adev, (void 
>>>> *)queue->mqd.cpu_ptr, &userq_props);
>>>> +    if (r) {
>>>> +        DRM_ERROR("Failed to initialize MQD for userqueue\n");
>>>> +        goto free_mqd;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +
>>>> +free_mqd:
>>>> +    amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr, 
>>>> &queue->mqd.cpu_ptr);
>>>> +    return r;
>>>> +}
>>>> +
>>>> +static void
>>>> +gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, 
>>>> struct amdgpu_usermode_queue *queue)
>>>> +{
>>>> +    struct amdgpu_userq_obj *mqd = &queue->mqd;
>>>> +
>>>> +    amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>>>> +}
>>>> +
>>>> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
>>>> +    .mqd_create = gfx_v11_0_userq_mqd_create,
>>>> +    .mqd_destroy = gfx_v11_0_userq_mqd_destroy,
>>>> +};
>>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>>>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>> index 55ed6512a565..240f92796f00 100644
>>>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>> @@ -29,6 +29,12 @@
>>>>     struct amdgpu_mqd_prop;
>>>>   +struct amdgpu_userq_obj {
>>>> +    void         *cpu_ptr;
>>>> +    uint64_t     gpu_addr;
>>>> +    struct amdgpu_bo *obj;
>>>> +};
>>>> +
>>>>   struct amdgpu_usermode_queue {
>>>>       int            queue_type;
>>>>       uint64_t        doorbell_handle;
>>>> @@ -37,6 +43,7 @@ struct amdgpu_usermode_queue {
>>>>       struct amdgpu_mqd_prop    *userq_prop;
>>>>       struct amdgpu_userq_mgr *userq_mgr;
>>>>       struct amdgpu_vm    *vm;
>>>> +    struct amdgpu_userq_obj mqd;
>>>>   };
>>>>     struct amdgpu_userq_funcs {
>>>
>
