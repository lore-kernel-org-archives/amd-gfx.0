Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DED0C61D85
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Nov 2023 16:06:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAE5010E4FE;
	Tue, 21 Nov 2023 16:06:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32B9610E4FE
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Nov 2023 16:06:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkHe3U69u+AYG6UO4lBGDPSmuEiAQK+5VXHiPca2AEjCsL2M7lz7zYgkyGiI0oah7x/Eenize/0wVD2jV4HRZxJgOgRApza2y/UFsB4EbwCVkqzbzNtAilg0VZ3jMdURTnITVDgGiEhb/1bqpHtGUp/Q4hkKOKXRiV+sxa7KxK8asLEj9FjGTUPlx5Hy1LuLt1L5UMDg7Ri0PbbnL2+tBEP3iqhyhEenm2TZ537JhNMR0OSA8Os8bt8aGSrPnrJNGqArB7HLxLj9fC1/1P3kMAhIdwNRnrFmB6dygzsJjy6LBWPdkT0y4NkREk5mlDYru10pkKg9SUscdHTXwnkFzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRz1XInLnmG53ACCRSWjlT/RnuLH+h02zrU6XildsUY=;
 b=BlMz0Qk1IPKikwcVb3FGIllI/w1psk+P51LIOayct5WCOSlZHUt2ARA9RD1v0lnRajel3S+pAnOebZU1dforP9CT6bA/dVyVWWHtYboMJdhBSDfgTE7LchYWxwTTTUPuwwnNiTDGI3EIOOXP1tyJ4jhWlR3OMD3zKBGWbbNQm4PJ8L/Csf3ZoAP9nf0G4iLB3opdfqYiy+wEqLK0Yp5Pxu5uPHQULkZAPy5ve0KXAHh/S1kyVxKL7HqHwOluSOCeuGPizv1Nf6Ne6FwTgtNY/rU23/o4bKmekGNuHe99aW70OUcKZShqpnZjPhv7qMfU1g6RbccE+QXRVkNOFSy+zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRz1XInLnmG53ACCRSWjlT/RnuLH+h02zrU6XildsUY=;
 b=ENABLP1PSd+Oh+jcBR7xt23volOV/n50Vd+hRhw2ZZmWL3p6xK2Txf8l6EtDXXXRVvgDKLSjooHxjd/31B9HUpsmjC5RPg7XnMJYTJhCUM5jCX76HmSbp08/ANg4dmRXz4p3wQbLgb/mLs+5QCaUMclCgb/zSCDRcIYiafRglAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB7557.namprd12.prod.outlook.com (2603:10b6:8:130::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 16:06:21 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7002.026; Tue, 21 Nov 2023
 16:06:21 +0000
Message-ID: <6e044163-c7a7-4a32-8a38-390e2b6a3fb2@amd.com>
Date: Tue, 21 Nov 2023 11:06:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Force order between a read and write to the
 same address
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231120174159.22491-1-alex.sierra@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231120174159.22491-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: c29e3cbc-c23d-4fa7-063a-08dbeaabcd60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yQj6jKzyihmlMcqznn4a9c3QtpNIbFkw6c3s6Lssluh9IaMJLeuC3PVDmmRCmVk5kLN7qvjRI4I3mgQJTzUuQBaAoHR5BF7FXs7cp67mo5E16/EOTirmQlFCsJ71FFdnZgthawU/7FsGOn8OU6N3Tvorwi68Nbn1m5THygXMKF8UJ89vouAWTKTFItnWRVwQYdaOo2II+2lNHClb+4j8qvsMT5sow/75HOYl8IrvhMMWjvr7nA8b+C53an45igHbE4KXQJulpXbddWSUdpLlNAYiQlUO7GukIctOBUxrA5j95g12eCGp3V3xm47h+FeTzFyC4yO1HN2tCfhF18Qc82PRiekbZwjSQCPLEBkoc4BuZ5UiIe9O9VZVAxi2iqtBh013ifzzX2/tN8tUD/q8XoUe88DivhabL6R9deHqT0OS8lnQ9ueQu960TpTwB6SiZd3w4sJZfAKZ0Etl2wdQhXB3Pg48lXNCHBBtqv9spe8pNU3ExZRsbhfdA6VCTrroreKQ5tic9umtApbG+us/9/WCk0CcDcrqd5dvGQ8IcArIhJ8HW681H4XXsul5XzlkqxPRAap+F3D2/nAYj9osnVoAtmkMveD/qvtwKFE0U0WdM1q4wsl2RHodm6XpCsDcGOR5vIuFfu+C16Zvfyk6mA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4001150100001)(44832011)(5660300002)(4326008)(8936002)(8676002)(31686004)(2906002)(41300700001)(316002)(66946007)(66556008)(66476007)(86362001)(6486002)(478600001)(26005)(36756003)(36916002)(6512007)(53546011)(6506007)(2616005)(83380400001)(38100700002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THNLVDNLdVEwTkdxOVArRHpYaVpRaTlXMWpZZFNpUGFpZGs5ZlI0cldvZnd3?=
 =?utf-8?B?SWs0N3VrWU04YUJPWEJOMG01dVZQempFcWtaWUEvNjREMnVsVDVVbTJURW15?=
 =?utf-8?B?L0lramtjMUppa2ZQR3d1S1M4c2dOOEQrUENPS1JXeVU4MjhQUDVNeXpQdmQ0?=
 =?utf-8?B?LzJFekU1dzdCUVdsSFR5U1dFc1l6R0FsRmR5SFVqMndyWkZXWFFWa3hjR0tP?=
 =?utf-8?B?TnU3VDZBK1pTUzcyTUl2S2hZM29uaC9ya2NkcjdUK01GYm50NGxsQ0JmRnhv?=
 =?utf-8?B?bHZCa3VyNlE5Q2k1T0Z5cFVGQ2JEZnlYMUUraCtQUzRrSlFobzJIdDhsK2hh?=
 =?utf-8?B?NmVBYXJEb0xuSmFaRTJyNGF4anU3djN0RHdsQ29DRnhKWUlKcElNSUZxcnBp?=
 =?utf-8?B?b20wbEw3OFUveWV2SFZZZTJHc3g5ZVpjbHFkQUlQTGxENENFTFJzQ3ovU3hJ?=
 =?utf-8?B?Z2pkZDdjaWpscGJHZGt1Y0VjSlQvRndvdFphRFF6czRpZk9oWlk0Nk8vNVNR?=
 =?utf-8?B?MVNzT2lyWXJMbDdTUnlGRFJ5MUNBd2E2QzVzWTkyNVJDQWorbWFvWDFCS05L?=
 =?utf-8?B?TlJiZ2dscGY1R0RrMHlkc3NhZGpkS21zaEtJYnI3TGxzdVNKcmZQZ3FON3lR?=
 =?utf-8?B?WCttdFR0clhJV1cxWndYbUVRZXloTWpWWVZYNVpTNi93c1VacnJuQkZsOGo0?=
 =?utf-8?B?NDhzamdabVhOUTRMYjl1WjFtbVNkWitTRkJEeEFudngwQjNPYmtiQ2NPcGRn?=
 =?utf-8?B?dTlKRTlpUUttekxROGR5V3ZBZkF1SmNHY0tIaDI2T3d1dElzY2dPaW4wNnBU?=
 =?utf-8?B?ZkY2MkNra3FLMWg1dGVmL2ZXRDI4eUxidDFUK2hERUxOc0kxZjgzeEhCRExz?=
 =?utf-8?B?dHN3MXRwK25DakFuTCtGYmZKa3dVZkgwemNLZDRYM2J0QnpNRXhydkhLMzBG?=
 =?utf-8?B?R3hndUlJN1VWSEFmTldOVkhMN2ZUNmRKUjVZUkdXSFc1L0lFY21sSlhEbm1D?=
 =?utf-8?B?Q2lNM0hBMllvYjVwMngzODBKY1NSZW1WRGNoYndqUERORTRPOHFDZDFCenB0?=
 =?utf-8?B?SnJoVFJxeVNwUGErb3cwU01ua0lhdWFlRmVHWHJzWXJuWVMwUzU4RlkvbmZZ?=
 =?utf-8?B?bGtrcW5NOFJIdnBsQ1FKRHZEWWp3UTZyWDdpV2Z6VUtQZGNjb2VCMldoTTVL?=
 =?utf-8?B?N2dqL2IxWGdIT1hBNVl2N1VqcnR5MDJBY2Z3L0tGeC9wUWhiNWRBMmRaUDhk?=
 =?utf-8?B?MFJuTEpzMFA4YVV5L3E3YUtFeVZqSS82Lytvb1hRVHV2Y3NPS01jTGtwVC93?=
 =?utf-8?B?R1YzbDBXNk1JS0ozeDFnZkoydXpURmxHTTF2eUxsdmNoL2p2SklTdVZpb1Rp?=
 =?utf-8?B?VDdSQkhUelFzNUZaNmx4TzJSc0xKdHg0M1RXVlpuWjJVd1ZnSTR0VUllTzBu?=
 =?utf-8?B?dnlhS0h4U3FobXNSaWVvdTl4ZUluN3hvYWs2YWVOWkh5SzBuTWoxSGw3MVUz?=
 =?utf-8?B?M1Rhby8xQXd0UFFBYUcwY3Y3TnV1QTZwaHJtOVVRRm9zR1hTKzRjMEIyUWM1?=
 =?utf-8?B?UlVNbThVUEt2eDdaMFd2eFZlOFNaOVJoRC9jN3NLaHk2TnFTOEYyaEdXUWMv?=
 =?utf-8?B?cVhHNkZCYnp4MU91V01YcTFnbGxBK1QzdnRTWnArYnVqa2RaU0NZNDhINitK?=
 =?utf-8?B?RzVwNmdqcFpLd0c0Z1BlRmQ3OFRzaHNXVWQzZGwxaWZwQ0xHVGk4OHlRVEZT?=
 =?utf-8?B?UUVLdUtKMC9kdDQ2WXM3M0dlZlVYRkEvNThwZ1hhZDBEZUI3N3Z1OEN4U25Y?=
 =?utf-8?B?Wk4rZlJUdFdSQkRKaDE1QXB1THEzSFZTdEZDOHo1ZXJTb3ZHZDVwbzJpaU9B?=
 =?utf-8?B?aEJkdWFmSXY3TG9NeGRoSjdDWWx4OUl1dTBHQXJxcU43S0FuZ3cyOFEydzl5?=
 =?utf-8?B?MnZmNE81WXo4aDY1Qmh0eGpVRjVYVUpxemI1WlR4Y1J4aTFmQ0hRN255T25x?=
 =?utf-8?B?YWhWWFd2WEV5ajJYUjlxMHNVWEIwYkRpOTZQb2wyYUVTVFllNTlUZk5HUzBK?=
 =?utf-8?B?clFGLzh6WDJWRVBUbkE1cEU1RDFxU2FxalpuTzNrWGpDN3ZjbVBUQmhVb08w?=
 =?utf-8?Q?qPu460tkSuiu2kvPa2MCQGDkH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c29e3cbc-c23d-4fa7-063a-08dbeaabcd60
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 16:06:21.0622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omUt+b3NjfdHdzkLRgC1nxBTIYy2kuHKA71sb5RXdK9z7ldl6xMoVyfhu+JDY7vvpFSN3so7QCseK6+j03H1Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7557
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
Cc: joseph.greathouse@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-11-20 12:41, Alex Sierra wrote:
> Setting register to force ordering to prevent read/write or write/read
> hazards for un-cached modes.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                    | 8 ++++++++
>   .../gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h    | 2 ++
>   2 files changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 0c6133cc5e57..40ce12323164 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -89,6 +89,10 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_0_me.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_0_mec.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_0_rlc.bin");
>   
> +static const struct soc15_reg_golden golden_settings_gc_11_0[] = {
> +	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL, 0x20000000, 0x20000000)
> +};
> +
>   static const struct soc15_reg_golden golden_settings_gc_11_0_1[] =
>   {
>   	SOC15_REG_GOLDEN_VALUE(GC, 0, regCGTT_GS_NGG_CLK_CTRL, 0x9fff8fff, 0x00000010),
> @@ -304,6 +308,10 @@ static void gfx_v11_0_init_golden_registers(struct amdgpu_device *adev)
>   	default:
>   		break;
>   	}
> +	soc15_program_register_sequence(adev,
> +					golden_settings_gc_11_0,
> +					(const u32)ARRAY_SIZE(golden_settings_gc_11_0));
> +
>   }
>   
>   static void gfx_v11_0_write_data_to_reg(struct amdgpu_ring *ring, int eng_sel,
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
> index c92c4b83253f..4bff1ef8a9a6 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
> @@ -6369,6 +6369,8 @@
>   #define regTCP_INVALIDATE_BASE_IDX                                                                      1
>   #define regTCP_STATUS                                                                                   0x19a1
>   #define regTCP_STATUS_BASE_IDX                                                                          1
> +#define regTCP_CNTL                                                                                     0x19a2
> +#define regTCP_CNTL_BASE_IDX                                                                            1
>   #define regTCP_CNTL2                                                                                    0x19a3
>   #define regTCP_CNTL2_BASE_IDX                                                                           1
>   #define regTCP_DEBUG_INDEX                                                                              0x19a5
