Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA85C61D85
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 21:35:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF27F10E194;
	Thu, 23 Nov 2023 21:35:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 783E010E194
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 21:35:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5KdlFYcwvcI4iImJYRuudrM1cVt0lZtU8vTBWXxOnuMkr1qhs4yIKvGB7J0uJPnYKooM0D+xafI3HdMC8bfC9bZRJ0dpmY7f7xae8F6DXiuMWjtC6A8LQ47WirQjXx9t3KohDJA94SZc3mOglqBWsWYjrOAAx6MR2QxHeNBWTpvR9XxyaBlWfGlLUga2xU6h3orsG4BiAlwf3SxHaWAUwaiBo7eN1KfAYfAtaRrEVOxR2fBwN1JDTpnmHuNloyVYB7hMIBMN7Jntta3l8GTj5ghHd6OGYpvKvrr+Ms0eHPN/TWSr+2Rm/nRFb88nwk9bGAB3mlk4QYbtV0pZm3QDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dyU7Tp8Kn/DyPKgu7VQHnnelRUJz02GxH64/8AtxpA=;
 b=cNZd0B4bFOxiy1FaCFAXSPvxClncgCPob34KKT9F0/Dzx4rnkFhRnay/DrarDx1KZOR9rCqw0eAqdHKDqp21PkO+tUHaHLuDzkxIBh2Pbrh8bNvbcW4ZNBnTQprIVD3mZpnqcLCtaYZxcrsJn4NSPB8vnCOtB7aqJdSlLyfnLtPHTempep44tx26U7NHM2IW27Qa4CQMVUuM9o+Lc1wKJDOuRboghUkCXGSrFekq9QNtSsPoaSIOT6+5kSLtgzlmUOHU7PNSgVavU0erAaA8F6/6drxtXovIo0JVrd5rHWEzVcsFMnFQaVpYLp/5eUR6ZvUChxtqHV0mHH8GJHjiNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dyU7Tp8Kn/DyPKgu7VQHnnelRUJz02GxH64/8AtxpA=;
 b=lmSdqusszpGC3sUsS9uDgh35N/Z/XqzupFB5T5FNgt2OzN3AfhDedn6vUKkVNkoRofoPs9XOkAjtr67iTzpHigLbUAzKAoFs1Pl6dQaDPzYdmuo1hTV0HDrc9gz6jGqfO0L7G5DbPKYerNxDyS+4pY2MS7bYHyUexbGYKchnG9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY8PR12MB7193.namprd12.prod.outlook.com (2603:10b6:930:5b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Thu, 23 Nov
 2023 21:35:40 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 21:35:40 +0000
Message-ID: <afe6ce05-af3b-4358-9af4-128bfc70a323@amd.com>
Date: Thu, 23 Nov 2023 16:35:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Enable event log on MES 11
Content-Language: en-US
To: shaoyunl <shaoyun.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231123195506.1042016-1-shaoyun.liu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231123195506.1042016-1-shaoyun.liu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY8PR12MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fdf24ce-0a0c-4d1c-0013-08dbec6c23d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hqhdMO0GGLv/y+k6YUopBVEV6Xeo+E9NKRHgMSQBU6Bx7thN48XP3mKetLez2hCEJReqFuTMgsxiD8klwaot8CXtAdM6FS9ovqiFJ2bLAWezKIS/iBomlmvIild5P/CAfXcOBuE9vkCodggg1YvxkMtIOYGp3l5rrTp6FinzPkceB14u5kKttSQkWiyy+QSaGfys1h4NPVcQ+VxLwbgtXzMuXQep8X9QnXEjvzLldJkY6Asm769H97DsbjRWccjUv2RjipSZbR3h5w8YYaZJUm0Xkj+fASRVkcsiwicICzA9SoLu9c9Ja8ehol+yJ+3XaNuUFsPddq7G89j8I26iRF63smh9j0fWbFwmp2RG8G7oeZvUw8VgmNlRsyJMkn+F7JESkG6VfPFigNrlz8aW0HcFxr7XbxWLQ3Kcqo4OQxCX6beNVnVg+uW4r5yprx5C2G7PPn5lZE+67Iu5rQsKa/PpzhFN+qz8W0enCmUeykriUBrA71oIy1si+mq6+FqK3AomMfCd72CK92WyedatigPXxh5vR8uVjolvymd9fizrZiDv03XacWcNPMQTdlXPQhHjg/EFmvVnn6ZBjtIIcY9AsNTovglJOl2t7812T5kPgy1sCG7wRqGZHsJAf0xe92dygXfUBI2oZqk4CeTLzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(66556008)(316002)(66476007)(66946007)(26005)(36756003)(4001150100001)(38100700002)(8676002)(8936002)(41300700001)(31696002)(86362001)(2906002)(5660300002)(44832011)(2616005)(6486002)(83380400001)(6512007)(478600001)(36916002)(6506007)(53546011)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VURmbE50eDBlTTlLQXUyYlViRFhKdHRZNWJjMTN1VkdPQWlIV0gzYWFrZ2ZD?=
 =?utf-8?B?T2NZL0h3RVdyTTFMb1ZibXd2VjVFTDNKK2tDRFQyOVcrZGFmdWlpUmRQOXVY?=
 =?utf-8?B?SHZwOGxTYkhkWExvYXJQaEd1MU16SHcrcWUyRklCajBCUjdwRlprT29MdmZ5?=
 =?utf-8?B?TnBYVWhJSUUyZUplNVI2ZHFYWFNua3I0UFY4ZVJxalFzMVE1eFhqbjZJcFph?=
 =?utf-8?B?ODF3bklNdTJaRGRVYW1DRGlYY2lLU0FhMWk0cTJObkJsT2NaYTEveThRKzY3?=
 =?utf-8?B?UE15VEo5NXZxejI4ODZEY2JlQnFuUlRPQU84OXFjMVF2MlNvRUZ2TlJsOVU1?=
 =?utf-8?B?TmtzN0ZGMkJDWFBWOXNlY2FKTVh4UG1yK3dUWDQ4R05GVjgwNjJ2RXpGdGUw?=
 =?utf-8?B?NUxhKzg0aWhQOE4yOUdQeVFhQlFrR2g0aUdEMFpuZkdKcEFuck9yd3hHaEUw?=
 =?utf-8?B?M1g4cGRXVnllb0F5ZC90Q0NWS2U2Q09UZkdIdUxnRU5ScnFXdlNqUEJwZVJm?=
 =?utf-8?B?RE9SQk10R1BsWEl2VzRaL1o0SFoxbVhnOFdjQzRlTU9VVXZ1d0t0a3AwMVAr?=
 =?utf-8?B?bTNqYW9Tc1NlclRldEJITEZXa2NySHJWdzUwRmlhNElmL0JRM2xVS05MWjFy?=
 =?utf-8?B?T3dWYTFaeVhSYzhsT2dGLzU5K1NoM1p5ZXhNYjV3eHVDZldWQkVEelJ5UDE4?=
 =?utf-8?B?U0wyZ3prZ1RIUzI5MndndGNpVXhmVzlLRkxhZmVVNlMwVXp4WUxWK1ZFb2Zt?=
 =?utf-8?B?TldJR3BpeUc1Y08vYUpROWZOUmxlY0Q4Y2EvWEFUSlZTa21DcE5LMWpDajEz?=
 =?utf-8?B?dWtaTXQ0MzdUdzkydmEvY3Z1SzVWQ3VMYWEzQWl6Nlkza3BmSnlMYk9BcUxq?=
 =?utf-8?B?OGl6UU1qeS9DRDVJMVZNZ1RGUWY0MHBaanNEVGROdExDcExzcXBJODI0QzNl?=
 =?utf-8?B?d0xTZnlPVDJhQ0JjUE1XNTk2aVVIVkNkNHBqaWFDTGRiTnQ5SmpQcEFqWUpr?=
 =?utf-8?B?aUR1RW9TQk1pMFdNalQ5YkMzSWJjOXFDSytHTGtaYXAwUndDRGRjTDBhZHFs?=
 =?utf-8?B?K1dBTU80bC95YkVaQTQzRmlabGFsaStncmk1QTY0R0o1eFdmSERDTEJpam1p?=
 =?utf-8?B?QkUwQnliWkd3TDBsUWdMaXo3MUhuUzlQUkNCUytxNU14Vm1ZRThneEdDMkZY?=
 =?utf-8?B?Q244bnZhWUZxQ2xsTDl0NGlLVTZRd0hJak10dU9RTW80ai9OVzk2cGNISEx4?=
 =?utf-8?B?VnR1WVhkQ3c3TWJ5T2lndDYrU3NONmNjL0Z1clE5d2lMQTNsSFh4RGJFUjZp?=
 =?utf-8?B?VHM3dWNET1lFMERqTndhaFZXdFppSVVaTTg3RGxiTnRhYVZmTUlyejkvQm5J?=
 =?utf-8?B?elNqdHpLQitVYVpKMEZYb0lvcldLYlBxSUwwVTlkU0lpWURyYmVCSFVaRzNm?=
 =?utf-8?B?ZGhhbldXb2dEZzRaSVhtSWx0RlBmMlJlU2hrSy9zckVuM2JHOXdVS0x3VWdn?=
 =?utf-8?B?TDdkS2E5MmpWeUVUQ09JUHU3VVlaSzZKNHQzRnJBMnUwRkUrdjNNN3EvamFh?=
 =?utf-8?B?R1R1Q25JT2VrMUhWUTZ6TExuaHRZVmNPV1A1bjRoeUxocFRvRzZrdzVuTFRK?=
 =?utf-8?B?eElYSkRrUXNZbFVoWlJxNVhKZVFOeWpLaW9NbWZIYWsrMzlrRGZYakU5eldC?=
 =?utf-8?B?ZnpmZmhuYks5ZzJsNUNuNjhSZGRTY01mUXZ1QnRISlBsdXNpNWlDa0tNMkx2?=
 =?utf-8?B?YlcwR2dYNzRMRlZNVUlNV0d6MVFqcUVJc2tkRzQ4WlA5cWdOcVd0aldON01Z?=
 =?utf-8?B?c3hFcStPZHNnUXk0Y2dTU2hhU3RYeWY4QWRJODIrbUtLMWhQaytOMk5hR3dX?=
 =?utf-8?B?WDJNYXdKaDRlRTBEK3FqOFNQV2k1ZGhFTkZVN0dhenRXRVp4VXZqNXh0dmRY?=
 =?utf-8?B?T2pMbGVwekN3ZTdIUXNVT2trdWgxZDM0eWhUZjFObU1QdWYxS0ZPaXhsTHVR?=
 =?utf-8?B?dXBVcUZ5SWZIMVlBVUNTL1QzelFTb0JmaVNNZWdWRUNOTGxZSUpZYlFhSllB?=
 =?utf-8?B?UHczMVVTUWh6cVJwZWFadWQ2R2FjY0xEVTVhakVGTEhVV25kRDV5ZHhRRGdC?=
 =?utf-8?Q?L7HvJOa8Hjt5Tuya2nKQnbT8C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdf24ce-0a0c-4d1c-0013-08dbec6c23d8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 21:35:40.6293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVikMWS0NvMfCAod/0J3ZTgtOOLUaF0iOGwjwyItjgke9R+d02snrH0WJsxDaavtWz480IK3i0cn6JBbibm0tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7193
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

On 2023-11-23 14:55, shaoyunl wrote:
> Enable event log through the HW specific FW API
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>

I'm assuming that enabling the log unconditionally has no noticeable 
performance impact. In that case, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 2 ++
>   drivers/gpu/drm/amd/include/mes_v11_api_def.h | 1 +
>   2 files changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 4dfec56e1b7f..26d71a22395d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -408,6 +408,8 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>   	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
>   	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
>   	mes_set_hw_res_pkt.oversubscription_timer = 50;
> +	mes_set_hw_res_pkt.enable_mes_event_int_logging = 1;
> +	mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr = mes->event_log_gpu_addr;
>   
>   	return mes_v11_0_submit_pkt_and_poll_completion(mes,
>   			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
> diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> index b1db2b190187..1fbfd1aa987e 100644
> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> @@ -232,6 +232,7 @@ union MESAPI_SET_HW_RESOURCES {
>   		};
>   		uint32_t	oversubscription_timer;
>   		uint64_t        doorbell_info;
> +		uint64_t        event_intr_history_gpu_mc_ptr;
>   	};
>   
>   	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
