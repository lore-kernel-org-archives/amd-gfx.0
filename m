Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D38C4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:29:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B4F223B86
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4F223B86
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 930F16E92D;
	Tue,  8 Dec 2020 19:29:00 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760087.outbound.protection.outlook.com [40.107.76.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 010F16E92D
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 19:28:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fN3gL1fuVv3dq4l0KPLl+SH1SLpQwS/otyLqYSzF2Tjg6Bt/pDDjB8KpuZMqcZtFKvbN5VBWE87sYH8NgjWrLYnWZ+7bASS4xBOguBI21xBB1h3Db9zDPFWrHMIlSNetz8WD4FxEsco2w9tAne6XFa+tQ9hapjtP9exVqDwA/A/e8X965XC+dXXifeuIS4c2CJfdKc5t2J9pGT9KE/JjP6P+EpWUhloLgA5z3lAVuwxFG7VzfVZAxMJ9RoK2tgKdv2QJSSSCGlnakwHLc52F9K7d0RZtrkPe1+es7ln8ceQoa8PhHHf0hvmnHjr90qdmoPRWgm8gzC1SKzHQesJ6mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrY0rfKXo/O0m8sW/8wH1pKxG84hmb58mLQTWsz81T4=;
 b=N5AArZhdiTACuMDYQgby/mh9PxxJnKcCNE3tTPP4ycFf8TZvIbdDAZMYiRj61ye3gZT4o7QD6C2TbG8BGLI+asKYy4y3s/Gkwv3HgH+uQW7d7LhD6OKLiZOEABz8H5tZDphHIh7NThz6mV4kNiiJlMyMSDcwS9s/GuWtyVkR+QgDKpjAKpWo06tZ67xPKGd/AIBZ7mIdXUVF4R0Lm6vXn5G/y1clz+FTgc2GHvUcDZSSNfxtMwXuEMILvJC8PgT9Ppal3WX9Coapf2BAUKppkhSdO3fkGJYG9miYzaOYRuvYaKnkfISnoG9sANxEycW0hCxmzsQX0zrX/VWBAGV43A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrY0rfKXo/O0m8sW/8wH1pKxG84hmb58mLQTWsz81T4=;
 b=p2aAauIOfcehiykadGMEuZAWBUPLXrsIBUr4+HuSCrM9Zz74/UiMgRrxmOwfcrffspG8ZLwwE+zC+0Z0XFK4QvkEakrjzDI/1+F9YB5W7GN4jpW4PXlbr3JyurWyhHi0IlyXXIOKIpEJYkKmY0IyptUnEonuPhdqWCu0E3Uw7kA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 19:28:59 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853%6]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 19:28:59 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/13] drm/amd/display: Fix to be able to stop crc calculation
Date: Tue,  8 Dec 2020 14:28:35 -0500
Message-Id: <20201208192844.23580-5-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201208192844.23580-1-qingqing.zhuo@amd.com>
References: <20201208192844.23580-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::32) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Tue, 8 Dec 2020 19:28:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6e2ccc4f-54e9-45dc-0339-08d89baf82ef
X-MS-TrafficTypeDiagnostic: DM6PR12MB4388:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4388D6D30D179638F2764328FBCD0@DM6PR12MB4388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uMUjVCxfr2qJlbn+28HusMEXarhkweWBWBD4PEnyLZzCM+k2LIv4Uw20K6sQ9oTlM8q2pVtQRxqOSaip+Uerh0Zai07jH2fTmWrRIIRzkHnAHvfSOL2MTGUvTU3QojsDoL5DjGvGwq4Tm63Xez/utlRtuzPrEmuDFXG7oq1Fk92fYpnd6gOHXHjQj6VFdGtY7PYebK/AcIpbgIBZHBAZf7PJoRCuj6zA9V2DS8HV3Ejf9zbc5ruzisQZgCV954BW1T1Umq7b6ypNMh0/odHIOrVasgh7+jg52pVBKbPn5Lt82OuLPKI3q3mrTNHp5PjOmPKXYV/9m+DQR+LEGohbXHKSvUCkVkLZlhTyaMheT4mXMIngfuOPHX6/uPV1/AZRlY8LKtYp8AZrQ6UTT7AGh6mMgki8t2hyExv2DZBAkOc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(6666004)(86362001)(83380400001)(34490700003)(6916009)(44832011)(8936002)(956004)(2616005)(186003)(6506007)(36756003)(52116002)(66556008)(26005)(6486002)(5660300002)(16526019)(66946007)(4326008)(2906002)(66476007)(8676002)(1076003)(6512007)(508600001)(69590400008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3uTIKcgBt6EkhswSo4Y0ru9DDXuRN4N9eibx2NiNLACwHbFHOmw8CV1fdPNB?=
 =?us-ascii?Q?LldtQ5XzdTtg+9s5Vmz0bS2hfJoMeD7gtFQsJxEhxaYkNaVlkVsOffFJyAWv?=
 =?us-ascii?Q?zvevlkNHIZtiH5utFoQShGOQY2SqZ9e2teUY3PjNqjvjtVEedRUnK5PZtqyo?=
 =?us-ascii?Q?YEACRwaPXsAt41pYPqwASG05/CXrvtk1pBH7/D3XkoBYmc5DE+/iNLZw9u0u?=
 =?us-ascii?Q?XAR4T+nBvXxrDIrhV3MTGoW4i9TnSifj8rL6hlgQR9gudDYirBici5CKjiFS?=
 =?us-ascii?Q?IxADUX3oCll3n9RatMdwDgT2m6yMiZ+BukQt7rUNqva0j8gPIObdMtsYw/te?=
 =?us-ascii?Q?xQaaOlHFn/ryyp0MIRNKPHJYo3qQxP0Mag9gGokvVi4t8Z9Ucr8s6gyCK0B7?=
 =?us-ascii?Q?TWisro7Sd+jhnhOjtHi7kiteWDF60ZRXurcggx37/zA6Opl+zipWUA+H09Vm?=
 =?us-ascii?Q?KfF8P0jlJNUUFME0MYUDl3Z9SG36Q/LybvGg9QOmDbK/ABAJ6CC4lw/gbexL?=
 =?us-ascii?Q?OdNYJcRyj2f3y/A8J1szksKFobRby/D1zQGBAzXRus7thnv/bi9QPyR+anKy?=
 =?us-ascii?Q?TYhZoqxWLXipGlEZYVDSWMxO39n3PBDVTAWdOlnaUviMG9808v9n6NCD27Pk?=
 =?us-ascii?Q?0Zm/JoRZnNOlUwFitzf+NmL+K/vvQ/ugY7o+mCY/J4Uwda2eIZi7wL330GdB?=
 =?us-ascii?Q?tEosH55k7uax/H8T74XkDWMZ/gZr3xXWLDx7C3EeIR0Mm80ZGO5IOgaIONl8?=
 =?us-ascii?Q?H+1O+U1sKJdnw0brk2hMBVK/i6ixSFi94TGn2RWlSrjYoGpL552uGOd8nrxB?=
 =?us-ascii?Q?dy5eMJK8UFecMLiHHA3MqQum5MerZ5GbPADadioeeWMoluHdByAakjRU/xt+?=
 =?us-ascii?Q?CjCD258EqAWXjlh3+36I3eV1B2A/Po6bOsa7969ZsdVc/ApmZaGQP7qef7eF?=
 =?us-ascii?Q?QHJVOM37YifKq4CIS4mLX7kHrVnKFIrIvEJSwHHZNw7rMdQkhMYR25tZ3ddN?=
 =?us-ascii?Q?qg+l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 19:28:58.9680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2ccc4f-54e9-45dc-0339-08d89baf82ef
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSmgoop1dAAD+owYNuCzbeywscEh8Rhdg+TPfDmMLjNVT2MjDB/nDv3YpuKCyVK3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
Find out when we try to disable CRC calculation,
crc generation is still enabled. Main reason is
that dc_stream_configure_crc() will never get
called when the source is AMDGPU_DM_PIPE_CRC_SOURCE_NONE.

[How]
Add checking condition that when source is
AMDGPU_DM_PIPE_CRC_SOURCE_NONE, we should also call
dc_stream_configure_crc() to disable crc calculation.
Also, clean up crc window when disable crc calculation.

Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c   | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index ff6db26626ea..7b886a779a8c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -81,6 +81,14 @@ const char *const *amdgpu_dm_crtc_get_crc_sources(struct drm_crtc *crtc,
 	return pipe_crc_sources;
 }
 
+static void amdgpu_dm_set_crc_window_default(struct dm_crtc_state *dm_crtc_state)
+{
+	dm_crtc_state->crc_window.x_start = 0;
+	dm_crtc_state->crc_window.y_start = 0;
+	dm_crtc_state->crc_window.x_end = 0;
+	dm_crtc_state->crc_window.y_end = 0;
+}
+
 bool amdgpu_dm_crc_window_is_default(struct dm_crtc_state *dm_crtc_state)
 {
 	bool ret = true;
@@ -141,7 +149,10 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 	mutex_lock(&adev->dm.dc_lock);
 
 	/* Enable CRTC CRC generation if necessary. */
-	if (dm_is_crc_source_crtc(source)) {
+	if (dm_is_crc_source_crtc(source) || source == AMDGPU_DM_PIPE_CRC_SOURCE_NONE) {
+		if (!enable)
+			amdgpu_dm_set_crc_window_default(dm_crtc_state);
+
 		if (!amdgpu_dm_crc_window_is_default(dm_crtc_state)) {
 			crc_window = &tmp_window;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
