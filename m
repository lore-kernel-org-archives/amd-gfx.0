Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16598C25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 20:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B335910E97A;
	Mon, 13 May 2024 20:49:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R1vZxpyq";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1551510E97A
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 20:49:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHsTXvYOdcRR78mLP/aQJnshsnqKVHdbQ0VfxXtCQiNTRNAtM2GrxtSQxBOb8LwtpJnOvNyZEfDBjEWoQROA5axRrxDokMZ/oxKqki3U02QR++uvFf+JWWvvHG5h4F/d4ypd8CWBw/PpkKA77gEBog+UWTopiA2WVLTrV1dsjAhhnh0FRf959SSuKp4mJWMA+tSHfwQr128zfc8ALbibhOus2ustWzKdZ6NbVNjy3UJTU85VzxcZi3fmH77/wagJouyZYj1257Eu+/cBlGCRkQy02S6GIH5whfyLgIi13jA+0WCSSGnhOMjB/gYR/onTjMlGUzzQWmafbOHfMPa+zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HU9mSfV2KlWcKSRhcocSkeCglGK2lXo211GCxm3XzSo=;
 b=oHwgsBs/Ts93wODlUgIiaLHAKu8nozIgTLlRUicv5t7/QWd4q/HcZjha6OajjCj4bc140Uerut1rfThYgomB0HntvU/gNhCfCoSyu9ZflMfNWGoKPokh24src3mRA+FSWOndiRz+EOF5SZg+GTL97JwQe6kOlFmNzUCJ0O1l+a0KHI/6E+preCeIrFwfzOeUvMYrRUFMGP4iNw+L1wKdn0W7KaDj/9aEiykm3MQxY9AtEY8s9WD1rvFmiTIttqtQbv7r1SlugJ3M/8BZaPtwyByjCd4+N51ewR56IFg5/jQ+AzAhuQ4wRQ5DdIQMve+4bXYYccr78+rc7oUupzPWBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HU9mSfV2KlWcKSRhcocSkeCglGK2lXo211GCxm3XzSo=;
 b=R1vZxpyqifsKKCOgriCeZN9IoWn/Vw+2P45Sq2qvQ9OHGnKw3qPz1ybt3JKRgspSyvXh6xhUiCMSD8ZRpkKh/XPauSQWRgeeg+0xRY3WWSn5nNR338meSKZb1CwyVWho3T4mZD3aTWYCESrxtojLGoLCO/KSDppmQqIdytkZJMI=
Received: from BN8PR16CA0004.namprd16.prod.outlook.com (2603:10b6:408:4c::17)
 by DM4PR12MB6400.namprd12.prod.outlook.com (2603:10b6:8:b9::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Mon, 13 May 2024 20:49:16 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:4c:cafe::76) by BN8PR16CA0004.outlook.office365.com
 (2603:10b6:408:4c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 13 May 2024 20:49:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 20:49:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 15:49:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: apply state adjust rules to some additional
 HAINAN vairants
Date: Mon, 13 May 2024 16:48:55 -0400
Message-ID: <20240513204855.151186-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240513204855.151186-1-alexander.deucher@amd.com>
References: <20240513204855.151186-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|DM4PR12MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: 32890ff5-7302-47e5-6c4e-08dc738e261e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+6idRO7G3aM3eoWXOl/p0CoppAsZe6cCCqUyKLglCZs/mNY2G2DVTMdbdGTX?=
 =?us-ascii?Q?k4GR+Z5uO+JqYalSNzYlMX2B9ogJHLIWhjGUOZQV+Xw8qUBJSrjmVuPlZTYm?=
 =?us-ascii?Q?qs4SE3lMSiJFfJsx72/CSSQ/MUSht1sd60gWq2TELEe7yIH0haMkDDtOBUQB?=
 =?us-ascii?Q?TXYtPBhceVNKkYsvy81IrtsEImgtibIt6WsfUY22o9fWb9jnP/PyNnSETnbj?=
 =?us-ascii?Q?UX2jWggYw9VfNfAHR4fQgpEvyIrq4RFTk68Jb6IGbMaqdHbObFwTGQnR0ZfO?=
 =?us-ascii?Q?TocDYCTanq6wOMZWw3lelPyZMeXiJcMbwdZL0+EV+oKT7oNg1NG4ZutRUIDr?=
 =?us-ascii?Q?U/pgu1bloeTZFf4AVJCCI/oGlWWjjd/Z5J7EZvuHj4wbpBZr1wtZ+nVQAuIo?=
 =?us-ascii?Q?0muTms7bxGQ8mgWdVtPHAb1pszPY6f/5HxqI00cvkVvIkseeWMvIa/WMcNiw?=
 =?us-ascii?Q?m0GjeHdJJMK0W2KmlCbWBBqHUa0H8rPsRTIxBKDllN7milYMYN2PU96ZxAUt?=
 =?us-ascii?Q?DnU4r/PeSTB1Ssfb62Dn7iGdFaPV/n3yhdz7ZUVGfZVr9/su3gEAjKzD6xhR?=
 =?us-ascii?Q?92guhdUQ5b0wepnx919aG+X4A0wmb3Bsm9A8hjkfLimcE9xKWvgpEWr2eACB?=
 =?us-ascii?Q?7s2YGIju+WsVbQRkvp+diYeXrHr1S26dp0MkffnyYXBCsQyDlvXs/NHSDXFG?=
 =?us-ascii?Q?d1MRo7clbWywRnFcqA8QYwWKr8hHmegRrOA3oPyQnHqgzUCeCAQYEEX+gMng?=
 =?us-ascii?Q?kT5YvYykUGvc87oYqLZlX+VTJoAx9GbrxETOdCU4NDkGuoOT1EjfLMp+1Kvo?=
 =?us-ascii?Q?5uvCG1MqWaOUrMf4B91QAIuRl4igGNyy8m4LOjRJgTVHOOMCSeBqI3A2VsJU?=
 =?us-ascii?Q?UFMGZKfUYwA5xn9ZWBjPSL+8d0InpKZJbbkLPOVvS4CkYjcAHT0ZsUzI4bfF?=
 =?us-ascii?Q?thZS0LduzvtXfgfANudVnkqGcuABlgnc+Qvv4AbObLCJ4eydFtWOrHjoenCg?=
 =?us-ascii?Q?1/kev4i16L1bwhQRM3Xn0xN+8TZDdu9OpPNwClX169gFGKKyOHpFrJvLZagl?=
 =?us-ascii?Q?ypo4X2+Px5BIa8VfVA7KM3VazJm2uEyoZnK91gNDYvRxLtEUk41m6yNag7OJ?=
 =?us-ascii?Q?Li/UVBz97ngiOJKtfRDK9AQuGpxBIHATI+yYB3I/MT2eEJZqjYJnYDwly2Ug?=
 =?us-ascii?Q?FIK6giJhAFqWy1u6x+61c7D4Ihbz1vVNOQqapqjHLpZxfqkLgh1a5isDl+Vg?=
 =?us-ascii?Q?KZ/pIpOyxizmPl5jkQebRF2QGtHEkPC6Y1T//irlb6fMGd1+aaciQiunePq0?=
 =?us-ascii?Q?GN8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 20:49:14.0596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32890ff5-7302-47e5-6c4e-08dc738e261e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6400
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

They need a similar workaround.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1839
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index f245fc0bc6d36..c836bb03547f6 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -3435,9 +3435,11 @@ static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 	if (adev->asic_type == CHIP_HAINAN) {
 		if ((adev->pdev->revision == 0x81) ||
 		    (adev->pdev->revision == 0xC3) ||
+		    (adev->pdev->device == 0x6660) ||
 		    (adev->pdev->device == 0x6664) ||
 		    (adev->pdev->device == 0x6665) ||
-		    (adev->pdev->device == 0x6667)) {
+		    (adev->pdev->device == 0x6667) ||
+		    (adev->pdev->device == 0x666F)) {
 			max_sclk = 75000;
 		}
 		if ((adev->pdev->revision == 0xC3) ||
-- 
2.45.0

