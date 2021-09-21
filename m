Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BFBC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE7161168
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7EE7161168
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A7DA6EA3A;
	Tue, 21 Sep 2021 18:07:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B6AA6EA33
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPFXgDTCAvw/W/nYh6NxsMEgPwjRg0dBE48FGlNXcRj1IsBH39zvQFRzL/FDAsUcfQMWvZq7ewiNgJ/9ibNXSFmHmyMRxrmceARMRf6Ow8zimroDn3mpTnb5dKxf8L4b3D3n+Y+7dnbO7z4xPqMweODcnvDyuS50mhjHZ+AzVK7CKPsSk39gTOy+fZmK2KXBeD2G+ltv85c7J84MAI0+H1a/sj2vMNuG7rbmGMeKmtlQARCmiifDya+lZJpgccxl6Pba/imr+hWGsYMmW4SfRCI41cclhyzPFvhajOHWcC2w9xRDLeP0ZC2mZp8wDUBvFWfOFQvOnfKX+RspV0Tckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=lgGyxTAuEcuJSZgEwtD/6LsYs1n1e0XtHUhaOHl8tWs=;
 b=TQVPDfd7kSpYHIbJxx1JClEMiJP8Hkasyh+EXEAzOn4Xtmd4fYqMCLeZdomwfJcdkIeMlhD+HsWWP0rc91Id94LNfz0lHqfasugNUPClLI2cxSaeMZbKn5jDDuZnPfHlwXU7mFTX5BI5QH/xjbyhzmn4ditWRBkB8wFdLnvgBEk3ZInLuEsF3pa0iFa4K/0PGNoHeLFRO0CBiyLzTcRK3bcO3thzUcJRjFfTHH+3gb5JI2x9bbBEKogAGp9PCasb/jPr68TEP9tAfP1KDX50oJU3+QsHrR5+pXC5anhm9G97mBo9xwZoBvC/qBaSjBkIlZEYJF1APVgsIAmbafWATQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgGyxTAuEcuJSZgEwtD/6LsYs1n1e0XtHUhaOHl8tWs=;
 b=D+mNgEZVDvc4L8ahhFll+VkJYlxqFJ58iM9cZJbHRJP4X1LBG2rHYbnrLKwVFRM7lUrDHXvAvRaRZEEu5GKojhu+eDnyJHsTFl2RzMi8Irfra8v+8EulQOLRvvzf+Lfzk9IwY1GlObJv8NJ735xzpBvF2cph5WZzyOcwKY7KLH4=
Received: from DM5PR11CA0010.namprd11.prod.outlook.com (2603:10b6:3:115::20)
 by CH2PR12MB3735.namprd12.prod.outlook.com (2603:10b6:610:25::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Tue, 21 Sep
 2021 18:07:42 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::21) by DM5PR11CA0010.outlook.office365.com
 (2603:10b6:3:115::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/66] drm/amdgpu: fill in IP versions from IP discovery table
Date: Tue, 21 Sep 2021 14:06:23 -0400
Message-ID: <20210921180725.1985552-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7f59be7-0284-49b1-f930-08d97d2ab4d9
X-MS-TrafficTypeDiagnostic: CH2PR12MB3735:
X-Microsoft-Antispam-PRVS: <CH2PR12MB373569A3380EF3B4D5979D20F7A19@CH2PR12MB3735.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cW3Zackw8q/GaJQEYDdzSsaB2akFw2FnHDwdnf+7rhpTo7QqJy9bWgoMOTFu/iykUGnUiNG5DHCgNesSmb/Kq8v8gma3lK47+Ftx20+wNau1hd0m8fc0sf0WmdZtObp65ckjspgg2exyj31+Hm+gWb0VnF5N7AEwSjMV4m4xvjuuX7FuFk7875w75SeWcVjBLyDaRC352/AzsobNwx+9dLM9SXWNgW6OyPAza8aBsSoPwd45gaFAFxwUmtzWZ51sKLSfbEufzaND+hTj9V4kJMoqUB+iO4nDcsicX9UH4m4KdvQb1+bTpxypg2wURPdFKZ3TKK8RN5c54V5fxCFAPVvwl2K/oeFwyHG3u3UxvWl/oapTJfb3hKwI7tXJl+8jeIikmRYmaylePM5DHlwcw6JObfTL3JAzkG5my1HWk4FgHZOApQ17oaP50zusXIhZposACYuFVAyD4y7ugejp5C1rl+SVxlMnw4LS0WsTJO0ujFyrd9Rqiy8zv4dUH0kdT/VjmvClQjl9JD+L4QEhiEO16W0oq6GBxNaVqApdeKVQWXlKq4YJj/5d9mE3+kozcgc5vLsm2TZlHbIu9ekrkm/oz1Zexdf6yfCck0DgeriTOsS+CI8++ChQygaxn3+uoJpiJIED43RG6MXFwQuL1kclj4o+aqDLKJspQoIt5cnbCJZY2RYyAAgQWwoHG60PuwvV09bdTQZorGIlFz607QyrGuSE9O7k197M2f09c3E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(16526019)(508600001)(426003)(2906002)(336012)(2616005)(86362001)(4326008)(6666004)(47076005)(82310400003)(26005)(186003)(7696005)(70206006)(70586007)(6916009)(36860700001)(316002)(1076003)(8676002)(8936002)(83380400001)(5660300002)(356005)(81166007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:42.5118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f59be7-0284-49b1-f930-08d97d2ab4d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3735
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 67e7a46f5020..ff52fcce1f93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -244,6 +244,11 @@ void amdgpu_discovery_fini(struct amdgpu_device *adev)
 	adev->mman.discovery_bin = NULL;
 }
 
+static u32 amdgpu_discovery_convert_version(u32 major, u32 minor, u32 revision)
+{
+	return (major << 16) | (minor << 8) | revision;
+}
+
 int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 {
 	struct binary_header *bhdr;
@@ -316,8 +321,9 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 							hw_id_names[le16_to_cpu(ip->hw_id)]);
 					adev->reg_offset[hw_ip][ip->number_instance] =
 						ip->base_address;
+					adev->ip_versions[hw_ip] =
+						amdgpu_discovery_convert_version(ip->major, ip->minor, ip->revision);
 				}
-
 			}
 
 			ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
-- 
2.31.1

