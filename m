Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A8DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 08:13:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D35810E9FD;
	Tue, 14 Dec 2021 08:13:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A64FD10E8A0
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 08:13:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuLibZgMXLvThBqo/ANEbVIRaBzAhRChUN7YBRgGCi8CKqBQrExitCA5nMJYSRvlIlSUTO+I7kbjE5ZUGXfOLlNnlSXzjvnyd13K58W13T6fZH6rT5Ka5veDiwGXhxDMuW1j3iQ0qOXGrZlY5CnK2Wr9LJtuaQil45zZcgQ4PHsJB9Mc3Mo4chfYnvW4TDXYZAtrzffVDoaIu/Odk6eIXs4RJlv8eK45KStJy3j5+IxnFIGFq1j4adDoZ4njbHnXep+8bqyBlQsPe6jb6vL5iVdlH3X7wRukPbKOfwIl79aNFioZSG2twmi1KPWCQWcraY7f/0A1eArnMnw71p3JnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1ps4FBy+GnM+/l9ABcWMSROsS14rCTvZGjsXMtTvqI=;
 b=KE2sWKCw/MWG84AyiamcVHZ40hPnMJ8TKR+8ZuLTU+Uym5i2G5AsebQeE7RvkypwG1YK2u3E/mBygGdQqupXaMlPGDfuuiM9Pg6t85J6ePYNe8svIYztr1kBCzXq/i+7nz4gYM/JsHLtpNDYkNVzDFh1dgpMd8T5rnbAsUcvFtxBc+5tJvXUKgEL3/GToyo4t1E1SZ9YJjMU299S2qd1rSiyBRzbPDCFbpFlz9ZwPEgY6Ks3smXi/wAP9b5Heovl2VbYxvif4HQ+3aeRJrfCa0wmOyC/gtRqerlHiPqAzIByzWANUobmqkn3jxcxk2Vl3qANQIMOwnsKuC+rpOUC8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1ps4FBy+GnM+/l9ABcWMSROsS14rCTvZGjsXMtTvqI=;
 b=4frpTeiFNI+WzJDK6vRxT0ssSVH+QqzzfTL8q8KvA1giQLIzw5S6XpDCy4FHROn4ey/uPjQIvvE3W8OwyFzsINAfGN4QdjrGgoxk4qcgwde9ILKT/kA4HX7zZrJhGhrukxLEuI0T/SPxVujAgWBsYeiy4sow6tTuoXGZjcIZcPk=
Received: from BN0PR04CA0171.namprd04.prod.outlook.com (2603:10b6:408:eb::26)
 by MW3PR12MB4410.namprd12.prod.outlook.com (2603:10b6:303:5b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 08:13:34 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::79) by BN0PR04CA0171.outlook.office365.com
 (2603:10b6:408:eb::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Tue, 14 Dec 2021 08:13:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Tue, 14 Dec 2021 08:13:34 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 14 Dec
 2021 02:13:31 -0600
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/display: fix a potential dmub_srv memory leak
Date: Tue, 14 Dec 2021 16:13:16 +0800
Message-ID: <20211214081317.337359-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 906f66d3-b0cf-48ad-5662-08d9bed99fb5
X-MS-TrafficTypeDiagnostic: MW3PR12MB4410:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4410A9EC78CD3036A2A84167FB759@MW3PR12MB4410.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:188;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FbfvB/BtOKzmf4HEOdJZTsajLhDwF2cJ1LytF7kbeluF7ejH2pfJA6bUC3NPyLDD9BQw5J7iMaXZR3jtMD6ApwYWBgBnNLcjNlLJlpHETI7z9zao4KbZXmwXOBYX1Y1zz4ULWP8lbyCu8g1PSFCS9ju+C5w5rVxWKBqFYRU1kZeublGK7JyHkdRcxt82DZzhgBA9PvEDbesUAHQWA9MOWBEXXEyzOSbyPYPRiY2RZ2B94ISTkkvV/xGvxMSxGtnS5zNjm9Ssx1RA27FcfoYiyNC5P6ellWJVTDcy/IR9tg1MkXOYXiRoQYAtvuZKU/2ODK5kK/vHfdaqVS9/wjjdLPNq6uuqXKoR7EKUuzXcvkrRIgPdrrXo7EFpzY1WyFoKidJSMVY39P243NCC9gzlTVS4dNWWaNsgTuRjjUguUInWgA8rv26JMij5iGluSGMj3PcA9sIurFPQqwaZb+hptDGKFjNFm1mjvyyJfacZl3LnePxOBst5iC0GRv00MVuvcxM28HSVlYmc8YmRdG7w8xXLW9uBlbpUGm8hPBjMC2dMVE4wl8YNffLz6JtpKzdRT3n75mdmKSwkdSMbOLTjWfOWniKjfWZm3Seos0cYwmZsX9ot4H7r5YS5RjWTzP/6m6GSCECxqWzzHjmy55/hyRGD1+i+HIco2sRmJlL8tGysf8fyonOombB1FE5yshHP362xzVHN8z4k05KO/HFDvvLq0E+32Foi/GzvxEqOs66ts/S+JiIV4LiUIIKUa2Np29+WSBq2M+x7Lg46bF0PjdwzTH3erHKQrOLIUkev8O0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(70586007)(316002)(70206006)(7696005)(8936002)(86362001)(82310400004)(5660300002)(54906003)(36860700001)(2616005)(508600001)(1076003)(4326008)(8676002)(186003)(47076005)(16526019)(40460700001)(6666004)(44832011)(426003)(356005)(6916009)(4744005)(336012)(26005)(36756003)(81166007)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 08:13:34.5965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 906f66d3-b0cf-48ad-5662-08d9bed99fb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <lang.yu@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Memory is allocated for dmub_srv in dm_sw_init(),
but not freed in dm_sw_fini(). Free it!

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e65214db904c..8f6766542c73 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2023,6 +2023,7 @@ static int dm_sw_fini(void *handle)
 
 	if (adev->dm.dmub_srv) {
 		dmub_srv_destroy(adev->dm.dmub_srv);
+		kfree(adev->dm.dmub_srv);
 		adev->dm.dmub_srv = NULL;
 	}
 
-- 
2.25.1

