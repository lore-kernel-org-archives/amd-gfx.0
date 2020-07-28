Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156BEC433E5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:50:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9DB121D95
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XT/jtFJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9DB121D95
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D2176E1F9;
	Tue, 28 Jul 2020 07:50:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D8F96E1F9
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 07:50:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxoHqwcsbEy7YoLG99qqQ+GbnnPt4a5MOw/tWaLptDRGvZmyo965MxWtRCbUYHM2SYjDdN9HN0XuuJaHUMmeDFBXc/gUTA0g6JYA3iczzW8zQXodbVRj8jkXvMqiQQW01Fa6wu7WS6AA9jIp7twscWd27MlNaLi2wsWMU5d43wkhdj/hR4PsdAiDUFC+cDuMjSV0RvNi0sX1wOFWDvHD0OuctT6pLdj2GXUz9nMdVIC5vz3OAtu80mkvhayBpyNxBZ3oruRctav7GXtJVl1FVJsnAcBFpH2TJgq911ZafuW9CoJsvSctc7e7l9F/WOGtC+w2DvcUxO77w5h+XJd1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/0a0VlcHewAV3ianBPmO2ZUNo3iJMGhIKa28d4B1A8=;
 b=RDR0cF1NdzzA7CCPbJsv95ghvRMxyl+ueXw7lCkGM4xa98m79/iOe052OB2d5pVwBq9G/91dig71WqlegxRSkGKXykwgLFI+g4nofg/DD7QPTdavHwwJ1tTsyBdg6gj1heIu2UVf6bJDmQKnnGC1u3KqxYu+BS6BS6qxWxoINVQEEbyIEcV+SvrkyNqoWxNjQL+cpRPSXjn8kGk+bvMsOBVMlKl515wXW4xkKj+0vmWk7X2qIX/o8BbEcq2cGZeSjDLp4OiEi5Be+o6fxyDf0PVMpJ9RsEC3pViXXWlMV+q5baaashD3kjlt99UDPE8H1dUfeP++PQLy5AVuiatJFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/0a0VlcHewAV3ianBPmO2ZUNo3iJMGhIKa28d4B1A8=;
 b=XT/jtFJqqIjQWgdu8nzqUOKxXC2wNTU1FgsqZYL3cGGPA/oTIH0mOiDIzavFsRNHAPbE9g4XsLSxeG7XdhkJMXPoY+yOx8OWSDJJTEiOMWSfMvHxsEJjqoocZk4DWWZeli9hKi52+/W4cAOjPoMgKAf6cZsgPIkQtrAyxFnZdgU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0120.namprd12.prod.outlook.com (2603:10b6:910:1c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Tue, 28 Jul
 2020 07:49:57 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 07:49:57 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, andrey.grodzovsky@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com, stanley.yang@amd.com
Subject: [PATCH 01/12] drm/amdgpu: add bad page count threshold in module
 parameter
Date: Tue, 28 Jul 2020 15:49:23 +0800
Message-Id: <20200728074934.12490-2-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728074934.12490-1-guchun.chen@amd.com>
References: <20200728074934.12490-1-guchun.chen@amd.com>
X-ClientProxiedBy: HKAPR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:203:c8::9) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HKAPR03CA0004.apcprd03.prod.outlook.com (2603:1096:203:c8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.9 via Frontend Transport; Tue, 28 Jul 2020 07:49:54 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c08dd0f9-aa67-47c1-cae8-08d832cad2d0
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0120:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB012036D7383650BA8039BB98F1730@CY4PR1201MB0120.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PCSmfvpucthl/qw9NaTrHjLt5TtUjcbuG0EPfcPFKhe0KjPulGRHBHB/4z95fIGdnQdk2CJSFtzPj7XIdQmW4dIQJ5KlErW5crMS6TFQ0q0mqzdUq0/COcuPsvD2J5NtEFGMnstsT1/mj1tYgE44Qa041vW4IJAmuottkjpzbAERuHeDOnHZul/TDmUh4n5VX3gar9jWCKXdi6bInel8MPQK9U4lx8LQEKK6L3PabIUlVwrFjSeWxDP80U7PSEI6DFdRiB9jx/kugwUkO4IyywwYPhR+XNazSO2LyoKqyej13a6UXK80sdJCnrfLA90gdXMFMzQk2c6L9RwgPG0nbKXL/E2ojFWXEV8ZIL0lJ7TSu7ALOERxVdmDEHYh/2kT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(5660300002)(44832011)(6636002)(1076003)(2616005)(478600001)(26005)(186003)(16526019)(8676002)(86362001)(83380400001)(2906002)(52116002)(66946007)(956004)(36756003)(8936002)(66556008)(66476007)(6486002)(7696005)(316002)(4326008)(6666004)(921003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /CtwNV3RpmH55OVtYf6nevuzEpdGBeMVYY6E2eatreqTw5JS+r8dpq9d6BZ7sS+uas20a829CaZEkQmMfiIs9qmG2aKzE/0PBgRIPnL9b8v5igoeZi/vsC/lhRFxnqrnsphRVV28GaOcfZHh2zLuegHmJToekBrjnZ79Ryz9uObVB0/w4/9jRwkGzjZbTXfKDUDMn4JHsYkCYNtyUQUgbHtl4gTKpOuCbz2O19rsUQz6wFxFGY+b8A1P356saFqbM8/zeVJ+7P0LDPxXncaQBS5aJnT1VMWybKdugxHpGUKKwboOP3Bicdg4+55M93VS6bSn71OZE1k/CABY/thUo+SJT0ZeEJ9a2D97R2cqdVfUHM1X8QNKljjtgLSjKfCR0iG9KH5YXOwL1qhbDacwaFaDotUuJplNfcsBP0ZJBfbTBoZ7CAv+daIy02FuKjZImJixiFd1tqW2CwKlnsVqYHL+1nTiPexCczD/SKWMOvOK4cPTtNn7z6y0pXdWw2gO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08dd0f9-aa67-47c1-cae8-08d832cad2d0
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 07:49:57.6815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JShE/EC5Jzvwa0NTv6hh4exeHSekFGVjVDrkeAa8uQk3VZbLuUIElWUdBsIkcpQ6qLeitrhngtYHmHAzZjiMAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0120
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

bad_page_threshold could be configured to enable/disable the
associated bad page retirement feature in RAS.

When it's -1, ras will use typical bad page failure value to
handle bad page retirement.

When it's 0, disable bad page retirement, and no bad page
will be recorded and saved.

For other valid value, driver will use this manual value
as the threshold value of totoal bad pages.

v2: correct documentation of this parameter.
v3: remove confused statement in documentation.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 06bfb8658dec..bb83ffb5e26a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -181,6 +181,7 @@ extern uint amdgpu_dm_abm_level;
 extern struct amdgpu_mgpu_info mgpu_info;
 extern int amdgpu_ras_enable;
 extern uint amdgpu_ras_mask;
+extern int amdgpu_bad_page_threshold;
 extern int amdgpu_async_gfx_ring;
 extern int amdgpu_mcbp;
 extern int amdgpu_discovery;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d28b95f721c4..820a28c9e957 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -161,6 +161,7 @@ struct amdgpu_mgpu_info mgpu_info = {
 };
 int amdgpu_ras_enable = -1;
 uint amdgpu_ras_mask = 0xffffffff;
+int amdgpu_bad_page_threshold = -1;
 
 /**
  * DOC: vramlimit (int)
@@ -801,6 +802,16 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);
 MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)");
 module_param_named(reset_method, amdgpu_reset_method, int, 0444);
 
+/**
+ * DOC: bad_page_threshold (int)
+ * Bad page threshold is to specify the threshold value of faulty pages
+ * detected by RAS ECC, that may result in GPU entering bad status if total
+ * faulty pages by ECC exceed threshold value and leave it for user's further
+ * check.
+ */
+MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto(default typical value), 0 = disable bad page retirement)");
+module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 0444);
+
 static const struct pci_device_id pciidlist[] = {
 #ifdef  CONFIG_DRM_AMDGPU_SI
 	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
