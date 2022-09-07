Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D28C38145
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 12:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D744810E74F;
	Wed,  7 Sep 2022 12:49:20 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35E8710E74F
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 12:49:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfk9wGPK7NPYXDBKCtgXeF/A27AJo/w/ChGozTvZokGu5B91XzWgxCFGWaZG3bqin+l1kaX854qAoF0AdzZUo2aT7w41EpbBNAFZ7jqzOaHIbE+HbOtw4Ht9UFZNOylJ06DNrWHtHG6llfV28pcclUvaZoWvoSCBvBBX5x/470BL81EF26yZPVD1ocqzEum105bSOTUI+JMSbI6feFKDD2K9ofkBMHSdXgQoskPibA/HYp7hmjgXpqUOflPVUmM3WNIH3eWCgNOQfoGfcBM3g99ac/ZaAF38Ss4JJVFtWO1icJOterCCCeNF4483HLXRr6fM+kSy5ISjKmBqXmX22w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAAOUkwnvNKxcJE4MWcVfd/6m6iso0dwmNU9/yz2XV4=;
 b=TmuvyMXEpM/G8TPyScGCOyd2EUOqKPcWtcj+OzX3JHngftBdHdXAl5qLVu/Ty+466Pz6Q8G1pH2ljHc4XYezNhO9eJT/DVxgzcXVDHCorWBqXAfVmtcE5Uzz86KPDGEjb1Us9bh1iX/EGDMXC9v/QRUCj3GEltpRR9DCa0pIbxks7eyw2UGeHZtsHKogWzVOccdMo3WjPLMa0uQRh8sJQDZAy3CqIG6FQHwWZfUQpw+HScSDUzAK36i3bG/b/Z2AtkVoIXj4feCyFWkpaBfKbjpGi6kaDk4KJSdG+OqVPjf1TM3H/2NgjFyWq7lldK3t8bPmH8+ADjBZyD7E7yssOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAAOUkwnvNKxcJE4MWcVfd/6m6iso0dwmNU9/yz2XV4=;
 b=QnNVyIlcweoiFDmoHKsAyATPwuv4PXVzG0CB8z0rhO0jT7BDMvrPvZvGYkuvOB/6OBoQBB25uw4RIwW3/Prvaa0yiWkRqh2IAyvhjw3/E7M9CVc2KCSCI4bbIJsd3r/MBOUDnJYGbZmeHgPRaR3LQZmjWIk9BDVqFZfLNMfZ6oE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH7PR12MB6537.namprd12.prod.outlook.com (2603:10b6:510:1f2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Wed, 7 Sep
 2022 12:49:14 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2925:100a:f0b9:9ad8]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2925:100a:f0b9:9ad8%3]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 12:49:14 +0000
Message-ID: <9812750e-29cd-ef4f-eafe-ccbbc46187ff@amd.com>
Date: Wed, 7 Sep 2022 18:19:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: disable BACO entry/exit completely on several
 sienna cichlid cards
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, hawking.zhang@amd.com, evan.quan@amd.com,
 kenneth.feng@amd.com
References: <20220907123348.2958910-1-guchun.chen@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220907123348.2958910-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::14) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|PH7PR12MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f408a8-9844-410f-2074-08da90cf5e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: je9C8arVBssuObOkgd3eLZCHzNy70JJLUARa1OpeH62hhSUa1++i4LgfJ+D5l5cgjk5M1QyLusFP/qIKn0jjyyrbCdH2PnKgX3Rae/CwKM/osjLuP7VP4B7Ae2uahcvAgWgU/6QIQBB/bd07xuCbB4ks83T1ElzsDnQ83cYGl/80MIYso6Ofj7FS8AgvoRUMvJkqCP0nSRo7+x+0NKieRE2AypzCyMHeGm0AcfpPBjkhpWSJl73ZC21iGz3UYjAXdL/VYnqXp8N/OtUIHY3v3+n4AKBftYiRBp4gHShL0rPX1YJsyXyauvwUvr7lSIJazW6tGdzMXGxLJOkc1dmyp4zwtlPE74v5om6bKCGG9yJ4mfXX7qn50uQRZIDZ6S+m5QtZd4kl/plSeNdiugymvyvSoRoH6gMyQOxH+s1Jn+jAJwMLGvxA3jLvQ1LfjBNglYodsABFjKbRYX4LRqywcYfFDeW8RhQl2i2yZ5QgGSAP2ID6pDy6en+Yk5hcRggdDArzRfYS6QE51P5yVt2ZlVIjIXARItXslauLJbC0uCoX75wFY1PnO+oSGCph8eUzZRs4ZV2bDNtMlREGTlfURCNcxIt8Ozqg9FPmWK8mdVH2bG8pSODyAgRAByahqTUF//D8KfV3kJ5U6cB8dDFfNMhrOLkB7+2a6tvmc/E2vgBGBd/KesDhpCkWDjJx5iMr29NKNz95nY7tlAmODzB4WJYee206rMAVR45NYFsp+3g1bjAP9JKDWHiTJnMrxXp2dV2y7Y/EaXtPatKOAg8VJgHwBZ4FkphZQ5zrUwisAdQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(6486002)(38100700002)(478600001)(8936002)(2906002)(5660300002)(31686004)(2616005)(6636002)(36756003)(66476007)(66556008)(66946007)(316002)(31696002)(6506007)(6512007)(86362001)(8676002)(53546011)(186003)(83380400001)(6666004)(26005)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czRmSU9PdStFU2Q4bWR4TjlGMWljWXRzMlc0ZzNSd0RJUVVlYzdmRE5WUWVT?=
 =?utf-8?B?NlNUWVI1a1dpNmZsK3JaNjhDOHh1VkF5eEJrZVkvWmVwOUhmYzFpZXloL29J?=
 =?utf-8?B?NHdBTjZ2ZHdNekFJdm55OGdSUDdTUlJIR2ZTQ3NWMllxamdzWEJva0FMQzRu?=
 =?utf-8?B?V2prUjc5RE0wVEwzR0FqSkJrd0RYSGNVTTliMmlldGFiamFxUlo4ZE1abERx?=
 =?utf-8?B?SThFRGFTd0ZxTjU2b2dNNVkyeXg0QWRPcjZFSGQrVjJiaHJlN0RibDVCcW9a?=
 =?utf-8?B?bmtvdzBWa2gwYjhVRXlqeUFZMEt5ZE9JMzNOMXhJeGJNK1RnUGl5djN0M2pu?=
 =?utf-8?B?a3lVcXF6T05qd1hxMWdOOW5nOWxDUXorMFNUVG13d2tnR21GZUw0aUVkSkJU?=
 =?utf-8?B?YUxnOXlGYmZidGVmVThZRm9PMVVEejB2U05OZENZWWhnU2diVUZFZmVjRkJv?=
 =?utf-8?B?V3N3eFBSMkNZdkFsZEtTWFdMN3JkbThBRFcrZS9xS2g3U3ppdVBhbTBwNlRQ?=
 =?utf-8?B?SVBTVkhDSWpQMVBwRjh1MENPVTN6R3lBajM0L1VwRXN0MzkzdlR0K21qVmls?=
 =?utf-8?B?V1ROOVovVVdkcFE3QkhINmVEUjZsSEZsTVhKakQ1WEw1MWFVajlsTkxTa3pJ?=
 =?utf-8?B?cjJPbVNwSWJHalY2K3k0WmNTRm1NRENaYXR3U2xCYWNYZml2bjArdklmVWt6?=
 =?utf-8?B?ZFdXbFNSRVB1RVdoVEQ2Ukd5NmQ0SUVXNlZDMDlzWjNoV3BxNTN0ejJYQlJI?=
 =?utf-8?B?Q1JCcGNHcVhnTjZNc0dDWi9OcUh3UER0azlneG9hRkpRcEpDZFlHRm5pNXAx?=
 =?utf-8?B?N2NqSkJkWGdzeFBlVG5EUVNhbjB1NXZ0WXY5VVFNTXpNRE9zSXIyb0ZTa2hM?=
 =?utf-8?B?WTk5SnJTTUY0R1JJVzB3OUFMNjgxWGJsdVcreVJCVzRmSkV0UVBGcU5SZEFh?=
 =?utf-8?B?Y3l5UFRrRStWMzN1NWxDbjhmYVprL0IxaHl0dDVOUVFmZGZOaUhWajJkcjcw?=
 =?utf-8?B?OE5GaXVPTEZ0Q1Jadk93N0RFZkxZODBKSlJUUmNZZVM0ZldkUkZDMldSZVNt?=
 =?utf-8?B?THVZL09YMVBrcUozbVVIazNqOWRRZFVyUTlTNVpRS0V3cFpjUS9HWUVoMkxY?=
 =?utf-8?B?aFdJK1UxWEJpY2I2U1ZrZkFqQTFxTHoxN1ZIZmNjWkpoT3MxcXlaT2Q1alJB?=
 =?utf-8?B?ZDVnTHlxU1p6a3NWRDJrWk4wcTU0UUg1SXZkb3RYVkkxSS9kNTN2T0ZOZ05z?=
 =?utf-8?B?elZDQnZ3Qm5EWXZYV2J6azc0V0FvaEFQZnZRRFlmSnQ4TXVtSmxWZDE2UUtO?=
 =?utf-8?B?VGMxYUFNeEpVRThXMnNzeCtHVC94UHdRNVp3Nk1CaVVjSFpheHlWVzBob1Na?=
 =?utf-8?B?YlBTUFVYY1kxY0o2OUU4VnFlbkE4S2dKdzBBcHZoNmp5TG5rOE92cTFXQmJR?=
 =?utf-8?B?TjBsa25SMDhoQ205T2J6Q3IzKzdXSkxTRXdjYUlNZnlXTDQvYks3Z0NvVzBz?=
 =?utf-8?B?eUJnNHdwU0YvTmk3WjNDOHVZandOeE9LRUN3cnBwSVZ6QlluK3dMa1gvdEwz?=
 =?utf-8?B?SFhXSmJVU0REb1ZXQVZhQTJja1J3WWhWdmptekFmLzM4NUZmb3JyV2ZCRFFB?=
 =?utf-8?B?ZEF3ZTN1OUU0V1NCNTl2RVM1V2x4WHNFNnlIRUdHOVAzSyswL1lrckRQanVD?=
 =?utf-8?B?dGVZWkpiOFpRTk9GcE51eGgybFJhQVZ0OUhmcFZ6bjZQcThHbVpxUmVyVCtY?=
 =?utf-8?B?d3IzZC8xaXJLR2I1T3JGemRhZGxPZU5IbnUzUTBGZk1mNVI5ektqSlRtQmZq?=
 =?utf-8?B?c0NsZkpTekRaazBlVnAySFp2cnk3TllsVEpjSHl3ZS9ZUGNlRHhuenVFNDhu?=
 =?utf-8?B?NkYrb05PVTJHMy9LZG11d091TTFZM0FhSGhCQ21QR3hIblg2aWRCRmpaR1JR?=
 =?utf-8?B?bkdaWHU4Y3dtMGcxRFlvM1pwZk8yTDZtNlpKaGFmay9sNG9yVjhtMHJPQjFT?=
 =?utf-8?B?dTg4NjZxa1ZxT05mMlYzemMvZ3lPUzZKWkdiN1dJRmRHajVuTG5xOHhMa0Ro?=
 =?utf-8?B?Mjg0Y1lZelpscEdxM3Y0V1p1YWdBUTBJeWNJNjkzRy9TWUdQYy9CUkIzYTF2?=
 =?utf-8?Q?gWcM7qplubhByNctN20sUW3WP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f408a8-9844-410f-2074-08da90cf5e59
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 12:49:14.5625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gz/TJmCRIZyQAY1uJHU0PrjJeokbZicOhWB/1u8kFLbm1BmGyTl41BBpsMUdUg3v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6537
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



On 9/7/2022 6:03 PM, Guchun Chen wrote:
> To avoid hardware intermittent failures.
> 
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 7ed4d4265797..74996a8fb671 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -369,6 +369,17 @@ static void sienna_cichlid_check_bxco_support(struct smu_context *smu)
>   		smu_baco->platform_support =
>   			(val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true :
>   									false;
> +
> +		/*
> +		 * Disable BACO entry/exit completely on below SKUs to
> +		 * avoid hardware intermittent failures.
> +		 */
> +		if (((adev->pdev->device == 0x73A1) &&
> +		    (adev->pdev->revision == 0x00)) ||
> +		    ((adev->pdev->device == 0x73BF) &&
> +		    (adev->pdev->revision == 0xCF)))
> +			smu_baco->platform_support = false;
> +
>   	}
>   }
>   
> 
