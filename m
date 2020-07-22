Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A289BC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 03:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F233207CD
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 03:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nFgbTvHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F233207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D61489C9D;
	Wed, 22 Jul 2020 03:14:45 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760084.outbound.protection.outlook.com [40.107.76.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1053D89C9D
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 03:14:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NynPI2YMGvdhoVv4QGJ9grv6IXXrM0mUnr/eGzmaOTOMRq/AxuUlGCorQ6b0IXPIPoV5SolIh9aNBy1s4UNCRAYFUI2wXuPlln5PacmgXcTbepVXHr7g61pr20Rh0e/Vfva5kuoQFBfR+Lx7uje0I4uESHIwziAqSFQag361yNUaGMR43WpzyNNpPmqZl1b3RR63oFxHJXICj3xtuqu7db2GqHFq5t7Se5phMzVLittubigShEsmH73lglH9Iz/4vChK+WZpSJ6zZilU8gRzxBXPqDv14qmTjkohP85TrIUEsXYGuuv1ZClGFM0YP0m06p7XrKPf1FbUbLt3pq4sdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zl4MnwIISaXqe8wOBGbE+KhRo7/CeQ/WOz61Gy+eA60=;
 b=b/TrtnshXsZHWPmGzJ7lWN2kuLH40V0AymGPJ0d6crN+z1F9bLeeYawone/irSDI5Q6HN0JPK3mLHd7v1h0k8iYWd5LxTnqA1Y+urQZsHDFC11c4KbYFlzJ4q79ugg4zfmScq99mMQzXdShSYZW8BPuuXRK3jQElrURHPCZVo6IlhMbNCYvP4w+YWa06ee2YgmI3fluVpkDI/UCNMZwACjhaGCRkZpYIkmYiN8g7kKosZuxYSQJazVWeSwJ3sI4EVbpep25EIPkC9XNqG7RVK+nf9C2uy9sCczmAHyH9YvTyZohiJohZxRoLBROqZlx238gzN6+gR4nJfBedfc4Lmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zl4MnwIISaXqe8wOBGbE+KhRo7/CeQ/WOz61Gy+eA60=;
 b=nFgbTvHcJBSNCy7s0SpzVts5y4aIc75ddtqRENgsJ2fv3LrBdZrA4IdvJ1pAX4eltA9sY8egoYMU/MPi1KlQzaTlTGAi4820YaQyvXZpKXZhKKhaHsDQctDK0Mcn6MELJ3//aDH428+HMHjPClOjpsmbjl8FIAG77jUODr+4/hc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1909.namprd12.prod.outlook.com (2603:10b6:903:124::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Wed, 22 Jul
 2020 03:14:42 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3195.025; Wed, 22 Jul
 2020 03:14:42 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, Stanley.Yang@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com
Subject: [PATCH 0/5] BAD GPU retirement policy by total bad pages
Date: Wed, 22 Jul 2020 11:14:10 +0800
Message-Id: <20200722031415.4792-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK0PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:203:b0::22) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK0PR03CA0106.apcprd03.prod.outlook.com (2603:1096:203:b0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20 via Frontend Transport; Wed, 22 Jul 2020 03:14:40 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0cd1fc1f-c63e-4825-7048-08d82ded6090
X-MS-TrafficTypeDiagnostic: CY4PR12MB1909:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB190965342B7842F21B54D9F4F1790@CY4PR12MB1909.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dXBs5iaUwazNPwRqHzPDJh6V00G5ectkLcVjlQGfz98caAXZzy9PZnK9oAWrhFxqfoYl9fMS4PnMzutknIBqt+57R1j/2vinI4YiZ7nZXfRsFnSZsFS5z449q8uFLFTySEUO6/zWgIx8CzZpdkNAIxvk+3VUVNLQ0sD2kEaOXVKfxpLIxxQsljftwVf0A7zJnT+8msWOQR3Ez5kIVnats/RpJUdCoPLdNstRpKu8mlpQFWCsXaa5igDz+JXZooChiuT6FHjfjVDSR5xZVLBlF2Mf4ftRkTw2Nztzvnz4Mrp4CbXc66wcgLv8dbTU/CvjR0Gt2MnuHMeI8eMll6dOUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(36756003)(1076003)(52116002)(7696005)(2906002)(66946007)(8936002)(8676002)(6636002)(66556008)(66476007)(5660300002)(26005)(6666004)(6486002)(83380400001)(44832011)(2616005)(86362001)(956004)(186003)(498600001)(16526019)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ipJvV+ejK+w+fOaIxYjkOJxDxoE6UNjudbu/DLeRqsIN454bGk56igDOckxFsSL/gRRmxbporIg079t61aQfk30+BxaEuFgZ1tGGFFXNu6fXsHAY6t4ArKFqKwfeegSLquAX2bgW0ZzVoyNc+0pttYsl2gKUgtB7tRkiUtb9DKcElftW9uTPkI15bcHdvQt2IJ1JTESZbAYDG//EshB9XY82N7W4WD4cwVstld1Ur2si9Xnh4Ha4f1Jy8rWL0TUj1wLud0WwWZJzFLpY+D8wlVaGbKfCQs1XtQjgXaQKAl2i56/eQnhpIPt1zpuz/anLvguH8h7sf7aQDHDnluAdaQFMN53dbIA9YRZmwk7QWneyP5KtA4laXr+y1eP1vwuUh2LkYZ+Wz2I9KqvZoKLJ1YFR0vg0D6KcGetQiu1pyU/pWmHoe4F1iPaNlNAl/k8CrlgRrZxxjEr8UGYNV+ZpTwbVjtO8h3sjHyqFHjJFPB9RMUUpP+EmP476t/0aYxNN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd1fc1f-c63e-4825-7048-08d82ded6090
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 03:14:42.6131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aekryldQqjt6y57zO6Whr0W6lPJ4c4FiQQQLFr1XmfH0iwulI+j9OfNot5MoP4kNO68rE1L2s8+HrlNOmnmZWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1909
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The series is to enable the feature of GPU RMA(Return Merchandise
Authorization) which is trigged when bad pages detected by RAS ECC
exceed the threshold value.

When the saved bad pages written to eeprom reach the threshold,
one ras recovery will be issued immediately and the recovery will
fail to tell user that the GPU is BAD and needs to be retired for
further check.

During bootup, similar BAD GPU check is conducted as well when
eeprom get initialized, and it will break boot up for user's
awareness.

User could set bad_page_threshold=0 when probing amdgpu driver to
disable this feature to bring up GPU, and reset eeprom later.

Guchun Chen (5):
  drm/amdgpu: add bad page count threshold in module parameter
  drm/amdgpu: validate bad page threshold in ras
  drm/amdgpu: conduct bad gpu check during bootup/reset
  drm/amdgpu: restore ras flags when user resets eeprom
  drm/amdgpu: calculate actual size instead of hardcode size

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 21 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 11 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 70 ++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       | 19 +++-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 98 ++++++++++++++++++-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  8 +-
 7 files changed, 211 insertions(+), 17 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
