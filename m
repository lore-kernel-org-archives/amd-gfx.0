Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DA0C77B7A
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 09:18:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7989010E31E;
	Tue,  6 Jun 2023 09:18:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53F4B10E31D
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 09:18:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXttQh6q8C93tISKiMOAFfq/5nKKNMrRR/bp/4npqDfznrRDqlqQYozQLdQzR6sncKcwzuGGHBxa0rDiB630WE/8Afs9rz6oF/ifOxM0wUerfoPdxeXJOwkHPBSbi3jpuWLFiHuCAd0ZJ4k4krcDrxSgxOpGAxxx4oj2NSFpNEBKqI33ZKoWQrKXA9pliUxq9u0vR6fXpKYpXrkpf/4ezsyOLS1ovS01gxIM5OpKphYVHxB1WmQekv1rs2QBoEHXfBW0LC0nKLfPWUhJz8LD6vs8JyKMj9m9DCwU+MKHT1TqQDV1+2SrnyQzU5oU7Y/cIU4UHx4rTB/V0lOZ46DwoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnLNfwWpnDV8p2K9s9TJVppFTAOEK2uOba2XDGwXC4Y=;
 b=YhR3fdR39kngs3HxlzBjOlDv14AMk1YKLwknxBekj6jYwu5NH/rXhI6NBJDgZWjfE5W1DZUQ7u0UuzVORAmRtYIuNomihusapx4R75doX7qJQE8yEYSEkxVxhUDX08LbHX+e0oEo8XXdMyGjxHIrsBxzymksTECyBOT4ACEHGqnjpGItmdAfg22mnuGbZFnbDRAk1KpRj7Tr1QKVoNWRfP9lpOp4NOqJNxPy8KdWAWuXROnlKgewMSH7at5tcXLZ2CNA7h32pH5vI3Y/+IjkfhrisSTi25Q6TY9HHOIaLbRkSkTQU0wj82y/ivpi5r19G+yfpoiMMHclasdbO8KtsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnLNfwWpnDV8p2K9s9TJVppFTAOEK2uOba2XDGwXC4Y=;
 b=dtGcZm9y+jZFpKe2QLX3EgTRzy2IqpVj1s5dtVYuQuZeihw7995gLJIR5NF2hrYLBu7m1QoMYJ2Hc/hTCCjBnvWyGCrizavQJJ165WSLbZHfEmSemZm4govKWhjF/j7TSiWPnAelDfgSeg7KLaZk+LfAjn3VlUHW2d6A+vVJb7k=
Received: from MW4PR03CA0087.namprd03.prod.outlook.com (2603:10b6:303:b6::32)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 09:17:51 +0000
Received: from CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::bf) by MW4PR03CA0087.outlook.office365.com
 (2603:10b6:303:b6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 09:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT080.mail.protection.outlook.com (10.13.174.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Tue, 6 Jun 2023 09:17:51 +0000
Received: from kullatnunu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 04:17:49 -0500
From: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH umr 06/17] gfx10+: warn when halt_waves isn't used
Date: Tue, 6 Jun 2023 11:17:14 +0200
Message-ID: <20230606091725.20080-7-nicolai.haehnle@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230606091725.20080-1-nicolai.haehnle@amd.com>
References: <20230606091725.20080-1-nicolai.haehnle@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT080:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f17019-4f7f-4eaf-3526-08db666ee757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PHR4szCINt/HxfDucvhFEGHVlwA+Uxuud1BYlFUt6Ov/12Fa/A/Cr/hOy4ho2U2XKZyKCBkPxjvIzgqNaswv1x6VSa53sE2rGHjipWP5zJ3I2XiL4EuzbfUd2ixtIQJh6PN4TtKTt4OFihGP1Nea+VzpXwe9bEzxwvkF5kjjNy8uS2cgDVnl3hMkc7bRA0wS6YiXkgOANkXwHPc9Yn2ynpf0kLkKlvF1VYro+WqYEBjMGbJsdtyYPSM/o/FV8JU7k8rB1UbDQ6igpC3PNoJ5jeSnbPAtSnlSVqq3ZLJvWI2iHN5u0WsMhMqOaZo3pHToBVDK9v8CGl2Hta1Cu/DCynA4fFMwm33/A4rHkpKtmBRZsco5rrgDE22wwBNYnX7dPAf9VBmPPSwms9f/sFHKs3WA8YbFUFfPFWLIvg82V3n5/phXL+OM68vKRrZQ03jo0KDEjfPoKTsaS32GHwWKYZyFJfZyUndruqb4XUrNSb5Woqa99h3pVqahHczSiglC3CmMNe/F/5n0+/JpahBj0AXDzOxOQrnefl7t9h543jnZ3YH/qYg+qA+OFD4rPKtcmREbZkY6fpilgoX1jdepOt2pgzo9f06BzCezh+7P8dKcON8mZmGabX6+TbsCGXAbaFlmNqzE12vrYVPfdVF8cf9t6NzH9JqXoySQDPIQYqXfd4/9UhY3SIWK/qBTAsB1zWxdp7BH+8S73Q5ZGin+uy0JUJt+z2K/Svj0AmULW2RGf0/oGDfCnkMWsfOZmw0offN91Nj9aRyhzqLBwktDqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(36840700001)(40470700004)(46966006)(47076005)(83380400001)(66574015)(426003)(336012)(40480700001)(82740400003)(478600001)(8676002)(8936002)(70206006)(316002)(356005)(70586007)(81166007)(4326008)(5660300002)(6636002)(40460700003)(86362001)(41300700001)(6666004)(36756003)(2906002)(7696005)(82310400005)(36860700001)(110136005)(1076003)(26005)(186003)(16526019)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:17:51.5182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f17019-4f7f-4eaf-3526-08db666ee757
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038
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
Cc: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

gfx10+ are particularly sensitive and are prone to producing completely
nonsensical information if trying to read from non-halted waves.

On gfx11, we really ought to take SQ_WAVE_VALID_AND_IDLE into account.
Rumor has it that reading from active waves can even lead to hangs,
though I've never witnessed that personally.

Signed-off-by: Nicolai Hähnle <nicolai.haehnle@amd.com>
---
 src/app/print_waves.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/app/print_waves.c b/src/app/print_waves.c
index 04a4447..89f4abb 100644
--- a/src/app/print_waves.c
+++ b/src/app/print_waves.c
@@ -376,22 +376,25 @@ static void umr_print_waves_gfx_10_11(struct umr_asic *asic)
 	struct umr_wave_data *wd, *owd;
 	int first = 1, col = 0, ring_halted = 0, use_ring = 1;
 	struct umr_shaders_pgm *shader = NULL;
 	struct umr_packet_stream *stream = NULL;
 	struct {
 		uint32_t vmid, size;
 		uint64_t addr;
 	} ib_addr;
 	int start = -1, stop = -1;
 
-	if (asic->options.halt_waves)
+	if (asic->options.halt_waves) {
 		umr_sq_cmd_halt_waves(asic, UMR_SQ_CMD_HALT);
+	} else {
+		fprintf(stderr, "[WARNING]: Wave listing is unreliable if waves aren't halted; use -o halt_waves\n");
+	}
 
 	// don't scan for shader info by reading the ring if no_disasm is
 	// requested.  This is useful for when the ring or IBs contain
 	// invalid or racy data that cannot be reliably parsed.
 	if (!asic->options.no_disasm && strcmp(asic->options.ring_name, "none")) {
 		if (sscanf(asic->options.ring_name, "%"SCNx32"@%"SCNx64".%"SCNx32, &ib_addr.vmid, &ib_addr.addr, &ib_addr.size) == 3)
 			use_ring = 0;
 
 		if (asic->options.halt_waves) {
 			// warn users if they don't specify a ring on gfx10 hardware
-- 
2.40.0

