Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95AEC3ABC9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 May 2025 09:59:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 803B510EA27;
	Fri, 16 May 2025 09:59:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="muyT6+a+";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE95210EA27
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 09:59:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zmfv6baxAyDVE9JqBS1TZb+4bYxLLBoJP9wEPyYOqqfSMu0bW2oZmzaeqF+2Z8+Q1NRiOskxDSidLouyayVKvrVlEZQc/mXBi8gW7h2DBV5puEO/Zj5/N0aA3CyEqi1dAmUlDAF82uVjVf3rDPic+jkFz9ZvnR2fGt5rlahx1Ck21Ox5j82rhL4tEr8lgtsh/AFwlnqw8pKJTy+DNlI9B+fXFuq8cHGcwxtI76qP670ujTaPZVNC+Pa2c63HWbrZZOD9V2it+mN8ooscvrFJKkBvcwWzqvlmaIInVv6HJyv7O2KJ+PGOjsxvo8+xs7gOKInpqsxRxeows1UD4Ew5Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mugHKruL/sqBOZCdj7hCHKbz7U3okthcbNohlJuf+9k=;
 b=AU/xRkUPBlxhWAA+InoNWtHBz3HeyzZMOQ4k34LIsdWuH1fwT9/O6TCSMguyKDc/FbGBJkPpm1JhTRuCLlEtib7h2fHqm6lj9heQHeCtCRpbgffIeMqMTeOK1vs5aNkthFy3d3pLE5jo1660laO3O0fF9HtujAI1j5/e8GCMyOYUKCza8yNSeLBIqrs9AnaryBoFd0OjCOPdR5KUJfhzV9dPFx12KkhHc8scRkPOmsM491/wkArGx/fT50VWeg1xq2Sdm/LWr2wNCs7KXyk+2e9x/4HYh6QCLVhmOYDO9gLsHX/ImJP75FBlnH/riZpobdc2E55DdyH/SqOIxlFD9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mugHKruL/sqBOZCdj7hCHKbz7U3okthcbNohlJuf+9k=;
 b=muyT6+a+xSMYcIvaNjylgugk2Txmf6SWBckiqMra3TTsWYW3LLuPWfV9N+HgGI2XFbGOv8oNmMPr4eZTKuvAlIJYHWi099EK/zL0wXaFSXZeX1gYMg0IyGotDHV5RAtVWbCbEy4RmFIeSx7UxnPiaxYpTiwiHmbYJWhq8X+tkno=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 09:59:08 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 09:59:08 +0000
Message-ID: <bb8859e1-85ad-459a-b868-33f1b431a79c@amd.com>
Date: Fri, 16 May 2025 15:28:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] drm/amdgpu: update GPU addresses for SMU and PSP
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Christian.Koenig@amd.com,
 Alexander.Deucher@amd.com, Owen.Zhang2@amd.com, Qing.Ma@amd.com,
 Jiang Liu <gerry@linux.alibaba.com>
References: <20250512064141.387079-1-guoqing.zhang@amd.com>
 <20250512064141.387079-3-guoqing.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250512064141.387079-3-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0116.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::8) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 30759100-3d0f-437e-2699-08dd94604c87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVNhZUVWekJRQkZDTTd0UkdBcURQNWlZclhrV0VocndmNEpuK2wzWVVGZEFU?=
 =?utf-8?B?T1NsUjdGU2JydzJRd250UFB4cGlvSWRSTExsaXRvKzA4NWl4WmRib1d0WmRB?=
 =?utf-8?B?L1VGeDhISmJxYVJTTXY1RllHNFV2Wk80SE5QWVBNdlJxUmlleTl1cDZHT0FU?=
 =?utf-8?B?eWFxeFZiY3F4b2R6dUNSK2NpblAzVmlUbklIVXE1dG8wa2l2WHlMU29FN25Q?=
 =?utf-8?B?WEhGYjNMZ2ljM0FVT2pLRTJ2UENGdytkb0QvK3AzUC9uWkxPRDZQUjM5dmJj?=
 =?utf-8?B?SUJsdXdJbW9rN3lEVi9wUWxzWmlBS0xTWkxVNmZaRlVlaXRXZUdoSUJGVTZk?=
 =?utf-8?B?QXVnYzBWaGV2a2djNlQwV0FkR1Rod01kQ0Q3OWo2WXRjamFpNnpIU0hQQ0pB?=
 =?utf-8?B?NVlDY1QvN216Qm0zM0NUeFh1V2RIMmpZcHlOeFc4WTkzS1J6OTlFZERySnBq?=
 =?utf-8?B?c0EzTXJQbVBRWFR2RXRzakFSUkJRS3JvZ1VYYXNBeXhGUHF5bXEyZEplK1o5?=
 =?utf-8?B?ZGFiRlNGRVZqazkxZGM2NW9YVE9peWZUTk1YSzZQMjV5SEhYT2diVjJXN1Ny?=
 =?utf-8?B?MXFFRmRqZkttSmZydDQ0RnhjTXJydzF6N1RhRXJIaTlJVXNJYlY0MEpjWmJE?=
 =?utf-8?B?cnZFa2xEa05DRXArUVlXMXlLMmd3aCtxY2Q3OGhLby9nNG9hcjVzemtnMDVD?=
 =?utf-8?B?bVhTWG5IY2lhdkkrR0ZHUWczNVdIcVVCdyt6eUlnSWJzVDBpNFRqVU1IbDVS?=
 =?utf-8?B?SXNPZFRjcHhjUWtlYTVjNWFsV2w1UHoza1dPZFFzK3A0Mnc2b2dmN1Fkc3dv?=
 =?utf-8?B?bVFQdkwxdm44Vk00VTMwV3gyeUxoVmsvN0czZXJITGFrbCtaeVlkWXpYOU9G?=
 =?utf-8?B?NVB3T0dGeG8zemJDY3RIQy82eDBxMmRLeC9obTM3ajFCZVMvSmYxb2l0MTBJ?=
 =?utf-8?B?QWc3NVg0cWpNMnZxZm11ZktxUVNtQVNSRU1pTUN2cVB5QVFSSzIxNDdXZVpH?=
 =?utf-8?B?VWV2NnZ1UEFyTTZRT1dEWHR1QjRUajI1a3FLT1QxSjcycFRvS0ZBU1Ftdlpu?=
 =?utf-8?B?QXJUUDVaSkdvbDhRVEc2U2RtWVU2U0kyaGVYdDJQTjRXaHJuY1Y1UEFWbnNa?=
 =?utf-8?B?YngvaWNrdW81M2hIeWtzQ3g3cWgydGJCRUd0M3dXKzJLMWIycnAxSEVXV0Z5?=
 =?utf-8?B?Z2g1TXNsdklkUFhvSUxSUXVhWHErVFpmK3BtT0xkK0NmS0hnbHRuVXJDNTlh?=
 =?utf-8?B?SWF5L0Q2eFhCekUxTVl0clZneW1kVVVrN0pRdGVmWFZqc3lKSkNlUThJV1Nq?=
 =?utf-8?B?VE1oZm1VRHpxR0JYUzVKeUdiekhwVUFNR3IwYkJudzdEWTYvZm0xN0N4UGhn?=
 =?utf-8?B?dFE3Ym83ZVp0T0tYcjVjY24vaDdORVhUMmdnUUlEWS9ZakxVZGRod3g5L0ZO?=
 =?utf-8?B?NzdOZHlCdlA1NVBHc1JtMHRKdjA4bmE2V1kyZXg1M25iZGNsV0crZjFzMDdx?=
 =?utf-8?B?Ujc1SDF6aXF2WHVPWGVLR3RqcnVBSmlaZUhadXVEYTM2V2hzczJNY0t3K1Bk?=
 =?utf-8?B?N0U5Njg3VWJZanA5VEtjVTkxTFV0TXNVcm1wRGZLZjc3YkVEOEhnV091UXli?=
 =?utf-8?B?blNJQi9qcGpkNngvNUJzWW5KaGQ4MlVHOEltTGU5czlkQlljSUZUUnZpaFpw?=
 =?utf-8?B?NS9JUXp2MlA2L3VMOC9sbWxScVZ4TVR1Ym50Yi8vQ2pmQVA2UlFJR052bnRR?=
 =?utf-8?B?SG5XNGsxTE5WNHFUb204RUpSL3NpUlFXN3RqWWVsQVhsL0U3TE9Cd1YybGtW?=
 =?utf-8?B?amFrRUdoYlRnUHBSdzRSOCtOU1JMUFdYT0pVSy8vWnNTSXhJWXhZUjl1d3cz?=
 =?utf-8?B?UU5lb0Zscjd1WWsybnI4c0Y2RUJGaktLdWV3SGNZMWxkK0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVl1TEZMeGJQZ1JmR3YramUxWlpveURlNmxjWW1rTUVLclJEZHhCYm5lTWpR?=
 =?utf-8?B?ZGxBY1RJUkIvQXQvcUhvaG9JU2t3am1CYVJnWTBsSHphdUNyQkx1Z1hIeS9u?=
 =?utf-8?B?RTR0QVdDTy91eFFZVytxWDVVVDVyTGR3eit2OWdjU0FEeUlvblNBa1FrdWNx?=
 =?utf-8?B?dXNIb040TXViTnZ4L2dkNDZITUJ5eENTYkdydHhEK1QxcnZtWjQzOUNsUUw3?=
 =?utf-8?B?MTBpYk8zaGUwOVRRZ0svUVF0SGlYY1ZEL0NHbnZ1Z3luWFVrL0pwZllCZG5K?=
 =?utf-8?B?MkJsTFE0VHM0Zng5WEtMRm9XM0JDUXhGRTIvUHBSWE80aXhyNnFsM2NWRE5r?=
 =?utf-8?B?LzNWVXloOU00cTV3NUp4OXN5WWdYbmRmNWlDMHYzZGwzOFFxUmNDVzdwNXRu?=
 =?utf-8?B?WG5YMGNWMU5uN3Nld2xCd2o2dUdKaHZRSk9sOGx0alVqTTFEWUlsMWgzOE0y?=
 =?utf-8?B?MXNuQXV4V1d0MGF0OU1LWlBXSGNkLzNCSURjeTNkaTQwNjkxMDJOTlFGbEdI?=
 =?utf-8?B?MTVSc3VReXZzWFBxNGU4Z0Z4OWdTMzdCV0dCcG9SWnhicHI3NFR4VDJGQ2pi?=
 =?utf-8?B?TE16RytXK1pURTFYOFg1d3FyYnBoNGRGalRxUEltU2xjK0Njc3JsTXpoTFkw?=
 =?utf-8?B?V0NsZzBYcHpHUVh3bWF0YjB3ZXVIYzI3YnJ3UGVkREVTdkFmcDc1S0dIalhj?=
 =?utf-8?B?Sms3MXBBU1VyR21oeHZoOExUdWNiUkFqMnNJVGtLK1l4djhYWlBJdUcxVUtm?=
 =?utf-8?B?UUgrdHBqanBSSm8yOXo0ckRCSXpZSkU1N2xlYlhoc2RrWXR6dW1BUzlkc3RX?=
 =?utf-8?B?ckNONFM4VnlsTXU4T2Qwb0FKTUV0Qm9TQWF1M1hUY3N3SnI0a0RPVmJRaWVr?=
 =?utf-8?B?djZ1TG5MWk9wOTZZWUVHTW0vUXJZdGZPZjFFVXgzazdwZ3FGam43YkZ1a01E?=
 =?utf-8?B?SUZCbXpIK0QzRDdRWUZ5cmNvcG83ZTQzcXhqcndqaHBTYWFUWFE3ZEVvYVRz?=
 =?utf-8?B?QXIxRmVjTzN3NmhGc0Jiem5FekdTRlFreWlFaGE3MEJOMVMvaXFjdUxyU1Vh?=
 =?utf-8?B?alplaEo2VEw2Y2FHdTdaT2hscVRySE9ycjNpYzJ3QjhGSFp0N2N0MXdkRmRV?=
 =?utf-8?B?UnlEQUVwSjZSMTZ4WjVuS1dZN2t6YjZPQkhLYTZ3cmxsN1lsMlVKWlBLYkxW?=
 =?utf-8?B?VnBjUitXNXZTM24rSFBHZ3JGTnJHSHNyY2VOVjl1Qklta0hKaFVTOHE5amlM?=
 =?utf-8?B?alp4YmplQlBKQys3bHFNZXZpdmhRaElJMk0rK1FMZWJFdnU0d1lMOVBlL2lp?=
 =?utf-8?B?aTh0dUwyeENYWllrcGxwa3NPZXFLNDZ6MWFzTXpoTVZ6Q2E4N01Ta3dSblJJ?=
 =?utf-8?B?YXFXU0NGY01Hekw5ajBWZzVkR280RElWcEFTUW5VUjFWZCtyWTZGeGhCODRp?=
 =?utf-8?B?L1VPQzJRYU9PQU4wMUtJeDlLRkFWR09sY3BGdFd0aGR5QVJPc3RIN3pibG9m?=
 =?utf-8?B?alplMDkwWmo5VjkxMk1nUzRFNUluRENnYkFNV1I3WlYrdHZwTWVKcjJtdWpt?=
 =?utf-8?B?cmhuTzFHQVpKaXV6ckxBNjR1Z1RSMk9ndlA1STNiZ09udU9FUndQV2lnY2tx?=
 =?utf-8?B?Slc3ZjNkSUNoUnpBL3pBSGlpY1N3emtqem5UOWtIOEJYZnJoNXNHSFhGdGpQ?=
 =?utf-8?B?SkV4NDZtaUp1d3IrSDRRSDNaSmZseGtsOEVGcG5UemlxcklETWxpUjBlNnZm?=
 =?utf-8?B?N0NuUGNiUjlIdE9RRFk0TEpZSVVKSFB1NUZyZjgyTzhZSHZiM3B5V1ZmRmNa?=
 =?utf-8?B?Q0I3by9ndHkxcVFNMkxjd1Q0UFNtVSt2ZXU2Y2tOY1NHS0dxZG0zd2N2amFY?=
 =?utf-8?B?djhtV29EN0xTcjNZTjlTSlRsMkYzZHE1NThuaFRSaVBEUzhOV3M0YlY3Z20z?=
 =?utf-8?B?REVSdkF3bG9OczFZWGtyMEJMb09LYTFiNEZmTUZyb1BINHZ1Q3hqSUkxM3Fv?=
 =?utf-8?B?WExaTG03K0c3MVBscDlpSFNZc0hiV3FCckdPaVd6RURqd0dQVGk2N0tJWWlO?=
 =?utf-8?B?VTJqVk5GUHd5SkNlZzJscXN0R2hEZGZXMXc5WndvREdVd3VBZVJ1SlA3bVdW?=
 =?utf-8?Q?XMhlpkwbdjbgy0gqnF/r9DZN8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30759100-3d0f-437e-2699-08dd94604c87
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 09:59:08.1955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJvcnAWgGmRpNF3V278H859COumEIC+xDxH1TcMohwKKOzZ56IU1hOLUYIKanOe3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791
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



On 5/12/2025 12:11 PM, Samuel Zhang wrote:
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
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 20 ++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 27 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c  |  3 +++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 18 +++++++++++++++
>  5 files changed, 69 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 4e794d546b61..3dde57cd5b81 100644
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
> +	fb_base = adev->mmhub.funcs->get_fb_location(adev);
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
> index e1e658a97b36..14271f62ca8e 100644
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
> @@ -3976,6 +3999,8 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
>  	memcpy_toio(fw_pri_cpu_addr, usbc_pd_fw->data, usbc_pd_fw->size);
>  
>  	mutex_lock(&adev->psp.mutex);
> +	if (amdgpu_virt_xgmi_migrate_enabled(adev))
> +		fw_pri_mc_addr = amdgpu_bo_fb_aper_addr(fw_buf_bo);

Better to skip this, this command is not supported on VF.

>  	ret = psp_load_usbc_pd_fw(&adev->psp, fw_pri_mc_addr);
>  	mutex_unlock(&adev->psp.mutex);
>  
> @@ -4085,6 +4110,8 @@ static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject *kobj,
>  	memcpy_toio(fw_pri_cpu_addr, adev->psp.vbflash_tmp_buf, adev->psp.vbflash_image_size);
>  
>  	mutex_lock(&adev->psp.mutex);
> +	if (amdgpu_virt_xgmi_migrate_enabled(adev))
> +		fw_pri_mc_addr = amdgpu_bo_fb_aper_addr(fw_buf_bo);

Same as above - no VF support.

Thanks,
Lijo

>  	ret = psp_update_spirom(&adev->psp, fw_pri_mc_addr);
>  	mutex_unlock(&adev->psp.mutex);
>  
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

