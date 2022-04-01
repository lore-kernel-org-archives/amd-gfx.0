Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1277C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Apr 2022 11:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3420810E08E;
	Fri,  1 Apr 2022 11:53:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD09A10E08E
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Apr 2022 11:53:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lERlDhX275ldWJFQcCxE5QOjuE9NC0ajudma8QMC1EKFKqV0wv+SxBl7JpWNAkAaehqfvxyTf7Twssy0OZdnKu49Yf65lnrWk+YUw+Sj59fYZjYgNae34HaxbKeuXZOIM+BJRGrq2yP1D4V8OzT/CQxRXyY0D/YoKKMskUhwkKRfucxLaKvs20TMwD3Pe2OwCAdkBTuIBPFNfO5QoDI3sTHigG3a74lJCw3HwE3pGwojJNkd/h1cuSxecAUijsQg2do74IKLZKQmtot/7NTWs8Fu4hNmPFsIoAbJggcxnMf8aafvJo7cpqA5gSQ2b2dFQBLCwA/eVAdMo4XbiHvhAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDDJOfeoDkwWKTflWi6C+Kc/BFiAF6l7Hp9BLaFxzuU=;
 b=WFWDIkOwmp+pslKayooxNN2u4I7oFMnoKqeia2DFtSrm0GZMR6uE0zTfUvsDWVAjMvbrJ8b8yr1ZuucXvfUtHkPFWV44AEuXtXBu3oX1Kkb+ICzYg5ri61+LYjANxDjpBnOKkRjgOdIJkUKUbSTaPoQORHdNNJt4iYPAANnPupTtSmmNMh3NH4x1Qim7TlT5rNvkOnvv2eN4SYgklQIdlQHjpYkYuWUMRjYl+7d7fDZ6kojAGMwyaDu0w0hDaqSBOr8Gw+pvHf2SjrgOUCdMmZ+HbqgO/lS+gB/w5uxW8jl/LwkVj+7wnMnjONVFVyFRSe/O/4h04rdDJ+9V8QQq4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDDJOfeoDkwWKTflWi6C+Kc/BFiAF6l7Hp9BLaFxzuU=;
 b=QdTYpuk529q+qHlCUL8FmtekkJvuXSukRCfJjgyY1HoObMNUalqVTMks9weDa/947HC8r5Q6nBpYtn2e2gj9/R2qQ9EBkG+pkHtqMCL6zIxd3DnAkYUfZ68fYSY9TINVef3knEQzyiypzzbpnFWyMW3CnpM5VEbskWWoVmNqYkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CY4PR1201MB0149.namprd12.prod.outlook.com (2603:10b6:910:1c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Fri, 1 Apr
 2022 11:53:15 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06%5]) with mapi id 15.20.5123.025; Fri, 1 Apr 2022
 11:53:15 +0000
Message-ID: <3f4eb7d0-2e48-a814-e939-a245f410f9c5@amd.com>
Date: Fri, 1 Apr 2022 17:22:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amdgpu: don't use BACO for reset in S3
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220331145623.1854199-1-alexander.deucher@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220331145623.1854199-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::11) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8404682f-ac4e-4d64-3207-08da13d633bc
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0149:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB014934F6E2748A976A212FD097E09@CY4PR1201MB0149.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IYHBpVzLJVBxHYLqtjI0Ty2lmUjD7tsR2f8l+KQijXXE1J213xWbnj78Jh2vb9GI0TPxsbpbhEnGB2WecdngRaSisWlNZRrWSVpTgRPzRY/UBz1K8RZpscgfcybg+yxi7kj1GZexBm0iU7cSKTWwbZJUeJqKtN7QmTNbPJXZjOk5xCiX37yy5uCD4Tpj/bj5WMF6YF+z99vEIK3soPoFdcK8NY1/4JJjAGzaoUJ707rapp1BWgmaDPwKR1RnIu9nPDc9SZRhaQHo1Utmv5ggGtRJpv/G1kkIWCoK2a0hdPylQ/q08Kq7cIv2Jz8k4Jc76aSu6Wu1JBgZynvZcXMviMp7wDTCxX/TuI17vSv6hMMStEqXGkpoQjxc8y8z5FtY9HmQ8nrs6QOEC2t2bHVuAi8biu2RJFxL9VDhc2DQmXOPuIw+D36zHnIweqsU1+TiSkdOYHeWvRIocfari6ZObKTR+r3lfg0cloeIpmsig45WrW9t67zJns+237j/cMjpHa/JY/5gQhd7bCSUy+lySMcggnygU//hX5C2bOynmVgLlf38iU5AtWhHDftlowAbb+VKCvlcFqhr+jIqTsSXc2MOqquSuVF8ctXp1Vxw2RJwpKyLrC1SDssfhsRNmqoEbc5KbbdvqH2S033pXFO3Wy3mVE4o6PQQjP4TAhfZosF/pYEQPhwLe0abIJFlnDleesKX3mifs+lkWnGRZagswAqujCywe8gDjoTB8h+chMXwNIk94NI/tRZ1TT+UL5uM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6666004)(186003)(2906002)(31686004)(2616005)(6506007)(8676002)(36756003)(26005)(66556008)(66476007)(66946007)(316002)(6512007)(508600001)(8936002)(38100700002)(83380400001)(31696002)(966005)(53546011)(6486002)(86362001)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU5tWllIcmJTY1lYRDhUbDE3UGNXOWZKNFlGYjlUNjB4KzUyK0l1aFEyMDBF?=
 =?utf-8?B?T3QyRFpsODZTUnVEVDVwYnN2SUpETWIwTVVibG1PR3oyVW5OWXMyTFcxdVBk?=
 =?utf-8?B?RGM0YU5MeW1GVXJuaXo5ZUZpc2RLMHhQa2htaEFmNjBJb3EvQjJxQXh1Y3B1?=
 =?utf-8?B?SEpwNFNINkh2SVRxWVBYaHE2VHF4akUweDlXTGk0dVByaWRZV1dSbk9RVzBG?=
 =?utf-8?B?aWdNcWdWTmtOd2x6NFgzNnJSNGcyRVVzaVJsWXYxam8yektzb0RIOGthZ3JM?=
 =?utf-8?B?ZnJjelFQMHJzS29raFJ3VVJmY2daWWJxQ3lkd2xQYjd2aUNkdThhNW9kMytk?=
 =?utf-8?B?L21aaTgzYjIycmhuOVJzSzlDWWc0VGc5emJlUVcwTmRlclBlNkUzcHJMYmtU?=
 =?utf-8?B?b2R0REJackcwblplaXpkbU81RzFWM2Z4VWxQWXVDNkJUbkh2Qk9iNHN1UVNz?=
 =?utf-8?B?UnJBZUVQdk5TV1BVVytlSFJjcGVwWms1bjA0RHg1UHZ2cFN3enFEUm8rSE5N?=
 =?utf-8?B?NjhCNGg0Yy9tYncrdHpNOEV5b0JGMkY0dStyWUR1WDQrUytRZXlKUWhTTDVq?=
 =?utf-8?B?c0lPT1BodlNnQzJ4dm50Zlc3elhGcDA0cjBXQU1kVDkrei8vbkRCMEt1Rk1i?=
 =?utf-8?B?SzhLeVpjWWhFZURpazVoWjUrY0VOUjZMYUl5THNLSzRVN25SNmU1UWU2L04r?=
 =?utf-8?B?ZDhvWStJNnMrREptb0wvbWt3ODBaNmxLWXJPOHhmMk1HMEU4a3RhNUltSjdK?=
 =?utf-8?B?V2JtNWVYTEJRbDN2SWlYM0pCbnkvV1hSS01pMmF5d1p3bURoMlhYRFllSlFS?=
 =?utf-8?B?b0ZMMnBjdEsxQ01taVlyQ0ZaU2d6bDdJV2plS2c5emlkYTVwRkZRNlBRV1M4?=
 =?utf-8?B?NmV3eEdYcTNqbG1HNFZvWnVMNzJpL2JFVVA2NFh5cVNsdW10d3gxNUpsOEVM?=
 =?utf-8?B?bGJjNnhxdkY1TVpuK2k5QUcvZXprOWd6ejNGUjNDSHVsWU5JM2E4czRWY0pl?=
 =?utf-8?B?cWpqTk5qOUVNNVpac29KcTZUOThVNHJsYXZHSUprK0NrUEM3cnYvcEtvZkt5?=
 =?utf-8?B?OStTVGtIenlGM2Exa0FnQkVVYWd3eHZSdndSWXZGVXV2STJZRXdMdVdLSCtv?=
 =?utf-8?B?SXYybzVzRkFKcEtmL2xWZ1hFNnBmVGpMR210aUxmWDhuU0NBdGF4VVJ1QVA0?=
 =?utf-8?B?SDgyR1ovL0c1d094NkxsSEszVmhxNjduZE1rVlNMd3IrbXJQUTM2S1hsdU9x?=
 =?utf-8?B?Z2NwU0oxOVZEZDNlZ3Mwa1BTVHR2ckhiaGpqaW9SSFRLcVlibElUdHZ1Ri9E?=
 =?utf-8?B?NzJoZXBLSzJpTzBueHUraWpqU01GZ3dNU3FablFSdldwaURISFRvYkdad3JG?=
 =?utf-8?B?dUJjQ1U4Ymw2dTJSZ05BVHhKdGs0dGMzSmgvaDc5eWZHTnQ1Z1JJclFJY1lM?=
 =?utf-8?B?eUVQWk5LME5vN25KRUdtWE9KcEVXdmRoMEI0RlZJcnFhL3dkRXBiT2ZpWVh2?=
 =?utf-8?B?RDUvQTVYckZjQnk2MzdSZC9LUURRdHdaMkQ0cnM1K0NOUllZUklZN1NYcXJF?=
 =?utf-8?B?MEwzbU1mbnVKbHpzOVZaS1dNbm52T01wdXd2TEJFK1JUdEhXcVVicEJhSXlQ?=
 =?utf-8?B?OFJBTjFoN2pCYWMvYzlIUTErT0Y5d2FVNUFBd2ZqZDJlbTVSdzAxV29SS2xz?=
 =?utf-8?B?dm16TXkvVFc5SGhjbDhkT3EzSmpDVVduRWJzT1YvMHduMFRJMng3b1RhUVdk?=
 =?utf-8?B?M3hDaVd5cmJDZCtiR1k2MTZJang0NmtUMEVkem04YUd6NVZDMEUzK1A0RWJY?=
 =?utf-8?B?TUVGMGRXWW12M0JLU20zL0dsK2g1dk5XNkp4S3dqbUR0YlJNWElXRklhSWJE?=
 =?utf-8?B?VG50NFJnMkFrQXlXYnA2bVcxRHZXM1djcDA4MXNNR2UzSHV2VDZadERiTU5h?=
 =?utf-8?B?b1ZuTWNCdXkzcTVEdHU2cGlJZzg1ZHRGVDVBWTAyRGZwUjdpcXRYTXB0amcy?=
 =?utf-8?B?YUllYUV3SkVSY0MreVVkNVZmL0w2QWhDUzU1ejU1UFN2Wi9hTGkyUlh5V1Qv?=
 =?utf-8?B?VDJTaDV5a0VnS2VBQ3lBZDRxcUlJa29HU21mZ0t5Q3pGaEVuUmxMQzU5NVI4?=
 =?utf-8?B?YnpxS1NhQjc4Y3lLdkhiR21kVXhaVmJRdUFaOEJxUUhmU3c5Ly90ckxGMVJY?=
 =?utf-8?B?eW85d0dkZjhPdHJHWkdZRVFhcWRvL214TDhld05JMGMyUytOVjF5ZnhUUDRa?=
 =?utf-8?B?aTgxOWZMQ3pVelJYYWdSQVRpaFRQZ3g1RDJjbG1wTHZiWG43NE1rTGZ0MlUy?=
 =?utf-8?B?UklLc3VIU0xwekp1WFNUbk81M0xwT2Q3d1FTUzh3WTJkK3lhS3FUQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8404682f-ac4e-4d64-3207-08da13d633bc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 11:53:14.9652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/7hny5dzcezhib7uekaDUXCUZEUT96rbYRRXvCgrOcE7Y4znCqE5P1mGFCCcvQf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0149
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



On 3/31/2022 8:26 PM, Alex Deucher wrote:
> Seems to cause a reboots or hangs on some systems.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1924
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1953
> Fixes: daf8de0874ab5b ("drm/amdgpu: always reset the asic in suspend (v2)")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index c73fb73e9628..1ff6c42fb110 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -173,6 +173,9 @@ bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
>   
>   	if (!pp_funcs || !pp_funcs->get_asic_baco_capability)
>   		return false;
> +	/* don't use baco for reset in S3 */
> +	if (adev->in_s3)
> +		return false;
>   

Suggest to add && !adev->runpm to the workaround.  For runpm supported 
devices, most likely it should work.

Thanks,
Lijo

>   	mutex_lock(&adev->pm.mutex);
>   
> 
