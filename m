Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEF5C33CA2
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 20:56:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EAD220880
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 20:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h84VlUXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EAD220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F8F26E137;
	Tue,  7 Jan 2020 20:56:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B24B6E130
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 20:56:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRXgcAlZp7Ei37/1WcmnSBuuuTMrv1V2kaWdQWzNHHGZtq1ZeTXWhGZIzE+fI+/ctTm7EMej6kFoN9fWn1MPxNRc01PfFLCsCuMKxIv4IIWeasEwFDBCEEYOzxw4r+14BSEE5tYxaDQzGYu5FNV7R+VyVDT0hZAfu0+sch9bxh5KihVseGeH1dIC7VnSFS8aHM17P218rCczDLFQxg3XRvbTp3NyH08u3u31lLy8hAfygWSly0f6CTI6yZoZbEVOz1zqvG1CdtnsIoa3kZLz6JWnNBZOr5jllVcwpfBdvZoW8qmdo9TIYN2ADIMgqAMEE6biLBT88b8dneJm63+Ejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcQ2DFkdShNnuN0wptImMQOBjmdes0xZZhKTFkpf6WQ=;
 b=lrnQLM69vrXs+xNSh3TXvh04x9fiEG8jdV1e8zmd4AUcjgAqmw0rWcGXmLSIY8qpohJeWLS58r1odczTcWk4dI2/uyLWCoT7quMWsyMtEAx8rS1MNncNGu8NVye+E3onthtSre+0h+m+pePYvPZciM6R88/h+BvWjFmO+d2qUyPdhCMTR5AWo8ilWIb5o6b0AwQCr7S2vGvUOE/s0iST4uc0orqBbJ5yG0BCe1vyQ7gm5nneZ7lEhsjxVleusCQhZWUz4G6T5TQp/qFZnu8n0goTjd13ITv1PaUO6Z6y9pWZfSORJW2QLsc/t5YDCrDMkjuKG5wsxbOaGvdnouw0EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcQ2DFkdShNnuN0wptImMQOBjmdes0xZZhKTFkpf6WQ=;
 b=h84VlUXMdPnq9SqUIsmTEqaCWpcLwBWb+AYMgaClQ94TbJL8rYAht3gy1bvXZzDlXjGhZoIliMRO0i1kwhRXRZg+gyWg5G4vX++dTdtHvWLlqvT6vVdW3FRY1EbOR5omgyfLWaKNIMshHNBBV/0GPB6JfpLL44dUDHhBbofa0sw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (10.255.174.32) by
 DM6PR12MB4089.namprd12.prod.outlook.com (10.141.184.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Tue, 7 Jan 2020 20:56:19 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968%7]) with mapi id 15.20.2623.008; Tue, 7 Jan 2020
 20:56:18 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: enable VCN2.5 IP block for Arcturus
Date: Tue,  7 Jan 2020 15:55:08 -0500
Message-Id: <20200107205508.2651-2-leo.liu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200107205508.2651-1-leo.liu@amd.com>
References: <20200107205508.2651-1-leo.liu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
Received: from ubuntu-Golemit-RV.amd.com (165.204.55.251) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend
 Transport; Tue, 7 Jan 2020 20:56:18 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d81fb1e3-691c-411d-b747-08d793b40b15
X-MS-TrafficTypeDiagnostic: DM6PR12MB4089:|DM6PR12MB4089:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4089DF1DB173E60307064FC7E53F0@DM6PR12MB4089.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:265;
X-Forefront-PRVS: 027578BB13
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(189003)(199004)(66476007)(66556008)(66946007)(7696005)(4744005)(2616005)(1076003)(5660300002)(956004)(8676002)(6486002)(26005)(52116002)(36756003)(44832011)(186003)(6916009)(478600001)(316002)(8936002)(16526019)(86362001)(2906002)(81156014)(81166006)(6666004)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4089;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4SuCQC2ISojsCu3+SLfUfxvJgwWn/A64Q2eO6LsiNjRRkYF4d+M1rcPBC6zfK9zW8/uL8yJ8apqUu11CJGsVZtDa6mLNGSzOdF5xwauMMfVfubq1fzDIKj8kS28eIqjJ5AWVPoS7rDdIMB/BFzoUijKWLyduu3I9yJjxuBUamTTPQMHkTEsB4o9TkQ98d1nZHPuwWoLAfsmk4vhZM6XJ9LoWG//xDabijzEoBkyA5HhQhNi70anVz2NweF7KcsHIWf6f4wpaGnG2owHEwkzcSKPpFWFueS7sqDMxhwrsJ5E3vCv6nmJzMgvHUSZll8k+T200iGuYUsUHjsfeUIRnOaSYWjZtSa41j7tYPf380BCvNbAjuD5vHZ0Ox2MERnGc2T+NAJxRVFKES9cD+1GyssQECi4tSJkDMoMOXyfuYLkEMUTU0BNbeiEqfIqloWi6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81fb1e3-691c-411d-b747-08d793b40b15
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2020 20:56:18.9201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+MZLtfRLZNV9zENwiPBmxhsippnRWKZmqUi9q9h7lCV+K0e9n4bObqF92pXqqst
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4089
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
Cc: Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With default PSP FW loading

Signed-off-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 714cf4dfd0a7..e4a7245939c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -834,8 +834,7 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
 				amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
 		} else {
-			if (unlikely(adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT))
-				amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
+			amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
 		}
 		if (!amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &jpeg_v2_5_ip_block);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
