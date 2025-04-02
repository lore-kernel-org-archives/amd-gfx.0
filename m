Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A5BC28B20
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 16:34:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 905C610E860;
	Wed,  2 Apr 2025 16:34:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C1Mmrfs5";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41F4610E860
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 16:34:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOaVr6jbKDx/a2p1CUgkg8BWitUvk85/rx9krGbXjIUJW9vgWhS6k1E81bnILQsFDIZKmScdr2pDQH4koH0I7jvheHHOypRKPyX5mbkUqO/8Iv1kb983ETq4fkDRxo9a4bL3IThnKRtJWM7Azr5G4USOnGZKvtB+wQ/jkJVnnqK03P+90yi4q0qHBcCFW7YOX7B+X3jFQZNDJnDuCWlC2spPek8Ghcipii6I93cYhuozOS8q3OhOdcz5yzGoiCGflOAu1fWqCuKe7+Rc7dcNB88IAzpbkPwOaWwrJbBUnATLrfdfHS+vd9g4zLJDYUkuKWmIDr/cXef57Qlt5eB17w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWFU7A1IMUAqnaSOnkCPtVA2ORlUcTLs23/pLv0ElXU=;
 b=liOOj83cWVPH96UvIPpydEiA28r/4ixtX8qhrgx4MY0p1Heeolgh769flOWWXkVKgSKbd7P7KbDnRVDgyfiBy5kHspm5sUO+gsGA+IVOil4lklfnbddyHXIMK4d8/S+9B3fYw5FqSEeUJNICkk7pl1u2LOG7B/VATZN/oA0dtdBySOGkHt4p/fsgOIPLFnuxpmOciDu6pajQ8N4iVV+jXVbmeYub68axB3BddlcKJSbTjANcoBaNCjdLZPRMqd5lRQr8/p0HTS0qABPsY/P9UoiQJoGHsAVLxJKYpQq1aX3JiylUTtUPm3v+lkFsz90Ronro+ZoZAxGuv19v69IyDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWFU7A1IMUAqnaSOnkCPtVA2ORlUcTLs23/pLv0ElXU=;
 b=C1Mmrfs55dEB2Jt3XFzUmJdT0fHhJ9GlPiWp2W5DeI6LvxRm4pMWIC0VUafr1BMfL2fL6+dd8loHDxRgvgfSFho4trQ4ZoK5GUDYptfM1M3+6NfLzJN0Rd7jztjeS585XlV++aqh6dYBenBv1bFC2JorZIQpNj35oxGSiJXtEyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8404.namprd12.prod.outlook.com (2603:10b6:610:12d::17)
 by CH3PR12MB8512.namprd12.prod.outlook.com (2603:10b6:610:158::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Wed, 2 Apr
 2025 16:34:02 +0000
Received: from CH3PR12MB8404.namprd12.prod.outlook.com
 ([fe80::6828:e34:9cd3:9cba]) by CH3PR12MB8404.namprd12.prod.outlook.com
 ([fe80::6828:e34:9cd3:9cba%5]) with mapi id 15.20.8534.048; Wed, 2 Apr 2025
 16:34:01 +0000
Message-ID: <c7226b8f-ff7c-4e7b-b3d9-e3792a1d5369@amd.com>
Date: Wed, 2 Apr 2025 11:33:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Increase KIQ invalidate_tlbs timeout
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Kent Russell <kent.russell@amd.com>
References: <20250331154456.1879064-1-jay.cornwall@amd.com>
 <be35f643-0006-4a12-be34-2b0f02cb3a5f@gmail.com>
Content-Language: en-US
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <be35f643-0006-4a12-be34-2b0f02cb3a5f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::31) To CH3PR12MB8404.namprd12.prod.outlook.com
 (2603:10b6:610:12d::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8404:EE_|CH3PR12MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4745a2-85e4-4ef0-4fa1-08dd72042cfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S3pzQzQvOUQzK0JXSldhanZGTmt2MEIvTG1WMUJSSjBmTGVtamRRZ1R0ZjVo?=
 =?utf-8?B?ZzNmbkRHWDNLbnRvaG0xYlUycWtHTVYrY295QkNORnMrVDd2aTkySk5ZUzdx?=
 =?utf-8?B?R3FQNytSVEdRQ1BiQ1pPcWVJbmdnaUpKaytMUkRpTDR0czAwYnpuY2FMc0VK?=
 =?utf-8?B?Nnd3aEF0YTdHZnNpcU55TDROWHlYRzEvekdyS0VtOHdPTU9xSlNBWFlodVgx?=
 =?utf-8?B?aG5yRVlTRTNwUUZkV09SbEIxOFUwR01CemFuY0FZTEwreTJXZEErK1g1bVo0?=
 =?utf-8?B?akkzSEJXQS9PaHNaSTZ0Q2hDMDUxOFhMOG03dWFSb3dGQXFVT1NlZ0RPRmtX?=
 =?utf-8?B?UWVzSTYzTWJFQ2Rvc2lQeDVPMnIweHdOcE0xdkFvb2tkUks3M29wd3Y4MnNw?=
 =?utf-8?B?OEpmWmMxNWlaRVQ0dWVNMG53Z1IrWFdpU3BRMDFvMGZDMFZkTnNrUWY4YVo0?=
 =?utf-8?B?QndUcnNyZDFVelRaeTMrMWNIaTRETUx4UEFFOVJDUUkrN095NjJMUThyUlp1?=
 =?utf-8?B?ZFJxbW5IMmZjUWx2dzczaURlM0lZNTc0VGJOV1RtcHB3SWNLMkdrREM1N0lY?=
 =?utf-8?B?L2wwZ0Y0K0dnYXdYZTI4NlR1YkR2QkI1VWNCaFl3dGVqNzA4cWo4YWRjbWpK?=
 =?utf-8?B?UGQyVCt0WTFWNGk2VE1Ed01TTHBVaVAxMHl4cU9kK1JlRFVhT1l4ejMyb2lv?=
 =?utf-8?B?Zm4vL0ExVHFPVHRzU0FEbDBSYmxNLzZZWFpMV3Z6NFgzQ1hkTjY1VVorOUFG?=
 =?utf-8?B?UHY1blNQdTZWS1o4WDlEVThVenpIamhoRkZPUDFZelNkWFVwYVF3VkoxdWJK?=
 =?utf-8?B?c3ZvWlNqTjVleGFZKzJyYnl1dnlhYUZhQnRHMnFzYTYzV215Z2hyLzZvWmFs?=
 =?utf-8?B?SkplRnVDOEdvKzM5eE0xSmxyR0puR1FleUdlaG9RZktnQnlpY0NSMk1mcURu?=
 =?utf-8?B?Qmw1OVhNMzBDZFl6VDd3MzB2cU9GTzh5MmJXMFVsSmFmeFJnZGszZERLTFIv?=
 =?utf-8?B?Zmc5OHBMejl0K2N2R1gzN1QyS3QvT25YZ3JaK1NpWTRVMG9yK1JkTFgwbW5t?=
 =?utf-8?B?YmwxYk91TmtPbGZmb2FnOW01SGVrVk1ZMlZYb1NCQ1dzcXlEVEpoeE1QTnMz?=
 =?utf-8?B?WGdUSTNpTERmOFlFMTFNSUNzdndsMllpQVBkOE4rRnZUZ2t3bXArVnl0WFdw?=
 =?utf-8?B?dHd6dTFTb3M0QTdET3ZVd3B2clA1WUU2bFhDQTF4bmhDQXBzQUd4WXVyWVJH?=
 =?utf-8?B?bHVnL1BQTVZ1ZTAwOThSU3BUcFpKdjJiNUd5NnNFZDB4VmhLK3U5bk1mNDFT?=
 =?utf-8?B?ZEtnTDZ5U0dZQTF0dEhUZFpVck1JcVlZZ0tTMnlaSWZ2cmtwSHU5V2kxR3N5?=
 =?utf-8?B?UEFxQmhyS3lhL0hPZm5Veml2TzA0WFNSOHMwYXJMTUVQQlVWRUlNc1BBeTdq?=
 =?utf-8?B?VnJadEQya3JjRkthdHpqZUlrck1RMDUzZlE5ZCtsMDJyZmIrdXJISHNMdFRP?=
 =?utf-8?B?dmxoUG9CQmhwWUhWV2NmQWU3UUtESkVDcXZ4eUJ3VzRFZmxFNXJHQm5VZHg0?=
 =?utf-8?B?K2dOYi8wY0kxZFRqT3hyM2d6WVFPTDE1eWpCU0lkUUlNSzFrL05aRzAwMCtx?=
 =?utf-8?B?aDdwTU5CSzJmOGhkNlVPc3hiZzNMdWpGdFp4ZGVsTFR5NVpGWWxuZTFJVUdT?=
 =?utf-8?B?V3FlWE5aWjR3VWFta3llRHBJR0QvaHNrWm10Wk9CeHdHK1Q2bG1qemdHOEhm?=
 =?utf-8?B?ODVOaHRReWF2VnVlcW5Qb0lDZzI3aDlKZFRFdzVCQkVYNUFialRwVjJaeXhq?=
 =?utf-8?B?bDBCZnBsM2pITUlIQ1ZTNENlNEE5VXlIOEZxbUIwaGpCZzRqd2tCWVdGNFRP?=
 =?utf-8?Q?5ApqO4lSNTYXQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8404.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzRWdjVzRTlKcmd0SW9USXRpZmVHQ3ZIc3RlUmRFbks0YkpFazh0b1o4ZW1o?=
 =?utf-8?B?RlAvem91aGgwSjBhaDZJSk5PT1NvREpBK3BBanVpdDUra0x4WHBNL3NxV0pz?=
 =?utf-8?B?bjBJRTFVSG5ITFEzVXpvREtKYkNuMmFneTRUbzRkZ3ZBaWRtSDZNdzEvZEFk?=
 =?utf-8?B?ZWJ5TllhZ3NxZTlXbW0yUzkvMmpycU9LUHRIME4vTi8vYWJEeWpOMWd0SW1D?=
 =?utf-8?B?UHRqRXpXR2x2clB1R29ud25VUE9WWXk1WlZZUThQZVJkZTVMc3NtK0tZRGRi?=
 =?utf-8?B?bWYrcEJDVkNCaVRnaHhtbHVVNlZKaERkUTVTcWE5a1JYdXFiY241Q1VaaGxZ?=
 =?utf-8?B?Y3dHTnZLeDQxWnpSbHVuZEh3cHVyaXF3VXNDZ2pNdFRvdGM3d3I3RldrTldX?=
 =?utf-8?B?d3N5WFpPMnRuVXJRdzc2Q2JWb2NjODAyb1Z0ZHpXTXJnWFdYeUhIT2IxRGxF?=
 =?utf-8?B?VTVWemdvRW9PZTdEbjUyV002NFM5Z1ZBZ2MvQ2I1bVlrNVM0QVByaXF3UWUx?=
 =?utf-8?B?U2s1TllBVnpIMXdBcVZsQ0NUQ1M0VmFYQTdGMGZ5dGhlb0poQU5LOWJBMkZP?=
 =?utf-8?B?eWtSZVpKdTUzY2FBd290Yjk3Qnp0Y2Rua3VObDNPSlRTdmwyL1F2eVp0Q1Y4?=
 =?utf-8?B?YllUQWV2MTBMUEVxTE9Ma1NqS0QrbzVndXBHMDFHUlUwdjZSRDVQL2pNbzQz?=
 =?utf-8?B?YWF0clh0K0diOUxNa1A5dC9zT0w0QVgvOERhZ2NETVNsbUNvbW44MDgrVDJs?=
 =?utf-8?B?anNOc1RIZ2FNYWdkb2VTcnVXVWNLZC8vS25tYVc4Si9DR3B5eVNuUjcyODRp?=
 =?utf-8?B?WjcvTUNESXBna1doZGJ0K0l0cDB5SzF1Sy91NllpSnI4MERqT1U0Mmt0UzFB?=
 =?utf-8?B?WDBpVlhzbWdEYld5VkU4bHBETkhWd2xuQ3ZES0hMM3VLQ0xxTkNUenNMeEsy?=
 =?utf-8?B?dFk1eVF2T1lYVTVmcGlYYmEzWStrMml0Tk1oYWUwYXBrMVo0ZFF4b252VFdC?=
 =?utf-8?B?NysxL05TTFIxOGZEVmk1Q0xqTXZ0TFUwUE95RVAybkk4Y1BWQW5meHNyN3JM?=
 =?utf-8?B?R1cxNFk5VlFxVThESzUvWDNoVm5lSCtYbmJIWnhacVo2SjZRbmlBMWZUY0tr?=
 =?utf-8?B?K1NaakkybWFuSVJETXNQWFJsNERXbktNK3o5cDc0UVZzcnB2UUp0YkhiYTNH?=
 =?utf-8?B?VVRWSktlc3FHbzFxL1QxdXMwMjNWNE5zLzNkVjNpWGZ4MWpwM2s5Ukx3TWtj?=
 =?utf-8?B?VEl3enRJWHJJK1hGYjJhYkdMdkFvWDQxVy9SUFZPZ2d3MEwxUzJBb1d4RWdW?=
 =?utf-8?B?Um9ZWEtrc0RmMnBaVHhqY09jSDFvUi9GMW9Da2g5dFJJS1J2L21lNmV0Q0Nw?=
 =?utf-8?B?R0JTOXB5SURhRE45K2k4bVpqdjYrUDV5VHEweDhrQTRydEZQM0NiV3ZCOGt4?=
 =?utf-8?B?bkl0ZE5iVGlVT3BJVGdVdDF6UHBzQ21lamFCWHZaZHdIVzFwM0pQUDhwZmcy?=
 =?utf-8?B?cUxoQlM1dzhkWkdMbDY3cDRhSUhKWFN2Zis4RjA3UTFsUkpTSGcvTGVKZGdZ?=
 =?utf-8?B?aHIxTS9lSlZPUW91bHM1N2FyN1FBOG9ZYUV6TW1ncno3eDRFd2FYYUUyODZM?=
 =?utf-8?B?VVU4ZGVaNTBPQk8zQkt0dkQrVmVwVCt0ejhCVHhvZXdnMWdySXFxNmp3bzln?=
 =?utf-8?B?aDRMMi9ySGdVZ2FOdjNTR2lUMWl2TXJ5VEpFRU94QklLTklDUm1BTE9VaEEz?=
 =?utf-8?B?RGFOQU50Y3UwOW96T1RsYk1WcHkwWDJxbTNoTU02dUVVeGRTK2NsQW9Bc1Iy?=
 =?utf-8?B?Z0JuajlmTG56d1VqSXBWRGZZMURxNnBrTDl3emxlWWFrUit5RmhJS25iMXBi?=
 =?utf-8?B?cG9iV0pZSTBQbVg3K21MZFdOalNPTnpzRnZHdkdhM3hWUUVlSTdEVloweXox?=
 =?utf-8?B?aXpIQ01KQU9xaHBGT3V1TDNyWjR2STNMeHZzbFBTVm1nUHNaTDVCdVR0VnVV?=
 =?utf-8?B?RVBUNjlTYzR4Qm91UGQxWkh2aUhOSFVzZVEzcmFDWHdOU2RKVG0xNEFMc3RX?=
 =?utf-8?B?L3ltSTJIMXFBSFZDQzdZcVhUOFIxSVFRNFd1T2xZdFJ4dktrTHg1LzgzcDg1?=
 =?utf-8?Q?D+ctia6n3tQ769Nz2b8aQDkFE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4745a2-85e4-4ef0-4fa1-08dd72042cfe
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 16:34:01.8874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hiWSlcj//A2HwDH5mZKiFP7CULluaEsrI8zcJpeoWG1EsT2AFgylfHF20q7a+nQqwLSDM7aPZVMzeIxZ4Wicfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8512
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

On 4/2/2025 02:37, Christian König wrote:

>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index ffca74a476da..3cdb5f8325aa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -356,7 +356,6 @@ enum amdgpu_kiq_irq {
>>   	AMDGPU_CP_KIQ_IRQ_DRIVER0 = 0,
>>   	AMDGPU_CP_KIQ_IRQ_LAST
>>   };
>> -#define SRIOV_USEC_TIMEOUT  1200000 /* wait 12 * 100ms for SRIOV */
>>   #define MAX_KIQ_REG_WAIT       5000 /* in usecs, 5ms */
>>   #define MAX_KIQ_REG_BAILOUT_INTERVAL   5 /* in msecs, 5ms */
>>   #define MAX_KIQ_REG_TRY 1000
> 
> Unrelated to this patch here, but defines like those *must* have an AMDGPU_ prefix.
> 
> Please fix in a follow up patch.

Sure. A deeper problem which has led to these macros is the duplication 
of polling logic across several different files.

We could instead move this code into amdgpu_fence_wait_polling. All 
clients would then abort early on in_reset or in_interrupt. There are a 
couple of users with different timeouts (adev->usec_timeout and a 
hard-coded 2100ms) which could be unified or retained with a fixed 5ms 
polling interval.

adev->usec_timeout is too low for this particular system under load.
