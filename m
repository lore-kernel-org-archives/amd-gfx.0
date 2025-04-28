Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB19CC3ABA3
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 21:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 512A410EA6D;
	Mon, 28 Apr 2025 21:21:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WcjmaaMh";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 066E710EA70
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 21:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+96vpB/9Xl43g7v0ea5Zc3/IblQPBNFf3xZgF1KGKm5u2Y8ddlUP1EpU3ob9H+Cdmh3gva+GJzz42PJrBCZMVxmQiCKIX3EG2RzG8x5dprKoG74H3Sr0pojev7SmU87mHoWs3luRIVj3In6iY0eAh1Pc+/WLnok5pnEt4gbx7/uFS7sBjIAnmUfCTqBgmja0Gj7BhGwAMIOiDU2GQkmx5XxH3nF5LGYDN8evTifGe79I8GdEuee9U1xf8Bqay+6VoYolBeJ44pQVeYoove+WmmOnohCAB+O1Ot6b+rYenWHwhM+N/Mz3AjiXBqJO5bcUwgGUSewRxGkWNHRGYazag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msfjPBzoGZE4tEP6OYBdFoAfM7KeyQY/h+W80EMMFMc=;
 b=Wy/PR0LmPEMMLhWGGosh2/xhk1rXl8xtW5708U4PErmS6UIfb7Yk3GssuD8Q9kEkTHZVL7opCZ/GY3+af62DREkauVdq0ly5OHMRAQ9C9i/4nk9uRoI+8I0+VKbwQhG8YpiCk2Rn2obVWIX4rzjRdFa3d1BQVWMQfPqEaFNNNaYDH3dkh4V01MInMKkjmNuCUgkQUxRJANphRAZeW6vZ3om34yvuQfOk4xTBPromTX0i8/q6LBi440ruEYjgJirPRDNGxEIw638kR29lkaXTZtLTduVD7DEoXRN7OSKTav54IUWY8A2hgH1GS0wk4wkd+i9Cfgcq/ER+9R+s1JVZNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msfjPBzoGZE4tEP6OYBdFoAfM7KeyQY/h+W80EMMFMc=;
 b=WcjmaaMh5DgDU+PSbpjljcCyWdWtgBNn1+sUMOKoMQTxYfGtsd/kuMCnRTyDYFR6s/GhveaPf8QFEpWaxzvKPbthm1e6RgH5PETo/k63lztrYE63fZmMGk7Xb+sdvo00G4VgiYVimql+P4Jk/XgwVrMtkE6J8MuLWsYHY4ZtB1g=
Received: from BYAPR07CA0089.namprd07.prod.outlook.com (2603:10b6:a03:12b::30)
 by BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 21:21:12 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:12b:cafe::8f) by BYAPR07CA0089.outlook.office365.com
 (2603:10b6:a03:12b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 21:21:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 21:21:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 16:21:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 6/8] drm/amdgpu/userq: add callback for gang setup
Date: Mon, 28 Apr 2025 17:20:48 -0400
Message-ID: <20250428212050.1098434-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428212050.1098434-1-alexander.deucher@amd.com>
References: <20250428212050.1098434-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|BY5PR12MB4065:EE_
X-MS-Office365-Filtering-Correlation-Id: a84d8474-934a-4d95-f29f-08dd869a9a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ml1pv5SciZ1iP47nCWVzITz32MbqOOMv6KwBRiMdUlY+oQwpwWl7Q7HG7004?=
 =?us-ascii?Q?6edAg9gjZvOxoBcxUjtaB19vSSwLZqHDPAO+zJcLg32nU2cR0sj+pxbLlCYq?=
 =?us-ascii?Q?HQQUf5zr00/ouvSoLC2KzWzwOEVP98Z5FUDiVmEH5TYsY8n1tG008QttcOOr?=
 =?us-ascii?Q?5GS0XXC7TFDlmjTJLz4n/GTfHKXSQFwvMfGy0KRq0fv/XDDF0WgPYbRBJNSU?=
 =?us-ascii?Q?rggll8mGxolHpPbQgFBrSFw3W3/hhkhsgR+xT1r2//IhHQQBZiQy+JbbzVlc?=
 =?us-ascii?Q?HfVntZ/IZhkaLwLbGigdVwnnk+6L1jVTxChQni4dgFkdB62DbOqSccvvAfwe?=
 =?us-ascii?Q?eE5eWnkUtR/B34T5rhXd5SYT/c2/mNLuAgDPlr0NWnHR6Cbp7kvtV9nt+lTw?=
 =?us-ascii?Q?DmrNrQkfYVI/n3sSv9ac9lmA2UoHKAul2SNCZpY1kEvtPMBoArv2AfCt5Q96?=
 =?us-ascii?Q?KKLHfPGr2M1ZKHRlDx0GuacEfvdE3uHWYYhzpDVPhONktpaTsMnOol5sNsNZ?=
 =?us-ascii?Q?Jzxe47lQ0zVx9YxUHv5zxBTHnzriEhtnAg4D8Jde5iNqySpN/Vvmvjp6zRqC?=
 =?us-ascii?Q?AGz2ijH4M3NYCeczTNGT9ulhVDxgQdIuloNwzBnJrhCZEGD90ahkgey/gWBh?=
 =?us-ascii?Q?qk51UMiVVBTnDWMig00vWiYIKBNq83nAQ3GYsBQp8EmfO2d6AG1aoEM17A2b?=
 =?us-ascii?Q?N0mJnL2eRS406aa/9GtmUIVKhrl77Sqw5gWZhvWTAi5aBPCTCXQtbC576BH0?=
 =?us-ascii?Q?oQaxGWfjZvl7OoeBwdqFxatdXn8TqnCtsCrIjOErERcmgUCx64qhW4KL40dN?=
 =?us-ascii?Q?AB7Bkhp2CmfioQ6Il0qzuCnpfoWAyL3b2NThNlSA70osvH6b3982yFCBzCP4?=
 =?us-ascii?Q?OrUxfPDT6ytW+U/iDib57c8TiH5rDpV0Hfzms3469iUFuhrW6fnh39aHD6Eo?=
 =?us-ascii?Q?Hx9RMUOeyWDbAp4Q5wogB8C+w7KWVnMhJ9XGrmP6rDhDV6XSWZp88CJ8Lk91?=
 =?us-ascii?Q?3WoCY9pesuF0y0sFYPad73AxO3oZuhxMu+B3Vgo3uksJn2mm58NfauFeNSqy?=
 =?us-ascii?Q?2h8JWb52GLa8nIuUOB17mWjIJQ1zG+enLtwtOdC+442zXSD0gMHEpSz19vjb?=
 =?us-ascii?Q?jrzt/Tq/ncnIA2vvb3m7wDz2MQgYt61bDG8z0nAFRGdm6tOI0HEQ46mTQA89?=
 =?us-ascii?Q?jcl1DAqobBk8xn36qYQcfCIDE6kofEO9errf58ldKhT8CsajedLj6aITp/PX?=
 =?us-ascii?Q?7cgUTMRS9s5mbDiJ9Wwe1tZbTB8LtdlyO/mQkw1vPty35Vw4WscpQtGsoes4?=
 =?us-ascii?Q?niLmAXfJQ81JsJUxt5mjoQhiCrZ63ZuTWyMOqMwzn9x6AJc3X0sj0EdiIK3Q?=
 =?us-ascii?Q?diR1Lt9bRulwCzCffpeTPAsyTPAHL8ANEUhY9Abq1uCiDDtQA65hXYayxnyS?=
 =?us-ascii?Q?BjWlV/bq0l7Dk9epT45GfikeDqcYhQ82dvQturKq5xCek+T3iyiurVBVJEP4?=
 =?us-ascii?Q?eA6MEAs80B3vJmvdBwGSQ61A6O5Q7yERQ+Vh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:21:12.7341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a84d8474-934a-4d95-f29f-08dd869a9a53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065
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

Two queues can be ganged and will schedule together.

Acked-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 35a08ee59d893..ca11f7748d031 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -80,6 +80,9 @@ struct amdgpu_userq_funcs {
 		   struct amdgpu_usermode_queue *queue);
 	int (*reset)(struct amdgpu_userq_mgr *uq_mgr,
 		     struct amdgpu_usermode_queue *queue);
+	int (*set_gang)(struct amdgpu_userq_mgr *uq_mgr,
+			struct amdgpu_usermode_queue *primary_queue,
+			struct amdgpu_usermode_queue *secondary_queue);
 };
 
 /* Usermode queues for gfx */
-- 
2.49.0

