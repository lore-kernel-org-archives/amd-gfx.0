Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750C1C021B1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 09:51:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FF4410E4BC;
	Thu, 20 Feb 2025 09:51:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P4VDMRBE";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0706F10E4BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 09:51:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJZB3BzHgny5mKGarrdt3jXhRTLP4fhnOh7VPA6VfKEvWJud8PpCIK6tGaMKnD56mfz98Yp2hFXdo4CxK812F7HUnHLdSLEPNXxUdea4g7dn/MuCLNszYYsZAt2oaZ0APpf9xgKysk98I9eCBjcANR/pXzrc2KLjMUNt0gZKXxxbbCE45n81vSX3grsZCoOdil0XYQPpr8xub17Ydh0KGcS7CHmZlwK7PwS1NtxlMYOdkF5OguOIvhPe9AxCmZykyaTYK4oeLH5dO/LQpos6IEpNtODz63UwkTQHNZwFd1Gw7GUzuWC7VPC7Z9BuTBU2JLxhRWMKNEfAUCAogcDtqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9uvuQ+UWJIdB/YwwlsPYDb3u+rH3jE382G5jHjg1DE=;
 b=sB2Ai3NlidBq1IfH2nlx2ZScSMLUtOsOyC/ia+wTjegC3e9HQr1ygMg8h5M4REr21DOwBLIJ4FP5vbc5TcKTY1oivDULw/ML4uVb7bl6s1uw6RtngK9djpovAZcJR+BO0A+YHMDBHg4LT2TDuHmz4Ue3KrHjg+VPDcC/Mwo8Z51n0uycgT6SpA6+xSOdPGhWOQruH1KAs5TyyPciWr07wlzIGdpegAv2W4BsKFrGH8EWkOZS6MgC8wFU5/q7/s8ThE8AvAiFvs1MyXRjrS0g2ApNVEGisxTtN1gxMMmir63tb2TBdVP4IJttBP8rOGo1ta3sNvbB4kmAdpEI8ovE4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9uvuQ+UWJIdB/YwwlsPYDb3u+rH3jE382G5jHjg1DE=;
 b=P4VDMRBEk5uUqvYQvgQNDn7+qFy9ciFz/+FgnGZvm2LQOmfsLXp8uKMcDoYLoUsYZm3xJLBoDo23BUKAIXs2fiGtsk4d3+Xb1m8IdLuxJzNu3zzczKJ6FBpjJ5XalHz4wkm3glvmOrL/YBQ/D5A8O8ZFgWHcNzX5ueCWLCCkqLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 09:51:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 09:51:49 +0000
Message-ID: <18614773-70dc-49ca-b475-e903e23b8c40@amd.com>
Date: Thu, 20 Feb 2025 10:51:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Optimize VM invalidation engine
 allocation and synchronize GPU TLB flush
To: "Lazar, Lijo" <lijo.lazar@amd.com>, jesse.zhang@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Jiadong Zhu <Jiadong.Zhu@amd.com>
References: <20250219090509.3559015-1-jesse.zhang@amd.com>
 <ebab1f3e-2f87-49e8-9801-6477febc09ba@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <ebab1f3e-2f87-49e8-9801-6477febc09ba@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB4495:EE_
X-MS-Office365-Filtering-Correlation-Id: aa9464d9-34a2-470f-4a7b-08dd5194320a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzU5dzh3QzZLdm5raHJxMTZmWW9PZEdDSndFMkRPb09Rd05JQytTR24rcFJU?=
 =?utf-8?B?ZGZDdEVGcFpKbjFQajRmQTkrdFB2SjlzRzhjdGVBc2VFN1MvMFFFL1JYNEdY?=
 =?utf-8?B?MVd0Sm1US0J0L21MNkxoc28vV09icWZlMkoxZE5PNXFOem5oNkdXZGkxdkdw?=
 =?utf-8?B?RldjQmJmK2VBUndhRmsxYkJhb2hycjdoOHB3L2tQNng1U0pyTkN1R3RvcWVP?=
 =?utf-8?B?a3kwaC9WYy9oaUhtMkRXbTlla1hRc3RtSzFYU2pxZlIzSUhDSW9hdTB2QlVH?=
 =?utf-8?B?dGxDQlpqa1pTbXdmVndqaW9vQlJseHppc3ZJeGx6VkhkYmhHcmFBanl6bkxn?=
 =?utf-8?B?ejQrNDg3SWptWE43UnpEZWZtQnRDT3F0ampjVDFnQzRDNTlsdHZNRUswcjJz?=
 =?utf-8?B?SWJOL3NhdDR0aVhLRzhzUzlHZVZuVFdhbDhCVDRuUGNQWnpwcW4zd2ZOdHE3?=
 =?utf-8?B?WWFENTZWbGpycGJFVkZqanpqTmxFMHgwNGZWOXlsMHFPSUdmTVk0QSs3aHhT?=
 =?utf-8?B?R05FNjRVVlp3aHdwazhaRlBTZTNGUnpjWmlLY01PU05YelFRNzhnZ2U2Sjcz?=
 =?utf-8?B?YzV6U2VmMklkV0JZN0VIcTM0S2VWQkowZHIyNmNwSzhUMWlXSUZFWGdsdzVy?=
 =?utf-8?B?RldHb2Y2SWxYWTRpcGc5dEpFLyswOXFZNG1mS05zZEMyYUtOQWYwamZVSkNY?=
 =?utf-8?B?cGVaVzlvQm1lVGkyWmZKWEN2SEVMenBwY3RXV0p5bGcvNWhML3BHYllPMDNW?=
 =?utf-8?B?cTdnWHBMNjkvdEFIUDJVcHBibjl2bnMyUDRja3doNzVrRHgvNVdWeVc1S0s2?=
 =?utf-8?B?Ri9yYkxvYzV5eXNEMjNSckwyd0JHb01wbk9LRlpXMEUyMENRRHhxV25iUk5a?=
 =?utf-8?B?cjhiU0NMQzZSWC9LUnhIWnh6cS9TZEZCVGpSSkRtTEUwQnNGL1ZmSzV4OUlX?=
 =?utf-8?B?aERJSXZReDFkNy9FOE1SVVplQ1E2aURQajdoU3NKc1RpemtVaUdtTnp2VFdP?=
 =?utf-8?B?N3BQQ25qRUxOTExWait2alVDcjN3K3dteE0xS1JaM0VNbjBuc1IxMk0xZkNs?=
 =?utf-8?B?Si9Mckk2VGhzVE5YZjNRVHZ1MjVVQXppQ1E4QjYxMkR0MlNkTldvM0lzNndj?=
 =?utf-8?B?a1FndU40Vko2ZzRuTWlZOVZzcS9qNGJVdG82Q2RSOVJaWlE0NGtuQjcvemlD?=
 =?utf-8?B?T1pnSUNlQ3E4eXFNaStySE9OampIQXNZRjFFNjNNbzUvTGwyTGlhNEtSQ1o5?=
 =?utf-8?B?by82T3FEQ3ZQRkVRZkNLRC95eUlkRVpIK3RhTGVqTUh0WkNleFAzTmoxL2RC?=
 =?utf-8?B?V28vV2V0Ty9qeDVCUjRHTVowU3lWSjhQUHBYUEZwUzZ5Y0gwLzkrNjE2UGlL?=
 =?utf-8?B?bEVLcktWN0tudk5icWtpc0tTRUxZMUZmZTljTllKZkc1S2pDbURlOU0zbytq?=
 =?utf-8?B?WmI3ZnlWWndjSXlRRDhtLzNsQVNDNHhDQ1paM3ZHUmJPTHZjaFBBZnE3aVdQ?=
 =?utf-8?B?NjkrK3l4MmFsaVNudmNqSWNQc0pKLzJVVVpFc2JMVURUdTZkdWRRbWU4N25V?=
 =?utf-8?B?d0paWVBaQUR3UWxHbTV2MWErTW5uSFdEVEVmSDl2MHZHbTR4SjB2UTFxOHdN?=
 =?utf-8?B?MGZuMkpHY2tnQ3NIejJCWEk5eWZKTTdxS01ZSG1kQ0VwMjJhZHY5dFU5Rm9U?=
 =?utf-8?B?TEVLK1dQUHBpREZEMi9uWjZoY1dTbXBqSmxFTGhES0U5aDJOK3lWbGFlRWoz?=
 =?utf-8?B?QlhVcjVGSi80cDRKQkVvSlJIZWZJV3Q2eE1KMnBmd3dNelRNZWw2WGVqcHRE?=
 =?utf-8?B?SVZPNllKRHJtd2w5d2VER2ZDWm1GZ3h0M0x6dVpPMEliQWcxRFB5NWxUaFhM?=
 =?utf-8?Q?30h4+l5jfbgQJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2E4em1wamhZUDNhaEpBRzJPam5ORUx0ZXhmZEgvTW1XSWVFVW1BMXhtUUF4?=
 =?utf-8?B?dXNHaUg1QWMvcmhtRXFSeVYwUlNFM3RPME8rZTloeWNocHhaTTJXNmNURWd2?=
 =?utf-8?B?K3RwU090U09HWFVURFNPSjJMTlF2ZlNNVlJOWTNqa0xxbU9IKzhjOGRFTkZa?=
 =?utf-8?B?ZTRaUE9QN3prbzVXK2ViOXV3c0JPV1JZdEZJTWkxcXBsaUNGcldibDVMZHEr?=
 =?utf-8?B?YVBPSVZlem9rV2VvM3JpakRpVG1LSXRtSHZDTFl0ZTRQR0phOHh0UVdZRkJ5?=
 =?utf-8?B?S1FKK3dRUVp3RjBmcXlhVHk3VnJ3YkJPRlVPMXYrdUpoam5HcUViN3ptV0lN?=
 =?utf-8?B?TXRUcGdSL3hZUnM3NTRHQlB4czlDV3pHeXp6OUVsdnlidCtKaXFOM0VqYzEx?=
 =?utf-8?B?V01wVzRvMWEzZXAzWVI2ZitKZEk1alRTVDR5YXFta05CY1dURndDWWZQSGlZ?=
 =?utf-8?B?VFZQaHBsdC9YQjJYUWFUZ0ZRN1VKTEJhZzE0S1lkNDVXS3Y4S0ROTzRYanVl?=
 =?utf-8?B?SkxvYnFmSWNveFkyZmxnT1IwRnBmdFMwVHptNlFSdDVXRE85MVdMcWxIcDdB?=
 =?utf-8?B?Wk9kSWN6MEw1RGpTVEI3dzJ6cmc0bUFnNnNjak91YitCU3c5aVVnQjkyNUtL?=
 =?utf-8?B?WDJTOEg3bGc4MmxmbVQ3Tm16ZTg3bTM3Nklaelozc1JWSlp4RHJZeGMwaUd4?=
 =?utf-8?B?SGtGaFl0MmVhMitla3RpYlBmYlNBaW9yeU5rb2V5QmF4WWx4cHdYYklHeDAv?=
 =?utf-8?B?RlM5OFYxWkpDL2JXOWVwZDB5bEZwMDVCWW55MEZmalh3N1RKaTMyekVXdlpV?=
 =?utf-8?B?VTlBUDMvNm1tZW1NQzVoTDVrRnpmdTFHS2RjM2hNUW4vL08zSzMxdWJZek9L?=
 =?utf-8?B?RDhid2s3c3ZMekFVZTZzSE5RU2JBckRUeU5zaUtGTVJIS0JrbE5MQklIZ0ZF?=
 =?utf-8?B?aXpENFRzLzl4b295QUczNGNOcnltUWhiUXZvUDlYQWRYcndhOVhMYnJYaGFv?=
 =?utf-8?B?SkRpSTIxcHEyV3Y4aWp1NzFNL21rMWNEY0NoRHpLcjMwZ3RYbUZtR0ZrTmNi?=
 =?utf-8?B?QVF4czNUNkhtQmZaUlVkTHYzOVI5VlBuOXNUaVpra2ZteFp3ZFQybkNrL3VK?=
 =?utf-8?B?WXduUURDYXRIRDBxc2x3R1ZpNVFNdUUrb01ORFdHTmNWZUFaaTdTMnJMM0x4?=
 =?utf-8?B?NG1NK3d2K2ZlSWhHUUcrbEFXaXY0eVljcVNscmVYVUV5L20rS2VWRDl3YmZ3?=
 =?utf-8?B?aTlLZVQrTDRQenpZUFZ3STVjdEVqWDd6Q3lXR1F1djVyU3BYQ3ByWW1GS1Ax?=
 =?utf-8?B?VExYYjdlZ1VBWm13Q1E1RzYvR0ptWGcxbFZxMUVFdHJkb2lkVWdja3lQekVF?=
 =?utf-8?B?Q25jd3lOUkxUUlM3S0JOMEN1bEl3cVA0djJnclFSMVV3RWlGQ0IzMk1iWUt5?=
 =?utf-8?B?WjljMExvMVRrMmRpaHJsNHVrOXE4azg1TkFQRVJtSEdXOUhDNHViS1Q2Z0di?=
 =?utf-8?B?UVNjbG4xZFhKRnc1K2tiNEpNNys2MXc4bnYwOUgzamdlY1Q1ZVZWZmE3Sm54?=
 =?utf-8?B?SWY5VklCRzdqbTJHbzdwVEtrM0xuMWc5Y1VSZE1BQ0c2N1Urdy9pOTQ4dUtm?=
 =?utf-8?B?bXNHOE9RclkyNDNkRjRSN0d0VDlWZDAyamJlaDJFeUF0a2Fsd1kyYmJNeVUr?=
 =?utf-8?B?QTVBaStWNmh1cmRkR1ZPak1BNnUrTktFNHBqOTVDN0xHQ25nSHpBb0dKTlNS?=
 =?utf-8?B?WGJZbWJaRXpOdGNORkliZEQza0h5MCt6QkE2UjVTY2NPSTNuMFhoeDZmWFdI?=
 =?utf-8?B?bTY3TUF0TUQ0YVl4bHdpdmx6eXB2aTJrQTRKazFnbW8vL2VOR0VKUU1qNjYy?=
 =?utf-8?B?OEFaYW1TNmZXTndZS01rZzJOMFFZOG11MmFldG43bEpsejBCNTF2RlgrUy9v?=
 =?utf-8?B?MkdmUUpqa0d3blBDQ2tXalNFQzI4TDRWbmN0RzFMaHZHQm9BK1ZxQ2M3Sm9q?=
 =?utf-8?B?NXhwU0xZTmRKSTRWR1R6aE56OEN0cURIWHluNGN1UTJXZUxmTE5xNmU0YUpj?=
 =?utf-8?B?RkpJUmlLazVhcS81ZkcwUmtDMERUbG9MQU9hQkVLZXM3bjBOcTNYNmJxU1Rk?=
 =?utf-8?Q?F8VhGfDwHFZdSqHQJ/SUhLq3y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9464d9-34a2-470f-4a7b-08dd5194320a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:51:49.4197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxJaxPwF3HL9B/m9zeW5AoJEDsd6qCC2yGbEgAAmFkvZ60o7444aHGrY2ICj0z/x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495
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

Am 20.02.25 um 06:41 schrieb Lazar, Lijo:
> On 2/19/2025 2:35 PM, jesse.zhang@amd.com wrote:
>> From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
>>
>> - Modify the VM invalidation engine allocation logic to handle SDMA page rings.
>>   SDMA page rings now share the VM invalidation engine with SDMA gfx rings instead of
>>   allocating a separate engine. This change ensures efficient resource management and
>>   avoids the issue of insufficient VM invalidation engines.
>>
>> - Add synchronization for GPU TLB flush operations in gmc_v9_0.c.
>>   Use spin_lock and spin_unlock to ensure thread safety and prevent race conditions
>>   during TLB flush operations. This improves the stability and reliability of the driver,
>>   especially in multi-threaded environments.
>>
>> V3: replace the sdma ring check with a function `amdgpu_sdma_is_shared_inv_eng`
>>  to Check if a ring is an SDMA ring that shares a VM invalidation engine
>>
>> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
>> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  7 +++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 18 ++++++++++++++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
>>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    |  2 ++
>>  4 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> index cb914ce82eb5..8ccc3fb34940 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -601,8 +601,15 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
>>  			return -EINVAL;
>>  		}
>>  
>> +	if(amdgpu_sdma_is_shared_inv_eng(adev, ring)) {
>> +		/* Do not allocate a separate VM invalidation engine for SDMA page rings.
>> +		 * Shared VM invalid engine with sdma gfx ring.
>> +		 */
>> +		ring->vm_inv_eng = inv_eng - 1;
> This kind of logic has an implicit assumption that SDMA IP does
> something like
>
> for each inst
> 	init sdma ring
> 	init page ring
>
> If the IP does something like init page ring/init sdma ring or init sdma
> ring of all instances followed by init page ring of all instances, this
> doesn't work.
>
> The other thing is this is not readable. There is no clear way to know
> what this thing is really doing. That is why it's better to explicitly
> express what the logic is doing so that it's maintainable in future.

What guarantees that the SDMA gfx ring isn't interrupted by the paging ring while doing an invalidation?

In other words as far as I can see it is perfectly possible that the SDMA gfx ring grabs the semaphore, is interrupted by the SDMA paging ring and then in turn also waits for the semaphore.

This would mean a deadlock inside the SDMA.

As far as I can see what you try to do here is a no-go.

Regards,
Christian.

>
> Thanks,
> Lijo
>
>> +	} else {
>>  		ring->vm_inv_eng = inv_eng - 1;
>>  		vm_inv_engs[vmhub] &= ~(1 << ring->vm_inv_eng);
>> +	}
>>  
>>  		dev_info(adev->dev, "ring %s uses VM inv eng %u on hub %u\n",
>>  			 ring->name, ring->vm_inv_eng, ring->vm_hub);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> index 8de214a8ba6d..159ebd9ee62f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> @@ -503,6 +503,24 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>>  	}
>>  }
>>  
>> +/**
>> +* amdgpu_sdma_is_shared_inv_eng - Check if a ring is an SDMA ring that shares a VM invalidation engine
>> +* @adev: Pointer to the AMDGPU device structure
>> +* @ring: Pointer to the ring structure to check
>> +*
>> +* This function checks if the given ring is an SDMA ring that shares a VM invalidation engine.
>> +* It returns true if the ring is such an SDMA ring, false otherwise.
>> +*/
>> +bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_ring* ring)
>> +{
>> +	int i = ring->me;
>> +
>> +	if (!adev->sdma.has_page_queue || i >= adev->sdma.num_instances)
>> +		return false;
>> +
>> +	return (ring == &adev->sdma.instance[i].ring);
>> +}
>> +
>>  /**
>>   * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks
>>   * @funcs: Pointer to the callback structure containing pre_reset and post_reset functions
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>> index 7effc2673466..da3ec6655be7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>> @@ -194,4 +194,5 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
>>  void amdgpu_debugfs_sdma_sched_mask_init(struct amdgpu_device *adev);
>>  int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev);
>>  void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev);
>> +bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_ring* ring);
>>  #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 2aa87fdf715f..2599da8677da 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -1000,6 +1000,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>>  	 * to WA the Issue
>>  	 */
>>  
>> +	spin_lock(&adev->gmc.invalidate_lock);
>>  	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
>>  	if (use_semaphore)
>>  		/* a read return value of 1 means semaphore acuqire */
>> @@ -1030,6 +1031,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>>  		amdgpu_ring_emit_wreg(ring, hub->vm_inv_eng0_sem +
>>  				      hub->eng_distance * eng, 0);
>>  
>> +	spin_unlock(&adev->gmc.invalidate_lock);
>>  	return pd_addr;
>>  }
>>  

