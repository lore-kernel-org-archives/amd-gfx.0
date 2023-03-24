Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EFFC6FD20
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 21:51:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E16410E53E;
	Fri, 24 Mar 2023 21:51:51 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D464510E53E
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 21:51:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nb99iyAN0/p5DZxY93QKpttFGBHSG/TjHNjIVWfJTj8w64ksPGRmkqCNeBfSlPRU9R+2LH4JMy3RjmobG38xe0mnxx/E7TUS4nM6wuocDqxXZQB1dhmIAwk8ALvA5HG4UCzXtzTu4X5F5uzX8Lmit44ZQAow7FtzQmw3mnuDZQdSUZPaPgc5jh6oRw2oLWUcGgba8WgfjJyzU/Ttsi1KcD6bvZ8CYp4plvzIxYqEx/8JLbEuKjGU5YVprmPMcChwXy8YrI3AV8n7i38Us8WSwQjgVo1jeKOFrhkV/Fiq+haloW2OFTlJO1P4dUxeRTZsSB6rRf6X4CzdBfc3h2y4dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFYZ4zIUOvxL/GGDMdm9JyCw31GUyhsRjRdrBZ5k0jg=;
 b=bujaHGd8GLJ1UZdr/c0O9LyUICneohSGqLtACgwv/PW6W0KBdy4gh6KXvgCWV/M4Uq/GStI+0/rdfUbmrOEATMSROQgGx/nuVC2t2xmjwd75v8nc2Ll/8gKYRBZLJuKz/Ik7CXIhr3ycxiU1NLh/vai4ks/boKI2F5HKvPWpoYEv6pNC3rZhR9f7LWz1Lqg/xQx1r3NY0ik+GNDoWFOQ96u9uksLNFZ6OVVC6KxAbHfh+iC6neQbQ4WFWio5f8Vt9qJviOZu3Mt/M/3S9EF7naKiu9wn8WC51AIgrZNEWrnDC2IqKMFNDTbYrlmYp4by/bGOP8OGrDQ2vjXs1NwrfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFYZ4zIUOvxL/GGDMdm9JyCw31GUyhsRjRdrBZ5k0jg=;
 b=OU5/71yHkxA15dugn1j6O63CKWA9RMVbf1tqlF7pu0SrYqzXjNNDayor6JE98WOyZgGhl4/HG9mduBNJK48eHo22N3SjVFBFthq9LeWQNFwHbgkixApcSiNvnDEFkXcibjM78XuveTNxlIJukw7HAUkYRb5XNZxPJTwwqF51u3o=
Received: from MW4PR03CA0205.namprd03.prod.outlook.com (2603:10b6:303:b8::30)
 by DM4PR12MB5747.namprd12.prod.outlook.com (2603:10b6:8:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Fri, 24 Mar
 2023 21:51:48 +0000
Received: from CO1NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::4d) by MW4PR03CA0205.outlook.office365.com
 (2603:10b6:303:b8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.39 via Frontend
 Transport; Fri, 24 Mar 2023 21:51:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT099.mail.protection.outlook.com (10.13.175.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Fri, 24 Mar 2023 21:51:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 16:51:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] NBIO 7.9 support
Date: Fri, 24 Mar 2023 17:51:11 -0400
Message-ID: <20230324215113.2560000-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT099:EE_|DM4PR12MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: b33a023b-f590-470a-f7d5-08db2cb1f7c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FH8SVJ1wMjPlfhL/X1SW0OQeG4XboxgbFhQGkOgpAdnkFqYonZySdQrrSW7QZL7oR6ANBVxuJS3FqMOp3wOVQ342t3YevFXVpx85vHVTkyHfUK4qMGMLi3Vd6WnpDz+Wv3kY4azOBaJjgKquSU+SktyoiGbEdVGxj+5wE2S97rdew0QOfOT87RORA3eTjxGSpVe5OUrVgXnVSB4gdKG6jJZ4LJnwJefjPHdB/I66mW8wzPdbAh26M7rt+1ebWim1kJtwieCRuMrzuEmcYAvLyP9fZMKYjeQAndfFHITg1jMIxkyrjfCePegnMlxD42b1fF/xb6uDksRiIRC7L8nJtBQePcVClXIj6fKOB/OLwpKPybgpCtaKwK4v+kyCZ4rofOrNt9BbW9Wu34eMofHBhE2A0H4TEfiCtgjorOzBTgfjFvaz3ePrYct1l3CPKkDOxVaHImrY9Z1CjdJxCO/l6o6JTjmPTeKMEwP1WrTDs5sC33WMP5aVHNlPjtb3ucCvW2WmA6kbiaQKhQdhNZFZ3Jq2NRubPfgcO9bOpizaXPUnDnD9JJjm+CyWIMjgxWIv0Dy113AilC09c0v7UpW+jIxdQMyBMep/5FiFMTJJDwfYp/UJV/v70Fklw1I7lXd24cc9fs2+50mf5ThOlZqyzenQwSScZDw4RCEcmquZV9x+vM4LGnwsC+ACExUSf/4ZZXAQMB2ZijiMWh5z+oCOCmqlGm9uKkzb1zzweSQeoNs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(2906002)(356005)(81166007)(86362001)(83380400001)(4744005)(6916009)(7696005)(40460700003)(1076003)(36756003)(6666004)(36860700001)(82740400003)(4326008)(26005)(47076005)(70206006)(40480700001)(82310400005)(5660300002)(8676002)(41300700001)(2616005)(16526019)(8936002)(186003)(426003)(336012)(316002)(478600001)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 21:51:47.8921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b33a023b-f590-470a-f7d5-08db2cb1f7c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5747
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

Add support for NBIO 7.9.  The first patch is
just register headers and is too big for the
mailing list.

Hawking Zhang (3):
  drm/amdgpu: add nbio v7_9_0 ip headers
  drm/amdgpu: add nbio v7_9 support
  drm/amdgpu: init nbio v7_9 callbacks

 drivers/gpu/drm/amd/amdgpu/Makefile           |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |     5 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c        |   369 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.h        |    32 +
 .../include/asic_reg/nbio/nbio_7_9_0_offset.h | 10002 ++++
 .../asic_reg/nbio/nbio_7_9_0_sh_mask.h        | 38900 ++++++++++++++++
 6 files changed, 49310 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_9_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_9_0_sh_mask.h

-- 
2.39.2

