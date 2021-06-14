Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E09C47094
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 732F761378
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732F761378
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E93256E0F2;
	Mon, 14 Jun 2021 17:47:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B07346E10B
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:47:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5RS66VrlQSado+FcPkCbFxz3bYO40enAlTftGp8X7s6WA+de/GfBnEi4hP7s/bb7/C/7Vz2LXA+BfNNCdQvbrIjMtiI+WN0BF1jOAglBacVcv4h68kZq5FL+dRTeIJU7kSnTWfqUjDinkAb32XMQpRRC82Cpj4MsfuA33oBThYvSXClYKD72qYvNjouIu4JhQubnauZlj4sSVEQYi4unqYTVPXBCCRreSRoXlrNJBLmQ3/nDS4sO8fmXhGqhNp13W7F1ZY+PlSHgu6fkiyh5v5Jc0VSq1zWQ0kRdHDEE5LnavpmwwtAyJPkCahSuw6zz96JEqzvIEUXPAFqUe8n2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqeq+w58A7v/+2Qw/ffbWMzh0zl4ohs/eNiNhgCAV+U=;
 b=US19/bt6RXyUJT4Kvs9kdFYw8Ou94W2Ijs6xIFfZM8R52WeYc00t/2kntpugwCBIgfASa+g9yZkLSAmZqYKSD7JWkjfXejOqoRUk8GEp/3PcIVzCm9rgQycn8aCL1bUvLmcioiuc4kwqDtp44QDuFxC4JvVAudY++I4Rd6a75FUSHbSOhFojkMImIVsKNHFxkHQG29QQ9cWRsdonYpQftUb32b1blMMyzQua+jipYku6yINKvzdkQptfBboUEtgvM+YluoL92ueIKBetjDmRYd99a7HxA+LAuOsZRgAxJi+rmtY4j8fKCjbCBAwY3SXMrVpg5N+MNgsMAPQivl/zGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqeq+w58A7v/+2Qw/ffbWMzh0zl4ohs/eNiNhgCAV+U=;
 b=w5LG4anrquzmv6ECpZot9BtwXzTUpcfCWkOK97kor2tW+2Fb1ww136UEIUkQUS8RD60mbTZxDgHjl2yDSW21Rs8rR2r9/4h9YNWaKh10RF44fXrPjKTYmBLAhmI1Iasd2/aj3y0SY7EF9Hv5GagCXbWqMnh7+HGuJro980Jkz4o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4748.namprd12.prod.outlook.com (2603:10b6:5:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 17:47:01 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:47:01 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/40] drm/amdgpu: Send STOP for the last byte of msg only
Date: Mon, 14 Jun 2021 13:46:07 -0400
Message-Id: <20210614174632.20818-16-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614174632.20818-1-luben.tuikov@amd.com>
References: <20210614174632.20818-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::32) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:46:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb8449e2-9fe3-4ede-137d-08d92f5c68be
X-MS-TrafficTypeDiagnostic: DM6PR12MB4748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB47481AC4456F56132CC459E699319@DM6PR12MB4748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SK1ufL+sbzpXIejBYcCIiZMwU521Lu9N7TiyhmKNYN/Kwq1VTUKpSZZ49jYuu42P3yKfI54ZyyUlwLVKoMiIqAFpPSE4TxVts/xYdyhNdSljdcUiQfY1N5Mda6du9F2bSro9Ai80R02CIMA3RMrWlac8WYdKBAfaomV2QZ5vnUo/WqHV5C82xMs1FavhFoLeZdc6T7WlBm7ji01iSa9GPROXk1jYatFeDB6eFwk9OMHbr/jT8Q/v3jzV690uw+WRRErAhpWl0DBLG5SmkAJ6Cq6Li12Z917lTmx4mKUfq9zXmjtNkHVrW1ulKEJwQLOR94cW/Y9KnqxG0E4c8PrW4gQ8WDq6kGd5Ru/sHTPrOjmV/8MivIKb5WDIxQTxymuV5qpkSSozFwb4YM3fAOEqviKmlcBNmXm/st9aEA2flThCZ2cUQQA3YTRJOpErBb7r9FxV7hMNjhrob54yD6RzFFpFeZdVLRSP8r2YHbIaFckztag8iSnHKBP2MSEcT8atD7qGh2bVbgV2pZQAKbnwBZytk2uO2fdqyhW4GoCJ4VYXEbvXCSMufNp1qe40g64EQRSutT3JmWHBvRSR5GhPzqKTDm6phUiDsw+SY89Kai9y+CzCkfr2auKTRuNI9JRtPDPS+KY3ZnD74Ar2wf2hVmIeaNcP5m6RtvqE+vGdErH6oFco1RYH43G6woTaaC+H
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(1076003)(26005)(6512007)(16526019)(186003)(4326008)(6666004)(38100700002)(8676002)(54906003)(2616005)(956004)(2906002)(8936002)(66946007)(6916009)(38350700002)(478600001)(83380400001)(6506007)(5660300002)(52116002)(44832011)(86362001)(55236004)(6486002)(66476007)(66556008)(36756003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x3nERs1O54TOKSHPfV7k4qbtdM06ySihcUQ0ZHWcB/T4RXpXxObZZ4GwA8Kl?=
 =?us-ascii?Q?1+Bs6mVW907Nbh2p3DVV2qF7fSFKSZsffut7sjDVG5Fu6uelkU4PmD33vnhj?=
 =?us-ascii?Q?WWFdg61g4KNs+fsxkIU6VuXCSBP9oI5HOAw0VXEF0+VE7d0b5+NJDC+2JlvH?=
 =?us-ascii?Q?7DLyzaJXq4A6a6CWNGxqoIuDuRBcwpqMGFv8J9Fm7CoNiGf789E5GrzezVs6?=
 =?us-ascii?Q?OIdzB3paprdkd2cOOVJM9c+92TirZqyG5HkhENClIL7S82KlOFDMDVt1FHh2?=
 =?us-ascii?Q?KKj2zFVUpqJRc8oyGFRLagturCdJDQQRw4Szxrxcxegd8LlpU7J8bwfvzJpR?=
 =?us-ascii?Q?l/RH9IgEtwfYG1DiQnJUDrCd/QF3j6P4+V67dpyjwaTwoWjvPChjbMLYuTM0?=
 =?us-ascii?Q?+5M/gApljL1RaxkZ3osQ/EnVit1aLD79ERxdEolul/mX53UET5YjdJshxejp?=
 =?us-ascii?Q?dfByf7Ct2pgyxl3mqoteA8c9DZQ6c4BXXY1z1BdoqtyJDgH8M25FKy9MRCkg?=
 =?us-ascii?Q?v35Ons44fMjWLXnog7mimTCQ3xKHuW5XBMGvnfTdyDQh0lWXo4pQBhUZ6I6r?=
 =?us-ascii?Q?FP07BRoMSLfKIY0qQzZ/wSgDD9Z0yWS5YXu+I6ZTBTUjciUJbcp0bL7SPj8U?=
 =?us-ascii?Q?fY5b8PWVHmeUJEgWJEf6ba94tL7IbbXqFFWPopjWLqwavoqzWZ9amVgniNTg?=
 =?us-ascii?Q?u4mtiBv9hiBBj/SLusHINRVzbUkUMA8+zhNhp1VPRd2AYVobeikLlSc3yOZp?=
 =?us-ascii?Q?8NulYMnDNJzb3HiHxHta3gt/7H39RvEzHRWYbh829+T8bzVayHCii8UU5zRb?=
 =?us-ascii?Q?5P95TkuJfv5+tT0akVpFEYUegWGIqoJCR2MQeBWXkUI3Kxag5fZCRciQqhQO?=
 =?us-ascii?Q?bh9LI3yLZS2HnDFYldiLtCmxk5t8UXSVxbVBHTs751bGZ460ZI3EEDsJpgQ8?=
 =?us-ascii?Q?NtZl+iN8tPw85f5Nx5eaED4TO+ghVT75IhzqqkPjW+ziTV8zB7PWfWhH7olb?=
 =?us-ascii?Q?F9FJq0eU3rQC5G3VJB8rQewopzTLk6V7ASizfUI21kn0zmIf2IvaNVuj1qcV?=
 =?us-ascii?Q?9kSU5eUnVcPoGO+TcvnDo41iqHn0GN0hW/K9TguuDgWLwYiQu6Ci3QV2k8Hk?=
 =?us-ascii?Q?uVBOm98Af1D3GGWlvJpLwl/ROdsU/FF6M9rROqb3FSQOj/MkmiEm3YCS3qw8?=
 =?us-ascii?Q?yRPD6tbzVaBGNDnu0yS8s47c7LBdt53fHUQkhEqVQx2rFFb7jPoRdTFXdru6?=
 =?us-ascii?Q?5N8sqqrx/n5nrGVsjdIqTGyL36EEuqTdULSp12ndPLev4NVEW4LjM+jeotii?=
 =?us-ascii?Q?HKhMGENaojm/GV1I+YxAvFUA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8449e2-9fe3-4ede-137d-08d92f5c68be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:46:59.1519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcDFF0VJmRN/2QK7EdRMzo3BuSEs6JYH6WUrJ5Up49tKzF3b6b9A54rTPK5flLrt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4748
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
index dad322f46db3c9..666b090e663894 100644
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
