Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8774AE83040
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 04:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 207C210E4E6;
	Tue,  3 Feb 2026 04:12:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ODVJVj4y";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012062.outbound.protection.outlook.com [40.107.209.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1875210E4E6
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 04:12:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEvfohQaG/F5e1tp5cGMbmcnQ9JYb3Xkb+7AUMMPp2SSJw7movn0X4neMg8cqXfw7cKXukMw3K3dVJUVZGGZerMrG6INk5uPQeL4I+OiIQnSVPT0sjBAMsd8qmc66euy4A5z5p/3agFpe5KqLi7lNLFbMgaT1WVj1I9D4HEoaEoVizL4GBtCUd1hQ/J9sMif7O+gHIpsJEBWS09wEma8k6uMf3ptM4cmXUMPverMVsqM+0oj+qugra15CpOHGXdN6Fx3bYtwY8DnHf2CCK2we3bb6arvtmCAn73AWX4IQh21goL6xWAJLoLyX9wAjm+vt3iQiobTZvGXQXmI/uZZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwNlToHhAPPjyt7+sQBIuoAka8HbwOLfw2fBWCFhIKY=;
 b=r9zTx4s7nSdiLl2Zi3xnNVUCrSj2buv1jfF0orPZvoa22Bt+Pw8+RUeTbdJ2Z7J6GKMGNgQ4XOQSoA36KiXJxQhCqPqGjC9uuIdFdkvHbB+iv6Q/H+gYHZdcm2R7RNIuKAiLXLEvVjl1bpL0XC4nNXHldntrMeyIvz0vO09EslB4lpEyL0cwzHqZ7TMRJsiV6RAJ7UQh3iR3YV8XBxjwFXe00Pn0B7OLVS76pJZe/dz15nEyIuD6GeYYeRnt2Y4cZOrfDxWpHGdHFaF8flO6yLOaNjVefRYehHJ849ZNg6eDioqjg6/EA2VKGA2npcmeJBg2pOpuUy/cVmXWK/b+BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwNlToHhAPPjyt7+sQBIuoAka8HbwOLfw2fBWCFhIKY=;
 b=ODVJVj4yzwOJ+z7qhmZQW7dyHhnoOdPAFMwOAOMPnXtKv7Ati6GXYrnz71S6MPtUSqIcIyo05siMmdYRrbXosUozvPwzszbkPHmTviVKQk6++Av/SvIacR+qlGo0R0AYCHloeFXDAOLYubflwnEAlhMmd3R0HezaFHV4svmVKzI=
Received: from BN1PR12CA0014.namprd12.prod.outlook.com (2603:10b6:408:e1::19)
 by MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 04:12:50 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:e1:cafe::ab) by BN1PR12CA0014.outlook.office365.com
 (2603:10b6:408:e1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 04:12:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 04:12:50 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 2 Feb 2026 22:12:48 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH V2 05/14] drm/amd/ras: add wrapper funcs for pmfw eeprom
Date: Tue, 3 Feb 2026 12:11:57 +0800
Message-ID: <20260203041206.1299104-5-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203041206.1299104-1-ganglxie@amd.com>
References: <20260203041206.1299104-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|MN0PR12MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b399855-e401-4cf1-509b-08de62da7ee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uNKSpJw1gwz8fIBDtRPyO55bRklW5p1ozZPCgW8PahNRMP1dh2tiFo36p9Fu?=
 =?us-ascii?Q?5MsFBkhXDSSsc2JoeUms859dRS3UZ8EB73MkTM6B9I3kIejLyIrJhho3g1C5?=
 =?us-ascii?Q?OcCUQJ9Erg7u40GdKALIbl5E62GAbYaGftnPzzqVYYBIx8DimdVWuitonn63?=
 =?us-ascii?Q?LuEjcXG7H7Fu8LavAxI7Os8e9bsn4jCBfhNPH38UAeBbxZK8UgbVVqeevPVu?=
 =?us-ascii?Q?aoYPXgT9FQVrfWnPL42FdmwcFrvzw64RFV6edEzkdAaGzqoUaOUpegjLXDnI?=
 =?us-ascii?Q?GG44AQrhzZgFiZ2+rh7mXqSzOldsPDVzausBL1FXTnmw7q4Hi4hnTlJeLsRH?=
 =?us-ascii?Q?69pwWWH4gs/NUwxC6T4R/De6BNZz3VqomJPkwduv5p3X7EoW8m2RIhEM17K0?=
 =?us-ascii?Q?t4xNhYKCPoCOGJNCm6jP0rYrIy8HeZkerffPTpsTJR9KSZiZrZZwqNdYO/7m?=
 =?us-ascii?Q?iW4ZJFU6wYpEG7MfPbIA7soIjvJynNl1u/KnsulCf0MYgF0AFE6Hn/l0OhRa?=
 =?us-ascii?Q?d3Zm9LtHIzSEtRAc7+J2Z/ShtwIjv4y7nbqj+eaRwKXrg9l/JcaUtpuo4+mo?=
 =?us-ascii?Q?puGk4tYcY/1aoXDwfg1VgDYGTXb5EOQJrsp+NARsbQDjTvX95/yricxTiuA5?=
 =?us-ascii?Q?3eFpdTZkMjDoSFr8ydeGWe6SN3Rc4OokMxHdaowjEJ/HWF3rwB+9fbewbbeW?=
 =?us-ascii?Q?6nrM7ipGpLXnPO4KNz65OVugd/HtMb4ZbS+g9YKGSWL7EwNSp9FfaaPuqnNm?=
 =?us-ascii?Q?K/WxIQhV8J3Wis3V0032Ewb2THranNSsLKaoMeN/YFC6ZYNiNyuIXVPd/Ftj?=
 =?us-ascii?Q?vCfW8UUrjX2PvlXhTu7zheEMqea7gCSiJ+QZYlX2u2ebYdTDldcnkokxId8M?=
 =?us-ascii?Q?J5lZaICiMkSYW32UTeckb5X26jo6WfWchKTx/BTND+XXy4ghHgHSfl/QNdqN?=
 =?us-ascii?Q?k4DArVtSaDX8e7Qdnc5fmlnP+HQHfgtbKvv0v8s7w4tNz6YOe+17jLi6jDLS?=
 =?us-ascii?Q?0NQtZqgl2oc/oSHmubN+AE3zAuMFbTDeY5SC+05sJkeLmS6q4Th5NbwWXVqy?=
 =?us-ascii?Q?cdS8lq5Nfnbmq9hkcE4YrSZmNgZ1AvDB5oNDezIiZsOYpCrz6V3dBphqLrMo?=
 =?us-ascii?Q?n99fjVvupqanD1djObVYPbaDQLOr6WHj/1t/9obpxGKfJ/eFmFaCUs2ZEffi?=
 =?us-ascii?Q?SIkqmuC6OS7jyu0r8/0Qjg0n3gDpNx7toCBPbP4c5qXReGoDn8XXtMJmQsxm?=
 =?us-ascii?Q?U0NFW2iDKMQCekkNAD46Q/0xpko9qam8VQ13QnOKXXOLeLLpiWVhpQk1N4rC?=
 =?us-ascii?Q?s3X/0yfWEZcp0wMYjN7fiM9CsjxnmP5BW4l6lcVnhx/JqioYcb9LpTXSC6nU?=
 =?us-ascii?Q?ckJ75PesFbCWNC/tRUH437ERrpgW0CbMH5WtC1WyFz5K9/W5ePnV+A0MM8RV?=
 =?us-ascii?Q?tq/aRsIxpwJsLX/Xxw8uRQIW+sbbkNphUan1Ytvq5M1cgXh4l4e3eoxcB8vP?=
 =?us-ascii?Q?XZYbn0ZaxRUJ2uzNH47OBTsNspBwKv9g0Njlz3A0ZkSLWHtUhyU1+M2xHSCk?=
 =?us-ascii?Q?zH9SaXvjBmeXuZ5UZKz389zLanZET9Wv+dGPCzFCFhGVG2pyz7xG79Uo4uVL?=
 =?us-ascii?Q?OmjHDc9CZ8+frL2Wt+vB4JPDOXmLEHv3rAYF6J+bmy9Tx4FH88q+2cJyU+SR?=
 =?us-ascii?Q?50dvbw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bv5LW24gMzjloRT8pwGgIYCBqH9Su8n53GuoDbt0/FcyGBq6d3spI5e813+LfjrJX+KvH3mEVUgeuiaoVOttGrbYaT6WIcDFXT2uHlq5wpi0Xd+nyp43Qem9kK14bJov+xBKjvwJyjQQDS/XOdjX7fhrRzHFi/CVfgRjWMkK1xygp5DVDCLFjSkt/hkDokc7FTybJStyAxxOT0OX/rVgaQA7S7c3QoxZSuDEtObvHHFhJzayVeaBfDhU/A3W2un/o61AmTAjb4Z/oAvp9Js7zLCbp8WhNixRhVrZxiS35OglGgtwZ7bRnWiAnxY0cymbqDcZDwePUYvxJesEX6Kwijr9NpC3lhVax055/I2xYcovmLpN8fiAOpsIxvuPD7poafeRGZjPBG12v9diPe7W/8A1mQKAW68g2PvhRBNvyaA/zpSzbk1AvHvmFgiXvNgj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 04:12:50.4171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b399855-e401-4cf1-509b-08de62da7ee6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5716
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

