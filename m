Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72130C43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 18:09:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F064910EEB3;
	Tue,  7 Jul 2026 18:09:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jnjEhwbp";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012042.outbound.protection.outlook.com [52.101.53.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B59DD10EE9F
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 18:09:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHONpn4jA0nArhMrUqHDHKQHn1DRP6uZQAUKbCsZ0eObJLYTqtnGZmiX+DVXyo9vZmkacKtRMkjZx74QtjHYqDfuBEd+wj/iKy/iHCSsHtUkwWL989cNBedgm77MPf0lCbK1kTHZ8PCnxbYBWoSQIQnAHwgqUQoSx+jZbjm5XCerkm6zyLjwOprdnoLqG5nCPw6HarwmPxT26o08jlWFJa9TzOr+/c3M0rX+mnxL30Fj25OtWaefiIxwL2hbsy6UHG9VMMaGJJila7ULWtDM9V1KF9UfTTE3EdRIbA4mWRypPrpUw4Smqp8Z+/m9nWmJVM/n33nyHPPnh5dUE2FvUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PrAcVZWtFhkzr+Zb87+kXkLhmz9iCTHkSE4ECTO3sc=;
 b=EUclW+60sxJqwu42L+AgJvogiYDDBTEfxRT0XXiMm9hDrju8TZrLiFROdcOBayPlM33JKCsiR8Da3xArPFp9Rmoh1Cb6zrnUy0jjjl1atO6lOma4NE2t4KHVZFCVZKlNfrGAChUj3PzsUGvtUJ26juBlWkLg9+lpXpt2Do0szsxwDG7zHlLMLMwDxqQs2TIHSRv+gyVnvtLtziXNfNrkVV5uMWmxiD8YEhLf6+oFckvKvDLXwhMKmdlJh7NFlXX2W8xUg/jFmhtKJ7T5mUE3SIpyBupYCN7y8+9ImfNWKbV5a7dtSSL+hpn0GnYXELYL6Xb7yeVYT405Rp7s7VzzUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PrAcVZWtFhkzr+Zb87+kXkLhmz9iCTHkSE4ECTO3sc=;
 b=jnjEhwbpmGfUfKOtzksQJJUAO6gFzHF7TcojbwV1BqSHMtWu5MDWYoNiQSFLL+PBiuj9Tde69q5Lrzo53gay7AfkFPACHExQbrv2r7ZzznvSkKuitjZBVixXVdS3f6LNyzF+OiM0k5VX4utNgberfG8NxInBCHJeYyi+2zCToAw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by CH1PR12MB9671.namprd12.prod.outlook.com (2603:10b6:610:2b0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 18:09:12 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74%3]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 18:09:12 +0000
Content-Type: multipart/alternative;
 boundary="------------EV06tSqjijSUcwX0v8M0nWE9"
Message-ID: <746bac9a-4d47-4d55-bb61-5c0e3c39e7ff@amd.com>
Date: Tue, 7 Jul 2026 14:09:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gx12.1: Add ip dump support
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260618204550.753250-1-alexander.deucher@amd.com>
 <CADnq5_Pn732-q2h0jcXcRErbjO=dtwsOfVgZE_qCT3-xCW24BA@mail.gmail.com>
 <CADnq5_NWbd3DCNU_LA9WDdZKJOLT+bSRBiaUwmrHVo5GVNGfyg@mail.gmail.com>
 <c16e8451-5d2c-4a36-93ab-a345739c3a1c@amd.com>
 <CADnq5_OOhwAjhp2ps+Arw=cnrmP4zgMeWtX79L0wam=SbSiitA@mail.gmail.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <CADnq5_OOhwAjhp2ps+Arw=cnrmP4zgMeWtX79L0wam=SbSiitA@mail.gmail.com>
X-ClientProxiedBy: YT3PR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::15) To BL3PR12MB6425.namprd12.prod.outlook.com
 (2603:10b6:208:3b4::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6425:EE_|CH1PR12MB9671:EE_
X-MS-Office365-Filtering-Correlation-Id: a28cc3f6-bd5d-4cca-663f-08dedc52d8d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|4143699003|6133799003|8096899003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 8qhfaKu3XHbxZzX6FeHgVNy29U3nYkILiaBYVLtx5lSuXkbLUhVajQbnJIWSgqcv4kqxwarcQukWzzzJqPPcZz18mMera6b8VZhYc2zQ65aawZtdfSI/q+jhJ9bRcv3LN0JA71+UgZV1vPXKe/TqKlG8D+s14MFMnGgb1GycYgnP7HGXq5rGXrs0veBa3fzH0tEE+BINDl8uA1zP7zCjkw333cM+wau8EtkL/JVyo1JSbqWmF1K3cBg+laD7XjXp4oR391RcqtQqLuysBcFfu5KvyBM/kpllcRZnD8JytLntDf5XlGHbcZ0GR4OY8OJIjvCvUMHMajBS69llb3j4heFfVREPvPzZoU24v61vr7BfiWj/82Tl9GvdoYun3gHO02wAaEbqRgj40sGFxS5W0SJWybmK69zlwJi49rLOBPJ0OEV74rgU0pfxARQ2uQA2s1AuxhjmbtRpAcJsJc8Iyb73at7nWSl8FkRf+1eP69NOxJUm5/Nepng0lhndu+PVZgmM63HeqAscFV/iIlOPvrCqTHFWd2/iwZgvr1kqr5q/yrx78bWVFc/Nbrp+qOLjLGy9zOmV17LGqNd6Z2KnreyeHMHydktaKepxsZxXSgNc3YdB58amtgPxMKVZ/BHgTzyJZPryXYab6JRTjSzuh5IpZ9k6ggCj9BvyJ2Kosnk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(4143699003)(6133799003)(8096899003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1BrbDI2MVhxUkloVklWR3dER1M4QlY5dHFTd0JBMjlsbTVncWovVHZsRjVw?=
 =?utf-8?B?SDdabGhVZWtFNFI1NjVkVFprYThSVGdvOFlURXR5dVNYb1FSLzBpOUQ4dWEw?=
 =?utf-8?B?YlJXNWIycFVPdEh0ZytPRVJIWXVXdTFKeXBwSTJPTERCbmRpYUMxM0tCQ0pB?=
 =?utf-8?B?Zjc4VzFwZFRKUGdzL1Rmd3JDUndJdE5vek5zYUVodVQ4LzEycXNsYjJEU203?=
 =?utf-8?B?aHhvempncUNNTkE0VDcvZWVVMTBIcFpUWWpvNllYeTEyTVR6V08xQWtVNzk1?=
 =?utf-8?B?SUQxcGlHR0R3YllRRGNGUG1ISFd4T2o3VTZjQmtGREJMaXpLU1U0NmN4Tld0?=
 =?utf-8?B?M1RNL3lkem5xVFFmN2NwTitkbFUzNWVIRUZjNHVZOVMvdDlIbWExMnlBcElS?=
 =?utf-8?B?a1ZOalBjZUQwSFR5L2tPY1JKYjR5b0Q3WHUzY0xJWjAxTmxTOHJPOHVFcXpm?=
 =?utf-8?B?UnlveVBEWnBkbXk4OXo2cHBsbk82djZYOUlKQm40Sk9FZzZjS1ZEcDYycWo4?=
 =?utf-8?B?bHI1MDdKOTEwbG9DWGk3N0E0L29Cdm80MERTeTlXblE4dVJCZlRCSHJEdUlr?=
 =?utf-8?B?U2NrRmRnK0pJSlRuMWNFV3E1Q3U4OTN4dlBrSEJuTGFwYU1GV1FKWHg1V0Q4?=
 =?utf-8?B?RDVTVjhYcHpibVBnb05USVdZR3RKQzNKQVVzSVlvOEMwaDlQTlIwNCtYcEh0?=
 =?utf-8?B?YytkMWZLRTE3N1dKd00yQlZ3QXErUk1HTlhtdWIrOEdKekd1aXJQWlZoOEdu?=
 =?utf-8?B?djkrTE40UDFRUzJpWUc1SnovRmNSVGIvdHNaaXA1Y1YzT2hwTFNJVE5VYmtS?=
 =?utf-8?B?NmZJdjRzQlRJL0VPTThUbS94NlV5Y0FNMWNBUUl1MGNNcUhVdEZKS202eUNU?=
 =?utf-8?B?c0pLK245NWxmS2tDTWhGU0N1eTJoQnNoZi9GTDcyNE1LVE16aHFWaUQyWnMv?=
 =?utf-8?B?eVJjSlRyeU1iMnR0RWpoYVJSM3YyWHNQYXVvUnFlaHJRQlhJWmZhdDFBbDUr?=
 =?utf-8?B?QUJXMmJHVldiN1lPTHIyZ0J2WUFMR1ZMTDBxeWd3N1ZlZWRPdlRDQXV3b2dZ?=
 =?utf-8?B?dkRCWDhFTTYyalpqWUEwRUVWeFRuNmxNaUxrUGdxTEt5ZzFOTk54TENwVFQ4?=
 =?utf-8?B?RERCbDRXOHJXbko5NFFTdGZISmFFS0pYMHQ5QWVIM1NGUDQ0QXE4MkMzY0xu?=
 =?utf-8?B?dFZnNHRIVGk3Z3dMRExNVmlVUEhBclBLd0VuckNKMGpMS0lkQndkQ1Z0TktS?=
 =?utf-8?B?c2FJTnBJWWFJYjZJNWtFRU53ZTNJb1pCaGJHM1FMODJMYWhBSmdPSW02bitP?=
 =?utf-8?B?cTV5UlNMbjdLcWJITVJER05QR0V1MWJqOU5ld3JkRWpQNk1PL0s1YTlXZjRB?=
 =?utf-8?B?RkVPM08rZzBJQmt5SG05cGJ0VkRjeDVvVGNhdU4xcFVmQjI2Q3UwVFd5SHFK?=
 =?utf-8?B?KzhJRno4aXUxbXpYNjJ1VGUxd1FiUWhoem8zUEVOSXhlcDRqUmJGcUdRUjZT?=
 =?utf-8?B?WDc1K3hPM1NlNk9tQTFocWpRYytKWVhWajB1WEZMMytyTjVkUUdoUmVuREJ2?=
 =?utf-8?B?Mm40N0VpRmVGK1BYZm8rVlhFSVFFTkJOSzJVZk1UdGRQbGFwbWZNSXZCQXZj?=
 =?utf-8?B?VnJPa3BOVzNZT2pPQnkyeVBrUVhFZFBNWElvd3pKeWt6NVVBY29keDdGSlhz?=
 =?utf-8?B?RnUvUjM2OXdjTURiOUtxeXRsVTl6MEtpeEFOTXJtdVI3bTFhY3o0eWhsV0kx?=
 =?utf-8?B?VzFVYTJvMURFMlBzMHhSamlkL2VEWGZOR1pKZTV4U3RGc284aHNWS3JTR2Ur?=
 =?utf-8?B?RVgyRW9NOUs1dWF1MHYwcm4vN2pvMkVIQWFyOHJ1SnJXM25ld0NxZ2ZiQUpx?=
 =?utf-8?B?VVFVNzBsSENscTFHK3RYNDZ6ME9xRHAxV1lvTHR2cUhKR3RCM2dqbmllSE10?=
 =?utf-8?B?akFyNnFiQXoreGwza0F5U0FrNjBJTG05VUdLNjE3UjRkTmQwcVVld01ZM0pz?=
 =?utf-8?B?MmFiV0thMU1RamxDOW9pNkZzMEh0UFRlSXZXN1ZvQUh4eTBjK044ZjFyKzEz?=
 =?utf-8?B?TCtSN3ZiOFdwNEZ6QVFPalNiMnpqeGk0OFgxWVpCZjVJMGZua1l3SFExakpn?=
 =?utf-8?B?dHJvbkxSOW5MdVhkT1JXdDlqZVNab09WS2puTE9waTMzVnJWa0llOU5WcWE3?=
 =?utf-8?B?cE11WHgxc2Q5MUlJbjVqVEhuOTRuLytiWGNOYjkzaWl5cXVuOWJBM0w2NGd2?=
 =?utf-8?B?TmxLMXcybEdVQ3ZITnZDQjBHdVhTaCtRVVBTck1CcmJqZ2FvSWI3YnZ0Sldy?=
 =?utf-8?B?dnQ0cmMxNVV1TWQ5bnFkaXRHalRHTE5sQ05vTXpScWZzY0xUSnZ6Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a28cc3f6-bd5d-4cca-663f-08dedc52d8d1
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 18:09:11.8384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9POJDOgF5HAnYpT/MeF/ZbCOOQSDhnQ2iKpjItSCyu+gpKfkUiS4x+JlGOuK81D7GND9fIzqaDCVdudmoQaHvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9671
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

--------------EV06tSqjijSUcwX0v8M0nWE9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/7/2026 1:58 PM, Alex Deucher wrote:
> On Tue, Jul 7, 2026 at 12:25 PM Mukul Joshi<mukul.joshi@amd.com> wrote:
>> s/gx12.1/gfx12.1 in the patch headline.

With the fixes applied and this fixed, this patch is:

Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>

>>
>> On 7/6/2026 11:01 AM, Alex Deucher wrote:
>>
>> Ping?
>>
>> On Mon, Jun 29, 2026 at 4:28 PM Alex Deucher<alexdeucher@gmail.com> wrote:
>>
>> Ping?
>>
>> On Thu, Jun 18, 2026 at 5:04 PM Alex Deucher<alexander.deucher@amd.com> wrote:
>>
>> Add support for dumping IP register state.
>>
>> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 275 +++++++++++++++++++++++++
>>   1 file changed, 275 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>> index 5bdf2512f1540..ec4346a6c2af2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>> @@ -69,6 +69,127 @@ MODULE_FIRMWARE("amdgpu/gc_12_1_0_rlc_1.bin");
>>           (SH_MEM_ALIGNMENT_MODE_UNALIGNED_GFX12_1_0 << SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
>>           (3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT))
>>
>> +
>> +static const struct amdgpu_hwip_reg_entry gc_reg_list_12_1[] = {
>> +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS2),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS3),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT1),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT2),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT3),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STALLED_STAT1),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STALLED_STAT1),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_BUSY_STAT),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT2),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT2),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_ERROR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HPD_STATUS0),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_BASE),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_RPTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_WPTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_BASE),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_RPTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_WPTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_CMD_BUFSZ),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_CMD_BUFSZ),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_LO),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_HI),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BUFSZ),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_LO),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_HI),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BUFSZ),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCPF_UTCL1_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCPC_UTCL1_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCPG_UTCL1_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS_2),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regPA_CL_CNTL_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regRMI_UTCL1_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regSQC_CACHES),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regSQG_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regWD_UTCL1_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_STATUS_LO32),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_STATUS_HI32),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_DEBUG),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_CNTL),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_CNTL),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_INSTR_PNTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_INSTR_PNTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_INSTR_PNTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR0),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR1),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_RS64_INSTR_PNTR),
>> +       /* cp header registers */
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
>> +       /* SE status registers */
>> +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE0),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE1),
>> +};
>> +
>> +static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_12_1[] = {
>> +       /* compute registers */
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_VMID),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PERSISTENT_STATE),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PIPE_PRIORITY),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_QUEUE_PRIORITY),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_QUANTUM),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_BASE),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_BASE_HI),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_RPTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR_HI),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_CONTROL),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_BASE_ADDR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_BASE_ADDR_HI),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_RPTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_CONTROL),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_REQUEST),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_BASE_ADDR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_BASE_ADDR_HI),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_CONTROL),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_RPTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_WPTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_EVENTS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_BASE_ADDR_LO),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_BASE_ADDR_HI),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_CONTROL),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CNTL_STACK_OFFSET),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CNTL_STACK_SIZE),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_WG_STATE_OFFSET),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_SIZE),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_GDS_RESOURCE_STATE),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_ERROR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_WPTR_MEM),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_LO),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_HI),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_OFFSET),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_DW_CNT),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_WG_STATE_OFFSET),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_STATUS),
>> +       /* cp header registers */
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
>> +};
>> +
>>   static void gfx_v12_1_xcc_disable_gpa_mode(struct amdgpu_device *adev, int xcc_id);
>>   static void gfx_v12_1_set_ring_funcs(struct amdgpu_device *adev);
>>   static void gfx_v12_1_set_irq_funcs(struct amdgpu_device *adev);
>> @@ -1148,6 +1269,153 @@ static int gfx_v12_1_rlc_backdoor_autoload_enable(struct amdgpu_device *adev)
>>          return 0;
>>   }
>>
>> +static void gfx_v12_1_alloc_ip_dump(struct amdgpu_device *adev)
>> +{
>> +       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_12_1);
>> +       uint32_t *ptr, inst, num_xcc;
>> +
>> +       num_xcc = NUM_XCC(adev->gfx.xcc_mask);
>> +
>> +       ptr = kcalloc(reg_count * num_xcc, sizeof(uint32_t), GFP_KERNEL);
>> +       if (!ptr) {
>> +               DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
>> +               adev->gfx.ip_dump_core = NULL;
>> +       } else {
>> +               adev->gfx.ip_dump_core = ptr;
>> +       }
>> +
>> +       /* Allocate memory for compute queue registers for all the instances */
>> +       reg_count = ARRAY_SIZE(gc_cp_reg_list_12_1);
>> +       inst = adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
>> +               adev->gfx.mec.num_queue_per_pipe;
>> +
>> +       ptr = kcalloc(reg_count * inst * num_xcc, sizeof(uint32_t), GFP_KERNEL);
>> +       if (!ptr) {
>> +               DRM_ERROR("Failed to allocate memory for Compute Queues IP Dump\n");
>> +               adev->gfx.ip_dump_compute_queues = NULL;
>> +       } else {
>> +               adev->gfx.ip_dump_compute_queues = ptr;
>> +       }
>> +}
>> +
>> +static void gfx_v12_1_ip_print(struct amdgpu_ip_block *ip_block,
>> +                              struct drm_printer *p)
>> +{
>> +       struct amdgpu_device *adev = ip_block->adev;
>> +       uint32_t i, j, k;
>> +       uint32_t xcc_id, xcc_offset, inst_offset;
>> +       uint32_t num_xcc, reg, num_inst;
>> +       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_12_1);
>> +
>> +       if (!adev->gfx.ip_dump_core)
>> +               return;
>> +
>> +       num_xcc = NUM_XCC(adev->gfx.xcc_mask);
>> +       drm_printf(p, "Number of Instances:%d\n", num_xcc);
>> +       for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
>> +               xcc_offset = xcc_id * reg_count;
>> +               drm_printf(p, "\nInstance id:%d\n", xcc_id);
>> +               for (i = 0; i < reg_count; i++)
>> +                       drm_printf(p, "%-50s \t 0x%08x\n",
>> +                                  gc_reg_list_12_1[i].reg_name,
>> +                                  adev->gfx.ip_dump_core[xcc_offset + i]);
>> +       }
>> +
>> +       /* print compute queue registers for all instances */
>> +       if (!adev->gfx.ip_dump_compute_queues)
>> +               return;
>> +
>> +       reg_count = ARRAY_SIZE(gc_cp_reg_list_12_1);
>> +       drm_printf(p, "\nnum_xcc: %d num_mec: %d num_pipe: %d num_queue: %d\n",
>> +                  num_xcc,
>> +                  adev->gfx.mec.num_mec,
>> +                  adev->gfx.mec.num_pipe_per_mec,
>> +                  adev->gfx.mec.num_queue_per_pipe);
>> +
>> +       for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
>> +               xcc_offset = xcc_id * reg_count * num_inst;
>>
>> num_inst is never initialized here.
> Fixed.
>
>> +               inst_offset = 0;
>> +               for (i = 0; i < adev->gfx.mec.num_mec; i++) {
>> +                       for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
>> +                               for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
>> +                                       drm_printf(p,
>> +                                                  "\nxcc:%d mec:%d, pipe:%d, queue:%d\n",
>> +                                                   xcc_id, i, j, k);
>> +                                       for (reg = 0; reg < reg_count; reg++) {
>> +                                               drm_printf(p,
>> +                                                          "%-50s \t 0x%08x\n",
>> +                                                          gc_cp_reg_list_12_1[reg].reg_name,
>> +                                                          adev->gfx.ip_dump_compute_queues
>> +                                                          [xcc_offset + inst_offset +
>> +                                                           reg]);
>> +                                       }
>> +                                       inst_offset += reg_count;
>> +                               }
>> +                       }
>> +               }
>> +       }
>> +}
>> +
>> +static void gfx_v12_1_ip_dump(struct amdgpu_ip_block *ip_block)
>> +{
>> +       struct amdgpu_device *adev = ip_block->adev;
>> +       uint32_t i, j, k;
>> +       uint32_t num_xcc, reg, num_inst;
>> +       uint32_t xcc_id, xcc_offset, inst_offset;
>> +       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_12_1);
>> +
>> +       if (!adev->gfx.ip_dump_core)
>> +               return;
>> +
>> +       num_xcc = NUM_XCC(adev->gfx.xcc_mask);
>> +
>> +       amdgpu_gfx_off_ctrl(adev, false);
>> +       for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
>> +               xcc_offset = xcc_id * reg_count;
>> +               for (i = 0; i < reg_count; i++)
>> +                       adev->gfx.ip_dump_core[xcc_offset + i] =
>> +                               RREG32(SOC15_REG_ENTRY_OFFSET_INST(gc_reg_list_12_1[i],
>> +                                                                  GET_INST(GC, xcc_id)));
>> +       }
>> +       amdgpu_gfx_off_ctrl(adev, true);
>> +
>> +       /* dump compute queue registers for all instances */
>> +       if (!adev->gfx.ip_dump_compute_queues)
>> +               return;
>> +
>> +       num_inst = adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
>> +               adev->gfx.mec.num_queue_per_pipe;
>> +       reg_count = ARRAY_SIZE(gc_cp_reg_list_12_1);
>> +       amdgpu_gfx_off_ctrl(adev, false);
>> +       mutex_lock(&adev->srbm_mutex);
>> +       for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
>> +               xcc_offset = xcc_id * reg_count * num_inst;
>> +               inst_offset = 0;
>> +               for (i = 0; i < adev->gfx.mec.num_mec; i++) {
>> +                       for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
>> +                               for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
>> +                                       /* ME0 is for GFX so start from 1 for CP */
>> +                                       soc_v1_0_grbm_select(adev, 1 + i, j, k, 0,
>> +                                                            GET_INST(GC, xcc_id));
>> +
>> +                                       for (reg = 0; reg < reg_count; reg++) {
>> +                                               adev->gfx.ip_dump_compute_queues
>> +                                                       [xcc_offset +
>> +                                                        inst_offset + reg] =
>> +                                                       RREG32(SOC15_REG_ENTRY_OFFSET_INST(
>> +                                                                      gc_cp_reg_list_12_1[reg],
>> +                                                                      GET_INST(GC, xcc_id)));
>> +                                       }
>> +                                       inst_offset += reg_count;
>> +                               }
>> +                       }
>> +               }
>> +       }
>> +       soc_v1_0_grbm_select(adev, 0, 0, 0, 0, 0);
>> +       mutex_unlock(&adev->srbm_mutex);
>> +       amdgpu_gfx_off_ctrl(adev, true);
>>
>> Do we support GFX OFF on GFX 12.1? .
> No, it's a noop if a particular chip doesn't support it.
>
>> +}
>> +
>>   static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
>>   {
>>          uint16_t major_ver, minor_ver;
>> @@ -1282,6 +1550,8 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
>>          if (r)
>>                  return r;
>>
>> +       gfx_v12_1_alloc_ip_dump(adev);
>> +
>>          r = amdgpu_gfx_sysfs_init(adev);
>>          if (r)
>>
>> You may want to free the IP dump memory if the sysfs init fails or do the alloc after the sysfs init.
>>
> Fixed.
>
> Thanks,
>
> Alex
>
>> Regards,
>>
>> Mukul
>>
>>                  return r;
>> @@ -1325,6 +1595,9 @@ static int gfx_v12_1_sw_fini(struct amdgpu_ip_block *ip_block)
>>          gfx_v12_1_free_microcode(adev);
>>          amdgpu_gfx_sysfs_fini(adev);
>>
>> +       kfree(adev->gfx.ip_dump_core);
>> +       kfree(adev->gfx.ip_dump_compute_queues);
>> +
>>          return 0;
>>   }
>>
>> @@ -3905,6 +4178,8 @@ static const struct amd_ip_funcs gfx_v12_1_ip_funcs = {
>>          .set_clockgating_state = gfx_v12_1_set_clockgating_state,
>>          .set_powergating_state = gfx_v12_1_set_powergating_state,
>>          .get_clockgating_state = gfx_v12_1_get_clockgating_state,
>> +       .dump_ip_state = gfx_v12_1_ip_dump,
>> +       .print_ip_state = gfx_v12_1_ip_print,
>>   };
>>
>>   static const struct amdgpu_ring_funcs gfx_v12_1_ring_funcs_compute = {
>> --
>> 2.54.0
>>
--------------EV06tSqjijSUcwX0v8M0nWE9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 7/7/2026 1:58 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_OOhwAjhp2ps+Arw=cnrmP4zgMeWtX79L0wam=SbSiitA@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Tue, Jul 7, 2026 at 12:25 PM Mukul Joshi <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com">&lt;mukul.joshi@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
s/gx12.1/gfx12.1 in the patch headline.
</pre>
      </blockquote>
    </blockquote>
    <p>With the fixes applied and this fixed, this patch is:</p>
    <p>Reviewed-by: Mukul Joshi <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com">&lt;mukul.joshi@amd.com&gt;</a></p>
    <blockquote type="cite" cite="mid:CADnq5_OOhwAjhp2ps+Arw=cnrmP4zgMeWtX79L0wam=SbSiitA@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">

On 7/6/2026 11:01 AM, Alex Deucher wrote:

Ping?

On Mon, Jun 29, 2026 at 4:28 PM Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher@gmail.com">&lt;alexdeucher@gmail.com&gt;</a> wrote:

Ping?

On Thu, Jun 18, 2026 at 5:04 PM Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a> wrote:

Add support for dumping IP register state.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 275 +++++++++++++++++++++++++
 1 file changed, 275 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 5bdf2512f1540..ec4346a6c2af2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -69,6 +69,127 @@ MODULE_FIRMWARE(&quot;amdgpu/gc_12_1_0_rlc_1.bin&quot;);
         (SH_MEM_ALIGNMENT_MODE_UNALIGNED_GFX12_1_0 &lt;&lt; SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
         (3 &lt;&lt; SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT))

+
+static const struct amdgpu_hwip_reg_entry gc_reg_list_12_1[] = {
+       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
+       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS2),
+       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS3),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT1),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT2),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT3),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STALLED_STAT1),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STALLED_STAT1),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_BUSY_STAT),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT2),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT2),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STATUS),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_ERROR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HPD_STATUS0),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_BASE),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_RPTR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_WPTR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_BASE),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_RPTR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_WPTR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_CMD_BUFSZ),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_CMD_BUFSZ),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_LO),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_HI),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BUFSZ),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_LO),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_HI),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BUFSZ),
+       SOC15_REG_ENTRY_STR(GC, 0, regCPF_UTCL1_STATUS),
+       SOC15_REG_ENTRY_STR(GC, 0, regCPC_UTCL1_STATUS),
+       SOC15_REG_ENTRY_STR(GC, 0, regCPG_UTCL1_STATUS),
+       SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS),
+       SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS_2),
+       SOC15_REG_ENTRY_STR(GC, 0, regPA_CL_CNTL_STATUS),
+       SOC15_REG_ENTRY_STR(GC, 0, regRMI_UTCL1_STATUS),
+       SOC15_REG_ENTRY_STR(GC, 0, regSQC_CACHES),
+       SOC15_REG_ENTRY_STR(GC, 0, regSQG_STATUS),
+       SOC15_REG_ENTRY_STR(GC, 0, regWD_UTCL1_STATUS),
+       SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2),
+       SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_STATUS_LO32),
+       SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_STATUS_HI32),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_DEBUG),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_CNTL),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_CNTL),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_INSTR_PNTR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_INSTR_PNTR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_INSTR_PNTR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STATUS),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR0),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR1),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_RS64_INSTR_PNTR),
+       /* cp header registers */
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+       /* SE status registers */
+       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE0),
+       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE1),
+};
+
+static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_12_1[] = {
+       /* compute registers */
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_VMID),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PERSISTENT_STATE),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PIPE_PRIORITY),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_QUEUE_PRIORITY),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_QUANTUM),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_BASE),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_BASE_HI),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_RPTR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR_HI),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_CONTROL),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_BASE_ADDR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_BASE_ADDR_HI),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_RPTR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_CONTROL),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_REQUEST),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_BASE_ADDR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_BASE_ADDR_HI),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_CONTROL),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_RPTR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_WPTR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_EVENTS),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_BASE_ADDR_LO),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_BASE_ADDR_HI),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_CONTROL),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CNTL_STACK_OFFSET),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CNTL_STACK_SIZE),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_WG_STATE_OFFSET),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_SIZE),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_GDS_RESOURCE_STATE),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_ERROR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_WPTR_MEM),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_LO),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_HI),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_OFFSET),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_DW_CNT),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_WG_STATE_OFFSET),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_STATUS),
+       /* cp header registers */
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+};
+
 static void gfx_v12_1_xcc_disable_gpa_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v12_1_set_ring_funcs(struct amdgpu_device *adev);
 static void gfx_v12_1_set_irq_funcs(struct amdgpu_device *adev);
@@ -1148,6 +1269,153 @@ static int gfx_v12_1_rlc_backdoor_autoload_enable(struct amdgpu_device *adev)
        return 0;
 }

+static void gfx_v12_1_alloc_ip_dump(struct amdgpu_device *adev)
+{
+       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_12_1);
+       uint32_t *ptr, inst, num_xcc;
+
+       num_xcc = NUM_XCC(adev-&gt;gfx.xcc_mask);
+
+       ptr = kcalloc(reg_count * num_xcc, sizeof(uint32_t), GFP_KERNEL);
+       if (!ptr) {
+               DRM_ERROR(&quot;Failed to allocate memory for GFX IP Dump\n&quot;);
+               adev-&gt;gfx.ip_dump_core = NULL;
+       } else {
+               adev-&gt;gfx.ip_dump_core = ptr;
+       }
+
+       /* Allocate memory for compute queue registers for all the instances */
+       reg_count = ARRAY_SIZE(gc_cp_reg_list_12_1);
+       inst = adev-&gt;gfx.mec.num_mec * adev-&gt;gfx.mec.num_pipe_per_mec *
+               adev-&gt;gfx.mec.num_queue_per_pipe;
+
+       ptr = kcalloc(reg_count * inst * num_xcc, sizeof(uint32_t), GFP_KERNEL);
+       if (!ptr) {
+               DRM_ERROR(&quot;Failed to allocate memory for Compute Queues IP Dump\n&quot;);
+               adev-&gt;gfx.ip_dump_compute_queues = NULL;
+       } else {
+               adev-&gt;gfx.ip_dump_compute_queues = ptr;
+       }
+}
+
+static void gfx_v12_1_ip_print(struct amdgpu_ip_block *ip_block,
+                              struct drm_printer *p)
+{
+       struct amdgpu_device *adev = ip_block-&gt;adev;
+       uint32_t i, j, k;
+       uint32_t xcc_id, xcc_offset, inst_offset;
+       uint32_t num_xcc, reg, num_inst;
+       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_12_1);
+
+       if (!adev-&gt;gfx.ip_dump_core)
+               return;
+
+       num_xcc = NUM_XCC(adev-&gt;gfx.xcc_mask);
+       drm_printf(p, &quot;Number of Instances:%d\n&quot;, num_xcc);
+       for (xcc_id = 0; xcc_id &lt; num_xcc; xcc_id++) {
+               xcc_offset = xcc_id * reg_count;
+               drm_printf(p, &quot;\nInstance id:%d\n&quot;, xcc_id);
+               for (i = 0; i &lt; reg_count; i++)
+                       drm_printf(p, &quot;%-50s \t 0x%08x\n&quot;,
+                                  gc_reg_list_12_1[i].reg_name,
+                                  adev-&gt;gfx.ip_dump_core[xcc_offset + i]);
+       }
+
+       /* print compute queue registers for all instances */
+       if (!adev-&gt;gfx.ip_dump_compute_queues)
+               return;
+
+       reg_count = ARRAY_SIZE(gc_cp_reg_list_12_1);
+       drm_printf(p, &quot;\nnum_xcc: %d num_mec: %d num_pipe: %d num_queue: %d\n&quot;,
+                  num_xcc,
+                  adev-&gt;gfx.mec.num_mec,
+                  adev-&gt;gfx.mec.num_pipe_per_mec,
+                  adev-&gt;gfx.mec.num_queue_per_pipe);
+
+       for (xcc_id = 0; xcc_id &lt; num_xcc; xcc_id++) {
+               xcc_offset = xcc_id * reg_count * num_inst;

num_inst is never initialized here.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Fixed.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
+               inst_offset = 0;
+               for (i = 0; i &lt; adev-&gt;gfx.mec.num_mec; i++) {
+                       for (j = 0; j &lt; adev-&gt;gfx.mec.num_pipe_per_mec; j++) {
+                               for (k = 0; k &lt; adev-&gt;gfx.mec.num_queue_per_pipe; k++) {
+                                       drm_printf(p,
+                                                  &quot;\nxcc:%d mec:%d, pipe:%d, queue:%d\n&quot;,
+                                                   xcc_id, i, j, k);
+                                       for (reg = 0; reg &lt; reg_count; reg++) {
+                                               drm_printf(p,
+                                                          &quot;%-50s \t 0x%08x\n&quot;,
+                                                          gc_cp_reg_list_12_1[reg].reg_name,
+                                                          adev-&gt;gfx.ip_dump_compute_queues
+                                                          [xcc_offset + inst_offset +
+                                                           reg]);
+                                       }
+                                       inst_offset += reg_count;
+                               }
+                       }
+               }
+       }
+}
+
+static void gfx_v12_1_ip_dump(struct amdgpu_ip_block *ip_block)
+{
+       struct amdgpu_device *adev = ip_block-&gt;adev;
+       uint32_t i, j, k;
+       uint32_t num_xcc, reg, num_inst;
+       uint32_t xcc_id, xcc_offset, inst_offset;
+       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_12_1);
+
+       if (!adev-&gt;gfx.ip_dump_core)
+               return;
+
+       num_xcc = NUM_XCC(adev-&gt;gfx.xcc_mask);
+
+       amdgpu_gfx_off_ctrl(adev, false);
+       for (xcc_id = 0; xcc_id &lt; num_xcc; xcc_id++) {
+               xcc_offset = xcc_id * reg_count;
+               for (i = 0; i &lt; reg_count; i++)
+                       adev-&gt;gfx.ip_dump_core[xcc_offset + i] =
+                               RREG32(SOC15_REG_ENTRY_OFFSET_INST(gc_reg_list_12_1[i],
+                                                                  GET_INST(GC, xcc_id)));
+       }
+       amdgpu_gfx_off_ctrl(adev, true);
+
+       /* dump compute queue registers for all instances */
+       if (!adev-&gt;gfx.ip_dump_compute_queues)
+               return;
+
+       num_inst = adev-&gt;gfx.mec.num_mec * adev-&gt;gfx.mec.num_pipe_per_mec *
+               adev-&gt;gfx.mec.num_queue_per_pipe;
+       reg_count = ARRAY_SIZE(gc_cp_reg_list_12_1);
+       amdgpu_gfx_off_ctrl(adev, false);
+       mutex_lock(&amp;adev-&gt;srbm_mutex);
+       for (xcc_id = 0; xcc_id &lt; num_xcc; xcc_id++) {
+               xcc_offset = xcc_id * reg_count * num_inst;
+               inst_offset = 0;
+               for (i = 0; i &lt; adev-&gt;gfx.mec.num_mec; i++) {
+                       for (j = 0; j &lt; adev-&gt;gfx.mec.num_pipe_per_mec; j++) {
+                               for (k = 0; k &lt; adev-&gt;gfx.mec.num_queue_per_pipe; k++) {
+                                       /* ME0 is for GFX so start from 1 for CP */
+                                       soc_v1_0_grbm_select(adev, 1 + i, j, k, 0,
+                                                            GET_INST(GC, xcc_id));
+
+                                       for (reg = 0; reg &lt; reg_count; reg++) {
+                                               adev-&gt;gfx.ip_dump_compute_queues
+                                                       [xcc_offset +
+                                                        inst_offset + reg] =
+                                                       RREG32(SOC15_REG_ENTRY_OFFSET_INST(
+                                                                      gc_cp_reg_list_12_1[reg],
+                                                                      GET_INST(GC, xcc_id)));
+                                       }
+                                       inst_offset += reg_count;
+                               }
+                       }
+               }
+       }
+       soc_v1_0_grbm_select(adev, 0, 0, 0, 0, 0);
+       mutex_unlock(&amp;adev-&gt;srbm_mutex);
+       amdgpu_gfx_off_ctrl(adev, true);

Do we support GFX OFF on GFX 12.1? .
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
No, it's a noop if a particular chip doesn't support it.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
+}
+
 static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 {
        uint16_t major_ver, minor_ver;
@@ -1282,6 +1550,8 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
        if (r)
                return r;

+       gfx_v12_1_alloc_ip_dump(adev);
+
        r = amdgpu_gfx_sysfs_init(adev);
        if (r)

You may want to free the IP dump memory if the sysfs init fails or do the alloc after the sysfs init.

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Fixed.

Thanks,

Alex

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Regards,

Mukul

                return r;
@@ -1325,6 +1595,9 @@ static int gfx_v12_1_sw_fini(struct amdgpu_ip_block *ip_block)
        gfx_v12_1_free_microcode(adev);
        amdgpu_gfx_sysfs_fini(adev);

+       kfree(adev-&gt;gfx.ip_dump_core);
+       kfree(adev-&gt;gfx.ip_dump_compute_queues);
+
        return 0;
 }

@@ -3905,6 +4178,8 @@ static const struct amd_ip_funcs gfx_v12_1_ip_funcs = {
        .set_clockgating_state = gfx_v12_1_set_clockgating_state,
        .set_powergating_state = gfx_v12_1_set_powergating_state,
        .get_clockgating_state = gfx_v12_1_get_clockgating_state,
+       .dump_ip_state = gfx_v12_1_ip_dump,
+       .print_ip_state = gfx_v12_1_ip_print,
 };

 static const struct amdgpu_ring_funcs gfx_v12_1_ring_funcs_compute = {
--
2.54.0

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------EV06tSqjijSUcwX0v8M0nWE9--
