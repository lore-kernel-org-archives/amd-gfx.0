Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83AEC021A4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 10:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4079F10E2C9;
	Fri, 14 Feb 2025 10:31:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0p+OkUEg";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 352CA10E2C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 10:31:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iD8XCdTHTPfYEJqeLDPQD6lVHysuFdzmx/QQ8v9yIBKFmOHBKaRKr0zub0GJeYqcD8DDgFg76f8/F69WLCyeOC93y4kLH24ZxiVk6Lkr8nrOho9l/VOq6d6rdmLnGAgx55zWhMUzx4h7mCQdtb8vsk0xUExvFfaEk8FV6rKqB7A68pCIPFpPrPYw9ikHExbfaP7+Zr+2n0//4lcYYQ1NqJDHfC3MFoIarvAeuP1rGpRZ/FcT26i9e9MjgxsNgqqm/J9CCZAznwG14l/rd1W6P7xuxe1h9mxVe6BArHcAk1DeA+UeqzSIhQWTd30JL1S1cpsfFZyOOLFVnXY0mED8iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyHysDB6xDdhZvjncv12Sh0ZQ+UIIgu/g2YGliSZ9po=;
 b=g54bi3mXOQTc9i3L2C0yDYEttlkhKStoR6FaILjB9ZwbUArEYcFjRHGDQRHSHXkENsCPaIM9oa/gzS/pSi/x5MWlCzcY+HQn34l//tMj4LcoDtf+vq2mhg12mSFmHj4I39pu0bncd9WOFnpbUw75lkAOHbpFAqBEIUD0mRDCOPJa6AyWaLStWXSeToFLvPTPj4R4OOFELQttjyk6HAENd/F2OBtozlhaapB2Uk+bahMX6Srq/s20pmcJjW7FDgZJToutSa5lfX6+HiA+kyGyHNdXkQGmpxFAMepRYNbh0MPOGitWeQxE+Eqjjtq70oRA/rjDjns4DHIT6BF0uVxyPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyHysDB6xDdhZvjncv12Sh0ZQ+UIIgu/g2YGliSZ9po=;
 b=0p+OkUEgzJycizlJpuco5vHF7GB2Z5mKrbxHI5nIfR8QkA3KIcUFvBI9Z5uEcYZrLXhc6/THmOG+x+rEBqdZQi1nN0hYkVaWC5cC0VvPHFZRRUaQk8tyHPRQtKiYWWpJmeG5fO1jUgrEsTNPQAIZRZOUh5Grab6m+1qrAx0+//4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB6742.namprd12.prod.outlook.com (2603:10b6:806:26e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Fri, 14 Feb
 2025 10:31:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.8445.017; Fri, 14 Feb 2025
 10:31:35 +0000
Message-ID: <493a3f35-b5a6-401a-be78-de19cec6ef44@amd.com>
Date: Fri, 14 Feb 2025 11:31:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: Pop jobs from the queue more robustly
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org,
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20250206164031.43413-1-tvrtko.ursulin@igalia.com>
 <20250206164031.43413-3-tvrtko.ursulin@igalia.com>
 <949a5a2f-dbf3-497e-a50a-92adb48aa31f@amd.com>
 <3f6de080ac75fc0988d371e71072cba5d60e269e.camel@mailbox.org>
 <e0a3e8de-2e90-420d-86c1-844f86ebe319@amd.com>
 <19b8713f-8563-4a5b-bd05-e3d507538acd@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <19b8713f-8563-4a5b-bd05-e3d507538acd@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: 812cd0b9-0b39-46d5-bdee-08dd4ce2c180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2VpNklEcWxKc0lMejZ5NGowUDVHTGZBQ1NMMGJrT1FoVSs1M2hjMUFWd0xE?=
 =?utf-8?B?UjdjTnIybm45UFVmaXNyUXFTV0p3WkNVank2VGluVFpwb1Bmb0k3U3dBdmpr?=
 =?utf-8?B?MnVTYThYVUUyZHZyK3E0WHBwdkxINS9OZTllOUhCTEozZEp5WnJKQ0xIOG00?=
 =?utf-8?B?U0pBODVaUzhQaEVoVkhtWmkwbzljOTVCWmtlUUY1VFFrSEI2RUM1QjFLREk5?=
 =?utf-8?B?VzZveU9CV3BnaUQ2WDkrMW1uVG5uWlFpdlhwRmZFdXE1WFhzVjV2TEg2WkVV?=
 =?utf-8?B?UlFCVUQwalBDdmwrUldGczEyYUhueHAwR0FET0Nic1VFNjJDOVkrMWlnVi9r?=
 =?utf-8?B?aTNLQmM1UGFEM3hvekpvQUV4KzZzNW1UVnpDT09jYlQ2eHFrVzFIcGViUXpz?=
 =?utf-8?B?cVhCYzhvWVJLVFcyNkx0Z05zVEtSSVI4WWVkSzB4RFdKRThhbWR4b01rbnBX?=
 =?utf-8?B?UG9rOExlNktoV25PbWpNOU1ZQTR1MDlPZjlDNUZpUjB6SEM4aGdBcitoZTFn?=
 =?utf-8?B?U2M5QXRDUE01cDZqajdKQThja0dTazdmbFhPODZSTTE0TlIraGo3ZnNFQWJ0?=
 =?utf-8?B?QksvMlExdmJFalBUMXMrVEQySjdZTU1kNi9YemZIMUo5ZkIxV2NQRy93OUk0?=
 =?utf-8?B?bnZ5N2dlNzgrMjJRRzBSelRBNUxMZzY4UzBzU0RpODRhTDNjM3ExajdWWm5F?=
 =?utf-8?B?a1NsNHNaeWxBa0xSd0YwNUJJUGRpT3VaTW01QW9HMStaNTg4Y0xmWWpZVFBG?=
 =?utf-8?B?cUsySEZqVTBBcGwxTUdGZHdhNE9rYTF3bTNMMGlIL20wRExOa2hnV1FIS28v?=
 =?utf-8?B?c3BTUnJVdGNIZ0RYTTM0aGhRcU8zTUdpNlJFVUo4MGplYWdZS2JlbnpyczYr?=
 =?utf-8?B?ZEFvSlBwS1k5aHRSdHZCL1VLUExHZXVmMjAzSjFJU3Q5V0Jsa0QwUlZYMmZI?=
 =?utf-8?B?VU9HTzIxVzlNMWhaVi94NmhtQnNZRzM4MC9ZQUVpb1hvcnJCbHcrdnd2Z01s?=
 =?utf-8?B?MU43MlQ0dXdQUXVvTjJYc0RyeGxHak5nV1R4Sy9HNVFhVUxzRTVOekdWWTNz?=
 =?utf-8?B?ZWNBcjZaeUpvK1RsWVRpL0RFcGdBSHVWZ2FWWlZhRXMwUzI1Ri9XL3ZqNnp5?=
 =?utf-8?B?dm1MRUhqeG1LMVlYcFhPQ2ptaXRZRnE1UG5zanZoQVpqai9BdGhlTTlkajVL?=
 =?utf-8?B?MzhGQnZWUUttOTRmWEZOMk5rcURmRFJseVBXRFpWZUdhQjRrZy9qeGVXOHVV?=
 =?utf-8?B?NTRqL25xV0VEbG5DRG5CVHZkODI0cXBXeVl1KytNdVFwYThrVkdDejVTMUtq?=
 =?utf-8?B?Qkk4NEw4YUVtTFdsU3kreXBzdzVhUUlPV1NPek9CWnBFa04ydXdFdWU5NzZ1?=
 =?utf-8?B?TXl0aWZLYkxsQWtPUTYwcnRBTTVWSlh1NGh1anoyc09KRkhoOVI2Rmh2VlhV?=
 =?utf-8?B?MGdTRHc1cER2WTV1dEM3bnQ2M0dCVk05cytTajVvdU5kU3lsZkx4N0NSNDlj?=
 =?utf-8?B?cjgySmxYYVFXM0ZsM1NzdzJLKzdLSDM0UzhpelpyRVFobE5Id3ZQOTk5ZVJJ?=
 =?utf-8?B?SGNaUXlxZDJONDhvRTNwemZ6QTR2YTVveURCaG9IVTVaWTM1aUJENU0yUmkz?=
 =?utf-8?B?UHV0a2Y4V1lrRk8zeWxoR2UzVlF0OXk4d2s2enkzQWxIWlJMQndhUklENmxI?=
 =?utf-8?B?enpVV0RSTS82eFVDVE1KeEh6VWVyMHBTbUJILzhLdlgrTHdFUG5RVzFNdTFm?=
 =?utf-8?B?TFNkcm9KTFpwMXV0aUlIeUMwckRiMmw3RG9RUjVITVVCOGFyY0tpQWV5VGw1?=
 =?utf-8?B?aWdtaEhYREpOOE5DeitWY3pVdFMxc3cvRS9SYU8wK3liQ1NZL2dxSkxjdjd0?=
 =?utf-8?Q?EGerlrHoo9zR0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THJUb2ErcXE3ZUFJVEdJYUtXMkdYUVJ3SVE1MlJxYlVYVCtqR0VNUnBCVDkw?=
 =?utf-8?B?NGVMTXdDVnYweXNTNVNLVVlVZ3FFQXllM0cvUVVUVmpjRnZzKy9BaVE0Wkxa?=
 =?utf-8?B?ZGJBZzM5UTlMbktSV0p3QVc3dXlaR1BMd2Z1ZGRRb3I4dHlzUGdnSXFwSXVN?=
 =?utf-8?B?OVI5Y2JLN3hwQ2V2elphWlQ5TnFWangwaHhFRnBLRkdmNEJEZW14UEs4K2RO?=
 =?utf-8?B?bnpGTytwc3RGSFdVeUF3WHlFNzl1S21zVmYvdnBIVFFoZG9NY3FTWWVsQWFw?=
 =?utf-8?B?WFpHRFgyVW9UbXI5NGlYOVc2Nlh4R0xoYm9YTWJZNXhMbDZMNlJpY2pvWXBW?=
 =?utf-8?B?d25veW1JRFNjVHRQVkt6Rklpa0VOZTVveVpJMllQN1RJbDNleGxqMmRneHUv?=
 =?utf-8?B?Y1ZoY2ZicXNsSHNyeFpiR0pOdEhBcXYrbkI4MTJ4YlNMSC9COEZnU3F1TTc3?=
 =?utf-8?B?SS9CVjNpQlJMdjBsWEFsUHArWisrOCsrbkQ5NCtwZFp6clVkZGlXUENPZFE3?=
 =?utf-8?B?cHJ1MUZhOTcweW9wT2FGQUVsalF5aVJWRUNTTitObE42NCtoVlR2S05ETzds?=
 =?utf-8?B?d21iVjJZd1hiL3E4dTNPc01LR2srTVc3eHpYZG1vc21MVk1jOG5vR0pPSzRw?=
 =?utf-8?B?MGxXcnF1Tk9nNFVZU0kzS3ZCUkFSa0R0cEIrNU5DVEc0Vmo5LzNkOExvVFNz?=
 =?utf-8?B?cVdLdFhodEpqQW5Sa1c0T09xYzZrUndTZnJkUE5sWU9CYjlIc0xYM2d0UUNv?=
 =?utf-8?B?d0VyajZ6TnN0K1BXU3ZVdnYrT3F1ZFlZL2dudHRob0tPQlZ3TTNnUExoejhu?=
 =?utf-8?B?aVdqdVI4YlJWcmFUU3ZJelZUMkQ1OWJCYjQ5blNDSDg4TFpwbmJoRWdvd2h6?=
 =?utf-8?B?UXhJYmRjdk1LRjhsa29DNVhlN2pPVWpabG5wcHNTMy80L29Hc0lyM2pYbUhr?=
 =?utf-8?B?T1JqZ1FOVEovUTNuaFBaaHdxZklXWGdCcnN3NVI4a0lqa3JJMldhdjg0ak4w?=
 =?utf-8?B?bVF5ZW1QRHJnY0l4cisySWVia0ZBbDkwOHNieTYwRWNTdkd4TlNiNHk1UFdj?=
 =?utf-8?B?L1dsYVRGVkdFb2pkMFJmcmZ0MVRxQmJpZ05nZjJ5RENTUCtZNC8zNTBEWGpV?=
 =?utf-8?B?R0tDaUp0dE5nV3ZneUJlSlNCRFNTeUlzeGFTMkxCcEpTTTluZ3l6TFk1YjE3?=
 =?utf-8?B?bmxqYnMrdnJxOGFXb1NaSlJ3L3I2aXhrVUZQNlc4V1VvNFFiekttSUk0RnIz?=
 =?utf-8?B?MndGM0sralZJV1RON1ltYW0weUhlcEhLeFlLRmkvSkJWcVRNcE1IblNnMXJW?=
 =?utf-8?B?enVlMHhaSW82RFdxZktvUmx1QlBPMVU4eE8yeE1USi9tVStnZU5seHpOdGZJ?=
 =?utf-8?B?cXNhbFFITGlseHBJaGJQNzhDRnBkei96ZjZPUnFaK2pyL29OVjUzTFNzL1ll?=
 =?utf-8?B?TWlhd0dlU1lqclpYd3IwRStFTnh6aTZkVytXMjB0VUx5UzU5ckRkM3ZrZWov?=
 =?utf-8?B?dFV4bkcyVUFEWEsrUldZWGxVTjhteDdLRXhsMzVLOVFBL0RIODJDajJmUVZi?=
 =?utf-8?B?d09NRDZ0eFpuNmFyYloyekJLdzUvcncrUG56ZmhpTjRrSkRZSUlqZ3dQZTN4?=
 =?utf-8?B?Y2MzQnVBMjZ3RW1yYlVNMHIra1dqNyt4d3RVOFNHcys5WnZ0MWxzSzY1eUZy?=
 =?utf-8?B?VDcvMTlUZXRlYkEwRE5BbmwwSk5RNGp1bVZiRUpwNnZROTVGaVBLTW1WeGlv?=
 =?utf-8?B?SVdicW1JRDNEQnNreEFid0RacytUL0JUVDE5MVVaRXhkT1cwNHdFYmg5UUsy?=
 =?utf-8?B?UWlvN1ZZSHoyVWh3WngxSnNXZVJjd3VJZ0E1YlNvODJxNmVJOVd1MWpIQ2Ey?=
 =?utf-8?B?ZUtlSEVYYkg4SERDdmFnUStRbm80ZXAxd2hKai9HTVo0QUJJV0xWenRXNGZt?=
 =?utf-8?B?Uy90Q0FVRGtTYWlscmlaTFpjcUtmb2Y4NEtSaVVzdlBreHR0d083T3o4ZG9D?=
 =?utf-8?B?a1lqRFlMcHFkeG1DUUUxZXpnM0hOOUlRckNHQnliUm5IMDlmUmlDZ3dleUs5?=
 =?utf-8?B?TnhhK3RIS2thOXlIWE9OTU02YnFCL1JXOGJVZllmMXQ1L29XT2tNc3JxWE5B?=
 =?utf-8?Q?1T8uETOvBfAjBTxiHYyJfcDWE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812cd0b9-0b39-46d5-bdee-08dd4ce2c180
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 10:31:35.0283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQIt6Web+R2x+xDlstq1T8TV0pbukg5FrnDWKb02d1783435AMOF1AOs1LO8E0DS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6742
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

Am 14.02.25 um 11:21 schrieb Tvrtko Ursulin:
>
> Hi Christian,
>
> On 11/02/2025 10:21, Christian König wrote:
>> Am 11.02.25 um 11:08 schrieb Philipp Stanner:
>>> On Tue, 2025-02-11 at 09:22 +0100, Christian König wrote:
>>>> Am 06.02.25 um 17:40 schrieb Tvrtko Ursulin:
>>>>> Replace a copy of DRM scheduler's to_drm_sched_job with a copy of a
>>>>> newly
>>>>> added __drm_sched_entity_queue_pop.
>>>>>
>>>>> This allows breaking the hidden dependency that queue_node has to
>>>>> be the
>>>>> first element in struct drm_sched_job.
>>>>>
>>>>> A comment is also added with a reference to the mailing list
>>>>> discussion
>>>>> explaining the copied helper will be removed when the whole broken
>>>>> amdgpu_job_stop_all_jobs_on_sched is removed.
>>>>>
>>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>> Cc: Philipp Stanner <phasta@kernel.org>
>>>>> Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
>>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>> I think this v3 has been supplanted by a v4 by now.
>>
>> I've seen the larger v4 series as well, but at least that patch here looks identical on first glance. So my rb still counts.
>
> Is it okay for you to merge the whole series (including this single amdgpu patch) via drm-misc?

I can do that, but don't want the scheduler maintainer want to pick them up?

Regards,
Christian.

>
> Regards,
>
> Tvrtko
>
>>> @Tvrtko: btw, do you create patches with
>>> git format-patch -v4 ?
>>>
>>> That way the v4 label will be included in all patch titles, too, not
>>> just the cover letter. That makes searching etc. easier in large
>>> inboxes
>>>
>>> P.
>>>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 22 +++++++++++++++++++-
>>>>> -- 
>>>>>    1 file changed, 19 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>> index 100f04475943..22cb48bab24d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>> @@ -411,8 +411,24 @@ static struct dma_fence *amdgpu_job_run(struct
>>>>> drm_sched_job *sched_job)
>>>>>        return fence;
>>>>>    }
>>>>> -#define to_drm_sched_job(sched_job)        \
>>>>> -        container_of((sched_job), struct drm_sched_job,
>>>>> queue_node)
>>>>> +/*
>>>>> + * This is a duplicate function from DRM scheduler
>>>>> sched_internal.h.
>>>>> + * Plan is to remove it when amdgpu_job_stop_all_jobs_on_sched is
>>>>> removed, due
>>>>> + * latter being incorrect and racy.
>>>>> + *
>>>>> + * See
>>>>> https://lore.kernel.org/amd-gfx/44edde63-7181-44fb- a4f7-94e50514f539@amd.com/
>>>>> + */
>>>>> +static struct drm_sched_job *
>>>>> +__drm_sched_entity_queue_pop(struct drm_sched_entity *entity)
>>>>> +{
>>>>> +    struct spsc_node *node;
>>>>> +
>>>>> +    node = spsc_queue_pop(&entity->job_queue);
>>>>> +    if (!node)
>>>>> +        return NULL;
>>>>> +
>>>>> +    return container_of(node, struct drm_sched_job,
>>>>> queue_node);
>>>>> +}
>>>>>    void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler
>>>>> *sched)
>>>>>    {
>>>>> @@ -425,7 +441,7 @@ void amdgpu_job_stop_all_jobs_on_sched(struct
>>>>> drm_gpu_scheduler *sched)
>>>>>            struct drm_sched_rq *rq = sched->sched_rq[i];
>>>>>            spin_lock(&rq->lock);
>>>>>            list_for_each_entry(s_entity, &rq->entities, list)
>>>>> {
>>>>> -            while ((s_job =
>>>>> to_drm_sched_job(spsc_queue_pop(&s_entity->job_queue)))) {
>>>>> +            while ((s_job =
>>>>> __drm_sched_entity_queue_pop(s_entity))) {
>>>>>                    struct drm_sched_fence *s_fence =
>>>>> s_job->s_fence;
>>>>>                    dma_fence_signal(&s_fence-
>>>>>> scheduled);
>>
>

