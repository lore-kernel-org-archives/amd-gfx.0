Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02A1C352A3
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 14:39:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B4F2082F
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 14:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kuv6G8o7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B4F2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E5736E99D;
	Mon, 10 Feb 2020 14:39:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3F926E99D
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2020 14:39:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FS1/YrusEOIZ0gDfzCwmDfFXLVbXnYuL5MTnUtDsGZqI2QXR7uFL3GiRRGCzbi6veYYsdDkuKmZ4Cspoz/D/XZ3ku8WHgKqCsPx2KlW678GQhsxlYGNTsFVG/sqfiIYBDF3nqcCw8szYSnflxAIBN1qOd3GQiqm1WFZZbpdX8c/Y76WnXipj1v3INbx5OQGgZ2YEnR4U1aF1H4dZr74dTFO8EwVsohoDrGb/nhh5izpuJZYPph0aEE9vTLzFAN6G6CslFmcNcRSZAF1MgefV9EDd2mcCPPw8xA+K/a7L+DphG54fLnHEnwtuw1E3VQWvnzu6EIK8dgNbEInrZ4uCpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRUdSxa67/BwfMqyMv9KykFzT7Jpoi9AD0fejw0cV0A=;
 b=b8ek2OBhcbcBHmTh1HGW6oQqjukKMQBdE5+EY6cYTgBNTthJUGe93+pwprjnm+wEmpoF9ZMPqEU2Q/r9ECIzMybLcZZwKKl8SDy5qmMg5Mg9ucYxaHR3rCt6cWHbzIbGp6zfBUEwEIafN0o/0KfAMeWjlRwwVQpwP4a4jn56oEGxs208Q69fwSu7fbprO6i5UVCTNWoAbYJRl2XdYDBCZTv+RxDkfo3Jlf3YLWsny2jnEGl5gTBgUHreJ8sszkPvI0fcL4E6eOFrrzwEh9fJatARRyYPmf7sNFKP54x0z20ycIUcQ+sEgDVo93tNUHky3e8mJoxukIozqFW4d54bpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRUdSxa67/BwfMqyMv9KykFzT7Jpoi9AD0fejw0cV0A=;
 b=kuv6G8o7FEJ9Mxr/4iqEoIHt5D0DbmZUhqQj/pt73zrV3z7HDi5L7rU2TkKVUC8sFOeFjS6LdXE9BnBAG0+eYd0ekC/Mn/5fv+CI3r1R+hVKh81BGEkx9U4bsCxLKynj7qJhtOzIH75E2nVvS2Rzs5dIBNMjEdM93nbhSHUslm4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (10.255.174.32) by
 DM6PR12MB2681.namprd12.prod.outlook.com (20.176.118.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Mon, 10 Feb 2020 14:39:20 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::7c3d:1072:f9d8:8686]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::7c3d:1072:f9d8:8686%6]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 14:39:20 +0000
Subject: Re: [PATCH] drm/amdgpu/vcn2.5: fix warning
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1581081447-1508-1-git-send-email-James.Zhu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Organization: AMD
Message-ID: <2a425dd3-1916-36cb-5710-9bb4bfadbacb@amd.com>
Date: Mon, 10 Feb 2020 09:39:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1581081447-1508-1-git-send-email-James.Zhu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::27) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
Received: from [172.27.228.95] (165.204.55.251) by
 YTXPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Mon, 10 Feb 2020 14:39:19 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 76910140-b7c8-42ba-409c-08d7ae370372
X-MS-TrafficTypeDiagnostic: DM6PR12MB2681:|DM6PR12MB2681:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2681B1F74D9517A127CF34A1E5190@DM6PR12MB2681.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 03094A4065
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(199004)(189003)(81156014)(81166006)(26005)(956004)(86362001)(2616005)(36756003)(44832011)(36916002)(8936002)(52116002)(31696002)(8676002)(478600001)(4326008)(316002)(53546011)(66946007)(186003)(16526019)(4744005)(66476007)(66556008)(16576012)(6486002)(5660300002)(31686004)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2681;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zciX+zASBBeGAtki/Lpjutp+G9B4Q9XClBtkOszmZV+bh+DE7tQ+AXsJujVRCTrIY0EkQX1jQ/NJMd0lDH/a1kNFasHPHowPtZjAWDKjWKsfGKGUDP3/dALibWF8eonBRCUNPeuqc3HbZLvf/lPRYz0mn1rcVR2WAsiPLQBApWmmqGGPW8ndOadShffoyszMmlbKJJEYx5V1QrXRliWkqVQUb0sANFs6KnOnHYkinYaKGN7hfQE6UNYP80PmQgZnwZNv1ev7OjHtwN4S6gkIVolnCC8ryCt9/B6VZTmzmVh4aHmobYycKdUxLj/h2s6Dz7XytOJmxSm1nRJVe6yb/cXB7tIcXXWFsra+ObmnrxRpsuXK0GhB8L1FCrcPHhC6mEKRVNfJowwc7TfpiPGrj1aFXSxHzSYNSBCpkS2DaUtK55gbwiB+frBv4ymzNzMt
X-MS-Exchange-AntiSpam-MessageData: 98MK+YiPAMrzzWtvM5F6hZm7rgdn5Yd+uhu2r9bXUSAHknsYOrjavuzWCVHKNBX5QmEfKZ4bwPeR0BWgh2oa9G9qg1ivqXhIjXiMKDdQgRtaXjfoHkQJTsFQFdAFTQBAKqhQac719p8fpZjAI0Y4AA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76910140-b7c8-42ba-409c-08d7ae370372
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2020 14:39:20.3676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHPxBeelA6Ai/scKTHka/7UyV7GuJHD8YaXqzOQ8Ctp+5d/yjKp8Sh2L9cXfuCUM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2681
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

Acked-by: Leo Liu <leo.liu@amd.com>

On 2020-02-07 8:17 a.m., James Zhu wrote:
> Fix warning during switching to dpg pause mode for
> VCN firmware Version ENC: 1.1 DEC: 1 VEP: 0 Revision: 16
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 97ab44c..2d64ba1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -1407,7 +1407,7 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
>   					   RREG32_SOC15(UVD, inst_idx, mmUVD_SCRATCH2) & 0x7FFFFFFF);
>   
>   				SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_POWER_STATUS,
> -					   0x0, UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
> +					   UVD_PGFSM_CONFIG__UVDM_UVDU_PWR_ON, UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
>   			}
>   		} else {
>   			/* unpause dpg, no need to wait */
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
