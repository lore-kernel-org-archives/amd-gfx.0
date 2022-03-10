Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC29CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 14:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 417CD10E853;
	Thu, 10 Mar 2022 14:04:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62CFF10E853
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 14:04:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQmozUTMdE1TJb7tp9LaSaI5rTk0G21O7i/8gh33cJsk19dlXMKjhzqrp+81Pa9KmchQlwq4r2/P1v6xN8CdnRjOXsWQtTW9k+vDXkz797yDmBpCkHar2CQI5C2IIw3w/QFDGr8VU8wghVDyi616DT1QfRVo38KpZiVZenXr73MpYmA+T6m5Ao48qRZ7nQh8sM8nv2Gggddq6z98tRnND7/NYYinrGW85SI5XphPK27+fxMgaxvIw2pwPiFBE3aBH7hhREStJAKlBYl1gLMO9Z09B+tjvEfhmL+zjzT00KnWNIxmjuZ7+HOKJtFOKUOZsnQjJopp6BA65jGFNeCreA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBKLz2CGMUpycXhhmrcX4+GSJB4JT3P1GQtVI8lKXiQ=;
 b=lcBK+jHVrYdYE+6U+pULFiDHxV4iFtGeShragLiNytvrcTjE0mE0CiBPo4Mu2uioGVy28kY6lVUsbWzh4Stf/hDJZyfoPiCcg90HtX0d+nUWRyXdVLu595XBzgoNmNfMgVcUeE5Fjv3SwQNu2h9nLih5AbO2WNH6ckpgT4497nAIkRC4BGrRu4w5httIf8HT3V3uAbmcw0V1VcVLsJ9SOqstMHW1cQnDpjza2cl3Zz0mvVYTvmE977lkItp+ZKuTLC7L+liSNc/XwDQqjCvXGmxUtoJDgZdZijz4fKHsJ1Qhgbo5+450GV5NStPygGs4aM4CUpSbzMUkQq/g8LJzGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBKLz2CGMUpycXhhmrcX4+GSJB4JT3P1GQtVI8lKXiQ=;
 b=0iEagxBFGNXJOklVIc46TQCas6siTpK0PgmJoyvy+Tu2dMCSqYWSlw28kxFM7MqYoAnw1sIefRqS3Py48mMYJPA1eNcWg+n55gLCwgpQW+adrGOBCjxAqN/PFSRY9YxIkpO5L7m0gZ/Bano03/nYwynZ1lxKyRZsq08vTKuqPwo=
Received: from MWHPR19CA0024.namprd19.prod.outlook.com (2603:10b6:300:d4::34)
 by BN9PR12MB5051.namprd12.prod.outlook.com (2603:10b6:408:134::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 14:04:51 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::ba) by MWHPR19CA0024.outlook.office365.com
 (2603:10b6:300:d4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Thu, 10 Mar 2022 14:04:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 14:04:49 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 08:04:48 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 06:04:48 -0800
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Thu, 10 Mar 2022 08:04:46 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: fix gfx hang on renoir in IGT reload test
Date: Thu, 10 Mar 2022 22:04:39 +0800
Message-ID: <20220310140439.249268-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 111a9760-1cd1-47cb-fb7e-08da029ef10f
X-MS-TrafficTypeDiagnostic: BN9PR12MB5051:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB50515474AD1BF8DD637B67DC950B9@BN9PR12MB5051.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G1QoX2+aomN87/K3g37QklC8U2Qlyk+4MNy0Zrs4CS2SNNCN/VCVJbKzCw+P8HBc8Ti5Ln+vC7+efdHPihKqUOZrwjDlOZfJcDvzJuIIHM/aG+6FuXpzNsKpUZ23cLCSeOGaKQcLFva0jAJkz7gE8rOzcNEj7HZtzDwmKj25BE+HMxv7sxfbuZwdkUdAKrhhx+5utnX8c41NUnMaJsmkHs+2c9DtQoJCvfq4sYtAsegfkbVa7qCNwAoZnqoan8tHjd7UUz14sbEcjAVlgbLvN0RRggTXVE/K3UCz+zDmnpqyU7VvdP6aT7VbOyEYM4aM25gDJcF6I2A7MW+eRS7cqfqI3zPoYUVk0d1L8zopYXPpfPwLffUvifHm/CLqjqOGfYQL+BoDaagZ5YU7TFFvJ9CEwekAH3TUK95ct2dEKTV7lSXMJ0LeQdE6WAcg44DJ+wbZ14qM6HpNyEqTBwl0MRSW6EaOSqO/a7KpxhE/eVzQRI9db49aQzEqTSMqiHq3iu5AIczDBIvxR7IJPkFl2x8diGntvFHxhGYROwxxjCNqj6dRG8iCLOyMiy1L71Wa9OGkdB1fxoB1880iwV6bGhyLZ47HP8cy9wg6+N7YkU+G3Qc054JA9/zNxG5EhDhttWA9O7rn10Gj+fRN9XrZwOtzGjfePYzJ++vtmXetUDnunEpuuBcUZr+8XJxRBRbCyGdfiXoCCj941HuzT4xbhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(47076005)(81166007)(356005)(36860700001)(7696005)(40460700003)(36756003)(82310400004)(8676002)(4326008)(6916009)(54906003)(70206006)(86362001)(316002)(70586007)(44832011)(8936002)(5660300002)(1076003)(2616005)(26005)(336012)(4744005)(426003)(186003)(2906002)(6666004)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 14:04:49.6916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 111a9760-1cd1-47cb-fb7e-08da029ef10f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5051
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
Cc: Guchun Chen <guchun.chen@amd.com>, Zhuo Qingqing <qingqing.zhuo@amd.com>,
 Tianci Yin <tianci.yin@amd.com>, Liu Wenjing <wenjing.liu@amd.com>,
 Wang Yu <yu.wang4@amd.com>, Deucher Alexander <Alexander.Deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

[why]
CP hangs in igt reloading test on renoir, more precisely, hangs on the
second time insmod.

[how]
mode2 reset can make it recover, and mode2 reset only effects gfx core,
dcn and the screen will not be impacted.

Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 496c4a6e23ac..f0713c027ed5 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -853,6 +853,11 @@ static bool soc15_need_reset_on_init(struct amdgpu_device *adev)
 {
 	u32 sol_reg;
 
+	/* CP hangs in IGT reloading test on RN, reset to WA */
+	if(adev->asic_type == CHIP_RENOIR) {
+		return true;
+	}
+
 	/* Just return false for soc15 GPUs.  Reset does not seem to
 	 * be necessary.
 	 */
-- 
2.25.1

