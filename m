Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115A0C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 15:05:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 928B710F015;
	Fri, 18 Feb 2022 15:05:12 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2042.outbound.protection.outlook.com [40.107.212.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D2FC10EF47
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 15:05:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXvmZPzWhtRDPeQA1Ut7vfj0ILPsABSEMOqRIXOniuwqD3Lor1xEWdweZ1b3QD0W64tMzHEhYILdt/L1m42dIo8GyO/0DQwGojqJ1NtSPz3DslsysbtDVnzL178YS6cqTqOvLVOAFxBeYhlrLLjhBZd/B67rGazTzfxYadH1BAwAMqazC3NFpuk8jDSoWYOAdtWAoP2FbQINr5JcFVv9nXNmVDyisqBdtD2XSMCugRPH/wkBApaDTzGAI5Nz4/6JA1gXXankpRsLhxD8Z1DZM/aDtcJV2mWHGNw+n6FEzJsRlNcNo9styIFpf1GYuKvXWsPQsirSTo2heqNQID2w2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=339kmtldQbK5Q7rlx76fptbJy59GDZZwhCRJHAl4YLk=;
 b=Chks1Zo4Ls2dqyKKIYwq9XNW7Kol00IlkWrUBPknDTUtiQ4dm6Au23/ce98xhyJN1kQ8X4fnpYI7G7YddD1mjtEGvEC43XMpisiWti3mkPPBWPS0hrI/NNpgdz54aFx6P1ows1UJ5CqPvhBZDC2oOSdRq7kUD9s6tFC9ECsWfCWDgfd12ANpa1u67NCUHJwjcv0b5ikDRHTuGbYVRCtXrYeyNv+mKaT74pjYr4Z7Y5ox0VQ/7lzkXOkKjyi1G/e7Inkp44ycM8NSpQb/W71Ppk8uMJ+HpPBcDkK2RII2WjboFAk6AeZSaHfxGQO4wL7S9/d24jBwFihOS6MNoDKNrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=339kmtldQbK5Q7rlx76fptbJy59GDZZwhCRJHAl4YLk=;
 b=ct45opBMTbO+r4Hu2lF612kj1yd3YIXrkXxqLAqN6Nfx/MZuiiZHycvld3vbXmE2dRjwKFS1e/95PRuA9PfRAYg9fpYEUeia1iwSIeG7bpiMk9yD2fI7oXShRZEd4LZg24KK3eW1ID7sRHVfld6BrdwmhPgkY7+kipJbJ6rFUZo=
Received: from DM3PR08CA0006.namprd08.prod.outlook.com (2603:10b6:0:52::16) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.15; Fri, 18 Feb 2022 15:05:09 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::32) by DM3PR08CA0006.outlook.office365.com
 (2603:10b6:0:52::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.20 via Frontend
 Transport; Fri, 18 Feb 2022 15:05:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 15:05:08 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 09:05:03 -0600
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/12] drm/amd/display: 3.2.174
Date: Fri, 18 Feb 2022 23:03:29 +0800
Message-ID: <20220218150329.7976-13-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218150329.7976-1-solomon.chiu@amd.com>
References: <20220218150329.7976-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e54471f1-1c8c-4a3d-bfd1-08d9f2f00df0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1354FC305289F9D480EC1E7797379@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fFHTvtzO5ZW1kmPMFUltHYTPZwd1nOhn/UZ2k+hL7dky0Eh/Kq4+Ujb+12Ofg1vJNoB23F0XBGL/O5uHNJAMtDDc2YvTWaNjdTVEtp6+bVTcfjV6gfWqgDHjFyWEj+JbqmFfJFISozVHAGu8JMEimhMc3S8gcSBTh7ekiypNf3MsCAXa9OrUa2LHiw9bQ54PvDR9VsNTq8YE45ctmyFHcQjBj/CQOLYbUi5JhLG/B6PdzlW/PwmWvvG5/2VJLICtqakCStwSbE87SybqHrASnASFP4/ZrGDqdb9J/1xM3s+32eP5pxzzIoB6WZPgdFRrAgvLH/HBUsbgh/rWp0yBTeU0bZ9UWWMpP9A4KChqSms9ox1PTROJKkaqY/S1+2A516j0dSTfprtgKfx5XH+H3EvTwzoCorEGYukVLamw537B/z9MTMfHJBQfrs8CS/KtG4NyLj470+CIAd3r9vEKMmrfCC8a058CitO+u+SgE8PD0TUs2rF/cnz/PfItbhHrXdiCmZCb4Phv4W/L0eQFDKSAsX9DQbeYDgw4yC+0EemU4LB7wUUfwOIGzjq2lkgiApKMhYY+3j9EnJhBrRrcLH7n+Raw6OpPmrWtJuuIk8fuDVJC777ZXV+078GSf0+Ue7BjN92mVUR+xSlF+JliA+q11O28Wf6bdlgX0aqBXZGDDjprMKyvkyz5GKB9L8t12jfXFLZAi/H9csCKA9/VCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(186003)(7696005)(6666004)(26005)(426003)(1076003)(2616005)(336012)(2906002)(16526019)(70586007)(82310400004)(86362001)(4326008)(70206006)(8676002)(356005)(36860700001)(81166007)(316002)(6916009)(54906003)(83380400001)(40460700003)(47076005)(508600001)(44832011)(5660300002)(8936002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 15:05:08.8496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e54471f1-1c8c-4a3d-bfd1-08d9f2f00df0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- add debug option to bypass ssinfo from bios.
- Refactor fixed VS logic for non-transparent mode
- add cable ID support for usb c connector
- clear remote dc_sink when stop mst
- Ignore Transitional Invalid Link Rate Error Message
- Fix wrong resolution with DP/VGA adapter
- Refactor PSR DPCD caps detection
- Set compbuf size to min at prep prevent overbook crb
- lock/un-lock cursor if odm pipe split used
- OVT Update on InfoFrame and Mode Management

Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c5a36c81d0b8..55d43d642b38 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.173"
+#define DC_VER "3.2.174"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

