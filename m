Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8478C54EBC
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jan 2023 16:25:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78FE910E2F1;
	Thu, 12 Jan 2023 16:25:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96E9210E2F1
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 16:25:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jh9oExEZc6YLkqbUncGaOv0tnzFAjfw8qFEU8kXWilbDTUB3VdRSGtIo1iJGf+qgmjU8O/wpPtXovjQJ8gMhZ5iwCKAK+SNjQ1u16o+LAJ1LgqbN7ZjBph7MSQj8mXwvawJM3QhgGg96YvwHlZSGR1fHSBH+HR05ym4HzvYhC87fkVuqY+JAsZpQGorN+DztVkJ8Gkxb3dzKpW7fHI42K5DW8K0ZSatgsAeQlHAltFqP3ELEkFazVwzQQfauzmvT7cekF4HTUhvSerNct3gqJ03VbqjBPzKlQNWRScIwowUbPKFUbQ1EkUZWDRIeOEtTKFcMiYiT3NkDYZBWwRbEjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ca8679WFp/lK6ifd9qAnzlb+P3KeWXZAP+IVtk459Cg=;
 b=f3/f9gh8LDGuHv1zpXUaiG6R9yEKoeVl7IZif74pzU01K3zgITEXauZZbGPAlZNWOKWXK+1Y611DgKrUtK6RrEcLIYdFdkRUr2fUdwWEW7e07Dxgz3bxoM3EmvzfuH+ot9aK+gG0sIDOTnJ9NZhN2Crilt5aazl4qdls8Ab1j/MhhlU4PYyeMlqYKRBjcMWToa1CKoKWj3aBbQLXqHiRusyvtm+l/WlgG8AOnj9SNGtr9b7TGrJbDrIT4wrjrvaIJQfrrI7kC/wGKuuDEzii830OvptwE+oizqIxdM7J463ZFJW5nCML2aW3/+Zd37UwI7HGgN3G+p3TrS0q/n+h9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ca8679WFp/lK6ifd9qAnzlb+P3KeWXZAP+IVtk459Cg=;
 b=TEakxVFyTI6RkuuKwKz2lIGFnb/luJtoLR/7yEVJgcO2gt6kI1Lt9f/sZ9Ub1TPlxye1QmkRCb5a0irz8H7/bySYmLr1m7D6gXhemf5IKzsNszl6kN9/BTZAFj5iMTf9+ABRld+/ur7JrSgWMt1/SxoqUSl9DTZynV3yOU0e8Sw=
Received: from MW4P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::29)
 by DS0PR12MB6605.namprd12.prod.outlook.com (2603:10b6:8:d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 16:25:00 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::d7) by MW4P221CA0024.outlook.office365.com
 (2603:10b6:303:8b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Thu, 12 Jan 2023 16:25:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Thu, 12 Jan 2023 16:25:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 12 Jan
 2023 10:24:58 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/smu12: fix power reporting on CZN/BCL
Date: Thu, 12 Jan 2023 11:24:42 -0500
Message-ID: <20230112162443.603552-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT111:EE_|DS0PR12MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: aac873fa-7696-4cc4-196f-08daf4b98d5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VYr5BEl5Z9VTiXWSZwfDAJrMdctjwGLmIlk+uF30sMUK7aRNirR5EErph9yaFwU2Nv2uPMX0RLsRf0Q+BwvDgOZjfiiuts6CfipoWFeTmL4uYkRjMcqPIe4ozJOCFJuFsVh5NDkdIWBBF0Me44V/ncqzHfzlnKL+B9db0KleYNePyqyAQV5qKeQLUqwB68oaDuyPhgj0of8CtTmVC4qWd/eJNB6ycMY1eOwL51Jt/BaOgVbuh82pTMW9EXv5LQDVG72VTagLcrARkj/TU3t+lDEVWy9tbr4kWbS4gHxzAGK5hKAMHfGMWLrAKHVsTjkonYnWoTeSen32q7otgvZiSMfcCfo5g0X+pJxwTKrWkkXARHcOLapQpROQymK4CzKOsKPE1sPn1mcDJcvmHv/je66MrCmu8psd/VrrttuVFSZCjR6o5IEcAD8dmXg/RQHW+Ne/vcPXuloTj9mNsNkdk4yjv2WtN2hmWqAza10RHguj83U/n6z4r1yqiTOkDDK/i/XZ/iqSh6mhLgZPMTTNxrNLjTYMqIOz9Yxb5nmKUzgdnfX1yEDs3fZgB8tuOVVzp4c0F4M+GyTj8Qgs5O/zvWQhi11Y9tfrVM79Ai2iHo2x2365B4M9Gylz+Vc32Q0ItSNp0xC5u+/AYtu03jNhjOH7qSuWQWphBKNkvgwyREV/X4GkBnOlTX9FSZfG3tgi
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(82740400003)(6666004)(81166007)(2906002)(356005)(966005)(478600001)(2616005)(1076003)(16526019)(26005)(186003)(5660300002)(40480700001)(316002)(7696005)(86362001)(83380400001)(8936002)(36756003)(40460700003)(82310400005)(8676002)(41300700001)(47076005)(426003)(6916009)(336012)(70586007)(70206006)(54906003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 16:25:00.2403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aac873fa-7696-4cc4-196f-08daf4b98d5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6605
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
Cc: Alex Deucher <alexander.deucher@amd.com>, jesse.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The metrics interface exposes the socket power in W, but
apparently RN systems exposed the power as mW.  See
commit 137aac26a2ed ("drm/amdgpu/smu12: fix power reporting on renoir").
So leave RN as mW and use W for CZN/BCL.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2321
Fixes: 137aac26a2ed ("drm/amdgpu/smu12: fix power reporting on renoir")
Cc: jesse.zhang@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 85e22210963f..77308d481c54 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1196,7 +1196,10 @@ static int renoir_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->AverageUvdActivity / 100;
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
-		*value = (metrics->CurrentSocketPower << 8) / 1000;
+		if (smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(12, 0, 0))
+			*value = (metrics->CurrentSocketPower << 8) / 1000; /* mW */
+		else
+			*value = metrics->CurrentSocketPower << 8; /* W */
 		break;
 	case METRICS_TEMPERATURE_EDGE:
 		*value = (metrics->GfxTemperature / 100) *
-- 
2.39.0

