Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB50C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 16:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3362206F8
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 16:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DKVg5RH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3362206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6FC96E165;
	Fri,  3 Apr 2020 16:37:03 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750053.outbound.protection.outlook.com [40.107.75.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4913C6E165
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 16:37:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjNuUMMo43Rz7UZNHaGgcfFTVV9+xk8hX2+8Kf4BvtrsZ4VnLAn5M9PZbZTR5knWV28mPNXDG4kkWXSdtvM4zoK53JNCNf6uTpXummj95mpIQPmwY2ero56rFLBgVZMIh089UgK5Ljug+XPtPbb1U0vtZSgjsa48sWV0Ldg3mI+iOtLpflgmEJIGTc8VnGUkHI7/8ZZvIt5qOqvdizRxGkp4riSOa1x0JBcSQ66Tfr+qXkOBGTpE5XmcVx2QF4Bc16P/TH1lGH7fvn9G3FE3xnyImDR4/ljYfFvZdJwHV4lWgpgnKiwnJsscLEfrMYcr1jGen5O8mT1ZclUaUcMWrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8VbBJAfcSoYrc9zLG5t4+J7TzCWyTcEGhQl2eismlk=;
 b=DGLj/RTOE9qtm4Um85M4opa26cEFyKXM7ZCibjMMKSzNNE417cpTc4kb47MY3rsnwuDajvLEXyizCE/OUg17ucpnUYU01TrIdA9rRD8inVoRGUIn0I5xtsMX5AujTxHLItVuMXMm7v9sGGz/4dc0ZBLDqxq6an81xBGzSHe9UJBoIUPEVptCbQPibdDMr9JeOrFTtzTLCsONZk3vKpHF5/85xtkewwncvXfp12uxazvuUy/B59/LSVjHPonmXBnhLW+J1JlyDlEnAdvaBgBs/wF2C1Tx45BtWxKNqIeJTKha5TwymFGwIdQc4vxbc2m4bgyZInZbI/r/aaRjc0YYmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8VbBJAfcSoYrc9zLG5t4+J7TzCWyTcEGhQl2eismlk=;
 b=DKVg5RH8Gzd7LJsUXJ7C2zvNP77C4/CxTUT7I6O1AEEgpI+duYbxuarNLbE83ypMVqTE3k283B4gowy07Xm46/svOEfaUFONvM3Qol9EOpUElkg4Dk1n2QlwoeJZrxkeEiPTVW1FEc5NWXmp2x7oTcIDBCoNzsJC847zFoPPSUw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 by MN2PR12MB3583.namprd12.prod.outlook.com (2603:10b6:208:c5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Fri, 3 Apr
 2020 16:37:00 +0000
Received: from MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::d8e1:aec7:6c60:d13c]) by MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::d8e1:aec7:6c60:d13c%3]) with mapi id 15.20.2878.016; Fri, 3 Apr 2020
 16:37:00 +0000
Subject: Re: [PATCH] drm/amdgpu/psp: dont warn on missing optional TA's
To: amd-gfx@lists.freedesktop.org
References: <20200403163239.63400-1-alexander.deucher@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <712219aa-bbdd-4546-3ee3-2dc0ad517805@amd.com>
Date: Fri, 3 Apr 2020 18:41:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200403163239.63400-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25)
 To MN2PR12MB3872.namprd12.prod.outlook.com
 (2603:10b6:208:168::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2b:1800:3b82:ea90:ab6d:9db3]
 (2003:c5:8f2b:1800:3b82:ea90:ab6d:9db3) by
 FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16 via Frontend Transport; Fri, 3 Apr 2020 16:37:00 +0000
X-Originating-IP: [2003:c5:8f2b:1800:3b82:ea90:ab6d:9db3]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 871191d3-2d4c-4a4b-2968-08d7d7ed3bb5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3583:
X-Microsoft-Antispam-PRVS: <MN2PR12MB35836DA8CD78108C4F8800F58BC70@MN2PR12MB3583.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3872.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(186003)(2616005)(36756003)(66946007)(53546011)(478600001)(31696002)(6666004)(66556008)(52116002)(66476007)(6916009)(16526019)(6486002)(81156014)(31686004)(5660300002)(81166006)(8676002)(2906002)(316002)(8936002)(192303002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gvaeJO3q+1TLiWQf0UExr2e3jCZGtuGV8USZq1Mz86pvFUDoW/ZsxG/+RXMnOxSIgwhE4Rls0mfbn9OpsfQ0tHQnu8sZZ6rZPj//KUsDnQEcJwkU1GktEbO3nf+FFaXvr4aCOfC2dvT0UbMwDeP1ITOUb2X9N31FRJC0ekuKn0gYZGVgSsnKKsNyX5zQNHVRRp0A9o2OqVfrH1DHrymtV69F0hd03TaFyrUZ5N39A3Z1ubxhcUO8pw59p/w5h69y6Hol6yxG0+kcpb5D4svfI7bEAfVsmaLfn9JEBbQ7NAV+kYeLzJtWgjX4humyzyIUbO7rw+vMUiAthzM5rL7Qbf+AjfhIiTfz6nLR0iUbt+nV4+JzabTgRvHnJNJZALKDK5b21k6CGt+Q2CdA0XZZEeelrHplHHB3fb0fvsndOmc1pKHdaHaYKQM3wKxeruam7aaNJwEEyN/FVSsm0zeLGPptegLMlcpIvfTSNn3PBCKym59d0xsGx1hXswZUpBEm
X-MS-Exchange-AntiSpam-MessageData: LDpFIJNX+pK8XpBlxGhZi2GP6eGwCiJuzH6m/VlJ74AziQQFl8qvH6sKY+d+Ohzj/v4XJUyWEjoHhwhtTrXdpOp388UdAPB7bGBgxrmOtB5r9R59dsqiXY+smGJB8OJegy3b5O8EwadPSX9WvXt8Y/NYb7jNtlnXMbk8a4pFDsMEzYbM3rOfaeVUf29SdCZYL/zsOUe9IPMtI0Z968GYxQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 871191d3-2d4c-4a4b-2968-08d7d7ed3bb5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 16:37:00.7372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zizuqZuI0wprUOszXjuewtqTmFpcYyx0YPZdpQDPPyQI61OIpM4CkYlUiHQYcd/eR7HBtX4unaJSQkyJdfzUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3583
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


On 4/3/20 6:32 PM, Alex Deucher wrote:
> Replace dev_warn() with dev_info() and note that they are
> optional to avoid confusing users.
>
> The RAS TAs only exist on server boards and the HDCP and DTM
> TAs only exist on client boards.  They are optional either way.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>


Acked-by: Nirmoy Das <nirmoy.das@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index dbaeffc4431e..5d67b1838951 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -822,7 +822,7 @@ static int psp_ras_initialize(struct psp_context *psp)
>   
>   	if (!psp->adev->psp.ta_ras_ucode_size ||
>   	    !psp->adev->psp.ta_ras_start_addr) {
> -		dev_warn(psp->adev->dev, "RAS: ras ta ucode is not available\n");
> +		dev_info(psp->adev->dev, "RAS: optional ras ta ucode is not available\n");
>   		return 0;
>   	}
>   
> @@ -906,7 +906,7 @@ static int psp_hdcp_initialize(struct psp_context *psp)
>   
>   	if (!psp->adev->psp.ta_hdcp_ucode_size ||
>   	    !psp->adev->psp.ta_hdcp_start_addr) {
> -		dev_warn(psp->adev->dev, "HDCP: hdcp ta ucode is not available\n");
> +		dev_info(psp->adev->dev, "HDCP: optional hdcp ta ucode is not available\n");
>   		return 0;
>   	}
>   
> @@ -1052,7 +1052,7 @@ static int psp_dtm_initialize(struct psp_context *psp)
>   
>   	if (!psp->adev->psp.ta_dtm_ucode_size ||
>   	    !psp->adev->psp.ta_dtm_start_addr) {
> -		dev_warn(psp->adev->dev, "DTM: dtm ta ucode is not available\n");
> +		dev_info(psp->adev->dev, "DTM: optional dtm ta ucode is not available\n");
>   		return 0;
>   	}
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
