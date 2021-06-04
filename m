Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4701C07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 12:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AF5261412
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 12:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF5261412
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A5D66E364;
	Fri,  4 Jun 2021 12:23:59 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18D766E364
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 12:23:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWp2RqQGOFdPuh8fogC7MNbJBEWkpUxrNUTi4+UvPcluVDngIFT/+EmpDFlUORMozmkVajkLk/T4wq3TFzogBvZRJCAreL5viOiyfgleVu4+FxJE8b2qF5mgVy3t79bzsocgYfse93UoVKuRktyHdNyecK5oIbnPBBH7udBagiBiKijhjpy/crZty6pVsKtcbE6TxK6mwc5fylSgEwNbFJwp0lID7c0xFq/I+JVWsqUJLNu3m1guCpOj7yGCOREjJrQh5+ldwI63PzCIxgfTPP2sYuJShuhSCY02jsf4ghfA/PUmr+EbrOqQAKodqIHDhR1x4BHVCoOyu59plBOK9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlc5WvodqFt8KUHphnmcsRYfRBsbq0rFLT1i6+y7Fns=;
 b=dLPU/pjd6BHGA1p+nWFLVNo+AlVURvMNFZlvnzviXD2fYXb9E4Ski1VuS+9qe3PlGvGt9Uy1raf+/Z5ZRNTtvtuNKkk3sN4yoJ4yxwPaVv0cOlJics3i2Byhxg94BPe2V+TCN4d43UnfYYo/ORpNSAcWfmlZo0h/qrsfgPPB4Q2M3Lj9xokzSkleZJkoeH89OjgQhOiyKvG9IxwtHdO2tlCMb8A39W38kfVfmiEiyttX/cWX6QHJ2cRgmrKvqrmJwb877bDjU5q45zoaiU7GG2/0d1Z26s+xyMqUwGa1IcqCg+cG/MU15K9wgqmBdrsX8MStup3LhKr1xvNOvlLQ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlc5WvodqFt8KUHphnmcsRYfRBsbq0rFLT1i6+y7Fns=;
 b=dgGkNGXfcfe5OJvwBWkRWHByIP8RRP5tV5R2gLCkpRncZ2INZFzf82XSJaYiJHkpXQBnRbzsV/tEr3szpIeSBWSOoKwlfQJkD2vZSTyQ05dRPVNYiN6gbMd+wry/IkYVvLcwgOBv1J/N7AH2eMIkTEhpGBhha09I9yMSXtZCd1Y=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5282.namprd12.prod.outlook.com (2603:10b6:610:d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Fri, 4 Jun
 2021 12:23:57 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9%3]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 12:23:56 +0000
Subject: Re: [PATCH V2 3/5] drm/amdgpu: correct the audio function initial
 Dstate
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210604095823.1403271-1-evan.quan@amd.com>
 <20210604095823.1403271-3-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <b55d9c52-cadf-fbb3-1ed0-8b99dc972b6c@amd.com>
Date: Fri, 4 Jun 2021 17:53:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210604095823.1403271-3-evan.quan@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: MA1PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::19) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.81.250] (165.204.159.242) by
 MA1PR01CA0103.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:1::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.15 via Frontend Transport; Fri, 4 Jun 2021 12:23:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6894532-ee98-4ef1-8d68-08d927539fa2
X-MS-TrafficTypeDiagnostic: CH0PR12MB5282:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB5282BDFA9429FBB929B54A28973B9@CH0PR12MB5282.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Or6+sDjw3U9BaZqa2uXxaMue5zGg7yalSbjQJBdrcGrDp4Lt9s9MLulUs3vdSDm5LFBZJYQ3tzArDOEjEiooUKREmBw8bHJeHPtCo9jf3hbNLyM0OdDuQrr7l6Wjb/dxwyoCi3/l7G+9QVXlbWgeZKfv2iX+7GjcT1XX0hzipioFzurgL0BRHxy8OybJp0B8irajJHwKkY3bXVyTDZ0W8a7yVIDkXp08jbeqmMZHs2z5JW1qxbkEN0Mu4P8pRdcx0hWHRLxqxTkC59FrXuvjeRKNpdgfJ5A1UmryyUWOikM8YPViBDZup65PGmkHfoJq50mLhLpFaG/7iQ4/TFnJ6D9br4LC9DrxLVxo9EqN3OrSy+0fJLVjThq8SWloJs34TubFxhHA8H8GLopCbdb6RTwO80hoiAR+i9+Xt/HmUqQGuaz4pFWUIGgpbo4DfGxVx6rXfgeqg0+TTC4rDC3NAQpvzjvaX667Iq158M3AcAiGfvmvYCdvW9z2hWP2tcuRyFUAKmKRbtkPZYyFwpvL28e1zkhqoLTqvCvjAXEjoLIDeA2IXNtOUFh+OR42YtMtJH3K8/18lo005l8uHtTcVdPl2wmmbpspsKWbDIrZm/++IowI5djnK0Ekg4bLi7fz6v4JDFtL4HfGs7JTzhpyyyZDbyj5hyEK0YFZIzRYu78uxlJ9mYbLZZARt3SBaK8f
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(8936002)(6666004)(31696002)(36756003)(86362001)(4326008)(31686004)(478600001)(83380400001)(8676002)(38100700002)(53546011)(26005)(16526019)(2906002)(66556008)(66946007)(66476007)(5660300002)(2616005)(6486002)(956004)(16576012)(316002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?L3VxelorVDVpQlh6cnNzeEt2cmlwOEJQcm9OVHh3ODRSdXJNci9rakh3N2tN?=
 =?utf-8?B?ZUdqWFJYV1dOK0R2REJyaTV3aG1nbnFKMkVwamhBRm9IWDFqdG1qTkFaOVRv?=
 =?utf-8?B?TGhMeGc0Sy9YTTBJSmlBcS9udXE1N3c3L3RYWTNvSytHVy9aMStnKzlsRFhB?=
 =?utf-8?B?RTlHQmhKZ05VV1FqdldiemgxUkFkc1MwdXVKTkxIci9RL3d4emRhblprd3VD?=
 =?utf-8?B?YTlvaUE3ZkwzQTlVeE83TVpDajRUaVk5M1lwL25YTVQrL09DRGR4QTArMGRX?=
 =?utf-8?B?NEFEYlJaR05yNEgrQ08xQkR0UllDWXludXBjNkhtYVFzbHBIZFZGMzdkZUV6?=
 =?utf-8?B?cXJqOVVPSGNmb1lFRnJvYWtoM0gwT1FjWFFxNXhMQmdtMzR5T2RtTVYvUjRR?=
 =?utf-8?B?N3lJdEVEa0UyNGs4Wm5mZmhQaC82UzBqZTBsWE9UR3AyRndURWU0THdSbXha?=
 =?utf-8?B?Wi8vb2F0OGRJMEs0YXU0TDdMand5WVV4YVhraU5yMGNkaXdrazB5VTF0RDlK?=
 =?utf-8?B?b1hDQnFGaG9kYmVOUDFWdVNSN1BOU084bmlDdTVISmdnMllMZ1puTVJveEEy?=
 =?utf-8?B?VjVBVkNUZ1YrdktYQ0VheWdiZG5VeXFCWTY4UDNxNSt5dmcrbkx5VzB5ZG05?=
 =?utf-8?B?L1pkbDJtNE5wa1FHUmlkbVdMdTN0MGE1eFU0djYzODdMQXFDVmxTVngvNHNT?=
 =?utf-8?B?djlyZ3hwU2J6N1VhR1BkSks0RncvRmNHcU9PY1lseTFIRGZkSWovRHJvTzFy?=
 =?utf-8?B?SjJqT3liR09uZUhOYkhic3NMZFF4T09Oa3MyRCtOOFRUNHdnajBTbjF5bmN1?=
 =?utf-8?B?YXhYT3lnWFVQUVRwOHF1cFFDWk5BRVYxaWRHTXJqTlBBa1cvT3N3T0Y5eUpq?=
 =?utf-8?B?aG9NOHRjTDdIZWhoNnp3cy9Hc0E3SjRxV3RCeU01OExUREtRK3o3TEpma3FU?=
 =?utf-8?B?bDFpeFpyaDQzbWs4L0NWZStldG1Ua1YzaTlUeWE2QkhrSGJmZVJvRnBiREdo?=
 =?utf-8?B?VUNHbHJRbCtSeUg2cFYvTEZYazkwQUxZUjZkcnlMVStsTVhKZzh3QTJZakVx?=
 =?utf-8?B?TjFpU0RyR1lNcStLZzlWQjVtL2Y1dmwrV013aHQyMjRuZHRzQmxrelkrVVB1?=
 =?utf-8?B?dU1PdDk2bHJjdDM3dU50SEhCV1U1cmorZHR3UTNCUWxPM2JnT2hBQnJoTFND?=
 =?utf-8?B?YkdRYU1scWd4aENkSGg3eW5IRXoxM3ZHQWg4WlVGbFFpUm9hQmFJSk9WN2Jo?=
 =?utf-8?B?NSsyOGNJeXoxNElyNWZNOUdwL3ZMM2JwVnZOcHVoNUZwaUJNVkhVOGg4UGlw?=
 =?utf-8?B?UFp0OWc1RzhtUlhTdnJlQXVxc1dkTW1rcGpQelBNcU5RZTl2aTlUSXhOTzVE?=
 =?utf-8?B?azNFdUUxU2ovSTAvZ2gvNmRwWEVlT2p2NllPM2VTOFprQWpxckI0UEN4NE1i?=
 =?utf-8?B?SzNzVThWTXBIMG8wRGd6TWwwV2ZMZXM3U2o2RTArNWp4eWROSzNYMzVaSFFQ?=
 =?utf-8?B?WHNUZHRlYWVFUGVKVEZnL3lheUN0NGM5NTRQWUtDclBuVHVMdDFTWjFhQ280?=
 =?utf-8?B?WE15M0pWcjY2SVQ3SWd6d1pDQ1ArUHFLSTlwbkRLRkxGZUovelQ0b2wvYXpk?=
 =?utf-8?B?cGFBbGhQS3RDVWY2RVlXa2ZTUHRQYTliQ3JlbjNHYk1rSzB5SjlGTDFTNzBy?=
 =?utf-8?B?MURFODkvQWEwaWxGV213OWd4SFhGZEN0TTR2NmdPb3M1VG9seTVjbkJTRytR?=
 =?utf-8?Q?IgEw7pMG5h8au9mNd/QK43hIVHtZpVA2yOWRYH9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6894532-ee98-4ef1-8d68-08d927539fa2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 12:23:56.8414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YIXmJsdSHWcHvJhWF0jkRWeStUnGrfSmNiOFnqW9//41xM6lzqmRREqrJE1a8b2g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5282
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
Cc: Alexander.Deucher@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/4/2021 3:28 PM, Evan Quan wrote:
> On driver loading, the ASIC is in D0 state. The bundled
> audio function should be in the same state also.
> 
> Change-Id: I136e196be7633e95883a7f6c33963f7583e9bad1
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
> V1->V2:
>    - Lijo: include the code in a seperate API for better readability
>    - limit the change for Navi10 and later dGPUs
>    - comments more about the background
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 40 +++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index c354ffa62483..e9f2161738d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -123,6 +123,22 @@ void amdgpu_register_gpu_instance(struct amdgpu_device *adev)
>   	mutex_unlock(&mgpu_info.mutex);
>   }
>   
> +static void amdgpu_get_audio_func(struct amdgpu_device *adev)
> +{
> +	struct pci_dev *p = NULL;
> +
> +	p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
> +			adev->pdev->bus->number, 1);
> +	if (p) {
> +		pm_runtime_get_sync(&p->dev);
> +
> +		pm_runtime_mark_last_busy(&p->dev);
> +		pm_runtime_put_autosuspend(&p->dev);
> +
> +		pci_dev_put(p);
> +	}
> +}
> +
>   /**
>    * amdgpu_driver_load_kms - Main load function for KMS.
>    *
> @@ -212,9 +228,33 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>   						DPM_FLAG_MAY_SKIP_RESUME);
>   		pm_runtime_use_autosuspend(dev->dev);
>   		pm_runtime_set_autosuspend_delay(dev->dev, 5000);
> +
>   		pm_runtime_allow(dev->dev);
> +
>   		pm_runtime_mark_last_busy(dev->dev);
>   		pm_runtime_put_autosuspend(dev->dev);
> +
> +		/*
> +		 * For runpm implemented via BACO, PMFW will handle the
> +		 * timing for BACO in and out:
> +		 *   - put ASIC into BACO state only when both video and
> +		 *     audio functions are in D3 state.
> +		 *   - pull ASIC out of BACO state when either video or
> +		 *     audio function is in D0 state.
> +		 * Also, at startup, PMFW assumes both functions are in
> +		 * D0 state.
> +		 *
> +		 * So if snd driver was loaded prior to amdgpu driver
> +		 * and audio function was put into D3 state behind PMFW's
> +		 * back, the BACO may not correctly kicks in and out.
> +		 *
> +		 * Via amdgpu_get_audio_func() below, the audio function
> +		 * is guarded to be in D0 correctly.
> +		 */

On a second look at the comments - should runpm _get on audio dev be 
done before doing device_init (so that it's in D0 while FW is getting 
loaded) and put done here?

Thanks,
Lijo

> +		if (amdgpu_device_supports_baco(dev) &&
> +		    !(adev->flags & AMD_IS_APU) &&
> +		    (adev->asic_type >= CHIP_NAVI10))
> +			amdgpu_get_audio_func(adev);
>   	}
>   
>   	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DRV_LOAD))
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
