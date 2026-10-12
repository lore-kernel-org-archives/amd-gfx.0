Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63E1CA9EC5
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 07:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CB9110E481;
	Mon, 12 Oct 2026 07:12:13 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013040.outbound.protection.outlook.com
 [40.93.196.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE6DA10E481
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 07:12:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRMfANDBYe1yxlOXxiVDwy3Qz9SPYXhkW2rdFvnDQ87ROP8y53fd3UGRfJJe+6xmzvS6ot9dclzm+y/FI+vgyfL3TQvfgy7Kj/BKNrnF23TDLQotCAJL3jtZjfthN4RkRQ1BSSeOHNHYE2oSYxCsvVgf54dnPRr7j23spYgkJdpidH18VcTVJRewxt3pMP35BaA/ESdnG2nGJLum+t+F6RSrdnyJb9mpuYQsAxGeSBRPP2jMNCoLe30lkN7SSUufZWo/WSF9f1RfFQ5AtrHGb+TxN7a738GwRbiDchg5L6E8Cl9vrxsaIy84kHQeVH/91wOQQLw4ocs6525orcBcLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJ5KbYb5ptgEKh7AZ/dnbwO+7LXAft5nhhOIREPNVW8=;
 b=magpNGq7QLwy3IdGHWLIRIOJn/0KBWAEEk3y2EPqMLidO1fdQ+SWIyq/TRp+NQSvJhobWPYxKrSQwAZvVVSaNIGAi1JIkyJsX+Y5W4X+3BujnOe795ei0ioKQvKTuP1MXV6t2l+6LnN6BUI+3iyv0GtYZ1paMI9tHIZWikuYbARBZgfslBtk6o7LSOQ7bOpvIWjbnYHp/2nNyR8QfWSMEWxVkbZAZFY7xvUghH3gElCprqcPAGUbH4joUVQgTcM2Zx+MhDuc6qPef8yLaaJsQ1iqYqS/JByumvV5Ya7L9huT5xGbTqhsPg8c31DGIO7yTHzT17eNzsYGRAJQabXGBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJ5KbYb5ptgEKh7AZ/dnbwO+7LXAft5nhhOIREPNVW8=;
 b=1M6z7hxqBd03W1MQt8d9V6nSpnV9eR7sW2W2kSsBuzHhbGaHrK+mGLuFmmg7scogS93vukB30aGx2HMQ0dKQGwZx4acd0LpHshQXgRSM4wyU1Jkh8fof/W/vblTVJBKIEOKpPXh4TBPgNhgjjN6MGdcvyyCIM/WCAKZ9gHYLxXY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8933.namprd12.prod.outlook.com (2603:10b6:610:17a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 07:12:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 07:12:04 +0000
Message-ID: <b6b76eb2-da5f-40c8-935a-9724eb546bb2@amd.com>
Date: Mon, 12 Oct 2026 09:11:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: actually invalidate userq BOs
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
References: <20261009154651.632259-1-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261009154651.632259-1-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0435.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8933:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf77688-d6bb-4747-6dd9-08df28301e49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 25gS38pBn+qT1BW2iuHilV38tkqjgDVM+yvmRSllbi3Antjwi2j3cAo9IpjwiYKqwJtDxzdEF9CsqdvIuQfQJRYq1MXkuMx0qxmEOnxFA2MFtx+bzanLKBfirlMBmwIb2QoJvwY+zzbxTyg4JfXBa3n2yrzVgkceWgJj3nOqFQR4NfPtk6mN7yQbwuS3m4qN0Kwmt4PT1AZD3CU8UA91HR1DJBwyIt5mQT9gO1GZX8w+lwUQ62hKpP/c11UoiiJ0cxo/xk0ATBXb0hQZFfMQ+4TGYPhrcMQ8i8pl+BQ4ZyW9Pd6rWC3Paf/LoLGFonj+auDyPlazZQ7E6rFeDb9HsjkM+YpnLKzKBGsMFNnjnU7EX5WdjLau245ebQWnSUjQhKxf6I8V/M5mRJuf1r2MiX+rSVY8xoexZgZd2+AAVm4lgtACt2Hp812nt0ewJM+H2bixX8G1KtUQVyRjTe4YIX92GZNC98VQWrJobUOI6sx2oIhK0o86YRRs6dWpyCzIiaHn/aXWmDUJimXp8l49NCz/M2GWVJ+QxhvpqxBOsNDduKSpvEscnJornF1qIJ6nCeYjusWvF2ecQ0xn/VLRe8xtct4osOnCs7tOSqSc8T6gyrjRyaoGxA7h/Lqql3sZXTliWZjHACvxM8IHTxXBh93VtumnjseSWAlyHvxa6fs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ei9XbG9OUlpwVEhjcTIvaG5RRW9UMmNoand4dzVTWDJQcGhDSHVTZVhmd1RK?=
 =?utf-8?B?Snp3L3A3ellON1JwQlRhdW1XNkhGYlpxeE9PeFcxSjRtbHA3ZWxuVUM0OG0r?=
 =?utf-8?B?Y3A0MXY5UjJwbUNLOU1XNlZnZTVoVUsrMGxvNTVoRFN3N2R0YzRPV1dYOGNs?=
 =?utf-8?B?am4vUTMrSmZlNXNpTlZiOW92TEdSRkRVenB3OU13MTQ2M1FFdzBPdXRKdlIw?=
 =?utf-8?B?aW9FUTNUZW4zQUFiNnNMaERlY2hrOEFqbzk0bGhqRGhma0lvYXB4TCtWVUpO?=
 =?utf-8?B?aXI3VHZEQ043TncxNSt0YmxOaXp0WlFrYTBCYjh0ckdySUJ5eEFOTE9XYlk1?=
 =?utf-8?B?a0s4SThSQjhPSUd6VmZUenBCWW1xQXIzbHdMcmoxcFc0Z2Y4Z3kwQitxc09y?=
 =?utf-8?B?TU1tejFNLzc1K2ZFVUMrSk51eTZsUmtVM0phaktxUVZqb3c5S3ZOZWNGd21q?=
 =?utf-8?B?dDlua0h4djNWK1pzN2t3NUNCWHRISjIrT2JsQ2d0cG5HZkhvMnMremp4Y3o0?=
 =?utf-8?B?TG1lN1JkK09maGwxMyt4KzJtSjk0SytqUm9UVGMwNHJIZ1dDSkNPbG9KSE9w?=
 =?utf-8?B?UGpXcm9VU3YwM3JrNUgvQk8yUjkzL0U3OFdsK1RQYmpNSTcxTWR5NlVGS2Vy?=
 =?utf-8?B?dHhER3F5alEyYjlOVktleWpiS1J4aVZPYW9La2QzSi9Wd21IMm1SaEUza3Vz?=
 =?utf-8?B?bXRGZVAvakg4cElMNWtDMnJ5SjBFT2gyam50bmZpS3hxVnF2WC9zdHZDNXVv?=
 =?utf-8?B?bGFpQXpKdnFEdG9tZGx5L3ovZ3I4L3V1QWw5VStDUzU5Sll3TmlxUCt6TWVq?=
 =?utf-8?B?NFRBVVdOei9Uc2trdmdNVmxFVkRER2FBY0JXZGlkNHNuV0hwK083MkZMR1F5?=
 =?utf-8?B?T2ZyVzYxVEN4OWJSYlNBNUF2Vm5yaW1GaFlvSVJqVGE1anoxM2xiVlM5MXU0?=
 =?utf-8?B?L2FLTUpWMUJjRXNDNzg4MjE5K2NROHpPOVpha0dKZEZ4bzIxeFl6QmI1SXcx?=
 =?utf-8?B?TW50RS9BeTU5c21WMW13L0w1dzA1clc1TFk0TGlnTlpQUSs1VjI2dW9zUHQx?=
 =?utf-8?B?Vms0YzJmdGFkSEM1eWRDd0sxNjdiT1M3NW4yTEVQTkFUWlZKa016QlFaMDF5?=
 =?utf-8?B?eUlGVVd2YjFISWt5ZG5WQTVKR3VlcWg0YkFKRFNGNkFFUExlMlpLQjArd1Q4?=
 =?utf-8?B?YkZqVi83M0ppeGovQjczUjZOU1A5SWhxSjR0SE1hWEY2dG02SlA4cjRpNlZY?=
 =?utf-8?B?VTRlMDluSDRTMnV6UUlIQ0ZtMTNnODNsSzdnSlBCV2h2Q00yazN2TlNSVno3?=
 =?utf-8?B?R0FlZjQ2YXJmM2hScUU3T294clh1b3V5UU80L1k4UDFyVUdwSERGKzVPODRn?=
 =?utf-8?B?YzIxRk00eTZCSmhTb0VZR3hnaEhPU2N0MnZJck4xSzdYcVpNYzRaQ1IvRVhp?=
 =?utf-8?B?Z1JpVXRPbzZXcXJyTFcwQXFmSWF4T0NtaWxUa29oWjErcHlWRy9RZEx3Z0VK?=
 =?utf-8?B?c2xEVUZSaFQ0VTRIaFA0dmhodWNSYXdRbHdkOHJGWHhvT1B4ZGhaNDBVWGcv?=
 =?utf-8?B?N2lqcy9aQ1J2QUd3bng3QWJKUnJ6MG9UdjY2STZLVzlLVnBvSGZKa0RsQ2Ey?=
 =?utf-8?B?TStIOGYvaFRmMytUZ1BqR1U4MFJseDVlTTQvVTNqaUl2d1dKRmZiUkJQVm5P?=
 =?utf-8?B?dUk3cytmTzcwdnFpTWhEbndIeWJUWW5jV2lRVGtKay9oTjdVMTQwdE0vVWtN?=
 =?utf-8?B?eUd2SlZYUGU3MlpmWStYQXNNdUZnNFhZUG9SRjZjd2VURktkdkRyK1J4V25h?=
 =?utf-8?B?bUpaZ0ZEK1l2ZVhSZ0lLN1NQOW9jbzd4MXprUlVYN0p0UytwWHRoVENMaXdp?=
 =?utf-8?B?dGtjZmhGWjN6NlJNWE8zWlBnMUNVSWJacTl5STFiekphYm5hL1J4a25FMk9F?=
 =?utf-8?B?K2NuZlQ2MDM5a3JabDY3Q2Jzd0c4WlVWeHVPZVA4cDB1TkViMXhNaUtIZGFM?=
 =?utf-8?B?RHpHczNVVVlXcjYwZTk1SEQwN1V1VWxEVEViL01BUUQxaTJJL1VrOXRoMUx5?=
 =?utf-8?B?T2FOb0hjdDVLN3E0TmcyVzl2UDlEaEtOdHBrL0dTRkdPeU81SUYrd3RNWkRY?=
 =?utf-8?B?LzRJa0ZUZ2lhSUpGR1U2QVV2Q1BJY0p0cHhGZ0t0T1g4Y2hPTXRFMzRpVE5J?=
 =?utf-8?B?V2lwMWd3aGRmZXNheVJ6L3V3cHErRnNnL0cwMktVUDRrVXhwUzRoTThNbWRE?=
 =?utf-8?B?di9iSk04cVJHTmdad3ZWZzQzRkNTYjh4UmZjWno2dXpGTGRiVkxmbFJweE0v?=
 =?utf-8?Q?8Vt4DCKvBTc3ieUIvh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf77688-d6bb-4747-6dd9-08df28301e49
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 07:12:04.4063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSu/zjy9zom6GZYiVkZdwv0hVUVysJm5CUvPlasCT1ggXupsRjYjp1ZjJ4mN5sfF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8933
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

On 10/9/26 17:46, Benjamin Cheng wrote:
> This was supposed to loop over the individual evicted list, as the
> kernel and always_valid evicted lists were already handled in
> amdgpu_vm_validate.
> 
> Without this, BOs that were created and evicted before a userq was made
> would end up never end up in an eviction fence rearm.
> 
> Fixes: 4cdbba5a16aa ("drm/amdgpu: restructure VM state machine v4")
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>

Totally my fault, thanks for catching that.

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index a90db4d3d4e9..5b9f7f7f3862 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -993,8 +993,8 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
>  	int ret;
>  
>  	spin_lock(&vm->individual_lock);
> -	while (!list_empty(&vm->always_valid.evicted)) {
> -		bo_va = list_first_entry(&vm->always_valid.evicted,
> +	while (!list_empty(&vm->individual.evicted)) {
> +		bo_va = list_first_entry(&vm->individual.evicted,
>  					 struct amdgpu_bo_va,
>  					 base.vm_status);
>  		spin_unlock(&vm->individual_lock);

