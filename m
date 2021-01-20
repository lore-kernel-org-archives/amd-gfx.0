Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9A8C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 16:40:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C80E23358
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 16:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C80E23358
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09B27898CE;
	Wed, 20 Jan 2021 16:40:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57E39898CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jan 2021 16:39:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mf9vKrQrhnM9jyPTkdQICGO/5WoyPCmnyI/c36UI/gtHeT5Vglf5c4+SgG1F2+inHXrnTDgUC8xfjEl3SEvm6aPsWyFWq5aBN38l4QH8I2jq26FufIAjAXfPQblC7KGmoGBKiZ+tCREgwKDyLh2ZJA2bPGBcPfy+asTfdllO/KmGMASkCDVaJJCCuNZFPBW7mCd7Fekd3PtWcGBN859R6nujIguzR59CK+9rTizddPGp654CGBha+cinQM4hjSXiPDpZT4gZ6/5qTUWPTI2eEtzLZIQi1S5gjAi3eGQfqr+1ZNPNeq27s9oBJkkPxIaVOKBsEZH3t/x00hgrDtEhdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfBH0XDE0VTBv0BlNN7Vfc7BJXjMuvXVUqCWT1Lm2Ss=;
 b=QwLLo8DIJlkgTDHgIJC8ERbXSfLP784WfyBgPGGYuoTTG6yu91+uwDiAlPJkivJSrvMEZsCcLCGMnbeeTF33talrm1YdfBiniEnksToCeQCGQIuo1xDdpytfHPJ/nmAa/W+PGLM9pRRfd5oaP+dSAYwUXrwyi6ONTtwrEkzsAh0qNsnkpdkJsiwkaG1pXrWYf7WKLzblHN83G05xJJZOiW56MikuOUSUGmhD3ql2dYaqSrNSJlcggxL6WnUxE+Dicrl4UGv4pIzuustQ12QbZdWl81juhwa+1Aty/ip72V1pMlu/l6KYIJzNrCB2wMhPz/9h7cSFQ7LbdPnDfQv8XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfBH0XDE0VTBv0BlNN7Vfc7BJXjMuvXVUqCWT1Lm2Ss=;
 b=3GGngXYxOFoJoeMBpUkcXK8Wyr26UJx+kVvE5nXeAc4ofYJUZqjutpyWGTNFDoJY/NgXNOvWq3pO7IlEe5925N5Euy/DKu22i7YIhiMj1PbyP58xz3lXTYT2hVKSlOlPiTG2YL+GXqxnx8O+/9qSAJCDCsH2ay8DHOPLnbCCk80=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Wed, 20 Jan
 2021 16:39:57 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::5d30:b29d:5f5b:6921]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::5d30:b29d:5f5b:6921%5]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 16:39:57 +0000
Subject: Re: [PATCH] drm/amdgpu: race issue when jobs on 2 ring timeout
To: Horace Chen <horace.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210120141250.4095-1-horace.chen@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <54b28e65-226d-a9a2-2448-c2decd1a7d58@amd.com>
Date: Wed, 20 Jan 2021 11:39:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210120141250.4095-1-horace.chen@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:39c9:c8e8:c41f:6637]
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:39c9:c8e8:c41f:6637]
 (2607:fea8:3edf:49b0:39c9:c8e8:c41f:6637) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Wed, 20 Jan 2021 16:39:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 24727191-e1b8-4481-0aa0-08d8bd6205b5
X-MS-TrafficTypeDiagnostic: SA0PR12MB4351:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4351B88BAC94BAE59B47B4EBEAA20@SA0PR12MB4351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /5tWIEoKjG/0W/zOBOgZaZf7J6TK6qqgaR9FN2YMiVAHcD8K0co5T0ccK5v0ZEkega3CaJ8E1/aHEj4VoPFfnoYRkNYLqSP0cyzwX0yk22fWm292mmXy+9TwQC4OMZ8gH+QwXfBAXauZq5ouHCWooxrdOwDGwfAigZWMTFDRHFHLLXg2UmPov0D/UBKVi7TOxJ2CyI1ffNr8/+jHzo3M5huNampFHGVRz1RRDQ773QV57umHFeeQoujhFHl3RX8HkRXC5VuTFSsPTWjKbm0Mqh7G84y3pSyJ9MBJ+mnckacaUuaJ5OrXSB+niWINKle+bkFR0a5NCEfsB+KnGtC8voacnINKHwWmZgMY7xCW9c629VCND1LWd4SxHGI0kNyyGKGjva3Iakw+45RK278uKpFa6r/5ELklAx1w6FUaRdbqfK9pJOKxsJI0d/SDOjgsNn+wKs/Zx1ZYKzhQ9XZxr7MBFnK6O/POtnIGgs/SFQI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(86362001)(5660300002)(8676002)(31686004)(316002)(31696002)(54906003)(83380400001)(36756003)(66556008)(66476007)(66946007)(8936002)(2616005)(52116002)(6486002)(478600001)(186003)(16526019)(2906002)(53546011)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SHd4OVhvamRsVFRLR0xYL2pIVVVkMVQ4T3pzUkp5NnlucHB6R0RQbVQwU2xR?=
 =?utf-8?B?QlFJS09KTElYa2IzbTkrNG0zeUdQcE5XZFRCQnMraURnTFdoSTAzeDRTRnY1?=
 =?utf-8?B?L25qTk5OWUxyMGI5dVdWdGh6Z0FDV3JMN3c2cG81cVlzM0haSWRzd3MwckdZ?=
 =?utf-8?B?ZFpIQnR5SXdzNFZ4UjkreldLMWtlazlpVUlZZ21aTzlOMURlTU8yOXZxeU90?=
 =?utf-8?B?dkY4R292dWRvR2lBZndoeHZCS0Z5VDVnYzNtWXZzTVNxT29uQXQxNEorRHFK?=
 =?utf-8?B?UWVubGV4UWRYT3FzRGwybTNxQ25PTU1KWmxZVXNUYnpxbG56SkJtWEI1S0R1?=
 =?utf-8?B?V3c2REZtN011VXdxbEh2ejNRMlE2YzVoZ2c1ZGpXNE9ncUQ1VTRwQUlQTnFK?=
 =?utf-8?B?Uk9FbHh2TGg2Z0JTZE96NFh1VC81Qzh5bFVLd3dNMTBPaWlsUnI0bHlDOHVC?=
 =?utf-8?B?ekNnTVpXRjU1OFFYYU5hbHhYQ0xKSDJmSHZJbzlmMXdYUDBnUm93UVRtejZN?=
 =?utf-8?B?d2NNcW1RZ3J2VnR0cFN4eW5TNWJ4YXNRNUJCVktBZmpjU2pSNnJjeHJkTU8y?=
 =?utf-8?B?c2JBN3NNUkh0eUxWbGRGMSt3dzVOa3NzRm5xeGxmQjJKSmM1TktLUUh6ZUVE?=
 =?utf-8?B?WkdDYlJ1SW5qaUVsYlloRlFCRno4dlM0RU1EdnJYckVxeDFpZGtxSVROMUJm?=
 =?utf-8?B?Y1g4S3VNTU9Cd0o2R0grVUg0TS9oL29yOUhndkhKQUFPZFVYK2UzOTFHbnBL?=
 =?utf-8?B?Q2lyZG40Qy82TVJXemlXNVlzZXg5cUpnWDB4ak1CWEZTeklvY2tIdlJYaExr?=
 =?utf-8?B?QXBlb3c0bHlURXBrNmxOQ3dTdlowMW0xTEgvb0RvUmNIdU42RExGM3pWZ212?=
 =?utf-8?B?aC9RME1BdTJROUlzd1F1WDhCNWovUUZuODNva3haVmFseVUxL0w0aFkyaFB1?=
 =?utf-8?B?MWlJYURMcnhhSzh4eFRiWk5kMFJ4Y2FRVDArcnZ3NU4xdkRaWVBMYzNvU3JF?=
 =?utf-8?B?OEwvQ2hpcDNZN2FFM2tyZHNoanpCaldQdGpBSUR2eTc1T3lXb3ExQ1h4YW4w?=
 =?utf-8?B?QmJTekphdndra3VMcDlsVmtpWVp5MDM0bGVBSlMwc2hOUWxFcDFJVjU4RUwr?=
 =?utf-8?B?NWh1MUFmTkkwMnRQVkJjUElNUHFUMyswRDJaRmZRNmFpaVlHT1hyYm1Rek9h?=
 =?utf-8?B?dWVlSWRjeE5zWmNLYnF6L0JoWU1FZFlXdzhWc2FVTFRxZlN6NEpvQ3JYM1do?=
 =?utf-8?B?TWZzQ2pEUkVHcVo0OUFsbUpSZGNITVNXT1FlQ2VWQzExd0JCQWZXZ2hHUE1S?=
 =?utf-8?B?cCtrQVYzRnZuTmV1SGVTanVKcWhrU2RPbE8rL1pDRTJFc3ZVZWVmekNTS2d6?=
 =?utf-8?B?SHVBOHMwdHd5OTVXcGQ5d0EzWDJLVWxSRnRJQTBaZlpmRlUwcXAzcm82d0Fk?=
 =?utf-8?B?UVJySlVqcnJmUVRkbUM3QU9aY0JIVFIyeDh1YTBNK2lJam1vNWJhakE2dzRx?=
 =?utf-8?B?bWFwSnJ6K2wzQUNNVmROS0RuTUdaZHUwRHhxcTZ4Yy8rcDNLT3lEejFsYXg1?=
 =?utf-8?B?VGRrQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24727191-e1b8-4481-0aa0-08d8bd6205b5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 16:39:57.5419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5Zeg1/KSYBOyAgw5xNvzIv/0hIuudwEB5xlfE3ljTKFw29ShC6des5E7UauMDtbDw5UKfGySc3o1d367fsH/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 1/20/21 9:12 AM, Horace Chen wrote:
> Fix a racing issue when jobs on 2 rings timeout simultaneously.
>
> If 2 rings timed out at the same time, the
> amdgpu_device_gpu_recover will be reentered. Then the
> adev->gmc.xgmi.head will be grabbed by 2 local linked list,
> which may cause wild pointer issue in iterating.
>
> lock the device earily to prevent the node be added to 2
> different lists.
>
> also increase karma for the skipped job since the job is also
> timed out and should be guilty.
>
> Signed-off-by: Horace Chen <horace.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 70 +++++++++++++++++++---
>   1 file changed, 61 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4d434803fb49..d59d3182ac2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4460,6 +4460,46 @@ static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)
>   	up_write(&adev->reset_sem);
>   }
>   
> +/*
> + * to lockup a list of amdgpu devices in a hive safely, if not a hive
> + * with multiple nodes, it will be same as amdgpu_device_lock_adev.
> + *
> + * unlock won't require roll back.
> + */
> +static bool amdgpu_device_lock_hive_adev(struct amdgpu_device *adev, struct amdgpu_hive_info *hive)
> +{
> +	struct amdgpu_device *tmp_adev = NULL;
> +
> +	if (adev->gmc.xgmi.num_physical_nodes > 1) {
> +		if (!hive) {
> +			dev_err(adev->dev, "Hive is NULL while device has multiple xgmi nodes");
> +			return false;
> +		}
> +		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
> +			if (!amdgpu_device_lock_adev(tmp_adev, hive))
> +				goto roll_back;
> +		}
> +		return true;
> +	} else {
> +		return amdgpu_device_lock_adev(adev, hive);
> +	}
> +roll_back:
> +	if (!list_is_first(&tmp_adev->gmc.xgmi.head, &hive->device_list)) {
> +		/*
> +		 * if the lockup iteration break in the middle of a hive,
> +		 * it may means there may has a race issue,
> +		 * or a hive device locked up independently.
> +		 * we may be in trouble and may not,
> +		 * so will try to roll back the lock and give out a warnning.
> +		 */
> +		dev_warn(tmp_adev->dev, "Hive lock iteration broke in the middle. Rolling back to unlock");
> +		list_for_each_entry_continue_reverse(tmp_adev, &hive->device_list, gmc.xgmi.head) {
> +			amdgpu_device_unlock_adev(tmp_adev);
> +		}
> +	}
> +	return false;
> +}
> +
>   static void amdgpu_device_resume_display_audio(struct amdgpu_device *adev)
>   {
>   	struct pci_dev *p = NULL;
> @@ -4573,11 +4613,32 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   			DRM_INFO("Bailing on TDR for s_job:%llx, hive: %llx as another already in progress",
>   				job ? job->base.id : -1, hive->hive_id);
>   			amdgpu_put_xgmi_hive(hive);
> +			if (job)
> +				drm_sched_increase_karma(&job->base);
>   			return 0;
>   		}
>   		mutex_lock(&hive->hive_lock);
>   	}
>   
> +	/*
> +	 * lock the device before we try to operate the linked list
> +	 * if didn't get the device lock, don't touch the linked list since
> +	 * others may iterating it.
> +	 */
> +	if (!amdgpu_device_lock_hive_adev(adev, hive)) {
> +		dev_info(adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
> +					job ? job->base.id : -1);
> +
> +		if (adev->gmc.xgmi.num_physical_nodes > 1 && !hive)
> +			r = -ENODEV;
> +		else
> +			r = 0;


You can just change amdgpu_device_lock_hive_adev return type to int instead
of code duplication, maybe returning EAGAIN for actual locking failure.

Andrey


> +		/* even we skipped this reset, still need to set the job to guilty */
> +		if (job)
> +			drm_sched_increase_karma(&job->base);
> +		goto skip_recovery;
> +	}
> +
>   	/*
>   	 * Build list of devices to reset.
>   	 * In case we are in XGMI hive mode, resort the device list
> @@ -4585,8 +4646,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	 */
>   	INIT_LIST_HEAD(&device_list);
>   	if (adev->gmc.xgmi.num_physical_nodes > 1) {
> -		if (!hive)
> -			return -ENODEV;
>   		if (!list_is_first(&adev->gmc.xgmi.head, &hive->device_list))
>   			list_rotate_to_front(&adev->gmc.xgmi.head, &hive->device_list);
>   		device_list_handle = &hive->device_list;
> @@ -4597,13 +4656,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   
>   	/* block all schedulers and reset given job's ring */
>   	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
> -		if (!amdgpu_device_lock_adev(tmp_adev, hive)) {
> -			dev_info(tmp_adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
> -				  job ? job->base.id : -1);
> -			r = 0;
> -			goto skip_recovery;
> -		}
> -
>   		/*
>   		 * Try to put the audio codec into suspend state
>   		 * before gpu reset started.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
