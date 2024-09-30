Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89152CF64A9
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 12:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B0F410E443;
	Mon, 30 Sep 2024 12:54:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AnXOiUrx";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1025210E06F
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 12:54:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TReEMcMc8R0WwaJGV6DwZM0F5RMVzh8HnoreyRvYeBN3VbzHNsCjyjnl5q2O3XoX7ECQBBz1eImC5QRtae0KONyCvo1HkaesXdIeaNOxnKcWwKb2uJRHhQ0hCp1oM+JiOkoY6Wl9AqYkg69pRdIUkzgt1uYQmfrJKEmNAF8SWPmpgsMOX/fig4jVYG6jnqDBZ0qx/xbgaB/rPL6zj0BvRKIbKHVWRpIetWMM8maBsDf4OWJ9mgqh9p+8yg06Pt8jOeN4+KLnlwkG7dyX5D12hqD0acTVVfkbS7s+NUFB4W1tMjQ4faRkbR61qhujF3xhAfygZc/UIkoEtVZL+fc0aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nX9usrmkV295l02q2Y2E2IMsOR/WjKl8efqYam5G0yE=;
 b=cAeiThdsVYpbgXBX0zn+2bFqkTR+bFnSWp6wsfPrIVgUrg+EfuAfI2V+uczZq3UWH/ehAC8VnH8LIBrLNSyEI+usXhTfBf1EwAPOxB3A6MTmb4k+bQ3IWP7X19xsFxROaJGJlXEOS7j3bhiDDQWx0hDowlGyuOdfPGfphvdE0wTAsgvePreQkJyC1QlTAVJDAQfuzyVzSrW2TqiksehjR5a8YqkprQ7ApeAzEKx1vzgmLc4QQhq3lnl06qlLpyxSvzlLGdN9An9QO1FZq6rC0C3UEALAnxalmPFes9ojtIeMIJ6Jxmq/Q+1YarOCpdfRGOfbpfSLs3q80PL5zN7VPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nX9usrmkV295l02q2Y2E2IMsOR/WjKl8efqYam5G0yE=;
 b=AnXOiUrxQmDG0eB3Vamh5dPnnIuRMPby1qosLFmXFbRct8acKD5g3IvCDWa1gdJARpHYqjVDoi4s4FE13iFztHwQOb+10RPLxz3u3XuNVZ9ajF/1gUebZxCIUQeeNV/QSGUNHnxObxpRKfUkQVadsKrLjzd/nGkSdt7HHQx7JDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB8499.namprd12.prod.outlook.com (2603:10b6:8:181::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 12:54:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 12:54:42 +0000
Message-ID: <fca0ff9a-fe54-4dd1-96d0-56f5734583e4@amd.com>
Date: Mon, 30 Sep 2024 14:54:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/09] drm/amdgpu: Add separate array of read and write
 for BO handles
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240930115906.191060-1-Arunpravin.PaneerSelvam@amd.com>
 <20240930115906.191060-9-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240930115906.191060-9-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB8499:EE_
X-MS-Office365-Filtering-Correlation-Id: ea74c0c2-3445-4f2c-3363-08dce14f0d83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZzJKTHNnQ0o1SDUxYUdlY0F5cHFBVElnQjZsVllHVmJ5NUhUNVl3dmxMeWtn?=
 =?utf-8?B?UHdvSHlqZjRqZmlpQXVhUzBPZ1JlWDJNYWthdE0rV1FjM2xBNXpZcVQxdXZH?=
 =?utf-8?B?dld2bURTczhXb3NzQ21HNEVneWZkTVplaDRiLzAyT2JySmgzQmNOSU1rWGph?=
 =?utf-8?B?WHZLZ3p0enZjUkJOWGRoa3NsMWFSU2JwVlg1WkJFOEhGZlB6dkVKZW96dXFx?=
 =?utf-8?B?eTk3UnJJWk80REJzNjRZRXU1My9xMHRaOTIyNUNYRXF0NHZQR2VodGU4ay9I?=
 =?utf-8?B?MGl5c1ZoT1p0QTA2WkxHZkEzWjQxeXJ5d3VFdGxQbjVYRkFRcXk0Z0VrUEEx?=
 =?utf-8?B?N0ptUkVId2R4N3YzVEtiQmEvZ0JvZTJ1bjE0Z2FoUWdSZHpxajNNN3hKUHJq?=
 =?utf-8?B?VGYyaWFIaVlGNXVJNnVFTGZwVzBsMFZUN0J0a25jSHhxQjRaM1F3WURiRkFn?=
 =?utf-8?B?bmp1aUVTS2RtWmgzVlhmYlJkd1NDb2UvKy9QeUIxS2tpM0puTXpvV25saDJt?=
 =?utf-8?B?dFB5aFcvNmF2Q2hHekZ2L1pzbWcyazV1enJKT3RvVDloVGNVbU5qbDYvQUM3?=
 =?utf-8?B?SU9lVklHMHd4dEhuSmJ6OEMzN1VHL1IzQ0ZFNlJ1QjZCUGFGT2tZR3E1ejdN?=
 =?utf-8?B?MnpMNWVRcUYvSTV1TzEvTitzMFJBVjlPK21DVnRJYzJFckV3L2tFcUJzN2Fo?=
 =?utf-8?B?QXAxSGtMWGd5L08wNmRxSFBMUFMrMmF5SGxZdFdHcEtYZGpCVS9RR3VFMCtS?=
 =?utf-8?B?TmNmTkxYeXdZZEtUTk5QZjZ1aFNjcXE4THZTTFhyREFmRHBuZWVHWHlmN0p4?=
 =?utf-8?B?WFdidkV1aURTRTFtMzE0c2ZVSjFYaEV1VVNzZmdrejhVZlo3WGVaVzdLT2J4?=
 =?utf-8?B?NDJ4Y1dHYzA3ZXBnVG9zNjNETGtNWDdmMWJaU3JueFNiVTNwRVhwdVRmcTht?=
 =?utf-8?B?WThrZnp4VU12ZVVsb0F4bE9jUWhUdDNidWtGdDFPMXEwMGxSRHVZUjZ0Tm44?=
 =?utf-8?B?a2MwTnFHc0ZOaDUyTWlVQWNqQmRMT2F1VkhwN0Y3SjFVMU41TnBVa0toeklR?=
 =?utf-8?B?bXJudWVlMHdibFRNSVBSYWl2cmpvUW9KQ2ZsK1IxTWs4aW92eHBKM1djdWNs?=
 =?utf-8?B?dlpYeG44OU9VUmRDU1hDR2JTak9wMmIrSFI4aFlEc2JQVndzTVJVOWtHeXd6?=
 =?utf-8?B?UmsvUjJCU1psZDM0enBmVklUVHFLY2pJMlBnenNZMklaTDlGcVVzWXlKYnpC?=
 =?utf-8?B?aUY5TElHMmhsQjN1MlIxK3V3RDM5ekRScnBCRnNPMTVxb1BFa0VsRlF1Slhv?=
 =?utf-8?B?VkpGSC8vZFdjaWpFdzRvN01VTnUxekNxZ1NRVVFabVFseFJ6ZVdXVFMzRy9T?=
 =?utf-8?B?UnI3TGNYMnlIdjIvZTlWU0FrdWhNb0k3SjhFODdzNm5YV1ZpZGZPZlJYK0Z0?=
 =?utf-8?B?T3NpUmxxZlR5SHFENGlJZDlSVXBnUFBwMUt4UncrMHd0VUZBYm1tOGlPNmx1?=
 =?utf-8?B?cUYrbDh2WmYrOTZaWG1NVjZVN05YdzZuYldacU1BelZjVStpMlFEbmhSalV2?=
 =?utf-8?B?aksybjZsOUM5Si9hZnR3eXRWMGpvUno3YWgvNUpaVHFSRmNTa0RkTlB6NEdU?=
 =?utf-8?B?TktSc1hxUDN2UndoVjZjK1BzRnZtTzhyVGxtYVA5alZ4ZXdZcURCazFXaDhP?=
 =?utf-8?B?Y2djUXo4a0tzcFJhNVV0bUFHQTZoOXQ5NVBYSHRKV1p3UjJkakI2T1dYUmVu?=
 =?utf-8?B?TFZOWmRkWjEvcUJxdkIrcnRhdURwTlNXZFF2VENQUUsvVk03OGhaVEF1aCs2?=
 =?utf-8?B?dGlSN3B1SkdURWd3V214UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzhVa0FlaEhMbUhlWHZscVdkeTdZeThHVzI2ZDlXTDQyTkJMZkZ0Vy9iWGpr?=
 =?utf-8?B?ckZ6Ymw3L3lLTUtlbElVcEdUSjFZVTJwcXBTVGNaYXE3SUlFbU0zR01kbnRm?=
 =?utf-8?B?ZklwT0JicGl6aVk2TFlBV040emxMNFNFUE5rQWNIM3lzQ2ZkMXluZHo2RFFa?=
 =?utf-8?B?R1UvUHE4L3ZzeHQ0TzhXSmNLa3JHaVlyQXo2L2JFdncyOHRqNWxBUkZXV3BH?=
 =?utf-8?B?OGxNK3pIaW1SZnMyTmh0V2xlcTBEU3BLYnhsQWJKSlk1RERVbi9VSHNwaEJk?=
 =?utf-8?B?My8xWmtScEV5dC90d0NETC9GaUhLcUJFZmtIT2lOYzV4SG1uWXZJNzhKa2sv?=
 =?utf-8?B?bDNCbXNJbHBoclh3NlBtSnJiYnlwWjN0M2Fsb3hQTU9TVzBPQUdJcm56TlJJ?=
 =?utf-8?B?U3lTdSt5cm5vSG5FaEZKeDRRSnB0TXZIL2t1WTJKb1FYTFhGRkp3ck1JVEo1?=
 =?utf-8?B?c0ZxQkh5ZnpOMU5COUwySzNOdVlkLzZWSGppY2QrZkNYMmx3bGNyYmc5M2N2?=
 =?utf-8?B?YnNPZ0cwVmRzVXJkRXhLQVJtYUxNTjdsd1hZbWo1ZVhja3p0aUpzMzhRdndE?=
 =?utf-8?B?b01wWml6YWdUcTdCbk94bXhRcTJqdDVaY3dzbjhvYW5vdkJmZWNCR2ZHZXd4?=
 =?utf-8?B?Ym1JRkhKQ1lIVWt3OHJNYm5UVnNldmR2b3p1Y2Q0dW1nZThhUm43R0QyY2Yr?=
 =?utf-8?B?ZGFaNFB4YmtDc1A1Y0xUdEc3OHFsaTZiWHhhVDVlRVg5bDN1Wm9WbFVWTSs2?=
 =?utf-8?B?WEtVOUpRUWNXT0RSZ1F6aW9YRnpVK1NBSHV0YkRxdk1YdHRLYnRFZTJsWGU4?=
 =?utf-8?B?cGo1Qk04b2grQXQ3cU5hcytybTFrcTNLQUJ1LzZtdGtLdEhTSkpWV2laRG4y?=
 =?utf-8?B?WjFydFNwSnQ5M29EMkVEMWo2R1BYYk02Zi8vVHpXQjZBSW9WL2hlN21LOG5l?=
 =?utf-8?B?VE1TRDh4RzVqVkZZajhidGFjZGlFWXJEVmQ2YmhkR0RNYVJCbkRSZ2dlSEVu?=
 =?utf-8?B?VVkwUm5QTk9vc1d4TThzU0tPcVVqRk9HUXY1Qkd0ZVUzYzQrNlF2NXRwejFS?=
 =?utf-8?B?dzEyT2l2cStjbDh1MWxTKzdKQ2hmQWZPOXZCSWM2dGlhVmxiSytVVlBHN3cw?=
 =?utf-8?B?OGphQmhpSjIzL2VoRUtGSkJzeU5uaG1wUktZN0IzOWg0RXpENXdzdnBrekJN?=
 =?utf-8?B?REhaTEJDWlZOQ2RLVUhjZERKdytQaWJtN2J1QXNic2ZlUnRQK1VoL25OQ2hL?=
 =?utf-8?B?VTRoYUlEMHlYM0VzU01hQzZuNWYwc3k3Z0srM2JkQ0tlKzk4cHJ1VGhjSUlS?=
 =?utf-8?B?ZlhSVDdSNXorb09ORzF1Zk0rK0hIa2g4NndNUlpEVW1YYXhHYWFob1Z3c3JV?=
 =?utf-8?B?VCtKZzNsQ3ZPNTRxTXcwL0RKSEdrNGhsalVINUR0cmN3TkthaXFHSVlUWVVD?=
 =?utf-8?B?ZlAvMmRycHpCanZFYkJOZ0FsbXN6SWJUTFJtQ2VVanFrM013RklFcURWTTVm?=
 =?utf-8?B?VzdJNEszZmtvTGtTQ1Y3c3l0SkdqcWVicGtYK1NhRk53QkRZdktsdmZJVGZQ?=
 =?utf-8?B?UERRdlAranFmRytPK2E2MkwxQ2tRa3hmK1RwVXY0d0Vya0VRSkVldFYyNmNv?=
 =?utf-8?B?MGtob3JsMWJpM1BUVUx3UW41Yk8zYXUxUDA1dUMyaXNORU16cWtFTzNlUll6?=
 =?utf-8?B?WHRRajhmL2I2dmFHRkhYUXVTZ3k4eGJFd2ZzT0JETVVFcDJKTVBmZWIwU1JP?=
 =?utf-8?B?WDduTUFFVUI1aHFNdDE3M25pRno5VThIYW5yWEVYTFRPT2hjTEh6VjNFcnVj?=
 =?utf-8?B?S3ZVNXlpYkd4bm9HazhRdnYrRndZcFN2WUUwVEQvc3h3UVJoNWdnQzdPV0VD?=
 =?utf-8?B?T2pkdmI1VjBEZUgySHAwdysrN3BoRHkwMHZtODdxRmcwTGxMazV6blpUSFRr?=
 =?utf-8?B?WlB1NzJKcUVvcWF6Mk1KZ0JJdEE0YXpuSSszdWl6SDlIMlhhQ29jamU3Rjhp?=
 =?utf-8?B?MDNMRWd3OEFMOW5YMW9QSmNSaFF1RzdFQTZoM01GU1NlQkp3NG9yNWtkNzRv?=
 =?utf-8?B?RDBOUHdOSkpsQ21jNlBVMjhuMTg3YVBBczhlSjNaRUl3dVpIeXlPeGlhRldv?=
 =?utf-8?Q?6Pvw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea74c0c2-3445-4f2c-3363-08dce14f0d83
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 12:54:42.7697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2L/PQGPpek7gHbezNhBybLfldatSNPnwhNFLy003ZCNOgt/TzjgbrbutC+s0ZPSB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8499
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

Am 30.09.24 um 13:59 schrieb Arunpravin Paneer Selvam:
> Drop AMDGPU_USERQ_BO_WRITE as this should not be a global option
> of the IOCTL, It should be option per buffer. Hence adding separate
> array for read and write BO handles.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Still some potential to de-duplicate code, but for now it should work.

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 238 +++++++++++++-----
>   include/uapi/drm/amdgpu_drm.h                 |  48 ++--
>   2 files changed, 206 insertions(+), 80 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 0725f28f3484..aa794f342036 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -386,12 +386,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>   	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
>   	struct drm_amdgpu_userq_signal *args = data;
> +	struct drm_gem_object **gobj_write = NULL;
> +	struct drm_gem_object **gobj_read = NULL;
>   	struct amdgpu_usermode_queue *queue;
> -	struct drm_gem_object **gobj = NULL;
>   	struct drm_syncobj **syncobj = NULL;
> +	u32 *bo_handles_write, num_write_bo_handles;
>   	u32 *syncobj_handles, num_syncobj_handles;
> -	u32 *bo_handles, num_bo_handles;
> -	int r, i, entry, boentry;
> +	u32 *bo_handles_read, num_read_bo_handles;
> +	int r, i, entry, rentry, wentry;
>   	struct dma_fence *fence;
>   	struct drm_exec exec;
>   	u64 wptr;
> @@ -417,32 +419,59 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   		}
>   	}
>   
> -	num_bo_handles = args->num_bo_handles;
> -	bo_handles = memdup_user(u64_to_user_ptr(args->bo_handles_array),
> -				 sizeof(u32) * num_bo_handles);
> -	if (IS_ERR(bo_handles))
> +	num_read_bo_handles = args->num_read_bo_handles;
> +	bo_handles_read = memdup_user(u64_to_user_ptr(args->bo_handles_read_array),
> +				      sizeof(u32) * num_read_bo_handles);
> +	if (IS_ERR(bo_handles_read))
>   		goto free_syncobj;
>   
> -	/* Array of pointers to the GEM objects */
> -	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
> -	if (!gobj) {
> +	/* Array of pointers to the GEM read objects */
> +	gobj_read = kmalloc_array(num_read_bo_handles, sizeof(*gobj_read), GFP_KERNEL);
> +	if (!gobj_read) {
>   		r = -ENOMEM;
> -		goto free_bo_handles;
> +		goto free_bo_handles_read;
>   	}
>   
> -	for (boentry = 0; boentry < num_bo_handles; boentry++) {
> -		gobj[boentry] = drm_gem_object_lookup(filp, bo_handles[boentry]);
> -		if (!gobj[boentry]) {
> +	for (rentry = 0; rentry < num_read_bo_handles; rentry++) {
> +		gobj_read[rentry] = drm_gem_object_lookup(filp, bo_handles_read[rentry]);
> +		if (!gobj_read[rentry]) {
>   			r = -ENOENT;
> -			goto put_gobj;
> +			goto put_gobj_read;
>   		}
>   	}
>   
> -	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, num_bo_handles);
> +	num_write_bo_handles = args->num_write_bo_handles;
> +	bo_handles_write = memdup_user(u64_to_user_ptr(args->bo_handles_write_array),
> +				       sizeof(u32) * num_write_bo_handles);
> +	if (IS_ERR(bo_handles_write))
> +		goto put_gobj_read;
> +
> +	/* Array of pointers to the GEM write objects */
> +	gobj_write = kmalloc_array(num_write_bo_handles, sizeof(*gobj_write), GFP_KERNEL);
> +	if (!gobj_write) {
> +		r = -ENOMEM;
> +		goto free_bo_handles_write;
> +	}
> +
> +	for (wentry = 0; wentry < num_write_bo_handles; wentry++) {
> +		gobj_write[wentry] = drm_gem_object_lookup(filp, bo_handles_write[wentry]);
> +		if (!gobj_write[wentry]) {
> +			r = -ENOENT;
> +			goto put_gobj_write;
> +		}
> +	}
> +
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> +		      (num_read_bo_handles + num_write_bo_handles));
>   
>   	/* Lock all BOs with retry handling */
>   	drm_exec_until_all_locked(&exec) {
> -		r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 1);
> +		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r)
> +			goto exec_fini;
> +
> +		r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
>   		drm_exec_retry_on_contention(&exec);
>   		if (r)
>   			goto exec_fini;
> @@ -468,13 +497,20 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   	dma_fence_put(queue->last_fence);
>   	queue->last_fence = dma_fence_get(fence);
>   
> -	for (i = 0; i < num_bo_handles; i++) {
> -		if (!gobj || !gobj[i]->resv)
> +	for (i = 0; i < num_read_bo_handles; i++) {
> +		if (!gobj_read || !gobj_read[i]->resv)
>   			continue;
>   
> -		dma_resv_add_fence(gobj[i]->resv, fence,
> -				   dma_resv_usage_rw(args->bo_flags &
> -				   AMDGPU_USERQ_BO_WRITE));
> +		dma_resv_add_fence(gobj_read[i]->resv, fence,
> +				   DMA_RESV_USAGE_READ);
> +	}
> +
> +	for (i = 0; i < num_write_bo_handles; i++) {
> +		if (!gobj_write || !gobj_write[i]->resv)
> +			continue;
> +
> +		dma_resv_add_fence(gobj_read[i]->resv, fence,
> +				   DMA_RESV_USAGE_WRITE);
>   	}
>   
>   	/* Add the created fence to syncobj/BO's */
> @@ -486,12 +522,18 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   
>   exec_fini:
>   	drm_exec_fini(&exec);
> -put_gobj:
> -	while (boentry-- > 0)
> -		drm_gem_object_put(gobj[boentry]);
> -	kfree(gobj);
> -free_bo_handles:
> -	kfree(bo_handles);
> +put_gobj_write:
> +	while (wentry-- > 0)
> +		drm_gem_object_put(gobj_write[wentry]);
> +	kfree(gobj_write);
> +free_bo_handles_write:
> +	kfree(bo_handles_write);
> +put_gobj_read:
> +	while (rentry-- > 0)
> +		drm_gem_object_put(gobj_read[rentry]);
> +	kfree(gobj_read);
> +free_bo_handles_read:
> +	kfree(bo_handles_read);
>   free_syncobj:
>   	while (entry-- > 0)
>   		if (syncobj[entry])
> @@ -506,28 +548,35 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   			    struct drm_file *filp)
>   {
> -	u32 *syncobj_handles, *timeline_points, *timeline_handles, *bo_handles;
> -	u32 num_syncobj, num_bo_handles, num_points;
> +	u32 *syncobj_handles, *timeline_points, *timeline_handles, *bo_handles_read, *bo_handles_write;
> +	u32 num_syncobj, num_read_bo_handles, num_write_bo_handles, num_points;
>   	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
>   	struct drm_amdgpu_userq_wait *wait_info = data;
> +	struct drm_gem_object **gobj_write;
> +	struct drm_gem_object **gobj_read;
>   	struct dma_fence **fences = NULL;
> -	struct drm_gem_object **gobj;
> +	int r, i, rentry, wentry, cnt;
>   	struct drm_exec exec;
> -	int r, i, entry, cnt;
>   	u64 num_fences = 0;
>   
> -	num_bo_handles = wait_info->num_bo_handles;
> -	bo_handles = memdup_user(u64_to_user_ptr(wait_info->bo_handles_array),
> -				 sizeof(u32) * num_bo_handles);
> -	if (IS_ERR(bo_handles))
> -		return PTR_ERR(bo_handles);
> +	num_read_bo_handles = wait_info->num_read_bo_handles;
> +	bo_handles_read = memdup_user(u64_to_user_ptr(wait_info->bo_handles_read_array),
> +				      sizeof(u32) * num_read_bo_handles);
> +	if (IS_ERR(bo_handles_read))
> +		return PTR_ERR(bo_handles_read);
> +
> +	num_write_bo_handles = wait_info->num_write_bo_handles;
> +	bo_handles_write = memdup_user(u64_to_user_ptr(wait_info->bo_handles_write_array),
> +				       sizeof(u32) * num_write_bo_handles);
> +	if (IS_ERR(bo_handles_write))
> +		goto free_bo_handles_read;
>   
>   	num_syncobj = wait_info->num_syncobj_handles;
>   	syncobj_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_handles_array),
>   				      sizeof(u32) * num_syncobj);
>   	if (IS_ERR(syncobj_handles)) {
>   		r = PTR_ERR(syncobj_handles);
> -		goto free_bo_handles;
> +		goto free_bo_handles_write;
>   	}
>   
>   	num_points = wait_info->num_points;
> @@ -545,29 +594,51 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   		goto free_timeline_handles;
>   	}
>   
> -	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
> -	if (!gobj) {
> +	gobj_read = kmalloc_array(num_read_bo_handles, sizeof(*gobj_read), GFP_KERNEL);
> +	if (!gobj_read) {
>   		r = -ENOMEM;
>   		goto free_timeline_points;
>   	}
>   
> -	for (entry = 0; entry < num_bo_handles; entry++) {
> -		gobj[entry] = drm_gem_object_lookup(filp, bo_handles[entry]);
> -		if (!gobj[entry]) {
> +	for (rentry = 0; rentry < num_read_bo_handles; rentry++) {
> +		gobj_read[rentry] = drm_gem_object_lookup(filp, bo_handles_read[rentry]);
> +		if (!gobj_read[rentry]) {
> +			r = -ENOENT;
> +			goto put_gobj_read;
> +		}
> +	}
> +
> +	gobj_write = kmalloc_array(num_write_bo_handles, sizeof(*gobj_write), GFP_KERNEL);
> +	if (!gobj_write) {
> +		r = -ENOMEM;
> +		goto put_gobj_read;
> +	}
> +
> +	for (wentry = 0; wentry < num_write_bo_handles; wentry++) {
> +		gobj_write[wentry] = drm_gem_object_lookup(filp, bo_handles_write[wentry]);
> +		if (!gobj_write[wentry]) {
>   			r = -ENOENT;
> -			goto put_gobj;
> +			goto put_gobj_write;
>   		}
>   	}
>   
> -	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, num_bo_handles);
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> +		      (num_read_bo_handles + num_write_bo_handles));
>   
>   	/* Lock all BOs with retry handling */
>   	drm_exec_until_all_locked(&exec) {
> -		r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 0);
> +		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 0);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r) {
> +			drm_exec_fini(&exec);
> +			goto put_gobj_write;
> +		}
> +
> +		r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 0);
>   		drm_exec_retry_on_contention(&exec);
>   		if (r) {
>   			drm_exec_fini(&exec);
> -			goto put_gobj;
> +			goto put_gobj_write;
>   		}
>   	}
>   
> @@ -611,13 +682,21 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   		}
>   
>   		/* Count GEM objects fence */
> -		for (i = 0; i < num_bo_handles; i++) {
> +		for (i = 0; i < num_read_bo_handles; i++) {
>   			struct dma_resv_iter resv_cursor;
>   			struct dma_fence *fence;
>   
> -			dma_resv_for_each_fence(&resv_cursor, gobj[i]->resv,
> -						dma_resv_usage_rw(wait_info->bo_wait_flags &
> -						AMDGPU_USERQ_BO_WRITE), fence)
> +			dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
> +						DMA_RESV_USAGE_READ, fence)
> +				num_fences++;
> +		}
> +
> +		for (i = 0; i < num_write_bo_handles; i++) {
> +			struct dma_resv_iter resv_cursor;
> +			struct dma_fence *fence;
> +
> +			dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
> +						DMA_RESV_USAGE_WRITE, fence)
>   				num_fences++;
>   		}
>   
> @@ -643,14 +722,30 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   			goto free_fence_info;
>   		}
>   
> -		/* Retrieve GEM objects fence */
> -		for (i = 0; i < num_bo_handles; i++) {
> +		/* Retrieve GEM read objects fence */
> +		for (i = 0; i < num_read_bo_handles; i++) {
>   			struct dma_resv_iter resv_cursor;
>   			struct dma_fence *fence;
>   
> -			dma_resv_for_each_fence(&resv_cursor, gobj[i]->resv,
> -						dma_resv_usage_rw(wait_info->bo_wait_flags &
> -						AMDGPU_USERQ_BO_WRITE), fence) {
> +			dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
> +						DMA_RESV_USAGE_READ, fence) {
> +				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
> +					r = -EINVAL;
> +					goto free_fences;
> +				}
> +
> +				fences[num_fences++] = fence;
> +				dma_fence_get(fence);
> +			}
> +		}
> +
> +		/* Retrieve GEM write objects fence */
> +		for (i = 0; i < num_write_bo_handles; i++) {
> +			struct dma_resv_iter resv_cursor;
> +			struct dma_fence *fence;
> +
> +			dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
> +						DMA_RESV_USAGE_WRITE, fence) {
>   				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
>   					r = -EINVAL;
>   					goto free_fences;
> @@ -771,14 +866,19 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   	}
>   
>   	drm_exec_fini(&exec);
> -	for (i = 0; i < num_bo_handles; i++)
> -		drm_gem_object_put(gobj[i]);
> -	kfree(gobj);
> +	for (i = 0; i < num_read_bo_handles; i++)
> +		drm_gem_object_put(gobj_read[i]);
> +	kfree(gobj_read);
> +
> +	for (i = 0; i < num_write_bo_handles; i++)
> +		drm_gem_object_put(gobj_write[i]);
> +	kfree(gobj_write);
>   
>   	kfree(timeline_points);
>   	kfree(timeline_handles);
>   	kfree(syncobj_handles);
> -	kfree(bo_handles);
> +	kfree(bo_handles_write);
> +	kfree(bo_handles_read);
>   
>   	return 0;
>   
> @@ -790,18 +890,24 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   	kfree(fence_info);
>   exec_fini:
>   	drm_exec_fini(&exec);
> -put_gobj:
> -	while (entry-- > 0)
> -		drm_gem_object_put(gobj[entry]);
> -	kfree(gobj);
> +put_gobj_write:
> +	while (wentry-- > 0)
> +		drm_gem_object_put(gobj_write[wentry]);
> +	kfree(gobj_write);
> +put_gobj_read:
> +	while (rentry-- > 0)
> +		drm_gem_object_put(gobj_read[rentry]);
> +	kfree(gobj_read);
>   free_timeline_points:
>   	kfree(timeline_points);
>   free_timeline_handles:
>   	kfree(timeline_handles);
>   free_syncobj_handles:
>   	kfree(syncobj_handles);
> -free_bo_handles:
> -	kfree(bo_handles);
> +free_bo_handles_write:
> +	kfree(bo_handles_write);
> +free_bo_handles_read:
> +	kfree(bo_handles_read);
>   
>   	return r;
>   }
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index eeb345ddbf57..8d21e765094b 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -443,9 +443,6 @@ struct drm_amdgpu_userq_mqd_compute_gfx_v11 {
>   	__u64   eop_va;
>   };
>   
> -/* dma_resv usage flag */
> -#define AMDGPU_USERQ_BO_WRITE	1
> -
>   /* userq signal/wait ioctl */
>   struct drm_amdgpu_userq_signal {
>   	/**
> @@ -475,20 +472,32 @@ struct drm_amdgpu_userq_signal {
>   	 */
>   	__u64	syncobj_point;
>   	/**
> -	 * @bo_handles_array: An array of GEM BO handles used by the userq fence creation
> -	 * IOCTL to install the created dma_fence object which can be utilized by
> +	 * @bo_handles_read_array: An array of GEM read BO handles used by the userq fence
> +	 * creation IOCTL to install the created dma_fence object which can be utilized by
> +	 * userspace to synchronize the BO usage between user processes.
> +	 */
> +	__u64	bo_handles_read_array;
> +	/**
> +	 * @bo_handles_write_array: An array of GEM write BO handles used by the userq fence
> +	 * creation IOCTL to install the created dma_fence object which can be utilized by
>   	 * userspace to synchronize the BO usage between user processes.
>   	 */
> -	__u64	bo_handles_array;
> +	__u64	bo_handles_write_array;
> +	/**
> +	 * @num_read_bo_handles: A count that represents the number of GEM read BO handles in
> +	 * @bo_handles_read_array.
> +	 */
> +	__u32	num_read_bo_handles;
>   	/**
> -	 * @num_bo_handles: A count that represents the number of GEM BO handles in
> -	 * @bo_handles_array.
> +	 * @num_write_bo_handles: A count that represents the number of GEM write BO handles in
> +	 * @bo_handles_write_array.
>   	 */
> -	__u32	num_bo_handles;
> +	__u32	num_write_bo_handles;
>   	/**
>   	 * @bo_flags: flags to indicate BOs synchronize for READ or WRITE
>   	 */
>   	__u32	bo_flags;
> +	__u32	pad;
>   };
>   
>   struct drm_amdgpu_userq_fence_info {
> @@ -542,20 +551,31 @@ struct drm_amdgpu_userq_wait {
>   	 */
>   	__u64	syncobj_timeline_points;
>   	/**
> -	 * @bo_handles_array: An array of GEM BO handles defined to fetch the fence
> +	 * @bo_handles_read_array: An array of GEM read BO handles defined to fetch the fence
>   	 * wait information of every BO handles in the array.
>   	 */
> -	__u64	bo_handles_array;
> +	__u64	bo_handles_read_array;
> +	/**
> +	 * @bo_handles_write_array: An array of GEM write BO handles defined to fetch the fence
> +	 * wait information of every BO handles in the array.
> +	 */
> +	__u64	bo_handles_write_array;
>   	/**
>   	 * @num_syncobj_handles: A count that represents the number of syncobj handles in
>   	 * @syncobj_handles_array.
>   	 */
>   	__u32	num_syncobj_handles;
>   	/**
> -	 * @num_bo_handles: A count that represents the number of GEM BO handles in
> -	 * @bo_handles_array.
> +	 * @num_read_bo_handles: A count that represents the number of GEM BO handles in
> +	 * @bo_handles_read_array.
> +	 */
> +	__u32	num_read_bo_handles;
> +	/**
> +	 * @num_write_bo_handles: A count that represents the number of GEM BO handles in
> +	 * @bo_handles_write_array.
>   	 */
> -	__u32	num_bo_handles;
> +	__u32	num_write_bo_handles;
> +	__u32	pad;
>   	/**
>   	 * @userq_fence_info: An array of fence information (va and value) pair of each
>   	 * objects stored in @syncobj_handles_array and @bo_handles_array.

