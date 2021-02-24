Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3760BC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D225964E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D225964E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D6006EBAA;
	Wed, 24 Feb 2021 22:22:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DF956EBA7
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhPpITyoQmQ4HoTzZj6doux6XmH4TscUfH5HlASmS2bsvL91rsC3+DR/eWRdWOAVQGFO1swjinzMYeTOxn77dz4R4y2tUqz8/u9o9CSntH121IGN4r8qXrLHMI8eEJPB0qfze5TgmvvqvLTZY2LiTExlLIQ+ifK+ey+/eBIrFB1TuForv8T12PiCsIOqcpTJufKJAC9KAhVyTZGhxjULwZ9fQhwaGHwGsbLqg1RFhUrfbmnIbacWUg3PxfnowXi9ZTTyfjUDL9sgEYG70AVBJcWvDygRr6Y6hkVaL2zcbQib9d40o50j1tCLNZkyItZTKPQm6ni2/e5GWjMBM77pKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZ8sgErI+diOsJY8Gwozu/M4O4LkyBmb33UknKCqyGk=;
 b=RbhRWDK+9ip267roSTtmimLayaShISEFyY4msRNhyyFR+69x/L/07pRGkd+52N/Rh/Y9IH9eDR9w0hNBP4uToRHQZN+W0z+BfheoE4WtKrQcfFbCYmPHUACGxLCzevQBLRg5M13Ohla50iEGXHZoeLqw7huDfI11Tg0s5ks4R0To502JGrHSQND8jtLrsz8xqGIGwugPTSWO8R2wsgPVMUJP0EI0obeZy9T1wQp1UnSdmRhbp2sdocyz8LY3RHIoNB7fA2Vt9ML125yNsLRxos/Q84d4CtyyL4E88CACmp1jSL3u5n50SOJd5x+DQNcMynLdDnLcpWWteaqKlndWHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZ8sgErI+diOsJY8Gwozu/M4O4LkyBmb33UknKCqyGk=;
 b=H9/6SkxFGiVmcUTa9yCTfq3OrJpV+ivdclaiF+uABL04N3s4iCy6xL5JUrjHExsHGaRnvEItF6DOr8tS2p2teZq1YpFlWjQ7fxc41ja9DWffN1ear5jb/93/jCytt8m+EoF7WFwKZK+EbA5OOcafSj9AVlLj13DshgedZoqHqEY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4722.namprd12.prod.outlook.com (2603:10b6:208:8c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Wed, 24 Feb
 2021 22:22:37 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:37 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 150/159] drm/amdgpu: update TCP_CHAN_STEER_1 golden value for
 aldebaran
Date: Wed, 24 Feb 2021 17:18:50 -0500
Message-Id: <20210224221859.3068810-143-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:21:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5e27372d-ddc9-4da0-02b3-08d8d91278e6
X-MS-TrafficTypeDiagnostic: BL0PR12MB4722:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4722C959089B90461F738483F79F9@BL0PR12MB4722.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RFlt4agAA8oAkPj3FlAJfp8CBu/GofQSD1U8MOtblzBUL7OprTy983AP4YX5C0YyvlcqiIf+J/iMU+IFPVXFX06sU5OcObFvT0ASY4uRLMZG4pAXK8c3r5trClAU8oFceYBKms0J1Xgcsaj7N+VZpyCFL3IiFBYXIn5v/DYmBsfmBVYL24HLL4d5m+f35Lg8Owk0QCWo1ieALLKlEGAAEwAwfNlp5OY44W0Hdvlb5s86C3cptvLJM8He3ptQntpVwH60kU27rCu+KPCzpH6UE53vNo9RPJ0yZAk5tGaeQUz04e1Zfk+gMq9hPqj7QvdoqeMOii2PcJFE4hIORcMjodtRgvm4khEZX6AUScEHO6NdnNEXahPc6QvP/uBoo/4n5YkVYv8foQcK0X7OVpXpWZT0dOdHChBSEwyt8sgwytVXtoqETglvVxpmR/FwlBfJnNYrHDYV/cbw3lQh7juirw6r63JmyLV/wANF+Fm4yfvs+C+HlWMzIidKWBzYqqPbNB9w2U5C/nmrv/j2OdvJUrIwWafvSx+8EsqLDoeXJfzj5HEJgqy1+5wJN2B3iKt7Tm1FVpERBtfFKJhs61Y3OQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(8676002)(69590400012)(6916009)(4326008)(6506007)(8936002)(478600001)(66476007)(54906003)(6486002)(2906002)(6512007)(86362001)(52116002)(15650500001)(956004)(5660300002)(83380400001)(316002)(16526019)(1076003)(2616005)(36756003)(186003)(66946007)(66556008)(26005)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zjHH/LtcPdA9sTE1V4sTCJqpHna9xMI1fKZXmhhqfL1VIgOLxNNN9zDtIbZK?=
 =?us-ascii?Q?7uYXi1pOUwKmAmQar2NTmM0cSIgY9C6xNGkiI0s3oit0THobMIo9Mg0FS0sj?=
 =?us-ascii?Q?PXgXNJa9ItSodjxmTcShzyrlPwEF2fam1aF0ECqCjE+u0/sqhPH2yVygw9NZ?=
 =?us-ascii?Q?LqzMlb/RmI4shMJi35g+whCdinKeXz6Qc7Iiopl/0jNwj25KHFij+w9STiFh?=
 =?us-ascii?Q?Bu6OehvixPeetDywvZ7VFMsbJfLfeFrI0KdY32L/TQ4S6m60bDgvJDQ65uzn?=
 =?us-ascii?Q?OWmK1hQpvy83/DYoAX0mrTX/mLjbeAgZVkUR29lta1cMo0AC/AxqHUkOyB7N?=
 =?us-ascii?Q?86r66/0rdDfU3M5fjnZjRPNejn8gV52C+30U4CTd/2xBZHw+5HTKttZIx99p?=
 =?us-ascii?Q?mKF4ijQ9jmS6x5PzqEAA284MNIx6gT7ga8zFNSU7hPskqyVZEaK7TqwxWi1g?=
 =?us-ascii?Q?ZFvZ+Pwt9d7NKUCh+wurA2M/wGaPsWjixxUWbPDkppN3rO3NpVXA3NjhNOhO?=
 =?us-ascii?Q?CCZMNW1il7gjo+U+7etXNd3z155eY+FuTR9x5XL4kZfF2DcnJz3aT9ZUPZYI?=
 =?us-ascii?Q?OKo5AtZHT4tywfobZTFoFme6jd/x2+VDO33T/pcJ00CNM3edFQOhaY2d4U9h?=
 =?us-ascii?Q?5Qz/sKUk+YempY1JJ2UQY5rhbbeL98yUE0yKNgOXtHpt3B2NAVLn1VwOhtLF?=
 =?us-ascii?Q?cBYe06IaMD627kH4j28wLQwHsVE8gj9j08Hm82M0Pb47vlRl/H+jKPl2MNJz?=
 =?us-ascii?Q?hrEm/dxHXwdjxtar1J25wKoRrKCyEsDPJxaZJvFZ3/KU3BMdqVzcWd2Ou0zw?=
 =?us-ascii?Q?JRFnLoh+lxObvwqzkJJtEf5Fz+d8VcttCElABDeQRebGvarQjxfgkhiUSj/E?=
 =?us-ascii?Q?bbx8Heq6y72LqGHV0AdQrvsih3rWltFig7emJWzztZmE/KFr4S+VtMorPXut?=
 =?us-ascii?Q?jZ4cHLAjVU4/9i51iInUPaJGpoFrMLlvSHXT1SSMoxaWLtXe4mUOYNWrhAMI?=
 =?us-ascii?Q?xp6yONAcn+/ZolmqNfLfHnx+nB9br0qzXg2dGZI81jUNm4ND8LSUKEMmfy4L?=
 =?us-ascii?Q?gM/rCgOQiuVpkQhufvw/UshXYndVREJiOkP0nqqv+nDSEJkYOKyIFnT+cW6k?=
 =?us-ascii?Q?y3eWtHzjrO1KO+W5GUZ4lPur6ZlS24zEkhTv7TVZlkU9Awve/39rO5PwYCIw?=
 =?us-ascii?Q?oZo3JbFMxeavarilgeA+AGL/TB46CyopgMrODYnBoYVeNCPTCZFRZhRmz2Yn?=
 =?us-ascii?Q?N36ugT9r4+mjvHOMH4gkJvjaUxkXT3Qy65nnp8zl1WLgsqUFor8DNk8XgIkX?=
 =?us-ascii?Q?wPudqP8/B0tE+M6l6wtOSbE9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e27372d-ddc9-4da0-02b3-08d8d91278e6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:21:03.5546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J8RIZJQvVq/pWB0oFdOB+JyZqks/y/v2OguQQowMlxzFyYCG8VrnBtQ03/0ugETltEtoDNdeXf7tE8OIirleEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4722
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

The golden setting was changed recently. update to
the latest one

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 80d37d227207..c9b532373cad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -37,7 +37,7 @@ static const struct soc15_reg_golden golden_settings_gc_9_4_2_alde_die_0[] = {
 
 static const struct soc15_reg_golden golden_settings_gc_9_4_2_alde_die_1[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_0, 0x3fffffff, 0x2591aa38),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_1, 0x3fffffff, 0xac9688b),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_1, 0x3fffffff, 0xac9e88b),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_2, 0x3fffffff, 0x2bc3369b),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_3, 0x3fffffff, 0xfb74ee),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_4, 0x3fffffff, 0x21f0a2fe),
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
