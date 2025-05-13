Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB9CC3ABC3
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 20:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E31510E5E6;
	Tue, 13 May 2025 20:33:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1z4dHGrU";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05B4B10E5E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 20:33:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tClukLXjstWFugvgsy9ATG5gesVR01fY2VvL47fZLIViL55gzw9c6GS8ejY6JLohtN+8ptlEmmd5gDTRTHdgCzuvrGx5q590JhbzI92JfI58IMTvvz+E2dsJxo0Eb8396zohrNAc9blBsoJ4BrK6/Uy9vDPyIQXg57bdlXJS48xW+4B/0qmIwzxrCkeYnh8OG56mGZwyDv68ki9qKeZhEyvn25RxEZS/xv5zXDu9aiRiM9OriTFYQjPo0rwJVOb3Cb+RDuSiaIbhUlos7S2bInCsoJAkQd97NAIdlWzubYq51ITIDV9yS2/L656ixIOCGpEtmOsrDkylKVkz6AUemw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRYahGZFXUXQmFFUdDIwzUDS7uEemck81Aya0izg8OA=;
 b=onLMnVv25wyR3Wvb3cT/rY9sXrS04syeQ970W7HdljYZ/HG4VpEk+/xsX+W2glxBLC4we/ashJ9HepC+AdxVK79BVmJ5Fphjhx2HRgyHaGocygqKaM/qKtX+tgN+ka7s8df8xh4TvJ1rOLqt92p8aa3CEtPjIL796L0gGF0ay+pCzJoolxIuOzIZNvas+TtYlm4q5+65LunfheRg2pDqRMa2oiTVZgcYw/pn2ZYenUUSyBIz4IrJPvn4/fmIgsUdk+nhfY46TawszG9vGZp+4uHeK1PU2+2O3yW7X97c1vlqN/ChlE2RTI6d8udKrxXaPcaNGSEsxNqkMDMSK6pqcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRYahGZFXUXQmFFUdDIwzUDS7uEemck81Aya0izg8OA=;
 b=1z4dHGrUzJlUlup5KIleIlsyUrO+k4Wbc13nCwpY5PMzZVZJNuzIj3cyNpgc8mhqlQ9F29fABcwipBO1nZeQa5O5jBEAMcaM98mve1V1L2hw292WACtOPHJVzK0xxooh71X+t9GeRXav8iwBcNh3zTBe2m127lH3hUUrgEIjb+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Tue, 13 May
 2025 20:33:21 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%5]) with mapi id 15.20.8699.026; Tue, 13 May 2025
 20:33:21 +0000
Message-ID: <e1e19625-faa1-409e-98f6-67c0cd240f61@amd.com>
Date: Tue, 13 May 2025 16:33:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] drm/amdgpu: read back register after written for
 VCN v4.0.0 and v5.0.0
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "David (Ming Qiang) Wu" <David.Wu3@amd.com>,
 amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com,
 alexander.deucher@amd.com, leo.liu@amd.com, sonny.jiang@amd.com,
 ruijing.dong@amd.com, Mario Limonciello <mario.limonciello@amd.com>
References: <20250513182307.642953-1-David.Wu3@amd.com>
 <20250513182307.642953-2-David.Wu3@amd.com>
 <CADnq5_PYHhPoRRgToDjJr58utMGLvyKhUtt+WdZvL6B_w2YjBA@mail.gmail.com>
 <732058a7-c995-4ca4-bd8e-04df669122ba@amd.com>
 <CADnq5_M2-3T8thYY-BtDOt_w+rxHFgyuPNCVnwyTY35kwKGsFw@mail.gmail.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <CADnq5_M2-3T8thYY-BtDOt_w+rxHFgyuPNCVnwyTY35kwKGsFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0075.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::10) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|IA0PR12MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: 2785a3de-2d7d-4f44-179e-08dd925d66d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dURUWEh1LzgrM0FWbXY0RXVpdUtiV01pblNuSlJHY2tQRWJGakI5SDBPZ3Yw?=
 =?utf-8?B?ODFpRjN1dWhNOWdJWVRVMlRQQnp5K0QxVjlOSk1RY2FST0trekVmRlF4Uklj?=
 =?utf-8?B?MjVURjVha2M3cnRSNzZFRlZMOTVMaVJHRGRTZjE1MzFGbnFwR0h4eEZvY1Jt?=
 =?utf-8?B?WkgvZnNCRGZQNlkyN3UrNEpGeU5QdUFzR0F6UDk5TnRRUTZDL2kxcmxaL3hF?=
 =?utf-8?B?SWhlbC9rYTBTdEVpL2xnd0dHQ1B6eEdRMGJGYUttTjBtMnhSeC9jRTV0TU15?=
 =?utf-8?B?Y3hIdnBsM1d6cVliTDg4VVhsemc3ZksxRlY5SldVRWNvS2t6akwvbDNuM0NU?=
 =?utf-8?B?UWhNaHV3V0NiRWFQRVBvODVDVHJRVlBqSGdTV3hzb1B1aWtETndhL1hlQlBH?=
 =?utf-8?B?eFlQU3V1V2tjM0wweDZIaHl1aldSYmh1b2ZKclVGbFRremdmK2kzYUdMMUxO?=
 =?utf-8?B?bTlDaUgxZEJGWXZPM1kxVFJIOUtzYTFlNVkwMG1lWGtpT2lqaVBuMEwyY3Ra?=
 =?utf-8?B?cUVSOUU0OHpndW1tbm1IZ3Nhc043R0FwbkkvOFNZdmF4OGsvT01tdTAwTmdK?=
 =?utf-8?B?N1drVUc5bUg3L1pWa3VoMVNMeVB0cWkxcHBPZ0FlaXRneWRBQ2kzNmRVakVp?=
 =?utf-8?B?NzExS2tJZCswNjRmeW1NOXZPaHVmRjlIa1ZiSFJoWWJjOUpFdFNJemdSVWtk?=
 =?utf-8?B?czh0THM3LzZQV0JHSWJBWU9MREhtYStGQ1R1YU5GTnB1V3gwbXE4a255THJN?=
 =?utf-8?B?SE1QTitWZExQTjE5NVhYRFdxaDlCbUJtT0tLUkpRbEJidDVBUW9oMGU1UFJL?=
 =?utf-8?B?VE9RbGRZY1pWbmc3Y0E4MGpmU3Zndmx0RE9IQW1kTVppRjRZYUMxTldHb2lp?=
 =?utf-8?B?YXRHSk92Qk5ZSVhFc1dVOXF6MW1pK09NZVNXY1RibXM4R2Y0QmdTbjdzMzNG?=
 =?utf-8?B?V0FWbHh0MTlNVXJjR1dEd0NhSGY1NXJDMitsRFMzL3hVN1V0V1VKcUhOTU5h?=
 =?utf-8?B?TVoxQ2sxRVgyb0VLSVZhT0tRcy9xWXI3dyt1aDFhQ2hua0lkWHkvSzU1eDFL?=
 =?utf-8?B?VGNoRU5sdEd3dGRMb09FNzNiZWZPckpUb2xjMVNnVlNvRHpGRm5hRUl2Znpk?=
 =?utf-8?B?RmZCdzIzTTF0TWNlTzJrZGZlalZEVkw1WXdORngxZnk1cThwWDl2YjM5ZVRK?=
 =?utf-8?B?c3JIemk5eHk2ckhjSVo1aGtoMjBqZ2xuUjg5eUlCS1JJaE4wUFFJZjQyay9C?=
 =?utf-8?B?WDNuOVEzQ1l5eTBQS1ZXWWI1OHJ6YXdVS28rdXVpZ3FUUU1icEpSdEJza2hJ?=
 =?utf-8?B?cTlIa1ppYXBFSFZqczA2SC9QTXFKWlZUL1Z1WmFrVHduNGxTMkFDQmhDR1gw?=
 =?utf-8?B?TzZEbzR4UGViUWxOQnZ2Y1lpcStCMHFqUWN1OHJkQ2dkaHJ5VzBGdERndXhD?=
 =?utf-8?B?WUs1WmQwVVJzek9rT3E4S2pTQURaVCtSc2JPbVE5TWJTVGF0ZGZiM256MmUz?=
 =?utf-8?B?U3lDbXJiWThpZUJwRjVmUUJZNGVwcC9wbHhCUUhYcWN2TlhuWStVWURjOFZp?=
 =?utf-8?B?NUo3Uzlxay93djBCeGNONXowV21jZEttTVloUnR0dnRMVDFLT1puVURjdGZk?=
 =?utf-8?B?RXhhZ1NQK1QxQnAvZFFmbFVSS3MvaDFOVUVVeDk1dUFXR1k1OEhZRzA0b2ha?=
 =?utf-8?B?b29JS0V2emR4b1dRVnlBeVVPRzJSV2NraUUxMW52Sk5OdlVsMXdGWUNpSmFJ?=
 =?utf-8?B?T3l2bDZDdkllRVZzR2ZBMHhnZmdTbzVJWW54RmRCdmRHZE1sV2RvbDJsRmFJ?=
 =?utf-8?B?WHZkSEh0cWorYUR3RWU4OGlUamo2b21CdDV0UDBDT0EyL3Uxc3NhYm9PK1dy?=
 =?utf-8?B?WE9ydWlzWDJNcUZzT09JdWdOemZacmU4dnQzZldLU01VZ1R0T2FvcnoyTVVr?=
 =?utf-8?Q?aahCltJXkVs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlVYa3dRQnBkRWZIOURTYWFWeGtmbjN0RHY0czRjL0NCWGo5U3lnay9EV05s?=
 =?utf-8?B?MURGZ1dMS2o1SkVCbk41YkV2SGc4MXBMUXkzSit2SXdiencvblFlTEtSS3Fq?=
 =?utf-8?B?QVV0MVpVTUczNEVEUFdmUmRWbUN4aUZoWnkrRlVON2ZIQ3NzdWhmUnBmaWtu?=
 =?utf-8?B?MkgzbE9URlNaNDY2dUw3b2pLMmJ0K2VOUlFaVmpMdWxmQ0JGYWNVc3ZYL25J?=
 =?utf-8?B?UU9mY2MyeWxyYWJlaENpMWh3cDh2L1ZqaTZHZ3Nta1F4OXdSS1NvNkVVa1Nt?=
 =?utf-8?B?M2ZCK0p1bm5uM3poQ1hFY1luSmJ0bEgzTmx1VVlTaXlNOEpOdGpJRWErUURN?=
 =?utf-8?B?Z1dHM2MxWjdGY0c5RHkvVFNuc2tIeEVrc2xhVzkvc2tWeVExSnVyOVkxVDRo?=
 =?utf-8?B?T0lJa3FJMG5HLzFyaFZSZTRKSWQ4WStOYjZOYm9ibGwrZS8wTWJUT0JqTlpD?=
 =?utf-8?B?Wi9KditkS2lyNmhFOExvMTd3TXlPd0M5NHFsWkl2anc5R2pYSW50RDhWYXBz?=
 =?utf-8?B?djAyNUQ0ODg1QmI2ZGJ3SWl3WVcwaWQrbjFwVjhQTnN2cXFiMFlweFU2Y2lo?=
 =?utf-8?B?M2EzKzUwWlByRTJHcUVUNzRhMEJXMXVXcGxXeURaSzBVL3RYeHhUTmV4T2pX?=
 =?utf-8?B?djd3WmFRcjhqNDJDVXV5QmlrMHJvQVYzOWlBTGsvSFZDckhnVWNrUktrL3hF?=
 =?utf-8?B?UUU2RFpFYzBCa3dZclFpS3pLNEx5a2tQMDE3a2p5QVExZW4waTVVS0s0UUth?=
 =?utf-8?B?djVBdFRtVXlMMnp4ZnlqS1FjamdqdXYwVk5uRGV4YmEwcTJRemlENldQOE15?=
 =?utf-8?B?cjlWdEd4NjQ0ajNrc2xyWHFvZVNBNVpGcVpGOUdObzVlRFlXUEYwcjdxQm14?=
 =?utf-8?B?QWRtSkVhaHg5Z255anRUZVdUdkdveDFPdzJmK2g0Sk5xYUNZcUVsNVhidDBa?=
 =?utf-8?B?N1UwZzhTeWQ3anpzNGR2SlovdGdkL3dYeFdOejBsNjBpVmpCdDBBSUhDMGIz?=
 =?utf-8?B?TUF5bExDL0o2UXFkREQrMzN2T0ZoemIwTml0TEJMNVdFSkdxUEgyeE5BU3BR?=
 =?utf-8?B?OFlCYkN4dmxvSGFLZHVKRi9BZ1FpMmphLzJUNzhrcHFXR252OWMvN2p1UWZY?=
 =?utf-8?B?NGg3MjJ5ditpV21hRW1CVTJYVGJnb05TRnBHcjFYYmxjbHJvTzU1M3AzMmsx?=
 =?utf-8?B?aXJDUUM5SXI0MFI2bkFxTUI3c2NFYWZQVEU3MlRIUnFQaXBNSjhOTVVRbUJK?=
 =?utf-8?B?K29Wc21sM2lyZzhwL01hYTBSS2I0ZE5lWW16VGlYMUYyZ2cxaDV5RVJiY1RF?=
 =?utf-8?B?N1ZWRUUxWlAxN2Q1WkNnNEQ3ZkhHejA3TVJkbVVXTWtILy96RWhGTEEyalRP?=
 =?utf-8?B?UHhHNlFXNXB4Tk1MSzRoNXBRYzBxNnY3UEJFYUZTNjNiM3U3MllQWkZYM2Ir?=
 =?utf-8?B?LzNOVVowZW9OeWVINS9DL214Y2hlbzgxYXRxQnd2Tk5Ed291QnVNdnJVZXhJ?=
 =?utf-8?B?T0M5cVBldzhGcUR4QlovVkRhdTBXTFVrWGV3QncrRDA5SThvb0UycVBNV3hP?=
 =?utf-8?B?TzYxaSsxZm1CUjNTK2ZTU2s3SzZLNTE1S3pGeXdtdUFhWVVxWTV5eW1NOFhr?=
 =?utf-8?B?TjdxVHhRVlU4dWhjbDA0aWJHNFZNaW94alI2NzA5bFZqTG9VeVJ1bkNNOFNu?=
 =?utf-8?B?dzZTc05aWFpMSTVFQXBScG0xOXcxa04vdnVUanA2R0o3ZnFCY3ZLamVJYjBK?=
 =?utf-8?B?Tk85WWdxS1c2eWZ3cWRCcFNyZHlTMmYvczFpUmxjZXFtYSt5MjRuZVl3bE5q?=
 =?utf-8?B?cE5BTmV2c2E1NEludklPN3UyL2ZKUFpkQjVZakhyNmdwcjAzRHRXK3h1am9I?=
 =?utf-8?B?MGRMeVZIZG96T3hWWWhRMkNEbXhZVkUwbHROZnhXWkhBT3BwMjhaWlhvS3lC?=
 =?utf-8?B?Q2t0OGhIQ0NkdUhGWmRER2lhT2VCS1dBWUdZWUFwc3Yxb1gwM2N4TTV6Zi9x?=
 =?utf-8?B?c2N1a0RVVExxT1RLRHROTkt6RlplSEtVU1NYNUJ5RkRMSThWaVh4Zms5WEYw?=
 =?utf-8?B?NXBPdStMdTkwY1RRN1d4SlVUZWcwOFdsM1RTRDkyek9uMGJJM3oxYTdEd3NR?=
 =?utf-8?Q?o8v+ZHiaCVB8CU2TUh620H5T0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2785a3de-2d7d-4f44-179e-08dd925d66d3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 20:33:21.2869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CL8bkTmsxZCyJqaUDQaErIE8gKqHXQtXbATQFVEuJp1UJIFIwihFkFOyWNMl+r1cjOQimkVZnST2mejM8dMkcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012
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


On 2025-05-13 15:29, Alex Deucher wrote:
> On Tue, May 13, 2025 at 3:01 PM David Wu <davidwu2@amd.com> wrote:
>>
>> On 2025-05-13 14:40, Alex Deucher wrote:
>>
>> On Tue, May 13, 2025 at 2:23 PM David (Ming Qiang) Wu <David.Wu3@amd.com> wrote:
>>
>> V2: not to add extra read-back in vcn_v4_0_start and vcn_v5_0_0_start as
>>      there are read-back calls already. New comments for better understanding.
>>
>> Similar to the previous changes made for VCN v4.0.5, the addition of
>> register read-back support in VCN v4.0.0 and v5.0.0 is intended to
>> prevent potential race conditions, even though such issues have not
>> been observed yet. This change ensures consistency across different
>> VCN variants and helps avoid similar issues on newer or closely
>> related GPUs. The overhead introduced by this read-back is negligible.
>>
>> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Maybe split this into two patches, one for vcn 4 and one for vcn 5.
>> That will make it easier to backport to stable.  What about other
>> VCNs?
>>
>> will split.
>>
>> This applies to those VCNs where regVCN_RB1_DB_CRTL is used for setting doorbell index, which
>>
>> means VCN 4 and up - all of them are covered (similar code is already there for those not in this patch).
> Sure that prevents the doorbell from getting missed, but what about
> other registers setup in the VCN start() functions?  What if some of
> those are still pending when the doorbell is rung for other VCNs?
I think adding a read-back is needed if there is any concern about race 
condition.
If we only concern about start() it should be easy to add. The question 
is how we will know there is
a race condition. Adding read back everywhere when missing after write 
is not a solution I think.
For any VCN functions we need to check carefully 
(eg. vcn_v4_0_unified_ring_set_wptr()) in case it adds too much
overhead and actually not needed (at least haven't seen the issue).
Any suggestion as to where we should add or at the moment for _start()? 
I can work on it for sure or leave it for
future improvement.

David

>
> Alex
>
>> David
>>
>> Alex
>>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 4 ++++
>>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 4 ++++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> index 8fff470bce873..070a2a8cdf6f4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> @@ -1122,6 +1122,10 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
>>                          ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
>>                          VCN_RB1_DB_CTRL__EN_MASK);
>>
>> +       /* Keeping one read-back to ensure all register writes are done, otherwise
>> +        * it may introduce race conditions */
>> +       RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
>> +
>>          return 0;
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>> index 27dcc6f37a730..77c27a317e4c8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>> @@ -794,6 +794,10 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
>>                  ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
>>                  VCN_RB1_DB_CTRL__EN_MASK);
>>
>> +       /* Keeping one read-back to ensure all register writes are done, otherwise
>> +        * it may introduce race conditions */
>> +       RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
>> +
>>          return 0;
>>   }
>>
>> --
>> 2.34.1
>>
