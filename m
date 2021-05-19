Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6765C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 15:42:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9542D611BD
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 15:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9542D611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42CE76EDFE;
	Wed, 19 May 2021 15:42:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B4856EDFE
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 15:42:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsHGt0tt172kMBjMwAbXPZMxQCmQ+P/093+LxvBE/XaL46bAWY1/PzhFDE2+8barLJkAyEt7RIoSRghU5SEKu0uIb9MOLWZTpf70E4EGLSfwxQHOmAJUKw2sy+2SbdfbQhOU563QBt4BjGhkR+7ZON3uUGAHb6HCsGiSME1lAgnzIzIwQkhB+wv14xnCvSbVuE6+OTyRL5Jm1ZsPb23dySg+sgrcnEVoM+tafUl3smzbmn+wjDZ8hwRmrW6GJ8B1ATS2KqNozCxEKauBmiqvLrvh2MD8dGScamkOLaxEIVX3SzYRC/Im9mluNt6PwexyQBfdEZQrYko1zeASLSh92A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbZkMVUylLQHveGngBivD7yFzJJDvwlXHjN+lxdZVAQ=;
 b=i+82tCD1PSNIOCTP3wIeMcnCqka9j4x7cBi4fK4DGpSBDF2FbYeY6YdY6usMfV34JPSgEHgOzNgumXESdnj+55ip533fhGJbteULlUq1Z3mfA1AmU5ZuIcOEZK0AWZqHbAGK1Y2FK2cYS/OM2P9h/0tGpjOdHuv2ojRpSd+gffkux7y2I89Evc8ShPcCpV17dfBp4rveeFLnCElikkFUugNytSehZMGT9RXSZLytR01dlKMK3F8oaYmQ6PwhI37OnNsU8P6YtASNZB6cKHEJrfPONNo6xZgJgkZW4Wqocu7g/vlDvPNqsT8GCTs0qbqPD9i/+eyfUQOerakzR/vDlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbZkMVUylLQHveGngBivD7yFzJJDvwlXHjN+lxdZVAQ=;
 b=00cLYT0kvQFxtvYxb7cr7+UO3P2IRLdVDr+E/Kgf0mLf2+z4sxSD7Op3HgRTEfyztrCgcih5c1wfuQan9Ko4Ez5Y2DaeOPyge0oOCiTabTYHps6X3PesNbGvCaEymJX46+mDEOtghbv8bCpUTf6nuuzk59oi7afbWUP/tcti1hE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5297.namprd12.prod.outlook.com (2603:10b6:610:d4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 15:42:45 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 15:42:45 +0000
Subject: Re: [PATCH 1/3] drm/amdgpu/pm: Update metrics table
To: David M Nieto <david.nieto@amd.com>, amd-gfx@lists.freedesktop.org
References: <476f8809-5521-98b4-e08f-1d06fc099468@amd.com>
 <20210519060233.13597-1-david.nieto@amd.com>
From: Lijo Lazar <lijo.lazar@amd.com>
Message-ID: <38e873bc-dfad-b422-a301-ed45cb48df65@amd.com>
Date: Wed, 19 May 2021 21:12:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210519060233.13597-1-david.nieto@amd.com>
Content-Language: en-US
X-Originating-IP: [117.222.149.218]
X-ClientProxiedBy: PN2PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::30) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.102] (117.222.149.218) by
 PN2PR01CA0025.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:25::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25 via Frontend Transport; Wed, 19 May 2021 15:42:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffb1c54d-f030-4667-fd9f-08d91adcbf42
X-MS-TrafficTypeDiagnostic: CH0PR12MB5297:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB52973188890123EC67D34E4E972B9@CH0PR12MB5297.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1RI0XyNMPz0wVhHL7LnQ8Oo+kdiwoaWxd3n075U4vI/DOnCqBEb4+Dk/rE/az5EsbauiVz87/a6z7Jxw0GAFgSOFf6NsqdQ2ia05NijZFAjg4zwLwawvCktl7KJU/99z4vMZ3cSIOpKCICfxMnPD0+uxPPO+Emwwi6pQuTsqdI5U/8AGaIS1EBwC40lGeh+yXfUC0571MSCuprkr8ZRU0qSwLEZvPd/9/1UOyfJOJoOUIRZ/aB/Qg7ictJS1RMkwWwhlS7IIFQxdabyy8TOl/CBt0P4lxiZCAapUuM4PFxwcCg6TvU/tqOhyJd4sXWblCxzpSxI/ceJSgS2RkhntFIH4ZAPEi2lsHClWSWxQ+pe112OKvBfMtiNRym74dpa3OR+HmA2IN5mciMXbgnYsaM2Krt9Gr6UVrQnoPPL709RHlM1I+eTnhd8beZYa5uZe4y7Oa8TgHkUCE1EL2EnFzydbH4+JzN54I5Fl+MNaFI7CrGjXPjklGGGDFIYMV32htH2lyITa3B8Q/qyPYG51eIRwBKsoLb9WEIIRwmKbxHFaWthRbVdrjCtUe/Nzhk8RagU7zYk50hpGnj70PBelTEu5s7j+QssSKgji4FKGEOfKgK5L5iXoSmJlmfv5CH2SBqlbc6GmPjzmzmOo8ScTITjrH2YMkzHwyqQJ8GIlHGARc5xVTlWq9mKEXvj197YGc14Z/RWsKURtJVqeMQFKCM2Lbk7jNd+0fKXkjNUqI6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(5660300002)(36756003)(31696002)(86362001)(26005)(53546011)(31686004)(478600001)(6486002)(6666004)(66556008)(66476007)(66946007)(8936002)(44832011)(38350700002)(38100700002)(956004)(2616005)(8676002)(16526019)(186003)(83380400001)(316002)(52116002)(2906002)(16576012)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MTVhRGl6Z3dCRVRmVFFuU1EwNmZyRmlGdFp6eHlscWRDZlpiUnhrdjVqckJE?=
 =?utf-8?B?S0RJcjB2YkdkdHIxZVBVakttVzlxUmtFcS8ybXNDN2JDSjFYblBObmZyKzRC?=
 =?utf-8?B?aCtRWlpEcDlaVElFTTZTWWs3Slh1UDI4RzQ2aEh1SmFJK0o5NmdibG80Ymk4?=
 =?utf-8?B?cDJOakFhTTYySW1HUmR0aktDUDF2YTVZYUh1cm56TTJlZWF5MzhGWVIwSzE4?=
 =?utf-8?B?ajN2MkgyRFBZV0RqN3h6QVVNL3Nrdzd2NTl2cmJZT2NjVk5Ka05JWjNyOGpp?=
 =?utf-8?B?dDVwcDNSZmlkS3BwSmJHMzJqVElreW8zNDlKMTI2Vm00NG9tODVYMlQxTGFp?=
 =?utf-8?B?NFBRcVRLZURWaENnUGF5MjZLUUNiZ2tWeUQ0Ky9iTFl5eFg2Z09ML1krbnhL?=
 =?utf-8?B?WDJwaWtYK1hBUlpoM0Y5Q2orS1JqTlhqRTJiZEgrMXZldnZ1RjV2MXZkNWRX?=
 =?utf-8?B?bWdqbjRaeU5udXYrRUt3eVlTYlVubjBwTEJYVlZhMERZMm5VdlFWQk9nL3Zi?=
 =?utf-8?B?TCt2M2lPWnpOSGdCQVZ0UTRSbjg1dlZNNVFUR1lYam41UlVPM0tOY3cvc2FK?=
 =?utf-8?B?YlR6VEh3d01BSVdGMVlqTk9qajJNZ01TcU5vTnYxcUpTQW9lQm1XT1orWG9s?=
 =?utf-8?B?UVFtRXhkemhGS3J2a09GQTlabjM3NUhHWVJnWTREY2dDWmJkTWZuZ2N4OXZC?=
 =?utf-8?B?MmNKQUhMc2FGYnpHYldhbUdUYzFCMVcxZkorWXlORlFGWWtNWXFwMitVeU9V?=
 =?utf-8?B?eWFWc2dpTEhOQWZYc09yMmhTTjBKczE0YiswejhqNW83Z1ZJeUhzR3FieHl6?=
 =?utf-8?B?U3ZmbGtvbndVNFg0OGY2bEVvTEJLNGpEYnp4UTVVYWdRMkphMVd4MkVMTndJ?=
 =?utf-8?B?azJiWE12b2JvVzZQUXJ5VWtERUNNU1puWG1HK0xPS0Z5YkNvK2V1cTlteHZv?=
 =?utf-8?B?WTlBM241bW1PbjFwYytHNVRpVGxEdXBMQS80MGxNUzFLKytyZVNDd1RLZ1pt?=
 =?utf-8?B?WEZLNzUyVkd5WUNHalpNdnVaeXNJZVNic1c3UHh0bk5XRFVGK3NVZFlCeC9I?=
 =?utf-8?B?MmhwNzFTZ0FYZzJLWFNnN0VoczduMFVwZS9yd3dYdFJTZ0ltekhFZVYzRTlY?=
 =?utf-8?B?ZVBTNlVKc2NnUnNQQkcyaC82dFROclNub3BXS0cxMm1sZUcwTVd2RnNCVVMx?=
 =?utf-8?B?dVJjZWxZUERBOSsrWnFCcHA1NUg0SEp1K0VCMUdYT1lHenRqWTh5bEw4TSs4?=
 =?utf-8?B?aXFrOHA5N2hnbytXdE5sSHZYeHBxdlhObFFSWE15cGlFV1pWQVpZNlhxOUV1?=
 =?utf-8?B?UFhCUzVNZ3QxRk5jb3Qzc3JZVUpGVG5ocjlpSEExek11bU5VVmFpVUVmUEN4?=
 =?utf-8?B?QkdoY3pvbnJjS0RJd0toKzNFRDZGNG1QYlpsaHFyVzQ0WVhHSUdLMnZuM282?=
 =?utf-8?B?ZDdBS0xBMmE4S0dtbDFpZUpROGl2QU52aG9lNHBRbVMwSGtBNmQwN3dib0VO?=
 =?utf-8?B?T28zTW1aYTlXYSsvUnFIUDRRUzk2NXNlQTVxQy9pT3VWelpwcmxMLytUSGhC?=
 =?utf-8?B?TEQxdzQzSzI4YzRpMXZYZGJNRDJvcThjQmtzNmdaOGExZ1FkMUtKN2Riemky?=
 =?utf-8?B?YXJPa3VxZC8vd1JlZ296Zng0KzQ5R1Ftbk1nRGljQ29sSTMwQndTbHZSRzBZ?=
 =?utf-8?B?RHByUUVvYXZTTkJicERDZVV0N0N5Sk1Teml1TkUxc0FuRFNMUFNQNVFtUDVp?=
 =?utf-8?Q?8punRIz/EP0NqwPFi1oU8M9ftGcS0wQOVgLMFDi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb1c54d-f030-4667-fd9f-08d91adcbf42
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 15:42:45.6668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D6fpJ6Xx0jdEgz8OfdU/kWVskpmfTqt76aRa329+DEeWezEgAse6RQxdw29Dh7qr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5297
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>


On 5/19/2021 11:32 AM, David M Nieto wrote:
> expand metrics table with voltages and frequency ranges
> 
> Signed-off-by: David M Nieto <david.nieto@amd.com>
> ---
>   .../gpu/drm/amd/include/kgd_pp_interface.h    | 69 +++++++++++++++++++
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  3 +
>   2 files changed, 72 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index e2d13131a432..b1cd52a9d684 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -536,6 +536,75 @@ struct gpu_metrics_v1_2 {
>   	uint64_t			firmware_timestamp;
>   };
>   
> +struct gpu_metrics_v1_3 {
> +	struct metrics_table_header	common_header;
> +
> +	/* Temperature */
> +	uint16_t			temperature_edge;
> +	uint16_t			temperature_hotspot;
> +	uint16_t			temperature_mem;
> +	uint16_t			temperature_vrgfx;
> +	uint16_t			temperature_vrsoc;
> +	uint16_t			temperature_vrmem;
> +
> +	/* Utilization */
> +	uint16_t			average_gfx_activity;
> +	uint16_t			average_umc_activity; // memory controller
> +	uint16_t			average_mm_activity; // UVD or VCN
> +
> +	/* Power/Energy */
> +	uint16_t			average_socket_power;
> +	uint64_t			energy_accumulator;
> +
> +	/* Driver attached timestamp (in ns) */
> +	uint64_t			system_clock_counter;
> +
> +	/* Average clocks */
> +	uint16_t			average_gfxclk_frequency;
> +	uint16_t			average_socclk_frequency;
> +	uint16_t			average_uclk_frequency;
> +	uint16_t			average_vclk0_frequency;
> +	uint16_t			average_dclk0_frequency;
> +	uint16_t			average_vclk1_frequency;
> +	uint16_t			average_dclk1_frequency;
> +
> +	/* Current clocks */
> +	uint16_t			current_gfxclk;
> +	uint16_t			current_socclk;
> +	uint16_t			current_uclk;
> +	uint16_t			current_vclk0;
> +	uint16_t			current_dclk0;
> +	uint16_t			current_vclk1;
> +	uint16_t			current_dclk1;
> +
> +	/* Throttle status */
> +	uint32_t			throttle_status;
> +
> +	/* Fans */
> +	uint16_t			current_fan_speed;
> +
> +	/* Link width/speed */
> +	uint16_t			pcie_link_width;
> +	uint16_t			pcie_link_speed; // in 0.1 GT/s
> +
> +	uint16_t			padding;
> +
> +	uint32_t			gfx_activity_acc;
> +	uint32_t			mem_activity_acc;
> +
> +	uint16_t			temperature_hbm[NUM_HBM_INSTANCES];
> +
> +	/* PMFW attached timestamp (10ns resolution) */
> +	uint64_t			firmware_timestamp;
> +
> +	/* Voltage (mV) */
> +	uint16_t			voltage_soc;
> +	uint16_t			voltage_gfx;
> +	uint16_t			voltage_mem;
> +
> +	uint16_t			padding1;
> +};
> +
>   /*
>    * gpu_metrics_v2_0 is not recommended as it's not naturally aligned.
>    * Use gpu_metrics_v2_1 or later instead.
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 0934e5b3aa17..0ceb7329838c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -764,6 +764,9 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
>   	case METRICS_VERSION(1, 2):
>   		structure_size = sizeof(struct gpu_metrics_v1_2);
>   		break;
> +	case METRICS_VERSION(1, 3):
> +		structure_size = sizeof(struct gpu_metrics_v1_3);
> +		break;
>   	case METRICS_VERSION(2, 0):
>   		structure_size = sizeof(struct gpu_metrics_v2_0);
>   		break;
> 

-- 
Thanks,
Lijo
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
