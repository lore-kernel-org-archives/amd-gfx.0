Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7F5C432BE
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 18:57:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 611F6613BD
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 18:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 611F6613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4F2A89B45;
	Mon, 23 Aug 2021 18:57:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 000E689B45
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 18:57:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcmPNoS3RctdmfFz7o+1+xYdg/eBIUmlEkL/tRhkeAb7KK/oi79rNqbaTW5X2273rn3V6VKyam4vg3sUVbUnJ0bzA/OaDTSVYM3edHsoH+Q6au2U7cSqM1iiPHBpNPNm/RmUZZRRSMr4FsXrgUnsUsupu699RFZuXxLYLTjAkq36zjOtM1apI1wv/NQI80PXc8Zc1NHbKB3O5wqZGuOchlbjCVj1FCLdn1eikuEaGomz7lB5GYskOzwb98SvF1D7nSP7FIFf+IZBPrJJEFFlOaogodIECaH5fJv3muXfqozB6+xF9ceenOBgs1AcNI+5Y5LXf+ZYbTz5rKbnsgh+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vElZRXhklVXDKWZ7C/SzEnsf6Fyt7jkN0mkGTDeg0TI=;
 b=SRBiL6tJjWIbaes+52XRDAG/+4lK+srb/NLTDYGO7dPFbJk/rilmy6O/l/ggx3KJh3fHEkfAxl0NbK2DP4+Gu3fykipDlT8cSG2CiypPf9TIzTmajokhIKLK/gjCAla6zlFXQpXGoUrYf5v/qXHweujN2hNcg+E5/VfkFRjZthyiY4FGW7A83O0lU2TC1bZn6JMGPJTxan//PHHiiN9d/6ypliLuzJmQvRGICqBDO1kkTE5ds+xqtincS2wy4Io5FAAGfgJsfOj203tg6M4OTxa8GuuYf6p7mf+wS5jJ1u4oDYfpKFAn1HcrlarlFz6Amvg4bCklENm3NcgZlCXZGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vElZRXhklVXDKWZ7C/SzEnsf6Fyt7jkN0mkGTDeg0TI=;
 b=fA3WuzJS6KGpxmFN+f1yR4hETcBoFIpCiQz14VyXIinp7ZlRMsv7wH4tugznwaufUImDxWR2hiuv1sq7e3qhZLAJ3hPpDYHKSSTVFMTg7UNsugs9jhdzi3gfEER3pyK/zhY930eDviDheNkAgPrwvxRGv3LZaHIXrNCJr5N1Oe0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5036.namprd12.prod.outlook.com (2603:10b6:408:135::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Mon, 23 Aug
 2021 18:57:41 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 18:57:41 +0000
Subject: Re: [PATCH 03/18] drm/amdkfd: CRIU Introduce Checkpoint-Restore APIs
To: David Yat Sin <david.yatsin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: rajneesh.bhardwaj@amd.com
References: <20210819133713.4168-1-david.yatsin@amd.com>
 <20210819133713.4168-4-david.yatsin@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <aeaaa4bb-8300-e45d-3da3-2888a90df52e@amd.com>
Date: Mon, 23 Aug 2021 14:57:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210819133713.4168-4-david.yatsin@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::29) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.47.3) by
 YT1PR01CA0060.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 18:57:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ec59914-7d4c-4f5b-a4bc-08d96667e25d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5036:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB50363BADED8C8181CBA6898C92C49@BN9PR12MB5036.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WcFrfikIAgh+wvrVH6HNdUaB2ylJ6CLdf5ToPMuUdzIsNJxB9M21H6KraJNMuXfHkIKse9TMzdwk7jKi8F+r3O7Wl70TC7JxlqX7Wn2ekcDIaQc1cBnDtQPbhSTIbj99Eujqhagq8eQQiLNIt98TGX5CLoGb9VYO+Y/ITyQHLw4qxsDFtKrykg4c96IRY8Fkp89aw5Uy2nqmhbGtjoPWtpRJ6AfQt1opuPs9CNhLaX/zrBxyZ+VrZIJcowIxFN1a17XfW/QjUVNWjtimj43TB0tzxbP8wQYurx+U8LIUcsNV1E7YIwibTKLu7XBPVsjs+X+YixV4jrYOPy6RACb/ll2qWycIKuVeG3rVkKI5n7UXevQGmxI5M1G/d8FAwVaXQN+akhjiHnulhYmEUV6dNMtm5owwzTxZtO+0sjeBFFwzjG1IFrGnSEJMk1oWuQhymPFHfVOlhQ+2y4Exsy2hXJqA93Mfn/nONLjlexMFQi5HY6ZFjOE9s6HxYN4zkwnWW16rwnfGW8d68queKzOmMSlGw9eccnuwBSm0RNSDgLBTmc1x4bgalYRQ8XBLDah3TNhOS7OmdAfptlyY4nS+T7kLZgnE2Ir+E6n8+1jd6HJyMymQ5qh46QiCiEz3RBPLAy5KPCFd4dKt1kXO3gw8nYkabgK46Q7IEceCQu1LZtpyuDiq/AkOVaugPK4FFsdRwbOt2EOIJzPIAoQ63b/EdOnaNlyLW63jrgDAO2uB+SI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(31686004)(8676002)(66476007)(6666004)(66946007)(66556008)(38100700002)(26005)(186003)(6486002)(8936002)(5660300002)(2616005)(956004)(4326008)(30864003)(478600001)(86362001)(31696002)(83380400001)(44832011)(316002)(16576012)(2906002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW8yNCsxQ0tYSmNKRzRTYmJaR2FOdHJsd3g2dlVhTjNwdmhrQ1lOSXlHR0lZ?=
 =?utf-8?B?Q2R5M2FTcGU3Y1dxNzF6ZHFsMm1EY3ArWWNoa0ZOQ2R0bzFZZnhGNTN6TCtx?=
 =?utf-8?B?czMxRTdkcTdUNnpXcHg0SG1IY1dMdCtxaG0vcDk1ZE5LUmtISmgyOGpwQng0?=
 =?utf-8?B?WWdWVldyaGU0WmFWRFBKa3dyeXdVell2cUdqOWRRVkJjM08vQ0MzczhlWE5u?=
 =?utf-8?B?ck5ncmZGbW5lK01XM1czTFhMVjRIRkhEWGZWY1VqK3Z6WVZlcG1QOGNCMGRJ?=
 =?utf-8?B?QUJXNFZqWU8rZ0VqM21HZndoa1RjbEFmYURrZjRoeUhhQ04yRWNhYnFmVDBT?=
 =?utf-8?B?ZEZTaWJxSVdkUDJzMlBobVBNU1lpckZtNnJZNWplN1kxN2FnbGhtT00rSWYw?=
 =?utf-8?B?bm1UdE5xV3FLTWZzT3BkenMyWUtialdYNlNsUSt4cFBnT09tR0pHVmxBS0ox?=
 =?utf-8?B?aFp1bE9Jb25YMjZrOVdoWHUzWEp1WTFyNEpjTFp6UUdlSUlzbk42REY2eXlp?=
 =?utf-8?B?N2tUQzl1cVFJWC93Wnh4aVBudFhicVFWL0cxR2NNQmtaSXkwS29ET1F0RFdW?=
 =?utf-8?B?UUZvTlBsQXZLZ1lEeCtMU1ZSQnVzSUZnMEVuUkdDbEJ4VlQ4S0ZFUi91M1V4?=
 =?utf-8?B?Qmx3OGlGbXNSdHRndElCSWxFNG1BdEFrWXNpNEFEWlByd0lsOUdCcCtIcGFi?=
 =?utf-8?B?YjJkUldxOWVkd1NCZnp3ZWxiQUVyQ3VFQjJsSnJZVnRVYzR2VEFKMGVvTGtx?=
 =?utf-8?B?R2ZsdXlWT1REaXpPZmdvMlNndXJnUnlWY3o0TlJPc2JBWHRVQ2x4R3NuQ1BG?=
 =?utf-8?B?UEIxbXpDK2U5Y2w1UFlOcnRUR2dpNlVTL0JLalljdnNnQm4vT2g4VVFuR2Ix?=
 =?utf-8?B?MXlIeFJFYVllVTFHM1E1VDYyQktUKzBMSnNQRHc5YWNwUS90QXBwUDN0OWpH?=
 =?utf-8?B?Ykh3Qm82RzFXLzRXV09JR1BQU002dmx0c2R0S3VwQW9TYVZ1VDNBU0FHd04x?=
 =?utf-8?B?R1g0Q1FVK2JJd3hiMkZNSVA4Z3Q0bDlmVEdvQUxSTys5YXpyVGhqQmFnZEo2?=
 =?utf-8?B?U2hMKzNYUGxyNUFkZDlUYXFoMzdLWFovYUxZNElqaGFIK0tXVVRHM1A0Vito?=
 =?utf-8?B?QThSSGVrbFhnbzdXRzIzN0dYRVZNc1ZLb0paOTlNdlZ0c2V6VmJhaWVNU1RP?=
 =?utf-8?B?Z3dCbWZOemYwLzdseEExZExjYlltWFVwNU9qS3ZMcmNwZEhiWUwzMllqTGg5?=
 =?utf-8?B?RVJlYnY0SUY0VWRQbFk4UXN3MDAyREIzd0JDZXFOR0dXSUFTa2RvNXBNak5K?=
 =?utf-8?B?YVBYWVFHMzNoQWpOVkZsb3UvZDZRQk1UV2FFTlJxb3hyRjhnRzRaSFRqbEZX?=
 =?utf-8?B?VHBDMkVhTjBkRU9VZWU1OHZ3bVF2ZXViU0d0Tk1yOWFueC9aM1hjcVJ1anl1?=
 =?utf-8?B?R0lHNTFaSXl1VDhtTk5IMWhnNis4V1FDN05kM1JGajM0bUhQOUpLR0V1RzVE?=
 =?utf-8?B?WnpOdU9TdTE3aVF4amhINUMySlZBdTRwZjB6enNNRHNsMWtjMHVqbUVqeDFD?=
 =?utf-8?B?L08zenFKLzcwU25ReG8xcWp3b0xOSkV1WGN1WURDams5WTB2TGI3MDE0bXBJ?=
 =?utf-8?B?OExLOHYya3UwUWJUd2hKekRTekwxYjZYNjg4NURISkYvc2xxZGo2OUlsdzdv?=
 =?utf-8?B?MzVMRjBRNW1Sb0VBNFFQY2dsMFFTUE8ybnE1dmx3eHpMOVFOekV2ekJNMWRi?=
 =?utf-8?Q?/LIkneJ2+QW0XjOPdoB1FwPZmVPOdbbwXRGyj3i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec59914-7d4c-4f5b-a4bc-08d96667e25d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 18:57:41.7029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YYCh9QuhgEoF6OFfIq8X1jMbAYgSjBR4bGSsO8bOlSrQbeRNK++4EDRWvk1tFsX57ZS4KRbujnydySgZW80CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5036
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


Am 2021-08-19 um 9:36 a.m. schrieb David Yat Sin:
> From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>
> Checkpoint-Restore in userspace (CRIU) is a powerful tool that can
> snapshot a running process and later restore it on same or a remote
> machine but expects the processes that have a device file (e.g. GPU)
> associated with them, provide necessary driver support to assist CRIU
> and its extensible plugin interface. Thus, In order to support the
> Checkpoint-Restore of any ROCm process, the AMD Radeon Open Compute
> Kernel driver, needs to provide a set of new APIs that provide
> necessary VRAM metadata and its contents to a userspace component
> (CRIU plugin) that can store it in form of image files.
>
> This introduces some new ioctls which will be used to checkpoint-Restore
> any KFD bound user process. KFD doesn't allow any arbitrary ioctl call
> unless it is called by the group leader process. Since these ioctls are
> expected to be called from a KFD criu plugin which has elevated ptrace
> attached privileges and CAP_SYS_ADMIN capabilities attached with the file
> descriptors so modify KFD to allow such calls.
>
> (API redesign suggested by Felix Kuehling and implemented by David Yat
> Sin)
>
> Signed-off-by: David Yat Sin <david.yatsin@amd.com>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> (cherry picked from commit 72f4907135aed9c037b9f442a6055b51733b518a)
> (cherry picked from commit 33ff4953c5352f51d57a77ba8ae6614b7993e70d)
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  70 ++++++++++++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  69 ++++++++++++++
>  include/uapi/linux/kfd_ioctl.h           | 110 ++++++++++++++++++++++-
>  3 files changed, 247 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 059c3f1ca27d..a1b60d29aae1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -33,6 +33,7 @@
>  #include <linux/time.h>
>  #include <linux/mm.h>
>  #include <linux/mman.h>
> +#include <linux/ptrace.h>
>  #include <linux/dma-buf.h>
>  #include <asm/processor.h>
>  #include "kfd_priv.h"
> @@ -1802,6 +1803,44 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
>  	return -EPERM;
>  }
>  #endif
> +static int kfd_ioctl_criu_dumper(struct file *filep,
> +				struct kfd_process *p, void *data)
> +{
> +	pr_debug("Inside %s\n", __func__);
> +
> +	return 0;
> +}
> +
> +static int kfd_ioctl_criu_restorer(struct file *filep,
> +				struct kfd_process *p, void *data)
> +{
> +	pr_debug("Inside %s\n", __func__);
> +
> +	return 0;
> +}
> +
> +static int kfd_ioctl_criu_pause(struct file *filep, struct kfd_process *p, void *data)
> +{
> +	pr_debug("Inside %s\n", __func__);
> +
> +	return 0;
> +}
> +
> +static int kfd_ioctl_criu_resume(struct file *filep,
> +				struct kfd_process *p, void *data)
> +{
> +	pr_debug("Inside %s\n", __func__);
> +
> +	return 0;
> +}
> +
> +static int kfd_ioctl_criu_process_info(struct file *filep,
> +				struct kfd_process *p, void *data)
> +{
> +	pr_debug("Inside %s\n", __func__);
> +
> +	return 0;
> +}
>  
>  #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
>  	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags = _flags, \
> @@ -1906,6 +1945,21 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
>  
>  	AMDKFD_IOCTL_DEF(AMDKFD_IOC_SET_XNACK_MODE,
>  			kfd_ioctl_set_xnack_mode, 0),
> +
> +	AMDKFD_IOCTL_DEF(AMDKFD_IOC_CRIU_DUMPER,
> +			 kfd_ioctl_criu_dumper, KFD_IOC_FLAG_PTRACE_ATTACHED),
> +
> +	AMDKFD_IOCTL_DEF(AMDKFD_IOC_CRIU_RESTORER,
> +			 kfd_ioctl_criu_restorer, KFD_IOC_FLAG_ROOT_ONLY),
> +
> +	AMDKFD_IOCTL_DEF(AMDKFD_IOC_CRIU_PROCESS_INFO,
> +			 kfd_ioctl_criu_process_info, KFD_IOC_FLAG_PTRACE_ATTACHED),
> +
> +	AMDKFD_IOCTL_DEF(AMDKFD_IOC_CRIU_RESUME,
> +			 kfd_ioctl_criu_resume, KFD_IOC_FLAG_ROOT_ONLY),
> +
> +	AMDKFD_IOCTL_DEF(AMDKFD_IOC_CRIU_PAUSE,
> +			 kfd_ioctl_criu_pause, KFD_IOC_FLAG_PTRACE_ATTACHED),
>  };
>  
>  #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
> @@ -1920,6 +1974,7 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>  	char *kdata = NULL;
>  	unsigned int usize, asize;
>  	int retcode = -EINVAL;
> +	bool ptrace_attached = false;
>  
>  	if (nr >= AMDKFD_CORE_IOCTL_COUNT)
>  		goto err_i1;
> @@ -1945,7 +2000,15 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>  	 * processes need to create their own KFD device context.
>  	 */
>  	process = filep->private_data;
> -	if (process->lead_thread != current->group_leader) {
> +
> +	rcu_read_lock();
> +	if ((ioctl->flags & KFD_IOC_FLAG_PTRACE_ATTACHED) &&
> +	    ptrace_parent(process->lead_thread) == current)
> +		ptrace_attached = true;
> +	rcu_read_unlock();
> +
> +	if (process->lead_thread != current->group_leader
> +	    && !ptrace_attached) {
>  		dev_dbg(kfd_device, "Using KFD FD in wrong process\n");
>  		retcode = -EBADF;
>  		goto err_i1;
> @@ -1960,6 +2023,11 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>  		goto err_i1;
>  	}
>  
> +	/* KFD_IOC_FLAG_ROOT_ONLY is only for CAP_SYS_ADMIN */
> +	if (unlikely((ioctl->flags & KFD_IOC_FLAG_ROOT_ONLY) &&
> +		     !capable(CAP_SYS_ADMIN)))
> +		return -EACCES;
> +
>  	if (cmd & (IOC_IN | IOC_OUT)) {
>  		if (asize <= sizeof(stack_kdata)) {
>  			kdata = stack_kdata;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 64552f6b8ba4..768cc3fe95d2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -121,7 +121,35 @@
>   */
>  #define KFD_QUEUE_DOORBELL_MIRROR_OFFSET 512
>  
> +/**
> + * enum kfd_ioctl_flags - KFD ioctl flags
> + * Various flags that can be set in &amdkfd_ioctl_desc.flags to control how
> + * userspace can use a given ioctl.
> + */
> +enum kfd_ioctl_flags {
> +	/**
> +	 * @KFD_IOC_FLAG_ROOT_ONLY:
> +	 * Certain KFD ioctls such as AMDKFD_IOC_CRIU_RESTORER can potentially
> +	 * perform privileged operations and load arbitrary data into MQDs and
> +	 * eventually HQD registers when the queue is mapped by HWS. In order to
> +	 * prevent this we should perform additional security checks. In other
> +	 * cases, certain ioctls such as AMDKFD_IOC_CRIU_RESUME might be called
> +	 * by an external process e.g. CRIU restore process, for each resuming
> +	 * tasks and thus require elevated privileges.
> +	 *
> +	 * This is equivalent to callers with the SYSADMIN capability.
> +	 */
> +	KFD_IOC_FLAG_ROOT_ONLY = BIT(0),
> +	/**
> +	 * @KFD_IOC_FLAG_PTRACE_ATTACHED:
> +	 * Certain KFD ioctls such as AMDKFD_IOC_CRIU_HELPER and
> +	 * AMDKFD_IOC_CRIU_DUMPER are expected to be called during a Checkpoint
> +	 * operation triggered by CRIU. Since, these are expected to be called
> +	 * from a PTRACE attached context, we must authenticate these.
> +	 */
> +	KFD_IOC_FLAG_PTRACE_ATTACHED = BIT(1),
>  
> +};
>  /*
>   * Kernel module parameter to specify maximum number of supported queues per
>   * device
> @@ -977,6 +1005,47 @@ void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
>  				  uint64_t tba_addr,
>  				  uint64_t tma_addr);
>  
> +/* CRIU */
> +/*
> + * Need to increment KFD_CRIU_PRIV_VERSION each time a change is made to any of the CRIU private
> + * structures:
> + * kfd_criu_process_priv_data
> + * kfd_criu_device_priv_data
> + * kfd_criu_bo_priv_data
> + * kfd_criu_queue_priv_data
> + * kfd_criu_event_priv_data
> + * kfd_criu_svm_range_priv_data
> + */
> +
> +#define KFD_CRIU_PRIV_VERSION 1
> +
> +struct kfd_criu_process_priv_data {
> +	uint32_t version;
> +};
> +
> +struct kfd_criu_device_priv_data {
> +	/* For future use */
> +	uint64_t reserved;
> +};
> +
> +struct kfd_criu_bo_priv_data {
> +	uint64_t reserved;
> +};
> +
> +struct kfd_criu_svm_range_priv_data {
> +	uint64_t reserved;
> +};
> +
> +struct kfd_criu_queue_priv_data {
> +	uint64_t reserved;
> +};
> +
> +struct kfd_criu_event_priv_data {
> +	uint64_t reserved;
> +};
> +
> +/* CRIU - End */
> +
>  /* Queue Context Management */
>  int init_queue(struct queue **q, const struct queue_properties *properties);
>  void uninit_queue(struct queue *q);
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 3cb5b5dd9f77..19489e2ca58e 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -467,6 +467,99 @@ struct kfd_ioctl_smi_events_args {
>  	__u32 anon_fd;	/* from KFD */
>  };
>  
> +struct kfd_criu_process_bucket {
> +	__u64 priv_data_offset;
> +	__u64 priv_data_size;
> +};
> +
> +struct kfd_criu_device_bucket {
> +	__u64 priv_data_offset;
> +	__u64 priv_data_size;
> +	__u32 user_gpu_id;
> +	__u32 actual_gpu_id;
> +	__u32 drm_fd;
> +	__u32 pad;
> +};
> +
> +struct kfd_criu_bo_bucket {
> +	__u64 priv_data_offset;
> +	__u64 priv_data_size;
> +	__u64 addr;
> +	__u64 size;
> +	__u64 offset;
> +	__u64 restored_offset;
> +	__u32 gpu_id;
> +	__u32 alloc_flags;
> +	__u32 dmabuf_fd;
> +	__u32 pad;
> +};
> +
> +struct kfd_criu_queue_bucket {
> +	__u64 priv_data_offset;
> +	__u64 priv_data_size;
> +	__u32 gpu_id;
> +	__u32 pad;
> +};
> +
> +struct kfd_criu_event_bucket {
> +	__u64 priv_data_offset;
> +	__u64 priv_data_size;
> +	__u32 gpu_id;
> +	__u32 pad;
> +};
> +
> +struct kfd_ioctl_criu_process_info_args {
> +	__u64 process_priv_data_size;
> +	__u64 bos_priv_data_size;
> +	__u64 devices_priv_data_size;
> +	__u64 queues_priv_data_size;
> +	__u64 events_priv_data_size;
> +	__u64 svm_ranges_priv_data_size;
> +	__u64 total_bos;
> +	__u64 total_svm_ranges;
> +	__u32 total_devices;
> +	__u32 total_queues;
> +	__u32 total_events;
> +	__u32 task_pid;
> +};
> +
> +struct kfd_ioctl_criu_pause_args {
> +	__u32 pause;
> +	__u32 pad;
> +};
> +
> +enum kfd_criu_object_type {
> +	KFD_CRIU_OBJECT_TYPE_PROCESS	= 0,
> +	KFD_CRIU_OBJECT_TYPE_DEVICE	= 1,
> +	KFD_CRIU_OBJECT_TYPE_BO		= 2,
> +	KFD_CRIU_OBJECT_TYPE_QUEUE	= 3,
> +	KFD_CRIU_OBJECT_TYPE_EVENT	= 4,
> +	KFD_CRIU_OBJECT_TYPE_SVM_RANGE	= 5,
> +};
> +

Please add comments explaining the members of the ioctl args structures.
E.g. it's not obvious that objects is a user mode pointer, or the
semantics of the objects_index_start field.

Regards,
  Felix


> +struct kfd_ioctl_criu_dumper_args {
> +	__u64 num_objects;
> +	__u64 objects;
> +	__u64 objects_size;
> +	__u64 objects_index_start;
> +	__u32 type; /* enum kfd_criu_object_type */
> +	__u32 pad;
> +};
> +
> +struct kfd_ioctl_criu_restorer_args {
> +	__u64 num_objects;
> +	__u64 objects;
> +	__u64 objects_size;
> +	__u64 objects_index_start;
> +	__u32 type; /* enum kfd_criu_object_type */
> +	__u32 pad;
> +};
> +
> +struct kfd_ioctl_criu_resume_args {
> +	__u32 pid;	/* to KFD */
> +	__u32 pad;
> +};
> +
>  /* Register offset inside the remapped mmio page
>   */
>  enum kfd_mmio_remap {
> @@ -740,7 +833,22 @@ struct kfd_ioctl_set_xnack_mode_args {
>  #define AMDKFD_IOC_SET_XNACK_MODE		\
>  		AMDKFD_IOWR(0x21, struct kfd_ioctl_set_xnack_mode_args)
>  
> +#define AMDKFD_IOC_CRIU_DUMPER			\
> +		AMDKFD_IOWR(0x22, struct kfd_ioctl_criu_dumper_args)
> +
> +#define AMDKFD_IOC_CRIU_RESTORER		\
> +		AMDKFD_IOWR(0x23, struct kfd_ioctl_criu_restorer_args)
> +
> +#define AMDKFD_IOC_CRIU_PROCESS_INFO		\
> +		AMDKFD_IOWR(0x24, struct kfd_ioctl_criu_process_info_args)
> +
> +#define AMDKFD_IOC_CRIU_RESUME			\
> +		AMDKFD_IOWR(0x25, struct kfd_ioctl_criu_resume_args)
> +
> +#define AMDKFD_IOC_CRIU_PAUSE			\
> +		AMDKFD_IOWR(0x26, struct kfd_ioctl_criu_pause_args)
> +
>  #define AMDKFD_COMMAND_START		0x01
> -#define AMDKFD_COMMAND_END		0x22
> +#define AMDKFD_COMMAND_END		0x27
>  
>  #endif
