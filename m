Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FBDC7EE22
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 20:49:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 403E710E521;
	Wed, 10 May 2023 20:49:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A91410E520
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 20:49:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/GsoS2k8cXZe/ZuYx7JLtjav+4GfL63oiCC+VNW2c7pb8ZjDgE49JVZ7Ltf+64TtrIR7notRQPVC4zEKJk/3lFz2iO5WH9IBjEFrMia1jznXxxKYC1/2tWWahar9Lu4ll39aJuwAFzEcgzfb6P4AmR94MPsQZTgTDRJuyT/wvGf72Ynstmte0j/JWyUPTKVHeFuF2dpbI97lffI60cWn97WzL5nZtHYuHisU5eBl8VjENeQ39S3lVbJYOJRLK8S6RKUFNGNgH/tkVbvPcVX/1XOI52XzVYWP0apfZvQLke2BQ9rIeKD/YyBWFJzQPC6n1MM4qWDabN3gtBtY70LrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bs1rU39z/Eqg0yAo8GPk9wzYc+2zKiVAZuqZ7p8njNw=;
 b=hQb4TweuGQjRT1NezFN6ySVzmXdqw6Mz+bRVJnJAdt3lBsWUR6HkkhQuelFvypdI5GDYg5yGoJKeEp6muDUKfBhWjW4d2Ca106Lv+5p9szRGCGBap+uENumDiRt3gXT6zKSfADqWEQb5YVPtxuts+LW/a2T3xOWWVWEm7dKIj82v8ttn8nwAqdq2nU0lS8ZTouEkUQSzZuw4MBBJ5QplwojmysZ+Tjm4CQBtCZAojGiVYUjkOYuCenU/mBnIoOT5NW7YhVBVQ1h4RotC/rsK9cmI+8YBt2eUi+ILdvpjnqfrZKP78cNHlXRMv42IFYmpPMDOZuqMaielJsfAlOHagg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bs1rU39z/Eqg0yAo8GPk9wzYc+2zKiVAZuqZ7p8njNw=;
 b=DBNPph4F0xg0yvsOsNy4/T0Qlz7RMzpkjgAnbHvAn13GQK8yF+h2rchmaj2CuAIY4DcPheVZYzOkZSTp1xEkRneBbqYAn0EfYh0BvHY2ZM96Vs+tRaOBxjADR5No+zye4YgAbGrxvACEHcP45DnEluIu/w5KeBdgs6fnCTRAHCw=
Received: from MW3PR05CA0012.namprd05.prod.outlook.com (2603:10b6:303:2b::17)
 by MN6PR12MB8565.namprd12.prod.outlook.com (2603:10b6:208:47d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 20:49:05 +0000
Received: from CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::de) by MW3PR05CA0012.outlook.office365.com
 (2603:10b6:303:2b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 20:49:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT098.mail.protection.outlook.com (10.13.174.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 20:49:04 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 15:49:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 13:49:03 -0700
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 10 May 2023 15:49:02 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/10] drm/amd/display: enable dpia validate
Date: Wed, 10 May 2023 16:48:51 -0400
Message-ID: <20230510204900.949963-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230510204900.949963-1-aurabindo.pillai@amd.com>
References: <20230510204900.949963-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT098:EE_|MN6PR12MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d298c3f-83dd-4a9f-691d-08db5197fdd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rL2YH2EJJww1CE5AExesY0rjFwOSDWXS1vcA64uEjZHxRnUb13lD33sQLKShb9kcLppNewUC3qtmDQxq/084z4w0BfhfuHTJsWCPSRnIVx8D1SLW8j/8a2pblr6GvL7Ai7Ry6y7s4iUGbdQ/qeqa1cD1g0245x6urmD/7BUVFA1qF6gZqtD/rY6Ih8SjXafFrcCyFZCRmSozBw4G8bQqaxY0K0x2/2K+TTlR7+lH4hLTcqSj+hC3SzrpRdWTL2utNowEfxyCfpCzHofbmnafuass9x6DwT6UAh05rhmFbBa3O69rQfAIBBzyv56Br2+ElQpFxMqlXi5YWgYD60Jc+MpPc0rowSXH5MDiDsClq0uiti01k620EGPZIP3MxDSjdgH4PgS6DFC/eGDkPaVV+ZIHDdpTzk7WRwhba720iYadyxOmOufjlcfC9GuFpBMidFHX1zn6+wP9euxKl97ETUfUVE63URplZivIa3d2U2DNp56alzxMOhTgYGxD92Kag20O0IJEfJFu+TzSqoesc34qNefmiEbFvruvKsZU9vP/lGyq0VEi3T6QWTKFlGfaL0n1Y9Xbu6xWsTQHIoniqJspKpqUbMoE8ji1gBsuCkXgFAC6aUVKjAXo2sSiO3WVBMhYMz+ebxI/wV/Fv/OzMI8pfGWuj/Qq1gImHCpTctc5nigiBdMJ9he6Lt+vO9Xr8v2hvQxoT8CmCg2DvYmj8Rg2yin1FtojLCyFgiXxcGE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(6666004)(54906003)(478600001)(7696005)(41300700001)(86362001)(70586007)(4326008)(6916009)(70206006)(316002)(336012)(426003)(83380400001)(1076003)(186003)(36860700001)(2616005)(26005)(40460700003)(2906002)(15650500001)(8936002)(8676002)(44832011)(5660300002)(40480700001)(47076005)(82740400003)(81166007)(356005)(36756003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 20:49:04.1871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d298c3f-83dd-4a9f-691d-08db5197fdd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8565
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Mustapha Ghaddar <mghaddar@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mustapha Ghaddar <mghaddar@amd.com>

Use dpia_validate_usb4_bw() function

Fixes: 6d86146dd62f ("drm/amd/display: Add function pointer for validate bw usb4")
Reviewed-by: Roman Li <roman.li@amd.com>
Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Mustapha Ghaddar <mghaddar@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_validation.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.c b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
index d4b7da526f0a..e8b2fc4002a5 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_validation.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
@@ -359,5 +359,8 @@ bool link_validate_dpia_bandwidth(const struct dc_stream_state *stream, const un
 		link[i] = stream[i].link;
 		bw_needed[i] = dc_bandwidth_in_kbps_from_timing(&stream[i].timing);
 	}
+
+	ret = dpia_validate_usb4_bw(link, bw_needed, num_streams);
+
 	return ret;
 }
-- 
2.40.0

