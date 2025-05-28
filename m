Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3CCC5AE59
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 08:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E4B010E5A2;
	Wed, 28 May 2025 08:07:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QSSknjFJ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEE2710E57B
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 08:07:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LH655W2Qf2Ql/lPBe+6FFSNfJrVZCwlYjhs/hkOATUXxWt25cJN6AI3IC+WCVup3gfSF98P4BwPks5ekmmpueyeY90eSO7k6lXsWb7167WekpGH1A/IRkyxeVZTJemd4pLQE5AylkIET7Dxs8rjy6LwsB07Yd2tS+nY808tQNxlIfS4qklrScuUOTJ04Be/IjimSY/c8OmlL6EtmJXVRZugEDzfLJWZvse2inPsAS3VGbA6G1dAQ+bl9a4JphhQTAa78Or2WdT+ktlOmQCu1D39XNgcf4oogDILXs9x+48xWFALvLmvU4bwT35OOc4/fssmzhmWtGpxZInyQfxxYcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAJ2e6AkNSBo+7UuLA/N9ejbILxY8rs2bsLehl+OZGo=;
 b=UIgTxQeeB94tZ6ehLJItKG7Y+69E0D86/ODX0Awmn+ANifxeOZJJ0JD+vyTK7sXyUopkVBtcS7WlTzUBtWlhTMPeIMukxbUmqXuUbrhsHjWdOPUt9Q5q2L8RQO14d6sWFnISjY/R3CY966jVzTN3ow9aVyxBIh713/5Bb2QuPgNQcU9gQVtsd4RNB2bC3k1oz77TzzvSeOnEX8tmnPsY+uqj0OxLDgHTHKK3jVwKhRUtVBj5l3Dn7j1VXbsBQYujpfylA26TX0ryVXCiS4dnwrR+VI6RhyDNbTKoCh6Ip40pym5/4Q6qZJ66rkB+CkFCM1IJE3Vkn0cxdt3G0czcxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAJ2e6AkNSBo+7UuLA/N9ejbILxY8rs2bsLehl+OZGo=;
 b=QSSknjFJlGpW91YS8PyR8KK9LXzji/AcWtJG+2XfcrDGjHNQHAUVWAlhro/zaqV+Pqo/UZNqtPpTghZRGjLxPcUXTNPqC3ZPM/HNY6kUOq4P5em4+qLhWKIBtM2y7CgvXOcy+uE310e8i8Nklks0ab7VRTJXdS3pWGePNkpqPko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB8553.namprd12.prod.outlook.com (2603:10b6:208:44e::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.21; Wed, 28 May 2025 08:07:26 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8769.021; Wed, 28 May 2025
 08:07:26 +0000
Message-ID: <f6bec410-26fe-42af-a7c0-896ff8d0f0c6@amd.com>
Date: Wed, 28 May 2025 13:37:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/4] drm/amdgpu: update GPU addresses for SMU and PSP
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Christian.Koenig@amd.com,
 Alexander.Deucher@amd.com, Owen.Zhang2@amd.com, Qing.Ma@amd.com,
 Emily.Deng@amd.com, Jiang Liu <gerry@linux.alibaba.com>
References: <20250522104048.569456-1-guoqing.zhang@amd.com>
 <20250522104048.569456-3-guoqing.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250522104048.569456-3-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0197.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: c6305aa3-b6f1-4449-6b8b-08dd9dbeaec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3NmU2JZc2I0YWhHNzE5eEFqc0dFMEY5SXUydnhBbFpBb1RuTEM5TjA0OE9m?=
 =?utf-8?B?UCt5YW5wS045YWFFVDk4QUJJc1Fxb1B1dTRUK0hGVHh2RDZxZ21lc3pFaVNN?=
 =?utf-8?B?a2ViUWFkUjM1bGxSMklXOTBKYnNlckhjMFg2dStoY1dzenpRcjMxdXhFT1R2?=
 =?utf-8?B?d1RFZmRZRVVqSkJHYTRPTHdBSENGaFc2elVuVk5BZElKV3FGR1h5QmlNN2Ju?=
 =?utf-8?B?NmRVY3FJZXhyMi9TOVB6eDJvQU5VTGU4RlhMYXdaT3I3cG1vbEhlMkJrS0ph?=
 =?utf-8?B?bDMwWUpLSnRoMXIvb2kzb2FMSEpSVXhVYjZZK1lLUHVnVUFDejN5Wjd6bS95?=
 =?utf-8?B?bnBXaFFjd2dXdTRUN01OSzVKZmtkaVdORklodlZVSWcwNzVHY0twUTV1RUlI?=
 =?utf-8?B?d1A4eXFyRllDN0RJQUgvaFlFeTk3MkdobmYvSlRXNTRJU0pac3VaZjN3ckF5?=
 =?utf-8?B?MW9DQUFMUG9lQXpkSGE0ZE9zWHZTVC9vOEkvZEFFYTFwQWgxTGVsT1BXKzQw?=
 =?utf-8?B?eWJqTFc2MFJsMDJXZVpHbmU3UUpyZFAyNmdyKy9aZUVVMGF3aGRQVU1TS3pF?=
 =?utf-8?B?alRzYXJ2QkFIeHh2UlBLSE1RdnJERlJkS1E2Tmh1bmVhTXd5MFBJRzJ4c1Fr?=
 =?utf-8?B?UWRBRTNRaDhzNnR5MTcyRndPcjZTZTVzS0E3dFNDWVhKWXdFc2ppRWY5VzFk?=
 =?utf-8?B?QkhXbklKazE1b1ZUNzU1N1l5MUd3ZnhsL0hMc3hqaXFkWlgvY3R1SFkzTFNk?=
 =?utf-8?B?T1gvUXFVTE9FMDBiMnFERngweXJHTWhwSGVLMHF5dGQ0V240akw1aS9IYS9K?=
 =?utf-8?B?SGpQNDlxNW1MZVJvZlB1clhjYUJLWHR5S2V1ekpGSHA5L1orVFZ4MzQ2WmJm?=
 =?utf-8?B?RHpuOG1CckM2L3ZUZ1MxVWpaY0tiSDdHWVM4TE1qTXppenUvNFFodUJZVWZo?=
 =?utf-8?B?Z1RkcXpOTG96T25JS1ZWVnBSMGpabEhYUUFzbmpxZlNDSTVNelR1RFQzOUVZ?=
 =?utf-8?B?NGU1WkZCQmZ0K0ozelRUN2ZYVUkyc0tsREJqOXNuNlZMTG5QVDN2SzdFdVJn?=
 =?utf-8?B?Wkg3bmF2SVdraHlaOWdTSUYrK2p3ZU0wMElCZkkzUHF1OE9oWXRUaHdYb01D?=
 =?utf-8?B?OTl3OGR6NUs5dFdkbnpUSnZhd25FK1liM0hpeGdWNWdqLzNEdGJZZ2Qwd3Bl?=
 =?utf-8?B?b2h6SklTNWIvRFdibCtnZUJ1dUgxU2tpTlRHd04rWnVtdHhKV0pXdkRDL2x1?=
 =?utf-8?B?T1ArcnovZUVjVkZyamtQZFZDYnhEZFB5Mldod2s2emNCWVE0Wkw2Y01ObDF2?=
 =?utf-8?B?dm5QalRMZEJ1eG5iNHZFSXNqdGFKQzFmdHJYUStzZGJvRmE3aUIvUXZBdXZt?=
 =?utf-8?B?YmlUVVZvWFBvd0laRmV4aGRjZTF1bkdnNkQyTlUyMDJMb2FTRGk2VXMwYVdF?=
 =?utf-8?B?UVZGSjVBU0FmZFU1OWtBT0hYTmw5QVVPZEEweWc1S1Q3aUR0Tk5US0xtR05o?=
 =?utf-8?B?OG1ka1p1Z3pRRnVtSi9FUXNIWkQ2MFMvU0FaN0RvdlYxWC9ERTBwSXNHeFc0?=
 =?utf-8?B?amdJZ0NsTU52cFBQM1dpN1c1ZFFIcm0vK3RMc3lXalZhcm0vblVBM3hHcGVY?=
 =?utf-8?B?bzhySG4zSEdwWVZRMEF0ekwxNEZnMFF4MENqcU1qVWs4dmRNWFMweHphaHhj?=
 =?utf-8?B?UlZqcE8yK2t3eHlpeWwrM2J5MTZ2ZUFPbkduZEgvRWtweE42SGhyQlpUeUl1?=
 =?utf-8?B?NURrTURWUHFzcWt5VmFhYk0rVXh3ajg5NzlLMTZ3RjZYM3VoelQwWkFuLzUr?=
 =?utf-8?B?a0NHdUdqSUZzekh5VzA4QXFXeklhVDlETWlNb1NaYzdQa0xoY1ZWV09Ncmw5?=
 =?utf-8?B?TjdvTDdnSXJCOC9udUVpcmRNZE90MC8xUm1BaEdsd1F3T2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDg3b3k5U0gzVGZnSDVReDl0aHZXS2MyeUJJRmlNSTY3TlE5WUk4dXB1RFVE?=
 =?utf-8?B?VTlUZUE1N2daN2lraHRmdTg5Q3RuTlBhVVRFWlVkejlxSUJkZWRYYUtOMG5N?=
 =?utf-8?B?cE80Z1IvQmFoSHZYTTFvWkZiOVpqc3dYd0ROREVUd2VDdEx5VFZxRCtvdmhu?=
 =?utf-8?B?MVN0OGZWVENSbE0yM2xCUXNXamwwbkd5Wm9IL3Nxdm4ydlJrTmFxRkhyK2Ft?=
 =?utf-8?B?RnBmdkFyOUIvUjlJdHo4bHN4MnhLckkvSkRueWNCQXlYdVcyRUpTN3d5d3p5?=
 =?utf-8?B?bHV0NVpCOTZUK2o3Q1pTU1FNOEhjZmxDQ1hCK3Q4Y0xJTVdPcEF1aGpQTDZ2?=
 =?utf-8?B?S252UWZRaHZpMks2VWxMK3d0TDJ3OGVhWW1FYmR4eE1QOXVqc1BqbGFQamJr?=
 =?utf-8?B?OVRHRDdoODlrM3N6NGh2Mnh3OUZ1VjZIeFNjSjJjTVd1Y1pTbk9SME9NUXJN?=
 =?utf-8?B?MEhpL2tsTUJPbVdCRy9TK2VoQnpOWUlFV1gwcXMxYWpUZHhZd1hpY3Byazl6?=
 =?utf-8?B?ZVJyK05OMGZkMnE5bGlLQ3pOdndZQ3BvazQrRG9FTitOTzVrNXNnQmR6eStE?=
 =?utf-8?B?SVoweVkwYlFqZ1dnZE9UemRqWUVIWFg0N21OdGxvOHNzbW9ROGpUcGkrRUV4?=
 =?utf-8?B?ZndhcUsyYlZWZHRjNHEvZ3RWMjBqMGVtbzJPejJXZzgzOUJaOEZKYkNXejcy?=
 =?utf-8?B?NE1ONFBjOUw3a0xadXgrTmFUZWlTNGdYVFRuWnQ1ZXJ0RGtSKzhndGh3T0dM?=
 =?utf-8?B?VnNWcEJtV0N0WisxNlFrbzRWbm9iOFFkdHM5NkNwTXlUREplbVlGKy9FblZQ?=
 =?utf-8?B?by9ESjN4S2pHS0tvbkRRYWZnQ3lOTXpWZTFPUGhYaUkwZzJsT2kwUGt3Mm9o?=
 =?utf-8?B?UGJObjJ5a0pPOWF0WWJvdTJKb3NNb25vM216RURaTzRPM2RLN3JCM3Y0SDBa?=
 =?utf-8?B?dE5aSnZLK016Q1NBVGZMR3pqNXQwT0JSVnFiUkVCMnNmMThaODZ0SDN0UENH?=
 =?utf-8?B?VHNjYkcrRkI2SElmNzZFMjRWa0w4Y25YQTU4dm9HOEFLeHNjK2huM0ZTTmhM?=
 =?utf-8?B?UnZoM0RxaXR0blVVVDdzeGYvNHdPVldva05GdTlHajJ4NDZGeHNVa1V0aGw2?=
 =?utf-8?B?MEpya2k1THJDaE4xVVUyMjJmZUZQZFFtdjI1QmdPci9FWVlyR3BWWVZKZC9O?=
 =?utf-8?B?NjRTNlAxR3ZrWm90TG01Yy9EemFIY29WaGFhVEFsY3BBakpSRzlIbWNtbFAr?=
 =?utf-8?B?QURXUDF1ZXZqYlVFaGZEMFRWMXM3bnFwSDVTWGluU1QyUm1BbmFlUFZOYTdN?=
 =?utf-8?B?b2VPMW1QS0NlSUdDNVVjRWI3WVoxNkNqejV0NU1LZlcyRGRIRTN1QlllcFB0?=
 =?utf-8?B?a2VDUUxMeVNkWHduUVdKU3lyUmhBbHJGbURieDJlNHByeit0VFFBNXl3dFZs?=
 =?utf-8?B?TlI2VUhoNUp3aFpGQjY0d0R5cGtXdEd4YWhNVDVSRlVRbWZ1S0lVMDdyQlc1?=
 =?utf-8?B?Z3RBWWpMSUc5SDFmVS9ScWF5SS9UeGhEbGVJRnREK2RxTjVNcnlJYWxEZHBl?=
 =?utf-8?B?SGI3RG4yUi9EQzg2aG8yd3NMUjljdkRmbzdIdlhqK1hoYUVUMU5PTDhuSFB5?=
 =?utf-8?B?c1JMMU5lS256UW1CSlBiNy9OenJaM0x0VHl6dUN1bkNRL1VhNWZoWFdMNkg2?=
 =?utf-8?B?TGk3NlZZMGl0Z2lrQmlSSTdPV1AzaHl3QjNOaGZOTWlUNUcxSHRoM3ZkRTJs?=
 =?utf-8?B?RU9rTEduaStJRTZxZ1MwRmRxVGJGb1R1c2tVbG9kRnFGckg2MWVhejFHbzNl?=
 =?utf-8?B?eitPU0grYzZGRmdUL2t3cHI0Y2gvem9TdnROano0SFRNRW1pYmx1ZGRIMVRY?=
 =?utf-8?B?dGtqdnc5aG1wRFRJWmlweHBsTnZ3eXBGcUlMdWxBeUppK2JwNndQektyRG9Z?=
 =?utf-8?B?NG9vVC9PTkhqWEhtYXVsRStQMHdwOWNtZFZHYVR2MDYrZ3JwUXZIYjdCVzhM?=
 =?utf-8?B?QmNnaGxuY0VLUHVXRXJKUDJSZDM4RjNDWTl4ZC9uN0p2VHA1R2hvbytlSlNq?=
 =?utf-8?B?MlJabkZzRVJVSmRZOTF4akR6UkNlaHdLVzR0M25uSWtWbmlWdzFVUlFOdzdi?=
 =?utf-8?Q?gNxERSK2FF19+/3pKHfuCQuKC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6305aa3-b6f1-4449-6b8b-08dd9dbeaec2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 08:07:26.1693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bo3Uf1+FLNkdCIGtWT5pPIPqXVLO2k6A7/o6O70eezyO8fuWeiYrvS+iSPQAFyVr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8553
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



On 5/22/2025 4:10 PM, Samuel Zhang wrote:
> add amdgpu_bo_fb_aper_addr() and update the cached GPU addresses to use
> the FB aperture address for SMU and PSP.
> 
> 2 reasons for this change:
> 1. when pdb0 is enabled, gpu addr from amdgpu_bo_create_kernel() is GART
> aperture address, it is not compatible with SMU and PSP, it need to be
> updated to use FB aperture address.
> 2. Since FB aperture address will change after switching to new GPU
> index after hibernation, it need to be updated on resume.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> Acked-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 20 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 23 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c  |  3 +++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 18 +++++++++++++++++
>  5 files changed, 65 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 4e794d546b61..c93376ac4043 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1513,6 +1513,26 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
>  	return amdgpu_bo_gpu_offset_no_check(bo);
>  }
>  
> +/**
> + * amdgpu_bo_fb_aper_addr - return FB aperture GPU offset of the VRAM bo
> + * @bo:	amdgpu VRAM buffer object for which we query the offset
> + *
> + * Returns:
> + * current FB aperture GPU offset of the object.
> + */
> +u64 amdgpu_bo_fb_aper_addr(struct amdgpu_bo *bo)
> +{
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> +	uint64_t offset, fb_base;
> +
> +	WARN_ON_ONCE(bo->tbo.resource->mem_type != TTM_PL_VRAM);
> +
> +	fb_base = adev->gmc.fb_start;
> +	fb_base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> +	offset = (bo->tbo.resource->start << PAGE_SHIFT) + fb_base;
> +	return amdgpu_gmc_sign_extend(offset);
> +}
> +
>  /**
>   * amdgpu_bo_gpu_offset_no_check - return GPU offset of bo
>   * @bo:	amdgpu object for which we query the offset
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index dcce362bfad3..c8a63e38f5d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -320,6 +320,7 @@ int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
>  			     bool intr);
>  int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
>  u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
> +u64 amdgpu_bo_fb_aper_addr(struct amdgpu_bo *bo);
>  u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
>  uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo);
>  uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index e1e658a97b36..3fc4b8e6fc59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -871,6 +871,8 @@ static int psp_tmr_init(struct psp_context *psp)
>  					      &psp->tmr_bo, &psp->tmr_mc_addr,
>  					      pptr);
>  	}
> +	if (amdgpu_virt_xgmi_migrate_enabled(psp->adev) && psp->tmr_bo)
> +		psp->tmr_mc_addr = amdgpu_bo_fb_aper_addr(psp->tmr_bo);
>  
>  	return ret;
>  }
> @@ -1270,6 +1272,11 @@ int psp_ta_load(struct psp_context *psp, struct ta_context *context)
>  	psp_copy_fw(psp, context->bin_desc.start_addr,
>  		    context->bin_desc.size_bytes);
>  
> +	if (amdgpu_virt_xgmi_migrate_enabled(psp->adev) &&
> +		context->mem_context.shared_bo)
> +		context->mem_context.shared_mc_addr =
> +			amdgpu_bo_fb_aper_addr(context->mem_context.shared_bo);
> +
>  	psp_prep_ta_load_cmd_buf(cmd, psp->fw_pri_mc_addr, context);
>  
>  	ret = psp_cmd_submit_buf(psp, NULL, cmd,
> @@ -2336,11 +2343,27 @@ bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev)
>  	return false;
>  }
>  
> +static void psp_update_gpu_addresses(struct amdgpu_device *adev)
> +{
> +	struct psp_context *psp = &adev->psp;
> +
> +	if (psp->cmd_buf_bo && psp->cmd_buf_mem) {
> +		psp->fw_pri_mc_addr = amdgpu_bo_fb_aper_addr(psp->fw_pri_bo);
> +		psp->fence_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->fence_buf_bo);
> +		psp->cmd_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->cmd_buf_bo);
> +	}
> +	if (adev->firmware.rbuf && psp->km_ring.ring_mem)
> +		psp->km_ring.ring_mem_mc_addr = amdgpu_bo_fb_aper_addr(adev->firmware.rbuf);
> +}
> +
>  static int psp_hw_start(struct psp_context *psp)
>  {
>  	struct amdgpu_device *adev = psp->adev;
>  	int ret;
>  
> +	if (amdgpu_virt_xgmi_migrate_enabled(adev))
> +		psp_update_gpu_addresses(adev);
> +
>  	if (!amdgpu_sriov_vf(adev)) {
>  		if ((is_psp_fw_valid(psp->kdb)) &&
>  		    (psp->funcs->bootloader_load_kdb != NULL)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index 3d9e9fdc10b4..bf9013f8d12e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1152,6 +1152,9 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *adev)
>  		adev->firmware.max_ucodes = AMDGPU_UCODE_ID_MAXIMUM;
>  	}
>  
> +	if (amdgpu_virt_xgmi_migrate_enabled(adev) && adev->firmware.fw_buf)
> +		adev->firmware.fw_buf_mc = amdgpu_bo_fb_aper_addr(adev->firmware.fw_buf);
> +
>  	for (i = 0; i < adev->firmware.max_ucodes; i++) {
>  		ucode = &adev->firmware.ucode[i];
>  		if (ucode->fw) {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 315b0856bf02..f9f49f37dfcd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1000,6 +1000,21 @@ static int smu_fini_fb_allocations(struct smu_context *smu)
>  	return 0;
>  }
>  
> +static void smu_update_gpu_addresses(struct smu_context *smu)
> +{
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +	struct smu_table *pm_status_table = smu_table->tables + SMU_TABLE_PMSTATUSLOG;
> +	struct smu_table *driver_table = &(smu_table->driver_table);
> +	struct smu_table *dummy_read_1_table = &smu_table->dummy_read_1_table;
> +
> +	if (pm_status_table->bo)
> +		pm_status_table->mc_address = amdgpu_bo_fb_aper_addr(pm_status_table->bo);
> +	if (driver_table->bo)
> +		driver_table->mc_address = amdgpu_bo_fb_aper_addr(driver_table->bo);
> +	if (dummy_read_1_table->bo)
> +		dummy_read_1_table->mc_address = amdgpu_bo_fb_aper_addr(dummy_read_1_table->bo);
> +}
> +
>  /**
>   * smu_alloc_memory_pool - allocate memory pool in the system memory
>   *
> @@ -1789,6 +1804,9 @@ static int smu_start_smc_engine(struct smu_context *smu)
>  	struct amdgpu_device *adev = smu->adev;
>  	int ret = 0;
>  
> +	if (amdgpu_virt_xgmi_migrate_enabled(adev))
> +		smu_update_gpu_addresses(smu);
> +
>  	smu->smc_fw_state = SMU_FW_INIT;
>  
>  	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {

