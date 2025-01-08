Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6584AE77199
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 16:04:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 176D610E8ED;
	Wed,  8 Jan 2025 16:04:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xui4QvO+";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63CD110E8F1
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 16:04:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qe8FfHbxzNr2xDWMapBNhYU6zhJTCW4XcRtiSFahQtQPUqdP3EkAa0WSqzW2Itqm+zxiTf74tCUjKHnA7SIxCIYjURks6hyl8IDdmLTLVxnpAw+AG5gl4YGXR80CUB5AIekreGtDV+9sRraQ7Du0thxbAUL/YkMFvds58OzztQGyMf0gEZPq8wt76zaM2v4R2/6vsTCZLCeJtA+T7/0r4UBcAZK7BdG0BrVbccXAn4YU4sN0TnqZgEfk4LwQ9eCOUf01YfCPECMyW2SPl/9eruwkfeGW0J0sL3be2pU8unhu8Oyxt1m8QA5wSsbj1yAjz2Vgg8IXQxrkNynXI38btw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYcTEcOk2y/EA1s2Z7u20Prv0YzAUIUBgpwY2HWJCX8=;
 b=t0wWAmaol1nuyliqMHd8clqMMBrfKpmQcByv0Lb5mIUrZQVpXevjREBk5GZGIFao1IGPN0Xz7RGY3mL4GE4M0J4WGeKoznDwvsy4cYuFL8qobU1hZJk+TfYalfaPRaXPzPZ3tKLqZ9xNFsw56ZKcIIO3Tg+09RNo8M9QwYHX3xelpsKVHTB8AW3qezLkjeSZJEw0YtxZM2mqAtAZj6ZIr4h4O0XeNYQkfR9dHDZcBUtqWKzE/kQ6bQLFI/ANcfJGgDe9OYhyJebRuJeg6ESpZOYCjwrV3/hwUj57MJX9/djpBAUqXj5PpIW2b9WDYR7gMF6HGFyALooVeztMvgsbWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYcTEcOk2y/EA1s2Z7u20Prv0YzAUIUBgpwY2HWJCX8=;
 b=xui4QvO+fMo0iIfn4cgwifgq9TXFBPAyAj0e23rw2FsMxoAqbEmzrmSigfn/wuhhBoLoxzKxQB73RAfgs/DtWrDqUPRZVaNM3a48ifLMynKPYv/z9L0RAFLzWcBg9jkEHLqbouDX/36D9cNLt/6OeCUDJhvhtOacNyLQPb9hxvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15)
 by MW4PR12MB6683.namprd12.prod.outlook.com (2603:10b6:303:1e2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 16:04:43 +0000
Received: from CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754]) by CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754%6]) with mapi id 15.20.8293.000; Wed, 8 Jan 2025
 16:04:43 +0000
Message-ID: <1acf7529-0b54-4e34-bf6c-6c1005a39540@amd.com>
Date: Wed, 8 Jan 2025 10:04:41 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 2/6] drm/amdxcp: introduce new API amdgpu_xcp_drm_dev_free()
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, lijo.lazar@amd.com,
 Hawking.Zhang@amd.com, Jun.Ma2@amd.com, xiaogang.chen@amd.com,
 Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
References: <cover.1736325561.git.gerry@linux.alibaba.com>
 <c46d4c3bead7f62439eca5110de8afe4783a7418.1736325561.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <c46d4c3bead7f62439eca5110de8afe4783a7418.1736325561.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::11) To CY5PR12MB6108.namprd12.prod.outlook.com
 (2603:10b6:930:27::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6108:EE_|MW4PR12MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: e15427ba-b60f-4c6a-c381-08dd2ffe2a40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SW5qSkR4S2VSQk1MMncrbVAvdmNucDBrRW1icHFpSDl5NlVSZUh2VWN1b2lu?=
 =?utf-8?B?NjRNYXQ3K1NxREFEa0puYnlKWDNWcXRrZmprVGhqMzVranZQaTZOOWRSamlY?=
 =?utf-8?B?Z1RWVVBaeWFjZ3NBQTNaR2VyNEg2bWp4aThkejFlVXRTQXdldHBtVk1RZTVW?=
 =?utf-8?B?bktUOHVubGRSaUYvajlocEozZE5sL0t1WXlCZDRRNmNPRjBQTzRUMTBJTmUv?=
 =?utf-8?B?ZFZMQ2dWYXlLSk9GeW9CVnZKWnROaXRmYTg2VFJEMTNxaW8wUnV2QVBwZVBi?=
 =?utf-8?B?ejJmVGwzKzdKNWFYZWtNVmVYUHpjd2pNS0ZNOXNMT0k0SzdvMnY3a3A2b3RI?=
 =?utf-8?B?RjI4WDJJVnAxKzQ2cWo2cTl0RXF6WC95VHpWRUR6b3l5aFJZa3ZiOVI5MXYx?=
 =?utf-8?B?WWZmaU9JSWdHVXlBRW1nMVZZRHdtemJJVmxLOWpURERzZkdOTEIwcUZGSng1?=
 =?utf-8?B?TGxqNDNZTVF1Tk5GSU9XMXBQQXBIMm1UQmc3elFyNmt5N1pDUnUrRjI4YkEz?=
 =?utf-8?B?ZjNPRkUvRStWb2REUjV4a3RvaTA1N0ZSQ3Y0ZUZxMWFGMlhXdCtsKzhqQlNo?=
 =?utf-8?B?eER1YkE1VWR6a09BNmVpdGVZTkRyUG9INW1qTTVlV05FSkpUWitjYXo4enJo?=
 =?utf-8?B?emdZZjhydjZjL0s1VExHUnJhSnpURzQwWjdhamtPNUNOUUhpdVhwV1U5dlZU?=
 =?utf-8?B?YVdabXdzV29mQit5NEpZb3ZOK0ZHS0E5WGgxbkhhSmFNTDVrcGRpWWU5Rm9P?=
 =?utf-8?B?VXpwUU1VMGVVWTdhd1pWWnY5RitNM1lseGZ0WWZ4T3F0bFJvNFBkWTdkTG5K?=
 =?utf-8?B?akN6MFZVOVJBYUdpR29IQ2FiQ3JMa25rV2g3Q2x4dWNmakRlSWpOT2ZFUDIw?=
 =?utf-8?B?UGRab2JISjhDQ2JBY01Db2RkNVZad0ZtbGF0UmcwWXhzN1RJVUk3QVRsbmRl?=
 =?utf-8?B?d0hGWTk5S1FHUkt2T1o4VW9iUmtEcSthNFg1YzBNemxqdGZrK2dRQjBhU0Nu?=
 =?utf-8?B?Qk5sNktPVmxYU1ltUWFUSnNjOWpON3A0RVQ5U0czTVZqQ2M5bmV1QlptNDIv?=
 =?utf-8?B?L0gyekJBWmhyNTlsSXp0UDl5a2xLNFN5QkkwbzI2elVYQUVPTDlFMU9QVGxX?=
 =?utf-8?B?di9FVTBKeGo5TTZLUEl0Q08ydlJrTHdvL01oMjZGSitzMCs1SmtlaVNmSUlO?=
 =?utf-8?B?bE9TZ3FKalpmZjBsUHE4c3pXcEJ5USs3MjBDaElpNHRNYVZ2ZEFEdUJHdjVU?=
 =?utf-8?B?WmUxOWVFMzA2amVjYUx0aUdsQ0dzZlhpTTVmcWlVNzlQeitvRU9TZnVxNXFJ?=
 =?utf-8?B?c2lnSUxJS0FLR1paR0J6NzJXMFEwRGpmUWRqZnNBZzhia0F2UklHd1BpMklQ?=
 =?utf-8?B?OFBkNzBDZ2JWa3Vid3pibE9IUHFYcHczV25xaDE5Z0FMMVBwaWt0WG05WUc1?=
 =?utf-8?B?NzNTeC83dCtIV2pHMHhHb2dOQ2tXZ3ZGM1plVGpIc3N0Ym9yY3ovWEM1ZThz?=
 =?utf-8?B?TmZyOXRUNHB3ZVFaVkZyYTdqSTY1aVhxUjl3YzdlT2R0T3BZR3p5amN1K3k2?=
 =?utf-8?B?TG5LNVcxYUFieW9JYjd0SklkS1RVSVNXWXNudmQ4SERvT1hLd0s4cGhCb1RF?=
 =?utf-8?B?Rkd1SWl4RHd0aTlzQTBuellGcitpdm5IWHRkbHJ3NTVCMklReHR6b1Q1Qjhn?=
 =?utf-8?B?eUs4ZmVzcnc4byt5VHNad0dFUGdoNzVYc0VzRllKZWxTRW52V3MyRWxsZjhQ?=
 =?utf-8?B?eENSbW1veDM5N2h4TFF2dXo5Q09CaytidXdEQU9Qb1pzb0dDR3YzU3YzUUpz?=
 =?utf-8?B?Vk5VUGU3ejBrVmpGZC9CVnhQWlVRV3QyUGpJYWJLSmUyKzEySnNXTjdDaTRa?=
 =?utf-8?B?RXFlNWN2blluakF4VXkwWUs5T0x0bkJkanhteWtINW42cTFhZXRPTkNDejBx?=
 =?utf-8?Q?nYfuiNQwVgs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6108.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(921020)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXF2dlhNTFM1SWpOR3EwM2IxMmYzMmlDOHRCS1pUUUYzWkVEMXdYT3pDeENI?=
 =?utf-8?B?dVJiNkNzVXk2Ty9JN2JoWkpzNGwwT0lJNnVTKzVIQk9hdWJ1VnBPUmxocWkv?=
 =?utf-8?B?OEpERDRwWmZZSE1kUHRha0ltcVV0QWZ6bS9nS0pSSXFqYWJaNklYUTc5b093?=
 =?utf-8?B?ZG9TMndRcmRkRXdUTE9ZZDdXQSszc2dlVzZCL3RRZnNqbXZtd0FuZU1RTG44?=
 =?utf-8?B?NFJnejBxcWZoeTZub05WUDlSRmtQelY0M0JsY0lFOVlEcDkzekRMSjZRN0FG?=
 =?utf-8?B?MXlnajYwOVBOSlBhUmtGaUFJaTdIcGp2eDRKQm5ZNG5YelNHM08zUXpxcW1o?=
 =?utf-8?B?OHJTeExqUXpqRkNRV0N1NHdoT2dzaEtrb2dWQUVtZDdjU2lOK1JERUtFZ2I5?=
 =?utf-8?B?WWMveEk1ci9jMThmaVZjbURXYU1zd3FOa0NGUzJkSGEwcG5nTDN1aFk3cEI2?=
 =?utf-8?B?QUY3ajFncWFFQWViUVFTQUJtaEcvWVRwbVdJRFhlQ3gzZEdFVWdMNmYzSy9M?=
 =?utf-8?B?THh5REZLTVVHYXJBZTJCZE9UajBrTFRLZE5yOXhOTjFxT3pCd0wzZlMwVmxu?=
 =?utf-8?B?RnFwNlFKak0rQWk5OG1JbDF3RFl2UzhvR1grYW1hSjdMZFRXN0hYU3BBVUVO?=
 =?utf-8?B?VEJvcmJNL2RPeUNEWjQ3ZGxTZzI2dlBzNU9oVnFIRFhDTlBKMDdRcTRqMUY3?=
 =?utf-8?B?M2V5RTc0Vit6RFRPZ1BHY0lMTXB2anVlY05CbzhPaE9aR3ZqNEo4UkFDaW95?=
 =?utf-8?B?cVBXRXJ3emNjR0xJajhDSHN6cTBqQVBjU3l5VWRIQlFqUXI4OXYvMEVsS1Aw?=
 =?utf-8?B?Witoakhzd2I5RnZGck9RUUdwWVVYT3Nwek5hRHJJdWVJTjFGR1NiS05mdkQ4?=
 =?utf-8?B?bG5DRVA3UFpCMWV3YjBtQ0RLVWovQTRhSmpKd1AvaE13YkpyanRwRVhrZElU?=
 =?utf-8?B?WjRIckRBeXRGdi9uNjE2dDdLa2pSdzBrWGNkdWFOMU41ZlQ3TGhvYjRuL2RO?=
 =?utf-8?B?akhVQjZDRTdhc2pqNE1UUGw1QXdhNkR3bjh3akJyU29UendRMGpBaVMvVS9p?=
 =?utf-8?B?azh6WTFRSnJwSEo0cUgyeE9UZ2MzeVRZRHhvSjVuZmJpOTlyL2gzMk0rYWxF?=
 =?utf-8?B?bzNjbGw3TXd6Vlh1OGpERUg1OTJGNEVTNG1EMThQNWRhWkVWc0VxUy82em9x?=
 =?utf-8?B?Mmc5TnBXbGhrb0tvVFRNaEE2NURqTTJmQXF2L0I5QlFaakpaZm9pZDJlYSt0?=
 =?utf-8?B?bzYrZkdHMVM0MU1qbTV6WXhUMHlaVHpsUlpHZnhRTVBaeVN4eC9Vd2NjZUtF?=
 =?utf-8?B?SU1UdGpyMmhLeVNRdlNLUit4MkJIODRFTmFicnR4WUxITVNVQ1pSWU9GcDkr?=
 =?utf-8?B?WWE1c0ZjVjcvNGhNVkc4dEtlVC82eldSOUhaNGlZRzN0a3Y1TGpibFIzdVNn?=
 =?utf-8?B?WStRbXRXLzlVaTRlUFhMVmRnanBBcjlBa05jaitkeVZUM0dHRDZjWXBhOXpY?=
 =?utf-8?B?NFRMVGVzQjYwb0ZIOGYwdm1Fb2k0T3pLVmhyQjU5a0xRcmNKMWlkbE1MS1Iy?=
 =?utf-8?B?RzltWnpwd0c0Z2U3YWt3TTEyR2tzRnJHMGNhQk5GeCtLUGc0NGh6Tk15Y3BZ?=
 =?utf-8?B?T0hnZUpGOVgrZDJVTGlPdU96d1MrQXRzNEo3SFRHTVhRU0xGYnRtTVpnZUZX?=
 =?utf-8?B?NjlVZUg0anp0YjRxYi9rcUh0TnpFSTVCVHo5MWZTSW5kUW9EMzN3OFNlV0xX?=
 =?utf-8?B?TE1pSWo4YXpCRnNTQXpKNGc3QjlmR3h0SzZtbEJDbmNrbS9sOVV6UXlFQkxy?=
 =?utf-8?B?aGt5YnUyVndiNXdpckY5aVcraHdRNC9yUWRjQUlpZ1hwdk5maU1mL3NCWGFr?=
 =?utf-8?B?cXpuYjhGbmhUcGpUZ0RsZ054Tnlrd1liSDlOVHg2MTgva0lOWXpwSE5jVUtw?=
 =?utf-8?B?Wi9sbnhnV3FuUjJDMjN3dmhPWmc3VDFpbnVHbjBXK1FKV002bTRVN1Ixcis0?=
 =?utf-8?B?TFp5c2hudGhmOVVtK25LZlhFNTNEcXduajdUYVRnaWdndlNOaDA5Q0pyT3d4?=
 =?utf-8?B?QWhwd3FHTkt3UStMTHBZVmhyUmlqL2tveFFpWU9zdldsOFk3enNybWR1UHVM?=
 =?utf-8?Q?OzlrSZBI49MHnM3x3zHrJ2hj6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e15427ba-b60f-4c6a-c381-08dd2ffe2a40
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 16:04:43.5082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RN4+NucGuTLQTEKB9XTojxSjzxL85R28G093SHQ3H9DeSRw/O3ce6dFArw2t+VegiyMpAK+ja4ACaJGnx+e7pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6683
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

On 1/8/2025 02:56, Jiang Liu wrote:
> Introduce new interface amdgpu_xcp_drm_dev_free() to free a specific
> drm_device crreated by amdgpu_xcp_drm_dev_alloc(), which will be used
> to do error recovery.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>   drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 76 +++++++++++++++++----
>   drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
>   2 files changed, 63 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> index faed84172dd4..fc92b5fe1040 100644
> --- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> +++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> @@ -45,21 +45,32 @@ static const struct drm_driver amdgpu_xcp_driver = {
>   
>   static int8_t pdev_num;
>   static struct xcp_device *xcp_dev[MAX_XCP_PLATFORM_DEVICE];
> +static DEFINE_MUTEX(xcp_mutex);
>   
>   int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>   {
>   	struct platform_device *pdev;
>   	struct xcp_device *pxcp_dev;
>   	char dev_name[20];
> -	int ret;
> +	int ret, index;
>   
> -	if (pdev_num >= MAX_XCP_PLATFORM_DEVICE)
> -		return -ENODEV;
> +	mutex_lock(&xcp_mutex);

For "new" code what do you think about about using scoped guards like 
guard(mutex) instead of lock; goto label; unlock pattern?

I think it can generally keep the code cleaner, but you need to be 
careful because if you still need "other" goto cleanup patterns you can 
unintentionally break the compiled output.

> +	if (pdev_num >= MAX_XCP_PLATFORM_DEVICE) {
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}
> +
> +	for (index = 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
> +		if (!xcp_dev[index])
> +			break;
> +	}
>   
> -	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", pdev_num);
> +	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", index);
>   	pdev = platform_device_register_simple(dev_name, -1, NULL, 0);
> -	if (IS_ERR(pdev))
> -		return PTR_ERR(pdev);
> +	if (IS_ERR(pdev)) {
> +		ret = PTR_ERR(pdev);
> +		goto out_unregister;

Er, if you fail to register why would you unregister?  I think in this 
case with the current code you would 'goto out_unlock' instead.

The design pattern you might have been following was from platform 
drivers that do this, which is different:

platform_driver_register()
foo = platform_device_register_simple()
if (IS_ERR(foo))
	platform_driver_unregister()
return 0;

> +	}
>   
>   	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL)) {
>   		ret = -ENOMEM;
> @@ -72,10 +83,11 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>   		goto out_devres;
>   	}
>   
> -	xcp_dev[pdev_num] = pxcp_dev;
> -	xcp_dev[pdev_num]->pdev = pdev;
> +	xcp_dev[index] = pxcp_dev;
> +	xcp_dev[index]->pdev = pdev;
>   	*ddev = &pxcp_dev->drm;
>   	pdev_num++;
> +	mutex_unlock(&xcp_mutex);
>   
>   	return 0;
>   
> @@ -83,21 +95,57 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>   	devres_release_group(&pdev->dev, NULL);
>   out_unregister:
>   	platform_device_unregister(pdev);
> +out_unlock:
> +	mutex_unlock(&xcp_mutex);
>   
>   	return ret;
>   }
>   EXPORT_SYMBOL(amdgpu_xcp_drm_dev_alloc);
>   
> +static void amdgpu_xcp_drm_dev_destroy(int index)
> +{
> +	struct platform_device *pdev;
> +
> +	pdev = xcp_dev[index]->pdev;
> +	devres_release_group(&pdev->dev, NULL);
> +	platform_device_unregister(pdev);
> +	xcp_dev[index] = NULL;
> +	pdev_num--;
> +}
> +
> +void amdgpu_xcp_drm_dev_free(struct drm_device *ddev)
> +{
> +	int index;
> +	struct xcp_device *pxcp_dev;
> +
> +	if (ddev == NULL)
> +		return;
> +
> +	pxcp_dev = container_of(ddev, struct xcp_device, drm);
> +
> +	mutex_lock(&xcp_mutex);

I think this is a good case for a guard(mutex) instead.

> +	for (index = 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
> +		if (xcp_dev[index] == pxcp_dev) {
> +			amdgpu_xcp_drm_dev_destroy(index);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&xcp_mutex);
> +}
> +EXPORT_SYMBOL(amdgpu_xcp_drm_dev_free);
> +
>   void amdgpu_xcp_drv_release(void)
>   {
> -	for (--pdev_num; pdev_num >= 0; --pdev_num) {
> -		struct platform_device *pdev = xcp_dev[pdev_num]->pdev;
> +	int index;
>   
> -		devres_release_group(&pdev->dev, NULL);
> -		platform_device_unregister(pdev);
> -		xcp_dev[pdev_num] = NULL;
> +	mutex_lock(&xcp_mutex);

Another good case for guard(mutex)

> +	for (index = 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
> +		if (xcp_dev[index]) {
> +			amdgpu_xcp_drm_dev_destroy(index);
> +		}
>   	}
> -	pdev_num = 0;
> +	WARN_ON(pdev_num != 0);
> +	mutex_unlock(&xcp_mutex);
>   }
>   EXPORT_SYMBOL(amdgpu_xcp_drv_release);
>   
> diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> index c1c4b679bf95..580a1602c8e3 100644
> --- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> +++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> @@ -25,5 +25,6 @@
>   #define _AMDGPU_XCP_DRV_H_
>   
>   int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev);
> +void amdgpu_xcp_drm_dev_free(struct drm_device *ddev);
>   void amdgpu_xcp_drv_release(void);
>   #endif /* _AMDGPU_XCP_DRV_H_ */

