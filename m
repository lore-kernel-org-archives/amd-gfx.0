Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3069BCCD185
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 22:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C645510E901;
	Wed, 15 Oct 2025 22:46:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p5HSTQur";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1806810E2AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 22:46:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sr2sizpb419QS35xcmO6ZtVwHBbzgEFDowum31Wo66JDYxK5gm9zmp1iVLyRQJZnhFyRQlDddmsflFBvKXU5P5oH8hiDdHQzwraMDti08xw7F/5cl9EnhAgVSovgT3uip0n8wuMqz9vwcxX5IavyBBfQ02O2YTnEMe3mvzcyUSDFI8kfwrfoU+LP6OB3zvOwfYIXLHoaQzyBWGPxzAe2flNo0XuOQDsMi0h0PFmpe5bnssoTvKgnxqaZ79gQlPFxFZfYuE7rSZvB627bS8S1et7BEygjiR1WpVaM/D5Zm5LCeL2aG2vh0qIYduQnfva0dEoLu8tyVFnpFkGWB31YsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sp6aSgQv1K4SENWotLsUy+8niuTvCA3369pb+5urw+g=;
 b=PS2+69FG343Epcg1BRW1cRTIsxauPfCIiItbCEZZnIHinJkutA+qWqYz5Nkonlgl2s29uocK5OarKxeEQp/PcGhozoTrztnF3InpYFy66pt2KCa+POyqVbeJa9F5BECdF0rlwJQf3WGR7vphJdkxdYKt/e4Er41iP5jwuwNKDGQNPyVy9q5xwlROpjPKMgtvkIh6EJYglqi3RxUHQ2o6XNq7w0/u794EvIDjaThawcTXA5DRpG+ua78woxgxD9zh+jW5xohDVZvLH4fL7Ck1Lsny/uYTuO3wLJJussbXM24iITZhKpXDwtNDaQVYQl46N1+2dzP0atzN9xebKZtC7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sp6aSgQv1K4SENWotLsUy+8niuTvCA3369pb+5urw+g=;
 b=p5HSTQurp8pzCE6ZR7vrO/EbXztczPlUJSqQu1ocAwulBx7nbBkqlpTC0Q/UNOx4LP1qt2fNnCduYwegexZgxs55sEoxsRYoDZ5A1HK9amJtYHa9n7j8Ux/YX7EbjLWB7EyAHADPjTvcE1BeIjf6sJUuJugsekTBYOHFeDY44Io=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.9; Wed, 15 Oct 2025 22:46:03 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9228.012; Wed, 15 Oct 2025
 22:46:03 +0000
Message-ID: <39f7504e-a162-42bb-a481-6c2c7aa8e416@amd.com>
Date: Wed, 15 Oct 2025 17:46:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdkfd: Fix false positive queue buffer free
 warning
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20251015201134.2540-1-Philip.Yang@amd.com>
 <682f9477-ae2c-4022-be84-620cb02e388a@amd.com>
 <42c82bf6-e100-076f-18a6-43a50e758d8d@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <42c82bf6-e100-076f-18a6-43a50e758d8d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0160.namprd04.prod.outlook.com
 (2603:10b6:806:125::15) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|PH7PR12MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 10dfc2be-6de9-4733-72b7-08de0c3c9ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWxVc2JFMVNOTWFVWTJhM3hJTC9IbnphcU9obDQzY2U0clNvYlVtTUgwTFl4?=
 =?utf-8?B?OWNEdjlTc0FqSzJVVXppN1BEMFBIcnFQVENIK3NHTC9lM00wTS9lM3MvWWdt?=
 =?utf-8?B?bU85dnJOWUNCb3JJRGZmQ3JpYk04VmlIUU9hOHNyWGRyVXl4NW1nMG1ub2tq?=
 =?utf-8?B?ZHZWVFhQaDlyd2F5R0EvNTFKdFM3akE4RUMzMXcvYjE2N3RSRVFBN2VpYkJr?=
 =?utf-8?B?d0R5WnBISHpMeDkxZ2VudFNqeXorRncrcEkvcHdZZk9ONktNenpqemNLMVBN?=
 =?utf-8?B?Zk4xdlIzbk9pTVJXUWpzOW9EUnhhY2swakFhQ3crTmJQZDd5VlkyUS8yZXN2?=
 =?utf-8?B?VzZ5aXJOanB3bXdKcnRhOEZwclk2M1poYk51eEJKQUZZa3JnUWg5QUtuUk9T?=
 =?utf-8?B?TlpDZ1RhcEZPZ2lrdjFiaDJ2UGJBeFZEeVNWK3FMbC9MMlloQlFpZ1Vjc25v?=
 =?utf-8?B?NFEzLy9KcmtSNTQxV05Sa2FLQlBNNjNpNm5JMzMwZXNYQWlmQjRmVGhTcTJt?=
 =?utf-8?B?dCtFSi9kbUJ1N1VIU3h6am9yeEd4dFlFZXU2UDBtcVZpTXVvTHRPTGRxY2Ri?=
 =?utf-8?B?S3pYak9Id3RLQmszekxLajJhVGZ2eGhMYkpNdGIyUU4zQzRvL2NicEcxdVpl?=
 =?utf-8?B?ZDdrMndtNG4xNU5DMXVLcXplY2Q4TGZKazZhZFJlNGdQZTBjSWFSUG1wVWlR?=
 =?utf-8?B?TGxmRk5HNzRMaGdUNVFkZWhMOXNDNENRZTZJOGRDUUhEUlc2TERaOFgyaGd1?=
 =?utf-8?B?WXVEUjdMaXNxUituY3JJV3I3Q1ByUFF1dkF4UnpYOFZoTk5waWxHdVRsZ3Rn?=
 =?utf-8?B?U2E1TXVxSFIvaFlSTndua1pSamZkOFVhZTlTaFBlLzVLa0V2Nm9NQUlrR3Vx?=
 =?utf-8?B?SEgxaXN0MXFFNWxHTGNadUpjUndwSzMvUmhETEl6TkZrNWtLbG5oR0hrL1FK?=
 =?utf-8?B?dlBwTExndndJMlV0VkZxTXJIQ2gxQ0hYczNraXVuL2NEblM0UkdiSDJpZndk?=
 =?utf-8?B?QjBNcHRXeVlCV3NYTy95SmhoWlR1SHh6Vmkvc1Q1VlBMSGs2K0I0NTBIanRl?=
 =?utf-8?B?MWJNQWlraWZNclJMakpaNkZ5aFBQV2txMzYvNU01aE4vZFphZW83MU9EUWhx?=
 =?utf-8?B?ejlPV3JqYXNyeUFCbEtuSmp5bU9PMm1RclFKNzk5WWZUKzdZV1c2bkJnUklx?=
 =?utf-8?B?YmVFV2NBSmxOVjY0dkM5TmNkeUw1TUljb0hzOTJuTmZ1U1BqdHpFTURpcEpu?=
 =?utf-8?B?Q2RqZnJaRnZjbU82Sit3K3piRHVuc01idTlsWTFreWdBcFZ6Qi9QeHNjelJL?=
 =?utf-8?B?UDdQZmdoTnB5QnNFWUpTVklEYWFWOUt1QTRYUHUwNW54NFhTZGl2NWNVSzIz?=
 =?utf-8?B?WCtERzhHekRtTzc1dTMyQUxiYzNyektuSC9IejhCNWkrRmRrblJwTVlnbmgx?=
 =?utf-8?B?VzV1OGRrc2RqcjRjaloxTWpmRUo0K0tYREYxK28zam1tRHZydUdjVmxWbUpT?=
 =?utf-8?B?eUwrVUo2NUlmSXJVcVBJWnNEZ2RVeGVFc3N2UVlnb0FxaTI0dHdSZUl0Vi9D?=
 =?utf-8?B?dW5HUjh4QTVEdzlVN2ZGK09GKzFTSU5CYi83MU91VlZHbTZBZkpTRzBiV0hx?=
 =?utf-8?B?K3BUZEM0WVN0VjIyR0JXckRsd0FGNWJZRHV3ejcyOUs1empZYWhQYmtpdllK?=
 =?utf-8?B?WDQ5RVg2cGp1c2ZTeHBLaU5oMVRRYjh3V1B6TmpSaWUyRGdaS3R4M281STNk?=
 =?utf-8?B?b1lLa3hiUkhqRkF1bkxBTks1VUdMdVFoQXNvZXlBU0tGUDF4Mmg0RThKQ1RX?=
 =?utf-8?B?TlhISkphWEtMZ3BOMTk1aWt1R2xWTW1pYjFUWXVBcDBjU2M1WXNpMS9YYTZx?=
 =?utf-8?B?UjdRNitYbzZyaXdDZTdubEpyakQ2bGpLZWJseHora3ZsTThYd0VQV0U5VHhn?=
 =?utf-8?Q?ro7/mod0NmxTCja3N7QfnZTjWYQqwZR3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUhwcnRqOXZFc2Q2Q1FGaFMvQkVFSkttaHU2ZEs4a29vRStPNXFsT1JaMnBI?=
 =?utf-8?B?Y3Frc2NXVFh4a1ErTElqT2o2aE0ycDVTTVBuUVJDMEtGZVBROWJPTnplcm5G?=
 =?utf-8?B?VS9ySzU0Z0hMMTdlaHpGKzFXZWlhQWxyejFJWWJLdFhhVzF1NEs1TzBGbGda?=
 =?utf-8?B?NEdvRm1vR01vNmR1SjRQcWc2R0Ntd1BUSDY2WGl5WVVWQWNxMjh5SWs1dy9z?=
 =?utf-8?B?Q1pyNVR0NWQ5bVBtYXlyMWsvY2FaRXZOOFJ6QU9lRjhmZlNKb2xITzM4MVp1?=
 =?utf-8?B?clhvQXJtall5bmsrNk5kd2IybmZtZm1iYmZTYlpVMzZaM3UxeHVUdk53czh4?=
 =?utf-8?B?aG5Uc0NoSFlNa3dmRWxKZmFrWDJualhIREZLMmNnK05rSFBaYTlvS21pb3BI?=
 =?utf-8?B?bEtRQjg0QmpGc3orRXNtWU1QOW5BaEJoYTAwZ1M5VDkvVVAwWHpUOTRxRHYx?=
 =?utf-8?B?TzEwSXY1M281c0Y5MkFZVHBRbVZqU3pCS1JlSUhjaGdCYmR5UFVYUDlaRjls?=
 =?utf-8?B?V0grcHg0blpicGFjNDgvUDFPK1p2Ry9YM3VwVC9uS0xMU1NtM2NnZkliTFJy?=
 =?utf-8?B?MEg0Tm5HekhBR1JzbXhZNGx5UmJ6ZDdXcFJmVWxyZ0pGWGtINS9Yd0oxbEhx?=
 =?utf-8?B?UDhYLzltbzByTDNhTW5wb0NDOWN5SXc5c3JjTFl5T0NvUkxOTVJBWlluNjE2?=
 =?utf-8?B?aFlRcW9KL0pOZjlUakUrMHp1ZmhOMFdRc3NJMjZYb1RBSnBJTjZGMlE2bS9v?=
 =?utf-8?B?eHIySlFHMEJ6TnVqRW53K0lTZlVmNjFQd3dpa1B2Q0xQWDNzR08wS2VKWC9F?=
 =?utf-8?B?UE9EV0hpZWV4RzRQR0thYlV4bm0zNGR3TmZEQitiYS9Ya1dXNkI5MTFzRXFV?=
 =?utf-8?B?aVQ2elJZUVJmRTZOZ3hqV0Z5NHZaRS9ZV0x4OU04THU5RmJvTlluTWd3dnVl?=
 =?utf-8?B?NDRoRTdOOEtJc1FtUzJMVG14ZzdKYlI0WitPUTZZRHJudzVXL0tESnN3bE5n?=
 =?utf-8?B?VStDMUpiWFptNzhkOVVCWkRVVG9aRE1XS3lwM3dBYTR5d3pZQ2lrc0IySmxP?=
 =?utf-8?B?UGVDUzVZVkl2WDdXK2ZuSXE2RzFJY2tqR21mSVBORGJsZWhQekNGY2dLWGl4?=
 =?utf-8?B?QWg4RVpKdzRrck9xMFRVcWMwVWxzdVdWT1hjVGNHUHFqYjBzNG9KbUkvNXA1?=
 =?utf-8?B?TnhndWFTZ3d0aXJqbEwreWN1cDJmVUZhY2hwaitZeStUMXhlSGo4d0w0d3Z1?=
 =?utf-8?B?ZWZqa0IxdHdLZ2dqWlhOZ1lPSDN3SzBSMUpKcHJyV1R1SFlwNVhoUnBMNHV2?=
 =?utf-8?B?a2ZTaUJWRDhVMUlTcjNlY1o0cFhHQVhKdVpkZ1JSSXpLRDZDU1g2WHRRSnh6?=
 =?utf-8?B?c1RVeWVTZ25jR1ZmNzhZMlpja1lFWEV2MjF6NlFUZy9KdFhuTmp3aU83ZzVV?=
 =?utf-8?B?dlV2aWY4OTh4YnBIYWVRTC9NRkpub2l6S0w5bFNwZlg0TzA3MWVaVHR0Z1Nk?=
 =?utf-8?B?WXVoLy9TanR4VWpWRVRzZitqT0Uwb3pjcytGWUxDbno2YThBd05sRWZMR3p3?=
 =?utf-8?B?dlV4UFZyWFEyK3hwazAvYUp5dThPckdEVEpQRTJQTkduYWlzbDhmdGZKeDVN?=
 =?utf-8?B?RGRwODdodnFJa2JIbklzVEF2Wi9DemtUQXVpdWxRMk90SFNzVFlpMGZLdnFW?=
 =?utf-8?B?ckVSSWlyYVhMWkpBUDBSVlpNZGxtSXFZSmR5WHkxTXR5bnBKMGNhQ2d0TU9j?=
 =?utf-8?B?VFY3a1RZdklTSjBMZ2k3UmFxVXVrVmZhN2p0cVB3T3NjV0NiNGZ2bmMyNHNk?=
 =?utf-8?B?eTFFYkFjeHA5QWd3cWQzM2NXZDRNZm1vQlI2UXp3dVlja25zQmE1K245L3ZH?=
 =?utf-8?B?UUN1blhkOU1FYWNBSDVtMHlLQ0lFSXdrb0FSY1ZnVUo2dDFGRDZkZENTaTFp?=
 =?utf-8?B?Tm5EOEJsZGVIVmFBeTdYaE11dklOcFNybDYxdUJxUVFpVWtNUlFXUkdJN0g4?=
 =?utf-8?B?SER4K2ttR3dyYndkSEF5TVJPcmFYRDV4S0hhei9qcldUbUFvRnlDWW5iNGRy?=
 =?utf-8?B?VE1BMThYV2hlbUtNbzhRQTV2VndudHJ5elNQRUdwM2RCNmpmd0FieklrRkNn?=
 =?utf-8?Q?AedM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10dfc2be-6de9-4733-72b7-08de0c3c9ebd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 22:46:03.6200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DX3qj3GVLvkrdZeiByUI5rCX3YtC+tlHiKetFArWRtO/mBKeQooEdQle6uv4Bdml
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282
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


On 10/15/2025 4:45 PM, Philip Yang wrote:
>
> On 2025-10-15 17:01, Chen, Xiaogang wrote:
>>
>> On 10/15/2025 3:11 PM, Philip Yang wrote:
>>> Only show warning message if process mm is still alive when queue
>>> buffer is freed to evcit the queues.
>>>
>>> If kfd_lookup_process_by_mm return NULL, means the process is already
>>> exited and mm is gone, it is fine to free queue buffer.
>>
>> But another question is why a prange is still alive, its kfd process 
>> is gone?
> It is application process exited, kfd process structure still exist 
> and available. The issue is race condition:
>
>    do_exit
>       exit_mmap
> a.          mmu mm release notifier, schedule kfd release wq to 
> destroy queue
>              unmap_vmas
> b.                mmu_notifier_range(.. MMU_NOTIFY_UNMAP...)
>
> the step b is executed to unmap CWSR svm range, before step a kfd 
> release wq destroy queue.
>
>
>>
>> When unmap a prange the queues that use it should have been stopped. 
>> If not, there is problem somewhere. This warning message need be sent 
>> no matter kfd process exists or not.
>>
>> I think a real problem here is kfd process need be alive as long as 
>> any of its resource is still alive. In this case since prange is 
>> still alive its kfd process should not be released(p should not be 
>> null). If not we need wait all pranges from this process got 
>> released, then release this kfd process.
>
> kfd process structure is freed in kfd_process_wq_release after 
> svm_range_list_fini.

I wanted to say: delay remove kfd process p from kfd_processes_table 
until all resources of p got released. So when any p's resources is 
getting released p is available. That needs change kfd process release 
logic.


Regards

Xiaogang




>
> Regards,
>
> Philip
>
>>
>> Regards
>>
>> Xiaogang
>>
>>>
>>> Fixes: b049504e211e ("drm/amdkfd: Validate user queue svm memory 
>>> residency")
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 4d4a47313f5b..d1b2f8525f80 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -2487,7 +2487,9 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, 
>>> struct svm_range *prange,
>>>       bool unmap_parent;
>>>       uint32_t i;
>>>   -    if (atomic_read(&prange->queue_refcount)) {
>>> +    p = kfd_lookup_process_by_mm(mm);
>>> +
>>> +    if (p && atomic_read(&prange->queue_refcount)) {
>>>           int r;
>>>             pr_warn("Freeing queue vital buffer 0x%lx, queue 
>>> evicted\n",
>>> @@ -2497,7 +2499,6 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, 
>>> struct svm_range *prange,
>>>               pr_debug("failed %d to quiesce KFD queues\n", r);
>>>       }
>>>   -    p = kfd_lookup_process_by_mm(mm);
>>>       if (!p)
>>>           return;
>>>       svms = &p->svms;
