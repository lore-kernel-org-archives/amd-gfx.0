Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB1CECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:20:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6C0F10E857;
	Wed, 14 Sep 2022 05:20:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2AA010E856
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:20:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+QnQDxgaT/d74fFLvM+KsiGKCTmSFpGAEcqlwOt2flvndiOwGtE+n6cqalVnpS7nQUZsfEAGqryQwJPKgSVzkg8y/hK9XdmTlXZMFI/vOQwC1Ecli2NF+x5hq5MvlGvzu0GQ34QON6jZYTHL/9NqiKeORjR2FBEjZ4/s8jt8UKt9cufo1/ZUNboADHHvZ50hphOg6Cb64kF98UrZTrmsuJhTtFXHz6/SN9AwNH+X0AW2t+n4Uu4SLgy5CPWskA4TzM/aj9nPeYJhL+tNUJszWWyiQLcgF6VRIS6gqaindhNC5HcnhoQJzvP1aIPvPZjcduf9EfWcutY9s54W0hkNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zqc83k8MbiZcZ4UYpLz61sm827Rd0xZFVXbhZY1XBs0=;
 b=nRODuFu5BQ4dg2t9+U0PSAsT2QHy7/MUWYUsZp32mK7cf1sdG158fPqo3/V0R+mfMMv2+zrIkyt9QmiIrP9PP62etyKAlXjMSgxSxgIrCVlp7TOQ3Uw/Jb5p3z8DNxhSwEETP5jctVuqEChetVns0gt3hUKc3XEMQKBVfqHXekzx7ll/2JyknHMvxzvQPvp4ZpA1r4XBNcXpLTG0/+OLahXNemGW/1FyJE0lxRDsQFgs519JUW4gYbRoJrZ4X2HOD/q3PTi35OZfuF/CqQKAeJjLVbJ+PKuM1ePSsgFWh6fjAZ9bx0enyMjFV7AI++p8pXA0s9UjbVyNJa5ZZruHEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zqc83k8MbiZcZ4UYpLz61sm827Rd0xZFVXbhZY1XBs0=;
 b=0qZoDPqHj1nW2N1GM216PenVX+w0YM41D5UVP/GBrH6NSieSr1u/Lw1JJGPe0Rqvm5b1zmloSqFhZMmYPiVp2hWIPkObwGHtX1lL/dadyOKOx4SLse/5JV0lEVmT/lJqqNWpEWii8KhFedfoXBYa+KdzBDPk8NNUAyDbb/MRn18=
Received: from MW4PR04CA0106.namprd04.prod.outlook.com (2603:10b6:303:83::21)
 by DM4PR12MB6376.namprd12.prod.outlook.com (2603:10b6:8:a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 05:20:05 +0000
Received: from CO1NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::fa) by MW4PR04CA0106.outlook.office365.com
 (2603:10b6:303:83::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 05:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT102.mail.protection.outlook.com (10.13.175.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:20:04 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:20:01 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:19:23 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:19:19 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 47/47] drm/amd/display: 3.2.204
Date: Wed, 14 Sep 2022 13:10:46 +0800
Message-ID: <20220914051046.1131186-48-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT102:EE_|DM4PR12MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 63f43620-236b-4cd4-bf99-08da9610c842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: snWnPiOAN5uUw82oA0fyQgTalzhTtCW9nzfihMOspTttD0OsMbdhoKohwA6FR9gq5RtyjgrseGBCM1AhcfoUpHBMMcZUVf1yRpxyW20/zegi3FPvlYfiDmldq7CIltfT0Ohc/M/oWSD3akv0744g/FpBYnaGDHzzLFnJQBGiIh7gWPAzVG7EFECAfojhEjHc4hUyPgFTvLPAe9gGaP1fCx6MY6CmeWxHFxEs7v165fCp3ZgTISqIICDR96HzXxDY2bRGed1a8+zI+xVUrQ6jx+NhjSK2Odfg8Uz5Ii/rZTtpnkVkN5f4Yxzg4/PthN6W3JlIvOT+/Q7DAixkrPfHLhYI0Re+afSDIkSUAGKKPeh2u4Z9USL5pRsN49ip1NWBdR2dojTHUYfNkYmSEqfXF0smWQIeONKupcmm5Rk7bWPDfqc5WDpF/gNIOdwGJ/Tr7Ze8f9YH+gW+1uAk6qPZIod8oimOZCIwrFe15Pj7i3LmUOHkWtC+GG10My+Ku8wohLrltPZdmU9aTrXpkR04I3gu0j1jACzbRuFPf1lTooWH5CleH5V5lV6ak8Yhek18nQ7MgdBfE+o1pLN1ko/JXUhoutCC4jQx8CAaqUD8JbuFa7f4zCIwTNhpFa9zuRxQFeoBF+9ayPSn+9ASgXlzd0WtzSR+RHr81Q11r/d8Bt5chBwOz4ft7Bgpcju2mbB+9o5kZjiEOi7b43TYSLA1DiGa4KamGeaQcEq9FFjXS/04P06TUx1jIyVgRN8QcavQkcoas4ynxO+blM2pxZ+ep3F+urp4NkovDiJ9KHVfwvkHHRxzwk998eFlTEf+XsqQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(47076005)(70206006)(41300700001)(6666004)(316002)(82310400005)(26005)(40480700001)(40460700003)(2906002)(4326008)(82740400003)(426003)(5660300002)(70586007)(36756003)(8936002)(54906003)(8676002)(2616005)(6916009)(356005)(478600001)(86362001)(83380400001)(1076003)(7696005)(186003)(336012)(81166007)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:20:04.7932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f43620-236b-4cd4-bf99-08da9610c842
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6376
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
- Fix urgent latency override for DCN32/DCN321
- Correct hostvm flag in DCN31
- Added new Asic Id for DCN301
- Adjust to 2 phys in DCN301
- Update dummy P-state search to use DCN32 DML
- Increase dcn315 pstate change latency
- Disable OTG WA for the plane_state NULL case on DCN314
- Update dccg based on HW delta
- Correct num_dsc for DCN314
- Fix DP DSC compliance failure with DCN314
- Refactor edp power sequencer codes
- update gamut remap if plane has changed
- Skip audio setup when audio stream is enabled
- Display distortion after hotplug LG Ultrafine 5K tiled display
- Fix DP MST timeslot issue when fallback happened
- Uncomment SubVP pipe split assignment in driver
- Enable committing subvp config
- Do second pass through DML for DET calculation
- Don't allocate DET for phantom pipes
- Modify DML to adjust Vstartup Position
- Ignore k1/k2 values for virtual signal to avoid assert
- Fix failures of disabling primary planes
- Do not compare integers of different widths
- Fix empty slot problem of EDID management
- Revise Sink device string ID width in dmub psr
- Log vertical interrupt 1 for debug

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7adb27b2a6b9..659c71778a64 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.203"
+#define DC_VER "3.2.204"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.37.3

