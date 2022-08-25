Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D519C04AA5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 12:34:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 562CA10E039;
	Thu, 25 Aug 2022 12:34:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48DDA10E039
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 12:34:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmy3oswzC2Q0vs97iLXRMEsy77HekMLolcZYVgars2ACW32ZcrTHjbExk5M6Pt+HqZ1UFTARBrrqAmBHDCwsY0kC0DqybsoUc354cv54o7V1AJAPXR3mqv5daAiHNTruiUZc+wYbBA2sTZ5Bt4yeYYmyCqGHbREXwcLhGqZjFwse1GViBsyBKBjQAd/YS+GOZi8VIEtZx8uKzUwNhUcdIy7ss4u38FQ7tHo116AEU2ib+t0nuCV+5154c/0qZZpsR6KOVtKZkb7kqR5+bZYJ8nmRDR0ddmdZbQfv3VeQiWxd48tCFSTbw9xvbK3bfQ/ncrRV67X/LrASrSEyx/zusQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mEb/JIy5+M/pmFaUHySBgRdI6YmM8Dqpy8cPvsO2LE=;
 b=nK+pxB7kfEf/UPOeszlQJRV2ePy+LAUFhKE1GnbJ8z4quDKcCsvrDFZxxTU/cNg9p/qM2mcwS7b6stWQBBniJgt2256kArZkiYmOuWSb6KKPc/g+iqZfVr6OH5METuMBcPYXrxjr/0fVZFDOmVsUrBmyTtDRV4KPBY7ExNecTdpcDw8oEQyh/WyR9VU+IrxZanWjD/giypxpINdS7ynZX84Y0R0PD7JrGunQBEMX7VaI1IXjLEfxNos+Bq/TuGJYF2AVh6sRr57afI6OwrTTMHedth0FMVhFB368ItoD+dvt2cmV7SjJOc+nmWROw/NQDU9STWU2ocny+BuNI+NpUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mEb/JIy5+M/pmFaUHySBgRdI6YmM8Dqpy8cPvsO2LE=;
 b=JPCLZ0koRYSQbTkJp8Mf0pmyXA7ULbMmsXN4KDnNDxpVOxJfVf3zsE489jYrMX8D2X2PFFP6ZMDmghyRIFwoNOb6WTJj46KeTYEKazytDqT9ABy72h8Z1uP7ErqhgQR3Ov5Rz4UFxuHriCVeCJgozV5BpiFQtTMuVqv4aCjc+TA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 12:34:22 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2925:100a:f0b9:9ad8]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2925:100a:f0b9:9ad8%3]) with mapi id 15.20.5566.014; Thu, 25 Aug 2022
 12:34:21 +0000
Message-ID: <4f4292c0-7841-a955-c07c-1eb8f1aa9293@amd.com>
Date: Thu, 25 Aug 2022 18:04:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amdgpu: Handle potential NULL pointer dereference
Content-Language: en-US
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220815153123.138156-1-kent.russell@amd.com>
 <DM5PR12MB1308B61FF812A91CA0FC77EC85729@DM5PR12MB1308.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM5PR12MB1308B61FF812A91CA0FC77EC85729@DM5PR12MB1308.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::10) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81b33a79-3b28-4df5-21af-08da869622d2
X-MS-TrafficTypeDiagnostic: SA1PR12MB6870:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RYks+V2HgsPa1/TsfxmzT/oZ/LL3hiEW9ZxJVtjTjFZHkw8+6PDAvNeChCqfaeRKU/qnZhbXQDFB0s6B8a8pIw8n/+yF0fyTkCGMfetRk+9wohJNKnswAXKQgblHB/Ph4xjGnDBBx2CkKqrpQyTzOYDvzTr2enu+vt+wiSOEgRL97fo3nh7XCCML/9wwtocJasM5bfxqpb00zHG3eOmbQqw/83V9pCvuZySVmsgARIE8AkGnfLNbb+A90Dgw2o8gGHDT4XP6u3Bko8Dq7mcEm4+zJp5iFbgY6GdQHyuSwI863X2tNrqQaE5J1XD/U0VdgapUeMCSylWWtjOr9LBiDRU5u0/sM+PLM0TM9fhpISm9yZjCFJBYEkdNXZNoECnRj941J7lQ30lBH0Lsz5NTirZp1uAlq7XKCkAvhPS2jmb1bsWHKl/m3M57p3pgZsDmXieMYKvOlEpgrR8hIV9fFJmIoTpH74wo/3WaxCOfDAWhnWMWfAtdNJoAJendcOewmB3HcVi2e5OSx4BeyvbIYWuc890bi/cmv/fdC/cgwJ1lcNOz5srz6RvpJnhWyZxFMAryYTSqLxq2QJNxODKXIAr/DSA8nODiFE4bfAEYosMrr0GGqLPIewzAKqvySMILvOdA2lTLQuIm/4wZ0AS0ope+MtDz07npj0jsEu/BxBpV+uacVUHis/rMsZkeRf8k07LLJBy44VI7MyfhXFwOHfwn38xSEO9gmvALiuH6amJiU8taKdxwuJjYsUpC0dBcNxhbh8dL5pCyyHlN5jWztBEBgjlBz5lhYHNo51oC274=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(6512007)(6666004)(26005)(2906002)(36756003)(478600001)(6486002)(110136005)(316002)(41300700001)(53546011)(6506007)(31686004)(2616005)(8676002)(83380400001)(31696002)(4326008)(86362001)(66476007)(66556008)(66946007)(5660300002)(8936002)(186003)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVVzWFVJZEZySnpldkQ2TTVqRC9vT3RyZmRJTjA4ZHV6UCtnYTRYL2dheTZN?=
 =?utf-8?B?Z2V6a3lvRkl2TUhOc2dFYzUrM2ZoNmJXdmk1MnNQVEVYMXQzMjBOcmwzSkJT?=
 =?utf-8?B?YWxGR05Ua3A0MWdJcUJkS1VjVXFjMmVDVWp4TVdXYStNdGg4UVFzU3dra1ZP?=
 =?utf-8?B?YW8xWk1GODRBSXV3ZGEvZjBFY2tmbjl5eU9QRUJqWnFBWWpJOUdvMmVSRm1y?=
 =?utf-8?B?R0dUaGtOeW9sbnhrSWJVc3J0Ynd2ZHVXYjVXdk9UcWlMOGFxc0dDTjNwZFl1?=
 =?utf-8?B?ZlNIYjIrT3JXbm85b2d1Um9Jd3JRS0JOVHVpMXoxdEFyVWJ6SXR5SUhyNm9R?=
 =?utf-8?B?aXlxUmRsbFppSjVFSmplV3FuaFRTRXpQaFhBTFlTZ1lvci94ZGRvUWJ2d1VO?=
 =?utf-8?B?eHFCMjh3NVdRTm1XWXVLMmp1QWkrL2hPd1pZUFd0Z0lwZ1MzWGNuK1pJRTdJ?=
 =?utf-8?B?YVgvV2JlYU9yRmZBNkJxblE5aGZKZ1BPR2NlWXRRdFhjQ0V6RE1PVlZ0S3ZX?=
 =?utf-8?B?ZTNuSnVsMkI5cTVTY1R3ZTFva3QxRGFsdmw3YmYwQTIrY3FhZ3g5c0NiZkw2?=
 =?utf-8?B?ZDBicnFOdVEzNkIzZWRpcDcwdmFybFhJbEJZNG9QRXZPV0hRM3pxbUJUWk03?=
 =?utf-8?B?anNqUHZsN0JYWC9CVXFrL0dsQ2ROU1p3V040K0pkdmRRczRIZWU3eUpmTUx2?=
 =?utf-8?B?bUVYUnJoWjZQbDNwbVNnOHRSbHBLMEJhTi9KbkJiSXJRRzRKc1hwQ0ZzWGIz?=
 =?utf-8?B?aXVmQW9GUFhiWURneG5xcXhwMXJEaTN2SjJRWnRGRDEyb25RYXRHYkIvODc3?=
 =?utf-8?B?K3EzVGlmZTBRL2JnWmhUMnI2RS9OZk10QStXS2NIeUpRa2JUdU5sWUhkUXRU?=
 =?utf-8?B?TGprNTl4dEtLWmJZN2pmZ0t2bTIxT3g3MDhiTWRaVUd5c3JBNTNkL0lJaCtt?=
 =?utf-8?B?UldlcUdMemtqaXlrUnZYa2p3elAyc3ptTGlGZW0rUkh5L09yKzUxT2VQYXlK?=
 =?utf-8?B?bXlMTk1JOWlvZUJuTUdTNmNhelh6bk80cVI0NmhUTGEvV0ZtSTd1eUN0bmhX?=
 =?utf-8?B?TGwxWHh3Z0FjdW9SRTBNUjNKNXFnV1N3NmR2K0lYL3hWSS81aUg3b1EwUUJr?=
 =?utf-8?B?azUycVBiaGhBdlJHc3NYTVI3R21rNHN3Um9aQlVpRjVxVW5XcE5QS05TYy94?=
 =?utf-8?B?MnNuQ2xBVzN6RGtnVHRsSGRYODJSQ3preGREeWtmd0lBZUdCZC9qSnA5RmJm?=
 =?utf-8?B?VGlLYVBpM1ZtdTNLby9oemx4OTNEN3Y2QkdtWWR5WlRlYkRST08yUDBrRVVP?=
 =?utf-8?B?emJobHljd1c3czFzU2lFVWovSCtzWnVYeGhZU09vMjdFeGlybFYyUFV5cWNy?=
 =?utf-8?B?ZFVRd29sMzFHQjZzeThTcnBRckNXMHhnNkJHVEw0aEI4Zk9sYU5tN0VwbnQv?=
 =?utf-8?B?c2M4ZE1vemh0WEFHZWc4OGxkbjA5VlVEK3RBSWpuOHIxYTB2bjlmVGMrUEFT?=
 =?utf-8?B?ZzRzOXhQREd0MFFMOW5XZUIvam13UzVBSmh4TVRvajg4cExheVh2M1d2SUxW?=
 =?utf-8?B?dlcwbDhQSGllZEdWOG05WDlkcjhBeTR4dTI4ajlXQ1M3cmNwcnlLMEFsdDFT?=
 =?utf-8?B?ZlR5MC8wRVMxTTBCaE5LTklJeXNyRzBKQy9CUkZtV2wrN2pqd0VmOHd6MDJq?=
 =?utf-8?B?ZmtLbFNRVkJGMzRLcGlvUUIvQ3A1THpzU25DRmoxcTBFdzdxZ01TMXZTRlh2?=
 =?utf-8?B?OEpHYUtXMFk2VXoweU9aS2ZMU1BmQkpKd0JiVm1XbXI4bU1ZR2JiQjI0cThl?=
 =?utf-8?B?TG40LzRISzFWTE1ZZko4VnNCcHNPemdRRVVOd05qVWFNaDUvRnE5Q2hETVFI?=
 =?utf-8?B?QVNLZjVDSjFpbmc2UXg2VVpERFovV1RRRFY5RStrN3p3RVptOWxvVGRNbnlk?=
 =?utf-8?B?akZmTDJpd0plSytGeDZ0c2pZd211b1dENHdrREFJT1lpSVJGZTg2UFBlZ0F2?=
 =?utf-8?B?K28rdlNhdlpSRWxuME1kUUVuaTJHM2JyRTl6T2MrZVhTczk0SVdxTVRYSWp0?=
 =?utf-8?B?SHg4TW9hd25VMUs2T3JEVHpCcU9obk9qdUk0NlBxV2dsazN2S2p1MitLa1h6?=
 =?utf-8?Q?33wb39EzGbr533d4V2OJIJsK6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b33a79-3b28-4df5-21af-08da869622d2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 12:34:21.7509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0Wgrq/L2jzw0vmpfRShHaw+mkBhkvZLqzS9igDDuk9Q1mdJLJHQvAaELsZedR8N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6870
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
Cc: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/25/2022 5:16 PM, Russell, Kent wrote:
> [AMD Official Use Only - General]
> 
> Friendly ping
> 

Wonder how it goes any further when m is NULL. It should do shortcut 
evaluation and return NOTIFY_DONE, right? Or is this for better readability?

Thanks,
Lijo

>   Kent
> 
> -----Original Message-----
> From: Russell, Kent <Kent.Russell@amd.com>
> Sent: Monday, August 15, 2022 11:31 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Ghannam, Yazen <Yazen.Ghannam@amd.com>; Russell, Kent <Kent.Russell@amd.com>
> Subject: [PATCH] drm/amdgpu: Handle potential NULL pointer dereference
> 
> If m is NULL, we will end up referencing a NULL pointer in the subsequent m elements like extcpu, bank and status. Pull the NULL check out and do it first before referencing m's elements.
> 
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index ab9ba5a9c33d..028495fdfa62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2838,12 +2838,15 @@ static int amdgpu_bad_page_notifier(struct notifier_block *nb,
>   	struct eeprom_table_record err_rec;
>   	uint64_t retired_page;
>   
> +	if (!m)
> +		return NOTIFY_DONE;
> +
>   	/*
>   	 * If the error was generated in UMC_V2, which belongs to GPU UMCs,
>   	 * and error occurred in DramECC (Extended error code = 0) then only
>   	 * process the error, else bail out.
>   	 */
> -	if (!m || !((smca_get_bank_type(m->extcpu, m->bank) == SMCA_UMC_V2) &&
> +	if (!((smca_get_bank_type(m->extcpu, m->bank) == SMCA_UMC_V2) &&
>   		    (XEC(m->status, 0x3f) == 0x0)))
>   		return NOTIFY_DONE;
>   
> --
> 2.25.1
> 
