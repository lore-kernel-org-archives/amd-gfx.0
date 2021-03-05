Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22033C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:05:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CACDE6509A
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CACDE6509A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BB3F6EC48;
	Fri,  5 Mar 2021 20:05:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A87286EC48
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 20:05:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLVXvix3DjZ/i8WnHLXhx4awOp7QfY68DuxG1GpkeX0g8kmtLNDXpmwbJwf++6FXKHjjb39nGOlrJVSNIHn3CWoQLr4GHRYagD0tmXE5pHlde03+5jTzx5YGcrZC6famm8N3gHHvy/deBx690q602dFjH7In6JtR2NJXZtHQ6QEKgS4BACPr1AP3OTH6C5puutgVROqjwKUuOhGNxFoBwnp1f1FgB+j0x0jm56L98U6M/WIYzOEKOivUWDh7ZJgwosEnh6QhPom1HlYyBvCNhlOgJrImSdA6y4IR/zNqHDLXEInsJCIxFeoHji8qJmqmFTaPm0th/v2s/DqK/cstiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAlepLSPwrgM93QqEP9eEf8mFbAz6hzsvVNHq/AxdQc=;
 b=fTj0FTgUlQo+o+nslb0jrqtUVoV0LGVTC8E+d86Jz6ZMDItvGTWiys7MdGoqzhQNiL5u9mq3+naLt37kX8ajVf8o9BnsirbqHvemda3T2H48s18s+fotcz40JnpFMOSuneEMB7QgCqZR6aHbR1tenxkOHndIyjijnXVgqpNJ9Smx5lDMvIM+MXJv24xK4786PgEk8gT1V7lztjBFQ7I63BIbwEBhWi3W+7Kdq+ZgrT9/kA4qRctT6rqe+2qImQ1oH98HkLJyxfopx4rliCcc7b61O1VcC2bzrkrbH8FCqe/urNe8MJ+xvdrlTx/9POUafTN6odk6roVrrx1qcx1/bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAlepLSPwrgM93QqEP9eEf8mFbAz6hzsvVNHq/AxdQc=;
 b=n7uF01uZN29DcYDO5gRxioQhkpaSBKspmtAX4hKhy2rMbfoe6yNKJK6k2V980w3Ak9HNPCWNUBBgTM641w+sBGXOxxIqmYXhcjMFMv+FfqqrqA1PBKdQpTt0ojt16uBAVCMxkvWTk29YIt4LsruTnVUqSXGuStGuBY7XlU8Zmcc=
Received: from MWHPR20CA0047.namprd20.prod.outlook.com (2603:10b6:300:ed::33)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Fri, 5 Mar
 2021 20:05:07 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::27) by MWHPR20CA0047.outlook.office365.com
 (2603:10b6:300:ed::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 20:05:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 20:05:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 14:05:05 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 14:05:05 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 5 Mar 2021 14:04:54 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/14] drm/amd/display: 3.2.126
Date: Fri, 5 Mar 2021 15:02:59 -0500
Message-ID: <20210305200301.17696-13-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305200301.17696-1-eryk.brol@amd.com>
References: <20210305200301.17696-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36c5dc57-925d-4f7f-d780-08d8e011f8c0
X-MS-TrafficTypeDiagnostic: MN2PR12MB4189:
X-Microsoft-Antispam-PRVS: <MN2PR12MB41897A141DE6D6F43EEC274CE5969@MN2PR12MB4189.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JY2GTl5UlyTuk9gbdf6ROa/hts2Y4DlqRJIkJlthIeSmzOys8p/GorO+weMMI7URSiYA0NNf9z2i6deakUMjg26AlIl5YyPt3S5TU6x14eWj25emJAZ3diuRJAfyuW6+4IZrYNT/8xRHjjTlltHaHx0l/DwjDOmgTMwyn3bpoAAPiuGE3TUOdDh8hesvYvXCLSorGjByCx+h6gc0T/RYTEm9MJKCse9j9UG7ULtq0v1YHqDYr0fJnRsJio9qTq8wxNz2MstGGopZHGKUR2RVoRJEig8KQj8MdkEmdr7U/WQJeS43kq3jAmdtQrjaFeoUa9OXsyRQ7iGxs1FaMhwC7e3TkGLNCnathve4ua6tSt29OYMxD0hkJAPWPyqwguKA5yvY6qLhdZRA+BiKgT8+q0ebddvyFRfnz0xs8VdYoB+mk1TOgAtGkNwno5ldZlP45Iz8T7QjaAfsSIDXNqOiAQsBsQBGNb10agVHyfX/5uOc3Bx/EEK0go9UIa2H4IMP9tC0D7VumXGLGFBTnbkGeujJMwv6qKaGQ51wg10eSDDH3k94KrkA2C0MNMYOex1hxmM98GdbWv8qLF1an5wKhUasLdKZsfXFSwEA8wG/Dqw7Xfw7RPQdJbvxtnhWRNVsPqDHz3fkiT515arywZSEpsabX+xmZsBxy4/ZYFKK+d9rsHqmGZ7nKIm++r7SCWlZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(36840700001)(46966006)(44832011)(36860700001)(186003)(82740400003)(356005)(1076003)(8676002)(82310400003)(54906003)(47076005)(83380400001)(86362001)(81166007)(8936002)(36756003)(6916009)(2616005)(4744005)(70586007)(70206006)(316002)(336012)(426003)(2906002)(26005)(5660300002)(4326008)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 20:05:06.3769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c5dc57-925d-4f7f-d780-08d8e011f8c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189
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
Cc: Aric
 Cyr <Aric.Cyr@amd.com>, Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

DC version 3.2.126 brings improvements in multiple areas.
In summary, we highlight:

- DMUB fixes
- Firmware relase 0.0.55
- Expanded dmub_cmd documentation
- Enhancements in DCN30

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 9765a63d973a..e0ee6d72b7f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.125"
+#define DC_VER "3.2.126"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
