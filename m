Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC6DC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 05:42:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 816A960F6B
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 05:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 816A960F6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3312D6ECCE;
	Thu, 23 Sep 2021 05:42:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1D1C6ECCE
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 05:42:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LODp0pGwIuzggNdvVHqukZbsDN2LmLgBbLhi3nvvsQjn+Od62kg7O/q4lY5ERq0G3LC5YI3zZ0izoaxq4MHtqzxUC6Za84BScPXVwsx4DsXTrSeUzY37CY2dCojwIxiokMAWWXvvIq4ZhGKB81wtG+CQZFvdYBorvnCaYbeU0L+5Ejnx6uAgfNLTjN//tqzVOQ70/9NponKvba+yy7mfs25VhJLygL3az+K7u3tNJ9GmiQH5Q74ldOci6IHq+VjoIWpvub+0EMWa0pmMu7J0dQAgqIGVEcVOozlocRpFrCf4TPCp6IIoq22QjJq649wvdS95kEMvWTXebyd4T7DqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Zxo6EvBchOxxd4vriaVS+ebui1AM65MTCISpjeVQdLY=;
 b=BACTUVL5q0kHkXw8vR0YZ6P87tBNHDxabk3g79eVFv7CnrJ/a52b5gf3Eu6q2nH8EwDZ8J14mB2otdZBkevbhb6BoZtElBBp4v6RbM38K+nFDxbx+kvF9lwpaUT5OuUPsPf+OWzvb2fqm+r/Q9FJPlnWhCUQm0mdA2bN6/FQGTgG28mQRyBb8rMoshBHwcUOyk2kFjDrFgU2JKFPkVp6T18SBqXwlpS1a2r5ZmICdK8ziTFYKmkjm8CG3UZr/2iZy9MIFCziR0FUAQgZDH9nrqhJJBZ5K0jkPYYRn+sdVckCI9isKDxEDgQxzcXwLVDdt7j12kifZy+Sivnr1qRr+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zxo6EvBchOxxd4vriaVS+ebui1AM65MTCISpjeVQdLY=;
 b=ArcIhylsi0W4r/YS6jOxxacBnduwz7UxSsq8HuLjEeWNVtjZfuXd5QMxeq6GSfR4y+tNSO6qaU1CUyrPJqxSB3bNKg05EbqEtEE+FWTSWp3TUE32CvQGuJQlb/qzvGThjyZzB40iFADPqogQj0RiRrv672c1BY/ThlMc74WdmFE=
Received: from BN9PR03CA0964.namprd03.prod.outlook.com (2603:10b6:408:109::9)
 by SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 23 Sep
 2021 05:42:46 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::7a) by BN9PR03CA0964.outlook.office365.com
 (2603:10b6:408:109::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Thu, 23 Sep 2021 05:42:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 05:42:46 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 23 Sep
 2021 00:42:43 -0500
From: Huang Rui <ray.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <Felix.Kuehling@amd.com>, Sean Keely <Sean.Keely@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>, "Chen
 Gong" <Curry.Gong@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: update shader array golden setting for
 cyan_skillfish
Date: Thu, 23 Sep 2021 13:42:01 +0800
Message-ID: <20210923054201.1433036-2-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210923054201.1433036-1-ray.huang@amd.com>
References: <20210923054201.1433036-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 614d786b-5965-4705-fa1b-08d97e54f890
X-MS-TrafficTypeDiagnostic: SA0PR12MB4510:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4510CC4179C131082F76EF89ECA39@SA0PR12MB4510.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SQLDe95n8tXEf3J1vtjaqoAAstitGb2UYe9Lh84SxGHcgUymc34R03F39kLxyI1tgcRuLrtJ7+h8+yBPcDFakAlLRf0FqCwJouINztfgb0CZmaekNbZadFcvRKeD8sBaeZenAq5XZeXA12PKxEvrMK0ma0BSetucy7SwS69BGdL5OY1mtPNYdXa01vEDdzMf1EYnXHcTeidbrzDdj79jXaGVKVimCE0LFCRuaA5ybyMS1ONxuJ246RFeAZONqK8shBsrDlTLAnu8EVV03I21s5TUPMUkjQ5B92nXlMiPUvyLeoxgiW9bHtMnncY3EqfGfgCTFqBOmFKk7SycT2I5fHlgXp69krHKCgU6/iL7tQh2CuxTP4Iahff2MDQJrfOaxMs+pyCwWfHoa0hIPKIj61pJyGTVl7FgFER6W4antO9aOxvp6VQO6YFf3pqn2wGWww22KP67ztNHpobnmn0B3ZIGymUVluaqsC3eqe8X6tSfZFL2txF8XL3Mog+OKjCMTJuMchTJPG/RN20BcKan0m8QFaWt+ABZ4ta4K28LJEgZeShMVLk3hTbH5pYy8adkda9Vt+pZyQ7pn/ZLA+9gccA3Fg1BgRdRyv0P5kJKgFwvUjx5GXmwOIaBm2Q38KuDWdUKxeyVHN8sdLpkbwTI9/eXHjdETlSarQekm3WKCr+8ewt0XRPdltphRaweILCa63g3pPaiyQRVPkT3aCVCeRHvHFVzs0E8uLnsCitdNIY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(26005)(16526019)(1076003)(186003)(86362001)(7696005)(508600001)(36860700001)(47076005)(6916009)(36756003)(83380400001)(336012)(2616005)(426003)(82310400003)(4326008)(70586007)(70206006)(54906003)(8936002)(81166007)(5660300002)(8676002)(356005)(6666004)(2906002)(316002)(15650500001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 05:42:46.1799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 614d786b-5965-4705-fa1b-08d97e54f890
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4510
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update golden setting to enable full compute units for cyan_skillfish.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 16dbe593cba2..5f9382d61234 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3573,7 +3573,8 @@ static const struct soc15_reg_golden golden_settings_gc_10_0_cyan_skillfish[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ARB_CONFIG, 0x00000100, 0x00000130),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_LDS_CLK_CTRL, 0xffffffff, 0xffffffff),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0x00030008, 0x01030000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0x00800000, 0x00800000)
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0x00800000, 0x00800000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCC_GC_SHADER_ARRAY_CONFIG, 0xffff0000, 0xffe00000)
 };
 
 #define DEFAULT_SH_MEM_CONFIG \
-- 
2.25.1

