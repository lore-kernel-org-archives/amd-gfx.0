Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BBBC19F2E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 14:25:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A47CE10EB08;
	Thu, 27 Feb 2025 14:25:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ar4Oo5Yr";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4587E10EB08
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 14:25:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udVS5LjJNjg31lAM06JhYHUCeE1zKzGJXm41UaLtwYY/XuI1zQdnl/mi9l3iZfRYHTAh4IqshrCtS5GfErK7BIxVFipQ2KpYytNZfhtZCvggYoXY3wiKjg9pu3YjVWaFYyy6L531K1BkBs0oF9truoZruNmHDAYsgj+Mkig18Iivz2EArdk2amhbzyKf9Fblzmff9tNxOLVNKdSlvu1eONGcRrsjkVF57WR1GR3gLLEbwkwjypaViR7c+KvPm+3MLeBhEOfOX+6GiJakXds/p0fOK+WrTEaN7tM0rgDBC2w858vsz03/qnTppXPz6YeH72pM4uM+t1IYFd98Io0Few==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fM3PJ64zyPM+MmdiVjcl5eVOaeZ1WXJpWykS5Wi1pq8=;
 b=bM23E0l/beEnG63ngVs7qQcazcQlcwZEkaSOmjKlBPkREU4SqpNMGsnn6gaNJqJJwIxJNz6FR0GYdv+22BECOKdGJdhUj656CN6W3n9yaaIouhXjQuc1BBXFr0STDd/NJ60veFrFBcEFfXiwzRRJBDJh76BUmeeZiIvwVT8/OFMRzRMK3D6Mv4Tkok4nhFg3at8YWV80NS/dRznPWk9INTlkTnJ1dggxGVQww5DyidTKrZUkSH1P3gXZBFzDEzMeoKzHINmzVOpZPcEbFYkORhJbm/w82ppN/DZyl50HGm/osOEw5glzp+q/e+AbBcV5uS8V++Jmf/SkGZNQ15giNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fM3PJ64zyPM+MmdiVjcl5eVOaeZ1WXJpWykS5Wi1pq8=;
 b=ar4Oo5YrBfgo5mXbkAFjkRQCiLGwxwaLoiPZ+EEtwB2KQ06nf0ujNIvtbE44d/44alfQWGYr0Zq1o9xk4DcVOmLWR3f79Mvdtz3JmbXsLBdi+LcSuLcd8PWaD8ZPnoEjhEeyAGztbQjl6zRSoZRwp6ftpNVKvspYadSZCHJpdZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 14:25:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 14:25:29 +0000
Message-ID: <b453f96c-ec53-48cc-9179-7dd70012c561@amd.com>
Date: Thu, 27 Feb 2025 15:25:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: fix the memleak caused by fence not
 released
To: Arvind Yadav <Arvind.Yadav@amd.com>, shashank.sharma@amd.com
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 sunil.khatri@amd.com, Le Ma <le.ma@amd.com>
References: <20250218145322.1500-1-Arvind.Yadav@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250218145322.1500-1-Arvind.Yadav@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: 141e533f-e532-48e1-ae8b-08dd573a95b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnRCbVJiNWVmZUozR0doZklkd3hReGFzcG05b1RkSHlRZlVqVXQvOFVzV2Ry?=
 =?utf-8?B?dUF3ZFB3c0pGSnF2a3ZCMHRPSTVMOWpFa05qRjZFWmMxVjRxRzltTHBJK3dj?=
 =?utf-8?B?UHhSVmNjUHZUdWxQQ05GdlFCNGxvS1pkQ2paTDlra3QvM1gwSVR3MVczV0Qr?=
 =?utf-8?B?WS9DS2FTSW9uT0M4YUdxMjVhOEgvYlJrQzhuVWI3S3ljMnVhTnM5NWVzUUJh?=
 =?utf-8?B?RTBCZGFkbFJIdFJvbXNKTlhRTHRFcGFXNlNMT1IxY0ZVTW5QSitBUW5GOVhO?=
 =?utf-8?B?a0oyUDNIWGwzVkNWcEpkMXpHOU1sb0tMUHNPMUlaTFFBMU54aFJkWWRtellD?=
 =?utf-8?B?dnZjd0NmdkxmZkJiY08zZUh1YUtTYTdkcjd6WXIvZWM0TVJPNXpyNEdIUys3?=
 =?utf-8?B?TkoyYlg1RjlYUFNLeFNnbzkvYm5HWEFYWUJEaHBETENUZnY0S1FzYnJYNExy?=
 =?utf-8?B?Z3g2M2pNRTJXUjE3c2hlWkIvTk1BUWZhOVhEdW5KYThXR1lrQjkzRm5GOU04?=
 =?utf-8?B?QVBaTjd1RFE4MG1GL3BTRzlHSERYZW90SkpYOGVBc0RNZEdKS1BHV1F5WDlt?=
 =?utf-8?B?YlRvVnBFNzNOYThBcjZ2RnNZRGpvaE16VW9heVdXT0k1UW00eW42d3dPVlU1?=
 =?utf-8?B?em5ObEVFS1hDa2hPRDE4a0MxNUFONjduS1g3T3JmRkgrbXMzREZiVkM3UTA0?=
 =?utf-8?B?Q1F1LzFxK2JaSERTRHJkZFlhaVhyN1BwV0M4ZDEvdlVwQmluVmVxMS9wdGR2?=
 =?utf-8?B?aXpsM1BmQ0NHdGhoY2dLc2pKNzI1YnF4VmZhdkd2WHBuWnhKUDN6TzdFdzVU?=
 =?utf-8?B?Rkx3TmRDTnFhTWlJVERQTDlWOWFsRW41K2dGY3V5ZG11VHRQTlcxVEp4dlpl?=
 =?utf-8?B?Y0RpdUJNYjE5MGNCU1NScmRXRkR5Ly9Xd3JEb211dlZTVXUvNFhvYVMwYmx3?=
 =?utf-8?B?Y05RZUp2WkZ3ekU0bHh6ZjhqTHR3SGY2c1RVVGl5Qit3OFBsK0FLM01YT0dS?=
 =?utf-8?B?b094d1VKOW9lbEdGOEpWM1FPZ1pGNjRFZmYxN1lUcUZxN1NueHhBMnpxU1BL?=
 =?utf-8?B?L01MODZ3cHhLVkdXMStmVys2TGlkN1VkYUI5S0NaalBRTkh5WWt5YlNBN1pY?=
 =?utf-8?B?Z1J3Rk41Z3lOU200YytmdFVwUnY4aStLSWYwNUs1cDJVcStPWFphZ21OY3dv?=
 =?utf-8?B?N0pmUHJqZEhGZGZqQ1BUN3FmbjZmQ1pLdklPZ0c3MVo0SnBMbzA2VC9hRkZU?=
 =?utf-8?B?OWx3MENnVEZFaFdLMmhlRWxQdm9aeHpmZUZvV0RjeUJpSzJDSzZLSU9kV0hO?=
 =?utf-8?B?WjNMREF6Wnc1M245ZFFrRUlRVnBtbit1b0Y0NVY2MXh6VEYxa1VsM1g2WUFG?=
 =?utf-8?B?Vi9RVTI4QnBXMWROYTlVUzZWQ2ZscEViOUZnTzgxdHMwVkhMZG5wNGFBaG5a?=
 =?utf-8?B?SENXWFdCWWNyQ2hKd3IzRGlmcXVMV0kyZnJ5NENHUytWNHNtVTZFZWxPOGYz?=
 =?utf-8?B?bDU1OTF2Z2xUNGJVRTlqYVVLdmN0T3M0SUdRcWdyd0RRaUlZOVVuNDZ6bXhk?=
 =?utf-8?B?RzNMS0xlS0htTVVMN0ZVY3V4YURMYWVLV2JkcGZyQnV1aGd2VDZrYWpyeVZa?=
 =?utf-8?B?OGlINmVDeU83OGlUc2NXVG1RQk1QckJsd0NvSnFrU09jUW9TV1VGUHBhVGlP?=
 =?utf-8?B?K0M4bWVlTXM5bDdwVmhlak1yVGtKTTljM0VqWkxwbnNzdXpTMTduTDI2YWd5?=
 =?utf-8?B?UXY2bk1RZDRrUytURnhCZkIvWHpZUFNycU1MeXBDM0F2cTZvZGlIS1gwMHAv?=
 =?utf-8?B?anRReVJITXNvRWdPRlgwQnZZelljVDVPOXhuNUU0NVBmVG5jMFJyWjBCZlcy?=
 =?utf-8?Q?cPax9hJag7YNU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXJMSEo1cEllc0g2Q1NSK3BIc1ZSSlFWU1pJT2dLdWJLRVZGQkd5aU9PQnhH?=
 =?utf-8?B?QTljV25QZFMvNUo4VXdRbUJPRzNIVStOV000VkxNTHBjWDVxY0xFcXI0czVC?=
 =?utf-8?B?Q1dxWkZJTWR0MzhOYTV3OVlsNzR3RzlscktzS0tGRFdUUGV3R2UvaVVrOWlP?=
 =?utf-8?B?Y1FSOWlwd0NOcHJKYk5Rd2tEcThFbjVna0VLTWZmNmZpWEdENXkyOEppekJR?=
 =?utf-8?B?NkEwQTcrNTh5ZVRYejBGVHFueUVGSDJqWHhhNzZ3Mk9SRlVtR2ZjMks2QnRR?=
 =?utf-8?B?Q2puckRlZDg1dWRhQmRIQnZRTk8xVGUzQlU4Qm5JeTBDRVJsWDd5Y3RvVGN3?=
 =?utf-8?B?UWpnSjVTRDFLWFE3VGdGcEVubEp0UW56ZFpjWWJDYlJFay8xSjdySGVjMExx?=
 =?utf-8?B?SXU2ZXRVUGN5UGROZ1V3dEtoNmV2dWIvcDhTcU9NWUkyMDZuTStoZTNGaGNQ?=
 =?utf-8?B?MGtmVURoWm9IcGl0RHZWZGQxbmprMmkvUVNVeEhURENNN29sN2o3aXN5aG9D?=
 =?utf-8?B?ZWcwZGI0cXFGWGR5bkhGRjRJQXNQYlh4UU9NOEg2M3BHcmZqMTBZbVFkK3lQ?=
 =?utf-8?B?WkNwbnBQL2RKdm5XYUpFS1RlNkRtZ0pwbE1DekVQYWtOdTByckdEV2pVa1d2?=
 =?utf-8?B?Z3dsVmc5TGh5VTVLcVdSeHBuSnVRZjBXaW5QQ09OaFNKcllhdTB5QzdJN0Zo?=
 =?utf-8?B?bDd3SUthYzlmbFBKMEdtaVBKTHNSKzR3YVBoT3IvR3NQRVl1aUlqQXkvc0lX?=
 =?utf-8?B?N0haMCtyQm50NE1vM1NqQWJEN3JEMm96L1doNnk1aGI0ckxxcmZFWlVyYllv?=
 =?utf-8?B?ZGpCSjRiVHRuYWtKRDhkK3BXVk45SWc5SVB4MVdlNEE5OGNtTzJYSU43MFIy?=
 =?utf-8?B?NjV1VmhiQ1h4bFo4WlNyeW4ybmltK2xGaXArWk93QU45a3NxakxnMmViaUls?=
 =?utf-8?B?TVcxUjMzajUxVVJCK0xUT2tKUytzK09FVjhRUjdrcGdyT1FjaXkwdlRLZXlR?=
 =?utf-8?B?RjYyWEtjVk1qM3NFVmM2MUQzRHh4VUxkdnBhQ2djS1FFcVVFOUFGWGwxaVZD?=
 =?utf-8?B?NVZFdW82Y29LTlFabUxrWldkZ2ljUEdySmprNElXdW1pYll3Ri9XWEV1bUMr?=
 =?utf-8?B?ZlVhVitBd1o2SXZzSmtFUld4cHlDZnZ0aENUZEZxYjNBTU9tay9lVUpYVXVm?=
 =?utf-8?B?ZUVJSGk5UUtWcWVNR2hOUmhTeGR5RmlMVDFjMHFLMTMwdVptN01XUkNMQlpD?=
 =?utf-8?B?YUZjZU4xRURRdWF1NkQ3YXd0cE9ERnF6Vmc2b0NmTWY3dDRKRzJ1TTBPSjMr?=
 =?utf-8?B?TDNGUjVjdFFqeUlCZ3lBekk3WVkwVnljSlhVSE5GMkNyMVVoSDNEMTBQTVE2?=
 =?utf-8?B?VllYdFNoT2NCNTdhb0NSZjVSV0lqajlhU1ZrRlRvZHRDMnRUTUI5T1h5RVd1?=
 =?utf-8?B?V2FoUzZ0QisxSzVjcTB3YW1reklpYzVuVk8yQkN0a3dUR1BsKytPZVhScjRY?=
 =?utf-8?B?dTZCVi8zeVFrZ3ZJOXd2cldXSjYvS2U5ZndFV2VKenczajRDekVkUE1CSWhQ?=
 =?utf-8?B?c0VkQzRSK0pVQTFqQU9YN0dpRHdUN2hkWEF4bFVXMUxQK0g2SEd4Z2dWKyts?=
 =?utf-8?B?V2JPWU80ZWd6Z0MyZ2Y3akloVzdrVHBTT0l2VzBYUFlkMVcvTlJHY0QzNmZF?=
 =?utf-8?B?T2tESEZKNXRvWXlQWVlEQjg4cVRDcjJGWVl5eHlCK0NlMFZLNGdBYjZkdXhV?=
 =?utf-8?B?UGhaekRuWGEwWERSd2IzVmExczc3NW5WV1dwWTNyNDlBTitjSEk4UmZpWWdR?=
 =?utf-8?B?M0xDc09XYzBBYjQzVlFyek02a2Vha1llMFlUcGJBZnZEdy9DdU5Ua2F2TnFS?=
 =?utf-8?B?eU9PU2hVQ3V6ai9mOE5OZU9Tei96akRnbFhXRHFXNldyaDI1MmJpOWpCRXE4?=
 =?utf-8?B?YjJpWmFaK2ZaWlVrL2ZFRWI5UVVaNnNFazNKeVg4WFdHSTBLK01IVk9SR3dm?=
 =?utf-8?B?TzcvWWllbVNHd2RDTytycnFGL3lsc0pjdU9tQW5mb3E1cmtVYUw3N2UyZ0c0?=
 =?utf-8?B?dXRxTmZnd25xVk1JcE5jaEhTTGxuZDVFVm1PUHBEQ1ZyamMyREgvZHBRNlFQ?=
 =?utf-8?Q?u9bv6lfxFh1C6rHupu2bpYkk4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 141e533f-e532-48e1-ae8b-08dd573a95b4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 14:25:28.9875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8E4pWoXi/tQollCeP6kZ8thsZbTTKA7QmlM06tvsaP8mg7pkhRGbE2FlrhPZpHgR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199
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



Am 18.02.25 um 15:53 schrieb Arvind Yadav:
> Encountering a taint issue during the unloading of gpu_sched
> due to the fence not being released/put. In this context,
> amdgpu_vm_clear_freed is responsible for creating a job to
> update the page table (PT). It allocates kmem_cache for
> drm_sched_fence and returns the finished fence associated
> with job->base.s_fence. In case of Usermode queue this finished
> fence is added to the timeline sync object through
> amdgpu_gem_update_bo_mapping, which is utilized by user
> space to ensure the completion of the PT update.
>
> [  508.900587] =============================================================================
> [  508.900605] BUG drm_sched_fence (Tainted: G                 N): Objects remaining in drm_sched_fence on __kmem_cache_shutdown()
> [  508.900617] -----------------------------------------------------------------------------
>
> [  508.900627] Slab 0xffffe0cc04548780 objects=32 used=2 fp=0xffff8ea81521f000 flags=0x17ffffc0000240(workingset|head|node=0|zone=2|lastcpupid=0x1fffff)
> [  508.900645] CPU: 3 UID: 0 PID: 2337 Comm: rmmod Tainted: G                 N 6.12.0+ #1
> [  508.900651] Tainted: [N]=TEST
> [  508.900653] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE/X570 AORUS ELITE, BIOS F34 06/10/2021
> [  508.900656] Call Trace:
> [  508.900659]  <TASK>
> [  508.900665]  dump_stack_lvl+0x70/0x90
> [  508.900674]  dump_stack+0x14/0x20
> [  508.900678]  slab_err+0xcb/0x110
> [  508.900687]  ? srso_return_thunk+0x5/0x5f
> [  508.900692]  ? try_to_grab_pending+0xd3/0x1d0
> [  508.900697]  ? srso_return_thunk+0x5/0x5f
> [  508.900701]  ? mutex_lock+0x17/0x50
> [  508.900708]  __kmem_cache_shutdown+0x144/0x2d0
> [  508.900713]  ? flush_rcu_work+0x50/0x60
> [  508.900719]  kmem_cache_destroy+0x46/0x1f0
> [  508.900728]  drm_sched_fence_slab_fini+0x19/0x970 [gpu_sched]
> [  508.900736]  __do_sys_delete_module.constprop.0+0x184/0x320
> [  508.900744]  ? srso_return_thunk+0x5/0x5f
> [  508.900747]  ? debug_smp_processor_id+0x1b/0x30
> [  508.900754]  __x64_sys_delete_module+0x16/0x20
> [  508.900758]  x64_sys_call+0xdf/0x20d0
> [  508.900763]  do_syscall_64+0x51/0x120
> [  508.900769]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> v2: call dma_fence_put in amdgpu_gem_va_update_vm
> v3: Addressed review comments from Christian.
>     - calling amdgpu_gem_update_timeline_node before switch.
>     - puting a dma_fence in case of error or !timeline_syncobj.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Shashank Sharma <shashank.sharma@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Le Ma <le.ma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 33 +++++++++++++------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 8b67aae6c2fe..40522b4f331b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -125,9 +125,6 @@ amdgpu_gem_update_bo_mapping(struct drm_file *filp,
>  	struct amdgpu_vm *vm = &fpriv->vm;
>  	struct dma_fence *last_update;
>  
> -	if (!syncobj)
> -		return;
> -
>  	/* Find the last update fence */
>  	switch (operation) {
>  	case AMDGPU_VA_OP_MAP:
> @@ -839,6 +836,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  	struct drm_exec exec;
>  	uint64_t va_flags;
>  	uint64_t vm_size;
> +	int syncobj_status;
>  	int r = 0;
>  
>  	if (args->va_address < AMDGPU_VA_RESERVED_BOTTOM) {
> @@ -931,6 +929,12 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  		bo_va = NULL;
>  	}
>  
> +	syncobj_status = amdgpu_gem_update_timeline_node(filp,
> +					args->vm_timeline_syncobj_out,
> +					args->vm_timeline_point,
> +					&timeline_syncobj,
> +					&timeline_chain);
> +

You don't need syncobj_status here, just assign the return value to r and abort if we can't find any syncobj.

>  	switch (args->operation) {
>  	case AMDGPU_VA_OP_MAP:
>  		va_flags = amdgpu_gem_va_map_flags(adev, args->flags);
> @@ -957,22 +961,19 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  		break;
>  	}
>  	if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && !adev->debug_vm) {
> -
> -		r = amdgpu_gem_update_timeline_node(filp,
> -						    args->vm_timeline_syncobj_out,
> -						    args->vm_timeline_point,
> -						    &timeline_syncobj,
> -						    &timeline_chain);
> -
>  		fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
>  						args->operation);
>  
> -		if (!r)
> -			amdgpu_gem_update_bo_mapping(filp, bo_va,
> -						     args->operation,
> -						     args->vm_timeline_point,
> -						     fence, timeline_syncobj,
> -						     timeline_chain);
> +		if (syncobj_status || !timeline_syncobj) {
> +			dma_fence_put(fence);
> +			goto error;
> +		}

That should probably be something like this:

if (timeline_syncobj)
    amdgpu_gem_update_bo_mapping(..);
else
    dma_fence_put(fence);

Regards,
Christian.

> +
> +		amdgpu_gem_update_bo_mapping(filp, bo_va,
> +					     args->operation,
> +					     args->vm_timeline_point,
> +					     fence, timeline_syncobj,
> +					     timeline_chain);
>  	}
>  
>  error:

