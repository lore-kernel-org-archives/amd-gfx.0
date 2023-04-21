Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950E1C77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Apr 2023 12:37:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E09010E0D6;
	Fri, 21 Apr 2023 12:37:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B778610E0D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 12:37:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8YiMfy4ARe2YigumihcOBEGjkqGF0cjkrXezvZmaCDxZNd8TF1xFL57kbdc2pdfkQeiaF3I05iN7Fb8Zqfq7DEXbl4HXZy5ZmLRv1/Nt2tnfc0VrIR23DvRpB86erdUQ0A175QBe0auJWGPibxfWdAlJynP/BgMzuUU+CdcwrLkfBzs9mtLlSqeUadlL0LQD7xqkUf/539DHEKmp6QVE3/wfSIzkYhljRyFz3m7KysYjRf4YE/lFIj5W0z5x0o3kgH8GfL4sngd8nRer+Mjepw7Z9807VT4gINT0riQgQWc/X9M3hhSFok+s0PAEVr8aTaNYcoxfiZ/mzDjt9i44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8cKEBIcXnYki0cIE+rhi0+rCY4ERRoYhivu2v6GBBE=;
 b=CwO5YfH0fWC8EPM5WbyjsfcI3edg3iqbFSprA9Bd1hr3qZLPuTa4Vpe5KQJdOHhkTLRLtdNYM8x7gtGxfII/biqhXA7MI8DsaIQ81VOrpLWtLBm7pJnocH1UIkks4jNh/JH/mM7IpkwPc2tSxQbNxFi/gtpg6C78F1w1M2Use8BsDrkI0TuM+LPcYw+72YzVikBEOAH6Ehz1MHQFw9NI8SyHA4TmlYm/X4BEqD2lgZzMbvECL/2uIOmeweesCZaNy38e2krfyipgSiuiJAZW0lKiG4C4kfC/ngT8J8J3QY8M9rEx9Cv+TTcpwgiomb/9Pu7U/0Pow20az+aHesGXug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8cKEBIcXnYki0cIE+rhi0+rCY4ERRoYhivu2v6GBBE=;
 b=CYvPhpeRNsgmqbiep1WtfPRdX/Bjq+UTpz3ffUczOcJxSHTDUTh9ScxROeV+8+AiJStd6CMy2LMAEeGlUMwhJlWsQa1mDYKyYn+h6YMnM1XfYZtYTcgec5aVLgTYfrfs4EwjjNmS17xRMaYH3WOxLmrgefi+Rqq1pYN7zDH+wAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS0PR12MB7584.namprd12.prod.outlook.com (2603:10b6:8:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 12:37:51 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 12:37:50 +0000
Message-ID: <40ef0a99-d159-d3ec-848f-efab6e702b56@amd.com>
Date: Fri, 21 Apr 2023 14:37:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/6] drm/amdgpu: Implement a new userqueue fence driver
Content-Language: en-US
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230420144714.124377-1-Arunpravin.PaneerSelvam@amd.com>
 <20230420144714.124377-3-Arunpravin.PaneerSelvam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230420144714.124377-3-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0265.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::14) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS0PR12MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c33715-99be-4300-dbd2-08db42653848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wTLLlZnON0E0pT8izW+SzLglEj1QWPAeFHQ48zYMBvTGpwwtyTWU8YHuYAOUHrnXrHHnGLCVl81ihYipSU7zlHTs2fAD5ISLbtgZYZgdfIat/JbQUW2ivzNBT22VjRwUt7B2/7Gy0jYtyhBwXMgPU9aODjpGZhuFbZ6xmhSbFVqNIvJwgy/xSJBFm9FduHNXD3ueirGO7/AolFOgptDW6HZvjDnhTj4lvSX27a+vsTOkpzWWtLg5y/zjwl1shLVs3jUvWH6uf/eF93EHuoFK7BlpN2iXxuveuGo3mkrUiUfT4hyRN1sdNZXuccvBAVtbRUrr8ksmtsTMIPt0Zt6kEYgIEnTLZRTSzcWQQfP2y2wgnYApaUEAuVBSB7UfNgSHWbF+kiBmJf86j/4s9F1rOEvrb8vYanPy5VwXtl7uG30q7Ig8xAKFzBZdRUHf8KnIITuy2Jhlw906MyIgVit3JG6EEOt0Nsy9fmZ+QbpjVfIninHhDl9rJIebdzmbIpqG8J8Xzs00vW/E0q0Ayw0Oob5SqwViqeJa4ihDjWb2VFjoAnOO7UGiRB1AMvXa7U9POYvkepy1UwtblpOwytKDm9nEGxZH1XlrVynwP19Znb4qg7bKe61W2RjwtFSx9OzoVr51NeN/GiNpio8Ox1sVCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(83380400001)(478600001)(2616005)(31686004)(6506007)(31696002)(6486002)(6512007)(6666004)(66476007)(66556008)(41300700001)(66946007)(4326008)(316002)(186003)(5660300002)(38100700002)(66899021)(8676002)(2906002)(8936002)(30864003)(86362001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajZqK2preDBKam9wcEFZNDhoYU1wdnR1WHluU21JYkNFUURrTDZNaG9JaXFq?=
 =?utf-8?B?V3RKUFc1OWtlNGE4b2o5Nm9rQ2xpY2ltVjRTSHBNNW5rbjdQM3MyeUdZMUZk?=
 =?utf-8?B?eDNnV0xWMDN4WFZtbUpjbHVSZ3M4RDNqajBGQXM4S2h5d3pHdWVzZUM5aWdV?=
 =?utf-8?B?c1lTYkVjckVDaXJnVlMydkxXQXJwVSthNnhoOEdPY2tCcXBYaStEY29tREFL?=
 =?utf-8?B?N1Z4L0NoWGxOT3poRTBIQis4M1pSamsxdmh2YWlqWFBOM1ZXdXkzRTIwSlBE?=
 =?utf-8?B?OVpSV2Y2MUM2VGl2aklHUFZGd29zUWRGOVJMUk9rY3JkbUtkWEk2ZExWdTJz?=
 =?utf-8?B?TFV6TzdYMitHa1RyU2llZkVoeHppUmxJakpGdUYreWs4VW9WckwrZU9jajE5?=
 =?utf-8?B?ZjE5MDZCWmdQSTFCV2I5VC9pcDhqSE5jcXc5U2t4TUdhWHcxbGZGRFZGdUx1?=
 =?utf-8?B?VFE2eXB3Z05BRXNMYXo3aEhHN3cwVXRQa0RYWW9ENGNGY1VrUWVNejFjelRi?=
 =?utf-8?B?cnpwbjRoeE1LSmFHa3YzSkh4cnJOdndOd2lIYzFQQndsOFR6UjQ0TUUycjU0?=
 =?utf-8?B?MVZ6TTdCZ1hIQUkzOTdCYWlRcnd4cUoybHphTkdKSit1WFNPU005WUhMMjhU?=
 =?utf-8?B?VEtwakIwbHNvWG9XUDNpbzlQcFpESGRqSjdSR0E4aUo2bDdpWDZzNzNXWER5?=
 =?utf-8?B?bWp0U3ZNaXk4Q0NTeFRVNVdGNUZDZjJic0ZFMVRlNWZiTjBLN0RCTGI2ZWda?=
 =?utf-8?B?aFpQMWxEb2k0S1JWVXNWdCtoZjFaQ2YyeHVnVEx2cWdXTTlIN2lIVm5lSEly?=
 =?utf-8?B?V1lRd1dxa2R1TUJHWjNWOFVFVGdGZUk1eFdUTGM5V1Y5eEhQNXVxRTlFUDVs?=
 =?utf-8?B?OXVtZkZ5OFoyUi9xWFNQVFBhS0tGdVFPU0dDSW5DS2pmazhLSitGVWhVdG8y?=
 =?utf-8?B?MXdRSGZ5M2ZGa0M2YUROL1B4cTJNQnBJUkhvb0V0UU5hNTVTZS85aUpYQkNp?=
 =?utf-8?B?YjUvRmNLME1MK0pVMi9LRU10eDRaMWRIRkZKUWlacXdoaVZNcXM4UGp4Rlky?=
 =?utf-8?B?a2JZZCt1ZnBRTERCVVNNN0FIWGNWZHFlS1kwU09lU0hRcXprdTFhRXNpNjI1?=
 =?utf-8?B?YnBQRVVYa3F0YUFXTkxuekF4K1hNOUhnZDJjYVZRZDNCcXJ3ZmdPeHNmcVJR?=
 =?utf-8?B?WWk1OEx4UmlxVEdFanIvUUVzN1VKeDVkRXVWUnk3andTTDg2WHVWZENnMVEv?=
 =?utf-8?B?dWtNNnpldDJ0YmZEalRtMzJHRDB3SWFpdERxMmNqNFl6a05pdUVVc3lWZk9G?=
 =?utf-8?B?dk0xZUZvdVVoOWRGc255cFdUY2lzSEpubHNJdFJzU051UnU5dWFUYXVzME5R?=
 =?utf-8?B?MUQvalpQdlA2cERJODZLK2F0K0FsR0NLaFZnYnhWY2JrY2JtdnJjU1VpQUUx?=
 =?utf-8?B?K09XdXFOSkpIVE5wOUZ4ZDlLT1hCeWdZaTV3ZjQ4dlI3N3l5NHRtUzFMT2Rk?=
 =?utf-8?B?Qm5kckNpVHZhTk1GalFmQzdzS3ZocjRJb3ZyOHVGdCttajQzVXV5WGUxalow?=
 =?utf-8?B?WjRmQTFGWjduTU9NL1JJWjJmUm9HcFpCSllqV2lqQWllTXpQcnQyV3AxVUFH?=
 =?utf-8?B?dUhQWlB4cTF1MlUzeFZBaUEva1B2UXZGT01TbzdVUlFqdXNRU050aksvN2Vm?=
 =?utf-8?B?NExNOEdsdDdLNmw2dnhnMi8vc1k2bmhSV3ZsOXhLSmtOVzRqSGswSUM2eXA1?=
 =?utf-8?B?THRZTFNmblJZamVtMURDRjlkd2ozMnRsb0RuYzRlS1Q4dmF3bEx1c2ZoT2xX?=
 =?utf-8?B?ZEZVUldrRXQ4ZVhBeDEvRTYzZy9YN0J3SEJGVTRpUFVzYVdPeGpEeldJV0ph?=
 =?utf-8?B?YlNkVnlXb05YNjNVYWlYb25IVVNOOGQ3ZWhJNGo5cG84eEN1K2x0MnRCOGVO?=
 =?utf-8?B?L0pkdlhZUFQrbFdWZ3A2aTdEbWo5TW9FLzNEQ0tTM2JNYlIrWmtrNWNpamw4?=
 =?utf-8?B?em43dkxSSHMyWVloZUI1M213QlEwTG13WStoR1hMRFFpSU55emtnN3BoeG9W?=
 =?utf-8?B?ZFZObFlNZkhtTkhRS0dFS3paenh3S1dQeFRBV2FlTUtOcG9NeWE1cWF4ejJQ?=
 =?utf-8?B?UHo2R3htZzQxYjd6Y2VDRnJ6cDlpNDBmaUpIbEl4Z0lvUHczaGpueWI3amw0?=
 =?utf-8?Q?U0nAxGUggN9iA6UcTP7EMgVXxYndJzT6X3NOEs4LaLeT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c33715-99be-4300-dbd2-08db42653848
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 12:37:50.7970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: le0c6CI+BRyyzto+GWEodRDHwIxaYRJd8Rh4H7cmWK4Svlf96MrpgdY0xStbAPCu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7584
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 20.04.23 um 16:47 schrieb Arunpravin Paneer Selvam:
> Developed a userqueue fence driver for the userqueue process shared
> BO synchronization.
>
> Create a dma fence having write pointer as the seqno and allocate a
> seq64 memory for each user queue process and feed this memory address
> into the firmware/hardware, thus the firmware writes the read pointer
> into the given address when the process completes it execution.
> Compare wptr and rptr, if rptr >= wptr, signal the fences for the waiting
> process to consume the buffers.
>
> v2: Worked on review comments from Christian for the following
>      modifications
>
>      - Add wptr as sequence number into the fence
>      - Add a reference count for the fence driver
>      - Add dma_fence_put below the list_del as it might frees the userq fence.
>      - Trim unnecessary code in interrupt handler.
>      - Check dma fence signaled state in dma fence creation function for a
>        potential problem of hardware completing the job processing beforehand.
>      - Add necessary locks.
>      - Create a list and process all the unsignaled fences.
>      - clean up fences in destroy function.
>      - implement .signaled callback function
>
> v3: Worked on review comments from Christian
>      - Modify naming convention for reference counted objects
>      - Fix fence driver reference drop issue
>      - Drop amdgpu_userq_fence_driver_process() function return value

That looks really good, just two more comments below.

>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   build.sh                                      |  11 +
>   drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   6 +
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 253 ++++++++++++++++++
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  64 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  19 ++
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |   1 +
>   7 files changed, 355 insertions(+), 1 deletion(-)
>   create mode 100755 build.sh
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>
> diff --git a/build.sh b/build.sh
> new file mode 100755
> index 000000000000..fddaff75dd2a
> --- /dev/null
> +++ b/build.sh
> @@ -0,0 +1,11 @@
> +#make -j16 modules M=drivers/gpu/drm/
> +#make -j16 modules M=drivers/gpu/drm/selftests/
> +make -j16 modules M=drivers/gpu/drm/amd/amdgpu/
> +#make -j16 modules M=drivers/gpu/drm/ttm/
> +#cp drivers/gpu/drm/drm.ko /lib/modules/$(uname -r)/kernel/drivers/gpu/drm/
> +#cp drivers/gpu/drm/selftests/test-drm_buddy.ko /lib/modules/$(uname -r)/kernel/drivers/gpu/drm/selftests/
> +#cp drivers/gpu/drm/amd/amdgpu/amdgpu.ko /lib/modules/$(uname -r)/kernel/drivers/gpu/drm/amd/amdgpu/
> +#cp drivers/gpu/drm/ttm/ttm.ko /lib/modules/$(uname -r)/kernel/drivers/gpu/drm/ttm/
> +#update-initramfs -c -k $(uname -r)
> +#reboot
> +

I strongly assume you didn't intentionally committed that, did you?

Anyway, please remove :)

> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index d39504e65db1..8ed9be0d4818 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -59,7 +59,7 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
>   	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>   	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>   	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
> -	amdgpu_ring_mux.o amdgpu_seq64.o
> +	amdgpu_ring_mux.o amdgpu_seq64.o amdgpu_userq_fence.o
>   
>   amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 229976a2d0e7..e9c5047087d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -53,6 +53,7 @@
>   #include "amdgpu_xgmi.h"
>   #include "amdgpu_reset.h"
>   #include "amdgpu_userqueue.h"
> +#include "amdgpu_userq_fence.h"
>   
>   /*
>    * KMS wrapper.
> @@ -2826,6 +2827,10 @@ static int __init amdgpu_init(void)
>   	if (r)
>   		goto error_fence;
>   
> +	r = amdgpu_userq_fence_slab_init();
> +	if (r)
> +		goto error_fence;
> +
>   	DRM_INFO("amdgpu kernel modesetting enabled.\n");
>   	amdgpu_register_atpx_handler();
>   	amdgpu_acpi_detect();
> @@ -2850,6 +2855,7 @@ static void __exit amdgpu_exit(void)
>   	amdgpu_unregister_atpx_handler();
>   	amdgpu_sync_fini();
>   	amdgpu_fence_slab_fini();
> +	amdgpu_userq_fence_slab_fini();
>   	mmu_notifier_synchronize();
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> new file mode 100644
> index 000000000000..a03d12f83147
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -0,0 +1,253 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include <linux/kref.h>
> +#include <linux/slab.h>
> +
> +#include <drm/drm_syncobj.h>
> +
> +#include "amdgpu.h"
> +#include "amdgpu_userq_fence.h"
> +
> +static struct kmem_cache *amdgpu_userq_fence_slab;
> +
> +int amdgpu_userq_fence_slab_init(void)
> +{
> +	amdgpu_userq_fence_slab = kmem_cache_create("amdgpu_userq_fence",
> +						    sizeof(struct amdgpu_userq_fence),
> +						    0,
> +						    SLAB_HWCACHE_ALIGN,
> +						    NULL);
> +	if (!amdgpu_userq_fence_slab)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +void amdgpu_userq_fence_slab_fini(void)
> +{
> +	rcu_barrier();
> +	kmem_cache_destroy(amdgpu_userq_fence_slab);
> +}
> +
> +static inline struct amdgpu_userq_fence *to_amdgpu_userq_fence(struct dma_fence *f)
> +{
> +	struct amdgpu_userq_fence *__f = container_of(f, struct amdgpu_userq_fence, base);
> +
> +	if (!__f)
> +		return NULL;
> +
> +	if (__f->base.ops == &amdgpu_userq_fence_ops)
> +		return __f;
> +
> +	return NULL;
> +}
> +
> +static u64 amdgpu_userq_fence_read(struct amdgpu_userq_fence_driver *fence_drv)
> +{
> +	return le64_to_cpu(*fence_drv->cpu_addr);
> +}
> +
> +int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
> +				    struct amdgpu_usermode_queue *userq)
> +{
> +	struct amdgpu_userq_fence_driver *fence_drv;
> +	int r;
> +
> +	fence_drv = userq->fence_drv;
> +	if (!fence_drv)
> +		return -EINVAL;
> +
> +	/* Acquire seq64 memory */
> +	r = amdgpu_seq64_get(adev, &fence_drv->gpu_addr,
> +			     &fence_drv->cpu_addr);
> +	if (r)
> +		return -ENOMEM;
> +	
> +	kref_init(&fence_drv->refcount);
> +	INIT_LIST_HEAD(&fence_drv->fences);
> +	spin_lock_init(&fence_drv->fence_list_lock);
> +
> +	fence_drv->adev = adev;
> +	fence_drv->context = dma_fence_context_alloc(1);
> +
> +	get_task_comm(fence_drv->timeline_name, current);
> +
> +	return 0;
> +}
> +
> +void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
> +{
> +	struct amdgpu_userq_fence *userq_fence, *tmp;
> +	struct dma_fence *fence;
> +
> +	if (!fence_drv)
> +		return;
> +
> +	spin_lock(&fence_drv->fence_list_lock);
> +	list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, link) {
> +		fence = &userq_fence->base;
> +
> +		if (amdgpu_userq_fence_read(fence_drv) >= fence->seqno) {
> +			dma_fence_signal(fence);
> +			list_del(&userq_fence->link);
> +
> +			dma_fence_put(fence);
> +		} else {
> +			break;
> +		}
> +	}
> +	spin_unlock(&fence_drv->fence_list_lock);
> +}
> +
> +void amdgpu_userq_fence_driver_destroy(struct kref *ref)
> +{
> +	struct amdgpu_userq_fence_driver *fence_drv = container_of(ref,
> +					 struct amdgpu_userq_fence_driver,
> +					 refcount);
> +	struct amdgpu_device *adev = fence_drv->adev;
> +	struct amdgpu_userq_fence *fence, *tmp;
> +	struct dma_fence *f;
> +	
> +	spin_lock(&fence_drv->fence_list_lock);
> +	list_for_each_entry_safe(fence, tmp, &fence_drv->fences, link) {
> +		f = &fence->base;
> +		
> +		if (!dma_fence_is_signaled(f)) {
> +			dma_fence_set_error(f, -ECANCELED);
> +			dma_fence_signal(f);
> +		}
> +		
> +		list_del(&fence->link);
> +		dma_fence_put(f);
> +	}
> +	
> +	WARN_ON_ONCE(!list_empty(&fence_drv->fences));
> +	spin_unlock(&fence_drv->fence_list_lock);
> +	
> +	/* Free seq64 memory */
> +	amdgpu_seq64_free(adev, fence_drv->gpu_addr);
> +	kfree(fence_drv);
> +}
> +
> +void amdgpu_userq_fence_driver_get(struct amdgpu_userq_fence_driver *fence_drv)
> +{
> +	kref_get(&fence_drv->refcount);
> +}
> +
> +void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv)
> +{
> +	kref_put(&fence_drv->refcount, amdgpu_userq_fence_driver_destroy);
> +}
> +
> +int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
> +			      u64 seq, struct dma_fence **f)
> +{
> +	struct amdgpu_userq_fence_driver *fence_drv;
> +	struct amdgpu_userq_fence *userq_fence;
> +	struct dma_fence *fence;
> +
> +	fence_drv = userq->fence_drv;
> +	if (!fence_drv)
> +		return -EINVAL;
> +
> +	userq_fence = kmem_cache_alloc(amdgpu_userq_fence_slab, GFP_ATOMIC);
> +	if (!userq_fence)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&userq_fence->lock);
> +	INIT_LIST_HEAD(&userq_fence->link);
> +	fence = &userq_fence->base;
> +	userq_fence->fence_drv = fence_drv;
> +
> +	dma_fence_init(fence, &amdgpu_userq_fence_ops, &userq_fence->lock,
> +		       fence_drv->context, seq);
> +
> +	amdgpu_userq_fence_driver_get(fence_drv);
> +	dma_fence_get(fence);
> +
> +	spin_lock(&fence_drv->fence_list_lock);
> +	/* Check if hardware has already processed the job */
> +	if (!dma_fence_is_signaled(fence)) {
> +		list_add_tail(&userq_fence->link, &fence_drv->fences);
> +	} else {
> +		dma_fence_put(fence);
> +	}
> +	spin_unlock(&fence_drv->fence_list_lock);
> +
> +	*f = fence;
> +
> +	return 0;
> +}
> +
> +static const char *amdgpu_userq_fence_get_driver_name(struct dma_fence *f)
> +{
> +	return "amdgpu_userqueue_fence";
> +}
> +
> +static const char *amdgpu_userq_fence_get_timeline_name(struct dma_fence *f)
> +{
> +	struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
> +
> +	return fence->fence_drv->timeline_name;
> +}
> +
> +static bool amdgpu_userq_fence_signaled(struct dma_fence *f)
> +{
> +	struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
> +	struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
> +	u64 rptr, wptr;
> +
> +	rptr = amdgpu_userq_fence_read(fence_drv);
> +	wptr = fence->base.seqno;
> +
> +	if (rptr >= wptr)
> +		return true;
> +
> +	return false;
> +}
> +
> +static void amdgpu_userq_fence_free(struct rcu_head *rcu)
> +{
> +	struct dma_fence *fence = container_of(rcu, struct dma_fence, rcu);
> +	struct amdgpu_userq_fence *userq_fence = to_amdgpu_userq_fence(fence);
> +	struct amdgpu_userq_fence_driver *fence_drv = userq_fence->fence_drv;
> +
> +	/* Release the fence driver reference */
> +	amdgpu_userq_fence_driver_put(fence_drv);
> +	kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
> +}
> +
> +static void amdgpu_userq_fence_release(struct dma_fence *f)
> +{
> +	call_rcu(&f->rcu, amdgpu_userq_fence_free);
> +}
> +
> +static const struct dma_fence_ops amdgpu_userq_fence_ops = {
> +	.use_64bit_seqno = true,
> +	.get_driver_name = amdgpu_userq_fence_get_driver_name,
> +	.get_timeline_name = amdgpu_userq_fence_get_timeline_name,
> +	.signaled = amdgpu_userq_fence_signaled,
> +	.release = amdgpu_userq_fence_release,
> +};
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> new file mode 100644
> index 000000000000..7329b4e5dd30
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __AMDGPU_USERQ_FENCE_H__
> +#define __AMDGPU_USERQ_FENCE_H__
> +
> +#include <linux/types.h>
> +
> +#include "amdgpu_userqueue.h"
> +
> +struct amdgpu_userq_fence {
> +	struct dma_fence base;
> +	/* userq fence lock */
> +	spinlock_t lock;

This one.

> +	struct list_head link;
> +	struct amdgpu_userq_fence_driver *fence_drv;
> +};
> +
> +struct amdgpu_userq_fence_driver {
> +	struct kref refcount;
> +	u64 gpu_addr;
> +	u64 *cpu_addr;
> +	u64 context;
> +	/* fence list lock */
> +	spinlock_t fence_list_lock;

And that one here should have better documentation.

It's obvious what they are, so the existing doc doesn't help at all.

What you need to document is why they are separate.

> +	struct list_head fences;
> +	struct amdgpu_device *adev;
> +	char timeline_name[TASK_COMM_LEN];
> +};
> +
> +static const struct dma_fence_ops amdgpu_userq_fence_ops;
> +
> +int amdgpu_userq_fence_slab_init(void);
> +void amdgpu_userq_fence_slab_fini(void);
> +int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
> +			      u64 seq, struct dma_fence **f);
> +void amdgpu_userq_fence_driver_get(struct amdgpu_userq_fence_driver *fence_drv);
> +void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv);
> +int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev, struct amdgpu_usermode_queue *userq);
> +void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
> +void amdgpu_userq_fence_driver_destroy(struct kref *ref);
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index fd4a2ca3302d..8918b176fdcb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -24,6 +24,7 @@
>   #include "amdgpu.h"
>   #include "amdgpu_vm.h"
>   #include "amdgpu_userqueue.h"
> +#include "amdgpu_userq_fence.h"
>   
>   static inline int
>   amdgpu_userqueue_index(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
> @@ -158,6 +159,8 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
>       struct amdgpu_fpriv *fpriv = filp->driver_priv;
>       struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>       struct drm_amdgpu_userq_mqd *mqd_in = &args->in.mqd;
> +    struct amdgpu_userq_fence_driver *fence_drv;
> +    struct amdgpu_device *adev = uq_mgr->adev;
>       uint64_t index;
>       int r;
>   
> @@ -173,6 +176,12 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
>           return -ENOMEM;
>       }
>   
> +    fence_drv = kzalloc(sizeof(struct amdgpu_userq_fence_driver), GFP_KERNEL);
> +    if (!fence_drv) {
> +	    DRM_ERROR("Failed to allocate memory for fence driver\n");
> +	    return -ENOMEM;
> +    }
> +

Why don't we have this kzalloc() inside amdgpu_userq_fence_driver_alloc() ?

Christian.

>       mutex_lock(&uq_mgr->userq_mutex);
>       queue->userq_prop.wptr_gpu_addr = mqd_in->wptr_va;
>       queue->userq_prop.rptr_gpu_addr = mqd_in->rptr_va;
> @@ -188,6 +197,13 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
>           goto free_queue;
>       }
>   
> +    queue->fence_drv = fence_drv;
> +    r = amdgpu_userq_fence_driver_alloc(adev, queue);
> +    if (r) {
> +	    DRM_ERROR("Failed to alloc fence driver\n");
> +	    goto free_fence_drv;
> +    }
> +
>       queue->userq_prop.doorbell_index = index;
>       queue->shadow_ctx_gpu_addr = mqd_in->shadow_va;
>       queue->queue_type = mqd_in->ip_type;
> @@ -217,6 +233,8 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
>       mutex_unlock(&uq_mgr->userq_mutex);
>       return 0;
>   
> +free_fence_drv:
> +    amdgpu_userq_fence_driver_put(queue->fence_drv);
>   free_queue:
>       mutex_unlock(&uq_mgr->userq_mutex);
>       kfree(queue);
> @@ -238,6 +256,7 @@ static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>       mutex_lock(&uq_mgr->userq_mutex);
>       uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy(uq_mgr, queue);
>       amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
> +    amdgpu_userq_fence_driver_put(queue->fence_drv);
>       mutex_unlock(&uq_mgr->userq_mutex);
>       kfree(queue);
>   }
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index eaab7cf5fff6..eaea88539007 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -50,6 +50,7 @@ struct amdgpu_usermode_queue {
>   	struct amdgpu_mqd_prop userq_prop;
>   	struct amdgpu_userq_ctx_space mqd;
>   	struct amdgpu_userq_ctx_space fw_space;
> +	struct amdgpu_userq_fence_driver *fence_drv;
>   };
>   
>   struct amdgpu_userq_funcs {

