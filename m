Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FD1C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 11:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DFD860E99
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 11:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2DFD860E99
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C4D76E7EA;
	Thu, 26 Aug 2021 11:44:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28C5A6E7EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 11:44:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMrnhIORcG0tcg0bm34nxOEpJNoZPTrSbZA+wAxxqEYPrMAn5Vh1wma0togiZFdVQhKo5bGnnjgUK/n/6XPb/ljBdlFIDLcAVQhDSQuf+Ae3l5mnHBYVgNuIIx5/BBa//qnnEKXqlVNwB/nu+8tSuq7+FA/sxl0JRXIt5lK8acw5Z1DAfAvhgXqKENVHGRl9d9XhNOPLVhv+SRVvejuV2mbMqGfZ3l60/QRouvTx3XuHPx0z1g95r411K49Be3K+OzfEHyUVssh7oMRdYyD1jcQeAZUsYri0QChfV1BBGTzS7P3Vqnt2tMSmTnh1jcLwPuvvQwmNIiTfhDQq9Tf+fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pk4/3Z8hyeiWuBKbzfYoNN+KLWgVXZE2Px3yiLBiW6U=;
 b=eij0LR/2NUJxKMa9uxHNT9YecXxNKhsHq772odyJn7xFBKS198p+HX5WwkHT9lT30YrCAUhxZ1UYwe4Yj3aql7Am6Jr659Ag7cLdVkh3e0O69HfCeofAltCG7q/V9YmdHL3LokcdNDBBJ04lPtcPaZWMSQAQiBlV5He4NuiVNFG5kC6Qv96JU49g48j8F9Vib5SQ8KixitxEXJADLurFxieHmO2P6ZPARNMQ1pYYCZxB1orjkowRZDV/UD9nHJIcqxi2MZW1iAB3FRICPMM9IdSeFMY/YUNoEfxo4zUiwfogT0MYg9K4yQcibxCBbHupgbU9WaL7SCfgJUSFMDqi4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pk4/3Z8hyeiWuBKbzfYoNN+KLWgVXZE2Px3yiLBiW6U=;
 b=m7Ry84fLgeQtHkprxE4dy2r2uodjhSRWR/jMWjLDZ2PxI+NZ01R4jDcdqkz/kgsC9F6f4gZrrrkFh48vCitXI3y5o5+u0zeNIAkeFtNmjOi5YSCYYVRo+I5vQhbDqWeCphSTczfDVDqcwdYnco9kktY8ck1Q/UYt0jKiz7pnM9Q=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5025.namprd12.prod.outlook.com (2603:10b6:610:e0::24)
 by CH0PR12MB5252.namprd12.prod.outlook.com (2603:10b6:610:d3::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 26 Aug
 2021 11:44:24 +0000
Received: from CH0PR12MB5025.namprd12.prod.outlook.com
 ([fe80::4193:5457:4a18:780b]) by CH0PR12MB5025.namprd12.prod.outlook.com
 ([fe80::4193:5457:4a18:780b%8]) with mapi id 15.20.4457.019; Thu, 26 Aug 2021
 11:44:24 +0000
Subject: Re: [PATCH 5/5] drm/amdgpu:schedule vce/vcn encode based on priority
To: Satyajit Sahu <satyajit.sahu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 nirmoy.das@amd.com
References: <20210826071307.136010-1-satyajit.sahu@amd.com>
 <20210826071307.136010-5-satyajit.sahu@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
Message-ID: <f6c013a6-1d88-6360-57c7-6494a92f7648@amd.com>
Date: Thu, 26 Aug 2021 17:14:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210826071307.136010-5-satyajit.sahu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::21) To CH0PR12MB5025.namprd12.prod.outlook.com
 (2603:10b6:610:e0::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.68.104] (106.51.20.251) by
 MA1PR0101CA0035.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend
 Transport; Thu, 26 Aug 2021 11:44:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac11f873-7dda-40d6-ccbf-08d96886d9a3
X-MS-TrafficTypeDiagnostic: CH0PR12MB5252:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB52528EA4DC8A69C76CF447FDF2C79@CH0PR12MB5252.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NhQ2vAzfCIEPgHRZkneBrXwJiUtpnZL0lTG+pr3yWmboU98K2Y43ulLIwGXUK+ggQuU9WOpy0h2c0OVQ+BmmgQFUQOMl+iZVdTwLLzv+z/Fa1JElCSG1/eOY5jpxTW1Qu42wGW8XK3XaMPAgmO+Dn0i+R0ThmjdFKLJuw6Kbo3ho1+yA5n7ZKqTB+RA58HJkbBrxk6iehIVHeBbNX2/p+N66fT1Jw84pZbjAoiwQs/pRGL9279cZHdLWvUbcuakRBECCdHQfi9M4ciyd1+VYw11d2MmSfHFvz86y6x2Q27uWAThI9MKAcf+6RbghprGKLWBEixoxFSb7AYgjq87MsANYQI9gir01gNUIhduhZoR9dihIPoAU5rb3BJfMWlOEVqFaV9r8TC+RMefHo5Pw4rHGEkEzlq0wmHaN4shaj93fy1R5SHszrt0mHym99LeVmcv05rWiMzQ0UpIsBshOaXoi1gfhjQ8chGk4ZDHWbcSF7Llv0K+ha2TSrg7gqLX5C0SgVdAUxsOJHisvByePyWO6EZQ8m0Hz6ATD2upMriGRcCPubzAekmmROd3KzkWcqd1QH0WdHj59O04brHqutS4fbYVWGWtB2i5BYx6Ks8mU/HTLBREUaqySE+R8nc1FdG54mYDRYFchCqTfUcfXsCNpcEIwnwrr+u7inalV3GirwFxuha0KRmagSvQYfz2a0xJ9jKwKt33KC8x56TIbnQ7Bw/IrkmOsNfmX6Nl/rwGGDMoGJ5UGRAem+wfVdQx+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5025.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(26005)(31686004)(38100700002)(31696002)(55236004)(2616005)(53546011)(956004)(5660300002)(8676002)(2906002)(186003)(4326008)(66476007)(66556008)(66946007)(508600001)(16576012)(316002)(6486002)(86362001)(1006002)(36756003)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUcyczdBaE42bzNNM1orYWVZTlViNlR6SkY0Mko1QWFiMFFiMHdyRUlJSkZ0?=
 =?utf-8?B?WFZKdGFxUDhxdndzM1R3dE92R09QU25Vd1IwWmVqRzBNWXdWM1dSdEZHcHZD?=
 =?utf-8?B?MlZzeVlmQWp3Ull1Z25oK1IvQTc1WmhrVW9oeGR5ME5CUmlMSlkrdE5JZW9F?=
 =?utf-8?B?bzdFZzR1Z2VqRmFRTjJjTkZpaDhqeXlTaW5VME0vd1B6WldMaEZZVnBjSU9G?=
 =?utf-8?B?QjJwWTVDdEpvME1zZzAzSzdlQzgwWjFQOC96VE1QeE5vY1U4QWp2V3NxTmsz?=
 =?utf-8?B?Y012dStFWi9lTmhNOVpiMVFySzZCK2JpTWtUa0gveUFmYlBnelZ3d1NER05p?=
 =?utf-8?B?YWYwMGJEVWpYdEt5aXpPaHE0Tm84cFdGZUhvUzBtZFdlSEFBV0p0c2NBRmtk?=
 =?utf-8?B?TDg3U09tVEd3ZFJORzRVL1JFUTI5RDhyeXdOL21YMFpKVzFwRUZnQlZQMjVp?=
 =?utf-8?B?N3FsdGRxVVJDVkJwcmlOS0hVVVI5UysrQ3NjRWtONmtnbzdzeHZNemNxZytN?=
 =?utf-8?B?a3VQQ2pVTHRnU0gwWjBUeHFUK05pakN3YWNGbHZDTnR0eGVGVUpvK3M2WkQx?=
 =?utf-8?B?Z2tVMEZ1M1FPQ2RHeUY2QVgvR3hTZmU2ZnE1M1E0dVdnZEcreFRDTGhYSU85?=
 =?utf-8?B?eWk2Ry8vaUhiTVI1YlFkYkdwY2xwbm5WKy9ZMUF6aDRCWWZrNHovaHgyOG84?=
 =?utf-8?B?cDllVFBsOHFlRXhBMnFNSDlxcXQ5TjcvWVIzY1RweGo4QXYyWk1NSkxjUDRU?=
 =?utf-8?B?UHEvRW5iRllaaXNhVDFzdGk0WUFheXZKT2RyZ2w1YnFPM1BpeGVRNjRqKy9F?=
 =?utf-8?B?NGwvTkl1d09GaWNBZm95emMrNFJMM0ZySmpGVFdPOTFNTkpLaHh0WVFETW9n?=
 =?utf-8?B?dTdERHh1dVFPR3R1bVhrVzA1aW51SGE1c3Fyck9YZW1sYkNmZWprNU1mVjE2?=
 =?utf-8?B?SENnY2w4VHBXd2RscHJodzdGeG0vN0FXUjFwWlN5b2RYWklJbFRJMUpZdDFM?=
 =?utf-8?B?NzdMK2hGRlo3ckhSMm8wNmtULzcrakhtcnhFN3pJUk4rWldpMzVndDRSSHlU?=
 =?utf-8?B?ajM2R2NmVHUyRGQ5TFZaMENzYjMxZGFrR1gyK1ovWU5pUzU0aW5na24xb3ds?=
 =?utf-8?B?VjROaFdBSzVoT1RSTVlyQzR3R2JEbnFMaHlpMHVUd1ArV0toQlNJVGFLQzh1?=
 =?utf-8?B?SHpjbldqWFlCaktUWEhranhaVVdYTmd4Rks1QU5HRkM5NU12T2JSbEdPdzR0?=
 =?utf-8?B?YkpvbVVxNWRYMzluU2pacGxsb0NsQy8xbE04Y0N6TUFEQ0x1TDBhck1jdEtO?=
 =?utf-8?B?c1F2UjJaSUVCU2I4YmRVZEJFRWNHWXlJVnEzQzljSE1GZ1hTU1NCK0xaY1Fr?=
 =?utf-8?B?cTFud3hkczI0Qzg0ZUxEaHRTYmdFSTY1MjhYaDhuOWYydkZWbDlHaGEzcnRT?=
 =?utf-8?B?WTNjcHZBSlFSSCttUEVJaU9uNzhoVTlzRTNWVEpjbUZWU1ZsQlRtYmdnL3Uy?=
 =?utf-8?B?VVhBZ0hkb1JPUVVJdlZna2VvVGg5UDk2QkFKYUFZb3NuU3JNTmwwRVQvTXBD?=
 =?utf-8?B?dlJSeldLMFZYNkdLRHo0VHRKMThGUG9tWWtjM3g5L3ZIWmxvUENpSXEzT0lv?=
 =?utf-8?B?R0xVWEFITTdyZndxMTNZcFU5Q0daWm5kcHFQSXk3U1c4NThSNWRRVHhyeGJR?=
 =?utf-8?B?dTZ1YTFaTWJXTHhaM3V5bklXQ3JBTEFXVjFtMHdRRGN1R3hoUzdTbjY4WWd4?=
 =?utf-8?Q?QCEmYikCRJK6ytmsvVymlCvs7qA5mENOx5hXi6K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac11f873-7dda-40d6-ccbf-08d96886d9a3
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5025.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 11:44:23.9108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVrKxr2efJEUdsyQgfWti3dCZS+RiuYRTgDndmCefcRokJfM34s3YSsJAyJNEJjWUlZU0WkwcLuLkhlZgsVxag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5252
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



On 8/26/2021 12:43 PM, Satyajit Sahu wrote:
> Schedule the encode job in VCE/VCN encode ring
> based on the priority set by UMD.
> 
> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 30 +++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index c88c5c6c54a2..4e6e4b6ea471 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -120,6 +120,30 @@ static enum gfx_pipe_priority amdgpu_ctx_prio_to_compute_prio(int32_t prio)
>   	}
>   }
>   
> +static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_vce_prio(int32_t prio)
> +{
> +	switch (prio) {
> +	case AMDGPU_CTX_PRIORITY_HIGH:
> +		return AMDGPU_VCE_ENC_PRIO_HIGH;
> +	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
> +		return AMDGPU_VCE_ENC_PRIO_VERY_HIGH;
> +	default:
> +		return AMDGPU_VCE_ENC_PRIO_NORMAL;
> +	}
> +}
> +
> +static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_vcn_prio(int32_t prio)
> +{
> +	switch (prio) {
> +	case AMDGPU_CTX_PRIORITY_HIGH:
> +		return AMDGPU_VCN_ENC_PRIO_HIGH;
> +	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
> +		return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
> +	default:
> +		return AMDGPU_VCN_ENC_PRIO_NORMAL;
> +	}
> +}
> +
>   static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, u32 hw_ip)
>   {
>   	struct amdgpu_device *adev = ctx->adev;
> @@ -133,6 +157,12 @@ static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, u32 hw_ip)
>   	case AMDGPU_HW_IP_COMPUTE:
>   		hw_prio = amdgpu_ctx_prio_to_compute_prio(ctx_prio);
>   		break;
> +	case AMDGPU_HW_IP_VCE:
> +		hw_prio = amdgpu_ctx_sched_prio_to_vce_prio(ctx_prio);
> +		break;
> +	case AMDGPU_HW_IP_VCN_ENC:
> +		hw_prio = amdgpu_ctx_sched_prio_to_vcn_prio(ctx_prio);
> +		break;
>   	default:
>   		hw_prio = AMDGPU_RING_PRIO_DEFAULT;
>   		break;
> 

IMO, this patch can be split and merged into patches 3 and 4 
respectively, but is not a dealbreaker for me.

- Shashank
