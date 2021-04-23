Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EDFC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 14:16:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69109613E1
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 14:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69109613E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D27096EB91;
	Fri, 23 Apr 2021 14:16:50 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2082.outbound.protection.outlook.com [40.107.101.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 612DD6EB91
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 14:16:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkLX0WZXArA1sQulcidHx4V4RQ99r52dMos1CJUBLdMEz2Z7+EOLLHmwsSNn7GiOKCdWt+FweKkT+aQHdDGG53bK7M7KSoVQjiVgoqLasC7NzkN9BFXJuHLINRVwMcYcAkKnJfNkN7Y8RZxgtgHF4Z8VNeJ8NU58cmol0/OiItiE5EF2x26DZ/cqUwKmRepb6g/yyCQK+xufonMUvh/LoXavsWzJpRDkyBQvYNYtFkRAjX1KGtrQblS27TYa+y3opxeCHGVJtHkgeaVEGxzsvZVs0QU/gWDITRUNX+u3tRP+RXlF7mPXacdK9SEayIdbsBg7iV8aXNle3P7OBw8KUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyYoceDZZppCWfsYrWwZVE6SQzAn2aGvBFWOb1HtZuM=;
 b=dLM8TmNXKh7Ugxuruf6o61zbH6SzO+N8njUA3AL2+un8dnKtncKIic+CHe2DqaqB1scmgAxYk2S7Wig3IpWuducMc4ylbLcPE+ikobwkTXYS4czGFzRAwvEE6OPS9IzlQvJNLM+c1SqIeIxLtJlll+vumCJK4jg2gTZa94kFpIQ7gN5ibgyr8zgrPkKtkgInaDgiEZnv5V04Eyri44ct1AB7bC7xKMwT5rHECw5xFOGbsWSB2L9GrxnXZINa243E8wBwH+xRuoG9a4IMtQMV0VKdshGdpy8OB4d+tuVznFK4ML96Vq4yBzU2OD1+NMoics5wJmOghuDVucqW4pMU5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyYoceDZZppCWfsYrWwZVE6SQzAn2aGvBFWOb1HtZuM=;
 b=3p26JsGPvD409Grx6l7YUJDT4OgXykWwDec5LJwSxZsbdrezSccYMK/vGQLEOXBIygfzuMdEmnMl3HuU81oNu45/D6xDxrxDKz0yqiaZgCIfdou3VlorCRJv/yUoiX5hec/Ljm34NAzYzcMSY7lYxQSEUXXYH2ecvn39vbLSROg=
Received: from DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17)
 by DM6PR12MB3625.namprd12.prod.outlook.com (2603:10b6:5:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.24; Fri, 23 Apr
 2021 14:16:47 +0000
Received: from DM6PR12MB4156.namprd12.prod.outlook.com
 ([fe80::d54b:4bc3:9d54:fab3]) by DM6PR12MB4156.namprd12.prod.outlook.com
 ([fe80::d54b:4bc3:9d54:fab3%4]) with mapi id 15.20.4065.024; Fri, 23 Apr 2021
 14:16:46 +0000
From: "Wu, Hersen" <hersenxs.wu@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wu, Hersen"
 <hersenxs.wu@amd.com>
Subject: RE: [PATCH v3] drm/amd/display: Reject non-zero src_y and src_x for
 video planes
Thread-Topic: [PATCH v3] drm/amd/display: Reject non-zero src_y and src_x for
 video planes
Thread-Index: AQHXOEqrjg/t1Wz+3kC9XLCXqHUSJqrCJa3A
Date: Fri, 23 Apr 2021 14:16:46 +0000
Message-ID: <DM6PR12MB4156B2874DE2C8D7EA56512AFD459@DM6PR12MB4156.namprd12.prod.outlook.com>
References: <20210423141210.28814-1-harry.wentland@amd.com>
In-Reply-To: <20210423141210.28814-1-harry.wentland@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-23T14:16:42Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f8fb42f5-bc22-4b67-8268-697b19d71588;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3c60:9c20:2c72:5938:f43c:bc01]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48c2ab86-c0cd-4abb-49b7-08d906626dd5
x-ms-traffictypediagnostic: DM6PR12MB3625:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3625488FB4856B9673F47A96FD459@DM6PR12MB3625.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r3mor54HmcRRLzjis8K94i2VvD4Xt3tH9STZSJ/fTcNWo1NAlWzlMqoA7h0tPlQYy2yu23xAc0sWJN2wo9JoD1gGp2lw7jnF7tIj9ESFBerqBp0Ao4onVEEtY4Hc8f5m8Hz9t0judBbeXa2hJcYUN1szhuY9u7RPkCaTdaL/MDozKRnFKNqHehCY1aPMzWxRK9Ruq72wxwcTidEkG04u/Ugs4EmmoGJ4l6/bCTPxGADAV+8HuoAPprb0oAYUA5QeKaMpXPCWIL+s2nqTAfxDT3ZNzt3LL6s2EViRt5J7iSzBTnOhIh0Olf7KEYxnPEy97kCxrUXLCHUy+ZwbZvbv6dZi7yxk+n9or5FrFG+khpAe9nTRSdFroo1IfFxNHx+1Cxn6woiGY+OO/nhtu6zPXepuB7XjX22P3XoKPDKleOkLp+uR9XRZqPeGWmxL4qya67oFGbF20QDhpDNJnkAKYobHF1obtdh7tpmC0dPDBWeefPsBma0IQlzkP+bDV+vpQAEsThyjXuEES0fcL2u4w/VKu4iJ25eMMjdFhAS1vWKLo8yS/BzKdFYOzxao4hWL77GVXJVr3kgkjh0x194dDkb2fJ2aVgysjILQvLugsvY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(66946007)(64756008)(316002)(71200400001)(76116006)(52536014)(66556008)(66476007)(110136005)(8676002)(38100700002)(478600001)(122000001)(186003)(9686003)(5660300002)(54906003)(8936002)(7696005)(83380400001)(66446008)(2906002)(4326008)(86362001)(33656002)(6506007)(55016002)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?C1jl35DoWH5Pgix/GaXPC5QIef6SX9tcun0JQbf13DE57plkPi9tI8TnIo9j?=
 =?us-ascii?Q?lIOSDI2NPU9fodau+0g4zp4l4n9XjTKLQk9nU9DIb4IAxNZEtR4fSzr+h26p?=
 =?us-ascii?Q?YiICbL7kHkxfc1nkWwYkGnDHBO5fUAIV+hiSdvjq5a5SkV8wLpn9E/8CWkqL?=
 =?us-ascii?Q?ZHnFrgg/3hXeqOiCiXhCu3jMv/PSj+TBTi4cJUzhNakjhtqf2v+4Grr3lyq2?=
 =?us-ascii?Q?qXY55c1RtS1TEVEnK/U6v+gEvTjQyhHI3lz08uQ3fh/i169X+cVjkjM4ZWfJ?=
 =?us-ascii?Q?RFLokMJxLn0K7Cf5ZLz8aQur1QDzQRjZc1x7cvnSrCl5m9cAiVdKAhyJdBIf?=
 =?us-ascii?Q?w5URPuXcCc3/ygv4fc/Ewj+TN3QbRp0YJgsSIHud7gtnKNsJcu2n1PDDnFGx?=
 =?us-ascii?Q?LgZf2GVaJ3TZkTaAWbNdF+/biUQn8L2+et7Zetr0ewBZXq9FoQxVPiWKZIOb?=
 =?us-ascii?Q?ZDgvCFynFZQruLC0KMfQVt69DJkN3bZVgcXIDgsIsq91Ae3xTek3AWcy8cYe?=
 =?us-ascii?Q?BjserPI6q6yjqT9FSQAgNWODM+5js/v4CZFYCd2lR7t2GMnnjheJ5aNgeARO?=
 =?us-ascii?Q?I+QchF+Nj0vdVJzc1BEh0ybgCkn894geeFx0bsAOz/YNqC0B/AujFlCSYzXm?=
 =?us-ascii?Q?1Md5ufbA7QYhW1f9SzAQhrahjEzoL6ssNpTAWOm9jiXt8J5ktyOn7ktvboTD?=
 =?us-ascii?Q?s5vSfyMXw2uP3YxUJxU+I806XEPovMl8EPgkezDU5Mt3G3wddUi4sZ2C+In8?=
 =?us-ascii?Q?WhrMZM48muXgpfL3+JDQBWTSxwh/7sgszIbsucHFb8yCv/bI71eTO2mEsQfo?=
 =?us-ascii?Q?5jv5hB8faxaZxMCcUMBtGtcMbDqxpymqv+Hkskq1Ox6DKeoc/zdK+NLQB7kg?=
 =?us-ascii?Q?jjqE6KhyPxmGfA3hU8eduB07oNlH5YISKkosZwAAuM+VAjMlNT9h0WWP94OB?=
 =?us-ascii?Q?a9XAXIOOA6x3+SkuW36PuBNhrP+8UP0gOMoSC8ADkzFYD93iJyeXGyiOfV8h?=
 =?us-ascii?Q?6DFyi//lldPrtFms0EOZAQi/rmgg6l2vrOcH5P5QKl7nlTnb9YXBuQoQGCee?=
 =?us-ascii?Q?QDBaoDc6gwSLK3ejXd5OCt75F99Th02llE+o8BkKX+KRMfBcoPPlJSSx/olc?=
 =?us-ascii?Q?xG5lledXXQ2ui89BPmw96spyQrUOxMmSniMweh9x0IxTO10g6PGJzAcd1HXE?=
 =?us-ascii?Q?4s1AwtTLILaJ7MPEF52DmD51GHhYoWCaQSb3kZ6cPEYflhhco2mJJvsARRgc?=
 =?us-ascii?Q?gcaa8wgCchigswkzm/PQMjLlsokirIoCtBt6tQksN9R1rlQ59YUr9pH7ssri?=
 =?us-ascii?Q?Mn0Px8C4VlgtBfbwEjAuWx9odyx2ELkaC6keMcYmS7d5EwY/m+LgkrB0u6on?=
 =?us-ascii?Q?yj+EchTY/QkEEd5dJmfNiJuUN/nN?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c2ab86-c0cd-4abb-49b7-08d906626dd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 14:16:46.6343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 41qn01VHLlN/31ydlZ3cO65WlPehvOQTsyzVRioqwRwYwAsEJEObAfrdAm4eRei4FSMaYrssX7bIo01uAgEu6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3625
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Wang, Danny" <Danny.Wang@amd.com>,
 "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>

-----Original Message-----
From: Harry Wentland <harry.wentland@amd.com> 
Sent: Friday, April 23, 2021 10:12 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; stable@vger.kernel.org; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Li, Roman <Roman.Li@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Wang, Danny <Danny.Wang@amd.com>
Subject: [PATCH v3] drm/amd/display: Reject non-zero src_y and src_x for video planes

[Why]
This hasn't been well tested and leads to complete system hangs on DCN1 based systems, possibly others.

The system hang can be reproduced by gesturing the video on the YouTube Android app on ChromeOS into full screen.

[How]
Reject atomic commits with non-zero drm_plane_state.src_x or src_y values.

v2:
 - Add code comment describing the reason we're rejecting non-zero
   src_x and src_y
 - Drop gerrit Change-Id
 - Add stable CC
 - Based on amd-staging-drm-next

v3: removed trailing whitespace

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Cc: stable@vger.kernel.org
Cc: nicholas.kazlauskas@amd.com
Cc: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
Cc: Roman.Li@amd.com
Cc: hersenxs.wu@amd.com
Cc: danny.wang@amd.com
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index be1769d29742..aeedc5a3fb36 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4089,6 +4089,23 @@ static int fill_dc_scaling_info(const struct drm_plane_state *state,
 	scaling_info->src_rect.x = state->src_x >> 16;
 	scaling_info->src_rect.y = state->src_y >> 16;
 
+	/*
+	 * For reasons we don't (yet) fully understand a non-zero
+	 * src_y coordinate into an NV12 buffer can cause a
+	 * system hang. To avoid hangs (and maybe be overly cautious)
+	 * let's reject both non-zero src_x and src_y.
+	 *
+	 * We currently know of only one use-case to reproduce a
+	 * scenario with non-zero src_x and src_y for NV12, which
+	 * is to gesture the YouTube Android app into full screen
+	 * on ChromeOS.
+	 */
+	if (state->fb &&
+	    state->fb->format->format == DRM_FORMAT_NV12 &&
+	    (scaling_info->src_rect.x != 0 ||
+	     scaling_info->src_rect.y != 0))
+		return -EINVAL;
+
 	scaling_info->src_rect.width = state->src_w >> 16;
 	if (scaling_info->src_rect.width == 0)
 		return -EINVAL;
--
2.31.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
