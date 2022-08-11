Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB976C25B0C
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 15:48:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AE3A9C969;
	Thu, 11 Aug 2022 15:48:51 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 447B2B47BF
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 15:48:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFWYe8uHqf+DYh8ZjGNDwVmMb+d0lVGilOTD5qr/birPOiL+C1GG5zHBgsf7d38xJTHL8zI9SA+L/WtnevaMo/VWiL7DsZW7D9k8FJU4RY5021Iw8t9L2nzeDlDeazdeOdbobe8q5DM6HMOwHZD9qct32X99xVR+JoFBDlx+6wuQo6LByQmyXmYRK0dJIOFo/hubGidEUNtTdUQ2K6RcJnqiHZUlTho+CI5O2jj7dMb6KUMSeS81afFdVgjeRH/uDrZbEbkvkwYtpYuz4C+4J/frvJEEGHNloPv3H5FeOkPBdM5CQS4fz+PwhFJgfVn0mYcVi24bmEp7PPE22Bns/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJ99jGwX04SSIr1Yrn3iOtaOMExFt/Z0ireSndz0XY4=;
 b=auZe7YfpjAz60siWKEzTlxFiz3rmgcWdDIoyrgpU9erXI+m8vrmzY5O/gBBO7w2ZxLIqz34BwEscjy4mdFUJcegdsty4meDL2JOUQ8mHa7QM9LoH1++voKlC32zEZ65tsEsZaOFHjZul3lCblMmraP3ZQs9sQSeBNFS71Zp+YhUPewuWERctYP1NMMcfzGs/RaMAXOY8i028qm+6mM7pO+JP++3YgQ8rULQkFczXacPMGO7mI2HXUlYZ/uhrXSLOIOs2/Cnm3Ar89PgwWFrshFZgdNDF516cyrLAtM9qB+HmEbJT0/xK/eEouChgdgkcf6EORTuTGJAxycHgRS4L4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJ99jGwX04SSIr1Yrn3iOtaOMExFt/Z0ireSndz0XY4=;
 b=ZJP8J9DAiSfljsuxG9V9TCuFn4XlEHQDbnwM3ZgAle8N90NSH/lsLDZ5VNNedLKeNFDcX0qJreof/ZMz0AsSWKs91hF/Iz3ipnWAbBi2g9p+IgVf9r4JZELQ4jlU6WXj9Q/lIq/TJzTOjqTASh5dqX9oKHNpq6U1cVy3kbEDA8Y=
Received: from BN9PR03CA0108.namprd03.prod.outlook.com (2603:10b6:408:fd::23)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11; Thu, 11 Aug 2022 15:48:38 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::9d) by BN9PR03CA0108.outlook.office365.com
 (2603:10b6:408:fd::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17 via Frontend
 Transport; Thu, 11 Aug 2022 15:48:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 15:48:38 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 10:48:35 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/3] Expand amdgpu documentation
Date: Thu, 11 Aug 2022 11:48:16 -0400
Message-ID: <20220811154819.3566210-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8625266d-df17-4877-6622-08da7bb0f52d
X-MS-TrafficTypeDiagnostic: DM4PR12MB5724:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WWeTHUcX01oTjzsS400aGRcx+EhvQe5KZHu6tyAFC9mGlPmFJxIF1B5OtAtPg0boSgQCEWmpQEPCID9dEajtT9+AYjMTMTvE0rgymKEg34klSWb4ricZ2oS4goOi/Uk9r+MLtu+3MsBI9aET1POO8E9jQRJTiSkI4XMGukrlSH1vFzV1EF8R+JOhwFnsxYhs4D8mZExHLV3QcKNAkWwMVGzM3HACRI52Hrc8FmVt+Z5KnzpOQrpln3CkxObqMl3knkBchoPz2zXAOd/qAiX/sTwJjhTV7RHZ7Jxv4jBlboIRDx6zsq3hjq6NOpxjyAKzO6aBh4FP5Oz2G4NxKlJYwatfeiVuF+NKufsZ97aDb7+32YRCcfpGCxBvXSpmYFDudp3PC79dMkbvasmsVdUFhcEIzRaACrEFwtCKL+sHTGvXoJdCEqDMp0Pn5CkTYsDfnjFACh2sOHyv9LoC+Fsj9oreocYsaQoNuzMczdQo9lvaF40yUPneXR5onNOEGsLs79KoiRaiMv6E3MvQXw9az625MOowolNugAXuWtOhQleMf4/QrMhXF3Ln3+O2ol+p3gbkMiZmeMEyvyGiRGLkRA/ay/79MrS/ow+WiTaXLyjEUFRMK0jgfoMBr4WfjeRA4m+yvketpdT7ej49yZ1D6NIKSu9Xi/gJIjG0WxKzavpslvSbHrpnYTvLLzGMV46YG5jWd+1GoX56IgZRzDq4Es9BiXBAHvz3EpaRELhwuJQikq4rXE7nLIZcJ8X6hMkoc2+hQCs26GmkIsvzHauQbtYLqZU9EsvGyWh0e81DOsihGRP/qLu/zR/KHJcIsyag6fbvKkPpPr4I6H8KYIEV7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(136003)(39860400002)(346002)(36840700001)(46966006)(40470700004)(2906002)(40460700003)(8936002)(356005)(5660300002)(26005)(40480700001)(86362001)(82310400005)(81166007)(2616005)(336012)(1076003)(186003)(426003)(16526019)(47076005)(41300700001)(6666004)(7696005)(36860700001)(478600001)(316002)(6916009)(8676002)(82740400003)(70206006)(70586007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 15:48:38.3419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8625266d-df17-4877-6622-08da7bb0f52d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724
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

This patchset introduces some new AMDGPU documentation. You will find:

1. A CSV table that maps which component version is part of some ASIC
    families. This can be useful to narrow down bugs;
2. Some explanation about AMD Display Pipeline;
3. An explanation of Multiple Plane Overlay, which can be useful for
    userspace applications.

Since we have some diagrams, I recommend applying these patches and
building the documentation to have a better experience.

In this new version, I just rebased this patchset with the latest code
from amd-staging-drm-next, and I also changed patch 2.

Thanks
Siqueira

Rodrigo Siqueira (3):
  Documentation/gpu: Add info table for ASICs
  Documentation/gpu: Add an explanation about the DCN pipeline
  Documentation/gpu: Add Multiplane Overlay doc

 .../gpu/amdgpu/apu-asic-info-table.csv        |    8 +
 .../gpu/amdgpu/dgpu-asic-info-table.csv       |   24 +
 .../gpu/amdgpu/display/dcn-overview.rst       |   59 +
 Documentation/gpu/amdgpu/display/index.rst    |    1 +
 .../gpu/amdgpu/display/mpo-cursor.svg         |  435 +++++++
 .../gpu/amdgpu/display/mpo-overview.rst       |  242 ++++
 .../multi-display-hdcp-mpo-less-pipe-ex.svg   |  220 ++++
 .../amdgpu/display/multi-display-hdcp-mpo.svg |  171 +++
 .../amdgpu/display/pipeline_4k_no_split.svg   |  958 +++++++++++++++
 .../gpu/amdgpu/display/pipeline_4k_split.svg  | 1062 +++++++++++++++++
 .../single-display-mpo-multi-video.svg        |  339 ++++++
 .../gpu/amdgpu/display/single-display-mpo.svg |  266 +++++
 Documentation/gpu/amdgpu/driver-misc.rst      |   17 +
 13 files changed, 3802 insertions(+)
 create mode 100644 Documentation/gpu/amdgpu/apu-asic-info-table.csv
 create mode 100644 Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
 create mode 100644 Documentation/gpu/amdgpu/display/mpo-cursor.svg
 create mode 100644 Documentation/gpu/amdgpu/display/mpo-overview.rst
 create mode 100644 Documentation/gpu/amdgpu/display/multi-display-hdcp-mpo-less-pipe-ex.svg
 create mode 100644 Documentation/gpu/amdgpu/display/multi-display-hdcp-mpo.svg
 create mode 100644 Documentation/gpu/amdgpu/display/pipeline_4k_no_split.svg
 create mode 100644 Documentation/gpu/amdgpu/display/pipeline_4k_split.svg
 create mode 100644 Documentation/gpu/amdgpu/display/single-display-mpo-multi-video.svg
 create mode 100644 Documentation/gpu/amdgpu/display/single-display-mpo.svg

-- 
2.35.1

