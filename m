Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B232ACF34C1
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 20:48:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6944D10E255;
	Thu,  3 Oct 2024 20:48:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nK3hIe5i";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5B3510E255
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 20:48:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDnMCwrURCG9CPORSM0iM4VrcF74/MzEwrOR2od2TizZxs/Jys1rHiey27xBmup6cX77pLATT3k2uqEzev8q8erBzgZGJ7RcdE0XmIJ7vaz3QRP6RCud5J23um7a53PxEj/T2yhgPElu8mN1oS6V8ce26ajJH6T7FIEiEPkNcghsVKKU4mh7pzz12w2jl7p7G7Z0M5EbdNR5amBG32+uZEvvUz+HyZShKcUvo99i4IHhJM3jbZDJCUHtYJ8IAwz2fg8lcTi5pZUFE8ZGkpwQmxwe+UzC5/lsV3CBHrkSXQnETkI2mEIp1QlBJCD96IUnh/CF+TaBlyczDLLjb/Za8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajRmaEzCof59T4hWae0fCLZtk1Wr47x7wuctzqeSHlM=;
 b=DPyB8kggP5pIbY4c8yLm8jG5vvXavcrjgEgYmFuPbhucBNN9qQSrqGIWa6C0vEHJqpBvJ8Pj2oidSNCmazllSdEVMoI95w7fgQsk5kTYV2Pqr//AxKszI2Vvi9vz7yHMnkijkuGSh6I94U2v/NLkG3xZunglI5sq6gBrnU1xT3CBwaECyEsTycKfHioCFgFoJvqEBbKLE+wWBbseODE1I6Ybx9Epa9vEXUHAuc3Yfx1g/fmiBGDfWwJ35lPFJsH3g7BflSPBkH9Q0+K8eYSnWaT1+w1QYh2ZXAaAvPBlA4XiGkgQ2TXoKO4vYcPtzm2g48XUwUgD31kutIxsJR0AuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajRmaEzCof59T4hWae0fCLZtk1Wr47x7wuctzqeSHlM=;
 b=nK3hIe5i0ic43ZFilhqLeL+9lt4I84ZtuWuUxCD01NPW09EIZnDr3AHESDpN9iwAgPQk5jS8/k+7432nioKS5QrjkxnHmIH3JV+EVUnrt7tKpMbWH4dkCJlMQMibm6O34VTTOML6cDRLWY/+rHZ8pkziVx7fFLuxn9CToToUGwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 SJ1PR12MB6170.namprd12.prod.outlook.com (2603:10b6:a03:45b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 20:48:51 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8026.014; Thu, 3 Oct 2024
 20:48:51 +0000
Message-ID: <d48ba656-fc96-4612-888e-d95f9b6e6751@amd.com>
Date: Thu, 3 Oct 2024 15:48:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: not restore userptr buffer if kfd process has
 been removed
Content-Language: en-CA
To: amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, philip.yang@amd.com
References: <20241003202828.29433-1-xiaogang.chen@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20241003202828.29433-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0007.namprd14.prod.outlook.com
 (2603:10b6:208:23e::12) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|SJ1PR12MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: b5436cc7-b73a-4da8-7342-08dce3ecc94c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDRzR0ZpaWZ4cXVzd2RIRDNEV0NwUXJRNUd5VmNVUlBHMjRYRVFXUXV0Rmwr?=
 =?utf-8?B?MzhLb0V2RlJlSm9oVERueGFEbTNZdmxteVR4SlJ1YzBVcFVmYy9WRU1YcHNu?=
 =?utf-8?B?bEJOQUwzNTE2NDZYM1E0RFRBVXJLZ2RwdkdkVloveW5malRVTjIyZ3JMYXRi?=
 =?utf-8?B?ZnJ4MGJ3ZXBtYS9GQlFTQTc2Wk5IaURvYjM4UlJYWGY2TGE2bTNQS2JubXU1?=
 =?utf-8?B?b0UvK3kxdnlYenI4VWloR2pIYWMwWjJoTzFlZ2JTdmY4QnEyR0p3TnN0a3Jl?=
 =?utf-8?B?c0hLaXp0cGdoQUpqeEVPOHRHWFdXU3M1Z0NsNmJ5MkNSSDNmS3JxS2QyNkRn?=
 =?utf-8?B?VmZESk1GM1BNblZQd3hvLzNTR1BGYjRsbWFSOGs0OWs3RzNFMGpjS3QxbTZF?=
 =?utf-8?B?eXkrSE1nTUdvblRRRWhYWHpZQk50TjJQTzNwa3ZYL2c3bjExMy9FcS8yVmJi?=
 =?utf-8?B?RU9kWkFSMjl6QzlXWCs5MjZweTNNQ1F0Q1FhMkJCdWRSbi84ZWIvbFl4QWta?=
 =?utf-8?B?cVpuSUtvcFFEY1UvaVV6WFlGOUJqRzdhYWZlN3lMNllaRTMxdDBDVXFBUWdX?=
 =?utf-8?B?WVJVc3dRODNEalVlVzhxM3hVb2NBTGxpdTd4cnVsYlo2RVZZQ3RCOE5IMnpF?=
 =?utf-8?B?SzRKcTE5bDhhc2lvbHBzWExlTGxlSEg2eWhjZFZweXNoYkZ3ME1JTExldmZT?=
 =?utf-8?B?Z1QzVSs5anBhSVhqS29aeWl2dHVmTEV1ZTR4blRSNXNqeHF0bEpVZVU4YUV1?=
 =?utf-8?B?UTZTcTJqK0JESy9teFVxWE9XYlFkbVJpTGh2d3VzS0JiTzlyL3Qxd284amlp?=
 =?utf-8?B?MlBZVkhGZXlRMmZVdkQya0t2d1dCZTBJVERXdkZpd3h4SG9Obm9Ha0FzMUo2?=
 =?utf-8?B?ZEcvNlFjcm1GUHl5d1JJQXJFcU9mQXdvYXNqZW14KytkSkk1OXNrdWIxK2lo?=
 =?utf-8?B?bkVYN2NSb05kZHVvQldDYzV5SDlLOGFOa2VDTTltaW9WZ0gxd0k0dkhYNEF4?=
 =?utf-8?B?SE1kSFFDUG5XVXlnUDkvOXRQVktUdW5GcnNzQVd6bXAySjA5RmpZZDVreXBq?=
 =?utf-8?B?MGxKanc2ZUdIejRXa2cyRWlWLytTZGlOMmpZV21XaEQ4bHFiMjdraHc3d1Yy?=
 =?utf-8?B?dDJoSGEyTG1oSVJiTm5DWXB4SFg1K1A4L08vK3ZaQXh3bmx1L3I4U2JWRkFT?=
 =?utf-8?B?SWFCbW1FeWZ5Ym45MVIvS0hmVE1ENnRZUEQwWVhHcXlsRDN6ZFFHSkRHYm0v?=
 =?utf-8?B?TER0ZW9Ld0xYSFNuaUMzcHBvMWY2S0tQVW1MWXg5YU04ZEtVaEtDazRqT1Bx?=
 =?utf-8?B?M0tUelV2U2Y0UEVSTHlOK3UvNE1QZks4aktvZmhWMEZsR2hSZEh4S3JHdndj?=
 =?utf-8?B?MERKd0paMk5MTlRERjRtL1NkZ2JGVEhaTGhZT1llNTdIOWlTanVNTGYyQzM4?=
 =?utf-8?B?SnU1SEt5QzNNTjBZRkRpU0RHekYxSUliSEVMM3MyN0E2enJUQzB4bHBzemRF?=
 =?utf-8?B?bUtzaVBpWVdhbG4wYXVQbVNMSS83MEp5RjZIK3I0Z1J6c3l0Y0EvdzVmbkdh?=
 =?utf-8?B?am5kTDkrZm1LbW93Yno5RmpCUFE3eW1VdEZjdnoweHRJYWtOdFNrSmo3UW5F?=
 =?utf-8?B?SGtiK0FWb2dFMGNUd1hycGZLZWFHNXV5STFFWkVSS3dkdm5ZSFBpTVRyUjM3?=
 =?utf-8?B?bG5FK1UzTjhzVDNFTWxFWHdrVlVTZ1pqT0U0SVNwQis4OTB0Vi9DVWdRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWRmZ3g1V2YwdjVSSm1xRDY0NGt0MU4rUDVrcExjK0NLeWN0cEEzL080Rlpo?=
 =?utf-8?B?NG9XZW5HaWdkeVJVTm9UUmkyVFVwZTlrTGdHcW4wdm9OQ2pYOW5RNVZOcVh2?=
 =?utf-8?B?bkZXMzIzbTRoU1RwSG94NGZSaUgwSXBWSDliQ1BQSitkZmFMQjRhd0lBZkYw?=
 =?utf-8?B?NkFWcmpObFVNU09jaU4vK2Q4ZzhzVU5CbFh3eGppQVB4Q3NmZVdKSC92TGxj?=
 =?utf-8?B?QnV2YTdELy85TkVyY1c2U3BvMjFMRDZOamtpeGVha3kyRjl2aUZpWTRhYWtZ?=
 =?utf-8?B?c1A0NFZUbjVUSEpYOENLMDlCcUx1QWpaYjIrVXJtTVlLZlRJSGI1L1pRcXA2?=
 =?utf-8?B?VXBIeXVDN0VlczJHZnBBWUxIeUlqbEVMaHpmWTZjOEdLMVd1REl4TmM0UHZI?=
 =?utf-8?B?MC9SSm1BTVVSVzcwaFNPK3Y0ZFl1NnFLUTJ3T3ZTbGZQZmZ2Ly9FNkhwUlVC?=
 =?utf-8?B?ME5EWGJXZThGVnA1enpKNUROMHJrUEROVlBZYmdqN3dyNlArQjQweDltRUY3?=
 =?utf-8?B?OFRvUkx5RWtNWGhBS1dTczlBeUE4THJyZGlYQnVYMk5Sc2ZtYzhBZnNxUHJt?=
 =?utf-8?B?WUhHT09sYXJVSXZPa1VIRFpDNkF2cXdhRzdVYmZpY0ZSSmhwSmg0enhnQkps?=
 =?utf-8?B?ZjRNYTZFai9Ub1Y1WDJSdytqWm96VGRMaG5weldRNHFDTU1WSUwvWFJOek1r?=
 =?utf-8?B?VG5RditoU1NhQ3ZGVmtmMHM2b3ovU3lFSEZsaFNOQ0UzS2tKTEdqejhBdXpP?=
 =?utf-8?B?VjZMTEc0WWhDUmdYQVIwNi9INVMxUXUvQVJzUE1pYmMrYmxBL25xZ0dXSzA4?=
 =?utf-8?B?dWFRRFBSMktEeGQxWmNIMWlydXFsbGVNMDdibEROaXVINnIrUUdZRUovcm5Q?=
 =?utf-8?B?RUdVeTJaelRPdEJlUDlQQXdBT1hZSENtaThMendCSWhuWUY3YTBIa2JOY1NI?=
 =?utf-8?B?WTNDV1g0V21Famd2QVVIdHNET1oyVFRXNGxhc0tiamNhM2xZUGdHdlNaZUJH?=
 =?utf-8?B?Z2NROCtUZTBYSTZSVTVvblJHdFRqSXd6NGFZSXhicXpPZUFBNjhtMnhKUWJr?=
 =?utf-8?B?K0Vqbi9zOUhMWWF4S3VjS3N3ek55RVVWUXVaQ01HUzFTOGc2QW9FTVlPQXc2?=
 =?utf-8?B?emNpMUJ6Z2wybnZBTmg0MzZ0RnlLcVBRSC9pUmQ5VU1lUzZSWDQ3WEFTNUlI?=
 =?utf-8?B?VUtQTXZWQTk1L0VnS2JTUDBWeUlQY1hpN0xCb2x6dG5yR3RSZE85aTdVZzBi?=
 =?utf-8?B?QzAyaUtTbVQvdFVjdjBLdHlKT01CdElGSUxMZ1M5ZDJlQ1pIdU9hMnkveW51?=
 =?utf-8?B?S094c1hJU0xjSzhPOTNrMFRzUlR1UUM1WHlmajhlTFh6RlhLU2lMVHFxbDlx?=
 =?utf-8?B?R1VkRlg3QkRBQ3pzeUxwQnR6V1oyMHZFOTdPL1BCdkFnM2d5TXQwZVlUVGsx?=
 =?utf-8?B?akx4Q1ZOWmI5VHN4aVJyRGZNd1JqcElZc09LY3ljdkNtNHFSWHhQN2RwYTVm?=
 =?utf-8?B?Y294NVg0Q2U0REdWZzVNZm1FcjI2bjlaQVo4VVlhYkRaQzhHQlBkYmJUU3VQ?=
 =?utf-8?B?cUhLd3hhY04rL0Q3bThHL0ZKRU9XRTdrbXBjSHFjUTVmYmtsd1MzaXIwZFJy?=
 =?utf-8?B?dVlCV3NIUHN0cmp4bVIxWUJSUjZLU0lxY2dqeXM0UnRTVms0WlVheW85OFZF?=
 =?utf-8?B?cTNVdjBkTG9TQmpnYXBva0ROVDVXUHdSemp2N2VHMkF3ZlVqNlc4SVk2TjNn?=
 =?utf-8?B?bmNxUTN6UkFYY3FZcFdXWkp5QUhMZ2hFZU1FTmNJMzlTanBHdStyb1Zlc2VP?=
 =?utf-8?B?RjdXbVhxdE44dkh4ZXI4emQ2azlQbVVYUDdPS2o4Nzk5SDgycEVPS1M2bUtT?=
 =?utf-8?B?cEJJNnptYU9kK1BZcGltck53bm1Kc3IrM2tTcGZ5cnArdXR3REJXL1ZKUGZ4?=
 =?utf-8?B?WHg3RkxJUHVEdFFSZDZtSzNiZ25NdHdCWWh2M1VEREwrbXdyb1AwZStJM1Zh?=
 =?utf-8?B?UHREU3pqdm8yMlZkRVh6V01RSi96WDcwNzVEOHFiWk91ODFhb0Roc01BdTRp?=
 =?utf-8?B?ODJHdFM5THZncHJmMmp6cUR6VlNJd1NaLzJkZlNtYjYzTmxFT0g4bjFOYm9D?=
 =?utf-8?Q?7+ow=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5436cc7-b73a-4da8-7342-08dce3ecc94c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 20:48:51.0157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91KysPxd/K+XOCJCfvIzqFkUPJvCLKzH90HjR4sw0mrGKvTysEJHMsfjY+VX2hcD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6170
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

sent a wrong version, please ignore it

On 10/3/2024 3:28 PM, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> When kfd process has been terminated not restore userptr buffer after
> mmu notifier invalidates a range.
>
> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index ce5ca304dba9..dab4a6a74c70 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2524,11 +2524,14 @@ int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
>   		/* First eviction, stop the queues */
>   		r = kgd2kfd_quiesce_mm(mni->mm,
>   				       KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
> -		if (r)
> +
> +		if (r && r != -ESRCH) {
>   			pr_err("Failed to quiesce KFD\n");
> -		queue_delayed_work(system_freezable_wq,
> -			&process_info->restore_userptr_work,
> -			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
> +
> +			queue_delayed_work(system_freezable_wq,
> +				&process_info->restore_userptr_work,
> +				msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
> +		}
>   	}
>   	mutex_unlock(&process_info->notifier_lock);
>   
