Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE01C28B23
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 15:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F9DA10EBD0;
	Fri,  7 Mar 2025 15:23:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zdfb2Ppb";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A88D10EBD0
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 15:23:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=laxi8KBWUDFeoP9efor/bYl4fZJkbzmOypbp9YOZJZCUDXI9xsvZzqnH774KWSak2c9oHgy/EKBLouTlfQVr3mWy2PJpRil5IXdBF2hqnAJxqF/DUu5aPgz3mWUpjsu9JTYB+pWZBXsmzNAtKTDUtTTthImCVC8LFcd23oRkC3eVub0wrafA90DSX6ghi0aJ4iHFJ/zDUuiJEJND9APDOhSTcnqllxUgzXw5JVw1pRxJfm7Cg8sMvuD0+cLF00BjEuUKABoUS27ES0ZkfdVesyVGCdzkca0hgOMvSF2OvNk73bxd1im/b2uBbL9nlzgq8YjT+f6rKfF7u+QtGrSG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCba0zp9o6+VoBXJmOy9J2a0v2/Jd1jueDVFUqy8JkY=;
 b=caLcAu1GXne7XTMvl/AyO6f6HgE31MZ08RZcPxaTNWTUQ532qg+vzz460NR6FDu97TIrDG9JahAYaDiMUCCaph49pvYhWCq3bp8ETuwJlkombUOfOksR6fwP4NWRo9JKE/hrvwkIMC4xrrtw1JOHkkpm8W8ckpjtM1RMzpr2/kQv89r7ujksjB4gz72DhdXW01UFYCsVoTZpH9HUlVWbpqFNqQLmHUfoOUpr1quwILVTFOviKY77oD3G3gZ811rLA6KIqTuQvHsV+akrPmzq1391OB4Nix2lVehPDJUF1yxvnhiSNTcvo04YOvmTCFucdoYvTofLi4i0O2L3euCn2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCba0zp9o6+VoBXJmOy9J2a0v2/Jd1jueDVFUqy8JkY=;
 b=zdfb2PpbJtzOJG1UZCO53mVlwbX2oE1YK2lJeh6//PmhmSyA3i0epWFLhD9jUTMdnF/HA1IqB4bvK9b0f87d/8tjbB4ulQt1z/kuppXWVvDdoVPo1oKWuYI+Qbp7nvB6SBJJY/+Zr1M49b9cRDYo55tVVugDSWs7Ff0cJVIMbms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CY5PR12MB6550.namprd12.prod.outlook.com (2603:10b6:930:42::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 15:23:24 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.8489.028; Fri, 7 Mar 2025
 15:23:24 +0000
Message-ID: <458514e0-78b2-483f-97b2-0686abde0efd@amd.com>
Date: Fri, 7 Mar 2025 10:23:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Keep display off while going into S4
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Xaver Hugl <xaver.hugl@gmail.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
References: <20250306185124.44780-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250306185124.44780-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0092.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::8) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CY5PR12MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: 89f1e08a-f264-452d-a8ba-08dd5d8c009c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHU1UnhCN0Q3TnBLRlNiOFQ1ZllSdmhxMkF2V1RrR1ZoeGYwY1N4aUIwTm9W?=
 =?utf-8?B?S2dISHIwZXhodXdEMzUxRGt1Q2xmc3lVdmhwRVdlYjBUb3hsZ1FvdFh1VWpE?=
 =?utf-8?B?bTZrcnZ4MGlPV1BPcE1QNm9mRTB0SzdoUXZ6bUlkNW10bGFnNms0MzlOdlZP?=
 =?utf-8?B?dDVEc3hWbUtpMzBveEp4RW40VmVYaStqUVBCcFRrZmxBazh6TngrVm9EZzdI?=
 =?utf-8?B?ZnBJWVFoaUhYa0dwTE51YVU4d3BSVFRTb08yeGpWOEVvTkRTOXF2aVNVSmhy?=
 =?utf-8?B?NXVPdHY5ejFKY0E1Qmh6L1Fib2lTeklhaG8vUE9XaEdjSjY3TVdhdmYyR01F?=
 =?utf-8?B?OWZjbU1VTUVhOFBVbFVWbTljS3d4YnkvZndPMm43cUc0SW95SnJsZWlpN2pu?=
 =?utf-8?B?YWdRODVCWG0waHR3aHZlUG5xQUNGbTd5RzFYV2UxclVTc3VuRFlySmZZdmVK?=
 =?utf-8?B?MmJwRUJuNnpQVDdqMmZPUVZSVkpGa0J6bmhvREVEM0UzZkxtQ29iWld3QzV2?=
 =?utf-8?B?K3FkOUZvcjNHVkpOWDV6OGpZUXUrd2ZOQ0NQZ2crTitaeTdlUDJ6ZG5Ob3ZD?=
 =?utf-8?B?SkYwNjFLZ3VTelZYSWo1bWFIZWg3SndUdzNrS2k5YkpzY2wxaDZoVW82ZjlR?=
 =?utf-8?B?YUwyRnZWdUR5NzdNRVVNaTIxaXpaWi9lVUVLTElicTk5V1lGRk9DT1c4dEJI?=
 =?utf-8?B?dEhxd2ZrTVh0NVMrMUlKRTFFLzlPeG1YNVIxNk5veGRveC9RL1VvUnd2blFJ?=
 =?utf-8?B?UzhnY21wN1BCYmJwV2VINERmeXRWRXdwSW1oWlphMTlkU2pLMzlCeTVDZGdW?=
 =?utf-8?B?UHA2aW5rdkIyZlhCcnlTdlcyMW5jdUFhTi94WXlGWE9JMzB3S3hIdTZPWkQv?=
 =?utf-8?B?M2ZMbmdVWERiTzhYL3FUQUN0TE96ejFZTnlVYWU0eW9JejZCckN5eXlVblpM?=
 =?utf-8?B?dGVJSS93M0dBcWczcTJha1BqZmRZQm5WSzBDNmhRVytSVlhVNmpHSTZXYVRS?=
 =?utf-8?B?M0MxZXhSUnRZT1dLamJOcUxvSlcyM0p2RkU5dW5Wa3JOUW1QQ0lGVjJ3VUJs?=
 =?utf-8?B?NG8wSjhzOFJjdGtTek9tTG0wUHVYaFRNR2FmYTNiZzd6cTV5NE9mWVdZV1BG?=
 =?utf-8?B?cHdjcW11NmpVSlVCbmtvVUhDSSthUzdRbno2WEkzZXVDVFZHellxYkd1cnFQ?=
 =?utf-8?B?SjYwZjZWRElOd2hDU0E0Y21aczJQeTB4a2tJU3RkK2l4aDlJd2Q0bE5BNjRO?=
 =?utf-8?B?M1NzbzdRaGVpZUxaK2JuQzBCbElDY01Xd0ppMUROcGgxRDVxTk9UY1hnVjRZ?=
 =?utf-8?B?ZE9FbHdLZE1UU1JnTmhtTHNiVXlqaG9BVCtmQ2ZpTGZrclFpeEY1ZitVRVJU?=
 =?utf-8?B?NjZLaGdwaEV1a2JqRnNKbFFMcjB5djRtQUYrd3pzQ1REbUN5dHgxK0U0NlJq?=
 =?utf-8?B?QzVJbGJSa09Pa0NxQm1qZi96YVpyTFVSejFzSEtCWlE5Wmw2YkhIc3didnhC?=
 =?utf-8?B?RUNpVDF6TmV3ejB1aWlhdGhWY3JtUkhNcjg0b3lMVVVtRFcxK0k0c0YvTWty?=
 =?utf-8?B?enVGRTE1TWFKREJ4RjI3dXc4QzFLT0dvVmNVNmJoU1oxYXRDYXh4UGduVDRz?=
 =?utf-8?B?UlRFNlMwQVBHQ20rcVIvbWFvVXVOZ2xVZExoU2RFREcrV1BuUU1sbTJCaGcw?=
 =?utf-8?B?Z1Nsd0JvSFZJVXNPU0ZJdWtKOUZaU3MyODBTaUI4ays5YVpPT0g5dGNydm4y?=
 =?utf-8?B?WERDY2JXdnF3UTRBREdRcnZlZko4ZlY2V0xDbm1kMFRJWWJtR2ZvbWxmcXJL?=
 =?utf-8?B?dFkrOEpOem5aNTUrTm42dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWJ2YzV0UUhPZkExVENoSmVxalhHdXQ3RnhzVDJMc0IwMmZpU01rVmFuMDlO?=
 =?utf-8?B?Y05pT1QxeHB2VzhUVENSVTVLbFk2M2ZIUkpUb3lCcFR6cXlXWlhoZW5aL3k0?=
 =?utf-8?B?VU9DZnZ5N0g0Z0Z3K2dGK04yZHZNTVJmSjJ0UXJmNVJKQWFRM3JxeVlDWktJ?=
 =?utf-8?B?OUFIWG5QMS9uZkVxL0R2YVVtbVZmTDQwamgxcTQ4aEx2NGQ2TTg0WS9xa2FI?=
 =?utf-8?B?Yzhnck5XcnFGRmZ1MnZlU0p6Snh1NXp4SysvUTBFeWk5b0RUWm1reHFFQUlM?=
 =?utf-8?B?TDFvWjkrR3NBVC96Rm9kWFdUd1VBUCszVFpwb3pKS2dNZi9sTjdxLzVwOWhr?=
 =?utf-8?B?Zm45eFp3ZXMwRlpnVDdqOWVHZ3dObFhRWDVpZ1FjZlJGWjlMS0xQc3l3RE5l?=
 =?utf-8?B?RXU5Um5UR0NaWlJPb0M0aS9Jbm1mUm90MXNucXRtS0dMRlM4azUxbkJvRDRq?=
 =?utf-8?B?aWs4MkREWmtGQmpOVXg4SlZXV2FtZ2hTTUpJTW9ybEh5ZjlObXZORDMvUUxk?=
 =?utf-8?B?NE52bkh6OVFRNVU3OUJZbWFGV0F2WmJGRXNpaE13U21ZNlBBRGZ6MEVjSFh4?=
 =?utf-8?B?cCtxMkw2NDRZdWVWZSt1L3V4S0JKdnZxallFSE9FN24vemtZM0ZWRTBwMmVX?=
 =?utf-8?B?M1JGcThwajJnRnRlNmx0K1A3bkdTSW9nUXdPY1hWL2NNUzdaVUhWRG5VQkw0?=
 =?utf-8?B?RWM2WHFTTU55OHRxZWxhL3BrMDN1eGpFZEE4UG5MQWRzUnFaTTR0Wm1YSjM4?=
 =?utf-8?B?MG5sVGxZQXNnS3g2R3B0b2VNRSsyQXI5VTBEa0g1dU5JYjNzcjVteE9tWkJj?=
 =?utf-8?B?Ulkya3g5K3R4MGpxNlF6cEJEMzJIRVBmWmFycHVzT2FJdnpsaUtRbjM2MUZq?=
 =?utf-8?B?WUJ3K1pPL2t4ZTA2MkJoa01JWkFXSzBNSkxDSmtWQkc0dkpkaHEwT1JPZ09V?=
 =?utf-8?B?ZkcrNnBHdzNPY1Bjd2JkVTR4dW1naXhsUUtOL2Z0N3h3WmhTVjE0M1M1Smx5?=
 =?utf-8?B?V2tRWkJaTXArZmIwaC9TcFJKTlB3TU1GbzZJRXpoTW1kRDhLUldvU0ZCTlVt?=
 =?utf-8?B?ckhOYXJ5ZkV6d2J0R0NJK2JHbnl5YmhBSlBXbHkxTkdmcTNZcWlJOE00Z3V0?=
 =?utf-8?B?Ny84Vll4U1F3L0VZTkxuUXdudUptckdZWWFndThoVUwwd0d5TkJkdUE4SzV1?=
 =?utf-8?B?T3gxUURSaU03aGpaejFNY1dwbzVPUHdCVTdDMG5RRlJibFZVMndTcFdGS2dN?=
 =?utf-8?B?cXRPdE9MbTBQaTMxb1pKNFE2bjRKZFd3KzNyenpZaDJ2MEdyTjZyUXVhTVNn?=
 =?utf-8?B?bW5RTVg1SUdQaDlqVmlnRFZPSUdFaFIvK2l3elNzOWdWRmlnemdjZDFzTkFT?=
 =?utf-8?B?RXlhOHhYTmZRei9kT1g3OEh6SVZHejJpdTVQbXhBWHpOWW50OE9pclRpejMy?=
 =?utf-8?B?cVZ0cHRTQS9oNUJoZVhva01QdkhraURBZWcxMUpoWGlXcmJnU1J4S29RVDl1?=
 =?utf-8?B?OWszcjNGT0JUWWVvQlVuYXIrMDRacmMzazhRcTR0Qm96dHJmdWYwSUpsdmZJ?=
 =?utf-8?B?NnRCMVE5RlpPYStWWVg2YTBwSWdqb3pWQjNJR1FQZHA0S3lOZlNVaFlqT1Ju?=
 =?utf-8?B?MVBCOEo2aGVIa3JVbTNhd2ZPTzhCMjloMzNUOTUrLzNKdkx0dzlXMTVsUU5Y?=
 =?utf-8?B?UjRrYjdna25IY0dRalJ3Q1V5Qm5iQ3lLaVUxU3dCSzBpeUpRREZoYURmbzFD?=
 =?utf-8?B?ZmRxMWhXQXRTM01ENDh3TGtpL21qYWt1dFJEdk1WMGxxdy80Y0ZTaDFiNTNL?=
 =?utf-8?B?SmtObDVja3l3cUtQemxWRXdPYmpaMllnTEp1bi9MenVDK2dDaUwxb0wvS2sz?=
 =?utf-8?B?VVhERkpGT2M1TVRrVzdMaXFlSWFHL0I0RXlZcTQ4SWNjTDJFRnhJdGVwNFpz?=
 =?utf-8?B?cVZzYms5Q2hsaXZUa3JtR3FNR2pIRTZ4NFNnVHlJWDVpdlAzOFRSS3VsTW5W?=
 =?utf-8?B?NUNUeWJxWmZiRUtjc3l5N3VUVGI0NDNLV0dyOUc3dzR0MjZDV0N2dUczNGdx?=
 =?utf-8?B?UE9RYkxWQkdHTVRXSGpYc2JJNitxc01kR3hDbHdrL09tanJFSXh5T0hJZ2N0?=
 =?utf-8?Q?Xz0vbSvGV/4TBCc7WevNxZ/v3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f1e08a-f264-452d-a8ba-08dd5d8c009c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:23:24.4540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6yu5Z05U3cjScC/yms4JyIA5gRvBYwwJbmHrDPV9VDN/kojH1eAB0epe/I8K4S39EuzMt972YkDqnbQAZbQTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6550
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



On 2025-03-06 13:51, Mario Limonciello wrote:
> When userspace invokes S4 the flow is:
> 
> 1) amdgpu_pmops_prepare()
> 2) amdgpu_pmops_freeze()
> 3) Create hibernation image
> 4) amdgpu_pmops_thaw()
> 5) Write out image to disk
> 6) Turn off system
> 
> Then on resume amdgpu_pmops_restore() is called.
> 
> This flow has a problem that because amdgpu_pmops_thaw() is called
> it will call amdgpu_device_resume() which will resume all of the GPU.
> 
> This includes turning the display hardware back on and discovering
> connectors again.
> 
> This is an unexpected experience for the display to turn back on.
> Adjust the flow so that during the S4 sequence display hardware is
> not turned back on.
> 
> Reported-by: Xaver Hugl <xaver.hugl@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2038
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           | 11 +++++++++--
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  5 +++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b161daa90019..b54c4b2f3f7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2565,7 +2565,6 @@ static int amdgpu_pmops_freeze(struct device *dev)
>  	int r;
>  
>  	r = amdgpu_device_suspend(drm_dev, true);
> -	adev->in_s4 = false;
>  	if (r)
>  		return r;
>  
> @@ -2577,8 +2576,13 @@ static int amdgpu_pmops_freeze(struct device *dev)
>  static int amdgpu_pmops_thaw(struct device *dev)
>  {
>  	struct drm_device *drm_dev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(drm_dev);
> +	int r;
>  
> -	return amdgpu_device_resume(drm_dev, true);
> +	r = amdgpu_device_resume(drm_dev, true);
> +	adev->in_s4 = false;
> +
> +	return r;
>  }
>  
>  static int amdgpu_pmops_poweroff(struct device *dev)
> @@ -2591,6 +2595,9 @@ static int amdgpu_pmops_poweroff(struct device *dev)
>  static int amdgpu_pmops_restore(struct device *dev)
>  {
>  	struct drm_device *drm_dev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(drm_dev);
> +
> +	adev->in_s4 = false;
>  
>  	return amdgpu_device_resume(drm_dev, true);
>  }
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 6f9331fe91c3..5939796db74c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3431,6 +3431,11 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
>  
>  		return 0;
>  	}
> +
> +	/* leave display off for S4 sequence */
> +	if (adev->in_s4)
> +		return 0;
> +
>  	/* Recreate dc_state - DC invalidates it when setting power state to S3. */
>  	dc_state_release(dm_state->context);
>  	dm_state->context = dc_state_create(dm->dc, NULL);

