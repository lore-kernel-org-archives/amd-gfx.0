Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B82C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D64816101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D64816101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EE0B6E8BF;
	Tue, 28 Sep 2021 16:43:55 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2072.outbound.protection.outlook.com [40.107.95.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94C586E8BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:43:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzwAVlVVtF8erOQvPKkM+UrACMpA2Qtrytl7njzGOWayqbAL4FR72rvLcEo8tebhU/4ggXJDqvv8SiRFGxy+w50Pk7v5/GLfhmY/gcbuacFCBFmjXbwCJqyxhSX8Q7qKSb2qftfRpO20YdrA1b1WSxoqn6lu3F7aIzVKlIHlOWfn443SQN469S1qAHK7cpm+K0TGvSjg4C6l0AtLhSTI0ZfBk0RPrMBpRMAo3G8SyLtg7swtRSa5E0wBdivQJRmOAqTr7wkmrF6Bk0OQneyoMnObpPfZW7nzSKO/JkH4hg0zbVDgXZnNA1bvdbTOFVtxcBoKyc/b/RcmALiwiK8CNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=vQDf2WIvuf6khCZ3PVIaM754njg8/hrJ3bLcIR1P40w=;
 b=Hk7+ipDxnIMeKEdNo+xV7I1AChqq39RiSQVvi/mBOJWkiY+V/txC9j87JIEAXkLbCuwPCDZtuUAxJU1aVby9cteZevyCjgOZZrmxjafQ2ZNDBpeEJ2a8nAtmUEWkjd9alNT+XDA5wKzUV3OiBUa/X4wyCYRwrdq7PVVeBybR7YMu76avSiBn/9j4qEff2gHB+KXbeIuDI54W82lqpqaLK3RRByXTY0vx7MITnhxSKLQM6+5a5uP6M+05xLVEFUbWO10RC17UL06OG3NWksnF+DdLAHpE583sg9MdkR9o3PBB3TEPwIKpG6YWxcMjxU1t5Tmosb5NrrhYgE80yZsfDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQDf2WIvuf6khCZ3PVIaM754njg8/hrJ3bLcIR1P40w=;
 b=bbqcs9txlRr+/Y+a+VWpMZ/XMA3gKcdEtSueA2SRIPSgo2KxPbVvEZ+SDCwXUbQGARdr7QbuH81FFr54olehruQxeDAPZ3hA+mXfEQ3mjXYCrrd+Vv9ChL+zUdBH/JeWj4xJHtrplXBhtyzFT6XW78+y3lg1/CuQKSjUHbDT6jk=
Received: from DM5PR13CA0022.namprd13.prod.outlook.com (2603:10b6:3:23::32) by
 BN9PR12MB5291.namprd12.prod.outlook.com (2603:10b6:408:104::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Tue, 28 Sep
 2021 16:43:52 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::38) by DM5PR13CA0022.outlook.office365.com
 (2603:10b6:3:23::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.8 via Frontend
 Transport; Tue, 28 Sep 2021 16:43:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:43:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:43:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 14/64] drm/amdgpu: Use IP discovery to drive setting IP blocks
 by default
Date: Tue, 28 Sep 2021 12:41:47 -0400
Message-ID: <20210928164237.833132-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 654727ee-a3c9-4060-f3ab-08d9829f2783
X-MS-TrafficTypeDiagnostic: BN9PR12MB5291:
X-Microsoft-Antispam-PRVS: <BN9PR12MB529138600E6B26DA756E6E8FF7A89@BN9PR12MB5291.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vYljIwD9wvKAiiCMqw2IS7t3aJvtbt8s6XQ5tvq48+Z+MG6DGnGgOV4II8wsgwCV0ia9B2k97eUhELXDYZ5qg+fwEKQLvFPYx/5aXKSxOoqOqLO5E6mmt4hAZmA4/2EtYyHmJYawuJrVFZhwKUGMiqDKMBfxv9NCgjajJUeE3cJ+ZYcf4c1SnC5QTNk6vVbGIflYD91uehWLem2u8L+Dsb83tavs1QHa1y/t4LrTLB8vc7OyuTundiTel7BYmeqzE+QcPjyIW+hXkYEjCjLXjdBjiNonm5ybgm4PwR3g35dSryFabk3TabReTamMgC0cvFUcIsyBpSmJ7IwF2REhEHzG/VGwMD/+o3EFhVanpO0OyY7zlUjU3miRk61Ey6EwRWt7ukDeULXKl4F2C5XFCVtBh2gwBDHHrBtX8w4i0t3eefZaPDp4J2IAd4pntvASAsDXZIkXhlL09I4DLqqyzq/iFAw70hL5emnde3nAIETTd5KCDGSvIuFpWaaf2ERoyKg9aoY0qaukqo9m1H2DB8WyCogdTraBtivaLvK5wy6Pfunrtu1+VkKRfCOjIzT4b5rFQQwOMl0nSNBa6LmkhPual1yNHmaRjhOaciDv5b9TxXMUqfPRhp8Lqs5dKkWbslJU1ExYLt7W8o1IMRDJGLUyNr8gueaPNrg59WeCJ4Z0tk1MQVkz5/yVoDHM54VCjo5/7B0o1wc3uguoSJ0aHcOsIyWL32pRVA3GTg8A574=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(508600001)(83380400001)(36860700001)(82310400003)(47076005)(1076003)(86362001)(356005)(81166007)(316002)(186003)(16526019)(7696005)(5660300002)(2906002)(6916009)(336012)(8936002)(26005)(70206006)(2616005)(4326008)(4744005)(8676002)(426003)(54906003)(36756003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:43:52.3206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 654727ee-a3c9-4060-f3ab-08d9829f2783
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5291
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

Drive the asic setup from the IP discovery table rather than
hardcoded settings based on asic type.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d06284ad96ae..cf916d4f4e9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2164,8 +2164,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 			return r;
 		break;
 	default:
-		/* FIXME: not supported yet */
-		return -EINVAL;
+		r = amdgpu_discovery_set_ip_blocks(adev);
+		if (r)
+			return r;
+		break;
 	}
 
 	amdgpu_amdkfd_device_probe(adev);
-- 
2.31.1

