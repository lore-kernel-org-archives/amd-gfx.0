Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC64C4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 19:24:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37FC16134F
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 19:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37FC16134F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB8766E3E3;
	Mon, 21 Jun 2021 19:24:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC26A6E3E3
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 19:24:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fv5j1VOMWAXtPkJkW84YVSQpo47f4JahpcIm/rf/xxqFvSQAkk8iKmLYu5LIZlEaC69lapffxbjg8LWXeooQWKLIYUTQjqLGqh/waWXE8+2fpuvziOn6/CWy+FcIAsj1EIagU3odwT8ODVBhuKI97aZAmZ61K+YU2Dpk1Sx+Ri8TfhN9urs31EwqEbnW7oe5JSVmOKSyZU7eh6/1nsQsePsl7ZN7WRO6vxVnc45KLJGpM/rK2UwPTRGfTTx2YqiDgYl/Jy/FcHThBIJ73TXqcSWqWd0Ooq1KDs9yJVOS6b2twRVJVup9lrw9qrSlBMa+I/cJ7mekPerS7tf7kHIP2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diCfPZZ8e3qdJbTrybF9DcgsK6fOHzWY8/6v0Opk9tc=;
 b=VYkGMgrAGZ6GPNF1FU0iSEVo+JgjzIwECkQ9kAUBOAxmLTT9MZj/Ne4MXkFHKbkRIVdLFD+EYxEF4hK75sTqkYSvpvqLfPNKfCiX12kpKK5C9lz1UUlJIZQsn55U+85ZrfEAooRO5Wn5vUnMKKbmbpXh8O4y8/ofooSW6Fyj4xKiz/3FGdbly3wJvHCrn0V/oApbrYUlwFeMDEQPi7eV9PgD7UpnOUqPJr/occfbRMJzbB7EGfxVKju7necQ+XeejR39w/aGutkDfIBoyC5GCQu0rucGGBOsMEvQSCkvt3sYm+GV8AIBMScEM0zH4hoiJk4eEHwUCClrrFGaU9VDFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diCfPZZ8e3qdJbTrybF9DcgsK6fOHzWY8/6v0Opk9tc=;
 b=i81setzJUZPpQFFfuJ0DQk5HXLH0yy8h6eg2n8E8cWgUmn91gGJLDK7o9JGPqEk5iblVLbUveeJmExYMwe7rJWbniRgxYvRw2Crh9gd7BA2avOot7X4AmQIUpyF6h6rtGKIVtdKNHX+rKLxNNA69w3TI/AgoHfumnkVan3TeFes=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) by
 DM5PR12MB2470.namprd12.prod.outlook.com (2603:10b6:4:b4::39) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.24; Mon, 21 Jun 2021 19:24:03 +0000
Received: from DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::1d06:dcde:55f9:3eb7]) by DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::1d06:dcde:55f9:3eb7%7]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 19:24:03 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdkfd: report num xgmi links between direct peers to
 the kfd
Date: Mon, 21 Jun 2021 15:23:46 -0400
Message-Id: <20210621192348.2775943-2-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210621192348.2775943-1-jonathan.kim@amd.com>
References: <20210621192348.2775943-1-jonathan.kim@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::16) To DM5PR12MB4680.namprd12.prod.outlook.com
 (2603:10b6:4:a6::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YTOPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Mon, 21 Jun 2021 19:24:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac57fc17-33d4-4cc0-c6df-08d934ea20d6
X-MS-TrafficTypeDiagnostic: DM5PR12MB2470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2470C1FE2F39491B250EC988850A9@DM5PR12MB2470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oOEC+ma831465MoIlwMHIZ4kE62B01FeAkRtdisWovxCKGJCjhkM7aTS8XzxLWDUDmSj4vpcR5LGftfGUbAMH8yHGF0h8M3LjsAaPwrRpLXGaMzAo8ZCv+lcwPvFHgpeGxvKRmahPjsSQtb3m6l2jX8GLnN9a/ftdzO14FPsAhIezBuTda68c/x7RaUbnOubB6ov3KN9/MsAuI6FQu+Fms9ddR2EEp0B3UfNlg7binA5Qd0sJOGrZeFP2g31PJsxNLzBxOkPv8AEGnieZoaPtAoL8aiVjcd2zsr2Pf9G/1rw/gYoprzfO/nOpY1peM5rT3AVRudJ0NcdHh7wGHABES0yuo6SfgJAquiGFNolzUOqqxIPY3nO9iX/m+nnWaOwvN84jPsbq4lMxA76r4QH2XmxsFksw9lo07NnvHbOkJFXDyjt3nCIjxSJIWOFjByCYUXwITH7uJCY447iAi4gcXhcnMEAJSizXYBHy1amo913hpCW4AL5+0+vD+NAIXvqxt9ZZYt/b6EN9uQqEYTvtohmzWfogPdrOzDMARVP4zQcqa9Up44AtxQXC1Im+skAwDP5Zy1nJhk8S3Uv2OVPibeGAWWiqZaI54eHxybHxSNUdH2RfXpewMnNHW61sgrTlTrUkYwecnIL8F3DTcnRb2z0kKV2JPaG2FDheuudDSM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(8676002)(66946007)(5660300002)(6666004)(2616005)(6486002)(8936002)(1076003)(7696005)(2906002)(86362001)(83380400001)(26005)(52116002)(16526019)(316002)(38350700002)(6916009)(956004)(36756003)(478600001)(186003)(38100700002)(44832011)(66476007)(4326008)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YB++kiGTdWUXfFALlEj0M6fgVPtaICOpePh2/uRHeyIHperytbz8XHdm4wOb?=
 =?us-ascii?Q?glf7OtNl0G2Ji15/Ewa80ilMXoOvT4so8dEQ+aEFEzL++r/fkxaQv8E8lYkS?=
 =?us-ascii?Q?1/b8h6PrJAj+yNOjkG+zEfpYyXPdXlR3iSUAQt0ukSWA3Cl6egPVAeLrcKSJ?=
 =?us-ascii?Q?TDYeORQZgFRTNietlG+GskBhQdoHrhTxJa9u6xJrAloOqjzo91rsdh8SFCTP?=
 =?us-ascii?Q?zUzGPTntehp+hhy6OCBFToogonvVLuEtibzbgshJFt0GNQWrNBLgZEJQk9oV?=
 =?us-ascii?Q?Axk5J1ZZculAaluC920ZQTsvsebyi70vL6Gn3eamdJ5WKjoRtUK8UYgHzDwq?=
 =?us-ascii?Q?Sk+hgbc7bgq7tOvP8VTyt7dfFjvVYoFwtOPiqk3yiCz74cjtPvwAdK75zs9u?=
 =?us-ascii?Q?myNvBqqo8Fu4R7ia/znKCMbI8azDNFbjPRyZeexqhemhoC2dacdlz/Fl3PkD?=
 =?us-ascii?Q?uZOXzDD746KzGjHT89VdBwBsK7mvx9yZrhc4YlSfx1g3a35xhaQVsmBAagoL?=
 =?us-ascii?Q?CA29ILG6jpY0lHEDY3prUf/vcMmnWR0+NpaIKlK2eIchQL63aYdIiVRFjs0r?=
 =?us-ascii?Q?w8+bUFpI6GNmgpCr/68y4kdv3VPymT+NdqFAoNmGFLP8k5TTnU50Mqdi5QyZ?=
 =?us-ascii?Q?WdHavSMsb4rdEPkuzWzva8TKGbiF2IBxT7gPh8itchb0JNMEp3511xplDuzr?=
 =?us-ascii?Q?zn3s+tp3d3odvsoVbzjYPBWTXoS/jzx+2LVw7vAuQqDWq/gyUmAyMHQ1uny4?=
 =?us-ascii?Q?Sl+MGFc77RAdTkRptkJelao6lhsoTHx/khdK+8Rt0lDyHhQ4ogvLgNBLs6MF?=
 =?us-ascii?Q?e/lcGshYB7BV/1iCdb8SEFjb8NugEK+ZAf2OyHL2Zsh+M7HTGvhz98uRpEEa?=
 =?us-ascii?Q?jn0ozWsgx8yHru3gs3vOrN2+wmd9rVU0U3OW4aol/B5z+PwhOwXKqyZCUbHD?=
 =?us-ascii?Q?BlnMhUYQsg66cjeHeaAVtyF/OpVx0p2cWTn5reAnPkqZFprP3Et03Ya3wpyY?=
 =?us-ascii?Q?iqxhO2L9HhMzk7CkZmc32LIf4qDCteHcUbeuQI7zmoMOyDWlqMVsE11Pqo8x?=
 =?us-ascii?Q?ftr4rSQ2Wae7He5GIT3ScDQdM5Dltg2ph0SRptV0H59V2RlveyBH5V3L5k/y?=
 =?us-ascii?Q?4BwZ3eDbqD0jUL6XB00UmDbsDR1/dfw+QVQwauc6P2fTmfq7n3bZ4+t9QcHB?=
 =?us-ascii?Q?58j4tU6823qtV6KiDVoUt17C8/qvY6PbleJeFE2MDjjoiZXgTlE7+fDPkvq0?=
 =?us-ascii?Q?m+KiD4kVRoE1AehSgBnR1BRsKH/NzF4/DkhCXSM7OowBSYsWdDGG+x881C1F?=
 =?us-ascii?Q?n4pa+QqnNNXbfYv7jAgAF6+N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac57fc17-33d4-4cc0-c6df-08d934ea20d6
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 19:24:02.8943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ut+lbXl824iINWCpHv4WPsQQU5MkPnK9T9GYVlRzmmXqAQDOeK5x5UCg/DgNmI9l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2470
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>,
 Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since Min/Max bandwidth was never used, it will repurposed to report the
number of xgmi links between direct peers to the KFD topology.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c      | 11 +++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h      |  4 ++--
 6 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index bfab2f9fdd17..c84989eda8eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -553,6 +553,21 @@ uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct kgd_dev *s
 	return  (uint8_t)ret;
 }
 
+uint8_t amdgpu_amdkfd_get_xgmi_num_links(struct kgd_dev *dst, struct kgd_dev *src)
+{
+	struct amdgpu_device *peer_adev = (struct amdgpu_device *)src;
+	struct amdgpu_device *adev = (struct amdgpu_device *)dst;
+	int ret = amdgpu_xgmi_get_num_links(adev, peer_adev);
+
+	if (ret < 0) {
+		DRM_ERROR("amdgpu: failed to get xgmi num links between node %d and %d. ret = %d\n",
+			adev->gmc.xgmi.physical_node_id,
+			peer_adev->gmc.xgmi.physical_node_id, ret);
+		ret = 0;
+	}
+	return  (uint8_t)ret;
+}
+
 uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct kgd_dev *kgd)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index fabc68eec36a..20e4bfce62be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -226,6 +226,7 @@ uint32_t amdgpu_amdkfd_get_num_gws(struct kgd_dev *kgd);
 uint32_t amdgpu_amdkfd_get_asic_rev_id(struct kgd_dev *kgd);
 int amdgpu_amdkfd_get_noretry(struct kgd_dev *kgd);
 uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct kgd_dev *src);
+uint8_t amdgpu_amdkfd_get_xgmi_num_links(struct kgd_dev *dst, struct kgd_dev *src);
 
 /* Read user wptr from a specified user address space with page fault
  * disabled. The memory must be pinned and mapped to the hardware when
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 8567d5d77346..258cf86b32f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -486,6 +486,18 @@ int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
 	return	-EINVAL;
 }
 
+int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
+		struct amdgpu_device *peer_adev)
+{
+	struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
+	int i;
+
+	for (i = 0 ; i < top->num_nodes; ++i)
+		if (top->nodes[i].node_id == peer_adev->gmc.xgmi.node_id)
+			return top->nodes[i].num_links;
+	return	-EINVAL;
+}
+
 int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 {
 	struct psp_xgmi_topology_info *top_info;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 12969c0830d5..d2189bf7d428 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -59,6 +59,8 @@ int amdgpu_xgmi_remove_device(struct amdgpu_device *adev);
 int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate);
 int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
 		struct amdgpu_device *peer_adev);
+int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
+		struct amdgpu_device *peer_adev);
 uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
 					   uint64_t addr);
 static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index c6b02aee4993..75047b77649b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1034,8 +1034,8 @@ static int kfd_parse_subtype_iolink(struct crat_subtype_iolink *iolink,
 
 			props->min_latency = iolink->minimum_latency;
 			props->max_latency = iolink->maximum_latency;
-			props->min_bandwidth = iolink->minimum_bandwidth_mbs;
-			props->max_bandwidth = iolink->maximum_bandwidth_mbs;
+			props->min_bandwidth = iolink->minimum_bandwidth;
+			props->max_bandwidth = iolink->maximum_bandwidth;
 			props->rec_transfer_size =
 					iolink->recommended_transfer_size;
 
@@ -1989,6 +1989,8 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
 		sub_type_hdr->flags |= CRAT_IOLINK_FLAGS_BI_DIRECTIONAL;
 		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_XGMI;
 		sub_type_hdr->num_hops_xgmi = 1;
+		sub_type_hdr->minimum_bandwidth = 1;
+		sub_type_hdr->maximum_bandwidth = 1;
 	} else {
 		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_PCIEXPRESS;
 	}
@@ -2033,6 +2035,11 @@ static int kfd_fill_gpu_xgmi_link_to_gpu(int *avail_size,
 	sub_type_hdr->proximity_domain_to = proximity_domain_to;
 	sub_type_hdr->num_hops_xgmi =
 		amdgpu_amdkfd_get_xgmi_hops_count(kdev->kgd, peer_kdev->kgd);
+	sub_type_hdr->maximum_bandwidth =
+		amdgpu_amdkfd_get_xgmi_num_links(kdev->kgd, peer_kdev->kgd);
+	sub_type_hdr->minimum_bandwidth =
+		sub_type_hdr->maximum_bandwidth ? 1 : 0;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
index d54ceebd346b..d1f6de5edfb9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
@@ -271,8 +271,8 @@ struct crat_subtype_iolink {
 	uint16_t	version_minor;
 	uint32_t	minimum_latency;
 	uint32_t	maximum_latency;
-	uint32_t	minimum_bandwidth_mbs;
-	uint32_t	maximum_bandwidth_mbs;
+	uint32_t	minimum_bandwidth;
+	uint32_t	maximum_bandwidth;
 	uint32_t	recommended_transfer_size;
 	uint8_t		reserved2[CRAT_IOLINK_RESERVED_LENGTH - 1];
 	uint8_t		num_hops_xgmi;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
