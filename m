Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18AAC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 04:04:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50AD389F5F;
	Tue, 31 Oct 2023 04:04:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2421A89F5F
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 04:04:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=desYAmi4UyjwlYfKGJLUx8Y0O1CYCxhn9GCr7lULMuv3yyGC/ZMNIIRfg89NCY8h9pzukmcg6GaMJFC1WyyxDiHWWwpiVYkAZ+83noPH65HH/tvqkycYf+0hTghGuNLR7Edp7i38CBhmTE1VAtk9Q3SpN6vZMzX1NoySjaBj4SWJk74CgIOLRh/ejFszQGfwEMxx8izQretYgrRLVhunlhE6ZqGcWDFSvKLGqIybXelSbZR5gOb8ZUeWxq53OsZc5SiG8OWdE7Kj5uyucb4FkllQpgje9Yegx3BV5EmyU4qzToURoWJhXZ3YZeKj21wtdcVXxm3kXaiLeHlILsJ2FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wqh3w8/6pXspI6vaKzijjQ2EmK0tdUihv63dLg7fpPo=;
 b=MjHC6hZaRpd2tDvH5XhCqEbODFRkvl+/hpV8De1Onyu7aNZHVzLs1JSe6hWnP+FFG/V1Aav0wXoCBpuEMU+t4c0LpPUOEHti7ZzkBlW7VllkOafmv/WX8YSMN79uk0UA17v1duysyhPHyfJatWH+9+5tu6fMNJUEN6mThiM//Pr17f9knN4TmUgz+eDLU38GCZIkNRjBWukqgAKNNpRLOEC31UCFmxN7LYE9zinwicsivcD24rT913qDieS9Qs8z0u6mTGVKDwDp1qiB08QPGJJx8w7xUYaFt3RBAN07wZgileDuWmccOWtUUHOt0UHcNfHCv9J3Zn/bF1dJ6NpvNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wqh3w8/6pXspI6vaKzijjQ2EmK0tdUihv63dLg7fpPo=;
 b=1L/LItMtSkyDQP4B9LCilGI8fe8zsJ27pJuB5dT7l762xzkvbhgUF2WwZ06fcWLjw1iwQDuVTAO34x8RwSnMz2tTk81ibZB7x9csnSD7n+mWI6Rhu7KDC7urcBf9l8J7LlmkzPfAjxx9R1YkKuoIOt0EdY2ZBJhUYAn/nMvhNw8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BL0PR12MB4964.namprd12.prod.outlook.com (2603:10b6:208:1c7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 04:04:34 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8b0b:3c38:b988:ca27]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8b0b:3c38:b988:ca27%3]) with mapi id 15.20.6933.024; Tue, 31 Oct 2023
 04:04:34 +0000
Message-ID: <4aad4243-25ce-7970-84fe-de9efa60613a@amd.com>
Date: Tue, 31 Oct 2023 09:34:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: remove unused macro HW_REV
Content-Language: en-US
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231031021236.2682661-1-kevinyang.wang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231031021236.2682661-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::18) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|BL0PR12MB4964:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de3dde1-5ea4-483f-9956-08dbd9c67e16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P+jXrEcl9hE9Bd0JMp0bYZ5sw2ZHU8gQ6dIMyR8aYjNRQrwr7ZIdU2Iwbr8xzrmRS2twJ71UuMse/WzvGbs3fVYS8tF2c4A1nTAui1UD7DjCNfEQCUtlfjVWgEP6+/YFWL32AVp+R0Vc/ccQ7Urx6aZNCkobugB0/499jzvkZp31nyL+7HpZcFgftfdjoQ5DPc9MUx9Z7cDuKU0hc/bRYu8e8H7TNyU6mPF5bFikBovhp1fFFPz5WNZED87IQH89/cE4Ozey19VVC8qli3lgzC0B3unfuU5gmUkUWkl0h5VCXVmnkJp7g4F6b1ACTQM1eLH5EawVMAgOdh3KgObmu8yg1tKYi0db2J0yrME81erh5eEsTvmyrUxi/CEmtVzsyWE0cRtsavd3+HCz/FsNYL8pYmQqeFP5Hl5nX5euatRdDSafbZe6B7oTqr9MmjEiZydT8ql6k+uYQsxhoA7gRgG/khrFQGxiwqSpmTxQy7wLmZng7FDMg0I1n+ZCapcdCX+sAeF+xt0wcyPOX1YNn/zWUVvCPj79WPK84w1VjZIGqJrxGRJSGi2jmQowIWRkFnNEGiP/+fHPtO+OpLucYOnHMLKVwc+T7t4GdKprcjl3eyZAOtymNpJkjqtXgl43pES1PRrLp2zKWw/+XstuDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(31686004)(6512007)(26005)(2616005)(38100700002)(31696002)(86362001)(36756003)(4744005)(2906002)(6486002)(83380400001)(6506007)(53546011)(478600001)(6666004)(8936002)(8676002)(316002)(66476007)(5660300002)(66946007)(66556008)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3NyYm9rUzJscUJmQ2lEWHl0MVhsM1JvV0dUa0VNTmt4Zk5aWVVlN2lKYU9t?=
 =?utf-8?B?WHplWVhGZkhqTUhFcGVvTEVScVBjZzZZcnF4bVEzWFd2ZlRiSXorVTVjT2JL?=
 =?utf-8?B?bUNPaExqZUZNWFlaYXlKVWJGOHg3SHgrUFFzWjlIZzFwaWhCZFJ4djF0dnFH?=
 =?utf-8?B?T05rOGNBakZsTzBzVS9BbTFVOGRjNytKaVdkM0FSODJKZjdTdC8yQ2wwV0ZG?=
 =?utf-8?B?YTVraEF2bGVYOVR6RCthUGhYeUZ1bVdkZi9iUXd6ejRnd2NHenQ2MVVkTHFB?=
 =?utf-8?B?Y1c5Z1JaZC9ZSGI5US94TE45eW9zL3NERmZzMk5lTkppc1lJbmxkYjNiSnM2?=
 =?utf-8?B?ZEZXcWZvckxKNjVPcTJTT2R0QWZyWVhGYzllbFV0VkhKaWFIRTkxdG4wRzhQ?=
 =?utf-8?B?aXdJTm96MTB0T21OWlRQQVhBeGdGWUNrNWRmSGdkaEdKQW4reStybllrTEQz?=
 =?utf-8?B?dW1xcnI3RkI2S3Mxa3JPbUpnUEFwWXFTWlpXUGZ4NmNFaENzSUNkT1pCbDIz?=
 =?utf-8?B?STBCY0J3bGkvQ3FBRjZZc0I3OHdIVXZPNzBVZHhCT0VlRW5FODN0OWRTR1Z3?=
 =?utf-8?B?V2hrNVdBWWxXOW1xdmNLem9hQk1lcmFqSEZoMk5XTHFrcXRIK21Qd0xMVlpV?=
 =?utf-8?B?NHFHZTllazM1TVB4V212YlB4QVdwSzl4czF6aENnVWpiZ2tCZzJZQlhTOWVN?=
 =?utf-8?B?QTV6NjBQS3UrbTIrN0R5NkRmS0x6bGZBdXJjU0ROckI4NG1PWE81K3lpYW9O?=
 =?utf-8?B?aDRvMXQydTlHVFZLRGM3anRHR1NQLzlxdU5yZXlMY0UzQ0IyUTlaOWNaZzdR?=
 =?utf-8?B?a05vK01Va3pGQVVtREZoekJ2RjNWTzRyYzh4VVdpR01HZk54RVh5M2dkVkJG?=
 =?utf-8?B?T0F4dlZNM0d1bDFyb3VPUWNPVVoxS0NrcG5URnhOYVJ1dXNNekRLVEZRREV3?=
 =?utf-8?B?dDdpK0w4bVVrRTNSN2pZeHJCMXFMaW5VKzdRa1ZsRXpCL01iVndCVy9zL3Rz?=
 =?utf-8?B?Q1d3QUI0QnRYN2FQdTU2TStodUNSZWc3eXkreFJNeUJOaDQvdGJqY3NySlZS?=
 =?utf-8?B?T1ZET1YrTG1WU0FRZml3Q2FOcWltVWVBa1pXU29lZVVPa0ZodjIzNHA3ZmpO?=
 =?utf-8?B?M3N5cmx2T0NHZzl0SmZ1ajk0MFZ4WHVFQUtPd3paMVJmenhuemJMNlhOOFdT?=
 =?utf-8?B?VWJCTXRlcmxsZUJQNVNaUjN4NlFwWUNyaEVnQzZSbEdSQkwyOWVrMkpUMDNy?=
 =?utf-8?B?UzN3V2lyUFNsSTc3dFUwaVllakQ3aTN4SnkvNW8yanNlL2hYRGYva0pjZ3Fy?=
 =?utf-8?B?dVFuVnM2Q3JVV0tMOWNHdWUra2NORG5oaUtabEJ2V3cxem1tLzhGOFRaWVd2?=
 =?utf-8?B?YXpualg4MHBUVDNUUTNjU1RjbXM2L3lLSUdCb2xsK1lDcFFTcFpFZ05lK1VD?=
 =?utf-8?B?ZzU1R1Q2UzVsZ0poVXhNZzZMakVCYlVwMzAxSVgrSFY0bkp1R3dhUGlGMlJy?=
 =?utf-8?B?U2J1RVgweDhTZUxrWHd5Mkg0dlcrbHo5TFg1U2JNR0kwMm40Y0p5eUg5QjBX?=
 =?utf-8?B?REdNcEdiWkxxck5ydUYwOUZSbTBJb2w0TkF5S0dFLzRuNEwxTTUvekM1L091?=
 =?utf-8?B?ekVtUkdxclpoMkNNNkEwQWVDY0FQTzlKQ2lhVmRGVlE3ZVJ0YVYzWFMvM296?=
 =?utf-8?B?NC9rYWlDRU5TQ3pZUkRpdnVvQWFiNHhOenM4ZjZFbEpWUFpsanZ0Vjl4ZWFG?=
 =?utf-8?B?WEJ5b1RwSzFkSjZQQi9RQWZ4d2VnN1dtRUZJSy9JN1BwVHYxS2VmdmtWdVdm?=
 =?utf-8?B?QXdnekpYcU05dG9zVkJaeldzYTJ4a29xMVNTZlhjL2NkR0d5S1VkSHlnZm83?=
 =?utf-8?B?cWhRcXZzY25paFc5c3A0eEllTk83eEh3T0VodXFwZnFhQ0ZGc0RPQ29YUkxn?=
 =?utf-8?B?L3kwa3pHRjhCbGZDOTVNTm9LNFpuSUpvOTBOUlBSYjEyenZGS0hLeG9CSS9Y?=
 =?utf-8?B?SFhvUU42NUQxRlJsUGp3dVZQSnArdFNWMHJBVzg0dENmcHZ6YTc4S2FZd055?=
 =?utf-8?B?K3dzVnJ6c1ptdmZLaHg4SWI2eHdycDdZY1NIODhUYzI3eE9WczBXNjQzRmVQ?=
 =?utf-8?Q?yeAnhyN5IarYZYKpLMUegIHSu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de3dde1-5ea4-483f-9956-08dbd9c67e16
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 04:04:34.8517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXvzn1mYytoxgG6gyKKyOhIynifR1x7sSvydoMt+zndEUZxdtREdSTur4NiMcE79
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4964
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



On 10/31/2023 7:42 AM, Yang Wang wrote:
> remove unused macro HW_REV
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index a2e8c2b60857..969d8ba8b8dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -365,9 +365,6 @@ struct amdgpu_ip_block_version {
>   	const struct amd_ip_funcs *funcs;
>   };
>   
> -#define HW_REV(_Major, _Minor, _Rev) \
> -	((((uint32_t) (_Major)) << 16) | ((uint32_t) (_Minor) << 8) | ((uint32_t) (_Rev)))
> -
>   struct amdgpu_ip_block {
>   	struct amdgpu_ip_block_status status;
>   	const struct amdgpu_ip_block_version *version;
