Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD1DC4167B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 04:04:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DFA910E06C;
	Thu,  7 Dec 2023 04:04:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4C6410E06C
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 04:04:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmycM+zBmpj5JW/G/I+Ap4Y8esSKazt6pqjKMgxk2sxNcZo6kvVFhepyEaBZO67fxk0RW/5cTmE1+A10zp4vjGM67la7qKBvg45uZ038n/84syI5XhRMj9aqocFdWKpQmeJISHj244wJ15fXx+jl/nZhMUSiNEEFHFvedz+dDpAEDFd89LwzItNPvG3w+IfCrBFtNXxw3TZylqp+20saucLPXHlGxRyej6MOcvlKYs/o1S0axw2l7AGd/8CPniOqg+HjJoMpQg1VgDoivYcWebIjZ6rbNFLw77ftTK6PgAYfLHswXOGna0Atj7TZj31OxOK0WJVFZ2mbF7jqEp2fVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gg/ieVWzGbXeQZN7twBlTGkFeJqEl93LjeKxa5NmWxg=;
 b=LLDQg83jF9925ABfcbkWrFD4sJ6iFk3Hw0jgW4iYkiVbbRQf4UwYPDzLTG1ZoxSEMFRZxi46PCJOPCVebKkUVY0Fip0QPZQeyeQZp5AIqtdVYVj6sjUUqVN0kx6yvRjYiirw/hUTUsYR+y7w9cPxwK3v+qIV6JsWmX7v9kyZeNPv8l/zOrf2cSi6D43a7NbyixyFBEUMjZMu355kVX7KyU675wBN6UPPUNNEKRjKy2ihM/zUIDtrgVcwltou7L+m3Y9Jb++ObUhwspwrmGqU9j2LecyHZFgzNYTJ/4oqAa9qmCLkKi2XtneDg2TYHWt255Rq+XsTgzKSimJmrZnClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gg/ieVWzGbXeQZN7twBlTGkFeJqEl93LjeKxa5NmWxg=;
 b=KPxb+vYDIIsiDziq7Vl8OW6HgIWzfB4E430RmFH4wt+KFGE+hELzLZr5HogmW37eb4xrrwc752rbxqznZ+g2R8D0oSonVd2OwxScSevPRg+5G35fgMLrTfe5yWLN6k7J1A+FMTz+WEen+5ongl6AYZmeC1cMeAUaD4k771yL830=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 04:04:53 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0%3]) with mapi id 15.20.7046.034; Thu, 7 Dec 2023
 04:04:53 +0000
Message-ID: <b1b17345-6c5f-40d3-bd49-a4402481a098@amd.com>
Date: Thu, 7 Dec 2023 09:34:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: fix pp_*clk_od typo
Content-Language: en-US
To: Dmitrii Galantsev <dmitrii.galantsev@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231206193903.14623-1-dmitrii.galantsev@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231206193903.14623-1-dmitrii.galantsev@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0122.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::8) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: c303298a-ebc5-4c76-c872-08dbf6d9aa80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TOBycGC2nxpxhso08xRShACzsygDXb4cC9yfG/D4ipebXGBwQ0RySn+TQseaMZz0K90tC8Q71K8jxdeOuNjcLMvTg5MH1vDOtBdX4WAx2M2u7ulRJSLyaz/I02j7nW7y8ol1MhEkYqJyk/+uAnIY7KxTdH1iv+MYUUwqS3+zmmoO8q3RX/1mJ/CNchygWDA88bJN9C4ZcMKUN6CoorvPWEUzY1mbE6SbXf4jG9DoBhgrAeSjPkcdGs0ExEm8XADQlY5QfDUMdRSDZx0Ps5OF1mK8L7d2KTLh/p6cpzYX7tEvPJMtDIHsfBgd40lEiK3yaxstmN3dyWS2Q9DXR4PyZuaxHJ+FkIE2/5j0XZWjbtcKBvHWhKNt97cyQfa+6Gb2GY+/TYDXhg9a6f5gs3EwpS175T80jMo/QHQLeWLYSK2owGENfNMIp/nL+DfH/uNmlSmS+8Y9jdzRhZkFf0pIkL3kuZpqMvnqy+VwOd3ziR8ekIHcLPdh9BrM5V9+KgDhspmF3/QWU6YT6wkmI7lEuMG2xpZV8/cdkwHK1AxsSqpqAzrwD1C1SR1cOwf2WUheL2w5eN2hVvgWhz/+GBD92msXxW774V1tQHY01L+pSxMJI18e7MhOkKA8WhBTjAKL50ApL1JXa7ej0fQKgIyVGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(366004)(136003)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38100700002)(86362001)(66946007)(66476007)(66556008)(31696002)(26005)(2616005)(83380400001)(6666004)(6512007)(6506007)(53546011)(36756003)(41300700001)(478600001)(6486002)(316002)(8936002)(8676002)(2906002)(31686004)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2VhQkR5VWRGTDZUbjhkRjllUzJFZGlMRVdFT3lVUktiNmkvMEhKTWJBU0pX?=
 =?utf-8?B?TzhOOW53NEpOMmQ4VnhIcWx3OEYrcU5HdWRiWlNROENXa3FOcEhTemJWcElR?=
 =?utf-8?B?WkoyMFhmc0tuVWxVdnZjOW8wMHFqY043ZFE0cGVmdis1dzF1amRFb2RJd0dL?=
 =?utf-8?B?b0hDYTZ6dzBGb0ZYZ3RIQnFvSmpiT3Z3dXNBKzk1QTR5dk5vWEZNeHcxRGpO?=
 =?utf-8?B?RlFYVEZKVEtXUEhWWnlRUm5udk5jM3VwQ1hQdFBZU3k4Tm9wakJldi9RM0ZV?=
 =?utf-8?B?OTYxUFIxODZDT29VSy92SDc4RVBsVi9TTkV1R0gxS213S3lINVJYbUF4Uzhv?=
 =?utf-8?B?ZVJNOU1rMENrQmh2emczZU1iTkxPZk1EcjZXLzdFWEVrTVBOazFHNGgyU2xT?=
 =?utf-8?B?aGdpTWJZYzNPSHI2WHlsUUtqYThUUktPNHVkOUxVLzlnRnJjRmtuMnNaUWQ3?=
 =?utf-8?B?QWpjdUtVVjE0MkVDaXdXazQyd2NMZURZNjBCWmdLbyttWkZiZEN2cWs3NDBh?=
 =?utf-8?B?cWhqNzZrNVhGZUM0UDQvRjVmemdZb0F6U0hLOVdzMU5ncUZ0N2hjMW5UYkY4?=
 =?utf-8?B?Q1lLTERLdlNvbHFQUzVrcHNKaFdPQmZpUDBHSzR1RDdYYm81N04wWXY2MUlX?=
 =?utf-8?B?Z3BtSk55bjBtekd3MkViajVidnR0S0FXTmtvTmZZMTI0TGI1ZzNueVVBTzFL?=
 =?utf-8?B?cjZhQWJCeG5lU0FXc2pKU3ZIZXJmSmZ1elpVMThCY291N3pQN0tyS1ZsemUz?=
 =?utf-8?B?c1ZYRGd2TFVXK2hIb2YxaGJsa0l1TXNyWHdZY3JqTDN4MTE2V1UwNFFhY2ZJ?=
 =?utf-8?B?K0JVVExoVWhTV2JhSnUrcDMwa09iUG4ySkhvNngxK0h4bXNMQmV2VngrdHdN?=
 =?utf-8?B?WFdUcjZyK1NkTHQ2WFNhYXVaQ3kvV05iUG9TTXBYQjd1RnVBWityRE1jSWY5?=
 =?utf-8?B?K0RMV3hibDZnZllRcVZiSUdNV3hHRHY0aVVkcmw0RytBSkZCSFhyVWNSeVdj?=
 =?utf-8?B?RzJRSmZEYUZMeThBWTRKZ0txLzBLZjVydTRsdjBRTEp5MFNNcHc3WHJWelE2?=
 =?utf-8?B?YnR1QU1adWloUmFDaWpxbmlFM2h2M3ZOMXZPbVlGY3p5c2VTdlpFYTE0NG83?=
 =?utf-8?B?MFU4U0h3clRiOFdrWWYvTnByVUJjRThiWHVodTdzSFIyRjluQlM5cU43cHpQ?=
 =?utf-8?B?NVVoWkNONkdUR1lTbTBFZmNJTndYazdZMEcyb2l6S1NkZ2x1TitaOHZiZTJQ?=
 =?utf-8?B?T0VmekJIYjBnM0R1VnFDZlk0S2YyN1dSbG1KSDNaMFYwTFI1YUtxT0x0Q0Nh?=
 =?utf-8?B?MGRWeDQ3Z3Y4WmJhdVdqTFhrMCtmcTVGRWo2ZFVsQ05XeUZYTUtBNUdyclpB?=
 =?utf-8?B?WFNQUDFPVzJCWFNtcmhXaVh0SFRWZlpMd2JwZTlVeDNaVXRETm5KZnZkcmJo?=
 =?utf-8?B?TmFSQkJqQ0ROangzeEppbkN2Z0E0WFdWTXY0YUpqRG9jdER4VU9VcGw4MmFk?=
 =?utf-8?B?SlJxd0w1SVZGWW5qU2tSQ29pcnNOT2NZaHBDR242RXM2bXorUkphNFptUEVO?=
 =?utf-8?B?aFZvMkRKMHdFV2tVZUtjK21TMVVDcExackw5TGNDWU80YUdGWGVVNkJSWEZi?=
 =?utf-8?B?VnBpVC8zdkE5MUp1dTNUTVZQSjM3bVZmTlhsbEdTSUlxOFRkUmMvQUJrZ0dS?=
 =?utf-8?B?V09yRVpnQnpDUGRSaG5XWFBxTkhFeHEvUXNNSjFPWUF0cjdEdEpJaEN3UEtk?=
 =?utf-8?B?TkRLRGpPd29rclZWcHpTNERBTVhtTEljRDJ1RXpuN3FKWk1icGQvSWNEMnNL?=
 =?utf-8?B?ZmNOQnhZc2ZiTm9mQkQyNnZaOEdzdktXWUlPZnVhRFduRUJNVnJFVXVkakkx?=
 =?utf-8?B?VjkvV1VpcmxBc01GemhUZ1NWQ090ME5QbERGbUxlOTNjWmFiNlVqNUQ2eVdI?=
 =?utf-8?B?K0tiOXNERkVDakEzNHVzaWNJWkt1My9LcHRMd010SXdBWGNvaWEyWXZFOUpO?=
 =?utf-8?B?RVR6UHpUM0RJSWFYSU1JeU9YejRlVW1ZN3RyRG5yVFdSc1FkU1c0T2JXN3hG?=
 =?utf-8?B?VHA2bVdsVk9EQ3dWQUxSQnMvUUFFMllDZXZhUkN5RWJpb2MxZWc1UGExMmlq?=
 =?utf-8?Q?zsOQI1+8nuuMfpUk9OKoRW/GB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c303298a-ebc5-4c76-c872-08dbf6d9aa80
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 04:04:53.5897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPNsy057Sy7UaEebQMqtYiAdQahfurn2FUsANORAc37WwlCHa3alP7DlaUU2D1AH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112
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



On 12/7/2023 1:09 AM, Dmitrii Galantsev wrote:
> Fix pp_dpm_sclk_od and pp_dpm_mclk_od typos.
> Those were defined as pp_*clk_od but used as pp_dpm_*clk_od instead.
> This change removes the _dpm part.
> 
> Signed-off-by: Dmitrii Galantsev <dmitrii.galantsev@amd.com>

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Add below tag also before while submitting the change.
	Fixes: 02484ac55114 (“drm/amd/pm: Hide irrelevant pm device attributes”)
	
Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index e1497296afee..2cd995b0ceba 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2238,10 +2238,10 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>   	} else if (DEVICE_ATTR_IS(xgmi_plpd_policy)) {
>   		if (amdgpu_dpm_get_xgmi_plpd_mode(adev, NULL) == XGMI_PLPD_NONE)
>   			*states = ATTR_STATE_UNSUPPORTED;
> -	} else if (DEVICE_ATTR_IS(pp_dpm_mclk_od)) {
> +	} else if (DEVICE_ATTR_IS(pp_mclk_od)) {
>   		if (amdgpu_dpm_get_mclk_od(adev) == -EOPNOTSUPP)
>   			*states = ATTR_STATE_UNSUPPORTED;
> -	} else if (DEVICE_ATTR_IS(pp_dpm_sclk_od)) {
> +	} else if (DEVICE_ATTR_IS(pp_sclk_od)) {
>   		if (amdgpu_dpm_get_sclk_od(adev) == -EOPNOTSUPP)
>   			*states = ATTR_STATE_UNSUPPORTED;
>   	} else if (DEVICE_ATTR_IS(apu_thermal_cap)) {


