Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0790DC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3A4861266
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B3A4861266
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A54F6E893;
	Tue, 28 Sep 2021 16:43:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B4346E8AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:43:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nta78y0MfnBkG1TaJEyKCHY+S13uCc9HSkaR8zn08Fe1TOHRK2/1C5lYSP8BZnopWteHIlixWHwNkvOOPpcynBcKps7XBdQgyLOoK/j16RUJ0+NTMeb/tHZ76DQtzYsIIBcZvn7iEKqvQCLhs/wiA1qaPdOxWCzSMnXOKLolTtNTh9VIHr7Qp2XvI/gavpDczBMnvLovj3kMsXmiXSllGEZMFik+A0zqHVOTnu6gNVw6u09BfgwCqE/TrxTOPcJNr0+veffdlLFpk+QKXXKB8imBqwupt/rPTpmZpvqW4HDvSmP2GSs23enJJO5FeGATiwR31oakWVR2FTTLED7/9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=BmP8lHqZnknUw7mj84/Fg0GU6UgU5g6RfF9TwL9rQS0=;
 b=J4wI/K8bASZyBKWnpVvpgD3nlM1LhwHL1PJb8bIhG4KbHJjPuhAm+z2qMMXt4neoDLhQUZus++1cFke+b68s/JnCVy57mW5XgkY3lfHA77Awum0nqqmkYbTWCcy78K81H2XGHWtWN2EysPXb1s4XSiyYkPly8ebflzVCTmGOcwCVIG/mtLurzV1xvb1fC2Le2HLcnza5k7Dzs4np2AJ1V170X4I40WtAyuxB7Nv62ILyC7MnBrwQvBEpQatbYRMdqV49a5Xrj7a7XFZfJNny69HWwqoR1Az7nffUg9VESKPyYBwzGo5LRvFf8R7h/IXfO3C/zRbcSBAxKCjwZNjsBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmP8lHqZnknUw7mj84/Fg0GU6UgU5g6RfF9TwL9rQS0=;
 b=XeTp75QrLOnhY97XwRGFPOJ5jHTfufGaeDXIet9YoT+22gm4vMdQQmwEwgiCHftQzbBHPC5Pl0AxSUgZ3xfuzbO1ZkWLNLjPsRgjP/QbZQSJnJ0Fev2i3c1JVPtdQ1f959nz0A0C3ocp4wSYa17i4aUqTGR1QCl88+VD6zfktf0=
Received: from DM6PR05CA0043.namprd05.prod.outlook.com (2603:10b6:5:335::12)
 by CY4PR1201MB0168.namprd12.prod.outlook.com (2603:10b6:910:1d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 16:43:16 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::19) by DM6PR05CA0043.outlook.office365.com
 (2603:10b6:5:335::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.8 via Frontend
 Transport; Tue, 28 Sep 2021 16:43:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:43:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:43:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 04/64] drm/amdgpu: fill in IP versions from IP discovery table
Date: Tue, 28 Sep 2021 12:41:37 -0400
Message-ID: <20210928164237.833132-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85d65c25-7c1a-4258-8353-08d9829f11ae
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0168:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0168743C1FE78C35A7E9E0E6F7A89@CY4PR1201MB0168.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQIasWUJa/a7XfK0y88sbia/Am7W+xljneIaJYEnyn3DbXSE1PvxsOWomBOIsjVBekwx/M6tQu6QEtLdveIw0OebmG8GK90+7p8zc7vP3Tz1rRPkDjTgfKEUjboBMhRTY/nKrsLCRFi6RvqsrSn41UDnwaXunHfarWpK8OZqFeuAix8uIZQ8V6OjfwtdBQU6S1XbU4VYLQbIAjCMJButi/82gLz+9aEAShOvhjtXgfZpsB6uK32uNI7DZNPrqVu9gBwFJDzDRFqWh8fTxMcWRS5BJwMay/L2Aruk6mnXJyefnfswE/4jGHS2ZMDN5/KaFruCP99KuvFQ1JH454A9TmdPFJpO2IxXO/qw3aw708K2xqFORbRGDEz6F4YXMw6CrFXJKyh5W2MMUFuBqy+mca/lmq5gVDS/OnurgIDwgFQKwOy/8BrTm185ui5kSar+TSsb2Y9ncY8F2Fkp3gamVw1fpQslYWLIWpwZGw3AP9DIcDzMOtTH/aqfwccQAkacRavAktFi/rG9EljyNSDJvEIAYux6v37briMX/RyxLs2TOvZeqtvzMp9bD/zcLA8LLC+NBCRcF04Beqi7O6Fkty0MxWVwkmct5NLDbK9NGySZMzYMnRCl8rtDvIzta0SNt6OyM+AVY+IlUpRcxYsVfziBoWmLp7w+HlQ8cGMMCzs4IPvizdr0R4sBJeFXfozP8O0/o51hXkTV/2oP3NSOcJ+flRfIJjHC+5oLGyAyR1E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(86362001)(6916009)(47076005)(36756003)(66574015)(336012)(8936002)(70206006)(5660300002)(26005)(54906003)(186003)(16526019)(36860700001)(6666004)(70586007)(8676002)(1076003)(2906002)(7696005)(2616005)(81166007)(356005)(316002)(82310400003)(83380400001)(4326008)(4744005)(426003)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:43:15.6916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d65c25-7c1a-4258-8353-08d9829f11ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0168
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

Prerequisite for using IP versions in the driver rather
than asic type.

v2: Use IP_VERSION() macro instead of new function

Reviewed-by: Christian König <christian.koenig@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index d195b814712d..3c60b7af9898 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -336,8 +336,9 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 							hw_id_names[le16_to_cpu(ip->hw_id)]);
 					adev->reg_offset[hw_ip][ip->number_instance] =
 						ip->base_address;
+					adev->ip_versions[hw_ip] =
+						IP_VERSION(ip->major, ip->minor, ip->revision);
 				}
-
 			}
 
 next_ip:
-- 
2.31.1

