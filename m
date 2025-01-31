Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFCCC02190
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:55:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97E2A10E3AF;
	Fri, 31 Jan 2025 16:55:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uxA/50Dv";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9862B10E3AF
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:55:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIe9UksAMncZIl/dPJ6NJ8AhVG4PoCV+9Y0P+/mXWNxenHKdJV3FTQ4OAzhnutzh1RoI5N2Au8DBISORjknWUMuGViboZ8y0hcRbr/F0W03XVXvY0iQBOfA/AOsxl9pue6gLfRSgxCIioLstaJrlO2qjXVMKgp528VMcEtseJb7aIUwAxiKpEpuzipG5enoSUz9S5YgrWgiLZHYHY2jR8jnrUNfXLhHfUKmPCswnN0S7oXE+9q9Kc8c4C6Rl4OMNkR88o10eyQbq1tWVUlRUnlIwIZj7mzTvgOY7/NiyXKkF6IBgzcrJ9vyjTYY15OD0hdztt5HDm1PBaIxjpniBQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFjJkGUPeym7btEQJz6JSxn1/EMK9TW/qnKrCkKsGQ0=;
 b=E4u6zVFdStIg51wFHQ6tFoE+/ce12uKWJUt0U15QbN8Rxf1nAsDv3wz7FHZQmkcluo4h0oNDNrQ83wNCGd+4nGrvMxsbqwOEQ7G3umJp8zVOQF7tj+yqxIp47N2oHXswCfwDCafotW0ahswxsqtBh3rp9OfHn2F1OvQ3elCypMcI7DnZoBKx07JLloA3xcshcIuIoZ1xXzR33cfzu/djbimrrQqI4lMCPY7LVSNspO6r8pnBoA3WsG6oxPRzN53H/yMrFtmIJGVaclGNtXfM59SKrg+YKGDB6fyCm6CRLuwh7Fo/dKiEYTPkBi89ppx2ON/p7TI6RUPrAtl03HeUFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFjJkGUPeym7btEQJz6JSxn1/EMK9TW/qnKrCkKsGQ0=;
 b=uxA/50Dvrcl/UC2zU/8e6RBArUsitTjUQOiAsn33eGKeP57D1LQdrRer/pzeCdvX25oWVhTCY/v9j/D+JDsDwrjbu2msvRF/Rvc1EQQICB1szJyLMxe1muxKdT850FXxEqo2KtFeIIkE7JHkBwfpMOzVlc7xosFdi3dNTPFlF54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by SA3PR12MB7922.namprd12.prod.outlook.com (2603:10b6:806:314::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Fri, 31 Jan
 2025 16:55:39 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%6]) with mapi id 15.20.8398.020; Fri, 31 Jan 2025
 16:55:39 +0000
Message-ID: <d4bcf2db-bd16-4282-b086-27969225f27c@amd.com>
Date: Fri, 31 Jan 2025 22:25:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] drm/amdgpu: Add ring reset callback for JPEG4_0_3
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>
References: <20250131162321.563314-1-sathishkumar.sundararaju@amd.com>
 <20250131162321.563314-3-sathishkumar.sundararaju@amd.com>
 <8371968e-e270-490e-9454-b521edceef37@amd.com>
 <8b9995da-269c-4a96-b374-09e40e0df605@amd.com>
 <8a8f4581-0185-4180-89e6-aa4d01260cae@amd.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <8a8f4581-0185-4180-89e6-aa4d01260cae@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::29) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|SA3PR12MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: 22719d81-a1ea-469c-b87c-08dd42181754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clkzMEE5T0xLaVI4NWkzQnZDdms0R0lqcWFDQkgxTVd0aTlaTHprTEUyVjVX?=
 =?utf-8?B?ZVJHbm4yOTZ4eThycit4RXJBOE1tN05hTHVhTHNKVGxnVnJySmljQXdQWG4y?=
 =?utf-8?B?ZkZuTkJ5a0JvazdLUDZ1N3V5anNKNnBJcXNVYm1PM3BvZmZJL0Z0WS84eVMy?=
 =?utf-8?B?WkM1MkhzQTRwWEs1a3hRVjVoZlBEK1JvOGxZUkJXMWlhTk1nSWVJWGd6THZm?=
 =?utf-8?B?WkRYZFZHMlhPNyt6RG5xaVBCTWxGdk5FMm44cGN0alZpTzZ2MCtoOFBJd3Zk?=
 =?utf-8?B?MUE1bytJYVlkMUpZaXQ4UWM5a1JMcjhNY1hPUXhrVW5aNlBBMGthKzRtYnBq?=
 =?utf-8?B?WlNoZ3BOTWNmdjRHVHl1ZCs3NTBUOUJrbFh4eklEekJ5SEZva0grNDlSSGdB?=
 =?utf-8?B?dkMrN1BxWnR1MTJSUW1Wb3h5OVZNUUpsdVA5d3hteGxzUkpJMlJ5SkJCaGFn?=
 =?utf-8?B?MzNleW9Kc1NsK3dhaUcvbitXd1pqWFZLRmVFcVc3VFhsQmtBMDV6SHVZTFJV?=
 =?utf-8?B?SE1pdVp1MHAwMDVERDEyejVkRHpwWmFyY1NHVHBxVDgrQ2UyTlhlb096QXNZ?=
 =?utf-8?B?aURVcC91V2VIQ0cxbHdkenBkVUtHd3lrV2FRZTNNSWkzbnBKejFtRkJWcUNZ?=
 =?utf-8?B?Q1UybURzYzNFbTRnZ0JZcU1oSnRpRmZZSlBRK2txeXFMckZXTTdzZ0U5ang4?=
 =?utf-8?B?MHZWUDFwZUxyUGx0TEM4SEJOUWFqVWpnbHNadEFSUmg2aGtCdExHNk5TZHNl?=
 =?utf-8?B?NjRpSnRKK2lhTUcyMGZ3QUp1UnB6VDlDdERGY0pDSWJBNzNkUnBDcWNidk1X?=
 =?utf-8?B?Zm9ZeEptRkpadEdPQk1PTnFmem9HS05rNFlXZ3VVTHUvdWs2TEI5ODBkY0Js?=
 =?utf-8?B?NUd6QVY3Tm5CY2p6TlZqaXcrZU5EN1lpUTg1QStBcHdLanJEVVhHUjBVdXlK?=
 =?utf-8?B?ckNDeTFwdVE5K3lBWmtoWGZHZ1RlaitkNDk1Rmo5R2NIeXd0YTlheDV4clBL?=
 =?utf-8?B?Q1FVNFNuYno5cDBQNGpzVm9Qc1I1bWtFMlMyVVhFMk9qM2g3eFJXQ2thTG96?=
 =?utf-8?B?d2VKQWxxNEVHRkZxaGZKako1ZEQxcWlUS21IRDJYclBHYVJQcVh1SlRsUERE?=
 =?utf-8?B?OWttektQOVJIOXhacWVhekdIUDd0cXgwTi8xbDJ5SCt3V1FMQmhMbEpoa3cr?=
 =?utf-8?B?bGt2enZSZlZXZzZKU1l0YU5UbEVERUIwZitMdDh4VDN1bnI0QTdMZ25nc3p5?=
 =?utf-8?B?cDV4dHNWREhhakVFSU9HcVpTL3gxQTNmbTdSZC9yQXRMQVRVSnJ4RUJyN3pH?=
 =?utf-8?B?NE01RDdqbjMxdUUwc1lDM2ZXYWl1U1laT2s3b0dKVlNsdHV1MllPT3BnR2dp?=
 =?utf-8?B?RjRHSkd3NW9Nb3BiVlJ6LzdJbW5aVzZTVTc3ejhQWEhpNzRrV005M1pVeDZ5?=
 =?utf-8?B?ZDNvZ0lwSVgyNncwbjdveDB0ZXJQZ3RCaWFOOFcrdktFZzFzWEhqaTNDUzBn?=
 =?utf-8?B?cmdoMjQyeklrS2lWaWltOU96WlhpZkFDYjBDM3p2Y2wvN29aZHpmY2tlNHRw?=
 =?utf-8?B?YjBvZzc2NnpyU00rcUlrQlg3cG1UZEpmUnJmRWlQWnN4UlpkUTB3ZUlnNVhi?=
 =?utf-8?B?T2Z2VzJGZmJOWHlJVkNZRU9Nd2VkenN5QnUvaU5kTW1tUGJLcWZHNzc5TGJs?=
 =?utf-8?B?SkY1blZiN0Y3d0tsR08xaFRPMDVOcC9oaWRXU09veUg5ZkhhT0tGMjRIaFBZ?=
 =?utf-8?B?aGh2TFRhRGhGNFBlY2NoTFdNNENPRU1GZ04vUVh4eDNLbDlFV3E3L2F5cS9L?=
 =?utf-8?B?dHcyQ05EVlExeWc5dUtMRUw4Y05yOUI3eE10SkhVMGJLY1doUmNEdEJoNm1h?=
 =?utf-8?Q?rwjdzyKGbVUb0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTFqSGNMMDVub3pKQzRsbi9sWmZlQ0NkS2EwRWp0UVJQQjNlZ2psZUhiZktx?=
 =?utf-8?B?UGN2NGpwOGhxNElOeUpQQnNNd2dSZ29OUDVZWEdmMWt0UGQ5Qjg0cXBWRGZu?=
 =?utf-8?B?bTNZS2d3MzB3K1lrRE8vMlo3TUhzay9XTmlPelNWM0ZaaHNYL1Y4bTh5Y0Qy?=
 =?utf-8?B?cEZ0SUpab1pQU3hCdC9YVVdIL2NJeGhzRmEwV0lJRUszdmJ4OTNyK2liMDRB?=
 =?utf-8?B?THFjaTJ3enQ1R2RSdWw5YVZNWEhJTlRSRXYwMFJuSUJGQTJuU3R6bjN0SDNL?=
 =?utf-8?B?QTdvRzFRa0FpMDlRQ0twMDV0QStGNjFhYlZWNVE4OWo0ZlJCRFd6VUdoZTg2?=
 =?utf-8?B?V0dzNU0rSVFFKzhKY0RJN1paR2diZGFJWUNCNWF1alhZRVQzdmNVVUdZeGJ4?=
 =?utf-8?B?VXF6WTZpTUFpMVV0WGxwcUVySkJaVzhmTXNMMXR6VkI1SE1pbndxeXVSaStn?=
 =?utf-8?B?dzFiNXRYRXk5dlkybEJsNDJ2UFhYRVljeEo3UytMeXJPb0NRdE5MTW8xaVdQ?=
 =?utf-8?B?VEtOZmwyNFJzTHhwTWR4NVBxaENvaWx1N2Y3cEVDQjRTamFmaCtMZURHTkFu?=
 =?utf-8?B?YytPRGd2UEQvRXBlKzVwOWw5T3RmUHdWejNscGxQa01vZUtmdWpyZ2xKUTQw?=
 =?utf-8?B?RjNYTkJEcUwyWmNRR0JmTmdHc3JtTUlNSXNkUHdkV3F3OXdhZ0dPNDdDMi92?=
 =?utf-8?B?YVE4OERlR1VzMnpoZHVsUkxMNldlUkt6YmpteG5YMFZXRjVESVJjNnpmSUFC?=
 =?utf-8?B?NzdzWWpsUGZyU2taV2FsRGFSY1o2M3lqY0ppSjNuMWQrQit3NHVwNU5TVldk?=
 =?utf-8?B?a05XNTIrZ3VoWmVud0FqUmZqd01ZTHlXVXJtZTJQc0lmZE92c09wdldJc2lZ?=
 =?utf-8?B?Z0tLMTBDeWFWQXJSdG05WTZ0M0FMajZ5RTBvVVZuS0FqRXdPUHFWOE9QUURG?=
 =?utf-8?B?VThxb0pKSDRoNGRWdnowTlFSVVFLVjNPNDh6dzRQTnNFdFJrTDRXYzVGSWlj?=
 =?utf-8?B?MkJQbTh5Zk1HZk95NUcvR1Z5ckwwVWxyQkNadVNqNUZrMnZhZzJpZHhJd1Nu?=
 =?utf-8?B?SjQ0MHhJVEd2ZlhrMjZ4QzRrbWZ1Ty9xSWJUU1UydUx5QW9admR3U212c2Jh?=
 =?utf-8?B?bFJrSHE3amQrdXZBcTJucVRseFUyb2U2N1NrSjhzdWZzaldxeW9wTlM0RnlT?=
 =?utf-8?B?YnYrNTZtbnExT2tHUllGRW1zRjA0T0hEWWcwSFpVMUxmZWlPb2NQZlJYQWhq?=
 =?utf-8?B?NmRtVW9OR2VPWk5CUFBGQjRaSXYxdzVRS2RKbld0NUY0UlIvNC9MTW9aaWxn?=
 =?utf-8?B?WFloOG5YRjB3VElQMHljcU4zclRTOVdmWGdneU1sQWhXcVhBc3l3UkZoVkRY?=
 =?utf-8?B?cm1YTWt0Vll2QXJORUNvNE5XTnM1WHkzOVRuY0hMSW5Zbm9obDE3amp1bTBN?=
 =?utf-8?B?RXBDYnU3Q0g4L1M1UjBCa2lVQjBaY25YR3l0eTVFbTdxTXpkeDkrV0Qzb1BX?=
 =?utf-8?B?WSs1Wk5NL3dZeHFUMWZseGZRS09zV2VNTCtzYTFMQy9ySTFja2FnMW9YL2M4?=
 =?utf-8?B?M0pZemZZY2MvZDlzQjR3blM2QnRoVjlLMGdINW90Uy95Q2ZSNkx0M0VaZnE3?=
 =?utf-8?B?SHg4bSsxZEl2cW5aaktjQVNpOXRiL3NLQ2tkOVpBY2gvNTBOdmt4a0IzaFlp?=
 =?utf-8?B?SDNiVVJQSWJSYW1HQmx1dDlVZk9abm0zOGJaOENldTJlWVgvSytDbVVBTXVF?=
 =?utf-8?B?QU9nS3kzUjBPMzhNMEFPS2lzY3RYWEkxUm1nUFpuN1JWN043TW5mZmFEZHJY?=
 =?utf-8?B?clZJS2habmhZZkJneGxzVDR1MGxOWnZ6MnV3WGRyMGJ2UmROSEtNYmM0eThq?=
 =?utf-8?B?S0s4LzIzTzc5MDVoNGpzN3dhNjVSNjQ3d1M1czVENFdFVnRwT1l0QXoyQUJG?=
 =?utf-8?B?RjJxWTZCZk13VkJBVG5JVnRyMjRqS2ZtOEU5Y3g1cHRtZk9Ha2JiaHRKRG9Q?=
 =?utf-8?B?S09OWW04bUNTTjQxaU9iaTNzcTdTaWNQN0gvcENGMmtxOTl1TnR2Umc3bVdE?=
 =?utf-8?B?aFZ0Z1NTRTZFNXlubU05WGpXMFNURWx2Y1NORTFWQW1FTzFTMlRHN2dvRVNx?=
 =?utf-8?Q?byQjtRZ07Jf3IRIymaz5cMhPK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22719d81-a1ea-469c-b87c-08dd42181754
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:55:39.7907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3crbHUZtac4ORYAsb4CRiY+K/+6/BpPaw40XMOt1pVV1nr32A6xAiC8O4dPcL1oi9/EimeeN6bDzSd3LJX8oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7922
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




On 1/31/2025 10:19 PM, Christian König wrote:
> Am 31.01.25 um 17:40 schrieb Sundararaju, Sathishkumar:
>> Hi Christian,
>>
>>
>> On 1/31/2025 9:56 PM, Christian König wrote:
>>> Am 31.01.25 um 17:23 schrieb Sathishkumar S:
>>>> Add ring reset function callback for JPEG4_0_3 to
>>>> recover from job timeouts without a full gpu reset.
>>>>
>>>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 60 
>>>> ++++++++++++++++++++++--
>>>>   1 file changed, 57 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>>> index be0b3b4c8690..62d8628dccc5 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>>> @@ -204,9 +204,7 @@ static int jpeg_v4_0_3_sw_init(struct 
>>>> amdgpu_ip_block *ip_block)
>>>>       if (r)
>>>>           return r;
>>>>   -    /* TODO: Add queue reset mask when FW fully supports it */
>>>> -    adev->jpeg.supported_reset =
>>>> - amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
>>>> +    adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_PIPE;
>>>>       r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>>>>       if (r)
>>>>           return r;
>>>> @@ -231,6 +229,7 @@ static int jpeg_v4_0_3_sw_fini(struct 
>>>> amdgpu_ip_block *ip_block)
>>>>           return r;
>>>>         amdgpu_jpeg_sysfs_reset_mask_fini(adev);
>>>> +
>>>>       r = amdgpu_jpeg_sw_fini(adev);
>>>>         return r;
>>>> @@ -1099,6 +1098,60 @@ static int 
>>>> jpeg_v4_0_3_process_interrupt(struct amdgpu_device *adev,
>>>>       return 0;
>>>>   }
>>>>   +static int jpeg_v4_0_3_wait_for_idle_on_inst(struct amdgpu_ring 
>>>> *ring)
>>>> +{
>>>> +    struct amdgpu_device *adev = ring->adev;
>>>> +    struct amdgpu_ring *r;
>>>> +    int ret, j;
>>>> +
>>>> +    for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>>>> +        r = &adev->jpeg.inst[ring->me].ring_dec[j];
>>>> +        r->sched.ready = false;
>>>> +    }
>>>> +    /* publish update */
>>>> +    smp_rmb();
>>>
>>> Using smp_rmb() to publish the update is 100% incorrect.
>>>
>>> What exactly are you trying to do?
>> On JPEG4_0_3, there are possibly multiple contexts submitting jobs to 
>> all cores on the affected instance,
>> so I am changing sched_ready to false and using smp_rmb() to publish 
>> to other cores which are trying to
>> submit on this instance , for them to read the updated change 
>> immediately and stop submission before
>> I wait for idle on this instance, which makes sure other good 
>> contexts of jpeg get a chance to be migrated
>> out to any available instance before reset starts, that way good jpeg 
>> contexts get a chance to continue
>> without issues while this instance is being reset and made ready to 
>> continue decoding after reset.
>
> Ok, completely NAK to this approach!
>
> First of all setting r->sched.ready to false is a completely no-go. I 
> can't remember how often I had to remove that nonsense.
>
> With the exception of the KIQ the back-ends should *never* touch that 
> stuff!
>
> Then the Linux kernel requires that ever use of smp_rmb() requires to 
> document the matching write memory barrier.
>
> Over all please completely remove that code all together. The wait for 
> idle function is *only* supposed to wait for the HW to become idle and 
> nothing else.

Okay Christian, Thank you for explaining , I will remove this.

Regards,
Sathish
>
> Regards,
> Christian.
>
>>
>> Regards,
>> Sathish
>>>
>>> Regards,
>>> Christian.
>>>
>>>
>>>> +    for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>>>> +        r = &adev->jpeg.inst[ring->me].ring_dec[j];
>>>> +        if (r->pipe == j)
>>>> +            continue;
>>>> +        ret = SOC15_WAIT_ON_RREG_OFFSET(JPEG, GET_INST(JPEG, 
>>>> ring->me),
>>>> +                        regUVD_JRBC0_UVD_JRBC_STATUS,
>>>> +                        jpeg_v4_0_3_core_reg_offset(j),
>>>> + UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
>>>> + UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
>>>> +        if (ret)
>>>> +            return ret;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, 
>>>> unsigned int vmid)
>>>> +{
>>>> +    struct amdgpu_device *adev = ring->adev;
>>>> +    struct amdgpu_ring *r;
>>>> +    int ret, j;
>>>> +
>>>> +    if (amdgpu_sriov_vf(adev))
>>>> +        return -EINVAL;
>>>> +
>>>> +    jpeg_v4_0_3_wait_for_idle_on_inst(ring);
>>>> +    jpeg_v4_0_3_stop_inst(ring->adev, ring->me);
>>>> +    jpeg_v4_0_3_start_inst(ring->adev, ring->me);
>>>> +    for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>>>> +        r = &adev->jpeg.inst[ring->me].ring_dec[j];
>>>> +        jpeg_v4_0_3_start_jrbc(r);
>>>> +        ret = amdgpu_ring_test_helper(r);
>>>> +        if (ret)
>>>> +            return ret;
>>>> +        r->sched.ready = true;
>>>> +    }
>>>> +    /* publish update */
>>>> +    smp_rmb();
>>>> +    dev_info(adev->dev, "Reset on %s succeeded\n", ring->sched.name);
>>>> +    return 0;
>>>> +}
>>>> +
>>>>   static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
>>>>       .name = "jpeg_v4_0_3",
>>>>       .early_init = jpeg_v4_0_3_early_init,
>>>> @@ -1145,6 +1198,7 @@ static const struct amdgpu_ring_funcs 
>>>> jpeg_v4_0_3_dec_ring_vm_funcs = {
>>>>       .emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
>>>>       .emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
>>>>       .emit_reg_write_reg_wait = 
>>>> amdgpu_ring_emit_reg_write_reg_wait_helper,
>>>> +    .reset = jpeg_v4_0_3_ring_reset,
>>>>   };
>>>>     static void jpeg_v4_0_3_set_dec_ring_funcs(struct amdgpu_device 
>>>> *adev)
>>>
>>
>

