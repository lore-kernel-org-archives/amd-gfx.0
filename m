Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1A8C48BD1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E284B610E5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E284B610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07DFF6EC43;
	Tue,  8 Jun 2021 21:40:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C2C06EBA0
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/UEed1PFwsqOGsK2+4vS87Ik/peYc0pmvAdWWRDyf8K7qNqL7p+TlKXj93+AYhcyXYX900amzdIIbrbA1uFe8m3L0+YJcR6o1gXlT+I1/1Z3C4aOd88NprcQcIEHrlF1Esu0j+ICWmyDE3iLzUD2NJYFOw9A/3gv+6KCZJIWFfIZG7FZsfcxDxBKM/0g1qigz41Y/0lla1D7yhb+uU4xA6fitfMdOPLVZ/yqgyTKEVv2xJeQK4WXtQslOsCLgnFRJ4BWccpb8eAGW0u8s/Fr0jjObaHJBkp26mIxdnPjbhhLGFHJYO6xzzHydRi1jBcmQNLxojlDA+vspsfpT8Z6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PYFxWXALyf0HRwH29X3xFMHVdDu9wOov2iZy6iQ9hk=;
 b=Oh4UQ1ie3qK0zHemt0Pq9y5iOFeufAjNa6dePifJ1imjfT5SsHHLF4DHE+RHkK5rcrgphjlDaiHIO1kXRzS0yI+iYa3N0s75DI4r8leF5E6IIGfzphtLYbSSHKrgK6NRVv3Mv3fK6LR2TCrww5dPDUQkvR8NOoaUDa/PadYmEPXUPmLZHYgqI+uJA3tmLYLCeU9ngdvT+aJ8lKq3b1gmS40oNVMkzSgz3tHI/lBkGhposwG/Vy4+w3GmLqNBgi9TtCsAxVzXDcAaonxZwjf3Xngu+T8uurxXHud62VYrIPNXNBUPFLGgpJPMi8eaHESeAYRPiZ/PJv3l9GC0dMtLSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PYFxWXALyf0HRwH29X3xFMHVdDu9wOov2iZy6iQ9hk=;
 b=rm7Jv3igHXDZAMpJ2c/E/gDtQlkTvECS/Utj0pEhrJ4vXX7UKzMBBzXgggTFpqqM6/mZx7XRl/weyi2oczGnxVqye2rauRqq5Hq8x9x20hFZW+FtYDbY1b11UMZgyqeHU9OT5EiBw+ws5tksmgM6iHL1249jh/pe7ZRCMznxn7Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:22 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:22 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/40] dmr/amdgpu: Add RESTART handling also to smu_v11_0_i2c
 (VG20)
Date: Tue,  8 Jun 2021 17:39:27 -0400
Message-Id: <20210608213954.5517-14-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608213954.5517-1-luben.tuikov@amd.com>
References: <20210608213954.5517-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bca619e-be74-4819-a7a8-08d92ac604dd
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44352222C5E22402480F69CD99379@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I789YVGtaaJj+LHTIECDBLh/nJyeLG84PqgJnmdzpqFqk0gRCcqke2ighf0NsXdo7Z7+Xgw47FDdXbYUxTkMxACSPWUE+YW9qsVMu/SAuspCpYuy9aIdPLnEonP0ke5lS6jtjduVdQ8zJnFmgdJ0k4zrU0VyZE8ns9ZueSZu1ytLOGiE+bV2cW21IKvk2SHdslgeHyzlXRJw1T4mAEpkPknZaAHreiDrxZHA16JIocbFakm9IM9YjSqMGYn4gYYCcVMqptSrUttNZTFtIW1X1PnSFECbq8pZTKeiz9ksuZsXSsmherf3mMCZk4r/+k5SPXjEjFvUjNmocgFkYJ/AD3gFszX73Ma6umxWs1OKSRI0hYqldNxe4mOxgkjtvecTn2UH/bD5i20mgbWYcNKdBa6HwiTFUPqVWknhlL9eRegghGh29/TRI6I27QeNF9Obtpm0zFQC16qfQ4yqQGWa8wbyjx7LHpKNGW36nHFJmonOXJ+VTXNUPzuNoebLC2xms5u1H0TGYm6SkzKfI6fnuXsVj57vzBV7j6PCH9fsLLj9fZe+hREyCspXCfdl2PV6HS/CFuMx57LAsRNbs4vBFpej+z9uIBmCxj5s1DT3ZX7U5Yfze5F70VGz1L8r6q0wbKYXL0pGc2EhE3bHu3MA5b/C7hgfe4p6LvZ3lxc04prLkrcWTX8XaGOhm5W4oGPK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39850400004)(6916009)(8676002)(6506007)(6512007)(36756003)(6486002)(66476007)(38100700002)(38350700002)(26005)(16526019)(1076003)(8936002)(2906002)(54906003)(316002)(4326008)(66946007)(186003)(5660300002)(66556008)(83380400001)(52116002)(2616005)(956004)(55236004)(44832011)(86362001)(478600001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NfvjfxoZ7wUnljF5bwDb+X6NhZr0nrbzj+99uG4zVu61KpGFy4qXvzgiNvLm?=
 =?us-ascii?Q?1c2/aHHBzMrqtLo13WmA3WdXSM5xCXYCSmwPcqu3rx6SrAMOTKNf6mQaDug1?=
 =?us-ascii?Q?ovHLgIEdAGXyk+cKBHQTFZ1cnUthXUNidx2OSoJpGUeARnv7O+8C6vuGcAwW?=
 =?us-ascii?Q?PLuVxliq2TWpnzHFUTc+Sx36QTbgwq1O6kV5f3DHJuKst/IhA9MXapokPGcZ?=
 =?us-ascii?Q?RUsMKXTfdCkf8NDm4xgTHDbzdDv9Ufik+Mmz6gk3z3HiuZ1vmtXluJcAK9v6?=
 =?us-ascii?Q?VPLg5EbvcBqaOTZF3HfbL52yzkJLC1ZMZZh1wXcrSqSWQfF43x+AJ32GgvxZ?=
 =?us-ascii?Q?XnST9hbPPEjNBLo5dvor1dXNcBIZ4qag66k7XZqaG9wXVeXibcrAFaCn9Enx?=
 =?us-ascii?Q?s1VPk4NH71EajCUV6aCZtWcqx4vbI8+ANAGFMAz5KP2l+Q4T4/J0s1LmrCRw?=
 =?us-ascii?Q?3LtKOwalfayjgSfXFDDxD0tSmlHjdxB/f5xf2i+YO+v/KExBgoBaoWKciR4c?=
 =?us-ascii?Q?pNpD0mx7IuOWJxrMgn4YlkNMZfxEQliDL0f3EEqZcAWkTIBGHYbjy5o0ltd0?=
 =?us-ascii?Q?jiM4kjagYrLVQQ1gHZ1Pf0S7BaoL/D6nyUl44evbkT/c65z8f7xYjB0bxKpT?=
 =?us-ascii?Q?Hgt6GEa9O+dG2thHvx/0v3gXqLyKI7CwPk4tR+a9hMxoArFnQkqpuNbEmm8m?=
 =?us-ascii?Q?0GR7t+OkHralBVtQHSNxdmGHqLV4ungDsIJ7eHhmKN4MwVa1VYPEJ6GnLMh0?=
 =?us-ascii?Q?qlTmw48HyBBxqur7ANDkpz8gcbMvcTYU9Y5HJyfFx3uEXoh05590GG9FaC7W?=
 =?us-ascii?Q?qUwEuI2a2SnFtQuFjlsSaftQwK/bI4OP/URMsQ1P6kY8utQMnfP/Ks7JBS2+?=
 =?us-ascii?Q?HotGaAhNqyq2OgWCEn/O6W8jrhvFjQaf4e1C/JGhnckHd7UF1tF4hhNI9jOT?=
 =?us-ascii?Q?eCrdl6ztjudYA7UuPZhPiOeccDcV13s37E9IMKqLaK0dbz8HlywezeATgGrn?=
 =?us-ascii?Q?l2odr90NMzgv3H7B2FwRhE8ZG18XycV8Ltta6+/IAokmsYJeq8z6JbXDWjnp?=
 =?us-ascii?Q?M92fJstLW2jd2kkGUYSS6v1WgKYctWww015THwBe2VFP1V1pvNE3QLtFWwQJ?=
 =?us-ascii?Q?9S/I5ZArowlH6L74LFNNAlP5YhWyiz06uJ01lHDOfwa5ufrnoPU1B9XeQaD+?=
 =?us-ascii?Q?HUqbQnnnf8mYO59ki0qSdvcHyZoU/PjZETEhQ4j+aMw8iy9Ts4ExFEgEp35B?=
 =?us-ascii?Q?tKXNmtMUAY3cORUv+oZxAqPoNt+OTDJRwK8tk7Bbvfmq5in1ljZPzHftU1KW?=
 =?us-ascii?Q?q+RmIGjjyNk6vJAzuZe67aDA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bca619e-be74-4819-a7a8-08d92ac604dd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:22.5201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: laRAYRAQf6mXAlGwAvVjRM1K8EtqXehSkMbhzdMuuumSO8RzU7FM9gndho2RvbnX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Also generilize the code to accept and translate to
HW bits any I2C relvent flags both for read and write.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index 3193d566f4f87e..5a90d9351b22eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -530,13 +530,11 @@ static bool smu_v11_0_i2c_bus_unlock(struct i2c_adapter *control)
 /***************************** I2C GLUE ****************************/
 
 static uint32_t smu_v11_0_i2c_read_data(struct i2c_adapter *control,
-					struct i2c_msg *msg)
+					struct i2c_msg *msg, uint32_t i2c_flag)
 {
-	uint32_t  ret = 0;
+	uint32_t  ret;
 
-	/* Now read data starting with that address */
-	ret = smu_v11_0_i2c_receive(control, msg->addr, msg->buf, msg->len,
-				    I2C_RESTART);
+	ret = smu_v11_0_i2c_receive(control, msg->addr, msg->buf, msg->len, i2c_flag);
 
 	if (ret != I2C_OK)
 		DRM_ERROR("ReadData() - I2C error occurred :%x", ret);
@@ -545,12 +543,11 @@ static uint32_t smu_v11_0_i2c_read_data(struct i2c_adapter *control,
 }
 
 static uint32_t smu_v11_0_i2c_write_data(struct i2c_adapter *control,
-					struct i2c_msg *msg)
+					struct i2c_msg *msg, uint32_t i2c_flag)
 {
 	uint32_t  ret;
 
-	/* Send I2C_NO_STOP unless requested to stop. */
-	ret = smu_v11_0_i2c_transmit(control, msg->addr, msg->buf, msg->len, ((msg->flags & I2C_M_STOP) ? 0 : I2C_NO_STOP));
+	ret = smu_v11_0_i2c_transmit(control, msg->addr, msg->buf, msg->len, i2c_flag);
 
 	if (ret != I2C_OK)
 		DRM_ERROR("WriteI2CData() - I2C error occurred :%x", ret);
@@ -601,12 +598,17 @@ static int smu_v11_0_i2c_xfer(struct i2c_adapter *i2c_adap,
 	smu_v11_0_i2c_init(i2c_adap);
 
 	for (i = 0; i < num; i++) {
+		uint32_t i2c_flag = ((msgs[i].flags & I2C_M_NOSTART) ? 0 : I2C_RESTART) ||
+				    (((msgs[i].flags & I2C_M_STOP) ? 0 : I2C_NO_STOP));
+
 		if (msgs[i].flags & I2C_M_RD)
 			ret = smu_v11_0_i2c_read_data(i2c_adap,
-						      msgs + i);
+						      msgs + i,
+						      i2c_flag);
 		else
 			ret = smu_v11_0_i2c_write_data(i2c_adap,
-						       msgs + i);
+						       msgs + i,
+						       i2c_flag);
 
 		if (ret != I2C_OK) {
 			num = -EIO;
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
