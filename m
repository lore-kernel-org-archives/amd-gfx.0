Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26EFC25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 07:16:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1666E10E49B;
	Fri, 10 May 2024 07:16:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lMOI8wtO";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A4A310E49B
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 07:16:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJaBhPFVeiTtex4QFmLGxpaCpi2Ogwf7rfm09xll+oB/iWy3r2puiIoOy+ZeSPi3S80uqzpT6yembQrDsER01EswYL69Htna4LxAzPPbbJ4ZxkL0aLdEuIXgDiXsf79VEfUDgciuLGCCjsB7ajPP/GYETsV/sXB2YYOVR4G+MZaigKbg0HIf2+QlByDwtZSY5Nuo/WHFg9tviEr23rOhfQ/m35HqZB5PKfxK/cXWHeyFxThBatWI/yfSCqah5M701LrAe2yuWVZor3RUU+FMbg6Tp0ZGDvd8Kr0Zhgg47NjrAMo0eUf5XnU5N6U03asSRGH+MLuMEhWws3DeAPYIUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leXDsUo20p9XRiJ8NdI2Bmgo/KouZ5k4b2OC9Pw9nh8=;
 b=SUaT537R/Po993Vxt160YaF+USwDMBD9QUJSsmlKTwQVfxL1k0Z7Wsi6njOAgCqCSAP7h8UlpctbxFDv1fV3n7PaVfk90fIy/gw26CVoA2bE3Rr596lNdIuddFCPaedjfiTr5Pt+9x9LV8yDgVZzuBdZzar6S8QYSavjVi+KtGat3j4aK1ptUahKV74SEWeiXvJHI+x3oWv9ZJ+Jsdat7AnqDq8t48yvwreBzjTGxA9osaoWo9N8DWdI2UWaZRyKPPGb+6N8ypXvo2TWAh5imbeWkJK4TUiSzy+/kkflvE73Ee+cwxOyseJUVZ5NC+Mt/dNYCdpOBfGemPyEczkozA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leXDsUo20p9XRiJ8NdI2Bmgo/KouZ5k4b2OC9Pw9nh8=;
 b=lMOI8wtOPiAuFL1F1G6BwpfvF0zCRNLsW4+3c49XocN0UXYNLde6m/Brkh2SjusI/bNWhpJiPvUIGC0CUBXKDzCPfj+uSyJhn7tGSGH54UsZKBcDL3EHgSxTou1hoWpoFWClVfzcvREvwvjXzdaZi6GXL3iVNFPwZ83QeYxJZL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB7298.namprd12.prod.outlook.com (2603:10b6:806:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Fri, 10 May
 2024 07:16:17 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 07:16:17 +0000
Message-ID: <f82ed0c2-d90b-41a0-aa90-62ec8eceeffc@amd.com>
Date: Fri, 10 May 2024 12:46:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/22] drm/amdgpu: Fix the warning division or modulo by
 zero for the variable num_xcc_per_xcp
To: amd-gfx@lists.freedesktop.org
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-19-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240510025038.3488381-19-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB7298:EE_
X-MS-Office365-Filtering-Correlation-Id: c4767eb0-79bb-4a3b-71a8-08dc70c11537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGxHT2xadTdiMktzaXovT1UrcmZJNk84MGV2VjVuSGx3VEJyQ3pHQkhueGcx?=
 =?utf-8?B?NjhaOWJhTEJtcmxEM085MElZQ2dCRFRxVXNYdmdTYVU3clNBQ1Fra3NwRHY4?=
 =?utf-8?B?dURZSzBzZVNLcWgzdkc2aE5LTXZJSWI5OE11dlFabldSanpsQmdTSEFNZmNn?=
 =?utf-8?B?RWJXN0xadFloNEY4U1g3OCtRMlh0K0FBVkVpM1RxK3Q0TjdleFNYQUJvMTVx?=
 =?utf-8?B?SG0zUDY0Qm0vSmtWNWFhUld0bHFGbDVqT3BJaGVrNXZBYkNtd05rdklrS2VC?=
 =?utf-8?B?THk1cURidHhYQUlKMEo5ZHVWOXJMNGVlTnBLdnRIR1kwNzR0NUtFN0p2dWFk?=
 =?utf-8?B?UDBrdCt2UEo1Nll3bnI4WGVoaVh4UUdkdjd3emhqUUN1SmNSRVlqcHEwZ3RN?=
 =?utf-8?B?Q1FIMGFRYUQ5Mm9PRkVsTUhlK05iWVR0ZEQwV0xjeWs3THUySGdCZlcvYzhn?=
 =?utf-8?B?bGNjSnRjY3JFKzdzR1V0bWhJM2xIeDhQSU0wd1hrb2VJL3FsWlZvOVk4Nm5i?=
 =?utf-8?B?UkR5NnlhZVRyRUJMcTJkME1YTTNPZ0RJZ3hnbmw0blFUMjNSUmd5RWxseUQ1?=
 =?utf-8?B?SEgyd1piWjlBTEU2cWJUWHd5UWxXeVRUWU9aSUs5aUJRaGRRS0pXeHg3QTdr?=
 =?utf-8?B?cno0eTE4ZDYzZHplVGhtYlJlbHBFRWlaRG5xQzlhQ1JibFJBK2ZKME8zU3Q3?=
 =?utf-8?B?OUhObFBCWkt1MG9DVEhFTHNpdTAxZ3RXVndZYjVKUkNyZTZrYlRINFB2S08r?=
 =?utf-8?B?QTJHZTRwb2ZRV0drQkpCTkRlQzM4Z2pkdGNhVTg1MUdlOXZHVFcvcWRzZ2Zw?=
 =?utf-8?B?ZVQ2TGJpT3NEM1NvdnlKRmJQV1AxWE1NRUR2RWVHSHpRZ0xjSWxaZ0JaMTEy?=
 =?utf-8?B?ejgwV1NIWm1UeG9vK2tyRWlKSFkvV1F1Y1BybndkakhwMm4zUFdETkpSWmtv?=
 =?utf-8?B?VWQreTNBMW81dXFxMVZjTUNnVFRoQUh1YlUzQk1XajgvZEozQXNOby85Njh4?=
 =?utf-8?B?MzFHZXlkTU43SGNVdzB0cmJJeTZIM2VQdndZWEJwTzI0N3ZsREI0eVFLNml5?=
 =?utf-8?B?c0hxL2tNRWluVWk2MUNsbmc0MjNWaDM4WjNFQUFiNjVFMXl0OWVYVkpGSHZZ?=
 =?utf-8?B?M2JLWFlBVWJQNmRqSGg0N3M0MDJabWhJczJ5T2JWcVlaQk1UNmZVZklYMW9L?=
 =?utf-8?B?K0ZmWVJXZFcrQUcvaEVDQ2doVVBSRWFuM29iZ0FSalRzL25CVW9DYW5mT0VB?=
 =?utf-8?B?cTI4VGg0ZENLTDBNZXVkd1RHQTFIWE5BYXhsMkpCRy9Gdlh1TmtIWEJrV2dN?=
 =?utf-8?B?b3cvTUxzaE1VN0tJQ0pGTE9weGtnaFJEMVRpclhldU5oWFJEcVpwUHhzZVp1?=
 =?utf-8?B?Y0trMkdQR1dHZU0zcCtxTGlCY1Z0ZGFack16emtQUlFHWjBsclAxbWZPZ2d4?=
 =?utf-8?B?dWNibU4rSzVZT256RzY2Rk1uZUdGYmpUQ2Z6Q0Y3RWZLaE5nZXIvWC85SVFn?=
 =?utf-8?B?emxxeTU1Vm9KcjR1a0dhNW96MmQ0bmZRbmthS24zR1FzenBxak5qU2N2dVgx?=
 =?utf-8?B?TVBGOVlkV3Byekw0blhYUFhUMDgxaEVQNndoRUE1eEs1SGs3b1NUU1REa0wv?=
 =?utf-8?B?Yy9MNzFvZTNEbWVHSkpHSVNMdjdPbXdwVGhOOWExalhEbW1jU2Zod3NIbW5Q?=
 =?utf-8?B?a3BNdDExelB3azJyTy80ZUsweDdlK0UxcjJNOTJmbUl6ZzNFNlNicklRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXBtR2QzSUxVa0hrejF2cUZxd0wzN2lEYnpicU42RC84c0k2Ynp4VE5pamNh?=
 =?utf-8?B?TE1SanI5VG1BZm1yY2IzNUd3cmd5QUtxTE1hQ2o4Q3JteGpTRHIwbFdRcWZO?=
 =?utf-8?B?d0dXQ0xTUTJ6ZHZlWndzWWthMWVsdS8rMUoxMzk2MlY4WnhqYWNTUW9UQUI0?=
 =?utf-8?B?c2VmTkp2aXFkdEpScjVHZmhMc3RGam9ub2FGSjJxRkIvWWVmcDZDQjMvVHNh?=
 =?utf-8?B?aHZDQ0pYOFJOU1VhZHBGaVovRThDTTlDUEZFU2RvNkV2Y3ZsakVHWlhwZHMy?=
 =?utf-8?B?a1h0NXV3dGs3ODAxYW5LZmpOOEdCV1dCdWlGaVVWcStnQkpGc3hrWEx3Q2pV?=
 =?utf-8?B?VUpuMlVzWXF2cWp4V1JuZU5GbkJIbzhBVmtUSC9ZR0ppZzlrS05oZ1hqaDI1?=
 =?utf-8?B?N0tnTWpMSW1DLzFpS2hmdVNGWmY3VWZwV1BFSFBYRG9PSmJuMTNUYkN5cEhP?=
 =?utf-8?B?RGQxdEtnQXc1NU9ORUVMQ0FXOC9CY3JCeGtvLzlTaHQ1eWNmRVJkZHNZTFBh?=
 =?utf-8?B?N1VuRmlsZ0krT3N0OWV3UHZPdDN1MFFoa29RdW9WWlY3K2liZTJEdGRCLzRq?=
 =?utf-8?B?WHBiT2hVQUQwZzZKL2NFQ0h0b244aWFZY1I5Tzh4SkVaYUh3cjJWRWhkYkM1?=
 =?utf-8?B?R2IwUlpIQUxqaU85dmV3TVdlYThRZlY1Tmt2NkVONFlyaTR1RkJOR0cvcXBy?=
 =?utf-8?B?RythMFNaMzBCcE5sc1lLbXBrditGdFM2THREMXRvVWQybGYzSVZOdFNidyt2?=
 =?utf-8?B?R0NXQVFsQTBPZWRUbHhJZ0FvbVFOdnVaQnZsM2UxSzQ5YzFnWkJkcVdyUERZ?=
 =?utf-8?B?SnZ0cHZTQ2lkeEF4VFVCZWRreEcxRisyeWppZXFJUFBLVlIvN0JsdTBUUGRp?=
 =?utf-8?B?UkJPdWlWVUoveFFuNGRVNWNicVhZUzJ4U2ZQK2JJQ0FvOXYzRHAxanlpdmN2?=
 =?utf-8?B?UUJSTENYMkx2OUZnWHZ3YllvWExYN3pIWFFIRUxTcGJZR2tzbk51anAzRytD?=
 =?utf-8?B?WDJsSUpnbFJqcVlaV1J2S2dCWFZGOEpqRmdjSXcwTG9QQnFZRFh3YlJIU2E4?=
 =?utf-8?B?RmhXK0M3S0hmb3pSWTBkbGZJK0NmL3NVOXJYeXZtMFJOWCs4TVVPN05HR0ov?=
 =?utf-8?B?d09UMFNxdkZoMjhzaXdFcUJ6MWZSbFVRdU50am1rN3dNYW1iVTJFMWY1MWNY?=
 =?utf-8?B?djBCYTRoWk52b044Tzl5c01EbENHUXlPTEVlQmN3TzZnV25seDZsRDU1MzZ2?=
 =?utf-8?B?YlRyekdCWGFUaktkMWV6YmlQS0hBSWVvYjlXbFdIbE1vdUZvTVdPc3JDNVhq?=
 =?utf-8?B?dUxvem9oV0lmVUp4Yk9IckRaYlVkblBkaG93UmFZaHU3Q3RLWDhGbGFiZDhh?=
 =?utf-8?B?ZlhIMHNYQUpJdDJjL0JBREk1dVRzcjF2TTVmY1U4YTdvNVNaRXUwN1o0SCts?=
 =?utf-8?B?VDRxRFB1cVYzZnM1MzFDZENEWUFsZ3hoZ3lIVmpEVDZGc3pDd2N2Y3pNbXAv?=
 =?utf-8?B?OWRzOHU4RHgvZ2NFRm9uRm1TZVlCWHFWTnpubWJXRlV5MkRIN1lyVVhEUnVK?=
 =?utf-8?B?eFRoakJ0TWg3TXp2dnROckdGUHpTQ0J3dUpyZjR3ckJyK25FZXdGdmNNUWZi?=
 =?utf-8?B?NXJ3VlZxd3lCaXduN3VNekYyZ3lFM3N2aFhqbTQ5N3JEZVd4RlJpVHQ1bjhl?=
 =?utf-8?B?a3VNaHR4Y1dzU3ZxR05HRUVWMnR4aXRxMDNWVEdnYmEzd28wejRSNEk0b2Ny?=
 =?utf-8?B?c2Y1RVBBd3o2SndRbzFrajNrOVE4aUhmVU15YjYxeCtjckVUV28yWjFKVFhI?=
 =?utf-8?B?Y2M0RjBocyszMW9tSjRKQ0VpbHZsRjhYczJzejM0Q253UkRmay9ocUNIQVJR?=
 =?utf-8?B?WmJLb2JjNDFhMTQwNnAzeVUvNVhvb2Jqd004ZWJZUE1BL01pMlFoUmNJNHU0?=
 =?utf-8?B?RHRWOE9FS2lRVThqYitqM0ZTV1R2VWlzMEh5OE8xMlNhQ1JBOVVuK3htK3J0?=
 =?utf-8?B?WDlPNDFFVG5Va05DSlltc2NjN29MdVg4Vkp6b0xxMmtHQkhXZytTK3BhYTBt?=
 =?utf-8?B?N213OTBXbmlUS0VBWDhDWGJNQnpqVGVwUUdLOUhBSUgrWFdzTkFUTlVvcm0v?=
 =?utf-8?Q?cQbwnekwJiAW6llG6rsVwUZA0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4767eb0-79bb-4a3b-71a8-08dc70c11537
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 07:16:17.0383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jUkqxoD2+0c1TBVpGesgYPQtEcuo+bv8QbKTuRiXzG7uLXVISRVLr66O7PnfyVL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7298
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



On 5/10/2024 8:20 AM, Jesse Zhang wrote:
> Dividing expression num_xcc_per_xcp which may be zero has undefined behavior.
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> index 414ea3f560a7..5752c6760992 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> @@ -522,6 +522,9 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
>  		goto unlock;
>  
>  	num_xcc_per_xcp = __aqua_vanjaram_get_xcc_per_xcp(xcp_mgr, mode);
> +	if (!num_xcc_per_xcp)
> +		goto unlock;
> +

This won't happen as the mode is validated before and for each valid
mode a non-zero num_xcc_per_xcp is expected. To satisfy the
warning-checker, before going to unlock use a proper 'ret' value also
(otherwise it will look odd).

Thanks,
Lijo

>  	if (adev->gfx.funcs->switch_partition_mode)
>  		adev->gfx.funcs->switch_partition_mode(xcp_mgr->adev,
>  						       num_xcc_per_xcp);
