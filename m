Return-Path: <SRS0=ROs4=M4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A895C4338F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 09:08:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD9A161029
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 09:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD9A161029
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B96B6E42E;
	Thu,  5 Aug 2021 09:08:08 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2042.outbound.protection.outlook.com [40.107.212.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C756E42E
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Aug 2021 09:08:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOzu0BoCFeSAqEAwY3n9dautRfHmz++ZfwPznoXa6J0WOmfAF4At7PQoi5rGCsp3qyh87OtlCrdR8H+U7XWfoAspzzMX15PjNYhg+BQ7GWmYowIV1a+SXKDcGHCWqTN80kopC7j8nyTBOlsu9zSif635OeN8RfhkUmoYC+YK7g9aDBZ4HMZZ29tfXz8StigVAxCsBYuvywgxntAkZpV4jLbjNbtT1FB7uJ3iY9PdHwdz+RsjnrfTgbq095Upez/Gv0Geet045y6eM3Pjs/aBOdxhzcnrR7kvpmcZYGBFcnIaoKu0h4ioyC9C1cclGasLCX3yFXtzxIF7fbiviUPDTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGcNIk7LcCncOhWQ2441g6kb68gyvTaG5ppinesqzo4=;
 b=kpWZ6TJEYxRi1nwBKYbGT6jlPH6b7FiPCDoHzE1+w7yxacrkOyRZ4JL3/V9EMnv/isROfa+8sOeC1MRQ9Xkt0FDkuJF/5J6+83rwHYQAN8TE+mjbjM4oOJ83LREhVmU9Du6eViq1iP+AAsU0jCXbUiwlMKn6gbiklRWH3YOZVGQiK1Mq04AB2Nqcxqv47LLIpDKvZcGA3xsUbfiauuDzwfkvqQYDvUi6gQznwvnEoqoCKM9lR40rS1VL3mfUEeWrRD+kgLqpulF5xRfMJ7oLxqoKzkqZZkNySsMXXp1WshmbRi2qIhldHvSjJ46YbZg0qRnnSW0udb384Sy8+Imk9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGcNIk7LcCncOhWQ2441g6kb68gyvTaG5ppinesqzo4=;
 b=SjMeaxIeTyu+BeijcfLa6moCGVTx1BBJioyO91iWq1aZZN7+BKKWebKdEosc6PpWI4rrLQxsIGnc3+NRKJkZnRfjo0RdPrIWFNNJuLXbNJ4/2vId8UbFfQwl8d92A+6k2IlyFgTA0aLTygMoRfsUr+CNlTM9PUuq1UZa6/dAqpE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 by BN9PR12MB5227.namprd12.prod.outlook.com (2603:10b6:408:100::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Thu, 5 Aug
 2021 09:08:04 +0000
Received: from BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::e1cb:9940:1924:50f2]) by BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::e1cb:9940:1924:50f2%6]) with mapi id 15.20.4373.026; Thu, 5 Aug 2021
 09:08:04 +0000
Subject: Re: [PATCH] drm/amdgpu: enable more pm sysfs under SRIOV 1-VF mode
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Nieto, David M" <David.Nieto@amd.com>, "Deng, Emily"
 <Emily.Deng@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210804075024.9407-1-Jiawei.Gu@amd.com>
 <CH0PR12MB5156021023502CABB4EAE1F8F8F19@CH0PR12MB5156.namprd12.prod.outlook.com>
 <CH0PR12MB51564DA6D0636BE10183A79AF8F29@CH0PR12MB5156.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <74fa9879-6f8c-d849-b9a4-a5ddd6fe3c04@amd.com>
Date: Thu, 5 Aug 2021 14:37:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <CH0PR12MB51564DA6D0636BE10183A79AF8F29@CH0PR12MB5156.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::16) To BN9PR12MB5356.namprd12.prod.outlook.com
 (2603:10b6:408:105::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN1PR0101CA0054.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Thu, 5 Aug 2021 09:08:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94bc32cc-eb87-4acc-4298-08d957f08813
X-MS-TrafficTypeDiagnostic: BN9PR12MB5227:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB52275F8747703F9C7F6124CE97F29@BN9PR12MB5227.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: STi55+/qVgs9Tl9q07ZeurC20N6ImmOvXGXEIDx1XSxwWNXWhCZkH6omUccllC3V8xQvGeFl9FP05cIDJaz98LtNPiWIIph8t61kc2bJKC/yygQb7r16nODcMS8w+Ibc1iyDl1dQjqu0yD2G2k+nxdj+UJtMXWftqLlRdHQEQi1GQv4ON4DhUbWoqke2dClXJPsS+d3vR9+hT/mNwuaTVGnTYXH8FjlRPW0+rEv4e001cQDvlPoWcs6LHQP1lxk1uVELHMyeIxUWp1NDDW1netXlWHMO5tTEIQIPQsDi8ad2UZmcCA8fG1thIsFJxYRX5MiW3qXlgOz3fcNVMzP7hMb7MVTPk4PsbQuDEw6wS/TXP3isSNlHyQaU5TSAU20k8mWpnRnK/nBCZZB6iNv6OSieWmT1UX2CUgNDOWF2RS2+1n9++ykJKA9zF/kefjDW/Z4sGi2E3LnHVCATbMtJrwm6WbBaPKBUrs921UyVY3ftpT7eem6TklLPN7KwuU26C4Y7Go8KzfUmUv2WtTxo9MCz5F/5bel8u2NOfCJB2EA1O7OuZGgmmviDE6zlqsWc2y1g9FzrFX49dWetRjgv9vB2NMlG+ptAZ5Ri0tHWoJPrwtEB2h7frNqeCCVpttFRHCVp/EUYP1i7HzX6XeXOqZC2odt4osNajLLJLlSQ/2YPIT1T3l6VBoXT8bevL0Ht0TW3GlKZpruJ9+jOxyv+D5ViKlJVft0hl2S63W7ub5n16qL1O24Tbyp2BRD6lTYH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(66946007)(31686004)(6486002)(4326008)(53546011)(66476007)(86362001)(186003)(66556008)(31696002)(83380400001)(26005)(478600001)(110136005)(54906003)(316002)(38100700002)(8936002)(16576012)(2906002)(2616005)(36756003)(5660300002)(8676002)(6666004)(956004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vnc5MnR0cGVGRDJQQVNCbkF5L0M2YVNXVUg5RktRZCsySy9XUEZ3UlhWZGhO?=
 =?utf-8?B?QVhDajQzcVkweWRGSjJFcmNsTlN6aVpzVlhqZlhyaGJLRXNWSGRSbzBDVGlS?=
 =?utf-8?B?dGpRV3g1UGtjNGk4bFhaL2xRM3B6RUZ0c3hrejJkZ0FSQkRneWlWcUZlWVRa?=
 =?utf-8?B?QXkwUTVUNWhzN2pRRlZLeGNIWkN5M2xzaHJBRldTbUcrS3JYT2NuWDdsaU1F?=
 =?utf-8?B?c3hqS2NZTFlDWXE3c25QYzFvOThvdWE5Z04zOHd3MytVblJsM2RlaGtRVjZ6?=
 =?utf-8?B?VkwxeTY5Ym9nbDNXeUsxa2pTM3I2cUxqdlNtNStxNXVNeVV3ODBqUlpLSHJ6?=
 =?utf-8?B?VmRhaHdCa0k4eTg0MUNrQW1qMFI0MFdiTmFPemJwKy9CVXl6dlRONkc0bk9O?=
 =?utf-8?B?Y2E1d29ZTGtldFh6SnhjVjFySTNzZERPYkVXZmw3bENNZGhNQy9tdDR0L1lK?=
 =?utf-8?B?aTJRQUVuZG1ERk5mV2RBRG5oK01QckRsV3NKR3VvUFFUZGhDOU84RlVLaUpL?=
 =?utf-8?B?VHZycDZMMzQyb1podS93M3ZUT3BJdE1MRG85WUM5aGJvaTNzWkgvcG05ZHdt?=
 =?utf-8?B?cjV0R2ZLb2g3UVFoN2ltLzMzcG0wYTVqL1AySUN6WVZMMDhpZ3pnSG1qRkly?=
 =?utf-8?B?eHZUdkZEb1JmOStOSXgyYll0QSt0RkcxREwxdXZqa1V0dVZUQ2lhZFVzZXQ0?=
 =?utf-8?B?L3Jlbmovc3dsWVhWM1pjSy8rdkt5THEzZVlFMitHNU8rTXhISUwxTkZzZjdF?=
 =?utf-8?B?QUUvalNIdTVpazBSSXlnMnpRUDdpNE16eE40Zm12R2pUZkNNWWZSeWwyWk9w?=
 =?utf-8?B?aFhoRm5hclV0T1RsdG5PdzBXY0U3VTF6SjVsazUvcTduYytybXlrQU9udml0?=
 =?utf-8?B?ZzdLbzdMTlVtRHF2S1pxVm0va2hocmhvdUdXaDVNcFg0U3hSNjBjazVXaXVD?=
 =?utf-8?B?ZktDUGVtUGMrZVJraStqaFVPSXhxZ09FZ0J6UDRGbmN3Vm1lZXZidW41TFho?=
 =?utf-8?B?UDViRkQ0MytDamtmc1VrT0xQOS9EQzFXTndhOXQ2clRyWnZhZnpqcXZ6YXpx?=
 =?utf-8?B?NnJ2VDRKbk5rZnZXZ3FtMWhjamZOakVsNEFQRStDQVFIdmEzdktJOTJSZ25I?=
 =?utf-8?B?YnlqL2V3ZXI1b1RoMHAweFNwZmozdUt1cURkTnh3bldqRU9CZWM5R1RvRHJx?=
 =?utf-8?B?YTdVYWs3bGo3R1lyRjZ3S3Uzak1WNmxRY1d0Q2NBMC9oQ3dmeFg0STRxQUta?=
 =?utf-8?B?c2s1S3lyNEVMU2hrV25QUTFOVU14VzVzc0psRFhZcGZ2T1k4RHIvS2Zqc2V3?=
 =?utf-8?B?Q2d3NFNkYUEvZXdHK2FtRmRIVFU1L2NMK2JxdmdQRU44ZGVlVE9JM01md0pR?=
 =?utf-8?B?Ny9aQ0gzeGJQdzdqbDlvRHlCcnRndkxoOEs3MXhGWXpzeWk1RDNnVy9Rd09O?=
 =?utf-8?B?VHRodWVlTGl6M2p2bDdjY3dUbENHRVp1YXFyVktFWXluY0JKdkF4Uk8yZmNy?=
 =?utf-8?B?aDd0WE1YU0dXSVh1NWJYRk9TSVowZVQ4Vng0bnVLZVdhOW41bmdKSjBKdUM2?=
 =?utf-8?B?UnVyc05lTi9JSnJaOGtNU1lLTWx3cjJ4TFF6dnl1Z00rTWJvV0p4UjZmNmNC?=
 =?utf-8?B?MWFMOGJCRFdUS01tbEJBdDloNmphWXVLcGxHN2FiVGNydC9qU2M1eDh6cGs3?=
 =?utf-8?B?ZzAxUzh3eTNybjk1UUtZdDBnVmhqS3RXQ3pBeG1IaXg4QlZpMCsyZEZsVVNI?=
 =?utf-8?Q?FmVIq9IhB5Nx63+JPiACEuHTaS7ByHckGStsFGk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bc32cc-eb87-4acc-4298-08d957f08813
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 09:08:03.9742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2gDNUFWPElZj8+QYSZPY/jhM2gUGkqajE8nyrqEr6LzFyTYGcVujY9YUjLNJola
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5227
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



On 8/5/2021 12:01 PM, Gu, JiaWei (Will) wrote:
> [AMD Official Use Only]
> 
> Ping.
> 
> -----Original Message-----
> From: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
> Sent: Wednesday, August 4, 2021 4:08 PM
> To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Nieto, David M <David.Nieto@amd.com>; Deng, Emily <Emily.Deng@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: enable more pm sysfs under SRIOV 1-VF mode
> 
> [AMD Official Use Only]
> 
> Add Alex.
> 
> -----Original Message-----
> From: Jiawei Gu <Jiawei.Gu@amd.com>
> Sent: Wednesday, August 4, 2021 3:50 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Nieto, David M <David.Nieto@amd.com>; Deng, Emily <Emily.Deng@amd.com>; Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
> Subject: [PATCH] drm/amdgpu: enable more pm sysfs under SRIOV 1-VF mode
> 
> Enable pp_num_states, pp_cur_state, pp_force_state, pp_table sysfs under SRIOV 1-VF scenario.
> 
> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 769f58d5ae1a..04c7d82f8b89 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2005,10 +2005,10 @@ static int ss_bias_attr_update(struct amdgpu_device *adev, struct amdgpu_device_  static struct amdgpu_device_attr amdgpu_device_attrs[] = {
>   	AMDGPU_DEVICE_ATTR_RW(power_dpm_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>   	AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> -	AMDGPU_DEVICE_ATTR_RO(pp_num_states,				ATTR_FLAG_BASIC),
> -	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC),
> -	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC),
> -	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC),

> +	AMDGPU_DEVICE_ATTR_RO(pp_num_states,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> +	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> +	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),

Which ASIC is this for? As far as I see from the current implementation, 
power state is not supported in swsmu projects.

Thanks,
Lijo

> +	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF) >   	AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,			 
ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>   	AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>   	AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> --
> 2.17.1
> 
