Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163A3C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C189D64ED1
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C189D64ED1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34A666EB59;
	Wed, 24 Feb 2021 22:21:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABB376EB53
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKt6WW+0tbAdhvCJhd8GmuoKzhZ0Bcsx+TmNiDoUmeL8cVa/HmYmFtGWzVXleMoS/sqDFcXHiYaZRvo3JKGk//quIdTy7hMkrafHNIpAMy0YH7fNa+umZGlI+hwopurWn2KwD6A2heEwE64iaG3aHaeubqg9KXzeDsTIECb2a70HIb5b8YCsgVngkRh/ksSIFmvdS9LjsO8vWz1SKcuLU+uaJhmocEBmEAZc3cHcF4R4kP5V9STI2svJ2FA2Hy5GETX0bHiBLlQ03eyoglh1y2YOfBd4BhnGIkCDYqcwWQX84BLcoEOFOGRIWFf2vX5AwT/5pX5hj2VAFBJsgZdXhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0qANXH02JEXEHpNoqwczRdFbGB9LygSsoHmi+EsAJc=;
 b=PyffxcJk6cuVZZnVK3PDu8lqa36i/O9oaPP91zG6xfE+GOce24dv3jIuVJ5gclvBwuV1G9A06C7+MHTwE7z8JlcjDqxHck4YftZ4CR+bmsZG2xnKCHWMKRKJ3OOv/n3TSk+hma/aTeDpD4x0UYi28++44ehpou9XzThYuc55r/j2s+Cs5DhURDWFqqvMbnp3gOPis+t/KjHVeAIkhSLlLx4+c/beLuvZ0DpQHgfnOu52iPrqMWkFm6EPZcZ1OOc89uHam6qbDIy8/l38mhnDiOCefaQJQtBUO/pk+wqCL6/yZB460ceXMhs9cN5k6FjcIxKFFt+C8IZC2aMzACFYgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0qANXH02JEXEHpNoqwczRdFbGB9LygSsoHmi+EsAJc=;
 b=eYNP7NFwKc7OB8QMMpixFbI6fbahl8SixdOEvKme8lZ3PYKj//SGyYTbLg/QLbbTJltn+rRW0bCctb3P2+wXrEx41XOyl2FH9/RJFH32+JxSYUYnWcuuv4OzyCNkRT6bQ8R2T0SFOAGR5z2w2kSRgmWHrsiTrv2T97oGo/alyj4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2497.namprd12.prod.outlook.com (2603:10b6:207:4c::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:02 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:01 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 071/159] drm/amdgpu: correct vram_info for HBM2E
Date: Wed, 24 Feb 2021 17:17:31 -0500
Message-Id: <20210224221859.3068810-64-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 84a1d1ed-a9af-46be-4b7c-08d8d912586c
X-MS-TrafficTypeDiagnostic: BL0PR12MB2497:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB249776CF6D62BB259D952D15F79F9@BL0PR12MB2497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vYNI1WUkQBFWV/008Cu1tuF5xHuvOojJLNbqzq3Urf6x1rqiG0kxlgZiLUUVmAS/3WZk76mLYY28Bz0gEsu1qI4s1ktEf5Mb9uWBb/obgZ6m2NVW5XhBg0XIXcnBg06NXKaXnZZAD5vFFhOMuOAp1hLH0naBtyDpCNkdihbZUpsTDUDplp+UE/68DMr8yJeo5Bo7J1XOYnwSP5RUtJdV5VuML44liX+PYvt2PcUv3RzyHJ9BpzEzwCWr1kQa1Vp3MN+MjITxYSxs0GUJgfED4yVNMRUDaMROmPN7cjVU1O1RhpSDWyc6adExEf+QN5Ng4dzEyBq6jFV3LddjE3Pz8R8fdftea5P/Cnx5iRzm19i6MM0mEjY+GK5ly9iDoOvMtJmqqx/h9xQbDFsVtAFGY0zwuGSy+/TFNaSklQeLDisXoxIWRn8SAX4voeQpVEmlCtknRVKUTY1cNP8RFmF+6j4NBUH2MDd+fU/RKTwUTmj45Pb3k/q3VVrPkVs1XmQ21/OUTJgfowLpg/p19B9FyL9PToX31e/8YWRVL+LINjOimiX/PsbJKpwO9PHyf27onqdZSuDTyBjQfg+qLvxXbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(4326008)(69590400012)(8936002)(6512007)(54906003)(6916009)(26005)(956004)(6486002)(316002)(2616005)(52116002)(8676002)(6506007)(2906002)(86362001)(186003)(16526019)(36756003)(6666004)(478600001)(83380400001)(66946007)(66556008)(66476007)(1076003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7V9UaohTD1YHZrLw4/79+a3wh1y/MmemsETwf2+v1EBzCOtQQgt8iIAJZRoW?=
 =?us-ascii?Q?B36Ebb3yUhZ77gcetgW4uHFJOdFj1luamSPKXaNCrQNQMjeyCk1cdEWddlwn?=
 =?us-ascii?Q?lRPw3aJXXwJkhfIQXrkt6zZf6OJ4wzWpHd37VMFNqwP0nDzzJwl6Q/16a2I2?=
 =?us-ascii?Q?FdmaYryQoMo2h2irP8B0O4ZNpPt+HydGjcvH+WGq0OrMmKjmWhIOi6xVlrsS?=
 =?us-ascii?Q?Fj+g6oGSUyc2+ZGw4ViVWUmvmROhkB7byXC3Y3DBUZRV+7KMWldFHM6mfY7a?=
 =?us-ascii?Q?hnHjj7iE+Oiqr9KcSKjuqbO5ZECPRVz7RdSIw6SMTcAdkQ6z91VEKbmmpcH+?=
 =?us-ascii?Q?nc5ndAtad6PCfYI4g364rB8zv81ICQ35re+pQ629gheuSL1WE7BG4Vd0VRpz?=
 =?us-ascii?Q?MVWwYhUd4kY3ByOajQrmuOzpUG5LPVS1lGuibCRhxEKeJOtq89JZo4tfzzCN?=
 =?us-ascii?Q?EKybfr6ucBOaovgMkR6UGwgSR1vuer4N53jh5xVoia5thC7osY6NZ703qQrl?=
 =?us-ascii?Q?5AlOpc2nVfab8osiGSj8ciJTki5mfyKsUlZBkxzyrRzgeJMIU2U2FVAh8IHv?=
 =?us-ascii?Q?JxIIxGq7h+11vWKvnP8fBHk2Vj7YpmjOthZ7oHZQWkfbuUVyWlIRsNWAr/7C?=
 =?us-ascii?Q?hvs1WwlBGddKAamPe0a2VBvoi2hWnoEroMU32VpO8Lyap2+l7Tmrxu43Nv42?=
 =?us-ascii?Q?dWBTgO/zhh56VWh4BsOYdh1H0b9FsZmWofyNotA+ZSfhnWXpHQoaEr2WeEN0?=
 =?us-ascii?Q?4OfxT6evsK/rsN4NV7kQhh5zjUQZL4U9D0hgYflT9k9PimEGjIyxISRmQewV?=
 =?us-ascii?Q?ah9S8vW+thwj52XBByEXrHkKtVNZD7rgmsXxiksoKV01JI9B3t5lmpKy9shR?=
 =?us-ascii?Q?b2loOpHTWlA/YfKgRZUcWCW5HSqD285tiu89Jmt3W+7XUkowacWXe/l2RbM5?=
 =?us-ascii?Q?1ROnJAJHoWGBv+5KqW8VJkH0HvJnIYXRQ6fN6NR8NEoIFw4mcuCxkgXBp1xn?=
 =?us-ascii?Q?P6TmtfplAFttJCipRagmEZ3iHQk3xoSkySHJJC+ZSRP8UEysEokAv2m/8mHF?=
 =?us-ascii?Q?tGxSId7zb3AGSDhrBd9cy+VZZNeY5Xc/zs54RYFJW3sYZnUNMGXoUkjFAKuq?=
 =?us-ascii?Q?DoOOgVlIQNkSoxiVopF7Ucy7kJ+9qh2LZW8LoX5f14ayFgL5X+7SNIulurQt?=
 =?us-ascii?Q?bKWpXLcWw6jKFbs7HkTdH2ddHvPEQ8StQ2eiZrKs9SGtnXbaOuV+4sswGmYq?=
 =?us-ascii?Q?G4K0xWOwariGTsR1eYTXlbDqEMaSCSSijOZ87j8pMeSNPecZEeRmONJNriNv?=
 =?us-ascii?Q?bUqsKEQBxoVDa/AH/bs9QR2A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a1d1ed-a9af-46be-4b7c-08d8d912586c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:09.0858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pru9l3St9BiQ2/v3DqKvXxIioDjJt0SspDRWMYN7s2uq6foSFkNM+00X8vQUjGp9C0HAuRCybCXXx22aNEZt6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2497
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Feifei Xu <Feifei.Xu@amd.com>

correct atom_vram_info_header_v2_6 and its vram_module.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 266d949759fe..d338f2db1f9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -123,7 +123,7 @@ union vram_info {
 	struct atom_vram_info_header_v2_3 v23;
 	struct atom_vram_info_header_v2_4 v24;
 	struct atom_vram_info_header_v2_5 v25;
-	struct atom_vram_info_header_v2_5 v26;
+	struct atom_vram_info_header_v2_6 v26;
 };
 
 union vram_module {
@@ -322,7 +322,7 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 				vram_module = (union vram_module *)vram_info->v26.vram_module;
 				while (i < module_id) {
 					vram_module = (union vram_module *)
-						((u8 *)vram_module + vram_module->v11.vram_module_size);
+						((u8 *)vram_module + vram_module->v9.vram_module_size);
 					i++;
 				}
 				mem_type = vram_module->v9.memory_type;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
