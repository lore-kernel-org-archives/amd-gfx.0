Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD88FC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73594611C8
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 73594611C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 020C16EE91;
	Fri, 17 Sep 2021 19:52:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FD796EE91
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 19:52:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWdbgR7dJuigPEkfyAsE9tYoVXV92vI66gH+Gt1G3rR/X3syZLJvvyJ5Hm/iFAdCivx2JVBxwstIjt9n/3S3aQ+k7Ai6RUgj9avVNlS4BKEDd3BK6iAUC79wct85q4f8zVRmaphu444BNHDs4zdtbLF3cuFKLt50lZq3FWy57ynK68xlDTx7zn10OMfMMURfPlUfre2/vxMnfVKDO/SNOlYPlhVbmH6co9Z1jbyGRzX1vDQAkkiaIfNqDhssdMR+/UsW/EmYyd8bvVg2xelea2WC7lzQIMvdEE1m/NaV3p6Qh9I8K5sy1qgJjfIEuuEnT8c4ANiSxV/v072xilncpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=eoVcbi7VRLWrLcmk8JjsrZrGFPZIWtrh/2R+av1i6pU=;
 b=MTS1EVaxuBOCCh//O+rBnVs7Nk5k7B45TdsfxVNiTsXrbYPiVp/UUSwFPiDOMsSMZ4+oucslsbFMpDNNiL1bdPkyW5Jc9h3s0ScsgVgG1CIMuQUDM0SuEdrjeaoSF32ZkkRTGiQVfik+DlJH1dT7hWfqIsPWhs+90IA0csnt+MGBaW+LW/b7vZ39wqlT4ty6FK1IrEh4zLiMvJhz9sSDiNbpzj81qG5V23lDIEPRClDJAQQ88BodNTcNn0wPWmvkZMD6xMkyiYSDLNJexhyBRJODiGfydu8hGaO6X3e41fFkVlDOHNP+LHFoP0713dAmUdiJQIUbRZG2KihC+I9CIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoVcbi7VRLWrLcmk8JjsrZrGFPZIWtrh/2R+av1i6pU=;
 b=HKT84u00goYGdI3WKTalTInhwedtNyEvgJzJ4ymK5t4iSsLD23bf2xurPTj8fBJUPhzRcnLkNWx4JCF6gwU4/ClsLU7VwFepjWz/DHD61pPsHHxVGXN5v3UPGIE7KlkeOD26h/en4wBIwkP078sThAVYJ6Ksk3WMSLcGVnhDC+U=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5196.namprd12.prod.outlook.com (2603:10b6:408:11d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 19:52:36 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c%5]) with mapi id 15.20.4523.017; Fri, 17 Sep 2021
 19:52:36 +0000
Subject: Re: [PATCH v3] drm/amdkfd: fix dma mapping leaking warning
To: amd-gfx@lists.freedesktop.org, Philip Yang <Philip.Yang@amd.com>
References: <20210917180436.13923-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <4b03b58c-bc8a-19cf-94db-dd9f4b27c109@amd.com>
Date: Fri, 17 Sep 2021 15:52:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210917180436.13923-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0074.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::32) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YT3PR01CA0074.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:84::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 19:52:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc5ad8aa-34ea-4a7f-d789-08d97a14b249
X-MS-TrafficTypeDiagnostic: BN9PR12MB5196:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB51962B782E3F09595C59D00392DD9@BN9PR12MB5196.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p59k7ozllEfL+NYQ1MlTUn9GR7PRMgDIUxohWrHbbuBjHQKNjv8dZFTXlLonQqDeJnZJqzXR20NueTuur90qRocg8ukxp9nouOpPugSlTB+gK09o03CFwW3fOu124sGBkxsbDrvdRynd6QrVHk3OwPtm7zvg1So61Jk84veHz5c7TBsJ6+r2TmJGwEE785pWtaCnvKQ2s78ljZuGGtK73WJmgoWyQCtOdcsusD1L4IzsSY/3Pc34iQhEqlWg9TxXh8n0tpd4rwnFa2MMHGgVNCcMAGoTdQhFejJRlclL+Q80Ki3+9DefWcH1P7k+YXTPaG0Uw50Wg+uw0Lep+j2v7OvZDV0Br4orv6V4Gf7O5A1cCLOPqlj5wrnO5GTVfcJ5yfOJb6Q6BUdrKrN1QXMIBXXCizQK6dtnBQs5saPJY00oDZ8W4JqrELHyy9KwJKuIHkm5NehzmtmUlStrNGeeabQr5rVGUqUI+IldJ1uOZ1UAPbAKqPXGuSa5H0gC1gjkL6xc1DwsMEsw5xDFut/GbPgMhmrRfLb+kfasGRaAiytg86dzuQWjtRRzqaDzVN2Qbu270qmQAgpQJuc5QH90Y5k7G+Bj1UYiMwyJPZ6FZ4r/fMhluovGGoqCy3E3gjKqEqqrIlalYd6wmpe8/9kJ/W+bLGVPB8Fw1X7DXIIpWFa70xcnUgH+dGQnJ/NNWI7E9jXz+mypOYv6xWqIta22O5O2kwx7P939w+twz6meSJPMlAIUUOTTlShpfuNwPNtH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(5660300002)(8936002)(38100700002)(66556008)(53546011)(66946007)(8676002)(86362001)(6636002)(66476007)(36756003)(186003)(956004)(2906002)(2616005)(6862004)(31686004)(508600001)(6486002)(31696002)(37006003)(316002)(16576012)(26005)(44832011)(36916002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW9SWkNIN3llZ3hkSmpDME5Edk4wQTJGVFRnRDFreXdmRHhrUlVmdzdQVjFB?=
 =?utf-8?B?UnlLMlpncHI1U3NKUnpRU1lTaEtLbEJwZ25kejZlVmU3OW5wNzZEOFU0emJL?=
 =?utf-8?B?Tnl3RUJha3Y1TmtiR1J1L2lEMUFxQmRvN01YNHlTNTlFYVlwR1FyZkpqVHlw?=
 =?utf-8?B?dW1iVTRDd1F5SmxYODl6THRvY3EvRGpKUlNVMDRiNXpValRjd0RXSThFZnYv?=
 =?utf-8?B?c0lMMTgrdkNNSnZER05pMHlpK08yZ0M4UHVON2oxWkZmN2lpb0tsbGFueE5I?=
 =?utf-8?B?ZEk1Mi9ocjlvMjRnUTNNNHl3UnNxNkVieWQ1K083VE8rTFhKMVkxRWdQYTVI?=
 =?utf-8?B?Ty9BMytyZmRqblRMV0EzRDhxU3hYMkRybk9OdUxGWDBlTGF0cHRQUW02S0gy?=
 =?utf-8?B?MUE0dXFRTnhLMjY3UENvRkxSeXJrYTduYytITWhTaHNjZmdRM3NZRk55d1R3?=
 =?utf-8?B?eFhIWkVyRktBc2dJejc2Yy9sRlZDUVcxVkJpSkFFbW9tWHk3Ukt3L0xhWmVy?=
 =?utf-8?B?ZktHTDR2Mi9vUVAzZUs1eW1Vb1NCVDd1ak8vZi81TGlDaUpIVHBkLzhQeEhQ?=
 =?utf-8?B?ZGpHU241d203dTIyNllhcm1vL2hvY3EvWGlSSTJ1bjMyKzNNeStoTmZPRVIr?=
 =?utf-8?B?V2JkaVRJbFR2NHpFNHhjNnQrTzdFcTEyRzlxY2U4ZVpvVlV3ZkN2MXRDREhv?=
 =?utf-8?B?VEsxQzY3ejdkc3lkUEJYanoyeEdxOC84RWlUSUVFblhqcEsxNU1Ybm9xK1Vi?=
 =?utf-8?B?YTBxNnU5M2xKSWVtYklQTHUxY1R3aS9sdUVVWXhvVHY3VGlGaWdUUVpuc0Na?=
 =?utf-8?B?Y01WVmVELzdCVStSclIvdk82cE1weUx4dURKZm5xNC9mY0IwWGRPZHdvQTJE?=
 =?utf-8?B?SE8zUWNJN1RtL1RVVXVHdjV4cDNzVHliZVcrNGRDRXZqQzFDbDNiVmcrNUhI?=
 =?utf-8?B?ZGNDOXVHUXdLM3NYMm1yaXI4ckN2K3BqNHRtL2cxaEhYZHpGUEp1V0xGOENJ?=
 =?utf-8?B?MVhGMllvL3k3WCtZcjBaMGR3akFhS2txUEJ3ckRMSFhPbmVqV0xOV0thNG1s?=
 =?utf-8?B?Y2ZpdGt2cUVaMWJmUEx0ckk0R3JQYjNzaUZIVUo2SVpvT093SEJtUGJNdDF5?=
 =?utf-8?B?b3cxenErOU83YWhud0ZHNW93MHA3SmtubmxIMnJLZ1IydFl4bG1DV0ZpT1FO?=
 =?utf-8?B?V0VpV3h2aDc3elY3MXlmTy9PbmtSa25yZGVqY0paeDR2ZDJySFpUSm15NldO?=
 =?utf-8?B?MllaR0x3UEdxK3owTWp0WG84MUt5NkRzdVQ0bzZjQ1dXeS9FYU42N2dLTzM3?=
 =?utf-8?B?NlFFWHBPZUt6NzNkZ1RoM2pxczRVT3V3VmM0TFpvNlZteWJOUm1CWmNFL1BW?=
 =?utf-8?B?aHNOMElHQUNpL0loS3ZOVU5RdmlGaWF6clZPb3EzY2ZhelBBTkxiMEdMdHpH?=
 =?utf-8?B?MjFpY0tFTk9UekNQdXpxN3I4MklYM0tNc2Vyb3hvL2N5aG94ak0xU3Fha3Y1?=
 =?utf-8?B?aW9ZOUpScFBvaGVISU5IVkFUaWtwV0VSOVViMUFzakE4VjBubFRkZHUvNC9a?=
 =?utf-8?B?TklLd0I1SzNJcXRJaGNPOFB4OWt2UGQydkhCUURuUUtlZHFHcXBPTTUrMDQr?=
 =?utf-8?B?dmNzUGdpYlMrNG5GV2UxNGVYaitwUlVuV3NHbmZUZUlSMkovLzdpZzJnR05l?=
 =?utf-8?B?aExkTGk4SUFoUDU3dWtCekRpZDBxV0NqNUlhcWlyTm9LOVN1NlpicTBaYkkx?=
 =?utf-8?Q?BOWzyRT97jr2HdRDCeIqqBOsfxMwoB0grbX7Gx4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5ad8aa-34ea-4a7f-d789-08d97a14b249
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 19:52:36.0496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mSBPsX8Hscg2EwolvslEhLrdwnM4hpYAwSk2Lv3MBWEfMwD7kDg/OeLS0eDihT6wQTyU0XBIuM6MggL0jBb3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5196
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

On 2021-09-17 2:04 p.m., Philip Yang wrote:
> For xnack off, restore work dma unmap previous system memory page, and
> dma map the updated system memory page to update GPU mapping, this is
> not dma mapping leaking, remove the WARN_ONCE for dma mapping leaking.
>
> prange->dma_addr store the VRAM page pfn after the range migrated to
> VRAM, should not dma unmap VRAM page when updating GPU mapping or
> remove prange. Add helper svm_is_valid_dma_mapping_addr to check VRAM
> page and error cases.
>
> Mask out SVM_RANGE_VRAM_DOMAIN flag in dma_addr before calling amdgpu vm
> update to avoid BUG_ON(*addr & 0xFFFF00000000003FULL), and set it again
> immediately after. This flag is used to know the type of page later to
> dma unmapping system memory page.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 57318edc4020..e47f1219ad84 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -118,6 +118,13 @@ static void svm_range_remove_notifier(struct svm_range *prange)
>   		mmu_interval_notifier_remove(&prange->notifier);
>   }
>   
> +static bool
> +svm_is_valid_dma_mapping_addr(struct device *dev, dma_addr_t dma_addr)
> +{
> +	return dma_addr && !dma_mapping_error(dev, dma_addr) &&
> +	       !(dma_addr & SVM_RANGE_VRAM_DOMAIN);
> +}
> +
>   static int
>   svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>   		      unsigned long offset, unsigned long npages,
> @@ -139,8 +146,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>   
>   	addr += offset;
>   	for (i = 0; i < npages; i++) {
> -		if (WARN_ONCE(addr[i] && !dma_mapping_error(dev, addr[i]),
> -			      "leaking dma mapping\n"))
> +		if (svm_is_valid_dma_mapping_addr(dev, addr[i]))
>   			dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
>   
>   		page = hmm_pfn_to_page(hmm_pfns[i]);
> @@ -209,7 +215,7 @@ void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
>   		return;
>   
>   	for (i = offset; i < offset + npages; i++) {
> -		if (!dma_addr[i] || dma_mapping_error(dev, dma_addr[i]))
> +		if (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
>   			continue;
>   		pr_debug("dma unmapping 0x%llx\n", dma_addr[i] >> PAGE_SHIFT);
>   		dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
> @@ -1165,7 +1171,7 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	unsigned long last_start;
>   	int last_domain;
>   	int r = 0;
> -	int64_t i;
> +	int64_t i, j;
>   
>   	last_start = prange->start + offset;
>   
> @@ -1205,6 +1211,10 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   						NULL, dma_addr,
>   						&vm->last_update,
>   						&table_freed);
> +
> +		for (j = last_start; j <= prange->start + i; j++)
> +			dma_addr[j - prange->start] |= last_domain;

This would be slightly more readable like this:

	for (j = last_start - prange->start; j <= i; j++)
		dma_addr[j] |= last_domain;

Other than that, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> +
>   		if (r) {
>   			pr_debug("failed %d to map to gpu 0x%lx\n", r, prange->start);
>   			goto out;
