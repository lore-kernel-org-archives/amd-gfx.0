Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1C0C43460
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 12:56:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AF75613B7
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 12:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF75613B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 735DF89D84;
	Tue, 13 Apr 2021 12:56:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5B5989D4D
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 12:56:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbKCj3e+9jpS9gHVVYB23o76LxCrDknS9SXPIzJ0rjrLFE13+Ef8AF1aHj/yVNMLrKshs0GcxV6zWHxMToU98RecHoSL+XH4FWv/v6xrcjrFHi4YhhRGdxoK/RyvAHnbosV9ihsJz+HyNXQ0KzmToKrrJ80wS64hqFc63HK1I5Ee0i4MWszkTYWvyfDCusRiZw9NdUPhVkwTXFuxW9+eT50UKeMBG9zEqRJ+TtGk2WdIvDF+kQGgsf8al3uLcZQVVF/gC8FPF5m4vYPkYoeLzf2tpSburOv6CqgZd3VLHQGtgDhAyelTO3otm++NEsAwNisd2ysBc2NGKSwLRezqFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mne+p415dvjlxzSNlsyChGRHB4uGrUKdJUV6QQZ2fiE=;
 b=A8fSoP+p/yrCDc0BlVzLB6VwsWq+dZx2GVd2cHnuWwZIlNN/RzOANv4uWwkyJoK/a/Q3v6RJRnB8PlMy+XouGWQ5t1RLroBgQPcj73StXZKtlX4qKu4r7i6vxznZDiOfLG+iMxVsz10lmoCDh++J+liKHnUsamwpawHkCa042GFbHYuJmrbLJYAJwKBi2N8BMSjbzA42Y1o1B/wahnxv53Epwo0udDDEevYJw4md5nRHdp5mcyIaluRwXAX4yhwx/b1XvREL1tLx0FO+yv3txEyv3hZe+Pu8QoC0Iv262ld4jgZCGd6dQxWuTAeprf9tnsy8PymGJgSTbERxvFMFKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mne+p415dvjlxzSNlsyChGRHB4uGrUKdJUV6QQZ2fiE=;
 b=gd0t+CcpLog1NrkNe/fW1uwRip8qhJQiTTT+lLIAesmpRwwh2vFqRXZVFk6uUJNJG23MMbHN//JLYszrroNQ0wKpR6EaBTsPaXX0507OpjMnP2oUgGVWJqfvkpL59Sc3SbJVpqrWYQvGDSG93LZ/7oZBoAdmpj7ggvDgp1KNGFg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1836.namprd12.prod.outlook.com (2603:10b6:3:114::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Tue, 13 Apr
 2021 12:56:21 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::cc66:8fc2:7029:d660]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::cc66:8fc2:7029:d660%4]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 12:56:20 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: Add bad_page_cnt_threshold to debugfs
Date: Tue, 13 Apr 2021 08:56:00 -0400
Message-Id: <20210413125601.50387-3-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.0.97.g1424303384
In-Reply-To: <20210413125601.50387-1-luben.tuikov@amd.com>
References: <20210413125601.50387-1-luben.tuikov@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: YTXPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::48) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.84.11) by
 YTXPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Tue, 13 Apr 2021 12:56:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 084e35c3-722d-49e2-784b-08d8fe7b888c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1836:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1836FEDF1C5FEC16E19536FC994F9@DM5PR12MB1836.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pr86Bcc/o1YcCNVWNxxyGKa2ku6ACRRLF+hnfmxsm0vBssVU99k4Obz39vXbjmSZYTU2GPS42+MDrx1TPT4xGUi0sg57YxWaVewuHggpb4oNGBuhEpEeXgV6YzG7SBzztR10wJcBevFvtmuHiJ8vX6imNDsVDZjGkjd2vee71z7Ni6xSZ36YTfK746jnXy6BV9YNHRc5oDH4iv2YYAZ4ofVPJY7mHkK7x8f89MdE9g1RpUqpQ4Dvqrk/i4VG59O35f45o95Z9jIuPW6NzRYZ8fDgb3y+F63G0LuU7lt8bli3RxJHty5T7ZB3mSqLOVqTprPzkPWb7aScaH4l2bFMdqgVc1XMvCVKZjR87r9ul2QNfS4dX+3GWASGTomddvizXxAIULjVfRyLmtwFnlQvK4Qs4L1DRvj+ssLyTJAsbY26etvTHR+nDK+R7AAs5Pm0L8+qnmy3Zd9XnPZS92zskl6f/PyqdXZ8zqEQAc8SMQ03eLlelobvQIQDP8qjquFEvFcTfCK1J4uHxNZxsusy8HpMfm6PJ4eV+jsEvZUC6Ub4dO6x+xRQz27pLeGAL6WB0HFitc/zu/pwuDud58rZUw6P/IH5SRJ2JEnYoHh3tgugNNft/Y97vEkifHZT9lKTr2aAos624QhevOSwuRz+okQnQnfRcEPgbaTDmj+R8MI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(8936002)(7696005)(44832011)(6916009)(38350700002)(26005)(4326008)(38100700002)(478600001)(5660300002)(16526019)(8676002)(86362001)(6486002)(66946007)(316002)(1076003)(186003)(52116002)(66476007)(2906002)(2616005)(54906003)(36756003)(66556008)(6666004)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?C6fe1sScrOLrwD0UFLFMgIMgG/K7McgQdy+487fVClmlCjM7zvz0StFUM44w?=
 =?us-ascii?Q?B8jvFeQ2JWaM3KbZH4mbWkscJdow2/HK6vTi4ihMsQV1lH7Olbrjw5KygTBZ?=
 =?us-ascii?Q?y9ItADmpUzfTjppr/JfrhRFnhyZ8NW8bL5L4JNPNn62TYXBQctH+cMO3HmTW?=
 =?us-ascii?Q?EHBbbDDlj7aPaeFK1nrJO2myH2SXZIqzKl+ZyuxiDg9vsZsz0mI62OnIONxK?=
 =?us-ascii?Q?AUhSuYtzHxpeYtEjZk+FQXwS869fZvSfXt3FzeDXF6MDcBdjooFGR9gdu7wq?=
 =?us-ascii?Q?jnE53tt6OPnLdqXgqQXwHiyT1GSvSpLk8EyG0bt0Y4mmi+xoEbtFDT3dOOPD?=
 =?us-ascii?Q?a6DeuXlKHKVBB8CGjK74lfL5p0SE+Rp+Fb2zIYKoGM9JGbe90/1JoKvqFYW3?=
 =?us-ascii?Q?pmDgviqLTqlnKilkUvcyJwIDzR+KyrsKEjmBhd0jb773KE/MXAzxDA9bM1CJ?=
 =?us-ascii?Q?eqYvkCUHlB7M+n4m4yDFLvO7QnbVwGg9tVpJnuKDeYtf5GEbPZvYegQOnhiy?=
 =?us-ascii?Q?vgEySMzDEtEfl3CAU5AV2ELd0OTalcmpV1VogeyxWR42HSB47M924htt3m5e?=
 =?us-ascii?Q?jMGfDeUH6HafFY8kut2FdlN7uwmR2tFgNoOZ5a19qGgN5kqTijgeXjdp3Wi1?=
 =?us-ascii?Q?Z0RIxpBeXp/r+eQJw6oYQ7IpQkpvsWllYaguxNS9UY1syg8C7K7PWx1O4M3Z?=
 =?us-ascii?Q?/SNauoA7Mp8Y79lQtr9D/od+0o7w+W0Y2Y/1NyjzKwzTXzHbxW29hjiMmw00?=
 =?us-ascii?Q?5vyBTRpZE7tMeybviN7lrs5biy/GOCWzuPE1GZyOs/6ySx6nTc+JFFoGLb82?=
 =?us-ascii?Q?ZWN6WQPgCfwku7QfR6v663bOnOhNjWGwdx+7AgfE3WMrs8a6kdxaNOt4E8VP?=
 =?us-ascii?Q?iLbw2aeZoJDvp2kmia/pXdMIXvG5BKFz+v3pyyDZpbOxXf7VQikM/qoVzP70?=
 =?us-ascii?Q?EgK1kclyQ/231YZ4n8cb8+LYUj9ynXmzGssQwqyqtUpM8JK5FUeZVcj1NEGt?=
 =?us-ascii?Q?n/oJjDykLSdj4Hgj3D7ufvcUvO/An9EjttEWby9yp5gHvhtuXnDiz3SfVIjK?=
 =?us-ascii?Q?uYG6RlgZRtY4J+aABfgawWwqBqt1oPJpL9Goqzm6G3/rqmrYcKryuLAj/b8l?=
 =?us-ascii?Q?jsuCPMY/tavIfLHdV6gEM9h5Xmy38BURRHVmjjgc810w1FaIj7b7QQgfw2Th?=
 =?us-ascii?Q?fbomX4Jn38zkBxSO+ybz0RBJqvNRHxV7aRhSbSj80gN5l+ALWDTtRQiocVeD?=
 =?us-ascii?Q?Aw8slREbNnG9QndNTytUMJ9LhcL9n2C6FgOurxbvO782K74vlU4XkBhhTs3P?=
 =?us-ascii?Q?mB/1A8wDFmHhiZe5qetCm4Ji?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 084e35c3-722d-49e2-784b-08d8fe7b888c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 12:56:20.0963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlzcIyf+4rPxIeJzw4gLAdrZSA9M5CbcOnTD8tB/YVfKYX5GWfJrpQVxYkX7lWay
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1836
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add bad_page_cnt_threshold to debugfs, an optional
file system used for debugging, for reporting
purposes only--it usually matches the size of
EEPROM but may be different depending on the
"bad_page_threshold" kernel module option.

The "bad_page_cnt_threshold" is a dynamically
computed value. It depends on three things: the
VRAM size; the size of the EEPROM (or the size
allocated to the RAS table therein); and the
"bad_page_threshold" module parameter. It is a
dynamically computed value, when the amdgpu module
is run, on which further parameters and logic
depend, and as such it is helpful to see the
dynamically computed value in debugfs.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 3ca6b51f0c9c..30cda4b8a461 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1263,6 +1263,8 @@ static struct dentry *amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *
 			    &amdgpu_ras_debugfs_ctrl_ops);
 	debugfs_create_file("ras_eeprom_reset", S_IWUGO | S_IRUGO, dir, adev,
 			    &amdgpu_ras_debugfs_eeprom_ops);
+	debugfs_create_u32("bad_page_cnt_threshold", 0444, dir,
+			   &con->bad_page_cnt_threshold);
 
 	/*
 	 * After one uncorrectable error happens, usually GPU recovery will
-- 
2.31.0.97.g1424303384

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
