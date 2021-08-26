Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D754C4320A
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 08:49:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6A1A61073
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 08:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D6A1A61073
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F15F6E55E;
	Thu, 26 Aug 2021 08:49:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 278016E55E
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 08:49:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FX3tOO5IDVEBj7L2HPChTBZgbACR3v8l4Rn2zmrKfJv+jBZX95qipsZGn35OqgY0rAvtoLf9hzHNtvzF4F/UEnTSLzJXay8a//14FWSth1x/DYcoirq7cSOIo+ghaNvN4nuObP4dENxGeGN0cikaMvawqd7ey2RZwRJjlxOK+cYeqsrFX0FM9TxRuxQQMeJuTJf25S3aoWSci77adBULPgVWYI7EvHLVQS02ZRu8sBzugV1xOyJYFM+iQXMQbVKqDHCmpLIm6VUfeXqGLV9xgNyxrW/MuAQohrlL8HSCsYC/xzzLfopjXbMu3j0cwY6uA+pN75fi3bkcyZMnQ6zztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2QSeL21rkDQ+ZFki59k4gjXV/EMQamxovlHFb0Ljo4=;
 b=FcaTA4k+2vvOuz48sAXUen1r6YwMUnleV6ezoGlUPasqwpQRhgdUl7VMRuEJ23TkCVx1arHV9CHsI0CG2kKh1kq8xIezbtyY9sjBzjSVEbkpp3DGXtSWryJFT85opYMzrnl31fgBoQojbpoLXF8maQhrLGJqiGlITu962lOFIq6yAh+66pHLSdBOwBjeF8hlniVnNjQ+2BjZ+N5HT286jjhJFA/WHZwqcJ27I43g6W59kGUHFzMnDF5NRJufqSgDuK+6XYTrZVj3RFRi61WfsS+e6moLLx+5azLAFe3U64vgi4Vs5AwUMRHvcTHRlEMGMhkTir4Qb2CuJc8Du0ox9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2QSeL21rkDQ+ZFki59k4gjXV/EMQamxovlHFb0Ljo4=;
 b=zMvgkWcu4aj8vvZx52DOWlQq/d3LFNhYLrBspNx2AkdbMjo7Ba1seb387RSe1J6Eeumy5cMQauohM9oV8svOxjlVdP2eMTrQlapUQ4DpDoNkbgQiG+ZdVxPR4cy/b7wMtvC2hvVhwO+E8xxc1RqNnZ+LY0waMUmBo6jVo/T0fus=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5035.namprd12.prod.outlook.com (2603:10b6:408:134::8)
 by BN9PR12MB5292.namprd12.prod.outlook.com (2603:10b6:408:105::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Thu, 26 Aug
 2021 08:49:48 +0000
Received: from BN9PR12MB5035.namprd12.prod.outlook.com
 ([fe80::e8b5:25a3:551b:6fa7]) by BN9PR12MB5035.namprd12.prod.outlook.com
 ([fe80::e8b5:25a3:551b:6fa7%7]) with mapi id 15.20.4436.024; Thu, 26 Aug 2021
 08:49:47 +0000
Subject: Re: [PATCH 1/5] drm/amdgpu/vce:set vce ring priority level
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, shashank.sharma@amd.com,
 nirmoy.das@amd.com
References: <20210826071307.136010-1-satyajit.sahu@amd.com>
 <a69fc58f-8c30-346b-f303-6bfef8aca724@amd.com>
From: "Sahu, Satyajit" <satyajit.sahu@amd.com>
Message-ID: <339caed4-e6f9-72a2-93dd-7ea9c437304d@amd.com>
Date: Thu, 26 Aug 2021 14:19:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <a69fc58f-8c30-346b-f303-6bfef8aca724@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MA1PR0101CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::22) To BN9PR12MB5035.namprd12.prod.outlook.com
 (2603:10b6:408:134::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.20.10.3] (106.206.77.242) by
 MA1PR0101CA0012.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend
 Transport; Thu, 26 Aug 2021 08:49:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebee2a31-0666-4f6e-a5f1-08d9686e7569
X-MS-TrafficTypeDiagnostic: BN9PR12MB5292:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5292814A5FF8A56273A7FA10F5C79@BN9PR12MB5292.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ijD05iOCLFpOGG5U7uR9tx9MTgtUTm863E7wYRiJSVrFZwRxZrQnzQHKVWMI/D9wbRIgSjNnzNwSfZHi4iDgrIdaZGOjvXAHhXFhAVSuavSUMFIR5ayFSdcj2F/Fq+hYDXXAwWjIvtbhK5uK1qYy3nTiB3WGWT0a3kHSjxcCe111h0xftzKbdLdhHglKNvqPaCGgIGJFb1yB/CDl1++noL6Z4lFdQR5+Skc7Gh33K3bj3/wC+QefeUF7MccLgKvRERpO43vxcbBTRf5DBU6192+z4Q+9NVpqgqWQ7MHwvPSC2mb4dMKV0oVN4t6+S31r7n3TZY3bwC4Lu4X+Abi9FoskPAL7WxKqD7y8BcO1dnkyI/TpdDo2aLJrA6viZalaOEkdauFeyaNBFiI+tVOOkDqSpkbBYm9y+Ex9rwY8n1ZH072BWevieESUNofQnrnTvtAw8NCdRDt2zT+xf6RlPZtSc7Vn3lN12mZ1vDMltHLyjVRlq1YIaY5GDL4he34PBGlLCSausGbiwF7DPrI801GLr2NZleQZJxuNdQXLotOyqZUn1I8jZFy3vQx5F1W9f33oKMI8UB0wwJXUjqaqcNE0RqdIEYo9BaeZ0oKWGQvx6Xr7TZGJ0ZHnbM2OKKe0uZuJgNyH6I5qIrLyBfUOrLnxukL7LgMW7Z8yXRk5Mhu8O2ENMo8fpYNUH8m0yIG78/ewGV/IUbUZnGi7wisLewFUqAI2JembDkF/SV7lqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5035.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(1006002)(16576012)(6666004)(5660300002)(316002)(8936002)(86362001)(8676002)(38100700002)(956004)(186003)(26005)(66946007)(66476007)(66556008)(31696002)(2616005)(36756003)(2906002)(53546011)(478600001)(4326008)(6486002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3NLS1pDMXdzd3laT0hoY2hFYTlORitSM1BBczV2dXhFa2ZSWlBzTFFLYlow?=
 =?utf-8?B?T3cvbEcrVmZmL3dsMk1IRURtYUpGWEV6OVFwQ09rQTVkODBjMncrOHZnTjhY?=
 =?utf-8?B?T3VFZ21oUWM1SjdFb2d5elFkYzVyYjc5R2d3OWtwcVcwYXFQa21CNm8yUG5F?=
 =?utf-8?B?Vnp2cHdBZFJrSG1XWit1WkVBakZ2UjQ3ZGdraVRSTExmWXZ5TFY4RUcxWFlJ?=
 =?utf-8?B?NEVHVW53SDdsQm91elBubU5YM1hGWS81M0xWTXpqTGZmYVlhaytPRmlCVG4z?=
 =?utf-8?B?UlZSendzQ3RFamZac3E1MWRnMEc2dTJ3cjNENVpsaStUcHJ1dktTV0ZnTm14?=
 =?utf-8?B?SURpQmNTbmY1SkhXUjFaTE1xODJQUVRabkJJYjFiR0ZEdEtKdjl5ZzVSL29m?=
 =?utf-8?B?V1JLNVo2Y1lUdEhJT2lrK0VvUDYxSEY0NC9oRURZT2ErUXhKdXkyUm1VQVhv?=
 =?utf-8?B?cFdOamhVd2JrRy9YUDQzMWZqWk5jTDlRNi9UMExwN1R3ZXE5MkVQUm45aHgw?=
 =?utf-8?B?Q0NyQWJYVjJXb1U0VG4vdXZUYU9QWGdSU2JTbjJ1aDI5Z3U4a3Nlc2x0STZ3?=
 =?utf-8?B?bURMS2JmSHU2bHczdkgzOTkzNHVoZEZKbS82TmNML3gxS1N2QnF4Sm5kcjFJ?=
 =?utf-8?B?NStOTklHcC85R0ErN2JFZjEzSE1oT3F0a3NMTUZlUWZ1NGRJbTFxc0VIQ1VE?=
 =?utf-8?B?VHgrYWYwejYxdVlaeERYU2pDTHpLT0xjN3BPaE1qNTVWYWlXM0QveXp5bHNF?=
 =?utf-8?B?RVhRaXN3UEIwQlFjMDR3MHdhaTRNdUluMGYySGg4VDU5R3VyZmdSd29wQXhv?=
 =?utf-8?B?Q0hwOG9KdllZaUVqWmZ1Z3lZQkxNa2RRY2tnSHZFbUpvWW1TNXB2ZUhXWGRx?=
 =?utf-8?B?bUNkWDdRZHEzc3JDWmhQcUNvNnFPcGZqaEFOMU5vV1pYT04vMitZSE96Zjcw?=
 =?utf-8?B?VC9zbkc2T2lHZThTcDI3K0ZQL1VtL2VOQzJjMkVyK0tUNGJYM0dZS3hJRW95?=
 =?utf-8?B?WHE3MGF3WWxzc1ZwNnVFT21udWJaNksrVWJnMllaanN6L21Ca3R5NHBlL3Iw?=
 =?utf-8?B?NVoxQUl4QlRjRGFhdTYyUFhKS244S1d1M1BCU1Z2dTc0RWo5eHV1SG92YmI4?=
 =?utf-8?B?bDhoc0JhaVg1RUI3VzJpVEg3WGxPN1lBKzJaa1ZudVNTQWxVS0E5aGtsZGRS?=
 =?utf-8?B?YlB3SkdyT2Q2enVBZVl0RzN4SjdZVzBWOWRRbkl1cXdlR040TGFocWdxNjJv?=
 =?utf-8?B?K1U4QXJBVkVFdllsOE5PZHpwNCthK1N6akdrREZucmFVU3BNZUcxUE9GQVN2?=
 =?utf-8?B?ZGtUV3JqU2ttOXR4RTFrd2NqeVhkS2czL0tCYzN5eXF2WW8wem1CY21ucTk3?=
 =?utf-8?B?N0R2MFNKWUlSTU1IOGJqNi8zclc1RzNIaXkxeDVKMGNYeGJzNlJrU0o5b3BO?=
 =?utf-8?B?REd3eTRubk9GdjMwbldYOHhHVWdiN2VjTEFZVDZUM0tkTmVRTUlyOFVETWVn?=
 =?utf-8?B?LzVYZE1XWTdCWi84TXVlRDlmOVd6ZnZSVWtZNitMN2JOSWRQb0NxMk5rNERz?=
 =?utf-8?B?cFRWbXBZdG9reTg1R2lndkFLWTlEQmtWWDFISmlvT3YyaDUzekwraGIxbUZS?=
 =?utf-8?B?cjd5N0ErMEFFYjFoRGRBeVk1K2V4N2krRzBSMmtJSlBaL0NPbTZHWG9qM2dF?=
 =?utf-8?B?NzhqVGlkaTJ6L3pnQWpvbTJnci9SVm9iL21IUjViVEFmWnBwQkd2bk93ZGtH?=
 =?utf-8?Q?YJFP1Sjliz3/bzvJcaDjAYMZYNeJHKypSOFvlzJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebee2a31-0666-4f6e-a5f1-08d9686e7569
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5035.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 08:49:47.7355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3TzSxxpJ/yvs5PNWU3QDW6Ttf3K8qLtq4TS85k/BF2Iaf+FPK1LzkUZ3eXfHrSw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5292
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


On 8/26/2021 1:49 PM, Christian König wrote:
>
>
> Am 26.08.21 um 09:13 schrieb Satyajit Sahu:
>> There are multiple rings available in VCE. Map each ring
>> to different priority.
>>
>> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 14 ++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h | 14 ++++++++++++++
>>   2 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> index 1ae7f824adc7..b68411caeac2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> @@ -1168,3 +1168,17 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring 
>> *ring, long timeout)
>>       amdgpu_bo_free_kernel(&bo, NULL, NULL);
>>       return r;
>>   }
>> +
>> +enum vce_enc_ring_priority amdgpu_vce_get_ring_prio(int index)
>> +{
>> +    switch(index) {
>> +    case AMDGPU_VCE_GENERAL_PURPOSE:
>> +        return AMDGPU_VCE_ENC_PRIO_NORMAL;
>> +    case AMDGPU_VCE_LOW_LATENCY:
>> +        return AMDGPU_VCE_ENC_PRIO_HIGH;
>> +    case AMDGPU_VCE_REALTIME:
>> +        return AMDGPU_VCE_ENC_PRIO_VERY_HIGH;
>> +    default:
>> +        return AMDGPU_VCE_ENC_PRIO_NORMAL;
>> +    }
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
>> index d6d83a3ec803..60525887e9e3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
>> @@ -32,6 +32,19 @@
>>     #define AMDGPU_VCE_FW_53_45    ((53 << 24) | (45 << 16))
>>   +enum vce_enc_ring_priority {
>
> Please name that enamu amdgpu_vce_...
>
>> +    AMDGPU_VCE_ENC_PRIO_NORMAL = 1,
>> +    AMDGPU_VCE_ENC_PRIO_HIGH,
>> +    AMDGPU_VCE_ENC_PRIO_VERY_HIGH,
>
> Please use the defines Nirmoy added for that here.

I'll wait till Nirmoy's patch is merged, then rebase my changes on top 
of that.

regards,

Satyajit

>
>> +    AMDGPU_VCE_ENC_PRIO_MAX
>
> I don't think we need this any more.
>
>> +};
>> +
>> +enum vce_enc_ring_type {
>> +    AMDGPU_VCE_GENERAL_PURPOSE,
>> +    AMDGPU_VCE_LOW_LATENCY,
>> +    AMDGPU_VCE_REALTIME
>> +};
>
> Same here, I don't think we need this any more.
>
> Regards,
> Christian.
>
>> +
>>   struct amdgpu_vce {
>>       struct amdgpu_bo    *vcpu_bo;
>>       uint64_t        gpu_addr;
>> @@ -71,5 +84,6 @@ void amdgpu_vce_ring_begin_use(struct amdgpu_ring 
>> *ring);
>>   void amdgpu_vce_ring_end_use(struct amdgpu_ring *ring);
>>   unsigned amdgpu_vce_ring_get_emit_ib_size(struct amdgpu_ring *ring);
>>   unsigned amdgpu_vce_ring_get_dma_frame_size(struct amdgpu_ring *ring);
>> +enum vce_enc_ring_priority amdgpu_vce_get_ring_prio(int index);
>>     #endif
>
