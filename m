Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45898C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 16:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2EA22067B
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 16:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W8jTyOB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2EA22067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 818B16E428;
	Tue,  2 Jun 2020 16:22:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41A796E154
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 16:21:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEmsK6VTvOsXVGeYn/StgZ0zIzWHnhQ3hWWUYmTYh0FjPs+yCLC/v3fOJaljnyf7Ft205i2WjxySB0qk33btz8aDVwqVqVIOcA6/plCKqli4vJ91APy2fo0lTkZRgPtQwPbunTZXiL2m09icgM2mP+63NblQgXqb3I46CqGrstm12H3xrIDqM6PTIFXvx31BrhShVNIrpwJchjmV/ytUXvLq3abJZRcs6wa9ILoa9JrdmHl6G1w69hoTQ/hZv3QYYQQPeXwRwgSKrDL4dCRQ25DEu5IPp2XW45oy6ag24h3DK0pc/odQCLiZBlLohw/kM7ZP5IJpSSETn2aYpgQQNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+mKZ/hrD/Vow6aOSOzkSlI3zBNXi24WpVkZ2OcaItA=;
 b=hxee+1azjg8+jdHqNHRTnup7lyHfoYuhD1VwtQrJqdHNQjSktPx6QeYOgfa9JwBID983vNkOCt9U2vv3k15vECrfusgpxBU44xOPZ8euWySnMIFbdJD9pLo0wd4jigBns7FafiUJsTTrn7B95Cp6X9XzuTmFQ6pbJylbYS7bob759ruL1ldcSsJmxkfkOyXaBQHW7MGhEEofCBEBjSpRKnmHK2C6OsY892uOyZGWlt1JpY8H3cuitWi+x1yxWu+gbpHjpHZwE5gnyplTJCfXnnKJAeTMxKkFOKPMWpHIA3KhxzNRXpyFi3Hrm8D8WcUdlLVepgC3wLlPfNZRtKi2qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+mKZ/hrD/Vow6aOSOzkSlI3zBNXi24WpVkZ2OcaItA=;
 b=W8jTyOB3jskb9VMtORcjzX3eRMMG0OC0VTPuEHuOx4T5sd6ckkx7TMI8y32yx1cBbDjN7IIotBW61h4f+EXjKuijAA00rrY4u6wQUe33vIcHLXpZ86yWM9o5AwUu5YIV4ZdkxrI4uXaYcLASmnaqgShKhS7vlRniAXjcThEBBn0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB3116.namprd12.prod.outlook.com (2603:10b6:5:38::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 2 Jun
 2020 16:21:57 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648%3]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 16:21:57 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: Add ReadSerial defines for Arcturus
Date: Tue,  2 Jun 2020 12:21:47 -0400
Message-Id: <20200602162148.21624-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::32) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YT1PR01CA0153.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19 via Frontend Transport; Tue, 2 Jun 2020 16:21:57 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0c6213f1-c481-49d5-3633-08d807111236
X-MS-TrafficTypeDiagnostic: DM6PR12MB3116:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3116D032BAE2CDE2D8FB5198858B0@DM6PR12MB3116.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: db20sfNjMfZKhgP5SVqQzZ8imigN09nb5Xt2AitlvL9NMLOQpAYvGGIsuFSUGNBMy5PhDQagUVY3H9vNriNjLrfECpECHqgc6lF+orp3FvY7ascQnax4qW8N756rzT+Q5v95WulDpiEkEqII/CAK1wn0rG/Dv3nk1ZBBtZ/gLFnRgK616oGFqN73Z/XGQL9EY0+9vg73jb7v4EMAZXa2TH5Gw+rxR/u+1M2OYkqXN4Takg290u7Ur1ddbNM3F+ddg0gU4IrpTV1LqcBmbcOBw2GF+p8KiLZ2ezFBFlgtgxtzp+v1r529CsHhDFBi5OLR8f2pSJLVcQHLg1SY2ovVpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(19627235002)(478600001)(44832011)(66476007)(316002)(66556008)(66946007)(52116002)(5660300002)(86362001)(7696005)(1076003)(2616005)(83380400001)(8936002)(16526019)(26005)(36756003)(8676002)(956004)(186003)(4326008)(2906002)(6666004)(6916009)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0Vjd09YXTqXt4eb+agkL+sANhf/R+tGjRO5xe5MO7Q93GF2gxd8mbcZjE/oWEiGgAkaif6iHzAScH6uFCdsc+Y7pAgVH///OwsFqngxqj1oYDi+Q7nf92Y1nATiAM3caj2TtGpJid0tp0YgkOyWLJPjNxRZo1jh9pQZ+PBduL43BWU52fDgKqz6bSCI6QM2rxjIHn/O8w1NeDJGwCvwo0fdoHea7JZoxWV3TejK5QAH6/Zokswz1NEZWM7n2/fSggjuJgppZH5D2c/hYLyhYGvo08JALEcd/MQNlgAbDtRd+z8ypiULVsdobQTh/HcHsGqGv6Dcnl7zFooWi4cTqiVk0EhwFrSEfGCqt/xNDdTKSKAzw8zArNTmsPa4j3aNKGxBOTtQTao+xrjcVpCjqLOC6EVN6Znp5FQfE8Uyu/+jVdqzcMBLIP5Xh44rmMALpf9lsIsEUi+pSXQUWMf6Gis4vHyWrnFUqvQYa07gKHp9Oc41ZmPxDTOGd1PbQhkc8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6213f1-c481-49d5-3633-08d807111236
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 16:21:57.5775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IW+NiOEufeNHQOwnfJufXcHCyZGZeI5uLiK9igYrB/qP22H3/XuR6rTj1CNbsoFFJtmHbXOMdk3hNke4GSP24Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3116
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

Add the ReadSerial definitions for Arcturus to the arcturus_ppsmc.h
header for use with unique_id

Unrevert: Supported in SMU 54.23, update values to match SMU spec

Signed-off-by: Kent Russell <kent.russell@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Change-Id: I9a70368ea65b898b3c26f0d57dc088f21dab9c53
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       | 2 ++
 drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 302b7e9cb5ba..d66ac7457574 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -129,6 +129,8 @@ static struct smu_11_0_msg_mapping arcturus_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(SetMemoryChannelEnable,		     PPSMC_MSG_SetMemoryChannelEnable,		0),
 	MSG_MAP(DFCstateControl,		     PPSMC_MSG_DFCstateControl,			0),
 	MSG_MAP(GmiPwrDnControl,		     PPSMC_MSG_GmiPwrDnControl,			0),
+	MSG_MAP(ReadSerialNumTop32,		     PPSMC_MSG_ReadSerialNumTop32,		1),
+	MSG_MAP(ReadSerialNumBottom32,		     PPSMC_MSG_ReadSerialNumBottom32,		1),
 };
 
 static struct smu_11_0_cmn2aisc_mapping arcturus_clk_map[SMU_CLK_COUNT] = {
diff --git a/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h b/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
index e07478b6ac04..79afb132164e 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
@@ -117,6 +117,9 @@
 #define PPSMC_MSG_GmiPwrDnControl                0x3D
 #define PPSMC_Message_Count                      0x3E
 
+#define PPSMC_MSG_ReadSerialNumTop32		 0x40
+#define PPSMC_MSG_ReadSerialNumBottom32		 0x41
+
 typedef uint32_t PPSMC_Result;
 typedef uint32_t PPSMC_Msg;
 #pragma pack(pop)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
