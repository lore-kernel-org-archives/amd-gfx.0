Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B729BD12678
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 10:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D94010E554;
	Tue,  5 Nov 2024 10:35:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MYIgyQfQ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06F5110E554
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 10:35:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oeNZtas1aWILE6YgxEMqVJf5j5vf893LyivfbzCN+sX4v+CaKwpIvgrf5EXsbJ1Wnp0JJwqABGPR06gNsnqSCO6FV2uSKhYsDaSiBjaXzIVoe8Y0gi1s0UywKbXCtx+4brmjqKcw3MD5J+Ufl8DVlK4vV5gQ20yDRj7alJKMPHSDHANlOYVIaE7D/mRyfUMWz/oBvtNcYgpFn9JS7A5u0BKPLlolCoN+Bbqv/3fisXtoz0uBIM1h95ONG04KJ3QJ0FsqPXguIfdiRXmYXrpDY90PTOwoW4YeIhwlRu8IBanbB7HnYzP9IgqS3A8csQWm/scw7uuaKQgKKkJKDiR3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZrGvks2haV5sroG3b29HuCoM0PsKYLmrrz29T5Mg0E=;
 b=aMAoxTu0H2b4J2QLK8UIF+3ZbJs0vmG8tIfC+ntoeWmgXLPvTBpLEsKHAChcymaHFf73a9lsIuJ+HdLg8OWfHv6rOvGnh1VQy0Y0caQVCUNVNqfMdIONbI8DQ8/YEG/Bw1I6K9ELabbjatf4GedkjHaMcQfMtpONZw1BaFeD1Mjrym0l6Y/zaHLe/QBn0gwTjgR2sNpl3/aeBgPEFszR115o5XmIAXGyrCTQQjQtJxSpHUcY0n/bjW99Av8mXIR6cGU8gvVsv97FlgpJBPo+j0M8VZvLcwES3JjlgmqacJefn16sVQMeBCbRccq0YdvVBFnkzUnDDh6uskVSIDX5fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZrGvks2haV5sroG3b29HuCoM0PsKYLmrrz29T5Mg0E=;
 b=MYIgyQfQdXjG70btpX2z7YD5Zm4+PlJyHzFwNyG4nyBqOliSucYr68gGwAonYAme9bfNMjFp9ZtrMcxCYztUxB0u2xPG1imxw6jjYomMzYgeQQY3JjhrAl1rSdqB3dRZFeMWMsCOL01n3JQfaG9PNY09zmQcDtFXw7bPEWLa0Jw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH8PR12MB6865.namprd12.prod.outlook.com (2603:10b6:510:1c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 10:35:31 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 10:35:31 +0000
Message-ID: <d3771cb9-124c-409b-afc5-1e6db3714504@amd.com>
Date: Tue, 5 Nov 2024 16:05:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] amdkfd: always include uapi header in priv.h
To: Felix Kuehling <felix.kuehling@amd.com>,
 Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20241031104701.248234-1-lingshan.zhu@amd.com>
 <19443a63-e82b-444b-9f28-ff0b66929393@amd.com>
 <5072b301-2e9e-48c5-8404-cdea976c3182@amd.com>
 <e5bfe061-bd1e-4ce1-8c5d-a0de372ed75c@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <e5bfe061-bd1e-4ce1-8c5d-a0de372ed75c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH8PR12MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 3420b51a-a4b3-4ec6-563c-08dcfd8592a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGJTMEtRNWx6NUdPcTlnblNDODNQdW9hN3ZsaWJVTlJ6NXExK3R4cG9qVVo0?=
 =?utf-8?B?MSs3K0VYTnB4UTlDbDJkVEZCWGFjSEUrcml4dWRHQjZQWE4wK0ZMNkowUlpZ?=
 =?utf-8?B?clByZ0xtaTdNcGVSVDExNnJxc29uU3F1c0U2RTd5YVVkNEFtUm1xNldaSDBx?=
 =?utf-8?B?Mm56eWtXZVNzWnZNOWwrLzFTRkdrMDFwU29ITjd6bExENU8wVndyZ3NPK1lY?=
 =?utf-8?B?dVNmQTJBcEhsWVJsc3ZTSjhQU3BPSCs5L3pHU2MrL29teXhVMHFoWk1RM1lY?=
 =?utf-8?B?MFdXOTM4NmUreWpvakUvL2xncjlCZGhodFZqdGhVT1pMaUdDQlNiRk15S0hG?=
 =?utf-8?B?S3NldmZKMGhWSnZJNmV4RkMzK3R5Si90TDVFaGJQWUZrMkhEall1dnVuUW9r?=
 =?utf-8?B?WElKYjBlZW1walE2UCtUOUFPNU9kSWIySFAwRmQ0cDQ5ajUvTnlYZStzdXBq?=
 =?utf-8?B?eVJkTHJza3ZMcmZQWHo3N2R6bit1cHMzM0thY0FPZmUxTXlrVUFEQTIrUDB4?=
 =?utf-8?B?WjN1cU9Sb3F2d01UMTlia2N2VGpacFVETDBaam83ODlDY1dSaUZPZ1RWVVhU?=
 =?utf-8?B?TDlGdkUvUytIa2lhMFY5WUFPdEJQMnB4YTZ3Ym05OHd2QjNTYmRZVGJWWVgr?=
 =?utf-8?B?TXBLdXpMZVRTMEk4dkxucHpKeVRHVlNHTFREM3JPQnUzN29LcEE3SFFZZ2lV?=
 =?utf-8?B?eERqaG5oazAyZ25CU1ppWHBKL0RJRU9rS2pWeWN6MjEwSWRpOFJ1ZU05Tm85?=
 =?utf-8?B?MXRtaERWK3ZLNWpPWmRJY0xjLy9vNDZZcDErMFZNaUJJSFViaHNqSUJrZlZY?=
 =?utf-8?B?MmNWaUlwczY0aDF2RjFCN3B2K2t6QVA4VXFFTERQUHk2UytaaENNRlNiZ1NP?=
 =?utf-8?B?aVkxOXJFRy9tQmZLU1Nxd1JqNDRSNWZmN1NkNTJRNDZEWXFMcEhVMG9OS0NY?=
 =?utf-8?B?cEpBOWZDbHpBZ2VldzloTG1uTko4WFZyd1JmcFBpdTFWMmRVTG51Skc3dUlU?=
 =?utf-8?B?d01MeGtGeDVIT0VXRTB5T3pxS1k0bFhkN0ZNajBOVDVxQlhaYkxucWRwZTcy?=
 =?utf-8?B?WHVRbzBqdVZ6OFZzdkN1M2JkZnFtK3dDdWtwRW9aWHRValdwSmNYUnhCZzVa?=
 =?utf-8?B?Wml5dHFEVmY1R1dySEI5RmprS0VRQVRpRTlGRithLzhKQ3NZQkxpTGlMMmYy?=
 =?utf-8?B?OHBzeVBZOXQ5VXNMQ05vbkl5QnFyWlMwckZwSGFyRlNRTE9NV1pyWW9WTGVm?=
 =?utf-8?B?SkYvVlQwaStrNXNCWUFNOG91RjhDNjVuMThJa2FlcERZb0xQYXBWY1pIMVM5?=
 =?utf-8?B?bmlrWmFXdExYcE85SUR4cVorY1d6bUQ1RjN2d0Yrc3J3Yk9EN2JCV2oveWNJ?=
 =?utf-8?B?Rk1pQUVlL1FmQXFxWnlaQVNvaWNFZCt0b2FkemRYd0liY3l3RnM1VlFwMjk2?=
 =?utf-8?B?TjhwaHAvMCt0blN5dTBFc1NKS21qZjhzc2RkOFhWRWVBajZsL2RXV2xxbWxy?=
 =?utf-8?B?djhUejA5cjF6bEJjOExDSmdhRjNHaDVkYy9OVms3c1RldHpXQXBCNkFteWUw?=
 =?utf-8?B?VU9lRi9DKzkxT1UvWkdBekU2U1BSNUJxWkxPa25ZMjVRUUYreTlxV2Q4dzBx?=
 =?utf-8?B?Z1Q4WWFPc2d2SkxhOWwzSDlWUVFvOVFSeVJhU3g3N3Zna3NmRXZkbzB0a1lH?=
 =?utf-8?Q?1pMtGFrFtaaGwNgEqRmL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1Vsb0I5aytoUDE2bDV3cEZWd0pLVTkwZXFpWkZPT3FzZWdtRDdQTVVxakFl?=
 =?utf-8?B?U1loVVVmRFpLaGhGS3I5UWs3WFBwc0FvTGh1ckZqc3hDTGhJSkZtY1Q0VVFw?=
 =?utf-8?B?TnJXczQyVjRYRnV3QmZvN2dSK1FGdjlqZDBQSC8vVkVETC9sc2NNUFMrV05T?=
 =?utf-8?B?K0Zkbm5JR2xBM2xhYkFpb3AzSVlyTkxnMXVYellQYUZaQktKR0o4WWxLT2Ja?=
 =?utf-8?B?UmwxWE94UUVBMi8xRkk0SWpUV1RGNnVVZ2tsaWNhWkVkQUticmVSK3FlOElB?=
 =?utf-8?B?ZVA3cjRnSjc3cjRIMFVqSkdyOTAyeTRCeFlCL1BIbWF0L0o4TUhnanQrZ0pm?=
 =?utf-8?B?MC9PTXRkU2pMc0xtZVUrUWFZYUpwRFFaQkxBUmNHclMyNTQwSHdjMmE5M014?=
 =?utf-8?B?ZHNjWGxvdkNjQ1VZeld4OU9XajVXdGhObCt0MVo1b0VBdFF3OTdvRkpVeUN1?=
 =?utf-8?B?b2VMVkVnWVdyU1lYZlVsaHhYaVhMNnFxWGY1M0hOc3JjeExJNVkvYVNja3No?=
 =?utf-8?B?cC95NWpqZWlEeEdDR2lyS1ozVWlIaUdCYWN2TTJWVmxhcklWdHRLeFg0Tmx2?=
 =?utf-8?B?b05GSWVNMHM5NExldU5mUGc2cEV2eWN1SzR4L3dXTDE5SnpyRmF6d2VxSmRi?=
 =?utf-8?B?eDhwLzN4bUZCbDEzdnA2cnl1SzQ1WncxQ1ZOMXFtRGd1N1pobGs2eW9NVklX?=
 =?utf-8?B?L1hmMUd0MkRndDZ4bVZ0a2ZZWE9ZWHBXK0ZJMDF6eUwwaWtXUjFDUUJCQ0ZT?=
 =?utf-8?B?Q3BwY1NRMXhJRkN5TXJST3ppc09jOVY3d0VIQ2xCU2pBYnF5SkVGeU5SbjFQ?=
 =?utf-8?B?UDBKV1BQaC9BandSRm1pQ08xT2s2VWlCSWFhN3dzMkIya3o1ajByeEk5dXN4?=
 =?utf-8?B?UHpsMEtNVmhkZVdPQUJrQzNBcnJ5bzdQSTR1TjdnYWlMTjZvRngvRkFnYlJk?=
 =?utf-8?B?RHYzNmVHVWQyZUhqMkU5VlB4bmR4WmhDSjZmb0d6eHBXODVVSDFFRHM0Y1hw?=
 =?utf-8?B?aUF3VFZQUmtHdmFONEdscmRKdk5JRHVzdll3Ykd6REs4bnZTSjJjNmFUY0ZQ?=
 =?utf-8?B?TWVKWjVMaDBVVU1QZ0FPaUdpemZReWg5MllZS092dTh3VjhEUXd4SkJuWVBH?=
 =?utf-8?B?SlJERUZBanlCNUJmK3dxeGw1ekExU1JKSU54bjlCUWNFbXZRMGV2VEdNaWUw?=
 =?utf-8?B?RjVKM2czb2s4YzVtMURLNGF1TngrY1d1ZlhaLzFxQVhVeHZzc0paODVldmx3?=
 =?utf-8?B?RmlzM3R5Y3F4TDIxR0daSnVGSjBkT051dUt3SjNSVEdZckI1MTZpYTFwNmpB?=
 =?utf-8?B?bGE0cld6akNTOVZPQlg1QUs5WHFlbmh5SmNlYWw1N3hEVkMzTFRnRSs2c2Rh?=
 =?utf-8?B?MDErdmVBOXlhMmdjWTN0WHIwMHhvcmVQWmZ2Q0ExdXp4UUV4YUxyV0hKSjBi?=
 =?utf-8?B?ODVkbkpzdU5ncENCWm5Ec000V2dmaUlIc2dkRk5sUHVqU2tROCtVNlliVHpO?=
 =?utf-8?B?S2JxSWtSL3V0Y3E1Ny9Pd3YvMTdUTkNzNkd0bFJ1UE5Uc2xMc1hFWWR2MkpN?=
 =?utf-8?B?UDNxZnBZc00ra1NSbkxPd2tVZXZ5dzA1NkN5TE1JKzdBSTVyZ0xPdzdsRHNZ?=
 =?utf-8?B?NnhFcmJ2UEFiUExPMk1POGZJeW9rSm1jeFVNTmdmbW9PSlJqQVEzcklBQkJv?=
 =?utf-8?B?WlhFOFFRcmpKaXJpNEZZaGpoRDlMZDlGcU5BaEp2MGFrQlU4bTZVL05ncnFi?=
 =?utf-8?B?ZkNLeFlSV09lVnlZNE93MEFMclNMS2JPek4vT2RVNEdvdWVubGlEcGNVNnBh?=
 =?utf-8?B?Y2E2dEhSWlZJSEp0ZGJpOEpsVkl4eFM4YUp6cjExbHRlRWlQcmQ4WkVxU0hH?=
 =?utf-8?B?SnFKQW53QS9oZzE2bjBWK0pJRHArZEZ4WUNHTlpjc3Q0Y1VNSjkyVjZCVHB2?=
 =?utf-8?B?L3FTKzMvVWQzWVdwOWJzZG9jMUV4T0ZWN1ZFNEg3cDVNbjQwUnZPMkUzMlJv?=
 =?utf-8?B?U2VPWnQ0Tms5ZHlyY0tvVWhPQWJWdDJuaGxIY1pPd0R4REtCeXBkMkcrd3Za?=
 =?utf-8?B?cWNQMFFGMmJ5bDNZejlzRVgxQUJxUGZpT3A5TGgxR2dZckNUZnBlQjU3NXQ0?=
 =?utf-8?Q?aO4d5emSUT4bJBtENDW22AdCc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3420b51a-a4b3-4ec6-563c-08dcfd8592a8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 10:35:31.6236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlAdVxlKchPqAvPv6s0lomYhlM3qv2rS9glR2VhxO2/Tt9mGbFvVVzA2omhhFiIw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865
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



On 11/5/2024 2:13 AM, Felix Kuehling wrote:
> 
> On 2024-10-31 22:15, Zhu Lingshan wrote:
>> On 10/31/2024 11:27 PM, Felix Kuehling wrote:
>>> On 2024-10-31 6:47, Zhu Lingshan wrote:
>>>> The header usr/linux/kfd_ioctl.h is a duplicate of uapi/linux/kfd_ioctl.h.
>>> I don't see usr/linux/kfd_ioctl.h. Which branch are you looking at?
>> The mainline master branch:
>> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdkfd/kfd_priv.h#L35
>> #include <linux/kfd_ioctl.h>
>>>
>>>> And it is actually not a file in the source code tree.
>>> If it's a file that only there on your local working tree, maybe just clean up your working tree.
>> Yes, this is a file on the local working tree, it is generated when build, it is  not in source code tree.
>> The is even no folder usr/include/linux before building.
>>
>> For a quick verify:
>> 1) it is not a source code file from mainline:
>> $git blame ./usr/include/linux/kfd_ioctl.h
>> fatal: no such path 'usr/include/linux/kfd_ioctl.h' in HEAD
>>
>> 2) it is generated when build:
>> remove usr/include/linux/kfd_ioctl.h, then build.
>> If we remove a required header, kfd would not
>> build and there will be error messages.
>>
>> but here we will see these lines:
>> HDRINST usr/include/linux/kfd_ioctl.h
>> HDRTEST usr/include/linux/kfd_ioctl.h,
>> no build errors, and usr/include/linux/kfd_ioctl.h is
>> generated by duplicating the uapi one.
>>
>>
>> 2) linux/kfd_ioctl.h is usr/include/linux/kfd_ioctl.h
>> add random characters in usr/include/linux/kfd_ioctl.h, then build
>> we will see errors like this:
>>
>> In file included from <command-line>:
>> ./usr/include/linux/kfd_ioctl.h:65:9: error: expected ‘;’ before ‘struct’
>>    65 | abcd1234
>>       |         ^
>>       |         ;
>>    66 |
>>    67 | struct kfd_ioctl_create_queue_args {
>>       | ~~~~~~
>>>
>>>> Ideally, the usr version should be updated whenever the source code is recompiled.
>>> If the usr version is not in the git repository, it doesn't need to be updated. I don't know where this is coming from on your local tree.
>> the usr one would be installed to the system when run make install or install_headers,
>> it is for user space, we should include the uapi one instead of usr one in our source code files
> 
> I did not see the folder in my tree because I build with O=... so usr/include/linux/kfd_ioctl.h shows up in my build output tree.
> 
> The extra copy of the user mode headers seems to be an artifact of the Linux kernel build system. The fact that the build picks up user mode headers from <OUT>/usr/include/... seems intentional. If your tree has an outdated version of kfd_ioctl.h there, it's probably something broken with your build tree. Maybe broken file timestamps. It should be easy to fix with a "make mrproper" to force it to update all the build artifacts.
> 
> I still don't think we need to change the code to fix a problem specific to your build system.
> 

Looking at the number of occurrences with "#include <uapi/", it appears
like explicitly mentioning as uapi/linux for header location is a better
practice.

Thanks,
Lijo

> Regards,
>   Felix
> 
>>
>> Thanks
>> Lingshan
>>>
>>> Regards,
>>>   Felix
>>>
>>>> However, I have noticed a discrepancy between the two headers
>>>> even after rebuilding the kernel.
>>>>
>>>> This commit modifies kfd_priv.h to always include the header from uapi to ensure
>>>> the latest changes are reflected. We should always include the source
>>>> code header other than the duplication.
>>>>
>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> index 26e48fdc8728..78de7ac09e8a 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> @@ -32,7 +32,7 @@
>>>>  #include <linux/atomic.h>
>>>>  #include <linux/workqueue.h>
>>>>  #include <linux/spinlock.h>
>>>> -#include <linux/kfd_ioctl.h>
>>>> +#include <uapi/linux/kfd_ioctl.h>
>>>>  #include <linux/idr.h>
>>>>  #include <linux/kfifo.h>
>>>>  #include <linux/seq_file.h>
>>
