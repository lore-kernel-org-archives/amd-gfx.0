Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52037606A31D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=T+Rn6bmy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E261910E484;
	Tue, 27 Oct 2026 20:46:01 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013017.outbound.protection.outlook.com
 [40.93.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7782D10E484
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 20:45:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wS5y0PSwl+wCLp1AjU1CxUmaV6wk+lY2Lq2nipvZQ2HITAGrW4SSrKVTar/WmkBZrNXU2iA4ZTQdhx3tM4IKGFLuGfdPFaPHFs6f3lVUts/GHt5gAgWkFw9U1g6ITi3bhaox3ssu42ahUkRDnynUwZp3pBSW0YlRDsrO9KuffAwLOjlhDnz2gLAl3rMkNT5upFSEwqeAOmJAPtijNZnrn+XtD8cu8mEVbBpMTNNi/DVkwYQp0DbcQDwxJbHhGNklVngNbYIrEG4mKH7UeFnler1Y4aE8BWnJtViqjVgA903vTE2sQJl2XCKdsT3jUJ9HQQG8LvGUQJb1BD0+ecmXBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dTiqPDg8o6hki+WDsRjUr7VGe4KNRDrPBlECUuzmtc=;
 b=tS+QOFs0Rh3ZxsRVqFhIY2zSE5NK8rXsP+2UYUGNw6LFk94wwl3cgBYLKSFGTUfhjCIytxW8uHzx2D4MJM92L8L+UiGmsL//HGB893z7JqohEEAE6014HNg/y8QeFf9jHSfEfCx/YXbo0a0R0GtV6Jbb39EPW77JaJicOTB5w0NuJdZXUsZtOsOSQmwHXK/4amcyXDlny75oVukCJVvInTCbPFYaLcr8AGaV5mwClmY/uaXaJ5mLWIQAppeIVCUuangclsc0nWJFSA9d/lzJX4VNgRgHicCE0v7gyV2ugjyhYIGhoobrAwGBF95l1FAxIe0CG2qI5a0+pGwk/PZmnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dTiqPDg8o6hki+WDsRjUr7VGe4KNRDrPBlECUuzmtc=;
 b=T+Rn6bmyLdGJ7czwTiNH+6OHHvsWPHksYjDfjCH3rasx5cCfIQQGCtpMJDXTPzG2Xuy0x7L79X9OXTq3RMNTJ2wMOg7q64lQ5X/ZpIasKX6ejNI1h1DMjaLTsSybcFae5COW301ABah8jYzxjKc2zBIWPngyDGTYPpiIfTxfAGo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by SJ2PR12MB9139.namprd12.prod.outlook.com
 (2603:10b6:a03:564::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 20:45:49 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 20:45:49 +0000
Message-ID: <20f59956-e398-449c-a38f-742176937a2a@amd.com>
Date: Tue, 27 Oct 2026 16:45:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/8] drm/amdgpu: Add UALink loopback infrastructure
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261027195913.1794477-1-mukul.joshi@amd.com>
 <20261027195913.1794477-2-mukul.joshi@amd.com>
 <ee1e254f-c322-4a75-be7d-a05a67af0e9a@amd.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <ee1e254f-c322-4a75-be7d-a05a67af0e9a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::18) To PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PHXPR12MB999256:EE_|SJ2PR12MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e60aa79-f9e3-4a93-57c0-08df346b4861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|261021123027099003|261009223027099003|261022075727099003|261022105027099003|261021121427099003|3023799007|10067099003|56012099006|261026121527099003|6133799003|22082099003|18002099003|4143699003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info: cZ0ZVaWoZEsrjnXB/KeutLKfhk5sgxlZrWNTOKMe5Zj7xncEUJSn/DnOEKoId3xvHhK5GOED09tE/BHLi71RXI+dd86tE2AfvrDHbgwLDhhKsntSaVi4CvACWi0//tSOdxLoFG1PlaFrXtwsCAr8wLKL3R4I6ZDOYB6v04kobb255M/7QOKzoWOc3w9G3tfxTa2dVo1rZJG8shZag24xTQ+uwCefmS1Mg9yj6UcwA1SE+5Ne4TT4Mlkvl4RoJ5wqb4PI793u79dqq5smMXkyG5BNjSrMia66BQlx//8VrZiR/jhFXUPIE289HU6IKQJX0+vKH8t+JK4ffX8ciDLbnPDDORwyB9WmqN5i1zMcMkiEH/FtBQGSWI6uy4OxxaoO7WAkVdzJ2GpCUNntyDFA4TBw/D94bnWWvWZ9zauMZAUUE04BxxlaaTIcQRe0WKBjHiaNr10EBUbhJ1QtV+TUbiXFR7+ptfEUlFqE28CGrPcmK/wIu7K8ogtFd2IPFGWKA+m3qJRf0fUUjbqvdp3ygc3I9Pdof9IKHyQfb7b+u4aHj82ZW3OfNI6NICCYEJMSCtXVEUNKndfQIcfC6w4zDAV5EpS9HHA5RjyP8S5Yfxf8goL6B8Sly/pjLE+jFUTNYsBqqi21Cg3zj3OfnI1DipixDvLBmcRmqq1LoVmomjY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261021123027099003)(261009223027099003)(261022075727099003)(261022105027099003)(261021121427099003)(3023799007)(10067099003)(56012099006)(261026121527099003)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDE5TWhCZ3pxaDRHb1dpWWloMkpUUzh4NzhaWVJlNDVFalpJelhpS2tvVEJ1?=
 =?utf-8?B?ajNMdHNLZ0tPUlFld0puWFVrN3F2dExReGV0dW8xSHZzSzVTWGY2dlp6OHhQ?=
 =?utf-8?B?L1dFazNGd1BtWlJtYTRzdFpOVndaQnNuV2JsbWpOeGk5WmhoK2dIMWJSdWI5?=
 =?utf-8?B?YnV3SzRwNDdWeU1jZndCa3VDdlljYTB3eUxPTHVOV1R4ZUJYYmx0M05VYkZp?=
 =?utf-8?B?dzVvUGRSc1BscE9BbnJRWWRhMDB2cEdhOXBkd1JZYzlKM1FDUUVHZG00Rmxp?=
 =?utf-8?B?RFFtUGFmWjEvQU03SlVOYTlDckg5QlJWWVk0cFhacyt3OEhuc0pWN25NRlBP?=
 =?utf-8?B?cWZxNkRDWUpvWGEvbmxmRHkzVG1MZVdlNlJRWHZXY250akpxTVdZUHlxUWZ1?=
 =?utf-8?B?RGI1L0M1K3hBTXhweWQ0UzdzYTd1d0x2bkdFVFVyZnNXeEMyeENpb0cwLzhn?=
 =?utf-8?B?dVd6NFZLK2JtWEg1UWpxcjBqdWxIUC9GUGZBL2VySTNjcGR4WFJxSzRJRWJa?=
 =?utf-8?B?dERYZmdIUUxpUTZ5VTFWVWVGQjBCMzd2bW5wVSsxVXlDZE1pU3RDTFhIYlJI?=
 =?utf-8?B?SW1yclBoQy9YaFpTK1k2ZTh5cWtvT21LU0M1ZDZtZmxFbnVRS21oeTd4dkRt?=
 =?utf-8?B?U1RZb21FMDRLZ1dkNzFiaVNDOFUyaFM1ZXdNNFFyaUFvclJoNDVFNTV4bTYr?=
 =?utf-8?B?ZnJjZ0pnTjIxcVJKUXh3NW1LS1lJd0M2UGxySHpTUk1UUTdwY2k5a2VOZ1FS?=
 =?utf-8?B?YWhSRkVCcHVQSGhBUXVTVjlRMW9CaE4zOUtTUnVjVEFMa09hcGpScmNyNXVG?=
 =?utf-8?B?bFdzK3BIZFFKNGs2UzBtWnJhK2pXRVFidEJZL1VBbnZ6UHl4OWZGTlB6TStP?=
 =?utf-8?B?MUs5K1lYZ01Cb2E4Q1c5azRoRHlRam4wQ3h3ckN4Njg2K2tYZUlJS3JEQ3RE?=
 =?utf-8?B?QWxtTzBxQW94M2NNa1BvZVZ3VWhvRGs5eEJqRDBTdi9qd01xeldyWHVsMFJx?=
 =?utf-8?B?K1l5LzFZZ21oZmYvbWJVOFlPR2JzVHpUc3dQaVpuVld4ZzRyY0ZSdFhwV0VM?=
 =?utf-8?B?ajRySGFFUzg3b2xCU0xIYmUzRVVzWVVzdVpwYm03QmFvQXFMc0NDM2dtL1hJ?=
 =?utf-8?B?bHoyYStSZGtibVMwUE5BTEV0QXRLZEFRTnZyREV2U3pUNzVpbU0vOWgyQ1I0?=
 =?utf-8?B?Q3lpVUZKSHFod3VPcGdlei9Ja2YwdFg4OThwcE43VFBaTS90SnBaNDNzYUpq?=
 =?utf-8?B?NzVDM0xlN0U0WWhlZzIrWENrMGt1NWdXRFgxZmRKL29NbGI4NFF5VmpESHJT?=
 =?utf-8?B?VVZ0QU1zTUtyY0o5Nk14U1BZemprcHJUaFFkR3o0ODdRMUcxZmV3OEUyUG9v?=
 =?utf-8?B?Vm8wdEZyTGsrMWV1eTdvb2NoZUwxbHorenJXVXNQTWJQM2lDT0N4WCtxdzJh?=
 =?utf-8?B?SzJUMG1uTDgxd3M5MitlV0t5U3lmRHJ4QW1oSzJhY3NiZnExUjBPejBNbDVs?=
 =?utf-8?B?cUNZVU8xR3lsdkNxZUNxczdWQ2hwRVdod09wb3UwRU54bnhnRUJaeDZXYjM1?=
 =?utf-8?B?TlBKQ1lwdEtiYWxMenVIMGZqa1J4eHQrUmlpZk1zck1FcUQyMkgzTkwyY0Yx?=
 =?utf-8?B?NHVPeFU0YWpacU9TTzdZV05zUk92WnR3TmEvOU5XVFAwQk9lK2c2WmoxVmVD?=
 =?utf-8?B?T2VRYUIzbS9neGgyUm5wMENia2VTMVlpSzFVOFBXb1U2VXhaVm0xWVNNWEI1?=
 =?utf-8?B?cXFTUUduL2NGZlYwaTZJR0NlS3RIL3RSS2NETVZtSmZuUWpmLytrMTcrYzVN?=
 =?utf-8?B?U0M3WmF0Y3ZEdE9CWGpIVjF0Sk5PNXBBZzVyaWV2RUxWdytQcGh0QXh2dUll?=
 =?utf-8?B?eXNETEs3eit1NUxIL3pabmtQWU9JdXk4S1RYbGY4TUhOb0RndTdRTnFzcFJZ?=
 =?utf-8?B?OWg4d01jZ1I0SHFlWGNEMEsxUENyUzRRNnM4amF4QUNEMTIva3NFbFU0MEQz?=
 =?utf-8?B?RFJhMGZWaXFNL0N6RFdyeHhNWVI1WU43MzBKTlVkWjFGVWg5dU95b2pYbjJ1?=
 =?utf-8?B?N1B4elpnWEV2SjdFTnB3R2s3cVhyZGRzeDhTVWFScnhrdkJmS25tdGxUS0Jj?=
 =?utf-8?B?Rzl1eHBLUzVRODFTcjlKNThzUFRKK3NpQVZvYjZyaVJsbnd0YmI5VERaVjE0?=
 =?utf-8?B?VVFmTFNDZU5pdUsvbjJHSGN0d0tmQWlQZ0ppVi9UM29lbXZaZEpxSFk0MzM1?=
 =?utf-8?B?eHBBOHdkSlRvOEZXZkhTSFFPbDFrdlQrODFWYklNMWxla2NTQmNWR3FMb1ZY?=
 =?utf-8?B?TTUrMVJrSDJva1EyemxaYy9iaDdyWC9BY1llZjN0eHluY3lPc2tnUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e60aa79-f9e3-4a93-57c0-08df346b4861
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 20:45:49.1054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPfH48C1LNhknkZqeqVti16RI/LTGzxwLXz//skR00WhBFCigO+ld5x5BmXrFAQNoS7TvmyNqi36yzK0g7QRKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9139
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/27/2026 4:22 PM, Felix Kuehling wrote:
> On 2026-10-27 15:54, Mukul Joshi wrote:
>> Add the infrastructure for UALink loopback mode, where a single GPU
>> plays both the exporter and the importer role under two fixed
>> accelerator IDs:
>>
>> - Add struct amdgpu_ualink_loopback to track the loopback state, along
>>    with the fixed exporter and importer accel IDs.
>>
>> - Replace ualink_accel_id() with ualink_exp_accel_id() and
>>    ualink_imp_accel_id(), which return the exporter and importer accel
>>    ID in loopback mode.
>>
>> - Add amdgpu_ualink_loopback_init(), which allocates the ordered
>>    workqueue used to emulate exporter->importer messages, and destroy
>>    it in amdgpu_ualink_object_fini().
>>
>> Loopback is not enabled yet, and outside loopback both helpers return
>> ppod.accel_id, so there is no functional change.
>>
>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>> ---
>> v1-v2:
>> - Drop the change in find_peer_adev() as its not needed (Lijo).
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 99 +++++++++++++++++-----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h | 29 +++++++
>>   2 files changed, 109 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> index ca6432610f71..2cd6dc71ab9f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> @@ -89,8 +89,34 @@ static int amdgpu_ualink_drm_client_create(struct
>> amdgpu_device *adev)
>>       return 0;
>>   }
>>   +/*
>> + * amdgpu_ualink_loopback_init - set up UALink loopback mode
>> + *
>> + * Called once loopback mode has been detected. Allocates the ordered
>> + * workqueue used to emulate exporter->importer interrupts in SW.
>> + */
>> +static int amdgpu_ualink_loopback_init(struct amdgpu_device *adev)
>> +{
>> +    adev->ualink.loopback.wq =
>> +        alloc_ordered_workqueue("amdgpu_ualink_loopback", 0);
>> +    if (!adev->ualink.loopback.wq)
>> +        return -ENOMEM;
>> +
>> +    return 0;
>> +}
>> +
>>   static void amdgpu_ualink_object_fini(struct amdgpu_device *adev)
>>   {
>> +    /* Tear down the loopback self-interrupt workqueue allocated in
>> +     * amdgpu_ualink_loopback_init(). destroy_workqueue() drains any
>> +     * pending self-interrupt work first.
>> +     */
>> +    if (adev->ualink.loopback.wq) {
>> +        destroy_workqueue(adev->ualink.loopback.wq);
>> +        adev->ualink.loopback.wq = NULL;
>> +        adev->ualink.loopback.enabled = false;
>> +    }
>> +
>>       if (!adev->ualink.info)
>>           return;
>>   @@ -472,6 +498,14 @@ int ualink_ip_late_init(struct amdgpu_ip_block
>> *ip_block)
>>           __amdgpu_ualink_activate_vpod_locked(adev);
>>       }
>>   +    if (adev->ualink.loopback.enabled) {
>> +        r = amdgpu_ualink_loopback_init(adev);
>> +        if (r) {
>> +            dev_err(adev->dev, "Failed to set up UALink loopback:
>> %d\n", r);
>> +            goto error;
>> +        }
>> +    }
>> +
>>       r = amdgpu_ualink_drm_client_create(adev);
>>       if (r) {
>>           dev_err(adev->dev, "Failed to create UALink DRM client: %d\n",
>> @@ -1028,6 +1062,31 @@ static struct amdgpu_device
>> *find_peer_adev(unsigned int accel_id)
>>       return NULL;
>>   }
>>   +/*
>> + * Physical accelerator roles.
>> + *
>> + * Outside loopback a GPU owns a single accelerator, so both helpers
>> return its
>> + * ppod.accel_id and the exporter/importer distinction collapses. In
>> loopback
>> + * the one physical GPU plays both roles: the exporter owns the MP
>> nHT and
>> + * receives all HW traffic, while the importer is the (virtual) HW
>> sender for
>> + * the importer -> exporter path.
>> + */
>> +static inline u32 ualink_exp_accel_id(struct amdgpu_device *adev)
>> +{
>> +    if (adev->ualink.loopback.enabled)
>> +        return adev->ualink.loopback.exporter_accel_id;
>> +
>> +    return adev->ualink.info->ppod.accel_id;
>> +}
>> +
>> +static inline u32 ualink_imp_accel_id(struct amdgpu_device *adev)
>> +{
>> +    if (adev->ualink.loopback.enabled)
>> +        return adev->ualink.loopback.importer_accel_id;
>> +
>> +    return adev->ualink.info->ppod.accel_id;
>> +}
>> +
>>   static bool amdgpu_ualink_is_local_accel(struct amdgpu_device *adev,
>>                        u32 accel_id)
>>   {
>> @@ -4487,11 +4546,6 @@ static bool
>> amdgpu_ualink_vpod_membership_changed(struct amdgpu_device *adev)
>>                    AMDGPU_UALINK_ACCEL_MAX);
>>   }
>>   -static inline u32 ualink_accel_id(struct amdgpu_device *adev)
>> -{
>> -    return adev->ualink.info->ppod.accel_id;
>> -}
>> -
>>   static inline enum amdgpu_ualink_addr_mode ualink_addr_mode(struct
>> amdgpu_device *adev)
>>   {
>>       return adev->ualink.info->vpod.addr_mode;
>> @@ -4837,7 +4891,7 @@ static void
>> amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
>>   {
>>       struct amdgpu_ualink_remote *remote = to_remote(adev);
>>       u64 timeout = msecs_to_jiffies(2000);
>> -    u32 dst_accel_id = ualink_accel_id(adev);
>> +    u32 dst_accel_id = ualink_exp_accel_id(adev);
>>       struct amdgpu_bo *bos[2];
>>       u32 n_bos;
>>       struct dma_fence *fence;
>> @@ -4956,7 +5010,7 @@ static void
>> amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
>>   static int amdgpu_ualink_metadata_npa_mapping(struct amdgpu_device
>> *adev)
>>   {
>>       struct amdgpu_ualink_remote *remote = to_remote(adev);
>> -    u32 dst_accel_id = ualink_accel_id(adev);
>> +    u32 dst_accel_id = ualink_exp_accel_id(adev);
>>       u64 timeout = msecs_to_jiffies(2000);
>>       struct amdgpu_bo *bos[2];
>>       u32 n_bos;
>> @@ -5241,7 +5295,7 @@ static void amdgpu_ualink_metadata_fini(struct
>> amdgpu_device *adev)
>>   {
>>       struct amdgpu_ualink_remote *remote = to_remote(adev);
>>   -    dev_dbg(adev->dev, "accel_id %u\n", ualink_accel_id(adev));
>> +    dev_dbg(adev->dev, "accel_id %u\n", ualink_exp_accel_id(adev));
>>       amdgpu_bo_free_kernel(&remote->rptr_bo, &remote->rptr_gpu_addr,
>>                         &remote->rptr_cpu_addr);
>>       amdgpu_bo_free_kernel(&remote->ring_bo, &remote->rb_gpu_addr,
>> @@ -5288,7 +5342,7 @@ static int amdgpu_ualink_metadata_init(struct
>> amdgpu_device *adev)
>>       }
>>         dev_dbg(adev->dev, "accel_id %u addr_mode %d fw status 0x%x\n",
>> -        ualink_accel_id(adev), ualink_addr_mode(adev), status);
>> +        ualink_exp_accel_id(adev), ualink_addr_mode(adev), status);
>>         /* Alloc metadata structure for all GPUs */
>>       metadata_size = sizeof(struct amdgpu_ualink_metadata) *
>> AMDGPU_UALINK_ACCEL_MAX;
>> @@ -5361,12 +5415,12 @@ static int amdgpu_ualink_metadata_init(struct
>> amdgpu_device *adev)
>>       }
>>         if (ualink_addr_mode(adev) ==
>> AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS)
>> -        wptr_gpu_addr = remote->rb_gpu_addr + rb_size *
>> ualink_accel_id(adev);
>> +        wptr_gpu_addr = remote->rb_gpu_addr + rb_size *
>> ualink_exp_accel_id(adev);
>>         for_each_set_bit(accel_id, remote->active_accel_bits,
>> AMDGPU_UALINK_ACCEL_MAX) {
>>           dev_dbg(adev->dev, "init for accel_id %u\n", accel_id);
>>   -        if (accel_id == ualink_accel_id(adev))
>> +        if (accel_id == ualink_exp_accel_id(adev))
>>               continue;
>>             rb_gpu_addr = remote->rb_gpu_addr + rb_size * accel_id;
>> @@ -5392,7 +5446,7 @@ static int amdgpu_ualink_metadata_init(struct
>> amdgpu_device *adev)
>>                                ualink_tlb_wptr_offset(adev, accel_id);
>>             dev_dbg(adev->dev, "init from accel_id %u to accel_id %u,
>> rb_size 0x%x\n",
>> -            accel_id, ualink_accel_id(adev),
>> metadata[accel_id].rb_size);
>> +            accel_id, ualink_exp_accel_id(adev),
>> metadata[accel_id].rb_size);
>>           dev_dbg(adev->dev, "rb 0x%llx tlb rb 0x%llx\n",
>>               metadata[accel_id].ri_rb, metadata[accel_id].tlb_inv_rb);
>>           dev_dbg(adev->dev, "rb wptr at 0x%llx tlb wptr at 0x%llx\n",
>> @@ -5806,7 +5860,14 @@ static void amdgpu_ualink_get_wb_addr(struct
>> amdgpu_device *adev,
>>                         u64 *wb_npa, u32 type)
>>   {
>>       struct amdgpu_ualink_remote *remote = to_remote(adev);
>> -    u32 accel_id = ualink_accel_id(adev);
>> +    /* The GPUID encoded in the write-back NPA address is the
>> routing target
>> +     * the remote writes the rptr back to, i.e. THIS GPU. It must be
>> the
>> +     * physically-owned accel_id: outside loopback that is our own
>> accel_id,
>> +     * and in loopback it is the exporter (the only id the single
>> GPU owns
>> +     * and can receive on). The importer is only a logical source id
>> for the
>> +     * forward path and must never appear as an NPA GPUID.
>> +     */
>> +    u32 accel_id = ualink_exp_accel_id(adev);
>>       u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
>>       uintptr_t wb;
>>       u64 npa;
>> @@ -5981,19 +6042,19 @@ static int
>> amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>>                              &peer->shootdown, &tlb_wptr);
>>       if (r) {
>>           dev_dbg(adev->dev, "accel_id %u read remote %u wptr failed
>> %d\n",
>> -            ualink_accel_id(adev), remote_accel_id, r);
>> +            ualink_exp_accel_id(adev), remote_accel_id, r);
>>           return r;
>>       }
>>         if (peer->interrupt.wptr == int_wptr && peer->shootdown.wptr
>> == tlb_wptr) {
>>           dev_dbg(adev->dev, "accel_id %u wptr 0x%llx 0x%llx is same
>> as remote %u\n",
>> -            ualink_accel_id(adev), int_wptr, tlb_wptr,
>> remote_accel_id);
>> +            ualink_exp_accel_id(adev), int_wptr, tlb_wptr,
>> remote_accel_id);
>>           return 0;
>>       }
>>         dev_dbg(adev->dev,
>>           "accel_id %u wptr 0x%llx 0x%llx sync to remote %u wptr
>> 0x%llx 0x%llx\n",
>> -        ualink_accel_id(adev), peer->interrupt.wptr,
>> peer->shootdown.wptr,
>> +        ualink_exp_accel_id(adev), peer->interrupt.wptr,
>> peer->shootdown.wptr,
>>           remote_accel_id, int_wptr, tlb_wptr);
>>         amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &int_wb, NULL,
>> @@ -6164,7 +6225,7 @@ static int
>> amdgpu_ualink_peer_remote_init(struct amdgpu_device *adev)
>>       struct amdgpu_ualink_peer *peer;
>>       struct amdgpu_ualink_ring *interrupt;
>>       struct amdgpu_ualink_ring *shootdown;
>> -    u32 src_accel_id = ualink_accel_id(adev);
>> +    u32 src_accel_id = ualink_exp_accel_id(adev);
>
> This is changed to ualink_imp_accel_id in patch 5. I think we should
> use the correct function here, where it's introduced.
>
Good catch. I made the change here and removed the change from patch 5.
>
>>       u32 dst_accel_id;
>>       u64 npa, flags;
>>       int r = 0;
>> @@ -6287,7 +6348,7 @@ static void
>> amdgpu_ualink_peer_remote_fini(struct amdgpu_device *adev)
>>   {
>>       u32 rb_pages = AMDGPU_UALINK_RB_SIZE >> AMDGPU_GPU_PAGE_SHIFT;
>>       struct amdgpu_ualink_remote *remote = to_remote(adev);
>> -    u32 src_accel_id = ualink_accel_id(adev);
>> +    u32 src_accel_id = ualink_exp_accel_id(adev);
>
> This is changed to ualink_imp_accel_id in patch 5. I think we should
> use the correct function here, where it's introduced.

Good catch. I made the change here and removed the change from patch 5. 

Regards,

Mukul

>
> Regards,
>   Felix
>
>
>>       u32 dst_accel_id;
>>       struct amdgpu_ualink_peer *peer;
>>       struct amdgpu_ualink_ring *ring;
>> @@ -6374,7 +6435,7 @@ int amdgpu_ualink_sw_init(struct amdgpu_device
>> *adev)
>>    */
>>   void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
>>   {
>> -    dev_dbg(adev->dev, "halt accel_id %u addr_mode %d\n",
>> ualink_accel_id(adev),
>> +    dev_dbg(adev->dev, "halt accel_id %u addr_mode %d\n",
>> ualink_exp_accel_id(adev),
>>           ualink_addr_mode(adev));
>>         adev->ualink.msg_ctl->send_halt(adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>> index 85c9a9634a4b..0b1e8dd38666 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>> @@ -97,6 +97,17 @@ enum AMDGPU_UALINK_PROTOCOL_MESSAGES {
>>   #define AMDGPU_UALINK_LIGHTWEIGHT_TLB_SHOOTDOWN        0x1
>>   #define AMDGPU_UALINK_HEAVYWEIGHT_TLB_SHOOTDOWN        0x2
>>   +/* UALink loopback support.
>> + *
>> + * In loopback mode a single GPU loops UALink requests back to
>> itself for
>> + * manufacturing testing. The GPU exposes two fixed accelerator IDs:
>> it acts
>> + * as the exporter on one and the importer on the other. Loopback is
>> enabled
>> + * with the amdgpu.ualink_loopback module parameter.
>> + */
>> +/* Fixed accelerator IDs used by a loopback GPU. */
>> +#define AMDGPU_UALINK_LOOPBACK_EXPORTER_ACCID        1
>> +#define AMDGPU_UALINK_LOOPBACK_IMPORTER_ACCID        0
>> +
>>   enum amdgpu_ualink_conn_state {
>>       AMDGPU_UALINK_CONN_NOT_READY            = 0,
>>       AMDGPU_UALINK_CONN_IN_PROGRESS            = 1,
>> @@ -319,6 +330,21 @@ struct amdgpu_ualink_msg_ctl {
>>       int (*send_halt)(struct amdgpu_device *adev);
>>   };
>>   +/* UALink loopback mode state.
>> + *
>> + * When @enabled is true this single GPU acts as both exporter
>> + * (@exporter_accel_id) and importer (@importer_accel_id). There is
>> no second
>> + * physical GPU, so exporter->importer messages cannot be delivered
>> by the
>> + * (single) MP nHT and are instead emulated in SW by feeding them
>> back into
>> + * our own IRQ handler via @wq.
>> + */
>> +struct amdgpu_ualink_loopback {
>> +    bool enabled;
>> +    u32 exporter_accel_id;
>> +    u32 importer_accel_id;
>> +    struct workqueue_struct *wq;
>> +};
>> +
>>   struct amdgpu_ualink_mgr {
>>       u64 npa_size;
>>       u32 psp_if_ver;
>> @@ -333,6 +359,9 @@ struct amdgpu_ualink_mgr {
>>       /* For remote interrupt and shootdown */
>>       struct amdgpu_ualink_remote *remote;
>>   +    /* UALink loopback mode state (see struct
>> amdgpu_ualink_loopback) */
>> +    struct amdgpu_ualink_loopback loopback;
>> +
>>       /* handle irq from ualink client of remote GPUs */
>>       struct amdgpu_irq_src irq;
>>   
