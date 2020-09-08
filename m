Return-Path: <SRS0=P3OX=CR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB930C433E2
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2020 13:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A34C922CBE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2020 13:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lb2Us8pN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34C922CBE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6061A6E1F4;
	Tue,  8 Sep 2020 13:06:55 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680088.outbound.protection.outlook.com [40.107.68.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90B6C6E823
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2020 13:06:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fh7sqNVVDrj685IgdKpzhRcEkcnDkm/Y32dAqc/vgRTFVKGweYqEh6NUhpI3XZBYSdLMevzYoI9e18DWfzocFkgYZXSELYpy3f3D/A2TpWZqT3a+atcP5kOsJtctZyTydKn02YXZmJurYnJOcZcNdc4UmGbk8S9YhYfPBNd6ym8XnHTCiNJe2Kdet3lmfDaDRYoUpwPFEzLDNgX17/deSLKk7o9cBVu7j/DcVH7hT+jlmbEqVvyqUobkd7/RGvIjnnI0pMbPgjTXqjdzZNzmIpAtn2I+D2vmn14i/h0Jf6t4Uyvr+t/4F5fsbcvpVzwd301OjHFLAYPvEf5azkRlHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VV9vqxJ/WNicXUE0Cv3GQ7L497QR99GToUE+TuKo+7Y=;
 b=H4cb+6itKM6vtyhxELJ/kjAu/gLP/g5rY1Jcpj7Z0iwhwo/H/nLKDcODSEDmTfrGeIzCQXzhkU0hBssnoKNaKhcfrcaeyjIcZrkZH7cCXbqo61Ie4YNXGILPt3JiNwy/4dUw5+ISKudTa5Qa0/c1CLE2mYtYHZRmCFUBzwHiE7AxYTeHr8s65GT+SJFhuz38KfwyKwomk4a6Ux7BoVqNahn70bVlin8yXU5yLuazfK07jtvgF0HiGD9BZQ/aXHQc4H6MaYTVlXrhThNbJnKRV5FSbL2+/4+cxa7JeDrtqw7PEA12ZVqOYwpR2mcjAc1iBn7JfS4RMPwVmDmdO8XEyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VV9vqxJ/WNicXUE0Cv3GQ7L497QR99GToUE+TuKo+7Y=;
 b=lb2Us8pNbV1M2G+oyhg1UoiwH6b+AZY1pMH3jlv+pjn0tK342WEkSNkwhmkwtbcRF//1LkcJHkxmSNkZDkdiSPDp76b5fDi6pYffNue9PQI9cWippGjyZSVheyDqbwf2j4vIcYZHCZ1vYnIWduvTxYjbt8n4bI3CVDugKllQo4U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18) by BN8PR12MB3604.namprd12.prod.outlook.com
 (2603:10b6:408:45::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 8 Sep
 2020 13:06:52 +0000
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be]) by BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be%4]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 13:06:52 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: add xgmi perfmons for arcturus
Date: Tue,  8 Sep 2020 09:06:03 -0400
Message-Id: <20200908130603.10344-4-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908130603.10344-1-jonathan.kim@amd.com>
References: <20200908130603.10344-1-jonathan.kim@amd.com>
X-ClientProxiedBy: YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::38) To BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend
 Transport; Tue, 8 Sep 2020 13:06:51 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d47e1199-a57c-40f3-a238-08d853f80d7a
X-MS-TrafficTypeDiagnostic: BN8PR12MB3604:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3604F31091069BF1FFD8222C85290@BN8PR12MB3604.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cC9ciqoFRm9zNs/t/sc4lHP6XTVMbRxc/d4UyqAoNW6s060wY2AvM6x3pk2Y2bJNHuhCWOy5+wTjnTEQ+NUYr5F2zAJy/XcC3YGxOcqmPaETT+ufBeq7vx9sQqOjWh+BX0hHHNmJ/S9qz/EbXfAWv7TlB5tuYaKioYCvEvoi48IwvOlXWeWuPnI7V9DXco6xJinu+SdjerYMH/faV19MincpkjV9Nn1voRX3i/P+HhRT+1+xxYRtG+Sdhn3PTsFJhANTBLRcdw6NT0zBC5Ta5gypQDu0RfEoEby10jTXqpGIh+BfvaRrMWS4/hM1mjqDkBWQxxy8nTmLLc/hD91yNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(36756003)(26005)(956004)(16526019)(2906002)(6916009)(2616005)(186003)(44832011)(7696005)(6486002)(66946007)(8676002)(6666004)(5660300002)(52116002)(54906003)(66476007)(66556008)(316002)(4326008)(478600001)(8936002)(86362001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: pt+uXgoOGLjvru0vJTOtkx65Xc6WFPmlhpFWl1x9VK1PezerSOklZu4VdQKIYILsjbTSkI0ZIBRy709wBuOBXgpCr/cEHBPgkjB38ZnE6McN1x73YV1bRpFFl49aIi+JjBA8glPutCbitd2kyLs2IjmRgeEDpKV1TI0NfHTFCTXGwPAtECsRkv75Q5OtvY+LrBlkTGzNSnC+5xAM0LNsti0fYoWr/nOfCnfMiIr6rSt371lp5Y/9GJwBjB4WhvgsRoNb00pZhf9ZhumHwWmV248M6rv70Jebp8P2uOeWqLWKGPdCl+M3KfV/Y41vL0/mrQCtvvh3PtgI1mBlPnFvcRFx7KFqBMFovlyulR8YGNk5QKIQxDjKRTnShvK21Lcf57Q1t3XUviv8p4IEhExXU93s3J4wGlxgr+BpBvu1kUDubhOyPFdjyre3PEqZidtLjkdv87MgMoijKVr5OT491kKzVLj9j2ZsBnLsLsJ8ebFDVQ9YwhiiuXSKdYFMbuTnfZXU2lH5g+dNPpUDR5nqcj0EsgUWFLFOuepYGKrW47n1CoQJSFai8JSsMxADz/2jKJ+br+4RcKpRMLL6zXwd4kK/ViIe0V/Ip8cw5YRDRxiki2QnjA90bPhbzd3Eb0S2M7R0jtWby2SQq1DaKGUvqQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47e1199-a57c-40f3-a238-08d853f80d7a
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 13:06:51.8449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0NjAeVUtamDupYPY0xtJ2es9XGeykhEqF99ddKVsN7oYZe/1SLCiKKYf9G89KZr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3604
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <Jonathan.Kim@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add xgmi perfmons for Arcturus.

Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 55 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c    |  3 ++
 2 files changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index 82f57bd38716..4adf9c6e3944 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -34,6 +34,8 @@
 #define NUM_EVENTS_DF_LEGACY		8
 #define NUM_EVENTS_VEGA20_XGMI		2
 #define NUM_EVENTS_VEGA20_MAX		2
+#define NUM_EVENTS_ARCTURUS_XGMI	6
+#define NUM_EVENTS_ARCTURUS_MAX		6
 
 /* record to keep track of pmu entry per pmu type per device */
 struct amdgpu_pmu_entry {
@@ -95,6 +97,27 @@ const struct attribute_group *vega20_attr_groups[] = {
 	NULL
 };
 
+/* Arcturus events */
+static const char *arcturus_events[NUM_EVENTS_ARCTURUS_MAX][2] = {
+	{ "xgmi_link0_data_outbound", "event=0x7,instance=0x4b,umask=0x2" },
+	{ "xgmi_link1_data_outbound", "event=0x7,instance=0x4c,umask=0x2" },
+	{ "xgmi_link2_data_outbound", "event=0x7,instance=0x4d,umask=0x2" },
+	{ "xgmi_link3_data_outbound", "event=0x7,instance=0x4e,umask=0x2" },
+	{ "xgmi_link4_data_outbound", "event=0x7,instance=0x4f,umask=0x2" },
+	{ "xgmi_link5_data_outbound", "event=0x7,instance=0x50,umask=0x2" }
+};
+
+static struct attribute_group arcturus_event_attr_group = {
+	.name = "events",
+	.attrs = NULL
+};
+
+const struct attribute_group *arcturus_attr_groups[] = {
+	&amdgpu_pmu_format_attr_group,
+	&arcturus_event_attr_group,
+	NULL
+};
+
 /* All df_vega20_* items are DEPRECATED. Use vega20_ items above instead. */
 static const char *df_vega20_formats[NUM_FORMATS_DF_LEGACY][2] = {
 	{ "event", "config:0-7" },
@@ -380,6 +403,16 @@ static int init_pmu_by_type(struct amdgpu_device *adev,
 
 		pmu_entry->pmu.attr_groups = vega20_attr_groups;
 		break;
+	case CHIP_ARCTURUS:
+		amdgpu_pmu_create_attributes(evt_attr_group, evt_attr,
+				arcturus_events, 0, NUM_EVENTS_ARCTURUS_XGMI,
+				PERF_TYPE_AMDGPU_XGMI);
+		num_events += NUM_EVENTS_ARCTURUS_XGMI;
+
+		/* other events can be added here */
+
+		pmu_entry->pmu.attr_groups = arcturus_attr_groups;
+		break;
 	default:
 		return -ENODEV;
 	};
@@ -510,6 +543,28 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
 			goto err_pmu;
 		}
 
+		break;
+	case CHIP_ARCTURUS:
+		ret = amdgpu_pmu_alloc_pmu_attrs(&amdgpu_pmu_format_attr_group,
+						&fmt_attr,
+						NUM_FORMATS_AMDGPU_PMU,
+						&arcturus_event_attr_group,
+						&evt_attr,
+						NUM_EVENTS_ARCTURUS_MAX);
+
+		if (ret)
+			goto err_alloc;
+
+		ret = init_pmu_by_type(adev,
+				&amdgpu_pmu_format_attr_group, fmt_attr,
+				&arcturus_event_attr_group, evt_attr,
+				"Event", "amdgpu", PERF_TYPE_AMDGPU_MAX);
+
+		if (ret) {
+			kfree(arcturus_event_attr_group.attrs);
+			goto err_pmu;
+		}
+
 		break;
 	default:
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 569c40be6e75..23af431de997 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -512,6 +512,7 @@ static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
+	case CHIP_ARCTURUS:
 		if (is_add)
 			return df_v3_6_pmc_add_cntr(adev, config);
 
@@ -553,6 +554,7 @@ static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
+	case CHIP_ARCTURUS:
 		ret = df_v3_6_pmc_get_ctrl_settings(adev,
 			config,
 			counter_idx,
@@ -589,6 +591,7 @@ static void df_v3_6_pmc_get_count(struct amdgpu_device *adev,
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
+	case CHIP_ARCTURUS:
 		df_v3_6_pmc_get_read_settings(adev, config, counter_idx,
 						&lo_base_addr, &hi_base_addr);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
