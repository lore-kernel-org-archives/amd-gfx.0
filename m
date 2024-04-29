Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D89CC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 21:50:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EAF710E693;
	Mon, 29 Apr 2024 21:50:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cI7q8K7g";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 909AA10E693
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 21:50:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDJNvLriGqeUwBzxM02PDIsbSh4gsIz+IHO2fQ5DF3pGZ7QyMISfE18+TNIIVr+KwGTEeVnEzfvzCFqsYMFAQdjLGxDiQC2m84IaW5iOYo3mF7JQBSDwd979EnVbyIys9vfzZEcVk2Tbd6D9Pac/dZEqGSSxxHlUY9iCaBKASq3e7LO1eUQrBbZyINZUstqgRaycRPjzJ5AlPKd7rAll+zcuZQ9HfJQX5YFZb4rhcc6vs8cd+FVKpL9JtKNWsPErDZURkub6grMfpPolTTjcyAtggEaDiIA8AHq2gWUoegWM9TItEYQo3YDjVt529vQdbTp2e7cFWIANwuQR5hKtuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CU4KPhtg7xbm7wltQZo/hVbZeGGHn9tvtwNeRkXu5E4=;
 b=Lf5wkaHB96Ctb3OP9BnVA8pOhWLw36FFhfx3FPuMRUXG5XCnGqVUx5zqDsfrGQ1bimLEu3xS+Ggos4IhR0TSQUmGbCOF0kK8LEeoagP2+JHq3ag4j+Fw9CuGYGRb21FXm71FrVjJXenP+0sKnKFYHkKGfKDRqpn/6Ity6kpzHIp/oU2oVOT+mzoIsL7eTsUFzMFK/Vyun4O4296bn9P6hOhR9C97LCHQPe/V+NrSCEB+OgWP2lFWOWjrT7jM+7gQHKMXRID+zzdN3PlzbKEvYCZy+2Fv/Z96+lw0R3fJ5QQlcxTFWybdSpFSxYHKOK1HgmGXKYnY6zztxQmh5VSfUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CU4KPhtg7xbm7wltQZo/hVbZeGGHn9tvtwNeRkXu5E4=;
 b=cI7q8K7g/JSjljwzjG9QS0LB134GnrjY564sGhpG8q9IaxSC/+qpz717UTrFTVy34K+DKrBomyIDOP9PyX09qN1gfZrFGm3PZrA5SR237rLSLKk+BwMBUzsurrqCI9gFd2AuIVjpAokBH2duZa71H8DPlnd3QKqT/ipUNNaNu3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4599.namprd12.prod.outlook.com (2603:10b6:a03:107::22)
 by LV3PR12MB9096.namprd12.prod.outlook.com (2603:10b6:408:198::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 21:50:36 +0000
Received: from BYAPR12MB4599.namprd12.prod.outlook.com
 ([fe80::6f97:8f23:34be:5b37]) by BYAPR12MB4599.namprd12.prod.outlook.com
 ([fe80::6f97:8f23:34be:5b37%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 21:50:36 +0000
Message-ID: <2eb63de5-2335-47da-81f3-42900a6caff0@amd.com>
Date: Mon, 29 Apr 2024 16:50:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: update buffer_{store,load}_* modifiers for
 gfx940
To: Lancelot SIX <lancelot.six@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240429110628.149277-1-lancelot.six@amd.com>
Content-Language: en-US
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <20240429110628.149277-1-lancelot.six@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::16) To BYAPR12MB4599.namprd12.prod.outlook.com
 (2603:10b6:a03:107::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4599:EE_|LV3PR12MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: d3fd7d19-b3cc-4e1d-3282-08dc689666ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGswTjdwK3VYSWtPOXlxL2J2anVUU0QvUThkZjE1cWFNVFpScXR1c1dWaFVY?=
 =?utf-8?B?YStVZExwMzVxei9vbkkyaHM0NThjdkw5WVVLM1pJVXZnY0hyZ2tCZUNrNUwx?=
 =?utf-8?B?R2NaRHNiL2QwQ3JZYjhVdVBiaGd0b0o3OWEzVTMvc3pmdUR2TVFLMWlTdTVw?=
 =?utf-8?B?Y3NKUzB1ZW1MOVZiZFBINUV2dEF3amQ5Y0Y4QU11anEraGNvRGticmZzanlU?=
 =?utf-8?B?S3A3RjdBSGtseHNEZy8vTzNoRVFFVkRFOE1TQldqSXE5OUdHVStiL2J2Y2lw?=
 =?utf-8?B?WktNTlNBYXp3VEthUWxkTG1wRWg5Y2NXUzhZUkg2RGxicU1uRm5zVEYrcDRE?=
 =?utf-8?B?c3AwQitBZTdJSkZySE02c3JVVEdDVmVnNCtkZnB4VDVMc0wvOG9ncGZqQzRz?=
 =?utf-8?B?SXlROHR4WTM0VjdKdXdLbis5OS9MUEVoK0pEY3ZHbVBxM3hwMSsrR1pSaDdC?=
 =?utf-8?B?aU5Oa2RKSDNOQ0JGUUxEYmhPVkhlL0VBN0ZIcDJQTm1XaTk0aVJDSTZmeTZh?=
 =?utf-8?B?aCsvUzNPSU1PbzBmV2JjNFNkSTVESC9Ld1IrRjRmVWMybm0wNituamZhQTZW?=
 =?utf-8?B?UVJadWJMM1A2K2lsaU96NEZmOW5YdFhtMmRKVjB1ZXVXaUNlTDdGRTlMcXhx?=
 =?utf-8?B?azBlN1dzT0c1QmE5VkVETDVKbEprUXZTZVlkTkZERkJJMWxKWmxJYWowNjNl?=
 =?utf-8?B?aUJTWFpHNVVETmJGQUZudjFFY2NqUTNjUlVFZm10YmxBNitacXdRdUNuQ0Vy?=
 =?utf-8?B?M2RPaHN1WmRKd3hQVzBDNnNnclRyTUdUQmFjZ1BpczNERzU3ZlRRdzdBTzRD?=
 =?utf-8?B?ZGkySXFzVjA5SGtINnFuTGJNZU5ETkRNNEI1R0dicFR5RjQ4aXhRM3hVK0pQ?=
 =?utf-8?B?VTJWa1R6RndDdDUvd0hScmtucVIwU2thUkJxek5vUk1JcnltWHM4RWR3c2dJ?=
 =?utf-8?B?VG5jWXBiYVNlU3hhUXNjSVNjcmVGZ0tENVNmdDlVTTI3elBqZ2FuSVJDSzZy?=
 =?utf-8?B?eFVQSEdGdXZIMEFYQTd3dGF3d1BRand2VGJHdzdvNnhsUldJaGNZWFIrWDVD?=
 =?utf-8?B?WFNQdWc0RlZ0b3lHeitjOHJGcTUycklnTjJZS1d2cjVkaHlxQzlCWktLRHVm?=
 =?utf-8?B?STA4WkhEcE8rcHlkOUlLZU93R3dEcThCams1ZS9DM2xXWDVDWWk3ZFc3N09W?=
 =?utf-8?B?UWd6MGhMbWtydm1lUXd1MlFST3pQNlR4UVU0d1NlWkxhVVI3cXNHVUthbS9J?=
 =?utf-8?B?TlVOb0RZTVdibG1wbVEvcE1zWEc2eFNlTlpSY0x4Mm5aQUo2OGszSW9jN0lp?=
 =?utf-8?B?RjVUaURMQndjeVh4RVVidU9EajhWRG1tWklnZlUzU2QwVk1pM1RVOHhPeHpG?=
 =?utf-8?B?MXVXMXZ0Zm9EdzJLbHVhNUlHUzBJVEdPQngzQ1RFaEREL3dFWTg4RDVaa2pJ?=
 =?utf-8?B?YXRyMlRhd1VIcVIxZVhLSE8zL0JsRkRKdjlRem9DbU02UzdsV2NZaEt3elEw?=
 =?utf-8?B?UFkyQTYxbWFnNk5La2h1aEZISnNMdUxIUWsrM2c0Z1hXcGdxUWJ6aXJ0TUlU?=
 =?utf-8?B?SnBJTjFkeEo4bkhKWStMVzhhWkhRczhGYjBITEpralMvMzRGcjNIODM5WkxM?=
 =?utf-8?B?ZGxURGZDKzRGeEFoUkRaNVVuM1l4SEUzUmIrRFJyQTExMkRDQm5lVDc0SzNI?=
 =?utf-8?B?UzRnMDZmbml4L3p3NDNUVTdrT2pvRlpKRHo0UzRnYThZbU4wbUlwbkhRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0pPSHV2dHpKa0wwVTAwYUljQ29NYzk5VDRja0RVU2pGQ3FEeUpOVU4wQUtr?=
 =?utf-8?B?azFmWXp6UTk2T2tYa0lCc3I1YUZHWWlYNFZYZmhKUnJ0OVdUNDV3UzZTeWhw?=
 =?utf-8?B?YlQ2MTlIZzRHNE9GVk16Z1orelFvZ2ptMjNqTU92TXNrR2x2bDlKejJ4L0k4?=
 =?utf-8?B?OThJWTZTd1pUYzFZYUNiTHVOUysrcVNZTVVNRFdraWFhcFZLRFdqWXZjSnk1?=
 =?utf-8?B?eUF2dzFmcThOQXVXVEFjUUc2RThpalp0YnJrYXNHYllOMWp5YmdYSmpMdjV1?=
 =?utf-8?B?MkNRWGRhb1hUNFNjei8xdTY1aEVlVElUQWozRkpCK0xxdmtwMXhHR25VdG5m?=
 =?utf-8?B?cVpER1duU1l3K3FsSGRFMG1TaUY2eXlhK00zOGR5U2cxb0VUZ1pDVURoakxh?=
 =?utf-8?B?WlY3THdTRzFIb2hnR1lYem9PK2lXQXVYYmJINnA0cGZRTnJoYWxRZmxOQm1a?=
 =?utf-8?B?dkVLRjJ0T3VUclR6ZVZzNXlCSUpINkxndVFNQkJkL0ZHU1NNaGxWUWo0bXhO?=
 =?utf-8?B?TUtHWDN4d0JQdWYvajl6NXpQdzdmTUFlY3pCaG8rQTNTeVc3OHRWbk9RVWFn?=
 =?utf-8?B?ZHFqT1dabzVtV2JxdG5iTnB1SGRyUUs2eWN5K1Y2cU9UWmJiRGsxMFhQaGZw?=
 =?utf-8?B?Z3V0aERJRkFXQVdMVVg3cDhybHdyVzB2a2ZJZ1pxVGNKTUZQbEo0bHVkTHNx?=
 =?utf-8?B?SmRDbDZWaDF4K09YQTliK3ZMWjFuQWJoSDl1RU1idUFiMWM0N2Vnai9sT2I0?=
 =?utf-8?B?SzVYNmlYeGhLM29qYmhBZi9rN2N1UVhsVm9iYnNVejJoVCthZW8zNWp4T0dk?=
 =?utf-8?B?c0pIWGtGcUtRSEdXSHJ5SkYwNFJERWd0T3Q4MjM3OXoxck1sdnlyNkxpU1BU?=
 =?utf-8?B?MHpnZHYvNFhuQjBSWFlLcjFpSEQyZkJXQkdiTEpwdzN4OUg3MWZoVi9IQ2dM?=
 =?utf-8?B?NEt1N0dPcjkva1VKYlZpVXZUOUhhU0gvakRtZHBoQWtIUEIySW9nYVZodGVj?=
 =?utf-8?B?Q1NLUmRRMGtEallnak84Skdidlh0M2FoVVdkNmRkZ3gySW1jU3djZnM2Y0ZH?=
 =?utf-8?B?SjY3ZFV6SEF3ZnF5cTlpdnllMSt3bWZmNVAzRkZsU2xrSHpRdlNEbEE1aFgr?=
 =?utf-8?B?QVpia1hEaVVXRXh0VUpCMzBqekhOeDg4MkFTdEVEdkNWblczVmZJOUF0Zklt?=
 =?utf-8?B?bWJ1M0l5S3VDTTJnMXJVbEg4UW5abWRmdnJPTmIwelJEdFJOUk9vVXlCaTJw?=
 =?utf-8?B?R0JzaHBQWkgrakpNNXp6azZ2SW1CUDJWaGcwSDdQUitkbjlEYkFxRWVvSSs0?=
 =?utf-8?B?eUgzeTUwNXNvWnM1YXlCWTFLR2NPREliZCsySVVtTy9tbXR2M05NdjBhVFlt?=
 =?utf-8?B?NU5UV1d4SmtFNGE5T2JMcTFJdFZuUnpWNUkvbzY1c0tQVEtpMXB4ck5oS2FN?=
 =?utf-8?B?QWxRWUtUNFdhZUs1QW9YZGdzdW1hZE5WM2NCS2xQZXhPL09Iam1ueGptTno0?=
 =?utf-8?B?bTRkS3lWVi9nOS9zVFJlWXBDZllDRThoYTI5SDFEandPVUsyWmdVN2NOT0xh?=
 =?utf-8?B?MHpxT1JNSDFnS09Ka2hLcHZzcFhKKzRlU285VEFlRXRnTGFCZTdFelFrTVlu?=
 =?utf-8?B?NUNsTnJMaEJzTkxXZ0ZROTFneUpDQU9KSWZvekFYRUhKUWhrR1ZFZ3JZTDZZ?=
 =?utf-8?B?RnMyRU9VY1Z5bmpBbTRnaG9HVVhUc3JhYzZQcFE1RXBUOHJkZU95anY1dDI4?=
 =?utf-8?B?RVRzaUFVa3c4RVBFem9WeVlLL3NVcTRsbFNhNzNJU3B6SFhwcDBEYVBhN3B5?=
 =?utf-8?B?SkxNVDloRHh5NGJRUlJlc3pva1ZiT0EzN3lVaHFvV1VyOUhjZldTNHRoNFA5?=
 =?utf-8?B?UzJ2YTQ3Q1RMTjI2c2hlQzFJWEN4a29jd3pOS2MrOWxsMGJXY3UyTElFYVJ5?=
 =?utf-8?B?SjVldEo4bEs0eUtnTUh0ellTSGNPL3FYZnFPR2t5YngzNWlON2dLKzA5N3hH?=
 =?utf-8?B?eGNZRTlYUnhMK2NCWnNUT2R2Z01VaUhuVXBqTkk2OWEzUFRIWkRRcEZaQ1Z6?=
 =?utf-8?B?NWlGUUMyMTRDRzVjUWFIWU9OdUlhdElDdlN3eEJaMnRBZTFYVkE2a1JZbHBB?=
 =?utf-8?Q?lsF94f1+7QuLweuhTgVGepuQz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3fd7d19-b3cc-4e1d-3282-08dc689666ea
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 21:50:36.3300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5FQR+ycGxrWlULY1gvBVyX0UBxIFwjUa2OW9ICKzFZgdZlup0dfOb1i833Ey+8Rq0xlhf7QQB5NqShrLc5lzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9096
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

On 4/29/2024 06:06, Lancelot SIX wrote:
> Instruction modifiers of the untyped vector memory buffer instructions
> (MUBUF encoded) changed in gfx940.  The slc, scc and glc modifiers have
> been replaced with sc0, sc1 and nt.
> 
> The current CWSR trap handler is written using pre-gfx940 modifier
> names, making the source incompatible with a strict gfx940 assembler.
> 
> This patch updates the cwsr_trap_handler_gfx9.s source file to be
> compatible with all gfx9 variants of the ISA.  The binary assembled code
> is unchanged (so the behaviour is unchanged as well), only the source
> representation is updated.
> 
> Signed-off-by: Lancelot SIX <lancelot.six@amd.com>
> ---
>   .../drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm | 24 ++++++++++++-------
>   1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
> index bb26338204f4..a2d597d7fb57 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
> @@ -48,6 +48,12 @@ var ACK_SQC_STORE		    =	1		    //workaround for suspected SQC store bug causing
>   var SAVE_AFTER_XNACK_ERROR	    =	1		    //workaround for TCP store failure after XNACK error when ALLOW_REPLAY=0, for debugger
>   var SINGLE_STEP_MISSED_WORKAROUND   =	(ASIC_FAMILY <= CHIP_ALDEBARAN)	//workaround for lost MODE.DEBUG_EN exception when SAVECTX raised
>   
> +#if ASIC_FAMILY < CHIP_GC_9_4_3
> +#define VMEM_MODIFIERS slc:1 glc:1
> +#else
> +#define VMEM_MODIFIERS sc0:1 nt:1
> +#endif
> +
>   /**************************************************************************/
>   /*			variables					  */
>   /**************************************************************************/
> @@ -581,7 +587,7 @@ end
>   L_SAVE_LDS_LOOP_VECTOR:
>         ds_read_b64 v[0:1], v2	//x =LDS[a], byte address
>         s_waitcnt lgkmcnt(0)
> -      buffer_store_dwordx2  v[0:1], v2, s_save_buf_rsrc0, s_save_mem_offset offen:1  glc:1  slc:1
> +      buffer_store_dwordx2  v[0:1], v2, s_save_buf_rsrc0, s_save_mem_offset VMEM_MODIFIERS offen:1
>   //	s_waitcnt vmcnt(0)
>   //	v_add_u32 v2, vcc[0:1], v2, v3
>         v_add_u32 v2, v2, v3
> @@ -979,17 +985,17 @@ L_TCP_STORE_CHECK_DONE:
>   end
>   
>   function write_4vgprs_to_mem(s_rsrc, s_mem_offset)
> -	buffer_store_dword v0, v0, s_rsrc, s_mem_offset slc:1 glc:1
> -	buffer_store_dword v1, v0, s_rsrc, s_mem_offset slc:1 glc:1  offset:256
> -	buffer_store_dword v2, v0, s_rsrc, s_mem_offset slc:1 glc:1  offset:256*2
> -	buffer_store_dword v3, v0, s_rsrc, s_mem_offset slc:1 glc:1  offset:256*3
> +	buffer_store_dword v0, v0, s_rsrc, s_mem_offset VMEM_MODIFIERS
> +	buffer_store_dword v1, v0, s_rsrc, s_mem_offset VMEM_MODIFIERS offset:256
> +	buffer_store_dword v2, v0, s_rsrc, s_mem_offset VMEM_MODIFIERS offset:256*2
> +	buffer_store_dword v3, v0, s_rsrc, s_mem_offset VMEM_MODIFIERS offset:256*3
>   end
>   
>   function read_4vgprs_from_mem(s_rsrc, s_mem_offset)
> -	buffer_load_dword v0, v0, s_rsrc, s_mem_offset slc:1 glc:1
> -	buffer_load_dword v1, v0, s_rsrc, s_mem_offset slc:1 glc:1 offset:256
> -	buffer_load_dword v2, v0, s_rsrc, s_mem_offset slc:1 glc:1 offset:256*2
> -	buffer_load_dword v3, v0, s_rsrc, s_mem_offset slc:1 glc:1 offset:256*3
> +	buffer_load_dword v0, v0, s_rsrc, s_mem_offset VMEM_MODIFIERS
> +	buffer_load_dword v1, v0, s_rsrc, s_mem_offset VMEM_MODIFIERS offset:256
> +	buffer_load_dword v2, v0, s_rsrc, s_mem_offset VMEM_MODIFIERS offset:256*2
> +	buffer_load_dword v3, v0, s_rsrc, s_mem_offset VMEM_MODIFIERS offset:256*3
>   	s_waitcnt vmcnt(0)
>   end
>   
> 
> base-commit: cf743996352e327f483dc7d66606c90276f57380

Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
