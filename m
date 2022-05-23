Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B567BC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 23 May 2022 09:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 580A810F15C;
	Mon, 23 May 2022 09:12:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB88C10E9E0
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 May 2022 09:12:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Im19nPHLkjWlY0KA67wZ8c3iE0b8M3l/xPoFEdPiXOCMcNXv7SmS808ZweHmxqpGwB0P6FkCQGlOVmf0lF2ce4Os02O/Xu4UK62ZYLoEq5wZa82fXwQKvfbMqxMeNE/69TODEaolL0Ee1ILqY/+IC+tT/aPvwScsnN/RM9H7NSTunZ4Ae5iEOogWcGeROlh/szlsZ7qUgiYIcxe5TAPaww+yqbGm1oGMoZ3B3/y8e7pA5w2/yKRvs5Earr0/35kBYEqgF9X1DtZtvLyV3J986d3AbHhygWmo9TIN00XgnOcD2zafF30KPlQ1lLjy+Kd9QDL6QDuPmOgPCdlHOTT3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJHDGqyHfUmiXNGGc+/00buWSNo6jKUZ+qyz1X2S1Eo=;
 b=KKyym5k7NObYnvytT7GpWc8LRcS/6z/rM37EvXpCaoC3ZMQ8Rc8zweEL6Wrgy9bN6V6pUEyup1/N1NQhx3Q9/4mUxnGPw4g5+pQs53pbFt9TYnHjtbXoTAuDU/hk0Ry5z1GVIKLF9EEbD4dolM+qm+6hzJzVooLBlKXzNbbHwfwUpQnURqmsEtBCrAOpPAyR2y0V0dtMrjGt2gJspxlqoA6sMJ5m6p8movsZ4ET+Islo++Z4TAE5BBYJXR6sox6zQMYIzk+Z1wflVDS+VwgEDv04CsNHKrJ3wJTa4Had+7Dly8akXYfEhSdEPiJVWhs4x6U7+PNquXTC/hkTbKX+vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJHDGqyHfUmiXNGGc+/00buWSNo6jKUZ+qyz1X2S1Eo=;
 b=Cj0vPxn11rCBVx+zRe6PH8fauMGrsdofbkXBiBxW0l4E8TvLj54/d8IUVKBqJLxXuyCHOMhu8mnZPWHt7/9aqMJ8t3lZsBHg6GgZqmcAziheO+r31Iv+BmvxRJVM2c/BGTpfHLIEmbb8qw4UL9PaFpn+VmR6/8OuO2iJGbXOj/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM5PR12MB1420.namprd12.prod.outlook.com (2603:10b6:3:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Mon, 23 May
 2022 09:12:23 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c59:9713:48a5:da53]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c59:9713:48a5:da53%7]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 09:12:22 +0000
Message-ID: <5b6dd70a-acb1-6212-32c7-e59f2a421121@amd.com>
Date: Mon, 23 May 2022 14:42:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH Review 1/2] drm/amdgpu/pm: support mca_ceumc_addr in
 ecctable
Content-Language: en-US
To: "Stanley.Yang" <Stanley.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, tao.zhou1@amd.com, evan.quan@amd.com
References: <20220523081701.32456-1-Stanley.Yang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220523081701.32456-1-Stanley.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::24) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02b2d716-ef6d-420a-7ac3-08da3c9c57ed
X-MS-TrafficTypeDiagnostic: DM5PR12MB1420:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1420C1962D341D12E8B50FFE97D49@DM5PR12MB1420.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UF1tR+BjdbP0+V8b8TE5C2FLIKlnfMxTSFL+oxp8qbtkd3GOgD7zA53tyVh+wirbWmOVYSEjy/jzPSJ0fQzRv6iomyFR1nxBxLZxu5oc6B5ZvyDGl125mtaEXhjBMCuv/fOtuyyRKy8dodiljm7zKVPxJKSYF9XERwdpoFJPXO9csaTToyDEImpepa6ETik1frkunpWHoH7rhtg7nVJ4udjbKslg9s0H5yj8wq+2um+HX4PUdQGCoKZHtiBmeRGEGlekVHEeLxmew85ZGz6BA/DPyMg/I78PvyaTRO6d3x7F/0YdmnvjAujT+nMMxhU0C5pSEz/8qSUnpPR9iScd4tMJhge61Wm3cW8p2Bej2zBCrd7510ghaVJ8IP3ckBeebL9XwjMVnpXVswXH4s7U3WPpFKTTjOyluxJ5juzb1RlzHi14iiv+LvSgw3KErlaK/uPSUHoTo04OqOIHCuxUvHAkxeO1+s+Ick2b9jZG9hFk+er0avH3EldPw5xfxBdIOSSBUGU8G8N1RHt3XTXmPnZbXZLrRxMLptWtVgmAuU+P0aEh/ubNK9u1NOx7AZGQOdbfIXdb80wb2mLoZAbpl0+WNuUiXkrRVDon2KJRVfEem7/xCCeS5adra4JnQ9THNOpIg47TuTFBbGQJARTJJmzaDLSVp9yLC0gC9TLxgMDoxjUs5VyyS6HZxJEHh1VSg+WNdiVtsJhZcUZLnpsmrN3dD0o9xQS80D6f14mAF2BG70CUkFj+s5IydU0PeHMv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(31696002)(5660300002)(86362001)(6486002)(316002)(6666004)(36756003)(19627235002)(508600001)(31686004)(2906002)(66556008)(26005)(6506007)(6636002)(53546011)(66946007)(6512007)(66476007)(38100700002)(8936002)(2616005)(8676002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmNpK0xYZFRBL0h1akF0NVlKZk1BaENFOUZOeEhScCtUbkpjcFJWbUU1cEY0?=
 =?utf-8?B?N05pSUQ3ZVp1bFlSbFl1UWV5aFE0cmtRNFdHSUhmdXV0dUZoalVqdU1Tc1Ay?=
 =?utf-8?B?SHkrRGd5b2tPV0ZjMitjVlJSbnpQamU4RThaVG55VUo0RW9NaDBNeFZPY0xP?=
 =?utf-8?B?Z3BxdlFZTTF3eGRRb0lFOVM0aEd4Qjg3TXFDamdxUTRmWE9UaFd0R2Y1RE0y?=
 =?utf-8?B?VmFDdzZ1ZlBlTm9YazBzWjdYU0cwK2pUUnFVWTduU2lDUmt1VmZqSmFOQXlm?=
 =?utf-8?B?bFdrL1pnUk84Sjc5VFlDdzJJOUVyaE1vQW43a1N4d3hmN2FRODZVUngvMHhu?=
 =?utf-8?B?VURmMytONUxGT3F3VWdRbyt4aStGNTJyT3ZLT25xNlR4d0gwdnFPTHRUWlBm?=
 =?utf-8?B?cHRTUmxiQ1g3MG54Sk1xTndBblMzaVJVMktpaUJ3eVRXZTRjRGYvS0x5OVFJ?=
 =?utf-8?B?TE9jVmJTWFNodG9VK3RTNHJMMEhNUERDTVk5ZlBzUzAwRURkK1FFYnpBRWx1?=
 =?utf-8?B?cFJFM09FdDMySXhxRlNuaGFVUHRjdm9GNUtENDcrMmVXeTdlcGwwejFzaVFm?=
 =?utf-8?B?MDNvODYrRU96M3NjaldYSDUzUnpkTHBYT2U5R1ZENThrdHpMUHJaQWp5ZVVi?=
 =?utf-8?B?WmdRZk84UFAzai9YeGJncGJFR3VIN0M2MEFXK09XaE9zTFFwZFoxV0lRL2Fk?=
 =?utf-8?B?M09Tc0YrOWVXd2JGRUFvbGVTcHpQbHBGWFIyZnMrUHpvd2Y5ODhqVjJNd042?=
 =?utf-8?B?RFRuUkVhb3RiZHdkQnR4MkpVT2pQSlNiQU5EY3JmeFdpTDdqTmsxYUo5c2c2?=
 =?utf-8?B?QVN6UzVRWkc0NFg0QlJ5THVGSHZwSEcySGRiZ0pVSTRONzkyelhxUUdVanhG?=
 =?utf-8?B?cXVEZTQ3S3BtajZmakt2aWsxQzF4eFBvZFlaSFUxcHU3RkNHY1FQa0FzNm41?=
 =?utf-8?B?d1ZIYkg5V3JyUUVPTHlKSUhJSTFqTFZWSVhxODFhWWJUc3pVLzlDd1p1ZDlo?=
 =?utf-8?B?RHNzVWhNcngzaWlnZ0FtVk93RlZ0d0lLRVZoYWQ4dG5OY29VU0NXekszQ0xx?=
 =?utf-8?B?WFFpM0FsY2tmNVFOc0Rydm5MR2MwTmdvaUlPNHdqK2IzYkhlanZHVTRJd01l?=
 =?utf-8?B?eWFZUWE0VFhNOVRodlZqcUxZbDVLeVFNcVdPVXpYWHpjdGRMOUNaaXpiV0V1?=
 =?utf-8?B?RytxZkdYZG9ZMTNzNHE0R2ExMDBBRnR5MWZPZ2hVVWhURTYwOWRTRmNQUElN?=
 =?utf-8?B?UHBzSWdUTzBXU0JIbXJiN2JOdWRSRHNwS3J3UTdva3hWVmY2ZDcvcDN4TTB3?=
 =?utf-8?B?UElGOUdHbllSK2lsZ3hmbmczSWN4bTAzMGhrblp4SkxCMFZ0djRmRjRWZTZ4?=
 =?utf-8?B?MDRiY3U2Tm03NFBRTVRFNitYcXo4S2dsVStQMFliTFo1L0FpTG5yUkNvbjhS?=
 =?utf-8?B?Z2ZsdlFiemtPbHQ4WkdSY2UwN1hQbVZIdWtGUmg2emhlQjZrWk5kR21HMGp5?=
 =?utf-8?B?dzY1MUVOU0Nqc1RsNnN1TUJxSDNmajEvQXJoVlhtRHQvOG4wTmxpdkc0WFpo?=
 =?utf-8?B?SUlsdE94cmt0ZWUrMTFQS3hmODYyaEJJN2xoVWlReXEyZk92NHRNOHB6RElL?=
 =?utf-8?B?ZmE2ZnFLVHB4dXI5TGVNYTF6TEwvZ092eThGUUtSMFl2Uys2RzJ6ZDJ4b2ll?=
 =?utf-8?B?MkdBR3ZNQ0FSRXRmdDRZZXl6L1JURG11aUJ1dHFkNExOeE1ydGFXMTRSQzlr?=
 =?utf-8?B?WGNza01aZURGTjN3eUt5QXlJR2lyWDByRmgrOFF6TE9BSGxYS2MrVXUveGx3?=
 =?utf-8?B?d3pZZHJ0RjU1MEpzeUlKMnVQMkE1SkVPNGowejMzZFBHQlgyc0lXZmVqdU1u?=
 =?utf-8?B?cGZLRVRubXB6Y1FuVmozT2RvanZjd29Xc1RMZ3lHMVRaWERtdjMvN1hKSFA5?=
 =?utf-8?B?dFNWVkRQRHNCWm1seDRLeW1kdVNKUDZ2dzdJUE02MDZlZ2xYZFViUk81Q1hs?=
 =?utf-8?B?ajhyM3lVanJmVjVmbFVwQUJSTWYwLzMyUkNmMGxzYXJOYVFRakhZUnlWazIx?=
 =?utf-8?B?RTNEazl4OUVkN0QxdlBuOUM2WURQR0J5WUlsUzQyd3ZETmxVRFNnbURacDYy?=
 =?utf-8?B?UUQrcTRaczN0dW16Z0hsSXh4TXJNVVlqMWcvT090VzExZ2s0elF6azdYZUF5?=
 =?utf-8?B?ZVJSREtEQ1R0RERheC92OWlHaFdlTTI4aHRsV28rVWZlOHZjb3c1RXBYWnVq?=
 =?utf-8?B?L1c2dW9Oelk2aWN1c2d4VXlpUmNrbVhwUDlJMXNuVzdZMEg2NHJ1S09kVWlO?=
 =?utf-8?B?WlFoZUVhTlVtd3Boejk4S2NPMTdPTjgwbFI2MFpIc3dFUHBnY1l1QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b2d716-ef6d-420a-7ac3-08da3c9c57ed
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 09:12:21.8310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTWN+Q8cvaBj25SgtGZ38yxqnHOS09ZIuU83ZpjV7GcuzSq7wITQmY2mxnxxPwFg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1420
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



On 5/23/2022 1:47 PM, Stanley.Yang wrote:
> SMU add a new variable mca_ceumc_addr to record
> umc correctable error address in EccInfo table,
> driver side add ecctable_v2 to support this feature
> 
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |   1 +
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   2 +
>   .../inc/pmfw_if/smu13_driver_if_aldebaran.h   |  15 +++
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 101 ++++++++++++++----
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   2 +
>   5 files changed, 98 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index b9a6fac2b8b2..28e603243b67 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -328,6 +328,7 @@ struct ecc_info_per_ch {
>   	uint16_t ce_count_hi_chip;
>   	uint64_t mca_umc_status;
>   	uint64_t mca_umc_addr;
> +	uint64_t mca_ceumc_addr;
>   };
>   
>   struct umc_ecc_info {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index a6a7b6c33683..9f7257ada437 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -322,6 +322,7 @@ enum smu_table_id
>   	SMU_TABLE_PACE,
>   	SMU_TABLE_ECCINFO,
>   	SMU_TABLE_COMBO_PPTABLE,
> +	SMU_TABLE_ECCINFO_V2,

Hi Stanley,

This is not the right approach. Need to ask FW team to fix this. There 
shouldn't be any new id with each version of table. You may check Sienna 
Cichlid smu metrics table as an example and ask FW team to follow 
something similar. I don't see 68.55 being released, so it's not late 
anyway. We don't need to keep defining pointers in table context per 
version of ECC table.

Thanks,
Lijo

>   	SMU_TABLE_COUNT,
>   };
>   
> @@ -340,6 +341,7 @@ struct smu_table_context
>   	void				*driver_pptable;
>   	void				*combo_pptable;
>   	void                            *ecc_table;
> +	void                            *ecc_table_v2;	// adapt to smu support record mca_ceumc_addr
>   	void				*driver_smu_config_table;
>   	struct smu_table		tables[SMU_TABLE_COUNT];
>   	/*
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h
> index 0f67c56c2863..2868604eff49 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_aldebaran.h
> @@ -522,6 +522,21 @@ typedef struct {
>   	EccInfo_t  EccInfo[ALDEBARAN_UMC_CHANNEL_NUM];
>   } EccInfoTable_t;
>   
> +typedef struct {
> +	uint64_t mca_umc_status;
> +	uint64_t mca_umc_addr;
> +	uint64_t mca_ceumc_addr;
> +
> +	uint16_t ce_count_lo_chip;
> +	uint16_t ce_count_hi_chip;
> +
> +	uint32_t eccPadding;
> +} EccInfo_t_v2;
> +
> +typedef struct {
> +	EccInfo_t_v2  EccInfo[ALDEBARAN_UMC_CHANNEL_NUM];
> +} EccInfoTable_t_v2;
> +
>   // These defines are used with the following messages:
>   // SMC_MSG_TransferTableDram2Smu
>   // SMC_MSG_TransferTableSmu2Dram
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 38af648cb857..e58df9490cec 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -82,6 +82,12 @@
>    */
>   #define SUPPORT_ECCTABLE_SMU_VERSION 0x00442a00
>   
> +/*
> + * SMU support mca_ceumc_addr in ECCTABLE since version 68.55.0,
> + * use this to check mca_ceumc_addr record whether support
> + */
> +#define SUPPORT_ECCTABLE_V2_SMU_VERSION 0x00443700
> +
>   /*
>    * SMU support BAD CHENNEL info MSG since version 68.51.00,
>    * use this to check ECCTALE feature whether support
> @@ -239,6 +245,9 @@ static int aldebaran_tables_init(struct smu_context *smu)
>   	SMU_TABLE_INIT(tables, SMU_TABLE_ECCINFO, sizeof(EccInfoTable_t),
>   		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>   
> +	SMU_TABLE_INIT(tables, SMU_TABLE_ECCINFO_V2, sizeof(EccInfoTable_t_v2),
> +			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> +
>   	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
>   	if (!smu_table->metrics_table)
>   		return -ENOMEM;
> @@ -255,6 +264,10 @@ static int aldebaran_tables_init(struct smu_context *smu)
>   	if (!smu_table->ecc_table)
>   		return -ENOMEM;
>   
> +	smu_table->ecc_table_v2 = kzalloc(tables[SMU_TABLE_ECCINFO_V2].size, GFP_KERNEL);
> +	if (!smu_table->ecc_table_v2)
> +		return -ENOMEM;;
> +
>   	return 0;
>   }
>   
> @@ -1802,7 +1815,8 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
>   	return sizeof(struct gpu_metrics_v1_3);
>   }
>   
> -static int aldebaran_check_ecc_table_support(struct smu_context *smu)
> +static int aldebaran_check_ecc_table_support(struct smu_context *smu,
> +		int *ecctable_version)
>   {
>   	uint32_t if_version = 0xff, smu_version = 0xff;
>   	int ret = 0;
> @@ -1815,6 +1829,11 @@ static int aldebaran_check_ecc_table_support(struct smu_context *smu)
>   
>   	if (smu_version < SUPPORT_ECCTABLE_SMU_VERSION)
>   		ret = -EOPNOTSUPP;
> +	else if (smu_version >= SUPPORT_ECCTABLE_SMU_VERSION &&
> +			smu_version < SUPPORT_ECCTABLE_V2_SMU_VERSION)
> +		*ecctable_version = 1;
> +	else
> +		*ecctable_version = 2;
>   
>   	return ret;
>   }
> @@ -1824,36 +1843,72 @@ static ssize_t aldebaran_get_ecc_info(struct smu_context *smu,
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
>   	EccInfoTable_t *ecc_table = NULL;
> +	EccInfoTable_t_v2 *ecc_table_v2 = NULL;
>   	struct ecc_info_per_ch *ecc_info_per_channel = NULL;
>   	int i, ret = 0;
> +	int table_version = 0;
>   	struct umc_ecc_info *eccinfo = (struct umc_ecc_info *)table;
>   
> -	ret = aldebaran_check_ecc_table_support(smu);
> +	ret = aldebaran_check_ecc_table_support(smu, &table_version);
>   	if (ret)
>   		return ret;
>   
> -	ret = smu_cmn_update_table(smu,
> -			       SMU_TABLE_ECCINFO,
> -			       0,
> -			       smu_table->ecc_table,
> -			       false);
> -	if (ret) {
> -		dev_info(smu->adev->dev, "Failed to export SMU ecc table!\n");
> -		return ret;
> -	}
> +	if (table_version == 1) {
> +		ret = smu_cmn_update_table(smu,
> +				       SMU_TABLE_ECCINFO,
> +				       0,
> +				       smu_table->ecc_table,
> +				       false);
> +		if (ret) {
> +			dev_info(smu->adev->dev, "Failed to export SMU ecc table!\n");
> +			return ret;
> +		}
> +
> +		ecc_table = (EccInfoTable_t *)smu_table->ecc_table;
> +
> +		for (i = 0; i < ALDEBARAN_UMC_CHANNEL_NUM; i++) {
> +			ecc_info_per_channel = &(eccinfo->ecc[i]);
> +			ecc_info_per_channel->ce_count_lo_chip =
> +				ecc_table->EccInfo[i].ce_count_lo_chip;
> +			ecc_info_per_channel->ce_count_hi_chip =
> +				ecc_table->EccInfo[i].ce_count_hi_chip;
> +			ecc_info_per_channel->mca_umc_status =
> +				ecc_table->EccInfo[i].mca_umc_status;
> +			ecc_info_per_channel->mca_umc_addr =
> +				ecc_table->EccInfo[i].mca_umc_addr;
> +		}
> +	} else if (table_version == 2) {
> +		/* still use SMU_TABLE_ECC_INFO index,
> +		 * smu 68.55.0 add mca_ceumc_addr variable
> +		 * in EccInfo_t struct to report correctable
> +		 * error address and the table_id is not changed
> +		 */
> +		ret = smu_cmn_update_table(smu,
> +				       SMU_TABLE_ECCINFO,
> +				       0,
> +				       smu_table->ecc_table_v2,
> +					   false);
>   
> -	ecc_table = (EccInfoTable_t *)smu_table->ecc_table;
> -
> -	for (i = 0; i < ALDEBARAN_UMC_CHANNEL_NUM; i++) {
> -		ecc_info_per_channel = &(eccinfo->ecc[i]);
> -		ecc_info_per_channel->ce_count_lo_chip =
> -			ecc_table->EccInfo[i].ce_count_lo_chip;
> -		ecc_info_per_channel->ce_count_hi_chip =
> -			ecc_table->EccInfo[i].ce_count_hi_chip;
> -		ecc_info_per_channel->mca_umc_status =
> -			ecc_table->EccInfo[i].mca_umc_status;
> -		ecc_info_per_channel->mca_umc_addr =
> -			ecc_table->EccInfo[i].mca_umc_addr;
> +		if (ret) {
> +			dev_info(smu->adev->dev, "Failed to export SMU ecc table_v2!\n");
> +			return ret;
> +		}
> +
> +		ecc_table_v2 = (EccInfoTable_t_v2 *)smu_table->ecc_table_v2;
> +
> +		for (i = 0; i < ALDEBARAN_UMC_CHANNEL_NUM; i++) {
> +			ecc_info_per_channel = &(eccinfo->ecc[i]);
> +			ecc_info_per_channel->ce_count_lo_chip =
> +				ecc_table_v2->EccInfo[i].ce_count_lo_chip;
> +			ecc_info_per_channel->ce_count_hi_chip =
> +				ecc_table_v2->EccInfo[i].ce_count_hi_chip;
> +			ecc_info_per_channel->mca_umc_status =
> +				ecc_table_v2->EccInfo[i].mca_umc_status;
> +			ecc_info_per_channel->mca_umc_addr =
> +				ecc_table_v2->EccInfo[i].mca_umc_addr;
> +			ecc_info_per_channel->mca_ceumc_addr =
> +				ecc_table_v2->EccInfo[i].mca_ceumc_addr;
> +		}
>   	}
>   
>   	return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index ae6321af9d88..af2d84a16f3e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -552,9 +552,11 @@ int smu_v13_0_fini_smc_tables(struct smu_context *smu)
>   	kfree(smu_table->hardcode_pptable);
>   	smu_table->hardcode_pptable = NULL;
>   
> +	kfree(smu_table->ecc_table_v2);
>   	kfree(smu_table->ecc_table);
>   	kfree(smu_table->metrics_table);
>   	kfree(smu_table->watermarks_table);
> +	smu_table->ecc_table_v2 = NULL;
>   	smu_table->ecc_table = NULL;
>   	smu_table->metrics_table = NULL;
>   	smu_table->watermarks_table = NULL;
> 
