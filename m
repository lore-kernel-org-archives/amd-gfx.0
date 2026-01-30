Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5D0D73EB5
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 02:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6E5810E351;
	Fri, 30 Jan 2026 02:30:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nt+ib93G";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010054.outbound.protection.outlook.com
 [40.93.198.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F94110E1FE
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 02:30:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHQqFnAi681Wf8T+PqxbfqfsTphDOsaXAAiSAwgrzteT+u6RUD8A0vJr6SKEjSZuKa4nz9+LL+aQ+iH4PcXPF826XzgNvLot9T96t1jnmTTrOM3hYJhbWqUKU3EOz9wPQ1T0NWK5iRZT4J54xzkzbm1xfBhcO2QEPBbyqOWgIkHPDS5HCQzkW2vrrgVmNGwoIaDOez0KAhmIxAdVr6zl6oYe+71UO2UDvt/NlWsf1VZkcQyoPhxhMEbTrg9yKD+KRAQsIkk+jsbsHnOnz04iAmT+Qa26ibRyVMrkeIJGxgkCai7eSc1wVRzLo5Z2+R6m/G5/joP4GFRu8/fGujId4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwNlToHhAPPjyt7+sQBIuoAka8HbwOLfw2fBWCFhIKY=;
 b=XENgbyRn3+9ISfZx38tvjasXGGcQwngAGxwuk4TyV3JSTt9CUpAVtzNKgibpWPKPR08ytui4fQW8DzodbQwlEpt0cvZct0T5u4Wb+HneosgU60FwcLR8UdKC90v76oBKj6xx8kUcSLyhrP/mKInMikiV2qFcAcgPBJugoKwoIm43MKLa9ZEYyfKP/8wHOiSH2vtSrGr9yiCshYESAsfI0kdz2ANljTCh/nv670J3vetBudGjXCw1J7Yh0yZUBGt5RtP/nnev3ciIG/RoXiy75ZDCT1YxpY3v9ZEP8m0DGYMSTY8AKvXS90Y2ZIVbzikU54vonGjO34T5BR6iTvF8nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwNlToHhAPPjyt7+sQBIuoAka8HbwOLfw2fBWCFhIKY=;
 b=nt+ib93GYIgehct2V4uPj3UGY3orY7nCoBJGF8Dq64A86leUB71mRmcw4FsbHz0WG5F/J0JpPVbdJypJgm9oqrPtkKXxs4XZ61KBkJnLRKVh+LCEpQQXdu+vJ4geD4o705rDurGJqIjf0JfcSxtRX0XMH7vYx3FV+Nw/UIpohVc=
Received: from SJ0PR05CA0031.namprd05.prod.outlook.com (2603:10b6:a03:33f::6)
 by PH7PR12MB8593.namprd12.prod.outlook.com (2603:10b6:510:1b1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 02:30:27 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::24) by SJ0PR05CA0031.outlook.office365.com
 (2603:10b6:a03:33f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Fri,
 30 Jan 2026 02:30:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 02:30:26 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 29 Jan 2026 20:30:25 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 05/14] drm/amd/ras: add wrapper funcs for pmfw eeprom
Date: Fri, 30 Jan 2026 10:29:41 +0800
Message-ID: <20260130022950.1160058-5-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130022950.1160058-1-ganglxie@amd.com>
References: <20260130022950.1160058-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|PH7PR12MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: ce42a3a4-3ed8-46f6-7436-08de5fa78781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4x3zRwzuBdiHiWOlXOqwlqAXukvXPsVV7hNTDdLR5jiTobDoidrH4EDV/Ief?=
 =?us-ascii?Q?+NeQwnDZ6dRQIfBAUBt3yp9gSM/z1WgiYGwmTCsEQJruu+AKPKIB9zI7hiWm?=
 =?us-ascii?Q?CX8/cup81+Cky0Ks26dLQRO5MqC4jJrfLynm/MFNvAse/iB/f0bIRI0qgqgr?=
 =?us-ascii?Q?fq1tN71VDR5zZY+5k/X4eDtqSsIZJXrR95OKK/cJY6aSzH0HuucnEXBgWklf?=
 =?us-ascii?Q?TC0CQf11gdN/Kq27Dzw9EWmYb9s3LPjtM601PygOnhIfcjeyg2AJzcK/RwFq?=
 =?us-ascii?Q?cqFwV4AZB2bTBaKykgIHgJB0nALTX5ZiCtBkUVYevChd2OGzPMmyZdscEMl3?=
 =?us-ascii?Q?btuLNQAf3WKVAnn+e3l/yoq/lhOLVBTpZEn21dWCxxat/o+jsO/fxdyKG3wo?=
 =?us-ascii?Q?/PbXmfuyW9Wse69b/R1tZxkt5PyI1XPUSXv24m6TKo17mfQhsTWb6us514F3?=
 =?us-ascii?Q?odkcjH6rWmfUEAwtoL3eVbHS8bjW0UhjzG0v1I+lTvEcr+nMgDknKRQEzyhJ?=
 =?us-ascii?Q?Ukk3W79uo4ZXsLgXy869iQ9apL/VadYDrgEZe0oXWo92GnG0up29EC8s9fOl?=
 =?us-ascii?Q?h6JIE9jPc9UfTr+LLCk1mJcyLovj5lS9mJTT+iOBhq2/kVslf6etQ/TJZH4n?=
 =?us-ascii?Q?+V1KCETwL0Yke9QkQopn7wfXtiVO20LB1GEVuM2FeDT1QLDME/IT3cr4LEBy?=
 =?us-ascii?Q?X7V0dhDncyhSJCikr/iQ9EjTS/IuIlcKzroEj2WP44YrSHPiF3PxmWvcREdg?=
 =?us-ascii?Q?gEUPkWi6xqwlM7Dtn0oBUnKf0LWVDu3rm9+NwXCznLsiAO2V2WkRB6GOnP6Y?=
 =?us-ascii?Q?88B8E7WWL9j8Z3CjCWYp/csWA2+PNxPiPQMJaXMuOY7cKTEcAUzUAHmQtIo0?=
 =?us-ascii?Q?8Qr7dPvG4diXXkNe+eo49pkbZ4TxrfWWRod061Q6SoCZXCyZYmB2IaJMWHht?=
 =?us-ascii?Q?hWSWoTkZB6NQZlkrnMFhJlWaNECboNpE1v9sHDNlobYR7LDuemLHtX7S0RiN?=
 =?us-ascii?Q?aH7cvfZsx3QhV5XBNByrdzPRuVRrBNGWLAmXWL8gFUedGzs5ehZp936EXKBK?=
 =?us-ascii?Q?YhmWt+IaYrSwQQtaj0y2tZ7awhalROmfhVdfotM0pVhFaizNVYjkPeGpmgxj?=
 =?us-ascii?Q?6y+7AeKwSMvxpJoSVdVLiHI+HLunbCCb/CZo7A5T/uU6jOLXkUSPAoFT8iSf?=
 =?us-ascii?Q?YFq4SFKQ2i9VMDEAs6NX3Gf0BiHDuFbWfs78YdjqiW5HReLRg9gBiA55QI4x?=
 =?us-ascii?Q?wAZ7V1xtiOZU66YLlDWVyupc+Of+xxolu0Pgh95spkrco9FgrI59mWyr03LD?=
 =?us-ascii?Q?tC7sWWOPvJsbKx4uAsZ7AXsT8dS0oH8xYdetSJPC/oSg7Wd8g7y+yhnkmYxb?=
 =?us-ascii?Q?x7aG1IMIAlCmpGUR5LpVuS2tszAGFr294s4Z3JNjS6RHl3lbpc7zuFClZCzY?=
 =?us-ascii?Q?SxSeQBmw+3C8aExeB49kR1EDzLwu89T6o7Mxgbg5GOOKrlS6K0MZXRn/XCqt?=
 =?us-ascii?Q?81Oa9oJDuqgouCid50iAKOhmt6Y6Km4DZbixBn8EW6J8n8Z5FKsETroX37u9?=
 =?us-ascii?Q?JflQFArdQXw+NFZNRCq+vXTBhipJ9+hfE6tHu/5P+qgO7dLtJaCXyu2sHw5Y?=
 =?us-ascii?Q?0jeWdxHr6zlsIuELPdXnCL/5dS9xCJdtHLSCB4671jk1/pQUspzyL2F/ankZ?=
 =?us-ascii?Q?YscQZQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JL9iS0ba+shk98PWnk3IVhpkwzoMtxWQsGIgYTyA0RYf+3IHlmW2vHde5T5Bou/pXUKKm+Az+dTf9DCcn8K4pXyAOzoC5SMod03JE/B60oklM5VGjmJ477v6On/B7V8E67338ctHJUCSX5fHJozFYW6xqaaIl6EcdN2qLyRjozu16sofJSsUgpyvgAmf/CgGa9IqkEYtHXnp0hYWTzk1TEFfBls04ZKLXHaRGDx+82AOPJEFb63NoXoWHnHZ5byyGPKIKxYCkJ2rdWQkq4r1jv3bgCjLBoOKm1rEj1IRR08d/CIo+RBmN+6CcXZiliMaNwr8m0qf6Iv7wi6zSnOLcORcaLwGo8vypVGfMExi9llSEFlI9RptmdOLo7NtMOa4Fa8fLbt9gh8z40OLO8YEcJSFF3EMOIJsX/lB+03GfqXylZF9LFzs8flusnqhci83
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 02:30:26.9983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce42a3a4-3ed8-46f6-7436-08de5fa78781
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8593
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

add wrapper funcs for pmfw eeprom interface to make them
easier to be called

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 125 ++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   |  16 +++
 2 files changed, 141 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
index e94c368c3159..f880fc49477d 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
@@ -36,3 +36,128 @@ void ras_fw_init_feature_flags(struct ras_core_context *ras_core)
 	if (!sys_func->mp1_get_ras_enabled_mask(ras_core, &flags))
 		ras_core->ras_fw_features = flags;
 }
+
+bool ras_fw_eeprom_supported(struct ras_core_context *ras_core)
+{
+	return !!(ras_core->ras_fw_features & RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM);
+}
+
+int ras_fw_get_table_version(struct ras_core_context *ras_core,
+				     uint32_t *table_version)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
+
+	return sys_func->mp1_send_eeprom_msg(ras_core,
+				RAS_SMU_GetRASTableVersion, 0, table_version);
+}
+
+int ras_fw_get_badpage_count(struct ras_core_context *ras_core,
+				     uint32_t *count, uint32_t timeout)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
+	uint64_t end, now;
+	int ret = 0;
+
+	now = (uint64_t)ktime_to_ms(ktime_get());
+	end = now + timeout;
+
+	do {
+		ret = sys_func->mp1_send_eeprom_msg(ras_core,
+			RAS_SMU_GetBadPageCount, 0, count);
+		/* eeprom is not ready */
+		if (ret != -EBUSY)
+			return ret;
+
+		mdelay(10);
+		now = (uint64_t)ktime_to_ms(ktime_get());
+	} while (now < end);
+
+	RAS_DEV_ERR(ras_core->dev,
+			"smu get bad page count timeout!\n");
+	return ret;
+}
+
+int ras_fw_get_badpage_mca_addr(struct ras_core_context *ras_core,
+					uint16_t index, uint64_t *mca_addr)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
+	uint32_t temp_arg, temp_addr_lo, temp_addr_high;
+	int ret;
+
+	temp_arg = index | (1 << 16);
+	ret = sys_func->mp1_send_eeprom_msg(ras_core,
+			RAS_SMU_GetBadPageMcaAddr, temp_arg, &temp_addr_lo);
+	if (ret)
+		return ret;
+
+	temp_arg = index | (2 << 16);
+	ret = sys_func->mp1_send_eeprom_msg(ras_core,
+			RAS_SMU_GetBadPageMcaAddr, temp_arg, &temp_addr_high);
+
+	if (!ret)
+		*mca_addr = (uint64_t)temp_addr_high << 32 | temp_addr_lo;
+
+	return ret;
+}
+
+int ras_fw_set_timestamp(struct ras_core_context *ras_core,
+				 uint64_t timestamp)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
+
+	return sys_func->mp1_send_eeprom_msg(ras_core,
+			RAS_SMU_SetTimestamp, (uint32_t)timestamp, 0);
+}
+
+int ras_fw_get_timestamp(struct ras_core_context *ras_core,
+				 uint16_t index, uint64_t *timestamp)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
+	uint32_t temp = 0;
+	int ret;
+
+	ret = sys_func->mp1_send_eeprom_msg(ras_core,
+			RAS_SMU_GetTimestamp, index, &temp);
+	if (!ret)
+		*timestamp = temp;
+
+	return ret;
+}
+
+int ras_fw_get_badpage_ipid(struct ras_core_context *ras_core,
+				    uint16_t index, uint64_t *ipid)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
+	uint32_t temp_arg, temp_ipid_lo, temp_ipid_high;
+	int ret;
+
+	temp_arg = index | (1 << 16);
+	ret = sys_func->mp1_send_eeprom_msg(ras_core,
+			RAS_SMU_GetBadPageIpid, temp_arg, &temp_ipid_lo);
+	if (ret)
+		return ret;
+
+	temp_arg = index | (2 << 16);
+	ret = sys_func->mp1_send_eeprom_msg(ras_core,
+			RAS_SMU_GetBadPageIpid, temp_arg, &temp_ipid_high);
+	if (!ret)
+		*ipid = (uint64_t)temp_ipid_high << 32 | temp_ipid_lo;
+
+	return ret;
+}
+
+int ras_fw_erase_ras_table(struct ras_core_context *ras_core,
+				   uint32_t *result)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
+
+	return sys_func->mp1_send_eeprom_msg(ras_core,
+			RAS_SMU_EraseRasTable, 0, result);
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
index b41665467368..46f45e82a3f3 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
@@ -24,6 +24,22 @@
 #ifndef __RAS_EEPROM_FW_H__
 #define __RAS_EEPROM_FW_H__
 
+
 void ras_fw_init_feature_flags(struct ras_core_context *ras_core);
+bool ras_fw_eeprom_supported(struct ras_core_context *ras_core);
+int ras_fw_get_table_version(struct ras_core_context *ras_core,
+				     uint32_t *table_version);
+int ras_fw_get_badpage_count(struct ras_core_context *ras_core,
+				     uint32_t *count, uint32_t timeout);
+int ras_fw_get_badpage_mca_addr(struct ras_core_context *ras_core,
+					uint16_t index, uint64_t *mca_addr);
+int ras_fw_set_timestamp(struct ras_core_context *ras_core,
+				 uint64_t timestamp);
+int ras_fw_get_timestamp(struct ras_core_context *ras_core,
+				 uint16_t index, uint64_t *timestamp);
+int ras_fw_get_badpage_ipid(struct ras_core_context *ras_core,
+				    uint16_t index, uint64_t *ipid);
+int ras_fw_erase_ras_table(struct ras_core_context *ras_core,
+				   uint32_t *result);
 
 #endif
-- 
2.34.1

