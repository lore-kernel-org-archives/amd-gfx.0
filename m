Return-Path: <SRS0=dANk=CK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FACBC433E2
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 07:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFBB92068E
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 07:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="E6rvBPbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFBB92068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D07C6E5B4;
	Tue,  1 Sep 2020 07:46:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34FCE6E5B4
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2020 07:45:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hse9z4hWXixv8vt6rmarx3O9rCllbNZbmpqIaplI5HUFCXcVCeBCUDBq4MBvZ/QKPd7oJ98JUyxz0Phajk9tGrk6KdfXUzIKhIn0ndL2O6b0CGIevsIRq+DtGZ/tInYUkk+taujFdrmPaRHihT9ArzykqX9Jjp4uVdBcHKffPLJoqXgwZl2oHdOlJhO53ToHM8w1sHkwU046pG3CWy+eFuxSmybH9becwjfNmbT7nkx7dK12Mt/6itheZVqYn63TVNHzt/i7aRLxcJ9MhmSCjtJGXlk7gcYkvxo2Ic2yhzz3q6k3/C4R9hzrshOitgLG7psfyPyq2+ADtBjH0sk3tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK+TxkyjwedjvVg+yAFAKX8GH+RwCJMs0xAu8KQ7nPc=;
 b=Vk2NsFoTjEyYjHb2cVVjrMqRzLDub6I7tjL7XGJmZtp33OWIOCtUyFavWfSh9F9fjHRb1mt1fsiuqsbfxtHn2pBAMTEzlMvnJA7HPvFfr0d86uY4f2SH16WuQOe2AnWwp383rFBJA0sOGwRXRjEs4Z/k6L5VG2JxUHU7Qbnl3tPj2nMorf6j8/5c9bk7EtI9LdMwJMzA2m4BAGZbODYA1YCT9kgdVMcIGvh0NBTqG3EIo/NM2JuoWgbXusdxa3SdEOSA69R1drP6yPhmUZTVxUoZ0nudHol8J1NNDO1NqPzsbHJpGT4GEA99gVltN8BVJlIROGqrCCegx8oRKxm99A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK+TxkyjwedjvVg+yAFAKX8GH+RwCJMs0xAu8KQ7nPc=;
 b=E6rvBPbUSkcx/ktIP65u+y+fVlLzl39Wl3UGvS0Y+OFm6TQ4pfm4n3FYv3aFdkLES6DOyKiWiXaq38h5QnFR0H7cPhhEiGCNC0QDiWi6wW14KdRApvietQYtoFVvMTzpxWN9R+TNftD5R4Sq9q2HyHweXX435eCBPPcgkc7NQHU=
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by SN6PR12MB2734.namprd12.prod.outlook.com (2603:10b6:805:76::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.22; Tue, 1 Sep
 2020 07:45:57 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::c8c0:9bc9:57ed:cb03]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::c8c0:9bc9:57ed:cb03%3]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 07:45:57 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix a redundant kfree
Thread-Topic: [PATCH] drm/amdgpu: Fix a redundant kfree
Thread-Index: AdaAM8FOrTvEfqviRDOZEE5pxC7W1g==
Date: Tue, 1 Sep 2020 07:45:57 +0000
Message-ID: <SN1PR12MB25588CE66B9F67BBAED67655872E0@SN1PR12MB2558.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=88499811-f894-4564-b445-98db696aa6dc;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-01T07:44:19Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca084677-25bd-4585-d2a3-08d84e4b104a
x-ms-traffictypediagnostic: SN6PR12MB2734:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2734FED9DE314E0EDA820538872E0@SN6PR12MB2734.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:245;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V/7/slVPvAJn3IzJ7rZI4Vj4sXYOqnm5P4Ve6RiFkO33Guib/Z+pTm+QtoNDDNIAyUoH9HKj5XezP94Qn8M642B8Pmrto4AC0nQeFkqGXCPBCTjephaxfxBjRkLqcqAtk7eXddeCEFLO7IhVlXCC/YnqpvC/Gh4z+p87rK8+uU3SGolY5nVwB49g+WGxJOx/vANBAGn8TC0bPN2Yyk3rlPBnUFAWKnAdzU4DKYJiSHWMHoC7LMwOZ9L6ZhH8qu6j01KRPLWfTVYtVRR6xxbluW/VjOkECkDLDsSiKannIegTfTndW/OAUfCyu64TyrLB4y6uB4TmTrtSqm3gOR5gsQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(4326008)(6506007)(71200400001)(186003)(8676002)(66946007)(76116006)(6916009)(7696005)(26005)(66446008)(2906002)(64756008)(33656002)(66476007)(66556008)(5660300002)(52536014)(8936002)(316002)(55016002)(86362001)(478600001)(9686003)(83380400001)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 1E/Pzh/KWAhPfMipQaQ8ZAbqnmw4ZPLtr4+1wJvrLEPzQobxViOZqyE99v2lsLF2yczGAAe2NOGo0tB5DCGhcFIvIrAr6h9vI4Oj/4F/7tJxJ80QHUMT4VDO8HsCAcirU2ye49H8y2QLuFkyXnIXxfxy3CINvyXGtBLTkW+4je6BkAt45qJPHMpBTgDuF3UACjbjAR+qFUAw6nBDBIrGdb381uAVaMkqbFwcaTMwa8zYxQKj3unv8ECi/z/AEWfTWphXbGeaL2r36Rkw9GqBQbcfBkKLq15LEh8ng8yWDimC4d4qhwwvIScvUNN49UA3GT8OeERxwnd0wvPqXPsPzj9DnbA6w5z843voUAN19suF9v8LHAnbzGiJpWp/8EpvqaGB3XqsCR3lOoo5mrtMhIReCRVTVP34gIPhKeOtwTMVJL7JoBGTW7idpfnN1ZNEqyJbwS2tUzywwE13UC5CaDTlQwikhtOojGunVn/SDnk+/sw3g5qDSBrvurHTKJOIrYF2bWBVwaNEr8j79BQiUQo0tYugz32hh3uG+HXUm0Bg6dqdcxLbXEwIl8wSjzJjEQd0+VIDImEh0D0LPIz8Ao6UgCqDhrsEomjmISvZk6HG6TmLSFD4DxeejdobU8PSSPtzMSQl/K/ktU4eq+QxQA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca084677-25bd-4585-d2a3-08d84e4b104a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 07:45:57.4368 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fEC1RNxRKhwl97a90uZzlfefDYEM4xVTP7Dfl7ZHtkaxqHzrVXnZle1hMhKD31N3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2734
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

drm_dev_alloc() alloc *dev* and set managed.final_kfree to dev to free
itself.
Now from commit 5cdd68498918("drm/amdgpu: Embed drm_device into
amdgpu_device (v3)") we alloc *adev* and ddev is just a member of it.
So drm_dev_release try to free a wrong pointer then.

Also driver's release trys to free adev, but drm_dev_release will
access dev after call drvier's release.

To fix it, remove driver's release and set managed.final_kfree to adev.

[   36.269348] BUG: unable to handle page fault for address: ffffa0c279940028
[   36.276841] #PF: supervisor read access in kernel mode
[   36.282434] #PF: error_code(0x0000) - not-present page
[   36.288053] PGD 676601067 P4D 676601067 PUD 86a414067 PMD 86a247067 PTE 800ffff8066bf060
[   36.296868] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC NOPTI
[   36.302409] CPU: 4 PID: 1375 Comm: bash Tainted: G           O      5.9.0-rc2+ #46
[   36.310670] Hardware name: System manufacturer System Product Name/PRIME Z390-A, BIOS 1401 11/26/2019
[   36.320725] RIP: 0010:drm_managed_release+0x25/0x110 [drm]
[   36.326741] Code: 80 00 00 00 00 0f 1f 44 00 00 55 48 c7 c2 5a 9f 41 c0 be 00 02 00 00 48 89 e5 41 57 41 56 41 55 41 54 49 89 fc 53 48 83 ec 08 <48> 8b 7f 18 e8 c2 10 ff ff 4d 8b 74 24 20 49 8d 44 24 5
[   36.347217] RSP: 0018:ffffb9424141fce0 EFLAGS: 00010282
[   36.352931] RAX: 0000000000000006 RBX: ffffa0c279940010 RCX: 0000000000000006
[   36.360718] RDX: ffffffffc0419f5a RSI: 0000000000000200 RDI: ffffa0c279940010
[   36.368503] RBP: ffffb9424141fd10 R08: 0000000000000001 R09: 0000000000000001
[   36.376304] R10: 0000000000000000 R11: 0000000000000000 R12: ffffa0c279940010
[   36.384070] R13: ffffffffc0e2a000 R14: ffffa0c26924e220 R15: fffffffffffffff2
[   36.391845] FS:  00007fc4a277b740(0000) GS:ffffa0c288e00000(0000) knlGS:0000000000000000
[   36.400669] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   36.406937] CR2: ffffa0c279940028 CR3: 0000000792304006 CR4: 00000000003706e0
[   36.414732] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   36.422550] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   36.430354] Call Trace:
[   36.433044]  drm_dev_put.part.0+0x40/0x60 [drm]
[   36.438017]  drm_dev_put+0x13/0x20 [drm]
[   36.442398]  amdgpu_pci_remove+0x56/0x60 [amdgpu]
[   36.447528]  pci_device_remove+0x3e/0xb0
[   36.451807]  device_release_driver_internal+0xff/0x1d0
[   36.457416]  device_release_driver+0x12/0x20
[   36.462094]  pci_stop_bus_device+0x70/0xa0
[   36.466588]  pci_stop_and_remove_bus_device_locked+0x1b/0x30
[   36.472786]  remove_store+0x7b/0x90
[   36.476614]  dev_attr_store+0x17/0x30
[   36.480646]  sysfs_kf_write+0x4b/0x60
[   36.484655]  kernfs_fop_write+0xe8/0x1d0
[   36.488952]  vfs_write+0xf5/0x230
[   36.492562]  ksys_write+0x70/0xf0
[   36.496206]  __x64_sys_write+0x1a/0x20
[   36.500292]  do_syscall_64+0x38/0x90
[   36.504219]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index c12e9acd421d..52fc0c6c8538 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1165,7 +1165,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 if (ret)
 goto err_free;

-drmm_add_final_kfree(ddev, ddev);
+drmm_add_final_kfree(ddev, adev);

 if (!supports_atomic)
 ddev->driver_features &= ~DRIVER_ATOMIC;
@@ -1221,13 +1221,6 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 drm_dev_put(dev);
 }

-static void amdgpu_driver_release(struct drm_device *ddev)
-{
-struct amdgpu_device *adev = drm_to_adev(ddev);
-
-kfree(adev);
-}
-
 static void
 amdgpu_pci_shutdown(struct pci_dev *pdev)
 {
@@ -1522,7 +1515,6 @@ static struct drm_driver kms_driver = {
 .open = amdgpu_driver_open_kms,
 .postclose = amdgpu_driver_postclose_kms,
 .lastclose = amdgpu_driver_lastclose_kms,
-.release   = amdgpu_driver_release,
 .irq_handler = amdgpu_irq_handler,
 .ioctls = amdgpu_ioctls_kms,
 .gem_free_object_unlocked = amdgpu_gem_object_free,
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
