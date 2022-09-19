Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E69ECAAA1
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 17:16:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3041210E05F;
	Mon, 19 Sep 2022 17:16:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCE5410E05F
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 17:16:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PG3tDUppvuioyw4CTfq5HASjkmWMDaw+wg3nZ2yC+vAaoM7JP7+pMuGC0UEuI+Qp0YIET3dLwg4WjFX8Dsyd2uAFdRMGk0Q3L0WkiMwWRjFdmRRkciGPUU7qcsAO/Dx7a1PeeSgwAwzWld1zVDXD/3JkTq7S5Mdu+8v9eCC1605El6GUyZ0FF8LpR2xWSsWt9d09uUAJ3v/dfkGNfhUo5Svlzd1MCr2UhcK+lfSr7ops2OqeXs15QQQ7+i/fevS8Xq7wvdVzncm4AWtwi+6/kycQ4v3VOU4G2opkm0nfmcEmNWQV6UyLn6Q0aihvnVIrS8vvUdbzhDz16/3fL/D3mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4Ns4vAaqtsUFFKbcPIc2UUkUdeF1VwOgCAX1KMMtD8=;
 b=FQNi31pV+o3syyg06IyqwWsUpcOTCwnoFeu/m8iETwAClhxxFvqVYWh1By/xQvLM1BoWNGO+ixD6UJT4NODvmr3pYmIR07DyUnANVvxvVx8y3hqWxVteIKg/zHd7xpEBNaI1Ya0tVcKSNwHeQw08rVjf/CNeXdnS5RHLZvTS8VsP9mZPb26+8I++jhTdM2G37fX4O72kQOm3/PuJTcEj3Cl2fwZZY1U9dn+umc1rDv2pd5rXuElYgcA99vGnhckmN+4s2grd/B4RVRbRqx9Lmo/uB3A1F6NgfK6kHU+D3v3rpmqjEtrmoNIICi7cfZGu+HvCkeCFEWzhqFbm+QGJOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4Ns4vAaqtsUFFKbcPIc2UUkUdeF1VwOgCAX1KMMtD8=;
 b=wekAriOeCpPNRZgpzHkuW4tj7AAkxAAf0tI6l/AG78WNr4no8CCVAz/yjn9P8THkkeSJZ2ewwurDt6vJVG2yqfCSr2L9BpHtAjVlnQJPlA0yfhlXiGrRnr+K7C5958HCXa7ytSQbRc8P7JTJbGZnMGSI28R1EFdESvHchLafLuY=
Received: from DM6PR07CA0121.namprd07.prod.outlook.com (2603:10b6:5:330::33)
 by CH3PR12MB7620.namprd12.prod.outlook.com (2603:10b6:610:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Mon, 19 Sep
 2022 17:16:26 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::5f) by DM6PR07CA0121.outlook.office365.com
 (2603:10b6:5:330::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 17:16:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 17:16:26 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 19 Sep
 2022 12:16:25 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 6/7] drm/amdgpu: Use vm status_lock to protect pt free
Date: Mon, 19 Sep 2022 13:15:52 -0400
Message-ID: <20220919171553.11286-7-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220919171553.11286-1-Philip.Yang@amd.com>
References: <20220919171553.11286-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|CH3PR12MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: 300ad3dc-6e5e-4827-5b01-08da9a62af7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: In9mEHL4yYvz4osQJui1K5X8SfNIzi+CF9U2GFO75QIz2MWGFRSi4X0SdhdMAKqJgG+pF5f64mw45z0/6uoC61dAsRjzvSUR1Ku9xYCCxdtYKF3VYsA9FWOSSsA1IsFHaoWtfSvgud6CsUpAh/LOtdpuxfUOob3+SdLng6a8hyfQ+DjdeYn/Qit3nMZErc0AUJYGfOxRcm6cJ9yMG+Wn2tX32qB+Rr4hNuqaosvUFbbTjfy2LeAMaGlLDUgQZmk2uDUoWxf50JCBg6quUaihFK/sShJ89XlWGf7OJC6OwyxTkUHoFBF3LvduwdXqb4kLpKt9FMLiN46BJ6pT5vE7OOHGc4wc5NJtc8/o3AYaMArMA2ive5n+Hi2fyTqcAsQtK29aGlUm6npIDYtghfhks/sxblo23D7rLFE2oS86F3W6JacMd/JsgNl8FKC8MHYOCGaZIkcOy/4Y8a2h1if8vQis5J2dbJXBqdvJH/S6RiMMGpct4N6Sm0EDIJTBFwGA1gxGdBHU8K+Eg/TJ/JonxnBKOCePNioXwCViMuazDmAHM3n6uReiUPWCIvWdDYrHc971Qt51oRDJGPo7xAjff/At5EHC6wNCOkWofVdAa8JO4ICzUHfpubJjUZ3lFJSITnc4O7LHyjxhjjNWqWf+5mrRGatje0HyUhal6+GHF0JqfGeg5FsTTLHnX9INnOb26FxkH+A5ww5VynhEZbbI2CCvrYkKbpYjqoQ6S0CnqjSymgWsZgyxKnmS/XERNrlgVZjgTFKpFyhN9WnzbWjHazy57fdI4PMXrN51OPEWZ0WruPTok+MtmtJQwQxPQYkb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(82310400005)(40480700001)(36756003)(4744005)(2906002)(316002)(36860700001)(426003)(47076005)(82740400003)(8676002)(4326008)(5660300002)(70206006)(70586007)(54906003)(6916009)(8936002)(86362001)(336012)(16526019)(1076003)(186003)(2616005)(356005)(26005)(478600001)(81166007)(83380400001)(41300700001)(6666004)(40460700003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 17:16:26.6887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 300ad3dc-6e5e-4827-5b01-08da9a62af7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7620
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 88de9f0d4728..61a4b7182d44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -637,7 +637,10 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	}
 	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
 	entry->bo->vm_bo = NULL;
+
+	spin_lock(&entry->vm->status_lock);
 	list_del(&entry->vm_status);
+	spin_unlock(&entry->vm->status_lock);
 	amdgpu_bo_unref(&entry->bo);
 }
 
-- 
2.35.1

