Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4281C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 01:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 755FD61624
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 01:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755FD61624
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFA766E037;
	Wed, 12 May 2021 01:31:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0462D6E037
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 01:31:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QU1WG8Xfpxl/qVdOdUU+XjOWgPTGmWik1HehqvDETQ+U2ccev/8FzX7OkCzQlEBj6Mo317mrYAXVdemHE6mHpl3vIaQpUuKVVGY6en287djdkTfbCjye/7CWlCHo35sleLxIX9J1bB+TeDQlQThf29mcMH1NN0kYn36Vv9DoMRGLEUPEwFNk0mSCQyRH5HY9gTRm/Hgmj9SoS6U9JJ3w4JLeHVp+KmjLK5LrdMFy7X5BF+MNcddlCBHtF+NStniROOyoXgO7iv10tm9RLtNfjVS3DhvVzEZJRa35Yam56f3iUbAqTsvjqLZvdbEvnDyZpbh0GCl+4QeTRVq4D5d4nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJwIrVaHasMMIyR6QgHfWVDQUAAWYW/hUVUbi0aPrfg=;
 b=QDwLDhl2yBF7xv2swkM56coOTTA47fNkCTuarJXFzZR+s7PQYq+wPuFwTiTtJ8yBG7YK03+rjlBpNl+G+T2S5FyYKgN7IaLKCZd+LUdbbLm7zql/4J42qLIihtKVFclWvJOQFJNo6JyxKZIbQByD9LJZa9PUOlPTwHVwrqKwIZD7OuIV+35V1L4U99QDcWRxsqpMa6zE5yqrV9YMAWTo9ZFW0lM35adh5BGtwv724S9wd+RGXvFIUgU35KwDxZjuFH48NU3rwblVzhcutSwIGAErr82bOIlx9r7h4/ZqLS19qGHD/ShWf34cO1F5sf5cCyQxj0hr0LoyPaiu9Pk9XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJwIrVaHasMMIyR6QgHfWVDQUAAWYW/hUVUbi0aPrfg=;
 b=WcCF63cf12azXnyZ7+3DGrgahRrDGlN9/Lwg6z+gIS5NgfxaRzib8BKjACr7G9r4P9UPk+Z/BHAT0Hb5VPohv2RfTcsIpgtsVVyfGRqrMTKSGdq/xnXdUw7vpxQt+f8FToQZzSHLam3B4jvDhuUzqFRi+lcnqoM5wmsKxDybTPI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23)
 by DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 01:31:49 +0000
Received: from DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::8ce9:f643:9ce6:af9c]) by DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::8ce9:f643:9ce6:af9c%6]) with mapi id 15.20.4108.031; Wed, 12 May 2021
 01:31:49 +0000
From: Mukul Joshi <mukul.joshi@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Date: Tue, 11 May 2021 21:30:58 -0400
Message-Id: <20210512013058.6827-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::24) To DM4PR12MB5263.namprd12.prod.outlook.com
 (2603:10b6:5:39b::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mukjoshi-dev.amd.com (165.204.55.251) by
 YT1PR01CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Wed, 12 May 2021 01:31:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 425b4d9d-762a-4d38-224e-08d914e5b677
X-MS-TrafficTypeDiagnostic: DM8PR12MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB54782E88C0607DBA5FB3C3E4EE529@DM8PR12MB5478.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:397;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YD0oc8TACBzQIEpTEs92g1BxzREIaEJWB8cKBPfSM7M70lYBKgj851JeSU0bscWxj6wQzRkcH/HNsdxUwfV/SsQlAeCJQz2zlCsuZgB7pIxXLWh/6uT3RGh/NNFsAq7WZ7GwRr87+5Kos/nsATGhKerAj0JlvFT1qlECtXSAwVnPQwuaAuDj8LhEpDoFeYfqYQo4OdC9XMpcu1+s7CorrKhqB1DhvnagoL24EZsOIYKSAQ7lfhFLv/N5IuaRjnEVntYut+IohYCCfdMFR+QOshQZjMo3X6ByS3osvjOT1Q9yc0zwlj8kk7JlkyxAn8ldg69jAgdy0g8oIi7M+TEeVWwiEKi6IiIypAEauIFraJwvxZ9KulhfJvoPptXxiamCWKnJSAw0BHvA1Wy34msCumTSbfLP6r8phGoBARa6rJgBCZDLdQsmagDLQZ48zF2SsdHyFuXhxfSKDBxP2+OJAJ+qwCkBB/I9r0rptOcrK6f9EZMoY6Kr/X2vV6JmLbp1LcFg+lC+aLhTyiPBCnIlqbWVwr3bOubKJR8N+eVIzgwvwmcTIPsi4FZwbTt8baCtGs5dduwueUZc+R42zmpMA4SL2syfqr3vxiQ10uoLr/2JxRl8o9A4Cak4Hfm44T17at12rApLRkb2sxVxlt1fTrdHLg4LOY8eemvuFLQbwfA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5263.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(7696005)(66946007)(66556008)(66476007)(16526019)(186003)(2906002)(316002)(83380400001)(52116002)(44832011)(478600001)(1076003)(8676002)(4326008)(5660300002)(6666004)(38350700002)(38100700002)(6916009)(6486002)(26005)(956004)(86362001)(2616005)(8936002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BZmd+Sgx8CyoTbmlOmHV+QMx++nGJ+4bt04FgDdn2KrAbPCnuncEogBtLm6m?=
 =?us-ascii?Q?+KZEXk6wDT6kPyGF5P+GUyzuQ4vLCEWiX7Wx4J3urkMOPzxuc/1qYS8VPfJs?=
 =?us-ascii?Q?xhfOX+oB1A/37Xq1qKvXwZB6ochubvF17aP6Jxl2C1FxgOCFsrsL159/9/e7?=
 =?us-ascii?Q?8wwDQt3+9a1WTwCg8yynIwnOLkhqGnsqd/tcdi+S/SMSZzzK6KSWbpX0UAim?=
 =?us-ascii?Q?zAopIYmaJxjOQ5sPAkdC7R9H7eFAaAEIN/dZdKOTQmyDcBleHxswZ33q3k97?=
 =?us-ascii?Q?JZq7ij0hGRy47y/wCRDSePON0LvMUk8xT17ofqDiBAYBxkiPneOrpreCyMSN?=
 =?us-ascii?Q?UFQnNHyA9sNa7djoKxh5hxe02bSpH5LwI7LU8cNRFWWjioYQ99jvB9gJZjAO?=
 =?us-ascii?Q?vElK6ymZ8Xvw9+B/N6NLGqaxAl2A8/PnIiImg90KdWWTUcMmESj0zTDvPd8T?=
 =?us-ascii?Q?xMr3JxoNkIVk8VuOvE/SkyikvjZZZ4Phmtcox3nMcLotb8FAb90N5sKrjr4T?=
 =?us-ascii?Q?koFPNv9FXicnh773+RIQrbdssKIkzZzdVd6obpZiQ3UlTcL4mWU80tyNkRBB?=
 =?us-ascii?Q?GondEW3zNVrhERk0BwgqALET+56hCYMo5qOKz57wNVfSAe+OeYz7rEJcTWay?=
 =?us-ascii?Q?Sh4QXIj80Lc1uZzRLraouwzKrbHXI2JdGQE4nGA5TMbIa/nRVW7ps7L1RKGp?=
 =?us-ascii?Q?cEmeaKC+4pjwaQaVnHq8wDRSngW6fKepIwRrACDmbhCnsAGwB4qJBkjvJOJg?=
 =?us-ascii?Q?oNKdwh/0OgDrqvqZt3+wc4TVg+hZxh/THeeTG6MeszA+dzrUG7YVzHPjpgAk?=
 =?us-ascii?Q?AwA57+2/Z/qXVIRCRR4SyP/EcYxc9RCTcj2tmod66ZslpuMONFk2nDA6QxTg?=
 =?us-ascii?Q?pybSLkEBZGazPgUGTGidc4iPqni/vSWWCX+9miz80QlfSS1I2TuIEKR4Rm49?=
 =?us-ascii?Q?+1d0hGmpNwLfclwLgrSchvxuChEpbZKqFyya74rZ6CBQxY4HwICsu/xMI90Y?=
 =?us-ascii?Q?kf76Sta+LmNFUyHO1EJ+rmz2fE63Udfghyid/l84DDthz5UX1rnP6pdXsRdP?=
 =?us-ascii?Q?mPPG0TJt3f63pr3qBqNjWjJDpbJx20V/Flz6nGhyQ/YDH9RZBRvUZoi5xVmZ?=
 =?us-ascii?Q?4aL5QNME0ezPSQIC+A531NJDFZ7jwk2h9MPgxkHR8Wa3dJBfn0bl8R//FHFs?=
 =?us-ascii?Q?doVrKKuh4mWvnO6ciF3Pw7Mz+G8hupSc+94VuCs6jmcAcT8CHUBEP3fBBoNr?=
 =?us-ascii?Q?8eBDNOswqCeK6VIa1ZwpBP42iiZYoSLjtv2fp/Up3nZ6LcsAukrrsDS8p9hF?=
 =?us-ascii?Q?GkNST78FmT8JRPsa5B1ueUlR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425b4d9d-762a-4d38-224e-08d914e5b677
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 01:31:49.3043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVAp6nJ5/3soJ5I3qR4heTKYQCiww29ErZzrgyJFW1B/e+wc6VzMdsuIA7kpMgrTq2s0kOdHk1evkn+RcJ5sbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5478
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, harish.kasiviswanathan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Aldebaran, GPU driver will handle bad page retirement
even though UMC is host managed. As a result, register a
bad page retirement handler on the mce notifier chain to
retire bad pages on Aldebaran.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: John Clements <John.Clements@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 154 ++++++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b1c57a5b6e89..02263f509b36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -34,7 +34,9 @@
 #include "amdgpu_xgmi.h"
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include "atom.h"
+#include <asm/mce.h>
 
+static bool notifier_registered;
 static const char *RAS_FS_NAME = "ras";
 
 const char *ras_error_string[] = {
@@ -73,6 +75,11 @@ const char *ras_block_string[] = {
 /* typical ECC bad page rate(1 bad page per 100MB VRAM) */
 #define RAS_BAD_PAGE_RATE		(100 * 1024 * 1024ULL)
 
+#define GET_MCA_IPID_GPUID(m)		(((m) >> 44) & 0xF)
+#define GET_UMC_INST_NIBBLE(m)		(((m) >> 20) & 0xF)
+#define GET_CHAN_INDEX_NIBBLE(m)	(((m) >> 12) & 0xF)
+#define GPU_ID_OFFSET			8
+
 enum amdgpu_ras_retire_page_reservation {
 	AMDGPU_RAS_RETIRE_PAGE_RESERVED,
 	AMDGPU_RAS_RETIRE_PAGE_PENDING,
@@ -85,6 +92,7 @@ static bool amdgpu_ras_check_bad_page_unlock(struct amdgpu_ras *con,
 				uint64_t addr);
 static bool amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
 				uint64_t addr);
+static void amdgpu_register_bad_pages_mca_notifier(void);
 
 void amdgpu_ras_set_error_query_ready(struct amdgpu_device *adev, bool ready)
 {
@@ -1978,6 +1986,10 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 			goto free;
 	}
 
+	if ((adev->asic_type == CHIP_ALDEBARAN) &&
+	    (adev->gmc.xgmi.connected_to_cpu))
+		amdgpu_register_bad_pages_mca_notifier();
+
 	return 0;
 
 free:
@@ -2427,3 +2439,145 @@ void amdgpu_release_ras_context(struct amdgpu_device *adev)
 		kfree(con);
 	}
 }
+
+static struct amdgpu_device *find_adev(uint32_t node_id)
+{
+	struct amdgpu_gpu_instance *gpu_instance;
+	int i;
+	struct amdgpu_device *adev = NULL;
+
+	mutex_lock(&mgpu_info.mutex);
+
+	for (i = 0; i < mgpu_info.num_gpu; i++) {
+		gpu_instance = &(mgpu_info.gpu_ins[i]);
+		adev = gpu_instance->adev;
+
+		if (adev->gmc.xgmi.connected_to_cpu &&
+		    adev->gmc.xgmi.physical_node_id == node_id)
+			break;
+		adev = NULL;
+	}
+
+	mutex_unlock(&mgpu_info.mutex);
+
+	return adev;
+}
+
+static void find_umc_inst_chan_index(struct mce *m, uint32_t *umc_inst,
+				     uint32_t *chan_index)
+{
+	uint32_t val1 = 0;
+	uint32_t val2 = 0;
+	uint32_t rem = 0;
+
+	/*
+	 * Bit 20-23 provides the UMC instance nibble.
+	 * Bit 12-15 provides the channel index nibble.
+	 */
+	val1 = GET_UMC_INST_NIBBLE(m->ipid);
+	val2 = GET_CHAN_INDEX_NIBBLE(m->ipid);
+
+	*umc_inst = val1/2;
+	rem = val1%2;
+
+	*chan_index = (4*rem) + val2;
+}
+
+static int amdgpu_bad_page_notifier(struct notifier_block *nb,
+				    unsigned long val, void *data)
+{
+	struct mce *m = (struct mce *)data;
+	struct amdgpu_device *adev = NULL;
+	uint32_t gpu_id = 0;
+	uint32_t umc_inst = 0;
+	uint32_t chan_index = 0;
+	struct ras_err_data err_data = {0, 0, 0, NULL};
+	struct eeprom_table_record err_rec;
+	uint64_t retired_page;
+
+	/*
+	 * If the error was generated in UMC_V2, which belongs to GPU UMCs,
+	 * and error occurred in DramECC (Extended error code = 0) then only
+	 * process the error, else bail out.
+	 */
+	if (!m || !(is_smca_umc_v2(m->bank) && (XEC(m->status, 0x1f) == 0x0)))
+		return NOTIFY_DONE;
+
+	gpu_id = GET_MCA_IPID_GPUID(m->ipid);
+
+	/*
+	 * GPU Id is offset by GPU_ID_OFFSET in MCA_IPID_UMC register.
+	 */
+	gpu_id -= GPU_ID_OFFSET;
+
+	adev = find_adev(gpu_id);
+	if (!adev) {
+		dev_warn(adev->dev, "%s: Unable to find adev for gpu_id: %d\n",
+				     __func__, gpu_id);
+		return NOTIFY_DONE;
+	}
+
+	/*
+	 * If it is correctable error, then print a message and return.
+	 */
+	if (mce_is_correctable(m)) {
+		dev_info(adev->dev, "%s: UMC Correctable error detected.",
+				    __func__);
+		return NOTIFY_OK;
+	}
+
+	/*
+	 * If it is uncorrectable error, then find out UMC instance and
+	 * channel index.
+	 */
+	find_umc_inst_chan_index(m, &umc_inst, &chan_index);
+
+	dev_info(adev->dev, "Uncorrectable error detected in UMC inst: %d,"
+			    " chan_idx: %d", umc_inst, chan_index);
+
+	memset(&err_rec, 0x0, sizeof(struct eeprom_table_record));
+
+	/*
+	 * Translate UMC channel address to Physical address
+	 */
+	retired_page = ADDR_OF_8KB_BLOCK(m->addr) |
+			ADDR_OF_256B_BLOCK(chan_index) |
+			OFFSET_IN_256B_BLOCK(m->addr);
+
+	err_rec.address = m->addr;
+	err_rec.retired_page = retired_page >> AMDGPU_GPU_PAGE_SHIFT;
+	err_rec.ts = (uint64_t)ktime_get_real_seconds();
+	err_rec.err_type = AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE;
+	err_rec.cu = 0;
+	err_rec.mem_channel = chan_index;
+	err_rec.mcumc_id = umc_inst;
+
+	err_data.err_addr = &err_rec;
+	err_data.err_addr_cnt = 1;
+
+	if (amdgpu_bad_page_threshold != 0) {
+		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
+						err_data.err_addr_cnt);
+		amdgpu_ras_save_bad_pages(adev);
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block amdgpu_bad_page_nb = {
+	.notifier_call  = amdgpu_bad_page_notifier,
+	.priority       = MCE_PRIO_ACCEL,
+};
+
+static void amdgpu_register_bad_pages_mca_notifier(void)
+{
+	/*
+	 * Register the x86 notifier with MCE subsystem.
+	 * Please note a notifier can be registered only once
+	 * with the MCE subsystem.
+	 */
+	if (notifier_registered == false) {
+		mce_register_decode_chain(&amdgpu_bad_page_nb);
+		notifier_registered = true;
+	}
+}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
