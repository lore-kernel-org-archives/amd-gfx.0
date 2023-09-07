Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1938EEE14D4
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Sep 2023 05:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49C2210E756;
	Thu,  7 Sep 2023 05:13:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::603])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BF2210E756
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Sep 2023 05:13:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCw4Qseo4vUdArqjBuwDNUcMel/Yme8N+4121Bk96yoJFodTOJ5+ulzw4cLR5fTKuMe2QfbKX/Oe8UucuZW8vUeo1xKOKvFOt17ca4CwXHlhPmrwvzbiQj6Xefttvq3CTIs9MMNV/yd2kHd1vP82vvOJO5TC407Tuud9cJo7i5meQHzjNhyavDVUJZvX9eZ7QRkPh6B5uH/j8bNomJY9ETFQPJoim//AdKZKyvKQXnYxPeMvXixNwV/XMYqNsfCJCIFlGchQ+LGoD7h1CtxE5C7p39jKcTIveDqktowkXvVFS6jV2EiYQFOFd7pmLC9TG/dEmOuBW3D7Mq+/5L+JdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNtyrjcK3GiBVvlvSDLyilmI+YSj6UBvB1SSIwnkgEQ=;
 b=aI1BR6iMKzer4uGHRnTYyTOlfK/crN+nXm9zfUkI1UbT4hcQaVoNPuHXLAU8hi9wjcS/+P4CwUqJniyg4yL+5/Nlcv+GXtwHzRCYKcWuF9ijq0Akwkg38XxKdmOJX90hY9jPx5ERMNUgaGJIixr1W8rZaawUm7QHC4cJZmBnQBSqFX6elqRDjyxn/bizwNB3GlGcUpkxrFVT53CED7T6xSPQex+YwcqTIXYN067helj10O+TKuRtSOQTZdqrWuRM1Fd2upv8/kthnQNIM3lLI6VWYZT8kWqgj3PNpJE8qnZSvTy7ZCWibNJN0DIXwrWSW770tDkHwNE6PLQ+PLC8ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNtyrjcK3GiBVvlvSDLyilmI+YSj6UBvB1SSIwnkgEQ=;
 b=4/jnMSqx89r6JhLdW9p+gXTkPTQsFCINwWkuXgqDBPUM4zgOp7EzBVDohCpBeruebV+EoSmr1Y7oKu/T1+6Fei1R41i2l/fXZvlXJc3nDfql7H2xmEtVipf56PPA2o3/vjz5DSiEre98G0+rRmloxK0OtGKXKjVCNDTQYurEEl8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 05:13:49 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0%5]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 05:13:49 +0000
Message-ID: <082a8ea1-a3d5-5983-0ae2-85fa633ad3de@amd.com>
Date: Thu, 7 Sep 2023 10:43:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCHv3] drm/amdkfd: Fix unaligned 64-bit doorbell warning
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230906153907.216159-1-mukul.joshi@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230906153907.216159-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::10) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: e6bdcc61-3649-4e65-9701-08dbaf6137b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X9WcAMBY18UBq/ladC1sdIaqCApRc3gJ1yDUEZbh1+oxS3sXluxoAvbXacJ3qp4VXgOSXCWmCzb0dT4u02aQYarnnz9D8/+81ZxuxVkzvMHw05XxZ1TDiDKRiPP+3ybR+crQztNM9qh+HiDabuEqGFTx+seRp6ZDRVp02CrXnaRWZcldeaC1LTZkNYDZ08mh9vjT+WjHlAlEfHEMWA+kspuf1u8RGn6o1jTKPpONH2oNcNSId1iwZGYwByHoDcXe0pUE1dMURyP5wejiGcuW6fdC3wwQkDhwZrI53L8AdufUcFA2FYkjcf8g1/Rj7672uDyhKSrcL6bRgax1gG1wN92In1YIAZLnH3TtWYd7US+xfdDB1vqkFneSBNWb6JvFXtg1fWXjzkVFGkXO8dZEPbFRoq3nevYboQzo7/W318oH0o2B1ZJePpBbXKVSkUs3skX29MZytVLCJwyxfkxTrVSyYiyAZ4pEnb95OVRHPPF8waLk0Pl8rk3r56E+3ygWlyteIrF5Q4i02T0lOv/tNFRZtazUtQ6C8Fhw+f6Eck5VCZkI444sjGs4golN40alF9pel3lLKxtuQq2THpaSGVPOG+iDXwKGzDjossxpVBJqS56R9A2IMtB4wu68PdFCee/E1Nkb+oRrZnIeruEt4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(1800799009)(451199024)(186009)(53546011)(6506007)(6486002)(6666004)(6512007)(2616005)(83380400001)(26005)(2906002)(66476007)(41300700001)(66556008)(4326008)(8676002)(66946007)(5660300002)(478600001)(8936002)(86362001)(31696002)(36756003)(38100700002)(316002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE1BMlFsSnFiTGpEc0ZaeVBoRlVscDJjdDlUMEtBdFFib3Y4M3ZYSmtqK1dn?=
 =?utf-8?B?ZW5hVEc4YnZFMWdDSW1wMkxwdzQ4Q0FHdWdlWmFZWTV5c0VoMGdocXBONlhy?=
 =?utf-8?B?ZHdNL3FOUVNMcng0TG4veldWcEZLZzdLL2xYMHBuN1V6K1cybkwzK29la0Q4?=
 =?utf-8?B?VU9aSldNRWJ6RGFSWUlyZzZXMXJUT2JTaXV0RXJxUkJKSi9RL2dmaWR5WURK?=
 =?utf-8?B?UUdBdFJwZG1FaXgwL0JkbzlXaEV6Vkc2NzdBK3lSbnVZUkgyR0RXSDRUT01F?=
 =?utf-8?B?UnlSY296K3dZbnB5SXdrNFFWbVJDTHpra01aQWhTaFFtU29OckI5N0NkcWVr?=
 =?utf-8?B?U3crRVB4MVd3Ni8wR2lZRTdoOURUWTZodTFrR2ExSnlsaVR4OEhtdkthNkVv?=
 =?utf-8?B?Tm1CUVJlSkpQdUtTOFZUNVdNbUtzUWg4OUV6NTVmSiszNTZDcVlzTEZETlJu?=
 =?utf-8?B?Vi9qRTRaZ09BeHJXN0J1Rkp3SVdNZDhYSnlKT3hqc1ZJQWVGWWpyMHR6Mmgy?=
 =?utf-8?B?NjRlKyt0YVVvWWlFZ00vZFh5RHRWbVZITm5zVHNobWVuY09MSTM5RmNEam0y?=
 =?utf-8?B?dzB3eDNXc0VMOEVwTkFIVjJKc3I4empQaklEVTJQUkNUT1JRUWRicW1wYnY3?=
 =?utf-8?B?RXdRQ2FyU0lOdUNoNjBMRkRtOUp3MDYvekJqZXBiWnFvMzFWWEoyM1BPc3Rp?=
 =?utf-8?B?VWlveVJ2ZGZXeTIwRWh2SVh6UVFpSXBSQmJRRFdvRStSZTJlY2YzWERTZktE?=
 =?utf-8?B?WHlqdmRkMmlMR1hURTVTdERZUnpwZnhCakY5T3QycG1PMEw0bGx5SnhqN3lU?=
 =?utf-8?B?anRjTVFmcmdBVnBhOHh6Si9nWGkxWlVaMGVDQXJ2U1BON2YxNm1ITGNRYjg5?=
 =?utf-8?B?S1g2NVJGLzU5alNsL0pjNWNrQXdiQkFCUE5DUEFVb010eUdQSnQrWnVLRjZm?=
 =?utf-8?B?eGFQZ29oRXlRY2lKMThVcnpQZmtkZzRhd1Q5Q1JPNTByajFiUG9uamh0VVA5?=
 =?utf-8?B?cTZKWlkzREZBbEVBdHZwZE5MZGNKNThQQlZuT2JHMWhpSHEvOVkrK25hc0xM?=
 =?utf-8?B?RjRpaENsaTk2c09uaDBIdFpYK1ByYllkaEt2WVM5WU52TUoyYWd3aVNCOFAv?=
 =?utf-8?B?UjBVMGhXbGczMjhsOXNCcGpZeHltNHdpeFlsaGZsWFE4QXlyQkxQWHJ3c1p1?=
 =?utf-8?B?SXRxWW0rcDArYjBaU3JMMDRDYmdZeFBYSm8wMGl5cnNib21rcDE1U0IrZjMw?=
 =?utf-8?B?QnJmL2FxR0dXbGJCTHBpdGJoaWlJMTRWTVdHemIxa3ZvSCtONHVrbi9YVTNG?=
 =?utf-8?B?dzZ4Z2dtZEtsK3phWlJVRmlGVTd1dHlpelIyTjdyeERpelpiV0J2MVZqQk9L?=
 =?utf-8?B?NHQvQmdwc3pGcTBIZkFKakdCUnhPSExCTGVINm9xUUpQYTFtRnhuUzBKVUNI?=
 =?utf-8?B?bXdPVXduWGkzdnBvNTlxZFFuQ2RHSjNNWXZrYmp0U2pNeVNESlFMSUpZSVhl?=
 =?utf-8?B?ZHJrMFRMQWZUejlmd0hkaUV6cWRKZXhuNDZNTVp3QXN2T25ndEsrK2t6QS8x?=
 =?utf-8?B?ZmVXOEt2bG90VTlFZ01xeVQyaWI5K09TV0k3V3lUTUpwUTdCUmtQQVc0QzJj?=
 =?utf-8?B?eEZPa2oxK0hmc3dlT3MwL1lxSFJVWUNETkJzWWY2VkREVXF6TDRuN1d2NlJz?=
 =?utf-8?B?a2t1U2I2THlvRE1kd0s4eHIzQ0RBODFwdlE3UlBCdkVZZFg0eU1CT2Y2WUY0?=
 =?utf-8?B?L0w1Q2lVVjNlUDQ4ZnpHcnArNU50SUZGQTZKTHlsUGNiOENRVzB4TVFPZG9O?=
 =?utf-8?B?MkpnTzIvcXlvTitKNGRMTHJKYzRkRzZkRVMvMHZwZEZRTTFtR0tybFpHZTBn?=
 =?utf-8?B?RHV0OVFCVnNXeEIzQkxuWURNSndGUllvV0pySFQwdzJlVzNPQTc2ZVNVUUtm?=
 =?utf-8?B?azg1TmU5VHIvWUNwY05YdUMvTVZQUjFiTURhdmJRNGpPYlpib2U3TU5TMk1o?=
 =?utf-8?B?WUY4bkRzWG5ucnZFTm1GZEkzN01mTS9icWFxcFpvZ2p4TFVqVjhtTjREUFpi?=
 =?utf-8?B?K3R4VGJ1RzFnL1EwZlI2OTlsbS96cFprTitnbnViTUpjNDJiVC9LRHRWUmFp?=
 =?utf-8?Q?dDrdzo0NmvrWo+OrSTVocqiyc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bdcc61-3649-4e65-9701-08dbaf6137b7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 05:13:49.1982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jy1JD5XHMLq8Kn948E2fG13ZBYa3gmOQYZScLJFMBQcpkB3k6VHt8SFcmY0JhuCN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315
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
Cc: felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/6/2023 9:09 PM, Mukul Joshi wrote:
> This patch fixes the following unaligned 64-bit doorbell
> warning seen when submitting packets on HIQ on GFX v9.4.3
> by making the HIQ doorbell 64-bit aligned.
> The warning is seen when GPU is loaded in any mode other
> than SPX mode.
> 
> [  +0.000301] ------------[ cut here ]------------
> [  +0.000003] Unaligned 64-bit doorbell
> [  +0.000030] WARNING: /amdkfd/kfd_doorbell.c:339 write_kernel_doorbell64+0x72/0x80
> [  +0.000003] RIP: 0010:write_kernel_doorbell64+0x72/0x80
> [  +0.000004] RSP: 0018:ffffc90004287730 EFLAGS: 00010246
> [  +0.000005] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [  +0.000003] RDX: 0000000000000001 RSI: ffffffff82837c71 RDI: 00000000ffffffff
> [  +0.000003] RBP: ffffc90004287748 R08: 0000000000000003 R09: 0000000000000001
> [  +0.000002] R10: 000000000000001a R11: ffff88a034008198 R12: ffffc900013bd004
> [  +0.000003] R13: 0000000000000008 R14: ffffc900042877b0 R15: 000000000000007f
> [  +0.000003] FS:  00007fa8c7b62000(0000) GS:ffff889f88400000(0000) knlGS:0000000000000000
> [  +0.000004] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000003] CR2: 000056111c45aaf0 CR3: 00000001414f2002 CR4: 0000000000770ee0
> [  +0.000003] PKRU: 55555554
> [  +0.000002] Call Trace:
> [  +0.000004]  <TASK>
> [  +0.000006]  kq_submit_packet+0x45/0x50 [amdgpu]
> [  +0.000524]  pm_send_set_resources+0x7f/0xc0 [amdgpu]
> [  +0.000500]  set_sched_resources+0xe4/0x160 [amdgpu]
> [  +0.000503]  start_cpsch+0x1c5/0x2a0 [amdgpu]
> [  +0.000497]  kgd2kfd_device_init.cold+0x816/0xb42 [amdgpu]
> [  +0.000743]  amdgpu_amdkfd_device_init+0x15f/0x1f0 [amdgpu]
> [  +0.000602]  amdgpu_device_init.cold+0x1813/0x2176 [amdgpu]
> [  +0.000684]  ? pci_bus_read_config_word+0x4a/0x80
> [  +0.000012]  ? do_pci_enable_device+0xdc/0x110
> [  +0.000008]  amdgpu_driver_load_kms+0x1a/0x110 [amdgpu]
> [  +0.000545]  amdgpu_pci_probe+0x197/0x400 [amdgpu]
> 
> Fixes: cfeaeb3c0ce7 ("drm/amdgpu: use doorbell mgr for kfd kernel doorbells")
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
> v1->v2:
> - Update the logic to make it work with both 32 bit
>    64 bit doorbells.
> - Add the Fixed tag
> v2->v3:
> - Revert to the original change to align it with whats done in
>    amdgpu_doorbell_index_on_bar.
> 
>   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> index c2e0b79dcc6d..7b38537c7c99 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -162,6 +162,7 @@ void __iomem *kfd_get_kernel_doorbell(struct kfd_dev *kfd,
>   		return NULL;
>   
>   	*doorbell_off = amdgpu_doorbell_index_on_bar(kfd->adev, kfd->doorbells, inx);
> +	inx *= 2;

To be more clear, suggest to use a macro here and at 
amdgpu_doorbell_index_on_bar() -
DOORBELL_INDX2ABS()/DOORBELL_ABS2INDX()

Thanks,
Lijo

>   
>   	pr_debug("Get kernel queue doorbell\n"
>   			"     doorbell offset   == 0x%08X\n"
> @@ -176,6 +177,7 @@ void kfd_release_kernel_doorbell(struct kfd_dev *kfd, u32 __iomem *db_addr)
>   	unsigned int inx;
>   
>   	inx = (unsigned int)(db_addr - kfd->doorbell_kernel_ptr);
> +	inx /= 2;
>   
>   	mutex_lock(&kfd->doorbell_mutex);
>   	__clear_bit(inx, kfd->doorbell_bitmap);
