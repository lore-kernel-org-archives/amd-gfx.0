Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48996C48BD1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1964B610E5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1964B610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA55D6EADD;
	Tue,  8 Jun 2021 21:40:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0DDC6E59B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iApzzUkv1Goys6XSje9SizrwlC3Ql+pxPw2fP2PZ/CXQkK9UZoXjudaEACAxv1E/FpmzwNKZnEpgVm2yWp3TPuvFyvfvFudEdBrjQIFjRh46OeSo/fTJLWvtWZQoC5D6Mz5m81qSflL+V0h0mQeKo+oOa3sJYu8HeFjbTK5OpSztpTUevUHBZmo3VvdxAP4+AofGVBLtQxTfac6yOdcl3kY5VS9uchgU+j+m2TFiCfr4QJLmfI2bPclRowsi20Zwto7unyWHN3d0/1kbULKTIXgeFVZaOC3RVJ+WJl3uUa3q2rKSS5BAZOB1ZwWy+ozeQI+BtescqOtzkzMxMkaTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzXNubiPxyzXBztceTVMCeZE13HSX+DfgWS8osIbiJY=;
 b=n4jC234ImrNnAY1WvyhegKrAKhW8t1be+UCQ8vyHTGum9FqJAyg4TPYUfjJn2JvaIgjLJsDjUZc58Tu2lMR1uE0k0r6WK+zM7Y+QZTr69kPNeAoyuQAxM4IlbSU7h7mi9lpsck5At+AGvHHXe13cBA4Q7mAs0tp2SDIVBHmfS4UWSd2mnd6rjC+dWv1CRD5t17h6+PFSRO+ZaSBMMX/ADFUcG0TKOdUgYk182WFIXymqburalFesh4iObyWUKVcWvL9YXKEpGaBerx18ueAdjBLaA7hwSxkrnaIsinIxfDn4F3EVPvTQ/Mbpq0qhwv0WrOMzGje6v1OrKdZmsPh/xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzXNubiPxyzXBztceTVMCeZE13HSX+DfgWS8osIbiJY=;
 b=Jqr7+hzbQRrje3bAE0PEioypA9+mLC/UJEC+PLxi+XdzSIBr1cHe2Jy3D8HVng0AVpy2ArA6Z7MO8HeCd5geMCO2j3n+5CNrK6d06LMHiOy9RYi1AbpHGsG5ROfT15PlQM+Cd4pFLvtCW/xD0PSGsFgm0bIL3PA/ity5UavG6S0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3964.namprd12.prod.outlook.com (2603:10b6:5:1c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:16 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:15 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/40] drm/amdgpu/pm: add smu i2c implementation for navi1x
 (v3)
Date: Tue,  8 Jun 2021 17:39:18 -0400
Message-Id: <20210608213954.5517-5-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb6f4292-779b-4b0d-f6a9-08d92ac600e9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3964:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3964A3115E16E23D684C0CE099379@DM6PR12MB3964.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lvaJbs4o41EuvvpIV13gxO8LPWBSkp8pc2cxnTHoORs2fORxTh68fNDfhnA/t6X+2Jx+erQqqY3mnFuE8McRx+zTTIzuxYwBBhau37hoaZSvU5ko+Azaa5uPi6WCK+W83D/qlALgeroZC0oFYHfhxkvtFYQsXBnnJ9JjIqj6kilQdbFgOV//27iVIK81r+75G9wktSERHNpES8xll4JbaV87HcJVXcWga2QPWdtrtTXjrzGC5buMh7J05n0QBmHehwv43ohrslG45OvHu9QZUCYCT9iJZedUsNefUu8g6s4PLhq9j3rnAUG5OlxH5k/DQ9qzKL/ENZJpimii/BaMivdnKTRnS1eA5fwHuvzHwBUtjSnIj2MTO4TsCtla7lxW4shvqyPJLJK7g69b4k2M5n5rmUcHnU/JYsJDE0vTInrSkwgAluCB3RQnOTXhtbEMdhYuPbTpzQmg1TEoATVCirE2Or8yeQ+oYxQI1XfA6eZlFUkihmWPkFM3NeVjniEt7uvXBVOEZVZMhsq4H6ctnOpJWDYp22RALgElH8ceXVx1JcF999SelwLdSYSIpVn1iSl8c4RiE+zb1pDdqQ9mKkcHqUY3CqDaOuc7s7HgVkCWUW3gScqisqsFDhaGVUjZt2VoJSJMPblDgaYjxfiePWrsw5CaE4B5BACbKs7j7WF8sHjbtUdBiLetvBxNKGAMUnKpp8akvLfRZFvaZndCTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(52116002)(4326008)(38100700002)(6916009)(16526019)(5660300002)(316002)(54906003)(55236004)(6506007)(6486002)(83380400001)(186003)(6512007)(2906002)(44832011)(26005)(1076003)(8676002)(2616005)(66946007)(8936002)(38350700002)(956004)(478600001)(66556008)(66476007)(36756003)(86362001)(69590400013)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RzzJJFpQZbPBLdZKd5w9lIbcnsgvTDp53dtzAObfW2PDboa+wplSRkm23Zbc?=
 =?us-ascii?Q?oQwXu24p3xEcwkHLu4gcUizxy9lHsu4AAphKF2R6Xh+CEJGZcHTbgk/+9iSo?=
 =?us-ascii?Q?xbrT2W//6gl/LnPPB0jPWJ4MON/OzkRJvu1kG0db0A8HE4ts+UaizkWZvbsy?=
 =?us-ascii?Q?9ERmJWYGO6skB1Nmf0K78HN8D85TEkicJuvK2atp7hmfJkvaCmGAE5r1SmrV?=
 =?us-ascii?Q?Ekb56s9Uu7dwIuXyEnFqBfHdn2CDPAUa1seP7r3HHM54aPYnor9PYzlH7xMR?=
 =?us-ascii?Q?F2n2iVfgc1bcPyUP0kRxkO29I7JAKeViS2h1npdDZphvDg2NQlWfw9VnqmdK?=
 =?us-ascii?Q?jrZZc9ZjhrwqBbJ+pWwNXGn2aQM2S5j6cffiTjQ/37xFRKO3Eq6KHvcHbWxA?=
 =?us-ascii?Q?XRPEkTr4q48qYzigLbYjGVPeQwU6G/uJyFxLHfFSSE+ZmsRKpRaAnsEapXgW?=
 =?us-ascii?Q?dZ+caD0NqfN257FR7EXehevonacsIBILq8nmEWZ7vWzCdljOourbTV/7pyht?=
 =?us-ascii?Q?eeBn4SQWzP/KEfR7xeysiEWypQnDMPJtou3f9q1jA5aeQb9wW/vjwJ6eZem/?=
 =?us-ascii?Q?fz51tBrundD5KylXbrl/VoNbxf9styHDs7qUaPNGYPJD003gYZZZppvbBxdm?=
 =?us-ascii?Q?o4g+uNlCE1rlIJGRZeJZPc0d9NXHw3LRCeeVn2D5CDl2YZxoNXel3SILD41k?=
 =?us-ascii?Q?BSvX68kJ5cT0n0ORGtP6z5D4gXiz3+alZXspMCHGyWPK4S1B1im0UnNGInhM?=
 =?us-ascii?Q?T2Pc3ID8MMN5hOivgkDCjKFvS4nVCyNaWHWLBtm7Iz3PZEVfiRRblc7liGTs?=
 =?us-ascii?Q?A2VXAHqIudfDUoa7MZkkZ8OsrFgIanGcgaRbOSZ260biX2BXLclnlWQFIviQ?=
 =?us-ascii?Q?WKDx2gxa8IJxW4Y5SjSNR+6AWJQRnq0knGHN28IbwuzDJJvApwrd6ye8vDIY?=
 =?us-ascii?Q?nzWTZT5XnsXM1ySzruPcLnn1zMfAaTIEYQ6Y8Aly1Xu7W5yXyBP4EWE7N5b/?=
 =?us-ascii?Q?okMUv7s4TcRQnlX31wGUio8acH3yBfpnfBRXDX64wGbeJg6ghdXyXOhJv+so?=
 =?us-ascii?Q?h7CkLW0e8t8ZUYK5TxfCc5zHXkPy5h6yyy2iW7CgRv3saN7Bl0dZ8D9UuHaw?=
 =?us-ascii?Q?dc4RrYMZDv6kDAl69E1YUb7lBlRtdOIezEtzPvPTxjIHJGbVPPm6FEFfZAnG?=
 =?us-ascii?Q?iKZ80bgCUsDDcdTgEN42kX1jbuOedO1uFDDzoStBvB1bLb9CmW4fnl9evtNk?=
 =?us-ascii?Q?+46EF9lt/V3rF9cZxxgvG4sYhtBNSRueP64s6lY4CdpEZbcPRzhxHunux04H?=
 =?us-ascii?Q?AI4NyJRS1WwVD98i4/59oqI5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6f4292-779b-4b0d-f6a9-08d92ac600e9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:15.8238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZufzV2/pfdEB07ks6ZXp/kAAz20N3NISaAFalrb4BOVGfE6eUBBxdqTW4J/LZip
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3964
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

And handle more than just EEPROMs.

v2: fix restart handling between transactions.
v3: handle 7 to 8 bit addr conversion

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 74a8c676e22cfb..6bb8b4d631a254 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2701,6 +2701,120 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
+static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
+			   struct i2c_msg *msgs, int num)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
+	struct smu_table_context *smu_table = &adev->smu.smu_table;
+	struct smu_table *table = &smu_table->driver_table;
+	SwI2cRequest_t *req, *res = (SwI2cRequest_t *)table->cpu_addr;
+	u16 bytes_to_transfer, remaining_bytes, msg_bytes;
+	u16 available_bytes = MAX_SW_I2C_COMMANDS;
+	int i, j, r, c;
+	u8 slave;
+
+	/* only support a single slave addr per transaction */
+	slave = msgs[0].addr;
+	for (i = 0; i < num; i++) {
+		if (slave != msgs[i].addr)
+			return -EINVAL;
+		bytes_to_transfer += min(msgs[i].len, available_bytes);
+		available_bytes -= bytes_to_transfer;
+	}
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->I2CcontrollerPort = 1;
+	req->I2CSpeed = I2C_SPEED_FAST_400K;
+	req->SlaveAddress = slave << 1; /* 8 bit addresses */
+	req->NumCmds = bytes_to_transfer;
+
+	remaining_bytes = bytes_to_transfer;
+	c = 0;
+	for (i = 0; i < num; i++) {
+		struct i2c_msg *msg = &msgs[i];
+
+		msg_bytes = min(msg->len, remaining_bytes);
+		for (j = 0; j < msg_bytes; j++) {
+			SwI2cCmd_t *cmd = &req->SwI2cCmds[c++];
+
+			remaining_bytes--;
+			if (!(msg[i].flags & I2C_M_RD)) {
+				/* write */
+				cmd->CmdConfig |= I2C_CMD_WRITE;
+				cmd->RegisterAddr = msg->buf[j];
+			}
+			if ((msg[i].flags & I2C_M_STOP) ||
+			    (!remaining_bytes))
+				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
+			if ((i > 0) && !(msg[i].flags & I2C_M_NOSTART))
+				cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
+		}
+	}
+	mutex_lock(&adev->smu.mutex);
+	r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req, true);
+	mutex_unlock(&adev->smu.mutex);
+	if (r)
+		goto fail;
+
+	remaining_bytes = bytes_to_transfer;
+	c = 0;
+	for (i = 0; i < num; i++) {
+		struct i2c_msg *msg = &msgs[i];
+
+		msg_bytes = min(msg->len, remaining_bytes);
+		for (j = 0; j < msg_bytes; j++) {
+			SwI2cCmd_t *cmd = &res->SwI2cCmds[c++];
+
+			remaining_bytes--;
+			if (msg[i].flags & I2C_M_RD)
+				msg->buf[j] = cmd->Data;
+		}
+	}
+	r = bytes_to_transfer;
+
+fail:
+	kfree(req);
+
+	return r;
+}
+
+static u32 navi10_i2c_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+
+static const struct i2c_algorithm navi10_i2c_algo = {
+	.master_xfer = navi10_i2c_xfer,
+	.functionality = navi10_i2c_func,
+};
+
+static int navi10_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+	int res;
+
+	control->owner = THIS_MODULE;
+	control->class = I2C_CLASS_SPD;
+	control->dev.parent = &adev->pdev->dev;
+	control->algo = &navi10_i2c_algo;
+	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
+
+	res = i2c_add_adapter(control);
+	if (res)
+		DRM_ERROR("Failed to register hw i2c, err: %d\n", res);
+
+	return res;
+}
+
+static void navi10_i2c_control_fini(struct smu_context *smu, struct i2c_adapter *control)
+{
+	i2c_del_adapter(control);
+}
+
 static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
@@ -3035,6 +3149,8 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.set_default_dpm_table = navi10_set_default_dpm_table,
 	.dpm_set_vcn_enable = navi10_dpm_set_vcn_enable,
 	.dpm_set_jpeg_enable = navi10_dpm_set_jpeg_enable,
+	.i2c_init = navi10_i2c_control_init,
+	.i2c_fini = navi10_i2c_control_fini,
 	.print_clk_levels = navi10_print_clk_levels,
 	.force_clk_levels = navi10_force_clk_levels,
 	.populate_umd_state_clk = navi10_populate_umd_state_clk,
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
