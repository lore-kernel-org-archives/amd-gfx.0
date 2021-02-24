Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE44C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FCFC64F03
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCFC64F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BA166EB66;
	Wed, 24 Feb 2021 22:21:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E1696EB58
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlgBubXUIR3Dp670M3VmmTYkitFeG4FxxNX94PhLm66XJMg3axin+52d2QaiIFfCqL/nTN0IGpN0j1DIsscOj/uNVgLSyMBDooWh6VZQRUT4wueF7ulwyDO5QbB0ACtJh+aI0EFS7tRPSsLqic0wONgBFfjTk2FQ6QHARH/ND9ZAzgYHwvVGljP58Ui9AEXLavEpsMm437b63mQwioSMTetZOqA0xZisOkE9Wxk63LoScRfLscTWhgTA7AJKnLlJUDReBu1Ejc9dyKPfyBxDNwgsf1inijK5gT9P09cSv9EBq5ADbeUnoebYmet64OuPz4Uvsz/IEmRmWLF8DHfsgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+WdRv8++LiessERVFlYRqmOrrj9USV2+XFKxywhj40=;
 b=KQMnq+/Hl6doZhg6kX2LfaKETAvAb0u2BzORCLuG9aZsX5UYSwN0EoxLZwQGcnANNBs15UyR4yPEVBt9AdN5wTTFqqx7XlnT6F8MZsdsDNoZZBnCuf27q/0tJ20WRcPuitMbwRQRDFf0vJOiw1YRd4FBvhw/s0FE0SO3KAbaK5PHZmIkp21Vb8vd9xShCftBK1UzUFbnQhniDDLI4jXBe7/Pejz6CWp6KRXMdTjb0YagKAAxvi2XM90mvLjy9l6mSikMEsq16Q7yJd9l4BwYZq6DQAatK2JbsOv3u6hAFxXfB/wZedTWuF5U25HeP0D32co1ywKMLh0w33WzimMfqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+WdRv8++LiessERVFlYRqmOrrj9USV2+XFKxywhj40=;
 b=LNmdsKxdr692ZSxpBCtXSzw+9zMkLppFwWKUtuvptywWROgvlIsKcFyeVShNATvUKMQ3Y9eRSIUH/brRZBAS17dttFW1/OYVHhxTqMHXZJ+5ZEXnoHxvCJDmILWqwporCjCvpFvDa6Rk3vwiXwhDeNEvMaSYD6jyhdy7Fsqse70=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2497.namprd12.prod.outlook.com (2603:10b6:207:4c::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:06 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:05 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 080/159] drm/amdgpu: add mmhub ras error reset callback for
 aldebaran
Date: Wed, 24 Feb 2021 17:17:40 -0500
Message-Id: <20210224221859.3068810-73-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 981622da-3053-4b58-9b42-08d8d9125c06
X-MS-TrafficTypeDiagnostic: BL0PR12MB2497:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2497DE44F7C1F42C905F1FD5F79F9@BL0PR12MB2497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UmDbmYW/Ydw4ByNo7yrdBv30A3jqY7IeUGRsQRY7ISVhZf3HsssGJkKVvE80qL9oiTMntgXPPw4C3PpA3L94C1aekSAkj+IdpZxI4ffoRGq+qdXi1Pwy7kkxLAcfzm7iTfGWGHIZQsS1kK6AiPUd6cKMZ2TNynRLnkmcKNWC5grj3FxX7/I04AHaAOnJf7chBQJ4XRKoapIRhBECtLLRIG1st9wrqp1lBSEPs+XDsp2X+H8TTkSvqzFqUZgZt1qK90B1fJezgjlNdXdZBUP/13j3zfuGb2Bjbbcj7wx8Zbkx7JsJSCrgDHROOHowocXmARZFwiEVPZ8XTxRosJyeTXxXHquVoINP/4A/DRtFL0x+7fA4tsyxX4ee4qj3ZlYxAgCRv9bSrc0dMiSG/ptCppXmOY87dmwt3FjiQrNkxQzSF1VvwOLApvuotITf+SF5SOWqkITMMQDc3B1YsoO+7RF4rTgNEe2Tba4LmEQpOqZYuxGnWQIyHQZ+5yzDQ9uTREMhS0bBwz3SEvYOsv44SF9F3ItmVAKwzcfKzg40IHX217eedD+yjykNai+SUsb1qGp9506Phjor5DTjPmP2/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(4326008)(69590400012)(8936002)(6512007)(54906003)(6916009)(26005)(956004)(6486002)(316002)(2616005)(52116002)(8676002)(6506007)(2906002)(86362001)(186003)(16526019)(36756003)(6666004)(478600001)(83380400001)(66946007)(66556008)(66476007)(1076003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mpTJewFOSR0xHgjOJsO+TgvkDnVXR3q1KTejSgZYhHG+s4AKQa9VrDWIT0JE?=
 =?us-ascii?Q?7xyxnPGjyH1NhhS/hvsHoqAjk/uRZVDcQwj7vwznX/LrZc7fZJ56KM7y3Brn?=
 =?us-ascii?Q?CYrA3ZZKwNhglLtGoQdYJVHUrRDurFNmjVaTcrvCFFMeS/RdpcHA5+gqxWTe?=
 =?us-ascii?Q?B+msGvVTyNdAB1NRjA987UXrO/UuacBH/1d7UvmY5JnsAnhc3pcIO+7hNnu/?=
 =?us-ascii?Q?txuCw6Q9DcIWwkE3W9ZZtIUtx3Exq9Rl9DWHqLbOolkKT9hjpUnr3c6mIn/l?=
 =?us-ascii?Q?+mayJWPHpJ65YRMjFhcjnfRPYIj2ML0KQ8c3Bs0cfcid4IYxJoV/cXcWBHl0?=
 =?us-ascii?Q?WDGxudUWrOJ4y+e6dPJvBC3EeY+R3hhVwkYvp+OpyEt/yRnb+8lCagAwLa+R?=
 =?us-ascii?Q?8BHjhZFZjmd8r/bmaiJlTgiqGNXUA+tFZfvfVzblUfaGS5kJFOKrbSZrVAmZ?=
 =?us-ascii?Q?ou68yDGq4TsmsCdQdbDyLe9xWiXKzDhP/PcjmjjVSlg9nCuOlB2zLwQsPE8E?=
 =?us-ascii?Q?/1JZq4carFpuUPeEU9/6HnVMrqCPhNLfKqZiCKsDD0B2dtekOUMx2gHnUdwH?=
 =?us-ascii?Q?Xt1YFnFR6wLds/Lpw57YeAAXnnrBMBzG2l5Gn1uf4Rty+xTBKxOUxXqPuArD?=
 =?us-ascii?Q?Jh5wbyilJVFE/CuBHy1rH7xwT5gEQh91lD/wUHayv85SAvKbyvdpXuh54r0U?=
 =?us-ascii?Q?O8EmHSV6A7V/ZUOGEdXmwwcJqydBAuUJ3IO7jRFqtNdab0IyQFXA+42Tl0fz?=
 =?us-ascii?Q?BUFrpaYpEIx1zir8RPpwbr6F5xVMN70m37ywNa3im4VxdFjnMxyM3fv93YWf?=
 =?us-ascii?Q?5ZQAnAgsROZe0hyoxBVTD7drVNO0Wz/oM07PDhFEx7Fp3oy4TyGSWizr55Pb?=
 =?us-ascii?Q?tIvsXuV7AiEnGfPmCx+5uYnM3GXfvgJaW72KlPkshDLNrafzuUYZ/wh87T6c?=
 =?us-ascii?Q?1GPOY50KsbCMOD9I41tKAZQCeZbdMdTmkpqOnRd3f43C53ZyugVcuxHArGVO?=
 =?us-ascii?Q?rrXnRf9qUyzxEbFXWBgQLzrOoTc/wjsXbWIvu4Q6E7Wj66h/X7ke66bNOhuC?=
 =?us-ascii?Q?cn1EYVIhooA7meBgNANJcd5IDcilt+yf9jbyRegJ0y9LkKI8qMf5OTj4Kw90?=
 =?us-ascii?Q?mhfnzbQ/oTJeXCiv5HyQhAe12+3JaxQTxM6TZBlIXZ9BUFNl7D6yS/KRIxHd?=
 =?us-ascii?Q?AlaAjaTgzGdAYb6EaXnjV3mYBlJZx8Js9gf3r/AY8z1aYIxRbGWS9WM7xbP0?=
 =?us-ascii?Q?Evey1pWtN6NiESietmQdPQiGtxKSQlvgs/uqqUPRbHtcQdIkJ3qNseVOFGDm?=
 =?us-ascii?Q?FZXirkKg/PcDj3aj88BaHT/0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 981622da-3053-4b58-9b42-08d8d9125c06
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:15.1860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsqfUiy6zODrdcPmCvK3lkzqrumEQrEn+cBx7VopVVVfypWYvYhYgOeQGMGLOnsCm1/k10DW3fEA1Mhpz+PEbQ==
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

The callback will be invoked to reset mmhub ras error
counters when needed.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Dennis Li<Dennis.Li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 340ba8b5b379..c94060ca4a10 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -1231,9 +1231,21 @@ static void mmhub_v1_7_query_ras_error_count(struct amdgpu_device *adev,
 	err_data->ue_count += ded_count;
 }
 
+static void mmhub_v1_7_reset_ras_error_count(struct amdgpu_device *adev)
+{
+	uint32_t i;
+
+	/* write 0 to reset the edc counters */
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB)) {
+		for (i = 0; i < ARRAY_SIZE(mmhub_v1_7_edc_cnt_regs); i++)
+			WREG32(SOC15_REG_ENTRY_OFFSET(mmhub_v1_7_edc_cnt_regs[i]), 0);
+	}
+}
+
 const struct amdgpu_mmhub_funcs mmhub_v1_7_funcs = {
 	.ras_late_init = amdgpu_mmhub_ras_late_init,
 	.query_ras_error_count = mmhub_v1_7_query_ras_error_count,
+	.reset_ras_error_count = mmhub_v1_7_reset_ras_error_count,
 	.get_fb_location = mmhub_v1_7_get_fb_location,
 	.init = mmhub_v1_7_init,
 	.gart_enable = mmhub_v1_7_gart_enable,
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
