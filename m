Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2B9C5ACB3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Nov 2023 07:31:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5AE110E24A;
	Tue, 21 Nov 2023 07:31:08 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 415C810E24A
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Nov 2023 07:31:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3wxFjxZBoCZCj5nbFlIKzkkNfVNhYbpoIcvNXxgqQd+bj16Npt/klfRop36e9yn7h6UPtIdf/Yw98D1xNUU8eca+qqxP88W0EOprQCUIJD2aapqsCP0pWl3V5zsuSbYFnp7Oy+7iVoPFS/IBx8Zcl7p6HL5rtLqoLlN0S5/9Rq0iI+1ntJTRnhgZz4DUZR80uYGZBPxkU9iK/mrfv+QiUtN+kDxDg5GEYJHE//tmVZV/9ywL7uUPlQhSgFo8KNwYKTo6haVamz5llUfkoaFhZryO5PzMAkd10Rp/Ie0PfEDtZvXPVdGqyVlIG6o7cLyZimubYvhADNdpl7gQvoTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQ6IJIGaJsNHROP1IjmItnbEOLj3uIYj24/+q0Jzg/E=;
 b=deovOyYVgcjQ73L90EHsDuB9gAmVEAJtoBhm056WXQcv3Co8+J8C+s52AALj3djVS8Q8cWNqX/WHWjGNEtWY55m+6r45S6uuWfGN6ipJZdIEXu6niAlKKYyXiaK9OsqokUF3KfsH11sPq4Dr1mgCvsnx1qeys9pCJdqydUNS1W7s4+gSnTaTkfLrHtLTa22qNTuDyzyEU0oUBY1si+9Xz6w5d7P21fw4Fsd9mae4+gO1bcdVClrXNdBZgVcrUAPD1aTeLYVYU/OuHi1Mydp5vrNw0XDBinm3g4+92yCisvYi8X4/7GQ9bjFT4FMGj3h0TEHx0yrgT7+oO3nUXZTDHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQ6IJIGaJsNHROP1IjmItnbEOLj3uIYj24/+q0Jzg/E=;
 b=yyoVeSeDn93R/KL12W6jxCPY/fSskeGpasjkFhOSykEH2NKmHTE9PJjEwiHxXh7wfo9ZcvORP3/N/WMbcx5/ua7TB4Icl4e4LB97dfkukyb0CCoq3w13xilJ7zsRiFLDxuZn/CTwrDlMo5bs8VrLOqv9uCWD+/yuFxiQ/Qfqhvg=
Received: from BL0PR0102CA0007.prod.exchangelabs.com (2603:10b6:207:18::20) by
 IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 07:31:04 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:207:18:cafe::57) by BL0PR0102CA0007.outlook.office365.com
 (2603:10b6:207:18::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.30 via Frontend
 Transport; Tue, 21 Nov 2023 07:31:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 07:31:03 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 01:30:59 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 0/6] Enable LSDMA ring mode
Date: Tue, 21 Nov 2023 15:30:08 +0800
Message-ID: <20231121073014.2984557-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|IA1PR12MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: a6428da6-49d0-472d-2c0f-08dbea63d139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LJ8YLN9hAaZEA7VzGVp+RKLzsKaEwdvJckFenFaJoNnGpDFUtAX9pBdmogZdAJayjwr0D3z2sJmBDJgF1QnNsBokV2uzi5DHdcRJG8wQJSLbjT1bstnGW+j0vAAIUYLxMbpDiZfKlyNorZsZZeHHKDBO76qDrhhoQ8MtJ0aIFzUsxYE50TphJPSofwPY0uOer58UgB2uSJbR49h1vbLiOzbk10xHeTMlSyo0hfgIlIzmU6semfzTTTxYine8hN0Jjy2aFtvXslIVhjb7QciOsi15oz+5tr5RvG3004e476AO/EKZiDKzDvspJ8wjPhjNF3wc51L9PkRgzIHed/YOgUEL/C+ATpaFCh1a9XAk2bmWq1xlq9/130PeQ39bUXEhcx1SQ/dNlzen11opz7Q6oazbJlyIKr9GADgaj3o3nfmktmultN+CokgvGs9yMjcFLfEZmJc+oGqD58tRD3CjOznM9BY91onO4hywwvY+NdK3BMI/Zl0Si7gbMBJ5zyAIwGZxj82ZOHGF4PA2YBOUYyi7X1iX8zjm2JhzEgS652W+Rfp5yK+oloLRG3fnJh5Cu50E4PtQ24aKkqBwB9k8LQnof2rNJdld8TdaQJV/OZIO07QzPwIW3NNzBzsg3+C1dgBwr1wLlOi3CQ+5rPa3+9OiA6OjfaBXHud2HCQkmiZEFozewa6ciJY/9fxU87jsrd5hQhwng+qofCCljcuVmnhIYvyB3lZM20fdVbh9c7FWFmd8l/qOSTPlYJLpmOlSUTROIOMM6BfB0QVrdvVBdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(47076005)(7696005)(6666004)(83380400001)(478600001)(82740400003)(70586007)(70206006)(6916009)(54906003)(316002)(16526019)(8936002)(4326008)(8676002)(36860700001)(356005)(81166007)(426003)(26005)(2616005)(336012)(1076003)(5660300002)(86362001)(40460700003)(41300700001)(36756003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 07:31:03.5435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6428da6-49d0-472d-2c0f-08dbea63d139
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650
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
Cc: Tim.Huang@amd.com, Xiaojian.Du@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Alexander.Deucher@amd.com, Lang.Yu@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This series implements LSDMA ring mode, creates LSDMA ring and implement
amdgpu ring related functions. Introduce a new module parameter amdgpu_lsdma
to enable LSDMA, switch buffer and paging funcs from SDMA to LSDMA. It changes
amdgpu driver buffer operations to LSDMA, changes default page table update
to LSDMA. Since LSDMA is outside GFX domain, it can work without waking up
GFX which saves power in mutiple scenarios. With LSDMA dedicated ring create,
it also exposes interfaces for users to utilize LSDMA capabilies. It is tested
on gfx 11.0.4.

Yifan Zhang (6):
  drm/amdgpu: add lsdma hw ip definition
  drm/amdgpu: add lsdma interrupt src id
  drm/amdgpu: update lsdma headers
  drm/amdgpu: add ring mode support for lsdma
  drm/amdgpu: skip LSDMA for mes self test.
  drm/amdgpu: Default disable LSDMA until proven stable.

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   22 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   10 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c    |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   15 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c     |   40 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h     |   33 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |    1 +
 drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c       | 1293 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.h       |    3 +-
 drivers/gpu/drm/amd/include/amd_shared.h      |    2 +
 .../asic_reg/lsdma/lsdma_6_0_0_offset.h       |    2 +
 .../asic_reg/lsdma/lsdma_6_0_0_sh_mask.h      |    7 +
 .../include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h  |    2 +
 include/uapi/drm/amdgpu_drm.h                 |    3 +-
 17 files changed, 1432 insertions(+), 7 deletions(-)

-- 
2.37.3

