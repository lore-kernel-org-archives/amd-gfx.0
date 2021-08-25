Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159E6C432BE
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 13:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D635660E93
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 13:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D635660E93
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8610B6E219;
	Wed, 25 Aug 2021 13:52:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 671C36E217
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 13:52:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqQP1riiNUEqJdQDbdy6c0hfNGYzDPiRU8rFSTs+tuTKQ3ZtBhnqlogsLnBU817e9aeHCzxiWnf5GjKCvuD6PjxgWhsPfL5hQm9xlnjXYZGrsMQknyj7T9uGvDfd69OW5dtbVLk2KOeMXowuUr39yPv7r2lL93M6l8NHYwf64YqQaOpHFQnEMvkJkE/BcICUR+cOjjQhEDjonIUsOsYW+WRSrzryyh9WFhR09aqAYcOr58aE2OFsHdscoCj2ObjdoO9OV71Ag9T0lmfCdUmKL7mPhTC4vKM9AGpaKefiQWWZjApTCnd7CFZiB/FW2hFGO1quo/YOx/TFK3Fd/Mp1wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a46s3Xy2qO8dHcTFyRYjQ9M67xT5Pkxph4t10ZIIyeY=;
 b=NG8udoA70EzWr48nhqg+jE9fgeX/nFlDM4cKOLT4jr/0mFuHv88Yk+b3xZyzj8hDo+ZlAnXOTrsqGkSeqzb5h6LL8nv8xUnViwvWhEDkDdq4qn28ACnMSsyzuJlWhf45QLyIgcFVbKYLB4lTYvpvVIQcYrsOFGuwh0JAx/UX/sIMQ36F1cvmUuj6tIitHAhmDa7sbuqSVM9VHIa0r6igZVB3ge1j/dGumiUYTrWvKIsAcDiiS2/bWPjGqgAId3JZxJYviFxp0goAiPV/oVDJDDDRtJWjhrePcB5+QRz+a8Ivc7ZgsbZvtYFydRzVx2XrGOe6fm/zwdAKwe5Hw3uQbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a46s3Xy2qO8dHcTFyRYjQ9M67xT5Pkxph4t10ZIIyeY=;
 b=bUdz1DMIvVPZ4waI5Mqke6snv2iSnbU9ENwOLzGpI79N0qkKo6AE65/lPKK0BdwREiM7XV3vkCI4y/tzxg8lwQDqnfSjQj1tba2YAYJNRzWMeTcqMHftOh2TJtxZpRhPOJ/jtVkasvCoorwyFWq9PhGrW69GcbemYIzVdCdrKXc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 13:52:42 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 13:52:42 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: rework context priority handling
To: "Das, Nirmoy" <nirmoy.das@amd.com>, "Lazar, Lijo" <lijo.lazar@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: satyajit.sahu@amd.com
References: <20210825112203.3806-1-nirmoy.das@amd.com>
 <bd435c95-4d7d-5b0e-b1c7-81ed4d883ff9@amd.com>
 <9f4562fe-2c83-a0fa-5564-618db6a33c7c@amd.com>
 <ca660b9e-e2c4-4c41-19c7-b68d05ffbe02@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <de5aedf5-0ec1-af9b-bd56-7f2a34d14e49@amd.com>
Date: Wed, 25 Aug 2021 15:52:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <ca660b9e-e2c4-4c41-19c7-b68d05ffbe02@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM9P195CA0015.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::20) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:de26:aaa6:84e1:c609]
 (2a02:908:1252:fb60:de26:aaa6:84e1:c609) by
 AM9P195CA0015.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Wed, 25 Aug 2021 13:52:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86f5faa7-ac1d-4c8b-cbd5-08d967cf9be9
X-MS-TrafficTypeDiagnostic: MN2PR12MB4360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43601BA1F54FDC8B35ACF2FC83C69@MN2PR12MB4360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vkIXwJBC9l7lq9l022Rwrc96qW6IJdE2xzA5WyopBzBxG7ZwnTEYc5bRgQv/Y+gD5OVcY7k3a0B3fmrjt5w+8uaQAE5RWTtrqeslywc/c8Xj5fa+m+Gme1YuiKb6Pfl1IgxC4uqIZP3IA5ezZwa6SC0ojjrbgtdOvv818DLlgxITFOjah0OLCP7Zvrp7Mfx3dUMMzMY4qBQEyQY+QAVHSLN07phzvAsXch28kZR4lCwtwozakDJ4B4SvIyOm6wD2o8cDsPBj3Bcdl/T80D38XRW8+G/uKN5/b3E2fvNStQ2QBGztXS7kc4CKWw7OD1LGyR4ti9R6Uor6/wlwSSuy4hStjVxjRW2M1zmEx6TaC8fuLPUW/a+A/qoa+yw6D7rrnc5OTsRqjg86epmdiOSId/zud0LWLz9KbLLRuKLQwalKySxzmjsArS0BtNd+e6U+zDJ3EFhXI/6nyzk8gEv/NkYjV9cvRoxiMHb+0OHy3kqABB9Qml2nBB1x8bqpxDcrOuM1r0pTT7krozAL7lYcLQomyDAU2ljJmB+M74SL6z5Q8JZTiajU3bjDgS7iqes8NxEFP7vJxtkGUoxvK7f/spyRkbMHXlKU+V4Gif5/Gf+jGeDsZCUADvAy6pk5xA9neqZF4lT0qCNYYljUxAZAHI59wIicayK9t7mBOq6vHbHleJ2p5X5gt/w2ahxg3APhgq17Qkw27Ao23HUpsluJd5yai7fj7a/JZkxyEA9ajvo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(5660300002)(8676002)(66476007)(66946007)(4326008)(2906002)(30864003)(8936002)(110136005)(83380400001)(31696002)(53546011)(38100700002)(6486002)(66556008)(36756003)(186003)(2616005)(478600001)(66574015)(31686004)(6666004)(316002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm5iTXR4SmRKSlFwcUdWK0VjaG5qSytrUWFUYkdPTFN0OHZkRm1LZ2grVG1D?=
 =?utf-8?B?cHd4cXZtV0RwWXR2d245RFBFZFV0N2NKaVRmUEEwejRxNEI4UnFiTy9qanAz?=
 =?utf-8?B?U2NYc1IxOUE5czFrd2VIQ2lTY1dkS3hlY09tTFpnanhHOHFPaEJyL0VDQkQ0?=
 =?utf-8?B?K1VkWWFqa0pES2ViZ3RoR0gxVXlESTU4OTFON3BMQ2ZyeXJZa0Q4UzNsam93?=
 =?utf-8?B?ZmVnNklCVzlvbUNYaVZnU1FyZ2xQaGFUQlNiOUhJajk2V0xPdUFUNFZNM0p1?=
 =?utf-8?B?QnF1aHNKMWlKZEIweXNaTVRvWlAvaGE2NFRFYk5SOUxSc0ZCRk8zalh2UlBr?=
 =?utf-8?B?S3dCSFZ2NitEblRwakJONEVoZ2tmdUF0VU5GVG1KUFBBZEhLb3BXa1ZBMFB0?=
 =?utf-8?B?OTNMaUtzcDVTMHlQTGs4R085bjg2azN2Z0hkakRkNFpuREdtM1NKNHZhU1Rz?=
 =?utf-8?B?bk1YeDBZRVU2NXcrSVkxNjBncXdzVG1aTWtTN3JzTk5tUWxVVG8yRG9jbnlS?=
 =?utf-8?B?TjQ2NU9xelMwL09pUDZsR1NQRVNyVHgvTDB1Yk9SVDRzYzVKQXhJNzlFMnBh?=
 =?utf-8?B?RXBONWdoZHovWXBIWEptdjBUdjNreTlUMnBwMzBtTkw4R21TVENIYUFPMnQz?=
 =?utf-8?B?dlJOUUp0aEVZQWt0NWhTOVBFc2N1Ym9iYUhjWGJHNjJKWUFobnBHekZhdSt2?=
 =?utf-8?B?TnB6cEtWbXcvY1FrNWZ0cjFsaHhPY01vU2ZjRDVaVUprbjhVSXpnckhOYk1i?=
 =?utf-8?B?TlNieHpnUDNuQmFFbURaeElRNHB1NmFSNHNaeGdpYk5ENFMzazlaNGs5aE9U?=
 =?utf-8?B?Y0ZNbWxzNThRTkdjdXV0ZW9GNmdxUkIybzBxRUpXRUhwTnRTczdlSHVJQTJY?=
 =?utf-8?B?MmMzVno2VkZYK0JKOVdkR25PcElONXFjakQxR0JWeHpvd2FmTjI5QThEWkhY?=
 =?utf-8?B?bm1kbituNGFoQ3hkRkZYQmxTVjhSS2QrbS8yclI5UFZ3QU1na0YyejR2eW1J?=
 =?utf-8?B?ejJpSDRPTW9sSC9HQlhva2k3V244cUQ1amtPb0hBUGg2WTI2V2lBeCsvWlVP?=
 =?utf-8?B?eTJ1SHlvSUF0Z1JaS283dnVXeFlzblBUOFN2c3FJVW5kM1Z6WGtjWXgzalM4?=
 =?utf-8?B?VDJBM2ZRK0h0M2RjMDdpYzBYOUY1SFJjQzJRazJxQmw2S2NFMDVJZnJMaXd6?=
 =?utf-8?B?eGxLK0wwMFFjbjFFYkhURXhocytnaU00T2x0eTBUM2hsTlF1cWJ1V3lvMEpT?=
 =?utf-8?B?M2hFaTAvbWdLcjI2SklqVkxzdWIyMFVsVEZHVmhucXAyQTAxV283TjRLRCtX?=
 =?utf-8?B?eE16MitNUjQ3TEduS1VLUkM2VzhPRVJrYVRLaFBDZzhVRXhTZDRENnNwa2dn?=
 =?utf-8?B?ait6YjJ0ZG9lQjBoQ2ptV0t2Tjc2VEVhMnI2dXZJVjVrbGE3cmtkYzlwdFNZ?=
 =?utf-8?B?VDBSVm56eDByQzhHOXA3MDdjNzNiTW9HVXlueDlNcFYwUU5yN2I4YVhEY1dp?=
 =?utf-8?B?NWxQbmd2UGl3dis1VjdyelVFSVI2KzBlYlpaR1NLcTJuV1JpZk9PQUxTMG1L?=
 =?utf-8?B?V1Z2TnNPaXBENnRvYWcvdXJ4ZEgyVTMwVC90TktqL1RST1JXODErd05nQzd4?=
 =?utf-8?B?VGZ4SWdYL3FFL0VJZlB3Q2IwbkY0TFJ6SWorUzFvWWFhSEwrcmlabTM4UnpL?=
 =?utf-8?B?VWFleEFqSFRtQW9NdnNsRkJVT0Z0ZzRiZnhucnF3cks5RXlxNGVxUnJGWDFm?=
 =?utf-8?B?Y0hsZVNQZmhzVFo0ajdrenVFTk8xMnlSZHNqZmdtZFM4MEFjeXNEdElIdlFG?=
 =?utf-8?B?OHpXdkI2SW11RzVzWk9RT1krZ05ZU0N4VmtxbmxsYkJNUVVQOVVreDRQelFV?=
 =?utf-8?Q?mDMeQWCP+NIaX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f5faa7-ac1d-4c8b-cbd5-08d967cf9be9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 13:52:42.3346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: idQhGAM5AyxlJ6uYe0/y0OHIPUKzQEVTc+U92knqpuInNdmUbtk9pspQFtBKyxv/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360
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



Am 25.08.21 um 15:35 schrieb Das, Nirmoy:
>
> On 8/25/2021 2:29 PM, Christian König wrote:
>> Am 25.08.21 um 14:20 schrieb Lazar, Lijo:
>>> On 8/25/2021 4:52 PM, Nirmoy Das wrote:
>>>> To get a hardware queue priority for a context, we are currently
>>>> mapping AMDGPU_CTX_PRIORITY_* to DRM_SCHED_PRIORITY_* and then
>>>> to hardware queue priority, which is not the right way to do that
>>>> as DRM_SCHED_PRIORITY_* is software scheduler's priority and it is
>>>> independent from a hardware queue priority.
>>>>
>>>> Use userspace provided context priority, AMDGPU_CTX_PRIORITY_* to
>>>> map a context to proper hardware queue priority.
>>>>
>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   | 127 
>>>> ++++++++++++++++------
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h   |   8 +-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c |  44 ++------
>>>>   3 files changed, 105 insertions(+), 74 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>>> index e7a010b7ca1f..c88c5c6c54a2 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>>> @@ -43,14 +43,61 @@ const unsigned int 
>>>> amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM] = {
>>>>       [AMDGPU_HW_IP_VCN_JPEG]    =    1,
>>>>   };
>>>>   +bool amdgpu_ctx_priority_is_valid(int32_t ctx_prio)
>>>> +{
>>>> +    switch (ctx_prio) {
>>>> +    case AMDGPU_CTX_PRIORITY_UNSET:
>>>> +    case AMDGPU_CTX_PRIORITY_VERY_LOW:
>>>> +    case AMDGPU_CTX_PRIORITY_LOW:
>>>> +    case AMDGPU_CTX_PRIORITY_NORMAL:
>>>> +    case AMDGPU_CTX_PRIORITY_HIGH:
>>>> +    case AMDGPU_CTX_PRIORITY_VERY_HIGH:
>>>> +        return true;
>>>> +    default:
>>>> +        return false;
>>>> +    }
>>>> +}
>>>> +
>>>> +static enum drm_sched_priority
>>>> +amdgpu_ctx_to_drm_sched_prio(int32_t ctx_prio)
>>>> +{
>>>> +    switch (ctx_prio) {
>>>> +    case AMDGPU_CTX_PRIORITY_UNSET:
>>>> +        return DRM_SCHED_PRIORITY_UNSET;
>>>> +
>>>> +    case AMDGPU_CTX_PRIORITY_VERY_LOW:
>>>> +        return DRM_SCHED_PRIORITY_MIN;
>>>> +
>>>> +    case AMDGPU_CTX_PRIORITY_LOW:
>>>> +        return DRM_SCHED_PRIORITY_MIN;
>>>> +
>>>> +    case AMDGPU_CTX_PRIORITY_NORMAL:
>>>> +        return DRM_SCHED_PRIORITY_NORMAL;
>>>> +
>>>> +    case AMDGPU_CTX_PRIORITY_HIGH:
>>>> +        return DRM_SCHED_PRIORITY_HIGH;
>>>> +
>>>> +    case AMDGPU_CTX_PRIORITY_VERY_HIGH:
>>>> +        return DRM_SCHED_PRIORITY_HIGH;
>>>> +
>>>> +    /* This should not happen as we sanitized userspace provided 
>>>> priority
>>>> +     * already, WARN if this happens.
>>>> +     */
>>>> +    default:
>>>> +        WARN(1, "Invalid context priority %d\n", ctx_prio);
>>>> +        return DRM_SCHED_PRIORITY_NORMAL;
>>>> +    }
>>>> +
>>>> +}
>>>> +
>>>>   static int amdgpu_ctx_priority_permit(struct drm_file *filp,
>>>> -                      enum drm_sched_priority priority)
>>>> +                      int32_t priority)
>>>>   {
>>>> -    if (priority < 0 || priority >= DRM_SCHED_PRIORITY_COUNT)
>>>> +    if (!amdgpu_ctx_priority_is_valid(priority))
>>>>           return -EINVAL;
>>>>         /* NORMAL and below are accessible by everyone */
>>>> -    if (priority <= DRM_SCHED_PRIORITY_NORMAL)
>>>> +    if (priority <= AMDGPU_CTX_PRIORITY_NORMAL)
>>>>           return 0;
>>>>         if (capable(CAP_SYS_NICE))
>>>> @@ -62,26 +109,35 @@ static int amdgpu_ctx_priority_permit(struct 
>>>> drm_file *filp,
>>>>       return -EACCES;
>>>>   }
>>>>   -static enum gfx_pipe_priority 
>>>> amdgpu_ctx_sched_prio_to_compute_prio(enum drm_sched_priority prio)
>>>> +static enum gfx_pipe_priority 
>>>> amdgpu_ctx_prio_to_compute_prio(int32_t prio)
>>>>   {
>>>>       switch (prio) {
>>>> -    case DRM_SCHED_PRIORITY_HIGH:
>>>> -    case DRM_SCHED_PRIORITY_KERNEL:
>>>> +    case AMDGPU_CTX_PRIORITY_HIGH:
>>>> +    case AMDGPU_CTX_PRIORITY_VERY_HIGH:
>>>>           return AMDGPU_GFX_PIPE_PRIO_HIGH;
>>>>       default:
>>>>           return AMDGPU_GFX_PIPE_PRIO_NORMAL;
>>>>       }
>>>>   }
>>>>   -static unsigned int amdgpu_ctx_prio_sched_to_hw(struct 
>>>> amdgpu_device *adev,
>>>> -                         enum drm_sched_priority prio,
>>>> -                         u32 hw_ip)
>>>> +static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, 
>>>> u32 hw_ip)
>>>>   {
>>>> +    struct amdgpu_device *adev = ctx->adev;
>>>> +    int32_t ctx_prio;
>>>>       unsigned int hw_prio;
>>>>   -    hw_prio = (hw_ip == AMDGPU_HW_IP_COMPUTE) ?
>>>> -            amdgpu_ctx_sched_prio_to_compute_prio(prio) :
>>>> -            AMDGPU_RING_PRIO_DEFAULT;
>>>> +    ctx_prio = (ctx->override_priority == 
>>>> AMDGPU_CTX_PRIORITY_UNSET) ?
>>>> +            ctx->init_priority : ctx->override_priority;
>>>> +
>>>> +    switch (hw_ip) {
>>>> +    case AMDGPU_HW_IP_COMPUTE:
>>>> +        hw_prio = amdgpu_ctx_prio_to_compute_prio(ctx_prio);
>>>> +        break;
>>>> +    default:
>>>> +        hw_prio = AMDGPU_RING_PRIO_DEFAULT;
>>>> +        break;
>>>> +    }
>>>> +
>>>>       hw_ip = array_index_nospec(hw_ip, AMDGPU_HW_IP_NUM);
>>>>       if (adev->gpu_sched[hw_ip][hw_prio].num_scheds == 0)
>>>>           hw_prio = AMDGPU_RING_PRIO_DEFAULT;
>>>> @@ -89,15 +145,17 @@ static unsigned int 
>>>> amdgpu_ctx_prio_sched_to_hw(struct amdgpu_device *adev,
>>>>       return hw_prio;
>>>>   }
>>>>   +
>>>>   static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>>>> -                   const u32 ring)
>>>> +                  const u32 ring)
>>>>   {
>>>>       struct amdgpu_device *adev = ctx->adev;
>>>>       struct amdgpu_ctx_entity *entity;
>>>>       struct drm_gpu_scheduler **scheds = NULL, *sched = NULL;
>>>>       unsigned num_scheds = 0;
>>>> +    int32_t ctx_prio;
>>>>       unsigned int hw_prio;
>>>> -    enum drm_sched_priority priority;
>>>> +    enum drm_sched_priority drm_prio;
>>>>       int r;
>>>>         entity = kzalloc(struct_size(entity, fences, 
>>>> amdgpu_sched_jobs),
>>>> @@ -105,10 +163,11 @@ static int amdgpu_ctx_init_entity(struct 
>>>> amdgpu_ctx *ctx, u32 hw_ip,
>>>>       if (!entity)
>>>>           return  -ENOMEM;
>>>>   +    ctx_prio = (ctx->override_priority == 
>>>> AMDGPU_CTX_PRIORITY_UNSET) ?
>>>> +            ctx->init_priority : ctx->override_priority;
>>>>       entity->sequence = 1;
>>>> -    priority = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
>>>> -                ctx->init_priority : ctx->override_priority;
>>>> -    hw_prio = amdgpu_ctx_prio_sched_to_hw(adev, priority, hw_ip);
>>>> +    hw_prio = amdgpu_ctx_get_hw_prio(ctx, hw_ip);
>>>> +    drm_prio = amdgpu_ctx_to_drm_sched_prio(ctx_prio);
>>>>         hw_ip = array_index_nospec(hw_ip, AMDGPU_HW_IP_NUM);
>>>>       scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
>>>> @@ -124,7 +183,7 @@ static int amdgpu_ctx_init_entity(struct 
>>>> amdgpu_ctx *ctx, u32 hw_ip,
>>>>           num_scheds = 1;
>>>>       }
>>>>   -    r = drm_sched_entity_init(&entity->entity, priority, scheds, 
>>>> num_scheds,
>>>> +    r = drm_sched_entity_init(&entity->entity, drm_prio, scheds, 
>>>> num_scheds,
>>>>                     &ctx->guilty);
>>>>       if (r)
>>>>           goto error_free_entity;
>>>> @@ -139,7 +198,7 @@ static int amdgpu_ctx_init_entity(struct 
>>>> amdgpu_ctx *ctx, u32 hw_ip,
>>>>   }
>>>>     static int amdgpu_ctx_init(struct amdgpu_device *adev,
>>>> -               enum drm_sched_priority priority,
>>>> +               int32_t priority,
>>>>                  struct drm_file *filp,
>>>>                  struct amdgpu_ctx *ctx)
>>>>   {
>>>> @@ -161,7 +220,7 @@ static int amdgpu_ctx_init(struct amdgpu_device 
>>>> *adev,
>>>>       ctx->reset_counter_query = ctx->reset_counter;
>>>>       ctx->vram_lost_counter = atomic_read(&adev->vram_lost_counter);
>>>>       ctx->init_priority = priority;
>>>> -    ctx->override_priority = DRM_SCHED_PRIORITY_UNSET;
>>>> +    ctx->override_priority = AMDGPU_CTX_PRIORITY_UNSET;
>>>>         return 0;
>>>>   }
>>>> @@ -234,7 +293,7 @@ int amdgpu_ctx_get_entity(struct amdgpu_ctx 
>>>> *ctx, u32 hw_ip, u32 instance,
>>>>   static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
>>>>                   struct amdgpu_fpriv *fpriv,
>>>>                   struct drm_file *filp,
>>>> -                enum drm_sched_priority priority,
>>>> +                int32_t priority,
>>>>                   uint32_t *id)
>>>>   {
>>>>       struct amdgpu_ctx_mgr *mgr = &fpriv->ctx_mgr;
>>>> @@ -397,19 +456,19 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, 
>>>> void *data,
>>>>   {
>>>>       int r;
>>>>       uint32_t id;
>>>> -    enum drm_sched_priority priority;
>>>> +    int32_t priority;
>>>>         union drm_amdgpu_ctx *args = data;
>>>>       struct amdgpu_device *adev = drm_to_adev(dev);
>>>>       struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>>>         id = args->in.ctx_id;
>>>> -    r = amdgpu_to_sched_priority(args->in.priority, &priority);
>>>> +    priority = args->in.priority;
>>>>         /* For backwards compatibility reasons, we need to accept
>>>>        * ioctls with garbage in the priority field */
>>>> -    if (r == -EINVAL)
>>>> -        priority = DRM_SCHED_PRIORITY_NORMAL;
>>>> +    if (!amdgpu_ctx_priority_is_valid(priority))
>>>> +        priority = AMDGPU_CTX_PRIORITY_NORMAL;
>>>>         switch (args->in.op) {
>>>>       case AMDGPU_CTX_OP_ALLOC_CTX:
>>>> @@ -515,9 +574,9 @@ struct dma_fence *amdgpu_ctx_get_fence(struct 
>>>> amdgpu_ctx *ctx,
>>>>   }
>>>>     static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
>>>> -                        struct amdgpu_ctx_entity *aentity,
>>>> -                        int hw_ip,
>>>> -                        enum drm_sched_priority priority)
>>>> +                       struct amdgpu_ctx_entity *aentity,
>>>> +                       int hw_ip,
>>>> +                       int32_t priority)
>>>>   {
>>>>       struct amdgpu_device *adev = ctx->adev;
>>>>       unsigned int hw_prio;
>>>> @@ -525,12 +584,12 @@ static void 
>>>> amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
>>>>       unsigned num_scheds;
>>>>         /* set sw priority */
>>>> -    drm_sched_entity_set_priority(&aentity->entity, priority);
>>>> +    drm_sched_entity_set_priority(&aentity->entity,
>>>> + amdgpu_ctx_to_drm_sched_prio(priority));
>>>>         /* set hw priority */
>>>>       if (hw_ip == AMDGPU_HW_IP_COMPUTE) {
>>>> -        hw_prio = amdgpu_ctx_prio_sched_to_hw(adev, priority,
>>>> -                              AMDGPU_HW_IP_COMPUTE);
>>>> +        hw_prio = amdgpu_ctx_get_hw_prio(ctx, hw_ip);
>>>>           hw_prio = array_index_nospec(hw_prio, AMDGPU_RING_PRIO_MAX);
>>>
>>> Not related to this patch, but this kind of logic may break some 
>>> day. There is a HWIP specific priority and there is another 
>>> RING_PRIO which is unmapped to HWIP priority Ex: when a new priority 
>>> is added for VCN which is higher than any of the existing priorities.
>>
>> Yes, that's something I've noticed as well.
>>
>> Either we should leave the exact mapping to the engine or have a 
>> global definition of possible hw priorities (the later is preferable 
>> I think).
>
>
> Will  this be sufficient :
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index d43fe2ed8116..937320293029 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -43,9 +43,9 @@
>  #define AMDGPU_MAX_COMPUTE_QUEUES KGD_MAX_QUEUES
>
>  enum gfx_pipe_priority {
> -       AMDGPU_GFX_PIPE_PRIO_NORMAL = 1,
> -       AMDGPU_GFX_PIPE_PRIO_HIGH,
> -       AMDGPU_GFX_PIPE_PRIO_MAX
> +       AMDGPU_GFX_PIPE_PRIO_NORMAL = AMDGPU_RING_PRIO_1,
> +       AMDGPU_GFX_PIPE_PRIO_HIGH = AMDGPU_RING_PRIO_2,
> +       AMDGPU_GFX_PIPE_PRIO_MAX = AMDGPU_RING_PRIO_3
>  };
>
>  /* Argument for PPSMC_MSG_GpuChangeState */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index e713d31619fe..c54539faf209 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -37,7 +37,14 @@
>  #define AMDGPU_MAX_UVD_ENC_RINGS       2
>
>  #define AMDGPU_RING_PRIO_DEFAULT       1

You should probably move the default value into the enum as well but 
apart from that looks good to me.

Christian.

> -#define AMDGPU_RING_PRIO_MAX           AMDGPU_GFX_PIPE_PRIO_MAX
> +
> +enum amdgpu_ring_priority_level {
> +       AMDGPU_RING_PRIO_0,
> +       AMDGPU_RING_PRIO_1,
> +       AMDGPU_RING_PRIO_2,
> +       AMDGPU_RING_PRIO_3,
> +       AMDGPU_RING_PRIO_MAX
>
> +};
>
>
> Regards,
>
> Nirmoy
>
>>
>> Christian.
>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>>           scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
>>>>           num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;
>>>> @@ -540,14 +599,14 @@ static void 
>>>> amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
>>>>   }
>>>>     void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
>>>> -                  enum drm_sched_priority priority)
>>>> +                  int32_t priority)
>>>>   {
>>>> -    enum drm_sched_priority ctx_prio;
>>>> +    int32_t ctx_prio;
>>>>       unsigned i, j;
>>>>         ctx->override_priority = priority;
>>>>   -    ctx_prio = (ctx->override_priority == 
>>>> DRM_SCHED_PRIORITY_UNSET) ?
>>>> +    ctx_prio = (ctx->override_priority == 
>>>> AMDGPU_CTX_PRIORITY_UNSET) ?
>>>>               ctx->init_priority : ctx->override_priority;
>>>>       for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
>>>>           for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>>> index 14db16bc3322..a44b8b8ed39c 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>>> @@ -47,8 +47,8 @@ struct amdgpu_ctx {
>>>>       spinlock_t            ring_lock;
>>>>       struct amdgpu_ctx_entity 
>>>> *entities[AMDGPU_HW_IP_NUM][AMDGPU_MAX_ENTITY_NUM];
>>>>       bool                preamble_presented;
>>>> -    enum drm_sched_priority        init_priority;
>>>> -    enum drm_sched_priority        override_priority;
>>>> +    int32_t                init_priority;
>>>> +    int32_t                override_priority;
>>>>       struct mutex            lock;
>>>>       atomic_t            guilty;
>>>>       unsigned long            ras_counter_ce;
>>>> @@ -75,8 +75,8 @@ void amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
>>>>   struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
>>>>                          struct drm_sched_entity *entity,
>>>>                          uint64_t seq);
>>>> -void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
>>>> -                  enum drm_sched_priority priority);
>>>> +bool amdgpu_ctx_priority_is_valid(int32_t ctx_prio);
>>>> +void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx, int32_t 
>>>> ctx_prio);
>>>>     int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
>>>>                struct drm_file *filp);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>>>> index b7d861ed5284..e9b45089a28a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>>>> @@ -32,37 +32,9 @@
>>>>   #include "amdgpu_sched.h"
>>>>   #include "amdgpu_vm.h"
>>>>   -int amdgpu_to_sched_priority(int amdgpu_priority,
>>>> -                 enum drm_sched_priority *prio)
>>>> -{
>>>> -    switch (amdgpu_priority) {
>>>> -    case AMDGPU_CTX_PRIORITY_VERY_HIGH:
>>>> -        *prio = DRM_SCHED_PRIORITY_HIGH;
>>>> -        break;
>>>> -    case AMDGPU_CTX_PRIORITY_HIGH:
>>>> -        *prio = DRM_SCHED_PRIORITY_HIGH;
>>>> -        break;
>>>> -    case AMDGPU_CTX_PRIORITY_NORMAL:
>>>> -        *prio = DRM_SCHED_PRIORITY_NORMAL;
>>>> -        break;
>>>> -    case AMDGPU_CTX_PRIORITY_LOW:
>>>> -    case AMDGPU_CTX_PRIORITY_VERY_LOW:
>>>> -        *prio = DRM_SCHED_PRIORITY_MIN;
>>>> -        break;
>>>> -    case AMDGPU_CTX_PRIORITY_UNSET:
>>>> -        *prio = DRM_SCHED_PRIORITY_UNSET;
>>>> -        break;
>>>> -    default:
>>>> -        WARN(1, "Invalid context priority %d\n", amdgpu_priority);
>>>> -        return -EINVAL;
>>>> -    }
>>>> -
>>>> -    return 0;
>>>> -}
>>>> -
>>>>   static int amdgpu_sched_process_priority_override(struct 
>>>> amdgpu_device *adev,
>>>>                             int fd,
>>>> -                          enum drm_sched_priority priority)
>>>> +                          int32_t priority)
>>>>   {
>>>>       struct fd f = fdget(fd);
>>>>       struct amdgpu_fpriv *fpriv;
>>>> @@ -89,7 +61,7 @@ static int 
>>>> amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
>>>>   static int amdgpu_sched_context_priority_override(struct 
>>>> amdgpu_device *adev,
>>>>                             int fd,
>>>>                             unsigned ctx_id,
>>>> -                          enum drm_sched_priority priority)
>>>> +                          int32_t priority)
>>>>   {
>>>>       struct fd f = fdget(fd);
>>>>       struct amdgpu_fpriv *fpriv;
>>>> @@ -124,7 +96,6 @@ int amdgpu_sched_ioctl(struct drm_device *dev, 
>>>> void *data,
>>>>   {
>>>>       union drm_amdgpu_sched *args = data;
>>>>       struct amdgpu_device *adev = drm_to_adev(dev);
>>>> -    enum drm_sched_priority priority;
>>>>       int r;
>>>>         /* First check the op, then the op's argument.
>>>> @@ -138,21 +109,22 @@ int amdgpu_sched_ioctl(struct drm_device 
>>>> *dev, void *data,
>>>>           return -EINVAL;
>>>>       }
>>>>   -    r = amdgpu_to_sched_priority(args->in.priority, &priority);
>>>> -    if (r)
>>>> -        return r;
>>>> +    if (!amdgpu_ctx_priority_is_valid(args->in.priority)) {
>>>> +        WARN(1, "Invalid context priority %d\n", args->in.priority);
>>>> +        return -EINVAL;
>>>> +    }
>>>>         switch (args->in.op) {
>>>>       case AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE:
>>>>           r = amdgpu_sched_process_priority_override(adev,
>>>>                                  args->in.fd,
>>>> -                               priority);
>>>> +                               args->in.priority);
>>>>           break;
>>>>       case AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE:
>>>>           r = amdgpu_sched_context_priority_override(adev,
>>>>                                  args->in.fd,
>>>>                                  args->in.ctx_id,
>>>> -                               priority);
>>>> +                               args->in.priority);
>>>>           break;
>>>>       default:
>>>>           /* Impossible.
>>>>
>>

