Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF47C433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA0242078A
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cT8E8m46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0242078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 429FD6EA86;
	Fri, 16 Oct 2020 03:28:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99CB46EA86
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:28:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqj1QKzXsaan0Lq71ABcXKxKLymulKeSOVPruOwIMtGzWsp6rSjj7R1mKVU7TuRcRiJ1Icid5lUcyl/gWbvR2LCLDGZ2rqoE1tAAI6k+3BHkUj7dYVcg3F8xbbDyKDUN9xPyy99kp65ajuJ5Yt6+Y/jVAS0PCYR6m2R7zNOXIt2qoVsVXYP4ss8SdRgDXKERMy6Rx50ZpR15d2YWIC49cJOZrBIZRsxwj38Gdzvvw3rKI8l1lfCSS96beGGtyY6TSLJTNMXJZKoHk2O3i8kFzf1WZRYJKyPzNmSq8+ra07KKc/lDtfCmDrSSnYDnBpe0YA7JGu6AZ3YxhpvglzVIuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcxhzJ6GTqdOxTgS5U7QnkGr+HE1IZQcyBUsVIUzuV4=;
 b=kS1MGaIJvaWHY0nO167qNOPGv8d5zEap3ZUp8/8o5EMMDKfTiBRkHAcOyqXONOndVRjGG36gyQvzDbSARS3+iuxGSHajShgA3KZ6W/r9Qozih7v6XKgrwyCnjjcIpikK7yhUf16dyIh+c9rdGu0K7B3ZvlF7k6uSRfjk6orRhZZd2ZAPdFXiAZLBDpPgGhtdVNb7lZc2edjl7vSLqspUVvHtyg1r2QULMZeQMNNcxGSAnSOAGo/EkGhBITDVYje4w4Oc7q78YbDL3oZCinPSyHfydS2V0jOrpVwQtT+BZEo0TUOjl3jrVYNyu/zmdjvl+Wu+Ot1a7fVlDZMHNHMjYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcxhzJ6GTqdOxTgS5U7QnkGr+HE1IZQcyBUsVIUzuV4=;
 b=cT8E8m46XAJIB07JSK6+Gs1q0CpfZAd6Sk/sLCjzL6tO7MatPwdR/oumWcPk8sJ+O4kE7dEmJ962wvSXlWkuJjtAeDfsc1bAuhP+1g2kyHqD6iJy7DybrfnL8bSDR5vKmPo/SHrKOBG2fGAhdh3o2UyY4o5Of7whKCf1TjGUodg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:28:31 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:28:31 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 33/40] drm/amd/pm: correct pcie spc cap setup
Date: Fri, 16 Oct 2020 11:26:45 +0800
Message-Id: <20201016032652.507-34-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:28:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25c67426-ac7f-4d21-c464-08d871838e08
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13545BDF1AC84B0C789DE586E4030@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FP/eVF7zqaeHHPaF9Bq4Y+dBNDQLhgqqK/ytHZIJNlDDdWZ0gkpWNdQoYyzFSlbSzIenTQO4EJjD+pNYA9i0AvClvZOYanC3p6RKX03XylF7tET27HOg8q77y6T5YOKrmuHQCvbPyeMUK+sY3fjvjjqrF+1RT9vHOotyi/4q4jUNQ7W50rOqyUcpk1ZOn+p437eCjgByw8I/KLXUqZjtw/KSIPjIsK37ico3HpxgRZvqtAmi2rIusaPs3vWYX582mLg2Wn8kGdHDHFGamumdZ2m7OXM28iha97YyqhNoYnvgitEXDxRvWcgiXauR9bnaJocDl2skhUwTOZVUjkCME1waPMdD4uMS+8LygtLbUJInrwAyVxQ/RDordx6b1b4x
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66476007)(66946007)(1076003)(8676002)(6486002)(5660300002)(8936002)(66556008)(6916009)(86362001)(52116002)(36756003)(7696005)(4326008)(4744005)(2616005)(34490700002)(478600001)(316002)(6666004)(44832011)(16526019)(186003)(54906003)(2906002)(26005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Y4PlTY8WbK5S3B55p7bZmKVOkq2xKsMkPBlrS5KD7Xwet6ymctAZSuGUSk/aLa03hrjg/li20KyjBKnOROoOTJB7CeeCY6CWMOaCTir14s1u4FHh/Pm0yP3D+/vdarSCibPRofNdpOLRL3bAL06HPtetRcvlsebRjQQ5VIFAGX/1ekjW72Vu58W8B6uXuY/W4ZsL63FQ52gJQNzIwhhWZJbafNP7cZFH0nPvUnDNfwdhk3J9I9e7gcKSDbvNn0a9FMEaSsLswZka5KkoQSchzSICAnoXIZorRKDyf2ehm4fqyAV3Ylec9jY4M808O5zACPBuowTwJ3c57rB+wuq3gHGhkTEOsqeGUl8eVMpFMGAdtSHdhnizkVGQ3VeKmX9R7HIXeAjmT/3U4a99osKHQvsV+igziye7w7h3dK9bADCGzT7DsjovFnxpJf/S9WAt6tolOkClWxWgfhYd0fuYIXT3Izg17Jfw+V7BfhBRs0e9C6XYRsZMR/6hWljJtgmWGall2COozr+X/NJdLMZW2iYcgTyWGzCCFb1OlnWBYWVdPW0E7Xy0D4Cb6w+5z2or02oewUuTcGeJVW5UVtQBUrm1cRlb9dW8TgHCbDtfM5vD2xfBEMncGTXNVjXfL0+rPqKNEpCBhfY7k0sSXuxRtA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c67426-ac7f-4d21-c464-08d871838e08
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:28:31.3827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LIeC0iPfuQwES7okeBXRq4sgx+k9i77r9qku6OWaqefNSjG61rF/L98yjp5p/Dn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct Polaris10 pcie spc cap setting.

Change-Id: I7f9a65cd615c43a62a38713a07290e3ec5afaef1
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 7eca860236db..59c199cd7aeb 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -2865,6 +2865,8 @@ static int smu7_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 		data->pcie_gen_cap = adev->pm.pcie_gen_mask;
 		if (data->pcie_gen_cap & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
 			data->pcie_spc_cap = 20;
+		else
+			data->pcie_spc_cap = 16;
 		data->pcie_lane_cap = adev->pm.pcie_mlw_mask;
 
 		hwmgr->platform_descriptor.vbiosInterruptId = 0x20000400; /* IRQ_SOURCE1_SW_INT */
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
