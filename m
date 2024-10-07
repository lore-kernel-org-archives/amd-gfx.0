Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACD5CFB453
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Oct 2024 18:37:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BD9A10E3FF;
	Mon,  7 Oct 2024 18:37:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UPbdVUjt";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B93610E3FD
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Oct 2024 18:37:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WufMDLqyP0rk2eC5KclBBG7OcXx/hoXazv73vasr6HsRC8bjZ1qAXdmeLg3lJhUh8sEvWHUp7xVki0Eh+gXKissQzMqPKlcBc8g+eUzrkx7FYXsacekWApkE+q8gzaedkkGuhqF9HsKrQuCR+GrGV752pLfKsUcLsgTA96f0UJIgdSkw0JbrlK/Ok240PDbdCYRN97U5r+ZueTMssRynK8C1CI8YYIElEpD5A3e9y6LC3YRDt+x5tkXt1zYi/LDvCD26lX8p4SVaX1SeA6gB2TJQfaMn5M3qBA6q4ZVfi/85oaNDpLc8SJNKM3oAqmyQjfzVguPP/PwmYLsjvhj2Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNioldOca5RHlCRIXFWvQbfUmAV5v1PVPvr9CeAQecc=;
 b=gZLXziF1B4mRRinKz7ko987KHTOikHMkkaemaxv01HWSsKEEb7snf/tPxW+GuUPol0Z2d9c6F1v/FNeR6QfIOOW0g2lsVybkDk69KQa4ldpuAO0zFMZuR3s92nXViT1oRobbQJkaq4QINP6XBDaOsy64RJeQgDfzwAFVI8ACbmKIKO22TNBhJMiNUMsyvKTRAIHk8teNy2JSChxYHO2xsJmn0jz6kCG6L29j1Z4VJc1rMlyh+jkfbAJ6LroDydIlyz2q7/Y1JhRkeO4V04HtdNOciJXURygVLFM223BN93pRGIa41NfF4Hvrcj4/rBdO2TDnpihchAtQw6rkUAJCqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNioldOca5RHlCRIXFWvQbfUmAV5v1PVPvr9CeAQecc=;
 b=UPbdVUjt3RTWBsMEtRrX0YR21EcjLlm1G9qBY2RTX6xSZZULVsR2/x1eQ/mf7mOgr8YrW0CUjic5iNE/c5FLPxwRZQBrSCdTBoXxzJdkzQN6kpqeWO15qme2KX2Bv8fj7KUY+xmny+6lA5VJptfMB9SiNmiVbe8ZKhuUbMEJKks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8832.namprd12.prod.outlook.com (2603:10b6:a03:4d0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 18:37:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 18:37:31 +0000
Message-ID: <2361b7c1-dfe9-4145-9e84-151516613d42@amd.com>
Date: Mon, 7 Oct 2024 13:37:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: partially revert powerplay `__counted_by`
 changes
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241003140614.3976582-1-alexander.deucher@amd.com>
 <CADnq5_OKdHEXLzn4aTTBVWX0SZRHQq3E2yB_VZysA-ZYPPs_Rw@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_OKdHEXLzn4aTTBVWX0SZRHQq3E2yB_VZysA-ZYPPs_Rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd9cc5b-bea4-41e0-9093-08dce6ff1a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2dXM3NteGN1OTllZjlPdHVTdGxHZ0JNeFhzRGtXdXJERXMxcHRIUFJqQ2xs?=
 =?utf-8?B?OHRSU1NwTWFCVThzV29mblBxWDMvNlovaEdpWkVqOFJCc1ZtSWloOXJWQW1r?=
 =?utf-8?B?aVR5Z1Q2dkR1UmxFbS95MSs2eTR4dk03K045RHNhRlFocDVUQlpHbEMxZmRa?=
 =?utf-8?B?TGlvemdnSStQNDA3Vk5WZ3gzMFhNVkVqQmxZclN0RGdzL3djRUNuMCtsZlhs?=
 =?utf-8?B?dlBReThqWTdBMUQrdHRPNmxpWi91WkROQVZJaWJmcUFjampWdmE5bDllTi9W?=
 =?utf-8?B?UFpsc0FDcmEwSTFGL2N0MlFTNlFKOXdNZEdTSnVhOG5YNjRybjl4a1A4cWZF?=
 =?utf-8?B?ZlByS2RhUUhOdTNkOXpCalBDQ0RKZ3VtRVFDSno1b0M1Uk84T1dySEgxN2dh?=
 =?utf-8?B?QWdnNWdrNkVldHVsazNpNGtSNkcyYVVFK1RoN0xxTlE4L2hVRWNGbFBHRHpL?=
 =?utf-8?B?Y21xUWNuQmtqNmg3b256a2ViMi9ydHFYdGJJSHkwOWlPMWltRUVKRW56Ump2?=
 =?utf-8?B?VVk3SEhDVTZLWjFSK3k1ajJ1aXY1bmJUcGRqOWVqMDl2Q1pIQjJzaEY3WWNp?=
 =?utf-8?B?ZzZ4WFZya0d3UlUxRHBHamF3NFNVdUN4SThXbVBBTkt4UEpRbFNkMXB1czhX?=
 =?utf-8?B?VWV0Zjd2WGNQWThPN05McUE3ZG93Y0h5ak8zV3ZOdDVNNDYrYzRwWk5TaFVO?=
 =?utf-8?B?K3NDVjB0S0F4K01RM2pBRSt5TnNONjJKbVhodFJUazQ2YVBhUzlyUEg5bmtE?=
 =?utf-8?B?N3RkUzNYNCs0Um5kYkhUZWk4K2YvZ0JEeVZUaWZHWjY1YzlQb1k3YVd3bEdB?=
 =?utf-8?B?SCtxTjlNR3pPeUdlOWNBVUh5ZzBlVDV3a1ZPZjFZRUlQMUx5YVJwRnJNemJ5?=
 =?utf-8?B?R1ZVOXUwdmpjaEJ3aXZqZXBqK3ZaVGhiaEJDZ2ZtZkJDYXoyK04xRHVQZ3JC?=
 =?utf-8?B?czQyemF1QnN3R09IOG5uN3paRXB0R2krTjZWN24vbm1QaFU5aG1nRTNlaDhF?=
 =?utf-8?B?Ym9YdktZZllET3hQekN6TE1Kb0NhZnVtdHdYcVBmTGRlejI2UVBITmJ6QVpF?=
 =?utf-8?B?SWpNcjFIcm1GbVRUUjhlZXRIbXA5YUx5U1paUWl1ZExhcys3WW5QenVMSENr?=
 =?utf-8?B?dXpsWXdwZHhuMlNYOVRqMStmV3Q1clE1dC91OU16U2JIZGtib1pkOFFURVQz?=
 =?utf-8?B?S1BjRTBlRlhXMi9TU2pobC9WVEZVcWczYmd1akxya3hUM1RFOVNaQ3lrSUdP?=
 =?utf-8?B?MFJ4a0NHb2lEV1pkOUZUY0kramhrRU1pdzJNSlBDTmkwRUh6eXJ1NDk4RnRN?=
 =?utf-8?B?cWJxOGtvR2ZrRnoweTlIZGhOSDVjVWxieXRCbkpacEI4VVMyZTJqQVRiVHVT?=
 =?utf-8?B?dzNRMFl1WlVQN1IyelRHQ3VocHhjRUIvVjdndm55Zk16alpaUFowZUxkYjBT?=
 =?utf-8?B?Y1N1WWRFQVNiMVV6UndPVVFGSFdKNGxzSE1DZ1RjK29FUmtOZGk0Uk1nSWNo?=
 =?utf-8?B?MjY3OFZ3WW42YzlaRHRURkhZS3Zpd2NlR2JGSis3WGRTUWkxTGxVZDdYcjda?=
 =?utf-8?B?UGdzMDhRUTd5OVQwaWhwczN6YWZqM3FWbWVuU0RHMEs1bFZrT05ZekRBMDZM?=
 =?utf-8?B?RitnVjREUmRJWk82TWxhMk1jc2x5WWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUQyblcyMUZoM1pjb0FEU2R3WnJWNWxHeEpnOEdEUnQva1RoR2tnQytUVDcz?=
 =?utf-8?B?eVBzU2hGK3l5SjQ2NmZoRHZzK0hqbjhuWHd0S0dKZGxZUHkzTnFFbU4ySEJM?=
 =?utf-8?B?RjJlb0lobEh6TCtYUG1kNC9Zd0tjVjVGU1VheVA4U2U5d2hCUVVEMjcrcm5t?=
 =?utf-8?B?ZzE5SDdxT2ZTeHhPVzEzM1VDRmVBM1BJdVFXdXEwR3NSd3lZZEY2N2lVNVFv?=
 =?utf-8?B?Z3ZxS0laa3JpMlBXU0pWOUtWd0JscS9wYlJYRXRnaEw2TmJlLzUwVE0wWVQ1?=
 =?utf-8?B?cTJlSkZWVTV0a0JGZ0d4VlZQNGxoRHVIdVBvYkdJVFd4NmtmM2Q1a1RBM0dF?=
 =?utf-8?B?QUdjRnRhanBGRXEyTVRzaWRSRzI3QmFWV3JmdVRoMDUvN3Mwc2FoQldZbzAv?=
 =?utf-8?B?ZWtvMXBHeFpER0VzQXRFRUxPVGIwajhObjgwYXNkbm1HT2dGQlFvcml6TUZ4?=
 =?utf-8?B?MU9SampUdFRMVG9VUytkZmNBRXdaK2NuMlZZYWwya0Q2K2xJdFlHeFZGVjBF?=
 =?utf-8?B?aWVNcytnNVdVNEpaSDR0VWlaMFM3a0ZJSFAzc1Jxcld5OHVtaTNOa3BRN2Nw?=
 =?utf-8?B?TVJnSmxudUgwMVZaT1RLVzhJU01hUkl2cHloMmRFb0NkWXU3SU1EOFdMVkUv?=
 =?utf-8?B?dUNYanNuU3RoaHdIYnpORzJBakxZUWwvdjRiSTRwSEdmRCtGWWFBUXdrWGli?=
 =?utf-8?B?Wlk0TXhWQUlibUhzTFU2RmNHeDkyY1ROZ3VRcFAyUXphb2lQbFpaMytUVkl5?=
 =?utf-8?B?S201NG5ha1NpWFFNSlBKMzdodXpTOEJKMXByUExMLzZnUXdZVno2MGVQZWk2?=
 =?utf-8?B?Z0Qxb3F6bGhWajZGSWdaaStsYlZGSzlnaTdCU3BKODJqUjVoSm91UlU4Rnpw?=
 =?utf-8?B?SjZDUnBmUDJiMUxHdEhqdzVKME1TWThad3g5YjlzNWVxelNRbUk4VG9NMjlX?=
 =?utf-8?B?Ymg2Mnd6d2UxbnorUFAvSU00L2IrWjRpVEVnQXVVU2hyc3hyMDRpOGNCQnRY?=
 =?utf-8?B?YjZ2cG4xY2VlaEpiZ3BmMGtLOXBxbGRONzRObGdFOU5xRDBDeHBuUFhZclJP?=
 =?utf-8?B?NEJXNjlXMGV6UWZIU0lmeXlDa2d6UEc2WE5MK2ladndDejgwQ0ovZXk1WEhy?=
 =?utf-8?B?dWplN3NvemNxSUpCb0ZlNVdhdlZicVNYSzFrbTJDaFhkRVQ5dEFpYmxLREFO?=
 =?utf-8?B?UkdDaHFWOVFJVFZSd3JsV2FqMFFFKzBmeDFqUlNPc2lRVHBQNTRLaW5PYVV2?=
 =?utf-8?B?VUNUUHFDamxDamZZSVhkdEtySWJoeTcvOW5hcmF2L3I0L05wNjlDZzBuYlpD?=
 =?utf-8?B?TWh4MGdsSFRBM2Voa3lLdUVwck5BckRSRU9DSFVpSEZzMG4zTSs5OXZiS2ta?=
 =?utf-8?B?c1JVaitIek9adjhPaTY5MXp4M3BmTkw0c2lDTitUTThIOWVta05tSjFIVmtJ?=
 =?utf-8?B?OGZYKzdZZlRmeFJlZE9vZ1hFOURyN0M5TzZHR1JTa0p5cUtNOE53V1BjbTNu?=
 =?utf-8?B?YnRYSWJPQ05WM0Z2RWprem9zVDkwU05aTHpGU0p3YjlmUmgzNWJsVDdSaFpK?=
 =?utf-8?B?NS9IUWE5VWZNell2TzJOdzRrbE4xUURpUGp0NFJBQ3BhSVdQUittUEg0MmM5?=
 =?utf-8?B?U24wdUlVOEljNFpGUm5WaktJKzNQRDZ6TFF3K1U0ZXUwQ0VpMStyQ2ltSUs4?=
 =?utf-8?B?a2NqN05QQ2x1VjBhVWtxRTJqME1yRXp4MllhcWg3bVI1aUoyYUwrbVRnTFJn?=
 =?utf-8?B?OWx3TEZ6Umw1ZHpnK2JJT2Zpb3MxVlhmU1ZoNzhSbjJVOVR5c3JSc3JSTVNZ?=
 =?utf-8?B?ZnhJamJIb1Y1MFNxc3RhK2t2eStucDY4Y3d6U2R0QTRnY1VOUUdFVktBSnZv?=
 =?utf-8?B?WDhzQU1yRzhSaVJwM2lIbjliNzRkRHZKZkhtMzBKak9TRjVrdFhTY29PUmNF?=
 =?utf-8?B?bXlheUw5UTFhNG9abXUvSTdydDg4bElpbjlJTkhJWE0wMkJpbk1aMEhjYXNZ?=
 =?utf-8?B?aGJqSldOREVVTzN0K2dqeTVJQ3Rya1hVVmNYMnVpcmRPR0tVUVNNa1l2MDNQ?=
 =?utf-8?B?Ti82MjlxWm84QkNDRHBHdXo0VDVObXVPM3d5M0tLaVkrakpkcmZIVDhKYTAy?=
 =?utf-8?Q?7MdPl2oEwk2Ci67gG7ZOmGeTo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd9cc5b-bea4-41e0-9093-08dce6ff1a1c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 18:37:31.0083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDEKkqLRcuaF3Rvs5cHLWc4iLXdY3nVt7ppxU4wAvFiullkDEUL8D+yyzLzMElTTJAyQAzVVQJAiNDeky4zwAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8832
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

On 10/4/2024 09:17, Alex Deucher wrote:
> Ping?
> 
> On Thu, Oct 3, 2024 at 10:06 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>>
>> Partially revert
>> commit 0ca9f757a0e2 ("drm/amd/pm: powerplay: Add `__counted_by` attribute for flexible arrays")
>>
>> The count attribute for these arrays does not get set until
>> after the arrays are allocated and populated leading to false
>> UBSAN warnings.
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3662
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h | 26 ++++++++++----------
>>   1 file changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
>> index 9118fcddbf11..227bf0e84a13 100644
>> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
>> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
>> @@ -60,7 +60,7 @@ struct vi_dpm_level {
>>
>>   struct vi_dpm_table {
>>          uint32_t count;
>> -       struct vi_dpm_level dpm_level[] __counted_by(count);
>> +       struct vi_dpm_level dpm_level[];
>>   };
>>
>>   #define PCIE_PERF_REQ_REMOVE_REGISTRY   0
>> @@ -91,7 +91,7 @@ struct phm_set_power_state_input {
>>
>>   struct phm_clock_array {
>>          uint32_t count;
>> -       uint32_t values[] __counted_by(count);
>> +       uint32_t values[];
>>   };
>>
>>   struct phm_clock_voltage_dependency_record {
>> @@ -123,7 +123,7 @@ struct phm_acpclock_voltage_dependency_record {
>>
>>   struct phm_clock_voltage_dependency_table {
>>          uint32_t count;
>> -       struct phm_clock_voltage_dependency_record entries[] __counted_by(count);
>> +       struct phm_clock_voltage_dependency_record entries[];
>>   };
>>
>>   struct phm_phase_shedding_limits_record {
>> @@ -140,7 +140,7 @@ struct phm_uvd_clock_voltage_dependency_record {
>>
>>   struct phm_uvd_clock_voltage_dependency_table {
>>          uint8_t count;
>> -       struct phm_uvd_clock_voltage_dependency_record entries[] __counted_by(count);
>> +       struct phm_uvd_clock_voltage_dependency_record entries[];
>>   };
>>
>>   struct phm_acp_clock_voltage_dependency_record {
>> @@ -150,7 +150,7 @@ struct phm_acp_clock_voltage_dependency_record {
>>
>>   struct phm_acp_clock_voltage_dependency_table {
>>          uint32_t count;
>> -       struct phm_acp_clock_voltage_dependency_record entries[] __counted_by(count);
>> +       struct phm_acp_clock_voltage_dependency_record entries[];
>>   };
>>
>>   struct phm_vce_clock_voltage_dependency_record {
>> @@ -161,32 +161,32 @@ struct phm_vce_clock_voltage_dependency_record {
>>
>>   struct phm_phase_shedding_limits_table {
>>          uint32_t count;
>> -       struct phm_phase_shedding_limits_record  entries[] __counted_by(count);
>> +       struct phm_phase_shedding_limits_record  entries[];
>>   };
>>
>>   struct phm_vceclock_voltage_dependency_table {
>>          uint8_t count;
>> -       struct phm_vceclock_voltage_dependency_record entries[] __counted_by(count);
>> +       struct phm_vceclock_voltage_dependency_record entries[];
>>   };
>>
>>   struct phm_uvdclock_voltage_dependency_table {
>>          uint8_t count;
>> -       struct phm_uvdclock_voltage_dependency_record entries[] __counted_by(count);
>> +       struct phm_uvdclock_voltage_dependency_record entries[];
>>   };
>>
>>   struct phm_samuclock_voltage_dependency_table {
>>          uint8_t count;
>> -       struct phm_samuclock_voltage_dependency_record entries[] __counted_by(count);
>> +       struct phm_samuclock_voltage_dependency_record entries[];
>>   };
>>
>>   struct phm_acpclock_voltage_dependency_table {
>>          uint32_t count;
>> -       struct phm_acpclock_voltage_dependency_record entries[] __counted_by(count);
>> +       struct phm_acpclock_voltage_dependency_record entries[];
>>   };
>>
>>   struct phm_vce_clock_voltage_dependency_table {
>>          uint8_t count;
>> -       struct phm_vce_clock_voltage_dependency_record entries[] __counted_by(count);
>> +       struct phm_vce_clock_voltage_dependency_record entries[];
>>   };
>>
>>
>> @@ -393,7 +393,7 @@ union phm_cac_leakage_record {
>>
>>   struct phm_cac_leakage_table {
>>          uint32_t count;
>> -       union phm_cac_leakage_record entries[] __counted_by(count);
>> +       union phm_cac_leakage_record entries[];
>>   };
>>
>>   struct phm_samu_clock_voltage_dependency_record {
>> @@ -404,7 +404,7 @@ struct phm_samu_clock_voltage_dependency_record {
>>
>>   struct phm_samu_clock_voltage_dependency_table {
>>          uint8_t count;
>> -       struct phm_samu_clock_voltage_dependency_record entries[] __counted_by(count);
>> +       struct phm_samu_clock_voltage_dependency_record entries[];
>>   };
>>
>>   struct phm_cac_tdp_table {
>> --
>> 2.46.2
>>

