Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3BDC6379F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 09:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91BE010E817;
	Tue, 14 Feb 2023 09:06:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED2CE10E817
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 09:06:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPng1skgAJoQbD9z02EjC2T2fX4BU2bAQs74G2vCZM53fjFDDSJQFZ84bv5CrWvkzJVKvwzQlqtTeuT3/jdj0vKf7BjYXzflq9zxzYglg1driQZ0Rz1gEL8Ft1DEBqeqwrZvJmY5feOue7E5foWRDWZQOvryWSI1DAJ4EFvxGB3csGUFqAQ4n/vkltDSr7GyOlKk3hThGGj+xpbL26kAzFFZhA/mMmfNZD1GXfoVlw3IrAcpX3h/ohWU1bjCkGfhduna8qkpLm+NwNrI9OK9u3tC5B42iqrLjZhqRTFHQ5vbjWiUz5oxyvJmBpeo9K0AmgaNV85+uxdxgxN3HqfwIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1i95QVLP7mASszIhxNLnmUi3lntmE8pw99FXE7ilChk=;
 b=eWtEPKArWeuy5qfndj2S1kTEKa/GuKXEdNAX6Ro4+wX2GY7jVCtHQAtb5nQcX1nQj/1BaiDZR/V581XZuf+preeGmHOGEax855AUlPQEJbVxHBkGUakuWrVbfNAmBCBsjYlIxtkgQpjmbSBaGo63USSXQ8r9wj0ECo5gqLLT1xDIusC2mUloeIP/h8GSgEqGJV8mDbHs4/B/hxD6ZQDxLH/eesl0wtWtiBLNHi7jDoujv8dWQIn+8YW2JLXmtIZFqCbYmbTw4ZTLPfngv2HprpazhuoStDHq7Jk3HGMlVTNwLA8PumoRu4bmAE8Cv5F50isQVuIMLH4LU9oFYLs+Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1i95QVLP7mASszIhxNLnmUi3lntmE8pw99FXE7ilChk=;
 b=M662auPcir94YVFMOZFN/Z7hrSt4iw6KkTBuOeeW3uQKgN2ydw1NrSo5RcCU076+MgXW2AMLf2USqvjsg1noeYTf3jzx1VrEFumUZDq4O5NlEdrJKdknM9pQUQVhIelw73piTsoGFxkweY5OjocQyRNf3tI7n2tEXgjGKWJ/Sek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 09:06:41 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6086.026; Tue, 14 Feb 2023
 09:06:41 +0000
Message-ID: <ddac3e2b-c1f4-fff0-4a37-6d6903c5f896@amd.com>
Date: Tue, 14 Feb 2023 10:06:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] drm/amdgpu: added a sysfs interface for thermal
 throttling
Content-Language: en-US
To: kunliu13 <Kun.Liu2@amd.com>, Mario.Limonciello@amd.com,
 Richardqi.Liang@amd.com, Perry.Yuan@amd.com, amd-gfx@lists.freedesktop.org
References: <20230214080255.31493-1-Kun.Liu2@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230214080255.31493-1-Kun.Liu2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::8) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ0PR12MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: db811d06-be90-4491-2501-08db0e6ac959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OJ7JTwb9elbDJgVzvOHapjJkRMR3RUCuV608q/az7cSNBOpVDj9xiY4eZT2nsCYp4qfTULuI9TbGQRS9gD+8+XWOGpDzRAwpw2SvJc8PMSrHt+Tdi14rQGozt8L+/wyMFn7rgg5aqgCaX77LHtjVKu31nvtWTiGTgUDcicqiVy6yId2YgN109xdUn1K7WKHS1oTjmI8fMXPAcPk1WbqbZYM1pWjrkdk40ygxXqrTiKDxSHO82aQ3TAu8XKO6dOosTzZX9ArPaMGqGqNxqXZQ58Z71uHNAbtZx9rpJf9X41U8N8kGdbGrrjz3LoN81Ms23Dz12HGQLTLIiBOl3F0fVHddH2oF1ygxsVp7X+taxK43PxZxgOz9uvkZIFnTpA8BvUJAfltrOG5G6QRrlNS5IUf78aHRNmrLgeZkcU6RQ0jaqNXVps8DA5uFvPNR5MByi0u8fliugZwu2jASZlo55oKwoBiVQb8WcExgDf5o6XoiTp0F8bRH04XPkzOzubvqxLPaettkt+rQ+yJe63W4Y8mkBeScD3QL1snX7dZRvtSPMdLDWvq5bcY/XlkQXMuzxXLAzM9n1P5kxs1d/5iZfumEzctQZQ13gBhOER+oAka3oca5HQm7DJ9QGaWzxO+rylR/GVhXOOoxLOpnu3NGb4y15YIih9203xjYHeitJaLaDqWmxgW1GMoMf6oeSavU7Fr6w6ybaujrvHaIDsehcRf5MbOkQpj6/rQBlBGUN88=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199018)(5660300002)(41300700001)(8936002)(8676002)(31696002)(26005)(6666004)(2906002)(6506007)(6512007)(186003)(38100700002)(478600001)(86362001)(31686004)(6486002)(316002)(4326008)(66556008)(83380400001)(66946007)(36756003)(2616005)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGJxQkVlV250dThQTTZHM3JGdFh3Y0h6WXltekZDQzJBR05BemhzM2NGamJu?=
 =?utf-8?B?Z0JvL0Yya3dyNWZqeE5zRjkvUk5xZlZJcTJNc0RvN2dya1pkQmVhR253Q0ZG?=
 =?utf-8?B?RC9SMXNqYzRsLy82TzZhWUFVYVFRclByMDZtM2l6clNrUW5pRlFkazZtNFhP?=
 =?utf-8?B?V253TW43THlxMnN3OTRRR0JSS1pzb0lJUm45akJhNDVIaEtScXRnTWpoclZO?=
 =?utf-8?B?Zm82WG4yVGNaWC9FazlXMWkzZTB5QVFFV1NKRElwTWJDK0NyY2taZENid2w5?=
 =?utf-8?B?QThScmRwejZLUXA5MFpXakxRRStaNGF4Wng3ZndZMjRUb2Q3ZUVhVkpQVnFv?=
 =?utf-8?B?V29SZU9VcmtTRkE1WGVTNlRpQ1VtVTRKYllLV2o3TmVjdXBlajBub1R6ZHB1?=
 =?utf-8?B?R0lINTZyM1A1V1NzWHJEV1dCOXJSNVZrUmU0bVJPQjQ5YjROMEwyUFRaY1ZC?=
 =?utf-8?B?d21nR0cyd25RandWeUpZWVdOdytubEtYN2tyL2dYZW5rUkl2WFFyS3U1UEVi?=
 =?utf-8?B?Nk5objRGVjh1d1ZHdGFOeHZ6SlBldEFMY2h0M1B3RXlHZVVCdVk4MnNoU0pQ?=
 =?utf-8?B?ckZsS3JXL3JkVHphcFdqUnBBRWJEeVMrZXFIV0cyK29HanRzVjkwUzhnejdH?=
 =?utf-8?B?L2ZnQTNWYi90dHlkOFc3NGVNbVo0Vi9UWmtVSEdLL1BjdE9IcEJtQXdLT3Fw?=
 =?utf-8?B?ZjM3WTlBVTFMUWtHRVlTdjlma2RKN2xaUHFhTmVkRHpVaG9XOXBKbGRyaGhI?=
 =?utf-8?B?UXIvWERjNFY2c2lxeVhCZG1IS3dFYkFrdndEUCtmRWltN3hSOXdrMXFDQVY0?=
 =?utf-8?B?ZUFpUVJNTkVmUHF2YzVuR1J3Tzg4dzJWVXA4MTlKeUtoMjZ2OXJOWXo0emJ0?=
 =?utf-8?B?VmdlYjRSQXg3a3V4a2RaZlljUmxUTXlQN3dhK0RTQnBtTUVBTldGNG4xSDNv?=
 =?utf-8?B?d3dpdTl3UStTdEVrdDBDOXNIWWR4Znowd0Vjd1VxZDJnTnZsZG1XSndYZ0sy?=
 =?utf-8?B?a2NWbTk1WXJoQkNhWE5wNWRIUFczdGswNGFnSjZ6ZDFzSDdFbjJ6QWRRaG5P?=
 =?utf-8?B?ZHpwaVpEQnZ1VnZvQ0UvRXZDd05FcWs1YzNzNjVVVDBSelVNQUFNZVRCcDZH?=
 =?utf-8?B?YVBQYTFDSHQ3R3FQcXdrZUVxL1BUVkd5M3pCRDI0RVdxN0YyTzIvaWZjNCtD?=
 =?utf-8?B?dytSenM3SUFocUNuVWt0SHFLR00rRXhlVVVWYkd5dE9KVEU0cmw4b25mYmhi?=
 =?utf-8?B?WmE5ZGdpTk5yODY4dnl2eWlVdW9kYXlHQkIvK2Rpei9YeWd1dWd6d0JWaFpT?=
 =?utf-8?B?SEI0SE1FQ0Q2K2FQRC9TTXpxa2IxQ2NlWnZMUGZ3RnM3QTQ5Qng5bkhrR1Vs?=
 =?utf-8?B?WHZvRXhPRmFaaEpHQUpyU05wK1drbi9PQ0xnMU1qcno5MXdmMjlIejdMcDhB?=
 =?utf-8?B?QUo4SUdTYXJyV3ZRNkVXUC9CeE1pS0EvNkdKeWZyWVRpUzhuSzV5N2tSZVM3?=
 =?utf-8?B?ZDloZ0tka2JsM1lHL05WMHUyMFFKRXRCYmFkazQ3eU4wR3ZiYjVBcmlaTXU0?=
 =?utf-8?B?QzVEMnJYZFA3MXIxUzRZT3FxL3UyQXlISUxoek5Tb2Q2bldhS3NJL0NVa0Nu?=
 =?utf-8?B?RUZrdS9DYlJWQzJvSC9JOEdHdjBndEJxK05vV3puTHltS2Era0FndHhaYzVs?=
 =?utf-8?B?ejZCNDg1SGs3NlNmMi9SS3ltSFpjcFo3Yjhxc2M5VnJYVHc0SHJtSmV2d1JG?=
 =?utf-8?B?T2F0dXlWRFFmSWVoWXJiL21LWU9pQ1A3S0s1YUREWXMzM1hSeWxxd1l1WGJS?=
 =?utf-8?B?UTRkNXNCRklObTFNUzZsQlZPeVZTSHlxVG9BbGk3MkFGVHNLMEd0UGxpbDhV?=
 =?utf-8?B?ZHVOS2tPUnlIUytyOHBrZ0Z3MUh4SlkrNTVmL2JYamVsbnd6c3FqaTR6MnZZ?=
 =?utf-8?B?Y0VqWUdTeVRLbWFLMHVzSnV2bnBUei9LL1VPZG4wZklkaXZaVDZYNjRPSnc0?=
 =?utf-8?B?c0ljZG1HZWJBeUNlczhBTXZJYWp6Y2gyWjN3WElxRzFFT3ZVbllaMDVhdmdY?=
 =?utf-8?B?WDhyQTRBcDlEMnI4U0tmTnJ0TzFrT3kxNTJUcVJkaUFQaWxFekRkK0VHOHRl?=
 =?utf-8?Q?llW84YnKwUf06bxHN7bOv6HiD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db811d06-be90-4491-2501-08db0e6ac959
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 09:06:41.3566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/z1yUcI20nnHqBzZsNdbPo7uLp/EwF6VF/AJ9LdFiOXj92HaXgs6iaNZZpqxXNI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853
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
Cc: Alexander.Deucher@amd.com, Evan.Quan@amd.com, Xiaojian.Du@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.02.23 um 09:02 schrieb kunliu13:
> implement apu_thermal_cap r/w callback for vangogh
>
> Jira ID: SWDEV-354511
> Signed-off-by: Kun Liu <Kun.Liu2@amd.com>
> ---
>   .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 23 +++++++++++++++++++
>   1 file changed, 23 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index cb10c7e31..d211b1dfe 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -1590,6 +1590,27 @@ static int vangogh_read_sensor(struct smu_context *smu,
>   	return ret;
>   }
>   
> +static int vangogh_get_apu_thermal_limit(struct smu_context *smu, uint32_t *limit)
> +{
> +	int ret = -EINVAL;

Generally please don't initialize return values if it isn't necessary!

This is constantly reported by automated checkers as bad coding style 
since it prevent the compiler from properly warn if an uninitialized 
variable is used.

Regards,
Christian.

> +
> +	ret = smu_cmn_send_smc_msg_with_param(smu,
> +					      SMU_MSG_GetThermalLimit,
> +					      0, limit);
> +	return ret;
> +}
> +
> +int vangogh_set_apu_thermal_limit(struct smu_context *smu, uint32_t limit)
> +{
> +	int ret = -EINVAL;
> +
> +	ret = smu_cmn_send_smc_msg_with_param(smu,
> +					      SMU_MSG_SetReducedThermalLimit,
> +					      limit, NULL);
> +	return ret;
> +}
> +
> +
>   static int vangogh_set_watermarks_table(struct smu_context *smu,
>   				       struct pp_smu_wm_range_sets *clock_ranges)
>   {
> @@ -2425,6 +2446,8 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
>   	.dpm_set_jpeg_enable = vangogh_dpm_set_jpeg_enable,
>   	.is_dpm_running = vangogh_is_dpm_running,
>   	.read_sensor = vangogh_read_sensor,
> +	.get_apu_thermal_limit = vangogh_get_apu_thermal_limit,
> +	.set_apu_thermal_limit = vangogh_set_apu_thermal_limit,
>   	.get_enabled_mask = smu_cmn_get_enabled_mask,
>   	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
>   	.set_watermarks_table = vangogh_set_watermarks_table,

