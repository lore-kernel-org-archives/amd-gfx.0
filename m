Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44343CA5FCE
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 07:42:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDCBA10EA01;
	Mon,  5 Oct 2026 07:42:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZXbfnnkz";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 967E810EA01
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2026 07:42:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xptBC0iTONX0kWTWhs4yvElyUMWWxNc3eWU2e67PcPJaxRmD2muoIJScrLkdtWk1IG2yWEEo//fqXbkPogIQR6LXO8sBmdJywEYcVWuS08SN042pANkUaA1SVgHPgyg7UgdmYdQVVGK/NLOG/10ndXtG29XdfAV+MD1DSo6mPXTZMM/l3rfO5zRRh8/XI8w+5U3Z2SaHDEECPc+a1O7P8T85yw93V43IAGb+KNjHJi3bdFUzjTh5j2//RjdpvCO2tUhWjA3EPbsUPY4vzW8/HRlbtaiymdRjDZaNVtsAX4PIkfB5D2wNYJb1zpjsh4xydfFtPoFbljzEeuUmd1/47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nuO+6aX+3c1omJ+X3cSxpIoZrDvR7bjqsMM7BrALLs=;
 b=Cvs5300hSyZD/+GkTlWt9VEMNAIPAIEafYyhb46c8vxMWaIZYV2eBFxKWG6HK0lnWI2agb9CKIe8Fahg5sbOMOFmXPp46fGpprfMXDbdx72PHsYb8y9nGpxG+7klMlJUxFLI1L/O8yVYlEanEGDw8XwbU9HTTdQ/+aBAAeb5BZR1DlWcRzSY+Toeq5/u+cTrovZyaJyRAuj3JnaUR9SXez59UPDw6sW/0E6FHTMKzd7U6I1HB5bxH3BztTYXAkTtexRRT8AXZz50Rs6IDifB62jldfMKBZo9RjCpc5x3fkec3gvwFeJxdioxpvZumosQzjo15m41TLHxlTv/DEiogA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nuO+6aX+3c1omJ+X3cSxpIoZrDvR7bjqsMM7BrALLs=;
 b=ZXbfnnkzcdzhu6Qe50JiqcTdA0EOSEsPVP/mWksGxie6JLah/L1ep6mIrNb/wr5JVC0JdgUYCwv+7JoC3FK2vDiopuJzxMKKEpwWRBFbi9HkmeuInfG8+Ps1qLF6ELMHLgZi1q3LTDERP3YuFSsVYn9Z4Nc3G6leqSQB2NMU1vg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Mon, 5 Oct
 2026 07:41:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 07:41:40 +0000
Message-ID: <91edc04d-c635-41e9-8ce7-88bbbb2b5938@amd.com>
Date: Mon, 5 Oct 2026 09:41:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdkfd: fix NULL deref and unbounded wait in
 teardown_processes on surprise removal
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: xiaogang.chen@amd.com, felix.kuehling@amd.com, alexander.deucher@amd.com
References: <20261003063817.36606-1-olivier.kaloudoff@gmail.com>
 <20261003063817.36606-2-olivier.kaloudoff@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261003063817.36606-2-olivier.kaloudoff@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0122.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::31) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: b0a3a525-4d59-44e7-bff0-08df22b41810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: i/ykXrVBiveDIAJPxOPPnxJmGxUqKUU6ReoMnhcPBWvkQtcHRDAZ1KtzTeemEV31daDXFDeo1a29ZcOADyt/EPJLSp8MDUJlUgOeCYnj0AdGxykzHWwtNbo7np7djU3FKwwXsIjYD2a/LGfRf1f5kgvlmNJ6lYqVmB6f4OcZ5PhVsXqf5atxf6oLtHVevfI3r8qAX+67nXkRWYMsZHQ2ngQu9BQFiom6Yj5s0aJh7BcobjuU2JfuvejLqk4ILw8WktX9QQ4JlulurSyndRbglnTGBhXe3MEEtHGxkEaCC6lwdqf/GVzsM3EObC/iDNVRr9UXJvIRnXsq7IBuN/kh00/vjj3VZuA/QjWuvz+sqm1NDoS0mMjxHNenqNQlMfmAT2ZClG2qJe1P69LPPSqYJvg3LQbyJFpYAMFWYADghjw+s2t1qNKGREkWXLOLiou27NMvyXpKU80YWYnV/Uk3omPlXa9fwRa3KmpxzTDj8LLXaFua6q1C8E1E/sJSJLKs+N2snmiU0Vrxn1VZ9qroj4ttnQo0+3y+e3vckV8BX2zu5s7E3cOTZUxPcZEHAvLVKAoGMNbFh7xfSH9/NTWby9zlVlgoFq0tcGmbh8iVLqhoACSa4H7oY99gH6Khh8n6Tqx5MShxlnPS8hLdgjt7j6C/iEPSdDOyNYkRTIP8SiU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWNOT1BmaDhiQ3lPL01SdGVSeGh6dFM2NkUwdTZMNytlUlJTbGMvREc0RGRw?=
 =?utf-8?B?MEVNb2N4N0pnaHY1akVvaWNzNlUrb1Zabk1lR0YrdzREc0djc1BrN0hXZ0Jt?=
 =?utf-8?B?SFR5TVhVQ0JWNnZNRDcrVlpHa2FTMlpjT3JldHhVMXlnZ1loR1RHdUl6cEJ3?=
 =?utf-8?B?bkl2K3FDUnlidWt3NDFoK3ZkbXZ6ODAwYWJsVzhVZCtEZ0tEaGJHOFJaOUQy?=
 =?utf-8?B?Wlc2dEtLNEhzTzRVS08zdEFRRHdxVHFEeU1YR0pKU0JycnpFSnNUVEZ1bnhM?=
 =?utf-8?B?M0tnVVlxYTJWdnlvMjlldmhnd1FZa214SHVUdnRKL0lWN24vUWlRbFM5OVFL?=
 =?utf-8?B?UFhHaksvQ1ZtU010eEd4SStpTXpjbmZ1NlFaM0NtRkNqc3FIVnNvdldQWmlK?=
 =?utf-8?B?cUdZajY3c3d6R0kxTmxXUlUyRmpackFveVhMdkVuRnhnN1hmQmpSZHEyUnJK?=
 =?utf-8?B?RVh3NXg4ZStBSTh1RkhRVUlTRlo4bTJlVHRsbFVpYjk1MGt0cmI1Q2l6Qi9U?=
 =?utf-8?B?Y3FyajEyVzhwemxJaGJhUjJPNE9qOXFVWjFONU5yUXRTMis5b3J1dXJUdFBQ?=
 =?utf-8?B?TlJnVEpQMklqTk5OclNhZ2tKdXZwYU9ZQnFTcStiQ1FqSEZUR2R3UnJ1OWlX?=
 =?utf-8?B?MGVidFMxR3F6M2dDUXdPc29TQVBTckFDVDlVTTg3cEpFS2EzWEJMODFUY25I?=
 =?utf-8?B?ZlJ6NFR0ajBsQ2hBQzBJTzhTUWxURXNYVFNrZi9IRUZoQjRyUEVpV2pOTkV2?=
 =?utf-8?B?WFZHbnhtbzBaQXNsejhwZzBRV0NqMDc3S2Zzb3FtcnN0OEtNWWxNSW00aHBz?=
 =?utf-8?B?OFhzdzU0K2FLeEMrcFAwc2FsMVJxRWJmRzAyL09pbHBJOVZDTk5vUGZCRDZO?=
 =?utf-8?B?eGZsdkVUT1NDTllFaU9mVFdQdFc5ejhxbTk4UWh5MklGaXVrZzhWY3RUeGRx?=
 =?utf-8?B?L0FoYS96SlpEMFV3d0Y4OEhCelE3cUJTdG1XeTZ3a0RsT2N4ajd1MGdoTVU3?=
 =?utf-8?B?VGs1RWI0QUdONmJlQnNjVzNWeXJlaVBjZm4xTlZTaHlOR1h1aUtYVENCN1RO?=
 =?utf-8?B?UmFEWFZhZmZteFRLekpQTXE0bGYzdURvZFBSZThWK2tEVVlDNWpLR1lIdjdH?=
 =?utf-8?B?a1FNbFZ0b1BPRHdyampRU05WeWcwR0tzZnZveG4zN1ZHUjJYbXFzWkFSUVlT?=
 =?utf-8?B?UnRpSElWdGt5ay9TTjRZSDEwM3FsT1E1QjdWRlJEWFJobWJpZDZXZGxvQVc5?=
 =?utf-8?B?NTRYL0lWMUx0YUIwT1lxaGdLcnZ3eit4TUtyN09PQ0NLdldZMkc4MnpwVk90?=
 =?utf-8?B?dlV3T0pIWDNKOWJrZU4vajJTaFFEaHF4b3RrbG1DcmZycXJpODlFTE1tam9B?=
 =?utf-8?B?VU42Q1ZqU0VBMDE5MitnbWtFVXRiSnp5eDVWM24vZGRwTHltMTcrWmx5ZGF6?=
 =?utf-8?B?d3ZQUVJPTjBOOU9WMVdlYTRWQ0x0MHhlUDVVOWR0S2hNd0RHTjZacjZVZndj?=
 =?utf-8?B?NlZMamNlckVZWWs1eTZmZG1FUmNCOStyQTZVWDRFdkp2WTAvVDFyeko0NEUy?=
 =?utf-8?B?TXZSS0plbTVKYlNlcERpVTBubmhFRW5FUWJSamNiSmFSRmQ1VWRyaUFhSXhj?=
 =?utf-8?B?WThpRHZGZGZFU2l1bFh3UFhGK3h3dHRqZ0UrSC9MaVJJY3o0M3BUeEl1Wnkr?=
 =?utf-8?B?YVhKMFNOK1VzcEV5Z2U4UHNvbFNJL0pkYjBZOXNvYXlaOXp1YWFkdFpRbzl5?=
 =?utf-8?B?UUtROEJjS0hDYmhoYTQ5d0ZrQlQ4VXZEbVZIMy9OVTB6ZDFERzRPYmZ4SUkw?=
 =?utf-8?B?bTVQQURmbkhKNzlpQmI1d0YrSVJnbkRpWWNFbzY0cU9DMHg0MXRtdnc1dXV5?=
 =?utf-8?B?d1JBOUpvMVdSWmVMWFRxVEREWDRQY0JxZDA0MW9DT2wrRnROUmFXOFdpVE4v?=
 =?utf-8?B?c3J0aUFOajNGUzMwN0ZtQ3hWblo0QU1LdEE1MlRqUnkwcG1YQjFFK05GSldU?=
 =?utf-8?B?MW80aWtVSDlMME9FVEp1NHlzYldtbnFwN3ozYmFHM05MT2RzbnpQSndzMzlV?=
 =?utf-8?B?eDNqaGFSblIyb3M5V2dxQUdJalVHdFNDSlNqVVRRRnpJTnhzMTRkS2FlYkh2?=
 =?utf-8?B?MmRSTlBtTFgvaERXUkpMWTlaOUhtN3JWczFUU2NUOUJxTWpvVWhYOVFVZ1RM?=
 =?utf-8?B?akl4dUxMZVp5QWJudEt3Vkd4ME1VRGJ5RGtTWmFISi8yenFodUFSTU9kbmlp?=
 =?utf-8?B?ZHMvZ3Z2dUJ4QUR2U2FHeSt1dU9pRGpmakEyS2Yya2FFM2NBMzhjRzlDTVp0?=
 =?utf-8?Q?buoH7BlxFoD2v49Hnw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a3a525-4d59-44e7-bff0-08df22b41810
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 07:41:40.5137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZyuSV4w9+boNgvmWNkfHZOmaQdDt6Zepe26NqiFG4ZsDAIkcE62zU9oTT+4KJ50
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835
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

On 10/3/26 08:38, Olivier Kaloudoff wrote:
> On PCIe surprise removal (e.g. Thunderbolt eGPU link drop),
> amdgpu_device_fini_hw() calls amdgpu_amdkfd_device_fini_sw() when
> pci_dev_is_disconnected() is true, which frees adev->kfd.dev and sets
> it to NULL. amdgpu_device_ip_fini_early() then runs a few calls later
> in the same function and reaches kgd2kfd_teardown_processes(), which
> unconditionally dereferences adev->kfd.dev->kfd_processes_count.
> 
> Observed on real hardware (MI50 eGPU behind TB3): NULL deref at +0x1b4
> (kfd_processes_count) inside kgd2kfd_teardown_processes, called from
> the pciehp removal thread; panic via panic_on_oops (pstore capture).
> 
> Additionally, the wait-for-termination loop is unbounded: on a
> physically gone device, processes can be unable to make forward
> progress, wedging the pciehp removal thread in cond_resched() forever
> and cascading into hung-task/softlockup panics.
> 
> Guard the wait on adev->kfd.dev and bound it to 30s with a dev_warn so
> removal can complete and the kernel survives.

That is clearly a really bad idea. Waiting for the termination *must* be unbounded.

The real question is why those KFD processes doesn't terminate?

Regards,
Christian.

> 
> Fixes: d12d05c4bc4c ("drm/amdkfd: Check if there are kfd porcesses using adev by kfd_processes_count")
> Cc: Xiaogang Chen <xiaogang.chen@amd.com>
> Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 586e640..9326447 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1780,6 +1780,7 @@ bool kgd2kfd_vmfault_fast_path(struct amdgpu_device *adev, struct amdgpu_iv_entr
>  void kgd2kfd_teardown_processes(struct amdgpu_device *adev)
>  {
>  	struct hlist_node *p_temp;
> +	unsigned long timeout;
>  	struct kfd_process *p;
>  	struct kfd_node *dev;
>  	unsigned int temp;
> @@ -1801,9 +1802,26 @@ void kgd2kfd_teardown_processes(struct amdgpu_device *adev)
>  
>  	mutex_unlock(&kfd_processes_mutex);
>  
> -	/* wait all kfd processes use adev terminate */
> -	while (!!atomic_read(&adev->kfd.dev->kfd_processes_count))
> +	/* On surprise removal amdgpu_amdkfd_device_fini_sw() has already
> +	 * freed kfd.dev before we get here.
> +	 */
> +	if (!adev->kfd.dev)
> +		return;
> +
> +	/* Wait for all kfd processes using adev to terminate. Bound the
> +	 * wait: on a physically gone device processes may never finish,
> +	 * and spinning here forever wedges the pciehp removal thread.
> +	 */
> +	timeout = jiffies + msecs_to_jiffies(30000);
> +	while (atomic_read(&adev->kfd.dev->kfd_processes_count)) {
> +		if (time_after(jiffies, timeout)) {
> +			dev_warn(adev->dev,
> +				 "kfd: %d processes still attached to removed device\n",
> +				 atomic_read(&adev->kfd.dev->kfd_processes_count));
> +			break;
> +		}
>  		cond_resched();
> +	}
>  }
>  
>  int kgd2kfd_reset_mes_queue(struct kfd_dev *kfd, uint32_t node_id,

