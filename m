Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E47C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 10:01:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ED4E10E161;
	Mon, 24 Jan 2022 10:01:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2803910E828
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 10:01:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPMNPCkhqMGxwAu7cSBhI+AYiB/NL+CqP14Uw6wTbMpbi+cHUhyx8PSrfsrilPiYCarHvk/ZtfFCtlOor6CCIZYqVnrpoKmuBJlWQ3RaL1TxwdSE9BppRBsa4OEi5v9zmQ/jF/h3QR/dWBNWfWFtZkUdAjWSMwDPxrwcX6jQVliYnepqwLSJRVz42rbxsJHrF6IxpbJ1Z0v3gR//TKJOQdO/EVg6N/lEH3IGv6WVknEteo7hUwydhg8lPdWUz2VGpHps1kW2GYB5J8IUz07diqmmesmZmbBU3bFMwyB+gtri0dqw5XuSH3hkuoQUl4ZFXFpVImCpoSSOOKdMd6Ur1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooX+RkvHTmTnSCujN9z4OH5mNf0Lpby6XvcZhLlQ3Wg=;
 b=XjeDRj2rez/RKg1qbxHurOwVDVLapOuFw8ptwDZQHQH2zfksKx+pzLKBf3oY97RoTzJ6m9/leqVVpnZew4ajLaq+Vx3cgkBguj9xIOEoUxW0umdHrk6JtJfMJqr95K9R1F926pXmQc3CrTnY1LB3YwilyyY5AbMk9yP/e+bYjYN7UuCZpo0UdxOIWK5yA3ad19HgoZfv/IdMfsn3E7JJnRkg1uIxjnQuLWC8a6ah68Udqcgyma0Q1a1asVDn3XmwasfWQkm7hWykiUdeqKeD1NIQ/2d++9TZB4fMFAnQHve5hg8/x5Ti7tbLJ/NHgBD1swsM69iPcIdUk+jhbKpH/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooX+RkvHTmTnSCujN9z4OH5mNf0Lpby6XvcZhLlQ3Wg=;
 b=FKxLY2TGlNkcH4/nUCRLpuvvb93I7DYvaYo7Ggzkrm9IXBy5ojXpkxg1yyQASAneYIouHimjvnGsjZSE3uo2iJ446V4R5rd7x1nlnG561jZg79CdNgGLVcPEojybUY5Mt1J1+LWHzoOiTA/r/KqC3rjDqfwIngjhr14xlKfg2QI=
Received: from DM5PR10CA0013.namprd10.prod.outlook.com (2603:10b6:4:2::23) by
 BN6PR1201MB0196.namprd12.prod.outlook.com (2603:10b6:405:4d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 10:01:55 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::ed) by DM5PR10CA0013.outlook.office365.com
 (2603:10b6:4:2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Mon, 24 Jan 2022 10:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 10:01:54 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 24 Jan
 2022 04:01:54 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 24 Jan
 2022 02:01:54 -0800
Received: from yiqinyao-Pro-E800-G4-WS950T.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18
 via Frontend Transport; Mon, 24 Jan 2022 04:01:52 -0600
From: Yiqing Yao <yiqing.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable pm sysfs write for one VF mode
Date: Mon, 24 Jan 2022 18:01:22 +0800
Message-ID: <20220124100122.1634569-1-yiqing.yao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 195d940e-6cfa-4001-a3b4-08d9df208d21
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0196:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB01960EB9C3FF34148B6F44EB855E9@BN6PR1201MB0196.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2J+kUNIMG/Vm+ckiurvvmYSBQWc4/McNy9+Ch64ap33KhD/ZGT30mZZwl+BkAo1tyBcKxVu4pmKFk9VxjWNXn5ZaWK3BLM95blGyaUcUmb9l19ZKxcVL+M82zv8j1/Xb5TOM6wgRIJai931C73/jG+wmpWvBTffA01h/4AnuwqrjSK8F8EC0d+w92VonMG47EEwHyyc4soYpY0YKNn1j/jT9ve89cfltFsAaHobIUzur/JexGg0IchEZaoFITeG0NoIIEoIspNnDp9zXg6m7TuOEi8q5UbtQuDULx2SvlLoXZIfoJ1ttg06cYtw1P+DFa+4Y1UHlRalz6dOGIrNSlDlrkiqkM65cC3sLxV7gR0wfaA1STer+HSD1NYGarUyjgMLPpecz8pzhRv6jqH+jkhUsX6IOlq2scmcZdUkYuzMDChnTzG+WP79JNantknsDHBKhmLYFfjzuD0I01hFGEpEAc3sZzHIXMWAGzedvuIHui3YcxR3JFVrMPyMWak0uaSD689aMLFshanSnWJ/N1hHiy8KX1IThwQlp+rEbbGEeCEXcB8Ucazb/pcNUc+ZuNNcZl54P1vZY2xPivNhSfatit5M578xPyDsGboGjT3tVoByFz8S1N+ZmWUX9KXY8wJbzRax50NxiQdqwPRscCmLICQxEMsQu8JWYORAfB2ksWE1L3FFocDQRSKtjSxJO2BPoymzm0AVWsLakBxxVFDP9RoZC/purBVWyXVBZWL1M12UHt28is6M0gpKkTQ3y2ppcNDIFAuylzFrqiW4aH3Ei9HHvpaQUbOgr4knjseM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700004)(36840700001)(426003)(508600001)(2616005)(70586007)(70206006)(5660300002)(44832011)(6666004)(4326008)(40460700003)(83380400001)(6916009)(8936002)(82310400004)(86362001)(36860700001)(4744005)(8676002)(7696005)(316002)(47076005)(356005)(186003)(54906003)(26005)(336012)(81166007)(36756003)(1076003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 10:01:54.8594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 195d940e-6cfa-4001-a3b4-08d9df208d21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0196
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
Cc: jingwen.chen2@amd.com, marina.nikolic@amd.com,
 Yiqing Yao <yiqing.yao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
pm sysfs should be writable in one VF mode as is in passthrough

[how]
do not remove write access on pm sysfs if device is in one VF mode

Fixes: 4436ea3c43a7 ("amdgpu/pm: Make sysfs pm attributes as read-only for VFs")
Signed-off-by: Yiqing Yao <yiqing.yao@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 837a31a46596..5250032a2ffb 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2006,8 +2006,8 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		}
 	}
 
-	/* setting should not be allowed from VF */
-	if (amdgpu_sriov_vf(adev)) {
+	/* setting should not be allowed from VF if not in one VF mode */
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)) {
 		dev_attr->attr.mode &= ~S_IWUGO;
 		dev_attr->store = NULL;
 	}
-- 
2.25.1

