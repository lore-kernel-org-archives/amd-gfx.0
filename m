Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4F7C52D73
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 05:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72E7A10E647;
	Thu,  8 Aug 2024 05:51:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JokMkWpu";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C9C210E647
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 05:51:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgOu7Uc6LGUb/Saq9vb/pMUYpehs+0o4/65QplF9Y81z36Y08mbL3gBaH7D+QAtcJ7l79z4W7RvVN1HzV8G0ienXVEQ20dHvczjj6yn1CCENapAwCAahLcb9cIU/tRl4weuDusgUbHboD2tKbHrqaalmdHSR9ZYTipguQXfVB4VxMalrGN7Ekdfwn2afJ/eGCdHUrJTNJTMI0bJVtduiR96yiYDOhdYUT2k915/TY74tz8uxQ12ceWpDDTxssiVtBV63JfMjWbSJnsm8PO699F9zB9marBHXDvVb3M/LlE7jt+zpMDDIPXJkIfPjO63T7nTSZC53kC5XR71fvSzJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HzxtcSoTwtU5yAvPSXQufAjgNcuW5OSRoS138TUQsA=;
 b=zIB7dXDjPTE2hjWUJvoo4TdhLuPb+YSxIaEIkKV8qbmIZA66Lq5AofJAgCnkiU7GbjcGogBDWWt4m6S+WTQplBdgmwT/fQOR1N6m4HzYFSPnV4i8IjDlpdjk/PyV+WJhY3DrzUuehZvtY4Vg15n7uCCpGh3Yl5bG8+fjSa9pGLEEux32RAf5ATYBooXGQUjmINQPxY2Kk57mXNzjwGWLH0cuhEpUL5tfEFKuWJM5qF9IijB6XlcHatV8orvCITtybPwqPHlAZesKxMjVc+LV3jtCaScR+LB1Z2Ux52CQTw2/xjE9mFSdP1KQgplrbz8sCHs4KGV25GHsP2GAhxOISQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HzxtcSoTwtU5yAvPSXQufAjgNcuW5OSRoS138TUQsA=;
 b=JokMkWpuJbSsvxSE72aolt+R3IoWyedwdDhOjCJaKqu4SmIZbWUlCAP0q7SOLY7xB9HOG2JW0kPpjD6jykvWG7OIwu09uoAn2Nl3J5aju/U7uOLzh8q5LzRnSa8GzxAcF8dreQ5DWiggi/qZiZEHFNcnZ/xObUjnugxYPBZzQ0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 LV3PR12MB9330.namprd12.prod.outlook.com (2603:10b6:408:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 05:51:09 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7828.024; Thu, 8 Aug 2024
 05:51:08 +0000
Message-ID: <a35d84a7-3d8b-4ca3-9157-7d8d48a54b02@amd.com>
Date: Thu, 8 Aug 2024 11:20:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/15] drm/amdgpu: add vcn_v4_0_3 ip dump support
To: Alex Deucher <alexdeucher@gmail.com>, Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240806081825.2422771-1-sunil.khatri@amd.com>
 <20240806081825.2422771-6-sunil.khatri@amd.com>
 <CADnq5_NRfRJQn9a44BZw1jge81X+htXjCAGkQue9BNEQ-EqXXQ@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_NRfRJQn9a44BZw1jge81X+htXjCAGkQue9BNEQ-EqXXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::12) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|LV3PR12MB9330:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd549d4-e1cc-4ce9-b2e3-08dcb76e1951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUhoenhWZzkrSXhpK09kMUsvMytPRm5MRzd5c3lwM1JDT1kwN3hlTzltR2Rm?=
 =?utf-8?B?SXhNNGt4eEVKTGxuQXpuSXdjNzN6NkFZd1UycXFaL0NiREQrMkdNUGZYZzVl?=
 =?utf-8?B?MFVFM1pDLzdXRlRjZklDeFZ1cTNSTFpTT0lwOEhIdTBKT0p1VkZHQkVOT0NM?=
 =?utf-8?B?VGEzVm1VMnU4MmE2eTVjcmxtQ2xpTFREL0FTOU5JbVJUQ1NKeDJQWnFONE10?=
 =?utf-8?B?ZFNrRkcrYTJqU04wN2JnWkwwOFdaZ2F4eGtXTFZmUjY5R04vb1plUzY0eldP?=
 =?utf-8?B?YXQ0YURMS2g3WTB3SGJ2b1VhTU5oNmhMSWFXZWJneHU0YXAvRWkzdEdFMXEz?=
 =?utf-8?B?TXBoNE4xNEpMMTQyWFB3WC95dTBibVA0Ym0rSWM2c241eVgzclFyUnpRNHl5?=
 =?utf-8?B?UEUxWWE3cHcvS1hKeVByMHNGZWtDenU2QTE5SFdFWXJvYTdTUng5cWxNSmlC?=
 =?utf-8?B?TlZRKzhvaVYzUXBkUkJUeFJ1dHMxRWQ2U2hCekZ5aVNibkd2M0tqYzdLTk9T?=
 =?utf-8?B?Vnh0SXdQSzVQeFBIYmd2b3ZMdHNQMEE0TGZNTzU5L1dLQTROTWQ0T1FtSmgz?=
 =?utf-8?B?SnRtcWVNUDRuRTZURzVpeDZCZlpZMkxjelR5cEVEdjl2OFlyWkZVQUlyNVFh?=
 =?utf-8?B?ZkFzRjVzQmtSdnBJZ0tZVzE2UzREZDE1NGVKTWJ3YTRaeVRQUkl3Nm1mN21l?=
 =?utf-8?B?aGxTTkdxUndYVVQ4UTlIWVNnT3dpeUFHRGpHbGxBRzlRT3JUQmI5NGdhRmJI?=
 =?utf-8?B?N1R0MTlrZnRyeHJTK1VmaXA4SjltMEIyc0JiSEZXOXZuK09GazN0WXUycVVl?=
 =?utf-8?B?TXVrNVF3L0p4V0xyYkVqTWVWTzg0cENzTXIvOVNXOWZ0T0FOclNEdUlaKzNw?=
 =?utf-8?B?dCtocS9sQWc2L1hOeXFYTEZ6c0xTQWdvN0MxNWpZeVV6bHErdkpIU2VaRllJ?=
 =?utf-8?B?ZEt3QUs0YXUrbkZyb1pUY2JwaVdDMjVrOE5WcnI0UmJ3RHBKOFBoQnZWazlB?=
 =?utf-8?B?N3RRdHRKNTVrMDBJakJkelpMcG9PYndUNnpLNk9RcHo5V0oyUG5yMWxIWFVO?=
 =?utf-8?B?Yk92V3QvSzRxSDczL3A0WXppbjdtaktvQzFzZ21iQjJ6N1dZV1NaeFN5djI1?=
 =?utf-8?B?cDYyemZyemVPeGxWdjJmSmxpV25vSUR5TFBQSVF1N3RxR1ZOVFNydlRTL2V4?=
 =?utf-8?B?SG1WYXp5L01zRThlajRWZlZPbzdpOW9Jd0t1Q0R3SGc4M29Lb3pKNkZvTXlH?=
 =?utf-8?B?RXRnNkNJV0U2U0thaG83YjNZTXJaMER4NG1SWEwxb1hISGF4L3NTTkhJQStv?=
 =?utf-8?B?NGpyU0FRZ0FTNEdWdDRuelBBNjBTOHFYcVBxcCtTTUc0OHJoOWU4emV1ck5W?=
 =?utf-8?B?MmUwU3ZhNzVIRjJHcXFoRjlubGgyZ2pFamx2Z3dLNGlwT1Q5SW45NnBzOWNp?=
 =?utf-8?B?VC90M2ZNTjcvRDlPN2hTbnh5QW8ydDk5cHl0K2dpdzFPNTcrek10bU1BTE1Y?=
 =?utf-8?B?a2RBcXB2eHRZOW5uRkJRTGFSTVplTVpINGdvcDNXNmt2dWpwa0cyNFlRZ24w?=
 =?utf-8?B?MWlxanp4RjFuSDNuNXBHWWw5aVRlSEQ4SE1IenNRb3ZEWWh3L21GdFN2SDdn?=
 =?utf-8?B?ZTJOVlpSN2N3cWdFTUMwY3hUT1JIR3N6VjQ4cmpTYTV4Z3JXbnRhSlFWZHc2?=
 =?utf-8?B?V2hudTB1K1o2ZUdkeFlBMGFmem9LMnJaZCtpamgyMER4a1ZOdTE2S3NDSWZQ?=
 =?utf-8?B?R3E2MDBiSUw2WW8rRDEyUGhXdjZ6U05JekhkV0dJd3lMT2JMVkg3am9lMzBZ?=
 =?utf-8?B?ZFBDSVY1MTQ1c1pPTHgyQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk1ONUZuSHBZVWJmYmE2U3BBSDNFR0ViNHcxcHNJR0lQQ05XRHgxZERld0NV?=
 =?utf-8?B?VkZGYk5oT1RBeDB6UXRncC9NREh3NEFMaEJmUVlrL2hDR0IrSU9ha0VqQTB1?=
 =?utf-8?B?KzIreTQ1SDgvbHhkbU5NMXRyQ1E0MFRhNFhIckpUckNtRWc2YnR6eHlOcEtD?=
 =?utf-8?B?MnhKUUdsVzdDRGZ2dWVYN2swalh6L05GNWNaMWxVSFdTNDg3U2ZwbFRMdGx3?=
 =?utf-8?B?Y0c2d2VXQ2JWNHliRys2RkU3QlpVbGdKMmxzM2hzVDVPR2dVM2g0MjhpYi9z?=
 =?utf-8?B?M21TVnJGV2ZXcDZSM2RKQTVZMjBBOEx1UzBNVU4zWXJDNUlpNXpCVG9SeHNQ?=
 =?utf-8?B?WERJMkZpOWd3dDZvQWs1bjNxYmJlaFE4TUVqQUNCODFQb0NPNHBiS3FoNkVT?=
 =?utf-8?B?WCtFUSs3b0JTbkk4UlVvWWNlcCt2dnZvc3VSNldBek9aUTkrOWJub3FSNkZU?=
 =?utf-8?B?ajFlTmRHL1hiVk1aM3IyTFNicmlOL04rTDE2dDQyOS9pNW15TjdkNW5yeHVX?=
 =?utf-8?B?OU05R3pZZ0VYTjdRaE90bEVXMUdlOTBWOWdkaXp5MWx3VHZaZGJLZkRWazNK?=
 =?utf-8?B?NURpdG1JOXlzcG8yVzFCbWw3TmdMMDIrak5NYUxyYnpsV0xnMFRhM29KYS9G?=
 =?utf-8?B?YXlaMUMveXg4RXZxUHhkazBzRkw2S1A4UklyMEdoTk9wUzZsQ3J2S2NsUjRK?=
 =?utf-8?B?VVcveWt0Nm1GTTd1L1djZmk3dDdUWXR2Q29QN2NFYStkS1RPNllSZWNON1Uv?=
 =?utf-8?B?NGNnRkx1SFh6WmM2dWd4a0MwUlRRVVA4aitQQm1QdGd6NFF1TmpSanlBdGRz?=
 =?utf-8?B?SEhFbWgrQWtQc3VFckIyOUcyNksxbkpianY1T0RtYkdLVkZkUVdEMzYxRFZM?=
 =?utf-8?B?RVNlYmh3RWwzZ1ZOa1FVN2tIdHJhM3UwMTdtaGkydG5SOEJGd1VJb1djaTQr?=
 =?utf-8?B?cDhPTVFWQjUwa1p6RE13V1lkcmU4a2MrYk9hOEE0dlFuWjJOeEV6bHFKZjNY?=
 =?utf-8?B?Wlh0MlpUMzJFcUpiSm51MGdIWGtiV1FUa1BIUFVYcG1OOThwZjI2eTgxdGdp?=
 =?utf-8?B?Wm92U3FSc2JUSkF1M1IrbW5XbmZhcFI0N0JCbFJoQzRFZUNaQU9SK2pNL01n?=
 =?utf-8?B?SEhMcXNMSFdZdTVPY2lFQSs1cm1NWHVabnJXZEVWNEtaQTVNRXhPaDdhUHFV?=
 =?utf-8?B?UHpqUi9kUDRyWkFoZWRMUFBJaDdJUzRpcGQvK3V2TkU3VFNYWjhqeUI1QTVZ?=
 =?utf-8?B?ZGVyTkUrOEV5WU9SWFRhamxPWExnMVNCVmcwT25rWDZ4YnY0ekJSazZvTmhU?=
 =?utf-8?B?TjhiTnd1bmtkdzVJVTlITzhpNzJReDUwRzltaW5ZckJyZ2laOW9xY1RITGVF?=
 =?utf-8?B?d0p3bmNkdzZmemFJR2pFWXJDc1VtYVp4bTBhNDBZRnBUS3BzZkpLaGhqU01S?=
 =?utf-8?B?dzBjanN3ZXdZUDhoQXdUUk1HUFVaeFF6UWtLZUdxa0R2Sm9vYkVmRHlOeS9S?=
 =?utf-8?B?QzlORkVLWTRNdnlOTXhteWlLcVVqblFtQ1VtTGdxMzJiV2xOUnoreVlwRjBT?=
 =?utf-8?B?Q3BFL0ZmdzY2QWhGVWRWQklUUEJQQktUT21qdFZwcjA0bERmbXk3bUxqQnpT?=
 =?utf-8?B?OXQ3V2lzcHhRTmx5UG9OUmFqSkJTaTBKVVRmb2NFRGIvMUliWjdFbVlXVmtm?=
 =?utf-8?B?bGYraTlWcVVBZXY3T1R1WmE0M2xhYUdUbFRSaWtOdjJCWnlKV2hvTlRBRUZN?=
 =?utf-8?B?QjVOSjAyTmE4WEdPclBkVnF2bGhlSzFQRUNWTERxV2oyNFFjQzl3N09UMnl3?=
 =?utf-8?B?Nkx5YVRvNVQreWFxRUZ0M2RRWFBPNzIyNTFDRHdqd08vbWtNNUt3YmZrVlJj?=
 =?utf-8?B?WlhkRG44ak14ZW5pMHRjRU80YU00SEpQMjg0czJqd1RFV2NKNWNma3lOWWdz?=
 =?utf-8?B?YTVNU2VYdGRYTW5iMGtnMCtHb25zSFJnNktzYlRiL2gwdlpaVHNKQzkwbVNk?=
 =?utf-8?B?VUEyUERlOTNHTDUwMVcrUTIyNVRLOGNSQ3lnbXhsblY1ZktYV0EyTk55WUxi?=
 =?utf-8?B?ODBFRDNHK3NPUUZtcWQrME9Wd0hBVG5xa3krd2lFa29Ec2RVZlY5K3ByZFhK?=
 =?utf-8?Q?d6MGXjDLaCpXIDs1QJt3rqHhT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd549d4-e1cc-4ce9-b2e3-08dcb76e1951
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 05:51:08.2232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dc5muQkK1+mL2TU9HpW/EtfMlxw44obmIVM0kjUb8kh/cwB+lQymKvcio2jDXCNw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9330
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



On 8/7/2024 2:58 AM, Alex Deucher wrote:
> On Tue, Aug 6, 2024 at 4:18 AM Sunil Khatri <sunil.khatri@amd.com> wrote:
>>
>> Add support of vcn ip dump in the devcoredump
>> for vcn_v4_0_3.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 170 +++++++++++++++++++++++-
>>  1 file changed, 169 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> index 9bae95538b62..dd3baccb2904 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> @@ -45,6 +45,132 @@
>>  #define VCN_VID_SOC_ADDRESS_2_0                0x1fb00
>>  #define VCN1_VID_SOC_ADDRESS_3_0       0x48300
>>
>> +static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_POWER_STATUS),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_STATUS),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET0),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET1),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CONTEXT_ID),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_GPCOM_VCPU_DATA0),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_GPCOM_VCPU_DATA1),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_GPCOM_VCPU_CMD),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC1_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC1_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE_VMIDS_MULTI),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC_VMIDS_MULTI),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI3),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO3),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI4),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO4),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR3),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR3),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR4),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR4),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE3),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SOFT_RESET),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SOFT_RESET2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_GATE),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_STATUS),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_CTRL),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_CTRL3),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_GATE),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_STATUS),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_CTRL),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_GATE2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE3),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE4),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE4),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_STATUS2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_GATE2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_GPGPU_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_GPGPU_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CURR_LUMA_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CURR_LUMA_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CURR_CHROMA_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CURR_CHROMA_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_DBW_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_DBW_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CM_COLOC_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CM_COLOC_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP0_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP0_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP1_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP1_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP2_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP2_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP3_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP3_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD0_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD0_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD1_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD1_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD2_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD2_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD3_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD3_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD4_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD4_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE3_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE3_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE4_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE4_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE5_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE5_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE6_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE6_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE7_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE7_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_SCLR_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_SCLR_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_SCLR2_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_SCLR2_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_IMAGEPASTE_LUMA_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_IMAGEPASTE_LUMA_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_IMAGEPASTE_CHROMA_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_IMAGEPASTE_CHROMA_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_PRIVACY_LUMA_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_PRIVACY_LUMA_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_PRIVACY_CHROMA_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_PRIVACY_CHROMA_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_STATUS),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_CTL),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_DATA),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_MASK),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_PAUSE),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMI_VCPU_CACHE_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_VCPU_CACHE_OFFSET0),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMI_VCPU_CACHE_VMID),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_CLK_EN_VCPU_REPORT),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_CTL),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_CTL2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SCRATCH1)
>> +};
>> +
>>  #define NORMALIZE_VCN_REG_OFFSET(offset) \
>>                 (offset & 0x1FFFF)
>>
>> @@ -92,6 +218,8 @@ static int vcn_v4_0_3_sw_init(void *handle)
>>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>         struct amdgpu_ring *ring;
>>         int i, r, vcn_inst;
>> +       uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
>> +       uint32_t *ptr;
>>
>>         r = amdgpu_vcn_sw_init(adev);
>>         if (r)
>> @@ -159,6 +287,15 @@ static int vcn_v4_0_3_sw_init(void *handle)
>>                 }
>>         }
>>
>> +       /* Allocate memory for VCN IP Dump buffer */
>> +       ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
>> +       if (ptr == NULL) {
>> +               DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
>> +               adev->vcn.ip_dump = NULL;
>> +       } else {
>> +               adev->vcn.ip_dump = ptr;
>> +       }
>> +
>>         return 0;
>>  }
>>
>> @@ -194,6 +331,8 @@ static int vcn_v4_0_3_sw_fini(void *handle)
>>
>>         r = amdgpu_vcn_sw_fini(adev);
>>
>> +       kfree(adev->vcn.ip_dump);
>> +
>>         return r;
>>  }
>>
>> @@ -1684,6 +1823,35 @@ static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev)
>>         adev->vcn.inst->irq.funcs = &vcn_v4_0_3_irq_funcs;
>>  }
>>
>> +static void vcn_v4_0_3_dump_ip_state(void *handle)
>> +{
>> +       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +       int i, j;
>> +       bool is_powered;
>> +       uint32_t inst_off;
>> +       uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
>> +
>> +       if (!adev->vcn.ip_dump)
>> +               return;
>> +
>> +       for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>> +               if (adev->vcn.harvest_config & (1 << i))
>> +                       continue;
>> +
>> +               inst_off = i * reg_count;
>> +               /* mmUVD_POWER_STATUS is always readable and is first element of the array */
>> +               adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, regUVD_POWER_STATUS);
> 
> I think you need to use the GET_INST() macro to properly handle this.  E.g.,
> vcn_inst = GET_INST(VCN, i);
> 
> Alex
> 
>> +               is_powered = (adev->vcn.ip_dump[inst_off] &
>> +                               UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>> +
>> +               if (is_powered)
>> +                       for (j = 1; j < reg_count; j++)
>> +                               adev->vcn.ip_dump[inst_off + j] =
>> +                                       RREG32(SOC15_REG_ENTRY_OFFSET_INST(
>> +                                               vcn_reg_list_4_0_3[j], i));

VCN 4.0.3 supports DPG. As far as I understand, most of these registers
are accessed indirectly in DPG mode through indirect SRAM.

Checking UVD power status alone may not be sufficient for direct access.

Thanks,
Lijo

>> +       }
>> +}
>> +
>>  static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
>>         .name = "vcn_v4_0_3",
>>         .early_init = vcn_v4_0_3_early_init,
>> @@ -1702,7 +1870,7 @@ static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
>>         .post_soft_reset = NULL,
>>         .set_clockgating_state = vcn_v4_0_3_set_clockgating_state,
>>         .set_powergating_state = vcn_v4_0_3_set_powergating_state,
>> -       .dump_ip_state = NULL,
>> +       .dump_ip_state = vcn_v4_0_3_dump_ip_state,
>>         .print_ip_state = NULL,
>>  };
>>
>> --
>> 2.34.1
>>
