Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F047CC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 13:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62E6C112C0B;
	Wed, 12 Jan 2022 13:30:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23E68112C0B
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 13:30:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kghB9tBo2lX1i6fIBD/GcVAy5GUia0i3tl1Ef6sPQ0KFZrH9OqAxC5t4Atn9Gis5pWEud3GyqKrhWQjsSvH78ik5stJQ30K3D8rEed9CvzmC2UF0zOYpmoqQI3rW09yuknS6426V9IQUrSD+8tljR/7SpuAzH3A8+6BZS8v18Ik5Aqmwrex3/3x9ctL0G/isuLY5iYMAf1vTFxyTcQ5TNzAX1QGROGDbhlbRF+bINRxfedPbs7fUqmsJwJoq5/XV9NEG0uPLp3WU6CLyez3kS38UIprrbsSzZwq26wA0NURp6l6KGJHoehIm+P16cGBBZixcO0gFFIXbHVdCnJpt/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTpbk3+1sNd7xNoJBbsTW4BRraU7biJBgYjalT1XSic=;
 b=SJrk6Ni+PN7VSK21vUuENjDTk3XCAMY+KDv9b2orjk4EmMz1xz9JXX+1TBzFhC9+K06OXvKtus244BjK05Snf3maY5otlvRSkLOKnc4Gc+S3N4gEowPqAJSdskZkI5o+IpNCjyrREDMyZMiSizV0iUZNp7hv7LW8A4nqMS5JSLrWs1114TOXk1f//KDb9A5xErxpnky//iWxg5ZMjDmGp44Y6QOA4WEdmuAwOKoPjJN+tIZoApo3AUiTcq24ZECUmVTWlmo2WLTK2EMTYH13gOl6bnKnmgKILB+ICkpu1kVe7D4KlLCbRSNa6Xj8w9eTzGJLw/IDP4bgTn3DipiJTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTpbk3+1sNd7xNoJBbsTW4BRraU7biJBgYjalT1XSic=;
 b=iwtv+yojJjJsSC3bEecfJj5198JLXojZDxgwK8s92yc/+1QucOawyefy+aZkOuDje0KS0d82E1EYe4Vrhys/7BvpuMFTw2Nhbkh5HCXfXWohW5sv09AO313x3i8TKhIjGsBG0uoT/0Su9sBZiJjgu3FCD6luJSZ7NJqQtHV85Yg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BY5PR12MB3762.namprd12.prod.outlook.com (2603:10b6:a03:196::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 12 Jan
 2022 13:30:50 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda%5]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 13:30:50 +0000
Message-ID: <fc67e059-6a99-0050-dd81-df2bdba98af2@amd.com>
Date: Wed, 12 Jan 2022 19:00:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V2 1/2] drm/amdgpu: Add ras supported check for
 register_ras_block
Content-Language: en-US
To: yipechai <YiPeng.Chai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220112103832.2910237-1-YiPeng.Chai@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220112103832.2910237-1-YiPeng.Chai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0010.namprd19.prod.outlook.com
 (2603:10b6:610:4d::20) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ccfca55-fe91-4bd3-684c-08d9d5cfbfaf
X-MS-TrafficTypeDiagnostic: BY5PR12MB3762:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB376221C7E4BDB442EA58D9EE97529@BY5PR12MB3762.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Akb1bVLG4gm23c+T/fMnjmVuEWc8fogZBFV66Hj/B6+UlgFioAa2Ro+AKRajJn9/Bzh1T7f6FSZ9P65NawtvbgE7oiAHcFmmdR+EdLs12BKDqRbunpf62hAGKuzVn5AOTopWQnzLjG28i1blS34hkKDQBXLHsSGkZfXfrw4XtrDcZ3HOSfmuMqh4GMQ1guOEeejCngU4zK30v6mbHeRiaP4oU7HOxwZB6qjA9vJPe8c1ttwsNCqeT+nFR9FLLQJ8rHsTVanQMWQb1DKnBOBcYo68cXumEnbDeJ9oauENptkT5BKWY7QjTvESGeDQjS+0PVHKkfqsDsq5VIKxHmL15PKM5Jp4rxacS8kgo1rrBfeTIUzOPzqh445neB/EcSld4iEgZpZUwfAzfig4YYA/YT/6v9ZQ1GkFFIuJbLsjJ1KunJR7NqP08ncQrNfxhOFG46bcJmZxYZnMA+6bdbUTgEF5cKmx4s3ty2hX15avEzNhfB+4CyGhxWXRWZ0PlWhhie5OEs4q+jDKXAOFbfLLJ1KFxexNEcz5FfdB1lYlzOevVsXx0+csqIQeQ3eq297pU0LI9CrsaR3PSyL84y0IhGPZdt98ONJFoFLtU28g+qYTCdRGGKZQAEt0qKnXhExnv+pa4TAqpjogXJjSe83Ea+uZ4av5+PxHGz/gjqp0B43vC8R+DBbfTACCE/8ImrVstAhT51L7M8DU0c7+G6XMsAJlsBaNS5R4ekv9u+mcqcI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6512007)(8676002)(86362001)(316002)(5660300002)(38100700002)(4744005)(26005)(186003)(2616005)(31686004)(2906002)(6506007)(6666004)(6486002)(508600001)(53546011)(66556008)(66946007)(66476007)(8936002)(83380400001)(4326008)(31696002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFpKSWxCZXU4cENzT1MzbGFLTXBKWC9pRzdGM0FKckR1S1VacHhienYrcjZV?=
 =?utf-8?B?YU9ZVzFOVTd0M00yejk5VEhVN2poOEExencyRVZkYWp4eHJneUNUK2NzTElX?=
 =?utf-8?B?ZWk2RkZVUTdSUlVjY21ZcDQ5K1hGK2NVMmlBUGdoQmNPSE1oWWNTK0ZqMXlQ?=
 =?utf-8?B?Y0k2SXVRbkpDVHFwY3pxWnZvS0RxeGJaa01XT1BKYXJaR3BseVlGekhzWWl2?=
 =?utf-8?B?cXFNVkwvYTllNHRjc0h6N1lZLy9lckZtaE1GRXNBZUtCbXVhRzAvc0pVaGFq?=
 =?utf-8?B?NktRUEQxWTFrSDF0ajEwMUJwc1VYbmhqV2ZYWmthYTR1Z0xqN3JwV3RvWDFr?=
 =?utf-8?B?cGtsdXlwSDl5Wjl1TFlBSE0yNGgyUThLcEkrRWFwU2l4UEk3VklyNUlpRmdZ?=
 =?utf-8?B?TUdoWDRsTlBZSURGRFFNTjFUL2pyRysvd3VxMDVvRE9WMGt6blZYeTk2Y2NO?=
 =?utf-8?B?czQrMnBSbTBsQXBwclZwSFBDbUovV0hNY1NNRzgrT28xUW5LTkxScnZzMDVu?=
 =?utf-8?B?eHBuVzdtU0RXdURLeW95NkFpK3FpU1pFdTFlODlEc1hZZjVjUlJvdlBzTmN1?=
 =?utf-8?B?NnJORzA0Ump5MkcwZXNnbHBlTTBxR1VoVFVzeWdNWk1HWVkwbHNXWFVXMGVN?=
 =?utf-8?B?T2pYRXpPWDVHZXpmYVJEYkJjN1AyZHEzS0gwUzdGWENWRVFJS3lCemhEOEdP?=
 =?utf-8?B?aGlZVU1ZUEJBNktZaWM0SnZESjlMd3NLMTFHS0JJQVZDejZPUkhOTFFRa1Zw?=
 =?utf-8?B?d2pKRDNlTTgxM3NlRzB3OEdYRFVmMzlZY0ZqQ20zUnBMZDhMVlJaSXlhY0N2?=
 =?utf-8?B?YjZHQitER3ZnSU9HQVp1aU5jcTZ4a24wVzI3RENPM085ekZjUHVKci9qMmRM?=
 =?utf-8?B?Uy9oS2NDOU0zZnBacjkreEx4MndrYS9kTmhmU1FpME5EdDhtZ25mUlRMZW9V?=
 =?utf-8?B?c0UxUmxXbkpJVWw4QS83K1lrcU9pcEJkNFIxQ3hiVFgzQVJjb2g4eWhXdm5s?=
 =?utf-8?B?V21NcXBEV2puV3lEcHJPQ3MyZjNNMDNkL0VCZFVnR1hmeTdkclFacGdQbkVt?=
 =?utf-8?B?S0QvbVREZDI5SlJGMlVUZzhncTRmSkQvbEhpMHo5eTg1YW5hbUFKa3JSU1M2?=
 =?utf-8?B?cTB0a1pyeHFRc0YwY1p3UGhXRUFDQVdDVmxnZzFCeElpMUdqN2FEYnk0bHNY?=
 =?utf-8?B?L29nLzFObndZR1VXdVZJSkNoVjduV3dFVHhVbTBmSWF5ZldDS3ZERkZMQjRU?=
 =?utf-8?B?Q0c4NFZtRW1YbUZ4R2JWRUE2bFREL1NVYkp4blpvM05DKy9qOWFEOGlnaGJ0?=
 =?utf-8?B?cVJaalJDeVZoUkdzT0RjQ3dKZVhZenQwMFVEZ1JPamdhT090dVAySkpXUkEw?=
 =?utf-8?B?OVl5a2RhWEp4Y2YrSWZDbFNWdS80M0ZkLy9pY1NwYzlLWW9HYzdaVktEQXZB?=
 =?utf-8?B?eTE1UzVKeDRtSm04TG1XRFJoMTNxaFdQSWJoMUgzdFY1Z2ozTkgvVUFCSmFX?=
 =?utf-8?B?NXAvUmFyVnVvdGxuTzNNUWo4MjlhLzZkT3VlNWFoMHhJV2VRdnYxRmVjYlU0?=
 =?utf-8?B?WDFtTERlN1JkL3QxamFyS1dLUkdKSnBhb0RqSkQxSU9uaFAzVE5TSmVrWXM5?=
 =?utf-8?B?YVllTGlBelBJaGNNaFN6aDNqa1cvUG1CWUhxNlNTUWdaVnIzTUxkUXh1RzVp?=
 =?utf-8?B?d2ZvekpqQ2QxY2lVaDE4V1NIRGw2dUg0S2J4VWcvUy93QlVTL1RIK21kNkF5?=
 =?utf-8?B?clY3Q2Q0NUV1amhuaDlJdkh0alpMV2lJWDQ3SEY0MlJlcVdaeXVxeEJQTlZW?=
 =?utf-8?B?RllTTGFLdDI3dnVHOXFZeUxCZnV3YlJ4SjR2cGNGb2kxbzJ4eHE0Njl1ZzhK?=
 =?utf-8?B?NXNMNWdxUXdtc0VCQlQzYmxpOTdKdG5lcWk3eFVWVWRvSEg5cTNUczhCdmRw?=
 =?utf-8?B?cWtCWkFMQW1nM0ErR0ptbkJBNEwya1RPV3MwSElwT295ZTlhbUdXVHJwbzRk?=
 =?utf-8?B?bFJZN0EvYSsvdnJLWWFlQ2U5SjNRdUFZN3VtU2RkS1k2eEJEWExYMFF0aVhM?=
 =?utf-8?B?YUt4TC9DdGtWdlYvTWV4UTE0aisybGE1Q2JqSW51RUJGejE2aFpnNitZQ1I4?=
 =?utf-8?Q?bPOo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ccfca55-fe91-4bd3-684c-08d9d5cfbfaf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 13:30:50.3963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYfNpEwUFS5K++hD3Vwto6PDsIrqERZvqf4lTLc+HDuhdffffffbKXVEPGg6uU2z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3762
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
Cc: yipechai@amd.com, Tao.Zhou1@amd.com, John.Clements@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/12/2022 4:08 PM, yipechai wrote:
> Add ras supported check for register_ras_block.
> 
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index b1bedfd4febc..614ae8455c9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2757,6 +2757,9 @@ int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
>   	if (!adev || !ras_block_obj)
>   		return -EINVAL;
>   
> +	if (!amdgpu_ras_asic_supported(adev))
> +		return 0;
> +

Why to do this check here? This check can be done prior and IP's ras 
block can be set to NULL so that this function itself won't be called.

Thanks,
Lijo

>   	INIT_LIST_HEAD(&ras_block_obj->node);
>   	list_add_tail(&ras_block_obj->node, &adev->ras_list);
>   
> 
