Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FD5EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 12:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2DB410E495;
	Wed, 19 Jul 2023 12:40:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3189110E495
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 12:40:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIBDqg79IXHGAdOYpRnaOADSOGWAlDL0tYXFXLY1xP3DN+sf5G/0AwD8oAfWPPq/VuxJRhgxFQmoOJjZO9XYZQokJytoz5QDyJghiSf3xrMxGBceI35ije86ONEzPMDnUcMK45xlIco3zMDu40Al9X59Rh10Zzmu07RFAtuMGl1I/Ni7cjq9j5n6ItX7CcZar4gidazeXkGx1vyE8gNuvjn52GmQ4damoW4FTSVimKkqJNZyE8ET2jilgniyHWzlAgcyL+tAbbdWnrARKdRcUsK6l+yImV3dNcriQUEth45d5cbRhkY3qDOKB+75VWwdAFKtjqBTsWdJ3Imzrt9+fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwk/tdqdUVmnUW4LYDRITls7rJugeMe23mkKRtTtDqY=;
 b=N6V50rN+/GoSwmVlT4YRXtVKLZC+7c3UkqybAaMKe8DZzZR3ymPteCMqOLGfm/3KrzCws+d3R+yaq4VjrYKWG00yjQDZe8NtsV9c+CZx4W9NltqUhzvx0JSfBoPySNEvnmITCsYEIbwSoTI7+H37wSJ3iQyOI9FosLPsZkAtnM75davnBGdx+YOXVHk3Eps+5/0wvM+YitxkVVfAc/COJrz2N+l8JN9rwlrRapoKt8CukybiFBA30EvVITfZ55BcNta32/Qseg2r/u2Lwy4sPFjo3XiBjJgSMoCWi4tFNgtF+18FxqrVE6Y5CCeYS+c6oOr9V5jpOJ5P4Vovb0Xrvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwk/tdqdUVmnUW4LYDRITls7rJugeMe23mkKRtTtDqY=;
 b=xJhZJx0D/1F34ag8Nhc4ZjEjLH8RMnAsGONPI9VhBxFuPAcn/gaDiCwPIewsEnq9vMbNMqi1Cj9EjN5IT94YK1VSRZmVR2wcLx6FCi92BxPsN6W0BwyeT1OK5JRSKToE+aVipliLX96AdRG7T69hNK7908TIWTINVLlY7Hmd1h8=
Received: from BN6PR17CA0038.namprd17.prod.outlook.com (2603:10b6:405:75::27)
 by DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.24; Wed, 19 Jul 2023 12:40:49 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::f5) by BN6PR17CA0038.outlook.office365.com
 (2603:10b6:405:75::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 12:40:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 12:40:49 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 07:40:47 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: not update the same version ras ta
Date: Wed, 19 Jul 2023 20:39:56 +0800
Message-ID: <20230719123956.1163008-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230719123956.1163008-1-YiPeng.Chai@amd.com>
References: <20230719123956.1163008-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT042:EE_|DM4PR12MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: bf131d00-119d-45b0-eddc-08db885561aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/9dD3l7uIf6ASv5QIPrW6FCLp1zNjyWj8q+tNCroRjx2pEAgZZEdm5frruDHhLNN2nLBDW3HpdEXFlYJpsuKjys6j6jfAwwH0EG5u11DTEjNL4e9Dx40bKEOrOC3l6urhN+se4O36qRFOfA4G3k/q0p4ejtpRO0eYa/Z1YYxWKzOeCcVdBmkgP3PJPZ+7GNsiYnOyEtnZ6HVSV8reIeo5Qnk9vnK+b6tEikbq9IbJ7GlYTuJQbk6dn2ecbkiXW0dTFkNkt5HYA2knNQknggjrwSSXmHSHafuE0e6GGftvNzRnG+rfNPxysUxS9B3ffGWrZZ+ksBkOQob8NzNcdv58cDbycYeRZVF7jOBX4vxhh3mA9iunsmiC2CEEiBFD1Y7EsxP6yqhKABh5oCavKUjTu15I4Y4wj8SEAseuAvWy/mSosxzUiBnvsWu2KqFGcVEJ9LPp8XP40NOew1P+CZERbVyIzwPNTep+dupH/eJjp3AktmHTXRntPJc8tOxHpDhGsVpP7vPmBZodRfAEdAGvKLc362ly7iFjAkeFbiHyiiMgRMx+4eqckWCKvWwcvuvsiPg90CSLEMugbs+1gX+uJESEtQXORgI921X/rKBbf7bbmEHN+EcdX6jL3dvHr+4Zn0XvKTNrFYJY/rsHLM7vxj+e0OJ24s52h9Tpd3wOYpbqJtYHhivsbKP1iwha+0ZaFsk7PbeKm8IJYIdRFOhOorfL0oT8OPPCmwkW3/Z7g58az0XOp+OL1sp3N1z14qlNSTNcUfk7I4PODVMmsgMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(40480700001)(54906003)(40460700003)(478600001)(356005)(81166007)(7696005)(6666004)(82740400003)(41300700001)(5660300002)(8676002)(4326008)(6916009)(70586007)(8936002)(316002)(70206006)(2616005)(426003)(336012)(16526019)(186003)(36860700001)(83380400001)(47076005)(1076003)(26005)(86362001)(36756003)(15650500001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 12:40:49.4778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf131d00-119d-45b0-eddc-08db885561aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6469
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
Cc: Tao.Zhou1@amd.com, YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com,
 yipechai@amd.com, Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

not update the same version ras ta.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
index 049d34fd5ba0..c27574239fde 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -120,6 +120,7 @@ static const struct file_operations ta_invoke_debugfs_fops = {
  *   Transmit buffer:
  *    - TA type (4bytes)
  *    - TA bin length (4bytes)
+ *    - TA bin version (4bytes)
  *    - TA bin
  *   Receive buffer:
  *    - TA ID (4bytes)
@@ -148,6 +149,7 @@ static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf, size_t
 	uint8_t  *ta_bin    = NULL;
 	uint32_t copy_pos   = 0;
 	int      ret        = 0;
+	uint32_t ta_version = 0;
 
 	struct amdgpu_device *adev    = (struct amdgpu_device *)file_inode(fp)->i_private;
 	struct psp_context   *psp     = &adev->psp;
@@ -168,6 +170,12 @@ static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf, size_t
 
 	copy_pos += sizeof(uint32_t);
 
+	ret = copy_from_user((void *)&ta_version, &buf[copy_pos], sizeof(uint32_t));
+	if (ret)
+		return -EFAULT;
+
+	copy_pos += sizeof(uint32_t);
+
 	ta_bin = kzalloc(ta_bin_len, GFP_KERNEL);
 	if (!ta_bin)
 		return -ENOMEM;
@@ -185,6 +193,16 @@ static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf, size_t
 		goto err_free_bin;
 	}
 
+	if (ta_version == context->bin_desc.fw_version) {
+		dev_info(adev->dev,
+		   "new ta is same as running ta, running ta will not be updated!\n");
+		if (copy_to_user((char *)buf, (void *)&context->session_id, sizeof(uint32_t)))
+			ret = -EFAULT;
+		else
+			ret = len;
+		goto err_free_bin;
+	}
+
 	/*
 	 * Allocate TA shared buf in case shared buf was freed
 	 * due to loading TA failed before.
@@ -209,7 +227,7 @@ static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf, size_t
 
 	/* Prepare TA context for TA initialization */
 	context->ta_type                     = ta_type;
-	context->bin_desc.fw_version         = get_bin_version(ta_bin);
+	context->bin_desc.fw_version         = ta_version;
 	context->bin_desc.size_bytes         = ta_bin_len;
 	context->bin_desc.start_addr         = ta_bin;
 
-- 
2.34.1

