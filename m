Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11072D5B866
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 20:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96BC710E29D;
	Mon, 15 Dec 2025 20:44:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1G4BeSHb";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D87D10E29D
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 20:44:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJvZ+MnR7+BAjygJI9FrOX5trkTQ/NI3O3ePLmKz+z6EFuVp3vwXNRkmUUPfuwIVpYmXOdbL3hB5Jxjs4USA4lBMvHk5+Aae5WwgM1lBkVctMiF46oYEOOX74xyVvl51+PiAP2ySRuadR5H1tngqj2hKBaSz9Z/CCTZxCgF4r8HjW2T7Vl/OiKyZ4kBj9LfzHVoycZsbvG1L1+ZYAptvmSlFc/KgakWlfOwbNlueWNT41JFiCVU5AB5xNXUZ7yjTZKDUECUc+wHJhbEasFM4SGKpCzryK7TyxGzkFL84VdTTojW2tOx2BjFGV2B8FiExmNMwjmnMgTGg3ka1lyW3RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrYqpjQrScolKXtnGySTNQtoWBikHKb/omZCmXaH2tk=;
 b=MD4bh6WIEinpuTYQkdxGoe5e1pF8/y+YVz4ZHLtY8Fp8Ht3PeOjR1kO3fP8z11/rR37h1eP7DI+bsc8w+9igNTamMzjsMm640EffvzQnhtdb9DYXg3kRYW7h6ACFzI9sawhon4ul/+kCaa7ZrjM6lH9LRLTOSqqL5lnZz1uypmpxpdZGNgf89KnQFKGJedq2vXhRlDNQthxVgkTWgyOGJAJATz1bFoA4myFvgOEnxiAYOlaApng69EvvIdHaCw2h9SjhvVTbgw6Z1Dy7T7GDy9sWSqxdiUfEfIoqzeF+O85aEPNLzbIwjX+PSpTBnpf1yQyMOgU88qq2IrP84WVFLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrYqpjQrScolKXtnGySTNQtoWBikHKb/omZCmXaH2tk=;
 b=1G4BeSHbSc7R/IjzEj2L8W2BstnHwd7J6W1Hkx8/erccvhtobbZ6Rdc1vAjyw0JfzHaj4KhEw5OdKRDnaoK72MWp1CmxZCm3wyFR0tQ13v6zAmOMuFeCeMqKnEhGmzoKWBVfvm70HPC0DZq+VDY7n5h2JLhgzAVKiDtUPLp7+cA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by PH7PR12MB7017.namprd12.prod.outlook.com (2603:10b6:510:1b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 20:44:50 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 20:44:50 +0000
Message-ID: <d901390b-ad17-44de-b7d1-a5c6034baa0a@amd.com>
Date: Mon, 15 Dec 2025 15:44:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 2/8] amdkfd/kfd_svm: Fix SVM map/unmap address
 conversion for non-4k page sizes
To: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
Cc: Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
 <901c6820624fa444f2c6fadf77e9a24f3f93bf42.1765519875.git.donettom@linux.ibm.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <901c6820624fa444f2c6fadf77e9a24f3f93bf42.1765519875.git.donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0068.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::26) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|PH7PR12MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b02140-a85f-4232-3e29-08de3c1acabd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzNxckxRZ0x2dFVFVkl2RS95MGVsVlJ3K2xYVXZsN3NiUXgyRlhtczVaT2Ex?=
 =?utf-8?B?TWJ3UXB0aHhhSkErZkc3RG5GSDdlejJPYjNBalNDSFcvUHlkb2VoWjYvTmxX?=
 =?utf-8?B?Mk1IcitkRExKL2VYdzl2NzF6RTJNeFUxN096ajdEY0xsR3d0WGNvMXhtSXUv?=
 =?utf-8?B?YkwzSzliKzFVODhqaHRpT3M3ZjF1MUVkNnNMemtFcXIzOTBzVXNHSkdzaTFw?=
 =?utf-8?B?eFhCVFBMSTVLVnJHMmIzaWZTdnR4VEFTck45aGNuZkZCVUM3ZkV3Z2RoSFU5?=
 =?utf-8?B?cHhIZ2lncVNXTTFvOWpaOFc3V2FoTmxmV3h3RzVVQ1ZoMUNBdnRWdEVvcncv?=
 =?utf-8?B?eUpoQUIyWjMzVW55eXozL0hpT3ZPeGtKVk91SzEyaUw5Mm45Y05udjB5eEFB?=
 =?utf-8?B?WEp2M1NmM01sQ21wM3c1Z1pIK3NqWDBRRXFYd09CZE9ZRmpNWnR5QkJmR3p2?=
 =?utf-8?B?bVRoSkw3Zm1kb2FPRk41a2V2RzZhTzliaERlRDRTSWNpR1puVWRkMVVJWThI?=
 =?utf-8?B?MkdTck1ZdzhYV0xKY3VmU2FrdVFrVDcxaFBUTkJPU2h0OWN1a1dPdlBTRVdy?=
 =?utf-8?B?dFdzcmJsR0swZk42UDFaeldvN0t0UWNwRk5adDVlTHpQbkZ6UWhuWEsrTEM2?=
 =?utf-8?B?WUg1a2F0bGxaUzIweUUwRFd2MGY2NlZlOWx4NWx5dVlobm9NOVg0bEwxZFUv?=
 =?utf-8?B?OEVBdHY0ZTZnTjFhYk00cC9OY0p5WVVQbElpYVFQNkFCdGZJcmVZczluemFl?=
 =?utf-8?B?TDlPL1ByUEs2bzJMekF0L0xtTU1sTWxRaWNmYW56UnpXYVRpSmlBdWpDVUxn?=
 =?utf-8?B?THBuU0h3WVlCdjEyd1Mzd0FUbVVOM0FQa2dUQmdoWGp2QU1WalVUOGtQSkdw?=
 =?utf-8?B?ZWlTMFppS0hYODlMTnI5bTh5VmZvbmptV3N6VWtrSjNMWHRuMXNmUUV2Mzli?=
 =?utf-8?B?eHpLS1pNU3F1TCt0Z2dTOTNnZmJScUpiYkFsV21CQXRvVE1hSDU3TXZpWlUv?=
 =?utf-8?B?bTFNTHlabzE1SGNEOVR5eEIybXNzUTFLazhJUzFmdS9SSXNiayt6Qk1nUHR1?=
 =?utf-8?B?QlpTWmNhWDhRQ014VlJBeTJwaXN4REZBZllZNEhzK3JLU3NaT2JMQ0JVZERV?=
 =?utf-8?B?aTJMWDJvMlVjVHB2RzJzelk5b1FlVkREQml1SE15VktBUnJSYzhKLytxVEZl?=
 =?utf-8?B?alFzVG42MWs4N2xWVGgxYnBFUCtLeU1LWVRyNnp2NGRpWGpkZ3BUbGNPRXYy?=
 =?utf-8?B?K1dveVloMXFER0V4RlBkTUlqRVJ0T1dNdXIyV0lIWnBneW9MdGx1YWhkWlpW?=
 =?utf-8?B?dWJLb09Fd3hFOHR6MDc1WG4xZzB0UVIvai9EQWplT0lYNDNsa0tPREEvWWp5?=
 =?utf-8?B?YXJ0VW52RE1KTEFiVWQ3bTJzalQxemFnQVFnOUtwWnZ3Qk9WWjdVL0VIMXhw?=
 =?utf-8?B?ZTJmMjVwajNBSjdyU253Z2dXcVNFVkplRjB0VmtlbHJMSVB5RHlnb1R4VCtN?=
 =?utf-8?B?YUV2REdLNTZwZ1VYaE4vd0NYNWdVNVpvRjFodHY2eTNTVmlkSTZrazlraEV2?=
 =?utf-8?B?aFhFaVhHbDRjMmluSXpmYzE4Y2F1VHB5VVZ4TURHV1dEQkYzT055SHY0V3NY?=
 =?utf-8?B?NnAvbmk0T3FTbW5MTVdRMHFLNmVvNU9wVHgydFR0aUEwTHZuemFtMHVnNWVK?=
 =?utf-8?B?ZzcyaStOc2VzQXc0N3cvTWlHUkVENHBacWY4akZDQmtXVXk1WGZLb21veDgv?=
 =?utf-8?B?NXBDMWFQUzVGY21DK3RnM2MrZ3lOSzU3UVVQSndINWtmUlZIMC90dTlaR0Jh?=
 =?utf-8?B?NklzSFZZN1M3OTZUZWxLZHNFYW15MDk5NmIxemxLUVZuQlV5Y2FTUVE3cHlJ?=
 =?utf-8?B?aGJyTTBCTmJFZllRc3NOOFJpYk9UeFNnK1MvdWhWekVXOGNSNm5DUmJnbGc4?=
 =?utf-8?Q?kVl1gik+L2xYVOOHCOvzW1dj37F5ToYr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG5IbHJtMHlqMGlNQTFQeEdsMDUvdUNucDBaT0g3WW9QRHB3aUFIeGQ4eDVF?=
 =?utf-8?B?NjBRZkVOa2c0YktaZUZnR2FWOEdPQ3pXRi9tWVhwM1RYUlM3UXFacnl1WlU2?=
 =?utf-8?B?dGlPTzBxNHdkT0tybXBneFVveU1RcWx2aHRsVWFkMm1kb3RqQWhtTnpObzU1?=
 =?utf-8?B?NHpabkQ3SUZTZkV3MHREZDZWZ0lXbUU5NmVPUkU1am14UERTVEFXem9NY2Rn?=
 =?utf-8?B?YWsyM2tIZ296eWppLzk5Nkl1am16L3lzd2txUUh4L09sS3l0OE94L01DaHdU?=
 =?utf-8?B?TmRNUEhoOWZHOVI1QkdONVFMOWtTWG5XOXlXN3ZkeXRYa3gza3BmWThodXY2?=
 =?utf-8?B?QVJxWlk1TGhuTE1WVjdNRlVpUzRramg2SGRTRDNvWVp1aXZQZ3pBVkN1Y2xw?=
 =?utf-8?B?Y0VEQ0N6NCs1Mjh2WWFtUjlKcHFmVlBsbzJQQTJJUE9uQjZtOGlwU3JDblNv?=
 =?utf-8?B?SWVUbWRLaWlPcFJ6MFRsQ081dTlRZDRIb0tETnlPZG1Lakg5dU1xMWpGWExC?=
 =?utf-8?B?cktkR0FWMmhGa1lLSFc4eHBUbEhiei9scjltVC9ER2c5cWdITHFtQm1ORlY0?=
 =?utf-8?B?YStGekoxV0VNNTN2ZTk0bG1GSkJlMGpqS3Q3YmJEWlFOc2J6aFpjOVFKNG9n?=
 =?utf-8?B?MXNEVHdkWUQvcjNsd3dNQUs4cC9oSmJjOWN1WTY5YWFIQmE4cC9mTENqcnJ6?=
 =?utf-8?B?TENnMk1veVhWdHltSVhoMmlleEZVL2MxTWd5OWJIb1ZyYmdxYTJERjJJbVBM?=
 =?utf-8?B?eFRsRW5GVzA1VDI0U0hyTjdLWDFUSjVXNDl4ejBBcloyNUtmSnBwU1BBeEZl?=
 =?utf-8?B?YmdydFBFYWU2YWx1VXI2LzZXSXBhMTE0d1d5ODRReGVvUmtxMytTT3lzWThs?=
 =?utf-8?B?V1pnMVUydndiWGgyd2dWT2hzdS9aUUo4MVV2R0ljb2U1ZG05UzlXVlNkcnpN?=
 =?utf-8?B?bEIzRUhGdG83aklWY1Y5SHd4V0xwQllCT1p4UldBQWFZUDA1dVU3UFJoL0Jh?=
 =?utf-8?B?eis3bHArQ1hGYTl5Y2paZXo1Zmd2TnEwb3BRZFhlbXJvd3ptZEtLSU5WbHNU?=
 =?utf-8?B?MHBWSW80TS8zNGcrWER6NlIzTW9IeExCZlJsa1dSY1EyTUNMTjN3bmhQRDdi?=
 =?utf-8?B?Mm1GS0U1Sk1OblNEaDI1Y1NnMTQ0SDBLdHBBUFNyL3RWK3NuVzAvVWdnT21n?=
 =?utf-8?B?YWhVRkRuUEZMK3cvOFc2eHl6M0pkVHBoSmErVkxrTzVJN1RFRmtOTG1pek4x?=
 =?utf-8?B?d3liaGhvQXB1R0RObXN2TTN5dGN1T09DSEdIUERRSDBsTHJ6K3ZZL2wxZTVl?=
 =?utf-8?B?WnFiVHNDOEJBWXdnVXFMeTNpamVvZnNFNlV2VUxvTUx1T0k5dUE3ekJ2czhM?=
 =?utf-8?B?U3UvZzFOL3FTWWhTb01ObFpYd1R5My8zWGVTM2xSSnczRS8xR0RLcDlJRTNB?=
 =?utf-8?B?RXBhOEV3alhJMmc0RXUvMHAwNnZoVFc4citiQ2lhRFhFU241RThDWUNENUtM?=
 =?utf-8?B?c3FYeTZMZXZHMmNuNXFMRVR5VENQb2pHK3Z4V2wwZEdmV0ZIMi85VkxIeTZH?=
 =?utf-8?B?aXVKVkU5eXhQU0VBcmdlM2FQTElveXBMbEgvL3RiWDlsYlVQSzNReXBTYnZ4?=
 =?utf-8?B?bit1OWJ0Vnc2TEx6dGpZT1oyZFFSRkhmN2w1NjUzaVY2RkNVRXMwaE13Y2VO?=
 =?utf-8?B?MXdOV1hISWU1T01KR1IzSXZCQTlDUXo2NGpaL2JVUlZNaXBCNVArTXZGSjVW?=
 =?utf-8?B?c2lVMis5c3lxK3ZQM1VGTGVSR2xaZnFHWnQ5ZzhsMFZlOW45d0gxeng0MlNv?=
 =?utf-8?B?SDlzWnJNVzhhMlRIZXRkOU1SUnJsWkVHdnR0TXJMd1I2QVFBSEo1WFBFM24x?=
 =?utf-8?B?U01qWmh3MFI3VU1hNFc5VmpPM0dGVkRXek55ck55cEpkbm1WVVhxSDFHVUJv?=
 =?utf-8?B?OVNMK0RaMnI0Yk95WXdoVzhYYVliN1lTUklmZEU0eVNwZDVjdERhVmJ6R25I?=
 =?utf-8?B?M2w5dWpPb05Bd25xWmJzeTdSb2puN2FWSzVQSEZHRTJqZU9BcWhLc2I1eDVw?=
 =?utf-8?B?TVRnVVZvL2hjU2NBVjA3RDJBSkQ0bDNqVnVVY1dtSGplTmpjazJieEQ2cVdj?=
 =?utf-8?Q?tHNA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b02140-a85f-4232-3e29-08de3c1acabd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 20:44:50.5222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+m8EoqhIsg2AfZVDE2IRdg9qXnHmg0pfAvLNVm2xq2GHkamRbz5HUGFMudB3HpC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7017
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



On 2025-12-12 01:40, Donet Tom wrote:
> SVM range size is tracked using the system page size. The range start and
> end are aligned to system page-sized PFNs, so the total SVM range size
> equals the total number of pages in the SVM range multiplied by the system
> page size.
>
> The SVM range map/unmap functions pass these system page-sized PFN numbers
> to amdgpu_vm_update_range(), which expects PFNs based on the GPU page size
> (4K). On non-4K page systems, this mismatch causes only part of the SVM
> range to be mapped in the GPU page table, while the rest remains unmapped.
> If the GPU accesses an unmapped address within the same range, it results
> in a GPU page fault.
>
> To fix this, the required conversion has been added in both
> svm_range_map_to_gpu() and svm_range_unmap_from_gpu(), ensuring that all
> pages in the SVM range are correctly mapped on non-4K systems.
>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 30 ++++++++++++++++++++--------
>   1 file changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 74a1d3e1d52b..a2636f2d6c71 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1314,11 +1314,16 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			 struct dma_fence **fence)
>   {
>   	uint64_t init_pte_value = 0;
> +	uint64_t gpu_start, gpu_end;
>   
> -	pr_debug("[0x%llx 0x%llx]\n", start, last);
> +	// Convert CPU page range to GPU page range
> +	gpu_start = start * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
> +	gpu_end = (last + 1) * AMDGPU_GPU_PAGES_IN_CPU_PAGE - 1;
>   
> -	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, start,
> -				      last, init_pte_value, 0, 0, NULL, NULL,
> +	pr_debug("%s: CPU[0x%llx 0x%llx] -> GPU[0x%llx 0x%llx]\n", __func__,
dynamic debug control can enable function name, linenum print with +pfl, 
don't add __func__.
> +		 start, last, gpu_start, gpu_end);
> +	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, gpu_start,
> +				      gpu_end, init_pte_value, 0, 0, NULL, NULL,
>   				      fence);
>   }
>   
> @@ -1398,9 +1403,13 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   		 last_start, last_start + npages - 1, readonly);
>   
>   	for (i = offset; i < offset + npages; i++) {
> +		uint64_t gpu_start;
> +		uint64_t gpu_end;
> +
>   		last_domain = dma_addr[i] & SVM_RANGE_VRAM_DOMAIN;
>   		dma_addr[i] &= ~SVM_RANGE_VRAM_DOMAIN;
>   
> +
remove extra blank line.
>   		/* Collect all pages in the same address range and memory domain
>   		 * that can be mapped with a single call to update mapping.
>   		 */
> @@ -1415,17 +1424,22 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   		if (readonly)
>   			pte_flags &= ~AMDGPU_PTE_WRITEABLE;
>   
> -		pr_debug("svms 0x%p map [0x%lx 0x%llx] vram %d PTE 0x%llx\n",
> -			 prange->svms, last_start, prange->start + i,
> -			 (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
> -			 pte_flags);
>   
>   		/* For dGPU mode, we use same vm_manager to allocate VRAM for
>   		 * different memory partition based on fpfn/lpfn, we should use
>   		 * same vm_manager.vram_base_offset regardless memory partition.
>   		 */
> +		gpu_start = last_start * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
> +		gpu_end = (prange->start + i + 1) * AMDGPU_GPU_PAGES_IN_CPU_PAGE - 1;
> +
> +		pr_debug("svms 0x%p map CPU[0x%lx 0x%llx] GPU[0x%llx 0x%llx] vram %d PTE 0x%llx\n",
> +			 prange->svms, last_start, prange->start + i,
> +			 gpu_start, gpu_end,
> +			 (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
> +			 pte_flags);
> +
>   		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, true,
> -					   NULL, last_start, prange->start + i,
> +					   NULL, gpu_start, gpu_end,
>   					   pte_flags,
With those fixed, this looks good to me.

Reviewed-by: Philip Yang <Philip.Yang@amd.com>
>   					   (last_start - prange->start) << PAGE_SHIFT,
>   					   bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,

