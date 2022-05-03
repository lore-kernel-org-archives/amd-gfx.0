Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81FDC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:09:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF84110EA6C;
	Tue,  3 May 2022 20:09:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C37E10EA21
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:09:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTPt7OMOttll/ZrdmlPZAzoJwgnSFHgdXFUJdqYoP3I7q9kmoozk8B/gHBSe8oA7O37tEis5EJcSo0IHxHnbUwtSPzmMbhMs4i0UWXzPuKH180gnvYHVeP2tAEQ5yJ8WWuIv2inIHKdLjX+eOAM/N14Y0arANQnyq1/8NGJGnr+buEvfZcIgst2YOK/PdWStWbFerH/D+wDG8/ZbNkpOlVRA1vWhQJpOuWSxJ/l4yYkiH9tv89DWCYp7FWtESOtGbxWBjpaalKoHwIPnw6xAsIvxUK+yzjcu+W321y+6D3fbY8QvlQgsTfTVX5FGxShr2ZlXobsr3a4eae+I4moygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLrU2DSXH37Adh8ZfUX882rpiiO3zrPRuHa6hjChdRI=;
 b=GTgDCtwGPXdhXX2BdFALeHntJCdiaj+c+PncGe9I1VjrqpikmzRSbdIWN/xHGRdSYh96FePMwAGduVBijKVAWJdGmhzTqD/QzFjeEDJZrc/r5GbSKdMGlmQRKshPL6GBQe4xuhnTjrwr4mJUDz4jDEZ61gPhgnPy6upG0Y/sZBUnr/aCFljg/TbP1Nj6GvNyFOXQog6g3US8506ROHFzL9NbHu8nQvLH86GETaGfZKFWHeicKddnUuBjocp9Hlw2aDWaPYCofRtUNrkWiJwXkSDcLa5vyJYFziuToWxZciIA9/4/4Fz+cs1w2tjnKdJ7kziaTOoRg4WaxGszeewEOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLrU2DSXH37Adh8ZfUX882rpiiO3zrPRuHa6hjChdRI=;
 b=eD7+CAYiLvEfVwfuKVo2XYt0YOkjXmwsQ1pbbwxi+mHmcV83D/XRdjF6/1jM0AF7Q8cywWSr9GXXiZ2WsmH9Ruu5fK6qhxtlOWyr+3uuAb6TTSpP+qmInHCxGnErJS+76CMo/i6zea4DqeY3brLyvZpvvBMzHYs9Fgej43kE7U4=
Received: from DM6PR07CA0063.namprd07.prod.outlook.com (2603:10b6:5:74::40) by
 BN6PR1201MB0243.namprd12.prod.outlook.com (2603:10b6:405:50::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 20:09:19 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::60) by DM6PR07CA0063.outlook.office365.com
 (2603:10b6:5:74::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Tue, 3 May 2022 20:09:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:09:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:09:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add soc21 support for GC 11.0.2
Date: Tue, 3 May 2022 16:08:48 -0400
Message-ID: <20220503200855.1163186-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200855.1163186-1-alexander.deucher@amd.com>
References: <20220503200855.1163186-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 871bb6b0-3961-4d75-bf8f-08da2d40ce9f
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0243:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB02439E1F164A78B8ADBA53FAF7C09@BN6PR1201MB0243.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zQmviuDIwWpBNIsdTPgJUBNQufSViZu9QFDacozkdHe37YsozLh7iTtx8/VDpPYZpAEkaqIGozqcJ3PcDvTvgrORFugKYWge8LQc/eAp4qNraApwqKKx34HDZBY4MO+rFRTc5fpx2RJdycHSMkOkeEUGOWNvxL5FwUTcOsc5Wj6Jr03QrAv8peee6m7swLUIWMdOKcsfqAtpDh0SMOlc5nt9aN9yy36uGe2jv651ArnZ6ijeSYBmU7DgwtiMFqoJy26iHgYKjFyFf2RhoxivenscK6xW8ad13pPJJO3Yy5AhvFAKqcfuVdB8eFPAzDfeGTPURqICV528sIiyYajNk45zCLMkKUedN10FC3Redz7UBfaMQkxYQ+j/5JLh/F81kQvbxX39bBCAX/EruD/n4hIOEQnTiwsaeWupQfN4yIF6BDr5sPfJU5BIqS+MwHpZPXAQp3ZMrgQbeGl/U6+yhsrSPyf4HzSheNaQshq9/rvYH/pS5a8UgXCWhBaC62hO5PmM5KU33Vzbpa0ifqZg0sIgqQT/lGtc13caiDHDioA1QY8FW5JSjkx5B07HJp6raeuB0mCbObZLOzUfHEdcmbKoXkVHyZV1VmxrDg6Npm0p+ptNWu/0O0D7RDfU5o7b1XdQQ/fGcPwC1IpFZWGBt8jbdV0EGyqW+FH29DZcnNQpa99xGchJdWy//f8pouw0GumBhi2V3OebAnY46O379A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8676002)(70206006)(70586007)(4326008)(316002)(83380400001)(5660300002)(8936002)(54906003)(6916009)(508600001)(36756003)(82310400005)(2906002)(4744005)(86362001)(26005)(36860700001)(7696005)(6666004)(1076003)(47076005)(336012)(40460700003)(2616005)(16526019)(186003)(426003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:09:19.2985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 871bb6b0-3961-4d75-bf8f-08da2d40ce9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0243
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Flora Cui <flora.cui@amd.com>

Add initial soc21 support.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Flora Cui <flora.cui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 7804f95b790b..d91bd70028b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -547,6 +547,11 @@ static int soc21_common_early_init(void *handle)
 			AMD_PG_SUPPORT_MMHUB;
 		adev->external_rev_id = adev->rev_id + 0x1; // TODO: need update
 		break;
+	case IP_VERSION(11, 0, 2):
+		adev->cg_flags = 0;
+		adev->pg_flags = 0;
+		adev->external_rev_id = adev->rev_id + 0x10;
+		break;
 	default:
 		/* FIXME: not supported yet */
 		return -EINVAL;
-- 
2.35.1

