Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E7EC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 13:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00D9520888
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 13:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jGorScCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D9520888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C150589AB9;
	Wed, 19 Aug 2020 13:33:42 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770052.outbound.protection.outlook.com [40.107.77.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 898B489AB9
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 13:33:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMqgKM3PQS9SFdF+qUcXpm50IqsDVegIjuV2y10MQ+WUoJBQJyXNs10G2OZHtpqm/FL/x3Y0vQEFWgpoqNnOXCjYfr4OJTB26u7ePegllJyY4ObWVHlBnMvrKV+1NV9u2ZmPv67JwrFA5tB44cybyTr1vYI9gkt+mPERDniDg37p6tKdn+gwhyRdJASUBn1MUTY81iFTGSGuxSzP1PzgzD2p8LHvf63+peaE5ITh64eB2D51bFTT3otIPkws7+bAt1kNGy/b0kNNVDn+n3o2uI/uRQwN0IQ+vEgJ/pbZqEvQJXPhkJztZhRoMDUD4diGuOn7z7aKVEnLfKmH9s4DaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r01C+ZMawVqWx7f5eYlQFuttZPRMoRX+Yx/OcWulUO0=;
 b=BiGF4vywxmD074NGgj5hU8Nmd3DQUoslHq0uAolyc/vgEKfEJ7mGQqwNfkC7/J8c3Gv0ZZ/WSfWAR/fXyuHVTbDWRlayLWvednFHJBrSnmFgTl6fRUMFYPz+dG1z+JCylk4N8zVh5c4XHZ5/7egcVl7JhX+2/AK1tjMxz4HaVb6xFu4i0PULml7QJbdhfJoQJewerbcrxTEr42Mlnyb1kA480cOGDfzJ6Ay7FYaV+qJ4Ti8CCCf6URAMNRWAEufs1bdqxKDMToxDkvoa/MiaEbBr0DDeE9SguxW4V4MDwA/CNjneYX1ZfrwjphgW+o67VpmQzsP4rfnck3j611U2vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r01C+ZMawVqWx7f5eYlQFuttZPRMoRX+Yx/OcWulUO0=;
 b=jGorScCSSqLy80YFgr6W3CzoWFYSLHosEP9xnarQP4QMfmqPVZZK3zLjJS5H7+KSeeCYjZRCcIXG5/v2peG/vJXgUMX4GkQq0GG7T9CcIcp71T6YGavmqeft5VdngiwQx2X0exlHIccPw6kGGwsECn1GTqI64e8R+zZ0THVbQyQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1897.namprd12.prod.outlook.com (2603:10b6:3:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 19 Aug
 2020 13:33:40 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 13:33:40 +0000
Subject: Re: [PATCH 4/4] drm/amdgpu: fulfill Navi gfx and pcie settings on umd
 pstate switching(V2)
To: amd-gfx@lists.freedesktop.org
References: <20200819095833.11420-1-evan.quan@amd.com>
 <20200819095833.11420-4-evan.quan@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <643f10d9-7d17-1721-8832-c98fa92fbc3d@amd.com>
Date: Wed, 19 Aug 2020 15:37:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200819095833.11420-4-evan.quan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR19CA0052.namprd19.prod.outlook.com
 (2603:10b6:404:e3::14) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.7.114] (165.204.84.11) by
 BN6PR19CA0052.namprd19.prod.outlook.com (2603:10b6:404:e3::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Wed, 19 Aug 2020 13:33:39 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 27eea9f6-0918-4521-2801-08d844447bdf
X-MS-TrafficTypeDiagnostic: DM5PR12MB1897:
X-Microsoft-Antispam-PRVS: <DM5PR12MB18973E59AAA36E3430D932EF8B5D0@DM5PR12MB1897.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ig8v373fe/8aB7Ik6F5d2F3K/k5IApVqXbfHl2kGLcpmP1LlV9w/khnBn7Usgds8cS0/HQ2vNQEQOPVa/oUxQF5Lf/qFRNZRESTZtkuu7y/HVR9fGmf5kKLZRFAGEniY5ggbxidLQlOKaQnc14cq5y7plyQvxGY0r19xs48Iw4pVWbSyuZecgbcs2idbWZNq1uWxDNx4ynAYkVdMbNL60cxC4EmcsA3kk/AMIi8F7133cUTesg3nvaaKKXdKZT4lasUa7EPV9dAF0i0LXfoNnEzX+edV5oOul+OG9nsWSVGRn1F46kW9Kv1GFfMoaeFYn3Wqqnrd2uTk1NxvWTWwq0IQl6Th/Lrrn3+uAVH0z9cQGA/l3eSd6xuP/QUPbegC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(6666004)(16576012)(83380400001)(956004)(2616005)(2906002)(6916009)(53546011)(8936002)(8676002)(6486002)(36756003)(52116002)(66556008)(478600001)(66946007)(66476007)(316002)(31686004)(186003)(16526019)(26005)(31696002)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: PtgjS7i+XzPwqSklrF8JXk07I5IEK//V1WDVd8RKsRa9FYdAZ6Ask1ldJfcbp2zE0WdwyvMIxDXUF9kWD4EbV4UbvIN03o7cguiUWvJII1lq4uQ75xONxyEBLBvbYLbvfwGndTkAV4e5wVo4pDtarQOpYBzoIyiFTfDq4mI8jSuY7AL7lTjO6MSEWjAR6Epl8iJnHKKPi6NsQLfqBBwxXFoPKB7cyV84B4n2ban77E5khfTKUyoyH1E/48Z5FOQoOgvq4htKOhS0Pwzv/0/UKNG9TYZCBZDp8qLk26elFPylitv+rAzygXdVK7aoGW5quQCpBAxnIIjK9mBFL0mH+9fw5IbywIyM4BfUQPiI1cn+pk82RIHoLGcgwL79T4hQEkqf9174WO1mV6E+nnqGKiuUN4WRuWJV3qGnhgAm34XiE9hR7tJmfkcOdNJ7iOQjZ474QohFT9fxDRufEgPEinpURET1AVAnYHUCToNqwJ92XtBavW6IweboJ/PFwE+HwRnavJtuTgupgtr/2VhAl6IXS7quFlLSwWPELwVLQO2a6puwSNnguw5SDKSp40Vb4ycId+cNw4jm2GotNMYUuQ6ldhe+1rof/LCqVdJ36VHV7dxpL0wXFDPXAvAP3MnKRgOxt53diBWHWQA/OOoq6g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27eea9f6-0918-4521-2801-08d844447bdf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 13:33:40.0931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gdQw9nMhYpBC3rQheHHQZMYB+wam6KMx0mB2OajcNpKT7B/rG5pLdti1YByIX0OR7UHp0TcUpGPSPC5HHetOTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1897
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

Series is Acked-by: Nirmoy Das <nirmoy.das@amd.com>

On 8/19/20 11:58 AM, Evan Quan wrote:
> Fulfill Navi gfx and pcie settings on umd pstate switching.
>
> V2: temporarily skip the pcie ASPM setting considering the ASPM function
>      is not fully enabled yet
>
> Change-Id: I8d746d4c25f890665feeffddf64164ed2b1f5ccc
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/nv.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index d07c84a7543d..36e59c735a05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -694,6 +694,23 @@ static void nv_init_doorbell_index(struct amdgpu_device *adev)
>   static int nv_update_umd_stable_pstate(struct amdgpu_device *adev,
>   				       bool enter)
>   {
> +	if (enter)
> +		amdgpu_gfx_rlc_enter_safe_mode(adev);
> +	else
> +		amdgpu_gfx_rlc_exit_safe_mode(adev);
> +
> +	if (adev->gfx.funcs->update_perfmon_mgcg)
> +		adev->gfx.funcs->update_perfmon_mgcg(adev, !enter);
> +
> +	/*
> +	 * The ASPM function is not fully enabled and verified on
> +	 * Navi yet. Temporarily skip this until ASPM enabled.
> +	 */
> +#if 0
> +	if (adev->nbio.funcs->enable_aspm)
> +		adev->nbio.funcs->enable_aspm(adev, !enter);
> +#endif
> +
>   	return 0;
>   }
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
