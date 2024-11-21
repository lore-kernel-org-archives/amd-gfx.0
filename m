Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DB5D75BB0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 04:30:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5819C10E85F;
	Thu, 21 Nov 2024 04:30:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dhX2J0wC";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0293410E85F
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 04:30:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEZ0ZojnDb4X2rvRDQ74SQtrQv6JjCJ4Ni9D6BUNV4o2PulVCRgaP0PimTLV8Lbkqpty6HSuqQsG5/J9/6TjuswGK/cOEy6I9tIIO2arPVnvzNZQyD7ZlsWtqGImsnVNyxLklEJ7AmoMesoCWohXVdZzxE/EnriHXkO/2+RYLlWYH58YlUkmOvcj6m2eHWk/Nv8iN4Cdco3xo9DYZU9Es+bo9pRU2lJkMvHOd5cJO+R8QjS/xZy8lJHwlWnCI/LLryvTG1kIepKh05Caac0z+ndfC+MHtiF2bfZpwDnAOlckrm2tSqUi8BQGxVUruDQzzOUIF2r3xxYPShB7FG7GdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRAEs419l8loXHiMo9svEJP/hI6GcaZrTGFsoHqoP0k=;
 b=qMMAqbW4S0SADVxXU90ZCMWygJ6XVJ8v7ubzaMmuyOycy5SYEeHz3UAG3yKB9BgHy2VjQZbuoEa1BH6nKrJAgZue+ZvjGcJvmojJOg33ld+VxwSJigNlED/93+YSWHd9q1hWiEiDbnmlz89gPon6hxpWZDXuJxnQhegbA32iL7Oy8YGFLkwCbuzaDT2C4qPbxa8Tfb3xgzAQCWQ5HVqQvvKR3+mBQII1ulc2QIqs9xsGq/+lqKHgyvbGAtn4dirYKyw+UEbKwAA2DRAjT8q0sBtsGVJMFLrXpSsRAFL7bAJlXEYaW8suRrZ77fmLUnUpKbS8HzLEAeAXNKVLKGmQkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRAEs419l8loXHiMo9svEJP/hI6GcaZrTGFsoHqoP0k=;
 b=dhX2J0wCVRfWvg87oLwRMINUIIx2/NWXhizkuyRyHBouDq0jRIfiTuwbDU5jxImOJz9vIR3GnkNg3Y620VqZBrroB9OlWk/JJPMVD8shUk8BiyHxkz4nqKhBcQFlrsgwfP3eFrw9Vp9oXkvm/UgH9s1XpYoplsejWa4bjMntUp4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 04:30:16 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8182.013; Thu, 21 Nov 2024
 04:30:16 +0000
Message-ID: <f88d5b7c-94e5-4bfd-af56-0714faf34f2d@amd.com>
Date: Thu, 21 Nov 2024 10:00:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: fix and simplify workload handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kenneth Feng <kenneth.feng@amd.com>
References: <20241120182828.2507700-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241120182828.2507700-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0019.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23d::22) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: eaf103d1-9f25-4687-b657-08dd09e532b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q05vd1Fnbzg1TUw1cDBaZGM4SFUvcTZMV3k3dHVhc2Z3ZVU2ZldySmhFN0Fq?=
 =?utf-8?B?TlFTMW5aRjlFOURNQ3VPRHoxOWxMR2VmV3ppZ2hvTU9pQXdrYWxxdVpEUER5?=
 =?utf-8?B?RVMrS3lJakVHQ1FNdmoxZnVtdmdFVngwSUpDVlA0OVlqRkxaUVpZWHpvU2pQ?=
 =?utf-8?B?RFhORHBSeTVoRXhYRmtJMGQ3V2J4NjNHQ3JlV0Jscm92eEhjeXFhbHFEK3I2?=
 =?utf-8?B?ZnJ5VDVxUG9GeHpuS1dyU0QvbHA5b0tOeHRTYXo1Qm5DRnRET1orVjVoTGpr?=
 =?utf-8?B?dk9oS1NTYTJRSFkzYjhyRUNsZFc3MVZzNXZ0Uk1QSnk2TGhFYkl6Z1Q3Vm9V?=
 =?utf-8?B?ZzF0bmQ2Ky8vbnFtRzR0L1UvOE02WEdCVDQ3YjY4UGV4cjlBUEZDQitvOWpx?=
 =?utf-8?B?K3ZLQmtOQUk3ZVBGbTJwdi9aYUxtdy9HZngzeXVRSSt0a21pTTZtbFprdE1V?=
 =?utf-8?B?SHoxc0ZUY1Q1U0UzVUtDRTh2Y3Y5QVh3RlhtVnpBQTFLOVhTVSs5NEpheW5K?=
 =?utf-8?B?K2QvcmpuNVYycEkvb2J0REkvS0EzaXhLZ3Z3ajJUSkZDK2xDZDlpa256TjRo?=
 =?utf-8?B?T1FrWjhmc2FHelhieWdaVEpQVXpGWldJNGhtaEJvdjVOV0NRRnVlVEJzK1NV?=
 =?utf-8?B?SW1rUUZSU08rVk5HbXRCcGxFbmNwRE1xOHJDbG5aeWVNSkRPR1cwL2tTQ3lv?=
 =?utf-8?B?cUcyMGMzZUE4emRGOU91Ym1JZTJHS3B6YkRZQnAxSEdLVHc3MlJQRjhGN3R3?=
 =?utf-8?B?dDhSR2Q1NW5zTkVZcEpkUWdwMTZsNmxFL0NRSStoNU9SNFpJNXNoYVpKcVFT?=
 =?utf-8?B?K09VY21JalVCS0hNUXpDSUk1c1pkSDl2anZsSVo5Ti8zejBQV1crZ1VFYVpE?=
 =?utf-8?B?d1hXdnBoT05iM2lTbkdEQ2VwRStmZ0lkNHRYSDVvcHJRUkdldTdjR2VaNkdW?=
 =?utf-8?B?MHBsNHhRSmJTcHdxSEI5R25TL21ybFQ4TkF2MUxyZEcxNzBsMjFBdTUxSm1T?=
 =?utf-8?B?WHdlejNuRFU3a2VBeTNENC9uK096ODk5RXVvUDZEelMrZnFwRzRVTUQ2MCtj?=
 =?utf-8?B?MW5hbE1MemtwWkl1V05NeFlzWUNlSEw3ZlpPRUswNy9ZWG9pUjlVREF4TFdj?=
 =?utf-8?B?VUxNY0Z5aHFFME5LZU0xdW5vSDdOQjRTRU1lYVlBY1hPcG9IVHFQNS9oQ1dw?=
 =?utf-8?B?UUZJcHF4dFg1YWJwL1VDUnEyNGFnNE5GcEFpTEFRd3NIbE1YTm8yY0ZoY0Nr?=
 =?utf-8?B?N3FoRS92Z0ZlWHBGZ1ZBeFlVZ2VDUlNQamxONU1jWnRLUzZwQWM3Q0hVUFFk?=
 =?utf-8?B?R2k2ZmY2UERUcUNLYjBFbEJ6WHhVOEVWZDB2bEthMVhYWUpQR2pId1JNR1I0?=
 =?utf-8?B?Si9sck9rS2F3TGprWHB5dHlzcnhBYVJWWVorWDNQZkhINzhtM1JIcWNWMWE2?=
 =?utf-8?B?TkI2MWRvdnB3TWkzd0NwMEVjNlpsVmxmeXhjaXBTNlA2QWtDVEZ0RlRORklQ?=
 =?utf-8?B?YmtKTDNYdW1iS2ljMzJWdE1LY1ZvR0dKQnhOYXR5N25jRFExaEs0N3lzbitF?=
 =?utf-8?B?cUh5OE1OV2w2MG5TaXVhSHl4dEpDc21KYnUxUHI1bU9TaExMM2dWQWpFNjNO?=
 =?utf-8?B?V20xT1pBQzNoeTJYSkRxZ1BlQ0p2RndGOFlOMjF4a3M0cnlqYnE2V1M5NWll?=
 =?utf-8?B?UFVBRHkreHFsTlRNUy9ZUWVZOFpvSGNqVkRPT2dZaWVNaVNuaXZSRTBVQ3Aw?=
 =?utf-8?Q?L2AzjPCQN2sTEPrBR/jNHk9rwvw8IxrouwFUcec?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXNmWUowWmZzSEFFb3c4ODU1K3VFM1kya2puTlMwZUhEb2M2T0JwWjhlQjdB?=
 =?utf-8?B?eGZhc1hKMi8vUjZhSWZJS09MVktOaTJZLzNRcW4vTXJOREtZVWJkWWhNRnYv?=
 =?utf-8?B?MnBpWW11ZjA2UDBJdmZLTmdDUzF5elBCM1Y0TW45cno4Nk5QZUI5TkVvZGkw?=
 =?utf-8?B?ZkpCbS9YZlk0Vm5kU2xmKzQyZCsycnBTV2VvSW4xbDBHSmlrVmV2MlZWcW9E?=
 =?utf-8?B?bUU2NXc2MmptVjFGU3E4cHU0OXlaQm51U0xFMUZjTGxBdk1lUUdmR1YvNytS?=
 =?utf-8?B?TVdaM2hjZG9scG1JZEV6VU1YSDhhY0xwZXpadjVIYTIrWjlaT3MwWERDK25M?=
 =?utf-8?B?WjBYTFB5ekhaa3dWeGUrU09JR0EvTEluT0dFSTN1QVhpbFJVYzZpclQxWSsy?=
 =?utf-8?B?TzhxNTVJU1JULzlLeC9jQjFuMlRBQTNEKytFaUxhc0Q0THpsNEVobHd3N21l?=
 =?utf-8?B?UnBjVUhxMFNJU3BnMmJ0ZStXQURldHEvNnFPc091aGNIaUpQbWFrTFZlenRo?=
 =?utf-8?B?S084Vi92NXJORDVLZDhJbllpUVZ5T2FSZHZmdGRtOUtDbkE4V0d0OHNMR3ZL?=
 =?utf-8?B?cHo1SHB6d0NXQVkvRUIyTVZTTGhEdXkvQXNKaG5GSk9rTGJ3TWRDcTlFd2lL?=
 =?utf-8?B?c3lFekdGUVVmZWVaNnl0dm1WUnNGZm1PY3N6NElweGIxRGU0ZC9kMnJSRjA4?=
 =?utf-8?B?V0pxRkRmYTBoS3FBYjRIV2pkWHZqaGFNeXE5V0JxR3dqMVlvTzBSY2tlWUpU?=
 =?utf-8?B?VGxnaVdHcEVsazZrbmVmU29RcDJFWGR0MmhUU1VRUDNyZTBiTlNmN1p1eSty?=
 =?utf-8?B?cDBNYVh2L1czOFkwaExKb29OTjRtTmd2bWt3OVA5OS9MM3lQbDN0UnlqUmtO?=
 =?utf-8?B?OWFSN2VpckI2RWtHUWlVSHNRWEZSeXdRV1o3VzZJMGxMYVNtNWs5Wk1Vemo2?=
 =?utf-8?B?cnlsOTlpYlNZendyclFMdElPcU5ZNnJURExrNDlGVjY0WG10TWF5Qk1hRXhy?=
 =?utf-8?B?ZmdoWU5JVFhDbE4wMCtPR3BSRnRPb09Eb1BlSWhad0RET3dYK09maWtJM09T?=
 =?utf-8?B?dnpYQ0Q2WDIwdmNFR1VIK3Vld1hFMWhHY2lFSFErTWJ6dHJQZ1ExbXVITERl?=
 =?utf-8?B?bnpQVXY1SHZzcVMvZldBakJqdG41WmkzRmFOb1p2VUVKVk1IUTAybkpyM3pj?=
 =?utf-8?B?ZjVtVzBqMkVXdG5XTCtua1FOTG4wY0pTWXdIZ1hPKzJkOXNiWXFFTmk0cmEv?=
 =?utf-8?B?VDgxTjcwWkw0Q21ycnhlVVFxdjZvQkVvaFRYMEo3MVBnMWRGb0NJNmhQTEpK?=
 =?utf-8?B?bVVONFRLSXNmYWw3NS92Qm1ZZVo3bWxETFhsckVkRjhkcG83V1BscUd3ZTV2?=
 =?utf-8?B?WVRsbnpoNzczMlJLYkI0M0ZzOEVxZ3hPM1BrMDJOWk5hV2huV0tuYUx1QXJ1?=
 =?utf-8?B?QWVrZTVmRXYvUlFoZW1qVGhtTExOaFFUckQ5M2xaalNjS1ZLbHFtSFJEdW80?=
 =?utf-8?B?aFFCdGU0a003VGh5ekhPQTZvSEJCM0l6bnBLcEV0T241RnBoRHlpN08vaG04?=
 =?utf-8?B?SVkvZVJtMVdIMG9vanUwZlRzVSs0Z0NKdXpEZ2U0SEtKNk56Qno2dHg1WVFC?=
 =?utf-8?B?S0NDQldpMnFySXJ0bTc5RnBsSDFzRHBweUtHU1l5anhyd3lhMDQveWF0V0x2?=
 =?utf-8?B?d2FmTXZ0ZHpPM3VsNjVxcHE1Rkl6MTZ2T1pHaWZzOFBqUlZiOHU3d0VuUFpN?=
 =?utf-8?B?UzFPRzNxeldwRGhTeHNUNmNqcTFSQW5aaS8vZ1pwZERjcno4aDBzTzNPbzB4?=
 =?utf-8?B?V0RGS3Y5S0tsS2Q4dG9QMXJhQ1o3WVZwSkVzMy9rMmZRK2QvQ0VaK2EwTS9H?=
 =?utf-8?B?THB0K2pLdDl4em85THg0UDZwdmpHMlN3VUFiU2o5YzYxTXFVeW1DeU53NGNQ?=
 =?utf-8?B?eW1sUHllUTFhUlozZ1Y2bmtET2FueE1XbFFjVUVsWTc3VmZ0a2pWdTdvaWlQ?=
 =?utf-8?B?YVE1QmtuUEJTTndGMFl6alJrZG9wUGhxYWhmaXhabEhFZ0tSd29IaVg3bEdJ?=
 =?utf-8?B?cjQ3NTZPVmU2QldwYUVWcEpaS0dFdzVZTE8wR1VwT2hkV2wrcTFlM0VUb0pS?=
 =?utf-8?Q?FQL+pDmr1IilEYRKmB5KPQVn3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf103d1-9f25-4687-b657-08dd09e532b5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 04:30:16.5243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5oSgslIDnOBJ4LliDUv3e9+4OjYRtup1HQzvFMrUPAuqj3sx9qt0CMtfMwDpsLno
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088
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



On 11/20/2024 11:58 PM, Alex Deucher wrote:
> smu->workload_mask is IP specific and should not be messed with in
> the common code. The mask bits vary across SMU versions.
> 
> Move all handling of smu->workload_mask in to the backends and
> simplify the code.  Store the user's preference in smu->power_profile_mode
> which will be reflected in sysfs.  For internal driver profile
> switches for KFD or VCN, just update the workload mask so that the
> user's preference is retained.  Remove all of the extra now unused
> workload related elements in the smu structure.
> 
> v2: use refcounts for workload profiles
> v3: rework based on feedback from Lijo
> v4: fix the refcount on failure, drop backend mask
> v5: rework custom handling
> v6: handle failure cleanup with custom profile
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Kenneth Feng <kenneth.feng@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 150 ++++++++++------
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  15 +-
>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 166 +++++++++--------
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 167 ++++++++++-------
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 168 +++++++++++-------
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  41 ++---
>  .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  43 ++---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 167 +++++++++--------
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 138 ++++++++------
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 168 +++++++++++-------
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  25 +++
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   4 +
>  12 files changed, 736 insertions(+), 516 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index f99fe2508852..acaa1530c25c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -72,6 +72,10 @@ static int smu_set_power_limit(void *handle, uint32_t limit);
>  static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
>  static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
>  static int smu_set_mp1_state(void *handle, enum pp_mp1_state mp1_state);
> +static void smu_power_profile_mode_get(struct smu_context *smu,
> +				       enum PP_SMC_POWER_PROFILE profile_mode);
> +static void smu_power_profile_mode_put(struct smu_context *smu,
> +				       enum PP_SMC_POWER_PROFILE profile_mode);
>  
>  static int smu_sys_get_pp_feature_mask(void *handle,
>  				       char *buf)
> @@ -1268,8 +1272,6 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>  	INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
>  	atomic64_set(&smu->throttle_int_counter, 0);
>  	smu->watermarks_bitmap = 0;
> -	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> -	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>  
>  	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
>  		atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
> @@ -1277,27 +1279,13 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>  	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
>  	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
>  
> -	smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
> -	smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
> -	smu->workload_prority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
> -	smu->workload_prority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
> -	smu->workload_prority[PP_SMC_POWER_PROFILE_VR] = 4;
> -	smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
> -	smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
> -
>  	if (smu->is_apu ||
>  	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
> -		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
> +		smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>  	else
> -		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
> -
> -	smu->workload_setting[0] = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> -	smu->workload_setting[1] = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> -	smu->workload_setting[2] = PP_SMC_POWER_PROFILE_POWERSAVING;
> -	smu->workload_setting[3] = PP_SMC_POWER_PROFILE_VIDEO;
> -	smu->workload_setting[4] = PP_SMC_POWER_PROFILE_VR;
> -	smu->workload_setting[5] = PP_SMC_POWER_PROFILE_COMPUTE;
> -	smu->workload_setting[6] = PP_SMC_POWER_PROFILE_CUSTOM;
> +		smu->power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> +	smu_power_profile_mode_get(smu, smu->power_profile_mode);
> +
>  	smu->display_config = &adev->pm.pm_display_cfg;
>  
>  	smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
> @@ -1350,6 +1338,11 @@ static int smu_sw_fini(struct amdgpu_ip_block *ip_block)
>  		return ret;
>  	}
>  
> +	if (smu->custom_profile_params) {
> +		kfree(smu->custom_profile_params);
> +		smu->custom_profile_params = NULL;
> +	}
> +
>  	smu_fini_microcode(smu);
>  
>  	return 0;
> @@ -2137,6 +2130,9 @@ static int smu_suspend(struct amdgpu_ip_block *ip_block)
>  	if (!ret)
>  		adev->gfx.gfx_off_entrycount = count;
>  
> +	/* clear this on suspend so it will get reprogrammed on resume */
> +	smu->workload_mask = 0;
> +
>  	return 0;
>  }
>  
> @@ -2249,25 +2245,49 @@ static int smu_enable_umd_pstate(void *handle,
>  }
>  
>  static int smu_bump_power_profile_mode(struct smu_context *smu,
> -					   long *param,
> -					   uint32_t param_size)
> +				       long *custom_params,
> +				       u32 custom_params_max_idx)
>  {
> -	int ret = 0;
> +	u32 workload_mask = 0;
> +	int i, ret = 0;
> +
> +	for (i = 0; i < PP_SMC_POWER_PROFILE_COUNT; i++) {
> +		if (smu->workload_refcount[i])
> +			workload_mask |= 1 << i;
> +	}
> +
> +	if (smu->workload_mask == workload_mask)
> +		return 0;
>  
>  	if (smu->ppt_funcs->set_power_profile_mode)
> -		ret = smu->ppt_funcs->set_power_profile_mode(smu, param, param_size);
> +		ret = smu->ppt_funcs->set_power_profile_mode(smu, workload_mask,
> +							     custom_params,
> +							     custom_params_max_idx);
> +
> +	if (!ret)
> +		smu->workload_mask = workload_mask;
>  
>  	return ret;
>  }
>  
> +static void smu_power_profile_mode_get(struct smu_context *smu,
> +				       enum PP_SMC_POWER_PROFILE profile_mode)
> +{
> +	smu->workload_refcount[profile_mode]++;
> +}
> +
> +static void smu_power_profile_mode_put(struct smu_context *smu,
> +				       enum PP_SMC_POWER_PROFILE profile_mode)
> +{
> +	if (smu->workload_refcount[profile_mode])
> +		smu->workload_refcount[profile_mode]--;
> +}
> +
>  static int smu_adjust_power_state_dynamic(struct smu_context *smu,
>  					  enum amd_dpm_forced_level level,
> -					  bool skip_display_settings,
> -					  bool init)
> +					  bool skip_display_settings)
>  {
>  	int ret = 0;
> -	int index = 0;
> -	long workload[1];
>  	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
>  
>  	if (!skip_display_settings) {
> @@ -2304,14 +2324,8 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
>  	}
>  
>  	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
> -		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
> -		index = fls(smu->workload_mask);
> -		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> -		workload[0] = smu->workload_setting[index];
> -
> -		if (init || smu->power_profile_mode != workload[0])
> -			smu_bump_power_profile_mode(smu, workload, 0);
> -	}
> +	    smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
> +		smu_bump_power_profile_mode(smu, NULL, 0);
>  
>  	return ret;
>  }
> @@ -2330,13 +2344,13 @@ static int smu_handle_task(struct smu_context *smu,
>  		ret = smu_pre_display_config_changed(smu);
>  		if (ret)
>  			return ret;
> -		ret = smu_adjust_power_state_dynamic(smu, level, false, false);
> +		ret = smu_adjust_power_state_dynamic(smu, level, false);
>  		break;
>  	case AMD_PP_TASK_COMPLETE_INIT:
> -		ret = smu_adjust_power_state_dynamic(smu, level, true, true);
> +		ret = smu_adjust_power_state_dynamic(smu, level, true);
>  		break;
>  	case AMD_PP_TASK_READJUST_POWER_STATE:
> -		ret = smu_adjust_power_state_dynamic(smu, level, true, false);
> +		ret = smu_adjust_power_state_dynamic(smu, level, true);
>  		break;
>  	default:
>  		break;
> @@ -2358,12 +2372,11 @@ static int smu_handle_dpm_task(void *handle,
>  
>  static int smu_switch_power_profile(void *handle,
>  				    enum PP_SMC_POWER_PROFILE type,
> -				    bool en)
> +				    bool enable)
>  {
>  	struct smu_context *smu = handle;
>  	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
> -	long workload[1];
> -	uint32_t index;
> +	int ret;
>  
>  	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>  		return -EOPNOTSUPP;
> @@ -2371,21 +2384,21 @@ static int smu_switch_power_profile(void *handle,
>  	if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
>  		return -EINVAL;
>  
> -	if (!en) {
> -		smu->workload_mask &= ~(1 << smu->workload_prority[type]);
> -		index = fls(smu->workload_mask);
> -		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> -		workload[0] = smu->workload_setting[index];
> -	} else {
> -		smu->workload_mask |= (1 << smu->workload_prority[type]);
> -		index = fls(smu->workload_mask);
> -		index = index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> -		workload[0] = smu->workload_setting[index];
> -	}
> -
>  	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
> -		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
> -		smu_bump_power_profile_mode(smu, workload, 0);
> +	    smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
> +		if (enable)
> +			smu_power_profile_mode_get(smu, type);
> +		else
> +			smu_power_profile_mode_put(smu, type);
> +		ret = smu_bump_power_profile_mode(smu, NULL, 0);
> +		if (ret) {
> +			if (enable)
> +				smu_power_profile_mode_put(smu, type);
> +			else
> +				smu_power_profile_mode_get(smu, type);
> +			return ret;
> +		}
> +	}
>  
>  	return 0;
>  }
> @@ -3084,12 +3097,35 @@ static int smu_set_power_profile_mode(void *handle,
>  				      uint32_t param_size)
>  {
>  	struct smu_context *smu = handle;
> +	bool custom = false;
> +	int ret = 0;
>  
>  	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
>  	    !smu->ppt_funcs->set_power_profile_mode)
>  		return -EOPNOTSUPP;
>  
> -	return smu_bump_power_profile_mode(smu, param, param_size);
> +	if (param[param_size] == PP_SMC_POWER_PROFILE_CUSTOM) {
> +		custom = true;
> +		/* clear frontend mask so custom changes propogate */
> +		smu->workload_mask = 0;
> +	}
> +
> +	if ((param[param_size] != smu->power_profile_mode) || custom) {
> +		/* clear the old user preference */
> +		smu_power_profile_mode_put(smu, smu->power_profile_mode);
> +		/* set the new user preference */
> +		smu_power_profile_mode_get(smu, param[param_size]);
> +		ret = smu_bump_power_profile_mode(smu,
> +						  custom ? param : NULL,
> +						  custom ? param_size : 0);
> +		if (ret)
> +			smu_power_profile_mode_put(smu, param[param_size]);
> +		else
> +			/* store the user's preference */
> +			smu->power_profile_mode = param[param_size];
> +	}
> +
> +	return ret;
>  }
>  
>  static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index d407777d6711..3630593bce61 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -556,11 +556,13 @@ struct smu_context {
>  	uint32_t hard_min_uclk_req_from_dal;
>  	bool disable_uclk_switch;
>  
> +	/* asic agnostic workload mask */
>  	uint32_t workload_mask;
> -	uint32_t workload_prority[WORKLOAD_POLICY_MAX];
> -	uint32_t workload_setting[WORKLOAD_POLICY_MAX];
> +	/* default/user workload preference */
>  	uint32_t power_profile_mode;
> -	uint32_t default_power_profile_mode;
> +	uint32_t workload_refcount[PP_SMC_POWER_PROFILE_COUNT];
> +	/* backend specific custom workload settings */
> +	long *custom_profile_params;
>  	bool pm_enabled;
>  	bool is_apu;
>  
> @@ -731,9 +733,12 @@ struct pptable_funcs {
>  	 * @set_power_profile_mode: Set a power profile mode. Also used to
>  	 *                          create/set custom power profile modes.
>  	 * &input: Power profile mode parameters.
> -	 * &size: Size of &input.
> +	 * &workload_mask: mask of workloads to enable
> +	 * &custom_params: custom profile parameters
> +	 * &custom_params_max_idx: max valid idx into custom_params
>  	 */
> -	int (*set_power_profile_mode)(struct smu_context *smu, long *input, uint32_t size);
> +	int (*set_power_profile_mode)(struct smu_context *smu, u32 workload_mask,
> +				      long *custom_params, u32 custom_params_max_idx);
>  
>  	/**
>  	 * @dpm_set_vcn_enable: Enable/disable VCN engine dynamic power
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index a15754b1989f..8aa61a9f7778 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -1445,98 +1445,120 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
>  	return size;
>  }
>  
> -static int arcturus_set_power_profile_mode(struct smu_context *smu,
> -					   long *input,
> -					   uint32_t size)
> +#define ARCTURUS_CUSTOM_PARAMS_COUNT 10
> +#define ARCTURUS_CUSTOM_PARAMS_CLOCK_COUNT 2
> +#define ARCTURUS_CUSTOM_PARAMS_SIZE (ARCTURUS_CUSTOM_PARAMS_CLOCK_COUNT * ARCTURUS_CUSTOM_PARAMS_COUNT * sizeof(long))
> +
> +static int arcturus_set_power_profile_mode_coeff(struct smu_context *smu,
> +						 long *input)
>  {
>  	DpmActivityMonitorCoeffInt_t activity_monitor;
> -	int workload_type = 0;
> -	uint32_t profile_mode = input[size];
> -	int ret = 0;
> +	int ret, idx;
>  
> -	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
> -		return -EINVAL;
> +	ret = smu_cmn_update_table(smu,
> +				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> +				   WORKLOAD_PPLIB_CUSTOM_BIT,
> +				   (void *)(&activity_monitor),
> +				   false);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
> +		return ret;
>  	}
>  
> +	idx = 0 * ARCTURUS_CUSTOM_PARAMS_COUNT;
> +	if (input[idx]) {
> +		/* Gfxclk */
> +		activity_monitor.Gfx_FPS = input[idx + 1];
> +		activity_monitor.Gfx_UseRlcBusy = input[idx + 2];
> +		activity_monitor.Gfx_MinActiveFreqType = input[idx + 3];
> +		activity_monitor.Gfx_MinActiveFreq = input[idx + 4];
> +		activity_monitor.Gfx_BoosterFreqType = input[idx + 5];
> +		activity_monitor.Gfx_BoosterFreq = input[idx + 6];
> +		activity_monitor.Gfx_PD_Data_limit_c = input[idx + 7];
> +		activity_monitor.Gfx_PD_Data_error_coeff = input[idx + 8];
> +		activity_monitor.Gfx_PD_Data_error_rate_coeff = input[idx + 9];
> +	}
> +	idx = 1 * ARCTURUS_CUSTOM_PARAMS_COUNT;
> +	if (input[idx]) {
> +		/* Uclk */
> +		activity_monitor.Mem_FPS = input[idx + 1];
> +		activity_monitor.Mem_UseRlcBusy = input[idx + 2];
> +		activity_monitor.Mem_MinActiveFreqType = input[idx + 3];
> +		activity_monitor.Mem_MinActiveFreq = input[idx + 4];
> +		activity_monitor.Mem_BoosterFreqType = input[idx + 5];
> +		activity_monitor.Mem_BoosterFreq = input[idx + 6];
> +		activity_monitor.Mem_PD_Data_limit_c = input[idx + 7];
> +		activity_monitor.Mem_PD_Data_error_coeff = input[idx + 8];
> +		activity_monitor.Mem_PD_Data_error_rate_coeff = input[idx + 9];
> +	}
>  
> -	if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
> -	     (smu->smc_fw_version >= 0x360d00)) {
> -		if (size != 10)
> -			return -EINVAL;
> +	ret = smu_cmn_update_table(smu,
> +				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> +				   WORKLOAD_PPLIB_CUSTOM_BIT,
> +				   (void *)(&activity_monitor),
> +				   true);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
> +		return ret;
> +	}
>  
> -		ret = smu_cmn_update_table(smu,
> -				       SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> -				       WORKLOAD_PPLIB_CUSTOM_BIT,
> -				       (void *)(&activity_monitor),
> -				       false);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
> -			return ret;
> -		}
> +	return ret;
> +}
>  
> -		switch (input[0]) {
> -		case 0: /* Gfxclk */
> -			activity_monitor.Gfx_FPS = input[1];
> -			activity_monitor.Gfx_UseRlcBusy = input[2];
> -			activity_monitor.Gfx_MinActiveFreqType = input[3];
> -			activity_monitor.Gfx_MinActiveFreq = input[4];
> -			activity_monitor.Gfx_BoosterFreqType = input[5];
> -			activity_monitor.Gfx_BoosterFreq = input[6];
> -			activity_monitor.Gfx_PD_Data_limit_c = input[7];
> -			activity_monitor.Gfx_PD_Data_error_coeff = input[8];
> -			activity_monitor.Gfx_PD_Data_error_rate_coeff = input[9];
> -			break;
> -		case 1: /* Uclk */
> -			activity_monitor.Mem_FPS = input[1];
> -			activity_monitor.Mem_UseRlcBusy = input[2];
> -			activity_monitor.Mem_MinActiveFreqType = input[3];
> -			activity_monitor.Mem_MinActiveFreq = input[4];
> -			activity_monitor.Mem_BoosterFreqType = input[5];
> -			activity_monitor.Mem_BoosterFreq = input[6];
> -			activity_monitor.Mem_PD_Data_limit_c = input[7];
> -			activity_monitor.Mem_PD_Data_error_coeff = input[8];
> -			activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
> -			break;
> -		default:
> +static int arcturus_set_power_profile_mode(struct smu_context *smu,
> +					   u32 workload_mask,
> +					   long *custom_params,
> +					   u32 custom_params_max_idx)
> +{
> +	u32 backend_workload_mask = 0;
> +	int ret, idx = -1, i;
> +
> +	smu_cmn_get_backend_workload_mask(smu, workload_mask,
> +					  &backend_workload_mask);
> +
> +	if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
> +		if (smu->smc_fw_version < 0x360d00)
>  			return -EINVAL;
> +		if (!smu->custom_profile_params) {
> +			smu->custom_profile_params =
> +				kzalloc(ARCTURUS_CUSTOM_PARAMS_SIZE, GFP_KERNEL);
> +			if (!smu->custom_profile_params)
> +				return -ENOMEM;
>  		}
> -
> -		ret = smu_cmn_update_table(smu,
> -				       SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> -				       WORKLOAD_PPLIB_CUSTOM_BIT,
> -				       (void *)(&activity_monitor),
> -				       true);
> +		if (custom_params && custom_params_max_idx) {
> +			if (custom_params_max_idx != ARCTURUS_CUSTOM_PARAMS_COUNT)
> +				return -EINVAL;
> +			if (custom_params[0] >= ARCTURUS_CUSTOM_PARAMS_CLOCK_COUNT)
> +				return -EINVAL;
> +			idx = custom_params[0] * ARCTURUS_CUSTOM_PARAMS_COUNT;
> +			smu->custom_profile_params[idx] = 1;
> +			for (i = 1; i < custom_params_max_idx; i++)
> +				smu->custom_profile_params[idx + i] = custom_params[i];
> +		}
> +		ret = arcturus_set_power_profile_mode_coeff(smu,
> +							    smu->custom_profile_params);
>  		if (ret) {
> -			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
> +			if (idx != -1)
> +				smu->custom_profile_params[idx] = 0;

I don't know if this is the right thing to do. This means we are only
having a partial revert eventhough custom mode settings as a whole failed.

1) Current Mode = 3D
2) Pass Custom + GfxCLK custom settings
3) Pass Custom + MemCLK custom settings

When 3) fails, we revert from the custom mode (put operation) and it
goes back to 3D as the new settings failed. At a later point if user
passes MemCLK custom settings, this is going to pick the initial GFXCLK
custom settings also. Is that needed?

Thanks,
Lijo
>  			return ret;
>  		}
> -	}
> -
> -	/*
> -	 * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT
> -	 * Not all profile modes are supported on arcturus.
> -	 */
> -	workload_type = smu_cmn_to_asic_specific_index(smu,
> -						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       profile_mode);
> -	if (workload_type < 0) {
> -		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on arcturus\n", profile_mode);
> -		return -EINVAL;
> +	} else if (smu->custom_profile_params) {
> +		memset(smu->custom_profile_params, 0, ARCTURUS_CUSTOM_PARAMS_SIZE);
>  	}
>  
>  	ret = smu_cmn_send_smc_msg_with_param(smu,
> -					  SMU_MSG_SetWorkloadMask,
> -					  1 << workload_type,
> -					  NULL);
> +					      SMU_MSG_SetWorkloadMask,
> +					      backend_workload_mask,
> +					      NULL);
>  	if (ret) {
> -		dev_err(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
> +		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
> +			workload_mask);
> +		if (idx != -1)
> +			smu->custom_profile_params[idx] = 0;
>  		return ret;
>  	}
>  
> -	smu->power_profile_mode = profile_mode;
> -
> -	return 0;
> +	return ret;
>  }
>  
>  static int arcturus_set_performance_level(struct smu_context *smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index faa8e7d9c3c6..7fad5dfb39c4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2006,87 +2006,122 @@ static int navi10_get_power_profile_mode(struct smu_context *smu, char *buf)
>  	return size;
>  }
>  
> -static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
> +#define NAVI10_CUSTOM_PARAMS_COUNT 10
> +#define NAVI10_CUSTOM_PARAMS_CLOCKS_COUNT 3
> +#define NAVI10_CUSTOM_PARAMS_SIZE (NAVI10_CUSTOM_PARAMS_CLOCKS_COUNT * NAVI10_CUSTOM_PARAMS_COUNT * sizeof(long))
> +
> +static int navi10_set_power_profile_mode_coeff(struct smu_context *smu,
> +					       long *input)
>  {
>  	DpmActivityMonitorCoeffInt_t activity_monitor;
> -	int workload_type, ret = 0;
> +	int ret, idx;
>  
> -	smu->power_profile_mode = input[size];
> +	ret = smu_cmn_update_table(smu,
> +				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
> +				   (void *)(&activity_monitor), false);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
> +		return ret;
> +	}
>  
> -	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
> -		return -EINVAL;
> +	idx = 0 * NAVI10_CUSTOM_PARAMS_COUNT;
> +	if (input[idx]) {
> +		/* Gfxclk */
> +		activity_monitor.Gfx_FPS = input[idx + 1];
> +		activity_monitor.Gfx_MinFreqStep = input[idx + 2];
> +		activity_monitor.Gfx_MinActiveFreqType = input[idx + 3];
> +		activity_monitor.Gfx_MinActiveFreq = input[idx + 4];
> +		activity_monitor.Gfx_BoosterFreqType = input[idx + 5];
> +		activity_monitor.Gfx_BoosterFreq = input[idx + 6];
> +		activity_monitor.Gfx_PD_Data_limit_c = input[idx + 7];
> +		activity_monitor.Gfx_PD_Data_error_coeff = input[idx + 8];
> +		activity_monitor.Gfx_PD_Data_error_rate_coeff = input[idx + 9];
> +	}
> +	idx = 1 * NAVI10_CUSTOM_PARAMS_COUNT;
> +	if (input[idx]) {
> +		/* Socclk */
> +		activity_monitor.Soc_FPS = input[idx + 1];
> +		activity_monitor.Soc_MinFreqStep = input[idx + 2];
> +		activity_monitor.Soc_MinActiveFreqType = input[idx + 3];
> +		activity_monitor.Soc_MinActiveFreq = input[idx + 4];
> +		activity_monitor.Soc_BoosterFreqType = input[idx + 5];
> +		activity_monitor.Soc_BoosterFreq = input[idx + 6];
> +		activity_monitor.Soc_PD_Data_limit_c = input[idx + 7];
> +		activity_monitor.Soc_PD_Data_error_coeff = input[idx + 8];
> +		activity_monitor.Soc_PD_Data_error_rate_coeff = input[idx + 9];
> +	}
> +	idx = 2 * NAVI10_CUSTOM_PARAMS_COUNT;
> +	if (input[idx]) {
> +		/* Memclk */
> +		activity_monitor.Mem_FPS = input[idx + 1];
> +		activity_monitor.Mem_MinFreqStep = input[idx + 2];
> +		activity_monitor.Mem_MinActiveFreqType = input[idx + 3];
> +		activity_monitor.Mem_MinActiveFreq = input[idx + 4];
> +		activity_monitor.Mem_BoosterFreqType = input[idx + 5];
> +		activity_monitor.Mem_BoosterFreq = input[idx + 6];
> +		activity_monitor.Mem_PD_Data_limit_c = input[idx + 7];
> +		activity_monitor.Mem_PD_Data_error_coeff = input[idx + 8];
> +		activity_monitor.Mem_PD_Data_error_rate_coeff = input[idx + 9];
> +	}
> +
> +	ret = smu_cmn_update_table(smu,
> +				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
> +				   (void *)(&activity_monitor), true);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
> +		return ret;
>  	}
>  
> -	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
> -		if (size != 10)
> -			return -EINVAL;
> +	return ret;
> +}
>  
> -		ret = smu_cmn_update_table(smu,
> -				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
> -				       (void *)(&activity_monitor), false);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
> -			return ret;
> -		}
> +static int navi10_set_power_profile_mode(struct smu_context *smu,
> +					 u32 workload_mask,
> +					 long *custom_params,
> +					 u32 custom_params_max_idx)
> +{
> +	u32 backend_workload_mask = 0;
> +	int ret, idx = -1, i;
>  
> -		switch (input[0]) {
> -		case 0: /* Gfxclk */
> -			activity_monitor.Gfx_FPS = input[1];
> -			activity_monitor.Gfx_MinFreqStep = input[2];
> -			activity_monitor.Gfx_MinActiveFreqType = input[3];
> -			activity_monitor.Gfx_MinActiveFreq = input[4];
> -			activity_monitor.Gfx_BoosterFreqType = input[5];
> -			activity_monitor.Gfx_BoosterFreq = input[6];
> -			activity_monitor.Gfx_PD_Data_limit_c = input[7];
> -			activity_monitor.Gfx_PD_Data_error_coeff = input[8];
> -			activity_monitor.Gfx_PD_Data_error_rate_coeff = input[9];
> -			break;
> -		case 1: /* Socclk */
> -			activity_monitor.Soc_FPS = input[1];
> -			activity_monitor.Soc_MinFreqStep = input[2];
> -			activity_monitor.Soc_MinActiveFreqType = input[3];
> -			activity_monitor.Soc_MinActiveFreq = input[4];
> -			activity_monitor.Soc_BoosterFreqType = input[5];
> -			activity_monitor.Soc_BoosterFreq = input[6];
> -			activity_monitor.Soc_PD_Data_limit_c = input[7];
> -			activity_monitor.Soc_PD_Data_error_coeff = input[8];
> -			activity_monitor.Soc_PD_Data_error_rate_coeff = input[9];
> -			break;
> -		case 2: /* Memclk */
> -			activity_monitor.Mem_FPS = input[1];
> -			activity_monitor.Mem_MinFreqStep = input[2];
> -			activity_monitor.Mem_MinActiveFreqType = input[3];
> -			activity_monitor.Mem_MinActiveFreq = input[4];
> -			activity_monitor.Mem_BoosterFreqType = input[5];
> -			activity_monitor.Mem_BoosterFreq = input[6];
> -			activity_monitor.Mem_PD_Data_limit_c = input[7];
> -			activity_monitor.Mem_PD_Data_error_coeff = input[8];
> -			activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> +	smu_cmn_get_backend_workload_mask(smu, workload_mask,
> +					  &backend_workload_mask);
>  
> -		ret = smu_cmn_update_table(smu,
> -				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
> -				       (void *)(&activity_monitor), true);
> +	if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
> +		if (!smu->custom_profile_params) {
> +			smu->custom_profile_params = kzalloc(NAVI10_CUSTOM_PARAMS_SIZE, GFP_KERNEL);
> +			if (!smu->custom_profile_params)
> +				return -ENOMEM;
> +		}
> +		if (custom_params && custom_params_max_idx) {
> +			if (custom_params_max_idx != NAVI10_CUSTOM_PARAMS_COUNT)
> +				return -EINVAL;
> +			if (custom_params[0] >= NAVI10_CUSTOM_PARAMS_CLOCKS_COUNT)
> +				return -EINVAL;
> +			idx = custom_params[0] * NAVI10_CUSTOM_PARAMS_COUNT;
> +			smu->custom_profile_params[idx] = 1;
> +			for (i = 1; i < custom_params_max_idx; i++)
> +				smu->custom_profile_params[idx + i] = custom_params[i];
> +		}
> +		ret = navi10_set_power_profile_mode_coeff(smu,
> +							  smu->custom_profile_params);
>  		if (ret) {
> -			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
> +			if (idx != -1)
> +				smu->custom_profile_params[idx] = 0;
>  			return ret;
>  		}
> +	} else if (smu->custom_profile_params) {
> +		memset(smu->custom_profile_params, 0, NAVI10_CUSTOM_PARAMS_SIZE);
>  	}
>  
> -	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> -	workload_type = smu_cmn_to_asic_specific_index(smu,
> -						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       smu->power_profile_mode);
> -	if (workload_type < 0)
> -		return -EINVAL;
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
> -				    1 << workload_type, NULL);
> -	if (ret)
> -		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
> +					      backend_workload_mask, NULL);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
> +			workload_mask);
> +		if (idx != -1)
> +			smu->custom_profile_params[idx] = 0;
> +		return ret;
> +	}
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 30d050a6e953..19a25fdc2f5b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -1704,90 +1704,126 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
>  	return size;
>  }
>  
> -static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
> +#define SIENNA_CICHLID_CUSTOM_PARAMS_COUNT 10
> +#define SIENNA_CICHLID_CUSTOM_PARAMS_CLOCK_COUNT 3
> +#define SIENNA_CICHLID_CUSTOM_PARAMS_SIZE (SIENNA_CICHLID_CUSTOM_PARAMS_CLOCK_COUNT * SIENNA_CICHLID_CUSTOM_PARAMS_COUNT * sizeof(long))
> +
> +static int sienna_cichlid_set_power_profile_mode_coeff(struct smu_context *smu,
> +						       long *input)
>  {
>  
>  	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>  	DpmActivityMonitorCoeffInt_t *activity_monitor =
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
> -	int workload_type, ret = 0;
> +	int ret, idx;
>  
> -	smu->power_profile_mode = input[size];
> +	ret = smu_cmn_update_table(smu,
> +				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
> +				   (void *)(&activity_monitor_external), false);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
> +		return ret;
> +	}
>  
> -	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
> -		return -EINVAL;
> +	idx = 0 * SIENNA_CICHLID_CUSTOM_PARAMS_COUNT;
> +	if (input[idx]) {
> +		/* Gfxclk */
> +		activity_monitor->Gfx_FPS = input[idx + 1];
> +		activity_monitor->Gfx_MinFreqStep = input[idx + 2];
> +		activity_monitor->Gfx_MinActiveFreqType = input[idx + 3];
> +		activity_monitor->Gfx_MinActiveFreq = input[idx + 4];
> +		activity_monitor->Gfx_BoosterFreqType = input[idx + 5];
> +		activity_monitor->Gfx_BoosterFreq = input[idx + 6];
> +		activity_monitor->Gfx_PD_Data_limit_c = input[idx + 7];
> +		activity_monitor->Gfx_PD_Data_error_coeff = input[idx + 8];
> +		activity_monitor->Gfx_PD_Data_error_rate_coeff = input[idx + 9];
> +	}
> +	idx = 1 * SIENNA_CICHLID_CUSTOM_PARAMS_COUNT;
> +	if (input[idx]) {
> +		/* Socclk */
> +		activity_monitor->Fclk_FPS = input[idx + 1];
> +		activity_monitor->Fclk_MinFreqStep = input[idx + 2];
> +		activity_monitor->Fclk_MinActiveFreqType = input[idx + 3];
> +		activity_monitor->Fclk_MinActiveFreq = input[idx + 4];
> +		activity_monitor->Fclk_BoosterFreqType = input[idx + 5];
> +		activity_monitor->Fclk_BoosterFreq = input[idx + 6];
> +		activity_monitor->Fclk_PD_Data_limit_c = input[idx + 7];
> +		activity_monitor->Fclk_PD_Data_error_coeff = input[idx + 8];
> +		activity_monitor->Fclk_PD_Data_error_rate_coeff = input[idx + 9];
> +	}
> +	idx = 2 * SIENNA_CICHLID_CUSTOM_PARAMS_COUNT;
> +	if (input[idx]) {
> +		/* Memclk */
> +		activity_monitor->Mem_FPS = input[idx + 1];
> +		activity_monitor->Mem_MinFreqStep = input[idx + 2];
> +		activity_monitor->Mem_MinActiveFreqType = input[idx + 3];
> +		activity_monitor->Mem_MinActiveFreq = input[idx + 4];
> +		activity_monitor->Mem_BoosterFreqType = input[idx + 5];
> +		activity_monitor->Mem_BoosterFreq = input[idx + 6];
> +		activity_monitor->Mem_PD_Data_limit_c = input[idx + 7];
> +		activity_monitor->Mem_PD_Data_error_coeff = input[idx + 8];
> +		activity_monitor->Mem_PD_Data_error_rate_coeff = input[idx + 9];
>  	}
>  
> -	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
> -		if (size != 10)
> -			return -EINVAL;
> +	ret = smu_cmn_update_table(smu,
> +				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
> +				   (void *)(&activity_monitor_external), true);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
> +		return ret;
> +	}
>  
> -		ret = smu_cmn_update_table(smu,
> -				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
> -				       (void *)(&activity_monitor_external), false);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
> -			return ret;
> -		}
> +	return ret;
> +}
>  
> -		switch (input[0]) {
> -		case 0: /* Gfxclk */
> -			activity_monitor->Gfx_FPS = input[1];
> -			activity_monitor->Gfx_MinFreqStep = input[2];
> -			activity_monitor->Gfx_MinActiveFreqType = input[3];
> -			activity_monitor->Gfx_MinActiveFreq = input[4];
> -			activity_monitor->Gfx_BoosterFreqType = input[5];
> -			activity_monitor->Gfx_BoosterFreq = input[6];
> -			activity_monitor->Gfx_PD_Data_limit_c = input[7];
> -			activity_monitor->Gfx_PD_Data_error_coeff = input[8];
> -			activity_monitor->Gfx_PD_Data_error_rate_coeff = input[9];
> -			break;
> -		case 1: /* Socclk */
> -			activity_monitor->Fclk_FPS = input[1];
> -			activity_monitor->Fclk_MinFreqStep = input[2];
> -			activity_monitor->Fclk_MinActiveFreqType = input[3];
> -			activity_monitor->Fclk_MinActiveFreq = input[4];
> -			activity_monitor->Fclk_BoosterFreqType = input[5];
> -			activity_monitor->Fclk_BoosterFreq = input[6];
> -			activity_monitor->Fclk_PD_Data_limit_c = input[7];
> -			activity_monitor->Fclk_PD_Data_error_coeff = input[8];
> -			activity_monitor->Fclk_PD_Data_error_rate_coeff = input[9];
> -			break;
> -		case 2: /* Memclk */
> -			activity_monitor->Mem_FPS = input[1];
> -			activity_monitor->Mem_MinFreqStep = input[2];
> -			activity_monitor->Mem_MinActiveFreqType = input[3];
> -			activity_monitor->Mem_MinActiveFreq = input[4];
> -			activity_monitor->Mem_BoosterFreqType = input[5];
> -			activity_monitor->Mem_BoosterFreq = input[6];
> -			activity_monitor->Mem_PD_Data_limit_c = input[7];
> -			activity_monitor->Mem_PD_Data_error_coeff = input[8];
> -			activity_monitor->Mem_PD_Data_error_rate_coeff = input[9];
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> +static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu,
> +						 u32 workload_mask,
> +						 long *custom_params,
> +						 u32 custom_params_max_idx)
> +{
> +	u32 backend_workload_mask = 0;
> +	int ret, idx = -1, i;
>  
> -		ret = smu_cmn_update_table(smu,
> -				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
> -				       (void *)(&activity_monitor_external), true);
> +	smu_cmn_get_backend_workload_mask(smu, workload_mask,
> +					  &backend_workload_mask);
> +
> +	if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
> +		if (!smu->custom_profile_params) {
> +			smu->custom_profile_params =
> +				kzalloc(SIENNA_CICHLID_CUSTOM_PARAMS_SIZE, GFP_KERNEL);
> +			if (!smu->custom_profile_params)
> +				return -ENOMEM;
> +		}
> +		if (custom_params && custom_params_max_idx) {
> +			if (custom_params_max_idx != SIENNA_CICHLID_CUSTOM_PARAMS_COUNT)
> +				return -EINVAL;
> +			if (custom_params[0] >= SIENNA_CICHLID_CUSTOM_PARAMS_CLOCK_COUNT)
> +				return -EINVAL;
> +			idx = custom_params[0] * SIENNA_CICHLID_CUSTOM_PARAMS_COUNT;
> +			smu->custom_profile_params[idx] = 1;
> +			for (i = 1; i < custom_params_max_idx; i++)
> +				smu->custom_profile_params[idx + i] = custom_params[i];
> +		}
> +		ret = sienna_cichlid_set_power_profile_mode_coeff(smu,
> +								  smu->custom_profile_params);
>  		if (ret) {
> -			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
> +			if (idx != -1)
> +				smu->custom_profile_params[idx] = 0;
>  			return ret;
>  		}
> +	} else if (smu->custom_profile_params) {
> +		memset(smu->custom_profile_params, 0, SIENNA_CICHLID_CUSTOM_PARAMS_SIZE);
>  	}
>  
> -	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> -	workload_type = smu_cmn_to_asic_specific_index(smu,
> -						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       smu->power_profile_mode);
> -	if (workload_type < 0)
> -		return -EINVAL;
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
> -				    1 << workload_type, NULL);
> -	if (ret)
> -		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
> +					      backend_workload_mask, NULL);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
> +			workload_mask);
> +		if (idx != -1)
> +			smu->custom_profile_params[idx] = 0;
> +		return ret;
> +	}
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index cd3e9ba3eff4..a55ea76d7399 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -1056,42 +1056,27 @@ static int vangogh_get_power_profile_mode(struct smu_context *smu,
>  	return size;
>  }
>  
> -static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
> +static int vangogh_set_power_profile_mode(struct smu_context *smu,
> +					  u32 workload_mask,
> +					  long *custom_params,
> +					  u32 custom_params_max_idx)
>  {
> -	int workload_type, ret;
> -	uint32_t profile_mode = input[size];
> +	u32 backend_workload_mask = 0;
> +	int ret;
>  
> -	if (profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
> -		return -EINVAL;
> -	}
> -
> -	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> -			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
> -		return 0;
> -
> -	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> -	workload_type = smu_cmn_to_asic_specific_index(smu,
> -						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       profile_mode);
> -	if (workload_type < 0) {
> -		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on VANGOGH\n",
> -					profile_mode);
> -		return -EINVAL;
> -	}
> +	smu_cmn_get_backend_workload_mask(smu, workload_mask,
> +					  &backend_workload_mask);
>  
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
> -				    1 << workload_type,
> -				    NULL);
> +					      backend_workload_mask,
> +					      NULL);
>  	if (ret) {
> -		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
> -					workload_type);
> +		dev_err_once(smu->adev->dev, "Fail to set workload mask 0x%08x\n",
> +			     workload_mask);
>  		return ret;
>  	}
>  
> -	smu->power_profile_mode = profile_mode;
> -
> -	return 0;
> +	return ret;
>  }
>  
>  static int vangogh_set_soft_freq_limited_range(struct smu_context *smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index a34797f3576b..37d82a71a2d7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -864,44 +864,27 @@ static int renoir_force_clk_levels(struct smu_context *smu,
>  	return ret;
>  }
>  
> -static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
> +static int renoir_set_power_profile_mode(struct smu_context *smu,
> +					 u32 workload_mask,
> +					 long *custom_params,
> +					 u32 custom_params_max_idx)
>  {
> -	int workload_type, ret;
> -	uint32_t profile_mode = input[size];
> +	int ret;
> +	u32 backend_workload_mask = 0;
>  
> -	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
> -		return -EINVAL;
> -	}
> -
> -	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> -			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
> -		return 0;
> -
> -	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> -	workload_type = smu_cmn_to_asic_specific_index(smu,
> -						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       profile_mode);
> -	if (workload_type < 0) {
> -		/*
> -		 * TODO: If some case need switch to powersave/default power mode
> -		 * then can consider enter WORKLOAD_COMPUTE/WORKLOAD_CUSTOM for power saving.
> -		 */
> -		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on RENOIR\n", profile_mode);
> -		return -EINVAL;
> -	}
> +	smu_cmn_get_backend_workload_mask(smu, workload_mask,
> +					  &backend_workload_mask);
>  
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
> -				    1 << workload_type,
> -				    NULL);
> +					      backend_workload_mask,
> +					      NULL);
>  	if (ret) {
> -		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
> +		dev_err_once(smu->adev->dev, "Failed to set workload mask 0x08%x\n",
> +			     workload_mask);
>  		return ret;
>  	}
>  
> -	smu->power_profile_mode = profile_mode;
> -
> -	return 0;
> +	return ret;
>  }
>  
>  static int renoir_set_peak_clock_by_device(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 199bdd9720d3..3aa705aae4c0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2571,82 +2571,76 @@ static int smu_v13_0_0_get_power_profile_mode(struct smu_context *smu,
>  	return size;
>  }
>  
> -static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
> -					      long *input,
> -					      uint32_t size)
> +#define SMU_13_0_0_CUSTOM_PARAMS_COUNT 9
> +#define SMU_13_0_0_CUSTOM_PARAMS_CLOCK_COUNT 2
> +#define SMU_13_0_0_CUSTOM_PARAMS_SIZE (SMU_13_0_0_CUSTOM_PARAMS_CLOCK_COUNT * SMU_13_0_0_CUSTOM_PARAMS_COUNT * sizeof(long))
> +
> +static int smu_v13_0_0_set_power_profile_mode_coeff(struct smu_context *smu,
> +						    long *input)
>  {
>  	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>  	DpmActivityMonitorCoeffInt_t *activity_monitor =
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
> -	int workload_type, ret = 0;
> -	u32 workload_mask, selected_workload_mask;
> -
> -	smu->power_profile_mode = input[size];
> +	int ret, idx;
>  
> -	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
> -		return -EINVAL;
> +	ret = smu_cmn_update_table(smu,
> +				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> +				   WORKLOAD_PPLIB_CUSTOM_BIT,
> +				   (void *)(&activity_monitor_external),
> +				   false);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
> +		return ret;
>  	}
>  
> -	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
> -		if (size != 9)
> -			return -EINVAL;
> -
> -		ret = smu_cmn_update_table(smu,
> -					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> -					   WORKLOAD_PPLIB_CUSTOM_BIT,
> -					   (void *)(&activity_monitor_external),
> -					   false);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
> -			return ret;
> -		}
> -
> -		switch (input[0]) {
> -		case 0: /* Gfxclk */
> -			activity_monitor->Gfx_FPS = input[1];
> -			activity_monitor->Gfx_MinActiveFreqType = input[2];
> -			activity_monitor->Gfx_MinActiveFreq = input[3];
> -			activity_monitor->Gfx_BoosterFreqType = input[4];
> -			activity_monitor->Gfx_BoosterFreq = input[5];
> -			activity_monitor->Gfx_PD_Data_limit_c = input[6];
> -			activity_monitor->Gfx_PD_Data_error_coeff = input[7];
> -			activity_monitor->Gfx_PD_Data_error_rate_coeff = input[8];
> -			break;
> -		case 1: /* Fclk */
> -			activity_monitor->Fclk_FPS = input[1];
> -			activity_monitor->Fclk_MinActiveFreqType = input[2];
> -			activity_monitor->Fclk_MinActiveFreq = input[3];
> -			activity_monitor->Fclk_BoosterFreqType = input[4];
> -			activity_monitor->Fclk_BoosterFreq = input[5];
> -			activity_monitor->Fclk_PD_Data_limit_c = input[6];
> -			activity_monitor->Fclk_PD_Data_error_coeff = input[7];
> -			activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> +	idx = 0 * SMU_13_0_0_CUSTOM_PARAMS_COUNT;
> +	if (input[idx]) {
> +		/* Gfxclk */
> +		activity_monitor->Gfx_FPS = input[idx + 1];
> +		activity_monitor->Gfx_MinActiveFreqType = input[idx + 2];
> +		activity_monitor->Gfx_MinActiveFreq = input[idx + 3];
> +		activity_monitor->Gfx_BoosterFreqType = input[idx + 4];
> +		activity_monitor->Gfx_BoosterFreq = input[idx + 5];
> +		activity_monitor->Gfx_PD_Data_limit_c = input[idx + 6];
> +		activity_monitor->Gfx_PD_Data_error_coeff = input[idx + 7];
> +		activity_monitor->Gfx_PD_Data_error_rate_coeff = input[idx + 8];
> +	}
> +	idx = 1 * SMU_13_0_0_CUSTOM_PARAMS_COUNT;
> +	if (input[idx]) {
> +		/* Fclk */
> +		activity_monitor->Fclk_FPS = input[idx + 1];
> +		activity_monitor->Fclk_MinActiveFreqType = input[idx + 2];
> +		activity_monitor->Fclk_MinActiveFreq = input[idx + 3];
> +		activity_monitor->Fclk_BoosterFreqType = input[idx + 4];
> +		activity_monitor->Fclk_BoosterFreq = input[idx + 5];
> +		activity_monitor->Fclk_PD_Data_limit_c = input[idx + 6];
> +		activity_monitor->Fclk_PD_Data_error_coeff = input[idx + 7];
> +		activity_monitor->Fclk_PD_Data_error_rate_coeff = input[idx + 8];
> +	}
>  
> -		ret = smu_cmn_update_table(smu,
> -					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> -					   WORKLOAD_PPLIB_CUSTOM_BIT,
> -					   (void *)(&activity_monitor_external),
> -					   true);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
> -			return ret;
> -		}
> +	ret = smu_cmn_update_table(smu,
> +				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> +				   WORKLOAD_PPLIB_CUSTOM_BIT,
> +				   (void *)(&activity_monitor_external),
> +				   true);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
> +		return ret;
>  	}
>  
> -	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> -	workload_type = smu_cmn_to_asic_specific_index(smu,
> -						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       smu->power_profile_mode);
> +	return ret;
> +}
>  
> -	if (workload_type < 0)
> -		return -EINVAL;
> +static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
> +					      u32 workload_mask,
> +					      long *custom_params,
> +					      u32 custom_params_max_idx)
> +{
> +	u32 backend_workload_mask = 0;
> +	int workload_type, ret, idx = -1, i;
>  
> -	selected_workload_mask = workload_mask = 1 << workload_type;
> +	smu_cmn_get_backend_workload_mask(smu, workload_mask,
> +					  &backend_workload_mask);
>  
>  	/* Add optimizations for SMU13.0.0/10.  Reuse the power saving profile */
>  	if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
> @@ -2658,15 +2652,48 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>  							       CMN2ASIC_MAPPING_WORKLOAD,
>  							       PP_SMC_POWER_PROFILE_POWERSAVING);
>  		if (workload_type >= 0)
> -			workload_mask |= 1 << workload_type;
> +			backend_workload_mask |= 1 << workload_type;
> +	}
> +
> +	if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
> +		if (!smu->custom_profile_params) {
> +			smu->custom_profile_params =
> +				kzalloc(SMU_13_0_0_CUSTOM_PARAMS_SIZE, GFP_KERNEL);
> +			if (!smu->custom_profile_params)
> +				return -ENOMEM;
> +		}
> +		if (custom_params && custom_params_max_idx) {
> +			if (custom_params_max_idx != SMU_13_0_0_CUSTOM_PARAMS_COUNT)
> +				return -EINVAL;
> +			if (custom_params[0] >= SMU_13_0_0_CUSTOM_PARAMS_CLOCK_COUNT)
> +				return -EINVAL;
> +			idx = custom_params[0] * SMU_13_0_0_CUSTOM_PARAMS_COUNT;
> +			smu->custom_profile_params[idx] = 1;
> +			for (i = 1; i < custom_params_max_idx; i++)
> +				smu->custom_profile_params[idx + i] = custom_params[i];
> +		}
> +		ret = smu_v13_0_0_set_power_profile_mode_coeff(smu,
> +							       smu->custom_profile_params);
> +		if (ret) {
> +			if (idx != -1)
> +				smu->custom_profile_params[idx] = 0;
> +			return ret;
> +		}
> +	} else if (smu->custom_profile_params) {
> +		memset(smu->custom_profile_params, 0, SMU_13_0_0_CUSTOM_PARAMS_SIZE);
>  	}
>  
>  	ret = smu_cmn_send_smc_msg_with_param(smu,
> -					       SMU_MSG_SetWorkloadMask,
> -					       workload_mask,
> -					       NULL);
> -	if (!ret)
> -		smu->workload_mask = selected_workload_mask;
> +					      SMU_MSG_SetWorkloadMask,
> +					      backend_workload_mask,
> +					      NULL);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
> +			workload_mask);
> +		if (idx != -1)
> +			smu->custom_profile_params[idx] = 0;
> +		return ret;
> +	}
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 34c1e0c7e1e4..f4ac403b8b36 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -2530,78 +2530,110 @@ do {													\
>  	return result;
>  }
>  
> -static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
> +#define SMU_13_0_7_CUSTOM_PARAMS_COUNT 8
> +#define SMU_13_0_7_CUSTOM_PARAMS_CLOCK_COUNT 2
> +#define SMU_13_0_7_CUSTOM_PARAMS_SIZE (SMU_13_0_7_CUSTOM_PARAMS_CLOCK_COUNT * SMU_13_0_7_CUSTOM_PARAMS_COUNT * sizeof(long))
> +
> +static int smu_v13_0_7_set_power_profile_mode_coeff(struct smu_context *smu,
> +						    long *input)
>  {
>  
>  	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>  	DpmActivityMonitorCoeffInt_t *activity_monitor =
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
> -	int workload_type, ret = 0;
> +	int ret, idx;
>  
> -	smu->power_profile_mode = input[size];
> +	ret = smu_cmn_update_table(smu,
> +				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
> +				   (void *)(&activity_monitor_external), false);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
> +		return ret;
> +	}
>  
> -	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
> -		return -EINVAL;
> +	idx = 0 * SMU_13_0_7_CUSTOM_PARAMS_COUNT;
> +	if (input[idx]) {
> +		/* Gfxclk */
> +		activity_monitor->Gfx_ActiveHystLimit = input[idx + 1];
> +		activity_monitor->Gfx_IdleHystLimit = input[idx + 2];
> +		activity_monitor->Gfx_FPS = input[idx + 3];
> +		activity_monitor->Gfx_MinActiveFreqType = input[idx + 4];
> +		activity_monitor->Gfx_BoosterFreqType = input[idx + 5];
> +		activity_monitor->Gfx_MinActiveFreq = input[idx + 6];
> +		activity_monitor->Gfx_BoosterFreq = input[idx + 7];
> +	}
> +	idx = 1 * SMU_13_0_7_CUSTOM_PARAMS_COUNT;
> +	if (input[idx]) {
> +		/* Fclk */
> +		activity_monitor->Fclk_ActiveHystLimit = input[idx + 1];
> +		activity_monitor->Fclk_IdleHystLimit = input[idx + 2];
> +		activity_monitor->Fclk_FPS = input[idx + 3];
> +		activity_monitor->Fclk_MinActiveFreqType = input[idx + 4];
> +		activity_monitor->Fclk_BoosterFreqType = input[idx + 5];
> +		activity_monitor->Fclk_MinActiveFreq = input[idx + 6];
> +		activity_monitor->Fclk_BoosterFreq = input[idx + 7];
>  	}
>  
> -	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
> -		if (size != 8)
> -			return -EINVAL;
> +	ret = smu_cmn_update_table(smu,
> +				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
> +				   (void *)(&activity_monitor_external), true);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
> +		return ret;
> +	}
>  
> -		ret = smu_cmn_update_table(smu,
> -				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
> -				       (void *)(&activity_monitor_external), false);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
> -			return ret;
> -		}
> +	return ret;
> +}
>  
> -		switch (input[0]) {
> -		case 0: /* Gfxclk */
> -			activity_monitor->Gfx_ActiveHystLimit = input[1];
> -			activity_monitor->Gfx_IdleHystLimit = input[2];
> -			activity_monitor->Gfx_FPS = input[3];
> -			activity_monitor->Gfx_MinActiveFreqType = input[4];
> -			activity_monitor->Gfx_BoosterFreqType = input[5];
> -			activity_monitor->Gfx_MinActiveFreq = input[6];
> -			activity_monitor->Gfx_BoosterFreq = input[7];
> -			break;
> -		case 1: /* Fclk */
> -			activity_monitor->Fclk_ActiveHystLimit = input[1];
> -			activity_monitor->Fclk_IdleHystLimit = input[2];
> -			activity_monitor->Fclk_FPS = input[3];
> -			activity_monitor->Fclk_MinActiveFreqType = input[4];
> -			activity_monitor->Fclk_BoosterFreqType = input[5];
> -			activity_monitor->Fclk_MinActiveFreq = input[6];
> -			activity_monitor->Fclk_BoosterFreq = input[7];
> -			break;
> -		default:
> -			return -EINVAL;
> +static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu,
> +					      u32 workload_mask,
> +					      long *custom_params,
> +					      u32 custom_params_max_idx)
> +{
> +	u32 backend_workload_mask = 0;
> +	int ret, idx = -1, i;
> +
> +	smu_cmn_get_backend_workload_mask(smu, workload_mask,
> +					  &backend_workload_mask);
> +
> +	if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
> +		if (!smu->custom_profile_params) {
> +			smu->custom_profile_params =
> +				kzalloc(SMU_13_0_7_CUSTOM_PARAMS_SIZE, GFP_KERNEL);
> +			if (!smu->custom_profile_params)
> +				return -ENOMEM;
>  		}
> -
> -		ret = smu_cmn_update_table(smu,
> -				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
> -				       (void *)(&activity_monitor_external), true);
> +		if (custom_params && custom_params_max_idx) {
> +			if (custom_params_max_idx != SMU_13_0_7_CUSTOM_PARAMS_COUNT)
> +				return -EINVAL;
> +			if (custom_params[0] >= SMU_13_0_7_CUSTOM_PARAMS_CLOCK_COUNT)
> +				return -EINVAL;
> +			idx = custom_params[0] * SMU_13_0_7_CUSTOM_PARAMS_COUNT;
> +			smu->custom_profile_params[idx] = 1;
> +			for (i = 1; i < custom_params_max_idx; i++)
> +				smu->custom_profile_params[idx + i] = custom_params[i];
> +		}
> +		ret = smu_v13_0_7_set_power_profile_mode_coeff(smu,
> +							       smu->custom_profile_params);
>  		if (ret) {
> -			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
> +			if (idx != -1)
> +				smu->custom_profile_params[idx] = 0;
>  			return ret;
>  		}
> +	} else if (smu->custom_profile_params) {
> +		memset(smu->custom_profile_params, 0, SMU_13_0_7_CUSTOM_PARAMS_SIZE);
>  	}
>  
> -	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> -	workload_type = smu_cmn_to_asic_specific_index(smu,
> -						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       smu->power_profile_mode);
> -	if (workload_type < 0)
> -		return -EINVAL;
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
> -				    1 << workload_type, NULL);
> +					      backend_workload_mask, NULL);
>  
> -	if (ret)
> -		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
> -	else
> -		smu->workload_mask = (1 << workload_type);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
> +			workload_mask);
> +		if (idx != -1)
> +			smu->custom_profile_params[idx] = 0;
> +		return ret;
> +	}
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 98e01a06add8..6a565ce74d5b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -1739,90 +1739,120 @@ static int smu_v14_0_2_get_power_profile_mode(struct smu_context *smu,
>  	return size;
>  }
>  
> -static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
> -					      long *input,
> -					      uint32_t size)
> +#define SMU_14_0_2_CUSTOM_PARAMS_COUNT 9
> +#define SMU_14_0_2_CUSTOM_PARAMS_CLOCK_COUNT 2
> +#define SMU_14_0_2_CUSTOM_PARAMS_SIZE (SMU_14_0_2_CUSTOM_PARAMS_CLOCK_COUNT * SMU_14_0_2_CUSTOM_PARAMS_COUNT * sizeof(long))
> +
> +static int smu_v14_0_2_set_power_profile_mode_coeff(struct smu_context *smu,
> +						    long *input)
>  {
>  	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>  	DpmActivityMonitorCoeffInt_t *activity_monitor =
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
> -	int workload_type, ret = 0;
> -	uint32_t current_profile_mode = smu->power_profile_mode;
> -	smu->power_profile_mode = input[size];
> +	int ret, idx;
>  
> -	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
> -		return -EINVAL;
> +	ret = smu_cmn_update_table(smu,
> +				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> +				   WORKLOAD_PPLIB_CUSTOM_BIT,
> +				   (void *)(&activity_monitor_external),
> +				   false);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
> +		return ret;
>  	}
>  
> -	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
> -		if (size != 9)
> -			return -EINVAL;
> +	idx = 0 * SMU_14_0_2_CUSTOM_PARAMS_COUNT;
> +	if (input[idx]) {
> +		/* Gfxclk */
> +		activity_monitor->Gfx_FPS = input[idx + 1];
> +		activity_monitor->Gfx_MinActiveFreqType = input[idx + 2];
> +		activity_monitor->Gfx_MinActiveFreq = input[idx + 3];
> +		activity_monitor->Gfx_BoosterFreqType = input[idx + 4];
> +		activity_monitor->Gfx_BoosterFreq = input[idx + 5];
> +		activity_monitor->Gfx_PD_Data_limit_c = input[idx + 6];
> +		activity_monitor->Gfx_PD_Data_error_coeff = input[idx + 7];
> +		activity_monitor->Gfx_PD_Data_error_rate_coeff = input[idx + 8];
> +	}
> +	idx = 1 * SMU_14_0_2_CUSTOM_PARAMS_COUNT;
> +	if (input[idx]) {
> +		/* Fclk */
> +		activity_monitor->Fclk_FPS = input[idx + 1];
> +		activity_monitor->Fclk_MinActiveFreqType = input[idx + 2];
> +		activity_monitor->Fclk_MinActiveFreq = input[idx + 3];
> +		activity_monitor->Fclk_BoosterFreqType = input[idx + 4];
> +		activity_monitor->Fclk_BoosterFreq = input[idx + 5];
> +		activity_monitor->Fclk_PD_Data_limit_c = input[idx + 6];
> +		activity_monitor->Fclk_PD_Data_error_coeff = input[idx + 7];
> +		activity_monitor->Fclk_PD_Data_error_rate_coeff = input[idx + 8];
> +	}
>  
> -		ret = smu_cmn_update_table(smu,
> -					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> -					   WORKLOAD_PPLIB_CUSTOM_BIT,
> -					   (void *)(&activity_monitor_external),
> -					   false);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
> -			return ret;
> -		}
> +	ret = smu_cmn_update_table(smu,
> +				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> +				   WORKLOAD_PPLIB_CUSTOM_BIT,
> +				   (void *)(&activity_monitor_external),
> +				   true);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
> +		return ret;
> +	}
>  
> -		switch (input[0]) {
> -		case 0: /* Gfxclk */
> -			activity_monitor->Gfx_FPS = input[1];
> -			activity_monitor->Gfx_MinActiveFreqType = input[2];
> -			activity_monitor->Gfx_MinActiveFreq = input[3];
> -			activity_monitor->Gfx_BoosterFreqType = input[4];
> -			activity_monitor->Gfx_BoosterFreq = input[5];
> -			activity_monitor->Gfx_PD_Data_limit_c = input[6];
> -			activity_monitor->Gfx_PD_Data_error_coeff = input[7];
> -			activity_monitor->Gfx_PD_Data_error_rate_coeff = input[8];
> -			break;
> -		case 1: /* Fclk */
> -			activity_monitor->Fclk_FPS = input[1];
> -			activity_monitor->Fclk_MinActiveFreqType = input[2];
> -			activity_monitor->Fclk_MinActiveFreq = input[3];
> -			activity_monitor->Fclk_BoosterFreqType = input[4];
> -			activity_monitor->Fclk_BoosterFreq = input[5];
> -			activity_monitor->Fclk_PD_Data_limit_c = input[6];
> -			activity_monitor->Fclk_PD_Data_error_coeff = input[7];
> -			activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> +	return ret;
> +}
>  
> -		ret = smu_cmn_update_table(smu,
> -					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> -					   WORKLOAD_PPLIB_CUSTOM_BIT,
> -					   (void *)(&activity_monitor_external),
> -					   true);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
> -			return ret;
> -		}
> -	}
> +static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
> +					      u32 workload_mask,
> +					      long *custom_params,
> +					      u32 custom_params_max_idx)
> +{
> +	u32 backend_workload_mask = 0;
> +	int ret, idx = -1, i;
> +
> +	smu_cmn_get_backend_workload_mask(smu, workload_mask,
> +					  &backend_workload_mask);
>  
> -	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
> +	/* disable deep sleep if compute is enabled */
> +	if (workload_mask & (1 << PP_SMC_POWER_PROFILE_COMPUTE))
>  		smu_v14_0_deep_sleep_control(smu, false);
> -	else if (current_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
> +	else
>  		smu_v14_0_deep_sleep_control(smu, true);
>  
> -	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> -	workload_type = smu_cmn_to_asic_specific_index(smu,
> -						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       smu->power_profile_mode);
> -	if (workload_type < 0)
> -		return -EINVAL;
> +	if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
> +		if (!smu->custom_profile_params) {
> +			smu->custom_profile_params =
> +				kzalloc(SMU_14_0_2_CUSTOM_PARAMS_SIZE, GFP_KERNEL);
> +			if (!smu->custom_profile_params)
> +				return -ENOMEM;
> +		}
> +		if (custom_params && custom_params_max_idx) {
> +			if (custom_params_max_idx != SMU_14_0_2_CUSTOM_PARAMS_COUNT)
> +				return -EINVAL;
> +			if (custom_params[0] >= SMU_14_0_2_CUSTOM_PARAMS_CLOCK_COUNT)
> +				return -EINVAL;
> +			idx = custom_params[0] * SMU_14_0_2_CUSTOM_PARAMS_COUNT;
> +			smu->custom_profile_params[idx] = 1;
> +			for (i = 1; i < custom_params_max_idx; i++)
> +				smu->custom_profile_params[idx + i] = custom_params[i];
> +		}
> +		ret = smu_v14_0_2_set_power_profile_mode_coeff(smu,
> +							       smu->custom_profile_params);
> +		if (ret) {
> +			if (idx != -1)
> +				smu->custom_profile_params[idx] = 0;
> +			return ret;
> +		}
> +	} else if (smu->custom_profile_params) {
> +		memset(smu->custom_profile_params, 0, SMU_14_0_2_CUSTOM_PARAMS_SIZE);
> +	}
>  
> -	ret = smu_cmn_send_smc_msg_with_param(smu,
> -					       SMU_MSG_SetWorkloadMask,
> -					       1 << workload_type,
> -					       NULL);
> -	if (!ret)
> -		smu->workload_mask = 1 << workload_type;
> +	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
> +					      backend_workload_mask, NULL);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
> +			workload_mask);
> +		if (idx != -1)
> +			smu->custom_profile_params[idx] = 0;
> +		return ret;
> +	}
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 007a81e108ec..8f92b2777726 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -1221,3 +1221,28 @@ void smu_cmn_generic_plpd_policy_desc(struct smu_dpm_policy *policy)
>  {
>  	policy->desc = &xgmi_plpd_policy_desc;
>  }
> +
> +void smu_cmn_get_backend_workload_mask(struct smu_context *smu,
> +				       u32 workload_mask,
> +				       u32 *backend_workload_mask)
> +{
> +	int workload_type;
> +	u32 profile_mode;
> +
> +	*backend_workload_mask = 0;
> +
> +	for (profile_mode = 0; profile_mode < PP_SMC_POWER_PROFILE_COUNT; profile_mode++) {
> +		if (!(workload_mask & (1 << profile_mode)))
> +			continue;
> +
> +		/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> +		workload_type = smu_cmn_to_asic_specific_index(smu,
> +							       CMN2ASIC_MAPPING_WORKLOAD,
> +							       profile_mode);
> +
> +		if (workload_type < 0)
> +			continue;
> +
> +		*backend_workload_mask |= 1 << workload_type;
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index 1de685defe85..a020277dec3e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -147,5 +147,9 @@ bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev);
>  void smu_cmn_generic_soc_policy_desc(struct smu_dpm_policy *policy);
>  void smu_cmn_generic_plpd_policy_desc(struct smu_dpm_policy *policy);
>  
> +void smu_cmn_get_backend_workload_mask(struct smu_context *smu,
> +				       u32 workload_mask,
> +				       u32 *backend_workload_mask);
> +
>  #endif
>  #endif
