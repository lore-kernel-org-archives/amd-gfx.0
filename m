Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D3EC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 11:24:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9AAD61B97
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 11:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B9AAD61B97
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F42E6E3F2;
	Wed, 17 Nov 2021 11:24:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF20D6E3F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 11:23:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDynRn9PythhRUb9MAzEJ7griiATtH4GAiojWw7nchFBXXpmUglnWrrqzD08Ogs9DF9GiKSeqYlw0gIHCp4agYN5ctACyKuH2yHXQhrXhZCuxQgi6QxWXVV3UskhB31hQg0MIdZoaiyenPz1vHOMRRtSWy6d99zQfOB7uczZ1NxHlOZ7/F/33gk0dihTVL8tz+ALlnvQ3K9Z4hjCavrN7Hd7KVIY17k97CovEBtdhod7py57wGdc12Yg0FgXNIwQEBVmt4qB5XrCtb7JX3yRnLoY9auARN9UnK+u2ULtvLGHX0Q/Rbv9t7lqYNdm8DdSpBRQkIV6WBBJ90aR/tV/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKN/Rzxh+DhOnsmv1X82/IdWP/oWMxdP9xilpNvgBrA=;
 b=DqbBRbkCiZ3ICSt3VxposTS5mcYBE9JFuol1OnqdVVGFFQ9dKDxc03OJguUDxLx7qluvTtFxm3A2pXHUEL5t1xhwQ1v5r2Z3N+U8LGojGut6hl7Y1NjMT64SCUzkZ7j48eN85MtHYl6x7pbnS+Sd0fo+O8naT4YAfXfoWD+M3yX+2+luyi3nRFqZEQinOc7dSfjYmCubEo20qnJAbptq4FgcMIUYZgGdqbsT9bzq6X8EqCUAJH1fWnBFYowibOaxzxhMRYYjo4/DdVVvm2yawhlxW7OJxFO6FCd/N7ecmt6zEmu10tuSNxRPy4qVUfwULz5zFvtl3pyql7L0wiSN+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKN/Rzxh+DhOnsmv1X82/IdWP/oWMxdP9xilpNvgBrA=;
 b=hk+UOdmI9Kttw2ppAs+QMZ2wetrJJQ7nN2W4Avor7/DDSir41/5ai3044Fn2ay1uLCYqZsvcKv7Pbj2v4SFsL6SSxCzlGUr9W5zfrDMRSAAAzRd4JsxjKzyo/tscuJGvlZopMkTrQpTe1662/CZTuYVuxY8ZOsZ1LPJPUUprzHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1337.namprd12.prod.outlook.com (2603:10b6:3:6e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.20; Wed, 17 Nov
 2021 11:23:57 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 11:23:57 +0000
Message-ID: <daa32ce8-5afd-a9db-fbd3-f9bb874622f3@amd.com>
Date: Wed, 17 Nov 2021 16:53:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH Review 3/4] drm/amdgpu: add message smu to get ecc_table
Content-Language: en-US
To: "Stanley.Yang" <Stanley.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com, John.Clements@amd.com, Evan.Quan@amd.com,
 KevinYang.Wang@amd.com
References: <20211117101132.6568-1-Stanley.Yang@amd.com>
 <20211117101132.6568-3-Stanley.Yang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211117101132.6568-3-Stanley.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::33) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BMXPR01CA0023.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:d::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.19 via Frontend Transport; Wed, 17 Nov 2021 11:23:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b43f9bb-2ecd-48a2-143f-08d9a9bcbe95
X-MS-TrafficTypeDiagnostic: DM5PR12MB1337:
X-Microsoft-Antispam-PRVS: <DM5PR12MB13376C59566D3247C66724AB979A9@DM5PR12MB1337.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k+1iuK0E8dhR7PRUzqdQ9DRy5RpmSJMKU0GsUbq5jOuo4I7uEoDW7jW3MaQhPpfNPqqc0qG2i7v3L6IEz91E3lGX5vbCJ5mXR0crL4EjveIVKuYsJrsAoUHuWAWT8M0+tiEUnHu3uIxk5f0j7gaW8u10vXO3AFK0e1DXeE1jm5QnzrhmdslX9JLOZPGSaummoo1SENu+UNYfcQqBYt18XDMkx/7q+MqhevyYaFRkrxmSU9oc+C3+Phr6Lo3MmUvHlUdxG4niQ4525Szge92RvoT4mhs1XREhlKi2l5/VUIN3tR8SPAIYFZDJnbofVf++uVyajC0CPSGcYltA6YWsnnwXsR7do1RTZEE8KxDFC9xJAHLJVKIIBvU4CMmOZAX99hlzEc9UgAprjIG3rzS0HspZDby2u63mLgSlTCwyEeFkMCxjSbhDPBG4M9WQPAxDIjv+ed+TmZ+a866ZvtT92jgPzowD8XA/EKcCqXZxBZqzzBj8fKjtYYoDXxpsTqTlAQv1HTyngTcEtNCaYWheAUkHyQQrHiNvUuCnV6Etx/jeTxQ0xSrPK39xvpI2+gTxuXBgc0/TE01+awIvSTF4CJJ0akthuper3KXAFY/+RHBZM6yHw2vfOyL+npBL6IMGAAERuWYaALBMlww5Qm8N2UvcjrheMEtKL/slgEMwiasS72Gu6xbDXoUviln5q/mUfWrDlsDnORLnQPqzB31+HP+2YmtoFrZVao+R81BpG7o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(86362001)(38100700002)(6636002)(16576012)(6486002)(8676002)(15650500001)(26005)(66556008)(53546011)(186003)(6666004)(31696002)(66476007)(316002)(66946007)(2616005)(5660300002)(36756003)(956004)(83380400001)(31686004)(2906002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnVZREQ5ZkdoNjlLZzJlbU85bkNoUGRqMmpMK25zYllSWTF1ekVtcUg5Z0tl?=
 =?utf-8?B?UllsbEo1REVRdkxpZEFqZ0NoVjQvTkwxRGk3ejJTYlZnS3llYWo0c1Zybkx3?=
 =?utf-8?B?R2Eyc3ZwYWNVZW85NWRYNHlXTnlta3FJNUxveXRDOXI3UEE0Tk9TRjZKeFBQ?=
 =?utf-8?B?NlhwOEFLMWxnVDg1emJLVWppMndPZXE2SDhnRm5qdkQyZlpsZmNEVHRGeTZz?=
 =?utf-8?B?V3RDQmdxU1hjVHFSTXE5MEtaL2wrN1A4SlNyU2lTZEtlMG5vT3QwbmhWS2t0?=
 =?utf-8?B?anV3OG03eVFOdlZGUUFYZCtSYTRIRjJTZW1BWk5HZjRuVmxHbkMvdldzeDJ0?=
 =?utf-8?B?aUlGZFN0UzVNbTBqN3hvZFp1cTZSZTJxQ0sxa1FLbHlrUzVjSWRrL1BEU2Nw?=
 =?utf-8?B?RkJCQUUwa0hXNmEyTUg0UGdKVGxqRU94N0xtWXFxWW1pVzBId245M0JCcXhC?=
 =?utf-8?B?UlFFWkZFUU5iVy9Kd0htR3RYbEo5L2E0NzhCS2RQUGFpeXVrLzBaVllzb3dw?=
 =?utf-8?B?Z004Q21HVnc2ek9FdWhnRkRpZGc2eE5Ib1NIYzE3bFBBVEhOdkpRZnpWZlBt?=
 =?utf-8?B?Y1c3WlRJckRuQ0lxYTlwOHVoeko2NnVNQ05qUzBtWktHVlpReVMvODd6eFkx?=
 =?utf-8?B?ZzJmUkt1bVZwK2kzUmJwL3NqZ2J1cjRLKzRuZnNSbE1YY29DTTNGa2J3SFJN?=
 =?utf-8?B?NWYySmNQMHowYXYyT1U4WlkrRFovZHQwYzl3MmlJKzBaZFVMWEtUL1lrSThv?=
 =?utf-8?B?ZjNPaEFRMkFJU0NVcjhDeFhlV29tYy95anNQMUd3Vm5FbUgwZzNYcmo3eG5B?=
 =?utf-8?B?RUNsN21idUV6OG12WkYrZGlJMVdhTVN3WUNOVXYvZkYwUHE0YmEvZENTNGdP?=
 =?utf-8?B?UUJCSUw5SWZLaW4yTGJycjlQQW91NFBYdmM2NmFkUm5Ya1ZiRDdFSkVvNzNF?=
 =?utf-8?B?VlZiVVNjZjlTQjlKd1dWZytsM1VhcUVkdlIyamJtU2Z6SEwrcGo3R0I2U1FM?=
 =?utf-8?B?akdCR256bHloQnFVQTQ0Q0NXSFlVS3dmV0NiUGs3aDdGNHFTWUYxdUM4MCto?=
 =?utf-8?B?M0V3cmM0ZDNxa3NkemhmREJvSTNUZ1hFSTNKYS9YbGVNbDdUWVNkeE83Q2pI?=
 =?utf-8?B?NDZVajdpZnlmeDRrVTdodEx2eU1aTURLMy9yc254N3pSM0FONEI2cEhDZmky?=
 =?utf-8?B?VlJ0eEJWL1FyQUc1M2lrSXVtRkQ1UExjcEpUUUlWQ2FPR2ZyUW5SMHgzd0JO?=
 =?utf-8?B?bkJvNXlFR3NjT0Y5ZHoraDAxWXdJci9DMVEyK0Z3WHlkZVpDMWhreVRad2tr?=
 =?utf-8?B?ek5IelZEbEFIZVU2OEJtTmlRL2tWYUVSckxvTGhxVnUyM0lIc3JDZWQzTS80?=
 =?utf-8?B?ZjF5R1E5bzhuQlZodTAwbTkzZnphb0x3TEhzK1RWSE5nZzdCVHdBNWhiSW1n?=
 =?utf-8?B?QTRsbWNqVkVtMFhZWEF0S0JkZW13eTFyVlFsVHZKc0NaU3Jqd0szWFN0eDFY?=
 =?utf-8?B?QzBZWnNsWW9sNlFsWUdFTE52ald2V2E5emVveVpiRm84WHo4amlDZ05BRVlY?=
 =?utf-8?B?Qm9oN1dYSHVabkVVa2htU0U5VGtYaTBzbWs3OVhPU3l4bDgwWjlVclJUeVhi?=
 =?utf-8?B?NVFqVUFpQkkveUdxVndFcU03alVPeVFka3E4bkRvcDNnbGhBeUcvVm1rV2VQ?=
 =?utf-8?B?K3pmTm4wME9PdXYwbTN2QW1aQkFHd1hncGpacXVJZkF3OVZ2a0VtVjlpelBp?=
 =?utf-8?B?TEN2RDlrR2FhWFp0Ym5xeDNNN3BIZklRWjM2U2RNOXEwTnRxbzJ5TGdyK3d3?=
 =?utf-8?B?TXRBRUdCajlpT01HQ0FRMlB1ak9FOGxiYXE2eHdOTW0rZHhiWndTNkY0bVJv?=
 =?utf-8?B?aERXL0lIZmx0RXB1NWprN0JuRkFXaFRONkx5MFdlNVZNeENnYjUxd1Yxanhw?=
 =?utf-8?B?TFgvczh1Q3RqL0M3SnBtZ1hNaEt4d0tIZlZGM3RXMS85MHpVR3VzRGpLd0pN?=
 =?utf-8?B?N1MwKzlwOHhZNXZ6QlZQRXh1THVSam5uYUplMkREYzZoV2tET1gwVWo4akVI?=
 =?utf-8?B?eEg5SjZTbkdaMnFveURBOEFNMWdsZC9JN1ArSlZKc0VBUnc1YjRtdTlVOG02?=
 =?utf-8?Q?Nezs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b43f9bb-2ecd-48a2-143f-08d9a9bcbe95
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 11:23:56.9280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkZLdEDc+O73ja4ca/LnarS1IyPBO939bDWhITj7Tzfsy2Gs1ONi6tn895+ngNNU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1337
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



On 11/17/2021 3:41 PM, Stanley.Yang wrote:
> support ECC TABLE message, this table include unc ras error count
> and error address
> 
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  7 ++++
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 38 +++++++++++++++++++
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  2 +
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 24 ++++++++++++
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  3 ++
>   5 files changed, 74 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 3557f4e7fc30..ea65de0160c3 100644
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
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index f835d86cc2f5..5e4ba0e14a91 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -190,6 +190,7 @@ static const struct cmn2asic_mapping aldebaran_table_map[SMU_TABLE_COUNT] = {
>   	TAB_MAP(SMU_METRICS),
>   	TAB_MAP(DRIVER_SMU_CONFIG),
>   	TAB_MAP(I2C_COMMANDS),
> +	TAB_MAP(ECCINFO),
>   };
>   
>   static const uint8_t aldebaran_throttler_map[] = {
> @@ -223,6 +224,9 @@ static int aldebaran_tables_init(struct smu_context *smu)
>   	SMU_TABLE_INIT(tables, SMU_TABLE_I2C_COMMANDS, sizeof(SwI2cRequest_t),
>   		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>   
> +	SMU_TABLE_INIT(tables, SMU_TABLE_ECCINFO, sizeof(EccInfoTable_t),
> +		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> +
>   	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
>   	if (!smu_table->metrics_table)
>   		return -ENOMEM;
> @@ -235,6 +239,10 @@ static int aldebaran_tables_init(struct smu_context *smu)
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
> @@ -1765,6 +1773,35 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
>   	return sizeof(struct gpu_metrics_v1_3);
>   }
>   
> +static ssize_t aldebaran_get_ecc_info(struct smu_context *smu,
> +					 void *table)
> +{
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +	EccInfoTable_t ecc_table;
> +	struct ecc_info_per_ch *ecc_info_per_channel = NULL;
> +	int i, ret = 0;
> +	struct umc_ecc_info *eccinfo = (struct umc_ecc_info *)table;
> +
> +	ret = smu_cmn_get_ecc_info_table(smu,
> +					&ecc_table);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < ALDEBARAN_UMC_CHANNEL_NUM; i++) {
> +		ecc_info_per_channel = &(eccinfo->ecc[i]);
> +		ecc_info_per_channel->ce_count_lo_chip =
> +			ecc_table.EccInfo[i].ce_count_lo_chip;
> +		ecc_info_per_channel->ce_count_hi_chip =
> +			ecc_table.EccInfo[i].ce_count_hi_chip;
> +		ecc_info_per_channel->mca_umc_status =
> +			ecc_table.EccInfo[i].mca_umc_status;
> +		ecc_info_per_channel->mca_umc_addr =
> +			ecc_table.EccInfo[i].mca_umc_addr;
> +	}
> +
> +	return ret;
> +}
> +
>   static int aldebaran_mode1_reset(struct smu_context *smu)
>   {
>   	u32 smu_version, fatal_err, param;
> @@ -1967,6 +2004,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
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
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 843d2cbfc71d..e229c9b09d80 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -983,6 +983,30 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,
>   	return ret;
>   }
>   
> +int smu_cmn_get_ecc_info_table(struct smu_context *smu,
> +				     void *ecc_table)
> +{
> +	struct smu_table_context *smu_table= &smu->smu_table;
> +	uint32_t table_size =
> +		smu_table->tables[SMU_TABLE_ECCINFO].size;
> +	int ret = 0;
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
> +	if (ecc_table)
> +		memcpy(ecc_table, smu_table->ecc_table, table_size);

This copy to another buffer is redundant. You may use ecc_table directly 
in the callback, then this method itself looks unnecessary. Instead of 
calling smu_cmn_get_ecc_info_table(), call smu_cmn_update_table() and 
copy directly from ecc_table.

Thanks,
Lijo

> +
> +	return 0;
> +}
> +
>   void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
>   {
>   	struct metrics_table_header *header = (struct metrics_table_header *)table;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index beea03810bca..0adc5451373b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -105,6 +105,9 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,
>   			      void *metrics_table,
>   			      bool bypass_cache);
>   
> +int smu_cmn_get_ecc_info_table(struct smu_context *smu,
> +			      void *table);
> +
>   void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev);
>   
>   int smu_cmn_set_mp1_state(struct smu_context *smu,
> 
