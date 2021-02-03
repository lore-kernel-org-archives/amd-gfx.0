Return-Path: <SRS0=BBBq=HF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462A7C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 18:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF9EB64DE1
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 18:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF9EB64DE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4240E6EB23;
	Wed,  3 Feb 2021 18:22:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 402A86EB23
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Feb 2021 18:22:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJyUBAR5zEsY94pycJ8Ti7mpxY/mq84oZ6noyVJFCN2mMaX5H/IjqWTQ4uhR2Bm40T21/tPYxSJ7eKgKNvi/EJmrQ0wT/hbFcTuv2HE+ExW4gZ6ygR6FT8doyYy9x98JSEKhvxonwsueWTmzQRC+jXgQurvsXMBl3zOahvk//yHxqySnIiR8KD7tuZbRHQX6Q8gKnHWAPDtaMjs/oYi3MNp7CAzfk+Vdi5bhDIBzPuZpl3ajgAl/EjxXGcFpXw+gUNGSIsEJk13yHbYLhUUC+S/6Dka7Ukc+0aQu4DhdzPrdTlh2Ba0gjJOMmENZHVHfz3sFV6FG7Zvd9ZLKb2vqrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMcUZjunpGHNBdVhTW6VeXvfG4CbiNyv4vlVYnav1vE=;
 b=OcExlesCAonxERhViLsia2ny/uZfeSZOwziM1+iLSPd3hBfLS78vOIGxj67OUNm4+BWezkWUa37upxT2P9Y8ZTjBdg3qDriJwnwos0ICFyMWForWjYf4bfSVUKhSdqj606P6FyT4zqupjZzaRkJ50EMp0gJ1IxRFuh2AxY46OLWCepTl+5EjYqxcXnGACZUFT6ERLJllV+IKSVq+2mb2uMtzumaFxqjPMBiNZjcMkI36tii9QiA7mcatHuAlHK0JQax4PdrwFjUatOTjSdh+WlhejIJHv12VvN7yvJcmGXgFTfddo9PM0RtQelD/UuQuxcX1VD1f840S5WJXL68htA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMcUZjunpGHNBdVhTW6VeXvfG4CbiNyv4vlVYnav1vE=;
 b=GSTBPtIpEKdCWsq6vJBylFokX5Jbpn6J/xcIzNBGaa+VSJbOhN20zpXJCi4J7BMMr2Xpij5Ggd/U5iCOjYBnmgPDPQ+jJqtV+meewejt8SnpjlLFi1QEbrEIUiAeTdbwDclAcrMMK3DGDvQje0DI+O4jEDJL4HKOTseFN9BhHSE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26)
 by DM6PR12MB4745.namprd12.prod.outlook.com (2603:10b6:5:7b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Wed, 3 Feb
 2021 18:22:53 +0000
Received: from DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::e122:1bb3:9f2:915f]) by DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::e122:1bb3:9f2:915f%6]) with mapi id 15.20.3805.019; Wed, 3 Feb 2021
 18:22:53 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Print unique_id as hex instead of decimal
Date: Wed,  3 Feb 2021 13:22:40 -0500
Message-Id: <20210203182240.24259-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTBPR01CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::48) To DM6PR12MB3324.namprd12.prod.outlook.com
 (2603:10b6:5:11e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YTBPR01CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.17 via Frontend Transport; Wed, 3 Feb 2021 18:22:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 27345000-d399-4c6e-f836-08d8c870b894
X-MS-TrafficTypeDiagnostic: DM6PR12MB4745:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4745B8985F236AEAC6962EA885B49@DM6PR12MB4745.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e8okUTpsPrKTOXtY/X+N+Vj41H8Bf79+mOn75kl3M76oKJGUPezadByyTfw0GJXu+Y/3zU3uITU/CAgxuDHKQJp8O78blAX/NBkfb1xbraz2Qm29MSmFRxNpyIfTWMaGr3sTZAf+dNWEMSXa6uL4+aVlLL5PNCqr1SaYNU3Ne0KqXldn8AZi9PA3UOn9sGlDXFTJpkxLjV+/zccjVAYxRvrGdayn+E+LiOu2yeRtmT5QUDTyT29XrtOON+xlDYwvaXEXHn9O+P7KV2UZwhevF9moGBdnddviA1HM5HksxrfOsCvGNveYbo5x12G9XDKBAYXM+cbM4no+6CFRqUbATisWqiChDPIL2uDq5ep529gql1Y0v+Gv1M/nSwSBZ0vXlwo5DgGTFJw3cxFXEY5/bQ2hWjooJIjd2SA0Fa35eEbw+6C+iiJWZTsNmjynUGL7u3YZelg7EOKkwa4SoySJNtGcImWOiYpKodMUFMi9ru8ycTa2sNEZ94z58wMHUQ4jmZLWxPZNmRCzmNrx/jUYtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(26005)(2906002)(8676002)(4326008)(6486002)(186003)(16526019)(83380400001)(52116002)(7696005)(66556008)(316002)(478600001)(1076003)(5660300002)(6916009)(44832011)(86362001)(6666004)(66476007)(2616005)(8936002)(956004)(66946007)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?okOXh4pe5LAH9tjcalm/SojFaS+GrteyMl0fpzfozw1Mm7HZr87FysIVAUk9?=
 =?us-ascii?Q?eBbg0G55h+xWjahoX+IN+t3RsRKAEDvygenbG0v3OtcQYCtMVHujD0Yk6uf3?=
 =?us-ascii?Q?MezdfA0KIhYQsXU4Tl+tZfIH1Gqayi7KpEzdpaHqv0nYiL+dHnueB2Cm+hu3?=
 =?us-ascii?Q?FtJ2ckEpAOJTY5XA/bN2ylJHk3vcAWWFTuj7vUr1j7dHhCesnY0H06QNXZWY?=
 =?us-ascii?Q?9Z2u6p2PwaHFDbSsS0GT6mc6UctQE2FLocxSPMGlAedraIYxHQ1ETdUiQ4rG?=
 =?us-ascii?Q?5mHtoFT7wTcRdQsA7tDiKwNm6tx+/6dfLyb8oAWmYSwwHuQCehVegSB7/mIa?=
 =?us-ascii?Q?7hdzItxK4ugNPc5OA8z63LaBncttojizZo+6a5BgFRDayvAoKjOYlZ2swNxv?=
 =?us-ascii?Q?FPHvPQUxxNxO1/b50zq9i4o+/eXEZg/ZkL95r9OhcH9gCsE/xHIXKuy/gwga?=
 =?us-ascii?Q?0Eya8ySOfy0F2FlwXOb3gUQqOKBznExB97ZM5vQFuVImVs13smqzkpPxbx1a?=
 =?us-ascii?Q?U+VupRwSpuQnoiOerTBh7IJwOCoeLdDw6VBytJGde8Pdo3f4YrcHBlLf4KmH?=
 =?us-ascii?Q?xlEf/8x6wPfq4iGkrRfJLTOsfKTpwrKdl/OC6gfTvUhWJ4L5WQYVsDqRcuX5?=
 =?us-ascii?Q?/tzcgrVBp+lHII+Mc4Thdy44tlxMe5CHSNC47unr+x0BR4zCEdNFKFRcPjBE?=
 =?us-ascii?Q?ApxrwDB3qwKLviqeenVgefkcswHxBZ2/+F8ibxjQFL0bBZ2uPLBjdCVbC6NR?=
 =?us-ascii?Q?iwJnP2ZG42+cz6NBry7a+pveFHYyez99EAmV+jVLfwRokrSg+XfvAob1yCWT?=
 =?us-ascii?Q?/XAvDC8l15FwPaddovaMQypyLEc3TSbSFUkgtWVhEF26OpBG8CDgL06D/R6S?=
 =?us-ascii?Q?Rd7ehntN2Ygcvlzomkm8+lRwJd9HfPBUXVzv+WSziv1B9pMovHhG6Lj3Dbd9?=
 =?us-ascii?Q?Aet5sc7GxkUmznKyl9bFhImcblkbqs+tkEE3Jp/8dEhopEwfzYtm0QRmgpXN?=
 =?us-ascii?Q?udNf3gz2/StmGup8/urVDxPtnPwX/nNeLYYPdmz/7TOo1vMRNGTInOB9g+eH?=
 =?us-ascii?Q?VusqhA+nz+KwyUEoO/6ClmNWdkWa5jDstDOwF7sYv0+yaM4HHDaTo9ipx+Fv?=
 =?us-ascii?Q?Xqc3h24T2h9J1c4rzjcZ6hLnh++LjMGmPtL96XxLMxO1uQIWp1MCUILKvnhl?=
 =?us-ascii?Q?9fyCESxXtT6QVT39Yk4rAE3moyHNJfOZn3j497TxaDGuIngjzByvRiEdV0BL?=
 =?us-ascii?Q?MdU1omwVb+cGUYSAvYqBjyVyQM22J8bbTm7d3NeKvOO7XgcVSMuvGrEvLlGB?=
 =?us-ascii?Q?2HsYqScSYUMhcuWgmQ9RZRoR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27345000-d399-4c6e-f836-08d8c870b894
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 18:22:53.4146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SoCKik3GLP1B4tDjSVHNa80gPYcKhj26qHlirGPlQWxKhSrPmT6pvXkjf2/aN7TSThwwXwyFSrak8Ae/v8/j2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4745
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a new helper function for printing Topology values to support
printing 64-bit hex values. Use this for unique_id to ensure that the
unique_id in KFD's topology matches the one in amdgpu's sysfs pool.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index a3fc23873819..4e4f651dcb88 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -217,6 +217,8 @@ struct kfd_topology_device *kfd_create_topology_device(
 		sysfs_show_gen_prop(buffer, offs, "%s %u\n", name, value)
 #define sysfs_show_64bit_prop(buffer, offs, name, value) \
 		sysfs_show_gen_prop(buffer, offs, "%s %llu\n", name, value)
+#define sysfs_show_64bit_hex_prop(buffer, offs, name, value) \
+		sysfs_show_gen_prop(buffer, offs, "%s %llx\n", name, value)
 #define sysfs_show_32bit_val(buffer, offs, value) \
 		sysfs_show_gen_prop(buffer, offs, "%u\n", value)
 #define sysfs_show_str_val(buffer, offs, value) \
@@ -497,7 +499,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 			      dev->node_props.num_sdma_queues_per_engine);
 	sysfs_show_32bit_prop(buffer, offs, "num_cp_queues",
 			      dev->node_props.num_cp_queues);
-	sysfs_show_64bit_prop(buffer, offs, "unique_id",
+	sysfs_show_64bit_hex_prop(buffer, offs, "unique_id",
 			      dev->node_props.unique_id);
 
 	if (dev->gpu) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
