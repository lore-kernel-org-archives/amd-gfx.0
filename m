Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BBEC10DCE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 05:26:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ABE22465A
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 05:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DhAQkOhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ABE22465A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F196E34A;
	Tue, 10 Mar 2020 05:26:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 547FF6E34A
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 05:26:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1I06/dbW+YkNqb3w6KxgdZEKyzPrxvrmUx5DXX8LAml3FnYBVGDmnFOuxL6zz4dziD3Ct/tFRRH8cjlOcXxEWZnp/uvyxHjGVOpJ7khGsl0dt1Zx6u6AukTQMGYN5i1a8Xk3HBCybw3Xz3a6s9hYh4z0qe5EMvtsHiRiy8x1IdesknZd2etMdCznJ8vS7GvNWLlnWiPoaqmHVSSheaH5yPDhXjreAFPDwtkLj7th62MmZJ7qz8S0v4n93yKSvnpg9CAJEnVYykPjlFGVCm7vbHxm2dBR7BGobyQ7VQaL7emM8l874jZigofFaQf1ilG3+n+OZRLHavzP2T1vV6ZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Wch1YsclatsPo3/5OZjgQOj6IcjIqo70TwJRfo/NHY=;
 b=HG76EOgFdnbf6t0hHoBlJj4sNHYV/pxPeLqDrQsfCfCpbFw7tEdJZqKJ+LLP2NnleObBXeZpyKSqMpm7oljZd75EZrPkt36wYTeH7uNi7GhdBi0Uy/qWySKAfn7cNL5Zptp4G0AIMkQudJjBK9e1aY7U4zr536yCzpDJvt+5bfmvurYgqtoO3P/0bYF/f8Bx+MQbdNMYA+FNecXFBsZqMjDg+ZbDXwoT6qD2isfLHyap9+mE3g3QnfUGl2a7bu89NrcdGq/MVqBJu16Yc1RZL3Bz5Xav3TQkhpnJnNtIqo9CSXKtVYHQUJ7rncjiF10UxexUI/rFhRapgATN1DJlPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Wch1YsclatsPo3/5OZjgQOj6IcjIqo70TwJRfo/NHY=;
 b=DhAQkOhf2DFSub1e77URyE2i8VpbKQFgDaKwMyoURRDUua3Acw8VIHIJj8wjTSCtbUwBLe+0Xb6mk2xAvN0kXuSmaW/2NX3cEvTD3IxQ6yYooBFp8L/unEQl8ykoYmO0cBnMG0feCxo4WTzYGlsyYkhGMeD2N+qRLzqDPwRyBHk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB3246.namprd12.prod.outlook.com (2603:10b6:208:af::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Tue, 10 Mar
 2020 05:26:33 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 05:26:33 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: check for the existence of RAS dir before creating
Date: Tue, 10 Mar 2020 13:26:14 +0800
Message-Id: <20200310052614.22208-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2PR04CA0065.apcprd04.prod.outlook.com
 (2603:1096:202:14::33) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR04CA0065.apcprd04.prod.outlook.com (2603:1096:202:14::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17 via Frontend Transport; Tue, 10 Mar 2020 05:26:31 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1ccc70d1-ba9d-4b78-b7ec-08d7c4b3984d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3246:|MN2PR12MB3246:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3246CD1C70B9E300DEB0674DE4FF0@MN2PR12MB3246.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(189003)(199004)(1076003)(6666004)(316002)(2906002)(36756003)(6916009)(7696005)(52116002)(2616005)(6486002)(16526019)(186003)(4326008)(26005)(5660300002)(478600001)(86362001)(8936002)(66946007)(66476007)(66556008)(81166006)(81156014)(8676002)(44832011)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3246;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MiyPXmRwdSIpCUC/YYAlCoQwlLyxM6wPO4WD09fu229FnF7V7UiNOLGH6GN54zZ+ubcWCIsggu4y1hMfG+GJT1y18JPEOWlWAkYw8zmyKLFKbdTXxCrIMvvjqC55q25tZudd7VBa3HJLqyNrLYidvzwgGCxvUMFtmf1j4QgzpoiQJwjkW+55BSi+rP5wqDraoOLD51Zvln6RhtRdHVAn8ehokV+SIBunq4l/+3I/4fZn0S2VRcmYUMlw1TjjSQX9bHumgrNMCo7OtXTaah8SQXX2ULob4SVy0FnbazWipjF263Tlq6nYhRHxpbqmWsamLw6BKTciJfP7LHVt8RuY1TP6l1Yt/+OFmEBl7uR6Gy02oLsvaZiXeNUkEEj3FVp/tRaTl4tMGUrXY7idAF0zU1tAOzg/bhz1/s/kWgSBswflbIBOY9r2gb9HKehzTXOS
X-MS-Exchange-AntiSpam-MessageData: Ur7VJ9gdjs5MomelDms7N+O1p0mpKiw5YXCXZhPWW3W2Au1YuWTN9LHrHQDcigxd1MIO0rtxg9dbOYdYSVy9wZ2w4KHxvrmvBlc/mbqgfNDXNbY1eAqgr+iOZZMIhScE7h0Ccao8LWZt35i3QoO7pw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ccc70d1-ba9d-4b78-b7ec-08d7c4b3984d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 05:26:33.7400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CXESiX77XvfgDfMQXM/wwCo1insizuXj8n9ym0Yn/+IiZe7HiuPuzWZUL5s9hcq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3246
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
Cc: Evan Quan <evan.quan@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To address the error message below:
debugfs: Directory 'ras' with parent '/' already present!

Change-Id: I2539e89fdfe4e22055c3be5a48a8c0adad315f91
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e1e8fd4b2b89..2195f6c63b50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1075,7 +1075,9 @@ static void amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct drm_minor *minor = adev->ddev->primary;
 
-	con->dir = debugfs_create_dir("ras", minor->debugfs_root);
+	con->dir = debugfs_lookup("ras", minor->debugfs_root);
+	if (!con->dir)
+		con->dir = debugfs_create_dir("ras", minor->debugfs_root);
 	debugfs_create_file("ras_ctrl", S_IWUGO | S_IRUGO, con->dir,
 				adev, &amdgpu_ras_debugfs_ctrl_ops);
 	debugfs_create_file("ras_eeprom_reset", S_IWUGO | S_IRUGO, con->dir,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
