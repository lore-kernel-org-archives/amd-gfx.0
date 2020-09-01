Return-Path: <SRS0=dANk=CK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C17C433E7
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 07:57:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72F602065F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 07:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="26vzShuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F602065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 352866E5B4;
	Tue,  1 Sep 2020 07:57:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 114D16E5B4
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2020 07:57:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ld03B3wrON5XzIv4Uqv8GgTMwSKiz1ljO7N5lit/7VNnwxX/jExnWY5m29m2qLNf4J9LfvsRbeqGeSnPkS5eAs7Piz4v222JJOKsZ7Yjy9B1SOja1JuqjeIfH2VfH5c76wgTr+d3VRLnoIRUsyzC6I2Z1s0a03hpR0LBW0UqZEPkYja32CECSagvrr//IT5GWXrUNj7rwiHnida6MRHw238DcqxOg5QP7EKxrtjdF1L+xx4aepM8qiQbN0Bi1qsy3C4ooC3rhiAlCsax5e4s4z47vqJH4YbdUiIamPcONTKBrGp7XqRylean4+YViqWRzDScVU57BZDc/lhPbXJGfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1hLmFW3t32hEURODm+uZ+xbAilYrtt5kfYdf5jYqlE=;
 b=ktxrwX+OwIYOOp2jxScfBKV8FvTONXNKjHPlU1OpQ2fNBkr63MHShiS7iW3YnNfuqG8Vv3mPgBr/8e9BdhXefOtFe7D3Ry015knvZg6YMFfQAWu3xZNrMY/UJdsw3b2CUkLkI3ab8gr7c89sIesppDerKG/iVCWqYNku0qkv5sKDWHizYD28HqRospRHSAVbW4Qk0w+nI0aUhXjnVKdRnaWQPOAOfht2wvKhgsVY3FX3ALJzjk4d7BvPnYUCuYzb09N8S18AuDQv0CbAq+WeaKnhupq26Ok4Czw7IxYhOFHIEjKiMwnCiJkqxGZWi8aYpxDlDQrq0FqiMpXvgbGkDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1hLmFW3t32hEURODm+uZ+xbAilYrtt5kfYdf5jYqlE=;
 b=26vzShuyLW2SCOM4N2GZuxF+uncYrRcQFr1NjM36/4JZmw7k/X2agh3MH7P+GJotyAmvAR8jcFPGtV+6JfZRe0gnVo7bHrTd20jhoIkths9XuLbM+J+/d9HCIp3UoBOIwc2B58cM07XiU4pm0g4moWPIA7310HNRyoO7vc+oBCM=
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Tue, 1 Sep
 2020 07:57:34 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::c8c0:9bc9:57ed:cb03]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::c8c0:9bc9:57ed:cb03%3]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 07:57:34 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix a list corruption
Thread-Topic: [PATCH] drm/amd/display: Fix a list corruption
Thread-Index: AdaANXHsFxjyWnshSmypHEDzrWBPDQ==
Date: Tue, 1 Sep 2020 07:57:34 +0000
Message-ID: <SN1PR12MB2558E28ECF0CC02A594BE1A2872E0@SN1PR12MB2558.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=fa50ea72-f41a-407f-b874-c85b2beb0a10;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-01T07:56:35Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 29849428-b5b8-4950-841d-08d84e4caf8e
x-ms-traffictypediagnostic: SN1PR12MB2558:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR12MB255863DA015E6DCEB30F111B872E0@SN1PR12MB2558.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VUM59UBIEjBhJSQijSssSNNe0Ul0aAhCcVIg1SBCmTFSTfHVbC3z1WMMTWMTDdVuFDxF7JtQimKICXmtKUGsQdtFLviS0Q6cQDyKtHrEC+THYYvb4/De170U4iRs49X05C70Emu1U77/0Si31bqrACG2/O24mTBw6QTKMgfZZbkp2smxTTLzp5DRM/JDNxeY4VATDK3ciB34MTo7MJE/NUTWyTz4xdXEmqE6SqAzzr/VUDpXLz+8Ep4Fm8nNdglAMlqM+NJLMHsJmQSiCuq9NnZAttg/5FHt5/M7eHzzELoZtB9bBJVSrckd5Dqyd7dS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(2906002)(66946007)(66556008)(26005)(316002)(66446008)(64756008)(76116006)(66476007)(9686003)(55016002)(6916009)(86362001)(83380400001)(186003)(4326008)(33656002)(7696005)(71200400001)(52536014)(8676002)(478600001)(6506007)(5660300002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: dhq/fG7XYyP792oX34t5Fl2d0mKZA1xF1p8flmYBtc1GybQsR4PwARTn7T9iYiIwHb92FZ16UsBrQ7nTb5bkEhFbkqVTzoW+0Txy76/4fPLmh2OrKaMtIQxnbUniF76wdh7KlF9eHfHuf79sokifPLXRkfd7NBRrh2Iup5dbHzYJKgvKFUJc0clCDcYnzn5kmsDd05IRqFxXz1b2K8NajiYaT8hkW8oJpxaBfGWpkAjwBZ0+3WM/iL0bl4EAKZm7cVaREsAGn6gKAeaYDmLT7j/SxJ0SJkmFpWV+zqlQqKzE2AosyAQUp42s/Y7DEdtbXtlER9mpP9kYp/1f+/usgYm0Xo05kLsTO18ijZX3f0b34xxcua2/dc7gDOok58Kti1TZvRx8EJEbyqSxbdpEc+0XbN6XOGV7zGWFb9H/o0iWMxJxvm1Qot2CHjiGMN8tlrGlKDd467O775AA9MZb/9x/aozrQkcYAvikEzT5Pu0nrBZqBbcUmKSc/gmItjgNCrYORWr/qz+LPoUk2A/SQTG+2mpe2szUwYUOvcy1SXLBpbgnJRD0Vn4tyYefwGdIkQ4LUITlKsOluwgNjl0Jz6/VqFIzRUVDLGoF9ojZjAsr5VPazmEqxHpaia7RBGc/iAn/dkSdCtwJMqxFyFOgTw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29849428-b5b8-4950-841d-08d84e4caf8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 07:57:34.1759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dPTtk2aRhRgbkDbayBxouhMX7XucJzPJmShWXvUz3maJf+F3ERMjQmzWwXe4wTg/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2558
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

[AMD Official Use Only - Internal Distribution Only]

Remove the private obj from the internal list before we free aconnector.

[   56.925828] BUG: unable to handle page fault for address: ffff8f84a870a560
[   56.933272] #PF: supervisor read access in kernel mode
[   56.938801] #PF: error_code(0x0000) - not-present page
[   56.944376] PGD 18e605067 P4D 18e605067 PUD 86a614067 PMD 86a4d0067 PTE 800ffff8578f5060
[   56.953260] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC NOPTI
[   56.958815] CPU: 6 PID: 1407 Comm: bash Tainted: G           O      5.9.0-rc2+ #46
[   56.967092] Hardware name: System manufacturer System Product Name/PRIME Z390-A, BIOS 1401 11/26/2019
[   56.977162] RIP: 0010:__list_del_entry_valid+0x31/0xa0
[   56.982768] Code: 00 ad de 55 48 8b 17 4c 8b 47 08 48 89 e5 48 39 c2 74 27 48 b8 22 01 00 00 00 00 ad de 49 39 c0 74 2d 49 8b 30 48 39 fe 75 3d <48> 8b 52 08 48 39 f2 75 4c b8 01 00 00 00 5d c3 48 89 7
[   57.003327] RSP: 0018:ffffb40c81687c90 EFLAGS: 00010246
[   57.009048] RAX: dead000000000122 RBX: ffff8f84ea41f4f0 RCX: 0000000000000006
[   57.016871] RDX: ffff8f84a870a558 RSI: ffff8f84ea41f4f0 RDI: ffff8f84ea41f4f0
[   57.024672] RBP: ffffb40c81687c90 R08: ffff8f84ea400998 R09: 0000000000000001
[   57.032490] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000006
[   57.040287] R13: ffff8f84ea422a90 R14: ffff8f84b4129a20 R15: fffffffffffffff2
[   57.048105] FS:  00007f550d885740(0000) GS:ffff8f8509600000(0000) knlGS:0000000000000000
[   57.056979] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   57.063260] CR2: ffff8f84a870a560 CR3: 00000007e5144001 CR4: 00000000003706e0
[   57.071053] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   57.078849] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   57.086684] Call Trace:
[   57.089381]  drm_atomic_private_obj_fini+0x29/0x82 [drm]
[   57.095247]  amdgpu_dm_fini+0x83/0x170 [amdgpu]
[   57.100264]  dm_hw_fini+0x23/0x30 [amdgpu]
[   57.104814]  amdgpu_device_fini+0x1df/0x4fe [amdgpu]
[   57.110271]  amdgpu_driver_unload_kms+0x43/0x70 [amdgpu]
[   57.116136]  amdgpu_pci_remove+0x3b/0x60 [amdgpu]
[   57.121291]  pci_device_remove+0x3e/0xb0
[   57.125583]  device_release_driver_internal+0xff/0x1d0
[   57.131223]  device_release_driver+0x12/0x20
[   57.135903]  pci_stop_bus_device+0x70/0xa0
[   57.140401]  pci_stop_and_remove_bus_device_locked+0x1b/0x30
[   57.146571]  remove_store+0x7b/0x90
[   57.150429]  dev_attr_store+0x17/0x30
[   57.154441]  sysfs_kf_write+0x4b/0x60
[   57.158479]  kernfs_fop_write+0xe8/0x1d0
[   57.162788]  vfs_write+0xf5/0x230
[   57.166426]  ksys_write+0x70/0xf0
[   57.170087]  __x64_sys_write+0x1a/0x20
[   57.174219]  do_syscall_64+0x38/0x90
[   57.178145]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f52533ee7372..cb624ee70545 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5076,6 +5076,7 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 struct amdgpu_device *adev = drm_to_adev(connector->dev);
 struct amdgpu_display_manager *dm = &adev->dm;

+drm_atomic_private_obj_fini(&aconnector->mst_mgr.base);
 #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) ||\
 defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
