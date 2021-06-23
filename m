Return-Path: <SRS0=KKXi=LR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B914C4743C
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 03:21:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BAB361001
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 03:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BAB361001
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C42DF8991D;
	Wed, 23 Jun 2021 03:21:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 852A38991D
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jun 2021 03:21:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGZgrEPiCFdh0FFzTiGbNN4jdSGKvieIS34BUkwe2dl3EUYPWfZVgcxQ0DjjfKZIMw4k3ovKuq46qRKAIZRo+DIiL4X/Oe46bbqJuGR4M6qBpUd27BPV4bNP5yACCr+41wNOwQ/C601tz40GDiDitkdVOALjg/BgvcV8dfriCZphhJZsmvSC1oX8wKy76wP7cjUsL7avZ1ygbht17xaUcTZOyo8nz1xm6aGFSad6BGiactRe703s826IxN+xerquTO6p7ECsbgeoFAJCjoxw5aNqsnuH7Jvcaq79Pu+CBjc22Kgc2qECJTlTtpdnV0+zulJW624WhickgCtyRhFFAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+maAqZriqcQZRg0Mzip982pcLdcZNwDr5/52jzB3l0=;
 b=fSjkor8oLDL+hgXwDrMHeCKlS8SMWgNpgI4cXJGy3FCjZVllStC2h0vk2pWTaNGCuVUEWCIxH+9DU/XxnutanOy/LBPcAFvrFO0e4evoAD7vCURjpXUKqeVtFoTKrnuJOWSDrOSeJOw/jCTywMb2H0Nxdzl+c8+b65JbB0s5Cx63Aa0MEIcZGnM1axk6gK61w6JzH/8XE9JjbBMP+iQsOxGLff63GeIvcMq9go/wYB1nfRHkuEeRMGjD+Ih+zOT9CpEOEKzDOZRtWcSWQeUrVlHFGAkFf2LJf0076E8cVGv1DKCgbPEtMa9NDFBOnqgcadR1qO7N0IwZ7nrJ8iI6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+maAqZriqcQZRg0Mzip982pcLdcZNwDr5/52jzB3l0=;
 b=zwuIJBs8DOk6Q/SfwtVVB/ib9u0XKePvY5dSeRMBDHkiYDv4DDlOSZ9fwrtgXuLkLcn7Z/MKs9cqy3DctieybJzI9S0gyDwDshstDoSare+wT7ErpzmppEDeVAUu+0R112eX1lcqOQR3pGgvdvDrZMiaY2wRMPisHgAcStJFggk=
Received: from DM6PR11CA0014.namprd11.prod.outlook.com (2603:10b6:5:190::27)
 by DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Wed, 23 Jun
 2021 03:21:28 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::2f) by DM6PR11CA0014.outlook.office365.com
 (2603:10b6:5:190::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend
 Transport; Wed, 23 Jun 2021 03:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 03:21:28 +0000
Received: from hr-amd (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 22 Jun
 2021 22:21:26 -0500
Date: Wed, 23 Jun 2021 11:21:22 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: enable tmz on yellow carp
Message-ID: <20210623032100.GA505943@hr-amd>
References: <20210623021009.2138018-1-aaron.liu@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210623021009.2138018-1-aaron.liu@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e56ac11-c216-4a26-cae6-08d935f5fd64
X-MS-TrafficTypeDiagnostic: DM6PR12MB4284:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42843285813761A2D98646FCEC089@DM6PR12MB4284.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:198;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hvuq7xOfeYusUmYVbIgAYE/21ZIdUTt78CVQ1fDO/svEQEXufkCzwRMJAyH3WHa2N5I4IzuidzkFynvk49Y3huD0WjGWAID84hD0B24WCvHp+s/8RCYHkqFQuNNLgEQS3GpUvM6d3mjLNfq/bNTjYCvPynF/GsKK/9rHAP5GyjrjPV7oSYw2LcQ2zjgnF73lHK/lxI2nK4RAAxQXr3Ui88DVVnBFmbepWNwZU04pKOW+qVTBqG5r8Mk381ZvspnZxJo6P0wNJvUdFyhh8O1N+MZbrypVxLurqLOnKzdRGTWDZNx9CdIWbubq+jOv4D9PzP+Af75IxCeg99lzO9gjjWd9A+k7acxJzcNQQUHkfNqjxRjPhI6qCiWqyWaVzRuwd3Z3ew4R+iqQHi+Zjk5hm/T24sEObCWxDj9bd39LdUktEe5CIIvpg9NnF/d9S56bDX/JNHdDwt6pay4bEo8BI7Czail7+v/Be1NfJ0TpUQD2vjbyJBt0nT2pI2w+n4R8EpRzgiIN89rMw+HCVsb+ILqXJFNr9EjXP5n4VtoE+kwFOsthRl6iTEVMLZCIiiHm61pgvnazYcV6NGKATklnqQUGnsVAwOArc0aKq44sqjf80kjW4CgtovPSYMk1z5xwlkQ0yfI4AhalYaN9hWkQ3Uv9Yr7PaKqu4EedXnEK6upo2A/SmaFFWIC+VLECIU/I
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966006)(36840700001)(16526019)(1076003)(186003)(86362001)(83380400001)(4326008)(4744005)(33716001)(6862004)(8676002)(47076005)(26005)(8936002)(82740400003)(5660300002)(336012)(70206006)(82310400003)(478600001)(54906003)(6666004)(70586007)(356005)(36860700001)(2906002)(9686003)(81166007)(6636002)(33656002)(55016002)(316002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 03:21:28.3127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e56ac11-c216-4a26-cae6-08d935f5fd64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 23, 2021 at 10:10:09AM +0800, Liu, Aaron wrote:
> The tmz functions are verified on yellow carp. So enable it by
> default.
> 
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 3014985cbf47..1525d957e114 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -553,6 +553,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
>  	case CHIP_NAVI14:
>  	case CHIP_NAVI12:
>  	case CHIP_VANGOGH:
> +	case CHIP_YELLOW_CARP:
>  		/* Don't enable it by default yet.
>  		 */
>  		if (amdgpu_tmz < 1) {
> -- 
> 2.25.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
