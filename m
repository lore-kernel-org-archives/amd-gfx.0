Return-Path: <SRS0=hFGi=CM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75B5C433E2
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 06:35:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DA31206EB
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 06:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rxB2Kb4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA31206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 250B16E185;
	Thu,  3 Sep 2020 06:35:21 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770052.outbound.protection.outlook.com [40.107.77.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8477C6E185
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2020 06:35:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTd2/Znj6T9lBZPq6lwYm1wHWtjY2OFaCrfhJU+3Khw7pUbu6wjCQo13+AXyYJNC3C5HjMFUocydTv9WbZn16mSBgGUgVIPf6sNudj1lkZXJkE5QoQ6CmbZj+mrJUOjTNC7I+Vm4sENfkyj4ULGBveuVlPwY8ZzRz/sfdSoOHt77UE5Fc7/6sQCt4O4FpnLlXTDYy4M0KPwM7fIGbHbJPGflh0Kymt2bIG8mJG8Sjhz0KB967+L1lho56t0fF6V0Ov6QJwoZDv3W5nrcLSRSWnmYCRSIeJ+lVwn7ym7ArbaOUMTtku2zi0B2qSW+o8wUhxClygQop4rScPCAibRxUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ej9xUuZaV5bpqHIUSrGckm0LHPUm3YCYDPjBm9PAQW4=;
 b=JMn/wUe35Ii+2mJN5Mo2y7x97T360gfDMVgdydg0JVk1CqPjMPkzqcuk1jnsrQ6CplvYsiXcIqY2toEv24oiTBEzAbH9SwfUZBhUmw4RTLLLvva8qVnPqxYZ7d6n3NnUICBc0oS/qJUdovRCFWD7zNb+mIDe7G2OM7S5/XjBKC295viH+SUCpO1gCws++WsRWUX2ZLge389WUXVrQu+oeecjzCqw32Pwq5qcBqfkDJHXjxG73KqSWSTRBqrLCilrdoUVAzprMXJAq2X9A1iIrVLH5G+3pv2DII38NW9Te/pOZRxGQ6bBWNP3Xl6IxZIsT96NX6WeZ8llnFehyDBhOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ej9xUuZaV5bpqHIUSrGckm0LHPUm3YCYDPjBm9PAQW4=;
 b=rxB2Kb4tkGFkBNEmEwas+X/JJl4tbEPx7FfrsroFwmHst486YF3oRWMMmgxqBEs3RX8E/JFu20HMIDgyIw/ylnFhaOIObZqKRtOXT9N64psFSdR8aZq2GdbAO4/lXwPZis5wtFzHD2Gjboi0HuLWqumCek6fJspM8oZwYkdG3Z0=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1184.namprd12.prod.outlook.com (2603:10b6:300:f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 06:35:18 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::e881:6ca2:c1d7:48e6]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::e881:6ca2:c1d7:48e6%7]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 06:35:18 +0000
Date: Thu, 3 Sep 2020 14:34:12 +0800
From: Huang Rui <ray.huang@amd.com>
To: Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH] drm/amdgpu/gfx10: Delete some duplicated argument to '|'
Message-ID: <20200903063412.GA2470278@hr-amd>
References: <20200903021756.316132-1-yebin10@huawei.com>
Content-Disposition: inline
In-Reply-To: <20200903021756.316132-1-yebin10@huawei.com>
X-ClientProxiedBy: HK2PR02CA0186.apcprd02.prod.outlook.com
 (2603:1096:201:21::22) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 HK2PR02CA0186.apcprd02.prod.outlook.com (2603:1096:201:21::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 06:35:16 +0000
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3018e605-d016-4b96-d194-08d84fd38620
X-MS-TrafficTypeDiagnostic: MWHPR12MB1184:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB118434475CD809B4D6667BD6EC2C0@MWHPR12MB1184.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:202;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZB9WjUU+mRde9+6am2oUjwTJrfmert7I0nZzKo6eu+DErc13bVTBcZ1rvgB2b9MyKKFJiGIUinpqyf52mcdZpfbNHJRTG6DHDvMEcY8VPirRBEbsMnjpJZ6gx3R9oezPdU7lbn6+lTN4oLVfuo9KwMU0vPLXUmSmAErsa+T4b7fdsa5xYDSdHuTM3UnaLbpow4HMVA0z/VZjwu2bZdsyEbwzHOxDEE5S/lQNiXjIBsc5/mpahaYRhBRleXCPJFrm2X7Os5AgDw0Ml8j8pGd6BSz/VACvu9hDZgOBm2GJRp8ATsEsiQ8ecUEj08nTHYASU1TM6vLdJbrd5pp4PF+J3oGZw4dYV9I+7H+fMd7JITw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(7916004)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(478600001)(186003)(2906002)(5660300002)(86362001)(316002)(45080400002)(26005)(66946007)(66476007)(16576012)(83380400001)(33716001)(4326008)(6486002)(66556008)(52116002)(966005)(6916009)(9686003)(8676002)(1076003)(956004)(6666004)(33656002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: fG2PkXUZ7ueZHqTzdCCrsdHBO+4n9gOt/xLyb79ZL/F3S1Z9o4MdK/gkZOWKkrNvjrnVlAQVsmo2gsvLL9bFxYrAVHXyU2Gp85z3Qjgdjp8iDf79bZcLcrfvtsBJ1/Vb5AAMvBywfv42rYmiPoYN+WxsV99usbDNQyLrqtn8V89hSB6AYhuvYW4a5iulF/sUZAlkACNNnJTMVSd8kMkzqI9bRbDMSzQswE+TntFNc8GlVr2RKX/QPrS9mQKu5ONnHDshAgS5U1bonNEPn31NrwMx9AIsIPwm4C9B4q4xAbHeDhAWmf3rBL6t9kUIV7c2xjUn4FwAhvW6w/IRjb6p/SpIDgyb8mLFEDaEzOTH6unb++Wkabm7itOGbPIcmjjKvwuhBaFSmrydiYiVw3LhIIw82JyCkEfpXNFdqE6FaIX8jz7LzDFSwtFBgI+/+dmUC/9X/OO1sPbaxR5fwiM5EkrWofnRBIKr2IuoeUA5JeiV4euVRXLBT2ee5N94AHNwr2EBJ5yIhe5OC+nWPfc22c4nbrQwIj/x9hbyX8MQNMHNOeHuHMgEWqPewZL/ptmwiiTw74/oh/Eq+GytpgrpdTdIO1uj9qTdOItZirHZZCiylWbkowQdkTvwAi8na0q8T28N6GYXAkrnogKOR/kALQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3018e605-d016-4b96-d194-08d84fd38620
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 06:35:18.3934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/quau9FuC3boTaVpNXkRhOvBrGqFwRXB/lU75LVqrVAPSQfmfoTQqUDSGi3d3npmfXhzTzZm+ISjAnLxigNsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1184
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Sep 03, 2020 at 10:17:56AM +0800, Ye Bin wrote:
> 1. gfx_v10_0_soft_reset GRBM_STATUS__SPI_BUSY_MASK
> 2. gfx_v10_0_update_gfx_clock_gating AMD_CG_SUPPORT_GFX_CGLS
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 2db195ec8d0c..d502e30f67d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7055,8 +7055,7 @@ static int gfx_v10_0_soft_reset(void *handle)
>  		   GRBM_STATUS__BCI_BUSY_MASK | GRBM_STATUS__SX_BUSY_MASK |
>  		   GRBM_STATUS__TA_BUSY_MASK | GRBM_STATUS__DB_BUSY_MASK |
>  		   GRBM_STATUS__CB_BUSY_MASK | GRBM_STATUS__GDS_BUSY_MASK |
> -		   GRBM_STATUS__SPI_BUSY_MASK | GRBM_STATUS__GE_BUSY_NO_DMA_MASK
> -		   | GRBM_STATUS__BCI_BUSY_MASK)) {
> +		   GRBM_STATUS__SPI_BUSY_MASK | GRBM_STATUS__GE_BUSY_NO_DMA_MASK)) {
>  		grbm_soft_reset = REG_SET_FIELD(grbm_soft_reset,
>  						GRBM_SOFT_RESET, SOFT_RESET_CP,
>  						1);
> @@ -7449,7 +7448,6 @@ static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>  	    (AMD_CG_SUPPORT_GFX_MGCG |
>  	     AMD_CG_SUPPORT_GFX_CGLS |
>  	     AMD_CG_SUPPORT_GFX_CGCG |
> -	     AMD_CG_SUPPORT_GFX_CGLS |
>  	     AMD_CG_SUPPORT_GFX_3D_CGCG |
>  	     AMD_CG_SUPPORT_GFX_3D_CGLS))
>  		gfx_v10_0_enable_gui_idle_interrupt(adev, enable);
> -- 
> 2.25.4
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cray.huang%40amd.com%7C8215921a33564f5d7eba08d84fb1e505%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637346973382780465&amp;sdata=91fBV5jvWLukcSerSI8WPwWc4bzWDJb3ZW86qDJ9kwI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
