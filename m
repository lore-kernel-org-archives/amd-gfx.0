Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F19EB64DD
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 05:18:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEFA310E64A;
	Fri, 11 Aug 2023 05:18:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C794510E64A
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 05:18:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADNm+pYuLZm3gfp1i0ZtF/scjbLOXnXMPR+JsR4Tu1B1YXXH1CMXvG6WO75PLOfgABZ9Crv0BhYGRAzOYunk+wtHV6q1YbJfn9qvK5HyyrPO6dPPafH64LM30bhK/qyxOS571zdVEJvNazTcQrHsl36pGAg4ApHR3q3H+RT4WwxuCxq1H5+ULIGtiYJko7zEF4gicwTmZOIlbVn+cGQCm1yUyj5Kqp5bROOvt6dPgYUQ5o1Tt3kKu6Xao6l9hz56Lj6IwhNjZ8f8PUAym2qbpMCnml/uOQX+4+ANcOvgobbV6eMVhfjsJpomp2wM3hS6Ns+l+UfydohkyplzFTQdwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTL+Ezd/Z/fQrOMuvx7TaQjbg0qAZRbq7f5iS9D9oMY=;
 b=achPs2x3iHEf4YD83Vys17qks5Q5Pn3awo2CHxmoO320P8UBII5fXLnIJuik82qjwExiZlEKKQ0cr5RjRXFcUBKIcS0xVEVXOauKHxhwy3ppHs2zEhdwm3wFOTuLMigZpq6XQkyAk3CZZ1wwVTTL+VnmE3gNuTV+IgdNmolFRPcZ4czN3tPq4Nf7TNdf9wfdZ8ZrG3O9MW3KmYoc6Tq+/ubr5+MaWIrKnQf/zBTEqaSulrc+m/ORvcTK9ntc9XvZIaTee+NsqPm2AMbJGWCycq0cs+IRjtPnxvU6W66OJQJR/GGlC2DXzhb3wcYVjMRUMDPjds8kZwQdZGg1DFvEkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTL+Ezd/Z/fQrOMuvx7TaQjbg0qAZRbq7f5iS9D9oMY=;
 b=LoKdOCBCEoldvQaRMqqEXL65KqrK97cPvjSqgcnaTYM/q3pcZOhns+LqH1nYeL/awpyD+jA9EbqlNlLEjIQ6XkjeqgOUmmXeeD6XWOvelMZD2tBvSrL6pjS4HvXiVpc+5h7YPBnXaLuu6ePbrMBigt7b/qlY2yqz9UHatFdku8M=
Received: from SJ0PR03CA0223.namprd03.prod.outlook.com (2603:10b6:a03:39f::18)
 by LV3PR12MB9186.namprd12.prod.outlook.com (2603:10b6:408:197::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 05:18:15 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::1c) by SJ0PR03CA0223.outlook.office365.com
 (2603:10b6:a03:39f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 05:18:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 11 Aug 2023 05:18:14 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 00:18:11 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/4] Add mode-1 reset support for SMU v13.0.6
Date: Fri, 11 Aug 2023 10:47:52 +0530
Message-ID: <20230811051756.653422-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|LV3PR12MB9186:EE_
X-MS-Office365-Filtering-Correlation-Id: 743767f3-0415-4633-947d-08db9a2a5d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /a+s2ZtgiNHTsD85Ikrt/XGubsLrRDqnZRtZVgf5paT4pvZWb3FC7ffDTZzj2kbLQ0/bK0BcDMxSZR2XkLpBlOfaMiIoheFoTrW6b8NMUq04ikNiGVyKP+0c35BCIQq0EXJjfOoDPmRHsZfB1QBHS7L9dwAnyAz/msk+8DsB80GHXtYfXH68xV69iAgmelAu7DHhc13XXOZEQLpww2YLMY3Mfuyll6TyQ4qC6d5i5rtaBq8+OwMvvONevbqrhrQ6MZEmm3TPrA0cbzp+nutGRDpLqeUwEJpDjoy9Mwdv+fMb1x/hj0CMMzFS8FCd5O12u85lSNCG5pY5S0uJSs/l6yR3HHo+CfiN5Mt8cLWeSn4fL1uI1DzO/BXfYD4L+h7WzA4OitEZw851prLVlkrM7+30iAoiorUQ7c0nfzRw2JdbN2oBIjySsAyk8ex08bkt/r4EygMq3L8bLsqH5laveq4QBDL1Se6eMfIDUj2Fanrm5QQWu25nsAAR7BqV6C3GV6IJCICTS/itRecJRcSSiH88IaHGbegBGl9NpuNf6Vzvr6kVNO9rYXDvkeiDXjN3d+oPkUcTSsKCAHtFqxTmHoZ1kXkpcA32ydyb4O+XnQ1c5cpXaaK3CUu2ZfJ5fBH6pG91qjzAZHE8Z3X/diY0ErRFqnQ080QWntsPedXgjyX7L6JEpuVavxuOjkBL03TPJ+LMHdXUco8TBIJc1h+WKgOAodKAOerTyQscioinUUEm2IaXZ12LLnkRyEWNFw4cxrT8X8P5AAs0Pz1d3BkQBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(1800799006)(451199021)(186006)(82310400008)(40470700004)(46966006)(36840700001)(82740400003)(2906002)(5660300002)(47076005)(41300700001)(40460700003)(316002)(4744005)(6666004)(44832011)(36756003)(83380400001)(40480700001)(426003)(8936002)(2616005)(8676002)(7696005)(356005)(1076003)(81166007)(36860700001)(54906003)(26005)(16526019)(70586007)(4326008)(6916009)(70206006)(86362001)(478600001)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 05:18:14.1445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 743767f3-0415-4633-947d-08db9a2a5d05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9186
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Asad.Kamal@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The series adds mode-1 reset support to SMU v13.0.6 SOCs. For now, it's used as
the default reset method on dGPUs with SMU v13.0.6.  Presently, reset takes
longer than expected. Hence a method is added to check the bootloader status
after reset. It checks if bootloader has set mailbox ready bit which is an
indication that boot loader has completed initialization.

Lijo Lazar (4):
  drm/amdgpu: Unset baco dummy mode on nbio v7.9
  drm/amdgpu: Add bootloader status check
  drm/amdgpu: Add bootloader wait for PSP v13
  drm/amdgpu: Add SMU v13.0.6 default reset methods

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 17 +++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 11 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |  3 ++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c        | 18 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c        | 28 +++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  4 ++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  3 +-
 7 files changed, 76 insertions(+), 8 deletions(-)

-- 
2.25.1

