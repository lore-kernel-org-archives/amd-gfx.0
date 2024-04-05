Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A6AC67861
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Apr 2024 17:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81A6C10EC71;
	Fri,  5 Apr 2024 17:34:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wu51MiB/";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2129.outbound.protection.outlook.com [40.107.236.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9689710EC71
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Apr 2024 17:34:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXIfLjLv9SQzJC5Vdry5W2AF8oc1lmr2XkJLlRRrZYON0jFD4tegdYnFCm1NMcGRklgwiU1BlO1/6GFCaSyMJKXFpZmnBN6pNGrxYJiDv4yWefs6WMAzmfi9zjYS6itO40+X8jsnRCxH/OoWnKbkoYAmiFvt0MXNOydcg6Le9wnIcXLiYUL6sRpaPt0o61aG3er9Ly1qDUPpm0VQNwEKHnxiSnYfL439gCBdxrBtf9zHuAEE68JMxClQIOisAHmc+tiT91DxJIJjQGnRl8/gsP4kOYYdUIuy6BCth4eAiDl0X28rBctB9S5118Izo2HIU0M6FNpeWMf33NlbU/zopw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9YMKCQr/GpZlTNXLNx0k4kkPV8vx6WfJUcRDCr1V9g=;
 b=WTm8KskK1+/0DFMAU9cK2uW/VgxqfHSvGatjtIKwnnU59yboQfgnw8NMfiolLmde8fiDGp0LH1vYGW9aBZlVMkGZLk4X4xGz/BP4HMKF8rYfUkzjFBPYfIhKSS6Ck1D1Mj5aSxbFnFY/uoMGAkhPDDWp+XsraIlfjAFp7YFct0/UD4vXYH7E9ahg0I8ZVzDPtex8MHDwcmphasfGxlKkWCjZI65f+eUHXj8EM8gPi2O/oNMwI3G3co9OKjMooXTDUjaPC/4iUaZ77StOqFcP15FcLq9WskXNG0h0iVxA+ZK6ydtVTbNzH00QMcbpUKbNPkvre+Z3Q2GN1IN2PY+qHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9YMKCQr/GpZlTNXLNx0k4kkPV8vx6WfJUcRDCr1V9g=;
 b=wu51MiB/VK2Uc3WMuOn78SbJT5V8Z+C4GvtqPiniczI37JBRja1ZlfDYdE6hIgP/Xtuqigbd+GNZsAEIJnZ1CKMMUXNTZUgb1PrOQYRSb3Cd92xLMgnEh2C0BwkXOlR1OC3acrWV9uep1f5nLDlUMldaXL/UYlxk8+aOSJdIywQ=
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CYXPR12MB9318.namprd12.prod.outlook.com (2603:10b6:930:de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 17:34:14 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 17:34:14 +0000
Message-ID: <244008e7-ba2d-9052-9e6e-24f9fff02217@amd.com>
Date: Fri, 5 Apr 2024 19:34:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] drm/amdgpu: fix MES HQD masks
Content-Language: en-US
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Yadav, Arvind" <Arvind.Yadav@amd.com>
References: <20240405143616.704-1-shashank.sharma@amd.com>
 <BL3PR12MB6425A4F95DE5309A5C9FB6D3EE032@BL3PR12MB6425.namprd12.prod.outlook.com>
 <3e9098fc-ece7-20a3-a62f-62c972db1ebe@amd.com>
 <BL3PR12MB64258C08E4108B2F7F0C3D3CEE032@BL3PR12MB6425.namprd12.prod.outlook.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <BL3PR12MB64258C08E4108B2F7F0C3D3CEE032@BL3PR12MB6425.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::20) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CYXPR12MB9318:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z0suHhahV+k7laq7rSBt1kUwIxQDi9jf7nuI/SVW+gcXMe23DxvKGDVVcfCcL8BPpOPJHHpdZ8r0PBroVDoRbgIlJa3YgCqZAe68e/dc8K/OWdSw6FantHDbRn8YsOcBbU13U5kZ+jvNpBP3lNTVJ8ewHbs/WikbkHYXm8h0NvoSlKc1eVIur4d7d5/iuKxnpHp9IKjnY30vwNwYr4r+LW6GChpR0XRqnWUXb/196HCz5TINIptROXK+64Z1P5K4qJyymmzgF0ujArJMkdmm+oTzse5Cw4KfJoUbiQ7qsgBVveswefb1GTp9O17/qHMhPPFh0ef4lNcORsCBlO/TN1rySureAdtpFZgR7lFscYW9POSxUvpMX+YWNcypMblANnKCiI0sZW4gy5u5knm1cdLM8KjQ9OHwyPiU6kU67ZJsAxoVJlqbU/gDe8+e8Bvd1A0I6Dr2d2Xpam2ZFdeXKPbbY2/KhN1KvvSYSvQSxIJDUOWzj/qkYTFGsDO+CBLOEerW2KezGjq689q11YUZL7tVQq/KKx937qpfckTyFaNC6kCvEROPoi0Ij30PLqz0rU1sDnomHsFxu1Nvq2/n4LRT34SYmf089RTxVOpFgG04BEEuEqToa60ZJjMT42ODElJdZumj72RIUQ9uXMgLjavo/9E+1PmVOOTtqtNMjSY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWk2eVBldFdDdVF1UXVQYWJzZGN5N0xScjNlNFVNUVJHejlQaHZSaVNOWC9K?=
 =?utf-8?B?c3U3b3BsQXprUStETlZnVGEzajZVbythN2IvY2cvSmlyaTN2UU9jOWJ3bnNK?=
 =?utf-8?B?Rkd1Ym1KUXZPRVFCbVBvUExKME5HbnFvTUN5dkwxc0RTYXVIUGtibXI1c21P?=
 =?utf-8?B?UjNjUURnL0JBYjNpeUUzbGZobUdYamR0Tk1GeFdwNUExU3NweXR6K0UxaTFi?=
 =?utf-8?B?bjFuemp4anJGZTlCdi9XNkdhNUFrdlJqQzZsZzZGazVpQ3R6dkpDZEFlRDQv?=
 =?utf-8?B?RXQ4TDh0aE9zZG5WK3hKM0VpZGF5cVh5ODhFM3FMNFNKUkpJVFo2bjdjY3U1?=
 =?utf-8?B?enltMDhWRnBCWjg3enBFVmdFbUZjV0VuZGg5c3E2QmNTL01oK0V0TWk3VzVG?=
 =?utf-8?B?R0dBN2dtT015ekthaUpvOG54eEh3Skg4YzQ2UEZJMythZFI3N01BZVlHaXBE?=
 =?utf-8?B?S0cySi9vVkNqUjNuUUV6OXRaaytwcXd6ZEkzYkhXMEo3ZHZjWGpOeGdEdEE0?=
 =?utf-8?B?SGtVZjJFbi9OUmhZUGNlalhMVHczVW5xeHhTQ01kSlBuV1RhYnZTckVaSmtO?=
 =?utf-8?B?TWx2dzdVblhHM1VuRStxR3pyZzZCOXRaNjdOOVRBQ2FPTENBKyt2ekVaeXpo?=
 =?utf-8?B?cG1oZVhtL1RFc0x0YmlKdnNtVUFZcHlYS2hUOUxsRnJBcllFRWVhUmpqRlFi?=
 =?utf-8?B?R1ZZeVlCaXo0VUdiRFJhTnZuU05PT2NOaGo3d1FMM2pFeUdEK294WDRzOUFK?=
 =?utf-8?B?cDl4SEZ3TGZEWXhaY1AwSFp6bW5IUVVkaFdMdlJCeXh6T3E0RXpmQnA2TUI4?=
 =?utf-8?B?RTBBRzBaTG5Lc2F3NHowL21IdDBieUJ6OU1YdEVmb1RWU2xYMlYrYzdjS0lt?=
 =?utf-8?B?cDdUR1JRYkhQbDZuYkprL2txeUR1QjlZRTY3eFN4M3VWV3A1Rkg5ZzhJYm9s?=
 =?utf-8?B?OHBWTE1Pd3lIQVZSTVZsdFhuTXhrYkZwSEtTVnlwR2l2TEdWeG8wUTBwTTJ4?=
 =?utf-8?B?Zk43RkJvUCtSWFhCQTNDRGxIcjBVdGQ3L1h0YUxITlpHZ2dsWFFQVDVyQ1Nw?=
 =?utf-8?B?T0FEOFQwS0FmRVRBKzh1a1pEUjRCRUs1TE1xN000V2JQMGkzVnY3bVRFQXk5?=
 =?utf-8?B?VDBxd3BDKzZrRzZjUWppYWQramJGeWRoR1JFTWlBV3BrSG1UZFF3Nlp5ZE9K?=
 =?utf-8?B?bmVqV1kyTzJuM0hzMFQ5Q3M5eXRZUWs4N3F3b2tGWTRKRUZRRjVYaFlDWjFS?=
 =?utf-8?B?emZmSS9tclZEcWl0SG05blgxUGwrdDlFOEszNzVjSWpZQ0JEMW5qRGFjWjAz?=
 =?utf-8?B?dmFEZG1rMExHVU5NbUdSYTNPNzNkODIwSk5UUHMwVjl3Zms5OC8yRDJRQzVP?=
 =?utf-8?B?SmdYZ3pjM0M3T2tUVU9rQk81SHdKMStPWWVyTStLb2RuWDFzTGhvOGIvM2Zi?=
 =?utf-8?B?V0dVd1Z1UFVBLzdlVXNMSSsvbm9hVS9oWGFmOXczQkxhTDRUTStjNDMxQXdD?=
 =?utf-8?B?dzN2bzVpU3Q1cTFBTDhVWFlvMmFNQy9QOXMzdE5CKzBDQStoNUo4Tzc0K28v?=
 =?utf-8?B?TForbjQwZ2NPUFV2S1F1K0QvajBIWjF5K2w1NHhWKzR3cnVKYnhwbkE5dElQ?=
 =?utf-8?B?NVVsMytTK1FoVzEzcThPZE90SGY2a0FCT2xJNDBDZExZbWxGS0RsUnpMZ3Z5?=
 =?utf-8?B?NVVFaER0WHB6UzhzV1lPdVovMXNtZC90TzF5R29iUUhiMS9qSzRaaTk2cFpU?=
 =?utf-8?B?ekREdkNpVlIyTFRMemF0ZHJwVHZsSmQ5cXI2czJyZlpBYUFtcUFkQnZzV1V2?=
 =?utf-8?B?VWVFSTY2eGw1R3Z4eGtrZUlDWXZjMFpGV2paNFpQOUZMUHFxRzNtNUg5L1ZD?=
 =?utf-8?B?YjBMRXk2K1lxR29peXI1cWYreEJ4N3pJNGJWVXJsRWxvNWVqV3JxRVQzVXJq?=
 =?utf-8?B?N2NhTEIwaE00NVRYU0lJa0ZJL21IbTZ3bjRtUy9tT0dJOC9oOTZ5bTcxaWRS?=
 =?utf-8?B?L2NtU0hib3RpbGlsZDVrR1QvY1Z0MjI1dXlMQ2ZuVitVZzZRTkgxY2RBSVlq?=
 =?utf-8?B?TDJ2RjFubjZPUHlLeVF0QlY4Yk9nTjA0YS9YQXdjWkIwM3NlOFlqY3BCaDhF?=
 =?utf-8?Q?jMoyRzAT2ffhykqqMp85SFxTx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb44c81a-ac9d-49a8-eea4-08dc55969cc2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 17:34:14.6450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpVEXG71UWTVnmjD7pDQZVgFnT5Ih9IrJmM3YEZJNRJre3fSWVDbWKOjYyhBVRGd1l8kkyc6wTmnTv89WHla7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9318
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


On 05/04/2024 18:39, Joshi, Mukul wrote:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: Sharma, Shashank <Shashank.Sharma@amd.com>
>> Sent: Friday, April 5, 2024 11:37 AM
>> To: Joshi, Mukul <Mukul.Joshi@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Yadav, Arvind <Arvind.Yadav@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: fix MES HQD masks
>>
>>
>> On 05/04/2024 17:26, Joshi, Mukul wrote:
>>> [AMD Official Use Only - General]
>>>
>>>> -----Original Message-----
>>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>>> Shashank Sharma
>>>> Sent: Friday, April 5, 2024 10:36 AM
>>>> To: amd-gfx@lists.freedesktop.org
>>>> Cc: Sharma, Shashank <Shashank.Sharma@amd.com>; Koenig, Christian
>>>> <Christian.Koenig@amd.com>; Deucher, Alexander
>>>> <Alexander.Deucher@amd.com>; Yadav, Arvind <Arvind.Yadav@amd.com>
>>>> Subject: [PATCH] drm/amdgpu: fix MES HQD masks
>>>>
>>>> Caution: This message originated from an External Source. Use proper
>>>> caution when opening attachments, clicking links, or responding.
>>>>
>>>>
>>>> This patch fixes the existing HQD masks prepared during the MES
>> initialization.
>>>> These existing masks values were causing problems when we try to
>>>> enable GFX oversubscription.
>>>>
>>>> Cc: Christian König <Christian.Koenig@amd.com>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  3 ---
>>>> drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 15 ++++++++++++++-
>>>> drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 15 ++++++++++++++-
>>>>    3 files changed, 28 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>> index da48b6da0107..7db80ffda33f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>> @@ -148,9 +148,6 @@ int amdgpu_mes_init(struct amdgpu_device
>> *adev)
>>>>                   adev->mes.compute_hqd_mask[i] = 0xc;
>>>>           }
>>>>
>>>> -       for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
>>>> -               adev->mes.gfx_hqd_mask[i] = i ? 0 : 0xfffffffe;
>>>> -
>>>>           for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
>>>>                   if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) <
>>>>                       IP_VERSION(6, 0, 0)) diff --git
>>>> a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
>>>> b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
>>>> index 1e5ad1e08d2a..9217914f824d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
>>>> @@ -266,6 +266,19 @@ static int mes_v10_1_query_sched_status(struct
>>>> amdgpu_mes *mes)
>>>>                           offsetof(union MESAPI__QUERY_MES_STATUS,
>>>> api_status));  }
>>>>
>>>> +static inline uint32_t mes_v10_get_gfx_hqd_mask(int pipe_index) {
>>>> +       /* Pipe 1 can't be used for MES due to HW limitation */
>>>> +       if (pipe_index == 1)
>>>> +               return 0;
>>>> +
>>>> +       /*
>>>> +        * GFX V10 supports 2 queues, but we want to keep queue 0
>>>> +        * reserved for kernel, so enable only queue 1 (1<<1) for MES.
>>>> +        */
>>>> +       return 0x2;
>>>> +}
>>>> +
>>>>    static int mes_v10_1_set_hw_resources(struct amdgpu_mes *mes)  {
>>>>           int i;
>>>> @@ -291,7 +304,7 @@ static int mes_v10_1_set_hw_resources(struct
>>>> amdgpu_mes *mes)
>>>>                           mes->compute_hqd_mask[i];
>>>>
>>>>           for (i = 0; i < MAX_GFX_PIPES; i++)
>>>> -               mes_set_hw_res_pkt.gfx_hqd_mask[i] = mes->gfx_hqd_mask[i];
>>>> +               mes_set_hw_res_pkt.gfx_hqd_mask[i] =
>>>> + mes_v10_get_gfx_hqd_mask(i);
>>>>
>>>>           for (i = 0; i < MAX_SDMA_PIPES; i++)
>>>>                   mes_set_hw_res_pkt.sdma_hqd_mask[i] =
>>>> mes->sdma_hqd_mask[i]; diff --git
>>>> a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>>> index 26d71a22395d..b7dcd936afc8 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>>> @@ -360,6 +360,19 @@ static int mes_v11_0_misc_op(struct
>> amdgpu_mes
>>>> *mes,
>>>>                           offsetof(union MESAPI__MISC, api_status));
>>>> }
>>>>
>>>> +static inline uint32_t mes_v11_get_gfx_hqd_mask(int pipe_index) {
>>>> +       /* Pipe 1 can't be used for MES due to HW limitation */
>>>> +       if (pipe_index == 1)
>>>> +               return 0;
>>>> +
>>>> +       /*
>>>> +        * GFX V10 supports 2 queues, but we want to keep queue 0
>>>> +        * reserved for kernel, so enable only queue 1 (1<<1) for MES.
>>>> +        */
>>>> +       return 0x2;
>>>> +}
>>> There is no difference between this function and the corresponding function
>> written for GFX10.
>>> Why not make this a common function instead?
>> This is deliberate, to indicate that the HQD mask can be different for each GFX
>> IP version, so as the number of pipes and queue per pipe. Also the limitation
>> on pipe 1 will not be there for future versions.
>>
> But for now this is common for both GFX10 and GFX11. When we have a case where this changes in future, we can implement a new
> function specific for that GFX IP version. For now, this should be a common function.
>
> Regards,
>   Mukul

Mukul,

This was already in a common function and this could have been fixed 
there, but the reason to write two function is to make the HQD mask 
setup IP file specific.

There would be some follow up patches for the same for the SDMA IP as 
well. As you can see, there are multiple common/duplicate functions 
already existing in IP specific files (gfx/vcn/sdma) but we keep it like 
that to indicate that these values and setups can be IP specific.

- Shashank

>
>> - Shashank
>>
>>> Regards,
>>> Mukul
>>>
>>>> +
>>>>    static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)  {
>>>>           int i;
>>>> @@ -385,7 +398,7 @@ static int mes_v11_0_set_hw_resources(struct
>>>> amdgpu_mes *mes)
>>>>                           mes->compute_hqd_mask[i];
>>>>
>>>>           for (i = 0; i < MAX_GFX_PIPES; i++)
>>>> -               mes_set_hw_res_pkt.gfx_hqd_mask[i] = mes->gfx_hqd_mask[i];
>>>> +               mes_set_hw_res_pkt.gfx_hqd_mask[i] =
>>>> + mes_v11_get_gfx_hqd_mask(i);
>>>>
>>>>           for (i = 0; i < MAX_SDMA_PIPES; i++)
>>>>                   mes_set_hw_res_pkt.sdma_hqd_mask[i] =
>>>> mes->sdma_hqd_mask[i];
>>>> --
>>>> 2.43.2
