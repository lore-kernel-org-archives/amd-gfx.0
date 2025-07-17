Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B39C83F1A
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jul 2025 15:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21FE210E2FF;
	Thu, 17 Jul 2025 15:08:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DDeGwt5f";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5C3D10E242
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jul 2025 15:08:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIrB7nBcqi/RQMoShuWGv+YpYbsLbbabOynLYhs0dCKd7ffQ/IFocLHUC02xeV4UqyTtUCrMG/lgNyGf5uBP9ymaGz5/ShRJChN7isoLrGuk+rz4J+y95us9P9uDEglu0C7r08EX3qXcjnIZtHsI9Lo8Xx4dc/JXWqGpTmPTm4rgIyxLTiqhpKiQyBecsvHXOXQMuUVdedhLRP5oNPBjDQ08KJ7DFZMv3cw0x1gNQ653rjYwLLxyLA3Y3P8iCGcYzMonC6GyUMuUkEyfekwkSbXiy8VKNfFWFgBADypnxylTOL+phH9Edr84KpyP7vBrXGPUyyCFNJ75nkSuwOt7OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMxDsb7lE7rMxnCyChtlKN/mVRsnjxc/xBXM6Z9FY2A=;
 b=M4w91snAOq4BBJyZdaCUQbh8QXdjDRAUsmN+wQ7EbivqfX7w+7+XxQvkFkzoetk96sGDtanyo1gGjU+sHyfVt1Etqmx9ko/GaN+rYmvGx11+6LNc/VAEJGOH4WQhLkqTEgptrQN6gRc5/mnbc+vyEs1X1UG9fsYUvncO5S9uJ+dTf5Wt2/4YG2ISucyQTv8T5HPs/lS3n66xaWmehpWUUZReA4EJg6X5n2CMsC1CtVE8U1h/b0NOjOUnA7oL8aBTy5ACRxmSKSad8WFC2rd93mTtDoxvfabzpT8h9McVysamRksBirFzfoCPkCjb0cfw5HnUGgonfxKzlFoR/t6IMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMxDsb7lE7rMxnCyChtlKN/mVRsnjxc/xBXM6Z9FY2A=;
 b=DDeGwt5f68/UpXS9MMY7og6FBxJm+GQpPo4gOe6qbsT8Z7uYdA6sHrx2rcHDiRblaRs/hHNo2VxG4E/yodNUlTePGOvMTHu87htweAdW8O8ia2EXZ5iCHfS3qByBg8kHrRMVpayyTtxFx2ZqVRf++TN/7+G0UU5BGgEJ4Zq8T4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.40; Thu, 17 Jul
 2025 15:08:39 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 15:08:39 +0000
Content-Type: multipart/alternative;
 boundary="------------eui2O95T91DXmu15rNeaqcUK"
Message-ID: <9257c6d5-aa8e-495a-a198-80fc0eaa4055@amd.com>
Date: Thu, 17 Jul 2025 10:08:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Avoid extra evict-restore process.
To: Gang Ba <Gang.Ba@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip.Yang@amd.com, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
References: <20250716175753.703955-1-Gang.Ba@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20250716175753.703955-1-Gang.Ba@amd.com>
X-ClientProxiedBy: SA1P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::34) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|SJ2PR12MB8650:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e421af-0dc5-4712-987a-08ddc543cf7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3Q2azRHbkRzMldIeTJHQ1ErcTZueGFYODhLcG9pTUpaY2N2YzJvc290OThh?=
 =?utf-8?B?MldmcEJNZWUybWp4L0hsbkVwaWhRK3Ezbys1RTFTK3JtVmFkVURRUHFHeGs5?=
 =?utf-8?B?djd6QmpoYkxJSzVnOHc1b01CazJ6cUdUYkVwYmxIbzZCaFJpT0ZWODhwcWgw?=
 =?utf-8?B?S0NRSS9wUnc1ZmQvODBIYjRHZnZhd3oxd1NmNXl2blFCenc0KzF1QXViQWR0?=
 =?utf-8?B?QkhtV2J3dnRHRzJlV3AwZzNhczd5TFJDdERFWExab2l5TWZqRkZXTmxvcHZh?=
 =?utf-8?B?eUU4bG5ON0lNQTlrL2Joenp1djhTK3NvUmdJbkYxekpRakJITE8zUnZ1bVRz?=
 =?utf-8?B?VDM4UDNWN0dwZVA0WkZteEdGWXljRGp1bUQ5Yng3ZTVMcjVIZjBreFpHYTAv?=
 =?utf-8?B?ZXBWeUIwRitxMzFadFBhc0Z3MkpSTU8yelZGZ1JXa2VuOURIbTVIbW9XQzc5?=
 =?utf-8?B?QmI5RVo0UDFuem9HS0YzU1h0Q1MvakxBQWFVWlo1TG9HY08rdVF2U1J2bUdm?=
 =?utf-8?B?V2xwUDdub3NlQnNVNTdPU2hzK29OYUtoL1ZvVjVJNVhHK296eW9lalNLdUxY?=
 =?utf-8?B?bjFMWmpPUHpPd3BiR010Uk1Pdk9SRWVUamcrQTFBY1YzanRCL09DeGl5VGEw?=
 =?utf-8?B?Q2hyMFArWjhEL29oNjFPYXQ1eTQwMHpUZDhkUEJ3SmwyL3ZlUURYbzBJN1g5?=
 =?utf-8?B?WXFxVU5vYnZlTUI0YStxZE93WkRiSndrSm4yQzN6cGs0bnh4ZzhHd2VHTE1O?=
 =?utf-8?B?MmVpTXhHQ1U2c05sTmhIZHNtWkRzdTJGZ3A5S0REc0Q0d0VHUFZlR1pJTlov?=
 =?utf-8?B?bGdiUTNvd1lRZGRQSjA3QXVaS1lLN2g2dzJEWUpnajRNNHVpUDB6K1FLelh0?=
 =?utf-8?B?Qk9rMXN5bGIwaENQQzVxOXFTN2VoWGVHQVBFZVJCbHJ4RTNWTmw5cy94TDh4?=
 =?utf-8?B?b2NtSUR4TWk0REErV3JmaEwvck5OT1V2QVBIdmpvMDdMMU5BNE9GTmplbHl0?=
 =?utf-8?B?c2hxSWI1bE9IWUNjcEJKOHNlSmpPV2NQdVE2QnRwRUFCeFI5OFJ0NHkrTDU1?=
 =?utf-8?B?eUZNS1FJMFNtditiN0ZpVG05OVZUcnROam8weTlTdFNydmNBSWJtczZwUHZQ?=
 =?utf-8?B?MHJ5UW5GUzBONUtIYUpKU002OWFISDV5enY5azlmQ1pMU1RpTkJJRWl6bXBR?=
 =?utf-8?B?UXk4VEpUTVM2bCtZbDlWRGNBc0tYaEZHSTR5Mk1tWVhOZkZIVjBKYUNiWW00?=
 =?utf-8?B?U2pBZ1lWcVBkc0tMNVU1dUpFMWE0S3JjWUM1ZGZhRFV5RElHRThxME9NbGZs?=
 =?utf-8?B?cUpwUXBqd0g5b1Y0a3Zoc2dGWG5VTzZBZG1RR2VCY2NhLzJTeFREeVlqTyts?=
 =?utf-8?B?dHc3WmtqZDFtNFZBT1VCQmkzZ2tXZlpSL3VrVFNkSDkrRmRBdysrVFZRU29n?=
 =?utf-8?B?QXBYb1BZendiaG5UdE9GUHNjTGVnN1JWY1VMK2FZRm4rc1BCei9YMHE2TXJh?=
 =?utf-8?B?eG9qMENlcTJZSnpzOGJwcVE0RERtQTFVWWJKT0U4VWNqZmdKRDdFMXJKejdE?=
 =?utf-8?B?TXU0dkI3akRXZlUzbE5wc2J3N1c2ZmpvenR2dndiWCsvb0dsQnhsV08wRkJN?=
 =?utf-8?B?bjE5S0VNcExXRlFQZmNBY29xM0RvZjZvUkJzNlA0WFVIY3BCZXJ4UXBhSHpY?=
 =?utf-8?B?bFJuUUtPTGdjb2N1azlETFBwVytpQjIydmtpQVl4akYvQ01RNW1TTHI2RnRX?=
 =?utf-8?B?M2MweUZoREwvVUd5Z3d6YVBYM3J6K1Q2a0dacGwveURXNkx4TEVtTFVidHZa?=
 =?utf-8?B?a2xWZGlqMTR4bG9PZyttWklvMGdkeEdxRkl2RURHNGV5Y3lMZVpvOWZ4RVps?=
 =?utf-8?B?WTA3SFV2YmQ3aVZGTDdNQUs2Vk5TZlA2bFFLQWN3dWg0djFxUGZUcW5pZmxV?=
 =?utf-8?Q?cMFaeUZMtiI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVF6UWtqRjNKWENmZm55eCtNRE5PRGJYTldRZDBDc2UyL0tHMnJxSElXRVBT?=
 =?utf-8?B?dndnYkcrTmpPWnJENGJiMTcwNHFtVnBXRDNBd0hkS2VwWjJlZWJEb3NzUVFw?=
 =?utf-8?B?UWR0V2VrOTJOcXFheDRwaThNbkR6dk5qZDhBdFZEN05CbzdOak56WU5QY204?=
 =?utf-8?B?UXFlc3h2YnZHaEVpblpxd3hpcXdkVnZHdlgvM2F3MjJGcVpXU0J2ZjZlUzVO?=
 =?utf-8?B?d1pwV0cyNEU3RTlteFJGU0pYRTc4WmZXQWIvVFhaa2trK205ZVJFU2h2Y1cr?=
 =?utf-8?B?R2JWdTB4OFA5aE0zMGRmT1JxMzNUckZQNzI5OGFZT0cvM0RtY1VsUUE0SHc4?=
 =?utf-8?B?TmExTml1ZEJTamZMVDhZT3lSR0hPWDU1OUFaeHBwb3VMN2YyRElpT0NFRTFS?=
 =?utf-8?B?UFBKYWZkWEkvUmN1a1AyNUhzRW5HaVMwVHlIUVVwQkNLbjFtZEttdUoyRVNm?=
 =?utf-8?B?MU92czh1WEVlSlArbUdBYXVLTXpZYytGUVpzSjl5VEJVeDFVZ0dxVExvSkNH?=
 =?utf-8?B?NjhaaVc4Q29ocWJNanpPR0JqQytBcnp6cUg5VmtiaWxpK09qNWUyaUJRTjdo?=
 =?utf-8?B?QkRSUzZBaEV2M2ErTTFyazJWdzc0SHF3YnQzSjhDWG9BSlJiR1BiM3lmQnJi?=
 =?utf-8?B?SHJBeTBwQVBVTlp2TGhwTVVpSnU1b2FtWkIvVVhnMEthTFNGKzJlemJaV1dW?=
 =?utf-8?B?Y0hlWEY1RjVJK1RPcmlKOUJadWhmdzlrTjJOTGVjK3NzZmhMcGFXZE85Tnpu?=
 =?utf-8?B?WFd3VTRQUHcyOXdLR1hOK3ZiNjdtbXYyYjNpdnJGVnJMdkJrVnNZREJTeVAr?=
 =?utf-8?B?VmZDYkt3NTF1VDlRYkplay9TbmdZMXByUG5oZTB1ZUF0d0NZSzNRZytDRG1s?=
 =?utf-8?B?SXNKNVZSd3RsZ3NsOWIzbnNFeGNnNkszMkowSTVkVXpuaWtSVmZ4Mkh3SkdH?=
 =?utf-8?B?QVR3NkNrV1grWnMxSk9PbEg3aVo4Q0lvcU9jWXQ2SVd6RFhqblN6TlZSMkhB?=
 =?utf-8?B?K1dkZlJHUjFaT2tOY254bTk2cFh6aCt5Ylh2UENlenFaQ0tKK1YwVFc1SzVD?=
 =?utf-8?B?d1BqUUtkc0VQSXpJWnlSNWwrMC9iOVZyb251ZHVrZHNVVW1oVkFKVEZlOWgr?=
 =?utf-8?B?NjB6NXFMVjRFNVhBOWpOWTBGNE5hdm9ZNDZ2QkFEdHlKSHlBalRXVjJkLyt1?=
 =?utf-8?B?TVpCMWV6T2dFeTNCTGJGcnJ6cmcxNzlxMmhxUVY1K05wN1VYSXVOKzZjRmFm?=
 =?utf-8?B?bElrS3JrNGsyUHFYUHljaWQzZ2ZudHFEbkxnck93Wm5QWlVyNmV6SmxuSWdN?=
 =?utf-8?B?VzNobStBNnhuRzRNYkxqMWlzSDMwMlpYMlNjQzk3cjdWdy80bkxRZlEyZmY4?=
 =?utf-8?B?Q0pydlVCaysxMHBoSHB0RVlIWWppZVpHSjMvSUlRVlNDak04MzFIaTR3MUFG?=
 =?utf-8?B?ZjNBRU1uekc4UVM2a0dDS09nSzZCM0gyWVdXN2kwa1ZsaEZ2bW4rL1ljZjRs?=
 =?utf-8?B?aHJHOFQ2c0RVT21hVFM2STV0SFVZbTlxV1dQL1RscnJWbGEwa3dHV2FPaVV1?=
 =?utf-8?B?NEJMMW0weHpkcWYxanJaY0ZLSytjN3hqekQ4eklWZU9XVE1wcHNFTkU2eU9h?=
 =?utf-8?B?dGxxT3BKVjhITVg2a0ZNUUtTUVJGODlnRUx5MVFuenpicVV2SC9aTS8zVmNI?=
 =?utf-8?B?ZFJPN1NMZkJTdmZUVDZNYzZGSVZEbFlWenJPN0tsaTBGYzl4ZmVVNVVjY2Y0?=
 =?utf-8?B?bGxrUlQ4NlJGK3cxd3RsOUt2ZDBhU0tBeG1PUURjM1RPOWJONHIySFZnZUlh?=
 =?utf-8?B?V1Y2aTEzM0dsMHF4alU1dE9keVFsRXlRenlNckFVcXozeGlNbzlVTzlMRmNu?=
 =?utf-8?B?aUVXREVROHl1K3hUZVo1WlBUWDdFVktVRkNPTmtaR1pxVFVXQzRQMWdEWnlS?=
 =?utf-8?B?SllFazNOM1BVUFhLT04zUUNTR2xtbDVPV0hnWlI4WHZ0NjlxMmcrNTdyZUlh?=
 =?utf-8?B?VkxMNVlzWklqY3czeHYwZHRrazdmTkQydWZkQkN0Nm83TDBuUmZjTzlFa25X?=
 =?utf-8?B?dit3MVRmQzRiS2NKS1RkNmk5ZGZrVGRSSXU2TVVpckxwaWx0bmZhZys3c3VU?=
 =?utf-8?Q?PvP0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e421af-0dc5-4712-987a-08ddc543cf7c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 15:08:39.3080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XlTFqsrUT7bWh9bFNzA3mYK9OXSLPQPnOBgXqjlXs3KzmgBGX9AkbmQzwtoicYz1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8650
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

--------------eui2O95T91DXmu15rNeaqcUK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/16/2025 12:57 PM, Gang Ba wrote:
> If vm belongs to another process, this is fclose after fork,
> wait may enable signaling KFD eviction fence and cause parent process queue evicted.

The commit message does not target the issue description. amdgpu_flush 
got trigger from child process when it makes execve system call because 
render node has O_CLOEXEC flag. fork only does not close inherited file 
descriptors from child process. The back trace below also shows that.

Regards

Xiaogang

>
> [677852.634569]  amdkfd_fence_enable_signaling+0x56/0x70 [amdgpu]
> [677852.634814]  __dma_fence_enable_signaling+0x3e/0xe0
> [677852.634820]  dma_fence_wait_timeout+0x3a/0x140
> [677852.634825]  amddma_resv_wait_timeout+0x7f/0xf0 [amdkcl]
> [677852.634831]  amdgpu_vm_wait_idle+0x2d/0x60 [amdgpu]
> [677852.635026]  amdgpu_flush+0x34/0x50 [amdgpu]
> [677852.635208]  filp_flush+0x38/0x90
> [677852.635213]  filp_close+0x14/0x30
> [677852.635216]  do_close_on_exec+0xdd/0x130
> [677852.635221]  begin_new_exec+0x1da/0x490
> [677852.635225]  load_elf_binary+0x307/0xea0
> [677852.635231]  ? srso_alias_return_thunk+0x5/0xfbef5
> [677852.635235]  ? ima_bprm_check+0xa2/0xd0
> [677852.635240]  search_binary_handler+0xda/0x260
> [677852.635245]  exec_binprm+0x58/0x1a0
> [677852.635249]  bprm_execve.part.0+0x16f/0x210
> [677852.635254]  bprm_execve+0x45/0x80
> [677852.635257]  do_execveat_common.isra.0+0x190/0x200
>
> Suggested-by: Christian König<christian.koenig@amd.com>
> Signed-off-by: Gang Ba<Gang.Ba@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index ea9b0f050f79..2f75f967f95f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2414,13 +2414,13 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
>    */
>   long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
>   {
> -	timeout = dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
> -					DMA_RESV_USAGE_BOOKKEEP,
> -					true, timeout);
> +	guard(mutex)(&vm->eviction_lock);
> +
> +	timeout = drm_sched_entity_flush(&vm->immediate, timeout);
>   	if (timeout <= 0)
>   		return timeout;
>   
> -	return dma_fence_wait_timeout(vm->last_unlocked, true, timeout);
> +	return drm_sched_entity_flush(&vm->delayed, timeout);
>   }
>   
>   static void amdgpu_vm_destroy_task_info(struct kref *kref)
--------------eui2O95T91DXmu15rNeaqcUK
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 7/16/2025 12:57 PM, Gang Ba wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250716175753.703955-1-Gang.Ba@amd.com">
      <pre wrap="" class="moz-quote-pre">If vm belongs to another process, this is fclose after fork,
wait may enable signaling KFD eviction fence and cause parent process queue evicted.</pre>
    </blockquote>
    <p>The commit message does not target the issue description. <span style="white-space: pre-wrap">amdgpu_flush</span> got trigger from
      child process when it makes execve system call because render node
      has O_CLOEXEC flag. fork only does not close inherited file
      descriptors from child process. The back trace below also shows
      that.</p>
    <p>Regards</p>
    <p>Xiaogang<br>
    </p>
    <blockquote type="cite" cite="mid:20250716175753.703955-1-Gang.Ba@amd.com">
      <pre wrap="" class="moz-quote-pre">

[677852.634569]  amdkfd_fence_enable_signaling+0x56/0x70 [amdgpu]
[677852.634814]  __dma_fence_enable_signaling+0x3e/0xe0
[677852.634820]  dma_fence_wait_timeout+0x3a/0x140
[677852.634825]  amddma_resv_wait_timeout+0x7f/0xf0 [amdkcl]
[677852.634831]  amdgpu_vm_wait_idle+0x2d/0x60 [amdgpu]
[677852.635026]  amdgpu_flush+0x34/0x50 [amdgpu]
[677852.635208]  filp_flush+0x38/0x90
[677852.635213]  filp_close+0x14/0x30
[677852.635216]  do_close_on_exec+0xdd/0x130
[677852.635221]  begin_new_exec+0x1da/0x490
[677852.635225]  load_elf_binary+0x307/0xea0
[677852.635231]  ? srso_alias_return_thunk+0x5/0xfbef5
[677852.635235]  ? ima_bprm_check+0xa2/0xd0
[677852.635240]  search_binary_handler+0xda/0x260
[677852.635245]  exec_binprm+0x58/0x1a0
[677852.635249]  bprm_execve.part.0+0x16f/0x210
[677852.635254]  bprm_execve+0x45/0x80
[677852.635257]  do_execveat_common.isra.0+0x190/0x200

Suggested-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Signed-off-by: Gang Ba <a class="moz-txt-link-rfc2396E" href="mailto:Gang.Ba@amd.com">&lt;Gang.Ba@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ea9b0f050f79..2f75f967f95f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2414,13 +2414,13 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
  */
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
 {
-	timeout = dma_resv_wait_timeout(vm-&gt;root.bo-&gt;tbo.base.resv,
-					DMA_RESV_USAGE_BOOKKEEP,
-					true, timeout);
+	guard(mutex)(&amp;vm-&gt;eviction_lock);
+
+	timeout = drm_sched_entity_flush(&amp;vm-&gt;immediate, timeout);
 	if (timeout &lt;= 0)
 		return timeout;
 
-	return dma_fence_wait_timeout(vm-&gt;last_unlocked, true, timeout);
+	return drm_sched_entity_flush(&amp;vm-&gt;delayed, timeout);
 }
 
 static void amdgpu_vm_destroy_task_info(struct kref *kref)
</pre>
    </blockquote>
  </body>
</html>

--------------eui2O95T91DXmu15rNeaqcUK--
