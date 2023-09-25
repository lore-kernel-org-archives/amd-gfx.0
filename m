Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE3DCE7AB3
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 17:50:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B2CF10E2C1;
	Mon, 25 Sep 2023 17:50:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EECDB10E2BE
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 17:50:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TH3uryegRJhTzKUjM4yHlwz2H7E23fnUxtNelQe01y0tuQRYF4W1WYk9AWf93tbHQV5K+bFOOG8RgGpoRGLjbnKl/adBYl2s/l9jaNdLSTbpeGjSihEeAYRt/uGqsnB5y/eDjDgK2Zy25fH7uKEvoI/zoeo654n7gZjUQrbo+mIqfMQ7zkVUG5P5wNgfjGo1T36S8hi05xXm479W+XqCb/L7aP3VR+Oa5EcppzJvKI9AyBm7YFSq63aC/28nl2nqgl3Mdd67gWxx3UKhCg2jFhdtKGm2l1qMwNAh8mRpBqhe7mdSiaYud4UtN7Gz3FDeCXDzt8Q1eLbbzPQ2KJ1iSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4VWxo44FSLrPmqtWwKhADsn/wAh3H90VedYm5R+OM8=;
 b=EDyrARIf6MuYZVaqMOhyvxY0mow++x5EbbvC2wdYgIE8tN+xz65ekIM+F3ZQeZ9QYSKA/vtaHOh0p4JvzUjkp+e6ZSrVv1UFn7LeYqv46LjZ9cDgve72iWeOSK2BAopiTDPL8lXqYDysr89WNMLNNX4MdIOtXncrOY647y357cDznsazoQ505az0qFmPfuEY5R/mmVTmzELrGOc27NHVxRLg4xQus7xn2E0WFkGz40Ovnhw2LT0uHpF1quz7s5kmUldydSt8+Dvqvvl45MroD+F2vcYdpKWed8E5Zbg7XuGovuV6oSu+7AjDbwXmnIip9sero5ziA6QuMk5DB5Yu1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4VWxo44FSLrPmqtWwKhADsn/wAh3H90VedYm5R+OM8=;
 b=sGuDx22tFIjDm487l84fkQx3UkIGVPztJqfNoxGjRp8OxulCw8FQTst47DwA9+B4+vhRbIgQWsrBkS4fQLQmhZ5ucbuMaL+ezJfTXBKxpercSJW1nzF/TfWrV415T9xuUCpxfWq/pMgixJaOmSATbT19iVh5flBKB21nrDab7dE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SA3PR12MB7975.namprd12.prod.outlook.com (2603:10b6:806:320::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 17:50:07 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::121e:5e68:c78a:1f2f]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::121e:5e68:c78a:1f2f%3]) with mapi id 15.20.6813.018; Mon, 25 Sep 2023
 17:50:07 +0000
Message-ID: <843e9cef-cff4-479a-ad0b-6d161d5d7c5d@amd.com>
Date: Mon, 25 Sep 2023 13:50:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Propagate failures in dc_set_power_state()
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230922201243.104935-1-mario.limonciello@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20230922201243.104935-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::14) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SA3PR12MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: d65618a3-9594-4199-185d-08dbbdefdb05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0YSDHAFhNxvIya+6fjmToce3JhSIFmLMzyH3SRkcPylH6+OlWNyPvngHT76iB0OAvsFtlr2HCk0iKnY2a1kpw4voOaBXjwoDGkCNhQ5nDbak8tCsCpZ8E1J4ecJw+s6lRbOfsG8LyIuvtrHeqOsPx2j1u5wRLhzRtPbsQ/mYB2mUSH4x4VqI+2vlFL1kAz7tspZ6hlgS/EynxdqNPJFPVCwYtxtMPIdjiR+mTKtj+7Pfds/pIPASiQaEtbFOgXIVc8/oLjlariFfPQs7t3aix9xGl67FenBIlqaIEjwQDaIzSPTM0vcaqbGfDi0Zl10oTKEK/aSVNDfOpK7xY0iRCgPJvb+fqen6nIYSD5j2qbzIvPMA4KdA/ydPm17KG6jgbNOjbKiWfQVvPnXu4afEqLWBW5rw2mQyqtNnBNnY6drI9DgG8ZF6ALrbem8Xwo6C/kiOc7KvjnH6WoimAG3t9W5qUqoeB0IRmKmKqlV3Fp186+7Eu4xwZJ55zpFvdbD+acR22ZT0Mofqv4UmNh2NpzmqVC7kDA+W+m1S1UHfQD6oC6QwZ1KjU+786vvePR6YKNocMq/5Tf0BqYGryyxesNUIdtIzdsM4qnMb5iHgpVW0D+Kd3fxHG81SMeKxwtOY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(230922051799003)(186009)(1800799009)(451199024)(2906002)(31686004)(5660300002)(66476007)(66946007)(66556008)(44832011)(478600001)(966005)(6666004)(6512007)(53546011)(2616005)(6486002)(26005)(6506007)(8936002)(8676002)(316002)(41300700001)(83380400001)(86362001)(36756003)(38100700002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEpZc1M4SFNsY1M4NlRmZEVQY2hPTjZRWWhjLzA3UkZybDNGRGxsWThaSEZy?=
 =?utf-8?B?eUZVaG10MjgyVmZhUHNPL0dJU1p5cG03cVdldWc0R2E5c09QYzFtS09Bc2FH?=
 =?utf-8?B?YnM3YW44b0hpWit5ZFNwQTAyWFNsZjBadXNDSVBxVDFBR1VrRzlLUXBGNUQ5?=
 =?utf-8?B?NldZL2Nlc1dURUNwbm8zVTVSSXhidDBBWkV2WG1JNmQwQSt3UGNDQlA1d2ow?=
 =?utf-8?B?Uk1zMWx5N0xUSm1FMjlBdFh5UFFqT1NlSGlERFQxN0pSVjc5K3FJUVg3UXow?=
 =?utf-8?B?eEZyZ0wvbmxFM3p6YW1mdnJOb2ZReHNvRGFsNzgyZGJmL0NZdzdRWVR1OEdC?=
 =?utf-8?B?eVFaSHRNQkRzUnU0RHR3V1U2MnYzUWdwTElUREdVbTNiaHZjRHpqWEtqL01H?=
 =?utf-8?B?bmhkOXN1K1RjM1Q5N2hPWlM5VFMxVVluMG9BaUNmU1FxdDJvUWUwc2lZazFJ?=
 =?utf-8?B?UFdRcmVNcHBpYWJ4QjBtWGd3Nll5WFcxUXRVM2pVaXprR0FzQTZwbUVNTnhl?=
 =?utf-8?B?Y2RHbmUyOXhVRG5pQm5tbEk5UXNFcG1KTjlkNmJ1WVIxYzFpendIcHBlTmlH?=
 =?utf-8?B?ZCtkdURTaXpmV2ZlNXVobGk0TFcvbXg3QlBYSmN1MkJsL2FKQ0E4OTR6ckNO?=
 =?utf-8?B?TS81QUJRQ1puL2czV0pNeHU3aEt1a0QydGxINHloeCtHQmRXbWFQTTdjY0V5?=
 =?utf-8?B?YmowZWFWbW9WbVBRbFBZbTE4NXhhZnR2Q3E4Wlg3L1BkUlJyMUhiS0VzMmJw?=
 =?utf-8?B?R2Q3dE1KNTdLQWxEbkNmbUJtREoxL1I1Y1ZaOWxRbXZVdmlkc3RnaFRSSHEw?=
 =?utf-8?B?Nm5TdGdnVTl5VnR5TWZlZ3dCUXNJWFdOZ1dYQTZLcndJS25KbWI2dFQ5VVV2?=
 =?utf-8?B?SlUyOWIwQ2V1am5FS0o2clFVc3NLelZvSDhnZUZKNWhNd1Zzc2RWSGRtd1g3?=
 =?utf-8?B?NFVFTjJxRGFleHJtblFoL0FqQ2s5cUtrNnpIaUlwOFJVdllKMDlkZUZyWEVu?=
 =?utf-8?B?bVlObkVuVVR4eVF3S0d2VVppQUlDZ05LdEQvcGtWM2pLeGc0U2FBNG45UjJZ?=
 =?utf-8?B?Q0RWWW11OUhGamJlbkxFOFEvY0lsalk3Uk1TNVR2Q2JDcFFMbGxHYkVKM3Y3?=
 =?utf-8?B?YTNiSHI4QkZrbmRaalhGZllkN24rSjhtdW1WZ2NIWmR6YWRzYmNWTkdjYy9Z?=
 =?utf-8?B?S0V4MlUxdVlCOTJWVE1la0FiZnBqYjI2cDhYMlZGVHgxZjlITjBpS2dsakdx?=
 =?utf-8?B?YVdUWFdMUlZXZWp1VTl4dXppbnR3MGJMcWNyQ2dmOFpQVko1SCttcEMwZHJY?=
 =?utf-8?B?Wm9rOExGWmIxRnZUQVluNm15aUpRajFNVHhhZDhmZjhqZlNoTlVkQlRsUHNK?=
 =?utf-8?B?WHVxb25tdUVkZUZTNXp0cG81MnVjRWdwRncrM0x6cFZFbmtJdmJRYlhnNUcr?=
 =?utf-8?B?V2c4UUxhN3hGNDBGaE5IbWx5QzNNcHJQak5jdzRoVFRRVldGTnpZYSszRjBH?=
 =?utf-8?B?UHFRMTM0YytjYlQvUjYzcm15YkhoWlFmNFVOTVhjN3c4MXRUV0tiN2liWEpS?=
 =?utf-8?B?WkFlcGtlendtUXBJbnEwNzlzN05oeVBQbWRVcWtwbFBxUEZ4MW9laFlHdjR5?=
 =?utf-8?B?OWlld2lRcjlQeHI1OWVWOXNMRERFNDMrOS9ROGdmVWZ0dWZwSDliQm1Ndkwy?=
 =?utf-8?B?WDJpV2lxYzhETGs5cVpuT1drVm8xMUsvOXo4L2ZrUmduNXFPOXVLNUIwQXVw?=
 =?utf-8?B?N1BVUDJDRWE4OXF6YU5uWVkvSmlkV1NLejhjdFpmdkZvVEtZcTRIQXZyOEdX?=
 =?utf-8?B?cDBZYUxnd0J3bTZqR1h4K2xpcDBVMGd6bzI5bEUveGxGa004ci9DaytMak1U?=
 =?utf-8?B?aGVjUlBCNm9FNTFOcWxwcXNKbEhuQTZsaTY5N0pDckpvdW9aTTlXS0NrWElV?=
 =?utf-8?B?b05OblkvbW5mSTdrU2VCQnlJdE8xKyt0NEpXNDltTWlJZjhYdjRWMFBoSzdn?=
 =?utf-8?B?d2pXc3kvT0VXMlUzV1YxajZLYnBzMUpkY3QyMmtsaWVia2ZnV2xBaFIyTkNM?=
 =?utf-8?B?dTAxa0h4THpqMzJpSzg3Rm5UY0FnbWtsK1JzZm8vM2ErbkVzcE80ZDFYdE54?=
 =?utf-8?Q?QBAVJy1l8zksSLpdhoMNscUQi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65618a3-9594-4199-185d-08dbbdefdb05
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 17:50:07.4919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /b+eqYaJfHIF+wcud3cPFwkRZdkoTbAEsZqNTiDXes35WkfEnKfqwOHl630qntFsR19ulqsNFqfYmpEiERxehw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7975
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



On 2023-09-22 16:12, Mario Limonciello wrote:
> During the suspend process dc_set_power_state() will use kzalloc
> to allocate memory, but this potentially fails with memory pressure.
> If it fails, the suspend should be aborted.
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Cc: Harry.Wentland@amd.com
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 ++++++++-----
>  drivers/gpu/drm/amd/display/dc/core/dc.c          |  8 +++++---
>  drivers/gpu/drm/amd/display/dc/dc.h               |  2 +-
>  3 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 373884ca38b9..2acb555343ae 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2670,9 +2670,7 @@ static int dm_suspend(void *handle)
>  
>  	hpd_rx_irq_work_suspend(dm);
>  
> -	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
> -
> -	return 0;
> +	return dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
>  }
>  
>  struct amdgpu_dm_connector *
> @@ -2865,7 +2863,10 @@ static int dm_resume(void *handle)
>  		if (r)
>  			DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
>  
> -		dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
> +		r = dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
> +		if (r)
> +			return r;
> +
>  		dc_resume(dm->dc);
>  
>  		amdgpu_dm_irq_resume_early(adev);
> @@ -2914,7 +2915,9 @@ static int dm_resume(void *handle)
>  	}
>  
>  	/* power on hardware */
> -	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
> +	r = dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
> +	if (r)
> +		return r;
>  
>  	/* program HPD filter */
>  	dc_resume(dm->dc);
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 293489c41086..a1593d550526 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -4711,7 +4711,7 @@ void dc_power_down_on_boot(struct dc *dc)
>  		dc->hwss.power_down_on_boot(dc);
>  }
>  
> -void dc_set_power_state(
> +int dc_set_power_state(
>  	struct dc *dc,
>  	enum dc_acpi_cm_power_state power_state)
>  {
> @@ -4719,7 +4719,7 @@ void dc_set_power_state(
>  	struct display_mode_lib *dml;
>  
>  	if (!dc->current_state)
> -		return;
> +		return 0;
>  
>  	switch (power_state) {
>  	case DC_ACPI_CM_POWER_STATE_D0:
> @@ -4746,7 +4746,7 @@ void dc_set_power_state(
>  
>  		ASSERT(dml);
>  		if (!dml)
> -			return;
> +			return -ENOMEM;
>  

DC code doesn't have a concept of Linux error codes and is
shared with other platforms. Can we follow a similar paradigm
to the other DC interface functions and return a bool, with
"false" on failure?

Harry

>  		/* Preserve refcount */
>  		refcount = dc->current_state->refcount;
> @@ -4764,6 +4764,8 @@ void dc_set_power_state(
>  
>  		break;
>  	}
> +
> +	return 0;
>  }
>  
>  void dc_resume(struct dc *dc)
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index faf897ac75d8..82013ebcba91 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -2329,7 +2329,7 @@ void dc_notify_vsync_int_state(struct dc *dc, struct dc_stream_state *stream, bo
>  
>  /* Power Interfaces */
>  
> -void dc_set_power_state(
> +int dc_set_power_state(
>  		struct dc *dc,
>  		enum dc_acpi_cm_power_state power_state);
>  void dc_resume(struct dc *dc);

