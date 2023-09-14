Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF7EEDE99C
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 09:24:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92D8010E27C;
	Thu, 14 Sep 2023 09:24:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8214110E27C
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 09:24:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ns2U7Zjk8uGNVz5sQ3x+fS4Yw5l8PgJr99tGqzCzvNpybrP6670Z54RsnQ5PcZC5DXS9EbeoVPUaJW7tpPgvmArnZpRjzAbrvbkVUhUvnPvLUAhwDurufVh8Up92OeTn821K2Sn8l4cg6ryumHwc3kfnmn2/iL+K1uwDaH6tp8wsRvDMGRTLAaw0J09FM64VJPQcuWumnyP/q5V14SEPVMc/oQwZ1JUo8ee8BtuVZUjgmazo9y5uK6ytpuveEnp4cyNfsb1s/uaxtCsVn/txWn4qleFpnQOxSwsr28hUkvarfYCN+eWL/+1ngRxtSlI+H6cznqPTqz/ooHpUrtbjjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5wrGDZqaJUKbj0ldCzjJYsBMGCF/Pwg1jTiYWq5g24=;
 b=aIjmEW9VkaTiTmjA93zn0aytcF/a5GaIKfZLe9F8m9cP++biJqOQ3xIVwRZKtvu0wMuK/aSkYXlnKP96/0slXrqIgkIuNXn8VklbSlytxReFqZQYtgp/YXrSQsYAMbog6L8Ouc0pn5O/Fhwmq1fxrnJqNOf2Ypis6Di5GvPyRiXlVaWXnFEqqtgqSEJhIs05vkQ9/53ticGjhBrNsGlbGoI6G6RrIDLXhjYsQ2hbaBbPKcaFve4PiufRjPNHmPVvmAl0xV3OZarP4SyKYSMTW+jzj6uCL1YLLPpxr9eo/78OwvtUtKnLCZ54H8Z7bjkHVKKQKAlGeBzoMDBy9uIF4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5wrGDZqaJUKbj0ldCzjJYsBMGCF/Pwg1jTiYWq5g24=;
 b=S8r2L8kWoSlxrJQ8zvG+OAFTQmvbW8c4om3CEyNL7bmFgJZLPQBlxidvgYcq9i7ROSZz4hgjY8bBK/i4MD+7DUfjq++1GlTnXOzE5uM3nADn2x/grttv5mg+2KAJM21YG2l+lZRJp+yvB23OcKRAuukvcVM3zNy5W0IGIU6fjIU=
Received: from SN7PR04CA0119.namprd04.prod.outlook.com (2603:10b6:806:122::34)
 by IA1PR12MB6387.namprd12.prod.outlook.com (2603:10b6:208:389::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Thu, 14 Sep
 2023 09:24:08 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::23) by SN7PR04CA0119.outlook.office365.com
 (2603:10b6:806:122::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 09:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 09:24:07 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 04:24:04 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix vbios version string search
Date: Thu, 14 Sep 2023 14:53:47 +0530
Message-ID: <20230914092347.1233562-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|IA1PR12MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: a6784671-3584-4447-2cee-08dbb50458cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nCNNR27TQqbJ9hmc2yJHaiTaFXjLJ9svvnSjJ9kP0noIz2byx+K7PgX5cPmFqiQB6mwflZlUp/zlI8b5y7QeEtLkZyt96Z4MwvCSfzjE7xEsHbSBeTg9aQUo3wXoNbHnpyjrO1HZujEWUg899DR8Dcq+JSb/whBG6nhP5kw+vMLCVdrKuO+x5OQ867bFkYlGqKpYO9tRRIen6TvasXNJHy3dWMSGbQBj/NIw1o0XRteqwk2pCcUjJPuDfGVb592P1p2R1LZwsNmVQPTO+6hVPMld/dJg2egQJ1ZV/CJzLDCr7Dd6UqZ3/q2idyTse05bWOQ70qB/+1OH+yDKnzxx9SUwdMozOjd5PhsTU4ya/LDbcrLrtBvg8LybjI0ZeLPFYnVSjWDHrEb3aLC+WcA/087KcC5Y1WMqwWY+oOnvg6OjJVKbO1tLTXvbKltXRc0WOCQb4w9wsQ5+tsPRPIObWK1jnnOEmyriOe59H/lpbwvaQuD20f+kcBEZZtqoM4sshGts0CiOg7iZurUy3GuaOxC2emmJALA//HR2c9ooamX2QRIhJMnAiDYuyyKlGsY4mY+tvC4ZaV08Ioisui32spkiwTu3g34rfllO5Z52oCUpeXJ0LhxRMTgweGVFlYdgygdtO5hRjhHO/Yk1uEUq7kI3e+1m9XbyFm1aGpVUw+icbz7Odd3cVqD2/M2QBrPA1NCor9B61WVCh/Rlcm8O6IMdHlLGyHniAy7rjFCOvdXZnjar2IjeWZcEzHaDyon49hilAOnFgJ5yt8DaQW9Z3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(1800799009)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(356005)(47076005)(2906002)(36756003)(86362001)(40460700003)(81166007)(36860700001)(1076003)(40480700001)(6666004)(82740400003)(4326008)(16526019)(70206006)(8936002)(6916009)(8676002)(54906003)(70586007)(41300700001)(478600001)(44832011)(5660300002)(2616005)(316002)(7696005)(26005)(426003)(83380400001)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 09:24:07.6901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6784671-3584-4447-2cee-08dbb50458cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6387
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Search for vbios version string in STRING_OFFSET-ATOM_ROM_HEADER region
first. If those offsets are not populated, use the hardcoded region.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 9f63ddb89b75..2c221000782c 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1444,10 +1444,27 @@ static void atom_get_vbios_pn(struct atom_context *ctx)
 
 static void atom_get_vbios_version(struct atom_context *ctx)
 {
+	unsigned short start = 3, end;
 	unsigned char *vbios_ver;
+	unsigned char *p_rom;
+
+	p_rom = ctx->bios;
+	/* Search from strings offset if it's present */
+	start = *(unsigned short *)(p_rom +
+				    OFFSET_TO_GET_ATOMBIOS_STRING_START);
+
+	/* Search till atom rom header start point */
+	end = *(unsigned short *)(p_rom + OFFSET_TO_ATOM_ROM_HEADER_POINTER);
+
+	/* Use hardcoded offsets, if the offsets are not populated */
+	if (end <= start) {
+		start = 3;
+		end = 1024;
+	}
 
 	/* find anchor ATOMBIOSBK-AMD */
-	vbios_ver = atom_find_str_in_rom(ctx, BIOS_VERSION_PREFIX, 3, 1024, 64);
+	vbios_ver =
+		atom_find_str_in_rom(ctx, BIOS_VERSION_PREFIX, start, end, 64);
 	if (vbios_ver != NULL) {
 		/* skip ATOMBIOSBK-AMD VER */
 		vbios_ver += 18;
-- 
2.25.1

