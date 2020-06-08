Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E60CC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 19:58:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC3B2074B
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 19:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zH2VmgaB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC3B2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 989D189DFC;
	Mon,  8 Jun 2020 19:58:09 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770077.outbound.protection.outlook.com [40.107.77.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7384B89DFC
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 19:58:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsKAckfUOjdNOrMobfbnnoV6N/GziR1gmBhrgLCb8izTlU7OwbZNSveftcAQl8S+5SFjUdA2FBeR6qpbByGsfWhDb+CEyWKmrcnuMHPsElxI1cvgkkwQQkfeVKYC4rA5BO/lUcn7xVzOA0S8ETSxyqO4sX6UndSfJhbAfSM+Gi6hGE5GEEIjmy6Zsf7hHQHb+o/y/a/FOq2tgyPFxnAo/RB1QPwWrmQPQZnYkih+LWROBaeQcH4sSWlRLDgyoa1+ocgs6x4oocPILuZya2mdXDUXsxEsj8vmTNrD1brykge+0hZYlEp7oK8z6JZRV/hZv1+fkaUG67XCLf7pcB5xxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQGBYt/b4hsXYvUnAdaREBN0hFCMaMwNesfbv00uD48=;
 b=kswbYmhPLQN90MZp5yb+netQpAyi8n7w1+Ru2fTPzFy0Gi10P9lUvdupA+aRrUvRnKNH0aYXZwn2QVK2qsvjODWPaee+zkAaT9I3u7i123GkQPuOFOlQkEZfYG9AxJA6DQPwGUz7sgwdF7bF1LIT3uJ/MuZlVOWXPeHoMAliGAHhjmvbRaQ62ha6HZDBiKJFzEMn2nesJjHhcgx/1/qMWfmHX2sf4zocj9waWEukP5gORlpEFR5TTFUZhRtDeLYkz3SmmWjE6YwXyEVZKEy7gk0i4e4Ha4XC6jH3SSj0mkusizFYlBsJ1ydOY0U8gFsb2te3/X2oUPOFtVJIJz0rKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQGBYt/b4hsXYvUnAdaREBN0hFCMaMwNesfbv00uD48=;
 b=zH2VmgaBgWDgDkUEFzRT1bjM04/vSF8aahWYiHRzyGW0Gj5VGYCJwiZvVOe/SI+2yNAUN91Ad7OkliszdwViINXwdfNcws3t0IPAOVB2sPqIso4jxRFnxBbOE6rLSeyFzDtnEZVzf0j0xqemNykyl0Ej5fBaR9nyCGfqWrjWB84=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2544.namprd12.prod.outlook.com (2603:10b6:802:2b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Mon, 8 Jun
 2020 19:58:06 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 19:58:06 +0000
Subject: Re: [PATCH] drm/amdgpu: skip BAR resizing if the bios already did it
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200608194109.224589-1-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <cf9578a6-0fc4-14c5-6a0b-87359b0956f9@amd.com>
Date: Mon, 8 Jun 2020 15:58:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200608194109.224589-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::10) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YT1PR01CA0041.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 19:58:06 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 27371e5d-e5d1-484e-d157-08d80be642b3
X-MS-TrafficTypeDiagnostic: SN1PR12MB2544:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2544163DBE1918164C73440392850@SN1PR12MB2544.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B1nQiJhqzKgjtBwT5GHXSvd3aw7c5CCtlWyi+i0bjyAYPoneuWdPb7wcniLpBgW+ViOIjeUVFGks+1rGclBkm5rTqgXatbVHyi8+XOoIXhjCKuvBPeCrbws1MXUe8Kcs0UxZJTqXlGLJFMZA551Zg8BNKglaz54co4gTUZo0DXRiIWKCONM/ETF8Q61kokKuFmK4JQAak2Ez7Cm9TP2HgqVAdFVJR/T95Xn9iSFeSD0wXvenzo4jZdNZVqN5KFK/uayJzkSxCe2hGSFQ+LPtFohl5lNttaK2Ze4xyP3QilgzNd+2QurMjIh4HP5w/owX+3IcY6egndMsiqOxqraiPMoMEXSQnq7RfG054jxj8+Avi59tVGPs2/fUoHvUbNgb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(478600001)(4326008)(52116002)(36756003)(66946007)(86362001)(5660300002)(16576012)(31696002)(66476007)(66556008)(4744005)(956004)(8676002)(44832011)(8936002)(316002)(26005)(6486002)(16526019)(2616005)(31686004)(186003)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: OCbPOKPqnuLwp8wNPCf8sRLX7otTW9Nf9iG8tHULGzzmdSufQd2Dug9FETDPAyKxkgPqUTJ4WzTApv6Wm2lH31dAxQL6pV/28/jO2KsktK80sR92MdT2Ff/g5mXZJa2QEG5dl6UDMafT05OvcyAdAg4vv+3IpXydK5SwRgaDfQOuSkMytcWgZVwUjSvM35d7MU+5RPxkPKwV+GUpHDTooZjBMB1vMEYEk1eLS9vuASnm8qjNgWOquFD+e1D+zZvCEo9W3xt9ociLpm6Cf6L7wZysfSJzmMNwDctOKVoCv7/NNRHNHbk+nFBWZU/Of452RQ+6Bwl+KM1QnvypYQHpWtJi8u4/555UMgbJ5VXOeQRZIC4XqrVcQ0rJ5iX9CFIoVBikxcS3Z9MtmR+VmeUqM3FCzkGSGtzFCbkOzjitp1O9iVu7Ipq8L7ufFlKs+3WkMwfTAVi5GWEsa7hIvGSl5EpEApS7vI4ifnBeCLb9uSZFFnRns/nOXkLwArCatYjO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27371e5d-e5d1-484e-d157-08d80be642b3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 19:58:06.5567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJ3sc8bR2daWLfZsQuXKjz8tUlH7FH19P6YfYH1uW/MMi3lL8Esv3lH+eoAM6bZlSRkekPog05jxqkNiEgjQtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2544
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2020-06-08 um 3:41 p.m. schrieb Alex Deucher:
> No need to do it again.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1df28b7bf22e..539010798116 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -909,6 +909,11 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>  	if (amdgpu_sriov_vf(adev))
>  		return 0;
>  
> +	/* skip if the bios has already enabled large BAR */
> +	if (adev->gmc.real_vram_size &&
> +	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size))
> +		return 0;
> +
>  	/* Check if the root BUS has 64bit memory resources */
>  	root = adev->pdev->bus;
>  	while (root->parent)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
