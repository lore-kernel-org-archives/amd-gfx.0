Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DB4C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 11:33:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD21361AFB
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 11:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AD21361AFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3924C6E906;
	Thu, 18 Nov 2021 11:33:08 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8E866E906
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 11:33:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5b9feNLFSjzDvtCod0Yw7bRGYefmRZcLlaConRzqjZs9jW9FlSK50Ujl5U4qaS/i1eyHQFu135zTkdlb2WecrdOKkKNXmrNn3dy619H3fWIA3I8NV8IYWiztiKtiN+v5In/x77eRqvt/d7GUN9D3CVRR99K2jyCVDOSkn/wv0+TrXzt+NlBm548ukQtzGf9kSZsPJNLHEihrEj7y3kX8dxnd5aQlp5YW7uEK0Yk6KbtXCK2GR/drIf3qpLHHE11Gp9E4c0wbtwI0GBbW9e40SILyJ570YXF6ELTmOYtiSE2uSxkjLxA1rDjlwQZ6CRiuDZ5qIyyfjecHf2wgn+beg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ug4KlnG8YlUDto1S76/1er3rWgbQ0K7vlzSRQb7hmbY=;
 b=i822wM3XKj8ZwTcdgxbiVf8r6DJ5lvv3KEMwih2xAqay8gl7cikuN1G4qL4/hVdL4uUlEgnIB7KjpayaT5gnMMJcQD/aDBO9MQ7TGeSs6k4nzecZHqV6MMVJQqIsGX/ckFpX+BXVhLe06XrmMbjXnTP9ya+/g1htx9Jdg8Vm/6oYOsw6BgfJBLFsy2WtulndsH5dLR0BNvwgTiUkwqiFgW7Z6RslBvpLI28z/9GFFO9OjogBhq7nGepkGHLGnjo7+aCXPO+ctKc1LT3+a0yA4Yg9cMM74jprZ8WcB+DdKFEq5eCcJqIRVnB2hAJaUmYpfrdJg2+lD7zmIRzIxeYbMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ug4KlnG8YlUDto1S76/1er3rWgbQ0K7vlzSRQb7hmbY=;
 b=BMgqNtkffMT8oIzy7AITeUtMUlHRH7td+xbnSVQC+4mJPUbP0hPqkrdF1SLPk355lF6PcOnKtARRYDwyb8HKn1vKsczfEdDTJKdF8mRafzJjyuSB3gF01fgWgIa5Q4VcX11Ht4U4B93elIaqK4B10KYc3p5GfPHSlpn3Rxz4dRA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Thu, 18 Nov
 2021 11:33:03 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 11:33:03 +0000
Message-ID: <491af5a4-e6d9-6210-6819-1817f04d7700@amd.com>
Date: Thu, 18 Nov 2021 17:02:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH Review 3/4] drm/amdgpu: add message smu to get ecc_table v2
Content-Language: en-US
To: "Stanley.Yang" <Stanley.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com, John.Clements@amd.com, Evan.Quan@amd.com,
 KevinYang.Wang@amd.com
References: <20211118093344.4361-1-Stanley.Yang@amd.com>
 <20211118093344.4361-3-Stanley.Yang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211118093344.4361-3-Stanley.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::28) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BM1PR0101CA0018.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:18::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Thu, 18 Nov 2021 11:32:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f12e5b86-2d23-40b9-db47-08d9aa872e0a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:
X-Microsoft-Antispam-PRVS: <DM6PR12MB32122527F976C393B9AD71E2979B9@DM6PR12MB3212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BwsWUTka82Fiuhi1dj9qnXdIpHnEaEvMSGHdI+1GhdO9omB0/7HUVqnmqQ0mHA70pgFOZaP0gbm0aJRCgeZOBg8ut5gIR+u+K3Ja5ndaMP27iHw8NppZXdnUSV2rAO9+GUQomup1WppZ1Za44wNjPHGu+lJpD0Ovk8iiRLBDy0WN/cyRwLvb8l2DobYMFk9uoxHvcFjivLS6u/bBI26WGwjc3UyHjrh7X+g7SS6Odb6SazvrH3GKcszJzCjPAEh00jB0MYbHtFkXkJVKeg6HtrHZyu7x8S9F2WVs0hyOeXdG4+uR5kln2Rorw2kgVb53X+bd0EPPA84D8Dtn5+sxVa9sQu63OPpiWIW/jRc/F419V5jeD3Esn+zmrbmhYWGo7RYi6YKvgwecsPVCfJgncwLWzxMzcjRCoFVSi4kHkwSOEA/eyWCgfyKL/mxAv2WRROJlmXk6R7vqRkaLf8cq9TBZGYNkmcx+Lr4vLqyrXlRqI2mlQg220KDD4WeJSQKFG3dlHYiAOs1k+0LRyMKbc+PyHTQvaFFipRWTK+aEz54q6DEQqv4/Lv1Xv2UV9MgSDf65sBs03pNURpo4jC6G/79b32H/DQOCz2lF/mdwlimdU5+CHcXugKpas/itqp2yBZY1X14xRWyATcu9TYlLa5f0nFYGa0Up8Lello6ZA8zOuQu7AP4Vttg+nOnG56tn3uuo5220l1dXeVsNesrmfzPo50j2SQBCo9i9gg2+St4/4be+wmt1sDV0Bk8kQvwn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(8676002)(5660300002)(26005)(15650500001)(31696002)(6666004)(186003)(66556008)(316002)(53546011)(2906002)(86362001)(16576012)(6636002)(31686004)(83380400001)(2616005)(508600001)(6486002)(66946007)(8936002)(36756003)(66476007)(956004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0VXTmhHV1BLSnJZcFZDMzRkQzBLdUR0N1dFL3VSRlhWSGQxZmM2L1ZlZXlU?=
 =?utf-8?B?SHJHVlArZHhKWXB2Y2lEWkJRZXV2cXIwbUdmaXFlaUR5UktzaGRaRGhBWmV5?=
 =?utf-8?B?d29iRjNzbEI5YTlYYTdtRDd4ZUpLZTJDTkRXTm4wWFJwSUdHQlkwNW5LcEly?=
 =?utf-8?B?Uy9MZGY3RlVaUlU4TnI3UksvZTIrOE4zTGtOcEhWWlc0cktROXJNMjhhRG4v?=
 =?utf-8?B?RnlSV25uclBTVzM3QVI4a3hmcVVWRjIxRGRhNzRkWFg4d0NmNDlyUzNEYWxW?=
 =?utf-8?B?eldqQnd1RzhmRU5sdEx1a3BIYy9xY1JkUWxkMUdLdXJaSU5laFJuSlRLcGY1?=
 =?utf-8?B?VEh3Y20yQ0tYeXAzOXhiaEY2K01mOFpZbWdXaG5zbkNVcEYrNktFa3VYdnRa?=
 =?utf-8?B?VUF0KzJWYVB2QzFDYTVjOWNsUnBYRlZ3T1U5SC85b0JGd1p4OTNZRXRqbE91?=
 =?utf-8?B?WkEzcERoalRZUnY1VWlQZ1Y3V1hhL1VjMWR1ZHZhb3lxMi96S3gzMmdWZlRu?=
 =?utf-8?B?aWhBQncxaExDbXVUYkRIbDlwK0c0dDhVR1BDWGlPMVRmUytnOVdOSFR4WFpw?=
 =?utf-8?B?MXkxdW1rcFR3bU9aVmVjRUNYcHcvdVlhNmpwVVBFTW9OWjg0TkJaVkJsTm51?=
 =?utf-8?B?b29aSFVpdnFGZE13VUJyRStaNG9lRGx5VXlOSHNvNHdkUGZubTcrek43Ynow?=
 =?utf-8?B?YTRNT1p2SlRiaUNxN1FWdHlmWGh2SVhZRUdmdjdzZ0phR1FtRjUwY0F2cnNt?=
 =?utf-8?B?NEhuNm5PUnJzK3Z2Rm5tVEVINVU4MmxpSHR4MVdjMEVtUWJ5cHJQYkhzTi9n?=
 =?utf-8?B?cmhWRkVlRFlBVnBWY0daVElyWVpkQWhvdmVzNkNOL2FPaVdSeWdBZkFRSDlC?=
 =?utf-8?B?cE1NdHNjR3hmWGNJUjk3eXF0WVVpd3QyVG9VbUdpRnlGS0ptWjhvOG5VS3gv?=
 =?utf-8?B?UGFDRVBpeUZPbHRDd0VlQytvZlQyV2ZURnB0M2lJQ0ZCM0kvb1c1S2ZscTRy?=
 =?utf-8?B?aDJrTEZVWXRjMXZxYVB5Y29UYnUzZlY3eitLSlJ5QnRJeEVyek13aFA4Q004?=
 =?utf-8?B?T01KR3ZqYWZ3YUlZcFh2clhXYVVBOG05SjYyekdsb21LU3J4dFVaYXZoTGhw?=
 =?utf-8?B?U0Zwak1ES1hXWEtHUDdaQmsrWmNmL2UydVVhRlF3eG5pSUZDN2NQa01XTGha?=
 =?utf-8?B?eDcrY2cwdThCc3dOMys0S3NsWWZsdkltVVErMW5IU0xWWEh6cWFFN2FER1JG?=
 =?utf-8?B?OE1EbWZiWFFySDluSDVkZU5SSmkzTURJSXF2M1ArWVJhODdEa2lYMS9BZFdm?=
 =?utf-8?B?OUpsdUFuRlZrUDZvUzNObzFDeFhMcTdwRzVxcE1Rc0ZFMGNuYUdhSHVEVCtT?=
 =?utf-8?B?dmZLdkZMZnZVS2o5SXJrNncwcjhGdUs4ZEM4eEFlTGQ0QkxkTVdjUC9zdk9F?=
 =?utf-8?B?bkJCNjlRNEppbTlNWEdGaXpCMTB3M3htNjJCbS9mMEZlNjloZVhEUVphRHVD?=
 =?utf-8?B?b2U1UGx0TnV3UnlKQXREMVFtb0psUUxzL2dHTzZsVWVWYUJ2d0FETDE2LzBn?=
 =?utf-8?B?ZFJ3aVp2Rjk0ZTJNb1NUUzk1YmNGeWxIYjJtQ2llWVlkTG5HTE4zU2c4c3pj?=
 =?utf-8?B?QzR3SE9aQ2hWZWl2Qml1UHEwbytNY0lJS056c2MxUEc4eVArclFnaXArMUNI?=
 =?utf-8?B?VURYVm9tb1RRRHo2NWZZc0w3ZGJSdlluWlRYQndoWGNsaVZFTGQvQk5TR2Qy?=
 =?utf-8?B?dDZZQnhoQ2NVYjlRb3BxdnhSMklNcDRxSWphZmtQRU1LRHZWV21EcCtsbzll?=
 =?utf-8?B?OXV1TTBWY1Rsd0pSTUpKbnNyU21lc2NGM3R4NEtOUlpORDFtYXIvcnpyWndQ?=
 =?utf-8?B?cFNtVHQvaUpDY2srNk5VdjBTMWY2c24vTVR0Q3hvRU5kQmpleE5HU3E1dTA2?=
 =?utf-8?B?YWlVeXRNSGQwMlNnSGorR1gwQlEzd1B2a0pvbENjZlJxNWZaV1FHNjIwNkdG?=
 =?utf-8?B?Wlo1bWlJUzVVaHFJSmdwcXJMbGlHV1J0eHBPVm1pQzY1WjRkRlpSVnZ2Vk5F?=
 =?utf-8?B?aXozM1NWZWxPTFgrRDNNaW1RZUtraXNxbHlsVzhDYkZBMEhqS1dsblEvRVBB?=
 =?utf-8?Q?TBrc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f12e5b86-2d23-40b9-db47-08d9aa872e0a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 11:33:02.9390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWmIOxOGNO/E/sxmC8Rujgc1s9aI6XeHLSXG+FjSlSvb+fwuHzQKS7iOc4YlgaTm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
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



On 11/18/2021 3:03 PM, Stanley.Yang wrote:
> support ECC TABLE message, this table include umc ras error count
> and error address
> 
> v2:
>      add smu version check to query whether support ecctable
>      call smu_cmn_update_table to get ecctable directly
> 
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  8 +++
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 14 ++++
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 70 +++++++++++++++++++
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  2 +
>   4 files changed, 94 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 3557f4e7fc30..7a06021a58f0 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -324,6 +324,7 @@ enum smu_table_id
>   	SMU_TABLE_OVERDRIVE,
>   	SMU_TABLE_I2C_COMMANDS,
>   	SMU_TABLE_PACE,
> +	SMU_TABLE_ECCINFO,
>   	SMU_TABLE_COUNT,
>   };
>   
> @@ -340,6 +341,7 @@ struct smu_table_context
>   	void				*max_sustainable_clocks;
>   	struct smu_bios_boot_up_values	boot_values;
>   	void                            *driver_pptable;
> +	void                            *ecc_table;
>   	struct smu_table		tables[SMU_TABLE_COUNT];
>   	/*
>   	 * The driver table is just a staging buffer for
> @@ -1261,6 +1263,11 @@ struct pptable_funcs {
>   	 *										of SMUBUS table.
>   	 */
>   	int (*send_hbm_bad_pages_num)(struct smu_context *smu, uint32_t size);
> +
> +	/**
> +	 * @get_ecc_table:  message SMU to get ECC INFO table.
> +	 */
> +	ssize_t (*get_ecc_info)(struct smu_context *smu, void *table);
>   };
>   
>   typedef enum {
> @@ -1397,6 +1404,7 @@ int smu_set_light_sbr(struct smu_context *smu, bool enable);
>   
>   int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
>   		       uint64_t event_arg);
> +int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc);
>   
>   #endif
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 01168b8955bf..fd3b6b460b12 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -3072,6 +3072,20 @@ int smu_set_light_sbr(struct smu_context *smu, bool enable)
>   	return ret;
>   }
>   
> +int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc)
> +{
> +	int ret = -EOPNOTSUPP;
> +
> +	mutex_lock(&smu->mutex);
> +	if (smu->ppt_funcs &&
> +		smu->ppt_funcs->get_ecc_info)
> +		ret = smu->ppt_funcs->get_ecc_info(smu, umc_ecc);
> +	mutex_unlock(&smu->mutex);
> +
> +	return ret;
> +
> +}
> +
>   static int smu_get_prv_buffer_details(void *handle, void **addr, size_t *size)
>   {
>   	struct smu_context *smu = handle;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index f835d86cc2f5..4c21609ccea5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -78,6 +78,12 @@
>   
>   #define smnPCIE_ESM_CTRL			0x111003D0
>   
> +/*
> + * SMU support ECCTABLE since version 68.42.0,
> + * use this to check ECCTALE feature whether support
> + */
> +#define SUPPORT_ECCTABLE_SMU_VERSION 0x00442a00
> +
>   static const struct smu_temperature_range smu13_thermal_policy[] =
>   {
>   	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000},
> @@ -190,6 +196,7 @@ static const struct cmn2asic_mapping aldebaran_table_map[SMU_TABLE_COUNT] = {
>   	TAB_MAP(SMU_METRICS),
>   	TAB_MAP(DRIVER_SMU_CONFIG),
>   	TAB_MAP(I2C_COMMANDS),
> +	TAB_MAP(ECCINFO),
>   };
>   
>   static const uint8_t aldebaran_throttler_map[] = {
> @@ -223,6 +230,9 @@ static int aldebaran_tables_init(struct smu_context *smu)
>   	SMU_TABLE_INIT(tables, SMU_TABLE_I2C_COMMANDS, sizeof(SwI2cRequest_t),
>   		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>   
> +	SMU_TABLE_INIT(tables, SMU_TABLE_ECCINFO, sizeof(EccInfoTable_t),
> +		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> +
>   	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
>   	if (!smu_table->metrics_table)
>   		return -ENOMEM;
> @@ -235,6 +245,10 @@ static int aldebaran_tables_init(struct smu_context *smu)
>   		return -ENOMEM;
>   	}
>   
> +	smu_table->ecc_table = kzalloc(tables[SMU_TABLE_ECCINFO].size, GFP_KERNEL);
> +	if (!smu_table->ecc_table)
> +		return -ENOMEM;
> +
>   	return 0;
>   }
>   
> @@ -1765,6 +1779,61 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
>   	return sizeof(struct gpu_metrics_v1_3);
>   }
>   
> +static int aldebaran_check_ecc_table_support(struct smu_context *smu)
> +{
> +	uint32_t if_version = 0xff, smu_version = 0xff;
> +	int ret = 0;
> +
> +	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
> +	if (ret)
> +		ret = -EOPNOTSUPP;	// return not support if failed get smu_version
> +
> +	if (smu_version < SUPPORT_ECCTABLE_SMU_VERSION)
> +		ret = -EOPNOTSUPP;
> +
> +	return ret;
> +}
> +
> +static ssize_t aldebaran_get_ecc_info(struct smu_context *smu,
> +					 void *table)
> +{
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +	EccInfoTable_t *ecc_table = NULL;
> +	struct ecc_info_per_ch *ecc_info_per_channel = NULL;
> +	int i, ret = 0;
> +	struct umc_ecc_info *eccinfo = (struct umc_ecc_info *)table;
> +

Missed to ask last time. Since umc_ecc_info is a common struct, do you 
also want to pass back the number of channels having data?

Now this struct can hold max of 32 channel data. Let's say if the same 
interface is going to be used on another ASIC X having only 16 channels. 
Then the callback for ASIC X fills data only for 16 channels. Or, you 
expect that to be taken care at the caller side?

Thanks,
Lijo

> +	ret = aldebaran_check_ecc_table_support(smu);
> +	if (ret)
> +		return ret;
> +
> +	ret = smu_cmn_update_table(smu,
> +			       SMU_TABLE_ECCINFO,
> +			       0,
> +			       smu_table->ecc_table,
> +			       false);
> +	if (ret) {
> +		dev_info(smu->adev->dev, "Failed to export SMU ecc table!\n");
> +		return ret;
> +	}
> +
> +	ecc_table = (EccInfoTable_t *)smu_table->ecc_table;
> +
> +	for (i = 0; i < ALDEBARAN_UMC_CHANNEL_NUM; i++) {
> +		ecc_info_per_channel = &(eccinfo->ecc[i]);
> +		ecc_info_per_channel->ce_count_lo_chip =
> +			ecc_table->EccInfo[i].ce_count_lo_chip;
> +		ecc_info_per_channel->ce_count_hi_chip =
> +			ecc_table->EccInfo[i].ce_count_hi_chip;
> +		ecc_info_per_channel->mca_umc_status =
> +			ecc_table->EccInfo[i].mca_umc_status;
> +		ecc_info_per_channel->mca_umc_addr =
> +			ecc_table->EccInfo[i].mca_umc_addr;
> +	}
> +
> +	return ret;
> +}
> +
>   static int aldebaran_mode1_reset(struct smu_context *smu)
>   {
>   	u32 smu_version, fatal_err, param;
> @@ -1967,6 +2036,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
>   	.i2c_init = aldebaran_i2c_control_init,
>   	.i2c_fini = aldebaran_i2c_control_fini,
>   	.send_hbm_bad_pages_num = aldebaran_smu_send_hbm_bad_page_num,
> +	.get_ecc_info = aldebaran_get_ecc_info,
>   };
>   
>   void aldebaran_set_ppt_funcs(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 4d96099a9bb1..55421ea622fb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -428,8 +428,10 @@ int smu_v13_0_fini_smc_tables(struct smu_context *smu)
>   	kfree(smu_table->hardcode_pptable);
>   	smu_table->hardcode_pptable = NULL;
>   
> +	kfree(smu_table->ecc_table);
>   	kfree(smu_table->metrics_table);
>   	kfree(smu_table->watermarks_table);
> +	smu_table->ecc_table = NULL;
>   	smu_table->metrics_table = NULL;
>   	smu_table->watermarks_table = NULL;
>   	smu_table->metrics_time = 0;
> 
