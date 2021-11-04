Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850F5C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 03:15:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4329A60EDF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 03:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4329A60EDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 842447B4AE;
	Thu,  4 Nov 2021 03:15:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AC5C7B4AC
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 03:15:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iliY1pBlYuSV1l1lNKPUTfQzZIfiu53VwXbjXooJbCc25Ex/f3iP3+opsfDpvuRBi9UCEEgY2Yj4DIIFvJHajA1b1vHpNSb4dvA/rba9YE586U12AA+XJdDmNfXyEXKOot7CE1eY9zHuJbVYQXXyUdE6cT22qXxbtmgwgt4aZXWWNZSQSdXVIiFdyIJdbM8uLHNWzBvp8yMm9+xGuuIFdBy7kcfgQMtdm7kdKjiQMINWgU9seZJGCdMGCWkcoda/+h8DkaFYQKZ+7Uu8kBpjwdWDDbVFheqTsHaPpGpcaM0RfOPwNPfn/Rxq8lxOdLfD7vJ52EzLcthI+KYvLd4wfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4tfr1KMYZqbqsDk74sOrQj1875q0Q9L2OzwqEtjwN4=;
 b=cMfNBCeB400WA8o63FSmnaVsiH/0L8OXrmrHzc9glErQg6LHVmkoWivX0g48VwNWnsZUKLkzD90KsWkvXIjH+arZW8NE7tX19n8re4QW6rR7fZ81E6cT6LlxWST8gO13ICCBf5LvFVgrbEorN1+fLCM3Xmiy5eT0uIsJ4VlhgC/3FgPPaScBuTYXQF+VpJqWkJNAcrNFX/pNNL8HI6HPyrI4krYGn24aC8jdqX2U4spAboUMw/qEhOwBeZdv3vBlmeuiYQPcJ2eDSbnUd59Kof3C06QdjM+YDfdsw713rbZ6EgUoFTVcOF5hECLi/asaSDB9VsGzEsUKrbVwJUG4Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4tfr1KMYZqbqsDk74sOrQj1875q0Q9L2OzwqEtjwN4=;
 b=vQ2mMr92QcHNedaLO5NVg4xBVLpCo/qm7oKEm3wffP33gZWdULjIacaQds57EER8ConFdmViH7ovD01+0/8DIj+DdnCh7a7GZ5JaHmu1taLqqwGFesBPTxrQaFUR7KGXNW/woAwEbO4JkqGUyG7vK2sx4m2/vt1hg/eJLO6F4s0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM5PR12MB1243.namprd12.prod.outlook.com (2603:10b6:3:74::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.18; Thu, 4 Nov
 2021 03:15:54 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 03:15:54 +0000
Subject: Re: [PATCH] drm/amd/amdkfd: Don't sent command to HWS on kfd reset
To: shaoyunl <shaoyun.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211103150427.18518-1-shaoyun.liu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <aa25c7fc-65e1-39cf-6934-cb617e239c7d@amd.com>
Date: Wed, 3 Nov 2021 23:15:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211103150427.18518-1-shaoyun.liu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR1PR01CA0035.eurprd01.prod.exchangelabs.com
 (2603:10a6:102::48) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 PR1PR01CA0035.eurprd01.prod.exchangelabs.com (2603:10a6:102::48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.19 via Frontend
 Transport; Thu, 4 Nov 2021 03:15:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1450e594-d47a-4c09-7d7a-08d99f416998
X-MS-TrafficTypeDiagnostic: DM5PR12MB1243:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1243EC381C135F01352CCB1E928D9@DM5PR12MB1243.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZZWzoMHXJs8xFmvDXamigX3YWxLPNSQXIjNPzmqTFDq3ylF+tVwze4osKMNslcdrlwE4o01XELWFF5i9z/4kQtLcp/xsrYgOE+V6lNAoUgF1ecO4WlZQ3bWDQXbvHM9uSUp+w1vSfmvyhHA3SpWZyE7mgBJbdeVMnyZagKQdLYyVTaS8pEkat1vIb/JcdzoKNAX8eh28HURKdSr31CUJCEsGV3Bs98PndkULEMFXVq85Bgo2awjMk46KOMH6wIlpB5aFbJEus+XLf+q4QvOtSFSHPukba5JtGgO27fRTdPmMMZXis8MBRElBQS5VN2itw3B7nrFEDMs9psDvPoe+dDd/fAFn47Wv8Gp0v5own8JGXnc6sJtYyw0lk0DCFtQMJ2vJtEUJAU3/zJAQv4iup8p+4ZvvtxI2AnjruXvtkTzQJrTSpGUtCCGt1G8tc5SQBYUTy5NDRmTLtlyF3Y8kVIHISPz7Um7m6OeiYDSNYTRHfLVS7fpzk7OAqqfDRw133+SkzLWOxe7HsxI4ZEf2/GS49IikbAefOxr4jV6d+4XBwpF3quPlvKikkKguCbYUXnjF1famuUiImVtP/ikIbyfmCyQYicewL2LV6PG+m2qyvxMm71hHuQKz/ikXOQY0LNR7PLzpO1pVdq0reVktXqQvq72nanAtUBfAGHH4Qu3vPOFN4BDacpfv3xma4bDPznqjMTaJS1V276eljoFZPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36916002)(8676002)(16576012)(316002)(26005)(186003)(8936002)(86362001)(66556008)(83380400001)(38100700002)(956004)(66476007)(2906002)(44832011)(31696002)(2616005)(508600001)(31686004)(5660300002)(66946007)(53546011)(6486002)(36756003)(6666004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGpvdytIOHNFczVQRDlPN0g5OUlXckpPOGExQWNoeXFSM0VMY3BOeUdUSVNz?=
 =?utf-8?B?RWg1K2ZjOHo3Vkd5TDNaNUQ4OFpRci96eHpVVVc4L0V5Y2dCc0owYjNkYjRT?=
 =?utf-8?B?K21nbDZQUjdRZlE1T0V2dnovYVptbDkvb0hoTVFhQzJYbW12Q2JqbFVYdDBs?=
 =?utf-8?B?MjZUYjNlVndTVWdLZGZ4Q0M4ejM3RHZIb1A4dWZ2cHlscGZ2b1U4RThNVng2?=
 =?utf-8?B?b3NyektjS0MyUnQ1c2N3QUJOZFRLb2xMQnpZS1JxSG01a3dzOWx3VWJRK1pr?=
 =?utf-8?B?d0cvZG1pR3NEU1lXa1VOWDlnWmk2SG10dzYzWmpHa3k5dWlvdStKU1pwN1FE?=
 =?utf-8?B?NTBxOTZjVWozOFZBeFcvQUpFSVFCMXZCQTYvWC9VMGN4bkdrcjY5TmhXd3ZO?=
 =?utf-8?B?aGdvWUx1M0tqSmhHMlhyTUdVM0Rza3dsS1A4ZHlDTFdSZFk4cXo4OHdRc2ww?=
 =?utf-8?B?am40djJWZ3FEWmlaMjZhNUZ0d0Q4OTZXbW1EbGRkeDQ4LzZvTmFkNkl6d28r?=
 =?utf-8?B?Vk5tUmdLNHJuY1FPaHp5d0ttd0p4cFFqb0pkbTd6b3Zzb3dxUXMxemhBdTh3?=
 =?utf-8?B?cUwzaGh6K3Vrc3ZyN2xuUjh4eS93TzEwVm91Tk1EWDBWZ1ViZjVMSEZOY0h3?=
 =?utf-8?B?VFpCWm85Y0dGdUxYTjE1eW5LMU9OZi9LekpRMGIybktoaXBWbXJCbXVmYzc0?=
 =?utf-8?B?ZEcwQkpWU2s0NFU4ZE9SMGdCOTJLVWV6alJWUXF0WUJDeUpDa3hseS9mOEdw?=
 =?utf-8?B?YXFRQ0d3UTFtUWxQeGIyQ25KTXBVZHl3QmwxQlllbngrYVo2SERWVTNlQ1VU?=
 =?utf-8?B?MVRxRXFXOGxlWVlxdFl1SUhmV3lNQ3JvRDlZM0ZNaTlMWUp4NkNERjZsZXJF?=
 =?utf-8?B?U0Z4ZEtXQ3NiZUgrNUJva05vWDJndkY2MjdtQnpBZGQvNW1ZV21wT0tHZStL?=
 =?utf-8?B?SlU5RU1aV0hIM1YrbVNRTmpPTk1ENURMdm5ZU0Z3dW1EOUFTd3NQNUcyUFFq?=
 =?utf-8?B?cWdtdDlnOUlmeDN5OVhXVW9TZy9WQS9GejlGamREQ05YTmFMY09rZWUxUjdT?=
 =?utf-8?B?N2xkWUQ2WXRJQVQrY3dJUFEzLzRtYXZwUk5uMHZzWFJMNUdFLzVjY2s0U1lr?=
 =?utf-8?B?ZEN6OXR4Mkh6bHBJdDZQT1N2cGpWWHdsM3VkR0VNL0lIY3EybVhRVlZQME4y?=
 =?utf-8?B?a3hjOGhBb3dQeUNOeUpudGJybk9VN0xVazNORmZac21WRmp6OVJyRkZhamJQ?=
 =?utf-8?B?U2tSWXJacmI5MUFMY0JJWnZ4R2lnTUxIeTljWUlIYng1bC9PS2dlRGpMd1Nk?=
 =?utf-8?B?NVg1YnRTaDlsdEdnVGJXdkNmelVtcTMyeER4Vk1HQXh5aGhhck9lSEVtVi9T?=
 =?utf-8?B?K2Z1L1p2dHNoNGtIeDNxRThLczhYVHBZamR5SGRiU1ZUMDU4bUhIbGtTaDdE?=
 =?utf-8?B?dmV2Q3g4alUzanE1bHVQRzFvT1Y3b1E1UGFTSHZWOTNZOVhaK1ZINk4xNTFs?=
 =?utf-8?B?b0hleXZlNHgvenJvWDdOSmNMMENKSHRGWEFQTXlqb3FNMkpTOWZ4R0pIdE1H?=
 =?utf-8?B?dHh6Tm1mSklQUzlia2gwRG03NzZOV0hCbjZTc3IreTM0cXhCTEVnTFhSNDBt?=
 =?utf-8?B?SzRQTXJKdUNTblpCM08rVjhDNm5FYlc1Sm5hVGNCN3JPbkdYeDE5VzVnWHJX?=
 =?utf-8?B?dVl6cDVTN21IOHRmOUh0UFR3Q1QycTVpeTVKYVBiYTZyTFNVTmVZOGtMYnFM?=
 =?utf-8?B?VmozRUF5MTk5bWtjNFZtNVVndDlIWm1rZEU1TS9vYWd4WWhmWGJaMHgzMUVP?=
 =?utf-8?B?Nm9JZlZ3dzI2TERncmFmUVBDNHZqWmhUR3dKZDZObTV1ZVJYRmxBajNUbnpZ?=
 =?utf-8?B?TUcyN2ZMUzdsNFB2ajdrMkVENGdZVFEzeDhnUzRlc0luaTFrVHpNUGpCcFZE?=
 =?utf-8?B?aklhaElvQ0p0cm13V2x3enFtZFVGbEVodFc4MWtpNVpDYlpnWDgra0hUYmFE?=
 =?utf-8?B?RXV3cnh5RVZ5RjVzN2RGaEcwVjNRQjF4YVN6RUhmTitQN3lGLzNDVTFnSzVl?=
 =?utf-8?B?ZDZlVHBvS09KbXd3djYyWUYwS0JwbGtEU2VveVNJTngzR3o4NVd4d1JodEpK?=
 =?utf-8?B?a1ZZTVFsRzJ1OFNsOHVOQnJ4eCtLWGFXWlAwcVVFRVlsbUd1a3ZZS0FEcE4r?=
 =?utf-8?Q?kpjtdoWPYonS/PUwEHxtXBA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1450e594-d47a-4c09-7d7a-08d99f416998
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 03:15:54.4806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOGntyHlNaATRN7l1NyamtbIE7wxaSt/ECyy/UXakM74bT4PnI8UvtROOR5T5p7wG/0MAlLvPouDcCVcz2Y/BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1243
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


On 2021-11-03 11:04 a.m., shaoyunl wrote:
> When kfd need to be reset, sent command to HWS might cause hang and get unnecessary timeout.
> This change try not to touch HW in pre_reset and keep queues to be in the evicted state
> when the reset is done, so they are not put back on the runlist. These queues will be destroied
> on process termination.
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c               | 6 +++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 | 2 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c              | 6 +++++-
>   4 files changed, 13 insertions(+), 3 deletions(-)
>   mode change 100644 => 100755 drivers/gpu/drm/amd/amdkfd/kfd_device.c
>   mode change 100644 => 100755 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>   mode change 100644 => 100755 drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>   mode change 100644 => 100755 drivers/gpu/drm/amd/amdkfd/kfd_process.c
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> old mode 100644
> new mode 100755
> index c8aade17efef..536ef766d09e
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1100,6 +1100,8 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
>   	if (!kfd->init_complete)
>   		return 0;
>   
> +	kfd->is_resetting = true;
> +
>   	kfd_smi_event_update_gpu_reset(kfd, false);
>   
>   	kfd->dqm->ops.pre_reset(kfd->dqm);
> @@ -1132,6 +1134,8 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
>   
>   	kfd_smi_event_update_gpu_reset(kfd, true);
>   
> +	kfd->is_resetting = false;
> +
>   	return 0;
>   }
>   
> @@ -1168,7 +1172,7 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>   		return ret;
>   
>   	/* for runtime resume, skip unlocking kfd */
> -	if (!run_pm) {
> +	if (!run_pm && !kfd->is_resetting) {

This is not needed. post_reset calls kfd_resume, not kgd2kfd_resume. It 
should never get here.

Regards,
   Felix


>   		count = atomic_dec_return(&kfd_locked);
>   		WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
>   		if (count == 0)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> old mode 100644
> new mode 100755
> index e9601d4dfb77..0a60317509c8
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1430,7 +1430,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   
>   	if (!dqm->sched_running)
>   		return 0;
> -	if (dqm->is_hws_hang)
> +	if (dqm->is_hws_hang || dqm->is_resetting)
>   		return -EIO;
>   	if (!dqm->active_runlist)
>   		return retval;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> old mode 100644
> new mode 100755
> index bfe7bacccb73..e4bcc2a09ca8
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -275,6 +275,8 @@ struct kfd_dev {
>   	struct device_queue_manager *dqm;
>   
>   	bool init_complete;
> +	bool is_resetting;
> +
>   	/*
>   	 * Interrupts of interest to KFD are copied
>   	 * from the HW ring into a SW ring.
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> old mode 100644
> new mode 100755
> index f8a8fdb95832..f29b3932e3dc
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1715,7 +1715,11 @@ int kfd_process_evict_queues(struct kfd_process *p)
>   
>   		r = pdd->dev->dqm->ops.evict_process_queues(pdd->dev->dqm,
>   							    &pdd->qpd);
> -		if (r) {
> +		/* evict return -EIO if HWS is hang or asic is resetting, in this case
> +		 * we would like to set all the queues to be in evicted state to prevent
> +		 * them been add back since they actually not be saved right now.
> +		 */
> +		if (r && r != -EIO) {
>   			pr_err("Failed to evict process queues\n");
>   			goto fail;
>   		}
