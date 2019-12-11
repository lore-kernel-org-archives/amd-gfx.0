Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414E6C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 20:07:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11ABC20836
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 20:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0XC5um8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11ABC20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D29B26EBC6;
	Wed, 11 Dec 2019 20:07:33 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750082.outbound.protection.outlook.com [40.107.75.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37A1C6EBC6
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 20:07:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mr76lhxF+Y5WH9UUWAZSd8qJ4s6jZ+Uyza8ml+LCeqfAFyFWBaW6XqFCt+hVzX12xyPv7nEcaz62TzG941im7IaYDC82VoRrTLBNWcLqEXCBEGaEJK7BsPFVKbhorItre5BAF2k07OdUs3PuuFZNzhewtNVpSTjzeIlvOQwwW2EflbcjbnDJOcY30oocqq+ZkPMQjGGSMpo8Rs34VnCYFDAOEnhaxqB7MXPFAw83UO+crxHxdZo0UmNrRC/ojtL0rSEfFJrcsdj1+ZMzGdG712b4WD58Qgte9F/0fhUogzYu4efmkaFa0CKbGVh8Wy7ni+93OyUeQ3B/e8OJ5KzyYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbmvfEVDn4wlCMN0iZvdDxhc9PmPptczfmGfkV79hL4=;
 b=KU5wfX1DdwgMwAUS7LRcsanuFx1oP6YAUXOK3Bg+waaIW0YjiUEtyTzm9liK7bmBIvcg4BGm0g3vIeyjFpwzJnlKQokzyJ0TscyDOVvT+XqxsyjNIYGN8rmegGJ0fAbz94xBl/tY4o2ah+4Vdh/u/57PdzIBMoEMKRnZT3704RmLGsSWopNM0zZEzGYtm28EmHgPx/zm62tolECaKAcKbDg0zScBcqj/OywWsoeJl5zi1Gwy90po0HnV5RlKpPolO2Z3kuHTDcDkW6W5r6/m11UA1tWGS0ZwcB8TL/GTBLAZfdmyPlmWSFv/koMVVx3VFBh1k2ifuCCKl8rkljrVqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbmvfEVDn4wlCMN0iZvdDxhc9PmPptczfmGfkV79hL4=;
 b=0XC5um8aL1QOSMsuyU1LODWGjdBshzM45ALh+YV5lusZTEyo9SmRQydfRPYZzM9sBQf43F6qE3m0OiEEcA0NqLr4Fp7PuDxyMy17gGCtZ1TzyohjHDp6wFmc961Lwsz1vGWa8kxg4AYp/4o7ASrvzSo0NdseWstrbDX0r3aUclk=
Received: from DM3PR12CA0070.namprd12.prod.outlook.com (2603:10b6:0:57::14) by
 MWHPR12MB1566.namprd12.prod.outlook.com (2603:10b6:301:11::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.14; Wed, 11 Dec 2019 20:07:24 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::201) by DM3PR12CA0070.outlook.office365.com
 (2603:10b6:0:57::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15 via Frontend
 Transport; Wed, 11 Dec 2019 20:07:24 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Wed, 11 Dec 2019 20:07:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 11 Dec
 2019 14:07:22 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 11 Dec
 2019 14:07:22 -0600
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 11 Dec 2019 14:07:22 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdgpu: Switch from system_highpri_wq to
 system_unbound_wq
Date: Wed, 11 Dec 2019 15:07:09 -0500
Message-ID: <1576094829-2245-5-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576094829-2245-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1576094829-2245-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(376002)(396003)(136003)(428003)(189003)(199004)(70586007)(70206006)(86362001)(36756003)(4326008)(44832011)(316002)(6666004)(356004)(54906003)(2906002)(5660300002)(7696005)(426003)(336012)(81166006)(478600001)(8676002)(81156014)(2616005)(6916009)(186003)(8936002)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1566; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2af69eab-fe1f-413a-08aa-08d77e75bca5
X-MS-TrafficTypeDiagnostic: MWHPR12MB1566:
X-Microsoft-Antispam-PRVS: <MWHPR12MB15664960DBAEC8D313B183E6EA5A0@MWHPR12MB1566.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ndcY3WSktEzfDPAEJbZSbJnxnoqnor7VNXBcrA4MBUPFUVK+XbMSZMOO7CVpSr87onIMMYv2sNB7aU2PkFFSgfIhcCuG56ayniDgFruG4CrdHEmQhADIRsZAVaRs8MfF9A6bevw/slsjCUlBY8jVCD1Jy/zqmBntUJdocJ7tuoPOjDl+Gb/tYfL3/bDqVU43VdnNiM5scon8LD570CKWj45ZRQ8yUTEkkXzXuLBw+xRZZqXQOSx9LYJ2tthNlrm8uelQOUPnC2UA/x0FrhIMx+NdJvgiNCzjatD5NnB7Fg/kJz355VEm5Q6WYB9KwJygcWH4nJefh2zqItoAcEt48tcKRZFR+RUlk6KJ+jVX0OY08Z8K38mifKWf3OzxMLQaQS0k3+E6+4Fvj6+80IT/VkeDgmPBzflJz6sDA9YGnc2sVLpzY8lI1SzZuDn99HhW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 20:07:23.5799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af69eab-fe1f-413a-08aa-08d77e75bca5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1566
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Evan.Quan@amd.com,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is to avoid queueing jobs to same CPU during XGMI hive reset
because there is a strict timeline for when the reset commands
must reach all the GPUs in the hive.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e4089a0..1518565 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3842,7 +3842,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 		list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 			/* For XGMI run all resets in parallel to speed up the process */
 			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
-				if (!queue_work(system_highpri_wq, &tmp_adev->xgmi_reset_work))
+				if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
 					r = -EALREADY;
 			} else
 				r = amdgpu_asic_reset(tmp_adev);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
