Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009A2CD98C7
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9446910E840;
	Wed, 10 Jun 2026 09:40:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eDn8X8aR";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012031.outbound.protection.outlook.com [52.101.53.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB98410E840
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:40:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drNDWaueZpVszFNwNqLKic0pg9TzlX7Ngzb0SfYQ0ItGNf828DPotrp7GwTiYibDgYuBcMpUpCS04coGbMU66BvbTsI6jw/+uK3LJqJ/gqtm1I2R1FTzidEoIZ8ps58nLu1EYBXc0T5WiHHezV0h5dv9inKrl3ivQKNLNVj6uJAYldqjDGk/F/CXZucjHOEMt55nlKpskYYpkivrO7uufPeLKVVybCPh/FJ/BLo+gdlxZcmHAMpTttAPuFCAKv3qe6BJSyXInurfthe8jlGPGKjUc0fDTHPS9EyQylX+9/XSnF1Icexr6k51LvWP23qBj8Msp94vMYFfpdoTn9Mtbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAuwBLc/+8WWq6SZ7GSRiqB4m4141zJz16k9OI/+qlU=;
 b=O+WeeiBUL5sxNOsZFtDJUDqVVnpz9/hyR20unkG0cVcpsDBMCxSRjr23PpKpJTwjER0ZciIaYn5zXfPmb6C4/6Y8fVvJ0/p939bpXKNJWnN950912Zv0L23W7Ez8Qas82Csd7HmtfZU8sCTWGwMdGPR7RmaczhS0LY8UmKNKUsYdV2fvtycytSkls0tDvSLoxrWj4YTMJ2m92kHbWSKXk8+stBH28Z66rFi/AMfAd1bv2LPZnsy4nSUBn4ieq2HRAx5WIB/wfhtdgwG2gaWqUQK/FBOLQ2f23hlMFxWm8o0J1tIvGioPI663f41VN8ZcENKo0w2oYuxJgJcoiZGC0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAuwBLc/+8WWq6SZ7GSRiqB4m4141zJz16k9OI/+qlU=;
 b=eDn8X8aRJ4GTrC0hgLHgJkebMwJ+GWM2VmVizV1avVwWqpv48u6vvfwvMHMABpNmzjfpOiXC88FuHejl+d4t7F0jQBQV/Yu8c+whLXSPfArbJ7Z2YnVyIhfu6w6pr4FVgZs6lYGMv/geRrmGyaqbIVWc1mfkjCuBVOep/SvuN08=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7654.namprd12.prod.outlook.com (2603:10b6:8:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 09:40:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Wed, 10 Jun 2026
 09:40:10 +0000
Message-ID: <576303c6-9898-4e84-b3f1-206c5bf577cd@amd.com>
Date: Wed, 10 Jun 2026 11:40:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/9] drm/amdgpu: Add helper to access the fpriv
 eventfd manager
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260610060402.2769642-1-srinivasan.shanmugam@amd.com>
 <20260610060402.2769642-4-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260610060402.2769642-4-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: 4383e24d-6ca1-4eaa-0f28-08dec6d4438d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|4143699003|56012099006|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: qDmtB0qqd6psTi3QpETycs+St9pkwKJQ9SFtzlRSOvg6SgFqn6zEuQ3QsCVCUUWby4pX2/hXJUzYfx5MRQ1M5Xt0Wk/oAqyhpWYgFU3klk+OQlkrL962I94WRimjUq3ur8p6yGwiD7/O6bvuB1ofOU2UPCZJok3VVPw9smB4n4ClLtTdjBQUgwJtEenCLXgBNrvkuiutQX94x1Zk71Y9eFWIc+GBOJMr+jEW7HrBCUqGeDAB7MMvPLSV85I5ahcXWBr+6Z0EM1leKE/FdnbPH+EXYpvBIxW1x790lpkY9iqd1awqh57Oz8P/ya13b6Z/WmBxSWBBIL5vTS1r2qgIXdDoX+FKwocmowCL8RHr1GCgW8sa8NiBT6W6XtjriRGdLXiCaw6eEcibrZrAOfES0Ze1A+yHXppdrzRoJyx9Zeyckz75IgYEwUPLOPP7TgfFSDEm2Pil/tGDSobDloj8bLydrArE8rPm5mrsYvOzTVOs+Yqa+ExdUWvc5ZbS1RKUAChwmRrMpT+vWcTtISGGHa2+VM7xanovUhJWBGEhA4WNsbkh2HH0Fq31P/cbweAKugKmSS1yfqAyZ9Rs6zX1d+EJ317m4sSB1SnUglyrHuqL+9JipXAYO8D6t0/wRQVlISUDdedhgvJLH+OHIqKlYKJXGQLKtssvbomT6h3qanN7mhT7hROyxmXHRaxxkDzG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(4143699003)(56012099006)(18002099003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXJISXJMK29PdWtkeWp2aHhubFFBRnFMRFkybXZ5VWJ3SzdmTlNpcmNHZWJx?=
 =?utf-8?B?WXdZZkU5RklLUk5BcytiZFJSS0l6bThPZVBtc0lSSDVIYWcxV2ttTXFEbmwx?=
 =?utf-8?B?NVI5c1p5R2F1dVBsVldwMG5pVm9SbVozSTYzbU0vR1p3RjROMTlsWDBtcjE5?=
 =?utf-8?B?ZWc0UCtjalZyNHBMdWw0VTY4VmZtMm5QZExoY3dZbFJvdUhKQWR3WWNhbWVy?=
 =?utf-8?B?ckxwNzBUc0xUd29uc2pzVUxXMm5GUXdkNkMwcElLUk1TVytYOXp1U1FnUHBl?=
 =?utf-8?B?OURXcjhmdGtRb3I3NVR5bnFBbmtFcTBMMzBxUlJVYUFkT1duUkFzcTRSQ1FQ?=
 =?utf-8?B?VnpkS2MyMU04dDZpOUZJYWZ5U1U3Nmh0UFFGdUcxclgvRWFOaGxpSEt4aUM5?=
 =?utf-8?B?TCtmeFhhV290Z0oxZk03QXdwNEw4a25CVjZqRDJ1cHBhZi9wajFWQXpnTzRz?=
 =?utf-8?B?Vi8zdDZaaDZVMGpMVGw5dCtqOXEzbGRzV3c0MnNrUkVWclZyTE40MFg2YmpT?=
 =?utf-8?B?ZU1TeitycVA3TExndWFFY010eGhGU3Jtb0pWYUEwT0IraW5DampkeUtWVU5h?=
 =?utf-8?B?Z0xSczZHdjZzdEdWWEJEc2UwUi9Qc2pFbUczOWZabDd2Nm14TlZPTGxmU2dP?=
 =?utf-8?B?V1JwdjUvRTZ3VnpSZ2swRk1YWkFMZUxtNjJjNFFqNHZHTEJKOEMvMmZvazlt?=
 =?utf-8?B?d2R6c01qY0pvTm94SXRKdGJKTXhkSTVNVENtYnRnRHMyaTZJODJIdnRNYnUw?=
 =?utf-8?B?dnNWbXA5NmhLemRBeS95RlVzdC80OGlhalRzWkxiYVdyWTQvdmN2VUxrTjkx?=
 =?utf-8?B?OEh0OWgvNHJkM25LVVB5QmN1Z0hXYzFiVkl4YlNPZThrWm1rS01SbXpTMUZi?=
 =?utf-8?B?VjFORmduaTg5TC80SDcrNmQreW1RNUhyN1dTbkdhME51ZmRnNkhmT25tUytE?=
 =?utf-8?B?M3VhdHpyM2VSMzNtZkVlQXhINkpQdkh5R1YvbHE3WjJrSisxMWZ1ZnkrMm56?=
 =?utf-8?B?dnF0ODB4MlBUdDA3NlBRYlE3Nmh5QlRrNG5kT2cvZ25oM3BWM0hMUCtJaWRt?=
 =?utf-8?B?aTBtcXFzTm9BQ2hnMDNyaXRrNVJ2OFpLOTdnWjNFMkw4Z08rMW5WYUdwYTh4?=
 =?utf-8?B?aVlJblp0Mk5vYVliakRqdC9NdjkzSEVQbnVYemZPdUpIbFBjZ1JpbUlXajRt?=
 =?utf-8?B?QjA4R0NER2NFV3lvV0czOTd5bWVVV3FramdzTmQ1QXJXNjRNMjdaY3BpU1M2?=
 =?utf-8?B?c292b3A2OTV0QVRETDhRTGc0YzQ5QU5ZaFU0ais0TXRzZVJOZjQvczNGK0pP?=
 =?utf-8?B?NGhwWi9XUkthTUVjYy9NWGwydEFycDZqMU1NUEJzblF3UWpzYzlGa3BRL250?=
 =?utf-8?B?K3VZZGY3Tzh1SkRhV0o1TFNvVTB1MmVoREh5ejhmWVNPdlh3b3oyQkNkdjFM?=
 =?utf-8?B?TlIrY0tDTjNSaUxtemF0bU55bTFLMmc0UHFydXlpSGV0alAzNUFmT0hjWk82?=
 =?utf-8?B?Zk12c1EyeXdNai9LT25TKzA5R0F5YzFuTVEvQ3JGM01wQlgzbEcyUXZuRS9Y?=
 =?utf-8?B?MHNNRXBueE5GNU94REh5NmdTMURybWFFOEU3Z2hBLzYvNmI0Z08zQVd4ZUxn?=
 =?utf-8?B?S2l4KzVta09SbnVkd25OeVdvNFQ5NFZjT2pRRnpCSmxzby9KNFAwYytIdUMr?=
 =?utf-8?B?a1NRak90K2xOSWpMQ051Tmp1aWI5UXI1UUZDbFhYUmZ6TFZuVVN1YUJsOUtC?=
 =?utf-8?B?UCt0OERZd3JlQUdodVVKRGJoSVBNeTdhYzNrS2kzRU85T0dUVmFsczY4alpZ?=
 =?utf-8?B?NnZ1TjV2QU55d1NoNDZNeTB5c1BSUlBBK1ZLbEZHeHVZLzFrbmhraVF3RzVo?=
 =?utf-8?B?YjJpR3B4T1ZHaS9URDVXcnlHZGdabHZOSlhDM2o0aHhSemJUY3NNWEVmZ0FB?=
 =?utf-8?B?c2JhalNweVN6S0RDNjdqY1E1bXJKb0pMbTJwY0haUjZtQ29GaHJEeGl6Qm52?=
 =?utf-8?B?bWUxcEFnSmVSbUhWUjN1TWhHZEtUUFo0TUNqUzV1bncrbWVvUVFDMUNNQjFn?=
 =?utf-8?B?MUM0UnpSTkN1NTZHY1hwMDM2dFZZaVRoMjBqR2NBMnl4SVkzY2dRVldOMzlY?=
 =?utf-8?B?Z2JwdnFDN1c3QXpXakY5dDFrTk9pc0puekkrTUdXZHB2cCtRcHMrVDJxVzh5?=
 =?utf-8?B?RlpkczZBZUFrUTJEMmQ2R0p4SW5RK0IvOXBWSWNEQUVMYS9mUDJucWVXalJa?=
 =?utf-8?B?aGNMMnZMNG9TRnRrUVBwOGtIMEVXLzdyaFZOTzYzVCtjRGFBZndFZE05ZVhi?=
 =?utf-8?Q?FFLgiq9nlisu8ihhj2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4383e24d-6ca1-4eaa-0f28-08dec6d4438d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:40:10.3939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZJgKADeFthV/NwD4qNlryCaGYI8AMuNgLz9OBrOUDwa6pi/GnLHMNLsRpmInHyU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7654
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

On 6/10/26 08:03, Srinivasan Shanmugam wrote:
> Provide a helper to retrieve the per-file eventfd manager associated
> with a user queue manager.
> 
> The helper resolves the eventfd manager through the existing drm_file ->
> driver_priv link instead of storing an additional eventfd manager
> pointer inside amdgpu_userq_mgr.
> 
> This keeps the ownership model unchanged and avoids maintaining
> duplicate references between USERQ and EVENTFD state.
> 
> v10: (per Christian)
> - Remove the extra eventfd_mgr pointer from userq_mgr.
> - Use the existing drm_file link to access the eventfd manager when
>   needed.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 ++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 99c711ddf71e..376813e9623f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -34,6 +34,22 @@
>  #include "amdgpu_hmm.h"
>  #include "amdgpu_userq_fence.h"
>  
> +/*
> + * Get the per-file eventfd manager associated with this userq manager.
> + */
> +struct amdgpu_eventfd_mgr *
> +amdgpu_userq_eventfd_mgr(struct amdgpu_userq_mgr *userq_mgr)
> +{
> +	struct amdgpu_fpriv *fpriv;
> +
> +	if (!userq_mgr || !userq_mgr->file)

WARN_ON please if you have such checks.

> +		return NULL;
> +
> +	fpriv = userq_mgr->file->driver_priv;
> +
> +	return fpriv ? &fpriv->eventfd_mgr : NULL;

Same here, fpriv should never be NULL.

Apart from that looks good to me,
Christian.

> +}
> +
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>  {
>  	int i;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index d1751febaefe..8c4b55517a0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -183,4 +183,6 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>  
>  void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>  					struct amdgpu_bo_va_mapping *mapping);
> +struct amdgpu_eventfd_mgr *
> +amdgpu_userq_eventfd_mgr(struct amdgpu_userq_mgr *userq_mgr);
>  #endif

