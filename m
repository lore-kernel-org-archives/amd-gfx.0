Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C556C282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 14:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A97410E2FF;
	Mon, 17 Mar 2025 14:04:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mPlAW3MG";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C643B10E2FF
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 14:03:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUSwo1rcGs+XcN4FchIbeVjTgA81IqDadxEL2imBPYuNnYtJa7DABLKs4qqlmG1kzJXDlInXuWlTYyQcGIIFQ59REmJxDUP7gqJCx8xJ4riVybYNm21fmMwr/ZZ8ODo0PB12a2RNb2kVUHTON7n7X+hxwc++dQ0ukiHAyo3WKPDKZQV+j+Xbbv/K1d9J8jZW2KO9WzvoFXoKKu4VEWEj34RfP3jFNRJLbZj9U4/+axf8PG2Rjon9DbG7CVOGC0gUscVAwEyhxD6bmhI//bu3wJIcdUtUI8J+rBuyuetogmtyDig+jEOKd7EpTynM68+j8TdT4VsqZekQW5P8ZQUcPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qe75lHJSz7Eoa3w5Tsjj+cRols60Xjk2DztwSVWP2Dw=;
 b=qmEb0iSX6+PQDLfYnV8ZJABOGjUQbkIvDSEqQA4X5dcC4On3gdVhgrMn8Mw7U0oGunUBWPzq+zxTGL72+WkZ1CpJK5bPDZTAlzbvqAyM0dJnDb6CLn9cTAban6H5xIJCTqGWoUtZLXOpoUSaJCalmghwzvemBzTwY4s3yMuMpRGBUmy+9jJOkaqx10QI1yuKxlFMQiQqLiPWbxdKs6xWWTvzcocveapz8PCOhFU7NTm+jgYGzM+3H+euNb7K5msNB59UaCk4Jy/8QYRYwr+WneCs/enPIYz4haPyHMrqEvpr7nDR6A04yGHqmxDXOVYCAV0vsJlWycHaNOKOYANqXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qe75lHJSz7Eoa3w5Tsjj+cRols60Xjk2DztwSVWP2Dw=;
 b=mPlAW3MG2kYFv5Xfy2YeZu1tkbPbm5XVKVN10BhjCOHbXwoAYDXIMccC3KZUzVbp1CPCayYY171VRXIbfDOqVQqRRM+XD9Cbx3WEx5P0iRFTrK/5bYyTCD5o1D0+vKxvAJUL0D6IQCHqUu92OyqWrakNuXYivl1nb9gmA8U3+/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 17 Mar
 2025 14:03:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8511.026; Mon, 17 Mar 2025
 14:03:56 +0000
Message-ID: <6face0d4-8adf-488f-84c8-12a012bdde15@amd.com>
Date: Mon, 17 Mar 2025 15:03:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Wait for pte updates before uq_resume
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250316153635.1181513-1-sathishkumar.sundararaju@amd.com>
 <20250316153635.1181513-2-sathishkumar.sundararaju@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250316153635.1181513-2-sathishkumar.sundararaju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0406.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: d99ffaaf-81f4-4b55-d09f-08dd655c8e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXAxbnNUZ2dCVjFvNGtBN0dsM3pGbHJ3eXBPc3hJTzkraXR5bmcvYnRvbldV?=
 =?utf-8?B?aGN4M002NjlPZXNrS3FqaTUyanVZd3VIL3FkTGNJaVJ4M0hkSnlJOW9mV0gw?=
 =?utf-8?B?T1haRnFCNXgrU0RJZjNIS0lWVUVUMkptc0dLWkcrQW9tOG9Qb1ZiS0xJYWRp?=
 =?utf-8?B?VUF4T1VSeHQyVmZHZ3RiV2xjK1V5bEVCN2tzaDZaS0o4M1hHblBLRGFRQW5H?=
 =?utf-8?B?S2RieGt2dXdyYXBtYWpUa0pIN0NReC9MaEtJVDB3UEZ2NE5rSVVDMDhzRGo3?=
 =?utf-8?B?OHh5MGR5ZnRncWpSNERXMXZaVENQOCtoVU9mT2NSTWhVTlVscVpDZ2tUMSs5?=
 =?utf-8?B?ZTQ5QzYrZmNKK0pLZWthREVqVjBmRERld0NTOXpkR0Y0MWt6clI4bzgzYjhv?=
 =?utf-8?B?cDl5ZjNaM1hPNzNNM0FHZk5DRmVNRDdIRlV1RmJtdGxYSSs0RS9WdWpaY29P?=
 =?utf-8?B?UVZMM3UyU0xpOU1tWTFlSDh6N3BWdG9MYmZ1WHplbDBxdStRSjB4M3k0Z1Z1?=
 =?utf-8?B?YmVGc21UTzRsTWNRa1ZlQXJVdnA0bjlJU3hDT2NibVdGa0x2NkZlK1hsRWpT?=
 =?utf-8?B?OWxrYlo1eGQ3dWNMOFRYQkROSi9zemRjaFBCeGJNYkNEVHhKclo3eWJzbk1j?=
 =?utf-8?B?U0xkVEVPVFVsVmtKSHIzOUdTanBMRUhJN1BPblFKdlpwSFVhdkJQRjVGNE16?=
 =?utf-8?B?RHNyRmNwUG9ER1RIaTJERERQdFZ1YW9YMy93QkVlN3c4VWd2M2piYlhOS2I4?=
 =?utf-8?B?N0hCRVMyOTVBMm4yTlhrREF0UnZKS3F4ZjBTczcweURjclRpcnExQmJUZlJ3?=
 =?utf-8?B?M2NaZnVzNGtjZ0RIN21PVG43VjU2Y0JxaWlrL2d2QlQvSDNOamhHUVVvVUZ2?=
 =?utf-8?B?ekpXL1N2Y3ludVp6VVNzZTkzV05ZUk1HVi9ibUlTdHlaRERqRWJzZXpaZEZi?=
 =?utf-8?B?RWE1TUNmM1VyVzYza0l3OFBERWVJb0dQK3d0MFVFTzhmNzNQWkV4OXFLb0JH?=
 =?utf-8?B?cFJmSWgzZm41Y3hiZmdwWER6dWhRMG9yS2tTZDR3SUxBNlZwODdQcW1Kb1Bt?=
 =?utf-8?B?dk5CMnpVenFkR1lTK0RUSGVqN3ZqUGxLZ1dNTzkvNjJ0Qys3L3lPelN3RnR5?=
 =?utf-8?B?TFlGbXVsN3VURno0cDJDWGt5WGNJWHQ4ZlJBdE5OdXlkUnB0cVVYWksyVjd1?=
 =?utf-8?B?bHdScjVYdTdFOExJMmdmTFM2VHRCZTg3clludnJ2UnJzZjk5NGxoOHVXRTBo?=
 =?utf-8?B?eGhYc1U4bXBycVlVNDVMZHg4MzlCb05CUC9BRTRONlI1N3VQTWY1cE16Nkls?=
 =?utf-8?B?bkhtU0pvOFNlWFZQK3VaYXFwTUVvaVdrbE5jWUNwRmszUlRxMm1oeXBHQ09p?=
 =?utf-8?B?enBBNjlRcGd0Y2l5VWRQbUxjNUFqdkNENHpLdlZyWnM5UGpQcUNZbkdOZ3BB?=
 =?utf-8?B?NkZBLzIrdUJaVS9PL2VUOXFLNDFhZlVOaDdqajdiTEpNdXZsVmFHbmlzSVJk?=
 =?utf-8?B?NnZoS01zSFZHbGp5MTFUN042RzVWN3M4V0REQjlQVDVtdzB1eG9LZk5iS0xl?=
 =?utf-8?B?Y3JEbWpwUDA4L3lWQmttbWw0RlBpemp1YW5Hdm5kcGN4eXV2SjBaQzQ5b216?=
 =?utf-8?B?ZGFodDNqYmF2cEVnQktVcTZidGFqenEzTzhLcW5icS83MDMvYmYzTXNlN1Za?=
 =?utf-8?B?d3JMaHJLZFUvYVZldGkzeWZSUWd2T1lzS29BYjFJSnN0UXNwVjdDWFdZQnN4?=
 =?utf-8?B?OVpvd0lYcFFGREdnRi82bUE3cGpRL2Y1TmNCM0dUME5maE9IU2I1c1JHanY5?=
 =?utf-8?B?S1RQSmVlcEgvQ01RVGYxU1lxSElSaEhHYXQvbGM2VjNJQXhtdTB0WnYxZ1hR?=
 =?utf-8?Q?gRosqVK0+a5OF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmxMTVprSHNWWTBwdnFZcjJiVElBa3oxME1YUHNmWTFGa1FvelBxRVZEeGhM?=
 =?utf-8?B?YS9Fc0gyNHBPYVlOdnNhdWU3QzVsSUhVKzByUTk5YlRsdFlPR0NZZTU2VE1C?=
 =?utf-8?B?NmJ6TmY4d3J1eHhIWTl0RjlnMTljdy9qY2RSUXdMeVhpeHhMQ2hveXlodFBt?=
 =?utf-8?B?VGhkSFVoRWxySDkvTStTS25TMkNlMW9iME1kSGNGNTEzZFQrK2lMWEdqaEY0?=
 =?utf-8?B?b3lQVXh1MzNtb0Y3eVpyeXhrdHZyNWRVQVNGR0wxRkRZUnZWV29CMjQ1M0E4?=
 =?utf-8?B?bTR4UElZN3h1OVFrTHNKbDZlZFY2bEczZHA5c0J3WjFIT2RSRnhwRm1iV0RH?=
 =?utf-8?B?Q0V0alhoQnlpYzRERklFR0ZiVkxLbk8rbUVqcEpsNURsZ0QwdkMwaThzK3By?=
 =?utf-8?B?MmtXUHlndzIyVnBKT3hlRTFHOXQ1c0FiNzMwdWd0UzJmVThCbnJkVjJFTWZk?=
 =?utf-8?B?TXNMNnlWaGhJVjFJbGxIeUViU3hyMDFBaGhlQVR6aVFNNElUcllvZ2w4WXBw?=
 =?utf-8?B?bVhLWVpJTjJMVDF0MnJrWUJ2UjU0VFk5a2x0QnU3TWwxQ3RnckxCUGlnRkwv?=
 =?utf-8?B?RUhRQjlPc0R3ZFVWWFlFeE5qQVd3N1l4WGc4SDVQQk80a0g4K0hLTEk3WWlH?=
 =?utf-8?B?MjlOOE0yVWhhWmpadys3ZXpSYUxwd0crVm92ZFU2REV4SmRYV1BHWFpNWnlJ?=
 =?utf-8?B?UU4rWitHYWgreXlTMzF4dGh0ZDdUYkpFNmV1NWt0c1RhUFpjODNVQ2NSaDQ4?=
 =?utf-8?B?MTJjeVg5NXNneis3VnFlU0Fod0g3L1NKQlZCM2Y5dVE3bFNiNjlyKzhENnNz?=
 =?utf-8?B?OFAyNjJVb3BOQm12NVdEeUdERHpZMUtZRytiOGgxT2F0WC9IVU5OTHRWVW9H?=
 =?utf-8?B?NWRCQzRaeEE3WWcyT1BQWnpBNWRPUjEwTG94WUJOMEZPeE95L3dnNUdJZmND?=
 =?utf-8?B?dG9PSkZTaWJJeWFHcmdRd3NXNW1RbnJwdEZRMStPY1BaRDF5TTl0cFlwdFR0?=
 =?utf-8?B?V1BNeHAvSXl0djZpY0JYZ2VKdkFSVXZWU1dQVUFveVpNajQxQ1lzZGFCVFJ3?=
 =?utf-8?B?S3RqYTR2UFl2MWtValRGck9hZ2tsMWkvanRXZG5QVDlISTJ1UGp0ZHlTa25P?=
 =?utf-8?B?L3IwOG5lT28yMGdaWFI4czZKVWpTS2RoNVppZm1jVStadTRYZGtpRGhJZVBJ?=
 =?utf-8?B?cmFkN0lkWVBZUnNucHJwTjZ3VENuNzQzeW1hZlJaQ1loMThIUzgyL3l4RUpL?=
 =?utf-8?B?c0wydnJ6MkI2Rk5Ca0lRaTVUd0Q4WUw4ZmE3eHVuVVgrMEh0dUh0Rm9DVEF2?=
 =?utf-8?B?VU5WTUh2Q0E1RDZlYXZXdXRpUUhSNkJkMWRYYld4TzNyMGhIaHRLZERobVNT?=
 =?utf-8?B?YTBFNVBQOEQ2SytVTzBGaDdjWmxSYmM1a3FGeDh6OW5WOHhVU2lORmRsQU15?=
 =?utf-8?B?aG5lUUhGdHV4dlFKNFBoWlNFNCsrOGV4RXRTNkFnTE53QmJXWHdzdVU1N1hh?=
 =?utf-8?B?b2hqRjVQWlZQWGdPRk82N2xPdS9oZGtoOCs1NWRrQ3Z0a1R2Nm9sb2k2cUNF?=
 =?utf-8?B?dVhEdU5PN2p0QitIL1ZCNzhPNit4d0p1Y0tEcmw4ZDk5b2NyeXgzSTJUN3U4?=
 =?utf-8?B?OUgrOXd2cEhpeVIxbldCelNlb2t4QzVuVHZRcGxkcmJwMXV5cG96U2VLdUNo?=
 =?utf-8?B?QWgxelErV2xZd3lPWUhGZEw3NE5DMDc2WHduZEozSUhrSmRFZktmdmh1alY0?=
 =?utf-8?B?V0g2Yy8wcEttYzJBNG9OdllySnRzQm1mVisva2RuMTNiNzFiRnA5WVh2OVZT?=
 =?utf-8?B?bkdFT2YyaEhHdHROSFRQREJtOTVBM2VPWDNCQWpqdWIyN0Jyb3hqKzV4OHVG?=
 =?utf-8?B?RC9XaGx0UVlBd1NoZXZCVk1aZ01KVWtBMVdlVUhBUlJUcEs3djBXTmZFblBj?=
 =?utf-8?B?bnVKRW1rZ0cya29BaWN5TDFST1dqUDFBYU1uanVGWlppc1RPekZFNXNMNWhH?=
 =?utf-8?B?ald3Y281aVFzWE4xa0M4cm1HdlE1U1A2cG1yeXlLVEFqYlBKQmJ3SmtJZXds?=
 =?utf-8?B?VnNwWTNvemNmemtURFRmWnp6MnA0TXE0aWNwckx5K04yRmtxZ3JMUVU1SWh2?=
 =?utf-8?Q?qFT0Pg6+Z5hl7j9sEj8dcUU2N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d99ffaaf-81f4-4b55-d09f-08dd655c8e91
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 14:03:56.1836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUj4TeRfodn/8izImDcayIor/XGHPQmCkKUMxYStfwVgdHWcs5ZYr7hgk9d1uVy8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141
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

Am 16.03.25 um 16:36 schrieb Sathishkumar S:
> Wait for vm page table updates to finish before resuming user queues.
> Resume must follow after completion of pte updates to avoid page faults.
>
> amdgpu: [gfxhub] page fault (src_id:0 ring:40 vmid:10 pasid:32771)
> amdgpu:  in process  pid 0 thread  pid 0)
> amdgpu:   in page starting at address 0x0000800105405000 from client 10
> amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00A41051
> amdgpu:      Faulty UTCL2 client ID: TCP (0x8)
> amdgpu:      MORE_FAULTS: 0x1
> amdgpu:      WALKER_ERROR: 0x0
> amdgpu:      PERMISSION_FAULTS: 0x5
> amdgpu:      MAPPING_ERROR: 0x0
> amdgpu:      RW: 0x1
> amdgpu: [gfxhub] page fault (src_id:0 ring:40 vmid:10 pasid:32771)
> amdgpu:  in process  pid 0 thread  pid 0)
> amdgpu:   in page starting at address 0x0000800105404000 from client 10
>
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index f1d4e29772a5..4c3edd988a05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -541,10 +541,23 @@ amdgpu_userqueue_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
>  static void amdgpu_userqueue_resume_worker(struct work_struct *work)
>  {
>  	struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, resume_work.work);
> +	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
> +	struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
> +	struct amdgpu_eviction_fence *ev_fence;
>  	int ret;
>  
>  	mutex_lock(&uq_mgr->userq_mutex);
>  
> +	spin_lock(&evf_mgr->ev_fence_lock);
> +	ev_fence = evf_mgr->ev_fence;
> +	spin_unlock(&evf_mgr->ev_fence_lock);
> +	if (ev_fence && dma_fence_is_signaled(&ev_fence->base)) {
> +	/* Wait for the prior vm updates to complete before proceeding with resume */
> +		dma_resv_wait_timeout(fpriv->vm.root.bo->tbo.base.resv,
> +				      DMA_RESV_USAGE_BOOKKEEP,
> +				      true,
> +				      msecs_to_jiffies(AMDGPU_FENCE_JIFFIES_TIMEOUT));
> +	}

In general I agree that we need for PTE updates before resuming userqueues, but this here is just nonsense.

>  	ret = amdgpu_userqueue_validate_bos(uq_mgr);

This call here is validating the BOs, updating the PTEs *and* making sure that we wait for this update to finish.

Waiting before that just doesn't make any sense as far as I can see.

Regards,
Christian.

>  	if (ret) {
>  		DRM_ERROR("Failed to validate BOs to restore\n");

