Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CE6C88E72
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 12:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B69A10EE4E;
	Thu, 17 Sep 2026 12:12:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DjOy69Nu";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E87810EE4E
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 12:12:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbKWrH3EblUpp+RQNNKY5wG29fzDec4TVgaNS82wBDay0M+F7ZYZJraih4y/3MB6TBYnrbOmtN9HhhF/GMbAXFmLOov9AECzo4nm7LHn69i4w0nBLKCRGoFe/OgfyXtaMxrBiZRIF5NpFoJcsrpKja17qeghFnRfV0KcYm5vaQJQN7gQjOmoQ2BCMCWx2Orcj3poR+4TBrqoIctXbTv5eguicksGk6XYsSbt0BjU4eOzJmwtr39/FFGDrqAtPVsHQLujHugrmb5BeKA5GdM35koiURF5gwWp+1sVa+KCKLpSYjVJVYara3Wx3BI96+M1ldgBGjj/EE13EttTNOx+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRkkf2DhhdOktaSRtT6UdZG0m5koTCmkYtRYCuGK5nI=;
 b=iCndaz3NM7Ml0N7CVTAHP4ojlFDSX823jH/WKy2t/sV5/JAwuIPoQLTu3as4rjK7RuwZMq7RANwVBbSZ+2eBFZ/SnHcR+l3dykdtbJrYE7ZDm9Z5+bFEg6eCQgGjxrbROhIo3ZEMX37tZVReIs0HUsPLzzOpATVoyWIUIIjf8GdtnYrxqfpT0NhpmB8n1RY9u8XDbshTLTmFTx2mLfsGWvLaZfX+knCFKAtrBaoTJZY1nSj4U6VfGdaIOmyCvjDajojs2fOz4RvvYxWPFVtPkXBD3y2SxArQaaFJbVT6uY81dnPSEpNDyGxQIzS/BBsH2VlTJXJqGER56bDmCNXgsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRkkf2DhhdOktaSRtT6UdZG0m5koTCmkYtRYCuGK5nI=;
 b=DjOy69NulFzhiRfiyJyFgksTrkrCdy8AkvDY/0Vy1yc30rfnxzkaQI335N5iQuepy5VPB9UG17u6ezV5Muw0uNeHeyBn5FmZIam3DE39rfH2AZi9gj4SU8RlOKvEjNMiLfizIZDav8pE8iomSsN4VzvqCfC1tFiIjjPv4ixZhJM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DS0PR12MB7770.namprd12.prod.outlook.com (2603:10b6:8:138::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Thu, 17 Sep
 2026 12:12:15 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%4]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 12:12:15 +0000
Message-ID: <2f3df784-35a3-4108-8d1d-cbded59ef727@amd.com>
Date: Thu, 17 Sep 2026 17:42:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Use iosys_map for trap TMA BO mappings
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260917090530.666757-1-srinivasan.shanmugam@amd.com>
 <d54c9aa9-6414-4984-8816-84db74de309f@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <d54c9aa9-6414-4984-8816-84db74de309f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0346.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21f::7) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|DS0PR12MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 077d2720-1c65-4096-d73d-08df14b4e91d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|4143699003|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: PAVCf50/p/M3wpnc6IiM+9i/PVfFMsYMBFVbHs03tqo8Gb+dLeTdfeNw8TAxdk291Jyasj44sgxone5HbE/ZS7F2IanlURnuET711jeMRJHgSz0qyK/XJ+QdUevvHEhqvppMj0ZKBF479vFlGadCGxPUYheGWP+ayaw8N/FNcCAfpMm2W/JzsTT94OSJvre6q9lpvY0xoI1LGdVn3Z2L8M+wPKCnSK1N6XNsxkoKzs/dR/XrJUz5KvBKHR/8kjt17oPbSHIGgW7GFoEg2fp7GCLdSQ4UoIU7kTbPqqo/8VhxgypD0UTmBcsRiUxyzKs5Oe8ilIR/H+qiaO0GU4sPb9sBbIf73pEocAKiQlGyKgMUAdn8AJQxk8lIMQ62hYQzNKbj/qbjQdm6IQNHzS56VsZelNPUoIwoFv3nKQI+Jq5Nrz+Vt4GLbUFNWskMW3CPRodNd8h5xHHBGFjgZFhDMrMqVL7Skvt0zK9wopjwH2xctszqO2/ZqSCL/syOuCyEtaRzG3VRFwZ4RsCRaVDV2Dqx0ybGgemAuprlUgACL4Dg3YRW504/TVqxXXRWBgJ/a73selhfJnS4mHNE8wJe83g0S8YBPJWNURQmBFPJN/1VO910n+ITri61PPQ1YJ09VZG/6p7ps8Tj+ph4fYEwMuWl37RAm4Zomi0w/IV+5rM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(4143699003)(18002099003)(11063799006)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlFRaHBrck1rYWF5YUdkSERWWWl4T0pNYisxRDYydFJiM24zZCtuMlllWmpO?=
 =?utf-8?B?V1RlUDB3bWVZcVJnQXR4Rm04S2dqdno2Y3BnMjNBakw2LytJZXlVL0Q2bHIr?=
 =?utf-8?B?UlA2aE5sMW9LOE1WRWYzaTFlZDJHNUk1ZUdTWU5DMzNPTGtuYTRRNk94eGdi?=
 =?utf-8?B?N1A1VjNCVFNYYkNnQjRFMWw5MWZXSi9LT3RZa1Z5clQ5am1QSTJyMVhIMFBW?=
 =?utf-8?B?dGozc0ZaQkNFUUNFVG90OUxYUEVKb3BKSFVpMHpySGFmK3dCUmt6b3FpTE9U?=
 =?utf-8?B?UDREeWg4ekt0V0RQNlFCaG1aNFZldUVMYkVPS3ZLWlpDRGdOZjBXMVBlVm8v?=
 =?utf-8?B?NTRoS21ybkN4VDh6MDJmTTlnZjc4dGg5NjVpaGNYc0JiYkZSUThCVngzeUox?=
 =?utf-8?B?NU85Q1l4OTRsWDFER2FCZ0FVcXE1aGx6bzVKOUphQVZKeUw1ZXJxbzQ3Y0sw?=
 =?utf-8?B?Yk92OVR0cU9sZ29OY0kzSW9Yek8zek5Ma1VJbTJZdG1RM3dVN3EzenhHUHFI?=
 =?utf-8?B?bzFQZS9YT2VEMHZ0RjFLTXFXNko1ak9TQWtKUG8vU0w3bk1wWTFtTXJWZUUz?=
 =?utf-8?B?ZVY3S1Y0QWc1dWlCcWJ0NXc3Y2ZUajhndVYrcWt0Z2xKdHVsa0o1cTFCQkNp?=
 =?utf-8?B?aUhTWmlIMlJKbmo2cUZRRE5IZFdMZTByT0o3K2pDcDcxVXNCRVFpZjZMMFdo?=
 =?utf-8?B?SGxxOCtyNnBSeFVyb3NuT1pEaTQ1d250NUVBVi9vK0h4TkNlY0V4VnNUTlFq?=
 =?utf-8?B?S2tRd0dhbXlIVTVEclF6WGJkTWdHS0RqRHNScjl6UXpRVkFQR1o5YW42ajVl?=
 =?utf-8?B?dlBJY3k4Q2dGeW05eVliOGVSdUxtNnExdW5rVWZvSG9TS1U1WTRLQ1Z4endO?=
 =?utf-8?B?UXc4eXNOeUdYbEgwa01lN1l6YzVHbzJwaW01b050c1JCVUxUUzZEY3g2cXY0?=
 =?utf-8?B?VDRGdkpqVENZM1FJL2h4MHkvWWRMOEx6dFpCeG1HTlZDYzlldXh6Rk5wZmNS?=
 =?utf-8?B?MmEwM3o0M0szdUtFQ3FaUGE3NkpENHZSNFIvbFlsYjJVWmtGa2h5dkV0VEJB?=
 =?utf-8?B?NC9kYzQ3Nm1peXZrdERiRWZHV1owTUpFQWxQcHlOVHF0b3dWK1pISkVNZWNj?=
 =?utf-8?B?N3JaV2xHZndoMDRHbEhvalduSWwxY1lhS2FQYk5jTXcxb0FZUi9lRC92K0xW?=
 =?utf-8?B?UkdsSWlrbm9wNkdIaTdVSDFLWkFiN05JdDRodm9uVWExRUNzVTh5bHdDTFVk?=
 =?utf-8?B?Szc4czljYlY1OFlIU3pFNDNWbVhsZVZWeGk5d1djZ0Y2ZGI4MlNwbzZjK09X?=
 =?utf-8?B?cExlN3RxdzNqK3Q4VjJ0Mm1zaGtRdDFudUVCbWdybStrcDdqcjZzaVlXaTFv?=
 =?utf-8?B?WW1tdFdiUlBuaXRJd0x6Z0ppWkZPUy9qdEduMkl0ai83WWxzMGxpZ09uYWZN?=
 =?utf-8?B?cy9XbGxxc0ZtM1JMeUZDeW16d0hPUE5jdnI4cEdBalZHTWRQYkRseVVNOEIr?=
 =?utf-8?B?eklQekJLUUxIcWErbU9mQTlKYjg5TXEzai9zalJMbm8wbGt0SWNBRUpWR2lT?=
 =?utf-8?B?Ylg5UnRHelVNbjFXYTFhRGk1MW5wWEZHc1RVV2NuMEV3bTJ6eWJ4dWFaSk5U?=
 =?utf-8?B?eDVQUmkvYmw4ZGtaVTJ6WTgzWEtiSE0xYVRrLzRzUHUrckU1ckNhanJYbXJE?=
 =?utf-8?B?bzE5SldIbXkyZmhLeEVDRGR2VmdoUmxwNHVPUk9zU0d2NTMvTkVWUEdXdFJk?=
 =?utf-8?B?Rnc5MlpkcVVoWG9TYkQ2Z0dJNjBzY0tMT2g1WHlOY2locHFJd0FqWHlYQUZk?=
 =?utf-8?B?RlUyQ0UxeEdqL05JYjQ4RUh6U2JDUlBSR0QwQldoL0l1TzN2NTJDZGxGRGE3?=
 =?utf-8?B?UjlyTnhVQ0R2WFNzTDhZTTNOSjFEUkhSWWlvYS8raEdidGpxSDFwWEt5bDZy?=
 =?utf-8?B?SG04VGVsNFAwV3BtdDExQW1EUEwzOWEzN1haU1lpRis1MDdyNUlSNmMyazF2?=
 =?utf-8?B?cHoyLzlHSU9TWXErS3h6MjVRa1M4YTZuc3FkeFc0SW9sd09QWEpycnErby9I?=
 =?utf-8?B?VlJyS0VIL3dyTno4RWh6TVdHWDhkbnB6ZS8yUEJ1eHZGdVdvM2ZNTHdBc1pB?=
 =?utf-8?B?Tk5RZVBSSVIwUWUxT25iYVhBeDZ5M3cxczZERURvTVpZaHVYM04wU3JkcjRT?=
 =?utf-8?B?VjJHV3gzakExZmVXZ1Qxb1VPU0o1VWJkWEJ6aHNKZy9jeEF6U2lseGttcU0r?=
 =?utf-8?B?U1JmdHIrN3VOaERhSEZ2YW9KaDMxWDJjUjBnRTVSMnlPV3JDeEdIUExXNWhK?=
 =?utf-8?Q?hRWQ9GxbI9xxFYC4YM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 077d2720-1c65-4096-d73d-08df14b4e91d
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 12:12:15.1552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1GYhxy/l0RyI24OVqL/I9/sXG3hCKBElDJbwyoI66c2RO90Eye1ZL1m9tEEJ3Oz5GW/nkEzgSZ2MSRv4Xgi6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7770
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


On 9/17/2026 5:13 PM, Christian König wrote:
> On 9/17/26 11:05, Srinivasan Shanmugam wrote:
>> Replace amdgpu_bo_kmap()/amdgpu_bo_kunmap() in the trap handler code
>> with ttm_bo_vmap()/ttm_bo_vunmap().
>>
>> Store the mapping as struct iosys_map and use iosys_map helpers for
>> memory access. This aligns the trap code with the modern DRM/TTM mapping
>> interfaces.
>>
>> Using iosys_map allows the code to use common DRM mapping helpers
>> instead of directly accessing memory through raw CPU pointers.
> I'm really wondering if we shouldn't rework amdgpu_bo_kmap() into amdgpu_bo_vmap() and use that everywhere?

Hi Christian,

Thanks, that's a very good point.

Introducing amdgpu_bo_vmap()/amdgpu_bo_vunmap() and gradually
converting existing amdgpu_bo_kmap() users sounds like a useful
cleanup for AMDGPU in general.

I did a quick grep and found amdgpu_bo_kmap() users in a number
of AMDGPU/KFD files, so this seems broader than the trap-specific
conversion.

Would it make sense to keep this trap change focused on the
original conversion and handle the wider AMDGPU migration as a
separate follow-up cleanup activity?

I'd be happy to look into that separately as well.

Regards,
Srini

>
> We can of course start with backward compatible return the kernel poiunter and then switch other users of amdgpu_bo_kmap() over to iosys_map one by one.
>
> Regards,
> Christian.
