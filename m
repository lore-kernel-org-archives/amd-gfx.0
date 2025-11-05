Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A22CCF9F8
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 08:32:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5456710E294;
	Wed,  5 Nov 2025 08:32:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="adOlsb6e";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010043.outbound.protection.outlook.com [52.101.61.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FE3A10E294
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 08:32:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDJXpSOubpEjbaSAtMkA6Yy8NarDOXgPdPtyZ9PLPvRfUCUIj7IWF6GfoYIiMHHrDzb0v9EAbTc7HNzA4UJE4cgT2PDhe/SZ6gaimgQMIWusewwCw1ZkDmSH9giwyaj0I6HRuY7esg690Wy5wBbG6OvNEWLRKZUvUfcPGXM4ZMq/Dx8fgsaHH2yYjimpCYUmFpBu4eEvcT+Na0rkk57Rxd82E+Gl+yupxwWSioxlB4F4OyWt22n2Fm3ORaFyMFGXraJOUUciMQeVAZqfj4BlybgTs/4mNJZylaCWcp5smdWK+GiJ3ons1YQjLzDMpJhw01/c19XbQUeNC4ZOaH/UPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6G3dovjNzxKGmnduM12Kk/yOIZcR6zY4EaYp0kCwAg=;
 b=D7trmfmbDiT6GCz6VAAmYSIu3UTGrwuJfis8YE2+kuPFGWbYPwauunDF+tHeASTL0FnGo6KwlrM97bT/UfXtJ1rgF66FXhJEcEAbWDMjl1iWef7u5gvK2+sLhJ40x1wPo7nF0Wxw59Y/WqsO2rMeSA1WXhkn+PKjcREFEK4gnjHZz3YNbYCgWMWsgQyOR4AmhzCzXFHIVJBT7D0Yl5+36D1A/KML+W/NaHgASMdL5ZERpSQqu1G1haR7zFGWq4sx3FmGnuE9IWMJYX5PhZiCmrviJ4jXUHzO0RIaR23LHh/ABKc0SqB829P3qRAFVeamSjTM0RVF6PL/uEqoUyUoaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6G3dovjNzxKGmnduM12Kk/yOIZcR6zY4EaYp0kCwAg=;
 b=adOlsb6ebaRGviiL1Dwg3yLQQ4pzH5CIKuZHEbpg2gmNCp/inpO+kEUajujia0DIGPiFu7OGjO9j9gqB+L5cjd0Q1qhyd7zuUWed+MLHvoYbR9uOFd6BanwtgFUMbvQpJA3+t/6k0+cUUM2u5J0lXrOJv+ThFusMwIh6aFIJEPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB999081.namprd12.prod.outlook.com (2603:10b6:8:2ff::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 08:32:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 08:32:30 +0000
Message-ID: <b7f8dc2e-074c-44aa-ac4f-6fe3348bd62d@amd.com>
Date: Wed, 5 Nov 2025 09:32:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: fix the vm update tlb sequence
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20251105061630.4146604-1-Prike.Liang@amd.com>
 <20251105061630.4146604-3-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251105061630.4146604-3-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB999081:EE_
X-MS-Office365-Filtering-Correlation-Id: e7bb458b-0309-4c55-ed86-08de1c45dbac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHlxcWVFRFpleFJsL0QxN3hWMzhqRTRuUksxNXRWaE9ocEVCeU52TzdtZDZL?=
 =?utf-8?B?UWlUYVNrL0xMeFNScThFQlJOUjF3cFV1WTR3Vk02dGUrdWF4UzJJZTd3YWho?=
 =?utf-8?B?KzlvRFJYMjRFWDRsdDZMTGowV3Jlc3NHeFVtT2krTGc0MEI3cWk1UlFWbWYy?=
 =?utf-8?B?MURRdEhqaWtZYWovcDdVMWF5d2xpaVd6c1JtUHczTjRJL1lqMGxvdm0xZ0NX?=
 =?utf-8?B?Z1FVMktBSkhSdTNTSjF0K2NNMkVCUmNMZVBZbkZzQVgrdXY3WE90emNScThw?=
 =?utf-8?B?bkIzNkFxdlNWc1YxZXk4bXhBWnV5VHlYTjYyT1M5aGdoR0RWZGhBdVE5bVZ1?=
 =?utf-8?B?VU5IaGdRaFdnd0UwdFBWVFc0V2c0NkhKa2RiZ09mYXVTTExkMkpaRUpXWDdG?=
 =?utf-8?B?UTVsa2dST05ZUHowYlRKRDJOWXY1dDh3T29aUVVqaC9wRTV0YkNMN2ZsMzVj?=
 =?utf-8?B?bTcrOVp1Nm5EaUFDT1VBMFRId21RblBuZFZxZG1VbTFSU0ZIZnZ6UWRZYVIv?=
 =?utf-8?B?Zm9Pd1JMRTh4MnhKYSsxTWdXZHBlRERkclFWQzRzejNTaTNyV0dQK3lQUUJX?=
 =?utf-8?B?Mk5OeVFCNTdGNUpCVHR3QkhMS1pZVGNjUnlaWjM5RE9ic0ZWSkNiZVNNRlFQ?=
 =?utf-8?B?dEx5VWdSeGd1RzRMUi9DYkNORXM4Sy85d2FqSDlXc0MzcTkxdWFlRFJ5ck4r?=
 =?utf-8?B?VmxTbHhKRExJYmprNFVOSVhPbmpzSjRrUFFxUDRNUk5zQTBHbW91N0hMNjVJ?=
 =?utf-8?B?TDRvdkJBaUZCWlcwNStFYlpoTGFDK0oxZDEveE9yZ0dhTU84ZGF6OGd6Vitm?=
 =?utf-8?B?andkYUYydUV6N0xUTWdEbUJZaW1nTHFFTTdlN2szKzEzQWRNOWFvWFZrMTRR?=
 =?utf-8?B?bjdvZ1NBdlUyTCtld0plYVJkcnRSaFQzcE8rcVk3NzNGT0xVcFJxVlZRTFB5?=
 =?utf-8?B?WEtHaVI5RlNoYnlnRlBLNTBoTlB6WUlPTnhiVC9ZeE1HV1VCalRuTFZJQ0cr?=
 =?utf-8?B?UmNZeEd5STBFT2Q3bUQrNUtjZ3liTVIyaWNHbnFZZzVha3BNWU1yb2wyQ3FF?=
 =?utf-8?B?cFh4bXhpWjl3SzVma1JGYVRMZ29yWnBwalp3UEQwUVVsK3BOeVBpclE3T3NE?=
 =?utf-8?B?eGZxOExSVXBBbUsvUUp2Q0o5YnFQKzg1RzA2cngwbytEUkdnSkdxU2J6TTZu?=
 =?utf-8?B?QUpZWlFQR1ZqRVI3MFpCYjQ2QVRjVnQ2Mm4yTS94aWQ3YlY1N2NBTkNJaHBa?=
 =?utf-8?B?TkMvMHpvSkNoNGlOT21RNmhEb3hVSThmZE1WWk11blZzOFF4Y2p0bjFidFQ5?=
 =?utf-8?B?UE9yYjlWeHBLUXhCRnVxSXdEamNVNTBsSGxuQTNHRG1KazZCemhXRXJsT2FN?=
 =?utf-8?B?aWw2eXptakhySUk5bW9SaGM5ZVhlYmJKUmxoUzNPWnpVcmVjdW9XaEVCWUMy?=
 =?utf-8?B?amxzRVYxNXBPbHhCQUo1cjdBS1Jzbjk5L1JjUUhmbER5ZjFYMnpPRmxlSlZU?=
 =?utf-8?B?b2J3VDlNQVlKM3A3MTdTcnlUdmhEOE04MlhyUTYrUVlPU0gxMzZvUitjSnlP?=
 =?utf-8?B?VGZzMFR2bm44bzB3Vm9xcTAweWY1L295N3hSbkIvbzFvMWxnWExYWkc2VlVU?=
 =?utf-8?B?SjlwK0RhdHRKTkVrZWdoQ0lhTXQxTWRmRFBYeWhOTnZ3M2R3RDBkZGNqYnha?=
 =?utf-8?B?STB6NGRSb0ZXeFViOUtUbTRIQmg2V0NlR013dkw4N2NQa3FyUTdKTHZrOEx1?=
 =?utf-8?B?TGhiNHg0VVcwQ2RzNU5naWJveWcwaEJGMTZiMk1icncxVkhzQy96aVdKWXNC?=
 =?utf-8?B?YU80ZFZ4b2VUQjlyQlh6VXFIdTBEKy9lNVJpS0labjBwblNRb0ZOZjlrWnFl?=
 =?utf-8?B?SktHS2t1dFViKzdZdTNWVDBRM2RFZ1l2UUdncUVaelRmaFNMRCtuZ0pTV0Vz?=
 =?utf-8?Q?/4DlCr4aFhRRteGpfFjCzGdyFo5zWM3Q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG92TldDOGFRcFM3bU1LN01YQUlYdVlldFo3Y1lTN0VNTHFBY0F5eEdVUEVj?=
 =?utf-8?B?VjRMNVdpNGlPc0tRWFJiK0M4NlNPeVd6QTJjYjA2YjJWUXEyMFR3OTd3eHhw?=
 =?utf-8?B?N0Z2MjVLVXpFaTN0MzY0bUF3cm5MeHpMbFZpblBFaXhZSGVqMTVZS0lxai9F?=
 =?utf-8?B?bDl2TjR0UTBtaUFEaENBZUwzWW15VjdUWStUVEd3Qzc5b2sxY0VZODJOVFNC?=
 =?utf-8?B?bjFRdzlkNzhaaFZYc1cvR0lTemM0UFQ2QldCSVhZa3RRNnFmOEdXOVo2VTJJ?=
 =?utf-8?B?bks3Z1h5N3VTdldyRUJVVmtnYXFvWU41WFFxNUFBRDJMVHhjTTRaM1lxNDFw?=
 =?utf-8?B?cXBrTDBCalRHZkg5M3I2UUZYQmV0S2lyVnh3YjJpaS9FYWRtNnllRXFobFR4?=
 =?utf-8?B?aSt3Z2pwQzQ1TUgvQTBVKzduNXNBaFU0aGdYNHJZZGdOZUV1ejg3SS9DSGwy?=
 =?utf-8?B?MnVKMmxCeW1Gd01NNVJ5NnpJTjNzeUt6eUM3YXFGdDBTMHdtbUZreVFCRWVo?=
 =?utf-8?B?N3hjbGM0S2trSkxWM3owQUFodkRObE1XbFdmUU9wdGZHUHFRZHh6bndMWmFh?=
 =?utf-8?B?K3k1RzIrMm9KNkFIaGZ4eXU0Vy9jbkdOdEpiRDFLU1MwQVp4d3gwdWJPMDhj?=
 =?utf-8?B?Skl6MHhRU04weEV1OUxXOWo5Z0dMZk9yaVJKcnllTUtGbzRBc0ZNdm5HZml4?=
 =?utf-8?B?TFNORitYb1J3TEtLd2ZrNmYxb1krNzJkNGFWQXZHY3BDMFVhYjgrRGdNRDRH?=
 =?utf-8?B?RGtxNVZYaDNmbTNaSkpRU3VyTFNUN0tCWG5rWHhXNWFhdHE0Q3pOTHhkenI4?=
 =?utf-8?B?dU9HV01STE5aZll6UFdvWENzbjJpMHVsRnBjanFsU3pSZ2RjVDlGQ0ZPRUoy?=
 =?utf-8?B?NHJMRjQwMWwrNHpMM3RtS0d3bGdFMFpzM05Ib0dFNVdRTkFNWThoZDJGNEFt?=
 =?utf-8?B?dGlpN3Nya0VBcGVkZlloOHo1RWlOWGJ5SWhKLyt1d3VvWm9BUndGaW1Ua0t6?=
 =?utf-8?B?SjhrTkl6QlJhSlVBOURESDBRZjAvQ1lKNURDekVjU0NnYnZ4RkxScnpOb0dR?=
 =?utf-8?B?bzJpZFZiWVdxN2p5a21jMVh6cDVKQmJVdFFZbWZNSGNoUG5Ueml0dDdXaGJY?=
 =?utf-8?B?K1Rqci9zYjJIOTIyblVsOWtoVXZvbVhLNWQvWWNqNGFqMWVVWDNDU2lraW05?=
 =?utf-8?B?UUdZRWlvSGZvQWROYm4rekRlQ1Vkcm4zdmZmQlhoa2wvSW9qbW96YVdFZEo0?=
 =?utf-8?B?SjlORTZxVi9wV0lkc0RGNEJlTDM4TktkQnpBU051RHJObmRNVFpucUNyMldn?=
 =?utf-8?B?R0RLdHF3RzVMZ25TeElBRnVuYlNNNkI3dll3blZoMHVIOFowV2REYmFCQ2t3?=
 =?utf-8?B?S1FFUkxzaDdqNGppWE1CVXpoS3ZxMUV4VDFVVXJFa1c1b0ZrR2czYmlxTGV1?=
 =?utf-8?B?ZDZ0ZS9QWWIyaU9YWGlVSHZ3WXg0N2pXUFBpSGJNQUltZFpndU1qaS9CSXIx?=
 =?utf-8?B?V3haM2tyYnVkdTEveEUrUTBVV1RtYld4aGlTMmF1a3IvYXhmRFZ4Ky9XTVJL?=
 =?utf-8?B?VUVCaEg4WWNIanJjZ3RLNmVuRGRWbkMrY1lueXBPRGNGMzgyUmpUUmxlVDJx?=
 =?utf-8?B?ZmJhSzd1blE1cys2Z2hrN1p1M1B6aG9NclhMQ0hBOWRVVThPOGh0OVo0dGxn?=
 =?utf-8?B?bitqcGlBdVdGVHhvZkd6elN4MEtpZ3lTdHNXMHVuRzc5b01HdW1CMVhaekVB?=
 =?utf-8?B?Y1RWVndlR1o2NU84NTRka3RKYWpGQlZkVUVnZzhmZG9raTEvS29iekN3Mmdw?=
 =?utf-8?B?RElLRlVmdCs2QW4yQktlS2Q0SGZ5WE5XYkQrNW1Za0QzSnpKSXBjKzhUN1F3?=
 =?utf-8?B?VnNNSkpVeHI5Z3NNNE01SEFiek1sNWRqZ2ZEZ0pxcklsWkZtelN0M2doRVJM?=
 =?utf-8?B?R0o4azhMV0xxam1iSTdGb2hHTTJqTHg4MVpZZFZLRkt0KzEyN1g1VUd0Umt4?=
 =?utf-8?B?N2c1ZHU0TE9qcXdOTGd1OVhZKzRUVytlUlI4ZzRDN2JoT2JvZWd4Qk9GeDhy?=
 =?utf-8?B?eDRLVFNpblc4Sk12THlkSGE4MG9Mdk94OElTYUZOVE9manl2ZzV0K1RxZG82?=
 =?utf-8?Q?RF12DX0fNq5cIgkqq/iil/c2x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bb458b-0309-4c55-ed86-08de1c45dbac
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 08:32:30.0160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27KtwTaaiGpceTn3K3mJyIGWDIAilMixb+bzkbRTK4wD9UE5jgRpUElzeIkKidVY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999081
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

On 11/5/25 07:16, Prike Liang wrote:
> The VM TLB sequence is incremented by the VM update
> commit invoker, so it should not be increased again
> in the commit callback.

Clear NAK to that. It must be incremented by *both*!

Regards,
Christian.

> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  | 2 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   | 2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 3 ---
>  3 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> index 0c1ef5850a5e..f7a5e71346df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> @@ -106,8 +106,6 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_params *p,
>  static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
>  				struct dma_fence **fence)
>  {
> -	if (p->needs_flush)
> -		atomic64_inc(&p->vm->tlb_seq);
>  
>  	mb();
>  	amdgpu_device_flush_hdp(p->adev, NULL);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 30022123b0bf..869f9cb28d94 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -420,6 +420,8 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		goto exit;
>  
>  	r = vm->update_funcs->commit(&params, NULL);
> +	if (params.needs_flush)
> +		atomic64_inc(&vm->tlb_seq);
>  exit:
>  	drm_dev_exit(idx);
>  	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index 46d9fb433ab2..0ceb2474a721 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -115,9 +115,6 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
>  	WARN_ON(ib->length_dw == 0);
>  	amdgpu_ring_pad_ib(ring, ib);
>  
> -	if (p->needs_flush)
> -		atomic64_inc(&p->vm->tlb_seq);
> -
>  	WARN_ON(ib->length_dw > p->num_dw_left);
>  	f = amdgpu_job_submit(p->job);
>  

