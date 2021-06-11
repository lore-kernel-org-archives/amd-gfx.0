Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89601C48BD1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 03:32:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA5E60D07
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 03:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA5E60D07
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA0506EE28;
	Fri, 11 Jun 2021 03:32:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0549F6EE28
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 03:32:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtYA51vc70tmiDQoFw4SrAEQpWauw3BpOrQZcap18qvUWsg3eSU2zhiLm1uFhBNmhHSmaibQ8EVdTSWJnnpczYMgzY2cS1blK78txWvGXKxdLGumkRhHwJMTdsSls89vtAlxka9gn2/MtqSVrMVQfT+KM3M3IDSXSO/dU5tGvhLCoXnT3tnoc5UQBXYg1/0IhJ6KPmErpmFYzNNB0BN87dDoEfqn524bate7b5AOKtWkifRAXIbFzyaIJyInbH8KtpNz/+Pw5fZ7X51tlxfTcASRCEB7sNozf+hx3lHhH8w1WASUZ5sK2y/5KDcVcd4XQsiBs0FIrkgs8x3V9WFnPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bl0sE7nIN73vtLF59OpbwF5qvccanZcs0HqHzifKBE=;
 b=d7dZE8S4HXjl5IsrjOODOWPbdmXSJD8VJjximzzxCUmF1ohxkvILRXHuk526b2DLxTThoXJBj9kg8GaEtjTgilWxRlmClxO4mvWJidtlx56GJVZ0AVFNwBkgA22DQ1jF+inlwrfDTnHyh6Q3RYTbIwxqrt6W/I01tT+v00Aa0BbZ+b79NQgfHOdwRymT6jNVugSpVBgmK+CTVxgeiJfrgRlJa84w7KhZCR3VdywO5TUW5PYE2VVFixeIc8E2g+pS6GDUXFIqCPrfcWW7nc3fAJYy5YXOrh8DWa9Ev6uhO42vuBsrTlYhrENXiSGQPZOgS8+5hemtCYhAfm5e+djG5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bl0sE7nIN73vtLF59OpbwF5qvccanZcs0HqHzifKBE=;
 b=ArBT1xoqQ8u5wVRjw7hk+5Rc4XF66bKFkku10t0h5t9BWKDzaWBMS0m7KCnVA8edoD8fH5e3rgtzvmMo+vwAep9QfjYy+5NUVGVqFiXuQnMQKSQAVwEWB85pe/wERfvoUbA482g8WosZtXsSvtx84xfQ1yeHai13IKcpKh1RVug=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SA0PR12MB4559.namprd12.prod.outlook.com (2603:10b6:806:9e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Fri, 11 Jun
 2021 03:32:19 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4%5]) with mapi id 15.20.4195.030; Fri, 11 Jun 2021
 03:32:19 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: move CoherentHostAccess prop to HSA_CAPABILITY
Date: Thu, 10 Jun 2021 22:32:04 -0500
Message-Id: <20210611033204.32224-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0501CA0110.namprd05.prod.outlook.com
 (2603:10b6:803:42::27) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN4PR0501CA0110.namprd05.prod.outlook.com (2603:10b6:803:42::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend
 Transport; Fri, 11 Jun 2021 03:32:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0383d3dc-0868-4f29-4549-08d92c89843f
X-MS-TrafficTypeDiagnostic: SA0PR12MB4559:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4559C1E87A08984E292500BBFD349@SA0PR12MB4559.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QFDlqO9VCxYX9L0HJHrSJG/IqbO5p1mt9XdzYRSbdwrO+0NfItg7Rn5VgItT8yqS9YYxbBBtHnvJlfZG74Aext5geHAcelhrSTlwoEmFwJ/MpogcgkUCfC5NRLX8Nxv+HiRdBQnxIOp5F1xrsvE2gtV91mpaKWXB2SSxsqj2Dl5TZlHdLx4qcezDdgFOS3rOkgVxiW6o3PcVB03Zt+OPnGnVoyeKIPxJfsLtRLj0oH87U72xP3PG/Mxk9vireWMFptVD3HTEHGn1svjXcsl50l2xf8WZGEJKh92jdwI/b8hpVfKXtUkcYHWOdDEkocP6NHvWys9BAlk5RP1BiGmD8WCE9Z5MRLrao0j0/TSpnWeGoSLMEAt2Wo9qpFhuWtk8whpXBnUva97Sqrlp8o3826FXraDjxm7KPCth3gw7qnIGa+RBa1W0Ti3cK5Cfnur3b6oe0ZrolZtBrujomwSpkScz5SzPkK1a/9MsyEQjqQJ3flxThYY6hpWGi/CqRJq9jqfZ+0hq+0M3QChorWTbXj5ZFCS/OZ07tGypO7dRe9rR5rmWcbWKhXV6rpzVESWFh378A1Z5q/BNRB4sKPQw6Kv/yjWkVv9utxvwRUgn3/5GMwyHgbr+GfFKmIp6fN978QvnAguVykgGzS1NmpGoCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(6486002)(38100700002)(1076003)(8936002)(26005)(52116002)(66476007)(7696005)(5660300002)(2906002)(36756003)(16526019)(66946007)(66556008)(38350700002)(186003)(6916009)(83380400001)(4326008)(956004)(2616005)(44832011)(6666004)(478600001)(316002)(8676002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HJbS2o7sgsfBaiekmRJWKEueHawXq3tPqU5EGjKPPxj6pu8P/5kVl4310E3E?=
 =?us-ascii?Q?ViXfgSTncwST4lyWrn040At3dLk6XxANmBmtpybcpmbHXRlR/plqup6bTNXi?=
 =?us-ascii?Q?wl2RiQHN1saKEIv29L/oASVwoYX/S//I88GQ4WhP1ugbmTx9BsA1lJhB8/xl?=
 =?us-ascii?Q?QizSzf8RbpERk03CroJNOPeQ7gbH3DrvQ5AR1Rt9H47hVrqSfq5zOofqozjH?=
 =?us-ascii?Q?wgAHEjYY7513ZDj1FMjvEKKPbUPIBX9MsYLHjS7YMl0btglbiwFDVMONKZxJ?=
 =?us-ascii?Q?IXzi9BUmtL3N4t2DCX0dnGiIQ2lkN+9j0UGBrxGwzXhrKhlvoMvkeow7YWTk?=
 =?us-ascii?Q?riGhGgoRuCj6ug0k7K2H9ADijUbrMsyGJWAwd5BWz1kRR69iIhUcpfCLEcM6?=
 =?us-ascii?Q?nSpO7Yw9gd3swDYH9JXNFWlxmVD9TtOrVWjbW9ztOYnCWqzBEUmEivgljyMW?=
 =?us-ascii?Q?q4lWxLVpnmB9pMKN+jqROCeh5MEmH+rKzD0iecT32QOl9p5FfEBV9qAjTDzp?=
 =?us-ascii?Q?amPXhthP2ewCgms0Y4sMrEv677LdGgI/tTBz3uUhFnQytjOhaXrZVmMyIM6y?=
 =?us-ascii?Q?+s9RbRjQLHNcH+8GSoPQKxCFEj/3wsSe/x6MylWv6Gn2LEDqXLfXH6I+s60c?=
 =?us-ascii?Q?hDzu/WOBMuU7149f0ued81JfpGGxcaTi/3LTnw8J+8XxmQUmk9nqxLLOxs4Y?=
 =?us-ascii?Q?lYRd6VxP9U4yGPQO27iGI5WHELYQt36MWUPoyj1cymMgRMDgU7UiWWgzTo6q?=
 =?us-ascii?Q?rZUj9WmmpgwUQWpep700/ycSlLfJN8DP4GbIJo6eP1fBH6bT0U2D0VmYcHqV?=
 =?us-ascii?Q?t87kaf4kmFoBwE4dL231aWp5/4/K+QCXNmQogxcdLbE/GVzfWPC3jPpUhSbA?=
 =?us-ascii?Q?bL2vm/XpwkmlD+KsXaiZH1UBC5cFYoRV8rRsZuQNh/2R3VVJ+rp8fgozxaiu?=
 =?us-ascii?Q?FrDCQyaT1O4HitUS8UCoCQxANw9iYQ3Kw2veA5Y5Tek3RgJXseD87SOzSqYN?=
 =?us-ascii?Q?RY/uHkLlPFw/cO2KhE5m/QNHT3xQFVAbVQlhZHxRyOyhMkUessE5GWDcGNog?=
 =?us-ascii?Q?pEB6gtomhHumdRz5sn1QqUReO8rZ3/9UEZThzjSO7vALk4k32YRREt9DBj5p?=
 =?us-ascii?Q?RvzGpEPMKzYPQPBz/ZSg9PQvUSjKXosOmHGtGGMLVUNvPaUFNrk+iLBg6qaG?=
 =?us-ascii?Q?GTxdfb5Pzunpqg+ciCRgv7r2GkUb1QIRMZNteWsYZlVrNhZJz8/KpevJvm1x?=
 =?us-ascii?Q?VEAEY9ZslXNjJOKPvUYBONrFI+oIRMdbODLCcVx11RoOg6SwfkjKrCgn+Pv4?=
 =?us-ascii?Q?Mvx/k1Lh1MOMbWx0MkRpH9P5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0383d3dc-0868-4f29-4549-08d92c89843f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 03:32:19.2009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5Y6XXrtkm5Z9uKn1kqC1RgvtD2SR7zr5Dq0S/lb3cpSyJuwqZlrizoLc3buEZIrUru22buHqZjitagEPYJZrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4559
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CoherentHostAccess flag support has moved from HSA_MEMORYPROPERTY
to HSA_CAPABILITY struct. Proper changes have made also at the thunk
to support this change.

CoherentHostAccess: whether or not device memory can be coherently
accessed by the host CPU.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 6bd6380b0ee0..8b48c6692007 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -54,8 +54,8 @@
 #define HSA_CAP_ASIC_REVISION_SHIFT		22
 #define HSA_CAP_SRAM_EDCSUPPORTED		0x04000000
 #define HSA_CAP_SVMAPI_SUPPORTED		0x08000000
-
-#define HSA_CAP_RESERVED			0xf00f8000
+#define HSA_CAP_FLAGS_COHERENTHOSTACCESS	0x10000000
+#define HSA_CAP_RESERVED			0xe00f8000
 
 struct kfd_node_properties {
 	uint64_t hive_id;
@@ -101,8 +101,7 @@ struct kfd_node_properties {
 
 #define HSA_MEM_FLAGS_HOT_PLUGGABLE		0x00000001
 #define HSA_MEM_FLAGS_NON_VOLATILE		0x00000002
-#define HSA_MEM_FLAGS_COHERENTHOSTACCESS	0x00000004
-#define HSA_MEM_FLAGS_RESERVED			0xfffffff8
+#define HSA_MEM_FLAGS_RESERVED			0xfffffffc
 
 struct kfd_mem_properties {
 	struct list_head	list;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
