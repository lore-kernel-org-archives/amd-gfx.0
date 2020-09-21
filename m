Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E433C43463
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 08:07:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 186D220874
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 08:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="y/WK6OJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186D220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C0296E247;
	Mon, 21 Sep 2020 08:07:50 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750041.outbound.protection.outlook.com [40.107.75.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E00F6E247
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 08:07:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPnLJM31NPw85ouEUYWJL45ORO3PkrtVE0rebwGQhOE4fI6O8MH49Jr1W9maEvDhAee3hHmTKuX8B1X8sSNyf4uywuCwl9tnM2mX0WwC/2+D80WRoERYmOndED8ad+hyS53wr8KPgJMoPsT4t8yKumXxqtar5eLybhvSIDQzp9Mh4i3cGzTNSp2Ryd4YqwCuhMk7njOfLvnz5mtth1mGDAu37lCZ7HMoq4pL2xdSWMOTKDAi6kdQcvAjFgZXCQ+TzO/2hLINmfVa3m7wNqd/EjEIl0/GBsgB+TMKj0cs0k8qHHiqE9lMNK1UVxlXhH1ONbDVI6y0him0Ksy1fRwhiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuNoP0UYM7PMkejtcZ+qP8cYb7X7ioaLckI9GX1Bbpg=;
 b=BqoSf+mAX0TcHJjlGGx2RGCBVNqCdM6UYpef/s0nllq+Gt3UBYkP/dS2qK2SLEwbBKxxBp65XF2mgBZVOh0rXeY9rFO7yxSiBuSn4RdwzZf+ZRyhTcygV07V8cPisUOAYaNbJaTKRG0hf+fHpPVx1eqYecQbyewegfSmejvQ7NqdBBdjY+LPo5MaKQwwW6P+JbAaJj7Q5o8DlUCYz8D/Fmb/AbvxcuRP1nkz4SfEM6+jvCXWI6gSz3Jo6EtBQVDG/WHzO0ba7UfaQ5/fy07ICuteeI2uRLrko00TJtyVl2D/r2zafr+LrNJrv7WFYn1ClOdfT0RgDA+0Ek/Mp6BSJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuNoP0UYM7PMkejtcZ+qP8cYb7X7ioaLckI9GX1Bbpg=;
 b=y/WK6OJYSesV7GG6y1UoBU8hERrsCjcoKvscS6aBGsNO/rycfBuk15nuQnN24mtTM+pud9V4yeUVhgbDYcENuftooaxYgq+7IDlFcfyvCvavYyyF6M7es6/7QoYRT+PpxorO/jyuG1woAiz+ZY777+QYzfK70y2sX5yz+5M2Njk=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.22; Mon, 21 Sep
 2020 08:07:40 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07%7]) with mapi id 15.20.3391.026; Mon, 21 Sep 2020
 08:07:40 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov: Enable the mcbp parameter for sriov
Thread-Topic: [PATCH] drm/amdgpu/sriov: Enable the mcbp parameter for sriov
Thread-Index: AQHWj+yDu+RFGfA+SESPaDTHs5KXAKlyux4AgAABTaA=
Date: Mon, 21 Sep 2020 08:07:40 +0000
Message-ID: <BY5PR12MB4115BF29636602F5846B5CC98F3A0@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20200921075452.527457-1-Emily.Deng@amd.com>
 <DM5PR12MB1708BC4B1A41A02D41A2CFC3843A0@DM5PR12MB1708.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1708BC4B1A41A02D41A2CFC3843A0@DM5PR12MB1708.namprd12.prod.outlook.com>
Accept-Language: en-US
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
x-ms-office365-filtering-correlation-id: 52a56d5b-a151-4d7e-a8ad-08d85e05690a
x-ms-traffictypediagnostic: BYAPR12MB2840:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2840553FA9DEBD1CD6BD4A838F3A0@BYAPR12MB2840.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kw/BeQO2MbwbewHxJaKlKUtykKDv1S7/acheY3EJtJqiPKAEuc57C7V4suWdEmQ3VnMsjKgNUPZXH0RSATaEPdVwWGeAKrv92678c7ZHtSK1TEf9fBtjy9IufEza/bRpWCCRfS3Y7bgoLNOohR+w6xx+5C3yDuiyFr4de4/+2EkBcWVypycHyY7RjLucEdRw6Z85jEWJDO3Qg/df4RQDqF4GRwh4OPhu1Prf2b2g/kElv5SRsC3yvRRMxfLOsQRwUtLwn6eCRvdKvofvlYSJakPkux9tU9soYzqCPG74XnyDqa2hVSxM8GMPJdyMiUYl/mkINR7miXNBPsQBgDWVAHpIbOkpgkPfEft5CqsPtIkRUyfzN+URzNIN6HBYjuxJ7YUUlyTeuXOyrUCIdhvgoA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(186003)(26005)(76116006)(64756008)(83380400001)(55016002)(66946007)(8936002)(66556008)(9686003)(66476007)(66446008)(71200400001)(7696005)(83080400001)(33656002)(86362001)(52536014)(2906002)(5660300002)(8676002)(110136005)(316002)(45080400002)(6506007)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: fG/Zi46NllWQRqp25qC5+J1T46yP7792Eg1sXvCASyPdblvOQYRiBoCxauCl6DYuhWC4o/E6lKL0ohbVT/sYsLoBOlfNUWkQ8DSygdu7khEhB2Mjvv5J/xXTM7jlGFouqPm0cA/QT/x2baRmzR3p8IH5EvnWABF/TtS2BI5qO5eA5kxnIVewNLN5a2c/1PFcJ41w2ZqroCuiczYlQ+7CbGyZ7fCqPGNahLhb+XIjV+hQSPobBhXA13vFILAKT+UHjHrt4bRyVlgCmTWVfqHhMtTK5GC5Rl8UAqCBXCW9yvkJSDNjBdTxtIisqoXORZcUin4tDvgkIMuhvFa2c153lD2H9FSwHWxG77J2RpifxGV3ZLlr5IyF2fJbRhCZ4rs4DQk6qvNxcNcI4dhywXtezfcEM2z4Fw8CmMm/uYBlbkPn4CJOK16Jt8ok5NGfqsmSQplLyf2DQ+lC26St45Vpois7GZiHMYgE6fpu3iQG+b9SZJ7J4y5S1Z/OCGGeLfdp1FwArzU3tkoQ/ILtZ/xD3p/pk0S8gLPKW7aWSNhdr1Y+lyL2Nw7Y+PRC7ahtwGKgrKgYcQKSUrsSYlYVgKC3Vnhsx3KVlxCVzDAiIMEMnIuDUmuVKxRhiBFsBISY8hivjj7OA3AiCs6iUu64/jl7Sg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a56d5b-a151-4d7e-a8ad-08d85e05690a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 08:07:40.1724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LteZCyzH/jv4J7JYxQbOLSFZ2G/dTEhtS2nempWLAGgMp3+f8fZjwvfnQvN/rvNp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2840
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

[AMD Official Use Only - Internal Distribution Only]

Hi Monk,
    Just for debugging, we don't need to remove those amdgpu_sriov_vf, it won't affect the mcbp disable.

Best wishes
Emily Deng



>-----Original Message-----
>From: Liu, Monk <Monk.Liu@amd.com>
>Sent: Monday, September 21, 2020 4:02 PM
>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: RE: [PATCH] drm/amdgpu/sriov: Enable the mcbp parameter for sriov
>
>[AMD Official Use Only - Internal Distribution Only]
>
>Looks you missed many places, e.g.:
>
>866     if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
>   867         bo_va = fpriv->csa_va;
>   868         BUG_ON(!bo_va);
>   869         r = amdgpu_vm_bo_update(adev, bo_va, false);
>   870         if (r)
>   871             return r;
>   872
>   873         r = amdgpu_sync_vm_fence(&p->job->sync, bo_va-
>>last_pt_update);
>   874         if (r)
>   875             return r;
>   876     }
>
>
>   949         if (chunk_ib->ip_type == AMDGPU_HW_IP_GFX &&
>   950             (amdgpu_mcbp || amdgpu_sriov_vf(adev))) {
>   951             if (chunk_ib->flags & AMDGPU_IB_FLAG_PREEMPT) {
>   952                 if (chunk_ib->flags & AMDGPU_IB_FLAG_CE)
>   953                     ce_preempt++;
>   954                 else
>   955                     de_preempt++;
>   956             }
>   957
>   958             /* each GFX command submit allows 0 or 1 IB preemptible for CE
>& DE */
>   959             if (ce_preempt > 1 || de_preempt > 1)
>   960                 return -EINVAL;
>   961         }
>
>
>  2029             r = amdgpu_device_wb_init(adev);
>  2030             if (r) {
>  2031                 DRM_ERROR("amdgpu_device_wb_init failed %d\n", r);
>  2032                 goto init_failed;
>  2033             }
>  2034             adev->ip_blocks[i].status.hw = true;
>  2035
>  2036             /* right after GMC hw init, we create CSA */
>  2037             if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
>  2038                 r = amdgpu_allocate_static_csa(adev, &adev->virt.csa_obj,
>  2039                                 AMDGPU_GEM_DOMAIN_VRAM,
>  2040                                 AMDGPU_CSA_SIZE);
>  2041                 if (r) {
>  2042                     DRM_ERROR("allocate CSA failed %d\n", r);
>  2043                     goto init_failed;
>  2044                 }
>  2045             }
>  2046         }
>  2047     }
>
>
>  4587     if ((amdgpu_sriov_vf(ring->adev) || amdgpu_mcbp) && (ib->flags &
>AMDGPU_IB_FLAG_PREEMPT)) {
>  4588         control |= INDIRECT_BUFFER_PRE_ENB(1);
>  4589
>  4590         if (flags & AMDGPU_IB_PREEMPTED)
>  4591             control |= INDIRECT_BUFFER_PRE_RESUME(1);
>  4592
>  4593         if (!(ib->flags & AMDGPU_IB_FLAG_CE) && vmid)
>  4594             gfx_v10_0_ring_emit_de_meta(ring,
>  4595                     (!amdgpu_sriov_vf(ring->adev) && flags &
>AMDGPU_IB_PREEMPTED) ? true : false);
>  4596     }
>
>
>
>  4742 static void gfx_v10_0_ring_emit_cntxcntl(struct amdgpu_ring *ring,
>  4743                      uint32_t flags)
>  4744 {
>  4745     uint32_t dw2 = 0;
>  4746
>  4747     if (amdgpu_mcbp || amdgpu_sriov_vf(ring->adev))
>  4748         gfx_v10_0_ring_emit_ce_meta(ring,
>  4749                     (!amdgpu_sriov_vf(ring->adev) && flags &
>AMDGPU_IB_PREEMPTED) ? true : false);
>  4750
>  4751     dw2 |= 0x80000000; /* set load_enable otherwise this package is just
>NOPs */
>  4752     if (flags & AMDGPU_HAVE_CTX_SWITCH) {
>
>72
> 73     /* don't enable OS preemption on SDMA under SRIOV */
> 74     if (amdgpu_sriov_vf(adev) || vmid == 0 || !amdgpu_mcbp)
> 75         return 0;
> 76
> 77     r = amdgpu_sdma_get_index_from_ring(ring, &index);
> 78
> 79     if (r || index > 31)
> 80         csa_mc_addr = 0;
>
>
>You need to change all the place  refer to "amdgpu_mcbp", and remove the
>condition of " || amdgpu_srvio_vf()"
>
>_____________________________________
>Monk Liu|GPU Virtualization Team |AMD
>
>
>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>Emily.Deng
>Sent: Monday, September 21, 2020 3:55 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH] drm/amdgpu/sriov: Enable the mcbp parameter for sriov
>
>For debug convenient, reuse mcbp parameter for sriov mcbp
>
>Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
>Change-Id: If1222b2c050376feefb8fed4be58b4b87d36bd77
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 ++++++---
> drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 5 +++--
> drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     | 3 ++-
> 3 files changed, 11 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index 5c2eb46e9b71..fcb6a41594db 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -3197,15 +3197,18 @@ int amdgpu_device_init(struct amdgpu_device
>*adev,
>
> amdgpu_device_get_pcie_info(adev);
>
>-if (amdgpu_mcbp)
>-DRM_INFO("MCBP is enabled\n");
>-
> if (amdgpu_mes && adev->asic_type >= CHIP_NAVI10)  adev->enable_mes =
>true;
>
> /* detect hw virtualization here */
> amdgpu_detect_virtualization(adev);
>
>+if (amdgpu_mcbp == -1)
>+amdgpu_mcbp = amdgpu_sriov_vf(adev) ? 1 : 0;
>+
>+if (amdgpu_mcbp)
>+DRM_INFO("MCBP is enabled\n");
>+
> r = amdgpu_device_get_job_timeout_settings(adev);
> if (r) {
> dev_err(adev->dev, "invalid lockup_timeout parameter syntax\n"); diff --git
>a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>index 8d658d2a16fe..976d4f8ee2f1 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>@@ -144,7 +144,7 @@ uint amdgpu_smu_memory_pool_size = 0;  uint
>amdgpu_dc_feature_mask = 0;  uint amdgpu_dc_debug_mask = 0;  int
>amdgpu_async_gfx_ring = 1; -int amdgpu_mcbp = 0;
>+int amdgpu_mcbp = -1;
> int amdgpu_discovery = -1;
> int amdgpu_mes = 0;
> int amdgpu_noretry;
>@@ -575,9 +575,10 @@ module_param_named(async_gfx_ring,
>amdgpu_async_gfx_ring, int, 0444);
>  * It is used to enable mid command buffer preemption. (0 = disabled (default),
>1 = enabled)
>  */
> MODULE_PARM_DESC(mcbp,
>-"Enable Mid-command buffer preemption (0 = disabled (default), 1 =
>enabled)");
>+"Enable Mid-command buffer preemption (-1 = auto (default), 0 =
>+disabled, 1 = enabled)");
> module_param_named(mcbp, amdgpu_mcbp, int, 0444);
>
>+
> /**
>  * DOC: discovery (int)
>  * Allow driver to discover hardware IP information from IP Discovery table at
>the top of VRAM.
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>index 2f53fa0ae9a6..cffa45a9481d 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>@@ -236,7 +236,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring,
>unsigned num_ibs,
>
> for (i = 0; i < num_ibs; ++i) {
> ib = &ibs[i];
>-
>+if (!amdgpu_mcbp)
>+ib->flags &= ~AMDGPU_IB_FLAG_PREEMPT;
> /* drop preamble IBs if we don't have a context switch */  if ((ib->flags &
>AMDGPU_IB_FLAG_PREAMBLE) &&
>     skip_preamble &&
>--
>2.25.1
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fre
>edesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7Cc6a9eedc2c2547b247d
>c08d85e03a7e4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
>37362717094719356&amp;sdata=6YoaakeAi%2BLCggIUNDpF455huD9qWbuF
>pI1ZY0jz1Ds%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
