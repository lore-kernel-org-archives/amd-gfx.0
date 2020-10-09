Return-Path: <SRS0=3Gw3=DQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684CAC433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 04:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 068C82223C
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 04:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YxGsjrpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068C82223C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 897526EC21;
	Fri,  9 Oct 2020 04:51:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E9026EC21
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2020 04:51:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaLiES6/ed9sPCrZg/0L+j6auPobMVVeI7P2ixZhU0M1SiRMaesPI0E1Lr/WQr0c9eUcq+xF2d1acgXUlcvMRjyE2qkSrRtHtuJqFSvb+Up5uBRWUEp9IRj4avjTdudP0e4p1/ZwicQayEApWT05g7LnSPlAHbiFwiT4m1WLYu6eVXgiUBXqxiIx9aRIUV6R9acAkxc1KzTqitV4CGVSd1Zcb6Nzxqu/2R3I2yZDYjocaWivYmIvxjEWuk4lH0b956uUZqrFcN9D398Y1NFSGAvV0FqHceppHLJFvbduNPGoEb6PvzhR0HHrK1ofTXaWTxoPIKlD/Aj4vK37g7sVoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubwGkQmSqact3GFzL6L8GwYFcbyJxIC9Mb1NzKPhHgU=;
 b=JhOD/m5TDhOYm4bDS+ORGqi8KlGBWkmXbYI2ZF3ZHK5vKtCPltdTNUxU0vJDB7RNRZ9Z6/zFbeDv6nHt088U1jojRQSn178NF7GEg6A2LnE8EOwHpyF+LE+G/e5CWL1jmqMfrlbTx3aek8ZWdh+iCzdr2FmGow49NEwG8yajlVZNUYW/cbSfGbGZDmzgOToa7VKe49wECIMOgTkCugLjqhwP46MtkWpV4OwITXzW573Dh7djkLKteJHCl/boqTW/s+ZE0xxcgEiLVyxTOIdJIKx4yL45tT0QL6rtCf61838cjdNDk+h1P51rsSUf13F9lsvsb9sKU7ty7LtlFA/3Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubwGkQmSqact3GFzL6L8GwYFcbyJxIC9Mb1NzKPhHgU=;
 b=YxGsjrpaHpDrpUfZKScO8oSm6mVax+a00Te+lqRtT7fM/8DCPigyVQkBZLQwR1JJ+on5qQl7cYB3IDqMi2YeVAqp4mQgR4oTEXgLhS+FvexS2D9lT5Ma+o6sYcmsJeTHAZaQaTIk8A1Qfmiu+cfc4BcTMWy3uDV7z5/lJfeaNdU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW2PR12MB2586.namprd12.prod.outlook.com (2603:10b6:907:11::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Fri, 9 Oct
 2020 04:51:16 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624%11]) with mapi id 15.20.3455.024; Fri, 9 Oct 2020
 04:51:16 +0000
Date: Fri, 9 Oct 2020 12:50:59 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: modify cp_flags to pg_flags in
 gfx_v10_cntl_power_gating
Message-ID: <20201009045059.GA2123052@hr-amd>
References: <20201009044652.10149-1-Changfeng.Zhu@amd.com>
Content-Disposition: inline
In-Reply-To: <20201009044652.10149-1-Changfeng.Zhu@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR03CA0056.apcprd03.prod.outlook.com
 (2603:1096:202:17::26) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK2PR03CA0056.apcprd03.prod.outlook.com (2603:1096:202:17::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11 via Frontend Transport; Fri, 9 Oct 2020 04:51:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7b894b37-d2d7-40b5-ea95-08d86c0ef4bd
X-MS-TrafficTypeDiagnostic: MW2PR12MB2586:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25868FE63BEDCC0FEDC6422CEC080@MW2PR12MB2586.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: REY7i09qX0ganYiZJFCQdFy2wLtXqSqjcRnlVztIQDhRmFo/KTjStUAtknu3Ojl5cRnmDX4QGGJeNQuO0TUYUUYGJV+CyssoPApVAeCErFKsxtHUkIgvn8+elK6Aen/o7Oz44k8PviGrtqAeKy1k+On27rsUsJeIpvISX3d1UC1Jx5WMNbW2UP/WlaCEI125aYziV83uuNvZGX1YGpK6n2iLPxKiO7Ua9HDNwlk4TnuG/iME6KFcUdb1r/duI3uQq/bkVJHCVkWqVX4DF9Idw3fYdvJaQSvtSwkR0n/ayctDuH0Y/wNnmjnRFedSNSrrp7X+PmhmdhHPqjJMPQoIcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(316002)(6666004)(6496006)(54906003)(5660300002)(16526019)(26005)(8676002)(6862004)(52116002)(186003)(4326008)(2906002)(8936002)(478600001)(33656002)(86362001)(33716001)(66556008)(66946007)(956004)(55016002)(83380400001)(6636002)(1076003)(66476007)(9686003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: PCvFmVMuMOxx+KnPDDD9uCfAk5aMiKxJpM5B/KHePywZ2XFV/qS1Aqmw2X/cOV/I9I6y+VirdgyYiFAWj7Dg/27xnyE40yv28gw3G2wdMMUem8HjEhe7hfJnVmQdKWic+Y3qHsGRgDj/6X+pVnRIFs591E6wJ+V7QnOutAxtSKGxo2k1ImDFPDUUWM19LtHW8vAXUQ66eU8rYe6Jd0ARooVERf3SI21enNpzDOoLa6AWhQNeaBWzBqFbkAWLTke9smdoqTPqc4G3ER/B/8+d9fW5TT1+RkbZJfZOLAje7gm6GjoIpSFw0V6+IfkRC840LE65FOEujll39kVdWhm8Q4rULKj72GPF0A24ek+CAYdQNHfOoL+h6Po/4MFw8sIlEVjVMR/GIc8LrLsRJpEh6ghjG1BGXcSDUPIe/66tw/diWk8UCgZCEgF3Z77JqS7+5+BdnYOqtfYmWOr216pk/r0JLoajrE2ohgbACO2GUVeczKLO/XaHXH4AIU4YUNvShw2xwYk9BeSCvPqWQVW9b16ebPf2M5kfFIpRh5do7BsdYyqvNY0bX3wa+TlgFmsCTtLfcu9vfiiJSlmilj5P3nVtqi0BpVCPva4Fj9wGG+3HKt3jgUnSzl1BhG+AgQkf8Ql3lZ1fFbRPpto5FQgQtQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b894b37-d2d7-40b5-ea95-08d86c0ef4bd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 04:51:16.6583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O1JUfBSzflhT3q/sBprtXbQrlN5R9yRXVFt9/1TAOHj7kJ6soZ3qkmJM1AEG1XvgmWrT2oPJOAVLqYI8PlW6Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2586
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
Cc: "Huang, Shimmer" <Shimmer.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 09, 2020 at 12:46:52PM +0800, Zhu, Changfeng wrote:
> From: changzhu <Changfeng.Zhu@amd.com>
> 
> From: Changfeng <Changfeng.Zhu@amd.com>
> 
> It needs to use adev->pg_flags other than adev->cg_glags in
> gfx_v10_cntl_power_gating
> 
> Change-Id: I5f64ee94d8e574293622aa5e496fe245fda17206
> Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 9a8d3f7b7b15..32360023e8eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7588,7 +7588,7 @@ static void gfx_v10_cntl_power_gating(struct amdgpu_device *adev, bool enable)
>  {
>  	u32 data = RREG32_SOC15(GC, 0, mmRLC_PG_CNTL);
>  
> -	if (enable && (adev->cg_flags & AMD_PG_SUPPORT_GFX_PG))
> +	if (enable && (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG))
>  		data |= RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
>  	else
>  		data &= ~RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
