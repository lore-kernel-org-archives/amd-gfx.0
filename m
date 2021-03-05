Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2665C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 19:27:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 813E56502A
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 19:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813E56502A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 136A56EC31;
	Fri,  5 Mar 2021 19:27:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D4DC6EC2E
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 19:27:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igvLAkNtwSXKulHxdhJMzeTec/qnGs9aARfuk08rrYwTS1JgY2I3kExsc5VTQmbZs8cOr5B+mVTF5DyDeAeLbVsXmOYzAu7+z5ltpYATvhubMxQjsgPL3YtJCmxWymh1oeO3VxTJ9RHbgnVz0cBszHHewOCeVOtnFt38X23EAXYNCedO8Z6lsdCON9JvFzuWfeXbNz/d1F+NFVPy4Sdc7MyIeAapcDGFOIOkwKW/ExzYZz8uqz0MfgCuFBuiyuRuXWFaRsIOuwE/Sth+FCraz/b6CQZiYPhqDwHCO5H2fZOfLkZvYqATLiePTEAtVWN6e3Btk1Tj5xMHZU2885vSFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ri7n18Qq8u6BDXujoyH+Yjjh0UA40/b4Omv0TPbdmQc=;
 b=UZW2vmWnBZegxEHdcI6vzKOvUIzmi7rR8+nXHyubn1D3XHseZsMdZZtNSqKWjt5WNiHeX0e+W9jQ8OuAwonBiD57NbKhXKNt46NgwBzVjoS4QN9OaPZ+kGgTheY/DIybuWW/D/HbnhDJYDXW8l9dUmr0xiV5wpMy3YLfiaVQOqzxoDQYDMWlF6C9nGiLUgKNh/TyNX+XtrBDzJ5bV9vRYpxhXOmzt+6wlYk4R1cwt3GN9MaarIh+x/Rt54CWamnzq7PBG4b2Z2DU6VoYwHhwrB7eouJ/Guif7ADnBBHz0b/7812Cjs2DHZgUl/CWsmyibzo22iibbFpCxUTtjKwZiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ri7n18Qq8u6BDXujoyH+Yjjh0UA40/b4Omv0TPbdmQc=;
 b=VMwdM8c96u6ficgGadLR5oasq682gAoPcMlJVibJUSWPyoDU2g2TeG18wsdFNJbjt/RpehRBJW4XxU6OJTLEGby7Cf9aYskQBqUYgRPFNa8NZUn9OqQ5MNsJrXoaxr8Oi7BU4adwSJKGakzQj8NyLY47eKLt90Ta+102vj+MMxw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2798.namprd12.prod.outlook.com (2603:10b6:805:69::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Fri, 5 Mar
 2021 19:27:04 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3912.024; Fri, 5 Mar 2021
 19:27:04 +0000
Subject: Re: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI hive duirng
 probe
To: shaoyunl <shaoyun.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210305175257.32219-1-shaoyun.liu@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <34643514-c054-242a-336e-1ac9ab7ffcc7@amd.com>
Date: Fri, 5 Mar 2021 14:27:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210305175257.32219-1-shaoyun.liu@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:3012:19ff:c30b:a786]
X-ClientProxiedBy: YT2PR01CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::18) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:3012:19ff:c30b:a786]
 (2607:fea8:3edf:49b0:3012:19ff:c30b:a786) by
 YT2PR01CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.23 via Frontend Transport; Fri, 5 Mar 2021 19:27:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d696313f-f334-4b92-62f8-08d8e00ca89b
X-MS-TrafficTypeDiagnostic: SN6PR12MB2798:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27986EA17A3C86D3F3EBBB1DEA969@SN6PR12MB2798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wSl3O+HIIzk94da/yEGdc0r/sM4rqLF5/fytdMSILPOJEG0/Gnb05S5TBsvjyoTO5ntMdhlZYvkwuKnyYJPfQivS7xWzRGsb+GhGPKItJnYcSBBM+nH+/eJTmwzwG8QhlY//6PH1kcKgQWk37zp4gMnbeDLVmUgZat3uECWHvODGFSs0qz9w2P//J+4LK1wbILeGk200zWpZDzHHNGO0FBhqbI6Pb+rnr58FC1p1RQi0X5dnWSXZMO7azTklfJaoS4PmEvrCJj7UPUdlJthnkvxu5G4b1np0LSdjJG7wvbe+0oc1DBwEw8yUsSYgXV9/Myi5QNmWOg6+gK8RY5c0vij8feTdSOnub+z8evgJmTdsIikop/zGaYf++7uBl4/jQkOwJePdjt7v+yVQtpuUkFdQSD6e5rJeMHY1lqn1Lo5UvTvajc44I8os0n2eVIBHyduZ1RyzXG/9DzVGTDx9rUGpjDCuq1fwC3FkDX2/kG0xsDa3PT4LKT28IL+Ji96V6vSD0oolZrHdsZND7hyR3OvSQFOYKHGtbs8qqkFycxOu94Ra0vD52EAk60Sqv/RTnYoVzs4I+TC/3uFJLmmLcLch5IMLJ0vPBBdquyM/tTWKdSO5TFfLC6+GWs05r/Ut
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(66556008)(66476007)(44832011)(66946007)(31686004)(5660300002)(83380400001)(36756003)(31696002)(2906002)(86362001)(6486002)(478600001)(2616005)(8936002)(8676002)(52116002)(186003)(30864003)(316002)(53546011)(16526019)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZW1aVVluYkQ5MlMrcE5vbU1xbFpMUEtZS01TMHlCZGRXRFY5Z21WaFIvSTVC?=
 =?utf-8?B?VzZ1NU1nRGhuT1FwSXBhUExmb3RxM3hwOUd1NklVSHhORkNLM1d4VTgvZ0Mr?=
 =?utf-8?B?RUNFWDRSR0wzcFFpMmU5Y2tTSU03aVhQRFg1dnpxVkxLSDYzaDBHWmtDUWtU?=
 =?utf-8?B?emk2RzI5dy9XRGxacm5DS1ltbEcxdzFlWnFQbzB3b3ZmbUx0ZEp4TDFUajE4?=
 =?utf-8?B?d2VWcHZBd0tRTVNJck9hYWhJWWkzR0prUlhwT2I4ZThaZXR5Smk3bzMyYXln?=
 =?utf-8?B?cGtzSVU2TmpFM1k2cGpIalRiQXprN3NmQ2tVVm1lU0tzdHZra2k5bWh6WTRy?=
 =?utf-8?B?ZFk3eDhPU2Z6SmN5L2ZybmlaM3BscThkVTQ2alU5Y1hMWnJCQjBFVXQrSXk0?=
 =?utf-8?B?MmN2S0lZV2xrTGROemFNTEtWUjZ4R000Y3pXa3Y3UzV6WGZZZzc0dmNPczkr?=
 =?utf-8?B?dE1EZm90ZXl0UHZUNlJkSklKcEVYOHhVREZhN0VacTlxQkZNMW16TTFCMXBu?=
 =?utf-8?B?TzV5NjJVaGtlQVdleXgrZnRHdHljQUlHRlNXR3ZzTjBiUDRWUC93VnFEZXRB?=
 =?utf-8?B?OGN2M3ZUWkNVSjR3QlBCcmZmMGh3Q2Ewc1NzQUJPWm9MQUFZNXhGZGhOeUx0?=
 =?utf-8?B?LzlTc1BLSXIybmZ4eCtBL05Cb3pGZjcwdG1LQ1RxcDFIUUFNY2dyRitORExl?=
 =?utf-8?B?SVNBdWdvZlJWZm1iaDNaUnVjS1NmMlVJRFgrQzlpQWs3cnpicll0Vm15ODVl?=
 =?utf-8?B?TDU0cmJFaDlzVnk2b3dlQlJRMXF3emJyUkM4ODl3TmZ3VlZ0RlE0aUNra1dk?=
 =?utf-8?B?WEd1RkR5YUZ5dnhsdVQ5N0NKQlpKRnRkZHZDTGwwelJQb21lWFRjM1JuSWxh?=
 =?utf-8?B?UCtFUTBrNzBDRE0wOGk4MVBZYWhaNnF5RzVidjFhY3pSQXVkSDZ0a0Z6c1VL?=
 =?utf-8?B?TDBJL2wycjdpdVFrOW5kOVhzeTFxSHV6QUttVVZ4Tlp1NEI2NGt5RjdSTkVU?=
 =?utf-8?B?TnJsSFJhM01YaTV3SldvNjhSY3BJVVJRSTJ4NDh1ZlVseUIxc25jWkdIdkhM?=
 =?utf-8?B?dkJQVXRPZVFjZ0Y0M3Q1ZnM3YytubmlIVmFTWUx0dk1xNTZYNHF2eEhjSmd6?=
 =?utf-8?B?OTZLWGllTHd0N25GVVcxdHNJWHNQMEw0bVNxdnJiYjdyMlkyNnZ6SkFsWFhx?=
 =?utf-8?B?OGhXbmFvRHBmY3lac041VVh2NWdPQ0lISWpXa0pGUVUwR1YreUJLVk9YNzU1?=
 =?utf-8?B?OUU5b2YvSDBldDlrd0JqcXpIUWhobHNWWFFHZHM4cEZjakpWeEJzc1E1NlE4?=
 =?utf-8?B?aitEbU9UMWhZZkl2MGFLc3JaZW1VcTQ5ZEhSbVhWWGU1a25iZXdMWk9wVzQy?=
 =?utf-8?B?WDEyTzJjQzZHU1IxRTBnaFRPWDdFRFJReU5pQkNGNHNzOHVTZHlKYW9ReGFu?=
 =?utf-8?B?Q0FUQ0sva3VQY3RQUEJLekdyWlNKLy9wcnNzUWJLdWdsRlNqd2ZSTUxzYTJw?=
 =?utf-8?B?ZWZsRnpzN0ZHcUJWMlpvN3hmdWZod1MyWHZQRWpRaVIzUjl1YWxtMlI5ODVQ?=
 =?utf-8?B?UTJSZ25BK3FjQ3JxczZicTVxOTlXSHgrR1FoZDdibnZPcE84L2MzQzRBRFJn?=
 =?utf-8?B?RWJtZ0VESEQ0dnQ2d0pJQ1lBZG1wSldmZURxTzkvNGtKQ1hUOWd3bFFPbWIw?=
 =?utf-8?B?Si9QTzNkY240WGdZbW9wRXAzT1FsOWRBeUNtOURSZ21XUU00cUw3Mnp3anc3?=
 =?utf-8?B?Qk81WlZqQVNBeHNCNWQzbndiK0RZSzFQbml6VEVqeWhGMlB1WWFjdVVQOXA5?=
 =?utf-8?B?M0NOc1NRT01yMXFPVVRJWGxZMWJNZzZIWExaM3pocW54dHpkcEhEdjZzUHNB?=
 =?utf-8?Q?ZsGGfHo1ZT3of?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d696313f-f334-4b92-62f8-08d8e00ca89b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 19:27:04.7659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFu9ga8vgfWLpN3VB8AqHDjzhcYbVr+BXAMB064k5Bpw+mIp+5OlAkk49hFXVAGe6QAcV5hRvDg6lEfvCShU/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2798
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-03-05 12:52 p.m., shaoyunl wrote:
> In passthrough configuration, hypervisior will trigger the SBR(Secondary bus reset) to the devices
> without sync to each other. This could cause device hang since for XGMI configuration, all the devices
> within the hive need to be reset at a limit time slot. This serial of patches try to solve this issue
> by co-operate with new SMU which will only do minimum house keeping to response the SBR request but don't
> do the real reset job and leave it to driver. Driver need to do the whole sw init and minimum HW init
> to bring up the SMU and trigger the reset(possibly BACO) on all the ASICs at the same time
> 
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
> Change-Id: I34e838e611b7623c7ad824704c7ce350808014fc
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  13 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 102 +++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  71 ++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |   8 +-
>   5 files changed, 165 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index d46d3794699e..5602c6edee97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -125,6 +125,10 @@ struct amdgpu_mgpu_info
>   	uint32_t			num_gpu;
>   	uint32_t			num_dgpu;
>   	uint32_t			num_apu;
> +
> +	/* delayed reset_func for XGMI configuration if necessary */
> +	struct delayed_work		delayed_reset_work;
> +	bool				pending_reset;
>   };
>   
>   #define AMDGPU_MAX_TIMEOUT_PARAM_LENGTH	256
> @@ -1124,6 +1128,15 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
>   bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
>   bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
>   
> +int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
> +				  struct amdgpu_job *job,
> +				  bool *need_full_reset_arg);
> +
> +int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
> +			  struct list_head *device_list_handle,
> +			  bool *need_full_reset_arg,
> +			  bool skip_hw_reset);
> +
>   int emu_soc_asic_init(struct amdgpu_device *adev);
>   
>   /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 3c35b0c1e710..5b520f70e660 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1220,6 +1220,10 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
>   		}
>   	}
>   
> +	/* Don't post if we need to reset whole hive on init */
> +	if (adev->gmc.xgmi.pending_reset)
> +		return false;
> +
>   	if (adev->has_hw_reset) {
>   		adev->has_hw_reset = false;
>   		return true;
> @@ -2149,6 +2153,9 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
>   			if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_PSP)
>   				continue;
>   
> +			if (!adev->ip_blocks[i].status.sw)
> +				continue;
> +
>   			/* no need to do the fw loading again if already done*/
>   			if (adev->ip_blocks[i].status.hw == true)
>   				break;
> @@ -2289,7 +2296,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>   
>   	if (adev->gmc.xgmi.num_physical_nodes > 1)
>   		amdgpu_xgmi_add_device(adev);
> -	amdgpu_amdkfd_device_init(adev);
> +
> +	/* Don't init kfd if whole hive need to be reset during init */
> +	if (!adev->gmc.xgmi.pending_reset)
> +		amdgpu_amdkfd_device_init(adev);
>   
>   	amdgpu_fru_get_product_info(adev);
>   
> @@ -2734,6 +2744,16 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>   			adev->ip_blocks[i].status.hw = false;
>   			continue;
>   		}
> +
> +		/* skip unnecessary suspend if we do not initialize them yet */
> +		if (adev->gmc.xgmi.pending_reset &&
> +		    !(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
> +		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC ||
> +		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
> +		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH)) {
> +			adev->ip_blocks[i].status.hw = false;
> +			continue;
> +		}
>   		/* XXX handle errors */
>   		r = adev->ip_blocks[i].version->funcs->suspend(adev);
>   		/* XXX handle errors */
> @@ -3407,10 +3427,28 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	 *  E.g., driver was not cleanly unloaded previously, etc.
>   	 */
>   	if (!amdgpu_sriov_vf(adev) && amdgpu_asic_need_reset_on_init(adev)) {
> -		r = amdgpu_asic_reset(adev);
> -		if (r) {
> -			dev_err(adev->dev, "asic reset on init failed\n");
> -			goto failed;
> +		if (adev->gmc.xgmi.num_physical_nodes) {
> +			dev_info(adev->dev, "Pending hive reset.\n");
> +			adev->gmc.xgmi.pending_reset = true;
> +			/* Only need to init necessary block for SMU to handle the reset */
> +			for (i = 0; i < adev->num_ip_blocks; i++) {
> +				if (!adev->ip_blocks[i].status.valid)
> +					continue;
> +				if (!(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
> +				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
> +				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
> +				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC)) {
> +					DRM_DEBUG("IP %s disabed for hw_init.\n",
> +						adev->ip_blocks[i].version->funcs->name);
> +					adev->ip_blocks[i].status.hw = true;
> +				}
> +			}
> +		} else {
> +			r = amdgpu_asic_reset(adev);
> +			if (r) {
> +				dev_err(adev->dev, "asic reset on init failed\n");
> +				goto failed;
> +			}
>   		}
>   	}
>   
> @@ -3541,19 +3579,19 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	/* enable clockgating, etc. after ib tests, etc. since some blocks require
>   	 * explicit gating rather than handling it automatically.
>   	 */
> -	r = amdgpu_device_ip_late_init(adev);
> -	if (r) {
> -		dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
> -		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
> -		goto failed;
> +	if (!adev->gmc.xgmi.pending_reset) {
> +		r = amdgpu_device_ip_late_init(adev);
> +		if (r) {
> +			dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
> +			amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
> +			goto failed;
> +		}
> +		/* must succeed. */
> +		amdgpu_ras_resume(adev);
> +		queue_delayed_work(system_wq, &adev->delayed_init_work,
> +				   msecs_to_jiffies(AMDGPU_RESUME_MS));
>   	}
>   
> -	/* must succeed. */
> -	amdgpu_ras_resume(adev);
> -
> -	queue_delayed_work(system_wq, &adev->delayed_init_work,
> -			   msecs_to_jiffies(AMDGPU_RESUME_MS));
> -
>   	if (amdgpu_sriov_vf(adev))
>   		flush_delayed_work(&adev->delayed_init_work);
>   
> @@ -3570,6 +3608,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	if (amdgpu_device_cache_pci_state(adev->pdev))
>   		pci_restore_state(pdev);
>   
> +	if (adev->gmc.xgmi.pending_reset)
> +		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
> +				   msecs_to_jiffies(AMDGPU_RESUME_MS));
> +
>   	return 0;
>   
>   failed:
> @@ -4240,14 +4282,16 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
>   }
>   
>   
> -static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
> -					struct amdgpu_job *job,
> -					bool *need_full_reset_arg)
> +int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
> +				  struct amdgpu_job *job,
> +				  bool *need_full_reset_arg)
>   {
>   	int i, r = 0;
>   	bool need_full_reset  = *need_full_reset_arg;
>   
> -	amdgpu_debugfs_wait_dump(adev);
> +	/* no need to dump if device is not in good state during probe period */
> +	if (!adev->gmc.xgmi.pending_reset)
> +		amdgpu_debugfs_wait_dump(adev);
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		/* stop the data exchange thread */
> @@ -4293,10 +4337,10 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> -static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
> -			       struct list_head *device_list_handle,
> -			       bool *need_full_reset_arg,
> -			       bool skip_hw_reset)
> +int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
> +			  struct list_head *device_list_handle,
> +			  bool *need_full_reset_arg,
> +			  bool skip_hw_reset)
>   {
>   	struct amdgpu_device *tmp_adev = NULL;
>   	bool need_full_reset = *need_full_reset_arg, vram_lost = false;
> @@ -4310,6 +4354,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>   		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
>   			/* For XGMI run all resets in parallel to speed up the process */
>   			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
> +				tmp_adev->gmc.xgmi.pending_reset = false;
>   				if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
>   					r = -EALREADY;
>   			} else
> @@ -4348,10 +4393,10 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>   	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
>   		if (need_full_reset) {
>   			/* post card */
> -			if (amdgpu_device_asic_init(tmp_adev))
> +			r = amdgpu_device_asic_init(tmp_adev);
> +			if (r) {
>   				dev_warn(tmp_adev->dev, "asic atom init failed!");
> -
> -			if (!r) {
> +			} else {
>   				dev_info(tmp_adev->dev, "GPU reset succeeded, trying to resume\n");
>   				r = amdgpu_device_ip_resume_phase1(tmp_adev);
>   				if (r)
> @@ -4384,6 +4429,9 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>   				 */
>   				amdgpu_register_gpu_instance(tmp_adev);
>   
> +				if (!hive && tmp_adev->gmc.xgmi.num_physical_nodes > 1)
> +					amdgpu_xgmi_add_device(tmp_adev);
> +
>   				r = amdgpu_device_ip_late_init(tmp_adev);
>   				if (r)
>   					goto out;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 253c59e0a100..aebe4bc561ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -44,6 +44,7 @@
>   #include "amdgpu_amdkfd.h"
>   
>   #include "amdgpu_ras.h"
> +#include "amdgpu_xgmi.h"
>   
>   /*
>    * KMS wrapper.
> @@ -167,8 +168,13 @@ uint amdgpu_freesync_vid_mode;
>   int amdgpu_reset_method = -1; /* auto */
>   int amdgpu_num_kcq = -1;
>   
> +static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
> +
>   struct amdgpu_mgpu_info mgpu_info = {
>   	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
> +	.delayed_reset_work = __DELAYED_WORK_INITIALIZER(
> +			mgpu_info.delayed_reset_work,
> +			amdgpu_drv_delayed_reset_work_handler, 0),
>   };
>   int amdgpu_ras_enable = -1;
>   uint amdgpu_ras_mask = 0xffffffff;
> @@ -1297,6 +1303,71 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
>   	adev->mp1_state = PP_MP1_STATE_NONE;
>   }
>   
> +/**
> + * amdgpu_drv_delayed_reset_work_handler - work handler for reset
> + *
> + * @work: work_struct.
> + */
> +static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
> +{
> +	struct list_head device_list;
> +	struct amdgpu_device *adev;
> +	int i, r;
> +	bool need_full_reset = true;
> +
> +	mutex_lock(&mgpu_info.mutex);
> +	if (mgpu_info.pending_reset == true) {
> +		mutex_unlock(&mgpu_info.mutex);
> +		return;
> +	}
> +	mgpu_info.pending_reset = true;
> +	mutex_unlock(&mgpu_info.mutex);
> +
> +	for (i = 0; i < mgpu_info.num_dgpu; i++) {
> +		adev = mgpu_info.gpu_ins[i].adev;
> +		r = amdgpu_device_pre_asic_reset(adev, NULL, &need_full_reset);

Why amdgpu_device_pre_asic_reset is needed ?

> +		if (r) {
> +			dev_err(adev->dev, "GPU pre asic reset failed with err, %d for drm dev, %s ",
> +				r, adev_to_drm(adev)->unique);
> +		}
> +		if (!queue_work(system_unbound_wq, &adev->xgmi_reset_work))
> +			r = -EALREADY;

amdgpu_do_asic_reset bellow will already schedule xgmi_reset_work for 
this device, what you could do instead is call amdgpu_do_asic_reset for 
each member of the hive and because there is a task barrier in 
amdgpu_device_xgmi_reset_func, it will synchronize all the resets to 
same point in time already.

> +	}
> +	msleep(100);

What's the 100ms is wiating for ?

> +	for (i = 0; i < mgpu_info.num_dgpu; i++) {
> +		adev = mgpu_info.gpu_ins[i].adev;
> +		adev->gmc.xgmi.pending_reset = false;
> +		flush_work(&adev->xgmi_reset_work);
> +	}
> +
> +	msleep(100);

Same as above

> +	/* reset function will rebuild the xgmi hive info , clear it now */
> +	for (i = 0; i < mgpu_info.num_dgpu; i++)
> +		amdgpu_xgmi_remove_device(mgpu_info.gpu_ins[i].adev);
> +
> +	INIT_LIST_HEAD(&device_list);
> +
> +	for (i = 0; i < mgpu_info.num_dgpu; i++)
> +		list_add_tail(&mgpu_info.gpu_ins[i].adev->reset_list, &device_list);
> +
> +	/* unregister the GPU first, reset function will add them back */
> +	list_for_each_entry(adev, &device_list, reset_list)
> +		amdgpu_unregister_gpu_instance(adev);
> +
> +	r = amdgpu_do_asic_reset(NULL, &device_list, &need_full_reset, true);
> +	if (r) {
> +		DRM_ERROR("reinit gpus failure");
> +		return;
> +	}
> +	for (i = 0; i < mgpu_info.num_dgpu; i++) {
> +		adev = mgpu_info.gpu_ins[i].adev;
> +		if (!adev->kfd.init_complete)
> +			amdgpu_amdkfd_device_init(adev);
> +		amdgpu_ttm_set_buffer_funcs_status(adev, true);
> +	}
> +	return;
> +}
> +
>   static int amdgpu_pmops_suspend(struct device *dev)
>   {
>   	struct drm_device *drm_dev = dev_get_drvdata(dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index aa0c83776ce0..8c71d84a2fbe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -149,6 +149,7 @@ struct amdgpu_xgmi {
>   	struct list_head head;
>   	bool supported;
>   	struct ras_common_if *ras_if;
> +	bool pending_reset;
>   };
>   
>   struct amdgpu_gmc {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 659b385b27b5..b459ef755ea9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -492,7 +492,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>   	if (!adev->gmc.xgmi.supported)
>   		return 0;
>   
> -	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
> +	if (!adev->gmc.xgmi.pending_reset &&
> +	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>   		ret = psp_xgmi_initialize(&adev->psp);
>   		if (ret) {
>   			dev_err(adev->dev,
> @@ -538,7 +539,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>   
>   	task_barrier_add_task(&hive->tb);
>   
> -	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
> +	if (!adev->gmc.xgmi.pending_reset &&
> +	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>   		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
>   			/* update node list for other device in the hive */
>   			if (tmp_adev != adev) {
> @@ -567,7 +569,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>   		}
>   	}
>   
> -	if (!ret)
> +	if (!ret && !adev->gmc.xgmi.pending_reset)
>   		ret = amdgpu_xgmi_sysfs_add_dev_info(adev, hive);
>   
>   exit_unlock:
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
