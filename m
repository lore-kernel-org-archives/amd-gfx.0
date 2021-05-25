Return-Path: <SRS0=WUpi=KU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BCEC2B9F8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 04:03:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD01613D2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 04:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD01613D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67E146E3B7;
	Tue, 25 May 2021 04:03:25 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2083.outbound.protection.outlook.com [40.107.100.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A7936E3B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 May 2021 04:03:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bp5Jf3lRVshIqE+B58rOmglofXewH2y2gDbyvf0ZSudOtAukMivaOkmcJcoDGcA2Zx5w3L0qBWBul5rw+1sIQZn6rX9bQ6KsH5ks/mAYAhvRKmRfIQ4scPxRRJM6mVpv5sp5hKagCfiaBE6npKqN3SZaBL/biFENrA7ns1F3VCWwBgFcJPQvPL4tTkTxrNh+DX3yaoxoYnz2dq7EjAyPkbzIo1wABlux/IYu5ds3OstQTUKc7Au/N3O3qli2W1iznyVeqRgf8nMp4W7cGGluzOED2YcAhn9E9mM/DrYZk9t5uwKTAXKhS9ELNP8/hRcx2KSjoRlAvgR+xXg7pgkZoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gW6b8TYZz1a2mQm22NlQv/MNPtxv3gpIuN0aAn0I3B4=;
 b=R5/BIHDqEsdI6db90fV/GJZNmgPT0p4tA7UvYnUvPFi9XqWAjDcbibPqXqMedR9TwVHXWWQplCmF2nuAknTRH55rsKgPuOkKVWQlZUylNxR/gqqAuK/YnViFF/+xZmcAa2mM9VykhGl7O12Kg8ZZkomyshrVD4bD/0lEV08Epa7XYkIBS3Xjy96Wg/wCtTENU97IxlBJGA2Btx2SIIVsnb4sBFUFfzR3OYKJmtxpjR/4mqWmEJw5er67DQKfZeAdHp5tJOYLADk0NJvx3K2XCOAqhGvviOwy9WVk8F6cb0DfdL4fl/o8uSVIeFMrpD/fkCW72aYCioHh9IEuW1lSew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gW6b8TYZz1a2mQm22NlQv/MNPtxv3gpIuN0aAn0I3B4=;
 b=psb14nzPZBn/vMTXs3V5sMPujGkWysesD+dJHwc6JuDn3PK+KWrhrEvA3UnA+/W4YLOr/i4RwdBn7VU5+KXwFgR0PmpCq6TZYJ5ZM5FcpMVHbxEO5PteQubhBulAIxbQC3K6yuaowsbes2SddisWLiJn63Pl3vFda/RnDKNDHL4=
Received: from MW4PR03CA0280.namprd03.prod.outlook.com (2603:10b6:303:b5::15)
 by DM6PR12MB4027.namprd12.prod.outlook.com (2603:10b6:5:148::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Tue, 25 May
 2021 04:03:20 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::ea) by MW4PR03CA0280.outlook.office365.com
 (2603:10b6:303:b5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Tue, 25 May 2021 04:03:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Tue, 25 May 2021 04:03:20 +0000
Received: from sdc-lnx-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 24 May
 2021 23:03:18 -0500
From: Asher Song <Asher.Song@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add judgement for dc support
Date: Tue, 25 May 2021 12:03:04 +0800
Message-ID: <20210525040304.294667-1-Asher.Song@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6798993f-99db-46a3-d610-08d91f3208b4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4027:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4027800CFD13FFB0FA289F8B8B259@DM6PR12MB4027.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ebe+hRB/wqosYt4cYvVvTGJtEExL3uxWXItSIZYQcJSyBm2KQ/MS8keKBgY0+CDZCCHcs2FSGztvKksJPGAqBSBleP+7Q7AYuhb2aTHVBIgbv2cbijCfvboT4F5+vaF0XmEAdAGcVyaVm4wFpI0DTeMVEDXU0rcmg7tDyISxtbR5qLvuGihcJqZmJCvMoo3znbeftaqKRYtFgpPvx98aMmiakmjrFJlkKF4emkNutyW78dHfF0fH9dST/MSJIgPdLIBVIy8qx6TML4bT3jGRhJ/VGZ5/fkBQAOkApNWNrARz+LX0UyZGYDNm2l+eH5kIkYe9kVELxJxoPVuc5MQkGgo5BscqjbDIEthcS4nlX5LE3pg/dRlp7EnC6K/7IAKjx6sgnzf6tIVNEI4mLTiKw18H7MfZkeEbItUmKrbRAi6YT/FMvoYth8y4gH8+4SizWNHh11lyMP01RjVuQE9NIYyRkQGsBKyczj8k53YOlXB9hPDfr6EP3BCbP8UesKOR5xtHDJtOS54O9akCHy+33ci+LrmV4CUmlkRb65YhlvdRXQAgLmk1Rzlv66LpfSDaxcrc5v0wttky0CxyhXd6QacWHTKQcjprn2lzrhrzjj2lC34P8obgL/s8mie0NHJdEg4vit9h+D7GiZKsI49lqMXViiBwktVn2rOOXS1QE3rhJ0biDbeN2O/coOuhOoKF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966006)(36840700001)(36756003)(6916009)(356005)(82310400003)(47076005)(478600001)(81166007)(83380400001)(1076003)(4326008)(54906003)(82740400003)(6666004)(316002)(16526019)(186003)(8676002)(2906002)(70206006)(2616005)(86362001)(7696005)(36860700001)(26005)(5660300002)(426003)(4744005)(336012)(8936002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 04:03:20.2921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6798993f-99db-46a3-d610-08d91f3208b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4027
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
Cc: Likun Gao <Likun.Gao@amd.com>, Asher Song <Asher.Song@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Drop DC initialization when DCN is harvested in VBIOS. The way
doesn't affect virtual display ip initialization.

Signed-off-by: Likun Gao  <Likun.Gao@amd.com>
Signed-off-by: Asher Song <Asher.Song@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8848e2b9bef9..148da7ca5d55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3122,7 +3122,9 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
  */
 bool amdgpu_device_has_dc_support(struct amdgpu_device *adev)
 {
-	if (amdgpu_sriov_vf(adev) || adev->enable_virtual_display)
+	if (amdgpu_sriov_vf(adev) || 
+	    adev->enable_virtual_display ||
+	    (adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK))
 		return false;
 
 	return amdgpu_device_asic_has_dc_support(adev->asic_type);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
