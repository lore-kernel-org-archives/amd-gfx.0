Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B4EC7EE2A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 22:05:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2E2310E033;
	Fri, 27 Jun 2025 22:05:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0hLDj2Xw";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31A7010E033
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 22:05:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1Y1u7rWdfpTcnkoFg2bg7xuBwzBfb7w0oKoZJNoV+R8x6EOGoWU8pzfsCT6tEpN2RM6CHAcK6tuKmE6T63gw4joLRXtbxGrfsQ8O9I/2zR6bcQavYFLfqHpawMjV/+s5BoP2iY6IbBSMBse7FVc7xvM72RiA7q+2QdSGrNsfAdoblBQKkoagT9pejo4ucFZWWj+gC7yqM+bj0LTdU7L553/73YgdwBZyK8TMNfIPhvGhOcHdfKvkBh6PYEqe2AquuWhfZ83tXv33sUZdZmv767rWzMnpDi1EaHaFt4GbDvPiaa3ZKT5dqY5P3DAJrqTjiVhYeKyc9kkFBOmnsO0fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1wTNQ9+qZ+5aZh+oq6RPMmwoulapsN1f6FoJ+fvwPk=;
 b=PuiGRO2++vgnbuE49iZLubdHHj2yGvR9ekNJtAcYuLMLhwP9Q0AHFSNCXcNNAToVGJH9eXok6DQeSWPQvO6giHstwH+kA2GoEc0CM01Nqmf05QUEh3uRivq160y4+F+JTPD+tDJH+6AWPCsVuSrKzr+cZFbwzV328bQ3+6NCpOc0H1X48D++Q2efLY2u3hMVA5rQ9AyMzPlWiOy7gpIy3MU3PKtqLK39GqHEUlh/YAclB58mvzVvK+aO2N99C4ZCHyvZEGJxXTy4fslb9c4i4r9m0oAFzTZAcuYPW6W46zWcWAMKd9nA2RE8r3TPZrB8ds1oqLfbs+DkCfredLwnRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1wTNQ9+qZ+5aZh+oq6RPMmwoulapsN1f6FoJ+fvwPk=;
 b=0hLDj2XwUHHJ9jKf5QzAOzZzGiBFe9/inZxLHnuoW/2jEPblhDLvohsaf5HMe/8X9JUra5Qj/hlQGZfSL+kawjA1o35LUfypzwJ6yKoxzoWVO0tL9Rx3USQdQuPKFKd5h8RdaTMEKOCu6TFDT+fN+mJBrr9vNvXbUqfLusFGEiY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16)
 by SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Fri, 27 Jun
 2025 22:05:37 +0000
Received: from CY5PR12MB6429.namprd12.prod.outlook.com
 ([fe80::1b40:2f7f:a826:3fa0]) by CY5PR12MB6429.namprd12.prod.outlook.com
 ([fe80::1b40:2f7f:a826:3fa0%6]) with mapi id 15.20.8857.026; Fri, 27 Jun 2025
 22:05:37 +0000
Message-ID: <5c55228f-339b-4830-adf4-1012f4bf6316@amd.com>
Date: Fri, 27 Jun 2025 18:05:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/amdgpu: Add helper functions for isp buffers
Content-Language: en-GB
To: Mario Limonciello <mario.limonciello@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, christian.koenig@amd.com, mlimonci@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com, phil.jawich@amd.com
References: <20250627201736.696030-1-pratap.nirujogi@amd.com>
 <7424b281-4101-432b-a1b7-fe7226bb49fd@amd.com>
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <7424b281-4101-432b-a1b7-fe7226bb49fd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0298.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::17) To CY5PR12MB6429.namprd12.prod.outlook.com
 (2603:10b6:930:3b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6429:EE_|SJ0PR12MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aa1d7ab-bdc6-4fb5-6bc9-08ddb5c6bf32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXM1aVBoY1pzaUoxcTNVQzFvMURQUVU3SjFuNHVPdE1YblFkMmkrdERHa2FU?=
 =?utf-8?B?dFpCOFAvdVc1RG55Wk45eVFaMC9oRUEzVVFRSU14enAwUit3Ulk4Ykk4T2NK?=
 =?utf-8?B?a2hVK0ZseFN0cHlEbHRnaW1oZHdTKzcvb2FQSzV6SVI3VGhXajhSYXI1RGRn?=
 =?utf-8?B?bS9BWVpiNFhiREkzcVV6L1V1QkZ2bjBZTTdObW5ZdmlRWTZOSitIUnZXT2Nw?=
 =?utf-8?B?YmNZN05WUkVrU1hnNnBhakZwQXlnR1pZNERieWkybVJ0ZnVMOU9KZ2Z1a2tM?=
 =?utf-8?B?MW9pU2FtS25BeFIzN09CQk5HT0NmZnh5QmcrU1lDazNOWlpiOVlNanZRaTA1?=
 =?utf-8?B?Q2twdy9XRlB0ZnpGeEpnT3R6cksydTNTMHd4dWlFQUVqbmRkc2tya1d4MEhu?=
 =?utf-8?B?c2llc3dwd21PN05ZUHZTNmdHQ0NWUDROT0dmejlRWHh5Z1NrTE9pQ01tZFBO?=
 =?utf-8?B?eS9rb2Q5TmNJYVVmQjJuUUdUZzFBalgvb0xYSVc1UmpYWDZINlI0Zy9iT0dx?=
 =?utf-8?B?Q0hHUXIzZTZzeHdUeTE5TTgzcmk4RlBqU3lmT1JxcFplU2NVQkN0MnYycmhH?=
 =?utf-8?B?Zlowd0hjeXNwL0tEMnZVckxLeUE4WlVqYnR4YUpnZXhvQk1lNlNNZ2RTSjBW?=
 =?utf-8?B?UXNudHUwVkdSQWFYTk1WTnNQWC9OV3VoeUpTNk9BQ0tzYzB6ZDZYc3VtQ2RZ?=
 =?utf-8?B?MHF2NmEwSmEwR1JubmVSNDNheUI5NXlUeXVkbk82WWFuVnY4dENiSXJReW1J?=
 =?utf-8?B?WnBpSkZFd1VTZm9hTWxEeUFSbllyNEY2eXR6TzN1UTJWZEYvQ2pnZmtqVUI4?=
 =?utf-8?B?Smg3Y1h4QWNYcmY2WFh6TWZqYzBmSy9sM1UrZTRLc3lKQndvZ2dpMGlSWHgw?=
 =?utf-8?B?VHJFTU1RM0JDN0lNK3d3eHVqRVVnYlNLOEF4YU1IbnNoNzBpaHd0REc2a3lk?=
 =?utf-8?B?QTh4TlZFV3Q3bXhUbXBjUnJLTzlSRkx1dThPTW4zeS9WTEpHQmFyRUYzM0ZW?=
 =?utf-8?B?T0YzQXlXV0g1Yy91WGxkUjdWc2pOanYwaDF2bFkrZ0hqMURBT1NNNUpvbHUr?=
 =?utf-8?B?MENxRzhjZ2FVTDBBd00rVG9zc3BkZTVCbE53aE1odzNlUnhvRDdja0J6ZEZi?=
 =?utf-8?B?ZW5FNnV3NXgyRUV4VXlQdzdKVitaa2VRQXF3ejk0bUZvZVZmUjU5UkRBc0J3?=
 =?utf-8?B?bWI3dm1abll4SjJKNFZsSmJIaGhaRi9QakNYK2RLNEgzeFFsOWNNK3ZwZm9Q?=
 =?utf-8?B?ajE2NVdjYVZYc2Z0clZnOUNpRHpPcTR4TS9ieHlzdktFb3k2T2ZTV29TYTJy?=
 =?utf-8?B?dWhCUjZwN3Fqb3Z3ZHgrODRKTEhjMTh0NStnWE5lZlMzU1Z2RmZ1SVE1Yk1q?=
 =?utf-8?B?azQwbENjM0N1UHR1UTl3eFhyRldkSFYrUHFwMHZ2QUkzYlpSZFBqTXNpa2RY?=
 =?utf-8?B?MjhXVHk1T1I5VGM5VDZQYjl4cmdQczhJRWNrdERXVDdmSFYzRlo2L2JNdWU4?=
 =?utf-8?B?QlZZRVF4dW05VnExNkZRc1hTOVVaaUhxQXNmUTNLU2s2NkszZEVIenFNZVVy?=
 =?utf-8?B?N2lmcFNHN050VEtzNklVR1M5UUN6a0JsNjBMSmp4LytDMjg2KzJVR013eGN6?=
 =?utf-8?B?clRTR3owVUc0QjQ1a1NVUHpMMHpyd21rQUtMM1gxd3p0em1YWm54WmpiTFpP?=
 =?utf-8?B?UW9xTU05MFptcWNWbisxRjI1cTRMQkE1ZWlvd3lYS2sxK2Jwanl0VnVWMGRM?=
 =?utf-8?B?U1Q5NGN2a1F1UjZjUzI3WWRlc3c5dmlSRG14dm9wUXFSSER1OTRqM2FIbWNH?=
 =?utf-8?B?ZWcyVzE2aVhWaldqem5pbVl4M3dvMEgrRk9QbkU5OTRLL3NQSGplRi83WUQw?=
 =?utf-8?B?TEo0R1dPb1NMR0dJc1N5NStadVRITHorWGN5dWtzRjFESnhFanpHc0dSVnlr?=
 =?utf-8?Q?4+Bg78O/WXE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6429.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1c0UWdoQUluMXYybWZIcUpJeEJIb0VoOG5DOVp6LzVMTHFwRlJ2Z1lDU2s4?=
 =?utf-8?B?N244aTh5OWFGNFJEQmIvTVJuM0xRb2VzclFoc3JVRzhIOXBoVDg3NWxjemxX?=
 =?utf-8?B?SUxHTVhGWU5aTVVENjZ6blNpdk1xdFEwRG5aWUhmYWFmV3diV2s4THczRmJY?=
 =?utf-8?B?UXRoMkxtT1Rhd3diSytjbDNiY0pPS21EYUd6dVdncEM3RzBqRS92N0c3Z3BG?=
 =?utf-8?B?RDcrL0ZMNHBGQ0h2K0QvS3ZBSzhFMUROVDNqalArZnhkU09BRjM4OHY1UW4w?=
 =?utf-8?B?TmRBbFJ5R1lNSDRtNWtzV1VtTGRJWlM4RnZpMklEVTFsWExKcm9kYW9YaEZU?=
 =?utf-8?B?a01ZU1YvSForeWJQMjU4OFo3NlBEMUMzSVdLWVlXek9CNFRJdW5tdVlMY3N5?=
 =?utf-8?B?ZjhleTZJSEtxUm55ekJoUVIzdlpzdFkyQUJ1Q2hOcjVhRmJ5dWVyazhaME1x?=
 =?utf-8?B?SWdiUEpXZ2Y5ekFNQUhEcWljUDBxaUQvb2tWMVAzNFJ2U3VpbDV4MGNaV1Zm?=
 =?utf-8?B?QUltdURudi9pZ0FTK21oRVpmYmlFWm1yczdaRU5nYlM1d1JXeDEreEt0OEhK?=
 =?utf-8?B?ZVo0cjFEWW05YUJIbENlM2VnYWhLVzZRakxtaGlhZE02R2lRYnMyZFhBRDNS?=
 =?utf-8?B?cElQcXZndG12YkI0WXVsKzVPT2ErQUhZQzFwMWxPZlF0dlNCbGtpMUErK3Vu?=
 =?utf-8?B?UTBRbXZFUjdtRDM1eCsxTDRybFhJN0Qyd3NaUnZzNTIwakpLUHh1Q2xhZDNV?=
 =?utf-8?B?L0tEcE5uQ21FK0laRkFwZmRUWWxjaW9WVGJiNXpCUDYxdFJKeVZ3NzVEY1ZP?=
 =?utf-8?B?Wmk3ci9oSnp1b29SSlBSaG9KdXB5bld4WXp2UmdVWVV3MldsMjIrajJpRDF2?=
 =?utf-8?B?KytwRHNxdkpsTmJNamNjUml6aUlmOEZVcGRwZFhzdzNCYjZ3Tk9KSW1jNi9u?=
 =?utf-8?B?YStBQXdTZVpkdW8rZWpseEkybjNrVlNqd2MyQy9oU3NWNzZJNHRQdnQrZFdV?=
 =?utf-8?B?MW0rcDdWbVozVU13eS91bDZUemp1VThlb0ZKZUtqZDFHTlBCRnZzb20wbnhJ?=
 =?utf-8?B?N0hmbHJaQ0tCYmxVam0yMVAzUkFsMDVZS25GY0wrTXhKb3VQa3hLU2QvQ2wy?=
 =?utf-8?B?T0pEakZXUFl0MkQ5bmlVM3I1eTVSTmo4OUk0cFpDL1ZQVlB1SVJUTXZjUGc0?=
 =?utf-8?B?dlFyM0hNR1lVdzVOci9YQnp1ZjRLYjBhdEtNZmlSMEV1MEdGUnBhMjR1K3VP?=
 =?utf-8?B?TjRwZ29PZU1tWmhYblNCUkZyV3BCekladXBtV3JqcFQzcXF0ZzNKeldpdnpw?=
 =?utf-8?B?dmpqbmJwTFRMQkQ2OFlBYU1tVkJBaWwweTBUbHdPRkVKbDZNc1JJdmpWYzNp?=
 =?utf-8?B?RzNiaCtNR0FTQmF5TzBDWTJXdGRFN0JmRlVyK1VPR2tnRG5UZ2pKUWZNVktL?=
 =?utf-8?B?WUFJZWl3YmUrYXhRc0hWL1dyQUdVNDU2UW14VHNkTW5LZkltN3RtUUVlZDRK?=
 =?utf-8?B?cVptTzE0bGpCQ25KRTBqWVc2NDl6eUhEd3c4VGhuNmg4UHp6OGRQcHpvaTQz?=
 =?utf-8?B?SVFKS1pJOTJIMFMrMUIxdmRLZUtWb3J4cnlQQjA0VHc5ZHlnWnVtTUMrclhL?=
 =?utf-8?B?eHFCOFFBTmU4RWNla2NoN1B3bFBQSGlyamRLN1NnNUZ1MFpZQkpHL1ZBUlZ3?=
 =?utf-8?B?bHRYaXdick43OHFELyswbFplNlB6SmprUU9lb2xKTHMvRVdkdjI3Ris4aVlO?=
 =?utf-8?B?UC9uc1pXbGJKLzYwTGZmT0YzT0VrS0RqT0xqQnhiOXp1NDlkTm9KWHJPOFNP?=
 =?utf-8?B?L0VVMENGNFZMa054Z1RIU0k0NDZrVEEzT1g0WEFLUFpTQTJKYXV4bW9VMTJT?=
 =?utf-8?B?bGZJVExOcDM0TytNQnJSZVdaM0tRdExLd2hwbzBYMHIyMk05Unloc2NYWXFX?=
 =?utf-8?B?d0dsUFNXTE9YOVBOdU0yMi94SndDREFzYUZ2OGpmWTZ6aHBXbHl4UGJtWllk?=
 =?utf-8?B?MWtYL2l0REdvdDA5Sm1pcGlZQ2lySGFxMzIzbkhRSExzOHNJcmxsVDJLMjJO?=
 =?utf-8?B?VGZUbHAwNnY2WFlUVzN0bElXYjVvcWtFYWpjTm5TaFZIZEpadkhFUEtKQmJ6?=
 =?utf-8?Q?EXYxZGgRNSqoDbiATKA1s6mML?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa1d7ab-bdc6-4fb5-6bc9-08ddb5c6bf32
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6429.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 22:05:37.4344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wViZ5i56wC0bILrUsk9gNY8cex3hvqNJnJ0FGdnT6GNLFo1bnvHC9dH0H1HFcBBdcBWuuwhrvYtXcbMvDSFTEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8614
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

Hi Mario,

On 6/27/2025 4:27 PM, Mario Limonciello wrote:
> On 6/27/2025 3:17 PM, Pratap Nirujogi wrote:
>> Accessing amdgpu internal data structures "struct amdgpu_device"
>> and "struct amdgpu_bo" in ISP V4L2 driver to alloc/free GART
>> buffers is not recommended.
>>
>> Add new amdgpu_isp helper functions thats takes opaque params
>> from ISP V4L2 driver and calls the amdgpu internal functions
>> amdgpu_bo_create_isp_user() and amdgpu_bo_create_kernel() to
>> alloc/free GART buffers.
>>
>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c    | 73 ++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h    |  7 +--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  4 --
>>   drivers/gpu/drm/amd/amdgpu/isp.h           | 47 ++++++++++++++
>>   4 files changed, 121 insertions(+), 10 deletions(-)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/isp.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_isp.c
>> index 43fc941dfa57..1b776c966bf2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>> @@ -33,6 +33,8 @@
>>   #include "isp_v4_1_0.h"
>>   #include "isp_v4_1_1.h"
>> +#define ISP_MC_ADDR_ALIGN (1024 * 32)
>> +
>>   /**
>>    * isp_hw_init - start and test isp block
>>    *
>> @@ -141,6 +143,77 @@ static int isp_set_powergating_state(struct 
>> amdgpu_ip_block *ip_block,
>>       return 0;
>>   }
>> +int isp_user_buffer_alloc(struct device *dev, void *dmabuf,
>> +              void **buf_obj, u64 *buf_addr)
> 
> As these are exported symbols intended for use outside of amdgpu, I 
> think adding kernel doc explaining how they work and what the arguments 
> are is a good idea.
> 
> I recall you had some of this on the old exports.
> 
sure, will add the function headers as I did before for 
amdgpu_bo_create_isp_user() / amdgpu_bo_free_isp_user / etc.


>> +{
>> +    struct platform_device *ispdev = to_platform_device(dev);
>> +    struct mfd_cell *mfd_cell = &ispdev->mfd_cell[0];
> 
> What happens if a caller calls this function on a system without an ISP? 
>   Couldn't this be a NULL pointer deref?
> 
> So I think you need to catch the NULL ispdev case.
> 
yeah, I completely agree, its required to add the checks to ensure dev 
handle points to valid AMDGPU_ISP device. Will address this in the next 
v3 version.

>> +    const struct isp_platform_data *isp_pdata;
>> +    struct amdgpu_device *adev;
>> +    struct amdgpu_bo *bo;
>> +    u64 gpu_addr;
>> +    int ret;
>> +
>> +    isp_pdata = mfd_cell->platform_data;
>> +    adev = isp_pdata->adev;
>> +
>> +    ret = amdgpu_bo_create_isp_user(adev, dmabuf,
>> +                    AMDGPU_GEM_DOMAIN_GTT, &bo, &gpu_addr);
>> +    if (ret) {
>> +        drm_err(&adev->ddev, "failed to alloc gart user buffer (%d)", 
>> ret);
>> +        return ret;
>> +    }
>> +
>> +    *buf_obj = (void *)bo;
>> +    *buf_addr = gpu_addr;
> 
> As this is from an external caller I think you should either WARN_ON() 
> at the beginning of the function or guard:
> 
> if (buf_obj)
>      *buf_obj =
> if (buf_addr)
>      *buf_addr =
> 
thanks, will add the checks in the next v3.
>> +
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL(isp_user_buffer_alloc);
>> +
>> +void isp_user_buffer_free(void *buf_obj)
> 
> Same comment for kernel doc
> 
Ack.

>> +{
>> +    amdgpu_bo_free_isp_user(buf_obj);
>> +}
>> +EXPORT_SYMBOL(isp_user_buffer_free);
>> +
>> +int isp_kernel_buffer_alloc(struct device *dev, u64 size,
>> +                void **buf_obj, u64 *gpu_addr, void **cpu_addr)
> Same comment for kernel doc
Ack.
>> +{
>> +    struct platform_device *ispdev = to_platform_device(dev);
> Same comment for NULL ispdev
Ack.
>> +    struct amdgpu_bo **bo = (struct amdgpu_bo **)buf_obj;
>> +    struct mfd_cell *mfd_cell = &ispdev->mfd_cell[0];
>> +    const struct isp_platform_data *isp_pdata;
>> +    struct amdgpu_device *adev;
>> +    int ret;
>> +
>> +    isp_pdata = mfd_cell->platform_data;
>> +    adev = isp_pdata->adev;
>> +
>> +    ret = amdgpu_bo_create_kernel(adev,
>> +                      size,
>> +                      ISP_MC_ADDR_ALIGN,
>> +                      AMDGPU_GEM_DOMAIN_GTT,
>> +                      bo,
>> +                      gpu_addr,
>> +                      cpu_addr);
>> +    if (ret) {
>> +        drm_err(&adev->ddev, "failed to alloc gart kernel buffer 
>> (%d)", ret);
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL(isp_kernel_buffer_alloc);
>> +
>> +void isp_kernel_buffer_free(void **buf_obj, u64 *gpu_addr, void 
>> **cpu_addr)
> 
> Same comment for kernel doc
Ack.
> 
>> +{
>> +    struct amdgpu_bo **bo = (struct amdgpu_bo **)buf_obj;
>> +
>> +    amdgpu_bo_free_kernel(bo, gpu_addr, cpu_addr);
>> +}
>> +EXPORT_SYMBOL(isp_kernel_buffer_free);
>> +
>>   static const struct amd_ip_funcs isp_ip_funcs = {
>>       .name = "isp_ip",
>>       .early_init = isp_early_init,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_isp.h
>> index 1d1c4b1ec7e7..cf26d283469e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
>> @@ -29,17 +29,12 @@
>>   #define __AMDGPU_ISP_H__
>>   #include <linux/pm_domain.h>
>> +#include "isp.h"
>>   #define ISP_REGS_OFFSET_END 0x629A4
>>   struct amdgpu_isp;
>> -struct isp_platform_data {
>> -    void *adev;
>> -    u32 asic_type;
>> -    resource_size_t base_rmmio_size;
>> -};
>> -
>>   struct isp_funcs {
>>       int (*hw_init)(struct amdgpu_isp *isp);
>>       int (*hw_fini)(struct amdgpu_isp *isp);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_object.c
>> index c5fda18967c8..122a88294883 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -352,7 +352,6 @@ int amdgpu_bo_create_kernel(struct amdgpu_device 
>> *adev,
>>       return 0;
>>   }
>> -EXPORT_SYMBOL(amdgpu_bo_create_kernel);
>>   /**
>>    * amdgpu_bo_create_isp_user - create user BO for isp
>> @@ -421,7 +420,6 @@ int amdgpu_bo_create_isp_user(struct amdgpu_device 
>> *adev,
>>       return r;
>>   }
>> -EXPORT_SYMBOL(amdgpu_bo_create_isp_user);
>>   /**
>>    * amdgpu_bo_create_kernel_at - create BO for kernel use at specific 
>> location
>> @@ -525,7 +523,6 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, 
>> u64 *gpu_addr,
>>       if (cpu_addr)
>>           *cpu_addr = NULL;
>>   }
>> -EXPORT_SYMBOL(amdgpu_bo_free_kernel);
>>   /**
>>    * amdgpu_bo_free_isp_user - free BO for isp use
>> @@ -548,7 +545,6 @@ void amdgpu_bo_free_isp_user(struct amdgpu_bo *bo)
>>       }
>>       amdgpu_bo_unref(&bo);
>>   }
>> -EXPORT_SYMBOL(amdgpu_bo_free_isp_user);
>>   /* Validate bo size is bit bigger than the request domain */
>>   static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp.h b/drivers/gpu/drm/amd/ 
>> amdgpu/isp.h
>> new file mode 100644
>> index 000000000000..6c8214ea28e1
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/isp.h
> 
> I don't believe this is right location for this header.  It needs to be 
> included by drivers outside of drm doesn't it?
> 
> So I think it should be in one of these locations:
> include/drm/amd_isp.h
> include/drm/amd/isp.h
yes, this file isp.h is included in the ISP V4L2 drivers, will take care 
of moving to include/drm/amd/isp.h in the next version.

Thanks,
Pratap

> 
>> @@ -0,0 +1,47 @@
>> +/* SPDX-License-Identifier: MIT */
>> +/*
>> + * Copyright (C) 2025 Advanced Micro Devices, Inc. All rights reserved.
>> + * All Rights Reserved.
>> + *
>> + * Permission is hereby granted, free of charge, to any person 
>> obtaining a
>> + * copy of this software and associated documentation files (the
>> + * "Software"), to deal in the Software without restriction, including
>> + * without limitation the rights to use, copy, modify, merge, publish,
>> + * distribute, sub license, and/or sell copies of the Software, and to
>> + * permit persons to whom the Software is furnished to do so, subject to
>> + * the following conditions:
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT 
>> SHALL
>> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR 
>> ANY CLAIM,
>> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
>> OR THE
>> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + * The above copyright notice and this permission notice (including the
>> + * next paragraph) shall be included in all copies or substantial 
>> portions
>> + * of the Software.
>> + *
>> + */
>> +
>> +#ifndef __ISP_H__
>> +#define __ISP_H__
>> +
>> +struct isp_platform_data {
>> +    void *adev;
>> +    u32 asic_type;
>> +    resource_size_t base_rmmio_size;
>> +};
>> +
>> +int isp_user_buffer_alloc(struct device *dev, void *dmabuf,
>> +              void **buf_obj, u64 *buf_addr);
>> +
>> +void isp_user_buffer_free(void *buf_obj);
>> +
>> +int isp_kernel_buffer_alloc(struct device *dev, u64 size,
>> +                void **buf_obj, u64 *gpu_addr, void **cpu_addr);
>> +
>> +void isp_kernel_buffer_free(void **buf_obj, u64 *gpu_addr, void 
>> **cpu_addr);
>> +
>> +#endif
> 

