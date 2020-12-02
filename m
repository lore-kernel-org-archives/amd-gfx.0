Return-Path: <SRS0=1d7w=FG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCA7C64E8A
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 01:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A18A220709
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 01:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18A220709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E13F76E9D7;
	Wed,  2 Dec 2020 01:46:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63E116E9D7
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Dec 2020 01:46:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEW5OKxXCwqy6hJLRFMUnK6ZYGnzYpLa1BmDV0CdOHnLp/SbM7XRb7URIfkmWzJrrpZ/RHlxnDkB2nBmtcZUIbI/rohVBmSnqFPgSUwHyM/GAuqMV9g8BXw2GPKrm6k0AT3dbhmPRJlHh9piC8BsHijCgWdGvkZ1bmoz3dUF+jCrw4ViUyE635FLVZEfV5Gqh3Dkc1/tltT4s4Iy7Xqt++CUNlqSNvAfH8QZIsi5SSYMdBS1YoR8iNtj8YkXDfmYSkbFQ1HCAlPG+dwB6JW74f5wAhW9t9A/WezGSBGIjRE1hE9LtRPkGfUG9oijAGbGQlvdIFtnkkPWxhcHW8I8rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/yW+HM+I7o9GJOWv/tJFYqq5303aN1+O0HMX1Z91T0=;
 b=BwNUvynBkPRGiFWaB/XTyan97vO5UyFfnRPj7F1s1zdWOMKDVv+NQBLB/tg+tdICbsx1/kDyEzi1g4cLqgnbZA3IadNpy3yUFUzBjYbT/Ut+eBcvBua7Q8sMO+FQPlqKP/1Vr+2LJC2Y0NvJZP5gxUQC4uLsj9s0uPXty7U61U+hxwCOxtA9wuCtlprkNwgwzjOaOJpSvBGuTY0GFHEDymjgwCOXWoU2yKitYS051NWD8kvaLyggOMF0JS3KrFIL6oM6sUcwmDoZi5UgeAONU4Xo1vEnVoLHzkA/WeX3ufITeMD9Vdt6FD4zwRBOCbnCTctQNHrH6MSQ2APQy9wpNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/yW+HM+I7o9GJOWv/tJFYqq5303aN1+O0HMX1Z91T0=;
 b=XIKRoEwKDKRIUZmoW0KZbnwy+TcN1zxXeJZ/nw3ZsICG/pDUpcpODmWxu+VzvpEU7Wb+OjMKP1xautImDIt/QL8nwSvPw5vBD5lbdeEAzmRqIUSIH8brnF4SfVOTj6sYv6ht3sS4eSFPguh/I/usKdafMl/3djL4Ykl5bP4GcIE=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3177.namprd12.prod.outlook.com (2603:10b6:5:187::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.22; Wed, 2 Dec 2020 01:46:11 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3589.030; Wed, 2 Dec 2020
 01:46:11 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/powerplay: set the smu fan control cap for CI
 asics
Thread-Topic: [PATCH] drm/amdgpu/powerplay: set the smu fan control cap for CI
 asics
Thread-Index: AQHWyDRP1H8BL53Cwku9vEMTZMGsRKnjCUag
Date: Wed, 2 Dec 2020 01:46:11 +0000
Message-ID: <DM6PR12MB261927E05D3010772983A0E5E4F30@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201201224943.1200069-1-alexander.deucher@amd.com>
In-Reply-To: <20201201224943.1200069-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=14098d30-50f5-40bc-8767-06e038050389;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-02T01:45:42Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8fc7b9e-2def-4d73-401f-08d896640bc7
x-ms-traffictypediagnostic: DM6PR12MB3177:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB31778DFEE38416FACA70781DE4F30@DM6PR12MB3177.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fn7ysrq9bOMlrJj1e38W6CwCCEzqZ3wRMs2Dy+Dkp6/nw8pocU9lU/8AFycdNPRqhMlW13O/jCCFuJhrImw/4JMG4RZYjxctjLBF496m2Jq4Apebjc0E1X+TuI6ZOVhz0qV6wCE4xS5DVfSW5wNr5/ED2lP9TvtyMjM3Yloohqoq5Dz/iNssnl9A32Bq1QjeQCQIHdqU1FBnxoORZupgANY4BBUxa8IjpZSvzhv2lCe0TkavGyZXKeRsbysDsx8NT/YeT5qKOtR9JpIl0tbeJJDXks3yIWi1m+t0VjQ10nIjLlpWVVd2o9DBYIYh75qa9GpRdLu5X7i9UMfY29QDzvWnAOdIOEvtdmBvlIoMpD6SxUC7xeFqAl1K749Rqd8z7oGrQ/mhWVWQAtKEQsn/QQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(66946007)(4326008)(66446008)(45080400002)(53546011)(64756008)(76116006)(110136005)(966005)(26005)(6506007)(7696005)(2906002)(9686003)(316002)(478600001)(55016002)(71200400001)(33656002)(186003)(66556008)(66476007)(86362001)(8676002)(5660300002)(8936002)(83380400001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?F/PbVfEjZ31cKhj2YZFovyV5cVcjmENd05ag8UdQ61wXbJwQHScr4HtHsSMn?=
 =?us-ascii?Q?iupBBAXKnwe7Y+dxEt9NrYnDHY18h7NCmW4Hz3UyfBPixvufkaYR2FrFGT65?=
 =?us-ascii?Q?CnRJrNwQn2GXQ2vUD5Q+s/QApIb3bVcrMW3RkN0x/M1tfXOQdvDEkeMvcGCK?=
 =?us-ascii?Q?qg/WNBc1sU8UIbiFdoGc4oWyJfGmXumCibxkNLhOsF7kjFZ19gw2/VZabsvT?=
 =?us-ascii?Q?BsFkHreGJhJJOqdFyKJ0Ekp1MDCeq8WHBSDAdbkem5cKdoy5IREdz4OVZNIr?=
 =?us-ascii?Q?fplUz1a2KCTqSm2nW8Gf3NMiM8RkavDl4d4Mi98pqvgzDxjPDsXed6ixc3Gd?=
 =?us-ascii?Q?C4rAtb8tLzJQR9pl+nM+ou0DA38XrUOcIiul0dqm3HE3uSyr1LMsJnvMsVc9?=
 =?us-ascii?Q?ejN7mMNvSA/zg4M7TS7LWuJDnO7fmX2FMdeQYe50qD2shkNI8NXsnKCyxVn/?=
 =?us-ascii?Q?EtFD/LBidMOVc7hEkLmdFvsN4N6zvwFjUMrJDl1a++3O0OWPTJFuPzBSz+V7?=
 =?us-ascii?Q?YoPTCBBQyikTStcoOwFHecVjyVOpLYWbmNYw8by0/aejebGc8fvLcikUwZ+8?=
 =?us-ascii?Q?MF/R1k0IMffCDOH6rlPDpbXvEpX1LRpat+OsDl0c29AMHysNnAuSSh6p5do7?=
 =?us-ascii?Q?Dur70CYcEW3rue2stXfahqh+jQ3yPm5U4a77Badp6XKaF97UObcE+gtbiM/r?=
 =?us-ascii?Q?Y3ocTS+4HopuJ53xu3+nBK2mEA40F6J5f74rCwWCnA5imVO5deQpNenSS7Ja?=
 =?us-ascii?Q?gOALucufJnMxpQd8BonZ1q+V9g2VD09b51JAdwZNsUOWSwfv+NDU0NarDXPy?=
 =?us-ascii?Q?G50AczSWfdiOl4ugZJslZscAklLxM0hsebMcBGkLQ8yp0Rdht0W7X0i+dnAc?=
 =?us-ascii?Q?PxStPp8QE9l+/9ih0W3iNF98H4nhv8M9hWs/fOp+fKL/72CKAk/s0S92fEpT?=
 =?us-ascii?Q?7fCb3kTUBD58UO0V+gboAuYWBt13dZ46GpD9Yupl0vI=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8fc7b9e-2def-4d73-401f-08d896640bc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 01:46:11.0580 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NBLAENLd0kNXWdg20l13jEYpHjWnzT+7LCO8UNO9wAjW15ai5iw3WXavjatYQEJp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3177
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, December 2, 2020 6:50 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/powerplay: set the smu fan control cap for CI asics

The default should be to enable it, and then it could be cleared depending on the board design.

Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D201539&amp;data=04%7C01%7Cevan.quan%40amd.com%7C71ab1a16a6634983bb0d08d8964b7054%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637424598051737572%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Y1AEo%2FVAOh%2BwgPMb88YiEBCRr4Q5BWk7ak1Tsp6ZHV0%3D&amp;reserved=0
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index 48d550d26c6a..f116346525df 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
@@ -1006,6 +1006,9 @@ static int init_thermal_controller(

 hwmgr->thermal_controller.use_hw_fan_control = 1;

+phm_cap_set(hwmgr->platform_descriptor.platformCaps,
+    PHM_PlatformCaps_MicrocodeFanControl);
+
 return 0;
 }

--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C71ab1a16a6634983bb0d08d8964b7054%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637424598051737572%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=0dIjgTK11GB%2FHyVt66O3MprB7WB8KdT6%2BWfxN1jXuzQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
