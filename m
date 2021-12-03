Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E7DC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 22:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4B0AAA4B6;
	Fri,  3 Dec 2021 22:59:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CE60AA4AF
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 22:59:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNLMDVLikpD08KdNCuz3nfHEtFlS2WapjHobJgn7y29+7WMgZTozDqmHUcLvj6qHdfPw4ZMiZWCgIu1HRcv69KIZaZwAoELCGSkBNrDSdXaNMfIi2nYCqFOygZYXA9QGOeJRNTGvCZE809LZ/9b5xejskVK82Dkju2LapZek5HhXH51w8OQ6mGmhTpmbT+d8dLSG2HCb5/7FGEbgEmgUuLzKjgf8xiwLldLBeiV6mUWOBxt5bsFfTAwvLnr+1YkoGb1Yt5ltlBSYoxTDMNM3vhPnioFRY6XjrtkVaBD1Wwd/qZE1E8P21BssKC6Wb8cvm+CsnQZUCfcnY+i/ufvsVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozdioxP5hzP5kSI+JCQ08Wz6pWeblSTeqMazwp7okqk=;
 b=NopCoc5pl00cgl5Ffpwqh9osvS2Ak/2EIreAFrmH/eRHDbllUceXZMTrZo3MGJjVEK7SOmFZgV7MywSDsI/xNyPnqGjs3z5KoQq34bkGryN8VzAvlaUlQBnzaErcXKomrhddzUP2hN76QbzFCopdBTFW9lUGADKoMl7VFeCxColuJAqzoEuq2pZYMPBjzdKaR5exc851StNdOtfIG4aeEldBjKb4g4k7VvT/2dBmgtVARZOU+RzkfWsK92rJ5Hn6PKweFLrqVBhOwfidDvgbEZzJ440Diyf/1JEQgqVvYATXpV70XJwzHJ6tUvEN11kfIczpBdGAK1A21WWQ+yom6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozdioxP5hzP5kSI+JCQ08Wz6pWeblSTeqMazwp7okqk=;
 b=JHva83NlbRoLDoVE/g8suzkwT2CIc6z552koXI815v1GTLs7Gzt9kNn4LncT5tF+s9ZLDSDTdBse3rMKHjJWWq6m4hLKQ2Vc+J5XnBdvaPqQpbkXnz5NsOfqcMXWulfWgAVgBrxcPxyZc9ZQfZkzbXy/99SCWUDWPwaS3brtElo=
Received: from BN8PR07CA0020.namprd07.prod.outlook.com (2603:10b6:408:ac::33)
 by DM6PR12MB3467.namprd12.prod.outlook.com (2603:10b6:5:3c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.28; Fri, 3 Dec
 2021 22:59:12 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::ed) by BN8PR07CA0020.outlook.office365.com
 (2603:10b6:408:ac::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Fri, 3 Dec 2021 22:59:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 22:59:11 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 3 Dec
 2021 16:59:08 -0600
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/15] drm/amd/display: Adding dpia debug bits for hpd delay
Date: Fri, 3 Dec 2021 14:57:56 -0800
Message-ID: <20211203225802.651367-10-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
References: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b870f99-5a76-4e49-dee4-08d9b6b08587
X-MS-TrafficTypeDiagnostic: DM6PR12MB3467:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3467ACF0845CE6D9C876F0B3FC6A9@DM6PR12MB3467.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DsCE16SXTs1+5YmMVltMpbgEiq09dBY3qDW5pziGfta4eL7mUA+js0ziO5INPag37yUI7tgIEK+UqsgNGkMYKOLPzspTW6iywYVlV4Z5k1mNk+bN6TTtB6r14JFm0BDyihbagTVge/J2inM6IfyfeGewEf7IAIRwK0URoEFX4KvLkTIvwh1fCOCTA4bN3xJ4PUx9Z4z/Sq1nmOB6bXv+HHxuvHdW4+NQNED0EPTqs6Z0GEcpFGnm6VNhVq/rKiWmKFkIDFG7gy2Rlp5IapLYMA0KG/Kj7slHpMdubv66VgH3rEDztxRKC4stysDEYSwf6M1LTxcf49n8xXMBTYrh4X3LEBxyTbY7zyj7GDMe7nKsKZwsMpnSPMhBT8fav0UI7x2okt6e1SmTBKyL8K3Xl9Ocl4ENNGkfKhOHWTw2x4+KuE7RSqFXmqTRX49O+ASsJocMWMK1BKAcp4xZttwCmTHEOyUqYW3CrbG6OHPXLAVtssN3vLxcGW8kIbUxsylqGcV+FvvcLVLh8wVaBVYqyVxFdT7ARG5gib2n5elGzUuknPZx4B5Y6fF7nA7RKZwh+8PEwA1H3SKTRy8Z5YXdu3zTFMAplxkJjRXGiHNr34E/7s1hGMM2UWib+m53scZ5OmzY3eMdM8FNUC0/KNuSH2Eoip4IE6LnSUYwdY/SSW//uZ2ArM3qFepHRKNYToPBXSDeQBjzvP34eApd9nRlE1d/ru9mIVaN/kNhnaLHVVhWkJ7YzAvF384UmSDGeq6P1fYuwOsD93w6H+iwPslnKJz/9XVZ64JmFk2J1ixcazE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(40460700001)(82310400004)(47076005)(70206006)(316002)(81166007)(86362001)(54906003)(8936002)(2906002)(1076003)(8676002)(5660300002)(70586007)(4744005)(7696005)(356005)(26005)(186003)(508600001)(336012)(36860700001)(36756003)(6916009)(6666004)(83380400001)(4326008)(426003)(16526019)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 22:59:11.9940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b870f99-5a76-4e49-dee4-08d9b6b08587
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3467
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Jimmy Kizito <Jimmy.Kizito@amd.com>, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
Need to have dpia debug bits for configuring hpd delay.

[How]
Added hpd_delay_in_ms variable in dpia_debug_options.

Reviewed-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: meenakshikumar somasundaram <meenakshikumar.somasundaram@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8ca53fc0d376..5c2cb892d993 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -522,7 +522,8 @@ union dpia_debug_options {
 		uint32_t force_non_lttpr:1;
 		uint32_t extend_aux_rd_interval:1;
 		uint32_t disable_mst_dsc_work_around:1;
-		uint32_t reserved:28;
+		uint32_t hpd_delay_in_ms:12;
+		uint32_t reserved:16;
 	} bits;
 	uint32_t raw;
 };
-- 
2.32.0

