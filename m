Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A5EC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 23:13:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E51010E81D;
	Thu, 20 Jan 2022 23:13:43 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2075.outbound.protection.outlook.com [40.107.95.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D40610E7C7
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 23:13:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1McL8TL5v8PW4OUDqUWdZ86BKYRclL0cEvXxVnAlcSmnpVEIKRFroqjA99lMHgqfrlC7PWHblkamlzYufuCrZnFmssiJeME0nb6mevHzF9zDVCuDZEQiRKeeAmUOL+ZM3c4cz6XQi+JSgu56SvpfQ9CDMT6AOdnOjUj8x03UlMtjBTHXMMANztJ4xKjDQNjRh6hyY2U/GKnDmoCOpKH86ijtmbzL5ea3QQyo62fzJTvW/wZiEZ9yNO4gvbxAMp51d3fk0dMKPCE7bOpc8WHA9aDhWvdz1H81Iuu+vpv+MbyJPseJsFh/MWYJZrxM0uHDHttd/AnT/55HtErH/mnhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCPzMdzbKt14YqiDU58RxWp1SgOLkaNXVjUu8im2mOk=;
 b=f6oCNC6woTfRzFRfMNuUfNoshZsjYMKa62ncHFoTo6mSg3YDrDTxKpD0XIKGQcD3DHUGqqbkjvPb6YRXHAkw54KYlNmCy7eNq8c+b5alTxB4dE4+bzbhxuCBIuMxZnLblkGDMZGe+4QTgL19yYIVATCX82JoHwry+EUfGAFH+3ogoV6b3ynK3gWsfwuduKQBvoPjknGLX3FPcjjVP6b4q4ReUgDuyTp3iz0XBmdJlsj0x+UNE2PlNKC6mWToF3F44PUBDEusFZDlUafWMyN2zmlGCc5pdIqUTulR5b8z65gjB6QxWUjz5ziX4m2Ljd1Kk+cypcPgK5GDyzLI6fLUdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCPzMdzbKt14YqiDU58RxWp1SgOLkaNXVjUu8im2mOk=;
 b=rhThd9PJxtbN16jOSGyozX+91eVA3ECzk73RhTj+dbV+e1eW5L+4slG04mj3iulsW5K0CZ4AJN9S/PtrI7tnLY45XRxSYaJNokQqvbgpf9CIJ+ol4PIg4Z9Vip8R/PAa1fNoNHCIO4yP7cbuXX0yeYYsOW1azWqeKIR67nXd4Nk=
Received: from MWHPR19CA0087.namprd19.prod.outlook.com (2603:10b6:320:1f::25)
 by MN2PR12MB4655.namprd12.prod.outlook.com (2603:10b6:208:1b9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Thu, 20 Jan
 2022 23:13:38 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:1f:cafe::c0) by MWHPR19CA0087.outlook.office365.com
 (2603:10b6:320:1f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11 via Frontend
 Transport; Thu, 20 Jan 2022 23:13:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 23:13:37 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 17:13:35 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/8] drm/amdkfd: Correct SMI event read size
Date: Thu, 20 Jan 2022 18:13:15 -0500
Message-ID: <20220120231322.10321-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220120231322.10321-1-Philip.Yang@amd.com>
References: <20220120231322.10321-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51ea3d59-c702-4d7c-95aa-08d9dc6a7d3d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4655:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB465509E7B232EC46FAE9A2C9E65A9@MN2PR12MB4655.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jXse4eAR9fXH67Tu/BtdBTwfXnX1Jt6KQjNnEXFy+If421RqMJKoADhjWtsZ4lDnu+zuZBnTwSxaQ4pr5hOLLSeOeVXPVMw9AvkoeGWHoy9B+etS/oUYSfr6v7L+tXb8knN98gqi5+yAQgRSDLTE3XnRcxxcnRhQ6Lw1f2WHpkui/isJNQ6j2isX1vxv0nQ0p3Qd4q+aeDM9UZ9PDiD+VR++WdVmC77CyXeUFtLopCUPgbAanCKlhNXrj5wEFJBP0lqTHKReOjFEqUVcbhm55mho+pcKKs8nPgu3GzZ9Dy5fR3IIX4Y3p+05Mk5uigBBIcf85PmtHBcqow4RqIoO3Kz5Wqk5/UN7c0HVUlIMz4T3EAJokTXCmZgjfS65eGNUF7aiUZlqhYMfRri9Q347vkwFWDlba8ze3WAOrd+7vbJ5C2mssDlRD0F9oVDpDLKzZZTlXahkImIY5IbTnn/7ejzVl9AOW6ShqdulXJLTU96JF2T0xYrGqgfcIcb1tmld11ba//xmYWV4YAc7aZJ1MJ+BDKF7awj7i2jq1iYLiFlNYvIyHHuVRGHtQwj9eMU53bQCgXXFp+TUL0lz3lF+Mtkmkqt/g6OiyhacE+fJHZsXuH/0G9JN9IxQN2gT5me9/iohudic2ETskYbtU+sreZnphTOl9PtV4wCOF6YHiEgcBCelVGtnsLI20e3x/tVVHO2VGLXcsN5+Fn2L+bFhHwuaXYhA3W/Mx+Y0Ji768JTZuGsu5bCzWM3uCwM91Dxiy3ltLfQKQG4uFZ4Wqisb92gJRCKrTWLOtS8F3jcseow=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(26005)(54906003)(316002)(1076003)(2616005)(2906002)(5660300002)(336012)(83380400001)(186003)(36756003)(356005)(81166007)(16526019)(70206006)(82310400004)(7696005)(508600001)(36860700001)(8676002)(6666004)(8936002)(40460700001)(86362001)(47076005)(6916009)(4326008)(70586007)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 23:13:37.3905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ea3d59-c702-4d7c-95aa-08d9dc6a7d3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4655
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

sizeof(buf) is 8 bytes because it is defined as unsigned char *buf,
each SMI event read only copy max 8 bytes to user buffer. Correct this
by using the buf allocate size.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 329a4c89f1e6..18ed1b72f0f7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -81,7 +81,8 @@ static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
 	struct kfd_smi_client *client = filep->private_data;
 	unsigned char *buf;
 
-	buf = kmalloc_array(MAX_KFIFO_SIZE, sizeof(*buf), GFP_KERNEL);
+	size = min_t(size_t, size, MAX_KFIFO_SIZE);
+	buf = kmalloc(size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
@@ -95,7 +96,7 @@ static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
 		ret = -EAGAIN;
 		goto ret_err;
 	}
-	to_copy = min3(size, sizeof(buf), to_copy);
+	to_copy = min(size, to_copy);
 	ret = kfifo_out(&client->fifo, buf, to_copy);
 	spin_unlock(&client->lock);
 	if (ret <= 0) {
-- 
2.17.1

