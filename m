Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE43C48BE8
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9417F611EE
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9417F611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D19096E15A;
	Mon, 14 Jun 2021 17:47:51 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2072.outbound.protection.outlook.com [40.107.96.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F35326E150
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:47:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtIi3SysNEPA+eplO+Z6rNhTsAV9ef8fSbk9z3t3WdaN5sKneRMifp3qaYurW9ZjhGEZ0Z3LMPTr8qpoVMXGN3k4i36di2WycoX//iq9vsFD0jZDOhuS9f1Uk4CiF/wxpv1p1xQGl4OH18QDeoEu4A0G38x5QoZuAtX3Gs5TVOkVQnQhUwMKrbUHhaJE6GUzZfzMrENd9C/XgN4jRNlS/IPQGN2D562J7hz/ieRf+kbkLHuOJnI3vy9TQyauCx19hHbbPqUCWPLn0DurcxVkcdj+CvCp3Q6mzLKystM8FiAmX6KTjJkEbUnr4aLhelvtdLg+juHnGBAKzKmw+3EccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XitBSYXl5PKCyFZcXjph5orUozSBWI8OzGoZCSo3tvo=;
 b=lugUrKYEpy231vDQXKrM7tg3qcF71K0FWh+oZ4H5xtab5VwXufhmpsFuAsSrVr1/7O2tI+JJLELra1dVebbl2y67A4O2fWX6x4vl4QRG/K3TX68pSD8I0ikkUTSiWUmNLwUcz2RB6D11eYDdUX7OnGERyZ5rnd4uhvoAKqki99xuiXk8YRrcm5Iyq8LdQbXTCBCXKfPIQeI+BCEuu3DCPdAqqvoclIe8cD5+yOavzyPsXm+Mu2d9+RW7t2fbeFDDIt4jD0qejcC0qH96zhvB52aRcT5/bl16789esHpIjrgkggGfKneY4Z1l4wUQc7U/4YBIcbcgsQMdM1IOUZ6lSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XitBSYXl5PKCyFZcXjph5orUozSBWI8OzGoZCSo3tvo=;
 b=4rtMFBIeglKX13LZbxEyfPrmaD/CEihg6Ah0lU6XS4vpg3bm3RU0FqsyDyTgAT69M3hH0TmuBwx9NXXx8sqrDbKEQc+KRWqSeW3nMUSuDHa7SpUeXlX4i6T/tGX0NhGEBXEEKrh1LUcml/tw/YbmLFdmtOX1k7i+L5zVsv/mQC8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.25; Mon, 14 Jun
 2021 17:47:48 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:47:48 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 37/40] drm/amdgpu: RAS EEPROM table is now in debugfs
Date: Mon, 14 Jun 2021 13:46:29 -0400
Message-Id: <20210614174632.20818-38-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:47:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccf8b630-dc3f-4d50-cd34-08d92f5c744f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB435549452278933B385C3DCE99319@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:352;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uOthy4wMM0Yv5n8hBeyXYVKOMc6VS3aKmaimTfXWBuJKaMpDWBKQHGcYPyUU28vcqzZU42hl1zbYF0hUw/k3DCIBbYHyt7ycyqVlRfuw1U5gMbeIFHEgWyOYpjFZM2q87/iQXNSOs8g/a5DZe+VJ3MaS1tIALGDuaaX1PazeyOSJiLc4vKFF/CTUDjcd8iYQhVlaktTRgwD8+g+KEGf9GMzJoZMJGiAzHPMMi4BWb/QwhZVtE0Z+UM+0V4nEsR8S7/QDdQ1PnjiU0FTzKMs7h61CXC/Wth6g5Jm1XJsFztFL18tcVliatFITv3PTQJpsGNAQZwl7mS9knsF4+vbjMoYTrmrytcWfPnUy+jEYQYZ7e1e1apHS+FqEVcfAvb9iVIynvE6hnzTO3/VHujXCkiL1TVpzt0kfX0xbIpdbYnDq0ESC2H42JMI48dZZ7RYBVfABtSWycEB9Q/Jp9NRvWty5YH1E8OjxxwDPbHLy+iI1BCjQRPEYbnrei8m1NVjCo0sA4SjYyO557wOFlIyQF1Mafmp1vhHrapJJ8LUDmQyNW4zyJdJPyNiyCIZ9ChMzqe+gLpGTMvhDbx6OHwAzrq3ulab13QCk68yNQs+uNsr9FbAQdvd7kcvBPjtQoVjsmcO4G/aTS5TFpBIH2WCV2SfMpyLrRGVb92spx/mTB6HdqMqPJUU8mXqYr4p9pDbW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(36756003)(83380400001)(86362001)(38350700002)(16526019)(38100700002)(478600001)(30864003)(8936002)(5660300002)(4326008)(956004)(6512007)(66556008)(66476007)(66946007)(8676002)(316002)(44832011)(54906003)(2616005)(6506007)(2906002)(55236004)(6916009)(6486002)(186003)(1076003)(52116002)(26005)(6666004)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sZDugovDWVaiNrEVVNTF2R+ywlbSEMTwKFwDFbIyTRff3wgwmm14HHuoYUxe?=
 =?us-ascii?Q?kwSyvDd6iyG0b940k+DJYNW2xp183mF7C4anfjfGN/GN45ebyggBSd/Zc9cB?=
 =?us-ascii?Q?bkTCYACeEo1olGs+8rlVKHFD9ZDTelrwYOssLFgHEwDPl6EpAwU8jkxpP8/R?=
 =?us-ascii?Q?uqPGomb8NV1JsheMRB0UVlW8utiNK6QNKVKQLcavH0b3rVeE0wJOij6zif0l?=
 =?us-ascii?Q?0sMtOfeNrGpbcZbxg834GkIs91MFYeMqbgTsNtgUktgcjSP+qpwd/Wk/eC7Z?=
 =?us-ascii?Q?F+C0FcazH+HhX371TJodtNjTQrvj3uEuk59q1n1rhDPUVxSpdpoaqkOz4rR9?=
 =?us-ascii?Q?NC5l/ic5iLTCzUuGD9cmCt3HACqTAmzdaotA7gqgn8ohN9/KqG3s6gelOPf0?=
 =?us-ascii?Q?WsSH77yOYX1ZbSsqY/A+0+XWaoxMJbPYYnLEEGPg3aGgjv0em89XjGfDT7qc?=
 =?us-ascii?Q?sdUi5wkfEQloWmO4cP334qB0wIQvW5BUnEVDc03UsjswWREZ4ilqlOrP1CGa?=
 =?us-ascii?Q?Ji3VE8aImNG3h1gqOkUvS0i746gl9KxT6lS2acIncZVpHhck1rNgiy/Xvity?=
 =?us-ascii?Q?2P98mU6Mkb0/fSy+kQYoBF5AMLz806UNupkTFw9lvU6CwwiH4+J5CT9fiESk?=
 =?us-ascii?Q?57PXIdzVeAykbpVEZ5HQCpHGdy25KkFXk4z3bwKiagJkCjBMT7ilhNRBLbbp?=
 =?us-ascii?Q?qUYaAdRTF3B1B7SHB6wyPbqSlRSiqSK/u0GHMahnAyRKoMrAwttVSWPF873I?=
 =?us-ascii?Q?KLQ2+6jMIbTEtI55VH5jOFpLhNUDK0HWfEitxz+MDPZzAnvXcQzZ3gi0lgKx?=
 =?us-ascii?Q?GbDHDVBbTGDTgRAQy3V/x+6uNiB9WtXt3RL1QF8wacxxbGX69YU0yZAR5PnO?=
 =?us-ascii?Q?NcjOkQ8iYSAbBgBt5MfDmrhyVe3R5eSekSniPiMvi9NYORWT9r9A6b1U9N/9?=
 =?us-ascii?Q?AXAEtez3ep9RLrJb10QE5mdpGqkkP5RYzckKZAfYri1Mko/cNsztXzCkJ3rp?=
 =?us-ascii?Q?V/60YOjU/NVoQR1q1nLA3k7KiF1G64z7sTYn8pjzMYu5PLBrMOU3Ajgr9W3o?=
 =?us-ascii?Q?WMIROmOgzPMf42AvZ7h+ilpz1/1dtHDfOUQlelTb9Wdffjjg+bTWiWEc3E/F?=
 =?us-ascii?Q?jdaI98kMb4S99UI4QE/nk93gIU4lSKUAAAMLgXvOVFu5vRjItLPZhP0OhjnO?=
 =?us-ascii?Q?xrC34/h0P1j/uiLIVKvDGgfO49dkOsZ1tMu0BQC427DZHmaMZRWdGPyQ/pOc?=
 =?us-ascii?Q?Qb2c7ITPpWj2rcR2tk7Zy7VRchNj0Yv2iAhJ5mXS7YXlD47lH/ZkN4H2nl7R?=
 =?us-ascii?Q?AR57eEXo/BI1BX+BOaZTprGW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf8b630-dc3f-4d50-cd34-08d92f5c744f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:47:18.5718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSvm9qW4ft/GvYM21q2LdS2c7IobYNamjlSEtuxYan8CSoPCJrsC3wijR3//Galf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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
 Xinhui Pan <xinhui.pan@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 John Clements <john.clements@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add "ras_eeprom_size" file in debugfs, which
reports the maximum size allocated to the RAS
table in EEROM, as the number of bytes and the
number of records it could store. For instance,

$cat /sys/kernel/debug/dri/0/ras/ras_eeprom_size
262144 bytes or 10921 records
$_

Add "ras_eeprom_table" file in debugfs, which
dumps the RAS table stored EEPROM, in a formatted
way. For instance,

$cat ras_eeprom_table
 Signature    Version  FirstOffs       Size   Checksum
0x414D4452 0x00010000 0x00000014 0x000000EC 0x000000DA
Index  Offset ErrType Bank/CU          TimeStamp      Offs/Addr MemChl MCUMCID    RetiredPage
    0 0x00014      ue    0x00 0x00000000607608DC 0x000000000000   0x00    0x00 0x000000000000
    1 0x0002C      ue    0x00 0x00000000607608DC 0x000000001000   0x00    0x00 0x000000000001
    2 0x00044      ue    0x00 0x00000000607608DC 0x000000002000   0x00    0x00 0x000000000002
    3 0x0005C      ue    0x00 0x00000000607608DC 0x000000003000   0x00    0x00 0x000000000003
    4 0x00074      ue    0x00 0x00000000607608DC 0x000000004000   0x00    0x00 0x000000000004
    5 0x0008C      ue    0x00 0x00000000607608DC 0x000000005000   0x00    0x00 0x000000000005
    6 0x000A4      ue    0x00 0x00000000607608DC 0x000000006000   0x00    0x00 0x000000000006
    7 0x000BC      ue    0x00 0x00000000607608DC 0x000000007000   0x00    0x00 0x000000000007
    8 0x000D4      ue    0x00 0x00000000607608DD 0x000000008000   0x00    0x00 0x000000000008
$_

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Xinhui Pan <xinhui.pan@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |   1 +
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 241 +++++++++++++++++-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  10 +-
 4 files changed, 252 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 37e52cf0ce1d92..28378c7e729608 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -404,9 +404,9 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
 		/* umc ce/ue error injection for a bad page is not allowed */
 		if ((data.head.block == AMDGPU_RAS_BLOCK__UMC) &&
 		    amdgpu_ras_check_bad_page(adev, data.inject.address)) {
-			dev_warn(adev->dev, "RAS WARN: 0x%llx has been marked "
-					"as bad before error injection!\n",
-					data.inject.address);
+			dev_warn(adev->dev, "RAS WARN: inject: 0x%llx has "
+				 "already been marked as bad!\n",
+				 data.inject.address);
 			break;
 		}
 
@@ -1301,6 +1301,12 @@ static struct dentry *amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *
 			   &con->bad_page_cnt_threshold);
 	debugfs_create_x32("ras_hw_enabled", 0444, dir, &adev->ras_hw_enabled);
 	debugfs_create_x32("ras_enabled", 0444, dir, &adev->ras_enabled);
+	debugfs_create_file("ras_eeprom_size", S_IRUGO, dir, adev,
+			    &amdgpu_ras_debugfs_eeprom_size_ops);
+	con->de_ras_eeprom_table = debugfs_create_file("ras_eeprom_table",
+						       S_IRUGO, dir, adev,
+						       &amdgpu_ras_debugfs_eeprom_table_ops);
+	amdgpu_ras_debugfs_set_ret_size(&con->eeprom_control);
 
 	/*
 	 * After one uncorrectable error happens, usually GPU recovery will
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 256cea5d34f2b6..283afd791db107 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -318,6 +318,7 @@ struct amdgpu_ras {
 	/* sysfs */
 	struct device_attribute features_attr;
 	struct bin_attribute badpages_attr;
+	struct dentry *de_ras_eeprom_table;
 	/* block array */
 	struct ras_manager *objs;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index dc4a845a32404c..677e379f5fb5e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -27,6 +27,8 @@
 #include <linux/bits.h>
 #include "atom.h"
 #include "amdgpu_eeprom.h"
+#include <linux/debugfs.h>
+#include <linux/uaccess.h>
 
 #define EEPROM_I2C_MADDR_VEGA20         0x0
 #define EEPROM_I2C_MADDR_ARCTURUS       0x40000
@@ -70,6 +72,13 @@
 #define RAS_OFFSET_TO_INDEX(_C, _O) (((_O) - \
 				      (_C)->ras_record_offset) / RAS_TABLE_RECORD_SIZE)
 
+/* Given a 0-based relative record index, 0, 1, 2, ..., etc., off
+ * of "fri", return the absolute record index off of the end of
+ * the table header.
+ */
+#define RAS_RI_TO_AI(_C, _I) (((_I) + (_C)->ras_fri) % \
+			      (_C)->ras_max_record_count)
+
 #define RAS_NUM_RECS(_tbl_hdr)  (((_tbl_hdr)->tbl_size - \
 				  RAS_TABLE_HEADER_SIZE) / RAS_TABLE_RECORD_SIZE)
 
@@ -77,13 +86,10 @@
 
 static bool __is_ras_eeprom_supported(struct amdgpu_device *adev)
 {
-	if ((adev->asic_type == CHIP_VEGA20) ||
-	    (adev->asic_type == CHIP_ARCTURUS) ||
-	    (adev->asic_type == CHIP_SIENNA_CICHLID) ||
-	    (adev->asic_type == CHIP_ALDEBARAN))
-		return true;
-
-	return false;
+	return  adev->asic_type == CHIP_VEGA20 ||
+		adev->asic_type == CHIP_ARCTURUS ||
+		adev->asic_type == CHIP_SIENNA_CICHLID ||
+		adev->asic_type == CHIP_ALDEBARAN;
 }
 
 static bool __get_eeprom_i2c_addr_arct(struct amdgpu_device *adev,
@@ -258,6 +264,8 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 	control->ras_num_recs = 0;
 	control->ras_fri = 0;
 
+	amdgpu_ras_debugfs_set_ret_size(control);
+
 	mutex_unlock(&control->ras_tbl_mutex);
 
 	return res;
@@ -591,6 +599,8 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
 	res = amdgpu_ras_eeprom_append_table(control, record, num);
 	if (!res)
 		res = amdgpu_ras_eeprom_update_header(control);
+	if (!res)
+		amdgpu_ras_debugfs_set_ret_size(control);
 
 	mutex_unlock(&control->ras_tbl_mutex);
 	return res;
@@ -734,6 +744,223 @@ inline uint32_t amdgpu_ras_eeprom_max_record_count(void)
 	return RAS_MAX_RECORD_COUNT;
 }
 
+static ssize_t
+amdgpu_ras_debugfs_eeprom_size_read(struct file *f, char __user *buf,
+				    size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	struct amdgpu_ras_eeprom_control *control = ras ? &ras->eeprom_control : NULL;
+	u8 data[50];
+	int res;
+
+	if (!size)
+		return size;
+
+	if (!ras || !control) {
+		res = snprintf(data, sizeof(data), "Not supported\n");
+	} else {
+		res = snprintf(data, sizeof(data), "%d bytes or %d records\n",
+			       RAS_TBL_SIZE_BYTES, control->ras_max_record_count);
+	}
+
+	if (*pos >= res)
+		return 0;
+
+	res -= *pos;
+	res = min_t(size_t, res, size);
+
+	if (copy_to_user(buf, &data[*pos], res))
+		return -EINVAL;
+
+	*pos += res;
+
+	return res;
+}
+
+const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops = {
+	.owner = THIS_MODULE,
+	.read = amdgpu_ras_debugfs_eeprom_size_read,
+	.write = NULL,
+	.llseek = default_llseek,
+};
+
+static const char *tbl_hdr_str = " Signature    Version  FirstOffs       Size   Checksum\n";
+static const char *tbl_hdr_fmt = "0x%08X 0x%08X 0x%08X 0x%08X 0x%08X\n";
+#define tbl_hdr_fmt_size (5 * (2+8) + 4 + 1)
+static const char *rec_hdr_str = "Index  Offset ErrType Bank/CU          TimeStamp      Offs/Addr MemChl MCUMCID    RetiredPage\n";
+static const char *rec_hdr_fmt = "%5d 0x%05X %7s    0x%02X 0x%016llX 0x%012llX   0x%02X    0x%02X 0x%012llX\n";
+#define rec_hdr_fmt_size (5 + 1 + 7 + 1 + 7 + 1 + 7 + 1 + 18 + 1 + 14 + 1 + 6 + 1 + 7 + 1 + 14 + 1)
+
+static const char *record_err_type_str[AMDGPU_RAS_EEPROM_ERR_COUNT] = {
+	"ignore",
+	"re",
+	"ue",
+};
+
+static loff_t amdgpu_ras_debugfs_table_size(struct amdgpu_ras_eeprom_control *control)
+{
+	return strlen(tbl_hdr_str) + tbl_hdr_fmt_size +
+		strlen(rec_hdr_str) + rec_hdr_fmt_size * control->ras_num_recs;
+}
+
+void amdgpu_ras_debugfs_set_ret_size(struct amdgpu_ras_eeprom_control *control)
+{
+	struct amdgpu_ras *ras = container_of(control, struct amdgpu_ras,
+					      eeprom_control);
+	struct dentry *de = ras->de_ras_eeprom_table;
+
+	if (de)
+		d_inode(de)->i_size = amdgpu_ras_debugfs_table_size(control);
+}
+
+static ssize_t amdgpu_ras_debugfs_table_read(struct file *f, char __user *buf,
+					     size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	struct amdgpu_ras_eeprom_control *control = &ras->eeprom_control;
+	const size_t orig_size = size;
+	int res = -EINVAL;
+	size_t data_len;
+
+	mutex_lock(&control->ras_tbl_mutex);
+
+	/* We want *pos - data_len > 0, which means there's
+	 * bytes to be printed from data.
+	 */
+	data_len = strlen(tbl_hdr_str);
+	if (*pos < data_len) {
+		data_len -= *pos;
+		data_len = min_t(size_t, data_len, size);
+		if (copy_to_user(buf, &tbl_hdr_str[*pos], data_len))
+			goto Out;
+		buf += data_len;
+		size -= data_len;
+		*pos += data_len;
+	}
+
+	data_len = strlen(tbl_hdr_str) + tbl_hdr_fmt_size;
+	if (*pos < data_len && size > 0) {
+		u8 data[tbl_hdr_fmt_size + 1];
+		loff_t lpos;
+
+		snprintf(data, sizeof(data), tbl_hdr_fmt,
+			 control->tbl_hdr.header,
+			 control->tbl_hdr.version,
+			 control->tbl_hdr.first_rec_offset,
+			 control->tbl_hdr.tbl_size,
+			 control->tbl_hdr.checksum);
+
+		data_len -= *pos;
+		data_len = min_t(size_t, data_len, size);
+		lpos = *pos - strlen(tbl_hdr_str);
+		if (copy_to_user(buf, &data[lpos], data_len))
+			goto Out;
+		buf += data_len;
+		size -= data_len;
+		*pos += data_len;
+	}
+
+	data_len = strlen(tbl_hdr_str) + tbl_hdr_fmt_size + strlen(rec_hdr_str);
+	if (*pos < data_len && size > 0) {
+		loff_t lpos;
+
+		data_len -= *pos;
+		data_len = min_t(size_t, data_len, size);
+		lpos = *pos - strlen(tbl_hdr_str) - tbl_hdr_fmt_size;
+		if (copy_to_user(buf, &rec_hdr_str[lpos], data_len))
+			goto Out;
+		buf += data_len;
+		size -= data_len;
+		*pos += data_len;
+	}
+
+	data_len = amdgpu_ras_debugfs_table_size(control);
+	if (*pos < data_len && size > 0) {
+		u8 dare[RAS_TABLE_RECORD_SIZE];
+		u8 data[rec_hdr_fmt_size + 1];
+		/* Find the starting record index
+		 */
+		int s = (*pos - strlen(tbl_hdr_str) - tbl_hdr_fmt_size -
+			 strlen(rec_hdr_str)) / rec_hdr_fmt_size;
+		int r = (*pos - strlen(tbl_hdr_str) - tbl_hdr_fmt_size -
+			 strlen(rec_hdr_str)) % rec_hdr_fmt_size;
+		struct eeprom_table_record record;
+
+		for ( ; size > 0 && s < control->ras_num_recs; s++) {
+			u32 ai = RAS_RI_TO_AI(control, s);
+			/* Read a single record
+			 */
+			res = __amdgpu_ras_eeprom_read(control, dare, ai, 1);
+			if (res)
+				goto Out;
+			__decode_table_record_from_buf(control, &record, dare);
+			snprintf(data, sizeof(data), rec_hdr_fmt,
+				 s,
+				 RAS_INDEX_TO_OFFSET(control, ai),
+				 record_err_type_str[record.err_type],
+				 record.bank,
+				 record.ts,
+				 record.offset,
+				 record.mem_channel,
+				 record.mcumc_id,
+				 record.retired_page);
+
+			data_len = min_t(size_t, rec_hdr_fmt_size - r, size);
+			if (copy_to_user(buf, &data[r], data_len))
+				return -EINVAL;
+			buf += data_len;
+			size -= data_len;
+			*pos += data_len;
+			r = 0;
+		}
+	}
+	res = 0;
+Out:
+	mutex_unlock(&control->ras_tbl_mutex);
+	return res < 0 ? res : orig_size - size;
+}
+
+static ssize_t
+amdgpu_ras_debugfs_eeprom_table_read(struct file *f, char __user *buf,
+				     size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	struct amdgpu_ras_eeprom_control *control = ras ? &ras->eeprom_control : NULL;
+	u8 data[81];
+	int res;
+
+	if (!size)
+		return size;
+
+	if (!ras || !control) {
+		res = snprintf(data, sizeof(data), "Not supported\n");
+		if (*pos >= res)
+			return 0;
+
+		res -= *pos;
+		res = min_t(size_t, res, size);
+
+		if (copy_to_user(buf, &data[*pos], res))
+			return -EINVAL;
+
+		*pos += res;
+
+		return res;
+	} else {
+		return amdgpu_ras_debugfs_table_read(f, buf, size, pos);
+	}
+}
+
+const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops = {
+	.owner = THIS_MODULE,
+	.read = amdgpu_ras_debugfs_eeprom_table_read,
+	.write = NULL,
+	.llseek = default_llseek,
+};
+
 /**
  * __verify_ras_table_checksum -- verify the RAS EEPROM table checksum
  * @control: pointer to control structure
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index edb0195ea2eb8c..430e08ab3313a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -29,9 +29,10 @@
 struct amdgpu_device;
 
 enum amdgpu_ras_eeprom_err_type {
-	AMDGPU_RAS_EEPROM_ERR_PLACE_HOLDER,
+	AMDGPU_RAS_EEPROM_ERR_NA,
 	AMDGPU_RAS_EEPROM_ERR_RECOVERABLE,
-	AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE
+	AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE,
+	AMDGPU_RAS_EEPROM_ERR_COUNT,
 };
 
 struct amdgpu_ras_eeprom_table_header {
@@ -121,4 +122,9 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
 
 inline uint32_t amdgpu_ras_eeprom_max_record_count(void);
 
+void amdgpu_ras_debugfs_set_ret_size(struct amdgpu_ras_eeprom_control *control);
+
+extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
+extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
+
 #endif // _AMDGPU_RAS_EEPROM_H
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
