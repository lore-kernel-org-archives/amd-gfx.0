Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED70C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 20:19:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90EFC10E3B5;
	Mon, 10 Jan 2022 20:19:47 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2085.outbound.protection.outlook.com [40.107.95.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48DD910E488
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 20:19:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2gTxI8+XTEzbDm2/Zg0kMV7LIEr7d3z4Z7uJFR/b/gcV+vGOi8fcwhgkv8Cu4zhq2oiLIFV9D9ttgw3KkozEoGo3E6cv000pQvN2th941TyBXY/iv5Fs+IZfH3LxMSbtujf23iM71tcy3Wm8rO4WDinhIBYAiFdYPkItOJwrtlOkbIsWv6Hbdd9gYrH0og0QGY1LVrxrzMd2dlg6+4xtF6QhVi7XRfRAcFZxxG3OcwbRkqFgj7NqULIFZ317oE6lE8zGJ0f9xy2gl5jYz2Xu1zrfTq3sBa/Q05BfRoQgaVoLaGP7U5D0RsMajbI2AsQmurUgN1pfsEc2LXwt0LH1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdoxkg/1gB8qdjTJMr/Jo1qza1kUdM+h9CcFnEBmiRg=;
 b=fkkoS+PtcSeyojrhrHll6ZuQ84bWDkrepTbPf/oKSxSRn//jrbF8ze8dfgappiiulbTClcN/keS3r5Sk8/iWJfKptvGI70y5FagJl++pc7gteW0ASuDczx4Hb10j7tZjmBwlJcLGRkm5D5B4wY1YJXpsjJJhDcXXqDBphyvk2r6ajinu5d5joDicyYsfogdVDvgIXZbOaLznxwW5kPROxMK79GCQrSh+GRYMp45t/x5GF9oZsRrZe7cTh12lzCnDmnGmXfiPAmZF3CB5XhR1alp73eRI8HzzZHAAirGEElQxLRVfEr4QGa1cBf4nRb+DOmKP49+snN2IbO2UP9j7EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdoxkg/1gB8qdjTJMr/Jo1qza1kUdM+h9CcFnEBmiRg=;
 b=veNgPGe5A1hGk1IGyZdH+jMvUS0lZdUqXsmZTB99QHIHxm4dtsjaCbQLo8sl+7XErd+AeYtq3QX1/vJZe2uqiujvag7mK1rRkq6PbCkDEF37yZhM6fZQwGhJ8/UB37xvZqAkvKbtbdJWGQRe1Guu9CrQGqFmrqzQWzjT7bChbVo=
Received: from MW2PR16CA0014.namprd16.prod.outlook.com (2603:10b6:907::27) by
 MW3PR12MB4490.namprd12.prod.outlook.com (2603:10b6:303:2f::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.9; Mon, 10 Jan 2022 20:19:43 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::58) by MW2PR16CA0014.outlook.office365.com
 (2603:10b6:907::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Mon, 10 Jan 2022 20:19:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Mon, 10 Jan 2022 20:19:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 10 Jan
 2022 14:19:41 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: add a forward declaration for struct
 amdgpu_iv_entry
Date: Mon, 10 Jan 2022 15:19:28 -0500
Message-ID: <20220110201929.1949571-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220110201929.1949571-1-alexander.deucher@amd.com>
References: <20220110201929.1949571-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df66edbe-73d9-45f0-0530-08d9d47689ac
X-MS-TrafficTypeDiagnostic: MW3PR12MB4490:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4490E2DF68571C7E550465D0F7509@MW3PR12MB4490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: epfX43yh/zrLUbFCDj4c3ey9cHp8WG58uItSahaxNd+FXOKFoAQP4tUTYqm4M0QVkKBmEi57LolAWcs0RQshiK4xD62WIlh05sjG4i3ufUBVDl/O4YfmMjvEmI4NXnn5qSNby4GB340x7XUTmpS/vbGYYC3gPD/63dQXYtljDkLd61dcwnxJgjKhPj5H6g7uD6vR86mK9qIHqIUCOVSIKav4V8nyQ1uu44muaVTlcKNb2aznvlNn5hTKSuAjUG2OY5G7SGI0I541EZ1a+SlT9bnfTBlTnPlcztVL7Unx0iQC33JqH5WAJCYUbVW/2UxayY1a7uP+3Zdw/fX9w9MbrEwn6W3WsRnyYMojrODRFgl7p6OJfvZ+0JanFtQr7zcnGGybOkdZAWdpRnbqew+k2Z1cnJkW1fkXBs8JkzmOLbz/6SBdBtqFRWeDfxaMntIC0LXiyrOySWfCdTF8I8dHLqVWJD2Hvle0tPTJb3Wuq4bke/PVCftJND+n4+kAXf3HrFYmqq8vCh3EGstxxmfJ7oTfgEb59+w0pSuEsH9+pxZubwix9L0N2qUpBB60QcfVXlCwVCGAYVYkPrXBNP4E8IEPhwPeBE5b0p7A+WsCBlcTEmj7WpFfmkOkBINGZ4JlNoSnnXbG0xL2dxmGWKZHX2gHT/zbnqOtXaMaJNSR+kvezgrk7g73dsruIzswvsNxtow/iwkwBH+7mkklUv0sqe0bMd1wchE9zkzNByv1ZMnHURDlW3JXEjt373Od88cBXqwZlNumHpL6Rbt+hepHYz9lgplewCfO0dwUiVVsjVY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(82310400004)(16526019)(316002)(356005)(40460700001)(26005)(426003)(508600001)(336012)(47076005)(186003)(2616005)(36860700001)(1076003)(36756003)(7696005)(5660300002)(6916009)(2906002)(4744005)(86362001)(54906003)(8676002)(4326008)(81166007)(6666004)(83380400001)(70206006)(8936002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 20:19:42.9055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df66edbe-73d9-45f0-0530-08d9d47689ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4490
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
Cc: Alex Deucher <alexander.deucher@amd.com>, yipechai <YiPeng.Chai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To prevent:
warning: ‘struct amdgpu_iv_entry’ declared inside parameter list will not be visible outside of this definition or declaration

Fixes: 0f60e1036d85 ("drm/amdgpu: Modify the compilation failed problem when other ras blocks' .h include amdgpu_ras.h")
Cc: yipechai <YiPeng.Chai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index f604a2235a9c..7a4d82378205 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -29,6 +29,8 @@
 #include "ta_ras_if.h"
 #include "amdgpu_ras_eeprom.h"
 
+struct amdgpu_iv_entry;
+
 #define AMDGPU_RAS_FLAG_INIT_BY_VBIOS		(0x1 << 0)
 
 enum amdgpu_ras_block {
-- 
2.33.1

