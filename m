Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8ED5C4BA24
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 11:53:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98DBC2468F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 11:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xHXqFzTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DBC2468F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B8716E86D;
	Thu, 27 Feb 2020 11:53:45 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690076.outbound.protection.outlook.com [40.107.69.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CB6C6E86A
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 11:53:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSriI9zlTjfIKeXQFviybeICx+njHZx1ty5BkPTn0Z/ligptVobGPdwRwfz+Jl5NcakHv7y4cX15IjXBKIM/cWDDXe4iTgmsxnRtVKPrnmgPSlnMEh8pTp3l0AertiqtBbqAd8IQY/vIYAngwznhXWAG81Hvp7p2lO/78il8Ap9ANc0Kkttk2dFX9XrHhs4rJ0WOLcmqzCubUxAA4trMSFcoOLu72HIBsNvrFrsYfIaGBGW2ZjPaUMmv9Bbno52iNVNNjXH8+KOBMw3FOYfBJgjsMVSFdZrEqCwfMAKQlC2vqMrU+BF5qZcb9NHK+AWj74NPFBIjfnIt87uQyq9h+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFU2yioZr3JP4+A4JosebjdZofIxO3I4QBrhjrzDi9s=;
 b=DEtovL7+ZnOyW8FtvLq9SSpLm/1EWiG24SQIAQ6dse7xjz7Lt2MFCJo1wzgww8D+jPO3u5ECsg7itcLACYNybLIwj65jSZ8MZKK0IlpWNOjoyk7jHN8i1jrnBb0PL7B7mPPJZoiJ7MkAfhtKrsKTaPVe12v2t78uZJ/BzV7Wqqb74siz5/Qlngth5J7bcyiRuGlK2W+YD4DqLmYDFcKH+C5sia8FyVXESIDlL60Qvk9Kr/TEq7H/OZaa87ynJVwOCvEiH/ICPJI/8NZ2WD0PG7v9pU84PGSO4wQjEkH46ltduigjzbD6QgXlkeoAaE0SwDvDnyRUVzTwYVVqoV2GMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFU2yioZr3JP4+A4JosebjdZofIxO3I4QBrhjrzDi9s=;
 b=xHXqFzTFFF6Jd3NFr3HwLu2sBcdRUTV4kt+Ngb+emmSiSoqqBnaKqOn6RXoErAmGNvgW7+BkPRhNc8IOfvqUzY4K9l2TNZhJw8lx4Y5KBmzwoQ6Q/JnmZI1o9leHP4dFQjZMziQvvvgt7UiTWIM+P+VpHXBE6XGkPWZ3c79P91g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
 by DM5PR12MB2502.namprd12.prod.outlook.com (2603:10b6:4:af::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Thu, 27 Feb
 2020 11:53:42 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2750.021; Thu, 27 Feb
 2020 11:53:42 +0000
Subject: Re: [PATCH] drm/amdgpu: no need to clean debugfs at amdgpu
To: Yintian Tao <yttao@amd.com>, Alexander.Deucher@amd.com
References: <20200227115040.32447-1-yttao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <fa0bfba9-cd46-de37-2bf4-8f4c3fe4cd74@amd.com>
Date: Thu, 27 Feb 2020 12:53:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200227115040.32447-1-yttao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::29) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR01CA0016.eurprd01.prod.exchangelabs.com (2603:10a6:208:69::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Thu, 27 Feb 2020 11:53:41 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fdf6d27b-8d28-441b-2283-08d7bb7bb0df
X-MS-TrafficTypeDiagnostic: DM5PR12MB2502:|DM5PR12MB2502:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2502B118A50FCAD2617D358A83EB0@DM5PR12MB2502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(199004)(189003)(186003)(36756003)(16526019)(31696002)(316002)(478600001)(6636002)(52116002)(86362001)(66946007)(66556008)(66476007)(5660300002)(81156014)(2906002)(8676002)(2616005)(8936002)(6666004)(81166006)(4326008)(6486002)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2502;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4mqFmJzqcQ62fR+Vv83jnbfxvpyELB+W7ZwMaV8cvVJ/qPmrFR8shCbl6sK8SocadNP6jazOpqboyyq2lBdjhtGxmS7FW5vu5Z39vpNiFCmBcCzVs7rCanIX98oAdeuJyW7Wwnbm8HAmq6pOfWrpZWQM8tw6J10fImW6n/ycvvlKcwSf6rZdo8bAyF4jiB+uXJZEIelDAX2ZmpBKpDlryTMbJwwsHupLX4j+RqyrvNc8g75GiY1Galwym4cdJ4jLPA0B3E/Oh0ALQ6fh0Vhuk+enIqDWYXGxRON/bredrAv0RzlTjvQ6u5Ekdb+ojWLA/Wm9cqMUCk7DN+UjwvjKZnSMpNm4MXzrZfFjKJtVvs7zasA5N3RAByZp4ztCL5Jpw+girKyFmCZctk6XlF34Iuu3VszB7KWJNFXZgMXMH6LiN2sqyhkUMmtPpDIwwb7q
X-MS-Exchange-AntiSpam-MessageData: cm129x7bDhjlO36f7oPwMISAhY+W4UciY5kcF0coV89qsb3zWe3bfqiInhz74vqdj3jvDKoJyFK2f7WRl3vaFpTL1Otsf8qfnw46ohW5B/Xi0fU5Q288p/j31D3ge9b6LtsSqt+lhIkHCVmC6VpkKFv1mEJdLHbXxxOXffeGhPoiPL2Uc1wSveCWJ3OinuL66R/PJV4v7dmGJ83WYwzQ8g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf6d27b-8d28-441b-2283-08d7bb7bb0df
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 11:53:42.1798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WFzK6++zm/rS3d92IhVJoGL5QGmdZ8TUBrrNX2hhsBbTqwWWh3aOoU9X14URfP7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2502
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If we do this we should probably make nails with heads and remove the 
whole cleanup/fini code as well.

Christian.

Am 27.02.20 um 12:50 schrieb Yintian Tao:
> drm_minor_unregister will invoke drm_debugfs_cleanup
> to clean all the child node under primary minor node.
> We don't need to invoke amdgpu_debugfs_fini and
> amdgpu_debugfs_regs_cleanup to clean agian.
> Otherwise, it will raise the NULL pointer like below.
> [   45.046029] BUG: unable to handle kernel NULL pointer dereference at 00000000000000a8
> [   45.047256] PGD 0 P4D 0
> [   45.047713] Oops: 0002 [#1] SMP PTI
> [   45.048198] CPU: 0 PID: 2796 Comm: modprobe Tainted: G        W  OE     4.18.0-15-generic #16~18.04.1-Ubuntu
> [   45.049538] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [   45.050651] RIP: 0010:down_write+0x1f/0x40
> [   45.051194] Code: 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 53 48 89 fb e8 ce d9 ff ff 48 ba 01 00 00 00 ff ff ff ff 48 89 d8 <f0> 48 0f c1 10 85 d2 74 05 e8 53 1c ff ff 65 48 8b 04 25 00 5c 01
> [   45.053702] RSP: 0018:ffffad8f4133fd40 EFLAGS: 00010246
> [   45.054384] RAX: 00000000000000a8 RBX: 00000000000000a8 RCX: ffffa011327dd814
> [   45.055349] RDX: ffffffff00000001 RSI: 0000000000000001 RDI: 00000000000000a8
> [   45.056346] RBP: ffffad8f4133fd48 R08: 0000000000000000 R09: ffffffffc0690a00
> [   45.057326] R10: ffffad8f4133fd58 R11: 0000000000000001 R12: ffffa0113cff0300
> [   45.058266] R13: ffffa0113c0a0000 R14: ffffffffc0c02a10 R15: ffffa0113e5c7860
> [   45.059221] FS:  00007f60d46f9540(0000) GS:ffffa0113fc00000(0000) knlGS:0000000000000000
> [   45.060809] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   45.061826] CR2: 00000000000000a8 CR3: 0000000136250004 CR4: 00000000003606f0
> [   45.062913] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   45.064404] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   45.065897] Call Trace:
> [   45.066426]  debugfs_remove+0x36/0xa0
> [   45.067131]  amdgpu_debugfs_ring_fini+0x15/0x20 [amdgpu]
> [   45.068019]  amdgpu_debugfs_fini+0x2c/0x50 [amdgpu]
> [   45.068756]  amdgpu_pci_remove+0x49/0x70 [amdgpu]
> [   45.069439]  pci_device_remove+0x3e/0xc0
> [   45.070037]  device_release_driver_internal+0x18a/0x260
> [   45.070842]  driver_detach+0x3f/0x80
> [   45.071325]  bus_remove_driver+0x59/0xd0
> [   45.071850]  driver_unregister+0x2c/0x40
> [   45.072377]  pci_unregister_driver+0x22/0xa0
> [   45.073043]  amdgpu_exit+0x15/0x57c [amdgpu]
> [   45.073683]  __x64_sys_delete_module+0x146/0x280
> [   45.074369]  do_syscall_64+0x5a/0x120
> [   45.074916]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Signed-off-by: Yintian Tao <yttao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 1 -
>   2 files changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 8ef8a49b9255..351096ab4301 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3237,7 +3237,6 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>   	adev->rmmio = NULL;
>   	amdgpu_device_doorbell_fini(adev);
>   
> -	amdgpu_debugfs_regs_cleanup(adev);
>   	device_remove_file(adev->dev, &dev_attr_pcie_replay_count);
>   	if (adev->ucode_sysfs_en)
>   		amdgpu_ucode_sysfs_fini(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 7cf5f597b90a..02d80b9dbfe1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1139,7 +1139,6 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>   		DRM_ERROR("Hotplug removal is not supported\n");
>   	drm_dev_unplug(dev);
>   	drm_dev_put(dev);
> -	amdgpu_debugfs_fini(adev);
>   	amdgpu_driver_unload_kms(dev);
>   	pci_disable_device(pdev);
>   	pci_set_drvdata(pdev, NULL);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
