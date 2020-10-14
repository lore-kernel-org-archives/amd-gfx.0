Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07C5C433E7
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 15:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CFF12222C
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 15:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IC0xnt2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFF12222C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1AF06EACE;
	Wed, 14 Oct 2020 15:46:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC05A6EACE
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 15:46:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLmjLbkGpTZoPiw0OFVDyTOQsIS6LdHfQ0xEK8+N7HM0E9Zw8TvtT2p3RROMLGRweebJZYGkY86w7DdUZF931ZnF3qxgNLTDquYxCR+mSJwWyrzhFfw+/L154nzWlO0zvX0VPlmdZiy2qeCwQEaOr+ixxIaZvoIiHCCDkQF5gSE+48Jw9wD/72eud3yYYRhpR2fX7YE7ZZXeN2+Ucs0iTl3tdDQKBvOVWJ6tihCnzPDRb/vNG0taVoQCdjm6r1l+UlR0C55GBlor730jZhtB6J7lVIi/uLCBxWRNbiYcavcWapl3vi1okd/wNc+I85Z3euoYJa6wVUqCA9OgN58Hgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjo5HNFTlMjMQZ9II73OV1ZcI1vtbes+V5Jyp++N/uE=;
 b=SOya77/FPYnrZrJfYbT9qtaTkuviPSxmSMNBfvDh/r6AljiPB+Qqq4s4dUhKBzLBigu+xX9cCopalMzxs93kFPiLhfyeItjZI2INhcadXxG/anXHkGeUpJ/aXO5hM+sDaDf7YOy8sJ+UN4xoU71GPwbNwqMibruDmh2eVO/dY65Re/HwkCZl0EROk2V0p9/ZPJFz1RxDnERzmEO9ryx36e/a+Gq3t+QqiGBxOytk5OWRPHX4CCarUcAlDzfbK4ed6XZV4p+RAVvId+DFetvKIR0337010VrFXyoOWG0Pri3JKx2DUnvBG/dlTpTMFHpRGFjd1psYm57DpQox8a7Rag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjo5HNFTlMjMQZ9II73OV1ZcI1vtbes+V5Jyp++N/uE=;
 b=IC0xnt2B7FOBR/7sjevcJQAxw87nV7525ppJaCBCPzQNoolhTzlcLBeVO80cS2dmSzjT3XiRoiUHMA8w2dzOdw8fnNowRVgFYT4PduIwVDpJxLQ9uoBaf7ObJXKvd8Rh0iIp3cy14FPOJyQi2hbwPi9zYeqEPkwgUhNQcitZKek=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR1201MB0089.namprd12.prod.outlook.com (2603:10b6:4:50::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 14 Oct
 2020 15:46:07 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3455.030; Wed, 14 Oct 2020
 15:46:07 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: enable only one compute queue for raven
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201014135242.24619-1-nirmoy.das@amd.com>
 <20201014135242.24619-2-nirmoy.das@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <92355f84-4899-69a9-7922-6427ba5a8d61@amd.com>
Date: Wed, 14 Oct 2020 17:46:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20201014135242.24619-2-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.103.243]
X-ClientProxiedBy: AM0PR10CA0111.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::28) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.103.243) by
 AM0PR10CA0111.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20 via Frontend Transport; Wed, 14 Oct 2020 15:46:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c491bc74-bbcf-4080-49da-08d8705843e2
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0089:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0089F3D603734E513D87FE788B050@DM5PR1201MB0089.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2vM7ziDp4LpxeckTcV1elkLjgucHN6fF9V0Nx0koID+S78dDypJ5D37y4C+dxP5HIAqeLaQeNCvFsoAMIoi5orXfSFA8041f/MbxEvQcOE6SbFfQsSjxibysYcXS/c+pD9sScbiag0Y3ljtoI07c9ZzwQwoiXCyHMDVh7HQfocJl2ioHs82KoU9oSrtWrZrvS07303/S0eN41f2OaNWd8QSXqp5flQZ+R2iTt+dG1bMNfUJ0DrxtEcckALfvn5A+ermmjzzF04U3jMmncNCP2JQAVlmfZy5GlRAzXmlR4NdGzJ+LMQABMH+wPqAUWkBg7qJJd6lEz7Yle1cjX9BevnazcAsKc+AYTaxP1t6kx7gfHHkocf9pmz1dykv0lVVB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(316002)(83380400001)(4326008)(36756003)(52116002)(478600001)(66476007)(2906002)(66556008)(31686004)(31696002)(26005)(16576012)(2616005)(66946007)(6486002)(8676002)(186003)(16526019)(956004)(53546011)(6666004)(8936002)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0DoCiB49zHxUZJM6dE8ul7vQtO1dZkNmXeGksOtxTKzTJE0rkOE7XTBQUd0gAs9f2ScVKT9ZZg+NBEa8plTWIxK6OXhHNZO975aH1OOHLki+CzDcgvynsbArY8oFuAlAtvz+NKU4h3fcmo/LPxeHs2H2uLzHUDfl7O/xCbkSCvIZ0CJEneVLoES1T5QZC92zc15ihksjuMKwN+rlG5NN90kA18t3muSiA7IGZ3DRN/W8Hi+Ig9+VZEV87u2Qw4GMm5ME9xzmMDm4iM86ksbgpLi9QXzCYPlqaL0pi6xM3NkPhWliJu6EPh0i+ES4wWyCzeNv4WsKbv1j61JDOZvVBn9aVnMt/iE6u9/6iL/CVDqOzkNYA9zduQd2ofe67sJv1oYaJ9+YBXMrEaiDLV9WA+qIEoDOyQFHgBk29FmUeD0z+IXvED1WkJfWHF2+vnIOZr6V3MTPGhdoJYAWTy/6IvCahwUcotBGPuQbFbj1KBaMqVGMrE3s2u7zWuGsZN5jj4vdlJTFeE6EGO8PV2Xm/8OYP2NqPMocn/NVrfG/4tr5a90ASdc1aXJV/9gHylGqwE4jQeVoM03Uz+pKtsfvx0sL7kN7AFMmp0YNqjmh31oV48E69MIwz0jOH1CAiMs094AmEzzMc6WURyvfhtbARw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c491bc74-bbcf-4080-49da-08d8705843e2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 15:46:07.2800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/FTSXatU+Frvezw+3LI/oXYzz+1i2JKkmilCvD4V3SyhtzgwGb1NjVPGOmhJDtTJ1FY217IkSHnBreVQXL/YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0089
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
Cc: alexander.deucher@amd.com, Christian.Koenig@amd.com, Guchun.Chen@amd.com,
 Aaron.Liu@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Please ignore this patch, it didn't workaround the fw bug.


Regards,

Nirmoy

On 10/14/20 3:52 PM, Nirmoy Das wrote:
> Because of firmware bug, Raven asics can't handle jobs
> scheduled to multiple compute queues. So enable only one
> compute queue till we have a firmware fix.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  4 ++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 11 ++++++++++-
>   2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 8c9bacfdbc30..ca2ac985b300 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -195,6 +195,10 @@ static bool amdgpu_gfx_is_multipipe_capable(struct amdgpu_device *adev)
>   bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
>   					       int queue)
>   {
> +	/* We only enable one compute queue for Raven */
> +	if (adev->asic_type == CHIP_RAVEN)
> +		return false;
> +
>   	/* Policy: make queue 0 of each pipe as high priority compute queue */
>   	return (queue == 0);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 0d8e203b10ef..f3fc9ad8bc20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4633,7 +4633,16 @@ static int gfx_v9_0_early_init(void *handle)
>   		adev->gfx.num_gfx_rings = 0;
>   	else
>   		adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
> -	adev->gfx.num_compute_rings = amdgpu_num_kcq;
> +
> +	/* raven firmware currently can not load balance jobs
> +	 * among multiple compute queues. Enable only one
> +	 * compute queue till we have a firmware fix.
> +	 */
> +	if (adev->asic_type == CHIP_RAVEN)
> +		adev->gfx.num_compute_rings = 1;
> +	else
> +		adev->gfx.num_compute_rings = amdgpu_num_kcq;
> +
>   	gfx_v9_0_set_kiq_pm4_funcs(adev);
>   	gfx_v9_0_set_ring_funcs(adev);
>   	gfx_v9_0_set_irq_funcs(adev);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
