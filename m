Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E1DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 06:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1D54AA421;
	Mon, 18 Jul 2022 06:58:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46A84AA421
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 06:57:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzaVbNL6lZvjTsiBFnrvAWAQVr2UPT/bnEvqxXKW9Cz05YxcJIzWwekvovXlp9YH3sbHU2Rer27+cD4Mf17DitAMrvSmREKnvKUNKEQjS97nV/39RpSoMvEDue3RuXvHEEpLAyKK9CsV6hyqXFktTvTOftwhWlYTqrPmMHbiJBnsTZVZwn9DyGfHysnz7qjKUajHVvz7ZG1jZ5lsfJUkGpuAeC15xgABu1OsJnjg9r2an9d9rqc4eDIz+b0jPeeUhPEJe0s1sU2e7j5Nitp3a2K1U7oEdkJikJsuSHPVBTvEMBB0fly9w2Wlmm5X67A2wBdvAiSDeLddXL8MQPc43Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z25lKUJdiYbDs40K9j/tuJJxAThEqUv8Vvhk7onH4Sg=;
 b=mURMtgwJaUGkqn7EDyzBsYOBTABbhbRVYNzJJ9O38Tj2w1XhxTu+Xo0DUQEsqwUSWwErvGXumxIJeusJnVdC2124rOg4a4yq8y8PJLZVikcI0uSzZsr+jrEz8Y9Xi3i+TFJN7X2newPwg9GdGuzXiJpMJiTYkFP6zMn3SsQ5o9xIig8VVsoArtNBnMyR9HhrChQnftgqw9C6k2oXQCyOm3vzeZMww09Bx2yzd5rEFdqPh03nej00W9s8ftBXkFWU5g93AeR9zVHtkhHq7Cm7xnVUqYbaOz/KF71nV9QoDr0S127PWTL9u02JOZwAq7M5tMJdkRKL0ZqAKp2Ib+tgiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z25lKUJdiYbDs40K9j/tuJJxAThEqUv8Vvhk7onH4Sg=;
 b=LfXXuvo2EcjPvHl7uLSm7EfeGrLiFnSyyZm9g0COSXpJ61kLu6cqbSWaajbtWK7iPqmL720AXE5WxGmqo6M4NzMMj4sAqYhdZdUm6nZO+L9QMCuRrKlp0zoTSM/P1Bzc0qJ6iqOe/3zwLannz1nc9570f6BW5ThPKTeZr4Op/YU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL0PR12MB2818.namprd12.prod.outlook.com (2603:10b6:208:37::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Mon, 18 Jul
 2022 06:57:57 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 06:57:56 +0000
Message-ID: <e2dbaab9-de5a-3180-13a8-cec2c8b0285d@amd.com>
Date: Mon, 18 Jul 2022 08:57:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4] drm/amdgpu: add HW_IP_VCN_UNIFIED type
Content-Language: en-US
To: Ruijing Dong <ruijing.dong@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220715200410.301438-1-ruijing.dong@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220715200410.301438-1-ruijing.dong@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::17) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2727462-6d1d-4fca-96bd-08da688ad7ec
X-MS-TrafficTypeDiagnostic: BL0PR12MB2818:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1bjOBTOXsTDcoZOnC0yHysDLoQsDCqcTwy6RKPYw/Hiv95hmHYUj+lEbRP1DRuev55p3JP3knbP0AS9QJwomNJU0VJ9USfQOZtEZKznlOD/PMX9Mw/5JvgN7F8pEsZ/4HAS4hPyUv8CC8BP7Dkqzo2l3fqpRe0EvL5zK3i+1OfZkg1sXyhCodKnv2JfJt/+YlLn3V+5e1/1z45yP1oLSjDX/PRFKKI4hiy0GV/J4TPJM4pOL0kMe6bd1h8MJpX8EA+4EZ5AenRmqiYm1+bmp41z+EpLSQ/3gtHnybUu9KSVoAfaC5pBxjwkq2ZD9r413r8U2K+gSKRefGt5vseK3qRjGnBu5yX1jqAkN7S5cSBucO5VaW+OsLRv6raIliQ5FRFfxqnzgHQXAWPHUDfPdTwF6PXyLhTVZDugr2ttI9rOfpP+O23wTpcFveT29GuE1Uqa7smHauh2CFdShhp/rzj9UpdV2iFa9awSI7teV2+/PoS6q1HoPHAIZtaT9ZXvqmZjXQt570sMN1O/lPApJDTjm6/O6WTF3OgW81HEGq1Nv1JT6zhxI7zdJP2hwdcbjjVt+fdC6d7JDjlrPb6UgYEJQZAUcAhtaGeTMviQONWa+PhZledLvfZP8VswssIYAil/ae3CxB1nxBU+2ECfSnvLwU4UR2vM2cUTlFBxfqBsaHK7ige5KHjuqmja4F7q9A7+a2yJD+f4xSb1/DhOs9pe9M3EjG4yyRV9F+8aY0hH0FbwtVyCpfBtPSJyXesvdqGFubHz5GR4/WFspm9ugeMqI01zQKQeokYT22bLAvF4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(2616005)(6512007)(5660300002)(86362001)(6486002)(8936002)(6506007)(478600001)(41300700001)(31696002)(2906002)(4326008)(83380400001)(186003)(966005)(66556008)(36756003)(31686004)(66476007)(8676002)(316002)(66946007)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEdLbkJmMGZNN2ZmQ09GZW9XcWw4RlJheTQ2TDlXV0U3Qmg5Z2M5NGFMRTFC?=
 =?utf-8?B?UWZLTU1mbERKbm5PT1VhVFlQVnJoemRDMENodUFxOXdPa2R2U2J3eWhFblJo?=
 =?utf-8?B?Vk1GZzFuSWo4cHNYQW00TlQ1dkVMZ3lmV0ZsR0s3bXorNXI4NUdDNGU2RFF3?=
 =?utf-8?B?UkkwSGJxaGl6eVNtaE92NTV3ZEVEcEs0QkQwY04xbmxhVUdWN2dodE9GbFpG?=
 =?utf-8?B?KzExRVNBV2lLdzIwYkVXdjB0c3Urbm9SOXZ0eUZLaGRKb05JdS9IM3lyYnZT?=
 =?utf-8?B?SndJMjVlTmkwTHBic3RyQzA5c3lmWUxUcXgweWJHUlNJWmtRNUUxZG5JUGp0?=
 =?utf-8?B?Q1dpV0QrSXhISnYzK1FGNHlBUWFUbGV1Tk5veWJYekFMSWc1OXpYYm1kSnEv?=
 =?utf-8?B?TzZTZnk5RkNoenQ0NTJaM0xSc2dBcmM1N0Y1RjdWamt3dmRxYm4yR3NBaVQv?=
 =?utf-8?B?WkNZMFBYaUJiZ0RETGJzY3lrNGxtc1F1N1lYR3RiZFNERUoxNzRWczhRNDRG?=
 =?utf-8?B?YWxHY0VjL2tDejdyWUUzZ2N3R1hQSXFXRllUZlBEY0pFRzBCV1JPRFJOV1pv?=
 =?utf-8?B?Zmh6NDl4aDAzaUlhTk1aSVRlb25IbXZSNVhQUGZJYkp6TjRVa1Bvd0pGdTh6?=
 =?utf-8?B?UC93VlV6Zm8vcWs1YUdSbXRBOXhlczZvaVh3Z1l0bHNxUGRZbHNlZjhCNFM1?=
 =?utf-8?B?NVBWeDE0eTVvVDFyVGNQdGlxMFZlTVp5VHErSlBHSWhTbHcvd2hqZUFlVjVj?=
 =?utf-8?B?U243dGV5TGRDWmo0ZlJTZ29jOVFEUmtqVHg5TEV4UWI5N09wa09kSS9BQzZD?=
 =?utf-8?B?VzlHanZxdE5tWmtzSndFcFllNjRabHZNTzg2YVdNRk1oUVlHSktzMVNISmFG?=
 =?utf-8?B?d1QwKzA2WGNTMmMwT0NicHhjNStITno4RHRadHdHaTFNMlI2WVZpK0dnTVQv?=
 =?utf-8?B?OXZPVHBKR2cvSDRYaDljdTRnencrUDI2cGdnR2ZERlZPYXFldUxCZXIrOFp1?=
 =?utf-8?B?dHlVZ2NsZEV1VWc1QlVOLzZnOExZdGVNTVp1ZkprK283NzgzV3RMV3Z0SVVk?=
 =?utf-8?B?WXV0U0lqRVNLNFpMUnoyTHNSL1kveFI4WHpYNG9rbVk2WUVjdjRrOHR0bkx6?=
 =?utf-8?B?VUU1d09pYWxuVGJKWko3WXM5ZE10eDMrclhGNmprdXJhTDF3OTlaZGo0NlhN?=
 =?utf-8?B?bjNFWmlxQk8ydG5ucTZicGtRcmNFYWpUZHI3NzllSElRS1VuRHlGVEtWRWRR?=
 =?utf-8?B?ek1FWkNOQlhySVNBZDJIbURGbENrUjhjYnd1dklqSWE1Y2gzOVRZTnYzU2xJ?=
 =?utf-8?B?bm9naXVVQVp4dDRKa2kyZ283MmQ0TkRsMDRnNlZnZHpWdy9pRHdKYmk4Y3lM?=
 =?utf-8?B?dlB1bkZ3SnlyUGtSRWtyekw0R1lldGxyWTJLN20xV0tCb1I5NDg3UXh6cTF0?=
 =?utf-8?B?VVdpdzZrOHBVaWRRa0Y0MnNEcEozZ2ZycU9vblRwR2EzTERQaWhYNDFpRzhw?=
 =?utf-8?B?VmM5YjU4SG91YzR3cTRMYXpkajJsNWdXb0FlWnc5RzRNaS81eERHU0hnYmRS?=
 =?utf-8?B?U2tLNXdUT1NUVVJDSGhJVkhRQzZsWHpjOHk1ZzBhTDBwNmF5bHdaSk5Xc25i?=
 =?utf-8?B?bmF2NGgwZktFTTRHaHE5OVQ5TDI4eldDcE1EOEIxV3ZOQjFuU29NbTZwZStI?=
 =?utf-8?B?WExLdWpqUlc5UEdiNjNsMUhya2d4UnUwTDQ0UXVrT21Oa2gwTWtWT0dwMkhC?=
 =?utf-8?B?anhkTDU3MEE5U1FuT2ZaQ0NWZ0FudmdlNVRnbmxyendhQmxxb1YvMFZwNVpL?=
 =?utf-8?B?YkJ2WG9vbkF2RlcvWFZ5V1V4TWcyVThNYUxJWFI1OWNFc0twUzJGdU8rQyth?=
 =?utf-8?B?M08rb0pXUDh6ZmFSREdPczl0dzMwZVZyT3BUYkRESnd5eVRNa0xhVWF4SUV1?=
 =?utf-8?B?dnNnY05VL0l6SmFSOWdVVUZNOTZXM3Jsbnp0U0QrTjR3RXYxeVVLY1dQaEgz?=
 =?utf-8?B?RGJvQzFLblQyZ05lUG1CbmxUdjVReHBPTkVUOHJzRDRleXl2em5xeGRXYVdq?=
 =?utf-8?B?c1JJT2dGczREQlorVGhxMmMwL3hZMS9BazVwZnNOVENHWmFxMkd0QXhTeDBB?=
 =?utf-8?B?ZkxCYkNXbFo3aFVma2t3Vys1R1lxc1dzQ1MreFIrME5OVHhiOVVqVVdVVG16?=
 =?utf-8?Q?kn9Vv5elA2sZMWVAa1ZEG/X2Mlbj0r9rg1pXvWrXz4QO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2727462-6d1d-4fca-96bd-08da688ad7ec
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 06:57:56.6072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+Hgrgr5RmJTwUDvDdscztC7WxhIimfR1G2umZtSnTFt8eWYVvuteZ7YmxHmcGcU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2818
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
Cc: alexander.deucher@amd.com, leo.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.07.22 um 22:04 schrieb Ruijing Dong:
>  From VCN4, AMDGPU_HW_IP_VCN_UNIFIED is used to support
> both encoding and decoding jobs, it re-uses the same
> queue number of AMDGPU_HW_IP_VCN_ENC.
>
> link: https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/245/commits
>
> Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
> ---
>   include/uapi/drm/amdgpu_drm.h | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 18d3246d636e..e268cd3cdb12 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -560,6 +560,12 @@ struct drm_amdgpu_gem_va {
>   #define AMDGPU_HW_IP_UVD_ENC      5
>   #define AMDGPU_HW_IP_VCN_DEC      6
>   #define AMDGPU_HW_IP_VCN_ENC      7
> +/**

Please don't use "/**" here, that is badly formated for a kerneldoc comment.

> + * From VCN4, AMDGPU_HW_IP_VCN_UNIFIED is used to support
> + * both encoding and decoding jobs, it re-uses the same
> + * queue number of AMDGPU_HW_IP_VCN_ENC.
> + */
> +#define AMDGPU_HW_IP_VCN_UNIFIED  AMDGPU_HW_IP_VCN_ENC

I'm still in doubt that adding another define with the same value as 
AMDGPU_HW_IP_VCN_ENC is a good idea.

Instead we should just add the comment to AMDGPU_HW_IP_VCN_ENC.

Regards,
Christian.

>   #define AMDGPU_HW_IP_VCN_JPEG     8
>   #define AMDGPU_HW_IP_NUM          9
>   

