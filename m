Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFCFD7876B
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 14:37:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D2D10E974;
	Thu, 21 Nov 2024 14:37:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fyz4gfqh";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5780B10E974
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 14:37:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNRnoHAoaoKhEgm4KfZL6hiJH5++v65YjrLhCseqhxNNw0Ndgu2Hq5fMjPbYSQSsE/Wf8HtXb8usza+9/zDdlA/CLC6Wch12RsDQAYy2xo724QIzXUiW8VD6kawiDB4HdiGHjwm997y+2kLSqa9yIs9NwD8FG+8GVA1KihAYCFUIDC/PR//pkHN/rhml/oxb0XiPnY4NftGqB2yN/J9E4QokhmRRjwjgDFLu16eVLC8slz2UpYwH2MGYwkeG3qo+V5+zfInBAH3r6m9suWC/A5GActXk7Hm/Z1sNiS2vDaphvyIv3avgZhQirA7PzHavVGiCyBp4K13SpqkwOIvYLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCqJw3zVbOr4a8SyfM981vMwbGGFkNXaWcz3l2TYmqs=;
 b=eNzqamrkRi4rBL2p2JpqXmYqulWY2JC2zrZqUTxKaKuzujdZ8X1XWpxj/b0B6EWtes0GbvEbb51Qp+lZLVT9Bv4txLQsHduQempxbcJFnJxlRJYEfm/sWMPXi0pwoLws4KmWRh/OfDgIOAD6uh8jmRYzkSPmJI41R7XdXgXB8wvMG6TqI+p2wgQ8YexJu89AwsOJVMpDcfSw/ivCRxyBKtE6SKEhHhLhljTeuD5n6fhq1lGlWmZ3T6mvfvKfSOAp9pADhZibc3fQHNLlJkjjhJWtHPjD1pV2k828iluEUVc5x59apP0hy9/KwA0Bmf1bVzdsvCQwdaV5ibotEMRQKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCqJw3zVbOr4a8SyfM981vMwbGGFkNXaWcz3l2TYmqs=;
 b=fyz4gfqhjP0/equmIm5R/AiLYInmEdZmnwA0TtV/0I9tGq30HEcVjzEKi124NsMsp2nAE/jpFkpHMlqZDzIasIYOFZAa6YDYMWCWYIHxCoQeF6bGdxOXsnmp6NCXp8PLav1pI4EUegfG20AZnBOZYL82lB2bDqVqKebAhoyoNDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 LV2PR12MB5799.namprd12.prod.outlook.com (2603:10b6:408:179::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Thu, 21 Nov
 2024 14:37:23 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8182.013; Thu, 21 Nov 2024
 14:37:22 +0000
Message-ID: <338941cf-8722-4d57-853c-b900f282d4ca@amd.com>
Date: Thu, 21 Nov 2024 20:07:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: fix and simplify workload handling
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Kenneth Feng <kenneth.feng@amd.com>
References: <20241120182828.2507700-1-alexander.deucher@amd.com>
 <f88d5b7c-94e5-4bfd-af56-0714faf34f2d@amd.com>
 <CADnq5_OKO=QaCrfXexc81Yjeew5_orML4f4gp2vaRchy9qLcYg@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_OKO=QaCrfXexc81Yjeew5_orML4f4gp2vaRchy9qLcYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0205.apcprd04.prod.outlook.com
 (2603:1096:4:187::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|LV2PR12MB5799:EE_
X-MS-Office365-Filtering-Correlation-Id: dac95a76-98cb-42d2-07b7-08dd0a3a0277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGQ4VWt3bDBPa3RKaXBENGZEd1Q3R0U2ZE1OaHRGcXJsOE5rZzlnVzkvbWVk?=
 =?utf-8?B?ZHpuRUF4eXhUaWk2MSsraldRWkozRmdQb2QvcklMWXFKZnV4ejVYVThOc3R4?=
 =?utf-8?B?bWFmQnpUVSs2enpUWVByc3FTZWJuMFZVVDRCRCsxWWxyYlVpdy93bzk3YUhp?=
 =?utf-8?B?RmcxeE9wY1h3OFFJampwRW4vdjYvdmFTQ2dzeFpkbVRuRkZrbE1leStSZnVE?=
 =?utf-8?B?TFh0aDhtVlFQNlFwMm51Qy9QeUJnU3BpZUpGRUdTcHlnMG5PRUtjdkRBUU1S?=
 =?utf-8?B?RXVGQUo1UXJxQjV4U0RHL296OTZRcVFwRVRWdlZvZml5KzRwZHNqc201NHF0?=
 =?utf-8?B?R3NjNUpsNGFreG5nZExBL09aTk9SOXRHcXFXZXdVbmpycHpockIxWHBQU1I1?=
 =?utf-8?B?bjQ0cnZ3TkhwOEgreGwxMkpUa0pKOU51Q3JFZHl1UXQ0L0QrQU1QWjFZYWJ2?=
 =?utf-8?B?NkYyZlhmV1ZSWUhPeVJvdDNDR3NqWWNQbjlrS3cwandWWTNTU0RrSkswcDZW?=
 =?utf-8?B?eVYvRTJMWE1MWmdzSXVLWjFGYnp0NS8vaVlNTm1tQzIvMm9sY0ZTdWlTQW81?=
 =?utf-8?B?RG83b3pvQlV1ckE4RTZuWkg2MkxpbnJCVXNFNjVtYlJ2U213b3RYMDRLNFBF?=
 =?utf-8?B?QWNtUTFVdlVsMTVrMVYyNnZ5Y1FwM29xYXVzMzkyTGRqTHNxeTZ3dERBL2hU?=
 =?utf-8?B?Nm9GSkJ3cjZmSnE0Mm0zakFpbk05WmdmU01iUk1ZV2RUUCtBNHd6Qk5YR0g3?=
 =?utf-8?B?ZlNISjN4YzY3Y2FzcnEzTFRySnNqKzJ0T1lTbHVjYnZETURIajllZ2QzdVdP?=
 =?utf-8?B?aUlhUmpwclBtTjUwdTg3YXZ1cEZYZWtqT2pJQS8vTllQK0h2cmpmdzgwcjlq?=
 =?utf-8?B?MDY5RXRJRXFqVjRuSGl2dHFmSE1keTZQWC9rc2lWTlYzT3NhckYweXU3QWF3?=
 =?utf-8?B?L1JCYXBpVi9URTBDeUNvL3AzVnFUUG1QUGk3a3NIRW93bGJvTjB1VXNRK3Q3?=
 =?utf-8?B?ZEZyUGxzN25xRTV6R1ZVVHZJMFVGZGgrOGd6d3Q3bEprc0Vrd1FSMVdHSkhX?=
 =?utf-8?B?VUE4R0I5ODg1MGQ2M2IyazF4VUJPejRrakJ6WURCK0lieW9HUjVPYXdXc2h5?=
 =?utf-8?B?Q0N4aGd5WDhkU0YxRitCNHJib1BkeWJzc0krT1pOQm9tSDFaWFNLN1FhOUdJ?=
 =?utf-8?B?ajljQ1M4TWlDbjNaYSs3bms3R1paaFJUYWFMcGg4Mm5xZmY1elU1amVoZDd4?=
 =?utf-8?B?TmRncFBQMXNyeWxMT21hU2hQSFYyenYwLzRycHcvSEh6am9WbFVkSjJycjJR?=
 =?utf-8?B?VDM1OUxrdFdCcUVab3d6RFR3Uml4enNCL21aWWs5Znl2Vm1vY2FPWkQ1OWhH?=
 =?utf-8?B?OUhrMXVuTUxXZ1lMcnJSQ09DNTNsZit0RkRXc0xVN3cxUm1pRFFvaHhyZzN1?=
 =?utf-8?B?VmtGbmtBNHpHOW5BUER1L3d4d2ZkK1JwZ2ViVnRDWkVqWTgxR0ppRUk0Rmxh?=
 =?utf-8?B?ZU9zakFiZFFPNXB5Z2lUdFFVejBHQkdGUW93cUk4OWpkUTNuS3JxS0drQ0l1?=
 =?utf-8?B?TlRrT1dtRWI3TTFDQWl1Qm1KblVsN2c0Z1FFNDdyUG9DUXBzNDIrcEdvemZB?=
 =?utf-8?B?aGVsSkljVFRJaWNLOEhzMDhrSnllcWJaQzlSMVVUZ2lUY0lCemROQURyNGp6?=
 =?utf-8?B?bzFtQ0R0eTNCYjJua2VaUDloVjFqWm8xMCtEL3Z3NERydi9UOU8zcUorTnp6?=
 =?utf-8?Q?95DG7OoNsno5Ra0KsMdHQhhI1BBWG8gPMhDf6ha?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXFPQVV6Y21QMjhweVM2ZWJCQnZFTm5LRVBETlBwYnNNc24ydHhrU1Q4cTRo?=
 =?utf-8?B?NXR1c3dNUFhVc2l0ckMrdW5qaVBSWnJxWU51S3dYQ04wNm9SSk9HZUlObkF3?=
 =?utf-8?B?VzZkaG9HRDFma2JaNHdOVTQ0VUxTM1RvOCtjN0JxY3BpeXhmcmRTR1FiV29r?=
 =?utf-8?B?NjR3akVjQWJKYkF2TEVlY0VwUW5hSHNFcUFtNDNYWWptVXQyVXVhL1dBL3lr?=
 =?utf-8?B?ancrQUo3cElpbld0TzduOU5TRm1zMGVsaDhLekRqeTBFTi9rT1pKeU9xTFJT?=
 =?utf-8?B?TGgwNlArQnNQZDBFRzJXenFDdFMzMEpSZS8rZVV4aWQzMHVaR285MnMrcHUz?=
 =?utf-8?B?UzJuVHpoVDUyTXJjQy9jTS9PQ3J1WTkyVnB2Qzk2TEVOYUxlQXhkQi82MEMw?=
 =?utf-8?B?dU9lRG5LS0d4QUk2dlYyQ1pBcEkwdWpKWmtQNUdaRk5ubzRBNVlyZGVJeHJH?=
 =?utf-8?B?Z3JNMHJUY3lDbGhoVTNZOEFpYmtVSWE5VExWdmNDVnMrcVp2bnh6S1BDMWdZ?=
 =?utf-8?B?enlHL254OWE0ZnRLUjcyZmpHVThycmFpdmpUcmw1T210eEM1QSthd2VtclVs?=
 =?utf-8?B?SEJadERCRGsyYmxqMnhmTUIra21HdlpLejY4SXliSnhObEFWUUlQMVZHVTBP?=
 =?utf-8?B?bW5peGhDd3Iwa2wrc1hPNjErWElxdmxFeWNFa0gvOWk1WTRZUGFSZzF4QldW?=
 =?utf-8?B?a1hmVFJ5aTMzWkpldktFV080eVRYRFpoYmxTYWlVTXVXSkpwK3o1ZHp0WE1s?=
 =?utf-8?B?NTZYZDZvTlo3akRLZmdXMHg1SFJnazlTZlFEUm1TaEVrM2RCK1dobUk5eDh6?=
 =?utf-8?B?TEovVC9sbUNoNzdjVFpHOFE0ZUdCTHdYdXBpVnlzRE9DWUE5QXN4Nk13aXRo?=
 =?utf-8?B?dStRRXVWNG5pWURGVHIrV21MOE8rT1pxRDVweEpTQTNxb29zWlgzOXZkMFhR?=
 =?utf-8?B?aE1VQkx6Zi9UZ0FiWXpEZFEvR3lGcFZFM0FCYXNnY250SEg4OGtxR0IyRTAz?=
 =?utf-8?B?aGNneXp2TStDdUp2cG1oSVh0UlUwNHo3dU51NnZ2YXIwZ3JGb3d4YkR6dDVq?=
 =?utf-8?B?KytFWTJvWUpFa20ybFlQcjF3Qll3eFJrNHlMU1VGQVNKZ2owRSsxQjV5NS9X?=
 =?utf-8?B?a3NHYyttT0xRM3VLTFk5K1RoaVdaWDdiQllDVUVTamdGa0EyaThKRUg0YnRL?=
 =?utf-8?B?MERISGFjQ29YV1Z2a3pWdnE0bEhKM0R4c3hPK25PQXhTdnhtR3pLMjNPQjQ5?=
 =?utf-8?B?a3pMZTdrMTJ3Z2Y4VENadVFPMW5jNG5CQzdJNHZ6VmFnMUtYZ0R3cnVIUVpu?=
 =?utf-8?B?T096ZnJrZjM4Umw4a09Kd0F5WXlSU05sRzQyQU5keUdpZzV4bVVWODVsYmdK?=
 =?utf-8?B?dW5nUnpnd0JYNS9uT2p0ZmdiUjFFUlVMVDA0ZlFqYlFleGdURVZzcEY4Qk1R?=
 =?utf-8?B?VkhRUWY3aktLbkZBdlc1OElxclZTakpFdTNJbUJwcEYrK2RkbTdEa3JUUHNJ?=
 =?utf-8?B?d0loQk9EQzYzUitQajdURnl2R0JQUWNrOWQySitDYnNwRVdINXYwQ3NTRzFN?=
 =?utf-8?B?Q2FsN0Mwam9aYkk0K0JwUUhaL0tMN3lyVnRqYzRRblZIbHpHSnBPZGVCNzMx?=
 =?utf-8?B?ajR4YlJkdll1eGoyck1meGU1M282cDBzZGk5RDVYQSsyek1DZ0JPS2F5cENB?=
 =?utf-8?B?UXNMVzhwQTJBR0R2SDlSeWtiZ2RuT0g4SERLd3MwaUlodWxIUUNEOXF4bjFZ?=
 =?utf-8?B?ZE5xNnI5LzQ1cDNLc1JQQWZBK2xLT2t2YmNoUGd5b1pHRVpQYUJUUHpZL1Nr?=
 =?utf-8?B?S3BmNTdZOFM4SzZDdnVRRlJjQm1jSEMzZHFzRUhHaTJPS1NlcS9TWExkbThM?=
 =?utf-8?B?Z1BYTlU4TEFENGdRNWxXclNZTFFvSjMyR2dKa3U3Wi94RnBlL3ZlSVJMZlRj?=
 =?utf-8?B?OXdpb0l2MjdXZzV2YVhlcmtqUklHcTUrREdoZ3hXSXNIYXNsUzBLUEV1RnIx?=
 =?utf-8?B?cEQ2WXg1aEd1bG56Tkg1MXVpS1ppTFRXNTg5cW9BcCs2VmxuMHNYd1NNNEha?=
 =?utf-8?B?anIyM1pwNXY0bkZ1ZDBSVWtvUVBJTDZMaFUybVc0VW8rRENJUUFXelI3ZEVO?=
 =?utf-8?Q?Y2E1Ll6qAI1ovZpcW5SgIKhW/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac95a76-98cb-42d2-07b7-08dd0a3a0277
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 14:37:22.8220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRBwgT1UiRTGdV7DUDxpf4Nvb9rwlyLrqPvVH5G+5fbxAI00wJaKAmOX2COlakGB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5799
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



On 11/21/2024 7:58 PM, Alex Deucher wrote:
> On Wed, Nov 20, 2024 at 11:57 PM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>>
>> On 11/20/2024 11:58 PM, Alex Deucher wrote:
>>> smu->workload_mask is IP specific and should not be messed with in
>>> the common code. The mask bits vary across SMU versions.
>>>
>>> Move all handling of smu->workload_mask in to the backends and
>>> simplify the code.  Store the user's preference in smu->power_profile_mode
>>> which will be reflected in sysfs.  For internal driver profile
>>> switches for KFD or VCN, just update the workload mask so that the
>>> user's preference is retained.  Remove all of the extra now unused
>>> workload related elements in the smu structure.
>>>
>>> v2: use refcounts for workload profiles
>>> v3: rework based on feedback from Lijo
>>> v4: fix the refcount on failure, drop backend mask
>>> v5: rework custom handling
>>> v6: handle failure cleanup with custom profile
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Kenneth Feng <kenneth.feng@amd.com>
>>> Cc: Lijo Lazar <lijo.lazar@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 150 ++++++++++------
>>>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  15 +-
>>>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 166 +++++++++--------
>>>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 167 ++++++++++-------
>>>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 168 +++++++++++-------
>>>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  41 ++---
>>>  .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  43 ++---
>>>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 167 +++++++++--------
>>>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 138 ++++++++------
>>>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 168 +++++++++++-------
>>>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  25 +++
>>>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   4 +
>>>  12 files changed, 736 insertions(+), 516 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> index f99fe2508852..acaa1530c25c 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> @@ -72,6 +72,10 @@ static int smu_set_power_limit(void *handle, uint32_t limit);
>>>  static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
>>>  static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
>>>  static int smu_set_mp1_state(void *handle, enum pp_mp1_state mp1_state);
>>> +static void smu_power_profile_mode_get(struct smu_context *smu,
>>> +                                    enum PP_SMC_POWER_PROFILE profile_mode);
>>> +static void smu_power_profile_mode_put(struct smu_context *smu,
>>> +                                    enum PP_SMC_POWER_PROFILE profile_mode);
>>>
>>>  static int smu_sys_get_pp_feature_mask(void *handle,
>>>                                      char *buf)
>>> @@ -1268,8 +1272,6 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>>>       INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
>>>       atomic64_set(&smu->throttle_int_counter, 0);
>>>       smu->watermarks_bitmap = 0;
>>> -     smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>>> -     smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>>>
>>>       for (i = 0; i < adev->vcn.num_vcn_inst; i++)
>>>               atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
>>> @@ -1277,27 +1279,13 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>>>       atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
>>>       atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
>>>
>>> -     smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
>>> -     smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
>>> -     smu->workload_prority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
>>> -     smu->workload_prority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
>>> -     smu->workload_prority[PP_SMC_POWER_PROFILE_VR] = 4;
>>> -     smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
>>> -     smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
>>> -
>>>       if (smu->is_apu ||
>>>           !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
>>> -             smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
>>> +             smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>>>       else
>>> -             smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
>>> -
>>> -     smu->workload_setting[0] = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>>> -     smu->workload_setting[1] = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>>> -     smu->workload_setting[2] = PP_SMC_POWER_PROFILE_POWERSAVING;
>>> -     smu->workload_setting[3] = PP_SMC_POWER_PROFILE_VIDEO;
>>> -     smu->workload_setting[4] = PP_SMC_POWER_PROFILE_VR;
>>> -     smu->workload_setting[5] = PP_SMC_POWER_PROFILE_COMPUTE;
>>> -     smu->workload_setting[6] = PP_SMC_POWER_PROFILE_CUSTOM;
>>> +             smu->power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>>> +     smu_power_profile_mode_get(smu, smu->power_profile_mode);
>>> +
>>>       smu->display_config = &adev->pm.pm_display_cfg;
>>>
>>>       smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
>>> @@ -1350,6 +1338,11 @@ static int smu_sw_fini(struct amdgpu_ip_block *ip_block)
>>>               return ret;
>>>       }
>>>
>>> +     if (smu->custom_profile_params) {
>>> +             kfree(smu->custom_profile_params);
>>> +             smu->custom_profile_params = NULL;
>>> +     }
>>> +
>>>       smu_fini_microcode(smu);
>>>
>>>       return 0;
>>> @@ -2137,6 +2130,9 @@ static int smu_suspend(struct amdgpu_ip_block *ip_block)
>>>       if (!ret)
>>>               adev->gfx.gfx_off_entrycount = count;
>>>
>>> +     /* clear this on suspend so it will get reprogrammed on resume */
>>> +     smu->workload_mask = 0;
>>> +
>>>       return 0;
>>>  }
>>>
>>> @@ -2249,25 +2245,49 @@ static int smu_enable_umd_pstate(void *handle,
>>>  }
>>>
>>>  static int smu_bump_power_profile_mode(struct smu_context *smu,
>>> -                                        long *param,
>>> -                                        uint32_t param_size)
>>> +                                    long *custom_params,
>>> +                                    u32 custom_params_max_idx)
>>>  {
>>> -     int ret = 0;
>>> +     u32 workload_mask = 0;
>>> +     int i, ret = 0;
>>> +
>>> +     for (i = 0; i < PP_SMC_POWER_PROFILE_COUNT; i++) {
>>> +             if (smu->workload_refcount[i])
>>> +                     workload_mask |= 1 << i;
>>> +     }
>>> +
>>> +     if (smu->workload_mask == workload_mask)
>>> +             return 0;
>>>
>>>       if (smu->ppt_funcs->set_power_profile_mode)
>>> -             ret = smu->ppt_funcs->set_power_profile_mode(smu, param, param_size);
>>> +             ret = smu->ppt_funcs->set_power_profile_mode(smu, workload_mask,
>>> +                                                          custom_params,
>>> +                                                          custom_params_max_idx);
>>> +
>>> +     if (!ret)
>>> +             smu->workload_mask = workload_mask;
>>>
>>>       return ret;
>>>  }
>>>
>>> +static void smu_power_profile_mode_get(struct smu_context *smu,
>>> +                                    enum PP_SMC_POWER_PROFILE profile_mode)
>>> +{
>>> +     smu->workload_refcount[profile_mode]++;
>>> +}
>>> +
>>> +static void smu_power_profile_mode_put(struct smu_context *smu,
>>> +                                    enum PP_SMC_POWER_PROFILE profile_mode)
>>> +{
>>> +     if (smu->workload_refcount[profile_mode])
>>> +             smu->workload_refcount[profile_mode]--;
>>> +}
>>> +
>>>  static int smu_adjust_power_state_dynamic(struct smu_context *smu,
>>>                                         enum amd_dpm_forced_level level,
>>> -                                       bool skip_display_settings,
>>> -                                       bool init)
>>> +                                       bool skip_display_settings)
>>>  {
>>>       int ret = 0;
>>> -     int index = 0;
>>> -     long workload[1];
>>>       struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
>>>
>>>       if (!skip_display_settings) {
>>> @@ -2304,14 +2324,8 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
>>>       }
>>>
>>>       if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
>>> -             smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
>>> -             index = fls(smu->workload_mask);
>>> -             index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
>>> -             workload[0] = smu->workload_setting[index];
>>> -
>>> -             if (init || smu->power_profile_mode != workload[0])
>>> -                     smu_bump_power_profile_mode(smu, workload, 0);
>>> -     }
>>> +         smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
>>> +             smu_bump_power_profile_mode(smu, NULL, 0);
>>>
>>>       return ret;
>>>  }
>>> @@ -2330,13 +2344,13 @@ static int smu_handle_task(struct smu_context *smu,
>>>               ret = smu_pre_display_config_changed(smu);
>>>               if (ret)
>>>                       return ret;
>>> -             ret = smu_adjust_power_state_dynamic(smu, level, false, false);
>>> +             ret = smu_adjust_power_state_dynamic(smu, level, false);
>>>               break;
>>>       case AMD_PP_TASK_COMPLETE_INIT:
>>> -             ret = smu_adjust_power_state_dynamic(smu, level, true, true);
>>> +             ret = smu_adjust_power_state_dynamic(smu, level, true);
>>>               break;
>>>       case AMD_PP_TASK_READJUST_POWER_STATE:
>>> -             ret = smu_adjust_power_state_dynamic(smu, level, true, false);
>>> +             ret = smu_adjust_power_state_dynamic(smu, level, true);
>>>               break;
>>>       default:
>>>               break;
>>> @@ -2358,12 +2372,11 @@ static int smu_handle_dpm_task(void *handle,
>>>
>>>  static int smu_switch_power_profile(void *handle,
>>>                                   enum PP_SMC_POWER_PROFILE type,
>>> -                                 bool en)
>>> +                                 bool enable)
>>>  {
>>>       struct smu_context *smu = handle;
>>>       struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
>>> -     long workload[1];
>>> -     uint32_t index;
>>> +     int ret;
>>>
>>>       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>>>               return -EOPNOTSUPP;
>>> @@ -2371,21 +2384,21 @@ static int smu_switch_power_profile(void *handle,
>>>       if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
>>>               return -EINVAL;
>>>
>>> -     if (!en) {
>>> -             smu->workload_mask &= ~(1 << smu->workload_prority[type]);
>>> -             index = fls(smu->workload_mask);
>>> -             index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
>>> -             workload[0] = smu->workload_setting[index];
>>> -     } else {
>>> -             smu->workload_mask |= (1 << smu->workload_prority[type]);
>>> -             index = fls(smu->workload_mask);
>>> -             index = index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
>>> -             workload[0] = smu->workload_setting[index];
>>> -     }
>>> -
>>>       if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
>>> -             smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
>>> -             smu_bump_power_profile_mode(smu, workload, 0);
>>> +         smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
>>> +             if (enable)
>>> +                     smu_power_profile_mode_get(smu, type);
>>> +             else
>>> +                     smu_power_profile_mode_put(smu, type);
>>> +             ret = smu_bump_power_profile_mode(smu, NULL, 0);
>>> +             if (ret) {
>>> +                     if (enable)
>>> +                             smu_power_profile_mode_put(smu, type);
>>> +                     else
>>> +                             smu_power_profile_mode_get(smu, type);
>>> +                     return ret;
>>> +             }
>>> +     }
>>>
>>>       return 0;
>>>  }
>>> @@ -3084,12 +3097,35 @@ static int smu_set_power_profile_mode(void *handle,
>>>                                     uint32_t param_size)
>>>  {
>>>       struct smu_context *smu = handle;
>>> +     bool custom = false;
>>> +     int ret = 0;
>>>
>>>       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
>>>           !smu->ppt_funcs->set_power_profile_mode)
>>>               return -EOPNOTSUPP;
>>>
>>> -     return smu_bump_power_profile_mode(smu, param, param_size);
>>> +     if (param[param_size] == PP_SMC_POWER_PROFILE_CUSTOM) {
>>> +             custom = true;
>>> +             /* clear frontend mask so custom changes propogate */
>>> +             smu->workload_mask = 0;
>>> +     }
>>> +
>>> +     if ((param[param_size] != smu->power_profile_mode) || custom) {
>>> +             /* clear the old user preference */
>>> +             smu_power_profile_mode_put(smu, smu->power_profile_mode);
>>> +             /* set the new user preference */
>>> +             smu_power_profile_mode_get(smu, param[param_size]);
>>> +             ret = smu_bump_power_profile_mode(smu,
>>> +                                               custom ? param : NULL,
>>> +                                               custom ? param_size : 0);
>>> +             if (ret)
>>> +                     smu_power_profile_mode_put(smu, param[param_size]);
>>> +             else
>>> +                     /* store the user's preference */
>>> +                     smu->power_profile_mode = param[param_size];
>>> +     }
>>> +
>>> +     return ret;
>>>  }
>>>
>>>  static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> index d407777d6711..3630593bce61 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> @@ -556,11 +556,13 @@ struct smu_context {
>>>       uint32_t hard_min_uclk_req_from_dal;
>>>       bool disable_uclk_switch;
>>>
>>> +     /* asic agnostic workload mask */
>>>       uint32_t workload_mask;
>>> -     uint32_t workload_prority[WORKLOAD_POLICY_MAX];
>>> -     uint32_t workload_setting[WORKLOAD_POLICY_MAX];
>>> +     /* default/user workload preference */
>>>       uint32_t power_profile_mode;
>>> -     uint32_t default_power_profile_mode;
>>> +     uint32_t workload_refcount[PP_SMC_POWER_PROFILE_COUNT];
>>> +     /* backend specific custom workload settings */
>>> +     long *custom_profile_params;
>>>       bool pm_enabled;
>>>       bool is_apu;
>>>
>>> @@ -731,9 +733,12 @@ struct pptable_funcs {
>>>        * @set_power_profile_mode: Set a power profile mode. Also used to
>>>        *                          create/set custom power profile modes.
>>>        * &input: Power profile mode parameters.
>>> -      * &size: Size of &input.
>>> +      * &workload_mask: mask of workloads to enable
>>> +      * &custom_params: custom profile parameters
>>> +      * &custom_params_max_idx: max valid idx into custom_params
>>>        */
>>> -     int (*set_power_profile_mode)(struct smu_context *smu, long *input, uint32_t size);
>>> +     int (*set_power_profile_mode)(struct smu_context *smu, u32 workload_mask,
>>> +                                   long *custom_params, u32 custom_params_max_idx);
>>>
>>>       /**
>>>        * @dpm_set_vcn_enable: Enable/disable VCN engine dynamic power
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>> index a15754b1989f..8aa61a9f7778 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>> @@ -1445,98 +1445,120 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
>>>       return size;
>>>  }
>>>
>>> -static int arcturus_set_power_profile_mode(struct smu_context *smu,
>>> -                                        long *input,
>>> -                                        uint32_t size)
>>> +#define ARCTURUS_CUSTOM_PARAMS_COUNT 10
>>> +#define ARCTURUS_CUSTOM_PARAMS_CLOCK_COUNT 2
>>> +#define ARCTURUS_CUSTOM_PARAMS_SIZE (ARCTURUS_CUSTOM_PARAMS_CLOCK_COUNT * ARCTURUS_CUSTOM_PARAMS_COUNT * sizeof(long))
>>> +
>>> +static int arcturus_set_power_profile_mode_coeff(struct smu_context *smu,
>>> +                                              long *input)
>>>  {
>>>       DpmActivityMonitorCoeffInt_t activity_monitor;
>>> -     int workload_type = 0;
>>> -     uint32_t profile_mode = input[size];
>>> -     int ret = 0;
>>> +     int ret, idx;
>>>
>>> -     if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
>>> -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
>>> -             return -EINVAL;
>>> +     ret = smu_cmn_update_table(smu,
>>> +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF,
>>> +                                WORKLOAD_PPLIB_CUSTOM_BIT,
>>> +                                (void *)(&activity_monitor),
>>> +                                false);
>>> +     if (ret) {
>>> +             dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
>>> +             return ret;
>>>       }
>>>
>>> +     idx = 0 * ARCTURUS_CUSTOM_PARAMS_COUNT;
>>> +     if (input[idx]) {
>>> +             /* Gfxclk */
>>> +             activity_monitor.Gfx_FPS = input[idx + 1];
>>> +             activity_monitor.Gfx_UseRlcBusy = input[idx + 2];
>>> +             activity_monitor.Gfx_MinActiveFreqType = input[idx + 3];
>>> +             activity_monitor.Gfx_MinActiveFreq = input[idx + 4];
>>> +             activity_monitor.Gfx_BoosterFreqType = input[idx + 5];
>>> +             activity_monitor.Gfx_BoosterFreq = input[idx + 6];
>>> +             activity_monitor.Gfx_PD_Data_limit_c = input[idx + 7];
>>> +             activity_monitor.Gfx_PD_Data_error_coeff = input[idx + 8];
>>> +             activity_monitor.Gfx_PD_Data_error_rate_coeff = input[idx + 9];
>>> +     }
>>> +     idx = 1 * ARCTURUS_CUSTOM_PARAMS_COUNT;
>>> +     if (input[idx]) {
>>> +             /* Uclk */
>>> +             activity_monitor.Mem_FPS = input[idx + 1];
>>> +             activity_monitor.Mem_UseRlcBusy = input[idx + 2];
>>> +             activity_monitor.Mem_MinActiveFreqType = input[idx + 3];
>>> +             activity_monitor.Mem_MinActiveFreq = input[idx + 4];
>>> +             activity_monitor.Mem_BoosterFreqType = input[idx + 5];
>>> +             activity_monitor.Mem_BoosterFreq = input[idx + 6];
>>> +             activity_monitor.Mem_PD_Data_limit_c = input[idx + 7];
>>> +             activity_monitor.Mem_PD_Data_error_coeff = input[idx + 8];
>>> +             activity_monitor.Mem_PD_Data_error_rate_coeff = input[idx + 9];
>>> +     }
>>>
>>> -     if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
>>> -          (smu->smc_fw_version >= 0x360d00)) {
>>> -             if (size != 10)
>>> -                     return -EINVAL;
>>> +     ret = smu_cmn_update_table(smu,
>>> +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF,
>>> +                                WORKLOAD_PPLIB_CUSTOM_BIT,
>>> +                                (void *)(&activity_monitor),
>>> +                                true);
>>> +     if (ret) {
>>> +             dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
>>> +             return ret;
>>> +     }
>>>
>>> -             ret = smu_cmn_update_table(smu,
>>> -                                    SMU_TABLE_ACTIVITY_MONITOR_COEFF,
>>> -                                    WORKLOAD_PPLIB_CUSTOM_BIT,
>>> -                                    (void *)(&activity_monitor),
>>> -                                    false);
>>> -             if (ret) {
>>> -                     dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
>>> -                     return ret;
>>> -             }
>>> +     return ret;
>>> +}
>>>
>>> -             switch (input[0]) {
>>> -             case 0: /* Gfxclk */
>>> -                     activity_monitor.Gfx_FPS = input[1];
>>> -                     activity_monitor.Gfx_UseRlcBusy = input[2];
>>> -                     activity_monitor.Gfx_MinActiveFreqType = input[3];
>>> -                     activity_monitor.Gfx_MinActiveFreq = input[4];
>>> -                     activity_monitor.Gfx_BoosterFreqType = input[5];
>>> -                     activity_monitor.Gfx_BoosterFreq = input[6];
>>> -                     activity_monitor.Gfx_PD_Data_limit_c = input[7];
>>> -                     activity_monitor.Gfx_PD_Data_error_coeff = input[8];
>>> -                     activity_monitor.Gfx_PD_Data_error_rate_coeff = input[9];
>>> -                     break;
>>> -             case 1: /* Uclk */
>>> -                     activity_monitor.Mem_FPS = input[1];
>>> -                     activity_monitor.Mem_UseRlcBusy = input[2];
>>> -                     activity_monitor.Mem_MinActiveFreqType = input[3];
>>> -                     activity_monitor.Mem_MinActiveFreq = input[4];
>>> -                     activity_monitor.Mem_BoosterFreqType = input[5];
>>> -                     activity_monitor.Mem_BoosterFreq = input[6];
>>> -                     activity_monitor.Mem_PD_Data_limit_c = input[7];
>>> -                     activity_monitor.Mem_PD_Data_error_coeff = input[8];
>>> -                     activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
>>> -                     break;
>>> -             default:
>>> +static int arcturus_set_power_profile_mode(struct smu_context *smu,
>>> +                                        u32 workload_mask,
>>> +                                        long *custom_params,
>>> +                                        u32 custom_params_max_idx)
>>> +{
>>> +     u32 backend_workload_mask = 0;
>>> +     int ret, idx = -1, i;
>>> +
>>> +     smu_cmn_get_backend_workload_mask(smu, workload_mask,
>>> +                                       &backend_workload_mask);
>>> +
>>> +     if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
>>> +             if (smu->smc_fw_version < 0x360d00)
>>>                       return -EINVAL;
>>> +             if (!smu->custom_profile_params) {
>>> +                     smu->custom_profile_params =
>>> +                             kzalloc(ARCTURUS_CUSTOM_PARAMS_SIZE, GFP_KERNEL);
>>> +                     if (!smu->custom_profile_params)
>>> +                             return -ENOMEM;
>>>               }
>>> -
>>> -             ret = smu_cmn_update_table(smu,
>>> -                                    SMU_TABLE_ACTIVITY_MONITOR_COEFF,
>>> -                                    WORKLOAD_PPLIB_CUSTOM_BIT,
>>> -                                    (void *)(&activity_monitor),
>>> -                                    true);
>>> +             if (custom_params && custom_params_max_idx) {
>>> +                     if (custom_params_max_idx != ARCTURUS_CUSTOM_PARAMS_COUNT)
>>> +                             return -EINVAL;
>>> +                     if (custom_params[0] >= ARCTURUS_CUSTOM_PARAMS_CLOCK_COUNT)
>>> +                             return -EINVAL;
>>> +                     idx = custom_params[0] * ARCTURUS_CUSTOM_PARAMS_COUNT;
>>> +                     smu->custom_profile_params[idx] = 1;
>>> +                     for (i = 1; i < custom_params_max_idx; i++)
>>> +                             smu->custom_profile_params[idx + i] = custom_params[i];
>>> +             }
>>> +             ret = arcturus_set_power_profile_mode_coeff(smu,
>>> +                                                         smu->custom_profile_params);
>>>               if (ret) {
>>> -                     dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
>>> +                     if (idx != -1)
>>> +                             smu->custom_profile_params[idx] = 0;
>>
>> I don't know if this is the right thing to do. This means we are only
>> having a partial revert eventhough custom mode settings as a whole failed.
>>
>> 1) Current Mode = 3D
>> 2) Pass Custom + GfxCLK custom settings
>> 3) Pass Custom + MemCLK custom settings
>>
>> When 3) fails, we revert from the custom mode (put operation) and it
>> goes back to 3D as the new settings failed. At a later point if user
>> passes MemCLK custom settings, this is going to pick the initial GFXCLK
>> custom settings also. Is that needed?
>>
> 
> I guess that is an open question.  Each step is discrete and 2
> succeeded so it seemed logical to me that it should be retained.
> I.e., if you are trying custom settings, it seems logical that if an
> operation fails, you'd only need to redo the operation that failed.
> E.g., one of the memclk parameters was bad so retry 3 with new
> parameters; no need to do step 2 again.  That said, custom is kind of
> weird because you can modify different aspects of it with each
> discrete operation.
> 

I guess then we need to document this behavior. With that,

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Alex
> 
> 
>> Thanks,
>> Lijo
>>>                       return ret;
>>>               }
>>> -     }
>>> -
>>> -     /*
>>> -      * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT
>>> -      * Not all profile modes are supported on arcturus.
>>> -      */
>>> -     workload_type = smu_cmn_to_asic_specific_index(smu,
>>> -                                                    CMN2ASIC_MAPPING_WORKLOAD,
>>> -                                                    profile_mode);
>>> -     if (workload_type < 0) {
>>> -             dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on arcturus\n", profile_mode);
>>> -             return -EINVAL;
>>> +     } else if (smu->custom_profile_params) {
>>> +             memset(smu->custom_profile_params, 0, ARCTURUS_CUSTOM_PARAMS_SIZE);
>>>       }
>>>
>>>       ret = smu_cmn_send_smc_msg_with_param(smu,
>>> -                                       SMU_MSG_SetWorkloadMask,
>>> -                                       1 << workload_type,
>>> -                                       NULL);
>>> +                                           SMU_MSG_SetWorkloadMask,
>>> +                                           backend_workload_mask,
>>> +                                           NULL);
>>>       if (ret) {
>>> -             dev_err(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
>>> +             dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
>>> +                     workload_mask);
>>> +             if (idx != -1)
>>> +                     smu->custom_profile_params[idx] = 0;
>>>               return ret;
>>>       }
>>>
>>> -     smu->power_profile_mode = profile_mode;
>>> -
>>> -     return 0;
>>> +     return ret;
>>>  }
>>>
>>>  static int arcturus_set_performance_level(struct smu_context *smu,
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>> index faa8e7d9c3c6..7fad5dfb39c4 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>> @@ -2006,87 +2006,122 @@ static int navi10_get_power_profile_mode(struct smu_context *smu, char *buf)
>>>       return size;
>>>  }
>>>
>>> -static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
>>> +#define NAVI10_CUSTOM_PARAMS_COUNT 10
>>> +#define NAVI10_CUSTOM_PARAMS_CLOCKS_COUNT 3
>>> +#define NAVI10_CUSTOM_PARAMS_SIZE (NAVI10_CUSTOM_PARAMS_CLOCKS_COUNT * NAVI10_CUSTOM_PARAMS_COUNT * sizeof(long))
>>> +
>>> +static int navi10_set_power_profile_mode_coeff(struct smu_context *smu,
>>> +                                            long *input)
>>>  {
>>>       DpmActivityMonitorCoeffInt_t activity_monitor;
>>> -     int workload_type, ret = 0;
>>> +     int ret, idx;
>>>
>>> -     smu->power_profile_mode = input[size];
>>> +     ret = smu_cmn_update_table(smu,
>>> +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
>>> +                                (void *)(&activity_monitor), false);
>>> +     if (ret) {
>>> +             dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
>>> +             return ret;
>>> +     }
>>>
>>> -     if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
>>> -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
>>> -             return -EINVAL;
>>> +     idx = 0 * NAVI10_CUSTOM_PARAMS_COUNT;
>>> +     if (input[idx]) {
>>> +             /* Gfxclk */
>>> +             activity_monitor.Gfx_FPS = input[idx + 1];
>>> +             activity_monitor.Gfx_MinFreqStep = input[idx + 2];
>>> +             activity_monitor.Gfx_MinActiveFreqType = input[idx + 3];
>>> +             activity_monitor.Gfx_MinActiveFreq = input[idx + 4];
>>> +             activity_monitor.Gfx_BoosterFreqType = input[idx + 5];
>>> +             activity_monitor.Gfx_BoosterFreq = input[idx + 6];
>>> +             activity_monitor.Gfx_PD_Data_limit_c = input[idx + 7];
>>> +             activity_monitor.Gfx_PD_Data_error_coeff = input[idx + 8];
>>> +             activity_monitor.Gfx_PD_Data_error_rate_coeff = input[idx + 9];
>>> +     }
>>> +     idx = 1 * NAVI10_CUSTOM_PARAMS_COUNT;
>>> +     if (input[idx]) {
>>> +             /* Socclk */
>>> +             activity_monitor.Soc_FPS = input[idx + 1];
>>> +             activity_monitor.Soc_MinFreqStep = input[idx + 2];
>>> +             activity_monitor.Soc_MinActiveFreqType = input[idx + 3];
>>> +             activity_monitor.Soc_MinActiveFreq = input[idx + 4];
>>> +             activity_monitor.Soc_BoosterFreqType = input[idx + 5];
>>> +             activity_monitor.Soc_BoosterFreq = input[idx + 6];
>>> +             activity_monitor.Soc_PD_Data_limit_c = input[idx + 7];
>>> +             activity_monitor.Soc_PD_Data_error_coeff = input[idx + 8];
>>> +             activity_monitor.Soc_PD_Data_error_rate_coeff = input[idx + 9];
>>> +     }
>>> +     idx = 2 * NAVI10_CUSTOM_PARAMS_COUNT;
>>> +     if (input[idx]) {
>>> +             /* Memclk */
>>> +             activity_monitor.Mem_FPS = input[idx + 1];
>>> +             activity_monitor.Mem_MinFreqStep = input[idx + 2];
>>> +             activity_monitor.Mem_MinActiveFreqType = input[idx + 3];
>>> +             activity_monitor.Mem_MinActiveFreq = input[idx + 4];
>>> +             activity_monitor.Mem_BoosterFreqType = input[idx + 5];
>>> +             activity_monitor.Mem_BoosterFreq = input[idx + 6];
>>> +             activity_monitor.Mem_PD_Data_limit_c = input[idx + 7];
>>> +             activity_monitor.Mem_PD_Data_error_coeff = input[idx + 8];
>>> +             activity_monitor.Mem_PD_Data_error_rate_coeff = input[idx + 9];
>>> +     }
>>> +
>>> +     ret = smu_cmn_update_table(smu,
>>> +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
>>> +                                (void *)(&activity_monitor), true);
>>> +     if (ret) {
>>> +             dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
>>> +             return ret;
>>>       }
>>>
>>> -     if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>>> -             if (size != 10)
>>> -                     return -EINVAL;
>>> +     return ret;
>>> +}
>>>
>>> -             ret = smu_cmn_update_table(smu,
>>> -                                    SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
>>> -                                    (void *)(&activity_monitor), false);
>>> -             if (ret) {
>>> -                     dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
>>> -                     return ret;
>>> -             }
>>> +static int navi10_set_power_profile_mode(struct smu_context *smu,
>>> +                                      u32 workload_mask,
>>> +                                      long *custom_params,
>>> +                                      u32 custom_params_max_idx)
>>> +{
>>> +     u32 backend_workload_mask = 0;
>>> +     int ret, idx = -1, i;
>>>
>>> -             switch (input[0]) {
>>> -             case 0: /* Gfxclk */
>>> -                     activity_monitor.Gfx_FPS = input[1];
>>> -                     activity_monitor.Gfx_MinFreqStep = input[2];
>>> -                     activity_monitor.Gfx_MinActiveFreqType = input[3];
>>> -                     activity_monitor.Gfx_MinActiveFreq = input[4];
>>> -                     activity_monitor.Gfx_BoosterFreqType = input[5];
>>> -                     activity_monitor.Gfx_BoosterFreq = input[6];
>>> -                     activity_monitor.Gfx_PD_Data_limit_c = input[7];
>>> -                     activity_monitor.Gfx_PD_Data_error_coeff = input[8];
>>> -                     activity_monitor.Gfx_PD_Data_error_rate_coeff = input[9];
>>> -                     break;
>>> -             case 1: /* Socclk */
>>> -                     activity_monitor.Soc_FPS = input[1];
>>> -                     activity_monitor.Soc_MinFreqStep = input[2];
>>> -                     activity_monitor.Soc_MinActiveFreqType = input[3];
>>> -                     activity_monitor.Soc_MinActiveFreq = input[4];
>>> -                     activity_monitor.Soc_BoosterFreqType = input[5];
>>> -                     activity_monitor.Soc_BoosterFreq = input[6];
>>> -                     activity_monitor.Soc_PD_Data_limit_c = input[7];
>>> -                     activity_monitor.Soc_PD_Data_error_coeff = input[8];
>>> -                     activity_monitor.Soc_PD_Data_error_rate_coeff = input[9];
>>> -                     break;
>>> -             case 2: /* Memclk */
>>> -                     activity_monitor.Mem_FPS = input[1];
>>> -                     activity_monitor.Mem_MinFreqStep = input[2];
>>> -                     activity_monitor.Mem_MinActiveFreqType = input[3];
>>> -                     activity_monitor.Mem_MinActiveFreq = input[4];
>>> -                     activity_monitor.Mem_BoosterFreqType = input[5];
>>> -                     activity_monitor.Mem_BoosterFreq = input[6];
>>> -                     activity_monitor.Mem_PD_Data_limit_c = input[7];
>>> -                     activity_monitor.Mem_PD_Data_error_coeff = input[8];
>>> -                     activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
>>> -                     break;
>>> -             default:
>>> -                     return -EINVAL;
>>> -             }
>>> +     smu_cmn_get_backend_workload_mask(smu, workload_mask,
>>> +                                       &backend_workload_mask);
>>>
>>> -             ret = smu_cmn_update_table(smu,
>>> -                                    SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
>>> -                                    (void *)(&activity_monitor), true);
>>> +     if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
>>> +             if (!smu->custom_profile_params) {
>>> +                     smu->custom_profile_params = kzalloc(NAVI10_CUSTOM_PARAMS_SIZE, GFP_KERNEL);
>>> +                     if (!smu->custom_profile_params)
>>> +                             return -ENOMEM;
>>> +             }
>>> +             if (custom_params && custom_params_max_idx) {
>>> +                     if (custom_params_max_idx != NAVI10_CUSTOM_PARAMS_COUNT)
>>> +                             return -EINVAL;
>>> +                     if (custom_params[0] >= NAVI10_CUSTOM_PARAMS_CLOCKS_COUNT)
>>> +                             return -EINVAL;
>>> +                     idx = custom_params[0] * NAVI10_CUSTOM_PARAMS_COUNT;
>>> +                     smu->custom_profile_params[idx] = 1;
>>> +                     for (i = 1; i < custom_params_max_idx; i++)
>>> +                             smu->custom_profile_params[idx + i] = custom_params[i];
>>> +             }
>>> +             ret = navi10_set_power_profile_mode_coeff(smu,
>>> +                                                       smu->custom_profile_params);
>>>               if (ret) {
>>> -                     dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
>>> +                     if (idx != -1)
>>> +                             smu->custom_profile_params[idx] = 0;
>>>                       return ret;
>>>               }
>>> +     } else if (smu->custom_profile_params) {
>>> +             memset(smu->custom_profile_params, 0, NAVI10_CUSTOM_PARAMS_SIZE);
>>>       }
>>>
>>> -     /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>>> -     workload_type = smu_cmn_to_asic_specific_index(smu,
>>> -                                                    CMN2ASIC_MAPPING_WORKLOAD,
>>> -                                                    smu->power_profile_mode);
>>> -     if (workload_type < 0)
>>> -             return -EINVAL;
>>>       ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
>>> -                                 1 << workload_type, NULL);
>>> -     if (ret)
>>> -             dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
>>> +                                           backend_workload_mask, NULL);
>>> +     if (ret) {
>>> +             dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
>>> +                     workload_mask);
>>> +             if (idx != -1)
>>> +                     smu->custom_profile_params[idx] = 0;
>>> +             return ret;
>>> +     }
>>>
>>>       return ret;
>>>  }
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>> index 30d050a6e953..19a25fdc2f5b 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>> @@ -1704,90 +1704,126 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
>>>       return size;
>>>  }
>>>
>>> -static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
>>> +#define SIENNA_CICHLID_CUSTOM_PARAMS_COUNT 10
>>> +#define SIENNA_CICHLID_CUSTOM_PARAMS_CLOCK_COUNT 3
>>> +#define SIENNA_CICHLID_CUSTOM_PARAMS_SIZE (SIENNA_CICHLID_CUSTOM_PARAMS_CLOCK_COUNT * SIENNA_CICHLID_CUSTOM_PARAMS_COUNT * sizeof(long))
>>> +
>>> +static int sienna_cichlid_set_power_profile_mode_coeff(struct smu_context *smu,
>>> +                                                    long *input)
>>>  {
>>>
>>>       DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>>>       DpmActivityMonitorCoeffInt_t *activity_monitor =
>>>               &(activity_monitor_external.DpmActivityMonitorCoeffInt);
>>> -     int workload_type, ret = 0;
>>> +     int ret, idx;
>>>
>>> -     smu->power_profile_mode = input[size];
>>> +     ret = smu_cmn_update_table(smu,
>>> +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
>>> +                                (void *)(&activity_monitor_external), false);
>>> +     if (ret) {
>>> +             dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
>>> +             return ret;
>>> +     }
>>>
>>> -     if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
>>> -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
>>> -             return -EINVAL;
>>> +     idx = 0 * SIENNA_CICHLID_CUSTOM_PARAMS_COUNT;
>>> +     if (input[idx]) {
>>> +             /* Gfxclk */
>>> +             activity_monitor->Gfx_FPS = input[idx + 1];
>>> +             activity_monitor->Gfx_MinFreqStep = input[idx + 2];
>>> +             activity_monitor->Gfx_MinActiveFreqType = input[idx + 3];
>>> +             activity_monitor->Gfx_MinActiveFreq = input[idx + 4];
>>> +             activity_monitor->Gfx_BoosterFreqType = input[idx + 5];
>>> +             activity_monitor->Gfx_BoosterFreq = input[idx + 6];
>>> +             activity_monitor->Gfx_PD_Data_limit_c = input[idx + 7];
>>> +             activity_monitor->Gfx_PD_Data_error_coeff = input[idx + 8];
>>> +             activity_monitor->Gfx_PD_Data_error_rate_coeff = input[idx + 9];
>>> +     }
>>> +     idx = 1 * SIENNA_CICHLID_CUSTOM_PARAMS_COUNT;
>>> +     if (input[idx]) {
>>> +             /* Socclk */
>>> +             activity_monitor->Fclk_FPS = input[idx + 1];
>>> +             activity_monitor->Fclk_MinFreqStep = input[idx + 2];
>>> +             activity_monitor->Fclk_MinActiveFreqType = input[idx + 3];
>>> +             activity_monitor->Fclk_MinActiveFreq = input[idx + 4];
>>> +             activity_monitor->Fclk_BoosterFreqType = input[idx + 5];
>>> +             activity_monitor->Fclk_BoosterFreq = input[idx + 6];
>>> +             activity_monitor->Fclk_PD_Data_limit_c = input[idx + 7];
>>> +             activity_monitor->Fclk_PD_Data_error_coeff = input[idx + 8];
>>> +             activity_monitor->Fclk_PD_Data_error_rate_coeff = input[idx + 9];
>>> +     }
>>> +     idx = 2 * SIENNA_CICHLID_CUSTOM_PARAMS_COUNT;
>>> +     if (input[idx]) {
>>> +             /* Memclk */
>>> +             activity_monitor->Mem_FPS = input[idx + 1];
>>> +             activity_monitor->Mem_MinFreqStep = input[idx + 2];
>>> +             activity_monitor->Mem_MinActiveFreqType = input[idx + 3];
>>> +             activity_monitor->Mem_MinActiveFreq = input[idx + 4];
>>> +             activity_monitor->Mem_BoosterFreqType = input[idx + 5];
>>> +             activity_monitor->Mem_BoosterFreq = input[idx + 6];
>>> +             activity_monitor->Mem_PD_Data_limit_c = input[idx + 7];
>>> +             activity_monitor->Mem_PD_Data_error_coeff = input[idx + 8];
>>> +             activity_monitor->Mem_PD_Data_error_rate_coeff = input[idx + 9];
>>>       }
>>>
>>> -     if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>>> -             if (size != 10)
>>> -                     return -EINVAL;
>>> +     ret = smu_cmn_update_table(smu,
>>> +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
>>> +                                (void *)(&activity_monitor_external), true);
>>> +     if (ret) {
>>> +             dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
>>> +             return ret;
>>> +     }
>>>
>>> -             ret = smu_cmn_update_table(smu,
>>> -                                    SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
>>> -                                    (void *)(&activity_monitor_external), false);
>>> -             if (ret) {
>>> -                     dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
>>> -                     return ret;
>>> -             }
>>> +     return ret;
>>> +}
>>>
>>> -             switch (input[0]) {
>>> -             case 0: /* Gfxclk */
>>> -                     activity_monitor->Gfx_FPS = input[1];
>>> -                     activity_monitor->Gfx_MinFreqStep = input[2];
>>> -                     activity_monitor->Gfx_MinActiveFreqType = input[3];
>>> -                     activity_monitor->Gfx_MinActiveFreq = input[4];
>>> -                     activity_monitor->Gfx_BoosterFreqType = input[5];
>>> -                     activity_monitor->Gfx_BoosterFreq = input[6];
>>> -                     activity_monitor->Gfx_PD_Data_limit_c = input[7];
>>> -                     activity_monitor->Gfx_PD_Data_error_coeff = input[8];
>>> -                     activity_monitor->Gfx_PD_Data_error_rate_coeff = input[9];
>>> -                     break;
>>> -             case 1: /* Socclk */
>>> -                     activity_monitor->Fclk_FPS = input[1];
>>> -                     activity_monitor->Fclk_MinFreqStep = input[2];
>>> -                     activity_monitor->Fclk_MinActiveFreqType = input[3];
>>> -                     activity_monitor->Fclk_MinActiveFreq = input[4];
>>> -                     activity_monitor->Fclk_BoosterFreqType = input[5];
>>> -                     activity_monitor->Fclk_BoosterFreq = input[6];
>>> -                     activity_monitor->Fclk_PD_Data_limit_c = input[7];
>>> -                     activity_monitor->Fclk_PD_Data_error_coeff = input[8];
>>> -                     activity_monitor->Fclk_PD_Data_error_rate_coeff = input[9];
>>> -                     break;
>>> -             case 2: /* Memclk */
>>> -                     activity_monitor->Mem_FPS = input[1];
>>> -                     activity_monitor->Mem_MinFreqStep = input[2];
>>> -                     activity_monitor->Mem_MinActiveFreqType = input[3];
>>> -                     activity_monitor->Mem_MinActiveFreq = input[4];
>>> -                     activity_monitor->Mem_BoosterFreqType = input[5];
>>> -                     activity_monitor->Mem_BoosterFreq = input[6];
>>> -                     activity_monitor->Mem_PD_Data_limit_c = input[7];
>>> -                     activity_monitor->Mem_PD_Data_error_coeff = input[8];
>>> -                     activity_monitor->Mem_PD_Data_error_rate_coeff = input[9];
>>> -                     break;
>>> -             default:
>>> -                     return -EINVAL;
>>> -             }
>>> +static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu,
>>> +                                              u32 workload_mask,
>>> +                                              long *custom_params,
>>> +                                              u32 custom_params_max_idx)
>>> +{
>>> +     u32 backend_workload_mask = 0;
>>> +     int ret, idx = -1, i;
>>>
>>> -             ret = smu_cmn_update_table(smu,
>>> -                                    SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
>>> -                                    (void *)(&activity_monitor_external), true);
>>> +     smu_cmn_get_backend_workload_mask(smu, workload_mask,
>>> +                                       &backend_workload_mask);
>>> +
>>> +     if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
>>> +             if (!smu->custom_profile_params) {
>>> +                     smu->custom_profile_params =
>>> +                             kzalloc(SIENNA_CICHLID_CUSTOM_PARAMS_SIZE, GFP_KERNEL);
>>> +                     if (!smu->custom_profile_params)
>>> +                             return -ENOMEM;
>>> +             }
>>> +             if (custom_params && custom_params_max_idx) {
>>> +                     if (custom_params_max_idx != SIENNA_CICHLID_CUSTOM_PARAMS_COUNT)
>>> +                             return -EINVAL;
>>> +                     if (custom_params[0] >= SIENNA_CICHLID_CUSTOM_PARAMS_CLOCK_COUNT)
>>> +                             return -EINVAL;
>>> +                     idx = custom_params[0] * SIENNA_CICHLID_CUSTOM_PARAMS_COUNT;
>>> +                     smu->custom_profile_params[idx] = 1;
>>> +                     for (i = 1; i < custom_params_max_idx; i++)
>>> +                             smu->custom_profile_params[idx + i] = custom_params[i];
>>> +             }
>>> +             ret = sienna_cichlid_set_power_profile_mode_coeff(smu,
>>> +                                                               smu->custom_profile_params);
>>>               if (ret) {
>>> -                     dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
>>> +                     if (idx != -1)
>>> +                             smu->custom_profile_params[idx] = 0;
>>>                       return ret;
>>>               }
>>> +     } else if (smu->custom_profile_params) {
>>> +             memset(smu->custom_profile_params, 0, SIENNA_CICHLID_CUSTOM_PARAMS_SIZE);
>>>       }
>>>
>>> -     /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>>> -     workload_type = smu_cmn_to_asic_specific_index(smu,
>>> -                                                    CMN2ASIC_MAPPING_WORKLOAD,
>>> -                                                    smu->power_profile_mode);
>>> -     if (workload_type < 0)
>>> -             return -EINVAL;
>>>       ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
>>> -                                 1 << workload_type, NULL);
>>> -     if (ret)
>>> -             dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
>>> +                                           backend_workload_mask, NULL);
>>> +     if (ret) {
>>> +             dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
>>> +                     workload_mask);
>>> +             if (idx != -1)
>>> +                     smu->custom_profile_params[idx] = 0;
>>> +             return ret;
>>> +     }
>>>
>>>       return ret;
>>>  }
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>> index cd3e9ba3eff4..a55ea76d7399 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>> @@ -1056,42 +1056,27 @@ static int vangogh_get_power_profile_mode(struct smu_context *smu,
>>>       return size;
>>>  }
>>>
>>> -static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
>>> +static int vangogh_set_power_profile_mode(struct smu_context *smu,
>>> +                                       u32 workload_mask,
>>> +                                       long *custom_params,
>>> +                                       u32 custom_params_max_idx)
>>>  {
>>> -     int workload_type, ret;
>>> -     uint32_t profile_mode = input[size];
>>> +     u32 backend_workload_mask = 0;
>>> +     int ret;
>>>
>>> -     if (profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
>>> -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
>>> -             return -EINVAL;
>>> -     }
>>> -
>>> -     if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
>>> -                     profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
>>> -             return 0;
>>> -
>>> -     /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>>> -     workload_type = smu_cmn_to_asic_specific_index(smu,
>>> -                                                    CMN2ASIC_MAPPING_WORKLOAD,
>>> -                                                    profile_mode);
>>> -     if (workload_type < 0) {
>>> -             dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on VANGOGH\n",
>>> -                                     profile_mode);
>>> -             return -EINVAL;
>>> -     }
>>> +     smu_cmn_get_backend_workload_mask(smu, workload_mask,
>>> +                                       &backend_workload_mask);
>>>
>>>       ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
>>> -                                 1 << workload_type,
>>> -                                 NULL);
>>> +                                           backend_workload_mask,
>>> +                                           NULL);
>>>       if (ret) {
>>> -             dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
>>> -                                     workload_type);
>>> +             dev_err_once(smu->adev->dev, "Fail to set workload mask 0x%08x\n",
>>> +                          workload_mask);
>>>               return ret;
>>>       }
>>>
>>> -     smu->power_profile_mode = profile_mode;
>>> -
>>> -     return 0;
>>> +     return ret;
>>>  }
>>>
>>>  static int vangogh_set_soft_freq_limited_range(struct smu_context *smu,
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>>> index a34797f3576b..37d82a71a2d7 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>>> @@ -864,44 +864,27 @@ static int renoir_force_clk_levels(struct smu_context *smu,
>>>       return ret;
>>>  }
>>>
>>> -static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
>>> +static int renoir_set_power_profile_mode(struct smu_context *smu,
>>> +                                      u32 workload_mask,
>>> +                                      long *custom_params,
>>> +                                      u32 custom_params_max_idx)
>>>  {
>>> -     int workload_type, ret;
>>> -     uint32_t profile_mode = input[size];
>>> +     int ret;
>>> +     u32 backend_workload_mask = 0;
>>>
>>> -     if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
>>> -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
>>> -             return -EINVAL;
>>> -     }
>>> -
>>> -     if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
>>> -                     profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
>>> -             return 0;
>>> -
>>> -     /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>>> -     workload_type = smu_cmn_to_asic_specific_index(smu,
>>> -                                                    CMN2ASIC_MAPPING_WORKLOAD,
>>> -                                                    profile_mode);
>>> -     if (workload_type < 0) {
>>> -             /*
>>> -              * TODO: If some case need switch to powersave/default power mode
>>> -              * then can consider enter WORKLOAD_COMPUTE/WORKLOAD_CUSTOM for power saving.
>>> -              */
>>> -             dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on RENOIR\n", profile_mode);
>>> -             return -EINVAL;
>>> -     }
>>> +     smu_cmn_get_backend_workload_mask(smu, workload_mask,
>>> +                                       &backend_workload_mask);
>>>
>>>       ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
>>> -                                 1 << workload_type,
>>> -                                 NULL);
>>> +                                           backend_workload_mask,
>>> +                                           NULL);
>>>       if (ret) {
>>> -             dev_err_once(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
>>> +             dev_err_once(smu->adev->dev, "Failed to set workload mask 0x08%x\n",
>>> +                          workload_mask);
>>>               return ret;
>>>       }
>>>
>>> -     smu->power_profile_mode = profile_mode;
>>> -
>>> -     return 0;
>>> +     return ret;
>>>  }
>>>
>>>  static int renoir_set_peak_clock_by_device(struct smu_context *smu)
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>>> index 199bdd9720d3..3aa705aae4c0 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>>> @@ -2571,82 +2571,76 @@ static int smu_v13_0_0_get_power_profile_mode(struct smu_context *smu,
>>>       return size;
>>>  }
>>>
>>> -static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>>> -                                           long *input,
>>> -                                           uint32_t size)
>>> +#define SMU_13_0_0_CUSTOM_PARAMS_COUNT 9
>>> +#define SMU_13_0_0_CUSTOM_PARAMS_CLOCK_COUNT 2
>>> +#define SMU_13_0_0_CUSTOM_PARAMS_SIZE (SMU_13_0_0_CUSTOM_PARAMS_CLOCK_COUNT * SMU_13_0_0_CUSTOM_PARAMS_COUNT * sizeof(long))
>>> +
>>> +static int smu_v13_0_0_set_power_profile_mode_coeff(struct smu_context *smu,
>>> +                                                 long *input)
>>>  {
>>>       DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>>>       DpmActivityMonitorCoeffInt_t *activity_monitor =
>>>               &(activity_monitor_external.DpmActivityMonitorCoeffInt);
>>> -     int workload_type, ret = 0;
>>> -     u32 workload_mask, selected_workload_mask;
>>> -
>>> -     smu->power_profile_mode = input[size];
>>> +     int ret, idx;
>>>
>>> -     if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
>>> -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
>>> -             return -EINVAL;
>>> +     ret = smu_cmn_update_table(smu,
>>> +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF,
>>> +                                WORKLOAD_PPLIB_CUSTOM_BIT,
>>> +                                (void *)(&activity_monitor_external),
>>> +                                false);
>>> +     if (ret) {
>>> +             dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
>>> +             return ret;
>>>       }
>>>
>>> -     if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>>> -             if (size != 9)
>>> -                     return -EINVAL;
>>> -
>>> -             ret = smu_cmn_update_table(smu,
>>> -                                        SMU_TABLE_ACTIVITY_MONITOR_COEFF,
>>> -                                        WORKLOAD_PPLIB_CUSTOM_BIT,
>>> -                                        (void *)(&activity_monitor_external),
>>> -                                        false);
>>> -             if (ret) {
>>> -                     dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
>>> -                     return ret;
>>> -             }
>>> -
>>> -             switch (input[0]) {
>>> -             case 0: /* Gfxclk */
>>> -                     activity_monitor->Gfx_FPS = input[1];
>>> -                     activity_monitor->Gfx_MinActiveFreqType = input[2];
>>> -                     activity_monitor->Gfx_MinActiveFreq = input[3];
>>> -                     activity_monitor->Gfx_BoosterFreqType = input[4];
>>> -                     activity_monitor->Gfx_BoosterFreq = input[5];
>>> -                     activity_monitor->Gfx_PD_Data_limit_c = input[6];
>>> -                     activity_monitor->Gfx_PD_Data_error_coeff = input[7];
>>> -                     activity_monitor->Gfx_PD_Data_error_rate_coeff = input[8];
>>> -                     break;
>>> -             case 1: /* Fclk */
>>> -                     activity_monitor->Fclk_FPS = input[1];
>>> -                     activity_monitor->Fclk_MinActiveFreqType = input[2];
>>> -                     activity_monitor->Fclk_MinActiveFreq = input[3];
>>> -                     activity_monitor->Fclk_BoosterFreqType = input[4];
>>> -                     activity_monitor->Fclk_BoosterFreq = input[5];
>>> -                     activity_monitor->Fclk_PD_Data_limit_c = input[6];
>>> -                     activity_monitor->Fclk_PD_Data_error_coeff = input[7];
>>> -                     activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
>>> -                     break;
>>> -             default:
>>> -                     return -EINVAL;
>>> -             }
>>> +     idx = 0 * SMU_13_0_0_CUSTOM_PARAMS_COUNT;
>>> +     if (input[idx]) {
>>> +             /* Gfxclk */
>>> +             activity_monitor->Gfx_FPS = input[idx + 1];
>>> +             activity_monitor->Gfx_MinActiveFreqType = input[idx + 2];
>>> +             activity_monitor->Gfx_MinActiveFreq = input[idx + 3];
>>> +             activity_monitor->Gfx_BoosterFreqType = input[idx + 4];
>>> +             activity_monitor->Gfx_BoosterFreq = input[idx + 5];
>>> +             activity_monitor->Gfx_PD_Data_limit_c = input[idx + 6];
>>> +             activity_monitor->Gfx_PD_Data_error_coeff = input[idx + 7];
>>> +             activity_monitor->Gfx_PD_Data_error_rate_coeff = input[idx + 8];
>>> +     }
>>> +     idx = 1 * SMU_13_0_0_CUSTOM_PARAMS_COUNT;
>>> +     if (input[idx]) {
>>> +             /* Fclk */
>>> +             activity_monitor->Fclk_FPS = input[idx + 1];
>>> +             activity_monitor->Fclk_MinActiveFreqType = input[idx + 2];
>>> +             activity_monitor->Fclk_MinActiveFreq = input[idx + 3];
>>> +             activity_monitor->Fclk_BoosterFreqType = input[idx + 4];
>>> +             activity_monitor->Fclk_BoosterFreq = input[idx + 5];
>>> +             activity_monitor->Fclk_PD_Data_limit_c = input[idx + 6];
>>> +             activity_monitor->Fclk_PD_Data_error_coeff = input[idx + 7];
>>> +             activity_monitor->Fclk_PD_Data_error_rate_coeff = input[idx + 8];
>>> +     }
>>>
>>> -             ret = smu_cmn_update_table(smu,
>>> -                                        SMU_TABLE_ACTIVITY_MONITOR_COEFF,
>>> -                                        WORKLOAD_PPLIB_CUSTOM_BIT,
>>> -                                        (void *)(&activity_monitor_external),
>>> -                                        true);
>>> -             if (ret) {
>>> -                     dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
>>> -                     return ret;
>>> -             }
>>> +     ret = smu_cmn_update_table(smu,
>>> +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF,
>>> +                                WORKLOAD_PPLIB_CUSTOM_BIT,
>>> +                                (void *)(&activity_monitor_external),
>>> +                                true);
>>> +     if (ret) {
>>> +             dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
>>> +             return ret;
>>>       }
>>>
>>> -     /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>>> -     workload_type = smu_cmn_to_asic_specific_index(smu,
>>> -                                                    CMN2ASIC_MAPPING_WORKLOAD,
>>> -                                                    smu->power_profile_mode);
>>> +     return ret;
>>> +}
>>>
>>> -     if (workload_type < 0)
>>> -             return -EINVAL;
>>> +static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>>> +                                           u32 workload_mask,
>>> +                                           long *custom_params,
>>> +                                           u32 custom_params_max_idx)
>>> +{
>>> +     u32 backend_workload_mask = 0;
>>> +     int workload_type, ret, idx = -1, i;
>>>
>>> -     selected_workload_mask = workload_mask = 1 << workload_type;
>>> +     smu_cmn_get_backend_workload_mask(smu, workload_mask,
>>> +                                       &backend_workload_mask);
>>>
>>>       /* Add optimizations for SMU13.0.0/10.  Reuse the power saving profile */
>>>       if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
>>> @@ -2658,15 +2652,48 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>>>                                                              CMN2ASIC_MAPPING_WORKLOAD,
>>>                                                              PP_SMC_POWER_PROFILE_POWERSAVING);
>>>               if (workload_type >= 0)
>>> -                     workload_mask |= 1 << workload_type;
>>> +                     backend_workload_mask |= 1 << workload_type;
>>> +     }
>>> +
>>> +     if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
>>> +             if (!smu->custom_profile_params) {
>>> +                     smu->custom_profile_params =
>>> +                             kzalloc(SMU_13_0_0_CUSTOM_PARAMS_SIZE, GFP_KERNEL);
>>> +                     if (!smu->custom_profile_params)
>>> +                             return -ENOMEM;
>>> +             }
>>> +             if (custom_params && custom_params_max_idx) {
>>> +                     if (custom_params_max_idx != SMU_13_0_0_CUSTOM_PARAMS_COUNT)
>>> +                             return -EINVAL;
>>> +                     if (custom_params[0] >= SMU_13_0_0_CUSTOM_PARAMS_CLOCK_COUNT)
>>> +                             return -EINVAL;
>>> +                     idx = custom_params[0] * SMU_13_0_0_CUSTOM_PARAMS_COUNT;
>>> +                     smu->custom_profile_params[idx] = 1;
>>> +                     for (i = 1; i < custom_params_max_idx; i++)
>>> +                             smu->custom_profile_params[idx + i] = custom_params[i];
>>> +             }
>>> +             ret = smu_v13_0_0_set_power_profile_mode_coeff(smu,
>>> +                                                            smu->custom_profile_params);
>>> +             if (ret) {
>>> +                     if (idx != -1)
>>> +                             smu->custom_profile_params[idx] = 0;
>>> +                     return ret;
>>> +             }
>>> +     } else if (smu->custom_profile_params) {
>>> +             memset(smu->custom_profile_params, 0, SMU_13_0_0_CUSTOM_PARAMS_SIZE);
>>>       }
>>>
>>>       ret = smu_cmn_send_smc_msg_with_param(smu,
>>> -                                            SMU_MSG_SetWorkloadMask,
>>> -                                            workload_mask,
>>> -                                            NULL);
>>> -     if (!ret)
>>> -             smu->workload_mask = selected_workload_mask;
>>> +                                           SMU_MSG_SetWorkloadMask,
>>> +                                           backend_workload_mask,
>>> +                                           NULL);
>>> +     if (ret) {
>>> +             dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
>>> +                     workload_mask);
>>> +             if (idx != -1)
>>> +                     smu->custom_profile_params[idx] = 0;
>>> +             return ret;
>>> +     }
>>>
>>>       return ret;
>>>  }
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>>> index 34c1e0c7e1e4..f4ac403b8b36 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>>> @@ -2530,78 +2530,110 @@ do {                                                                                                 \
>>>       return result;
>>>  }
>>>
>>> -static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
>>> +#define SMU_13_0_7_CUSTOM_PARAMS_COUNT 8
>>> +#define SMU_13_0_7_CUSTOM_PARAMS_CLOCK_COUNT 2
>>> +#define SMU_13_0_7_CUSTOM_PARAMS_SIZE (SMU_13_0_7_CUSTOM_PARAMS_CLOCK_COUNT * SMU_13_0_7_CUSTOM_PARAMS_COUNT * sizeof(long))
>>> +
>>> +static int smu_v13_0_7_set_power_profile_mode_coeff(struct smu_context *smu,
>>> +                                                 long *input)
>>>  {
>>>
>>>       DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>>>       DpmActivityMonitorCoeffInt_t *activity_monitor =
>>>               &(activity_monitor_external.DpmActivityMonitorCoeffInt);
>>> -     int workload_type, ret = 0;
>>> +     int ret, idx;
>>>
>>> -     smu->power_profile_mode = input[size];
>>> +     ret = smu_cmn_update_table(smu,
>>> +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
>>> +                                (void *)(&activity_monitor_external), false);
>>> +     if (ret) {
>>> +             dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
>>> +             return ret;
>>> +     }
>>>
>>> -     if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
>>> -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
>>> -             return -EINVAL;
>>> +     idx = 0 * SMU_13_0_7_CUSTOM_PARAMS_COUNT;
>>> +     if (input[idx]) {
>>> +             /* Gfxclk */
>>> +             activity_monitor->Gfx_ActiveHystLimit = input[idx + 1];
>>> +             activity_monitor->Gfx_IdleHystLimit = input[idx + 2];
>>> +             activity_monitor->Gfx_FPS = input[idx + 3];
>>> +             activity_monitor->Gfx_MinActiveFreqType = input[idx + 4];
>>> +             activity_monitor->Gfx_BoosterFreqType = input[idx + 5];
>>> +             activity_monitor->Gfx_MinActiveFreq = input[idx + 6];
>>> +             activity_monitor->Gfx_BoosterFreq = input[idx + 7];
>>> +     }
>>> +     idx = 1 * SMU_13_0_7_CUSTOM_PARAMS_COUNT;
>>> +     if (input[idx]) {
>>> +             /* Fclk */
>>> +             activity_monitor->Fclk_ActiveHystLimit = input[idx + 1];
>>> +             activity_monitor->Fclk_IdleHystLimit = input[idx + 2];
>>> +             activity_monitor->Fclk_FPS = input[idx + 3];
>>> +             activity_monitor->Fclk_MinActiveFreqType = input[idx + 4];
>>> +             activity_monitor->Fclk_BoosterFreqType = input[idx + 5];
>>> +             activity_monitor->Fclk_MinActiveFreq = input[idx + 6];
>>> +             activity_monitor->Fclk_BoosterFreq = input[idx + 7];
>>>       }
>>>
>>> -     if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>>> -             if (size != 8)
>>> -                     return -EINVAL;
>>> +     ret = smu_cmn_update_table(smu,
>>> +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
>>> +                                (void *)(&activity_monitor_external), true);
>>> +     if (ret) {
>>> +             dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
>>> +             return ret;
>>> +     }
>>>
>>> -             ret = smu_cmn_update_table(smu,
>>> -                                    SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
>>> -                                    (void *)(&activity_monitor_external), false);
>>> -             if (ret) {
>>> -                     dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
>>> -                     return ret;
>>> -             }
>>> +     return ret;
>>> +}
>>>
>>> -             switch (input[0]) {
>>> -             case 0: /* Gfxclk */
>>> -                     activity_monitor->Gfx_ActiveHystLimit = input[1];
>>> -                     activity_monitor->Gfx_IdleHystLimit = input[2];
>>> -                     activity_monitor->Gfx_FPS = input[3];
>>> -                     activity_monitor->Gfx_MinActiveFreqType = input[4];
>>> -                     activity_monitor->Gfx_BoosterFreqType = input[5];
>>> -                     activity_monitor->Gfx_MinActiveFreq = input[6];
>>> -                     activity_monitor->Gfx_BoosterFreq = input[7];
>>> -                     break;
>>> -             case 1: /* Fclk */
>>> -                     activity_monitor->Fclk_ActiveHystLimit = input[1];
>>> -                     activity_monitor->Fclk_IdleHystLimit = input[2];
>>> -                     activity_monitor->Fclk_FPS = input[3];
>>> -                     activity_monitor->Fclk_MinActiveFreqType = input[4];
>>> -                     activity_monitor->Fclk_BoosterFreqType = input[5];
>>> -                     activity_monitor->Fclk_MinActiveFreq = input[6];
>>> -                     activity_monitor->Fclk_BoosterFreq = input[7];
>>> -                     break;
>>> -             default:
>>> -                     return -EINVAL;
>>> +static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu,
>>> +                                           u32 workload_mask,
>>> +                                           long *custom_params,
>>> +                                           u32 custom_params_max_idx)
>>> +{
>>> +     u32 backend_workload_mask = 0;
>>> +     int ret, idx = -1, i;
>>> +
>>> +     smu_cmn_get_backend_workload_mask(smu, workload_mask,
>>> +                                       &backend_workload_mask);
>>> +
>>> +     if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
>>> +             if (!smu->custom_profile_params) {
>>> +                     smu->custom_profile_params =
>>> +                             kzalloc(SMU_13_0_7_CUSTOM_PARAMS_SIZE, GFP_KERNEL);
>>> +                     if (!smu->custom_profile_params)
>>> +                             return -ENOMEM;
>>>               }
>>> -
>>> -             ret = smu_cmn_update_table(smu,
>>> -                                    SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
>>> -                                    (void *)(&activity_monitor_external), true);
>>> +             if (custom_params && custom_params_max_idx) {
>>> +                     if (custom_params_max_idx != SMU_13_0_7_CUSTOM_PARAMS_COUNT)
>>> +                             return -EINVAL;
>>> +                     if (custom_params[0] >= SMU_13_0_7_CUSTOM_PARAMS_CLOCK_COUNT)
>>> +                             return -EINVAL;
>>> +                     idx = custom_params[0] * SMU_13_0_7_CUSTOM_PARAMS_COUNT;
>>> +                     smu->custom_profile_params[idx] = 1;
>>> +                     for (i = 1; i < custom_params_max_idx; i++)
>>> +                             smu->custom_profile_params[idx + i] = custom_params[i];
>>> +             }
>>> +             ret = smu_v13_0_7_set_power_profile_mode_coeff(smu,
>>> +                                                            smu->custom_profile_params);
>>>               if (ret) {
>>> -                     dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
>>> +                     if (idx != -1)
>>> +                             smu->custom_profile_params[idx] = 0;
>>>                       return ret;
>>>               }
>>> +     } else if (smu->custom_profile_params) {
>>> +             memset(smu->custom_profile_params, 0, SMU_13_0_7_CUSTOM_PARAMS_SIZE);
>>>       }
>>>
>>> -     /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>>> -     workload_type = smu_cmn_to_asic_specific_index(smu,
>>> -                                                    CMN2ASIC_MAPPING_WORKLOAD,
>>> -                                                    smu->power_profile_mode);
>>> -     if (workload_type < 0)
>>> -             return -EINVAL;
>>>       ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
>>> -                                 1 << workload_type, NULL);
>>> +                                           backend_workload_mask, NULL);
>>>
>>> -     if (ret)
>>> -             dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
>>> -     else
>>> -             smu->workload_mask = (1 << workload_type);
>>> +     if (ret) {
>>> +             dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
>>> +                     workload_mask);
>>> +             if (idx != -1)
>>> +                     smu->custom_profile_params[idx] = 0;
>>> +             return ret;
>>> +     }
>>>
>>>       return ret;
>>>  }
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>>> index 98e01a06add8..6a565ce74d5b 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>>> @@ -1739,90 +1739,120 @@ static int smu_v14_0_2_get_power_profile_mode(struct smu_context *smu,
>>>       return size;
>>>  }
>>>
>>> -static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>>> -                                           long *input,
>>> -                                           uint32_t size)
>>> +#define SMU_14_0_2_CUSTOM_PARAMS_COUNT 9
>>> +#define SMU_14_0_2_CUSTOM_PARAMS_CLOCK_COUNT 2
>>> +#define SMU_14_0_2_CUSTOM_PARAMS_SIZE (SMU_14_0_2_CUSTOM_PARAMS_CLOCK_COUNT * SMU_14_0_2_CUSTOM_PARAMS_COUNT * sizeof(long))
>>> +
>>> +static int smu_v14_0_2_set_power_profile_mode_coeff(struct smu_context *smu,
>>> +                                                 long *input)
>>>  {
>>>       DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>>>       DpmActivityMonitorCoeffInt_t *activity_monitor =
>>>               &(activity_monitor_external.DpmActivityMonitorCoeffInt);
>>> -     int workload_type, ret = 0;
>>> -     uint32_t current_profile_mode = smu->power_profile_mode;
>>> -     smu->power_profile_mode = input[size];
>>> +     int ret, idx;
>>>
>>> -     if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
>>> -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
>>> -             return -EINVAL;
>>> +     ret = smu_cmn_update_table(smu,
>>> +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF,
>>> +                                WORKLOAD_PPLIB_CUSTOM_BIT,
>>> +                                (void *)(&activity_monitor_external),
>>> +                                false);
>>> +     if (ret) {
>>> +             dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
>>> +             return ret;
>>>       }
>>>
>>> -     if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>>> -             if (size != 9)
>>> -                     return -EINVAL;
>>> +     idx = 0 * SMU_14_0_2_CUSTOM_PARAMS_COUNT;
>>> +     if (input[idx]) {
>>> +             /* Gfxclk */
>>> +             activity_monitor->Gfx_FPS = input[idx + 1];
>>> +             activity_monitor->Gfx_MinActiveFreqType = input[idx + 2];
>>> +             activity_monitor->Gfx_MinActiveFreq = input[idx + 3];
>>> +             activity_monitor->Gfx_BoosterFreqType = input[idx + 4];
>>> +             activity_monitor->Gfx_BoosterFreq = input[idx + 5];
>>> +             activity_monitor->Gfx_PD_Data_limit_c = input[idx + 6];
>>> +             activity_monitor->Gfx_PD_Data_error_coeff = input[idx + 7];
>>> +             activity_monitor->Gfx_PD_Data_error_rate_coeff = input[idx + 8];
>>> +     }
>>> +     idx = 1 * SMU_14_0_2_CUSTOM_PARAMS_COUNT;
>>> +     if (input[idx]) {
>>> +             /* Fclk */
>>> +             activity_monitor->Fclk_FPS = input[idx + 1];
>>> +             activity_monitor->Fclk_MinActiveFreqType = input[idx + 2];
>>> +             activity_monitor->Fclk_MinActiveFreq = input[idx + 3];
>>> +             activity_monitor->Fclk_BoosterFreqType = input[idx + 4];
>>> +             activity_monitor->Fclk_BoosterFreq = input[idx + 5];
>>> +             activity_monitor->Fclk_PD_Data_limit_c = input[idx + 6];
>>> +             activity_monitor->Fclk_PD_Data_error_coeff = input[idx + 7];
>>> +             activity_monitor->Fclk_PD_Data_error_rate_coeff = input[idx + 8];
>>> +     }
>>>
>>> -             ret = smu_cmn_update_table(smu,
>>> -                                        SMU_TABLE_ACTIVITY_MONITOR_COEFF,
>>> -                                        WORKLOAD_PPLIB_CUSTOM_BIT,
>>> -                                        (void *)(&activity_monitor_external),
>>> -                                        false);
>>> -             if (ret) {
>>> -                     dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
>>> -                     return ret;
>>> -             }
>>> +     ret = smu_cmn_update_table(smu,
>>> +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF,
>>> +                                WORKLOAD_PPLIB_CUSTOM_BIT,
>>> +                                (void *)(&activity_monitor_external),
>>> +                                true);
>>> +     if (ret) {
>>> +             dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
>>> +             return ret;
>>> +     }
>>>
>>> -             switch (input[0]) {
>>> -             case 0: /* Gfxclk */
>>> -                     activity_monitor->Gfx_FPS = input[1];
>>> -                     activity_monitor->Gfx_MinActiveFreqType = input[2];
>>> -                     activity_monitor->Gfx_MinActiveFreq = input[3];
>>> -                     activity_monitor->Gfx_BoosterFreqType = input[4];
>>> -                     activity_monitor->Gfx_BoosterFreq = input[5];
>>> -                     activity_monitor->Gfx_PD_Data_limit_c = input[6];
>>> -                     activity_monitor->Gfx_PD_Data_error_coeff = input[7];
>>> -                     activity_monitor->Gfx_PD_Data_error_rate_coeff = input[8];
>>> -                     break;
>>> -             case 1: /* Fclk */
>>> -                     activity_monitor->Fclk_FPS = input[1];
>>> -                     activity_monitor->Fclk_MinActiveFreqType = input[2];
>>> -                     activity_monitor->Fclk_MinActiveFreq = input[3];
>>> -                     activity_monitor->Fclk_BoosterFreqType = input[4];
>>> -                     activity_monitor->Fclk_BoosterFreq = input[5];
>>> -                     activity_monitor->Fclk_PD_Data_limit_c = input[6];
>>> -                     activity_monitor->Fclk_PD_Data_error_coeff = input[7];
>>> -                     activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
>>> -                     break;
>>> -             default:
>>> -                     return -EINVAL;
>>> -             }
>>> +     return ret;
>>> +}
>>>
>>> -             ret = smu_cmn_update_table(smu,
>>> -                                        SMU_TABLE_ACTIVITY_MONITOR_COEFF,
>>> -                                        WORKLOAD_PPLIB_CUSTOM_BIT,
>>> -                                        (void *)(&activity_monitor_external),
>>> -                                        true);
>>> -             if (ret) {
>>> -                     dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
>>> -                     return ret;
>>> -             }
>>> -     }
>>> +static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>>> +                                           u32 workload_mask,
>>> +                                           long *custom_params,
>>> +                                           u32 custom_params_max_idx)
>>> +{
>>> +     u32 backend_workload_mask = 0;
>>> +     int ret, idx = -1, i;
>>> +
>>> +     smu_cmn_get_backend_workload_mask(smu, workload_mask,
>>> +                                       &backend_workload_mask);
>>>
>>> -     if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
>>> +     /* disable deep sleep if compute is enabled */
>>> +     if (workload_mask & (1 << PP_SMC_POWER_PROFILE_COMPUTE))
>>>               smu_v14_0_deep_sleep_control(smu, false);
>>> -     else if (current_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
>>> +     else
>>>               smu_v14_0_deep_sleep_control(smu, true);
>>>
>>> -     /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>>> -     workload_type = smu_cmn_to_asic_specific_index(smu,
>>> -                                                    CMN2ASIC_MAPPING_WORKLOAD,
>>> -                                                    smu->power_profile_mode);
>>> -     if (workload_type < 0)
>>> -             return -EINVAL;
>>> +     if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
>>> +             if (!smu->custom_profile_params) {
>>> +                     smu->custom_profile_params =
>>> +                             kzalloc(SMU_14_0_2_CUSTOM_PARAMS_SIZE, GFP_KERNEL);
>>> +                     if (!smu->custom_profile_params)
>>> +                             return -ENOMEM;
>>> +             }
>>> +             if (custom_params && custom_params_max_idx) {
>>> +                     if (custom_params_max_idx != SMU_14_0_2_CUSTOM_PARAMS_COUNT)
>>> +                             return -EINVAL;
>>> +                     if (custom_params[0] >= SMU_14_0_2_CUSTOM_PARAMS_CLOCK_COUNT)
>>> +                             return -EINVAL;
>>> +                     idx = custom_params[0] * SMU_14_0_2_CUSTOM_PARAMS_COUNT;
>>> +                     smu->custom_profile_params[idx] = 1;
>>> +                     for (i = 1; i < custom_params_max_idx; i++)
>>> +                             smu->custom_profile_params[idx + i] = custom_params[i];
>>> +             }
>>> +             ret = smu_v14_0_2_set_power_profile_mode_coeff(smu,
>>> +                                                            smu->custom_profile_params);
>>> +             if (ret) {
>>> +                     if (idx != -1)
>>> +                             smu->custom_profile_params[idx] = 0;
>>> +                     return ret;
>>> +             }
>>> +     } else if (smu->custom_profile_params) {
>>> +             memset(smu->custom_profile_params, 0, SMU_14_0_2_CUSTOM_PARAMS_SIZE);
>>> +     }
>>>
>>> -     ret = smu_cmn_send_smc_msg_with_param(smu,
>>> -                                            SMU_MSG_SetWorkloadMask,
>>> -                                            1 << workload_type,
>>> -                                            NULL);
>>> -     if (!ret)
>>> -             smu->workload_mask = 1 << workload_type;
>>> +     ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
>>> +                                           backend_workload_mask, NULL);
>>> +     if (ret) {
>>> +             dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
>>> +                     workload_mask);
>>> +             if (idx != -1)
>>> +                     smu->custom_profile_params[idx] = 0;
>>> +             return ret;
>>> +     }
>>>
>>>       return ret;
>>>  }
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> index 007a81e108ec..8f92b2777726 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> @@ -1221,3 +1221,28 @@ void smu_cmn_generic_plpd_policy_desc(struct smu_dpm_policy *policy)
>>>  {
>>>       policy->desc = &xgmi_plpd_policy_desc;
>>>  }
>>> +
>>> +void smu_cmn_get_backend_workload_mask(struct smu_context *smu,
>>> +                                    u32 workload_mask,
>>> +                                    u32 *backend_workload_mask)
>>> +{
>>> +     int workload_type;
>>> +     u32 profile_mode;
>>> +
>>> +     *backend_workload_mask = 0;
>>> +
>>> +     for (profile_mode = 0; profile_mode < PP_SMC_POWER_PROFILE_COUNT; profile_mode++) {
>>> +             if (!(workload_mask & (1 << profile_mode)))
>>> +                     continue;
>>> +
>>> +             /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>>> +             workload_type = smu_cmn_to_asic_specific_index(smu,
>>> +                                                            CMN2ASIC_MAPPING_WORKLOAD,
>>> +                                                            profile_mode);
>>> +
>>> +             if (workload_type < 0)
>>> +                     continue;
>>> +
>>> +             *backend_workload_mask |= 1 << workload_type;
>>> +     }
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>> index 1de685defe85..a020277dec3e 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>> @@ -147,5 +147,9 @@ bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev);
>>>  void smu_cmn_generic_soc_policy_desc(struct smu_dpm_policy *policy);
>>>  void smu_cmn_generic_plpd_policy_desc(struct smu_dpm_policy *policy);
>>>
>>> +void smu_cmn_get_backend_workload_mask(struct smu_context *smu,
>>> +                                    u32 workload_mask,
>>> +                                    u32 *backend_workload_mask);
>>> +
>>>  #endif
>>>  #endif

