Return-Path: <SRS0=1IUY=JD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12CAC433ED
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 10:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F45B61154
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 10:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F45B61154
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09AAD6E3AA;
	Tue,  6 Apr 2021 10:54:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95B636E3AA
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Apr 2021 10:54:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZ04FALv6py8JnorEF10mNJYtgnyNLw6eI4s6wNbsUE51+PDGBrPg0XQOTxlKssxou/J7DHo7EBmRHf64OgyO2iNeqVbaUltbGO3QGepRU1vg84JFZyPttcLZOtKpbeIJ/ODWsYBN7JkIgnaedAxnShWAif2PZyavZvGZh/Z96wriK4ttbJUIIJuZqFUAL2+c1KQhCmOXqw5+wy/JaHq0TyyahT8PL/Lc3qD/hxlg8450VmWC90wozS6Baqxh0YRqAvY2VFz9TewwxyRY3R1cCEdxWz6JjkdPILeZ/OkahNCn4o7XTOgEQBddNu5G84dipd0bBBcsv0nb1/hLYC+hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJjZ9gGjxYYkomxMB1EZTz7CIKNyYhVyahhsyv8RlDE=;
 b=MmA1Y0k13igEeOdq7zfj7AER5rZ7BRAwlawax6JVve5PsBgMBZy2c91ciLM1Vi/k2vGw28DMnOmBtVbbOkdYyLcLO82yaDkN2+jDper+Rj9tMQWxbF5PBYc91FmLYH2XyYVPlAtMOkrOiRdorm4g5eFfdjC3FzIZ7aPPbkiC90zxsyQtpWpndLwe60YFGXWi/CQQWmgK1OuqrVmPTXGN+zpQ3Cs6wizSyAZJ2zp0BsdUKYQE10/dADt5e0C7BS/aOcPYy4CYqzxuiLMckuVxyOayvW6jV5uC+9KeoyD7b2UcXgw35ofDrNS/1TPiGin3L3mRZC02DTsHRoyDzn84kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJjZ9gGjxYYkomxMB1EZTz7CIKNyYhVyahhsyv8RlDE=;
 b=hLZXj+q8I0MckqLyiAz2F+TRo99GoffxB8nbyCNm0VKnuzkPhT7yswmafnU2ghbYUlcP82z2rcqWcjkMRQEnpmOO5CRCoRhxdTfMAc+EDNmloK4C/VfWRtu34GxLj/5da7iDvYwfmHvcihIjd5uuLroVXIIEu6EF6gGrpaTItyY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1589.namprd12.prod.outlook.com (2603:10b6:910:e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 10:54:09 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 10:54:09 +0000
Subject: Re: [PATCH] drm/amdgpu: Add show_fdinfo() interface
To: Roy Sun <Roy.Sun@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210406094915.22984-1-Roy.Sun@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <cfab1417-2a93-dc89-f9d3-1dabdc0a0a79@amd.com>
Date: Tue, 6 Apr 2021 12:54:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210406094915.22984-1-Roy.Sun@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN0PR04CA0145.namprd04.prod.outlook.com
 (2603:10b6:408:ed::30) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.7.102] (165.204.84.11) by
 BN0PR04CA0145.namprd04.prod.outlook.com (2603:10b6:408:ed::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.16 via Frontend Transport; Tue, 6 Apr 2021 10:54:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ceb49c0-dc4e-408e-c7c3-08d8f8ea4e02
X-MS-TrafficTypeDiagnostic: CY4PR12MB1589:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1589904F99E46897E901CFAA8B769@CY4PR12MB1589.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ICSM3KLorvBG8m0p3QmXk6nKdHhYyO7KBkbbMPsEIhx4FCFtE8d4LbBvKaO3aZQp/yTKRInpbl0m544/xGdtTcMc0P7di6RNTeCv1ihm19CcG2NuORLmJadkBdZcAd3DY8AJiwOk28Solj+vtw64wdv+D5b3y4TK1ICadbSQwyDzqRc9SvM3SndDWSy+1fNpKfduSiX3ppBryYpH3VAkKg0XmUBsMSJ35kDGoyLYKc3sb57ruBrqWabJcLALnYm9iwh6y82doJX5S6RKsgyLELqnFI4IfWHRse7naEX3QEQC0yvysI4LJQwxl57LwuAht4HF/LDMTUMEjc8IkHvPCK8szADVFUJZE3lyRKmbG5PbVQq+q+icotQlWttU/krkpVnAbfaeUucMupuKCMNbb3w2/J3u8MHOzN/UHyExa2JUb4iNrE5sDapuXRuKHkmmwFIQqDUOROQvrQ1WcuGb4vNIAkc9S5JUBxHnZ7E4X6a9OpkI5pBTwAXO41FenJxhEKJdjK4Q2ftNZvJBgA62g2jlNQzmr/efEv09EFiKZQI16CE97CeppHVlreTCQ3qUVnH6wUxDYX40GkijJfMzyuSLvniDIRrpHKYcTbGXBXOqYW/FzCradf3zErPfZZOUImLMGchDmN60t91bEeYQAju+RGTsBCbodQ01OjU+f9rfIdaI/NAFDnA/0xugTQhouDOGxmQvL38cWYTM9hGB0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(39840400004)(396003)(346002)(38100700001)(956004)(52116002)(4326008)(316002)(8936002)(16576012)(83380400001)(16526019)(31686004)(66946007)(6666004)(26005)(5660300002)(186003)(8676002)(2906002)(66476007)(2616005)(478600001)(6486002)(53546011)(31696002)(36756003)(30864003)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VUF6cGU0RXBScUwxcUdyQm9jaExWVjhaUFRReTZ5ci9aeTlvSkdSWkxCaTY3?=
 =?utf-8?B?WGk4SGdjSkhLTjVUU21Xd08xR1JFUC9iOHJFaCtSTWpVazZremVDSlFGZjc1?=
 =?utf-8?B?c1MyMlh1WkphZHJWMWk5bGRsRlEvdXhCZjJKSUN6RTFMdFA4WGJJS3Roc2xl?=
 =?utf-8?B?N1NHeUJ2emMrVmVTbkZ2dm9ranpXQW5vRXNzWFBrMGdXRWVFQnRjYjQ1S1h6?=
 =?utf-8?B?MDVvQ1BPNnltamNPRzRxaytjSFdaMDJHVXM0SlpaRDEyUUh6cmRHWW9wOFl5?=
 =?utf-8?B?N0Rac21vdEVXamt1d2ZTMWhwS25WYlF1VENmNXk5aHh3K1ZOVklpbjIwUUd0?=
 =?utf-8?B?dnFtZ0svOHdBelJ3SHoyOE02ZkRQamxQU3RHanB2VUlxN05iUkxnVzB5dG94?=
 =?utf-8?B?R09XYzFQbTRxNWJSSHRDYnlXbWx1ak5MTHNRcHB2QktueWp3QkUyS2ZlNGFw?=
 =?utf-8?B?V3VhUDNtOEtNR2xBRWpMTTJzNUMxNzlqSk51aGptcWpKSnFHWVJMYWJQcXVI?=
 =?utf-8?B?NXpPSkk0Ly91TTFWTVhQL2VuWDd6SzcrSEU5aklVcEVCeEsraDRzWm9qcTVW?=
 =?utf-8?B?angxRlhzSFV0R1dhcWVpU2JQOWw0ZEFRZjdUdlkxSWJnNVN4Yi81TTdUendY?=
 =?utf-8?B?WTNtZ2tTenhSV01JWVA3R3RnMlNEcmE1L0JiNVhjbnlpVGFmVk4rbGNQWjY5?=
 =?utf-8?B?aFIxczRrWm9GVTZoTmNCajZYQUwyNFVlb1p0b3RUZHZmMlo2SDBxeVB1TnVB?=
 =?utf-8?B?L2hYcFczNEk2Y3lEV0s2MlhQbmFPWDRQSCticElFSjJsSkxqd0Y4OWp6WEF1?=
 =?utf-8?B?SXkxU3g2M2ZUSGpDU2ZwUzJpS0U1bFZrSEl0WnJSeHdzUnNob251R01ySFhH?=
 =?utf-8?B?SHNodEJhMUh2ZktXN2tiVXlCQ3dRZDNPcGt4RW9wNWhScGQ1NVo4YXhuSVQ4?=
 =?utf-8?B?WDI4dTJ0QjFNK2ZLNzR3TGExSmpIZHplVHVNdGdDOE45TUU2K2ZPTDhIUFFU?=
 =?utf-8?B?Zks3T2ovZFdMZ01tYVl4d295aXh5ektodWIySmVLTWxHMTNqUWVZU3h6OGw1?=
 =?utf-8?B?TWRqL0NhQTA3M3BocXJ6R0krK3ZVajBnaEdZMkRCM011eXVhd3g0WG9uSlJE?=
 =?utf-8?B?SVlabFVacTVqTk5LQ3l4eU5TSFhFRmt2cXJaV1ZwV0Z5OWZEU2NtdG5hMDVx?=
 =?utf-8?B?cHcwalQ0NzYzUHFVUWdEZkoybnVZYkZaNi9POHpHRnZnbDQvZjREdGJFMlJU?=
 =?utf-8?B?U1A4ejBYU2tQMkt3ZkhVemgwSDRDYzVLZUFtdVF6RkdEWFNXL1d0NTBGdDIz?=
 =?utf-8?B?d09TY2NoSEZKZnpZRUtLTDZMTS9pQlhYYkE0WXdWYk42RFRaQnd4SzJiYXd0?=
 =?utf-8?B?R0FoNmtvL0lMTEM5U0FrejdOVXJDVytEYjlzQ0lvdnluU09xM3J6cDlEMkFr?=
 =?utf-8?B?OWFRMnFUOGEzeVB2elZDWUduRXVZeXlFcVFFMEpJMmJLRnlKR3hwQUhRaVlv?=
 =?utf-8?B?L0RSSmo1V1JjYzVzUzBITVR3bm9wOEg4eFlLTzAwYTFrN1VaNnM2ZmljUkFs?=
 =?utf-8?B?ZG9IYjR1UmZlQXdzMkVobkhObGRONW91RU1rQ1ZyVzZLOTd2eEZGK3c1WUxw?=
 =?utf-8?B?cVhFOU1HMUJoeWdFaDMySTVyTTJPSElYNkt6N1AwaHRybWd6RUZ5dTFKeE5S?=
 =?utf-8?B?UUlMdGQySzR2YVhhVmJ4dkFzckc5ODNRN1AwRys4aUlqbGl3YStLbFJSdVFr?=
 =?utf-8?Q?VBCjfK2Yr+RdiemtaJ3GJ1gFhayS7xAQOgRvVOr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ceb49c0-dc4e-408e-c7c3-08d8f8ea4e02
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 10:54:09.4293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9T5goYCRU8YrMOLg9ywZLkAHGoWkq/OjZ0e0hZOMFxRFDEiUPhmaztQPPzflBvFz/4PZ4+L4UJWgKMIyseFTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1589
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
Cc: Alexander.Deucher@amd.com, David M Nieto <David.Nieto@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 4/6/21 11:49 AM, Roy Sun wrote:
> Tracking devices, process info and fence info using
> /proc/pid/fdinfo
>
> Signed-off-by: David M Nieto <David.Nieto@amd.com>
> Signed-off-by: Roy Sun <Roy.Sun@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   3 +
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  15 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c    | 282 ++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h    |  58 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   3 +
>   drivers/gpu/drm/scheduler/sched_main.c        |  11 +-
>   8 files changed, 371 insertions(+), 8 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index ee85e8aba636..f9de1acc65dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -55,7 +55,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>   	amdgpu_vf_error.o amdgpu_sched.o amdgpu_debugfs.o amdgpu_ids.o \
>   	amdgpu_gmc.o amdgpu_mmhub.o amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.o amdgpu_vm_cpu.o \
>   	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
> -	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
> +	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o amdgpu_fdinfo.o\
>   	amdgpu_fw_attestation.o amdgpu_securedisplay.o
>   


Use amdgpu-$(CONFIG_PROC_FS) instead so that you can ignore some 
CONFIG_PROC_FS checks.


>   amdgpu-$(CONFIG_PERF_EVENTS) += amdgpu_pmu.o
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 616c85a01299..35843c8d133d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -107,6 +107,7 @@
>   #include "amdgpu_gfxhub.h"
>   #include "amdgpu_df.h"
>   #include "amdgpu_smuio.h"
> +#include "amdgpu_fdinfo.h"
>   
>   #define MAX_GPU_INSTANCE		16
>   
> @@ -477,6 +478,8 @@ struct amdgpu_fpriv {
>   	struct mutex		bo_list_lock;
>   	struct idr		bo_list_handles;
>   	struct amdgpu_ctx_mgr	ctx_mgr;
> +	struct drm_file		*file;
> +	struct amdgpu_proc	*proc;


You should be able to avoid adding these extra members. See below:


>   };
>   

>   int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index e93850f2f3b1..702fd9054883 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1042,13 +1042,15 @@ int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, u32 pasid,
>   					  struct dma_fence **ef)
>   {
>   	struct amdgpu_device *adev = get_amdgpu_device(kgd);
> +	struct amdgpu_fpriv *fpriv;
>   	struct amdgpu_vm *new_vm;
>   	int ret;
>   
> -	new_vm = kzalloc(sizeof(*new_vm), GFP_KERNEL);
> -	if (!new_vm)
> +	fpriv = kzalloc(sizeof(*fpriv), GFP_KERNEL);
> +	if (!fpriv)
>   		return -ENOMEM;
>   
> +	new_vm = &fpriv->vm;
>   	/* Initialize AMDGPU part of the VM */
>   	ret = amdgpu_vm_init(adev, new_vm, AMDGPU_VM_CONTEXT_COMPUTE, pasid);
>   	if (ret) {
> @@ -1063,12 +1065,14 @@ int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, u32 pasid,
>   
>   	*vm = (void *) new_vm;
>   
> +	amdgpu_fdinfo_init(adev, fpriv, pasid);
> +
>   	return 0;
>   
>   init_kfd_vm_fail:
>   	amdgpu_vm_fini(adev, new_vm);
>   amdgpu_vm_init_fail:
> -	kfree(new_vm);
> +	kfree(fpriv);
>   	return ret;
>   }
>   
> @@ -1142,6 +1146,8 @@ void amdgpu_amdkfd_gpuvm_destroy_process_vm(struct kgd_dev *kgd, void *vm)
>   {
>   	struct amdgpu_device *adev = get_amdgpu_device(kgd);
>   	struct amdgpu_vm *avm = (struct amdgpu_vm *)vm;
> +	struct amdgpu_fpriv *fpriv =
> +		container_of(avm, struct amdgpu_fpriv, vm);
>   
>   	if (WARN_ON(!kgd || !vm))
>   		return;
> @@ -1149,8 +1155,9 @@ void amdgpu_amdkfd_gpuvm_destroy_process_vm(struct kgd_dev *kgd, void *vm)
>   	pr_debug("Destroying process vm %p\n", vm);
>   
>   	/* Release the VM context */
> +	amdgpu_fdinfo_fini(adev, fpriv);
>   	amdgpu_vm_fini(adev, avm);
> -	kfree(vm);
> +	kfree(fpriv);
>   }
>   
>   void amdgpu_amdkfd_gpuvm_release_process_vm(struct kgd_dev *kgd, void *vm)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4bcc03c4c6c5..07aed377dec8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -42,7 +42,7 @@
>   #include "amdgpu_irq.h"
>   #include "amdgpu_dma_buf.h"
>   #include "amdgpu_sched.h"
> -
> +#include "amdgpu_fdinfo.h"
>   #include "amdgpu_amdkfd.h"
>   
>   #include "amdgpu_ras.h"
> @@ -1691,6 +1691,9 @@ static const struct file_operations amdgpu_driver_kms_fops = {
>   #ifdef CONFIG_COMPAT
>   	.compat_ioctl = amdgpu_kms_compat_ioctl,
>   #endif
> +#ifdef CONFIG_PROC_FS
> +	.show_fdinfo = amdgpu_show_fdinfo
> +#endif
>   };
>   
>   int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> new file mode 100644
> index 000000000000..5208fab6e35d
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> @@ -0,0 +1,282 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
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
> +#include <linux/debugfs.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/uaccess.h>
> +#include <linux/reboot.h>
> +#include <linux/syscalls.h>
> +
> +#include <drm/amdgpu_drm.h>
> +#include <drm/drm_debugfs.h>
> +
> +#include "amdgpu.h"
> +#include "amdgpu_fdinfo.h"
> +
> +
> +static const char *amdgpu_ip_name[AMDGPU_HW_IP_NUM] = {
> +	[AMDGPU_HW_IP_GFX]	=	"gfx",
> +	[AMDGPU_HW_IP_COMPUTE]	=	"compute",
> +	[AMDGPU_HW_IP_DMA]	=	"dma",
> +	[AMDGPU_HW_IP_UVD]	=	"dec",
> +	[AMDGPU_HW_IP_VCE]	=	"enc",
> +	[AMDGPU_HW_IP_UVD_ENC]	=	"enc_1",
> +	[AMDGPU_HW_IP_VCN_DEC]	=	"dec",
> +	[AMDGPU_HW_IP_VCN_ENC]	=	"enc",
> +	[AMDGPU_HW_IP_VCN_JPEG]	=	"jpeg",
> +};
> +
> +struct amdgpu_proc {
> +	struct amdgpu_device *adev;
> +	struct amdgpu_fpriv *priv;
> +	int pasid;
> +};
> +


Is this, struct amdgpu_proc really needed? struct amdgpu_fpriv can 
provide you the pasid(fpriv->vm->pasid) and pretty sure

there is some other way to get adev from fpriv too.


> +int amdgpu_fdinfo_init(struct amdgpu_device *adev,
> +	struct amdgpu_fpriv *fpriv, int pasid)
> +{
> +	struct amdgpu_proc *proc;
> +
> +	proc = kzalloc(sizeof(*proc), GFP_KERNEL);
> +	if (!proc)
> +		return -ENOMEM;
> +	proc->pasid = pasid;
> +	proc->adev = adev;
> +	proc->priv = fpriv;
> +	fpriv->proc = proc;
> +
> +	return 0;
> +}
> +
> +int amdgpu_fdinfo_fini(struct amdgpu_device *adev,
> +		struct amdgpu_fpriv *fpriv)
> +{
> +	struct amdgpu_proc *proc = fpriv->proc;
> +
> +	if (proc)
> +		kfree(proc);
> +
> +	fpriv->proc = NULL;
> +	return 0;
> +}
> +
> +uint64_t amdgpu_get_proc_mem(struct amdgpu_fpriv *fpriv)


This can receive drm_file which gives you amdgpu_priv

so you can avoid fpriv->file.


> +{
> +	int id;
> +	struct drm_gem_object *gobj;
> +	uint64_t total = 0;
> +
> +	spin_lock(&fpriv->file->table_lock);
> +	idr_for_each_entry(&fpriv->file->object_idr, gobj, id) {
> +		struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
> +		unsigned int domain = amdgpu_mem_type_to_domain(
> +			bo->tbo.mem.mem_type);
> +
> +		if (domain == AMDGPU_GEM_DOMAIN_VRAM)
> +			total += amdgpu_bo_size(bo);
> +	}
> +	spin_unlock(&fpriv->file->table_lock);
> +
> +	if (fpriv->vm.process_info) {
> +		struct kgd_mem *mem;
> +
> +		mutex_lock(&fpriv->vm.process_info->lock);
> +		list_for_each_entry(mem, &fpriv->vm.process_info->kfd_bo_list,
> +			validate_list.head) {
> +			struct amdgpu_bo *bo = mem->bo;
> +			unsigned int domain = amdgpu_mem_type_to_domain(
> +				bo->tbo.mem.mem_type);
> +
> +			if (domain == AMDGPU_GEM_DOMAIN_VRAM)
> +				total += amdgpu_bo_size(bo);
> +			}
> +
> +		list_for_each_entry(mem, &fpriv->vm.process_info->userptr_valid_list,
> +			validate_list.head) {
> +			struct amdgpu_bo *bo = mem->bo;
> +			unsigned int domain = amdgpu_mem_type_to_domain(
> +				bo->tbo.mem.mem_type);
> +
> +			if (domain == AMDGPU_GEM_DOMAIN_VRAM)
> +				total += amdgpu_bo_size(bo);
> +		}
> +
> +		mutex_unlock(&fpriv->vm.process_info->lock);
> +	}
> +
> +	return total;
> +}
> +
> +uint64_t amdgpu_get_fence_usage(struct amdgpu_fpriv *fpriv, uint32_t hwip,
> +		uint32_t idx, uint64_t *elapsed)
> +{
> +	struct amdgpu_ctx_entity *centity;
> +	struct idr *idp;
> +	struct amdgpu_ctx *ctx;
> +	uint32_t id, i;
> +	uint64_t now, t1, t2;
> +	uint64_t total = 0, min = 0;
> +
> +
> +	if (idx >= AMDGPU_MAX_ENTITY_NUM)
> +		return 0;
> +
> +	idp = &fpriv->ctx_mgr.ctx_handles;
> +
> +	mutex_lock(&fpriv->ctx_mgr.lock);
> +	idr_for_each_entry(idp, ctx, id) {
> +		if (!ctx->entities[hwip][idx])
> +			continue;
> +
> +		centity = ctx->entities[hwip][idx];
> +
> +		for (i = 0; i < amdgpu_sched_jobs; i++) {
> +			struct dma_fence *fence;
> +			struct drm_sched_fence *s_fence;
> +
> +			spin_lock(&ctx->ring_lock);
> +			fence = dma_fence_get(centity->fences[i]);
> +			spin_unlock(&ctx->ring_lock);
> +			if (!fence)
> +				continue;
> +			s_fence = to_drm_sched_fence(fence);
> +			if (!dma_fence_is_signaled(&s_fence->scheduled))
> +				continue;
> +			now = ktime_to_ns(ktime_get());
> +			t1 = ktime_to_ns(s_fence->scheduled.timestamp);
> +			t2 = !dma_fence_is_signaled(&s_fence->finished) ?
> +				0 : ktime_to_ns(s_fence->finished.timestamp);
> +			dma_fence_put(fence);
> +
> +			t1 = now - t1;
> +			t2 = (t2 == 0) ? 0 : now - t2;
> +			total += t1 - t2;
> +			if (t1 > min)
> +				min = t1;
> +		}
> +
> +	}
> +
> +	mutex_unlock(&fpriv->ctx_mgr.lock);
> +
> +	if (elapsed)
> +		*elapsed = min;
> +
> +	return total;
> +}
> +
> +uint32_t amdgpu_get_ip_count(struct amdgpu_device *adev, int id)
> +{
> +	enum amd_ip_block_type type;
> +	uint32_t count = 0;
> +	int i;
> +
> +	switch (id) {
> +	case AMDGPU_HW_IP_GFX:
> +		type = AMD_IP_BLOCK_TYPE_GFX;
> +		break;
> +	case AMDGPU_HW_IP_COMPUTE:
> +		type = AMD_IP_BLOCK_TYPE_GFX;
> +		break;
> +	case AMDGPU_HW_IP_DMA:
> +		type = AMD_IP_BLOCK_TYPE_SDMA;
> +		break;
> +	case AMDGPU_HW_IP_UVD:
> +		type = AMD_IP_BLOCK_TYPE_UVD;
> +		break;
> +	case AMDGPU_HW_IP_VCE:
> +		type = AMD_IP_BLOCK_TYPE_VCE;
> +		break;
> +	case AMDGPU_HW_IP_UVD_ENC:
> +		type = AMD_IP_BLOCK_TYPE_UVD;
> +		break;
> +	case AMDGPU_HW_IP_VCN_DEC:
> +	case AMDGPU_HW_IP_VCN_ENC:
> +		type = AMD_IP_BLOCK_TYPE_VCN;
> +		break;
> +	case AMDGPU_HW_IP_VCN_JPEG:
> +		type = (amdgpu_device_ip_get_ip_block(adev,
> +			AMD_IP_BLOCK_TYPE_JPEG)) ?
> +			AMD_IP_BLOCK_TYPE_JPEG : AMD_IP_BLOCK_TYPE_VCN;
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	for (i = 0; i < adev->num_ip_blocks; i++)
> +		if (adev->ip_blocks[i].version->type == type &&
> +		    adev->ip_blocks[i].status.valid &&
> +		    count < AMDGPU_HW_IP_INSTANCE_MAX_COUNT)
> +			count++;
> +	return count;
> +
> +}
> +
> +#ifdef CONFIG_PROC_FS
> +void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
> +{
> +	struct amdgpu_fpriv *fpriv;
> +	struct amdgpu_device *adev;
> +	uint32_t bus, dev, fn, i;
> +
> +	if (amdgpu_file_to_fpriv(f, &fpriv))
> +		return;
> +
> +	adev = fpriv->proc->adev;


You can get adev using:


struct drm_file *file_priv = filp->private_data;

struct amdgpu_device *adev = drm_to_adev(file_priv->minor->dev);


Regards,

Nirmoy


> +	bus = adev->pdev->bus->number;
> +	dev = PCI_SLOT(adev->pdev->devfn);
> +	fn = PCI_FUNC(adev->pdev->devfn);
> +	seq_printf(m, "amdgpu_%02x:%02x.%d:pasid:\t%u\n", bus, dev, fn,
> +			fpriv->proc->pasid);
> +
> +	seq_printf(m, "amdgpu_%02x:%02x.%d:mem:\t%llu kB\n", bus, dev, fn,
> +			amdgpu_get_proc_mem(fpriv)/1024UL);
> +
> +	for (i = 0; i < AMDGPU_HW_IP_NUM; i++) {
> +		uint32_t enabled = amdgpu_get_ip_count(adev, i);
> +		uint32_t count = amdgpu_ctx_num_entities[i];
> +		int idx = 0;
> +		uint64_t total = 0, min = 0;
> +		uint32_t perc, frac;
> +
> +		if (enabled) {
> +			for (idx = 0; idx < count; idx++) {
> +				total = amdgpu_get_fence_usage(fpriv,
> +					i, idx, &min);
> +
> +				if ((total == 0) || (min == 0))
> +					continue;
> +
> +				perc = div64_u64(10000 * total, min);
> +				frac = perc % 100;
> +
> +				seq_printf(m, "amdgpu_%02x:%02x.%d:%s%d:\t%d.%d%%\n",
> +						bus, dev, fn,
> +						amdgpu_ip_name[i],
> +						idx, perc/100, frac);
> +			}
> +		}
> +	}
> +}
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
> new file mode 100644
> index 000000000000..1f776b3a5f45
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
> @@ -0,0 +1,58 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
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
> + * Authors: David Nieto
> + */
> +#ifndef __AMDGPU_SMI_H__
> +#define __AMDGPU_SMI_H__
> +
> +#include <linux/idr.h>
> +#include <linux/kfifo.h>
> +#include <linux/rbtree.h>
> +#include <drm/gpu_scheduler.h>
> +#include <drm/drm_file.h>
> +#include <drm/ttm/ttm_bo_driver.h>
> +#include <linux/sched/mm.h>
> +
> +#include "amdgpu_sync.h"
> +#include "amdgpu_ring.h"
> +#include "amdgpu_ids.h"
> +
> +struct amdgpu_proc;
> +struct amdgpu_ctx;
> +uint32_t amdgpu_get_ip_count(struct amdgpu_device *adev, int id);
> +
> +uint64_t amdgpu_get_fence_usage(struct amdgpu_fpriv *fpriv, uint32_t hwip,
> +		uint32_t idx, uint64_t *elapsed);
> +
> +uint64_t amdgpu_get_proc_mem(struct amdgpu_fpriv *fpriv);
> +
> +int amdgpu_fdinfo_init(struct amdgpu_device *adev,
> +		struct amdgpu_fpriv *fpriv, int pasid);
> +
> +int amdgpu_fdinfo_fini(struct amdgpu_device *adev,
> +		struct amdgpu_fpriv *fpriv);
> +
> +#ifdef CONFIG_PROC_FS
> +void amdgpu_show_fdinfo(struct seq_file *m, struct file *f);
> +#endif
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 39ee88d29cca..c2407c08b2ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -41,6 +41,7 @@
>   #include "amdgpu_gem.h"
>   #include "amdgpu_display.h"
>   #include "amdgpu_ras.h"
> +#include "amdgpu_fdinfo.h"
>   
>   void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
>   {
> @@ -1139,6 +1140,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>   	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr);
>   
>   	file_priv->driver_priv = fpriv;
> +	fpriv->file = file_priv;
> +	amdgpu_fdinfo_init(adev, fpriv, pasid);
>   	goto out_suspend;
>   
>   error_vm:
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 92d8de24d0a1..4e5d8d4af010 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -515,7 +515,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched)
>   EXPORT_SYMBOL(drm_sched_resubmit_jobs);
>   
>   /**
> - * drm_sched_resubmit_jobs_ext - helper to relunch certain number of jobs from mirror ring list
> + * drm_sched_resubmit_jobs_ext - helper to relunch certain number of jobs from pending list
>    *
>    * @sched: scheduler instance
>    * @max: job numbers to relaunch
> @@ -671,7 +671,7 @@ drm_sched_select_entity(struct drm_gpu_scheduler *sched)
>   static struct drm_sched_job *
>   drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
>   {
> -	struct drm_sched_job *job;
> +	struct drm_sched_job *job, *next;
>   
>   	/*
>   	 * Don't destroy jobs while the timeout worker is running  OR thread
> @@ -690,6 +690,13 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
>   	if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
>   		/* remove job from pending_list */
>   		list_del_init(&job->list);
> +		/* account for the next fence in the queue */
> +		next = list_first_entry_or_null(&sched->pending_list,
> +				struct drm_sched_job, list);
> +		if (next) {
> +			next->s_fence->scheduled.timestamp =
> +				job->s_fence->finished.timestamp;
> +		}
>   	} else {
>   		job = NULL;
>   		/* queue timeout for next job */
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
