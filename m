Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77199D1A631
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 14:06:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A41410E2C2;
	Fri,  9 Jan 2026 14:06:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w4Gop/6a";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012002.outbound.protection.outlook.com [40.107.209.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD82410E2C2
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 14:06:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9AYYGou6vzVU3lCEHU+64qNNcHeRLVYTusd5QychvZnz7okPN5g8Kod4GCMkBs7aOcpSpRGDh2jnDHXXW6lQ0D12l3/vzVZDS5/va1HvzPlIu+PSxTqnSrKzRPuY08fgbsh3fnUXt0C6WJlLCQgH9i8UTUb8Vjy3GcxXkBBOrm3ZoTXt0zhUEKvPFHDjMa8QP6wYhWP+7Kd3JFgBcNYWg8JLlEBDGEXgaldKx3JWwCyVW5qPfICGTunBzNTDwxmxiHS1kNwPTVO9iteNH8fHDsIyxVC5Vx49V8/J5xtXhzpZutcp3edSKO7aRuSz5o8q9s1RzEaP/T0YI+9TLx4yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LL8PrJcMOra2uSEENDtnGchQFzchkf9q5v4ezKVzPNU=;
 b=ODgesL6vznwyHkk/0s5fPnYm+6OmnAkxfH4fF8GZvoLTSfC3lr2QJteBPjF9PS/kPVrh4gnI9Q8RFg11UWqDXU6/gV8hrU07CGFiIeQU4H1RmFaQ8NKK3JSbEyNtLSqJ+dNOZR2ab8/s6z8l9WywaxtIeCkfvqJQxalnTftFz1CoY1d2cnbHUAOKQkt8gGewKxP2FAubJVDw2+Nz/vNdFRWsXJJJDGd4rwZHpFfNcrAVjQ06vQzm7SNL0xFyfNXFOevSeNi1tL75qiJwMW/Ld5WFXzhK85i6/KBeGT2cPHVf8s06enNJHQPoWBAYZMUn2LjcpVY+FZUn8YPQHeNpsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LL8PrJcMOra2uSEENDtnGchQFzchkf9q5v4ezKVzPNU=;
 b=w4Gop/6aorH6RgIEPLoq8vllHTVnG1ueei80cHPTr0RxYJuv6Z91kDZV3hHEldC/vnaGy8UnZlvc0l/BocYlwOJHSi8L99sxRa9UaZeNP/c3cu9OY90uoCQ1tr2tdzo9b+9TvyZ55E03ObhRKQT2Iuf78Q2bWKY17RWPqVjTEBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB7320.namprd12.prod.outlook.com (2603:10b6:806:2b7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 14:06:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 14:06:35 +0000
Message-ID: <72905485-200e-4660-bd52-f08cbceb68c5@amd.com>
Date: Fri, 9 Jan 2026 15:06:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/12] drm/amdgpu: Replace idr with xarray in
 amdgpu_bo_list
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20260109133314.88548-1-tvrtko.ursulin@igalia.com>
 <20260109133314.88548-11-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260109133314.88548-11-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR04CA0163.namprd04.prod.outlook.com
 (2603:10b6:408:eb::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: ec4efeec-4ac1-46a2-43b6-08de4f884c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z25ZS2wrQkRpNDNtb0hRU2Q5b3UzKy96RExwRWRPbDVBelRueFNpSGRFNERp?=
 =?utf-8?B?bitjdTI5ODJ3ZFh3UityUTEzSnFEY3lNY0ZTREc1ZHpEeDN3bzJDN2FneW4w?=
 =?utf-8?B?OEJrM1RUOFFGQmdlUCtjVXd4SmpjTmE1WjZoZEFIbWNTWXJuWjBYUHRxa0po?=
 =?utf-8?B?cTBMdlVPN2VzMWk2ektuQ0dyVnVIdEg5TXA1bkwxSTNPVEZwa29rTkJ3VVB6?=
 =?utf-8?B?aDZrai95dXJuNjByK2N3OE1hcmVqc2tPaVU3cWtVaXNva0dwUXBiOHhmdGRl?=
 =?utf-8?B?NjRnWG84WHZOTVg0dUR3aXpCNWhENEE3UHVLTndHOFJ2WmRZdVlaYW45VVQr?=
 =?utf-8?B?S2Y0aHMxMUFZOFRSU056TFlBdi9SMHF3ZVNDTWlNNjFmc1JOZ1JJcTIrSXpk?=
 =?utf-8?B?bjlpZ1JLbVJFakR6d3FSZlExYjZSMENpRW5lUlZBR2pjMlRBUFRrayt3NjM3?=
 =?utf-8?B?VEx3NUhuckdPUjJqckVZcm5oaUgrVWRpUUlyQjBnaEx6VWViakc2R3NFMWh3?=
 =?utf-8?B?SGt2RW1oQnNObFdSUXpaa3gxcTIxMG1EMDhrem1vOFZGS0pTTTVPS1VyRm5I?=
 =?utf-8?B?THpxeWdzbEMza3NlVWtNMUFDalo1djhXL2NuVkRXNmFXQ0loL2NjR0NWdlZM?=
 =?utf-8?B?eUVnMGc5K2lMSUNLNS9wdGcwZ3Vub3g0V01qS2dFYTVXaTlncVRkRGpVM05s?=
 =?utf-8?B?VTZrdCs1eXJMRDI1TTE5VXRwT0EzMjRjanFJTjMwNElhQ2NadTJGeVF3bzNQ?=
 =?utf-8?B?ZnpKYmU4L2tiMW5NWVlORlNVUG9PYy9qZ0VQYTMrZ0NiUGFDakhoTW1QWXJN?=
 =?utf-8?B?UFpUcUxNRXorS3lPOGxTU3hnZXB3aEt3RHloaE1nTnNxbFVNUmlLU09TOERz?=
 =?utf-8?B?eVdSVHE2U1puS3BIc0JjV29ac1ltUTV2dE5BTVRVTVlMR1ZTc2R3d1dhWXlv?=
 =?utf-8?B?WXdlNFFLOG9VMEVkY0R6WXE1c1pwbHg1VG1NMXM0bzgzRjgrM2VKR1dZb0Rj?=
 =?utf-8?B?QkxFbmwxN2Y5UVFTVXJyTDRKSHEraS9KZXNoL2h4NVlwNEFCTWFzSC85Qnla?=
 =?utf-8?B?ejRFeTJPWVcyemZWZjB2RlNORzM1YmNReGFPdHNCcFYwU1RxaklJajYzK0JY?=
 =?utf-8?B?c0kzRzI3emFvNzRRT0wvSnpwb0hHNTlwM2xkdEYyUk12WmM2U1hkWXZFMnJs?=
 =?utf-8?B?QWJVSzR6V25ubkxkL1BTWnJlNkZraWQ0eksyU0toWGw0Y3VpcC9tSVduYUIr?=
 =?utf-8?B?S0x0alNsK0RDaWhqeHMxM0J4aS8wZHRrOWwvK0c1MncrcWhLRzFaeXQ2MDk1?=
 =?utf-8?B?Q3RrNjFua3k1NktoQWx1czlqcmVFdDNnUG44OFBMY3FzNTZTMDlNN1FLUW5M?=
 =?utf-8?B?aEZOWEVVYVVyOG5sZlhUVVVtQUliVkErVkhTTmlsLzdHNGNKWDhkUU5zUytC?=
 =?utf-8?B?TUV3eTJYZ1dNNUQ0bXk0d2M2ZHp0c0FIYndsSWh2ZUNQZ1FiWno2R1AzU1cx?=
 =?utf-8?B?YnlFeWNkTDdyZWordFExdkZxKzlwVTJBa2VIWUplQUpRNGFRc0QzNm1vZzZX?=
 =?utf-8?B?cjlyQVRsbXlpYTJmc0xGVlUza3UwL3BKS3hRcEFVRFl1NCtGdzF0N0Q4L09W?=
 =?utf-8?B?RXFQcE8rWU4waFU2dnFjRVhjVjBpdUQxZnFNSDZaR096bGtIUWUxaVRJQnEw?=
 =?utf-8?B?SU14SXhhZDhlWkcxQ0pXRXF6TG9OcDhucFZKTnVFTWw2bkhQcWs5NnR1eVd2?=
 =?utf-8?B?V0M2ZEJ2bkNuV1R0cDhRNG9FQVZxVTI2bzY1djF0TVRaVlRudHhLVXRFS0p6?=
 =?utf-8?B?aEswa0p6OVNJN0E3aHZ0RTdHenkrWWY3Wmo3YnNMSGxWTm44MTZaZFJoTTVv?=
 =?utf-8?B?cUlCQUdEOUg2dWF0aEZ6Z1kxU0MxN2VHQ1ZEcnpzc2pibXZPWmRmNy9kVVRQ?=
 =?utf-8?Q?knfhPfmdc5m2IUxPPF6cB6ureZbbjFcu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amo3amo1RzR1dUxEWjZTaWUrY2pOVTJ1YTFlcll0SkZJUEdSM1lJNjg3TURy?=
 =?utf-8?B?cmkrY0k2ZGZ5ZVIxNTdyeTlKbHpacDM4REx1Y0pPaWRNdkJUZEMrTkIrZ1Bk?=
 =?utf-8?B?TU0vMW1QSmx3Y0haNmJmOXRDMVk0V1dkMDhDaUNzc0gwOHdLb1kxc3NFWTdQ?=
 =?utf-8?B?UjNkWWxrNFdvSXNxWVYza2pkRCtTSDN2YVQ1NFo3M3A0ZzhDYUcwbjNkblZP?=
 =?utf-8?B?dERRMlBib3ZYRC9uUWZhcTNwUDM2dG9DTU9zTXh5TENnQUg1bDRSTWtkSVJ0?=
 =?utf-8?B?U3lyNHEyMHZpMnBjQ0p6K2xCb3Y1VGF2L0N5WEp0SlhWdDBVcjdqcjNjVjR6?=
 =?utf-8?B?SmpCRmUwdTZRZ2x0WWkwZjkza24rMFVuSHh3R2VGOEdnL3BHemlYcDRWbzd1?=
 =?utf-8?B?TWZwa0laR1ZJdFd3U0ZCUGwwZjcrM29rLzNzckxlcWpXWnlNK3dLZ1dvT2NU?=
 =?utf-8?B?cXU5Tk5iNEIwNFJTdWluaXdqZGVzeUx6Q2RldTdGL25ScU5QQ1Bway8zdk1m?=
 =?utf-8?B?eVJneE4rZ2RRRTVjVmxkTVc2THVxT2RtU0NaS3dIQ2tROE1LVU9BOWlLa2ZI?=
 =?utf-8?B?OVB4d2JJQ01JOERqM3A4THBvbVBvYWlTcm9GaWpnU2NJZnN1OGpNdFZkZklj?=
 =?utf-8?B?UU5EWlN4WlM3Y2dSeFFFYlROYjdJbWxaU2VZUnNvQkdzTkZ4SFdwWjBLMnpk?=
 =?utf-8?B?WUNHaFBVUGhNajdNcytsdW9ESzV2SFN2citFUTF4ek96ZUh2dk9BV0szSWd2?=
 =?utf-8?B?QmFpbkRlMVE3bjdsb3JPK1g3ck9LUWV3KzZra0hHYzR0VGx1UG9mUVRmaUYz?=
 =?utf-8?B?U2FWTEM1eXAvenkycXhSWjhQMGVFU2g1VzcrN1ZLUWJQckdROTgxdnRSNnVC?=
 =?utf-8?B?SWxUZlJrditUMS9xY0hQeTVUNjEyZERWSGJUL1Y2RUdENC9ETnc5ZktxaGtm?=
 =?utf-8?B?T1h1QnBLL2o2ZURHSEEzb0FFaHVQZHBQQXdXNEJvRFVHMXpDMkxqajdPQUtt?=
 =?utf-8?B?Uk15Tml6R3ZCWDE5dEtpNGpzZWpqTllXeUpYMlV6S096aHhsMnE3ZDQ0czdy?=
 =?utf-8?B?ZEtGVFNKZzBBZzkvcCtnblFrQXk3NUk5R21qT3h0YWY1MWV3cEZlZ2IxZ3Iy?=
 =?utf-8?B?U1ViZmZ5SExaMjlKVFIxcGJZU3lmSU5XbEdJeXJFRnBNd3F1d2pvbXcvcGx6?=
 =?utf-8?B?TXd3TWI0SENyUDFad0lMMjk3b3VaSGVqM3pXTFdpT3p3NDNGbWs5dUhqbjlJ?=
 =?utf-8?B?cDRSV01NcGFHelo5bGk0WVlhSXROcDBOTUtMSU1FdnhveGJhV2YwZXdHQVZr?=
 =?utf-8?B?TE9DZlpIOGFWK0kzcFZHdjU4WEpuTEFiRzNaS2NxbklQWXVQL1RlcWF0TVBB?=
 =?utf-8?B?ajZkZk9HWnBMeDNDRzdhbzFjQ29zTlN4aTRZYUNxU25aR1FsZEtpL1ByYXNi?=
 =?utf-8?B?alN2cFI5L1QwMzF0SWljNmh3QXQ1VFMxbkRzTnFzMm04ZkpBa1U1S2VWcFhW?=
 =?utf-8?B?NkdhVmx6elJWbkdvZElOUjZOQXhsV0lrUlVRbVhYbUQrNHd5a3REUVR0OHQ2?=
 =?utf-8?B?SUluaVkxYWNnNUxpdys5L3YwSUhXeHJrV2FSQzBoN2JPT3pFT2ZheHlldytv?=
 =?utf-8?B?WEJlV0w2Yy9ReWJna1JpNzFtZWVsdUJudXdSeWl0Mk0rKzFUMERCaDZYL1lB?=
 =?utf-8?B?dkpWNG1kOXRaV1lIZGtZUjNUVVR1ZnVYcnpRTFJLYWlmS01USG5OTVNKM1ZZ?=
 =?utf-8?B?bTBWdDRwTnhIVXRxZFdURmt6aFI0alhSWlRQWXNqeTlhSWpuQWZRQ00wWmQy?=
 =?utf-8?B?aERJVnVlSEdhaGtQSnFjY3ptdUZVNWNIaHR5eWJlOE95UHNhY3VzMFp6MzBW?=
 =?utf-8?B?Z215UzNpVXZLYnhtb2RmQmpuamsza0EzcU0rd3piWDVuQ2F4NGVRdHZHWVpR?=
 =?utf-8?B?clJscmZpbzZmMGJjZFd5NVNHb21uM0hULzBIQ3RIOURwYW96MVhPd3VGZkQx?=
 =?utf-8?B?YXRUeXBrL3pLZXFMZS9DU21PeXhUZEJHWkJtSjltcC9OdzloMHJGTDRJTkZr?=
 =?utf-8?B?T3hkY1plUGc0VjVHTkgvM0tpRndsY0RmWUxzZm5DUFVBLzN0aHF0ZldiOGtw?=
 =?utf-8?B?MjNRbzdESEJmTEtJTG53NjJMZ0NnVlV6bTFsVWRLMzVtTUlGQ3V4dDFaU1Nu?=
 =?utf-8?B?WlpzMDNJYmJKUUtreDBVaDlCcytrSXhUMDhzUUoycWxpZzlxOUI2NWRmc1R3?=
 =?utf-8?B?anJZYWxWOXhJS3hLbVVmNGJDRWVIU3pQbll3bTQrblNacFJRUWxHYnVkempT?=
 =?utf-8?Q?BRvT6t1B34It4yjeis?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4efeec-4ac1-46a2-43b6-08de4f884c94
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 14:06:35.4216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cffmkjc9zfkma/8V2qiivm6wuF/uDOo7BH4L7H609kpjzneKL2qZ1gZ16crFlmaI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7320
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

On 1/9/26 14:33, Tvrtko Ursulin wrote:
> IDR is deprecated so let's replace it with xarray.
> 
> Conversion is mostly 1:1 apart from AMDGPU_BO_LIST_OP_UPDATE which was
> implemented with idr_replace, and has now been replaced with a sequence of
> xa_load and xa_cmpxchg. Should userspace attempt multi-threaded update
> operations on the same handle it could theoretically hit a new -ENOENT
> path. But I believe this is purely theoretical and still safe.
> 
> Also, since we have removed the RCU protection around the handle lookup we
> also removed the RCU freeing of the list.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> v2:
>  * Dropped RCU freeing of the list.
> 
> v3:
>  * Handle NULL in amdgpu_bo_list_put.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 83 +++++++++------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h |  3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     | 11 +--
>  4 files changed, 43 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 80dba6276aa8..ec3cbe70012a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -50,6 +50,7 @@
>  #include <linux/hashtable.h>
>  #include <linux/dma-fence.h>
>  #include <linux/pci.h>
> +#include <linux/xarray.h>
>  
>  #include <drm/ttm/ttm_bo.h>
>  #include <drm/ttm/ttm_placement.h>
> @@ -499,8 +500,7 @@ struct amdgpu_fpriv {
>  	struct amdgpu_bo_va	*prt_va;
>  	struct amdgpu_bo_va	*csa_va;
>  	struct amdgpu_bo_va	*seq64_va;
> -	struct mutex		bo_list_lock;
> -	struct idr		bo_list_handles;
> +	struct xarray		bo_list_handles;
>  	struct amdgpu_ctx_mgr	ctx_mgr;
>  	struct amdgpu_userq_mgr	userq_mgr;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> index a7a58126c8db..62336890ed40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -37,14 +37,6 @@
>  #define AMDGPU_BO_LIST_MAX_PRIORITY	32u
>  #define AMDGPU_BO_LIST_NUM_BUCKETS	(AMDGPU_BO_LIST_MAX_PRIORITY + 1)
>  
> -static void amdgpu_bo_list_free_rcu(struct rcu_head *rcu)
> -{
> -	struct amdgpu_bo_list *list = container_of(rcu, struct amdgpu_bo_list,
> -						   rhead);
> -
> -	kvfree(list);
> -}
> -
>  static void amdgpu_bo_list_free(struct kref *ref)
>  {
>  	struct amdgpu_bo_list *list = container_of(ref, struct amdgpu_bo_list,
> @@ -53,7 +45,8 @@ static void amdgpu_bo_list_free(struct kref *ref)
>  
>  	amdgpu_bo_list_for_each_entry(e, list)
>  		amdgpu_bo_unref(&e->bo);
> -	call_rcu(&list->rhead, amdgpu_bo_list_free_rcu);
> +
> +	kvfree(list);
>  }
>  
>  static int amdgpu_bo_list_entry_cmp(const void *_a, const void *_b)
> @@ -146,36 +139,26 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
>  
>  }
>  
> -static void amdgpu_bo_list_destroy(struct amdgpu_fpriv *fpriv, int id)
> -{
> -	struct amdgpu_bo_list *list;
> -
> -	mutex_lock(&fpriv->bo_list_lock);
> -	list = idr_remove(&fpriv->bo_list_handles, id);
> -	mutex_unlock(&fpriv->bo_list_lock);
> -	if (list)
> -		kref_put(&list->refcount, amdgpu_bo_list_free);
> -}
> -
> -int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, int id,
> +int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id,
>  		       struct amdgpu_bo_list **result)
>  {
> -	rcu_read_lock();
> -	*result = idr_find(&fpriv->bo_list_handles, id);
> +	struct amdgpu_bo_list *list;
>  
> -	if (*result && kref_get_unless_zero(&(*result)->refcount)) {
> -		rcu_read_unlock();
> -		return 0;
> -	}
> +	xa_lock(&fpriv->bo_list_handles);
> +	list = xa_load(&fpriv->bo_list_handles, id);
> +	if (list)
> +		kref_get(&list->refcount);
> +	xa_unlock(&fpriv->bo_list_handles);
>  
> -	rcu_read_unlock();
> -	*result = NULL;
> -	return -ENOENT;
> +	*result = list;
> +
> +	return list ? 0 : -ENOENT;
>  }
>  
>  void amdgpu_bo_list_put(struct amdgpu_bo_list *list)
>  {
> -	kref_put(&list->refcount, amdgpu_bo_list_free);
> +	if (list)
> +		kref_put(&list->refcount, amdgpu_bo_list_free);
>  }
>  
>  int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
> @@ -199,12 +182,12 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
>  int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>  				struct drm_file *filp)
>  {
> -	struct amdgpu_device *adev = drm_to_adev(dev);
>  	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	struct drm_amdgpu_bo_list_entry *info = NULL;
> +	struct amdgpu_bo_list *list, *prev, *curr;
>  	union drm_amdgpu_bo_list *args = data;
>  	uint32_t handle = args->in.list_handle;
> -	struct drm_amdgpu_bo_list_entry *info = NULL;
> -	struct amdgpu_bo_list *list, *old;
>  	int r;
>  
>  	r = amdgpu_bo_create_list_entry_array(&args->in, &info);
> @@ -218,19 +201,18 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>  		if (r)
>  			goto error_free;
>  
> -		mutex_lock(&fpriv->bo_list_lock);
> -		r = idr_alloc(&fpriv->bo_list_handles, list, 1, 0, GFP_KERNEL);
> -		mutex_unlock(&fpriv->bo_list_lock);
> -		if (r < 0) {
> +		r = xa_alloc(&fpriv->bo_list_handles, &handle, list,
> +			     xa_limit_32b, GFP_KERNEL);
> +		if (r)
>  			goto error_put_list;
> -		}
>  
> -		handle = r;
>  		break;
>  
>  	case AMDGPU_BO_LIST_OP_DESTROY:
> -		amdgpu_bo_list_destroy(fpriv, handle);
> +		list = xa_erase(&fpriv->bo_list_handles, handle);
> +		amdgpu_bo_list_put(list);
>  		handle = 0;
> +
>  		break;
>  
>  	case AMDGPU_BO_LIST_OP_UPDATE:
> @@ -239,16 +221,23 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>  		if (r)
>  			goto error_free;
>  
> -		mutex_lock(&fpriv->bo_list_lock);
> -		old = idr_replace(&fpriv->bo_list_handles, list, handle);
> -		mutex_unlock(&fpriv->bo_list_lock);
> +		curr = xa_load(&fpriv->bo_list_handles, handle);
> +		if (!curr) {
> +			r = -ENOENT;
> +			goto error_put_list;
> +		}
>  
> -		if (IS_ERR(old)) {
> -			r = PTR_ERR(old);
> +		prev = xa_cmpxchg(&fpriv->bo_list_handles, handle, curr, list,
> +				  GFP_KERNEL);
> +		if (xa_is_err(prev)) {
> +			r = xa_err(prev);
> +			goto error_put_list;
> +		} else if (prev != curr) {
> +			r = -ENOENT;
>  			goto error_put_list;
>  		}
>  
> -		amdgpu_bo_list_put(old);
> +		amdgpu_bo_list_put(curr);
>  		break;
>  
>  	default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> index 1acf53f8b2f9..cf127bc66f53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> @@ -43,7 +43,6 @@ struct amdgpu_bo_list_entry {
>  };
>  
>  struct amdgpu_bo_list {
> -	struct rcu_head rhead;
>  	struct kref refcount;
>  	struct amdgpu_bo *gds_obj;
>  	struct amdgpu_bo *gws_obj;
> @@ -54,7 +53,7 @@ struct amdgpu_bo_list {
>  	struct amdgpu_bo_list_entry entries[] __counted_by(num_entries);
>  };
>  
> -int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, int id,
> +int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id,
>  		       struct amdgpu_bo_list **result);
>  void amdgpu_bo_list_put(struct amdgpu_bo_list *list);
>  int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index f65edd80cabf..a72a74ba30ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1451,8 +1451,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  	if (r)
>  		goto error_vm;
>  
> -	mutex_init(&fpriv->bo_list_lock);
> -	idr_init_base(&fpriv->bo_list_handles, 1);
> +	xa_init_flags(&fpriv->bo_list_handles, XA_FLAGS_ALLOC1);
>  
>  	r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, file_priv, adev);
>  	if (r)
> @@ -1498,8 +1497,8 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
>  	struct amdgpu_bo_list *list;
>  	struct amdgpu_bo *pd;
> +	unsigned long handle;
>  	u32 pasid;
> -	int handle;
>  
>  	if (!fpriv)
>  		return;
> @@ -1535,11 +1534,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
>  	amdgpu_bo_unref(&pd);
>  
> -	idr_for_each_entry(&fpriv->bo_list_handles, list, handle)
> +	xa_for_each(&fpriv->bo_list_handles, handle, list)
>  		amdgpu_bo_list_put(list);
> -
> -	idr_destroy(&fpriv->bo_list_handles);
> -	mutex_destroy(&fpriv->bo_list_lock);
> +	xa_destroy(&fpriv->bo_list_handles);
>  
>  	kfree(fpriv);
>  	file_priv->driver_priv = NULL;

