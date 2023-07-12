Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E338EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 16:07:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04BB810E589;
	Wed, 12 Jul 2023 16:07:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59BD910E5A7
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 16:07:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJFZdSTPQA3lpZW3A5Up85ZGauj+3sF/saTwpZTjpqJmuqb7qYwSeVSp6NvWpVPympVRdkDmVU2rpTsfV3C7xkDOyukK0/JIT2Ll6sN0ax+QBLum3PPVRXQRXrjkSpYwgXt26VfTg0V+PqZiwpJzZtRFFHIzR7V/kdSS3+13dJGzbmj9pVckv6Gc75HcvMkQ14HFJAD03gHXDlCAvX09EL3Z9VOa4eEt/u+nPssn2x3P7im+iW1hBJnYLQSKvFbw6tO/H70PAMOtic872+1d7fX9qSYhfUwh7fVnpTIda5hgGo7A7herTvV46SCv/uLhyfmeNqNAfLktY7K30m9C1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBTddkeTSOlGlTX5EHKCWPxvTLQkxvBCSDpmWkGHnY0=;
 b=VXV4FN1pmiERtwWmnF5NO6eV2ypEkNc6czDZv80591XQ2pWrkLC2q+tt99uFO9L0pC+dP+wy0dSViVCqJhMbpEQ3hVQddWve3zMLHH0UcXS7ispSyTHFgsIyP9l40of+rz9PlNWoMXtkzRT/cAXMatKegOrHgtDJzudOY+RWuS6e2ENQjB8ArzHfsYMYh9m2PhsLrMXbVg5G7luzQP7lMHwIrWysRXFqQ2bmZl1fbgLlota5zjMd1n1KbdEkHb4IvWsLbggGUqWsqFyCKl2lTms36byyae5fNMj8ex0+rKgrIAUGl3wUFFLQvT57K05vh3GwLp+1MSXX2ur8MWp7vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBTddkeTSOlGlTX5EHKCWPxvTLQkxvBCSDpmWkGHnY0=;
 b=RRrBIYeXTHE9sVN1ljPXwQyE3TY2OckzXHTGSr5aaXxoFzQsIRPbzkWf8Z5EuG7DQohN10TimSvO3QBiTaIzvtgFxSrid+Bpr98MOm8HC2EI/ew77Iz/Fb73f40USghEosAyn9T+X6GUBQvFj8+n9vGujkaaW6E17DVHlyzWYB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 16:07:28 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::178f:15ce:51b7:8a45]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::178f:15ce:51b7:8a45%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 16:07:28 +0000
Message-ID: <5a35a02c-77da-e7ce-b924-57226ba77e88@amd.com>
Date: Wed, 12 Jul 2023 18:07:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 04/10] drm/amdgpu: create GFX-gen11 usermode queue
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-5-shashank.sharma@amd.com>
 <56fbaa22-285f-1030-1822-36d542de4ecd@amd.com>
 <c87cd5f9-b940-0bad-6cfe-c8640693b426@amd.com>
 <e669c8cd-9fc2-73c6-c8f0-140695f17156@amd.com>
 <435820e9-1680-3687-4930-bf7ea5967568@amd.com>
 <9cac0523-8596-c64b-93be-9d3425ca3c25@amd.com>
 <de08d8c9-dd29-48a0-1316-f7a0bd9cb69d@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <de08d8c9-dd29-48a0-1316-f7a0bd9cb69d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0407.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:83::28) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 71dc5cf6-f0cb-4a54-f6c3-08db82f21702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVBcNcxvf5RVhLOJGQvp+41sdjNUzEXMQ8E5e7mjp11q3MVQ/R2ryIHmE6MT/ecKS3fZ8u9kItkZVukO0k0jE2BhJqk+TyuTSYddo3FXbmnNlIuiAz/322J9AGo/IxsgztZ62FyNrfauDOX9ar42HeMgxDjMySa+1dUdK0DvoVm2tuvQkaGH7UF4qGBwhCl7IThgeBI6xUy36m0aHaDBWbkT7S47AKjLiPmRSV/hxPvntJWWyB2J17iM0C1uXQccc+M31WhPlbA6e3v1E2viwiJdSVxXSRrHYsJQZ3tYR2eY1GfE4SLE0QLrxtZWg87ZcwbkDkywf37VJg0EWcF06WED3VPYbKlw2NhLKbnMT8L3DeG40NiUY44vRAZE64fXfOyZddewiRiyLuONh37+3KSRJcwwrjaOhiX2VhZgdWdCjJXzxRkIRVUKo4mgVxM85Gw6hiRpAPcBIyIJA2lmAe1mT4qnphJeJ2Rqbr10NSI0dQirnPL1qh4eCj0yFZ0DfiZL22ZJ9wjI/6EfACNrv4PLlhj0uZs3ytjRDzIA7xb/zTd6zoYEBnSfz/fBuAJdZM3Z3a/ztpOdmqZqFyCUOwR5rMp+Fm1oHAjjUpDnRQO60sduH5PgShjiQaPDkKC0sBKKn1gWbB2KaNusjT3mOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199021)(6666004)(6486002)(478600001)(110136005)(186003)(26005)(53546011)(6506007)(6512007)(30864003)(2906002)(41300700001)(66946007)(4326008)(66476007)(66556008)(316002)(5660300002)(44832011)(8936002)(8676002)(38100700002)(31696002)(86362001)(36756003)(2616005)(83380400001)(66574015)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amFqUHluRDhzSkZTYUZnMGIyYkNWMzB5T2JzNm1mamNrOTJKeGFNcnR0cGhv?=
 =?utf-8?B?cWY5K0ZEOGxWTmJWNnEzNGw2dHY4dFJGZE5zUCtidUJVei9lK3hSQ3ZGb0ds?=
 =?utf-8?B?b2Y5UEFITGRuVFAxMzNnSWN2b28zODRHNDFYR1pFR3p1L3NZeGpuaGFTYnlt?=
 =?utf-8?B?TThsaTNOd3RWb1BOOC9zUGNNcHMyT3NxdnZTby90WFNLREx6aE9yMkIyKzRG?=
 =?utf-8?B?MGhqMEJKOXVKMmcyQ01rMUhmbXlteG03ck5YRHdKZWE3VTBLbStuODBWRjRH?=
 =?utf-8?B?K0tnNG5QdnJlVFRiZ0crRng4ZFdOY3NkNkRQeDlSNVhIbmtxNUZyMmZYTnNt?=
 =?utf-8?B?MWRVbTZqS0Y2eXMwZVpYTHZyVHBlUktjNTJtT1o5eXRLbmEyOGlNWW5vek8y?=
 =?utf-8?B?OXBEZmR5OHVaZWZDTGlNOGcvZ3Zzazdwci96T002ajkxbzY0UDcxYi9Zdk0x?=
 =?utf-8?B?UGJLQ0p1Si8rUzNIVVI0YjBXR05XMFIzbFlhOFlka1JWMFlZYWcwMGNWamhJ?=
 =?utf-8?B?SXlGSzdZTjd3SVo0b2Q3azV3U1N2bmVGME1ZenpNSElZV1lTZGs2cExUT25Q?=
 =?utf-8?B?cWdvTDBkNzhWZUpuT3lRU1g5djB3YTE2VitWVWNpaHI0RExNdXVzeG8wMUVU?=
 =?utf-8?B?cW80cjlwRjE2NHNVUVh5dlRpMkpLUFNxeEpBWlNSa0U4UDByTTB5bGZXNWpL?=
 =?utf-8?B?aEVpYldHcnlLOTBrRStVdjAyWmlDQjRWVTZ3bU9JUXhTVmQyTisrWjcyZ3ov?=
 =?utf-8?B?TkhvTHBzRnhVRkdqd3gxY1VBS3haUGFqY3E2eGJ3RnkvTWhDWGd5RzlxQmJY?=
 =?utf-8?B?OW1xWXpQRmU1KzBPUSs2b2QrMyszalZxYk1hWWJVa29ZUmw1OXkraCtvOFRa?=
 =?utf-8?B?dzVKVGlSUVBqa3VKaXlXNnU5Y1k4Q3l3bm4vc1N2K3p6eXdsR3Zsbm1jY0VK?=
 =?utf-8?B?VmQ0a0V4QzFoY3lkWUZXRlRaQTlhU01aaWpxcE5LTURqSWl4dzdZMHl0L1hK?=
 =?utf-8?B?KzZrNmF3NnhneGxZdDY1ejRwck10VU52blhMdjd2OC9ZY0lMRklZMU1oK01q?=
 =?utf-8?B?UVNpSVJTQnN1WXQ5ZlhyRU5TcGZKVnVxM2U0L3dFYTl5TU0wMkZ4OEZmTmUx?=
 =?utf-8?B?NEp0Y1BnY2tmdEN6emFCSkQyOFRlcytWVDAzaGE2RENtSno4TkNoZ2hibzBZ?=
 =?utf-8?B?SFVUeTVxWUJHaFRJa3RmdXowY1grclpUcVFZcE5DWUlVTUE4MzZpK1FVeHcz?=
 =?utf-8?B?bk9WNG1KRDZKZGpTc2hRME5qeEJrTXdHWW9PMjhwRStvWGZLZEtxejdqb2NC?=
 =?utf-8?B?TVZKUWtSa1RieFhvTVY4NEVSVHVOb3Nsd3dVOFJkdWpMa1hIdDlYZGZhSXhn?=
 =?utf-8?B?TkdSZVVQVnVrQTlVN3N5N05yNU5FSlBFclpHK1V1M1lhODM5QVI1OE1tOVE2?=
 =?utf-8?B?bzYyWlJYNzl6QStmUmlhU3QrbHFoNFNDZ3pEalRIOXdPYktMdDlnK2J4WSsr?=
 =?utf-8?B?emhYQkd6NVlKekVUUjdPdkIraFZyUERFbkF5cGRhZWxQQXdzL1dBNVRaVHA1?=
 =?utf-8?B?WkJvSjlyMFBud29xTVpOVTlmQklGZDFuZXpLbHdTcjBvK2M4V0hiVU5HcGYz?=
 =?utf-8?B?RUZrc3pqZVV5N2laVStxNWdBRkVSLzI3bHZkcklEeldrUXVTWUtkRWJBTFNR?=
 =?utf-8?B?T3I1NHRwbFVJUWVnay8xdTdXdEJIc3psVFRvOGxTRzkzaHFjeVNYWHhLQWpE?=
 =?utf-8?B?aG1PWjJZOWVMVDRBYXplMWhyY2p6dGtqR0pQcUhiSzFHNEl6U0dNemYwVG1i?=
 =?utf-8?B?cUJ4elorbUNQVTY2RG9GUW1jdXQzaVJpN214L0VqclBMbFI0S1o4NGZ3d2Mv?=
 =?utf-8?B?cWRhOTFaMWVIdzVtODFrV2hPVWlxL01QSHRKc0xrQXVJa3oxV1FYcjV3dzA2?=
 =?utf-8?B?LytUOWtHQU1wT1AwZEFPYjBxUlJxamVEamtrelpTbWpTbkxjYmZrc3o1ZFV4?=
 =?utf-8?B?M2dhUmZLZDNXZjBOeWVybURqNmZ3YmEvRnVFbEgzQS90Vk1XSlBDYzlSRElq?=
 =?utf-8?B?Wm1YVGVqVlhMVW8zR0xxYlR2Ty91Si9ReFB2WmJqSlZXL0cyUE03Q1N2dm9Q?=
 =?utf-8?Q?Uaw8e+HZt01OQGfyqUe2bKdAz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71dc5cf6-f0cb-4a54-f6c3-08db82f21702
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:07:28.5320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9u32V/j8Dvk293M3dA4DvdNAbXDTkhbOIOzpDe+jPeUd5G7rXXIvesWC6iZ/B8iw/uSwb2zI7Uby8vJn7oCmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994
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


On 12/07/2023 18:01, Felix Kuehling wrote:
> Am 2023-07-12 um 11:55 schrieb Shashank Sharma:
>>
>> On 11/07/2023 21:51, Felix Kuehling wrote:
>>>
>>> On 2023-07-06 09:39, Christian König wrote:
>>>> Am 06.07.23 um 15:37 schrieb Shashank Sharma:
>>>>>
>>>>> On 06/07/2023 15:22, Christian König wrote:
>>>>>> Am 06.07.23 um 14:35 schrieb Shashank Sharma:
>>>>>>> A Memory queue descriptor (MQD) of a userqueue defines it in
>>>>>>> the hw's context. As MQD format can vary between different
>>>>>>> graphics IPs, we need gfx GEN specific handlers to create MQDs.
>>>>>>>
>>>>>>> This patch:
>>>>>>> - Introduces MQD handler functions for the usermode queues.
>>>>>>> - Adds new functions to create and destroy userqueue MQD for
>>>>>>>    GFX-GEN-11 IP
>>>>>>>
>>>>>>> V1: Worked on review comments from Alex:
>>>>>>>      - Make MQD functions GEN and IP specific
>>>>>>>
>>>>>>> V2: Worked on review comments from Alex:
>>>>>>>      - Reuse the existing adev->mqd[ip] for MQD creation
>>>>>>>      - Formatting and arrangement of code
>>>>>>>
>>>>>>> V3:
>>>>>>>      - Integration with doorbell manager
>>>>>>>
>>>>>>> V4: Review comments addressed:
>>>>>>>      - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
>>>>>>>      - Align name of structure members (Luben)
>>>>>>>      - Don't break up the Cc tag list and the Sob tag list in 
>>>>>>> commit
>>>>>>>        message (Luben)
>>>>>>> V5:
>>>>>>>     - No need to reserve the bo for MQD (Christian).
>>>>>>>     - Some more changes to support IP specific MQD creation.
>>>>>>>
>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>>>>>>> ---
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 16 ++++
>>>>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 73 
>>>>>>> +++++++++++++++++++
>>>>>>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
>>>>>>>   3 files changed, 96 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>>> index e37b5da5a0d0..bb774144c372 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>>> @@ -134,12 +134,28 @@ int amdgpu_userq_ioctl(struct drm_device 
>>>>>>> *dev, void *data,
>>>>>>>       return r;
>>>>>>>   }
>>>>>>>   +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
>>>>>>> +
>>>>>>> +static void
>>>>>>> +amdgpu_userqueue_setup_gfx(struct amdgpu_userq_mgr *uq_mgr)
>>>>>>> +{
>>>>>>> +    int maj;
>>>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>>>> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
>>>>>>> +
>>>>>>> +    /* We support usermode queue only for GFX V11 as of now */
>>>>>>> +    maj = IP_VERSION_MAJ(version);
>>>>>>> +    if (maj == 11)
>>>>>>> +        uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = 
>>>>>>> &userq_gfx_v11_funcs;
>>>>>>> +}
>>>>>>> +
>>>>>>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, 
>>>>>>> struct amdgpu_device *adev)
>>>>>>>   {
>>>>>>>       mutex_init(&userq_mgr->userq_mutex);
>>>>>>>       idr_init_base(&userq_mgr->userq_idr, 1);
>>>>>>>       userq_mgr->adev = adev;
>>>>>>>   +    amdgpu_userqueue_setup_gfx(userq_mgr);
>>>>>>>       return 0;
>>>>>>>   }
>>>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>>>> index c4940b6ea1c4..e76e1b86b434 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>>>> @@ -30,6 +30,7 @@
>>>>>>>   #include "amdgpu_psp.h"
>>>>>>>   #include "amdgpu_smu.h"
>>>>>>>   #include "amdgpu_atomfirmware.h"
>>>>>>> +#include "amdgpu_userqueue.h"
>>>>>>>   #include "imu_v11_0.h"
>>>>>>>   #include "soc21.h"
>>>>>>>   #include "nvd.h"
>>>>>>> @@ -6486,3 +6487,75 @@ const struct amdgpu_ip_block_version 
>>>>>>> gfx_v11_0_ip_block =
>>>>>>>       .rev = 0,
>>>>>>>       .funcs = &gfx_v11_0_ip_funcs,
>>>>>>>   };
>>>>>>> +
>>>>>>> +static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr 
>>>>>>> *uq_mgr,
>>>>>>> +                      struct drm_amdgpu_userq_in *args_in,
>>>>>>> +                      struct amdgpu_usermode_queue *queue)
>>>>>>> +{
>>>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>>>> +    struct amdgpu_mqd *mqd_gfx_generic = 
>>>>>>> &adev->mqds[AMDGPU_HW_IP_GFX];
>>>>>>> +    struct drm_amdgpu_userq_mqd_gfx_v11_0 mqd_user;
>>>>>>> +    struct amdgpu_mqd_prop userq_props;
>>>>>>> +    int r;
>>>>>>> +
>>>>>>> +    /* Incoming MQD parameters from userspace to be saved here */
>>>>>>> +    memset(&mqd_user, 0, sizeof(mqd_user));
>>>>>>> +
>>>>>>> +    /* Structure to initialize MQD for userqueue using generic 
>>>>>>> MQD init function */
>>>>>>> +    memset(&userq_props, 0, sizeof(userq_props));
>>>>>>> +
>>>>>>> +    if (args_in->mqd_size != sizeof(struct 
>>>>>>> drm_amdgpu_userq_mqd_gfx_v11_0)) {
>>>>>>> +        DRM_ERROR("MQD size mismatch\n");
>>>>>>> +        return -EINVAL;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    if (copy_from_user(&mqd_user, 
>>>>>>> u64_to_user_ptr(args_in->mqd), args_in->mqd_size)) {
>>>>>>> +        DRM_ERROR("Failed to get user MQD\n");
>>>>>>> +        return -EFAULT;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    /* Create BO for actual Userqueue MQD now */
>>>>>>> +    r = amdgpu_bo_create_kernel(adev, 
>>>>>>> mqd_gfx_generic->mqd_size, PAGE_SIZE,
>>>>>>> +                    AMDGPU_GEM_DOMAIN_GTT,
>>>>>>> +                    &queue->mqd.obj,
>>>>>>> +                    &queue->mqd.gpu_addr,
>>>>>>> +                    &queue->mqd.cpu_ptr);
>>>>>>> +    if (r) {
>>>>>>> +        DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
>>>>>>> +        return -ENOMEM;
>>>>>>> +    }
>>>>>>
>>>>>> Using amdgpu_bo_create_kernel() for the MQD is most likely not a 
>>>>>> good idea in the long term, but should work for now.
>>>>>>
>>>>> I was a bit curious about this, the scope of this MQD object is 
>>>>> kernel internal and used for queue mapping only, userspace doesn't 
>>>>> know much about it. Do you still think we should not create a 
>>>>> kernel object for it ?
>>>>
>>>>
>>>> Well we should use a kernel BO. But amdgpu_bo_create_kernel() not 
>>>> only creates a kernel BO but also pins it! And that is problematic 
>>>> because it allows userspace to do a deny of service attach on the 
>>>> kernel module.
>>>>
>>>> What we need is an eviction fence, e.g. what KFD is already using. 
>>>> Then the BO is created similar to how VM page tables are created, 
>>>> maybe even using the same reservation object.
>>>
>>> KFD doesn't currently use eviction fences on MQDs. Those are pinned. 
>>> I guess you could treat the MQDs more like we treat page tables. 
>>> They are allocated in kernel mode but protected with fences rather 
>>> than pinning.
>>>
>>> I'm not sure if MES needs to be able to access MQDs while queues are 
>>> not mapped. If that's the case, pinning can't be avoided.
>>>
>> I was planning to do something like this keep userqueue objects from 
>> eviction:
>>
>> - Add a new mutex in queue struct (say userq_eviction_fence)
>>
>> - lock this while mapping the queue, and unlock it while unmapping of 
>> the queue
>>
>> - add checks in amdgpu_vm_evictable() to add a 
>> mutex_trylock(userq_eviction_fence)
>>
>> Does it sound like what we want to do here or should I need something 
>> else ?
>
> A mutex is not a fence. The eviction fences we have in KFD are 
> dma_fences. They interact with TTM's memory eviction logic, which 
> allows us to stop user mode queues before TTM moves memory. A mutex 
> cannot do that.
>
Ah, I meant userq_eviction_lock (not fence), as I was curious if we just 
want to keep the GPUVM from eviction, a lock can also do that for us.

But now I realize that we actually want to keep all the GPU BOs (which 
are related to this queue, one of which is MQD) to be saved from 
internal TTM movement, and need to be embedded in form of dma/ttm 
interaction.

- Shashank

> Regards,
>   Felix
>
>
>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>>
>>>> But for a test this here is probably ok.
>>>>
>>>> Christian.
>>>>
>>>>>
>>>>> - Shashank
>>>>>
>>>>>> Probably best to add a comment here that this needs to be improved.
>>>>>>
>>>>>> Apart from that looks good to me,
>>>>>> Christian.
>>>>>>
>>>>>>> + memset(queue->mqd.cpu_ptr, 0, mqd_gfx_generic->mqd_size);
>>>>>>> +
>>>>>>> +    /* Initialize the MQD BO with user given values */
>>>>>>> +    userq_props.wptr_gpu_addr = mqd_user.wptr_va;
>>>>>>> +    userq_props.rptr_gpu_addr = mqd_user.rptr_va;
>>>>>>> +    userq_props.queue_size = mqd_user.queue_size;
>>>>>>> +    userq_props.hqd_base_gpu_addr = mqd_user.queue_va;
>>>>>>> +    userq_props.mqd_gpu_addr = queue->mqd.gpu_addr;
>>>>>>> +    userq_props.use_doorbell = true;
>>>>>>> +
>>>>>>> +    r = mqd_gfx_generic->init_mqd(adev, (void 
>>>>>>> *)queue->mqd.cpu_ptr, &userq_props);
>>>>>>> +    if (r) {
>>>>>>> +        DRM_ERROR("Failed to initialize MQD for userqueue\n");
>>>>>>> +        goto free_mqd;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    return 0;
>>>>>>> +
>>>>>>> +free_mqd:
>>>>>>> +    amdgpu_bo_free_kernel(&queue->mqd.obj, 
>>>>>>> &queue->mqd.gpu_addr, &queue->mqd.cpu_ptr);
>>>>>>> +    return r;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static void
>>>>>>> +gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, 
>>>>>>> struct amdgpu_usermode_queue *queue)
>>>>>>> +{
>>>>>>> +    struct amdgpu_userq_obj *mqd = &queue->mqd;
>>>>>>> +
>>>>>>> +    amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, 
>>>>>>> &mqd->cpu_ptr);
>>>>>>> +}
>>>>>>> +
>>>>>>> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
>>>>>>> +    .mqd_create = gfx_v11_0_userq_mqd_create,
>>>>>>> +    .mqd_destroy = gfx_v11_0_userq_mqd_destroy,
>>>>>>> +};
>>>>>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>>>>>>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>>>> index 55ed6512a565..240f92796f00 100644
>>>>>>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>>>> @@ -29,6 +29,12 @@
>>>>>>>     struct amdgpu_mqd_prop;
>>>>>>>   +struct amdgpu_userq_obj {
>>>>>>> +    void         *cpu_ptr;
>>>>>>> +    uint64_t     gpu_addr;
>>>>>>> +    struct amdgpu_bo *obj;
>>>>>>> +};
>>>>>>> +
>>>>>>>   struct amdgpu_usermode_queue {
>>>>>>>       int            queue_type;
>>>>>>>       uint64_t        doorbell_handle;
>>>>>>> @@ -37,6 +43,7 @@ struct amdgpu_usermode_queue {
>>>>>>>       struct amdgpu_mqd_prop    *userq_prop;
>>>>>>>       struct amdgpu_userq_mgr *userq_mgr;
>>>>>>>       struct amdgpu_vm    *vm;
>>>>>>> +    struct amdgpu_userq_obj mqd;
>>>>>>>   };
>>>>>>>     struct amdgpu_userq_funcs {
>>>>>>
>>>>
