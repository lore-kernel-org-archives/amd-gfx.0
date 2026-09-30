Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A7ACA5FBA
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 11:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC4A210E571;
	Wed, 30 Sep 2026 11:26:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jDtlAOGP";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013020.outbound.protection.outlook.com
 [40.93.196.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF32010E571
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 11:26:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2f7PKk0GkqA3K7Fz4Qu9PmJXYrLK2IfuFWpd1WZ+zMpLZ9JBslgc4wj+bKR8z2isAxKI+pmCJEYd5ASmNB6QFyeLwy3sU4lvUT+IcU4sLpUE6pP3h++yrvs1ZmmCrJXsgv/KA+FueBqZkBC5CxBz6MszndKAoWYo0ed/0DsXpeuDb7FNK8P5rrUCUcyOjGsIkt8UeGHL7glv2wPTNpl9Uw3/bW1TPEUqGrBmsay5GqYMnkiyqgABb2VQQFVgQGWKAmUezgp/ZT57aICDDbscTRZjEe05T25sCdScbmT/bTD/9lvIbICM76xp4g1oOwF45RxaYX0k4/+4MMtGP3nKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEX0VKOHN2+xr0QWCTRbvHmZrBQ6OJUg7ysiFMmjOHw=;
 b=kI4g8vMujUHyLVvqmqq/vqpNUrosCHQ9UomqG0iHZBzoLi3QmXX7WGpWYGOPuQj9xyhtyZdihIKn15+S/BD4/56lfyGM070G7cXDtYl1vHLNOjKRlE2EQA05BgvaB4a1piLs4pD0FEsgOhH/36+wCjHy7mp3guC002ycmFA9HBK2iPhD+AMIOxOwZ7KsnCdJk7Kg5O6/ycTkpm4TBzXePisB4Mog8Wmewc/Ioy4HsumDF60bxVa1wkU+jnGLZoGdse2shq/4GdAldA9NVOdZiMRBTkJniCeicZgUSnn5TMFoApP3QYbRMJTF9ugCRy5ludzlJzUdUilFqbbDKyPTuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEX0VKOHN2+xr0QWCTRbvHmZrBQ6OJUg7ysiFMmjOHw=;
 b=jDtlAOGP59GrexzRcsIvA0I9ICIe3q/K04IV3EiDrjEY9MVapPCvbYG/WcLEnwGyVFXPgIVKhsIA755oxXkKy3GSC49lxOwZ4HMap9R91fyOQj6qaZEcnz4AF1Y/D/iD08Dce18rDZzKZWjklJD5RncFyfPfJXKkROLqCTlXr1U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CHXPR12MB999243.namprd12.prod.outlook.com (2603:10b6:610:2fc::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 11:26:02 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 11:26:02 +0000
Message-ID: <1ff26404-19cc-42d1-9792-e6e557b2fcc8@amd.com>
Date: Wed, 30 Sep 2026 16:55:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/ras: skip RAS TA firmware reload on resume for
 SR-IOV VFs
To: "Hong, Chi" <Chi.Hong@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Zhang, Tiantian (Celine)" <Tiantian.Zhang@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>
References: <20260928061148.117428-1-Chi.Hong@amd.com>
 <LV3PR12MB9235640A364B16BA772702889F8C2@LV3PR12MB9235.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <LV3PR12MB9235640A364B16BA772702889F8C2@LV3PR12MB9235.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0116.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CHXPR12MB999243:EE_
X-MS-Office365-Filtering-Correlation-Id: 36482b72-51c3-4254-9018-08df1ee59c10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|11063799006|5023799004|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fIwUQ16IvAXOffFXE62iS36fwSoERLqEt7K8y/70WtLoiDx6xM91xjbJWCX5Fc/VhfUSmb4Gommx+5Nn7zcOcZNlRczfqf0O+Jk5NSfwZTpIgDiamj65mA1QNGxLqAvSRrL9ahotPW/Rz28E82yjBM5beTL2TCFg32IWF4+2K++K30APNODlZWY6MdCnA8ZqOU2WGponxAprMKcxjzqefnW7dqJqMFgfaKRjAR/R12MOQNH6dWI9dMSE0X0g2HCLNDVSCbKtfLQHO72BBzc2CEeMLxUSePQNkVaQYQ9DGsJTisSHJeGqczX1fYki66OyqBgn19CveZS56HPwdzrt/sBYI5iCPTycDiq2+JZEDaj8JigA7/rHc/rIX8+Kthc1iG1N4Dn2SGrPUjSa1vgCwFwc6XTqKh2fsOud0YjIuvoJsM3qfT2CCmpMxLnSj1Ox5Lz6ABhy2aSCEev8WyltBVqIhLoLA+fM4Z1l9EIgAIvbmolGrKg9W3OkRKRSIQqLzCxUyKlN/jdI+0etzNPSVvcAqDNTPqEx74bv7AiS6LdPmeyWhP90PUVghgMZ68JWUGDT7gjYqoKw1oRhxJWjTM1c/AOFWrFgBuljG4PkAmg15Lf0+yKXNYk3Hr0EwkKivV8SkpJi8mZjP22QD48x2w0Pj8ajO5jifN5AguWR690=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(5023799004)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFlKbC9ES3RqVFl1ZGR2bS8zZ091blV4MGJGNURac3A1SUdBMncvUlBLNTBI?=
 =?utf-8?B?eUhSamdlTXhpN2NESkdYRlU1WHhISVF3bmtBeExwdVJ0Rlo4Wm5XcGkrM08z?=
 =?utf-8?B?YlAzZ0tKOWdFalpNRVR4ZFJoYXhMdnlibWJQS2szanlxMWwvc210RmtnL2dM?=
 =?utf-8?B?WnBEcVZDZkZhUjNYUG9wUTV4WHF0V1RkT1ZTeEtXYVlyZ0gvYm9rYmxMVm1t?=
 =?utf-8?B?MXl4VjR1Zkk3Ly83QTR5Y2ZIeU5aR1VzM2hFTXh4OCswcVI5K3c0dmhJbEdO?=
 =?utf-8?B?ZDF5cVZUQTNmRGpBaVZSeENDNzVzbkZicTUzVGpxaGFWbzNjMThXM1VjV2pD?=
 =?utf-8?B?aDNsV0JzK0hzSU13akJiKzRWS0swSWlnWCt3NG5IcU9ORUJvM3Qvcmg0Tlg0?=
 =?utf-8?B?bm9GUGIyclFlcXRRaVNicDZac3pPbVlKL2RINXJUZW1XZStLbG1rVC9wSW04?=
 =?utf-8?B?a3pQSHcwcnNpNGtsWml0ci9ZZXAxMktRbVlyNXd3M2d3cFU5bURibFlWSHl2?=
 =?utf-8?B?M0psNjRBeWxVNWtwZzdQY2ZpRFByQ2szWDFoeWNPbnloV0Y3OXp1ekMrazYr?=
 =?utf-8?B?MGUyRzJ4SmowNVhscjgrekd6Q3Jha3VsTE8yblJOTlYzVFhQejNmTUlJZk1F?=
 =?utf-8?B?TzJJTVdZa1ZSK3ZuZHBVLzc4cVhKTzdqYXl1Q3NYNnRVZFEzOFdtNTg0bnNm?=
 =?utf-8?B?cWJsM1d1S1FtSzVVL2J6U0FWUmRwQW81dTBXN0dOWVVhSGI3R3VGc1pXaTh5?=
 =?utf-8?B?MGtiV0FGOUJXaVdaRUpXdjdFQmYzS3BnWWZzZjU3Z01mM0ExbGJ0NXVhWGk0?=
 =?utf-8?B?TWhGUDlkR0wwUDNFMHBNcUJRNkVYakppM3c1UkhOaVVnZldtRGdDcjNHSm1M?=
 =?utf-8?B?WUMzNzEwaHFWK29NV1AzMGRuYkJQcXd0Y09rdVVoeE4yZEV2NWYzNlZ3TGNk?=
 =?utf-8?B?Y3ZvdDVmd2hoQitmdlFQdlAyemRqaml4ck1xS3U5L0h2bG0yVjFnRGhMTnY2?=
 =?utf-8?B?S2V4bXB2Z0FpdEgrNkZFOTZzWnlic1V2VUx5dWlBM1FGNE9JclhISDA5ZGV2?=
 =?utf-8?B?M25MazJmNG5IKzFDMUJGUk5iSzBaeGNPSVIwSEsxUGxuL1ZSMEV4UXBRM2lo?=
 =?utf-8?B?WDFPZURLeHczbWxGWnVrWlVqVEhOTXVOUThzQUtJS2N5SnRqR0loSWVyWWJW?=
 =?utf-8?B?emROamNRVTJhRlAzNmNoTjQ0ems3dHpYUlVHS3loSzFkcE9temhDTC83SndE?=
 =?utf-8?B?bFlxa202eXBhM2pva1d1dzVYTGJMbHh6SVBkUTVEakpGZ3FjM3dlUVhxK05O?=
 =?utf-8?B?Z2dDZ3RHZFNXRWdrSTNXa043eHZBcVFmenNIV3JlSDUycWxEUm5DVjdDTitu?=
 =?utf-8?B?ZVVaZnJZaHBaUUg1SHVYQWNlQmNZd3dwQXRvYlNKcGo5Y1VEWDUzRk5hbFNX?=
 =?utf-8?B?ZVlwWm1rY0J4ZTZkVlR5Y2lFNmVyMUs3bk5TRUJtNU15VFRWL2ZuMFRUOWZH?=
 =?utf-8?B?dmJwWU1Dc2JaMGlta0Z4T2hFMEYyTDE5YW9KdGJMb3BvSERRN3YrVGUrVXA0?=
 =?utf-8?B?dTZFVzluS3EvbHF2UVc1RjNVdzZEbUpmd29GcmVOV2JQRmpiQzZ3bk5GaVRr?=
 =?utf-8?B?V3pxMmgyWTdPN2dUamQwSTlQWDRkaEM5a3psUXIwS3pNUy8rUUQxSVJZUUtq?=
 =?utf-8?B?WmkyUW1kRi8yWG1haTZycDNiY1FrbEpKaWFmcVdnei9oWEZiWWdTZVlyZ3dF?=
 =?utf-8?B?ZzhXbGN3bFBSR3AwbHpjSG9NTHluZCt0Vm5sRDdmTzNKcVMxeVNVUGtkd1hz?=
 =?utf-8?B?RzZiY0U0ZGRtc2FWWGFza25UemVsazJpRkZGWDB1LzBzcmE2eTVtd0lETTNE?=
 =?utf-8?B?b3ZZMzJVWkZCeGZiT2Fndzc3SVBxdFQvV1ZlKzJrTkx1eUx3dHFLNkpXeVMy?=
 =?utf-8?B?S0lpTXpuZjFIMTdVMitUSXhLblJ2YnFKK2J4UldGZTN1QU1ORlhNOGh0SFRN?=
 =?utf-8?B?RGN4RVpQWVZWdFk4REZRRDlrdTNHc1ZZZ3hDc0VPUEt2U2NZZmRLVEF2UHN2?=
 =?utf-8?B?Ykp6dExQSFpPZkFjV0hHM0l6bWg4MXFjR0hJQmpMRGtvZjVVVWlkZEJHWWM4?=
 =?utf-8?B?bkFJSnNabHlTMVdkUis2QlVuRjhCYmFFOEJscmxIcHA1OVpaWnVqZSswZFhQ?=
 =?utf-8?B?WjdRVjZFdWNGZ1BUNGF5YVhDL3gwWjgrMEJRVCtNb05PdnBTeDNUTDZxaTc2?=
 =?utf-8?B?TFJrRDQxbjk2MHBLZEc0SjI2MU92Q2o0VDhvM3U2U2QrUEVqaVM3OW1hK0E2?=
 =?utf-8?B?bTZqQ3RrWVp5S2lKbGgrUkNoMmZVczBBZmxQVG1SV0pEdm5IbzQ5UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36482b72-51c3-4254-9018-08df1ee59c10
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 11:26:02.6662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwU2flnB/dSoQxz4mcktEKtsl4i9LO9WwSaaaN9bxtVYCNOL1aGoB9IdcPJY0wu8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999243
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

cc: Tao/Thomas to take a look.

Thanks,
Lijo

On 29-Sep-26 12:55 PM, Hong, Chi wrote:
> AMD General
> 
> Ping
> 
> -----Original Message-----
> From: Chi Hong <Chi.Hong@amd.com>
> Sent: Monday, September 28, 2026 2:12 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Hong, Chi <Chi.Hong@amd.com>
> Subject: [PATCH] drm/amd/ras: skip RAS TA firmware reload on resume for SR-IOV VFs
> 
> SR-IOV VFs use amdgpu_virt_ras_hw_init() which skips ras_core_hw_init(), leaving fw_gpu_mem unallocated. ras_psp_reload_firmwares() then hits the NULL buffer and returns -ENOMEM (-12) for every VF on resume, aborting
> ip_resume_phase2 before amdgpu_fence_driver_hw_init() runs. The next hibernate double-puts IRQ refcounts causing a WARN storm.
> 
> Skip the reload for VFs - there is nothing local to reload. The post-reset path (amdgpu_ras_mgr_resume_after_reset) is unaffected.
> 
> Fixes: 5e5be56a5b76 ("drm/amdgpu/ras: reload RAS TA from ras mgr resume")
> Signed-off-by: Chi Hong <Chi.Hong@amd.com>
> ---
>   drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> index a02167397ce2..5bac792554f5 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> @@ -529,6 +529,9 @@ static int amdgpu_ras_mgr_resume(struct amdgpu_ip_block *ip_block)
>          if (!ras_mgr->ras_is_ready)
>                  return 0;
> 
> +       if (amdgpu_sriov_vf(adev))
> +               return 0;
> +
>          ret = ras_psp_reload_firmwares(ras_mgr->ras_core, 0);
>          if (ret)
>                  RAS_DEV_ERR(adev,
> --
> 2.43.0

