Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7970BC33CAF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 22:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C9924655
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 22:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mQ+MxhDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C9924655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D98746E290;
	Tue, 21 Jan 2020 22:06:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FB916E290
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 22:06:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ml7mYgfBbpa057yDxEuuq26+g0CX086PrxLE2TUa/8Z+TWxTR22lN8oEL7+DdZX5HH4afYiRyqVF14/1y23JPq/rjFkFjTw6vYT8OOnV1gd16yz6NhKMw7m4+XJowWWKgcC3OyTXEZMyATi9Ck0H1/Gjy3B9fvUNcrpcP39gZ4lbVIrYzY9EV6JOP4cRsEHbkoxKt/TIgqzRsAxWseq+p1nYV4Yut3tyfy9Mnon1gGxxH6c89sOGe7HUAw4ja2Uku9BwAlgNxoG1JDnUOqsdKulpFUKpBUNjvaj0IcVLYgiPoMqf6CgqCbaBtUxA4Q0/G4q7oHXGe/EuTtJyfjn1bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/tpcS7zZLsvXPzqfVyUdNY8I9RXohkwLnFdKruJFe8=;
 b=JJ4K3S4HeyJyFBProIzkyjum6wnU0IqxjWLj3er6fW6nVqSckuTaS28+JX3tKtkdkXwsamsxiPvw8mkn72Gv9YsopnPfiIkSnEou64v+n3mshKR5jeVMyF/5yeqmvNJftbuZjmAOoGlzhVATdF07Lg5J8GSy3VC3C6aBUi+K+oRnwis0vS2+D7dDGwBlHU7+nK+5U+VTMSpvI3/gF+ps0jmpdcVTWSZHzixFYvBRi1tBOQqCMuGyiPj3rpjjZqbdESE3sDUSdXslT2vGmGAO8oFxDPJ/3vkS0cQOK1sTVvzPv2XjNDX7RhROlrTlkoYQkN93mt9WCfN4WT6JM8/Mzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/tpcS7zZLsvXPzqfVyUdNY8I9RXohkwLnFdKruJFe8=;
 b=mQ+MxhDRoKEgclnCVSY7Yvf2vCOHQIotWC0gix4om6JmLeP6xyG0FnK3INljfcB1FUz1dcaMfMsL8sfTbJuUFz43cTWwZcyLuz9jzLStOB7S8F/Yv9btD/RRV2ZjdvSMj7J7yD2cEXfSufGUxuswMOR7kGsLwBv36QDVK+E+6d0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (10.255.174.32) by
 DM6PR12MB3804.namprd12.prod.outlook.com (10.255.175.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.21; Tue, 21 Jan 2020 22:06:27 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 22:06:27 +0000
Subject: Re: [PATCH v2 4/5] drm/amdgpu/vcn: fix typo error
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1579623556-30941-4-git-send-email-James.Zhu@amd.com>
 <1579642771-8907-1-git-send-email-James.Zhu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Organization: AMD
Message-ID: <debc1f7f-6b69-4305-3e56-496a23b826dc@amd.com>
Date: Tue, 21 Jan 2020 17:06:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1579642771-8907-1-git-send-email-James.Zhu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::16) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
Received: from [172.27.228.95] (165.204.55.251) by
 YTXPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18 via Frontend Transport; Tue, 21 Jan 2020 22:06:26 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9a0a2db8-4da8-4ab8-a349-08d79ebe2938
X-MS-TrafficTypeDiagnostic: DM6PR12MB3804:|DM6PR12MB3804:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3804AC8CBEA13BBA1C438998E50D0@DM6PR12MB3804.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:250;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(189003)(199004)(478600001)(4744005)(31696002)(52116002)(2906002)(36916002)(44832011)(53546011)(81156014)(26005)(16526019)(186003)(81166006)(956004)(2616005)(8936002)(8676002)(31686004)(86362001)(66556008)(66476007)(66946007)(316002)(16576012)(5660300002)(36756003)(4326008)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3804;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TkDWwr891WS7nUs+0M8TeY7ehq+XaXLRgymTPYFqdhOWQhUhmtbltu58Tl2rouxTRmoDroDj5ZkExXrjCsFWKgoeOftg8GiyhwVVvaqidZviwnSlc9Vjz0frN7lVxiC1zVZGKdnevPFkun1xxXgjuSKej/mCeyUGgszMMQEV2YYZ02CCT4nel+nXKW6eG6rLKWhUf31REN17widcRGGY0l8x2aaC8FfxjVTBHjvx9AMct8IxN7HlV3K7Acdu06KN/dZ0M7OW52JaErDsVCcd0c9qgiYMBSkCoTum/fB3go161NmsntVIJxgk6ajJMWJcbKqossYLW6deOwRrT5oa+ciDOB+dJTUWc9ieiqGW2p/QchMg+qDT29qerSzLQYebE73kVstUKjQietqWmo5G/Nezqo5i6f6H8DsH+1VCvHha1r2Ip2RJ+VWlurY1CLlw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0a2db8-4da8-4ab8-a349-08d79ebe2938
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 22:06:27.0116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwm7KAv+1FRXWMmNqKvxh9gm68hCfucmPSgwCOtJGWx0QAsEuoav2A66DZLEemSK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3804
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

Patch v2 4 and 5 are:

Reviewed-by: Leo Liu <leo.liu@amd.com>

On 2020-01-21 4:39 p.m., James Zhu wrote:
> Fix typo error, should be inst_idx instead of inst.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 60fe3c4..ff4f4f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -111,7 +111,7 @@
>   
>   #define RREG32_SOC15_DPG_MODE_2_0(inst_idx, offset, mask_en) 					\
>   	({											\
> -		WREG32_SOC15(VCN, inst, mmUVD_DPG_LMA_CTL, 					\
> +		WREG32_SOC15(VCN, inst_idx, mmUVD_DPG_LMA_CTL, 					\
>   			(0x0 << UVD_DPG_LMA_CTL__READ_WRITE__SHIFT |				\
>   			mask_en << UVD_DPG_LMA_CTL__MASK_EN__SHIFT |				\
>   			offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT));			\
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
