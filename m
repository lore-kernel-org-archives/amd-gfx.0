Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42DDC433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE01464EDB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE01464EDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3BD26EB9A;
	Wed, 24 Feb 2021 22:22:37 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770054.outbound.protection.outlook.com [40.107.77.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 477C66EB98
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeSuHoCZ2PbS+YEkCgI3uM71bOr3ofc9aQbaLVVXFpRQOeI3Ox2g9QmjE8PSUVdimO27cRnaDaz1JlmG3Dg+s1fhXW+3O/saJWSfUDTbLFtHPryIhmlTnwvIbSv3QAHnChazfeRPVjRxxy8JHU7S4CJuL+fnehcC8h7JbfWrXxw2vwLpg98jw/x1ANMj/ElJOnJmz7AuXvAD1cu0gpQiD0dCoR3LmSfUfrOAGR6yG9HwoHL837J6YCh1Quos6SpXAY/JWPKoHFY0nD5capJxxDyFyrfTasQGz/XTK1Jhu5Bq5v2lwUO7znN5ua9A+ZmwICBcfVIbKIG+xKsm2w+6Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVebZsBlat8Dzo8ZUwsBvruX9IEJLfZvTaKuAQJdEuQ=;
 b=SH54gVL39X/QibudTGK8aL8Yhsr9jw36Ief5TEmJpLWRe+2oVFXwlscQJGRsjdiL0VSN4rdwr6bWd5b44YZpspg6YHBeMgZUvBmF/gKwIHhPDw4aeI4cvjCIawJq9GwTK3tvJ1y4a+zXF8w7hfq7Y+uI5vx9YHlhhHN8H4u+D98Vy5zA15LTVpBgxkOk7uqstWl8JGn7vURX19gT9uoTvmKi6EPs9KyVb73IFs5dOp9u/X0ua16LHJSx2tM8++FivgZNHpnJovTMZSI46pdg3kgdMzfpO/U6cDuTrE9Ygx8kkDRdKSbjHPXL5X882Co0iG1G1NDBX+H2IABzyqVEWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVebZsBlat8Dzo8ZUwsBvruX9IEJLfZvTaKuAQJdEuQ=;
 b=0uDkw0MfqvukPqTh46uTlCQFK5qOSrnfbhkf4gYbLjSnK+EbDhkPkC2g06E4aKF8tk0TgBav40q/v6YueFc34TJCb1AD9O92MdOnxtEk+VSMg4yj7XF0Y/vXy1wosN1mBPe9vItCmwo1OTj7zA3RPTQd3Qs4qYyagJs8HwRxpXo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Wed, 24 Feb
 2021 22:22:32 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:32 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 139/159] drm/amdgpu: Fix the comment in amdgpu_gmc.h
Date: Wed, 24 Feb 2021 17:18:39 -0500
Message-Id: <20210224221859.3068810-132-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 31b87ea3-9d64-48e4-011a-08d8d91274fd
X-MS-TrafficTypeDiagnostic: MN2PR12MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB38078D0666A7621BABE2BF08F79F9@MN2PR12MB3807.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2BGivo6K9HJkKvpYsOQ80Xk19eftjlI37ES1A0KIMEv2jsuhCTTN9fn4J5J/rPvS//afNb3sIXEDm1FgXR6YyQg7vtCz0Pmk/hzeu82KCmFd98rlUdKFZhCv7QE5e4HbIW6tQSFhhOwaYj8af8kJmPzk0Edrz46uoYBCz4TWa2eF882FHNQSoJMu890xr33fp/YUCeG//N0xT24Rm3oKeNwtGcH3GosEiuXwnfTIQ6Ksq02d2rtdVYq56uu4f+Hakh5fka9hnHjMfRa4w+N/riTX3SsAmQXXWScDpyrWXsvDqPvKBmJKbVymG9mSOEbmzbmU1bhuyJ945UYx97FK/uKVSDpVIMUL6Zz1HC3NDNvHcNNGYfTtHGpS7+m949Fe108fwwOd2yHch76h/hEzbmzlALVnC3bpN1ZHAJ2lh+2DFi8c957k1rDPDzDH2mOWrNc3+Mch9EN6S9vddrAzQfwla159Kd2cqmcpRrsEc8OMeNKy8ut/XUkkbZj6GJN1pH/w9N0By3xA2+YKtX6ZahUfsRVnWRyY/3sxC+mYtqbsssmcH4NtQHtrPngUuD0eHo+yPfdRRPLS/FvLul+tFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(54906003)(478600001)(4326008)(86362001)(83380400001)(16526019)(2616005)(186003)(36756003)(66476007)(1076003)(6506007)(6666004)(66946007)(69590400012)(6916009)(8936002)(6486002)(6512007)(52116002)(5660300002)(956004)(316002)(2906002)(26005)(66556008)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ka/Mbkj/ClmqrYPZqltyzskwD2Atn9VzX9VLqTHVtVgLMXCRODxHkguFTqmO?=
 =?us-ascii?Q?k+C6mxIYZN4Jk5B0KkPn+jMfQH+GtQQtRNNsSS+d+GpnV86orUyNawF3hfMo?=
 =?us-ascii?Q?GLNvRbihUuHM9c3Bawl3qyPUHZsPoKDp9T2oy/v/0KL304wOBnp0XScTJ3lc?=
 =?us-ascii?Q?0Ij3B64BSP1kuoBCWsbdmdb0QqgPs6ktuXc+Wsl4R7gk0Y9p3LsEvFXt5QQw?=
 =?us-ascii?Q?bokG44N4uYwNXw5ZoC64mkccO/ywLHU7gCH1AVQnmaeooov3uRB+iMaq8qvY?=
 =?us-ascii?Q?oliEGT1IMzdDSWnA8bM/Q+hc6lSmUWc8SqNI2Dfcm6Adc4h27kNnD6Vre5iW?=
 =?us-ascii?Q?MDiu48ynwMEL1mwwrNvtAnZQ8+i3mj2dZmO61JNhcyLK7ZSUb6DmWtavEHzd?=
 =?us-ascii?Q?i60it1+/GtjYzdL6Ukw5h3yDuRa6NgRLIOtDufjPkeZx6kQFS1M+RMV38l5Q?=
 =?us-ascii?Q?tBknSnqoTnh9WcBreD4hutqFriyFBGqn+5G1H56Yf7iDzOYAh6npEreOGj/8?=
 =?us-ascii?Q?GO7KW/knSkOeAtbYP+swv6fqH0pHUBg4dGgzxIQ7MY9Bz+8Zk5oM9ozKCLBY?=
 =?us-ascii?Q?NGzjOM0e2YF9RogukYmBRlb0IgO8cBS+KgTq1zpc+8HBlnu79ZlDG86q4vZW?=
 =?us-ascii?Q?FVFaI4LHs8Me6jeLPqK4cO4uY3OE6qtcqtPVrT/U/8E16nTtpB7kFsw3yQ9r?=
 =?us-ascii?Q?IS7BzJEfqZBvX5VjwroLbF0v2vFU6zIdurGqWAS9f1ihQwqrB2ttjEQIcGxV?=
 =?us-ascii?Q?sBJvpayJgKLEgnpvkscRuTLM9PclGnkXzanm1OVhQw0AlHz/XmQXqtkYI79j?=
 =?us-ascii?Q?bcVYBy40AGvHUk81foxP8pZzDWJAhXFRwH4/2omE+bXtzAhkdNZRLtd9wlTo?=
 =?us-ascii?Q?fk9W1JTccSLDLBNMY8PQ5WiKljh7noLLhNmdk5exAK54w5Sl8iwP8VVTW/rM?=
 =?us-ascii?Q?RtySYTRAxBFOoD7BtmplLO+WUwrEdPXfwbYl2+Wx1ai53qmu4tP5fOo0hkIW?=
 =?us-ascii?Q?LMYSbYuytcVwUTiFCtpuxSs5XO7yLwvE4/YPq0fn3JyclelPoZKFPZ/I9Cgu?=
 =?us-ascii?Q?gL9V+OD0wWWQ9gP8Mhsk8Hoo2X96+yeth/Pd/Nzu7YSdDDSceVvbQhUAdWSN?=
 =?us-ascii?Q?sWG41/hj7u9cTvltx9OPe1MCujOLyoFDH7ETOAEL74rSwYPnRpN7pX00AY49?=
 =?us-ascii?Q?BQDmJBahJhbkuQyB3KmsWCGmKSj3EsRzTQ7/bQOXmQnKzmmA7RDDNZRoTspL?=
 =?us-ascii?Q?OFYBLuBbic0xD4Q9VgKnz48LSsYD9Mol2UYBMvGXhq/CdveWfjUuEIT+LPIM?=
 =?us-ascii?Q?1T6zra+D9Kg7SRtrIrv0vHRO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b87ea3-9d64-48e4-011a-08d8d91274fd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:57.0113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9evDvLYnQ2VsWtUIlZ4N6TEP8/O/kjY/vJToA7ZCznkJrd2fo8IJTh14qU09Qfpgt2ZYI7RhMEjarwfeBO0ArQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3807
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oak Zeng <Oak.Zeng@amd.com>

More accurate words are used to address a
code review feedback

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index cd4592ff70ae..e57daa262150 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -190,13 +190,13 @@ struct amdgpu_gmc {
 	u64			gart_end;
 	/* Frame buffer aperture of this GPU device. Different from
 	 * fb_start (see below), this only covers the local GPU device.
-	 * If use FB aperture to access FB, driver get fb_start from
+	 * If driver uses FB aperture to access FB, driver get fb_start from
 	 * MC_VM_FB_LOCATION_BASE (set by vbios) and calculate vram_start
 	 * of this local device by adding an offset inside the XGMI hive.
-	 * If use GART table for VMID0 FB access, driver finds a hole in
+	 * If driver uses GART table for VMID0 FB access, driver finds a hole in
 	 * VMID0's virtual address space to place the SYSVM aperture inside
 	 * which the first part is vram and the second part is gart (covering
-	 * sram)
+	 * system ram).
 	 */
 	u64			vram_start;
 	u64			vram_end;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
