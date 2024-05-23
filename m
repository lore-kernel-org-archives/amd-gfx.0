Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721A3C25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 19:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBA5510F2CD;
	Thu, 23 May 2024 19:31:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cmXV8uQE";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B08C210F316
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 19:31:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbwhTMjLgahChx36bnA0jG9te/e2plqnoJ54cHbptV3GIhfMjOuGuKqt8kGyzGJUX9kFcUFGg27PTN2pQ9WCI1u8g8GBUmppErbj7skAerg3sYKjWYdvRsUTW/E7e2jYFUNJyn0Q9YfddiiKdj4AxSlCFBbv0wlDVSyaTKaL+vLfyOjkBcOxxNp9FRa0lvrJVeV9BbGEhPFQ3oD0YjvmovIDli30Idj7p2RbhpaSTVxMGQBHfIQ5a8008unqEexpCGuQmmMwiF86NkfcrlQMYx25we0jAmxAsB7qTJF3FWo4V3O925gSpy1842u24i13oYsW1x1/gsU1UQ8ksMtgWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5Ccczscse86mRYdrSWSA6ZzmMW0pIBQsoUSLaEMXSQ=;
 b=b+IBs4aY4cPUz5kJMI0VTGFXG9R3v3WewTVsIR1T8VzsQsR7b+MIM6HDpSdoKnoz/U9T3gsDcT+Jb2GS0WxIkqyQ+N/fMu1fcTYPh1DTC/JTAWH0EkVzItozgjZyJfX7V10kQQgHxPlYCozmglXnaqeftgD97qJys/iSyZpcY4+wFULEzjInF7jsQKx9IV59AYVqoUupMInIX59YOSfdXRwVlhmtqx99vWfj7ce4Z6sVTZ/nm9rj1RMiTGYIBsK/EApihVCaypLV/vAGugA/VOJuSrYdYUqS0gxg23/lYqq2NEmgER7CR7Ly8r0KEs3ETtcrGMuN7WbILt/r92OCog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5Ccczscse86mRYdrSWSA6ZzmMW0pIBQsoUSLaEMXSQ=;
 b=cmXV8uQEEJ2ywfwqqnNpPWq/ifrVksJHa+ww8TU9TEtfjP+kCHZ2tkxOeH9thx98oSbbmM04k0DkhjjcigBrs/TWzmS502zZryuk2x6AQMqzA0jlPZQFEuTLN1An8AtHhRKpRt47FIWmLRTDJ/j0vKhYgNt2uwCIuGRJOMUIJMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4599.namprd12.prod.outlook.com (2603:10b6:a03:107::22)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 19:31:33 +0000
Received: from BYAPR12MB4599.namprd12.prod.outlook.com
 ([fe80::6f97:8f23:34be:5b37]) by BYAPR12MB4599.namprd12.prod.outlook.com
 ([fe80::6f97:8f23:34be:5b37%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 19:31:33 +0000
Message-ID: <4f0a5ff8-ba6b-4db0-8e61-4e8a3b74fcc7@amd.com>
Date: Thu, 23 May 2024 14:31:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdkfd: gfx12 context save/restore trap handler
 fixes
To: Lancelot SIX <Lancelot.Six@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240523140809.1135226-1-jay.cornwall@amd.com>
 <20240523140809.1135226-3-jay.cornwall@amd.com>
 <6572dc07-fa47-412c-9ad3-ace0c3914cc5@amd.com>
Content-Language: en-US
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <6572dc07-fa47-412c-9ad3-ace0c3914cc5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:5:333::16) To BYAPR12MB4599.namprd12.prod.outlook.com
 (2603:10b6:a03:107::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4599:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: dba26a78-5b12-4714-e30b-08dc7b5ef422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z204aFBCdEc0TEk1elVsbFdEWlp3aVAySlhpdUhDK1VGdjFlZUJtakJnM2JS?=
 =?utf-8?B?Q3RHZTQ4RGI5Q3QwaUxJWVJRNVhaV21JR1NuUkI4aTd4TEZPY3V3WXJmNUNJ?=
 =?utf-8?B?TkdDSjBmVjQrYUQ4dTV6L0tHSzZ0VFpwQnVSc3ZmQStQSjhQQXdESWsrQUZU?=
 =?utf-8?B?NTdwS1g2bVlOUENyQWZ2VFdUc2c5RGFRMjA3TzJ4L29TWktVM0FFQ2lrV3l6?=
 =?utf-8?B?R1UrNXk1WGNpUWxxNHd1WURmQWNXR1d2QnFvWEhXSEpKdUVNZlNpaE42V1B6?=
 =?utf-8?B?R1dMWDVqdUo0a2Vrb3RoaFJSUGxDOGpRUm1TUm84STRFYUhzaDNjd3p6YjlG?=
 =?utf-8?B?NWIwMjV2MytlRGFBSUxPRVFvVTJIVlAya1JmUmxWSDRTRExma0k4WmxnM3o4?=
 =?utf-8?B?NVU0alJ1MDhEaDFtM2krYUQ5YXNsdnR4cC9vbFR5TVgwN2pLbVFwRHZnZEgv?=
 =?utf-8?B?UzNZVWdUYVFSenRNYkJFY2srcGozMURaQml2cjRJOEt3UGl0T0d5UXhKWThK?=
 =?utf-8?B?d2pKR1kwQzZpeE9CWVYxZVovalUwVU5wVWV2eDROUmY2dVRvU3JwczhwQVN5?=
 =?utf-8?B?T04xbXkrM2pyMVhtY1VkZkIvdGQyUHR1ZmRDVXcrcTlwR2ptbzF5QWdpeXZU?=
 =?utf-8?B?SEx4YjlyTGsyN2xWTW5KWUh0d2k2cnFiakNLT3dRc0Ixc3o4cmJGRUFRYlRW?=
 =?utf-8?B?aXJrL1RLTGxNL1RuNVArQkFEV0VwdU9ZQmNZZG1kelJBS2NkeFBZN0VkS09C?=
 =?utf-8?B?KzRtcDZwTGJLeHowaCt4Q3JOczVtZXplQjhrcy9EcWt1MG4wRitoVDBHRFVM?=
 =?utf-8?B?M2lIYXViL3BncnpmckJ3eEdkSFlraVhtcXlHMS9RMEJic3U0ZlpENTd5WVds?=
 =?utf-8?B?MFNJTW9HNnhLNmVHTnR6NUxOdG9aNUl6VjVWWnBjWE14RHhYRS92UWN4b05Y?=
 =?utf-8?B?dVJlem0xU05ORU5mVkJORFk3ZFIzSzNvWG1NQXZPeHI1ZjBGUzh5RURCdXkv?=
 =?utf-8?B?Q2s5L0pkS0s5VVA3WTdXYlg4ZnA5QWNvNEJEQkpjQ3FpYXpIVGljdUkrTGYz?=
 =?utf-8?B?UnpNMFNQViswYjB3akdKck1MVWNkTDcwdlFicTBGKytmNG5LdmJTaStvcVFI?=
 =?utf-8?B?d3FzQldNTUwxOCs4L29QOVVoZ2NMeStXMUp6Vk9lQmdFR0JraUJRQVJaZk0y?=
 =?utf-8?B?OHg0T2trcFFkUU9GM0xZTHJadHR3dFhnVEJabFZjTjU0bDZSWjV2cHBmQnJU?=
 =?utf-8?B?V0dEcUJBYXZLWGdYRm5uNDY5eGhPbDVjcFNnUjErVm1iMW9ySEVFTnpqVWN0?=
 =?utf-8?B?RXhSVmkwZEFiVW5SUEVKYTNrM2wxQzY2dFYzNW8xQ3dtL0tHVWxUMTMrT00x?=
 =?utf-8?B?RjBhRFB6SFV3T2U2TFJDUmdqQmFBRUNVMytDbjVvL1g5b2RQSE91Y2xJSmEw?=
 =?utf-8?B?T2JncHNsS0pwNEdMcktaUnhHZW1ZN0ZnOW5qSjQ4QkZJTjRJSlN6eWVNVGV1?=
 =?utf-8?B?WndnZXZDRVR3bk1ZRHZyRkZmdG1aRnVSOStSbG9HZDlrUGVtQkxnVjBtT1ZE?=
 =?utf-8?B?R2I2Wm1oczBDeFY3YlRkMWduVXFhUE02RWNHNlhhQnlwbnNDU0JkbFBEbWYy?=
 =?utf-8?B?N3hVN0pMaHBxS2xma3YxRmpjWHdnUTlBSVcxWk5EY0dlaFpRVzdFa0txN0w5?=
 =?utf-8?B?TEhiMHZsakFTdmpjU0JhMW9WQlk4Vm9pWmUwaEcyQW4wWDhBOUF6eUxRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXMvVnRIMjNRUzRqR0R4TjlNcURiNUhkYzBWWU45d0hSVmR5TDdIY1F1ZGRB?=
 =?utf-8?B?Vzh6aGRLVVhHKzVBZk5DQVBENGIvZlpaN3VQaVE0akhveHVTUjlaL3dqRnFQ?=
 =?utf-8?B?YUVPU0xNYkFUdHA4UDY2TWc0ekNQbjVlYmpJN0pBS2Y5dXhnZGhRMGdHZGYx?=
 =?utf-8?B?MzJFaEtRSzhpajQ0M1BCRHlnWERkbFhONDNwRHdnTlRpQ1ZCZUdFT3RDcE1i?=
 =?utf-8?B?K3dsb1ozL1hGNmVWNE9sZXhNdnFxejR2RTV3VS9jYnFvV2EzRGxWemFCanZH?=
 =?utf-8?B?Yk02TGI2VWtOYWpBVVdGRGRxQnpQaFhpbFJ5Q0hkTTZyOE5pLzRoNUlybmU4?=
 =?utf-8?B?bHZtcjAxcXRVUnNLWUJoYkg4U0lYemFHMGMzbng3b01WT2RqMmRZREJ4bzFU?=
 =?utf-8?B?Y3ZTdGJCdjc0a1hSRk1Nc1lZTUlqd2hzYkpiSU5Dd2tsRkE2dExtWk9OUU5T?=
 =?utf-8?B?Qlp3dGtTT0VpMkEvb2ttc2g2dnluMWtoWkVtc0IwNlhad2FueGFOSFpnNGF3?=
 =?utf-8?B?VTlrUXBXQ25oVk4rWkNpZkR4SjUvYXdvNDE4VkJ0S0NHc2tjN1Ewd2N5YTJ1?=
 =?utf-8?B?THBSOUgzb3h1djYzK0FWeDA3TnZnTlphRkJQeGRTMnpiVWxUbVZmcHFyTmtr?=
 =?utf-8?B?WC9NSnd5d3RWNGliOEtOVFhFNzFWYkgwRGJWd0JDdzF3WlZ3QjhJSzZ5a3Ex?=
 =?utf-8?B?K3U3SmN6QlZrdlRBQzNRYlVGVURvM2pTUFh1UmNlTFNRNzdqRVV5NW95RG9v?=
 =?utf-8?B?ZjJNakNqWFYyRDhyL3YxbDZEbm1XQUNPU3NYemlMV3czK2tCSm5DR2NWTzNW?=
 =?utf-8?B?N0VReDczakQxQzV5NXgwdzlGSDNMUG9oZ3FidTVaRHFWTURNYWpWWVlSdWhs?=
 =?utf-8?B?Y29pNnhYQUNtNG5qZnRRU0dqRWQ3eVBqNGVtQ0xZcUtqTnlGOWtrU3R0Rkh3?=
 =?utf-8?B?ZjdMUUJyc1owQWpIK3lqWW9PY2hCUEF6aEhrSC9TZmllRE96LzRpdEdtd2xC?=
 =?utf-8?B?U3oxTUV3MEIxaWRiVzcwMU1xTFNodW9EQmNzRWFUa28yMjdES003WWQ4aEtZ?=
 =?utf-8?B?cndUY3A1RVArRHM2L3IwYmc3R3F2TlhiQmVtbExjSHoyN2loeWQwRkNRV01C?=
 =?utf-8?B?dTQ2QXY4Z2hXYTRWdno0T2FuclNGd0FyS0NBSGJlU3hEV0pjR1Zyb3lQOGlR?=
 =?utf-8?B?NkhzcnlDbHlPVmsvWnBZa3dpaXkrRFgyZkZqUVNOV3RuRldSc1Nwb0VNV0tm?=
 =?utf-8?B?dUxPc0hTYW9qNE1XdHpCWU8xOVdQbUltOTZzRk0xSktLWmxiMFFKYTBhM3lu?=
 =?utf-8?B?Qy85Zmdkd0V0aXRhcGdzZkZ2UlRGeE9TYjFUU2hIYlVwZEoxQVUydzN4WEt5?=
 =?utf-8?B?YVR0SkFVQ1p1U1N1NXo2VTY1UEsrNnd5T01PS3J6MFRUYzFCRVFvS0J4L3BI?=
 =?utf-8?B?aHJxTHBLazVjc1RwSVRtRHF1bzc0bjJLS0wrTExPS1UwMzQ3ZGVuRVhGK2R5?=
 =?utf-8?B?eFVjeUk5cDRYRzNwaC9nRlVhZUhLYkp2R201NlpVYmpPbnhkMEpDNVVPNlFH?=
 =?utf-8?B?UVVSQkwzaEtQYzdiVGhLNWJ5QjNpVTUxUFFBVE9mNnM0VWlMYzUwQkVtbXVj?=
 =?utf-8?B?NlltS2djUThzTnIyUnZFb1ltMmR6SGlPQkc3TVpkbDZjeFRtK29yelVGdFNX?=
 =?utf-8?B?UElEWGlxeTkzY1R5UjRRM0Q2a2p1RDM0K2tmZ092ZWRWM0pRWjd6Uk9YYnlC?=
 =?utf-8?B?R1JEWjNjbVU2YUlhYXo0Q2w4cWxSaFl6WGVjL3BTTjBIaDVQaDlQUXZUVGxC?=
 =?utf-8?B?Z3JFZEF3ZWt1RVpub0VjRlZ1WHZVNWRQeTdPTElqYXZ4aUhISU1FbWk2cXNy?=
 =?utf-8?B?R2YyNjdhMUhJajUrUDB6YktoclQ5bk1VMk9WWGQrOHUwcENYajZUa2ZPdDV1?=
 =?utf-8?B?RHpDTWRhK0pxZERUZ0p1MGg2V0xBVHFUYlNWTDkvdHVYZjh6MVFoYUJUdmlv?=
 =?utf-8?B?ZGdFYlBzNm95bWRtWFFFSEhtSnhxMzF3SE9xTjh4bGVPRnRMTENLZ1JGUldp?=
 =?utf-8?B?M3Z2UVZDTHBsYUtVSlE0SHdFVno3TzVpVW9VVzdwOVEzTTZiM1c0WU8zNHlT?=
 =?utf-8?Q?6w2W04VJawARGIr/j8ZUWq3OB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba26a78-5b12-4714-e30b-08dc7b5ef422
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 19:31:33.4123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/On0BtJpwPMRBt8hh7BfcMsh7j+aejzedT8JmtJQJ5qXiOY+EDOcDNpr9SsM6F2cauaDKEA89XqV7emktnGyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690
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

On 5/23/2024 13:37, Lancelot SIX wrote:

>> @@ -622,8 +638,15 @@ L_SAVE_HWREG:
>>   #if ASIC_FAMILY >= CHIP_GFX12
>>       // Ensure no further changes to barrier or LDS state.
>> +    // STATE_PRIV.BARRIER_COMPLETE may change up to this point.
>>       s_barrier_signal    -2
>>       s_barrier_wait    -2
>> +
>> +    // Re-read final state of BARRIER_COMPLETE field for save.
>> +    s_getreg_b32    s_save_tmp, hwreg(S_STATUS_HWREG)
>> +    s_and_b32    s_save_tmp, s_save_tmp, 
>> SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK
>> +    s_andn2_b32    s_save_status, s_save_status, 
>> SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK
> 
> Even if BARRIER_COMPLETE can be asserted while we are in the trap 
> hadler, I do not think it can be cleared.  That being said, it might be 
> easier to just replace the bit, making it clearer.

Yes, I chose to structure it this way to make the intent clearer. We 
don't gain much from dropping the s_andn2. Most of the time spent in the 
save handler is stalled on memory instructions.

>> @@ -1351,7 +1369,17 @@ L_SKIP_BARRIER_RESTORE:
>>       s_setreg_b32    hwreg(HW_REG_SHADER_XNACK_MASK), 
>> s_restore_xnack_mask
>>   #endif
>> +#if ASIC_FAMILY < CHIP_GFX12
>>       s_setreg_b32    hwreg(S_TRAPSTS_HWREG), s_restore_trapsts
> 
> Wouldn't other gfx1x architectures have a similar issue when writing 
> TRAPSTS here?  That is if TRAPSTS.SAVECTX is set while we are restoring, 
> wouldn't we loose it?
> 
> And for gfx11, there is TRAPSTS.HOST_TRAP that could have the same issue 
> to some degree (not sure if we would loose the host trap completly, or 
> re-enter with trap ID + HT bit set in ttmp1).

Prior to gfx12 context save and host trap exceptions are not delivered 
to a wave until STATUS.PRIV=0, i.e. it leaves the trap handler.

The changes needed for gfx12 are due to a design change in this area. 
Exceptions are now flagged immediately and cause re-entry to the trap if 
any are non-zero.
