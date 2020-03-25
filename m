Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CA1C18E5B
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 08:33:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A661D20409
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 08:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NmTUnvt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A661D20409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FACB6E5B9;
	Wed, 25 Mar 2020 08:33:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DEBD6E5B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 08:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLhkevl+78BrF5VBGvx71iDaIU2cKrkXpq8uqlWHK7fKtvaGWR6bUOgVexH/vZG+p7NF9K5A3N24sYLuaYa/zIqPxzqH0ntWLtIuyj384rsx5AegdGJe7u1egiiucSJWfD1a1z6RLFOCVQesrj9SI0ShJ6SQ5Vv1Y2yMmTS2ClaxsQaBMN7gZX7C+coP58MLU1SjbvQNRSG1QBMWT5t4tviLM88JvXMTeIj1pX4T/57D1fPS/TPneUTmVeB9bRARP64rl4wZ6x/iUqeLt71lMhE8taA0np8viUzvrSdZXE5NrGRtMixcn+gx8ceLQ8NpcOosBSXixoumt1kSKhTEtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzMI0czdjAVw3lYYsQrA8JX3O2Xv5zmwTLd1orkfoCU=;
 b=bznO62AX8wrZGotsl/U8KmelQkpSxCfACWK2SyFCRiYXJjyFPykrRDduez9TZCCvkb5WFQpmiWWrZSLO0z6IqHGMKHKXQHMg0tHnm3KXF8742hxYhtpoTnZNPB4qnJ3jwRm4qNwwbZOrYI5SFRbEAnDK3pKb3rFhpEuEk8Ijpcvzy4wx1OBpmtjCfhFp9m8gOqWSRgZXIu58hUIW2hUvDjAYPuygSAfGOwLeywODS9aPLM63UW+Re3HYVchkPHHHLw4azsEbKItvaB+IAAIdsx/G0c5FxhxdaZZNiwbnv9Nh+tbNXqw/PRudUKxcNQ/YNoaI36JUtqpnn0l/Nnx+Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzMI0czdjAVw3lYYsQrA8JX3O2Xv5zmwTLd1orkfoCU=;
 b=NmTUnvt9jJX1F2jC8czrWnqNr+c939UvF6iAlrRliXyT1I/zbh4SzR2znoU9cuknjqsMwurgwRHz23F/u5apgXX92f2+HKNSEWabh0FBUoRH/ymQxu/XSiTVQdK7TGaCGWTFt8ttO0nK3DFrCb55NUKDmvbPQOx+ZY2zAa6wV8U=
Received: from BN6PR13CA0029.namprd13.prod.outlook.com (2603:10b6:404:13e::15)
 by DM6PR12MB3707.namprd12.prod.outlook.com (2603:10b6:5:1c1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 08:33:46 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::3a) by BN6PR13CA0029.outlook.office365.com
 (2603:10b6:404:13e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.12 via Frontend
 Transport; Wed, 25 Mar 2020 08:33:46 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Wed, 25 Mar 2020 08:33:45 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 25 Mar
 2020 03:33:45 -0500
Received: from emily-build-machine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 25 Mar 2020 03:33:44 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] SWDEV-227979 - Add 4k resolution for virtual display
Date: Wed, 25 Mar 2020 16:33:00 +0800
Message-ID: <1585125181-14195-2-git-send-email-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585125181-14195-1-git-send-email-Emily.Deng@amd.com>
References: <1585125181-14195-1-git-send-email-Emily.Deng@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(39860400002)(136003)(428003)(46966005)(36756003)(8936002)(316002)(81166006)(81156014)(26005)(6916009)(8676002)(82740400003)(356004)(6666004)(186003)(70586007)(7696005)(336012)(478600001)(47076004)(70206006)(2906002)(5660300002)(426003)(2616005)(86362001)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3707; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 277a5ada-019f-49dd-1f4e-08d7d0973bc1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3707:
X-Microsoft-Antispam-PRVS: <DM6PR12MB37076E033FE16321C9818EB78FCE0@DM6PR12MB3707.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-Forefront-PRVS: 0353563E2B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vg7y9kUc+m8ZG7vbUoVopvPNxo9aTwsfJPLd//OU33rTrzqKzmGJguX/EMtOvZvw+rLCMq+XhZPBvdm0g/ONe2UrZSn9vPsSOJJH98d760Fq993x7Abs5FRoCwhq70klpwg5nUR+rJHU+5F9wMkUoxZNcJ6zGqgwTbIyT5+Fv+PSquzrELijqazYzZ99nDJQQv29frCTSWv9MVJ4jh2F9cGTP3Ze2GBMsoQ7SYK/uXxxzNTLFYNYVQOJz0DBMXo2ZRh7xVqFHgyLtSKwcpQ5hbCOe7iQ3UglqmBVskHz7bx6nzRtzo+q8q5GyX25lyHT+xhcbiBfCZexZO4Num8jgwT/tqF87ZR611NeV7LkIA8JvObjEibQqC9FvWc8E//NJbtYPhCf7fE0OFk7kH3wBAMIkV9ESjoY9EQI0R+MZzrHgHoGv/JmnjaKZINGGFEUMPUpDMkFd3M5VYyZypOuTqVQJ1eZZil57lURGMjH/HVXwPzn1lJ32+1D317pf7o8RoXeTFPgFK5vEeOKMWcq4w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 08:33:45.6926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 277a5ada-019f-49dd-1f4e-08d7d0973bc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3707
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
Cc: Emily Deng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add 4k resolution for virtual connector.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index 3c9f2d2..8656cb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -281,7 +281,7 @@ static int dce_virtual_get_modes(struct drm_connector *connector)
 	static const struct mode_size {
 		int w;
 		int h;
-	} common_modes[17] = {
+	} common_modes[21] = {
 		{ 640,  480},
 		{ 720,  480},
 		{ 800,  600},
@@ -298,10 +298,14 @@ static int dce_virtual_get_modes(struct drm_connector *connector)
 		{1680, 1050},
 		{1600, 1200},
 		{1920, 1080},
-		{1920, 1200}
+		{1920, 1200},
+		{4096, 3112},
+		{3656, 2664},
+		{3840, 2160},
+		{4096, 2160},
 	};
 
-	for (i = 0; i < 17; i++) {
+	for (i = 0; i < 21; i++) {
 		mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
 		drm_mode_probed_add(connector, mode);
 	}
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
