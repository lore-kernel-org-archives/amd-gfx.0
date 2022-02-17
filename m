Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA159C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 16:36:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 827CD10E2B3;
	Thu, 17 Feb 2022 16:36:14 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2074.outbound.protection.outlook.com [40.107.102.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4A3910E2B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 16:36:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/QjcRuSF/wXxxIDwrU/XeQ876oEuLi9HhPwS8xSQfFkf5dKph7UdTRmQaZ0HLZ62dftnVGobsUwSGn6qnfTFmWp2AAl/HdHBsMgFrifIRhSW5HQjrD4Me8FBjb53xLYmwG6SJdOQKYYdrfpNgsEJ5z15uO6umGBamxO3X15SSLk62WrLTZA/6NxGYAIgwSiUdf+ZwrI3ptIu8NPKChvTa4Df1IiPzfagcmJfUyN6Ba/hAcj/I/adA9bZg8XgHGNzPVBpKIsn3ObkmE9Yhj9DB1+WVbyPptqkrtO2rdcyyCGnoVYqBeekDbsDr4MbiiAVkKYh8Dj9lvTop72JHskBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/n2RNcTlAusJ9E0SiYGCVqRHBh/SSdh5bgoHkqXMkA4=;
 b=eliADyJUO8qaVHwStnzgvOt4iMV6RqT+Vc5sovCPYZdtYUAnfBcc8fcmkSOqN5Ba22OVi2P105VDpvsuxRU8gg/I1M/zSdbevo2kNW9dAhMXKi6lACiRVsdka2z7UHc/LO1nUYgGxvQwNpZuDyCeWGp/QfoK2SoEc89+2WQgGb9C1aoJVDnc6RXJgEibwlxnEvCTuALJnjKrfq14PZ6EWaXqYnwqwOvFiGEQ80ilcWC8kAWd5w6/xbebwjEb1uervPppmHwLfNgHyNGH1q45zYtNeq94uvtzyQgPkHgO2NCzeg/FpT76rwrYjwYNGNTqrMq4LHPjs65G/+avF1Kt4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/n2RNcTlAusJ9E0SiYGCVqRHBh/SSdh5bgoHkqXMkA4=;
 b=JpP2zcII2N6kKpqWLRE7GOqZV0jQT3oTcDkQLhrAYG38P8MAG3W8jd7p896jov0Udrv0Y3SV11E3r9e4wMSfaAKGDtEhufedI0OSvhyFwy+2IWnEzXJ0YgiTH/VL8ulvsIvaYCLgssIDNpXmTG6msAchfepxyB3+9g+nShLTae8=
Received: from MW4PR04CA0152.namprd04.prod.outlook.com (2603:10b6:303:85::7)
 by MWHPR1201MB0141.namprd12.prod.outlook.com (2603:10b6:301:56::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Thu, 17 Feb
 2022 16:36:10 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::b3) by MW4PR04CA0152.outlook.office365.com
 (2603:10b6:303:85::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Thu, 17 Feb 2022 16:36:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Thu, 17 Feb 2022 16:36:10 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 10:36:08 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Dynamically initialize IP instance attributes
Date: Thu, 17 Feb 2022 11:35:56 -0500
Message-ID: <20220217163556.6491-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.1.129.gb80121027d
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97b01625-b6ab-49e4-09d9-08d9f2339ac6
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0141:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB014100F02DD6AC5F9869A8A899369@MWHPR1201MB0141.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:262;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zNHnt1c4D55B5teXuDKrW9g4T8FjNkNnlZtzSAhSm66Q/xjnr+Ugs10WAVbEkYliNoSLagdzys/QVO1bhnvM/QyTjFe5JGfX/gMgwietdSNlf53awh0DkCrXbndKd4eihk5ZaJoRgpDa8Qb3IHi8vRf5gDlgTlz7Arkl0wTzpl3m1gudUDI2US8GTJgO0riCE/pjyO5fS+afKRPkcJorDgMVdllCI75qwKuH0mMpmyG19jFMB0j9oM6If57YdYCiRT9vC1ofh+4jMJHVKTH69sWh+zfy2gR3sOIl+BYPlyTUXBuQpLMQHYw3rZ3Kc+smAJJIZriaMNoE3dhDTd+ekrhmE9ukNTG4PG0s0WvFq2IRUjNvCytQTb0VNwKdgde59tEcrV/hZ9c1sK3eOAVRhfVoCXGZG6wdzv6JDaSFItLbFOdQrwwP0YxGzlFoCYl26doF2SrhQsDkARNh2W6mefIaq20OSiNX8/oxOI5oEre4VE8w78XN8+F6iyZs/ZIvi9dyFOvfuhpiJ6ie8Zvrmxg52+0AZrJMLGE122+4BSQxuuIirn4bqaXAnJ5noPAX28MeQL6W2L/4KFYR4r0rM0043KEPP5QRkagB4dLCOq8ApqiX4dGYi09f6VWtsuKXtLl0y8LYaGfMsQCPiRJNt/ajSjED4ATr893nEeDmVIg2kIm2yxEaZ9AYfZci60eP6qq1aUFNm6P/af/Yunmdyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(4326008)(70586007)(54906003)(2906002)(70206006)(8676002)(83380400001)(40460700003)(36860700001)(86362001)(47076005)(6916009)(316002)(82310400004)(356005)(81166007)(8936002)(36756003)(7696005)(6666004)(44832011)(508600001)(26005)(2616005)(186003)(16526019)(1076003)(336012)(426003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 16:36:10.1684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b01625-b6ab-49e4-09d9-08d9f2339ac6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0141
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Tom StDenis <tom.stdenis@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dynamically initialize IP instance attributes. This eliminates bugs
stemming from adding new attributes to an IP instance.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Reported-by: Tom StDenis <tom.stdenis@amd.com>
Fixes: c10b6aa7417b0a ("drm/amdgpu: Add "harvest" to IP discovery sysfs")
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 6c7ec058125e1d..5848fec5c39251 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -482,16 +482,7 @@ static struct ip_hw_instance_attr ip_hw_attr[] = {
 	__ATTR_RO(base_addr),
 };
 
-static struct attribute *ip_hw_instance_attrs[] = {
-	&ip_hw_attr[0].attr,
-	&ip_hw_attr[1].attr,
-	&ip_hw_attr[2].attr,
-	&ip_hw_attr[3].attr,
-	&ip_hw_attr[4].attr,
-	&ip_hw_attr[5].attr,
-	&ip_hw_attr[6].attr,
-	NULL,
-};
+static struct attribute *ip_hw_instance_attrs[ARRAY_SIZE(ip_hw_attr) + 1];
 ATTRIBUTE_GROUPS(ip_hw_instance);
 
 #define to_ip_hw_instance(x) container_of(x, struct ip_hw_instance, kobj)
@@ -789,7 +780,7 @@ static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
 static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
 {
 	struct kset *die_kset;
-	int res;
+	int res, ii;
 
 	adev->ip_top = kzalloc(sizeof(*adev->ip_top), GFP_KERNEL);
 	if (!adev->ip_top)
@@ -814,6 +805,10 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
 		goto Err;
 	}
 
+	for (ii = 0; ii < ARRAY_SIZE(ip_hw_attr); ii++)
+		ip_hw_instance_attrs[ii] = &ip_hw_attr[ii].attr;
+	ip_hw_instance_attrs[ii] = NULL;
+
 	res = amdgpu_discovery_sysfs_recurse(adev);
 
 	return res;

base-commit: f736148ca7bf82654141a4411409c2d7a9e2269b
-- 
2.35.1.129.gb80121027d

