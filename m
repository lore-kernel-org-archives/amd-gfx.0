Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF7FC02194
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 14:51:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2B7610E27D;
	Fri,  7 Feb 2025 14:51:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZG0NVA8/";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AE8410EB31
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 14:50:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXscKc/JVkBZLrAvQZ9ERIXoDnhGoBZlP42Jz01ogNOS+oFNgFL6BP48+VMDqpue0sfQzr7Yyzmv28YnSciuUEvcW5E4oUeepSDTTNqSs/dmh33RG92c7AEL/AVeNDdYWuSbGW77Y/U7fTfjSddo2BzJHJIPh6K9MwK4+VxU55t8JKW+AWoogNU9E2+47WdkTEW07vAkAay0hirmrAv266jDNIiAeAPy8bjUhwIZgdLAGW6K+hzTl/oEHiR/2jl+GyuJ0c8twPBNkyqTn2dZJzqP7x3ZUrR8eF0jKWKSbjxBzGHt3bXlYBFd3xKRQQnnUaGDQZVOuxQIK1akmo5A2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMydrZ9G85ijztxBizvQNamxvvWyOowE19UGoM8rffs=;
 b=mhKBqyHQmial+5w7ehVw4I9oaEwaFco6mLwzszoTIRRyP3ughfZkRQs5xWAILHgSsUpNtK4JDZuSDQnBhT9syerAIua7Pl/MUCXbXeGeYhHTLYR2Gxkv+IKmGnUA3aT/pTT8Kh3SMX0wOP3UWFDnu365i4yBVj2LWGYHxwuZ2Jx1I+EH/kHoR6Ne4J4Ks1GCXG+9MmXnwZC7MGG4hsI97w6raQUuVh5Jb14sjecsV2+R0kfhpIAxknnNEmbHTBxFBlBMlTEquQ9wOFaV/EA5CYfofPy1LHAhG/nAEeFPTM2ECWWhoRcDl//CaQvYjm00d58fPcG/yT47Rqffa1u+LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMydrZ9G85ijztxBizvQNamxvvWyOowE19UGoM8rffs=;
 b=ZG0NVA8/c5PptDh/FwW/Aj/zHD0yA11Bx6KS0zGzMosOGr1ixpCdEJZr25e64n2BSWl0QCsPhkiYtTQ7HSo7hr6j3KC1vG+v6rt8cWOJqbDa1aB8LN2Ze1D8AtaPvot5RQOFOLeFfdWAXrBNfm713z+p9PbqqBWJ71HNKjeWjdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7364.namprd12.prod.outlook.com (2603:10b6:930:50::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 14:50:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 14:50:49 +0000
Message-ID: <2ca96297-db0f-4683-a46f-9621ea4bd60c@amd.com>
Date: Fri, 7 Feb 2025 15:50:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] drm/amdgpu/mes: Add cleaner shader fence address
 handling in MES for GFX11
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 lin cao <lin.cao@amd.com>, Jingwen Chen <Jingwen.Chen2@amd.com>,
 Shaoyun Liu <shaoyun.liu@amd.com>
References: <20250207144352.920100-1-alexander.deucher@amd.com>
 <20250207144352.920100-2-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250207144352.920100-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: fe615b04-fcd9-470c-84ee-08dd4786cfbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amlWRkttTlk1ZitFR3g4eUxEVWYrSUJXOTJpam9SUU1kMXc0a09EcFVVQjEz?=
 =?utf-8?B?R2tNSTNhUUl5RGVDQUE4Q2hLTmpYNjJUd01qQXl2ZnpDbWx4clBSM3ZkVCtE?=
 =?utf-8?B?cjN4TnZkN01aN3BocmtKN1lWOFlhQlU5R0VpcDh4UXBTYVlRVXpEdVhyREho?=
 =?utf-8?B?dG1Ta08zVGNackp4dzhuSVlPcnZMWjRpZzlDbG9vbnRGTURxNHk4WE5ZSk8z?=
 =?utf-8?B?bHNXYjlJS3RzeHJNOWx6YWhWZHROMlFmdjJBOWhYdHVBMHJtZHdjN05FaUNN?=
 =?utf-8?B?a1U4L1ovZ3FKeTZpYVNUeVA4NmNIRFV6NG1vUm1LNnhVYkhKak5RbC9seCs0?=
 =?utf-8?B?UysxQzZpQWxTcnZ5T3hoUFEvbUg2UXpkOGRxcDVGSS84Y2p0YmhzeFR0YUx5?=
 =?utf-8?B?T1lIZDNHK05PM2lVT2c2MFJsRmh3SU5MVllXMGpVSGMrbnVZVm5hR1J4LzBv?=
 =?utf-8?B?SU45d1ltRlllTDV5eVh2TlZnUm0xSHZvR3J5eDYyelRRR3g5cW1ETkFnWXR0?=
 =?utf-8?B?c3QwM3dnNFBzaXpVcXN3aFhxcFZyUmZLcWM3UHhUdzY5RmFjaWplQWEwSjVz?=
 =?utf-8?B?WjdSazMvOXQ2aU05WlcvVldxckc0RnpKS2NlTDVCZEY4YkdTSS9Na1ZYL2lW?=
 =?utf-8?B?dGhuUVFHRHdRSmhXYnNkeks1SUxDVXVWeExCcy9VdnNsaE02cWtzRlpTcW9I?=
 =?utf-8?B?anErK28vcXV2STRiMWd5WXVnZTdMY0lyRkhDOE9pNk9lQXpaSWpkWUdNZHhV?=
 =?utf-8?B?MFIxZDZRUWpkSGg0aGUwdHFucnJTbkg5a1dtbXc4TGNFNEdPRUVmdThyY3VG?=
 =?utf-8?B?Qng3UU5qb3JheG5QVUpOWGVxcXlVaU9xV1RzKzFvR2VqOHVXMG16blNnVXRh?=
 =?utf-8?B?bWREakpnZXZtL1BFajE5dGYydE5tRnlIaFF3czAvZmZINVEyWktGWlhYNGxY?=
 =?utf-8?B?YUdlWWc3UmNHbDlkblBaOGFxbUxCVmhsOUM2c0VBQnJ1MWhnOGFiUEFISFNz?=
 =?utf-8?B?RDlzZWFJc0hlR2h0WFpLNVlzMEdkck9Lem1adkMveHd5Y1dQSk42bkNtaXM0?=
 =?utf-8?B?ZlU0RXI1a3FzVzJNNk45MHZQQnQ0WVI5UEtleFhtY2dlVVo2RWJrQ05wTjR2?=
 =?utf-8?B?bEJDdzVQcFZ3eE43Z1lSOTBpNG4yRDl4NG1VZDlzUThWTndWZmJVVXlJUWZl?=
 =?utf-8?B?WmRUZ2k5WE5VUVY0cTVSYllkdEVraU11dHl4Sjc2bDlXbmFTLzA4OXVCR2JY?=
 =?utf-8?B?alJEYjZNUHBMYzM5eVVacEhBQWZpQ0FudkxGc2pvQ3ROSmIxdWc2d09OQmZ4?=
 =?utf-8?B?VmFITXg3ZFUwa2RqTzVLSy85UXhkQnBlRnJDcnJaMXFiR2NyR3h5OGpUbG9N?=
 =?utf-8?B?eDhmYld2SmRZUFhWYXZRNVp6TS90RE5WcWJiOWVXTlcyVlN2S0JMVlVEei9C?=
 =?utf-8?B?Ly9wdXh2eElRVFdZYmxCVG9mL214VVNwZ1YvQ2JQOFlPYTVkcjlrUXdXZjlR?=
 =?utf-8?B?ZHNxUHRQVDcrVkIrbHkwM2pXcUI4TFU4SmplQnB1QzBLQ3RXVVcyc2ZGa3VQ?=
 =?utf-8?B?NFd4WDlUOU5ob3BnZEdTRDdxRHIwSkRiRElEbUZ6TjZZMUFCVGI2ckZCWmpi?=
 =?utf-8?B?bUE5MzVoZUtSZWJmOEJpRTlHZURnWThpZHlCT0FIU1NobnY4RGpkNUh1bTdV?=
 =?utf-8?B?cklNRnk2Nmk1andQYU10Z1NZR1FnVzhXWjNZSVhtcVVwWno5b3pGU2Q2RXk3?=
 =?utf-8?B?aDkwYTRiZFJPZU9BbTVnaTRoNWc4OHdOQ3U2QS9IWVg5L0VrLzM2T2FiQ09R?=
 =?utf-8?B?ZEdzaFh2bUFLL0d4elVJRzh5NDlUaURaTVo2ZkN5OUxZWmMwL3VJaE5tamdn?=
 =?utf-8?Q?bFDYa8pMuS6rd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHFqQWRFWkM3OXdrcFI1RUE2Wkt2N0krOVdkVUptcWptcWw2Vm5wd0JaRkhF?=
 =?utf-8?B?K2cvYm9wL1lvMXY5L0tjWmMrQU5FY2ljYUd4RmJQbU0xSXZVWWJIUkVJSk1w?=
 =?utf-8?B?RmxBVEdZZGdJRTVDVUJhNWRXSnFNWGw2c2ZyTloxM0hvYVNWM3dlb080cFd2?=
 =?utf-8?B?ckNyRThyb3VaZ0hzZUYyakMraVhsUlQvYTNGdWtDT3MwUmFpMVBzVWRhenY2?=
 =?utf-8?B?ZTlqSHB4cFJ1czJVczQxYm50bXA5aWFNdTdiU3BETmY3MWZNa3lWN3NZUnhF?=
 =?utf-8?B?Sk9LZnhHWkVsNUIvNy9yZ3NKYkw5VisvWVJ5SDRTRGFmMEdnOHIxRmVSdkpx?=
 =?utf-8?B?b1NTeVlyT1ZQcTRJQ3lycE91bnRWaTE0U0RRbVJtNm9xbVF5MWMyS21Qb295?=
 =?utf-8?B?dlBYVm1Xd1JoNDdNcTFqdTYxajhvK25NYzVoWHZTN01yMGo0ekYxcWFUcWpy?=
 =?utf-8?B?N0ttb2NOcGptNFByUnBzUXVqOUtqSkhqTUFzK0RkcFBlampOK2VTcFpwOU9u?=
 =?utf-8?B?TlIvaDU0UHh0OVo3NGNEcEgyN1VEUjl2UHdIMnRrWlp3NFNMQzFLa3dnN2w5?=
 =?utf-8?B?WVBvNHRKYjZkQmVNdzBwVy9vOXdHL3NTZXQ4anFLeFBpVlZzNWdXSUxvVTdP?=
 =?utf-8?B?am9lZndoNTU1a0wwRnVNNGFOVDFOaDZIWUZudlVLWUdaUHFyTnNaR3dpaG5J?=
 =?utf-8?B?Vyt3S2pIZS9IMTN3NllwVmw4V0V5dkdjSWg2cGlaY2llSlUybGxKci9VWjlX?=
 =?utf-8?B?MnVLaGk5SW83RmxIYW94TmYrbzU2TTRwaG9COEN4M29SbWhSTUJQeXJNRWNv?=
 =?utf-8?B?U2kzSVlVS1YrRVk3eGlzWFVCTzZmVGgybnJhNDB6dEZHcVhJVlphaUxhcFRa?=
 =?utf-8?B?dFJhZkNhVzhUS0VSS2RIS3BXZ2ZUNFV1TEdZZkVidVpIdnIwVUcrR2cwYlA2?=
 =?utf-8?B?WndiZUg4R2NGaHArZFEwV3FrV2NYYW5iVDZKTGczRzduS2cvTExwSkxiZHN2?=
 =?utf-8?B?WWhldUxWMDM4Tnp4YW9uQUlqekd1WWhOcmVuMXNnM3BJdjB4c1haVGFSRFI3?=
 =?utf-8?B?encraDFGSko2U2lhWTFrVy96TW1tVC9uMEVCb2k2MXUrU2NFYUNXZ3hKLzFK?=
 =?utf-8?B?MzR0N1VBcDFPaUI5OTB6MG1MRzhFa0NTT3UwL2ZSdVNhZm5CQmRTVTlqdjho?=
 =?utf-8?B?UzgvSkNUc0NYd1ZadE80eEVZeFcydFdTUVcvbHgyZDFsUnM2WFJ6REk1MTB3?=
 =?utf-8?B?QldpNmhXSjY5Q01UcXIzMnhWNEVoZlF2aWNkUlVKWTJlNVJ5cGpWcVNBRHp1?=
 =?utf-8?B?N0ROMEEzblMwTXZzUTJOOHByd1hWSk05WVJ5ekdQcm9vV1I5MHlZTHJDaUV2?=
 =?utf-8?B?aWZseVhGMjE2Z2Qxa0VsS0V2VTdXaVRmR3lCV0pzMk53N2k0SkdIdmFHKzFC?=
 =?utf-8?B?YVlWTU0xNWRvSU5pNEllcVBCT2RaVGtScTRWWDc0QlpxVmJIWDludEsyb3Ux?=
 =?utf-8?B?NmRSQXQ0Wlh1UlZKTU5Hamt0V3lGNk01SkROUXlDVjFXOEk2UGFzVWF5VnVO?=
 =?utf-8?B?Tyt5YXZ3aEloRXBTUTJaZmt5V2c4dTRpaW8xRXVkalBlbWUwRVZ1d1V5L3Bt?=
 =?utf-8?B?RisrUVRQKzRFaVRJWXRmTVMrYytHNW9qUmtJUnBISC82NGE1UC9ROFAvM0xj?=
 =?utf-8?B?T1RhWVY5bTc0OWZQM3FrKzhzcGRKMlZFMDJ5MWRtSVZWUW5HcU4zbFB2eGJn?=
 =?utf-8?B?ZGJhUTR0SzlId2UvU2hWU1VkU2FlaFRCMUhmUVNobTdJYjhIRHVoWkJMdlVm?=
 =?utf-8?B?TFhtYnJaY01vRlRodnloT1orclJIVS8ySGpLakRWcTNXVHQ0cnlmSVdSRkhN?=
 =?utf-8?B?dkV4SkRIUHBodHBTYk5McVdSOGN4Z1AvTDhaYjNMU2JabmF2emF1cCtYSWpU?=
 =?utf-8?B?VkFjME0vZUVzQjQ4T3RRYml0ZUJlQ3kvMDRVSFdsNkplZC9OTTQwcXJXdkla?=
 =?utf-8?B?QUNtWXRXdUk1QURlS3dmNWprSzIxVWQ4bzlXSnFqU1lER2dnaTVHaHNUblM3?=
 =?utf-8?B?VE9ZUDRzQXBFYllRVDUvaTVWVkZFOGFOb0p0YWFEaVJWN3lnWGdmUEIvdDJn?=
 =?utf-8?Q?E5hz7vBxMjkzBylSiZiLBYAmI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe615b04-fcd9-470c-84ee-08dd4786cfbc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 14:50:49.7749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffP19m2IhRiuGoDO+Mjw4l6LUryofxx2q7MopBay28AF40SFdKLG/pn+bHnMz332
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7364
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

Am 07.02.25 um 15:43 schrieb Alex Deucher:
> From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>
> This commit introduces enhancements to the handling of the cleaner
> shader fence in the AMDGPU MES driver:
>
> - The MES (Microcode Execution Scheduler) now sends a PM4 packet to the
>    KIQ (Kernel Interface Queue) to request the cleaner shader, ensuring
>    that requests are handled in a controlled manner and avoiding the
>    race conditions.
> - The CP (Compute Processor) firmware has been updated to use a private
>    bus for accessing specific registers, avoiding unnecessary operations
>    that could lead to issues in VF (Virtual Function) mode.
> - The cleaner shader fence memory address is now set correctly in the
>    `mes_set_hw_res_pkt` structure, allowing for proper synchronization of
>    the cleaner shader execution. This is done by calculating the address
>    using the write-back memory base address and the cleaner fence offset.
>
> Cc: lin cao <lin.cao@amd.com>
> Cc: Jingwen Chen <Jingwen.Chen2@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Yeah that makes much more sense.

I'm really wondering why the MES hasn't allocated that in it's own 
memory in the first place?

Does the MES expect the kernel driver to wait for that fence value?

Anyway Reviewed-by: Christian König <christian.koenig@amd.com> for now.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index e862a3febe2b2..e22d0ee6d8a3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -754,7 +754,7 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
>   	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
>   	mes_set_hw_res_pkt.enable_mes_info_ctx = 1;
>   
> -	ret = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> +	ret = amdgpu_bo_create_kernel(adev, size + AMDGPU_GPU_PAGE_SIZE, PAGE_SIZE,
>   				AMDGPU_GEM_DOMAIN_VRAM,
>   				&mes->resource_1,
>   				&mes->resource_1_gpu_addr,
> @@ -765,7 +765,10 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
>   	}
>   
>   	mes_set_hw_res_pkt.mes_info_ctx_mc_addr = mes->resource_1_gpu_addr;
> -	mes_set_hw_res_pkt.mes_info_ctx_size = mes->resource_1->tbo.base.size;
> +	mes_set_hw_res_pkt.mes_info_ctx_size = size;
> +	mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr =
> +		mes->resource_1_gpu_addr + size;
> +
>   	return mes_v11_0_submit_pkt_and_poll_completion(mes,
>   			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
>   			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
> @@ -1632,12 +1635,10 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		goto failure;
>   
> -	if (amdgpu_sriov_is_mes_info_enable(adev)) {
> -		r = mes_v11_0_set_hw_resources_1(&adev->mes);
> -		if (r) {
> -			DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=%d\n", r);
> -			goto failure;
> -		}
> +	r = mes_v11_0_set_hw_resources_1(&adev->mes);
> +	if (r) {
> +		DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=%d\n", r);
> +		goto failure;
>   	}
>   
>   	r = mes_v11_0_query_sched_status(&adev->mes);
> @@ -1665,10 +1666,9 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
>   static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	if (amdgpu_sriov_is_mes_info_enable(adev)) {
> -		amdgpu_bo_free_kernel(&adev->mes.resource_1, &adev->mes.resource_1_gpu_addr,
> -					&adev->mes.resource_1_addr);
> -	}
> +
> +	amdgpu_bo_free_kernel(&adev->mes.resource_1, &adev->mes.resource_1_gpu_addr,
> +			      &adev->mes.resource_1_addr);
>   	return 0;
>   }
>   

