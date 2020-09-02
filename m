Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C21C433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 02:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3EC1206F0
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 02:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EKAj5xk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3EC1206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E80896E0B6;
	Wed,  2 Sep 2020 02:44:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE9746E0B6
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 02:44:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDnTluWMng9rXzLgFK6szXXhzd2cZNcm/xPutAhP7yUnI+RuC/n2+3f/j0PfLW5flpXYdnVFA8skJaNdUP9HHagHTxVa5CwcOG7qiu8L32fQhfI+7ae7UPeiNAITsXwCNdVBuuDaobrIXdc+VXNn3/dAaCiv3K4g3hTlkeCNpa4OxW2F18izMarTTvsxJ2ADMyh11Fie9t+ZCfUpimhXsuPrhYyhZ6VUcxjKYPozxl1SXfREw6187JvVr6LNMXDJha5F4RXZ8SQwdDINpYnQXnTr5Dx+uxVNvPJKq/bVjm41etuAzZJYNC+HFayFvVtSQosIOxnmuJx9/qY+AHWJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrNECaWPiHPJJohYqkGrylpRU3c/MeJ099C9gBwXKTs=;
 b=MgdDv2x1eSGr4Z3n3cEamwKyYAddMEsy06axdzhTJnYIcngsgLwG2rlbe3ryKk97OnVpkl/lqkKv6FIe79INsuT/gxh3Ra2QU1fq237ODMPYoiHOm0W5kvIxplp4Ej1jgKfLVGR9te+dHfRkyMWh68vFWWWb8mAHIF2zWhMhm/yMw8kwioNGG7uwriP5NsJw6xYxwOVy8b+PEap+qjPM+7eudPNfa7o3iUnHlWRrN63gf8vmarVTZA6Qk19Ltkp/L2WNIxPYRxDtEOF4XFFMTa90jhktumRWKZ4xzgw9eVOPdr3mNBAmlxadOfpf49wijrGsR9WDfeqCngCQS/SlDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrNECaWPiHPJJohYqkGrylpRU3c/MeJ099C9gBwXKTs=;
 b=EKAj5xk2JFAfpl81K5pv0NjnGDcv8Tht0JGkN4qsKdbIuuWxRzymsNpBKwhjKGUtTjslGpNxVCn7Cquzw5Gi1gvtBRPVC3/dQfKSsrCPUd1fqIVz7j8qx9+l8COAgT7qRMJJG0oFBhUz9wOieSku0Vyzna/r1uVnjp4azBfqVXI=
Received: from CY4PR12MB1623.namprd12.prod.outlook.com (2603:10b6:910:6::16)
 by CY4PR1201MB2550.namprd12.prod.outlook.com (2603:10b6:903:ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Wed, 2 Sep
 2020 02:44:45 +0000
Received: from CY4PR12MB1623.namprd12.prod.outlook.com
 ([fe80::9d61:d60c:1042:b493]) by CY4PR12MB1623.namprd12.prod.outlook.com
 ([fe80::9d61:d60c:1042:b493%3]) with mapi id 15.20.3326.020; Wed, 2 Sep 2020
 02:44:43 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Fix a list corruption
Thread-Topic: [PATCH] drm/amd/display: Fix a list corruption
Thread-Index: AdaANXHsFxjyWnshSmypHEDzrWBPDQAnX8IA
Date: Wed, 2 Sep 2020 02:44:43 +0000
Message-ID: <CY4PR12MB1623215E2BE1FF082038F56BFE2F0@CY4PR12MB1623.namprd12.prod.outlook.com>
References: <SN1PR12MB2558E28ECF0CC02A594BE1A2872E0@SN1PR12MB2558.namprd12.prod.outlook.com>
In-Reply-To: <SN1PR12MB2558E28ECF0CC02A594BE1A2872E0@SN1PR12MB2558.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=fa50ea72-f41a-407f-b874-c85b2beb0a10;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-01T07:56:35Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bcc6a76e-c5d4-4d9a-66fb-08d84eea259b
x-ms-traffictypediagnostic: CY4PR1201MB2550:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB25506CB1090EFFC3168AA4D4FE2F0@CY4PR1201MB2550.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KTI07eQup1VbpT/u3za5GZfCcoE5crD56m22hWDCuajyTLBJkJM8Y72Hq0OT63MXC/Q/lf52NuNCwRgoWeFg86CBjpecCrA4PDOJcEGuLRp0F39yXiyAEFpJD+DDKj1nSfBOqNC3JOAyqW7tHtF3e0/KHz4hgMevjuJm2Q62F5+Cw/zWaadU/ffaXSzELM2IDLqiwz8KxTy2CfRrx0EJbR8P7H043gkoHQ6PwqYX0tzS9LCj3J7lbtc/IxQTUZtGhOMUM70n+o+FMWrSUdkvSMnwtan3SyX8AWx0UhS0b/3MxbCFsCmR2cWXzN6+AohSsfD1veSNOvOV+GK6FoJQHfzQ4lQFBitLdtkH6xWLjbE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(86362001)(45080400002)(83380400001)(71200400001)(316002)(26005)(9686003)(2906002)(478600001)(186003)(110136005)(4326008)(966005)(52536014)(55016002)(76116006)(66946007)(33656002)(5660300002)(66476007)(64756008)(66446008)(8676002)(66556008)(7696005)(8936002)(6506007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: i9iMfU1m3s3HQAKT6AYhwOnok7AD890V7Q79NFaItOi1bnfpaGeADr0gO2vqrV16/OIdKglw3t566zzcnxdKDqvq3i6R/oUpJvbfv/iFZ6MQiLE0hsyEkk1Ff8MVyKxxJWoIz5Af1yckQoHZNE1bdLjGRM4KS02JIyXVECnSI/pIa3+wGDQZtn2UyUtpvAkBvEROEt91dc1d2E+ovMC5yQtczM7ylvB+BIurkwA2hF/kwmDawoavrqOHkCte0/lBjDOZk6wxs+fqd2NIsQZjOZZy3YBccCc9f6Hvnq7B3DyHz9IBC7vkTQVmv+AyJFfT3E2FrShQM2dV7Baq6V/Qv+3CUABYJMCWMzIhMkox+PGWScXZh8TluyFFqtOACG1SfOxVq6mCZvvKvzqCwfvheWQUoaBYlow4F4heqUr29VdIxYmGGbpD4LyWFiCPzbg7pr/4q4wNhHeNwldsLUdU9+WH5Y+kobEgnPytlmgg/rIcxcn1dWmMbhiUnKGfmqJvTF+TvgGAq5mVg1yeKkEvVoCRAAjoIdy2FQNfqsQzhTg+LF3PaLnqT0gQiDqZ71K/PVLwG5I5oRW1ID4oMx9CsQALW+F9q1ZS7emoQT1Qq5Koc340I8mTuJovbrejA1zXxFct9ocb5X3ClgBZVMn1hA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc6a76e-c5d4-4d9a-66fb-08d84eea259b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 02:44:43.1631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pFowRTooWUosdXIlrADJH9ywn8LznMvkX+i9e4P3qIRNog879Y7rsTYoOU33oOmn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2550
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

Acked-by: Feifei Xu <Feifei Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Pan, Xinhui
Sent: Tuesday, September 1, 2020 3:58 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amd/display: Fix a list corruption

[AMD Official Use Only - Internal Distribution Only]

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
@@ -5076,6 +5076,7 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)  struct amdgpu_device *adev = drm_to_adev(connector->dev);  struct amdgpu_display_manager *dm = &adev->dm;

+drm_atomic_private_obj_fini(&aconnector->mst_mgr.base);
 #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) ||\
 defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CFeifei.Xu%40amd.com%7C39a1103c3dfc4794778c08d84e4cb1c2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637345438618002415&amp;sdata=WXlcZfzbfIKcrcCR8DQoT2GerjWbT0MorFil%2FP3LCAA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
