Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997A0C432BE
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 18:32:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 359856044F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 18:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 359856044F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7E8B6E40D;
	Wed, 25 Aug 2021 18:32:53 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2060.outbound.protection.outlook.com [40.107.212.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72D336E40D
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 18:32:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExyAMAA0oxwY9WyjbunWZwdqrbVd6ImWSrVnOTs3CdqqLT0sFJV96Xn/pYd61HYrFyBAjeXS1dACslw70gocnw6zE7C5OyQD1bo3P1qph3ct3/sgY8YFsBN+uCdX9vCNh2dOrUn1oQmiYkbyeLhwYqyfJ+2dQZBTVeJ5DCUGc9JnbC6uRtNkDF6OjxQKhm1fa8/ig/QXStw/4iLaNV+DgmXBBk+IFAleRQaMoZedNzYymUTjEepGn8odc+3QLYxiJl5bEDagwZc0gQxldFVC5OC26ra1qpyf468D9qKjzYyV9PqFECGC6vH4QICYssAZCIiFejjUu9JBUk4ywgoJTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Aq4XvhKR31Zqgps8LvmEOdjcUdaM1F7bx4oAWNXu5k=;
 b=OahyqRdmfIDncSuz9KBRF0W7pucVFHhiZxqhijpt7VCNvT782wLnJTb3a5kNNzjNGvcuLi1kEzaXx6w7oBu3pxDQ9DaqaBYePqVGwKBa0dnVpk5Uo//9494lNz+Aev/t0aEzZiwYi+fpd7rt8hnkPl08XY4MskeEX+BlXtpAFz0H5PlUAj/oJlPnwzIMA8dtAy4FAhxF/XVm2A8El/gKI1ui86t3efrllOopytSnais1brhM9b0S1uw5voq5sFOGnZLZmVrdtE/U2dLlzK/tJPcKZSnOJ5jGVov2+qpTA/afHfYjOyNgLXSFRhuIvltFFC3uFyKT9qIxdOfsEX4pZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Aq4XvhKR31Zqgps8LvmEOdjcUdaM1F7bx4oAWNXu5k=;
 b=bgT3F6H7djOTFZ5Wt2sJEG7lg59nEwbNcAScoSNergG/lVu2pdgZRAKd/++BXvhBCHudDzB4bh9yG7Sckg7kQnRwg3lT/lXK8/Wf7bgogqb6VcIaMRHiNucSeyNPR3AkpkcdBb0dRDdbVixP+vobNX9fL4eF7QEv7wRJKygPup0=
Received: from BN6PR1201CA0009.namprd12.prod.outlook.com
 (2603:10b6:405:4c::19) by BY5PR12MB3985.namprd12.prod.outlook.com
 (2603:10b6:a03:196::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Wed, 25 Aug
 2021 18:18:34 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4c:cafe::44) by BN6PR1201CA0009.outlook.office365.com
 (2603:10b6:405:4c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Wed, 25 Aug 2021 18:18:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Wed, 25 Aug 2021 18:18:33 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 25 Aug
 2021 13:18:31 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Luben Tuikov <luben.tuikov@amd.com>, John Clements
 <john.clements@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Process any VBIOS RAS EEPROM address
Date: Wed, 25 Aug 2021 14:18:12 -0400
Message-ID: <20210825181812.4359-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210825181812.4359-1-luben.tuikov@amd.com>
References: <20210825181812.4359-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddaa9a22-4b57-4799-1fb4-08d967f4bfcc
X-MS-TrafficTypeDiagnostic: BY5PR12MB3985:
X-Microsoft-Antispam-PRVS: <BY5PR12MB398500B0D7D3EFAE84DD222E99C69@BY5PR12MB3985.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWFHGwS7dPWIAycxtOLn9fVOXBtrPhDulbYcbqj/Kfl8Y6fbFPiSu88vuf5v2lDYoPsANKdSW5fteKVz7Jb9rf9DEYSot2zWlsoQsdWwCfAAbtbN7iD4k3hFsmIr54FAh2hmXyRb06UYhxIslk+0NlGJyLo/TGlWYGXsOY0FBlt3tPM4Y60v16GGrzXEXbCA8sDPB2XazgR3SPPNQeZhuIMyAH4TzVf3Kw01xid8+zp8veJzRGo1/PtRV8Na7Mme2rRLuC/5awZZ2KSuEq2VtiHql88h6WrsrflHgV30YduLTkEujZYTR7LgVIPYQ/eWbs5bzP161cYElqoZB8pTn8kWb0boaYeNBG2GQCDhhfNyJdXuOX25ggqHJJm8fn1xRpzSSBp/JON/XiGXlvxIT+7t2YtOmKi4Ot7Ta2Cfq8Hv9bRk+ZtV0d6jj70eExfTYSbX7BhZcV7SlUoLq6ngESvu1mZsjKT2CPeNHVXiQ64rP+RWB85GoY0AaS16JM9px7ndn45mb8Nlv3mj4HjGYnW+j2LomGOp9xzMc97GCsU76ZXGsWgiQPeiMFFSdmk8wlXdplyNewJH0yi7TIHLyy2oj9p0U1QfojT8uMhnI17SHEIwBWxc55x6DjWM/gAygIcfItvM5zQy2q9mxmG/p/m5K2GeDU9WTeNREL5DNOSwNhH5HMigY/m6/zA4ykqDX66cuc5S4ZGtAgyGAMBFCnLMhDRwqi3ydUVxNHfjPJ8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(508600001)(5660300002)(4326008)(36756003)(8676002)(1076003)(356005)(2906002)(70586007)(47076005)(6666004)(82310400003)(36860700001)(83380400001)(186003)(54906003)(86362001)(316002)(2616005)(81166007)(70206006)(44832011)(336012)(426003)(7696005)(26005)(8936002)(6916009)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 18:18:33.6712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddaa9a22-4b57-4799-1fb4-08d967f4bfcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3985
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

We can now process any RAS EEPROM address from
VBIOS. Generalize so as to compute the top three
bits of the 19-bit EEPROM address, from any byte
returned as the "i2c address" from VBIOS.

Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 194590252bb952..dc44c946a2442a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -114,21 +114,22 @@ static bool __get_eeprom_i2c_addr_arct(struct amdgpu_device *adev,
 static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 				  struct amdgpu_ras_eeprom_control *control)
 {
+	u8 i2c_addr;
+
 	if (!control)
 		return false;
 
-	control->i2c_address = 0;
-
-	if (amdgpu_atomfirmware_ras_rom_addr(adev, (uint8_t*)&control->i2c_address))
-	{
-		if (control->i2c_address == 0xA0)
-			control->i2c_address = 0;
-		else if (control->i2c_address == 0xA8)
-			control->i2c_address = 0x40000;
-		else {
-			dev_warn(adev->dev, "RAS EEPROM I2C address not supported");
-			return false;
-		}
+	if (amdgpu_atomfirmware_ras_rom_addr(adev, &i2c_addr)) {
+		/* The address given by VBIOS is an 8-bit, wire-format
+		 * address, i.e. the most significant byte.
+		 *
+		 * Normalize it to a 19-bit EEPROM address. Remove the
+		 * device type identifier and make it a 7-bit address;
+		 * then make it a 19-bit EEPROM address. See top of
+		 * amdgpu_eeprom.c.
+		 */
+		i2c_addr = (i2c_addr & 0x0F) >> 1;
+		control->i2c_address = ((u32) i2c_addr) << 16;
 
 		return true;
 	}
-- 
2.32.0

