Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFC8C7EE2E
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Feb 2023 17:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6434610E21F;
	Fri, 24 Feb 2023 17:01:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40C0510E21F
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Feb 2023 17:01:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpgQXp/+YaYbJcGbbUMqW4dyPXCUE29lTG6+gsxWlWfX74r+WQ+Px3MwyYEnu6j6FybyXbMqr9/pQ+M+JFUXIenQWGiL3zZIRmmrGb6qrIshMJQ4cXVdffuaUHUrKJeJu3aGTT4G/DExJ8rZKlfpjwXtodzSk2QXj1ORxCHDl0a7YgzOto6x8mY5zWeAX23WaiZ6YwLMC2RJgd+j7YgedYDblYddXBVscS6Ldu9UC3NGna9327uhKWPFjMYIsbsYHSRSIHCNjWBJuYArekNE7wL5VGopWpwskBj+nhVCnc0hYk9L8dZVKlj+wDnCk1XXUkCP9M7tVlbJPKprF+m6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aql0A2NPVMzg1Kk6swGRsxAcL0CmcIShwwz/w/B8UTk=;
 b=SIqPTOqMzLqDvQz3DmVraFtU+Z1d1s28MZL2W1D2PYpx5KtgjgJSgStspismuA+Z0pwiMJn6YJsnBMqbKQiugGjf4lzcc1K9qu426yclz/KRzCYqk+qsH2KbwCK5fMdrCfzpRDWK5DCCfcf6I06TZNUx9Ln53E17tzynbUdopLwev4i3UnzKJjouP58SqKkSGbqfoGngo0FSyj8G8u243lEFW0Fu74jKyiaW6MLZ16l3SoiBwTy8VKrAvik2aft8nSsXxqE4G5PG7I2lerYL4MSqOMFmM+f0RN+f0AoH2T58EL/xSQXfGt9SGDB5PSjGTjc/3lwrC8MY7hlHcdMAkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aql0A2NPVMzg1Kk6swGRsxAcL0CmcIShwwz/w/B8UTk=;
 b=MUJ5s7dcV2GVpHHRMzfyv9IrbqYWxgZVyUeQn2FhJdYh++53pe2btmcZxh9G8nxb1kM96rSreNPe5mnmT1UmY5w/LTusCC0VhyFQuViz+45mUZ8kuUeceJhXtJDro44FrCdbEeUkNLj1bjKi8Eqws3Ck1NXIIPgrCT6lJBw/B9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 CH0PR12MB5169.namprd12.prod.outlook.com (2603:10b6:610:b8::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.21; Fri, 24 Feb 2023 17:01:32 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::cdcb:a816:4bc3:a83f]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::cdcb:a816:4bc3:a83f%9]) with mapi id 15.20.6134.021; Fri, 24 Feb 2023
 17:01:32 +0000
Message-ID: <2c116178-0709-640e-f8e5-c7175621e018@amd.com>
Date: Fri, 24 Feb 2023 12:02:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/amd/display: fix dm irq error message in gpu recover
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230224165506.2276412-1-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230224165506.2276412-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::40) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|CH0PR12MB5169:EE_
X-MS-Office365-Filtering-Correlation-Id: 5528b7d9-6f36-4021-ce25-08db1688c71d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u+8QOJldODtobkKkjB8BjFOhdvR2vwFXQzWRKvwiUifVhdKS/LN4Fjxjm7OoA8hF3VYKOrRE0UCKa0J38WY+okzXh+9zxDVkOnlDtp1qeColZ3AMq/vW0QyVgCSXxEHKVLtlMHHpDt7yKIYny571EoPA14ts3VhWqNlzh4eKbUqd5HaADWQCc6Q/cE9BtbtcmF3b/gNWTtqXQLwjbguRYkEsCOL3jMmI3jieYMA6P11M62MzlIbQ5H+AFaENVp2w3wKIPBaCGvrMyRU8+/U4S8Egj5FV8NSvtokqf3XQj9kJ+pfUb2osW5jelj0f7eP7zRJ6clZxg3cBIYXIwv8qZOtcYdmALE4e+bULtYoB9mjE88dQcntrz3FYq9bG8VRt9MMH8+eB+GBJt3mhSRh7wmB/a+OK9IgFJkRFJSDh7pj/ep/XLN/abZBZ52YXH4DAwAJAMIInathwHVeSX2Vu08J4KD1Z9oH2YXQhS4l20+QVQW7ahVXFztsXmD6vcihs8NM76fRQs8wG8IZNDVcpDIrDwnN52Q9bzSO322I9coIKu6JFb5ZWEYZqXFceuAJ+59VM6Qqu21lSDCtfeTl764/4+PWXArORBfDQeft9wbfJcn3V5QcocXBOIa8DuWjnTYtjWQEVzioXYOwcg2w/ACr94IArs9B4zNZXCCc5CxGW1KOO8syCO44y1e205L2MjIf2NFVxSonI6yCL5dJXg2srZexkUAf6yHxybd8kN0s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199018)(41300700001)(2616005)(83380400001)(31696002)(5660300002)(478600001)(8936002)(186003)(38100700002)(26005)(86362001)(4326008)(44832011)(8676002)(53546011)(66946007)(6506007)(6512007)(316002)(66556008)(66476007)(36756003)(6486002)(15650500001)(31686004)(2906002)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckl0K0UxU1FNbitpQ0ZPU05ZZnRGMkd6Y3JMQThlb3VJd2ZSaGZ5cVllaXht?=
 =?utf-8?B?ODhldFNZRUQvb3VQQlp1Z3VGMzc2QUdUU05OWWk0S0ZJWXltMGFWa2VZQVIy?=
 =?utf-8?B?QWZLMjI1S3pUTDRqV2x1cWMrN3U0bkpsb2ozVFlvQ3ExSEs3bXFFSzdOM2xh?=
 =?utf-8?B?aXVUNEF6QW5XZ2tzYjNQZ0JNam1RWWpzYVFJRS8yd0FVSmZRYm83QUl5ZnZq?=
 =?utf-8?B?NE96UUkzY09SdUU3cWlvWFRSWmx6RE0yMlN6dy9Yd1pPc1p2aEZrQmNKaXpa?=
 =?utf-8?B?OCtxYk52eGY2QUdyWUxMaHpzYU9GcnpJNzQ3NnJrbW15R3JjNGJySE4xaXRR?=
 =?utf-8?B?Z2NzU3MrdmtUSFgxWnJaQm1zNW5jV2tYSkVST1ZybmJzRVN4L3hLaENYWkZD?=
 =?utf-8?B?cW9zRjhaUmZNQmNqRVhlUzRpVmVxNVBIY1Jwc00reGsyU2QzWDREWEJHazh5?=
 =?utf-8?B?NXNGb2cxQVhHMUVPa2doeFBXUkI1dGtDaC9OZ0w4SzlrSjdibEtURUFzOFZG?=
 =?utf-8?B?YktYSVA3TlJJa1ZzMVpXNFBXNTZOdTJ5WGlNR2ZFSC9kMHM5c0xUNDFzUzhu?=
 =?utf-8?B?NjFkUzcwdmlkQ1BUQjcxckd5VnpkYkJXYVN5cFBnZzJaVVV1cFdzaEdkaHNR?=
 =?utf-8?B?UGhNSTBkSzlNZE4xdmV6N1o4N05XVHpHUUhEd0tRd0tNcGxUNkVXT1Vpc2lW?=
 =?utf-8?B?dzJGclE3SkY1SE5UZmM4SnVoeXpsNGtMaTJvWGlMMFV2QUhZRWtQVkVmQjVl?=
 =?utf-8?B?TzNya2xpK2xDY2lxbUliSGVXSVBadE1BSml2aHFkMGRhRG1sZFhRZ0VsQy9m?=
 =?utf-8?B?VVRFcVR6TS9EVFBhakZrdTRCTWMwaUJvODNuMVhucnNkNWNTSE9BOTZmSS9C?=
 =?utf-8?B?VFB4aG9jeXc3YlhiTDNVZVNVRmY3NEUxQkJLbXFpQnJINlBEVk9XQnVXSDhT?=
 =?utf-8?B?OWN3VGFGd2RSb2x0emNDc1h4YnE3eGhnaTVBSDkwWkc2b010eGRGa2J4c1lN?=
 =?utf-8?B?cGh1V0ViNm9hZmN6QnZzRFp0ZjljbHZ3eU40SXZ0VUpNTFBNak8zdXdSdzdL?=
 =?utf-8?B?Y0Z0YkMwbmZFZUU1dTJBSlFqUGFVU3dkTjdQYnpuNXpPaWRKM3ZWTS9jMTRJ?=
 =?utf-8?B?RzhiTmZoSHVGbHY4SGZOVnZZV0lNVkdnOFN4WXFINWFPZ0dCSkpOdytKM1Vk?=
 =?utf-8?B?RHBqdGt2YUtOcmNNWjhOTFMrZXROTzZEeGNXblo0elJUYmZ6bHl4L0U0aDI3?=
 =?utf-8?B?UWpWZStqQnRUcFNUYUFyNmFPYUdTVzBaSjBvUmFiR3hEOVhZZGlxY3V3V1lO?=
 =?utf-8?B?RUJZRU1zZVEreE5qVUlLL2tBWWlzR25zVWt6TEs3cjRPenNONmhCbmpIN3Zv?=
 =?utf-8?B?b08wZURmUDZBU0w0cWtYNkRBeXpCcFBoTkdyNHBQRWRMOHBrNlBqSGtXQ0I3?=
 =?utf-8?B?RHk3d2dvR2lGY1ZsRTNMZGFzWFdkTkxIbTFTc0x3ZGRTQXIycjhpZkZ6Q1lP?=
 =?utf-8?B?dSsvV1NNc25NcTl2a2pTMGFQUC92alhERVViU0h0SlNwdElJZFZ4WU85V2l5?=
 =?utf-8?B?dXdma1BaZUNuL3c4WXl2c0d6WEtPYnNtNURraTZHaFAzSkxpTTBJZVB3UVdk?=
 =?utf-8?B?anB2RGQzMUd1S3I0cE93QTQ4ZzlDb2FjN2lwTkdmYXdGVzRKVHRnWENUU3h4?=
 =?utf-8?B?dCtEVHZKczhwcWdWMm5KK012YXhEa2FqemFNWWdTbU1jUDlPZDFhajhvNk85?=
 =?utf-8?B?NGp4cDNSZ1l2UkM4bGxaaU8rYWVQSG9sR21OQ3JETGxlb2hXSytsenpMK2pa?=
 =?utf-8?B?cUpDaDh3N3VIV2FKd0FWVWt2ekl6Yjh6citjNmI3ZHRWTEpUUC94eXdhMUhC?=
 =?utf-8?B?ZFNWVDVxeDJLZHUrY2M1cEdPVEJOeFA1cUh6MUw2dk1IZklFNGphNWx0VXpG?=
 =?utf-8?B?QjIvZU16cGo2VndxU0kzenhGMFFlMkxsZ2o2SUp3K1FZT1BDVVJNdFZYcXRQ?=
 =?utf-8?B?bFJYZXhRNHh0ditLSmZZelhVRThmY056RWNJYi9YWG9XRTNmVzRaNUNxMVhj?=
 =?utf-8?B?NGM5V1JJNS9EVjEzZVNxTU41NFJiVjE3WGhLaHYrOVFUejVDbjh2OHJsNWpu?=
 =?utf-8?Q?4pBu0cwNPe/B014ksZ60Rq6eG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5528b7d9-6f36-4021-ce25-08db1688c71d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 17:01:31.6758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JPhSL4cwc2eG98QO13JSy+XlcRWuunY/JRByf3/70J5aNb6dgUfS4g6DaHVaT9WmkmuQaQdrRMQfnmyYFiebg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5169
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
Cc: rodrigo.siqueira@amd.com, tianci.yin@amd.com, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2/24/23 11:55, Aurabindo Pillai wrote:
> From: tiancyin <tianci.yin@amd.com>
> 
> [Why]
> Variable adev->crtc_irq.num_types was initialized as the value of
> adev->mode_info.num_crtc at early_init stage, later at hw_init stage,
> the num_crtc changed due to the display pipe harvest on some SKUs,
> but the num_types was not updated accordingly, that cause below error
> in gpu recover.
> 
>    *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
>    *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
>    *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
>    *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>    *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>    *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>    *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>    *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
>    *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
>    *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
> 
> [How]
> Defer the initialization of num_types to eliminate the error logs.
> 
> Signed-off-by: tiancyin <tianci.yin@amd.com>

Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 79cbf71c2eb3..038302dc1a40 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4270,6 +4270,8 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   	/* Update the actual used number of crtc */
>   	adev->mode_info.num_crtc = adev->dm.display_indexes_num;
>   
> +	amdgpu_dm_set_irq_funcs(adev);
> +
>   	link_cnt = dm->dc->caps.max_links;
>   	if (amdgpu_dm_mode_config_init(dm->adev)) {
>   		DRM_ERROR("DM: Failed to initialize mode config\n");
> @@ -4758,8 +4760,6 @@ static int dm_early_init(void *handle)
>   		break;
>   	}
>   
> -	amdgpu_dm_set_irq_funcs(adev);
> -
>   	if (adev->mode_info.funcs == NULL)
>   		adev->mode_info.funcs = &dm_display_funcs;
>   

-- 
Hamza

