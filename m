Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0B8C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D1C664E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1C664E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26ADE6EB49;
	Wed, 24 Feb 2021 22:20:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2C626EB3F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:20:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+sCZbd2zB2jV1oHI6oigJrs3qj5Rddo+x8+GUV8SqyDE8x4gkl2iM4vRUTKSF/OHxhsPtELp2KJ0VCKaXDcETgTNEiVNFQ3b9rvYj+ccpJOTc3veLClyWF61mgjkmkaE7tpV+gLOFy6N/N8g4WwUcfwX6+TGqNVaJaE62mtdA8Xu7FP2Y572FOwCHzA3hnZe6BYNaVTHGeCAJ6J/wOfQPe9epsNu01lm0K9Ju9ppqGTYHSWdY23oni2X4cBYjAWMg+R70BXdD2oyu4G9sy/+CQE5lyuUSNw9WVO/Ca3ggYOJ+8rZjJVBv9fmDG3TPCttSTuMWvN6nmFJjwEPqSr7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qO0StKlLi472VqnTgbY7TrGJivif7c8/ZlDwfso/Y/w=;
 b=PWFpwdxRoLiIHYLwv2RYsJd2vEwtwrdTvlcJNRx+Wiq6ySw9ac/jum8LpwrjeX0VR3Nk9jxInVqoAi+iwACSew2KEKIRHLxkgwxS65O4pt2jPu9FMo4E4de0DhtNy2oNk6cqhNm6Myrd5RNjfmRodfj3Eijtd3r+oyah16FQVc3wj7ZxxljQQ7eXql1brI5VZ3DqwDGLSlid/wgkn0CF5OUEkzH+WhBXzZlg1aakL50FnGu2qUFH46lzIgSAHUGVM/H3ofPrAruHEHf5rO5kqxjONPWQM6dHV9tKRXZgaIuI+OBh1e97nA1NmjQbsqaVcsJKxbIe0LsRP3xeit0HEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qO0StKlLi472VqnTgbY7TrGJivif7c8/ZlDwfso/Y/w=;
 b=mnwJbdGe2Nr4Fx84vwwqXEBK6syN/77PqxUPzPfRYMDVnBVa8I9/1HmWw3CUCyUnyGPZ2zHOqXoP+3Ig9lB8yQWsbJ17/64gGirVh9tUTTevhShSDrLYmtDd2ENlDfO43y0WhAVipqOHHLF0cmGdkJLYLAZbdUXHc5W1jOYJnrc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:20:28 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:20:27 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 063/159] drm/amdgpu: declare smuio v13_0 callbacks as static
Date: Wed, 24 Feb 2021 17:17:23 -0500
Message-Id: <20210224221859.3068810-56-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d4a878b7-d139-49c7-5c2f-08d8d912556a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB417506602BE0511C80839D24F79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FNX6GwdgUngI7nQFPdM7c7eUoGKOUqvjpooynjnAInIS3ASxP4yDy4OTrdyrOQ2Sz2e70F5BYhZ+MtwQXUixPhw6hW5EnEP4EwuWaYtGLK56atCzNgTbMavkT13J7Op8z1GclNocoglJ05Jx1tfaK+K79tHMMO0nva1NlNh+qNPr5Zm/sfsHG6ro1CfGz3XBEZxT+5lMKYrEccdZ0MoxwvbejUxkcIgmMQtryPFQssuhCamkNwJ+S1OkCZSUVte8BAwMItwezECUehu3Jz4Lk9MGQFwANuU33ICbFsl0xU/uSDDBxrlZ/cmCTqY2t0L51986z9ZCjieXQERKjfLvF9h8LEfdPALY+N+iKvKS30MckgQSsxcbHBzAq752T+3Fm757oklPK/w4kmZwPQA86o6DoIfkfypBWbR5kdp2XO9khE+rWByT9nqszHSA+Zox2a4RqRp54lznfMotdgIQAPjT33HCTAZhViapfXnve8LSEWqvK+CLP8pV91VTnvNAtyQItgEbblk5+quj/ZGpwHN73ze8lHIB6tKG2/bIgX+tczikkliyFWRs3eGH5t0n07P0YBZIlFE96yxk4xOg4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(6666004)(83380400001)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UlkcHQVJ/zDFlv0vlnQtniewrkbIjYIZp8BCkbKE+JBCETfPh9CF8zFHRvHo?=
 =?us-ascii?Q?cuJKRoPXcPIS03O4wXwOPzDyO5W46WNk6Ca2dyb3ZXVgm+OgMtSgfpwRHuWd?=
 =?us-ascii?Q?DPfF+swpQIMGKf5j4/BbJCzy/W+EosxU7LT4nmBNR10M566E2juKQ06wTJxK?=
 =?us-ascii?Q?wPzKpAuajdGXYfd6AvJbds1rp+w102utodVg/OgBCTzhE0q3vh35fNqSx/gz?=
 =?us-ascii?Q?5Td7V0CfOCOVf5bG6Aqlg4hj9hVn2tKk4FIgtLBZxmEpNBqWZAkZCl79+50M?=
 =?us-ascii?Q?gEo6zfo7QjsDsGM1PRNKAuZtVBcdhQfKGoH3llgPf0Utcc49B047FZjQjK9r?=
 =?us-ascii?Q?3cwyq/LkdKp/+0s/AnoJfZIo3nY9fNel3PO5OG8q5fBhmzs6L+84BTg+pEpi?=
 =?us-ascii?Q?DgZqC8dcuPWzac/8BcrxiXx/wUfSVuR27SL9q5N5yuLhV6sQDNREI25bUXDx?=
 =?us-ascii?Q?QRGeCqLM+G5JGjdOYcPkbuNIMTIv5Y9qvRkQmA10U8nn2K33pBOFYts3lGlZ?=
 =?us-ascii?Q?V485gjoLMKY0sS7Z2h4LKCuJt+36SVLJWzdyX0/LsbI+sbEcG/OgrQqDDLFJ?=
 =?us-ascii?Q?146Lzoyqfv3IMJTVfUylpI+4Lrkb4mHj5P1eldpNfFEV4I79qSMh0bOzChsE?=
 =?us-ascii?Q?4jQcjWyf+mHUkcJIEKqV4rK0H2Kqp0lUKzeoQVbRyYMG8IO6rh3eyRFwVYdg?=
 =?us-ascii?Q?TOybyOLBz5Pq4JDxodI6RtDENjJEJ3ofePdBWJnSsxQ24HYV0xeyBJqS54oo?=
 =?us-ascii?Q?1pGW67QMtuxp+3DAkb5DY+AJDZMX4gGGgEW1isB6nydHEkDgZFmhsjuAVNTz?=
 =?us-ascii?Q?f+7HLtJm3eWMPd3BMHUcjqyxxbGw5A0cZziAQD21kZpeiVoleDwTVGC+BC8W?=
 =?us-ascii?Q?4UyJXn0FDdaqN2XLbOD0k5EUlfnGB1XDMqhglMY2yy8uHWtyispl2uF6MdI8?=
 =?us-ascii?Q?CQc+cOZEzp7jUNiebvSYcUidjSi0pFvkY4xi1MnfUvjUfj82phzsuNN9b4cy?=
 =?us-ascii?Q?XOw0OSu1QJaRWfY9otQEgF7gWchrY3giI4VlrGCyywCHVu7jSK6kRijrulNO?=
 =?us-ascii?Q?Ze4Ol9tFg959bd0ZPOdpbqVNBtGiOTaaKV3E5wg+QQ/3YCUwzGiT4DL1V9lF?=
 =?us-ascii?Q?hr5P2PVQ6T3Vhqr44juvOIQJCqeaY1Z2BQM+gJugdciaZjMs5CzT7hr3svpr?=
 =?us-ascii?Q?Io4asupMw5zdA1DyufsiirQpBhu4U8eLrIo2zD/8l4fx1DR6YVLEIjMGrde6?=
 =?us-ascii?Q?D1PQfBB66THPXuj0l60kabXgxO8ylWv+mm6kEpaJ1R9y041jKgtMZ/W+qF93?=
 =?us-ascii?Q?gFx+OGiN4EKhT+GiKZQvY6FJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a878b7-d139-49c7-5c2f-08d8d912556a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:04.0678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Wk0ZPseaDU8H6LQ+40PGsW8K0t4NAL3oF/pWYHRf7O3W6VK0/aVqZRB3t1fm9JdOY5Dvb1V8ni4B07vUE2/ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

fix -Wmissing-protoypes warning

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
index 31817b604e28..079b094c48ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
@@ -37,7 +37,7 @@ static u32 smuio_v13_0_get_rom_data_offset(struct amdgpu_device *adev)
 	return SOC15_REG_OFFSET(SMUIO, 0, regROM_DATA);
 }
 
-void smuio_v13_0_update_rom_clock_gating(struct amdgpu_device *adev, bool enable)
+static void smuio_v13_0_update_rom_clock_gating(struct amdgpu_device *adev, bool enable)
 {
 	u32 def, data;
 
@@ -58,7 +58,7 @@ void smuio_v13_0_update_rom_clock_gating(struct amdgpu_device *adev, bool enable
 		WREG32_SOC15(SMUIO, 0, regCGTT_ROM_CLK_CTRL0, data);
 }
 
-void smuio_v13_0_get_clock_gating_state(struct amdgpu_device *adev, u32 *flags)
+static void smuio_v13_0_get_clock_gating_state(struct amdgpu_device *adev, u32 *flags)
 {
 	u32 data;
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
