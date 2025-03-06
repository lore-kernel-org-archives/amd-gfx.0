Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AA8C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 10:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 617A710E936;
	Thu,  6 Mar 2025 10:21:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TFP9xeu+";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F35B710E8B1
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 10:21:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8eFY09kUwLaMbyftkadYT6E9yfpeMkT7G5Jvu+kmV1lyOLmm7l9IcdKWnLyXP53Ny6EH8GWIgm9UFzSh9rOcWr87FhbQ+EOsJvkr33tK6R6R+Q/Xx38bFTr5lJqVNKT9Z0GBDsowTmDeNrlzwSXn0m7QCMTrPAp+O+fmVQKJmuWtoTO/BGMBkp5zrwO4/BoqA2opnn0vPkCmrCvbd3FdIsllTpnOjwT5fO5KbGrzlHiziMlC91k7k2Flqotg1pvmtoS7W3zbKTPiiaRLoBinJJOVWpZKUP8FQnhiEv0/i0rlQmNqjBSLZ2zBInsnnYgJ35HFPmf+W3yYp5c2DdWSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHTOvBQ+X7M4wZGw7fMDieX//3cdTu/ZrGiJN0xzP2Q=;
 b=iiflhFCqDcJlpdlHTzRh2jsTPNjJNn2NlmdyT1uLUGuk3S8t0Sg+gmzu0d6L9g5AXB1SNbueMkxnpUxct6eBIzadchv3g4WEvpsMd3tVP3q8qAkeHbsLznWjFcgKc7GEhz7xZcZ08cOMlFIsn5YhWuVLGZu2sdrzL8mXymEzrfi354Sfhq+MtECIV9W9k4Rp0v4fO6c+GK8+Tg7zG86XqySJt4vHmmzWlOMr7JIl/Hk6Yrc58fce1YUdi7oLLSlJYrl3jSFUYAO4EyW2Ch+NgaUwrtmTn9nlzn/TwwAzLDFOWMZzqf7596WuBY04gGj/xTHuSJPWGm4L8AJNdqx3eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHTOvBQ+X7M4wZGw7fMDieX//3cdTu/ZrGiJN0xzP2Q=;
 b=TFP9xeu+uTQUrNFDxC8dN/JEeCBrpW7nkCBlcjXNZaaGNVwuhVOcXEMGl4anK50okl5gSD1pPj4IExPYPQpTLzP4q7ZgYIdfy7ZvkNt4eBIiK7b+RQFNpzKyuOBdwfHXIuEu9xNn73Rbv9aQzL8fFU6QqE0/B8t1essDlROgbiw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM4PR12MB6304.namprd12.prod.outlook.com (2603:10b6:8:a2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Thu, 6 Mar 2025 10:21:12 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8489.028; Thu, 6 Mar 2025
 10:21:12 +0000
Message-ID: <4bf496a0-4028-4dcc-a9f3-2004ef769d19@amd.com>
Date: Thu, 6 Mar 2025 15:51:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] drm/amdgpu/mes: update hqd masks when disable_kq is
 set
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
References: <20250305204721.1213836-1-alexander.deucher@amd.com>
 <20250305204721.1213836-6-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250305204721.1213836-6-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM4PR12MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f603c3-8ba0-48c6-fba5-08dd5c989e67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUc0UGROaFA3bnlJK2J1cytJU3oydzN2ZUhKZXVad0FSVUtXd1oxMktmNWxC?=
 =?utf-8?B?V1hhMUxyKzdxR1NveUlyOUQ3aWxCY0FCb0RwelkydjNoWkJYNVRPVUZNUldS?=
 =?utf-8?B?MkZTWDgxdzlDQUF6MlVnL3NqSjBHdXlzb3RyWnJuUHdRYUFicWpYM1NheTFL?=
 =?utf-8?B?Q1Z1Nk5qdkJZMFM2eUkrbCtXNERNclc3c2lqdEY0aGhHVm9oMW9ZVEtnUWNy?=
 =?utf-8?B?dEJ1Zkk3Y2MrU1EwZDdRVHZ4bWU5VG9vMmdzeXJsRXV0ZXNseWlwaWZBSTNB?=
 =?utf-8?B?QUN4TzFCYlo2NEErUDh3dzNZTDlEaUNmWkFxcmhyV1o5VWJIV0dQc3Q2RHRr?=
 =?utf-8?B?NTlsOXIyN0pES0IxcXYvdWI0UGZra05NV0x0N3RqV2pTWFVxbzVQKys1azl4?=
 =?utf-8?B?YVVoZUE2L293RTNTQlVMampKaFovSmZHVTBpdVJEenBVZUJsalpOYzN0S2RQ?=
 =?utf-8?B?NkhxWDdhVzFtREsxTVovRDZFVWIzeURpVFFWYk92SjZ6QVRaa0lsOUFuWFps?=
 =?utf-8?B?RUhja082R2s5S3BIR1NIdThkUWNQU2tjaGZOZ2F1TENsVGVKK28xTHQ3enRP?=
 =?utf-8?B?b0lqdlQ0bGE0WXVibHhRajFDcXJuM2VtU0NvK0JaTGNpQjJRN3Ayc3dqcFVY?=
 =?utf-8?B?bkVVbTgxTXBGdm5KcXhnQldhcC9lU293NitSbFc3b0ErNTIvVHBpdzJVOGtL?=
 =?utf-8?B?eExBaVArRmVWcjN6OXZJYnRpUHYxeVh1bmtvYkdIYzVMWjJ3T0g0My96WGJk?=
 =?utf-8?B?YjgzOU8valB4VEpMM1E3RXVIZC9xRTFZZ3ZMb0dUSk5yejdYZkYrWjNidVY5?=
 =?utf-8?B?ek5FL3dTa3FjNFZiS0NydDZaTkdIVzVRWEo4UGl6cVJOdy9GZmtEVWdyRGwv?=
 =?utf-8?B?Ty9kOTNKc2lUVW0zSThvQm4xZ0kwMkJmMHhQUGxsWWZKS09kMmd2Z1hwenY4?=
 =?utf-8?B?VHRSM3hkdEw1ZFpubUdIak1ZYkJWMk82WnJWLzFCaml5bWJVWi9Qc2Y2SXlQ?=
 =?utf-8?B?VVI3V2pRci9oNEpCeG9LQzk5K3F6Qzh1ak1RZGFvWUNXR3N4UDV1VmJjZWQv?=
 =?utf-8?B?a1JscjJlbk5HM3RyY05OSURWVzdFT3BJOUMycWtQaDFJbzJHMjRFMHp1NVkx?=
 =?utf-8?B?d3Jwa05XSVV4ODRhL2N4eWRKOC9NMFY2R0hnQXdJeUx0bWJwd0QwdXBRdHB4?=
 =?utf-8?B?UHFBOEtEbHZCNWNKUGcvQm1BMnJsUStnUk1VbVdLZFFNSmRlRlpURDFBdGlz?=
 =?utf-8?B?VURkczVCRVQrU1JkUFUxZ3E5RDIwWmZFVHRYUk5DM1drQVR1dEhWN1dkTndE?=
 =?utf-8?B?V1VlOHYyQkdXRHRDY09lbi91SWVueFVXUHdubmMzWkRNaTdqNGlZM1dYV0FR?=
 =?utf-8?B?YXhYcjhNRVZDRlZpS2pKRGhvam9SSDNVN0l1c3hXbkNheGRyS2srODhYRmRF?=
 =?utf-8?B?dHcwWEE5ODRYM0VwOThjam83Qy9aK1VqUGtBYzcwaE03NU9IQ21YbU90SGFM?=
 =?utf-8?B?UUZWMSt2cWNKWGdWbDlLRzZLTlJpcTVNSU5oZTFDaENSczN2bGdUa2M2Wit5?=
 =?utf-8?B?UUcxRU55Y3JJQ2wwbkFCKzhQMVI4NHZSWmZvYXV3Qnhmem03REs0cFV3dFc0?=
 =?utf-8?B?dlBPL3ZjK1Yyc2UrZFdvZUtBZm84em1PR0JoZ0tOZ1ZDMFoxYzFmbS9RcFY5?=
 =?utf-8?B?cnBSek1ERktBRytUVUNBQlBMQ0N6T3pFY3kwNE43dm92ZDdYVHhZTVZPUS8z?=
 =?utf-8?B?amJWUlZrMm9QbGgvZmMvNnZtWmRFb2lSRVZLS29DQXFFakRUMStYNUVjYWlO?=
 =?utf-8?B?ZUpiUUFkTnpDaFFvZWgxaXA3NTJOSWFlVHAzT04waXhNeVJXZE5qblp0dTl1?=
 =?utf-8?Q?mG5ZrHmLpU4QL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEFQYm9sZnRrU2g2U2Ryb0RTVm1mRkpNR2IyYnVJajNkS3BQVHZEK3N3WVhR?=
 =?utf-8?B?TytpUDFoeE1oYzIwdGpiMFdZSTQvMkdyTTB5Nm1EVVZud0RWRHdJSXdENHVi?=
 =?utf-8?B?Rk13c1ZVWUxRTFViTlpxOWpScHNhM1lvRVVEZ3JJSS9CVlJaWHlhOElBOHZJ?=
 =?utf-8?B?NEIvczE3ZE5wZXBZVThIVjZKcHdMcEJtVVNLaVVUcXBaaDRFWVNLYkxYcXBv?=
 =?utf-8?B?SzB1b0Z6cGpYazJHSnc2eXl2TmdnRmR1Sk9FT1M3VTlJalJ6NEZsOVVkMjYx?=
 =?utf-8?B?N1FZajAzRVZKYUMxcUl1c003dU1tcURRdWNjR3NFQW9ncjQ0eHVZcVB5OGdX?=
 =?utf-8?B?MkhCUHRZNjFQcEdCSFQyR1Bwb2pTRnBrOEFaOWN4VFJ6Z1hnYWE0U3ZrQjho?=
 =?utf-8?B?dW1FakRhdS9kMTIrSU5JYm1JTTN5SWhFT1hNRWhkcWFkREt1eHN6M3IvUmZn?=
 =?utf-8?B?MjgxaVpET29VN0VYSDM2Ym5vUUpPd0ljUEVqZTlIMzV4b3NWWUNaZmhTbmRG?=
 =?utf-8?B?amZTcEhzR1grVEVURDdTbU9wMWVtZlZVMEVpeTIrZUJpZ294QmZ2REZxWjVo?=
 =?utf-8?B?K1Y4TlNOSXBQa3M2NE5KSm5DeUd4VlB5bi82WUZXa2lUa0tSQmRwd21xSkZU?=
 =?utf-8?B?NmlTclphMzBqZFFyMUFkVnlReGFRUW9vV0tTQXJveGFzeTl5YlliR0toTG4x?=
 =?utf-8?B?YXRybGdlSE5WVll1NFB6Y2xJUWY2ZEZoMkdPT3JFOGllRHpCYW1Vczk5SGhn?=
 =?utf-8?B?R0pYbHUrc2VyU1lRL1g0Vm1wOVIzRk9lYmNwNDY2cVBHS0NuSnR4YlBEYVJj?=
 =?utf-8?B?TTV4U09oVHBtcWgwSW52UEVaRVkzS01nb3dlWVg4RitZamdPeDhwS1E4aVlo?=
 =?utf-8?B?aXk0TlNQTFUyLzBxSk5uTXQxT1FoUnFhUEJ5KzNlaEZuN2dDNzcyVW13bDRB?=
 =?utf-8?B?Z3NyVG55V09UcllET2thdVBJTW56SUtKL0N5WVl6UE9YZFg4aEdhbG0yTVRO?=
 =?utf-8?B?Vms0VVdmcjJQdHhOTWg3dTRJZllRcGozU2VnNVZQdVF1STZ0Y0NtL1lhU2xN?=
 =?utf-8?B?Q2hxWERncUcxL1F3elFnNGRNbDNoditsRkJkL3B6akQzMWZEbXZoSENFSkNn?=
 =?utf-8?B?UXUzRm52Sm9qNFVmWTBLWm1CZUd1TE5qZHM2bEt6cUJmQ3hNb3J6VE5udU44?=
 =?utf-8?B?RVBmYXp4dXlSN2tCOVdBVHh5UDVDYnBaSlJFOTk3bDNIZmthVUh0NDBRQ0dG?=
 =?utf-8?B?ajZLSStDOVV4MWZZOXJmN242eGhHU1Z1a0xSWkdGcmZZZ29USnNndEtlV1Ix?=
 =?utf-8?B?OVppT2hSZEJVaWpyTmsvbnlKVWR2U24yV0RidzR6bVdGVVNzZElSWE1BWmFz?=
 =?utf-8?B?aE9hTEIvUmF0a3hpa0dJbG9sRFhDQnA3M1l2akpaT2RGbkVvZFBEeVhaY0hZ?=
 =?utf-8?B?b3l6YUNEcHBxZFFSZnVPR1k4clhzZUZ0Mmp1TE5xNDBiWTZRMkhHU0pRdXdh?=
 =?utf-8?B?Z2dpSDRJZ1lXMkV0VGNXeW9yS0VYdEhlZlhiZlpxanBETGZ0NnFPd1R4SS9D?=
 =?utf-8?B?S09CZkdpam5TMWhlZXZsTURjMER0bjlaeUN4QlV2RSswYmhHQ05DTmMxcVhI?=
 =?utf-8?B?S1Z1b042SFJqbkZlVVZsdUxqNUtZelFrTGxneXhGblBnVjRpY1lsMlpmOFJS?=
 =?utf-8?B?YVl5eEFKWEQwbFlYMFgxem9QNnVYOG4wR3RwQnNHVkk2cjJ2MzVDMDBwTzUx?=
 =?utf-8?B?MW5PUC9xSnJiejJOYW4xdVZja09yYUZkdTRYMWdPdlVKcGgrQS8rUUt3UnYr?=
 =?utf-8?B?RC9ZaEMzS0Y2bnQ4UUdOUHpveHRuUVFtS1hhV0JKeGs4RlZkVlErUnVJL2lQ?=
 =?utf-8?B?K3c5TUtpNDMzVnljTmpKdkZKdm52ZFBYbE1nUjNrQnpDYVdhelFkTWlPUXQy?=
 =?utf-8?B?U1FtczE2Z1J0bE1FT1B0Q2hFZnVvR0NLZlpYN1VoTjNkWXNhMnVVcEN2aCtV?=
 =?utf-8?B?dC9IbzhjK21ONHUrdHo4V2tOU2wrbGxuY2tPaWwvK2dvZVJMcEtrSUUwSWhT?=
 =?utf-8?B?ZDlDLzVGZWIxNXhYRTYwaXBLd1lTb0k0Y2I1VnpxQ1dtcWgxWXBVUWVWYis0?=
 =?utf-8?Q?6gvE3UKcq1sNDNfrj6SzRBRwQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f603c3-8ba0-48c6-fba5-08dd5c989e67
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 10:21:12.1900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwjAOldu0XQLguqyWSssmn/CjJgGiyVqlXUOXLnQFfrKSTj69QSPmG/lfhgBkQmpPQAyhZA0Xod7Z6GOltOz9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6304
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 3/6/2025 2:17 AM, Alex Deucher wrote:
> Make all resources available to user queues.
>
> Suggested-by: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index afc2ce344df52..71dce64a0ea32 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -157,14 +157,14 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>   				 * Set GFX pipe 0 queue 1-7 for MES scheduling
>   				 * mask = 1111 1110b
>   				 */
> -				adev->mes.gfx_hqd_mask[i] = 0xFE;
> +				adev->mes.gfx_hqd_mask[i] = adev->gfx.disable_kq ? 0xFF : 0xFE;
>   			else
>   				/*
>   				 * GFX pipe 0 queue 0 is being used by Kernel queue.
>   				 * Set GFX pipe 0 queue 1 for MES scheduling
>   				 * mask = 10b
>   				 */
> -				adev->mes.gfx_hqd_mask[i] = 0x2;
> +				adev->mes.gfx_hqd_mask[i] = adev->gfx.disable_kq ? 0x3 : 0x2;
>   		}
>   	}
>   
> @@ -172,7 +172,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>   		/* use only 1st MEC pipes */
>   		if (i >= adev->gfx.mec.num_pipe_per_mec)
>   			continue;
> -		adev->mes.compute_hqd_mask[i] = 0xc;
> +		adev->mes.compute_hqd_mask[i] = adev->gfx.disable_kq ? 0xF : 0xC;
>   	}
>   
>   	for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
