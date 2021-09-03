Return-Path: <SRS0=/nsf=NZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BA4C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Sep 2021 15:28:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B13960462
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Sep 2021 15:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9B13960462
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AEF96E8A3;
	Fri,  3 Sep 2021 15:28:33 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2085.outbound.protection.outlook.com [40.107.102.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D28336E8A3
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Sep 2021 15:28:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lczGxzEV7BPBffLdCvhscg6dh0yCURoVM8ILeqC6YjRCsjlz4dxl+kj1PUj6r6PwrKLTGsLMq2emmyi1gEoVAsfS5YH651/OP5vMqVeAufbRh8WqSmEUB0AP3UoU9wtOfucNlghPMNzOaHJpNNnSG3Al+aGUPIAc0nannVjbmqvZ6U56S6bZ/UrV0eyLj0w+pB4tKtsnxh952B665fIxtvx5N+3xx8eIb9s+wjOdOChLNMVePgh3s+uq00vGwwUROBhekTWCn009Ez7aPGZ3NeLw2mtkuptqm9qqUbkLr0Rev7NJGeCswavZ2blUNwfUv3mM21V1eaPtd03OUjwjcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=eIh2fb25tkUMCOqaiwbWfL+en6PqqY46WGiT7Md560I=;
 b=NYPc7TK1us2KnyhOkrQbbDIvq7lH+fj3VDWaKPO6nzbZ6USpmmG2AZz7Pgrs+xECN83U7SywQaHY88FEyNymDTT3AdDrZgpzEEa3EzBnyQTOV2ulDxEYnaseLXRZCbYqb8foJLdAr4bNx7jGjP0OsoVmbbfp7owaeR/CBSOL2/t+a48EnFiy3XVmbpCRtjU7ouGryQPn3LeE2G1bZ7XLJ2TfiXZDh5AKtv49gBK3VUzKEgFjkRtw5uSQAdYpR9BlqBMeOL2+awIF1jcqeCIfDfJfT7NntaoD97k0LvZH25po6jkZLTy6IdJdMeZAHyNlRwiCGLSgKhijhBMutaJzRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIh2fb25tkUMCOqaiwbWfL+en6PqqY46WGiT7Md560I=;
 b=5YPe0yafBksRXL/0rXolbSPBAw3gk5lY9shzXi75IyyhQxAN0Dq9HAQKS6zsRO5y0Zc6j/aYnsEoZTgTs1yrs5iHk5BbQtnX71QD90lbTcRgJf7ZnfPR27usj/K45DHdlgoqo0zCntKisk1sYC9fp+IgZ2H5zfoT8QVyoWwdC7Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Fri, 3 Sep
 2021 15:28:31 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9c06:d113:293:f09b]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9c06:d113:293:f09b%8]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 15:28:31 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: use IS_ERR for debugfs APIs
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Das, Nirmoy" <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210902114459.3866-1-nirmoy.das@amd.com>
 <5aeadf99-0864-1e45-63fa-a9f299d373f7@amd.com>
 <1fdd6081-b332-fdff-2190-5f8ead784b59@amd.com>
 <5f6f85c8-5bb0-55d7-06e2-e14c230ed6ea@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
Message-ID: <4eb1dabb-b2b6-295a-5529-0150ecd4adbd@amd.com>
Date: Fri, 3 Sep 2021 20:58:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <5f6f85c8-5bb0-55d7-06e2-e14c230ed6ea@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR0101CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::34) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
Received: from [192.168.68.104] (106.51.20.251) by
 MA1PR0101CA0048.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend
 Transport; Fri, 3 Sep 2021 15:28:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0689437-c995-4b45-805d-08d96eef7c5d
X-MS-TrafficTypeDiagnostic: DM4PR12MB5232:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB52320F03CDF4A2861748A249F2CF9@DM4PR12MB5232.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bMIRvT0KD8ox2zeyl+SiJQ3dZAuaNjOfMPRtdKOi2pXjOlBn/KkZqFCpJ6/pzXSUhGZx8etLip7Qm3m+CaDYX3hQMiEqLuszPz7653g6G/615Q4zZe2OnuwExbYN+LHr2/KDii6nVCM4Wc+6KqpgX2aGhJ1MCWR0VDhFrSLDKxiH/81wVFGOkcbxvR0hWg7rWyZn8eMRQrx4anuwfQVLRGQLtFpmejTcINb6xllpxfcxVPj4RVYpelvWyej8GWwPgviizUExedHdfUKA7K9EM+KNLaJ+KNueml+EeZ7ZsgW/onDnPNQiOmuZNfu0ZE9/f2KTtZjE0wX4OgApN98/u4BjgbfC5cYqamBi+rpBwy4qJOSz6nhoOIgw0CjEDdAjd2G8fBuovnw2Q5MS/vryLtRvWwycLDPL3n7DzfUyL3ZebgDJdRt9ZKE1kQe0WhsivK8w2gEW2XeMaaSBGYOZGteMGwKOhwc0FdS1EVkwYRDNevYgncvoOh3xWJv7iHYNPgr+9+dcal8In1YKpEozfhDEdYSyMpAVn6bMINInsQSmlwOiIPWpmja2GX+tyZ5WT8kjA1PsIMNvW/2UU1netnLH2fvSq+TfMsshob78mZzsM7KTAODJfuVW0QQFWhz3HEL9DFBaxHy/uNWMsh1wmtK8H1vCVRX71t6R2MoNBN7Shl3tZ9E5g1hohNnmLYjyAR85cxVYClvfVjlJzDTRFceMrzHiXdkQKdgFle+XcNI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(8676002)(31686004)(66946007)(66476007)(66556008)(8936002)(16576012)(26005)(110136005)(86362001)(2616005)(966005)(316002)(31696002)(6486002)(53546011)(956004)(36756003)(83380400001)(508600001)(5660300002)(2906002)(1006002)(38100700002)(55236004)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXhrRld6ZUlTeUdMeEZ2Zk02LytUL1JVM1dFVDIyQ284NjN5MmVXc002cFAy?=
 =?utf-8?B?VCtJN0swSWRCTTlUWi9xYUI3em95L1dMa0R2L05HYTFwRkVQUnNHWTJJU01s?=
 =?utf-8?B?T21FbmQ5YllGSWFHWlpqblo2STU0Tk52bkhKNC9qT3NtcEQ4TEJXdS9pVitM?=
 =?utf-8?B?UllZSGkzaFVnOWNSSDJRakZ1K2ttN3RKRDdJTUpDMnZSaXdyUGhyVFg5ODNk?=
 =?utf-8?B?a2cvMDVza1hFNU8zeGRqdVplcStjSG5nMWFDQy9NamVXMUhDT2MrV0xuYlRU?=
 =?utf-8?B?VERwUCt5WWVPUittMUtLK1pBT0hvd3NXemlOSFhmWGFIOVJ5SWg2MUE1SlF6?=
 =?utf-8?B?MVdoN21ORk1XK1RYUHhxME5sQURlaENaZnZUZjYrV2hYRHVlNDMzQzNzaDVa?=
 =?utf-8?B?aTNCMXlRT041RGo4OXFVTExtandZTDQ2YU9rWVRmVTVPWEc3eWtxenJrMXkw?=
 =?utf-8?B?ckhFN2ZWL2Jxckl4d3JSM1Job1JRUnpBaWFMemxZUW5SR2FTR3E0NzBKRW1o?=
 =?utf-8?B?UXVnVnc3bldzVHExcTZoVlh0K2dhU0VFQzlwMnNTMHNmOGlJUmxEc0doamly?=
 =?utf-8?B?OXRVUFN1NzdTQUo3RHVsUklsNG1pWjRpY0JLUmxqQ25Na1JaN3ROMTFvSWND?=
 =?utf-8?B?dVZkQnVJK1BLbHVPZnFOMzEzUEJiYmk1Szl6K204Y1VnUUZyOFpSdkxra0ZV?=
 =?utf-8?B?RzduTkdid0tNSHJaNjl6NUhUcVJydklKdTFGWmUxYnZtaUsrU1V5cGpqbmZ0?=
 =?utf-8?B?UXE4VzBlWGhBdFRLVTdUbUVKYzV1WDVkenVHaS9HOUtuTEVkcDZwSWhXTU9V?=
 =?utf-8?B?Tk8yUkdCWHdMRVlsN08rRHZZNGlxeGV2MW1WVDEzbUFQS0ZPOEZ3cmYyTHlZ?=
 =?utf-8?B?QXVlaFo3cHNONnc4dlUzN1lKeW9pY0hidGRNbFJtaVQ4RGVQMzk2a0hYcnRZ?=
 =?utf-8?B?K3hZdTM2aW1Jc2J4T0NuV3k4eXhHY2d1SXZpMUk3d1VXQkZTN0Z2d1g0Wk5v?=
 =?utf-8?B?TUlJZU94cDViWEtYTGwwM2NzbkdjZjhzQ0hpMXd0NGx2WWZnMjEwV0o2V2xk?=
 =?utf-8?B?bUhqeGM4TjBiNmZySjI5TXFwNVB5T0VYNDZnMU1WVlAyZDFBU0JQMlQ3dTli?=
 =?utf-8?B?WHU3Ti9XSW03RU0ySkY5VWZSTkdRU1JseHJ0VytPM00xaVlYaW9mOUxTSnhC?=
 =?utf-8?B?M2I4OTZhMVl2NFhmelpFVDlpM21HelhXUTQwYjlTNHM5NmNleWxiS0dMY1Qy?=
 =?utf-8?B?TFRsSDZjVE42dmcwMTFkcmlRNXN0NkwxbFdWeTJyQ1U5SlhnL3VIOTZoa0lz?=
 =?utf-8?B?dXlRL3JkZDk4cHFQQXNPY0JlMzZ4UUZUQlpiUzRHSXZZaHZSUys0NW1uWGN5?=
 =?utf-8?B?RHVoRmovUTBVTmVTaW5vaEdjMmRwYmdjVHMyaitIK2xoUmo0WWNXNENteEoy?=
 =?utf-8?B?WFJqWmk5VzZYWm5hY1NMaGMwRmxmekVUNFBKS1BZNkZrdjg3NVpwaEowcjdu?=
 =?utf-8?B?eE8xRWVUSFBoRVh4bG1YOUlQK29rT1NJZy9ZNG9DTThDeXoyU05GMSs3NEJy?=
 =?utf-8?B?UTRTb05QcmJXNDdEZ1plaEZqVnVLakwxWW9udFZUb0dGZDZ6T1hPQ1FBM1Vs?=
 =?utf-8?B?eW5Na0VEQVhWRmwybDl6N01Uby9reXF5Z1hYa1I0V1p2VUc1MGcvNnZEUUY5?=
 =?utf-8?B?YkpoOFJobGlCeldYREVwbXZFYUJuQm1rd1hTOTNlQTNhWDhhajZqWG9lOEpH?=
 =?utf-8?Q?ZLhRFUneG1jHx541+zYLsRe6MIjm6/Hr5HFdwWr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0689437-c995-4b45-805d-08d96eef7c5d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 15:28:31.3552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RE9lnmKwBKt00ucTsltftQ2cPDJ2awXMzrCD+IQM7/BTCG85rykorwGOGaOpdE8mK6fJ9Cpx3acwS5VvBWi1vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5232
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



On 9/3/2021 1:47 PM, Christian König wrote:
> Yeah, sounds logical to me as well. Feel free to stick my rb on that as 
> well.
> 
> Christian.
> 
> Am 03.09.21 um 10:13 schrieb Das, Nirmoy:
>> Hi Christian and Shashank,
>>
>>
>> Please review the v2 : https://patchwork.freedesktop.org/patch/452175/
>>
>> In v2, I am returning "PTR_ERR(ent)" instead of -EIO which I think 
>> makes more sense.

Agree, LGTM as well,
Reviewed-By: Shashank Sharma <shashank.sharma@amd.com>


Regards
Shashank

>>
>> Regards,
>> Nirmoy
>>
>> On 9/3/2021 9:53 AM, Christian König wrote:
>>> Am 02.09.21 um 13:44 schrieb Nirmoy Das:
>>>> debugfs APIs returns encoded error so use
>>>> IS_ERR for checking return value.
>>>>
>>>> References: https://gitlab.freedesktop.org/drm/amd/-/issues/1686
>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>
>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 ++----
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    | 2 +-
>>>>   2 files changed, 3 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> index d256215ab2c7..077f9baf74fe 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> @@ -1696,18 +1696,16 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>>> *adev)
>>>>       struct dentry *ent;
>>>>       int r, i;
>>>>   -
>>>> -
>>>>       ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>>>>                     &fops_ib_preempt);
>>>> -    if (!ent) {
>>>> +    if (IS_ERR(ent)) {
>>>>           DRM_ERROR("unable to create amdgpu_preempt_ib debugsfs 
>>>> file\n");
>>>>           return -EIO;
>>>>       }
>>>>         ent = debugfs_create_file("amdgpu_force_sclk", 0200, root, 
>>>> adev,
>>>>                     &fops_sclk_set);
>>>> -    if (!ent) {
>>>> +    if (IS_ERR(ent)) {
>>>>           DRM_ERROR("unable to create amdgpu_set_sclk debugsfs 
>>>> file\n");
>>>>           return -EIO;
>>>>       }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> index 7b634a1517f9..f40753e1a60d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> @@ -428,7 +428,7 @@ int amdgpu_debugfs_ring_init(struct 
>>>> amdgpu_device *adev,
>>>>       ent = debugfs_create_file(name,
>>>>                     S_IFREG | S_IRUGO, root,
>>>>                     ring, &amdgpu_debugfs_ring_fops);
>>>> -    if (!ent)
>>>> +    if (IS_ERR(ent))
>>>>           return -ENOMEM;
>>>>         i_size_write(ent->d_inode, ring->ring_size + 12);
>>>
> 
