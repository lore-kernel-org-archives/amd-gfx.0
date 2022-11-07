Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989EFC4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Nov 2022 09:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90F3B10E07E;
	Mon,  7 Nov 2022 09:15:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1296810E11E
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Nov 2022 09:15:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Th1eSvzzMEyWz4X9kKrx+JRQuU2Ds/fe2sGijY+fOcs0Mfaovd5IkFCPN1RaxtG2iRYOyun+h9ZeJJHvReuo8yAcEzWqHkk0l1j3GoSAMRpkbRTG26rOK7gShxrHy1nuEqPqce7kUjrFMYUYxCHwCGY/01Q/aLgqVAgvGzKnb3NrZ0EIUQ2OuKntSiytCWBIytYgtU+B8lruRnnm1AHvlk/yREvVf7ZtrDZEAP45oBoIviE2M6U5G/4lI+1U/b/n88qzF6+VDDbk41VN+B0BslOJonU2cEIj3aG/OgvBvcGeNZm1OLpEGzNq/3Q/d67OhLtGfj38/hvDejV2avwXLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cboQxITZVDzgQnPRR+gM7Cv9LNxDCUK0xDMDLYpSDzk=;
 b=Y5fnkq6mG0g+gmaEg2B3kVZA6Mk33+xG92oiiWXkyqefhBSEbWybs3+E3ev9i+RIDUNhhJcAmhCz5d/6Rh2hHJZ6F19dvLYHoJFrw3INoPFMtQSRxVifljjc0+pZ4Ws5xtvwhvBQhnE3/yk5WWUIqDebjjACEcDvFqG3uVoLdQIhFVOV3iCuBLxFu1qLSVzdF3gGl4SAfkj/ghId6J78O4m0VHtnYelitbVSbezdKutrKKcOGZNveME7O77YkUWO7pbQ8L7TNlI2FIRPdFxMcTL2O9lLIfXvpYz+l/lG5sDYvr5pE+4OK95OaS5vn0v0AKpjSihb0nmPlsnd4heonA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cboQxITZVDzgQnPRR+gM7Cv9LNxDCUK0xDMDLYpSDzk=;
 b=ZaqpQIMx3eyLfyRRyKivVZmZJF58tJTnGzIshEFqjEfEpA1LwcAYW9BK2wSyomDHUkPtbwoYbOqnuKYdTO6ga2ykHu/wC9X/KcXmsyNU5rNBnTFIC/YIjW34rmB5o7/zQ9Q39gscEUuut1pU0YPDK/Mk4ZWFMAJlL+6p4mk2p9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CH0PR12MB5074.namprd12.prod.outlook.com (2603:10b6:610:e1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 09:15:30 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::992b:b2b:80dc:86cc]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::992b:b2b:80dc:86cc%4]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 09:15:29 +0000
Message-ID: <61daa052-8c49-92b5-e805-ddbf0eeec90d@amd.com>
Date: Mon, 7 Nov 2022 14:45:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: disable BACO on special BEIGE_GOBY card
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, hawking.zhang@amd.com, evan.quan@amd.com
References: <20221107084942.1065293-1-guchun.chen@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20221107084942.1065293-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::8) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|CH0PR12MB5074:EE_
X-MS-Office365-Filtering-Correlation-Id: 07cd2779-1235-4b6e-a7ab-08dac0a09d6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8OlcdVEVyxJv6BjVXfjOYZB8T++OjVccYehS/iaEnGCQX2vQauS0VDG7w1Qibu71B/fnJMgh1eFtDGTxY1wDUnAwlEFyBZ5OK2/VfLWyLPFXiZKfG671uZg5t6b1n/jaqOyaWcRywmIprXNEey3wFw+jp2f9GRTOhOILpV1Hw+sIT2hjP6ycFLmzESijbTKo1E0zg7zLK4d3kbKCaIf+T9c5O5c6f2MN33gWyu1AEgXMNSJiFoJMFLhbAwLfkhhZcYXwPPN8Zz9jJgdDkBzVSdinyLARYOVjTEkLbqImNfhO6ZWbmt1RNqB70vdqC2HErXZHGdlwtKHxwbw9nh37ywBj/pyIkj9WfZDgl3rfCZ6LgJ/gHOz4LRgpzGt5WKLydU5K9qo4nQSj7qAvazo0tUgiN9bdtF45asmmuMiRfYESYwOrhRtUEPcCqFrk84KyFB/o4JYgscBL0qO/EOCI8GkIuVGDeTUcBVB+Y0paCaQ/K2rcHYbqoZSW2pMxlp7c3dJjg0jCCUU+SCRJWwjlMYjXoJg6rB/MHOylb6VeS1WmzdwN1DUOD3WKvl0v4J8flwrparTBVBqwDxs9bj/w9KJ6eCs5CKeHNLGp+5Q7wS8U4qTGeU26iLVbTQNStKRV1LRHEu/Z1/27TK+f53lX7u/eNAaPM2dqYoIU7DfFt8EW0f3PC6cXHb6CLDUqRWXggydV5F3KR261/ioN9j2xLacFvOYZl76RAn4HALHNbL16HD/NsOJaLIg3x0Tmu1C8bC4QHfMYj46qj6KIGivCOrXu0dpLmgNjC49373DEx4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199015)(53546011)(6666004)(6506007)(2616005)(26005)(186003)(6512007)(38100700002)(83380400001)(2906002)(5660300002)(478600001)(6636002)(6486002)(316002)(41300700001)(8936002)(8676002)(66556008)(66476007)(66946007)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm5qQXZ5SWt1YzlMSnFNajVUSldyQlljWnN0ck5YdXlQcjlPQnlyQitRbU5V?=
 =?utf-8?B?b2M3a0M3OXVjUGdXb0xZdzJTbjhRc0xPMk1SQ2kyMDNCTE1OM3I0MEJFS3B1?=
 =?utf-8?B?WWg2ZXlvMVJFSVJES0IxdVd0Tk04NjBIelFVSHlMVCtJY214RnZRLzlYdTVw?=
 =?utf-8?B?MHpOSFpxamlHY3RJVVpCYVpoTGsxa282THdYbitKK212Vm54UHM4NENCQnRP?=
 =?utf-8?B?Q211Z0cvY3IzSjR1akhyNzNLeDZuTUZpdHZUNy92U0MvT21rcHFkMkd5Vzdn?=
 =?utf-8?B?MElCQjBUamVxVG5jeDIzclA1dDVvZTRYVEd5b1pxYUVMdVAxQytObnJQSDlK?=
 =?utf-8?B?QXhZNFVzVDg5eVpralRic2lHZHpyd1BHWldRMmNmclNCaWcwc3BTUnJrd0Qr?=
 =?utf-8?B?cnJWcGNQTlYwTlRrUlczcUozY2ZVUU1sbE1GODVOSWJ4UDdNYmVJSEpQWmJq?=
 =?utf-8?B?ZFJBbWc1M0trVzNSMHZ4OThLK2NleG9yYlBjSUxTQ25paVQ0dEtoYlBMUm9X?=
 =?utf-8?B?ZkF4TVlJQnJSTDdnaWhyZ1Faa2J5Z2dRZzRtYVlHdHd5R0hXMlRiV3lDYURF?=
 =?utf-8?B?QzA1VTBpRGxLZVNiWDdGdzdNV1NmZVRua3pURGZ6WlFRNHBIczY3b2ZhUEQ1?=
 =?utf-8?B?Y0dRSVV4K3EyUVdING1zZFpJWFg0SVE4WXZOM05QYUxVT0Y3OFB6UUhpcHpY?=
 =?utf-8?B?dkxCWjYzb0dXYkNBNlRjTGZLMnpIWW5uenVQUytnVCtrM0d2NlgyN290aFk0?=
 =?utf-8?B?YkRVSWs1Y1cvYzl4K1lsVVZqRXp4Ly9sTGFBMXA4bllKaEk5TXRhN1VBQnJE?=
 =?utf-8?B?QmxJV3JQMEpNbVR1WTVJSjU0bnhMZG9GNVBOSlRzYWpJNXNuWVloYXpQaHlU?=
 =?utf-8?B?cW4rQ3h1a1YwRDRwOVZiQVRiYzRtY3RUSVlwSXNsVUpGZ3k2K3ZqZFI4MTJi?=
 =?utf-8?B?SEdpMm5KaFZDK2tmNzR3Nkp4S1h1OTFLZHA2T0tPU2hralVFV3RDNDgwOU1F?=
 =?utf-8?B?NnJtTnMxMkF6V0pVZU9VYUFHM1BROWN5NFJ6RWxNR2ZrTXNkbDk4dy9NMHZ1?=
 =?utf-8?B?NTBDSml6NjJvczNTVmdrV1ZWalpXUGV0UFpSNVduUzRMM1NWSmJoMldpazJk?=
 =?utf-8?B?Y041NWpudkkwcFpkMUVkRkY5K1A1QlZTcUpoU256OXJyZnRUVUYrTVFpcHdI?=
 =?utf-8?B?Q1FlZzdCRXBIczk2bGY2V1V1NlRSNmI4a1UrMkl6SEFlVGZocnJpaEZIZ2tJ?=
 =?utf-8?B?ZDBFOW1SS2E0MFFjZjV2Umx5UW5RMkowcDRkOFlHVjBmZEpOWktFSGpWbm41?=
 =?utf-8?B?ZEthWUxwb25NNTJmSStvZDBGOXA0b0lwRk1zdWcrMHZEUHlzM2VyTUliOXBV?=
 =?utf-8?B?cnY2T0l2L2k5Vmh5MGJwTVZXbXpyeEJNTEF5T0ZySWF4bkg0Z2hWT1N0L2hr?=
 =?utf-8?B?L01aSmEzY2JmWGxkUnE5VHhYV2FqbkRZVGdxY1Qrek9TbmZQRFJQYlF5V0JE?=
 =?utf-8?B?akc2TFExaEppSk9JUnFhQmdSQXVUWi9xSk1zSjJUZVlHdFhxb05tN2lxUlRX?=
 =?utf-8?B?ZEhPME1oemdQQmczVURSRU5Sa09jU3FKa2xhS3lCT0lISDR4M1k3RGtsQitN?=
 =?utf-8?B?SllpUXNyUEVMY3FhUG5wc3NybUx4bFBuZjdQUGVub2dDMzhYWHVqSXhqRWMy?=
 =?utf-8?B?UnpUUzJ1ZkZ1ZkFYK0xHTHp6NTJZMEE2UThLYnlpb0d3YW1hSFNGZWRQVHV5?=
 =?utf-8?B?ZE9QRUo3S284T2prTjM5QXMyV0F4L2RkWWFSMXJ3WlVIWFBDTnJ1aWdxVzBp?=
 =?utf-8?B?Q0ttZzR1Mk5YYzFIRFBvYU8wVUw0TTRjM1A5L2srNk92bXQyR3h5VUlkY2xi?=
 =?utf-8?B?NVZ6YlhUSmplTGtsTlB1T0cyUFNEejVvcVVJdDlBUkpoUTVIZ0NsdUFRSVg2?=
 =?utf-8?B?ZEc1YXJPY3VTNVZiSGQ1aGRaZmc0N1l6d2J4QWtYdlptSFN6UjY1aHN1Q2w0?=
 =?utf-8?B?MmJ2cEphM0xwcUFqbEp6WnBzcTdrZWdsN3h2VmtBTTk4OW50UVpKMkpkMVlO?=
 =?utf-8?B?TjJXKzkrRzdZSDh4bFFQSVhYQVN2aHliQTk2VlFoZFVleFowM2MzY0dWcnht?=
 =?utf-8?Q?5kRci74HPlG4PwPej8mmhfsVL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cd2779-1235-4b6e-a7ab-08dac0a09d6d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 09:15:29.8605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMUs26ekJ5UW+bmdadfQSguNJ2yPHz/ay39x0dC8sDZx6oTqbXUrKYtSkyPV+oOo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5074
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



On 11/7/2022 2:19 PM, Guchun Chen wrote:
> Still avoid intermittent failure.
> 
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 74996a8fb671..c9e0be9bb180 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -377,7 +377,9 @@ static void sienna_cichlid_check_bxco_support(struct smu_context *smu)
>   		if (((adev->pdev->device == 0x73A1) &&
>   		    (adev->pdev->revision == 0x00)) ||
>   		    ((adev->pdev->device == 0x73BF) &&
> -		    (adev->pdev->revision == 0xCF)))
> +		    (adev->pdev->revision == 0xCF)) ||
> +		    ((adev->pdev->device == 0x7422) &&
> +                    (adev->pdev->revision == 0x00)))
>   			smu_baco->platform_support = false;
>   
>   	}
