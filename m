Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862B4C072A2
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Nov 2023 19:49:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB44110E317;
	Fri, 17 Nov 2023 19:49:45 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDE9010E317
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Nov 2023 19:49:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9Sng/SBWdmH4yjc7Reo/d2OIbt3Ef4a++E82NYURaYYXixP09IsLBkKgyYIiu5rJqV392pR5rQed2YYYllyQuGoC4k62/k+XqGdTPscUgk0Bj5ANcs56aadS7fAPk1fMVqAAETqr1TbOkPoDHfucfJXLOCXro0+iBRjUqQ6nYz3QDDFUxjSSpl+b1Mhu+yhmiguEVEP0/Mz8L3Silr5KkxfFzPC5dd1Tbo6ig0hJo0z3VeWXY6X7dpEkz8HZJcJIp4ZryV+X3uPuLI1G4StNvnQMMzA/sz0oPHyxfIBRMwk25lMpMdV9UnCT5/7ihb8i0FghVekGoYaKlyam1pBrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxmmRty36QTshqi4nnIKSYGqTE8Qp3XpbBgyxGGacxg=;
 b=oBf6Qhiel6QWDjoX8+6UOaNk9bGb55F0ZNk0GH6t96YLHonqEG1Z8yI6nrCMUcUPMde69o8XMkE4rqcxK/lM9l/hf86MQ6nMghUfAGE6m1XRTzzecjJiKNfnn2y7t20OBPVWtHYTyqqhVJynuB1faFDJXiWszCvjSH+EZ765vKE0wQyOKKrBpssVG+RQeL96cbQXMGbGbD6mshRwHwjjnkYod1k1pe+N5V3JSKBSa3mCvkpm9FQxsPLfCWJAHYbv/3F7wX9e1rzPl5kWAVxd/6p37LRyMAKsXUqJghAHuZvVcwhRD8pApaooAgsRylP2D8/Ry6HozvBmEb4Q5j1/Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxmmRty36QTshqi4nnIKSYGqTE8Qp3XpbBgyxGGacxg=;
 b=lEV06osBmGV6/q24qXE9+ylQK3GjSz050325XLk3o62rSFK9CM5wF1Pn0DQ5yrkk7V7RvxVhbMHV/YiI1UX2XCmeOsBB5sDQQdORaKXkYhePhjaNc7Nk1rtD81PwzNyjwwZYotERVQC8apPARc1R/Oybiy7w0DXZ8lCK7Hx6lH0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Fri, 17 Nov
 2023 19:49:42 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::7ef6:8317:95ab:ce40]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::7ef6:8317:95ab:ce40%3]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 19:49:42 +0000
Message-ID: <3a6feafa-f264-43ef-ad41-98cb77a2d669@amd.com>
Date: Fri, 17 Nov 2023 14:49:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Copy HW exception data to user event
To: amd-gfx@lists.freedesktop.org
References: <20231117052010.3166816-1-David.YatSin@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20231117052010.3166816-1-David.YatSin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::20) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: cee466ad-3dd8-466d-0588-08dbe7a65799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nJKPDoX29WEXlxze8TAGfWAK4lU5Pckyai+P8wybEU0ZjXidMiv4phMtQLjSykFYXvD87YvlFU8Pqw+LYgPVPmjTmaS2FEWj8zu0xPVdViKQUtSew2ILaFUAwDwoXnyb9bRYSFhp2sA0Ud0/yWuq32vWA9k82Yli2TMFiIW/IiXLlncEMOYS2ql08JtLgUXtAjYyU0mwTw/9roAE8Jf9uJQwQncH3RycUZf9V/hySnOMV7Sy45R3tOz7KxNkWfPeMPXdyJNEptp7lWNbVaY9U8Md+SBDURfR3FR4EQvRuD1H0wqQNge+Be2dzZpe5nD/6MlrR7SY03RaJKqGdR/xto8FlNHGfxeFZChB2gVOYnuOV0wh+lsPKywGLHkTArs7TMRPiblrJga/f05gt56ckKWt1Mbfjxpcod+Oqggr2yvFES5t9OEDEqNF841ifTSuqcmv/z7kWaqImPfrHTBXfR0OZwuPd+RLxlpr39CI36JJfXO0T6HsKWV8HVSIDI+/HVKF78wtHmGFTO9UOw34kBV1U/2IFTufSVgnuIOaLc1sU+6t10/AS8vEeuZ/RZppuJIMQ+CVaNrAOHiSmw3bmk2OTf/ncZqpraNWG8szXX8hzNRX8pEuZj6MpRuYxOy5S6LR5C3GEKXFRiyHYEVgSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(66946007)(36756003)(66556008)(6916009)(38100700002)(31686004)(316002)(66476007)(53546011)(31696002)(2616005)(26005)(6486002)(478600001)(41300700001)(4001150100001)(2906002)(8936002)(5660300002)(6512007)(6666004)(6506007)(8676002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODdEUUd0YXA5TFdIN1BsY2dFdmpjSGV6b3hlYWp3dm0zZDUweFNSd3VGM2tU?=
 =?utf-8?B?eGhYSjgzTndicy9qT3FTbFpFU25kUXFRNEFJR0JtRVBUbGZ3V3g4QWhNREJx?=
 =?utf-8?B?WlQ5QmEyZlIzbmFuL3crY2Zkd0lEUndQWW5JUnFMd1N6NVFnTlN3RnR0Qld3?=
 =?utf-8?B?QTF2T3V5NGY3ZzNZV1E1dElsRFJGc0puYlgxMlBWYVB2SjN0Nm45WWY1eW1P?=
 =?utf-8?B?OEwzNkUwc1J4YlBucU9aV0dpY2haamFYNWRuKzdZUzE2QkF2M3ZkS2hzK3pw?=
 =?utf-8?B?NkEvWHlzZzlGcFk5WDFScXkvd3hLbmtMTDROQ0FqVys3dHRsMEZyUmhrMGVP?=
 =?utf-8?B?NG5EdkU2UnhxRjc1ZGdPMzFobHdEUGx3MHNaeWgyVFQxeGRmUGNaVkVjajJr?=
 =?utf-8?B?aVhjWFMwT1lhZmczVTE0a2dWU2RFaTFFMmpCSHE5SUJxSzdqSEtIZkpiS2U2?=
 =?utf-8?B?QUhBcmpMamI5RmlvSTZleXRrMlZIR1pteU4yWGZGVUNHRW9DZDcvejdIV0RO?=
 =?utf-8?B?Z3JRV3ZOaFBtSDB4Ry9WWTFDN3Buc0NRSHptOEY4TGNCRDBNSU9uODBxWTVH?=
 =?utf-8?B?QkxodG0rU29DeWlIMzBhUFZZdjBDODNlSmNyRGUwbVQrNWlyTzVTYkFoZVI5?=
 =?utf-8?B?TTBqY2VuVWRvLzVPcWYzNDJnR2dqenB5b0hQQitrT2IxUlVJMS9kL2MyS3Nh?=
 =?utf-8?B?YjhkY2s0Wm0vRFZGSTlYM0lmR29FSXIraVhBVnNscWhrVWVjWjJuS3ROV3o1?=
 =?utf-8?B?VkpoTllERnpkMGxiK2h5UGJBOTRYZTdVbEVuN096eGFyL3MvMWdiSGlhc1Vl?=
 =?utf-8?B?OUhzcTVYWERtRW9OdExPZGFXVGR6NEZJdHBXTXp3NHRscmRPUDM5RWJUbmZt?=
 =?utf-8?B?NlVDZXExRzQxWGdXdEFRSzNycDRzR0txUEhNV1kyeXNPZ3dIVktzSzlmTCt0?=
 =?utf-8?B?VS9pMU5VdC9IWmxJUG1lQ2kxa1NGSTN2eStKMjBHY0J2dG1iemlYdXhpdjJY?=
 =?utf-8?B?UGN2MmMrRlJjTTVDSEMrS3N4bDlLSExBUXJNZ0ovOFFqQ0tRQzRaTG4vY2NC?=
 =?utf-8?B?K0lZY0pyNmhPcUNKNUsxY0NtTVpmWFNwWUtQZDlmSlVkTDEzMkdVUDRycDEx?=
 =?utf-8?B?d3dpa1l5bW1Ma2cva0FCNUpFQ3ZIbldkbGlLUWU5eXFhcC9oc2RPcjNib1B6?=
 =?utf-8?B?dSttKzlONmNMcTRUVDh3ZmhtMzBtQ1ZHNGU3dWg1QUFTWnhIYXpSZ0xmTlVu?=
 =?utf-8?B?M280SUYxT1M3UjJxa1hYTlNoeGlzRVQ1a0VSVm8yeUN6K2NHekJKNFBuRnVI?=
 =?utf-8?B?U2xDc240dHlWQS8rbkkwSDMyRzgvUUFLbzZyajE2RXR5cVJ0WFkwNklTM3VN?=
 =?utf-8?B?TkNiUjZUbnFId3AyZFNHQW5lYVlxQ1VFSDZ3NHd3NFd1ekNmSzZGV0RRdEdt?=
 =?utf-8?B?WGxyREkyeG81bWhkanhyRCtGTldzU3R0aGZVVUpyclp4Zlp4ZFNFc0wyckNF?=
 =?utf-8?B?d25FTjJsNi93T0xnWmFpTWFWTm1HK1ZBK3J6S3lvRWloQ2xQK3oxWjJZRHlF?=
 =?utf-8?B?eURwaFBXT1FpRUZuem5EcUMzVXU0bjk5R3NOcXhCemIvanpoa2hGc1F4NERZ?=
 =?utf-8?B?Y1R1UzZ4Vm9qNzZnRWxBM3AzWlo0Q1hIRGlqckpHQTRZcDYxK3ZvK1hCTEpm?=
 =?utf-8?B?STYvSXlCRmRlY1dZQnlJQzloOFVkeE9FUTVpdEEyKzhqNmZ3MXVRSjlrSDZ2?=
 =?utf-8?B?eUNNUHY0YXNDaFNjOWxLU1owT1ZMamhqaFdiMlZpUjFaQ3lSK3l3TVlSYUlF?=
 =?utf-8?B?dXdqOGFNallmOUNMRUs2S0dDYS94OVljWGtoN3k1UVV6RVZFbUJPZjRYZVBh?=
 =?utf-8?B?dmRnMldiNEpqOFZVSHBoZ20xMkxlL2ZQUVo2cnlFZUtDcHlmUlZMQVlkY05j?=
 =?utf-8?B?dFpXWHZtOVlKVVV0U3RKQmxGTWpML05rckI1UGRCaGlwNDY0dFFKbS9na1cy?=
 =?utf-8?B?TzNoRWU2VmttK01BOFk2b3I5QXJHZ1BBU1Nwekt6K3VMWWZOZWx2bDZ1cFN3?=
 =?utf-8?B?Q1FxM1lUeU9TYlh1dXcydmFwMyt0Z25zSEttUmdBZkxjcS9mYnlVeC9kMjNz?=
 =?utf-8?Q?wHvQlUGd4GOo0ZYzSDDHus1EW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee466ad-3dd8-466d-0588-08dbe7a65799
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 19:49:42.4961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WroZ2ymuPZHJEN1OOKEVS7D/xljYuGYjtPxYQ+R5S+bWSFwsGxPajIXxoyvjqcH34LAewQMNqVat76NrmjSpIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932
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

On 2023-11-17 00:20, David Yat Sin wrote:
> Fixes issue where user events of type KFD_EVENT_TYPE_HW_EXCEPTION do not
> have valid data
>
> Signed-off-by: David Yat Sin <David.YatSin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index 0f58be65132f..7d3db017f8d7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -880,6 +880,10 @@ static int copy_signaled_event_data(uint32_t num_events,
>   				dst = &data[i].memory_exception_data;
>   				src = &event->memory_exception_data;
>   				size = sizeof(struct kfd_hsa_memory_exception_data);
> +                        } else if (event->type == KFD_EVENT_TYPE_HW_EXCEPTION) {
> +                                dst = &data[i].hw_exception_data;
> +                                src = &event->hw_exception_data;
> +                                size = sizeof(struct kfd_hsa_hw_exception_data);
Please use tabs for indent instead of white spaces.

Regards,
Eric
>   			} else if (event->type == KFD_EVENT_TYPE_SIGNAL &&
>   				waiter->event_age_enabled) {
>   				dst = &data[i].signal_event_data.last_event_age;

