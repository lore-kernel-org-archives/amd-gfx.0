Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803B5C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Nov 2022 01:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D077910E4CC;
	Wed, 23 Nov 2022 01:45:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5677910E4C7
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Nov 2022 01:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkiKtpiIo8zvhjp4WZkhuADE8DVHLgrdhTFIfA9Xcxt0QOb717LGbxhrA3w1jOGgnJbvhyBjy0W/e6RfrXqU165Du61WsP45v8m3aP1TGtCNDacIvRH8p1ExBVhOaNhnYMynqtDafidzClfvAcI7QvGgLjO84ZDpwTNU3tAaekqkgV8sex5GC8dtFqgVsAa5FZ78o80f9Zn4bRBggDUELlk+EdU61fdlm5VqjYkUUpTJAUpAJhoT97xc4O5x3HcoEa7CuOIqSLqwp+Z6IMb1aAzNJew1xAMlE2J7HR7DV/j84fKBwfOqrjxTrtqdNQd0yxFUkBUv8Wy1b+TFB2JJuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnU4+uY4hwGiiOSku69ZB2PG2ybUOo8xJhhSzfODykg=;
 b=QfviIM9IEfUSPHIGpAxIGrYerA+u2SjUV7tmSwdXhMpLvb4dQ3W4PPsbwgaGzWIuhDW71NyPaqrdVCQWGzLV/tyE3QLmB2UkouFkZECCbMLoDxFAeGjZT20dccnH9+X9XeuZ6bgjt8Xg+UGsRo6hI+xEkCcb9pQRlahpMtosEetP0T5k2rZG7Z6T7E2hL1vm79uX/1PpP/hYoPCJEmpeXrUasUtOYZ15/t+9z5SMNcTeFv3A1oK+94QqKWiRT4SZ+htv3UVdTxYgLy+PDCEE6ZSMwugXtHveHpF67GdWU/FwjzdbNrNZz2ivaSi+M+XAP3xklNW7u5ss2u50k4jm5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnU4+uY4hwGiiOSku69ZB2PG2ybUOo8xJhhSzfODykg=;
 b=QrwdWiv26Y0UgHg6PLhnWGq07+uyIJaK4IM8XeGvZ5aryh6j1wYbL98JSfOxzuXuis4YjB0Vn7XzUh0MB3nUwp5HHui1ya4xKjy2pwYysNDI+5iG1cr3ug0n0Y51/NdKSwgcyySfA6H44qJgeHvcKXbSNnPB0nT3ahSOMIRWVSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 01:44:53 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 01:44:53 +0000
Message-ID: <31f90d88-1db5-756f-02f7-456f721e9899@amd.com>
Date: Tue, 22 Nov 2022 19:44:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 17/29] drm/amdkfd: Add debug trap enabled flag to TMA
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221031162359.445805-1-jonathan.kim@amd.com>
 <20221031162359.445805-17-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221031162359.445805-17-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0004.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e315a6-7bc0-4434-7d61-08daccf450fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z4EXfUGifUZzBVTL4Nu2KOtbNS3ybRGiL2vB87wd+EONpqyoweVUt8N+VzAiQn4gGGC7p9OR7n6Kw0SPaue7VK+gPDUgB3jqX55hXTrN0k6bP2S1P7iu0gLuqbP115Cd3RlxOi73YZYC89NmL1JKZbdSgHK2ZCdwpMlINa8UuM3dIsyIVk8obf79D6pOeFbsaCqxX7xZ4nTkUmKFC/tL5kyrvkatlvZaolwgez5jipLKSOwRnxeBA/JnADOe+1IAuwBUA66B4J7kfe/HWd6YAkD9qD0Zs60DGVFZ61a9L0MNJY+tYTAmOunPzDkxfHGcIUOkpSyfVAj3f5FtyfrYmkAcM/+XxZ7gvmeBie07ldkGWruah1GOc3Ekhwdv8fX/8NDXfHD7mIWgC8MkwFhmOAP7A3o6vkOW2EDAGjOBjeR2auiEUyYFAX+r0Q+CefP8fJZplQ+DiPbBS++gE3MhlA4Irp7ywKvoKsBqwSQ8pfibq6bQPFwXiJrbdxgAtlDjU2FKAHLT/+jThG9/YxxvHYlm7WILCyJSKNnnC/1KdVMhe6QOUBCvPIOyNVBSxHkVzmcJKxNs3GM8/OWU2QYOb5chuXFgY8KhF4WNAB1sdnGqn7UwRLBT4X4liT+6rwUl204IfnIJYsMQCqi7d4RI5+eQbkClQA6BIacnUwa8AmMiEmlygZlXeP44dctUIvm/WrjanaQGiylHIrUNqD53uVpn4Ut6VkZXPwV1Np1pvSY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199015)(66946007)(83380400001)(36756003)(26005)(6512007)(66476007)(41300700001)(316002)(6506007)(2616005)(53546011)(66556008)(8676002)(6486002)(44832011)(38100700002)(2906002)(186003)(478600001)(4001150100001)(5660300002)(8936002)(31686004)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2h6cHF6eGVDK0pvNjl4eFlPblNVaFJ6N0ZGS2g2M1NZQ04wRitoOFlUSXA2?=
 =?utf-8?B?VEM3cEpsdHJHSU1mNWhLRTJTVVlMallETVlHSWNLandsMXR1alVLMG5wRzRE?=
 =?utf-8?B?dG5iNVBuRFJzVm1Db2lWRVNYU0ZLMk1ha3Q5WFBRZEo5dnNTTVFBMDhlNEZo?=
 =?utf-8?B?ZHBueXJ0NDVjdy81dUJhZlg0Qnl0RTRpc3hQZUVuZTMyOEdXNW1aUHo4S3pv?=
 =?utf-8?B?blV3RTVJckt4TXRuTXlocy9HV085cTJrRTJKbnAzdyt0ck1saThYZkJwYmEz?=
 =?utf-8?B?Mi8rWHJja21oK2xrdlBZTTBDdVIzc2hWb1lXMGwwaGZZd1hoMVRRTUZZK202?=
 =?utf-8?B?SW1WOENwNkhtMjZyWGh1NytRK1J6YmZsaE1ZWXFkQjRQb3dwRTh6VmtYUWFp?=
 =?utf-8?B?cWhybUZGVU9iWk1tcTVQRDdmOTk5L3g4MFYvRWZoWW1kbE8zYTJISWdydlN2?=
 =?utf-8?B?cUYzajJBRUd1VktMU3ZhQXdCN1IxTW9JZTFpalVhQ0thN3AwNllQbFlUQkcv?=
 =?utf-8?B?Ymw2MHpvME5IQWJaOE9ONDhtbnBRNEt0YVgzTk1pWitmS21xWWtpYndRUVY3?=
 =?utf-8?B?QXlpSlZXYzU1dzJXYzhSUUZrelY4OC9OR0QvQml5TENkdUw2bjBhNEdWUCtr?=
 =?utf-8?B?WnBNc3NRWi9pUHNvc0dIRkdERFN3MGFORUVJZTF6bXMvaTNVQVlPTmVuMWhU?=
 =?utf-8?B?a0szVmVudEIzaUdtd1AyRlFBRVV5S3hqS3V2K2N2TEtTbVUzb0lzQ0FUYzVr?=
 =?utf-8?B?TVFhbHI5Z1gvcUQyamNvZ0lwbTFVVnIzcEdWbEUwVGNRWG9lUU8wcHozaFFC?=
 =?utf-8?B?NmxOZURvb2poZU1RSTZSQ3NQZjdvUTlqVWNXWWsyMGtXbE5TSG1wY0lrcytF?=
 =?utf-8?B?bWQ2b2ZPVkdKTUZ3MVdaMWJPZFhuOGxiYmFqSUQ2bnV0cVE2dkR3N1QwS3Zm?=
 =?utf-8?B?dVBNN2V6WC9DbGlDbHpNZU4vM0hzVUJmdWp2OERBRVVBVnFveTZDWTRNNy8w?=
 =?utf-8?B?NWxRQjcycGhNSzVid2NqL2xvZy85d2VwT1hNR254MUkzTjF3bUxSSkZkZWln?=
 =?utf-8?B?cUw2YXF5VDNIZlFlUElpdGxtdlRoenoxTHdKa2txbnk1bEdNVFp1ZDNyWlpm?=
 =?utf-8?B?WWlsZExmalcrNFhRN3VOR0EzSEFHRnlncjhiRkdhajA0SG1Kb2J5Y296cFVi?=
 =?utf-8?B?cUJJWG9XTzkzRG8xNkZ6RHRKeEU1WkprT3diNGxxOGt6NTU2ZUlNRFByNUNs?=
 =?utf-8?B?WHN2QW5hSVlXY2dNbnZKSmVKaEVxTzNRQU92dU8vNmwrSDNmZWI1UE9vb0xv?=
 =?utf-8?B?NlFnY2oyVGo1WWxOU0pHeUgxMlR0NkZGYmNMbXg0MHpQY1h0NmNrcG5lMi9U?=
 =?utf-8?B?OEZIKzN6VndsRlhaSlB3cEN4OVFLT0NkZURKdGppVTNoWHI3aWhzVTZ6dkEx?=
 =?utf-8?B?K3VYMitJTU5BUm9wa2NMNjlMejU1K0IydE4yMHhsRFFNTnBHVVEzOURjdGl2?=
 =?utf-8?B?UFBlRUt3em55WmdCMCtROWFWTERLTFRSbWlyWHlUbS9EY0JWa1VteUkrc1Vp?=
 =?utf-8?B?dDl6eTJJL3dhSXRpbUJXYWptbWEyb3NaM1c5OU8wK3JBNmZ3N2tZSjdaVDMw?=
 =?utf-8?B?eUxhN1BQMm5EZGZRaFQ1dlkvT2dJSWhzZGc5UDVqMmFZaUJ5TWQvRGRRWUxl?=
 =?utf-8?B?MTNXdTQvNThxaHlqMjdaYmJyQzZndlRhRTB2UEtiU2V5M0dhWkFPUDhZRGVj?=
 =?utf-8?B?WFdaUFNmSmxWa3p4OVdWU3NSN0MybXduZDdSQ0YrWSsxa2xIRk1sMHIyVnll?=
 =?utf-8?B?aFZsYWpTejF0YnNSNGVBYUpBbEZkTkVLU3ZQUkxhSGR2bWJiaENlZWNBVHNn?=
 =?utf-8?B?Ty9pSkVVWGY4WENCT1RIdktGNnA2L3J1SzNFYmdRSFhJZnVoN0hOc3F0bm4x?=
 =?utf-8?B?bHFCQktmVjR4RElUQ2NxMVpLcFg5QWtEZ2pteHVycDAvT3JOWFRRR3B1eGN1?=
 =?utf-8?B?L0xyNzBhWXFxN3ZnZlhiMDZQUGp5bnBUUHM4di96aTVNNFdnYkY3SWVSdU84?=
 =?utf-8?B?ZU9hbXpNQVB2T2h3QUZjaXRVaXFvSTh3SGx1K2pmalpLV2JRYUxVbE5yQVlj?=
 =?utf-8?Q?MsV0jXAczE5fTR2XwyemFMya2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e315a6-7bc0-4434-7d61-08daccf450fb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 01:44:53.0197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slnzRDLhdIixu5TXcIBr8WHM2/OX84M8QsYZDaEwibjjdzmSkbNRnWNOiwqtt/jZYAGaey/tg6WdXFU/wJXKiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
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


On 2022-10-31 12:23, Jonathan Kim wrote:
> From: Jay Cornwall <jay.cornwall@amd.com>
>
> Trap handler behavior will differ when a debugger is attached.
>
> Make the debug trap flag available in the trap handler TMA.
> Update it when the debug trap ioctl is invoked.
>
> v3: Rebase for upstream
>
> v2:
> Add missing debug flag setup on APUs
>
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c   |  4 ++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  2 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 16 ++++++++++++++++
>   3 files changed, 22 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index ae6e701a2656..d4f87f2adada 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -193,6 +193,8 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
>   		if (unwind && count == unwind_count)
>   			break;
>   
> +		kfd_process_set_trap_debug_flag(&pdd->qpd, false);
> +
>   		/* GFX off is already disabled by debug activate if not RLC restore supported. */
>   		if (kfd_dbg_is_rlc_restore_supported(pdd->dev))
>   			amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
> @@ -278,6 +280,8 @@ int kfd_dbg_trap_activate(struct kfd_process *target)
>   		if (kfd_dbg_is_rlc_restore_supported(pdd->dev))
>   			amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
>   
> +		kfd_process_set_trap_debug_flag(&pdd->qpd, true);
> +		
>   		r = debug_refresh_runlist(pdd->dev->dqm);
>   		if (r) {
>   			target->runtime_info.runtime_state =
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 9690a2adb9ed..82b28588ab72 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1101,6 +1101,8 @@ int kfd_init_apertures(struct kfd_process *process);
>   void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
>   				  uint64_t tba_addr,
>   				  uint64_t tma_addr);
> +void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
> +				     bool enabled);
>   
>   /* CWSR initialization */
>   int kfd_process_init_cwsr_apu(struct kfd_process *process, struct file *filep);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 59c4c38833b6..d62e0c62df76 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1252,6 +1252,8 @@ int kfd_process_init_cwsr_apu(struct kfd_process *p, struct file *filep)
>   
>   		memcpy(qpd->cwsr_kaddr, dev->cwsr_isa, dev->cwsr_isa_size);
>   
> +		kfd_process_set_trap_debug_flag(qpd, p->debug_trap_enabled);
> +
>   		qpd->tma_addr = qpd->tba_addr + KFD_CWSR_TMA_OFFSET;
>   		pr_debug("set tba :0x%llx, tma:0x%llx, cwsr_kaddr:%p for pqm.\n",
>   			qpd->tba_addr, qpd->tma_addr, qpd->cwsr_kaddr);
> @@ -1288,6 +1290,9 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
>   
>   	memcpy(qpd->cwsr_kaddr, dev->cwsr_isa, dev->cwsr_isa_size);
>   
> +	kfd_process_set_trap_debug_flag(&pdd->qpd,
> +					pdd->process->debug_trap_enabled);
> +
>   	qpd->tma_addr = qpd->tba_addr + KFD_CWSR_TMA_OFFSET;
>   	pr_debug("set tba :0x%llx, tma:0x%llx, cwsr_kaddr:%p for pqm.\n",
>   		 qpd->tba_addr, qpd->tma_addr, qpd->cwsr_kaddr);
> @@ -1374,6 +1379,17 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
>   	return true;
>   }
>   
> +void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
> +				     bool enabled)
> +{
> +	/* If TMA doesn't exist then flag will be set during allocation. */

I would expect a change to the TMA allocation function, but that isn't 
in this patch?

Regards,
   Felix

> +	if (qpd->cwsr_kaddr) {
> +		uint64_t *tma =
> +			(uint64_t *)(qpd->cwsr_kaddr + KFD_CWSR_TMA_OFFSET);
> +		tma[2] = enabled;
> +	}
> +}
> +
>   /*
>    * On return the kfd_process is fully operational and will be freed when the
>    * mm is released
