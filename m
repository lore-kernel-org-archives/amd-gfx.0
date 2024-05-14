Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD92FC25B75
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 06:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47D8110E290;
	Tue, 14 May 2024 06:55:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gIjUOSaM";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 904D510E1E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 06:55:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5ocB6+eovqDwUa503w6heC6p2ggAQCsuAgNfcCEYjt/s2dKOtFOXEUgG02792TWkV3QzcG8iUwSlINNjm6rbMsc/wjrpQOteqVXxfhxR5c5tJn3xTf737kO8H2RWTTkaOUCq2C5VpcmPumo7Zn63qHFeJzj+1tFXDLUVqX5H+IKI1FydHPv5DRm+yN4WCP82JGMEU4YXt/O9EhXK/600+K+opp1BAeOBS/2+JooA1/J35rbDPAFMp3AH8NIe0OCNk14da2kI+h4a41gs6EWyI2jNQSSVz+T5rIv32vTsmzQW8fsIGkb50aD1t/Jl23uZWcSGImS9ufnz3+AvJmpcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzEQbPg2YE065ETlqmMbHExcjm4GmwGR8QpvDIvR58w=;
 b=krEjmwPv9/na4J7OCqI/Nns5AZVQ20N/vdX0fKbWm+iA5Tn2U68KSuRoav4rXnIP14Vjp/v4FwRfEfFi79ImC7LayAczapp5MKZ190lv08jBhkxjgZXLPQWK1ax25hlENNP1kfEXdlaqSx0miWmNOjJACCSo+RvlW68pyJ4Uu91SscErJ+ouwf8gH+4TSNFFrPjR1+W50tdLfGm2ZyoWnxqVASCcUxw1d/n2tCuqCksWsFTSQM6PV/tcv/QAJnR6XO5rhr+N0esJjjGZJyrqx6AuehJBskAkFANtbKKRnm8m+SKcUWt7LlxS4HFOfYgMo9dFjBK9UxYfp31ZxZ0h0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzEQbPg2YE065ETlqmMbHExcjm4GmwGR8QpvDIvR58w=;
 b=gIjUOSaM6wahUiIyChtVNCAq4Vlk/oNQRob9FoRKX8RAm4uMhmuPSqPIzidZUOJ17bm3snCJyMz8EHxyOXOB7jffHQXiHQdp0z9pOCaoJxElaJuoZv7umatSdKejd9IZ90D2+3sN343tRq0S9yfyYTtUEQ9n/KCECuL3Nb2Czhw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Tue, 14 May 2024 06:55:14 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 06:55:14 +0000
Message-ID: <c8c60185-9a44-4883-887b-646345c32f3b@amd.com>
Date: Tue, 14 May 2024 12:24:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix the null pointer dereference to
 ras_manager
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kenneth.Feng@amd.com, Alexander.Deucher@amd.com, kevinyang.wang@amd.com,
 christian.koenig@amd.com
References: <20240514041230.605539-1-Jun.Ma2@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240514041230.605539-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::23) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH2PR12MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: 81782c5d-fa05-4842-32d0-08dc73e2ce5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVhrZkJEbzhJMXdBeU5SeGpVV0U3NGhrZXVMZy9TUnN4eUtLb0NPZ3U3SVBN?=
 =?utf-8?B?UTNkN0lhRkRLbEdtOFNMbDJ4STRVcDN3NVFxNnBYZ1JTdkRhUTBDdGMzOVlL?=
 =?utf-8?B?L3pXN0UyQk9ZMWRpMXJwOFdnWDZFYjJUSW5DZmpON2FyYWViZHFJV1BqRVRr?=
 =?utf-8?B?ZHhvWm1PNHA1TldQUnhWcFNIaXBYaGY1UnI2WjloOVdvVjViSjFQQnpqdE15?=
 =?utf-8?B?UHE4VUZlZ1lhUkVBZ1RPSTcyOGxNSmMrSE42bXhEVUszNVM1Y3dUN29tU09K?=
 =?utf-8?B?cFNrQjZmbHJHMXlwYTdxZ1d4emJldFBWVytEMEw5aGZpMGl0cWdwbFJ0c2NQ?=
 =?utf-8?B?N3hKbTBQeHZ4N1pSd1VERThWY3dmTzdGSEg2QW9nOXZ2eVBHRFhma1hHODJO?=
 =?utf-8?B?MXM4UzlXSTIwc3FnbjQrcTdMdmFuSWNkMHZxT0ZOTktYcXg2eE94U3VkMlc1?=
 =?utf-8?B?SG5McWhqWUU5SUxyRzhkYlVyNk5uRFlJeWFLZDNaMlcyU09UTEZSRVFMR0dl?=
 =?utf-8?B?MXpZWjM4Q1k4TkRSMHhGR0NXS0c2eHg5MFdHQVZCMGpYN1VrMXZJNGFGNThX?=
 =?utf-8?B?MGJvQ1hDamI2TDJ2V1Z1TDdWTFZJTC9pV0xDUW5sZ2pDeDJkL0J6ajJjdWdS?=
 =?utf-8?B?b1lVbTJMS0xwN0xod1FiOWgwT0JqUkdYdEkyNGhXR3NXczdPbmNkZ1V3SjVK?=
 =?utf-8?B?ZWxuZFUwaWhBZTFsNmplMjFISjNIYS90Y1dBdW9McDN1MTBHQjRYM2x0VFo0?=
 =?utf-8?B?RnVhU2E5Z3JQRXZnNjJiR3RkdW1QWVhuZ2V5MlFpMTRsMzhJYjl4RG13T21l?=
 =?utf-8?B?enppWStvQVltY0hoWUNVTitZc1dOTDdzc0ZYVTJob1NGaHE5WklEYTJMRkVa?=
 =?utf-8?B?SzF3SWM1cHBGd0NCbmIxNnhkdXBSdGhKR09zUnBBNTFVVVZIdzRyM2d0SlU3?=
 =?utf-8?B?cE1ubHpldnZwQWo2RENrOVJHd1JJZTdMSWxPMGF2Zzk3OCtDY0xhSVRtdnVu?=
 =?utf-8?B?MWZac1pML1dGUXdMa3dTYjYrSlBlQWpqditkZnRUR3FJQ1Nvc1Bkd2E3STlF?=
 =?utf-8?B?ejdKbUY2VTNCK1RsU1ZVK3dHK1VwS3o2WlhMVFlDZU05L2FTZ3NtdGkvcHFX?=
 =?utf-8?B?SWdoRHZsVmhoZHJxYkdHOFE2dS91STU3dGlQZkd5dThiQldYL2lxT1I2bXRI?=
 =?utf-8?B?RVR4Q2NKa29NVnJwSVBSWWNJcER0alF6TGtNdXlMMFBudmVucjA5aldCUFV4?=
 =?utf-8?B?RDF3bGpuaHFQOXVrajBwVzlwQXpuL3JJVlI1Mm9pdUorQ2xTaXdrL05hZHcw?=
 =?utf-8?B?YXZQTE9sNDg4QnU3QytHQ2pnMFpEeVB0RzRZNUo5bC9abkRBdGJCeG9Fb09F?=
 =?utf-8?B?SWp3TGJjMXZ1RlZweU1XQzdyQzBmOGF0czRuZk54Y2t3aHYxZUxBZkxoOEl3?=
 =?utf-8?B?QTdxYWVvcmVESE1MUDlFNW11ZWRIRUMwNUdBcFFLSkY3dTdNTDRjcmZJcG9J?=
 =?utf-8?B?dEV1bDBHNTVlSWJ0dDNvZ0ptSWhwcEJhVDYyLzhKWVlZUVczcENKbU95ZHY1?=
 =?utf-8?B?SVd4cDlCOTZxM0lqU0FtMFRUMno4cmJiK2VPeHV2Z3pqdytiN1pPclpOYWpF?=
 =?utf-8?B?T1Z3UW9BajFxUW1KUjYyMVdYakkzSnRNaXZPWG1aNTd6c0RWQTBDTERwdXBR?=
 =?utf-8?B?Tmo0THpheW8zVUZramxMOXJJZ2dPdDBkVU1jZmltUzZMNXl0R0F0YmJ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW9FMmUzcFdHUDB1VmJEU05SdEtqQzY2VkhhVGx2UEczYWpQbUJ2UW1wZ053?=
 =?utf-8?B?SHhEODV4ZVVWQ2NNQWNxbkMzUjBveHdvODZLSHlFbEdyNE9Cb0hkcGUxU2xr?=
 =?utf-8?B?L1R6b3NqSnBzbVNTRXQ4TEtxNUJBdkdWTGszMVlWZWlIODJXS2twSndHU1Q2?=
 =?utf-8?B?bUNDN3F0eWRkS2dZb2lQZmppL3B6MGJYeDRIVGpFU2lnbHBVejNJMFQ2RnQ5?=
 =?utf-8?B?OGRYRTNaUFhzemNKSit3UlZ3UEtPeTlISkhxeDdaS05yVkR5NERvS0tqdXJo?=
 =?utf-8?B?SWxucjdaMVlHL0ptTmdqVGpabDBxQy9VL3luVzIyNEhpZVJMY0ZxYWR1enZE?=
 =?utf-8?B?UC9HYUtIcllKUG9kc2FoMytvQUJDRnlqVWV4M0loeUhDMWNucFM0R0VVT2tz?=
 =?utf-8?B?YjlSMDBKcm9sV3FkaXBUdC9EeGtETkhrRTUzOFBEMU50RlNvNVA3QUtyU2w4?=
 =?utf-8?B?NUdHaERMT01oaHRsM2RwZGdSeWNIbE9aM0M4Z1cxWldWVGZ6bjNUR1lESWVP?=
 =?utf-8?B?bzFOK01iK0c3TW9rRzVNN1Z4OFlTRFE1b05Vekg3SFZ1cTk3OGxXUUExVU40?=
 =?utf-8?B?YjB4aUZNamdLY202R0xyampSeTNjcXpvSDR5NThyNjFWbDZlalhlOXY4REFO?=
 =?utf-8?B?M0ZZRUtoZEVSN2l0M2JNbzAzQzlwOVJVV0ptbHZmSW9HaUpMcnVOWHFpQlhu?=
 =?utf-8?B?V2h3OGZaWHJNK05aeW1Oc29GelF1VU1DcGYwSEJ4TnphTGZ3Y2F5Nkp3ODBZ?=
 =?utf-8?B?TGtGMWpKTkRkTUNtOFJLQVZYdW12enVLZEtNaUY1VS9jcTFkYk1kYnpPV213?=
 =?utf-8?B?eDYrUmJxOGRPRlBsRThQcjYxUG1YTnNNc2NlN3ppN0F3RWtGNmQ2SUlFa1VC?=
 =?utf-8?B?QjBqRkxPaGd4RkpIQUEvK3l1N1ozUHcreHpIdUhtdjhnVmtjUUhjbkZieFFr?=
 =?utf-8?B?d1I1YWFDYU1uU0RWWTJwWE9TcmxIL2NQdWhyL3lPOU9td1pzcll5R3Rvellm?=
 =?utf-8?B?NXJOUWZXRmdLK0hDbEZiMjFlbmV2WDZPV3BXeGRvQmswbUZpbTdFa2dlaDR0?=
 =?utf-8?B?ZWxjODZoVDN5QTExdGlOZTFwaWk4ZUpxdnRZeExseUg3QzROS2Y4UmkzM1NB?=
 =?utf-8?B?UWJUcUFFTC9VdmQ2emdqQndNbFpyanZnMEt1eHI2STFJQ2RBTlREaUx4azZu?=
 =?utf-8?B?MGp5UzBCamdpdmhZK2RYaFk0Q3pTUVZJMDJlTUVDNGhTdzlpKzk4WjR0YTNn?=
 =?utf-8?B?L3c3U2UwN0dyZkk4SnZVa1cxb0JoRmpnNjE3Yzlzakk5T3FLb3A4UlJRTlRJ?=
 =?utf-8?B?U2VkbGVhVmNoVjRLaGNzVmZITjVGUmpXTFFwbm02WFdwUE9FdE5mazcxV09L?=
 =?utf-8?B?YzhTd092VElFWitWMFk4RzY4ZGJabXVTUW1QQXZYSEZHcDhaMlF3WWJkMVFU?=
 =?utf-8?B?c0ZrZkgxY0x6YmNWbzdVNkpRSGdyckpNUjVuMU5JL3A3cFNXQnd5SGRtamxl?=
 =?utf-8?B?ZmcrSXBuVW51OEN5SmxUVFFDSGdGUzlWN3BaWWwxakRObVNPNnNVSWxxQmQz?=
 =?utf-8?B?U01sUHh5b3pZS2I0MU1jZHM2TVFZYy8xK0NGNjgrWjlFSFJSaEJndFUwNXB4?=
 =?utf-8?B?T0lGSnl0bHBKTUNMcHo3VlFFbjNKNTlhZ1JmaVRFeWFQTEIvem42dDh1VUNq?=
 =?utf-8?B?TUxBQk0wYW14aGNoRk9LalJQMlhPY1ZqMXZOaUFQWUFlTS9qY1NhSWdjZlhw?=
 =?utf-8?B?Y0xSQkF4aXF0WUptUFZyWUljeTJyM24xMzYwbkYxeGljNlpYMDFJMlZVR0o4?=
 =?utf-8?B?cjJ3Z0xtdzZnOGZOSXp6YUNqRWhtZVpmZmRDVTZBd0dqa2pJN1dGRXE1RnY2?=
 =?utf-8?B?cjJ2SXMwYWpvMjdkenlxNGpnMVp3R1dZZW93UmE4R29odmpyTlRhM2FZeVVJ?=
 =?utf-8?B?ZmhwREtXRCtiT2t1QUFnbTg5clNObS82dkZDRHoyYUNRdEp1b3dvRjBnRUp4?=
 =?utf-8?B?OSs3aGZxQ0pFemREWlNuNkNtam5DcDhsNWxOSlJFZ1hLQWJPSFcvVFh2SDht?=
 =?utf-8?B?enVXWEk3T3RNZWJMcTA0V1Nsek9ibU4vQ080ZE11c3ZIejdEejNuNFBvSm1Y?=
 =?utf-8?Q?w6oGHyUZK7vNMG/3mnaOpnCzo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81782c5d-fa05-4842-32d0-08dc73e2ce5c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 06:55:14.5237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e2Oj/zAP/SydNi8j3BfKzlfMjXLVy8capP+Ktw6onej07gLA6Mme/HCQF1LbCgnw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088
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



On 5/14/2024 9:42 AM, Ma Jun wrote:
> Check ras_manager before using it
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 925ec65ac5ed..2bcf5c3b5d70 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2172,12 +2172,15 @@ static void amdgpu_ras_interrupt_process_handler(struct work_struct *work)
>  int amdgpu_ras_interrupt_dispatch(struct amdgpu_device *adev,
>  		struct ras_dispatch_if *info)
>  {
> -	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
> -	struct ras_ih_data *data = &obj->ih_data;
> +	struct ras_manager *obj;
> +	struct ras_ih_data *data;
>  
> +	obj = amdgpu_ras_find_obj(adev, &info->head);
>  	if (!obj)
>  		return -EINVAL;
>  
> +	data = &obj->ih_data;
> +
>  	if (data->inuse == 0)
>  		return 0;
>  
