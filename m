Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2ECC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:41:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44466613F5
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44466613F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C970A6EB30;
	Fri, 23 Apr 2021 02:41:02 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2086.outbound.protection.outlook.com [40.107.95.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76A706EB30
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 02:41:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jafYGu433YPwNuydF0TAqP2bbfBQf5TkpsGj3stO5XEnwNh94qzkIzQgwFtAbhdQTm/3lsS18peiO5iAl25w2VMZpn40KxCBBFJJW46H83I++g31UXDjyXw+IIi2Eb4QY6l6Wngg2FCgxFfA/ZJ2soux0sb/N7rCxEKZ1bRZ6V2mh1dOdC8+YewK9SMRljOk9G/B+dCpsI3osO2XXf2VC2kBkBlHxQjIOmynq6n0VAagcO6JKqbEoRE7cX04qumBB4PkHgpO1+eneMpEnbpOBhFyZgK4KHuZP7Evi5hV9YvUeijx6ATSUFAlMmqYA6M8g3ghohNryldEZXDLsjtiWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZ4eobElWVE+OTC9JH6ovdk2H1Jk+VrwIaGFTF6ZpJE=;
 b=IJ2mJbBetpwzkIDKQa52zvkpfcku4BwMPCk8T9bHGknypC2cRWIvE3zM1Ohvr28jtHe+iRp6dMCtobQcM8TNslhhSYyxzrolgnMfn/3YUqcdbM0cUmvEwh7TiUnrbrxRUVsCz6jrbucMMp+8ofJw2tytnVMGiNy9MNsavTmKJy5xqzs/4wx2lxICNPh2sxCcIG2ZG6mI0yuT3/dvT2x42iG5RzbmB/ROnTK+4SC2XoN850nLSa5F3jlcHlCae/aUpy5BTsQdqRpfxds0QU+0ue81yQ9wFvHTaXNa3AYdGVSSzWczkWPhU1HevFZXugSVKSFN6Ogh0yMQZA0pW7JSpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZ4eobElWVE+OTC9JH6ovdk2H1Jk+VrwIaGFTF6ZpJE=;
 b=P5AaUnDop2vm4nmfIrQzIDdYa1a2jr5v/xDVlo0PeCVvhXzjWR2FtknZVwVW7JOnX+9dKdos6FsY+msd3kwFllQf7dpPLCrwRXu1ZR8T6EWcBY1S9t+9TO4EbC5i7OrnJNOLUdLpXcURxowu+dUz8M6MLjmBj21dGTZVzUEIq0c=
Received: from MWHPR21CA0053.namprd21.prod.outlook.com (2603:10b6:300:db::15)
 by BN9PR12MB5308.namprd12.prod.outlook.com (2603:10b6:408:105::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Fri, 23 Apr
 2021 02:40:57 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::11) by MWHPR21CA0053.outlook.office365.com
 (2603:10b6:300:db::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.10 via Frontend
 Transport; Fri, 23 Apr 2021 02:40:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 02:40:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 21:40:55 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 22 Apr 2021 21:40:53 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/16] drm/amd/display: 3.2.133
Date: Fri, 23 Apr 2021 10:37:14 +0800
Message-ID: <20210423023714.22044-17-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423023714.22044-1-Wayne.Lin@amd.com>
References: <20210423023714.22044-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c8d5a6e-e53f-41e1-098b-08d9060138f6
X-MS-TrafficTypeDiagnostic: BN9PR12MB5308:
X-Microsoft-Antispam-PRVS: <BN9PR12MB53085CA1CC2DB1C29AE08A2FFC459@BN9PR12MB5308.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /gHNKm7RsN2fACjpExezqINk0HUCABja1rhrmGGpjjciDKNpjaebIApslwY3iDY9xworQlH2C2YHIWH5FR0kiC9snmEibAVAqr7N6n3cNFSTJ/PSwK1IjpR56/98HAOqmvWwyT1uWS97SfCRWvLmRybqw/Ou36mhYWls5LdlD9bCQ4lv6K4lEkeDmUMe8NId/+rZ0+a+zxLjrzNUgkiDMT3aRaqNoGsL+dnniLKXqBXd50Xyditsn0uoltZJDdzr0GJA3U+Qgydf56NX6UciM7gpTjJ5aA6KUlIvsPekg/LwSZhOKM7vGjbLg4LShc/f5osFZ1pVi7kN/ls3UJ+SfJbVJbxLRZyidP8w8Yy2qqrXC7nycdVHuWAGkHHmfSfOkYSN4vbCvPYLAIfm7H1sV8CZyC5YrCuocDJjQafpxrwqIs0sMQggYO9BcBfzGL2l+EuYp2uxySA+kkEDjmPB/CJ5Apx38O6212s3MgKKytbj+IiilygM4qUp42rUg8gW6GrcC4dFFLi5jquPfm3E4wxAkD2dW63L6OGZBagdHeT85vvQGuFm6HveqjBiiquWBxc8Tj2HF8Wsu6Xzo7TRtUlpsjvZHzPXBdIDqJQZxwWfUNFyAQGk4nJt8RwGC4HQNji23HfxddnvQwopC7M94Di0lZZN+SUNXsSC6qcUfSFQWS5EQXylOapdQ403H4Dz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(46966006)(36840700001)(2906002)(186003)(5660300002)(82740400003)(2616005)(26005)(47076005)(6916009)(70206006)(70586007)(8676002)(36860700001)(478600001)(1076003)(54906003)(83380400001)(81166007)(356005)(86362001)(8936002)(6666004)(36756003)(426003)(4326008)(336012)(7696005)(316002)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 02:40:56.8439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8d5a6e-e53f-41e1-098b-08d9060138f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5308
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This DC patchset brings along following fixes:

* [FW Promotion] Release 0.0.63
* fix HDCP reset sequence on reinitialize
* Fix BSOD with NULL check
* Added multi instance support for ABM
* Revert wait vblank on update dpp clock
* skip program clock when allow seamless boot
* Add new DP_SEC registers for programming SDP Line number
* Add SE_DCN3_REG_LIST for control SDP num
* Add new case to get spread spectrum info
* fix wrong statement in mst hpd debugfs
* Clear MASTER_UPDATE_LOCK_DB_EN when disable doublebuffer lock
* Expose internal display flag via debugfs
* take max dsc stream bandwidth overhead into account
* ddc resource data need to be initialized
* avoid to authentication when DEVICE_COUNT=0

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Wayne Lin <waynelin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 65f801b50686..dba2584e8986 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.132"
+#define DC_VER "3.2.133"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
