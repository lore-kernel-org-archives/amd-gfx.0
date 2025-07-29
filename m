Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE3CC87FCC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jul 2025 06:27:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D05710E5CE;
	Tue, 29 Jul 2025 06:27:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kpkNC3bT";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2B4A10E5D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 06:27:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWJKIbarBlpr804+uJLCtn8jFRAvI6g/mS1ppDbXZc7AfpKyM4oS07GVLH4gWvquZ2GeFhJtVNDoEscNR4cbP62Udm7d7EYMg3H8GZh4KNu0wFaOBupCQy3KgTBpU4TbBzpFk5eoutyex4Z1y2pw7uLCkbWuP1L3jgEx69wLceyYlUVwRMLT9pMYk0gSTi8CBykSaexIo60J1XfDOjfwzmHyeYd2mTOJFbdcaSBFtGbpUi9ojTic/PTdL72m3Kd90+87CRKZR51ICbRk8CIxMnplz0b728OU6EnGa/bgbRqLTHNUqLiStOjFB9yMSe9KuxzVoRwg2pzlTfZyOGwPcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5rFhwsX4aW/iPtfguP7y07zBG3A30+w7GKtFtBGdN0=;
 b=l6IZYwFOgWHHaxu91z6PFKTd7MGP4cmUBHVjiVo1r7ZyBzvTtCVhuUJscqsBGQxEMhZ9T89HFDh6Qit9d5oUd4k76BalSTTdljpvqzPbEcsra2+lvOQqDgHawel7fH8jaFJnmxDa24MkwO3oXbej9A/sEKm1TtdD7PGXqxsyDu6TYYsz+o0lrTOSrgUZrC4r9MIanBuFK9idYY4expihi+y4IfyLAqssGdnoFvQtRAIyx5KLA2QG2jMV8RtzZ5Duqa9iOkU6vwZqIcJJywMgzj2SuNUkRkevCpWdhtUk9djJTuecdDUysKZ5Doxs35yKDHvADUSeFRtv1GVlLqBBUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5rFhwsX4aW/iPtfguP7y07zBG3A30+w7GKtFtBGdN0=;
 b=kpkNC3bThr+2sCu22pVq67Y8KFv8o3elQXS/yJQh6VEHeLHW1FsIFQ+R2W8zVLxVH2rklhvXM/YYy01LBuoTCM0oqznlZ3IpOAALF0r2U4P9u3OQ/vJIOSlV6biIgvzlpV1vo/rA0JRYqAxi44Rtk0VjVSj6PSjQ62WxOvdNJQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by SN7PR12MB8817.namprd12.prod.outlook.com (2603:10b6:806:347::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 06:27:22 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%7]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 06:27:21 +0000
Content-Type: multipart/alternative;
 boundary="------------suEWkzO8kY1JFGxoIScFCpJg"
Message-ID: <ab1fd244-ce71-44a7-a9e7-5d40399015b4@amd.com>
Date: Tue, 29 Jul 2025 14:27:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] amdkfd: introduce new ioctl AMDKFD_IOC_CREATE_PROCESS
To: Felix Kuehling <felix.kuehling@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250725024316.9273-1-lingshan.zhu@amd.com>
 <20250725024316.9273-10-lingshan.zhu@amd.com>
 <88f528e6-ab31-4864-8bda-60889a186059@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <88f528e6-ab31-4864-8bda-60889a186059@amd.com>
X-ClientProxiedBy: SG2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:3:18::14) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|SN7PR12MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: 49a72903-00ea-4251-7d83-08ddce68f9b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1o0dGpHSGhaR3laZnhESmg3a01ocWo5aE1abk4zYlVXVjZSQmJpbkJTNTRt?=
 =?utf-8?B?YTlYcmFFemRJOWV1cUhCUjFPajFub2FDQ3QzYjRnYU8yTjNPWnBoaDd6WnhL?=
 =?utf-8?B?ZFNKbUE5KzFXK21OQlZzYkRIMzBLLzJWRWFET1VsRlhyQmk0b0NWZ2k2RlQz?=
 =?utf-8?B?U2czUFhmU1EvU3prOFZJN2JLdUlUSjRjemZZcUdOekxWY0RiNVhrb1N1cnM0?=
 =?utf-8?B?ODVkZjgybXpmMytiQTFWV1A5cEFSYURhQzFFd3NVZ0lkWG0vNDgyRXJTb0Np?=
 =?utf-8?B?MGNFV3VXdzhJWFdPZXlFejBSelhCbHpIS0tZVUtDS0xlOFIwZXkyK1AzS1o3?=
 =?utf-8?B?OGpIdjN6NVFraU1CN2JobDJybUwzVVhsYjdHRGdLdkxLYjhuZ0VZalBPK2RL?=
 =?utf-8?B?Z2dRMi9JTXg5QUlOYjRjRFJqZTlwemNwd3F0am9Sdkl5SWVxWjV6ZVJxUWx4?=
 =?utf-8?B?U3ZVRE5CMVlaTEwvbHRpNmZhbTlWUlZ4REZGMUE2MEpFUXJ2cTdEWUlEVzlT?=
 =?utf-8?B?TzQ0eCt6NGNoMWEzU01BR0dGRE9SKy96OG1aRTNtZ2xFd0tRY1V4aXdLdnIw?=
 =?utf-8?B?YU1DQzZrYzdwVkNnbDZmZWFPejRxSzdPVVFDVG9pYjhOQU8zZUhmSm1kdUVE?=
 =?utf-8?B?bkNsWTlQeDkxUFF4YktQM2FWeTcxb2UvQ0NiTnlLc01ZSU82azJwc0FtbUo4?=
 =?utf-8?B?NzBTSUVHWS9VU2MyMWxGQUVFb0kxcEkwU1RGQnRQaWpPeWtZc2dIUFREU2dn?=
 =?utf-8?B?Undyb2wxVE5WN243d0hORGZZOS9HRnhwdXB1S1Y0WHhkcmljb215dVdyZVVw?=
 =?utf-8?B?UWE2U2J6RkJ1RkFLd2ovaTZ3QVhWM1VzOHAzS1pWNVZqN0h5SEJZQUxDQ1g3?=
 =?utf-8?B?aGRnSjVJYW9TZ05vbnhjV1NTVGlMRUFSR0cxQ1RqY29YZUxJVzh6aUo3QXd5?=
 =?utf-8?B?aUxOMHpzdHF2Mko3VTNXME5pZjZEL2g3VEdRU1pFN2R6TUpoQmZNM3cwZzN6?=
 =?utf-8?B?bzc0WmovdW9sbjAwYVVIVHg5WVlkcDVsWUZyZjc2ampYQkVKRUVzdU5rTTM2?=
 =?utf-8?B?YUhOM0p2b2JpS2tkQytIdWlnN00va0p0VGhtaFFjMEprcUNzbkV3VUZITmw0?=
 =?utf-8?B?dVRra0VuRDRVbW5GL3dRYVdxWE1oS05nUzI4Z2lxYUtPYVhISndZS3hZNE8w?=
 =?utf-8?B?K3A4aEZFemV6dFA2QXBBZndCdnErdklpNzlseGdGdVpCUWtNamJtWUFLcDg4?=
 =?utf-8?B?cmJHVUlmZ1ZWTGl1VG5JRlJoRmV6aEpqUEpQVFdWajZSOEY5NWpYLzh6emJm?=
 =?utf-8?B?b1hVWEpmdnpuNE1kbXI0WTEvckM0UC9HN0MyeGttNEhLMnIyRVppYU5zV3JE?=
 =?utf-8?B?UUZEajduYjhaZkpGdkNGYVlqbWI1Mlh1K2lmZ3AyR09uY25TWGFMbVVhVWMy?=
 =?utf-8?B?T0xvUnBBYnVrY0d0YXFqN3hkMUQ4ekM0NmpYNGVIU3dNMVBVT0hEWmkwc01a?=
 =?utf-8?B?UnZubFdleGcyTTg2UDNLZW9qNnFTZUY2TTUrUmhlb2VxVFpVSXd1dk5Hc0xs?=
 =?utf-8?B?UVhzVnBTYUZVb2dlaVRVOXlGWmw3R1lZeHhJQ2llNnhZdCtGTTU1ZlM4QTR2?=
 =?utf-8?B?L1FhS3daVWZkNnpQaHFOYlRaekR5SmFCQnU4T3NadXVyOWVaVG5CME9ZSWll?=
 =?utf-8?B?MGV0cnBFZ2thcGhtaFJrK2lTbmZDaUhJZGpWRUFMaTkrNDlZcVNYMkExd2VS?=
 =?utf-8?B?UjdBOWo3cDlwSFBDVVRINm9yYnR2UkVLZFQwSW1tMFJyd3RRZnR3dUpxcFdR?=
 =?utf-8?B?UG1CQmIyR3FhdVJKTGZ5RmxOYTEzc3lEOHZVTWlVaWtSRXdXbitpc2o1NXp0?=
 =?utf-8?B?RVluWUowWmVtRGxrWjkvN2ltZGMzWVl3M0JsSldHQWtTYzFRdjB3ei9CR0ZZ?=
 =?utf-8?Q?rEjXyEZWOZg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0p3cEkyOUxnSHhzTVhSWXJmQlRDVTRjeThyam9aUkx6dUQxVFBkMUthbkVj?=
 =?utf-8?B?cDdSYStDSVpMZTdhRXdWSzhUWUFVV0pLdXVmNVV0THFpQXZIeC92Si8wOVVK?=
 =?utf-8?B?TEcrYUlSNXd1QnNsQWFHY2tIZjlKL0FkKzhOTWlTc3AwdTZQdEU4bjBaa2Y5?=
 =?utf-8?B?ZnhBVlZTMkZyTUJnTVZQWStBcUJuRHdsRlp4SFBVWEU0blVpaXFoKzVzUk1P?=
 =?utf-8?B?b2Z3NVRtYkg2dnQvRjhTR2U0MmJXbmlBbWQ3T252M3lZOTdXUlNidVJWRGpj?=
 =?utf-8?B?bUxEU1Z1QXhVcWlaMUF3R0hnSko3eTdFMEFaTWlNTlhTaSsrb002V0U4bUlS?=
 =?utf-8?B?Znc3ZkxvYXZUcnpSKyt3QlErMEpGNDdONGpNK0pFam11N29Dd0VodGIxemFx?=
 =?utf-8?B?ZStJRURpVUdHZldGNnV1VWErUW9RRE9PWElvTHlTYTZtNUNNVGhvSndieG9j?=
 =?utf-8?B?NFZEc2t2ODRQOXhiU2RBM05Rc010MDFyUkZnNUNUUEFOTUNLQlVJU3hlMWdI?=
 =?utf-8?B?YVlLV1VVZTFMRFJHeGZXbVU3ZEJubW1wZTNOZURhY1Y3TEJNNFhpYUhkeE1H?=
 =?utf-8?B?SytndEhWRkpGZVJXZzlrWGRFSGIwSW9PYkFXSFVaMHlZY2p5YTM3eThUVXhM?=
 =?utf-8?B?OU5QVEtPMVdQM2FBWEVIc0NCTGxOQW4xYkFDdzZxb2VHam04M2lzM0VSL1FN?=
 =?utf-8?B?R2czL0JCa2RlcDcySkdkR1B4T3hNN2sxWmVEdzkzNnpTRzJzRDlmL2JRQTl6?=
 =?utf-8?B?dFJpVHJOT1k3TU54ZmVydUhtMndWdFQ2N2lhVWM3dHV6K2hXQ2xMVjRFV1Fp?=
 =?utf-8?B?YXdFSDRSaU1Uc0cyUGVMdWVXd05wSko1TEd1YmVWZEo4eEN0Q2I1M3FrSU53?=
 =?utf-8?B?QVJ5U3VkL2pQQjVoU01Pb1N1TEcrbDJibXMzVDk3S055NjJjb2hrYTJBdlRB?=
 =?utf-8?B?REZaakpLWXpmbTN6anBPeGVEVWtFanRyRUhEL294VkM0WU1kZGNVUE43NzNr?=
 =?utf-8?B?cWcrL2NNc2ppWUdMMXF2dk5VMmpPZVAyZ3NSMWhqVDVhUkFteUtzK0pkSHNi?=
 =?utf-8?B?aXp6Q3FvSzVZcEh0THk2N3hHZ2taOEZETENKWGZOZDIrRjFKMXVYUG1LV21q?=
 =?utf-8?B?K05KdHpBQllpaDI5RXBmTkQwdElvZDJSeE9yeThPUlUydGVMR1pGU01ib3I5?=
 =?utf-8?B?SWZYdzg1OUJKdXRlNTBBR3Y0TkIxUTExbmJncjUva25WZGVCRnV4Wmo1Mm5R?=
 =?utf-8?B?cGpKVHRvMlExdnI5aG1RbXhMVGR6NW4zYXl3ZjBHc3dUaEt4UnNvOFhSdGtK?=
 =?utf-8?B?Rlh0bWZUUDExQU12cDJQeXN3UlVjU0kvR3RDY2pJTnRESnRPVlRZdHUyOTFk?=
 =?utf-8?B?aDdaenBObm84ZzRqc1BaMjc2REJMSTdmMS9MaDZsTEI5RHExamdtUHVVaStj?=
 =?utf-8?B?WFZ0UEZ0UmMrVzZZVnJtN0Fmd25CbXVCckFkNmp6NzhzOVdkQ3VZVmpPS0Vz?=
 =?utf-8?B?SkpqYWZqR2gxUGJFdUVLSmp3M0FjU3dnOHMxTXNnZ2x4U0h3SGNWU0VBRktJ?=
 =?utf-8?B?MlA3Q0RaUnZOUlhZZDBFcWtBMG9xeDZ1M2QrQTlQblk1Ukt5MnhYbzRaSWt3?=
 =?utf-8?B?cndDdVY1bStnek1CVi9TTUhOa2VWL1NZNWI1Rm9RNVRsTU1SQjVTM01lSlRX?=
 =?utf-8?B?REpBZlViWGtVMDhiYVY1UnFyc0dYbGtOcVdpTG5aSDFuTVdTTkFMdmZWaG9s?=
 =?utf-8?B?YkFkWEh3QkdOT3N6dlFPV05hMzV2ZEsvVGJGOHRNMVNsRjhUaXFwbS9lRTBP?=
 =?utf-8?B?amlQZ1FaQjBLMExDZXpiamRqTzFrMnZPU0Q0c3hYTDBXQTFWbC9yOTVONEFi?=
 =?utf-8?B?YjNxbW1OMWdLd0Y0TGZVeTR4VFFNRlJuQWRndVMvdnFyWEFEMGtydTdvZDBj?=
 =?utf-8?B?SXE3VVpPQ2FrWDA5Ums4QStoTWtZSVVEaWNaUk1ZSXFGN3IyLzl5dzI2RHlM?=
 =?utf-8?B?SEk5SDRCQkR2eEFnV3ZGYzRPTEhPdUdJYVFCNmg5eUwwMUt0Y043T0hZcmRR?=
 =?utf-8?B?aEZ5RGM4ZEZpOU5adS93WEo4MHZXMHlxTDZxQmdFbDYxWjlzUlVqcjBoQTRm?=
 =?utf-8?Q?HjvQ3Gx9mQIcLwWzTl4KnkdHU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a72903-00ea-4251-7d83-08ddce68f9b0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 06:27:21.8687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUG+ob5nasM/fQonZ//+wJjdkhBfCOaS/FA9JgG8R4HeagOUqoycLLs6wu4IuMIoCbhTpbXxtVPae3Z5P16z6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8817
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

--------------suEWkzO8kY1JFGxoIScFCpJg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/29/2025 3:59 AM, Felix Kuehling wrote:

> On 2025-07-24 22:43, Zhu Lingshan wrote:
>> This commit implemetns a new ioctl AMDKFD_IOC_CREATE_PROCESS
>> that creates a new secondary kfd_progress on the FD.
>
> To add a new ioctl upstream, do you have a link to the corresponding
> user mode changes? 

I have tested the code locally and we are developing kfdtest for multiple contexts.
This new ioctl will not break any current use cases.

I will post my local test program for this ioctl in the cover letter.

Thanks
Lingshan

>
> Other than that, this patch looks good to me.
>
> Regards,
>   Felix
>
>
>>
>> To keep backward compatibility, userspace programs need to invoke
>> this ioctl explicitly on a FD to create a secondary
>> kfd_process which replacing its primary kfd_process.
>>
>> This commit bumps ioctl minor version.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 41 ++++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  1 +
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c |  3 +-
>>   include/uapi/linux/kfd_ioctl.h           |  8 +++--
>>   4 files changed, 49 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 5b22e1c47b2e..f9c43ff8a89f 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -3136,6 +3136,44 @@ static int kfd_ioctl_set_debug_trap(struct
>> file *filep, struct kfd_process *p, v
>>       return r;
>>   }
>>   +/* userspace programs need to invoke this ioctl explicitly on a FD to
>> + * create a secondary kfd_process which replacing its primary
>> kfd_process
>> + */
>> +static int kfd_ioctl_create_process(struct file *filep, struct
>> kfd_process *p, void *data)
>> +{
>> +    struct kfd_process *process;
>> +    int ret;
>> +
>> +    if (!filep->private_data || !p)
>> +        return -EINVAL;
>> +
>> +    if (p != filep->private_data)
>> +        return -EINVAL;
>> +
>> +    /* Each FD owns only one kfd_process */
>> +    if (!p->primary)
>> +        return -EINVAL;
>> +
>> +    mutex_lock(&kfd_processes_mutex);
>> +    process = create_process(current, false);
>> +    mutex_unlock(&kfd_processes_mutex);
>> +
>> +    if (IS_ERR(process))
>> +        return PTR_ERR(process);
>> +
>> +    /* Each open() increases kref of the primary kfd_process,
>> +     * so we need to reduce it here before we create a new secondary
>> process replacing it
>> +     */
>> +    kfd_unref_process(p);
>> +
>> +    filep->private_data = process;
>> +    ret = kfd_create_process_sysfs(process);
>> +    if (ret)
>> +        pr_warn("Failed to create sysfs entry for the kfd_process");
>> +
>> +    return 0;
>> +}
>> +
>>   #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
>>       [_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags =
>> _flags, \
>>                   .cmd_drv = 0, .name = #ioctl}
>> @@ -3254,6 +3292,9 @@ static const struct amdkfd_ioctl_desc
>> amdkfd_ioctls[] = {
>>         AMDKFD_IOCTL_DEF(AMDKFD_IOC_DBG_TRAP,
>>               kfd_ioctl_set_debug_trap, 0),
>> +
>> +    AMDKFD_IOCTL_DEF(AMDKFD_IOC_CREATE_PROCESS,
>> +            kfd_ioctl_create_process, 0),
>>   };
>>     #define AMDKFD_CORE_IOCTL_COUNT    ARRAY_SIZE(amdkfd_ioctls)
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index a6e12c705734..a2b5081fbfc0 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -1051,6 +1051,7 @@ struct kfd_process *kfd_get_process(const
>> struct task_struct *task);
>>   struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
>>                            struct kfd_process_device **pdd);
>>   struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct
>> *mm);
>> +struct kfd_process *create_process(const struct task_struct *thread,
>> bool primary);
>>     int kfd_process_gpuidx_from_gpuid(struct kfd_process *p, uint32_t
>> gpu_id);
>>   int kfd_process_gpuid_from_node(struct kfd_process *p, struct
>> kfd_node *node,
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index e1ba9015bb83..15a8de2275f4 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -71,7 +71,6 @@ static struct workqueue_struct *kfd_restore_wq;
>>   static struct kfd_process *find_process(const struct task_struct
>> *thread,
>>                       bool ref);
>>   static void kfd_process_ref_release(struct kref *ref);
>> -static struct kfd_process *create_process(const struct task_struct
>> *thread, bool primary);
>>     static void evict_process_worker(struct work_struct *work);
>>   static void restore_process_worker(struct work_struct *work);
>> @@ -1598,7 +1597,7 @@ void kfd_process_set_trap_debug_flag(struct
>> qcm_process_device *qpd,
>>    * On return the kfd_process is fully operational and will be freed
>> when the
>>    * mm is released
>>    */
>> -static struct kfd_process *create_process(const struct task_struct
>> *thread, bool primary)
>> +struct kfd_process *create_process(const struct task_struct *thread,
>> bool primary)
>>   {
>>       struct kfd_process *process;
>>       struct mmu_notifier *mn;
>> diff --git a/include/uapi/linux/kfd_ioctl.h
>> b/include/uapi/linux/kfd_ioctl.h
>> index 04c7d283dc7d..1d206ecc831e 100644
>> --- a/include/uapi/linux/kfd_ioctl.h
>> +++ b/include/uapi/linux/kfd_ioctl.h
>> @@ -44,9 +44,10 @@
>>    * - 1.16 - Add contiguous VRAM allocation flag
>>    * - 1.17 - Add SDMA queue creation with target SDMA engine ID
>>    * - 1.18 - Rename pad in set_memory_policy_args to misc_process_flag
>> + * - 1.19 - Add a new ioctl to craete secondary kfd processes
>>    */
>>   #define KFD_IOCTL_MAJOR_VERSION 1
>> -#define KFD_IOCTL_MINOR_VERSION 18
>> +#define KFD_IOCTL_MINOR_VERSION 19
>>     struct kfd_ioctl_get_version_args {
>>       __u32 major_version;    /* from KFD */
>> @@ -1671,7 +1672,10 @@ struct kfd_ioctl_dbg_trap_args {
>>   #define AMDKFD_IOC_DBG_TRAP            \
>>           AMDKFD_IOWR(0x26, struct kfd_ioctl_dbg_trap_args)
>>   +#define AMDKFD_IOC_CREATE_PROCESS        \
>> +        AMDKFD_IO(0x27)
>> +
>>   #define AMDKFD_COMMAND_START        0x01
>> -#define AMDKFD_COMMAND_END        0x27
>> +#define AMDKFD_COMMAND_END        0x28
>>     #endif
--------------suEWkzO8kY1JFGxoIScFCpJg
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 7/29/2025 3:59 AM, Felix Kuehling wrote:</pre>
    <blockquote type="cite" cite="mid:88f528e6-ab31-4864-8bda-60889a186059@amd.com">On
      2025-07-24 22:43, Zhu Lingshan wrote:
      <br>
      <blockquote type="cite">This commit implemetns a new ioctl
        AMDKFD_IOC_CREATE_PROCESS
        <br>
        that creates a new secondary kfd_progress on the FD.
        <br>
      </blockquote>
      <br>
      To add a new ioctl upstream, do you have a link to the
      corresponding user mode changes?&nbsp;<br>
    </blockquote>
    <pre>I have tested the code locally and we are developing kfdtest for multiple contexts.
This new ioctl will not break any current use cases.

I will post my local test program for this ioctl in the cover letter.

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:88f528e6-ab31-4864-8bda-60889a186059@amd.com"><br>
      Other than that, this patch looks good to me.
      <br>
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">
        <br>
        To keep backward compatibility, userspace programs need to
        invoke
        <br>
        this ioctl explicitly on a FD to create a secondary
        <br>
        kfd_process which replacing its primary kfd_process.
        <br>
        <br>
        This commit bumps ioctl minor version.
        <br>
        <br>
        Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 41
        ++++++++++++++++++++++++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp; |&nbsp; 1 +
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c |&nbsp; 3 +-
        <br>
        &nbsp; include/uapi/linux/kfd_ioctl.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 8 +++--
        <br>
        &nbsp; 4 files changed, 49 insertions(+), 4 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        <br>
        index 5b22e1c47b2e..f9c43ff8a89f 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        <br>
        @@ -3136,6 +3136,44 @@ static int
        kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process
        *p, v
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp; }
        <br>
        &nbsp; +/* userspace programs need to invoke this ioctl explicitly on
        a FD to
        <br>
        + * create a secondary kfd_process which replacing its primary
        kfd_process
        <br>
        + */
        <br>
        +static int kfd_ioctl_create_process(struct file *filep, struct
        kfd_process *p, void *data)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct kfd_process *process;
        <br>
        +&nbsp;&nbsp;&nbsp; int ret;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (!filep-&gt;private_data || !p)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (p != filep-&gt;private_data)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* Each FD owns only one kfd_process */
        <br>
        +&nbsp;&nbsp;&nbsp; if (!p-&gt;primary)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; mutex_lock(&amp;kfd_processes_mutex);
        <br>
        +&nbsp;&nbsp;&nbsp; process = create_process(current, false);
        <br>
        +&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;kfd_processes_mutex);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (IS_ERR(process))
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return PTR_ERR(process);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* Each open() increases kref of the primary kfd_process,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * so we need to reduce it here before we create a new
        secondary process replacing it
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp; kfd_unref_process(p);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; filep-&gt;private_data = process;
        <br>
        +&nbsp;&nbsp;&nbsp; ret = kfd_create_process_sysfs(process);
        <br>
        +&nbsp;&nbsp;&nbsp; if (ret)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_warn(&quot;Failed to create sysfs entry for the
        kfd_process&quot;);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +}
        <br>
        +
        <br>
        &nbsp; #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags =
        _flags, \
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cmd_drv = 0, .name = #ioctl}
        <br>
        @@ -3254,6 +3292,9 @@ static const struct amdkfd_ioctl_desc
        amdkfd_ioctls[] = {
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDKFD_IOCTL_DEF(AMDKFD_IOC_DBG_TRAP,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_ioctl_set_debug_trap, 0),
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; AMDKFD_IOCTL_DEF(AMDKFD_IOC_CREATE_PROCESS,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_ioctl_create_process, 0),
        <br>
        &nbsp; };
        <br>
        &nbsp; &nbsp; #define AMDKFD_CORE_IOCTL_COUNT&nbsp;&nbsp;&nbsp; ARRAY_SIZE(amdkfd_ioctls)
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        index a6e12c705734..a2b5081fbfc0 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        @@ -1051,6 +1051,7 @@ struct kfd_process *kfd_get_process(const
        struct task_struct *task);
        <br>
        &nbsp; struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device **pdd);
        <br>
        &nbsp; struct kfd_process *kfd_lookup_process_by_mm(const struct
        mm_struct *mm);
        <br>
        +struct kfd_process *create_process(const struct task_struct
        *thread, bool primary);
        <br>
        &nbsp; &nbsp; int kfd_process_gpuidx_from_gpuid(struct kfd_process *p,
        uint32_t gpu_id);
        <br>
        &nbsp; int kfd_process_gpuid_from_node(struct kfd_process *p, struct
        kfd_node *node,
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        index e1ba9015bb83..15a8de2275f4 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        @@ -71,7 +71,6 @@ static struct workqueue_struct
        *kfd_restore_wq;
        <br>
        &nbsp; static struct kfd_process *find_process(const struct
        task_struct *thread,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ref);
        <br>
        &nbsp; static void kfd_process_ref_release(struct kref *ref);
        <br>
        -static struct kfd_process *create_process(const struct
        task_struct *thread, bool primary);
        <br>
        &nbsp; &nbsp; static void evict_process_worker(struct work_struct *work);
        <br>
        &nbsp; static void restore_process_worker(struct work_struct *work);
        <br>
        @@ -1598,7 +1597,7 @@ void
        kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
        <br>
        &nbsp;&nbsp; * On return the kfd_process is fully operational and will be
        freed when the
        <br>
        &nbsp;&nbsp; * mm is released
        <br>
        &nbsp;&nbsp; */
        <br>
        -static struct kfd_process *create_process(const struct
        task_struct *thread, bool primary)
        <br>
        +struct kfd_process *create_process(const struct task_struct
        *thread, bool primary)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *process;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mmu_notifier *mn;
        <br>
        diff --git a/include/uapi/linux/kfd_ioctl.h
        b/include/uapi/linux/kfd_ioctl.h
        <br>
        index 04c7d283dc7d..1d206ecc831e 100644
        <br>
        --- a/include/uapi/linux/kfd_ioctl.h
        <br>
        +++ b/include/uapi/linux/kfd_ioctl.h
        <br>
        @@ -44,9 +44,10 @@
        <br>
        &nbsp;&nbsp; * - 1.16 - Add contiguous VRAM allocation flag
        <br>
        &nbsp;&nbsp; * - 1.17 - Add SDMA queue creation with target SDMA engine ID
        <br>
        &nbsp;&nbsp; * - 1.18 - Rename pad in set_memory_policy_args to
        misc_process_flag
        <br>
        + * - 1.19 - Add a new ioctl to craete secondary kfd processes
        <br>
        &nbsp;&nbsp; */
        <br>
        &nbsp; #define KFD_IOCTL_MAJOR_VERSION 1
        <br>
        -#define KFD_IOCTL_MINOR_VERSION 18
        <br>
        +#define KFD_IOCTL_MINOR_VERSION 19
        <br>
        &nbsp; &nbsp; struct kfd_ioctl_get_version_args {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 major_version;&nbsp;&nbsp;&nbsp; /* from KFD */
        <br>
        @@ -1671,7 +1672,10 @@ struct kfd_ioctl_dbg_trap_args {
        <br>
        &nbsp; #define AMDKFD_IOC_DBG_TRAP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDKFD_IOWR(0x26, struct kfd_ioctl_dbg_trap_args)
        <br>
        &nbsp; +#define AMDKFD_IOC_CREATE_PROCESS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDKFD_IO(0x27)
        <br>
        +
        <br>
        &nbsp; #define AMDKFD_COMMAND_START&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x01
        <br>
        -#define AMDKFD_COMMAND_END&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x27
        <br>
        +#define AMDKFD_COMMAND_END&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x28
        <br>
        &nbsp; &nbsp; #endif
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------suEWkzO8kY1JFGxoIScFCpJg--
