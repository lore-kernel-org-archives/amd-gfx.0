Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB15C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 04:42:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3370C10F126;
	Wed, 11 May 2022 04:42:59 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BB2910F126
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 04:42:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShtSsG2217cpP2BTXB4I2YqE6TuApY08AXXcZHrgmwh7/TPnw4BsLdP3c9BNYDZT/4CIV/ymfje/m61cn3Gg7uOqSLOxYQyaV9TbghhZH1vs6YjaAeCmotB8esdMKawZLKT5ohDJkf+K/FxO0M9Icp5xY8TMrcNvxpV4gVzEtoPGaW/dIP882ydkXZBQH3yPux9PHmDPkw1hv6zSdofcnuzMIZMmFYIXPpUZsxl8WrMkh8zi4QhoT9GSk8TU8dOZppMvjoHP3VlfwQvvoX2bZTiwmUGeZb5ZgR1Xc8Na8+WJFHVd1nD1Z6EeoIoblYs9N/F1ie6YDKU5Nr+qSKQ7TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuxkpFfuaD19Kwv1h7Sc1SCba5awFQQVr4g+dYs6Kss=;
 b=W7jtGPiiGGeeiWxLP673k/5Y+rdir0+0IvNgVMsy7Sz4+26DGlWR7mmJFKs/vbswwXQVIzEIiJ/OA2sa+D+VOYhPxAqC/ZWyoeog6kTIROpOS9s8OYDubrjMWxknYJY6864xchpEkMBpPNwRbA74Ds5Rn2EfWVg55z8tWVSjZLad4TCHvUebtYcoG/cOMGD+hQY7RrY1Lj1BZH3BhIUVffUZuY/751dX7ZK21j2xldBKW0xF1W/D+mY5hUkyrpjhN8H4qq3dkV6zvMolBdmSoT0ZHJGd2v4NfJwym8mPM3sRLXecq6hgf5m9gWEcXaVSxKucE/c9KLlbFDKxWSqQEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuxkpFfuaD19Kwv1h7Sc1SCba5awFQQVr4g+dYs6Kss=;
 b=v04WAN+JDLVRls9k0IYUPiUY4oBw+sUeqBqOJXAzaIiMhuHukk7w/28zFA/lMWYzdFEtWg4nbXS0NuEciwKxGzNymaPeglldz2z3lpmfuWuQcV+941wTTUEZi9Y5fvqmkRkAxBmEFUOvZOSD0Hfbmcer9eJcnwiruiNJ09OKQOg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BY5PR12MB5527.namprd12.prod.outlook.com (2603:10b6:a03:1d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 04:42:55 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f%5]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 04:42:54 +0000
Message-ID: <bc1e5968-587e-e128-413d-3b5b841c9975@amd.com>
Date: Wed, 11 May 2022 10:12:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amdgpu/ctx: only reset stable pstate if the user
 changed it (v2)
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220510143744.622588-1-alexander.deucher@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220510143744.622588-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::9) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 846a99f3-f5ec-4845-a738-08da3308b688
X-MS-TrafficTypeDiagnostic: BY5PR12MB5527:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB5527C85C6DA349CA4B606B8F97C89@BY5PR12MB5527.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2PHhf1WoPsiGCud7XHrjj8CVfw+goaaUgcLDOeM5uYFZzbyJ5NjgrAnRNlLa8voY43jmUopcx+ORpz0Ihh8TlPz5FIn/FJ4WFcEFLHdpuB0eohdI5kG7IdtE6mG+3LUDRiSX+Rx+F08PO8hXE98xeHMjgsTJQLYJ/16k1pPmIKEMX56gX8u+LuoBJw9KL4dxz+2etZf0W2V5Vi9Afs8KnWW1aUGlHQgfNDG8Mua22Mvu9UMoZ8bOOubL11Dw3+8gBiQeartvSTdMdwL6yP7X3yehalywskHlDdg3Y659j4+IvVANzRq5nFufe6APAu2tjhVekt6syxNjhTp3aYfowbUTbZKkblE6LX3V8JSK1ojOpsnuoCoTIqtPVQMrG0IlFnZR0H6/G7r4GPTYJWYS25qNmDLByTdbP0gMRHiHFCPtJ9oXSevLE104ah80apqv/AXBhxnzYs3m893dwtBARelnkYdO7YIOGxM+5el1C1tHhPdG8QjU2XqaC0gJtP4Hd+QLGrwzNX35ikGL3Ee0rnaZySQPFYmdY4lK9lY2sMhpYstThdy+UxlfVPZG+hfY2OELp5lEDB2qXMDMYloNVd8VvfPH4GMiFrMHxMnqYn+/vZ53I8EJ6utudwmh9nWpkWLb4PAHiwQaX8ljh/9GgA3WJNgKNlB1p8qo9oq67xkmCAjToZg00g84ttlnUrdABST3tesa25ANIV9Tjl+K3GXvTQ+J6APJCFD99S14lFZTYIpg5EDxgAKAdKW9082k
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(2906002)(36756003)(38100700002)(5660300002)(31696002)(508600001)(186003)(83380400001)(8676002)(2616005)(66476007)(66556008)(66946007)(316002)(53546011)(6506007)(26005)(6486002)(6666004)(86362001)(6512007)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmRlc3dLMmVocGQ2K3BTckFCMUdZY1pISzByK0lmcU55MzR3dXNMWE1vRjFy?=
 =?utf-8?B?bUc1NVJmTGpsMWpjVUxqQnNHVkt4K1RWM2IzN0t1SU53WVVHVk1BOHhHYXkr?=
 =?utf-8?B?SkJVQTc3WkQ5MnJaNFRQUVYrRHRkMDJyOUtabEpCU2VCaEdMajU5dXNxR3lK?=
 =?utf-8?B?OUNKK002NEZuOGhYZGJVdDhPWjBXR1BXRXNuYlJzd1MyYTVoaGxUSy8vbTRj?=
 =?utf-8?B?ZmtSZng3QjlFTlFOMUxoVnlHYTBxSVd1MUI1TEFjMnFXdjRKYnZZb0hoaUN6?=
 =?utf-8?B?SVd5QWNhcWp6Qmx3eGRXNDIvdk5ES2VZbm1POWQ5VDZVS2l4bWFQd0w1dllj?=
 =?utf-8?B?dnFHMkVrMUxIWWhyaERFQlFFUkpHUzAybTIzNlNJb1VBVTZHL1MwTEhER05G?=
 =?utf-8?B?ZHB3OWZ2V01uelExckdiM2d5V2xRU0syZWxlaVpkdENRSVVmRC9ZZFNubkdS?=
 =?utf-8?B?VHpXUTNreS9POXNVTk1oV3grU0k4U0VETXAyc295dCsyVk1Td1ZZS09nelhX?=
 =?utf-8?B?TE9VWTU3cjl3THBHUkpVb0FlYnZPWkpWcWJzVStnUXRhTURmYUhpdUV2d1ZC?=
 =?utf-8?B?UE12L3RVbk92NkZrT2hjdFl4cjJzYTdKNzFNTksrenB2WFMzMTFCWm9hVlFP?=
 =?utf-8?B?SVUvWWtoZmNpd2hmSCtOWW1XOWlqd0tBc2Z6QlVaamhGU0IrUmNhWVRGb3ZS?=
 =?utf-8?B?R0IrdkxVZHhxY1Q5TzFUTmpSZUhtM2ZibWlxRDRuUU94d3F3MDdIZ1Z2T3lI?=
 =?utf-8?B?b2ZIdHhxem55T0phZDJkU2hSUllCQlppcVNPZ00xdENrQ0hDWTFNcWlOK0N5?=
 =?utf-8?B?NE9zb0xCeGw0MmRHNzY4VkNXcWVXL25BSGlMWUpJNnFFbVRsbnliMC9aSlBo?=
 =?utf-8?B?NWgvK1orSnYyVmdkdnlwK2hMV3FReXA3b05pYUlHaEpqTVdQSkJhQURxdWVw?=
 =?utf-8?B?SVYxWmJoWXdyYlZnRG9zbzNwRlJCN0JiazlwY29hUGxleTgvYU5QaG0xaURC?=
 =?utf-8?B?SS9Uc1BKMFZOY2F4NmpleWhMN1R5Rk93RzBiTGRJUkJMeGtIMjBjaGJ4RVpr?=
 =?utf-8?B?OURDc2J2b1hWQUp3NDRoWUw2K0JBSEtwMlBUVnhCU2ppa3d0Y0UzZEpTNzVl?=
 =?utf-8?B?NkhMWG5aQzZFeXdSNmgwaVlhZW1iaTgyNW1Ya215bjhrcGRaUlBoSXU1OFY0?=
 =?utf-8?B?YlJaZ2xidkJLV1R2d292alVkbXE5WEFxREdIRFBmU0UwVkZIZWRzd3p5YldY?=
 =?utf-8?B?YnFsRTNRaDNmUHlrdG5SOVFuQVlCRkc1Z1FveHorc3IvMmxLVlVITmFMblJ3?=
 =?utf-8?B?SFpBWk9jU3kzODA5TlA1SjVDMFo3bVpMZmdTbGkvdHNkOHhUOVVzNFdRa053?=
 =?utf-8?B?S0w4aERha0V4SFVYbFpPeVk5UkdmNHVuZXF3ak1NL3QzZEo2TmQ0SGlvMjZk?=
 =?utf-8?B?bTRaSmM1UURKdjFobFJLWDU4S2hiVlNrUmZDR1J5RGRKUXNyUHpFQm5OdFJt?=
 =?utf-8?B?ZEEwaFlyZWwxOU1IWkNFeTF3TU4xTWNjelFIMlJPZTE4ZFFxaTRFUGhsblE5?=
 =?utf-8?B?Y0p3b0thblBGY0ZRSE5XaG9peWhRd3M2ZVlod2lKOWlsU05ZR0JJWXl3UkRQ?=
 =?utf-8?B?b1pScDhhNElORU95VmYwYTc2VGpIQlR3Q3lQc3BXeTlFN3N3YUYxKzd2bDVQ?=
 =?utf-8?B?ZUFEVzhrRUoxY0Fncmg3UDJoYkpmcU1Rc1lWbTlodXVTeGpmLzl6T21qbjJx?=
 =?utf-8?B?NUJnK1pYaFpUenJWc2pFUHFjY1diMGhsL0xFRVRSVGdBSU1oM29YdE5lUnp2?=
 =?utf-8?B?Z3hFRXdLWjA1OVpoTGVMZmdqdzViaVNKTGQxamtVVWpVSEtCQWx6UWpHcE9m?=
 =?utf-8?B?R2ZBVEZVQ3J6T09kak16T0l3N1ZnTHp2YWZ3UUlYMGUvQ3lIUUJKS3JiT09l?=
 =?utf-8?B?bnRXQWUyR0VxR1FkZ2xQbnI3RVM2c2VWQXZDdE1WVEd4elZBOUxuTzRqajdI?=
 =?utf-8?B?blhVV2dFTUgyTkFTaHZMeUhqU0g1YnVqT21vVkl4dlBORXZpakVoMWNycFNl?=
 =?utf-8?B?ZlhqOFFTTlN6TFdtRWU5S3BHVGtDQjVibnRORUJvSFpBMkd5bVdKbGlHam5T?=
 =?utf-8?B?bVZWYUZmcnR2REZIbmdCZEt1dm5MeTk3VCs3SnMvUXFoT0EvWVBLcHN0N3Y5?=
 =?utf-8?B?ajhhUDhobGo5SU1lVlR3UEc1Y2lraUJMS3RlNzBjd0RLOGhEK0lLQXhHTUY0?=
 =?utf-8?B?eHVGYnlnSlBIR2NUenZjYkhWdlhQc2dyb3VqQzZobDdrVSt2WFlGTkY4WFQ4?=
 =?utf-8?B?WENwVThvSkI0NlpDdDdYekVBWDhwbU1xVG02T0EwdFZRUHJ2MEY1UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846a99f3-f5ec-4845-a738-08da3308b688
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 04:42:54.4947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+/4lrSvISbH07cDNwB8ijS1XFXdsxw7OPKzIje+IdJKeIKRA+UFJUiU1nzvbGqq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5527
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



On 5/10/2022 8:07 PM, Alex Deucher wrote:
> Check if the requested stable pstate matches the current one before
> changing it.  This avoids changing the stable pstate on context
> destroy if the user never changed it in the first place via the
> IOCTL.
> 
> v2: compare the current and requested rather than setting a flag (Lijo)
> 
> Fixes: 8cda7a4f96e435 ("drm/amdgpu/UAPI: add new CTX OP to get/set stable pstates")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 5981c7d9bd48..94c3a52df131 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -295,6 +295,7 @@ static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
>   {
>   	struct amdgpu_device *adev = ctx->adev;
>   	enum amd_dpm_forced_level level;
> +	u32 current_stable_pstate;
>   	int r;
>   
>   	mutex_lock(&adev->pm.stable_pstate_ctx_lock);
> @@ -303,6 +304,10 @@ static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
>   		goto done;
>   	}
>   
> +	r = amdgpu_ctx_get_stable_pstate(ctx, &current_stable_pstate);
> +	if (r || (stable_pstate == current_stable_pstate))
> +		goto done;
> +
>   	switch (stable_pstate) {
>   	case AMDGPU_CTX_STABLE_PSTATE_NONE:
>   		level = AMD_DPM_FORCED_LEVEL_AUTO;
> 
