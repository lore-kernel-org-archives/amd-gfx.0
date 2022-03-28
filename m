Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226FFC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 17:08:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9CD610E059;
	Mon, 28 Mar 2022 17:08:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA31B10E059
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 17:08:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9hjc3iAzXdi5sfhNCqv9ayRSJreKvRVyrpBL55NO9Unt4Qk7+N2BKMeAv+z/4D7PF3hhzrlcCOMsQtjcJfyjxVWtr3hf3B/HbW48RG9Kuw1KU0iqheSPAP7F9lCw3DlAfIvEDV7774wGzi03hlitzse4niWk5Nsmo4V4g3NBRH/Lk0mk9NFSKAWNjq/w6wvQVkHoMETK4HjY6RwLU5Fj9BoKH6E5bcdWUk8j92Plhf0/9Ya60ied80vikM5gZmeeXgQpWE7m2SuWXTMT5Puclju9mOjTamnucsvBdIUbQW+9o50A+IY0h3zU+wMMLHTcaT5kEkph80Nj0Qt8fhxmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJcxic88udOIt97VFcOpHolfJu75Gw2ZPgt89gCC0ZQ=;
 b=MvhGwjYsrNQLGEgeueUQ9ZmUFvcTabaKL+FTiPcV20LBEL9ykISq5FTDdhB7JdoYAKxY/3FtVKRJBcMPonfaFWdea3vps0PNFCzHeBxwHJ+aActmdbzGCJ3voRBsn/6qfrifwXAj1Axz32WZq1V3bWwTHmZV/JG7W1Bhd+qIB6xzsacQi2Dt7RywF0P8BKXrRNWRNXV4BLG9wx+WurXa+99n36mL0IRNgx0ImR6pekV73ElpQUFR8xVxSUlNonFYpuO2Y7dpZMRRn/EQ6/ltlT1NioE2Y6eVNCDPQrLtBgNm5KQAY3+I7zNzKpo1uyD+gzkbU8qUhdXAaLdeAMGcTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJcxic88udOIt97VFcOpHolfJu75Gw2ZPgt89gCC0ZQ=;
 b=VdOj4xnkZXR4Fo1qY6xtqXFtVkIEIM6HUBGrbygBH07lTUqkFZdGbx8dzmCt0L4k7h9C6eBUCjS5bRlWCKfnpmjvBDeJtysbq6DurD7b9AWQLzqqUpCfiYDaBGMlFt3utxUITgCsLSFA+aq3VOuZxmPjo0S9XAwX7YtR3sMJkSM=
Received: from BN9P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::7)
 by CO6PR12MB5457.namprd12.prod.outlook.com (2603:10b6:5:355::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 17:08:13 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::d3) by BN9P220CA0002.outlook.office365.com
 (2603:10b6:408:13e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Mon, 28 Mar 2022 17:08:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 17:08:12 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 12:08:11 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Use switch case for unique_id
Date: Mon, 28 Mar 2022 13:07:58 -0400
Message-ID: <20220328170759.1267968-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 307183c3-4d29-4cef-1aac-08da10dd8acc
X-MS-TrafficTypeDiagnostic: CO6PR12MB5457:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5457A61EF34471AC161A3A44851D9@CO6PR12MB5457.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RvfTWKiriwmVtYluwaBHf8+lAQq+fVVWVMyrYVxKmY9nEWGNKzzabhj6Akmw5ghqRbiP1YShrmq1Rj0Ii2/qchKgjdmC5O85CVfnlTkoexFCidO4hO+zV27wjdkQ4WjuG6b2Kv0p0XvKtlH7HtfDLL2YlgGSQ0a1CxFK5Z4yi7AJ5jbsRChK6/sAzfUv5HU9U8ttF5/x/tNSyp9aWEKJ+rM9wlpSGpWeXUKBjOcWqh63zbg434QuEP7gs7VAXIKe2b7WWHFBMi/Uicq0ttb1+ciMZc5Yr6yllPYYjfkyXz3Oq3XTsytXCSWCAxuYXIEziaPWaTJU4BGlbNtdlW48QNCKGjQp/OPHR8utept6GONILHhdlPZxbA5V4O69FNA3OKeRHd5bWLMGF1E/K4ebYs7God4ryP6z1jxs5IxiIxLFAHTTiw0GrbwEdJKeZLuXCNoQDYBKiFPqM4YAmM1LBA27tmbFldXMuJRslYumxNc3SZCCK56ivAiz0LXhwbcj+jTBZYyZ+1zGpxQenebPqSKUh2g49sZG8GWbmGru2x/WI+wcVPWvlDCV+Co7ZCu3Eddb5cApz09lOiq5NQRcfnmk8Y/g+ZKPtJpwbmSK9pLrzCKqrd0ZqU3h6dmzS08Gn/KpKc+DaTiVQc268AkHru5uC2Z5neb2EhVw2plcICyMZbLQ7H4rachfi8bAgjDqPHlB99UWFkWa0ZQE3j4i8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(356005)(81166007)(83380400001)(36756003)(6666004)(47076005)(16526019)(36860700001)(4326008)(70586007)(8676002)(426003)(6916009)(2906002)(54906003)(44832011)(70206006)(316002)(1076003)(7696005)(86362001)(8936002)(2616005)(186003)(508600001)(40460700003)(26005)(336012)(82310400004)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 17:08:12.8014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 307183c3-4d29-4cef-1aac-08da10dd8acc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5457
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Kent Russell <kent.russell@amd.com>, Kevin Wang <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To ease readability, use switch to set unique_id as supported for the
supported IP_VERSIONs, and set it to unsupported by default for all
other ASICs.
This makes it easier to add IP_VERSIONs later on, and makes it obvious
that it is not supported by default, instead of the current logic that
assumes that it is supported unless it is not one of the specified
IP_VERSIONs.

v2: Rebase onto previous IP_VERSION change

Signed-off-by: Kent Russell <kent.russell@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Kevin Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 9ce597ded31d..4151db2678fb 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1988,11 +1988,16 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		if (adev->flags & AMD_IS_APU)
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(unique_id)) {
-		if (gc_ver != IP_VERSION(9, 0, 1) &&
-		    gc_ver != IP_VERSION(9, 4, 0) &&
-		    gc_ver != IP_VERSION(9, 4, 1) &&
-		    gc_ver != IP_VERSION(9, 4, 2))
+		switch (gc_ver) {
+		case IP_VERSION(9, 0, 1):
+		case IP_VERSION(9, 4, 0):
+		case IP_VERSION(9, 4, 1):
+		case IP_VERSION(9, 4, 2):
+			*states = ATTR_STATE_SUPPORTED;
+			break;
+		default:
 			*states = ATTR_STATE_UNSUPPORTED;
+		}
 	} else if (DEVICE_ATTR_IS(pp_features)) {
 		if (adev->flags & AMD_IS_APU || gc_ver < IP_VERSION(9, 0, 0))
 			*states = ATTR_STATE_UNSUPPORTED;
-- 
2.25.1

