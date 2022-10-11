Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C845DC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 20:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A177410E87A;
	Tue, 11 Oct 2022 20:56:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D1D510E873
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 20:56:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2kSEGIN7rmTUJwNDOrkBoQi+FBXlTd9//AYuZreH7a8EgSpWS7vENVrXEVtjwKPFzh3DJbOHLb09lhPzu8nJkR5R0bacFbvObwvA9rqV8Mmgleii+NUeM5Xg6+hq7GCsz3FFZXzunKsTNz5hTLJu5bM7Z8I1ElYNXJtabRuphn949rJ8jng5Mx+yKrNknRhWlnMdGydGHsM475hqOxCHgO9FHjYWlyRoztIZrjIyVm5z7R0glnRFalAfZHjZXjjthf4pwayr2imONbkQQ3CC0BspNl9X3O3aKcWgXXubrKQdBPETXHKldknrVDyvn0bv97y024m0bGu7Y6pXWyVfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSCm6AyN5NuHlfIscTZjRk4ZaB0cMzYekpZ2Ffeg7IM=;
 b=AyeYz2pXEjhqO4CnLk0pw91va8oH8ODurL9pwT/amoNylsSR3/3ydLsDuTlpi2bEdCtPQncFfL9p0U4fpT/wNutIedHfpY7X2SQ1SPMw92uyMHB5NUcER+/Ae4UYjOOH3ZPjgiQc6eO4c46IqlEFzxTaLrPhqVf+Bf3qmZjPklNIaT2MCkvLM+SmdWScOFn2atKp2axP/ezyLgdLecXXvF4KXbEJqxJQZ5rjHVOBfLVCfTH3XLwxcTnZqrCjXQZYxwoWGxVAkeKBd25lQil/mapbyWk5CqrGaIjpctBcz2mnin2Dwkn2duUDV4wh7iujhqITRPP53upPrj6s4YITLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSCm6AyN5NuHlfIscTZjRk4ZaB0cMzYekpZ2Ffeg7IM=;
 b=LMPzFynLVcXkcB3eW3UGOBglvHDaTdhwmc3HI6W3ldYyTEixajAh6s7BflEWOY5tp4yrSq+ClQTtLvanXREEyJ0xqU7ygW06meN01+Ck8NlqjuEDX93VaXYVbTn8ZYe/9uW0A0ddZNhUFXQMnPzrZYlrL83etb/keMh4ZkSnJhM=
Received: from BN9P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::25)
 by SJ0PR12MB5439.namprd12.prod.outlook.com (2603:10b6:a03:3ae::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Tue, 11 Oct
 2022 20:56:27 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::a6) by BN9P223CA0020.outlook.office365.com
 (2603:10b6:408:10b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Tue, 11 Oct 2022 20:56:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 11 Oct 2022 20:56:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 15:56:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: convert vega20_ih.c to IP version checks
Date: Tue, 11 Oct 2022 16:56:05 -0400
Message-ID: <20221011205606.2540082-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011205606.2540082-1-alexander.deucher@amd.com>
References: <20221011205606.2540082-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT036:EE_|SJ0PR12MB5439:EE_
X-MS-Office365-Filtering-Correlation-Id: d687d354-ffcc-4c0f-a8ba-08daabcb1089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kiD1QcvsE9KcB48Wcwd2ujpuWID9W5XQDOzYIJgAdHx//8RMqdGr8UZfzSVBTS0xp1qol5Fm30HvEUS1DYLzLqVp1gK10tsH0P9iYPe+tq45Lx4ZyXAq32OH3ofAogvNiQMu/ouPrU7A/nPCj37Dy+1opoZt46tpwAEOsjdpo/oczEUo/bVwEB+x4K1b1O+MJY1WpnBWrLNjHjG44KAe1+TJTysuAlmbh2WJG4KEegnhE/dbyrc6JggqCgtkt9jwMMjRSGEMdg/hwRmsKh9o35CqyH6OZlLfpFkzrrfGR1wZX1UAxghNQRZrFGcxqF0mMAz46d8vO4S9T8eXbF0RIyruocDmVeWcoGM4QcIEeCQ6C2OuVitwY1UQECPxIRZwTJnULnyRMoN+RoM9XIXKJ2VAMVfXpzOskjHnMM148vl0/I1myAitLo5yNPrrU9rGGsYr+qYXvXDq89B4W+aVaH9xv2ocPYhAWPFve+5pJW+QzZ3GSpXLGJl7dRGiCjyLlH/MYmwtd1xfyv33UNGoDxbB5GFF4S+HwWqCPDkWlsQS0934Ng/LKM3wklvp9whnEbEYJ4a/4+OMkeDOuxurZOefYk0WShfGz4V/KYRGy/LXqormWaU1xSk7ICY3sVlENWdm0Pg7AO0bOLf1pgje8orB5eJmbq/07GSriEpDpVM2rQImZuw+qpP1t/TEG6zfvdTQeCPsyp3ozSJ3bmbF30NoT9SQSZ59LGbuXJckyhkF+FsnWMGTU9sF2rt3SUie+ZUEWv+ai8iGpeS89qSRaSLXs9fTST4/bBXRnpwt3lxMxUTn/EJYfw7hI3l9rQ4C
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199015)(40470700004)(46966006)(36840700001)(2616005)(16526019)(1076003)(186003)(426003)(336012)(47076005)(356005)(81166007)(36860700001)(83380400001)(82740400003)(5660300002)(2906002)(4326008)(8936002)(82310400005)(40480700001)(40460700003)(41300700001)(6666004)(26005)(7696005)(316002)(8676002)(70206006)(70586007)(478600001)(6916009)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 20:56:27.0045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d687d354-ffcc-4c0f-a8ba-08daabcb1089
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5439
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For consistency with newer asics.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 59dfca093155..1706081d054d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -267,7 +267,7 @@ static void vega20_ih_reroute_ih(struct amdgpu_device *adev)
 	/* vega20 ih reroute will go through psp this
 	 * function is used for newer asics starting arcturus
 	 */
-	if (adev->asic_type >= CHIP_ARCTURUS) {
+	if (adev->ip_versions[OSSSYS_HWIP][0] >= IP_VERSION(4, 2, 1)) {
 		/* Reroute to IH ring 1 for VMC */
 		WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_INDEX, 0x12);
 		tmp = RREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA);
@@ -308,7 +308,7 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
 
 	adev->nbio.funcs->ih_control(adev);
 
-	if (adev->asic_type == CHIP_ARCTURUS &&
+	if ((adev->ip_versions[OSSSYS_HWIP][0] == IP_VERSION(4, 2, 1)) &&
 	    adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 		ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN);
 		if (adev->irq.ih.use_bus_addr) {
@@ -321,7 +321,7 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
 	/* psp firmware won't program IH_CHICKEN for aldebaran
 	 * driver needs to program it properly according to
 	 * MC_SPACE type in IH_RB_CNTL */
-	if (adev->asic_type == CHIP_ALDEBARAN) {
+	if (adev->ip_versions[OSSSYS_HWIP][0] == IP_VERSION(4, 4, 0)) {
 		ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN_ALDEBARAN);
 		if (adev->irq.ih.use_bus_addr) {
 			ih_chicken = REG_SET_FIELD(ih_chicken, IH_CHICKEN,
-- 
2.37.3

