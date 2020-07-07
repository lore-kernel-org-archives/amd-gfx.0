Return-Path: <SRS0=Rnur=AS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D502DC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 06:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F40A206E9
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 06:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MkqT2Rwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F40A206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5805E6E20F;
	Tue,  7 Jul 2020 06:59:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E08B6E20F
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2020 06:59:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J18tHxnDHsJ1hHCD9mPuRCVa7rnGtWdSZffajnf7dU0M07caRMLyVpoxPe2Tt5R5F0XcL8IrcfkSEVCww3hsz6gyj4dYlPqpf7mYRHMoEqXJu9bqNyxvO3Hef3F0iv7lhziHprfNVAi5r6F5ewNlxxPtnk5I+7tak/o+FqB85ZAT8EEnbT4ajthpzdtHYfAs+INnOoaXX3hY+x1vqxIGz3LQ2QKZ0mrhMJk4iCsZrDghp5QYsTE+iuvOqYFj+CDCRE5A03I96u0n5NwcbGh0bf1oDOWetF4RWCj9MwxxOUOxYNH6l37hHeDYfjSTlGuRQ2fYSYDdXYs9TfANrITaVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2/kQOruRhi1+R0FyvMxFquH1luKVBO4OIqNyFldJxQ=;
 b=IeisVBSNizfEpTpN89fXuJIRJrRBS6izwWq9onrDa9HLFc5sBKzzEN74XdBoOYjOXGeYL9J9xg47l+u0OIUvgpUQnyh6fGQiiCwQoI3PpVlF3sy7aBLAeYgKgqAcF8rLVzdJEY11UrbgGd0I7Zy08sDHkb0aAOEc10yMgcG6aHn1SNq/p60OQzhkSjfvjoKpX8wwLBolZApvr+H9LgixzcIcdiR50XjLIoEr2AsYsUQUlOsqWC50vYEyv2e9A2mVZv4dscy30DaUBQC+auGW2fiXFEFb4ywUzOXonAEdI9qBlJ9xHkH0fGZ9C0AiLG332jvHzASIbwb+rASHpyBHFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2/kQOruRhi1+R0FyvMxFquH1luKVBO4OIqNyFldJxQ=;
 b=MkqT2Rwe+sU9Y3pJjelPEwj9LW044CBMv1SpofFM72sT5l3t3q+Q10D4wQgwlLgYmq5/i+9Kziazv9f8DMxVn6Xn0MFhiEES7UdV5f8aXfMqpU9eUIUm1ayWBbiBIIr9pj79wccRJOHyMc5FMcYXeR6HjOmZ5mhk/UWKcNQpljM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4518.namprd12.prod.outlook.com (2603:10b6:208:266::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Tue, 7 Jul
 2020 06:59:17 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3174.020; Tue, 7 Jul 2020
 06:59:17 +0000
Subject: Re: [PATCH] drm/amdgpu: fix null pointer reference to adev.
To: Lepton Wu <ytht.net@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200707032603.2525411-1-ytht.net@gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <119ce850-c07f-8a4d-ac3c-78e021b7dd32@amd.com>
Date: Tue, 7 Jul 2020 08:59:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200707032603.2525411-1-ytht.net@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0101.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::42) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR01CA0101.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend
 Transport; Tue, 7 Jul 2020 06:59:16 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bd7de647-a0d8-4c59-246f-08d8224343b9
X-MS-TrafficTypeDiagnostic: MN2PR12MB4518:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4518F74AD21003127F6DE71483660@MN2PR12MB4518.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0457F11EAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7YJPR+LgtgK58RPfAjLDlOYnpfk8I/nskzsQToI8DhinUJujHxCy7iRnZ8iopnhbZ3pFbJZtvSCvkH57kOjgrDBJ83pPj0BkofVaOtibS080YDir0SDAfs8Ku5BIBLgrGf4Ng91YzzbGdVm5ogMtpM/zZK+WESu5POHzB4kwvLimWnZr7aJa4tB6F61+ZnIIrtXlvjme7/QqvB9//X46PQ6cVMnLLlqoktqlQ+0AS7+tMUyKiFUD/ys9sZL41batDvcIAY7vivKw2HqdidicCbFP8L7+OkAKbxZrko/z0hPlFdDqz/bQrMZyS9J+SmhLxvGkUpZgZ5qK0bK9oDCT0U05OpFzf4hQfwR5ZYvwDYrbcRSeGIqufreoS7W0a437
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(2906002)(52116002)(66556008)(478600001)(66946007)(66476007)(36756003)(186003)(2616005)(316002)(6486002)(8676002)(4326008)(83380400001)(8936002)(86362001)(31696002)(31686004)(16526019)(6666004)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: P4K+FM0hCtGkjNpyacnkXwni+M1agLscBDZcFqU65V/W03WwXza1W6JiF4XYJ2BAHod6R7bqW4JjrhzcLdA0KSQXNYLfOpsPtnOriRCiJam28idDSICTKA3d/P54JU5LQNAqWrUl7Un+EY+Ae4RJAFCLbKKsjycr/LNeZAvcvwhSAiXGU/p3dR4duk7Wh7m72RY7jcsD6KpSGaDQ0u72NZqQDWCj7fytk4VEz9ttCBpSzBeiyQ+9YUhoBVOb4BY/35OUABpDiaonynFoxDOMcPKyiXjRFDC4rYi35kZ006im2NEjQUinXvMM+AJ7aub5A2IwerSkYDzN22HP+qE8G/JvD91QbHZOXGuIp39R/C9u4VJRVnASBYy0nKXhc+X8IyWH1YG8YRK/Aqxnb1qDCm231ButT9csvs4hL5WHwid/GP1hWmm7KUzdI3WgFaq5JHBWU3CLQK0ObxPB9TrU4MVegIQjB+KveK6DMmRAkQ9qh2A5+7x/dhZpBCiBF/8xAqux+wlg4rtj+2H5w7w0z/4NNBYxSh2L1G4F8WS27VA9WNw39bF9cZJS2Is/8I2A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7de647-a0d8-4c59-246f-08d8224343b9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 06:59:17.0843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhkQQOfDlE2L3nxDPD1oDPkvDtpUgdAnMXUf9S5LqhiRW3h5lNXwSSXtTgGuUpBG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4518
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
Cc: alexander.deucher@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 07.07.20 um 05:26 schrieb Lepton Wu:
> I hit this when compiling amdgpu in kernel. amdgpu_driver_load_kms fail
> to load firmwares since GPU was initialized before rootfs is ready.
> Just gracefully fail in such cases.

Good catch, but the solution looks incorrect to me.

The underlying problem is that the return value of 
amdgpu_driver_load_kms() is not correctly checked.

Christian.


>
> Signed-off-by: Lepton Wu <ytht.net@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 ++
>   2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 126e74758a34..f9d277f8ddd4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1124,7 +1124,8 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>   		goto err_pci;
>   
>   	adev = dev->dev_private;
> -	ret = amdgpu_debugfs_init(adev);
> +	if (adev)
> +		ret = amdgpu_debugfs_init(adev);
>   	if (ret)
>   		DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index d7e17e34fee1..99a6ec49ead5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -978,6 +978,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>   	struct amdgpu_fpriv *fpriv;
>   	int r, pasid;
>   
> +	if (!adev)
> +		return -ENODEV;
>   	/* Ensure IB tests are run on ring */
>   	flush_delayed_work(&adev->delayed_init_work);
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
