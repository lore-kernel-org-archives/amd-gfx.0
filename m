Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB57C48BE5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E27BF6054E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27BF6054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 871596E255;
	Mon, 21 Jun 2021 17:12:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1F6A6E237
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+lB51EsOyvzZqOqmq83ZYhF0Shb5RneSzO3h6+vAI/9FkMXABPCfcD1qYchMZRBmTqQK+K9+Ye2uaEEYXEUA86tWUbWfRlJ89JTqzBH4/k610eLVUH6NuBmQutATwPm4qUiUsDdJ/B75yoHpI8ARSjVYRN5TgEe9gRCv8VCwCsGE7lPca7FfY7QNYqID6MhKblFWgucvLQktjW5WOBiI5nadYJuFBXaE+QQigSkvcLb2qYS1e0wcwY0rECJ/DGqgWThH9hVE89dBo/AUGaiv5PezklePmrY64wEs201H7jjhPn2uqdAjFBAUm9/8IP8ZSq6CatXSkqJA1k5JYoV7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uCXWktSju19xhko+Bd/wRgjCWAkqB7t2/6WyOUpxPk=;
 b=FhBo5G6JaPFtYFyk9Mp1j5x1YOB1oZpJRlDNs1DuLnOtOeHnX1tZ+XujUBcpcfxwiBXAC+KVdxJjYFYUu5HNqcErG/pnBkh3hptbS5mwA9ScTdW+EYH3q+d0W6ZjzdglZwmqIfsqBV0GMwx93EqcpTl9bztAkdCFUKUQZgTkej5WSSwEvshjNkhTll/yKgoTvoQPjFhPoYPKGE/Gwj5LTAJ0PGlVEX+mI3FCeo3EbGkPQmv1fG+aTprzHMVVTxTKBnWaxrIZQi36wcZAhj+i0KH4IHtZz5OEm6NOm0bRhnId8vnoso5E293QyqYWZ9lmyVRFskJBlix5/UG2dqRcdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uCXWktSju19xhko+Bd/wRgjCWAkqB7t2/6WyOUpxPk=;
 b=WdqnAQSqBYLJJ5e0tGo7kXCJC3lY+BBrNGczOBViJmOrXpGh/8cwTX8/EUtieokXCPRTGb8pyYHotQU+VAQ5nnR+WIIYnVr+c66vOsoStfwIkifTxR4NpSTIJhQeiwDoMAkWQMA0Ys22kFwsIZoGDwqRlFTzynDR5C4mFKadXE8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 17:12:47 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:12:46 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/43] drm/amdgpu: Send STOP for the last byte of msg only
Date: Mon, 21 Jun 2021 13:11:53 -0400
Message-Id: <20210621171221.5720-16-luben.tuikov@amd.com>
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
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e1c018b-a49d-48a4-77cc-08d934d7c9d1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3865D938BFD8B18B33E96E80990A9@DM6PR12MB3865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y6JGQgagIa6DOBJBo1Dp5FMN8r7H5Yom+Juuc0VeRMjO3RAdrH2IURTxBdMZr0AAnTWbn15FE0fR14uOPcf/2JB8IrAkuS5eu0asISFXo/KhrvTJ+oKcAEhNFzu2FiEEnFkTx+iZVfpwUA/PBWzfDi1Ep1fRfG6ir+bNFeRgelKVirYqskuLUqf/XM/QsG1ToeneVxdshbma0KZqnJOi94BNOz1VdoRvpstGKJuQZhUTar3RZkbo8kxQWc6BLAF+m0lJi8eQtUcbDYZ1TsHRk7Ng/YyU6NNDIz6BBbQUscKmUfmynZDqVDP39LAVZL19u9WQLrS40jxw327Q66mbTdFf9sPz+zxehT0DpW6oyTYYqgoWy60aZZWO7hO36FP3FfnTTfJ2gjexgMrH724XnyWsH91Vk9nvFydSSt5uMEE3OKQdvQ+oUYLDMbzBlu2MDitaBSnz4fcadEAXj7M+lKNDjk4EjRPFXKu4ybk8cBbgVGxzIYThDraJjiZ3n/XO1cyJyldyIwYOF80G6kmoF4KXqVplRpq0z4ApgiLJdTnd+30ujA7kruIiBcdJhHzg778+gZ19C3OJ890b4xH6PBMcZyndheKoj3cxtBpsDK8LSmvyZ+fQw3wIN9caYM2I850TYGnEIJ88Q/Xr369jfIG+8tr/HHDMWtANCn77yY1BfCLlwEjey6hAJzR9MmdC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(478600001)(44832011)(54906003)(52116002)(316002)(66556008)(6916009)(66476007)(66946007)(8676002)(2906002)(5660300002)(956004)(26005)(6512007)(6666004)(83380400001)(1076003)(8936002)(38100700002)(38350700002)(186003)(6486002)(2616005)(16526019)(55236004)(36756003)(86362001)(6506007)(4326008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XvAv+idt7RYTHEp2J0B8TwSvafGUaKTFBPlOiRhVHtgqMy1M/y0SwizFZSKd?=
 =?us-ascii?Q?Fs8kexztagzRJB6ERO4z5lHtxTT+5Ou45Qyq6OPh3m1vUCQa73nTwMG2wEDy?=
 =?us-ascii?Q?W/cmxfT3mwb9I6SyNRbeF8S3OA6Bp9tsDd+Eh1VL5JhApo1oMli2NCcbe+Zl?=
 =?us-ascii?Q?xIlkGXkEfCz4HZoe+7nLEyJb1Gdf3k2mH7bbJej+rqPwQITKOvjfVgupePx+?=
 =?us-ascii?Q?bEFfSAxZ+emwh6fxF1ZCL1Bl5APu1ks+bUoxgmARNTBL6h97l6hL8Oo5ABR9?=
 =?us-ascii?Q?owdz19wPgHDPX3nYbEwXcjwUnIgLKZERR+YBQp5RBwwKNh4H+eg16wS0AtmG?=
 =?us-ascii?Q?cVH2MRt+XisHVzd3G2ocEWZMlIilVVwVJqrAjaYtYfLvI43Zr0ZQC8l6gmzT?=
 =?us-ascii?Q?9iySL6wQcDq1L4u/9mxrqBUjZbYCcTGKBR6rc6C4LwaSGeh+FP1TyhVb6/vt?=
 =?us-ascii?Q?U/AOroVSzQrvIDWhV0AswVJlysrX4+bPyG4ka1zVJFWk+sVD6De+ZOweKXcV?=
 =?us-ascii?Q?tQykw8uEGjouPMjKBG9y8NK13C+j0IGKmLpdexYebXN/ouOqew9uegL/kUDb?=
 =?us-ascii?Q?sHmmchFZo9u75PV5WKKJqQue1+df1cN8bPQYwZPAYR9t90XrtWnpRwQ6adN3?=
 =?us-ascii?Q?AZZ1S3nQtccrLKPTHSOIzH95tGRVovGwYeIqFJPW+laeRBqIFySJfKbtMTHn?=
 =?us-ascii?Q?uAHlJqwzod5zERtPf39HwpYSEhTNeAL5hJJLy17mmhKakYwhkfE6ylEaV3Sl?=
 =?us-ascii?Q?RLvU0jlbnnEVy+hnQe3OhYA+xrOs8hwgySJJ8U/+CTfNH0WRuj3bpmMDIlOu?=
 =?us-ascii?Q?x2dabOilx1s0uJaEYGvnJGRApNomj9tZmZOTy8AUjiGwv4uuQuQ0dJd2ZF3c?=
 =?us-ascii?Q?b5Q2eZGzvw6sWeo6obS12wPZuzRNv5agjZRG0BwhgGRDVrujaD74Puzmboue?=
 =?us-ascii?Q?f2imPtzNajRnao+IoJAdyrq009dpWQ/A9McugfeXoMvABo+/PlBtwLpRvU7k?=
 =?us-ascii?Q?lw10x5gsryG5sM6KzJ+7RiE2f88szXLh0dMV/U91/qpSynfzgUoZ0hSqQMjt?=
 =?us-ascii?Q?DaOg/LNhyq+9ysxG6c4E4GRe50uVW/A+04kf9LqhIzMvE6UmyrckF8967NMr?=
 =?us-ascii?Q?l4xQd5karixxBoRUndrXImcAhnAc5iW6jKrZD5dyEo5bIeAx6avA+jwkOHa2?=
 =?us-ascii?Q?7fvGWDsKJ9Tg7UEBAAI0wbEZ2HoSnczstz938Kj99l4NyQyt3jCUqF+Z1a2b?=
 =?us-ascii?Q?6bC5qnpleBK8Sbzw6W24E2UJYe8vHoURj183DZWwI1mMPCFXY1HQ2FAWnm+V?=
 =?us-ascii?Q?nWjpQM3Z3l998cISF4r0V2Wq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1c018b-a49d-48a4-77cc-08d934d7c9d1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:45.9226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZUcP0on3u5pTG7Bdm1t7FU9hdOpz0G8oABYjV1+rEsdm6ocxzPqDwYImwDZKBer
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

Let's just ignore the I2C_M_STOP hint from upper
layer for SMU I2C code as there is no clean
mapping between single per I2C message STOP flag
at the kernel I2C layer and the SMU, per each byte
STOP flag. We will just by default set it at the
end of the SMU I2C message.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Suggested-by: Lazar Lijo <Lijo.Lazar@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index a6d6ea1ef9e31b..fde03bb6ffe7c8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1981,9 +1981,9 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
 				cmd->CmdConfig |= I2C_CMD_WRITE;
 				cmd->RegisterAddr = msg->buf[j];
 			}
-			if ((msg[i].flags & I2C_M_STOP) ||
-			    (!remaining_bytes))
+			if (!remaining_bytes)
 				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
+
 			if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
 				cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
 		}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index e682bbd3c26d82..8bd3fa2ef7efea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2780,9 +2780,9 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
 				cmd->CmdConfig |= I2C_CMD_WRITE;
 				cmd->RegisterAddr = msg->buf[j];
 			}
-			if ((msg[i].flags & I2C_M_STOP) ||
-			    (!remaining_bytes))
+			if (!remaining_bytes)
 				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
+
 			if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
 				cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
 		}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 93acf3f869227a..7c266420e31cc7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3487,9 +3487,9 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
 				cmd->CmdConfig |= CMDCONFIG_READWRITE_MASK;
 				cmd->ReadWriteData = msg->buf[j];
 			}
-			if ((msg[i].flags & I2C_M_STOP) ||
-			    (!remaining_bytes))
+			if (!remaining_bytes)
 				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
+
 			if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
 				cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
 		}
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
