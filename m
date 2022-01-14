Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8793EC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 22:37:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFA6B10E286;
	Fri, 14 Jan 2022 22:37:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BA0110E286
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 22:37:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xly/8V89Et/mQYCOYeHM9aIfiyjRxnOXcyVLkHR8Wk7HJMwn9hdK3tNzpesCFAK7uLVXBVhNVE+lH0Io/CLnUOuvc211NAQ6+NCn9p4x65i6/SvVQHNbroHQ0g1BThuHD92ugPvvcx3oASOnj5XmTp/fjc1gZNwJYaX98ON62ItG1vOBVOg98yOM2NlLYsXzJ95PEbvSqKUvpI46MwFxUcclmf/9+Roo2IP0stMTnzeyZgukgdXgvicoO23tbVet0n9Ng9eXDDCQ8s2sP5z5J6ArlzOijnKmZ9xV0Rl9Pw/EI2kTgAN6ZVEnIwxVvIR7Y0qOTAOLnDl1cz2Z/O+o9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CTMFPuA6OAB01nacTrYBUC2PGabnrKbIaWe4stmuW8=;
 b=hO3/EFlNjX1TvDaK01MsOJ9l+Gp2cbzJiIrfqDMpTbTwiVBGOZmhsXbi0eGuJ1pQA6sUpAZOEISPulYzOJkvS2uNe2WXoA3d35bBovPaOmpX/IpTYBS86jOrYcCQS18Qum1afmmSmr6GslliXM9/KO54/9mlpB3jkEfSDc7lxAddbUHB5iEi+SVjp2antTcyzpfzaam2sla0urEm5UdwUabCOlPO4JO67hHSIZXv/mUnPYLOcssybgmRSiEod6ua00ffL5RHEDHzjxlP/iiDWTJ+4m83v5nU5E5Rx1hcX6Nk89IwCy0seP3oxopTrA07j/K4CSExd/CQTi+pzLnkSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CTMFPuA6OAB01nacTrYBUC2PGabnrKbIaWe4stmuW8=;
 b=ptiiZ5aTzPYoC74zZLgyOID4nRh8whpR1gXMm62IMc7Kaox3rwcW0xy7ZJdxvVckrD0sJE9nXZ0Zauc7ohjPZblVPkcfg2q4/B4cHRckG7PItPskdZKEC7mmYzxfNAD1HIKtQ0T5z7xybEinndutoOxLDgehOasv/uxoQQIDFd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Fri, 14 Jan
 2022 22:37:23 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 22:37:23 +0000
Subject: Re: [PATCH 3/5] drm/amdkfd: add page fault SMI event
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220114203839.21707-1-Philip.Yang@amd.com>
 <20220114203839.21707-4-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <47b948f0-c004-b3d1-d5f9-0cbf1db1f21e@amd.com>
Date: Fri, 14 Jan 2022 17:37:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220114203839.21707-4-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c74d9fda-7000-4e63-40a8-08d9d7ae6e87
X-MS-TrafficTypeDiagnostic: BY5PR12MB4193:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB419354A8E2E59DF80FA1102692549@BY5PR12MB4193.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oDO3aChnn/Zdv4uUalqs2rPwcBhAaQ/aY1/dx4TIV++oEGw7CT4Lqht5aTV7pkGX1qAakO6L+hKWAC2+/jr1r9TNzzbDvhPDBpDQrfpiP00RhGSWMUnc2POqNUem2acNnHTktGfpIPuLL6+vgib2GVT1PQCY0B8jTsq18f7fJTl4p+cjW40uUZ+B1vXViXqSEApJH/xnJjqql5pTgn/xcT8TuyeYKUumQ9H2jJvKamn9WBn+Yvswfr/k4gwutCIYrFmbrCl8gt+3cw7pvcjAQ52fG0wLyKyteq3h/BGj2bfy8xBuSTMe+AhiRgJ+pGZH7wibRmHYfzYjj1IjdLsqbYzF3AKAm9oczPsy8W8vVK4aWFobvrFi1B1KwgvQHGvlJ0s0Z3CAyMl8eW/EUW6MNhF9JNMSYU/AqRjJ6hs3M7KRVp9uyFDiNEfghVSYKwTGvLcRDgX13Yp1F6ASa4Ht0y5UdcBajH35VGcUfw7Iv1pKUrrYIdUl+G5kwi7B6THxIqFj0vjO9IjK2gd2jgny1Ppcy8UBvOHlyXgOGiK5XbRPBBowUDZ3MNUEbG8MoeCg4uK4+uL6DfEkIDfSRtghI5lMx7Zhtg9NuR5V9qByE664XLTmuphfCdTPdbn/Rk7LOX2LbbFqWrFo3pg8kfeziGAPUnePQd19W2VxUezPGKunQKjg6vtdKsgSbzaRor70/YTba8elMm1GBJqpcsgpwTbQGQasx8Vge5OmhbH/0XDPGb2gFhKK06y2+rEy+O/+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(5660300002)(44832011)(31696002)(316002)(38100700002)(2906002)(508600001)(66476007)(66556008)(8676002)(2616005)(6506007)(6486002)(186003)(26005)(31686004)(36756003)(83380400001)(8936002)(6512007)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXZydDZUdTZDYzE3QTVEQ01vMDFqZnZ4YjVMQk5rdkpHZGNrVXZ2bjF0amVR?=
 =?utf-8?B?bmJCQUtTQzV2WVYrbUVIbklIaEkxNWl3WjVWZ2lOYTlXckVtbHEwdGJQdVc0?=
 =?utf-8?B?dWFTaXg2MTZzQk9kTnZCY3VMQm9ZRjVyZWF6SnphcHN6dTdZeVQrTjFXRHJV?=
 =?utf-8?B?VVF6LytXcUU2MHBhWkV5U0VSSVM3Skdna0pYd216RlJDakQ4VGRPd2Y1a2xN?=
 =?utf-8?B?SVkrbXZscStCcHNWbnZka1lMTFg1MFI5UEttUWZaZnAvUEsrUnBoMmtHRVRn?=
 =?utf-8?B?VlkvNDJkZmYzRVdvZ2U4U2pmOEVGNEJsZ00yd1FjdEM2RUNoODdmY3h1QU5O?=
 =?utf-8?B?b0llVW91dDFGRXIwemhVRHpQVTg4ckFYVFJLZmdDZm9HWUYyeVh4OCtRckhk?=
 =?utf-8?B?T2lqVEFyS0V0SUQ2U29DM2hxNWxqT25mdUd3cjVQeVNqUmRES0NTcTV5VU5z?=
 =?utf-8?B?NE9vUFJEUExGY2w5RHZIYU0xMXQ0MGpYU3JML09McjZNSnhSVXJmVjRtbEJQ?=
 =?utf-8?B?azhxWXNMVzJNMlo3Y254clpqTlNWeWpPOURTYStYYkFkeFBDVGRCcGVoWmlH?=
 =?utf-8?B?b29PTkYrTW5NSjlyZno4UG1SZ3hDUXd0ZHczL2VmK04zODVQbmxPdCttZkMy?=
 =?utf-8?B?YUk4TmJiTXpmMllocFZFWmc0VHJYMWpMd3AxSEZvMW4wQ2FqY0dOK3dyQ2pT?=
 =?utf-8?B?MjNIc01GOVIzVHpuUnFNcC9MWWZIVm45c3VVSmxLMFY5SmRXVkpIVGtvS2Fq?=
 =?utf-8?B?NWNTVG5KeXUwZnNsUjBkVi9NNzlMdTJxcTNXWU4rOEwrR0hublc0R3hrM2Mv?=
 =?utf-8?B?dnlBSkdyUHI3WWN5S2t2Tm5pVDR0ajc3WS9VRWhpZ25XQWhxTGRSOXJYVng2?=
 =?utf-8?B?ZmVvN1Rwdm5ZcjUvYUJoMXZpUUlDOCttNnRnREpFUTVwNTlxeDRDbFFDZ1VU?=
 =?utf-8?B?UU4xM1pVNi9BRTFrc0U0TWx0U1RVU2FHVmxVYW10NUJDbFhabzhtdnV2c29x?=
 =?utf-8?B?ZzRHVStXSmdHUVdkbTVzdE9SYlJid0hQbkdkY1N5ZU5QbzhOdlFqVVFlRFYr?=
 =?utf-8?B?Tk5UWGd6VVBYa0FESUFvYkcrYWNGaFZOZXhUR3ZDR1Nhb3IxWDA3NjBrZ0tx?=
 =?utf-8?B?U211M1RUeG1RemN5S0lhKzVWNjlVS1FwQjdYemlZTlozQXRXbXdhbWtDTTZh?=
 =?utf-8?B?UEoyb1JCaUFHOXRweEpHTklFUStwd05zRTlvL3hXbldpcnZHS2JyaGUyVjh6?=
 =?utf-8?B?NHVaSW8yYVNxUVRTdXVRT1pRME5ZSHB0ZjZ1bkhKNHNXZWZKSnNkSy9XV0ZD?=
 =?utf-8?B?MkZSR1djZmhJZUJKRXh2WTJPZjcwaE1CMHRWT05OTElhZWZiaks1VlUweUpS?=
 =?utf-8?B?bWVyeEVnWUU1ZFpQSmFqY2FGWlRIQXYzQ0FHczI5emJCNEZtamMvcnRnNjBq?=
 =?utf-8?B?TkFCL1JqbHRsSFpxemZ5MkdhWThkOWFtdllzMGtRT2hBSTMyalBlWU12bzY0?=
 =?utf-8?B?TjlaeElLUy9Ocy8xd2dERGVqaVZEeGw0aXAxazRwOFBKODUyZVdjSjdBKzcy?=
 =?utf-8?B?cVhWQW1PeHJwSVVGVkRaZnYyRVVjU3pWdG1uRjNld3luN3k1QjRhNWtLOUY3?=
 =?utf-8?B?NlpKbG5EM2s4MXdUSjdrRkNsYXlieEx3eU5CVFdxSTFwMmhic2NiWG1hNVdl?=
 =?utf-8?B?RmdzSGIyMUY5SmJHcnc5bDMwNFE4My9XNlBtdVpMbmhmODhlQmRPWDZyc3FC?=
 =?utf-8?B?SFBmenZWRmxtbzhZN1pnaWFlNTlxczNmZHdQdGZqYzdHMVRzSXlocVFLeE5J?=
 =?utf-8?B?MmNYaXgwWkt4aEpBNldDWm1OcWN3dG5nTkpaN05BZThWMS9CblNoeXhaWllR?=
 =?utf-8?B?bk90OCtOY3dOVkdvazE4SFZlRmpjRjJHSlJ1S1NJTVd0UDFTVVRiWlBlbjhw?=
 =?utf-8?B?K3FTRlgzZW53WWxYb3BlUjZQMHo2bm5wcFFZcmtaVUJJK25kc0xuTndoRG1j?=
 =?utf-8?B?WFA2TUhKSFdqaGhwSDFzWDBSVFV6MzdNRzNzYjdTbHZGenBvTzkzNGJZRnpU?=
 =?utf-8?B?OWo3UzRPeUVwWTlKeFpqbG43WDgvWCtYcVZjNm1NOHAzWkNEQWR4ZzlRcnJE?=
 =?utf-8?B?dy9tQWo3Wk91K3F2akgyMmtIT2ovSnJTemt5UHRCWHF0cjhqNmw3c1hyV1c0?=
 =?utf-8?Q?sXW/XnNqIbdZXh0ZaIdrarM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74d9fda-7000-4e63-40a8-08d9d7ae6e87
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 22:37:22.9045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hoTXjhgUKkCdMnOoS6DsKWvc0Uy8b//Np+gKz+oI3f4mR+wb3casdYsfu0py9mxiGaE0XU9yuzs86ZYLBvLtjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193
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

Am 2022-01-14 um 3:38 p.m. schrieb Philip Yang:
> After GPU page fault is recovered, output timestamp when fault is
> received, duration to recover the fault, if migration or only
> GPU page table is updated, fault address, read or write fault.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 41 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  3 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c        | 12 ++++--
>  3 files changed, 53 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index 5818ea8ad4ce..6ed3d85348d6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -265,6 +265,47 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
>  	add_event_to_kfifo(task_info.pid, dev, KFD_SMI_EVENT_VMFAULT, fifo_in, len);
>  }
>  
> +static bool kfd_smi_event_pid_duration(struct kfd_dev *dev, uint16_t pasid,
> +				       pid_t *pid, uint64_t ts,
> +				       uint64_t *duration)
> +{
> +	struct amdgpu_task_info task_info = {0};
> +
> +	if (list_empty(&dev->smi_clients))
> +		return false;
> +
> +	amdgpu_vm_get_task_info(dev->adev, pasid, &task_info);

The caller (svm_range_restore_pages) already knows the kfd_process. It
should be able to provide the pid directly from p->lead_thread.pid. No
need to look that up from the pasid and vm task info.


> +	if (!task_info.pid) {
> +		pr_debug("task is gone\n");
> +		return false;
> +	}
> +	if (pid)
> +		*pid = task_info.pid;
> +	if (duration)
> +		*duration = ktime_get_ns() - ts;
> +	return true;
> +}
> +
> +void kfd_smi_event_page_fault(struct kfd_dev *dev, uint16_t pasid,
> +			      unsigned long address, bool migration,
> +			      bool write_fault, uint64_t ts)
> +{
> +	char fifo_in[128];
> +	uint64_t duration;
> +	pid_t pid;
> +	int len;
> +
> +	if (!kfd_smi_event_pid_duration(dev, pasid, &pid, ts, &duration))
> +		return;
> +
> +	len = snprintf(fifo_in, sizeof(fifo_in), "%d ts=%lld duration=%lld"
> +		       " pid=%d pfn=0x%lx write=%d migration=%d\n",

Please don't break the string over several lines. I believe that would
also trigger a checkpatch warning.


> +		       KFD_SMI_EVENT_PAGE_FAULT, ts, duration, pid, address,
> +		       write_fault, migration);

The existing events use %x for all numbers, including event number and
pid. Maybe better to stick with that convention for consistency. At
least for the event number.

The existing events seems to favor a very compact layout. I could think
of ways to make this event more compact as well (still using decimal for
some things for readability):

"%x %d(%d)-%d @%x %c%c", KFD_SMI_EVENT_PAGE_FAULT, ts, duration, pid,
address, write ? 'W' : 'w', migration ? 'M' : 'm'


> +
> +	add_event_to_kfifo(pid, dev, KFD_SMI_EVENT_PAGE_FAULT, fifo_in, len);
> +}
> +
>  int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
>  {
>  	struct kfd_smi_client *client;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> index bffd0c32b060..fa3a8fdad69f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> @@ -28,5 +28,8 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid);
>  void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
>  					     uint64_t throttle_bitmask);
>  void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset);
> +void kfd_smi_event_page_fault(struct kfd_dev *dev, uint16_t pasid,
> +			      unsigned long address, bool migration,
> +			      bool write_fault, uint64_t ts);
>  
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 37b3191615b6..b81667162dc1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -32,6 +32,7 @@
>  #include "kfd_priv.h"
>  #include "kfd_svm.h"
>  #include "kfd_migrate.h"
> +#include "kfd_smi_events.h"
>  
>  #ifdef dev_fmt
>  #undef dev_fmt
> @@ -2657,11 +2658,12 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>  	struct svm_range_list *svms;
>  	struct svm_range *prange;
>  	struct kfd_process *p;
> -	uint64_t timestamp;
> +	uint64_t timestamp = ktime_get_ns();

kfd_ioctl_get_clock_counters uses ktime_get_boottime_ns for the
system_clock_counter. We should use the same here (and in the duration
calculation) to make it possible to correlate timestamps from different
KFD APIs.


>  	int32_t best_loc;
>  	int32_t gpuidx = MAX_GPU_INSTANCE;
>  	bool write_locked = false;
>  	struct vm_area_struct *vma;
> +	bool migration = false;
>  	int r = 0;
>  
>  	if (!KFD_IS_SVM_API_SUPPORTED(adev->kfd.dev)) {
> @@ -2737,9 +2739,9 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>  		goto out_unlock_range;
>  	}
>  
> -	timestamp = ktime_to_us(ktime_get()) - prange->validate_timestamp;
>  	/* skip duplicate vm fault on different pages of same range */
> -	if (timestamp < AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING) {
> +	if ((ktime_to_us(timestamp) -  prange->validate_timestamp) <
> +	    AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING) {

ktime_to_us takes a ktime_t. But timestamp is just a time in
nanoseconds. I think the correct conversion is just div_u64(timestamp,
1000).

Regards,
  Felix


>  		pr_debug("svms 0x%p [0x%lx %lx] already restored\n",
>  			 svms, prange->start, prange->last);
>  		r = 0;
> @@ -2776,6 +2778,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>  		 prange->actual_loc);
>  
>  	if (prange->actual_loc != best_loc) {
> +		migration = true;
>  		if (best_loc) {
>  			r = svm_migrate_to_vram(prange, best_loc, mm);
>  			if (r) {
> @@ -2804,6 +2807,9 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>  		pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
>  			 r, svms, prange->start, prange->last);
>  
> +	kfd_smi_event_page_fault(adev->kfd.dev, p->pasid, addr, migration,
> +				 write_fault, timestamp);
> +
>  out_unlock_range:
>  	mutex_unlock(&prange->migrate_mutex);
>  out_unlock_svms:
