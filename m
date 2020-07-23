Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1BDC433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 08:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 843C42084D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 08:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3k3RSFNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843C42084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A7BE6E49C;
	Thu, 23 Jul 2020 08:34:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0847289C03
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 08:34:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfjYPCfMvmb06z7qZyvB395HkO7q40ybW8aEvhW/YD1qPaAvuR9QIE4jqjAbVftrq/qP745JyHUETd9OZmL2BIX2JVhzQPzHCIttDlh6Xc4WxAmMm6n7C0i8dEkDY1TB834UR4OTeou8ZXcu1ItEC8REOii0sHriRBA4bYIC/afmi/ndiri2FBEZZkDCFMEWG7IMlrEy0yAZeDTqTLQ5gk4b8qVcys6I1voGuUbOKRwUFlR2iYnzBnLrxmgV2/YH09iHl9YoMQ0MkqpdkIPnvVg1dupfu4PZ3txNfpir1JyH+4uXcn3c8GnrsseCH4oMWxOCyqX01NyR3M/gc823iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UUUmUxO+CBzbr4auL9VHSu7RxYDrcenP3nqtEf9VdM=;
 b=ONjcmG+mv6JpwyRfJR5AnMEqGYQ+0DF+nP0v6jlk6ZgcOj0FXo4snjHp9isHrpjZu3DFjZD15nJMIz4oxcpiSf4I03A+kmmGORjMod/Dec3Z3bkUjBcKAx57MDWbETjrNI/zfRqHVmpEplKLDBn34N0aEcid+hf2rNt3sOBxHagvdzFCF9yOc/llHf5XuFMD7ECJ2iZHBdsSScX8s629HX1qlmqJwuPLd2E7Q4YEEqAehTwGmEi10kHNPGCYr8B7puQkRO/JstH9sMZ3GP18jAWa5YgiKSXgvS0nsyRuM2Tt2R7JdGYUNai/FMj0kbdBlQCIP3wUBG5XGC1nnDO4Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UUUmUxO+CBzbr4auL9VHSu7RxYDrcenP3nqtEf9VdM=;
 b=3k3RSFNGtrd+/Gj8iIz2TSin5J6FP4Daqg4DgTJucA2blHwF2e5tiycymYGdhjgw36wF/O38IjC4FP/i6/wO4KXXjbOw3XcSDfq2aQMwa95f+vx7IIqF38HukjEc8eV6GtZDrp7V+gJJMY8KaPdDE0J7Vq6P14A5a4d03yXGWlY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0005.namprd12.prod.outlook.com (2603:10b6:903:d1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Thu, 23 Jul
 2020 08:34:09 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.024; Thu, 23 Jul
 2020 08:34:09 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, Stanley.Yang@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com
Subject: [PATCH 1/9] drm/amdgpu: add bad page count threshold in module
 parameter
Date: Thu, 23 Jul 2020 16:33:38 +0800
Message-Id: <20200723083346.8743-2-guchun.chen@amd.com>
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
 15.20.3216.21 via Frontend Transport; Thu, 23 Jul 2020 08:34:05 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f11cdd8-08dd-43c7-250e-08d82ee32af5
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0005:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0005EB93F0E10733C34FA357F1760@CY4PR1201MB0005.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iooqm6r96hQitcLL0p0GfGRpX+TUB3fFYGQkZ00mFNKSGl9QkIqiM3Rn7zPYxErxOqeWx3tS4+EYkMqKiXTL3weUE3KyR2e79DR8MaXo2yfaH4Gnsq6S16bz9JhJMLNvwhTQpZAZKyXT9TLhnT1H7FsT9X0Nn0vakKfBzpoS62Xnpri7ysoonyLbkxGxiOAtu/4iWkBas9H2AiAjUv/lN5ls7N9p/lfBgzw/8S5FpqbTW9ty/vDzKNRJagzF0pekp6rLr1KuGLG0W7u8KwEwWKwTCM81Y2Tr3Zv7c5+BkNKIVfWi4QIFanwk3mmnWl72
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(8936002)(316002)(2616005)(36756003)(2906002)(16526019)(186003)(8676002)(6486002)(44832011)(4326008)(956004)(26005)(7696005)(478600001)(52116002)(5660300002)(66476007)(66556008)(66946007)(83380400001)(1076003)(6636002)(86362001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: W7z6L+V10lnbQfl2g6kY6P89zMw3IqqDr9ZmQAyr3jQYkTShwUw/8UfsvkJI5ankF3fkhNY9eKe4ehLjSGIozpPO5D5FF3EfheWRgopgNed3E83uYj3eEse8KM2A23TOSata8SvH/Lt159MkKCjw9ntrIueklqQIRyDQx6d3r1L0kxNEPw7DnVWfN2N1ZYEEJY+XV1cH+D3brLd4KE1+JmqYqQkVhWR5O20RN94cfYqfUZguEd5IiufxAjwuUy06QJdTtf/Cm5ZhmdI6I2h8ENoHq2i5lSmZQF+vhhq71R9pCtGKcsrgp7yEwY9puD2SlC3hAsv+OwxhJeyOeQ3eMw5VzGOPu8zPfvW1Po82qXcXJaVtQsdXLJoVU1NLhicHfll0d32rK5g/gDptKZFiz75ZjDa+ys92ZZ1IEpn+S15qa8DX7pNVKlEujOU+aeKChpCSC1O024PdAQyfGfRwN1vJ+H4agzKRUGgmflcSqEKGd0t0eB3PGTRQ0Uxujft6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f11cdd8-08dd-43c7-250e-08d82ee32af5
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 08:34:08.9576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SY6PmIM/Nen+porMu8FnoNlcU/QhNJmeKDKG6Mxvgy9F5gG68uvdcW7T5hUt+tjRuC+9FcrXIdDmBfGBHAZcRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0005
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

bad_page_threshold could be specified to detect and retire
bad GPU if faulty bad pages exceed it.

When it's -1, ras will use typical bad page failure value.
When it's 0, disable bad gpu check.

v2: correct documentation of this parameter.

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
index d28b95f721c4..5a517f2fce35 100644
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
+ * Bad page threshold configuration is applied by GPU retirement policy.
+ * The detail is to specify the threshold value of faulty pages detected by
+ * ECC, that may result in GPU's retirement if total faulty pages by ECC
+ * exceed threshold value.
+ */
+MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto(default typical value), 0 = disable)");
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
