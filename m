Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527DEC3ABA3
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 13:08:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9D2F10E91E;
	Fri,  2 May 2025 13:08:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JzZ5ztit";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F062010E914
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 13:08:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzHj9aIkSIr1u1v44Npr4lYUWEBae+XaLbccUWkM3sTYyXcU52BqVZP2qulO+xRBTM84uBhvuT10atMRfxC3iWNfsi7Z9BR495wtCSoVX5GHYMGi7DlP66kIgl22gi6hlGdU3H5kMfG6wNhD8pTMUwQdnf2hKMDNB0vo7S6Jxs8JRpHy95hn/IB51gcc5S0EVdVIqyltx5Oejw3YKr8YOsbA/nsB+1hO2HUfw57DkeolvrHFL3iQi5SjR3FC/QHqFA8E47SA8CqDQLfUEz2ZA9fVldVVGerWT5+86WjFMe3dcY1XB3zTUNKBVExwtVS8wsgvGbE5Nl6UgfArFAh9Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZDNYbHOVtNl/3BvrSRVoUj29NDERUAAVcu7z+eDajI=;
 b=huNoKVS6ini0/uja5kx/qVVzjhONJn6M8fYiU5dZT6BMVweGj4rj6PoJFem97qPJHRVY+34zogFuoxMkfV9I6mLfqDgWeZUgNoRqKCuJ++jl3L2+dIoDPKoJuw4d9CBVQGd7QkKNwYcWczlSQ7eKhOATDtoOYWwSkB6vbj7G83SoyCWH47c4yKioiSLMy1nukw+SGsGn7RHIHUJ74WIDgZm8kRnRuoAoALfV5q9Nw6NnVbR9eD7Mzes6kBj1G26y8uPmsNs3KP8POWkER3+eCGoc4ofVQ2Twn1O7XZfSE8epbtdBrD6xsN9NcQOPCKG0bWA0He1U7K2Hfcno57pN5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZDNYbHOVtNl/3BvrSRVoUj29NDERUAAVcu7z+eDajI=;
 b=JzZ5ztitE/7Jjvisvdg9FqYE8njVi5GcDhKNJ0xl4nCz1IuH9l2WD5W8PAVp8VSwk8hHUOTI+QPcxPwkY9038cl6e1EnIuCsVgE83dxIktc2WU+kmOoTv+9v9AJaiCYmua+ofn4l734MSnl8hcM70TATslGQTXZd6SjJfJCpiQg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Fri, 2 May
 2025 13:08:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Fri, 2 May 2025
 13:08:00 +0000
Message-ID: <c7512a47-f44b-4318-a060-8be4b3456c9d@amd.com>
Date: Fri, 2 May 2025 15:07:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] drm/amdgpu: Acquire BO locks only during BO processing
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20250409054831.2411-1-Arunpravin.PaneerSelvam@amd.com>
 <20250409054831.2411-5-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250409054831.2411-5-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0022.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4192:EE_
X-MS-Office365-Filtering-Correlation-Id: c109e8b5-5f60-4841-9123-08dd897a5d15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzFhOXBwTU5kbVJqQVNZMWE4Y2xFZVRMZUVYSWJHOU12MkFpU1NGeEdJcUVv?=
 =?utf-8?B?UU5qMDlCeVN5VzNsdE1ZN0U5K01WN1Z5RXYvWnN5M3NaejliZmxQYmJvYW41?=
 =?utf-8?B?bkV2NTZrSVo0RDJ2azM1QTBjSTFuWkpBYVNDOHhmM3VNdlJpZXhiSHVIUUVK?=
 =?utf-8?B?Uk5VamljbjhzUVcwUlAzaFRJbXJ2ODV3bVMwMjVMWWUzVlh4OGdrSVFLZkVM?=
 =?utf-8?B?UFpIWVpVbEpmZHg0SHVCT2drVE5XZWVQNXFVTUlrSlFsZ2JWZzNlRDdpSzN3?=
 =?utf-8?B?Q2RKOUduQitxM2V6eHFOaitQalhCd2dKRFNUWGZpUkNNQnJEeFdMV3lEbm5M?=
 =?utf-8?B?a3BCZHJIYmpiTVNRQzVLZ3E1eFVvd1llWTlXZ1F3cnRVVW5wM1ZxeVpTTG5L?=
 =?utf-8?B?N090MzBBYlE5bU9ETUhma3d5aHg4dG4vUlhISmMrL3VGbUtVVDVoT1ZnYlVT?=
 =?utf-8?B?Smd1OWc2eGZMWEY5NEQxNkdzb1JtSzcyWTFMaG54aGllZ3JEMC95Ymp1SXJu?=
 =?utf-8?B?Wnlpai9JTXU1L2RSRmdYREVZTWJXYnp2cm1NVlRuc2JGRk4yNW1OczM3U0F1?=
 =?utf-8?B?SkgrMXZBZkw0RHVmQ2svaCtETktXa0srWlJkYy9tR1ptRVdNZHdValYvN3FB?=
 =?utf-8?B?SVk3eDhOZUJsSzYyTmExTUhGc01RWkxHcW5xSTVwZFBUTkFJK0dPRSt6Mmd1?=
 =?utf-8?B?SWIwb0NXeWxURkxOVElFOXZLSEJFU0dyZHNOb1hDaTFBRmsyTzRZL2wrVWtL?=
 =?utf-8?B?a0dzcWNsY3AvdVRERDBWSXYyeHhSOE5lUk1OWU1QOVI3RWc5U3BHZlcrZGhZ?=
 =?utf-8?B?VGJsS2Y4Rk9iOXpZSFpHa2NSUzJ5UnlsVE1BM1BxNVBKcVFSMUdwTGJTV1VY?=
 =?utf-8?B?QjdoVG1SaHdrdjg1UEIvOXhRTUZvcFRPNjlyY0dKQkthNUZKVnR2QnBZeHZq?=
 =?utf-8?B?MjFvakRCMW5Bb0VtMTU4dy81K2t1YWZ6TXJvalB3VTBnU3k1RVFnVUwycktV?=
 =?utf-8?B?aUJaUlJucktmRGlUWkpXQ2ZaVG03ZEZlYzU3SGZCUy9yQisrY0ZHSktsUlpx?=
 =?utf-8?B?SlQwRmRNSnpZUXdDMFkrMTR2RDdGTUZ2VUdxVm1lNS9mbm1DVkY1dTFQQnZ1?=
 =?utf-8?B?bTNwMmdWKytodzQyR0QvK3lkOXprdE9wTmhELzVGQ3NUT3RPSzU5SUNBOFRD?=
 =?utf-8?B?d1pwWktCTCsvOW9RUG95a2xQMy9ZMHJuNDdyOHZxMFlSR0YwV0VYN2wzRVpy?=
 =?utf-8?B?ZjFoVEFOc2I5ZE1TYjNWTDV2ZStzdnZKN1RETjZDVXFhYmxjbXd5MktOSWc4?=
 =?utf-8?B?d2tjT3dWTzEwZmh0RlIrd3pqOUVOcVlTcUdmckMybkVUbmphcWpPaTR3MHk2?=
 =?utf-8?B?dXpWcHJNZTFkQUkwbytmR282WURSenh6cWpiUUxzeHIwc0RQbFZwSmtTNXQx?=
 =?utf-8?B?Ykl1OEJ4VXAxOThPWGhkNG9pcW1XckdXdXZwQnc0SEk0TzBPTlorVUNxdW5T?=
 =?utf-8?B?dGpEYXZYaURYNWZRU2J5YnhtMFhPZ3pXcVRZM3FQSUlYMWdTeFJJZU1rSkVI?=
 =?utf-8?B?UitMQTk0TitBVFdoMlVzNmhZcE4yV0poNms5WXNnM0hkN2F3RngyR0Y5LzVQ?=
 =?utf-8?B?clQydXcrYUx6RDdnbDBDc3hNZHhHY3YrSXZsN1RZYUxLSmM5RmZGeUo2WGdy?=
 =?utf-8?B?RjJRSHZwZDBueEJ2OXFOd0NodHdVT2JSZWlEcVJDQ0xIdEhCTUFacVc5VTM5?=
 =?utf-8?B?NkdDSFlZb1JQcEFQYkNNQit0QkdBL21oWmhFYTZ1cTdIb0JDVUQzTEZSSm8z?=
 =?utf-8?B?TDRPNFFhajgrYTBVajNEZVdnUVVKSFI2S2JKQVRraHE5ZWJwYitETjRQQTJ2?=
 =?utf-8?B?NXdvdE4xRG1OLzBRZFBRbE0wWWtLZEpvVnNPaGcxVWV6RjBBVGdGay96YnR1?=
 =?utf-8?Q?1HU5kl3CpJ8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmppNGNmT3lnSHhSVkR4bW1JaVZMbXJ5RDVOZ0dxWXBOZ3BGa0laODFDSXlF?=
 =?utf-8?B?eXJlVmJFUzY4Z0huemRld3pnZzhicHFsRlF6alVlVUVHREdQbUw4VmdWNXhQ?=
 =?utf-8?B?S3hmMlgvT1hZL1EyMnZmVmExVnZUL0ZTZnV6YU5CYVZrc3lMRGxDblpncGoz?=
 =?utf-8?B?aEtrbmUvZUcvb3RZanB2WlhLVmh3NktWbmJKYnhoSVFVMVYrWG1UZ0V4NUFH?=
 =?utf-8?B?TytsNU1ySjE3amJSZ3pWMkFNTHdsUEZNQjFoWXU5b280djYrTDhrck9mRUhv?=
 =?utf-8?B?MnpGRDhLZmIxenVYVGxrYVlQbHZiOWlaU0lPalVHSlRqa24ybUUzLzd1cy91?=
 =?utf-8?B?T1JCSURQR1o2SFRJNjUxaHNZa1diOVdyY2JGS1VtWnJnSHJVM1pFaUdoZjZm?=
 =?utf-8?B?OFBnczZJR2xiQ2JsbUhIY2Z0anhSOG5lWW1qbjJxNEVDZnZmRnltRHRXOFRB?=
 =?utf-8?B?OTZLL3FVOTNvOWNXQnB6bGxKekRSaDBuSHRESVBWT2FTQ01nOGRoUFByc29L?=
 =?utf-8?B?MkZucEJLWHpIV09rc3BFNU8rSENaUEFuNk1DUkxtZG5ScW44K2hQZG1DZk8w?=
 =?utf-8?B?WmQwK2NQRnMvYU44NFNYa1UyclJyU3dXSUtvTndlRkxycHkrc1F6cUM3SWEy?=
 =?utf-8?B?eTlVNW9jVDdBSTNSa3MxRVZTbjRrQTZSN3B6MWk0MkN5ai9icVBETjVWVU9E?=
 =?utf-8?B?YmFNekZLYmJVcTZ2aUpBRGtSMjhrekcvRW1Za0RnZ21IZE1oelFZeEd2clg5?=
 =?utf-8?B?TXc0TUw3R1F4cGV6dDN0VXNNVXNRLzRFTDRLcFdsTFBBcnE5SURhZk1GcDA0?=
 =?utf-8?B?ckVWb0lwSllsdnJiTHltSU9GRXlaZU5HMnRlY2lOZmJGMFN2eTJVWXdRY0t1?=
 =?utf-8?B?Y1NrZm9OWCtMczVGVkRCcGVTSFlkY0ViRVIvUWkwL09Jak9mWXlocnhSTWpk?=
 =?utf-8?B?OHJIcWdzZVU5ZGh1ZmtPTUM3THdoRG1yYXR6VHlaa0tKU2hjSXY5WmJ0Mkd4?=
 =?utf-8?B?b0RGRnJoV1ZTNnNYWU0vaFRuMWdqMkdpaml5NmpuVGdCanNSQUF1VVd6YnRk?=
 =?utf-8?B?Q3FTNVlSYjluRG90WmRza2t6VlhCTWFRSHN4YnBnRCtLZ0ZLUVlDWTlHMmov?=
 =?utf-8?B?SXlROG90RUp1RUlRR3hsczQvQVpETEtFa2RCS28yKzZzUmtJVk1lZm1ZeWts?=
 =?utf-8?B?TTRGeU9Xa1psVGFGZlJnQTVkcDQ1RitSL2w2MjB1VzMvRkVqK1NmaS8vYzZu?=
 =?utf-8?B?ODBFeUFKVmRJREgrV3FOdk0zOGMzbEtFQms3MjlLNWN5Nm5nZWkrajBnVVJu?=
 =?utf-8?B?SkRWQVZ6ZFRVZG5XeHJlVUw1SnU4cHdId0Y5NzVxNGQ2TmFvT0dsZW41ODhN?=
 =?utf-8?B?aVQ4QitaTFNuT0c5MlNkRS8zckIwS2h0aFVMMXE5R0sxY29jcUh3QjdxSmRU?=
 =?utf-8?B?dmRQYXVoZDZ2ejYxVWk2eE1kNmdVU2J4WXBvSHBNLzd1c1A5L1g1N2VtQnE3?=
 =?utf-8?B?THJjdWdTd0dMbUFpQTVmUGdERWNWcFNQc0x2SmVDRUVWQjFwSnBPZDI4THNP?=
 =?utf-8?B?clR1Z2wxeFRJTFg2aVBDVTBwMlZseTl6NDZjb3Q4dStud2FTRkNqT1N2UDlv?=
 =?utf-8?B?WGxjcUFxU1FGbnN6aENoK25lNGRpZWRXcmxLQjMvSEpZTEpvTVRJbTJZcVg4?=
 =?utf-8?B?WWh2ejFuZUphaFd2UXNFaUcxRGl6UjFidTlqbm9UZ0ZmZTg4Qy9wRnBCMXEy?=
 =?utf-8?B?TEpzSnBreEtLVHg2ckJkUGxxSkQvekM3YlJRMDBPZk1oc3FkNlE3UWRCTGpZ?=
 =?utf-8?B?dWF6UmVHT3dMMUlwTmJJcC9mKzc0U3c2NlFVMWR2NWxMbHVHUTVrdW1yLy9u?=
 =?utf-8?B?TVFwUGF6WFBwbUlaelBNZU5HVEd5QjRoSGwwTElPZCtJQnRsV1AyU3dtRTg4?=
 =?utf-8?B?NFNyVUJDc0JadjNhbWJCcmQ1REFtTzRPd09DNFpKN0pFcVEwS1F3Rk9BbmU3?=
 =?utf-8?B?T0ExcFl6VldtMVRxRFFFK04wWnNZbUd0VkZINEtYTWZxV3JlK25FZ1lTMS9O?=
 =?utf-8?B?blJuaGpEakoxb29GSW1nNHVJcndJNzJxalRFamRzdk9Fd2pRV2U5ZW16U0Jr?=
 =?utf-8?Q?iXyNdV2kVkcjHtqZm1szlkK3V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c109e8b5-5f60-4841-9123-08dd897a5d15
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 13:07:59.9334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: toa0zSKZR9qG5qH16HcJgQ8MmO/Ng7IQqK08XhRLViVUTgI6QuEuh1F0hajyPIkx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192
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

On 4/9/25 07:48, Arunpravin Paneer Selvam wrote:
> Fix lockdep warnings.
> 
> [  +0.000024] WARNING: CPU: 10 PID: 1909 at drivers/gpu/drm/drm_syncobj.c:456 drm_syncobj_find_fence+0x58c/0x6e0
> [  +0.000519] CPU: 10 UID: 1000 PID: 1909 Comm: gnome-shel:cs0 Tainted: G        W  OE      6.12.0+ #18
> [  +0.000008] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [  +0.000004] Hardware name: ASUS System Product Name/TUF GAMING B650-PLUS, BIOS 3072 12/20/2024
> [  +0.000004] RIP: 0010:drm_syncobj_find_fence+0x58c/0x6e0
> [  +0.000006] RSP: 0018:ffff88846d9ef680 EFLAGS: 00010202
> [  +0.000008] RAX: 0000000000000000 RBX: 0000000000001388 RCX: 0000000000000001
> [  +0.000004] RDX: 1ffff1108f5ad1da RSI: 0000000000000001 RDI: ffff88847ad68ed0
> [  +0.000005] RBP: ffff88846d9ef770 R08: 0000000000000000 R09: 0000000000000000
> [  +0.000004] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88847ad68000
> [  +0.000004] R13: 0000000000000002 R14: ffff888149353d00 R15: 000000000000000f
> [  +0.000005] FS:  00007269977fe6c0(0000) GS:ffff888409500000(0000) knlGS:0000000000000000
> [  +0.000005] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000004] CR2: 0000643a866b50d0 CR3: 0000000469eb2000 CR4: 0000000000f50ef0
> [  +0.000005] PKRU: 55555554
> [  +0.000004] Call Trace:
> [  +0.000004]  <TASK>
> [  +0.000005]  ? show_regs+0x6c/0x80
> [  +0.000010]  ? __warn+0xd2/0x2d0
> [  +0.000008]  ? drm_syncobj_find_fence+0x58c/0x6e0
> [  +0.000009]  ? report_bug+0x282/0x2f0
> [  +0.000014]  ? handle_bug+0x6e/0xc0
> [  +0.000008]  ? exc_invalid_op+0x18/0x50
> [  +0.000007]  ? asm_exc_invalid_op+0x1b/0x20
> [  +0.000020]  ? drm_syncobj_find_fence+0x58c/0x6e0
> [  +0.000012]  ? __pfx_drm_syncobj_find_fence+0x10/0x10
> [  +0.000012]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000006]  ? lock_is_held_type+0xa3/0x130
> [  +0.000016]  amdgpu_userq_wait_ioctl+0x92d/0x2200 [amdgpu]
> [  +0.000257]  ? amdgpu_userq_wait_ioctl+0x92d/0x2200 [amdgpu]
> [  +0.000180]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000006]  ? __lock_acquire+0x1b19/0x69c0
> [  +0.000022]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
> [  +0.000179]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000006]  ? __kasan_check_read+0x11/0x20
> [  +0.000007]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? mark_lock+0xfd/0x17c0
> [  +0.000012]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? lock_acquire.part.0+0x116/0x360
> [  +0.000006]  ? drm_dev_enter+0x51/0x190
> [  +0.000008]  ? __pfx___lock_acquire+0x10/0x10
> [  +0.000008]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? find_held_lock+0x36/0x140
> [  +0.000021]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? lock_acquire+0x7c/0xc0
> [  +0.000005]  ? drm_dev_enter+0x51/0x190
> [  +0.000027]  drm_ioctl_kernel+0x18b/0x330
> [  +0.000008]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
> [  +0.000181]  ? __pfx_drm_ioctl_kernel+0x10/0x10
> [  +0.000005]  ? lock_acquire+0x7c/0xc0
> [  +0.000009]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? __kasan_check_write+0x14/0x30
> [  +0.000005]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000010]  drm_ioctl+0x589/0xd00
> [  +0.000006]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000006]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
> [  +0.000187]  ? __pfx_drm_ioctl+0x10/0x10
> [  +0.000007]  ? __pm_runtime_resume+0x80/0x110
> [  +0.000021]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? trace_hardirqs_on+0x53/0x60
> [  +0.000007]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? _raw_spin_unlock_irqrestore+0x51/0x80
> [  +0.000013]  amdgpu_drm_ioctl+0xd2/0x1c0 [amdgpu]
> [  +0.000182]  __x64_sys_ioctl+0x13a/0x1c0
> [  +0.000012]  x64_sys_call+0x11ad/0x25f0
> [  +0.000007]  do_syscall_64+0x91/0x180
> [  +0.000007]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? do_syscall_64+0x9d/0x180
> [  +0.000005]  ? syscall_exit_to_user_mode+0x95/0x260
> [  +0.000008]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? do_syscall_64+0x9d/0x180
> [  +0.000009]  ? __pfx___do_sys_prctl+0x10/0x10
> [  +0.000012]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000009]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000007]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? syscall_exit_to_user_mode+0x95/0x260
> [  +0.000008]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? do_syscall_64+0x9d/0x180
> [  +0.000009]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000009]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000007]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? irqentry_exit_to_user_mode+0x8b/0x260
> [  +0.000007]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? irqentry_exit+0x77/0xb0
> [  +0.000005]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? exc_page_fault+0x93/0x150
> [  +0.000009]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  +0.000005] RIP: 0033:0x7269b0324ded
> [  +0.000006] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
> [  +0.000005] RSP: 002b:00007269977fc9b0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [  +0.000008] RAX: ffffffffffffffda RBX: 00007269977fcb00 RCX: 00007269b0324ded
> [  +0.000004] RDX: 00007269977fcb00 RSI: 00000000c0406458 RDI: 000000000000000d
> [  +0.000004] RBP: 00007269977fca00 R08: 00007269977fcc1c R09: 0000000000000000
> [  +0.000005] R10: 000000000000000f R11: 0000000000000246 R12: 000000000000000d
> [  +0.000004] R13: 00005bce7c309a50 R14: 00007269977fca30 R15: 0000000000000000
> [  +0.000021]  </TASK>
> [  +0.000005] irq event stamp: 1359
> [  +0.000004] hardirqs last  enabled at (1365): [<ffffffffaa8693a9>] __up_console_sem+0x79/0xa0
> [  +0.000007] hardirqs last disabled at (1370): [<ffffffffaa86938e>] __up_console_sem+0x5e/0xa0
> [  +0.000005] softirqs last  enabled at (756): [<ffffffffaa67377e>] __irq_exit_rcu+0x17e/0x1d0
> [  +0.000006] softirqs last disabled at (749): [<ffffffffaa67377e>] __irq_exit_rcu+0x17e/0x1d0
> [  +0.000005] ---[ end trace 0000000000000000 ]---
> 
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 116 +++++++++++-------
>  1 file changed, 69 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index d5b35b5df527..c5de39a8ff98 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -395,6 +395,43 @@ static void amdgpu_userq_fence_cleanup(struct dma_fence *fence)
>  	dma_fence_put(fence);
>  }
>  
> +static int amdgpu_userq_exec_lock(struct drm_exec *exec, u32 flags,
> +				  struct drm_gem_object **rgobj,
> +				  struct drm_gem_object **wgobj,
> +				  u32 num_read_handles,
> +				  u32 num_write_handles,
> +				  unsigned int num_fences)
num_fences should always be 1 if I'm not completely mistaken.

> +{
> +	int r;
> +
> +	if (!exec | !rgobj | !wgobj)
> +		return -EINVAL;
> +
> +	drm_exec_init(exec, flags,
> +		      (num_read_handles + num_write_handles));
> +
> +	/* Lock all BOs with retry handling */
> +	drm_exec_until_all_locked(exec) {
> +		r = drm_exec_prepare_array(exec, rgobj, num_read_handles, num_fences);
> +		drm_exec_retry_on_contention(exec);
> +		if (r)
> +			drm_exec_fini(exec);

Don't call drm_exec_fini() here. Rather just return the error.

> +
> +		r = drm_exec_prepare_array(exec, wgobj, num_write_handles, num_fences);
> +		drm_exec_retry_on_contention(exec);
> +		if (r)
> +			drm_exec_fini(exec);
Same here.

> +	}
> +
> +	return r;
> +}
> +
> +static void amdgpu_userq_exec_unlock(struct drm_exec *exec)
> +{
> +	if (exec)
> +		drm_exec_fini(exec);
> +}
> +
That looks superflous. Just call drm_exec_fini() in the caller.

Regards,
Christian.

>  int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  			      struct drm_file *filp)
>  {
> @@ -511,24 +548,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  	queue->last_fence = dma_fence_get(fence);
>  	mutex_unlock(&userq_mgr->userq_mutex);
>  
> -	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> -		      (num_read_bo_handles + num_write_bo_handles));
> -
> -	/* Lock all BOs with retry handling */
> -	drm_exec_until_all_locked(&exec) {
> -		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
> -		drm_exec_retry_on_contention(&exec);
> -		if (r) {
> -			amdgpu_userq_fence_cleanup(fence);
> -			goto exec_fini;
> -		}
> -
> -		r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
> -		drm_exec_retry_on_contention(&exec);
> -		if (r) {
> -			amdgpu_userq_fence_cleanup(fence);
> -			goto exec_fini;
> -		}
> +	r = amdgpu_userq_exec_lock(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> +				   gobj_read, gobj_write,
> +				   num_read_bo_handles,
> +				   num_write_bo_handles,
> +				   1);
> +	if (r) {
> +		amdgpu_userq_fence_cleanup(fence);
> +		goto put_gobj_write;
>  	}
>  
>  	for (i = 0; i < num_read_bo_handles; i++) {
> @@ -546,6 +573,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  		dma_resv_add_fence(gobj_write[i]->resv, fence,
>  				   DMA_RESV_USAGE_WRITE);
>  	}
> +	amdgpu_userq_exec_unlock(&exec);
>  
>  	/* Add the created fence to syncobj/BO's */
>  	for (i = 0; i < num_syncobj_handles; i++)
> @@ -554,8 +582,6 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  	/* drop the reference acquired in fence creation function */
>  	dma_fence_put(fence);
>  
> -exec_fini:
> -	drm_exec_fini(&exec);
>  put_gobj_write:
>  	while (wentry-- > 0)
>  		drm_gem_object_put(gobj_write[wentry]);
> @@ -666,26 +692,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  		}
>  	}
>  
> -	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> -		      (num_read_bo_handles + num_write_bo_handles));
> -
> -	/* Lock all BOs with retry handling */
> -	drm_exec_until_all_locked(&exec) {
> -		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
> -		drm_exec_retry_on_contention(&exec);
> -		if (r) {
> -			drm_exec_fini(&exec);
> -			goto put_gobj_write;
> -		}
> -
> -		r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
> -		drm_exec_retry_on_contention(&exec);
> -		if (r) {
> -			drm_exec_fini(&exec);
> -			goto put_gobj_write;
> -		}
> -	}
> -
>  	if (!wait_info->num_fences) {
>  		if (num_points) {
>  			struct dma_fence_unwrap iter;
> @@ -698,7 +704,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
>  							   &fence);
>  				if (r)
> -					goto exec_fini;
> +					goto put_gobj_write;
>  
>  				dma_fence_unwrap_for_each(f, &iter, fence)
>  					num_fences++;
> @@ -716,12 +722,20 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
>  						   &fence);
>  			if (r)
> -				goto exec_fini;
> +				goto put_gobj_write;
>  
>  			num_fences++;
>  			dma_fence_put(fence);
>  		}
>  
> +		r = amdgpu_userq_exec_lock(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> +					   gobj_read, gobj_write,
> +					   num_read_bo_handles,
> +					   num_write_bo_handles,
> +					   1);
> +		if (r)
> +			goto put_gobj_write;
> +
>  		/* Count GEM objects fence */
>  		for (i = 0; i < num_read_bo_handles; i++) {
>  			struct dma_resv_iter resv_cursor;
> @@ -740,7 +754,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  						DMA_RESV_USAGE_WRITE, fence)
>  				num_fences++;
>  		}
> -
> +		amdgpu_userq_exec_unlock(&exec);
>  		/*
>  		 * Passing num_fences = 0 means that userspace doesn't want to
>  		 * retrieve userq_fence_info. If num_fences = 0 we skip filling
> @@ -753,7 +767,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  		fence_info = kmalloc_array(wait_info->num_fences, sizeof(*fence_info), GFP_KERNEL);
>  		if (!fence_info) {
>  			r = -ENOMEM;
> -			goto exec_fini;
> +			goto put_gobj_write;
>  		}
>  
>  		/* Array of fences */
> @@ -763,6 +777,14 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  			goto free_fence_info;
>  		}
>  
> +		r = amdgpu_userq_exec_lock(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> +					   gobj_read, gobj_write,
> +					   num_read_bo_handles,
> +					   num_write_bo_handles,
> +					   1);
> +		if (r)
> +			goto free_fences;
> +
>  		/* Retrieve GEM read objects fence */
>  		for (i = 0; i < num_read_bo_handles; i++) {
>  			struct dma_resv_iter resv_cursor;
> @@ -772,6 +794,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  						DMA_RESV_USAGE_READ, fence) {
>  				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
>  					r = -EINVAL;
> +					amdgpu_userq_exec_unlock(&exec);
>  					goto free_fences;
>  				}
>  
> @@ -789,6 +812,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  						DMA_RESV_USAGE_WRITE, fence) {
>  				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
>  					r = -EINVAL;
> +					amdgpu_userq_exec_unlock(&exec);
>  					goto free_fences;
>  				}
>  
> @@ -796,6 +820,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  				dma_fence_get(fence);
>  			}
>  		}
> +		amdgpu_userq_exec_unlock(&exec);
>  
>  		if (num_points) {
>  			struct dma_fence_unwrap iter;
> @@ -901,7 +926,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  		kfree(fence_info);
>  	}
>  
> -	drm_exec_fini(&exec);
>  	for (i = 0; i < num_read_bo_handles; i++)
>  		drm_gem_object_put(gobj_read[i]);
>  	kfree(gobj_read);
> @@ -924,8 +948,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  	kfree(fences);
>  free_fence_info:
>  	kfree(fence_info);
> -exec_fini:
> -	drm_exec_fini(&exec);
>  put_gobj_write:
>  	while (wentry-- > 0)
>  		drm_gem_object_put(gobj_write[wentry]);

