Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AAAC33C99
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 06:37:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A4FF20721
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 06:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Z7vKlOaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4FF20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7C006E991;
	Fri, 10 Jan 2020 06:37:44 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700065.outbound.protection.outlook.com [40.107.70.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DB8C6E98F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 06:37:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VC4C9OMpJhpP9E9ZwxDSAhvvju7PxOK/2N2fov1gftHCZIhiwjwern2pY9BPrNvZFoSnddwFykeK5Oo/7Uwz9f8gcVoElEDd7Zbv1r0XFHMS2NUs+l/E79knghQPgroxiJW6V7o3Bi4XJmrFA/fHzLGrd48A2YfkfWTTa72z8h2MHnRiO9itx45ay0MarIq7xf6QxDZn7P9O/SbjbNz+0nSt6kNGNUBLjDBuAN++qRXitIuatrqDqvlhMLPhXBWzsduGkSc7cw8NL0z+eLojm2iCjuwIp4eRADqsDkOnKq8CQL2UVxxKssYsYeeFt1p0XhRZ/sEXrXXvEr5tm8PO2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RACQmQclQcvwwp7WxHx0syj/LSIVjHMGcwZ/Glbz4Mw=;
 b=Yhsm1gGqirOmuLAGf4WBlX4nUgeRel62Up65DJPMO+vaQZkkTw0pefUidcET5oI1a860w5z2WuMF45HwywcDvnJ7RhC+18LSOrgDYpsHJE8w941Au1gA23c2Bf+olh11Y1pecXpfSHi6EQVYWu7vEoRmR8xhieO5ddOcu69QABIm52AFaXjbd2oItdg2su3Gr1iwfnyDnJijoJKh3AAAUhlXbR2Amb/zSemklEcHywi3Jt1YAagh+nfryOz9AGUmHYzQ0KpoKWeGEkjbWgsSssFDEU88oOrpKXUfoY+VdP226l0wEBdL2O5aJxMwbpoSQUSh9pF7yUofgFIHNJjGdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RACQmQclQcvwwp7WxHx0syj/LSIVjHMGcwZ/Glbz4Mw=;
 b=Z7vKlOaNAjdVzFtzit05FEWfqxIeLaytmgBpmXgUj08OdoCWH1rulLGgCxEJymzNQIYJkY0tNsOJAgynmYYojYpMqtxlaLfoZ4dSTdouwYiijDDClwI4zHavm/7JCE/yUxcBNLH/Xeg1KsELLyOoUnlww9PZqYqowtNtISHugVs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB2974.namprd12.prod.outlook.com (20.178.240.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 06:37:42 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2623.008; Fri, 10 Jan 2020
 06:37:42 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH 3/5] drm/amdkfd: use map_queues for hiq on arcturus as well
Date: Fri, 10 Jan 2020 14:37:11 +0800
Message-Id: <1578638233-9357-3-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578638233-9357-1-git-send-email-ray.huang@amd.com>
References: <1578638233-9357-1-git-send-email-ray.huang@amd.com>
X-ClientProxiedBy: HK2PR03CA0045.apcprd03.prod.outlook.com
 (2603:1096:202:17::15) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from hr-intel.amd.com (180.167.199.188) by
 HK2PR03CA0045.apcprd03.prod.outlook.com (2603:1096:202:17::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2644.6 via Frontend Transport; Fri, 10 Jan 2020 06:37:40 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ad7a68b9-3825-47da-e5f7-08d795979809
X-MS-TrafficTypeDiagnostic: MN2PR12MB2974:|MN2PR12MB2974:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2974A7EC5B57B119A7EDB3F7EC380@MN2PR12MB2974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(199004)(189003)(86362001)(54906003)(8676002)(66476007)(478600001)(66556008)(6486002)(8936002)(66946007)(6636002)(37006003)(81166006)(81156014)(316002)(2906002)(4326008)(956004)(26005)(6862004)(2616005)(7696005)(52116002)(186003)(6666004)(16526019)(36756003)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2974;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wTpvstIZMf0FtMvt3wfXYNL+p2oefhkpfQ6WEKdY7QCbd2QT4XeU8n6nvUfxKGEUiB4KPIWK8YaP8ZtC9MVAG/C+7q3PXpaffA29SRLahlIx2Lineg/O+2/tGS6J/VGvWhjKpto6D0oDD15Zz01bMJHjyyLW44B+u+DzMVBmUHqGOxM2W6dsBX1dsyKn/iD83lov+4j3+sBkgKnKxeILOwzdLBO5tN1Vb56JV8s7mRA1CkkFO2AHVGmhwxzAL+5gIx/j8qqbHGkAK69lIy3jSJuJ4GqqL9LCFXK2oDFAPitZhWdj1hxQy6l/D5cOec6zGfSkfFpsrSY9HXNmMX1TFpnJ6C8mP143ZuVUFphM0Xco3aUBH7HcOi6Uiwf3h2pZEAmZYTbOIb8D6w7eHp/6kYKVXzYMEHI/VmiLaDmYSez/mTpunsebUccWG95hfXig
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7a68b9-3825-47da-e5f7-08d795979809
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 06:37:42.1569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SHHlCO+FQTN93u/2XaRZ+iUjEVe59hbPG43n4jvIVAfXhMcAv9qrqQ9+v/E4Cm/CUmOTOJunNZyB6RUZjpxx1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2974
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Align with gfx v9, use the map_queues packet to load hiq MQD.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c   | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h   | 3 +++
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 3c11940..8baad42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -281,6 +281,7 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
 	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
 	.init_interrupts = kgd_gfx_v9_init_interrupts,
 	.hqd_load = kgd_gfx_v9_hqd_load,
+	.hiq_mqd_load = kgd_gfx_v9_hiq_mqd_load,
 	.hqd_sdma_load = kgd_hqd_sdma_load,
 	.hqd_dump = kgd_gfx_v9_hqd_dump,
 	.hqd_sdma_dump = kgd_hqd_sdma_dump,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index ab8c23a..d2f9396 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -324,9 +324,9 @@ int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 	return 0;
 }
 
-static int kgd_gfx_v9_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
-				   uint32_t pipe_id, uint32_t queue_id,
-				   uint32_t doorbell_off)
+int kgd_gfx_v9_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
+			    uint32_t pipe_id, uint32_t queue_id,
+			    uint32_t doorbell_off)
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index 02b1426..32dd1a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -33,6 +33,9 @@ int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 			uint32_t queue_id, uint32_t __user *wptr,
 			uint32_t wptr_shift, uint32_t wptr_mask,
 			struct mm_struct *mm);
+int kgd_gfx_v9_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
+			    uint32_t pipe_id, uint32_t queue_id,
+			    uint32_t doorbell_off);
 int kgd_gfx_v9_hqd_dump(struct kgd_dev *kgd,
 			uint32_t pipe_id, uint32_t queue_id,
 			uint32_t (**dump)[2], uint32_t *n_regs);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
