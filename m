Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0ED4C433E8
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 08:34:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75A2A2084D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 08:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Alto6HJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A2A2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26B6A6E86B;
	Thu, 23 Jul 2020 08:34:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB4936E86B
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 08:34:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwV5LlDy9+kcllWTer3rbvCk6o7xWKtcEEpEFg1IQg/xmlMtluo4maP9PUS3023vtxYe7FALBHzqv0KHpbOHoE0JMJSrwi7p7mvdzEw7r/Sa5IH8zo3IFkmPAb3yR7HvliYWUHvvUeZ0eqQoKn1A8yFn4HLmw/6ZCSdsgpGzQBzNlUngD3jhtG2umnGPI8wv4nyQ5cfNqL/2WJz/M7T7k0npPY+ATNrdXY7/72KZJR7BephYzfEjJTGi0McXcMzko93wOI0vqZxOpgAyfoMNNfW+bgfdgq+YjO+ys6ttgk5dPdy03GI9wcmxQCWAqcqZyVpcdHSOuHAtmYTHA2JBDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scncX4XXRa8Ei8h8fARnAuUgr27EpIbfq68H867uezY=;
 b=Sl/XkfPItdTxNn5X41SSKzkYMELus4wLubkKTWFZbK7w87cFoNgk61v/WMfSbNGejCbzxAvjxS+2MPNacXR/EJy+YjAMm9jf4SBaANWufNegzQ7YX3g5PADBLbeX0pPl9PO4KDTSv0BWANpmXdcSOhAGjq19T/SiFU7JSDfKoTGklsJ58wh23BawTlCUOn1c36L0dpW0ar+pE6gzc5FE72GkeTINdJTur8q9bg9qV+tiSb8h1zyt+O4jYVTkr9RR9ElVT20S8K5Kpk8MFeIztQU44yiNf63ErjR735nqvH4Km+QVs00QsPpfC30aY8WAu9M2Jytm5t8J5eQR+5kHBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scncX4XXRa8Ei8h8fARnAuUgr27EpIbfq68H867uezY=;
 b=Alto6HJ66pO1Y2ug5876tp0MRHXs787YifTZ3kHyyCXdnsbJt/9nCbvNrKK62JbgT3GFuBgvdbphln+MJsGvmvIkOf1GcSx7bmmXx25+Nn70GMfXUaEZmMxhBHtdZdcec6yGDg/7nP5iEOqXpdMHy5nXCo/ha29GR0Z+FcF+v6k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0119.namprd12.prod.outlook.com (2603:10b6:910:1e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Thu, 23 Jul
 2020 08:34:33 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.024; Thu, 23 Jul
 2020 08:34:33 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, Stanley.Yang@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com
Subject: [PATCH 8/9] drm/amdgpu: restore ras flags when user resets eeprom
Date: Thu, 23 Jul 2020 16:33:45 +0800
Message-Id: <20200723083346.8743-9-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723083346.8743-1-guchun.chen@amd.com>
References: <20200723083346.8743-1-guchun.chen@amd.com>
X-ClientProxiedBy: HK0PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:203:b0::21) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK0PR03CA0105.apcprd03.prod.outlook.com (2603:1096:203:b0::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Thu, 23 Jul 2020 08:34:30 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3de3b45c-d93f-4274-b1f0-08d82ee33983
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0119:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0119DF19EFA88CDF716F5F4FF1760@CY4PR1201MB0119.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:359;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJ1nGEfz63vXAUDd/8D5AtagqUD9n6vJgLimmlehV85vY7McuPaQBmbrffLg8WyVZtL1ZS8Uzn+W/2YB00JEuIznuP4MQI9f0npB6+E+X0/kGB7kfZJcZji69f3M1McL+96zKc0+Ki/Y1Jkh7QpiaWWA9wKCDMZo2s4z/OMwq1ba59Q+dVDjYuBAfgNdnKKhCE1f+Y8AjWTA3WyaPKmtKVoncUKOckNdc9jlpmPXH0FbwWaHB2+yy7sfIJuWvxzPeNak75lqQbF7pJQlh+uOapajqg1bUTWsf7hjtt2bugvnc5mhYYVBZank/Lhsr/G3qIgdi68VnIwAsFNllKIVHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(478600001)(2906002)(86362001)(52116002)(7696005)(6666004)(6486002)(6636002)(8676002)(5660300002)(4326008)(8936002)(316002)(36756003)(66946007)(66556008)(66476007)(956004)(2616005)(26005)(1076003)(186003)(4744005)(44832011)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: KxxaRvM8d6FttYnV4ZXKDKp/nQUUlSF9ek7e71roClEtE0Zryj00QMGtKs4kWAomyBtMCauGqFX+U2yUuyulnDAwhGlqV7gzxCeuS2in+OGNe10Hp2MQBgo+uQNOCFMlMKZMME+16dpHi20hWuH+k3FqGZcC6Ii6wxQb7gO+EYrz3AHA/QI+sOxcUwWrq67M+JrXRlGHp6oyK0hh1aezYjJFwmu9gElLCqes5o9BfObO/ejae2rRQS/1JgmjzIIgMz+bS6q5WtDBmJiIo6wgWVDGnJ97tfnXEfuapKDVKw9/ApNaYkcQRL3YSrvIYM3VQ5mvkwsgW7cIrQZ/kLCqusY3MTrayoB+C78FfcWI6jVzmtGq45lAD6KMocNrT05jPlI8IIwm5ERLo8r/LKBNNXu4NjhHkCYYTgOkfdj4uy3CgQzliisI/XbaJ5+Z3BdhYf6MJ9ORXC2BTLU4NPSQwCEqgIeSHDrCnpDrFtXR+4S25KZEb8nXiMQhMwPm+zRk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de3b45c-d93f-4274-b1f0-08d82ee33983
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 08:34:33.6198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1jFFQ4Unhhb04Xe6YWuOLiQ13hyaa3DqUdvzQifHJBVqD1ZRTHVy8tQM7NjET9aigdHKIu1HnNCK7C9QqVX1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0119
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

RAS flags needs to be cleaned as well when user requires
one clean eeprom.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index acb8231f2052..003bbd023c23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -371,6 +371,8 @@ static ssize_t amdgpu_ras_debugfs_eeprom_write(struct file *f, const char __user
 	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
 	int ret;
 
+	amdgpu_ras_get_context(adev)->flags = RAS_DEFAULT_FLAGS;
+
 	ret = amdgpu_ras_eeprom_reset_table(&adev->psp.ras.ras->eeprom_control);
 
 	return ret == 1 ? size : -EIO;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
