Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A31DC43331
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 19:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 009F3206F1
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 19:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QhqrRWtV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009F3206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B686C6EA72;
	Fri, 27 Mar 2020 19:55:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73BAE6E037
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 19:55:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhJRnuXuuXKu24b1q6VDd3LkOxIyZ+6oCIj8l1xUjiSr+QqpwqwLRPc5/u/Obesd9rrGQ7bGTt/IK2z15GV2XOuh0hZl2lFZIBjqBGCHrzAbY23HNs0IauIIbkANNU51k92bpusaGeG3IbzF8jWE+UAkUXn6vyH7hzjDrXc6IGYeCpYjOGnMAoGHx2xptTCPrdZvioGTTBWY8Y59vQAvzT785rkQkMWK/7D7SIAuYHQRM7GG3zbEssmVQq/iMiamyRC+kfPSj3ejvjZiWE7aBnBD4SW3iFtcX3et0wRry7OFo87lSAwBqe9sTFh0jswU0UAvRJHBEPBpQpcymfF45Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlpxK/OqzvIa6tBM7CvdNq3pWq+YgR8opoXOZ0qWavA=;
 b=VIU05qMnNEvZA5iCEgi00R6nEYgFfSsjXcVF7K2s1MccKpmr9mDTW7yQJOmKJPHdfeyvt5Op/XEwTlbExcSXQBOXjs/LJUx3XJh6k0HoOGxcbG773Z9qGOz/JujmyNNZZ8QbHajsEziEJhC5EDgwtv9/sJokuqAAKf4CO+HvJd2Wpst6J36BS6OvfI8L4j08yODeEVGU6DSnU6OTiLeNI1pY8IXYJLeqFM91NCr9GrUAbeVfD1VAyMiy/LZjDTILOUMe8bqGc4A2qYdRIreiU1h6p/q5ap7l7qZo9OIo4oe81KJUGBN89spBjZDostgbw4BQD2rPCgDS26PbkRQIcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlpxK/OqzvIa6tBM7CvdNq3pWq+YgR8opoXOZ0qWavA=;
 b=QhqrRWtVJPPLqEAk2GoIgVvLu1yUKZxInDUpH5Ec0a4LVnLAPwi92v8g/5QwtksBrZgdlXLWEuqk9tlsYFg9dxTVMrrLI7Tw222odSjgpQ+SS1qwa2duSrwGlxl9Qyo8apjXGJ+FOAQjfd1Mde7VVUHhDKb1CkLeOSdv/DbywJs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2589.namprd12.prod.outlook.com (2603:10b6:802:2c::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 19:55:31 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 19:55:31 +0000
Subject: Re: [PATCH 4/4] drm/amdgpu: replace ih ip block for vega20 and
 arcturus
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200327193747.8520-1-alex.sierra@amd.com>
 <20200327193747.8520-4-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <fa452e55-73c5-d8d1-0fa1-c7464866feae@amd.com>
Date: Fri, 27 Mar 2020 15:55:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200327193747.8520-4-alex.sierra@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::27) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.147.81] (165.204.55.211) by
 YTBPR01CA0014.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19 via Frontend Transport; Fri, 27 Mar 2020 19:55:31 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 559b347f-2ae7-489f-2df1-08d7d288ce5f
X-MS-TrafficTypeDiagnostic: SN1PR12MB2589:|SN1PR12MB2589:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25892AFF1175DF0496CC792292CC0@SN1PR12MB2589.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(66946007)(66476007)(66556008)(16526019)(44832011)(31686004)(8676002)(26005)(81166006)(36756003)(186003)(52116002)(81156014)(8936002)(53546011)(2906002)(5660300002)(478600001)(86362001)(316002)(31696002)(2616005)(16576012)(6486002)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2589;
 H:SN1PR12MB2414.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jm3dSmebPX8bhfS4wgBzkTrEvrzysBbaMvdCqKzYEUjmc8+Qh5gvYuB0sVKGVvIfWgk9QMB0Y+bfDfZJUW4x1Ntyi+p8RXB0fOVK0ZhRuF2vuX+KtliJtZ+dD8oeTnGvh8vWNGSeHDG8tf0c5uT0RRIX2gjzRvMT4jnkMRMz2m0gDtKlWylEEoN4Y00sbyMZ4rfIJM8IjSaFARsCN8n7RIiJmc0SEPQTt1CFLPd1NYQb0trxe/+sOBysYV8yBLOV5+gzYLuLR5B35A0Vs4ecvK1WH/p3oySZkT7wTqFR2kF5gRPt2BSbQEA9ShEDi8VLFQoy1sz0NWUdTds+agYLaGfNAeBdWUEecb/ZkuczBtOuXXFYSELeeCQBypo/HYadvSTqG/CE10eazrntRVAvvUF030IrZ3vjhKekCQoedtVjtRThobdEx8hxaYLHfUHQ
X-MS-Exchange-AntiSpam-MessageData: 1XBqVE0eWPo+v73cLqiNX4vFJrrXwkIFcNGNrPOOTs17BMa4m1xnjPdq/PSixDJfkO57K8Kp89QifI4houDENOCZr1VR2Gnx1Tu6YCI5zNdwdaVBronCKUGqq2KSIhZVav4MooufMNj0W8HwhDt5rA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559b347f-2ae7-489f-2df1-08d7d288ce5f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 19:55:31.7572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vi79r33gPUIYaR1BrMeflGnbH5SzBLelGRx3Cq3kjFpX1xUPz2Qn7xRZ3PXtmRG5ep8JEnFJU9WA9dAZzZyciw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2589
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

On 2020-03-27 15:37, Alex Sierra wrote:
> [Why]
> Vega20 and Arcturus asics use oss 5.0 version.
>
> [How]
> Replace ih ip block by navi10 for vega20 and arcturus.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/soc15.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index a8c90d83a9ee..9bd965e88bd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -62,6 +62,7 @@
>   #include "nbio_v7_0.h"
>   #include "nbio_v7_4.h"
>   #include "vega10_ih.h"
> +#include "navi10_ih.h"
>   #include "sdma_v4_0.h"
>   #include "uvd_v7_0.h"
>   #include "vce_v4_0.h"
> @@ -731,9 +732,15 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
>   				else
>   					amdgpu_device_ip_block_add(adev, &psp_v3_1_ip_block);
>   			}
> -			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
> +			if (adev->asic_type == CHIP_VEGA20)
> +				amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
> +			else
> +				amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
>   		} else {
> -			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
> +			if (adev->asic_type == CHIP_VEGA20)
> +				amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
> +			else
> +				amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
>   			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
>   				if (adev->asic_type == CHIP_VEGA20)
>   					amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
> @@ -784,9 +791,9 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
>   		if (amdgpu_sriov_vf(adev)) {
>   			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
>   				amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
> -			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
> +			amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
>   		} else {
> -			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
> +			amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
>   			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
>   				amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
>   		}
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
