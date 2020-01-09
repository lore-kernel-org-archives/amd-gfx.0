Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8887C32771
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 05:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870CE205F4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 05:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1I2zp46k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870CE205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F0FD6E394;
	Thu,  9 Jan 2020 05:34:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EE5D6E394
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 05:34:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHY9dsaUVKrm+n4O4kjpmqWYWDYatp8FLNo8tR55sZyekuN9ehtRk+zuDrz/qeDau2VyWYYRurxYAc8TnYCXH7/tDRHBSZlXepRfeHpy1rbo2nOBcFdR9T7IM7n2W3cL1aYICbcjqFvyHDhPgEPy1MZWOtdtyxNybQpjVgGj9b00jy75zocLr8yE4y0DV1Ilb8e7lgY1bDJM5QaaGtWskYwF8w6NoAbYGtdG5aldtXpemnvAKejkiVGj+7/D93CruMTTVuDE6Omb0a56Wf5ITtqtUz5aFzv2f0FiUNnanXzh5BHFJbwhEO9VLFROE8skXZ18iVHCVukRMxxCkLkRpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szJ1pjvQnsKJCS1Fxg702KGREck1b7mPG58y7WiAwTU=;
 b=mlxHXbFYfJNkVNFRF70+G7kEaJ2abB77GzS2WSQbKwE+QzrI7lIAv3p7rpPOws7hXV7k+BMGHovqoAbXl2ip2TtkKiTU+gnI+Vhmq1xd7HRDoAAnEUe3I2z6uNZmZ4unOeQmH1ha9dMz/DEp2Ry67UcZBJ2pbyY/1jHMtlYmw9zjCzG1W9z6c9KgSnvmKRsGYzzR8/PcHsTawRR5R962AqBmWsZs4AIUbfEkxbWbut0uwX2QUAr9RZYwFvUhtotCclDQATKQVAqHBO2kWWXZowYp6ALC+d2eTa60t5DM3azyX/2by9UxEl5EjdKj0QTgjby7/rTXXwIhrCYy/dk4mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szJ1pjvQnsKJCS1Fxg702KGREck1b7mPG58y7WiAwTU=;
 b=1I2zp46khRVMLXX+ATSFC+XfXVT0GFgCbX12tQsIkigKae4ox9vm5P0PB7EQthKDi/6xZH2xIXpUy+dn65xhdRW5M00BvbRzrnqH/yR6oPsbRfS5fbzqw4OxInudpwuSQc3Bit+hDywpaikAwxqxJdR8yAmXzc5TcPXNXZ4U8AI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3566.namprd12.prod.outlook.com (20.178.243.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 9 Jan 2020 05:34:23 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2623.008; Thu, 9 Jan 2020
 05:34:23 +0000
Date: Thu, 9 Jan 2020 13:34:15 +0800
From: Huang Rui <ray.huang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/gmc10: remove dead code
Message-ID: <20200109053414.GA11669@jenkins-Celadon-RN>
References: <20200109031602.343800-1-alexander.deucher@amd.com>
Content-Disposition: inline
In-Reply-To: <20200109031602.343800-1-alexander.deucher@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK0PR03CA0101.apcprd03.prod.outlook.com
 (2603:1096:203:b0::17) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK0PR03CA0101.apcprd03.prod.outlook.com (2603:1096:203:b0::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Thu, 9 Jan 2020 05:34:22 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e88cb44c-2425-46de-f6df-08d794c59588
X-MS-TrafficTypeDiagnostic: MN2PR12MB3566:|MN2PR12MB3566:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB356646E8F21EAC78E2EDB5BBEC390@MN2PR12MB3566.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-Forefront-PRVS: 02778BF158
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(189003)(199004)(316002)(8936002)(186003)(6916009)(33656002)(956004)(52116002)(16526019)(66476007)(66556008)(4326008)(81166006)(6666004)(81156014)(8676002)(26005)(1076003)(66946007)(55016002)(45080400002)(33716001)(86362001)(966005)(9686003)(478600001)(5660300002)(6496006)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3566;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rs6Zp+Xi7ihkLupDb5/JiLoHxZ/dodtfE2388zRKhyJjCGhKn6clbZEwBy44+iwqs0zX8miwPVrXZQmedt2MCvwiHcFeTZndmFO/I2zWNoPEKv9Q9AcxNkf3C8QCGUtQOhIqco5LxrZK+knP4yg/ReQvNGthKB+VluvoqZcDSea4p90n7GEnfQwcPg0jRGSsrhQ9Vo9XEh2ZwfJmW1pew3dbMuGuwLEqbdlChjofHj9gKZXIpxQKvA7zEFt0WM6tyz5RMrB1DM6axZtig6+pbMUP+stKvWYLW5w9TgB8q8p/AIKRCCssNX8n5qpQJ5TG+D7EE1uiIOcWrGSMCFcq+ovZ8yuZQsjBTFqodA/+SH/3BB6F90b7UjAFT0P0wsRvJTy36C0CZlPX3G3VuTuhFMBESNAfHu7FAbnRno04cVzZeItwLfEFvVWnrahLuyqPNAnbYn9oiRWL0S8gO4LY09sw5LZAIplLLqbVguETA5c=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88cb44c-2425-46de-f6df-08d794c59588
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2020 05:34:23.6043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SUmxLt2fRu/fXdHv8lpPwYrjPJihYXCYSn5Jvkrny/XxwxJXeO76wGigHgGNu2UxKVbX0gSpAv0I208ZQZoHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3566
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 08, 2020 at 10:16:01PM -0500, Alex Deucher wrote:
> Leftover from bring up.  We look up the actual pre-OS memory usage
> value later in the same function.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Series are Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 7dc8c068c62a..faa310b76b50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -736,15 +736,6 @@ static int gmc_v10_0_sw_init(void *handle)
>  	 */
>  	adev->gmc.mc_mask = 0xffffffffffffULL; /* 48 bit MC */
>  
> -	/*
> -	 * Reserve 8M stolen memory for navi10 like vega10
> -	 * TODO: will check if it's really needed on asic.
> -	 */
> -	if (amdgpu_emu_mode == 1)
> -		adev->gmc.stolen_size = 0;
> -	else
> -		adev->gmc.stolen_size = 9 * 1024 *1024;
> -
>  	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
>  	if (r) {
>  		printk(KERN_WARNING "amdgpu: No suitable DMA available.\n");
> -- 
> 2.24.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cray.huang%40amd.com%7Cfcadbf4647914b13864b08d794b24878%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637141365794342902&amp;sdata=NLyK5M3lt7wTTYi3qKerRge46seP7DEi06vjCOOeo3Q%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
