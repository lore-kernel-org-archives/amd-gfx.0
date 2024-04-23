Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009ABC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 05:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A5C71130E8;
	Tue, 23 Apr 2024 05:30:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nSENKxvx";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 209241130E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 05:30:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aB55xHgpV4+EIAREk7oFSPZKoDkxiIVSJbwW+Z4rtFBFCGuiXf2nLoQT9t1jcHQ9L0jaHvtv6LejpeJsFVfpiRuLbAG+GbA1rSxS2hAZ8kR5CC5qjbjya4L7SawCXLrmS+NbAEldAG2EV/QaI8x0H2VeV186JW2ygg1Ti2saUQeKuceyEWQ8any/a9CyCG1Tlp10D7aZ1SRWN82T4G1YFaDjZOEfj349sXontqrR1pcNiLp56Hq4WrvkqB2ZIOAA/pmBg8vpW/QJ9SNxsdT5kqVWp5a1/yDy1Yt8dNvMGeiutXulNt779VCP0jHIURGhWyQObpRc3BVs93980LeQCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnYMbzK4HnHTm/Ag/cdUUKYJMid9nIpK/mEhPBtqsSk=;
 b=m+mkiO2MGIaeRNPcZbe03MW+gW79Pknwe/+onWc9L9ixHkJ4sB/UAXLa0zWbMzr7yU9b8YfyqQZTu3p+18lxA1Ke5iNzZqkDda1GbFiaRuW+ei6tWZDOTRa8QyGj1DES95h0lOkmuwcjujWzFhfGZYhlQ1hsuy6s9sFSM6Nh7gKrhe7I2sBYrjwN3ePl3CmM98Z7k18eXZclvyx6IKUJcaS676cztlpWYDcvDw5q+sWyZGg0SZ5C23zwAzW5FOXYlAL0bTWAHD++yvSxLXVSHn62IDCpxJ4AlMSKtM/45w75XHUqci+oPW8vbPk36avEyaAWNpqXYtcFn95RPQKtIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnYMbzK4HnHTm/Ag/cdUUKYJMid9nIpK/mEhPBtqsSk=;
 b=nSENKxvxc+9XDUrzx58ahBLvKR6FKg/IEwuDDs5/X1U0zc/4oIEV6N4TTWakeGuV3axgsojTiefUPnqMCViswUkN560gMl4BDFn1Ah8LeCftsy+qg0uLghmEENcF8+4OO3s6+3gXuWqqJI1osFhm2b4J1pgD6rNEVhej5KHpz+w=
Received: from SA1P222CA0164.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::29)
 by SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 05:30:50 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:3c3:cafe::41) by SA1P222CA0164.outlook.office365.com
 (2603:10b6:806:3c3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Tue, 23 Apr 2024 05:30:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 05:30:50 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 00:30:49 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 00:30:49 -0500
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 23 Apr 2024 00:30:48 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>
CC: <Hawking.Zhang@amd.com>, Bob Zhou <bob.zhou@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: fix double free err_addr pointer warnings
Date: Tue, 23 Apr 2024 13:30:47 +0800
Message-ID: <20240423053047.883983-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: bob.zhou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e0eba1f-a213-4f1d-4c98-08dc63568988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fjIsa/Blz7b/KH+hh3HV+8SgsF08MLIpZHjA+pwFcW0JJTMJKuEHv9mjfKoB?=
 =?us-ascii?Q?EoM0/DRTtNg9sMLw6PLkYrNg5BC2RIlZA+Rx5U2Xz9a6Z53eJvRx9iyyM5KJ?=
 =?us-ascii?Q?vHCEPsI2SmGoPp6Mn2+v4FU+OmQ91fl7ajWfH4eXN+xP2i+kCAkigkIly+gD?=
 =?us-ascii?Q?dGRek5oXOJggX9jFPdZkvdobQvYisXVu6JkcIJrA4ArL2Em131rnv4irXaRL?=
 =?us-ascii?Q?KtwJ4qML5INQXCFnzV9z1zHSeJ1PdPspnz/helso0VxkiFJ7TUY56U+QOa1Y?=
 =?us-ascii?Q?tPw2wSA7C5B/HGd+ugBEdjnILFvU6fZsIzNDYl6fIsak2eREls7xyhETcHcm?=
 =?us-ascii?Q?uArti7afylLSX9DmGKN7j1GpchDQuiPBW4ipRJ6KTy4evMA0Lg5K1kDzbyUm?=
 =?us-ascii?Q?gqmMBmcCAQXLQ6EeQNWhwJ7moMMfaNbklz6fAnL5hNNkVXiaMZU1WPayOyw+?=
 =?us-ascii?Q?Xn0Iqkdoc2OHJLOQnnN0xuZTdwpRy+GgyioYyrIKssmg/Lj0wbGG5UeKZS3S?=
 =?us-ascii?Q?6jyltagPkO+m7PPXFrsTjeUiSk9yBOKFQeAJIo+LFdu6rVeMSseu3AHoiMx1?=
 =?us-ascii?Q?0qdixH+ZMZj12ZXsCyQxSiLz3Qwhh+Fs8dMDJsEqv/0DZa2RBUNtnorN7OEh?=
 =?us-ascii?Q?zAKxQWGbNnD+2lGei0kmitK7wSzpwk8xcNUJpWbznxNBgN7J/lKt8adxTjmp?=
 =?us-ascii?Q?Sg0WghiMNG6KMSe3VfiO2WCU3HlQgmcrAMgFpaiuWhGtcHf98Vh2dcmEZRnQ?=
 =?us-ascii?Q?07YNpE6Rmf+26wWH1qU0zHvI/GUbFFRj6YyrEPCn0OZ8upez6i47FKRicmde?=
 =?us-ascii?Q?kHRD/iXZV83MwaQG47do1qBQQO5IduZKoSJ3XlENig1pUj0NLJEg2sdO9cB4?=
 =?us-ascii?Q?FkuwtpFVkPtKQ72eJ4pdVzyXPY8BbS72IvgYIDrA86YE32RDpZDAWz9hPSga?=
 =?us-ascii?Q?mhSGidG+SATi2NHss57kd18UmVCeRmdSGWd6IJiXAbUvRumv3ngP4gyoVrQQ?=
 =?us-ascii?Q?yz9iitZ22ybYyM9cCZuu5Yl14+OzVc+9xDfQFMNBHBMmdbJBAhbL7VBERBDD?=
 =?us-ascii?Q?B2Y7bumy3ir99f0msY596Es7/GuASGlmKTtdmxMrY8/mwfXlHXU3WnjlAMU6?=
 =?us-ascii?Q?yUhZq0hd4UC7YTglBLVkG476GwN92Xwd6zNxJjl5gggG5NJR0dBfHxpb7sn1?=
 =?us-ascii?Q?fEpU3xRRDXDC6l+q3vB7Au58lXzxgtk/t0/fh5TTuK/MbO1u0QzOuzYNHwyt?=
 =?us-ascii?Q?Fx/AJrypWuOoeLVyImRwzSEVLl56hByuYucTF4QPIilaEzqJZmepa6LniWaU?=
 =?us-ascii?Q?Llu2R1CGgkvw5qK5hyXbSRBr5e6eDdWYWAPH9+HL3ccxpFX0GR6pR8yOJXRP?=
 =?us-ascii?Q?53GKWOk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 05:30:50.4891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0eba1f-a213-4f1d-4c98-08dc63568988
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766
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

In amdgpu_umc_bad_page_polling_timeout, the amdgpu_umc_handle_bad_pages
will be run many times so that double free err_addr in some special case.
So set the err_addr to NULL to avoid the warnings.

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index f486510fc94c..32e818d182fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -170,6 +170,7 @@ static void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 	}
 
 	kfree(err_data->err_addr);
+	err_data->err_addr = NULL;
 
 	mutex_unlock(&con->page_retirement_lock);
 }
-- 
2.34.1

