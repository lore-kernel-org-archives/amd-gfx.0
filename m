Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFE0C6FD1D
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Mar 2023 09:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AFBA10E12E;
	Tue, 21 Mar 2023 09:19:17 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D096A10E0F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Mar 2023 09:19:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAsHm6nApsBH2w5aqEVTg3LtsKELKAut2IgQoJFdeyqDgZ8uyxjBmq20uxG/swk2Ui1AVA3Ssy3PTGYyb3BFG371JmEXmnb5pIwEZWCVvarSxdPYnykoqhu+V8n39T3QGBbI625xlT4Ov3hLyn4Aljus0wxtBIinjpDZpqDOg/+WeGYsK4euOeolJ+dXAjYvwcKGEi4kBdnfi5rmxZJgWlMpCX1wR7lEYh3LDZY6x6EJiaBRqKtnFcVIdFA12QIaU6P6tqTTgqrHzxbQ6lkQhUlxgLIathbsBZv+JYy+iTlxplZYpPrCuYhmxUKe38nyQ1+80/tSOxNGpqmkU7mDlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W342OCvxFcmVyMbcEy9oYV2XMGmR5qWJ4M0WJGycNjk=;
 b=fu21UP+xOe1vhOzIBuncz2cUB8+i+AENSxaS50pq5zA6gI5DFWdTGB9rPshEbONEHdV22eEeZkJxb7E7RMFg+G77Vz43HCpiE2LUReIBOKJRZC3VT7HSQPYaybOGlyNkeO0RTKc/UkDlj/1gT25A/zTgcCh4a3cS9aU+sWpNskFRZwPh59lronZ5dtbk2iCzdlTVsb1t4wE/ZiBMy+K7MCG0K5FFsq9wLAXUK17aO/SMugWwc2xqYIvjOlgSl0Q0U5UgVfoJH0/tN+LrjvB6CeyfZL2qoBzeyv165Q+RvgDSNHAY37Heot+4V5VP8zbjmNdKnZERTg1+9efGC7ifKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W342OCvxFcmVyMbcEy9oYV2XMGmR5qWJ4M0WJGycNjk=;
 b=CygsvE8Wv1I611Jis5RkfkrpV57YuER8QAcdK/4k1gb9s2CMmclAf78BuNLRIssH24nxUFpuMN1Av/njamEN/Um5rc0dCvXYytzVrD3gbGMaMDc+6IJCE0ZBd1bsz1bxJpixbQwgzi7d5VSvRf9brFdDae9oW0bwgs78wRaFHlU=
Received: from MW4P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::26)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 09:19:12 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::38) by MW4P223CA0021.outlook.office365.com
 (2603:10b6:303:80::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 09:19:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.16 via Frontend Transport; Tue, 21 Mar 2023 09:19:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 04:19:10 -0500
Received: from amd-SYS-7048GR-TR.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 21 Mar 2023 04:19:03 -0500
From: Tong Liu01 <Tong.Liu01@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: skip unload tmr when tmr is not loaded
Date: Tue, 21 Mar 2023 17:19:00 +0800
Message-ID: <20230321091900.144479-1-Tong.Liu01@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT017:EE_|PH0PR12MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: a8bdf16f-030c-4cc1-51a1-08db29ed5570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJ30s7RN9LoS2inXWasVaVAhaWgAdRxQRCvCE+qluY8NJkT4L7dCnOxeZMHa3gadvZL1juRpE5uvt+UBTRCPeh/HrCI2LRohRcLnOV9IPv6Hfm83ctX2ZB/9Ki6PfYqhbzOSwF+yojr523ZFy1h8dp/y1RhR7YoqDer1RjtQWMXRl+UgYbgjWcFYDukxHGZqSdnCIW6d4TB9nTMdiLRDz8bmSbAe7ik65K5J0jz9qd4GiXpohEnEMNfwvaviRsU4O1c80NlfBnyQRoil1GU7aIl+0qyBpWMFsT1PeMFq0Dyk3SIb5n20rbK9gdB20zm18QvTuidSVLZgenFYWAdT4QAr5ApL2LfmdrR8xbHz93vYPF6KdAHchl4tl8EkQ060Dfe6QUIrPQtewpbjRqlhbpIfHJmo/iw35kPB4ZGh3kp6DGf/q20mjc+3lqCXBWMyvZFglJDqVFADoARN9w9uzh3KaiD1qqdQHHHqU3+Bb/x1v9qCC9rbEOU53QldMeCPjAx6WLBaKkJg2hwhv4Em28FfA0j0z4ot0SOqFlU3PqM09uTOwSAYEhZ6qS/77KFzLyrvbAfkYYOTThEv07ysw92cHwdWA6OELFG5tKrFraVNd/5fALimkRjhV4xnj+yTOw6Ox1vWnPJpBmV1TEChZebr0Ia3D5erDxI9D2VqlOzCsSBUyfLixIHG4MV+57f5nD3GJREhCo/SHo2lM0tP9YB6vaB82xKjHl90aukCF2o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(4744005)(5660300002)(8936002)(41300700001)(4326008)(6916009)(36860700001)(40480700001)(82310400005)(356005)(36756003)(86362001)(82740400003)(81166007)(40460700003)(2906002)(336012)(426003)(47076005)(478600001)(7696005)(2616005)(1076003)(186003)(26005)(54906003)(316002)(70586007)(8676002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 09:19:11.8750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bdf16f-030c-4cc1-51a1-08db29ed5570
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, horace.chen@amd.com, Tong
 Liu01 <Tong.Liu01@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
For Navi12 and CHIP_SIENNA_CICHLID SRIOV, TMR is not loaded. Should
also skip tmr unload

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0b9e99c35a05..69addf2751aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -841,6 +841,12 @@ static int psp_tmr_unload(struct psp_context *psp)
 	int ret;
 	struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
 
+	/* For Navi12 and CHIP_SIENNA_CICHLID SRIOV, do not set up TMR.
+	 * Already set up by host driver.
+	 */
+	if (amdgpu_sriov_vf(psp->adev) && psp_skip_tmr(psp))
+		return 0;
+
 	psp_prep_tmr_unload_cmd_buf(psp, cmd);
 	dev_dbg(psp->adev->dev, "free PSP TMR buffer\n");
 
-- 
2.34.1

