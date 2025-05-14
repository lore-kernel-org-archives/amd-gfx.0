Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C45EC3ABDA
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 07:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B104B10E3B3;
	Wed, 14 May 2025 07:52:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h4qFOZX2";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA69C10E28C
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 07:52:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHAYiu2giXU/m7cVEA59s7q9ZMTDOyTrh8sW7408rBes5l9tMZBfQcKNvt9fOiLFsrqPSroCxjkAdsttFlUdJ1Le6wvdk3FnbpeVDF2IVUZ27CEfy5OA8BTkpUVjf4ngpE2qQrYvUXE9aVMGDNtK2o52PcASD+/IgVZDjJQFdSEgpUprT4YeVQBeGGnoTM13BlJVRjUVO/BhbXQBtdCFFUtMJj5SI7G/qWu1rqfXugjQ6rT0lUhgLQWCHu4TgGy2w7XCfK69Yir29Ephp5gJqPFHxgi4RfOCJ3WeJlpQotz6o3RTBnFxWhFgShkxYUKn/MHq2fqmsgUfJQ/dkAxOPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUfQaNQkInp/ZaU1HUpz0CgaGS0Zsvx0F41ImXim7iM=;
 b=v3ziVPgwVJ7qsFtGKkZsiiy+m6ggxbYmAt6NPtbWTguX92qT0Fkq9haeDZPxjnm1j1gEaKMOTVm1Z6CSai2wDqDKrPANMGm2JmkegVks57L4vpgDzT8j3Ek/2oDnrv/We6+PfE+DPMzcoIWKBy+/6+RGsngxMKY/RdYBP5Zs8/6FpCIKQ6QHtfIHkmuViLzvfP+qb8PruvFV9TZmMfsj/wKcxiEeG0SCCsYwE9mvG+bOJ+HjN+GaVf0HrTDoXX1V4ID5b1PIXcgg5v5oMzps69HfUUQ4RnLNaSSpj2e7wFczsE87Bcongh9P4urpi4AZys0YInx3mLyjmE+RkTGz6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUfQaNQkInp/ZaU1HUpz0CgaGS0Zsvx0F41ImXim7iM=;
 b=h4qFOZX2cJbSolNWBZiyDeEih9GHuDEqpxrVE/BlpGyoImiJZOyA4NyW7yBIhtoGwXFtFuCbKgIwb1U4mN5PMjEaFGLQdTfD+objkshfVPVWXvo/2D19f567aWMcFCbNMvc6m890Ovqvnrkm/Bvb6YFXJMyRWYYkX15Pg2zvHgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW4PR12MB7358.namprd12.prod.outlook.com (2603:10b6:303:22b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 07:51:57 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 07:51:57 +0000
Message-ID: <fd968681-3f86-4038-8799-aa4a37ed7455@amd.com>
Date: Wed, 14 May 2025 13:21:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: add debugfs for spirom IFWI dump
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: Shiwu Zhang <shiwu.zhang@amd.com>, Hawking.Zhang@amd.com,
 Likun.Gao@amd.com, amd-gfx@lists.freedesktop.org
References: <20250514062145.82529-1-shiwu.zhang@amd.com>
 <e0bc2b98-99b2-4f66-ab74-ca085f4b3847@amd.com>
 <1d0b618e-d45e-40e1-8b3d-0edd893936ea@amd.com>
Content-Language: en-US
In-Reply-To: <1d0b618e-d45e-40e1-8b3d-0edd893936ea@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::20) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MW4PR12MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: a200d8b7-6800-4efc-e2d8-08dd92bc331b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHNCTTBEVDZkdXdUU1VuM0xZWG9OczZTQXFmTVR5SFpXVGtRRjUwYnpuWHM3?=
 =?utf-8?B?VHBWQldGbXRseFZPeWtPR1FZNC93NnJoSFArSXg5U3FvMFdBbmFFYnVTK2hM?=
 =?utf-8?B?NURLSFhQTWFaZThzajV0b2FEYU5jRDErNksxSDJTcEZhS01xcEJDTHFQU01p?=
 =?utf-8?B?RzVVWGlaejBTaGN6MktpWXZBMEhzNmFWVG0razZpMHZIS3F3SFRaWXdENnlt?=
 =?utf-8?B?cURCTXpPMlVXVDBZbVplL1V4WXEyalVRUnpVRTlRdmNYamZOWmlISDFIdDBM?=
 =?utf-8?B?REFwK3NvKzBiRW9NY2Y4SnYvbllzR2JCNGd0TUJHYnJjYkcyazFuemlaUk9Q?=
 =?utf-8?B?RnFwVVZZVmk1Sjk3ZkovYlNpTHRoMzh4dXd1aGhkMjcyblNENnFQZVN0VUFm?=
 =?utf-8?B?WEpiRWpUa29vRDVvd0lOV2lTSXRrL0dkNHNmMmhjQWp0T0picm9US1JEUzZT?=
 =?utf-8?B?UVVDT1ZTWHN1NUZTZkNQWTMyV2UzNUhxNTVTYWxRL2s1QllpRzFxcmw4cEVB?=
 =?utf-8?B?ajl1d1MyVzNOSGVtLzRhclA1U1JpMmova3FaWE1BaW9QOHJhR01CUkVKd3dT?=
 =?utf-8?B?YU5idUJLcFVmaklWNkxBLzdNaWVYK1JHSkVSOWRaRFVJYmsvQ1I3Vy8xbXRV?=
 =?utf-8?B?MEl3K2xEc3B4QWhNT1FCM2xjWkptUS94M1RIbnRhTTJML3ZvMDIyZWtmVkRV?=
 =?utf-8?B?KzNTUjJUZm11Rm4yRHVJZS9xTXRBLzMwV2NvK2JtNkVVS296b1l2dEtyMm54?=
 =?utf-8?B?ZWIwTjRuWjh3NGdMbmFtcXAxWHQ4MGUvSDVnV3BtMFAwYXZPRHM0NVBHVFpq?=
 =?utf-8?B?QUl5V1oxV0xYSkZlL2QyZVBVeTV4OVpMNUYxd2JkOUppUFVpWmN2ZXJaZnZs?=
 =?utf-8?B?Z1V5Mys4VmRJVldpSytuZ2tHaEh6YUdpNHFCNWg2QXZNMVVEQ0dMaXB4OWd4?=
 =?utf-8?B?TVFZOE5IZ1pNTmZxKzVOOFhjNVVKRHJBMVhGM1IrTzlDcWNteEZWN3EycnlY?=
 =?utf-8?B?djdTa1UvdGVtL1kydzRNRUI1b0FManVqS1g5amRTdUVwQVdTeG9rQVM3N1pU?=
 =?utf-8?B?STJsR1oxTXFkN3BaMVM2SzJyN3N5TGdHdnB0MXFxcklPTXlJS285d3JkWEsw?=
 =?utf-8?B?Ymd5bnFLTHVhdUsvUjhBQlBoUjNzZ1l5aEZWNWV5aVN5citvRmFrajVNcTBp?=
 =?utf-8?B?YTlRMUxyd3N6S2V5MWt1WlErQi9zaW5QMTJ4TVhNT0hxUHpSZ2ZGdDhuNVJC?=
 =?utf-8?B?WHNhOEdHV05RbFJ2bXhMdVlYQXF5VGhDaitCSkl4anY0akp5Ym1wTDNNakRE?=
 =?utf-8?B?dlIzVGMyUUR6YXkwZ1A2U2lzWUsxM3M5UHpzcEoyTUdLMWdPSUFwZWVVZU5F?=
 =?utf-8?B?Y2lMOWZnZVlXOHVxbUZBcEkvOG1zNG85Y080cDJVK1FKckdKWS9oS3Y5ZVgx?=
 =?utf-8?B?UmdwZlBxcEF1d0dUYjdOMzNGcDgyOWlYREw0bm5LU2gwUFN5aXZlcm02RndN?=
 =?utf-8?B?WTdwVEVrMWNIVWJhVy96SGI0SlVqZittQURONDhZbzZCbUNDUytNMUpaWFh6?=
 =?utf-8?B?RUZPcDJmZlJ6VXJPN2VIczFWRTUvNVd3cXViWnlnSjZKeHhWQ3dIWGErTjhS?=
 =?utf-8?B?bGtBbjBtYmF0b29UUno5SmM4VGZmaTVQNkxTWTNQVUMwTVNDSVdmWTZGZjdP?=
 =?utf-8?B?ZW85clNFenRvRGhHdVJvV1ptYzRtN3NiTmIxT1ZnL2NtRlg0OENkbDNVZ3Zk?=
 =?utf-8?B?TUhEczRwdjA2VzFhRk1aQ1ZtOVIxa1laMXlnQy91MnRBeDhOM2dDengzWEhk?=
 =?utf-8?B?enRsYzhtdFNRVExJbkFpSzFnb3MvanM2aFNxT2dLUlJBbjlqYlovcWtoOFlw?=
 =?utf-8?B?eDl6blJCQlh6SXdhV2tNRE5EWUZTRTMrNzV4TEVhcndFZXZiOGt2THg5cEpj?=
 =?utf-8?Q?YFRuEZKbYqs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3ArZncrOVUyYUZKNzVEdDU5SXU0SXJXc09DVUc2ekxzM1M0VmdHdXhVK3NV?=
 =?utf-8?B?V3RvR2pxaFFhcXU4dEh3SisydGhLVmtUUDRNNEk4emdOV2Ziak95TkZYbHRT?=
 =?utf-8?B?cDh2TUJBNFYzRWdvdmJFN3VKeWF2c2F0emRCMnd6YW11M2VQdm1SbVFTdTFL?=
 =?utf-8?B?WGZTVlJ1VnU4V3V6QUhLVnl5N3dPMUdxRmFDV3VEWC9EZXhPTnErREhoUG8z?=
 =?utf-8?B?MWx2ZzFOR0E0S1NNM2tuZUZnK2dwS2JyRVY5a3pjT0NwZDBKVmFSMmx2SFJP?=
 =?utf-8?B?cGZNQXphNGxCeWcwb1NUWHlOZENrVGtNTVBNTjEzMmFrNkFRWHZ4cUErZEgz?=
 =?utf-8?B?NXJnK1BXMDhBMXQ1cFA4Y3ZTb1RlVThkQ1ZEbDkweGE5RC9EZjhBZFFwTFVF?=
 =?utf-8?B?aGRReUlXZDIyZTM5YlVKWWZXak03WUpyQXVYWnlId2hZWUdtdjNaS3JNYlox?=
 =?utf-8?B?T0VjS3VkMGkyK0l1aUxvYW9OaFFBRXJlY00zNjZ0MVdMK0hZdERpUXVId2Jm?=
 =?utf-8?B?QnhSZ3BuUzhiUzljL0hTcVl1WVJrektwQWVaMzJjOGZ3VmtWU3FEL0VwV25s?=
 =?utf-8?B?TVJaSUZKWml4M0NBZ3N2RlNoVlRnbEZXWFAvSzV3NWNjQlZ1YjNCYlZsYU4r?=
 =?utf-8?B?b1Y4UkNldUw4TGRhRXlub1BsaDFYeXdFM240RG9XNDl2NzJnaW4zNDBzUzdV?=
 =?utf-8?B?VEQ0Z1BKa2M1Wlg2QlVLaU9CbWZORFMwRElXV0ZVU1ozaU1yc0hWUXJ6L1Rm?=
 =?utf-8?B?RFJBak8zcmo0TVBXaTh4MjRieUdrV2ZSTHhZV3ZHS0taQXhvL1dXRW84NHg1?=
 =?utf-8?B?cW5XczV2RlVja1ZKd1NLVHVtc2RBc2Izamhoc0VTRVlFSmk2WTJWWk1BOC9X?=
 =?utf-8?B?QVJucjV2NFFkdzRPR2xVYXpkMmQ2aE14Ry9qS3hkSTlxb3JaMCtmNGZ1Z3Ax?=
 =?utf-8?B?UllBQ0dyRnJqSGh6bmdxd2x0aUdQOEttbi9CZEs1UTZOOHRRM0RrRnpZY2U5?=
 =?utf-8?B?R251bFdqYWpncjhSVG8rYjRucmFxcG14ajNLaFNXRXlxMWhUcFdDbVhLSy9Y?=
 =?utf-8?B?ZDdiY0tpTzBWa1Y2dUdSVWZpNEdnTlhPaW1yU3JXOGZkYlQzYWtXMkU2SUQ0?=
 =?utf-8?B?cHJJUGdzTW84VDNaSmhlTlF3U1JIdFU0VHFjd3JGYUxDQWNnUHNrN1paa1J0?=
 =?utf-8?B?NmhsN0krbWtrb2V2S1N5NHpMUXdJbUlYSnJZOTJwVUZzQ2lhSjM5Ym1iZXZS?=
 =?utf-8?B?elFqVmFqa0ZKMXo5QzVyclRLVHdGNlFIM3ppMm91RnVSZE90L3JxckdXeGR1?=
 =?utf-8?B?d0d3L2FNWEF4RFNrR0tCU1ZnNDVuSVVIbGhKV1JyK1pGSFNKemJHSDEwV0RP?=
 =?utf-8?B?NGxLQU4wdlVZbHV2OXUreStJS3dsSy9jYUFHUW0yTmxmWUtUSFZpK1p3V256?=
 =?utf-8?B?L1cybWYrZUFhSUFRVXkvM3VUaWV1cmErWTZyOS9CK1dnVU1QSkk5NFJ6N3Vy?=
 =?utf-8?B?VSs1WGprUnRZUUpUYlRSZStYUlk5Rk1vdHBSenczQmFtaDdPQUFETTFYajcv?=
 =?utf-8?B?SzliL1RYYVB3eFllcjhFYUU5YWFLZHFoU25pTjROREdBbkZDUmRuV2cyak5n?=
 =?utf-8?B?VVdXVmJOVHZxNW10SVI5SDkwcHRObVB5dU9rTElNbkh4OTltRWFzVVp5WGUy?=
 =?utf-8?B?ZVFkb2JmWTQwYjU1MVg5NS83RXlHSTRieWtGTVArMVpodW9KcEpPZGQrdlNB?=
 =?utf-8?B?VjBKYnJEZDErQllaaFd1NXZDUlRqZUkrdVNMOTJJNFBXRSthdW9xMXg5R2M2?=
 =?utf-8?B?M1JueWJzZHlONC8vdHZodEJhMWRhd3NrYmpScWNhd1BoWktoRWJvYWY5OFc1?=
 =?utf-8?B?UUVoaDdZZGFDQktJNGFSQzU0NWlhaEpqRk9mM0I3QjR0RGdSVHozbTBRUktZ?=
 =?utf-8?B?YzI1aHQ3SHZQTUNrdys0bnJONzlvQlFtSXNXV0V4ZncvR0xya1Z5SzdXTVox?=
 =?utf-8?B?dXBLbzB2Kzd1aHNnbTlCc3JYd0xxNDU3dFFuS2xCSDd6UVNNbXBzUHlRcWxx?=
 =?utf-8?B?VkxPcFNVNDQzVTUzZDRYUmFZTlR3MVFaS21kSGNtamwwQ1BuY3I0ZlZIbHQz?=
 =?utf-8?Q?Jet/eQEUJZrgasyDn6yOPw3wv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a200d8b7-6800-4efc-e2d8-08dd92bc331b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 07:51:57.5391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3pki30R41GbLopa1eSlAu5E0tSmBKvcgeBKW74tL+hMW1fIz7wCMA2Xn1lVmE1eQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7358
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



On 5/14/2025 12:55 PM, Lazar, Lijo wrote:
> 
> 
> On 5/14/2025 12:53 PM, Lazar, Lijo wrote:
>>
>>
>> On 5/14/2025 11:51 AM, Shiwu Zhang wrote:
>>> Expose the debugfs file node for user space to dump the IFWI image
>>> on spirom.
>>>
>>> For one transaction between PSP and host, it will read out the
>>> images on both active and inactive partitions so a buffer with two
>>> times the size of maximum IFWI image (currently 16MByte) is needed.
>>>
>>> v2: move the vbios gfl macros to the common header and rename the
>>>     bo triplet struct to spirom_bo for this specfic usage (Hawking)
>>>
>>> v3: return directly the result of last command execution (Lijo)
>>>
>>> Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   1 +
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c     | 104 ++++++++++++++++++++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h     |  29 ++++++
>>>  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c      |  44 +++++++--
>>>  4 files changed, 168 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index 4835123c99f3..bfa3b1519d4c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -2113,6 +2113,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>  	amdgpu_rap_debugfs_init(adev);
>>>  	amdgpu_securedisplay_debugfs_init(adev);
>>>  	amdgpu_fw_attestation_debugfs_init(adev);
>>> +	amdgpu_psp_debugfs_init(adev);
>>>  
>>>  	debugfs_create_file("amdgpu_evict_vram", 0400, root, adev,
>>>  			    &amdgpu_evict_vram_fops);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>> index 6f9bcffda875..3a27ce75f80c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>> @@ -4185,6 +4185,110 @@ const struct attribute_group amdgpu_flash_attr_group = {
>>>  	.is_visible = amdgpu_flash_attr_is_visible,
>>>  };
>>>  
>>> +#if defined(CONFIG_DEBUG_FS)
>>> +static int psp_read_spirom_debugfs_open(struct inode *inode, struct file *filp)
>>> +{
>>> +	struct amdgpu_device *adev = filp->f_inode->i_private;
>>> +	struct spirom_bo *bo_triplet;
>>> +	int ret;
>>> +
>>> +	/* serialize the open() file calling */
>>> +	if (!mutex_trylock(&adev->psp.mutex))
>>> +		return -EBUSY;
>>> +
>>> +	/*
>>> +	 * make sure only one userpace process is alive for dumping so that
>>> +	 * only one memory buffer of AMD_VBIOS_FILE_MAX_SIZE * 2 is consumed.
>>> +	 * let's say the case where one process try opening the file while
>>> +	 * another one has proceeded to read or release. In this way, eliminate
>>> +	 * the use of mutex for read() or release() callback as well.
>>> +	 */
>>> +	if (adev->psp.spirom_dump_trip) {
>>> +		mutex_unlock(&adev->psp.mutex);
>>> +		return -EBUSY;
>>> +	}
>>> +
>>
>> Didn't notice this before. Once rom buffer is allocated/read, you could
>> allow multiple reads at the same time. FS backend will handle that.
>> Release is called only when all references to the file is closed.
>>
>> For ex: in open, you could do like
>>
>> 	if (file_count(filp) > 1)
> Correction -
> 	if (file_count(filp))
> 

After further check, it won't work for this usecase. The patch as it is
good enough.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Thanks,
> Lijo
> 
>> 		return 0;
>>
>> If the file is successfully opened by someone else we have a valid rom
>> buffer available. Rest of the ops like read/seek etc. are handled
>> properly by FS. Once all users do close(fd), release() is called and
>> that time we are also releasing the rom buffer.
>>
>> Thanks,
>> Lijo
>>
>>> +	bo_triplet = kzalloc(sizeof(struct spirom_bo), GFP_KERNEL);
>>> +	if (!bo_triplet) {
>>> +		mutex_unlock(&adev->psp.mutex);
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>> +	ret = amdgpu_bo_create_kernel(adev, AMD_VBIOS_FILE_MAX_SIZE_B * 2,
>>> +					AMDGPU_GPU_PAGE_SIZE,
>>> +					AMDGPU_GEM_DOMAIN_GTT,
>>> +					&bo_triplet->bo,
>>> +					&bo_triplet->mc_addr,
>>> +					&bo_triplet->cpu_addr);
>>> +	if (ret)
>>> +		goto rel_trip;
>>> +
>>> +	ret = psp_dump_spirom(&adev->psp, bo_triplet->mc_addr);
>>> +	if (ret)
>>> +		goto rel_bo;
>>> +
>>> +	adev->psp.spirom_dump_trip = bo_triplet;
>>> +	mutex_unlock(&adev->psp.mutex);
>>> +	return 0;
>>> +rel_bo:
>>> +	amdgpu_bo_free_kernel(&bo_triplet->bo, &bo_triplet->mc_addr,
>>> +			      &bo_triplet->cpu_addr);
>>> +rel_trip:
>>> +	kfree(bo_triplet);
>>> +	mutex_unlock(&adev->psp.mutex);
>>> +	dev_err(adev->dev, "Trying IFWI dump fails, err = %d\n", ret);
>>> +	return ret;
>>> +}
>>> +
>>> +static ssize_t psp_read_spirom_debugfs_read(struct file *filp, char __user *buf, size_t size,
>>> +				loff_t *pos)
>>> +{
>>> +	struct amdgpu_device *adev = filp->f_inode->i_private;
>>> +	struct spirom_bo *bo_triplet = adev->psp.spirom_dump_trip;
>>> +
>>> +	if (!bo_triplet)
>>> +		return -EINVAL;
>>> +
>>> +	return simple_read_from_buffer(buf,
>>> +				       size,
>>> +				       pos, bo_triplet->cpu_addr,
>>> +				       AMD_VBIOS_FILE_MAX_SIZE_B * 2);
>>> +}
>>> +
>>> +static int psp_read_spirom_debugfs_release(struct inode *inode, struct file *filp)
>>> +{
>>> +	struct amdgpu_device *adev = filp->f_inode->i_private;
>>> +	struct spirom_bo *bo_triplet = adev->psp.spirom_dump_trip;
>>> +
>>> +	if (bo_triplet) {
>>> +		amdgpu_bo_free_kernel(&bo_triplet->bo, &bo_triplet->mc_addr,
>>> +				      &bo_triplet->cpu_addr);
>>> +		kfree(bo_triplet);
>>> +	}
>>> +
>>> +	adev->psp.spirom_dump_trip = NULL;
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct file_operations psp_dump_spirom_debugfs_ops = {
>>> +	.owner = THIS_MODULE,
>>> +	.open = psp_read_spirom_debugfs_open,
>>> +	.read = psp_read_spirom_debugfs_read,
>>> +	.release = psp_read_spirom_debugfs_release,
>>> +	.llseek = default_llseek,
>>> +};
>>> +#endif
>>> +
>>> +void amdgpu_psp_debugfs_init(struct amdgpu_device *adev)
>>> +{
>>> +#if defined(CONFIG_DEBUG_FS)
>>> +	struct drm_minor *minor = adev_to_drm(adev)->primary;
>>> +
>>> +	debugfs_create_file_size("psp_spirom_dump", 0444, minor->debugfs_root,
>>> +				adev, &psp_dump_spirom_debugfs_ops, AMD_VBIOS_FILE_MAX_SIZE_B * 2);
>>> +#endif
>>> +}
>>> +
>>>  const struct amd_ip_funcs psp_ip_funcs = {
>>>  	.name = "psp",
>>>  	.early_init = psp_early_init,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
>>> index 3876ac57ce62..089b6ae48329 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
>>> @@ -39,6 +39,18 @@
>>>  #define PSP_TMR_ALIGNMENT	0x100000
>>>  #define PSP_FW_NAME_LEN		0x24
>>>  
>>> +/* VBIOS gfl defines */
>>> +#define MBOX_READY_MASK 0x80000000
>>> +#define MBOX_STATUS_MASK 0x0000FFFF
>>> +#define MBOX_COMMAND_MASK 0x00FF0000
>>> +#define MBOX_READY_FLAG 0x80000000
>>> +#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_LO 0x2
>>> +#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_HI 0x3
>>> +#define C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE 0x4
>>> +#define C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_LO 0xf
>>> +#define C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI 0x10
>>> +#define C2PMSG_CMD_SPI_GET_FLASH_IMAGE 0x11
>>> +
>>>  extern const struct attribute_group amdgpu_flash_attr_group;
>>>  
>>>  enum psp_shared_mem_size {
>>> @@ -138,6 +150,7 @@ struct psp_funcs {
>>>  	int (*load_usbc_pd_fw)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
>>>  	int (*read_usbc_pd_fw)(struct psp_context *psp, uint32_t *fw_ver);
>>>  	int (*update_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
>>> +	int (*dump_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
>>>  	int (*vbflash_stat)(struct psp_context *psp);
>>>  	int (*fatal_error_recovery_quirk)(struct psp_context *psp);
>>>  	bool (*get_ras_capability)(struct psp_context *psp);
>>> @@ -322,6 +335,14 @@ struct psp_runtime_scpm_entry {
>>>  	enum psp_runtime_scpm_authentication scpm_status;
>>>  };
>>>  
>>> +#if defined(CONFIG_DEBUG_FS)
>>> +struct spirom_bo {
>>> +	struct amdgpu_bo *bo;
>>> +	uint64_t mc_addr;
>>> +	void *cpu_addr;
>>> +};
>>> +#endif
>>> +
>>>  struct psp_context {
>>>  	struct amdgpu_device		*adev;
>>>  	struct psp_ring			km_ring;
>>> @@ -409,6 +430,9 @@ struct psp_context {
>>>  	char				*vbflash_tmp_buf;
>>>  	size_t				vbflash_image_size;
>>>  	bool				vbflash_done;
>>> +#if defined(CONFIG_DEBUG_FS)
>>> +	struct spirom_bo *spirom_dump_trip;
>>> +#endif
>>>  };
>>>  
>>>  struct amdgpu_psp_funcs {
>>> @@ -467,6 +491,10 @@ struct amdgpu_psp_funcs {
>>>  	((psp)->funcs->update_spirom ? \
>>>  	(psp)->funcs->update_spirom((psp), fw_pri_mc_addr) : -EINVAL)
>>>  
>>> +#define psp_dump_spirom(psp, fw_pri_mc_addr) \
>>> +	((psp)->funcs->dump_spirom ? \
>>> +	(psp)->funcs->dump_spirom((psp), fw_pri_mc_addr) : -EINVAL)
>>> +
>>>  #define psp_vbflash_status(psp) \
>>>  	((psp)->funcs->vbflash_stat ? \
>>>  	(psp)->funcs->vbflash_stat((psp)) : -EINVAL)
>>> @@ -578,6 +606,7 @@ int psp_config_sq_perfmon(struct psp_context *psp, uint32_t xcc_id,
>>>  bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev);
>>>  int amdgpu_psp_reg_program_no_ring(struct psp_context *psp, uint32_t val,
>>>  				   enum psp_reg_prog_id id);
>>> +void amdgpu_psp_debugfs_init(struct amdgpu_device *adev);
>>>  
>>>  
>>>  #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
>>> index 17f1ccd8bd53..ec9462336bcf 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
>>> @@ -71,15 +71,6 @@ MODULE_FIRMWARE("amdgpu/psp_14_0_4_ta.bin");
>>>  /* Retry times for vmbx ready wait */
>>>  #define PSP_VMBX_POLLING_LIMIT 3000
>>>  
>>> -/* VBIOS gfl defines */
>>> -#define MBOX_READY_MASK 0x80000000
>>> -#define MBOX_STATUS_MASK 0x0000FFFF
>>> -#define MBOX_COMMAND_MASK 0x00FF0000
>>> -#define MBOX_READY_FLAG 0x80000000
>>> -#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_LO 0x2
>>> -#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_HI 0x3
>>> -#define C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE 0x4
>>> -
>>>  /* memory training timeout define */
>>>  #define MEM_TRAIN_SEND_MSG_TIMEOUT_US	3000000
>>>  
>>> @@ -710,7 +701,8 @@ static int psp_v13_0_exec_spi_cmd(struct psp_context *psp, int cmd)
>>>  	/* Ring the doorbell */
>>>  	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_73, 1);
>>>  
>>> -	if (cmd == C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE)
>>> +	if (cmd == C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE ||
>>> +	    cmd == C2PMSG_CMD_SPI_GET_FLASH_IMAGE)
>>>  		ret = psp_wait_for_spirom_update(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_115),
>>>  						 MBOX_READY_FLAG, MBOX_READY_MASK, PSP_SPIROM_UPDATE_TIMEOUT);
>>>  	else
>>> @@ -766,6 +758,37 @@ static int psp_v13_0_update_spirom(struct psp_context *psp,
>>>  	return 0;
>>>  }
>>>  
>>> +static int psp_v13_0_dump_spirom(struct psp_context *psp,
>>> +				   uint64_t fw_pri_mc_addr)
>>> +{
>>> +	struct amdgpu_device *adev = psp->adev;
>>> +	int ret;
>>> +
>>> +	/* Confirm PSP is ready to start */
>>> +	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_115),
>>> +			   MBOX_READY_FLAG, MBOX_READY_MASK, false);
>>> +	if (ret) {
>>> +		dev_err(adev->dev, "PSP Not ready to start processing, ret = %d", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_116, lower_32_bits(fw_pri_mc_addr));
>>> +
>>> +	ret = psp_v13_0_exec_spi_cmd(psp, C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_LO);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_116, upper_32_bits(fw_pri_mc_addr));
>>> +
>>> +	ret = psp_v13_0_exec_spi_cmd(psp, C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = psp_v13_0_exec_spi_cmd(psp, C2PMSG_CMD_SPI_GET_FLASH_IMAGE);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>  static int psp_v13_0_vbflash_status(struct psp_context *psp)
>>>  {
>>>  	struct amdgpu_device *adev = psp->adev;
>>> @@ -898,6 +921,7 @@ static const struct psp_funcs psp_v13_0_funcs = {
>>>  	.load_usbc_pd_fw = psp_v13_0_load_usbc_pd_fw,
>>>  	.read_usbc_pd_fw = psp_v13_0_read_usbc_pd_fw,
>>>  	.update_spirom = psp_v13_0_update_spirom,
>>> +	.dump_spirom = psp_v13_0_dump_spirom,
>>>  	.vbflash_stat = psp_v13_0_vbflash_status,
>>>  	.fatal_error_recovery_quirk = psp_v13_0_fatal_error_recovery_quirk,
>>>  	.get_ras_capability = psp_v13_0_get_ras_capability,
>>
> 

