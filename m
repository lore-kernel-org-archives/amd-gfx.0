Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AE8C761AF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE15810E90C;
	Tue, 28 Mar 2023 15:14:44 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7333410E910
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXCWq+kO35HokYOF7fm+RE0+XL41b116y+If+7vPYsTtqGFhy5MR+HA8vZcfOHp9xaj7ERR3WFYhpQUoSzXlFRacc48mfhCcAlq0DMxkCnjhnGe5v96UDmCx8IOZ7kA+jM887C2uT5qtVvfs9EHNSgprrzZEZzQVlK1x0zGX3rHMMmEZfrVmU92Y5innrOgNtJD/vJa5volR79q2z18G1kAqyt3A9hVUzi3HVjaVoKUpXAgykKo75u6Cq70xdvESWPo/QvosWNjYlqdDAglaySyHFQFZc7AjGuo47jZWdnhC/TY61baRAjV3t7oafcL8eXxCrU6bZGbp05lXoVvWmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p84fstA8bsMHyzXrf9XXfcj7NjmHcdU5kW9FfZXDxPM=;
 b=lFenYuzHzb96WVdgOy1wHI8BV9H+xmCr4OKxCYi+N6m+K4Gdg9JsgPK2G/wugzCIvdIVXQJeeHNO8gccITyhzVQtLJ24SMcdPR/ICKWMemLrmDZGCorG3CGtiOZ80S6VIjFBWEa0alWJzDuBMQHBCcCP0TGnOoKbcHQy144owXQfiaECImBp42bxVU55tUMIVm40hDa49n/c6LtRftGEZLbfPzg8xdPWQH1t8ycfZqDyMTQdOTSIaZwtWY7RCoe5elkh2hdZ4RUNZDdU+TQztEK41I5xPSnztUt8/8UK5FSgqwbS61TfZvJ1K4V+clDLEC1u7UpqYuuzNlwoHo8SOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p84fstA8bsMHyzXrf9XXfcj7NjmHcdU5kW9FfZXDxPM=;
 b=FbrllDbV1O30cOGzoEOx4JQAQU0ui8zDwK6WZAVmgrIsvvTi0Oink00Cob+5tvEsMVTPi8dgBT2QA8tmOB3yIXkh3MbJgFeqThCLZQkmvPytXyQbB9Z3TIs/cP/I2LmG0FUgOkjiIT5K5vb13aOff/hJe8EIpg/xbf1vRbPvV/g=
Received: from MN2PR22CA0010.namprd22.prod.outlook.com (2603:10b6:208:238::15)
 by IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 15:14:40 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:208:238:cafe::94) by MN2PR22CA0010.outlook.office365.com
 (2603:10b6:208:238::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:14:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/32] drm/amdgpu: Fix CP_HYP_XCP_CTL register programming in
 CPX mode
Date: Tue, 28 Mar 2023 11:13:29 -0400
Message-ID: <20230328151344.1934291-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151344.1934291-1-alexander.deucher@amd.com>
References: <20230328151344.1934291-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd870dd-53ba-47dc-a679-08db2f9f26d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YLGZexWtgaXELUkZIJ9AMtqH7a91Y7SYmipRrqV7hzUjDXm8RJmkDXVXcByC6l4wLBj1af8+I7yqCEjuIKKXTxOe9nPAnp6+o2IRzIekiC2DUT8Nw2U3gLPaayxAYK25GJPEeqk3pOwd160hWY2mBr8P7+Qg4qB5jzwojTggGevrQSQtltjQl56p1sXaV6TdiCANFkmiTXQBWcu5sOAMmcoMzIPqRM7dPw3zAyTyeEfVfFbLc+PM/deNkD7J1gG6gSYp8Ltc4w+d8opNB/K8FT4J2gLK2XWDzu1TWJvzJxZcbQk7/RIhymofKnaK9rkik1eDBiCQSAXM3NPKEs7cyw+DHnUybJ6NSGcluLOnjrsjdSAKoBkQs1Qqfj7hoLajn6ewES22eX8CN2t/gVVHVfTM1RvVC2erMB9ON3UPF6+gfhzbz0rzm09ZWl47Rt+mgD6eTFmA5CAP4W9Y82kgIEEAKgMJMVDmyDaAFS9UM+UxqgRLiZVwtY6guytI2lFN7fOVi6SdsoA1uy6i7b+2kWlbT1aeMWHTAqunisPOHfcKE+LVFM0XA6OC0/BKy457PGYiKNiDJtRmienmon0WjhMPhz0SZOzIvLbtZDQTQwlDyg2kXytjXpoD7frMm+ci7qW0SyD+w5ncVn/QSewdpltQmgx5WXjVX3Lf+INMCv4kb2N3l3ldK9iGmur0k/MCy4vpa0QbREGeDSMZxS+hnP0njZJlRo9zKwB/R0tYTcU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(2906002)(82740400003)(4326008)(41300700001)(8936002)(81166007)(356005)(5660300002)(40480700001)(86362001)(82310400005)(36756003)(40460700003)(478600001)(316002)(6916009)(54906003)(7696005)(70586007)(6666004)(26005)(1076003)(83380400001)(2616005)(336012)(426003)(70206006)(8676002)(186003)(16526019)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:40.0233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd870dd-53ba-47dc-a679-08db2f9f26d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Le Ma <Le.Ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

Currently, in CPX mode, the CP_HYP_XCP_CTL register is programmed
incorrectly with the number of XCCs in the partition. As a result,
HIQ doesn't work in CPX mode. Fix this by programming the correct
number of XCCs in a partition, which is 1, in CPX mode.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 7b589f279ece..3811a7d82af9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1166,7 +1166,7 @@ static void gfx_v9_4_3_program_xcc_id(struct amdgpu_device *adev, int xcc_id)
 		break;
 	case 2:
 		tmp = (xcc_id % adev->gfx.num_xcc_per_xcp) << REG_FIELD_SHIFT(CP_HYP_XCP_CTL, VIRTUAL_XCC_ID);
-		tmp = tmp | (adev->gfx.num_xcd << REG_FIELD_SHIFT(CP_HYP_XCP_CTL, NUM_XCC_IN_XCP));
+		tmp = tmp | (adev->gfx.num_xcc_per_xcp << REG_FIELD_SHIFT(CP_HYP_XCP_CTL, NUM_XCC_IN_XCP));
 		WREG32_SOC15(GC, xcc_id, regCP_HYP_XCP_CTL, tmp);
 
 		tmp = xcc_id << REG_FIELD_SHIFT(CP_PSP_XCP_CTL, PHYSICAL_XCC_ID);
-- 
2.39.2

