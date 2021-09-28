Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74722C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A766101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 43A766101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D63B86E8D0;
	Tue, 28 Sep 2021 16:44:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CAD06E8D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:44:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDHzTJxDRN/wXD+zsr40sywLf5K+aQ38ClKqx6JI2HzRTipEGRG98QYmMBJny63/Visn6RhR9jOZeT6cGfHovHQamr+jgdNB/bBYRXnaf5YsJUMhCZNk+PGLc8lGRIopTsxDGfJXSQSYEWdemouQzk4/sIfkZuBh93JTTsdxtdwp+Z2VJPt/IOlg/i9YSrCmvIoNYc1Fv2WlxCispf5S77FDunzMsRSQzUWtiJQKtEQI7/nFLBa0CLM+6JTpODoZa3kyhtFS5pt6j9YgXJy7twvX2crXz0QaxkTxNiOuGI2j0VsRH3gvPg8E27A9I8ZWg4Pvnpu6iUMYqZnrk3iHRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=gS2gzorDWw7a92V1VIhHpV3r5GDRHcTf+gOTBq0McBg=;
 b=TUG6nsQfX5qt0y34OgKuMI6/l89lKCKDL+j74N/fXIaOKoSQVJMQo6Jru3+oTmR5QDohVSlgU5VkxIDqnRgAZFlnH7rujU9/naQjh5F6GclknDQ/gQTml7yGd/8Dee01vZLF0Qaz0MwxLKrI1qOLok06TMQN3iLV8NU5i7FypaPx+ErPvXNc6HWjs8paq1Y6sWfpqh+1G03U4vjt8ShmH7vTyLDENQA563HAvdvYcjGzrckbQy91NbQOuk6micYPhNJKIAO4ZHRLwY//i7efzZJkX3sxrAckfX/kEaeYXZMiiT+PLcw/atMyp0VdnUu6LZx2/j9azcRjw/5y/t7rTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS2gzorDWw7a92V1VIhHpV3r5GDRHcTf+gOTBq0McBg=;
 b=zpbJkQA7C9eDTQ2IlzeQf3QdpxYhMEVQJQt3t354ORFBBuDiEpU2EJ2ZjyU0MlP2kJ3jEcS4JumsZLgIQOrju601i1qPr7Uev0l4jmd+p9eZgo8ZnsvPOn1R1MVchCUIJKVhXWkkX/P2xpl1Tjw21uawdRkhbahBuYSGnyY/UJc=
Received: from DM5PR07CA0129.namprd07.prod.outlook.com (2603:10b6:3:13e::19)
 by BYAPR12MB3125.namprd12.prod.outlook.com (2603:10b6:a03:dc::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 16:44:44 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::4f) by DM5PR07CA0129.outlook.office365.com
 (2603:10b6:3:13e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 28 Sep 2021 16:44:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:44:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:44:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 28/64] drm/amdgpu: drive all navi asics from the IP discovery
 table
Date: Tue, 28 Sep 2021 12:42:01 -0400
Message-ID: <20210928164237.833132-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f98d841-951c-4b4d-8472-08d9829f44cc
X-MS-TrafficTypeDiagnostic: BYAPR12MB3125:
X-Microsoft-Antispam-PRVS: <BYAPR12MB31250A23260C3472BB7705ECF7A89@BYAPR12MB3125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ljqzqeO2aHwZvO/Q8xHwPYft76M1uduK1cAp6DNzlJY/Luv+dgir1IB+8RTudvlJ0NZ1cKVg6+JONKRoVC4ejjryH7kGKFJSdRv5X301cw7fgowkprx0x1M6OwBbVu+/LYM2oRxtreKkASQVNbVLFKc+czggr5kbOeBhMFUC0302wlC95VwRReSAcBfTqRWbzKdZV7DUuMuId7KwZjVKrMAW4ZXzweIH05SIs3XqLe7NbmQiK4oWVrdf0lE01inJtYO1DexKYI4pThNvLj5HyVMwZa7qO2vqT/DDR00B9e/3QLoA4t9JgaRuOwX6lfVdch0DxnCKR5s/stFwYAQ2SjJzZXiH2RYPeN5qEFE0aglwhYjy1Zg1aUmz4iOu6K6wbI9bJjNnnbb2KXFXKdzFvmQWZGyTzp03JzB/Fy7BgYlY1DKJyu+lAG+REIUW++Bz5O4raxQ3Hr0DLaqLrnqQZDaTKcnmOkqUcM8772ycotiifOBSslxZfXTU8ExQ12tmNzpvABb/QU58TjxzvdqwHGy5DL9klQzb/DVSIWhPPe9xRWA7LAinuKzpkrEc9zZPM0z6nSMehUfE7+LgZt/+Pn7n0eUVU+MT10Kz0IoR9BBoDUCIxOLUPDfzpJgq0EjVRJ7BR1ZXjTUy24AViSoAAarY+D+d/Ylwin8XTPaaqDC3hXJIcRbln6Y5sGEOXPWce5enfs+0D9zEG8ipoP16OxYpJWxEigiuPrLTBtpwa0I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70586007)(54906003)(36860700001)(47076005)(83380400001)(2906002)(86362001)(26005)(316002)(8676002)(6916009)(4326008)(7696005)(70206006)(426003)(2616005)(36756003)(1076003)(6666004)(186003)(5660300002)(16526019)(336012)(508600001)(8936002)(81166007)(82310400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:44:41.4431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f98d841-951c-4b4d-8472-08d9829f44cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3125
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

Rather than hardcoding based on asic_type, use the IP
discovery table to configure the driver.

v2: rebase

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5e0956b19d69..9c47cc636429 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2142,26 +2142,6 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 		break;
-	case  CHIP_NAVI14:
-	case  CHIP_NAVI12:
-	case  CHIP_SIENNA_CICHLID:
-	case  CHIP_NAVY_FLOUNDER:
-	case  CHIP_DIMGREY_CAVEFISH:
-	case  CHIP_BEIGE_GOBY:
-	case CHIP_VANGOGH:
-	case CHIP_YELLOW_CARP:
-	case CHIP_CYAN_SKILLFISH:
-		if (adev->asic_type == CHIP_VANGOGH)
-			adev->family = AMDGPU_FAMILY_VGH;
-		else if (adev->asic_type == CHIP_YELLOW_CARP)
-			adev->family = AMDGPU_FAMILY_YC;
-		else
-			adev->family = AMDGPU_FAMILY_NV;
-
-		r = nv_set_ip_blocks(adev);
-		if (r)
-			return r;
-		break;
 	default:
 		r = amdgpu_discovery_set_ip_blocks(adev);
 		if (r)
-- 
2.31.1

