Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D995CCD195
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 22:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93F3210E1C3;
	Fri, 17 Oct 2025 22:34:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uvI72WM+";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011061.outbound.protection.outlook.com [52.101.57.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACE9010E1C3
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 22:34:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2lyMjOZs3zvEZ+NjePEE9wvhJukiWQUoD07E9wgw0BJ0xb+TM3nRrCfXORUL0vvxJ3yz/xuxaWRaJKNlxlPadvl3rLyrU5Qka949JB2MwTCfmHaAU+4+9ombd1YQ9EShis8LEsXw4lLNW8C2u4dttG2iFrc0s1MzndORxU0JaZfYFfr6X3/Fyu73P6UPJ8gyBCplTRIwgctkOxROaTFcF3F8H+WqerXhO0xD2rG6G8s4e+TT/22KvVQzUG+INctaivUfOyaLAwE2SmRWPhGldm8dEK+KTcJwaOzK2OE1k/B8oO5bJDVLc4lJQtL7e8og1vT+5Vo5K4sjdz5TvbWvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isKxZ/C4aWcepfdhnAH+SmHrHw8E835/faZ68z4ZbuM=;
 b=EQylnoEImXneCYLKzx+j+S35sR5MHoZ9hGWj8EAe8oxkoBysC+53YlKXfi71TXuUdYyLH5JOd6S/0KBBjVIpJMRA+2wH5QmIivxB34Exy0U0/s5/MTIrPy9DIW15mOaJpwQV0jMbKqjMcCdcMwtRiyVOBfuJFiAOWIsNAMHl39+rZ9j2qxmEkKYFuNJ9DXRUcLXobxx32yQ5ej6EZbjKWrCNdXwY0HUvKnpQ6/BFZm0xvVk4BlXe/aqMyb8/mhMAXGLxbYTUBm3luoChMcB3gT1U9sZ6PV8g9HFRQc/6juUGkyKxuAOPJXram7bPNW7XOAn2BTaOujb7jda5oZwWkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isKxZ/C4aWcepfdhnAH+SmHrHw8E835/faZ68z4ZbuM=;
 b=uvI72WM+JLcLLiTY9ocDYLXTw5SPR4jNN0HwG4zxPaFKORjkRiZFyq+49Lplzom7RiWmr5X9BK3uy8wOBaNtewrDRs4UNr7bL8f+4+DqIUGYsMEtLmA2tR58eKWgpmJ6fAFnuRLJZRiFWvhpajEfe8w0tUrzJMsk21h8721MWFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 22:34:22 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9228.005; Fri, 17 Oct 2025
 22:34:21 +0000
Message-ID: <4296fed2-18d2-4c75-bdb8-a364a61ad864@amd.com>
Date: Fri, 17 Oct 2025 18:34:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdkfd: Stop user queues when process mm
 released
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, Philip Yang <yangp@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251015201134.2540-1-Philip.Yang@amd.com>
 <20251015201134.2540-2-Philip.Yang@amd.com>
 <29dd1aad-26de-49ac-9d25-c3dffa862705@amd.com>
 <c0daed21-77b2-664b-ed63-ae188fff2f06@amd.com>
 <3bf66993-7a24-4657-a264-cc44df5fb560@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <3bf66993-7a24-4657-a264-cc44df5fb560@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0145.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN2PR12MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: b24b13f3-ab5c-4ee7-8253-08de0dcd515a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yk41WG5MeEdpTUdmZnRrYVI5WXZvMnRJdkV1eit1VVBwbGZQU2JtRko3MGww?=
 =?utf-8?B?N3ZzbGVPV2JaeUZmU01EcjArdUpzT0NxRnNsOG5yQXZVK096aHJrUHNxNlBQ?=
 =?utf-8?B?SEpVSjQ1WXlzME9uV3JNckF1KzR5ZThVK1NxZEwxQnFKV0M2b2hoWGRhc2hm?=
 =?utf-8?B?dFVpcUR5Q3dwUU5OMTRrdGc2d0FNR05Jemh0Q3FvOEFObkhLK2Z2emlXVEtC?=
 =?utf-8?B?QjhXOW83eEM0dDVMRDFPb3h2bTJxekZ3L1FWRTFFSk01VWtsQmNHQUN6c3h3?=
 =?utf-8?B?MEMrYUVQZG1Ec1RKY1ZlK0paZkMyemt4aU54S2U2azJmTTNrcGtJTjc4bGNm?=
 =?utf-8?B?VVNEN2F5R016NC9QVEpoVUtvU09odU9oTi9neTN5Z3ByNFlQZ0d2RkpoYndh?=
 =?utf-8?B?MU9xa0h6TzB5QkZjZ1h3MkxtMFVVdkNuQkloa01mek1zd1BxakdtQ2hpSWUy?=
 =?utf-8?B?UnZZclNBSTVBd2ZmQVNxYVNVTlpRM0dIRGd3SjhXTDc2blFiaEt0ZHd1S3Rt?=
 =?utf-8?B?ZUxYYlJkdVZXWEVOMlJEVnN2Ukk2TlJJdVVpTGZrQmovZURxdUgrazY1dGZv?=
 =?utf-8?B?VTAva1Z1RllzK3JiUGFYT3JxRWZ4cjVkK20ramVBM3RocjJpNFVUMDZlTG1X?=
 =?utf-8?B?Y0hMSGRjWm0yMUJUTk54TkYwejUyY1l3dExxdWNBZ1A1azBadWFrL3paQUVB?=
 =?utf-8?B?MVhMM1BCTXZsaXBKbHpER1lwTHlUTGpsNGlTU3lnSFhYRmJ0UHBOMEdQK0hy?=
 =?utf-8?B?N2cycUgvQ0ZiNFRyb0tIcE9uVDdjRDNncGJmeEp4QmtRNVU2cG1qN21rbTI5?=
 =?utf-8?B?bE9KMTJUV0R4V0ZaYjUzNXVsK0xpR3pEMDRMeEFyYk05eUlZOEkxTTdReWRC?=
 =?utf-8?B?NkVLRzFTK0pkSWhNVEN1eFd3SjBoYmZmTWc0RktCVmFOajg2eXFLb3pTcU1T?=
 =?utf-8?B?VVdaNGM2YXluVUJnMVpWcG9qL2dJcTRXYXZUV2ZPTHdPVGg5ZUlOaXc0M1JQ?=
 =?utf-8?B?QjV3UEZNaGtESjNzNmdtcVNQWTlGazN0aDBwUGhPLzVWTWlBRjYvcFVXU051?=
 =?utf-8?B?WGZZUnd3WkN4TkNkWEo4UWRSTTM1VmUwbXVleXJiZlM0bFdqMnR5emN2akVZ?=
 =?utf-8?B?M0pYbjZIWlN5T0ZLZlQ0azlLMTZncmFkdGF1OVlsK3J2Sm4rcTVySmg4d3o4?=
 =?utf-8?B?MUxGL241UlBqN1FLNnJCeVkyUkhyS1Rra0N3K3AzbTIxMEloOGlUYXNHTmFy?=
 =?utf-8?B?ZFRjRy9yeU5WbzEraTVNNlFCMFNNakZhZDlPbmQwVkduenQ2Um1MdjQ5UTJo?=
 =?utf-8?B?OHVLeXFHK2V2UlVTbmNNa3l4ZEpGcUZBdC8yWTZzTzJjZFNYbU9pZlUySjE4?=
 =?utf-8?B?SEZlQTdpalA3VWNScm1MT3Z4YnQxTjEvOGFXTDVQY1gzM253NExNV2NocHRR?=
 =?utf-8?B?NWdyNTB5QWNPZ1dmTTNWaTROTzFQUmhZaTlJRGxwTVZhQkJQOHBXYUhOR0cz?=
 =?utf-8?B?UEVmaVNmTzludC9Fcm5aRjA2TGxEQ2xkNENtVytvM1k1ZzdkdmtadEJNWTl3?=
 =?utf-8?B?SDdPckVpNUJPODBCY1JnMHhYSUVaMlRvM1ZRdGtSU2Y1bDFhMWNzeHhEdklh?=
 =?utf-8?B?ZmFwa21VNG9PamdmSHVvVkRTQW1rQkdNeXZ4M2gwLzlaSVpZcjhsYmtvS2s4?=
 =?utf-8?B?ck1KUHR1SEN2aWt5QnVlSWluMzZsOE9palMzeUVXemJ0YTJ2alNiYSsvMGtB?=
 =?utf-8?B?b2s2d2NqUWZxMFFSdURoaGpwcCt3ZEVmR1V0TXB3VnpMUkgrRDNHdHBRRlA1?=
 =?utf-8?B?ekJpQjRHYzdTclkyMkc5NjZlbTlxSE1qMWxHY0lqZ1MyUGFseEsrMndjT2Jj?=
 =?utf-8?B?L3RscEFhWGswR0pxWXRjWEwwUVFTdnBkR21UcmRJWUd3OHd3ZTRkcld6MUZ1?=
 =?utf-8?Q?++YqmpHX+cdFH5IpnSubxAdY8eTcwvRo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU55dmRvYjEvUzMxVVI5QmpLdUlBZjB5Qm55UGNxSXVSa0VzNkQvUEJZT1ZB?=
 =?utf-8?B?ODgrTk10bnZSaytzWWM3djJoN2d1Qyt2eHN0OEdEbm5nRXQwMWRaRXNaWFNi?=
 =?utf-8?B?aXlyaVNOcHdBUmkyUHEyNmRERDVYY0FTSTMxb3BTb0ZNRm9obFV0SnM2cjVi?=
 =?utf-8?B?NmdEU1VxK3BIWjAyOEpidXlSN1pabVFvM3I1Tkg3L0JyRVFaK3p1N0ZDdmZD?=
 =?utf-8?B?WUR1eXNOeDBYaTg1UjBNTlY5Q3lxSjhqMldoaTUrbEVQTFBhUjdPY0FnQWVj?=
 =?utf-8?B?V0M3SnR3L2Z6aGtKTFI1aXduQjZLdkVHWmlHS2FmN0VHaEV0amFoS1luQUJi?=
 =?utf-8?B?QWc0Ym1hWG5zcE9rSExUbUJudHBzZDVuc0xBcEo4UzJlMnJaQ05PcldGWkg3?=
 =?utf-8?B?bWppR2doSU5vZVZRY0N0aktNTFNPWkpSbzdLQzZNSnJoNmFCaHdhMUtDQ0tm?=
 =?utf-8?B?TU5ZNjB6LzlleEVpWmVseWU4RVg2QzJzM0tuSWZ1Y0hjaVN2b3J3MWhZMDN3?=
 =?utf-8?B?cUJ6akV5WVlrQ3UwNnZGaitjdUxTeXJ5d1IwWkFWdjlqSXlYVG14RGQ3RVpa?=
 =?utf-8?B?T0EraU9Ma01sNkVJeFpyTDJKRjFFTnNFZHM5Z08wZ2ZXdEh1QXNqSmltWjd2?=
 =?utf-8?B?RkZIUk5BcGxOVDA0UTVFbVlGUU0xaWRlelZ0ZWFYVWprMlNUVTFvbDVpRkNo?=
 =?utf-8?B?VGhORHpRbG5iY1g1R3BnNi9kbnNzUmFoTFMxL1M0MklzNm5wNGtJMVVweFh6?=
 =?utf-8?B?QnUvcjI5a0lxcXZ3YlBZU0F0emJPME9kS2lCQ0pBNkpWcEJwc0lCUDN5UDgy?=
 =?utf-8?B?QWFVQTV4K2N6cEdiajNTMG42U3hPcHlJYmNrejhNZ0hQS1lDY0MvSlBSNHlm?=
 =?utf-8?B?TWxRUXUrRUQ2L2N5R1V5YVRVNXd6U0lvZmU0OVZxVDkwNldYMit5ZEZBSllR?=
 =?utf-8?B?UU5qeDFvd1h4QUtYbGtKbm5hQ3MyeUFkcExqZldjZGJ2cUh5UktQbkE1aWs2?=
 =?utf-8?B?SU1EOEcwbTBicWZVRGVsTUkySStuNUN6aHJFSXg2QktRZTRDMDB6aE13UE1I?=
 =?utf-8?B?eG5rVU9KbzJQUDhQVVBFRTFLT0dtVnBubGJNbEpEandxS1hCOWJ4MCtEdE9I?=
 =?utf-8?B?WG1iUVVDdzJKNmlOMFJwVFlMek1aSVMwazNHUWdYSFY0ODB4Z1cxZGhQQ3NR?=
 =?utf-8?B?ZWczcDZ1WFYxMkRMblM5TEQySGQrbnNGbDNMK0tUbGtqTHlSRnlSUXFJNzZi?=
 =?utf-8?B?TnRIYXhtd1BISEp6RG5zQjlxcWowdWdTeEVFZlhRanRaT2dZTU1Pd1BBWjlx?=
 =?utf-8?B?WXIrWDZkZXR4YWliOXNWcXBwcWp3c2hwMEliYlZvTGhDOTM4MnF6a3ZYdEJw?=
 =?utf-8?B?UVZlNTVXZ1JHZzJPb2dOMWJHQkNSWk5yaVR5L3FmSjA2bnJqTXowc2NiclMw?=
 =?utf-8?B?dUNiVjQzSEZpeG1POERkdUZpd3JsRGwxOUpiaEJvaEw3Rk9rRkExVUVWNzZQ?=
 =?utf-8?B?WUhyN3VNWXF5OURiMlp4Qi94OUtXa0pEMndOY0w1TURZQlVFQ2F1M05FYjQ3?=
 =?utf-8?B?bUFSUlU1c0F3amtjSWtUL3Z6elpkYkdJWS9SSFVCenRJcTlTbzBtWDIyYXQv?=
 =?utf-8?B?YTFXelpqQjdFcS8vWFFvRlR0TUxvcVN6OUlZRTZqTWRrZEtVOG1PazFaN2FP?=
 =?utf-8?B?OVpISWhodk43Y1VxSWw2VU9lSUlnK1YyNGFmdnc5cGt5cDJJb0RwSUNTVFFa?=
 =?utf-8?B?V3F3ektONzh4Mko5Sy9sV1h3RmQrcnpHNDVBd3lmdW01Zkd4U2tnOU5sSlYx?=
 =?utf-8?B?TzJxTnkzZWx3Y3VjUGVlRUpCMXh2Y3UyOHdNT1ppU1BMZ2J5aDhNeVJQeG1F?=
 =?utf-8?B?TmtINFkxRmJMUWVhMlU4ZjdOaGtxaHdEOUZHUms1ZUMrT3Jmc3ZwN1piUXdP?=
 =?utf-8?B?c1lIbVpPTGdNekN2dlRtYWp1WWNTRmhJT0I4amRKWXEyR2ROclUzYXNlc0Vh?=
 =?utf-8?B?dFgreUMwSFVwR2g1UTVUb21yYmdjQmo2dDZnMmlLc2t2R3VES2l4cVdaeUFj?=
 =?utf-8?B?dmd0OFdLcStRcmViNlF1ejV4eUhOMzcrL1JqSnlGRmRSQk1Zc24ycXh0OFVi?=
 =?utf-8?Q?IeauxmAg+3MwrR6nJIKy4j0z+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24b13f3-ab5c-4ee7-8253-08de0dcd515a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 22:34:21.8952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0uThoBLcVAd53tqW9/jUhulf/CcXpsPRnC2SgM0ZHVgt0chrsg1vO3bxFxfsY5+iMRyud56+UCydcurQf7FQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
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

On 2025-10-16 10:46, Chen, Xiaogang wrote:
>
> On 10/15/2025 4:33 PM, Philip Yang wrote:
>>
>> On 2025-10-15 16:40, Chen, Xiaogang wrote:
>>>
>>>
>>> On 10/15/2025 3:11 PM, Philip Yang wrote:
>>>> In mmu notifier release callback, stop user queues to be safe because
>>>> the SVM memory is going to unmap from CPU.
>>>>
>>>> Suggested-by: Felix Kuehling<felix.kuehling@amd.com>
>>>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 7 ++++++-
>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> index 0341f570f3d1..e2a0ae0394b8 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> @@ -1221,11 +1221,16 @@ static void 
>>>> kfd_process_free_notifier(struct mmu_notifier *mn)
>>>>     static void kfd_process_notifier_release_internal(struct 
>>>> kfd_process *p)
>>>>   {
>>>> -    int i;
>>>> +    int i, r;
>>>>         cancel_delayed_work_sync(&p->eviction_work);
>>>>       cancel_delayed_work_sync(&p->restore_work);
>>>>   +    WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
>>>
>>> Use warning message or debug message? I saw this WARN are used 
>>> several places. If the queues from kfd process p are still running 
>>> when come here we need to stop them. It is not error. debug message 
>>> is more suitable I think.
>>>
>> The module parameter debug_evictions can be set to true, use WARN to 
>> dump call back trace to help understand why queue is evicted, by 
>> default debug_evictions is false.
> I agree stopping  kfd process's queues during kfd process release. 
> Just wonder if change WARN to debug message form. We can use 
> dump_stack() to dump stack anyway, but it is not relevant to this patch.
>
>>>> +    r = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_SVM);
>>>
>>> The evict reason KFD_QUEUE_EVICTION_TRIGGER_SVM is not good here as 
>>> it is general kfd process release. Maybe need another enum value.
>>>
>> Define new profiling event requires rocprofiler API change, 
>> KFD_QUEUE_EVICTION_TRIGGER_SVM seems the closest event from mmu 
>> notifier.
>
> That is awkward. We may add a emu value at end that rocprofile would 
> not know for now.

roc-profile collects events in the running process context. This only 
happens on process termination. roc-profile will never see these events. 
So it really doesn't matter.

Regards,
   Felix



>
> Regards
>
> Xiaogang
>
>
>>
>> Regards,
>>
>> Philip
>>
>>> Regards
>>>
>>> Xiaogagn
>>>
>>>> +    if (r)
>>>> +        pr_debug("failed %d to quiesce KFD queues\n", r);
>>>> +
>>>>       for (i = 0; i < p->n_pdds; i++) {
>>>>           struct kfd_process_device *pdd = p->pdds[i];
