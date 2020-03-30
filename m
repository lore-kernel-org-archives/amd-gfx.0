Return-Path: <SRS0=xvO7=5P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6399EC43331
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 15:36:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E3C2072E
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 15:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GKLYrJi+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E3C2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F5CD88862;
	Mon, 30 Mar 2020 15:36:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1819B6E427
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2020 15:36:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0kqD0V/PIMngZyLb/PEsmBAldd+RwKo0XSyxQ1rxAGJ4TTv4Rp3RiuWGdW+7m1lE/NMdgyndOcM4+JT20rn9W62i276rA/yAamlNx8El2HYhtSswQHLTSbElBXg12qL99+K61udFWRI4ZkBXxYO8TcuLA6vBjGtBO65+A1nt0Fn/DSHJFFP3o6rR9KF0X9X/s8LdGTtwSHZ1ZvFA/7rTlQdU4eNFsdmvSRgy1A+SHEFAkSdyYM/3cKun3oxvzVaJsnMArxNb0KtYVtYNksIx85VuWSc8PRyp8Cw+C680Fp3VMl96Ns/r+n9vIHYt7u7ncxPrd3QHL3s2ZR6H6leIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4P4alLATOAowp03Q7HStDW7ZqJOgxf9gMbP06bzJDAI=;
 b=if74yXIm2LjsvWM6zVoiw+QQOFIeOiTUA86afEORuM/8gNYsQP2bKLcnydY33ADTU5E0EtZiD10DwSd1RGqZHTTnW0thilv7fKCbnt/IpIAfbkNvoEotM3n0pfjd/6tdMwmER8bMieezaLozK0KkyK1JFuZ+5GkjRmVmta0+dnW/DXTkL5xShURmbRB3yKbqG55UGc7mw0sU58bgcwn76oKsJsS3k8M6RVJUKnmvs4PFk6TTQMuJH7BCWRH/s+Vidt57dePaglHZgTl19yc7ltmXBnFa39AdxD1CDoadiPURZRfV5pVWwNIR3FVftjHAw4UHeROq98yqmX7gaNcYfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4P4alLATOAowp03Q7HStDW7ZqJOgxf9gMbP06bzJDAI=;
 b=GKLYrJi+YlgCPlqJ8eLW0HTcKG80hThQJvj5/NQixiJk2D5z9RJvr9PSUJUrIWInMi9mC6x/9ajGdkuYVM43Jpqp1QVGDqmZ9AEFSAxJE3qG6ZC6IriiN3JZL5XT5MAns0/HRGYStfeFSa4Nf+F6COtzfnx85C/W4tdQZ5a3MkU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2397.namprd12.prod.outlook.com (2603:10b6:802:27::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 15:36:12 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 15:36:12 +0000
Subject: Re: [PATCH] Revert "drm/amdgpu: replace ih ip block for vega20 and
 arcturus"
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200330152436.19095-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <b2b6104a-7330-b704-0022-bac85097d93d@amd.com>
Date: Mon, 30 Mar 2020 11:36:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200330152436.19095-1-alex.sierra@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YQBPR01CA0141.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::41) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YQBPR01CA0141.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:1::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20 via Frontend Transport; Mon, 30 Mar 2020 15:36:11 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2119869c-793f-4fc1-7a1e-08d7d4c01364
X-MS-TrafficTypeDiagnostic: SN1PR12MB2397:|SN1PR12MB2397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2397338372ACB26E58CEF25292CB0@SN1PR12MB2397.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(16526019)(81166006)(186003)(81156014)(478600001)(86362001)(16576012)(8676002)(2906002)(31696002)(5660300002)(66556008)(66476007)(956004)(36756003)(2616005)(44832011)(66946007)(316002)(8936002)(52116002)(26005)(6486002)(31686004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PYX+gsyTCd2btWHAd6NPyXKom9NpmhOzk+dMlol1UAjPBgBLj0P7OQWqKWRFLcMidkXaFLFcgR/z1f+ix2Uz89NBgz6x7xg7lZSyAb1R875gMXD5UJN/ChFo/3gD3FCA0p+NqE44Z8BmgvCScRCnSvo9KTGvBBv0+Jlqz+RHhelj0XW9ZXclcN26PMg3wqX7VQDCU4Y2EZ5O9H8uvQOgq4ubvCJ8K8eqS9NzDWJ0Bqkg69xfkqVda9twK58yXInXeHTMiJJ+mlgR3sv6BpQHVpanjjYr0P5vvDzwnnxaWQquQMz7PN/GcYh+gwVXbVdNyB370mH0aKjLyMUhqT71wcSVBJkc+oNVzv70sat8m0ReLWshFWQpJQBR3t/4rom5/Wped7PPTKRi2dVTs/6PbjeSIwYLoOlIqh1ltSXoO0s82/kIiyaLOa+YnwHaHZbk
X-MS-Exchange-AntiSpam-MessageData: ygUW7nn7vfSbL4arWSzMO/aBMFQX9lISvYdqLMqdIDBCr9sa63VJIvTggRSAvjwX4ET6kd+e2E3kf6mt6xijU3u5ol+YHYWko7GGuMmerFFVmdW6E9lWCYAkvVmRgs0OtdiLKBC7XM7h5rQPqoiE/A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2119869c-793f-4fc1-7a1e-08d7d4c01364
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 15:36:12.3553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BzMB6GCKkNH1KDjC/nCH9nq8TrqKzpzd/UMjjLBksi8S34wDIpSBW2RfCj6qb4OBqw3W0n3HVBEIm3XeRrqXyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2397
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2020-03-30 um 11:24 a.m. schrieb Alex Sierra:
> This reverts commit 6237cb9febd7d61780d281e7141e12462c81cfb8.
> Due to Loading driver failed at "*ERROR* ring sdma0 test failed" issue:
> SWDEV-229211

The Jira ticket is not visible to the public. Therefore please include
more information about the error in the change description. At least,
which ASIC is failing.

You're also missing a Signed-off-by line. With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 9bd965e88bd9..a8c90d83a9ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -62,7 +62,6 @@
>  #include "nbio_v7_0.h"
>  #include "nbio_v7_4.h"
>  #include "vega10_ih.h"
> -#include "navi10_ih.h"
>  #include "sdma_v4_0.h"
>  #include "uvd_v7_0.h"
>  #include "vce_v4_0.h"
> @@ -732,15 +731,9 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
>  				else
>  					amdgpu_device_ip_block_add(adev, &psp_v3_1_ip_block);
>  			}
> -			if (adev->asic_type == CHIP_VEGA20)
> -				amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
> -			else
> -				amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
> +			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
>  		} else {
> -			if (adev->asic_type == CHIP_VEGA20)
> -				amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
> -			else
> -				amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
> +			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
>  			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
>  				if (adev->asic_type == CHIP_VEGA20)
>  					amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
> @@ -791,9 +784,9 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
>  		if (amdgpu_sriov_vf(adev)) {
>  			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
>  				amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
> -			amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
> +			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
>  		} else {
> -			amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
> +			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
>  			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
>  				amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
>  		}
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
