Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF35C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Nov 2022 19:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9E1D10E4EF;
	Wed, 16 Nov 2022 19:49:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2799110E1B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 19:49:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1y7BP3ionE02znRKBtEdA8TPaDZ1F5fGbtu24Fwcmn14m9Vzr6XR63jSTPAIVAozmQ4T//BRHdGGYDToqMBKbvVjpv6kcYEpfnL59XVwsTu1OEuzpYBJMjo0y5XfTSF9bzL1yzr2MYqrP0k3FQkl8U/CY+g+cWsy7zRrhKgrOj+x8KCOvDT8yZTpACL/kjpIJiFjt5XkD4ut0sl5TF0Pj7Y9q2BEd6bIMskO3jWusxZ8Tz/gX0C+C0rAKJN8wLrqDr0OxO3IYTkvBYsFW9b8PFXpeeuN+YUZ3iIvaTegRLkg2eQMeJYm1WCSgC59ZxU+yFAOOe2sPU6ZA/t8NZqEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5S0l4PfgkDCCGjfa2J88StNwMwHnq95tC2/X73zMRBw=;
 b=Vx7z9MYLhNRuWMSvgvb0H6Hr/A3Xxx7t9d45DhSKRSQL8k+c+vYObBWpmqjgA1Qhw1f4s1XilxgplIXpWxTMHsn0BLCX1xBWGpwuJiAP/BgWrbg3mjqurxV6lrmp9Qt+OuhVexaxpwowcpLn7oCEla940MKF8OU5HOzl+DQq+pLe0yL+gjV3tfvsAnnnhN0iKLiJculzrVLPfvE8UER4B44ICDhw68Tu+n6YTWFP3xxOj7mlbJb9E7trQbPvya2nHM68122yIoVd+M4IjWunjgkIe72ytNreuwpTMWaj4RaLaemvudOH2trT8PtAa5mOax1ElsGh79TUYX7xYHBXLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5S0l4PfgkDCCGjfa2J88StNwMwHnq95tC2/X73zMRBw=;
 b=Gy92E11vsiD4LrC3Y0twXKoIMoYLhZkAS/dtNqMMqUGB0f0N1Gn4UDl0lT2ukV4EaSIHYKb8RJeViNtPaLZkUnSaIEHRWwcEn9adxV2GH9OGORo80/cW8ud4cUG/4iL0JW2E1Q1OEqdioIhQ/YSo9R6U3eojRVuPbxahIUgmAz8=
Received: from BN1PR13CA0021.namprd13.prod.outlook.com (2603:10b6:408:e2::26)
 by SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Wed, 16 Nov
 2022 19:49:06 +0000
Received: from BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::1a) by BN1PR13CA0021.outlook.office365.com
 (2603:10b6:408:e2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Wed, 16 Nov 2022 19:49:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT095.mail.protection.outlook.com (10.13.176.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Wed, 16 Nov 2022 19:49:06 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 16 Nov
 2022 13:49:05 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/4] Fix reading IPMI data on new Aldebaran boards
Date: Wed, 16 Nov 2022 14:48:34 -0500
Message-ID: <20221116194838.15315-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-check-string-leak: v1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT095:EE_|SJ0PR12MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff5c9b2-6032-4279-6d2b-08dac80b9f01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 529iTraFj2tWLYe9fkhOh8tu2HvG6cyuFwZNGeU5OH4noGZw5vH2YFg/Z4UQY0tbur2078R3JwljSVSv0eY7IBMj7tYxFMz8ZFZe5cR1jUlOyE3+0KKoV1awhhwfVjIiEpsNQqmL2wA2MzlXyWfCtOImzdeV1ndqpfSK1VHshiXQCA7Qx6KMrPzjK89unsC6hz47snXM2xsAtm8KJ5I+qHjaxyyB4WceDTWB8TZfbHpt6+ODqMPB+sG6igokpg22BIIDYR/RKINmfeaA2eOwaSq9w5gvIyHhDWBdavPfU+ZJztpjE9Smj1D+64h/jPo4/YU9Qc9xOR2bqT34yKHvOheUqc6aUaT6786esANOmh0w9SPtOlUoqpBmjXRyOhB/JxK5suThUt0ix3W1FUz1QWl/LSYJonJK13G4LG1wZ524XW9wQS+JMcrZbcUy51svoWAoaD+axSXil/KZzfiWTJ7io2npm/KI+5hhhosaeSdYEu4ypDJRpVlWOjDNAmloU2JvqnuJ/wPTP2WNMFTigPiWbApFTpGLLJrKGiFHK96b1IZ2Dr3rZ9LX8cPfZJc/0Te3hl/DSV5wL1bZSAUktXSgR8vxtXyEfF+O19BQUlIvPhBatnfwREhdk/h+eXrOw780Y9Eokcej/KQPK0DDOQxWP3Gj6WTEBYWYMtIAT1q7zLOOUKFEtE2jEDDladpkp38G0gpW2tYdDGkXnNwsgus6tdtR/pBCoKnvhYrTwSmn/rdcSuYNUtnBtXld4fTaFSiI/67diuo/Pek0XZq8vDdJQo/gNzYKoCn97WcMRMsRoKdmRoXSvDeaQ7GkYzoP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(6916009)(54906003)(36756003)(316002)(26005)(426003)(4326008)(6666004)(2906002)(7696005)(44832011)(47076005)(70586007)(186003)(356005)(82740400003)(81166007)(8936002)(83380400001)(336012)(2616005)(40460700003)(4744005)(1076003)(16526019)(36860700001)(5660300002)(41300700001)(8676002)(82310400005)(478600001)(70206006)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 19:49:06.3744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff5c9b2-6032-4279-6d2b-08dac80b9f01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5676
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Mostly fix reading the product name, product number, and serial number
for newer Aldebaran boards.

Luben Tuikov (4):
  drm/amdgpu: Allow non-standard EEPROM I2C address
  drm/amdgpu: Set new default I2C FRU EEPROM address
  drm/amdgpu: Read IPMI data for product information
  drm/amdgpu: Add support for RAS table at 0x40000

 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c    |   2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 215 +++++++++---------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |   7 +-
 3 files changed, 115 insertions(+), 109 deletions(-)


base-commit: f9cb9d9b7cfde813d3b2d19dc0016645f985b543
-- 
2.38.1

