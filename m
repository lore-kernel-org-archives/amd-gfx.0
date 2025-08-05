Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A82C87FCB
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Aug 2025 04:53:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C17F10E241;
	Tue,  5 Aug 2025 04:53:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sqU4PfN1";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3257510E241
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Aug 2025 04:53:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huN+2Y+8CviqGBvR+4d3KyqmBxvtM3jSuGGA/M9HCnZJeW+CTPiHef8nkyMempEbbqmb0+B27sEPDhWdmOtgq90MJr0MnttUcm8RS6MR4OsKj7nmWU3lkjvnwvMNXIvat5b6H+vwe1PQp3LFVCKsvHvSYsvk6XlFKJx+cyuytSgDLW9QYncez5xQ8cSBGGitoE4zwtDzWWyX1V0aeJObLEwosCLN6u4bSs0gwbGqcIRfvM4qd2h9fcAS3CSvD8FMehBgEMOMcdl8k812bSabMB2v0aDGuDR4jzMxYJ1BK2RRQdByI8d9RuET7JxCI+P3/c3XKZXZwCaPL+Bpm/zN7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2G130MuhpxnsL4B0uYsPQxb01QNruSy0KQFVF8ArNQ=;
 b=qQDqcqty3LPaCKOrDlr4zKfTNeFKWt8pNQ7FCqxcslV5AR1VMPG7Wgzr336fzDFN9CkLgPZr2pG/aVYROvplto/ST7EqPaodhf1VbGiI2W+1uRwvYy5II+ZSHJpoOG/ruQjosPz70lucPWoOiJeyBab7oBK3usRaoNu1fWAyWpvAxJoG7tx0cVR+/m01bHE1+IFY8+D6rV7Qw0yCOFsYlSrnkzUAyDJ5+ZlxBHwD4Hht9GYMejpyV0dOTRpOzIi5sC0VkI5WTQPpQQVym9qhvgpxx95HRjrJO8MwR1w6vwLbR+cqikhskMHw/dKiQwDzrTScWsAuzFjUi44ORTwJ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2G130MuhpxnsL4B0uYsPQxb01QNruSy0KQFVF8ArNQ=;
 b=sqU4PfN13/6YrJtFDEu0LmzHvpuSOWLlEwHXruQThZuM2687sGX3CP/e7LOQmTNnSNod9YzSYhtkPZIxHqaT/TmWb69X0xlwfSZb2sgWWeVrSYPrs7plv7cOz23K7BEQBDFY27W+JIxQtRqPYPKqXe3eTpg+wJyk+wO+frIWrN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 04:53:05 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%5]) with mapi id 15.20.8989.017; Tue, 5 Aug 2025
 04:53:04 +0000
Message-ID: <efff2f9b-62de-44ae-b7f7-37d26c20a7f2@amd.com>
Date: Tue, 5 Aug 2025 10:22:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] drm/amd/pm: Fetch and fill temperature metrics
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com
References: <20250804141757.643501-1-asad.kamal@amd.com>
 <20250804141757.643501-4-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250804141757.643501-4-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::33) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|MW3PR12MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: 51639c3e-e9b9-4fca-2690-08ddd3dbf66b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SEdNaENEQXR2R0tUWjJDVThJc2g5dDZFZzFZMGNaU1VHMWl0c3prNlFCTExa?=
 =?utf-8?B?K3ZhMTNEb0JLSi9sOC9XRVFsZGdHblk4UTdlbHd1bmYwMlJ4NnpGakRjRFk5?=
 =?utf-8?B?SWpKOS9hSllSSlBiS2wxQnF1d1N6aWpTTEllNFExbC8yL3dtT0NQaHpOR3g2?=
 =?utf-8?B?ZUwwYXRWRG45c0pMVGgxcmlSWjhFaTJheGg3bGtzK1BmQWw4T081NVBYcnoy?=
 =?utf-8?B?aUtvZytVRzF4N3VYeHFYNWVpanM4TUgzRmNIaTFsSmVBZk12bnhMRDBzTWx5?=
 =?utf-8?B?Y2NxRkdwWGhJRTNFVUJzRUJpbzArNHJQclE2T05LV29NUjR4czV1eWUyalZ1?=
 =?utf-8?B?QzRvaDVSbmo0Wk54OE5vUkpuYy9DQmdRY3ZKc2NUL2pqTkw3QktRVWt3RnNh?=
 =?utf-8?B?dzllbFJHVFhZaWpMTEp6ZkdWUE9DSjM4Rk52S2x5T2tmMk1wTDYwa1NBY3Aw?=
 =?utf-8?B?UFhNc29rakFsdndpV2hDVU1pSlpQOU9UdVdPaDIyUlllMXVvanRFcElZZ3FI?=
 =?utf-8?B?WXcwZlhMMFc4NGljQ3VCU01DTzZyUE1ET0lkN3ZGMU5CTCtmZEFsMVpEMmtV?=
 =?utf-8?B?Nk5EQWNNcmZ4Sk1SOE9NNVlvUzRsZW9kenZzY1ZqenpkeDg3alA5MEtKSVJQ?=
 =?utf-8?B?SnVVYU1LcHJsNlJKSVo1aTc2Y01NYlpQOWVQUnI2eWlxa2p6bFY5eWl0WXMr?=
 =?utf-8?B?YnBiZ3lQWmtPa0pMdElBdmhlYTJVbkNkQ0duL0RFY1pFZE5tNktLdFZRL21K?=
 =?utf-8?B?NGlocElPbmlPakRmazhDRE9PYXZiZ2swWk9WYUR2RWdmOFhmVG1vNDFsM2s4?=
 =?utf-8?B?eUVaN3pwSkJBSUE2SW5BU1hMdzZJR3ZqVTI2S1l1eHZidFR1TEhzVjhSblk1?=
 =?utf-8?B?QklscDRPMFZXdm02VFltRnY1aE1rVzhBUzVmQVZPU2tOdXlLaW9QbTFrT1RT?=
 =?utf-8?B?MGhBZ2ZNcHBqL3FRY1lCRmhGd1NUcE5DUHAzY0h1eEVRTncvQlhIU2d3Q3lt?=
 =?utf-8?B?dldlWU1MU1NaeWtDdXIvREErM2Z5TkJ4SGV0eDRZY3ZVL2RyUHpRUklEQXI5?=
 =?utf-8?B?emx3dmJIRVl2R09VQU1nbTV3Ym9teGdyYUhhRlNJby9UeU9ITTl5WitoVk0y?=
 =?utf-8?B?OEZQYm95MHFESTk3NFpFeC9sbEtsVTdsa3VaZ1hiaTY1Z3g2SFBScGI1MUV3?=
 =?utf-8?B?UFhzOWRzMWthSTFZcDBjS0kxSGpGb1NsYS9VSTM3a0oyNkozb1JDUkJub0tC?=
 =?utf-8?B?aklyL3JNM1ZDZVlWYWFaRHpFUjl3Z29yc0l2MWdxYzQ4amM3YTRjZElMc2VE?=
 =?utf-8?B?YmZSYW0vNzB6c0kvdlVVNHdmaTF1OW1BNjdHL2FWbHpTZDZXLzE1dDdTVzY4?=
 =?utf-8?B?RTl0UFhhc2RtUnJ3TncxUVFGOGNoWlVSUFJUR2Y2dTVMSXhGS2tHUi9zMzli?=
 =?utf-8?B?MHA2ek05cGwvRTN0QURaMnBuRmJqWU5rbjZXQ3JLUWJBMkw2emh6TW91V3Y3?=
 =?utf-8?B?UlV2VU1GaDFyS1FhMWRaSlFybm5Rd2xBRXhYd0VIRHhkSUhUQnF0djAyajhU?=
 =?utf-8?B?dDJwckJudm5GQWZyR3BYWVBreVRvbmcvUlZlV01JN21GZlN2RExNYXhmQUJv?=
 =?utf-8?B?cGhpZW85Qi8xSnJIMkxqSVdFaDdneHExN0dlQXVyUkMxa0Y4ZnVCaWVvUS9w?=
 =?utf-8?B?b2M2dUhFRWw0dEltSHVBODVkdTRVdlNvKzVzSytkR04vMW9wSjJqVThzd1Zw?=
 =?utf-8?B?bi9mdUVWL202VzNPdEttSUhYY1ZseVB1c3NqVDRHSzFBYllHU200LzNoQkUz?=
 =?utf-8?B?SGhrbzB0ekhkRXlPYjNrZHVrbC9hNUpDZnJxU1dJSXFoaURjWnBteGF0MnZE?=
 =?utf-8?B?YkN6cE1FM010b1R0b0hWU2RpYjRZTzVMaDVLK25haXJiTytlbk9ReFZUUXZx?=
 =?utf-8?Q?LZNjv4ADzS4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXlRN3dGU2lXb01wV0ROd0c4UC9kcWE3Vkxia28xa1RNUXFBdjJZMHpHZVNt?=
 =?utf-8?B?ejhsSmx6aUlCWm9KZDNUd29PcEhITEk4SjFSVjlDbWhzd1ZESVFjWW5ZRnNT?=
 =?utf-8?B?YWN2TTdiZWg3VGVwUG5KS25YdWNjR3I2T2RwRHFLWjh0UnlVa204ZjIvMDJN?=
 =?utf-8?B?QXFuOGNEekQvcmVrRlY0MytBWjQzcERDWHBjd1VLK2N5SkJ3Nm5Lc2V4N0s2?=
 =?utf-8?B?d055aW1xdzBjaVMzb3FueFJnamtuS1JReXhmOFlXdW1GSnBiSjBiU2ZOZ2lt?=
 =?utf-8?B?Uk5sem02akJJb0djb01SWEFQbVhrTVpZT0pnUVBvN210SU5YNnY0R2ROanJw?=
 =?utf-8?B?eFlDNjNzOGNvTkVRSVNYU1lTYmJMd0JkSzNyNWo2MEh5Mi83cnhORzRGU2Jl?=
 =?utf-8?B?akZPT0dXZ0FzTlhNWWNFc2dsYm5NVVdXM3JlbHhob2tSSmRKSXViQU5SaGFG?=
 =?utf-8?B?eHZCUWpTUWE3YUpKYjVlK1RBcTIwRzJ3SktUNlhCTXAyTWtoYnM3eU8vSTZm?=
 =?utf-8?B?b1dJbUIvSmxQNC8yd3FzOWNVeHdCNFQ1Y3lZSEJTL0NpTU9TZ0d6aDA5T0RK?=
 =?utf-8?B?cFV6VTRqby8xZHNKMm9VbURSZlFrUFl6RWJPZjdrV2Z6TEtzd3ZEUDNUUVlV?=
 =?utf-8?B?WW4wYVZCVldKK2JvRlVpdVNXUGlmSGJMV2NydkRNT0plZVF2a3hHMFUyUlNB?=
 =?utf-8?B?cVR6Tlh2WWJIVXlYMTJ3dzFPQnFDYm4wR1RtaHBRaWpBSS9JRTFaSER2ZXdW?=
 =?utf-8?B?N0xkUFNMazRqMnZvV1BLY0VMODRDcGRwUC8vZURnRjd0d1ZHNzk0VlFtWklE?=
 =?utf-8?B?SjRrRXNYVGsyM1Jva0JjSHArWGFFbWExdXg3ODUyYkVCc3RjRWY4bERrcDFv?=
 =?utf-8?B?UXorZDh4UmVXRHpqYlFJWDFBOVNDak0rMkdFazNabWg4OHIwSm1HTktVWG42?=
 =?utf-8?B?SWZPeTMvOTkyTHNsYmpaM1BjZ3lud0RmdG5NdjJBSWdma2grQS9jUVhHT0Y3?=
 =?utf-8?B?MTlRM0ZPV1VzQVIrTEtiQzZLUUtFd0NhSkJSVWQvRXZadEpEK0FiMlVDQXVD?=
 =?utf-8?B?cXBzZ2xKcXlmZUYxRmprQ2JFN1ZkK3ZqNk92QUcwSWZjWjVVUUQzQ0sxMDRN?=
 =?utf-8?B?YlZublI4MS9XK1gxSmtjUkRkanFIYk8wRlh6MWVGWEF5WDBiNFcwOU80WGoz?=
 =?utf-8?B?d2hrV0kvaExFVEpiQUQ0cFJtdUcwMkRCQlZaRkpwM3hLazNhK0FRamJnZ2Fl?=
 =?utf-8?B?OXNLM3dha3NPUXdxRG1XQWZpVWVBRTBiN2dvSVMzcmlhdGp2NW9DZXBnK0dx?=
 =?utf-8?B?Nzllc0VNeW5MME9HVzNkS0NWaTRha01SUzJSY1NsY2pFd1I0SEpVcERiRERP?=
 =?utf-8?B?OWdWTk5xY054d1VMdnVtSU5vRUFFU3VhdTlQckFtRlRIWGJtQVdBNGxEcDZr?=
 =?utf-8?B?dUJ1cm1EKzVrVk5qcEMxaUdVNmVUbjBZdG1rdHdlSUhRWkJ4b2RUVUJBTGpu?=
 =?utf-8?B?RUJDdWxUVDFGdWhZSmVYQWdFdjkzWVJoSURBOUQ4Y28yWUhvRDRhYm1GRktE?=
 =?utf-8?B?dGY1ZUViY0ozVmVrUWR1QUZYMjRLL2Z5SzVoSDlheGRXT01lQ01tOUJZdjBm?=
 =?utf-8?B?b0dqV0VpRGpPKzdibmpLR3EvbmcrZC81WlpNWHE3a1lXejE5ck9XYS9lNElw?=
 =?utf-8?B?V0NyOUR1bW8rdU9IRVA2Mm81bWUyVnVhVzN4RUVYZ3U3T0U1QlZIWmE5VkRL?=
 =?utf-8?B?cVBZQXZuMDZQZ3lyWTIrOEQ5THRSYUJrdVl3RHc2YWIwODdmajBUaVVCT0NH?=
 =?utf-8?B?cHFVQVFURW4rcXpOMUFUV3dJTkt3am1yVmxzSDJlMk9BNkJVZ2dvNjZuTUlh?=
 =?utf-8?B?bkpwc0lOemtzYnVvanJBUWJtMEMxaG55YUl1ekRiV1Y4b3hSNkI1S0VxUGtO?=
 =?utf-8?B?QlFsaXZCVjRMTTYrVUVpb2pqSWcvSVA3aUllcTRRQzBwNDNkTWF6U2pydVJX?=
 =?utf-8?B?NUtzTkJ6eU83MnVBMnBRMy9PYWEycDhJMXVrNFAwUjZXYmUvd2N2REt6Y25N?=
 =?utf-8?B?RERFaEx5MGlLYWo3NWxRTFpCV3JOWFlTVGdXSjJTNjFuUjZ3SWxMTTNiZnVr?=
 =?utf-8?Q?aW8gPLkdyW9uuBJEuirgkH3t1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51639c3e-e9b9-4fca-2690-08ddd3dbf66b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 04:53:04.4157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DMbLxH90cGz2+1oAXd841ahAs5rxFWJO3vWRe1wbna+MM/723q4RkWUYi0UNV/lk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492
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



On 8/4/2025 7:47 PM, Asad Kamal wrote:
> Fetch system metrics table to fill gpuboard/baseboard temperature
> metrics data for smu_v13_0_12
> 
> v2: Remove unnecessary checks, used separate metrics time for
> temperature metrics table(Lijo)
> 
> v3: Use cached values for back to back system metrics query(Lijo)
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   1 +
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   2 +
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +-
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 248 +++++++++++++++++-
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |   6 +
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |   3 +
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  26 ++
>  7 files changed, 287 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 8b015107f761..dc48a1dd8be4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -766,6 +766,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
>  	case IP_VERSION(13, 0, 14):
>  	case IP_VERSION(13, 0, 12):
>  		smu_v13_0_6_set_ppt_funcs(smu);
> +		smu_v13_0_6_set_temp_funcs(smu);
>  		/* Enable pp_od_clk_voltage node */
>  		smu->od_enabled = true;
>  		break;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index b490c39e313e..611b381b9147 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -257,6 +257,7 @@ struct smu_table {
>  	void *cpu_addr;
>  	struct amdgpu_bo *bo;
>  	uint32_t version;
> +	unsigned long  metrics_time;
>  };
>  
>  enum smu_perf_level_designation {
> @@ -322,6 +323,7 @@ enum smu_table_id {
>  	SMU_TABLE_ECCINFO,
>  	SMU_TABLE_COMBO_PPTABLE,
>  	SMU_TABLE_WIFIBAND,
> +	SMU_TABLE_TEMP_METRICS,
>  	SMU_TABLE_COUNT,
>  };
>  
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index d7a9e41820fa..458c4ac2dfbc 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -278,7 +278,8 @@
>  	__SMU_DUMMY_MAP(MALLPowerState), \
>  	__SMU_DUMMY_MAP(ResetSDMA), \
>  	__SMU_DUMMY_MAP(ResetVCN), \
> -	__SMU_DUMMY_MAP(GetStaticMetricsTable),
> +	__SMU_DUMMY_MAP(GetStaticMetricsTable), \
> +	__SMU_DUMMY_MAP(GetSystemMetricsTable),
>  
>  #undef __SMU_DUMMY_MAP
>  #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> index 02a455a31c25..f1121d79dc35 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> @@ -138,6 +138,7 @@ const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] =
>  	MSG_MAP(SetThrottlingPolicy,                 PPSMC_MSG_SetThrottlingPolicy,             0),
>  	MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,                       0),
>  	MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticMetricsTable,           1),
> +	MSG_MAP(GetSystemMetricsTable,               PPSMC_MSG_GetSystemMetricsTable,           0),
>  };
>  
>  static int smu_v13_0_12_get_enabled_mask(struct smu_context *smu,
> @@ -184,7 +185,8 @@ static int smu_v13_0_12_fru_get_product_info(struct smu_context *smu,
>  
>  int smu_v13_0_12_get_max_metrics_size(void)
>  {
> -	return max(sizeof(StaticMetricsTable_t), sizeof(MetricsTable_t));
> +	return max3(sizeof(StaticMetricsTable_t), sizeof(MetricsTable_t),
> +		   sizeof(SystemMetricsTable_t));
>  }
>  
>  static void smu_v13_0_12_init_xgmi_data(struct smu_context *smu,
> @@ -359,6 +361,245 @@ int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
>  	return 0;
>  }
>  
> +static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu, void *metrics_table,
> +						 bool bypass_cache)
> +{
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +	uint32_t table_size = smu_table->tables[SMU_TABLE_SMU_METRICS].size;
> +	struct smu_table *table = &smu_table->driver_table;
> +	int ret;
> +
> +	if (bypass_cache || !smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time ||
> +	    time_after(jiffies,
> +		       smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time +
> +		       msecs_to_jiffies(1))) {
> +		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetSystemMetricsTable, NULL);
> +		if (ret) {
> +			dev_info(smu->adev->dev,
> +				 "Failed to export system metrics table!\n");
> +			return ret;
> +		}
> +
> +		amdgpu_asic_invalidate_hdp(smu->adev, NULL);
> +		memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
> +
> +		smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time = jiffies;
> +	}
> +
> +	if (metrics_table)
> +		memcpy(metrics_table, smu_table->metrics_table, sizeof(SystemMetricsTable_t));
> +
> +	return 0;
> +}
> +
> +static enum amdgpu_node_temp smu_v13_0_12_get_node_sensor_type(NODE_TEMP_e type)
> +{
> +	switch (type) {
> +	case NODE_TEMP_RETIMER:
> +		return AMDGPU_RETIMER_X_TEMP;
> +	case NODE_TEMP_IBC_TEMP:
> +		return AMDGPU_OAM_X_IBC_TEMP;
> +	case NODE_TEMP_IBC_2_TEMP:
> +		return AMDGPU_OAM_X_IBC_2_TEMP;
> +	case NODE_TEMP_VDD18_VR_TEMP:
> +		return AMDGPU_OAM_X_VDD18_VR_TEMP;
> +	case NODE_TEMP_04_HBM_B_VR_TEMP:
> +		return AMDGPU_OAM_X_04_HBM_B_VR_TEMP;
> +	case NODE_TEMP_04_HBM_D_VR_TEMP:
> +		return AMDGPU_OAM_X_04_HBM_D_VR_TEMP;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static enum amdgpu_vr_temp smu_v13_0_12_get_vr_sensor_type(SVI_TEMP_e type)
> +{
> +	switch (type) {
> +	case SVI_VDDCR_VDD0_TEMP:
> +		return AMDGPU_VDDCR_VDD0_TEMP;
> +	case SVI_VDDCR_VDD1_TEMP:
> +		return AMDGPU_VDDCR_VDD1_TEMP;
> +	case SVI_VDDCR_VDD2_TEMP:
> +		return AMDGPU_VDDCR_VDD2_TEMP;
> +	case SVI_VDDCR_VDD3_TEMP:
> +		return AMDGPU_VDDCR_VDD3_TEMP;
> +	case SVI_VDDCR_SOC_A_TEMP:
> +		return AMDGPU_VDDCR_SOC_A_TEMP;
> +	case SVI_VDDCR_SOC_C_TEMP:
> +		return AMDGPU_VDDCR_SOC_C_TEMP;
> +	case SVI_VDDCR_SOCIO_A_TEMP:
> +		return AMDGPU_VDDCR_SOCIO_A_TEMP;
> +	case SVI_VDDCR_SOCIO_C_TEMP:
> +		return AMDGPU_VDDCR_SOCIO_C_TEMP;
> +	case SVI_VDD_085_HBM_TEMP:
> +		return AMDGPU_VDD_085_HBM_TEMP;
> +	case SVI_VDDCR_11_HBM_B_TEMP:
> +		return AMDGPU_VDDCR_11_HBM_B_TEMP;
> +	case SVI_VDDCR_11_HBM_D_TEMP:
> +		return AMDGPU_VDDCR_11_HBM_D_TEMP;
> +	case SVI_VDD_USR_TEMP:
> +		return AMDGPU_VDD_USR_TEMP;
> +	case SVI_VDDIO_11_E32_TEMP:
> +		return AMDGPU_VDDIO_11_E32_TEMP;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static enum amdgpu_system_temp smu_v13_0_12_get_system_sensor_type(SYSTEM_TEMP_e type)
> +{
> +	switch (type) {
> +	case SYSTEM_TEMP_UBB_FPGA:
> +		return AMDGPU_UBB_FPGA_TEMP;
> +	case SYSTEM_TEMP_UBB_FRONT:
> +		return AMDGPU_UBB_FRONT_TEMP;
> +	case SYSTEM_TEMP_UBB_BACK:
> +		return AMDGPU_UBB_BACK_TEMP;
> +	case SYSTEM_TEMP_UBB_OAM7:
> +		return AMDGPU_UBB_OAM7_TEMP;
> +	case SYSTEM_TEMP_UBB_IBC:
> +		return AMDGPU_UBB_IBC_TEMP;
> +	case SYSTEM_TEMP_UBB_UFPGA:
> +		return AMDGPU_UBB_UFPGA_TEMP;
> +	case SYSTEM_TEMP_UBB_OAM1:
> +		return AMDGPU_UBB_OAM1_TEMP;
> +	case SYSTEM_TEMP_OAM_0_1_HSC:
> +		return AMDGPU_OAM_0_1_HSC_TEMP;
> +	case SYSTEM_TEMP_OAM_2_3_HSC:
> +		return AMDGPU_OAM_2_3_HSC_TEMP;
> +	case SYSTEM_TEMP_OAM_4_5_HSC:
> +		return AMDGPU_OAM_4_5_HSC_TEMP;
> +	case SYSTEM_TEMP_OAM_6_7_HSC:
> +		return AMDGPU_OAM_6_7_HSC_TEMP;
> +	case SYSTEM_TEMP_UBB_FPGA_0V72_VR:
> +		return AMDGPU_UBB_FPGA_0V72_VR_TEMP;
> +	case SYSTEM_TEMP_UBB_FPGA_3V3_VR:
> +		return AMDGPU_UBB_FPGA_3V3_VR_TEMP;
> +	case SYSTEM_TEMP_RETIMER_0_1_2_3_1V2_VR:
> +		return AMDGPU_RETIMER_0_1_2_3_1V2_VR_TEMP;
> +	case SYSTEM_TEMP_RETIMER_4_5_6_7_1V2_VR:
> +		return AMDGPU_RETIMER_4_5_6_7_1V2_VR_TEMP;
> +	case SYSTEM_TEMP_RETIMER_0_1_0V9_VR:
> +		return AMDGPU_RETIMER_0_1_0V9_VR_TEMP;
> +	case SYSTEM_TEMP_RETIMER_4_5_0V9_VR:
> +		return AMDGPU_RETIMER_4_5_0V9_VR_TEMP;
> +	case SYSTEM_TEMP_RETIMER_2_3_0V9_VR:
> +		return AMDGPU_RETIMER_2_3_0V9_VR_TEMP;
> +	case SYSTEM_TEMP_RETIMER_6_7_0V9_VR:
> +		return AMDGPU_RETIMER_6_7_0V9_VR_TEMP;
> +	case SYSTEM_TEMP_OAM_0_1_2_3_3V3_VR:
> +		return AMDGPU_OAM_0_1_2_3_3V3_VR_TEMP;
> +	case SYSTEM_TEMP_OAM_4_5_6_7_3V3_VR:
> +		return AMDGPU_OAM_4_5_6_7_3V3_VR_TEMP;
> +	case SYSTEM_TEMP_IBC_HSC:
> +		return AMDGPU_IBC_HSC_TEMP;
> +	case SYSTEM_TEMP_IBC:
> +		return AMDGPU_IBC_TEMP;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static bool smu_v13_0_12_is_temp_metrics_supported(struct smu_context *smu,
> +						   enum smu_temp_metric_type type)
> +{
> +	switch (type) {
> +	case SMU_TEMP_METRIC_BASEBOARD:
> +		if (smu->adev->gmc.xgmi.physical_node_id == 0 &&
> +		    smu->adev->gmc.xgmi.num_physical_nodes > 1 &&
> +		    smu_v13_0_6_cap_supported(smu, SMU_CAP(TEMP_METRICS)))
> +			return true;
> +		break;
> +	case SMU_TEMP_METRIC_GPUBOARD:
> +		return smu_v13_0_6_cap_supported(smu, SMU_CAP(TEMP_METRICS));
> +	default:
> +		break;
> +	}
> +
> +	return false;
> +}
> +
> +static ssize_t smu_v13_0_12_get_temp_metrics(struct smu_context *smu,
> +					     enum smu_temp_metric_type type, void *table)
> +{
> +	struct amdgpu_gpuboard_temp_metrics_v1_0 *gpuboard_temp_metrics;
> +	struct amdgpu_baseboard_temp_metrics_v1_0 *baseboard_temp_metrics;
> +	SystemMetricsTable_t *metrics;
> +	u32 idx, sensors;
> +	int ret, sensor_type;
> +	ssize_t size = 0;

This init is not required.

Thanks,
Lijo

> +
> +	size = (type == SMU_TEMP_METRIC_GPUBOARD) ?
> +		sizeof(*gpuboard_temp_metrics) : sizeof(*baseboard_temp_metrics);
> +
> +	if (!table)
> +		goto out;
> +	metrics = kzalloc(sizeof(SystemMetricsTable_t), GFP_KERNEL);
> +	if (!metrics)
> +		return -ENOMEM;
> +	gpuboard_temp_metrics = (struct amdgpu_gpuboard_temp_metrics_v1_0 *)table;
> +	baseboard_temp_metrics = (struct amdgpu_baseboard_temp_metrics_v1_0 *)table;
> +	if (type  == SMU_TEMP_METRIC_GPUBOARD)
> +		smu_cmn_init_gpuboard_temp_metrics(gpuboard_temp_metrics, 1, 0);
> +	else if (type  == SMU_TEMP_METRIC_BASEBOARD)
> +		smu_cmn_init_baseboard_temp_metrics(baseboard_temp_metrics, 1, 0);
> +
> +	ret = smu_v13_0_12_get_system_metrics_table(smu, metrics, false);
> +	if (ret) {
> +		kfree(metrics);
> +		return ret;
> +	}
> +
> +	if (type == SMU_TEMP_METRIC_GPUBOARD) {
> +		gpuboard_temp_metrics->accumulation_counter = metrics->AccumulationCounter;
> +		gpuboard_temp_metrics->label_version = metrics->LabelVersion;
> +		gpuboard_temp_metrics->node_id = metrics->NodeIdentifier;
> +
> +		idx = 0;
> +		for (sensors = 0; sensors < NODE_TEMP_MAX_TEMP_ENTRIES; sensors++) {
> +			if (metrics->NodeTemperatures[sensors] != -1) {
> +				sensor_type = smu_v13_0_12_get_node_sensor_type(sensors);
> +				gpuboard_temp_metrics->node_temp[idx] =
> +					((int)metrics->NodeTemperatures[sensors])  & 0xFFFFFF;
> +				gpuboard_temp_metrics->node_temp[idx] |= (sensor_type << 24);
> +				idx++;
> +			}
> +		}
> +
> +		idx = 0;
> +
> +		for (sensors = 0; sensors < SVI_MAX_TEMP_ENTRIES; sensors++) {
> +			if (metrics->VrTemperatures[sensors] != -1) {
> +				sensor_type = smu_v13_0_12_get_vr_sensor_type(sensors);
> +				gpuboard_temp_metrics->vr_temp[idx] =
> +					((int)metrics->VrTemperatures[sensors])  & 0xFFFFFF;
> +				gpuboard_temp_metrics->vr_temp[idx] |= (sensor_type << 24);
> +				idx++;
> +			}
> +		}
> +	} else if (type == SMU_TEMP_METRIC_BASEBOARD) {
> +		baseboard_temp_metrics->accumulation_counter = metrics->AccumulationCounter;
> +		baseboard_temp_metrics->label_version = metrics->LabelVersion;
> +		baseboard_temp_metrics->node_id = metrics->NodeIdentifier;
> +
> +		idx = 0;
> +		for (sensors = 0; sensors < SYSTEM_TEMP_MAX_ENTRIES; sensors++) {
> +			if (metrics->SystemTemperatures[sensors] != -1) {
> +				sensor_type = smu_v13_0_12_get_system_sensor_type(sensors);
> +				baseboard_temp_metrics->system_temp[idx] =
> +					((int)metrics->SystemTemperatures[sensors])  & 0xFFFFFF;
> +				baseboard_temp_metrics->system_temp[idx] |= (sensor_type << 24);
> +				idx++;
> +			}
> +		}
> +	}
> +
> +	kfree(metrics);
> +
> +out:
> +	return size;
> +}
> +
>  ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context *smu, struct amdgpu_xcp *xcp, void *table, void *smu_metrics)
>  {
>  	const u8 num_jpeg_rings = NUM_JPEG_RINGS_FW;
> @@ -572,3 +813,8 @@ ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table, void
>  
>  	return sizeof(*gpu_metrics);
>  }
> +
> +const struct smu_temp_funcs smu_v13_0_12_temp_funcs = {
> +	.temp_metrics_is_supported = smu_v13_0_12_is_temp_metrics_supported,
> +	.get_temp_metrics = smu_v13_0_12_get_temp_metrics,
> +};
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 9cc294f4708b..c777c0e4ea11 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -3857,3 +3857,9 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
>  	amdgpu_mca_smu_init_funcs(smu->adev, &smu_v13_0_6_mca_smu_funcs);
>  	amdgpu_aca_set_smu_funcs(smu->adev, &smu_v13_0_6_aca_smu_funcs);
>  }
> +
> +void smu_v13_0_6_set_temp_funcs(struct smu_context *smu)
> +{
> +	smu->smu_temp.temp_funcs = (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)
> +			== IP_VERSION(13, 0, 12)) ? &smu_v13_0_12_temp_funcs : NULL;
> +}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> index 67b30674fd31..ece04ad724fb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> @@ -68,10 +68,12 @@ enum smu_v13_0_6_caps {
>  	SMU_CAP(HST_LIMIT_METRICS),
>  	SMU_CAP(BOARD_VOLTAGE),
>  	SMU_CAP(PLDM_VERSION),
> +	SMU_CAP(TEMP_METRICS),
>  	SMU_CAP(ALL),
>  };
>  
>  extern void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu);
> +extern void smu_v13_0_6_set_temp_funcs(struct smu_context *smu);
>  bool smu_v13_0_6_cap_supported(struct smu_context *smu, enum smu_v13_0_6_caps cap);
>  int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu);
>  int smu_v13_0_6_get_metrics_table(struct smu_context *smu, void *metrics_table,
> @@ -88,4 +90,5 @@ ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context *smu,
>  				     void *smu_metrics);
>  extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];
>  extern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];
> +extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index a608cdbdada4..d588f74b98de 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -65,6 +65,32 @@
>  		header->structure_size = sizeof(*tmp);                     \
>  	} while (0)
>  
> +#define smu_cmn_init_baseboard_temp_metrics(ptr, fr, cr)                        \
> +	do {                                                                    \
> +		typecheck(struct amdgpu_baseboard_temp_metrics_v##fr##_##cr *,  \
> +			  (ptr));                                               \
> +		struct amdgpu_baseboard_temp_metrics_v##fr##_##cr *tmp = (ptr); \
> +		struct metrics_table_header *header =                           \
> +			(struct metrics_table_header *)tmp;                     \
> +		memset(header, 0xFF, sizeof(*tmp));                             \
> +		header->format_revision = fr;                                   \
> +		header->content_revision = cr;                                  \
> +		header->structure_size = sizeof(*tmp);                          \
> +	} while (0)
> +
> +#define smu_cmn_init_gpuboard_temp_metrics(ptr, fr, cr)                         \
> +	do {                                                                    \
> +		typecheck(struct amdgpu_gpuboard_temp_metrics_v##fr##_##cr *,   \
> +			  (ptr));                                               \
> +		struct amdgpu_gpuboard_temp_metrics_v##fr##_##cr *tmp = (ptr);  \
> +		struct metrics_table_header *header =                           \
> +			(struct metrics_table_header *)tmp;                     \
> +		memset(header, 0xFF, sizeof(*tmp));                             \
> +		header->format_revision = fr;                                   \
> +		header->content_revision = cr;                                  \
> +		header->structure_size = sizeof(*tmp);                          \
> +	} while (0)
> +
>  extern const int link_speed[];
>  
>  /* Helper to Convert from PCIE Gen 1/2/3/4/5/6 to 0.1 GT/s speed units */

