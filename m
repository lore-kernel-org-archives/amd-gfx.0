Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADDDC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Apr 2022 19:57:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F1D910E079;
	Fri,  1 Apr 2022 19:57:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0F7410E037
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Apr 2022 19:57:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eP4acsiUvVaQH+EhViYxs5CUBpIUDlp2kj/qmeKYEWaju222R7KhVtuoQUo0DCYfb5+oKkazidJKqdPMbX50FJc9f6QELC352XJIj9MvwXyieD1LZWbI00+6Hb4YCk1ozLmg++pa2VVmEZhI5mQ60ked6WR/ZZfPX7NuGCVWl7nU6Gvt+Pioop9l2rrkp2rOgDS6Zo1PFOgEKuXiyRqY25YPev00HnihChgMJpc3XkSmKqiKNDmTWoDb1W+UFwYYR3jzXzs1C2HUaMlnE78knDzzssp15LCPW6lSBwgeNzmvXy5//DNOkYM6ASvmT2J3kYG9Zd2r+G/6HxrcCBaFSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqd5/KlT0jJmStj7O/HMwLCgEW4TYwmcHMmsgwCaJG8=;
 b=WTD6rLXF6JrOBbNFWWL8G2gBTit+IklFMEjDXCXiAIyeZxLstRnLcQ22Q8lTiy1jZ4rhLKhYpSUjUM+gzerAk2uTaY7WVKJACtmSyh7N+FBijxz75c3GekHfnt5m8CSSzckwuTM1EEGvkv9o6B6LYAodyWKYHaFg4oZ6Skbt2fHtgSBmbxtT81g+OP2kuSSdX1YMSqFn4yRp1SWL3NXM/H74SIM2kVPAKTkyI7kuNOuryfRmWIePzWhne2Zp5A2rOwrf8AtVoy2FvKRq/ld6I0hUnr8mh0tzVIXJqyUVjUDwQazGtTVDbX7V5vj5ngeGkojjPsEp9tcU9qUBGIytag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqd5/KlT0jJmStj7O/HMwLCgEW4TYwmcHMmsgwCaJG8=;
 b=JhljNrBqpvm7+uPrFfu2RrmPoVg6FzggSxIZkjoAcwsJUkPFc9Pv7ivxHBJzar+7prbcwPs+xIzL/Obj2X5O4umw5hkZ0JJdExnEIONpuwY1vTb8qeZjVUjtH8mrB6q/pqv9sLe91VhYQTSQ8JQXXjqlWwAZv29m9DCshIMbdgE=
Received: from BN9P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::31)
 by BN9PR12MB5308.namprd12.prod.outlook.com (2603:10b6:408:105::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Fri, 1 Apr
 2022 19:57:55 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::9a) by BN9P220CA0026.outlook.office365.com
 (2603:10b6:408:13e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Fri, 1 Apr 2022 19:57:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Fri, 1 Apr 2022 19:57:54 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 1 Apr
 2022 14:57:53 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: Flush TLB after mapping for VG20+XGMI
Date: Fri, 1 Apr 2022 15:57:26 -0400
Message-ID: <20220401195726.21436-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caa61309-daef-4322-8874-08da1419e944
X-MS-TrafficTypeDiagnostic: BN9PR12MB5308:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5308A01168CAA152924AC860E6E09@BN9PR12MB5308.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cA7XChoKuzil9G+fK5G7I60S+ZTTDJIUoKSNBhqAaMtpw22TGniy2YGtbS0B5g/mRF4NjQdx8E8uYtFmFHx4ZnOBRV1lGJncAQmDVbxv7mcmG0zYtR42CiBhOXQTxnZVVhfKMoum98JFBe/XzONpnM98JVwmiIp1km7KyL3G0XSsg+G/TxjtBulGfWuE+9mVncSGPml4deiEqZfCr02g3DjbQbGlUZQJz7znTiuqnnhGaqpOlhAvS0D/j5guWoJm6jT6qStoJP083esIx8STHysGFYDODkD27qc04vWLekw7WJLNBX8LsJL0SO9xdvcEsO/oAlo+rvl6cP5UnwB3Q0BcQMeOw54TTUye1VGR4wDV1RvLK+hfLPGusAGlyFkFCy+BBad1mdJlXOswt1DOd5jg8KvsN6AMd85611B+tW4M+oiNmT+uegbKGPHBo0G0RuOto3tdz8VE95bwQ3D+k9FZskIzY3V3sxMqoMS19eFJZn3UDbbC8fBvlgSXcF+v/i7VVXyfAs53X7xX5CBAqCbIydUKARVqicXgizP+Gat4Y72nBdP54yT4UxpX+tiX4eFa1ESt7dsM7M4PYcDZS5r1yMbwBicLNxp7uFNDnJco8uarB5EvOp0HcckvoalEH+jc2YNoHxO7Kabu9z5q97/XIQtIJUn9TyJSBZCw7o7zS+g6Icj4InlZmYxEK1Dn+KcU9uxY3r/3y8s4OnD1Yg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(81166007)(356005)(40460700003)(86362001)(316002)(2906002)(54906003)(2616005)(6916009)(7696005)(16526019)(5660300002)(508600001)(426003)(36860700001)(70206006)(70586007)(6666004)(4744005)(47076005)(336012)(8936002)(1076003)(26005)(83380400001)(8676002)(82310400004)(4326008)(36756003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 19:57:54.5885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caa61309-daef-4322-8874-08da1419e944
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5308
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For VG20 + XGMI bridge, all mappings PTEs cache in TC, this may have
stall invalid PTEs in TC because one cache line has 8 pages. Need always
flush_tlb after updating mapping.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f0aec04111a3..687c9a140645 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -837,6 +837,12 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		goto error_unlock;
 	}
 
+	/* Vega20+XGMI where PTEs get inadvertently cached in L2 texture cache,
+	 * heavy-weight flush TLB unconditionally.
+	 */
+	flush_tlb |= (adev->gmc.xgmi.num_physical_nodes &&
+		      adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 0));
+
 	memset(&params, 0, sizeof(params));
 	params.adev = adev;
 	params.vm = vm;
-- 
2.35.1

