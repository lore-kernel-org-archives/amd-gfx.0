Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DC6C25B08
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Aug 2022 06:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEB6F10F3C0;
	Wed, 17 Aug 2022 06:20:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91B9310F3A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Aug 2022 06:20:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NC1EWqzk8Gfczx/N+Ep9rfj8GP7wAhSbZOGPlH7/neQfY3uCHzm5YqHrzScg0NQNHqr0WSvGKxUOFlLQ855nYV8GcFh2gmj5jntuXv28M2AFu2hBqAJgLuafiH9CJ2ry2Bf+PXm2ltvazY/LuK0JtrBEikd65T6mSy/yTtmDxWmZ9NYY4RrmX9ET7tghVuuJEnUOEnfZctyfKT0RFgc5WRgKZY/3hZdGLn5LRV82KzV6IF9spuZ9qtluadn6imL/cpdmvnwehqWTpM5rJ2xLKTXPiYk+eKcLy1XX1KDZS6Im3ZTGPtc9MWOWBp0EcOhwLZcyEnpmCoycjPPMh+ws/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXSPxuiXtkLks9DJmZ1oxcrLKRlPawcJHCt2jev96cY=;
 b=LL5BpNRSQf/fNcxtqSzy+Gn5Png2tRbfBJuwdaJAlC/adGpMNT7FkrJ6BTm6DsT7WnJlzMgmR2vsiZVmpf/Zdh6XSYMyWoQrL36BLpJPYWQ7UplFu7CYLJN46+n7g/l2hiwszm/eqXfRfHfYzWuLzIncTWD7xYxgleEP8GCc5rqQlLmkF6ANk39B17+9XvDajCE8yFqnuFJSeCf4/CBYqgPi/vi4iCpR76mRgr9VnQOYkRDeMBbrNnD7IHeusos+Hjqxp96v99RX3XjAOmRsu5+cuxuqJbZzc9XE+0rTEwgw7d40iKRg6NVwQYQcDag1kUO9TaFzoDC+VzE1Vx5vcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXSPxuiXtkLks9DJmZ1oxcrLKRlPawcJHCt2jev96cY=;
 b=5fzcTVRhS9XrLuCvitQFhyF089hRNddI6XD+YP2EAm2QTLC/DsRn6nBGdQbZzmPOHVLbdUe78SeQkxfYWyRstU/0XQZp1djqD/vqMXAzXObq1exwAw0H6SmP+ZZuea83MXgoEsWVLnoV4xwn78L/5a+8N6HlvDGmVAeF0ArEIe8=
Received: from DS7PR05CA0014.namprd05.prod.outlook.com (2603:10b6:5:3b9::19)
 by MWHPR12MB1840.namprd12.prod.outlook.com (2603:10b6:300:114::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Wed, 17 Aug
 2022 06:20:11 +0000
Received: from DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::32) by DS7PR05CA0014.outlook.office365.com
 (2603:10b6:5:3b9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.14 via Frontend
 Transport; Wed, 17 Aug 2022 06:20:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT110.mail.protection.outlook.com (10.13.173.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Wed, 17 Aug 2022 06:20:10 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 17 Aug
 2022 01:19:48 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 2/2] drm/amdgpu: fix hive reference leak when adding xgmi
 device
Date: Wed, 17 Aug 2022 14:18:54 +0800
Message-ID: <20220817061854.706010-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220817061854.706010-1-YiPeng.Chai@amd.com>
References: <20220817061854.706010-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e75b55c1-6cf2-4e7b-4f89-08da801889ef
X-MS-TrafficTypeDiagnostic: MWHPR12MB1840:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zCWGtPjM4vnOf2JWnUpK4IUKViW3nQHwrsrq30LY8Ui9yh3fZz/fmaGM9cHnIzyx1zEwRNzHf0md3/k5Qx55FIru370ZSFg4FHZwF3sfqvgyzLFE+ZwhSa4evMfyCBVxma738fuXCwImxzS4TBAuyUcWpFX0RL5bWqPiNELoPz7fkvDln6Z0nCfm5Z85lyafdmo8+p79dmDg2KxVjoglM4OZdeDxrhE40mfVMEY3yAZtkqFO3GiugUTs6c/LdUNr72df97qToJgkTyo1xTYjkL/OuRNIey5wmVmVPztL6Qcxq+D1mzwYpebr1eDD/TVcgbk69rE60EFSAOHcuc2EESZEJp/QskE3+sMH8JqQWaMQx4Z+beTj/A038VDmWA+AV/GjASibvNUQD6cQdSgONaMRHOXkjgPI28LovL8CPcJ2iSIPep7YGYtLG1oBo9V4knJ1+IwN5ckP/JEiu3EVN4Uhdt1aP2Weh1rKd2JD6RrQDXA8myEwM8ldMx0HYDiQLdLMytMrSPJeRB2zxtEACB1qST568wHH4w25OcDbmMwZEslnnxHLNVWPJNSfhbfNU8F5AlqxO+n4i1dR7kEf8w1+lRZ9yhFDtoBIKoU4vnTS8y8VU1qDfknGEBzrhh60Grp6s1Oze9sp+TXfhSQQBpGVbC6ffO92348C2C8Hot2KKMd8EDEFHg6hv4mQDsU5KGuRD4OQPQIuXlL9v+I5Z0FYHWlM7+bNAHS5lrc1c3jb5QV6ECGbHNOFH8hvATrNMcie+pthJMd1k0CZRXqCb1vbG351BXcscrRHoGYhmpUe1hdvQAC1ozirVbswXKblmAaqEFqCGynM6Bp2oReOhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(376002)(36840700001)(40470700004)(46966006)(36756003)(478600001)(316002)(8676002)(4326008)(40480700001)(2616005)(336012)(82310400005)(70206006)(186003)(26005)(7696005)(16526019)(1076003)(41300700001)(6666004)(70586007)(54906003)(6916009)(36860700001)(40460700003)(8936002)(356005)(4744005)(47076005)(426003)(5660300002)(2906002)(81166007)(86362001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 06:20:10.6829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e75b55c1-6cf2-4e7b-4f89-08da801889ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1840
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
Cc: Tao.Zhou1@amd.com, YiPeng Chai <YiPeng.Chai@amd.com>, yipechai@amd.com,
 Candice.Li@amd.com, John.Clements@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Only amdgpu_get_xgmi_hive but no amdgpu_put_xgmi_hive
which will leak the hive reference.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c84fdef0ac45..cf55b9354831 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2456,12 +2456,14 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 			if (!hive->reset_domain ||
 			    !amdgpu_reset_get_reset_domain(hive->reset_domain)) {
 				r = -ENOENT;
+				amdgpu_put_xgmi_hive(hive);
 				goto init_failed;
 			}
 
 			/* Drop the early temporary reset domain we created for device */
 			amdgpu_reset_put_reset_domain(adev->reset_domain);
 			adev->reset_domain = hive->reset_domain;
+			amdgpu_put_xgmi_hive(hive);
 		}
 	}
 
-- 
2.25.1

