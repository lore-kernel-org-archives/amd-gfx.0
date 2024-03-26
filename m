Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEF6C6FD1F
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 18:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BFA310F1C6;
	Tue, 26 Mar 2024 18:06:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YucPRgpq";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2106.outbound.protection.outlook.com [40.107.244.106])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7337410F1C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 18:06:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFrGPO/TIwBEKG3ymuyWVLMFz2dDW7jTBNG1BkSoaOu+ereWPjw+5R9/RvQ08+8bT1zv6tW84t1Vbq2G4WVcry0YzLWc5or7z5uBAeO7mKzAelwj1CQTqQnDDR7jYW6ZmBHi8SgZfqf9cyCOHzsSF3FTgFHuo79eO6jp+2tUObdvq9O8drEt0+rPiNA/cdvmPbjORS54eEntguOFz4vHdpPE2rhaH1S1R+1CVADF6eOYFTLKJ/iIRfWyyAXApEIXu6Or9FBpe91Cox7Gc/oyTzgnavDCGY6r27wkkZgJDb3NryZa3jZHAIpFEUx88q6kr0H2AOaZ6r4U04kz2ADa9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaLnlJZllPjbx66b/F/Lt1AqC+l9Ht8iZ6fcXBUtAjE=;
 b=LAr5GJ7+ESqzjibq/w2rG6TZQQX5wHcKRdH95hkfSeMK3wBkHTdgn8vWTCPgNH4a95MXqnburr+sM2hjGJ600YFZZEi95Hr+qUwHhPgx35Z37Ej2A3NIxr9CQKA6f2PoWnJLVTrThTRk7xcH5ldetrYAdK7FEgJk9yl3osTEEQnEiESfVAiNspljiJk1pRQ+TujYeGVDxa0XZ9L+dbsKMCE0dPD/jUM3sh5UoAb3MWAqQJtJoQDCdjNfm/1PzRs7K+ohmeR9PTjR27yU/28DNrZYVSxJ9H+g1EV5LtMa8KHlUwO0F+8ly3GmDzX2G6RgzcQiwI3TdtMPvQOzK1uztQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaLnlJZllPjbx66b/F/Lt1AqC+l9Ht8iZ6fcXBUtAjE=;
 b=YucPRgpqCPpzP4KJWu7AdIv3kTrJdTpFfYk+Zlqs2XwL2BKH3RAd5ij7ccNObXz5xffLGMuuWLZRGWZu30gy/g1tMq1+IWlVkoayngxUc5PobgBMaTro8PvSx8qFZLoB4aPtjUcZWthM/9E2o+2QQp8X84bNxbgYQutSUh4Dyzs=
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 18:06:55 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%7]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 18:06:55 +0000
Message-ID: <d7323c74-f12f-48d5-b1e5-18e6b9a7e3ff@amd.com>
Date: Tue, 26 Mar 2024 14:06:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu : Increase the mes log buffer size as per new
 MES FW version
Content-Language: en-US
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240322164956.167498-1-shaoyun.liu@amd.com>
 <1d3c4b3a-733e-4820-ba8f-0466cb26a45c@amd.com>
 <CH0PR12MB5372C29628094DCF2C51D2BBF4362@CH0PR12MB5372.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <CH0PR12MB5372C29628094DCF2C51D2BBF4362@CH0PR12MB5372.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB4279:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y/D0vzJr8O8OTEaoDoScJFDRKApq18v9t5ExryVyrzWHedMTsyo4DD3GdS2TwgQTAAIZWgG1AkbBJGsjRG3Wj6t0NpCbQzRV/W1KRJt8meCqz/fgjlBQtARHRsGU+YVOBpyhOtG1ZTWr3RchdpWc17qcZtHvEob77ChtLwvAyJd9HdIlPhAe9zs3uhNSuCKZtI39F2NP6Yt/4vN8w4sf7q1MA0x4Q2pNFpIkYFkmxqCw8l4fDhMBai/AcX1uiGdQyvX1r/6hNZYcEGoRqpObPVzX7MCfbSKxVt4UjoYm24GFf5rFmxX6MhsqXtlMMO7+EXpl3pHlnv8GF+89Dum4XpfBSePtcI1sHJy4a0rJiDMQOgkbutP+Lku1YWWsnc9/pl2KAygTwdovLc8vTSChePzXWjeiJpk5CfZ8gaD8zAcRBze2xx3yY4wtmRQmEqG4wwgqyIH+OQWvZq1kjUVQ6hsnjwIAFSVVuwgnRbYw2l0Zmk1rnfhknY8mR7RedworBMOsLmadWXoT0rAdQ+tbWLkLeyM80aLvoZNnWPwKqwS0MJH5iLTLC1T3XI4PgOMIVeOQgy+KYFJyNYIMk+tk2CPQEw8ODthQn9weSEvfd1usSFSZaRGWp4gmYVpK/F9B+Y1xnlnhWkYlTpeBGtTFVdkjtfSlt6U1/zqmtGCsoy0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rzlkay9abWtveVoxcTR4ejFQeFRJMHN1TG9BY3RYYVVhZTJIZUd1ZStHUFNq?=
 =?utf-8?B?N09GWURvdndqMWYvZGpJeVJhaXZFMUo4ZWhycFpkVUkwSDdPM2NWOGRkTVBU?=
 =?utf-8?B?U3NaaThMOGdaY3gwSnFmdHgvYTlpZjFWLzZ5QjZ3bnk5T1pyWGFHV1ZFQ29q?=
 =?utf-8?B?TzU2bElCZllwaEQ2eTgrbnRQM0RRT3BoOWhaMEJibzEvdXY5UmQ3Q2hwQjNW?=
 =?utf-8?B?ZkQ5WkhWdmcwdGpBN3BhQUJLSlorelFKL2U5NmNBUzh3aDdKQ3F2SzlmSlJQ?=
 =?utf-8?B?YTJDWHZQZ29wU0I5Z2VielNwblgxMWJXYWVDQ01yK0dCS2dxWGFQWnN4REpV?=
 =?utf-8?B?aEZVQTdWT2dZQnUrWnlmWUF3b2dhTzNDZHl2RWdVdk1RRmVXWEgzelRyOEZK?=
 =?utf-8?B?SllkYUVQVVVINnM2UnJ1RWdlVTVoaUJJZUZ0L3NsVEJwdUNBRlVad0tQNEJG?=
 =?utf-8?B?QUZ4NjFkWUNiTlFFeVBtVTh6RGZwS3gveE5zOTMyZUltVGhjZmhHS1dSOVR5?=
 =?utf-8?B?eEhhWkZlaCtybE93TUhlSmRnUU1PNmNYamx2aXQvaVdlUGswTzBKKzBRclZZ?=
 =?utf-8?B?SjBNVDcwZVRqbHFlZ1pzSUFMVG1nNWhiSzVVVnhIQ0ZtZlB4eWxXZmxmOHZD?=
 =?utf-8?B?c3g5Nks0TDlveVk4dG1IbGF5c01HUmpOOCtqamZMY0srcmJ3SmdWQmFTcFNX?=
 =?utf-8?B?Y0ZPTXJjTEl4djFaNHB0ZlBIQ0JWbDFEZlhHYUt4QisyWEV5LytHbTdqUko0?=
 =?utf-8?B?S29sdEpDTURDOS9xK3krYVFNTG14WC9WVWR1UHdIVHQ0WHBOQUFlSjBBZjBI?=
 =?utf-8?B?eTBjNEtCTWQvNTRlVFdIT3hCSzFWdGxEM2svakVFSWdJcyt2ZXlBZ2ZpYTdS?=
 =?utf-8?B?RTB2V1BJb0dsY2JIVWNnS1FFTzlOdGFTaE5LQTdoUFNWQ2ZxcEY4dmFBRWRq?=
 =?utf-8?B?OGZ0dDl3SENqdmtvRVVtS3FjWm4yQmlHeElkMVBKZ3Q0MStNSzdmYmdvRmdN?=
 =?utf-8?B?VlRVSWcyNEN6Q3hNdE5HaHJIR1k4VVcxNlNGd0J3dVNON2lQSkZ6cUptMDR5?=
 =?utf-8?B?RFg3ZEt3dVpkV1ZJZU1ZeVlORmM4TVozOWliT1g3MHQvVkZQRytNRitaSHZq?=
 =?utf-8?B?QXkwTFNoM0lTSHBIVGJZdjRQNlptem9yMVlOZzVWdzlvN3paWE1DLzkrYmU3?=
 =?utf-8?B?WFRwUGxRWUg1Ylg4bXA2Y0ZHMyt4SFVMa3Vqc0UwQVVpZXBHVG1ZNU9IcDJx?=
 =?utf-8?B?SWNKN0dNTjZueXNTVS9uUDZWVXYwWDlpeEpjQ0lmcHR4WGVURjRBSkswRktR?=
 =?utf-8?B?NEYwYWJTUC9SeVNDMkhiR2FnSm9pdTNuL0loVzVsTFpwU0hIdXl5OE1EbHcw?=
 =?utf-8?B?WmtkRlFtRnhSbGNCZm9MTVl5QWxNdjNoS3k0TXRFRkZMS0ttMmdPRFNGaHc4?=
 =?utf-8?B?YlJaR1J1MmM5by9ZbU1FamRmeXZoTkVjc0tmV25kQWpkT3ZkM2tkd3pmUUlR?=
 =?utf-8?B?cWJlVVA5T0Y3cnZPeHkyb01xUmY2aVROd3ZjZnZwVTU1MitHektNYnhMRzU1?=
 =?utf-8?B?ZldCbE9ta3BLR1NVb1YzWWZyVzh2Y09nOENrUUhqWW5mdVlCcnhnNUVMRHE5?=
 =?utf-8?B?aVRpbGl4NzJoSUpwWnh3UFVMTEJxK1Q5RHY1ZFlCeFZ5eGt6emEyUkRTd1J0?=
 =?utf-8?B?TEdWMkk0TmovaDc2OHBybnREYWFReFlPQ1NqQWhhU3BDOWhwdWpGM0dzQ0RU?=
 =?utf-8?B?MldoL3JCTXkxdENJQjB6YmlZd2w3TmxTaVY4L3V3Zi9jS3lMU0xmbms0OWIr?=
 =?utf-8?B?WVNzYWFiaVBoVmV4YUZDVFBxenc1NDhjSlRmdnBKOEFKaDByRmNwdC91OThS?=
 =?utf-8?B?RDJVc2ZJSHREdVVCYndKODcxME81a3Q2Z0FXaWZDV2d1MTVaYjczYUtFM3k0?=
 =?utf-8?B?eEV6Z3lTVy93OTdHUmVMcDFVdjdKOEVLamxjOU1OVDNBR25xRlZRQytnQ2ls?=
 =?utf-8?B?MUNsNUZHSlpXRysvaTlDR2dSTEVlc055WWZkcmIrd0U0M2ZqRnFQYnI0WVNP?=
 =?utf-8?B?MEExcmRUd045RG5EV2poY0xubE9BWGZFQ0JYL1lCQ2tjOTFBNFBMRlo5ck1K?=
 =?utf-8?Q?aaoUR3LdBHLZeiaMiSpD4+x+N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5ee190-6eba-439d-b624-08dc4dbf8577
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 18:06:55.5339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFzXgvpvf/ArQOXoYRIzdvlxRyG0wOnsvrRdc8q57ftYC1RGuHnYL0Ajgc/MVtFPmiwuCR181xYFWP13WL0rHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279
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


On 2024-03-25 19:33, Liu, Shaoyun wrote:
> [AMD Official Use Only - General]
>
> It can  cause page fault  when the  log size exceed the  page size .

I'd consider that a breaking change in the firmware that should be 
avoided. Is there a way the updated driver can tell the FW the log size 
that it allocated, so that old drivers continue to work with new firmware?

Regards,
   Felix


>
> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Monday, March 25, 2024 2:58 PM
> To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu : Increase the mes log buffer size as per new MES FW version
>
>
> On 2024-03-22 12:49, shaoyunl wrote:
>>   From MES version 0x54, the log entry increased and require the log
>> buffer size to be increased. The 16k is maximum size agreed
> What happens when you run the new firmware on an old kernel that only allocates 4KB?
>
> Regards,
>     Felix
>
>
>> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 5 ++---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 1 +
>>    2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> index 9ace848e174c..78e4f88f5134 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> @@ -103,7 +103,7 @@ static int amdgpu_mes_event_log_init(struct amdgpu_device *adev)
>>        if (!amdgpu_mes_log_enable)
>>                return 0;
>>
>> -     r = amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
>> +     r = amdgpu_bo_create_kernel(adev, AMDGPU_MES_LOG_BUFFER_SIZE,
>> +PAGE_SIZE,
>>                                    AMDGPU_GEM_DOMAIN_GTT,
>>                                    &adev->mes.event_log_gpu_obj,
>>                                    &adev->mes.event_log_gpu_addr, @@ -1548,12 +1548,11 @@
>> static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
>>        uint32_t *mem = (uint32_t *)(adev->mes.event_log_cpu_addr);
>>
>>        seq_hex_dump(m, "", DUMP_PREFIX_OFFSET, 32, 4,
>> -                  mem, PAGE_SIZE, false);
>> +                  mem, AMDGPU_MES_LOG_BUFFER_SIZE, false);
>>
>>        return 0;
>>    }
>>
>> -
>>    DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_mes_event_log);
>>
>>    #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> index 7d4f93fea937..4c8fc3117ef8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> @@ -52,6 +52,7 @@ enum amdgpu_mes_priority_level {
>>
>>    #define AMDGPU_MES_PROC_CTX_SIZE 0x1000 /* one page area */
>>    #define AMDGPU_MES_GANG_CTX_SIZE 0x1000 /* one page area */
>> +#define AMDGPU_MES_LOG_BUFFER_SIZE 0x4000 /* Maximu log buffer size
>> +for MES */
>>
>>    struct amdgpu_mes_funcs;
>>
