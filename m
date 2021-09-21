Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB27C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADD8861184
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ADD8861184
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 460266EADA;
	Tue, 21 Sep 2021 18:08:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C570A6EA79
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFk1srpot0lx5NJS541ZEcy0FWiWlb6uHaIs0H/m0sfVLEf+DU69w8eiYBt6meFT5YGp9ggAe+hduLkKNGseDMoWoIE/E28XwqGb0lZC95Q69tpj1Jp5q/OTmbb9X68P5bUTsW9gK8l51RYuEWXMe09wTb2Vy33zocA71CerijNNlAuDuWxOZhMUD3pELvuyqhOW7lRbRG2I80IMsKHqHRXzEUwXk0Eesb1D0Ou1ny99pPpGd0JTAleqyjaIEkmJdlBZKg4r7dyP7nXQSmRp+65xNSHBsGsFO+lCP6IzCcgp8PNPnAMYFA0jjqxx7iBATY9+ofoHGJPAJcHgNg5KHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=jRrAkfvUizNY9ok/G6NGzGaQ7gURCLM+HQV3egyFSJA=;
 b=BYw9SsWAHMT3bHaucl1SMlOCMbMMTe+7VASuC9h6NyM35YXNv84pTbuQtt9zZWnxoRz2lA3dxU9YkCFI1MkFT3YAc1pgFdIvHZE27fM1dQfPGMoiyDyZllpJZeoo2cTFSxQyJ4RgrNOLcqY/kjRh4+HpV7sQrrUZ19dww2ZQ42KIGl7FHJKUg0no6s+n9+3iL9zDEOKSm0MwdW7L7c34UKI95RFOfsP0uuJlM1hE5hRtidoNpy2Mv3Tfn21L/y8PdB7jWJR7VzSeExk5JA9gTTTxLUE7S7XPYYSG4S27XxMptYoVPSia1DSJIHLLUq96BosfVQoe3mFiXZI0lVQcdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRrAkfvUizNY9ok/G6NGzGaQ7gURCLM+HQV3egyFSJA=;
 b=yeGvlBEs52KHOFoSvsGjPA1iHGXczlvSmMBV0H9/m19/4dHODDDEgMIZdapGQsNji2ZjJFCLgm8sRIDbAZ62mzwoaKCzpiefFTeIW+77lTOWUBt7S5scBkHm7eadxTeYKRLBdYaLKx1ZUQE9YbX+NCXonxiMp36RX5XhAp+JK3U=
Received: from DM6PR03CA0085.namprd03.prod.outlook.com (2603:10b6:5:333::18)
 by CO6PR12MB5396.namprd12.prod.outlook.com (2603:10b6:303:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 21 Sep
 2021 18:07:56 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::45) by DM6PR03CA0085.outlook.office365.com
 (2603:10b6:5:333::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 35/66] drm/amdgpu: drive all vega asics from the IP discovery
 table
Date: Tue, 21 Sep 2021 14:06:54 -0400
Message-ID: <20210921180725.1985552-36-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 636410df-3e42-4394-3dc0-08d97d2abd58
X-MS-TrafficTypeDiagnostic: CO6PR12MB5396:
X-Microsoft-Antispam-PRVS: <CO6PR12MB53967455342D09379F871DF8F7A19@CO6PR12MB5396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nby7yIgXcZDfQ0yGzrF6KqNBOLLoFBO2KY+2JtOmL6z/qN3DTZZ6n86teX/eapyrmgPAdUnLFlih9M8H568tIr33qtJNLomFOp9Jb6SGDPOBJ5SUJOjoDJwoplwqEUbC/yZv5gJd1NWFqWoKhBPsqpBLGO0QxjPALf6JVpZhij8cFMwwQ+69PGtUlhlGivaPtykD4iLvRcOm6Bj3saXmFEK53yQ9fiNiK9uf1kI/XB6DuiNtFBigtcmQbGpyUPTR5OkL3/YwNTrvExhMVJOASXzx8zMWiXBeChX0pz3RcuLtC4jF24QG2sl9UfDjZ4GLhTY95ZxF+9ZiQ96miSp6eCE/TBS0+YcQJ0NH3Cd5wSAOSfb7EMu+kAZx/DWAK6D/cen39M3aXgADqZBP8m4X9LFRnwqXRFlErqUu4s+XWqpmY2uuotlJuOND+DnWcRVkxehIIp37nCHW59FcBH2QDmU4mltGCOKnizRTE4xAxhWwJEGGn0SrYVLBrOUM18UhBeYZA8SaDiJ9551/cdXkcSEMV2rca1RrGDbtPkJO9Norf6IitYAwnvSzmlwQRvcooHJGl22HU9gYnzKtvl32gx3HwRPhtEKNn+agdsZfdOKWOGzcgadZpOAa7YRT0xi6KNj7Jm2gLZeyEqHoDbTENC0txkcwhHfkS18Bpd3gBayKth+WHp34o6aEdqmzj+JInhGI9Ti/hofnMGKwBEdvYez/aGvfr12RjYdBALCbf+c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8936002)(36860700001)(70206006)(5660300002)(16526019)(70586007)(2906002)(336012)(6916009)(82310400003)(186003)(2616005)(83380400001)(508600001)(316002)(8676002)(26005)(426003)(1076003)(356005)(4326008)(47076005)(81166007)(7696005)(86362001)(36756003)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:56.7621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 636410df-3e42-4394-3dc0-08d97d2abd58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5396
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2bf18bc30f69..d64e5a209cf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2126,22 +2126,6 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 		break;
-	case CHIP_VEGA10:
-	case CHIP_VEGA12:
-	case CHIP_VEGA20:
-	case CHIP_RAVEN:
-	case CHIP_ARCTURUS:
-	case CHIP_RENOIR:
-	case CHIP_ALDEBARAN:
-		if (adev->flags & AMD_IS_APU)
-			adev->family = AMDGPU_FAMILY_RV;
-		else
-			adev->family = AMDGPU_FAMILY_AI;
-
-		r = soc15_set_ip_blocks(adev);
-		if (r)
-			return r;
-		break;
 	default:
 		r = amdgpu_discovery_set_ip_blocks(adev);
 		if (r)
-- 
2.31.1

