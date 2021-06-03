Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B54C47082
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 11:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4063613D2
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 11:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4063613D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EB486E429;
	Thu,  3 Jun 2021 11:04:33 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2086.outbound.protection.outlook.com [40.107.96.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EB7B6E429
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 11:04:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WF1nbG1lDS42bALIyxisg76vyxFNsRrisWNtyN8OzBPo6Qu1h7WLYH5GiORoNZCLYbndkBh9GX9ii4I7c4CWd8Hmi0A+hUKdaWxHEtCULyvW3XQQT4I1DR4fvWcxeK1sKkMW/TweDHKRCIJHF1QymmZZwjq5vtxI8MjJHdC0eeKhmoHqBL+cUhtNAAbKgSI7Ulkodc4iOXzfBUUdVl/Jqn6f1PsTGqnVIOVQSAvPZA0iWyMsfEqQCs3C4cXINQ2qtEYh10x0VOuxfZ1aj4eyayFZY2PLSSqzniiT2frwheaxsYgIhpTehZBjIUZTWdFiPY6jyw5Cvw/OBcBJtidQLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iq6vsrzjbHyN6xV/tS4QzCgw3iS/mJ4ipA8dtE+QwsI=;
 b=Y2u1ZlYu5JeUy2IEUasmMRXYVCFlIdRrm+UMeH0S/JNGm+kerQYBTkQBqY1T8A0N0em8nWCYDehKNnRdaN+D7LphQvsYSbc72coJ4+jIdmt8l6S0az4wrDUMsFpQk6ArE54fhaRuHKgW65Hnjj5xnzXy0bP4UTqo8mYRI3Y3cG5l732yCoHpGPRfkXT2BQnUz2CZr5NgZCx6iYInjJ9pbwWWus8+zl/faT/ZE+V4aw6k3dm8jy7+NiEAOjuB62YCP0mDB2owSMLtqgqgrw5ysxa8q73Y3+EKrcQKRvMM4wHpBfV4KCXwPukL+PhflFvJI4Cl6eMzVGfSwyCy9tUqOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iq6vsrzjbHyN6xV/tS4QzCgw3iS/mJ4ipA8dtE+QwsI=;
 b=rk66X4lIm689mwKToQgf8j8IVdH9jQ3Zx5no8h16KddMlQhCxC2rrvbhthEmKkVLOzi6IkAfImuJxL3iTXN5m09SRHcxlVDcqGI6qsJZZ+A0M8qgPmYaZuwdqCjOst/QdHAVJo++N1AU73MTaf22eywGzUGkNkP36x+6Blm0oNU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5153.namprd12.prod.outlook.com (2603:10b6:610:b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Thu, 3 Jun
 2021 11:04:29 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9%3]) with mapi id 15.20.4195.024; Thu, 3 Jun 2021
 11:04:29 +0000
Subject: Re: [PATCH 4/5] drm/amd/pm: clear the cached dpm feature status
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210603045603.977998-1-evan.quan@amd.com>
 <20210603045603.977998-4-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <1a396a96-3c99-1e16-b170-75667c97ccfc@amd.com>
Date: Thu, 3 Jun 2021 16:34:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210603045603.977998-4-evan.quan@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: MAXPR0101CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::21) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.81.250] (165.204.159.242) by
 MAXPR0101CA0035.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Thu, 3 Jun 2021 11:04:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05d3f316-c4b0-4091-0c8a-08d9267f5be5
X-MS-TrafficTypeDiagnostic: CH0PR12MB5153:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB51539E16CA3E5BF90968A1D4973C9@CH0PR12MB5153.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c4zMDkrvQwQAWCkjZwoz8yYLOupAq/jl5XqFMCz5K47+BqBNFyVFzBp9djY+JU37fSApgfZer3g2fYaisSGCNglXy/n4jH53ZOQuZE+Ldagm4+DSV/1JmLRkYYdTpQL9ttERcFZdAbqMCmpqjqRcP0Id5pyyLgoA47yDzddZk4gkXHVpQY6H04Xc6D0+JiWsvbUNlNlIDyuEwY1Ze+nFhhXZm4+r6U+ugEdvasckpzRd1K4AQF4MSYF7y7+WkRhKvKY5hRTk91ernpiUFWLlnow/IH8F6ccDpqZ05UiXeyEETR+DkPw+DI0IvQAZwbEyhaM4zeF2FBiBEWtSIZaWOP+O6HlyzlK1Fhw814XCFh1vPrJAZDGqV5GIarGJY7AWZj3qCCl3tgWeYC/724XAX6Xj1bpwEdW9p54bDQuLai4fC/tQtVDNIa2rdL2D2VkSOFrifQoAn+qgb9yWfZNcgXFh9H/fb5O9DXKOCKSfhuTbqjZ4K91P8/cn7QCIo1GT11ta6PSoKIXg1aO99TulsINUYwPL44GUvGT77+aEtH7YpknMsMzPC5tpkbZtFNf3ONJp4vgIc7XKm2QcnhFBb/20V1N65nXuE3NbZ/2OrRbvQxAvLs/RZJ32y61yxEe/gFa+WGQv4ljQvm8BLyEwAl//mWaQHPz3I+GjA6pNGdaPcz+Ol5FoU8ZGdjb3J97O
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(38100700002)(16576012)(4326008)(26005)(8936002)(16526019)(478600001)(186003)(2906002)(316002)(83380400001)(53546011)(86362001)(66476007)(66556008)(66946007)(6486002)(6666004)(2616005)(31696002)(8676002)(956004)(36756003)(31686004)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N2E0aU5WZG42R0owcTQ1eDRmcUkwOTBJeXo5ZVlKYUJxamgvWjZTZnZyKzhZ?=
 =?utf-8?B?QlFsZDhMS0FIdE1VSUlONS85RmE0WS95NVRJc0VTZVFtT3JFREJWd0I4T1dB?=
 =?utf-8?B?aDZrZGs2YzdsemRuUUI4WGdmclNZZGhhUkRwVW9Sekk0dktrdmZBSEZ6SURu?=
 =?utf-8?B?TW5NR3d5S2c3REFaT05KdEI0UndHUUlTZ24yWTJlLzhhZVhJankxMTBxZVBB?=
 =?utf-8?B?ZjBsWTBLT2x0QW5pTllQUjRUNnE3bnYxakEvZzBxNmFLMENwbG5FZnhkM1hj?=
 =?utf-8?B?QmVhS1M1T2l6TUJ5eUNmUE9VTWFyNVlGUVI5MHEyZHRQRTExS25ia1pHSXN4?=
 =?utf-8?B?Y1lMTCtvUmJYOS9nb245SzRnUFRXc0kxaGhEaGpjeE5BUUZSRHZnWkhWRkI5?=
 =?utf-8?B?M1lsb1E0YjJnNW1OWW9xbXlBem9pZjhSNW9Vbm5aVkgwZm5TL0xTWWEydnB6?=
 =?utf-8?B?bXBZcmlTblJuTzRuTFIrekd2MjlETHRUc2ozS2JYckRwUURKcCtqRnNZQU1n?=
 =?utf-8?B?Ryt6ZHk0SVUzb1E3dWljR2tTNEk0OUlaZ1BxdXhmUjcxSzBUZTJQY1Ivaktk?=
 =?utf-8?B?MVlvMEd1N1Z6QXo0N0l1TFM3RGM5ZWlSV05aRlZSS2dXeDlvV3RxOVYxWmRH?=
 =?utf-8?B?Q21YVGUyQkF2NEMxQXlXcUk4bktUSXBqZU1MdXFHZXQ4SGIrTlBra2trQ2M0?=
 =?utf-8?B?aHhBVFVqVUdlZDRBK2VnNnNOZ3VrcmFjVmU2WmR4YllVV29yYTdpUm5XRWtU?=
 =?utf-8?B?R3d1VGdXdHpmcjVNajlRU1ZUR1l3MTZTL2VNdVlJSnBJeU8wSU5ta1ZiaEI2?=
 =?utf-8?B?ajNkUERvZTdCK2FaZzdkM0kxWHVYVUE2TWZvdnRid2dDZUpiR1Q1WE5pZkt2?=
 =?utf-8?B?bWV1QmlPSHJJUWFpZytvZHFuY1NvcUx2VmdLNmk2eDc2cUpST1AydHk2aERS?=
 =?utf-8?B?bitJWjVxVTBGblFBRTZucjF2VHBJek9CTmlJMXRXKysvWW50c2dRWjduRkJM?=
 =?utf-8?B?d3pOTFNmNSs1RWhycXZwOE42NVBhTFl5NE01aGVQaXo5eHZ5eU5tNWpod0Yv?=
 =?utf-8?B?eXVYV3AxODJqY0pwTmpoalFKczlTeitUekFPdkNlOEU1WlVIbDdFZENheEE5?=
 =?utf-8?B?Q0FFbEl0bDdabUZUa2V6eGNXaTJ1b3lYMGFhZ2xhMldlVldUeEpHbG9ndWw3?=
 =?utf-8?B?aGxOWnRlUVhHM2ZDTG9MNmU4YzZkcnpsL1FXcDZ5b3phbzlJaDdPeklQOTM4?=
 =?utf-8?B?eloxVzYvWGFIb1J6NTZaZDk0cEhBdlA0bnRqZG9KbEx2YXZUTEh6ZFpURFlS?=
 =?utf-8?B?OWpDSFdjVEZTY05PcHJhR2xKR3dhbDBGdmpxL2ZkMWhSV0x3d2pXRUNSdnJQ?=
 =?utf-8?B?bG1Zc2pFN1pESlFJSGFVNFBnK0lsd3grVGZUejNiOER6VnpqZHNWdlpvWVJj?=
 =?utf-8?B?ZmlLeU5DQUhaam5tcXJvRW9Vek5vU1hxSS9NWWIwUGpRdjg0RVlYMEtKR0xp?=
 =?utf-8?B?R3NTYTdiUzlQZ2M3N25RUkp3SXlseW9RTGVjZEVlS3JhczJacVVHVFlSdGNO?=
 =?utf-8?B?L2daNXBxemorWU9XSW9NZW1NUkx1czBqeFAxbUQxSm1vcGlReUk1OGVmMkNH?=
 =?utf-8?B?VVB2Rm10dGVabnZxajZZREdCd2hxZlNkS2tybW9ZVFAxdi9aL3hmWTNLc2VP?=
 =?utf-8?B?V3VGalJCM29NUnBzT3kxSm1Oc1d2Rjd0SEY0Qm5GenRSRGpiTWlka1VpdlAw?=
 =?utf-8?Q?sSpoVRsehzD3b7v3zi6iF6SGzD9zwhEQQqeyz0J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d3f316-c4b0-4091-0c8a-08d9267f5be5
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 11:04:29.6096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dp3twEXXHBdS/c2ig+Goe1dvnw+nHVB+9cy//UeQiwSNgHkl2gQV04TESlNr2Lno
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5153
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



On 6/3/2021 10:26 AM, Evan Quan wrote:
> For some ASICs, the real dpm feature disablement job is handled by
> PMFW during baco reset and custom pptable loading. Cached dpm feature
> status need to be cleared to pair that.
> 
> Change-Id: I9e37d80e13599833301c04711b097fb37c2e41f9
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index c9a31556e077..fd7b1b8edeb7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1352,6 +1352,16 @@ static int smu_hw_init(void *handle)
>   	return 0;
>   }
>   
> +static void smu_reset_cached_dpm_feature_status(struct smu_context *smu)
> +{
> +	struct smu_feature *feature = &smu->smu_feature;
> +
> +	mutex_lock(&feature->mutex);
> +	bitmap_zero(feature->enabled, feature->feature_num);
> +	bitmap_zero(feature->supported, feature->feature_num);

This will clear also clear the BACO feature status. Won't that affect 
using baco exit for runtime pm resume?

Thanks,
Lijo

> +	mutex_unlock(&feature->mutex);
> +}
> +
>   static int smu_disable_dpms(struct smu_context *smu)
>   {
>   	struct amdgpu_device *adev = smu->adev;
> @@ -1374,16 +1384,20 @@ static int smu_disable_dpms(struct smu_context *smu)
>   	 */
>   	if (smu->uploading_custom_pp_table &&
>   	    (adev->asic_type >= CHIP_NAVI10) &&
> -	    (adev->asic_type <= CHIP_DIMGREY_CAVEFISH))
> +	    (adev->asic_type <= CHIP_DIMGREY_CAVEFISH)) {
> +		smu_reset_cached_dpm_feature_status(smu);
>   		return 0;
> +	}
>   
>   	/*
>   	 * For Sienna_Cichlid, PMFW will handle the features disablement properly
>   	 * on BACO in. Driver involvement is unnecessary.
>   	 */
>   	if ((adev->asic_type == CHIP_SIENNA_CICHLID) &&
> -	     use_baco)
> +	     use_baco) {
> +		smu_reset_cached_dpm_feature_status(smu);
>   		return 0;
> +	}
>   
>   	/*
>   	 * For gpu reset, runpm and hibernation through BACO,
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
