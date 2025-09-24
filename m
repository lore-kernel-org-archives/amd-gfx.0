Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182E0CAC5AE
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 21:43:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B78DF10E7F8;
	Wed, 24 Sep 2025 21:43:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yw/CzBk1";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0FD410E7F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 21:43:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zP4DmoYQGkKW3+h9bb8806tRmt3mTxntGrcE9EbN8QfHxbp58Lufbu7llchJ2RMgixC35WNJ63/KGDjVH2Kr3NeM0N0KAcwp+v73QmyMhr8w3cnaLNQxp+AibaqdlAxhyZS6s/5G8vV3cS7E5FTdA8Qj8aX+DClRecZjcdtKwDwILGH3TGAk1TgA0i2LRh3ZyMagfxTXwcNvTga9SAr8edqWAMcsltKWfY0QbVvOrbWYTTJPPQVfMNHK5oL2mW7LPrsd4aJiXoO6ZKKSr1od1VO9Ph9rRtdQHJQB14d0vPpMm43P3OKxSL3IccV3Mkt8fcZYMOXMzsvD1MRU7tmfQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o+LSZpIw+L98QHHnj02aUrN6bcFE2I0EQxcho/I6cE=;
 b=mN9m79tYz3SxDqHKlOVQIDvodUqQXOeQclLpRARmTnHih90goqFxnCitqiznrlDzkZl3YQAg5U4VW5Puo0D7HUIJV5Y3XJISENhiySTVKrWNYo1hMOo6AErts0MNkDm0I4HK/Zpi0bGq/UjPVx6ju9b7k/EyDV2uFXnOjkFUy+tD98xdob01k2AeUOQE673f1xWZBiJ99kmwvdBynmcNqpqOhZhMF0PQK49pnBuXNpk7TsttQ5GZyE9Ef9YJw5qMLPSirri2Er9BBZx2jyTX+j55lX5bQsQthkXqQVNUCe+60sBd6vDTeBsXllF8nju1khvxgfs5i+42YqOzNk0smw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o+LSZpIw+L98QHHnj02aUrN6bcFE2I0EQxcho/I6cE=;
 b=yw/CzBk1lp9IWEA+B6t2cl4JdVm4F9Djs76XYTUkCdNz/aViVvk8N9L5Sfh3V3JkxUMZ4APqV2sSlEKkM+HTHVIsRU4qJ5gkOrzomVTOKBvubth4rAukHc3K8V672SBvgqMyOcFjEXw5IeTwh8cJ1XLmGBA7CowokpMLaJRCY4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN7PPF862C85B20.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Wed, 24 Sep
 2025 21:43:08 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 21:43:07 +0000
Message-ID: <9bb94863-8e8d-4e0f-a018-7da249c230a0@amd.com>
Date: Wed, 24 Sep 2025 17:43:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 11/18] amdkfd: process pointer of a HIQ should be NULL
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250923072608.252345-1-lingshan.zhu@amd.com>
 <20250923072608.252345-12-lingshan.zhu@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20250923072608.252345-12-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0188.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::31) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BN7PPF862C85B20:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dfb6aaf-0734-414b-02e6-08ddfbb3594c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1EvSlVtREt4VEFsU1FUemVHTTVPSnhaUndNNm8wb1JrRWhsK0NhVFJZZ0pD?=
 =?utf-8?B?elFtWWdENXZCQmhsUEJNSTdEeUI5TERBS2R5bU9hQXFJZFA1QzY4SVFxWmJS?=
 =?utf-8?B?RWVPaVJzd1ByS2JieTNqbktOS1o3VUlCVlg3anZDTk5YYnU3NFh2NWoycUNK?=
 =?utf-8?B?UTNXS1JMdzJ4M1NTUFVGT25JNndSVDdLdEs4VXNHcWFHODNONVVHSkJuZVB6?=
 =?utf-8?B?bzBQNUNPMWpGcFdDOHArOTdPZUxEalhheTkvWXJ1cjRaNVBKM0NkVTVPSzVL?=
 =?utf-8?B?aXQ0K2wyNWVSMHF3YVh0OUs3SXVsQ1FWNS93TncrZWFhWTlVekZmTEwxVm1L?=
 =?utf-8?B?WTV4ZElCZ1NacEY1MlgyT2hOdk8vclFVR2VEK1kwaHpxWituTmEzQytseTVq?=
 =?utf-8?B?dDc5cE4vbUtqT3d4NkJmYi9FU3IyN3BTSGJEanE3OGxOQ1BvTGYrUk5FbW80?=
 =?utf-8?B?ZW5aRVhwQ2s2Y0NOWWs1WU8yblg3ZnJIZjl1K0phMVdXYXdPRGo2MCtqZDVD?=
 =?utf-8?B?c3d4U2lHeFdpSUNrTVJoMVJJTGJ6cEVvcGxYZkxuMzRBQTJvWW04OWJtL042?=
 =?utf-8?B?bk1GbUZSbWFYUlJqMlZibWpsajNueGpEQ1oxVGNtaWF3VnlaK2FUYkg0aHg4?=
 =?utf-8?B?T2M2N1oweGlOMHkyWGhHViswVjZ4aWxraTVWd1Nic3lkYWpwdnE5TjNGVVJh?=
 =?utf-8?B?OUY4SlcrekhBL0ZTUmkwRzBPcFhFRC9DNFhHVzBlQWZXZEpJYTRuVS9ZL1lh?=
 =?utf-8?B?eFkxWHFFY3h4UStDZnBKRGRFOTZqaW94U2tHVTc1ZGxseTFxMFR6dG5PR0N3?=
 =?utf-8?B?bzM1T2UrZnhlZ25mbUNIeE9scXhiaFMxSExJT2NhZ1BnL1VRWEdzV3ZjSEFR?=
 =?utf-8?B?a2xXdUpSaUl3S0Z0RzBxcnU2M2t4andpQldkc2RqbHlzVFhPRC9tYkdmYmNT?=
 =?utf-8?B?NDkrN2NBR2l1SUlFNXZGQUxTSWFiYWdmbG1TNUY0N2F3ZjI5RkNNZjZ4WVJ1?=
 =?utf-8?B?WjJudysreHFOYnloekJONmtPazNlSXVGeFZ6b0xRRDBVbzBLS0JMQndkTE1U?=
 =?utf-8?B?Z2J6K1pRVGk2TDkxZExvMVhzczFOUVVCZkV3dTZLVTNmSXhoY0RQZUJJakl0?=
 =?utf-8?B?dDdQWHY5VDdmUHlLV2N5Q0J4a3doT05YSW5kVHpMWFNWOWcwbTdkczJ5ZHlR?=
 =?utf-8?B?VUxxUi9JdC9yRVcyRktKRUg0T0JCZnpmeFAxVndVMFRPNytZdm9JSjBvVjUr?=
 =?utf-8?B?MFlUWTQvdlFwd3JhcUlHTklvbEpKNHY2Z2dMbVl1SkkveFJEdTA2aC84SUlm?=
 =?utf-8?B?cnlCcmd4T2FtRzlOMkx3V2hwY2xKSEYweUFOUXUzY0pxd1kvemZZOS9sN1Rw?=
 =?utf-8?B?OTNLNGhleEh5TEVpU0lsTXVzYlR1eHg5T3dacWRma2QzUDI1bmxjNXkzeFQ1?=
 =?utf-8?B?NUNKeElsU1NDclpRcE83VmxtL2NHUFFjSlMzRHJoQ0dVTGhvTTlyd25nd1NG?=
 =?utf-8?B?WlZWYWpteDBwV3hrL1M2RWFWY1BGRlhuV2NpUU9mUmp1dkQ0VTBEQk5lTXZ6?=
 =?utf-8?B?R0s5UVRlbEUzUklhU3M5VmVtMCtnZWozUWpjbXROdDBMWllkMTFqQXRNVXA3?=
 =?utf-8?B?b2VtdTc3eW5SdmUxdFAzU0ZudWo3OTI3MkwrcStKUXhWMldsb2tWRDhDdk45?=
 =?utf-8?B?TkxnRlZaWitHeWZBNUNBZVo0Z1RHTWliTG9TRHIrUm9ONEJ0eXp3clRxU0g1?=
 =?utf-8?B?ZjBUL0UxY1VJTCtsbjIydXo3SUFyM05xZ3UwbUFkbzFYVUR2ekxzQmw1N2Zz?=
 =?utf-8?B?MkJHQlRSZloxV2RFR1p6UnhNRGcxalJMWE1YOG5RR1FGdDRmR2JEVUlUVmM3?=
 =?utf-8?B?ekFHSWJSUkI2TDJEUVVNaG1xaUFHSXdWV2tlSDBBV29TeUJydTBPNVpEVVZ5?=
 =?utf-8?Q?FBwhOZhWRh0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjNHaU1tcDZqelR5SW45bUZYRG9hSHErdHlxZFp4WjlNODlEM3c4SzgycmdF?=
 =?utf-8?B?K1J2WmtpYi9ib3ZnVTZqeW1kUC9tWWFsSGtlV2QvNDNOOFZHUUZlbzhUQmU2?=
 =?utf-8?B?cTdhWmZ4ZWVZZWNSTXM0V284TUE2OHFpLzdnK2k5R0RKY2RMYVhFT01DMUto?=
 =?utf-8?B?YlQ1WXJLaVhDc2RTR1lHUnFZaUl6d0huV1Z0MzY3Wm05U3Y0OTR1cUtZdFFn?=
 =?utf-8?B?ekxEaFptenFLUFZITXllcVlGNFdOS1dLZkYrd2ZPalFvU3d3Skh5SlMwcFk1?=
 =?utf-8?B?dGt2NlNYd0dZM085bkVrWTdIZlJhcjZ4aHlnZlVnZ1hjaU8yWGhKRmQ1N1c2?=
 =?utf-8?B?eEoyUWdOSkpKYTR4M1MxL0FEcGR6dXRCaExqUVJXTDNpTGxkTkl6UEJ0YXBO?=
 =?utf-8?B?enBDTDNLM3hrY25iVGxVTGNlREthUUdxUlRkYkI1TXFYajRETG1EM0Y3MjR3?=
 =?utf-8?B?RExEclROVlpmMVowWjlFNWg1VlJmV29ZVTZjVTZRdkhjbmJTOFBSb1NTZEpv?=
 =?utf-8?B?dWRsSC9pY0ZBYVYrTndjWndLUzRVZHMrQW1HajVDK0lIbmpCcXFxM0ZmUnls?=
 =?utf-8?B?L0lsNUlIdjVNc3c0MFBGL1ZUcjJ0dGpPVEpYWWVTQXJxbjVaMEhkUW9aWjJC?=
 =?utf-8?B?N2dTVU8wMDRRNmd1d3ZmN2tpaVRySGJiQjZ0NldkdEd4MWlPbDl1TTVFK2E0?=
 =?utf-8?B?eWsva3hFajhBZEY3NS9DM2c3WE1KQTR1VjlJdlBBUVBoUTl5N09wVzNPVlNZ?=
 =?utf-8?B?ZTFpb0FyU1BDaW9DVFRtRmNkK3I3RHEzQVQzUzE3ZTJIMjNpeGNTZ0d1K08r?=
 =?utf-8?B?a0xoZThVNHNSdkphakZvYmhTb3JycDdNbCtMalNabUZHc2xMdVFQbmNMZzhw?=
 =?utf-8?B?RmJTZVJDcEsrczJyMmRIMURETUFaSHpKb1NMelFuaE1PTkNXWjFqZ1l4T3Bp?=
 =?utf-8?B?MjFEWkhFM0twNmh1dXFlS2dXdjYwL0E3UjA5ZFc1czdjUDRuVE9NQVY3bjNF?=
 =?utf-8?B?NXRma3BLNG1WTnBmLzJKREJtZXdTaDJ3NFlyeDRjRlBWTmd1Yjd3VUxGM0Ri?=
 =?utf-8?B?NFI0WWZaYXF6S0N6UTlTcGZCb2pnaUxMcU9paTNaNTBMZzgzczF3dFB1Q1ZX?=
 =?utf-8?B?eSsyLzRnVE5NaEZ6ZkN1SU1xUk5uZS9LK3IrbFNTUnRGV0grQm95RXFzVXpM?=
 =?utf-8?B?NVV2VDEycTFZekVhQ1VhUFI2Q2loSjIyRUlKTGVjWFp6cHVWT2xpdE5lUVlF?=
 =?utf-8?B?bUVkbXpHYW9Tc2tNVUxOLzI0a2trc1JPOXVRSGpiN0E3SGttRFp1dWd2L3pD?=
 =?utf-8?B?OUI2TUMyV2g3NEM1MzFYcWpQcndFejF3SUYyRHRWZjVjanVxbEF0YlpVWVpM?=
 =?utf-8?B?K1JLbEtibkFRRzhkMXNyZUdZdHAwMHBJMEladDdTTEgrWGs2TDJWcDBJVDgy?=
 =?utf-8?B?UVVZcGVQRlNpb0c2NFZXYkgvNHBBQ2trS0xDUHJJVzhpQ1l4NTlWS0k3bHhr?=
 =?utf-8?B?aktLU3QxcFd2WHduQzBXRzhWNVJkRngvbGEvOWxhYXdIMTBkQjJENERzd1hU?=
 =?utf-8?B?RER2LzVVNWNOc2JENVRTRHozellqV21iYWFmbEVXekxTYjJObmtQTFhNMEVP?=
 =?utf-8?B?YzA3WmUrUUV1QXRBM2tGU0dvT3AvRktxeDZkcDdUeXhZbi9maitUZ1kvbmkv?=
 =?utf-8?B?WWlBcFMyUHEzY2l1SytMejF6VmRyWFpyMFQxdHhZRFlGcHNnLzNlMzRIOXB2?=
 =?utf-8?B?TE01aU82RW4yVUV3dHNZQmFPQ2MrVnR1MHhlZzNMS0NJY2QzbVRFV1Y4RTZS?=
 =?utf-8?B?Y2tURVc3WlZKa21Ka1lTUzM0S0k1d29lOThWRnNCNlZqYW5CVzdDL1pSYnd3?=
 =?utf-8?B?K25UOXdQS2dmN2EzcDh5dHd1VWVHaTQ1dUNXR21nanJ3MUdVVzVGQWZkRVQr?=
 =?utf-8?B?MnlGenZQZDZLMlVLY1ZVZ0JjWDFvMjBWcGRRSllYalU4Y2ZGK2FmaThNNTB4?=
 =?utf-8?B?K1VhM1lCaUdXangyYy9HdnQwUkxDUWwwT1puU00rc1hLRnNpUU4yc3BnQ3hG?=
 =?utf-8?B?OTBKM2ZNRmdWRUNibjQzWDg3UmRKTFNlRkRhc1hWTEowYURqbWFnaUY4VThZ?=
 =?utf-8?Q?5fg/4JG5r8S80B8fc6PjrTwQk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dfb6aaf-0734-414b-02e6-08ddfbb3594c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 21:43:07.3904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECn96/GZCjb+f9r6QlcfL9INNEuem6Kyo1S34LMBZoowTVsTIErMWtEHpFOxrZFb+SigJJy2+JU+IGsMo8Y5gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF862C85B20
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

On 2025-09-23 03:26, Zhu Lingshan wrote:
> In kq_initialize, queue->process of a HIQ should
> be NULL as initialized, because it does not belong
> to any kfd_process.
>
> This commit decommisions the function kfd_get_process() because
> it can not locate a specific kfd_process among multiple
> contexts and not any code path calls it after this commit.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  1 -
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 -
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 18 ------------------
>   3 files changed, 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> index 4c7ab7a711be..0a4f8e8dd77e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> @@ -134,7 +134,6 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
>   		goto err_init_queue;
>   
>   	kq->queue->device = dev;
> -	kq->queue->process = kfd_get_process(current);
>   
>   	kq->queue->mqd_mem_obj = kq->mqd_mgr->allocate_mqd(kq->mqd_mgr->dev,
>   					&kq->queue->properties);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index a2f8b1c24fc3..e09c8bd3e138 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1049,7 +1049,6 @@ void kfd_process_destroy_wq(void);
>   void kfd_cleanup_processes(void);
>   struct kfd_process *kfd_create_process(struct task_struct *thread);
>   int kfd_create_process_sysfs(struct kfd_process *process);
> -struct kfd_process *kfd_get_process(const struct task_struct *task);
>   struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
>   						 struct kfd_process_device **pdd);
>   struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 8e498fd35b8c..0c3f0cc16bf4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -989,24 +989,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>   	return process;
>   }
>   
> -struct kfd_process *kfd_get_process(const struct task_struct *thread)
> -{
> -	struct kfd_process *process;
> -
> -	if (!thread->mm)
> -		return ERR_PTR(-EINVAL);
> -
> -	/* Only the pthreads threading model is supported. */
> -	if (thread->group_leader->mm != thread->mm)
> -		return ERR_PTR(-EINVAL);
> -
> -	process = find_process(thread, false);
> -	if (!process)
> -		return ERR_PTR(-EINVAL);
> -
> -	return process;
> -}
> -
>   static struct kfd_process *find_process_by_mm(const struct mm_struct *mm)
>   {
>   	struct kfd_process *process;
