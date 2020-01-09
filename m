Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48C9C32771
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 05:36:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A1A205F4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 05:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QN6zTzan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A1A205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 312836E394;
	Thu,  9 Jan 2020 05:36:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21F9A6E394
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 05:36:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOXWGcdExA1DF8qLOvCMdmTDgGk9PP+M8sGc0LGrp/QnhOyT3H2+nDWpyJFOAbUqODttfgq/Qr05EVfPdpKLciWfKAio44BMwPU3yeWlsftBE+SuSKsxsdqZtJ6RUzOMMSmnPtbZdSyn68surKUIlmkqgpGl1gM+tkOMLhiD7+1ictNfCIDTurrOgWyLPMzknWgVGEN7PQXh5HJkAesjy+yvAJ/EMiK6rIMDSP11zgEZaUQJgbAaY5BuAvCml6RuFAMQfJDDQXWi0/gWAPg2nztvxPLSL+miVHLMp4R3OjqG3mGfEiOuVepYgNzhhJpvGjXVlqQdwKkbNmOchdeupA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1+XCC289JJo0W1cfTyaS5UCemFse6MP7w9ZWDg6aPM=;
 b=HvMXll7PyQOe7SJyKjrBNL45JB13f/J4Ec8cOn358w6bJGdNj9xAWHz8uVERjmz+f+FsRJAJLRzof4mJc0oZsiEuVbKw+6NeUA1kxuYcrisBow6CcyFClz0Z4ty5i/3w55zv7v04A30tqjnlmhb0xtfcgLBxhcOq48QYfM5FVHAEFUBAM2ghyjNbkRdu+rzpxfhcYtoSfLVODz/GmGX+OQ1xCX0Y4wjIIF3znxOwTxlMt9wRSRzX7QoSFIUZouoFeuIAye1Jv75iFX4KWNo+zmM3296uJvjUqQGTmKmS2Y/yNi2/28VajdH8Vam6TMc3Rm1Xyi2xF7SeUxTl40gemw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1+XCC289JJo0W1cfTyaS5UCemFse6MP7w9ZWDg6aPM=;
 b=QN6zTzanQ5TAehhM21HSwCqqPHbNW28CJ1v8ukoJOln2zMiOXBdkKITgILCBEKd1BgKGZbe/a7kMt5EATAMavJNJFzHKJb+9IGIdvSVv7gVRVyA9WsqGphDCMH+rngY9756WlQv7P5jjQCPKzv02f08sHsco0hbkB6hX3BMBL1Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB4048.namprd12.prod.outlook.com (52.135.49.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 9 Jan 2020 05:36:12 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2623.008; Thu, 9 Jan 2020
 05:36:12 +0000
Date: Thu, 9 Jan 2020 13:36:04 +0800
From: Huang Rui <ray.huang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/display: set gpu vm flag for all asics
 which support it
Message-ID: <20200109053603.GB11669@jenkins-Celadon-RN>
References: <20200108224910.289731-1-alexander.deucher@amd.com>
Content-Disposition: inline
In-Reply-To: <20200108224910.289731-1-alexander.deucher@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR04CA0090.apcprd04.prod.outlook.com
 (2603:1096:202:15::34) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR04CA0090.apcprd04.prod.outlook.com (2603:1096:202:15::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9 via Frontend Transport; Thu, 9 Jan 2020 05:36:10 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4a5078f9-f802-466e-b929-08d794c5d65c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4048:|MN2PR12MB4048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4048F6907F721B00D6F5A108EC390@MN2PR12MB4048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 02778BF158
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(81166006)(33656002)(55016002)(316002)(1076003)(2906002)(8676002)(966005)(81156014)(4326008)(45080400002)(8936002)(478600001)(6666004)(52116002)(9686003)(26005)(956004)(86362001)(16526019)(66946007)(66476007)(66556008)(5660300002)(33716001)(186003)(6496006)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4048;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6nVlsX/ireJRghf9PVckZYNWvDjXoj7Futg3N1RevYx76Vev8rPysqm5g54e8GfZFd2sqn4FcNe67mv/ozsZlWhL3btVf3ufTGFMcyzdG5ymjxe3RG6TTB2JAJVr1+68eWvaWVflWcI+uPIOGQtCIVZ+jlJzJytQ83oAAWdVfAL/SS9YJUkeB8hDkGUvD0hxzkmjRLkQFymCeAMJStHe2U+0YmS4bKwn813VuOsV6HPgje4RUUAVSohuqLFDrj2XKBus0ngKGXFdJ2GPGSBgdmKuvMGEFt6R10gqnvN9McxVs1BuW1OLpv++3EsKSO+Tdx8lezF4ZVVeou5nD6YJGF8t/1dS4PppVPdANlUhSzt+FkhPcErftZ2JYQHz/SbD9ujY1omxC97ULuvGRjFVN5ouHlvt1uSaEa7wRfwvfz1viW2e6TWXkdY1tbyb5IHxu1quH7N2Ftr/qWLtoI1ClpC4KT7nOPmRzVpQAbIN/aQ=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5078f9-f802-466e-b929-08d794c5d65c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2020 05:36:12.3892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FK65KNmxF4tW3K7nwVyF5/5YaasifHs0TXYgyxXxoAIcJYbEHt3dQw7zCDIS7rcMfp5gKVlquG5QexzGGqb7bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
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

On Wed, Jan 08, 2020 at 05:49:08PM -0500, Alex Deucher wrote:
> It won't get used unless the driver allows the gtt domain for
> display buffers which is controlled elsewhere.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Series are Acked-by: Huang Rui <ray.huang@amd.com>

Any suggestion for testing, I would like to give a try in my renoir
platform.

Thanks,
Ray

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1123f9ce86ee..fdf4d202ea1f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -906,13 +906,15 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  
>  	init_data.dce_environment = DCE_ENV_PRODUCTION_DRV;
>  
> -	/*
> -	 * TODO debug why this doesn't work on Raven
> -	 */
> -	if (adev->flags & AMD_IS_APU &&
> -	    adev->asic_type >= CHIP_CARRIZO &&
> -	    adev->asic_type < CHIP_RAVEN)
> +	switch (adev->asic_type) {
> +	case CHIP_CARRIZO:
> +	case CHIP_STONEY:
> +	case CHIP_RAVEN:
>  		init_data.flags.gpu_vm_support = true;
> +		break;
> +	default:
> +		break;
> +	}
>  
>  	if (amdgpu_dc_feature_mask & DC_FBC_MASK)
>  		init_data.flags.fbc_support = true;
> -- 
> 2.24.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cray.huang%40amd.com%7C2abbd206df9a4078e3d208d7948d01b1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637141205928856098&amp;sdata=T%2Fetyq5T01NBu4x9l3jtZVC2%2BGwQv9z0KUlhJkxaa9I%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
