Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EAE8C3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 15:31:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 061B010E012;
	Mon, 15 Jan 2024 15:31:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 567F210E012
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 15:31:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZm9SGztomkNj3D29+32UH7w0URLmilKrHJPIRn0341swwE5P05kKqkufoMG4WbQ93dhxdUeRxyRN3ahj0E2nY0lAQ5Z//HfryeHVUF6hZkULeSJIbVUibKex53hx5jead2kb9wWLQCAlwoiDFCsNnht7OPGXTYKve5D7PHNKgnbHfS2TrE4ePxx2WVhXsWmdvPnTF3Ky+hMOACYGV+3+po9Aorb0k6avFHC2W1XhFyK+FoSpn2juMqZF7M+ee8w0gQyotzmiUUNY3SdtshQhpLmGt4s9gpStHUnxZF0L/HpR7Qz1mByINOMaXDWM6OqzD+vYsjKKNdfTsne1EG6mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gg6NXVhx8ZEY280iGgwqRHsmuoe3kV10V9edjLbAQR4=;
 b=aqO48706LFArhrY5LDNTi4roRKFo8mDIsRWLiXAPjYQar3bs89dBYD33LAbuM/SGtCzqsCvJqom/58JrbX6nZ8Db67J7SvkUuvnBJh+YCpvcSzPbSkkzTPcZcM1s1u9G5rp6N3M16zri6KH5KOLUnmOAcRoSaaPyTiqyGELfavCnRVHXoBH1ZqfSNqXwHGK+TOQVAz8lSglPA82c7VediU9eC9KLnVXxeVx/skBX8bo8UJSRQkPH3dk9qYB8f6juCaSEQzJjy2YxWupGA0fj2VXbee746Q/apfH3Wx1k9Xm6JziBv2dPBBeSKl8bLLnZdQTFnhuYBG81c0lHx7NVrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gg6NXVhx8ZEY280iGgwqRHsmuoe3kV10V9edjLbAQR4=;
 b=rEJhP8Yf/jrhAaTubOMb0SDpc/7SoEKSpQu6GhSE1sti5XqR0q6wJmZmPsJegohf2aP2plhlfVmxUcKYCJE50bqrOUjb9wUdNXxB1U+NsuowvrAwd6YD67uzyc/Sp7bJtQfoU+z9hlpO7BMIWsEzNs66M5Zln5ewPCsk6NAPt7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5101.namprd12.prod.outlook.com (2603:10b6:5:390::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 15:31:31 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ed98:3dd5:fe85:ead7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ed98:3dd5:fe85:ead7%4]) with mapi id 15.20.7181.022; Mon, 15 Jan 2024
 15:31:31 +0000
Message-ID: <b4e605f9-adc1-4e20-87eb-706be0fff85a@amd.com>
Date: Mon, 15 Jan 2024 10:31:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: init drm_client with funcs hook
Content-Language: en-US
To: Flora Cui <flora.cui@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240112080516.291675-1-flora.cui@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240112080516.291675-1-flora.cui@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::13)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB5101:EE_
X-MS-Office365-Filtering-Correlation-Id: a920859d-5ef5-4f96-25d0-08dc15df0c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aBuC6AWMoG1rkXgZi2QIonSwmkRLTVkYaDDjO8V4nS5Eu4Xe9pbB7jk5KSj0h2Ns/55XYS9aR7ZPzbc0xyoQ2A2SViI+sx8nOXRYS67VlYmjQfciLAtLZcK8P0/k0sGXfb2vSdjLynzdwhOAAVaCoNIo/BvIAhGQFQ5F/zBRsS8mZR1Id/J/s3WeEzRlOQN982uDwtriGO7Q9O6G5y8LJ88G+bAx/lmXbLE5FshEDDfykzvdLwcjS/gfDiOT6IetwWWRgcDJwaqNvMM5V2/v+yxUWupY4QotwL2yBijLgWNNNeTQZDILsZuPsWDAvnPWemEIk2jUa9pU/m5LwpQ8I7Dj+JrB9/bYao4JtDYU/3uZdmhD46Wpy56knMQNZuYxNqvR8CRUI5XDhqNCVEWqODdpRjnT2XoDAkTUo77xaT0L1LHu2qWIzk3p37KYoUxdUyf8LfNujuomuerYCGydWdiw3ycCaI7OrbqXKlxtiCWZCxpLdX+sgr/zh2rxCL2E0zrNzKnb3xptClQve3Gcma7lnG8cAdhQZ77Zh2bAoEB/3r6fw1yhuHQYwOZ/zOwwAjtJ/xFPxsDs2VfNwuR/F1D8RMgCs7pF9+IDQ9D7Wfbez4LrIeltrNTAd4aow3hHvIgk4LwEq0Zy5XdhTAOjyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(39860400002)(346002)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(31686004)(6666004)(478600001)(53546011)(6506007)(6512007)(26005)(2616005)(86362001)(31696002)(38100700002)(36756003)(41300700001)(44832011)(2906002)(83380400001)(5660300002)(8676002)(8936002)(66476007)(6486002)(66556008)(66946007)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU5UMHN6SXJhUW1paGdvQWlZMmZ0ZEdXL2xEMUlFNzJqQm95bW9HSTNXa3dM?=
 =?utf-8?B?SlpsRlQvR1FZbUVGK3ZuNVZ6WWl0UVZmM0I0NDlmdEt1NnJuWUNXVUgwVW95?=
 =?utf-8?B?VXJNL1RmYnlROTRQckxFcXdRSmhhT2lMNCtRZ2h3M0tMTi9QazZFajUra1lF?=
 =?utf-8?B?bWR6NEhGQVNqQUtwUDVwZ1dXUFdiWWxmckNnTkluMGxNMzRvVjRScVV5NmhX?=
 =?utf-8?B?akM5UTlpVVplOXpkSE55MU9LblJLOUJtcklmS3ZWd1p1S3ptYmlhUzVwdjMw?=
 =?utf-8?B?Q3NDekYwQytiVDU5czJHUHVZTkk3Q29ESDJZTTM5TU5yY2gwa0N2YlhRMk5u?=
 =?utf-8?B?YXBYMXhsTkZoOHZZclVvaktZSExid3YzY1JxLy83WVhRaVA5ZWJyK1g1WnJB?=
 =?utf-8?B?d214cmVTVldYZmJuUDJQazZVRTQyQkZUbFFnRWtHanZVVUJiQVdtWkhtZ2Z5?=
 =?utf-8?B?bStudHd5ZnMvbUc5SUVobFdqUTJwN1d5eGJmQnZhNmlxbmpZRDV3RkxvVk9y?=
 =?utf-8?B?SjNTV2p1cW9FNktCSWhHcG9QRDh1UElhbDVqQmUwendhd1JnWGdJZDRZSDVo?=
 =?utf-8?B?U2phSkdXV2Y2L0M3ajJiZXU2TkRvTUM2SXdERDkxUE84TThpV0RXZksvbXNF?=
 =?utf-8?B?bXp4RzFPWUNHUUExeFVQZ0tpSHZGRUF2NURHd3NSMzM4Sk0rQkFOWXY2R1NE?=
 =?utf-8?B?Mkxvejl4RlhVWjI0QjF0b3p3dWxmdGUvbkN5MGVKLzlvRm5SaDFjT1dvMU1m?=
 =?utf-8?B?RVVoZTdlbWZ2UlkxVlo1SW5FWEw0dzFYaEx1SmtlZ0dpQ2psNUNxVlhjRjQx?=
 =?utf-8?B?NWpiVHROdWVVaXRNT0pwdVZaN211cVc5Vng0ZUhIOGt6L3JZd1Mrdis5QjEv?=
 =?utf-8?B?cHFLSFVqZGV0allHTzdNSXNORE0zSVZJWnVXUlllQ1hDVURMaFZmL0d6MFJH?=
 =?utf-8?B?RXhBakg4ZU1aYVE0NE42N2F3TEp4U3NDVnJ5NFFaNWNsaGNGazJEWkhQSmR0?=
 =?utf-8?B?RloyR0grU3FXaHBtWFVZeDh6NWxDYmhUcUVsWktubkNjdWlHQVQxdlBGNVBF?=
 =?utf-8?B?UlRqVU9Xbml4T1lZWER6ejUwZlR4MmhCYUh2MTJNVnRKRjM3T2lJbG5DSjBa?=
 =?utf-8?B?VUUvbnZDcVdqV2d0MUE1T3JXWTZIWUxHTGc2ancxZGFXVThtbkNvSWdJeWdZ?=
 =?utf-8?B?ajkwbUs0TnhkN0tVdFVLZ3VVYlczWWNTMWNaL2xDMVh4S0tEZWRwK2oxcUVz?=
 =?utf-8?B?SE9JWWs2T3JPcWZHSDRtaXp6T0JsYUFZYVIyeU14aVJzL3puTHFxNGh1dkp5?=
 =?utf-8?B?ZEV2NGJxMHJoRUJOQ2luczdhdUkwcmVkdjI3L1pMb3h0YWx1dHNMUVBHRTd5?=
 =?utf-8?B?cFNWUHF1Z2hDSVlhcHNNM2k3YzJpMVdsVy9sbUtEdFJ4TTVMNzdneWJmek94?=
 =?utf-8?B?RmEyaDc0bFB4OGFtTVd5T0xBVzZ6ZXZsYjBNVmlCQjRZSUVZRDRDRnpWTmlp?=
 =?utf-8?B?KzAyWStGZjFmbVp4MWRvbjVlZmNCVmMydEd0cjZkNSs5T1o4dTI0MlJuWHcr?=
 =?utf-8?B?MThvb1hsVDZ6VkRIdVFtS0p5NHcxQ2FHaUErSHJYK2xFYVA2blNyYzJqRFpI?=
 =?utf-8?B?VFV1WFQyck5yd05RTlJ1bVgwV1N2R09CaU1uUVhJeThPb0ZLOG5TK1E2UjQz?=
 =?utf-8?B?QVBBYzBXVXNkVCtKbTZkYWdLM2tsUm9YK29mN3hSUWs4dmJjYTRnY3FUc2tj?=
 =?utf-8?B?S0o5Sk5TZkFla3B6bkR5Vkd3czVuZ051cHVzNXZiYi9tOHBuVmlYdGVaR0RQ?=
 =?utf-8?B?Vjk4N3RBRzRMdkozUElFWEdVc3JVOVdRVUwraTNEbnJWZ1VRU2R0UzYwTjVk?=
 =?utf-8?B?cmxGWTJpTkVLS2hjc09UYVdBUTFZZCtpMXFSTEtuT1pQejdQMnFtaGtFVVM4?=
 =?utf-8?B?WVhXaWcwczRRNTJyME1BakhjWXp0K2hBOFB2NVJoQVkzdXlobVorTTZDWmR2?=
 =?utf-8?B?SUhhVDNERGlLbmtVU1VzU2ZlN1JwcVRaL0FoQk5ocC96YU9IeWREQXRHa1E0?=
 =?utf-8?B?MXNIV1BMbzVsVmJHRDZ2NVArY0pGaUU3REFwbzVOV0pEdXdBVWYxTEJydTFX?=
 =?utf-8?Q?tPoh+gk1k6r82mA51u0iOxcFZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a920859d-5ef5-4f96-25d0-08dc15df0c8d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 15:31:31.3646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/40dc9/GSDLWhIGSH49lZp/C3QM1JRUfRClVEXJG5vDErbwr+dq2r9V0cmrRHsWfQRTpMC2Kfvd62eVm9/KtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5101
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

On 2024-01-12 3:05, Flora Cui wrote:
> otherwise drm_client_dev_unregister() would try to
> kfree(&adev->kfd.client).
>
> Signed-off-by: Flora Cui <flora.cui@amd.com>

Thank you for finding and fixing this bug. You can add:

Fixes: 1819200166ce ("drm/amdkfd: Export DMABufs from KFD using GEM 
handles")
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 067690ba7bff..81af6bf2f052 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -138,6 +138,9 @@ static void amdgpu_amdkfd_reset_work(struct work_struct *work)
>   	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
>   }
>   
> +static const struct drm_client_funcs kfd_client_funcs = {
> +	.unregister	= drm_client_release,
> +};
>   void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>   {
>   	int i;
> @@ -161,7 +164,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>   			.enable_mes = adev->enable_mes,
>   		};
>   
> -		ret = drm_client_init(&adev->ddev, &adev->kfd.client, "kfd", NULL);
> +		ret = drm_client_init(&adev->ddev, &adev->kfd.client, "kfd", &kfd_client_funcs);
>   		if (ret) {
>   			dev_err(adev->dev, "Failed to init DRM client: %d\n", ret);
>   			return;
