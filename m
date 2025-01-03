Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC27AE77188
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2025 06:13:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9746D10E803;
	Fri,  3 Jan 2025 06:13:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HMherl+N";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36D4A10E808
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2025 06:13:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFk140tUAOyy85VRoPJBUrQ1b/WxD52vCsQ0sv2SDofje5aUP8xgXX5gMD2Dl8jaY/hMjARxTk0mZxg4UKi/rFlSZ6pWXeDOgFyW1Rc99nLCy82LxOthQZN7W3v8hJtwuIO1d5tkgl3uSfmr3zg0tq58rOrIf5aD6he9QxhiSGPkR58Amq8jLsLsRR6xt/eFdrS7cRa36hVTgREAhfKkEvsxshmLI+weQ1rOdqz5HAa145QEqnfyKEOcTubSDFzy6u4PfNC59lvngMyMyw63myYp4TFgK0UImwAi6sZYAGZOZtf5J765BtuP9OdIwO2wXSVo3kbwe7+ciRxIDhdvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGgWDEBMr/R0qPHhxiiZbc7W/W3l1cifHqapt61HT+4=;
 b=vm+QnCE29qy7+vl3aBaxL0R0zH/jfGa03NWqqV4Rv2AgPu7Tfw5LqoUJIGaIG+eNTPIy63gE/JcdCXpfnYtkPqSgrdh446IGMpJk6ST30Y80Med5qMFkbUA8fL0j8u6AX6AoYNbu4iO5xg5uj7uUSQeTnjGMqdvOgaJn9p7LcGuKT1GUFLzAYORdmtv24zs+NXx2LVxlA4xADS0yTHr8srBmIfsTgEgcrvC3S4BC8CvR1Q/ZV9d39jiGaF9Zvj7oYsOKAzo85oMEFjQL0KfrJy89dadmZwYSAR2pjJluxxXYThKiosx5DBXuE8Qc0Rec7+jhUr1xBbJq0k+SokbB7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGgWDEBMr/R0qPHhxiiZbc7W/W3l1cifHqapt61HT+4=;
 b=HMherl+Nq9nuLAtDnJ4PrfohOw1T/PBu2Y4v9gtbeIDRxfWdekivVawvwXNwk4emDb/DzygJPRXG2S12hoeg7Jf79LQS50DQLwS4ROoyM3S53ND0gGVTFXvvWqK4RFWnqt6EdF3WGGreMV9Vh4NqIrFrOf+AYDf1NHkhmmauxbM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 PH7PR12MB5832.namprd12.prod.outlook.com (2603:10b6:510:1d7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.12; Fri, 3 Jan 2025 05:58:59 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8293.000; Fri, 3 Jan 2025
 05:58:59 +0000
Content-Type: multipart/alternative;
 boundary="------------jMZwFXGVuUmjGYdnpYt0uDET"
Message-ID: <291f4971-132c-4587-ad36-158a8ab64883@amd.com>
Date: Thu, 2 Jan 2025 23:58:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] amdgpu: fix use after free bug related to
 amdgpu_driver_release_kms()
To: Jiang Liu <gerry@linux.alibaba.com>, amd-gfx@lists.freedesktop.org,
 kent.russell@amd.com, shuox.liu@linux.alibaba.com
References: <cover.1735795671.git.gerry@linux.alibaba.com>
 <176921ed3539fb55e4a222212b638caf84ebf4aa.1735795671.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <176921ed3539fb55e4a222212b638caf84ebf4aa.1735795671.git.gerry@linux.alibaba.com>
X-ClientProxiedBy: SN7PR04CA0204.namprd04.prod.outlook.com
 (2603:10b6:806:126::29) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|PH7PR12MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c948d3f-665e-4b99-d0be-08dd2bbbb73e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFRtUmFEZjY0WFhUeWE3QmJWcnpHVzdQaUFVUkRVOU90SFJJM2lVbUg3TWJk?=
 =?utf-8?B?OWFSYjZvSkpJQTJqeWtsaU42TGwzOGY3QjhXL2lWNDBOTDVvREpJNXZDQWZJ?=
 =?utf-8?B?Vm5UUG5MMG9NbzBzTGc1YklZRW1Hak9oL1hwK215K3pDTExEbnJ1cXZBOFFl?=
 =?utf-8?B?YVpVSVhqNFdlcXBlOCszTDB0QlB3VzhNQldwWXpMNWRUc3JJejFFeGFIUTJ3?=
 =?utf-8?B?NWdlSUM4VXJKU2oyczhONXRwSzVOUVBUNWd1ek9xWFJ2UkNORjU5OElnUkVH?=
 =?utf-8?B?a3FNNkxuUkx6NXQ3K0pKWUx6cUxXUHJqTTNLM0ZmbDhZT3lHTjZsc2Q1d1Nr?=
 =?utf-8?B?a01IZnN2ZGVRN2JKM2pqZ3g1VjBQTFNtb2ZTNnR6bERuR1AyUFZNdlB1eWxi?=
 =?utf-8?B?bDcrbTNhbUhpYStGQUZBYlRwWVA0c0lKT2dGNWhKQXZjeGxPdnJ1ZEk5NXJi?=
 =?utf-8?B?NWUyd25aSVZTZncxcmljWGZUN2Y0S3Exa1JhMXNOc3ZZTWI5S0QzZ0JNSlAx?=
 =?utf-8?B?S3JiV0FyeUo2L2p3a3J0bkJiWGRUY2J2alpHdXlWcmZXMVhCVjRLQkRXUVlH?=
 =?utf-8?B?c2FJbkpqTmF1bXpmRDNkNytwRnlCQ2JYaWl1L1RBSVRsZkxuWmJhUWVTc01K?=
 =?utf-8?B?bGxWSmJyNkhkaUdnYjhDVUdFazIzcE02dGw5NExyUUlCU0IvR0VSVVpYZkNF?=
 =?utf-8?B?eUdaYjVvS0NuT1l4OU1aYVFGb0Yrc1lUVUk4d0NWeTZDQklUNWVuWDFLQjF2?=
 =?utf-8?B?YitjeHN4a1dLaVg4ak5FMUt6dHNmaUpwTnZkRUhGVDRaK2lONjRaRGVza1RV?=
 =?utf-8?B?aVo1MnMrYUdzeUdGM0kwUTMrWDFSR3BwV3ZZOTM3c0FNdWlpakExeVQyUlY4?=
 =?utf-8?B?TEVlaEpBMi96aVV0R2FickJubWFTQURSWE9uL085OG1hUE1teGdCaW1pb1JR?=
 =?utf-8?B?RGdUS1RNSW95T2ttaFZtVkxXc0paOCs1ZUtnc0pDWFRUa1dMZ0hkM3RrT0I1?=
 =?utf-8?B?VXJtZ2lzVDF4TkVZaDJ5OC9IdzNvSkFaT2pmWlV6VTNPMWxwZys0dndlQitx?=
 =?utf-8?B?MlRRRlpGb1pzNWljcnF3anVZRXhBU1d6MXZCMmNZWjl0SVRTTEZIVVVudXN0?=
 =?utf-8?B?clltaDdITkhxL0hYNXBSTU5HTUt4QWl4TGJNZ0FWb2hUMnFVblc3NThmK3VL?=
 =?utf-8?B?L0tBR2UzWjJOQ0ZUOWZPZkVnWFFWT0s1TGNhT3JQdjdlWk9LTENmSEd0V09w?=
 =?utf-8?B?U2R3SGJWa21ESEl4QXM1RlFmYnc0akFieXNyOVdVYmZMTGJUODVEQUVXZHRo?=
 =?utf-8?B?MWdHclJCbHhYNzlMSnY3N3ZjMjgyZ2I1K0d6ZUxYUUJ5eTNSOHU1Q29UWGRM?=
 =?utf-8?B?ZnNocUVlYVVTSFEyUmswOVlBVEljQm1XejNqUkFnWTg5ejBZVDJlU095WTJD?=
 =?utf-8?B?bDU1M3VscGtNNWlyei85RzZlcGNZZ3BmeENHQzJwekVWNnRmZTNXeVl5SkhV?=
 =?utf-8?B?WktwdVU5c2w1MGVPZWtNZ1QwTHJ5dXZ4dTdKVXRJbzFVaUdqUmZ4cFczZzFH?=
 =?utf-8?B?bDV4TzR1MnRWRURleGloNUtZQS9DVDk5UE1ibld3QnowdkpGL2JUV1FjSEdB?=
 =?utf-8?B?UjZCQnhuWnVYNGNoQ2l4Y2xYMnF0VnZnN3FUVUtoYWxwb2JHTkZRck5mb1Z6?=
 =?utf-8?B?MW8xRmZ2Uzl1d2VzbzY0U2tGK09zWTE5ZUxXcUV1enU5Y0o0c1hIUDIvTy9t?=
 =?utf-8?B?cGE4bEwvV0F5M21EbXNpbmZlbVRMS1VZL054amU2SDFGU2ZBQVlPbmlXZ2Mv?=
 =?utf-8?B?UW44MVZwZy8xMHErSlBCWmV0NWdJTUphLzQ5b0Mvbm1yUlZHZGN4RU5VMGc0?=
 =?utf-8?Q?wqwR8PO+8motZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzN2YzRQQXA1elJpRVlrU2hDSGpwdUVQbVR3UVpKMk1HR0RVK3JrTStXc002?=
 =?utf-8?B?V0FxQWJFL0swdzdMQmJLVWNuc2JtWTZYZzk5Vlk2VVBoWjU5VWxTNUR1OHB1?=
 =?utf-8?B?QW9uQ0pna0gwMmhKVXM1TXVkVVhZMXRpekV2MlFLQzFEY1VnUmE1eXdjak93?=
 =?utf-8?B?ZU1rS3o4U3hkcGloMVEvcXZiZEF6d25HNzg2NGYyYXQzYWVNT0FVMkdQaHVN?=
 =?utf-8?B?c0tNNGdjUy9NOXN6YmVmbkhiWE1kTFNRdXE3OGZSNVhIOGF1cmRYeHliUm5z?=
 =?utf-8?B?ZHFPK2RETDhrdjN3TzljcVdDTzQzVW05Q2FSMXkxVDdrT0hZMVdadGc2WG1V?=
 =?utf-8?B?WWNwZ2R5Y2s1QUtoRC9oTkxRZnpOMXoxRDB2Y2NaOGEzRFYwVUt2Y0tMRGFk?=
 =?utf-8?B?Q3pOTlRnQjAwNmhacFJhZ2JBWkVoZkV1RjlsMUYzL2R5ZzBFRUZPU01TRElV?=
 =?utf-8?B?UDZ6bHhlSjZnWE53YmRwUzQ0M3RsOXY3ZjVxOGJycXpQaUI5NUY5c1U2SFJn?=
 =?utf-8?B?QWVQM3FjVFQxcVpUWnNUYnByZ29OaXdYVllRcFgzN2R0VldaNVZvTDc4QTIv?=
 =?utf-8?B?eXkvM1h0SzlXMVRZRzFMZ1QwOHFXaW96cVBteG1WbFZZbkdEaGJDYUcwSTlq?=
 =?utf-8?B?N2hWOVFScDBLdkpnbng0RDBmdk1WbkdkdWN4d1R6bHBnVGJGczEwSkpXSms2?=
 =?utf-8?B?M0NDMTUyaXhsZEhGU0ZRZkRtZ0s5T0V3SlRsYkdlSkhKWkd4bkJCYUN6clZs?=
 =?utf-8?B?dWRMWW80dnlIZ2ZvbWJONEhkUC9LNExxdEZDSFpRVXZtYW5xWVV4TkNYNG5m?=
 =?utf-8?B?TzVrNnczYWdhYWN5MHh5Tmg1K0xrWEdDMHA4Ui9HbUFBWCtRSEZLMnUzaVds?=
 =?utf-8?B?YktreFdDeHkzSEk2QWxTaUh6dlppVkZGM0RrUEdTVVQ0NjRIUUgvbW5uREFr?=
 =?utf-8?B?YWI4Syt6SUFLZ3h4bzNVamFtVWEyMHo0Vjc5ZHJpUGVJbXEwdEZkbXVIaGpi?=
 =?utf-8?B?SVRKRGpzWlBkVThCVWNjZG9jUEVZTlhxMmVlQ2x5MG94b2NnRUpPTDNMRThB?=
 =?utf-8?B?bi8wMW04R2hmM214cER4eG9pZVAvS2lwK1ZPeWNmKzcyK2RsZjlTZWxGT1VZ?=
 =?utf-8?B?cmtoNmR4dG5QdUhxVVkvVE1XZi95L2RTcVk4a1JIeTA0RzJya3k2cEl5SmdM?=
 =?utf-8?B?WFBub0t3emxHbEU2NTJQbHhuRlA4NU1vemRRbE9MOWhJWVBZNU9Gc2o2S2o2?=
 =?utf-8?B?ZE9NUzlpaWpiTXcxTjdCbmxhVURvZ01DSFVkSjYxR09IdkI2MVY0MFZ1TEJp?=
 =?utf-8?B?V2RSemNvU0U4VHJiUVpxTHRWY3dWbmZBTTdWRk0xV2RxNTkxcGhTMkU5Rjlr?=
 =?utf-8?B?aVpCa0VBdVRqMXNQK0NmRFZqTVVvRStHa1ZXekVPNFk4UFErVGVMVkNzNGZ5?=
 =?utf-8?B?Uzh0ZlRUa1BMNEN0bTlzdEpYUmdCY25TYjQ0ajBFaVlNQXJYdXhTUUl0eU5w?=
 =?utf-8?B?WGxOQ2l3dVp5MnVDUnVEcFZPZ1FESTlFRmVlM2Ivd1k2OEJqTXdMSlJDNkNn?=
 =?utf-8?B?cUtsU0hvWUtub3RNZjEyVFBtT0VFYkl3V09MZE1RcXl0cTc2OGs0bFJlVSs2?=
 =?utf-8?B?eEFwMUhOeE9yWWJnYjh0OFpvbXplRGxSK1cvZ1RWazJ1RGNWc3Z5MTRrTVFK?=
 =?utf-8?B?eWlMMWlFeEE2eHUvQy8xV3JtbWhqeDB6Z0tRdkdMaWlBcnpNSzJmc2dBRWM5?=
 =?utf-8?B?Z3hlQVRlUGNHSUczZVg4dFZqeG90am5xdysrTnBrUkgvMURpU3A1VzFiR3Zx?=
 =?utf-8?B?NllCeStML1IwcUJVNVMvMDFVaDZmdi9HclVQeVBjZE13RmFmeGNPY09pYlpZ?=
 =?utf-8?B?eTFQT3R4aXhEV0F1bVpsRnAxRHdONUduSUVPcU96WWZTcXV5elVtVys2a3Nz?=
 =?utf-8?B?UW1TdkZsQ3Vwdkk3SmpiWmptanpWZ1ozNzZhVUhzaDlVbTZiVGZVVW1CSWpP?=
 =?utf-8?B?NEFRSnFzZFdPeXY1WTRpTVVjWFh2OVAvdXk2WS9VMC8xSytYUk4zeVFFTmE2?=
 =?utf-8?B?SVU0T3BKTnM3aGUxL2lMNEg2RmlnU0tjY0QwVlA0QzlVZXFtS1BnS3dvRHVS?=
 =?utf-8?Q?YT5U=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c948d3f-665e-4b99-d0be-08dd2bbbb73e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 05:58:59.0856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59X2ZT7W5HyzKmolzjMbGw8ki4xwiUzOHhKIjk75vB5SjymZ527dV08ZwpS2tlXG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5832
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

--------------jMZwFXGVuUmjGYdnpYt0uDET
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/1/2025 11:36 PM, Jiang Liu wrote:
> If some GPU device failed to probe, `rmmod amdgpu` will trigger a use
> after free bug related to amdgpu_driver_release_kms() as:
> 2024-12-26 16:17:45 [16002.085540] BUG: kernel NULL pointer dereference, address: 0000000000000000
> 2024-12-26 16:17:45 [16002.093792] #PF: supervisor read access in kernel mode
> 2024-12-26 16:17:45 [16002.099993] #PF: error_code(0x0000) - not-present page
> 2024-12-26 16:17:45 [16002.106188] PGD 0 P4D 0
> 2024-12-26 16:17:45 [16002.109464] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> 2024-12-26 16:17:45 [16002.115372] CPU: 2 PID: 14375 Comm: rmmod Kdump: loaded Tainted: G        W   E      6.10.0+ #2
> 2024-12-26 16:17:45 [16002.125577] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
> 2024-12-26 16:17:45 [16002.136858] RIP: 0010:drm_sched_fini+0x3f/0xe0 [gpu_sched]
> 2024-12-26 16:17:45 [16002.143463] Code: 60 c6 87 be 00 00 00 01 e8 ce e0 90 d8 48 8d bb 80 00 00 00 e8 c2 e0 90 d8 8b 43 20 85 c0 74 51 45 31 e4 48 8b
> 43 28 4d 63 ec <4a> 8b 2c e8 48 89 ef e8 f5 0e 59 d9 48 8b 45 10 48 8d 55 10 48 39
> 2024-12-26 16:17:45 [16002.164992] RSP: 0018:ffffb570dbbb7da8 EFLAGS: 00010246
> 2024-12-26 16:17:45 [16002.171316] RAX: 0000000000000000 RBX: ffff96b0fdadc878 RCX: 0000000000000000
> 2024-12-26 16:17:46 [16002.179784] RDX: 000fffffffe00000 RSI: 0000000000000000 RDI: ffff96b0fdadc8f8
> 2024-12-26 16:17:46 [16002.188252] RBP: ffff96b0fdadc800 R08: ffff97abbd035040 R09: ffffffff9ac52540
> 2024-12-26 16:17:46 [16002.196722] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> 2024-12-26 16:17:46 [16002.205179] R13: 0000000000000000 R14: ffff96b0fdadfc00 R15: 0000000000000000
> 2024-12-26 16:17:46 [16002.213648] FS:  00007f2737000740(0000) GS:ffff97abbd100000(0000) knlGS:0000000000000000
> 2024-12-26 16:17:46 [16002.223189] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 2024-12-26 16:17:46 [16002.230103] CR2: 0000000000000000 CR3: 000000011be3a005 CR4: 0000000000f70ef0
> 2024-12-26 16:17:46 [16002.238581] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> 2024-12-26 16:17:46 [16002.247053] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> e024se+0x3c/0x90 [amdxcp]
> 2024-12-26 16:17:46 [16002.337645]  __do_sys_delete_module.constprop.0+0x176/0x310
> 2024-12-26 16:17:46 [16002.344324]  do_syscall_64+0x5d/0x170
> 2024-12-26 16:17:46 [16002.348858]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 2024-12-26 16:17:46 [16002.354956] RIP: 0033:0x7f2736a620cb-12-26
>
> Fix it by unplugging xcp drm devices when failed to probe GPU devices.
>
> Signed-off-by: Jiang Liu<gerry@linux.alibaba.com>
> Tested-by: Shuo Liu<shuox.liu@linux.alibaba.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 +++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 1 +
>   2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 5ffe1dad9622..e7f35e3a6d2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -164,8 +164,10 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>   		DRM_WARN("smart shift update failed\n");
>   
>   out:
> -	if (r)
> +	if (r) {
> +		amdgpu_xcp_dev_unplug(adev);
>   		amdgpu_driver_unload_kms(dev);
> +	}
>   

I wonder if you can call amdgpu_xcp_dev_unplug here. It will call 
drm_dev_unplug that unplugs a hotpluggable DRM device. In you case 
amdgpu_driver_load_kms failed during probe time. We need unwind 
amdgpu_driver_load_kms. Why need do unplug a DRM device?

The backtrace show:

2024-12-26 16:17:45 [16002.136858] RIP: 0010:drm_sched_fini+0x3f/0xe0 [gpu_sched]

has:

2024-12-26 16:17:45 [16002.085540] BUG: kernel NULL pointer dereference, address: 0000000000000000

How this change is related to the invalid access above? Can you explain 
more?

Regards

Xiaogang

>   	return r;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index a6d456ec6aeb..ef4eaacf67f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -382,6 +382,7 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
>   		p_ddev->primary->dev = adev->xcp_mgr->xcp[i].pdev;
>   		p_ddev->driver =  adev->xcp_mgr->xcp[i].driver;
>   		p_ddev->vma_offset_manager = adev->xcp_mgr->xcp[i].vma_offset_manager;
> +		adev->xcp_mgr->xcp[i].ddev = NULL;
>   	}
>   }
>   
--------------jMZwFXGVuUmjGYdnpYt0uDET
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 1/1/2025 11:36 PM, Jiang Liu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:176921ed3539fb55e4a222212b638caf84ebf4aa.1735795671.git.gerry@linux.alibaba.com">
      <pre wrap="" class="moz-quote-pre">If some GPU device failed to probe, `rmmod amdgpu` will trigger a use
after free bug related to amdgpu_driver_release_kms() as:
2024-12-26 16:17:45 [16002.085540] BUG: kernel NULL pointer dereference, address: 0000000000000000
2024-12-26 16:17:45 [16002.093792] #PF: supervisor read access in kernel mode
2024-12-26 16:17:45 [16002.099993] #PF: error_code(0x0000) - not-present page
2024-12-26 16:17:45 [16002.106188] PGD 0 P4D 0
2024-12-26 16:17:45 [16002.109464] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
2024-12-26 16:17:45 [16002.115372] CPU: 2 PID: 14375 Comm: rmmod Kdump: loaded Tainted: G        W   E      6.10.0+ #2
2024-12-26 16:17:45 [16002.125577] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
2024-12-26 16:17:45 [16002.136858] RIP: 0010:drm_sched_fini+0x3f/0xe0 [gpu_sched]
2024-12-26 16:17:45 [16002.143463] Code: 60 c6 87 be 00 00 00 01 e8 ce e0 90 d8 48 8d bb 80 00 00 00 e8 c2 e0 90 d8 8b 43 20 85 c0 74 51 45 31 e4 48 8b
43 28 4d 63 ec &lt;4a&gt; 8b 2c e8 48 89 ef e8 f5 0e 59 d9 48 8b 45 10 48 8d 55 10 48 39
2024-12-26 16:17:45 [16002.164992] RSP: 0018:ffffb570dbbb7da8 EFLAGS: 00010246
2024-12-26 16:17:45 [16002.171316] RAX: 0000000000000000 RBX: ffff96b0fdadc878 RCX: 0000000000000000
2024-12-26 16:17:46 [16002.179784] RDX: 000fffffffe00000 RSI: 0000000000000000 RDI: ffff96b0fdadc8f8
2024-12-26 16:17:46 [16002.188252] RBP: ffff96b0fdadc800 R08: ffff97abbd035040 R09: ffffffff9ac52540
2024-12-26 16:17:46 [16002.196722] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
2024-12-26 16:17:46 [16002.205179] R13: 0000000000000000 R14: ffff96b0fdadfc00 R15: 0000000000000000
2024-12-26 16:17:46 [16002.213648] FS:  00007f2737000740(0000) GS:ffff97abbd100000(0000) knlGS:0000000000000000
2024-12-26 16:17:46 [16002.223189] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2024-12-26 16:17:46 [16002.230103] CR2: 0000000000000000 CR3: 000000011be3a005 CR4: 0000000000f70ef0
2024-12-26 16:17:46 [16002.238581] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
2024-12-26 16:17:46 [16002.247053] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
e024se+0x3c/0x90 [amdxcp]
2024-12-26 16:17:46 [16002.337645]  __do_sys_delete_module.constprop.0+0x176/0x310
2024-12-26 16:17:46 [16002.344324]  do_syscall_64+0x5d/0x170
2024-12-26 16:17:46 [16002.348858]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
2024-12-26 16:17:46 [16002.354956] RIP: 0033:0x7f2736a620cb-12-26

Fix it by unplugging xcp drm devices when failed to probe GPU devices.

Signed-off-by: Jiang Liu <a class="moz-txt-link-rfc2396E" href="mailto:gerry@linux.alibaba.com">&lt;gerry@linux.alibaba.com&gt;</a>
Tested-by: Shuo Liu <a class="moz-txt-link-rfc2396E" href="mailto:shuox.liu@linux.alibaba.com">&lt;shuox.liu@linux.alibaba.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 5ffe1dad9622..e7f35e3a6d2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -164,8 +164,10 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		DRM_WARN(&quot;smart shift update failed\n&quot;);
 
 out:
-	if (r)
+	if (r) {
+		amdgpu_xcp_dev_unplug(adev);
 		amdgpu_driver_unload_kms(dev);
+	}
 </pre>
    </blockquote>
    <p>I wonder if you can call <span style="white-space: pre-wrap">amdgpu_xcp_dev_unplug</span>
      here. It will call drm_dev_unplug that unplugs a hotpluggable DRM
      device. In you case <span style="white-space: pre-wrap">amdgpu_driver_load_kms</span>
      failed during probe time. We need unwind <span style="white-space: pre-wrap">amdgpu_driver_load_kms. Why need do unplug a DRM device?</span></p>
    <p><span style="white-space: pre-wrap">The backtrace show:</span></p>
    <pre wrap="" class="moz-quote-pre">2024-12-26 16:17:45 [16002.136858] RIP: 0010:drm_sched_fini+0x3f/0xe0 [gpu_sched]</pre>
    <p>has:</p>
    <pre wrap="" class="moz-quote-pre">2024-12-26 16:17:45 [16002.085540] BUG: kernel NULL pointer dereference, address: 0000000000000000</pre>
    <p>How this change is related to the invalid access above? Can you
      explain more?</p>
    <p>Regards</p>
    <p>Xiaogang<br>
    </p>
    <p></p>
    <p></p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:176921ed3539fb55e4a222212b638caf84ebf4aa.1735795671.git.gerry@linux.alibaba.com">
      <pre wrap="" class="moz-quote-pre">
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index a6d456ec6aeb..ef4eaacf67f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -382,6 +382,7 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
 		p_ddev-&gt;primary-&gt;dev = adev-&gt;xcp_mgr-&gt;xcp[i].pdev;
 		p_ddev-&gt;driver =  adev-&gt;xcp_mgr-&gt;xcp[i].driver;
 		p_ddev-&gt;vma_offset_manager = adev-&gt;xcp_mgr-&gt;xcp[i].vma_offset_manager;
+		adev-&gt;xcp_mgr-&gt;xcp[i].ddev = NULL;
 	}
 }
 
</pre>
    </blockquote>
  </body>
</html>

--------------jMZwFXGVuUmjGYdnpYt0uDET--
