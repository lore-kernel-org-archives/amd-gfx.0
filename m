Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8ADC04FDE
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 16:37:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2208C10E572;
	Fri,  9 Dec 2022 16:37:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D64D10E55D
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 16:37:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgI9ucCHr6NsTuqZgqFjD4/DeSkPAIpLgWsuh861HMv1ePlBb+lK/E+3mDN6L9uL1iawCcr7bZ+mTAex9EaM0EyPynKoZVPDjSWOlpLGWptlgjgLYa4fZafUKnTsZT167xh2u5k9QIfKj7m3hMma9zuRdrQLL9IZ/mJZSKmwdtP6dQHJcCvEf8XhHLBsu639ZqNVllceHn1l2C/S8KH4w4kpIXFwvk/Rz0mqsRJXcjujrE1JazcJhs9q7PZrJaG7vKKIseWPxCZH/JG3ECcVN/aDLg+GeIgTQnUJOSqwfZlixPBdP+9w/ddPtXw+D2kSNDA7knNQtItK22trPu0J+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wH+wLF40RpFUY6vl8VfAsSFNHLkh3GF2wTo4+5NSPI=;
 b=JTCDjtdpt/V0cZwUi9WvbATuOj8O5QIJm4KNnNhALVeuaagD5R0+6bp/RQdapBwjPxOwPmfTI0INewrwyF6jAFAKypxmf2Mb006T5DlNvpRI3GdUlpf39cKSpM/ZzoyfTp4JHXYmz1Cx28iZOmCeOOBSSaLRRTJdOsgzDhnFA6sVGkgBgfLuWL+JmeJKa5FxJRFYGi9htH24Hr8N7LaSp+4zSjstvjnFBvVqUa7cECG7lcMurNlsMBPdDJkIqqY4eY6FbAjr/Mq9/aPXIc+/k9VIXu7uqdEk4YQrxKkxtoB+XXCdMPty0xvNGG2uDOmSGnUbEt3I0nPZ+SMv8GMI3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wH+wLF40RpFUY6vl8VfAsSFNHLkh3GF2wTo4+5NSPI=;
 b=tOcWY5tROmm89occOxIqZsNeziJhVbEL3IbMkOye2YuMcWYY+W+5c8E4WdutHlHrUoprX0qBp+/Y+dnTKPu+eAPproIdTZ5pFUIbWmLFjVXRSy3bHv/bLoh8teM8xmJI+G0wEe1vvuHYhWhk2/7XOjH3mnLh/42XR0/7lXoZrvw=
Received: from MW4PR04CA0151.namprd04.prod.outlook.com (2603:10b6:303:85::6)
 by SJ0PR12MB6925.namprd12.prod.outlook.com (2603:10b6:a03:483::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 16:37:39 +0000
Received: from CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::e) by MW4PR04CA0151.outlook.office365.com
 (2603:10b6:303:85::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18 via Frontend
 Transport; Fri, 9 Dec 2022 16:37:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT089.mail.protection.outlook.com (10.13.175.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 16:37:38 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 9 Dec 2022 10:37:37 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/23] drm/amd/display: Revert Scaler HCBlank issue workaround
Date: Fri, 9 Dec 2022 11:36:45 -0500
Message-ID: <20221209163647.25704-22-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209163647.25704-1-jdhillon@amd.com>
References: <20221209163647.25704-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT089:EE_|SJ0PR12MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 0419fe90-e238-46c8-2b9a-08dada03af6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ldMXDlgT2S/4JhWAkIq0Ig+DcpCpkreLc99T7MvhnkxCWdjSkpKREdujRkQPkz1Cj/n179GHpF2tJYUuKC2vyehuIfMF4j6HXDYRNHv0do+EoucANAbGesE1pUWgFOq4BmS1FCc3UgtHWrnPVXHEH8oBIJZkU76PHz+ctzSIcKknC/ngxjGq0Q5N2Hj2AW24QXAYvxeyD1Es5YwTVzuxgsy3efKKCUzd+m0JwH6lKEV25Q+WHajk9UHJvQZf6WOYzk9AYa77IinyOuHvPjn3Kkv3ApTT3EKC7GqeEcvSxp5SIrTU4VqwDQApvbMXZ5n1DsYTwuq6zMWNQTr+pN8fePx8KtWoeFA6kMFCDNvxmCzY6oTdNfAERtlyD6e/1r6HJtWqQGxPRV37mqncejX2+tBl+m34KGhE5yCxXNONcoAE/O5BRQPL9zbwPic/PO4shtumCLu8wAcBPoMpCdNAdM8yPHxm40AEG/J/kiPsZtz0JPrk4Gv1T5HRy2F8AXNjr/d9HejlsWp0/mTMd2/2vgkAalEpRaWxQu5/aP5/yzE8bhZtcgt6bLAkKs6/VJlIQV1GmeeZzEfrXHKvIzbeXh4SC/NcExhdaWMllLm4WaS6uDX/nUz2dwzD8HC8dNq9SFc+3Tso71C+UhmmbkpXeAH1Au2dABsNUsNrv0OvbwLGr0V/sI7PTSiJj+7sN99cSGpLjAxelR45Ulvkb70BYatGIZnNvfVvLbanNYDSKwA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199015)(46966006)(36840700001)(40470700004)(1076003)(426003)(47076005)(83380400001)(186003)(41300700001)(26005)(336012)(36860700001)(82310400005)(8936002)(16526019)(2616005)(5660300002)(4326008)(8676002)(81166007)(6666004)(40460700003)(70206006)(356005)(478600001)(2906002)(70586007)(4744005)(82740400003)(36756003)(54906003)(6916009)(316002)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 16:37:38.7839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0419fe90-e238-46c8-2b9a-08dada03af6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6925
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
Cc: stylon.wang@amd.com, Chris Park <Chris.Park@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 "Leo \(Hanghong\) Ma" <hanghong.ma@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

This reverts commit b1a3d467a069519fd8aed711fff94c49e486e701.
Workaround no longer needed.

Reviewed-by: Chris Park <Chris.Park@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index ce8d6a54ca54..651231387043 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -82,7 +82,6 @@ struct dp_hdmi_dongle_signature_data {
 #define HDMI_SCDC_STATUS_FLAGS 0x40
 #define HDMI_SCDC_ERR_DETECT 0x50
 #define HDMI_SCDC_TEST_CONFIG 0xC0
-#define HDMI_SCDC_DEVICE_ID 0xD3
 
 union hdmi_scdc_update_read_data {
 	uint8_t byte[2];
-- 
2.34.1

