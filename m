Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441E2CD1292
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Apr 2024 13:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBB4B10EB82;
	Mon,  1 Apr 2024 13:53:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kVshkPT0";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2118.outbound.protection.outlook.com [40.107.243.118])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3035D10EB82
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Apr 2024 13:53:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F83Gn2sWVjhF1+pvaaR3JWIXF5/9CHx0XNGGWokCLVlW/CRjGs1niJScuTYz7V3rk50RQR9ZLXSiMsrPxcqzcbhfAiy0m8I7LXHpELfHGqaaBlvNqke5+wdClDaqotbnZofsD32TjMgpvwivL40nzqErXgspfnEzjDe4lEsO4GXoTFQvGiyIQ9L0CJFWmLSllpyEQz/QU7sy6lI0LgPzCMrGmf4AAe1fSxqvHQL8uX9mc1oEGvAlAYmcqjNRc47kVnloF95ORLtKSlim7SDfNe2+6KDB3iujOy/ONjBnzlyVa0ocykyOt491s+UZ5jNqTrhNMEhcvxKjH9vautPmmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcYCljYLJxYbpJLc4sZA2Bq79NGCdYCNXr/j5hU6vL8=;
 b=g0oto2bJ2OEIvSazfLYvN9zVyJIcUIsOofGlO9xw3gjdRtA7VHxe1YttGylfGJBhIp6pB34SkHWhaOfq20mD/pbJVeL7X/OJhxgbh/lEZ2Mn0P3KgdYlhn8UHoZqTYdhv1TAtSXcXzvS6J1/BTVrKu3kZMHLMwR5YsFga09Z/Q2VXLr+0rLTFfR+5uTYW75SoTk6lzWy4KKO/5n3AT1IoSAsTbOipMAFe23NVacWnr6rr0/e7S1UBHHxB41JZoPsE+snchgj8oUCU0KCkUIzk6TukLeqi8jNrT0NasH5GN50Hsfv+Dz3zhXA5ZYX8guqoJtiEXO2GXyFcc5jbS8Few==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcYCljYLJxYbpJLc4sZA2Bq79NGCdYCNXr/j5hU6vL8=;
 b=kVshkPT0cNFIrzGrj3wh6+g/M1hmb+ylo7wFt97njpKqzhCQzfBQDKS2huSE1JKZMlq/j4zzdGlnqaz2qBhW+kGYSMop3JbC+DFI1TiaeTwaD1jPd2OOa5LrF4FRXy3lkkqr0UR7n2VF8qjemDQlIyz8nrzARNp0ZF/OpyPkOsc=
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DS0PR12MB9423.namprd12.prod.outlook.com (2603:10b6:8:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 13:53:03 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::8d12:60ee:8dfb:daef]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::8d12:60ee:8dfb:daef%4]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 13:53:03 +0000
Message-ID: <67196ec6-52ed-4583-8e27-2327b8c9acd2@amd.com>
Date: Mon, 1 Apr 2024 09:52:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/43] drm/amd/display: Enable cur_rom_en even if cursor
 degamma is not enabled
To: Melissa Wen <mwen@igalia.com>, Roman.Li@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: Daniel Wheeler <daniel.wheeler@amd.com>, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 solomon.chiu@amd.com, agustin.gutierrez@amd.com, hamza.mahfooz@amd.com
References: <20240328195047.2843715-1-Roman.Li@amd.com>
 <20240328195047.2843715-31-Roman.Li@amd.com>
 <e39bd7f4-827a-44cf-8759-f6967ee24f49@igalia.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <e39bd7f4-827a-44cf-8759-f6967ee24f49@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXP288CA0010.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::25) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DS0PR12MB9423:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: joc1UORlINu+XHDG5n6avMzNELdhnz3PSrAs/NbPxa4UhCcGcZGAze2hFyTOzt/xWBCKzEy1FR594AjJNISgUYaK49qNsF7AZwrRvoqeO7AyC1z03p74U0hbo3l1khpnowJtyNw97TnPegQvnfdektR04tcaNUopram1QBMEtonkfpIRIwrVSgs2cx/FIkWa6SBqDK0/k++47mgw8fFw4W7N/8xhOlq3JwxBbDSrhqeq80hKRCjb++p8HtzQrAmQTdyFmN6TIcLUQmATk8L5hK+4Ukww6KAqpGutnp2zykj8jJGek1OBQ21vSZD1NLENYsNjMr8/n8sXAkCtx13EYXHW8h8eulNUEEZFCJj0BX/CD6P8BuQO4JzJkq5XAlE/I9TUNp6tCYWxDFotLQRTbJvOj1Jr7SylsHyIqu3ps8L3cb5ab9SfJU6NyTBllSDpYOvtaDzROErsCTSVVSHznOy5j3YWm+y882aoJoDuhio5N6+lfbzlKYfJ6zfhKIDdYmVgC64xfeyKFdwwr0txO97jo9F4mGObGjg98aGBqlczc1L+f3QfdBBZVXREpjBQ9C3ve1wvdr/NmlEki0hRoLVM+j4CDX5oeJPjXDL8KyxEeNKze2nFVNXe8MS21tSI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0pyelhIT0pyNC9QZEFGTHpqdWlibWdPZE84MVp1cnpHQ1o3SXRJeWpoSXgy?=
 =?utf-8?B?eDM2K3RHMEdGMVJGMUJJVDZKYlV3UEgrRDlSRm5lK25xeVdZdy82bFZKSElT?=
 =?utf-8?B?UzEyK0JBaUY4MWJkV1hUcVJYUmpWSFRxL3F5OCtqbW1FTzNqV2pFL1VIWEVh?=
 =?utf-8?B?OWRHR2gvOXBjOUFkV2NNK1ZUSDlKWGFDT0x1YzlZcE5XclUzenpIWld4dXQz?=
 =?utf-8?B?T3VhTko2UnBGQzBXdWpLdEJXTU9RYTMvUkc1dVVlcGlvRFdSaGYzck1haXBH?=
 =?utf-8?B?cEVGVUF4WFAyV3RGSm1kczJEdmRDWDVKUlFSNzVETllDM3hzbXI2aWUxbHBF?=
 =?utf-8?B?a3BiK2gyeFYxRFQrOWNjT3lWNE5TMXI1RTlWcldJbU0xMXlCdVlFN3pvUE5I?=
 =?utf-8?B?dnR2VkxFbmcycFF1dmZMMFRqWXdmZk1GSVYzM3pTVE9TQjhxamNmbzgzUU84?=
 =?utf-8?B?NUJHMTNBbHlDVUhReVZMc3NWajhsNWhnck90SlRnMWo0WU5BNzZldklHeis3?=
 =?utf-8?B?MUNVWU1ENmV1S28zMytGKzRZejJXNTBsYVZRZ3NNdUtNT09FUGU4dTAyR2xp?=
 =?utf-8?B?TlR5c1BZalRwWERTZ25JNDEwellSclROZGo1Z24wQ2EvaE0xcDNibG5GcEZk?=
 =?utf-8?B?bE43T1J6dEVJWjdxU1NjdER2amVLWDRmZW8yZEUwL09SL3dGbm10YllJWU9E?=
 =?utf-8?B?b21nTmRudHVnSjcyNUJRWkk0bkk4Vmw2cXUzaE9wQ0F6MTBqaUd1TEVkZWdV?=
 =?utf-8?B?TmFjNnBtNmg2dFdNOHZ0ckNERUtla29keDJiS3JLbUVMTWZjOVRnZkUybnpE?=
 =?utf-8?B?RGpYUWhWVlhJaUY5NUtpTDkvbjV4dVdkckJoSzV3a3hBSEovckhLWTJSbXkx?=
 =?utf-8?B?Tzg2ZjluN1M4U0dPNTRDRU5UL2xpak1WQTdkdDBNQ25XYVlIL09iQlIyOXpI?=
 =?utf-8?B?Z1I0aVlxakdHckJvek1IZXdDVE1iOS9QY2tQaUovVW9Nd1krd2tPOTNnKzAr?=
 =?utf-8?B?QVRLZ0c2MVdCQllmQmZXYXlhSU90ZmFYKzM2dWtYcjVGY1VwRzZsVkZiVnRK?=
 =?utf-8?B?ZDRoMVBVZUZ1MlV0aXJCcmFLUFJvNjNpRnpGVnJNTUZCN0p5Y2loUnE1Zy9q?=
 =?utf-8?B?Z3NJYXdBOE9CR2VGZVByNm52TVBVTkdFekZTbHRJWjVodlg1MW9VbDRJaDJx?=
 =?utf-8?B?M2VCN1dKZythcnFVMW5NRGplc3JPZW5CWGFaMXU0bFgxVnZicVZkSzh4N2hz?=
 =?utf-8?B?b1FRSkZCb1BlcFhkNDVOVUdWNEZEZ211YW1OWE9TaG9yKzhod0FQK3pnN3Q3?=
 =?utf-8?B?UjNCL05FNy9VSENrOVA0QjJQSUovSXdJMWV4VjVGUlFiMDVkRW1EaE9mNGFY?=
 =?utf-8?B?UXNpTFJkaE5wK1R6ZFowMGlZNnVPdzV0b3RGRU1CQ0lKdGVMYUIzQmlmM1Nu?=
 =?utf-8?B?ZFN0Rkl5aU8veVlqT2xUS1dINWM0VXJRWkR4Q0pWSjBacUFhQVdRRkdTTURR?=
 =?utf-8?B?WGNvYlVmMUtaaldjWkxGME9QelFBa05walJIYUxkQjJ4NFJBZWliMDVOQ1Vw?=
 =?utf-8?B?VUVJVGhHcXNUbEIwL0s2SDFRT3liZ0czSzhxemtQdzlYcitvMG9icGcyakxp?=
 =?utf-8?B?WTRCcFNoSW5HMExOcm03eXVZSXpmS0s2a2J0TjAvcVVrSXZtVEF0VU5RSjJu?=
 =?utf-8?B?cUFvdmVIUFZHZUYyVk1RR2lJd3RqbWlKRWVNTk1PVG1xU05jcjIzdFRESHJG?=
 =?utf-8?B?M3pNVC9oM05HdmFCRXRZTkRYMGdYN202K0JEdTFYSkJ4TkVUeWQ3UHpnampJ?=
 =?utf-8?B?dmxDMTVualpWZmxZRFpNVHZvTWZIUmpQRGRtZHlkRS8ycC84YXVxUVJlUUl2?=
 =?utf-8?B?RFVKNFlCd1pFNnBTdHZ2STZVditjZ2hvVVFXRnZDVi9iUFl5a3hqdEJJOFV4?=
 =?utf-8?B?MWJGdlBKdjFZdWFWR2lsWVQyeGJrSTF3WGRkL1REbDdudnIyR1Z5dkdOUHNK?=
 =?utf-8?B?ZkxIVU5OVXp2alM2cG9MSlphWXNSVVFhdktZWXMwOTk3UWdnSGkzSUNIRHdC?=
 =?utf-8?B?Z0lCc1pWSDFRdzdQUzhkcGJXb1pmTk5Cb09mTTVhdDR4R0pwZjZkcndTb0dX?=
 =?utf-8?Q?Rdu/EERVdOFOuNegKmBuU2asI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ec84c2-0302-417d-c686-08dc52530cc9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 13:53:03.2231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJmLNaZU4ekxrlCfzy+N/oNvamNo38JiRDHjVa8CCGrbrlhpdrZSpIXcppaGbVQHc5NH5TDgPyjBse9pqc32Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9423
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



On 2024-04-01 09:40, Melissa Wen wrote:
> 
> 
> On 28/03/2024 16:50, Roman.Li@amd.com wrote:
>> From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Where is the commit description. Why is this needed? What is this fixing?

Like Melissa said, this might cause a regression.

Harry

>>
>> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
>> index f8c0cee34080..ed1e2f65f5b5 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
>> @@ -395,9 +395,7 @@ void dpp3_set_cursor_attributes(
>>         if (color_format == CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA ||
>>           color_format == CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA) {
>> -        if (cursor_attributes->attribute_flags.bits.ENABLE_CURSOR_DEGAMMA) {
>> -            cur_rom_en = 1;
>> -        }
>> +        cur_rom_en = 1;
> ugh. At first glance, I think it will cause a regression with legacy gamma.
> 
> For references:
> - https://gitlab.freedesktop.org/drm/amd/-/issues/1513
> - https://lore.kernel.org/amd-gfx/20230731083505.1500965-1-mwen@igalia.com/
> - https://lore.kernel.org/amd-gfx/20230824133810.10627-1-mwen@igalia.com/
> 
> BR,
> 
> Melissa
>>       }
>>         REG_UPDATE_3(CURSOR0_CONTROL,
> 

