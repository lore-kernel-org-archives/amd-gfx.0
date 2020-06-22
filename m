Return-Path: <SRS0=8rPh=AD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EA1C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 02:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EA6525358
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 02:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l/jdnrgw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA6525358
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E48EC6E0F0;
	Mon, 22 Jun 2020 02:04:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F90B6E0F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 02:04:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bX0mXOrCN529MGChRQ8ZYdCEf33aSNP0ACxNncUbjh5ptc5xuyQMfh6zzlyviy/Wp/Me+zDSJVUsBZl6WDMzqQmcAYdsdc724p9t0WidJ/GcN6T6wVubTCh3Y2kyexFxu00O4uYhgwlGjhbR6AvXKSRk0JBlBmnxgKPLULWTXoVJy5q4xTbX7h9haX58Wr7GFLBYlalp16FwTFak/mSs251ZzWm6n5is3hyiJ/pQEvUGTrBn3SecuZqPYYfUH3mbdFcV6MAaysW87xsra1F3Ja+jWX3xLQom8SJJv8ngc4USm4l1MDi6nTzueMISiEpY61IeyXnAPVF/fY6yuGLuVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmppnHFd/4XKdHkatIQua7wWwd3SNMF2zjgu/R73dQg=;
 b=mfDR3z/0Z2wlDSvpdngKpsNVSVv07NB7EMqN+ViQ2A0/FFczSiaAuTiwcY5IQ5c8V5rQ15J622taZd1bR59lGVRQEW4DXHoSoRZhEVln89FH6+coPleay8VJduaENkCazzyRY+CqlhXmZjisY5EFBhhN5KtqL1zyK77XrSh8oQBut6jkeiuuLFc/mb5Mb3ET5cENBu34+IL/xkg/OH3vcqbI/01KRqFO51/CVXuu3q7/IRt58WO4dsbReUADCCpmUNti8X+6MJ0u6sa+NzpXrsxrbRea98SGGrP6j2epQ7QdIxE/V10rQ2K7GW4g0A5GkQ5NidAuBtF+PWjU5iZPIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmppnHFd/4XKdHkatIQua7wWwd3SNMF2zjgu/R73dQg=;
 b=l/jdnrgwUvywnCLDKvgZIZA55C0zdlRW2oRpi/8Gl+REo6nLvHzdlnBWVWyXcmV6uLTLjtxSboN3PNSoKUatohN6l7MRUJqhBPMwNRHikEBZ4thizfKGa/FpdFhJj72O/8eRNqXqev7BQ/6X4Tz1NoXgy+w4X/PaihDcyT0dSuk=
Received: from MWHPR12MB1471.namprd12.prod.outlook.com (10.172.55.20) by
 MWHPR12MB1262.namprd12.prod.outlook.com (10.169.206.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22; Mon, 22 Jun 2020 02:04:13 +0000
Received: from MWHPR12MB1471.namprd12.prod.outlook.com
 ([fe80::b108:84a1:d4d4:7b4e]) by MWHPR12MB1471.namprd12.prod.outlook.com
 ([fe80::b108:84a1:d4d4:7b4e%5]) with mapi id 15.20.3109.024; Mon, 22 Jun 2020
 02:04:13 +0000
From: "Chauhan, Ikshwaku" <Ikshwaku.Chauhan@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: backlight rescaling to original range
Thread-Topic: [PATCH] drm/amdgpu: backlight rescaling to original range
Thread-Index: AQHWRCgpnyiJkjif1EK9ueCkKmLbi6jj5/1A
Date: Mon, 22 Jun 2020 02:04:13 +0000
Message-ID: <MWHPR12MB1471F9307450227A9068B0049A970@MWHPR12MB1471.namprd12.prod.outlook.com>
References: <20200616214958.120051-1-ikshwaku.chauhan@amd.com>
In-Reply-To: <20200616214958.120051-1-ikshwaku.chauhan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-22T01:59:16Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c45d6afc-d398-4723-a1c7-70575d76f5d4;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [20.184.57.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2a143b68-350c-4a77-8244-08d816508fd4
x-ms-traffictypediagnostic: MWHPR12MB1262:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1262F6C9DCA051D35F3918489A970@MWHPR12MB1262.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kNFAf6CgHTWCsBRNnv8ZA61307iKTsFbHoJ7r9s/2CKYJb1QSex/bmFTkpVmfhzBzYw3k9TzRsYKoiByYqePMCGWMyydGfx5Dymn6KojfHYpqRfPfjy95223YzYyqFvU4VWE7k3GKUAqgSM7NRoX3WCZk8XlTNHCrnMNgJSR82FqLENVLSwVNb2aSyZuXtzYC4AQNWVvx6DuGJ+mOL4n8/f7gz37p8NTnMIpzYDpdEcWCIYWpYnzCEJO8aLhAc1gjuzSYEM/saWYlyWzKUktKaTqFOJKvOW4lwilukZlY6pgw5+wyRBuEmB9QK6FdpQy0iVedBh2oJ9Gmt9pontRnA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1471.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66476007)(66446008)(64756008)(66556008)(76116006)(66946007)(6636002)(26005)(52536014)(33656002)(8936002)(6506007)(53546011)(83380400001)(7696005)(5660300002)(71200400001)(478600001)(2906002)(86362001)(186003)(110136005)(9686003)(316002)(55016002)(4326008)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: qXTAZ7shEK793mnTZtY5GKnbIVS7YjA6nrqHuE8+UZ3hxZJ8O6LNewVheilFutcZQN6BpqY8SIAuU9YVj5DbVjqgEiymUDts6k5okHbxAJ3iFnLfFvUtCoUcTTZGzdSyJ6o9+9grZSdVlgMxn2ebzlN9xWFfakwrXJaDtO1iwEwLA/IpMIY70wxU47Q3USwWDxU18bg+TSK2jD5AJ3CMC8+mMms26VnPZTnfD3RumIkxS/r4EUds1vIBoU0aiSHUeAAlBhX2PMhMxsNKJQFTJIRLWPqKG7y1JPVX7+DNS6O11cE34EAhbQfXDWBhImuukNgngiSd0HfgEy7xYCZYIDfZ5Dy2jYBEWid5wB77MqGB29dM6B5IRZ6gjI545DEG45GmG2jzIj4Wkmbdf3noa12MVisyjykQN8purdBXTibfP1jVLc3y/95jcEHpJVHGuw9Er9tPt2g4GAjtKXl06L6izPejVDmKF4iij8ZWoCQ=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a143b68-350c-4a77-8244-08d816508fd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 02:04:13.6709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K3/X/5zyR5pg+8LLmpLvonYgMcn18ecvj85mVkmC1yWIpx9psBkx+AhbMMT/4yeNM83DTSKQDxQL31leK9A5Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1262
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hello All, 

Could you please provide your feedback for this patch?

Regards,
Ikshwaku

-----Original Message-----
From: Chauhan, Ikshwaku <Ikshwaku.Chauhan@amd.com> 
Sent: Wednesday, June 17, 2020 3:20 AM
To: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Chauhan, Ikshwaku <Ikshwaku.Chauhan@amd.com>
Subject: [PATCH] drm/amdgpu: backlight rescaling to original range

[why]
The brightness input is in the range 0-255.It is getting scaled between the requested min and max input signal and also scaled up by 0x101 to match the DC interface which has a range of 0 to 0xffff. This scaled brightness value is not rescaled back to original range(0-255) when we reads it back.It returns the brightness value in the range of 0-65535 instead of 0-255.

[how]
Rescaled the brightness value form the scaled brightness range 0-65535 to input brightness range 0-255.

Signed-off-by: Ikshwaku Chauhan <ikshwaku.chauhan@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 40 ++++++++++++++-----  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  5 +++
 2 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9ab0d8521576..73b0a084e893 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2881,7 +2881,8 @@ static int set_backlight_via_aux(struct dc_link *link, uint32_t brightness)  }
 
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
 		 * We are doing a linear interpolation here, which is OK but @@ -2940,24 +2947,35 @@ static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 
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
 
 static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)  {
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
 
 static const struct backlight_ops amdgpu_dm_backlight_ops = { diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
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
