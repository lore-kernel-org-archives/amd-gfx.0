Return-Path: <SRS0=/DoG=L3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98194C07E95
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Jul 2021 00:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AFAB6141C
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Jul 2021 00:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AFAB6141C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB77D89B4D;
	Sat,  3 Jul 2021 00:25:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16C3189B4D
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Jul 2021 00:25:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6uUjnG4pFCxX/0yRn1FD8hL8b7AFAbqNzBUrbQG1m8IqHLDc/1pF3eVe+lo4h0fT6NQ2Ef00kNkgJxGvBjLUI1u9fLXXHMq3N7dvQ8uhUNTlSU7p3IFBxkt8xpWRPdZ/B6hh1VB+9K4QzYQBafVnn/ICW47UySqQVMln8Ul1uNpau0lp86wKqFELuJAxpq9FZDc966tdyUjlNe/2C0JmqRjEKjlVnYDJLz/+77NdK6p47glvkQikW8YfWfxSkzO/h/9wZA5TCouH4i6ElS0yysz7zQ/Bt734SWjbwZZoaBpEbF94jTkY+Dyws8n8dAeO2y4ZG4b0SR2b/Z5Tz7OGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3SH4El/n1EOjNJkNV2jlX3+A3xgMU6dh7bb+2tpe+w=;
 b=HyrPQnu9d1AoCDrdX1zUM6399ALIkuNyfH+UE57DF7ehgVN/2KhZ7C4+dIFjXwAyfXzb+RjH4p7XN9AGLmZpNqOsgCf6I/Di9NjZkMB64bXjtvHBAJq65pZ7FJvgi8EXx4HsetYfL0L79oo1ahu3DBzaTRuwNmohLhYw/lFBpNGer1fjcikQpAVCLuUb4s90zvoxhFjST0dwWFA6sD8ssFO37EP2bNiUUF4SxlEB8JRTCyUz506Z9p3jdbcigknix0RdfZhqtHT9AC6CtrNSHdwSkXSgscHqU5Xg+NpteaTotfl66QDv3ZWEP8WsSJ2dirkysPLV/1jwMenhk+VNvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3SH4El/n1EOjNJkNV2jlX3+A3xgMU6dh7bb+2tpe+w=;
 b=RjgMlMUrF11xnRmSKnIxGt5mbAmMjKOf4pDi82rAUMi/kk/Y7Ms2fANr8Il/oSC71J1mpggn6xbow0ptlsnkq2kJLeJi1qcENT77z1i76aRY4y22vAHWzm1SE8Vh54dzbfeGlkbxyh9EWZt86cPWj+FuokvoffcDgs2FJwTn2j4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1353.namprd12.prod.outlook.com (2603:10b6:3:76::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Sat, 3 Jul
 2021 00:25:26 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257%4]) with mapi id 15.20.4287.023; Sat, 3 Jul 2021
 00:25:26 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: The I2C IP doesn't support 0 writes/reads
Date: Fri,  2 Jul 2021 20:25:09 -0400
Message-Id: <20210703002509.59476-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210703002509.59476-1-luben.tuikov@amd.com>
References: <20210703002509.59476-1-luben.tuikov@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: YT1PR01CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::7) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.84.11) by
 YT1PR01CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.23 via Frontend Transport; Sat, 3 Jul 2021 00:25:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd56147a-6277-4496-ffcd-08d93db90de9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB135337CFB84D509831B90B1A991E9@DM5PR12MB1353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LsE3USzqypxzLSMlOuKXG3l/SlusMI4d/pljqntFVnhrovJOkcQv0oH3UhIyi0zVWcm6kKgwYs4X8I3AaYpSeZs+pq+gnQ5jXqQ1jG7q0+3uBxNjYIseM1f17lNz05MXtwvzEynr2EcEAY+ZduEANwbKzNXA5eC2WCfrUF5T33s0gdp0CC33e1WO1+ZoYO8sr3twLIQO8ocVjOiLIV2fWqL6u96aqwjhr4cArc1+kGaANccjntHuJl/POhCUMlRb+3PT+EzIKrmeqMMqI5W92zaunJgLLFj4QGtrgky5lRG8LgpByhj+hnuInXmCaYo8sR7QcNELsH4W5PBM7PVBmRCbTzTY1btwMOr30GTlka8G8lrN2dgRdwiZoGqbZNcq4HrJOjr4/hrk5HG21NJvQkQwfC2AU9Wiw5HUSaD3RoHjKxF9FPhMuQ4nyWQU5A3pB/uAWDsoMkeT9FSeDITcKPtc2cha6jPEiUAnpXs/fbSbawJxK6riS5q3/D7TFKrbRd5eHcKgfMPi8VwUGB02ALObY3f1GVfwQQylL5GkHzSqzEyFLbzLPKQZbeVk7Pay2G72Yys668BFdo5hznRNDifFZ6ETutmdypa4ayvohIxZOACwC4HSE5llKhCbwmxZ6Q97vPkcWFMWHvuWV1Eht9KUHUW+Jn+uhV9ft3netlJQKKvjwVJSZAnsiI0A/8rJabP1zpZ2ybUVAE37aedihQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(2906002)(956004)(5660300002)(316002)(44832011)(8936002)(66946007)(6916009)(36756003)(54906003)(8676002)(4326008)(2616005)(66476007)(66556008)(52116002)(1076003)(6486002)(16526019)(186003)(26005)(38100700002)(38350700002)(83380400001)(86362001)(478600001)(6666004)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M3fFrG7pUJt9y1q1LGI3UIWoyXClOwY9jYpk7+rkhYw0eR8XSka2l+ygDYYq?=
 =?us-ascii?Q?8dxWJu30p8GkKO0DRQDSarHb2M2hE3LF0gMJqZYpoFTqPYFxZKf6MudG/qP3?=
 =?us-ascii?Q?CBrEiYhCFhXZDvqep3nBJ0+A8+YuIf5JKh6TnLKGjrHCNI/5+rkCw04G1SKv?=
 =?us-ascii?Q?OLovfWa6UvqH4ITVDJSLig1qLX0GelAIphqU1td+/AfvLbK4dHa9ePidc0Pi?=
 =?us-ascii?Q?NxS5J03ku3plh7GgsyW9pUl6/y5dbuGS8jLra8VnuRBtZNxEmRB8pdTB+Qd0?=
 =?us-ascii?Q?t2hCqtOybqKCV6UQVfv+QHnlSO0JPVthzERYE0dC4LNFyfP0avxXgFurR4if?=
 =?us-ascii?Q?scJGJPu+7DPVa6PxuZd0L1OPh035YNc0FDHtme5mWPIoOvx6qu9/loMSGF0U?=
 =?us-ascii?Q?jbXQ9F03BwxUFJdyyHHQC0d8clEMkrKIFFPjp1qypVHG+C0DQzEnHuXZi97h?=
 =?us-ascii?Q?tbwp3mkYYQLZFxoQZIygI0IT9wcoexWEiRqM2e2TCUDGK2NAgQPfLcJdDvRm?=
 =?us-ascii?Q?lvQbky5zTpuXaSYYs1krs2k5d2T6AEGqY2mVYhB2Lqxaae5sdmZHLJ2cx2CG?=
 =?us-ascii?Q?PFxuFJ2w2JINoF2f4IIKKd8pS81QMRykCjoegoq6+GzXRIr7D7bpVwHBus4y?=
 =?us-ascii?Q?01jsvKHzuFdS+HP3COoGWG8r6MbueZdnLbNOdv4kEdGlweeqQeyU/KwIO6fn?=
 =?us-ascii?Q?/Cz10m82D/1mEfGsvcj0W67bnT7t94mfWeYqPbzthBR1aKpGRK1Rp3Fp9x55?=
 =?us-ascii?Q?wkN2Ur2/xjOqIgaSoCSzT+6W6MXqXx8Lx1RqQ9ij4O3ckyyL0tEjReSJ+tl2?=
 =?us-ascii?Q?UIt+ukMsdMDnhVYkEycp+bCDVe6DngLBeC1Ffyq4yQbsypY6QljbLKIs7gvm?=
 =?us-ascii?Q?az723dmNFeYlwZN0t6WpSuAo+caLBiyc3NQecLrBoLBuFZb5wcleQuWKmygQ?=
 =?us-ascii?Q?Eon5ixkHOS8M2QAuKlSyYZu4tkCvNL0gUJqOoCod74e6n4/IGpB9j54GZqNO?=
 =?us-ascii?Q?YyahXXwz0GD3kXl21gtruUPMDKiAX+sW9rfb1yB1Ugge/dLqMxBhF2UEFEG9?=
 =?us-ascii?Q?7At5CzbBIdLlbLy045SeWv6HTauYeeJ3Z3sqF/1JLBXJfcZAVWTwjJhijNtR?=
 =?us-ascii?Q?GjMBngRO3wEHmzWxV20A7LcocyezqkqxZKXsVpLz29KsjgWUo637vnVyM6E1?=
 =?us-ascii?Q?IU/rJiXv6CXehj6S4cZY6e6dV/CNUzWNCP9lmETQkhCPBTu0JnSWwxuWDUYz?=
 =?us-ascii?Q?CLsJTPvKKGs0Y2zKhqNt2PFOqtUUQSIJ7vRW+zjrB9UiYJvbUI5gjaejkesn?=
 =?us-ascii?Q?s6gwDLUrBBc+2J2xt5bXTVMo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd56147a-6277-4496-ffcd-08d93db90de9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2021 00:25:26.3547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4aHDf5rRcFraFTPVlien6cGtw8JdkPAwfjCrlxMsJUZsoqy57jwiRjtsLPRENCo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1353
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 John Clements <john.clements@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The I2C IP doesn't support writes or reads of 0 bytes.

In order for a START/STOP transaction to take
place on the bus, the data written/read has to be
at least one byte.

That is, you cannot generate a write with 0 bytes,
just to get the ACK from a device, just so you can
probe that device if it is on the bus and so to
discover all devices on the bus--you'll have to
read at least one byte. Writes of 0 bytes generate
no START/STOP on this I2C IP--the bus is not
engaged at all.

Set the I2C_AQ_NO_ZERO_LEN to the existing I2C
quirk tables for Aldebaran, Arcturus, Navi10 and
Sienna Cichlid, and add a quirk table to the I2C
driver which drives the bus when the SMU
doesn't--for instance on Vega20.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c              | 5 +++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c      | 2 +-
 5 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index 7d74d6204d8d0a..73ffa8fde3df3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -702,6 +702,10 @@ static const struct i2c_algorithm smu_v11_0_i2c_algo = {
 	.functionality = smu_v11_0_i2c_func,
 };
 
+static const struct i2c_adapter_quirks smu_v11_0_i2c_control_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN,
+};
+
 int smu_v11_0_i2c_control_init(struct i2c_adapter *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
@@ -714,6 +718,7 @@ int smu_v11_0_i2c_control_init(struct i2c_adapter *control)
 	control->algo = &smu_v11_0_i2c_algo;
 	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
 	control->lock_ops = &smu_v11_0_i2c_i2c_lock_ops;
+	control->quirks = &smu_v11_0_i2c_control_quirks;
 
 	res = i2c_add_adapter(control);
 	if (res)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index b1adbe17b6c2d4..6b3e0ea10163a1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2022,7 +2022,7 @@ static const struct i2c_algorithm arcturus_i2c_algo = {
 
 
 static const struct i2c_adapter_quirks arcturus_i2c_control_quirks = {
-	.flags = I2C_AQ_COMB | I2C_AQ_COMB_SAME_ADDR,
+	.flags = I2C_AQ_COMB | I2C_AQ_COMB_SAME_ADDR | I2C_AQ_NO_ZERO_LEN,
 	.max_read_len  = MAX_SW_I2C_COMMANDS,
 	.max_write_len = MAX_SW_I2C_COMMANDS,
 	.max_comb_1st_msg_len = 2,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 36264b78199620..59ea59acfb00ff 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2820,7 +2820,7 @@ static const struct i2c_algorithm navi10_i2c_algo = {
 };
 
 static const struct i2c_adapter_quirks navi10_i2c_control_quirks = {
-	.flags = I2C_AQ_COMB | I2C_AQ_COMB_SAME_ADDR,
+	.flags = I2C_AQ_COMB | I2C_AQ_COMB_SAME_ADDR | I2C_AQ_NO_ZERO_LEN,
 	.max_read_len  = MAX_SW_I2C_COMMANDS,
 	.max_write_len = MAX_SW_I2C_COMMANDS,
 	.max_comb_1st_msg_len = 2,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 0c3407025eb29f..fb5b3ea6127342 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3527,7 +3527,7 @@ static const struct i2c_algorithm sienna_cichlid_i2c_algo = {
 };
 
 static const struct i2c_adapter_quirks sienna_cichlid_i2c_control_quirks = {
-	.flags = I2C_AQ_COMB | I2C_AQ_COMB_SAME_ADDR,
+	.flags = I2C_AQ_COMB | I2C_AQ_COMB_SAME_ADDR | I2C_AQ_NO_ZERO_LEN,
 	.max_read_len  = MAX_SW_I2C_COMMANDS,
 	.max_write_len = MAX_SW_I2C_COMMANDS,
 	.max_comb_1st_msg_len = 2,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index c1c7aefa9d8fdc..c16ca0c78e9306 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1510,7 +1510,7 @@ static const struct i2c_algorithm aldebaran_i2c_algo = {
 };
 
 static const struct i2c_adapter_quirks aldebaran_i2c_control_quirks = {
-	.flags = I2C_AQ_COMB | I2C_AQ_COMB_SAME_ADDR,
+	.flags = I2C_AQ_COMB | I2C_AQ_COMB_SAME_ADDR | I2C_AQ_NO_ZERO_LEN,
 	.max_read_len  = MAX_SW_I2C_COMMANDS,
 	.max_write_len = MAX_SW_I2C_COMMANDS,
 	.max_comb_1st_msg_len = 2,
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
