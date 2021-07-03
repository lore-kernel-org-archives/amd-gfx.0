Return-Path: <SRS0=/DoG=L3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094B3C07E95
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Jul 2021 00:25:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F096141C
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Jul 2021 00:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F096141C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE5446E155;
	Sat,  3 Jul 2021 00:25:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0F9089B4D
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Jul 2021 00:25:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAaYc3pyNAcKvqLjLVzOGDK15SwMI9dgRO1lImgHNyVtFpWYcN3W/cIjQKWgaqq91PAFVDvtJGoBJqqHWBpoWfjPMPalC8Wy9NUHVrjdk37i7l+2+QVeaPp8eIpJ6mQupuXriDU9O/+MZNh2hChsIn6JhZWatNHPEVErWtDR2vK6sQnRNAzI4hFiOcI7k1z1+h5kZRkCGjFnbgXp5E27Hvv8mW8nH93LEPMZSN8I5jwmEjaGbjDhK5a53jH+gdKgoKnKt18C2IOrxbmMQVa/AZ2iNHnk43R179zEybkB2sZVZ0hec5wDQVhFy/2waf8EcQwRTnhwvWNjKgcrnOQZJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxsNpwo+t3qDW47YSqdivseP+piVEyn8VxYzFKHN6oM=;
 b=ctcLjudoBdxQ0e7FkOzfeFFbXBWmuJNqwAVyFmulSk9hVP6Zbt0Bsl668fcktUq6iKVQUf/8pbT3NSNdjpax39QTjofOwgxWFQLuWotuWWLx5nfX+kVXxyyYY8GfR38hJ4xSRH11Xf20GKJ0LbeFyNM06R7UL4UGqDMAYM9+yB5dN+9VBLwI3Dt3lFyV92vClmE5JVh3LswRnfimx4xU/Th7i3LRf3YZDd6DnncBGVbC/9IK6n8F1zx9gQgbr49wWuvEYqZMykA+UO62+zXMDkdultrNywzOIY1r2qQTY8hE/z+ZDQXkHlv1ta+6H7kG37gcxGfiUNzirYYyeJwq2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxsNpwo+t3qDW47YSqdivseP+piVEyn8VxYzFKHN6oM=;
 b=wBLIMmF8Y/Ox/NWKG1Ag1PvfKjC+0H6aZl93UU6DP/SxtTQrdEM0zCwggu1f2QUbq3a9/SkUHdLLbNm7dDssWk1Ymgrnz/tC8f7MkSogZxR9t4B5b6A8pD0SmCh7XxpmCMj/btbDnwv1FbZcDanYAkniKfQWnzz7iDJxUnnHAac=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1353.namprd12.prod.outlook.com (2603:10b6:3:76::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Sat, 3 Jul
 2021 00:25:24 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257%4]) with mapi id 15.20.4287.023; Sat, 3 Jul 2021
 00:25:24 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: Add I2C quirk table to Aldebaran
Date: Fri,  2 Jul 2021 20:25:08 -0400
Message-Id: <20210703002509.59476-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: YT1PR01CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::7) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.84.11) by
 YT1PR01CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.23 via Frontend Transport; Sat, 3 Jul 2021 00:25:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73619683-95f7-4fa2-fab3-08d93db90cf7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13533D2B65E82DD8491ECAC6991E9@DM5PR12MB1353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:93;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VL440rkGRq0eNUAuJwz+nyYBK6+jylkH3no7zTJPplIU+Ahf6wA0Nd5gZEA/QhFgEsWyPbf+vmjkqdZdBUFbRZ8v/ZzpUiISTGS8Q9jQ0dVJ/1u69cBEfZer9SGHadVYSbCOaCiAa3lN+ZMDY8QBwYXwfOIGDFSawrc8QWQvzKIY5lijak+ynifyYNAsDMen9XcvMVUCNB77ez1uTN7hVcFCXiAUWzF/Z5zr+Yl6wbY4B4BhagzllA2ty+WzuoMiFHeYYlsBSaoyWY4OblSgJGDD2qk2+O3HVYQa7i9kax3SQ/lLOMqdq6xWm5yUmgP/iMzmFP1sjlMoRKBIud8QUhaQr9WL6vDxvtcyifktdm0If5Z+uOpo922APU+bOfiRAurzJzex7BZDJjGPMj7dSIh78UeZUfVQIA71jc4OY+xLyPRf0YS5WuT8b2LveDmI9ujXc2qRn6SuAHThvizNNrTR78XA/NNujIcJ1VaagV8NtvKG4/A7RAwIlp+sQHCgQh8gnmzUdCGWWYKDOnTlzVFqq/8Ozj9oP1kUBIH1qhNQrSKH3hJ1S3H/cEZSusfCgfX5GwobrMnLuh+0KAcKiGAx/9/SLqQwUJtowiRbWuxseJRkv0+om0eLdAlaxYIjzK2bdIwL/zp1fc5/3sqJSCOCAfZhKbwIH5j+Goo+PtorYm5eCLbHnrYn0Xt1mZqpCw0CPsIhdBX/hwCzDJ00Kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(2906002)(956004)(5660300002)(316002)(44832011)(8936002)(66946007)(6916009)(36756003)(54906003)(8676002)(4326008)(2616005)(66476007)(66556008)(52116002)(1076003)(6486002)(16526019)(186003)(26005)(38100700002)(38350700002)(86362001)(478600001)(6666004)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OBA7qPkqQgqji5UfdNpgdhZNqNq6NFvwZ5O7lV4GeS6oxEhXi7YaKbBE8AiZ?=
 =?us-ascii?Q?PRwAbqcmYeKkD+ZVlAkqcMHul0H5FG+2XWdHHrUkuUdg84ihxLUSCZnyktZf?=
 =?us-ascii?Q?ckpd2djm1T39V5p66RmPHqz8RosIQeJ98rAQCwzdbNm4ifqtJwJyaXHHhEwE?=
 =?us-ascii?Q?mzgKyhlRheQQd0RHfugVBoAo2LSkqstpJGYtejL7MYtWfWAfA/SCUbiuSsvt?=
 =?us-ascii?Q?QYyIooTeOPPlStgQOlM2oO3P/2yQXR9UICYCuEhBlRQL11pR9iCbhlhRlt6R?=
 =?us-ascii?Q?dJagnyS9D0vaicsgYjnfZOmhCM31kkGXtVfZUseHhJSvf8/lzGL2BreAlNfz?=
 =?us-ascii?Q?2LlmzSOlpMiDb/5HeOuSoHYgp91guwG957TrQIHUuQLq1HnsBlLw6+JvbHqZ?=
 =?us-ascii?Q?89KLK7ihUGNKwD2j7qKxXI2qfWfN7sxpLVA3hTbNA2QTpyV0sGw5MegRpPtX?=
 =?us-ascii?Q?bVUvJ4Y2tz+sWQ9nLobbtIwwYmPuNWVvOqGK4SMJK6FgaVBxn+wzsYL8V/Sd?=
 =?us-ascii?Q?HCSOF/F/fhHejAr2QmEESX6nu8DKUyjqaV1ZuHu7+SSKTVNgDBbDrPifjJdz?=
 =?us-ascii?Q?1/y3xCQ6bJJB3rpg8V7XZMQhdtooBioQjFRYjQQfqtKrL40S8Vinjus3WB4q?=
 =?us-ascii?Q?+ohcxs0raBWPJWySLsOWoW94q6bqQG3hLkz3wG6d1iNWIKMClnLomq7FKNEX?=
 =?us-ascii?Q?jbr+V0CgAP9L1fWNUoEMuEG/tNd6iXU2j0ylEljQAdWe3wqKhilBUDn0DVrY?=
 =?us-ascii?Q?AHOI6Fk3131fIhDeIVwFKJ97ra+wbYLI/UuQjtdaLAFEcPPjNvEI4RL2BiYq?=
 =?us-ascii?Q?vhNZHAzjzYHwV4Vz03V4Kd1sdQA/3EyGrpoehUk5tMEzamFsuA6DJ2CtX4r0?=
 =?us-ascii?Q?3WObYLenEZLHUJZ9I5U/yKeXt0P5w53fpXZ+OJFW+eSvW/lskE3UcpopVTtP?=
 =?us-ascii?Q?yXu++IG7Qn4FukccjSwYIvwGU6f6LQ5jG3jN4M9Dk2Ii3o4ztlNZqKzEnTnk?=
 =?us-ascii?Q?IkYcNMzguNeScZkesMtOtTwwIP5rR1cupC7EGmAcr/9IcTBPGyKcvZ/oFys8?=
 =?us-ascii?Q?myi2xcJMW8R+PKjM8+/3WxxBmVoTUh6rCRS+WX4P4SzUFK7qxhf08/pLa4Dk?=
 =?us-ascii?Q?rWyyjE6t/ZedbkUiiZFLOtK2pTsYKo2HzQLXeyHxhUL35yO8hHav4aWyPMv4?=
 =?us-ascii?Q?gvFNlGjWn9HWECd+nDmN7tQKtF9Z3yVqRX2oq4C2D2tSzt5BmVl39sVEaZEH?=
 =?us-ascii?Q?JYGBHLbcy9g91SdtrTTbvjacCuGHPSZN5mXwd2cDQ0ek4oStmZQNcBO9zrCn?=
 =?us-ascii?Q?N5pJzG/k8qLVKWvbJR/xYLbE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73619683-95f7-4fa2-fab3-08d93db90cf7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2021 00:25:24.8156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1Hb30WPdUIBdambbMW3Y3u1FpS15SIkxKI3s8/iYz0HoLMkalwjuJDdaFq4AFTA
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

Add I2C quirk table to Aldebaran.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index f30edf862b86d1..c1c7aefa9d8fdc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1509,6 +1509,14 @@ static const struct i2c_algorithm aldebaran_i2c_algo = {
 	.functionality = aldebaran_i2c_func,
 };
 
+static const struct i2c_adapter_quirks aldebaran_i2c_control_quirks = {
+	.flags = I2C_AQ_COMB | I2C_AQ_COMB_SAME_ADDR,
+	.max_read_len  = MAX_SW_I2C_COMMANDS,
+	.max_write_len = MAX_SW_I2C_COMMANDS,
+	.max_comb_1st_msg_len = 2,
+	.max_comb_2nd_msg_len = MAX_SW_I2C_COMMANDS - 2,
+};
+
 static int aldebaran_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
@@ -1519,6 +1527,7 @@ static int aldebaran_i2c_control_init(struct smu_context *smu, struct i2c_adapte
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &aldebaran_i2c_algo;
 	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
+	control->quirks = &aldebaran_i2c_control_quirks;
 
 	res = i2c_add_adapter(control);
 	if (res)

base-commit: 81dfdb3e6a907ced8f915da3c65632f7a1616985
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
