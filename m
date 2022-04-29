Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A25BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:35:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EB0810EFA5;
	Fri, 29 Apr 2022 17:35:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B24810EFA5
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:35:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ax9pu8epGa6OEFIQ2rSA4BD9/3zTDzV0a59ehJzFC1Cz9+MyTtm7lLzKWNQoSwl/3qNfKCK43By/rtEu8s/BXg06uTiP2+rXLOvhb0G/hD8WBPgJRVOy8XLny8RplVa3l0mwVaMM29z9RUfXdZjuRyCTcu4apOMePlR25/FId6etCH4TRBofTo/sRZUZyxsCWlTtWU1gNTPs5S3RrbTgQjUt19JBo0/xMrsNR8eQvyRoGihaQu0itQaRfoZMoLW/VQKNyNfFKtKxibyhN/zwE34gWaH0WNLloKnHChtr/Rs1LC5pv0qSRt2A9hgLemuktf59IerijhAYRqq6/PpSNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZffK/wd+aj33+vmeHfzcHrT7FrhMFg6FSy16JKXd00U=;
 b=IpiNcL1GZP8fSw0MwJQJLwoQegpnolJmYZwka8KadJS18mvbi/SPTZLUtkH31uqySTrA4HLT/vjkIrEHGVuzdSpq1L2N085kUsbjep2nR1cqsYOe71FOZo9clIor3Z95PjEQTBslv/qR6kcAWgjMRVcLqmpe7CgoNMfhtGsWkEQcXiZy85j7BirWey8b840KprXrsUew6pDENtBxtfsSD2cjh8lG3LJHOOkUCs1vDxIEiQ2/jUho2Q4SM3ZDKeZQb9X4pUVxwFfgv7MiIfutFNeeg7VfEKsBp6NvGq1/9DK6/3/kQXI9Q3iAGvK3LC9Kn8E0GD6xiflbCnoIiUPjVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZffK/wd+aj33+vmeHfzcHrT7FrhMFg6FSy16JKXd00U=;
 b=bjUYFkD+IFiYrYZ2jPZenNQ8iOdZ0c9p3mZK6PEyaSLCGsYvFu2TDcIAWKbGZasoaUmCKqMupTSrwrt2vYvW1pqgm3U1wihJxpry6lfL6zspDOIM6r0ENbE7uLxkC+Fl63/0JSeXhH9Kk/WYbCA3BuGJSo81PC6GGEE0Zm4Ug50=
Received: from MW4PR03CA0116.namprd03.prod.outlook.com (2603:10b6:303:b7::31)
 by MN2PR12MB2958.namprd12.prod.outlook.com (2603:10b6:208:aa::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 17:35:17 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::d1) by MW4PR03CA0116.outlook.office365.com
 (2603:10b6:303:b7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Fri, 29 Apr 2022 17:35:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:35:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:35:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] add some gfx11 headers
Date: Fri, 29 Apr 2022 13:34:30 -0400
Message-ID: <20220429173432.433220-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd5c5438-20d1-44b9-e1d3-08da2a06a07a
X-MS-TrafficTypeDiagnostic: MN2PR12MB2958:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2958392185C445E42E2A58A5F7FC9@MN2PR12MB2958.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0M4/tYyf9GbpO/5SuKfuEPwFXUgDmtz4v885ZdrrtsOQMsW150roonTlwZPgzvPEKCzgofonUtMBYiGXGyhaSSyw5m0ewvj+JRW+nEFj/WbdnLtl8Gc+SoptIsOd2xt5SP+LygKhIuINWrEiMYf/lknGHQBvjTxz3bCM5RnlA0eamdE0pTemuDOwGSb3vhz51TkEaQ+EaeuYpr95xCABdRKmTG246SV2t5M4QEdaPYgH5snkiSH6Ti3PkqqLHyhdFzR8eLH6pq0LLuVF6Ua9dgkmbqaX8/UDwMQ3fDB4c8+0kBs/fEOVAIoURhU42JA/9Tu2pWhBs3PE+VqLWdZG3D9IyjXO47kMr68PWknGdnQMyRLUPsdbdDy+Wq821D2Eir186DOYOwiqBdojxgNpYhaKd1joSec//V14TznMtY8bVCP+1Hfz7owdn1cZP3xWHXbdxVVgWrEfjV/plwe4qadjWrBD6uTiBZUbD/VJFEnR2MdANuYaZBjI7/dsfrbI6XJ/LgER9rLp2gvYS287sot596WhAx0T7T3fFVLBphUwGmGDbfuMkrKPoEILyIY9lRNtb4/Pk0VFdhBMPNX0F8fhKIyGOakw2Udv+DoZHDueKPj2SougNVZEQsUD7yg+MlHBxY5Omu5DhMSbsMr1d2TZcCc25s5za0Mlep8GafkA+i5SlfJqVRmdAw4PiP95HmtfDvWcwqtdp+I6nzQrng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2616005)(1076003)(426003)(16526019)(336012)(186003)(6916009)(40460700003)(47076005)(508600001)(26005)(36756003)(316002)(5660300002)(8936002)(82310400005)(4744005)(8676002)(7696005)(6666004)(70206006)(70586007)(4326008)(86362001)(81166007)(356005)(2906002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:35:17.5049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5c5438-20d1-44b9-e1d3-08da2a06a07a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2958
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

New headers for enums and gfx structures for gfx11.  First patch was
too large for the mailing list.

Hawking Zhang (3):
  drm/amdgpu: add soc21 chip enum header v8
  drm/amdgpu: add gfx11 clearstate header
  drm/amdgpu: add gfx11 mqd structures

 drivers/gpu/drm/amd/amdgpu/clearstate_gfx11.h |   988 +
 drivers/gpu/drm/amd/include/soc21_enum.h      | 22477 ++++++++++++++++
 drivers/gpu/drm/amd/include/v11_structs.h     |  1189 +
 3 files changed, 24654 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/clearstate_gfx11.h
 create mode 100644 drivers/gpu/drm/amd/include/soc21_enum.h
 create mode 100644 drivers/gpu/drm/amd/include/v11_structs.h

-- 
2.35.1

