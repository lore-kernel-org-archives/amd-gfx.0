Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BA6C10F1A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 19:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF9CD10F1DF;
	Thu,  9 May 2024 19:55:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wdXVbQhp";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1A1A10F1F8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 19:55:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EK5MdYqg0bd1zx0C22jKzLdZI3h2lTXgxXSQ4SIClA0pKJexfJ8bMcaTkztj79RW54aWePDsXf8x63EtQFSPs02bJPcWYWzRqDejDhP3GMFirfnMOc8iuo6bJJgbx51lqXm1waAN0nqFGkwiXlugYDbacVwkvFollksWku4tkZXIoyOGvZdZ/SQh5jJVblqch/leIRRxw29U8SHVJ+2vbxyRGGr41qO/ghyuiKh4VMj+3mN0Sf6yhRQn9gqOTUuc9BfzcA5q8/RYSPcpGD7kOiwAQ1vsXNYd+J62637TsKqFhKKsiQp64eCyKsBiupQ/x08/s8UFNKNPzsGesWypbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKxZyUhx1wIQKD7xvbdG7aTie/eyogwjVS96kIcwKoo=;
 b=dCpZ5++OwN2RXnRAkuDic7QR/QeRqgmR+ZYpgBl+C9ixPrFgmeCHvpd+AtzS8oc3toZJDx4qrUwWmoT7gxLEidhE5Gq5oW4PY86O/dbWov5zA7F0ukfTM7UQN+YSwpWEV2xFzL6csQ3a50YDJEu2F6Z1e2H6RIYirawCxmY/0znPbhfFJJTxuHzD3z+IZ/t0Z/N1rcWWAb4ZukpZg5QFmfVrDPNrLrPRc8xECfdLozorzSEt0dtBzJ38mAmhC45C+FcHjEsq4mh43Dz0Kg0OCsjY32tVY+Lq+pEonHOFQ9dWZZ/Khj3AB7I9Xrq4zLnYRQg2lF9RJV1z4TC14MFD7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKxZyUhx1wIQKD7xvbdG7aTie/eyogwjVS96kIcwKoo=;
 b=wdXVbQhpyT2vG8AheQSn2tbQwxMvoBax98o/x+ynpvcD5Ode5COjc66hnxoIy2IslHo2m6RRV0UW9+ANC7YU794inGVJQvQGENPYf/YL2Qi9TwgMsYoOtyQIBL+kD42G+f2VNUaDtaXHpqJqdkIJg2BNNj0x6HLzBoaHpGHZjTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.42; Thu, 9 May 2024 19:55:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 19:55:39 +0000
Message-ID: <52ea8322-a1a0-4799-a79e-876395123aa6@amd.com>
Date: Thu, 9 May 2024 14:55:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/amd/amdgpu: Add ISP support to amdgpu_discovery
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, mlimonci@amd.com, benjamin.chan@amd.com,
 king.li@amd.com, bin.du@amd.com
References: <20240509193531.129092-1-pratap.nirujogi@amd.com>
 <20240509193531.129092-2-pratap.nirujogi@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240509193531.129092-2-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0296.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: a4570764-09bd-437b-3f8e-08dc70620066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aExDNHJaTExza0xFTUNhZVNPb24rSzhocDNWNWxpV1dKK2dzREt3Y1dpT3dN?=
 =?utf-8?B?S0w2dGE0SDJzN053UXFDd3JnWmtjc0Q2MTF6SXB5ZW1FVEhXMCt3RFZZWFF5?=
 =?utf-8?B?NG9QaFZncDhtVTBwcTJJNEpuUjFLRzNXVFVuTVlFWGl0NVk5bm04d2dUNFRM?=
 =?utf-8?B?QW5EdkdqL0x2bWFRZWNSOXFaREN0SlVDd1l4bU9ibzg5aW40a0FuNGlkSkk1?=
 =?utf-8?B?ay9YbXBXKzZJSXgvVHNrZUNuTElvVm1kSm5qTUZpVlU5Sm13RlFROHVYcWtw?=
 =?utf-8?B?RVVYNTBhMU1WMkdpN3B0RVdIMDJkR2JDeWpjdS9ENnNsSFFJSDlDa0dGbEs1?=
 =?utf-8?B?QU42WkVTWUw2WFBqWWZ3ZWRzTnlqVmhlc1RYWTQwYzN0dUNtbkMzTDVtSjA5?=
 =?utf-8?B?c0pWMTc2TXVpYXVpU2lDZHpNcC9oejkwMFdBL3hvdzlUcUhuM3ZCb1VpS2V6?=
 =?utf-8?B?MHhJYzFTcGZZZUVpK2wrZEhwcFUrczNWVWdldENUTkNSY0gxakVFTnpsaHRU?=
 =?utf-8?B?b29CVlQvOXZDNjhZQ3UzZ29mYjBQS3E3SHhTYm5hWVc1SVV0YnAya3BlYU93?=
 =?utf-8?B?NllPcTZCeEZLMmplODl3RS83bUZwMEVWNmVVMlBVNUdmRmkxQlE2NjRGNkhI?=
 =?utf-8?B?M2FXT2Z1bWYya3lBUC9xZ2VPMTZLRXRZSkVpNVUxMUFnNmVTNlhpanR5ZWN4?=
 =?utf-8?B?OXRDOXg1QzFOZ0ExaFFSZEVESnNRbjYvcTNjeW5aeXJpZG9tUzRkYzZhaXh0?=
 =?utf-8?B?VldsTEk0R01oSVNvMTB6d2ZpVDFQcmxUM0J6OGN0bXZIUjRhcjk2MTQwMGZK?=
 =?utf-8?B?c3ZvdXgrNkFDakdxV1hpZHNHMEt0c2hVYmkzcXRoYkZiNzlGalpvS3k3OE1u?=
 =?utf-8?B?aDZ2b245RisrRURzS2ZHR3dUbC8rbXQ4TU5UNGJDTFp4R1oyalBERXVNc3NX?=
 =?utf-8?B?ejVyT0VVSjYxc1V1cXloR20wL3lSd200VEZaWk5LT04vM0VOMjhINGpZbkVO?=
 =?utf-8?B?dUVVRkNTYjRKNklsU05Nei9IODBLTWN3eEQyNWFPZldQQ21EQ0k3Yk0wQ1I1?=
 =?utf-8?B?cXRPV1h4QTJtOTFWZ2h3WkNPMnVvaHlvZkJkbk1ydm5pVjBKZEpHY0o4SnRo?=
 =?utf-8?B?UFdCQ0VBN2FGS2l5eVZ0dmE2VlVIOVl6NGxpUlBCSVp6bHFjYjhBR09NZlJH?=
 =?utf-8?B?b2hLR2xyZW9laTVhUHFHN2pRckc3SlVrOFYrdXo0RXcvMEVpNzdNbktvTDVN?=
 =?utf-8?B?bGl6ZXVSN20rWUE2TW9BcmtTdmFreTY2WW5hSENNN2VRM0M5T1lLTVJwR1d0?=
 =?utf-8?B?TlRFVDFHajlVN3F6UzBrZ2U1bEpyZFZFUWhjSU9nalpHWk9ua3FTM3NZYzFI?=
 =?utf-8?B?a2xLR3JCL0c0RnRNRkYrYzlEUWxYUm81ZXhnMFh3cm5KMnYrbFJNanZmRFZX?=
 =?utf-8?B?VkVMREYwZG5ieDUxTS93dUsyeWFFcXFUK3hXMkl0elczYUtOcHVETVdkZzVB?=
 =?utf-8?B?LzU1di9kRjcwYXE0bFIwU2JocWU1RlVyTHZhKzFaSVY5RkxXTEtaRW14NERR?=
 =?utf-8?B?Rk52MWNHeDI4RGtRa01iQ3hlQUhXMERON2Y2K1RsZnNmS05RNS82TFhOVldE?=
 =?utf-8?B?ejRTdFEvYU41a2tIcExEdXpNcjliNWpkT3RkVTFkdnlDOXM4dm9kVlZ0d3Qw?=
 =?utf-8?B?R2FNNm9CRXo5Wi9PQmdLNHdUaFFNNWd4NnpaeGJYM0FVS1o2K25RK01nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE1uUHFSRW0yNkYybFZCRHRvNDUyK0FCRmtXSjNKbE1UQmNnc2t0MWJtYVo5?=
 =?utf-8?B?YzR4dE0yUWxoWEZXLzU1YTZ5UElMY0plYTlCTnMycEtaM2JJT3JXQ2lHRXNH?=
 =?utf-8?B?VkZFKzR6ZkRuN3VOY3FqaDBiYlN6c29FUXhIU1hTSDlEcnh3VVlSRzZJSEJZ?=
 =?utf-8?B?RTlMaXh2K2xrMnBWVjZZVFpkUUhmZHVMUTV1ZEYybVdSd1UzdFJreDlmOTBC?=
 =?utf-8?B?eDJFVXVQeHFJYk9wZDlob01TeHVQRjBhdVd5SEpFWEh4MDFxZFVqV1JMY3FT?=
 =?utf-8?B?Y0RSbXVpTTF4ZVVScUVQdCtnMjdpQi9SSldPR2Jaa1FianJQYklNZGpzZThX?=
 =?utf-8?B?cHlYMmtzV3h4S1N2K1l1b2wyY0Y3Wld3aGZoU1Y4UU1BSmE5bTFRd01YMlZi?=
 =?utf-8?B?ZG9KU1M0d05kMDN5WGxrVTdXbzNBZ290b0YvOGZndjNrWXFhQVRNelI2aWl3?=
 =?utf-8?B?ak55eCtESkVRdW4wOTBuaCtoRHlVaVNEMGJnQ0tlTzBDUmNiS09CZ3FSN1Zw?=
 =?utf-8?B?bWlvMThaNVlrdzZPTXBnUlRsOHo4YURDODFrWDY4QWlVeWdBSHZkSEZTbEpH?=
 =?utf-8?B?MzlTbk9NOUJHN3ZHeEZEb2tjL2hDZUZmQktJa0UwRGwyRTlGN0JUSlgvTXM2?=
 =?utf-8?B?L01mbGhwZEhMUUhMV1pvdEliVlZxUXRoYm1WRUJ3cW1ON2VDayt5RkxmN1Ns?=
 =?utf-8?B?N1h0cFZ0QTZBYlZXMjMrWkN3WmM3Zm4vQURzckZ2MTRtdVNjVVQ5enNpWDZY?=
 =?utf-8?B?eVFMR1JvRWJkaG1mVkVRbFduNFJlQ21tYVpmYnczWlpmWlVFYm5DSnNuT3No?=
 =?utf-8?B?NjdtMUdKUHN1cHRPR0lDQk1NN01KaWZVWGtCV3JwaHBvbi9xWkpFMFduTXNw?=
 =?utf-8?B?VUVGWXpNYnIyc2ducWd0MDcxc1JDb254SndndFpnQWFwTmp5bHpDWHZkNmdr?=
 =?utf-8?B?K2NlenNuL2l0WmozZGpsOXFNb3dnRFpvQzFhTkRhR0FmR0JBWlB3RkJvcGRw?=
 =?utf-8?B?OXJ2WlR6czBVcHgzWVJYZE4wVmtheVZYdUtZTmY2VVFSR2haRGcvWkRrS2hR?=
 =?utf-8?B?OERpNjlkaWc4YVN2T2hwUzExSE5FbTcwNEhZWFNqUVZvN2RyMytFUEVEYlc2?=
 =?utf-8?B?MG1HbkhBUVVOZUNRV0pIaVFEQVdHTHpGVk5nMVZ2OTgvNUdaZWdQYXRkd3Z3?=
 =?utf-8?B?VVNBVitKV1p2dUtETVBod3BZSVZtNlFUQ1ZqR2taamUzcjNVa0FQUktvemc0?=
 =?utf-8?B?ZC9ubkx0VHNsQnovWEhENzEwWHQvdXp1L1BjaTNJd0tzb1hzdlNEODg1cGMz?=
 =?utf-8?B?Zndyc2tuU2JnQ3ZWSUMzSjIxSFB2OFB3czNTcFl3YnA3SHRheCtpOThmU0VG?=
 =?utf-8?B?cVJpVVFQamRiUlhTV1kwSUFWVVVaUERDTHYzeUt4RHp6N0l3ZUs3b3Zhd0tt?=
 =?utf-8?B?NFdMUTg1UjFseVAwZEg2SEYycnNXRnBGM3RHK1NycTFxUW03NHdrOGVUOTB3?=
 =?utf-8?B?WUVBNVd1TUlnVzRQazQvMVdvRE5OQXBlc3p2dVA5TVczVVN4NHZHWDVSNnRI?=
 =?utf-8?B?VWt6QnVmcE5KS21ibzJqYVJCQm03NFdsMzhFblRNRHgyOXJOaDdOOE92bGdP?=
 =?utf-8?B?NTl0bm1lcDJ5eVJHeWFtUlBWUG9ScTVvZmp2eHB2OEt1QXp4ZjRoZDFoOElw?=
 =?utf-8?B?TWtmVThhNmxTcFlZVG1wdTFGY3g2aTdsTFNIeFVGdkdUVWRMLzRBeWhKdVRh?=
 =?utf-8?B?ZmNLZ0gyVG5YQ3lpQzhqR2dtT3VjMnVqZ0ZET3FSZDQvNEJHSTZFcVZVNVlS?=
 =?utf-8?B?NjF2TGxYeVJzaHg3M3JWbi85eWl1bFRnblU4YjgrV3U4S0pMSGRpWFB6Mngw?=
 =?utf-8?B?N3VoZTRHK0VVOEdDeU41M21sVFp2VEZ6YzE2NUExT3ZWL0ZrTU9Fa2JrMjNv?=
 =?utf-8?B?VjdtdkJYYnl0b0xGZVM5d0ZCdU8yWDRiRlZVY1lnMExIaDNZakoyZXBqbEg2?=
 =?utf-8?B?a3QrbW9RbFlnWkJYc21HRUNieU45cWo0Qm9jYUg1NFYzbm9ydTNyVkJuRUZN?=
 =?utf-8?B?dUtZNUpPSEw1UGpRNk5DLzU4NXQ0LzQ0THJlbmc4TE55ZXlWYlB3SkdqQzk0?=
 =?utf-8?Q?FqNQa+zyqqgRFXL44lQ7LjnDY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4570764-09bd-437b-3f8e-08dc70620066
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 19:55:39.6819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DvB26kn/9cQTOQnk0LRPQl/6J2mMWmrqLHtUwfGZU3sansrDebYH6czZ6UWlxuQ6Lj2PYiafjJTeFX6WKyTAYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724
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

On 5/9/2024 14:35, Pratap Nirujogi wrote:
> ISP hw block is supported in some of the AMD GPU versions, add support
> to discover ISP IP in amdgpu_discovery.
> 
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
>   drivers/gpu/drm/amd/include/amd_shared.h      | 1 +
>   3 files changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 8bb8b414d511..eb60d28a3a13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -718,6 +718,7 @@ enum amd_hw_ip_block_type {
>   	XGMI_HWIP,
>   	DCI_HWIP,
>   	PCIE_HWIP,
> +	ISP_HWIP,
>   	MAX_HWIP
>   };
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index ece462f8a324..6586feab8c2c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -226,6 +226,7 @@ static int hw_id_map[MAX_HWIP] = {
>   	[DCI_HWIP]	= DCI_HWID,
>   	[PCIE_HWIP]	= PCIE_HWID,
>   	[VPE_HWIP]	= VPE_HWID,
> +	[ISP_HWIP]	= ISP_HWID,
>   };
>   
>   static int amdgpu_discovery_read_binary_from_sysmem(struct amdgpu_device *adev, uint8_t *binary)
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 36ee9d3d6d9c..8bc2134cdd6b 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -105,6 +105,7 @@ enum amd_ip_block_type {
>   	AMD_IP_BLOCK_TYPE_JPEG,
>   	AMD_IP_BLOCK_TYPE_VPE,
>   	AMD_IP_BLOCK_TYPE_UMSCH_MM,
> +	AMD_IP_BLOCK_TYPE_ISP,
>   	AMD_IP_BLOCK_TYPE_NUM,
>   };
>   

