Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8DACCF9E0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Oct 2025 07:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F71910E04C;
	Mon, 27 Oct 2025 07:46:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hNmlD74s";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013026.outbound.protection.outlook.com
 [40.93.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AD6410E04C
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Oct 2025 07:46:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwoxDtwiBSLO/e39Zz3mWM81jkhXl1fUrPgqlytejNwmctWf254akJWYgFtPagVcZlAAwWG9zxsA3s6w6iIlvVVBod3LYeNynD1msp2odHsNGViBIpudMpdB1VOW1HOPDNf8Zj49ryDwpufUoZAhvK2ct9G9Q8KTk5ATMlx2IFzbZAJ9yuJzSx6w62Hjb2zuB+z6OwoBiM7sfu8wKlyOwdVMH8rnfh5bU2WF6r6vOTAdlp8Fk8l+49kp+CBfJ7ZzPjrTXn7SFFrL5t5PEBB8r4beYQQlr+Y/X7bk7lqg3KpSH6iuYLkSyF0d+yb6VMtIm9/ymTkKv/k/Hao5ngkx3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T509m5nKD3X4EufSECERy6eoSuqLICUi+HM2nnY6IHk=;
 b=pzoV2xkIO94A+S9v9gj+ddqQTCe2bCf7JQ71KU35tkHrIebWJKK+6vIuJWCJFNQtEPYJIfRmG2X3WmBBRYTlJQGV4f4Rh6vKCqG08tlNazKRBcdct5ekw59Qgw5uR6uCv6CwWvvNtEIKz/ImgDFkfJdLOwoSefUjoP9C7YVoQvypK5erSPejY3YqK9alxMESjLs2HC2C+Ohm/4FlMZXUmJpcvcZXsf6AgbKbgviN6KlJiwZcJaS4jZpJ0xipyTE6sPcWkyZnb0jhDHB3hsQk1nXMeXxCvh8tDGq3KAbTlKW3UpO/hPar9aMb2v+fOdB+f8i/whaiaIf+QG59aU5OaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T509m5nKD3X4EufSECERy6eoSuqLICUi+HM2nnY6IHk=;
 b=hNmlD74sb2XTWLMLj0h5V8Q8ix32rJ66UwOWMLKCGtb4IzY53t/nOj+sJNb9fUQx6SLueGf9+pbSzoxfyqX1bRSiZxahPpu9EdTXMhwbm792AkZkjcbg0Wh2lvIvmQxedgUuaN+JLc4QnYLQqjWhGO73jgJeYhb3c02bfY3WbGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB7455.namprd12.prod.outlook.com (2603:10b6:510:20e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.17; Mon, 27 Oct 2025 07:46:06 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 07:46:06 +0000
Message-ID: <46213d03-25e7-4c29-82b8-2c078990f524@amd.com>
Date: Mon, 27 Oct 2025 13:16:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Fix incomplete null pointer issue for smu
 v13.0.6
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, alexander.deucher@amd.com, asad.kamal@amd.com
References: <20251027072757.1267995-1-kevinyang.wang@amd.com>
 <fc5a13a8-12aa-46c9-a660-12ea7e99b3b4@amd.com>
Content-Language: en-US
In-Reply-To: <fc5a13a8-12aa-46c9-a660-12ea7e99b3b4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ae::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a871709-b855-4733-434d-08de152ce2c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTBnQ3h3V2ZQWkIvZnBoTDNaYWlYeVJnQ2pvcWMvZG5IdmFZL0lBZEJkQ05C?=
 =?utf-8?B?L29vd2s1ZFNXTnZ5MlFEcEhnVHVmcTRyckFCOU9MZXVWNlBGRmdaaUkrZFJl?=
 =?utf-8?B?REU4bVdGWURMNXRGbTBjdlRYck1ieTlHMlo0L0Y0QVhMRFdkV25mSmlDcjJ5?=
 =?utf-8?B?aFl5ZU1CeWhJRER3Y3BMcDBwdzRtSnpvWEhMR2U1SVZKM0M1T3hIM3hkdUhi?=
 =?utf-8?B?aVAwMFpINGpPemxhekZEOE1GMFM4cHlnWk9UOFJIcFdkczNzMW51WWdVbDd0?=
 =?utf-8?B?YTlzYVBlbTFrTE5VbzdxOUdNelVUVHRuMjlXMytUaXJkNHN3aGFVZHB5cjB4?=
 =?utf-8?B?Y0IwaDY4aVNzTjArellUWldrQy9vK3NLRDk2SEVDc0NoaWZ1Yzc5bWV2Q0pa?=
 =?utf-8?B?azBHM0FsK2dzZExSazREaDgxQU9hMnJkekVhVWVhbUZIMUlNNisyQUIzQjA0?=
 =?utf-8?B?a3BGcm80WHVzbjdsdFcvTzBvVTVSMDhKb3Zaa1NUeGJ3NDB2WEdYelJqQzZv?=
 =?utf-8?B?cm9rMHlucjVYOEFtYldrWGJXY0M5UldVVUNGUGljZHVwa3VpNHAyaTdORlI4?=
 =?utf-8?B?V0J2OHN4UThhUmhlZkprSHR5SzVvYU5CL0V1cE1maTkxelJBRDRicHB0dDZS?=
 =?utf-8?B?R1FhRnlEQ3NuV3loZ1ByQ3plbGxLNlp0VlFkMkxXakNsRGFOdE9wZnRROTND?=
 =?utf-8?B?blBkR21XZFZzL2FPNHZKcjZOTG9XMnRaR204RTRiMlNWN3MrT0lNU3pJdUZB?=
 =?utf-8?B?cmhOMCtET2gvQ1JrNVRFMUgzK1ZWMUdEdXVBUDZJVldIQjBTSlVMNm5IdnBU?=
 =?utf-8?B?TDhwWG4yWkkvbW9QLzRvY0Z3eEtzNEV2RFplcmtwSUdqbnpmSU9ESFpiTExn?=
 =?utf-8?B?dUVoR0c5NGZxZEtpZ09EZW9kNW40bmZrekZ4OGZ1Yk5YZ0ZXNm5aeURWMWNo?=
 =?utf-8?B?VGxWUVV4V3ErQUl3aG9IKzY2cUQ4TnRnUmo1eklUTlNjMU5Ga2NKb21Oakpw?=
 =?utf-8?B?NEI2YjQzY01Td1BRR0M4azk0V3pQWUUzdmF1ZUt1Rm12ZW5YNFYyK3E5REFo?=
 =?utf-8?B?enpYWlFHTFI3ZHorcUh6djd4NlF3OGNTU1BqMnZvOGJPWGJld3ZwWXN4MFhV?=
 =?utf-8?B?elloOTE4NXRMelFLSkx6Qkk3OFd2TVdZQXFLRE5WbnVtVThGM1JhbFlHa0pi?=
 =?utf-8?B?V0FlNFo2dDlMRHlud0VRRUlmU1ZPRGZzblJyRmhMd1hMNHo3SmZIdlBBWTVZ?=
 =?utf-8?B?VFlvRWVKL01oU2RrR2FpRFlqRTB3TXllZy9Ca3dPVSt2MENHb2dWQ05lSVF5?=
 =?utf-8?B?QnJ2N0NwUFRxYnY1ZHFDNEVxRFlwVE92V1F0SloxV2VFL1NaMEFPNmdUcVFI?=
 =?utf-8?B?ZTVoenAyUEFLdDJqTTgwd1BmNmhoVUhKdk5Ed0NmZXBLTUpOaEw2UnJ0NUJm?=
 =?utf-8?B?ZGZrRW5yRm4vb3FUMU0zUSs3ODlFc2JCbzBWbW1hWW95Q1RobkZoaDg2bUhw?=
 =?utf-8?B?V0ErcURvMjkxazVpVzFld2NFclljS2NaaHpkQzZEb1hqckdSK2NDb2J2Z3Vq?=
 =?utf-8?B?amJwaVNnU0FUSFlxZGJmTzY4d0g1NC9nbjZnQ21qUmFIYzlSVmVjVkkvNlpt?=
 =?utf-8?B?U0d0MUYwRVNtMGNhbjcrSmRWZnZrbHlESDVNQWUvWWE4T2RFdjYzOE1xbUJM?=
 =?utf-8?B?OW4rUkMvVWFiQWJQODlKZFRLR21KS3lEZkpGMGpDbGZ6NFppSFdvQkc4UUl5?=
 =?utf-8?B?Y05OaDcrVzRIZE9scVBKRTVOVnAzNTB5RnFNUWFCL3g3STlLcnNManh6OHdJ?=
 =?utf-8?B?eEVnZllEN1BVcnVNNWdGL2g3ZkNNeXBoK3Q3d2d5OGcxeDBPd1NKYVdjRkt5?=
 =?utf-8?B?Q3JQZGR1YVJra2lwT3lyeDFCVCtnUTh5NGw0SEhjWTZnSloxTVVLVitsajBn?=
 =?utf-8?Q?412i5MhRlgJPdGT9svuYv41jw25OjXTG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUVMODF6empyVW4xMEF6VXp0VXR1Z3IrZ2VmQ1gzZ2NXOUsvZll2WUFPVnE3?=
 =?utf-8?B?YmhoLzUybEgzVENCYjhYZHIyZElrcWFTNTB5WDhOd094VUpiRTdONkFnVU5m?=
 =?utf-8?B?akVOVGY1QjVBa3ZjNUpXcUZRNElHWldwYmtENWlvVm42REtjMkpTUFNwcjZi?=
 =?utf-8?B?TURoVHYyYktuQUpGWEc0RFZVT0lkcEVheTVaQXBValNDaTBvRVBPZzFaUVFS?=
 =?utf-8?B?bWpqWDFXV3liVHFuczJUeG5QRnZqaExkY2dJRHJsVEQrN2RFcENEZFVEcGw3?=
 =?utf-8?B?YmdXVlJid2lITHNrWmoramNGWmllYXZVUzZhZ3krbm9ZbkxIYzA5dHpERHcz?=
 =?utf-8?B?aXhCSGkzVnI2RWwyc3F3TTZmcnArQWxyUEVESHhOUmswSzJrL3k0Qk00azVq?=
 =?utf-8?B?YlJtQi92ZjRhTkRxelkwQkFSU3pXZkMvbXlDOHEwbVFPSzVhMVdvN25wbDdm?=
 =?utf-8?B?Mmc0TU5IRDJxVWh2UXN3cWtHNzF4UTV1ZEZJeFRDOVZWclFxampGNjRtUmIy?=
 =?utf-8?B?dFhiZzhHSjdXWGcyMHo3N1R1bGRWbU5SZFJCS1E2c2tYWDMxNWxKakdqeXpW?=
 =?utf-8?B?Q3JCTFFUYmQvVnFJd2RmVTNuWjY0aUNhSEJSdlZVai9EVzZmZEd2OGlHYnhL?=
 =?utf-8?B?WXViTEFsb2R5b0lBOE1wSVQxdjFHNkVvbFVrWVJJU242Y1BTSE1ldHlkbXNJ?=
 =?utf-8?B?anBuajg2enA0dk9xZzgxM2tIbnlTL1prOUtvek5jOUU4ZkdiVzl3NFZwS1pv?=
 =?utf-8?B?WEdSR1d2Umh0WHl2b1hqL0xndlQ4NlI1bndsZEh5OHVGTzRBMXpWUTNvRys5?=
 =?utf-8?B?VWc3Tndram1icVVoM1VGd3BORy9TSkE5bTJaTFVaYXVBTTArSEo0YXhSQWlx?=
 =?utf-8?B?TWZzeEc1QnVkbUNPRGFPZWYrU0ovZnByZktXK3NXWERXMkFMV2ZidmdBY1ox?=
 =?utf-8?B?VUFhekR0dmFoT2NidHkrazNqdExFYmkwUG0xZXlwM3ZId2dCWTJ1MUxSdlFz?=
 =?utf-8?B?dEJWQXBvbEdWV3lBcjV5TTZwcGVIc0ZqcUEwVW9RdmRSdStUSTRwUkQ5QXBB?=
 =?utf-8?B?d0E1Mno3N1J0dERMTEFzN1U0WVQrVVRQcnFFdmV5MWlZK1g2aU1PQU9QNVpO?=
 =?utf-8?B?bnpKUXRUeDM3TWZEOGhORFY5UFlud2k2QlpJb05LdFF0NEhERHdxK01FbWIz?=
 =?utf-8?B?ckgvSVFaVCtWMmN6d2R5VUF4TEJ4aE51eHo0TlJBMTROYURUWTlxemVHMDA3?=
 =?utf-8?B?UGh3QUYwYmRGZWFaM2lFV1ZIc0FXeWxDb2xKS1VodVdsRGU2OXFYK2ZKZkRK?=
 =?utf-8?B?WTVzU0NoL1h6VzYzaWdYSnpCVFFyS0FwTXdJcGNSQVdGdCtTVElwdjMrZDMw?=
 =?utf-8?B?MG9DM2huUzBkSE1HOVlkdFQ2T3ZjL2dZU2JaZld5Z0xyRm5DdEYxQTlvRkFE?=
 =?utf-8?B?NlkwL3djRi9PUFdOaXhFQWo5SW4yT0lLTTZLWG5Qc1VvT3E0RVBjMHE3UjMz?=
 =?utf-8?B?SGJ1MUdWTDRHejRaR0tEQVN3L0Q2U0xJK0lZZkJWRWVKZXcyZDVQOHJ3VG1O?=
 =?utf-8?B?SkdndE1Na0Rjd3NRQXZFOWFNb2diL3BjWm5ZY1MyZG1mTWRPMDhRNm5vWmxm?=
 =?utf-8?B?ZFVVSTJtVUlFZ0ZkQldTcWtYY0hjSUhDeFdYSU03azdQMVFYd2gzK291TE9V?=
 =?utf-8?B?UHMzYkpndmdMYkRjbmdjU2hWeWd2L1l0U2tOclREczJrTjRlM1dkRzRnZllp?=
 =?utf-8?B?UkVRWm9kVG9EWEJDT3ZZMzBSSDkxM3dHNEVqbyt0L2QweWswUUlQeXJjK3c0?=
 =?utf-8?B?L04ybVN1ZlhsVUI2UDIrZDQwN3pvQzJQMmhUZHdMemY3YzVjQTNsVEprbVVB?=
 =?utf-8?B?TjdzNTBLZlJaMGMzSjZLeUNwSHFxUy84T0Q0dk91bjFvaVZLMjJKNVVFMTAw?=
 =?utf-8?B?ZjVnOUZYLzFGVm56RWlWRlBHMFozU1JudVFNcnBkejJ3S0FTZ0p5Q1plUTB0?=
 =?utf-8?B?NVkwbktwT0E0V0pvK3JyQ0FTa3hEdTZRYStIeXExTmkrM0JyeHJWOW80TVhv?=
 =?utf-8?B?RjN3VWFpUXV3RDJoTW81eUhicVZ1dDVvTS9WVU9NWUgySjEwR1Z0TU82YXRr?=
 =?utf-8?Q?UwTqNWP5B+1cCPVN0H4ka2h+G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a871709-b855-4733-434d-08de152ce2c3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 07:46:06.4517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RzdGiBFVNBEQTdXf7iimU/iZOntZsq15ZRr6zQqYh4BWKRp/eEluck/GURRV9UzM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7455
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



On 10/27/2025 1:13 PM, Lazar, Lijo wrote:
> 
> 
> On 10/27/2025 12:57 PM, Yang Wang wrote:
>> the smu v13.0.6 driver should handle return value of 
>> smu_v13_0_6_print_clks()
>> to avoid null pointer issue.
>>
>> Fixes: 0354cd650daa ("drm/amd/pm: Avoid writing nulls into 
>> `pp_od_clk_voltage`")
>>
>> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
>> ---
>>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 41 ++++++++++++++-----
>>   1 file changed, 31 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/ 
>> drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> index 39ae6701147c..22fe4d3508fd 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> @@ -1514,9 +1514,14 @@ static int smu_v13_0_6_print_clk_levels(struct 
>> smu_context *smu,
>>           single_dpm_table = &(dpm_context->dpm_tables.uclk_table);
>> -        return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
>> -                          now, "mclk");
>> +        ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
>> +                         now, "mclk");
> 
> Probably the fix needs to be in smu_v13_0_6_print_clks?
> 
> 
>                          size += sysfs_emit_at(buf, size, "%d: %uMhz 
> %s\n", i,
>                                                clk1, (level == i) ? 
> "*" : "");
> 
> 'size += to size =' so that it returns only the total size emitted by 
> the function.
> 

Never mind, this is not going to work. The function may return the total 
size it emitted, or it also needs to adjust the below condition.

Thanks,
Lijo

> That is the case for this condition now -
> 
> if (curr_clk < SMU_13_0_6_DSCLK_THRESHOLD)
> 
> Thanks,
> Lijo
> 
>> +        if (ret < 0)
>> +            return ret;
>> +
>> +        size += ret;
>> +        break;
>>       case SMU_SOCCLK:
>>           ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, 
>> SMU_SOCCLK,
>>                                   &now);
>> @@ -1528,9 +1533,13 @@ static int smu_v13_0_6_print_clk_levels(struct 
>> smu_context *smu,
>>           single_dpm_table = &(dpm_context->dpm_tables.soc_table);
>> -        return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
>> -                          now, "socclk");
>> +        ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
>> +                         now, "socclk");
>> +        if (ret < 0)
>> +            return ret;
>> +        size += ret;
>> +        break;
>>       case SMU_FCLK:
>>           ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_FCLK,
>>                                   &now);
>> @@ -1542,9 +1551,13 @@ static int smu_v13_0_6_print_clk_levels(struct 
>> smu_context *smu,
>>           single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
>> -        return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
>> -                          now, "fclk");
>> +        ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
>> +                         now, "fclk");
>> +        if (ret < 0)
>> +            return ret;
>> +        size += ret;
>> +        break;
>>       case SMU_VCLK:
>>           ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_VCLK,
>>                                   &now);
>> @@ -1556,9 +1569,13 @@ static int smu_v13_0_6_print_clk_levels(struct 
>> smu_context *smu,
>>           single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
>> -        return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
>> -                          now, "vclk");
>> +        ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
>> +                         now, "vclk");
>> +        if (ret < 0)
>> +            return ret;
>> +        size += ret;
>> +        break;
>>       case SMU_DCLK:
>>           ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_DCLK,
>>                                      &now);
>> @@ -1570,9 +1587,13 @@ static int smu_v13_0_6_print_clk_levels(struct 
>> smu_context *smu,
>>           single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
>> -        return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
>> -                          now, "dclk");
>> +        ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
>> +                         now, "dclk");
>> +        if (ret < 0)
>> +            return ret;
>> +        size += ret;
>> +        break;
>>       default:
>>           break;
>>       }
> 

