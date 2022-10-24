Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F7FC3A59D
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Oct 2022 04:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 314CF10E23F;
	Mon, 24 Oct 2022 04:51:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43A3E10E23F
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Oct 2022 04:51:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GR+cpMDQ3zif055Rjg2wrHFtq0nDs02nbW7xAoFSjVhIkUF6/tybT1ZaGRHsRoq9llhWjJrQW7P40yvDKSrHuDwIxbFit9cdaPzopzjd+bfbBFH0tnmYHr0LyViETV11kaOZMECxsbzshviy/HDel2saQXirCstSCs7yku0BXa2byEBdA9qn0qX/wGqudbF51T8ED0VT3ZekPXTQlZpVsxaOJLl3k1RTzMgxjbTyqqkSd8VDwDUpA7eYJV/SV5qDChZuLoM0yrcdj3TJR7bvxpTftBNHxIqjbV1mCpmNoyPZnjV6IxSNAYtFoKuoxjmjMF0CG16cCAERULFXNIkF5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ca+9sm1R7SXK92bMwdxBoCHa9yGINF6W6ITeLaIC8BE=;
 b=b3oxK7Om1eo/dZJTrskZ3ZEgOt8wRv+iHeRIgJDHOeHBOvuax12hxYyFPX8h3R8tfbmWhua2rnh5NEH9QmOseNsLDp53jjZW5JZ51bmbg/EldY81MyRV2jn3KZ5V+xM3V3s+NWyAxCsEIl+doVqP8XjBHD4kIZ4WnyvXUPvvKjfTFGk9ph6dZ9lHkyImPtwKk3Y79AauulfuLaO+pRef9qwg/BqO6ckUgwFKXkOuOg5VRFGxwBJ1mX2fW1sbnc6PKgHOpsMsEwlqymXQGilCAs0avfFn7PqMQrceW7eLynwfve2N5KbvRjI6j7dtT8TiArGL3t/snNIjhuAqZurB8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ca+9sm1R7SXK92bMwdxBoCHa9yGINF6W6ITeLaIC8BE=;
 b=TDPhMoKBRla4G3xMB8fcVavDZiuAT0GYT15rvpIYBaYb6QiTLBzhnRH5pX/3xGtPITjlDI4NLd9daGOPs1QknxtCfWRJ6bMNf0nbI23KGUk/g5B5dFsW8OsPTHtzZpx+c7px5/C3WHrwv8zsqQo+ZKZUadf09GcJQ8XjtqKolyo=
Received: from CY5PR19CA0103.namprd19.prod.outlook.com (2603:10b6:930:83::17)
 by SA0PR12MB7074.namprd12.prod.outlook.com (2603:10b6:806:2d5::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 04:51:30 +0000
Received: from CY4PEPF0000B8EE.namprd05.prod.outlook.com
 (2603:10b6:930:83:cafe::f3) by CY5PR19CA0103.outlook.office365.com
 (2603:10b6:930:83::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21 via Frontend
 Transport; Mon, 24 Oct 2022 04:51:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EE.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Mon, 24 Oct 2022 04:51:30 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sun, 23 Oct
 2022 23:51:28 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: set fb_modifiers_not_supported in vkms
Date: Mon, 24 Oct 2022 12:51:13 +0800
Message-ID: <20221024045113.2532106-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EE:EE_|SA0PR12MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 85fe6887-6f5c-4406-a432-08dab57b6af2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /aZkixFcMfBZMNRjtoUiy+wCXfnGztz8x/CydsxCwYbIEyvwUpJ0Se6SOjERmafE94xQ6p4GnwOVN5FdNrplY/NYKa3arehdW2LWjS7xLtQ/IwMseetO76oAryo4+BlVSa7rW6RE1Slphi5Zkya5hQb2g3602XitjjqIHQmJA46LKPVi/USs4nQp4Xsz3UxL07zsUFp4ekVtpkf0+41qVinQe+6zERP7Brr6f4Aw31HQLDPNMmLBS7vjJEbipl/XK5nZ4vH7g6zazmuix6pCWMpCJea/k0xS0kXyflQJjFSXEKSrR730BZzAuLQz4oCB/S4tuUoYTlZ2YwZVj/fU0r/i7NLk28Z1SjoigFcA6tN0Dz4fBv5OHfU3xcoYZuq3s2xMv/3YssjwbFIbI2GS2JKrAXy5TcLv8o6KDKmRO24PFiF2iyJjkcg9GoTLFeWk2iRRhfcPTOhFe4nSPv7NFhoQHGyT0ev32b2aQCYoGW9OtEZnkFJi3MI8PWorU5VfjQJwG5JHSU4mxVFssYO9MpIMx3X1sqsETNAMuNd0PUJuJdHr2TMxBZjeVxkZU3x4E7y8DdGXhmk/trhRVm+4kcUI5Nv4Yie8FRKf8EDvjZhhrMNofMxCH/0BrY3t0uYxMiNJNoHiVnfr2dl2lUt5bnhhgdclylSJdV17n+mqN+grfMT9yWb6V8jcpjaRnSelRgJ3lMkRnuybt2vA/AQl37P3eCjyqkNw2mSQSDOXLZFutX6CozZFX6ukHaCkJhUdT4lzUcsv/lTbLLFwCQ3oqDXiGX/udRRBYz6sYlMhGAA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(2906002)(36756003)(47076005)(81166007)(82740400003)(41300700001)(8936002)(6916009)(40460700003)(8676002)(86362001)(54906003)(4326008)(70206006)(70586007)(5660300002)(316002)(426003)(83380400001)(336012)(16526019)(1076003)(186003)(2616005)(36860700001)(356005)(82310400005)(40480700001)(26005)(478600001)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 04:51:30.4518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fe6887-6f5c-4406-a432-08dab57b6af2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7074
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Harry.Wentland@amd.com, christian.koenig@amd.com, Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch to fix the gdm3 start failure with virual display:

/usr/libexec/gdm-x-session[1711]: (II) AMDGPU(0): Setting screen physical size to 270 x 203
/usr/libexec/gdm-x-session[1711]: (EE) AMDGPU(0): Failed to make import prime FD as pixmap: 22
/usr/libexec/gdm-x-session[1711]: (EE) AMDGPU(0): failed to set mode: Invalid argument
/usr/libexec/gdm-x-session[1711]: (WW) AMDGPU(0): Failed to set mode on CRTC 0
/usr/libexec/gdm-x-session[1711]: (EE) AMDGPU(0): Failed to enable any CRTC
gnome-shell[1840]: Running GNOME Shell (using mutter 42.2) as a X11 window and compositing manager
/usr/libexec/gdm-x-session[1711]: (EE) AMDGPU(0): failed to set mode: Invalid argument

vkms doesn't have modifiers support, set fb_modifiers_not_supported to bring the gdm back.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 576849e95296..f69827aefb57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -500,6 +500,8 @@ static int amdgpu_vkms_sw_init(void *handle)
 
 	adev_to_drm(adev)->mode_config.fb_base = adev->gmc.aper_base;
 
+	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported = true;
+
 	r = amdgpu_display_modeset_create_props(adev);
 	if (r)
 		return r;
-- 
2.37.3

