Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55EEC433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 07:39:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5025F60FEE
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 07:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5025F60FEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD67E6E303;
	Thu,  1 Apr 2021 07:39:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72FB76E303
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 07:39:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEB00OCckux8+MEtdIv6ltSAaxz1fKzh0UvNDjQDLJjMRD/IDxsuMuSgyefe2JCJy9tCTw9rLL0Bzmf575sG5eEGq5ZaoFM72bIRGr/iEShWwpZy5pP/p75uLEV9otjgDw20p7Jz8vo1SFCaXtIS+qCN6+nmig/AkPBr4bcXi6KOzT/xgsQBMDE0EASKWU2sPlAUR+GWCLK+g5eLAHbOI26j+ORB3J1T5EBG/yttlYSJyIP8agStKADc1dSd8No7iHay/Hv/SFKxv3VjQ+j1sIiWpdmw6K8d0tp59eMsBCBE2P/Vqbztp9EP+DDwRyY10mvvSdI81iuDJlZhW7xxuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHHKYMogympkZanbbi1noDe8rqm+g9LnKzJNHOdB/tA=;
 b=nqZcatH58TiCBeAbutxsIh3h3Xxa0F2I7TpMBFrRKionSqLf3rC/lXWXQ/wpCDluMmNYkxcGRbV5Ep0tds3X+t0WccyrXPUe9JGv0LRxjWlUnYig5og/5LOXP+vd//KjFU1LJ5QlVaTUT03ef9aeb0n64Iv6NMqlXnjNNSWeTZn2ul525HPDKDNy6AiyOoiQVmX4Hv1L82Z5HrGWGDedlISEafAcmmZX/brCUxbset9GNa+WiVFYTY1gFywVihVHkQspS8LIkSi7AQrAi4lVhpkppcW7xtT/AdqQJj/QlUXj/LNeR003ty9WiaNULQSGffEAMkhn2SWRI5ofnNQyjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHHKYMogympkZanbbi1noDe8rqm+g9LnKzJNHOdB/tA=;
 b=e+Dm9Ay3i+JEFvAESgzXrP9EdXD5pgmXc8zDQwH2f/syAl4PqwN00njW/EXfkPPfK06pPv5RwD7TTfUO5grg9IdN63YgO/YoU8nRNk4DzYN+lxgPVhLl5yDyC5hlg6acE3T8XN4ylO6QuG2U98ZVoYfAavsJFrETP+Z0a6lo4Sg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1208.namprd12.prod.outlook.com (2603:10b6:903:3d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Thu, 1 Apr
 2021 07:39:42 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 07:39:42 +0000
Subject: Re: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210330094235.69090-1-Emily.Deng@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <1ed15e2f-1f2c-95b0-e806-1c1bc4a30a23@amd.com>
Date: Thu, 1 Apr 2021 09:39:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210330094235.69090-1-Emily.Deng@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.106.131]
X-ClientProxiedBy: AM0P190CA0025.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::35) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.106.131) by
 AM0P190CA0025.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.27 via Frontend Transport; Thu, 1 Apr 2021 07:39:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27e17abc-380f-4141-ad4d-08d8f4e15010
X-MS-TrafficTypeDiagnostic: CY4PR12MB1208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB12083723D0166D844A8B53D68B7B9@CY4PR12MB1208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SBPhcytoEb6TvtD+HpZf0V8aAVIo6x1ezZg/IooJuzAfr4qH/1cWs4vUaNy1R35t1HhnoQIVF5GwxjoG6KbsQJSvJfi76od10EA3RITVA+GDbhdH00GcoVT381wDBo0Y1HwRFKMmsatWj2J6CRlC+jyfeHJEdWRcHyrDqHeUq5+GZFZ1zC/pBFkqtcUAvaAsLvI9JoIc6pdeSealZ7r1Gl3WyA2W6Oah968VnuhPB3y9kMrNRWbs6NtZV1yDc5kPW64ZFo9NUhwucAufEsLJfmzARf/SR1Irg1vWIh1rlsEQG8fRMzGIvBR8wqowon4MzAdMohcmGLGh/mxs1FOtCSMJLJAAHzGeBITgJZmnDX1oscYyC4LkHLnxsVyL1zwliZVyIPE/F71wh4rmhJUszjActKIKzbaBofdPIgOWliZAiOWQNTsusS/gWVEIov8CcfBfYoyBPacDf/lvVkYyT6WPInFnOZvOFKWvVRp7k36wGYQhq/qGXv+9UeFRXY3IYFxzAxJwa/EEKLdudJ9gLWr4y+O2H8bY4NHjIeFEGIy7PBDuEJE9ZGmHY7m05mSv3beYSEzktwxLAOHCahPfym9laOWMArH3jVSi0/Q/m7Wr/MRxYHS9J3/sAwEEq9OQNiWPre6Izu/u2B+W/8vslnjNGiTsLUETwRbsnpnsNujsPFbgpUebouqpxsHgz4CgEnZUgRjbsFvo85b8xGHsxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(26005)(8936002)(8676002)(16576012)(186003)(316002)(16526019)(5660300002)(83380400001)(38100700001)(66556008)(31696002)(66476007)(2616005)(6486002)(53546011)(478600001)(66946007)(31686004)(6666004)(2906002)(36756003)(956004)(52116002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V1ZJVVk5Nk42a0xrZmpZQVZhRzhKc3NHZ042VlU0SUdERWJTclhIbDEyZU9o?=
 =?utf-8?B?UWVnR0pjcGRqaGNOenp5cG9LZ2NmQ056cE5FVmtXUnJzYnpkMkhTZGY3bC8r?=
 =?utf-8?B?QlY4akdENmdRTEdhZUZoT0NQWjhUcWxjT0sxSkVjaWlTbU8xVXpTcG15ZkJD?=
 =?utf-8?B?ZW9YR3VVZTJFelFETHIzcTlkT0dlbThudk9oamJadENVaW9uOUd1V2NHVjBy?=
 =?utf-8?B?NlpHKzFMK21WUFYrVjZpb3FpVW0zeHVQemNucnhxODgydUJzTjZPclZDckNF?=
 =?utf-8?B?elRkVzZMQ3JmSkM2T1ZDa0hWS3JNMlFYWE1uRDVObWxFRElxT2F6dzV2Wmk2?=
 =?utf-8?B?RXpFWUJFQzNkd1hjZHdxWktaUzJ2YllJSXFxZ0ZWVmx4OWRqV1ZkL25IWVhO?=
 =?utf-8?B?OWhnejZaVUZoUk9Gbks4UjdaNXN6bGxPRFB3U0VTTUlSeWpWWlo1RVVLQWlm?=
 =?utf-8?B?eUFUVm5pVFpZREdMUFJiVlpOQzM1WXo2anhOLzMySTA3Uk5rai9JcVBFb3k5?=
 =?utf-8?B?akNnT2dLaGhyOEpvUEpUSzI3a1J3UmFVVVFDR0lyeEQrMENRUVZpUXJTZ2ty?=
 =?utf-8?B?K1NXb0U4OUo0TVh6a09SNDJLNXRENnU3UHNRcVJ1MU5Ua2VWMm9aQTFmd3VP?=
 =?utf-8?B?Nml4VnNXT2ZFREV6VGdOWVdXQTd0TmNoRWVMWkZFeU1rbXJJQ094NEd4bjhH?=
 =?utf-8?B?MUc0c2ZSWTA1RGxZcGlWd2RPNWVkRGN3V2dadktVV3FERE83djRaR1FDOXJX?=
 =?utf-8?B?SU1taFNWMEJyZjN4YTg5eVc2MjRpK0piZFBJcGxQaUU1a3JMWkxSSjR6bXQ5?=
 =?utf-8?B?LzZoY1RXdnRUa0pNRmkvNit6Q040VG1PbHRYNUpKV3pmdmtDR2ZQckk0dHBC?=
 =?utf-8?B?TmZiN1lobjJuR3hsTWtUdWRneWs4dVVFOUdCZ09TSUI2Tldtdm92NGdiVjNw?=
 =?utf-8?B?emo2dWYrR2hpTjQ4N1FBakM2Tm1YaVRzM3ZUTFoxTmhvaUd4WE5qWE1UMTk5?=
 =?utf-8?B?SitpUktySVMvNmZwN285Vm9GemVhZGlwckE3N1JrbVZzVU5qMnJIUVpFZGdt?=
 =?utf-8?B?L0xmaHVCVVhqR1ZURkRYdCsrVTI3VkNIMWVvSHJ3a25pcnIzQjNsYzdOZVBY?=
 =?utf-8?B?Y1lOa0p6UDIwOFJoSU9lK0ppT1VlR0NsZk82NzF5R2VmQ0NLUzFFQXhua3kw?=
 =?utf-8?B?cW13Zk9sUnNNZUR3bVhxZGFEMldHaC95YmswWDZvSXVEUERSQ3Bjc2F2RXE4?=
 =?utf-8?B?Nm43VmVSeUtQUTltVmo3enlRMFdZdE5rZTJoZWhidzVIYWdheFEyMFpKL2VP?=
 =?utf-8?B?cEFmZ2g1amw3c0lVYWVOTmF6QmY1WXhlOU5kcWtjL3JpdFl5Ky91RitRTnVh?=
 =?utf-8?B?NUdVSGlhOWMrYUNSUXhqTE9sRUczZFVBZ2hOa2k3VWNUeXR3TTYvdlh2TTFG?=
 =?utf-8?B?dUZVZElzVERSU0RpVk9GOUxGa1VSUklvVWdwWjhoVUNzTTlBTzJFTzBPZXNQ?=
 =?utf-8?B?bG9TYXgxUEpiMUpQdzNxa0REcU0vRjlTNERoZHVmLzE4cnlERE4xdkRUNmJ5?=
 =?utf-8?B?ZmZ4eTNjN3R2ODlJWTBvM0RLVFhSU2pXUUJ1bmQ1aUtRUEVSSk5JT1J2L21j?=
 =?utf-8?B?bEhuMnVDN1VHbk15dC9DelpDR2liQy9iS2FGYjFPSWl0cEpaWGhrSXVCaTNN?=
 =?utf-8?B?QWFiMFFibkJnRHlhWVRVRitiTDJMMjB2Q2kvM3BHMnNlSjZ2TDVOT0N2VUVv?=
 =?utf-8?Q?iq5q9FZvuLyGLA00m6i54OLsIuQ+CcErtqgXkVZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e17abc-380f-4141-ad4d-08d8f4e15010
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 07:39:42.4952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W48jY1tKn8szbByjWkys5TIRy5NCp7m405uboFaVxLbSkdWKhkn9vcXMH8fhOsFAzFNv1kM9bjVFQc2Vb3nr0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1208
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Nirmoy Das<nirmoy.das@amd.com>

On 3/30/21 11:42 AM, Emily Deng wrote:
> From: "Emily.Deng" <Emily.Deng@amd.com>
>
> For vf assigned to guest VM, after FLR, the msix table will be reset.
> As the flr is done on host driver. The qemu and vfio driver don't know
> this, and the msix is still enable from qemu and vfio driver side.
> So if want to  re-setup the msix table, first need to disable and
> re-enable the msix from guest VM side or the qemu will do nothing as
> it thought the msix is already enabled.
>
> v2:
> Change name with amdgpu_irq prefix, remove #ifdef.
>
> Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 03412543427a..3045f52e613d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -277,6 +277,17 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
>   	return true;
>   }
>   
> +static void amdgpu_irq_restore_msix(struct amdgpu_device *adev)
> +{
> +	u16 ctrl;
> +
> +	pci_read_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
> +	ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
> +	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
> +	ctrl |= PCI_MSIX_FLAGS_ENABLE;
> +	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
> +}
> +
>   /**
>    * amdgpu_irq_init - initialize interrupt handling
>    *
> @@ -558,6 +569,9 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev)
>   {
>   	int i, j, k;
>   
> +	if (amdgpu_sriov_vf(adev))
> +		amdgpu_irq_restore_msix(adev);
> +
>   	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
>   		if (!adev->irq.client[i].sources)
>   			continue;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
