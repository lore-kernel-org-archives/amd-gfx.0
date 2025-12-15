Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2C4D5B86E
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 21:03:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AEB310E0A8;
	Mon, 15 Dec 2025 21:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LlGo2CoG";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013022.outbound.protection.outlook.com
 [40.93.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF1D210E0A8
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 21:03:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxj91b8nu3zegorCO1QqjS5um/tOMnxLJ6nrVPwEQiNE1Dz/+brum3TvlZx/HosvI1+zGPoiv7vzlHD1SzU9iKXKXZQvxN0DECfi/iC/MO7p8RFTKQGIrtOGr8BSo3vUz93aGbt/ELqgh8OUyYpy8uYHpsqYxxLDEUH/0tDN6HtMH0jBCEMBMBNf4ZOqkDKMcjyH9aMMqZUC2wfuZinbudq6jn1fS0+c6eYRzn7nGSkXBf/3NZ14HGRVhTjnLiZEcPoMuMvKNTgx98gXYSTvh7GXAtt2eRwmVmZnWaoGdUXqtEsnfkbe/WaXTJ92hQ1tOJLPNqB8PUUp18Zcu5PcHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSPBcEibXxAGvFxNxz72fXi8yyUcl6LtD5n7CyxnMog=;
 b=wT9J6GIX8KLn2VSuN9KlNQXiDf7LNRflWC9QVsDgvjqQIIlMG4v4VgwqdUU6SN+D2+72ctarmWgoGSZ2+1tjn/4qebMCW7LBkyO2bwByhMcXisFqgae+WyXkn3YnQ5EMvwFS7ZhnSQ2koHz0yi3UoKBZp7ME8d5DCAFb8NRyesQvvG++mG6L1t9jvYpS9qObU+ZhlorLi8RtovpL5SIO3DnIdmWx+GyjsivaM2mspaLRUXK7pSojoSU9vxoFTTr11F2J96Pvsoyxr75hv7hMvXz+5+mJdLvkf2TB6zQvifcJHpLy5EbnrA6iM5cK69qlAyxQGsxbwLoUZLTY6rvIbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSPBcEibXxAGvFxNxz72fXi8yyUcl6LtD5n7CyxnMog=;
 b=LlGo2CoGB9TBnEQgbLBxFCD9J91mnr4O1O0B+lL4roc7WtfA2LCIySha97zxLzPAdICv38h5f40CvDCOiWUObPi3mPa8SR9IdmRrtwpTdEeNlvIow7EwDU3Jp3kEPeEU+Jq7F/c1u71qrXOhHqG6FW6DYaYGOa/vpgwZIX9zWdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SA3PR12MB9226.namprd12.prod.outlook.com (2603:10b6:806:396::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 21:03:13 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 21:03:13 +0000
Message-ID: <0e8c1847-c847-4e7a-9939-214da8a6af16@amd.com>
Date: Mon, 15 Dec 2025 16:03:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 3/8] amdkfd/kfd_migrate: Fix GART PTE for non-4K
 pagesize in svm_migrate_gart_map()
To: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
Cc: Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
 <12e16278a663e957019ce83b86b11f55d451d90b.1765519875.git.donettom@linux.ibm.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <12e16278a663e957019ce83b86b11f55d451d90b.1765519875.git.donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0082.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::15) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SA3PR12MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ddfbc6a-b1ce-4dc3-f316-08de3c1d5c03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2hNTjhSTGxNQmdQMnF5dk9XK3QrbTdkNE9udWhxUWxDbXVmRlJTTU1YeCtZ?=
 =?utf-8?B?NjZWY3lzMGNiajloQXFYcGZpN2VLUERXQ0RtdEE2WmNVdzdxOTY5S1p5SXlI?=
 =?utf-8?B?R1hPQzUrTHJvbzFVU1ErQlBnWFQ4WEFsY0dYV09xZ0N5U1huZW1GbHdlRFlF?=
 =?utf-8?B?azlFNFV2d2pvVlFjNEJNNGVKd1BHcFFyWXBXOUJjdngrTTJqbjBTQ010YnRY?=
 =?utf-8?B?QU13RHV3TTQ5djVhWUJQY09YMlJIQVR4SXRqOEthTGtkNHI0bmxrMHR1UlZK?=
 =?utf-8?B?a21IeXpUOGFXUk5pd0FYYysxOGZ1OE1mMUx5eTVKV1lIbVZmRHFGcHBPOTR1?=
 =?utf-8?B?ZEdxQkQ0UUM0Sk1Ea2s5R0QxV0NOWjNNWVZNUEtHR2s0c2RSQjVaK3JZNzVG?=
 =?utf-8?B?MGdNU2FpdkpKV2orbG1jREViT2hNNktpZ2tCTEtObHlKSTg5UnZsbnFyUFli?=
 =?utf-8?B?TWswU2xXamdkRUpmSGdPTFNWeW1WTDgzR1ZRM0NkK2hRY2R2b1Fwdy9iM3ZW?=
 =?utf-8?B?a2JGSWJLNWxVczg3N0lkeWJJWCsweFdPTmhqZllSY2Y3WTRrcXVuRXJYVjlm?=
 =?utf-8?B?Z2Z2NTNoZDhRNGJ2YnJZcHJlelBiZkdnNXltdVp1bittWVhmZU5qWUZNQU9H?=
 =?utf-8?B?dFRyOUJtR1lXRHp6eE9ub2RKdTkrMXN1YzI1OUt5WTlUL3BkelF0RnpvS2VV?=
 =?utf-8?B?UWZjWVB2V0RtL1NDSitKUlNQVU8waFdxbWNjTXFtTEg5Y1JSREVqNHJ6cXZS?=
 =?utf-8?B?Zlc1RTlwNUhoeTQ2Ykl5VjNtSTlJU2k0Z21MVkk3aUI3NUQxQ3B4WHU2MXFD?=
 =?utf-8?B?M0lLbG9WZDJ4YlIyL0o5ZS9ySWZOcTB0L2hLZmhodU1sbGk1QlB2V0Uxc0I3?=
 =?utf-8?B?UkNibTlPUjlZK1NmTWFVQ292NDhLcUtsWDNuMEtIQmRndUR4MUwyS0tlVWRL?=
 =?utf-8?B?QllHL3ZJVm5zY0dHSnZyM0t1U2FMdEwxdGw2VkhPc2NISW1oYm5kbnFickRW?=
 =?utf-8?B?M0NzNGRrbVFzVi9sdmIrZSt1aVkyOXZxMWpmU3RZRTlCZTNBOUlyL1hpOFpZ?=
 =?utf-8?B?U3paMjRqYzQ2ZnVYS3ArUXQrR2V6Nm91eVBxL0FvZ0Y4VVNneTdRcTZLT25S?=
 =?utf-8?B?T2syMHEwVXFpVGFyQlFXaDNWSExKZXViRHZmSmVkYzNoSkR4aXV6Rm1uNzkx?=
 =?utf-8?B?MHBQRzdLTkdKY0M2bFhSSk5FRlNlT21Pc0l3a1prMnN6UkQ2L2NCUk55Q2Q3?=
 =?utf-8?B?dnFEMnRValUva2lSNk9NWDl4TkVFVDQ3ZjQ0OFlQUFVOTm1wSGorRnN3M0Qv?=
 =?utf-8?B?WFFYUGVBS3NobkpUYUFJWS9VanNUOVVaVG5wUXJTanBwZjUyNjU0NDZTOWhz?=
 =?utf-8?B?SjhUN1orOGFHbU5WSStSMnByR3lKcUt1aEpxMFp0aXMzdEkwUGpmOS9PVVU4?=
 =?utf-8?B?ODBVWUxKZWloN1NBS0VPVVdjdHFxZXBUVTJmb0JBaG9sZXY2VTdZTUJQWHhl?=
 =?utf-8?B?VlN0eFBXemt3d0krbTc0VHVhVWYrU3BvcHhMOUlPbXBaNmtmRFNXWlAvWVRI?=
 =?utf-8?B?VGx3aUhBUDVScG9DM2FoSmNXWE5LOUJ1N2g4NkthaEJWRk96a0ZxYW9mbDJo?=
 =?utf-8?B?TkhjNmQ2VzJHMjdUU1M0NUpDWG9GQnF5cnZOQStqYzFMaThQOEJkVVJwc0Nn?=
 =?utf-8?B?UXNTTk5HeVA3UFdoZm41djkrNGkxaVR3bC9aQmQ4b2JGWlpmanJOS1dDZFVM?=
 =?utf-8?B?M3hsdzNGZVM0UGMya2RXUDFMeUFFTHI0ZlZhbS8zVlF3aHQrc2ZCRTdDcXdo?=
 =?utf-8?B?TW4wcXFwMEF5QVJ3VmYrRFJNQ203UnBuYXVNdU9Cd1pmTnJ2TDZDUEIrMVdQ?=
 =?utf-8?B?TENDa0ZSMHA2bHhWMHlaVjNBblRRbzdNYW13aGx2L3NBcEsza1pOOWcya1FP?=
 =?utf-8?Q?UrjZIObKSva9dXiRig6uTuLfTzcqBKMi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWFwUHFYN0h6bFNId3pLOVFTcUtLaUZLNGpXMzZIVGkyckFmWUJ3dUNRM3U3?=
 =?utf-8?B?S1hsNEIrbk5lV2ltNEkzc2NDajZ6azZkSDQzbGUzUzBkMVpJWkF5dmdWWVcz?=
 =?utf-8?B?QlJrc1VybnlrOUgremlEalBrd090T1hPMUszMTdVT2hsc01iN1REcnNnN0s0?=
 =?utf-8?B?NkgyT1htODdtZUNiVmxKQW9RNDdwM1BocWRKZi8xYW1JSkhsVE1FRWtPbzBH?=
 =?utf-8?B?ZUxKeXRGS2xiV3BPQUsrNWhKVUVSMkhjZ3hITUtjZ1pMNXJQeTBHVzVJc0d2?=
 =?utf-8?B?b29NQ1IyWlhmb2E4dHozY3dyZVJRY3E0bGxBd0JTcVc1dTRBUFpnZXFqNW04?=
 =?utf-8?B?dUkxR0hCS2ZLeHZ1TXgzclROYktwVFY2YS9QT05IRlZtd0hFL1gybGZ3M0Ns?=
 =?utf-8?B?dkxsa3haTTlNSWkwbSt6RGQrZVozSkROMHdnMU9kZHlOZ3hQSVpBYndUMnRB?=
 =?utf-8?B?UWtsZlVROGwybmpJU1g4dTFDdTJCVnpwYjBQaitrNVp3N0U3M0Y5Vy81VWI4?=
 =?utf-8?B?RVNvNlV0OHoreitoblNudldnTEY0c3hkM1VqZkREVWVibHNqNUx4eHBuczlY?=
 =?utf-8?B?c3VWbjErZjNEMnpvMkV1ckdvcXBPZjlTTi9yM1pCeUt6RnNLY0hpcHFXZURl?=
 =?utf-8?B?NUNRTXl0ZlR2UWVlUE9wRzNDSEdkQlBPSnM3UnVmdkFqLzc5VGQxa0dSaFA1?=
 =?utf-8?B?dEFrcEhYYi83MDlROGltcVVDOFlZYk03R0c4TEl5YTdGTjJRY2VmWnlRclZC?=
 =?utf-8?B?NGk4K0dVbkpHQ09VWTdLUzFOMTNPTEcwVUZ2NGdTZldXQ2xKWmdJTnA0ak92?=
 =?utf-8?B?QThtWUloQTJoY0JNS3FNV05rY2hncGJGMGNTL3lJR1B2eFVzdnhESllQWk5I?=
 =?utf-8?B?N3RJOFI1SS9VSGxESWNGa2VXc3hUQUZJd0x2eVk3WGsrT3hBQ3J0MUpZYXRs?=
 =?utf-8?B?R2VibFJLNzV6WjNBdFFFNHFiUTRFYVZIU2M5UEVSdVhXSVdsTDN4alVvL2pu?=
 =?utf-8?B?ZkwwbUJ6QVJFc0ZlU3lqS0ZrOTZpaTVrODdkbGpWRis5MWsrWEFsVTN0cmlE?=
 =?utf-8?B?OTBFRnN1Q0VUVFh5Z05Ocy9pNXhsank4RjRiVjcrcGI5WG9DMEhJYTgvaGVz?=
 =?utf-8?B?Z2lRYmQwcURqcXJlNFhXNklOZVJaODM0eDE2d0duaU45TTJzVEVMelhRZmhl?=
 =?utf-8?B?SnNJM1NpTGdGVjlXUmkwcE10RmtOaTl2eU91K1cxY3pzaERLaU54YzZNM09M?=
 =?utf-8?B?dS9helNCUTYxdy91V2hKOUo2YWFGckNtMzlsRVRIZXUwaWR5UVhudXdNWTBm?=
 =?utf-8?B?WXVzT0FZaGlvc01PTW5ydWFrYnhpbmRIZjNlQU9kdm1tb2FTemV1clVHNlY4?=
 =?utf-8?B?bk5zQWVZSlFwUXl5RlVuVzVyWDBUdWs2RjV6bDlyNmdEZVlzMVk5NjRkaEZi?=
 =?utf-8?B?OUY5TzZld3c4bmdYaVFwUEVTZ2pzZWU1Tmp0Q2gxVzN4cG1VNnpOUC9BME1u?=
 =?utf-8?B?NDZzSU1ZMzV2R3NLc01FUHFyUG52emk1alNVYnhhTStSR3N0LytjVS9KcWpK?=
 =?utf-8?B?d0JNaWtWQ3IwK2k0YjVwY0Vpa0FKVWQraW5Fdy85cFlDdHg5cHFBVUdZNXgz?=
 =?utf-8?B?MGJQRTJHbGkxTE5JdUo2NU4vbjZ1bVh1S1QxM09pWGFGUUFLQjNjb0R4elJr?=
 =?utf-8?B?eXhkcTRYcnVEQWJMdzROM3lNNzRscFRsWm45QTdJaFlKTXh5bFNWWTRzR3Z3?=
 =?utf-8?B?eGdyQ3dUY0Z3UGVxU2wxeHJUYSsvc3pTZFlTNHZVeDU4NTRyditaTXd5Vkh0?=
 =?utf-8?B?cHRhL0lLWTlmUHV1L1pEMEwyOFp3UWJhVThzOVcvOFowc2hham51czNIemJF?=
 =?utf-8?B?MHpSWmd3Vndxb3hRcXZUelFBOW5PNHdDSjRuK2lLMU9zbGNrYjNFd0NXOXBV?=
 =?utf-8?B?VFUyVzRSa1Qxbi9HdEh2NGJGM0g3NzRNUEVwbWgzbnVFSVIyV1JLYzdnaGEr?=
 =?utf-8?B?RTRFUDZydHFVaHRNb1dOaEkycmZBT3gzVVd1ZjRRWEJzVWtKKzZMZHpYYUxG?=
 =?utf-8?B?WWhLRnhvUU5yeXFmNzJpK0RMTVhxeWZIM2xybjQvbWNWZWdYN1Y0b1FkT0lm?=
 =?utf-8?Q?AiEA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ddfbc6a-b1ce-4dc3-f316-08de3c1d5c03
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 21:03:13.4296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxT/ALImLAwjjUfkjWKhBeLaBHa9krtvxf+cUqAGLhfEOJ7zAvlru1GInqUA2PRK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9226
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
> In svm_migrate_gart_map(), while migrating GART mapping, the number of
> bytes copied for the GART table only accounts for CPU pages. On non-4K
> systems, each CPU page can contain multiple GPU pages, and the GART
> requires one 8-byte PTE per GPU page. As a result, an incorrect size was
> passed to the DMA, causing only a partial update of the GART table.
>
> Fix this function to work correctly on non-4K page-size systems by
> accounting for the number of GPU pages per CPU page when calculating the
> number of bytes to be copied.
>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 59a5a3fea65d..ea8377071c39 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -62,7 +62,7 @@ svm_migrate_gart_map(struct amdgpu_ring *ring, u64 npages,
>   	*gart_addr = adev->gmc.gart_start;
>   
>   	num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
> -	num_bytes = npages * 8;
> +	num_bytes = npages * 8 * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>   
>   	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.high_pr,
>   				     AMDGPU_FENCE_OWNER_UNDEFINED,

