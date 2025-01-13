Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C348E7719A
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 04:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14AEB10E08E;
	Mon, 13 Jan 2025 04:40:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mGQDH6cH";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96D0F10E08E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 04:40:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVb2sv+JpAdsDtOElv8yHuOlsHdyo1ULN6f0zC73C2o0TxbVtwr+Unh08BcoZMt6W7Vdo+LEhxCD8QWxW4fYoorbrVgyePKVXqsKOHR2A5eHNFiF73GGgQjJAZhPtCf78e8ZW40Cm70s7lZ4MbBe7ZhfzGnBu8Oh1YX2KzUfvzx+OmDWeFHN6fBDc/AFmkAJgWXFMYMaYGAaPidY4i1WTv1GGEa4bWdn4BZGu99m9W0Cpkk8LmOSa+tuQjgvW7jQQ07QgD+uFbhtleaguksT4O5JCxfFitQ5LdrWpea70cAxGfqOvmWzApit9o7fFEedUvDdND8RLJd4KzFb++qEJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aomy1vkKhrJwENLTPBrLfr3t9FAdMzZw5SKdk+Z6xe4=;
 b=aQXiLdX69QFIUam/bch9YU31IqA0pb8PmQFzPDUQcWR8zZvY1hYUkfO2FcshjCREAWa7lrAqGgtfZhvefojbl7cIedHGtQ8rB8OxI2c7oN8wR20x01VwIiqQXhiIGdUGOa/i+IAL+5q8/NRrHbwv95p9O9gKSJh7vUaWt6yzbbd6+dKIaZsS7HOWrS7i9RSSSw/2UdzZzJNVFlXaR/N0WlrEcW8WHJkFg7LeHnNsMnIb5zHj5KmcqDQfp0g574jm/pwl9jEvNN5cBa3qVFtk1xitEqlQo+aW2amgwdGoytyGY85wgFDtScRMifkurWc9i8a0RDvKJOOx82sA2S5kfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aomy1vkKhrJwENLTPBrLfr3t9FAdMzZw5SKdk+Z6xe4=;
 b=mGQDH6cHAjWlpiZD+DAoqaf0WvUkbGGkB+U5EAz/DPtPw3VT5WTPzJ9+Xe1YQQgSHAAkKm5WlTjmZkJxS4mV/s5lcbNswfNQUvctaZcEdY7kFSZ7CbiQzQn5kimznAxriyhp8Um9dGrp0+mvRr+AZhwlHgXjS3FkxUcKLnaTOmo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB7612.namprd12.prod.outlook.com (2603:10b6:930:9c::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.13; Mon, 13 Jan 2025 04:40:28 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 04:40:28 +0000
Message-ID: <ef255fe6-98ce-4656-94a4-aa259b7e6a51@amd.com>
Date: Mon, 13 Jan 2025 10:10:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 2/5] drm/amdxcp: introduce new API amdgpu_xcp_drm_dev_free()
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736474822.git.gerry@linux.alibaba.com>
 <79267ddb1b1b8d83e2ec170f4b0b578c705de4dd.1736474822.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <79267ddb1b1b8d83e2ec170f4b0b578c705de4dd.1736474822.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0055.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::33) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 536e44be-bcd3-48cb-dc37-08dd338c6746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkpuajBWTEJuYU0xZk1OMDdiUkpwYTdxelVLbjRKNjUrOUk5N2ZwVzgrUnZE?=
 =?utf-8?B?OHlHMVJxa2VRSU5YT09wbVFoRXN0eXNCelBxSVhLS0FEQ0JhSXhpbUc0VGRt?=
 =?utf-8?B?T25mb3ArYjFqNUhaRnZxSVI1NmM5WG5yQ2U2cDVZR2ltS3BZNXJVdlZ4emJW?=
 =?utf-8?B?VnBLdm9SSUxzbm1wYXhpR3NjTVFDWDNqdUlzWC8rbzJLRFRGM3Y1UzBoUmxx?=
 =?utf-8?B?TUFMenRvb2NRN0VIOUh0ZHZGMnF1V0ZNc0cyVys1OVkzaFIvR2krWHIyZjlh?=
 =?utf-8?B?WUVHbndjVnJqeTdxVS9mWFpQTTR2a05hbnR6dVhxZ2dqUmlXSmFUbEFuN2Z6?=
 =?utf-8?B?WVpHTGMyd01hZk4zQUI1TVNKcGlLVWk0bVhYV0ZwVnlxVlRWNnhrNmVvL0sv?=
 =?utf-8?B?Mk52d0ZNSXNXM21WLytMQTcrSytaNk5GSXN0ZzFCWS9TWVhKQWU2aGlUUVBW?=
 =?utf-8?B?UmplSkVpamRWdFFDWVdQd1daaFFLdzkxejFNL3h3S3h6L1hJT0x0RThRb25N?=
 =?utf-8?B?bnVtRXJ3TVMvSUtwSDdQcHZpT2M0L05sUk5FbUQrMnVQSWdLUCtlS01IOUZN?=
 =?utf-8?B?NmNHQVh6V3NiV25NUjVOVkdqNStSZ3QvMGEzdmZCb0tkV2kzTnoyZTQxanVi?=
 =?utf-8?B?UUFYcERuYW9FSkxGSnpNRHBySXJiSzA0amgvOHNJOWM5UWdqV2lEbFFtaGZJ?=
 =?utf-8?B?SmFwNEZsektUOEQ5QnRHbGFVdjkzb1AvOXNmenNuWTFwRFFWQTRsSWxkZUpP?=
 =?utf-8?B?SHB6T1kyMDBVQTdYM2MxYjg4cFBjNDBWb2FkM2FQVTlXS2dlSGxLT3YvcFRF?=
 =?utf-8?B?R01qYWloU05OSmNtZnBzaGRDTm96RlEyV3pOVWI3SStuN0RWQldnaVBTb0xL?=
 =?utf-8?B?VFY1VnNzM29NeG13RTR1WGo2Vkh4RnYyTGJVcUlmMlE1OWhYcTZrdWZodE54?=
 =?utf-8?B?VEg2VzloRjRRdDRSQnIzUlhJY0pWaGlNaUVCNHVtMUFyZEY5WjJZOE1NamlX?=
 =?utf-8?B?djdlUnU3M3ZpN09BRUNRY3cvcmdya25UUHdSMjFGV0o2dmx4MGhKajVJMXBB?=
 =?utf-8?B?T0dsOFRyaG9xR3FVTWs4MGtlaUxwdWZHNm9FcGRWYUNDMDZaUjBmQTJET2Fk?=
 =?utf-8?B?VFcwS2ZjNUNOdWtrelpDTDRSRFg2RWZ4UzU3bUdIVnRLejBrR04wVWQydnE5?=
 =?utf-8?B?ZVhoemp0K1VwbkljM005eUN4STJLM0R0cVpOeUJ1djZDTklrMkMyanhzbFRG?=
 =?utf-8?B?SnluNW4xeHNodHpUa0pzdlFLT2RMcUlKcG8rMjRDM3ZyY0xsTmlveG5nQkFt?=
 =?utf-8?B?bVlBekNMZ05iWVF6TEVJRkhXdnZBN0lKbUk5c0p6ZGQ5SHpYSkVWUVhCMS8w?=
 =?utf-8?B?T0tiN1dFRnRjQzJnbWNuTTFtaHlKdlJkaXNYbnBDTWdjS2hQV0lJZGRuRCth?=
 =?utf-8?B?UXJodmVLaTJOWFMyUTB3TUtqaU54SUdYS1NVRGhtNDVwbVVES05USEVjTEhn?=
 =?utf-8?B?OU8vR1I3YTl5eFJqUDFVdlByVFNKL1k0VTE4ekxYOS9FaEJTT3lpdnlqT0V6?=
 =?utf-8?B?eDdoMUFHRmJNZjRYL04rOC9vb1FrcHRyZ3VFS3E1TUJUZmdOQTlqMW9tVVda?=
 =?utf-8?B?R1htdkRibHduL3pULzNzN1lvaTBwRTEzZkJWbGp3TE50bkJlZEszTklPR1Vj?=
 =?utf-8?B?NmppNS9Nd1dlQXhSeUswdWNPeWVsUWYyUWlRbXZLa1F4ck9hUERkL1M2eXpI?=
 =?utf-8?B?QnRZV21USnVWZFhkV0loWURxdFhia25RZDU3d0tmd2lxOTJ2Y1BBVVcwbEI2?=
 =?utf-8?B?WHZBcDZFRzFkVExIN0VERloxb3U2OHc5dGdkdWZZNzRuUWFLeXNrdityQkt0?=
 =?utf-8?B?QW9DRHE4Yk1NdXlTRnhhdXlHclN3TVFBQWhXYVpad0V1TkRUNko1TG9lcHVF?=
 =?utf-8?Q?JvpnoLCpw4E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(921020)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFlrcDlubEJqbVQydE9SMDFRTWt3dWNITHhRbjJIQ3pMZUE5bVo4cTNZNjd4?=
 =?utf-8?B?eWZ0QVNTRDNPL0VYSFFaM2RUVjBNYlFJS1d0R3dzVXZMNjhTNDdHWmE0V2Nh?=
 =?utf-8?B?eHhON01ockhrM1ppR2htVVNnTDNvRlNEaVRSY0hNVmplL2QwV1ZVVldOcklT?=
 =?utf-8?B?Tm5OaGdkTWpSZW15dlVHZ05raGFSR0o5aHN1VHJ6aGVhSnFMaFc0R2pObTNQ?=
 =?utf-8?B?WmpYKy9VWWhRaXJaTm1BNHVIZktoNmFCQyt5KzlHS1Rpb1N5cExhTER4NWps?=
 =?utf-8?B?SVlvWDlFeVIra3d6WUJ6akNML3MrYTJYMkkrSlhKNTNEOUwzek5YV0V3N1A0?=
 =?utf-8?B?dVNpeTZEdmwvZWFQLzhuaHBtN0cxNVhObjc3MDRudkdZOTJuL01RUDN6Mis3?=
 =?utf-8?B?TlZrcXVjb1J5NnJYTWdRdkpQL1ZSbHgyYi94KzJWZFFpQ1lsVklURGxYWDYr?=
 =?utf-8?B?TTFnN3hKL1N5QlJML0FsWG5RSGVvY05WNHh0UlBMRC9VRk9BZWhsS1k1MWNp?=
 =?utf-8?B?U0hwenRwenhXVDYxa3JMSEpZZUh4TGNGcEdwRzJ6blVFTzhUMDdDUDduY0pL?=
 =?utf-8?B?Q0FMa01venJXWFZQTmplOWRPOTA1WDhKU0x3U2dvS3NvN2wxdUpBZHMrS3FN?=
 =?utf-8?B?YmFQRytGSE9adU5jdnNMQzMwbjB0QXYzY1F1bGpNOE1wQ3lCMHVJa21idFdq?=
 =?utf-8?B?c1VmTzR2TGRjSllVNFE2RUF1UjlHY0FEYkZDNDF2T3BYSE9UaHVxaWtsQ2R3?=
 =?utf-8?B?L3ZITGd0bklHTkxQUmdxaHZKRzZ4OS9vZ1IwS01UbS8rRDBSYTJnS294cm0r?=
 =?utf-8?B?aVdycEpXRHlVcTZmd0l1TXJWb0RKOE5mUDUraCtlNnc5ZkxxK3FRU2FiR3Zq?=
 =?utf-8?B?L1cwSnQ4UWNlbTl1aEhsck5wY0RTT0hDSmh4RnVUOXl2Lyt1Tlo0bVVQejAv?=
 =?utf-8?B?bmhGZCtjVEs3MW1RNnI3L2x5U2w5ZzZESWVQOElFMlhFYW94aTF6b1pKK3FP?=
 =?utf-8?B?M2cyYVc2TzNseGYxYVhDRkVXS3VYV1puN3VrT3JMVE1PbndBTU9jbUtNMG5P?=
 =?utf-8?B?b1JObGdmSndZMnJFb2Mva1pGQ0VOT0VXTjdwMzVGQ1BETUt0blNBVG5CSmNh?=
 =?utf-8?B?UHpid2pWTXRqMGkzU2NoSVEvZzBhR280a1N6S3BzTzB1aDFHeC9IYi9WNDFq?=
 =?utf-8?B?alRhN3RnRkt0dFA2L2twcVNXczF5RE00R2VNOS9sYkRSdE5PaktMeWplU2NW?=
 =?utf-8?B?NXR4WTZzU1VvemM2T3ZVZ1RHZ3pIRkJoQUJjaUE5V0ZrTXVTbytNaWhweGJL?=
 =?utf-8?B?UDRpM0l6K2xWOTF4SHlURTl4QkVjaFZLMXBNTkdJUUFWREp2ZTROek0xSWd5?=
 =?utf-8?B?ejhwRWtQdlplMjRZS0l0Q1UrektVdnhIWDBBNVd4WERKWXZrMmU0MTNkQ3Zn?=
 =?utf-8?B?WDVvVzlWelMvTGJ1QTNNWVU2S3MzbDYwa0ZmVmRTUHBqYjVMQnlJaXVCNEZY?=
 =?utf-8?B?T0NxWFpGVkM4TGRwcFlqdXFOSGlicXlFTSszOHdOdVFPQkFjajM3UmFNcC9u?=
 =?utf-8?B?eGNzUkgvNVVZQkFPWW5RYXgvbTMrTUloUE5KUDdGa081d2Z5R3FCMS9FTDRt?=
 =?utf-8?B?d0VjS0NrZWFNZU5tTXpRWmFXc285QmNjeWQ4S1dkK2hHTkU3QlZ4dzYwaVc2?=
 =?utf-8?B?UnFiaUdtU0lzblRGbkZUZTVaQ0dTUCtsbStuaHRieXhkNmRvWHlHSFRLQjNz?=
 =?utf-8?B?aGoyTE9YbS9rRU1OaXdMK0plT1k4Z2cxaWxWSG54OEIvSUtNZmMzaWhYaU9k?=
 =?utf-8?B?UzZDSlllcDBhenp2L2FxUUs4ZnhSY1Rka0dMZ096aWVsZjlsVThsZm5DYngy?=
 =?utf-8?B?cDBsVkdxUWhJTjBubk9vSzNldEhEZWxOemhiS04yTHMvamlCMFV5OXRsaVBX?=
 =?utf-8?B?aVRqMWEvTEEvTjZNRUZZenlUSDUvQjdkRHh4aHB6ZXVyakxRL0k5bnFZTjBq?=
 =?utf-8?B?cHA0NkNHQ1J1cmNrb0xKK3NrL0ZqOHY1NHFOeHdyRGIwdmVOMVhRSUkxRmtj?=
 =?utf-8?B?RlpjN0tubWdXUFVLdGxtZ2VWRnBqOEtuS1R4SGNuQ0FvWDd3NFZtYVdOWksz?=
 =?utf-8?Q?CicIdiOAlN+jgdjfl3o6hwHBq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 536e44be-bcd3-48cb-dc37-08dd338c6746
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 04:40:28.1082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYXE5IEj7ErKRkkDAhEzcIVqgIswA/XctkrYoaFPCJ/wvzC7wbYIdjzJuXD074JZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7612
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



On 1/10/2025 7:38 AM, Jiang Liu wrote:
> Introduce new interface amdgpu_xcp_drm_dev_free() to free a specific
> drm_device crreated by amdgpu_xcp_drm_dev_alloc(), which will be used
> to do error recovery.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 65 +++++++++++++++++----
>  drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
>  2 files changed, 56 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> index faed84172dd4..0473fe0479d9 100644
> --- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> +++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> @@ -45,18 +45,26 @@ static const struct drm_driver amdgpu_xcp_driver = {
>  
>  static int8_t pdev_num;
>  static struct xcp_device *xcp_dev[MAX_XCP_PLATFORM_DEVICE];
> +static DEFINE_MUTEX(xcp_mutex);
>  
>  int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>  {
>  	struct platform_device *pdev;
>  	struct xcp_device *pxcp_dev;
>  	char dev_name[20];
> -	int ret;
> +	int ret, index;
> +
> +	guard(mutex)(&xcp_mutex);
>  
>  	if (pdev_num >= MAX_XCP_PLATFORM_DEVICE)
>  		return -ENODEV;
>  
> -	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", pdev_num);
> +	for (index = 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
> +		if (!xcp_dev[index])
> +			break;
> +	}
> +
> +	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", index);
>  	pdev = platform_device_register_simple(dev_name, -1, NULL, 0);
>  	if (IS_ERR(pdev))
>  		return PTR_ERR(pdev);
> @@ -72,8 +80,8 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>  		goto out_devres;
>  	}
>  
> -	xcp_dev[pdev_num] = pxcp_dev;
> -	xcp_dev[pdev_num]->pdev = pdev;
> +	xcp_dev[index] = pxcp_dev;
> +	xcp_dev[index]->pdev = pdev;
>  	*ddev = &pxcp_dev->drm;
>  	pdev_num++;
>  
> @@ -88,16 +96,53 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>  }
>  EXPORT_SYMBOL(amdgpu_xcp_drm_dev_alloc);
>  
> +static void __amdgpu_xcp_drm_dev_free(int index)
> +{
> +	struct platform_device *pdev;
> +
> +	pdev = xcp_dev[index]->pdev;
> +	devres_release_group(&pdev->dev, NULL);
> +	platform_device_unregister(pdev);
> +	xcp_dev[index] = NULL;
> +	pdev_num--;
> +}
> +
> +void amdgpu_xcp_drm_dev_free(struct drm_device *ddev)
> +{
> +	int index;
> +	struct xcp_device *pxcp_dev;
> +
> +	if (ddev == NULL)
> +		return;
> +
> +	guard(mutex)(&xcp_mutex);
> +	WARN_ON(!pdev_num);
> +
> +	pxcp_dev = container_of(ddev, struct xcp_device, drm);
> +	for (index = 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
> +		if (xcp_dev[index] == pxcp_dev) {
> +			__amdgpu_xcp_drm_dev_free(index);
> +			break;
> +		}
> +	}
> +}
> +EXPORT_SYMBOL(amdgpu_xcp_drm_dev_free);
> +
>  void amdgpu_xcp_drv_release(void)
>  {
> -	for (--pdev_num; pdev_num >= 0; --pdev_num) {
> -		struct platform_device *pdev = xcp_dev[pdev_num]->pdev;
> +	int index;
>  
> -		devres_release_group(&pdev->dev, NULL);
> -		platform_device_unregister(pdev);
> -		xcp_dev[pdev_num] = NULL;
> +	guard(mutex)(&xcp_mutex);
> +
> +	for (index = 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {

May be this - before entering or as first check.

	for (index = 0; pdev_num && index < MAX_XCP_PLATFORM_DEVICE; index++)

Thanks,
Lijo

> +		if (xcp_dev[index]) {
> +			__amdgpu_xcp_drm_dev_free(index);
> +			if (!pdev_num)
> +				break;
> +		}
>  	}
> -	pdev_num = 0;
> +
> +	WARN_ON(pdev_num != 0);
>  }
>  EXPORT_SYMBOL(amdgpu_xcp_drv_release);
>  
> diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> index c1c4b679bf95..580a1602c8e3 100644
> --- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> +++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> @@ -25,5 +25,6 @@
>  #define _AMDGPU_XCP_DRV_H_
>  
>  int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev);
> +void amdgpu_xcp_drm_dev_free(struct drm_device *ddev);
>  void amdgpu_xcp_drv_release(void);
>  #endif /* _AMDGPU_XCP_DRV_H_ */

