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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0114DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 08:16:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDBE161209
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 08:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BDBE161209
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76DA86EADB;
	Wed, 22 Sep 2021 08:16:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB33A6EAD2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 08:16:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOl96uAHpyg+ZBt65jy3Zaryu0a9wN7FQ2V25Gj10SzRE3+Q50IrVVaiFgL9f629Uy1ZBZwGH86OcxmUUChTeWE0q8VQV3Tk29Oj62WFxP05AHdAVFz+oXOodOwFnRZKY9wvOEcbogUfF/Drf4vzO9zggEVJhhxBb+6L1NkBSOMRRGllWTFYfAx66l5WeCC8c+16NnI2qq5ZDwrSNWyHja1QGNEAelKBcrRgn2hxyGHv7DGxZiaZb6pBUA+pNIY7gttVZUEfpt2K092S12Q8/ffI24wbRFXh3YHyfVRsh+oMh7UJcyTi6thmbVQlbyIZVlgm8K/i5eWbLiJEihhLmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Hd88MeTWPvfpRJBPYXkiEAPAyDG9NyKHTPwCf8iJl3I=;
 b=INZd/IILyiW4jkNjY/+AuMAmU3AHGDkCDi/pYsa8A08M3oy5DHFbxTYBu3RTjK3bxvfXE43w+XoopSH5A7slcJyjcDh1nJc+uqSg9BWCuAiTlgAhujUk3zloe1XWn/k8Nti0IMfTPpnUoI1faYkAB1BvDF7+H5BMwSSIFNeEyUA7Z9ilnnZ8wcpyd7DaKDyreyHUpIh98q92wT+6ni5dslnnlQ95Jt+katv+iHDWyY9uh12lqtnk6Fyh2CKPTIuc0RiQ0aiR1s8V2sAFru9Z/hLsMJzYoMW109qWZQYGXLc94GqcPRSG6Ym7b11foyrihMU/8EY8cnyuRmmYEpr/tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hd88MeTWPvfpRJBPYXkiEAPAyDG9NyKHTPwCf8iJl3I=;
 b=KWoB3oKzAIHCQfEmQ9D9G3xgLwrMmfUTLN9VXkKWuSRdBXbNlzNp0Bxe9J7aJdMsh/jxIdHVdd5zgc+f9UkPQWUSSDq2VFTI8o4Jg73qSZHPdBli+eS+J0vMkbJf9mPzKh3QrCNYIWwy79AjQZIKL6f9ydpcHrOver25CPCl+OQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB2438.namprd12.prod.outlook.com (2603:10b6:4:b5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 08:16:49 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57%7]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 08:16:49 +0000
Subject: Re: [PATCH 46/66] drm/amdgpu/pm/amdgpu_smu: convert more IP version
 checking
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-47-alexander.deucher@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <7fbaf500-dc08-df63-2483-115be7e543a2@amd.com>
Date: Wed, 22 Sep 2021 13:46:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210921180725.1985552-47-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::33) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN1PR01CA0093.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:1::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 08:16:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 696dbb9a-07d4-45aa-75cb-08d97da1539a
X-MS-TrafficTypeDiagnostic: DM5PR12MB2438:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2438822A08B1753E9142B31897A29@DM5PR12MB2438.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VSWqxoAR5JhEKizYSOgVTiGTjh8TMGtylD+TgiA200HIu+iFtOvj9Z4EWKe4p+QPdsYnWw7TbADipSsZVWlY5dpYnZ4DRUcgcocQ5RDqJ7IYD2wvu/O+TjRUQvakNlI6K6j6DWCHFZ5diY3GNOFgiSbyPY21uqbQ5atPc0eqzYFlOScQMhifr/vHevd/4MrxnCoryuq+ZsxTMk0RCapo8/ecbLaf8+c4iHBGYi5Omg8E/lNFjl4B2tgnlH/uN8LHLloJCENCSrqRZ6/H08xCMIHKp+unvFiXze9oRByHct8V8gRIfsFW/ys4L7VuokhTPpE8ZvheqomGXZGss70IRgXnXAS6DiBMO5a84Nr4D88/i9UY6kRYkRdKRsT1VXAzXTHSwUzTJqx0bb9df44UYxQ4ENQnP7B3IqClbZCivzKV4BMPJocoBPVEnWDE4HOixj6PhKvcMMmwOwmJawOD5ie4rRIpcDaJ4wc3/LqILfq2nUipE5gYwlCOZpWXl1THGU42S7CzLsYSxg6DVjL6I9A50Qtwp+eAwmK4eOlB2AqtcAT+ftb7gSYCNOeAuWPwy/GKPwCY1iR3CuBAhKzHP19apxJmdsStJU2hRHMRvN78F0uj9DOAlU+dGrCqbIqyBT6sES6bMisuk6TIBuDB07rfY0jug3qPFTcObiMo308AE0f3acUF5sGeb3j4OMnftEahMhLDHSAAyi0cTDHm3K1XW3x0A0uacZuknhzZwWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(2616005)(53546011)(38100700002)(956004)(36756003)(6666004)(316002)(2906002)(16576012)(83380400001)(508600001)(6486002)(26005)(8936002)(31696002)(186003)(31686004)(8676002)(5660300002)(66946007)(66556008)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHp5U3Y4aHB1eERlT3R4TmZxdEd3OGlqdUdaTjY1SnZMZTEwUHB0U2dyTndm?=
 =?utf-8?B?cUtyRzFhVnpBUTBaRE1mYkNKSThSYXJZckQzV0xtalpTZWVIMzlnVzVUU2du?=
 =?utf-8?B?eHkxUTg5eW45M0I5Z1N3bUJPM3ZBa3RmWVcxbC9qUkRvdWtBNHhrL045Z3JJ?=
 =?utf-8?B?eGplTDl4ejRHUmtmaVZxUUpHdWdQcFdHTmxvK0Q5TmQrdXRaRTA3SWxEejdC?=
 =?utf-8?B?aStFcUJLdjBKVVhEV0hzVVdPUy9SaWFjbEVXekRWR1FoZEVpUDhLKzhGSDlw?=
 =?utf-8?B?VUMydkN0Wkk2ckh2U3RhUnA2MUsrdEgzbUJXcm9QbXZPNytHdWx6Y29xOFhO?=
 =?utf-8?B?T1paK2Q3c3VXeDBFcXJEMXBnNWJiRXhoSVBiRUNkVkZiejIydmpWL3FKeVBr?=
 =?utf-8?B?dWE3Ti8zMFJ0TkNxeGxGTitSa2pJQjNjOUtkbURGUlNKOE1Lc0hBdmU4K3hj?=
 =?utf-8?B?Ylp0UlV2ZEtnYkg1Umw5ZmFYaytEVTlZcHRkODU0aDE1YVliVHNKRzlQRW9E?=
 =?utf-8?B?SmhkYmtqc2xHbkRyZE0yVGdyVEczZnByK1RQSytFN2d5S1A1UFc0aGJHazN5?=
 =?utf-8?B?alVkazFBdkU5VWdTYTdvZHhEUzlYei9YcjBjZXFCRU4xZnJLRFFsOGVHUzBx?=
 =?utf-8?B?LzNPdklmL1hCTHlVVk5mK0Jjb1loRGtIQkVCZU9mQXU2MjhPbTlUKzVtNWhO?=
 =?utf-8?B?dTlPSDlBUXhoallaODNpM3RiUURhWERkSWtpcHFycHVzbHpnWDJZRWtMOTFK?=
 =?utf-8?B?WU5vUzBldEZHei9WM2trRUY1NHJKUmowdlIzTlpZeWU2RnRYa3M2ZUtaMjhT?=
 =?utf-8?B?Z3lXNm1aaEhHODA3N05YVFpsaHE4VDdkVFIxL1F3ZVdDUTJCSWRiSWcvU1F4?=
 =?utf-8?B?bHAxUEZGS2tGRDBIcnVCOURxcHIyOGRDQTlyTkZ0NjVGWFFINWRNZCtRZE9Q?=
 =?utf-8?B?QjR4NVNlak9HVFJZZHdOMVJodWNQZTg2b3pEYXlWb0ZlbE9ZZldDUXdWaTZW?=
 =?utf-8?B?YldLMDM4TWVBV2ZjRkRjcEhoaDZJWE16Y3VCSVMwVzRJSndNaEs3MmgvbjM0?=
 =?utf-8?B?VmZCaXF4UjhYZXk3SWFxRWR6M1lleXVGMHlBSUJzOFRKQzFwdW1jaExhbkJi?=
 =?utf-8?B?UldRbWhYVG1lODhNcFVvM1k3NnRoMmdGYWhtbERGV3h0d1NRbzRIdmJnZ3pt?=
 =?utf-8?B?Ry8wVG9sTmlBcGtjOVNYZDk3N2V2cnMxODROc2tJa3M4TFYxaWl1d3J5R1Mz?=
 =?utf-8?B?NWt5bWRBVUVVUmh6Nm5xcWdGMVFHOTNxdXh2UndMNllZYUprOFQ1QjJaajh4?=
 =?utf-8?B?OTU0Y3QvSFZuMHlKQU5YeFYwbzRINU5NdUNDckFQM05Td1NzMlgwajlCM2ZG?=
 =?utf-8?B?dS9VVUtiYjBubDBYanV5TXlFbE9NM3liZTJMWWJUeG53SElMdytyd3IvbGQz?=
 =?utf-8?B?Q3BGZU5PVUFTcjVjNFBRbkl6NXBxU0xPd21nclREZkE0RjlGU2NwelA1S0Fz?=
 =?utf-8?B?eWdtUFdMV3dFQmxmUHVwc1BydlBJcnY2Njhsa25uVytyMU5nQ3pINFNJRUFr?=
 =?utf-8?B?Z1pTdG0yOU1FTUMrQWpnRjV6OXBNdy80aTJQTE5kUno0QWh2cWZNTVlxZW9W?=
 =?utf-8?B?OFA5Zko0NGxVTFJJTjdXWkFDRlQrM2NnTFN6NzFIbFlnQ2VPbFhMMTNTQ1V4?=
 =?utf-8?B?Q0VxN1BoRmtmR0hGdDNHaXVsUytzeGo3Q3BpdytyWkNEdFhkTStONDRtNDl0?=
 =?utf-8?Q?aItUUE1CDXYijhYdhxmsrz9qag+VAf39aI3Au4r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 696dbb9a-07d4-45aa-75cb-08d97da1539a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 08:16:49.6853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7fPq7UzaT/NI95KCR7YUVDpYafis4+fJdWhQht9sRRAUpzYc3OVlsZ1FKJZ5L3R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2438
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



On 9/21/2021 11:37 PM, Alex Deucher wrote:
> Use IP versions rather than asic_type to differentiate
> IP version specific features.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 41 ++++++++++-------------
>   1 file changed, 18 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 5f372d353d9d..150cac4ea75c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -455,8 +455,7 @@ static int smu_get_power_num_states(void *handle,
>   
>   bool is_support_sw_smu(struct amdgpu_device *adev)
>   {
> -	if ((adev->asic_type >= CHIP_ARCTURUS) ||
> -	    (adev->ip_versions[MP1_HWIP] >= IP_VERSION(11, 0, 0)))
> +	if (adev->ip_versions[MP1_HWIP] >= IP_VERSION(11, 0, 0))
>   		return true;
>   
>   	return false;
> @@ -600,23 +599,19 @@ static int smu_set_funcs(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 0, 8):
>   		cyan_skillfish_set_ppt_funcs(smu);
>   		break;
> -	default:
> -		switch (adev->asic_type) {
> -		case CHIP_ARCTURUS:
> -			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
> -			arcturus_set_ppt_funcs(smu);
> -			/* OD is not supported on Arcturus */
> -			smu->od_enabled =false;
> -			break;
> -		case CHIP_ALDEBARAN:
> -			aldebaran_set_ppt_funcs(smu);
> -			/* Enable pp_od_clk_voltage node */
> -			smu->od_enabled = true;
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> +	case IP_VERSION(11, 0, 2):
> +		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
> +		arcturus_set_ppt_funcs(smu);
> +		/* OD is not supported on Arcturus */
> +		smu->od_enabled =false;
> +		break;
> +	case IP_VERSION(13, 0, 2):
> +		aldebaran_set_ppt_funcs(smu);
> +		/* Enable pp_od_clk_voltage node */
> +		smu->od_enabled = true;
>   		break;
> +	default:
> +		return -EINVAL;
>   	}
>   
>   	return 0;
> @@ -2288,11 +2283,11 @@ int smu_get_power_limit(void *handle,
>   	} else {
>   		switch (limit_level) {
>   		case SMU_PPT_LIMIT_CURRENT:
> -			if ((smu->adev->asic_type == CHIP_ALDEBARAN) ||
> -			     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 7)) ||
> -			     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 11)) ||
> -			     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 12)) ||
> -			     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 13)))
> +			if ((adev->ip_versions[MP1_HWIP] == IP_VERSION(13, 0, 2)) ||
> +			    (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 7)) ||
> +			    (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 11)) ||
> +			    (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 12)) ||
> +			    (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 13)))

Maybe seen/commented before, anyway switch...case

Thanks,
Lijo

>   				ret = smu_get_asic_power_limits(smu,
>   								&smu->current_power_limit,
>   								NULL,
> 
