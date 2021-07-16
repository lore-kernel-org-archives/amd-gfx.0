Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E895BC12002
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 15:37:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE5B613F9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 15:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE5B613F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4DA06E9B5;
	Fri, 16 Jul 2021 15:37:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1DA36E9B5
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 15:36:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Agokik7j799LkQHm91YhWXB4LBc32D63uGIexAXOau2NreVpTFdpT9v+jREAqv4s9VIyAcOXoW31RqwHP+yTDsM5JoXaZkDRATXgEAm0cqgSFIM5MJ9CkPVJ573/4WxbEpeCYYEoAwXM1j+WbygtP8T3MxTZN+4CpLEjbbcBIep62L/H3MyYLkRrJXHsyXsBcRHrVj3OEcyhOK3Icnomqjvie2Ei+pMIqwiufIyZU5ZWJmTq8qQvkBeeBH+O7c22J96v0uxqnPF24SJUJadXpLnHJBCGRM5Q7jI4O+Q0y/MGmsJQwPSvRt8jwbRmLKV0w7Kj+i3bFqGTBsQY6oA12Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTsNVOVXh41J7DOyZdaSB39SarlnRC/GxnDJzDGIlLE=;
 b=LYymvDR6josMceqFZq0LMvgVs/RG6Ms9RHdNF0BgItpO60CMFioZDDcOd188d2pwuESGZvZtVT7DjUUJIBQMOfRtgvKtYBzq5h6brVVu975Ou6ImDCBMbM9kmpU7QNiFi2jUb7Z65SY2u8GybiKnS+ubwkbjLEbB+kBOdE4k/c85AMzm79u4Bsdz64pN4o5qTkZv5IWskcbK7uPpLgKrwS14R77mYSFTh/cyI5qyN3C1AkqUMNm70e854XDf/Cstaqxbrcn1Yv8hU9aFklXRqMsil0nFUToCWoXCyOACsUc5IbEVPK4uZOmzkNw78jRsdvuWhx6+4VakGoQLCvZSXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTsNVOVXh41J7DOyZdaSB39SarlnRC/GxnDJzDGIlLE=;
 b=zZ56SkoaXjqwbxedhBZZvBfDyHOhGU8gAoZmVBFKMbkAfrI7U3/Fm/t0q24awpgnDxRVi+bNG4fiQsln9hvGCimDqp+BWT82qQbiBlo8pOV++F3/srZ3uha0eBobXjas1CvFOIRFPqyTgaj/NSN/k3+/yrvrRWQkqtAceRzRtTM=
Received: from BN6PR22CA0056.namprd22.prod.outlook.com (2603:10b6:404:ca::18)
 by BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 15:36:58 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::22) by BN6PR22CA0056.outlook.office365.com
 (2603:10b6:404:ca::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 15:36:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 15:36:58 +0000
Received: from ozeng-develop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Jul
 2021 10:36:57 -0500
From: Oak Zeng <Oak.Zeng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amdgpu: Fix a printing message
Date: Fri, 16 Jul 2021 10:36:46 -0500
Message-ID: <1626449810-18044-2-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626449810-18044-1-git-send-email-Oak.Zeng@amd.com>
References: <1626449810-18044-1-git-send-email-Oak.Zeng@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56e19627-1950-4aa7-3505-08d9486f8c58
X-MS-TrafficTypeDiagnostic: BN9PR12MB5257:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5257B2CC6AD90F34AE6AC17880119@BN9PR12MB5257.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +tK2vRuIFNwyQag39gnKS6ABxF9OeJn+rRJBX3jDqzjmUMSe1wNpfaX5TcCnbFTNZCnpYm5C51cF5oPAfPVYVSxWuq9T9e/l+bZfbhKRvyiYk2/7H4ELfyud7nUr3aUP83NUgPeJTNbcrRhIkQ60G9xWNL5SLr9YuqO3HT7JvqNg1GixN8EPG7biVzkY2+ZIhtk9nUlrXMDJAtRqLs3SfCR8abXpHvVgwKf1NJrJgNUR3INvrYxq86j9bF+TS9YnxubObJwSNg0oMSZmpkkZEyRUJTMQoqDl9K/hlgHZrAOK2M4SImo8EdEo8wgafbipnhvFiVJOVIdWAGztpuIGDW6EOOmG+iV48LaQLA8H34f5yu7vuYv51u+FKq7/vUYwjLvMBNPuqtz9MRRcjF3quU9mDBh97cnmf+T+TMWCL71XR7fVDJ1t2ULX0123FFDsPjLrJvwSkO0zGemJT8djS15TFy5wf5tJXt5yLX9Zycg+elhE7g32l/AGKsjxI7BTZrshnjUtpPY5rAgxDpjxNZ1a2DFYFoOOKWfeov6chfIBFOCb7nB3cYocCviJXGbq9LoRCeCrH/noasAAV/ZnYmDZJ0j1KnwQ+EiKt/1pi8p6aSRndtW4bBzN50lMW/kpmMAYS1fDPyDMhyLjFzfaUPrR3UbhRIxEh7899ZL2jKZK/Om6fwDSZ2/z3YdVnK/4Um8M9jol6hgktY84CWn/fAZGDwKHjRe++mf0y/4VEa4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(46966006)(36840700001)(70586007)(2906002)(8936002)(5660300002)(316002)(70206006)(6916009)(54906003)(81166007)(16526019)(36860700001)(478600001)(8676002)(26005)(186003)(6666004)(356005)(7696005)(86362001)(426003)(15650500001)(2616005)(36756003)(336012)(47076005)(82740400003)(82310400003)(83380400001)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 15:36:58.2266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e19627-1950-4aa7-3505-08d9486f8c58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5257
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
Cc: feifei.xu@amd.com, Felix.Kuehling@amd.com, leo.liu@amd.com,
 Oak Zeng <Oak.Zeng@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The printing message "PSP loading VCN firmware" is mis-leading because
people might think driver is loading VCN firmware. Actually when this
message is printed, driver is just preparing some VCN ucode, not loading
VCN firmware yet. The actual VCN firmware loading will be in the PSP block
hw_init. Fix the printing message

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Christian Konig <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 284bb42..121ee9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -119,7 +119,7 @@ static int vcn_v1_0_sw_init(void *handle)
 		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev->vcn.fw;
 		adev->firmware.fw_size +=
 			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
-		DRM_INFO("PSP loading VCN firmware\n");
+		dev_info(adev->dev, "Will use PSP to load VCN firmware\n");
 	}
 
 	r = amdgpu_vcn_resume(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 8af567c..f4686e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -122,7 +122,7 @@ static int vcn_v2_0_sw_init(void *handle)
 		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev->vcn.fw;
 		adev->firmware.fw_size +=
 			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
-		DRM_INFO("PSP loading VCN firmware\n");
+		dev_info(adev->dev, "Will use PSP to load VCN firmware\n");
 	}
 
 	r = amdgpu_vcn_resume(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 888b17d..e0c0c37 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -152,7 +152,7 @@ static int vcn_v2_5_sw_init(void *handle)
 			adev->firmware.fw_size +=
 				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
 		}
-		DRM_INFO("PSP loading VCN firmware\n");
+		dev_info(adev->dev, "Will use PSP to load VCN firmware\n");
 	}
 
 	r = amdgpu_vcn_resume(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index c3580de..a1bbe33 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -158,7 +158,7 @@ static int vcn_v3_0_sw_init(void *handle)
 			adev->firmware.fw_size +=
 				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
 		}
-		DRM_INFO("PSP loading VCN firmware\n");
+		dev_info(adev->dev, "Will use PSP to load VCN firmware\n");
 	}
 
 	r = amdgpu_vcn_resume(adev);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
