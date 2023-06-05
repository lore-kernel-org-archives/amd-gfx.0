Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AD8C7EE2A
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jun 2023 12:27:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D4B510E1BF;
	Mon,  5 Jun 2023 12:27:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6819610E0BE
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jun 2023 12:27:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFcdbQy3b2iwkR1KSKB9Qb1nVpZBUo4WC34JXfKhaT7inrggaMjuAvNNMUateto8zo3Qgn3cnn9mruYn+gn42iBGAh2qGjmMkOsJOefMrH04EfJ4pVrSoUnDEDc3EOvA89vbvx4j0Xj80PEHiU7zIIRurH+J1fqUubzNBhDKnq3xJ05f6+et6AYPKYwCYcsXsm8K/o+2gcbANqacAQCQ3mJUWvXkbSUMyditIjoEiWCSH2QLWB3ek0dsAbISscRG/YHh7c7Q+BR4GRpAjrx2b4I/27wKIpLleEk1tZVGd+wumkGh141zIi3MzTKfOxKSup1/q5IgdxHjuQX60jv8HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cn9bVSY2I1xC2qgKYfEZIhckGBcwTP5g75Cd2r3NcZo=;
 b=g4sfL+uLnCcm1qsedAfcHeDLdF4mmura4WvHNddY+CYNeDrJ4xKQpof2xc1NTL+q4X1Fk07J8hi1Bz3Wkkm3nb1khHkDA/X0OcR+bSPhVUQOyDOGNpRdgMRX9Ldt6zQToF2KcXA4gRtFm4QFC04PTFfrbH1O/kni9Ur4HQk2c7IcKfMkTouQVvdVsa9z6n9Qe3wOfb/9e0KolhlO/ElnIZ3eedzn2dibbXZLsLlAthbAYAXGUow/DNt7fic/ESlM82rogCTLdQs5nnyHkz/1u6K9X6E8q1/VA/kRJZhQzDNjqbOtZjCn1wLTa5GEXhhpUVsXsiqGBDK7X80ELpBvLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cn9bVSY2I1xC2qgKYfEZIhckGBcwTP5g75Cd2r3NcZo=;
 b=qv8zrMDXFa+ObHjYb6KRMn1WhD5OjakTvQJ6aVJUOrIZ6QSxDIDUPxUw+FOiF2vegZa2EGqh4dsLccTLPjQKHxzWnnzT1g7jP7uN7drXKFQxBloQ04d0NduHU3bWgyeHEyojq0xicmGHiv98BBQAGrCcVLNpNIU4tw9DN81dnGE=
Received: from MW4PR03CA0029.namprd03.prod.outlook.com (2603:10b6:303:8f::34)
 by DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 12:27:53 +0000
Received: from CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::ae) by MW4PR03CA0029.outlook.office365.com
 (2603:10b6:303:8f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 12:27:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT101.mail.protection.outlook.com (10.13.175.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Mon, 5 Jun 2023 12:27:52 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Jun
 2023 07:27:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Jun
 2023 05:27:51 -0700
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 5 Jun 2023 07:27:50 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH Review V2 3/3] drm/amdgpu: convert vcn/jpeg logical mask to
 physical mask
Date: Mon, 5 Jun 2023 20:27:44 +0800
Message-ID: <20230605122744.3484-3-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230605122744.3484-1-Stanley.Yang@amd.com>
References: <20230605122744.3484-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT101:EE_|DS0PR12MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: 706c5d17-5ab6-4475-cad5-08db65c04881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2kqRaQ0pdJt2Tx+/QYxQ5YIRBfpcg3iMogGWKXBUZH9fQzYlaKv6vJ2elMIEE4OMTxduiMHbQKhx0vJZ+AIAo6eaWo4Q0J4y9G72hUT19WfbSQX1b5pJLHeONOWV1z9t3AZ6Dx2dl3QHm3WLvtyzA8wptl6oS+yw06QcLgwHDzOjLn/ElCRi1t+pzFX5e//SPUaVvLU0Sf2/jVM51dyVlrZa2VI8u+rfn+EllGdH9YPay74k+XOAOEC4WN+PdcEGbSbIRNc+Gik0aUkKLK8bQvpNSxnyAOb/6LeVriVcnRJVT7x/HGmH06WiYGFAlVLQ3B+RzR3IJsRUOya0BF1gYy95nSBPuppcK3XrpMl+3G2G8vpaoAL5k12F1bpqFucUjx6x9yz5gz/6hFGWmHCavnP2MyhknF0a71dIpOuVYuoWpYcmrG15f8hnXkYChaAUAxVna8VHQDNpzWvRRD+BEU9eiWaLFMmeA8lAadSfw4fF5LHLPaEzwWwskO9o5rU75PXuH/mD72VicFQ6uh1ED0xj8JW3LBFiOyxqnvgkNP2HILovFcWU3dEyy6vv01CpcfBUMHzvxiuaAKcBUGhwERk/i/MjaAr3E/pcGTkesooGXoSRvJXiiswbRK8db/CcQVdQuB1Yt+E54i1Gxho9YIphGJ7XcA5sjvpfDnp+gsJGno90z6VKFV6c9FfyjYDSAWHOh24lBtjOa8BDvRFWQ+HYX7V4N+qTTygoLRpbgGTdWeudUP/8kwjzXHMEcO2CB7ckq/G4/OsCwfLAKKXvhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199021)(46966006)(40470700004)(36840700001)(7696005)(82310400005)(40460700003)(6666004)(26005)(1076003)(40480700001)(83380400001)(47076005)(336012)(426003)(36860700001)(186003)(36756003)(2616005)(86362001)(356005)(81166007)(82740400003)(5660300002)(316002)(41300700001)(8936002)(8676002)(6916009)(4326008)(70586007)(70206006)(478600001)(2906002)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 12:27:52.6086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 706c5d17-5ab6-4475-cad5-08db65c04881
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 Changed from V1:
 	Remove amdgpu_ras_logical_mask_to_physical_mask
	due to GET_MASK provides same feature.
	Support convert VCN/JPEG logical mask to physical
	mask.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 2ad3b93bf530..1fa024a94314 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1698,6 +1698,10 @@ int psp_ras_trigger_error(struct psp_context *psp,
 	case TA_RAS_BLOCK__SDMA:
 		dev_mask = GET_MASK(SDMA0, instance_mask);
 		break;
+	case TA_RAS_BLOCK__VCN:
+	case TA_RAS_BLOCK__JPEG:
+		dev_mask = GET_MASK(VCN, instance_mask);
+		break;
 	default:
 		dev_mask = instance_mask;
 		break;
-- 
2.17.1

