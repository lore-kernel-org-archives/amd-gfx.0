Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A331C7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCA2610E42D;
	Tue,  9 May 2023 22:21:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 389E710E42C
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qlw/QU77uRsZLptnYNIzV+Q7pF1qGp0CJGjLDTJtWdupxMAUo3jLoiL18awetOHAV30eospTxDbMKRSlRtjtIc4hkE1eEMfTx/Kn46fIf2FvLXKINbdwrNxOHsLBuIyyzccMjzt6cbpkpdEUdoNLAo8C4S4/Kj0GoOXccdTPh51cUqCk7ot6AR9fXXHXYzKzx0LP0HxC8wp89zHqHmnAaWEsyZzroC8RgpwFim3k8wHSEbEtsqq8BOXCNh9Ba3xw6wn/rHH2dEig0gwbNRrIuiSnS9p5s1LOGRN5sauzT0JHQPZUIc7Buh9vYNS+gR1tiW1NNrlVVhc4AMSM1fG0ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYiUXZ2z9WDRwF51nvQZ+IoOG+i6IM+4apN0WgmlEQY=;
 b=IQOxgpYr6HlYVClSU1OMeO4SNXtuMoCTsJ/PjZrBQ1iia098vmkIskJjrjUx8fAA0/yxZqozYBejCRRL3WMNsoE6COGY9CEBSeLmsNaMrQL6xSPkiDKiLoPDTHHrp8o5+AaAPK7Cb6UsGqkBtdmsIcNw0rw12QuxvNJC9UDZl5Qzm8rN56zd5qHd/FkSulBTUsHX/P6JxCQ7R8UUV8RaN3G3wmoDaysyAbAyXtbTb478B6VjoFPADD+8w+z3XF+X66zvlgmfZDAwMLpyAKY4CeRYoPpLenVri1usTIXGcbV9G02DKuNuoV/WvQQGaoLvDYjmXsIFj+ihbSpVjRQwZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYiUXZ2z9WDRwF51nvQZ+IoOG+i6IM+4apN0WgmlEQY=;
 b=OWoDrNJA062A9a6oV7wBuZ17Jh/TetMh7BlRBMlyxy954hTOMMnqExoVBO9sbTGHIibq9tSTvu1uteaSUYg8qI25NZ+im2Bm2+xI5FxZgwaXkx5eu4Un4ZGTwVNotJubUhukuwrjszUIKgpsmo32ii1os/Db+d9a2HkW2+LrX54=
Received: from BN9PR03CA0955.namprd03.prod.outlook.com (2603:10b6:408:108::30)
 by BL0PR12MB4914.namprd12.prod.outlook.com (2603:10b6:208:1c4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Tue, 9 May
 2023 22:21:40 +0000
Received: from BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::8a) by BN9PR03CA0955.outlook.office365.com
 (2603:10b6:408:108::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:21:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT075.mail.protection.outlook.com (10.13.176.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 22:21:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:21:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/9] drm/amdgpu: Add reset_ras_error_count for vcn v4_0_3
Date: Tue, 9 May 2023 18:21:20 -0400
Message-ID: <20230509222126.477847-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509222126.477847-1-alexander.deucher@amd.com>
References: <20230509222126.477847-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT075:EE_|BL0PR12MB4914:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e30572c-7078-4526-443c-08db50dbc330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A2dc3dutwsGson0ilEGgESKNnM3KR0V0G21XmywnVrX6xDVNsqZ59mzREH1j+mLrEiS/uKMjMgr1kywqk8rqS4Swjhpxo1T0cG8Sy2ErKajm6UHCtC6sClyt3yKu7cbWaRzvW4c82UPjZBcF3Inqs+f5cBFWeC6BxDEeQWvO2YsOULA473p+H5jv8PUtJ11cGZf1W+NdXKCgIEav84cBaO/HKkKaOaAAeOBIWGsGPoWZrQtudufjTG8iC56Ik0xkSUXbvLV3gJyyzUURsjbE61SCzmbsD0rCh0Mf7XjUZS4N3ESF36cQbKqBVWYeHPKdolGP7DslviKpyMq3J785QgoodWGqpnO2lqKXtatEXuwtaMQPtitAa7Bf2I4OeWgFp6Kzeh7tCkVUhKAkui5RZs6Ci7Jj7r2Hc2bW55USXDOMgu5r4GqMCBJbYS37Go3t5mwUA60tHQQvaDAzUMDhXr4Usr0JJOg507V9ea7ca8xTBnLaJ6U/RtLPW0pE8tZsebzuupq5+i0NvyGgdzxQ43QzTZ4oQUVsz3U4P/8ypCZomqsvHwYsKCgCdSJks8XN6ioMdeoQQ8qPGv7JUHMf6Q5vN7T9c9v90pIOsp+9j/rpeSatlzpxVsbIpJVKoBSGO0Gm+IZQEsSli4xWW3LbfJ4aTd/w98eTPIxhAMgrfieklkz2QNAzSVx2mfNGp6d7IXVLsaLNwtR+DdjY7TTS53vGfwf1LgkVGTg4j7J+1Eh44c6Mv240gvHoIGGuHV7lzAOu0CKOZ4cAYB6rndWJDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(478600001)(2616005)(83380400001)(47076005)(336012)(426003)(36860700001)(6666004)(40480700001)(1076003)(26005)(7696005)(86362001)(81166007)(356005)(316002)(82740400003)(54906003)(4326008)(70586007)(6916009)(70206006)(16526019)(186003)(41300700001)(8676002)(8936002)(5660300002)(2906002)(40460700003)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:21:40.5368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e30572c-7078-4526-443c-08db50dbc330
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4914
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add reset_ras_error_count callback for vcn v4_0_3.
It will be used to reset vcn ras error count.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index e5037d6f884b..e8933039bcd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1466,3 +1466,25 @@ static void vcn_v4_0_3_query_ras_error_count(struct amdgpu_device *adev,
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
 		vcn_v4_0_3_inst_query_ras_error_count(adev, i, ras_err_status);
 }
+
+static void vcn_v4_0_3_inst_reset_ras_error_count(struct amdgpu_device *adev,
+						  uint32_t vcn_inst)
+{
+	amdgpu_ras_inst_reset_ras_error_count(adev,
+					vcn_v4_0_3_ue_reg_list,
+					ARRAY_SIZE(vcn_v4_0_3_ue_reg_list),
+					GET_INST(VCN, vcn_inst));
+}
+
+static void vcn_v4_0_3_reset_ras_error_count(struct amdgpu_device *adev)
+{
+	uint32_t i;
+
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN)) {
+		dev_warn(adev->dev, "VCN RAS is not supported\n");
+		return;
+	}
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+		vcn_v4_0_3_inst_reset_ras_error_count(adev, i);
+}
-- 
2.40.1

