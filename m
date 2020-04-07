Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2A2C2BA2B
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 14:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2CFE20857
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 14:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QK4IaqOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CFE20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75FA389CAF;
	Tue,  7 Apr 2020 14:55:55 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770059.outbound.protection.outlook.com [40.107.77.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71F5989CAF
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 14:55:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYKab7grTXQjNy8/0KezGaEcVrucyhVw1xeMRIPqy63ffLrPGyuef6LKvbJnAyf6W7X7zJurQM4gdfTaN6yN7+sbFMY83fxA2PHxN6qoXzTIIOM1yHhqRIVQHQ/oxDVBubOw6j4kwcBjP8iZNhEW9DBy7sX9W4kQdq8SH5U9jatH76pH5SMeR9j4ZXJYGsaYQ4TDtYEdemFkwONgyY+XNBD3V7p/U0EyPQHDP0xeR/7+eX17D/EJzKX0+aj67eS0QEzuvGL41PpSwaEN8tHNKHMkKNP//RBtwqiikXS8dVK4cbFtlzrNIDesZa1y3OEtsVBFCVnV3YW9DlubxXlrxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WE0riqTztc5weBLa3cY7NoUkD2VS8UxRScIVlYDdyo=;
 b=S14S6X3GrCxUtJWbxawtfg348wb4eNMI4M+lyeKcZxQXAqWQn9toDj/h+bHTUCIxG7axN9Clp1KOD6dHs6/xbRkdykUtv+gwwZWkF5vkMTfqLCgETxLrw2pX0SOEyfQCigthv9J6lYLF8ZjYgklEjHqi+Cql3pobRaMyGUc0bgmob7xAjXdAc1yZGo4r/G8wCXH1A3Gfd3xfvdmE17KQtBPxxB3i5Mjsxc6yBHZVDB6om625HNKr71Kh5UPNavJ0wOF5fm4CLJm7FYnOY3Ff+me29GZsCqdkI5w24AIDylrOgTVZDBrG/CNAR6lDyIzo360XOr/pGsNrIcBCSHQH/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WE0riqTztc5weBLa3cY7NoUkD2VS8UxRScIVlYDdyo=;
 b=QK4IaqOpQFBDPJIsBULc0/xJ1WkFcWtcd1OOlIEswt0dwAJQ6rGQDFoI8ZIMPL/3517dEPzx4Kdu/w59UE/6VW/9+w5vMHjyb4Smsp9hpC5MrpBaW5PskpZE3WVxkY3OdpbzL5sKJc4ItpJiFP5Wl6MfM4B3NNbBlMVNQfYkOZA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB4551.namprd12.prod.outlook.com (2603:10b6:208:263::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Tue, 7 Apr
 2020 14:55:53 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b%5]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 14:55:53 +0000
Date: Tue, 7 Apr 2020 22:55:45 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix gfx hang during suspend with video
 playback (v2)
Message-ID: <20200407145544.GA28332@jenkins-Celadon-RN>
References: <1586265256-8824-1-git-send-email-Prike.Liang@amd.com>
Content-Disposition: inline
In-Reply-To: <1586265256-8824-1-git-send-email-Prike.Liang@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HKAPR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:203:d0::14) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HKAPR04CA0004.apcprd04.prod.outlook.com (2603:1096:203:d0::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15 via Frontend Transport; Tue, 7 Apr 2020 14:55:51 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 47775862-2d4f-45c6-b26f-08d7db03c4bd
X-MS-TrafficTypeDiagnostic: MN2PR12MB4551:|MN2PR12MB4551:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4551EA9DEF97E9BD67DE6848ECC30@MN2PR12MB4551.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3309.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(54906003)(15650500001)(316002)(26005)(6666004)(4326008)(33716001)(478600001)(6496006)(52116002)(16526019)(6862004)(186003)(9686003)(81166006)(8676002)(956004)(33656002)(66946007)(81156014)(66476007)(5660300002)(6636002)(1076003)(86362001)(66556008)(55016002)(8936002)(2906002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pLUbuzLZzbbQBD9CG1Gi6HRONagRLYO5CALlYLeQsa4VvvMw2TKZi4YvqQYIuw58TcsQGkH8dXL3m1p/JOwpUUzbBPQinRv3AKBFMxG1U91BHbTmfspwfLxR3CEf1bZ88GeUkqoiOzd9ysjlDDalA/YiymusEbI/WPgAaU1CpUreoIHU+/hNNjnSyVJaAft2n/oRqJGR03dp2bIbVlR4bXLAeVurXitZKrgxh3NKr/Xf9ESYG0w7mabFLh6LM4uDgVvGVMXjHiXkS3xHVfpily14hFpo5sMNjC11NnCgL8STVldEa2LSk3q2/V7msjsfBm5wfe9bGTA88VcZWwJ7uziWIOQvRMvlYxVxcz8gjRzvmI4KE4g6uAVfRSsg8WKZyjx0jpgUxWIQymaOIE4ivOPv2m2sXmH+XY2PCDvgA5A01gyxqS06MYo5IC0Fq9qc
X-MS-Exchange-AntiSpam-MessageData: 27U3O/SgRCVg0HlDxZbvFpa3aszV4b/YeOiWFsjATvZW1SBONctGWRVzKX40afOHYn0R4oW+XN8eT1V6b7NkP+Dd2ZL7PF3rxUYTw8/7MmTS2C7VzHP7VAGiGz+EYQYzMkofH9QzZONEdBlWLeSovw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47775862-2d4f-45c6-b26f-08d7db03c4bd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 14:55:53.1074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruu/vu4Pz5HWinsEfKJqFN8b7rMkIUW7uuTF8q/p5xXAnbK8kuQSv24uJDo6MM//ZW2AISd1teR+RAuoWvUVDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4551
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 07, 2020 at 09:14:16PM +0800, Liang, Prike wrote:
> The system will be hang up during S3 suspend because of SMU is pending
> for GC not respose the register CP_HQD_ACTIVE access request.This issue
> root cause of accessing the GC register under enter GFX CGGPG and can
> be fixed by disable GFX CGPG before perform suspend.
> 
> v2: Use disable the GFX CGPG instead of RLC safe mode guard.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Tested-by: Mengbing Wang <Mengbing.Wang@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2e1f955..bf8735b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2440,8 +2440,6 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
>  {
>  	int i, r;
>  
> -	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> -	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>  
>  	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
>  		if (!adev->ip_blocks[i].status.valid)
> @@ -3470,6 +3468,9 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>  		}
>  	}
>  
> +	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> +	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> +
>  	amdgpu_amdkfd_suspend(adev, !fbcon);
>  
>  	amdgpu_ras_suspend(adev);
> -- 
> 2.7.4
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
