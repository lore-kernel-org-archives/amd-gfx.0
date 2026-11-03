Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC9B606A32E
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ISZvUB63
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28F0510F4D4;
	Tue,  3 Nov 2026 10:41:40 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010050.outbound.protection.outlook.com
 [40.93.198.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6B0310F4CD
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 10:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zw652k0BZn5hCmYWW8YJcJv0Qf8bMxb+7YKFBXmRS0ZB2RCOh++KNX1lIhOYzGwARAuQoTUpf+DCkAroXmkUYgyifZRmPuTYQ8s0kvrL7M/bWuBqatSXPHvafDLnx3SPLDezQSYGIpj2mlQf2SosHDUNwIVeMGj6skZXHPMFDuHNmSC0MiL5OyBpizXQhbR3AYlkRYELxdXsyUl5Na0RuRWdQQHWsAJCtx3Sfzavg7yU/jGC5bDc5bsdeeTHzPlWKaYXNdf8867uw5IyrXf1orGRGu9475ZTqirvBZTR2oNUsTIu0gtD8QupZ43quFHsDa1FQc4sturmPCwx+DR7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qzhsOrbTKD/kFlxPthYTKGCVF+PXVLP64cy4zwOTnQ=;
 b=Glo+X4E2vyVdiFY0VVSvkAcaZGk4lAMuvJOW3FDzpM+VmliKNAnaE+huo2Q62ZYGbEuKnAvs4YUOB6LsDP2wiIP4POXysqXhyTBwMdulPa4zIqICaFSq1kETSZu/Llo/iVd98ISE+56lPPjntoshA+zzZmn9FgIl4IHhB1L6SdCLWAKwT4vcfHXK6OKrWJybAzPChnZwtLUskO+MWSaD4qZ5jLkSscjGXpiAV0rzF4SUf0gk0bo7ASDB+mb09rhA15pekAWvC2/3vwr0YuVIgRHPxBlPVT5i2DBQ7KJkHI74ZPdI1XApJmwJHLP+SkJ/Lg/ZLs7dEbNAF3kWojr9jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qzhsOrbTKD/kFlxPthYTKGCVF+PXVLP64cy4zwOTnQ=;
 b=ISZvUB639Y3Pl5gM/YHUjmi6kG0rfcTGIKhDox8mKNlYNgjyJ5YfzJVuzlA+rWOLd6RQgDde/T+zdcPTBhcLTtGfKiAwkpOyO2kBKy11Tzk/7KG5svfMDBfgsIM18CChe+0aiMyJSzpYJsJTMiSJczG7Djbl0yzXtk7F+C53Og0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA3PR12MB8022.namprd12.prod.outlook.com (2603:10b6:806:307::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 10:41:31 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 10:41:31 +0000
Message-ID: <51d3d345-e1f0-48db-af47-de488e428dcf@amd.com>
Date: Tue, 3 Nov 2026 16:11:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] drm/amd/pm: restore the forced performance level
 after a reset
To: Priya Hosur <Priya.Hosur@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Kevin.Wang@amd.com, Christian.Koenig@amd.com,
 Felix.Kuehling@amd.com
Cc: Veerabadhran.Gopalakrishnan@amd.com, Pratik.Vishwakarma@amd.com
References: <cover.1793689935.git.Priya.Hosur@amd.com>
 <f370dc0e7025b9b39cac723b1b60ccbd339d233f.1793689935.git.Priya.Hosur@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <f370dc0e7025b9b39cac723b1b60ccbd339d233f.1793689935.git.Priya.Hosur@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0234.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA3PR12MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e01ee7-24be-401b-5c0b-08df399705ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|22082099003|261102123227099003|18002099003|56012099006|261009223027099003|11063799006|4143699003|261022075727099003|261021123027099003|261026140227099003|261022105027099003|261026121527099003|261028144727099003|261009221227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: Fpjq9YWlLzzlamuUq8zST6hYlznP3gcxIT/Ad0ppUvjlsO6JyL8CTLnzcZvzPXlNODLV1iMEeZOgscV3HTL41iKD0jjsdmJqqcqzWp7otzWO7AGrI/w6qHU+P5DPJwZLXRgVU1Um4yX7IoWMOEmSldpv2q93E1bgdcMtGECPWXaDA67Wyev0Emq/3eW30zCRVlFOljviUcaNh4UcZLZ6uk8PoYlQ980guJu1pkXdp9Roap33Z8xn6+W4dU9cQ5i07bLAMVN0W1MbQNs1Swu0eQyViJ2Vg0BtlH4bR/xHySNi0jUJwneNN7gb4fP6EeKGiaLk2xxu1zsJQGAODrj9nXabgvqcVDR7LnlHf7b9KZPpRceIRpprCV/E0lFXNfeRC3Ax/Tpg1Jbfn0W7lDAmshCYxO1cnc7ywP95SciokWlD4d2mvvMJmcx0O+pKW/N0LG5Td06/Wnb9++kUcogS9BlwCQ0TABC2p44x7qBYYRwnCFuOjs9X4WfcasMUF8pUyJNTqPXKJYSuL9ta7vpNoHvRe9oDqtUFbP1gbXLECnIx/ozp+MVAYYrnR8I7utMgzyXOh5sBRJMzRpg/P6A3hkBkvQtWO42T3HXgEIgJqeJDi9REZnCTUaTFCCotQIcIAtpTOE6cokK6dQvG+Ha0wVMzbWTkgxlv70nWjcfmozo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(22082099003)(261102123227099003)(18002099003)(56012099006)(261009223027099003)(11063799006)(4143699003)(261022075727099003)(261021123027099003)(261026140227099003)(261022105027099003)(261026121527099003)(261028144727099003)(261009221227099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzdmUUwrR3RacnU3eDY1bGtnbzlzQzZERzdCdEJBUGF5d01NSjZxYVFTL29N?=
 =?utf-8?B?czN4c1hTdmxBYjhhN2dNaXlwZ0xqaVVucU1Cc1JqQTNJL054cWZ0RTJKL3M5?=
 =?utf-8?B?Y1ZnWldqeWxtU3BPZ3lvcXR3bjlmeGplaGZMOEFiV3BzZlhVVmI1M1U1cVVp?=
 =?utf-8?B?bC9xNUJ1UnIxMitxN1pLQnRHZ2Y0V05WVVZYSGQxUHRVU1lUMnpJMVJVYWtX?=
 =?utf-8?B?LzA4QWNoWlAzZWpqQXdwRjNSa0VtMDFsWU5ITnYvMUpKUnBBOVVRV0lBeUF2?=
 =?utf-8?B?b2Q2NXk2eFluaWdLVzdMc0V4RTB2NTRKQnlQMUQwNnRrdkpFUmt4Ynlaam1B?=
 =?utf-8?B?eHlnby92UllVa1ZldE5qRFJGNHBBV1hpLzlhbTh0Uzg3ZUlXMEhFOC9hUE1T?=
 =?utf-8?B?NmU5ZXRsampOL2dDRHdyM2d2YUxNb3YwVnVVejhPY2N4dDRidmpPaUhpRmpZ?=
 =?utf-8?B?RXhRWWMyWU4wZ2lxSjlKcHdlNEVhNE5MUFZrUHh1OGJIY28wTE1lRUxFeTZH?=
 =?utf-8?B?MkVaTGt1dE95NjdET0hwQmx6TFNMNDJwcEVLcHNsS2kvK0U5N2IwZGR0b1Vo?=
 =?utf-8?B?c3NDMTQyOEtvVEV4Zm1EamdqR3BDY0d4M1pNZy9oSW9xREE1RkFCQzNwb0dn?=
 =?utf-8?B?L2o2M3hjV1hpSngwUW1JU1F1VUw3dU4wMVN2VlY0QUVnSFBEWEN4WEhvd3Fr?=
 =?utf-8?B?eGdjSkUvS2xRY1QzTEN6MnhTZXVLcVNRc1krMWxPNlJKTWVrd2FzT3B3RHhZ?=
 =?utf-8?B?NDRhc2pJNWxCMUYwazBmUnZoaGRBdGJUSjRxT3g5QjVWNnMxcFNtcjd5RE0v?=
 =?utf-8?B?Z0QzTGpWMzd5ZkpaL0dwYXRhRE9Edk9KVzV6eXE5UHlnVmtOMW9pUlRvTkFk?=
 =?utf-8?B?Y244czN5bEJ3SEd2eGlELzhUbmdEdlMwTFZCelNVNGplcmtHOUN4ZkNwOHI0?=
 =?utf-8?B?SExHalRmamY0bEYzOXBQNThnUGpVMWZIbHVjQTNiRmsrRDduaU9pd0lXZWYr?=
 =?utf-8?B?TTRkU2kvNmkvOW5ydXdJeE94VjRmbG5HUTdHQ3BaNGt0MjhtSHF0dFpLdHV4?=
 =?utf-8?B?eTZITkNiWEVpZGYwcFM5SmZUdmZkc29TUUxSVVNHaVEyYXlTYlBnUjB1dG5G?=
 =?utf-8?B?cDNxcTVVUEdLa01teVVyWk9UcVNlMnBwTGxobnIvM3BUTkVhSzFlVkZpNmtw?=
 =?utf-8?B?WE96ak1pVUhaYm9SR1J3cUZkN3JEeGJlNy9kN2pnbUNNVXkrSjJtZ0JKdHZL?=
 =?utf-8?B?ZjA3em16NzZMOC9oeW9oYzNwTkZtVWI5dm5ibS9tT21iVnF4QmdaYjBFb0Nq?=
 =?utf-8?B?YmkwKzIzK3h4ZGlLZUdKcGduVDQrQUtnaCtidWhHaXFOdHF5ZGVpa1lqRnN5?=
 =?utf-8?B?Und5cngrRGErY3JMNGpoaEU1WDZmd2xiSDJxcU5DSWdKSUduQjRDenZIYlVq?=
 =?utf-8?B?RFp1UHNQcmNsN0ZxdXBOR3MvNHJMSzB4NnlNbjhmWVdRWXhYMzEzQk5QaHBG?=
 =?utf-8?B?dWxKdHBSQVBWaThrVnByczZ6ZXc5UFhGYXdDMFBQQVNMdjNqOXJhaGNSRXhY?=
 =?utf-8?B?Vmk0NXZnRTJzZnFyUjVLVEk5MVRoeHd0YkE5eHlFYkVNYllUbDZaUkk2eklO?=
 =?utf-8?B?U3pONXlSUVJHdmxQZFpqV3VNOXpZWXlhakJIMUVLd3hGMWh6NS9XeVNkSDl3?=
 =?utf-8?B?L00rRi9KWlZNVWdTN2JhTGNEcGp2WGZJcmh1NTlqYnU0dU9UUGoyNDh1Z3B4?=
 =?utf-8?B?Y2tOb25TOXdVb1poSVcwUFlqWWw0Wmg0b241Vm5ZUjZrcjJPL0R2WW9aQnBO?=
 =?utf-8?B?SVdDVjFmMVY1V25OQ1J4UVpQeXZNQzkxNnpud1NnRDFRcVgwR1oybUt3WUVh?=
 =?utf-8?B?MHFldVdxaVl5V0llcmxNbG9nSmpxQmpMOXFqNzNWV0I5UXJod215USsrbXlG?=
 =?utf-8?B?ZUpWU1h4K2ZDOGZ3T1UxdlhGL0I5U2VrVFNEMGNoZnlxTlRHeFhKZElrWjBM?=
 =?utf-8?B?V1I5a3ZoMitndGJrM0JtQnduODVpb25hQjlHYzJ5Njd6dDByWUgrS1o5U2Mr?=
 =?utf-8?B?QldUeDdVZHI5ZG5jK0pnczV4S3IrMjZ5aEJBcDU1c0hicEFUTnlwTnVoRjVj?=
 =?utf-8?B?Vnp2U0NZbjVtd3Q5NXkyQkZRUE1KOUh4SGU2YlpzU29Pck5PbzFCMlU5RGxV?=
 =?utf-8?B?RWFRUGdNaWpvaThkN1FSVm5odElOUDBRSkw4Tktyd203d2djbDVzQjVXaktK?=
 =?utf-8?B?anoyV3ZMcmNPRDI5YUlYaDNFcGVvQXp2TDlla0Z3UmhiNXNhQzFuM3lzQVhG?=
 =?utf-8?Q?So180yeTvvNCOCnUll?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e01ee7-24be-401b-5c0b-08df399705ec
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 10:41:31.4024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9UAOhr1hxi/ZAvay8OJOsjKeXCG5X18JLKubIbObVK/VR318Gk77IJ3ZNXouepZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8022
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 03-Nov-26 3:58 PM, Priya Hosur wrote:
> smu_late_init() re-applies the DPM level with
> 
>    smu_handle_task(smu, smu->smu_dpm.dpm_level, AMD_PP_TASK_COMPLETE_INIT);
> 
> but smu_adjust_power_state_dynamic() only programs the hardware when
> 
>    if (force_performance_level || smu_dpm_ctx->dpm_level != level)
> 
> AMD_PP_TASK_COMPLETE_INIT passes force_performance_level = false and
> smu_dpm_ctx is &smu->smu_dpm, so the level is compared against itself and
> smu_asic_set_performance_level() is never called.
> 
> PMFW is reinitialised by a reset and comes back on its default curve, while
> smu_dpm.dpm_level still holds the level the user forced. The device then
> runs at the default level while sysfs keeps reporting the forced one. On an
> SMU 14.0.1 APU gfxclk drops from 2.8GHz to 600MHz while sysfs still reports
> high. Writing the same level again does not help either, as
> amdgpu_dpm_force_performance_level() returns early when the requested level
> matches the cached one.
> 
> amdgpu_dpm_reapply_umd_profile() restores the PROFILE_* levels after
> recovery, but returns early for any other level, so high, low and manual
> are left on the PMFW default.
> 
> Force the level to be programmed for AMD_PP_TASK_COMPLETE_INIT during reset
> recovery. The cached level is left untouched, so if programming fails the
> level the user asked for is still retained and the failure is logged.
> 
> Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index a901f8535598..654ff6824fdd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2553,7 +2553,12 @@ static int smu_handle_task(struct smu_context *smu,
>   		ret = smu_adjust_power_state_dynamic(smu, level, false, false);
>   		break;
>   	case AMD_PP_TASK_COMPLETE_INIT:
> -		ret = smu_adjust_power_state_dynamic(smu, level, true, false);
> +		/*
> +		 * PMFW is reinitialised by a reset, so program the retained
> +		 * level again even though it matches the cached one.
> +		 */
> +		ret = smu_adjust_power_state_dynamic(smu, level, true,
> +						     amdgpu_reset_in_recovery(smu->adev));
>   		break;

There is already a reapply profile to handle this.

Does it work if you replace the current smu_reapply_power_state_dynamic 
by calling smu_adjust_power_state_dynamic(smu, level, true, true)?

Thanks,
Lijo

>   	case AMD_PP_TASK_READJUST_POWER_STATE:
>   		ret = smu_adjust_power_state_dynamic(smu, level, true, false);

