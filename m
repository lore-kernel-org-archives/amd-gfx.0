Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A81C46CD2
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 21:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D686910EFC7;
	Mon, 22 Jan 2024 21:28:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9146D10EFC3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 21:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHjn3rKaPweE18C3M5FPczB9/iM96QJn+plDx5XCTq/3/AsCkfJxhh2mp7d40MOaK3gE9dcDN7sINJ8V+LDH2bOuI2ikApazNX31a4toay/sW4AGvZb872+zjKQ0vtG/c769DfMb23KNjLI5ilVBM1rAyxDbKuwJ9Wrp0gCbZwJwXwqTfa5HtRxr6iX7KnIdMq9YPl2rqa3oN1LnlxQ7QrtQBju0Oc2smzY57HQdexOFWPdRUHJq1KxYtPCdZBYuBpshDkUdfQ32puRM8zg6LgzKK1lKZQHGnTaX2h83M2vprLHlNC2JspaZQzlB8dC2beUO7pMxYCumCbzeYq8VKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8gZI8I4es66tNDT0z8rnhHmiK9/l0bwuZho1GSdVEM=;
 b=iSS6plBtGCHBxdrHscRxVSpeUOMY2u3INroO4duO7jw/Yq9uBf+HMCF8hMUfKV60UmNHM0TWgQ7thToNfHF3WNII8Adt5DJ3K1ZzgIe22M2ipXIvzW3CP4I7ZbIx7JDwtW15vMqbrPaV0iKh/eMxqKa7oeErbW8Q0NSu0V7+cE4rzLD1LQDmf8FFOtClDD8aPxvbhPv1aEtHGZuyYoZmV9rladLbAqRJS3A+3wFAHiSFp9z6N/DuE8Nb46ZIb4I35rioLxcm66UouNds3TjAxuy2e0nGhFPQvmxCWV6VsQrlFWisFLeeqQXW73K0t7eQqRmnFimngCqvb8yLTXNmCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8gZI8I4es66tNDT0z8rnhHmiK9/l0bwuZho1GSdVEM=;
 b=tGgvJqTY17dA+a1u59gTuoOJEv8TCBwvM+fIkRU6YfMmssWoZIlZ/7p38y4tSfvzG6v+a63MjNBbt3jokeYmbFpvp4A0Bz0bAkLWXQxh5lyb44g00N3FWeKm7qk9TRLDYR781hNFJDRTaM0i5EOC82jcQ+bNkMC7mWNunPLRvJE=
Received: from BYAPR01CA0028.prod.exchangelabs.com (2603:10b6:a02:80::41) by
 IA0PR12MB8893.namprd12.prod.outlook.com (2603:10b6:208:484::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 21:28:17 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::f) by BYAPR01CA0028.outlook.office365.com
 (2603:10b6:a02:80::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32 via Frontend
 Transport; Mon, 22 Jan 2024 21:28:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 21:28:17 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 15:28:15 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Jani
 Nikula" <jani.nikula@linux.intel.com>
Subject: [PATCH v2 6/8] Documentation/gpu: Add entry for the DIO component
Date: Mon, 22 Jan 2024 14:24:59 -0700
Message-ID: <20240122212719.647008-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122212719.647008-1-Rodrigo.Siqueira@amd.com>
References: <20240122212719.647008-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|IA0PR12MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 543b3c3b-1253-4c1e-a3cd-08dc1b910c84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7elejCQNRlPXWiKu2CBvrkPyp8U/FkW5TY/pULUe5uhfh6YZ+PuJVtwWOmQbsfNL/0sAA1Y6rPduydXqiO+55BkOjHbILx/lSVkPM5T2Ukt0uQarE6fM1tLe56A4zqV/OO/9gdoIoLnUHzIJzkpU6LX50pTw4NGD82/yc7yx1IFmQrXSf/V60nHJrUKU4E5g+cfHqrnhxlIbzYhtneqG9jEzXDAielk7jay2ONqMMn71hFl2FqstS5oTIhOmMN/SpiphnbethlZZFjRSN1PGBdBVcWeGBYI8XT0KRdAiKTHp9DUXqIoyK1IJebcYmv2vCNbl4ogcyvTxKYlz7Wy+NhRwDzgybRojXtaEd3e45Q7IP/8CAjU8xxZko+vYob4koW5uW8VetSiP3xtz5h/6dzeMwUt66I9hyFBoHPSjrj7Hn74Ol4DlBcE4GmQfdpPyGj5OgnUZmSAMIxABTl+QBGQxcWf5JTi0lMzor5qTYEFXe7rY/ik3b+7WVYzsxFTCQ8XcLCqKuIfO2OaMQxW5eqSB3j9xX4K60uxj57Pp6XN/88glf0O4Bwk8BhvbG+6eAmkMzjEVJDIxAfn+BuxeNnbb0XbpRfbAeOn8RKW5YeVf93q9daQJOlRwBCmmpXek8nsAc8vSzOzkm3V9mL7pG3xLcThU+WpeOcOsJvxAV2xUFbGtmDn9IJlO9jDdqaN9TTzxnmtoFpLJRsMCsiAsQkmAlJ0mt0nSxjjSrfqcl3zNPE9Hu77F9KXgs8MpfeKZADYjfbcFnKMs9+0rsM8uMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(186009)(82310400011)(1800799012)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(336012)(426003)(36860700001)(40460700003)(26005)(16526019)(40480700001)(1076003)(47076005)(2616005)(478600001)(83380400001)(6666004)(82740400003)(5660300002)(2906002)(81166007)(316002)(86362001)(8936002)(36756003)(41300700001)(4326008)(54906003)(70586007)(110136005)(70206006)(356005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 21:28:17.2744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 543b3c3b-1253-4c1e-a3cd-08dc1b910c84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8893
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
Cc: Harry Wentland <Harry.Wentland@amd.com>, Rodrigo
 Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-doc@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 Documentation/gpu/amdgpu/display/dcn-blocks.rst      | 12 ++++++++++++
 .../gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h | 10 ++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/gpu/amdgpu/display/dcn-blocks.rst b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
index 5ba3c04c1db0..a3fbd3ea028b 100644
--- a/Documentation/gpu/amdgpu/display/dcn-blocks.rst
+++ b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
@@ -64,3 +64,15 @@ OPP
 
 .. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
    :internal:
+
+DIO
+---
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h
+   :doc: overview
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h
+   :export:
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h
+   :internal:
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h
index f4633d3cf9b9..a1f72fe378ee 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h
@@ -22,6 +22,16 @@
  * Authors: AMD
  *
  */
+
+/**
+ * DOC: overview
+ *
+ * Display Input Output (DIO), is the display input and output unit in DCN. It
+ * includes output encoders to support different display output, like
+ * DisplayPort, HDMI, DVI interface, and others. It also includes the control
+ * and status channels for these interfaces.
+ */
+
 #ifndef __LINK_HWSS_DIO_H__
 #define __LINK_HWSS_DIO_H__
 
-- 
2.43.0

