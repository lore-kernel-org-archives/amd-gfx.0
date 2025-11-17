Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AA8CEACEF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Nov 2025 15:01:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6936D10E16F;
	Mon, 17 Nov 2025 15:01:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BYu4Zn0E";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013035.outbound.protection.outlook.com
 [40.107.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5A6F10E16F
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Nov 2025 15:01:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uto72DjwZ3lytgN91m0VJQ7sgCmBzYY3n5xG4F4NEhstpfyZNipRdLiobBgb/ESpB0fOYLSpxMKXoAmbbEPjPw0LY9oRSE8qdi1Lj7m/6gMsUvknX/GBPSiuihsHJeAW9rwzkSt6vjRWIfJ45k3URLJCL1tpyKVgbRC6e9Fq/cH5hR64XezA21BjapzpT2F5SoI/QvRHX4K4R5S2kBrEaUraLkP8Vd22YVpURX3f6pXrLah/tsaf9scBti3wCayuIgL0XMYzsfVJbvdCX0itNb55yw3LevVNPOxhyVpIk38l7qHVOzxGWoLeS4AlCxNqpdjWRCr1qOnwgkMChnd3/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbgqsS8Opxz2z7dS9nqxWQ/WIU30+9YRoPXm377iEs0=;
 b=HSG9ksA0e+apIA3Xlis/SkF4N+ocwhwAqkjQ5mbWJsNoGqU/Kmrerlcd9BJEDf1oj9KdW1ci9ej02vuySV9U/uVMezB4npixK4P6QvvW5LEtcPfu81jM17zjLw5eVcv0UeQh2+Sd4W29BVfYJpJidtT8eRKxmJXSyRdkthvGZGfC2Kd7VGB9vzkkE4RJ2xiVxF1s0+ihYYSGSEyJ4hbaUV0zDAUBzRzWqO2yVk6VeyugEWqiKsUAeLsrkP2s5BGVACy3wID6H8y+AiZxl/ADhVPSF0GqATWD0ExMiK30yBRN2WGbQqrP9X+NK+0/L2702239SHEuB0x2Vngvjh0fqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbgqsS8Opxz2z7dS9nqxWQ/WIU30+9YRoPXm377iEs0=;
 b=BYu4Zn0EvhJK0OsXY9mF6O+q5Jj06K1reFJKTLOrEekf5tto7rpqd2H5sPGkkgcazoea8rXF6b1/NoLmNTAa/FQedQwJbcnsj39nzmSenvu5KmD18UMf3EM6+EkaE5m5cz6AzjCjx0h8IMFFNWpGk44HZy4Uj6EkZ2CdcitZ6mA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 15:00:58 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 15:00:58 +0000
Message-ID: <1421dbc3-c800-330a-2b30-3a359b9ef9af@amd.com>
Date: Mon, 17 Nov 2025 10:00:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdkfd: Use huge page size to check split svm
 range alignment
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251113210955.352373-1-xiaogang.chen@amd.com>
 <c87b788f-65a6-468d-b100-2295eb284489@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <c87b788f-65a6-468d-b100-2295eb284489@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::21) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS0PR12MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: 038cde56-d8f1-4749-f90f-08de25ea1da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3RieDJwNW15bHYyMThIRTZXclR3NFgvYko5MCtZUllhKzRTZGdWR1kydTZW?=
 =?utf-8?B?aEFyZ1VXTjZFamx5TDBaNkpYWmxLNzR0Zno3aVcvU2lGU0c5Y25YMVFZbzds?=
 =?utf-8?B?R08zQjBpcUJWQXV5TVZaOEh3dnVpcUQyaHM2WTdLOUMrT2tsUjNPcnlIK2Rv?=
 =?utf-8?B?NVJtM2sxdFE1S29JYkYyS2I2eE05R3lwUDNRQUorZGY1WW9QMWx0OHBjQWR5?=
 =?utf-8?B?VnlrbG9nYTVrVUlHcFRSQU92a09TT1dEdXc5bUNZWnNibm42dkVWRjYwLzNr?=
 =?utf-8?B?RHVSVVNNU1VFWmRhL1dBQy9YdmJQU1NNQjNiRnJFU0p1MXhya3JLZUV3V0RV?=
 =?utf-8?B?bmNmaWdzNkNjOC9tVlBwWUhpMnlqSlR1MjcrVzFxMmt5U1BxeEh5bHUwTmpy?=
 =?utf-8?B?NFlHdWZMM2lCSUJlTG1tZFBqVVRxbHJVaUQ1ZFd0MzVnVGV4bU9FK1A1YWph?=
 =?utf-8?B?cXNpTGovcTlsbkdkTklvbWw5Y1ArM01DNHBDRUk5eUtxb1F3MTN4aVptS3BC?=
 =?utf-8?B?cjJVL0c3QllwdWJWZGlHRTNYWlY0Q2xsSWR4ZGtseis4TXBaZ240UUNEYnhO?=
 =?utf-8?B?ZlFWOEZNRk5UMTQyV1BobDlsbHp5OTY4ekJYOWFUWU5tVlNvN1orZHI1cmxH?=
 =?utf-8?B?OVA5TEVPSUVaZW5mdjREQUdBc0FoMWJUUmxaaGJKUTlOWFkzNjNGaVNhT29D?=
 =?utf-8?B?ZXZ0S2JNejhnQWVncmRSNktkRElWbll2elBreWg5ajVTbDNyRWdEUURwd0tH?=
 =?utf-8?B?SWQvS0xVdGN5dVNjS01mVmdBckg3eVlNWk5PTXhWRUs2bWtldHFhb3kvL21F?=
 =?utf-8?B?ZDBpMTJNVm1zTS9MTU12WWFwSDhyZS9PS0JlK1NPeldwZmlLZ2lnUU83Mmpx?=
 =?utf-8?B?UXhGR285ck9RTmg3ampyYTdUTFd4SHIvZFZkS2lmYVdmQkFqZS8wVk5kRE9R?=
 =?utf-8?B?M1JOTTNkSTc1MFpkbmhrM2pMaDlwblU4ZUFUdWNhZkxmMjZ2dVQxbnErNDBM?=
 =?utf-8?B?dDVmNHV5eG1kYTcyMWNkZ015QU5FL2lUa2h1Vnh2ZUJ0amNCeXdiYVo1VW5R?=
 =?utf-8?B?NWV5N1Bzd3dBUTJpUXZFbEEyZFMzRDF4VWI5VHRVdURBZDNLUCs4Wm5sS1Zr?=
 =?utf-8?B?b3F2UmdVcS9ERGpvb3BHNkl2TzRlb0I0eFM4ZlVINk11V2hYUFlkYmVUdkVE?=
 =?utf-8?B?enpjZExtSjU5Si9WMXplRGlCRXlWdHhIV0p1cEpDR0VoNkQzU1hWS2JNdERu?=
 =?utf-8?B?R05ubUZJclRWS242cEh3ZUp6NzJQb3M5WHJ4VFUyQ1FhbHptYVZaNHRCTHFj?=
 =?utf-8?B?ZEppYkFoZnIyRE9pblJlelFKQjdhNmRtQytYanpyR2pOcWxDUmIxS0JvN29L?=
 =?utf-8?B?cmhCc01rTUtPM3h1emx1TDEzRGprK1ZkSHpxaHBFOEJpdm03QUVtZDVjNUND?=
 =?utf-8?B?dyttK05iRU4yVE0vbmMwMXREYXhCYjZwSGE3RmRGby9pNEJIOUJHdnZSYnY2?=
 =?utf-8?B?YlQ3UGF1RXNLcWxjSm1raVNNRWtjVWFFdXZ2anhoOVVONkRlTW9ja3ErZDcz?=
 =?utf-8?B?YWpNQjRIeTF1bXg2OHVmYm9JRHRhQ29ObzVqaG9KckZmSGw2a2pxQW14K2dX?=
 =?utf-8?B?MTYzMWFnelBoRFJ5TjY5aWFNZkFuVWFva0N5WnZzdjQ2UWVQSkVTeDcxQ0R2?=
 =?utf-8?B?aWVuMVVFS2pWR1B5MlI4ZnJNM2ZBSVlRSE1XbXlDOTJsS0dLdEk3UlRuQUtO?=
 =?utf-8?B?amw3ZWJxWjErNFBYYlJPWWVSMmtJcE84WUxsUzl1Nk1LNzdqc1FlZlVCQWlP?=
 =?utf-8?B?YW51RHo3anI3b1RlaFVvSEo5d2NOVE9uRk5MZzFhZ0ovT0hhUDJlSThhN2Ru?=
 =?utf-8?B?UFlVWHMyQ3ZQVUFaRGlpN2hjU2JZN2pzV2U4eFVqU3JEZmV6OXUyOXR4VUg1?=
 =?utf-8?Q?uqLm/Pa6x5KTl+TGif/uWgRJJs0IaMX7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ci9iYVhkVUVyTUdIVnhxNWNuYjQrU3dwTjN4Q2czQWt3OTBGNFpzWkxaN0Jp?=
 =?utf-8?B?YUtndTY4TVZqaUJTYU41SHhVQ1NyUUZxQTEwTEdNenFiZ3dBQXRCR01CQzVJ?=
 =?utf-8?B?bGcvK3A1Wm5BV1dlaFlDMlovQ3FFZm1DQWNmWFdPWUQ4dm9QaDA2TFgzR2NR?=
 =?utf-8?B?aHEzVmNuelhrOWptNU9VWjI5RUZEaGdjRFVaaDJSYlVUaW9oM1hLRVNYTi9L?=
 =?utf-8?B?bHVDMDRNaGZrUXc1U1NkVXB5UFYwcHV5MTk5bUM1TDE3eGY5SFF3SDN1aExu?=
 =?utf-8?B?TGkyYlF1NTBzemZodVlRSTBwNmlPWUxwMkVLVGlZREw1cGNObVNkN2o4Y29U?=
 =?utf-8?B?RGlOWCt4TFVWZzJnZXljQnNHQUJVYzBycXFobzJnWVkxWTRwUUlvTmRUZ1Zh?=
 =?utf-8?B?M0lweCszemtCcjNYdWZQRFFBK1NXN2FmSnB0Uk82MDZEZHZ0OFJlTUtwaGxu?=
 =?utf-8?B?M1ZleXNkcERDMERCK08wRHhvYkwrTHpiVTNERktiT2R0aFFzbS93S0hjcjd2?=
 =?utf-8?B?Wlc1TlFud3NDcTFndHlhWFlKSzBKUW9JNFZ4ZWRwc29XLzFvWHVuME8zQVMx?=
 =?utf-8?B?VzFuS3gvVFFDb01tditRMGErQjhQSzVHV3dURHZpRFpXS1c3NGJBOGlTdjRv?=
 =?utf-8?B?Vm1mTGJKdjJUVUpuMzIxc2NRN210MUtyU1ZEZ3VXdlJtVkdvY21QUkxwMTdp?=
 =?utf-8?B?QVg1K2ozdmhDMTZDK1o5cVlyaW4vMnBoc2IrMWxNWEFPZjJEL1o1ZWMyeEI3?=
 =?utf-8?B?WEx1dS9QdjlJNHBxTDFGSUtuYnZDeGlZV3FobnpIVWFyZ0htU3RBUTZJSHh5?=
 =?utf-8?B?dThSZXB0TEFENlhTZDAvQUY4VHExSUFkQ2gzbzEwcThEZ2J3MjBDYzd3a0M5?=
 =?utf-8?B?QjZmY29xd2VhOTdTUEY3bGkxek5ia3BUa2c4STY2KytsTkdSTUFVV1UxTDVm?=
 =?utf-8?B?U3gzOVg1TldGNnRUMFJ2cTlDVDhRMHNFT1lYaGlaNlBEOExGSUt6a2hhOXRy?=
 =?utf-8?B?WjRaMWJNRmxwSGtJbjdWVWJ2TEg1MDV4Vkxaa1hjU24wLzY0Y2YwVmxpR3V1?=
 =?utf-8?B?U2FJU2dOazByYXNNV0JSOUpQaWJxWkkzTlNZOXpiYzNneHFZZjU4ZjA4ZWp4?=
 =?utf-8?B?d3lSOU9iSlp0aVZKd3F2QnVQZUc2bVN2R0dMOXk5empndmNkeVQ4Ym9sZm9Y?=
 =?utf-8?B?WmZhRnBzQk9VcGNNM2lDK3Fid1VWTXZLSVdBZmxzaWZ3VGNua3VncXZIV2JT?=
 =?utf-8?B?RHhVNTlTUjI0VFdNd0JSS3c1RVVrc2Z6ZFhCSFQ5TTFsUE8xT3A3Nyt6RGRY?=
 =?utf-8?B?SzlWU3U4OE5udHR0Y09OcXIza3B1SURJOVg5aW1tTmEzSXRWaFFEREJPVENL?=
 =?utf-8?B?YU9qU3k3TnNEYnNqY1ZtYmNlZmZwUFBLSXRiRDRHSTc5OW5SMlFPeGJ6WElE?=
 =?utf-8?B?MFdsWFJoR2lJSk5NbWU0Ulh3dkIycVAyRmtDUUZ0WjFNdHBsdDRjOUFoVWEz?=
 =?utf-8?B?TVdjeHBneTdKUWhnT2JHMzNYenhkNktBNHo1SmxDTGdkNC9qeFlsS3d1Z1N1?=
 =?utf-8?B?amxKWHBhMzhEcDVsUlV5N0FKNVd6OTd5QlJtTmdETGY3YmJJOUpkL2Q0dUNl?=
 =?utf-8?B?QlpKcUE3Q2pFOVJpSEdtMDJGUmxBcXhwQk1PRnk3anZ6dVV1dTlTczBRTzNj?=
 =?utf-8?B?cXp0SEdYWXRLQlJFdGtRYXpleFB3VngwakZQRWFTaWJmSnFyekJqN1BMMVU2?=
 =?utf-8?B?d3BtYWs1OXJqMHdkUUc3akpKQ3ZIWlE1NVpvVy9aOG5ySlV6T3dXU3JkTUMv?=
 =?utf-8?B?cnl4SlBpNGI0dURrYnhMTDM0V0xXbGFscmZCNmQyR3N6RDVrbnhENU5jaldD?=
 =?utf-8?B?RHVzQkorbUdkSitCNU9GTzNMVGVVQ1pMRHQxQ2ZqRnI5TFRlYldVbzlCeDEz?=
 =?utf-8?B?cTVhdVV1cE1pTmZxUnlpZFJMNXJuQ2ozR3RsNDczRExremF0ZU5EWWRWUWZh?=
 =?utf-8?B?Mnp6cnNFUDl1RDY3MUQycUJJVCtGMEdrNjhTbEphS2xDci9rbnRQVUY4UXNN?=
 =?utf-8?B?TGphNllkeEJQQ29nRjR2cU1oelpsUnozblNOT1ltUU8zenZzYmRNdFI0bjFu?=
 =?utf-8?Q?clMJ8H0FSMn2By++SbcR5PviL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 038cde56-d8f1-4749-f90f-08de25ea1da3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 15:00:58.4717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFQ6XWEKY3kOvGN4LpdCaVWJb6EyS2ED0OEGeIxDKQqxVlf6+YwlBm4Q/LsmtR/z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768
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


On 2025-11-14 18:26, Felix Kuehling wrote:
>
> On 2025-11-13 16:09, Xiaogang.Chen wrote:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> Fixes: 7ef6b2d4b7e5 (drm/amdkfd: remap unaligned svm ranges that have 
>> split)
>>
>> When split svm ranges that have been mapped using huge page should 
>> use huge
>> page size(2MB) to check split range alignment, not 
>> prange->granularity that
>> means migration granularity.
>>
>> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 521c14c7a789..c60d8134db45 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1146,11 +1146,14 @@ svm_range_split_tail(struct svm_range 
>> *prange, uint64_t new_last,
>>   {
>>       struct svm_range *tail = NULL;
>>       int r = svm_range_split(prange, prange->start, new_last, &tail);
>> +    bool huge_page_mapping = IS_ALIGNED(prange->start, 512);
>
> Instead of hard-coding 512 here, it would be more future-proof to call 
> amdgpu_vm_pt_num_entries(adev, AMDGPU_VM_PDB0). That's currently a 
> static function in amdgpu_vm_pt.c. Christian, would you object to 
> making that non-static?

We don't have method to know if prange has huge page mapping which 
depends on virtual address 2MB align and physical address contiguous, it 
is decided inside amdgpu_vm_ptes_update. Even prange->start is not 2MB 
align, prange could have huge page mapping.

Regards,

Philip

>
> Also, to improve the check whether the range can really use huge 
> pages, you could add a check that it's size is at least 512 pages.

>
>
>>         if (!r) {
>>           list_add(&tail->list, insert_list);
>> -        if (!IS_ALIGNED(new_last + 1, 1UL << prange->granularity))
>> -            list_add(&tail->update_list, remap_list);
>> +        if (huge_page_mapping) {
>> +            if (!IS_ALIGNED(tail->start, 512))
>
> Make that one condition: if (huge_page_mapping && !IS_ALIGNED...)
>
>
>> + list_add(&tail->update_list, remap_list);
>> +        }
>>       }
>>       return r;
>>   }
>> @@ -1162,11 +1165,16 @@ svm_range_split_head(struct svm_range 
>> *prange, uint64_t new_start,
>>       struct svm_range *head = NULL;
>>       int r = svm_range_split(prange, new_start, prange->last, &head);
>>   +    bool huge_page_mapping = IS_ALIGNED(prange->start, 512);
>
> Why the blank line before huge_page_mapping? It's part of your 
> variable declarations.
>
>
>> +
>>       if (!r) {
>>           list_add(&head->list, insert_list);
>> -        if (!IS_ALIGNED(new_start, 1UL << prange->granularity))
>> -            list_add(&head->update_list, remap_list);
>> +        if (huge_page_mapping) {
>> +            if (!IS_ALIGNED(prange->start, 512))
>
> Same as above.
>
> Regards,
>   Felix
>
>
>> + list_add(&head->update_list, remap_list);
>> +        }
>>       }
>> +
>>       return r;
>>   }
