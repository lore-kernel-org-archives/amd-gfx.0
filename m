Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46BDC00454
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABA952077B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="D7h0SVRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA952077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 635836EB88;
	Wed, 11 Dec 2019 15:33:36 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760089.outbound.protection.outlook.com [40.107.76.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CC786EB86
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYy1Qq/pH8qk5vVd7AlPwVBzMH/6oRuZlJcwuNVVMbpvoo3SXl+CKTPQU5Vec3I8rxBsoywdHYmYVdq4TlwSZZ0Nm/EpJAJCVksZcPnwUVEmLhql4RbiXDryJ0QboBrFWT4fMnzGANd1ODmkxb4DhO+tAV9gAOQVhs+i6Ttezcqm3cl/n92Vl2RUvrpZZq/YiCTa7X289WH5RbnrQUTHpXXUpdPHY9xYL98DyOhfJIVThZQjiyDcKWbZkBDUOG2/60LSZ5K9HA/LzP9KDEJqLxWdrVuf6Q8L8m0Vcsjp4ks2vxaH9nY9JN/5lHXR7F2hWoG7I6gVsKgV88ukh6pl5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0xvxrNdOPozI5tLJgQ64p943wAwjvvHoTLV+gD5hek=;
 b=mU7Ui6d5o9A9gLKY6NeaFwoTOw6urR85eTu1h4aMjzwhLSPsmug1RVpTmiqXNRElcHABTAtZkTMm/wsVKsENowMGKf5hjAdD1+afz8w5SveaHd/Gs+J45VAzuM+MX0qSjH2wZTZlOcdamweX1r6TCRp50QfZ0gL028OecWXDgk/5QJYJz3fBnnq7fTsHcdondAEOeTqaKx2BXrI2PKJcMLE1eSFPrBk9crmZcBZ8SmGVmdzDYIRbwTier+IwPYjxYsUgvgcPaYT4rEbxH0vTIF9B1YAkdpXBkJuNkEVyLfa28o8eXuFGCFm/WN1hJA9H0+vopw/7l0VeDPpO4tpy6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0xvxrNdOPozI5tLJgQ64p943wAwjvvHoTLV+gD5hek=;
 b=D7h0SVRLyodXMWNopbOLL0qLdC4SVzNDP0ehVwbPi0MHe4hfWB6OEiokmNS57iz5KIzY+hllRpRX2byb16ycyEFLlHRnyc+K5xJ1nL73vb/uhHeJDVXXlbc5c/Q/BTlDkiix+gA1uv6S9rNxctChcbUuThar5kktMhneiBHEXFw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2491.namprd12.prod.outlook.com (52.132.183.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:32 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:32 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/39] drm/amd/display: 3.2.63
Date: Wed, 11 Dec 2019 10:32:31 -0500
Message-Id: <20191211153253.2291112-18-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8a99b91c-aab0-41c6-2853-08d77e4f7a5f
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:|MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24919BE7515A1CE29AC8C0A2985A0@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(6512007)(6916009)(8936002)(5660300002)(2906002)(86362001)(52116002)(2616005)(478600001)(66476007)(316002)(186003)(8676002)(81156014)(81166006)(54906003)(36756003)(4326008)(4744005)(1076003)(26005)(66946007)(66556008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2491;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3n1415dVSYy+SkPXM3TqpDY6lX2BLl0Mv9dz+jDGp1V04ZtFm7ubFOMdGYwJZIxmjno0Q+9BiwrlxcUsUElElUVqG7QtEn++KW22V1s9HnQB6L3S64740QA3RxKLD2xqIRIuzUz49xmTBzcjFcCDrcVjWdWUXHHdiYNIo3g381WNrHJf/PYJmjhP5/DFLmZXMn3damvk66typQU92uxkdJvYYv2m8qC2JTfZkPYAwbHd6J1nYuSEwUPbRDJag5mZLe3D7unN5XnKurnz9LZPiDnWM7nUNdePkExFnicC2lEmTPQTOoPjlaRtjetnmqchGZGavGd9irHS5ejDzVwyY80gCdNOtiTALRXl2heuITVgziLcD30SycP4Gcs0XuqdELsrnDurMys0WUKXG2GU9DFrorDK2OCvRLl2lA9cvJ5HwQeIXucVdQPjLvgkFAin
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a99b91c-aab0-41c6-2853-08d77e4f7a5f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:31.9435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgQ4aQnV2q5rH01M9Ki3zQk+J8fA2uwedSYFjAddMqT78R9PJNJyFMTImZXtNkdk6DzeUMjJYxW92DCp/hyspg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 91b60a549d35..5c48111deabc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -39,7 +39,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.62"
+#define DC_VER "3.2.63"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
