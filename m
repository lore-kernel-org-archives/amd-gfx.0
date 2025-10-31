Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09ED7CCF9FE
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 14:07:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97F5D10E082;
	Fri, 31 Oct 2025 14:07:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mPmgSwr/";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013060.outbound.protection.outlook.com
 [40.93.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95B4610E082
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 14:07:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6ub0Q4MsRgH2W/5up1y5XpxUv7kCIOxid4oWjhqHAGkEFy54mw2H2aIRx1Vcf7U2sM0w22Se/XV97o+hxSCmALQEX1t/CzAbPfbZeIuXA9mjzZMTd5MdFjw+z0wqmInc5GCdAaQxzfF2DnyevsEVQh+rbYWUmYFg1wiNAzeLP7zkEA0B+VpePct1mfkPPAGtZOA+0xHuefGTwCUPazoH20B3gu9girBpK0tTdgw5fcz+pdORf6jqg4+7R7+Qy0hn9npLZuwvM8Yh8bsO5dNrIHpMIkJtRSlPSWNlADF5KV97JHeYW+KkbT56HYAE/HlpqNRq5WkxFScnbbDK/IIyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DhdD7DYpLfv8iLFCHw93spBj6g490bb64KPCEbbrP0=;
 b=ufEFvSDUwjFWdYmQYFNKHOu0XNSigdWy0rHnDmVltUmr8XqTVsqFteUBWmwYWJ8v9O1y1YTDsVSRctSMOnd6t7w7zf3yBe7a8wuCPUCi3xzhZ99/NlXDghPlz09PWRaB+O2n6rr9VkLdaV7H2/+O6qechoZoV0SFsN2eqZsQn5ucUgvuRhiIJL+AEJi9FETZ0l5ssCjTT3bXXenrqJiHuFwF0UP9qHeyAJZYbKQmM3ub/geoUccgF2odAhPygODkCNnGJHQ7KbGFzfhany9q7IyDibWo4lIQsOuUDeeSMkPknrw9UkYA8CHxY2VcsEdxAt+t3c11VldpFdyjNNLPCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DhdD7DYpLfv8iLFCHw93spBj6g490bb64KPCEbbrP0=;
 b=mPmgSwr/In4/s+RvbTFxtCRX6DkoYn7S13US+a87B2QdgasRnDRlAIMhZN7LukW/jAiZA28gMTgMlE6z4cuj95nBq2AHoBtod93bZAumlQkYGTHbOrNRnAYaoeF7IKRLPCJvN8HafGbmMra+dnWEcBdajreW83M37mccXW8US8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS0PR12MB9040.namprd12.prod.outlook.com (2603:10b6:8:f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 14:07:24 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9253.018; Fri, 31 Oct 2025
 14:07:23 +0000
Message-ID: <f5dc6a49-57c0-5198-8fcd-96ccad21dd7d@amd.com>
Date: Fri, 31 Oct 2025 10:07:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdkfd: Fix GPU mappings for APU after prefetch
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 Harish Kasiviswanathan <harish.kasiviswanathan@amd.com>
Cc: Philip Yang <Philip.Yang@amd.com>
References: <20251030010027.2503555-1-Harish.Kasiviswanathan@amd.com>
 <bf4723fe-24f8-43d3-95b6-302015c26b46@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <bf4723fe-24f8-43d3-95b6-302015c26b46@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0188.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::31) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS0PR12MB9040:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d09d0eb-7078-4d5a-5432-08de1886d011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3VpUkhUaXd5WkxOUDVDeUdkWFdZdVdqOU1sbUFIcVpSTkpuOC9VbWhacjhK?=
 =?utf-8?B?SDB3SEVBSTRxSEZLb05pSjVKUjRNUUJURmpEYS80elNLcVRzaUQzUmp6UC9m?=
 =?utf-8?B?dlJRMUlzeGNFM2FIRm5TNjN0Vk5hcU9OZzFkUTBGQzVKSXZNOGFtak9HMWF0?=
 =?utf-8?B?MTBLY3o3c0tleDIyU0UrTGFaZjFqUjhlR2NNZGw4WXBXOGZqc0dVTHBhcjR1?=
 =?utf-8?B?ZTVUZU1LSzl3QnhhdnJYNWRWMTRYMGhySnlJNWxFQXYxajZ4dTd6cmwxUVRr?=
 =?utf-8?B?UGwwcVhlQ1Vwc3VQU3BJYUFvMklZdXlLV2UrZnhxKzRweG85MFJSM3hMdFhk?=
 =?utf-8?B?dm5rT09tR05MWmhOTEpjcjRLNzFSd3ZZMUlQSHMwWHdIYzJnYVRTZDFBNE90?=
 =?utf-8?B?aDhUZE9zMVNEZUh5Q3Vod0N3S2FvS0ptcWFlMVRkanZ0MnVRTER0alRVayty?=
 =?utf-8?B?TE16ZWNRdnZlWlFvZzVGdEpCbkI2dkxZSUV5SEtuTnlTa3AyREFnbFZLQVNs?=
 =?utf-8?B?S1ZJZ1ZWaGZ1OW9WeEovNFJmZ1N2bW5xTUxtbGtYVG8zWmZ5aThpMVZSbVRM?=
 =?utf-8?B?TkpBdFVabWxTTWxDNy80MkpRZ0oxc2NQVEw1SERJcjFIbHRmQUIvVnUwNU9M?=
 =?utf-8?B?VGVjSjJDWTE2WVVSTURCTU1vdEpNaEVlY2p0QWJVOXZ0UHhYbi81TzVadTZ0?=
 =?utf-8?B?NHhjQkw5dVJrMWlFWFpSMDllMkxoajdJeXEwOVcyelcyU1lNSXBwWmZBYmh4?=
 =?utf-8?B?M0NCKzVKRUNsMFhpalBMT00vcURsWGlKNXptYllqMEEvYkxpeW90S3V4aU81?=
 =?utf-8?B?bERSNEMvWjV0TDB5dG15VnBmV28rbi9FODF4blRINXYyMHlCSXdDTkhxYzlB?=
 =?utf-8?B?RkdSZXgzdHFxVHZZeUI2Sy8xOGxBcGhLT2JjWUpya1pISWY1aUxhZHA3YWdJ?=
 =?utf-8?B?OHhrQWdUZVQvVDFYdHRZZkZMZkMvSTQ1dzBDWldEekpEVVdtQnhGejJzZU90?=
 =?utf-8?B?SCtGTkZuaHFxSEtBVUJoMHJDKzN1dHZGbzREbmVKRSt3ZzFEcTRzY3htWGtW?=
 =?utf-8?B?bHYvUFFvaUljVTRaaityYzFWcWF3WlBENlVBN3VtR1lpWkYrcjhxSkJrQS9M?=
 =?utf-8?B?OTVaYkZXQUNPRUlvZWZXZ1pYMDRzRitLaGFNY2dYTFo5aG16RG9hVEdPd2M1?=
 =?utf-8?B?akFUa2hCSXI5OHVMRnhxNHkvMlEvdGJoMEx3SzUwUU1LbCtyMkJkT0IxNXZB?=
 =?utf-8?B?UFY5RCtHQ214YjR5OTRkaWNxOHRLMFhBa2N0S1cvODJCUE5oZGF1MzFlYVll?=
 =?utf-8?B?by9ZczhzM3RqSzVBQjE3bHNETWNlTmRIVCtGR0ZPSE5hWjQ5SndtNDB1Z08y?=
 =?utf-8?B?NXVWVlgveEhhWnhiaVArUk1DUmxrM0ZVVDBPVjJyYTk4djJmYnlpcjM2R1Fk?=
 =?utf-8?B?SW5ZYmlSY2NlbnFHZDhNamF2LzJoQkF0U1AvUVp6WVVWcjEyUkJzU09qRFhT?=
 =?utf-8?B?OW84cGhBcHdOSllvUnRzeUhaSi93ZlprNk0yUWhBVm8xM2JRY1dJMGxuMnVi?=
 =?utf-8?B?ZjM5ejVxYW91UWUxVU1lb05nRTh3SHhnQUlXWEM4U3ZPM0h1Q2NYQ2ZObEtJ?=
 =?utf-8?B?d3BRWWVKNCthY2xqWlBVVjVBVE43dzE1Z3dVb0dZMHMwZ2FWU2x2TTBEVWU5?=
 =?utf-8?B?aVVBN3VrUk5sS21xQzZPT29FVlVXUGF4Z0FNWUY3QWpoS1l2UkJ0UGs4ejZK?=
 =?utf-8?B?Vm94Qm95YnVzNE1pTDBWQXJMNGhnS0ZoNy9oa0FlZHJZNFVsTVNMN3lna0li?=
 =?utf-8?B?R1JwU1hHQVdVSGpOV0NrZW43NzVOOWJqSHAyVURPVkw2M0VJMFZJS05OdkFv?=
 =?utf-8?B?M2ZxczF2TUx3YVNYbU96dWEyQkNGcWxBMjlJRC9CdVEwN0daMlJVd1JPditj?=
 =?utf-8?Q?Eb/OYLpOpTAtHscsbgpA5vHqkKjPoTD1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y281R2lqVHNIcHM1VFZlcDdiSTJaRllqWXdXak5NTFlTU3NsUnVpQko4VWFP?=
 =?utf-8?B?OW1rOThEc1hWUy9ma2U0OUx6NDBSNC91am5HUjhnN0JhTktNWFoyeTFqNGpy?=
 =?utf-8?B?RS9OQWw0SStyLzRhc3lvUCtZbklvK2RoZUpWb2lBWW9ZWXdDSjlkZFBjTzVG?=
 =?utf-8?B?ZlRFcGVtcDlVV0JvU0E0UVA5RHQ4Nk5hVndZSGZqb085S0JmK1AyYTg5ajNv?=
 =?utf-8?B?NkFrd0tUZWVmSG1Sb2d1aDBJT3BMYmQ1cUJaVXQxWmNUQzRvQnExTklhL2pJ?=
 =?utf-8?B?MlRCcXZNNlJ1Rmx2UGFMZ05FK2dMb0VQOHJsdG1UOFZWbk5QNlJVdXJjUVBY?=
 =?utf-8?B?Tm05RGowRkJTQzVnYy9XZmJ4djZ4aHFoSjRVaUM2bFh2KzFGRVZQTDBtWHJM?=
 =?utf-8?B?M0taMzNoSHplK1lZMUVJcnVaVkVibzgyRyt3bjFrRi96eTdVSUM1eWlwSXo1?=
 =?utf-8?B?OEc3N25STHYvRHV1alNXSS81TUtVVTQ5dDd6cE1aSm04M01IRlpvWHYrRHh3?=
 =?utf-8?B?ZkJVeDFlYzlRUW0xVHRkclhVMHNkeS9KSnRVNzJpUHA3WGFXc0luTzAzbklI?=
 =?utf-8?B?MHBZL3dxM2FVaUtmQVVybVNiRUFxL0Fja1Q5VVExNGRSRm96K3JEeGp3MHVT?=
 =?utf-8?B?eEZXWjhCendoVE12UFo2MUI1Rm9hYm5rcEtZOFNHM3pRNWZSeGY2RzVXcS9z?=
 =?utf-8?B?WVljVklWSGVGSEo1aVNXV0hueHhxRXFLWmFuMkFUTFlvRDNla24zRnVmaWMx?=
 =?utf-8?B?L2JDeGJSTGMzeDVHT1ZiWG5kVnJmV2xjaGlVRzVtd2Q5eDlPc3dqVFJ4WXVT?=
 =?utf-8?B?OTA0MzU2ajBNcHV0QkZmOUdvSXNsM0ZBcVdhRDQzR0JXdnpIbU1CNUVPQmNX?=
 =?utf-8?B?Q3ZOQ0greDVBOU9RN3U0a242TWhNYkkyT3RZVTJkWWlkckNKblRIWnRoZzRj?=
 =?utf-8?B?b2JMNkpOc3grZnQ3ZTVRNFBlWU5uTXM1aUlFUVRyMUNUTGZRQXRhdTgxejVL?=
 =?utf-8?B?VUY1ZTV4UjduYmdqSS9NWWhTbktxdmdCN0xYbjNoaW15cnYxVDE1RjNUZzZL?=
 =?utf-8?B?SHdJRDcxL3drOWIzekZWL0VmZnBiVFNYeVBzanMzV2FzTW95dkVHQWhHMEtn?=
 =?utf-8?B?emYrVE1OSndGWjdteXVKM1hpNXBkVjFLeURnTnMrenY5c3E1Q09oS2hCRCt5?=
 =?utf-8?B?VDk5Z3pVRGlid0tFWmdHb2RXMmFaaTJGcVhRaGtxNjJsQ0hXaUVQREFSb1c2?=
 =?utf-8?B?QlBySWtTNDdGWVY0MjE1U1NNZlVwaDliOXNBc0wyOUR2SXJLaVcrRzlSWHB2?=
 =?utf-8?B?VlVMUXJYR0tOSHdsSzBCaGpVbnJmMzJNUTZxaklYeTF3SG1Tc2paR0JxRFR0?=
 =?utf-8?B?VWNBeEpsNkswbHhOTlN2MFhBQ01wcmR0WStEN2FhYmMySjhpVjhqMUtZUUVi?=
 =?utf-8?B?eGl3bm1iaFF5UGFHMWIxVkNWR012QUhuZTdGZWl3eFExQ3dQU1pZdkM3RjJz?=
 =?utf-8?B?Z2JIR2czL25QUVcrSEZIeDdLemwvY0ZXREo0VjljaWgwQ1YvTU5PTWdnUVRr?=
 =?utf-8?B?QmlLaFBObVN0ZCsrMG10NStpbHFEbStPYTNhSlorbFo5NEhBMktYOGY5d211?=
 =?utf-8?B?VHJ5ajZLTVNHUG85RnFvRytHdDhuTzVtMWdtOVRuNzBodEpHSGdxc2ZJTnUv?=
 =?utf-8?B?MUJzRXNOSU8ybnF6bmR0dXFNeWFTZStzY0IxSHNiZHpweGNXd0h0WE84U011?=
 =?utf-8?B?Tm5rZjB1Q1AwUjhOWnRlMlZjWCs2SWdENmREZHpNOU5qOHovYm8zS2U4bSty?=
 =?utf-8?B?WlptM28zdU4vbnFwYW9WU3E2TXlWM2IyTkh4VGxIYnBmL20va1FkUFR5S2I4?=
 =?utf-8?B?ZnRGNlVHUzNyaXR3UWxVM3VFVk5yaWZpSnY0NS9RbHFib0ZLenhaSFZURDdw?=
 =?utf-8?B?UjJkMHdLNjMxSTVkalFHYkpMbkNDTy9RVGJXSGNESTdhWmducnFRODV3SUtr?=
 =?utf-8?B?ZyttQ2p1VVZBWnVpOWNNK2tUeGI3VjE4NXdWUFdTMXJ6cVlPQjVPWFZvaDBv?=
 =?utf-8?B?ZWtJdEFhUkxveFJOcSt3QjN3VFdrdGVjM0VqN0hDdjkwOEdmYkU2ZVNkdTdJ?=
 =?utf-8?Q?J8IPzbnTirD+GOXlq1fbyynsK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d09d0eb-7078-4d5a-5432-08de1886d011
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 14:07:23.0996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bJcxQvgSM3QwQ0qcHZI7E1ZV5ERnSQmCwscxm+isAc/s330JQqVPlRRJdPhJREF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9040
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


On 2025-10-30 18:39, Felix Kuehling wrote:
> On 2025-10-29 21:00, Harish Kasiviswanathan wrote:
>> Fix the following corner case:-
>>   Consider a 2M huge page SVM allocation, followed by prefetch call for
>> the first 4K page. The whole range is initially mapped with single PTE.
>> After the prefetch, this range gets split to first page + rest of the
>> pages. Currently, the first page mapping is not updated on MI300A (APU)
>> since page hasn't migrated. However, after range split PTE mapping it not
>> valid.
>>
>> Fix this by forcing page table update for the whole range when prefetch
>> is called.  Calling prefetch on APU doesn't improve performance. If all
>> it deteriotes. However, functionality has to be supported.
>>
>> v2: Use apu_prefer_gtt as this issue doesn't apply to APUs with carveout
>> VRAM
>>
>> Suggested-by: Philip Yang<Philip.Yang@amd.com>
>> Signed-off-by: Harish Kasiviswanathan<Harish.Kasiviswanathan@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index c30dfb8ec236..76cab1c8aaa2 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -766,14 +766,21 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
>>   {
>>   	uint32_t i;
>>   	int gpuidx;
>> +	struct kfd_node *node;
>>   
>>   	for (i = 0; i < nattr; i++) {
>>   		switch (attrs[i].type) {
>>   		case KFD_IOCTL_SVM_ATTR_PREFERRED_LOC:
>>   			prange->preferred_loc = attrs[i].value;
>> +			node = svm_range_get_node_by_id(prange, attrs[i].value);
>> +			if (node && node->adev->apu_prefer_gtt && !p->xnack_enabled)
>
> I don't think you even need the condition based on apu_prefer_gtt. You 
> can always set update_mapping. If you are migrating, it would update 
> the mapping anyway, so it shouldn't make a difference on dGPUs.
>
For dGPU xnack off case, prefetch range migrated, we should use restore 
worker to update mapping, yes, you are right, if migrated and xnack off, 
set_attr will skip update mapping regardless update_mapping true or false.

Thanks,

Philip

> More importantly, I think this may apply to other attributes as well 
> that result in splitting of a range without causing a migration. So 
> this condition could be moved outside the switch-case block and the loop:
>
> 	if (!p->xnack_enabled)
> 		*update_mapping = true;
>
> I see we already do the same for the access attributes. Just 
> generalize it.
>
> Regards,
>   Felix
>
>
>> +				*update_mapping = true;
>>   			break;
>>   		case KFD_IOCTL_SVM_ATTR_PREFETCH_LOC:
>>   			prange->prefetch_loc = attrs[i].value;
>> +			node = svm_range_get_node_by_id(prange, attrs[i].value);
>> +			if (node && node->adev->apu_prefer_gtt && !p->xnack_enabled)
>> +				*update_mapping = true;
>>   			break;
>>   		case KFD_IOCTL_SVM_ATTR_ACCESS:
>>   		case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
