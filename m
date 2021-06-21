Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B6AC49EA2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F256054E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F256054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08E176E221;
	Mon, 21 Jun 2021 17:12:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64B896E221
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itQd/uFXzPHGfvrXTnfuOcO6wT6WiW0J1ms5HHkp5lWimxM+5y9xs3MoqSXUFNpcZAf9YUj09LMemakiYiF6Cv0txM6ghlSSNUufxjyG0KLuh85xuz8RJIC6IdS5Zm/fp5n04Glt7y5/JQiqXCVmn58cf7Omzj03Rq9puwGGn5pS4xcgY9EZWtrwtmmt/eOs6r9TueBXKM8UOu6Crp5OsJ604tUi0JG3GbyIfmbCV1NAjsjC+UexKMVQNGKTCTZfwDEssXhTiCI6Q4Oz+VqWOQzKevUukuEFSblCXlvpJhLAAOG0RRNMODgzjdTPbE1Ggf/JEMbxnzukY4B5OIuBWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vv43ah7eShxf00NzwZ1rqq118/UOJoFxAikJQH5VzIA=;
 b=O/4XDT5py76TZbtLoNCa6MeAysn1LBag1X035YzDq+3089Uq9vUFoI1f73L8oeu0QCxjyxJ8utEpA5cPCZtziUCImncEEZPQGc8LOOTpY5bgJStuUtnn2QiFlC8J/O5DuWMoe+zaYAwKU+nIQ/HJKpNg92RPxGkGOyfN4ZhWj09LtIpjzvE4gbTNjP25qzHc6d2Ri32HIVg+2G32do952I/TxoZt77WGaQI2PjQLeqpx36HnTLYd3XXZhLuVLzvdGLwtOw4vwlYd2Q2nEenyM5I+AhBiHlZqgyXhk9/sxDiTfR6h0IcYFW1nTFyhpMuodB5j4hA/ixy2uqr4YxMhcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vv43ah7eShxf00NzwZ1rqq118/UOJoFxAikJQH5VzIA=;
 b=GErAxaXjUZdq8+lROeRmXkRzgDo0kHw8uN8iXPodiONpzQZlbBv/owbk6ttYYAVH2ljMl1iXM0kxUyfkaUolMSx2hAVTrKNg5uG/e8XUIa/sbyuyI/5JpBr5n1AACUKEehzrVVxdewpqwzkt4uhqxSHZoIaq7QsyCHmHDbZpkFw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 17:12:44 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:12:44 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/43] dmr/amdgpu: Add RESTART handling also to smu_v11_0_i2c
 (VG20)
Date: Mon, 21 Jun 2021 13:11:51 -0400
Message-Id: <20210621171221.5720-14-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621171221.5720-1-luben.tuikov@amd.com>
References: <20210621171221.5720-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::23) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d14303c-506f-4d9d-5afa-08d934d7c881
X-MS-TrafficTypeDiagnostic: DM6PR12MB3865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3865C267C5A6B481126F3780990A9@DM6PR12MB3865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1LYiikb6xYAFIB8KPUWTL9VLxs4oPPSGI0K6MeTWcwNZqM8RrgBLsegPTI4aMLh0VrQrIbTvhNuz+wsHnxsMHx8Xcxkf1L2Fv7XxI/II+BVI+fi/TGyqlY25yCyi1EtQ04uyxlK8SXwnjuKDsG1XckOi1NxxNuBCSqbYVS1+cLrC1BdVs2X0tYLdXKOyJYrGVwTji7Xf7TMTIE+X2YWL1f+KEJRFjqWXvHw27f0SZzw1xVI8l2/RUGt8/2n+NM++Of9uLaXURTLvAPlVu9jEvqAfEmo1AJljYelSjQLtdExQ9UC6Q5GvmiDLcR76jOtF+nU4+ZLXNnLBI3Nhgv/V9a7t8LzSLpFYHZFnAY1fhLvakH33VMiViRayzIweMMECbEV42g1hBQ1a/jL+dVpsVoqE+FXM0YfvTpQuyDCoc2GNX2pSvhdu1Y/r+fzCj+U7vUU/9iIezFGzdT31P4Aaj9rOW6Avy9JIkiC8kgwdQ9kCvIDYx8glZEBbJNvCCTJ51zewTdRgCuRXGqzPBpGtEsZFJpjtOaE/uDg/clp989FXN1MoyE9j/gsW+xOoY5esjTs+CNetrcL0UobLXdVBVhswE9qUwAeY8Fib63yVjTHfkMKX4ltJQ15akM7yPGvTLE6/Qn4yA5nN56HqBU9FFie4Q/VfNy8CfR8RPWp7faFP2HmWZezZYYoE9gkKfIb9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(478600001)(44832011)(54906003)(52116002)(316002)(66556008)(6916009)(66476007)(66946007)(8676002)(2906002)(5660300002)(956004)(26005)(6512007)(6666004)(83380400001)(1076003)(8936002)(38100700002)(38350700002)(186003)(6486002)(2616005)(16526019)(55236004)(36756003)(86362001)(6506007)(4326008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qHRHnwzjLYzj5pVetusf4Sdm0lsK34R7CilUmpZmIic4KpdoK+8gcDU4D0Uc?=
 =?us-ascii?Q?F4U2zc+BmXNI0Od5pWEae8u6dG+xdk1P0t9i/KFBuynOVAGvjyqXY03KWQlS?=
 =?us-ascii?Q?9dDwkAKlqirdRI6fVHIpQOd38zLebmSQzKjKmZM0NtML1cGOIoaUbPuh3UD8?=
 =?us-ascii?Q?6AiW8zttcebHmFkVdEQny7YRcEgsS10uvC0SXmUJiVUQJzs8OyQjgvLAbAeg?=
 =?us-ascii?Q?Owoltrmzvuo8cj1smriifXc65LzzAP5cowZ7Y+TbXe94929BrVOgmn3jjuBF?=
 =?us-ascii?Q?u9pmiMEvIepUfNOZfuDDcNhX5XKjYv0RE/ruNRBAgEzh8axKqC+slQ7X7vX2?=
 =?us-ascii?Q?V/cql50V2K233hJsmhexqdCarZgns7Zr1TZv0QVhhPwdBNlPT0zMTXt0uGev?=
 =?us-ascii?Q?Y2/FtNOyYUpIxzxNcl9MSY09CvZ5nGtaD+++6qZyawwOya0BlWJO8Jznr4xN?=
 =?us-ascii?Q?m5QrrXL5l9WsrLGfrQ8GF41rQvr1d7v8IXc4Sfo/SuCs5x+RTwY/XLHb7w+o?=
 =?us-ascii?Q?bJCeFCy1wpdbBNQ1LjfFJtpNqLbwhLhCn0uVAjfLyVTPovWuG6yOvmQKbWWn?=
 =?us-ascii?Q?dRgd3ESy7RYcHoftapzzGX60xGQSz1WNIhyBNXpe3AuRNHHQUTuw0dk3t2Ft?=
 =?us-ascii?Q?FXCYvZ1cqvrag0iuDJkprm2WQeMYQ3Y7c4doioZ59r2IzXSnSxJiIC5LxZpO?=
 =?us-ascii?Q?a/26iVkBe/JEjpvv4L3gcR1BLOEVRU+srLP4IAGqkuyxz5sXqoHlQEzovSZ7?=
 =?us-ascii?Q?mKMjEe1ZZOI8zweLr9D3MBnBobTLTH6w3IOxYObqpLilu9L6b4Jmst7KIr+A?=
 =?us-ascii?Q?yae9Rn1vkKUR1wIplJ4zhlcFxEkd/bHcSMOmd+lXm++0D78qTFroERVeC5pK?=
 =?us-ascii?Q?+q+p3zbdykwZx98JlQg9jeUhfEN6l3g1yjG9LDHtE5sWA6Lf2knrwAq/XsPG?=
 =?us-ascii?Q?jUG3Hwn5cFLAwgH8p+3Nsd/NguOGbg6fgEBB+3H67x+NVoI+birNvcmFwYd0?=
 =?us-ascii?Q?CclddON1q6PeFpXAWNR75rXEvKJZ2AQxXki6vvwYgBSoJOVKjtpXQQDYOJLD?=
 =?us-ascii?Q?ZyR6DfvrW6YGq7AZSSwzNih1/58paO+Ny9dsFgFsohEo6QhIQ2+zid+atcCa?=
 =?us-ascii?Q?x+bjCAFIK64XE2/9xRoFXCtRI5T1600iCkrAFSuvvvAT7oapL54z0aibegHC?=
 =?us-ascii?Q?+JxLs4OPsHW6Yldvh96LOogqt0oPxxDmbajP9MhJfM2eZLS5YcOR9ZAYZ5IF?=
 =?us-ascii?Q?NCPPz6cfGShwAIM9l2aD1qkRJQifwE6PYa6M3atdzWyvjAdnEev8+Ab+v+KH?=
 =?us-ascii?Q?QjxCJW/S0wU/OFZbliNDx1nR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d14303c-506f-4d9d-5afa-08d934d7c881
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:43.7678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szJ3eKx3IrZjd0fDdjSOLzDUGoJGWQs4I7IpIlmypJq3ERR6s7Hxm217y2spmN5u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3865
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
Acked-by: Alexander Deucher <Alexander.Deucher@amd.com>
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
