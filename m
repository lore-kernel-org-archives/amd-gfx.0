Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3253C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 14:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2B5B10FA99;
	Tue, 28 Jun 2022 14:51:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E7B110F9D4
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 14:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVdIwSTw/k5T296/T9G+pgiNpqXVVg0al1AXCfDDUelgFyF2qUSAfrfR6yCqlOPTe/8yVS3M1A9vkEr7tB6ojn/rkM3yncdaRf4JM1zowuSECn5gYeH2kN/B88dv3cs5hmHGKRjJpyxcGtW+Z5goLKNVo//M8D89Lsg7LaM+Tmr0F/5zOCXBxs8B/9ZfN1iPT7+dwccWTWYjFgGlsRxrh7po3GmOFwyfM/GfHLIBHIbpF14XdGQ4jPgD3gdyGPWBmlNlN4teFPxmhaKg4F5IKJEBO1gGlAntd4LwTqq77z9I4RGEkP7lnsnXQvnoNeQTCQgiObnN7rezjVfRWQPhRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URCGr5eL0eWKccGUF8/E4RYgnZso61Al35JvwZ8Sh6o=;
 b=KIWFftXs1tQZSbmJ5oZh4ZnlbO9BAGXExizqXy2z33NTR1lAzb1w4LKCOAlNDCf3w2D7SuQ8gyAvMHJo+9HPNGGv0o8WZm2TyEFFlKl/jozWXbh+px8Rzc9NuLRFi2BJBMTEb6atUzFiisNHcPMXbY1A0gq9dwm9KjRE1ohN6mQDbaOgQ4xzON8b4RSYM27jQtyAcFIUoS+IhZa1XgNdoRmh2KnoeGGgJKDoIJuu5KawHZ+WKqG5Vgl+3bE76rEn9E/9tN5tVRyZGNIo/TdVT9fdF9MBHxkbO/FnAoHpSy4ATlVOaSbHwv+30xT3X967jRuwWNJiToCLPbGWRoWN1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URCGr5eL0eWKccGUF8/E4RYgnZso61Al35JvwZ8Sh6o=;
 b=IrMO4+eK0GZR/WD+AxL84hscRIi5FZkCgCUdqv1GC3bzS5fCj1hAYYYNB344MlPIu8o/ytulVouE0H1UPUenrl8E5joe5PN7C0F3oxtEUAUV7C8HvkSpr0fdsolhfXi5XYan5lNXMHFsu0ZYy3BO5OeX/9mSFKf5GjtPFucMz38=
Received: from MWHPR17CA0090.namprd17.prod.outlook.com (2603:10b6:300:c2::28)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 14:51:28 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::ec) by MWHPR17CA0090.outlook.office365.com
 (2603:10b6:300:c2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Tue, 28 Jun 2022 14:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 14:51:28 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 09:51:23 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 7/11] drm/amdkfd: Asynchronously free smi_client
Date: Tue, 28 Jun 2022 10:50:16 -0400
Message-ID: <20220628145020.26925-8-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628145020.26925-1-Philip.Yang@amd.com>
References: <20220628145020.26925-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa561ed3-e508-46cf-470a-08da5915ae9b
X-MS-TrafficTypeDiagnostic: MW3PR12MB4460:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kxxdbtwbXe+fy2v1byyaIEgtyn3uP4Ie4qCBZ0LCZ16JVsGNC1pTLACHQtEwTGSDowQy92MXG5qAZZO0l34SuKvlrRN4ju3bw9LZaHit17S2v4Wv2DKPDIT5z07Py8eTRi3rDwfFtG3onynotzXTr8AgoIJbZMeXq5Isbg0Qd5OEmkecNHUcVCc0aVV0aqne4npz1/06ERN8Ro+Xd2Fo3ZY1SR2kIPyhWSHnCRUjcDHwqkcj0LnJH7nF5vt1Ua0aflsW+FSElkR0TKYDivOeiIkNXsqfcTx59PrRUZ7l+/dZlopzB1n5kxNTM0//cKar3jU7D7cIP0nsrVDkI1slR+myiowrBKLGfDGUBxoMezlBQkRx8jT2VR1lKkc2Z+rNzX533Tzpk4pSfVMcFc8eY7if9z0s6h6R7rJVqGPrW1I3Qkd1A31vOBD4vKzxDLVqlhPzQeBd8Jl0ts+3vnDd7rfA8nwrWoeNRn2M6MXBIlWb7iH1OOkNWcG4wlJ4Nn8pL1vKeepM4VrVbRZKdxtOrIAlBp8KD5gA+A2gOLGKlEUoTLH8L49HLOywghOCuwdDHgbP/fagu08Mh43zyblvpcpoy1dWft+EuFa+CqRrYEBtdTysjN0omm0//vo28mJe2nUX2plJMP+NRh6iQ87qIZV+dvCNV/toHDQJxWSmhdpX9dKHHrgmV6AsnIeym5Y+TGKMydFITymU6JnPjcE9Fn7755lkAnDQ+Hu/4pnolE4VKH8dgeO7IjyIV6NVxEatFuzX1dyOazER3uwU72kZiWMg56NyX1exXjQNvpBrtEmdj6eI2ZqSwsdKBJ16GEPN0swv9Ls+GjBGoGAy61CrBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(376002)(36840700001)(40470700004)(46966006)(6916009)(82740400003)(41300700001)(36756003)(5660300002)(316002)(47076005)(2906002)(70206006)(2616005)(186003)(82310400005)(40460700003)(6666004)(336012)(83380400001)(54906003)(16526019)(7696005)(478600001)(426003)(356005)(1076003)(86362001)(4326008)(8676002)(81166007)(36860700001)(40480700001)(70586007)(26005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 14:51:28.2912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa561ed3-e508-46cf-470a-08da5915ae9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The synchronize_rcu may take several ms, which noticeably slows down
applications close SMI event handle. Use call_rcu to free client->fifo
and client asynchronously and eliminate the synchronize_rcu call in the
user thread.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index e5896b7a16dd..0472b56de245 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -38,6 +38,7 @@ struct kfd_smi_client {
 	uint64_t events;
 	struct kfd_dev *dev;
 	spinlock_t lock;
+	struct rcu_head rcu;
 	pid_t pid;
 	bool suser;
 };
@@ -137,6 +138,14 @@ static ssize_t kfd_smi_ev_write(struct file *filep, const char __user *user,
 	return sizeof(events);
 }
 
+static void kfd_smi_ev_client_free(struct rcu_head *p)
+{
+	struct kfd_smi_client *ev = container_of(p, struct kfd_smi_client, rcu);
+
+	kfifo_free(&ev->fifo);
+	kfree(ev);
+}
+
 static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
 {
 	struct kfd_smi_client *client = filep->private_data;
@@ -146,10 +155,7 @@ static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
 	list_del_rcu(&client->list);
 	spin_unlock(&dev->smi_lock);
 
-	synchronize_rcu();
-	kfifo_free(&client->fifo);
-	kfree(client);
-
+	call_rcu(&client->rcu, kfd_smi_ev_client_free);
 	return 0;
 }
 
-- 
2.35.1

