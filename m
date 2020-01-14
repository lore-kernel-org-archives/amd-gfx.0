Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE47EC33CB1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 09:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3CCD2084D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 09:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZBrL2vYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CCD2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DC336E321;
	Tue, 14 Jan 2020 09:36:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1076B6E321
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 09:36:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZGfxS9H9Hs/DHhgndVvwkIasZZd+R8aYFAJfODg6ontPrU45SBELFe44HxbIuhYmuzLuq1RbZKo4dzty9R1I8ipqc4dJHpmHVjRzovnvwzr489VZiutVhmUxmTrJCtQsk3VpZhohrCbgWmSwcvMTfZGF6DkapIvtmqZlPuISa6B8s9W4Vn4KGRVqHxOhsrdDjVVDkZg8BF8fsQ0tG6gGE/YCVDbJgy/nNDg+QwcO66kxLm+iONoSkYp0kGd3UdaIdXzfAwov1DthmcVx/adInztgOAO1RLaCHBJuh8s9hPBceBaRdrImsVjWabJRenQNdfeyyguoSVoYAjdAgBeMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qB35x6pAbqk1pTirf42hhkPdkF6mmmeyzM2lfLCvyG0=;
 b=f4trhDA2DPtPeQOtmYm3QeNZG7EP4kWkOU4BW9gk22Xn8vDCKN3s7RSn5hCYyIARFYfkqlq7p4wNvwzc3uYmxL8R4pBxFvGRbEc+reMbKiHojyX7qUTLOLiCBiH7eJXRl2kKYDpDRuKEpOn0rOHJ4pzgdpzbJeoUtNULD3wnauHuvevUHSn9k0xeCnh+arTGREHYHk7EzOq+uWuBnvwLAIF3oMLgPtW2pt+yljJRpAZm12O25MqRgBhAZZfVx7NC5H4dKahk+4RR8EVg94lLzfnVExyprwLI2VG/8fxzZD5v93EXmMl//j8+3WikXK2ueBHFknGEXekWtB+o0AFzpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qB35x6pAbqk1pTirf42hhkPdkF6mmmeyzM2lfLCvyG0=;
 b=ZBrL2vYsv5AeZ1Of4dTLt+D2JGwmDlNMP8wgtnSpUwvOcb4cCYdbNYXOiQfwFzgz3ZVB8oEAQKpsXDFuRjpXlwjHgksYk5T6xQsBciGQj63MTjn5aItlBcVcd6nly5ytYjYMqW9Resf8DmOaglKpotXtMNw/UE+6iVjCfmUYYjQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3263.namprd12.prod.outlook.com (20.179.80.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Tue, 14 Jan 2020 09:36:49 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 09:36:49 +0000
Date: Tue, 14 Jan 2020 17:36:41 +0800
From: Huang Rui <ray.huang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH 1/5] drm/amdgpu: only set cp active field for kiq queue
Message-ID: <20200114093640.GA20112@jenkins-Celadon-RN>
References: <1578638233-9357-1-git-send-email-ray.huang@amd.com>
Content-Disposition: inline
In-Reply-To: <1578638233-9357-1-git-send-email-ray.huang@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR06CA0022.apcprd06.prod.outlook.com
 (2603:1096:202:2e::34) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR06CA0022.apcprd06.prod.outlook.com (2603:1096:202:2e::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9 via Frontend Transport; Tue, 14 Jan 2020 09:36:47 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2500bc02-9e6b-4d6a-8ec9-08d798d54725
X-MS-TrafficTypeDiagnostic: MN2PR12MB3263:|MN2PR12MB3263:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3263092D8FF5D7D07FBED027EC340@MN2PR12MB3263.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(189003)(199004)(33656002)(55016002)(2906002)(6636002)(4326008)(316002)(81156014)(81166006)(8676002)(9686003)(33716001)(478600001)(110136005)(186003)(956004)(6496006)(66476007)(8936002)(52116002)(1076003)(16526019)(86362001)(5660300002)(66946007)(66556008)(26005)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3263;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KSGEPXPMMH7ksd38vHp3lvHg8Jpc+fcrtNZYCah0AAhH1z/6YlGgjm/GusmE6LW/7K3o7s6ZdH8cByu38GFM3fZXj7IS7lsLGp+0N2NLauGH5/s07g3dNM0Ov36iLdPJqBqQR90ND2kq1LDz2I0U31W+31EIo2If5f49gRd5SgmXb33twFofWwHleDryshaj3Qhpq7pBipNpoErWAoEIYXXwf/QkDrFE9sq/48iKmdYpGlbMin9Q3EzxMh2J+jTNuK5FHK6Uvo9akWB/dW75UlnxvjyPThetqYs952p3QitAGnefhbx2CNnq9TUGk/MYjcHtq46J1MKZKWv8BYVPjHoPGr+Q+KdJrs+SWMPMkhy5lwdvpbIT+UmRuUCVODuhKPJTkpDLuWrDR00sy5oVq1Gume7FuL/AXzznFMNrSHveN6M8gVBeSnvdSonSZj6k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2500bc02-9e6b-4d6a-8ec9-08d798d54725
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 09:36:48.8312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nus+HkBGly7rD5x5guk0VH2amZcDZKt8tHQof9IXm6uZLSF1asgZUtbQPEva3sn+u6hiNAz+aEICOB34EaccIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3263
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping~

On Fri, Jan 10, 2020 at 02:37:09PM +0800, Huang, Ray wrote:
> The mec ucode will set the CP_HQD_ACTIVE bit while the queue is mapped by
> MAP_QUEUES packet. So we only need set cp active field for kiq queue.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 7 +++++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c  | 7 +++++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 7 +++++--
>  3 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 5b05334..22c69d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3323,8 +3323,11 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_ring *ring)
>  	tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
>  	mqd->cp_hqd_ib_control = tmp;
>  
> -	/* activate the queue */
> -	mqd->cp_hqd_active = 1;
> +	/* map_queues packet doesn't need activate the queue,
> +	 * so only kiq need set this field.
> +	 */
> +	if (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
> +		mqd->cp_hqd_active = 1;
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 8b9f440..306ee61 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -4558,8 +4558,11 @@ static int gfx_v8_0_mqd_init(struct amdgpu_ring *ring)
>  	mqd->cp_hqd_eop_wptr_mem = RREG32(mmCP_HQD_EOP_WPTR_MEM);
>  	mqd->cp_hqd_eop_dones = RREG32(mmCP_HQD_EOP_DONES);
>  
> -	/* activate the queue */
> -	mqd->cp_hqd_active = 1;
> +	/* map_queues packet doesn't need activate the queue,
> +	 * so only kiq need set this field.
> +	 */
> +	if (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
> +		mqd->cp_hqd_active = 1;
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 45328f9..e29818b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3313,8 +3313,11 @@ static int gfx_v9_0_mqd_init(struct amdgpu_ring *ring)
>  	tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
>  	mqd->cp_hqd_ib_control = tmp;
>  
> -	/* activate the queue */
> -	mqd->cp_hqd_active = 1;
> +	/* map_queues packet doesn't need activate the queue,
> +	 * so only kiq need set this field.
> +	 */
> +	if (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
> +		mqd->cp_hqd_active = 1;
>  
>  	return 0;
>  }
> -- 
> 2.7.4
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
