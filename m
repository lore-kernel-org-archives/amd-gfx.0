Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E86CED606
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 06:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBEC310E644;
	Wed,  9 Oct 2024 06:02:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kpPXQ13/";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6447610E644
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 06:02:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GL+GLAOMJkjtYqKPlOsHvWUaOtWvVI4MaUQlLPdAp1dDPJB6ENbsi0AxVmxKFbFHilt2UO+CID1zR/TeWgaSF5RxauPxmwSr1+zh9NwbCTR8Vdb1mtlxZ38jQ7yhrrboe7k+1nlcTpqKkxSBi+oGiRXUa2rYM+/1oTHNcKrYA4BM4UFUqS394D/flHwqEtKGwMgBq8iYcylSg2V39kSr5QxCrVWNq9ml9oPC3Ws/MtwTfnGQsu6UgV/DngLBLvzUTESRIAdhG0myY2Ut3tqR9TI4dKxF0yEDwv2baVVH9bgruS+bbib3BURW50vudUGiAvDcE6EVpJ10MGU59pHWLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ssgnk4MdwYml6kL1wQURvw5GAf+W+ppD4tcVYYlzn0=;
 b=gT0I/KQRSGcLrUsD9e3pUYrKnCRpQr6UziF+v78SS43mMb02K2sj3oeqHvGDrIRH06Ua6OKZE7eCm5kf8dSZWIdr38CjqO2NQNSxbxLHT0HA19ho43mppcPs6inScMqjYSpu2yYeTj3lhWpaeSdR3G/pwM47JI/dnnnv5bZhcscP8yUvrhlZon7ooHVrPrwk6kxmg9fSPjyKzJ5EBRFTUX5oiWqVj28VVy9Z+smPpIK/cdx2OEFgCoaLmcThbZfRAbj4fWDdHinVCWgCaDYSx6uXrDt2KD6DOh6QcAVY12anKHcI+3YumdCUz3GsKy688Ddu8C4+gOmCf9qw4/C/jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ssgnk4MdwYml6kL1wQURvw5GAf+W+ppD4tcVYYlzn0=;
 b=kpPXQ13/Z0y6P+UsI7u0BG2EV9nDGdXfxoH956AY+E7dB4J37UX7czr9KvyiD3BU/YJfJqwYdXA7AbeXM/Heu/6pZhgEoojG9tB97iE+Hu10uifJsSvBnLNsqhsaRZ8yal5NFom8S2JLc3hAZrnEbYj7gIU0yOlj0yRa7oCxuj0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 06:02:39 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 06:02:39 +0000
Message-ID: <063060cf-46e9-4664-8b5d-0d8b2ea200a0@amd.com>
Date: Wed, 9 Oct 2024 11:32:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/amdgpu/sdma4.4.2: implement ring reset
 callback for sdma4.4.2
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241009034545.543736-1-jiadong.zhu@amd.com>
 <20241009034545.543736-3-jiadong.zhu@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241009034545.543736-3-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PEPF000067EA.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::26) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|LV3PR12MB9411:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dd04c06-7545-443b-6f69-08dce827faba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2VDQXh5c0d6Q0xidlIxRy9wZGdMM1ZOZmo2RmJpVmcwaHBPVVloRU1nd3BN?=
 =?utf-8?B?UlVsUmVPLzduQ1BuSmcyUG1FUDBqV24zRjVOSXhONkVNbk55NXQvQ2x1ZGFk?=
 =?utf-8?B?bDNsRTBkMzF2d3NLandsWWcwbE5GdnFMSGd2UnFhRWtLbGNUcUFhUmt5NnZU?=
 =?utf-8?B?NE0rU3ByR1YxYWR0bHZ1WWovOXl4TjJ2M3B3Uk8wR0VsQk4vaW1WTEdXMXZM?=
 =?utf-8?B?bm9aSVY0YjQvZGpHN3NnRDM1d3JTSndtdXhEbFhJc3NjK0lvdm1hUU5lQnJz?=
 =?utf-8?B?ZVlsK0E1OFQ3aW9Hb1I1aDhxaEdLVS9yNlVDaTRxSzFPbzRrZVg5OVo5ZFhN?=
 =?utf-8?B?cDZKbVlIWFllWVllaU85Q3g3SEI1ZjRuWm41ZEsyU3pMT1NhTjZ6TmJpSzk5?=
 =?utf-8?B?L2d1emJ5WTVFaTNLZGgwczRIVC8yK1l5S3plQ2YzTEdGUVd0Y3F0QWVGcUhv?=
 =?utf-8?B?WGVqRTBZYWJ6RnhQaHpneGNHcXZEc2tHTXJHa25xM0UzL1BnSTZpdzhVVlkx?=
 =?utf-8?B?MlB0dVFRQ015UDlNMVFHZ2RhZlFPdm5IYXRPd1VFRnJIRGJwSE9nWTRBa09B?=
 =?utf-8?B?TjkwTXFyNUNuNTRTaW1CM3B4UUdqaUlqSmxTaTJSenZCb2N4cVdIbDBGem5i?=
 =?utf-8?B?eE8zaXJHMG11MkFLLzNGU2R6VUNtMEdTYTNiY2VUdkU2S0pjWklnQUgrejgx?=
 =?utf-8?B?RFYrcWFJQ3FHU0tzRVc1QWUzYmpSaGl6YnNBTkI5SjFhcjhZWGV6L0dlN25l?=
 =?utf-8?B?dmIxRFhiY01Ed2ptdnhjSWxoWFJCcFRRV21maHFSalJZcHNxakJDRU9OSUsw?=
 =?utf-8?B?Y1FBOW9ITTZic2ZQTkhTc0k5Uk54RnltYkpEa05jdUhOWERyb1VwYlB1cHNu?=
 =?utf-8?B?MmwzU25aaUVrRnREcnYwRUt6RjRqTFZhZzlLQU5ZU3JCWW1xbTdIakU2N1lv?=
 =?utf-8?B?SWZiRFNXdTNCMDkyMXIrdGluS1A1Ykp2ZGtnc1ZwRnZuWmtnZVNCaW1UYjdW?=
 =?utf-8?B?dExHcVdJZE50SkkzSDArOUxJZzF0T3RTemFWb0dTYS9IWHo0akg2aEE5RVhM?=
 =?utf-8?B?OTNWVnQ3RGtPalRCcnFsYW9ONW1YRkt2TURLUFJ0aUV4Z2M0MGc4c3FaelBH?=
 =?utf-8?B?TlRKOWdhVEhMYk1VYlVCKzJ1OE0xVFJyejlNbTkvMmprNWxYZjlzVU40cW9r?=
 =?utf-8?B?cUlMbitUNTBRemd4WUlaVzZMcEhwY3lqTmp2b3JOeHJvT3VZSC9WellRbWN5?=
 =?utf-8?B?MTBuRzF2cTc0ZEJuR1JEMUR1VEpjcjVGNmc5alJ1eXJvd0huMXk2NUI0cnlr?=
 =?utf-8?B?NEIrbE96NWhsb3RWQWlJYXEzS2RXTjQvNlNsL1lUMHM1TUtFdTErV08yRjdp?=
 =?utf-8?B?S25GMlBwRlV6R295RnVMYkxNb002QXRqVEQranZHZUZGVU0wdExsV1NVZ1ZE?=
 =?utf-8?B?WFhPT3VROHptUEVNU29BRW9xeUhJcVkxNWMzTGxxMnJDcGx3bjBRazBKUTIr?=
 =?utf-8?B?ZjNDRUx5U1paUGZERnRRTlE1aDE0YzViTCsybkZPbG5jbWcrUFJnbkVkaFF0?=
 =?utf-8?B?Q3JNdUdER01PYmhDWnhpVmlVajFxOXluRWFWZFBpU0VTWGxUVFg0eE01aWJ1?=
 =?utf-8?B?bi9NMWRtNEZKRXB4RC8ydWJuUkpDSDVQQkFUV09qYkZJOU9GTEgxV2pDaUxO?=
 =?utf-8?B?dlRIZHFGSE04bDUrRmI5aXNnWmpPMWgrcHBuZHlwRTBvNmNudXJlcjdnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVBoK1lEYWVrRGd2c25WN0Q5QVB1cW9Pa2F4eUNKblVBbTRkTllKSlZOVkR3?=
 =?utf-8?B?aDRTRGx4VUUyMWNPejFMSU5UdFJYUW1VYUU1ZlYxbWM1T3Vjd096RHlIbWlU?=
 =?utf-8?B?UVhlV2Foa1I3MUZ1cExZZmpHalZwNkM3L1lSeTIvUU9CVHVUUWxzbE9YUmpH?=
 =?utf-8?B?MHlNVVRzdkFqdUdkOWlyS1JZdGwwc3BaQU1GRzd5WFRXc0NadGI5TmQ4Qndu?=
 =?utf-8?B?c05RSmNVaHEvL2VOV0twcnQ5R0wremhFbG9QTFVJcmF5RTM1eVRuMzAwaDdT?=
 =?utf-8?B?RWVZeDFxa3JCZGdMMWFXcFZlWjlZeWs5TmcxTjdMU3YzT0xCa3N3RzlUSkZU?=
 =?utf-8?B?WDhHNE84MzFkcitaUTQwNFV6Nk9MMjhaTFlRL0g4akg0TjRaVXljQ0x2YlZL?=
 =?utf-8?B?SGZvK0FIbEp1RUoxdkRXWmV2SFNUVUcrenhKRmZ4N2hGN2JvWk1aY2Y1QU5X?=
 =?utf-8?B?TG9ETThlbHE3Y0JlZ2tSS2tpTUsvdW5OdFhyQVFpNDN0Q0JjSFRMaUdlMUtY?=
 =?utf-8?B?TjFOVzkzSTVmWUZFbjlnOHdKR2pESDZzNXlWMDN6ejVlQmdFemI0WHNURXlw?=
 =?utf-8?B?TGxWRUthbFBqQVN3bXJNcFVmdWI3YnM1TUY3NDhOSDEvVHlFZW5BeHlreVpE?=
 =?utf-8?B?NjUrdzFWWWFqdHZOVnhyZ2NmNjk2dFhyY3lRY0IxWU1LUjkwb0ZzME9NdFNT?=
 =?utf-8?B?QjFvOTBuTmFzMnE0NzB4RnN1cHZqVHhBSjdGbEQyRklXb1Z6d0UzWk9LT0pW?=
 =?utf-8?B?SGxtc2pndnFPczRJaEU3TWV5QTFZNnFYeXZybEgyVDVyU1NaMEY2eGpBZGRw?=
 =?utf-8?B?aUZvR1hPdFFtQTdFbFJJL3hZSWUrZUVFWUh6WDBQUUozV0RWQ21pK200S1BE?=
 =?utf-8?B?RzV4M3MxdHA1L0VDWnZ1bjdVRE5NcTFVZmc5b2VHNjNpV3YwbWdOdlpqenZV?=
 =?utf-8?B?K2UrUExIdFpHYThCcExQbnpoTk41NE8rSFdXS3ZycnJDQlZDL20wMTlHNjU1?=
 =?utf-8?B?d3owWkN5eEwvTkdadUN3LzI5NW9nSmxKUFRRczhKQjJlUS9LWTlDaVVSNjNi?=
 =?utf-8?B?TmZ6UENqcXI3VVFuQ2QrRmtqQVRaTVhMR2g3Z3RmOGNGK0txc2doMFBrOEdw?=
 =?utf-8?B?K05BTkVQcVEwTGZVUExlUS91SUdBNEVBNGlET2w3ZGxhejRzZGVCUHVUOVl6?=
 =?utf-8?B?Y0dvZG9ENWpUSUV4U1F6WW9nVDVkbzN4M1NMNXNlWWFWdjVRVTlOUVh6bVAr?=
 =?utf-8?B?dk9xTHdiYVFMZzdVc2kyVjdDSUxKVFFsK1ZUd21NQU1mM0lRcjhmWmJpRFhi?=
 =?utf-8?B?ZHlsQk1OUDZlLzB6Q2lLQ2tzdXlGeEJYZTh3Y293anZpN09ONjJrdWQrTDN5?=
 =?utf-8?B?Y3M3WnhCZmkyTlhTYnAra0ViajNWVWExcFpWd015M2oyUFdJb2Z1SGs5ZnJu?=
 =?utf-8?B?cCtiQlJwZ3ZVZ2NmWk13SG5Yby9yWFBDclNtRS92ejkxNTQ2T1RFbk9Rc3Vy?=
 =?utf-8?B?TkNqRTE5eXM5dDZ5VGZwQVV4WmFhZkhjZVRZNWZHanNuTEw5Y2o0cGw0TzBW?=
 =?utf-8?B?QXJRV2JhRE1RZ3lWWW83Q0dnVjZKR2xYNmlVWE1oZ0tWOU0vczFFc1ZPd1du?=
 =?utf-8?B?Q2JmNk5vY1lKVDBhQUwxaGRtdzJ5bE9mRmFiYXBuOFBrV3BaL3hpcTZtQ1A1?=
 =?utf-8?B?VjN2T3cxbmw4ckpSTEFBb25BZWpaSUVKZDJzZnM5QWVjdjhJT05kN1pYN093?=
 =?utf-8?B?ZWllc3RtQlV5K0hqbUV6OTBXbWd3RjBsWVpkcUpDcjFKZFNoQ2dXdWIxdXVH?=
 =?utf-8?B?NVR3aDVNZlhLV2laRisxZ3V5Vk5neXRibXFLTVdOZHhURTFDc3dIRTNhNExH?=
 =?utf-8?B?NWNtbGkvZGZBUFpOY29PWTNmS1A2SGR1V0RtMXNINkpsRWxqY2lIbGFxRUtK?=
 =?utf-8?B?N1NjVnYxMC9hS1JpeTFSckdHVGYvYlNuZHg2eE1ZdzcreUZ0TjRsTm0yTFR6?=
 =?utf-8?B?eUJ3RzlyeGt3a01kSHo1THFxSUtKdzdtVlRsejhiUEZhbW9XSTgvMFFQVjAz?=
 =?utf-8?B?VmNCemtrMytvQmtTRDZsNFRGS3lIQ1hlNGR1eXpjTkdVSGdaZWd2bjNRU2Ux?=
 =?utf-8?Q?ld2C8lnxMvoyO5RVxdFrCaDXi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd04c06-7545-443b-6f69-08dce827faba
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 06:02:39.0429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RD/SAkcLK2+jw2Qw+Ak51NkOsFptwlPTeFSiPE0uhJG7h7q1vMxSuNCkXJAXxaZm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9411
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



On 10/9/2024 9:15 AM, jiadong.zhu@amd.com wrote:
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
> 
> Implement sdma queue reset callback via SMU interface.
> 
> v2: Leverage inst_stop/start functions in reset sequence.
>     Use GET_INST for physical SDMA instance.
>     Disable apu for sdma reset.
> 
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 97 +++++++++++++++++++-----
>  1 file changed, 79 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index c77889040760..3cb16af9b78e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -667,11 +667,12 @@ static uint32_t sdma_v4_4_2_rb_cntl(struct amdgpu_ring *ring, uint32_t rb_cntl)
>   *
>   * @adev: amdgpu_device pointer
>   * @i: instance to resume
> + * @restore: used to restore wptr when restart
>   *
>   * Set up the gfx DMA ring buffers and enable them.
>   * Returns 0 for success, error for failure.
>   */
> -static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i)
> +static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, bool restore)
>  {
>  	struct amdgpu_ring *ring = &adev->sdma.instance[i].ring;
>  	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
> @@ -698,16 +699,24 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i)
>  	WREG32_SDMA(i, regSDMA_GFX_RB_BASE, ring->gpu_addr >> 8);
>  	WREG32_SDMA(i, regSDMA_GFX_RB_BASE_HI, ring->gpu_addr >> 40);
>  
> -	ring->wptr = 0;
> +	if (!restore)
> +		ring->wptr = 0;
>  
>  	/* before programing wptr to a less value, need set minor_ptr_update first */
>  	WREG32_SDMA(i, regSDMA_GFX_MINOR_PTR_UPDATE, 1);
>  
>  	/* Initialize the ring buffer's read and write pointers */
> -	WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
> -	WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
> -	WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, 0);
> -	WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, 0);
> +	if (restore) {
> +		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->wptr << 2));
> +		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->wptr << 2));
> +		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->wptr << 2));
> +		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->wptr << 2));
> +	} else {
> +		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
> +		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
> +		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, 0);
> +		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, 0);
> +	}
>  
>  	doorbell = RREG32_SDMA(i, regSDMA_GFX_DOORBELL);
>  	doorbell_offset = RREG32_SDMA(i, regSDMA_GFX_DOORBELL_OFFSET);
> @@ -759,7 +768,7 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i)
>   * Set up the page DMA ring buffers and enable them.
>   * Returns 0 for success, error for failure.
>   */
> -static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i)
> +static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i, bool restore)
>  {
>  	struct amdgpu_ring *ring = &adev->sdma.instance[i].page;
>  	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
> @@ -775,10 +784,17 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i)
>  	WREG32_SDMA(i, regSDMA_PAGE_RB_CNTL, rb_cntl);
>  
>  	/* Initialize the ring buffer's read and write pointers */
> -	WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, 0);
> -	WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, 0);
> -	WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR, 0);
> -	WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR_HI, 0);
> +	if (restore) {
> +		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->wptr << 2));
> +		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->wptr << 2));
> +		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->wptr << 2));
> +		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->wptr << 2));
> +	} else {
> +		WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, 0);
> +		WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, 0);
> +		WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR, 0);
> +		WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR_HI, 0);
> +	}
>  
>  	/* set the wb address whether it's enabled or not */
>  	WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_ADDR_HI,
> @@ -792,7 +808,8 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i)
>  	WREG32_SDMA(i, regSDMA_PAGE_RB_BASE, ring->gpu_addr >> 8);
>  	WREG32_SDMA(i, regSDMA_PAGE_RB_BASE_HI, ring->gpu_addr >> 40);
>  
> -	ring->wptr = 0;
> +	if (!restore)
> +		ring->wptr = 0;
>  
>  	/* before programing wptr to a less value, need set minor_ptr_update first */
>  	WREG32_SDMA(i, regSDMA_PAGE_MINOR_PTR_UPDATE, 1);
> @@ -916,7 +933,7 @@ static int sdma_v4_4_2_inst_load_microcode(struct amdgpu_device *adev,
>   * Returns 0 for success, error for failure.
>   */
>  static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
> -				  uint32_t inst_mask)
> +				  uint32_t inst_mask, bool restore)
>  {
>  	struct amdgpu_ring *ring;
>  	uint32_t tmp_mask;
> @@ -927,7 +944,7 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
>  		sdma_v4_4_2_inst_enable(adev, false, inst_mask);
>  	} else {
>  		/* bypass sdma microcode loading on Gopher */
> -		if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP &&
> +		if (!restore && adev->firmware.load_type != AMDGPU_FW_LOAD_PSP &&
>  		    adev->sdma.instance[0].fw) {
>  			r = sdma_v4_4_2_inst_load_microcode(adev, inst_mask);
>  			if (r)
> @@ -946,9 +963,9 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
>  		uint32_t temp;
>  
>  		WREG32_SDMA(i, regSDMA_SEM_WAIT_FAIL_TIMER_CNTL, 0);
> -		sdma_v4_4_2_gfx_resume(adev, i);
> +		sdma_v4_4_2_gfx_resume(adev, i, restore);
>  		if (adev->sdma.has_page_queue)
> -			sdma_v4_4_2_page_resume(adev, i);
> +			sdma_v4_4_2_page_resume(adev, i, restore);
>  
>  		/* set utc l1 enable flag always to 1 */
>  		temp = RREG32_SDMA(i, regSDMA_CNTL);
> @@ -1390,6 +1407,7 @@ static int sdma_v4_4_2_sw_init(void *handle)
>  		ring = &adev->sdma.instance[i].ring;
>  		ring->ring_obj = NULL;
>  		ring->use_doorbell = true;
> +		ring->me = i;

Appears like an unrelated change. This is alredy done in
sdma_v4_4_2_set_ring_funcs()

>  		aid_id = adev->sdma.instance[i].aid_id;
>  
>  		DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n", i,
> @@ -1477,7 +1495,7 @@ static int sdma_v4_4_2_hw_init(void *handle)
>  	if (!amdgpu_sriov_vf(adev))
>  		sdma_v4_4_2_inst_init_golden_registers(adev, inst_mask);
>  
> -	r = sdma_v4_4_2_inst_start(adev, inst_mask);
> +	r = sdma_v4_4_2_inst_start(adev, inst_mask, false);
>  
>  	return r;
>  }
> @@ -1566,6 +1584,48 @@ static int sdma_v4_4_2_soft_reset(void *handle)
>  	return 0;
>  }
>  
> +static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	int i, r;
> +	u32 preempt, inst_mask;
> +
> +	if ((adev->flags & AMD_IS_APU) || amdgpu_sriov_vf(adev))
> +		return -EINVAL;
> +
> +	/* stop queue */
> +	inst_mask = 1 << ring->me;
> +	sdma_v4_4_2_inst_gfx_stop(adev, inst_mask);
> +	if (adev->sdma.has_page_queue)
> +		sdma_v4_4_2_inst_page_stop(adev, inst_mask);
> +
> +	/* soft reset SDMA_GFX_PREEMPT.IB_PREEMPT = 0*/
> +	preempt = RREG32_SDMA(ring->me, regSDMA_GFX_PREEMPT);
> +	preempt = REG_SET_FIELD(preempt, SDMA_GFX_PREEMPT, IB_PREEMPT, 0);
> +	WREG32_SDMA(ring->me, regSDMA_GFX_PREEMPT, preempt);
> +
> +	r = amdgpu_dpm_reset_sdma(adev, 1 << GET_INST(SDMA0, ring->me));
> +	if (r) {
> +		dev_err(adev->dev, "amdgpu_dpm_reset_sdma failed(%d).\n", r);

If this is here, then better to avoid another print in smu callback. May
rephrase as "SDMA %d reset failed".

> +		return r;
> +	}
> +
> +	udelay(50);
> +
> +	for (i = 0; i < adev->usec_timeout; i++) {
> +		if (!REG_GET_FIELD(RREG32_SDMA(ring->me, regSDMA_F32_CNTL), SDMA_F32_CNTL, HALT))
> +			break;
> +		udelay(1);
> +	}
> +
> +	if (i == adev->usec_timeout) {
> +		dev_err(adev->dev, "waiting for unhalt failed.\n");

Better to add more context - ex: "timed out waiting for SDMA %d unhalt
after reset".

Thanks,
Lijo

> +		return -ETIMEDOUT;
> +	}
> +
> +	return sdma_v4_4_2_inst_start(adev, inst_mask, true);
> +}
> +
>  static int sdma_v4_4_2_set_trap_irq_state(struct amdgpu_device *adev,
>  					struct amdgpu_irq_src *source,
>  					unsigned type,
> @@ -1948,6 +2008,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
>  	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
>  	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
> +	.reset = sdma_v4_4_2_reset_queue,
>  };
>  
>  static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
> @@ -2160,7 +2221,7 @@ static int sdma_v4_4_2_xcp_resume(void *handle, uint32_t inst_mask)
>  	if (!amdgpu_sriov_vf(adev))
>  		sdma_v4_4_2_inst_init_golden_registers(adev, inst_mask);
>  
> -	r = sdma_v4_4_2_inst_start(adev, inst_mask);
> +	r = sdma_v4_4_2_inst_start(adev, inst_mask, false);
>  
>  	return r;
>  }
