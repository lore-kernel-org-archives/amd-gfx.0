Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EB2C7EE26
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 09:06:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3242C10E288;
	Mon, 22 May 2023 09:06:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AF1810E288
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 09:06:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQDC87yJLo2ZAVvF+1rQF0pm7277ZWVch+/XOyPM80EX0iJpvhO/aGocN6Lg4aTqrHYxRzbHekoypXlXLNTB1mEFVkS9dn/GIfLFcNlrGIaPO1z4RiM+/ImzX7yO270bjL1xIx9+bz3DogjOJ/lBkPdzRWDvCdyK9ljL0j1OQ8iuQWDZoNJSHsqhNjo+3U8Exatj5SMFWvdeVcao1Wc4GWYTkiqBuSwHAnxFk/Zd05bzb+92jpz+ugiTUQ6PfYmamNMSrcf6a84GxEP4kfgGCqszxuBXXXqDf+21AjKpZXZ5yIJ2bxrvSUUoJ/xd0gqA6B1CLxwOU+i33P2AsHI2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/19WIlvFKVp0gjob9YAZxobGWFwic6ju7wh5jEOIj0c=;
 b=UN9s3ovDH4C/3nsLvQFAHK3DI00o9GlPUrDbc7OPMZk9VT5sPqwzEL3ivWB5T3BjewRKM9gM60uw+UiFOxsOJBS5HHOngfjzAtPv7HSMN2x3LTmGDRWHtUQpHxdcFB6zk1GtX7BxCaJC3S7c19R+VpcHLlxbbLBIQ1zwOaav0v3NM5/rGoBmOReawjdzPaDmouchC3T97VMnGDsOAKhptvU+6H3HprCkaFKdYaGq3JfixnIFwesZbH5SWGQVqqPFczkf9Ku++dxJckGkDfgePEMYJwyBHS78xrFJWEEWDC5JnSoTsMbwUx3VfEi8vnXwTgZT6qBcO5Ce6unVb+Ukww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/19WIlvFKVp0gjob9YAZxobGWFwic6ju7wh5jEOIj0c=;
 b=ikT3pix8/BSWJ4b1xNsYiJtUJVGTjhwzGbKCDjGEUhzBVdDxuX9Izkf4lYNyb5Sq1H3HeNWMsnPPGjhZT/NH/vETi+WUyDlP6U5SJeTuEsQfoKde5fZQSsaVwf+gIAhfmoSN2OG/QviZXX2wvxyt/KjfXwB2CezR7tlMFH+nk+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 09:06:36 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 09:06:36 +0000
Message-ID: <b71264c0-6ae6-0310-82d0-3d5c486d5deb@amd.com>
Date: Mon, 22 May 2023 11:06:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 06/10] drm/amdgpu: set FW parameters in v11_struct
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-7-shashank.sharma@amd.com>
 <CADnq5_Ncu2zSiJqLOu5h63c77AwO3rMGe5=3w3thEGjtYfFBaw@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_Ncu2zSiJqLOu5h63c77AwO3rMGe5=3w3thEGjtYfFBaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:79::7) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 964fbd18-cf30-43cf-6478-08db5aa3d828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FgoROUtPTU+6SlYr2eawFbKKveIEwpanCZx7W6cegiFU4/irA5yu/qTMKJo3LJtOj18FNZUm5o2yinDuK4oVt7x/eNXyytx8mcGmuy4f6dnVNELyflPXvw4XfDFXf35F7fQIoIp635au9sucnIAReU+Cs1fF6jLIMmgJ4hDwvFQV+WFhmTPD11SE6+1z4VBkZLQPecU+pJrOY5jxrkFWKbWpbyTmNtXDe6l2bTBXo4mCVlZHxMxA+XHAMM8/oRvjFn38VlXWTQzGWJVoew6raiQRL5CUmXgel2jZP8Sa3DSQEdSTUCwSo8Op5mGTDC39XddYkGNfX/9QDPZWSzNMZpVpTjacZfXW3ps0KlH57xr0UrVxDHTxXhPixHudJjUIRapNZnw0sGlF7GOkgnOpdrvV8Nl6PXcG9brN5mPeQXTp5IEOrB7e5CZ0zrx4c1tanFAKXgbQISwgJbzfpumIzJI6MIsIdOGxWnDmCSdd0yFU/xEL8ZeTLwDy8r8zakrT6Qc3JHaiXploGqBLe1XhIy/XMExLk/Huj0btA4YV+LJ/x9K0l43MwqtSXITjtaQJ3ZsnOa63OrzJKodrjqZQ0i1eWXDW341h11sWd9hTUSCn8E4aeArhORp5V7sj1YiAW+qXgLR+XlEoUVixkgUSBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199021)(2616005)(83380400001)(186003)(2906002)(6916009)(4326008)(66476007)(66946007)(66556008)(41300700001)(6486002)(316002)(6666004)(54906003)(478600001)(53546011)(5660300002)(44832011)(26005)(6506007)(6512007)(8676002)(8936002)(31696002)(38100700002)(86362001)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek5taThTYUQzN3kzMEI3MHovMGdqdFdpMThvcVBhempxN0RzenFOVlVyZEtr?=
 =?utf-8?B?bTJzTElGektpYXNFN0pDbEEzWHRQbjUyb2dzRlZVMlo1M3pyczVvdzMxdlBT?=
 =?utf-8?B?Mk9NaGZnYjZZYytSQUp6UVl4SnljV2FJaGdHRERXcmZEcElhYzVMQzZ1ZzZm?=
 =?utf-8?B?RTAzVm9vS3g4dEFKYnZlQm5Vb3p6QTRQbFpVdWlRRnNRR0pNVEErK2hxcTJq?=
 =?utf-8?B?aERxa2VnTUM5RmpkOGdpRVQ2Qlcrb3ROMXdhZDFKOXN4RDQvM1JPZ3d1V3kv?=
 =?utf-8?B?MlM5K2VMUzdCc2JZWGxkMXpRR2l4aVl3S25KK3h5Y1MxYWdhV0JFWlhkdjF0?=
 =?utf-8?B?S2d2MTJBYUcrbUxvbHBOUUw5dDN0RDJEd1EvQ05sS3Jjd1greU14N0lWMkxk?=
 =?utf-8?B?K1grV0tSMC9Qam9ESG1GZjNRVE5lTjFnOFdQZWpFQXlGVTZpUStrL1htWDds?=
 =?utf-8?B?ZnVsM01UVURXN0lROW8raVZxSW82MTdNT1pMZW5PSE1oNE1GRm4reVpkVi9S?=
 =?utf-8?B?OFYyWllUZ1NiQUk1RE1kekpFV3kvSmtKdWVZN0tOb2ozTWVFMGdhN1dUTFNy?=
 =?utf-8?B?SWdnQWJvd2ZWbHArTkJRS0RlSy8xdzg2ZUVVWUliZ0VPYkhwSHlKYWVUTTQ0?=
 =?utf-8?B?eENndUxUNFlSL3pWMGxFMG9qQUlnYkwvVlZPRDN3WUNWTlZRSVY4R1VWcFUx?=
 =?utf-8?B?ckVJWDFIS0tmRzl2NmZqSG5kVTUzTzhVRW9SZVlNT3dTaldSaE1zV2ZUb29M?=
 =?utf-8?B?bmNNQXcxRUNvdDk5Q0Y1V29FS2laeUxaYUhSTmVnUG05WVVBVXVIb1RUa0g3?=
 =?utf-8?B?dGVOMUIyL3hlZllLRTl2Z1VQS3RqeDFwZWM4ZHdxamIxcm5LeWJxMTRxYUxa?=
 =?utf-8?B?NGJtQmVUS295eXczZVpaa2V6REFMM1NEa1FneWpoSkl5VEpzeEVNbldlNDRu?=
 =?utf-8?B?WnM1TkJJVzlyVzRWWHVvOGY5Y3JqL2dYQzc3Mm5zbkpsOHVhbktsTVhaMjBv?=
 =?utf-8?B?Ui9rUHlCS2xyZTJWZlRjR3NLZkFEMEp0RHpxcWVIWmNobVVUQTJOcUhMN3dy?=
 =?utf-8?B?YlI1amcxWWU2b3JRY3ZzWkpYS2xJUVo2RzVXTCtrdWsxc1JFdzZZUG9DQXlZ?=
 =?utf-8?B?RG1BWlc2c1FWTFdlSGpuOERJcUwyenZJTkJYSVFRRGlXRFJVeWhnR1pHeW93?=
 =?utf-8?B?UTkzK3NKWTh6QmUzNDYzeTdLNjFJbXVkS1RlK0c3a0tiMUNrVWxrRktBRDlG?=
 =?utf-8?B?eFAzdFJCTDVhQm1ZbGcvR3NKSmQ0VW13VW10clJnOURYK3p6NFNQRmRzWm1o?=
 =?utf-8?B?ekZQbTVGdElSWk5TM1dWNlFKc2YwOVRiSXYvbzBad0srQmcvQjVrMVRKSDlF?=
 =?utf-8?B?eEg2Nng1T1o3aGtZN0RDaktKMitTVUFYbVp6SkhoWHJjeEhxNTNwUzhyekpo?=
 =?utf-8?B?RngvZzk0RzZrUXBFOUdqTlNBTjYzck5Jc2xEZ0l2emUvMVBFZ05BZW95WXJu?=
 =?utf-8?B?bmJHYUc0TlJGUXY4OFdVcWNRMTBhS0creEZxUVZZUUJ2SlUxVVNaOUZLeWdV?=
 =?utf-8?B?clZzQkhLS1M5Rk9vRFJBcW9CeEh2NVN4Q21PY3RyYWdiN29VN1BybFdaeVV4?=
 =?utf-8?B?b3JrNU5BR0hnY04rSkdpRnhaSWJSSjJzUTV3clE5WFNraTdUaE1tYmVXaWdU?=
 =?utf-8?B?NEZkZ01rY0NjcmxkM3FSekxJK1AxdC9FUzIrOTM5QVUyK0hiamZ1RFFqY1RN?=
 =?utf-8?B?VTZ0OGh6NVBuOTBBVFkxWERSRGNVclRPSWxoZ09tUkVZb0phVXZhbDN6U3hh?=
 =?utf-8?B?bEVWb0ROa0FhZm9qTE5FTjNDU1FpcmRVNFZMOTJFUS9Ed05LWHFEY1gvdWtu?=
 =?utf-8?B?L01BMXpOanhzb0pnL0dTRDlZYTF0VGRlYzVaNy9tcVZNdDlTelhvM2NGMWNr?=
 =?utf-8?B?RkY0Wm9HUDQraXhqVFhMem9hN09TZ2JjeW0xQXlDTkxSRGc0VThyZ1FMUjJ0?=
 =?utf-8?B?UEhvY2k0bHhpdTYyMTFsendUM0p2NjBMNjZwa1k3UFh2NENLM1NkQmhETVhm?=
 =?utf-8?B?clpZU244TTQrd252bE85YndXUjlsQnoxcW4zRS9DRmgrcFpSM25YZmpkSm9p?=
 =?utf-8?Q?xwI4KDEl4jLXv4rg8QGW8Nwni?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964fbd18-cf30-43cf-6478-08db5aa3d828
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 09:06:35.9125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ya+I5PkaWc5iZHhHTm3ILMK2uTfktTUjllSpSOgjjVs9rwYWAe10wTEDGFqqsTSlpWpBtry3DdKYLHRbJAcXJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690
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
Cc: pierre-eric.pelloux-prayer@amd.com, arvind.yadav@amd.com,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 19/05/2023 23:22, Alex Deucher wrote:
> On Mon, Apr 24, 2023 at 1:39 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>> From: Arvind Yadav <arvind.yadav@amd.com>
>>
>> This patch sets new parameters defined in v11_struct for
>> usermode queue with the respective allocated gpu context
>> space addresses.
>>
>> V4: Split the patch into two parts, keep only the set parameter
>>      part in this series (Alex).
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Cc: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index f6b33faea86f..86de35292f69 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -6411,6 +6411,21 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
>>          .funcs = &gfx_v11_0_ip_funcs,
>>   };
>>
>> +static void gfx_v11_userq_set_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>
> gfx_v11_0_ for consistency.
>
> Alex

Noted,

Shashank

>> +                                       struct amdgpu_usermode_queue *queue)
>> +{
>> +       struct v11_gfx_mqd *mqd = queue->mqd.cpu_ptr;
>> +
>> +       mqd->shadow_base_lo = queue->shadow_ctx_gpu_addr & 0xfffffffc;
>> +       mqd->shadow_base_hi = upper_32_bits(queue->shadow_ctx_gpu_addr);
>> +
>> +       mqd->gds_bkup_base_lo = queue->gds_ctx_gpu_addr & 0xfffffffc;
>> +       mqd->gds_bkup_base_hi = upper_32_bits(queue->gds_ctx_gpu_addr);
>> +
>> +       mqd->fw_work_area_base_lo = queue->fw_ctx_gpu_addr & 0xfffffffc;
>> +       mqd->fw_work_area_base_lo = upper_32_bits(queue->fw_ctx_gpu_addr);
>> +}
>> +
>>   static int gfx_v11_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>>                                            struct amdgpu_usermode_queue *queue)
>>   {
>> @@ -6484,12 +6499,14 @@ gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode
>>          queue->userq_prop.use_doorbell = true;
>>          queue->userq_prop.mqd_gpu_addr = mqd->gpu_addr;
>>          r = gfx_v11_mqd->init_mqd(adev, (void *)mqd->cpu_ptr, &queue->userq_prop);
>> -       amdgpu_bo_unreserve(mqd->obj);
>>          if (r) {
>> +               amdgpu_bo_unreserve(mqd->obj);
>>                  DRM_ERROR("Failed to init MQD for queue\n");
>>                  goto free_ctx;
>>          }
>>
>> +       gfx_v11_userq_set_ctx_space(uq_mgr, queue);
>> +       amdgpu_bo_unreserve(mqd->obj);
>>          DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>>          return 0;
>>
>> --
>> 2.40.0
>>
