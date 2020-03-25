Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BE0C2D0E7
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 19:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00CA8206F6
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 19:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Wc68lzpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CA8206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A41756E434;
	Wed, 25 Mar 2020 19:22:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6F5E6E434
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 19:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdD85oZmDQW5P5vvw4qDNqw1e3T8PMF6QZK8KXNLjaWUtXnb6XuEvQJBtqiULh1FsjuJ2FsiKKn4kwTQ9YdWIfRA4zn4eg/rcN+YFmN++sJwrX5RaQoA44scl/m+ATjzUHiWLmszDoH+I8Gh6xt7upOA5WonoMrRqKlJU1T+F5C4jfAaCeafLg9dTv54neiePJgjrWPQlH6M3srjpuf9tGKUa7oko657tas7O399J7mbNo+zl7gltxgrt+UfveQ/qaPJoQ8TDoRoXyp6W/7eouTcZo1eaxfusoRo+5cZhscLVzSFD7XOTISn+zkjqoT73wPn8Oy2jCzDs0e545UoyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVNniJQ7IKEo++gLuuT1bygP9QU8s/4HPRQweEt7NA0=;
 b=hY+HDnXcK2PlG99uyxd2wBAtssctcCpFklPD/+A/gln0lYbdXEefekGYdVrc/QZFszQe9lkqIXsuE3TZCQ7AF9/j4H+Ww54cKIDht91zRYMu7QpdHLd6bGS7mVz06fYF1GQ2WKIdz9uGGpCzPES/WygcDX4kbtYM1/hzNl9A6HZRAWrlE0lukdH8B23GWQr/8oSzhPZD7qP/RQnThVpv6hAo+zNpPWYx2BCzB/uGTEa0jpyfiRyWqD1gz+4cxA7wTUeXnp/Kt2zkR08ZAEBxZliLL0b1oGXUS4J1L1c23q6CdEzEdlTCG7LmqZ3lGg35+AyjZNMPoojJqqPM/SQiRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVNniJQ7IKEo++gLuuT1bygP9QU8s/4HPRQweEt7NA0=;
 b=Wc68lzpaviNeK7fRWAjOtvhHiLktWQG++cxxYPTPljVU9JPspowogsO7+ThQ3v2+mK0gOMI7isC87kRF9u+Z0a3aNMfOKelreRpXJte0OwabCNPHnjOeYxriSo4zWBVQ/ki9zOY6XCMrk+JGYOViPe++RcMiDkyu8cKEdpd//0E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from DM5PR12MB1674.namprd12.prod.outlook.com (2603:10b6:4:11::15) by
 DM5PR12MB2424.namprd12.prod.outlook.com (2603:10b6:4:b7::34) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Wed, 25 Mar 2020 19:22:29 +0000
Received: from DM5PR12MB1674.namprd12.prod.outlook.com
 ([fe80::c0af:ab9b:b8de:7c4d]) by DM5PR12MB1674.namprd12.prod.outlook.com
 ([fe80::c0af:ab9b:b8de:7c4d%4]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 19:22:29 +0000
From: Tom St Denis <tom.stdenis@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: Fix SMUIO/PWR Confusion (v2)
Date: Wed, 25 Mar 2020 15:22:21 -0400
Message-Id: <20200325192221.717578-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: BN6PR17CA0036.namprd17.prod.outlook.com
 (2603:10b6:405:75::25) To DM5PR12MB1674.namprd12.prod.outlook.com
 (2603:10b6:4:11::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.84.11) by
 BN6PR17CA0036.namprd17.prod.outlook.com (2603:10b6:405:75::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18 via Frontend Transport; Wed, 25 Mar 2020 19:22:28 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7c2a4cbc-5bfe-42a4-7584-08d7d0f1dc09
X-MS-TrafficTypeDiagnostic: DM5PR12MB2424:|DM5PR12MB2424:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2424B3FB861C2DFF70DEFF5BF7CE0@DM5PR12MB2424.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(6486002)(2616005)(956004)(16526019)(6916009)(186003)(66946007)(66476007)(6666004)(1076003)(66556008)(5660300002)(26005)(4326008)(478600001)(86362001)(52116002)(7696005)(8936002)(8676002)(81166006)(316002)(81156014)(36756003)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2424;
 H:DM5PR12MB1674.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FdMdsbRYmjwpbQgWbcnglLq8Vds25UuFBA332BaPMhIwZcsDvFP+S/V73uwc+WRam6XRrYXtsNiU0znf/5TrlVT46a5NLX0Z4nLz+IwzNEbsk8dvaR4U+2CPxaJc9cq2z8ozlW2YWLy9G4m+EMx5oSaj9Ap1QaVlzTiKJOY1yGF1z2lIcOMHs8kdFEAtROSWV+bI9vEFeWNWyscO7vrB4swX/lNruahf3vYSYDW46gmVQ2yqgQ+3Daz/Lj9ZFaBiTk2GRPBeGLb0E5s+k7OvQl0qYrY6hUSFCMWroISqPSw5VuXpgqW7WAmyFsSboUv7rnSw5QR46I38AdHwcJlHo9SqoA4RyyMTgw2eL76h0HJlj8gYvrEjuS6dPGjJe4XnGj5zvbAKZvuwLwFaEkaKeBV271S0XKkP4JKVLR9IHoi0QJTQ6/iCo32qX8nyQaaF
X-MS-Exchange-AntiSpam-MessageData: WHC9vd3UPwXDgV9GF+U0/bFzXumYjCESg7yzwFMePnPDttGv4OVOKx9d7K0lEGKQ1GmarGSY/y2LPvKbAtihX0Dw8f5SzKFdGU5bObs3b+hvjYoxXBaxHHkXRVamtjNRbhH2G+tIWCuzESY/Vj+v9g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2a4cbc-5bfe-42a4-7584-08d7d0f1dc09
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 19:22:29.6186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jm2YHoTXRwmhuw8I/uRcTziCCiR2pXG/c7p3HNeWfYedI8JxL5g25c2Oeqa1hKR7WSSOBglCz4c9U9kF8spF8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2424
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
Cc: Tom St Denis <tom.stdenis@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The PWR block was merged into the SMUIO block by revision 12 so we add
that to the smuio_12_0_0 headers.

(v2): Drop nonsensical smuio_10_0_0 header

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 .../gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h | 3 +++
 .../drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h    | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h
index 327b4d09f66d..9bf73284ad73 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h
@@ -24,4 +24,7 @@
 #define mmSMUIO_GFX_MISC_CNTL                                                                          0x00c8
 #define mmSMUIO_GFX_MISC_CNTL_BASE_IDX                                                                 0
 
+#define mmPWR_MISC_CNTL_STATUS                                                                         0x0183
+#define mmPWR_MISC_CNTL_STATUS_BASE_IDX                                                                1
+
 #endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h
index d815452cfd15..26556fa3d054 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h
@@ -24,5 +24,10 @@
 //SMUIO_GFX_MISC_CNTL
 #define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK                                                           0x00000006L
 #define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT                                                         0x1
+//PWR_MISC_CNTL_STATUS
+#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN__SHIFT                                                      0x0
+#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS__SHIFT                                                        0x1
+#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN_MASK                                                        0x00000001L
+#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS_MASK                                                          0x00000006L
 
 #endif
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
