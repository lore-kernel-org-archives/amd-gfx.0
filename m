Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4C6C2D0CE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 17:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E16206A2
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 17:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tOS+md1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E16206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 600096EDF5;
	Tue, 21 Jan 2020 17:29:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0B656EDF5
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 17:29:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFi6vnSpQtFR0aKVXcLikthgewmbNO/SiSXTw5buMHZeOyrs5qwDSpyjBc3QCMnYE1FlfddEWvKExiZrL/qpNnbe5gF7zw0ezOx8ykozt2gyAroVsEEDEGSavrDZ/st+MSAdJ7EOFcAECj4XOj+mi5/Ic8RzucJQhfFOQSpkrHBCl7rA5P0nKNqdpBrQNMSJMIFWQ+YTcx1chs4B8kUZwd2M6Smum7vKAKN1TDaKB1WilUu0v1h0DvfhDcwG9g5nrnsKRn0lnLu2Czo//qOxnR5gROSFFxtq9mKONcMInp1vxXbisl8j1W7IYM4sdZrZ7ThFvjztI81+OtT5Out1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjB9wXnAu/iq9xpezNWaP9wr8ch5IFw5ivvaz49DR80=;
 b=AJdzaegWA69aPtLtpQoHxUEeueOa4zVH91cgg42HP1axsfgkQiDJvNGUbkk9QnwkuttxIldLbVOKnVsn6XFwRH24L2dldfhjqeftdOsc+IJzb/p9OxkabBRYawGp4tO0E/6/C9xp2XIP4X8ZHpfzPdg4rEw5T1i/BZ5tGtkCJBKvWAvf1Jrdccl03EcxmEM5dri2lr2oukB/XcIHKoJhGH+hDZPTRE+Av6wy1YCToXtLdgwgJ3citqHD0OS1u1p9JkAVkh+/yBTDqkTZ9lfy4QYNTDPee4QtzK5WjrgsMKab5rQxN/feO4JH0twH2M3RmeKMj/ZKqqPooEKMsY+7bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjB9wXnAu/iq9xpezNWaP9wr8ch5IFw5ivvaz49DR80=;
 b=tOS+md1kZR8ZSxo5oMBnihBlqt/cq8OctQthNqtZiyBBKNDyejo7V7a+NYp90s9vvcesGc3+ddgCoZHlYSxuYIvWDl3/LJq8U5+PBbd1pwp3xU9VUPxkhQ4+F/mX584eNT2h2DpnyDelBIBzoBRLfIYawTKeuaI07z+gIM/0hqQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (10.255.174.32) by
 DM6PR12MB3785.namprd12.prod.outlook.com (10.255.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Tue, 21 Jan 2020 17:29:32 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 17:29:31 +0000
Subject: Re: [PATCH 2/4] drm/amdgpu/vcn2.5: fix a bug for the 2nd vcn instance
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1579623556-30941-1-git-send-email-James.Zhu@amd.com>
 <1579623556-30941-2-git-send-email-James.Zhu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Organization: AMD
Message-ID: <9a367f37-2531-3966-7904-40cbe4a290d0@amd.com>
Date: Tue, 21 Jan 2020 12:29:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1579623556-30941-2-git-send-email-James.Zhu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::47) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
Received: from [172.27.228.95] (165.204.55.251) by
 YTXPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Tue, 21 Jan 2020 17:29:31 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6a33c92a-90c7-4d35-bdcd-08d79e9779c9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3785:|DM6PR12MB3785:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB37851EA324581C3B5A6AD98CE50D0@DM6PR12MB3785.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(199004)(189003)(52116002)(36916002)(66946007)(66556008)(2906002)(66476007)(16576012)(31686004)(316002)(8936002)(81166006)(8676002)(81156014)(36756003)(44832011)(6486002)(2616005)(956004)(4326008)(26005)(31696002)(16526019)(186003)(5660300002)(478600001)(53546011)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3785;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TfCPWmQQKaOJO9xjvu3sKZaKdT6ITB91sUCUNYZbcE8CfTkFteiXpbgh9uQ09kq4/yXyEDyF4doxpUTiX7G/VLEr3tcPC9G/60a3haQriOfNNauun1InuPNe7n0ouT1DQ55EMFHDtGuqiK07/Jxf23DOupddxP88/76vOSSaGODeWG38kkrlukQcMPucysOl1JRTCnNxpZGI4qFwODvD8bQeYhL1UF6l3IO3exGTQ9bDtivyV481kwTTDnCSa5GzVIzsO8ORA1I9bo1Ho+TXIdevhMiIkJ/qDSNLwxfY7YVxTC6qrvYUpW6eGh/j1NFgrZ5viaU6Lum1ZHK9GGx175dqSQdq7o6b0PF2NtoNRHfUCq5iwJ8InVyoV8DXV7GfbzWAupMg/m2itW/b+/+Ex4zzShMVsuKsU5Z/n1vKSV6oQ/e60mTLbJ1PdUUtZJbq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a33c92a-90c7-4d35-bdcd-08d79e9779c9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 17:29:31.8908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLBEsKdLsWTdYry1st6W2kOGNownv+8M3guGvZVLoreEp0e4oYzg8vYODyt73py8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3785
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
Cc: jamesz@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2020-01-21 11:19 a.m., James Zhu wrote:
> Fix a bug for the 2nd vcn instance at start and stop.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index c351d1a..740a291 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -891,8 +891,10 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
> -		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -			return vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
> +		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +			r = vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
> +			continue;
> +		}
>   

"r" is not being considered, and after the loop, it will be going to the 
code below, is it correct?


>   		/* disable register anti-hang mechanism */
>   		WREG32_P(SOC15_REG_OFFSET(UVD, i, mmUVD_POWER_STATUS), 0,
> @@ -903,6 +905,9 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
>   		WREG32_SOC15(UVD, i, mmUVD_STATUS, tmp);
>   	}
>   
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> +		return 0;
> +
>   	/*SW clock gating */
>   	vcn_v2_5_disable_clock_gating(adev);
>   
> @@ -1294,10 +1299,9 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev)
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
> -
>   		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>   			r = vcn_v2_5_stop_dpg_mode(adev, i);
> -			goto power_off;
> +			continue;
>   		}

same problem as above, don't go through the code that isn't necessary.

Regards,

Leo


>   
>   		/* wait for vcn idle */
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
