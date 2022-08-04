Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48206C25B07
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Aug 2022 16:04:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63C34112673;
	Thu,  4 Aug 2022 16:03:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 980579BE0E
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Aug 2022 16:02:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgXKfVMoRNN5jcxY0mZdKzXhQAPy/alAyPLpY60NXxbPo9nsSg8FZi3vmzl2cn5tLJwze+c2cwrTdozwn6+NXFePqFHXgfihef1/3vYwg5M0Ry/nxkUmVvWbgoAG8y5l4vtVPaQSle6N1RpD+YEE3G/ehxn2302jVoySWMQGDWYCA2Ed6+At35IoxS7dq9RvwMnLdnlGxiW2SgISiulsqPm/d2vGrqqwHoOZJ1BSAtEQ3NmB5KcBI2j5PZH5ZDfMHxQYfek7OMDdlygR/+6zL5LPxHMLf45LTuT+tXOwYe1pEp6uAxN/xectO9gKBmFdP+RMbxqBG4oK4dlxeUhxyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rN67Xnt8VMzq/DjVYOYBxoMn2oe4EuhuEYJo2z1xBPA=;
 b=R/xBYhN548NII0YYqN3zYSB8yLzUtmYnSswtpYpJiN0B9EqYa7AjNfZ5dTHNYgaW1BiXrlF7ssCPQEgu7HzgfVjkA4QK1tWsE3WWK7ZF6eStipH9QsnJ9VIa8zP7JFo6PAwkAkTBadDlp7MB2BIp7+E5ZWwyjZF0N8HyG/rY1R3Pcp8NLoMpBdsrzKpraIv+cUdXyHYrpgZcYrQoIl41cavHtnj0Rxax7BCFE1TmUQbxNwMyBe62wp2E0HG5VdJV6bpY5BXD/qRfj12SDbCSozks9+kTxLOT/nJCg1u1Y6Ky1rdE8p3RkwJNNaPOHA/h1kj78rIOdMZNAeVbNkZzVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rN67Xnt8VMzq/DjVYOYBxoMn2oe4EuhuEYJo2z1xBPA=;
 b=EiDJwlQqxADWKdyuzwGwPw93BTEWukD1x1rPDKEuBwJzzSWQSlSIjcxS8hF0ZXQr1RJg87PTUZahqj7JCHYMeNYh2hpXB2lmjacwFtoVlOh5rpfpBcZ08ArGfclHUaMxDeAN3ILj8yp7K7C8HDUccXtxgfvhyznp/QIRoe+LnA0=
Received: from BN9PR03CA0776.namprd03.prod.outlook.com (2603:10b6:408:13a::31)
 by IA1PR12MB6458.namprd12.prod.outlook.com (2603:10b6:208:3aa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 16:02:47 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::6a) by BN9PR03CA0776.outlook.office365.com
 (2603:10b6:408:13a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16 via Frontend
 Transport; Thu, 4 Aug 2022 16:02:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Thu, 4 Aug 2022 16:02:47 +0000
Received: from rocm-perf01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 4 Aug
 2022 11:02:44 -0500
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable translate_further to extend UTCL2 reach
Date: Thu, 4 Aug 2022 11:01:58 -0500
Message-ID: <20220804160158.937021-1-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98234fee-906a-441e-38f9-08da7632c676
X-MS-TrafficTypeDiagnostic: IA1PR12MB6458:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KZChqVrGCjfclnSZ753I1YCjLp4uc9LO3PdEdr/u9YzFVZkdGVSVIsXcA602BEQWYqIqjoTxT8KKv8/OkZpztcgCXGFsmyJmnkHxgzWBRi5YmZpE25m0ua2fxHvqaBG2Z7FI5tWxfAYJLXe+yCJHwBfS+I0FJAQrgSYsYDhazy9s465xRYtoVKj9yPz1j3sluyoxrQSgcvolfLHmBbbThfr8vYvENYFZAhgr25IHtAUQKjtluf27IS+zMe0xRsXdeW3jM9sbPMWmY8mfbRKBeD/HSe4qo8J/K2z4rk4Yy6Gkbbk6LHmIpvb+BtO2VTKJ36TH8YVFTIigcxC1KSgCiLJiWt2Nd9KIsYRbrMXSa1B7EX7cR2TZZJVYOKabn23oHRrKKHdLSKq0cRZFKJHnPoJkEzwIcxWQzE9qqBAhaXaTYWn6gayrB2CWPALnSnO42KywuP0EUP2KOALbg4OGMYPmggXj2Db7H96MTWMHBOKONoXkbTZt9HwLjHKnqbTrcWekhQJpU43psYUTPLW7u/pcN5F3lVJXmvpNrl8/ZLYzkZuCtwAO7jGc5Zbosv0DEyZQTvPK+ahPtn2d8eOdSERyvV9me09WcMq4Kui8PnPb0TdKcX44NZ94ScLZn/s3eSlUMrM3o1ogWUPQW3P0qsvJ22mwS48l90+c97B9cMzPAp0rPNbus0xc85Wp5WhVesK7eMKo9vDRht2MBVLTpqwQANomBXg4++Xe5hGfR8heyOyGo+cO5fR2Fq3Cu8OAgAWoi51H+/LKf1lr+szTcWrnNosH1ok1ohWJj6VFMZ/FjQRHHRgrE1BXOZwDdWCW8XlchwZXRd+NVNNryUmlvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966006)(36840700001)(40470700004)(2906002)(6666004)(478600001)(41300700001)(70586007)(4326008)(8676002)(86362001)(7696005)(70206006)(316002)(6916009)(36756003)(40480700001)(54906003)(336012)(426003)(47076005)(82310400005)(186003)(16526019)(26005)(83380400001)(8936002)(5660300002)(1076003)(2616005)(82740400003)(81166007)(356005)(36860700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 16:02:47.5800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98234fee-906a-441e-38f9-08da7632c676
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6458
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
Cc: Kent.Russell@amd.com, Joseph Greathouse <Joseph.Greathouse@amd.com>,
 Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable translate_further on Arcturus and Aldebaran server chips
in order to increase the UTCL2 reach from 8 GiB to 64 GiB,
which is more in line with the amount of framebuffer DRAM in
the devices.

Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 22761a3bb818..ab89d91975ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1624,12 +1624,15 @@ static int gmc_v9_0_sw_init(void *handle)
 			amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 47);
 		else
 			amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
+		if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
+			adev->gmc.translate_further = adev->vm_manager.num_level > 1;
 		break;
 	case IP_VERSION(9, 4, 1):
 		adev->num_vmhubs = 3;
 
 		/* Keep the vm size same with Vega20 */
 		amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
+		adev->gmc.translate_further = adev->vm_manager.num_level > 1;
 		break;
 	default:
 		break;
-- 
2.20.1

