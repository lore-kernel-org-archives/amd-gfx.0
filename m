Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB26DC49EA5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B040A6054E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B040A6054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 386726E2D1;
	Mon, 21 Jun 2021 17:13:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 907336E270
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:13:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oa8H/CMGFKPN15k/wqG5rDg+su0ufaaRL8Far0gkl+FAh+JQncf8TU0jUxV741nyxToxel5a3SZl8TyCs17FYzGR1FELluzlvEPwNVagER2CbYng1DXz734Z1XoWAEjriPelWo/WIg1OMWwkSWd41hTi/2xEmEYXMI1dTAUGI5m4aQziUoqki55Qg9/U2vdpe6GTNc+OM83eVww1XwXleXu+SU6RVnPWfBr/2XYP8/72FQ2BBKoz9krRkbWwT6HNHW0X/cygSKzKPTQScnS44zfCmYNKRPeir+rAv8RrH/Dj3mAqT3C00Ey19nwWbWx0XKNHu1wBBoFuLP74yUBkPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BI5pagSReQ6MoUK4JmqoFu+bkHO8+U9ibmDAGORYxQ=;
 b=ZGc9zKlWPPMtdJrSUxeX10PxU8JgYrPRWbBxh+nKoioBUf8nMW8frLnlcQg6H+zjGFHFbiy+cG3dKqr3pupLcjYsVjvY1fpDhCw/idXy+KebqW5nxirNe/S/OyzPIBVjbx+jQkfk8W62g1mrClTDxC3C4YHu/vnbxX4+s10obRJHxP3/2d23+f9LiVcOz+Qs2yJ8Zuy24UsUrNw4RFvqs0EPCUCKdaQJ4qb91o+n4Oq6BzqgGkl9dHMJ7xuAQl8liIzm30znK7Qge/t65GSTvVKQBuYvrARE5qnAz4Ebo0qB+Ly3YTaHJhMOlYmaJskFIoy0w281o4cTMZfJQNFYnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BI5pagSReQ6MoUK4JmqoFu+bkHO8+U9ibmDAGORYxQ=;
 b=mU+Gm9F8do00mbBma0ZnEg7TarVhwYW6i7UAmOuW0Ou/vM9gYougUZyETTC3d5sgB0RtGMJMaJ/u8JHba3Shokr84/beItkeg7SiLTEFV9Ra3YhWFKpCj4HQkX4skM95wHrQMUDzf1zzVE+RsZj99lTN2TMdwtcooT9ZE2YQyAM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2985.namprd12.prod.outlook.com (2603:10b6:5:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 17:13:36 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:13:36 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 40/43] drm/amdgpu: RAS EEPROM table is now in debugfs
Date: Mon, 21 Jun 2021 13:12:18 -0400
Message-Id: <20210621171221.5720-41-luben.tuikov@amd.com>
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
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:13:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e38c4e92-9663-4af4-2dab-08d934d7d659
X-MS-TrafficTypeDiagnostic: DM6PR12MB2985:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2985272493E1D10EC7B0C29D990A9@DM6PR12MB2985.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:352;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GzTul1tYttnpcJKVjrQH9MoYbQ4QXyc5E8lL7R0qN/hnu8oC2VGdXpV4Ks+IrJgqKzI6RN968EftZJSciL/fJLB9n/sLbFHCYpKwhRy87sgb3SzPYgizIAPx4mLTcss8QHS2xOy6c0i5JWqpqcG2g4tagTFwW71kCEP2pZN2PXZ83xVi3Ye1emKHmsgVG27dBypPFMkB0zmwlsAP+aSZDMaMM5UHTXiipMt4PBfbew6T4IkE07yS+y0P5UG+jrvIdVrGb8NiVkSzatkQyTXEMeSLJFuwHAv5kU7mWu22lt5ekhnrkWKwNc6iVbRgbHZ2dzzfsfiVhb23iR0PaABBTJp9ICcGt84K6k7y8J7nyB7zsWLDu+aWN+kQ/CTK1vn/XJunqa6BtuplRPJOcNa2wHZVh1rt1vqcovzgk2E/GV91QGOlmWUWMAcYBcygMNXnSha1S3K3CvA2Ax2TUDXoel3jXd0Y3x4Pxz/088E6SwG4L0MBJ67ql/tb+irwIxNNUTKhP6hYXFsletB6gwUi9tJH77tfbKuKXQZjDAh7fHpS//oEFXy0F3TZrc+UmeD5QPAj5C07GAKIjCTJf7/Erm4xH569voOWwrJ6RTxQcqdE9PcJD9/Cz8QGlJeGzScMSJ7+et2CwWJfBW+7ddqIftaNs7mGTDsN9SGmW4m+5xorp2tU8mqf2Ju2N+Gr9u0x
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(6666004)(55236004)(8676002)(316002)(6506007)(6486002)(54906003)(44832011)(8936002)(478600001)(66476007)(66946007)(956004)(2616005)(6512007)(66556008)(2906002)(52116002)(36756003)(30864003)(38100700002)(38350700002)(86362001)(5660300002)(186003)(4326008)(1076003)(83380400001)(26005)(16526019)(6916009)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cQKWb/lRyDOkBcnLSyZgrljhnP3Cw96aBtphvHV7lYDM5tLU6U/RA2mXfV5H?=
 =?us-ascii?Q?OOTCtW9h/4bWoO6w+jc8gcMeH/bHDdJ8aKPIhXm2QEFH1OahlY9BlnbTPww/?=
 =?us-ascii?Q?ybOa9+4HeiSFHIQUd02OPT76J6git1vmtKaEr1b/WONBwNbXd0PR/l/yd/99?=
 =?us-ascii?Q?fseISFbKcNYkGspppAZFYP7p9lf7df2tVW/UPBNMaCZEaQ+OUUQDVokqgOPK?=
 =?us-ascii?Q?HAJYJzJLl3oMUYgtoCZMqIji7WhiXrp05Ss46rfJKMa0cUegVFyv64n3J+20?=
 =?us-ascii?Q?RZh2vjpDnDn1gEpiaiKDYHad57w9pgjn1PtulOuLXB8SoAjhIYx6Ml8eZgd3?=
 =?us-ascii?Q?V1aasQoqXh8MzyTAfgyzmtQdAXoTAxVJyMS07P5ImC2m+T5QJ8iLXL7ncAZj?=
 =?us-ascii?Q?WiImwkNBN/C7tbdMFlXtHx07rqVesMyMFss3/pfvYN88vTIzwzDUnlYvVnox?=
 =?us-ascii?Q?8n0Ue73zLchVWpFtIF7RGyCqlDLFBKJyQ77UKFQzzx0kV09O9mxKJ1BMPpxi?=
 =?us-ascii?Q?kkbwAJOJX6Fzh1y6lYxNUE7YIJx0duYt4CttciQuK28bZjTFwSEUqgocAsCM?=
 =?us-ascii?Q?ETytlUIyzSsBG3XWpdDSqAu0rUzlmDzr9s2BZy9KWJjjzIZ2iMpERNe/C0lW?=
 =?us-ascii?Q?vlQCfo5kbGVlb+k10OjCu0cyKc9RQbujuMUOkm5j7+r+u7iSeE+gMBX42LX5?=
 =?us-ascii?Q?H6FsfiP++KQQ0W2TOoeFICxMA6DJ0YOJB7yMJqP/dghcG3O35FMbBQ5t24My?=
 =?us-ascii?Q?SVITJGcQwwxb6HgJ7T1U2zORwU6bSdG5wyavkC/nYcWMhwGIT0CWmPblvjuD?=
 =?us-ascii?Q?lr1onT8e40boCjdmUHFIEDMKokyp+uYS8MELbcH4ealf0fZ2gUkb4EmpBZtF?=
 =?us-ascii?Q?SIKuqp9vYEUYzrSZ6gBWUkq6jTuYXslVwxcHh7VCWR4Zimn+CWFcKr4D6fRk?=
 =?us-ascii?Q?IQiGc/t9LeXIUpKREfwi336pUFd0HHWMMQRRBB9B2B2VTN+XcDPmjHvXFtkE?=
 =?us-ascii?Q?Xkz9LNR9k5zkN5rAcy24xkfjTsGRH6BeuNse60go/j8pe5E/xd8jZDra0L+H?=
 =?us-ascii?Q?4XNDfvtpstVCRWU2Y5FFtXAhG3Q0jQiBAvmsiNjBd0SHcarPIGjSEt4jJ/UO?=
 =?us-ascii?Q?3H+qbQ9HtIrlKF8Itu6pifh34GsVRmSCjRF77NIBBvBbCagOy0TSbDfCBMpO?=
 =?us-ascii?Q?ZFOx4xm+JgB+xPDpPGWEi3XKCAKlL8CIRlwHbI97tJHiS7eKmfkgASOOzoKN?=
 =?us-ascii?Q?0al8iIHFb0RmzQRWaWGV7sjZ/KcNOpeVn/kP8ZgiD7XnXgMkn1nYTuUPjwnB?=
 =?us-ascii?Q?JMLsNwJ6unXALiYnTl/QHMRq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38c4e92-9663-4af4-2dab-08d934d7d659
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:13:06.9606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/yHFz9OiFqjUFhEe8ZOL3jeDaOnokU/zMMxsso7p2FOHETV8vchu73AbA61jqR4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2985
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
index f15f8ab5b9affb..edf4c02d075f48 100644
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
index e26af82ea63a44..f95fc61b30219c 100644
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
