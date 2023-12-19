Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C7BC41535
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Dec 2023 07:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5319610E35B;
	Tue, 19 Dec 2023 07:51:59 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28C7E10E35B
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Dec 2023 07:51:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifXBz2meGQIFi3KKCaN8eljDyFv/QNFJpLmdNLVOTGc7RlCwp6NoDrTRw+M9K8sVtAo3vgYwdjkfKg4SNkvdQACJNP3h6MzkNcRnFixaMvu0/za7SM8MUMtW6kiSDKrBvP533WVwD0bZllifGProddekYJpU/eOTjzpidNgT+fNQX+1kZGpOzli7iJgE+eA4HlpUuK0PUQkSip1jkqoSuhh80dgqtvUtHGIKywT/Rw1BQzB0YwKXc0TedQSVkCtWi8VWAjmWGNBOMg8p7zltXRk47ilEz25zFuHc8BNt+9LdHY16lhu4x6VxVCrly94IlThAQ8XGPyhjsWYGvOhp8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzPl8sdUHGLdZthoB7sgQzLMq4hDo8/pBqakRJWK3zk=;
 b=ZsBv7Ih1hRerAkYEzzg2koSIusLqz2AD59BkGr0ZWBz3IxrV6C19f4LjXctV5cGVsUTpR0WdTv8kbzX3KlIMN4jc+NOGgO8P/ika3Er+8fvXm+7dFw/3d+9GxxWMCcPWGnaFOtl+4DTSOJWfSWq870EPE09LkEXCpJfm8rMynfyyb9u+GLdd/T9y9ZkjlvFBJ7IM9Foc6TpQ1GBDLDXIM20jXu5zg5z2Lw/Xf5r3HJx0Gz9JvAoYcEUCsGZ23KvGx3YzJ7qV50IypiTPdRUPLcAWUMY564gA9zL9V8pnQ20MImB1YUqHgxfzhLyZp29U+vjHz841J7YJwf2h+8JaLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzPl8sdUHGLdZthoB7sgQzLMq4hDo8/pBqakRJWK3zk=;
 b=dnroWeRyRWUfjArN0ZLNhLYETRn/+0UMh2o5iBekR9BFrKjouoLUx9PCjMvY0j6HxTSQx8+36ZNG3Lch9A866WBSRFxNr3rQxm16++jxirO138PfXOluGPjFSrytYReMGc5AabDm0im+tDSdw4hDlV+701XUIGpzaYXxQZmRLFA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW6PR12MB8836.namprd12.prod.outlook.com (2603:10b6:303:241::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 07:51:53 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 07:51:53 +0000
Message-ID: <9f21761e-4b70-4149-abb0-9733c3962a33@amd.com>
Date: Tue, 19 Dec 2023 08:51:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Let KFD sync with VM fences
Content-Language: en-US
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231218212111.565869-1-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20231218212111.565869-1-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::6) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MW6PR12MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: 79ca8b70-b48b-4c55-6c65-08dc00675daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TSuyZG3OmoSzOHw+wcWUZgvY3hsIFWyAkuhju99NEhiKC/nRq3NuEBK6nXvPob/fcZ50DNbOwu2ILuYv6FbU2Hl9Q0LD/+cJFMHRT6jAZPHy9s4GrTrQ6lgnLbr7fyFruWCi7+f8omAJwHLVovqCMcHCjX4Kxi6J9PRNs407tPn0e1BeLUnKmT9QKKnWN9FhSTkt0g4xF3l3hoBDwbzcK6/fsDnIRzo1yrlNnDimUqf4OPQDNUMwBDLxstUZb57lj4Dtm9udiDBNMKgCHNi+E6NDXFX9sqUpQel4+c/KWkBMcf6MMVHPndZvimyyGHPTYylGgP1rwGr+8ALORHJfT1kV07jm8UIkFpzucskb0+0NPWRt2H5WC7ddEn/XmLxazLiKyEBXeAm9eVH+BNPAdwvDRSIUtLWDbihdEKYTHAUvtvWcuqrwofHcobumy1t7H/Vweumk1irT3kGTIG2H5bDOzX2rP1uPdhbCOJLy87lCpdyT03kWEqILU4bBIQN4SYyDEv/rm3L/1emQ+5wFysci4l6FO9b//xICm0SQMzHdavJyYFDlP/NkjXyAs5lm5wZbXhWK+JJH8She5HCgyLoHPdA/SGfxi6cu6JIVbolP5FhaycJaZ5zwxzPFfm2lj6S0pwZqvBNMsMt65u4xuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(36756003)(316002)(83380400001)(66574015)(66946007)(66476007)(66556008)(2906002)(38100700002)(8936002)(8676002)(5660300002)(6666004)(6512007)(6506007)(31686004)(478600001)(6486002)(26005)(86362001)(2616005)(31696002)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWhoVFZuQnc2NTVMYjFteTdPYnZRWXhueHZsMU41YlR3UEMyeUlxb3hzYVlB?=
 =?utf-8?B?MUdGLzdHU1huYTZGaURERWlYbEo2dDZDV09PN2dCVG5Ec3ExNGFYM3hXbHhG?=
 =?utf-8?B?MGZOdGd3Z0FSb3RVVVczWUR3VzNLTnUwdzlmWExVK203T0dua0ZpZDBXN2Z2?=
 =?utf-8?B?WTdJMGx0UEV1SEx0RVVabjJWcFZFUU1KdXdpR3MrYXQ4blhteThTemNVUmlH?=
 =?utf-8?B?Rjg2MVdGdXNLREVSREExZ0JXU0JmUEFQWU1ha2Z4ZXdaMGJrR044V0dwRTVj?=
 =?utf-8?B?WkF5R1BXOC9pdnNveW9hMXhHenlPbFhMQWlIaDNsUXJyMjM3WkwweVVpWktO?=
 =?utf-8?B?VFZvTEc0WXhGV3lJTEkxZkpBR0pjZ050Y0p6QWdYSmxEUE9WTzlHQW5STFAy?=
 =?utf-8?B?MWJZYWFwU2FsemM3Q1BuMlN5VWp4SkM2ZlRmV3VzUXRWWnNYQWZ4cm01Yjlt?=
 =?utf-8?B?NlRuazBLYzVwUUF0enA1d3k2bWE0d0hIdEZoWVllVTExODhzeTVHQ0pLSm9m?=
 =?utf-8?B?SkVra0xIZUZNTXBuK1JqTHBBVjlzOS9LUEVISktGWVNkVW44UUg2ZVRMQm1V?=
 =?utf-8?B?VG1HTHM0RDFhK1RKNGV5SCtwbjRlUnJqR2IxVWJQN3E0Slk0N21EWEFXTXpj?=
 =?utf-8?B?Ly8yazh0ZmM5dDY2WjdHMzFxcU9VTE91RmFRTzJ1K3k3VUxYRDdkQytCa2Uz?=
 =?utf-8?B?RUZXeWRpWjRuMVJGZDVGVU4yZFcyWlVFZVZsdG1HLzRiLzdVdE9EYkh1bHps?=
 =?utf-8?B?MDZURFlLVkpqUThEdXc4anRZWUxuREJPbnZrSDJKVHRnS3l5bGhOQWVGeXBh?=
 =?utf-8?B?SDJuU01kMGk1L3M3K0l5cWJ6eEQrOTV2RjhkWFQ0OHJmaTNHU0RTOEZoeGls?=
 =?utf-8?B?WCswci9uc3lTaTk2MStaZk1VSytIWk9mZnhaai9pRTBLb3hJQlFHK0hOTVlU?=
 =?utf-8?B?YTdKQ2FiM0JMQW9FK0xQS3lvOGRBSVlUUjRwbHVGayt2RUhZV0R3QzhkRmp2?=
 =?utf-8?B?TDJpV2tRUnNVOVZ1QWI3ckZsalJPWm5RRXJlMHMvMm5ML3liZHYvTnFreFRo?=
 =?utf-8?B?VnMwZFRhK3NKajl5cFZyTXZ3L2xQQmVRclYyWTgvS1A5MWNuRjJXcy80Wml2?=
 =?utf-8?B?Rlg4T0ZHckRKNjdRdnpkWEdYRzd3S21QNWpHdjFNZzBRRE1kU0FiZy9VT1ds?=
 =?utf-8?B?bHZmYkJjN3RVWjJ6U0lUYXJKY1cxS2lXdXRhMGhCR01oSFJUTVhod0NCckd6?=
 =?utf-8?B?Z0RHbjJJcWo1NGlYZndSUnlYbVpqM2QvOHR1bTdLY21zN2l1NThGSVA3V2g2?=
 =?utf-8?B?YklOZUJkdjJ0TG9TR0R1U3lBckptdjV4TmZOYVU3MHhxWktTeUVSQW8xbGZL?=
 =?utf-8?B?eU95ZnI0TllRcWlqc3h1Tkwxd2FyRVNHcDVKNHMra1gxK1FYZjQrbk5WdHls?=
 =?utf-8?B?NlVTc3J3eCtiakVJeHdOU0hBTmhkeDZDd2xDWGtENTdDV25qcElWUlJ1TGJJ?=
 =?utf-8?B?WFNmRzkzanVQekd2YVJDd3ovZHgwNEFFckRaNU9vUUJnWmg5MVJSb29wMHB3?=
 =?utf-8?B?WExqa2ZnTHRObExvNEZSZ1lMUnV6dVJIU2ErK01udDNXTWNYaE03Y0tJNmVi?=
 =?utf-8?B?Nmt4NjBlWVBJeUVqU3J3KzZ6ckRwcCtXTDJuK1YxMVBodnQ5cHQyejlQL2Rl?=
 =?utf-8?B?MURwRzRlZ3VvV3BKMjUyT29Wc0pqa1JQTVd2ekVuUGtEdW1qYkErbTJFTDVE?=
 =?utf-8?B?ZnQ1bEZuK1VtdE9JSUszcTZWdVhIRDNWMmhZMExGU1YyU3BRMGxxaW1yZEkv?=
 =?utf-8?B?Z092YjVnaHd6S3JHNVN6MC8zcVJUdWsvMHpuV0xZbDdZL2tJaVdHM3BVZE8v?=
 =?utf-8?B?SUhYVkU5WnFNNVk0Zm4xVzh1Q0NjUmtPTDFNR2xYQ2ZvUU9OTmQwVHFjeEty?=
 =?utf-8?B?Z1cxK0Fya2dtK0VIVHJZdDhQSDE4c2JDVGVnT0xPL0Q1Y200bWN2L3Bza3l5?=
 =?utf-8?B?RHhYNkE4cjVsdG5KcGZXdFZkaVRkcnhtQ1FDNjk5U20wTFRZY3VxZXBYVmY1?=
 =?utf-8?B?RzNWTFJ3a0JqU21KcUUySjJuU0dMdGsxcjlhM0RPaklkWjUwS3JsVW1STHdL?=
 =?utf-8?Q?h7Wo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ca8b70-b48b-4c55-6c65-08dc00675daf
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 07:51:53.5391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbPdjOBQeNEpHq2fKYhpg4OgODRkoHVTs+Bnz8BAjmapbFK25Bj06cxks/EuSO9L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8836
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

Am 18.12.23 um 22:21 schrieb Felix Kuehling:
> Change the rules for amdgpu_sync_resv to let KFD synchronize with VM
> fences on page table reservations. This fixes intermittent memory
> corruption after evictions when using amdgpu_vm_handle_moved to update
> page tables for VM mappings managed through render nodes.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> index dcd8c066bc1f..1b013a44ca99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> @@ -191,7 +191,8 @@ static bool amdgpu_sync_test_fence(struct amdgpu_device *adev,
>   
>   	/* Never sync to VM updates either. */
>   	if (fence_owner == AMDGPU_FENCE_OWNER_VM &&
> -	    owner != AMDGPU_FENCE_OWNER_UNDEFINED)
> +	    owner != AMDGPU_FENCE_OWNER_UNDEFINED &&
> +	    owner != AMDGPU_FENCE_OWNER_KFD)
>   		return false;
>   
>   	/* Ignore fences depending on the sync mode */

