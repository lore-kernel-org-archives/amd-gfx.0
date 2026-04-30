Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBF7CD13DA
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 19:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4425710F423;
	Thu, 30 Apr 2026 19:33:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ReKm97zG";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A1D610F423
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 19:33:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eotwZCVt+YrcmAr0j3ciAPC3qrPlSUEZvMxePWocjH6o4qZEAZqbUqaiz5GwcQeMhmAFQ3VbFh7Wr5lhymJMGhBbWVIYJhL1Xy1KOO3ZKUoFQmRb4JAo3NTETCtJr4FbNSZEwaw8C3yrzs13qQLFhpWpJYDSx7u4DGWAwtb07WByn5jdCpCtRWpa3pn487/Noxe+KdiaQAuX2z5E2n9n/YCU/6ZlmuzAOFq4jAv3RVpjo320l6ioEedV7i288HtLrc84kePdSfW9Ikgye/XNc9HGRJRVf2ZuU192yXO2q5a8BQOd7NXo64MH8ZmPMKPY1+nqbPjPDCpQ69hEjGbjeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOAcXmOGpFLe+dvbL5Bmo6goFZz7LyKQz+O2BtcD+nw=;
 b=DuAL/ubV1Ji5l4xyvqQhnImvFsGoGv2g0J+HwtbeVEuYDW1+41Xij5yjPBJjIblhLOB4Kk0fg8fSEvIf4gxuDtfi9oKvEpWDOz1vsx2UfXtKjhGrXQ7oCSIRo0Blk6Ky4iYzFrd9jlaQmgy7t7cN3ENQ5bS95DhYsLmoP2newWhlMevOSrrhsyFsTQjfmil7fszIowrdXnpx1I9v7bfqkRNOdL0opYo8F3tPRESJ38Xt3druMYBRdKXN+NhyCZasvm9KJxi3cod7FQMrOEpaDnAcAqneNB0xntAjMKtjte9aMbuf64D52OibYJZ/xD7CTxxkXA/UJuNUfWqOuyb9Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOAcXmOGpFLe+dvbL5Bmo6goFZz7LyKQz+O2BtcD+nw=;
 b=ReKm97zG08U7ZrjQ5oVKaSAFCSHxKlx9CDbFeZPBXX4/sGfP57+/YzKHzbrHNGUcas4caNfXd8h62gvxfaCRauoYGLLQOiNIhRe5XAcJa8GvI/VAEnhD8Zvnp9nA4ZnLwd8/unD9DmGxMy/A6PfFLWjGfrcJ4vNX1D/UBhMdVU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 19:33:30 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 19:33:30 +0000
Message-ID: <204ba2ed-a10f-4574-87b8-d54e8061e377@amd.com>
Date: Thu, 30 Apr 2026 15:33:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: remove obsolete codes for kfd_mmap
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260430181718.201371-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260430181718.201371-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:208:329::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY5PR12MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ee7d59-8c52-4f50-d9fa-08dea6ef5be0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: Ad9WNbXtyxEwkrS70UNthjfPzFbf5wI0zNEfe+1p9IpEsCsw2isN/B8hIUAlbOJZ8svOl6niLy5r+HzD0jLqp8BLtlHJO1sJzdJ7VesGHp68SoXJw0u8a8/Xpd+y8+WtzM6xT7CbchSvi6oCR4EQtYGBoFQIlZQzA5sk/Rs3S5kUUUOzciVsJo0bp7g2QA2NyssaNBK35TfF5NAHlepechsyleXDoflkmxn7lSv9kFAKXTbmNYpPxBNt9fDEqXs4MFQA2gpDEwq+FIWSZsNwjP596xCk9qjEHIPABaK0jNfWybL5Hkt+D+zdTz9hWrlKx6N/8aTXHgFTMZP8RX0jqtpUCJU+s+wpqGq+fw5zujBvo89BZZwFzgrSIvATPEoGlvf1WHX8ct3U76gBeZCnACxLtT9RUNAFHDwpciXjCQSPv48APK/unEy58PAfIeB9GHZ/CWim7xICbpWc+SHRjKFoUzfjW2tWz/P8XOQpTVm+1vVL/SdIMEcLUkt4QxqwfYx7MjVfzQbQBlzXRT9ix+MSm4iBLLB5DgteT0H8VBVAZvHXHfWOpj3SvO9YvgJH8VlRPp4DJw51JxDu+zzrwrV53BBOij2Fw2OSaNbygsL5wQQuT2eNZcsuHUIt2ndSuY7NUk/guFCqAUExm4oq3mi383XTo0oDOzdMPfIh8XiTLRrhESeQnr8LftQOYXE1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWh3VzRuRWtveGFhZTRFYTVFVlZBVk9tdTluazgwMnZGaWRGb3hpTHRCZWoz?=
 =?utf-8?B?VlR4VlVFd3lXampGc215R1ZTL1pMeVpzVk1LYUowd2hTYjlBbWY1WlNCb05W?=
 =?utf-8?B?bkFsNjdBNmEvWlNtN1FTcWV1b2lpd2E1Y3Rwb1lYL1VTbUlwanZ0TE5zcXlI?=
 =?utf-8?B?enZOWjFidlV3RUpJaUpDVFQ2dkQ3SW1PZ2dudjM2WlJwVzdEa0tDNDlTSjBQ?=
 =?utf-8?B?STdwVm1IMjd6akk0MVBXYk9MY1hkUTFTSHpmbnlJY3c4OUo4ZzA0Z1Avd2lE?=
 =?utf-8?B?T0pkVUVUWitDQTFhTGY2dk9EdmhCMUFNWUVPUHNMNVd0eVVDQkhFeVEyU0RR?=
 =?utf-8?B?N2FUNys1aHcwRFFzRUZRR0NrQ3RRWnU1WTZEZEg5bmNPejlzc0RWNTA3Q1lD?=
 =?utf-8?B?MWh1Zkt4cWtUclBEYjUvWHpJcVRBUnZrdGhpNHU4SXUvTVlTaWdYSjBjTCts?=
 =?utf-8?B?T0dCRkozY2RvQUdjemRpSkFVajBsUnV2QTE5UGRabXhrajM5Nyt0aVVvdlRI?=
 =?utf-8?B?REc4a1ZXTEMvM2lhdkxPS2RhVkZabno4cW5paEcyZUJ2SS94OHZ5Ti9rR3JK?=
 =?utf-8?B?VDJGMkVjQnoyeEo3aHVaOGhLWnVsblRuN3ppb1ZtZDkrRFI0Q3BZTVJMRVRC?=
 =?utf-8?B?bGdLdUltRkRtMFQ1eEs4WEJ2NVY4K0p4U0NJM202aUtYWjdXTHM5ZGRNaWgx?=
 =?utf-8?B?akFqUC9XMHhUeHpiWGFvb1JiRUFFMHd6ZFROMjJRVzNwV2F2NzFkM20xY3N1?=
 =?utf-8?B?UkhwV21SbnFvYlZqTVdKR0R1YUhPQzJvak5PWjV5YWY0aDQvYkJVUFoxQWtJ?=
 =?utf-8?B?Mml6T0pMeHBTQWE3RmFyTmQ5L1ZNdFlGaDFlZjJzTkd3NkJGWGsvRktoM1FL?=
 =?utf-8?B?Y3BrNGhJcjY4S21jc1ViNHl3QnFvUjgxRzBuUkZRdUhGbVdISVhkelFNWnRN?=
 =?utf-8?B?WnlFQkJKOVNYUlZnZXZJc1BxU2pvb3IweExzS2t6VTIzM0k3MHNoTnZTVDQy?=
 =?utf-8?B?bERxYzlNWkNWQ1FmTVZ1WXR6N3ZZN3pCcGZMaU5BY3MrT1Q0N1BBZFNoZGRs?=
 =?utf-8?B?Yy9IZzlCRGNVdGdKYk0wRTI4cWlDVVRUZ0FOR2xac1lSTU0yczdHVHE3eVpE?=
 =?utf-8?B?UVlYTjNuWkNScFRUMERGT2Q4TnFhTVhPY2lCaFlERTVyOVNob3VnaUJmZ2tZ?=
 =?utf-8?B?TTR3eG9lbEdLQXNXNU1kTzQ3U1pmbGI3aTdYb1Fya0tFcjZGQ3lvQ3N3bUpn?=
 =?utf-8?B?Smx6Y256elc0em94cHNkOVk2blUwTFJUWlk4MHczdnAzbkp2cklrZ3p1dFI5?=
 =?utf-8?B?VlFXTHV3YUJ4MUQxanZKZlZzZ1NrVmNDU2srdjhYYmswck4yZlAxSUhlcmhC?=
 =?utf-8?B?STJBbGozRnNucldtSElsRjJNdStDaVppRjZwQ3RjZXdtUFpuTUFNNlpLSnlp?=
 =?utf-8?B?MWFpcVpCaDR2YWp1Z3V1MkFMS2w2NmtMTVV6R3JweWtidVpnSjEydmE4Y05W?=
 =?utf-8?B?NW9oS1F1RHdiNDZDRmo1VHZ4bk00K0JCSXdBYkhXNXJWMTI3NWlhSFJzZVND?=
 =?utf-8?B?UjhibmE3aDhJZTR6d2lpUVBvaVcwM3lhMkh6aXhlbFFncU4xK2ZkZU0rMkRi?=
 =?utf-8?B?V2pTb3oxZTRPWWUxc25iQ0hWZ2Zma1Bham9SSWs4Qjk1UXFKQTcrN0NuL3M2?=
 =?utf-8?B?cUowZU5ZMWZNM2tKYXFiVkdiMmhpTnc5MzU3alM3aUFOSGFIMWdEUkFFVHZ6?=
 =?utf-8?B?a085bnd4K2lSeFFrcytoUFlSbEJFNFlGZFk2dG9lUERTajBRUllhZ3F3ODk4?=
 =?utf-8?B?MnFhL0RyZ1UzbnA0eWhPaDhiRGtnaGMxRkdhUi83SzQrZkZmYld3b1hOZFpI?=
 =?utf-8?B?dzlDUUVFVHJCeThJK01LbmloMXJNZkd2U3E2dEtpRlJ4UzdkcjhyV1NoZ0JZ?=
 =?utf-8?B?WmFKQnBlWCtnY1ozWUg3STlwYTdqRTJ5V0c3NmNZS1FJdE1GM0tYaDNDTjNS?=
 =?utf-8?B?TklRRWo4NGRtaGRwTkZnVzdzQ3VSd0xaeDgrN0tmc3h6N0lWQWtjNERYSGZu?=
 =?utf-8?B?VEVBYkVMSGx0dTFFVW1LenBKdVlrT2xPSjhiczZDNkdiU3EzL1pmYmcwVDdJ?=
 =?utf-8?B?WkthSE90a1preVpIL0hDRlYwQTA0ZlR3SlJpTndFZjhHSEhVVmQ5eVRaS0sy?=
 =?utf-8?B?THE1czVISDZVWHhHUmJPWi9uMnpqeFBWaGZnaXFlQ3lVb1JOMGtobmhBTWEy?=
 =?utf-8?B?RG1TbUNFSkVPbWdMY1VIUFdkMitXUU1UOXRQTHRYMjZ2THVVNzh4dVQ5V0lY?=
 =?utf-8?B?cXAzRGc2Y3NtRXc5UXB6dHR1Zi9RbVFOTGhzekNmM21xYXlaMDFVUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ee7d59-8c52-4f50-d9fa-08dea6ef5be0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 19:33:30.3141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NGPAAi+vOMEhOzzV/88v4fXiw7JwXdx6U9HdkKALkzfRnj7F2U8meIsc1o5QxJjQSkSJouj7NDhxnL04cO2Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6084
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


On 2026-04-30 14:17, Eric Huang wrote:
> kfd_reserved_mem_mmap is only for mapping CWSR on APU in IOMMUv2
> mode, which is no longer supported, and qpd->cwsr_base has been
> set before calling kfd_process_init_cwsr_apu, which is the only
> caller for KFD_MMAP_TYPE_RESERVED_MEM, so kfd_process_init_cwsr_apu
> is not functional anymore, remove them together. On the other hand,
> it will fix a vulnerability issue to abuse KFD_MMAP_TYPE_RESERVED_MEM
> of kfd_mmap from userspace.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 10 +---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  8 ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 76 ------------------------
>   3 files changed, 2 insertions(+), 92 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 881ea252b3ad..84b9bde7f371 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -149,11 +149,6 @@ static int kfd_open(struct inode *inode, struct file *filep)
>   	if (IS_ERR(process))
>   		return PTR_ERR(process);
>   
> -	if (kfd_process_init_cwsr_apu(process, filep)) {
> -		kfd_unref_process(process);
> -		return -EFAULT;
> -	}
> -
>   	/* filep now owns the reference returned by kfd_create_process */
>   	filep->private_data = process;
>   
> @@ -3748,9 +3743,8 @@ static int kfd_mmap(struct file *filep, struct vm_area_struct *vma)
>   		return kfd_event_mmap(process, vma);
>   
>   	case KFD_MMAP_TYPE_RESERVED_MEM:
> -		if (!dev)
> -			return -ENODEV;
> -		return kfd_reserved_mem_mmap(dev, process, vma);
> +		pr_warn("KFD_MMAP_TYPE_RESERVED_MEM is no longer supported\n");
> +		return -EINVAL;
>   	case KFD_MMAP_TYPE_MMIO:
>   		if (!dev)
>   			return -ENODEV;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 78c76fd64677..a6ff1db477f9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -995,9 +995,6 @@ struct kfd_process {
>   	struct kobject *kobj_queues;
>   	struct attribute attr_pasid;
>   
> -	/* Keep track cwsr init */
> -	bool has_cwsr;
> -
>   	/* Exception code enable mask and status */
>   	uint64_t exception_enable_mask;
>   	uint64_t exception_status;
> @@ -1113,8 +1110,6 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
>   
>   bool kfd_process_xnack_mode(struct kfd_process *p, bool supported);
>   
> -int kfd_reserved_mem_mmap(struct kfd_node *dev, struct kfd_process *process,
> -			  struct vm_area_struct *vma);
>   void kfd_process_notifier_release_internal(struct kfd_process *p);
>   
>   /* KFD process API for creating and translating handles */
> @@ -1231,9 +1226,6 @@ void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
>   void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
>   				     bool enabled);
>   
> -/* CWSR initialization */
> -int kfd_process_init_cwsr_apu(struct kfd_process *process, struct file *filep);
> -
>   /* CRIU */
>   /*
>    * Need to increment KFD_CRIU_PRIV_VERSION each time a change is made to any of the CRIU private
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 4f6bf3b7c59c..419bb8086ccd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1430,50 +1430,6 @@ void kfd_cleanup_processes(void)
>   	mmu_notifier_synchronize();
>   }
>   
> -int kfd_process_init_cwsr_apu(struct kfd_process *p, struct file *filep)
> -{
> -	unsigned long  offset;
> -	int i;
> -
> -	if (p->has_cwsr)
> -		return 0;
> -
> -	for (i = 0; i < p->n_pdds; i++) {
> -		struct kfd_node *dev = p->pdds[i]->dev;
> -		struct qcm_process_device *qpd = &p->pdds[i]->qpd;
> -
> -		if (!dev->kfd->cwsr_enabled || qpd->cwsr_kaddr || qpd->cwsr_base)
> -			continue;
> -
> -		offset = KFD_MMAP_TYPE_RESERVED_MEM | KFD_MMAP_GPU_ID(dev->id);
> -		qpd->tba_addr = (int64_t)vm_mmap(filep, 0,
> -			KFD_CWSR_TBA_TMA_SIZE, PROT_READ | PROT_EXEC,
> -			MAP_SHARED, offset);
> -
> -		if (IS_ERR_VALUE(qpd->tba_addr)) {
> -			int err = qpd->tba_addr;
> -
> -			dev_err(dev->adev->dev,
> -				"Failure to set tba address. error %d.\n", err);
> -			qpd->tba_addr = 0;
> -			qpd->cwsr_kaddr = NULL;
> -			return err;
> -		}
> -
> -		memcpy(qpd->cwsr_kaddr, dev->kfd->cwsr_isa, dev->kfd->cwsr_isa_size);
> -
> -		kfd_process_set_trap_debug_flag(qpd, p->debug_trap_enabled);
> -
> -		qpd->tma_addr = qpd->tba_addr + KFD_CWSR_TMA_OFFSET;
> -		pr_debug("set tba :0x%llx, tma:0x%llx, cwsr_kaddr:%p for pqm.\n",
> -			qpd->tba_addr, qpd->tma_addr, qpd->cwsr_kaddr);
> -	}
> -
> -	p->has_cwsr = true;
> -
> -	return 0;
> -}
> -
>   static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
>   {
>   	struct kfd_node *dev = pdd->dev;
> @@ -2249,38 +2205,6 @@ int kfd_resume_all_processes(void)
>   	return ret;
>   }
>   
> -int kfd_reserved_mem_mmap(struct kfd_node *dev, struct kfd_process *process,
> -			  struct vm_area_struct *vma)
> -{
> -	struct kfd_process_device *pdd;
> -	struct qcm_process_device *qpd;
> -
> -	if ((vma->vm_end - vma->vm_start) != KFD_CWSR_TBA_TMA_SIZE) {
> -		dev_err(dev->adev->dev, "Incorrect CWSR mapping size.\n");
> -		return -EINVAL;
> -	}
> -
> -	pdd = kfd_get_process_device_data(dev, process);
> -	if (!pdd)
> -		return -EINVAL;
> -	qpd = &pdd->qpd;
> -
> -	qpd->cwsr_kaddr = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> -					get_order(KFD_CWSR_TBA_TMA_SIZE));
> -	if (!qpd->cwsr_kaddr) {
> -		dev_err(dev->adev->dev,
> -			"Error allocating per process CWSR buffer.\n");
> -		return -ENOMEM;
> -	}
> -
> -	vm_flags_set(vma, VM_IO | VM_DONTCOPY | VM_DONTEXPAND
> -		| VM_NORESERVE | VM_DONTDUMP | VM_PFNMAP);
> -	/* Mapping pages to user process */
> -	return remap_pfn_range(vma, vma->vm_start,
> -			       PFN_DOWN(__pa(qpd->cwsr_kaddr)),
> -			       KFD_CWSR_TBA_TMA_SIZE, vma->vm_page_prot);
> -}
> -
>   /* assumes caller holds process lock. */
>   int kfd_process_drain_interrupts(struct kfd_process_device *pdd)
>   {
