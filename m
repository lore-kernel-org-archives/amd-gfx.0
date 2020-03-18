Return-Path: <SRS0=EQAg=5D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015D2C4332B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 22:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9355C20752
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 22:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0RpF65uK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9355C20752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3264E6E97D;
	Wed, 18 Mar 2020 22:52:22 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690054.outbound.protection.outlook.com [40.107.69.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F31E16E97D
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 22:52:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mg0/5YD1be/S/UjT1rPp5SS+OUorboxtNHa0cINF+1evJiNZl7O8L32ldOiTAebjC6JcReHi/NrXdg9rKmyOx9AzWpwwkemDVCOtxWwn7h0jsi2P5eSdava2hScETOW7qlS4TBQIjAfIwEoeDjiHhJTDVeeTRv/7l4nKgR2+l9QCWkiDs51zstt6yAWxzUvyIuY8CvxEtOQOjI2F376pO9Yhd/HvFhxXH3gQ1Yw/vRXhPgwg+G8yJ9Vxq9aPsFCKWyWYl/OflX0B4gN/TkfyCNE4vUvbcqvhN7D7mza3eUK5sYeWo7VtcrZ1c4hHGFhU6zuy3P4VPc4qT1xbE/4fkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAqAhYXMkm0BN6uCj28eBqUiAPGmHHWg+Sfb2I6Fpl0=;
 b=Ctjn8lW3tdFSThEkEV46dNuNF512JcdQKGGHYcKLFwXC9MNBSlN7CNzeyFy8PEqa8hhMIOhTNCtPrssjoiJp1ueCDE4PcQsLLLMhJuUCBmfEC68iRggy9r2TUFNUTrPejVx2gdCWZsvWVa7I+hP3E4iGl53HT5eze4BTptYcoueBkY/gpD1j2qNgWldoS9rB6Ws5sKxJnu28ARsXXVOghmnThubG6ji04pSaflsCrdrXeYxr8J0lYhe6QxPyUGqJYhQlCKWyXQxxZkzBkeF1y8V65kV1+EwMqu3XBumHisdiCklAkyp/1PBD75/rVVx4dviyJ5wWJd+pNgjl2H5syw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAqAhYXMkm0BN6uCj28eBqUiAPGmHHWg+Sfb2I6Fpl0=;
 b=0RpF65uK06J/ItKe47rTePqyU2l7vO/je0TYeI4idpOwRaJHnyKwPSjveklHcVSCZnAwp7N3RvsNWO7Ayu0ePe3yx7a1MBYTubJ2Mun1YT8CCTG/fzu4sxCEqcgBmXrvKk/xQQeD0Rn0ewgZiheXoLPDgRaihLfM+QuYywoTPbU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16; Wed, 18 Mar
 2020 22:52:19 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2835.017; Wed, 18 Mar 2020
 22:52:19 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/8] drm/amdgpu: add mask bit for IH_CLK_CTRL on oss v5.0
Date: Wed, 18 Mar 2020 17:51:11 -0500
Message-Id: <20200318225118.10756-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: SN4PR0501CA0076.namprd05.prod.outlook.com
 (2603:10b6:803:22::14) To SA0PR12MB4576.namprd12.prod.outlook.com
 (2603:10b6:806:93::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN4PR0501CA0076.namprd05.prod.outlook.com (2603:10b6:803:22::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.11 via Frontend
 Transport; Wed, 18 Mar 2020 22:52:19 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 86b5e1a7-8c1e-406e-b5a1-08d7cb8f0377
X-MS-TrafficTypeDiagnostic: SA0PR12MB4415:|SA0PR12MB4415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB441595878DC78A839C5569FAFDF70@SA0PR12MB4415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:353;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(199004)(66476007)(66556008)(6486002)(81166006)(8676002)(44832011)(316002)(81156014)(956004)(2616005)(16526019)(26005)(186003)(8936002)(52116002)(86362001)(7696005)(66946007)(478600001)(2906002)(6916009)(1076003)(4326008)(6666004)(36756003)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4415;
 H:SA0PR12MB4576.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ulLRbyDCVLgyaSaQilgOeMzJwDEiAIJBAuZrHK8fVCdfSR0uKYOXLqd+BGYRSHuefwmu7D5MAucb0Tst8Vh1OQztxsFToOZZ8x8w7xMoFQGu95h/r784zTmd31oKcah8lINoNumpG/ZqWt+sm8Fwq5qzJA3LIvwtUNI0y8jtZ0gfaoGSRe/IPQs31e1VdlEVKb14PaL0lJVPCqoWbIQ9VmL4hTUYqe9XwsOS99Nu+QkknwgTZQvApqvOg6WnDW9s3WsUIvC+k7abMsSVdYBIQG5X7UinBRZmagWV0LS55kU2TtkL7O9MdIPEKNJ+cc7fFnSJjmapkSg/twN5WwtbXRFaF0XiYShijJLCuPLlB69FXRZUhT1DSSRas90eBcnvRg3t3DuE/XyeIIKMJGOJquponcULNmDUVilZyRzXUPsNxbjFgmcPYQhAexofQEXX
X-MS-Exchange-AntiSpam-MessageData: 0pxbx9+v3IiWKY76C+Jf8Chfu783e6o4jAgruFD6yIpXZgo0m0gNwaEWvpZGKhtV+Pjn7JfWp7PuRA7ZpreT6xKKcB6cMqOCubTL6ub/rS22C3PmR6BVy0AThUTLrcj8IekM9316Fvj5Y36etr2y1Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b5e1a7-8c1e-406e-b5a1-08d7cb8f0377
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 22:52:19.7512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOUGdzBHnSD2/fxkvz7WWv/WYM5FguzlP56UG3QM6/S8JNxEma9DT3ulPGsph+m6v46/u/jLJbOQilLLOyirKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Mask bit IH_RETRY_INT_CAM_MEM_CLK_SOFT_OVERRIDE was missing for osssys v5.0.

[How]
IH_RETRY_INT_CAM_MEM_CLK_SOFT_OVERRIDE bit mask added for IH_CLK_CTRL register
on osssys v5_0_0 mask header file.

Change-Id: I71e5ea3a8e5b5077b21906c730bcf30faa678f10
Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/include/asic_reg/oss/osssys_5_0_0_sh_mask.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_5_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_5_0_0_sh_mask.h
index 05543bde3444..7555ccb667eb 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_5_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_5_0_0_sh_mask.h
@@ -586,12 +586,14 @@
 #define IH_STORM_CLIENT_LIST_CNTL__CLIENT30_IS_STORM_CLIENT_MASK                                              0x40000000L
 #define IH_STORM_CLIENT_LIST_CNTL__CLIENT31_IS_STORM_CLIENT_MASK                                              0x80000000L
 //IH_CLK_CTRL
+#define IH_CLK_CTRL__IH_RETRY_INT_CAM_MEM_CLK_SOFT_OVERRIDE__SHIFT                                             0x19
 #define IH_CLK_CTRL__IH_BUFFER_MEM_CLK_SOFT_OVERRIDE__SHIFT                                                   0x1a
 #define IH_CLK_CTRL__DBUS_MUX_CLK_SOFT_OVERRIDE__SHIFT                                                        0x1b
 #define IH_CLK_CTRL__OSSSYS_SHARE_CLK_SOFT_OVERRIDE__SHIFT                                                    0x1c
 #define IH_CLK_CTRL__LIMIT_SMN_CLK_SOFT_OVERRIDE__SHIFT                                                       0x1d
 #define IH_CLK_CTRL__DYN_CLK_SOFT_OVERRIDE__SHIFT                                                             0x1e
 #define IH_CLK_CTRL__REG_CLK_SOFT_OVERRIDE__SHIFT                                                             0x1f
+#define IH_CLK_CTRL__IH_RETRY_INT_CAM_MEM_CLK_SOFT_OVERRIDE_MASK                                              0x02000000L
 #define IH_CLK_CTRL__IH_BUFFER_MEM_CLK_SOFT_OVERRIDE_MASK                                                     0x04000000L
 #define IH_CLK_CTRL__DBUS_MUX_CLK_SOFT_OVERRIDE_MASK                                                          0x08000000L
 #define IH_CLK_CTRL__OSSSYS_SHARE_CLK_SOFT_OVERRIDE_MASK                                                      0x10000000L
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
