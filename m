Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9D0C27C40
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 21:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D955610E69A;
	Wed, 22 Nov 2023 21:14:48 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A885510E319
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 21:14:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACCVV6R4vGnDWYiffyuV5vLx+wnSSHqBlU4xgeHz/uhwr4zSaUpj5YbVWZSUwu8acJKSlsGA7n9HR7WCgNwz1JEaEsHvMfUt9QuXTTjuzTYLKoqqnfL5zbncZNOFgFhuIKVkNo9qp0v60UB1wFz8XIwZGJjqbDeSFwuStrKauEmxMp1daKiTrN3t2VGecEVszMms9YcjAzf61SjfVons2UUjwCUpSEe9u9HvgkvjExlu7lUQxy+auGjJkNrfJEMloZf7psKvym2YRR+JPVsahi6nho5jMVSmuEpMnljJHH4Lyc4Vo0sjudxjvj519bkJll/QBiFO0/WZCEFqXVfgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkHlsHiIThlLYuJ3DB5MqpqLvUaspNsGJsnxY/Z8G/Q=;
 b=I0gW88cCYMAikh+dn2/SHLSg0Mmcf//Z/Pin2aE1alpagcpnIlBLwhIruCWg2xHwJfgh8ujOwZPlVbe1zskupPFV5zVPSlyk9oPYAbT64Zhsdp8XxEaKq8CJAEQQKFkzXDkNbX0zdtLpxx5DoFke8gYGPHIzOa3iq3vuJXG1QcmHQ1VyDSUpDouXWMnkv40QE5/GaaxKzdfnri7AqOaC4YGIBUX1wzLQ8i3qho9FUJP3wPV3zgi3sfm3CRf/6N4qeqnigtfID1zyUIHS46UICoDxtb0ynzujsns865fbcPsOXjmGfac23dIlHTBWC1OPZeuVKF6uoPYnQuF8upkYqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkHlsHiIThlLYuJ3DB5MqpqLvUaspNsGJsnxY/Z8G/Q=;
 b=Exwd7QCOrDLcsrKixQrg/2nUqjJSUlZo80Ta56A14/e4g2RnHyDC811TvNKbZlA/KZxSVqn/qzIN1obmIodlMFVh/svhgMnj+5ksQeeuW2k7dkIErve6VUx02F3I9u3uQux8cnLigK8YAIaKDaxpyERmEvnU6yC5UUTVj/JHpEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4230.namprd12.prod.outlook.com (2603:10b6:610:aa::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 21:14:43 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 21:14:43 +0000
Message-ID: <2667de7c-1840-4804-8099-ad143982098e@amd.com>
Date: Wed, 22 Nov 2023 16:14:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/24] drm/amdkfd/kfd_ioctl: add pc sampling support
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-2-James.Zhu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231103131139.766920-2-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0198.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::35) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB4230:EE_
X-MS-Office365-Filtering-Correlation-Id: b4bdbbeb-fdd1-428d-8c2e-08dbeba00c1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5DH87my4AAbTkzD2rwtwYswlFE1ggrGJfPfDcVVyu3MtksDWDpJpjlMXHhDO5bukwk3K9YrCgOyiP7vCyCLxXzkL917BN+vt3b4DUoEIE9nBsPYdPl1iDCbR8Ivgd1z5S6EaVtTTwlc1OPqAYwQHJFg6kgo6JybwgXOwUCZFPOxE+UGPPB0aWfko+F8ngpHbvMZW0K8OPKt0hX3xw5VvZPiYxzjE3jma/orl32iq2ebI1GEk2XlO+Obeo5wYFrioXrPbtIsn8Cgq4qu1ywf9bX0gy3zfYotynppC680fmWQgYh0ZeCpdPDOJ5k2Mf+1RKjRAd8Uk59TR4vOuHGNR7qxGoji5+7UOUqfpt4MLz+8SJCRk3JUPauyuDNilfgWXqBkqKN5z7nYdfMYjMoTfPM/+sB0ZoGCQ8v3OVuQEcZ3omYcVoBy767973gAqao0IKZEDhKdnkQQWUjyjvf7E6CKll58KYT02C7HOTm/NFDCb7lRhbWZ2DfJXP/EoUyFRJo1YjqA15S6/nUMl0uK9RkY3P91Ft+zpYMqxjIXPUMLzi0vYFeqOvQLTdz68UTrrETslLFMy15zDGRllscla2cUbBPS4ZKlydCL6q/SJnxYfz+OhScXWXU6BZeBDyGYUnh350gV9ZDnptnTRbgUZoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(39860400002)(366004)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(83380400001)(2616005)(36916002)(53546011)(6506007)(6512007)(26005)(6486002)(478600001)(31686004)(38100700002)(66946007)(8676002)(8936002)(4326008)(44832011)(66556008)(31696002)(66476007)(316002)(86362001)(5660300002)(2906002)(41300700001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnVwTEVSblREc0hKQmRUcmhVd09jdjhlYkZBTHdNTTE0endldXFDQ21MWU1a?=
 =?utf-8?B?enU5S3lNOXlQZndRWDBuMUcwV1RxWWFNS3lQNVdDRUZQN3ViQ3l3c3VPbFBI?=
 =?utf-8?B?bytBNFJUdWFZZFUxQlVPa1RrU29uZ1YxbysxbEF3SmZKa3RMMEVtaEFwV2pz?=
 =?utf-8?B?ODVpS2xyVnhjaFFEeUo0ZjJ0VVBWaFcrMWRwam9HcWVLMjZaS2pkOXMwdDhk?=
 =?utf-8?B?WFdkMzVTT2hIcXVjRFQzcy9BdHZUUFFNdk9UYXpzbEVUSGJSOHFaUVdacmVX?=
 =?utf-8?B?ckw0WEtFRnFoTFMzMWpOUElMYzhid2lBNStaUDYzRU5jSzRBLzBzVjZERDNw?=
 =?utf-8?B?aVo3VDJ0RG9Kb242b2llL01Pa1RuVzZiOTlyTXpaSGtGbUFYR1V3Q1BrNlNT?=
 =?utf-8?B?elV5WThpd0g4eUtrNktkQmMwOXhpclI0c3BqRitmS2MxQnJVTldRQXpJanVx?=
 =?utf-8?B?YXNnYmFnNjJoY2FtUWpGTmUwNEVicUhjM0haWnR3RDhLYXVEOURFWndHTE0z?=
 =?utf-8?B?aXoyWStkZ2pJbmd2V1BqM1lqVk1oZC9WeVZHNlFvN0t5RVJjSGE4Znh2bXNm?=
 =?utf-8?B?RTlLYzhsRVhydzZNcmtXTHF1dEVsNVRuRjQ4US8vamxSbWxDRXZzd2NIMWJh?=
 =?utf-8?B?OEZLMGkvNkNSdUQxTk5xcXpMNHpvVzVKZXNhL2ZET2ljbUxLdkZpbCt4ZXJm?=
 =?utf-8?B?Tm1Za3NvRVNpdzkzcWhENzFBUE9mMGhOajJkVXA4eWYyNk9tWTFBeVBBS0Q1?=
 =?utf-8?B?UGtibi9tWTVQR3Z4cmsrWVBVNm5jL0hMblV1MWRiQWZZOVRaVjVFemtENDVs?=
 =?utf-8?B?cVo1MEVpMVl0N2RTOGFNekNhU1BPV3VyWjZCMVptN2ZWN1FwWjRjWEhVdGdi?=
 =?utf-8?B?a1dSWmZjQkVCaW84MHBSam9MdCttNm9rR1NBZmdZaDNONFh0TEl6dnAvQ01O?=
 =?utf-8?B?aHNoZlZ1TDd4Y01Jdi9FTjZkc0RxcmRnK2dpb043K1JQUzBSMzlEVHFUTjdN?=
 =?utf-8?B?TnVoZU5sK0hNRVlyaWQxdVhqdXhUbnI0a2UzRDJLRGJQeW03ZkNLcjh0ZHpB?=
 =?utf-8?B?M0Yzb1hLQWRvbzJpWTRnRjRhZE5ZOHdBdE5TWEJ0d0phRjNyc29LUkRmNEZU?=
 =?utf-8?B?UHJMWHZ2bWxwNkRFd2k1anJMMXhUaGtHOWtJQWhiUkNRYXB5UmxUYU5IaFdl?=
 =?utf-8?B?bXNmbmJuc3NhdVhzSGxGbmh4ZUdCMUYxS1N2Z2pTdlB3U3RJSXdtYmV6WS9r?=
 =?utf-8?B?QXROZW4rYVVSTlFYMUJqL1VDOUoxV2VCd2JZMXVyaVUxbWtnSVo1Zis2UHBw?=
 =?utf-8?B?MjNHVWVzb3J3SnY3dUt5YXgwV2w2Q3Q0eExPM3lLNE1scEYrNVlpUXdRYW1G?=
 =?utf-8?B?N1BWeFdSOFh0UERQYVBZbys2TmMweE9vMFF0Nk53OWx4OElaUWovVXNGOWVs?=
 =?utf-8?B?a1lCQnBYaVRKelQxTlZLaHZuZm5acDFvWExEVUw5U1JncGl4bWJXMGZBSnpF?=
 =?utf-8?B?MGg5NWJhbzFRWENwTG1SQTFMMjZPT1ozS1hvYysyWHNWMkI5VEE0UVczR0Fw?=
 =?utf-8?B?V3FOQTJBaWtMRUFrVms3NWNHaTI0dWpPNW8rVXJaRUwwNEFjUlZ6YUJrMUFP?=
 =?utf-8?B?eStYOS9iM0tIY0wwU0JDYWpoOGdGUXNuUmJESXBMK05PMC9YWC9MY0ZmQ3ND?=
 =?utf-8?B?M1hZN2lscVdHMkZGMkdBMzUzc2tUYVoyQ1NTdjB6enRxczY2WmlGand5eHpU?=
 =?utf-8?B?Mm5QSWhkdTdqZFlTdG82K2ZRWGpQeGhuRGZReFV2cDhJcXU2bENTZDRQSEdT?=
 =?utf-8?B?WXlWdHZOdldUOE5JSXVRSFdqcHBqRlZzTlNSSmExTUhRNUx4UkFsUjdxL3F4?=
 =?utf-8?B?NEo2TmtTVFhQWU1PK1A2WlRTblJhcGRSaW1FZnVOa3B2ZzRtU3JJYU4xS29W?=
 =?utf-8?B?RHNvVUpZRDVxVU04ck0rVnpiSXlXclA4SkxxajhKZWxGc2h2VXhkczZmSUVw?=
 =?utf-8?B?ZFgrQVFLZXFHclRBcmJNQmxaMm9aNy9lMXErYUJzbmlVamVEZEpDazhtRUtM?=
 =?utf-8?B?amJoRDVDM3ptL1ZKTldnWG9nN2NER1U4cVpHNGxxNWh6ZHBWd1ZQeGdxRDJH?=
 =?utf-8?Q?PEGFNHSVIjRbwxEmYlBd/WEBk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4bdbbeb-fdd1-428d-8c2e-08dbeba00c1f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 21:14:43.5125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8ny93WZKLPmN1XOzbdV598CcZ/Q0WVzBGkzUdsB4+gm7c2159YvxdjYlJ+XsYbfObzqsXmJYHKNdhX3ZCoMBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4230
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
Cc: joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-11-03 09:11, James Zhu wrote:
> From: David Yat Sin <david.yatsin@amd.com>
>
> Add pc sampling support in kfd_ioctl.
>
> Co-developed-by: James Zhu <James.Zhu@amd.com>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> Signed-off-by: David Yat Sin <david.yatsin@amd.com>
> ---
>   include/uapi/linux/kfd_ioctl.h | 57 +++++++++++++++++++++++++++++++++-
>   1 file changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index f0ed68974c54..5202e29c9560 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -1446,6 +1446,58 @@ struct kfd_ioctl_dbg_trap_args {
>   	};
>   };
>   
> +/**
> + * kfd_ioctl_pc_sample_op - PC Sampling ioctl operations
> + *
> + * @KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES: Query device PC Sampling capabilities
> + * @KFD_IOCTL_PCS_OP_CREATE:             Register this process with a per-device PC sampler instance
> + * @KFD_IOCTL_PCS_OP_DESTROY:            Unregister from a previously registered PC sampler instance
> + * @KFD_IOCTL_PCS_OP_START:              Process begins taking samples from a previously registered PC sampler instance
> + * @KFD_IOCTL_PCS_OP_STOP:               Process stops taking samples from a previously registered PC sampler instance
> + */
> +enum kfd_ioctl_pc_sample_op {
> +	KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES,
> +	KFD_IOCTL_PCS_OP_CREATE,
> +	KFD_IOCTL_PCS_OP_DESTROY,
> +	KFD_IOCTL_PCS_OP_START,
> +	KFD_IOCTL_PCS_OP_STOP,
> +};
> +
> +/* Values have to be a power of 2*/
> +#define KFD_IOCTL_PCS_FLAG_POWER_OF_2 0x00000001
> +
> +enum kfd_ioctl_pc_sample_method {
> +	KFD_IOCTL_PCS_METHOD_HOSTTRAP = 1,
> +	KFD_IOCTL_PCS_METHOD_STOCHASTIC,
> +};
> +
> +enum kfd_ioctl_pc_sample_type {
> +	KFD_IOCTL_PCS_TYPE_TIME_US,
> +	KFD_IOCTL_PCS_TYPE_CLOCK_CYCLES,
> +	KFD_IOCTL_PCS_TYPE_INSTRUCTIONS
> +};
> +
> +struct kfd_pc_sample_info {
> +	__u64 value;         /* [IN] if PCS_TYPE_INTERVAL_US: sample interval in us
> +	                      * if PCS_TYPE_CLOCK_CYCLES: sample interval in graphics core clk cycles
> +	                      * if PCS_TYPE_INSTRUCTIONS: sample interval in instructions issued by
> +	                      * graphics compute units

I'd call this "interval". That's still generic enough to be a sampling 
interval in a unit that depends on the PCS type. "value" is misleading, 
because it sounds like it may be an actual sample.


> +	                      */
> +	__u64 value_min;     /* [OUT] */
> +	__u64 value_max;     /* [OUT] */

interval_min/max.

Regards,
   Felix


> +	__u64 flags;         /* [OUT] indicate potential restrictions e.g FLAG_POWER_OF_2 */
> +	__u32 method;        /* [IN/OUT] kfd_ioctl_pc_sample_method */
> +	__u32 type;          /* [IN/OUT] kfd_ioctl_pc_sample_type */
> +};
> +
> +struct kfd_ioctl_pc_sample_args {
> +	__u64 sample_info_ptr;   /* array of kfd_pc_sample_info */
> +	__u32 num_sample_info;
> +	__u32 op;                /* kfd_ioctl_pc_sample_op */
> +	__u32 gpu_id;
> +	__u32 trace_id;
> +};
> +
>   #define AMDKFD_IOCTL_BASE 'K'
>   #define AMDKFD_IO(nr)			_IO(AMDKFD_IOCTL_BASE, nr)
>   #define AMDKFD_IOR(nr, type)		_IOR(AMDKFD_IOCTL_BASE, nr, type)
> @@ -1566,7 +1618,10 @@ struct kfd_ioctl_dbg_trap_args {
>   #define AMDKFD_IOC_DBG_TRAP			\
>   		AMDKFD_IOWR(0x26, struct kfd_ioctl_dbg_trap_args)
>   
> +#define AMDKFD_IOC_PC_SAMPLE		\
> +		AMDKFD_IOWR(0x27, struct kfd_ioctl_pc_sample_args)
> +
>   #define AMDKFD_COMMAND_START		0x01
> -#define AMDKFD_COMMAND_END		0x27
> +#define AMDKFD_COMMAND_END		0x28
>   
>   #endif
