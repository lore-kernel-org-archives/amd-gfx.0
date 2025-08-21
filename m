Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129F8CA0EEB
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 15:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3401810E0DA;
	Thu, 21 Aug 2025 15:46:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UV1Zm4Sj";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D8BA10E0DA
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 15:46:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rM4U98UuoSzK3suKJRuoi/7ZcCoxjBK+AWRPE4lZExLSj/GIlIMk76J/3FNCYWeKdnk9AfvoX6ucMT1DEv37LNbVrILuLzUwtbPKwn9ePDsvQ3N3WQUelVvBFWPXECnfFdGoeyvpQvcGC2swluWZG4hY6vMmg8K+s/zGFM0lLn2SumG4SeCyLbgtxcOmDhxMZ+KVK3Apmu5WqiVcVoSpCYfpQnmde8zsmkRo+Sfuf9nLn2M4FqstqKJqbATazW7RBqK96o6M05beCx2y8894Fw4RbstO3T3xy47l6Dn2OBAp6IXdR6cn5/ogsZTRCl86iLx1fOz3ldQ37XRzGCTjcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOzFpUbEZFzvpaXewYIqkkLB9PCQJb0ovA6GI3BAT7Q=;
 b=hSYleRwfhC/v1aw+wIiwr6KUybOsB7438EOiCZHQ6/nmlrLDNAgPZ4miBtpKY9vVAiL0EpZQpkzJi0yQakgjgoSMv6VMUtGk2/n99Que9NmwufbvvhOk37Ki9oycEfLIa3yyP2gfMFyd1xF7+ThVVkw8ElswNT3rmlnZA6DzixQns11utAX6fA0H8MJR5DnHpXScb9pr6UKxAoqkxKew0vUMCefpYhUN7tISiaJw0Qqb+b43T1NxJWUmr1+NbF3q2Drh9uc0Pxr4Fd0a3i013ekUZsrvrrTccSEq/RhrOm4RGTjZBpa8Y8ZJg0v6z/XcJu7kgL7yXQM9Qkr6/0Ptpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOzFpUbEZFzvpaXewYIqkkLB9PCQJb0ovA6GI3BAT7Q=;
 b=UV1Zm4SjSWhsSwQLt5PZsmz6HmdUULmzql+qI3hivh5b+n0Ieoo54/YqG8rlf750mAY8SLTv7fCAYg8pxXZ8VeHo0bj2Hl4BAxHf/904wIHSMG1WDWTu5fuHdUnpN73R3czox71HkkPmyODb7fi26UTzYuOMglR94ijiww/heY4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS4PR12MB9706.namprd12.prod.outlook.com (2603:10b6:8:277::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Thu, 21 Aug 2025 15:46:37 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.9031.018; Thu, 21 Aug 2025
 15:46:37 +0000
Message-ID: <8a240840-77e5-4597-a4c0-60ee73e9dd66@amd.com>
Date: Thu, 21 Aug 2025 21:16:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 5/5] drm/amd/pm: Add VCN reset message support for SMU
 v13.0.12
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 leo.liu@amd.com, sonny.jiang@amd.com
References: <20250820030400.514460-1-Jesse.Zhang@amd.com>
 <20250820030400.514460-5-Jesse.Zhang@amd.com>
Content-Language: en-US
From: Lijo Lazar <lijo.lazar@amd.com>
In-Reply-To: <20250820030400.514460-5-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::21) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS4PR12MB9706:EE_
X-MS-Office365-Filtering-Correlation-Id: c89d2aa7-d5df-4fd2-9d41-08dde0c9e9a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWRKMDA3MEw3aHdlZjFvNkgvSjNSdVFWQVJ1aTlkOC85bExYTmNBdVF5dkM0?=
 =?utf-8?B?SjBNMXkwVlh5eEI1dDNhd0doV0JXcjNTem5heUM2amdOVkpVQ3lvRmwzR1Nt?=
 =?utf-8?B?Wjd2cDdXSWVwM0hTVEFVRTNNSTA4TXpPOHY3THdxM0JaZklpaE15Vm5sYnM4?=
 =?utf-8?B?cnYyOHJ5eHBzRTlUTEs3bUo2TlltdzRBKzNMaXJxRUh0M2hCRHd2MnVpSEl6?=
 =?utf-8?B?YnRGWDVhbit1L0N2YmE0U3ZhRmZJT0lTRjBGSjZydjJCQTQwdTdqL1k3M1hH?=
 =?utf-8?B?bEdHZ0hmT2hPSHJuWVpXNXRTcDFUSE5tZUVhMUdPZ3RnY0VTelphQzRuUFM3?=
 =?utf-8?B?MnhqNUpQS1diMnNYZ3ZCdk1DT2JvdlVEeCthVUlPMm9IUSthQ3N5VVlMU1Zx?=
 =?utf-8?B?ZG1Dc043ZW44MlhydUw5eVRKK0lGclpHT3ZISHdDRDJpL1orM1prenlHV2U3?=
 =?utf-8?B?akhkRW1LSHlhWTNiUnl2N0JNeVRMNU9oQXQzaXZ0YWRTQnNuZHhteHlFWUxO?=
 =?utf-8?B?c3VYYmdRMkVvOXRQN09zbGNtUkFwMVRlaXJRVG90YTNXUy9WK3FxQjNaaktK?=
 =?utf-8?B?amN0VUVUMXJlN2pab2d2M0cvQXpuVmFEVGFTaXNtV3BUZ3BBaFlyaVFrR21m?=
 =?utf-8?B?aHBkc3o1dURLRHpmdDRRM21WK0NkZ3M5UkV6b0hIOEQ1ZnlvTkFtaHc4YzJJ?=
 =?utf-8?B?QlhVT3Q2VFdJeXlJSUlVSWJHL25CdHhJbUNRV1FlTXlUNGpDOVRUU0Z4SEFq?=
 =?utf-8?B?UUdSUFNqcEdMdEl0cDRJMmpLR0l3Z2NHdURyVFgrVU1WM2dFQXlFVlhweCsv?=
 =?utf-8?B?bjIvekxobTBPcSt1OHJiZURQRHBETy9qSjMrdjFYQ2crWFdIRDZFYUs5S3hh?=
 =?utf-8?B?OExoQWpleng1RGRlY3htRCt4bUUzVnpnUzgrZGQwM1VvVEM5dFBkSVgzd25I?=
 =?utf-8?B?UExWL3dxVjh5dThYb1c0UG1JcEM1NzNaU2k1OEZuUjVMd3hEWXFNVHErODV6?=
 =?utf-8?B?NXF4Z3hFUGV1aHB4QW1EVWZpSmd1S2NhN05jT25UUE85R2hUdGl0Rlk0NzVB?=
 =?utf-8?B?TmN6dFV4QlhTR3VuM2ttRDhiMnVtQTVFZWJjZTJtVHFIb0ZSUGRraERCVGRZ?=
 =?utf-8?B?L0szSC9JQjF1OU5IUjdaVm05ZzhxYzQ1SFJuSWt2dWNyR1p2TVh0NlVPaGlw?=
 =?utf-8?B?cWN6THhSd2JJdkgwaXNQdDVhd2s4azVJOHEyMzZxc0pPekh0WThPRVFlWmRP?=
 =?utf-8?B?R3ZZS1MxQlVsNG8rY3lvdnpYS3UrNDd2RmRsdVliRFUvQmEyWUEwUmJtZ09s?=
 =?utf-8?B?K3FMbjREaHZHa3pZS2REQUNmLzc3NGZWWldHU3B1YmJ3UTZOQlo1YXgvZFd2?=
 =?utf-8?B?YitTNmNNMUJlVnNSUy9JMjdlSFY4OGxZd1lqdFJnMStwYkF0ZkVsang5TFVU?=
 =?utf-8?B?WVlESWpRUXpwWnY1V2xxdDFnZGtDMitLZThHZ1VxR1lHU21JYjEvN3lXREp2?=
 =?utf-8?B?RlM3MHFNN1hpS25sVUxhSWJ3cjRLVVFVdmRJSmVhNURnb2Z6QUdLRVRQcFNI?=
 =?utf-8?B?N3VBWkZmcVRZUitCU0JXNmV4VTNiREJjaUFxK2JVOEluaDVLd3JmUVg5dkNC?=
 =?utf-8?B?TW9aVGVrQWhQY2NXY1B3anc4dFVGVVJ5UU1YQU92SDNRT3dUZGN6blhicW9w?=
 =?utf-8?B?QytmMXFxM3F5NThTOGZlMUJ3ZHhvU2pUbWxxalF4ajZianlMdE5mQ1k1UndS?=
 =?utf-8?B?NklQblU1R3Q0Vm8vYi85eklKTUtjUE5laUxJeG02VFBpN2tTODJhVWJURTVh?=
 =?utf-8?B?ZlBkamwrNGhGbmYva2hWZHdsMTNIeGNmRFhLbDlaVENuaTdwUDJCeUVvUUtG?=
 =?utf-8?B?NzR5S09WME5uVDNOc3l5dndrU1pOMkU5cVlKd2Z1M1RRbVN4MndFMVNRUXdI?=
 =?utf-8?Q?v5ebjKifmJk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlR5NXJBaVYyejlQcWJ6WFlFQ1BKT3J5UjR6OXV5NWZuMkJ0VkllbnBhbXhH?=
 =?utf-8?B?SWd3Z2IvZE43Q2xjZUY4WU9RcmN1cFB4N3UxZDU0VDlQZEwvVm9wVTJVdkMy?=
 =?utf-8?B?bzhQdS9JK29YcXNndGc4eW5sS1hXQysvMTZzZ052YWlab1BFbE9pZGsvQ3c0?=
 =?utf-8?B?OUJQQm5FUUpPYkIwWjgvU1J3SHN1NGFyUmI3Y05RcmhZckdlWkQ1NkdYekUx?=
 =?utf-8?B?dlgwUXBFMGFIc1RWWGJoS1VjTUtqeUI0WTFsc2tCeUEzbmxlc1dYNUVneHNW?=
 =?utf-8?B?TEhsamh1N3FONTl3RXg5QlFLR08rdXhGNDFydlFlOE1NSHd3Myt1MjVEUWMr?=
 =?utf-8?B?bEJ5Mm03ZlFPWHBwVGY2STdqckRHWUpFclFEUkpibm1QTG5mRVBha09qMSs0?=
 =?utf-8?B?dFBxSE9sNVpVRlVsR2RyN2VGekNTYytEZjc0OWVZVmROTFhyMTBMdzJrSDk2?=
 =?utf-8?B?YlhRTHZlODFjUjZWZDNiVW9yRFRqTmh3RzNrMUJKTUN4aytVcHlLYVlINTlp?=
 =?utf-8?B?ZmUyRVgxUkZ2cG9uOFVNY0Z5QzNQOFBicWIzYVF1SUlBb0E5c3hoc2h1eVBG?=
 =?utf-8?B?VkN2RjlPZlNpdk9MK1F5eDBxS1RRemtVenRva1ZaeVJjZXlYVkE0SDVjQytC?=
 =?utf-8?B?MktXc05wT1BSNEsrdlJsWGRUdE14UmpCekJOWGNERERBNEZLcGE5em8rWXgr?=
 =?utf-8?B?bG5MQU53UkhhaTY3YmxveHZwbHJFY0poTzNkb1FKQjQ1VTA0SktBNU9MbC90?=
 =?utf-8?B?ZHZlUWxXRTdHaUhxcGVTUjRJR1d5UXFJald3NytEb3RBaTNPWDY3ZFdyMTYw?=
 =?utf-8?B?ZU53UE9nUGliOFJZQ25ZcnNFa1dnYlNVNXFPbXdjbno2K3BZNVBXN3IzWjJR?=
 =?utf-8?B?TDRFOUxHOVZZR3J4N1lkMGpTNEtrbkVPQ2xmSGtNbmxzUWhDR2RMQTlzNUVs?=
 =?utf-8?B?d09HdU5XTlpmWDRSaDFnUnkrcDV1ZmVHSWdFU2ZOam8yaVF6eXQrY3ptd3hN?=
 =?utf-8?B?aVlhZjQzOU1tMG5XNU1PbElOZUt2MityY1M4Tm84Wk85cHVCYTR6RHZ3c1Vr?=
 =?utf-8?B?bGFtRG1hVHJ4KzFWQTQ0MkQrbW50WmFwWmxoVVJSaGZFODN6c2JTNjZCczAr?=
 =?utf-8?B?MUJvcHVkY0p4RWRGa1lWTGtKQTRsbUhFMlM3NUVaUHJFaVI4RlRzaXhPdW84?=
 =?utf-8?B?UGMxekkxNEg3L0tvdEk0Q1VCTXcwOGFmUmwzLy9KNlh5cHcxYmZxM1lERm94?=
 =?utf-8?B?ejhNdHVxTlpWT2twM1oyWCtQc1BuVjJacHZEeE1sa1NQaWNqNWFKek5tNlVu?=
 =?utf-8?B?eXEyemkzNWQwQ0g5RW5yZWdNWlJtNkNXQ2loakZjUTJiM2RkWjJET21ySnNz?=
 =?utf-8?B?aHhpcjVlNTQwY3R3SzVpSkdGQTZkTlR4ZHhnZjdnTStrZ3Uwc0ZxZlRaaUV0?=
 =?utf-8?B?dXc5QTRpV3ZOK25aWmhzVUo1SlNHQmFBcFlhdHRJRG1VYXA1M053b2FJcDc5?=
 =?utf-8?B?TEVCVUlUcHVySlZHa0pCQzhkblF3cHk4WlU1QkU4b1lBeTJnY1BHSXJFT2Fs?=
 =?utf-8?B?V3VCcEk1Z1oyODBkZU93VW5QT1ZKR2E0VS9FSy9hcGdKbWtyaXRZc2VSTURT?=
 =?utf-8?B?UHRVSlRMbUpXUTR5UGNFZ3ROREMrNy9CMWtKWjVSQktPQjlCakJBTVJ2ckZ1?=
 =?utf-8?B?OVdjZ0pnODJaSlBJMHREY1Z4Yk51TkZLNmdQTG9DS2Z3cjhIOTFWMjYwUUJL?=
 =?utf-8?B?czdyMmFkUXA0ZWRDeE4rSlV2dXU0dVBHNGM5K0ZlbTFVTjVialEvek8vTTZE?=
 =?utf-8?B?dnZjdGt1Rmc1STlOVjNWK0FnaGsrWU5aRlA4V25IcCtHcW9ocW1qenZTeGtV?=
 =?utf-8?B?eER0Sk9pVDlXNERQMmtOcFU2NnJ0ZWpwVFpmVFkyZ1lpZHZycThzaldJN1Bh?=
 =?utf-8?B?NmtGSjc4UzdiVkVqcThiUDE1M282WE5kelFGQ2plck4xaVhuVHUvUW1ycmlW?=
 =?utf-8?B?akVOUWlNM1haaXRnV2dzMHRJdEo2RUpBMlNhT1BIdjZBcXFwMnVGMnZYbkJx?=
 =?utf-8?B?WHE0TCsxSGE3ODZ5bzNzeDliaVIwNnhlSTNMVTI5VVpzbmJCd1Z6S3lRZjA4?=
 =?utf-8?Q?Hw+VAKZGjYwPNoN6VwK1g7/SI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89d2aa7-d5df-4fd2-9d41-08dde0c9e9a9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:46:37.1828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ttFr00YrgFYbr2fNF2I+SN6y9AsJxVz929CJfgZ6IIL1ZNdtfa2DclfNb7FnwoC0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9706
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



On 8/20/2025 8:33 AM, Jesse.Zhang wrote:
> This commit adds support for VCN reset functionality in SMU v13.0.12 by:
> 
> 1. Adding two new PPSMC messages in smu_v13_0_12_ppsmc.h:
>    - PPSMC_MSG_ResetVCN (0x5E)
>    - PPSMC_MSG_CPPipeReset (0x5F)
>    - Updates PPSMC_Message_Count to 0x60 to account for new messages
> 
> 2. Adding message mapping for ResetVCN in smu_v13_0_12_ppt.c:
>    - Maps SMU_MSG_ResetVCN to PPSMC_MSG_ResetVCN
> 
> These changes enable proper VCN reset handling through the SMU firmware
> interface for compatible AMD GPUs.
> 

Is there a corresponding FW version which enables this? If not yet,
would be better to add both together in a different series.

Thanks,
Lijo

> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h | 4 +++-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c         | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
> index aff2776a8b6f..037529eb70bb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
> @@ -120,7 +120,9 @@
>  #define PPSMC_MSG_GetBadPageSeverity                0x5B
>  #define PPSMC_MSG_GetSystemMetricsTable             0x5C
>  #define PPSMC_MSG_GetSystemMetricsVersion           0x5D
> -#define PPSMC_Message_Count                         0x5E
> +#define PPSMC_MSG_ResetVCN                          0x5E
> +#define PPSMC_MSG_CPPipeReset                       0x5F
> +#define PPSMC_Message_Count                         0x60
>  
>  //PPSMC Reset Types for driver msg argument
>  #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> index 32fd0be05cff..a3eb19f702d0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> @@ -136,6 +136,7 @@ const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] =
>  	MSG_MAP(RmaDueToBadPageThreshold,            PPSMC_MSG_RmaDueToBadPageThreshold,        0),
>  	MSG_MAP(SetThrottlingPolicy,                 PPSMC_MSG_SetThrottlingPolicy,             0),
>  	MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,                       0),
> +	MSG_MAP(ResetVCN,                            PPSMC_MSG_ResetVCN,                        0),
>  	MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticMetricsTable,           1),
>  	MSG_MAP(GetSystemMetricsTable,               PPSMC_MSG_GetSystemMetricsTable,           0),
>  };

