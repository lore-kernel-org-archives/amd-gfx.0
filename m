Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06AFC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 18:24:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D25D10E10A;
	Wed,  9 Nov 2022 18:24:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C05BD10E10A
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 18:24:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7NtyPRAZwscZ6wIGqnSIHFkqDo9iS0vGi1lKBDYJ5Vka04738TUpd0NeDWkmqKYuOpV3Ve+ay9RhKDy1o029NdZJ+5p4vrzA/4zOe60PhXhldRQabOkmSLLecwvOE9p+uacvWsJHc2HtmL0BChwHzBi1+Ce9ns02sdy7oAJ2RrEwYQTdbclJgrfYgTx2+nBjo+HbHZJKmhkzlhxJ1pzacdhN/My4p/NKayFmxKfPrU3Et+k67GoHzl1IO0tLr9y5sQ8mHc9jdPCUWjkuMWctb5EncqkBC2aNnvrbGM6aaTFwIjEl7cN0I9v/UQ4qi5AMvjqDBgk0mQ1Vp8gz5Lc1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4S4ssQreGNK3dOOpwQyC3/UJIyyhuQ3O9mMP0HmWffw=;
 b=jMX1tPC+Qn3IdeC+ZHnhkRtHxlPJr5kfuqcoG+xW8UqeR6EuI1nMCUxQL/SCKhgsDxQgGyNDPmpochr2p1/Apsxc4VbHp8bqJ8zDolL1M+UEuTnhuXRhztYDDmSjPONMObLtuSYp8uMUBnBGLpShed5mQ4O6BOQVbN/2J4UkWUkRTZAOkSXLEWku4Ixj5bmhSzrfUVhHX2Xnrt0WlBVxRxR/z2weDTdQ4t4ON4wBL8lCF1R0NecrWl+xCbY3krOU05NA3NEsamEhhJuutLZqoVueBTUzMJfer97/N5wHvs0f4sOhMt6qOJ7es2aFiyp2hgpbyGtylsRWAqtK0rWRyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4S4ssQreGNK3dOOpwQyC3/UJIyyhuQ3O9mMP0HmWffw=;
 b=OpnNzT8cIQStfhN4WmTyIL8wWDVG3UcRzIARlNHd6jkZ0g1Kp7hMDgr8Z24oKF+Loo3jKntfUQtUbdXrxjmqFoHug2P4WdkHS2Gmo7AEPuHk+bHLuH2/9QdGEOo687v1/MtWa11QiOrmyRwoBKdcfGGZ4CPhPLgUOHwl+L4Chrk=
Received: from MW4PR04CA0094.namprd04.prod.outlook.com (2603:10b6:303:83::9)
 by BL1PR12MB5972.namprd12.prod.outlook.com (2603:10b6:208:39b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 18:24:41 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::fc) by MW4PR04CA0094.outlook.office365.com
 (2603:10b6:303:83::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 18:24:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 18:24:40 +0000
Received: from vm-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 12:24:38 -0600
From: Gavin Wan <Gavin.Wan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Ignore stop rlc on SRIOV environment.
Date: Wed, 9 Nov 2022 13:24:22 -0500
Message-ID: <20221109182422.21924-1-Gavin.Wan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT005:EE_|BL1PR12MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 298acc96-10f3-4adf-3f43-08dac27faaec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A95suEkBh1htub+xoC2polv4zGScB3d36xUfxtSDvrfXsCsxZ6+3gwUx1JqmBOedCrFrEOjuE9DYNjx4KQk49JyMLFXsw9NVc7prpXr0c0WBU/Ubqzk9WByEPe/maPDdvZUhYexxE6d5deKMODlOu5szWboTEskRL60PYJ4Xnx06i3Ued9lKMwPI9gKdcdaU27WqOzGlJdBsVL50CfQXJyzSAmbjVQJxSbTiu2HT5veAh5ShqxvIcE11VC+MxFMijBUL3ArCY1iFNH+P4gkwBvEzSngQ9+vtLxGtUSBYz0f3ZsQD407mBulZmynbCQoqMjb3fWzaX2IPQiu/CXMBN8iHrxPRCl9gofgPo5VmNHPPDIudlwwQVxNDcNLeZQGY3TGcuOHmPqswc8EJlbS7cZ8k2FdQ7NTtKTtOsWaHe4anKIgQyZm+t61PNQk8mNfiO+TQhGr5L9ipUMLm9nJApfZC2V8vFtZGyuS82loCMQKW1mksFzod2dVkV5lhgdHqtp2PMfBV5N3yGKDD6xd9tjAhbZjIfgOL5MlEZaO7fMGmBHVl1KNvHTFIaH0xofYNO7ykVY+voDmwzKrYiFr0zr/V/0XJgFwzK2qoZJM8fMqGPlzZXX710IrdNkBXLylGV3vQMT9pu1uJ0IFJUPZAW42Cs8REU8K2rkqc/coH0E9ip92X8ZdPMJ/IX/+kB7cQkwnf/NcFXaQ62sD0ZgLjRzXtYigzKsW0GNtze+YFNm5fDt7LcW9t0PDYeLkN6rnXkgILO/TAMn26ulFZ6rAIp4l26YYpQVdvsOOiYUhd7L1WX0uQy8nOGBUKIj7fE5ix
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(2906002)(4744005)(8936002)(5660300002)(36756003)(41300700001)(8676002)(356005)(36860700001)(83380400001)(70206006)(316002)(70586007)(478600001)(4326008)(16526019)(40480700001)(6916009)(186003)(1076003)(336012)(2616005)(40460700003)(47076005)(426003)(7696005)(82740400003)(6666004)(86362001)(81166007)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 18:24:40.9184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 298acc96-10f3-4adf-3f43-08dac27faaec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5972
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
Cc: Gavin Wan <Gavin.Wan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For SRIOV, the guest driver should not do stop rlc. The host
handles programing RLC.

On SRIOV, the stop rlc will be hang (RLC related registers are
blocked by policy) when the RLCG interface is not enabled.

Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
Change-Id: Iac31332e2c958aae9506759de1d3a311b5c84942
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 4fe75dd2b329..0e9529b95d35 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1517,7 +1517,7 @@ static int smu_disable_dpms(struct smu_context *smu)
 	}
 
 	if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(9, 4, 2) &&
-	    adev->gfx.rlc.funcs->stop)
+	    !amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->stop)
 		adev->gfx.rlc.funcs->stop(adev);
 
 	return ret;
-- 
2.34.1

