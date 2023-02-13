Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6C8C636D4
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Feb 2023 10:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B59C410E1F6;
	Mon, 13 Feb 2023 10:58:41 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C96B10E1F6
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Feb 2023 10:58:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMMEgGt7LHO5MUIIDACuJsdZO7dWYOBsyrgt+kyB0YIeDLdwvGS1Ws3luzI/OP9H8nYQMtDX35N9DhhwXVfReSbQC+NIZCt3+hnUaWmmvMep/A+nit1in5wkHdaNidXLmrkpIdQ+wpbiHRiwrbRbapY9RiShms2Dpf6a7/38hV6uS+XYXNgNKrqJQRloplJ30l4L5VtMOWwVI6HreHmbTgAy00s0LWHFRNO9/MmkeiFI5eXeCDxeItROF8OGMzW43oIiebzH/uB0HSHpUoJaLaOOb7q2jTjxNabupGZaGcoVZ4paiQFw3pu9VoIjg3KmYfbRvjqMQs1Vr6PQPD71xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3oDpdiZHL224fzcI0cdPNCpukiviFtSk6D9UWNKjdg=;
 b=KeYl/74W0u9D796OKQk4sYieC75olcP2CSpVGdhqnL5IOLnVrRhz3b6eVEsyLYQZM+F1qOttL+AXk/ASF9di7XjF+BBGAO7HdYkmiEOh5jvi1mMpZ5v8G408/eGGMsU4G6U1Tj9y+hZZ+940cDa+jZiaWoTNEpv2FrylP/IiOmwnJ9Ue06cBwoxh/QLDoh/5DKCNCJk2YDYTGT+fhHcaztkao9KIrO8WhGBq3TSbQULg38yhlbkuEDGnhuqZyATNOM5UvXmLx1SMIFYnqY5Qt446chllWF+WdwoMNN6GR4+yT3+Dy532AKznv9ClpYCp8nwALhXospgOmPOaYBqnwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3oDpdiZHL224fzcI0cdPNCpukiviFtSk6D9UWNKjdg=;
 b=ohNy93Eot/RkDTBJSKEt46AORNjBKlDNly8N7QrOCBEFfPr98iNRuK0UFzLHxqzmEH6g4oBx/NgDLdIMKHdb6eB3iLaF0/bLB0qvdRoshXax5KHDlprcs5X3KkR3JY47J/FEcj8BWKs0InYONwMU4I++9eS4IuBRCEYpJHyk0aI=
Received: from MW4PR04CA0096.namprd04.prod.outlook.com (2603:10b6:303:83::11)
 by DS0PR12MB7770.namprd12.prod.outlook.com (2603:10b6:8:138::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 10:58:39 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::ae) by MW4PR04CA0096.outlook.office365.com
 (2603:10b6:303:83::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Mon, 13 Feb 2023 10:58:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.22 via Frontend Transport; Mon, 13 Feb 2023 10:58:38 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Feb
 2023 04:58:37 -0600
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: fix warining during suspend
Date: Mon, 13 Feb 2023 18:52:24 +0800
Message-ID: <20230213105224.55662-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT048:EE_|DS0PR12MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: d1112505-a06f-4215-3e78-08db0db1433b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rSYkPeo/IyU2huYjbh2NbYJZMmnkgj6Fr0onkoWabM9quJC1NIEty3pNuUkTeg/mPpMzPK0AVzlmENAVpoYtDazF2fghJ/K3TFUE4QeKTBdiGyg8xpLpnyjJ1O20ptQRA/96+LSqpQKjHx0OQNjn0ffPvdZj8+IuC28CVkkqfCor88sUo0DaTRSpF7oAMA247ME2axf58Qkn/q54j+Ut5CSWvlkULo+n2OYklRm4J5tl6ZR9v1ls3XBMK5U4EmqirIN2dpaZn3HCGq9/eH+xbPJNmJG3zu7RoPC7Pk8dIFL+4ofu6/Lg9KKoguLx2RZLkeq6wHyhhYgKNYB1F1sPI9foUIHQolW+AIYEUfoPBWKNTNS6LNvJXNYLQSDlF1nMOBFOj3Yb1CsXgk8lYHSrGMmAy/MHbxflsDXlM4G23hJm3lnIzowSDih78fB953nLXcwR2wkRXtcB/Ee1tRkxehdSVyMh+8Yw0sz8OqgUzOnLPRTJt6PKSXGED7C9WFq96+jKFXnS1aLfWFjOIZ3rpWtlQ5tyV7G3WAGPyWDYz+4FNdNQyWl63mooIFLHp0CIsNxCvW5keP2uKlEPBXjY4iFSr+6SOng2PRgFYJQ2wUu2lXh+XuFdbUjcL5MCl9tiruirPC0FogjZCJtkXB1FByv4CQ5y/NIgu1j0a2SblE7jFCWbFp1Zo8BWBrJcV2+7l6YvJdp7z6y7fSKHg9b0Jl387abdlgE6E4z0aOjHQ8jMAOtuMOnp9orKT62sb+s/5I6yh7S4IvmZXOEwnhGe/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199018)(40470700004)(46966006)(36840700001)(36860700001)(316002)(83380400001)(40480700001)(40460700003)(4326008)(6916009)(70586007)(70206006)(2616005)(336012)(47076005)(36756003)(426003)(8936002)(8676002)(7696005)(356005)(2906002)(82740400003)(966005)(15650500001)(478600001)(86362001)(5660300002)(6666004)(54906003)(16526019)(41300700001)(82310400005)(26005)(186003)(81166007)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 10:58:38.9979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1112505-a06f-4215-3e78-08db0db1433b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7770
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, jfalempe@redhat.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Freeing memory was warned during suspend.
Move the self test out of suspend.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2151825
Cc: jfalempe@redhat.com
Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c     | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a10b627c8357..3842e7e62eda 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4270,6 +4270,9 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	}
 	adev->in_suspend = false;
 
+	if (adev->enable_mes)
+		amdgpu_mes_self_test(adev);
+
 	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D0))
 		DRM_WARN("smart shift update failed\n");
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 62cdd2113135..5826eac270d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1284,7 +1284,7 @@ static int mes_v11_0_late_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	/* it's only intended for use in mes_self_test case, not for s0ix and reset */
-	if (!amdgpu_in_reset(adev) && !adev->in_s0ix &&
+	if (!amdgpu_in_reset(adev) && !adev->in_s0ix && !adev->in_suspend &&
 	    (adev->ip_versions[GC_HWIP][0] != IP_VERSION(11, 0, 3)))
 		amdgpu_mes_self_test(adev);
 
-- 
2.37.3

