Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90A8EB64DD
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Aug 2023 09:16:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 438C910E1C0;
	Tue,  1 Aug 2023 09:16:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E48C10E1C0
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Aug 2023 09:16:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YG6ybBDdGUPTA2QH7Io5BmzEXmNs0n5Fm1t14oCuowfVeEyMptOmiXjtopYMK+7n6zeLmJdj5DSKksBtK+D7+fuOLfnZvhSUCzw2djFafLDvUZWfrslggm0pQhI7m0gAdduCxLa5euAlmDDIooJX0EWMB9E+z8xLTIRFctdwTQZ+ei6IM0xdkfMOGOVdABYT242x/CsKbvXJu4eLPgrnXmXzUQXFe0/xpidPb/s/lugJHq0//GhW3Qr8+qA/WqobHdOdmaGPvzxioY/5/rH9GPGKf82H/mTjIErDJmVfUBFvwBFsKxSbw9kr1tjgWRNreLH+TQf0NWyggu2sbFNxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUQfFsK58M/ckhhlkiI0KWff8RE2CMan9opiXMRsgww=;
 b=Y0wmlfwF1iXWwlHKMhnFpzDxHiYwnmbaawuHpqzYC8SR21S98F9PibrVscm+DJNSvVlgBovRiBkqX+BnKK9kAN5k6vogHx/xjcEm5/JM3lCRxEFPrQs1coYGNMDcD8P+fUEYTAMzB28P30xd57aAS3ptMtLumoguEImE3dRuQq/NSsVIzS2kf2VdG3J0YNxqeqAAyqa/7U5GgXidQhDYSbbU5LIcPqvPfcbuiR+lr42ziBqMHPTe5pJo2idIU0DDRlfENgvCADHfMmyCLnZxgEaWk3oi2bQJ0N0szxc0Fk1Ay5Vcihmi1MZTbEmLM1aYLTfsK4ezO71gqw9d31mBVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUQfFsK58M/ckhhlkiI0KWff8RE2CMan9opiXMRsgww=;
 b=eGsg8lZR9GYwsN8zC1je2zOQGM8w9M2rThhsagQ/iViVIwHwKMtT66m5IYvlGkrlpCyYdes6flDurs7tA/T7E+dw5J+tKuJdkHwJaa0zJ+pT0IJsTqiYJUJ0gslWedS33w6IyeyS/0ydzcjtZFRn1pa6NOCEfEEJQ/KoMbWbG8g=
Received: from MW4PR03CA0059.namprd03.prod.outlook.com (2603:10b6:303:8e::34)
 by DM4PR12MB5312.namprd12.prod.outlook.com (2603:10b6:5:39d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 09:16:47 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::4a) by MW4PR03CA0059.outlook.office365.com
 (2603:10b6:303:8e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Tue, 1 Aug 2023 09:16:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.44 via Frontend Transport; Tue, 1 Aug 2023 09:16:47 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 04:16:45 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: fix variable dereferenced issue in
 amdgpu_device_attr_create()
Date: Tue, 1 Aug 2023 17:16:28 +0800
Message-ID: <20230801091628.3689529-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|DM4PR12MB5312:EE_
X-MS-Office365-Filtering-Correlation-Id: f637ed31-04de-4f32-6343-08db9270082c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pZc2BH8x6o44WIbhs5wtLAzZyZgasInr5+MUvoqJ0t5Zh7ca2EI7OkoySAfn0vZ4irjNitYIcNN8yvG7qRy0yVW7MgrqQgXbc7+2lqKP0IXrqSI7ybLoHYTCD5jMthFMj/ZRQWetYNwp4HxCrGpWgk89rO5ONctgM5k7ubY2G2Ji0ve5P3T7QK6CD8ZiUvcm4pu5AwV5B59w080cbiVzPAsAdANh78YEgXWUAmUGzwcAbAAxT1PnMQhEhacp9lZ3fQKG6otWyEgqAq/BceXsa+fAu8RlCpAIZ935f0vzBy9QwB3mU4WgfP/K1TqlPpPRs2m/hK0QhgJoYWqBjkKSpO5UAQQQQQ1zPG8A8Cd76RZc5bhSt2H+Vlbr4INB4OjZ90iDg4q9QM+JmhYVDj2yBg/Sw5o6J7+irRwvWr+2SreGELHI7DlMTzrbLUFDMy5qDMD9pfvDDzxM5OwhWUbZl59RNuyulOCjz0VtEQZumiwTonZcbKFr9HGqPL912lNoz2FG03glSj95nraw3bBxbjqW4H8vs6Ew5hzXP/ght0+iti8M1UVV34e/noJSNXSI8juAokQ64Jd5tSFT/TOVoBYVuUh63+Ool+3LQ5ZmdgIdCvbe0+LwRHOtD01hh7s3tqPzHp86igoG9OmVvTH+ZPG+F2AFarHIJLnbVHqvxV8Sl0xvqIhEkzXdn1UgnHN3mNJKt7eaegjvMDNdStgpeLp1Y/4XUDqg5iJryuLnf2LFm3BM2OUp2+zIH3jaMwqOfSbv0EyJSIBZ5qpHTNksQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(5660300002)(2616005)(426003)(336012)(8936002)(8676002)(16526019)(1076003)(36860700001)(26005)(83380400001)(70586007)(316002)(47076005)(478600001)(186003)(41300700001)(70206006)(6916009)(54906003)(4326008)(7696005)(86362001)(6666004)(40480700001)(356005)(36756003)(2906002)(81166007)(82740400003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 09:16:47.2613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f637ed31-04de-4f32-6343-08db9270082c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5312
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- fix variable ('attr') dereferenced issue.
- using condition check instead of BUG_ON().

Fixes: 4e01847c38f7 ("drm/amdgpu: optimize amdgpu device attribute code")

Cc: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 3922dd274f30..383b2b778456 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2171,15 +2171,19 @@ static int amdgpu_device_attr_create(struct amdgpu_device *adev,
 				     uint32_t mask, struct list_head *attr_list)
 {
 	int ret = 0;
-	struct device_attribute *dev_attr = &attr->dev_attr;
-	const char *name = dev_attr->attr.name;
 	enum amdgpu_device_attr_states attr_states = ATTR_STATE_SUPPORTED;
 	struct amdgpu_device_attr_entry *attr_entry;
+	struct device_attribute *dev_attr;
+	const char *name;
 
 	int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
 			   uint32_t mask, enum amdgpu_device_attr_states *states) = default_attr_update;
 
-	BUG_ON(!attr);
+	if (!attr)
+		return -EINVAL;
+
+	dev_attr = &attr->dev_attr;
+	name = dev_attr->attr.name;
 
 	attr_update = attr->attr_update ? attr->attr_update : default_attr_update;
 
-- 
2.34.1

