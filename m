Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6A1C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 16:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF2B710E1E0;
	Tue,  2 Jan 2024 16:18:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4DE910E1E0
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 16:18:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDL/78BBZbLdi7fYWNX0wbcStOvuIXR5TkaWK0ItPF6PLY/oFgbc8HFOeaK4lGNEZnz+oMl+PsTuKAWMUGkIXjvbaor3niFy4fQa5GgREtklGOHOwuFmOb8jX/mhA1B+emgOuX+iEnqu0k5TdCaIMo5ezwwv4rIv/rwM4hj/0GOnJOB8+gIlT5lHacVJRlv5rOtx/sUVraT4G2L4mv6IaGplPbaPMqZ84DQb/a3J6TBFDqutK6i8JX1Ou6UBz1QsxvNUO5hHGTI4npr/VdjiqOTad4+BTtMWYnxAxM/qU6tvPb1TnaUdiRpqS++uoHTPr/GAjSO9lyD1cSHxJuetQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UdFkMAgzmLbobL6I1GfNeqBZPd4ixpHxYzOWt5wrFs=;
 b=VQxHhOaMR40EXyWX2Nk4rvGeBjPlo/ZG1+zonqi4yKLzlEj74vRVl3Tm71aMaK5MniUaXrI2rV9I0Fa73xHgMqp/gL185qB1jfXeUuk4DVDfnkrMtw+olpVDxNInRUDlrG7pX1k7bnv3ucw/0tXtClW1BxefGnpexDPG2xX0ym7rJGzdtx+aWpkprjXMqSofkDEE6cS2AjL/RA3eTK3ZL1G5knl6XJo4LPd4PEqDNyNkpHlqjrvQMjJsgSkDDFFvFGwEPW/dWRwKnzxvagOa4DlItXnM160bDUn4/4TMWSSMWHAWcYyJSK1m1xK6ekLdFQ4i+D0ZedMXHWUxwg6xUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UdFkMAgzmLbobL6I1GfNeqBZPd4ixpHxYzOWt5wrFs=;
 b=cC6fCSFPK2NwzVX/wRk+Ac3AevlZgFHZnUvhZt8+qCrPxFDI1oT+LPiavjpWg/mJiWtGrFvzbycPF7W395eewqdQfY80kqdbCsTqWEwpGWWsfw2dV0CR/F0sMI8uoM7B1277FVQpzZlf40sVlmjALF2dMD63gCHrvcLh+Zn/Z3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW3PR12MB4556.namprd12.prod.outlook.com (2603:10b6:303:52::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Tue, 2 Jan
 2024 16:18:44 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7159.013; Tue, 2 Jan 2024
 16:18:44 +0000
Message-ID: <7cd9894f-411f-482f-b5a4-08b1dbbd1daf@amd.com>
Date: Tue, 2 Jan 2024 11:18:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Drop 'fence' check in
 'to_amdgpu_amdkfd_fence()'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20231229151226.175336-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231229151226.175336-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0168.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW3PR12MB4556:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4eee48-8983-4025-7404-08dc0bae7db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5q+dnA3l56NTNPC//B5Jvkx28/Vp+E9RqCkDJYZaihO64mk8Ih6W3mV6SYyuGPEsPbTzny9wRJ0WiKhTin02tmLlmpKNGk2IlI/NBKEZT2hnHdrHhwkuJtn5P77nxsPO/mhyWVBUIbqGD09LDjsVOjtsgEPYGjbFjsU/KLpoxTQqWbEje1aROg/yvwl4sfd2EaD6ZM/V7p3Qt/m6U0SyQCr07rVB7cOcYYdEHwsIbwlcXrTuOZkmj0jIdKIZJYojFVP+mpNO6WEEIcRxy6j7JqT3mDmJB2c/r9cVOJdEznj24Cz/SjelLa8qvG88JMVgNizLRDvt2ui9PUox6A6rRC91dkBanEQ//e0uLLzspTbxpmrM7pPuM0AByQcSnbEivOlbvuFqdQdSBvsoWuhAdMGu5GfxKof292bMQUgUIoNmnvkSsmAq1K0fSPJ8zAXBbOTF6W0QhPqPzDkytSV3BDTnnRhU470CbmQccux9hGsgf/oXEVrbydqUeyrK4KZLONZ310HM75iYX8aQFWXuioL/e+A6ROm/ehPxC0XeeNQUkdJYgDgVii/OlbsnvbMSLjwDwTBErphhl32fWIfALiHPLkRWQacmObuuPHF6e5G0cJtBtaiWFNHnQqTUtbKHUYWO4q+3CH0DF8nZ2r9fxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(39860400002)(396003)(136003)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(26005)(2616005)(66574015)(83380400001)(38100700002)(110136005)(66946007)(66556008)(36756003)(66476007)(316002)(6636002)(6486002)(478600001)(31696002)(5660300002)(86362001)(4001150100001)(2906002)(31686004)(44832011)(8936002)(8676002)(4326008)(36916002)(6512007)(53546011)(6506007)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVZkZlYyREpGZ2d0UHZVRldoZ2p1cGtxTEtCVDZPa0k4VHBhaTZlZERDTVRt?=
 =?utf-8?B?cXFDM1R3TzdNQzNnMmF0ZEFJUWhDYUx5YTBVY0wxS3pycFVNYWJtTjZ0ZFpz?=
 =?utf-8?B?R3BFS0d6RlliaDYySmU0bWkxSVpDMmJmUGVzbm5GM25EWWFWTkxBaERxNUk2?=
 =?utf-8?B?MWlvYVBPUkdqUmRNbGhRcjN1bTFSVTYzSlBkcllUWHJlUVRZOHhia1Flcjdk?=
 =?utf-8?B?MmdoN20xWU11ci85aFEvTVRhSythNS85RlBDZ29pSzNSNWZBZHJOMU5FeWJF?=
 =?utf-8?B?T1hoUzhrcXVWRDNkTWZucnYzUnJKR2F5bjl6Qkh0eDgwVlVjZG1rbUwyY2ZZ?=
 =?utf-8?B?YkhyOUVGNjhUdTMxZWNFNlh3OC9aZkYxeWxoWVI2RVRldjFjNkhJblM1NUsr?=
 =?utf-8?B?MG9ZK3ArcGpFUHg1T3U3M1hFQzNTNHNqeHluTmlOSEFXU3pTQU00eFZjY2RS?=
 =?utf-8?B?NnZZaFF2Wll0R2JxMjJVdUczOFQ2MUFHNkdXY2RoYitsSjIxSWkzSEF3K3h3?=
 =?utf-8?B?RVUrSlk0VWc4Q0FaVlhxM0IyeXhManI3RjlEQkxNTEZTVENhUk9KUXVqZTM4?=
 =?utf-8?B?MitJSUwrbm9Icy93Ry9sNDN0ZmxMOUtJMjhuM3VZYy95MEhSdG85a0hWYXpy?=
 =?utf-8?B?bnBaYlYzKzkzZ3lGb2NCQy9JbExCVHBCM1k5emZRSXZZMGxyY3pBRk5XbVNG?=
 =?utf-8?B?Ymk4eXdKOTJMRGRDd083U2NMQ1poQllZMUxTQkRsSTZuOVNZTjBxeXZOOG1T?=
 =?utf-8?B?VE5DV1Z1dDh2MUcxY0NOOFRYWVRVY3U1bWJpcm1xUmFaV1BmbWNkUHdaUUow?=
 =?utf-8?B?YVBrU1hiSTdRdE9xTTRDTEI0bUtSZVRHUFRJMFBWYytMUytIWDVGdnRzbWVY?=
 =?utf-8?B?Zk1McHFCZXVpZ250ZExDNXhUc04rV0pNSGNoU0Zad2JEWnNmdFhFSXNLTVN2?=
 =?utf-8?B?dVlTdkoxa0N6N2NiMVFKUi9XWFU4cU1zemVsZWlML3pGeHl4a3J4VUNyc1Z2?=
 =?utf-8?B?Z2JtQmZzOTR4UjVDM25FQlk1NGhqbE1SallwUmJma0xLOFVwaHNDcVBrU0tz?=
 =?utf-8?B?TDNaQzk3cHVSc3FTanRvcHdwR1Z6Qm5aKzRjZjc1dUx3bjNSUmd5cmRkckgz?=
 =?utf-8?B?ckhCNlhIc0crK1d3ZXhFRWVscENnNmhFM2k0VE1VL2R0WEowUHFJU3I0SE9K?=
 =?utf-8?B?SFBPazVyc1FQaW4yYzhEOGIzYy9YRkY0bzNReFZlcmxtcUxhSHp6aEJTM21U?=
 =?utf-8?B?OU4zNTZGOVdkdUZYWUVHMUxrVWExMEhKSUNNckpsQmpXdG5peVlZSVJFU3Q4?=
 =?utf-8?B?TERhR3E1VnlUUExBQWcxTmN5SUxDQk9qeWZOSGJmbUIxQnFobDg4L0lTdUR0?=
 =?utf-8?B?aTc3RS9jNk10MjM2V0QydmtWNHNPeUljbnlTY1RpR3BHQkcvd3Fud2V1anpE?=
 =?utf-8?B?UmNGMkYxNXcvaXIyNUZobEtvMkdtY3A5S2lsVXUzSXNaWnJXSmVycGN4RUpm?=
 =?utf-8?B?L080ZHE1Yk1kRlBjOEptdkpPTEpSUDV0bmc0d0hCbVVIamlxVnVPWVdCREpm?=
 =?utf-8?B?ZS8rVzVKbnZjWHJVZ0pjbTFZY1BRVUdPSmVLMUVBYk1FZkd3UGdoME55UVVr?=
 =?utf-8?B?UWVMOXBCQlkrMmZYbkhDaXNhREIwa2tDcVdtajFHVTRlZjZkQnVZTGpNYWRK?=
 =?utf-8?B?OW1nNWhJS3c4OXVUNk95S0R0U3FDOXBOMkU0dlh5NXJuVncwdktVdWNZVFcx?=
 =?utf-8?B?QnlLQ2YvSm5EOTcvVDhMYnBFdXNBSjB4VGYrVnpBSndXZEh2TXJPT0NKcU0z?=
 =?utf-8?B?QnF3UVowRXZFT0Fuc3ZHdjhGcWNtYitlMndRd2FlZStFWldFNlQ1ZUVsKy9I?=
 =?utf-8?B?aXdhbEExcitKT2EycUpidnhsZ1lCdkMwTWZzbG04ZFE3clZFQXZrUjZQWlFv?=
 =?utf-8?B?TjFpUC9zNmwwbE9SbVN2MFFnSWFUZmJtLzhTdHNqMEk5L29nQ1BpNk9BRWZu?=
 =?utf-8?B?VXA4czdvUmduWW95RzlPNVBMSHlLNFBLM0UyUjdVSzdXTEl3SlBGVThGci9o?=
 =?utf-8?B?dHFUTXlSOHEyeWFoc2lRVEY4T0IzK2dqRGZna25ESXZlaWdROCtZR1I4Wk40?=
 =?utf-8?Q?1xwQHU9oTh3VzfrdADjPttG4s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4eee48-8983-4025-7404-08dc0bae7db2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 16:18:44.3383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ttwcbP5kPPhHH8u6AxdVYuW0b5FrBCPn6lVEQNUIFLybEqPdxqf7FZ9PXUVkp6bh9KgY+9QNTOTpNNs801KhdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4556
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-12-29 10:12, Srinivasan Shanmugam wrote:
> Return value of container_of(...) can't be null, so null check is not
> required for 'fence'. Hence drop its NULL check.
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c:93 to_amdgpu_amdkfd_fence() warn: can 'fence' even be NULL?
>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> index 469785d33791..1ef758ac5076 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> @@ -90,7 +90,7 @@ struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f)
>   		return NULL;
>   
>   	fence = container_of(f, struct amdgpu_amdkfd_fence, base);
> -	if (fence && f->ops == &amdkfd_fence_ops)
> +	if (f->ops == &amdkfd_fence_ops)
>   		return fence;
>   
>   	return NULL;
