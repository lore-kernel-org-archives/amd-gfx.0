Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4ABC27C42
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 21:52:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A0D810E3D5;
	Wed, 16 Aug 2023 21:52:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A94C810E3D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 21:52:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5lpfXXwv2A5VkWmqpMvJ4mV6GpPGOryr+sx9aqtekSjynvRAyagLAzN5F/+oms0kVQ7RT+bAoJxO85DxqTDgvJ5THO+H1p+0bwFa+3ZhyWMUO9U3iIlp07juUVsL0ReJzKG/Eg0YCTZ0nKHhoZCljzKEith7Of4kziZXvZtD1q+9MJ4LlquqXizci1/wPGii4D7jJ6TUgQMisw3KqgaicQP8lq03UFTRDCWPeIlwJ4Zfnc70cYb/C6jU/MnmQQHTX+BD+IgSmKTv1OB6dU6GM7UC/B/nCv0gMJjpobZM6wsEZQsF4WuK4bUtwMQoLnQyeS/J/fAUX3xrsl3URH3dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqt1WFXmroebO4pAIby7lf14pok54JyeNNTH6O+XmY8=;
 b=aoUWGzRly3aLKo9TdMz+fxBYx10VSP1O6wxakxOoMGWuTnN8ah9J8Cyr1SZ5rLWKru5LwjKpDUxgOpghwQCOXhJzddpjTCoIdEOzs8pqfdDtFho+G3zapc06chjh3oj3+zz/HL3R5BB8N7vYLEjZzXaaUzeRli5PytS2GBaUBcImjFU/HcuF8DL0L6kNMQaOtL95kPUf3Y5/adueFaJQjpRggyuDfid/0o9QgbMeWiz5M1tIzEDQPfc8KxQzZIWAKvTaOhNGojGjhN9liacfDByAwiZ1410UAZJUcz4Zqo0rhQtXHkSNd69+ln7RTe3NIINrpBh2cMmXxK6wRdLWdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqt1WFXmroebO4pAIby7lf14pok54JyeNNTH6O+XmY8=;
 b=ssDehBZp1jeIoCjR2VDivj2+gPfiE/EoNBnU4+TS73h9B/MD8MAsKLg5j1/OcfwmSMjQijSOicqY8gl7wC7aegmkXEaOw4BhZi31lnW3hpMxFVxn4ujEjQBBHoP8ZIuHu0kqRbVWNs/TSvOClBUjGjMZeGMTSioIeBdkjTZN7Fw=
Received: from MW2PR16CA0018.namprd16.prod.outlook.com (2603:10b6:907::31) by
 MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.30; Wed, 16 Aug 2023 21:52:16 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:907:0:cafe::2) by MW2PR16CA0018.outlook.office365.com
 (2603:10b6:907::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 21:52:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 21:52:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 16:52:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] NBIO 7.11 support
Date: Wed, 16 Aug 2023 17:51:56 -0400
Message-ID: <20230816215158.826684-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|MW4PR12MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: 320a4e86-4bce-4389-b130-08db9ea30e9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kdCXN0iHXchj2OeT4x1s5Nxo7aePjsVlOD28YroOssdEBPqDi7nMAlW1dUsgQWtruzhGnojtPEBiCEREbtZtGPLY+kveWFaRxxgr3YpXbLmZ7+7x7uBw6sZSy6xu1lGbqxVjlj+VoSmcQcGbisiZwhCURqrx9CC7j4LwnoI/DtLBPfAPi7I9PeBaRQ4Qt4EVSM8S3whmcxy0BCOCWUW2VyB1NqbCGOZUOWrlvcn9rwPAAcIKimdytbaH//xiVrCXi+Q7RjOK3mjilCm5vWTAZBGuu+KJ3gwZHlpTwp5MgkPRX9WwcEOzrjwqmql+zYk9s5HVPSMuj5bwV4kQx7c1PGYbVAj4LIkKRRGZPxhI3dI7d00DnDGIDmywIQZI2uoK2gzaNMwX4cCSbXOpHhqi8XupdjZV028jxf0yo91sdH2RbR/BJQWSrFxpGAfwENl9txcNZ8GRdrhbRF3vk7hBJH8em0J8D2oqKc1KvGF4AQpE/pHPD+Wlj18t4h3P/PBbOmMl3QarUqW173cdoEG6faTpOoZ8Ikk9Rvy4cYo+aK6c8I0AWTpYAYdxaEMF8c1pf3OK+/WMyvxsuj6FW3uKzyqu5/Zh8kR3YINgRI9zh/4gDg+fAWceExMmfcOgC+j/iaOqphFMFpwLSnGxseKUKrquG4pFMAt7srICIQlC4AKi1JrdJRG/lZrvRkpe/ytjh4sla0Lquj+JhkRkp+uWgySxWbCZ/a4FnGBoKN74/3ApVYtdqV4v4Vf1WD+8SvfovdOQT0pjVlCk6dTRU5ULVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(1800799009)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(336012)(2906002)(4744005)(1076003)(2616005)(26005)(16526019)(86362001)(426003)(36860700001)(36756003)(6666004)(7696005)(356005)(81166007)(82740400003)(40460700003)(47076005)(83380400001)(478600001)(40480700001)(70206006)(70586007)(6916009)(8676002)(316002)(8936002)(4326008)(41300700001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:52:16.3370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 320a4e86-4bce-4389-b130-08db9ea30e9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7142
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add support for NBIO 7.11.  NBIO (New Bus IO)
is the block that handles the interface with
the PCIe bus and other related things.

The patch to add the new register headers was
too large for the mailing list.

Prike Liang (1):
  drm/amdgpu/discovery: add nbio 7.11.0 support

benl (2):
  drm/amdgpu: add nbio 7.11 registers
  drm/amdgpu: add nbio 7.11 support

 drivers/gpu/drm/amd/amdgpu/Makefile           |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |     5 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c       |   243 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.h       |    33 +
 .../asic_reg/nbio/nbio_7_11_0_offset.h        |  9391 +++
 .../asic_reg/nbio/nbio_7_11_0_sh_mask.h       | 57846 ++++++++++++++++
 6 files changed, 67519 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_sh_mask.h

-- 
2.41.0

