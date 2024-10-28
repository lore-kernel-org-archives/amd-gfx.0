Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A763D33990
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 15:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A8C410E4EE;
	Mon, 28 Oct 2024 15:19:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vrUxccpP";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F4B710E4EE
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 15:19:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IunwV8N1nM5BGd3k36kyhPHP6iXNyJfB13ADr4lLLrsCRDfM0xHsEkHsxBvkEovvuI+0Ko7HHoi8vY7FFT6auN+nEyUcZDVD1EXLdoeizh1ZLXUaBDhkutJ3V2W5YmdEvntIyRi0SxNnf2Xxi4ss9KJXyUxlCIMKceY1uYxM7VW39uvUxsE2jauF/nD0ZK1H6Q7y06pdkArGCMo5oEAfdg7zW3mgJT0/deMtrtusGiDbtDDGxo+idt2Db9KqEhxHLzlq3Dy9bs+jBCSz1jZcrcO8ODKHzQER3Q9f+MBYKrH5fcgpZHOf/ILwh55yl3TaAdU9wxFuVrSwbmDYU6wuag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJlnQBil6qD+EJTbr/KhLwJU4H0jp2CiK4+WjTR4dsY=;
 b=H8IKtV9iihO41D0bxBancORTRI2WfF+qLC/Da4+yujV6EB6TrkAYV9BL8XT3F2Oh7I3n6LNdf4T3TqgTjpLWPw0lqiLtJvWX8Rbh9qu0tlBdye2ikJmugyesQYewnhPaCM7CcY4nk+y2BY1rhsXNhp/MRCBi+GSW0MTFw/pWilXX1IbuZjMVVBTIG9p21ls0c01UKLHd9jv7iNTTVySAtmSWt5vbrbCN6FkWZxwP35EOcFrUOfYUphbw1iQ9DklxBa6x71BFsZLhffEZUd//uC2YZWt43vffpStHObUVo3E/9FS7OzaqDaFp1IgspDlNTprDoORxhRZFomLP/p6MKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJlnQBil6qD+EJTbr/KhLwJU4H0jp2CiK4+WjTR4dsY=;
 b=vrUxccpPAdMk/fD9pLhOOgFqjEVdi8pgYE5VZUtrJt41ifJWiKx0E+/JXBZ7gljaLKdwdlasiCeh6xNTZLZVjoIZDxQgKv6JYXHtARL2lsPfidlqXGIWSeWWCPFFOv/K8m023b8zglXFMDGV40wimm3Sg6fA1anTU5MiNBLA/D4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Mon, 28 Oct
 2024 15:19:48 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%4]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 15:19:47 +0000
Message-ID: <d599d954-e8cd-41f1-ac78-5720b6c8219b@amd.com>
Date: Mon, 28 Oct 2024 20:49:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdkfd: add an interface to query whether is KFD
 is active
Content-Language: en-GB
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241028145242.3672515-1-alexander.deucher@amd.com>
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20241028145242.3672515-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000187.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4d) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|IA1PR12MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: bf2b6a93-1699-4dbc-f8db-08dcf763f5ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHJsYm02WlRrbE45Umx6UHNzRjY5VnJpNWhHT1NzSStiT2dyYUFQQklCcUpi?=
 =?utf-8?B?YjRsNVp1ZGNzZVBHSkNsWW10RXVpMFZPa3VNUTRmSmYyWlcrdmNGSnFzNFpL?=
 =?utf-8?B?Vi9oTVdkMTZFZForQ2FTQkJ2R0JLalZKZG9TT3JkbFFNczVlZ2E5OG83M20x?=
 =?utf-8?B?QnNlQzBpbTNKUEJiUlNpaEhIaU1YQXVyR2I0cmhOeG5YcFBGWSthSGZBWEZT?=
 =?utf-8?B?Nk01MWt1eGtPajNkd2pOQmZtZlJCOFA2QXo5RWYyK3NaNVZ1bXI0YVcwNnNq?=
 =?utf-8?B?M0N0bWk0eWJUaFBGT0xTcDMxRnJGZ3NOcUtIVU8xME1Ea2FqbGIzSEtwOGUr?=
 =?utf-8?B?MnQySGVSZ1NtUmVtTnNwVC81OXJUWTBHa045VnFQUWcydVBOT3BXcWtPV1BK?=
 =?utf-8?B?N3JxTi80RU83WVU1RndFa1RDT0ZxZVA4YkExSnkrUktSQnZGSnBlcXMxQ2pR?=
 =?utf-8?B?MHlzZE9UajRyUG1Hd000cmhsVHF5RWFBeG1LM1RaZzV4V3hwSjFiOGduNyt6?=
 =?utf-8?B?VXFSaDJIWE5oL1lhb3V0bUttSjBnd1FwT0VVR1RGYXNoVyt5aXZTNU91NElX?=
 =?utf-8?B?QysxZldmV2dIVXY1SUhRWTRadXZlRHplck16bVVxSDJrUlM4Q1h0MDVSdVZ6?=
 =?utf-8?B?dTJMaldxV2JLdEVkZ05vb1B5R2ZyaHdhK1BVM3RpU2JIUGhPUUVZSmVEY0E0?=
 =?utf-8?B?Q0JkWFRGR0Q2T0xMUGRYYjRVTFpIR2NNMVhiVkRzOHMzY0Z6YWpCQ3NESTlx?=
 =?utf-8?B?ajZ1b1p1d1B2bVVlN3R4YjJPbFB1bjFCUi8rVjBlOVVUTWJweCtvb0FjVW0v?=
 =?utf-8?B?UE51M0c3aHhYQ3R3VEVCbHNSWGFuMXhsTm9paHdaVzJ0NzJ5TkdEM2UrYmlU?=
 =?utf-8?B?RjRiSEdIeHZzcEs0b1pyaklwWlBFN2VybzNaRitmbEp6S2hXeGZPS3czL21V?=
 =?utf-8?B?RktoZ3F1ZStXUnNSY2hEVWVJbktESnJyNTZyTXlYM0k2VWlZTmpGZ0lCeXYr?=
 =?utf-8?B?ZWNBZklUdlBNbnVtcHFLVE9RbnNYUkh5RW8zN3FXckx5WE1qNzhTWlVPWVZL?=
 =?utf-8?B?MEFnM2dKOGxFL2ZUZHI5dTJzcVlCRWplTkFKY3IwSGN0bjhCMzJjeVQvVWxM?=
 =?utf-8?B?b1I4Z3M3ZDVSeTNXUEZIT0lqV1BsVnZJc3BsOFNwMXJCeFFjWXE2cHF6SnZs?=
 =?utf-8?B?YVRZS1EzQkJRZ1U3bGlUZGJlU0sxakRxVTYzL2pXUTJUQmVIR3pXZ1ozQ1pu?=
 =?utf-8?B?Q2RqWjdDZk1hWENWYnZNbGJrM0xUelEyWkgxc1A4dTFKQ3VQdGZiUjVOaTBQ?=
 =?utf-8?B?TWxhV3F3OXFKNU5hKy8rbEwxS0oxcEZCT3RPZVBKbnp4dXNWYjgxMklMbWM2?=
 =?utf-8?B?bTE1enJERS9lMlNOZjRpdGhmQVVWN2lQVG43VkFFQXJROVZoaVJkbnQrR1VP?=
 =?utf-8?B?T3hDTnpZT1RDZGJ2T2lSNGNZV3dNWXZDUXVWYnlLQVRpbmVZTWE2U2FnSklN?=
 =?utf-8?B?TTVYcTJ1ZmFwcSszdmhVSk1TcUtnWFoyY2NGTjZ3T2hzTHZFTFA3RUNSSzh6?=
 =?utf-8?B?SEtQVS85U1ZkVXEzMncvQ3lTS1F5bHNBaEV4cG5ZUHdzcDd4VWFrU3FvMWxx?=
 =?utf-8?B?Q1BmN21FVGVZNnBsMTZwUHdKTVB0SHdHaGlkYmhqK0E0aTA0engwYmhtZElk?=
 =?utf-8?B?MkZUSlE1K0VjWnErQk94cVZnWG5TYWFRc3dQUkpWVzRUM2pvdlhxVEkvSTha?=
 =?utf-8?Q?adMTpM1GUzdKgNqp2Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUNRc2IweXZRMW1xVnBKY095eHNkUTM5NHptTHAvaFhkeHZ4MG1BTnZJWDc3?=
 =?utf-8?B?T0xZSm5yK1JEb2EremoyQkY3MmRsUzYvekhJV1daTU9jZFl2SjJnSUIxdTU4?=
 =?utf-8?B?dzVnSWN1NW52UmR4SjF4RG5NVXNscG1sVmZpcGdsczlWLzdXTC9sVTZiWDhH?=
 =?utf-8?B?Uy92T1pBS3RYOGcreGhkSW5UdG1uMjZMRGJCdDluWmpEWS9mR1hrQnprRW4w?=
 =?utf-8?B?U01HMWlDY3lGWUV1RzhIRXRvZDFsNkRqb2xoT0FPaWx1QUJzd2xSdk9jWDNZ?=
 =?utf-8?B?cGZYVU9oaVVoczhzMnBqVDZEa0crZ2FTdFpkUnNPN21UZnRCMUdld1MyZi83?=
 =?utf-8?B?SHdOSWs2b0wwQVlDbWszR2NjV3J5Tmo5RWpUUXM3SG1SckRVelFDaE40VUVJ?=
 =?utf-8?B?clYrNDVzOVZwWEJJNVR3SHphVE1VdWcyemI5NFM1dWZwZm1mZGhYT0liczdq?=
 =?utf-8?B?TTN5aitURjJvcTdJQXY3Ymx5dmRaMVRrR1IyamRuc1hsSnl4T3BYL1hGWGFZ?=
 =?utf-8?B?OVFZQm9HV1BHZVl5MkF0dlJwNWVrdS9UcTBxY253cnpoZFlROUtCbEFVWnZ2?=
 =?utf-8?B?Rms2U1lTZnJxMDNoMUhJWSt3YWlmRG1wb3VzWjF2eExpcjRYYjZPUDlMeDVo?=
 =?utf-8?B?QXlvUXFEd3lmNmdvWU40anY4cFFmcHIvZ0djSTVDSjJIR1ZTWDltZjlkUzM0?=
 =?utf-8?B?TkZtazgySWRMMG8wWmQ4Skw2Qmd3UVZwVE9GdERsZ0VWYXJDNEUyQkpwNGJL?=
 =?utf-8?B?VG5FczE0VDA4N0crY1BkK2t2UzNsTDRpYk1ZcGJUcElXK2lxQW1VdXZHL1dR?=
 =?utf-8?B?SytHQ0pMRU4vK2tqRnZ6SGVGdmpYOG14WXNpNGl1WTVRMURjR0F1SG10eG05?=
 =?utf-8?B?S0NBUWdHVVBnUEVhSWxkdU1oVm9sbWl6cWZya1Q4VUZMRUNCdEtmS3QyTDlB?=
 =?utf-8?B?RURtaXVRdHZpK2VJeXY2a2lJKzFXM1JrYjRNN1RtRDdKa1hwcEtGOGFxSEIx?=
 =?utf-8?B?S2FpRTY3QXZSNVZHd2Ixc1cyN2pLcDVaYXdaYmFZOFNWQk5tZTNnZXpKMUlJ?=
 =?utf-8?B?ZzdkbW1oSDFMcGZTL2QwL3doRDRBT0FUY2Jkd0hTanM5WUt0T2lzZERLNlhy?=
 =?utf-8?B?RzFIdkxDQWllUEJCWUg5N2F6VTFib2ZHYldzdTNhK2VrK3FWSmFocHFHNFR6?=
 =?utf-8?B?Y1NFbEYrNWVNSFlET2Y0amRhdXJKTEVkb3JaRXJKQUsxWXUzY1RlQ01Pdi9K?=
 =?utf-8?B?TWhndUNCeGJjYWdCZ0w0Um1kM3U0YlY0ajZCRjBnMFNxOFp3dXRscFRvQW54?=
 =?utf-8?B?cDdWL0FSd2FYRVVCSVM5bkhGZTUwOE1RcUhyNUg5TW1xclFlT1paRHJXcm5H?=
 =?utf-8?B?OC90cVE2K1YzZmozMGV1NUNJeDFuZnRCTE5FRDhEYjdyZENUSEJBNTZhOFF3?=
 =?utf-8?B?K3pGeTM0ZDVJODlCRWN5cmFsc3dpalc3VWhrVFAvTTA1YjkzaHUxb0xrL3l6?=
 =?utf-8?B?cFkvOFF0MVRlZGhmOUZYbmR3ODVMZXM5ZnYzNW13Q2pRbUtoUTMzb0VVRmhp?=
 =?utf-8?B?dERuaTlYMGR5bEdQeGRsU3NqTThRdXJTSXdRY29jdEYreTBqR2Nsekh3ejQ2?=
 =?utf-8?B?WWlUcVhaNytaWS9CVndaSWlrdkh6eFNOOWs1UStNWVpZeWVnT3cvWHNWQ2dK?=
 =?utf-8?B?OFc4SUxoZXR0eWpyd0xYYUhKcUo4SGZhV2ZDaHZaU21jNVdkanpNTGxMR2k0?=
 =?utf-8?B?YTNkV0o1SHJISVFHWnh4K1RvQlcySER2UCtlUEdYWVhmYXh2OVc3V3d5UzZR?=
 =?utf-8?B?WDdXOVh4U3hNcldJc2JkbTZoelpvbGdwSXFpRFJmUFE5alRjajlDY09acU9P?=
 =?utf-8?B?T0g0VGNMNG9DMVlDdS81Z2ovOVk3MTdDRGx5aXYwWVRqRDYyMmN2L0RxbmR6?=
 =?utf-8?B?MDh3cnhrZTdnUlB0Qmc1dlh4TVUzRDVGUVRQRDQzTmhRNkcwZUZKSmIrTndq?=
 =?utf-8?B?dFhBWHJWWkRLb2Z1L3ZWb2ZwMm4yRFRLQXdsYmRRc01jcUFScWE5T0d2Tkkv?=
 =?utf-8?B?S0RMR1M4UWVRN1ZuSG5VMXR2c3Vja0xtWEMwL2doOHBmNWdIazFnY1pxRXQ5?=
 =?utf-8?Q?s2JOw3QNZejDLnXHMFrU9jja2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2b6a93-1699-4dbc-f8db-08dcf763f5ba
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 15:19:47.9089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NN0XTBGlSonkac3Ra7QCpSgpVjmlmV2gJ+vHci+EU8Rod5KdBSeXaNUwGTsJ27k1Z2S3GAkJFl2oZbWxyVXJXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518
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

The series is:
Acked-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

On 10/28/2024 8:22 PM, Alex Deucher wrote:
> Add an interface to query whether KFD has any active queues.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  9 ++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  7 ++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 25 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  1 +
>   4 files changed, 42 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index b545940e512b..82f1c6a19d79 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -890,6 +890,15 @@ int amdgpu_amdkfd_start_sched(struct amdgpu_device *adev, uint32_t node_id)
>   	return kgd2kfd_start_sched(adev->kfd.dev, node_id);
>   }
>   
> +/* check if there are KFD queues active */
> +bool amdgpu_amdkfd_compute_active(struct amdgpu_device *adev, uint32_t node_id)
> +{
> +	if (!adev->kfd.init_complete)
> +		return 0;
> +
> +	return kgd2kfd_compute_active(adev->kfd.dev, node_id);
> +}
> +
>   /* Config CGTT_SQ_CLK_CTRL */
>   int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, uint32_t xcp_id,
>   	bool core_override_enable, bool reg_override_enable, bool perfmon_override_enable)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 7e0a22072536..f47f4555437b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -268,6 +268,7 @@ int amdgpu_amdkfd_start_sched(struct amdgpu_device *adev, uint32_t node_id);
>   int amdgpu_amdkfd_stop_sched(struct amdgpu_device *adev, uint32_t node_id);
>   int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, uint32_t xcp_id,
>   	bool core_override_enable, bool reg_override_enable, bool perfmon_override_enable);
> +bool amdgpu_amdkfd_compute_active(struct amdgpu_device *adev, uint32_t node_id);
>   
>   
>   /* Read user wptr from a specified user address space with page fault
> @@ -431,6 +432,7 @@ int kgd2kfd_check_and_lock_kfd(void);
>   void kgd2kfd_unlock_kfd(void);
>   int kgd2kfd_start_sched(struct kfd_dev *kfd, uint32_t node_id);
>   int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id);
> +bool kgd2kfd_compute_active(struct kfd_dev *kfd, uint32_t node_id);
>   #else
>   static inline int kgd2kfd_init(void)
>   {
> @@ -511,5 +513,10 @@ static inline int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id)
>   {
>   	return 0;
>   }
> +
> +bool kgd2kfd_compute_active(struct kfd_dev *kfd, uint32_t node_id)
> +{
> +	return false;
> +}
>   #endif
>   #endif /* AMDGPU_AMDKFD_H_INCLUDED */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index b1ce73c7a9ab..9d8bdead6e65 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1404,6 +1404,13 @@ void kfd_dec_compute_active(struct kfd_node *node)
>   	WARN_ONCE(count < 0, "Compute profile ref. count error");
>   }
>   
> +bool kfd_compute_active(struct kfd_node *node)
> +{
> +	if (atomic_read(&node->kfd->compute_profile))
> +		return true;
> +	return false;
> +}
> +
>   void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint64_t throttle_bitmask)
>   {
>   	/*
> @@ -1497,6 +1504,24 @@ int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id)
>   	return node->dqm->ops.halt(node->dqm);
>   }
>   
> +bool kgd2kfd_compute_active(struct kfd_dev *kfd, uint32_t node_id)
> +{
> +	struct kfd_node *node;
> +
> +	if (!kfd->init_complete)
> +		return false;
> +
> +	if (node_id >= kfd->num_nodes) {
> +		dev_warn(kfd->adev->dev, "Invalid node ID: %u exceeds %u\n",
> +			 node_id, kfd->num_nodes - 1);
> +		return false;
> +	}
> +
> +	node = kfd->nodes[node_id];
> +
> +	return kfd_compute_active(node);
> +}
> +
>   #if defined(CONFIG_DEBUG_FS)
>   
>   /* This function will send a package to HIQ to hang the HWS
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 9e5ca0b93b2a..f9140fdb8132 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1518,6 +1518,7 @@ bool kfd_is_locked(void);
>   /* Compute profile */
>   void kfd_inc_compute_active(struct kfd_node *dev);
>   void kfd_dec_compute_active(struct kfd_node *dev);
> +bool kfd_compute_active(struct kfd_node *dev);
>   
>   /* Cgroup Support */
>   /* Check with device cgroup if @kfd device is accessible */
