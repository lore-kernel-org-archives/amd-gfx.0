Return-Path: <SRS0=tiv0=75=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05F2C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 21:50:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6029520776
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 21:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pook7UXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6029520776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B4466E0B9;
	Tue, 16 Jun 2020 21:50:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5B8B6E0B9
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2020 21:50:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLI+xtxypD9Vdps2QjBpp3WyItaxPn6bCRkElJ6q9qo9xr+ZBaBdLqYrOeGcvFn6g5wSC+qM4pS6/ka1NI3Rm8Y00nf6TFhap/dTHJMq2PNxt/LcBHB5lzUy2JDDQs9AYYXjM9QS+JRf2U00cumO7/LV3kJOkmvzuR8EQCpwAgsoMk4MAYgUKxz9h08Hq2U26nVjqefzyTXGZalJxPi+06mIxnkjTuxXIOPaPIC17+wMzpqlk0TwlRj1QkG5zwX7cxAv0/CS1tp03gDSMBqVB+X+Pm7LcFpAVfO5Mfwi2YBCvDMXaWj7jBbS1Ienvr83+rsHFoFzuFCzjcWgbacGPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evA9fiqGxe6z2pw9/An2YJ8NgHf1y6lsnKut1IvtdV0=;
 b=T5yjH2V+VGITJhx1rB31IZRcRhRmPtJauYFS2jVk0PSlnvShlbQQe7ROAhHYeU+vLqm4Ss1WfZ+4baRRcgm0khx1Wq4HR87rN24GVALlGqLb8L9yvwb5zcG7wH/FhTJSEW76iOZqDbCICOz0LlfiR4toBx6PZIfpFSOUT7MF93xgoSXIIbMyqLlydW+N17hs1JVvcXVfcwdrKxh+syv3PeHoO5TJuFNsafhK5nMTzq0wBMnP7WYC4jVBFaaNXe8SbdV40uPSWycOebYudiD4jpQqEI90RDDwzsXyopSbZ/IplE0WLQWekmr1JTXaDKsDtvOR2nvDt5RUX7t+9SoUNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evA9fiqGxe6z2pw9/An2YJ8NgHf1y6lsnKut1IvtdV0=;
 b=pook7UXMUupUpV+IoXUXSt2Ya+fuGa+F6SlfujMM++n7lCR9y7PTQ19KdI9z4lRfXMHZa4hfN3zv8WiZt+FOZO4ALuqma8zTm6RXF4NpNkj48efRedtDISkRZj597RtWOnyDvZWUsWRnPdlbm5nKUQ1YSRf0qsWDHfVkKAFd08U=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1471.namprd12.prod.outlook.com (2603:10b6:301:e::20)
 by MWHPR12MB1328.namprd12.prod.outlook.com (2603:10b6:300:c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Tue, 16 Jun
 2020 21:50:34 +0000
Received: from MWHPR12MB1471.namprd12.prod.outlook.com
 ([fe80::b108:84a1:d4d4:7b4e]) by MWHPR12MB1471.namprd12.prod.outlook.com
 ([fe80::b108:84a1:d4d4:7b4e%5]) with mapi id 15.20.3088.028; Tue, 16 Jun 2020
 21:50:34 +0000
From: Ikshwaku Chauhan <ikshwaku.chauhan@amd.com>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	alexander.deucher@amd.com
Subject: [PATCH] drm/amdgpu: backlight rescaling to original range
Date: Wed, 17 Jun 2020 03:19:58 +0530
Message-Id: <20200616214958.120051-1-ikshwaku.chauhan@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: MAXPR0101CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::27) To MWHPR12MB1471.namprd12.prod.outlook.com
 (2603:10b6:301:e::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ETHANOL2.amd.com (165.204.156.251) by
 MAXPR0101CA0017.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend
 Transport; Tue, 16 Jun 2020 21:50:32 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 674043d2-5685-4b8c-5f9a-08d8123f4bce
X-MS-TrafficTypeDiagnostic: MWHPR12MB1328:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB13280E134A0D59418273E1FB9A9D0@MWHPR12MB1328.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wBOsZt5dM/5je9lViQcPd8hTFCGjG9IlSbbFCLsxEI7PZnnNGDHIOWv8u44xKsskDCgHxu2NLPO8qbsUuq67ItBSqtWVEjP6rBqpV7cuaJ8CBIPIBLDeUFt2Wf69b94q8v9mrzX5RxHBXgxbHeDuO5DoLCH65Pln0fVdcJvEybWVIpx/m3zbOzZZ5mlCuhHXv7fY8HB2y0xyXq4+OnqIGDgA1P7O6JAUZCWwSaJ38UKvuZjbTuz9izJ2EK6Ws1RXnwwMZkHhTlzdL/r7YUTE9ebVuA4WNixq3N7L4W2jtPKx/Wv63SZB2GO1iwUbAs6wJCwKZUUmPEvZmUbrXQMhKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1471.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(1076003)(6486002)(66476007)(66556008)(66946007)(44832011)(956004)(186003)(2616005)(86362001)(26005)(5660300002)(2906002)(16526019)(7696005)(52116002)(478600001)(36756003)(6636002)(4326008)(83380400001)(6666004)(8676002)(8936002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: BqXJy9KeJqkld/qIu/1p4mWKQbOV2k3CZxRlgmy8NcW0q5pVMnGi6kxq10K46uQyXNR6E+mvw2UdlQ1vS+ZCkCZH0UA9dnPCLryCXBj/9TLJeGAVJt02WihzCgBNSOZf5fVgZxoW039vYNu7OBMbF4vhikfnUb1S37ihvNpdwHyq4Lgz6Qb79PKvyAfF+jiXBVXRDUQF9AIY6QzyZzWuxetKw40CrNqKBcaMXbxWkCrAfWWExoG5kvwsTAVFU3DlLO6gHJWW3rnvdu44+mnhBtcp6Iqgj0Urq+FI8VkhCJ8DWPwvJbHMCwPgAg1O7eGpMsueqzR2mhKDfFlx+75ZJf9BXxc00Pxm/DK0V+wzU9h9eLXBVe9KWPx5dzvOMR1V4hTLbHjLg2vlGAhaoAiZs/yANCXF7re3p3+4I3VLeKxJpLOm6PGmfsFPjluKum6yFAiGwYxzdPLMbjhiasyI2OHmj0myv2989M+uee9Np0E=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 674043d2-5685-4b8c-5f9a-08d8123f4bce
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 21:50:33.9179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JfaVosQ2mt33+7ARGIF8btcnCLMRKbkRVbLLA7oPsp62HNsCxZ2MzQQ38M9DjvolnsNcQ1FJQnyFD85Vt+357A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1328
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
Cc: Ikshwaku Chauhan <ikshwaku.chauhan@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
The brightness input is in the range 0-255.It is getting scaled between
the requested min and max input signal and also scaled up by 0x101 to
match the DC interface which has a range of 0 to 0xffff. This scaled
brightness value is not rescaled back to original range(0-255) when
we reads it back.It returns the brightness value in the range of 0-65535
instead of 0-255.

[how]
Rescaled the brightness value form the scaled brightness range 0-65535 to
input brightness range 0-255.

Signed-off-by: Ikshwaku Chauhan <ikshwaku.chauhan@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 40 ++++++++++++++-----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  5 +++
 2 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9ab0d8521576..73b0a084e893 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2881,7 +2881,8 @@ static int set_backlight_via_aux(struct dc_link *link, uint32_t brightness)
 }
 
 static u32 convert_brightness(const struct amdgpu_dm_backlight_caps *caps,
-			      const uint32_t user_brightness)
+			      const uint32_t user_brightness,
+			      enum convert_backlight flag)
 {
 	u32 min, max, conversion_pace;
 	u32 brightness = user_brightness;
@@ -2901,12 +2902,18 @@ static u32 convert_brightness(const struct amdgpu_dm_backlight_caps *caps,
 		 * 0 to 0xffff
 		 */
 		conversion_pace = 0x101;
-		brightness =
-			user_brightness
-			* conversion_pace
-			* (max - min)
-			/ AMDGPU_MAX_BL_LEVEL
-			+ min * conversion_pace;
+		if (flag == set_backlight)
+			brightness =
+				user_brightness
+				* conversion_pace
+				* (max - min)
+				/ AMDGPU_MAX_BL_LEVEL
+				+ min * conversion_pace;
+		else
+			brightness =
+				((user_brightness - min * conversion_pace)
+				 * AMDGPU_MAX_BL_LEVEL)
+				 / (conversion_pace * (max - min));
 	} else {
 		/* TODO
 		 * We are doing a linear interpolation here, which is OK but
@@ -2940,24 +2947,35 @@ static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 
 	link = (struct dc_link *)dm->backlight_link;
 
-	brightness = convert_brightness(&caps, bd->props.brightness);
+	brightness = convert_brightness(&caps, bd->props.brightness,
+				set_backlight);
 	// Change brightness based on AUX property
 	if (caps.aux_support)
 		return set_backlight_via_aux(link, brightness);
 
 	rc = dc_link_set_backlight_level(dm->backlight_link, brightness, 0);
-
 	return rc ? 0 : 1;
 }
 
 static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
 {
 	struct amdgpu_display_manager *dm = bl_get_data(bd);
-	int ret = dc_link_get_backlight_level(dm->backlight_link);
+	struct amdgpu_dm_backlight_caps caps;
+	int ret;
+
+	amdgpu_dm_update_backlight_caps(dm);
+	caps = dm->backlight_caps;
+
+	ret = dc_link_get_backlight_level(dm->backlight_link);
+	ret = (int)convert_brightness(&caps, (uint32_t)ret, get_backlight);
 
 	if (ret == DC_ERROR_UNEXPECTED)
 		return bd->props.brightness;
-	return ret;
+
+	if (ret == AMDGPU_MAX_BL_LEVEL || ret == 0)
+		return ret;
+	else
+		return ret+1;
 }
 
 static const struct backlight_ops amdgpu_dm_backlight_ops = {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 1df0ce047e1c..d54fc00148f9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -60,6 +60,11 @@ struct dc;
 struct amdgpu_bo;
 struct dmub_srv;
 
+enum convert_backlight {
+	get_backlight,
+	set_backlight
+};
+
 struct common_irq_params {
 	struct amdgpu_device *adev;
 	enum dc_irq_source irq_src;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
