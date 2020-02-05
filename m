Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F8FC35254
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 12:56:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A11B20702
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 12:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CZ4B+ZhZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A11B20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 026A36E98C;
	Wed,  5 Feb 2020 12:56:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F086F6E98C
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2020 12:56:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvjG4QYTJKy887mKfll4VcChuoBPNMB21hXSZWI4+tM0LbkZJzBLz1H9lbbWoQjiaXzsGJcJLhLZ4QXiGIitifm6bfoEN0/pNrGWHFkcE1dqdiOpIVPd7c4GN09EbcijMoaiPAJ8bPqGEgnWT6ir7KG5hG0hTLdsu36QqAEj65nXOGP0nZjN4QCs5pipe4yAClbeUFCfbWj3Z1bZo1V4iKdtCBAhvX3uQvaURmnW0nMP5NHJwXWgVO6a97oPrj34BgbIOUd34m0SQUt2UzlNUNiQfaciB+yG2hKG6xFZ4YlQcg6ZBcy+AsFNwwrM1FB4SbgIi206cCcKF/7o+OuiYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTM5kHLQbu43szbTxX2CK01hPzcmRsPuf3wo6oiq3oc=;
 b=D9IYgoF4vct5TLBhVA3CnwP3U7lXZuUXUr6WxWnCai5ucTJT0KT2l4P95EDC0LFgNUuQ8PIiheKpBPxWQsNFbWfKDOaG7qeKwn7Q1cwCnfdYXicF1++iKC/SEjUvmDRJf0u9CB5ir3hrlwckEnsdyFj6Cf2KXQEhZc9EEWWSJphGOE+L5vUBlFcQCdFgYcISQ3V1YjSxn8QxvxLZk9DaAnRpLyJhvwgypXWaczUX7o0m3gBWJjUfHTbDic2W7fHdRpiWTBJzEYAV6iERvnrn09uDHRo0grJF+O92U03B3hb1S+8fzKOy4r+2Gm9dF9l/hOG8pgbciFL3d4QHu2yiBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTM5kHLQbu43szbTxX2CK01hPzcmRsPuf3wo6oiq3oc=;
 b=CZ4B+ZhZpjMAnDg5Oi/rGecMGLqrPnkuSfiXFEAvw38YpJaLwzntn6KbqUP24JSe7AQ94GJpieqjwCsgqx0rmyni0wyin1XnVoLmoTaZfZHsaGXVCXXBZFdVDgWyW+Zywj0H7ZZQ5DKd3ur16NGcqq1CaJBYOiXfRCLp1WQkLeg=
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (52.135.101.138) by
 SN6PR12MB2831.namprd12.prod.outlook.com (20.177.251.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Wed, 5 Feb 2020 12:56:04 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::b99c:18c0:8685:1c10]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::b99c:18c0:8685:1c10%5]) with mapi id 15.20.2686.035; Wed, 5 Feb 2020
 12:56:04 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [RFC PATCH] drm/amdgpu: Remove eviction fence before release bo
Thread-Topic: [RFC PATCH] drm/amdgpu: Remove eviction fence before release bo
Thread-Index: AQHV3CLD8tZCMU7icUO2w2fUQeUFBA==
Date: Wed, 5 Feb 2020 12:56:04 +0000
Message-ID: <SN6PR12MB28003CCDAC027B461B900FA287020@SN6PR12MB2800.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-05T12:56:00.420Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f5139cee-f261-4177-ea2f-08d7aa3ac2b2
x-ms-traffictypediagnostic: SN6PR12MB2831:|SN6PR12MB2831:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB283157A1C53138379749824787020@SN6PR12MB2831.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0304E36CA3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(199004)(189003)(8936002)(6506007)(2906002)(478600001)(4326008)(33656002)(186003)(81156014)(316002)(81166006)(54906003)(86362001)(6916009)(26005)(5660300002)(52536014)(55016002)(7696005)(66946007)(71200400001)(64756008)(76116006)(8676002)(66476007)(9686003)(66556008)(66446008)(91956017);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2831;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qsXaDLTWQ2nOyUf9wCUBcZZ+iiCKbXBGopywvWch2Qi8eAKjLLQiAOic7AKGDEykEGbtt3JD8OJdhAUgit+z9da53hNlYgCwAr5uKaTbskDeJCbv1es3GOCOfb08dPvVAyHK+stEUH7AzN9Z3wAKgBPc3hDHGj+oYtCtkEa5GAN8MBDtCRH+6K+Po75xb/sQ76D7h/oszB6dDiUKbkwaJnbCCQY3wlPxH36jMHs3DVnvxy2DeTf72cKaDlhz6moKiislzkdhP/m/Cdvuxcku9HCuxT8WcNauuHNxj8Ta+CvIJR8L2WvFD4+yDuz91sl6cLuGa3kMpD6HWGs5bKI8xs7atnPaAoJkHNz8znFOSCO2HHlRYFWH5QHW2eitwjgh6o4BGi9BzHT0FeLf4P4hRTDQmg+9hPx3wQ/TPc1fmc/6/a5z+xDNFlPeRO45uI8s
x-ms-exchange-antispam-messagedata: 7LIbADJgoE+gFedxtaFieK0o12SwCG0qRWTE5JoFw6B0vft+sSxZ+Hv9wsvawqHbZVVhfKIAhQUdjrycAEtZkeDRg8aH6quIQDV1ZgYMVmVfHiA4SQn6DWIUtDmDfFuOy3w9E+G9CTv4HYvk1ICorA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5139cee-f261-4177-ea2f-08d7aa3ac2b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2020 12:56:04.4686 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HvThmNovY8CPu9EhAvu/q2Og8wlW5j5oZnQtKzbutYKCs/eMaFVPfpxdRGOnGGH8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2831
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


No need to trigger eviction as the memory mapping will not be used anymore.

All pt/pd bos share same resv, hence the same shared eviction fence. Everytime page table is freed, the fence will be signled and that cuases kfd unexcepted evictions.

kfd bo uses its own resv, so it is not affetced.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 47b0f29..265b1ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -96,6 +96,7 @@
 						       struct mm_struct *mm);
 bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm);
 struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f);
+int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo);
 
 struct amdkfd_process_info {
 	/* List head of all VMs that belong to a KFD process */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index ef721cb..a3c55ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -276,6 +276,26 @@
 	return 0;
 }
 
+int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo)
+{
+	struct amdgpu_vm *vm;
+	int ret = 0;
+
+	if (bo->vm_bo && bo->vm_bo->vm) {
+		vm = bo->vm_bo->vm;
+		if (vm->process_info && vm->process_info->eviction_fence) {
+			BUG_ON(!dma_resv_trylock(&bo->tbo.base._resv));
+			if (bo->tbo.base.resv != &bo->tbo.base._resv) {
+				dma_resv_copy_fences(&bo->tbo.base._resv, bo->tbo.base.resv);
+				bo->tbo.base.resv = &bo->tbo.base._resv;
+			}
+			ret = amdgpu_amdkfd_remove_eviction_fence(bo, vm->process_info->eviction_fence);
+			dma_resv_unlock(bo->tbo.base.resv);
+		}
+	}
+	return ret;
+}
+
 static int amdgpu_amdkfd_bo_validate(struct amdgpu_bo *bo, uint32_t domain,
 				     bool wait)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 6f60a58..4b5bee0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1307,6 +1307,9 @@
 	if (abo->kfd_bo)
 		amdgpu_amdkfd_unreserve_memory_limit(abo);
 
+	amdgpu_amdkfd_remove_fence_on_pt_pd_bos(abo);
+	abo->vm_bo = NULL;
+
 	if (bo->mem.mem_type != TTM_PL_VRAM || !bo->mem.mm_node ||
 	    !(abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE))
 		return;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index cc56eab..187cdb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -945,7 +945,6 @@
 static void amdgpu_vm_free_table(struct amdgpu_vm_pt *entry)
 {
 	if (entry->base.bo) {
-		entry->base.bo->vm_bo = NULL;
 		list_del(&entry->base.vm_status);
 		amdgpu_bo_unref(&entry->base.bo->shadow);
 		amdgpu_bo_unref(&entry->base.bo);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
