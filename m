Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7952DE77188
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2025 18:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1903810E105;
	Fri,  3 Jan 2025 18:06:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YeuxrdwC";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B33BE10E105
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2025 18:06:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8MJFj2QypNbR1mz3HP0i9DIBk9Pc/qJy+38O8SuUHf+kikxWe+69vbW08ln+xZ2DZB1RDWAOuI3ebm31oPxBt0Ya92EzpcQCusI6EunoVtxx1AuoOLD8aaWEexwGPv9igkoMzvce78OK5ZI/jYWB58o09Hws4rDz7LzTjzZIeSZsdAvWm7ifdLc71gxBQ4Dlw0Mw9w/UQjw+PReGWRKe1NnswPYBhdw+ewhgtEKpGExRhxxkPizjC8XdQYbp9LQXNoxA4uwWfxy6iQ7sLTnBa7NnJjxo9oyjsdu4Wk0mBnaadGZg7X8xxizR3RJ4E8wIA6/XWx5GQkwRsN7/jR6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rh9kxxaN9+KRWiNOmKWk6j4ZkKxE7GOY2RS7RTg1c7o=;
 b=NvtqxlQScJoQbw/xawf6pUEghzcXHKKznge0fRsFbXaMYeg2923HLDSCSZskpWaa1In2WIJvRKKQZApALxcqkXNV7mtQdaybOi9LhQr+KkL6KT0jZp778qJEE5qAWHXc2Tt2GRdiAPnC58KRnANiB3EPUNLZRagBgPABmuXTTm86JDz5G8+O1zWysJ/hCKrEGswWua12eKiIxYsF85LgJah3Rj+ivTYCcep0QldM3+S183jy7H5whNIyIV2GNmNv50Cl5TAC7nSsd/578rWm+3Ma9k0l5HoTNrhglNW9Gp+K9xrcakbPXsHL+eaEAgAVsSDiS7lWAj5h1b5TiGbFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rh9kxxaN9+KRWiNOmKWk6j4ZkKxE7GOY2RS7RTg1c7o=;
 b=YeuxrdwC9SoVAeQJNLIqNF04LpLwHxU3zX4zgF/6Rgmd3IcXWJe+0d244o9FWmvT4FLrTPohLAb73ezSArXrkDSffqt6s5OaT3W+UQkteVfKLRHL4Tfxy9JHOfC2C5VGItXsgF848qDn/tnJ0evsNyQOEhBxbIwQlVKx+gv44BU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.13; Fri, 3 Jan 2025 17:34:15 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8293.000; Fri, 3 Jan 2025
 17:34:15 +0000
Message-ID: <56be391e-e0c4-49c3-8e25-81c746d984d6@amd.com>
Date: Fri, 3 Jan 2025 11:34:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] amdgpu: fix use after free bug related to
 amdgpu_driver_release_kms()
To: Shuo Liu <shuox.liu@linux.alibaba.com>, Gerry Liu <gerry@linux.alibaba.com>
Cc: amd-gfx@lists.freedesktop.org, kent.russell@amd.com
References: <cover.1735795671.git.gerry@linux.alibaba.com>
 <176921ed3539fb55e4a222212b638caf84ebf4aa.1735795671.git.gerry@linux.alibaba.com>
 <291f4971-132c-4587-ad36-158a8ab64883@amd.com>
 <4A1FAF80-B3D5-4440-A73E-6D8AE2486F7A@linux.alibaba.com>
 <Z3eVNVoTJhyAiV83@shuo-ali-mbp.local>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <Z3eVNVoTJhyAiV83@shuo-ali-mbp.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0070.namprd11.prod.outlook.com
 (2603:10b6:806:d2::15) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DS7PR12MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e487708-0498-493e-1d1b-08dd2c1cd7f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFVHckZjOWppc3VWL0RIUHdCdkU0K0daMU9TeDJSRk5hcnhRaDNBcVFkOUJ5?=
 =?utf-8?B?Um0relgxWWFVd0NxcWdtUm5KZnZZakpVUlBRRzhuK1V1TUlSY1kzbFBhbkJE?=
 =?utf-8?B?VGFOclFQYnMwTWZmQXIvaXhPbjFwK2toY2p0K2ZiYjFvdnJMNUxjWk9nVGFk?=
 =?utf-8?B?bkhjYVlUcnNva3BPcmxxWmRMeUs4YXdlTnprNVpPV3lCUTEvOE1MTnFFUm9w?=
 =?utf-8?B?TFh6YU1nbDRsRk5LRHdEN0MrcVBqcVpOcnBsYno4Y0xQOXZwTjloSm5lZHcy?=
 =?utf-8?B?Ynl3a09LL3ZmUnZVME5FS0V6WFZMN0JLUVVGczhwZTc5ZldkbjJ6cGdNM3VG?=
 =?utf-8?B?S0s4dEdoNmlBaDM2bXlTTzN1ZkZ6bXFkYTlVUkZCU0NCS3dUdG5nNmxQK0d3?=
 =?utf-8?B?bUdJMS9STXJHaEZXdkJIc0ZVTktneC9vZGhzVTJWTWhqWG1Ya0RUbW14R0tu?=
 =?utf-8?B?bFlZbFR6clZKd3FDS3NCa3V6dzVpS1lpZk9kd1JMN3RiMEg3WUtjVnM1eTM4?=
 =?utf-8?B?ejZoL0RwL0tsSzNJbjAxRUovUXJYU2xRS2xlK3N0TmgrVkpwTSswTkxldTEz?=
 =?utf-8?B?azZnSWorYkg5ZXVGTjV5TDBJRGZoTFRoQTFwZmFUaUtCRHl1NHEvaEcyR2ta?=
 =?utf-8?B?VnJUa0FQb3FzQmU1d05DMDU5UyswZWFSRFpMRGdSQUlxYW96YThIa3Roc285?=
 =?utf-8?B?ZGtYcWVmNUFhNGh2RjRVMW1oWnNMdGJ0Y1RGRVFyMnRKYlRtdndQSmxZb081?=
 =?utf-8?B?VGJVUGdMQjdEeHlGL2ZlQ0RLYys1bmZ4ODRBeU5mbnJheWxjMUVmbHJybVBW?=
 =?utf-8?B?eGZKcEJQc3dkK1duYlZyQld2WHVoK3NoUGovcS9MaWdicHJnazZpK2NEb2dT?=
 =?utf-8?B?VEdmUWwvR1k1MmFpUnlzakw5SG9SeVRRYmFDUm9wNGx2Smh0MzBjNU9Da3BX?=
 =?utf-8?B?U2xVbUQxeFNjTnFWK25EN1Z3eFJSRGFFbDI0SHdURlpJcUtGZkJaSGhiMkJl?=
 =?utf-8?B?ZXlOMHNrUS80TkUwTkRoYnViWUxNemcxbVp4U29Ja3JtVzhNUnkzRDNqV2xX?=
 =?utf-8?B?eTg2TU52dTZycDluOUVWN1pYUGMvNEQ3cUdFRGNmbSsyemhsTysxUkdhenZ6?=
 =?utf-8?B?MVZpNnhYaUlCaWdjNlFaRG00a0Q3ejR1bXV1aEM1SEdlY25FUFFDRHJHQ1Y0?=
 =?utf-8?B?VXFiNjhHOTIwU2hid01PNmxnQmpxL1ZzZnBJT3MrRnNSVjhGOElOWlFEelV4?=
 =?utf-8?B?VmQ0WjVjUHF6TWJETDJJQUdkNGRXRnZ6ZHd2T3ZsWGhLcHYzdzM2b0pHY2pT?=
 =?utf-8?B?VWRGZGphQmNaSEkyNlQ3b0lUSHpDMjFUdzlCcHN4bUsxSU9Qdm9vWktzYUtS?=
 =?utf-8?B?N3RzSWh0THM2bk5LVVNoT2ZZTUx4cXBQV1NNaFdvb3ZmSkVvdXROSWxHVmpM?=
 =?utf-8?B?QVV6VnNYeDVnZlYxQjczRzUzdUFnN1ZGOWZsWDdYQ1BERzhjY2l5ZzM2WXhk?=
 =?utf-8?B?WmNReVJtNGV4M1dIUkkxZ0JaVHQxallyQWpua0JsdFkxMjRLYkxuK0llc2h5?=
 =?utf-8?B?TjVhSVFsSFAzNHBERzZNWm5mdFRLTnovL2kyREUxUC8rWGdyOEwwdFZKeEsz?=
 =?utf-8?B?ZlRyZGVDSmZxekdxNEhOVi9Sb2FmVWdob2JVeEVQU2dKVnNzVUZYRlZHZlpx?=
 =?utf-8?B?SERadGR1UlRRMHJPbklEeGRML3Y2WldLVXdHckZLZHBBRkt1ODJmVmRVTXpr?=
 =?utf-8?B?dFNzQUhBQjlFTXlFdnpPa2hpNHUwUkUyaTg4MWJ5a3UzZ1VpM2F1Um83U05P?=
 =?utf-8?B?YnFkdzczajBJdnBFaHFBUWxLRlRmZ2x4SEhBdzFFWFc0MXF4U0t1UGUrbTNk?=
 =?utf-8?Q?poJtLnsLHECH5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTVGWnpGcUJIZmtaWXBnSjJMVTRXa3FLNmU5YUZSdjFrRXErTXQ1VjFGczhq?=
 =?utf-8?B?ZkVxV1FYcFR2dWhqTGNBSXUrRy8vNnBXdjRpZ1NnMnNjcmthY3VUZlc3ZzJY?=
 =?utf-8?B?NkprdVR4UmxQTFVuT0w3aitzcUowM3h0T2tIVmovQVdtWWZEZjJJZjlmRG85?=
 =?utf-8?B?MEY4YmhqbEcwRmdrb0NUeFF2NWl4bDQ2MzR6NW9lU1pka1ByOXJ5djM3S3ZM?=
 =?utf-8?B?MGxCNzZ0aHRBS3NOMU1aMjBtM2RnWU4rWHF0NEJEcFBMaEhLRlBIazFEWUN3?=
 =?utf-8?B?YW9kQ3cxN3FwejBMVW5vUUt2NTkrQlZwT0pLdEloRi9KaDkyVXZwdERXWUp2?=
 =?utf-8?B?SzBxTlpGNEVUeFFZQTJ0d0RGS3pNbmZBVEl2Ly9mV2J6dlVHdUNyQVA0cldW?=
 =?utf-8?B?NElmaTIyMUN3Q2dabWhhWTlOZUNJRXFnY3NRZHZjRExXNFllR2hlNFBpcm9y?=
 =?utf-8?B?OXV6RDFMMkdzNGt2WndDUTJ6ZHRzNHh0N1BCT1hLK29adDN5dVN0Q3lETlRz?=
 =?utf-8?B?a3pJbWYySDNwNVp4RzRRMFpPMm5iMHV3WGoybFBGRC8xQ1Bzai9QdDhyUUx5?=
 =?utf-8?B?aWV5U0RzcHE5cUd1TlpQMFhEOGlCaFFSOUhBWGgwOEh4UlVRYlIvOGxOSlI0?=
 =?utf-8?B?L012MllXS3k2QVJ2QXVsK3dVL3NLdVFnOWpSYTZuUW1NcVp3ZWxTTVlZbUdP?=
 =?utf-8?B?SXZyQXBhZ3NNd3VHeUN4Zm5IbWR2dkhhbnpTTk03TGtrVjlZWVN1RS9YekRE?=
 =?utf-8?B?UXJ1R3F6bnVyY2VsYWVTTGNzQ3U3RVk0Z0t5N2Z4QVI5bnVEcnRTYWpSZGVp?=
 =?utf-8?B?eGtvaHV5bjBTemI3cU4xb3RzamU2WnhpMXduQVIrb0NiV1MzNWl4YVJWMEpr?=
 =?utf-8?B?c1hiRGc5K3JsUCt4ZkhrYnNnWDE5S0tKamp0aE02UG9yUUt0ZmNPcmNKTnU3?=
 =?utf-8?B?SDZyQTRlWmlCUDhmSk1uZVBYMG1PaVE5TTU0dndWRk8xRlFMRC9IV2hRUlRS?=
 =?utf-8?B?ZTQ3LzBsaElXNWVJaTJoWjZxU1RjTHNFYVV2azRXbFpRVk1lTm1URjZxVU5o?=
 =?utf-8?B?bVppR1VkOVJMZU50ZUp0YnRZQ1NPTFhwaUVEb3pEeGRGSCtyTEpSVEdGbnRF?=
 =?utf-8?B?WllJYmtkVkQzWU5hd2FvSWVRc2Z2bW5CZUVDUldXWS9laFNtTnZwVnNpN0pO?=
 =?utf-8?B?ZytFYUxsSXp6dHJHZWU3OGRKdkxKeE1oOGRyVkY4dWtRL1hsNWNNYzM4N3Rz?=
 =?utf-8?B?T0lNNDJ5amg3Wk1LSDFOZ21iTFhzYjFDWWd1TVdWT0g1VzNldktjWXhUc0c2?=
 =?utf-8?B?aElMMFIxa25OSGUxb01xMENTTE8zUGdGYnZQRnZ0a1EwOFB3amFEaFg4bWFi?=
 =?utf-8?B?REROM1RER1FiOFNuQVBrRldiL1VxejZZN1lvb2pOU1VWVDVOR2lCNlpHVzBQ?=
 =?utf-8?B?aHFPTjdTTkxteFVieHcwSFVOTXVONjVhT3hmZHFpMjV5QVNYejd2b1dkZ3lT?=
 =?utf-8?B?eEdkUmp4ckgwRlJNWjM4b1JxcTZYNGY1UE83a1dqSDhWd0krM0QyK3BLaTFw?=
 =?utf-8?B?Zmp1c2xISUdRNktLWjZkRjMxczRpc0dJci94VlJyNmRFWFU4d0haMGtseGFy?=
 =?utf-8?B?c2lRaklCaDNBa1YwNWdoSk1USGdDK296MlM5TU5vNENxNWRRQUN6MGY4U3hN?=
 =?utf-8?B?NHE4RkFTTW9BRFhndkpIeklTKzgxdXR4MnRYS2o3RjVaMnU2SVNRSUJSYU1D?=
 =?utf-8?B?bTNxTmZ1WE5wVG41a05oWVduNHROdS8wOG85cE4wbFlRbDNRcmNFOURNaEFE?=
 =?utf-8?B?YldWUFV1aDNoNDRUMDhqNEZVZk5FTjl0TEZ3bnlhdnZnbGx0dlNZY3JHdlJn?=
 =?utf-8?B?TUJWZ2dxQnliRzdrdnNFOEJkRlhwczNvdjJDZ0pRSmtZU1pxem9OVXBuUTN2?=
 =?utf-8?B?Z3h3L3JDcTFxK29sRDFkc3dwaHprL25icDl6R2FOTkN4d2U1Z3JjYzUwSUdL?=
 =?utf-8?B?dTRUVkVrODRVNGVpUkJ2VENJRi9WdGgrSEJaNmJtS0o0K0dHaUs3ay82OXBv?=
 =?utf-8?B?bG9iOU9nVU1LRzYvVE1RTDk2NUdRK0hjT1FlYzIyQUluUS9tRzBabHU5N1Iy?=
 =?utf-8?Q?PSq0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e487708-0498-493e-1d1b-08dd2c1cd7f0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 17:34:15.1445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hO0p7F++XUN26X9krpjPtXegUbrvx/YjA1RmV6Na7UpEfQRii0TROvEvFWgbQwUR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143
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


On 1/3/2025 1:43 AM, Shuo Liu wrote:
> On Fri  3.Jan'25 at 15:02:38 +0800, Gerry Liu wrote:
>>
>>
>>> 2025年1月3日 13:58，Chen, Xiaogang <xiaogang.chen@amd.com> 写道：
>>>
>>>
>>>
>>> On 1/1/2025 11:36 PM, Jiang Liu wrote:
>>>> If some GPU device failed to probe, `rmmod amdgpu` will trigger a use
>>>> after free bug related to amdgpu_driver_release_kms() as:
>>>> 2024-12-26 16:17:45 [16002.085540] BUG: kernel NULL pointer 
>>>> dereference, address: 0000000000000000
>>>> 2024-12-26 16:17:45 [16002.093792] #PF: supervisor read access in 
>>>> kernel mode
>>>> 2024-12-26 16:17:45 [16002.099993] #PF: error_code(0x0000) - 
>>>> not-present page
>>>> 2024-12-26 16:17:45 [16002.106188] PGD 0 P4D 0
>>>> 2024-12-26 16:17:45 [16002.109464] Oops: Oops: 0000 [#1] PREEMPT 
>>>> SMP NOPTI
>>>> 2024-12-26 16:17:45 [16002.115372] CPU: 2 PID: 14375 Comm: rmmod 
>>>> Kdump: loaded Tainted: G        W   E      6.10.0+ #2
>>>> 2024-12-26 16:17:45 [16002.125577] Hardware name: Alibaba Alibaba 
>>>> Cloud ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
>>>> 2024-12-26 16:17:45 [16002.136858] RIP: 
>>>> 0010:drm_sched_fini+0x3f/0xe0 [gpu_sched]
>>>> 2024-12-26 16:17:45 [16002.143463] Code: 60 c6 87 be 00 00 00 01 e8 
>>>> ce e0 90 d8 48 8d bb 80 00 00 00 e8 c2 e0 90 d8 8b 43 20 85 c0 74 
>>>> 51 45 31 e4 48 8b
>>>> 43 28 4d 63 ec <4a> 8b 2c e8 48 89 ef e8 f5 0e 59 d9 48 8b 45 10 48 
>>>> 8d 55 10 48 39
>>>> 2024-12-26 16:17:45 [16002.164992] RSP: 0018:ffffb570dbbb7da8 
>>>> EFLAGS: 00010246
>>>> 2024-12-26 16:17:45 [16002.171316] RAX: 0000000000000000 RBX: 
>>>> ffff96b0fdadc878 RCX: 0000000000000000
>>>> 2024-12-26 16:17:46 [16002.179784] RDX: 000fffffffe00000 RSI: 
>>>> 0000000000000000 RDI: ffff96b0fdadc8f8
>>>> 2024-12-26 16:17:46 [16002.188252] RBP: ffff96b0fdadc800 R08: 
>>>> ffff97abbd035040 R09: ffffffff9ac52540
>>>> 2024-12-26 16:17:46 [16002.196722] R10: 0000000000000000 R11: 
>>>> 0000000000000000 R12: 0000000000000000
>>>> 2024-12-26 16:17:46 [16002.205179] R13: 0000000000000000 R14: 
>>>> ffff96b0fdadfc00 R15: 0000000000000000
>>>> 2024-12-26 16:17:46 [16002.213648] FS: 00007f2737000740(0000) 
>>>> GS:ffff97abbd100000(0000) knlGS:0000000000000000
>>>> 2024-12-26 16:17:46 [16002.223189] CS:  0010 DS: 0000 ES: 0000 CR0: 
>>>> 0000000080050033
>>>> 2024-12-26 16:17:46 [16002.230103] CR2: 0000000000000000 CR3: 
>>>> 000000011be3a005 CR4: 0000000000f70ef0
>>>> 2024-12-26 16:17:46 [16002.238581] DR0: 0000000000000000 DR1: 
>>>> 0000000000000000 DR2: 0000000000000000
>>>> 2024-12-26 16:17:46 [16002.247053] DR3: 0000000000000000 DR6: 
>>>> 00000000fffe07f0 DR7: 0000000000000400
>>>> e024se+0x3c/0x90 [amdxcp]
>>>> 2024-12-26 16:17:46 [16002.337645] 
>>>> __do_sys_delete_module.constprop.0+0x176/0x310
>>>> 2024-12-26 16:17:46 [16002.344324]  do_syscall_64+0x5d/0x170
>>>> 2024-12-26 16:17:46 [16002.348858] 
>>>> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>> 2024-12-26 16:17:46 [16002.354956] RIP: 0033:0x7f2736a620cb-12-26
>>>>
>>>> Fix it by unplugging xcp drm devices when failed to probe GPU devices.
>>>>
>>>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com> 
>>>> <mailto:gerry@linux.alibaba.com>
>>>> Tested-by: Shuo Liu <shuox.liu@linux.alibaba.com> 
>>>> <mailto:shuox.liu@linux.alibaba.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 +++-
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 1 +
>>>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> index 5ffe1dad9622..e7f35e3a6d2d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> @@ -164,8 +164,10 @@ int amdgpu_driver_load_kms(struct 
>>>> amdgpu_device *adev, unsigned long flags)
>>>>          DRM_WARN("smart shift update failed\n");
>>>>
>>>>  out:
>>>> -    if (r)
>>>> +    if (r) {
>>>> +        amdgpu_xcp_dev_unplug(adev);
>>>>          amdgpu_driver_unload_kms(dev);
>>>> +    }
>>>>
>>> I wonder if you can call amdgpu_xcp_dev_unplug here. It will call 
>>> drm_dev_unplug that unplugs a hotpluggable DRM device. In you case 
>>> amdgpu_driver_load_kms failed during probe time. We need unwind 
>>> amdgpu_driver_load_kms. Why need do unplug a DRM device?
>>>
>>> The backtrace show:
>>>
>>> 2024-12-26 16:17:45 [16002.136858] RIP: 
>>> 0010:drm_sched_fini+0x3f/0xe0 [gpu_sched]
>>> has:
>>>
>>> 2024-12-26 16:17:45 [16002.085540] BUG: kernel NULL pointer 
>>> dereference, address: 0000000000000000
>>> How this change is related to the invalid access above? Can you 
>>> explain more?
>>>
>> Per my understanding, `amdgpu_xcp_dev_unplug(adev)` is a workaround 
>> for design flaw of the amdgpu_xcp driver.
>> Currently the amdgpu_xcp driver assumes everything will go as 
>> expected and there’s no failure or GPU hot-lug operations.
>> So it only provides an interface `amdgpu_xcp_drm_dev_alloc()` to 
>> create xcp devices for a GPU instance, and another interface
>> `amdgpu_xcp_drv_release()` to destroy xcp devices for GPU instances. 
>> There’s no interface to undo what done by `amdgpu_xcp_drm_dev_alloc()`.
>> And I found `amdgpu_xcp_dev_unplug(adev)` can undo work done by 
>> `amdgpu_xcp_drm_dev_alloc()`.
>>
>> So it’s a workaround, the fundamental solution should be to enhance 
>> amdgpu_xcp driver to provide interface to unroll work
>> done by `amdgpu_xcp_drm_dev_alloc()`.
> Agree. Actually, some ops of amdgpu_partition_driver cannot be reused
> directly by amd_xcp drm device. DRM doesn't use its minor->dev as 
> param of such callbacks, just like .release(). When
> amdgpu_driver_release_kms() use a amd_xcp drm dev to find the `struct
> amdgpu_device *adev`, unexcepted memory accesses.

I understand the issue is from xcp driver, but I do not see it is a 
right workaround. The solution should be unwinding 
amdgpu_xcp_drm_dev_alloc(), not unplug drm device though part of 
amdgpu_xcp_dev_unplug(adev) may meet what you want.

still, the bracktrace has

2024-12-26 16:17:45 [16002.136858] RIP: 0010:drm_sched_fini+0x3f/0xe0 
[gpu_sched]

How the root cause of that is from xcp driver?

Regards

Xiaogang

>
> shuo
>>
>> The code paths to trigger the use after free are:
>> 1) in function amdgpu_xcp_dev_alloc(), we allocate a drm_device by 
>> calling amdgpu_xcp_drm_dev_alloc(), and then change the device’s 
>> driver to amdgpu_partition_driver.
>> 2) in function amdgpu_xcp_dev_unplug(), it restores drm_device’s 
>> driver to the original device driver.
>>
>> In function amdgpu_driver_load_kms(), if we don’t call 
>> amdgpu_xcp_dev_unplug() on error recover path, the 
>> `xcp_dev[idx].driver` will still points to amdgpu_partition_driver.
>> Later when amdgpu_xcp_drv_release() gets called, it will call 
>> platform_device_unregister() -> amdgpu_partition_driver.release -> 
>> amdgpu_driver_release_kms().
>> Here when amdgpu_driver_release_kms() gets called, the corresponding 
>> amdgpu_device object has already been released on error recovery path 
>> in function amdgpu_pci_probe().
>>
>> So just like amdgpu_pci_remove(), we call amdgpu_xcp_gpu_dev_unplug() 
>> before calling amdkcl_drm_dev_release().
>>> Regards
>>>
>>> Xiaogang
>>>
>>>
>>>
>>>
>>>
>>>>      return r;
>>>>  }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>>> index a6d456ec6aeb..ef4eaacf67f6 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>>> @@ -382,6 +382,7 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device 
>>>> *adev)
>>>>          p_ddev->primary->dev = adev->xcp_mgr->xcp[i].pdev;
>>>>          p_ddev->driver = adev->xcp_mgr->xcp[i].driver;
>>>>          p_ddev->vma_offset_manager = 
>>>> adev->xcp_mgr->xcp[i].vma_offset_manager;
>>>> +        adev->xcp_mgr->xcp[i].ddev = NULL;
>>>>      }
>>>>  }
>>>>
>>
