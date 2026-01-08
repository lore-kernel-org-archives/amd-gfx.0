Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2861AD185E9
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 12:31:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA6AF10E33B;
	Thu,  8 Jan 2026 12:31:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ENlj2Yuq";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5089F10E33B
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 12:31:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRUgvzNPYKfrNmammzHgYfZ4dfjRRQsZlNHZR3ljRAb9VhFjHAeJp3xzBcKX5vYXxckM7Z0he2M48BhUp2RU9IZ2x7DwcvtzqkOmK/Y9mi697I1jYqrQPyDnTp5OwrGz0XIhIramMgob20D7JtYNYB4p1u7RfU+Na7tjlDTV4r6NWj4vlUXtVp7en6ruEgXrWOHsVMahRVIQ2fdQjfcd6bI//Bv/mnQdk2Xx0GiTB8V8EDDQ7YeAXQ1u0mz9/7RBC0+UOOmkxnazH6U4B6EfczVG/CTVMUwmTfdo99IQkWS/vZLdPcyQBER5obzRMRkNYc/N/HH2IzTDE2BIXgYkuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77hyS31ZMTwD7E2T9uQ6LXOKm+0rhCKBiiyc0qv9EUc=;
 b=pwwC7aVfALNkWrZK43W9GszFTE8qBK5Dt7wKpzcCtkNLBzmlQvJQ84RRMuQPjo5duY/NbnlSBwfPyHFciOB4/P2Uh5IGjUvM9CEasaMJeIU9FJHoIntJxtmTZXHA38CvHpFCiGQBEnJIPFXVHPhCYzCVMWap0OhsEx01Cz37kSk1VLGOA4ZCEQEmBL9weXLkjnI7B3E9KIAeh6xaOIuyq96aBisMBaT0HKmE182KU2hHCmij5nZlaRWX19AUwAS+YCRTeua6XV7+jUwnymcetkNc74AHiUtjxjycqVOSlKFf9j6YpULT3YRDcOWFPQpiItCgHxBQN+UKuexa3+hYyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77hyS31ZMTwD7E2T9uQ6LXOKm+0rhCKBiiyc0qv9EUc=;
 b=ENlj2Yuq2eGJRe0/M7FyANeE0+3HCLAcp5AM/MXbQvSRfP9UXKVZoOq8Q8kd0t2W8/jfU61goFwanee0t+AjT4iprdNaAr6DoN1Bf334zPtWu6rFsC7N1/QEZ8QMMll07psTZRK0X02TRFWsAzCBjbRMrPoQug+jMCiV2iQMLlg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Thu, 8 Jan
 2026 12:31:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 12:31:35 +0000
Message-ID: <430ac9a5-8665-4f0a-a658-5266668bc846@amd.com>
Date: Thu, 8 Jan 2026 13:31:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 4/8] amdgpu/amdgpu_ttm: Fix
 AMDGPU_GTT_MAX_TRANSFER_SIZE for non-4K page size
To: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Philip Yang <yangp@amd.com>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
Cc: Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
 <465b106ddc1ff0d661f0f3db0eb9a9d092097825.1765519875.git.donettom@linux.ibm.com>
 <277c65ad-a3c3-4d99-a0f4-a6ca99e61ab4@amd.com>
 <c28b117f-b3bb-42de-a1fb-a4dceccfbb72@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <c28b117f-b3bb-42de-a1fb-a4dceccfbb72@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR04CA0182.namprd04.prod.outlook.com
 (2603:10b6:408:e9::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: c02def20-7ea6-4278-237e-08de4eb1dc7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTBXbUxiUUxYdnArS3ZjYlpXQUNENUh0ZW1Vd1ZySldtQ3VVOUV1b1V1bk5T?=
 =?utf-8?B?V3ZrVGZuMWZNVTRZbjlDam1IQVpCamNjdmVteVFidnV6MkhBUEYxc1FQakZD?=
 =?utf-8?B?UkxFanc3RFQ4eGljVWMzSVFEZVlGNHhNQ1A2czBaV3dxM0xYSEZKc0o2TXdH?=
 =?utf-8?B?K2duOHg5OXhWM1Vrd2JmQTFrUmNQcXF2WTY5RUJoT2FWTHNwNnBXRElZQkt3?=
 =?utf-8?B?aWR1dk1aQmN5SVI5NlZieXRyZlNqWGMzb0UyeHpwU1d1UVdqQmRaWTBGWHdt?=
 =?utf-8?B?T2EvWHRyQk1QZ3crR2FjK1lVRDNESkt2amFtd3VoVFJkbkRaZExIQXo4YlR3?=
 =?utf-8?B?b1hONC9HSlh4MWlUcUlKZlRaL0RxNVdKaHN4eEllZm9CMG1iSVA3bzlrdFQy?=
 =?utf-8?B?UVpWR01WWSt6L3RuTStac2NzY2RoNS9nY1ZzWDE2Slo1TENMNnZxRVBVMzZM?=
 =?utf-8?B?dk04RXdKREhON2t0WUp2MGZ1SGtWSlZBeis2R2lUb1Z6Y1NHZkFOdWNTaVA5?=
 =?utf-8?B?T1RNMHRBRFlVd1AwckpTMWhxWG9WbkE1NlZLQk5iK2F6aHpaalRtNmxpdXJV?=
 =?utf-8?B?SXNrWkVzNFZ5eGRsbnJwR0lrdEp4U3NxZnRPVUw3aENON1dTUjUyQkFWVDhX?=
 =?utf-8?B?b1lFY2lTUmZPYlI3djM5Qy85WWxyUUxFNFFEdC9iVUlzNFdmVVNRc1o2VTVh?=
 =?utf-8?B?Y0c3bmRjKzQxaGc0VzJXTzg2b1M2ZVBjQlBKUWZidDhQODg3MmdRV09Mczdi?=
 =?utf-8?B?NW91QkNURnpYbEExeHpMaUw2ZHp5eGtnWXFHTnFybmx3VjBOd2Y1MFlGWS9j?=
 =?utf-8?B?eTZQdVo0MnAvNFFqUXhpalVZVkFIMlBrcHhtRzh3RzRoS1cwSTdMZE9qa2tO?=
 =?utf-8?B?b1IrODE0Qk1nV3Q3MWZVeldUV3VRTkxOTGxaMys2YnE4OC9wamt5YW8vTmZB?=
 =?utf-8?B?RG5LVC94RUlid0tIOTNlMEdZYTl6UzA2YncvRDZpcVAwOFJ3a1p6V0R1M01i?=
 =?utf-8?B?MGZEazJnNXlGdWhtR053OGpuOC9Na1o3L08zKzlKbVZwL0JGTHpRL2NDRCtU?=
 =?utf-8?B?Q1BOYTBFV3cvSVNtMWd0MmFsbDdaR2lxMkJLRi9JTXdFVXJCQ3JmMXI0cyt2?=
 =?utf-8?B?Nm56eHc0MmcrcS9sNnNSN1JKbUttcU1GcmREVkRWdm5YM0dUWHJMOUVSTzU1?=
 =?utf-8?B?RXZsZUJiYmp6NXN3TWpGV3U4TUhhMHZjVEt6bGIwN2ZUWVNrTGpINldHcnVo?=
 =?utf-8?B?SXJhazRwNGw3Vjh3dVJvTGZQeFFHMnltaUNwWlFERGlFNEd4VUY5c2RjZWxT?=
 =?utf-8?B?R0xwa1lwK0hHQW10YS84Y1pSMGxTdGdDK0ZBQXZmTWNRa3NOaVViZUVSQnhl?=
 =?utf-8?B?RjdUYnFwYWRGaklZSXRpTGx5cmR5LzI2U0IyaTU3amNyQVFzMnNtYUF0VGZG?=
 =?utf-8?B?bkZnYVZielQxd3VLcGRmaWF2aCs0Q2dzRGh5dG5DdUhiQ2FtY2RqL1ppQ0xB?=
 =?utf-8?B?aEFXK1pnbUZJdmFiLzIyVElrSkR3Y3R2STR5U3hGeE9UTUlmQjRVQ2M0cVNl?=
 =?utf-8?B?OXNGVFNEZU9iNXhDR3lPUVB0aWE0NW9mUkRxNE1mWnp5U2NWeC9TR0pzMklH?=
 =?utf-8?B?RERQaUs1NDlkYmRNY2NNbkJiZExRTE00RUNrdHJvMTRSNVJzVTI0T281ZXh2?=
 =?utf-8?B?blZraGgwRkJzL3dCMDV1UjdtNWtaVHBoUHZXQVhyVTdyeXRYNnNYaUVKeUcx?=
 =?utf-8?B?R1MwcWlBb0RudWpoZlJmdDBSZEcxaEp5cGdEWTM3Ynd5N3g4VWt2RXhtd0FK?=
 =?utf-8?B?SFdXNmV0Vlk0NEFsRUpQZUNzTG1sTEUzcVJ1UExDTmNxR09vZlN3RHVEYm1Q?=
 =?utf-8?B?c01qWVdZMldiaE1FRkFvaTlNY25vb012M2hnS0UvdnhCTkRNY0kvVzdZcThN?=
 =?utf-8?Q?mWRwjAJW13BVRLDLy0Z1ebfzNmOFTx8s?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTdKaU9LSDdYbW9pSUNRL3hDMWs1WGZKUUNsNlRXZlJ4cjRiRXo3TTJoK2ZX?=
 =?utf-8?B?cFZuT1NXaUdJdHNkTHUrd1FMT0ZpZVRKMUMrbmNFcjVFUTlyS2JnT0twUk8z?=
 =?utf-8?B?ZEQ5RVNTR3VhUzl5VHNDTzQ4NW56Mmg5eTFFdzRCMkhhYXZuZFBKR1VuUnEy?=
 =?utf-8?B?NWtPZFUyUzRkRlYvWEE5dFdVN0ZiTEJ1VUk5bEN0YkV3SzN5MGEwWnVVOHdi?=
 =?utf-8?B?VVlPeStNNFFCMUlYZXYyUTJZZ3dibVhGNjMvOUIvT3dOSGlQbE55Z2lJaGxa?=
 =?utf-8?B?am8yOHVTdnhuNm56aGthdFRMQjNwUnd0VHV3a2FlS3Bva0gydEs3a0tqbFlm?=
 =?utf-8?B?MERsTUMyVnVTMVYzLzZFOHViU2psWW51MzVseS9ZMGx3bmlhMEttRXAyUHcz?=
 =?utf-8?B?OFRBMEl2TkVxRm9jMHlCRnpTVFcvaWVIQzRkaTh2a3JTUFVnOTFDZHVLaGw3?=
 =?utf-8?B?NkxqTSthYVU3QklSeHVxTFNTYzNOcjhmRzBwWGtQaXd3MDZ1ZmZaOTJsdTR3?=
 =?utf-8?B?MG5oUXFIKzdBUzJyTUJaTUxkUWJ2VEh3dEJoTnU1L2JYWnVlbjlMWWlxQ2tD?=
 =?utf-8?B?RTFWUStRWEhhUmtZNHM2Y1dZYklGQWR1QW9iT3hudncraUpxYVJpYnpuaCty?=
 =?utf-8?B?Uy94VXBVRWZWM3c0ZTJQOEpYY0lpNkZpNzgxeEVHYXo4SFNtMXVyQWFML3A1?=
 =?utf-8?B?NkJiazUwL1BZU1Y5eTRhMUl1UithZ3RNNVF0RWJjSzNhMmdLd0x4YnNPR1F2?=
 =?utf-8?B?ZFh0djJ1djNQWGQ0MW5ydm9FV2p1TnJLTEdXRjJKd3Jlc09pa0xoUVF4VjZ0?=
 =?utf-8?B?cXAraDc1Ujc4M1A0RU92ZmZPY0J6ZjcxTXNmWWdVeHlyN3RBSFpGOXJoekVT?=
 =?utf-8?B?NGtLQTBTa0xxVllFMHVHN1JlWnhqdlFTSmtTbXpUaWFmQ1NtK0MrZ2VwcFdl?=
 =?utf-8?B?a3FRTEl2NUtIR0RkMmM4aEQ2RWJrN000ZHlNV0FhWHpDYytlLzM3SkM3V2dE?=
 =?utf-8?B?WDV1OUV6V1o5SUdZblZhOTdhUnR4aVRFRFhaYXBIZXNKYy94UGVPaVVoUkFJ?=
 =?utf-8?B?VUhEYkhGWHFFY3JRU3MrbTgyM25oVUlLT1krSGNEVW0xb1lPak5qT1Q1TUFu?=
 =?utf-8?B?UE92MHNkT0tkK0Y3aFU5N3MxbGxEVXR0UjBLUTI0RDBsekd6d2QvWkFMeXR3?=
 =?utf-8?B?ajBUYXFSNXkwRTdaYTJWSkFKQno5S2lMSFFYbklqTDFiM05ObVg1bnFyRmhL?=
 =?utf-8?B?WDVJeFdsT1MzNlhqeVZ2d2ZabzRuekJVR2s1NFkrTHBjUFBIWTJzd3c2T050?=
 =?utf-8?B?c2ZKOXk0UnVucUZud1AwcDQxYXBXaWRjenFLTHMvWURRSldyMVpleXRoOHQz?=
 =?utf-8?B?Mm9VT21DcSthM0pOTENHNzhYUVlRejZ0UW83Q1NkdG5kR294eWJmYUdzcTR6?=
 =?utf-8?B?UHNaYm80ZFFYUHF6L203RkhzRStvZUMzNXVVV2JDMEc5TXZGS3JPTi9FblRq?=
 =?utf-8?B?Qk1DL2YvTjk4WTdpYWdpQmtGYUJFQ3lWOEorVXVvWGxETEdQS1JjZVFUQ2I1?=
 =?utf-8?B?d2FzWGJvalBnQ2N3M0EzUnd2SVZ2c2pWYTV4KzFBTkEzL2tva0FvNmk2a21v?=
 =?utf-8?B?S1VmVEJKMFo2WTVyTkFBVEZIVXFBdXpFdUhNVVNmbHpLMjRTY0VqV2R2ZjM1?=
 =?utf-8?B?aFpTTWV3eFk0WUFzWUJESnhpM2xDeEF3NXlrVUpWb2Q0dFVPaitNaFpPbklV?=
 =?utf-8?B?dnZjZkI1dWRGVW1yZ1ptUjhRNjZhTGltN1RqSnVTUHNtamZaWS9mWGcxQW1G?=
 =?utf-8?B?dTZ3bEc4UVBHVnFXYjJzQ3VqZTRrUDR4L2Y4OHkyUmkvWXgxYTRaN2ZUeitk?=
 =?utf-8?B?THZoSGw0bmpTdU9iZlVwT0xUa1cvSUpvMkhsM09QKy9FMjhoYlE0VGRLWk5D?=
 =?utf-8?B?R25wdDJrMzFoWW5SelNRaUxETzJKY2t5WGoveDQ4SE51dFlrbFNGTmxzNUt3?=
 =?utf-8?B?VUpFWFZtbHgwZDhDcWtLNWVoTzRReEx4QXRpVk9NdmZLTlZrZ0ZKUjVPVlFQ?=
 =?utf-8?B?VmtGZG9jODU1UmtBU3FlTWFtZjZRdnRwV0Nabk1xV0ZoNW5RTGwrV2pzcGor?=
 =?utf-8?B?SXFoTlhlQkU4TVVtWVNLTE8rczZSUkk2cko2cHFVdG9Tcm5zNXdhZWNmMzR1?=
 =?utf-8?B?Y0swQldqTC9vK1VTZ1l1OXdTMGhyMUdUL3VwS29TSUhoUGp4UjNiUTZORmFs?=
 =?utf-8?B?YmZUdlpjS3d2TDVidTEzeWFSa3ZKT2xtb1lHR2l4SEl2SE15Z0pvajNxKzhF?=
 =?utf-8?Q?sX8kX35seZWBmm2jjB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c02def20-7ea6-4278-237e-08de4eb1dc7f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 12:31:35.0649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZYYTopMCmC0WVzNsgPEMNDENQZ4or4SBbJBK/9uQZ4lf4ou/pRiz+ZmkS8OeC3i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775
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

On 1/6/26 13:55, Donet Tom wrote:
> 
> On 12/12/25 2:23 PM, Christian König wrote:
>> On 12/12/25 07:40, Donet Tom wrote:
>>> The SDMA engine has a hardware limitation of 4 MB maximum transfer
>>> size per operation.
>> That is not correct. This is only true on ancient HW.
>>
>> What problems are you seeing here?
>>
>>> AMDGPU_GTT_MAX_TRANSFER_SIZE was hardcoded to
>>> 512 pages, which worked correctly on systems with 4K pages but fails
>>> on systems with larger page sizes.
>>>
>>> This patch divides the max transfer size / AMDGPU_GPU_PAGES_IN_CPU_PAGE
>>> to match with non-4K page size systems.
>> That is actually a bad idea. The value was meant to match the PMD size.
> 
> 
> Hi Christian, Felix, Alex and philip
> 
> Instead of hardcoding the AMDGPU_GTT_MAX_TRANSFER_SIZE value to 512,
> what do you think about doing something like the change below?
> This should work across all architectures and page sizes, so
> AMDGPU_GTT_MAX_TRANSFER_SIZE will always correspond to the PMD
> size on all architectures and with all page sizes.
> 
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 0be2728aa872..c594ed7dff18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -37,7 +37,7 @@
>  #define AMDGPU_PL_MMIO_REMAP   (TTM_PL_PRIV + 5)
>  #define __AMDGPU_PL_NUM        (TTM_PL_PRIV + 6)
>  
> -#define AMDGPU_GTT_MAX_TRANSFER_SIZE   512
> +#define AMDGPU_GTT_MAX_TRANSFER_SIZE   1 << (PMD_SHIFT - PAGE_SHIFT)
>  #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS  
> 
> Could you please provide your thoughts on above? Is it looking ok to you?

It's at least reasonable. My only concern is that we have patches in the pipeline to remove that define and make it independent of the PMD size.

@Pierre-Eric how far along are we with that?

> 
> If this looks good - here is what we were thinking:
> 
> Patches 1-4 are required to fix initial non-4k pagesize support to AMD GPU.
> And since these patches are looking in good shape (since Philip has already
> reviewed [1-3])- We thought it will be good to split the patch series into two.
> I will send a v2 of Part-1 with patches [1-4] (will also address the review comments
> in v2 for Patch-1 & 2 from Philip) and for the rest of the patches [5-8] Part-2, we
> can continue the discussion till other things are sorted. That will also allow us to
> get these initial fixes in Part-1 ready before the 6.20 merge window. 
> 
> Thoughts?

Sounds reasonable to me.

Regards,
Christian.

> 
> 
>> Regards,
>> Christian.
>>
>>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> index 0be2728aa872..9d038feb25b0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> @@ -37,7 +37,7 @@
>>>  #define AMDGPU_PL_MMIO_REMAP	(TTM_PL_PRIV + 5)
>>>  #define __AMDGPU_PL_NUM	(TTM_PL_PRIV + 6)
>>>  
>>> -#define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
>>> +#define AMDGPU_GTT_MAX_TRANSFER_SIZE	(512 / AMDGPU_GPU_PAGES_IN_CPU_PAGE)
>>>  #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
>>>  
>>>  extern const struct attribute_group amdgpu_vram_mgr_attr_group;

