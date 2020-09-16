Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6911C43461
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D6D3208E4
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3rUJE2kZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6D3208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7561D6EB11;
	Wed, 16 Sep 2020 19:42:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7799C6EB11
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 19:42:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzJKxG7sYF+95FPJStJAHs+cejRh4NhtEDyI8puKt+bE6I11WcsCGoDxo10hFudgB4LewdvUlEn8KyS9RF53R1BlTloVWWKnnjb5duriH5/R6K8H21MVLsw8atbmASmaGGLrT+fKqttBoPaCnbXYYosvhiiHBYHKWRXmJuUA5HxN0nmfB8hci+j89H8gZW19PDoyYsPbbIffnKWl3K1amZHteodw1JFifAdor4tvf7jgeew2180dYEHDNjCvV4sbIYvMRehoPPIyF1EnyTpNycOG/9Id+nfrffIiGnt4sh2SsuBdvCnIT2p44lklsmykjkB/o96GblL6dWgxf3mFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyORKOBG9TI3sfoH+zT61KhMMqBCz0ivFtO6mUU2WfI=;
 b=VKkM/ksotNEwkT/JEjEyQynG7CdYkgXkekM4je/SxX6/NE03WtzxNDf751x5YH8u0Aph0XGCt3nSkquRtUAfhNnzAkavQfLR6APzkjRd7ae8RRtDNt6X5OBsqEWwg/1+Pn8AjIKM/2XG8N11rw6lU6wJJ3zttIn/+Ayhuqp09zZ0tgY9zNwcQpoogW0YCqqvbXfRMRYjzvtZ6/Z++Dnq9b9MhM8HwOjA5bEVwrlyBCWsmU1zifXM84QrENLaADoFwEzK2w1Y581/Cjo7uQh7IqnORKYJT65/8SdMUUPeshLgFEfYuxvRme/tKbxU0g3vbn6ev0hXV/tzaJc2cAjArg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyORKOBG9TI3sfoH+zT61KhMMqBCz0ivFtO6mUU2WfI=;
 b=3rUJE2kZi1le53KdtCu3baV0RwVwJachDPHTcce/2ZzUsDKBIcfhdlnQA6F+BPabFW+/HrQcbcm64fpLUaO6HTh6xEsv1/49MKsUK/MFOHYOgA2qci3Gfpdy3sMbvFOLFdX4Iy+zbixDoo3uMeZyPnyGSCIc1O8IOSiav9fnO3g=
Received: from BN6PR12CA0034.namprd12.prod.outlook.com (2603:10b6:405:70::20)
 by DM6PR12MB2921.namprd12.prod.outlook.com (2603:10b6:5:182::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 19:36:46 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:70:cafe::83) by BN6PR12CA0034.outlook.office365.com
 (2603:10b6:405:70::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Wed, 16 Sep 2020 19:36:45 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 19:36:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 14:36:45 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 14:36:45 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 16 Sep 2020 14:36:44 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/15] drm/amd/display: [FW Promotion] Release 0.0.34
Date: Wed, 16 Sep 2020 15:36:34 -0400
Message-ID: <20200916193635.5169-15-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916193635.5169-1-qingqing.zhuo@amd.com>
References: <20200916193635.5169-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0931fdc5-587a-41fb-9173-08d85a77d8d5
X-MS-TrafficTypeDiagnostic: DM6PR12MB2921:
X-Microsoft-Antispam-PRVS: <DM6PR12MB292174B4E090316074C87F07FB210@DM6PR12MB2921.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TCCn66tNmFM7XKdL+nik2D2SC1odmg7GYlFjf+9Kw9s9k3slDXV8EIwt0QKRrWgShQYXQW1jL62AHVR+dOUtfvp7QtwMgpTTmyZa/6bYIqSLYyGeTvEmyD5Rp7Dttdz0hbkSBawO9/IcouMq9jD0KyIgddDg+g7Tj46Fj4rTRtT3Ny9/QmTbKwsqXv1fqPhUKvVQjU5DhApoHIP57ZTV/X4rqDsQiPFpmpJ8ga2PdVsmCKR6ox+qQbqBFJE/QL5z3vwMnswzRHm57oXTd2rN4IVVHg9W/AkMjJ+X8UAm9pp57tbxIfyVD4mwkwRoKfjN/CngH8xIMV1oo2d7cJ83wUqp/TeYsMcmO+oyCJ5x8EcupioW1RkunZ/5I1RkF1oxkdJdHYQ4HJXXuQ6JdD1Eu6/t2jqwkIeA7oOu4DdqTn0LHxc73klNJuq5ErtvYQqy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39850400004)(346002)(136003)(46966005)(36756003)(70206006)(83380400001)(426003)(6666004)(81166007)(356005)(336012)(316002)(8936002)(54906003)(26005)(8676002)(186003)(2906002)(82740400003)(70586007)(82310400003)(86362001)(478600001)(2616005)(4326008)(47076004)(1076003)(5660300002)(44832011)(6916009);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 19:36:45.7988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0931fdc5-587a-41fb-9173-08d85a77d8d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2921
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Header Changes]
       - Add new SCRATCH0 status bits for detecting restore state

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index f20d6df6def1..137613a60419 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xd0772ca1b
+#define DMUB_FW_VERSION_GIT_HASH 0xf547f0b9d
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 33
+#define DMUB_FW_VERSION_REVISION 34
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -170,7 +170,7 @@ union dmub_fw_boot_status {
 		uint32_t dal_fw : 1;
 		uint32_t mailbox_rdy : 1;
 		uint32_t optimized_init_done : 1;
-		uint32_t reserved : 29;
+		uint32_t restore_required : 1;
 	} bits;
 	uint32_t all;
 };
@@ -179,6 +179,7 @@ enum dmub_fw_boot_status_bit {
 	DMUB_FW_BOOT_STATUS_BIT_DAL_FIRMWARE = (1 << 0),
 	DMUB_FW_BOOT_STATUS_BIT_MAILBOX_READY = (1 << 1),
 	DMUB_FW_BOOT_STATUS_BIT_OPTIMIZED_INIT_DONE = (1 << 2),
+	DMUB_FW_BOOT_STATUS_BIT_RESTORE_REQUIRED = (1 << 3),
 };
 
 /* Register bit definition for SCRATCH15 */
@@ -301,6 +302,10 @@ enum dmub_cmd_type {
 	DMUB_CMD__VBIOS = 128,
 };
 
+enum dmub_out_cmd_type {
+	DMUB_OUT_CMD__NULL = 0,
+};
+
 #pragma pack(push, 1)
 
 struct dmub_cmd_header {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
