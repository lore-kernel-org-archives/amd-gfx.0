Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB15C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 12:44:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A866C6E222;
	Wed, 24 Nov 2021 12:44:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 011566E372
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 12:44:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkrLg4ZdugbducuFeee62Fco2mlWt6f8uwMmeErqOok4ss3pS6Q8OaIZd/5ptygZM2QWLRmtU0t1Zf+ydKwEz0hGP83HmqQwPOSy5b+M0WtfaxarJUPpqyrNOw5N3wj+Z70k+KOfnDVwyW+AXAf/awOW6fAoZc8CVp/XQJQ06rsG79Eqvp0BmdqIfzz23+8skKObutI6oOlXFdsi/S9l9RFNbWe1a5SMtAt0+B9m6XetJK26wotqEqYqgRO2N6wbDVVuM7DuT5Pp2QZeUsIEgvfp+Z5LIGJpZoo9wkBOBbQGikIm5+s54AgyhdeUogl/pCVVD4F94prn5Q2hQZVXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmRTyEYuNAQ7CXOZpO0uWaphGXM6s8oTBfdIcv94Slc=;
 b=APBSXQvjzkFeuZrZpu/2ek9JGsh9vCgQ0DgCIljgb6GTjhkbosMZ7L1i7r0twHO1BoTgGq+SzoZElKvnXo5swIE3Xo5g4+YYsNqv5/mn758mre2XIuQGWGNhy6BxfH7sr695RcPOmN1Ettbbb+Nj8d4/S3o0/dWIDDIuB2KPyCCCLQlgQUjcurypGvAXGOvFZEKR+RGRdocZTQzs93Sg13ry9WNx8kZC3LWzHp/dNqKSEee/bdBgKlasE5Vv6MtK4xYFp6zl7dG10d/nkVpYzSSk9gO35WqikO04St/Dp7KhaiLNZZXgeUQHiAL6vI6meT/ybC/lIG7PwwNFV8JeWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmRTyEYuNAQ7CXOZpO0uWaphGXM6s8oTBfdIcv94Slc=;
 b=rtRY4Y1cVpvFomdXBjTbZOXdrjf+M/Mt4ayWJmwj49qBZ6Nc30hAn74LllRjf8QSUpHqW2Og+53yM9Iiinx9BejlubpcsGovbjxn6LKq6kRPdf7e2fe5Wq/gW8QMc/yf6JqezwIKKIkqNk+MGlFexQLTaXGmB2H0qkLJV4X1zQQ=
Received: from MW4PR03CA0322.namprd03.prod.outlook.com (2603:10b6:303:dd::27)
 by CH2PR12MB3847.namprd12.prod.outlook.com (2603:10b6:610:2f::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Wed, 24 Nov
 2021 12:44:08 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::60) by MW4PR03CA0322.outlook.office365.com
 (2603:10b6:303:dd::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Wed, 24 Nov 2021 12:44:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Wed, 24 Nov 2021 12:44:08 +0000
Received: from prike.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 24 Nov
 2021 06:44:03 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: reset asic after system-wide suspend aborted
 (v2)
Date: Wed, 24 Nov 2021 20:43:11 +0800
Message-ID: <1637757791-3210-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b70b95f5-f8dd-42c0-8fd1-08d9af481b78
X-MS-TrafficTypeDiagnostic: CH2PR12MB3847:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3847E2C8264CAF11314F4395FB619@CH2PR12MB3847.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LRPJbuouiDKVVpRqImItTe5hbhZq1eA32FzFZ+XVGkCmW6VkmqOv7eVNqzrnG/fyHpImJ9OdRjBy/NEGrRM35CR5uiTtlHfPjNJgImxuyunki4e0kKi3peqMwAx43e0Ho+S9HSveRMUYvn+oISR6x7ZUl23t1RN2zgw9r1RjOWIZS24yvn2LLiW83fnOH50qHQWDdiNo64OEOueMX8cwMbSTQKoULuSX1yRk1Bh0sksHutpTBaGcigddQUem0fdTnTVU/tBoiBSOOuz8PUPedBoOgYjIgO2IJwl0a7rESdNIYNk12u/JmzVHEvGW5RZOSBP9a/pnL5SnN+MaDUl8Ev5VBpypwA83fs9d7N7Jyc1kcYaJFoVB+REozN8Olh5jglFBrF6FdI1fcpNfPkcj/EVf3RP9GyXuB3xwciNJmjiH+4ig75XHjX2uePVOEdoUcKfgyK6s2k2gGEctOyr/cUfbYX4aRp2aamxTjWkCClNvl9Nrrvt/IYBCpyEcbi9Sy/cDrj9+teL1zzsxqI11KPjiMGfVBepsRM+KhhZ2ZJNuw9tLt3T1hu0D0gt/lNqUvBW0YNOi6u4lrkBTVqlNOCSBA2c3RmEF/zN4MGmeS1G6Q1q0dKc00DFmfkIpJrDA5B88Zxp453tENmA9s0U0L/Q/68ynmF2hZvdBNt8R3S9XXYIMq9YwpS0+V4p193naxxnwGNTe5ALvZTD9DuW3lhMgue1kjxxpmLntvqRfaqg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6666004)(508600001)(70206006)(8936002)(16526019)(316002)(26005)(15650500001)(8676002)(82310400004)(36756003)(6916009)(336012)(81166007)(86362001)(5660300002)(4326008)(2906002)(7696005)(356005)(2616005)(54906003)(36860700001)(70586007)(186003)(47076005)(83380400001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 12:44:08.1438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b70b95f5-f8dd-42c0-8fd1-08d9af481b78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3847
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

Do ASIC reset at the moment Sx suspend aborted behind of amdgpu suspend
to keep AMDGPU in a clean reset state and that can avoid re-initialize
device improperly error. Currently,we just always do asic reset in the
amdgpu resume until sort out the PM abort case.

v2: Remove incomplete PM abort flag and add GPU hive case check for
GPU reset.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7d4115d..3fcd90d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3983,6 +3983,14 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	if (adev->in_s0ix)
 		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D0Entry);
 
+	/*TODO: In order to not let all-always asic reset affect resume latency
+	 * need sort out the case which really need asic reset in the resume process.
+	 * As to the known issue on the system suspend abort behind the AMDGPU suspend,
+	 * may can sort this case by checking struct suspend_stats which need exported
+	 * firstly.
+	 */
+	if (adev->gmc.xgmi.num_physical_nodes <= 1)
+		amdgpu_asic_reset(adev);
 	/* post card */
 	if (amdgpu_device_need_post(adev)) {
 		r = amdgpu_device_asic_init(adev);
-- 
2.7.4

