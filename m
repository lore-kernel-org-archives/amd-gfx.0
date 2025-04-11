Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDFFC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 12:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A062510E029;
	Fri, 11 Apr 2025 12:20:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lDpuSsUp";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12D2410E029
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 12:20:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVYh2iLqVlP1rfXYXJCn12ZvMLCbYvxv+UuYNpU9cTWqYbKSO1l5TD10qAlvupbsBWPrzsiMXnm3l72lovByatdY7BznjwF99Ps56UcxzxZeGw2kFzEmDXE0XkegfIzYnZ6UfNiXu+k2oB8mAPoXIm2izo7HZ/erVixRMyZHaAeGB47+dnwGkj3yRpU+EftLjWMvsSreQ2+SyC1N9fszfHVR1Tf/LdWHDHaBgHl0HfzOlYCT77cfzOD2BqJoUcqsyxadyXcS5dmHc/OLcd1QMZpJ4uAVbjRuFfF0isaXagehTuYu+3G4Zex9DVQQMpFXX/Ue8dVr5iw0j/7aFVCQ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nllEuFlqLcL7+RZbQ+I/NVExLb8HUfjEMwBVcKChySg=;
 b=ULM0QcAsh9cLSRabKFb6cejXdTDR1xZrHFEzBgRqpppTTxtCH5zlm5qynioF3ESz1+4gt0pXr2PLuIm4yyLpk0fPMb5tCe/RxZRtsde9dmyRZ9vSnZ63GbodwV54RtaL9ONWZig8kOID29u1c76Uay4BP8i7ORL0Fo+RNJj2h4mcDFF84SCQNQSaWAZDGxjZMPeMLuYW8qC4V71SGnGqrVJOH3VcLORK1s6+daAAOLWngqla4g/MMunX40GvuGNEtI0xzN5o53oEn611oh3+V1wcfjw6sMIxxaTj5LDoYGhNDChp9xRWEvBHbVDu9bbuGm1MTygs7P5qSX9IFVM9NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nllEuFlqLcL7+RZbQ+I/NVExLb8HUfjEMwBVcKChySg=;
 b=lDpuSsUp5IgzPjnF2Ri3oz9qUBvvJb5DXScBj7A5UKrxn10WlYWsUaZ8j3LxiRt07gcD0OYR2UXe+Tx8zO3Qh8LFH8GI9JDaZwmGXDG94RJRkU4T6BSkMegwFSvZLPZUMhq3E/zd0n2WdMzWj1gQDV+YDCycgLBtzlfetzw7/5w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DS5PPF18A985A10.namprd12.prod.outlook.com (2603:10b6:f:fc00::645)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Fri, 11 Apr
 2025 12:20:46 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 12:20:46 +0000
Message-ID: <ca94aa69-52f7-40f3-bae8-9385967b7949@amd.com>
Date: Fri, 11 Apr 2025 17:50:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] drm/amdgpu/userq: properly clean up userq fence
 driver on failure
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250410181138.2287932-1-alexander.deucher@amd.com>
 <20250410181138.2287932-4-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250410181138.2287932-4-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26e::6) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DS5PPF18A985A10:EE_
X-MS-Office365-Filtering-Correlation-Id: 5657bf17-5ea7-43a6-7ac4-08dd78f34977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0J5U3NXRmhydXlpMlR6dDlCWlFDQUE4WUJFdTh5U2RxYVBVRWNtZ0hzOEVD?=
 =?utf-8?B?Mlovem5XZkwzZFFreGZWUjk1NDJaZS9TZURSSXp1TU44ci80TnRvajZqaEpQ?=
 =?utf-8?B?Vkp1NDdEUG43Wmo4UlJ3a080d3BpVlpQNzhyTXQ4TCtwMDBQdlJFczFiMUxm?=
 =?utf-8?B?eEJkT0QxbEFXdjVXS2JXS2RGcnNHWnVkbXphOGY3UlNtZk8zQXZ5cDZoNG1p?=
 =?utf-8?B?RGlDTVRyMkUzSFVwMDlZR0Y1Vk5rOU5LTWZwVmxVN2RpbGRCckxOMEFuNDhX?=
 =?utf-8?B?dlhZaVErdUIycjZkMGtaOUxzdnJwbndTR3E2enF6MEN2bEdIUnMwS3lOQ3J2?=
 =?utf-8?B?dXk0aEI5ZkliTW5BUzNCczY4UTFMcEJ1Z0ZMaVFhb3NEejJQUENUeTZiWUJq?=
 =?utf-8?B?QlRia2lIUmt2R3E0TU1kR2NEcG42RDc2NHRQcUUrYjlNVGhDL1JzM2JMamU5?=
 =?utf-8?B?MEkra3hCakRFMVZra2lzV3ZCVEx3MjZoOFJPTVpiWXJTb0IzZG5CWkg4ZVB3?=
 =?utf-8?B?azcvUzNwRkhXdjBkaEpzS3VHaURxMnNFZVhuZHkvdHpUbmZoTmxwY3VrZXM4?=
 =?utf-8?B?eGowVCt0OTd3N3VORVVlMnVuUnlNbnZ0MFUwUE9jaGY0azU3SU9CY2tVaTRY?=
 =?utf-8?B?RWVSTUhOb3Y2NjBtanFMSjhBL293emtha1BKQXZHaEVicWI5M204c1pHNGdl?=
 =?utf-8?B?Q2w2MmpmYUwxUnRrYTlDdTcyS3FtcWFJSnNoTHNYMmJHelZGL0pyUFQvWE1q?=
 =?utf-8?B?MlVPQXB2VEpuNTRHaU5Ydi9XZDRyanRCYnlycHBCNXlucElmVzN1L0EzZUtB?=
 =?utf-8?B?TXhhbGNrTnlvSkYxV0ZaSDhBQTN6bHcvR0h1SWVxUnJFT3dtTHZkTVBKd3BU?=
 =?utf-8?B?YzVTUVJ5NUVzQ0pLb0ppa2ZYeC9FWDRPYlp3bENnbFBGVW1uVW9Lc0tlQkpa?=
 =?utf-8?B?ZGlrL0M4L1k5ZXhaazVLbnRtVFBzd3gzenZvUldNQmNjMXlXQ201WFAxaG1z?=
 =?utf-8?B?dW8zR0FEbG9FY3k3WGpjK2FINWtUTlJEcDdSdVlhVkJ2aTBkNUFQVUhTUTZu?=
 =?utf-8?B?bENnTVNmTUcrNG40MXM0NXZjUGZUSXRjTFJEdjE1Q2UwcFRORlNzWWdGcmx3?=
 =?utf-8?B?bis1WU1JUzJFTm1CbTFzMlVsTWYzdSszWGhwcHRTQ2lMMEFHTkpsU0VlVHdN?=
 =?utf-8?B?ZEd0TnpwOVB6YmVRb0E0Z0hhbWg5NGVPdEIyeUVMa0hRT0dBNFFzcDlpaGlP?=
 =?utf-8?B?L1kyV1o2dlBjK1RGeUQ0V0duaFlORjhVcUlDOWxCNG1lVTdUa3Q4MFJ6R3l4?=
 =?utf-8?B?bk5Wc20ya1NpSkhrNjlFWWZVcURVNncxSnNXM0ZMVzJPbnc0NEYzNXJ2eTZC?=
 =?utf-8?B?SDg1RnV3cHF1aURHVGpUT1d0YVp3Z3JtTTM5SnJDRzNjbC9ZSTZXSWhrUTA1?=
 =?utf-8?B?RmlLTDh2aFk1TWRzYTltWkRzeTUydmRQUkdVY1hISFA4dWZtdEJVRTlpcVRU?=
 =?utf-8?B?MFdxMXRlZTVSY0J4Qk43ajJPeURyM3NWanpKY0puM05lUjB5MkdwWUJwQnhM?=
 =?utf-8?B?bUZHb1VtK1J1L1NwM3U1OTA3d2FMeG9UYlhjOHlsSUwxM1dqNDJCS3hrUUkw?=
 =?utf-8?B?M2lVNzdQZGwyZ1c1U3ExKzc4T3FkdnVwcmdnNHU3L3ZBN0EyRVhLVDBNdkEy?=
 =?utf-8?B?UElTdlhDSFhvNitjbFkrZ1hxYlFLMFBFWU85dmxVVEY1QVEwZFlsTGc0NHJl?=
 =?utf-8?B?NEV0NnpkWnhiQ1R1OHFydXltSWFjS1ZMZU55WVVQVWVBTW0xaVcrVVJtM0o3?=
 =?utf-8?B?ZDczNDhlSFNzR1orVmpheGVvWWhHVFVQOEFSYVFDZitqWTU0MnFYYk15VGFu?=
 =?utf-8?B?M3VlMmUyMXpNdWRSR2FQY0szMTRIS3h0ZmV0LzF6UXZ4blVPenM0aHVqVjFO?=
 =?utf-8?Q?kDZiseVNVcs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmlWdGtqdlErQ1VvTmswZlNzMHpabXd5WWJNemFyelZVM2RmSVlzUWZ3ejFV?=
 =?utf-8?B?N1VscU5pUmpnZTA0bk1hcEtJYXJZMzdXOFhqclh2VnFzRnlVL29WQnNYaS9R?=
 =?utf-8?B?RjZkdkViZVh5ZkpoOHkyY2EwTXY4SklsNzRXdFkrMHBuVm83RXpRVDVNLzh6?=
 =?utf-8?B?NENqTW5GcWxwVk4ydmdDZFd4dVpJWmE5N3hhVXl3T1N4UTZldzhaemZ3NVdp?=
 =?utf-8?B?RVdqaHU4U1N2NERUTGNheld0RUdKVk54akd6SE40ZnZHS2tTeGd3RjZIcWJH?=
 =?utf-8?B?MlV6MnZxTExZSkduMVJCbUE1RnRMWEM1UEhGLzQxZXFWZmhwdS9CbkxDeWtJ?=
 =?utf-8?B?NU5zSVhRM1FFeGlXWWFEZ2IvZmhxcjV1OGdFMmVmeGpIQ2h1TGg1N3lwRHpF?=
 =?utf-8?B?aGNJK283UU5CNDRGbGhsdCt5Q2ViNGc5NXc5bnJwOTlUK0VCdXBDbjhPK3BC?=
 =?utf-8?B?clduczlZT3RBdUYwT0I0b1dQNTJEaFl0a2UxSXFvbk9JbXlxTlN0bWJWNWxR?=
 =?utf-8?B?OTk3K3d6YVpkSVZ4c2dIcXJ4YVpROWJCd1VOQ3FpUFFseE9ZZ2t4SEg3UU1I?=
 =?utf-8?B?dVJCajYxd2k1UThJR0ZRaXhLMzBkWWJhQkM0b0Fzc2xOTkdtZHptVHlUbGs2?=
 =?utf-8?B?VDFZdUhreEJyKzRBUXl0cmZGMGNEcmNHL2xKRlZJSm5aTmUrckNjZ1hRUkxr?=
 =?utf-8?B?K3JqUDZCYUxhOERmZUtpVERGdWRzNlduRmhQS2ZzM1V1cVVYVmQxcHRjSUJW?=
 =?utf-8?B?alExRUhOcWM3MlFuMVlCWDhyNjJTRXU5UTE0eHFxVTF4UEs5eGdLdVZkWjhi?=
 =?utf-8?B?dzE0YmgxazFYYjllTFR6WUF3YXRlYXBlcFBwc2ZxMHhhQllTejNhcmNueHVS?=
 =?utf-8?B?Vks3T3VrakJYQ2VZSXlnejRyb1o5R2wxdWpFeFRTUzd5MG9veVlaWUFlcm5H?=
 =?utf-8?B?WU9KdUtqSmxlV282VzhCWm1XWWRsWnNxUEF3d2VlejZnTHpSWGwrVWVCOGJv?=
 =?utf-8?B?ekpjeFE5eVpUejFqZjJ4c05Ca0FVdkxjaXRYWmJzUThGSkFGWDdDdmh5cXUr?=
 =?utf-8?B?cmZ5enpvQ1cwanJLbUxKSzNPaXZlYVNVSEZZU09oTTNpQ1dLU29KS2xFTUtn?=
 =?utf-8?B?TVNTay9XbGU5ZWl1T1BjcWo3NGN2S01uUXFYWkJGbjZld3cvMURnaU9DTERo?=
 =?utf-8?B?V1lNdS9YTHVGUTJTWmFwNnRXeVhBaWNMTU5mT0tvQTk5ZmVZVDVPVnh5OVZt?=
 =?utf-8?B?RDRaOHVMREF4SklkOTY1OGpBKzg0bmtnZE9Od2huYWg0UkVKTjQ0Nkl5Q0ov?=
 =?utf-8?B?ZG53d2NidHlaaWxSVnhuS2ovVHpvZGVnM0xXWFpxNlZDUFQvN01tNDZVYU9j?=
 =?utf-8?B?R0dUMVlMYnMxZFpnQmFoV2hpYSszbGNFajZxRzNKc0o5WXRncnJCVlVObzRO?=
 =?utf-8?B?NVJOSkVXWFJlbnAyWFNPVWxDMWNjeWJDSXVYY2RrbnZKRS8zbG9NSFBneVJs?=
 =?utf-8?B?OTFtNVBXTzdqQ2taSktoYUJuYnNEUDVZbWRvVHRnQ1MydEFhb3VpK25YVXVu?=
 =?utf-8?B?OFJFc2VMWnpHbTNrZmZjU01DVUVvRXdJSGJJWmtwNGJwM2Y0THJNcXFjVVIx?=
 =?utf-8?B?eTArVmpETklQelgvUEM2dUNBekhHblRpWFJIMnF4SGJ2UlYwQ2JJRW1aSlNQ?=
 =?utf-8?B?VXcybnM2STI2M3IzUThmSmduUkdjYUZlb280d3RETTM0SW8rZDYxKzUyQjBM?=
 =?utf-8?B?VXRRYjQySWdyQnRrUGFQZ3M3WEFkUWZQY1Z2S0FYTlAwMW56RDVUT3ZIek11?=
 =?utf-8?B?TnBxa0g3Zk9KT05YcWZXRUtnTENRRDJIajFpZ2NSYXp5TlUzbjFGbSs0Mldj?=
 =?utf-8?B?WHhTbExlWXh5WEdiTS93SHM2d01aeEtYNjNDQmwwVFNseDJSNXdUSitPZlF6?=
 =?utf-8?B?OCtZdDhrWFNVSFN4Ukp1RjhmcDJVRk83SlFocG9FS0RicEZ1SzFrckxML0Fi?=
 =?utf-8?B?ckRwMDdZajNwNHFSd3NQeExUYTk1T0s0bTcrUUlVTUREbmpaclVIMDVJVHBw?=
 =?utf-8?B?ZDV3d2p3Y0NTcFMyTFA2c242TjJjZCt3VVJKYnh4TWxwNXk1TDJSc29Dem83?=
 =?utf-8?Q?dCGXTOQvatvM8gK++U9ym0xx/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5657bf17-5ea7-43a6-7ac4-08dd78f34977
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 12:20:46.4528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZfmC/SdmA33Nq/IKD15twRRr8LhSgfEqg6etaBXa6QVSe5tbJc8UkTEASxrYSc3ROeJoV+f7RYcMGPBKodM4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF18A985A10
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


On 4/10/2025 11:41 PM, Alex Deucher wrote:
> If userq creation fails, we need to properly unwind and free the
> user queue fence driver.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 79f4df4255c50..6157258092cef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -330,6 +330,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	r = uq_funcs->mqd_create(uq_mgr, &args->in, queue);
>   	if (r) {
>   		DRM_ERROR("Failed to create Queue\n");
> +		amdgpu_userq_fence_driver_free(queue);
>   		kfree(queue);
>   		goto unlock;
>   	}
> @@ -337,6 +338,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
>   	if (qid < 0) {
>   		DRM_ERROR("Failed to allocate a queue id\n");
> +		amdgpu_userq_fence_driver_free(queue);
>   		uq_funcs->mqd_destroy(uq_mgr, queue);
>   		kfree(queue);
>   		r = -ENOMEM;
> @@ -346,6 +348,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	r = uq_funcs->map(uq_mgr, queue);
>   	if (r) {
>   		DRM_ERROR("Failed to map Queue\n");
> +		amdgpu_userq_fence_driver_free(queue);
>   		uq_funcs->mqd_destroy(uq_mgr, queue);

We should have an idr_remove too added here.

regards
Sunil Khatri

>   		kfree(queue);
>   		goto unlock;
