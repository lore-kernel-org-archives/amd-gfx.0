Return-Path: <SRS0=7Ry8=JY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09602C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 19:57:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F7DC613C1
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 19:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7DC613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56EF86E9C2;
	Tue, 27 Apr 2021 19:57:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BE816E9C2
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Apr 2021 19:57:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuU7uVZ9Tcj+B+K4K3bh4B4sM5KedgqHDbZtwBphX54h/ZeOz81KeayXNecXeWgHuyEwNP3XqrHAZn6f1r2LAhWbBH1nlUCCHhYQTTodMi5gNBHcRuARZsem8lHA8L/ISC1PL9C3Zi9pWfY6mlaHKZD3o4zYFwM0ZkbggyyZRox4eLU31M+YHQrt1YfBuksn3krHXX2hQE0s7sb1uC93kZ2+WJ3DCOlgZ6yb1VIZwtFPBSbDxpzdNet6vvSeqtunFC8WyC1O7d6E/c3LTzDwI9QR0jBByZ2VM0VXrzDQbbZiEJTO4E72bCDDalF56scstQv6XkVBNI33KKeQDghHoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Zc6ZIVhW2wgdo6GHXmLuNpyX3+hnz3NqaTdWUi39io=;
 b=T4SFEQ7YcYqQE6I5tbwedQScVmiwwFur7GUATtFEYRWOY+cV3OesHmZPxlAGBMWyMTe3ujxOa4WD2Tug0+pGQbluDzZUwkOyPJLqV4I2ZBFZPPqK3ef/NpQLTt2UlRaX4kcQ3XWH1dTsxyi2X+hbQzEv8acJE/K53H9dQ8Vt1Imos3SfJ5086egXmwSEpuG+lc4fD7yz9PfWs55kA/yPkH4aPFpQN+dL1ByArg+JlVE9nE6vOyYQYSDoUX2G8LE/nI64rAO2egiZjiRel1UEeq987zM+SOMQZfIRC4qxY5cAu+jOznmX+rNTydewsooPYo3xCNAbYMNzPDU4ybcJtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Zc6ZIVhW2wgdo6GHXmLuNpyX3+hnz3NqaTdWUi39io=;
 b=gUuXZLOzBkknYV+zkCJjUST4MWhkExkedS5EG8JvpQFlt8cS7+OECn3zhv4VrwXEPDlopUHGSkwxpvbNJ23DZZK2jsSx+v0GsaQ9Xnn/qrbPZIH4NPjvkesh9nLVxaFL0sqb2jZVoibsFMhZB1ZyJorjl8TKhwdA1U01B+UaMVQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM6PR12MB2763.namprd12.prod.outlook.com (2603:10b6:5:48::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.25; Tue, 27 Apr 2021 19:57:01 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::5194:b381:c345:eb0f]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::5194:b381:c345:eb0f%2]) with mapi id 15.20.4087.025; Tue, 27 Apr 2021
 19:57:01 +0000
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: amd-gfx@lists.freedesktop.org,
	joseph.greathouse@amd.com
Subject: [PATCH] drm/amdkfd: Add Aldebaran gws support
Date: Tue, 27 Apr 2021 15:56:47 -0400
Message-Id: <20210427195647.2212603-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::11) To DM6PR12MB2761.namprd12.prod.outlook.com
 (2603:10b6:5:41::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from harish-base-compute.amd.com (165.204.55.251) by
 YT1PR01CA0132.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25 via Frontend Transport; Tue, 27 Apr 2021 19:57:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02cf0124-cfc4-4e22-7fe5-08d909b69f5e
X-MS-TrafficTypeDiagnostic: DM6PR12MB2763:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB27633C8F11F887AB50367B6D8C419@DM6PR12MB2763.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1L3fmIj0SXRthOS5Te/5OXvPlJQoppM9TjKgG9l+Aj+tbV2LM9+RKaGlQljP4etUhnoTNqjGiUKOyICaRPItNu7925KkrwhByYF2KvLoGA7UAaWOQHXxHD/9TV4N5iZvownipINupPvCefsTxOYFx6pD+8AK/rDBS27d8zFJF4kjoUGW2GQ5Rro6lTRJ0Fy1XtUO1GcImkD5nfSPmvWLx+MYdnvR5v9r3nt/1MyiUdKzKy6qfo+7+Qhlh1aWqQO/PaFOiWnhjmgUUHtMWHf4BoK8dp7tuFIMKESkgE/dH3JzbT1GBNX0QhuRV2wkqiuJ/Mfl4S8N9+WT7bnNqPcVlwSn6A9CoWUGuD/NHpt1Unw1NOBMndwrcsKd8LhonYtKHLgZ3lDNomzca1Ndru+CRObE0mo18hUdlteZ3ZRTZ4nmyAAPS+BqMHmuNWY7CwbjTu0i36z9eZW5yoFqBmt8Zy67Ucv7X45dDkE0dEZjss4CD/vU9W7pjDl8Ld8YTi3CjFSPECApH+nOFRI0UoADxjmy/hI8iu5Dv2+wqBjRoxXNKjNDMnumYS0xiJ2J3Dy0bOO1zblWxgGgWEXr49jj5OMDXPOuk60R1QLNE74h4MT9zrMBRuGvA522ERahF6ldB258+dS1yz0vzx+LG6lnMkhSrYYygMjkttUmJ6yL5ms=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(366004)(39840400004)(83380400001)(6666004)(8936002)(1076003)(6636002)(2616005)(956004)(6486002)(38350700002)(2906002)(4744005)(36756003)(4326008)(5660300002)(86362001)(478600001)(38100700002)(26005)(7696005)(8676002)(66556008)(66476007)(66946007)(16526019)(186003)(52116002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QCeySsH/l0WOubc1DOMgzAH7KMEoFRpQ3sGiCKRyAkFEDImooTUCfq4xY9RI?=
 =?us-ascii?Q?HeZJBVUI7NFPKFNLdoTk5OAGMrwVyHvoQmskURlzTRFO6eTxhs4bgmqZ4Ny9?=
 =?us-ascii?Q?QcSC9uVSMWUXpdJS3zg39Uc/toNcHEYxNNldzhRRXJkaj1S300jc8LCGR081?=
 =?us-ascii?Q?SCimNmv/owyFiTvXAM53M37Tcf6ugH1g6Y4Wie3ufy8/rhIlb6k3Kd8AP7dC?=
 =?us-ascii?Q?Af0vTHYMEMgnrQxsiiUGGe6n/QT6UVeZHZb3C1s1GXlkBXp7YI/4hJTVbQj+?=
 =?us-ascii?Q?PtuMNw0Pxqb7e6YndI83USaomCmOYZYh6Z1qlrEHkm9p4Akq3fgIffAT0Qm/?=
 =?us-ascii?Q?GL/ATtIR0jrKFYcQKgv+DmBIomlfe/fBvKaxzsxgqeVmkRCx3XboXDRDBCNE?=
 =?us-ascii?Q?hvOKdL003GEwIrXV8deeNwah9//sKhzwwLj1cW9x0umfHGKDIvcBIM+Axw7K?=
 =?us-ascii?Q?RGBATNO6fDgI603P6SToasihG2VlXVbilE9QX1LEnoSs1cScn+oPua+OQLzi?=
 =?us-ascii?Q?OEsfXtYz/QZie4N635r/jIwkknx1dXNWhLO6ROOzUer1kJH9jnxGkqliVnJE?=
 =?us-ascii?Q?t8hxnMRWv3CKpvh+oBzJVsTC+YdATlzuktG7oGP5lpTuCN+nZ8U4ji+//wMJ?=
 =?us-ascii?Q?eAqMF0KEmNH+uISGKqvTcOtGTKtKuru/mGK/3+nuudOt1vhjFcAMVJxItPEN?=
 =?us-ascii?Q?/Rmzqyt8VrJChWGig9WjO/PhAgNw9gxm6RIY4j/KcfO7dHAoB0KGnSCIGk2/?=
 =?us-ascii?Q?9Ema2TfeyxssGcNSeXX9kc+LF+Rd41GHKLQSfay5fqH8dY11iHwL6m+xL7gb?=
 =?us-ascii?Q?3L0uKUvfLfQdFAKUuqtIAjRPntg6DiQ/xtLKUlMSgt/O6CInopOT9Wrtl1sk?=
 =?us-ascii?Q?pgDAaY1+3pe8FA0PBFHKhrVfwu6Iyld7bcQmO402NBpcZ2tG7lie3zSreXCH?=
 =?us-ascii?Q?cFpJVQo9w/hCtiBSBzdzaHYYFPJ1Uf+xxVASUJpBWh02GHeEY3L8rn8wzvBw?=
 =?us-ascii?Q?4eXo+F4Kt6FkTsK6dSD2kv1Bmisi7xva1LRSdjfpw7HAToTDGKafiWx9cjFh?=
 =?us-ascii?Q?LZ0yxgOT8Xr5fLPNvyg+/aENd4blWX87FURWMyFppNpKGZsHkSeYpkLIfL1U?=
 =?us-ascii?Q?vpEdZiPoROwnbJUOboirwxwmIqSMsRzDC5PHf2fnX7a33FFvSayVlJlwWiG3?=
 =?us-ascii?Q?XJwDrXzjra16I2OhPPorNQBElak/JvJt3zModEg8RG9Uj5FwHZIl5uVF/H5v?=
 =?us-ascii?Q?YarypqQYS1T+qLzTpIgwdAE76XN+aUjw4qRhLGj6Y9X2NLYjYXhUiva2uWF4?=
 =?us-ascii?Q?RME6UgWiyVbQrhPYsfDzz1z6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cf0124-cfc4-4e22-7fe5-08d909b69f5e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 19:57:01.3673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqYTOyyFSvJX0drywT+S8eM8jR3gGldIG4fD0rtfJa0x7XgJzOWW5S2KpLro8lmJyQ4wCc5+sRBJ1u7a5ZMfgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2763
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
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

v2: updated MEC FW version after validating gws with debugger

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 348fd3e49017..ae3cabb47a26 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -699,7 +699,9 @@ static int kfd_gws_init(struct kfd_dev *kfd)
 			&& kfd->device_info->asic_family <= CHIP_RAVEN
 			&& kfd->mec2_fw_version >= 0x1b3)
 		|| (kfd->device_info->asic_family == CHIP_ARCTURUS
-			&& kfd->mec2_fw_version >= 0x30))
+			&& kfd->mec2_fw_version >= 0x30)
+		|| (kfd->device_info->asic_family == CHIP_ALDEBARAN
+			&& kfd->mec2_fw_version >= 0x28))
 		ret = amdgpu_amdkfd_alloc_gws(kfd->kgd,
 				amdgpu_amdkfd_get_num_gws(kfd->kgd), &kfd->gws);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
