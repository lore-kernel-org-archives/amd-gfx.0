Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F17C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 14:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C52CC11B28C;
	Thu, 30 Jun 2022 14:19:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03E831139D4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 14:19:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kciPOD6YSESlvQ93jo9lf2y4OeX9QosIVvevYX1dq1hiFpVbPeeqi0ecQ2fZavxR8u3+F+ZQCUeMhFgXc2oh6AH81V+XP6pAhcnnoY2rY2Cf7upozJ5YFm+V1FBdJRdR9ltd3pnjz8b/7A++rzeiGsnvxdTMgaQC0yZ1tpKcb1z37fRItkydn45dr1WHed1e5F98p7GtudLKtuO2fCHIdNRt5akRtIKsR629vmNdgbKokH8YTUSkF8wruwIwds+/wXbtzQZ38O8B6H5+9wCq52nC/zwHfVaWvVJKe/RoiQx1JFWZGs8X9rOlNkj890y369bkN9LI26JTY3/uL2Bfdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gCEO5Wm+58vKpgPgmGJOG668TPwSFqBnXGJFJ1Bai4=;
 b=XOzZ/1oAhp28TCo5IcAeT6I5kiu/aykTafsN9wtEPHK8i/wgOQyibBDNYZsGBhj+0t5P/WWR5TM9VjzL+nDY+2R+0fg/n1b7cpNxiMdl3T1FPDGbuLYug1hO/38TRPKExwTSbFXYdBgdgr9kV7nZ2UKuYTrIsbxkQxPMRi8dQ9kQOtBQnGFllNISviRR/CkfBOKxJVK4qu2g1iZU6t+IhP9JXwK0h4sksn4BgTQtloPfoAIi94CQq9zcEsN8swOzy+Gc2wcz6Q4YAf2/QJaNF2hBRgjFkW0a/krWkQnp6boeoSmPIgObBiYvp0FwprpzBOhTeaYFpFRiSX2c9DCYOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gCEO5Wm+58vKpgPgmGJOG668TPwSFqBnXGJFJ1Bai4=;
 b=aM21Rb6sut2jL34DDDFSeMmi5npekmg/JpvPOFC1huGX4Zto1crrdUXnbA4bk0UxPj7atrPRcGm1+Pw0Ym74PLN+zPHTzjtVsZtuVpLmj7oyHMhClxe8I81eeQjnoK4yrJEvJufL99pUS0jvMF2a06n0Tdxgaj4h0IA5/dozM6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN6PR12MB1523.namprd12.prod.outlook.com (2603:10b6:405:10::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 14:19:23 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa%6]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 14:19:23 +0000
Message-ID: <7c8b25a1-2937-18b6-c329-e901673ae691@amd.com>
Date: Thu, 30 Jun 2022 10:19:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 3/11] drm/amdkfd: Add GPU recoverable fault SMI event
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220628145020.26925-1-Philip.Yang@amd.com>
 <20220628145020.26925-4-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220628145020.26925-4-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0105.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::34) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bdd4ba7-7dd2-4561-04b9-08da5aa387fb
X-MS-TrafficTypeDiagnostic: BN6PR12MB1523:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vdWYQFoULNImU/jzqEa9owQ0XfnPtNTL2MOSlG+8xePwz7ofI0WnIxQRIop01y2kTgNMYsXAldN968Rz5Bz/FtauYHcFN7VTtb4tuwWLt23YJqaRzQmY9lKsFEbUKiV+yLnOJp19H8DjyE4NS2UYeQZBfHTFtC2VNzi4rQE2JCUCb76axEoxLy4yD9oKk0aVkfTotraUQi98CAFc347Ku8cvCMWbEKWeL0yxjKnYDRHL81go2/KW02ENgqmBCvsYNUfhLcMwsuXUgV0cZ8tz+s0AOgIhfRVN+9pGMBXPy/368eykh63qnJteK/ROa6lqr+5dBg/j75z0Va2X/Gki0763DXzZaVJFTnISyhqMaPVSgnV2vroV5XS10p7t6nDkUgC0OBCMIipNBmupwwnAuBsU+TPyWMT+g+b8Aqzsih+UjG1/YtoEFS+bVQCoH7ABjyi9uFZ53ViDsXd/jweeayESVYOqPC3GeYddIlzZkY31bNXiW6jLDNi9a1tFwCG+i4jumpo7OGP5/RpEt6Ur062OENV10JDMPr15+gdHNpxKPNuwng7PkLCcGJCJ52xEW1Ek2BEuCw6WrWP5+HZZu0dv0mJ2ko6fU8vC3ZNVO7OXtpr+NRG41Tt9V7agszETjAJM7QSKiublqVxsYo7trvuVRT2omJ7SXUhfZm2to69U+Gz40QJQvI64HI5YBC9Zn7SVFm511Dn1mkj1v+K1iKjeEbzai/KECDnAB463uzJKEm0VtKxD1PnECJVMUjeeijXTo4t90W+z9wmakFO+33npLCXJF3/Ro1arc05hosAkRLG2FwxpjOYs74b8Bfe65kBkKZYv4cSU7sSGtnR7wtwrPhoRnQ0wi5/4muA/8As=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(6512007)(6506007)(41300700001)(86362001)(31696002)(26005)(186003)(2616005)(83380400001)(38100700002)(6486002)(31686004)(66476007)(66946007)(66556008)(8676002)(2906002)(5660300002)(44832011)(8936002)(36756003)(478600001)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NllCcUNRSXVURW1CTjY2cUVvNXc0cnNZUUVzeit5U2kwM0dBK0V3SnEwZnRD?=
 =?utf-8?B?ajVONitLNURwL21oa05JblpoWUUrbkE4K2lsZ0JNWTFOcVBJT0JMajBJejVa?=
 =?utf-8?B?VXMzUWJoMmRxbndsN0t1VDJDU3VUblRJUmJVanFuZm45T2VQMWtlNC81bStm?=
 =?utf-8?B?V005enJxTDd6OWs5elQwL2NCZmRBb2pJNGc1ZklBMGRKWWFpTDcyNWdjcGN6?=
 =?utf-8?B?dEZEZjFVbkFNV1ZMaDY5cDRTUWlvUFU1TWE3L0w2MDZHSEl2VHVWUUN0S2Fw?=
 =?utf-8?B?MDErUVFuTWkrbjl4dWhLSThUSXYzTER4cWpSTWorTWJwZndrWGR6dHArNWpL?=
 =?utf-8?B?S25YcDBDUFdJcDY1MXlZVUNFb05jOTUwdTNyN2YydFBjUXJQaXFraUgrQzRh?=
 =?utf-8?B?UlBUZS9zQXFVaVJSejBOZHBJM285L3pZblhOMEZIU2RmekJWb1Nnb3A0L2hn?=
 =?utf-8?B?QS9OMmFwNFRaU1FqVGc4V2tKMU5QbXQwMG5FZ3VXTS9QNGNXNk1wd0ROdFAx?=
 =?utf-8?B?UHZWbGV0MUdQQnBXSlUvZG90SGtoSmlmdTE5YVo3eWhObHU3NXoyMmVZWVFm?=
 =?utf-8?B?Qkk2NFBkd1BDYW43M3AzWlJwMEFmT0QwSGlidHpRTWpVYmJOTk5TQmt1anB1?=
 =?utf-8?B?R1RKRHdtTS9XK0lwRnJ4U3phMkNaaEF5Y1RndGlVaTR2Wm9oWUdNM3ZqTXpF?=
 =?utf-8?B?OWo0TjE4Yzg0Mm9hbXJMMnJ0Tm9jL2VXSkVVcHJXZ20vdjcrbWcrdkxIRFp4?=
 =?utf-8?B?b202dHloQUU0d3RhOC9MN3J2a2dnWFJZVDNnV1ZwaFdHajBtQ0ZqNmxKbEtm?=
 =?utf-8?B?VFVNcWNFNFRVQ0RGQVZJckM3U2l0elNHcXVhbnpmL2lmQ21YVmkzSTdVa0FX?=
 =?utf-8?B?VG94bHhGczZhR05LUWNUOGE5c2pFd1JCNUFRTktxL2Nibm9kTUNPMkRRTjNU?=
 =?utf-8?B?UVJ3dEZrL1h4bWJ3VFkyQmtWcXB5d3V0UGpneEc3QnlaUWIxdkFUbEp4UllS?=
 =?utf-8?B?YVVBQ05RMHUzMTA3bFQ2MzlYc1hHQkFVamRBbkI4ZURaWU4rT1I4M3lEYytR?=
 =?utf-8?B?LzRVRkdMUC9xNGlvNDQrZjJrR3lHWmZRTXU4ZlJCQk5JTTNqS3lBQlNJaHVu?=
 =?utf-8?B?K1h0c2c4VFQ5bDg1WTRUMWdYNGF4Q0xKLzFhRHZpWXJidmMrSEdvRm53MndI?=
 =?utf-8?B?UnhaSFhnaVhRakZzOU5lMERHYnB0K2ZhRGp4YnFibGdoUHJoZlZySEpQTDZT?=
 =?utf-8?B?UlI2NFZCZ3UvTTBUNkczNEFLZzJkc3J6Z1hTUWxBVzZXSUVCT0Q1aWVUbmEx?=
 =?utf-8?B?b25WenZlT2I3L2laV0NSTWxmanE5TTRkZm1KZmlSbmhJZFFtekdNdFY3c1JC?=
 =?utf-8?B?Y0o4QjZvQk9zME9GNDgycGxwQ0lyN0RxdUpuaWc5d2JaelM5ZFJVaTEyMEw1?=
 =?utf-8?B?VDRuME11em9KMTlHOXc4YnJ4cDhSUTl0NzdlM1dKbkhpcitNVG5UMWhpRU8v?=
 =?utf-8?B?VitEK3FCUUFxSy9LMlhUdXQwWjcycjFBcWU5dUl2MEkvaG1RUHBpcjlpSkRR?=
 =?utf-8?B?VXRNZXhubUw1SUxJOEZrOWxLam9vRk93S3VMWndOTGR0TWUvMitjRnVVNkJY?=
 =?utf-8?B?UEtWVFB5RjhRVzR0UGZmVTVwaVYvOVlockoxMHU0YUtIdmJvV1ZjaUNtQWQ2?=
 =?utf-8?B?TDRXMFo3ZnB3MWh6U3hOVFFoOHBQRktDMzhKR0ZKZGQ4QTFTSFRGVG1vMVZQ?=
 =?utf-8?B?S3RyS3E4TjF2eGt4ckVwR2pqQVNqWm9NVHdIdUJJOXpWUldsN0tINzM5Wk1X?=
 =?utf-8?B?elozMGUxYy9uZHhxMVcySGtBVWpYbkRNSytBZ1ZwTVZ2dC9NdU90SDROOUFS?=
 =?utf-8?B?bmFMMFByblUrZDhKbkZoWG5oNm94aHAvOHZqSElobXozWG93bFlJRis2Undz?=
 =?utf-8?B?TjVubDk5Z05SR0IzN3Y1WUlrcmJ0b1FNMjkzK1VwM3Q1SHdtYlFPRE1nMGlC?=
 =?utf-8?B?MWhVcUt0eVlzTU1CSmJUR0dQK2JOYlF5a3VGcDJQOXI3NGdiWTQvVGlnYkxG?=
 =?utf-8?B?VDl5YVJhSDFGSWplQjBSQkg0SEwySVBuT1AxOGY2ZkFmUEI4K2daaTNWdG12?=
 =?utf-8?Q?G4s0+zljGioBbA1PiDfpqd+Z9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdd4ba7-7dd2-4561-04b9-08da5aa387fb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 14:19:23.5452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLt8Mrq96UXDiV+CU8aQIXTHp6Q17QfkVcEr4+B0mJYjU4+JZHFRp7STtYFnTjtXig+IK1+topXX8yg6NQPmeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1523
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


Am 2022-06-28 um 10:50 schrieb Philip Yang:
> Use ktime_get_boottime_ns() as timestamp to correlate with other
> APIs. Output timestamp when GPU recoverable fault starts and ends to
> recover the fault, if migration happened or only GPU page table is
> updated to recover, fault address, if read or write fault.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 17 +++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  6 +++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c        | 17 +++++++++++++----
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h        |  2 +-
>   4 files changed, 36 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index 55ed026435e2..b7e68283925f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -244,6 +244,23 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
>   			  task_info.pid, task_info.task_name);
>   }
>   
> +void kfd_smi_event_page_fault_start(struct kfd_dev *dev, pid_t pid,
> +				    unsigned long address, bool write_fault,
> +				    ktime_t ts)
> +{
> +	kfd_smi_event_add(pid, dev, KFD_SMI_EVENT_PAGE_FAULT_START,
> +			  "%lld -%d @%lx(%x) %c\n", ktime_to_ns(ts), pid,
> +			  address, dev->id, write_fault ? 'W' : 'R');
> +}
> +
> +void kfd_smi_event_page_fault_end(struct kfd_dev *dev, pid_t pid,
> +				  unsigned long address, bool migration)
> +{
> +	kfd_smi_event_add(pid, dev, KFD_SMI_EVENT_PAGE_FAULT_END,
> +			  "%lld -%d @%lx(%x) %c\n", ktime_get_boottime_ns(),
> +			  pid, address, dev->id, migration ? 'M' : 'U');
> +}
> +
>   int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
>   {
>   	struct kfd_smi_client *client;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> index dfe101c21166..7903718cd9eb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> @@ -29,5 +29,9 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid);
>   void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
>   					     uint64_t throttle_bitmask);
>   void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset);
> -
> +void kfd_smi_event_page_fault_start(struct kfd_dev *dev, pid_t pid,
> +				    unsigned long address, bool write_fault,
> +				    ktime_t ts);
> +void kfd_smi_event_page_fault_end(struct kfd_dev *dev, pid_t pid,
> +				  unsigned long address, bool migration);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index d6fc00d51c8c..2ad08a1f38dd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -32,6 +32,7 @@
>   #include "kfd_priv.h"
>   #include "kfd_svm.h"
>   #include "kfd_migrate.h"
> +#include "kfd_smi_events.h"
>   
>   #ifdef dev_fmt
>   #undef dev_fmt
> @@ -1617,7 +1618,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   	svm_range_unreserve_bos(&ctx);
>   
>   	if (!r)
> -		prange->validate_timestamp = ktime_to_us(ktime_get());
> +		prange->validate_timestamp = ktime_get_boottime();
>   
>   	return r;
>   }
> @@ -2694,11 +2695,12 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	struct svm_range_list *svms;
>   	struct svm_range *prange;
>   	struct kfd_process *p;
> -	uint64_t timestamp;
> +	ktime_t timestamp = ktime_get_boottime();
>   	int32_t best_loc;
>   	int32_t gpuidx = MAX_GPU_INSTANCE;
>   	bool write_locked = false;
>   	struct vm_area_struct *vma;
> +	bool migration = false;
>   	int r = 0;
>   
>   	if (!KFD_IS_SVM_API_SUPPORTED(adev->kfd.dev)) {
> @@ -2775,9 +2777,9 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		goto out_unlock_range;
>   	}
>   
> -	timestamp = ktime_to_us(ktime_get()) - prange->validate_timestamp;
>   	/* skip duplicate vm fault on different pages of same range */
> -	if (timestamp < AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING) {
> +	if (ktime_before(timestamp, ktime_add_ns(prange->validate_timestamp,
> +				AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING))) {

You changed the timestamp units from us to ns. I think you'll need to 
update AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING (multiply with 1000) to 
account for that.

Other than that, this patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>   		pr_debug("svms 0x%p [0x%lx %lx] already restored\n",
>   			 svms, prange->start, prange->last);
>   		r = 0;
> @@ -2813,7 +2815,11 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		 svms, prange->start, prange->last, best_loc,
>   		 prange->actual_loc);
>   
> +	kfd_smi_event_page_fault_start(adev->kfd.dev, p->lead_thread->pid, addr,
> +				       write_fault, timestamp);
> +
>   	if (prange->actual_loc != best_loc) {
> +		migration = true;
>   		if (best_loc) {
>   			r = svm_migrate_to_vram(prange, best_loc, mm);
>   			if (r) {
> @@ -2842,6 +2848,9 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
>   			 r, svms, prange->start, prange->last);
>   
> +	kfd_smi_event_page_fault_end(adev->kfd.dev, p->lead_thread->pid, addr,
> +				     migration);
> +
>   out_unlock_range:
>   	mutex_unlock(&prange->migrate_mutex);
>   out_unlock_svms:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 2d54147b4dda..eab7f6d3b13c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -125,7 +125,7 @@ struct svm_range {
>   	uint32_t			actual_loc;
>   	uint8_t				granularity;
>   	atomic_t			invalid;
> -	uint64_t			validate_timestamp;
> +	ktime_t				validate_timestamp;
>   	struct mmu_interval_notifier	notifier;
>   	struct svm_work_list_item	work_item;
>   	struct list_head		deferred_list;
