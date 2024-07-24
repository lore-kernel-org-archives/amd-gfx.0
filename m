Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A54C3DA61
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jul 2024 19:18:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EBDA10E135;
	Wed, 24 Jul 2024 19:18:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NhqDLDzf";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECE4B10E135
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 19:18:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sM2nMOVrYb3PaJiwPfxeFKD3k2N9YeQga5ChbAuFyWUQ88gzzZnhFrJaANkI8ENeWk2KkcGa1ftChXjfDh7jJL8kWEeqEfEyL8h3HlzucXKxpSzvCY11qYrfTCbrPqCesgsZnft9TScZQlxPvbg2EUXpKDOJ/r9Yu3gq3D518GQpAADAKl9dWWyF/RDXpPd4rp35sSDbp241IDSa1e1r4CfEDyvqDnvoNaxS0nUd2w9A42H9iwumnA1s4priQP09If8stVlLQZ+RrWravfxEDbNAbsO7kQ5KbIDcV4iyg5Dv8obhO9D0UK7mYwepFXQ1ynvx0yyX/MFGBWS/AiEUpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiw29Qd/4E7x7WKu8IKsgb3J9RJdDwUNc+cwQ9rsJfc=;
 b=cpwMvBNWRuoZjgM+Dmf2dznXaPSbUkACGdFL7/9xB/XEp7GARXFfmJk0r3s1eRfMJE+oDs2eM/rAVHIm/xHfWpJ6mfwvhYEO2vp38Io/g2rVkmTZFMQjgz/cs2QW0Cdx35YXmyRh6gtGqRbE+AdsRzzobDgzPhlAzl2EQAGUNj9UKEsy2zJTDGI4QM29x8rI0Ysq1ggjjnhzV0Y9YbFUKZlhATU04S2I1dqBA95V0/HtZBnP/QK4AUm/R7yGd5Vjl8tXNN+hZMj8kXJDbvvSv2g8Zy0k+j1TdS0Xx7MPp+c668AIeNGBIq91cKL03W4odnbPdcHe8jt5cTLTsKE6wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiw29Qd/4E7x7WKu8IKsgb3J9RJdDwUNc+cwQ9rsJfc=;
 b=NhqDLDzf5HAVUginbDPxUKcDcPaaKSCPJpmtJb3zu023ArofFH3goYiuaUc0JQWwl83SNL7ASiOi93gGU0mTTQv2CNUzzfrW9FcKnkGODGSnfy8CLkzvwtacg+uzfcmu9B+lwJ3jP3KqDI3jBzkSHDpDyqM2Jg+ITJbRuwW+VtY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Wed, 24 Jul
 2024 19:18:30 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 19:18:30 +0000
Message-ID: <d9a634e2-5a38-4751-bcc0-25276c4cc073@amd.com>
Date: Wed, 24 Jul 2024 15:18:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Change kfd/svm page fault drain handling
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip.Yang@amd.com
References: <20240719221738.26840-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240719221738.26840-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0352.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL1PR12MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 0656b158-c7e5-4cd9-08ca-08dcac1566dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anA2Z3laelNPMGJoMjJweW9rMFA5clJaWk1qR1F2WFBubzM5OXdOQ2RhV3Rj?=
 =?utf-8?B?ZUI5VE1mTEtkVGlmU2V4ZWJjVmV6QTlnaFhUam9Dbk0xSitRK1BLdTJqWEpa?=
 =?utf-8?B?QXhUekUyZ2VnZnZEMUc1SVdWRWxYdmJUMlh1dFArT3pVZHMzVkFESHRGUmNG?=
 =?utf-8?B?RHoyU2wrR2ZxWFBqa2hXRVBCWlhsSUEwYW1EWnUzYWwzQVBzUk1yOUJNamFB?=
 =?utf-8?B?WjJIbCtub2VBeGlrSnlHQnFzZmZ1cVIwd3VkZVpZUElVWTBxdHFqZ0JMc29q?=
 =?utf-8?B?alZjblhQZ29kZjN1LzNxOEk5RUVaK25kVnVTbElrMlNBcWQ3cW9wVzV2dlgz?=
 =?utf-8?B?bHZOWEZGQ0M0YnJMK204VjF4Q3F0ZUptaHRicGRVOTZseXJTVnZYNmg1ZjZS?=
 =?utf-8?B?K2wrU2ZWV3J3OE5WT0F5Zlk0dnhSZmIxR3h5Q1hoWTUrT1F1U25xV1Bjd1Fa?=
 =?utf-8?B?YldQMUpDVXpydHJNLzB3WU5PQ2grcUhDelFyN3A4Z0NyQkNHMHpaUWpEejZF?=
 =?utf-8?B?TDFJd3dXeC9jL3ZzQ0hWbTBWbnJZcmd3UnA0aE5VV1VHTmdybGVTUnk0bWRN?=
 =?utf-8?B?ZzZRWm0xVzFYREtmZHVhQVUweDZ6VXFzcHRxZUliOVNjQU9MYVJVY0IrNThw?=
 =?utf-8?B?a2xXOGo5aHlJcFhKU1p0bmhUNXZrOVlsS2d5Q0ExUU85U0Rxc3lvVWVZZmFS?=
 =?utf-8?B?QUJjd016Ry9jTndqVitYeFdFUVlTeDh0MVhIRTkwVXJRSUFhM252aFV0YkFj?=
 =?utf-8?B?dzNhMVpFM1Y0VmZwcnMrVGVWSmU5eWRrbHEzSlgzNmc4bmRWbGhHMTVhaTNj?=
 =?utf-8?B?NkpudGg3M1E3dC84bXJGYTk3aXpjdEwxamUzMEVHbmJ1aXUrbVRLYWNjWmIx?=
 =?utf-8?B?VkZobmNSYmFkQUdpSWFOZlBtak9Sb1B1dC9WUUlXN1lielNnOTd3RmxiZ29O?=
 =?utf-8?B?UVNsN1N5NFFPRjFtUHlhdklWbnF2RTliK3pHclorZ0VkVXNuTUNmNHphb1dT?=
 =?utf-8?B?KzFCRlQxakk4M013NUZKNWFxZFpKRzVwTVFKRWMzakpKNHp5NVpqWUhvcVdH?=
 =?utf-8?B?ZUdOekVsN2xLQ2tkVnZMZUI0ZmlPS1dwUXVkMUw0VTVqbDdRQ2FrTmFLUEJH?=
 =?utf-8?B?YVd0Q21vZWQ5b2ZQVlBubU16N0VPRVZuVy85UDQ3T2JGVmhMSC9kYUQ1eTda?=
 =?utf-8?B?cFpQdWFWcUtLN2ZualpXM1Z1dCtsN0ZxMWI5VDhoZE5pM2FTN2FWUGNNZ3RP?=
 =?utf-8?B?NnJTY3VOR3NXUFVYZk42MFg0emIzb0tVMlRUdUN0cVRON3pLYU9tTmJ0ZzZZ?=
 =?utf-8?B?YXkyUURCT3hxOVB0S2Rjem0rWnRMWW9ZNDJnS3RCTjd2R2tMYSs2SThVTDI5?=
 =?utf-8?B?c3Rta0w2UWdOai9UK2Z5eEkraEpxSHBFc2EwSklXekVIOWt0cnpqek8rUHNC?=
 =?utf-8?B?MnZaZGRBMVBEZlo0UklYOUxwQVZoeHVhLy9La0pubXNSRjVqalNnWEdJZmtE?=
 =?utf-8?B?VnlVUDRYUTdOcWNwOWpGeGlscTY2dmo4WFVsa2ZkUDVwTVpweUhTUjNwZjlE?=
 =?utf-8?B?bzBiUGJUQkhERXFNUVdISzFBaU9pb0pITmd3V1cvaERDdEoxaWduZmlxSVBy?=
 =?utf-8?B?bi91bDNSNkl2Y1ptaDNBT2ZYaGtPODFGaEg1cDYxRHBZbnFCb2hFaGhaVVVG?=
 =?utf-8?B?VEp0SmtyY3NlaVBWa0hqTGZhRW5mSXVFTUQ1dHVXWkE4c1NuajFhempMdFB5?=
 =?utf-8?B?YzlnVmw1ZWFkV0Fjenpxb0xVUUZGSVZpbFdvVCtIUmJWQndaWnFXTjljQkw1?=
 =?utf-8?B?bmRZWmdVY0xzRjd3d2RaZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWVqSHFPMjB2Qk5heGJnN2FtWGpmZDA2Vk5BbFc5b1JmWGRiTVpLTWVKZUky?=
 =?utf-8?B?cmpyN1ByR1E2b2JzZmZKMm4rK1h5ZVQ5Zk1heDNkSWp6VkhkMmNKR3NoNVhC?=
 =?utf-8?B?T2lIZit2ckJFR3JPN0xBRTRxbW16a25DaXRoUXdXdnBrQ1U2MllEUVJnclFy?=
 =?utf-8?B?N0Ntc1ROcVY4dGJ3NzN0OVFLTWM1dWNmNDluSVNKSnA3M0pVa3RGamZLRCtr?=
 =?utf-8?B?TUdmQ2wwY1JmbTcrRlY1TmdSRzFXeWU4VUdaamw2MldYWXJ2ejMvNWwwejhS?=
 =?utf-8?B?YTRtK2VTRHoybVN5MVdLLy9ySHpGbTd4R3oyUElFVUJBRGY1a0VJdXVlMmJJ?=
 =?utf-8?B?cll6UW5ibU5oZHFCbUUyMUtlK0g4NDQxaHh2VHkrMnkyRmlyRVMrcXVtQzZl?=
 =?utf-8?B?NUFDcG9tWUtIOW41eS9yVGd2K0tvTWNBbTdrY0QzTFRKQzZOTDdlSnhJdkpE?=
 =?utf-8?B?NzlZaFovaUVuS05DWU41TXFPMlFJRDFoTXJ6Tk94K3pLeXVRK3dsWDF1VnNX?=
 =?utf-8?B?REZqdVhGQWU5ZkhzSXJnWnZOSXdjcHJFb3JjKzQyYjJRbHZtakFYZzZyeU9X?=
 =?utf-8?B?Q05mV1JndDFEK00rUXVFTUxGZkFDZy81UEt1d1JTRkM0SldPVWJsZ1AvNEJ6?=
 =?utf-8?B?TFBvNTZlOURpQkpHZU8ycllqeGlIZVNIeGNYR1lWbFlHWHBMRnpFSWpsSVZj?=
 =?utf-8?B?Sm4wZnRIQm5vZXZFWVpSTkh0dzRORWx6WEVvM0Z1N1packhKNnRGYUJaL0RP?=
 =?utf-8?B?YnVqc1Nlc1J2WG1uaTY3cW5weEtCVEFKRVl2dmlxU2IwcC9sdktXUmV3eHlu?=
 =?utf-8?B?cmtzSzN6RGpDUWY2cU9YTXJPbW5YRGEyOUFDUW9UbXlVbjlCamQ0MjM4K0JN?=
 =?utf-8?B?c2RJcDNYZEkyWEsxdmluN0VDZEo5ZjlSVVFuZERRcDlSdVowOG9jbkJ5dDVE?=
 =?utf-8?B?NHZ2SmJ6OGRiVUZyZlAvRFQ5bm1xWW9CSDVtYm1pc3VDRmdyTDhyVlNSbXNv?=
 =?utf-8?B?Yk9vNCtlTlVUa05KU0FtT1J2VSswWFJBQlFiSldBZW9qMXJkN3JDQUFybW5C?=
 =?utf-8?B?eHNOVjNIUWQ5L0hLOVFKQ0hwdThQL3hBS3V1eW5KalEzN01tY1FyOEh3Nld1?=
 =?utf-8?B?dngycGpSMTc4eEFGOGQzemNGYjR4MUY4VG9EMno1UWNCWUhaNTV2cUFZRnl1?=
 =?utf-8?B?WjZ0dHNyb3c0Z2lBenNiMHVacVFsbjZNbHdxMGRQcUl1dkZmbGk3dXExYktO?=
 =?utf-8?B?NE9vbFNEN1J4d1Y5cnNISXBNQndDQ3Myengrd3BnYXFqanRrTTA3WnZVeDBS?=
 =?utf-8?B?NjI5Nnk4VzVZa2FRQWFFSmNnWlZ0b0hSMkNBck1mVHB3QW9CRXdRNGxoWDM5?=
 =?utf-8?B?cWFtaVdpSjN1SlFRQUFIb1lSTHczcjA2YnZmOWVHaVYrR29JclU2NEh4NHMv?=
 =?utf-8?B?ME1YT3VyblJGQkl6Y0k5ZXhESHFUYS91WENQNEFpbVFnT3lMT0ZuNFFTTDQ0?=
 =?utf-8?B?TTk1VzN3aG9aak1uZXRSUHVwcDJEeElKZ3RobGJUaVZDcUpMcDJqbDJkcUdz?=
 =?utf-8?B?dmttckx3TFJtWDhjb0orSVprV2V1VUVaSUhrWXlEbTZnRFpFMTVTd2JZS0ZP?=
 =?utf-8?B?Q1Mrbk01U1U3UW15SWwrZGY0UjdZRkFCbUtSZUhlbXRWSnlGK205NDhnVnd0?=
 =?utf-8?B?R2V5K2Erdjd4RFlDUkNXR2orUVcrZDZSdWRZbndXcGZhd0ZkVUJEWFY3dUFV?=
 =?utf-8?B?RW5tMnluZmRnWVZJa2FQelZKbFJuZ3NCbXRNWFV5TVI5VWx1SS9QV3NtTXdn?=
 =?utf-8?B?Mjc5UXRIemtPd1JPcmh4YXJSYy9KTXlUUDJ1eHg2V2dHekFyclh0bUdzVXJ2?=
 =?utf-8?B?RFNZckJjYWluNW9sT2NleERueW1rcy9MeDJJbWJ6aW9ENE9jbjkxWnhNOEx1?=
 =?utf-8?B?TVYzNGZVTWlFWDJxZnFqdHdjZzd2QWcvZ3B6clZxNitvT1JBUm9VZFNSQkdI?=
 =?utf-8?B?TlFTVU9DdHRZcW1jVFJpZGh1THdzSXBlWHFqa1ZOanNSemQ3eDNMRXFyMmpK?=
 =?utf-8?B?MEJtVnBPa056UVFpV3J6U2pSN09YbHRoSmlhcTB5T3JmanRGNmZsMFVGaGwy?=
 =?utf-8?Q?Srq+i/CUu850xfgw58JrHV6S1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0656b158-c7e5-4cd9-08ca-08dcac1566dd
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 19:18:30.1191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrnPj6wg9JT/f2MW+kbL1Rewny2TNE4CVhGqmwB2eqDEJ7jSXOjF7LYO+Ld5RyFNjmgyZM+i/MaS21kopItJaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876
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


On 2024-07-19 18:17, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> When app unmap vm ranges(munmap) kfd/svm starts drain pending page fault and
> not handle any incoming pages fault of this process until a deferred work item
> got executed by default system wq. The time period of "not handle page fault"
> can be long and is unpredicable. That is advese to kfd performance on page
> faults recovery.
>
> This patch uses time stamp of incoming page page to decide to drop or handle
> page fault. When app unmap vm ranges kfd records each gpu device's ih ring
> current time stamp. These time stamps are used at kfd page fault recovery
> routine.
>
> Any page fault happens on unmapped ranges after unmap events is app bug that
> accesses vm range after unmap. It is not driver work to cover that.
>
> By using time stamp of page fault do not need drain page faults at deferred
> work. So, the time period that kfd does not handle page faults is reduced
> and can be controlled.
>
> Signed-off-by: Xiaogang.Chen <Xiaogang.Chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |   4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |   3 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |   4 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h  |   5 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 111 +++++++++++++++++--------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |   2 +-
>   7 files changed, 88 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3abfa66d72a2..d90b7ea3f020 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2763,7 +2763,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>    * shouldn't be reported any more.
>    */
>   bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
> -			    u32 vmid, u32 node_id, uint64_t addr,
> +			    u32 vmid, u32 node_id, uint64_t addr, uint64_t ts,
>   			    bool write_fault)
>   {
>   	bool is_compute_context = false;
> @@ -2789,7 +2789,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   	addr /= AMDGPU_GPU_PAGE_SIZE;
>   
>   	if (is_compute_context && !svm_range_restore_pages(adev, pasid, vmid,
> -	    node_id, addr, write_fault)) {
> +	    node_id, addr, ts, write_fault)) {
>   		amdgpu_bo_unref(&root);
>   		return true;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 312a408b80d3..1d6a1381ede9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -548,7 +548,7 @@ amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm);
>   void amdgpu_vm_put_task_info(struct amdgpu_task_info *task_info);
>   
>   bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
> -			    u32 vmid, u32 node_id, uint64_t addr,
> +			    u32 vmid, u32 node_id, uint64_t addr, uint64_t ts,
>   			    bool write_fault);
>   
>   void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index d933e19e0cf5..5cceaba6e5c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -132,7 +132,8 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>   		/* Try to handle the recoverable page faults by filling page
>   		 * tables
>   		 */
> -		if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, addr, write_fault))
> +		if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, addr,
> +								   entry->timestamp, write_fault))
>   			return 1;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 350f6b6676f1..ac08d9424feb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -595,7 +595,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>   			cam_index = entry->src_data[2] & 0x3ff;
>   
>   			ret = amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
> -						     addr, write_fault);
> +						     addr, entry->timestamp, write_fault);
>   			WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
>   			if (ret)
>   				return 1;
> @@ -618,7 +618,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>   			 * tables
>   			 */
>   			if (amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
> -						   addr, write_fault))
> +						   addr, entry->timestamp, write_fault))
>   				return 1;
>   		}
>   	}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index c51e908f6f19..8b8d5ab9da76 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -850,10 +850,13 @@ struct svm_range_list {
>   	struct list_head                criu_svm_metadata_list;
>   	spinlock_t			deferred_list_lock;
>   	atomic_t			evicted_ranges;
> -	atomic_t			drain_pagefaults;
> +	/* stop page fault recovery for this process */
> +	atomic_t			stop_pf_recovery;
>   	struct delayed_work		restore_work;
>   	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
>   	struct task_struct		*faulting_task;
> +	/* check point ts decides if page fault recovery need be dropped */
> +	uint64_t				checkpoint_ts[MAX_GPU_INSTANCE];
>   };
>   
>   /* Process data */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 407636a68814..9dd28d06ea2a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2263,16 +2263,10 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
>   {
>   	struct kfd_process_device *pdd;
>   	struct kfd_process *p;
> -	int drain;
>   	uint32_t i;
>   
>   	p = container_of(svms, struct kfd_process, svms);
>   
> -restart:
> -	drain = atomic_read(&svms->drain_pagefaults);
> -	if (!drain)
> -		return;
> -
>   	for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
>   		pdd = p->pdds[i];
>   		if (!pdd)
> @@ -2292,8 +2286,6 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
>   
>   		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
>   	}
> -	if (atomic_cmpxchg(&svms->drain_pagefaults, drain, 0) != drain)
> -		goto restart;
>   }
>   
>   static void svm_range_deferred_list_work(struct work_struct *work)
> @@ -2315,17 +2307,8 @@ static void svm_range_deferred_list_work(struct work_struct *work)
>   			 prange->start, prange->last, prange->work_item.op);
>   
>   		mm = prange->work_item.mm;
> -retry:
> -		mmap_write_lock(mm);
>   
> -		/* Checking for the need to drain retry faults must be inside
> -		 * mmap write lock to serialize with munmap notifiers.
> -		 */
> -		if (unlikely(atomic_read(&svms->drain_pagefaults))) {
> -			mmap_write_unlock(mm);
> -			svm_range_drain_retry_fault(svms);
> -			goto retry;
> -		}
> +		mmap_write_lock(mm);
>   
>   		/* Remove from deferred_list must be inside mmap write lock, for
>   		 * two race cases:
> @@ -2446,6 +2429,7 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>   	struct kfd_process *p;
>   	unsigned long s, l;
>   	bool unmap_parent;
> +	uint32_t i;
>   
>   	p = kfd_lookup_process_by_mm(mm);
>   	if (!p)
> @@ -2455,11 +2439,49 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>   	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] [0x%lx 0x%lx]\n", svms,
>   		 prange, prange->start, prange->last, start, last);
>   
> -	/* Make sure pending page faults are drained in the deferred worker
> -	 * before the range is freed to avoid straggler interrupts on
> -	 * unmapped memory causing "phantom faults".
> +	/* first stop kfd page fault handling for this process */
> +	atomic_set(&svms->stop_pf_recovery, 1);

Why is this needed?


> +	/* calculate time stamps that are used to decide which page faults need be
> +	 * dropped or handled before unmap pages from gpu vm
>   	 */
> -	atomic_inc(&svms->drain_pagefaults);
> +	for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
> +		struct kfd_process_device *pdd;
> +		struct amdgpu_device *adev;
> +		struct amdgpu_ih_ring *ih;
> +		uint32_t checkpoint_wptr;
> +		uint64_t checkpoint_ts = 0;
> +
> +		svms->checkpoint_ts[i] = 0;
> +		pdd = p->pdds[i];
> +		if (!pdd)
> +			continue;
> +
> +		adev = pdd->dev->adev;
> +		ih = adev->irq.retry_cam_enabled ? &adev->irq.ih : &adev->irq.ih1;

Rerouting interrupts to ih1 doesn't work on all GPUs. I think a better 
heuristic to determine which ih ring to drain is to look at whether ih1 
is empty. If it is empty, drain ih_soft instead. If both are empty, 
there is nothing to drain and you skip this.


> +
> +		if (!ih->enabled || adev->shutdown)
> +			continue;
> +
> +		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
> +		/* Order wptr with ring data. */
> +		rmb();
> +		checkpoint_ts = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
> +
> +		if (adev->irq.retry_cam_enabled) {
> +			ih = &adev->irq.ih_soft;
> +
> +			if (!ih->enabled || adev->shutdown)
> +				continue;
> +
> +			checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
> +			rmb();
> +			checkpoint_ts = max(checkpoint_ts,
> +						amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1));

This won't work correctly when the timestamp wraps around. Use 
amdgpu_ih_ts_after to compare timestamps in a way that works with 
wraparound (as long as the timestamps aren't too far apart).

That said, I don't think you need to look at two IH rings. It should be 
enough to look at one IH ring, either IH1 or IH_SOFT. 
svm_range_restore_pages never processes interrupts from IH because it 
always runs in a worker thread that looks at one of the other IH rings.


> +		}
> +		svms->checkpoint_ts[i] = checkpoint_ts;
> +	}
> +	/* resume kfd page fault handing with time stamp checking */
> +	atomic_set(&svms->stop_pf_recovery, 0);
>   
>   	unmap_parent = start <= prange->start && last >= prange->last;
>   
> @@ -2900,7 +2922,7 @@ svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
>   int
>   svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   			uint32_t vmid, uint32_t node_id,
> -			uint64_t addr, bool write_fault)
> +			uint64_t addr, uint64_t ts, bool write_fault)
>   {
>   	unsigned long start, last, size;
>   	struct mm_struct *mm = NULL;
> @@ -2910,7 +2932,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	ktime_t timestamp = ktime_get_boottime();
>   	struct kfd_node *node;
>   	int32_t best_loc;
> -	int32_t gpuidx = MAX_GPU_INSTANCE;
> +	int32_t gpuid, gpuidx = MAX_GPU_INSTANCE;
>   	bool write_locked = false;
>   	struct vm_area_struct *vma;
>   	bool migration = false;
> @@ -2930,7 +2952,29 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   
>   	pr_debug("restoring svms 0x%p fault address 0x%llx\n", svms, addr);
>   
> -	if (atomic_read(&svms->drain_pagefaults)) {
> +	/* kfd page fault recovery is disabled */
> +	if (atomic_read(&svms->stop_pf_recovery)) {
> +		pr_debug("page fault handing disabled, drop fault 0x%llx\n", addr);
> +		r = 0;
> +		goto out;
> +	}
> +
> +	node = kfd_node_by_irq_ids(adev, node_id, vmid);
> +	if (!node) {
> +		pr_debug("kfd node does not exist node_id: %d, vmid: %d\n", node_id,
> +			 vmid);
> +		r = -EFAULT;
> +		goto out;
> +	}
> +
> +	if (kfd_process_gpuid_from_node(p, node, &gpuid, &gpuidx)) {
> +		pr_debug("failed to get gpuid/gpuidex for node_id: %d \n", node_id);
> +		r = -EFAULT;
> +		goto out;
> +	}
> +
> +	/* check if this page fault time stamp is before svms->checkpoint_ts */
> +	if (amdgpu_ih_ts_after(ts, svms->checkpoint_ts[gpuidx])) {

When we're not draining page faults, you should set 
svms->checkpoint_ts[gpuidx] to some invalid value to avoid comparing ts 
against an outdated timestamp. If it has the invalid value, skip the 
draining check here. Otherwise, when ts wraps around, you will get the 
wrong result and drain faults when you shouldn't.

Regards,
   Felix


>   		pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
>   		r = 0;
>   		goto out;
> @@ -2952,13 +2996,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		goto out;
>   	}
>   
> -	node = kfd_node_by_irq_ids(adev, node_id, vmid);
> -	if (!node) {
> -		pr_debug("kfd node does not exist node_id: %d, vmid: %d\n", node_id,
> -			 vmid);
> -		r = -EFAULT;
> -		goto out;
> -	}
>   	mmap_read_lock(mm);
>   retry_write_locked:
>   	mutex_lock(&svms->lock);
> @@ -3173,9 +3210,11 @@ void svm_range_list_fini(struct kfd_process *p)
>   	/*
>   	 * Ensure no retry fault comes in afterwards, as page fault handler will
>   	 * not find kfd process and take mm lock to recover fault.
> +	 * stop kfd page fault handing, then wait pending page faults got drained
>   	 */
> -	atomic_inc(&p->svms.drain_pagefaults);
> +	atomic_set(&p->svms.stop_pf_recovery, 1);
>   	svm_range_drain_retry_fault(&p->svms);
> +	atomic_set(&p->svms.stop_pf_recovery, 0);
>   
>   	list_for_each_entry_safe(prange, next, &p->svms.list, list) {
>   		svm_range_unlink(prange);
> @@ -3197,16 +3236,18 @@ int svm_range_list_init(struct kfd_process *p)
>   	mutex_init(&svms->lock);
>   	INIT_LIST_HEAD(&svms->list);
>   	atomic_set(&svms->evicted_ranges, 0);
> -	atomic_set(&svms->drain_pagefaults, 0);
> +	atomic_set(&svms->stop_pf_recovery, 0);
>   	INIT_DELAYED_WORK(&svms->restore_work, svm_range_restore_work);
>   	INIT_WORK(&svms->deferred_list_work, svm_range_deferred_list_work);
>   	INIT_LIST_HEAD(&svms->deferred_range_list);
>   	INIT_LIST_HEAD(&svms->criu_svm_metadata_list);
>   	spin_lock_init(&svms->deferred_list_lock);
>   
> -	for (i = 0; i < p->n_pdds; i++)
> +	for (i = 0; i < p->n_pdds; i++) {
> +		svms->checkpoint_ts[i] = 0;
>   		if (KFD_IS_SVM_API_SUPPORTED(p->pdds[i]->dev->adev))
>   			bitmap_set(svms->bitmap_supported, i, 1);
> +	}
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 70c1776611c4..5f447c3642cb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -173,7 +173,7 @@ int svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
>   			    bool clear);
>   void svm_range_vram_node_free(struct svm_range *prange);
>   int svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
> -			    uint32_t vmid, uint32_t node_id, uint64_t addr,
> +			    uint32_t vmid, uint32_t node_id, uint64_t addr, uint64_t ts,
>   			    bool write_fault);
>   int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence);
>   void svm_range_add_list_work(struct svm_range_list *svms,
