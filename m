Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DC5C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 20:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F11EF10F78A;
	Mon, 13 Jun 2022 20:01:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDC6310F78A
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 20:01:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAmUNTAgaXSK0Jyr7fZxFvvrjDwoyPdliEeoa6r2I+hTPDndwhV/bnm9wZlzvz9kZnPMhVGLALjLb0w93/mt6/l1fse3P6TtVf6g7c0jSHnhTsQe77hqVbOitULH3qPh67XxfRDt57ZYG5+waSE3HV/5MAI+/cHZUEnJ8QVYzVm4zXmRYXFKaB5GgxhXpOq6iw1Wki8O43n68y6qaOgkUCjmDm8VvFEVcnmrIzaqHLXqhhy8hmHjmAo2oC1x7ZjPPSpTCteQj0/kmXuN0z1+9/PfFYyB70FoKFIPoe8+29TmKo+zP/8yIn29sL92M+0midOQrvTKD9bSBkITEsSgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lracQKSHn5o/FCkcLdeZfdvuunvkBnVmJBsXtXPidF0=;
 b=fSRulCqiRbRv2+b1Cs6q7ueC+mYCC0bJOa/+BqBQtC8EDrFbwhIqPXqZxfRDKxFefMrUpdVUapnZHVaPF/G4UFXssOL741p8XQZqlIdyLvYxh7G5pxks5bbaCd2BCw132d+m4pK4wpgx7M++7BGUSsV20I7DO+x/vQhfzdMkUlPd/iklhLEaSMFGoZRSMofgYsmFWxUFsetqnnEjrth2f2I51uHM/XsYcIjRf/wQDIhW7QY/P2/aAkN+aqzj8nCUqECl4sp6OR/SaARS+82EpntxkYXYRn+nxX7ia7XIwOVBkRQmd5yPK3NQsnzSpRAMPbGTpb0NKiMXT82208QLyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lracQKSHn5o/FCkcLdeZfdvuunvkBnVmJBsXtXPidF0=;
 b=Ftk1yCNC31T/Pngpg5l0q+Y57oVHKxBph0CEr+IKVyZsT9BseH1thZhTBe30+zYaTlHrhKTBRqVjQR4txd61egMw7TfQM6jMSKL1ku3J/owzswgX2qqxjt8jhmZpZRNr8jaBXDK+3WGHe6fZLrB7scVdxI1K8OW8sT+GZ2V5GKk=
Received: from DM6PR07CA0074.namprd07.prod.outlook.com (2603:10b6:5:337::7) by
 MN2PR12MB3583.namprd12.prod.outlook.com (2603:10b6:208:c5::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.16; Mon, 13 Jun 2022 20:01:51 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::b) by DM6PR07CA0074.outlook.office365.com
 (2603:10b6:5:337::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Mon, 13 Jun 2022 20:01:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 20:01:51 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 13 Jun
 2022 15:01:50 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] Expand amdgpu documentation
Date: Mon, 13 Jun 2022 16:01:09 -0400
Message-ID: <20220613200112.3377638-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebbe2991-5ed3-443c-71d3-08da4d778ec1
X-MS-TrafficTypeDiagnostic: MN2PR12MB3583:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3583B4AA30772529CD78E22998AB9@MN2PR12MB3583.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7jTk4Vd0fAmkQ87pQ8AGxJ7sB8W0do60didDxpn/T2fDa9jptUnZyVxaKzTep0y3tyGpTfkGQOulpAvqTrNvoamrtrjcN1nPtyk5XOf4P5jNeoU5Q2z4+D7gC6cNwGEPWgUHjlgcsvHraYWiaVxo7E3xkeEEFmz9MR/6PCglVfiKiGXhjBzmDMlrbhxXL2zPva1lxh+UG8SHzOApVJ+1wo40CplH+WQMy1J/fXpfaJ3QWxy85YtX3dpiJb1uRGWwZ8shYqmaHg6NgXbepPNJz6tikNSSc8vHDPZCtt79LLUEVVvWjxOFJUEbBQUV/lyZ3OU3uEK/NsA6fyYX7Z1HBT3oxIbd0RVZXQLT/6GDi27Mg0HvuQzYIEaMAcZf9SGvTJzKUIG3Sh1F4rlEQKxsDLVFYsWz9WpJfvaCxl0m/fCUSJjQ/B3xo5wMdgFTj0FiHysSjUwvaiCVt/R1sICXCSFj8K1dSMzhfZhElGPKSwsvRFtr/zSBKPSk8TapH1+LEZrnTlXhX6OCPEPz9WXMEWif+7IQrDMdjVaU6JMvxojrDsxtl7rfwmvXUrG2/gqqc4tfKabB2LsMQQENHOu0t3mtW2ZWreQyX9GBnPp9c4s6/oXuMI9O5omxemgyYG5G5FHes4Gc2cHxACDccY9gqqib7Pga/D+S6mBZWdedjYdqFfehRCuDXrFt1k0BTmv2qxxAtpOJXWJZZiVGzzU1+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(8676002)(4326008)(86362001)(82310400005)(36756003)(36860700001)(5660300002)(81166007)(356005)(8936002)(70206006)(6916009)(40460700003)(316002)(2906002)(26005)(186003)(508600001)(70586007)(54906003)(47076005)(336012)(6666004)(7696005)(1076003)(16526019)(426003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 20:01:51.6742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbe2991-5ed3-443c-71d3-08da4d778ec1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3583
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
Cc: mwen@igalia.com, maira.canal@usp.br, isabbasso@riseup.net,
 andrealmeid@riseup.net, tales.aparecida@gmail.com
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

Thanks
Siqueira

Rodrigo Siqueira (3):
  Documentation/gpu: Add info table for ASICs
  Documentation/gpu: Add an explanation about the DCN pipeline
  Documentation/gpu: Add Multiplane Overlay doc

 .../gpu/amdgpu/apu-asic-info-table.csv        |    8 +
 .../gpu/amdgpu/dgpu-asic-info-table.csv       |   24 +
 .../gpu/amdgpu/display/dcn-overview.rst       |   58 +
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
 13 files changed, 3801 insertions(+)
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
2.25.1

