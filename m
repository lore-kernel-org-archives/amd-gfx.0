Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A19C001B0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 03:18:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E9DB10E399;
	Tue,  8 Aug 2023 03:18:43 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E64410E399
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 03:18:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aydvd/ej1y5AZU0qDsKiUkIqMnCS1je3umhxX72kXNaYy24OttWkNvrgbilzYpJ7UREjXCIpp2fBodvuOsvjaHMDP/nOxwO2xAUjtBRylHjqMzxPoWyhbBw+1U9+TRRXTbPTaZHFM7zGGxp2XaKo7Lww/b9Mh6wFv8vLDYtPCD8HIgKaBrDsJ4hJxUlWwXrbZSzGPU9rpcjWW/e0iwP1rEuo3AON5C3QuxhtK/jhXMJ7p9YDH3+d5VtEzrzOpvw7oBT9XgE2nsivVwdBp0xkYR0p6ma89WpMQ5mtPTUCW150Xwbdwsmd9A5pWpztEygtj9hiTnLZqWYAaBMKl/Qw0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPjD775X/nNO+xb2wP2vgtLzI7QegSJhayyZ3niVRkY=;
 b=mgZ311Uy+oSSr0jFyrt17OcdBmACm5JESWvq4tSHAS98qU179Od0+4AeS5MCBdzJfsUtSVQsB5B+ioU3GEkTx92RhBTMFXDUcOzLkxdlsrQV5Z8hIaVBGNnGmrL8xOOe7DwcIPwxL3bbAY1TXsCinWBVDL2V9IY8q4gF+9b+FbThXpKpWJRIRm7aYS+Hp6j1iYuYX/G4ESQ2F8obPfCWCmHwMoXO1R78+NIvCws4ySDayPlc6f4eyE0vWPnxGVHZRqxE2kHVYnmEgxoEvWT4j8TNyYynCaQSdnY2u31++HSumPF6BAMUxCF6NReke3W13BpdBD6x3BWNf97q6ET91g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPjD775X/nNO+xb2wP2vgtLzI7QegSJhayyZ3niVRkY=;
 b=B2rciQtAeY5r/7ArE9IElLhiwm3mw8ZP8NYYC5qww3QMnxq0PTQB3f2XE9O4B+uoc6CLB/2Iep1VIXdyMD0TAVFGP5o1I11Mk3WjVrCxIhSDwPU6VPlxrHWmzsA7PcfuaFZvLIEyuxVC6GVZriF2Rjv54d3rATvLk/PtUZTZzKQ=
Received: from MW4PR04CA0131.namprd04.prod.outlook.com (2603:10b6:303:84::16)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 03:18:33 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::2e) by MW4PR04CA0131.outlook.office365.com
 (2603:10b6:303:84::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 03:18:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 03:18:36 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 22:18:34 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: disable mcbp if parameter zero is set
Date: Tue, 8 Aug 2023 11:17:36 +0800
Message-ID: <20230808031736.529835-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|DM6PR12MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: 464a4f6e-38d5-48a8-574c-08db97be27bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 49AFoNpoO22Zg2ScaXQ17b2KY0RiE0CNZ0Iiavh3ESpkhULiMxk84fBMKkQB27VmRr1HEpr02+tLuOPf4skyc3v0OXCCY6poss8FgGiNY8f0VBZiLeiIL9kgVdEdo1d8wtckJ6pAvRAmqpSpwIjKTmLnuh7n00C1Tgs8XR95fGsvIRkAnFVqUpeQo3X9MltUadB9TgST21ZSXHelqcibIrVPBVZ1dBg0S2oB0klvtJ4Q49rk9INXQMjB53ffzuPTByWeBy/wy3xvi1IZ67ZvmDZMOlBvQVu/dlltTpHpXwh6hafoUpNAAEU/wBQeYw/7ILjh0PlsaOw3kSl8+CtOZG/q2QphC1w5AVmhOqkl6LYC28AOvB03c0iQZDFro9K/HrKdQxpIGIYgCxkjh4Knla2wlVMWz/48UmkRQYU8V0N3WR063+eLkZoHyCJYsHpmPeZH8h4FYzUJeP0DmxF7KnGr0a4g2uL85e88CMVBT735wdr48PsPPr+iEmkLt2a5xEHTR3JtBIayF5Z7ok+2IsJVOHfsI33dhP+jezV1J677fKZXH7a3FUBdWJgsgKjiKdcXe/5YR0bhiQEF8qE88Uw8qkWepKYJdVmsaNKMn91cw3uktO2QZob71Jmj9if76bAna1/EYhGBRSSiQuiRQWgw7pjnMxWt9ArGTss8CNpDXtqB95TQNql8RWUo9deun9sDArQEX9IrZL8ARtifn38fKaUjZ9fCdp30SM46GLv/QtcJYbgeC5VVqsqV+ggT4tOnBp/DMSX/rfwLCTAVM2hH9EnAd8hIwmkvlSVzAVAhUoLFlhEm/uK0qveC9YITtZ3rNiYMGmwAtsYbigNBKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(90011799007)(82310400008)(451199021)(90021799007)(1800799003)(186006)(40470700004)(46966006)(36840700001)(40480700001)(26005)(1076003)(40460700003)(36756003)(5660300002)(86362001)(2876002)(4326008)(6916009)(2906002)(70586007)(70206006)(41300700001)(8936002)(8676002)(316002)(7696005)(356005)(478600001)(81166007)(82740400003)(2616005)(47076005)(36860700001)(83380400001)(426003)(336012)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 03:18:36.7769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 464a4f6e-38d5-48a8-574c-08db97be27bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434
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
Cc: Jiadong Zhu <Jiadong.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

The parameter amdgpu_mcbp shall have priority against the default value
calculated from the chip version.
User could disable mcbp by setting the parameter mcbp as zero.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7314529553f6..615669dcabc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3699,10 +3699,11 @@ static void amdgpu_device_set_mcbp(struct amdgpu_device *adev)
 {
 	if (amdgpu_mcbp == 1)
 		adev->gfx.mcbp = true;
-
-	if ((adev->ip_versions[GC_HWIP][0] >= IP_VERSION(9, 0, 0)) &&
-	    (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 0, 0)) &&
-	    adev->gfx.num_gfx_rings)
+	else if (amdgpu_mcbp == 0)
+		adev->gfx.mcbp = false;
+	else if ((adev->ip_versions[GC_HWIP][0] >= IP_VERSION(9, 0, 0)) &&
+		 (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 0, 0)) &&
+		 adev->gfx.num_gfx_rings)
 		adev->gfx.mcbp = true;
 
 	if (amdgpu_sriov_vf(adev))
-- 
2.25.1

