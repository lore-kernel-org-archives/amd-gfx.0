Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8767C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 13:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 326D56EE9B;
	Thu, 25 Nov 2021 13:32:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDDD36EE9B
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 13:32:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lt2fK3oUzbqJcRpYwMGY18Mnkh0rzEV0Qq+3CZkPE30pehOWtzZR36/4pxeLS8pW3NKjF/NBo32ys5clFSFXCwo3yHgnvjg7QvxSE2sQ8Fxvu0x1I18aKfg71W8bMaG60BfkI877uYnnqdaVH37vYGh2CHaJp0pGjkeTFdfX4hPeoedtI0hGSaoLmoSFcSX58akMiHOSUuW+nVHKls52uZMG57fiXl08AjlITxmZ4/VH6OeOqKtECmjiPfGKpnlCVC1DfW8F3qdQVs/4ZYOSQOuRjKZ58JqkCys44PMdlW7jl8b4DX85bedzAhQ401PtNpux2rCoQmVuU4UPKHj1rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbryevOwfSpXN7UwW01ffk22eZuiAMyzCIAAL80xH6c=;
 b=MjAmBdHWYK0MXw2gtPH7fa4VTcFaUr+0KzqyR0hEg/wF9NChLwNzB9BxLMgJpGmK5CTLFIwsl4Qn8+i/+QsmUiF//77ajidqYuHfXX6CDyBkJtwZA6Q7CrO7Pa5NM4LZ0bSk3Ay7MXQCrBrvRm/QCebxxedIOV7nJHWAGP8unO7Rck3RQhplWhpz8iLftb1L71UEBhsuXC3fshRPvbTHg4NSmMgCm+ogA2ITbsdPt8nN6qUQTjpDu03VswOs2kEwQwUXjw6UTy/+Hd1tr9NZmFFCkSxomwPb4O6eqwg+D3hfxhX25mGIPqJS6UNCk72Cpbi7ga06Cv+hsJmUFHfJgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbryevOwfSpXN7UwW01ffk22eZuiAMyzCIAAL80xH6c=;
 b=irshR2q0YJuyON/ZBtfXWT7LH7zXaeEtgyKt9xXIeDmSvK32h+pMUhdwbkNZUoWItTPNxV+OnTZDsRx5NLt52CK/6ut6U2eW/oS+zMpspSL6ewgAd3PSvOOmKmVU6FRnE30vmZloeqn8+gryoKFM9SO7zDize5yOtqdv60tNhoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3836.namprd12.prod.outlook.com (2603:10b6:5:1c3::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 25 Nov
 2021 13:32:38 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4713.027; Thu, 25 Nov 2021
 13:32:38 +0000
Message-ID: <a5e2b887-2f61-247f-b279-3db57b68766b@amd.com>
Date: Thu, 25 Nov 2021 19:02:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] drm/amd/pm: Add warning for unexpected PG requests
Content-Language: en-US
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211125115049.122591-1-lijo.lazar@amd.com>
 <DM5PR12MB2469D8345E74CB6B2299130AF1629@DM5PR12MB2469.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM5PR12MB2469D8345E74CB6B2299130AF1629@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::27) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BM1PR0101CA0041.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Thu, 25 Nov 2021 13:32:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acd07e97-c9c8-42e3-ff01-08d9b0180c08
X-MS-TrafficTypeDiagnostic: DM6PR12MB3836:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3836CC075EA83B943AFC9C1D97629@DM6PR12MB3836.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HLwTVLR/2ZJ1jUV+ccUnm2Db7IvfhdxboNDQR1/UUYDDpMws5AmkZWTwJ1z6vF6715CuzDjYs2WN5GsqQbaC8XBILhxCCsIJ0Jg2RieXWG0AX2AxHLBjz/2uY7C9nuPDszg72I4Xdw8P/UE4nsrVkfS1HpPC5JT/BfgcSYQj6lvOP5tt4+S6XnmjERDzt6hVT/GcgZZLhQnofmiYrxSr52ao3gbJ3pa2zmU0fSdwASFy0XOzJiF+7jBlGqAzIhQZEPkNe+tWTiBr84v1nr02JnycMTTSCbb0u1N1qAwQe+VguratJOwTdrjrVn6eAaFjISDJ+ogMuF4NfQC1jbP+Hg6P03Eme9qIIkfgTYqXRr6mrS9ALn93+lgEALDwHapWHsAX6hLzJhci5Nt50tKz5VJducGAPdIGIYDJQbDKzGqL6Hm4zuCDilgxso25kelsSwaSx+VTfAsPTVV8eAssBRfKKnwu8OFdD9FN1G3+RK3UVFNqB6YfjPM/c7i4vR5lBOMCwp0CmAYJUyNaHMxcGrgVtR7wdJFDzlMkaINBdVztcrpa6yIEhhtE0ENzlxteqoNerjCAlz+sed6ICl2oXVu9QBhzAj9ZZLEQNKRinMVMbRbiJR3yEmPcRXmy0JX3gFlyJtqPJ3AUOZjAmvLLrQSL0n9kuxGcC9OHN6AKebvVQEP5s4hKYLJuXY5dwFV5RzOI699ZKqyAYl1cmSEODFg9lnecO5utTYG17iXnhQE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(110136005)(54906003)(36756003)(66476007)(66556008)(66946007)(316002)(2906002)(16576012)(83380400001)(31696002)(956004)(2616005)(4326008)(6486002)(508600001)(8676002)(8936002)(31686004)(5660300002)(38100700002)(26005)(186003)(86362001)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDVJdnNuU3FsRlU2UERwelJHODNKVHJJL0F2NXp3empPc3I3K1dwZGplQmF2?=
 =?utf-8?B?THIwSDdWQ1FldnVvWkFGNzhwc0VOSXFtK1hZRFBaMU1JdjBnMVZYUndYRVJ0?=
 =?utf-8?B?Zk1EaTJsRHpRWjB3Ym1Kb2daWDVVQ1pQTEZ6MURldkJPNjU3aVF0NGFiTWN3?=
 =?utf-8?B?T3dzdGVsdXZVYzJ6MHdPNEtpdER6MStGVWdsWTdyMjNMcWFpNGliNzQ0VHFh?=
 =?utf-8?B?anJqbWJ4OWFoWWdvV1RSOEJmNVdBYzI3Z1Bld0h5N1FNWkJDRlg0UFhWVWFk?=
 =?utf-8?B?UUNCQjRPS2F1ejdsTWdVMi9nTGpLUVduc2lCaVRuUDF1YUdkOUQwckYvWHJV?=
 =?utf-8?B?Tm5SVTlHdmlKcU4weDE2WjhWSEZpR09GQ1ZKaTNwQjJ1NlJhd0pvYm1pZlVW?=
 =?utf-8?B?dm9EREZVNURvNW5DWWhmWGVxQXRqUzRrREVJWjdXeE5JOE5CYklVeGxIa0pF?=
 =?utf-8?B?QkhmRGRtYVlodmxDMVNraGVBNlVWRUFrQXFleEd1VlNLOUdsVC9EdnVZbXFs?=
 =?utf-8?B?T1JvZlZUY3F3eERLRzhGT3M3bmxuV0g1WFJtQ20xZFRLRGdqM1Mrc2t5eEJO?=
 =?utf-8?B?ZWxiUmg3OUszQmlzei9Tbk0vdWliclN4dXJQdXl0S3ZlSFJpS0UzRWNTQ2RM?=
 =?utf-8?B?VElDdGhmRnJOajFWQlAzK2VKU2FqYzkveU5EayswRzBnQ3NXVWY5YUtGTDh4?=
 =?utf-8?B?bnlJQUJDWElDZUxqdGxXTTZHSEY0WmE0MEJ1R0RxalpLdW9rOUgvRDFtdEZl?=
 =?utf-8?B?WHJlY1N1Ri9ESG85TDZtdXA5ckRJdVlsSlViMGNMb091Z3Fkb1B1eGNGclRo?=
 =?utf-8?B?MWpBN0xDOTV3NG5XTEQ3dXUxc001QTFFclZQOGNYY1hqWENkdnQyUi9DV2dU?=
 =?utf-8?B?Q2E5aCtqOXF4T01CODRxSnc0NnY0eVhrUWZ6SDdmZklXSkpLeEl1R3N6WGFt?=
 =?utf-8?B?WHpRWkl6aUxHVTcyc1NqaExFNzJIcDJ0TiswM0VKMGdhSDVjSVYyOUxpSVM3?=
 =?utf-8?B?aC9TcEtCYzFUQW9TSG1jYkhjZkhTTk5MTVFuZU12RWt4enZhTSs0OVZTVmdW?=
 =?utf-8?B?ZXdCQWdxdk1sekhCRm5qcmlBQ2UxV2dzYU9vMkl6MmJCbUVWZzlBY0ZPVEFK?=
 =?utf-8?B?cWtpNGw5eHllVFRqQ1JjeEs4dGtNd2xacS9za0t0aFdTTDV3aCsvcDhwTEVU?=
 =?utf-8?B?SW1kc1BIZ3Bkd2gwcnNKY2dsL2JiTzdORWpqUVMwb3ZYNEpvc1ZIOFVWdURP?=
 =?utf-8?B?amxFNVlSbEovcWk0cGpLRDJIdzN0c25uZnI5dFkxSVlVclVsb2UzakdQYnRx?=
 =?utf-8?B?emtHUDdCcDAyb0FIR2k1dFBHa1BSelZ1SElpREJZRTRrZjNYOU40ZFFQM0ls?=
 =?utf-8?B?UTNBR3R5bjRWVUpZQkd6bURSZ1hLb0NwTlhyRE9LMFhxcEFlRHJTVnkzMWg3?=
 =?utf-8?B?UjczeWdkR2luYjJZWjM2aktTSWFFUXRYSDJsUm54ejBMTXNYMEQySjRjQ3Jx?=
 =?utf-8?B?K2hodElreXA5L2UyOFBKT3Q0TkwxazY5MjZ4M0ovSVQ2ZEo1Q2FkYm9HYUxG?=
 =?utf-8?B?cTZrRGNQaEZuQ1lJaFZ2S0ZrYm9xR3BNdWhTUkhxelJZYXpqMlRwRFpLTjI5?=
 =?utf-8?B?UnBZNEh2R2J0Y2FhdDVPNC9kTEdndVVMTkpzQzNuYTAxSk84a096MGl3Z0xw?=
 =?utf-8?B?eWhjaTNhNjlzRXZRanB0ckpCRnhrclZ5LzNwMjNZYldqSjJEOEw4ZzN1dEFS?=
 =?utf-8?B?TGszZnJsekNCQnhBN0ROU0RQQldVbFlFc1pBNjA0eldPNndRTkRaWEpTNTIv?=
 =?utf-8?B?UkhLT2lueXY4eWloR3ZTZDRYRHl3NlRJUlZFdlA3cDNQT2tTMFJYMjB0UTVH?=
 =?utf-8?B?UGtwb2VpT3pPS2dtWUhvM29kWFhOMXJOYlJ3S29pdlhYUFU0MW5tYmFPOUVF?=
 =?utf-8?B?WjkvUDlscHg4U2NZeUtJdXZYT25CZ2tlRzJPcGJsSjIzV1A2T21nMFo3ejNY?=
 =?utf-8?B?azdOK1hpWWZPR0FJcUltNSswUWZrVVpGSDh5blQ0TFhFQThsR0EzUkkwbE4z?=
 =?utf-8?B?WThiS1VadGxFS2VDUThJVXFiczR1U2lhRmNIV2ExcGNJN0U2Njk4cGgvSEVQ?=
 =?utf-8?Q?p88w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd07e97-c9c8-42e3-ff01-08d9b0180c08
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 13:32:38.2772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lwSpzDIuXAEICGs71nUWQ5wNVU41zW20A45qKddmMmlHkrevPIuEKsIjgFqoeD/A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3836
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/25/2021 6:52 PM, Chen, Guchun wrote:
> [Public]
> 
> Use dev_warn to be mGPU friendly?

The intention is to get a trace as well along with that. There are 
multiple paths to this function.

Thanks,
Lijo

> 
> Regards,
> Guchun
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Lazar
> Sent: Thursday, November 25, 2021 7:51 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amd/pm: Add warning for unexpected PG requests
> 
> Ideally power gate/ungate requests shouldn't come when smu block is uninitialized. Add a WARN message to check the origins if such a thing ever happens.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index e156add7b560..e0f8ab8be975 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -277,8 +277,11 @@ static int smu_dpm_set_power_gate(void *handle,
>   	struct smu_context *smu = handle;
>   	int ret = 0;
>   
> -	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
> +	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
> +		WARN(true, "SMU uninitialized but power %s requested for %u!\n",
> +		     gate ? "gate" : "ungate", block_type);
>   		return -EOPNOTSUPP;
> +	}
>   
>   	switch (block_type) {
>   	/*
> --
> 2.25.1
> 
