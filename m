Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A87BC48BE5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 10:04:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E71BF61444
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 10:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71BF61444
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEF8089EB7;
	Tue, 15 Jun 2021 10:04:50 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2044.outbound.protection.outlook.com [40.107.212.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED4C789EB7
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 10:04:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAEfrVYHjo+jcbtfW1ecjOXNu/TJGgMahzrXwG/Iva2zN2aQDyLEqxAS/1p1M1z9b0fItmDeiPkNFp2MnrLPtmKrHuWHwMCFBC50yndSbv7/+HW14v2pxT0qk6dpf9Qvexf6ToKzDqAHZCc/JdTRHQqz4INlYaRxnavWXckUf+q3OpFkEAMvjTspCY+yP2aVGS6tF1DYmQryDzZ2Q4qE6JVP0T9iI6cXDf5pqglyhalkxx+Zw5SRadkGM37tF1NWF9ZmC8AX3q4suIHz5qCzxgSORkEiQ5613WzqAg4icEpYf3OuPLy5MKPMgmHGmqtvXH2aHz3ed9i6KO2z5Zh/gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKCKLwg9xoAlzMgafMiTRJYPMdRTMcmqQF01VQfOc7E=;
 b=HV9v5AxCqq1wp8GCkDgPM0bj/DcVuIRkQFyGZsP004fqyF9X4kJ8UDsb1M0GW8ZZmczwghkGpqjhAfgHW1UsMbgTAqb4qyUbAlhe2T/+OQBXEsFt6HslEG9Hrwlp+tjC6Ql/HldZh4+SU4FjafnIzmp4lV9c4MUVHLqB664zgh/8G4I60uCDf7jYSNEHpYpq475p7fGHzCkkqunq4JArlj9u6jcbzNSjroVj5YscXC3gAY362URJTpwCcAILPtq368cEYF5x1/+hQj8FkF6py/FybzfL/xd1COfFtTeMiVDqs1PbWkUwwqmoPriEkB5tcz9czBxj3IptyIMkHET0Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKCKLwg9xoAlzMgafMiTRJYPMdRTMcmqQF01VQfOc7E=;
 b=ZXzPfwvJjcfxtqy+sz8JNIiHc/cyZKDrpQsP/wAEtk/1IgH8zonJ/QiUf8NqZYAAiFH48yMS8xjlRVdMmpjfpS1gktdTqD1mfLnWgvtzrvpYjYPElrI3nAqYUVNLc7jVjTHjJWwxuE91hAC7vRoEAbKcQQJUhsnhWCUFC4WtO3Y=
Received: from BN7PR06CA0063.namprd06.prod.outlook.com (2603:10b6:408:34::40)
 by MN2PR12MB3360.namprd12.prod.outlook.com (2603:10b6:208:c7::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Tue, 15 Jun
 2021 10:04:46 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::e7) by BN7PR06CA0063.outlook.office365.com
 (2603:10b6:408:34::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Tue, 15 Jun 2021 10:04:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 10:04:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 15 Jun
 2021 05:04:45 -0500
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 15 Jun 2021 05:04:44 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/gfx10: enlarge CP_MEC_DOORBELL_RANGE_UPPER to
 cover full doorbell.
Date: Tue, 15 Jun 2021 18:04:41 +0800
Message-ID: <20210615100441.1334269-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0302b5a3-917e-43eb-ba63-08d92fe50117
X-MS-TrafficTypeDiagnostic: MN2PR12MB3360:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3360E4D2C5ADB8FA69FBAB3CC1309@MN2PR12MB3360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AKubQ2p27IguhoR1Uckdro6flxTt2FM593PZYjCC6UlUoLkygONn55y8WVE9yBwB0Yzj4tpTju00YGVTzKowX8XDauTw/XFSEVZtHK5702q3NqEwBuiF/I8R6ICOQHYEtUkArs4Oij2WoJjwAVZyOEI4BUbaO+IA6NQc90cpsl8D0TOjKE9kzZCOXOLabO60WS0ElLhXoYwWwUsP4dcGClctWq6vX+2lfDYzAlIK3cvGJeAEU9LaYK5ndEHAaD9lsr1bOuFL8EkdKY+Ys6Dk87U2FprUtDp/A+x4FQf7AWMKQ5JxyPEgEZAcJKC95jpRBNhyPZ3DIlDpxECTsSkQPhOi+vKVaTc2w2GfGFUj/4t8Tznlnc70QV9mgpBbKDkwsdCSg69DeshOnqIDMJhJNhNrmifUDZSipik47nr4sQXSS1KQ3f8eoKiEa7tRkUvFW9xm1wUacs97znJCbb2KgYFd2MOWjgn6hQA5G4H+6NtJ9XgHaryucZTcchJyGYKxMSOyiKqxrdNHXJDZZAXBgDqr8h+JTuB4p2CUrTvWrnGrGvkVv1IHy+byoNMx92xrL0PEOXAj1FMLhEZwaWjAw7aG5uhHmpp1LPI65NnIz5YX0I/Aybp2C+RXi7Z+FAkmjaQkKMZLC8WPlWarLv6mmz0bQYm4CsDn/48AY9sQ2tVBYNLxaNMaQr1cdoxKtm/kM9Fg9JRNlPFiyH8NIweME9qG38wNQU8lTJlrosJoTCM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966006)(36840700001)(316002)(336012)(5660300002)(4326008)(36756003)(54906003)(82310400003)(2616005)(7696005)(1076003)(86362001)(8936002)(83380400001)(478600001)(426003)(6666004)(6916009)(82740400003)(36860700001)(81166007)(2906002)(8676002)(70586007)(186003)(70206006)(356005)(26005)(47076005)(161623001)(147533002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 10:04:46.1544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0302b5a3-917e-43eb-ba63-08d92fe50117
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3360
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If GC has entered CGPG, ringing doorbell > first page doesn't wakeup GC.
Enlarge CP_MEC_DOORBELL_RANGE_UPPER to workaround this issue.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 15ae9e33b925..7bfe6f9d3a52 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6974,8 +6974,12 @@ static int gfx_v10_0_kiq_init_register(struct amdgpu_ring *ring)
 	if (ring->use_doorbell) {
 		WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,
 			(adev->doorbell_index.kiq * 2) << 2);
+		/* If GC has entered CGPG, ringing doorbell > first page doesn't
+		 * wakeup GC. Enlarge CP_MEC_DOORBELL_RANGE_UPPER to workaround
+		 * this issue.
+		 */
 		WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
-			(adev->doorbell_index.userqueue_end * 2) << 2);
+			(adev->doorbell.size - 4));
 	}
 
 	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
