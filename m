Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914B8C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 19:43:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2629664F60
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 19:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2629664F60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1D606EA6F;
	Thu,  4 Mar 2021 19:43:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1E8B6EA6F
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 19:43:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxtKVYOUV+dJE58xQb7b9fEd3p/mS3qjo1njJrQVCj0IdXJ03WUbEqyZ6Hyli0gj6NcOn5u/RwL1e77g402APdBEhEECeQLCQm2UlzKZc/rGdzS75fb3R0kKLdM9fYrbrLZ8Jk1jsb5T/teKNxpx6sYriuMhaA3J81fEWVNuqtKPjim0BZw1Ep7dkuqmUP4FrvOiqaK20lTmScDwvs++oEUUlkQxLqATYaNBsjAluf8ImV73Pl8AdFJFXBihCIq2rjD1o7uZxeyPb/g6MrNBIEJHp5GuSkDYeUu3kRnCL+rgvk/MbOarZsZN7GdImFflCVvlCe/v24cEWYyDy/LKhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYSOD5uDi76AktWlExjG6tokkbOOMqascD1WKEwgdP8=;
 b=S1XnWVEwX73pPg+V4JY+mE4MfHETHmaZ+3+wWM/wlAgPTCzhZD2OnbnPYL51cLXYS/8BqdqXyKRsGZtDaKNoB0vRXDdGeNg3IRrIqCuwqIzIqBJUj0RhGrm7WQRXfQQau6DPl4p8FqsRRXjkhwGGD62SFCwRYr3F9EC7DVpHnxhQ7YWp7HgNPi6uUpA0PoZyFkuaoD5UWqbnGzbm1qUSlHi9CU/eLmoYozWfZ/HfB9QoF/b02Mlfaf472b85ODontiRBRjWAAgio/mU4WgOcGEqqdHXaCp+iAPIOPDa4oke6zQ1RftE4Ryqh47A6D0OCnV4EaeeAVmVlXXifSHhXYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYSOD5uDi76AktWlExjG6tokkbOOMqascD1WKEwgdP8=;
 b=rEIUUBJLDQediSBvd5Xyryj6VFQkUxiN/58deTdgRpa/hyXvKb/zS5fGoTs41T9/Q51yYyQcXsIv6TI06g8qq0iACLzFAo2se71r3+tEJxR+TZFxbguYtmSMHZI8wCYWrA3LMbn/8WYQqiuSY4xGL2c1cZA6hiX/BA/jjg4Mmrk=
Received: from DM5PR16CA0029.namprd16.prod.outlook.com (2603:10b6:4:15::15) by
 DM5PR12MB1388.namprd12.prod.outlook.com (2603:10b6:3:78::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.20; Thu, 4 Mar 2021 19:43:56 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::91) by DM5PR16CA0029.outlook.office365.com
 (2603:10b6:4:15::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 4 Mar 2021 19:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Thu, 4 Mar 2021 19:43:54 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 4 Mar 2021
 13:43:51 -0600
Received: from leo-VirtualBox.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 4 Mar 2021 13:43:51 -0600
From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>
To: <harry.wentland@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add DMUB trace event IRQ source define
Date: Thu, 4 Mar 2021 14:43:23 -0500
Message-ID: <20210304194323.3498-1-hanghong.ma@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90ee6bdf-9a55-4cf0-38bc-08d8df45d7fc
X-MS-TrafficTypeDiagnostic: DM5PR12MB1388:
X-Microsoft-Antispam-PRVS: <DM5PR12MB13885F8570B8F1E8DFBA3444F1979@DM5PR12MB1388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1U5AOScsz90FD++mBE0NZGSSQsSlet+gZLnwDA/zq116aNUs+RZaDUwbTrpB/UBkYkPbxkdBpTK978Sa2rNTT3Go45LJyslB44Cq+DBrU+6Dfv+31yf2aa49krGxiDG/VFuojFUAP5c872xn+cGN1d9OGY3T22uL+5m0TQBrxDiJKtkTeD9T+PjcMu4holk/SdlhoT39iLM35i5xvIJlA+qzhMB+ZVI0A6Y+1tSbYVRXViOIcqWgz3nVpuAodJ7ojqotlI+IahtN4Xhgk77fdVngWZM4gtiAec5kRzUtnmyoliqKqHeFKaTcqNN1sjlGhcMPvdus2rBA06o4fLLCcQ8qcKNYrx8/ldGAW4KJlh1vgCeujGJa0M/Mko09vX2Ig0H/T4MWbO6wiu1U8cFY8VWlkLFChw+KjSb8b45ymvIOigEr6NSjeB1vODoP5gMJB8kLes4Nj9AcenHcwb8hKUXKyWMhHbTLixRg64+dUKLzWB8OGO7uegRNQpyoJfrjjSMWyJQ34zaw7JhirUfy/EtRjrdjBvnNAbzbgJS8iS+G5jvQqfcHnnk7PNIYUN/sJdFFIXG/XFptgZmWxj8OrzSNIFEfUsLvoc5o2zilPWhngL7X5TIUiPzBW5tnozGelJXq3GifO9f33c1YRg4e1Q2RP//Wh3gihWcPjzP2/b+l0fVg/NjYncw+gAEOtu05
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966006)(36840700001)(8936002)(6666004)(1076003)(36860700001)(82310400003)(86362001)(478600001)(4326008)(82740400003)(356005)(81166007)(83380400001)(2616005)(186003)(7696005)(26005)(70206006)(70586007)(110136005)(54906003)(426003)(36756003)(2906002)(316002)(47076005)(336012)(5660300002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 19:43:54.0554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ee6bdf-9a55-4cf0-38bc-08d8df45d7fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1388
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
Cc: "Leo \(Hanghong\) Ma" <hanghong.ma@amd.com>, Rodrigo.Siqueira@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why & How]
We use DMCUB outbox0 interrupt to log DMCUB trace buffer events
as Linux kernel traces, so need to add some irq source related
defination in the header files;

Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                       | 1 +
 drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 1624c2bc8285..f01b75ec6c60 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -912,6 +912,7 @@ struct amdgpu_device {
 	struct amdgpu_irq_src		vupdate_irq;
 	struct amdgpu_irq_src		pageflip_irq;
 	struct amdgpu_irq_src		hpd_irq;
+	struct amdgpu_irq_src		dmub_trace_irq;
 
 	/* rings */
 	u64				fence_context;
diff --git a/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h b/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
index ac9fa3a9bd07..e2bffcae273a 100644
--- a/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
+++ b/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
@@ -1130,5 +1130,7 @@
 #define DCN_1_0__SRCID__HUBP6_FLIP_AWAY_INTERRUPT	0x63	// Flip_away interrupt is generated when all data for old surface is returned and old surface is not used again after the surface flip.HUBP6_IHC_FLIP_AWAY_INTERRUPT	DISP_INTERRUPT_STATUS_CONTINUE17	Level / Pulse
 #define DCN_1_0__SRCID__HUBP7_FLIP_AWAY_INTERRUPT	0x64	// Flip_away interrupt is generated when all data for old surface is returned and old surface is not used again after the surface flip.HUBP7_IHC_FLIP_AWAY_INTERRUPT	DISP_INTERRUPT_STATUS_CONTINUE17	Level / Pulse
 
+#define DCN_1_0__SRCID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT       0x68
+#define DCN_1_0__CTXID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT       6
 
 #endif // __IRQSRCS_DCN_1_0_H__
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
