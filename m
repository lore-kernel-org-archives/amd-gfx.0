Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B151EC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 18:54:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F73A10E279;
	Thu, 27 Jan 2022 18:54:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51E3410E276
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 18:54:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3pUPh1zLdhc6Sk/Ymo6T+OLUpzoRTHeeNZ39JRSN9hjld+VXvTzJNJqv9jeUEivct+aGHmxC7tJ7GWlrCEQvpcAgFDcdb6vF+Ma3so47QlD05gPWyimLWaeMHNzX3Wag9Pqfd+b/kNN6HtPXlb+hsGwV4AGFOVJmXoFYHiFcU3v5zpetmghqhsLlyhGZ8UWifciiNS0Rr4Ynr6vADqnMgmsPDKWKqbKzTpY12l+Ml8ciKH6xcS1HH3QMDNY3qL0Lrc74mwo9UD9SSbKCl2MgVcK46fzkDU0zRF91TaU9EVrLjttHhaQo4T1RnOwyvjmd17E4mNf3pvQHuEWdC/9Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MH92tdFTOUaR5OocbHE96yoaebn6MNSaGzert6AB7xA=;
 b=K5MFrtHKf7ODKvEB671IZG5h5apePe9k4+Ay5U005HZcav1LRgjuE4vUiTYxTMKpHGMwMr+hhjBWG3l6aRg4ljvsDKKoOMYJhTJgMS6hbkFFw5KJIDETIF/KwVMiZ1SX6eReHcOlornUGqf6mosLBL3v7yIcRYnBcNWQtjhb1cfOc5isxxgS3ujgoFRak1EJ2sam2P7lhw0DurguQ1HnKvi7a1GgAhpJl/SQJcr3Jz1o5/Fq7RUEgswnHFmWF/ubnyaSLr+kEEAsqOtMTx1fdADYqXn00uHAjxSOREu7P1+UPoFtqzTxLzoLavC02CgM4rTYvZTgcG9HyCRf3tRL6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MH92tdFTOUaR5OocbHE96yoaebn6MNSaGzert6AB7xA=;
 b=L2ymIuYCScPSiNM4k+BacR0iBR6ToTChN+wTM+TeL/JILMNrum2E6Rty+K4/kaHS3aZCP8tdbP/wnSDi0zZczrrFBIh1og/1aDdRbbNybI0DhZgt9y5XrZIop/rNhY/tquWzlWhXMlH4gagYRPBjzh2+mNbus00SRX/3W3xZ9h0=
Received: from DM6PR18CA0030.namprd18.prod.outlook.com (2603:10b6:5:15b::43)
 by BY5PR12MB3715.namprd12.prod.outlook.com (2603:10b6:a03:1a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Thu, 27 Jan
 2022 18:54:10 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::76) by DM6PR18CA0030.outlook.office365.com
 (2603:10b6:5:15b::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Thu, 27 Jan 2022 18:54:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 18:54:10 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 12:54:08 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd: Enable FRU EEPROM for Sienna Cichlid
Date: Thu, 27 Jan 2022 13:53:49 -0500
Message-ID: <20220127185350.66455-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220127185350.66455-1-luben.tuikov@amd.com>
References: <20220127185350.66455-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3528968-e209-4223-f782-08d9e1c66751
X-MS-TrafficTypeDiagnostic: BY5PR12MB3715:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB37156D053F24B555AD7DB42C99219@BY5PR12MB3715.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05G0iIt1exnOKwb9zK8yxSRjuDLCLsskNDlN8wF/xhWzna0tOiPg6YIisqHnp8PnKpkNnOOLA21cqDyj0UX5n64BFBmHf7jPoHxWZ8wVa54WDErdNP+KkjUnBalsukjAQgStfV+bP/jVa2VGj3/S+pvOZZZC9NkbIo+NcPyhbUMN5uGBu7OEiAIbSqxCKuh+7mDkyngqcPQ8qak3SRSUvvNKY31K4tOrHc0iX3cPLlJhaddMSgzpHqG2QDiDokN0UFfygGVHrtBN82rLjWPyaQLetGtlpr8SImMLqcwdZLcmItCLM24oJ9e1wcJgHFtrNKX/As5GSeq3DwN6N7xx9Tpov/bayO579kAPnN4wyMKyVQ81RRWlwYiK4BPs8vICZQ8HPYHuTul42TpzZ+VMUfPK9YfFneWN1fMfiI6vbf+l1x21dj1ZD002PxeAJp4XZwy/pMbiMAUcioSA6virjkRj3K3vgTZZZdxXPJwv4W2QMH7c3usxkg2NSY7rwe+75EmVxWuPVP519wnICn3oj7oX3bipbA+2HmMVPSZYef3au5spTQNW5YEtbm09lC4FSvAT1mTTuEOPfcw/z/QZkLy1whgWUw2aY6ijjMNkzvsoUOPvzVG1jGbW/B/mC2A/Ek3nrgCjM+ohvDxRWeb5vgXNncwUVbc6ex5XmSoYxVIZ0X5Biqv2LZLCnFwR5fhaADvHMqQUb4eRYJ69YHIDN9B1tbiJuwW/4BsRuGoDZo9e/ixTNGlm4+iHliXS4PxROxN8z7cYdr883EaiOLFw6UIlBWrrM0TCbLHpt9a8Bag=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700004)(186003)(8936002)(508600001)(8676002)(26005)(6666004)(356005)(82310400004)(426003)(2616005)(336012)(1076003)(36756003)(47076005)(16526019)(40460700003)(81166007)(86362001)(7696005)(36860700001)(70206006)(54906003)(4326008)(2906002)(316002)(70586007)(44832011)(5660300002)(6916009)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 18:54:10.1741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3528968-e209-4223-f782-08d9e1c66751
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3715
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
Cc: Alex
 Deucher <Alexander.Deucher@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Roy Sun <Roy.Sun@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable the FRU EEPROM I2C bus for Sienna Cichlid
server boards, for which it is enabled by checking
the VBIOS version.

Cc: Roy Sun <Roy.Sun@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 40180648be3811..ce5d5ee336a990 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -46,7 +46,7 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev))
 		return false;
 
-	/* VBIOS is of the format ###-DXXXYY-##. For SKU identification,
+	/* VBIOS is of the format ###-DXXXYYYY-##. For SKU identification,
 	 * we can use just the "DXXX" portion. If there were more models, we
 	 * could convert the 3 characters to a hex integer and use a switch
 	 * for ease/speed/readability. For now, 2 string comparisons are
@@ -65,6 +65,12 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 	case CHIP_ALDEBARAN:
 		/* All Aldebaran SKUs have the FRU */
 		return true;
+	case CHIP_SIENNA_CICHLID:
+		if (strnstr(atom_ctx->vbios_version, "D603",
+			    sizeof(atom_ctx->vbios_version)))
+			return true;
+		else
+			return false;
 	default:
 		return false;
 	}
-- 
2.34.0

