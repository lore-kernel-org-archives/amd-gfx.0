Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181A5C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 05:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1EB42072E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 05:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tDdBawFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1EB42072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73E066EB68;
	Fri, 10 Jul 2020 05:45:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB4CE6EB68
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 05:45:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fatc8We6SrnMC/I8j+KmxvokeoRfJMt2M1X1M/IVBNyn8xkMZeAEkYBxDMRCyAhiML+PX/2XlurfwBQn3ppvESjC1/trO9mutc1okM/uwEugUNPuq02D/TDqa5gGsic5DCQQWYZ5LVgJLRGBuSQdwpGFpGq8jWmZWFAXG3ugSOj5wcs5YlQaFISdvpscCcMqwJlRQ02ssP0HS1wyYaBDa2028D720lCgGWCn3HqyAmj5hpnvfCcwNr26ZeWOvQ0F6/873g4Nbfi0jpleOR1rbYFRDDAcNPNDKQEhPfSN/sthuVAx+O/8u9JEiwzgGJJDABWd7klZ4hHUMRk3djsdUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHPleYhpY5eUWLWw/qZmBIQFf0NbmDYsx+hM6WnmPt8=;
 b=Dvo1EvGb+CGBPAAOrilx2snivksdRfsNxdr+2eRs38EmYpebva+7gYa0kOLm3jd0D3XPRx6pC4yL47K2RwlEmVN4+yiuH075R3OomYXpjzF+Ta0c4/Px4+zFHHeGuMhtaG+lO8xYK3D2BR1Ed+WKyc0e3j0HzdTHCShYbNWdrdvVBSj4wjDBK2p3rZheHxjEMru0PgOnwtq9xpG/1fzy4zrvFf1qi63e+JA4siHFdKAOcS8N7r7WFJRKetRnFCLUf3LTqgISJLJu+UJ+8prOeTP6VDJIUBqTgD74AaxyHGoqZbVzkoBtzlv2kQxCxZPSfEdVZOPCc1ldD4AzQ/Hhrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHPleYhpY5eUWLWw/qZmBIQFf0NbmDYsx+hM6WnmPt8=;
 b=tDdBawFNb86Noc3/GP9hhRIFKaMoxKqB1FQPnaWVmMF6+Clg1N+q+gjFdpJ/Jd63QdRV/xmO+MXtO5fY5LpoRTxMITfvGGHO1lyuFJkWrx6DVk1NHyiMYpr+vJ5NxIkEAMiDcPx5VX0NZFyleKmiE6cbbmWmbjid6rbAywkBeq0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2474.namprd12.prod.outlook.com (2603:10b6:3:e3::8)
 by DM6PR12MB3260.namprd12.prod.outlook.com (2603:10b6:5:183::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 10 Jul
 2020 05:45:10 +0000
Received: from DM5PR1201MB2474.namprd12.prod.outlook.com
 ([fe80::8c23:3013:c186:ace5]) by DM5PR1201MB2474.namprd12.prod.outlook.com
 ([fe80::8c23:3013:c186:ace5%7]) with mapi id 15.20.3174.020; Fri, 10 Jul 2020
 05:45:10 +0000
From: Jack Xiao <Jack.Xiao@amd.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Hawking.Zhang@amd.com
Subject: [PATCH 1/2] drm/amdgpu/gfx10: fix race condition for kiq
Date: Fri, 10 Jul 2020 13:44:51 +0800
Message-Id: <20200710054452.2058855-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: HK2PR0401CA0017.apcprd04.prod.outlook.com
 (2603:1096:202:2::27) To DM5PR1201MB2474.namprd12.prod.outlook.com
 (2603:10b6:3:e3::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jackfedora30.amd.com (58.247.170.242) by
 HK2PR0401CA0017.apcprd04.prod.outlook.com (2603:1096:202:2::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Fri, 10 Jul 2020 05:45:08 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 123f898c-3ad9-446f-e9b0-08d824946868
X-MS-TrafficTypeDiagnostic: DM6PR12MB3260:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3260D9F42208569B7809CBD5EF650@DM6PR12MB3260.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1y4YI/nIlm6tPH8Fzz6pDgPH4Dz0hzq+sF39BYGztafNDnLyKjmE+Q46Iqc+Duin4RDzAsuxHHQ/thskMlYbQfwdHTuFwQAA2JKRS51J1BwMYCrvQt9XqzonwWgpD1ecGnxtfYxjUxYrogcg5+IiqCHDzA7wj4IwGlZO5O7xD3nW1cp6opncnKx9PVZgFd2tGD7P1OhtU1h86HoGfSA6oKgNOIpYMZ8YktuqZXjBjehealSf3obKbGwfEd1Vr4ggWX1jWvH5tNeZEnPIBhRBu2Bj091kzBSAN7xUi3c1LHABD8WeIq17iVMJ+VUt64C/qJ2m9veeVA/pdOMnBQfdNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2474.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(1076003)(66556008)(6486002)(83380400001)(5660300002)(66476007)(66946007)(478600001)(8676002)(2906002)(6636002)(6666004)(4326008)(8936002)(36756003)(186003)(16526019)(86362001)(316002)(956004)(2616005)(26005)(52116002)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: jY1zniL53nM1trkxl8lA6DiBAyxSlvJpV81Ld81M3RyxPi7xnTTQ9YxBqkP9K8fP4Avd0y2rj5jVbY5/+Fxsg6l/l9RTkJcQ76gwJ9eDY+P3FBsdeGxhfhQt6O/4eWHgD+IRHioVAvpKWQjFKg1lRPW7OoFNk2w/Teg7+jJTISzb7fWTSNsvw2hYN1TpEkrOWOg61pdEpgZ/NKKt9F/ZHystyTazNP3ax4VwssEcCvULqhn+GoMedwhXBgu3Gv6GOBWzFGgYmp5aRyB8bmJOMOSKNM16w6CcNUtB+1SfD2qZTo5LxREGv7CSZtvSdeeiBtnfDdtkeUmR/SeamdlZULfMFgjxl7PoBLQq5Uyca/TgJJXkI7V9wQq0ZwYpRSAaT10lUxJ8u9JUlpeZdmcOSfzu9vFZ4CsQOZ++GhwxTMBFg5N/ydLletTtNaqrcm/FICrbGbpzlDf/eJAbcd/KcxviUihe/TIp04Lp3Ic7/oVfqyQYfa2FinhwNIRawwIs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123f898c-3ad9-446f-e9b0-08d824946868
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 05:45:10.0699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CuCKq02W1BE+AO7f8Wz4TBqf++yBeCpaE4iHCb/H/Zvx/3+V0DNDywtVmQi+BWZg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3260
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
Cc: Jack Xiao <Jack.Xiao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

During preemption test for gfx10, it uses kiq to trigger
gfx preemption, which would result in race condition
with flushing TLB for kiq.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index a6170a346b39..ddf6d8128753 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7836,12 +7836,17 @@ static int gfx_v10_0_ring_preempt_ib(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
+	unsigned long flags;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size))
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+
+	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
 		return -ENOMEM;
+	}
 
 	/* assert preemption condition */
 	amdgpu_ring_set_preempt_cond_exec(ring, false);
@@ -7852,6 +7857,8 @@ static int gfx_v10_0_ring_preempt_ib(struct amdgpu_ring *ring)
 				   ++ring->trail_seq);
 	amdgpu_ring_commit(kiq_ring);
 
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
 	/* poll the trailing fence */
 	for (i = 0; i < adev->usec_timeout; i++) {
 		if (ring->trail_seq ==
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
