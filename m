Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A22C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 05:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94CD710E37C;
	Tue, 22 Nov 2022 05:52:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40B8C10E379
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 05:52:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRtulczq0iYrMuvP9fet3klPwGwIWmpkFmq8LGAPTowlnA3M+TIpeOPLLAzS4TRogZaKUyuxIvlzWNat42EHZlJ0IrleZKZVNg0gn2eeljLvayT8gc4Zj4dLOSXl6KJQzl/93MgYay0HfBHBPcNJI8a0oqBtXirre6V9OgzxWgVykmKam2g/5Gd7Z3SeTe6M+E78ioEiZJvlXwSYSqkaTxsrKf07iBlSMKBNWf0sFvbn4cVx4AOZ07H+8doWmaEiQYw+QmowzKXUGGZlTqIbVeFO6mHKn3L8/ohVHbfTq+SM+rpST/YN+nC0Ootc3Bmll3yvYQ6avYUa20UWNOBPRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6+OZWUhxNjwkTNkF+IPsjy5OEv0UXwQJYeYt1P3rto=;
 b=c9gEMbSoYyLxyJPmVWC+gAT34OlGS1kDk9VAmOAyS7O9l1XTTwGOze64fS76fUpUwvY0bT8rqJBEWlr8wVQybgn0Wu0ZS7iTKyrQz4RCH789CdC9VS4UqeBwW29QlqSX9z8SagGH489ed+dkGH3KvJ6w3d6Y7+x2Q9HdowXQ5kJdO/zPHcsO2G84AVKCtTkzyqX0ifJU2CNyIRVWqal3ONKdn6CJiHnsHZzgVDFgLv24l6N7VshA4gzVBZMMH8QrwoPLfeX8WyYNbQN5mxoZftSBVeaziUh9YoDeCOP2Ey1tm32k0G7H91APBhGSWQJmS0S5nAHZ56A1o/f4td6nBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6+OZWUhxNjwkTNkF+IPsjy5OEv0UXwQJYeYt1P3rto=;
 b=H5kAaPB1kB9x4mtx3ZQHE9yQBU6M+TmBrUh5A7HZi3K8SOA0GT/zzUsPU3jYtNw3zIoSxwH6Dh1cARDV7t0MHvYY7cj8uD64NTlsJ7sfIqD5D8Kz6nNfP93V3raEUV7LCRe8IKoAy1Vg8RjK2F43+SDxAzkQrwLBkpE+XkEjY6Q=
Received: from DM6PR02CA0091.namprd02.prod.outlook.com (2603:10b6:5:1f4::32)
 by DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 05:52:37 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::4e) by DM6PR02CA0091.outlook.office365.com
 (2603:10b6:5:1f4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Tue, 22 Nov 2022 05:52:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Tue, 22 Nov 2022 05:52:37 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 23:52:06 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/19] drm/amdgpu/discovery: set the APU flag for GC 11.0.4
Date: Tue, 22 Nov 2022 13:50:13 +0800
Message-ID: <20221122055025.2104075-7-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221122055025.2104075-1-yifan1.zhang@amd.com>
References: <20221122055025.2104075-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT039:EE_|DS0PR12MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: b6aa1ced-9b97-4db5-9440-08dacc4dc2b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X47OphXTK1Y7TfUOeE1VYpipYcFZ5gh7BXtLPQR9+5mGOq3/is3VdXPGFew/TiOV+K966VOP93qI4toT2eCQ5DZOGKK3hkXKI3H7Vf0VFWCltnXMMCITC3/AyCS5HsvrFomh5J+Rw29mJDLMkTyPVBuYEmQY+L8axvzL6glHp0mZzBF3elvYT5v23tFH6v8QnKA2Z0DjGAenPjRzPpKEUvE8XHI1esAwd8EwMXscH/3vGJVUpDKyN8sdqgLb/nH69iCeM6WwVkPm0fPiFVkbrOCkV+CY6XlrJi6fLLdkJF5wTTtyvkZH15d+TYv8g0KGPw5RGiZweFaXbnRDcVvCsoUyZ0EfGDPgx4hXLAzRf8izOwm8huLOkMKR6xJbV4Dh/RFDGrt/JCgxXsIH+KpVrFY+imDShDt9QZoqJJBpfDLSQl0e27uKtx0an/tRBxv4OgWGVNGbfpAtmIrqeecOan1kKHWN70a2MPj06OVUBx4A+FNcHDPj8qPF6ZI+cznSgr+vhqRlVoYkSnf+MNzcVUO0PNYjTMtgG5AEw4NNDjTmrI8zDG42b6nI4UEZ36PCQem44JXYi3KTKLQ0/sKUMYTczkxsDrupGTxgAjlDq3ePgXK1kvojWRobo2z7hhAOyPUjZ3u35qiIrP/6OXMOLJCTArJH3Meaf0EYVmGXK/9EW18YpoSp6g3/ExMWFvPEu3nRYu6qRXLuhTF4/3uv3biAYqvxrSdScATWCpDrXw8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199015)(36840700001)(46966006)(40470700004)(2906002)(4744005)(8936002)(41300700001)(316002)(6916009)(5660300002)(82310400005)(40460700003)(36860700001)(54906003)(478600001)(8676002)(70206006)(4326008)(70586007)(36756003)(86362001)(186003)(1076003)(47076005)(26005)(7696005)(336012)(6666004)(2616005)(426003)(83380400001)(356005)(16526019)(82740400003)(81166007)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 05:52:37.6858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6aa1ced-9b97-4db5-9440-08dacc4dc2b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6608
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Xiaojian.Du@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set the APU flag appropriately for GC 11.0.4.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 524e2aa849c0..19dbd75a6176 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2220,6 +2220,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 7):
 	case IP_VERSION(11, 0, 1):
+	case IP_VERSION(11, 0, 4):
 		adev->flags |= AMD_IS_APU;
 		break;
 	default:
-- 
2.37.3

