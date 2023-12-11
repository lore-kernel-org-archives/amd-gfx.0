Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC46EC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Dec 2023 19:45:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31D4510E4CE;
	Mon, 11 Dec 2023 19:45:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B57D510E4CE
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 19:45:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbJS1zW0iT4wHtPydzFcMEq01sQtVFgG18An22mVJWPP2JEIo864JoH5vab3pD77fGJItIQIDknLY6oTZoqGeWqth5goPZuVjCwzgN+CD1k8C5h36f8fM2T48aRUiUh/aJkhufAJ77k/YbSHBg2KJoci/FfLaSY90jYjBfUnJUxBxK4gI9f67qC02T0MddCRF2IOT1dbo4dp9VJ6apqCLLzZeSBua2TfHEXiyEFK29np3t61p6gBIFpZn2c/VMD9qEGnUW724S5M5bkZAHtLOOFuS1KVsd803zjnDcFKvLk/hnG/aVOMjA9wLb3kFGpfz/kc1R3Uu5vbhSdZ2ZjVKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Got5iccWonxzpRBbBf4w8/tRCWn1413Mn8cGbUray0=;
 b=Quuk/hTXrDQUpgeXpg9KZAiY2N9JpASVfpKcQn36Li25MW0UlSBRrVujLX67mcsyFLPFg3lGOqNjgvxsQwGiX8XSUJcGH3xLb3ONfU3toyhM0Lj1Vl7/SrwScZZxJyAFWavQPf602xy2/aAJKA+fO8k5QPzSXbjl7Vjbk/cKT6gIYjia9CFNLx4PtyvUg6BZ4XkJruEbDL8BVuXPelcHmAiaeRWT8s41GJsjZvSYCjk4rr3oYjHPCNVEcNwdek/JiRf1dO93KhkeEG4O3jqVXpe0HZh50snPzjcpCFaLCzvmjgoHyej5qvbUACooLubbQrXgsC626IH9+rPHOnNG2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Got5iccWonxzpRBbBf4w8/tRCWn1413Mn8cGbUray0=;
 b=KowVbnGE/XlU1sxz1YL7DRD7Onc48DkxfDylnbrlikXLG80VATCsjKJ3O4cj43ugd18mqybu/byZuwtrXbmSZlZwCkRQW9Tn7vJLzaA76qjbYFzxjXPHm28J0VBfEDaq9VA6A6zEWnL+fhDW00zefvbTFa84JKPpTtCFLwcH9GY=
Received: from SJ0P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::9)
 by DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 19:45:08 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::ba) by SJ0P220CA0004.outlook.office365.com
 (2603:10b6:a03:41b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 19:45:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 19:45:08 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 13:45:06 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 00/23] Support Host Trap Sampling for gfx941/gfx942
Date: Mon, 11 Dec 2023 14:44:57 -0500
Message-ID: <20231211194457.762416-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207225422.4057292-1-James.Zhu@amd.com>
References: <20231207225422.4057292-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|DM4PR12MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e6f5121-33ff-42fe-b39c-08dbfa81ae20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 043xidVDUxX9ys/55PzRUR9LJbT91Z/5T/C4F+uW2ECIH+wHOBNKafPojpkFMmLYos9wcFpJtbKwG6YJqpUsFUMweOsA5niGB7+n0rNY2B9DndsOSI6DMQGbHxXd2WBGUIJdhJwDN/k25frQg81d9lwzQvy0OdJiu++EZg7QFVwDtlR4+S/GoSynzR8pSWcoPSLxAUve0EqOmWlGjRex2ohEuEzliiexzHImJaQSzseSmd7TGTaBp44F57vjDhcNUUcx/Tf+k/UxVuxXUJfsC2FdHiqcxqY1711mlcXA647nKiMK+HMmzWq+4eQkyF2s2SdRXFM6RqdsVsoLC4adOjuqXklnIwqGpRC6q+rA64BuEInfu4S8Hcdp0tj7wYt5dVAHCg/LNJ/VILltFXr5Jou8QSGiQjJnRgrtOt7Vd/6rEKxAB3dRRaKIXwq+nO04Z+g1IZafkH9xQx/cP9LUFb4Qt78Ds6cbiayzgZB/EBto5a0WWDBJV0TOwKJ3Ei83aKcajAChnHK71u0e3DhX0AjI8995LQTJMqNGcxTwxyvJy0v2vNYYmDPAD9CltzmQLmKQQUpBBbBjQ7l8qR/6TjYc3uHIwYzN0Tqdi9JivHW3XlfdG7vBmIJH6pOwJuriqgcFTXPbmR7ljNGLibmyVIhwGtvG8ojFbJrz/FVZhp8DIFWUtjDUXZgjy2wLGq+uIkQs6uXkR3CvFhHyKNeAi/vfDn3U1GHsDtCU/Uj8vNXP2vhMkjBp95i3n0RQB577lENnj4NMRlM2PJ0az0sC7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(83380400001)(2906002)(81166007)(82740400003)(41300700001)(356005)(478600001)(426003)(40480700001)(54906003)(6916009)(70206006)(70586007)(966005)(316002)(6666004)(86362001)(7696005)(8676002)(8936002)(4326008)(40460700003)(36756003)(1076003)(47076005)(5660300002)(36860700001)(336012)(26005)(16526019)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 19:45:08.0754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6f5121-33ff-42fe-b39c-08dbfa81ae20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6063
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PC sampling is a form of software profiling, where the threads of an applic=
ation=0D
are periodically interrupted and the program counter that the threads are c=
urrently=0D
attempting to execute is saved out for profiling.=0D
=0D
The user mode code which uses this new kfd_ioctl is linked to=0D
https://github.com/zhums/ROCT-Thunk-Interface/tree/zhums/ROCT-Thunk.=0D
=0D
David Yat Sin (4):=0D
  drm/amdkfd/kfd_ioctl: add pc sampling support=0D
  drm/amdkfd: add pc sampling support=0D
  drm/amdkfd: enable pc sampling query=0D
  drm/amdkfd: enable pc sampling create=0D
=0D
James Zhu (19):=0D
  drm/amdkfd: add pc sampling mutex=0D
  drm/amdkfd: add trace_id return=0D
  drm/amdkfd: check pcs_enrty valid=0D
  drm/amdkfd: enable pc sampling destroy=0D
  drm/amdkfd: add interface to trigger pc sampling trap=0D
  drm/amdkfd: trigger pc sampling trap for gfx v9=0D
  drm/amdkfd/gfx9: enable host trap=0D
  drm/amdgpu: use trapID 4 for host trap=0D
  drm/amdgpu: add sq host trap status check=0D
  drm/amdkfd: trigger pc sampling trap for arcturus=0D
  drm/amdkfd: trigger pc sampling trap for aldebaran=0D
  drm/amdkfd: use bit operation set debug trap=0D
  drm/amdkfd: add setting trap pc sampling flag=0D
  drm/amdkfd: enable pc sampling stop=0D
  drm/amdkfd: add queue remapping=0D
  drm/amdkfd: enable pc sampling start=0D
  drm/amdkfd: add pc sampling thread to trigger trap=0D
  drm/amdkfd: add pc sampling release when process release=0D
  drm/amdkfd: bump kfd ioctl minor version for pc sampling availability=0D
=0D
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |   11 +=0D
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |   14 +-=0D
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |   73 +=0D
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |    7 +=0D
 drivers/gpu/drm/amd/amdkfd/Makefile           |    3 +-=0D
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 2106 +++++++++--------=0D
 .../drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm |   29 +-=0D
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |   44 +=0D
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   14 +=0D
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   11 +=0D
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |    5 +=0D
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c  |  372 +++=0D
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h  |   35 +=0D
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   43 +=0D
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   32 +-=0D
 .../amd/include/asic_reg/gc/gc_9_0_offset.h   |    2 +=0D
 .../amd/include/asic_reg/gc/gc_9_0_sh_mask.h  |    5 +=0D
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |    6 +=0D
 include/uapi/linux/kfd_ioctl.h                |   60 +-=0D
 19 files changed, 1813 insertions(+), 1059 deletions(-)=0D
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c=0D
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h=0D
=0D
-- =0D
2.25.1=0D
=0D
