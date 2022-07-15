Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB18BC43334
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDCB8113794;
	Sat, 16 Jul 2022 14:38:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6DFE10E05A
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 20:04:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoILXinbNzAckBbxS0Mof2SsZGMp7Ja6iUF1/IfpLYdGIiVuONeEonVO7zO/QXSiyGczLo0WNwnynizYg01sYM93hvXLN0Lj3G/E8LwqU8zAgmxMfAY2odNNtWlfk6+U6HjVHAgNJoZQvuPRQKibhPTP19m4b+Ge9UhGPytpzfzlzBTNpL1k/0QGePLTUU+8EbRiOcvzQVYIO9qVOqM7Ar/n1QWubyMsP8OQl1bn1vqEmd9tna5Px8+qNJ3MxGn5Hy/+NlLW4GwaND7EeZmcyfWWqse9l3n4vljlTo89IoIgYliMT4EjedQWj4BGNWxpy214hpcYWunWAHRGcYyjkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCnQyiKk6jmqZYLEiU32Pg1xCv3RMGFFBttmdWTHJ10=;
 b=QcKJAZbOAjBgF7TXtbkbwL+2a/Lw+U4qrXoWUe/soW6gnJL8YME5lIOlW3B0sFc9368UzrCEjr7NgJtQMRz6jb86gd2iXlpSSI6TwNq5f2oYc3sxWGfmXcMIVZlW5x2wVW7iaije6XAmeCHGCLskSRQDdB9VwG5UQIulTOAlNcka7BZuSjzbLRdMt2RKu4/hGyonjlZP0XpmF+4igv4GQAe4gpV6nbuP9jkzF1BtYouusajJCbtrbnJmjN38uQpTMUr3r/l3mAShZNODapD0Da7CDx0Su5QvmIdKil/ckHBWl7CAz38yKVhm7rFRz6T6vBFgNGyW5Eg4bYVZSXOjCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCnQyiKk6jmqZYLEiU32Pg1xCv3RMGFFBttmdWTHJ10=;
 b=ompeNvgIB74Nexqgoz+209WePvM5BR7cZDr34QAH6kE7zxA3UYiodjQqdQJe3kbLf43kckHqlVGzY5N70aVwZdCL69qO4bAzwCmbLuY1KcXJOL3yAFv6Y5WfIlDeYZTCph1GEJ9y1X7DzYvPidp3IPW8vSavCBCKd4evaQpFD00=
Received: from MW4PR03CA0044.namprd03.prod.outlook.com (2603:10b6:303:8e::19)
 by MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 15 Jul
 2022 20:04:26 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::7a) by MW4PR03CA0044.outlook.office365.com
 (2603:10b6:303:8e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Fri, 15 Jul 2022 20:04:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 20:04:25 +0000
Received: from ruijing-ubuntu-pc.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 15 Jul 2022 15:04:23 -0500
From: Ruijing Dong <ruijing.dong@amd.com>
To: <Christian.Koenig@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4] drm/amdgpu: add HW_IP_VCN_UNIFIED type
Date: Fri, 15 Jul 2022 16:04:10 -0400
Message-ID: <20220715200410.301438-1-ruijing.dong@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20c66ed0-672e-4f6d-51f5-08da669d37c1
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k/znoiG1JWVY6RZHoZ9yGh0sRKEoshpWKVrKtZBIyE7mg3axlarN5yq46Paz2HXbhZJJfWLbU8l6nPe1MRG9Ay55u0aWMK91DC3w1IEMSk1EQI7XYCN10/vRjuPsJgA22Lwm2mlZ8yXjyLT7f1bQTso4abGTZjdGdVc4ZgUnuuJ8WUx7KwG7fqj/pFri5c3DSRSGO9+X4KSHjBhWO+9Bceubhr8DoomvyANPFx//bcYXe/J2YlOi3sRbPaKaHf3uU1tm4iVYW1NBMsgO5tDuoDbEpb1631S25KIklTqlQr93kB9IRpSovvjxCN+cRJ0ffymooGIYA7hy9cjjs/DeR1KwfMiD6ibImCi/aW6HEuyLwaKlvHYay5BcfP3/glT8IkyJgT+ag/UkhFI32zEDgYVej1UUNzCg1nP27IM1R8PMNHP8nZaCtg7V8FtJpA29ACDR1Hqcd5rouqGa7Db07ld1ADkx3bGn7p+TlDT84AYd7oqcuGj4wMUiKu8cLtDSI77yQ7zXTcIOvtzQw5g/hgzzJAhR+kFe4qxcwEIBSx3lKFyJLZmcWTCulsxb9qJVUT86Bdy2VhRJYfjexTdFmIMIIdsqNoH6P9stY2lhLkhzSk0fsQkoAq3bnCDgTrdGPPt5nVA1UOvrnrlbDJDNVofON0GdPwPKOWpZL+ZnPYjwrS2A0nMj2gdtPlFzWxOujT8x2mRhff7r3InGib1hz1Cno2JHoWP8P0xKjozB7ZN45S37eW5dU/+JK9d5K5XbGsDgsZIPK1os4lESKqarkZFvE+/FJ718aXtmGWbzb6Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(396003)(36840700001)(40470700004)(46966006)(186003)(110136005)(426003)(82740400003)(966005)(70206006)(54906003)(478600001)(4326008)(47076005)(36756003)(1076003)(40460700003)(316002)(16526019)(70586007)(81166007)(2616005)(86362001)(36860700001)(336012)(8676002)(26005)(4744005)(7696005)(82310400005)(8936002)(44832011)(83380400001)(41300700001)(356005)(40480700001)(6666004)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 20:04:25.5786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c66ed0-672e-4f6d-51f5-08da669d37c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2524
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
Cc: alexander.deucher@amd.com, ruijing.dong@amd.com, leo.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From VCN4, AMDGPU_HW_IP_VCN_UNIFIED is used to support
both encoding and decoding jobs, it re-uses the same
queue number of AMDGPU_HW_IP_VCN_ENC.

link: https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/245/commits

Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 18d3246d636e..e268cd3cdb12 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -560,6 +560,12 @@ struct drm_amdgpu_gem_va {
 #define AMDGPU_HW_IP_UVD_ENC      5
 #define AMDGPU_HW_IP_VCN_DEC      6
 #define AMDGPU_HW_IP_VCN_ENC      7
+/**
+ * From VCN4, AMDGPU_HW_IP_VCN_UNIFIED is used to support
+ * both encoding and decoding jobs, it re-uses the same
+ * queue number of AMDGPU_HW_IP_VCN_ENC.
+ */
+#define AMDGPU_HW_IP_VCN_UNIFIED  AMDGPU_HW_IP_VCN_ENC
 #define AMDGPU_HW_IP_VCN_JPEG     8
 #define AMDGPU_HW_IP_NUM          9
 
-- 
2.25.1

