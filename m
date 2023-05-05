Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485EEC77B75
	for <amd-gfx@archiver.kernel.org>; Fri,  5 May 2023 08:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEA1810E5A6;
	Fri,  5 May 2023 08:34:53 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9771C10E5A6
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 May 2023 08:34:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oI5n83AgXmzxCZZ1fW7IrfupAu8uJq8JTGGvnBYjuLd26zfzEJBaJRIhJrTtFXJ3TkAHDno+NX/W6xZnQ8oErNZg3k9AVIWq4NK3KCHnZnEIt1/FSQk5d3pY+5EDAatz1G1ZtuJQbhI8/E+sqk8gJy6tqIviHdSBihMNNwm0Ty/vkzfVzcHnMtpvgnvejmPn7+8SRRzkWUKsVZy1QRvqz3GsKBhO2XZIROTiTNGR+oJ8TXcUWX+zYanbkzFaa+EdoQQfuhp2HHSA6TMU96wm+bei4zQK/um9Dj9XGpbnHSrl6yTmvc3QPejZMiZtucBNx9VMRSr0JjIfp0yVUUU1Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+NyIoHGXdKiDFBAbulA564T/isYbEPzNmaSefvZKk8=;
 b=YX9vE/9EfcL/RS+WUxQb+rWtcoN06ce6vxewHO4Nao4b8otCE36JdPGfhhjR/rrRf6rm/3iMZ0E6WOT9j9TZHwTHYc7mioDDZXB7RoGR3FL5jFxWbWtw0CdFrhObsGkalsiYoYb9F48Su6kx72zL2cBBXtqGj+nTfpM9GYH4GSraAACdtDHZZ2fPNs41CWHad/3koooYgGIUz7EakMUKFMnTnVF5vEdID2fbbHGXfhTmQCobXpw0LnqKNpIUGWY8lO1dt6plco1kzCY2egYvzT1TeYGF/Yttqyh6VCUKNJF0lOQAeuPyhiPXZAvuNBTR1BGxdTEXx8uxtEZ6DT/RZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+NyIoHGXdKiDFBAbulA564T/isYbEPzNmaSefvZKk8=;
 b=zBGyV4sR/zDkUPifidTzDGAWSbjLAHa/qa+ckMsYaZioc4u8R7IJV37nLCUYD1Vlfvz1/SCAlrBx6ZCzadKPjq0spbxMkfchqRxR3heYEK3AakNP1cYcOQF3qUXJeFLoBK7pbhNJAPvogR4CrnqxDRnYJO4TIB15K3DV6mjxq6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB4204.namprd12.prod.outlook.com (2603:10b6:5:212::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Fri, 5 May
 2023 08:34:48 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 08:34:48 +0000
Message-ID: <cb798677-5c84-05df-665a-3743f1569d8b@amd.com>
Date: Fri, 5 May 2023 10:34:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdgpu: set default num_kcq to 2 under sriov
Content-Language: en-US
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230505063939.2485298-1-YuBiao.Wang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230505063939.2485298-1-YuBiao.Wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM6PR12MB4204:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6d5a40-7919-407c-695e-08db4d43967a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DPfJ4XnQrHlhsevTV9+3+ViMHXXqntrlVQak+4uEbol6Kh4pt44bJcXRBbYbb4VRGvn1rGi5iB1n5bfEM8/lBuNC9KqCu5hRWvmMWJnVc27anlo/looxhwkpJ21pvWJY+6qfFTG0zWE4eXAIaWAvC6poPAvgSVb3ZVGipxWHTieaN/X78v3Xkkc99ejn35aBre6KlynOqrO9dQmquoo4hBCDxbyAapDQwtEPybco9Ko5lSmLBxhpOWKPAPvFM+G5ZsGxYdLnNPROs7Cj4zMu0OuD+PkLYWnmOeq0QUrK3Y5YNBkUtN4S+x+WcoXwWAFCGE5uNAf0dFznedvCjPUjZbKzn93YYrj1LyH2kZNKofV3Fmt4PgVso0G2G5wFKJBNqRv5j2Itx/rhPjIn/7q283eBpSDwmtxyLtoDwT8u8TR77fljjxKiqaHY65NiRBjIIqQxkiN5t0zMYkq0sBDhEH8SgxK2RUk5GiKm7gth94FWSeARuUdlfs2wE+JlTRn4Tvcl95mD/XIkBWakpFFOfPmK48+A83gZ7a13Fohco9VSgzhPutFZeh7sr35OLLrRJ8wnvTrj3Orp8ATGrWozj9aGrMrKYsCoXogU69bgeJkRfH7NIMxFiGjobH/GnmJmzQZXdCC07fz5A8ivLGB7pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199021)(478600001)(38100700002)(5660300002)(8676002)(8936002)(2616005)(6666004)(31696002)(66476007)(66946007)(86362001)(66556008)(4326008)(6512007)(6486002)(6506007)(2906002)(186003)(41300700001)(4744005)(36756003)(54906003)(316002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVMxVUQwUDloeE9YSytjN3Avc2x5Rnd6c0lPYTBBS3NzS09Ba2VFM2lqSmxk?=
 =?utf-8?B?SlZRcEhFN2tKc3JmWTV4c2x0VVR5bm5WSHhaNk1iS3VkbXVOQzJwZHBRdk1G?=
 =?utf-8?B?TmEvTW04N2U0MUtYQXliK0hVS1pZUWJkVGpWUWFobkE2bjFzeE1sVGdLVndX?=
 =?utf-8?B?Unc4NUI5SWl0YjNjcjBLUFNQMHpTeWViWkxHdkJYbXJOcmNxQlhvd1hqNlhW?=
 =?utf-8?B?NHJaTW5BWGxsU3AyZEk4RnFNQUIzdGFEM3BMb0NlY082dk9JdzlJRG9MK0FG?=
 =?utf-8?B?QW9PRXcrVXNjVXl6M0g0NWQ4WisvOTQ5aUhaSVlTSXVOWTBuUnM5Z2Y2dklC?=
 =?utf-8?B?eXIvTGl4NXlaWUNwcXUzbklxdFNNVWY4ZE1jMlBTYWkzMTVaTzBqbXJwUTBE?=
 =?utf-8?B?cWVZV3FENDBFamVUakU3Ty9EQ2ZpUng2V29qdnBWSnRGN2VNRVV3UFQyaHE0?=
 =?utf-8?B?TjlsODY3Y1ZFcCs4TE52enI3MFJuMlQvS3VUcHE0Q1pCcmdXRHpvR3NaMG8v?=
 =?utf-8?B?RW5FT2VBWmFBLzNaK3Q0ZUhiOWRzQ013M0g1REhseDgzRHlGb0NDeC95YjU5?=
 =?utf-8?B?NzBDOTNsZEtzMzNDc0Y3dFQ5SXVGVm1RZjVucVFyTkFsOHlwT3p6T0M1RjJL?=
 =?utf-8?B?OGF6eEVuMmJRMDVTOTFhNzh0Z20va2IzTEZ6dGxINkRiYlJVYTI0UitxcDlI?=
 =?utf-8?B?ZzMxWFYrY29mMXRQWCtYREl0U2wrSzUvV2lsTURUOTNMYXdyRWJGS2JCVnE0?=
 =?utf-8?B?ekdyV2MzYUIrSXdhemg2V0x3WkpRaVNkVEVSeGxhTzAyVFVPS3BMRm1ZMlVh?=
 =?utf-8?B?V3VYcVlvb0c4cmEwRUtPaEJ6TmtCdE9keHY4b0U0clNscm1hZWRQanZrSlkr?=
 =?utf-8?B?cHNLM21TM3JydFU0QmdiaXpjOHFMN05LOFpFTGNGY254VlFHQjNtZ3RPYjl2?=
 =?utf-8?B?b0E3aGZDQlJ2bGNwcXMxY0l4TG8wTjhkZzdWcDF4MG9GZHh6WDF5akZQYThE?=
 =?utf-8?B?THRHTEs1cFpVNWVZaE9qZHY5OXhyRDVuelhRczZET1lyZkQzNUVZdVFHZW0z?=
 =?utf-8?B?RnBqckFNajhrVTBUVTN1K1UrR1g5UGdNSkdSNWZnb0tLRVhtYjJHUDlPNk1x?=
 =?utf-8?B?YVpyMGJNNHpVT3M1ODYyd254bWdXVXZ4dEhkbzgyUTdZYWJHVGVMV2lLbG0v?=
 =?utf-8?B?QTloRmVLSm9VTkdGakFRamRDWTljSWZWVDVtZEtXOC9VZ3c3Qk1KMUFwK2pJ?=
 =?utf-8?B?VEZiQWoxTDRzMEppZGNLcEVkWWUwVG0wSFNGWXJCOTFUaWpmOThYOCtMenAv?=
 =?utf-8?B?U0laaGVJazQwU1BXNXdJM05LUTBjd3VTYm1rNGdkVEh2aUFCM3dNUkdHNVVE?=
 =?utf-8?B?TUFURFlqVUNVaFdvLzNqdHJVVkM0OWZzUjFMUVpjNTZYTUZ5NVhRZllHWGNC?=
 =?utf-8?B?UEk4V0piTGtaZHN0WmtDT3VDQ2Z3RnV2akV0UkNUMlFaV25raURTd0NncnRU?=
 =?utf-8?B?ZWVNSnJMaVptSlhOanI1TnFwZnlWMU50ZE5QNVVIdWFiU3NMcEtmOXJycFY1?=
 =?utf-8?B?VUNTZWEybDhUNk1PRWY3a1BUTER0cXM5bnVxTWVGb0ZRTjZUTUtYSHpBTFdt?=
 =?utf-8?B?MDZZZ1NZRmgvQzFoMTFWT1RwR1JPVnhtNUIxYUhINlBHdC9GSlZYOGNkT01O?=
 =?utf-8?B?bnRnWUk2c21sUVo1OVFmcEN1K2s0VVJhQnVlVjFmeDN6NzF2ZWhFT0NTUFA3?=
 =?utf-8?B?ZU5wYU9pTkFxcE82dEZEMkZJQUtHRWlpSnN1NktwT2RaMVg1Z3lSbk1WS1NZ?=
 =?utf-8?B?VUt6V0lQMFZwVC91MTJlcHJIVGkyb2FSdWlqQmdTUk9PQkVQMTlzakZ5UGlj?=
 =?utf-8?B?Y24zT1NjS1JVOUZSSXZyOUFPeVBlVzM4UjJYa1JwT2dONG4vNW5WWTBQOFF3?=
 =?utf-8?B?UXdUKzY5Ymd5OTA4VWNYWit6Vm9KSktkU1VRVys1WUZXYWFmM0cwREE4dGdr?=
 =?utf-8?B?NGFPOHA2b0tvQlk3TWYwaENXS1RsWnkwNk5MUDdESGtGb1FXQVhLTlBsdXAy?=
 =?utf-8?B?ZFlVQmRRVE1zR09mZk1YOURrKzI2RVhKVFBXNExBZituSDdlV2RDV0g0cU1O?=
 =?utf-8?B?Z2dEazIvUVNTQUhpSVl2bmFlRUpjYWhaT3JXMnMxV1l1SkMwYmxkQzV5eWow?=
 =?utf-8?Q?nMbnp1p2AIS5QqigjyzNnom9erhflQQiaJZtixotpIJR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6d5a40-7919-407c-695e-08db4d43967a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 08:34:48.7901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: miWqZxRwjqrbwxyzcAvfIi+q+J6UsWZVwbue9LDDv8bbcv0HMQhNn+W9jirC3500
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 05.05.23 um 08:39 schrieb YuBiao Wang:
> The number of kernel queues has impact on the latency under sriov
> usecase. So to reduce the latency we set the default num_kcq = 2 under
> sriov if not set manually.
>
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 1311e42ab8e9..d0ad7cb0fa05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -68,6 +68,9 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)
>   	/* enable mcbp for sriov */
>   	amdgpu_mcbp = 1;
>   
> +	/* Reduce kcq number to 2 to reduce latency */
> +	if (amdgpu_num_kcq == -1)
> +		amdgpu_num_kcq = 2;
>   }
>   
>   void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,

