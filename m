Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38480C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 18:45:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EF1E6E851;
	Wed,  1 Dec 2021 18:45:56 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2049.outbound.protection.outlook.com [40.107.102.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB9086E851
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 18:45:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQ58TjlIdiF03OUJja9LvqWabkI6zgMv8Gj2EUNl51ukt+GoPgfhf1FgkQpaueoYKvT28nj/IU/mr7ZjEL/CVvhdQXTfRj382ricqS0LAg5aUvcRIJNwExn5G+MjiXGSys985E8s31i6Z6M3y1Px04qwRytPy06NOYRQt6K+ZLoYlWnLus0Vq09yuUCDoPQbRIw8LwwnrvJnSWwTeIC57gGV9xpRoWeqR3kPTPtBlQ0Que2HelmUkF7DBMAmxt3HurxWH7EPm6v/GAWJFKBRmkipi2GQouo/pAd/edDnpiKmansRXMndg8Xw2sGABApXgcQzAeGWHkD3TbxeFAeuKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNRbLJig4nubTTmAvcORkug45tCjf5ZUFD7NTb0g3Gg=;
 b=TG/6aImXtMNzuePVBhKwOefRx9x3UIIVQPl6JoXkEyT7ShDE7DU+8eTZZArhI8xO3T01YQqPqZNVXdzGn8PCrx3LoxsSIveNNAWV+qdgf9Wx6ViJO7ngM++RCoJE1Kb+IHtr9Gdz4eTYo7XbQk44zFi4vZbIZGIS4PGHIcrf4N1UkLSvH+MQAXZSyRwWizzEb3LAsckkuZnOFVE5fsjzHyOKNbBgNwUYYXT0qwszDE2LzA8M0cIAPrjSfx7w595hdY2GHJHK32p/vLMB8NywU9gfriuqi0N4dUZyr3ciH5wgnQXosjHz++sfKO1IDsrWaMvtUEq9z6J6F9Qp0wSk7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNRbLJig4nubTTmAvcORkug45tCjf5ZUFD7NTb0g3Gg=;
 b=RyUe49WZ/EYP/9q9rT2hgbQRCVunardJlYj6562JJ+yKPe9vrAXNJ78AbpfhI9ke0y3K3ix/e/dfbZ/tqlcYZOzNRRq3zkOVU6WDWYvpcs+3KAwLbK+zXWX5B2P23x+qj9vUF57gJcw/4XMbN7dxgTYUiGLnC6k4rZ/M9XCqg8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN1PR12MB2542.namprd12.prod.outlook.com (2603:10b6:802:26::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 18:45:52 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea%6]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 18:45:52 +0000
Message-ID: <0bf43968-25fb-7303-ad93-e7d79a0105a5@amd.com>
Date: Wed, 1 Dec 2021 12:45:50 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [v3] drm/amdgpu: reset asic after system-wide suspend aborted (v3)
Content-Language: en-US
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1637819291-4159-1-git-send-email-Prike.Liang@amd.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <1637819291-4159-1-git-send-email-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0018.namprd21.prod.outlook.com
 (2603:10b6:805:106::28) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
Received: from [IPV6:2600:1700:70:f700:b54f:ab87:a805:63f2]
 (2600:1700:70:f700:b54f:ab87:a805:63f2) by
 SN6PR2101CA0018.namprd21.prod.outlook.com (2603:10b6:805:106::28) with
 Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Wed, 1 Dec 2021 18:45:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54ab4853-cbcb-4b04-fe63-08d9b4facc9f
X-MS-TrafficTypeDiagnostic: SN1PR12MB2542:
X-Microsoft-Antispam-PRVS: <SN1PR12MB254274AEDA88CA07474923BAE2689@SN1PR12MB2542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MSYesA3fs2w5dhJUxw4TB4OAgLH/p67w3go+/ta0/M7+qaHw6hLb3+SSAOvqZ5E2U5KYv7pzVH4QGJCb+tGn7dmyYG520E0s16VjB92hNa0FS+IR2wkgRmIoDnJnE4VMzQV5FJjd0WJM59OBj+twPyzWf27R/0419gGd0g/abzM9kfNwuno2tR85jw91bTpI5vVFx1jSaerJxDos6nKBv/WQG1fO4Sd88hgxWOYWf7/a8INg+fcvye9/U4M5frNfLGgNlS2Zo/xJCUUyvuAhX8jLbpDW9tOvIvPEYZuehk6R+OgA6N7kVRN/FYQ0Smhqe0CprFrClw4b+ie02l8SSdPs6m53GYOqfyWK1PsnZ1iyAQxK5cSomfHIzN61ml3EQNsJvZigfvZVbB6ua0Dbu2GTFdBZxe55GqkvV20/OaD4ziyfSqVBC1njrTm5zhtH5+niR8/3rZuGJ7UBo5dATAb8/mlxiVQdT+ha9jauAzlBIYL8fTXWM3W5K2807pdzuWTCujnx3bkBT27pjmIulgOhP1nW91wvmcJhDVrDAbmQL74B/mOXmxr13C1tpaJknxT+o+lOvBs2ACUr5kHin/iksBxvcIXA503/dgkgxduzNffKL2ti9O7zrfmSPtrod/oI9tAwEVhO3+gojUgoibDgPrFUJYluqtS2DqUjKFEpCZDeXswG52XxFcN7IXKoJzL67g78HlQhaX1XTcEbDzswWQcCZalioabURNSj+7c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4510.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(6486002)(66946007)(53546011)(186003)(86362001)(66556008)(36756003)(38100700002)(2906002)(8676002)(8936002)(316002)(31686004)(5660300002)(2616005)(508600001)(31696002)(4326008)(15650500001)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjlXZHc2aW1wMk5WdUQ0cWhGKys2bGNDR1FidGtZK2FXSFJJYUl6ZWwvWW9R?=
 =?utf-8?B?cFlubURvNVNkSk9kOS9qb3VnL2xhWjQ3RkhFeTh4bmFXU0Rsckl2SVRIYU5y?=
 =?utf-8?B?M3RlMS9aOEIxVUtRSXdBT1luekk3U2puT2xjVGdXdUlzSGYwbW12Q1FXZnVh?=
 =?utf-8?B?SlUyR3h1enNBaDBtblpSY3JWYThDU1B4NjBTRkpxNnRwRTNLM1JFK2dGdXpT?=
 =?utf-8?B?T1VrditVN3pZdlpOeEZCVFVHbjRiZ0hGTjRyZ012VU9jV2ZPR042a0U5WU51?=
 =?utf-8?B?UnZuVnh6TVRSUjkzNkZ5alg3bTRseGlVMkFnOXVhRmtNY3IvLy9yYkk5U2ZE?=
 =?utf-8?B?QUdaVlFiN0dhTGtrUXNudnpPRHF1dmR3NVlIWXNLYnJ3QzJmS3JoZ3QzQ1JB?=
 =?utf-8?B?bnUrWVVNd1BLbmppMHloV3BnRFl6SEd1SWhvZHZmVzZOM3MxYVpQUVBBR3FO?=
 =?utf-8?B?UXppZUt5b3dtKzlLc2lFNWpiem9kOXRIK1ZhblRqNFFSOEg5WnVSUENwRHRT?=
 =?utf-8?B?ZmJVU3FsU3A3WkZ6UDZjaHB3OWdndjVBaUR1TkozU1dnOWhqaWU1V2FLVEFH?=
 =?utf-8?B?cU1NbE1jeWdpM0p6dlFRZnV2MnNGc2xrcW1UWEtuWnRpUXk4N3kzSU9aeFJB?=
 =?utf-8?B?aXZzNmp2eHk5dzAyakhOK2U1ZTZ2WExsZ2tyZk04emZKNkVxaGZ2enZ3Q3pt?=
 =?utf-8?B?WVlqMDBia2tVU0puUk90eXphWUgyWWFpRDcyRkRvQ3JkQzVieGJnUXJ6d01J?=
 =?utf-8?B?c2RVb2hnbkRaU1RGVk9JSGVkUFpXam5GN2UwUms1dFc5cWhwWWVCSmRBcWZ5?=
 =?utf-8?B?ZWlueTlTNUMyWWc1TEpGMjZkU1RKVDc0WXdacjdDeGgzdjNRelRsVDhIWUxP?=
 =?utf-8?B?QnRxeW5pRHpYbllsTzhzYWtxQzdRemQ4SEcrbGN3UmhCS0lzL1hvN0pPdjJW?=
 =?utf-8?B?YXhIb29pYjRJR3dBWWFBV1RQTnIvcDdQTjJPWmFpOE8zcXpTMGtFdG1MSDdn?=
 =?utf-8?B?YVh2RDJXRzdUOFhmbmgvYkZibDQ2dFhuTkFyOWRZdXMyZDRwL3Uwdkt3am42?=
 =?utf-8?B?d1hoajY5MjFtMHhDVGY0S3N1ZkZqbThLVXp6ZjN2aS9PekZyenVuU2hRenZW?=
 =?utf-8?B?M2x1OTgyc3JHK0VKcktpRmpmOXp1TzJoeUFzcU90ODI2MTdZakR4ZlU1aWJP?=
 =?utf-8?B?Q2g3K25uRUZQR0hBUHZBbVIwMno2bEI4RlNCUHF4S0QxVkZjc3h2V2JiWTdj?=
 =?utf-8?B?MEtYeHZVUU9WNlJsZCs2UXgrSnVNTlJrQkZxZVRHK3hIWGw0ZmdPTmtxd2d3?=
 =?utf-8?B?UURTWndiTXNtNHhOWVBJS1J6cFB6SVBrcGJnOWdsdFZxL1lCRnd0QzFtM3VP?=
 =?utf-8?B?dEtUM3ZwK0ZPRUVaTWFjdEVUUTNnTkxZVW0wOW5mcHNTVDIwWFR0UjNySEJE?=
 =?utf-8?B?SFhvRUFEN0VuOGJnQ1V4SFdxVXJOMWZlTHBSTW9QMHFZQm1KNUhpS0R4L2t3?=
 =?utf-8?B?Ym9QNVRMZkNSaXp1SStVUjV3eFRuYmxLUHREZlROVWloaHQvZmw3dEdzMUVM?=
 =?utf-8?B?cnN0eXJ0YnQ2RTRFd2N6dEFmTE4yUGovU004TDVSTU0vS0lPMTVtRzFQblo2?=
 =?utf-8?B?NWRNdFVBM1k0QnJCOWJDaHVsSUVEaUQ5OFlIS2pZb0VQa3ZTeE80b3h0M2Nx?=
 =?utf-8?B?bFF5amR3c1VHRFd5SjRXQk4xdnRPVEJJU3FycW9qSjlRWDM1UUc3UlF0dGZY?=
 =?utf-8?B?VGREc0ZDV29Ha0hlSWMwZmRVeDN3R0dBU3NLQ0UwNTVYOFpQNFZ1ZWFmd2dG?=
 =?utf-8?B?bzh5RVZjbS8yMklkSUp5TmFmV3NyN25IVHJFemZnTktEaVFKSVRvNC9jMmIx?=
 =?utf-8?B?cC9kOUJtODFUZGdmNHNmS05KWFFyUUtnSEpuNGNRWnNZaEY0VDl5UWxsRlgy?=
 =?utf-8?B?ejd3ejYyZVBFRTU0NWNwbERSdHRLbHZsYnp3ZkhOUTdPdVB2R3l5UE9IMC9v?=
 =?utf-8?B?bWNPMW10N3JRb1VpbVdyVlBHTkxYdFUvelBBZ1crRmVjNnQ3SE9BcGFtTDJz?=
 =?utf-8?B?c3V5R1BOOGt0Q0NIc1lWTTBqTUpoNmRLRFo1UTlMRjN2ZFpwT0tZV0xXQlA2?=
 =?utf-8?B?U0Z6RDZiQjVsN2VveS9FbW1XR09UaWI4VWRwQWIzRmVCRDBIOFVQSUtHV0cw?=
 =?utf-8?B?MGhHTk0xNzAxZjZEQUdTL0MwMnZBZkFTNktpSjBDOUFyT083Tm1RU0NYcWNO?=
 =?utf-8?Q?5SWfZTbzCJoCqBk3NC1ZTaSSo4mqE8IRFaBo2Z4lWQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ab4853-cbcb-4b04-fe63-08d9b4facc9f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 18:45:51.9418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDB3i9K9Nx2Xp8Pg0ALeWWhXucFb2f0uzpiKuhhiA5FjLpAmCWPhGrOvHap+o1PGxPuZ6oIr84Z31XVEfRjQiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2542
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, ray.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11/24/2021 23:48, Prike Liang wrote:
> Do ASIC reset at the moment Sx suspend aborted behind of amdgpu suspend
> to keep AMDGPU in a clean reset state and that can avoid re-initialize
> device improperly error. Currently,we just always do asic reset in the
> amdgpu resume until sort out the PM abort case.
> 
> v2: Remove incomplete PM abort flag and add GPU hive case check for
> GPU reset.
> 
> v3: Some dGPU reset method not support at the early resume time and
> temprorary skip the dGPU case.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7d4115d..f6e1a6a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3983,6 +3983,14 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>   	if (adev->in_s0ix)
>   		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D0Entry);
>   
> +	/*TODO: In order to not let all-always asic reset affect resume latency
> +	 * need sort out the case which really need asic reset in the resume process.
> +	 * As to the known issue on the system suspend abort behind the AMDGPU suspend,
> +	 * may can sort this case by checking struct suspend_stats which need exported
> +	 * firstly.
> +	 */
> +	if (adev->flags & AMD_IS_APU)
> +		amdgpu_asic_reset(adev);

Ideally you only want this to happen on S3 right?  So shouldn't there be 
an extra check for `amdgpu_acpi_is_s0ix_active`?

>   	/* post card */
>   	if (amdgpu_device_need_post(adev)) {
>   		r = amdgpu_device_asic_init(adev);
> 

