Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB0EC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 01:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24C7B10E129;
	Fri, 18 Feb 2022 01:39:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A640510E129
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 01:39:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkt6OBbJJjHnbbq0b7JRfXfCz1GqeD3RCvODXjOhb1mcnz0Z8qB+EKD25/EIagEk4y0NjZVfZBnwt48TfSgrERmwAZlSlQdplZRRpDdvj8WneldoZClYOiB6dK2F+VY6SsFh9w+eQjelkeqvUoPKluJM8w5D9o5UAxxhJdDTc3u25hFPG83eEfCMjvgvs9sgPuMDTs0ArEhr3m7lB8ZhLgAoOddBJmhvnuRqK4AQ2H6ci7VTZz28VoJe4ogNZGPmDjEIm2dyuOOZXJ6L/gd+ELcChdOpsn0rNHzw+BLqQ1b5GUfdUAl8FY+P7n9gXw6hLth64b9i6WVSHb/M4aMVhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtDo05qJatxTEtgPDHi0n7XynPPRyAo/ke1Kh//m8nk=;
 b=O3QCEYsZwPMNt/PnIludgIABVJwMikVEB8ENcAJPhA1btsXnJLX1L83+sJK+Qs4Dm8CjmANWLvhoSS7jHi1Q4XWMfBzXS9jbDDu4ty8Mv4ChdcH3jN9MS7dYVcVEdZqS68qYWBLktiGdeljEQ9q02IonqEJgQNyVycL6xLo4+yKFhI8w5fng69UuRg86CTDDFczeaDbYjrJGxpLp9sNlH1xnKmWJP06qBSSOKHMwMEmVPXML5ahvrt6d4B7bM/yr3Ssra/sll0Xd20gzjRWTbMmkSmc0vkdTHm65T7200MP10RYu0qky53giPMcxM3/PrFRIYEP+fE9wJsbvjL+G6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtDo05qJatxTEtgPDHi0n7XynPPRyAo/ke1Kh//m8nk=;
 b=z5U6LDXU9Vpx6lwoC9FMvwhlJyAOTyQZ8heoJ/9P/T9uVsjFOGSxECX3Isck1C81+b+AqsaXgVyqBT+fxUCgUucYXipFaoptTVElRf4oGlyFplao4n9IZic0rE2W/YfK7gClunKXD59wbPv9fjNzyOhAuaj6a6cmdo88i7UOzrI=
Received: from BN8PR16CA0026.namprd16.prod.outlook.com (2603:10b6:408:4c::39)
 by MN0PR12MB5906.namprd12.prod.outlook.com (2603:10b6:208:37a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 01:39:21 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::b1) by BN8PR16CA0026.outlook.office365.com
 (2603:10b6:408:4c::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.21 via Frontend
 Transport; Fri, 18 Feb 2022 01:39:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 01:39:21 +0000
Received: from prike.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 19:39:18 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable TMZ option for onwards asic
Date: Fri, 18 Feb 2022 09:36:59 +0800
Message-ID: <1645148219-17774-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2886b23-00c3-4f03-b96d-08d9f27f7c71
X-MS-TrafficTypeDiagnostic: MN0PR12MB5906:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5906E7B5CB079A932796FD0AFB379@MN0PR12MB5906.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UwLnym+XHlJNq7HRgWMw1D8KYOuOmWKul2VS2zecXC/IJkmZbQOWYln4NTzacvsimqhKMuKrIMg45+dAHEG8E+hyESJT66YualitTVOA9IpQ3qCmqebkt43f5VO4mCpDSFNrMxaBFGtqKNuuQtwCNshT3nzDpzv5/1Lf1C5hzv4n4e5dCChwcOfWNdTswnGEYZAuelQrHjfjgCrDI7E9q5nBlKXDAok138m+Zi3XuKoQ/HQVoLKTMZEalAdQ2dejju/EGokVVWfywSnymaqu8j63APBEuCnhDpdYc+hDz64i50wnp30Qtk7G1NFIChCIXtpgsrgCDQhWJyPxWtae9P2Sxe4jaXHmd2dSgM6pP9p4Tj1fsHgUe1yYniN7G5W4ZQMLrO0cbRqJkNcOngmcUKqEN43sqYilxpN6L6+DgAAZiB0F3iUjzTXExUIRS0NGK4CL57vkPwmK98zPDDRKH9d45sFROPG5FZ68IqMcyZXGNzWror+2ag+yIY2y2dgxLeJgeY89Gkrji+M8I9Hb2ISlsLgR/iyjFSYzimR6PebISxu5M/NVoIKDfy88wF1Wn9hwEqM+b+V5EQ8OB1muT5jMSazONvMRnxnPsZVtel1UdllVGwWvvD6nUlL0UwUIR+ePavSkxXLrdPUSwk8lPtLhiX1oQUR0TN+hXNi2Rbj/nz96TR+KK+DLbKMilJGgcJGFl4xBOFc6qChlnQLXnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(5660300002)(86362001)(508600001)(70206006)(356005)(36860700001)(70586007)(81166007)(36756003)(83380400001)(336012)(26005)(426003)(186003)(16526019)(4744005)(8936002)(2616005)(316002)(4326008)(82310400004)(8676002)(6916009)(54906003)(40460700003)(47076005)(6666004)(7696005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 01:39:21.1607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2886b23-00c3-4f03-b96d-08d9f27f7c71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5906
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 ray.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The TMZ is disabled by default and enable TMZ option
for the IP discovery based asic will help on the TMZ
function verification.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 956cc994ca7d..d2dd526a4c80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -581,6 +581,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	case CHIP_NAVI12:
 	case CHIP_VANGOGH:
 	case CHIP_YELLOW_CARP:
+	case CHIP_IP_DISCOVERY
 		/* Don't enable it by default yet.
 		 */
 		if (amdgpu_tmz < 1) {
-- 
2.17.1

