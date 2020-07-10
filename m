Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFE9C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 06:42:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACE362078B
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 06:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NHtvra5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE362078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 609F26EB70;
	Fri, 10 Jul 2020 06:42:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A73346EB70
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 06:42:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGHvKsyiDtfiJ5NRmj856+EiXU8dZiJOBITb64cGtvLmp66GqyTX2Z0+EGEyfMZLV7yKp5GtUb/SJlVPtuBipqALkoMjzRE3FJ9RA5VSNcPiXiHC/oq0rN2zuuFtWn3Hnyr+XiMyAw0Wf7CR7GNrIPKvUw/QpsBF9iKAT5V17oJw9cnCKmeccjR5o3u4Y/N6cbTK3Kui46Akpvl5axkbZW5egkEkksLvZbrh33zrIz19ujo8Vvgbt/U+7Y0Kw2+eReDwPRXEg3i2y6NTNLJkQ3bxGvfI9JvU8GivUYOFR7/ps3WbP38axk5ZxDAzK0JankkZiwTMFBEaqll5G+GkRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cerxwAyxuRLeVjemVnDI8VsTOMLGayr5cw0mBXRFC7I=;
 b=M0il7+IJZ1ND/+eX9TRd2155mPjWJfl0MrxPweINF9yT0ybgeZirbzfns8pdSAV6Q+rlSUfn24DlMwO68FLlceNIG/rmxiXghvXoS2w8DmoGB0Sy9TB4kcw16t1E4I5RM8a/iqtEDG+M9xRPr2FjitCBd0pMtDlXQH+ZZ/GULVB61fgc3jR1XN5mojXA2zSfBgdC2BGlVmdVswfI5uYZ9Yy1xSh4AauoeAorviHUc1UVKAYt5OvuwR/UY0JEaJ+fOWAJCxzZIqHUcWfKtZYJhruH01aOH01zDxZXzEvFhgIqjo+iY0dg16Kx98QcchBRcTJyycbBJhupA8YUTbzNBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cerxwAyxuRLeVjemVnDI8VsTOMLGayr5cw0mBXRFC7I=;
 b=NHtvra5EN9RfOyZ3fGYMpooO8gRvCM2+a/4GwOyEw6Nv1TWll8wOXeg4O7zrF7QNQRY5h7AFNB7ew/ce4tyYWw0xeNvZyZ/VuUCrgGYIMTL42zxH2C0zj3fezDXq4N1qzqo3uz7yeMSfBnxfUC0KohX9wIgAcJc0TtYYHxLe7Lc=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1353.namprd12.prod.outlook.com (2603:10b6:3:76::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Fri, 10 Jul 2020 06:42:23 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%6]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 06:42:23 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xiao, Jack" <Jack.Xiao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: fix preemption unit test
Thread-Topic: [PATCH 2/2] drm/amdgpu: fix preemption unit test
Thread-Index: AQHWVn1IgZy5bj6nl0a1BqYRaWFEOakAXWuQ
Date: Fri, 10 Jul 2020 06:42:23 +0000
Message-ID: <DM6PR12MB407561654C80B128D4C7219AFC650@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200710054452.2058855-1-Jack.Xiao@amd.com>
 <20200710054452.2058855-2-Jack.Xiao@amd.com>
In-Reply-To: <20200710054452.2058855-2-Jack.Xiao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-10T06:42:20Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=4a2b8ef8-5bfe-440a-9005-0000cf578539;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-10T06:42:16Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 37e2a82d-fd0e-4d6a-87bf-0000d8314170
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-10T06:42:21Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 53afd983-6ee0-4e7c-a211-0000c88eb8bd
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d18061e-594d-45f1-8f27-08d8249c671e
x-ms-traffictypediagnostic: DM5PR12MB1353:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1353B51FE56EF89837E81599FC650@DM5PR12MB1353.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DLqPyMPch1ceoayg9zswBFBXMEbJQY5ZNz0yzz1S1z9scHEFLRAIi3DmbkMWnZveYdc99PAz+gjXRh5Vp9w6sC8pPshrAmpxkOVbOXFsJSmvR9elAMDENfyMJMUyAWjeWEsWy86nC5vpeW5AKqSXMbLNbZpgYDer/R41qnp0/a5NhuoiD5M8qxEWTMA0bTyO0MD5Kx2H8Zupar5PACLC2DNvl4TVbJODPzx/6STLhOduJ1a6Ln+A27ax2mPgAa3PR2gMLWtRL9q0Bo8wtpXRSM+Y8XmtqfB8+HGgTTfWb8ZEzPO2XMbJncxF2jz7y5KlcqeNRRFT2rWvJ4+hTWN8ZQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(53546011)(6506007)(7696005)(8676002)(8936002)(186003)(83380400001)(26005)(2906002)(33656002)(55016002)(316002)(52536014)(9686003)(5660300002)(478600001)(66946007)(66556008)(66446008)(64756008)(71200400001)(110136005)(66476007)(76116006)(6636002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: YFITal/fne4BMIJ1PRkAiMK4EsLxkArCXvt4wXrG1JpIzPZ+FtwzrN/pxyFK/Yq14p+f4EMWKEjhKznsgowU7BzFA+z8iCLuv7IlGzuTRpFkwaLQa71sopFaVlyLY+JdMaCw3xDlBob9TnhFFb5DPJfzVoEy3r5qdCnN3Qy9/Xm7LB+HvfkzyoH4ke1+kHErQkqvWvzPCqBVvNFF3aTBBOgBO3ZgTCuXZHGx44JNkUKFYCXNG8emPRIXukEk6YhdIOuaD7xIY3R6UlXD0nPTNDQEhWZdA/lcY+EO0WcALx8m4BRjFZWx2Y84uof8eol22GBDfcqMfcm4nfP6Lb9byqolhdaAc55WHFcDjSUgYPgJ1srtLDgL4lCCtYR2qQB0iaeN/Ly4hvCaT3jylNBXlkSWrpTWXflMq+jI9WO1F9FCipFgXCM4gzwRnLNOYVnSXsEhggp+dCZIZAUY0EgVJXYhm+j1RGif0zZLfGl4mOCv6g3clkmluJiASzx3Ge/i
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d18061e-594d-45f1-8f27-08d8249c671e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 06:42:23.5274 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DAizRKR4cBSNGtIj/XyXoHLftjB1eCzuf9r3Z0n0l6QD5unz5d3KKy8JeDxG3NZrf47jAS+LhedjJgPLvhdwBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1353
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Xiao, Jack <Jack.Xiao@amd.com> 
Sent: Friday, July 10, 2020 13:45
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Xiao, Jack <Jack.Xiao@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix preemption unit test

Remove signaled jobs from job list and ensure the job was indeed preempted.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index aeada7c9fbea..bd5061fbe031 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1343,27 +1343,37 @@ static void amdgpu_ib_preempt_job_recovery(struct drm_gpu_scheduler *sched)  static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)  {
 	struct amdgpu_job *job;
-	struct drm_sched_job *s_job;
+	struct drm_sched_job *s_job, *tmp;
 	uint32_t preempt_seq;
 	struct dma_fence *fence, **ptr;
 	struct amdgpu_fence_driver *drv = &ring->fence_drv;
 	struct drm_gpu_scheduler *sched = &ring->sched;
+	bool preempted = true;
 
 	if (ring->funcs->type != AMDGPU_RING_TYPE_GFX)
 		return;
 
 	preempt_seq = le32_to_cpu(*(drv->cpu_addr + 2));
-	if (preempt_seq <= atomic_read(&drv->last_seq))
-		return;
+	if (preempt_seq <= atomic_read(&drv->last_seq)) {
+		preempted = false;
+		goto no_preempt;
+	}
 
 	preempt_seq &= drv->num_fences_mask;
 	ptr = &drv->fences[preempt_seq];
 	fence = rcu_dereference_protected(*ptr, 1);
 
+no_preempt:
 	spin_lock(&sched->job_list_lock);
-	list_for_each_entry(s_job, &sched->ring_mirror_list, node) {
+	list_for_each_entry_safe(s_job, tmp, &sched->ring_mirror_list, node) {
+		if (dma_fence_is_signaled(&s_job->s_fence->finished)) {
+			/* remove job from ring_mirror_list */
+			list_del_init(&s_job->node);
+			sched->ops->free_job(s_job);
+			continue;
+		}
 		job = to_amdgpu_job(s_job);
-		if (job->fence == fence)
+		if (preempted && job->fence == fence)
 			/* mark the job as preempted */
 			job->preemption_status |= AMDGPU_IB_PREEMPTED;
 	}
--
2.26.2
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
