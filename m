Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF43C43463
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 08:02:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC52F20BED
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 08:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZMAr9Dgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC52F20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34E09892B7;
	Mon, 21 Sep 2020 08:02:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E22E16E248
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 08:02:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTcUxaHNEYqSyLYnKYOk2C+1Js5Zu6eLbTafz9ttoR0yUvc+Ass84R8HmUhe98mKqUjH5irERmki14klsL1pv+KiQ1A0+TJIUxWsStqBQtaXoYAoQd6fNV9ChcpLnVzjJqo6Ukyfk99a6xfWi1pfhBK7u6TdiN8YBM1K5a/aVDjtaHyNwVk2BUmS3Z1TRE6JB7mgBqOfqWOEBCbX4nvZzMneR0czyWkpvHNAgMPNFYqC/PU9z1hoHkrokXJrczo+bgc1HXGwlcRaq+0zRhkwSQq9491/j8123j+zf1jtQ6tTnB17VFR2JdpwHihTKFgctFpagtsa0Y12fFQ192uQug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXinj2TgDpud7ZuTIZo1SS7F3OwOr9/K3E06c8YE/TM=;
 b=m+kAyyDgPADANlJX3wI0YqgMA4PMq4T4rOUjMeRmZqX03YSeTP63GhY4YU/YBlUwy2Tqk49TxBx9EunavvQL8fh847PF5Se/5EP332cQguYaR/HkCQXGzL2Xyq1ib+fzG3Ctt98XrdgykuJrPfMv6Hv+anrCPfFBFWRkGc+q21muhmFZvPErHdyET4MRVtDFLSKN+fnRgLHLDI93+W4btD5WuucVBpOKMBU7IlxqBWbyG8s/GipA7zB05HTPhI8ZWLcQc46wpM3MVTAR5KbRhYprVxshoT1UhQHKkDuVhzg+51czbtZWZVXRd/gerO/n3ANWklxGKT6TVHJ+Jh5PoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXinj2TgDpud7ZuTIZo1SS7F3OwOr9/K3E06c8YE/TM=;
 b=ZMAr9DgfXoS/Z+MuZF7trI1UAfHDew+cY9vQr47/lvz0dysx8ibBeMrHWwOwWoAr4LVxrtH6bElV3zEwyFlGDs7Te45Mrkuxge/CXMqQQVCOkoqlNZUKC190HA0zOqOsnAKjUGNVvUhFfstEgEtD2BlC49wp/Pfl7+++45gyJOs=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1644.namprd12.prod.outlook.com (2603:10b6:4:f::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.19; Mon, 21 Sep 2020 08:02:01 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5%10]) with mapi id 15.20.3391.011; Mon, 21 Sep 2020
 08:02:01 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov: Enable the mcbp parameter for sriov
Thread-Topic: [PATCH] drm/amdgpu/sriov: Enable the mcbp parameter for sriov
Thread-Index: AQHWj+yH+vZjwmSgwki8RPfR0K3Zr6lyun5Q
Date: Mon, 21 Sep 2020 08:02:00 +0000
Message-ID: <DM5PR12MB1708BC4B1A41A02D41A2CFC3843A0@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20200921075452.527457-1-Emily.Deng@amd.com>
In-Reply-To: <20200921075452.527457-1-Emily.Deng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c2274371-f016-4204-b960-0000639282c1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-21T07:59:46Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9d64ebab-236d-4ede-e16a-08d85e049ee3
x-ms-traffictypediagnostic: DM5PR12MB1644:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB16445CB944A14A9323CE6612843A0@DM5PR12MB1644.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ctbZcJKdQ0DpjjRQxyo2uZ6m1sDcMF8Lg3tquw3k4colGqF27ew78PYEskwyUnWvGl3+9z+pWUrUARZOvgqys+dSPRjufW3PRmOdNkHARRMtZA5VSUv0s1uvTlzsfOrax1iNYY6q6qT8wMbo2NLljRMqUh8EON+ovHeE2d+F63djwwGYFkNNyOyOG0lS95TReAuzGu71GkA4uTAvE/eU2kjpBNahZCZQtIzPQHAq8goqkHYhgc5Gggp8INsHxWL5y3lke0kjmgFN8ZXW0YqWa9FcoRvqsKjVkaHgUWag3xKFWnR+JLfliX84NxxkCBasNtiEVUlys1wah41GcsN1dInz0OCQCXVnubztvZDIT4A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(76116006)(9686003)(55016002)(478600001)(966005)(66946007)(26005)(86362001)(6506007)(7696005)(316002)(53546011)(45080400002)(83380400001)(64756008)(66556008)(66446008)(2906002)(33656002)(66476007)(110136005)(52536014)(8676002)(8936002)(71200400001)(186003)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: mbRGAq+cDfVwhz4L6affNHX7tV8/aX/ShW/jPQlK3zPcO7mKxKNkjtphGJMk+0OUZVHrS9oSTMXmCyc18qHrBE36ykRh9vq4vpqFWqwce1NNcarqMtH6wGj2RdPgHyiK3AkwfbYNr3/YbhlBh1AIiWuGo7IemR2clry44HD1rAabCh9Yo7qZROSmazTVTI5h3UPYBExx/vCn7sdhW2RZ/35vUDrR29OH4I6FM6PsMSlvKkXcxal786OU29mFuk7hhlruilw8eplyGUPT3gfl9+Ssx5Ps4142R/b9529oMT+oSfGGHw1wfaZzwncFoUmrhISKo4XicSTpLonHTAnLFxGMR2y5nx22xRwUHfmAsLzRaE7hD0mBAqY/KTnXgz7u1B8Mg5E0rVgzQARdCvj1uHlDRf6jZqDXYXqVyQ64WDJWaS5hu0th+ryFdlOtRNUo7WTjBGyvzJIwbWDtOri0L/fJ0/vdnjrnTCet+vP/rlDUisIAaBGNQ0nj2irJDrLKmchzljbttN9NQPw/1I6zFenYY1ucB7IrUe1LWMhLD978hPhfzH9kGdXY/71UeX0g6x8WvXo4JvXH01IoezHI2kTh2ab35gHAefPPXwaSQyPuBhIq6F1qzgg3NuENmJDHOR+BRqbdWEMv5nSOr2gkIw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d64ebab-236d-4ede-e16a-08d85e049ee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 08:02:01.0070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZeTKtC0lvDO/dXAdAeM0PyDgon4FwOggoJf24iZBVD9y1OTtPxpVcn4ng9896DRB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1644
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Looks you missed many places, e.g.:

866     if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
   867         bo_va = fpriv->csa_va;
   868         BUG_ON(!bo_va);
   869         r = amdgpu_vm_bo_update(adev, bo_va, false);
   870         if (r)
   871             return r;
   872
   873         r = amdgpu_sync_vm_fence(&p->job->sync, bo_va->last_pt_update);
   874         if (r)
   875             return r;
   876     }


   949         if (chunk_ib->ip_type == AMDGPU_HW_IP_GFX &&
   950             (amdgpu_mcbp || amdgpu_sriov_vf(adev))) {
   951             if (chunk_ib->flags & AMDGPU_IB_FLAG_PREEMPT) {
   952                 if (chunk_ib->flags & AMDGPU_IB_FLAG_CE)
   953                     ce_preempt++;
   954                 else
   955                     de_preempt++;
   956             }
   957
   958             /* each GFX command submit allows 0 or 1 IB preemptible for CE & DE */
   959             if (ce_preempt > 1 || de_preempt > 1)
   960                 return -EINVAL;
   961         }


  2029             r = amdgpu_device_wb_init(adev);
  2030             if (r) {
  2031                 DRM_ERROR("amdgpu_device_wb_init failed %d\n", r);
  2032                 goto init_failed;
  2033             }
  2034             adev->ip_blocks[i].status.hw = true;
  2035
  2036             /* right after GMC hw init, we create CSA */
  2037             if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
  2038                 r = amdgpu_allocate_static_csa(adev, &adev->virt.csa_obj,
  2039                                 AMDGPU_GEM_DOMAIN_VRAM,
  2040                                 AMDGPU_CSA_SIZE);
  2041                 if (r) {
  2042                     DRM_ERROR("allocate CSA failed %d\n", r);
  2043                     goto init_failed;
  2044                 }
  2045             }
  2046         }
  2047     }


  4587     if ((amdgpu_sriov_vf(ring->adev) || amdgpu_mcbp) && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
  4588         control |= INDIRECT_BUFFER_PRE_ENB(1);
  4589
  4590         if (flags & AMDGPU_IB_PREEMPTED)
  4591             control |= INDIRECT_BUFFER_PRE_RESUME(1);
  4592
  4593         if (!(ib->flags & AMDGPU_IB_FLAG_CE) && vmid)
  4594             gfx_v10_0_ring_emit_de_meta(ring,
  4595                     (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ? true : false);
  4596     }



  4742 static void gfx_v10_0_ring_emit_cntxcntl(struct amdgpu_ring *ring,
  4743                      uint32_t flags)
  4744 {
  4745     uint32_t dw2 = 0;
  4746
  4747     if (amdgpu_mcbp || amdgpu_sriov_vf(ring->adev))
  4748         gfx_v10_0_ring_emit_ce_meta(ring,
  4749                     (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ? true : false);
  4750
  4751     dw2 |= 0x80000000; /* set load_enable otherwise this package is just NOPs */
  4752     if (flags & AMDGPU_HAVE_CTX_SWITCH) {

72
 73     /* don't enable OS preemption on SDMA under SRIOV */
 74     if (amdgpu_sriov_vf(adev) || vmid == 0 || !amdgpu_mcbp)
 75         return 0;
 76
 77     r = amdgpu_sdma_get_index_from_ring(ring, &index);
 78
 79     if (r || index > 31)
 80         csa_mc_addr = 0;


You need to change all the place  refer to "amdgpu_mcbp", and remove the condition of " || amdgpu_srvio_vf()"

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily.Deng
Sent: Monday, September 21, 2020 3:55 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdgpu/sriov: Enable the mcbp parameter for sriov

For debug convenient, reuse mcbp parameter for sriov mcbp

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
Change-Id: If1222b2c050376feefb8fed4be58b4b87d36bd77
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 ++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     | 3 ++-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5c2eb46e9b71..fcb6a41594db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3197,15 +3197,18 @@ int amdgpu_device_init(struct amdgpu_device *adev,

 amdgpu_device_get_pcie_info(adev);

-if (amdgpu_mcbp)
-DRM_INFO("MCBP is enabled\n");
-
 if (amdgpu_mes && adev->asic_type >= CHIP_NAVI10)
 adev->enable_mes = true;

 /* detect hw virtualization here */
 amdgpu_detect_virtualization(adev);

+if (amdgpu_mcbp == -1)
+amdgpu_mcbp = amdgpu_sriov_vf(adev) ? 1 : 0;
+
+if (amdgpu_mcbp)
+DRM_INFO("MCBP is enabled\n");
+
 r = amdgpu_device_get_job_timeout_settings(adev);
 if (r) {
 dev_err(adev->dev, "invalid lockup_timeout parameter syntax\n"); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 8d658d2a16fe..976d4f8ee2f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -144,7 +144,7 @@ uint amdgpu_smu_memory_pool_size = 0;  uint amdgpu_dc_feature_mask = 0;  uint amdgpu_dc_debug_mask = 0;  int amdgpu_async_gfx_ring = 1; -int amdgpu_mcbp = 0;
+int amdgpu_mcbp = -1;
 int amdgpu_discovery = -1;
 int amdgpu_mes = 0;
 int amdgpu_noretry;
@@ -575,9 +575,10 @@ module_param_named(async_gfx_ring, amdgpu_async_gfx_ring, int, 0444);
  * It is used to enable mid command buffer preemption. (0 = disabled (default), 1 = enabled)
  */
 MODULE_PARM_DESC(mcbp,
-"Enable Mid-command buffer preemption (0 = disabled (default), 1 = enabled)");
+"Enable Mid-command buffer preemption (-1 = auto (default), 0 =
+disabled, 1 = enabled)");
 module_param_named(mcbp, amdgpu_mcbp, int, 0444);

+
 /**
  * DOC: discovery (int)
  * Allow driver to discover hardware IP information from IP Discovery table at the top of VRAM.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 2f53fa0ae9a6..cffa45a9481d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -236,7 +236,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,

 for (i = 0; i < num_ibs; ++i) {
 ib = &ibs[i];
-
+if (!amdgpu_mcbp)
+ib->flags &= ~AMDGPU_IB_FLAG_PREEMPT;
 /* drop preamble IBs if we don't have a context switch */
 if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
     skip_preamble &&
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7Cc6a9eedc2c2547b247dc08d85e03a7e4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637362717094719356&amp;sdata=6YoaakeAi%2BLCggIUNDpF455huD9qWbuFpI1ZY0jz1Ds%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
