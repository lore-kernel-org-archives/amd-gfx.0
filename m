Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E5AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 16:17:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF7461179
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 16:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ECF7461179
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9514A6E528;
	Thu,  9 Sep 2021 16:17:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED5B96E528
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 16:17:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQoeoSaD5XHWPWj4J3OA0ph+nzkqIwU9qaYMpIVaVhFQTJspE4sAnA6M9juHkS9UHv56ptxrz2zvk1Bmf12zWS1CP1rA02OAbUcp07ZRPPl5f/MMDUT3nBTkaWhAngKhY64O/rpDcid7DDIyfX2/eMuDqDYkAGhaEbkbSrvb4JjAjlqh+QXNlUErXgrrpZ9xCYuJXuifYsWy59/OfHB+XR+fWLc4oZBuEZFqvr2ULKilIhazO/ac9hi97BYf5EJj693vd39Jv5MyFf6u5h93vgQYwyRvOwhqrgqTjzkEZsJKyTi2c2BdnyFbDe690JeXNRArZ5it5Jn3T6BsE6LHyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ITLsKQPiectHJNNSB2p2KxJ7lRbuvWMnpuEuOPxTi+M=;
 b=lj2oKOuBkv3VE0Pdp0h3rKAtvtJMsWNu7KP7vw1lJh2MjY/qqmAMcC+6h58c000Uhn0y7pcEhZLtrHmx88KuqOT27y7HCRE23PJ+p7XQ6YsaTCbAgfpet/jVIqf27X6Wgh8q6SsdY58c/FVqfKzkeO6s7AvTw6aKNnrauTX8khAoSQ+4pXLD61YgQcuUVD91SkADboAAhOOfupZvlukR8kK8EnqTMW8a6I6YDcFe0cUGmI4XZ8UvkeVarPuWUgE+irQBkssLfisFfK7Zc/5jmE1A6yTP24AzA7wGQUV0uAmgX4SecLKMSdeENeEywIpMTcHmBOxHu0+mNr2qrebZMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITLsKQPiectHJNNSB2p2KxJ7lRbuvWMnpuEuOPxTi+M=;
 b=uTen39QwnmNzVZqFAnC7QTpX3bQ1YJV7fciP9KRTXXoOFV9B77nLddcNysSBsT8nKl5npVGMe5zYp0EsJ7pqglg2caFXyIDyDNcu9GCCoNhnak05ZDsR6SNR5xLPdlKBwQwPOpmDgSUNBh9s1mIDxQUZ2yeqgVRw++zjf173xgU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Thu, 9 Sep
 2021 16:17:54 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c%5]) with mapi id 15.20.4500.017; Thu, 9 Sep 2021
 16:17:54 +0000
Subject: Re: [PATCH] drm/amdgpu: Get atomicOps info from Host for sriov setup
To: shaoyunl <shaoyun.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210909155906.16026-1-shaoyun.liu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <5f2d7782-8530-122e-4082-2b4cad9f4a0e@amd.com>
Date: Thu, 9 Sep 2021 12:17:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210909155906.16026-1-shaoyun.liu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::26) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.186.47.3) by
 YT3PR01CA0115.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:85::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 16:17:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5c0b4cc-3d5f-4a3d-095c-08d973ad610c
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5115FBC8465B85C6B00C299292D59@BN9PR12MB5115.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7mRQj2IhapgWLSDu8pzz1qZckfT4YrZMIX2af0hrwgSLrTNBh5BtlVR+hpCxHe4dAAN4LdFVp5uqD+OV7yrvNsmXZW/vNAoWFISUv3Qb5e4YNov/cWV6tmI5wezODNEEy70fi3Uav2aWIdNZ+Xy5H4f7rYs8/I7vJFBmUTzIAPoTyrR9lpex7oyVNP7imVQVSiI+XQEDUK7QAvAKHlM3fPLmqKE8TS2fKjGMP1/p9q/9NcGSfIfaUtqGNSTB86TQvkQSj+PTeMDxsIGDDwzli9MSq0qlRY40Fo4TmDTjEvWoZGLb5LNFB5KtFEbD/gTiN5/WsIHX+drvpD7Dl1EMW0FJUaIpoW2DZrjxl/ySJAjX1L2Phyr1gQvzJ5aKNhEbwniGhmCrIVtXYMRiZA96qxxwgTmZBxJHXbKr4IUN3l51LjKM5m9d5R2OGXX05pfNTAyJc35+gAY9UMvBDJa0Ld2ckwqoP4XB4MVc4ZEs5knOem0imIMNDgVEtPtsYdSE3JnIFKd7rQvNbEi4iIuZACajdhz1uYvAKaQP3Thhdbfb6pN7L42a8xYG1qjw26RkC+ZMZ4Eu3W4AMjh6aGZTsB3V+Rl/QTrQWlce8WuYs77ETRZSFqVb4/Hm8/vDO1rrm27xlRyTPPw9l9ZEoTUSxcfKajIwkx3gLVNRBwSIN51TUn4oR8/285W1QtVvjO7N5O2mxuTVHxgwDJO9r4RcUR9KS+OBS5qn2ab+feDI6ZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(16576012)(2616005)(956004)(186003)(26005)(83380400001)(316002)(2906002)(36756003)(8676002)(5660300002)(66556008)(478600001)(6486002)(8936002)(66476007)(66946007)(31696002)(86362001)(31686004)(44832011)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anNaaUF4Mjc1VE9JMGZoc2QwWVRnRzlhSEZETUxJSE5Zekswa3hjVkwyS1RO?=
 =?utf-8?B?eVNWdmhTdjlNWFZmVjdNTUM3RjR5eUREQUhDYjBKcUo2anE3UGFORUdEb2lk?=
 =?utf-8?B?MHZucEpkalJJbmJMVnF1RGNBVUgvU294VENDZTVlRU42S05JSGdxUGd5d3lI?=
 =?utf-8?B?SXg2bHJ2bCs4NWcvK0kxOTAzZjNyNkpQeC9PeEZWTnhPR3pidWk3SHZVMVhP?=
 =?utf-8?B?K3ErUWZNRDdDL3JIaFc1R2dJN3o0SDZzZjJjeXFHdmVhYkZqKzBJcnlEQkR1?=
 =?utf-8?B?NEJnejdkclk5NC8xMmp2aU9XUWhINmFETFlUaHRrUHJjZGQ1SjZmbUV0QnhO?=
 =?utf-8?B?Z0trcXBQNFlkYzZld2w1L1RzcnVSNEQ5cTFmblNOOGR4cWpoK2xyaEVHVktG?=
 =?utf-8?B?bGxQbCtCczZRdHBiRWZxQ1dWcm5rTnBteGMzd0U3MkllSXhIaGQ0eW5zZE9h?=
 =?utf-8?B?SCt1MU9mZHlRbFdtUmRZT0k4dGl1SC9laEpTeXNvcVZvUmZLNys1ajVUdWdh?=
 =?utf-8?B?RlpUeStWUDcyYjNoOWpmT0NFakQrVkZZblRnTVpKeWo4L0V5YVN1WU9zNHE3?=
 =?utf-8?B?QnBwNHN2K2g0bU9hSUlGNnpTbVZ4YVkrbWd0Z00xVWg5dlhKb09yNExua1pU?=
 =?utf-8?B?SUJ3a1gwd1pSNmZxMVJ5YWZWQm82a3hKeit4L0lYdU11eXpzQlpYMDBWcWt0?=
 =?utf-8?B?RUlCUlFBN3djbzY3T1A4S05tRDJHSGdWSmRkZVc5VHAvUWhKajJtZXJrWXdi?=
 =?utf-8?B?bnBYTG5wbkZLcHNKaXRlc2d4aG85ZXl1ZG1HOFNsaTlVbm1ucTV6cGV3Q01Q?=
 =?utf-8?B?YlFNdGNyZXBwWVlieTFHemd5emErVnlEV0paUzNnbGF3MWJORzZxd1lYTmpJ?=
 =?utf-8?B?V0JJaXovZCtnWDBQR1ZGVWxIVkZyTVpTTUJWTHMyTHp0SVd5QWZwamdBdklJ?=
 =?utf-8?B?TGFJTzBJK3JHWVgwSTFnUFB4R0FLMDc1OEswaDVua0JpZFBWclpxQzIzcUVo?=
 =?utf-8?B?V3BvUUxWc2pEUWlFK3lBSGxlQ29qWllvbHl0YUtiUVRtTkFIVlMwRDBmOWVu?=
 =?utf-8?B?N0dyMCtwaG1rNmFYMEp4eXlzNnBIM0xTc2Eva0RmQ29LZ0pIZThwUmdJU3Bo?=
 =?utf-8?B?R1F1MnZSMlVUV0dDMVBOdFpkVjllUWJqVnhiL1VFWCs0cnpNUnRtT09LVDNF?=
 =?utf-8?B?SXpqa1VrUjVqM2NuNXY2RXNOdXRabm5hK1h1Sk16WTVvbEwrSnhscWRIY0Vr?=
 =?utf-8?B?ZlhFOGU4b3ppOTkxdWNiemN4aGdPWTIvWEdEaGtVYW5oajVpYU5NZXVwNFlJ?=
 =?utf-8?B?TVdIdEQ2TWNKM21nU2x1RmV2QnV6bStKOVJ4M2R5bitscWRmZHBQQjFVaTl2?=
 =?utf-8?B?cjBXUFZVUVlnV0N3WVNWbTIyODU3ZnNteUJIMThzRWFlYmFzYjdveXQxeVdJ?=
 =?utf-8?B?WHI1M216Y2hkdVNQdU1HWHdPL2VWR0hJNllhTkN4WGtMb1hkK1ZkSjVWMUlC?=
 =?utf-8?B?czlPNGtGSmxpMjM5ZnFJOExVOWFvVFl5Q0xvSGJSSjZtNGU0L1pITng5dkRP?=
 =?utf-8?B?ZkFwTzl4ZmtqeU5FdGVLbllzRE1nWFFocDhRVHNuNE1Cb1RSYzFNa0VVNGRj?=
 =?utf-8?B?ZTNSZXNYVDZZQjQ3SDdsTkZHUEorOEkwaTRYUGIrMUo3MGNjUGZxQXFVZU5a?=
 =?utf-8?B?aFg5YTNONnZZV3prbkwvZzhzRjBFYlkxVjBqTU45VU9mQXBKTE85WEwzZk9V?=
 =?utf-8?Q?YNoBXAbVBs2CGr1gUMCj1bN4If/OPdwXFtJI9G6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c0b4cc-3d5f-4a3d-095c-08d973ad610c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 16:17:54.6252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRrOSy/pgsU1EnD3OMJPqzf92ElaInM28lm25/dGLqrE0r5tiYnI528HzWkT7KUartpvRDBA6fHqrk3C8Q4ujQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5115
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

Am 2021-09-09 um 11:59 a.m. schrieb shaoyunl:
> The AtomicOp Requester Enable bit is reserved in VFs and the PF value applies to all
> associated VFs. so guest driver can not directly enable the atomicOps for VF, it
> depends on PF to enable it. In current design, amdgpu driver  will get the enabled
> atomicOps bits through private pf2vf data
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
> Change-Id: Ifdbcb4396d64e3f3cbf6bcbf7ab9c7b2cb061052
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 20 ++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  4 +++-
>  2 files changed, 21 insertions(+), 3 deletions(-)
>  mode change 100644 => 100755 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>  mode change 100644 => 100755 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> old mode 100644
> new mode 100755
> index 653bd8fdaa33..a0d2b9eb84fc
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2167,8 +2167,6 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>  		return -EINVAL;
>  	}
>  
> -	amdgpu_amdkfd_device_probe(adev);
> -
>  	adev->pm.pp_feature = amdgpu_pp_feature_mask;
>  	if (amdgpu_sriov_vf(adev) || sched_policy == KFD_SCHED_POLICY_NO_HWS)
>  		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
> @@ -3562,6 +3560,24 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	if (r)
>  		return r;
>  
> +	/* enable PCIE atomic ops */
> +	if (amdgpu_sriov_bios(adev))
> +		adev->have_atomics_support = (((struct amd_sriov_msg_pf2vf_info *)
> +			adev->virt.fw_reserve.p_pf2vf)->pcie_atomic_ops_enabled_flags ==
> +			(PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCAP2_ATOMIC_COMP64))
> +			? TRUE : FALSE;

Please don't use this "condition ? TRUE : FALSE" idiom. Just "condition"
is good enough.


> +	else
> +		adev->have_atomics_support =
> +			pci_enable_atomic_ops_to_root(adev->pdev,
> +					  PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
> +					  PCI_EXP_DEVCAP2_ATOMIC_COMP64)
> +			? FALSE : TRUE;

Same as above, but in this case it's "!condition". Also, I would have
expected that you remove the other call to pci_enable_atomic_ops_to_root
from this function.


> +	if (adev->have_atomics_support = false )

This should be "==", but even better would be "if
(!adev->have_atomics_support) ...

That said, the message below may be redundant. The PCIe atomic check in
kgd2kfd_device_init already prints an error message if atomics are
required by the GPU but not supported. If you really want to print it
for information on GPUs where it's not required, use dev_info so the
message clearly shows which GPU in a multi-GPU system it refers to.


> +		DRM_INFO("PCIE atomic ops is not supported\n");
> +
> +	amdgpu_amdkfd_device_probe(adev);

This should not be necessary. I just sent another patch for review that
moves the PCIe atomic check in KFD into kgd2kfd_device_init:
"drm/amdkfd: make needs_pcie_atomics FW-version dependent". So
amdgpu_amdkfd_device_probe can stay where it is, if you can wait a few
days for my change to go in first.

Regards,
  Felix


> +
> +
>  	/* doorbell bar mapping and doorbell index init*/
>  	amdgpu_device_doorbell_init(adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> old mode 100644
> new mode 100755
> index a434c71fde8e..995899191288
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -204,8 +204,10 @@ struct amd_sriov_msg_pf2vf_info {
>  	} mm_bw_management[AMD_SRIOV_MSG_RESERVE_VCN_INST];
>  	/* UUID info */
>  	struct amd_sriov_msg_uuid_info uuid_info;
> +	/* pcie atomic Ops info */
> +	uint32_t pcie_atomic_ops_enabled_flags;
>  	/* reserved */
> -	uint32_t reserved[256 - 47];
> +	uint32_t reserved[256 - 48];
>  };
>  
>  struct amd_sriov_msg_vf2pf_info_header {
