Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4467C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 07:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6706720716
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 07:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Tu7bz84v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6706720716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06D4E6E179;
	Thu, 13 Aug 2020 07:54:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 405C06E179
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 07:54:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNztcinhOMiwYcuF6KmXnITFL85qZstHmn+u4svPJtxiQWVt95dD6KYr2JddGnqpa+L43NoHMv5Rly10i/oM5j60gA08cptQDfB9scwzaoyZVyElMzQlaKkOgsTuhjOFZbjJS8bzBPtCPE1WBZbqAPZZ1HZnQBe4n8aKUZYQccNrPad4wsHtmxcu0iGNEld1Jvva1uj1QvwwLZrFr3FYjYWCOF4CNtDIqxx9douiqzfZ6gGK4e+uucku57QWcMtTFf7kJNvGS63RwfW97OIymiS9nLi1e7OUT/FhtFASgLTBPIaJGG1laxhNSf9DpVltYsbaGRtzU+cpXM3TOstFeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9XFuy+9pAP8toGvKJTR0MVLeu4Vejzg591jbxmBPOA=;
 b=HBtGsZFLltSTTU8X4ycG0HWEzAV9coHeG4LqJLyXmHHQF7VqEEUDS2TfgnRDiXEe8CJEDiyDd4z3ywgdRvufdqUQRpMBN+wAyluOyvAzU6ReueTBbOTnnRgzh2wpHvw+2DGPInh4X0fSa7RhqkIwXhADCa1ABo57MMiwncQPKWFkHAHv8VgZLcJP8KcEotXkwDaZmNY7HQlh8VwGG6Mvwuh1wwMx4cGgZTKkNMmeK6WF5NSzCq96R3v7wd+xdcvo74EcNgHHq6PB/V8AVImvmOmkp4tZJjPEn/svRQXWROAQXZEUeXO39lzp6cdaYSDXMdDcWti9p+uUqyP738ZLXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9XFuy+9pAP8toGvKJTR0MVLeu4Vejzg591jbxmBPOA=;
 b=Tu7bz84vJYk+EpoDiyw2SAeaazslMmp5w/VtGSeRj9Ql1vvFgfbIGXhHn9hGI0a6C6ih/GEuYWDScwconmwBongu2mSntlHa8YjCBmNa+jQkc4BMksDRRzDLIUIpZORtNYq3wQRPxNkLLKT8phQSk0lGFt9D/b75edN1odNKAuA=
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BYAPR12MB2696.namprd12.prod.outlook.com (2603:10b6:a03:68::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Thu, 13 Aug
 2020 07:54:50 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf%4]) with mapi id 15.20.3283.016; Thu, 13 Aug 2020
 07:54:50 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>, "Clements, John" <John.Clements@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix NULL pointer access issue when unloading
 driver
Thread-Topic: [PATCH] drm/amdgpu: fix NULL pointer access issue when unloading
 driver
Thread-Index: AQHWcT1OF1zmn7Tg7kucfP9pmHff06k1q3Tw
Date: Thu, 13 Aug 2020 07:54:50 +0000
Message-ID: <BYAPR12MB28883CB9D1BB8CD935BAFD34B0430@BYAPR12MB2888.namprd12.prod.outlook.com>
References: <20200813064446.23994-1-guchun.chen@amd.com>
In-Reply-To: <20200813064446.23994-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-13T07:54:40Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=bd61ff83-62b2-4779-9305-00000d5657ba;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-13T07:54:33Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: bccab724-5ba9-493a-84a6-00004fcee24c
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-13T07:54:42Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 2c92a6d6-8af3-4897-8a3f-000091cb828b
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b2e5b4f8-c1e3-4232-6202-08d83f5e2820
x-ms-traffictypediagnostic: BYAPR12MB2696:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB26963A2062C03C0ADBD0261BB0430@BYAPR12MB2696.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cc4KmpD1QUo9KuCnEHNRKsNwGCF3ClRjH99xMo3mFkfPdDfiKVkhpw0mAV2ykjS6hj3nA7LS/mr2c5ADX/Vb8hx+PV+EKmyh+HKKJWPsu0cuP/RyGMn9ejk2wXGGaU0VIrPsLuFsOrF/eSvXALGr83AqvMcJv3c5ERZ/eykHDtD/Z7oj8PaRTp3m0mnCMaiePkEn9t3aVQsIv5cgH3b651wrgwWbJThJRfLv7BhjAwyS8XyPjWVLr/2NA8oUmrcR3KAtLlHVFPRvXo9qFUpZHvkMCVkeMOMiim8sAmMcPZEc+MK61+XkPCNRmhliv0O8WlVcySVJhl/LjHJLbVkiyg0EOwttgpQi+y1TNau4RMbKr14xPZBabtmfwLGQsxcP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(6636002)(76116006)(53546011)(186003)(6506007)(71200400001)(2906002)(26005)(33656002)(66946007)(66446008)(66476007)(66556008)(64756008)(86362001)(7696005)(478600001)(52536014)(110136005)(316002)(83380400001)(55016002)(8936002)(9686003)(8676002)(5660300002)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: XIrOEPlOaBDoA2W3mShtj2fREUaX/DRFC+zKjCjZK6QSUtuVkSP06Po2tgHJa4J/W5IocxEGsoPEfhSY6xMo848XoixBUBCRpc3NLXgEGDFPrC3zgFceat73WDZ94aoyLSTSCtIvBGv/4U317mOEp0OckaGRQ/tk3pPmxr7A9UNG+58nUpii1wIdESHwgJ1V3cjCHJJYOx1LXokDSNJPTcsdXkEcK9cuSIX2uKQB/XUfvh5BqZhY9atDNshAxSZQO+0s86+7F4B2/LRiEjqHomjzWrfLR8a3Bh/IEQG9jAdXoz6j5KLvfNk2b9euj5dIYSfezZIAYVioMzRxQLBZPQdTjjQjWQpoIOG5w3by84HVmzLmSAFsaNn4VOx2jZrVYSt4Orzax1uRnjNtnWPbK8NYYcWQdLkf+TuZWAp6rkK+bbcMf8+TQMptbrxEqnq5AuNhk5MPcus4D4Gx5C2UvL2q8R5Qjsgtj7XoffsXoOzQ5ku2YwwtmVLmvLQGlA2OUHpHcH2QKowFm4mZ3o/AdJIJGIae4iG2YPeemzGJp+zVjmV1IJERaDMZxWvG9XH1C3tIy+n0UGgriDwaH9OIeNCQ1b7xDnPKg1oac7arXoKItoB6+4n0Wdb2ERROz23+nxloZkRyhAUqcHOvoGHrKA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e5b4f8-c1e3-4232-6202-08d83f5e2820
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 07:54:50.3492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jf0K/SzP2aAsl87EHh7K196xzrOQ0bedPNhhxJfXb/3wmxpCO8yYsEfa5SWOJBfT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2696
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Thursday, August 13, 2020 2:45 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>; Deucher,
> Alexander <Alexander.Deucher@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH] drm/amdgpu: fix NULL pointer access issue when unloading
> driver
> 
> When unloading driver by "modprobe -r amdgpu", one NULL pointer
> dereference bug occurs in ras debugfs releasing. The cause is the duplicated
> debugfs_remove, as drm debugfs_root dir has been cleaned up already by
> drm_minor_unregister.
> 
> BUG: kernel NULL pointer dereference, address: 00000000000000a0 PGD 0 P4D
> 0
> Oops: 0002 [#1] SMP PTI
> CPU: 11 PID: 1526 Comm: modprobe Tainted: G           OE     5.6.0-guchchen #1
> Hardware name: System manufacturer System Product Name/TUF Z370-PLUS
> GAMING II, BIOS 0411 09/21/2018
> RIP: 0010:down_write+0x15/0x40
> Code: eb de e8 7e 17 72 ff cc cc cc cc cc cc cc cc cc cc cc cc cc cc 0f 1f 44 00 00
> 53 48 89 fb e8 92
> d8 ff ff 31 c0 ba 01 00 00 00 <f0> 48 0f b1 13 75 0f 65 48 8b 04 25 c0 8b 01 00 48
> 89 43 08 5b c3
> RSP: 0018:ffffb1590386fcd0 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 00000000000000a0 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: ffffffff85b2fcc2 RDI: 00000000000000a0
> RBP: ffffb1590386fd30 R08: ffffffff85b2fcc2 R09: 000000000002b3c0
> R10: ffff97a330618c40 R11: 00000000000005f6 R12: ffff97a3481beb40
> R13: 00000000000000a0 R14: ffff97a3481beb40 R15: 0000000000000000
> FS:  00007fb11a717540(0000) GS:ffff97a376cc0000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000000000a0 CR3: 00000004066d6006 CR4: 00000000003606e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400 Call
> Trace:
>  simple_recursive_removal+0x63/0x370
>  ? debugfs_remove+0x60/0x60
>  debugfs_remove+0x40/0x60
>  amdgpu_ras_fini+0x82/0x230 [amdgpu]
>  ? __kernfs_remove.part.17+0x101/0x1f0
>  ? kernfs_name_hash+0x12/0x80
>  amdgpu_device_fini+0x1c0/0x580 [amdgpu]
>  amdgpu_driver_unload_kms+0x3e/0x70 [amdgpu]
>  amdgpu_pci_remove+0x36/0x60 [amdgpu]
>  pci_device_remove+0x3b/0xb0
>  device_release_driver_internal+0xe5/0x1c0
>  driver_detach+0x46/0x90
>  bus_remove_driver+0x58/0xd0
>  pci_unregister_driver+0x29/0x90
>  amdgpu_exit+0x11/0x25 [amdgpu]
>  __x64_sys_delete_module+0x13d/0x210
>  do_syscall_64+0x5f/0x250
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 6170d7d28495..35d5bf9e6f6f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1276,7 +1276,6 @@ void amdgpu_ras_debugfs_remove(struct
> amdgpu_device *adev,
>  	if (!obj || !obj->ent)
>  		return;
> 
> -	debugfs_remove(obj->ent);
>  	obj->ent = NULL;
>  	put_obj(obj);
>  }
> @@ -1290,7 +1289,6 @@ static void amdgpu_ras_debugfs_remove_all(struct
> amdgpu_device *adev)
>  		amdgpu_ras_debugfs_remove(adev, &obj->head);
>  	}
> 
> -	debugfs_remove_recursive(con->dir);
>  	con->dir = NULL;
>  }
>  /* debugfs end */
> --
> 2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
