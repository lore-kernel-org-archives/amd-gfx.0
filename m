Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2648C6FA8F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7884610E5E1;
	Thu, 24 Aug 2023 21:59:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 251EF10E5E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:59:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnULM5L6P7JrxqL8X63qG6VBJZ2VhqKaHz7Q3XrzIWZiq7sjsQ4QK2NyVaZr85DJjeGEpnlE8ravgDKcOzHVqeYzxbly30TeFy+RJlZLnaQkLNGrmRDSXCclt8gNTVDoxcwKsmkiILrYy4WwOvi2o4W9aMXoIRwS1la9xDoDwrEXhpJWlNKGVfv1pJSgoeKz57XJKrjlj3UsFyNRA0zvXuL3vBu/1MwbgG40vdDtdztrsHxE0COZ8XxObm6ypMs3kbwrxLQr/GhWC8n0U4kM9fi0XoA7owTZxEbifkCtaFl+MgO58txiv4EFmJnPCA8YkQQbBPb4OUcMl3ibxIdevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oudO4fe9xJgroWgtgli+MmUFZUwPq8tjy0kgvraUUE=;
 b=IoukJ+4n6XqW03wBUka0ekuro6loGFTT4bZBRTzzJVeKZZYyWp3ROvtYpVYwNjG4AnZ96vEn9IKgNrMKFWIP8p5KLXDQZ+ecmVqjIP9JdwWvmx+fIKjkb7taR4mGiTyjlAZAp832cXxJkvE8iaNLz5cFb4eRGP+rDHMQWsI/RgMlbQQo96qYmyoZ7tQG+SZYaSl0krYo0H8CZakrjyZdlg/XG6yNWNyVE4f1QoPBKOOnW46MTRFu1E1L7DrHwjz53XAC6IFD1U3ymurGtg8E+aEO9YHt9evxaSDIgpRhjo8y0DE/S777Qpq2TItkD50QYC7Q0B9FKMYW4b/XAY40jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oudO4fe9xJgroWgtgli+MmUFZUwPq8tjy0kgvraUUE=;
 b=ai6vGfyC16u3wvYcH2iQfO5PV/vQXy181pDn/ZAwjVRLWbA2Q20Htv0EMcwSfTJnW/dQU8vATG5UDtqVTe236o7DrhvhcMlkLJTkFvcjrjTEVNE6pGqDtoFVoY2sdg/MYTWzcQZTPpy0qd7nXcc9+shAPV4rMW0DbREgLVm9o84=
Received: from DS0PR17CA0018.namprd17.prod.outlook.com (2603:10b6:8:191::18)
 by DM4PR12MB6398.namprd12.prod.outlook.com (2603:10b6:8:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:58:58 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::d1) by DS0PR17CA0018.outlook.office365.com
 (2603:10b6:8:191::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:58:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 21:58:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:58:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/14] drm/amdgpu/discovery: enable UMSCH 4.0 in IP discovery
Date: Thu, 24 Aug 2023 17:58:33 -0400
Message-ID: <20230824215835.2740115-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824215835.2740115-1-alexander.deucher@amd.com>
References: <20230824215835.2740115-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DM4PR12MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: 79f8ed4c-0d7e-4bfb-589e-08dba4ed5135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4rJhm3FjuA+Svir9AmuqR0yAFKphd1upv0cJrOJbqrIeTEpqy8xI8KXNlwKM91eU7QZljP/aTRe4Wgynu2+lwVM3D/t20/NLtnx+G+O4UYtBbceVFfRbSUjdkWz8ZDgEj2VVXJ9QrswOeqWewh0yB3L7eu/TjthP17jhJ7xERjJAnTwraNU8Xw9F5ZazdoOmJpQSaUV3RqPOiYoykhxase7/Me4vfrDpJdhDzY8GNQlHLhjJpnrhlMNuk2BP2+z9ZTEY29RWvBUQjGI1bZAQZ6sgPZcJy3fVBPAK0VW6cO7JT97HTo7ImhISFVRz0xrUNAVcAvOwJM7loF2ZOFzc/3dZ/YvEsO+4DV6HnkWSQsfY0hK6qoJkEk2QW6duLJiJ8wVPI/2vPtgZ0+d3ZxGin0JhNrF9wlBaRvRJBxsDHC6cJ7TalGS1g/TvvLHhtfzPICyKv4vSIe3eXVasp8Nnn3ODDe6uMRuRnrKG+Uyy/6uhoDhZJHWi/+49sC8C8s45k1tK58GXwppUGkq2FEpRf2VY9R7/yxlXCQ2AWnZawXkUZJV06T9tmTH4MELIBWDDZLsfi9hJQzTwNESTfHO/hxXg6dlnONFkr803EFLHk4GX/wvxsNkUzYQXe/VtfckVbRogl1qCY0x/PEXJMRSVddCM0sSztssd6QwvviWM/C/BbTsWMYHgzpyiHRGGdkJGSl0AD8Fl0rr/q0ToOZwU/SfBSsrVoBrBYWs2Y02eJYcnoxEspgCaxnBwb/CpSfh31Fv24tIPaH23VgtlpDxLkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(1076003)(40460700003)(2616005)(5660300002)(4326008)(8676002)(8936002)(336012)(47076005)(426003)(36756003)(83380400001)(7696005)(36860700001)(26005)(40480700001)(16526019)(82740400003)(356005)(6666004)(81166007)(70586007)(70206006)(54906003)(6916009)(316002)(478600001)(41300700001)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:58:57.8618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f8ed4c-0d7e-4bfb-589e-08dba4ed5135
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Veerabadhran
 Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Enable UMSCH to support VPE and VCN user queues.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 0bf3bf94955c..783f8d50e499 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2159,6 +2159,20 @@ static int amdgpu_discovery_set_vpe_ip_blocks(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int amdgpu_discovery_set_umsch_mm_ip_blocks(struct amdgpu_device *adev)
+{
+	switch (adev->ip_versions[VCN_HWIP][0]) {
+	case IP_VERSION(4, 0, 5):
+		amdgpu_device_ip_block_add(adev, &umsch_mm_v4_0_ip_block);
+		adev->enable_umsch_mm = true;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 {
 	int r;
@@ -2650,6 +2664,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	r = amdgpu_discovery_set_umsch_mm_ip_blocks(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
-- 
2.41.0

