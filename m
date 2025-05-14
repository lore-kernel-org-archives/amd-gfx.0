Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1B6C3ABDA
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 07:25:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32B4910E257;
	Wed, 14 May 2025 07:25:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GugKFD/a";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95FD410E257
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 07:25:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPeT4gU3SzBWEvxbO40vV9UW38MtNTF1GSf2Ac0OFXO1zdTT8+UuGvLfOOHZxX+MosZv08xbtvDjzEmZKb6DHd4CuLlNxb4dMKpVEVzSaVJ2AUWF29TW+NsOiC9zf8Sl1FvsiXtP1D+taJYsmNKSegahoIkfkJfa5lGN8HHtp5wyM6iywFRjlEOteo0PbytuITHy2Bn7T+1a2YUdje4ILwTNRrj5oVC3vzpu0Ssx2ZnhiafiZASzl5T5dvAYdRqozdCjvaP+jaNw74RgPwzfuogYsmZL72Q+oa3G1uipceUN7hiVMhL0c+5nnCY7c/qJlvjgiTHAQ9m3FOVqd1mLjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wc+jaqAjehTGSLieuBezgz5Tlh8q0njUK3u1K38O8Wk=;
 b=xXhCYK1y7IN6EDhL1nrPcE25jYysfs0uPLuTpQTZfjJ8oDGCOfC2jl4Lembv5coM9qwqHwhbk3aXLb+ktWIpgNQcIngo+Scp4mrYLX9pauQURCSZXIFYryryAaTquNwfElyBRQXnBodKx3XeJBgwZEmEDa/fVq2RiC+8AT/m85QCy18W2opfsROC1/rpNr5gF5o4vQHdw3HaSV3NFWWO9WksyOEp50jFtmTPfrqHrU6Co7k4yyizEeEpu0ibz/gbttu5cdGbIp0y4gJATvp2ue4O/A6z3S5EuEjrDckhahj/GfL1ipXMfr/Wk+9pzOQIk13oqB++8Qxj9DIyeGmEUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wc+jaqAjehTGSLieuBezgz5Tlh8q0njUK3u1K38O8Wk=;
 b=GugKFD/aFIDAEdcMXlTEqwLM3Kksq1UEhIbjZr3IxvdjntJJ8CXwhk06WmyLO8/qHGD/YZDUGxc4qnZH3tANbAppB8Uw5QQkoIJspgyj5JZjT6CCg0wZveD9ffdAPZi2u25t70mV+hK8B5cRBoTY1jzTLFtk7Vg8EBM6THCLXWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB8067.namprd12.prod.outlook.com (2603:10b6:930:74::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.28; Wed, 14 May 2025 07:25:31 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 07:25:31 +0000
Message-ID: <1d0b618e-d45e-40e1-8b3d-0edd893936ea@amd.com>
Date: Wed, 14 May 2025 12:55:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: add debugfs for spirom IFWI dump
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: Shiwu Zhang <shiwu.zhang@amd.com>, Hawking.Zhang@amd.com,
 Likun.Gao@amd.com, amd-gfx@lists.freedesktop.org
References: <20250514062145.82529-1-shiwu.zhang@amd.com>
 <e0bc2b98-99b2-4f66-ab74-ca085f4b3847@amd.com>
Content-Language: en-US
In-Reply-To: <e0bc2b98-99b2-4f66-ab74-ca085f4b3847@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ae::11) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a91e31d-038c-4664-78b4-08dd92b88225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVhOWURQUk1EM0lSVFp4RTNHVGdRYUl5eTVvQTJzd1pQdTN6b1lPbVBTR0gr?=
 =?utf-8?B?NkdLTDE4bEI5d3JZUVdpQ0ZySG9hYjlhazRsK1NGVmpWbEFkTEdwZTdIWDJE?=
 =?utf-8?B?L29aYVJtTXhOcjIwWmxEZUdiSGRSNW5zaCtubktZN1dTdXlvOHU4b0REOE5I?=
 =?utf-8?B?Mmg5QTR0RElXeWdWd2pmYmlxMDJ0REdTTXc3dTY5UUl5aGI0ZGl2Qlczank1?=
 =?utf-8?B?dzRab2pwWE1RTlZRVk81RURpV1E1TFJiT2RERXZnMnVpc0hvNmhsNWRJKytV?=
 =?utf-8?B?UGxsR0dyZnA2b3dzeGRHOHBjaUJFZ2xBUWQ2c0MxaTJIbjJ4ejVwTUhiK05w?=
 =?utf-8?B?N1dtZzRwTWRIbm04L2RUWUZIM1pjc1UxbER5eUlabFFMODFJdldIZVR2d2Rt?=
 =?utf-8?B?RXZZM1QyMnVXcEZaNUx5TXRiY3VROWNSNzBiejFtY21sd0FOS0l2SzFnSnU2?=
 =?utf-8?B?dk1pdm5mY3lXbGZhbExBbGtUdmlzRHVjcFVER0RsNFY3KzVWcndpS0RVYVA1?=
 =?utf-8?B?REpYeW4yZGwzNnZxdWFVa3hEWFhwZFVkcjBwR2FpR2hhNjVyR2hkZDJydGc2?=
 =?utf-8?B?SEtBdjJ0U2ZEZ3FGS25SWElpQ3BSbVV0WXRVLzNTNnpGOVA4QWFLWnVmL0Fo?=
 =?utf-8?B?WDdIQUgra09uTXJ1c1lkdUNSVFNqZDhLZlo5TVAzcVBPUElwNld5TGN0dTR2?=
 =?utf-8?B?VXZoUGN5ZUN3QzdtMHFkSjZyUmY2ekNiRzJ0eXlYZVRjamc5YTk0MWQ5dkVE?=
 =?utf-8?B?WkI2dVpjcDgrNWgvOWxiRnBaSFZNaFMrdzA3dFYzT3A4cDl4SmVnWks5YVhS?=
 =?utf-8?B?d3R6RUN0WENYUE45bEpzRG56Y1V6amFDS3RlUmJQdnltUWhkaTNXQXZwZkgr?=
 =?utf-8?B?QzJFRTVUQUgxODY2UGVnN1ZwRktwdWtuRWpkUXdhazdoZUhNaEpyUXdHZXZp?=
 =?utf-8?B?ekVYNEQ2WlhjeGoveTNTNlNqM0w1SERmcFFoVjJjYzY4TnlLcklUbXpROCtB?=
 =?utf-8?B?UDAvZWNXRDB4bEFoMEE3eGdiREFIeGR5Uk9BTUdjZjZlWlg3OU5xQkljTDJj?=
 =?utf-8?B?RXZRREpqQThTYW1vaW02bFJEbXdsMUY1R2ZMbHFha1BJZ2IxRWxBUTFodWl6?=
 =?utf-8?B?cDArWGVqaFdIV3FRMVVsVnVnWW55M3pSSFRSdWxqRWJ4WDE2d2J1blQyNW9o?=
 =?utf-8?B?VWFHVGwrZjdiQTVHbEZoWFZzNTVRVzkvMzlKQ2J0VlVMTUlrMjJSS0o3ejFF?=
 =?utf-8?B?U0VYM0lsTnZ6Q3EyLzhKRkxmWEJscVU4UE04ckl6MGpQME1jQkxyblJlVGRL?=
 =?utf-8?B?NGErK0Rqc2xVL2JSNVFKQTFiNTJzS3RDY2gyc2pxbHpCMlYxNDd6K1lTd29C?=
 =?utf-8?B?b2lqYUs1T1lTQzJHQTJzRGdhYnpOTUE4d2Z5TXJpY2xkWTFXeDAwck04cDFY?=
 =?utf-8?B?OHA3S1JjZlc4MGkxSkx0Q3ExSzdPV1hOSE5LSFJzWnE5VzVGMXRXUjFrV3d3?=
 =?utf-8?B?ajg4K2tuL2tOS1ovVGZydGl3R2RzSVlzNVpzV0hvd3lqY0oyV2Q1cjVSN1dw?=
 =?utf-8?B?KzZYYjBIZjBIMFlHeUhEU2RyeXlJL3ZReUdCUytZS3FzcGJ5THI2djhka2Vj?=
 =?utf-8?B?c25GbndRRXRTcEtNVlFhU3lrQUQ1ZnFvNFRDOGg1RS93eWhianZGWmMvK0h3?=
 =?utf-8?B?WUhYZ2IyMUNSRzBkbEdncGdnUXlLVTVrdjZseXhBNlUvTU80NzZCRERLWFNn?=
 =?utf-8?B?YjZHbnRtcDBpZ28vOEZsMTlmUGJ2Nk45cEpIUmtqY2tHeTUrOXVCanM4MXBu?=
 =?utf-8?B?SkhsWEd5VjY1bmdobTlEOGR1QjlFRmpKQ2pLcnZmQmNKN0s3SUxzL3dvOTkv?=
 =?utf-8?B?cU15b0o5KzJPL2VJNllyQUh4RzVTT2xnKytqUjVIdkNKYno2bWpnK1F4NGd3?=
 =?utf-8?Q?KMLDqAICWyc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE5pbURnUWVMWHMvNTFPYkhLL0hjZkFFVHhzNDVVQm1IeU8zcjJBSm8zRFRJ?=
 =?utf-8?B?am9wajg0a1czT0RublY1eWJQQVdQVEFIWi91Z0VjWno2eG50bEhRNUhseUtI?=
 =?utf-8?B?d1pJTWo0b1VMM2FSK3BvN2pkMWpJNWxyTXIxcEM5bDdLQlJHRlcwOEtOWHBq?=
 =?utf-8?B?ZUpXdGlscmt1SDJUVUVTSDBVb2svT21lampQbGdWaDFnekwxVXpPc0YrRGhx?=
 =?utf-8?B?Z3pGMEVDd1MrQUVwM1QxbDZFdEV2SHpUQmRHaDhuK3FEcEQ4Q1FwUXlBQVlz?=
 =?utf-8?B?WWxvaDhWTDdpTkQvNkIyZE9GbzI3M1hCNk5oUHdSSytHN1g3ejhiSXRZVmVv?=
 =?utf-8?B?NU5QZmJyQjhaMENHR1QvUjRUV1VRMHlHY2tlb05qOFBDNzU3ektPSnZ6ZVUz?=
 =?utf-8?B?V0ROTlMyQjUzd08xTXlZNkkwTEhIOWZGa2xqZ05QTnZweUFXa3BHRGRUQzJi?=
 =?utf-8?B?WXg0YlRucHNMMGdpZ0lSVTUvUk5PQVNZTmw2MndFZDF4L2huTHBUaVJqMHZW?=
 =?utf-8?B?M04rcWVVNEpXVFkxQ1ZERVJvRnJYeGZycjkvQ2xPcm80MlZ1Z0QvS1dobThO?=
 =?utf-8?B?S1Mrb0s2TnZwZkVnZmRubzdrK3hQS1RNejd1T01aR2ZpQUhPNm40L09EcXBY?=
 =?utf-8?B?bUpvL2dOZmJSVGFkcHQxQWRXSnBEVHgvWmNFeGZyREJmN0FKUU9uM0k2QmRR?=
 =?utf-8?B?ZnNvN2dleDlRbHBrdSt0L05YaGdEWGpqa3g2U2pxZG9RTnMxUGgyekxZWUN6?=
 =?utf-8?B?dWEyK3IxZ0htaXpyd2lpT3FhWUZOY3IwZTV1bXBuOVNFekVoYmRHSEdQYTN3?=
 =?utf-8?B?ajlETENhd2RuN2dWSDd4SG40bFovUVpxcG1EVEs4NGw5a2JlVHI3Z3FFTjgw?=
 =?utf-8?B?MnI0N2tueGxiUmFLY0RwMFBSWFJTaC91L1pLVmZERVA3SXpnbEdYVGUrUGZG?=
 =?utf-8?B?ckhWZ3pWVXZNQUdiR2E0NzAveSs2QThJRFNLbTdiVURreEVKRWhQT2JGcUNj?=
 =?utf-8?B?UkxzdjEvMWIxM053amF2TVBLaGY4cEVJVlZCKytFRGpnRmRpM29GRDVtMGtm?=
 =?utf-8?B?bmxXY2pDKy9MUFhaZjlNNkpVWk56Y21TS09rMkZDUnlydEtTSyt6dVlrck1N?=
 =?utf-8?B?SzdzSFlyY3MyUzhNU09qeGNsdUxxeGs1YXpaa0pRTG9HTmhpQVY0U3IwQzN2?=
 =?utf-8?B?K3Z4NTBTQy9ZUWZNTWlZK0ttWXIxRnhUMjFkVkJrVVh2c2d0UHp4d3pHaDBx?=
 =?utf-8?B?N2VXb3lJN3RxemJXMWtMSDlXS00yUE5ZdUYzV0Y5b3EvMjZ1YnBtSlIwcEVL?=
 =?utf-8?B?VDJPYmU1ZDdMM3prVTFaUm9HaW9odnpNZm1pdTBHa2JwVFlLcHYrOWtnMmhW?=
 =?utf-8?B?anYvN29QemlZTkhobVFjOExLS3o4ZHlhWUVpY2dCejRHOHpid3FTNTRtc01D?=
 =?utf-8?B?eVBEVVprM1IzcUJpOTl1cFpTd050VU0rRVB2U3gyZmZVbFpnVmJjVmRhSEVi?=
 =?utf-8?B?ZmVzY2tNc2dIdGZZMjF2R3BFZU9GbnlseDQ3YXV5bkVQbDMwWlBBclg4Q0dm?=
 =?utf-8?B?dzl3UlRZenpOWXY1aXB2ZnNpM0p1RFovLzN4YXVYV09EaEx6NWovbjZiMGt1?=
 =?utf-8?B?aFJIa1JuNmhGajZWVGFXbkxkUGlpWmk3b0thczJpU205TWlkVFpoQXBjS2VU?=
 =?utf-8?B?OHZxVzhCZ1VnT1ZJbjIwSURNK01lS3VlWUVnNitTb0kzUFFwQzBFcHh5VFdL?=
 =?utf-8?B?amw0M09ib1pEQkRXZGxXdm8vVkN4aURQMFlraGdGbmQzZjdnN3BZN1pTQkZB?=
 =?utf-8?B?cjRoZVBsTGhMcDFSeEJSNG14WnBiNFl0R0hRZnR6d0psd1p4Zjg2MTh4ZzBS?=
 =?utf-8?B?TVJSM0Qza0hsMWVXZUxGdEhwQUJlT2sxY3hzUHNEUElMQzYvdUhSTEFOWUtY?=
 =?utf-8?B?MEViVjVwdTd4dEcyL3RpbDRNbFEveGhha0FHVnBjb2FPVHhoRkd5ckFpUVRs?=
 =?utf-8?B?d01DRmE5Mm9qeU9BdFlqNFRkemIwWFRnaDhFTnBHYnFaZ2h4QjdyWmNscngw?=
 =?utf-8?B?THFkczByUVB0WnVrSU9SMU56RHJQa0hVVUVHN054Rkx2TmV3bXlmL3RhYnVP?=
 =?utf-8?Q?aW7Srf0qjDeOuajUHFhunGE5Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a91e31d-038c-4664-78b4-08dd92b88225
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 07:25:31.5020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQY5TIN9+iFlm73/Rpy3UTGD9lNk6rDptFj3ZGli7vJnH2Qpuh6l6cM8BjVSmhVM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8067
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



On 5/14/2025 12:53 PM, Lazar, Lijo wrote:
> 
> 
> On 5/14/2025 11:51 AM, Shiwu Zhang wrote:
>> Expose the debugfs file node for user space to dump the IFWI image
>> on spirom.
>>
>> For one transaction between PSP and host, it will read out the
>> images on both active and inactive partitions so a buffer with two
>> times the size of maximum IFWI image (currently 16MByte) is needed.
>>
>> v2: move the vbios gfl macros to the common header and rename the
>>     bo triplet struct to spirom_bo for this specfic usage (Hawking)
>>
>> v3: return directly the result of last command execution (Lijo)
>>
>> Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   1 +
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c     | 104 ++++++++++++++++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h     |  29 ++++++
>>  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c      |  44 +++++++--
>>  4 files changed, 168 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 4835123c99f3..bfa3b1519d4c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -2113,6 +2113,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>  	amdgpu_rap_debugfs_init(adev);
>>  	amdgpu_securedisplay_debugfs_init(adev);
>>  	amdgpu_fw_attestation_debugfs_init(adev);
>> +	amdgpu_psp_debugfs_init(adev);
>>  
>>  	debugfs_create_file("amdgpu_evict_vram", 0400, root, adev,
>>  			    &amdgpu_evict_vram_fops);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> index 6f9bcffda875..3a27ce75f80c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> @@ -4185,6 +4185,110 @@ const struct attribute_group amdgpu_flash_attr_group = {
>>  	.is_visible = amdgpu_flash_attr_is_visible,
>>  };
>>  
>> +#if defined(CONFIG_DEBUG_FS)
>> +static int psp_read_spirom_debugfs_open(struct inode *inode, struct file *filp)
>> +{
>> +	struct amdgpu_device *adev = filp->f_inode->i_private;
>> +	struct spirom_bo *bo_triplet;
>> +	int ret;
>> +
>> +	/* serialize the open() file calling */
>> +	if (!mutex_trylock(&adev->psp.mutex))
>> +		return -EBUSY;
>> +
>> +	/*
>> +	 * make sure only one userpace process is alive for dumping so that
>> +	 * only one memory buffer of AMD_VBIOS_FILE_MAX_SIZE * 2 is consumed.
>> +	 * let's say the case where one process try opening the file while
>> +	 * another one has proceeded to read or release. In this way, eliminate
>> +	 * the use of mutex for read() or release() callback as well.
>> +	 */
>> +	if (adev->psp.spirom_dump_trip) {
>> +		mutex_unlock(&adev->psp.mutex);
>> +		return -EBUSY;
>> +	}
>> +
> 
> Didn't notice this before. Once rom buffer is allocated/read, you could
> allow multiple reads at the same time. FS backend will handle that.
> Release is called only when all references to the file is closed.
> 
> For ex: in open, you could do like
> 
> 	if (file_count(filp) > 1)
Correction -
	if (file_count(filp))

Thanks,
Lijo

> 		return 0;
> 
> If the file is successfully opened by someone else we have a valid rom
> buffer available. Rest of the ops like read/seek etc. are handled
> properly by FS. Once all users do close(fd), release() is called and
> that time we are also releasing the rom buffer.
> 
> Thanks,
> Lijo
> 
>> +	bo_triplet = kzalloc(sizeof(struct spirom_bo), GFP_KERNEL);
>> +	if (!bo_triplet) {
>> +		mutex_unlock(&adev->psp.mutex);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	ret = amdgpu_bo_create_kernel(adev, AMD_VBIOS_FILE_MAX_SIZE_B * 2,
>> +					AMDGPU_GPU_PAGE_SIZE,
>> +					AMDGPU_GEM_DOMAIN_GTT,
>> +					&bo_triplet->bo,
>> +					&bo_triplet->mc_addr,
>> +					&bo_triplet->cpu_addr);
>> +	if (ret)
>> +		goto rel_trip;
>> +
>> +	ret = psp_dump_spirom(&adev->psp, bo_triplet->mc_addr);
>> +	if (ret)
>> +		goto rel_bo;
>> +
>> +	adev->psp.spirom_dump_trip = bo_triplet;
>> +	mutex_unlock(&adev->psp.mutex);
>> +	return 0;
>> +rel_bo:
>> +	amdgpu_bo_free_kernel(&bo_triplet->bo, &bo_triplet->mc_addr,
>> +			      &bo_triplet->cpu_addr);
>> +rel_trip:
>> +	kfree(bo_triplet);
>> +	mutex_unlock(&adev->psp.mutex);
>> +	dev_err(adev->dev, "Trying IFWI dump fails, err = %d\n", ret);
>> +	return ret;
>> +}
>> +
>> +static ssize_t psp_read_spirom_debugfs_read(struct file *filp, char __user *buf, size_t size,
>> +				loff_t *pos)
>> +{
>> +	struct amdgpu_device *adev = filp->f_inode->i_private;
>> +	struct spirom_bo *bo_triplet = adev->psp.spirom_dump_trip;
>> +
>> +	if (!bo_triplet)
>> +		return -EINVAL;
>> +
>> +	return simple_read_from_buffer(buf,
>> +				       size,
>> +				       pos, bo_triplet->cpu_addr,
>> +				       AMD_VBIOS_FILE_MAX_SIZE_B * 2);
>> +}
>> +
>> +static int psp_read_spirom_debugfs_release(struct inode *inode, struct file *filp)
>> +{
>> +	struct amdgpu_device *adev = filp->f_inode->i_private;
>> +	struct spirom_bo *bo_triplet = adev->psp.spirom_dump_trip;
>> +
>> +	if (bo_triplet) {
>> +		amdgpu_bo_free_kernel(&bo_triplet->bo, &bo_triplet->mc_addr,
>> +				      &bo_triplet->cpu_addr);
>> +		kfree(bo_triplet);
>> +	}
>> +
>> +	adev->psp.spirom_dump_trip = NULL;
>> +	return 0;
>> +}
>> +
>> +static const struct file_operations psp_dump_spirom_debugfs_ops = {
>> +	.owner = THIS_MODULE,
>> +	.open = psp_read_spirom_debugfs_open,
>> +	.read = psp_read_spirom_debugfs_read,
>> +	.release = psp_read_spirom_debugfs_release,
>> +	.llseek = default_llseek,
>> +};
>> +#endif
>> +
>> +void amdgpu_psp_debugfs_init(struct amdgpu_device *adev)
>> +{
>> +#if defined(CONFIG_DEBUG_FS)
>> +	struct drm_minor *minor = adev_to_drm(adev)->primary;
>> +
>> +	debugfs_create_file_size("psp_spirom_dump", 0444, minor->debugfs_root,
>> +				adev, &psp_dump_spirom_debugfs_ops, AMD_VBIOS_FILE_MAX_SIZE_B * 2);
>> +#endif
>> +}
>> +
>>  const struct amd_ip_funcs psp_ip_funcs = {
>>  	.name = "psp",
>>  	.early_init = psp_early_init,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
>> index 3876ac57ce62..089b6ae48329 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
>> @@ -39,6 +39,18 @@
>>  #define PSP_TMR_ALIGNMENT	0x100000
>>  #define PSP_FW_NAME_LEN		0x24
>>  
>> +/* VBIOS gfl defines */
>> +#define MBOX_READY_MASK 0x80000000
>> +#define MBOX_STATUS_MASK 0x0000FFFF
>> +#define MBOX_COMMAND_MASK 0x00FF0000
>> +#define MBOX_READY_FLAG 0x80000000
>> +#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_LO 0x2
>> +#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_HI 0x3
>> +#define C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE 0x4
>> +#define C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_LO 0xf
>> +#define C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI 0x10
>> +#define C2PMSG_CMD_SPI_GET_FLASH_IMAGE 0x11
>> +
>>  extern const struct attribute_group amdgpu_flash_attr_group;
>>  
>>  enum psp_shared_mem_size {
>> @@ -138,6 +150,7 @@ struct psp_funcs {
>>  	int (*load_usbc_pd_fw)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
>>  	int (*read_usbc_pd_fw)(struct psp_context *psp, uint32_t *fw_ver);
>>  	int (*update_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
>> +	int (*dump_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
>>  	int (*vbflash_stat)(struct psp_context *psp);
>>  	int (*fatal_error_recovery_quirk)(struct psp_context *psp);
>>  	bool (*get_ras_capability)(struct psp_context *psp);
>> @@ -322,6 +335,14 @@ struct psp_runtime_scpm_entry {
>>  	enum psp_runtime_scpm_authentication scpm_status;
>>  };
>>  
>> +#if defined(CONFIG_DEBUG_FS)
>> +struct spirom_bo {
>> +	struct amdgpu_bo *bo;
>> +	uint64_t mc_addr;
>> +	void *cpu_addr;
>> +};
>> +#endif
>> +
>>  struct psp_context {
>>  	struct amdgpu_device		*adev;
>>  	struct psp_ring			km_ring;
>> @@ -409,6 +430,9 @@ struct psp_context {
>>  	char				*vbflash_tmp_buf;
>>  	size_t				vbflash_image_size;
>>  	bool				vbflash_done;
>> +#if defined(CONFIG_DEBUG_FS)
>> +	struct spirom_bo *spirom_dump_trip;
>> +#endif
>>  };
>>  
>>  struct amdgpu_psp_funcs {
>> @@ -467,6 +491,10 @@ struct amdgpu_psp_funcs {
>>  	((psp)->funcs->update_spirom ? \
>>  	(psp)->funcs->update_spirom((psp), fw_pri_mc_addr) : -EINVAL)
>>  
>> +#define psp_dump_spirom(psp, fw_pri_mc_addr) \
>> +	((psp)->funcs->dump_spirom ? \
>> +	(psp)->funcs->dump_spirom((psp), fw_pri_mc_addr) : -EINVAL)
>> +
>>  #define psp_vbflash_status(psp) \
>>  	((psp)->funcs->vbflash_stat ? \
>>  	(psp)->funcs->vbflash_stat((psp)) : -EINVAL)
>> @@ -578,6 +606,7 @@ int psp_config_sq_perfmon(struct psp_context *psp, uint32_t xcc_id,
>>  bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev);
>>  int amdgpu_psp_reg_program_no_ring(struct psp_context *psp, uint32_t val,
>>  				   enum psp_reg_prog_id id);
>> +void amdgpu_psp_debugfs_init(struct amdgpu_device *adev);
>>  
>>  
>>  #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
>> index 17f1ccd8bd53..ec9462336bcf 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
>> @@ -71,15 +71,6 @@ MODULE_FIRMWARE("amdgpu/psp_14_0_4_ta.bin");
>>  /* Retry times for vmbx ready wait */
>>  #define PSP_VMBX_POLLING_LIMIT 3000
>>  
>> -/* VBIOS gfl defines */
>> -#define MBOX_READY_MASK 0x80000000
>> -#define MBOX_STATUS_MASK 0x0000FFFF
>> -#define MBOX_COMMAND_MASK 0x00FF0000
>> -#define MBOX_READY_FLAG 0x80000000
>> -#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_LO 0x2
>> -#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_HI 0x3
>> -#define C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE 0x4
>> -
>>  /* memory training timeout define */
>>  #define MEM_TRAIN_SEND_MSG_TIMEOUT_US	3000000
>>  
>> @@ -710,7 +701,8 @@ static int psp_v13_0_exec_spi_cmd(struct psp_context *psp, int cmd)
>>  	/* Ring the doorbell */
>>  	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_73, 1);
>>  
>> -	if (cmd == C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE)
>> +	if (cmd == C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE ||
>> +	    cmd == C2PMSG_CMD_SPI_GET_FLASH_IMAGE)
>>  		ret = psp_wait_for_spirom_update(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_115),
>>  						 MBOX_READY_FLAG, MBOX_READY_MASK, PSP_SPIROM_UPDATE_TIMEOUT);
>>  	else
>> @@ -766,6 +758,37 @@ static int psp_v13_0_update_spirom(struct psp_context *psp,
>>  	return 0;
>>  }
>>  
>> +static int psp_v13_0_dump_spirom(struct psp_context *psp,
>> +				   uint64_t fw_pri_mc_addr)
>> +{
>> +	struct amdgpu_device *adev = psp->adev;
>> +	int ret;
>> +
>> +	/* Confirm PSP is ready to start */
>> +	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_115),
>> +			   MBOX_READY_FLAG, MBOX_READY_MASK, false);
>> +	if (ret) {
>> +		dev_err(adev->dev, "PSP Not ready to start processing, ret = %d", ret);
>> +		return ret;
>> +	}
>> +
>> +	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_116, lower_32_bits(fw_pri_mc_addr));
>> +
>> +	ret = psp_v13_0_exec_spi_cmd(psp, C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_LO);
>> +	if (ret)
>> +		return ret;
>> +
>> +	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_116, upper_32_bits(fw_pri_mc_addr));
>> +
>> +	ret = psp_v13_0_exec_spi_cmd(psp, C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = psp_v13_0_exec_spi_cmd(psp, C2PMSG_CMD_SPI_GET_FLASH_IMAGE);
>> +
>> +	return ret;
>> +}
>> +
>>  static int psp_v13_0_vbflash_status(struct psp_context *psp)
>>  {
>>  	struct amdgpu_device *adev = psp->adev;
>> @@ -898,6 +921,7 @@ static const struct psp_funcs psp_v13_0_funcs = {
>>  	.load_usbc_pd_fw = psp_v13_0_load_usbc_pd_fw,
>>  	.read_usbc_pd_fw = psp_v13_0_read_usbc_pd_fw,
>>  	.update_spirom = psp_v13_0_update_spirom,
>> +	.dump_spirom = psp_v13_0_dump_spirom,
>>  	.vbflash_stat = psp_v13_0_vbflash_status,
>>  	.fatal_error_recovery_quirk = psp_v13_0_fatal_error_recovery_quirk,
>>  	.get_ras_capability = psp_v13_0_get_ras_capability,
> 

