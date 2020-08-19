Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7F9C433E3
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 18:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30F6F20658
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 18:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F6F20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA0E689BEC;
	Wed, 19 Aug 2020 18:06:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 943A689BEC
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 18:06:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JA2iDM72LRp5iSqJSZaL2525mok20GfcnhXqmm4AT/lNOqN1d1+8A4QGx4OBgA3lWb5JZONh/aSKVa82QvZiUQZ8mL745RXXGf6hP6dyYW+Sjir7Sl3vffs6aYz+oSisJQrWAOctgmgx7ihyrpvkkjCXPOyFZVTxabJ4EWjc1v5eGKilgCKfWPfVCoVUNnwu3oPkZ+itjK8Sl45MaCMBqVEqdnLbX86gA6x3bY6bBaQZP0LcCOiVbP7+63UwTJ7eldK2uPEpHtYOjBKtLgxfwfvwSdOHIFggMoGeKIN3JNDyLxqKG5CnN7drTBKeF0WKdekfbU9YTh6JSKxKwZdjVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IBnlktKSztYsjzd91BTH2KQQQCShCO0Hp4133ReWKg=;
 b=TYZiE6N9cseu0aJPS3xLoQxyuFdtb1PSlu7+Eq55SDOPBgloWP5GdrsGNTkSdMR2pL2AkNFYD5qXfEyb0O0LW2W0Bw/12A1Ore9o3RK0HJ0Lb2PRnsAovAUgedxsXMFrOfg0O0p6gvbLtlTk/f3uq+1MtZNrfMVImxqoro/5tvgDlgCPpUfKyO+c/S6Ga15x5swf5HCGelNu1ZBIZaUzwLV0eR2VhCD57Aitof6YlYgC4GlFSATeInsl7ZPVB6RMhg9LVEvPQu9XCec5MynQUaHBj8InUzhQJGMAllBw9wKyudgeCc4zs/bYqZ5txz2L9OR3V9pBWR0rda4wT8/SYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IBnlktKSztYsjzd91BTH2KQQQCShCO0Hp4133ReWKg=;
 b=3Eyf5nNnzHDDoOa/r/EIWyx0+NHT687twWhlrN39oJyeYh4iBunGfH/Sibs8kBHzbmmGA2xZEek+G8KBUKvfDjYDHZMRpX4e4NZlJ1HNlix6uyKYSLDNGVdagd68iWKfNpcIGK6wIjanr/AFOsOdZ2CO/bmmWP84bSBQn+mFSyo=
Received: from DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17)
 by DM5PR1201MB0057.namprd12.prod.outlook.com (2603:10b6:4:5b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Wed, 19 Aug
 2020 18:06:07 +0000
Received: from DM6PR12MB4156.namprd12.prod.outlook.com
 ([fe80::60f7:248:5585:a18c]) by DM6PR12MB4156.namprd12.prod.outlook.com
 ([fe80::60f7:248:5585:a18c%3]) with mapi id 15.20.3283.027; Wed, 19 Aug 2020
 18:06:07 +0000
From: "Wu, Hersen" <hersenxs.wu@amd.com>
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Reject overlay plane configurations in
 multi-display scenarios
Thread-Topic: [PATCH] drm/amd/display: Reject overlay plane configurations in
 multi-display scenarios
Thread-Index: AQHWdlH/BsbrjyKoY0eUyHlOu/ScQ6k/ufNQ
Date: Wed, 19 Aug 2020 18:06:06 +0000
Message-ID: <DM6PR12MB41561D75630EB0A7E19BEFD9FD5D0@DM6PR12MB4156.namprd12.prod.outlook.com>
References: <20200819175556.285629-1-nicholas.kazlauskas@amd.com>
In-Reply-To: <20200819175556.285629-1-nicholas.kazlauskas@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-19T18:05:51Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c3e94d04-15a4-40fe-bcc2-0000b6d287df;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-19T18:06:03Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 0c336a47-3df8-4516-aa1c-000096a11d88
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3c60:9c20:c48:d72:a858:783a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1de2fd39-62d7-4351-8c40-08d8446a8b92
x-ms-traffictypediagnostic: DM5PR1201MB0057:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0057FB050106D57556475D62FD5D0@DM5PR1201MB0057.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nocXtrRbCg6p+7XV/uVvz8bMCVvZp+Vgj2Reoj54Tm2VLxzUbnhokEZLQzOnT8pa1EYy4a5STK6QXB5fgyDrKK308x8hxArRm6Ifc2bLzqFImZbQuQU8E1q8qvKA+gvWohZ/gQoEIRC8EGYj29Iqa96R2LvErIGLN/RtY+2cnyOuXJjaDGEhYZ2BmiVXVM0h1O32Z64g+kDLQpecT4n6HL1Yj2M0BK6Dft6y1jc1FBvZgankuQJraRVGzSr9KNtYiixk7DkyIJEcOLpy9bLFF0T+RNLw3F2viCLJAKZpVaYpvq4bSoq+l9XmEUS0ldRrUYIf+KgrY2oIAnc5WlDQkg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(66446008)(66556008)(64756008)(9686003)(52536014)(33656002)(71200400001)(66476007)(66946007)(76116006)(5660300002)(86362001)(7696005)(478600001)(110136005)(316002)(53546011)(8936002)(55016002)(8676002)(2906002)(83380400001)(6506007)(186003)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: eSBJmGCCDROKapy1H+8fRdiPP//g3KFPDqOYWot1b+uCZwCUgFIyzBdHcK5Omromq3SAVmS/jlLtxFs+ZM9I0shRPFxexXmJV+LWR7ISkManiyKdN06UN7xwbXlO7bnllqYnE6qiQszcbiMcFamBmosV5cztM5wIskr6o6NMk78TRK61sZmdwWwDuKcvYZfGt9cA9+eF/Kbi1cspTpxq5hoEUKY0TzWwmNgdVDXd9eHVYxdhBprXbVvYwcQXSVmmWcSxT1HSnX6+Mi8fPnRXFkT/Gcof3Xyek80UEHU/ZbQGsHwINy7wXYmKUtSLXxa0R+YQpB4Fg8KiZ8z6b3RA7LWAfrF7juKGtan0AscnDvkVAzv2gr7dbEWBaPEdfjr/O+sgdfZPFZn/5GUXtOyiakrrWRIhUas7UIxNt0qeic2TDP57jvmVjNPbAJk6/SfnXbjnAqcgYOKacld/caUAnm8er2obMIf47+C0fI4Ck9miCVdA2xHVrhnO7WwhsAX/i/psaEGLoJFeyOI6vjAVytRefKaHkrrk7Ew/JAi6/wO4wlJF9g00A+VC7pHp1KXugIsE+dK1ZTSPXjHo0b+F6zZzTsOHL5+7ZbWIhq8tnF+2a23vI3/tNsqhsvQ5sZC3c3JIxVDtd+Yw8diYQGg/F1IXGtyALIybdYGvivzX24nl7WzKbaG1RqsrekG+DE27ysjQXm/vDTd/6fWfHV6COA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de2fd39-62d7-4351-8c40-08d8446a8b92
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 18:06:06.9385 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K6pISPgDzC5Fcjayu2vA/bW6wPltWlKw00jiORmdeRCYzNEh5mM76ZH/GqW2PkckIDbvltBlgtA0xJRBnzbSHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0057
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
Cc: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]


Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>



-----Original Message-----
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com> 
Sent: Wednesday, August 19, 2020 1:56 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>
Subject: [PATCH] drm/amd/display: Reject overlay plane configurations in multi-display scenarios

[Why]
These aren't stable on some platform configurations when driving multiple displays, especially on higher resolution.

In particular the delay in asserting p-state and validating from
x86 outweights any power or performance benefit from the hardware composition.

Under some configurations this will manifest itself as extreme stutter or unresponsiveness especially when combined with cursor movement.

[How]
Disable these for now. Exposing overlays to userspace doesn't guarantee that they'll be able to use them in any and all configurations and it's part of the DRM contract to have userspace gracefully handle validation failures when they occur.

Valdiation occurs as part of DC and this in particular affects RV, so disable this in dcn10_global_validation.

Cc: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 07571f84e0f8..1abd81e17f09 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -1213,6 +1213,7 @@ static enum dc_status dcn10_validate_global(struct dc *dc, struct dc_state *cont
 	bool video_large = false;
 	bool desktop_large = false;
 	bool dcc_disabled = false;
+	bool mpo_enabled = false;
 
 	for (i = 0; i < context->stream_count; i++) {
 		if (context->stream_status[i].plane_count == 0) @@ -1221,6 +1222,9 @@ static enum dc_status dcn10_validate_global(struct dc *dc, struct dc_state *cont
 		if (context->stream_status[i].plane_count > 2)
 			return DC_FAIL_UNSUPPORTED_1;
 
+		if (context->stream_status[i].plane_count > 1)
+			mpo_enabled = true;
+
 		for (j = 0; j < context->stream_status[i].plane_count; j++) {
 			struct dc_plane_state *plane =
 				context->stream_status[i].plane_states[j];
@@ -1244,6 +1248,10 @@ static enum dc_status dcn10_validate_global(struct dc *dc, struct dc_state *cont
 		}
 	}
 
+	/* Disable MPO in multi-display configurations. */
+	if (context->stream_count > 1 && mpo_enabled)
+		return DC_FAIL_UNSUPPORTED_1;
+
 	/*
 	 * Workaround: On DCN10 there is UMC issue that causes underflow when
 	 * playing 4k video on 4k desktop with video downscaled and single channel
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
