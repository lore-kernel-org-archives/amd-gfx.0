Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B95C83004
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 00:01:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69CE820787
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 00:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="M1OoYSjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69CE820787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27A206EB2C;
	Thu, 30 Apr 2020 00:01:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9300F6E119
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 00:01:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8ioB1cFM0u6udyQsbQm53D0MIOU5zN48Su2Vsg/S/+cV3vPP5BSBGrLj4o9jhJvPrOpH3g/dH+dHwElLusag/QNw8SBpSrN69b879wkZzAEGg6M5AknG/lEYE+MPIpOKTPUruCMcNI/E6990c+XgfDvWEQUt0fda3UwfR+AYZ2M8EcYmBZO04qX1B95Xu2tioY9/zvAQhhRoBUw8tBVBQqeDcwj+pD4LQJ5K2UoDS8DHcOCkzY15NBaxLP+j4vzcs7f0k8sj7cYyjaCNjsen/R8adkzL82+WqbygTlXC8eIR67A/LiYImuUi+OFQIvL3GNsAw9CAk+NbOWYIZ1ULg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DL1EIdiNE0tf0lcNHzaQoOxKRTmSL2IaVE0bA4mVwqU=;
 b=nxbcjyR6g3NEhLO5e4AopJ7sfZ8oTYRCDvtwxgfuL0uBBxzdE4qXE1BuJ91pvpbVMvgMqecHumwkKK/pOYJSHINgsTMCzOOU7NL25ZKaBHnuY7hJxsa9PtPw+2gAEnH7nGDXQDmfGEbUOIPo/iSuv+oO4noML/7Il6gAErDzMaLwH5OvnqInDM6unbe+CRjeP2cF/u6rwPEpPm/WSwWD0f7t4QAsWfZ2R8kd95ZbroZLfb6WEMxuAPdA6nSKLAwf53Z4L5lNuZxYygpOSaPzkarxyjJMDHPvcKx8WX83XerzcymILm0rj8J9iKFODu63MV07zikyyy88O6J1OxGDqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DL1EIdiNE0tf0lcNHzaQoOxKRTmSL2IaVE0bA4mVwqU=;
 b=M1OoYSjdZ0ewXWz3jbMRyBXfV+6fhFS2Qhe9VQXPI1RDAxnW8Jgu8p2+Qca14P/Q77khqNqb009VvlD1zT1ijmSWSD5P56euPP3LlPICzBUddeC8mwIM6QcM2QevMl3zC2JN4J82/WhQO/h3mwwjEl9H0RyVoZNrwn3MM2Rdd14=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Thu, 30 Apr
 2020 00:01:23 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2937.023; Thu, 30 Apr 2020
 00:01:23 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: Add missing parameter description in comments
Date: Wed, 29 Apr 2020 20:00:47 -0400
Message-Id: <20200430000047.31083-5-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430000047.31083-1-Felix.Kuehling@amd.com>
References: <20200430000047.31083-1-Felix.Kuehling@amd.com>
X-ClientProxiedBy: YTXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::24) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.211) by
 YTXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Thu, 30 Apr 2020 00:01:22 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b5b6c96e-c429-49ca-6aab-08d7ec999e9c
X-MS-TrafficTypeDiagnostic: SN1PR12MB2575:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2575340C9BFEE9F48880796192AA0@SN1PR12MB2575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0389EDA07F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(6512007)(186003)(6666004)(6486002)(16526019)(956004)(86362001)(2616005)(478600001)(66946007)(69590400007)(36756003)(8676002)(2906002)(6916009)(52116002)(316002)(26005)(5660300002)(1076003)(66556008)(66476007)(6506007)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wJIyFHf4pozjNJMQuwwsQ5Pa0iUnUe1DTYE2oTT/9HTLffD+d72KiAirTio/KT8mDWuS2H2tQBs17M/hyg3T8BCGDgXWAZzuvFYIpxpGoAivRYrvMzJYxlsCg8W/OyWQPAHtqFcmJp1P/rmoksBzGia4PATlLbqXg86e8MPCFZZVWMssjj96yN5LYKPb8JS7K74QWuXhKH7oTOU2GQ4+kzQRQfDrjAK2TDkZnD/PPtP059Z1xeE/c37Ahk9d9TpFxSQ/qXP6rCQ2L8WzC9tLApoPdMNkRyvsFckc2rw8Du+KMqiBOT6znvwWVUeVGQMjYGGCMq9eYcaicmTdDvmA9mnLsO1AFme9or2AMLuUDrv81TaCDRL4RDS/dyn2qvky8ajKww44Xeg384JEAC1vXFzsN30J9XiZvHR38WW9bmHVpeLpGc4BZ+5RNQv9h2lnF3ahBqmBkauz3uGcmh5LE6ZU9BFG3DJQQuDgKpcr0yXYln8qLM5dVbb+n+BEv74j
X-MS-Exchange-AntiSpam-MessageData: 8c8xeNHx7zbtD5XNOPHOr3XLc4tKim6RuTTIkg8IEe28VfwzZxaP5GKabHtROOd+pV+Sd1rlyLqsU2UB/Z2uxagpz6xD0BixwEJI6YkegWFuno0/ttlBtIkKlMH4U0xgaFsxu921uqIHQABuqKx26a3dRiXsfRQnL8D5Tbc9h+yBQoEq976jvo+NkCMGCljuvrgdBKnx0ffKHHR1nEcCleF7qEZJDNEwcpUCUZuQN6syQonNk8WRNBTc+iJTmJ+Q+khJ1wYWhqm5f5OTbZDLh7RCTVoP5IQb7Gs3FZ4txZeCbjc09AkvPdyzCWWoXhFAXaKyglJDJoVcJsIO6JDzWu0HwcL07rz8q1Aaeo5KEZCSH12xlPDy1uZ8brnSPnG7reyTs1eKNyueeHYPHECA6hkhWdaPaAhS1lZmucyGnwd8qd6lK8kZeYV4yZywm30RUrLbrgbHHVRLQKSZeAJtx8SvNHRRAhw6sa0ZetYpkcH84WzLH9dCVXbr3CmqIPRY17Y4dVazvS56JTL7X88P0te3U5q9uvJb8s3jCUiyQSi6jUSvGfkT39l5LivXdG9+71Uc6bEk/WRnFFWc1iU7J/zfmn4dmvLJOlGfdiYtbp+r+dnSbwtr8eAk+PBwjERBwNUxrtO/Evp3a94Y7qEZLbN9NvMOn4URJWAp9av5TXkYvO8E+lQ0i022Xkd3krnvwl2hukoYzFDohSd2uVzI9+GBCbIR6omIwORjHAc3tQYVDWUcvuhAOehrytdvcoBoHd4Llrq9zc1CU6mykhslUNlzfkV4MqI+ylGrVCuSSiA=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b6c96e-c429-49ca-6aab-08d7ec999e9c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 00:01:23.3805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFEieo9vO+M8BUFmAMBIRWKqQ+Si4GylNVf8IzDCkT/HfTRjD0VyNZo1TA/1z9Xi2EkajeI7E9G+Gx1tjXHIpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2575
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Kerneldoc comments should describe all function parameters.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index e8529e244a2b..bcd4baecfe11 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -762,6 +762,7 @@ static void gmc_v7_0_gart_disable(struct amdgpu_device *adev)
  * @adev: amdgpu_device pointer
  * @status: VM_CONTEXT1_PROTECTION_FAULT_STATUS register value
  * @addr: VM_CONTEXT1_PROTECTION_FAULT_ADDR register value
+ * @mc_client: VM_CONTEXT1_PROTECTION_FAULT_MCCLIENT register value
  *
  * Print human readable fault information (CIK).
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 0aa5b82808d1..26976e50e2a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1005,6 +1005,7 @@ static void gmc_v8_0_gart_disable(struct amdgpu_device *adev)
  * @adev: amdgpu_device pointer
  * @status: VM_CONTEXT1_PROTECTION_FAULT_STATUS register value
  * @addr: VM_CONTEXT1_PROTECTION_FAULT_ADDR register value
+ * @mc_client: VM_CONTEXT1_PROTECTION_FAULT_MCCLIENT register value
  *
  * Print human readable fault information (VI).
  */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
