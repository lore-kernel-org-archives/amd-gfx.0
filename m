Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7568EC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 21:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0880610E312;
	Mon, 14 Feb 2022 21:57:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E88F010E312
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 21:57:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqBVsJmJHJmnE5Z5UAvJYH8D4/y00xRCTwi+ypeHHkF2NBCufsHMyq7CaXX4N6XNZHpneGbMlM3JTGKmb8L4Z3/VyDQcjPCgmAV1XVoAZTLW6gTS8TycXHHcxtim4wT4k2jjENws5lvDoY8Z0B0utLs5rrTwbu9CEXJKgm0tdF7RZnBXV9rjEIm2J88TRYyDm5IDxKDWCBJuadXus0zY2H5e35pD24l4XY/hso+0lJ5B2jgFXHdNi6UJgxADsyT6EEfetO9TkZGdd2c6/f9krk7NEuMh1KqmZ/Y8WuXl6sluMJn8ljUsTNixTf/lY/VnbHO14CtKbypsqbiERHSIlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+2WK0HuSY+nWXLF9f4e8CaRNGZDtoKWuO+Pcgw+mcw=;
 b=FXDrV3WVnPHSqZWheKUcS5UC9FQ0qPDG0SAeGWNUZPhXdZmM/q8rhCmPc6deT+JfsHvSNeZj/cQ+VSWOfixxl9MjP13gcHQqs2jK+betkH26+fPz++7K9oYPT3tcx/aQ73SbEzVnp0FItpX2fnA6849hoih3pqDORauxarO+ArKZ1BxG1e5zuG70j/9i7gYcwkw7KPG/hcBmXMx5zqeUQMkyvKngKJwq0mC4YosPWdY5ZUrgcTBMrEsK9EAZrx15r1O52QJ2HHfX2ZlZbsV6W5OA4vI1FAmglDsLzHmMAmJ+ppaLfHBRCvcsRf2GfsKPgjocKhiMLgmFq8ZSKRTfNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+2WK0HuSY+nWXLF9f4e8CaRNGZDtoKWuO+Pcgw+mcw=;
 b=yZYtB2Q1Q3qKaK5srAd8oc3+CDlIGYw/ouHH9k07HEdFksQExj/Em5ks1PghQDy49sqQ9BYwmPwunUUSlXjZJIYBTgCKZskv8JWr7WhuMkKeiCNwKzLNFSAiExR5/+XjYFGPLlHD52mW6gavklDEw3FGkKG+Goxs1ib6xmTuyOI=
Received: from DM6PR06CA0072.namprd06.prod.outlook.com (2603:10b6:5:54::49) by
 BY5PR12MB4227.namprd12.prod.outlook.com (2603:10b6:a03:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 21:57:11 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::89) by DM6PR06CA0072.outlook.office365.com
 (2603:10b6:5:54::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Mon, 14 Feb 2022 21:57:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 21:57:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 14 Feb
 2022 15:57:09 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: set new revision id for 10.3.7 GC
Date: Mon, 14 Feb 2022 16:56:55 -0500
Message-ID: <20220214215655.2116747-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 624c27f4-1f5a-4e5e-e415-08d9f004f3d7
X-MS-TrafficTypeDiagnostic: BY5PR12MB4227:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB42273A1558D51F7F736E49E1F7339@BY5PR12MB4227.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Teah+3bHQVd8CPWHyKkz+k0lxYWrg9anie7bbzOELW6ro3nn4KyIKbGEiXqoyrp8iTwk7tUP+w+bm6677C2jPnWmBEt862AV7LWt/Q+VDxJQQSrMiB+bsxs47bd+Lqk3E3Rhs9aK+vSZS1RJV1mjTLDTu2MPoajMzoTZ9z8wxvL7XFiffaMEQkb+1e+a1TQsA6WYS1/+Va8gSUQP2fyUQBjJTOpGpDtrhAo6g0Nk8a0jxH4QDXpseuIxNgo+IVGr6d7yaYw7wGBP+f5idmQBZvZ67qjGUlA0Fk8ysb3Ofdt2Bfu7xqTLj8kMRgBOAUARcVbnvRhvQLGU9jjJEx1dl5+ECH5F0Dosg6eQfNz4mzyo426pzLz3E5+O+EDruD3F0jCDz+wiK7cj1kuL7UtP79O79n80U6eIUL+8KllorqHqTvBk9ANJutbvIPaiaxwXvDLuwbc0ke/rvodoe+8hsLYaly4if+jtruTm5O+LPw8zZtExbnnTagUxn7t153zFU5qz+81UyAmq5RzNxqEceyxjgUWqq7k2HTlYs51XHEDfYaoJFyM/FpTjt3gCHYOkY9rz9xhhAYNcfvAe+V4+9XvTb3dutDt85RmRqolAD6HXs1UULGX66xjQzLSyNndKg2DDSvvvh7kmC7Q27CeN16q7IEWUsw4KwRc8iusrewg5Kmknk3glKEUGaM93RyR5c4dUKTVFi226sjpZl0KmUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(54906003)(508600001)(426003)(336012)(36756003)(4744005)(6916009)(316002)(356005)(47076005)(81166007)(82310400004)(6666004)(40460700003)(4326008)(70586007)(8676002)(70206006)(36860700001)(5660300002)(16526019)(186003)(8936002)(7696005)(2906002)(26005)(2616005)(1076003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 21:57:11.0245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 624c27f4-1f5a-4e5e-e415-08d9f004f3d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4227
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
Cc: Alex
 Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Prike Liang <Prike.Liang@amd.com>

Add new revision ID for GC 10.3.7 and set
cg/pg flags.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 494e17f65fc3..8cd1dbaddeb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -905,6 +905,11 @@ static int nv_common_early_init(void *handle)
 		adev->pg_flags = 0;
 		adev->external_rev_id = adev->rev_id + 0x82;
 		break;
+	case IP_VERSION(10, 3, 7):
+		adev->cg_flags = 0;
+		adev->pg_flags = 0;
+		adev->external_rev_id = adev->rev_id + 0x01;
+		break;
 	default:
 		/* FIXME: not supported yet */
 		return -EINVAL;
-- 
2.34.1

