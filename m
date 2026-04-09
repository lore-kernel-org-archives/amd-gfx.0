Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F37AEA3C59
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 11:53:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C943D10E7C9;
	Thu,  9 Apr 2026 11:53:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AJLHHe3z";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1796510E7CD
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 11:53:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofkIsTvtd8e9XrtrOYS9NQ1lq+AxJbfdUeulWlVD6Fa07WqCRUch98MNskbHBmzIIf40bOPIdGG8UtjdW5W4iWnBCvfsoj4Dj5tqs4aMnEiKDb42kL0eYW0xD4nPiQ33gkz6Rbft1N1aKZ+4aHY4UaSYzvyf+qHVi3c27I+d024yh2Ea5qvXKTYfGM4u5qOvOnx9AFHdUwgNQA6kDsMa2KAsEr8vOoowYwT1dG8MLIFbAD0LpKNXnPARofbVwnN+F9cboD2n1WLHINjjpROj2BxShUPopBkgZYWNN4iCxOIOvaJokFlCd/Wi1M5xTBVI2mqPoPw/cjaaXV7ETrvFOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVJQk5wyYcBc0KRzWepICtW1K5SWjeOzF75NGLBo7kw=;
 b=tqtY6XAAJXaqk6mBMMU1YwQ9+WKUXSWfvb41kAdb3g3xM6T50qI/mkjtv9ScdxFLALPi+CEqyyu2I8wXq/xuW8aBZDhZSVjso5fJEUNyofZgwqTyqQZLA3RERg7HEi+2qnIKccVuobvX//J0F0FTCXwlPMGWpZl/pP8d0kxVZ9tMiXOV6iKlunpFwhLwCkJE8td2CjSB3sMex/tQ9v697PK9nABJveTsN843oBFp4tUM1Fr8pWidDYepBQyBNJbQCnYET8z8iTGP5LtXg2v8lfwiABMnWfqat1UUHMK1W/9qgz0nPbFAn9V4duSZWrjRxzIYYeU428s76rgm2yyHVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVJQk5wyYcBc0KRzWepICtW1K5SWjeOzF75NGLBo7kw=;
 b=AJLHHe3zUJzo5A4+V+i1R70HS7RpZK2npAQd363NNDtOVPMqZZHlwNC0r0AsU6YLrp2WBFgckocHb/7BV1GN4u8CJiiDkzBmu6OgMm3ImqgaVEx5ArPOuLZr4VaoJpIB+Fl9Jdo6xHgzVN3+LH7ZfCoO1iLHMrdoUlOLejKUY/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 11:53:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 11:53:04 +0000
Message-ID: <c1914157-d8b9-451e-936c-1e2082472ba9@amd.com>
Date: Thu, 9 Apr 2026 13:53:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] drm/amdgpu/userq: dont look root bo with
 userq_mutex held
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260409083355.1326089-1-sunil.khatri@amd.com>
 <20260409083355.1326089-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260409083355.1326089-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::34) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: b41d139d-baf4-49af-356f-08de962e8e6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: e+y1onLCaBMtvgW+QmDE/Bvo19jVqgheyIQ50QJsBt+2enH95rQ7fHtV8eUU2ex2+7F/B+nL6GaW1RvKNJr6foY5GJpLWhFq5SwIiLi5cstIGzl6XDWvFbAwPynnN8YTAcYQRtsg/i8o899SQqRIUjvAUpGNWI8mHvUHqskTiGMwZaBQG9h2rdyPjOYPF3+JD9/6n+amL0LhzQ+Re6Q+TQMjLaWOwY+ffIr49ShWUCgX3PEA2kCr/+QGH/BKwZZy2VGDrtC0ffLnLUqY1jWkK2RwFkHxXoxARxJyiTBz4Uojyb6RHGfrMkX3vZjaKRI/9/kLpumAO87U4pxU44E6D9sr8etiLbIwcGegdeG3TvxMqMUJRL2jLqtl80jXrpT1k/9UHyfDRNPP+RGJgLZ9jYKLDE3toQ/OyxhXCw+Og0/Y/NpUcOoiyZir26yl2gz8Uz5mSFuLzWy9hC3ZRNK7TE4O6unrkWafMemxQWD9r/osGB+Q7Z/KAsdukqpmiA9X3LQZhQWl/VN9U8vRhItLbKgbN3wd7fUavReYqBV1fE/2/2/IOepejISWjJ7gK5dSWETqeMLtJSvzhOjD82WqlvzZVnKuPG0PZrQDPu01Mxk8JNYSmWxtdPCYR1HyX0RtAn90EHXF28fAhmgk/XLZcdUbOspFte0C4yCPTLA782u9J7okPgFZeU9IOt9s+FaA65omA16tKuy0IUlfy9rfXA3fO/nJXABo8nkeWcdp0ng=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2JmVXRLeWtjRHZmRGVRYVF3TlV3TnJaOU1aY2tWNUo2NTJ1aTdNdFlhV0NY?=
 =?utf-8?B?R1FKMmY3Z3l4NTZ1L3dwNlJ0a1p5clk4bGNOSFh3dnlsSVVSU25mNkFMUWlV?=
 =?utf-8?B?K1dhdEFCUUtBT3YwM09CM3JYMVoxWFFNRlhHNnEwZ3hzb0xDTDFRQUhTTGZS?=
 =?utf-8?B?M0JLN3M0Q2thZGZ1UU4yVnRpTy9YWVQ0VmRHZHc3T3lvYlA0bkFlbEQxV3FM?=
 =?utf-8?B?c0VPa2Q0Qlh2NDFlRjd2UEJRWkxhYWRDZXFURGRtMG4xWXZTQjlVQkRhYlNv?=
 =?utf-8?B?VFZMSThCUWRVMjVTa0YrVDRpMTdBczVucEpxNWgzKzY2QlVlK1l6OFlxSFFS?=
 =?utf-8?B?cEpMNkI4OEFObTVVSHRZMCt0TXNIL2VOR3FGNU51WnJSUnYydHFoVmpSaUZq?=
 =?utf-8?B?aldRbU80U0drTGc1cktya0J6NWUzb2ljbGEyMWJiRlFoOGFTVnhhWmlQRDdu?=
 =?utf-8?B?dGs2NCtKbkRFM2NFSTNjK3BzdThUNkZhWmFSZUdWZncrc3VqZUNieEJKMGxi?=
 =?utf-8?B?d2dIdVZTTFFOd0ZXbjVxVDRCR2E5bWtoZFh6Rms4SG1RazU5dHE5L2Qydmkz?=
 =?utf-8?B?bVJSQmltZDRQZDd3MEtTZGxNbVpEbVMwYUNUMFI1NFJvL01ONWJackh0N1Jr?=
 =?utf-8?B?RjFSWm4vRGU5a2RkN1p0bUd0OGhGQkhYN053ZVRuTmpKWDRQemVUOFJtQ1FB?=
 =?utf-8?B?MzUyTkM5bHNidWtqb29ZaVM1dk01eVZrVTNlbFl5M09vZ0hWanFndVl0Mi9S?=
 =?utf-8?B?bmxlSjFrOXhwVTYyRkh5T3M3cG5KOG9rOWdnWGVjZnd2L0xaanBjcEhpOGZB?=
 =?utf-8?B?dm9kMWJNekJiTm80RzJ2ajZucWpDVzlRTzU3MlVCZFpPK0ErRFBzRVIycXN5?=
 =?utf-8?B?eThsdVZTR0RWOVdWQTJDVGtBZWV5VW10VnNyTFpWZm00U0VZZEdJcWdFUzNE?=
 =?utf-8?B?ZVVpL0dWdDVsc2NpSmZUQkhGY2JibzJtc0RUaGlqUi9IdEltS3p3QzlXSWxE?=
 =?utf-8?B?c2hSSCsvbEZ3enFEK1FGWDV2bU1hUFJKNWFPbFdpRVI1UGRnTlRZUDVmbHZZ?=
 =?utf-8?B?ZURLYzdXWDRhNFdPbDN3cm9EK3Qyc0dlUmJYd3c5amw5WWVNbmNBRmpxZHRj?=
 =?utf-8?B?aXZWcXdNcnpzK056SW5UU1VheENpRmx5c3BtRjQvR25hK1RnOHlXaGxCODFR?=
 =?utf-8?B?VUYzSlVscjRLd0llZHJPVlJxTWZma3dDUFp6c29aVWxOUG56MXdDWUxqNkNR?=
 =?utf-8?B?TDkvUGxpa3JHa1l6NVV2UXpHcGRvZTNqWFE5K3ROODRGN2lJM0dDdkVseTdG?=
 =?utf-8?B?RlFGZG9TcUsrQXZmRHlxVEtOekxMem9uWTJjWU9Zb0N4TEljTkdtUXR4YXNn?=
 =?utf-8?B?djlPVlJSZXMybnVFb0dDalowK3JuWG1sbVNWdGRXVi8vbmpyUjlYU3FrZ1Bs?=
 =?utf-8?B?RHI3Z0FuaW5qbE13VmovR1JJUHFTSitoTkhMcVRtVEVEYSsxd053bExVbVhi?=
 =?utf-8?B?Uk1Zb0xwQ0xua1E3RGIwMmJTWThMQkVFMHova0ZINjkwb3lyV1VPTHgxeEQ5?=
 =?utf-8?B?aXlZU1lKTlB2bXl3c3lrRTVDRnNldU5CaWtpVzU0OWF1bDkvQnlwM3hEZUl5?=
 =?utf-8?B?bXRYZUVzYXJVMzNRN3lQdW5MMlIveC9ObWIwa3pzelc3ems3TmpKNVVGQWV2?=
 =?utf-8?B?bnlGdFNXN0k5V09DdGszUlRzdERuSjFUbHFTTzJiaDlBWFo1WnB4Qm1SUGR0?=
 =?utf-8?B?b3dpeEtDUHJzV21GM2k4b0pvMDI1dHZVWExuSjY2L0dsS3ppNXlkRlV0Skpx?=
 =?utf-8?B?SjhDckZhWXBTc2pJRXQ3TGlwTS92R0VROElqdU5Jak00d0NtK1ErRXF3SE9v?=
 =?utf-8?B?STQ1NzkwaWZoN1FiS3R2WG5lUmxLT3lCazVrMUFURTZ2cHpsRzZCR1Q3Uk9i?=
 =?utf-8?B?RXBWdTNKRjlpTjRPMkUxdWltMjR5ekRsb1RRczJ2c1ZTMXRwSFZuWjUxSmtO?=
 =?utf-8?B?MG5yYytDWGVYTG9OMkJITnBDUlBDYXdrMDAvNyt1Q3Y2a1lDWGRmVkJIR0FG?=
 =?utf-8?B?NnFhSGtZd2w1Y0hkZERqUmtKclhwRDBMSjB1V0M3a1A0TUpxMzZRVGJlVWsw?=
 =?utf-8?B?RlJJdWhFUCs0bTkzd2pSbnJIcjhBSzBuQkhaL1FxNUc4b3lqdGlWMnJUQjRV?=
 =?utf-8?B?dG9KVlJFSjZNRXhMQ1E5TU1PSU9UdngwdWxEbnZqWXNER1JkUVR4NUVzSS9s?=
 =?utf-8?B?MHVHTHBqK0pYdGNqN0lBazlONGNTdEE2YXJOYXNrcVBaU2hSV29RKzJQT3Nj?=
 =?utf-8?Q?/B8ApI81kpB951r7Zv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41d139d-baf4-49af-356f-08de962e8e6c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 11:53:03.9024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQ9vqcvg9zr9W4x2w6i3j7WJAvr2QOe88bXE1ZoNzP8sfdA41m3GUgi6+HRCzJqI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912
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

On 4/9/26 10:33, Sunil Khatri wrote:
> Donot hold reservation lock for root bo if userq_mutex
> is already held in the call flow this cause a lock
> issue with ttm_bo_delayed_delete.
> 
> Its better to lock the vm->root.bo first and then go ahead
> with userq_mutex so userq_mutex threads dont get stuck until
> the reservation lock is held.
> 
> In this case it helps in the function amdgpu_userq_buffer_vas_mapped
> for each queue during restore_all.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 9f7a08a6b018..cf8c8dfde721 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -270,15 +270,13 @@ static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
>  	struct amdgpu_bo_va_mapping *mapping;
>  	bool r;
>  
> -	if (amdgpu_bo_reserve(vm->root.bo, false))
> -		return false;
> +	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>  
>  	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr);
>  	if (!IS_ERR_OR_NULL(mapping) && atomic_read(&mapping->bo_va->userq_va_mapped))
>  		r = true;
>  	else
>  		r = false;
> -	amdgpu_bo_unreserve(vm->root.bo);
>  
>  	return r;
>  }
> @@ -991,10 +989,16 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>  static int
>  amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>  {
> +	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
> +	struct amdgpu_vm *vm = &fpriv->vm;
>  	struct amdgpu_usermode_queue *queue;
>  	unsigned long queue_id;
>  	int ret = 0, r;
>  
> +
> +	if (amdgpu_bo_reserve(vm->root.bo, false))
> +		return false;
> +
>  	mutex_lock(&uq_mgr->userq_mutex);
>  	/* Resume all the queues for this process */
>  	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> @@ -1012,6 +1016,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>  
>  	}
>  	mutex_unlock(&uq_mgr->userq_mutex);
> +	amdgpu_bo_unreserve(vm->root.bo);
>  
>  	if (ret)
>  		drm_file_err(uq_mgr->file,

