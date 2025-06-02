Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A893AC54FB3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jun 2025 08:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4328610E486;
	Mon,  2 Jun 2025 08:23:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oI5D1/G+";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A14510E486
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jun 2025 08:23:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIgFWVbT8YSv0DggkXXqx41LUqBxIq7wMrycynwXNWtySsLUzHZxQtbFyjBQ70VCFl8EsKtRhtchmaRJKLtSnaq2ZlZqOEIbwCdL0UFQgTT2RxqWWOihpEo/5HnQl0Wou+qO39op99RWlC1ADdqrJnavgAupLrCxgtW96KMFqnp6Nuc2ZsEojagmsLKRWxJOVcyo1+qINZDEOepA8s/blMBNOUAATPC42zbjBBO70p/Cowv+wKkS8pEhAjka4S4hPCvJmMDBj1f12gHf16Fm0nHjcWasw1OuapH8vnW+HUsEz/MG1TqLchP//VXiVN0XqQHTSyvE74k1ulbD5IJ7vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c85GG+Ge3H0ugB4vcwiGJOu0md/CgyIdTVGbso/cnks=;
 b=wII8MO08AiKRUQU7PyWzz6N0ACKLeM97lsOIMG30+02/e/rNZV2K0xCiXG66PF/KFTG3xhN5p/isABlIOYbf01niRL3/tDhBy50h1k7rvXvb6YENwgDmXvPVEBFsSuLEI1rogun8mYEtVA4mN+xyKeLMZOkHilPdeQbPMMI2MtT74gnUYb+M40/VIB0ifWWv3gOYjMoMfbQl/0pu8d8xHQYBtKDCbkXEqQQv1p7fvLbRmqio7VR7N9k7FsiPk1z1Cc66bQNPGJGNadBtjvOx7i1D8pT2nz98MHI5WSd71U+Oa+WwqErhVdbr0LKTKDYITELyFEQYHcryRp7mYl6e4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c85GG+Ge3H0ugB4vcwiGJOu0md/CgyIdTVGbso/cnks=;
 b=oI5D1/G+EFoGU7Dyns/nWOPqG4Q2lod671gdJeN7X+MeSSLky5LPZ6nONsZtNdWAQWMH7HdHuVgoTXnkutLT8l2tuBcB4j3gNLt1/P4usTIKxbj1vXay5nST1AEbOmbSPx/9wcVRk7GNo/+MNPWC5O3SZDunPeYzvVzJr6b5mMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYXPR12MB9444.namprd12.prod.outlook.com (2603:10b6:930:d6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Mon, 2 Jun
 2025 08:23:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Mon, 2 Jun 2025
 08:23:31 +0000
Message-ID: <6cbdd791-cf8f-42f5-a5aa-e228415b195e@amd.com>
Date: Mon, 2 Jun 2025 10:23:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: only export available rings to mesa for
 enabling kq|uq
To: "Liang, Prike" <Prike.Liang@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250528083756.847677-1-Prike.Liang@amd.com>
 <CADnq5_MRsoGeKDhNHuKZbAbjRM9WNAc20q_T60y8kN1biBL0Lg@mail.gmail.com>
 <DS7PR12MB6005CC481C03A04628CD56CFFB66A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB6005CC481C03A04628CD56CFFB66A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYXPR12MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: 4749557d-c546-4ccf-61ca-08dda1aec26a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGtFQlg0Qmlxc1dTZVE0aC9KMVhnRXEvaTgxNnZ1NU40bXBROXZzS2w3VEVX?=
 =?utf-8?B?N3MwZkxHL29KK1A3aWJrQUFVYUxPRUFETWkwV2RMRjlxRDhDMmJWUVdKMEhk?=
 =?utf-8?B?ZFlxMHdzSWlkWm1VMTR4MVlOWDkzN1JuaHhqZ0o3aXR4UGVMU1EyWWRkcEIz?=
 =?utf-8?B?TW5Lb2RmM2p5ZmZUcWNTVkNmQ3pjeDBpR3JFaVV1N1VRa0NEMTNCOHFXTnIr?=
 =?utf-8?B?b21nalc0dGN3NzUwSm11aGV4QTBmYXM3QjRWdXkvVVhvakpObkc1TzVUdXdr?=
 =?utf-8?B?V3YrZDB1TUxpT2ZwQ0lqT3lWeCtmWFhhL0RIR1EwbzdRb0lIeS8vSHUzV2FB?=
 =?utf-8?B?NTNqVEkxdzhRZGdkM1pScG5aaVYzUTZDYXFXUG5nMTZOYnJuZm5VSForZGdn?=
 =?utf-8?B?RDlUZjJlVnJrcVpmdFpNNkF3NkZibk5CdmMzdmRlT2lXUmNRYUEzdHFSWkFk?=
 =?utf-8?B?dDh0bkJCdVJWSGRTVkEzT3dUL2c2RjByMEJ1Q1FkUVozQUlBVUs4WGlBSGZP?=
 =?utf-8?B?dGk4bUVlbCtEelJtYzBJS2tUNGlIdThodzllVzAydVR6RkRJc3kvRisraWF1?=
 =?utf-8?B?T2VZdWV6aW95TWtjL1lVdjZ4QzhacCtVOTE3cThPL0Y5LytsTkZET1hsdlFw?=
 =?utf-8?B?NmNnT2RWUzU0V2dIaUVscldrdExwR2pTSkZVTjd4VXBNaGhSQmJxREFUYkdB?=
 =?utf-8?B?TTliZ0g1UXNqQlY1cHU4L2RpdDBhZ0JPRTY4S1hJWlF1bVk2ZHZNdjBKTmdL?=
 =?utf-8?B?YU53SWxLOVBUN2FQTU9USXVKOUpQb1l3ZkludytLTTVOLytpMzVVeTYzdzNz?=
 =?utf-8?B?aHRPSnhoM2o0VXpZOUtHaVEyRTZHVEdDSGNFSDFnZlJtTm1IUEN1dHl3Szd6?=
 =?utf-8?B?akx3dEFzZWpUR2doSE1La01BVExsM0k5b3hyZ1ZVcGpPK0FUZ1B4SXVlUkRU?=
 =?utf-8?B?ZlV3S1hPNXVNU2ZDSlgxLzdMVmZDNFJMSTVwQUk4d3BsTGtWbkplUkVETW9k?=
 =?utf-8?B?YjRmbWdwWWZhOFdsa3lVTHdHRnFCS0N2Wmo5QktVKzlUYldVUHphSndhUjdB?=
 =?utf-8?B?QmF3eDFWNTVqY0x4YmFrWUZvS1kzUEFTeG15YVMraDVLcHlxWmc5cGhnRUVm?=
 =?utf-8?B?c28zdldnL3dzNFhSeGRBQUFCTlAwclFmdDBtOUxVbU04b3EvbXB0blVlYWZK?=
 =?utf-8?B?UGk3eFdZZXJZZ2RFTjZuK3VZY2V3Qjh4TWVWVndsRWVYSE1sdWg1SndNUXJj?=
 =?utf-8?B?OXVUU0htRjZxZjBFcDBOanU4bHg5WlErY0FoSHJNYjBEYUt2RFpnY0RzMVZC?=
 =?utf-8?B?VTBJNGJkNjZrbW9pSzlNWmxpTlFNSGxFTEtVaEdpYlVyTk9XQlM3V1VQT3d0?=
 =?utf-8?B?NkFOQTNNb3pIWVpGNEsyVjM4M0ptUHExd21FaGI1RDVJbkJRdGhCeUVYanlk?=
 =?utf-8?B?ZU9YNURoL1U3a3FQZ05NbVNsU1QvOXlQK2kreCtnRXNsNUNCd0ZkditEYmdV?=
 =?utf-8?B?RFlTeXlmbnJHTHlJRGtyc0RmZlZhc25JdUdXdjUzdmloYkZQa2J0eWViMWJj?=
 =?utf-8?B?bUl4Ym9FZHdRZVVGVnlPYVZHMXh5cFJNUkhtWC81MFhUM0JKQ044L2JDNnJP?=
 =?utf-8?B?Skt0eUk1OHJwZGZPcFBhNHJTNXU4MThFWEFEOTV6dk1FNWRZOHlkaEFmS295?=
 =?utf-8?B?aHEwV0dCcTNHelAzYVJMVzNoQ1dLN2hiOEZDckFSb1U5bml4UlczUzlFQW1S?=
 =?utf-8?B?bmxZNFFUZnhSQ3IxODEwMTlDQVhqQnRvU1NLdEdWekVlYzdYN0ZrZkEwdldJ?=
 =?utf-8?B?eitzeDEvWWtvNDA2RWdKOVJpczcrMnNOYUs3R3dYUlZ1UUtiblpNQTdOUktG?=
 =?utf-8?B?R29qdUg5aFpHMDJ0R2k1bmFGQklTSXQrcVRSdWt1U29TUEtXdlZYbnBtVktM?=
 =?utf-8?Q?qEtjwdrLNHY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVB0NTE4QkIydkRxQ0duRllMdnorM0tyVUo5WHBzdVowNlpVN2dQMzgxNmlF?=
 =?utf-8?B?cW9kWVFXbUxmQXE1MmM3akRXcW1GbkNMMkhTQ0NvSXZmdWl3VVdVTXBIa3RU?=
 =?utf-8?B?L1d3K1ZXdUxxYm5XRzdyZWowc3ZoWTErcFgrYytRQkdZTU5pSWJYaGRzQUhD?=
 =?utf-8?B?aStSRHVLWWZweVIwSWNGVkhWTzVZZTRORVBhTmpRektUbXdhK3RsV3VZL1ZU?=
 =?utf-8?B?MWlvYW9LTjJVRll1Z0pjQ0UzR2FiRVRUZzRZbkZYVmpUTE5IcVVCVHpzMmNE?=
 =?utf-8?B?MjRIclVVVXdJbTZCOFVTYVFmVnFua1d2SXQ1Q2FWZHA0bEhJdVNrc2d6amVY?=
 =?utf-8?B?TUd3aTBtY0k4cWdlMnpzb29FdTZ3Vy9obDM0em5PRUJFRG5KMUtFZ3hPUXBw?=
 =?utf-8?B?a0N2ck5mRWZxaHRhK0lqM1hmVXBxSGtIaGN6bm1PTjVJdURUVm8wRjJVcm43?=
 =?utf-8?B?eGVjQS8za1dreCt5UGRQTVpBV1dyWnR5RmR0QlpicjJQUjk3dUxDdlAyUE9X?=
 =?utf-8?B?cEs0ZXYwcmgxblN3K2tJNFhLZWwwRHNnSVpVeURvKzd4SGR6V053Rmttdzhj?=
 =?utf-8?B?Y2JYbDhEcHYrS252M2gwZjN2RDVZM25BZ2tIenZieUxKejVhQk9wQmxqaHBt?=
 =?utf-8?B?Z0hMNkhmU3J4b2NkNE9JSVJGdmZHelE4OXBPQTR5VHp0bHhaT3kvYVQ4K0d5?=
 =?utf-8?B?d1FPaEFabU1sNFFyR25aakF2cHpyVWlQT3h5b3VLcXp2QTdxOEVXbFlaSWc0?=
 =?utf-8?B?STNnVnRGZFpYZTMvLzlyQko2VkNBTzNRMWtDUVpWRDBsTWNqKzh1NThTRzRs?=
 =?utf-8?B?UGZwNGI0T3NGQ1cvSkxQcGVuUHB2MXY1UGxjQXhkdEV4WDUzV29nTXpyWlVO?=
 =?utf-8?B?Q04zTU9GTWFtNmdBUE4vTDV1dlVXOUlncjE4eUJiTGVFTnF6UU9JczhyZ3N1?=
 =?utf-8?B?QlNSY3ZxVDhCcWRWTnZ4WU1tUGFnT3lMWXVwWDc2Z0RUaXBrT3J6MUNiV1pR?=
 =?utf-8?B?NllwL2ViTGF0V1cvazVzcy9Sb1ZnbGF6NmJ0dXZPdEJNVHU3L2Y5aStQVVlj?=
 =?utf-8?B?eklHZHNhOHB5Ykk1elZxWmZiR2psT3lEOTNrZHRlQ2Vnb0RXNkRqTmJJSW54?=
 =?utf-8?B?ZEpBVWZsS29rNmhzSS9wQS9YWE0wSTlsaGlMTUIwZlRnV3hDb2NUVmM0MEhv?=
 =?utf-8?B?M1l5RjB0OVJZR0pLRkQzQklNM0pSaUhoaCtiQWtCbXdYT2x2VDE0WXdHUVk5?=
 =?utf-8?B?M1dDRlRGKzIrT2NnbVFHNFhLS2p3SjRBd2RUbDhVUU1lbXd4SGhCVkhZaFVO?=
 =?utf-8?B?ZkcwS2NMY2hJTWVJa1pEWWI2eDNHK05qTkh0SjR4MTJBU3NLdkZRbXZpTTZV?=
 =?utf-8?B?bDZSSko2dFhTam1GZ1FtSi83RVJDWnpWTWJHd1ZMV09ENlJ4ODZVd1NadlUv?=
 =?utf-8?B?a0c4Ni96d3UraHNmRmQzakxnZTBkZ05nSCtqREFKNXMwTVBtci9uQ1hnWUl3?=
 =?utf-8?B?b1ZzT1YzRzRNOGM0MXFQR1UrcmR1dVF3TjZUQVFjRkFzRC9pZi9YR29sWHhp?=
 =?utf-8?B?eU1HMWhvakt3cmh6TDBGUFhpbWhmeVo5bDNKMmV4Tm5ZVFVrSWIrRDJBUzNN?=
 =?utf-8?B?WTVXRXFnNmExbWtRY1FXa0tYU0NVUnRsSUxtb1JsemlFczFJSXZHWis0cGFx?=
 =?utf-8?B?Z3h0OGU5d0hEN09zZ3huMThqWG5HajFWRHAvYy81MzFFbXhhWVd3d2NDK0lS?=
 =?utf-8?B?RDBoRktONTFNSHVUNkFuZDNKeDRveVZUQlpsUm94TDJaV0JZb0tkZzVSb3BD?=
 =?utf-8?B?ZUhaNVBXamZsTWdIL1Q4V3JSek5BM1dVTXhYcDRVRDVWa3ZXMVVEU0hyRjgz?=
 =?utf-8?B?NUZGcStBZmhwRjlRMUtnbm56bkhTaENSN0JBZm00OVpObnBxUmlzcjVFeHps?=
 =?utf-8?B?TUNBNStkTnpCRmZnc3VIZ2ZyQXpDZkNJVFpPL3h1cW1GUmhsNnFsOHNnVlZH?=
 =?utf-8?B?RkJ0MzVQejdNVWhXTmZpTlY1R3ZOdDI0LytlRzE5dHNYS1VkMngwamJMMHM0?=
 =?utf-8?B?Wk1HemNiak9reG5wZ0ZtL29oU0hQd1NndEdKZHB0U1YzSDE3NVdkWGI4SXpG?=
 =?utf-8?Q?sjr6inNIzmhVu1Y99W9GnJf4a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4749557d-c546-4ccf-61ca-08dda1aec26a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 08:23:31.7188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 898gHJ4Qi2e/Ey0yiZicZfgKWhTPlpwKoqfgD8r9dI7HKPZjSriuIdsvBasVgrYZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9444
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

On 5/29/25 04:05, Liang, Prike wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Alex Deucher <alexdeucher@gmail.com>
>> Sent: Wednesday, May 28, 2025 9:11 PM
>> To: Liang, Prike <Prike.Liang@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: only export available rings to mesa for enabling
>> kq|uq
>>
>> On Wed, May 28, 2025 at 4:38 AM Prike Liang <Prike.Liang@amd.com> wrote:
>>>
>>> The kernel driver only requires exporting available rings to the mesa
>>> when the userq is disabled; otherwise, the userq IP mask will be
>>> cleaned up in the mesa.
>>
>> The logic should work correctly as is.  There are three possible states:
>> 1. KQ only
>> 2. Both KQ and UQ
>> 3. UQ only
> 
> Yeah, but when the kernel driver tries to enable KQ and UQ at the same time by setting user_queue=1,while kernel driver will report available rings to Mesa, and Mesa will further clean up the userq mask, which makes user queue enablement fail. Without this change, the userq can only be enabled successfully separate from the kernel queue.

That is intentional behavior in Mesa for now and shouldn't be changed.

When we have enough confidence that user queues work reliable we can probably change Mesa at some point, but for now that is exactly the behavior we want.

Regards,
Christian.

> 
> Thaks,
> Prike
> 
>> Alex
>>
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 20 ++++++++++----------
>>>  1 file changed, 10 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> index d2ce7d86dbc8..43d86c09d8bb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> @@ -409,7 +409,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
>> *adev,
>>>                 type = AMD_IP_BLOCK_TYPE_GFX;
>>>                 for (i = 0; i < adev->gfx.num_gfx_rings; i++)
>>>                         if (adev->gfx.gfx_ring[i].sched.ready &&
>>> -                           !adev->gfx.gfx_ring[i].no_user_submission)
>>> +                           adev->gfx.disable_uq)
>>>                                 ++num_rings;
>>>                 ib_start_alignment = 32;
>>>                 ib_size_alignment = 32; @@ -418,7 +418,7 @@ static int
>>> amdgpu_hw_ip_info(struct amdgpu_device *adev,
>>>                 type = AMD_IP_BLOCK_TYPE_GFX;
>>>                 for (i = 0; i < adev->gfx.num_compute_rings; i++)
>>>                         if (adev->gfx.compute_ring[i].sched.ready &&
>>> -                           !adev->gfx.compute_ring[i].no_user_submission)
>>> +                           adev->gfx.disable_uq)
>>>                                 ++num_rings;
>>>                 ib_start_alignment = 32;
>>>                 ib_size_alignment = 32; @@ -427,7 +427,7 @@ static int
>>> amdgpu_hw_ip_info(struct amdgpu_device *adev,
>>>                 type = AMD_IP_BLOCK_TYPE_SDMA;
>>>                 for (i = 0; i < adev->sdma.num_instances; i++)
>>>                         if (adev->sdma.instance[i].ring.sched.ready &&
>>> -                           !adev->sdma.instance[i].ring.no_user_submission)
>>> +                               adev->gfx.disable_uq)
>>>                                 ++num_rings;
>>>                 ib_start_alignment = 256;
>>>                 ib_size_alignment = 4; @@ -439,7 +439,7 @@ static int
>>> amdgpu_hw_ip_info(struct amdgpu_device *adev,
>>>                                 continue;
>>>
>>>                         if (adev->uvd.inst[i].ring.sched.ready &&
>>> -                           !adev->uvd.inst[i].ring.no_user_submission)
>>> +                           adev->gfx.disable_uq)
>>>                                 ++num_rings;
>>>                 }
>>>                 ib_start_alignment = 256; @@ -449,7 +449,7 @@ static
>>> int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>>>                 type = AMD_IP_BLOCK_TYPE_VCE;
>>>                 for (i = 0; i < adev->vce.num_rings; i++)
>>>                         if (adev->vce.ring[i].sched.ready &&
>>> -                           !adev->vce.ring[i].no_user_submission)
>>> +                           adev->gfx.disable_uq)
>>>                                 ++num_rings;
>>>                 ib_start_alignment = 256;
>>>                 ib_size_alignment = 4; @@ -462,7 +462,7 @@ static int
>>> amdgpu_hw_ip_info(struct amdgpu_device *adev,
>>>
>>>                         for (j = 0; j < adev->uvd.num_enc_rings; j++)
>>>                                 if (adev->uvd.inst[i].ring_enc[j].sched.ready &&
>>> -                                   !adev->uvd.inst[i].ring_enc[j].no_user_submission)
>>> +                                   adev->gfx.disable_uq)
>>>                                         ++num_rings;
>>>                 }
>>>                 ib_start_alignment = 256; @@ -475,7 +475,7 @@ static
>>> int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>>>                                 continue;
>>>
>>>                         if (adev->vcn.inst[i].ring_dec.sched.ready &&
>>> -                           !adev->vcn.inst[i].ring_dec.no_user_submission)
>>> +                           adev->gfx.disable_uq)
>>>                                 ++num_rings;
>>>                 }
>>>                 ib_start_alignment = 256; @@ -489,7 +489,7 @@ static
>>> int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>>>
>>>                         for (j = 0; j < adev->vcn.inst[i].num_enc_rings; j++)
>>>                                 if (adev->vcn.inst[i].ring_enc[j].sched.ready &&
>>> -                                   !adev->vcn.inst[i].ring_enc[j].no_user_submission)
>>> +                                   adev->gfx.disable_uq)
>>>                                         ++num_rings;
>>>                 }
>>>                 ib_start_alignment = 256; @@ -505,7 +505,7 @@ static
>>> int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>>>
>>>                         for (j = 0; j < adev->jpeg.num_jpeg_rings; j++)
>>>                                 if (adev->jpeg.inst[i].ring_dec[j].sched.ready &&
>>> -                                   !adev->jpeg.inst[i].ring_dec[j].no_user_submission)
>>> +                                   adev->gfx.disable_uq)
>>>                                         ++num_rings;
>>>                 }
>>>                 ib_start_alignment = 256; @@ -514,7 +514,7 @@ static
>>> int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>>>         case AMDGPU_HW_IP_VPE:
>>>                 type = AMD_IP_BLOCK_TYPE_VPE;
>>>                 if (adev->vpe.ring.sched.ready &&
>>> -                   !adev->vpe.ring.no_user_submission)
>>> +                   adev->gfx.disable_uq)
>>>                         ++num_rings;
>>>                 ib_start_alignment = 256;
>>>                 ib_size_alignment = 4;
>>> --
>>> 2.34.1
>>>

