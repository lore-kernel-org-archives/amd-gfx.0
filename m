Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E40C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 07:48:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA3B610A1
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 07:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2FA3B610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCF866EABD;
	Wed, 22 Sep 2021 07:48:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF5F46EABD
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 07:48:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bO+N1hWmx6v9gJnu/9UTn2wy2i9Fqj30A5sKU1lXl8+H/g4LNyCppXO3vShFPtphHQBRlDwOwO2BgWzK5cQAqqvC+vugQYRcnTLG6lkNRp/hx0q9gjYwwY/UUCDBZE3zyVEsYoa/1y/v1UViGNX16JaqhGEAl3P3emZkEMjfH3Z1MgQgl4yvqTqT4sS/JqQntLi0Fkl+pOgWs5vVKYFfB6CExZuITzy55y1k7pTafZcwsBheD4EjfzeEUcw2nBDo/fG5mDoLrs/qTQZ4Eo/Xm/rLWf3OzmplSKv0evuXXiTWHlnal+PgkSijG0hB9giTMJDbmnyRYjccuu/K5ExFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Q2Y90kP+XFC5VKFi55AuOKwIaouJjW79gI+IKeLUs9U=;
 b=BjUEPbaUUcZITPoizRB1423QNZiukFl2m9IIqbfn+zsn3YL2Hne0fyk5jS1DMue06BRXXQy2UrFL1+PlWwGrO8+4dOu6cEn28tY+paE6P5DUijhJXBR1j1MpI7MYmd8VqJa+YghOVXm16ex6vzH6F1XXwalxGbS5ttR+NILQV6hPIzDUaLKPNXwZUCDPtX1EHJfTzxw37pkhvmNh5P/C0Vct14pfaizw60en9NstjurxOwVnxSdvcltnbImjt+KdyaUKwbYxbqLth/NldRyA8pw2P8yRWh+rjcSi0NPrvtaxhwa/dFWtZEHewa9l8ZB1tGu2/FMUzYJfkDkLA45BPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2Y90kP+XFC5VKFi55AuOKwIaouJjW79gI+IKeLUs9U=;
 b=yyhVgfmJSkpkdoyRqz07P524faMg1cVSwXTkpXFeOSWPPJM8LZyzNVJhnyuMOqLoXBlzZr27fOglbT2o5fb2UIeKF9kG86C8RgkO3Owz1NJIExDTPqRUiMgUw4u/1HNVSQHHNoQAQQz1ZZdo9U6ufIwo6If1uIh48B+vnFTv+MU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Wed, 22 Sep
 2021 07:48:43 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57%7]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 07:48:43 +0000
Subject: Re: [PATCH 33/66] drm/amdgpu: add initial IP discovery support for
 vega based parts
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-34-alexander.deucher@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <4ba25973-3fc5-7d89-e70b-2d55c1b27367@amd.com>
Date: Wed, 22 Sep 2021 13:18:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210921180725.1985552-34-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0137.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::22) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN2PR01CA0137.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:6::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 07:48:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db432dc0-068a-403e-12e8-08d97d9d6612
X-MS-TrafficTypeDiagnostic: DM6PR12MB2939:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2939551D76F71DC063161D8C97A29@DM6PR12MB2939.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aCxWXTJggYCglfGcTh5WnPZBoRMIzextEjVQshkSxyoWdD99UeEQkT/Ar+QoqN98hY0t+sKUYiPGMUaj3D8PjGPVv3Khk1Y9l61cxon+QYJO/+3iToB+coC9a72dc5ZrW3ZGB4hFhlL8Es++iEX0rcDqYGUHXyUMuoR8mnRzhamMRxQ6inoz/PE2NqVTyZMoqo9NvBFM16h0aw7KIj9AOXciUvCmSorlISGJqy+CV26NNOXiJxD5UlxVTJ+9MNLqyf2UezSYUcWDd+WvWz7/RlirmAqWivj7nXN78V/2PpN5/QVOvoNfSOwzrbsKI67Kha4fPF+2dbTvw10zePjYGtR+o9elmvnW45Ni6HtmOgV63AQdcUwmepwC4r4rx+fYTsXgwAQtOZceuOVvGGri7NaNLfSU0UTrwvVJt8JrfOATf0RItovy91O5qjrnUc5uHPP5qnQlA9KBLcL1jEe71WEJtGE4RwO4dkN6JpQ0cNJpMJ0P5SAZoBS+6idx11ZhaM/STj74Dd6n277Zf6imoCigW/IFkEgC9q4aCOmoHLMinwIM+uwu0lDOiWrrnkkxaovx+DrPpKu26Y6hodukEt719OYCcu94tcmBj9iKLtfNvwrxQ41WH7jQ+imxpZtA7gyL3Vp9w8y31knhSONOGN5b2ks6QvZNqq6ocPFbyjWR/PAY6IKj7wzsoiqPVI1odByK/Te+0ojXYNgT8Kqd9mRpZEV5yOJ0Roo256skWDE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(16576012)(8676002)(66946007)(66556008)(36756003)(31686004)(8936002)(5660300002)(83380400001)(956004)(6486002)(38100700002)(53546011)(2616005)(30864003)(508600001)(86362001)(31696002)(186003)(66476007)(26005)(6666004)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUdOSVlBQitWa0tnbXlYTisvdmV1Q0t6TmpLMWE0TVBXL1VUUFI1V24zRVUv?=
 =?utf-8?B?U1BIaklkN2p6c3hiY0pQMFBobGRGWHNZOUR1M2xhZTZaeDZCUG4vTFdMNHFm?=
 =?utf-8?B?SmNZd0RvNVl1MkhNcUFpOU8zcm5SQ1RJRFJaeW84eTZaNDBvNXQ2ZXZuckh2?=
 =?utf-8?B?VElNZjJLTi9pRVBEbmFIRXozb2JkZDZ0QUhuaTVwSm5SYTA1c2xQTWdYc3ZH?=
 =?utf-8?B?dU9namJBWCtwWGw3bnNMMk96TnhyL3pjOHA5bnBJek9YWXB0UkorNk8xWHVM?=
 =?utf-8?B?MnlDeXQ2N2swaDNEOGk3TU82c1pHZzkyR0FEUm9iTENuZ1dhdWwvTGt0cVhO?=
 =?utf-8?B?emZjZEVwNFZYT3BsYW1USmdvTFU5S3JOd3JYbW1Ib0ZKcTFsaEVOUGg3T092?=
 =?utf-8?B?OGpSbWdmcXhOa202MWVZWmg4Z0FIT2VwelhDWHBUc3dqRVdtNUlIU1owMml6?=
 =?utf-8?B?UUtHTGlsL3YwRXppWTVmZzdLRk5BczMzK3cybU9BNW1mSTE2R25TUEJlVEln?=
 =?utf-8?B?T3krZU5ES1VxT3N0akkvd3VBS1F3WEJ1aktJZEhOUkd0WGJ4a0IxNlVVdko4?=
 =?utf-8?B?Sy9sUmJFRzN6cDVBN0J5cVVNb0puRmkzWjh5MHFQUU1iRHJNajNVUmp4TXRx?=
 =?utf-8?B?Vng4ZDVla3k3MlF4L1JGZFlSelVpditjbVJSQzJqbnl5VEZVNjNWQ0JHeGtR?=
 =?utf-8?B?MGhaN0dUYkFFUkI4ZURvanE3MXpGcU12L254R2dnWHZldUtrckVuZTN6NWlF?=
 =?utf-8?B?UzNwdy9FSkdyTEFSVm9EWHhTWE9GZDhFVkFyQ3JSNTY2anNwVDBCMm5tWWxv?=
 =?utf-8?B?cUROU3M2bTdjeStWVmlhNmsyeUJhZVBRd3BaK1hpelhWV1FxRVpMeG1UcjBR?=
 =?utf-8?B?MHFicm0wUkFpaWxNc1QxelErQWs2emNqdUNsbDY5NUM0aCtBUmY2Y083aCtr?=
 =?utf-8?B?QVArcXJZSm9rYmU3NFNXNDJBQVlTODBlKzRZeU10K05QT2VzclY2dndJeW4r?=
 =?utf-8?B?WG5rd3ZPV0RkMEh2UzFFOXVvR1JjUW1WSEczMXpDcEhSbUcxSWxSOW5oT0Jx?=
 =?utf-8?B?Z2xRU09PS1o5VjV3cHVxSnlHSFhKNmNONFdyakFVUGYwVy9DNXlsSWdRT2RR?=
 =?utf-8?B?VVh3ZmpQdU9YZkdwOG1Ec0tBanoyVlczRnFzTGNZTlhaaVhmM2VBNDEveVo5?=
 =?utf-8?B?OXF2QUE1cG43QldWOE9sUjZQZDJjNFBXWjZpVS8wK0JDNmpTQjR3VkRvNU5K?=
 =?utf-8?B?STNhbGdKa3NjaWtKT2htQWRmdW52YlFtRDhZZEtBa2M2Rms5UzJaRldJZytt?=
 =?utf-8?B?WXUxaTJYYlBhNGQ4cy9NWjVSaVBUdHVNSVQvcEh1cEZGa2ZZSmttcDZOUmpm?=
 =?utf-8?B?Z2J5blRzbEl2UUhIMmZrRzBJY0ZHNHY3OFpCQmlXaG55bG5JUTc2ZysvbEVs?=
 =?utf-8?B?ZDd3NDUxMHVyNjFPbXhpUUY4M3hlZk9VRG16NUNKdkVSdkxML1BmTnI3d2to?=
 =?utf-8?B?OXZ3ZDBEUWVONGMwdUxHMTBselZHZVlNc0ErRE1xSm5WNWZxTDJiZEVpY2U0?=
 =?utf-8?B?bmhldkg4WXpZQWYzcUlDQnhoMXdCNE1ueG1sbDFGc2pwOVFqTDA4aWtQdDZR?=
 =?utf-8?B?TDVScGJTR1p6MEJ3OGlBVjRzYlMwRFRPRmVLRlg0a3gwaDZtMXpCa3c3N3VE?=
 =?utf-8?B?RFlGL2UvMVZ4aDl5WXRrdGp6bDFwRytkNndlWG5FRXcxWTRCOCtTajNEdUFa?=
 =?utf-8?Q?Nho6s/CGmn+FZBkeJhdubMxRoV4dA0beset3tV1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db432dc0-068a-403e-12e8-08d97d9d6612
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 07:48:42.8891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6R/7RjwqNyOJYBbFDD7w1oU6Ah3Uwj+rfJuHHGamLR4I385LHCTtUoDUQxTNKBX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2939
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



On 9/21/2021 11:36 PM, Alex Deucher wrote:
> Hardcode the IP versions for asics without IP discovery tables
> and then enumerate the asics based on the IP versions.
> 
> TODO: fix SR-IOV support
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 417 ++++++++++++++++--
>   1 file changed, 387 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 6a993043badc..e3b4578872f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -26,6 +26,26 @@
>   #include "soc15_hw_ip.h"
>   #include "discovery.h"
>   
> +#include "soc15.h"
> +#include "gfx_v9_0.h"
> +#include "gmc_v9_0.h"
> +#include "df_v1_7.h"
> +#include "df_v3_6.h"
> +#include "nbio_v6_1.h"
> +#include "nbio_v7_0.h"
> +#include "nbio_v7_4.h"
> +#include "hdp_v4_0.h"
> +#include "vega10_ih.h"
> +#include "vega20_ih.h"
> +#include "sdma_v4_0.h"
> +#include "uvd_v7_0.h"
> +#include "vce_v4_0.h"
> +#include "vcn_v1_0.h"
> +#include "vcn_v2_0.h"
> +#include "jpeg_v2_0.h"
> +#include "vcn_v2_5.h"
> +#include "jpeg_v2_5.h"
> +#include "smuio_v9_0.h"
>   #include "gmc_v10_0.h"
>   #include "gfxhub_v2_0.h"
>   #include "mmhub_v2_0.h"
> @@ -45,6 +65,7 @@
>   #include "mes_v10_1.h"
>   #include "smuio_v11_0.h"
>   #include "smuio_v11_0_6.h"
> +#include "smuio_v13_0.h"
>   
>   #define mmRCC_CONFIG_MEMSIZE	0xde3
>   #define mmMM_INDEX		0x0
> @@ -485,23 +506,166 @@ int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> -
>   int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   {
>   	int r;
>   
> -	r = amdgpu_discovery_reg_base_init(adev);
> -	if (r)
> -		return -EINVAL;
> +	switch (adev->asic_type) {
> +	case CHIP_VEGA10:
> +		vega10_reg_base_init(adev);
> +		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 0, 0);
> +		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 0, 0);
> +		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 0, 0);
> +		adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 0, 0);
> +		adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 0, 0);
> +		adev->ip_versions[DF_HWIP] = IP_VERSION(2, 1, 0);
> +		adev->ip_versions[NBIO_HWIP] = IP_VERSION(6, 1, 0);
> +		adev->ip_versions[UMC_HWIP] = IP_VERSION(6, 0, 0);
> +		adev->ip_versions[MP0_HWIP] = IP_VERSION(9, 0, 0);
> +		adev->ip_versions[MP1_HWIP] = IP_VERSION(9, 0, 0);
> +		adev->ip_versions[THM_HWIP] = IP_VERSION(9, 0, 0);
> +		adev->ip_versions[SMUIO_HWIP] = IP_VERSION(9, 0, 0);
> +		adev->ip_versions[GC_HWIP] = IP_VERSION(9, 0, 1);
> +		adev->ip_versions[UVD_HWIP] = IP_VERSION(7, 0, 0);
> +		adev->ip_versions[VCE_HWIP] = IP_VERSION(4, 0, 0);
> +		adev->ip_versions[DCI_HWIP] = IP_VERSION(12, 0, 0);
> +		break;
> +	case CHIP_VEGA12:
> +		vega10_reg_base_init(adev);
> +		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 3, 0);
> +		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 3, 0);
> +		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 0, 1);
> +		adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 0, 1);
> +		adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 0, 1);
> +		adev->ip_versions[DF_HWIP] = IP_VERSION(2, 5, 0);
> +		adev->ip_versions[NBIO_HWIP] = IP_VERSION(6, 2, 0);
> +		adev->ip_versions[UMC_HWIP] = IP_VERSION(6, 1, 0);
> +		adev->ip_versions[MP0_HWIP] = IP_VERSION(9, 0, 0);
> +		adev->ip_versions[MP1_HWIP] = IP_VERSION(9, 0, 0);
> +		adev->ip_versions[THM_HWIP] = IP_VERSION(9, 0, 0);
> +		adev->ip_versions[SMUIO_HWIP] = IP_VERSION(9, 0, 1);
> +		adev->ip_versions[GC_HWIP] = IP_VERSION(9, 2, 1);
> +		adev->ip_versions[UVD_HWIP] = IP_VERSION(7, 0, 0);
> +		adev->ip_versions[VCE_HWIP] = IP_VERSION(4, 0, 0);
> +		adev->ip_versions[DCI_HWIP] = IP_VERSION(12, 0, 1);
> +		break;
> +	case CHIP_RAVEN:
> +		vega10_reg_base_init(adev);
> +		if (adev->apu_flags & AMD_APU_IS_RAVEN2) {
> +			adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 2, 0);
> +			adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 2, 0);
> +			adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 1, 1);
> +			adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 1, 1);
> +			adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 1, 1);
> +			adev->ip_versions[DF_HWIP] = IP_VERSION(2, 1, 1);
> +			adev->ip_versions[NBIO_HWIP] = IP_VERSION(7, 0, 1);
> +			adev->ip_versions[UMC_HWIP] = IP_VERSION(7, 5, 0);
> +			adev->ip_versions[MP0_HWIP] = IP_VERSION(10, 0, 1);
> +			adev->ip_versions[MP1_HWIP] = IP_VERSION(10, 0, 1);
> +			adev->ip_versions[THM_HWIP] = IP_VERSION(10, 1, 0);
> +			adev->ip_versions[SMUIO_HWIP] = IP_VERSION(10, 0, 1);
> +			adev->ip_versions[GC_HWIP] = IP_VERSION(9, 2, 2);
> +			adev->ip_versions[UVD_HWIP] = IP_VERSION(1, 0, 1);
> +			adev->ip_versions[DCE_HWIP] = IP_VERSION(1, 0, 1);
> +		} else {
> +			adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 1, 0);
> +			adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 1, 0);
> +			adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 1, 0);
> +			adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 1, 0);
> +			adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 1, 0);
> +			adev->ip_versions[DF_HWIP] = IP_VERSION(2, 1, 0);
> +			adev->ip_versions[NBIO_HWIP] = IP_VERSION(7, 0, 0);
> +			adev->ip_versions[UMC_HWIP] = IP_VERSION(7, 0, 0);
> +			adev->ip_versions[MP0_HWIP] = IP_VERSION(10, 0, 0);
> +			adev->ip_versions[MP1_HWIP] = IP_VERSION(10, 0, 0);
> +			adev->ip_versions[THM_HWIP] = IP_VERSION(10, 0, 0);
> +			adev->ip_versions[SMUIO_HWIP] = IP_VERSION(10, 0, 0);
> +			adev->ip_versions[GC_HWIP] = IP_VERSION(9, 1, 0);
> +			adev->ip_versions[UVD_HWIP] = IP_VERSION(1, 0, 0);
> +			adev->ip_versions[DCE_HWIP] = IP_VERSION(1, 0, 0);
> +		}
> +		break;
> +	case CHIP_VEGA20:
> +		vega20_reg_base_init(adev);
> +		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 4, 0);
> +		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 4, 0);
> +		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 2, 0);
> +		adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 2, 0);
> +		adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 2, 0);
> +		adev->ip_versions[DF_HWIP] = IP_VERSION(3, 6, 0);
> +		adev->ip_versions[NBIO_HWIP] = IP_VERSION(7, 4, 0);
> +		adev->ip_versions[UMC_HWIP] = IP_VERSION(6, 1, 1);
> +		adev->ip_versions[MP0_HWIP] = IP_VERSION(11, 0, 2);
> +		adev->ip_versions[MP1_HWIP] = IP_VERSION(11, 0, 2);
> +		adev->ip_versions[THM_HWIP] = IP_VERSION(11, 0, 2);
> +		adev->ip_versions[SMUIO_HWIP] = IP_VERSION(11, 0, 2);
> +		adev->ip_versions[GC_HWIP] = IP_VERSION(9, 4, 0);
> +		adev->ip_versions[UVD_HWIP] = IP_VERSION(7, 2, 0);
> +		adev->ip_versions[VCE_HWIP] = IP_VERSION(4, 1, 0);
> +		adev->ip_versions[DCI_HWIP] = IP_VERSION(12, 1, 0);
> +		break;
> +	case CHIP_ARCTURUS:
> +		arct_reg_base_init(adev);
> +		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 4, 1);
> +		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 4, 1);
> +		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 2, 1);
> +		adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 2, 1);
> +		adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 2, 2);
> +		adev->ip_versions[DF_HWIP] = IP_VERSION(3, 6, 1);
> +		adev->ip_versions[NBIO_HWIP] = IP_VERSION(7, 4, 1);
> +		adev->ip_versions[UMC_HWIP] = IP_VERSION(6, 1, 2);
> +		adev->ip_versions[MP0_HWIP] = IP_VERSION(11, 0, 4);
> +		adev->ip_versions[MP1_HWIP] = IP_VERSION(11, 0, 2);
> +		adev->ip_versions[THM_HWIP] = IP_VERSION(11, 0, 3);
> +		adev->ip_versions[SMUIO_HWIP] = IP_VERSION(11, 0, 3);
> +		adev->ip_versions[GC_HWIP] = IP_VERSION(9, 4, 1);
> +		adev->ip_versions[UVD_HWIP] = IP_VERSION(2, 5, 0);
> +		break;
> +	case CHIP_ALDEBARAN:
> +		aldebaran_reg_base_init(adev);
> +		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 4, 2);
> +		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 4, 2);
> +		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 4, 0);
> +		adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 4, 0);
> +		adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 4, 0);
> +		adev->ip_versions[DF_HWIP] = IP_VERSION(3, 6, 2);
> +		adev->ip_versions[NBIO_HWIP] = IP_VERSION(7, 4, 4);
> +		adev->ip_versions[UMC_HWIP] = IP_VERSION(6, 7, 0);
> +		adev->ip_versions[MP0_HWIP] = IP_VERSION(13, 0, 2);
> +		adev->ip_versions[MP1_HWIP] = IP_VERSION(13, 0, 2);
> +		adev->ip_versions[THM_HWIP] = IP_VERSION(13, 0, 2);
> +		adev->ip_versions[SMUIO_HWIP] = IP_VERSION(13, 0, 2);
> +		adev->ip_versions[GC_HWIP] = IP_VERSION(9, 4, 2);
> +		adev->ip_versions[UVD_HWIP] = IP_VERSION(2, 6, 0);
> +		adev->ip_versions[XGMI_HWIP] = IP_VERSION(6, 1, 0);
> +		break;
> +	default:
> +		r = amdgpu_discovery_reg_base_init(adev);
> +		if (r)
> +			return -EINVAL;
>   
> -	amdgpu_discovery_harvest_ip(adev);
> +		amdgpu_discovery_harvest_ip(adev);
>   
> -	if (!adev->mman.discovery_bin) {
> -		DRM_ERROR("ip discovery uninitialized\n");
> -		return -EINVAL;
> +		if (!adev->mman.discovery_bin) {
> +			DRM_ERROR("ip discovery uninitialized\n");
> +			return -EINVAL;
> +		}
> +		break;
>   	}
>   
>   	switch (adev->ip_versions[GC_HWIP]) {
> +	case IP_VERSION(9, 0, 1):
> +	case IP_VERSION(9, 2, 1):
> +	case IP_VERSION(9, 4, 0):
> +	case IP_VERSION(9, 4, 1):
> +	case IP_VERSION(9, 4, 2):
> +		adev->family = AMDGPU_FAMILY_AI;
> +		break;
> +	case IP_VERSION(9, 1, 0):
> +	case IP_VERSION(9, 2, 2):
> +	case IP_VERSION(9, 3, 0):
> +		adev->family = AMDGPU_FAMILY_RV;
> +		break;
>   	case IP_VERSION(10, 1, 10):
>   	case IP_VERSION(10, 1, 1):
>   	case IP_VERSION(10, 1, 2):
> @@ -527,6 +691,23 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   
>   	/* set NBIO version */
>   	switch (adev->ip_versions[NBIO_HWIP]) {
> +	case IP_VERSION(6, 1, 0):
> +	case IP_VERSION(6, 2, 0):
> +		adev->nbio.funcs = &nbio_v6_1_funcs;
> +		adev->nbio.hdp_flush_reg = &nbio_v6_1_hdp_flush_reg;
> +		break;
> +	case IP_VERSION(7, 0, 0):
> +	case IP_VERSION(7, 0, 1):
> +	case IP_VERSION(2, 5, 0):
> +		adev->nbio.funcs = &nbio_v7_0_funcs;
> +		adev->nbio.hdp_flush_reg = &nbio_v7_0_hdp_flush_reg;
> +		break;
> +	case IP_VERSION(7, 4, 0):
> +	case IP_VERSION(7, 4, 1):
> +	case IP_VERSION(7, 4, 4):
> +		adev->nbio.funcs = &nbio_v7_4_funcs;
> +		adev->nbio.hdp_flush_reg = &nbio_v7_4_hdp_flush_reg;
> +		break;
>   	case IP_VERSION(7, 2, 0):
>   	case IP_VERSION(7, 2, 1):
>   	case IP_VERSION(7, 5, 0):
> @@ -549,6 +730,15 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	}
>   
>   	switch (adev->ip_versions[HDP_HWIP]) {
> +	case IP_VERSION(4, 0, 0):
> +	case IP_VERSION(4, 0, 1):
> +	case IP_VERSION(4, 1, 0):
> +	case IP_VERSION(4, 1, 1):
> +	case IP_VERSION(4, 2, 0):
> +	case IP_VERSION(4, 2, 1):
> +	case IP_VERSION(4, 4, 0):
> +		adev->hdp.funcs = &hdp_v4_0_funcs;
> +		break;
>   	case IP_VERSION(5, 0, 0):
>   	case IP_VERSION(5, 0, 1):
>   	case IP_VERSION(5, 0, 2):
> @@ -561,8 +751,34 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   		break;
>   	}
>   
> +	switch (adev->ip_versions[DF_HWIP]) {
> +	case IP_VERSION(3, 6, 0):
> +	case IP_VERSION(3, 6, 1):
> +	case IP_VERSION(3, 6, 2):
> +		adev->df.funcs = &df_v3_6_funcs;
> +		break;
> +	case IP_VERSION(2, 1, 0):
> +	case IP_VERSION(2, 1, 1):
> +	case IP_VERSION(2, 5, 0):
> +	case IP_VERSION(3, 5, 1):
> +	case IP_VERSION(3, 5, 2):
> +		adev->df.funcs = &df_v1_7_funcs;
> +		break;
> +	default:
> +		break;
> +	}
> +
>   	switch (adev->ip_versions[SMUIO_HWIP]) {
> +	case IP_VERSION(9, 0, 0):
> +	case IP_VERSION(9, 0, 1):
> +	case IP_VERSION(10, 0, 0):
> +	case IP_VERSION(10, 0, 1):
> +	case IP_VERSION(10, 0, 2):
> +		adev->smuio.funcs = &smuio_v9_0_funcs;
> +		break;
>   	case IP_VERSION(11, 0, 0):
> +	case IP_VERSION(11, 0, 2):
> +	case IP_VERSION(11, 0, 3):
>   	case IP_VERSION(11, 0, 4):
>   	case IP_VERSION(11, 0, 7):
>   	case IP_VERSION(11, 0, 8):
> @@ -575,12 +791,25 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(13, 0, 1):
>   		adev->smuio.funcs = &smuio_v11_0_6_funcs;
>   		break;
> +	case IP_VERSION(13, 0, 2):
> +		adev->smuio.funcs = &smuio_v13_0_funcs;
> +		break;
>   	default:
>   		break;
>   	}
>   
>   	/* what IP to use for this? */
>   	switch (adev->ip_versions[GC_HWIP]) {
> +	case IP_VERSION(9, 0, 1):
> +	case IP_VERSION(9, 1, 0):
> +	case IP_VERSION(9, 2, 1):
> +	case IP_VERSION(9, 2, 2):
> +	case IP_VERSION(9, 3, 0):
> +	case IP_VERSION(9, 4, 0):
> +	case IP_VERSION(9, 4, 1):
> +	case IP_VERSION(9, 4, 2):
> +		amdgpu_device_ip_block_add(adev, &vega10_common_ip_block);
> +		break;
>   	case IP_VERSION(10, 1, 10):
>   	case IP_VERSION(10, 1, 1):
>   	case IP_VERSION(10, 1, 2):
> @@ -599,6 +828,16 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   
>   	/* use GC or MMHUB IP version */
>   	switch (adev->ip_versions[GC_HWIP]) {
> +	case IP_VERSION(9, 0, 1):
> +	case IP_VERSION(9, 1, 0):
> +	case IP_VERSION(9, 2, 1):
> +	case IP_VERSION(9, 2, 2):
> +	case IP_VERSION(9, 3, 0):
> +	case IP_VERSION(9, 4, 0):
> +	case IP_VERSION(9, 4, 1):
> +	case IP_VERSION(9, 4, 2):
> +		amdgpu_device_ip_block_add(adev, &gmc_v9_0_ip_block);
> +		break;
>   	case IP_VERSION(10, 1, 10):
>   	case IP_VERSION(10, 1, 1):
>   	case IP_VERSION(10, 1, 2):
> @@ -616,6 +855,18 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	}
>   
>   	switch (adev->ip_versions[OSSSYS_HWIP]) {
> +	case IP_VERSION(4, 0, 0):
> +	case IP_VERSION(4, 0, 1):
> +	case IP_VERSION(4, 1, 0):
> +	case IP_VERSION(4, 1, 1):
> +	case IP_VERSION(4, 3, 0):
> +		amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
> +		break;
> +	case IP_VERSION(4, 2, 0):
> +	case IP_VERSION(4, 2, 1):
> +	case IP_VERSION(4, 4, 0):
> +		amdgpu_device_ip_block_add(adev, &vega20_ih_ip_block);
> +		break;
>   	case IP_VERSION(5, 0, 0):
>   	case IP_VERSION(5, 0, 1):
>   	case IP_VERSION(5, 0, 2):
> @@ -630,7 +881,16 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   
>   	if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
>   		switch (adev->ip_versions[MP0_HWIP]) {
> +		case IP_VERSION(9, 0, 0):
> +			amdgpu_device_ip_block_add(adev, &psp_v3_1_ip_block);
> +			break;
> +		case IP_VERSION(10, 0, 0):
> +		case IP_VERSION(10, 0, 1):
> +			amdgpu_device_ip_block_add(adev, &psp_v10_0_ip_block);
> +			break;
>   		case IP_VERSION(11, 0, 0):
> +		case IP_VERSION(11, 0, 2):
> +		case IP_VERSION(11, 0, 4):
>   		case IP_VERSION(11, 0, 5):
>   		case IP_VERSION(11, 0, 9):
>   		case IP_VERSION(11, 0, 7):
> @@ -643,7 +903,12 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   		case IP_VERSION(11, 0, 8):
>   			amdgpu_device_ip_block_add(adev, &psp_v11_0_8_ip_block);
>   			break;
> +		case IP_VERSION(11, 0, 3):
> +		case IP_VERSION(12, 0, 1):
> +			amdgpu_device_ip_block_add(adev, &psp_v12_0_ip_block);
> +			break;
>   		case IP_VERSION(13, 0, 1):
> +		case IP_VERSION(13, 0, 2):
>   		case IP_VERSION(13, 0, 3):
>   			amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
>   			break;
> @@ -654,6 +919,15 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   
>   	if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
>   		switch (adev->ip_versions[MP1_HWIP]) {
> +		case IP_VERSION(9, 0, 0):
> +		case IP_VERSION(10, 0, 0):
> +		case IP_VERSION(10, 0, 1):
> +		case IP_VERSION(11, 0, 2):
> +			if (adev->asic_type == CHIP_ARCTURUS)
> +				amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);

Better to split to two separate cases - 11.0.2 supports swsmu block, for 
others pp_smu block.

> +			else
> +				amdgpu_device_ip_block_add(adev, &pp_smu_ip_block);
> +			break;
>   		case IP_VERSION(11, 0, 0):
>   		case IP_VERSION(11, 0, 9):
>   		case IP_VERSION(11, 0, 7):
> @@ -664,7 +938,12 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   		case IP_VERSION(11, 5, 0):
>   			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
>   			break;
> +		case IP_VERSION(12, 0, 0):
> +		case IP_VERSION(12, 0, 1):
> +			amdgpu_device_ip_block_add(adev, &smu_v12_0_ip_block);
> +			break;
>   		case IP_VERSION(13, 0, 1):
> +		case IP_VERSION(13, 0, 2):
>   		case IP_VERSION(13, 0, 3):
>   			amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
>   			break;
> @@ -676,10 +955,13 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	if (adev->enable_virtual_display || amdgpu_sriov_vf(adev)) {
>   		amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
>   #if defined(CONFIG_DRM_AMD_DC)
> -	} else {
> +	} else if (adev->ip_versions[DCE_HWIP]) {
>   		switch (adev->ip_versions[DCE_HWIP]) {
> +		case IP_VERSION(1, 0, 0):
> +		case IP_VERSION(1, 0, 1):
>   		case IP_VERSION(2, 0, 2):
>   		case IP_VERSION(2, 0, 0):
> +		case IP_VERSION(2, 1, 0):
>   		case IP_VERSION(3, 0, 0):
>   		case IP_VERSION(3, 0, 2):
>   		case IP_VERSION(3, 0, 3):
> @@ -693,10 +975,29 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   		default:
>   			return -EINVAL;
>   		}
> -
> +	} else if (adev->ip_versions[DCI_HWIP]) {
> +		switch (adev->ip_versions[DCI_HWIP]) {
> +		case IP_VERSION(12, 0, 0):
> +		case IP_VERSION(12, 0, 1):
> +		case IP_VERSION(12, 1, 0):
> +			amdgpu_device_ip_block_add(adev, &dm_ip_block);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
>   	}
>   #endif
>   	switch (adev->ip_versions[GC_HWIP]) {
> +	case IP_VERSION(9, 0, 1):
> +	case IP_VERSION(9, 1, 0):
> +	case IP_VERSION(9, 2, 1):
> +	case IP_VERSION(9, 2, 2):
> +	case IP_VERSION(9, 3, 0):
> +	case IP_VERSION(9, 4, 0):
> +	case IP_VERSION(9, 4, 1):
> +	case IP_VERSION(9, 4, 2):
> +		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
> +		break;
>   	case IP_VERSION(10, 1, 10):
>   	case IP_VERSION(10, 1, 2):
>   	case IP_VERSION(10, 1, 1):
> @@ -714,6 +1015,16 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	}
>   
>   	switch (adev->ip_versions[SDMA0_HWIP]) {
> +	case IP_VERSION(4, 0, 0):
> +	case IP_VERSION(4, 0, 1):
> +	case IP_VERSION(4, 1, 0):
> +	case IP_VERSION(4, 1, 1):
> +	case IP_VERSION(4, 1, 2):
> +	case IP_VERSION(4, 2, 0):
> +	case IP_VERSION(4, 2, 2):
> +	case IP_VERSION(4, 4, 0):
> +		amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
> +		break;
>   	case IP_VERSION(5, 0, 0):
>   	case IP_VERSION(5, 0, 1):
>   	case IP_VERSION(5, 0, 2):
> @@ -734,6 +1045,15 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   
>   	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
>   		switch (adev->ip_versions[MP1_HWIP]) {
> +		case IP_VERSION(9, 0, 0):
> +		case IP_VERSION(10, 0, 0):
> +		case IP_VERSION(10, 0, 1):
> +		case IP_VERSION(11, 0, 2):
> +			if (adev->asic_type == CHIP_ARCTURUS)
> +				amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);

Same comment as earlier.

Thanks,
Lijo

> +			else
> +				amdgpu_device_ip_block_add(adev, &pp_smu_ip_block);
> +			break;
>   		case IP_VERSION(11, 0, 0):
>   		case IP_VERSION(11, 0, 9):
>   		case IP_VERSION(11, 0, 7):
> @@ -744,7 +1064,12 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   		case IP_VERSION(11, 5, 0):
>   			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
>   			break;
> +		case IP_VERSION(12, 0, 0):
> +		case IP_VERSION(12, 0, 1):
> +			amdgpu_device_ip_block_add(adev, &smu_v12_0_ip_block);
> +			break;
>   		case IP_VERSION(13, 0, 1):
> +		case IP_VERSION(13, 0, 2):
>   		case IP_VERSION(13, 0, 3):
>   			amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
>   			break;
> @@ -753,26 +1078,58 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   		}
>   	}
>   
> -	switch (adev->ip_versions[UVD_HWIP]) {
> -	case IP_VERSION(2, 0, 0):
> -	case IP_VERSION(2, 0, 2):
> -		amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
> -		amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
> -		break;
> -	case IP_VERSION(2, 0, 3):
> -		break;
> -	case IP_VERSION(3, 0, 0):
> -	case IP_VERSION(3, 0, 16):
> -	case IP_VERSION(3, 1, 1):
> -	case IP_VERSION(3, 0, 2):
> -		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
> -		amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
> -		break;
> -	case IP_VERSION(3, 0, 33):
> -		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
> -		break;
> -	default:
> -		return -EINVAL;
> +	if (adev->ip_versions[VCE_HWIP]) {
> +		switch (adev->ip_versions[UVD_HWIP]) {
> +		case IP_VERSION(7, 0, 0):
> +		case IP_VERSION(7, 2, 0):
> +			amdgpu_device_ip_block_add(adev, &uvd_v7_0_ip_block);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		switch (adev->ip_versions[VCE_HWIP]) {
> +		case IP_VERSION(4, 0, 0):
> +		case IP_VERSION(4, 1, 0):
> +			amdgpu_device_ip_block_add(adev, &vce_v4_0_ip_block);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	} else {
> +		switch (adev->ip_versions[UVD_HWIP]) {
> +		case IP_VERSION(1, 0, 0):
> +		case IP_VERSION(1, 0, 1):
> +			amdgpu_device_ip_block_add(adev, &vcn_v1_0_ip_block);
> +			break;
> +		case IP_VERSION(2, 0, 0):
> +		case IP_VERSION(2, 0, 2):
> +		case IP_VERSION(2, 2, 0):
> +			amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
> +			amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
> +			break;
> +		case IP_VERSION(2, 0, 3):
> +			break;
> +		case IP_VERSION(2, 5, 0):
> +			amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
> +			amdgpu_device_ip_block_add(adev, &jpeg_v2_5_ip_block);
> +			break;
> +		case IP_VERSION(2, 6, 0):
> +			amdgpu_device_ip_block_add(adev, &vcn_v2_6_ip_block);
> +			amdgpu_device_ip_block_add(adev, &jpeg_v2_6_ip_block);
> +			break;
> +		case IP_VERSION(3, 0, 0):
> +		case IP_VERSION(3, 0, 16):
> +		case IP_VERSION(3, 1, 1):
> +		case IP_VERSION(3, 0, 2):
> +			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
> +			amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
> +			break;
> +		case IP_VERSION(3, 0, 33):
> +			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
>   	}
>   
>   	if (adev->enable_mes) {
> 
