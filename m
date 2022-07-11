Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EB9C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jul 2022 08:55:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DBD911B857;
	Mon, 11 Jul 2022 08:55:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D2C211B729
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 08:55:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geia4DM/ljw3swCF2bRix50E8xSiHiQuuw9+9gT+AFZy6azKnLenffyJgTo4phHCutqw324tBIR+VHujO1gYQhZm8mTl7nqEBr4CuP3Y4qGQCgRk/u5onN3HJbbs5H8PUh2rTV9HqtMNILCnsZfwvX9TZYC38M1fcqoyK8SPec2Irf3LbgxoJ9CuEY69zhN+FOfElTl2Naf6ThAfGpgKGzQ5l0ShsDGtUVCFQQkWn052pDOI1JwtntWcef8aoZzZZzBwMook3ydrGJKNsBwJi5P1NbQbEWbhLLjB5F79RRWim6ylakZwRY9sJgjDP5eBfwpelnyXNLAkrLOZUfv4ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhGFWimQXoKqKwvfmHNjbZ77H9LZNvIx/t3xc0MlS8w=;
 b=D8Zi4GmYPfUlEkZf4ZxoiyvwoSjEJgcpO1VrPnhJh30HpPA5zcZNBNQ1bfNR0JVB8XY8LKFS0HScH9U8U7C/vCcT6D3a602iytqMJZkqYQBeLU/ugovT8w6gLJniRVCP6uvIL3OXUXLzQ+wLKjTj+T1xbNdCqUOK+B2aYRb2MGrzIbdeRnW2zevze5KbJqKW2HzUlpE36nNIK+ukBrnN/Rs2BmvHE+AG4P/ZICBr5GICZwS9Lt9fCfhP1FS8t0LsRdnysjH3+DHDfHCAEZY1GfaOBGEzJGLKY+ZV3eTL7WHg+D5sdfird2bB4IcWOtbKdI2Q4ecQR8bdv7XqjdTWFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhGFWimQXoKqKwvfmHNjbZ77H9LZNvIx/t3xc0MlS8w=;
 b=Ut/gtXMcLMqtTAICrSUTIkJnJHJi99WmIq41k98/aYvqQ5mhj4pvQ6uw9CouJCDmhu3lWnsbT2Zz/B4TAEXxHU+Q153erNDFEyZ777JA1O/BcNthmgZinWA4APhCQ3Norplp0LdDgRZR55gHJIffMwD9G12H4xgQMWTS2GUAhs4=
Received: from MWHPR01CA0040.prod.exchangelabs.com (2603:10b6:300:101::26) by
 DS0PR12MB6392.namprd12.prod.outlook.com (2603:10b6:8:cc::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.26; Mon, 11 Jul 2022 08:55:08 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:101:cafe::60) by MWHPR01CA0040.outlook.office365.com
 (2603:10b6:300:101::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Mon, 11 Jul 2022 08:55:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Mon, 11 Jul 2022 08:55:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 11 Jul
 2022 03:55:06 -0500
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 11 Jul 2022 03:55:05 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: correct the MEC atomic support firmware checking
 for GC 10.3.7
Date: Mon, 11 Jul 2022 16:55:04 +0800
Message-ID: <20220711085504.2143925-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3c35206-18c4-447c-4f6b-08da631b0e3e
X-MS-TrafficTypeDiagnostic: DS0PR12MB6392:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pEO1ucnUNyfJffC6RTT0EQZokra7JmkfC7WmcYYlawL/ZTarE62Mndz0TGQvjNpf/2T7Hm9wMC+9YC/HlSRsx77DCjs4ASmDOaORJOKlXJ2jqAVvBHKEMqk6qCiH1qwePJ1g11HfGMi4leOViDN/JQj8VzXMa8JGOJ4WHWSvnbG15qvfCD6ijMWkMN/BIUicp/h2i8Lx41HEIlG00foy6TT/BWwfJbwlN7fut/d1RLYGGos7GTDYJOc+dUAH0f7pP2wnTti9DSjBEWr03+9Ytmy3e7FKEto9tQAprFVhzOuChAQb3/11SWZFVCAnRyDBE+232Ue5KfmJOD5VWpdjPDjUIOiGxaiE/rcuIOoh6gehF6kBVkMcMkhRHnXn9WIvCANZzLUQ6YDPKsdXc6qkN6lqhsVxT8FWZM/dOgjkHxaoRyelhB5qvCA3nd45C43nypZYUdo7F+5b0CZexladrgap8P2qeDUOfxEIamkTuKE33P9JEb6CUJ3Qwofh5bJefUt1xi3TDEG6vw00ZX55EykAzaVg1NB0TuZsRnGvhGCqw7pjBPplk1OWzJ0WV0z9Do0UlpVO3Yr8sZdQvg3TB4p1SPYUvkiZYrfnF9QyBYYIJ8PLRF6r+QAs6lGatzXyzFW2ZwQFWYvvEr0B1AeD9xo/2RZrON0eiIvUlK3u6YMl915Njxioxv6Pu9p5ReuFWZNIAg4pnyFgfWaqM7vFltsMTW3E8gHxiCHPsnAsTwHQzvNxL7g6NlcoND3lg7KDf+M0ajfTbAFRqLPJ3UNkW9NB/x+yOeZUu4agldiAtCfEbCI/JJnDdno50pjT4O/mAeOTJZqf8Gi5yI8yRm2Zh01pyH6a1ZHuVpWBWmm3vyStr3Boui84IYsmJWALkxSU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(36840700001)(40470700004)(46966006)(47076005)(426003)(186003)(1076003)(26005)(2906002)(7696005)(336012)(356005)(82740400003)(2616005)(40460700003)(81166007)(40480700001)(86362001)(34020700004)(8676002)(316002)(4326008)(6916009)(4744005)(54906003)(36860700001)(36756003)(82310400005)(70586007)(70206006)(478600001)(8936002)(5660300002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 08:55:07.8703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c35206-18c4-447c-4f6b-08da631b0e3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6392
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

On the GC 10.3.7 platform the initial MEC release version #3 can support
atomic operation,so need correct and set its MEC atomic support version to #3.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 6ec0e9f0927d..f5853835f03a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -184,6 +184,8 @@ static void kfd_device_info_init(struct kfd_dev *kfd,
 			/* Navi2x+, Navi1x+ */
 			if (gc_version == IP_VERSION(10, 3, 6))
 				kfd->device_info.no_atomic_fw_version = 14;
+			else if (gc_version == IP_VERSION(10, 3, 7))
+				kfd->device_info.no_atomic_fw_version = 3;
 			else if (gc_version >= IP_VERSION(10, 3, 0))
 				kfd->device_info.no_atomic_fw_version = 92;
 			else if (gc_version >= IP_VERSION(10, 1, 1))
-- 
2.25.1

