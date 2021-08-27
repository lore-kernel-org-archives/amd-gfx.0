Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C9FC432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 08:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F47F60ED5
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 08:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8F47F60ED5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E56E6E905;
	Fri, 27 Aug 2021 08:51:29 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C90506E905
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 08:51:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQHlb/XSw9vK3RhUPpZH3eWbIWBCB0oLCZxWT7eATzSif0QOf5JeL52Jj+XEfewKt9Vkz7mKRLD8XCZpkE27VQw5wW2cWIEmV2trbmwkpK0TfFRgrTROYSPdIF4jEPdRHXU1pcE+DaH2mR7Fq+c/iIjGTOSsTRg+la47glpt+4FHEGX3w77sf3Fz65znsB9mlULiNP9NSucKvOOGaLjxIwTy5wc9gsEjp/y8AYEH6/GKycbF2RHWQq6UxvZwJmoJRDTuRehIxAnqwpkdO1XzuFaS+U4pbioHgwkSfhvW+/vnfSqK09xdgm2mYhqntk45Wj2i2TFEczaGBzQ46vVMzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZ9r1fW+WNnRsAyrY2VyJPCnoRpqYSs8Kjb3r+WAba8=;
 b=Gg+RRnClchceZTlUaKrua1qBoPF/seHvG6N7Z66DMhNTbSahhz990MkQXMwapSckGYy8u4WrO4jMbV42EzUqtsXt/kvjJx1OlGOoVB62iZ8/qXr8m22spUZclDIC+vrx7SGZh6Dl4goW2FesA0zB4vPjybwYwJ3930ysNyYbRSCOaIHPtGRdJoYJY5lnq35WjAeb8bYGt5hHUCkEsjw7REEl/Uz6/GdmxlqA6NatBPzOqKg2K023S9rUXffVj+3fubUk+F5SBBoynFBfLVbpmhaNOTO53DDC6V13YqDZhJoQpRZikg1SCl1+yd0RZLHqFGxmvGb55pHUgnz/LW5/LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZ9r1fW+WNnRsAyrY2VyJPCnoRpqYSs8Kjb3r+WAba8=;
 b=miq9/927PFnRpuScy6Xc4kVdxnH9lTzNgV/rbcnaqtV8qCJZ8rGCznaN+oTYrp+VtVeapggtcUaD7JgqwQL4oRKaTYqqf3YoaBYzJuKVpvaIjRECY8BqqX5lU8avU8Px3Cr6Ta6ZXVwNes+JZk0Gqizl7Vfqt+yNtPSKCkZ6vws=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4848.namprd12.prod.outlook.com (2603:10b6:208:1be::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19; Fri, 27 Aug
 2021 08:51:25 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4436.027; Fri, 27 Aug 2021
 08:51:25 +0000
Subject: Re: [PATCH] drm/amdgpu: adjust get preferred domain policy
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
References: <20210827084549.166223-1-yifan1.zhang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e2c78532-0950-e2fc-00ea-b55a36f4fe1d@amd.com>
Date: Fri, 27 Aug 2021 10:51:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210827084549.166223-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: FR3P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::18) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.21] (91.14.161.181) by
 FR3P281CA0055.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.6 via Frontend Transport; Fri, 27 Aug 2021 08:51:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b2fca2d-6e62-4523-78c7-08d96937d992
X-MS-TrafficTypeDiagnostic: MN2PR12MB4848:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB484813C964BD41527C476E4983C89@MN2PR12MB4848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qagmUmHPU1+gn7P5SoRHGp1IrNI9t+vHOD+v0eAK8eP0btOaNH8CVYuRfgiboH4o60wZuZGDW3QHEfdjDSPYAObx2o5BHH3NuU9HE8TlJuJckIiOT4hQOK0HsSBULZNcRi7Xf7BSpbrq1Tyy0mhVCRpz/Cgm19ebZlW84+a1caMD56I5YCdsSDMJOR2CYZvdm9zix7tv9+K2bPoendt+6NhHiNQ/PFwrq9EX6XiP4rJDz2aX9wNKYlIGwkgOe/TVxqxIspulo7Bx+NV4fLteEG6jkWKux4p8oA5YjkLzObSAxo/ki1dpk79s8VDInLJtiBcafcBBXI2+vlTeRridYSDX29//UdrAn7rAN6Qbdacdx39vgjx6+LQWaBsJSbGyTzoEzCe1diNsLCcQNi9OaWwErhROOy4QWsCZKV+RG53YBIq8t75Yc3589m94kSpAfNaGIhzGHRPwEY7UK95ViZ0wiv+7FZznfOdnIOTnbC37NqR2YpHI6CUkAFEHIerAgfOjGXNG4UCCDpa991X1AVdp2QT/Z07MlYTY4yRFW/YRCC+S1d6kyglJ9wDSl/N6RFimmVbG3Xaf+4dZOzPYkcsSxOaTHU9GqSqMMALDEEyMH0w6xPf5tjW51eXagDzDELNgsxjUhD0CqG+tWcbmZWLitXDjr1iT/iNsF0LqzLv5wl1fFsMLDchLtq4kCp1jd/9QLHhe39xDk1vzXqJvo+tUb93ev5BCMetlM6ZBFZLRnj+oe9O3JPFzD5RBS4Lz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(36756003)(86362001)(186003)(66556008)(4326008)(38100700002)(5660300002)(6486002)(31696002)(2616005)(26005)(66476007)(2906002)(16576012)(478600001)(316002)(83380400001)(8676002)(66946007)(956004)(31686004)(6666004)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG1iZXB5cGtZMUtNMmdTc2RsS0ZnaFZteU9uOVl2THA2QkdESEJhc2dnOUV0?=
 =?utf-8?B?dkVEeWJHLzJ2M3lxZkFIT2J3V0g0WmtrdndVTDdiVVZZYVBUZHpKTVBiYllH?=
 =?utf-8?B?VXlldU5CT2JUL0xYMHg3LzFXNjlORXF5dzd1NVpjb0MzTVdxVnFBV2J3d2VL?=
 =?utf-8?B?dU1sNStWbjM0SGtXYWh2MjE4Y1VKbXlqWDFlSGMrTUJlRHNNMFhYdTN1T3cr?=
 =?utf-8?B?T29lTjVxa3NIcysyNit5SXdwaE9xNjNkL2ZybTJZT0lSN1JzL0RNLzFYaXFH?=
 =?utf-8?B?dlJFNFlLTUcxdEVpdUlabTFzTi9uN3p1UlFUcFI4ZTZsNHpvQVRGRkR1Z0h6?=
 =?utf-8?B?RC9BWmRBMm9FSHM1UUNiWnQ0K3Z5ZXJad2pkMWdGR1RzeEJnUERDMnFpS25U?=
 =?utf-8?B?K2xyZUJVZUNaUE9KWU1Vd3NEZGUxRW1JNFRBYmRyK1ZpRS93ZEhlY2dnbVV0?=
 =?utf-8?B?aDl4cEZ5ak82Z2FzNm8zeHVxVlpVYkN0NE1OcWZCMTZLYlk1TUc1Q0dwbjd4?=
 =?utf-8?B?K013bk4rS0dxVi9wNmFobnNyVkcxcEx5WWl2OUV5RUlKNWtwenN2bWFWYzI2?=
 =?utf-8?B?VVVOVW5FT2NXR1NpdUtlcnpaYTdDN1JIN3ppeG9meXN6VTlYdHgvVDc1OS9D?=
 =?utf-8?B?R2ZLdGdxTjlrb1U3clQ2bGlsZG1oMjR5YVVxZzI4Wnk4YU1BeEhjS09VTzZC?=
 =?utf-8?B?d0xJdGRONlBFS2lsZGdFdU9pKzBtSnJlSDVPZlczUWMySmo2cWk4SFZjS2Jl?=
 =?utf-8?B?MXppS29CdU1FeFNubUxLYUJFYUszWkd6VmwxNXA0VTlFSEVMSStnQjh3L3M5?=
 =?utf-8?B?Rkk1WFkwa3hycG5MM2g0aS9sMDZlMVExTVRBQVFWWk1mOWhGZUxuRDFZcHBo?=
 =?utf-8?B?dS9yaldRYUxVNk1TakxtNlJ4UHZOczFTQXBQeUcvUDdZSlI1bjQ4OW5CclZt?=
 =?utf-8?B?QWhjbjNhSWpNRVM0TW9sMklpMTR0bGZpY0F0dDNKQ0xjKzBmY2xDRnd2WnRq?=
 =?utf-8?B?MUdkTFBCZkF4eEJrNlc3NG90SjcvSG4rL2liZWxxNDZEUnBtUEw1aGZWYzEr?=
 =?utf-8?B?MmpHNE10R01xNTc0MXRiTnBIRjlFQWdzVDJOcHJKSHdXYXpERGZGSStGRzhw?=
 =?utf-8?B?OWNFc1JFUzEzVHc5NVhVakpoM2tpZU16cFZEQVp1NHFTUW9Fa1F0OEh6Wmxh?=
 =?utf-8?B?b3ozM2ZBTnk2Mnl4eTFlQS9XL2hQQTRGSjRVenJ1d1E3SWxlck4yNTlybGxp?=
 =?utf-8?B?MHRJTU83YWhmTkVrMEdTb1ErMWRhWFJKM3Bma0UxcnI0TjFDUzNIWWxlajNV?=
 =?utf-8?B?SUdoODVnU2NjSnZ5SWRIRDhlWG9nejNmMGlZSWczUUZlMU00OTd2Qk80Vi91?=
 =?utf-8?B?RW16eXZucW9Pa0xlQkM0S1pDZXEwc2xDQVRmRjBnYUxHSktTRkQ2RGQ2eW9s?=
 =?utf-8?B?TTBseHhlK2NocmVWSjc2OFlZNmd3Mk5OWDBRa2NRSGpZUVU1anN2QlNJbzlT?=
 =?utf-8?B?eDVsVUpBaTMweUNPZFpNZ3NWUFY5MFJuZjFNTEVhM0Vpbm5kcHRIc1ZjbWJO?=
 =?utf-8?B?NEcyTnI2TSswblBrcERmWkN1bEI5am5URWJidFFOc3RwWlB4TjFuYnIyNlJO?=
 =?utf-8?B?eFNNdWZqcVlrU1FrV0NITHM2dUxnWXFEL2hnVUNPbkFrK1QrUWMrcVZacXdC?=
 =?utf-8?B?ZXNZa2I0QU1mK1lIMnlBRmtFVGlmS245cEV2MlFpMUx6UmI2UGpRd09aS25N?=
 =?utf-8?Q?co+v3B8kDs7nKGnuLZigIAw2m5zCyeI5ex7w95l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2fca2d-6e62-4523-78c7-08d96937d992
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 08:51:25.2733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akTEqtdUSFeslAUviphN4W9o04f1TcjtisSqdZIvV09xSXnQDUYeguiXWzGM2V0I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4848
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

Am 27.08.21 um 10:45 schrieb Yifan Zhang:
> current preferred domain policy is static, which makes vram > 256M
> APU never get a chance to allocate system S/G framebuffer. Change
> this policy to take vram memory pressure into accout. If system
> support both vram/system memory, return the preferred domain based
> on vram usage.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 65a9b23f0a46..ea3b084e3c3f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1530,7 +1530,9 @@ uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
>   {
>   	if (domain == (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)) {
>   		domain = AMDGPU_GEM_DOMAIN_VRAM;
> -		if (adev->gmc.real_vram_size <= AMDGPU_SG_THRESHOLD)
> +		if (adev->gmc.real_vram_size -
> +				atomic64_read(&adev->mman.vram_mgr.vis_usage) <=
> +				AMDGPU_SG_THRESHOLD)

Well apart from that you are accessing a private member of the vram 
manager and have messed up the coding style I don't think that this is a 
good idea at all from the design point of view.

Scanning out from SG has some huge disadvantages (unstable on some HW 
generations, more walker overhead etc) that we certainly don't want to 
enable it unless we don't absolutely need it.

Christian.

>   			domain = AMDGPU_GEM_DOMAIN_GTT;
>   	}
>   	return domain;

