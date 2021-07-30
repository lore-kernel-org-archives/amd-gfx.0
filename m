Return-Path: <SRS0=IbmW=MW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4384C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 16:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF5A60EBC
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 16:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7BF5A60EBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44F446E3F2;
	Fri, 30 Jul 2021 16:02:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47D426E3F2
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jul 2021 16:02:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCI+9qyn4gz2Wj9k0iMzrxlC93/O9/HRPmV0zLSd/8TLcg+6xv7HeEmHV6N/jSgZ8CuRThGVDpOdHpFXrR4zKHZeIqA2HfPx4YPOReE/fT+pfqi8nxCH0CB3tCMjHEyuq//EjQp1K9FoWolQQfAGIO09CJewdE5JXxDCdUGltirHF7IMxk45yqFLl7b9Rc3NXsFqA9p3/NLx694lE2c6mJ3iUGTvw/EusOnsp4/WWTSWwb9HqiGzv1tYh3yjhH9UxY8Ha1DBzAJ5IDpm7PhxOc5IvK3QwJB+jzf5vEGfPv8n3oV0X3U9nvoTBUwPZcrq2UmpKhST7fx8Vn1niwHqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3fZzw/9/tQdwoxDXyK4QthJL7MATwg58fEJT+uaMGQ=;
 b=d6AKFs3AMk+uCQ2rDf57U1ZvzWODUIZFAj/GltwI5BxKnNm1A1tOh75fwQPWq2MKKHURuseReEEGYMTc6VjJrLaFB1dTv/8OWgg8EF5Q3OXnoTbEBGbNwPA+JrStZNtrv/1aGRHRnfME2+nAW7yeV632OqcDQzI83W7dv7e0O31QlimFzHeWkUBIvFPOSnawO1hF0WGi8LvUv/dakg9kX/OlZvluOh7RkyPTgmAVCNGNxvS4Wdlm+kd7tIq7mJDaqpl2RL3FE1YwbErFa2SScvOSLibikAe7BZ9zN2/wGVbvrMycbaW5xnGuM01gEGaxeMYtG5NlLJiXTy+2k1ePrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3fZzw/9/tQdwoxDXyK4QthJL7MATwg58fEJT+uaMGQ=;
 b=GaTaUaDJwXfFC4Fg+kckerUtYL0OeLiXQ5DIZRFBPJY1bG8uxBuFCeD7g50vBCfkRAf8VvLC1xrsjhWUtEdaOU1Cw9Y2ezJc0KZdDi6JtlinaYQn7BY4Q7SB4SVYIMEg/6GLaNH1FzFwtwLsFszfD4P0PfQlY23WGrtF4zX1bfY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN1PR12MB2416.namprd12.prod.outlook.com (2603:10b6:802:2f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Fri, 30 Jul
 2021 16:02:49 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861%7]) with mapi id 15.20.4373.025; Fri, 30 Jul 2021
 16:02:49 +0000
From: Mario Limonciello <mario.limonciello@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v2 2/3] drm/amdgpu: Convert SMU version to decimal in debugfs
Date: Fri, 30 Jul 2021 11:02:30 -0500
Message-Id: <20210730160231.3594-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210730160231.3594-1-mario.limonciello@amd.com>
References: <20210730160231.3594-1-mario.limonciello@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR2101CA0024.namprd21.prod.outlook.com
 (2603:10b6:805:106::34) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (165.204.78.25) by
 SN6PR2101CA0024.namprd21.prod.outlook.com (2603:10b6:805:106::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.0 via Frontend
 Transport; Fri, 30 Jul 2021 16:02:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e631c587-fbc4-4d33-d789-08d953737a34
X-MS-TrafficTypeDiagnostic: SN1PR12MB2416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2416CFAB0A38AF4AC3231931E2EC9@SN1PR12MB2416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /gO97pC1jbKl4KIRTIZGWEOIPTgKPjxZrWunNgA5DrsbZkyDDpZwk0OMXulsN1qhIKcSxFy6OO9PzxyVNSGip5HMK/g7Tuvb+s6ctyybaLinNFlP9pM5oDEOpu78Gubn7EkxtKnmV51dh+QLJCXomjrcAkwHiiJny7/wbmTlo2k3OEu3FDXiGK7zZaBPg0Rqsz2Addy3VTXAp1ZIzmPpcTDNDYxU1NcJ0+EYK8qeOW67+gzsoeeL08at2Ov2leOQ10823x25CF7gE2MgLuA62Y2OlGzmFEgBIz0nV/IOxRoiVR+e6oeljp4WAygU46cFquSQidLJOy1eKB5awY+8yEEGcDJJH4EIxrAS7zT0i7H05D3axwhpuy+4RPmE8ib/lklnt6uvLLrCa2rm+f6qKTyTAFc7yD+kra/O3OOFiTJ+HOyU9DSsDmAqEcvfBfXioYHssJ9n1BTWnzyUwBIUPiePP+wAaQft4/aWchNc8kkkZqT02Fikv768UITnd3/RWy7x/f49P/DL+kLR+MMGSNNMQnjTKA0WBh4INHhqDnrge+uP/vfeSUgwetbO/qjGpQYi1omSSq8+wZWfI7QaaApd+eKW2CpzkAkc7VjkaO6VUs/trFUMMhOUzbpPoXqzv3GZMNKBtbp4B4DXZUFi66nKUXCXuUSCgVBWH9KaAtujpsfItG08guwLsg8qJuoiUayIXOmMqlXII6dc3Cb3Tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4510.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(54906003)(6916009)(6486002)(4326008)(316002)(6666004)(8936002)(2616005)(186003)(956004)(86362001)(26005)(83380400001)(66476007)(52116002)(66556008)(66946007)(7696005)(2906002)(36756003)(8676002)(1076003)(38350700002)(44832011)(38100700002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LmxFy7xVCNG220WOv+zjadxbRnurCvrGSkrg1zvEKuXR51sFck33NSnCSG9h?=
 =?us-ascii?Q?yb3AG6qONImAUd7hgcyVHGdsqZweUKCeZ0xoCbNYMxBdwLzzkXUdoEz0VPs+?=
 =?us-ascii?Q?ZGKNQPZM2nBI9uBWGvyryP9YZ+IfQZOoVqfkQg7AzhqAPFAUCRAGPx9ckG0i?=
 =?us-ascii?Q?fzzBc4VC+5fehqIVZ7K8HcIWuisYyw+vT6o/0BcY9b/0fRGw1/beGNaP/vBb?=
 =?us-ascii?Q?aVIMOBgq2jlfVJvg35VOZnZDxVQRaxeQlIBoQxQreatzcBI8lNQYX+25rSBb?=
 =?us-ascii?Q?ZmQeWFP5zolF4qPlOZsbiR4j6+5wIvcwTai9NVLWOYwgKtiiId3hUHvADdde?=
 =?us-ascii?Q?5Tx1uSGFNaFYInxQpPiZgd956yv1teQ4E1lylb7j4qGKk6T2U/zViDrrbwHI?=
 =?us-ascii?Q?bVi+zlf6WC97BytTlRGIWIU1PJBWDq3y6Ovgak3qZ2NlD1EZb3Lcbz94zYHO?=
 =?us-ascii?Q?aP0k3Ot3+9r9zuCvJSwDRqC0J67sbmca8gnZB6s008EGDoHcKt1geWiZ2yhn?=
 =?us-ascii?Q?YdhbHihXpQos7uSHKrRk83xTGDJc6yx1sRwCmRjLn1WANj0CNSwo7+DXrFxA?=
 =?us-ascii?Q?HFCvTiAhDaJbOlZeN0ZZQYNBd4QCZp3AAGmZqBECR6iINkUJImzqZJ2YaK1F?=
 =?us-ascii?Q?GInwlb0ad8Q81w+RZzhkDAsgLkdFRvh2o3/QmxB/GR8i99kLijndcJOo0PvD?=
 =?us-ascii?Q?mDAXPZ7OS7o5QNrOhvjsVN89G0dI9KygdUTKJ3UVpy6NVhOGrBKTQvTew0jD?=
 =?us-ascii?Q?uU1+/EwBTCRS6wW0J6Qe0p5V8b1BKh4/BGMJp5F16JhGNbo5KTvYdRRkOfWU?=
 =?us-ascii?Q?wIpKRNMF8RClF5Qeb/0o0qL3+Rc7aHE7sqV2IixN/iU2ZiCeEYh9Amt07FFJ?=
 =?us-ascii?Q?wYzuIDfZRJduxQj3zoB67HU71iiJog12UZH8NVguWmLPXxRhWWvWU8+Gjes+?=
 =?us-ascii?Q?CGxGCp/AvP0bpyzC4pmPCCsX8OLaYFtAugTbyYxVGhLQn18mGmG0SPnBi6TO?=
 =?us-ascii?Q?RRb5nVJHEIGUvPWF6pAyqzZbWwETzmwjIL0jwwZAEUD1FieHW8Tziz65UFvF?=
 =?us-ascii?Q?JH6FvN6Fff8RfkiKwVY+oviHcdJB/u7J8CzzdhIic9C/pSWVyHRbMdYOLfJ9?=
 =?us-ascii?Q?JTt/sUSJ7uxMJF9znA0WEMsYNk2kD6zClhPzBNe2VQpysFWUxMmsfLRYMQ7y?=
 =?us-ascii?Q?sitLuZyk1W7N36vkHhYh3tyEcrFvNl7cNgSmH7JMGzMbrpzEbl/fHhDnfZh6?=
 =?us-ascii?Q?SzLLbUOH5AuV5iGTgkgQ5bd7r390o6Jw6rkRJp3e+Nm6Buyl6rOrO1lPE8vG?=
 =?us-ascii?Q?XDGHKb53XesqYuAnNM84OOwj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e631c587-fbc4-4d33-d789-08d953737a34
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 16:02:48.7727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNN9OKQsQTuA2aaew2j4FoLJ+2e4jqjPlVpYUF4SiUhpjlQ0URJIfS3SChUT8mMcMsbHunlTjdODH08A236k8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2416
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is more useful when talking to the SMU team to have the information
in this format, save one less step to manually do it.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

v1->v2:
 * Add Lijo's tag
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 96ef3f1051d8..cde82677f0bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1410,6 +1410,8 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 	struct drm_amdgpu_info_firmware fw_info;
 	struct drm_amdgpu_query_fw query_fw;
 	struct atom_context *ctx = adev->mode_info.atom_context;
+	uint8_t smu_minor, smu_debug;
+	uint16_t smu_major;
 	int ret, i;
 
 	static const char *ta_fw_name[TA_FW_TYPE_MAX_INDEX] = {
@@ -1555,8 +1557,11 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 	ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
 	if (ret)
 		return ret;
-	seq_printf(m, "SMC feature version: %u, firmware version: 0x%08x\n",
-		   fw_info.feature, fw_info.ver);
+	smu_major = (fw_info.ver >> 16) & 0xffff;
+	smu_minor = (fw_info.ver >> 8) & 0xff;
+	smu_debug = (fw_info.ver >> 0) & 0xff;
+	seq_printf(m, "SMC feature version: %u, firmware version: 0x%08x (%d.%d.%d)\n",
+		   fw_info.feature, fw_info.ver, smu_major, smu_minor, smu_debug);
 
 	/* SDMA */
 	query_fw.fw_type = AMDGPU_INFO_FW_SDMA;
-- 
2.25.1

