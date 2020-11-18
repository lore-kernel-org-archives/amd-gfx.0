Return-Path: <SRS0=Rejl=EY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FD9C5519F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 19:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 927732220B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 19:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tr7MXACW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927732220B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8202788422;
	Wed, 18 Nov 2020 19:19:23 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760088.outbound.protection.outlook.com [40.107.76.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE52E6E437
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2020 19:19:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9Nx/36ANCebBZjtZR+lRaVt3Xf39BLX85XDJNDuJRIdl9/w5A0pUjiIWjAzEl6YZzpi6C8noBqwnyVsqbBV2tBn6YlKGybpo/rpeEjAy10M3wzdOSYkMliw8yYNxL0vZ+cd/sC+tQjTY17tewgHKWg640aiCDTO5ir9GtR4+DZOlgft6aJ19twU4PErakUWW7yAWD4CUO8TNhPyDMHYG+2JamndsQr0VcqHpMyc9hiVIQie6Xr3cEJ5vz+pmrm5iboUs6bVoGait7KQuk/8CTkEg0agHn80kDlSgd41ZzTUVFG9pAHu4xiInSGwhBNVuyrqyP3XU06X1BYDtG1j5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0sMVt0mnXhccNlFYX9Nr8u3I28ig0V1UrvBDHTHFbc=;
 b=bNdgiLI/kPKmT75pZ4SVmiZGJUPprEUFjsJkUgzr4NWy6EGk5QAtJUV/9KwP5RCBzoKLOSeBIc4VPfTJLTVp5sFVr7u/R7Xg4fYyl9PBVYcNuAeV5+LBlJKQ3HM5HjAeNxduESZPciuPieweambHm/5GWbBhMFk/UcrL6j2d6QOzAX4E4LBW5675uy41MAbBTzSoGZr9XGY2//rdcUa+/eV2zEhvO6WIham9nNp9Scl72qutD9ywzCxAbgP+uXoDrKL2Zp2IbWxu/OQPDY6RmSNBFrc/6eLjtNQKAzEcPTCAzeUe/FogZVU68k76DwMB6ujZPJfsl0SwMOkJV2/DTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0sMVt0mnXhccNlFYX9Nr8u3I28ig0V1UrvBDHTHFbc=;
 b=tr7MXACWI3tx4oN7Lo/Xb/maGGD+6B08Ee/DNQyTowQX9TtFO4M7nRivEOL3HvwUA4/bDy5PSCZZXthVuaCszg6eLr+OFOFt2RDS8zJmBbYygPbrrm1QNdmbC4SBiPq6zCCdHtykBJkYwD7OuMiwKwZEBiEeeqUv+fmURQ0wRzc=
Received: from DM5PR07CA0080.namprd07.prod.outlook.com (2603:10b6:4:ad::45) by
 BN8PR12MB2947.namprd12.prod.outlook.com (2603:10b6:408:6c::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.28; Wed, 18 Nov 2020 19:19:16 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::4c) by DM5PR07CA0080.outlook.office365.com
 (2603:10b6:4:ad::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Wed, 18 Nov 2020 19:19:16 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3564.28 via Frontend Transport; Wed, 18 Nov 2020 19:19:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 18 Nov
 2020 13:19:15 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 18 Nov
 2020 13:19:15 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 18 Nov 2020 13:19:15 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <nicholas.kazlauskas@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Add DPCS regs for dcn302 link encoder
Date: Wed, 18 Nov 2020 14:19:10 -0500
Message-ID: <20201118191910.2672820-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd6b270c-a56d-41d1-cc91-08d88bf6d76f
X-MS-TrafficTypeDiagnostic: BN8PR12MB2947:
X-Microsoft-Antispam-PRVS: <BN8PR12MB2947566C928AE4D86BDDC011F9E10@BN8PR12MB2947.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:612;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Alayr5vvKTdK/oxAAj1zZabjw1LqK7PpJcgYP/X65CYyKN+2lxgnaTFv58dqyAgD0BNUebeU48VKmsUIw+m1anTFxS/3cCPNctumQb/ATVTZoNMjrCWsWq3oJR4tdznTcN5hUzm3+E7E5qq6fL0Ly6thJH+w1GEwYDovwRu27/QiSTxg7BrabH98RTLdT4e+3knKW82T2iLX++Z7bX3Zp98Ov0H0PoN3BKahE/XPGytCDinGmRyrMsbLw3yFTjAQVzjLs9Xu/R3bb5lu7ZFfLd7xg6tXi7LmpFs6z8XWJt494nItFoMPleVnOHC4W6qCIMYF/40GEuIORVokS8yaeQXRlJybkWOGeZd2+2EIeNx+3bBl6Ho+/HOLWsSQUje4XwKU/5vbkKlN0Q+imr/jQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966005)(316002)(2616005)(6636002)(110136005)(54906003)(426003)(356005)(81166007)(82310400003)(36756003)(336012)(8936002)(70206006)(7696005)(70586007)(26005)(1076003)(186003)(5660300002)(2906002)(8676002)(6666004)(4326008)(4744005)(47076004)(86362001)(82740400003)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 19:19:16.4629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6b270c-a56d-41d1-cc91-08d88bf6d76f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2947
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

dpcs reg are missing for dcn302 link encoder regs list, so add them.
Just like dcn3

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 765002e0ff93..08ef1428550b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -967,6 +967,7 @@ static const struct encoder_feature_support link_enc_feature = {
 		[id] = {\
 				LE_DCN3_REG_LIST(id), \
 				UNIPHY_DCN2_REG_LIST(phyid), \
+				DPCS_DCN2_REG_LIST(id), \
 				SRI(DP_DPHY_INTERNAL_CTRL, DP, id) \
 		}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
