Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27421C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 15:20:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9457710E843;
	Wed, 12 Jan 2022 15:20:36 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2066.outbound.protection.outlook.com [40.107.101.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0E3910E834
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 15:20:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gg9xI1J+Fg2yo4h833CC05VDryi6oSvt5mnqILwvO8EVy8ZxaeTHRa9cfIg5I16gdJDyfISJLpoVNqVsVliAf6ayPvJQvT+jkchp28sxsqTV5L0o1Ko7g3SDGiqAcD6odcA4E452d/WPABOd/i1f6Yx0nF69nXm6zcdhZPw4vv9NTrxSaTUmSO3RpI2BwnXz+2jiK+2ddPL742rCPA20HggMcPpV8fxO3/QB4RWrtH1FRRgHQk8wWEpBicVXi6wR92Ea96jFyFCoF5EEormZHdUvbbWhPuxh62hYGanzoZhB51xdNlc+A/1pBuJNKLhuLn7FfZNuUMGPw7SEPQwHbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qihZ4GAljGCp61t4NBHE+FxJxWiy2JIBTviBiDtMS2s=;
 b=QMka6rFBKow32RplIkFq8WKSkwA7j+BmiE/q4GZZBhUWKNXh09iMNaq508cqnROdig9iN6kZMdoqESW10Lf8KXXVDaUQfeSWWfizEv4F0IkkXAZ1SQBcvPn1fjk7oQY+Je0Cu0FPBlF/B+zcVkMM4eEooWceCu1IYVOmZzq1DeyFrJOJchk5TePT1eeeVVuBdU6uafBdh8CNLlUW1wb91HXxnd7XfFIHnFij8/o4124PtIjZ70Twcx1mc7k19OWd87gxFbQH8QjJAEB7RGvABFczanNdevORhZmFePcJQVwOsEKvU16bDwjJpUJqzl/zYFIlG2i8FogWP3b5JJCtew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qihZ4GAljGCp61t4NBHE+FxJxWiy2JIBTviBiDtMS2s=;
 b=JhYDfdDpu4DIrBybHtZsS4GZCxO4+UHQkAkGNTYkG3RHpTlSjPNTu/dQGfud6HHH+KrAkA9I5ncNzQRKiEeUnXBQkcfkxg/0BAhBaM/pE8ln0dll7pqt1UeiiIrFug6iEgJChN17PVzRg5PGEpXWXIIvCQhQiQ4JtOG9ODwNVSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BYAPR12MB4616.namprd12.prod.outlook.com (2603:10b6:a03:a2::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 15:20:33 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda%5]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 15:20:33 +0000
Message-ID: <ef9108e6-e9ff-2b7c-2310-06d54788bf6b@amd.com>
Date: Wed, 12 Jan 2022 20:50:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH Review 1/1] drm/amdgpu: handle denied inject error into
 critical regions
Content-Language: en-US
To: "Stanley.Yang" <Stanley.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220112014243.6959-1-Stanley.Yang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220112014243.6959-1-Stanley.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0115.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::31)
 To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 865efbe5-8cbc-4a23-4893-08d9d5df1309
X-MS-TrafficTypeDiagnostic: BYAPR12MB4616:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB46162EC70CC480DCA1E2BEB997529@BYAPR12MB4616.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wYnTjHhxDmHym8u6QUqDi21l8elpWFdedPoAKFBzvTe8pVbmA0a3pcfYnAz8ebJHZPZdMAq3kxIpPQcjFHDZnJn3w4yTRhv3bpxNYdIL/pL2D6hD6R8ZF7eIUKWFHa5GLc+//JmgH5bcET/N04+w6btB8lpk6SkPZYYhCCeIaIXws/GbGkoChN4j8iknW8TIHGgpi7ROuqHJkfhhOoFagZTF4LTwYW174Z9Yz/uQJICI0Mg2hEfeduJR9xL/fPtM495+gbnJlu/iXfPhYyRDMnWS4ysaK5ojHKVtwlR4j+5EttSTMd5b7n1+zADpGx6L09brYVc1FLt3rqgV/GlBx7L4gfHdK1KrD190/K8gTMZqUD8VkTRfWqPSErAXB2Q5pBdGDbZfVL19xsmAoGtyWdIwalmwlagIrlsRdvRbOK04qeKt4rDPknLpJrfaBYGDi7/FrBys39CebtGuNeCgU95UnKWleQnj+BDk8xCz9s8FggzRC0WcYgtWT7qeoC71n3W0bVO2/s89A92lnJ/SYX5XTbp8bCRfmizZT5bcXz/5ccF1+fVHVcP9zdtUK5OuugiMBfxlEnMHI+6mKm+SZwTQTfF4EsZ2GRUg4fpEaZkyip7Au4Uy6D5AYIJGx24OHm1ZZSz5vXyYNoNariu+1RZ5rEj7EYegxIoSFA33nMcRZ7gpK+r0khLXvI6fXUj7/DG+ObJpAGPF2rwq0BrHXSqRP0qlyOUOitF5F9ZatxQGiM2KrqIQt+h1mz4MPmXA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(2616005)(6486002)(8676002)(86362001)(5660300002)(53546011)(36756003)(26005)(6506007)(83380400001)(186003)(38100700002)(8936002)(66556008)(6666004)(66946007)(66476007)(508600001)(4326008)(6512007)(31696002)(2906002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm5HeWp0YWh1ZDlDT3pPVERyR0ltVjJWZmNMdjQvQzR5a3htZ3pxblhWUXR2?=
 =?utf-8?B?bnRIWmV0Y25lNUFUeDZVVHRuc0x3U2pLNC9hU3BndTR3eGFUN3FnbGdsSlgx?=
 =?utf-8?B?V1hDOVp5Q0ZYLytrSTZFbEpsZ3F5ZjA5MDJXeXZ5cDhIT29iU2I5bVhjUUwv?=
 =?utf-8?B?cWxUZlFuYTJBRlQ0TDRKbFlZVm10VmJRcGw5aE54enhNcldVeVkzby93SVdV?=
 =?utf-8?B?ZlIxM2RvV2JwRDNaOGdmUktaZW40U2hPWWlJdjQrNzBVblVENUxOQTVkTU9i?=
 =?utf-8?B?R1ZlallVYlBrNHpFOWx5ZFNsT0JPWGZ5UTFXUkRlMlpxbktXNGxxMUVRNXEz?=
 =?utf-8?B?NnJxbEVvUHFaTFFlYjEza3VDWXJJd01MTXdkdW5NT3J1NHA2OURUdGNJMmlv?=
 =?utf-8?B?OHRubTA3Wm5JMzVubVFPdTk5TzdoSzFSS3d4V3Q2Z1JSM3I0amZvWTVGRVdz?=
 =?utf-8?B?cDVYeGhCZEZENEdyYUU0SldXck9Zc2s3NmtOK3d0TzBobHI4RlhSSXR1T2RJ?=
 =?utf-8?B?N0hRMzdFVVlQaDlWWjd6ZVh1UHI4N1pGZGgrYlZIbk9MS2hPZEl2a1ZLSGdt?=
 =?utf-8?B?NnROKzVoMmR2cW5KSW5kTlBRSjFWeVl0aFdUUVY0K0NoUytZVS9TUEVEa0g0?=
 =?utf-8?B?Z0xmdkhsN3BTN00vUXpWOCtBTUZkL2s4QzZuc1grclIxOXhsN2c4WDFoMEdL?=
 =?utf-8?B?T1RaUjQ3YWQrc1BlUS9lVTZqWnJZeVZDRnZMN05Qc0dYS2VGK09nTUgzSHQ2?=
 =?utf-8?B?RWZ6S0ZmaDB2b3o1d001NURDeGd6Y092TTVCSE1ESkc1OEhmYWV6dFhNL1BV?=
 =?utf-8?B?YXAwcGFrVUdFQVE2VXB3SFVBcElKak9UME1qQXk3L2k3cnl2dmNjVWlDNmMw?=
 =?utf-8?B?M0RMWGNnN3k5NTdEUjUrZk1mV0tTUUZOajRzMHBrWERuQkpTcTdkWnFHL05y?=
 =?utf-8?B?TDJ4dENMVFRWMVVpZ3l0a1l2a29LR3F0cnc1Z2RSNFVyOFd4S1loZk1keTha?=
 =?utf-8?B?dUJYTmYrUmU5SXRwQkszdkVENVhwdVJ6aWFzWTJ3ellFYTBXcEQ5OFdPTy81?=
 =?utf-8?B?MU9xcUJ1RmxGNFpMbE5GVitneGhqZ3NxeGxmWFo0SGoyVHU5QlE4ZFVTeEtV?=
 =?utf-8?B?M1BsZWgxWVhVQWt3ek9KbXJrNWp4a3FTS1FFUFVZRSs0S0J5akZMSDJIS3A3?=
 =?utf-8?B?QkxQNWJobHRDYVZlQTUwL2doY2pDWDM5d2NUVlBsZzM0Q0VWZlIrdGN4cG54?=
 =?utf-8?B?VVFUekE0VzA1THZBU05NNFRSTmhOSXpORGxhUDJjNjZsaDUzWTdIUnVpRWgr?=
 =?utf-8?B?YkZTZ25XSTR1WFhxVU8rQnhqQ1cybmRtNi8vWnhWa3R4MVBORzluWXZ2S094?=
 =?utf-8?B?RnRJT1hHek1zN214Smp6U2U1b01ZUjUyNmpFMDZkTXlxcGlKMmdQb1BxMlFm?=
 =?utf-8?B?N1RRVUtVMklYYU5Ma253YWJuYUV5VEg0d213NmdRbGRPL3J1dUI5RHFORURD?=
 =?utf-8?B?MDQ0Q0NzQ0I3ellBZlh1WE9LSnd1SGZGUmJFeDFQNUtxMkQ3aHA1L2M4N28r?=
 =?utf-8?B?eTRKMzhsVW9BSzJqanZJU2U1cTZkS0ZBbUJOT2duc3JvNFQrazNCb1ZGUFha?=
 =?utf-8?B?V2NXaEtRVVB4MmlOeFFSZW9mR3pnbmJjc2FhbjVNSlR1VldQVkRjWldweUhD?=
 =?utf-8?B?V0N1WE5qTGVqelR5dEE2MjgzWnBGb1lCdVZMTFdZWEcreWhwUDV3dGhEcElO?=
 =?utf-8?B?WEJ4Qm5QZTdhYlRrVTdiTUEwbjR3b1dDNlRCbTFZbFc1WVJodWh4QVNHd1Zk?=
 =?utf-8?B?QlkvV0tTTFJxRkpTbHBQTmN2VkxVSHhDZDI4bnB0ckRrRkJScSswMXF3Z1BU?=
 =?utf-8?B?Vy8xZHZKby9Jb0x3UklmdnJZcnczZmFPYzNzdDI2MithK1lDMzM4L01idTEv?=
 =?utf-8?B?NFpDNFhsUDRtV1NyQWcxTnljdG5UZS9RR2NvM3RENEJoVHVtb2FqcFZHUkRm?=
 =?utf-8?B?THI1cXJydDVQQWs5SVh4K1U1eWUvejhyK3JZV2U0Nzc5aEQ1WmNUbDNMK3ly?=
 =?utf-8?B?QmQzb0oxak1ZbHN4ejdOSm9BZ2tMMC9TR2E1YTlxUk1XVUpyRmd1alRJV1Bx?=
 =?utf-8?Q?73rM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 865efbe5-8cbc-4a23-4893-08d9d5df1309
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 15:20:32.8590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5PUAbQe66zMcKeSkGPmC9GuhaTKQOxwAx5AM9CGJhRIKtZ6TGUFPw81uo6sxrQ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4616
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
Cc: Tao.Zhou1@amd.com, John.Clements@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/12/2022 7:12 AM, Stanley.Yang wrote:
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 10 +++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/ta_ras_if.h  |  3 ++-
>   3 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index c742d1aacf5a..8e0ea582b9c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1309,6 +1309,12 @@ static void psp_ras_ta_check_status(struct psp_context *psp)
>   		break;
>   	case TA_RAS_STATUS__SUCCESS:
>   		break;
> +	case TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED:
> +		if (ras_cmd->cmd_id == TA_RAS_COMMAND__TRIGGER_ERROR) {
> +			dev_info(psp->adev->dev,
> +					"RAS INFO: Inject error to critical region is not allowed\n");
> +		}

Instead of doing this, why not print this in psp_ras_trigger_error(). 
i.e. caller interprets the error code and prints the appropriate 
message. I guess that is the single entry point to send TRIGGER_ERROR 
command.

Thanks,
Lijo

> +		break;
>   	default:
>   		dev_warn(psp->adev->dev,
>   				"RAS WARNING: ras status = 0x%X\n", ras_cmd->ras_status);
> @@ -1521,7 +1527,9 @@ int psp_ras_trigger_error(struct psp_context *psp,
>   	if (amdgpu_ras_intr_triggered())
>   		return 0;
>   
> -	if (ras_cmd->ras_status)
> +	if (ras_cmd->ras_status == TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED)
> +		return -EACCES;
> +	else if (ras_cmd->ras_status)
>   		return -EINVAL;
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index e674dbed3615..8bdc2e85cb20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -449,7 +449,7 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
>   	}
>   
>   	if (ret)
> -		return -EINVAL;
> +		return ret;
>   
>   	return size;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
> index 5093826a43d1..509d8a1945eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
> +++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
> @@ -64,7 +64,8 @@ enum ta_ras_status {
>   	TA_RAS_STATUS__ERROR_PCS_STATE_ERROR            = 0xA016,
>   	TA_RAS_STATUS__ERROR_PCS_STATE_HANG             = 0xA017,
>   	TA_RAS_STATUS__ERROR_PCS_STATE_UNKNOWN          = 0xA018,
> -	TA_RAS_STATUS__ERROR_UNSUPPORTED_ERROR_INJ      = 0xA019
> +	TA_RAS_STATUS__ERROR_UNSUPPORTED_ERROR_INJ      = 0xA019,
> +	TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED          = 0xA01A
>   };
>   
>   enum ta_ras_block {
> 
