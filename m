Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B59C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 07:56:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9267311B533;
	Mon, 10 Jan 2022 07:56:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C838B11A6F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 07:56:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YM8lhrOtVYv6+vhMQ+N7vJU0vGLtOZa4OBChOGuZPdepaxGvy/L51fj7bGrBJmPYrULtwXpUujgASaTLPj8m6EzeTOhoGGAaAgWGduRm2g5nwczyQcp3sXzNG9PpybQkQOa6nLkq6fDYfbo4UnRudbDIYX8TW9iVEZrb36Yhh62jDCoV0fQ9qP6/vj/THHFZe3NLf9WAoPHc6mUH7jAh6tmX5e2vYWnBt5aRmytPEJJkLVyMK34Sn7uMmzJZqfe+Rs4awNZlPnbrKXL5Z72xsp5f1jDUt9SGmq+vRKE2g37NQ7ZvBMTyirVTANO5dSIbgWB+wONCpVyf8lwizjOBEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHlOv5AioA+wZR2fGjs4VfByusvYuSDANdwS9ExVInM=;
 b=O6JH8ZwIufnXuXjSb3eXCYnkal15Rlt8/eg5jcy6XTae8aHHpH+WUHnn+r79uKBeQLj8bpTJW3TMZcgw5CnvMILfZqeosbY6rMFF8HfFlpVhDzHFqJtwH1M93DzUqr8JsnCzioD66rGC4KnAbGDs52/YTEsCME9nOPKeRUDI9ghNOz8Ij2DiL5jagCrVhJnEmb34RZetvqTIgCXaeM4M3rM0t/P5+5KcToU9Q4sAnWd8TCfWow6EgSvoalUEPVVhaas0IVLnk8y78H8pYkCgi/EVOUcpnWsDaemEyyCqkyvgxvdtZ8AqyuXmvMVDKv/B268XdjMUUolH4pALOjrICA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHlOv5AioA+wZR2fGjs4VfByusvYuSDANdwS9ExVInM=;
 b=YA+pPrzk9MJqB0IQ5gkZTPySOffIj82i1o6TVcWGqz7da6BpgHVhOlAEJoWl+VfcKHsRUrKKaKIoCqONMy5ZD5fIV7T8LQvOAs+Ex6ALYjfivEQT2BG2BLB/mbQcA1fJ/Z2PAQf4n5FqSBFouEjCs/RhE8P6I43/hKSHEzslsOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 07:56:37 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda%5]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 07:56:37 +0000
Message-ID: <250f538b-8cd3-47c7-0f0f-0fa3ea1a9bc2@amd.com>
Date: Mon, 10 Jan 2022 13:26:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: ingore failure of GmiPwrDnControl
Content-Language: en-US
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, Evan.Quan@amd.com
References: <20220110074700.27602-1-tao.zhou1@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220110074700.27602-1-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::22) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0384619b-ace4-4efa-5adb-08d9d40eba36
X-MS-TrafficTypeDiagnostic: BY5PR12MB4196:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB41966C67C3754F43190B15E397509@BY5PR12MB4196.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TyT8sLORdh9JP3ho2UiOu2tdAhk6Hfv+RxgImw8td3edhM2U0BmmNu3gte6FGRmvBmwThvEoAWxuIXNhPYOk2o+j9BwSXt+QAMxpflZjUfBUsnMXXWihQpVXMTuwQBqufkn9S2BqWaCaF/UiacEhmKNYEysur0dRBEzKwo9cMwsIaovRQqTZHfKkKKGGyICiROID/oWStgwBKYE2PMP/3p4N//gBGl8cBGmfYNqkYYmpeHvFJ1hOrebHmq9wJmPg87lFrYgZzN6HhyHhLPyMH5duoWbNX7vXY6qZZScXQkIWl9wMohevZyRUOeSGmg6ME0HXv2JCS4K9Cj6H2bnniTSAdnfUXm3PoJdJVXVYRUxIXugbY4FFMnWzqfKe2feWA9wUCUCmF1eQo/CddIOoA18YRF2oXJIAUKVzMcxmNkfIBrLRpidciSMI5h6Nm5hFT16paQz7NyMN8EFRrpB4Nkiiohi4q0Q6BUt8oBl0KdyExZe+V3N1jG5G/hyWH+30t37dSRoypKDxhhi+dmw3dNRa83NEq+T/BnSxKlFuyaySDfHmOG5KRzM4j3Cf4xxdprQxtg+kYJk84wSeP/MRHdsMnnmAUQIaIi56MIbXEg1Fuwa/YDgsX5DOiAznGhvnakc9PRMyIM0FQPoLrxFM6bXTJ21aHDCmSQdPgvbBM2RA9nP5t9fGZo9+btj+EQ1b6vaynncPCnlfjP7xOoHrFlbL5FWUSiUi2woc8/1i8fQrpuLRpmBMEL+nJu7qY+38SFQzKWeBCOBNjUB6o4/Fxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(6029001)(4636009)(366004)(86362001)(5660300002)(26005)(316002)(6636002)(6486002)(2906002)(31696002)(66946007)(508600001)(66556008)(66476007)(8676002)(53546011)(6506007)(2616005)(36756003)(6666004)(31686004)(8936002)(38100700002)(6512007)(83380400001)(186003)(156123004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ni9mbWxXdFZVb25BL0FCdjhSZFBJc2lKcXBic2tmU1NjRXJzMXJ2NnVJVTd0?=
 =?utf-8?B?Zm1oV1FvUGU3WlhFWXFJT2FLejVicXo3Slc3Q3hOQWdsdTB3ZHJKS05vRFhy?=
 =?utf-8?B?WXhNZXNvc1ZLMEJCQS9nRG5OaWNQUnJSQ2Z6OFByZW9GdHpSaUJLU0JGQWhp?=
 =?utf-8?B?K0RhenhVVFJZQWl2RitKVGg0T21CdmZoOFZyb01nVFJVZWhmNUJXOUk4dllH?=
 =?utf-8?B?RXdKRGpxODNuRmFMcG5FMkNnTUlXaEJjVkE1QjgxOW5ZaG5ScDhHTFByNjhE?=
 =?utf-8?B?bjJMcmJ3N3RlKzBsTUphK0Ewc0xadUg0WVN0VGVXMDhINklkcVZYV3Q2N0Vl?=
 =?utf-8?B?dFRNTnVYVlIvV2FmRzhNN3VoTkdCdm1LWk9YRGI3Z0tiVG55Qy9VTHFIanpF?=
 =?utf-8?B?VmxwSDAwSGUzcUJWbndTdlJUWEp6MVNRRDBLbnZmbnNKT0IveEMxY3JzTDBU?=
 =?utf-8?B?ZkhKVmd1akE1U1Y5TWdaQWdOUzVKSHU4SlVJZmZzVjV5dE9pK0xwdUh3VHlK?=
 =?utf-8?B?SFl4N1ZrVG1vY3IydHE1d1hvNG1UMTdyZGVncEFpNXJFbHhJVmNpNTVST3lG?=
 =?utf-8?B?Mm1WK2Ryb3VuTUNUTEZlZ1FUVUVLaWVETW1PTmhvZTQzY1ZBU1MyWTRNdW1y?=
 =?utf-8?B?cjNVVDI3cU5xb29kSFFqdHpuS0NzeldGemtqTmNwS1RqUk5weXRucitVZGR0?=
 =?utf-8?B?RjlPdEljS0RWQzd4MUFoZythM0JpTFJFOVhMckdxbXliamFXcCtoZHROSVlM?=
 =?utf-8?B?YVBGY1JLRUdLK3hVTzNzSE9SZ3BVMmpteWk4ZmdMNERPQUV5N1V5Y1BsaThV?=
 =?utf-8?B?a04zVlBHbmd5NE9WRmg5OW9JWVhubEo5RkVGdlcyenpDTDRtaW5QZ0pVaUE1?=
 =?utf-8?B?dDlZdXFkbGpEMko4clVWNVpnV0J1ODU4Zm9Ma1Rqd25FNkRBSitXdk1xRUIr?=
 =?utf-8?B?TkJYdlUrNmtUNFNBQkNyYjBIZzRrNmE3RFR1WDZqL21GMWk4RVlZVW5RVThV?=
 =?utf-8?B?TWtkSTc2WURKcG5oYnVzcElqajFFUit4RksrY3AxMVlqN0U5dGVtT2V1R2h5?=
 =?utf-8?B?RFVvYUNhZURiVWhRYTJpQVR4TmRYdGFGaHEzYXJEKzcxMGhSOVpDK2J4RUJ1?=
 =?utf-8?B?MWx5dTdqT25KZWlhOE1zMHdlYjh6UER3NUl5L0J6VWNMMWlaTHdpQ000ZDV3?=
 =?utf-8?B?d09kNXFYOVlQK2FPcHRJNEU2bmxMUXUwcFVOY0h1VzF5WTZuTkZIOE5LRFE0?=
 =?utf-8?B?SVVkRWxvTGJiRGM5a0NuS0ZCRms3UThuUmxTOEd1Mk11K2wweUZHc2NFd21t?=
 =?utf-8?B?QmFzVUMxZGlYaTEzVCt6YjBsbG9DR0lqd2FQWmhTTzkxeTVBbFBUSXRWRTJX?=
 =?utf-8?B?eTZHTnFLVUlZWGZRSFk3M21lLytZeG1wcHd1UEVsc0xhK3l2MlJ4NGJ2RXFY?=
 =?utf-8?B?Mk85cDlyVEEzb1pSY2ZUMnl0TEgyaENGeWREb2pTanlvK0dTTlRsTmZGQUdj?=
 =?utf-8?B?TGVWTkR5dWJhN0YrYVowKytUMW53clhQckJLdWYvK3B5dUR4TEFheWFEcVVs?=
 =?utf-8?B?OW9LSEpURFMrQUpsbjFaQjdyVWh6SURTT1h2bmExelNWRVRoRmkwRzNsVlZq?=
 =?utf-8?B?MUFMMW5hdlowbjlFb2RsRnN5NVQ4OVkwVDVUTytGV255cUR0WHBuNWxkZkpi?=
 =?utf-8?B?dHNpUE4xTS9zUng3ZW1IdS93WDVPK25SMW5JSk1vS0V6OE0rcFhHaTRjNG5z?=
 =?utf-8?B?KzVBc1hYTlpKckIxNlhJMFQ1NHRyVVFJaG1XdjZCbCtxRXdJcWFFUFdPd1VH?=
 =?utf-8?B?T01SV1poUmhrYzVuTXM0RzZEYW1CakoxaUNwQ1M2Q1pJTHBGdUhjTEEvdzV0?=
 =?utf-8?B?MEJWeVRpM1hZdEtFcGJzaXZ5NG43WU5hekNZajdmWGRnbmVVeXVvejhIdnpU?=
 =?utf-8?B?YzkxMnV1UVhVSXpQcXNiYU5XWUpoOUxOT2dNSFBqWDRPc0NKMTZLK0d4YWkr?=
 =?utf-8?B?MUl1WmgzKzR0YkhjVThHaGpVNWgvMFQwaFNaWWpjQzRNQWpCTHZhQ0w2dXZ0?=
 =?utf-8?B?aFdJTHVzeXk0a1NUd3M3alBLci9ZbDJsenMwZUtlVzBJbnVzWWMrTE1OOTgv?=
 =?utf-8?Q?0DxA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0384619b-ace4-4efa-5adb-08d9d40eba36
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 07:56:37.3546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLCRJ9cfsltrsHzRl4B1Py4l/lXRu0UXiVt4U7GF48HOEnhesbeVf+8W2rSz+aQ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196
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



On 1/10/2022 1:17 PM, Tao Zhou wrote:
> PMFW only returns 0 on master die and sends NACK back on other dies for
> the message.
> 
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>   .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c   | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 261892977654..121b0ab5823f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1625,10 +1625,18 @@ static int aldebaran_set_df_cstate(struct smu_context *smu,
>   
>   static int aldebaran_allow_xgmi_power_down(struct smu_context *smu, bool en)
>   {
> -	return smu_cmn_send_smc_msg_with_param(smu,
> -					       SMU_MSG_GmiPwrDnControl,
> -					       en ? 0 : 1,
> -					       NULL);
> +	int ret;
> +
> +	ret = smu_cmn_send_smc_msg_with_param(smu,
> +					   SMU_MSG_GmiPwrDnControl,
> +					   en ? 0 : 1,
> +					   NULL);
> +	/* The message only works on master die and NACK will be sent
> +	   back for other dies, ingore CMD failure for the message */
> +	if (ret == -EIO)
> +		ret = 0;
> +

Could you confirm if this is hive master or primary die of each device? 
If it's the latter, use aldebaran_is_primary(). For the former we can 
add support similar to is_primary().

Thanks,
Lijo

> +	return ret;
>   }
>   
>   static const struct throttling_logging_label {
> 
