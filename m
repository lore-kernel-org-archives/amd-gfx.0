Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5694C636CD
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 15:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CCCC10E555;
	Tue,  7 Feb 2023 15:43:49 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF3BA10E559
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 15:43:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Py3KAC2PB++8jhpkFTnZHn7iHFdj/H1f/Em4XJJ9sN8wjyX1gmaA+0vTlHpJSuRuIyD2z5r22STd67PBDfnGIUyMG+j9Fs+SRggJmjGf7KeFAWH6kxWMYGxs5y0NyYaLUG3tQvmkW2NAw2STBkxV07iwA3DUFwQDeFMxF8XJZ8hiL+uEGdGptSflzAur8jEoePhc499ENEdT4cwMLSk8LNp70r3x/+sUUENMtMeOr7Qc5wcMrdywOR8IlWAQgeWBz1TmdZY5YY3DitrDSR2CF8aqMcMMxvWMDbgIJt3+yw3J+rAz4X4SBWFy9vAwwrPqIiXoCDxVwnuWq5e7w6+B4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsG+ffao2PHsMZA88RAWepIqrFI/FhsIaCyQgv7bvq8=;
 b=mK689XNt/kkMBsA4prHKU4XP/eTrUmX+jv+ShStXoKx8qubaUnbRvA5Lw8PCe6g0j5CwTEjtHr4h2ALsJR8SdzHBmdXsq+v5rAeo7TwledXbJxEUKWHRBJywBrVWK6dmDmrtaHOlfgHhOH0lg4X1UleHbohLbDsWwegMLMBkDz6umWIjGm4F4KiAVrGe01mZy+YCvta3qgAWCndjw8f1NhiWAejc4tApHqiJWX543jvlkPa04YZeyD9Ga6b8G/j8CPf45gSgemTS8F/2HYE0WExGW17uT4euTIz3oaMRLHJIxqNcDqiBu0yo4z8uq4fApQQqRPFcLOcqaVv+R6G3Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsG+ffao2PHsMZA88RAWepIqrFI/FhsIaCyQgv7bvq8=;
 b=5jTKmUQlHHx3kKvAg3TDxAQf47yu1aziLJuOZtkAJxB1rh4jsahK53sm4J5u8sW0b92t7cwAQ11hHn3ZT1/fQ0OIyQZbBtR90eUi42K7hP1dMWgUWVGO/TQuSc+t2CLx4yBsXWTeZqsVWaOXI2DvvsfuZbO8t0/5hAJuJl/eP6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH2PR12MB4971.namprd12.prod.outlook.com (2603:10b6:610:6b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Tue, 7 Feb
 2023 15:43:44 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f%4]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 15:43:44 +0000
Message-ID: <d6e62077-7c6e-1fb4-8abe-275ccdf72003@amd.com>
Date: Tue, 7 Feb 2023 16:43:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/8] drm/amdgpu: Add V11 graphics MQD functions
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-5-shashank.sharma@amd.com>
 <CADnq5_M8wnDZUEvDVA_CdyE0sxgg0FragSbO19LjhRE_XMJ-OA@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_M8wnDZUEvDVA_CdyE0sxgg0FragSbO19LjhRE_XMJ-OA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::11) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CH2PR12MB4971:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1470c5-9a51-461f-e6d0-08db09221802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q/pu8msqn7/sdeGuNnqdT5KE0k+r70iNyHCm1yMkWvBgZPoWNXI8EBKEdjLKFJ+8dan3bnGSZ7L3kJQq5h3x/OiCzsSwU47LCRdm3mn6JcafrtEFyTHpXqseQ6ofXPyfqqxiq9PaZrogTzfMZ6/XpO02An9fo9ffprmB2qucew2Js+4CwCNVd9dzSKPCjUoQqwtAXhMDdPULvHOB300uLhtFWt15Oi/R1ejN00gQdX30rIgoMFf8RngPornsVUwo64/RYIJm+WCfbXFFulL1lFbvyiibnJ0+kuPUppeWcn4JqPCSktkPnaMsyuVZCMaXQ3xnFFx5cWiGWx+JtU4MQO5f2YhYqolx7j/N6Wzuwev2d7DlSy7eOROgqTPB1iOS4wVRc7SsR0NfAFFO9wLHXlRlngd29ANd50eJICjrrzDMzu8v7f4ZK4zb9ZVuhmvlffLorQmj9h2YBMxKCDZHT6HDNPYfSHyzDOkAtR+MD5h00KysvOWOESBNmpuYtuGC3sC9+1dxjexBr0krm4JKDXyK5eRXQdfjc3tKm4OsZI4po1e+/pdKHKnphqR7erbk7bMpRx/iRZ5mzhDlYabpT/88S2yzrBVhoDmpU3ZWTj5RYq1C5iHSJR/bqlMIC5sWAqBa0lGUb/6UXmMpBHNVKGSVQaCvFa83TwURYNU/IuVz2G9FmfMXmMIi+gYw7LHr9g6AUmiAVf/VthOL55XozuS8RhjVdi9wuXs8evfwSp0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199018)(66899018)(31686004)(54906003)(66946007)(4326008)(38100700002)(6486002)(66476007)(6916009)(478600001)(316002)(8676002)(66556008)(31696002)(86362001)(36756003)(83380400001)(186003)(6506007)(26005)(6512007)(53546011)(2616005)(41300700001)(8936002)(5660300002)(6666004)(2906002)(44832011)(30864003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVNLSGowLzV2TUZvcUdRZ1ZRa0NHcTBxdCtvNlNlWU90MFBhZGVFTldGcnlm?=
 =?utf-8?B?cG1LN1ZRaFhTVWJXSCtWUk1vZmNXQzJ5OXhGNlVGazdCa0tVR0RMc3ZEbExU?=
 =?utf-8?B?b1FqaG54MXE1aXJRamdhVndjOGlsM205WVkvU2JQbVFSMndua0ZIY3pVdksy?=
 =?utf-8?B?Z2U4U1FYcDhCa21wNEFDZ2dQUjRxVFJQUE5GbWx0UE9RWGNIbVhYaWZXZmlw?=
 =?utf-8?B?ZjYzWjVZRE5qZ2pqdDhZVGYweTVpM1c0UFlwNDZ2SzI3Tk1Ob1JUdy9SOGU1?=
 =?utf-8?B?WW84YnRERWt0eWZhcDFzWmI5eGpPRksxVkxRcFZ2b2hYUHhEUjJOaTZ2Zk5Q?=
 =?utf-8?B?aDNVUkFxUUtYNjV5VlVBNldZd0VXRlZtWUJGUnZyOWNvaHVGK1RTeVRMTTY3?=
 =?utf-8?B?VnZ5NnRqblFrRkx1Ni9xQnlkUXl6OWYxWXlOcDRpVDlEejkxQjhXMjJyN05X?=
 =?utf-8?B?MWg3OWpRc3F0RTRkcUZPRXdQMGZTbEFPMXlzbmp0WU1LOW8wYTZ2eUpJaWp5?=
 =?utf-8?B?eE9yVnljMk5aY0F4b2JaU1JqUzNFN2pvQUdCOCt4cnJTclJXN2lsNE1VUWZw?=
 =?utf-8?B?TmNuUG9PZHR4K01RVy9kc3RHY2NPWllSamZKaG5KcmoycGQxand2clA2bGZs?=
 =?utf-8?B?Y1YvMExEWVpLbVpldFJVQllCYXVzSzAxMzRZZFhST2k0a2dIWXBJZzZvMzVK?=
 =?utf-8?B?MHFhb0pqdG5INUI5N3Q5aCtkUkZtK1dvNktCVHVnSUxmWEEweWxScHB3VzBK?=
 =?utf-8?B?T1JpYWRHYm95VWEwc2NxR25hNUV1d01PWDFsZkpCNTlLMGhSYXorVE9oMjg3?=
 =?utf-8?B?cGlGMU9KU1cxTHpmMGNmQmltQWRoR3kxdkprSlFFbUhGM0RFZmIwNTB3WVVC?=
 =?utf-8?B?VTlpeXJ2ZVBhOUZkdDd6aHAxQUxHRndleVFENjBQV1k1emNHNndiZWZGUUw0?=
 =?utf-8?B?b0JLSmpWdkFmemRlU0ZSbm95Z2VmMzIvcW00RlFPNWF0N3ZQQUVHRk15K24x?=
 =?utf-8?B?NnBNc1R0cGJvWnhQZHJWT3JkeFNBMTVzVFJkSWdDK0NubTBNQVVsQTR5a01Q?=
 =?utf-8?B?VGQrajJhMllsd2V2cWlBYjB1YjdMT0o4c2w1cEFmVFM5Z1pBSDU0bkNOQ3ds?=
 =?utf-8?B?UG1DYnFEMHE0anlJN2hvaURDN0Y5V2VJWnpLYW9HWFdBVUdlQ1R0K05CbkpK?=
 =?utf-8?B?VXgvak5uSGVEM0FRZmE3aHFMMG9abUh3eHI1eXdyanlubDl1YVFGR08rRkVy?=
 =?utf-8?B?bWZqeU9raDV0c1o4bnZnSkFOYTkwS0FIL1VvTmRLcy82Rk5WeFlYNGE2b0tR?=
 =?utf-8?B?ZkJNU0FENUJTRzB1VlAvTGFra1lzNU44K3FOaVlsem1xSkIxZFYvcnFFcnh2?=
 =?utf-8?B?a1V4OTJmMjRZQ3haZnlLTEM4bmliNzNna1ZWc0liNktuaUhEck9uRjUxVXA2?=
 =?utf-8?B?K2Q0UkdCU0lra2IybnIzQUpwTm5TMjBmeTBwMmZsdGQrV01KMWtTa0dVZ2pE?=
 =?utf-8?B?MGREMDZtNlBiQmdMUHo4S2ZSenlpUVpmL2RLbk40Y1Z5NmJ4MitBakVmazdr?=
 =?utf-8?B?S1lGS0FtbmxBSUsxeURGRjFsUlFxcFduWHpPM1FJZCtYTXlOMkVqK1I5WUNH?=
 =?utf-8?B?WkpZeTA5QUxjMUVkekdGbTczazZlWThFNkpMV0VRUkh6WEtFemkrL2w0R0k0?=
 =?utf-8?B?MURIemw0emhmeUo0ekY4WjFVWXRFYmFaV0RkTWJxL3g2c1ZSSUthMDFjSlRa?=
 =?utf-8?B?N1ZWUWNmcm42czFQaWRGL0NmckdDeDRlRzFOZ3BET2twZVpuR3JOTWNqa045?=
 =?utf-8?B?MDFXRXN2VlM1UDZ2RzZhbGgycG53VU9oSFpwQTZxYXhoTnV0NEpqaFVTL0k5?=
 =?utf-8?B?OHU3d0xoTUY4UDIyN1ZzdlJ6Vmp5OWhKUitzNTBYSURJb0pTVDdnVjFMUENW?=
 =?utf-8?B?ODR3TDhUcy8rZlRyQ0U2MUh4ZnRGc2NobUhiNFNvRkhKWkw4aW1rODRtSm1h?=
 =?utf-8?B?TExSOWR0eWt0QTJjVDA1ZE93TG1pMVpKV3cxa1NWUzMrdlhIRHNQS0FjWGF4?=
 =?utf-8?B?VUpkdWlML3RsdzJ3bmZId3NIN2JWRVFOKzVJTDBzeXZ3S0dLZ2YzOENmR2JQ?=
 =?utf-8?Q?EVZeHW/JoQ+HFvR9op9jgQaGv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1470c5-9a51-461f-e6d0-08db09221802
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 15:43:44.2250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ieo7dZsCW0UUyXKo34JZBUW/YhE9/+a7ZN8dA4HcidVB+e1SrPqF4dMOk9IZqc2qaX+V63VlE1R0abblBoKmcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4971
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
Cc: alexander.deucher@amd.com, Arvind Yadav <arvind.yadav@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 07/02/2023 16:17, Alex Deucher wrote:
> On Fri, Feb 3, 2023 at 4:55 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>
>> MQD describes the properies of a user queue to the HW, and allows it to
>> accurately configure the queue while mapping it in GPU HW. This patch
>> adds:
>> - A new header file which contains the userqueue MQD definition for
>>    V11 graphics engine.
>> - A new function which fills it with userqueue data and prepares MQD
>> - A function which sets-up the MQD function ptrs in the generic userqueue
>>    creation code.
>>
>> V1: Addressed review comments from RFC patch series
>>      - Reuse the existing MQD structure instead of creating a new one
>>      - MQD format and creation can be IP specific, keep it like that
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  28 ++++
>>   .../amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c | 132 ++++++++++++++++++
>>   drivers/gpu/drm/amd/include/v11_structs.h     |  16 +--
>>   4 files changed, 169 insertions(+), 8 deletions(-)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 764801cc8203..6ae9d5792791 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -212,6 +212,7 @@ amdgpu-y += amdgpu_amdkfd.o
>>
>>   # add usermode queue
>>   amdgpu-y += amdgpu_userqueue.o
>> +amdgpu-y += amdgpu_userqueue_mqd_gfx_v11.o
>>
>>   ifneq ($(CONFIG_HSA_AMD),)
>>   AMDKFD_PATH := ../amdkfd
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index 625c2fe1e84a..9f3490a91776 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -202,13 +202,41 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>>       return r;
>>   }
>>
>> +extern const struct amdgpu_userq_mqd_funcs userq_gfx_v11_mqd_funcs;
>> +
>> +static int
>> +amdgpu_userqueue_setup_mqd_funcs(struct amdgpu_userq_mgr *uq_mgr)
>> +{
>> +    int maj;
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
>> +
>> +    maj = IP_VERSION_MAJ(version);
>> +    if (maj == 11) {
>> +        uq_mgr->userq_mqd_funcs = &userq_gfx_v11_mqd_funcs;
>> +    } else {
>> +        DRM_WARN("This IP doesn't support usermode queues\n");
>> +        return -EINVAL;
>> +    }
>> +
> I think it would be cleaner to just store these callbacks in adev.
> Maybe something like adev->user_queue_funcs[AMDGPU_HW_IP_NUM].  Then
> in early_init for each IP, we can register the callbacks.  When the
> user goes to create a new user_queue, we can check check to see if the
> function pointer is NULL or not for the queue type:
>
> if (!adev->user_queue_funcs[ip_type])
>    return -EINVAL
>
> r = adev->user_queue_funcs[ip_type]->create_queue();

Sounds like a good idea, we can do this.

>
> Actually, there is already an mqd manager interface (adev->mqds[]).
> Maybe you can leverage that interface.

Yep, I saw that and initially even tried to work on that interface 
itself, and then realized that it doesn't allow us to pass some

additional parameters (like queue->vm, various BOs like proc_ctx_bo, 
gang_ctx_bo's and so on). All of these are required in the MQD

and we will need them to be added into MQD. I even thought of expanding 
this structure with additional parameters, but I felt like

it defeats the purpose of this MQD properties. But if you feel strongly 
about that, we can work around it.

>> +    return 0;
>> +}
>> +
>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
>>   {
>> +    int r;
>> +
>>       mutex_init(&userq_mgr->userq_mutex);
>>       idr_init_base(&userq_mgr->userq_idr, 1);
>>       INIT_LIST_HEAD(&userq_mgr->userq_list);
>>       userq_mgr->adev = adev;
>>
>> +    r = amdgpu_userqueue_setup_mqd_funcs(userq_mgr);
>> +    if (r) {
>> +        DRM_ERROR("Failed to setup MQD functions for usermode queue\n");
>> +        return r;
>> +    }
>> +
>>       return 0;
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
>> new file mode 100644
>> index 000000000000..57889729d635
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
>> @@ -0,0 +1,132 @@
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +#include "amdgpu.h"
>> +#include "amdgpu_userqueue.h"
>> +#include "v11_structs.h"
>> +#include "amdgpu_mes.h"
>> +#include "gc/gc_11_0_0_offset.h"
>> +#include "gc/gc_11_0_0_sh_mask.h"
>> +
>> +static int
>> +amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>> +{
>> +    uint32_t tmp, rb_bufsz;
>> +    uint64_t hqd_gpu_addr, wb_gpu_addr;
>> +    struct v11_gfx_mqd *mqd = queue->mqd_cpu_ptr;
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +
>> +    /* set up gfx hqd wptr */
>> +    mqd->cp_gfx_hqd_wptr = 0;
>> +    mqd->cp_gfx_hqd_wptr_hi = 0;
>> +
>> +    /* set the pointer to the MQD */
>> +    mqd->cp_mqd_base_addr = queue->mqd_gpu_addr & 0xfffffffc;
>> +    mqd->cp_mqd_base_addr_hi = upper_32_bits(queue->mqd_gpu_addr);
>> +
>> +    /* set up mqd control */
>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_MQD_CONTROL);
>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, VMID, 0);
>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, PRIV_STATE, 1);
>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, CACHE_POLICY, 0);
>> +    mqd->cp_gfx_mqd_control = tmp;
>> +
>> +    /* set up gfx_hqd_vimd with 0x0 to indicate the ring buffer's vmid */
>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_VMID);
>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_VMID, VMID, 0);
>> +    mqd->cp_gfx_hqd_vmid = 0;
>> +
>> +    /* set up default queue priority level
>> +    * 0x0 = low priority, 0x1 = high priority */
>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_QUEUE_PRIORITY);
>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUEUE_PRIORITY, PRIORITY_LEVEL, 0);
>> +    mqd->cp_gfx_hqd_queue_priority = tmp;
>> +
>> +    /* set up time quantum */
>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_QUANTUM);
>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_EN, 1);
>> +    mqd->cp_gfx_hqd_quantum = tmp;
>> +
>> +    /* set up gfx hqd base. this is similar as CP_RB_BASE */
>> +    hqd_gpu_addr = queue->queue_gpu_addr >> 8;
>> +    mqd->cp_gfx_hqd_base = hqd_gpu_addr;
>> +    mqd->cp_gfx_hqd_base_hi = upper_32_bits(hqd_gpu_addr);
>> +
>> +    /* set up hqd_rptr_addr/_hi, similar as CP_RB_RPTR */
>> +    wb_gpu_addr = queue->rptr_gpu_addr;
>> +    mqd->cp_gfx_hqd_rptr_addr = wb_gpu_addr & 0xfffffffc;
>> +    mqd->cp_gfx_hqd_rptr_addr_hi =
>> +    upper_32_bits(wb_gpu_addr) & 0xffff;
>> +
>> +    /* set up rb_wptr_poll addr */
>> +    wb_gpu_addr = queue->wptr_gpu_addr;
>> +    mqd->cp_rb_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffffc;
>> +    mqd->cp_rb_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
>> +
>> +    /* set up the gfx_hqd_control, similar as CP_RB0_CNTL */
>> +    rb_bufsz = order_base_2(queue->queue_size / 4) - 1;
>> +    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_CNTL);
>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BUFSZ, rb_bufsz);
>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BLKSZ, rb_bufsz - 2);
>> +#ifdef __BIG_ENDIAN
>> +    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, BUF_SWAP, 1);
>> +#endif
>> +    mqd->cp_gfx_hqd_cntl = tmp;
>> +
>> +    /* set up cp_doorbell_control */
>> +    tmp = RREG32_SOC15(GC, 0, regCP_RB_DOORBELL_CONTROL);
>> +    if (queue->use_doorbell) {
>> +        tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
>> +                    DOORBELL_OFFSET, queue->doorbell_index);
>> +        tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
>> +                    DOORBELL_EN, 1);
>> +    } else {
>> +        tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
>> +                    DOORBELL_EN, 0);
>> +    }
>> +    mqd->cp_rb_doorbell_control = tmp;
>> +
>> +    /* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
>> +    mqd->cp_gfx_hqd_rptr = RREG32_SOC15(GC, 0, regCP_GFX_HQD_RPTR);
>> +
>> +    /* activate the queue */
>> +    mqd->cp_gfx_hqd_active = 1;
>> +
> Can you use gfx_v11_0_gfx_mqd_init() and gfx_v11_0_compute_mqd_init()
> directly or leverage adev->mqds[]?

Let us try this out and come back.

- Shashank


>
> Alex
>
>> +    return 0;
>> +}
>> +
>> +static void
>> +amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>> +{
>> +
>> +}
>> +
>> +static int amdgpu_userq_gfx_v11_mqd_size(struct amdgpu_userq_mgr *uq_mgr)
>> +{
>> +    return sizeof(struct v11_gfx_mqd);
>> +}
>> +
>> +const struct amdgpu_userq_mqd_funcs userq_gfx_v11_mqd_funcs = {
>> +    .mqd_size = amdgpu_userq_gfx_v11_mqd_size,
>> +    .mqd_create = amdgpu_userq_gfx_v11_mqd_create,
>> +    .mqd_destroy = amdgpu_userq_gfx_v11_mqd_destroy,
>> +};
>> diff --git a/drivers/gpu/drm/amd/include/v11_structs.h b/drivers/gpu/drm/amd/include/v11_structs.h
>> index b8ff7456ae0b..f8008270f813 100644
>> --- a/drivers/gpu/drm/amd/include/v11_structs.h
>> +++ b/drivers/gpu/drm/amd/include/v11_structs.h
>> @@ -25,14 +25,14 @@
>>   #define V11_STRUCTS_H_
>>
>>   struct v11_gfx_mqd {
>> -       uint32_t reserved_0; // offset: 0  (0x0)
>> -       uint32_t reserved_1; // offset: 1  (0x1)
>> -       uint32_t reserved_2; // offset: 2  (0x2)
>> -       uint32_t reserved_3; // offset: 3  (0x3)
>> -       uint32_t reserved_4; // offset: 4  (0x4)
>> -       uint32_t reserved_5; // offset: 5  (0x5)
>> -       uint32_t reserved_6; // offset: 6  (0x6)
>> -       uint32_t reserved_7; // offset: 7  (0x7)
>> +       uint32_t shadow_base_lo; // offset: 0  (0x0)
>> +       uint32_t shadow_base_hi; // offset: 1  (0x1)
>> +       uint32_t gds_bkup_base_lo; // offset: 2  (0x2)
>> +       uint32_t gds_bkup_base_hi; // offset: 3  (0x3)
>> +       uint32_t fw_work_area_base_lo; // offset: 4  (0x4)
>> +       uint32_t fw_work_area_base_hi; // offset: 5  (0x5)
>> +       uint32_t shadow_initialized; // offset: 6  (0x6)
>> +       uint32_t ib_vmid; // offset: 7  (0x7)
>>          uint32_t reserved_8; // offset: 8  (0x8)
>>          uint32_t reserved_9; // offset: 9  (0x9)
>>          uint32_t reserved_10; // offset: 10  (0xA)
>> --
>> 2.34.1
>>
