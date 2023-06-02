Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0417C7EE24
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 11:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2878910E670;
	Fri,  2 Jun 2023 11:57:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5735E10E670
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 11:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfN/6Ad57QZ9IsPHshOlgjdrD8eRHNi7gFYxBZnJREDuWv9OrSQs/JgSCyxwzLCyQACawKwVPpoXAt5P/qna8uNLwvgq3jV5e2pkuK9iVOb2sE3PoebNt/V+9Nprjdx0EkxIL1IHfleMSJhB06YsjldKraGVRi2dvsIH3zyzDncQv1chXvZwFQi0INIA044cydcE0lo5RiawbMgLNzWgo0ISgkjylMaUHp/UWgGJthYqcYlo15n5HMkwUV0oPaLFdNoV5HCCRo8tQ0PjtlOR3cj8Sgi+diawKlOOKYyuEE5PCx8UF9JNRq7pGnIZDSf5UhTX4NEFv6iK/CoNSK4/iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPsmrY4uzikFlDlPgHPusjXaMZQuGurs4OppP0Bq6Eo=;
 b=fQITd6L6v1ASpXqk4aNsxE4df8/bLs3BFXg/JSE5+mGAyq14+y4nQcPfTgjlqtxHS6xAJRPiX8IZAFDRZobFh268jdN9a5qlexBunoA2deJ449iqWXkPxj42GzNRnyE4sHooNF9jrZDyZdaQ/EkCgr6gO4+GXEvP/KnfZC34UWWfyI8G6Pog9tdIT2bIAjSte6E0EW0+YoInfv0IRC/ac7ZVi7Ble+l+m4inQW6NekmK4zE73/vK9oUSiH2v+/If48QmpFANGvOvfZ+KnUOJQX6F0b/w6Mi6pP67D9KKLmaCFianPKwdIO5cPbqUH+vl/2dl7dCgv3/nvk87TsN3iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPsmrY4uzikFlDlPgHPusjXaMZQuGurs4OppP0Bq6Eo=;
 b=xrUw0BmaeeJeAf7zuzHU97/e2BYXL5Pz7ASanZiBnxw3/SAxezOpi3j6dp+9pdA4fVm084NyxOsNsr2LF86lJPQc4Ca6ZPzSd8D1ASBuC7KM+/JCB85MzHnaJLJ9ZOOmph4+mVN3KDwkRRietAZgMt2Xbos282X99xT51xZkW2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 11:57:39 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::907f:26e2:673a:2ad2]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::907f:26e2:673a:2ad2%6]) with mapi id 15.20.6455.024; Fri, 2 Jun 2023
 11:57:39 +0000
Message-ID: <90a3ac90-4091-4542-89c2-778230d265a5@amd.com>
Date: Fri, 2 Jun 2023 13:57:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] drm/amdkfd: Signal page table fence after KFD flush
 tlb
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>,
 "Sharma, Shashank" <Shashank.Sharma@amd.com>
References: <20230601193117.13143-1-Philip.Yang@amd.com>
 <20230601193117.13143-3-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230601193117.13143-3-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0259.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BY5PR12MB4066:EE_
X-MS-Office365-Filtering-Correlation-Id: 927d1502-de85-40e0-d6ab-08db6360906a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JIFep9ua3fuZBRNVd3hCxxs1SrcDFWq9hcT43gdYygF2MaGxTV6QcC1lHM8qO2h9Gqqbz4qampCyu64Nj+hbFkes++d+VyT2Q6jZmvW7m9nsPLoEk82qEzOzTTeyhdQJQx11kHuDLej1PBEuLN4frigSK20o/+TRp2xcgSySkivTqvU3FIhBA3r/8/KmGuuAkCaDohrCdd+85rShBc56lPEwwNzKVDS4rYO99AA/zD5+mumAXUYH+EDsqYMbP60c9GtQbF6MlJ9SMfmRraycEOpGscPxP8honnx+6hQX4OcVRjNzaYUEjj1YHDZlt7JM6U8pmq+VnucHv1PprRn7j7rFGnbkan20VNhLv88d/hG8rBmbdQR76k/nSqgefkypJs8lyHG7sfQL6OjeUY2yFw2Lk7DDAHrNkWMKbtkZloL0OqfAi0G/ZIf899Tt1VClhKVw4NlhiCYeGqcgeVcClc0kGspAUfgtebgA7Xa/4j4S5+jke8ihK4inccCl0Kt9OnErB5HRXxZP+Rp1qD5JwjOYt1Lljd32NwGSwC4BcTmcdyXVDtmeSGyBrOV+9nYYC2DEjuLLLz5hxj8ZI2tGqHR/oWhdX0TQlgBPGdMmJxkq6V3bQZM9/P+PxoioHFGknGgmozEhh4xYKE8fh45EWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(451199021)(6486002)(6666004)(36756003)(2616005)(38100700002)(31696002)(86362001)(6506007)(6512007)(186003)(8676002)(110136005)(2906002)(8936002)(5660300002)(41300700001)(316002)(31686004)(66476007)(6636002)(4326008)(66946007)(66556008)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjdPaXBIYTR1TE94RTNXSGZseHNEbHMzTHVXWmdWMjJLZGJOM1BndkRuR25M?=
 =?utf-8?B?bWdDRlBVQisveDBRUmNnOTBoYXkyUGpsRVRVQldLNXE1MXEzSzJsWDJFUkxD?=
 =?utf-8?B?cUdYckhTMTlNVkFMTElUaHJ5UFhQbHY5bVNjSlhZaUw0alFqb1dZQml4RWVj?=
 =?utf-8?B?d1ZURzNlN0NCZHRHenI0TE0wRXJ1RklwbHp0VFFiYm51TGhrK2ttamJSUFNu?=
 =?utf-8?B?bGZmNUdWZWMySjQ4WURQTXZLWEVSYTcwMVJlN1Q0UVE3L1V3UXNFQUdFUisr?=
 =?utf-8?B?aWxwd2VzM2pza250OVo1NVdLT3lJWHhkTFo1M2NZOHJOdFc1QVZJQk5ReDRn?=
 =?utf-8?B?Mlc2K3RyMTQyUncreWx3ZmtlSGVrZ1Q4YXpicVRLd3crc0hnT3h1L3BpeGh6?=
 =?utf-8?B?YzB5aFVad1U3SWxTQ3pjcnJzQzZnSndYbzNUMDNhNFdFWmRoL0dCbCthVjF3?=
 =?utf-8?B?QjlBS3NQenBnd3RJRzNIbSsvbWRPNUpqV2NQM3FjemYzMU95WXNIamorU3hp?=
 =?utf-8?B?K2wwOXhJRVROQktuT2JTMloxSURjSEFLVkEybTdWeXlJU1pkZSs3dG14cW9U?=
 =?utf-8?B?THJicU84ajhzOUU5L3N5ZWZZbmg3NUVBZ1p6T0RVUHdxZlpSeDh0MUpzaEZY?=
 =?utf-8?B?KytJT253cFRoTFVFSWFweHlKaDFxK3pLZDlzN3B6QVRqd1h2WHY1cWRRb1R0?=
 =?utf-8?B?cGpHSDJrcCtFRFZVUUpaOG5EakViMlZTWWFuUlM5MDZwNDBCN2ZmcTM0VFlY?=
 =?utf-8?B?aGg1NHN5SjZTQS9udU9ZUjgvazNUZWRBVXZzOU96WE5OMjk0OHBwRkU2M0Rj?=
 =?utf-8?B?bW5abEhzQUNQZnFVc0thVmJwMkxFRVBtcDVlbWxsQ1c2Mno3blBlNHZ4NjhU?=
 =?utf-8?B?ZkZQak1PdUNFRG9CVzJpamNLQzJiRVlneVRUT1N1Y3J1VC9sMldLb29NNjkv?=
 =?utf-8?B?VE5VVlhvUkk4MUlIaGRoQUtscnNkUmtBeGFERFJnQlgwM3F1TVJRVEM0VDJz?=
 =?utf-8?B?dFhsT1BOcFp1Ukp3MnVvQ2ZsUE4rc3oyODY3Ky9TbE1hUk5LUzFYT2g2c0hN?=
 =?utf-8?B?MUJhc1R4WVZjWWpiZ0prSHVNbHErN2Ixek9UN0ZxcTl3NHZsc2gvWURjcmFX?=
 =?utf-8?B?UjBGUm5QclFPcGNCUHpOSEc3YXpVQzhpQ0FuZ3pMUmhXZlB2UVBuVEFZNk83?=
 =?utf-8?B?Sm43YklRZ3NndjJJQjlPWGZkeW1RK2dIWEw3cXVwMzhXMWZiU0Z1YjJuMHFa?=
 =?utf-8?B?RXlpZ3ZXZldiL3RDcHVSODNZeHovTjNITDMvaXdjNUxZT29tRThFUkdvL2JB?=
 =?utf-8?B?RlRTTTNmL0NYa2J3a3RQMkY0TlM1WlUwZTcyZjVEenZkdWxuVHZEbnI3dVgr?=
 =?utf-8?B?bDVGVDd0QXdHSTNDWmZqcFZUcnp2bnVYK2VhVlRuaFBBbjZGNmw0R2Z3b00z?=
 =?utf-8?B?YXFGYWlhYURhSk1yckROalY0NGJ5UkMrVm1PYnhyZ3RVcFlrcXRXN1dvZ21z?=
 =?utf-8?B?RGt0R0V0dTEyWThyTTBLMGZKV2EvaTY4bFVtS21BTEdkSG1hNGJTeFhKbDFi?=
 =?utf-8?B?OTQyOElrMjMwaW1FT0duNit4Y1gvTDBRRDdaRVlPWDY1NHVVMi9PYVBYcjU2?=
 =?utf-8?B?ZmltbWVUOE5VeS9yYzJsZmVSc3poUGlsN1gzSjgyRTVTcy9ubFErTGROdHIv?=
 =?utf-8?B?Qi9kaVRYQjdzNWNsSVJnUU5mcENxb2FoUWU3dmRTNjU5SjJnYWNSZGpxTWZI?=
 =?utf-8?B?ZkVBa0RzOTF2R0prcnhGalkvSkprU1pBS1NER2l6YjhUd2VEcGxFanpVYlhl?=
 =?utf-8?B?dlFVYTJaWVdEajdjdnh6ZGRMZVMzZzdNSnJWd0pIYUJMOHptOE01R1FId3Z3?=
 =?utf-8?B?OHBkc09lWTZ5RDNDUmVyZVRnaEZ5eTJZTnlEOE1uUTl1VnRKUkxKb1dTcmFw?=
 =?utf-8?B?OERWT1NSRWtHOStpK1Exa0NHMHlVaCtkd2VZY2Y5QXFCWGFqdHphdzRMS0lV?=
 =?utf-8?B?Um80QVd3SVpXajNMdjRKeXRQQTkyczhYcnBNeW9OdHNLcTR4V1JSQi94ZW4z?=
 =?utf-8?B?a09Zajk3YTNoa2hwb0ZuNEhlWWNXUG1lanBSYlhmaUU5anhpREZUcHM1Z1JD?=
 =?utf-8?B?Qnp2RlhxYmNRUHM2eUdsTDJrRlVXQTgwRDhGVnc4U1E2YjI0YTR6eXh0WXMx?=
 =?utf-8?Q?rFRFt7MbHFcRlWbBjRlx8VHdoyW7M9B3Q6gxzvshO0Qm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927d1502-de85-40e0-d6ab-08db6360906a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 11:57:39.6407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZA0StO4iNtxWivKxIq1r6AWK35dY3c6faNW05bpgBNScG0LgBuPhiWIUxyvDDdd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 01.06.23 um 21:31 schrieb Philip Yang:
> To free page table BOs which are freed when updating page table, for
> example PTE BOs when PDE0 used as PTE.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index af0a4b5257cc..0ff007a74d03 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -2101,6 +2101,11 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
>   			amdgpu_amdkfd_flush_gpu_tlb_pasid(
>   				dev->adev, pdd->process->pasid, type, xcc);
>   	}
> +
> +	/* Signal page table fence to free page table BOs */
> +	dma_fence_signal(vm->pt_fence);

That's not something you can do here.

Signaling a fence can never depend on anything except for hardware work. 
In other words dma_fence_signal() is supposed to be called only from 
interrupt context!

What we can to is to put the TLB flushing into an irq worker or work 
item and let the signaling happen from there.

Amar and Shashank are already working on this, I strongly suggest to 
sync up with them.

Regards,
Christian.

> +	dma_fence_put(vm->pt_fence);
> +	vm->pt_fence = amdgpu_pt_fence_create();
>   }
>   
>   struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process *p, uint32_t gpu_id)

