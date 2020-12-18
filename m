Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BADC4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 16:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4443E2395C
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 16:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4443E2395C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AAD5893A7;
	Fri, 18 Dec 2020 16:40:25 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2046.outbound.protection.outlook.com [40.107.102.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A8B5893A7
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 16:40:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgULrrQJ0/LH4m0lJYmWNJotXQoXTC2FnUK5DCVHr6CwJq8MO4QYTDnYi6HkOZZYtYL4pci6USd8n2tTVeHApPOseX44HfGxpBQ3+PBXvglryYmjHoF5X1kxhwhZrAuM7k18L66kfinTEHMj/a2/WC2E9zuNr5OWISxvzxXzG2xwBC0WnPa5SG0JVME2g/uxVMm8DissNqiXyo8bhnEtvfhE/Ury8k9jeQyaVIFRIyAuR0uDUUxjsqabOmeByI0Q3L6008achvTGQ8h/4bSOupOk0GQwFtRu/4Yj0AEOEiTnisJrLXIMHOLMwNCi+PcuDqalT0grhZktASnbtSedhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWQfM4qg7xiLfjcIJwAj4GNrgBfm+6mrqUcPj7c2gWQ=;
 b=LwtCfIJzuafXDJVASy3SvnP+llshc+G+PvhyBpOlKZ+KbxqYhv8iZlARExTk7R81onoeFVoVo8o+h99uQMdwuFD640jg7TEZlOxv+c7qIglG1JTcVGJp4n4z+FYGrOoXQXp6YPoCHfM2ZrtFfeG2HsUsFs0PoH9CzeT6zpsSVGMs8yaPmfDUS/vt5wUXlpItMoH+ckrunCOW4qDH8FvTuI8b4Ha7s4Kw/x8fUJy5pBBhhVcxo/SM3YCsvveAuYBkRC2xAdsaxgtwBvEU5AtB7zeJTjjkvVUVl/BfAIXU/cq/7nuxGZckAQRedMuQjgINs8pAjeqFKNZZpfiqXZ0oqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWQfM4qg7xiLfjcIJwAj4GNrgBfm+6mrqUcPj7c2gWQ=;
 b=WORHc2ah3QPYPMF6YEbQ9JuZDH9z3jIuIGyoPFGplONe8tVsxwrlP+n4d9hzXw7aLBJonSSvvio/wM7l+rFBU4JSoqsv/oWq7/nCP3qyo8H1Pqg3Z2Dvz/I49TG8+mb22nwS7/wWUpMCwuWZ/fD+I1YzVPRv3BOt5P22GQSRjEo=
Received: from MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21)
 by MWHPR12MB1629.namprd12.prod.outlook.com (2603:10b6:301:3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Fri, 18 Dec
 2020 16:40:22 +0000
Received: from MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::858e:d929:4fab:5ac3]) by MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::858e:d929:4fab:5ac3%8]) with mapi id 15.20.3676.025; Fri, 18 Dec 2020
 16:40:22 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>
Subject: Re: [PATCH 2/2] drm/amd/display: enable idle optimizations for linux
 (MALL stutter)
Thread-Topic: [PATCH 2/2] drm/amd/display: enable idle optimizations for linux
 (MALL stutter)
Thread-Index: AQHW1JV86Pyo88/tb0uKRGAsJd7p5an7hDGAgAAHUlqAAALYZ4AAysoAgAC1ut8=
Date: Fri, 18 Dec 2020 16:40:22 +0000
Message-ID: <MW3PR12MB45542B6FF86591E78D4C5235F9C30@MW3PR12MB4554.namprd12.prod.outlook.com>
References: <20201217165459.3570331-1-Bhawanpreet.Lakha@amd.com>,
 <20201217165459.3570331-2-Bhawanpreet.Lakha@amd.com>,
 <MN2PR12MB448896B7772424C662E2EFD8F7C40@MN2PR12MB4488.namprd12.prod.outlook.com>,
 <MW3PR12MB4554D9CAF479797E24D4108EF9C40@MW3PR12MB4554.namprd12.prod.outlook.com>
 <MW3PR12MB45540F913662D5CE5ABFC87BF9C40@MW3PR12MB4554.namprd12.prod.outlook.com>,
 <BYAPR12MB36409B2596B0B06E0239D4038EC30@BYAPR12MB3640.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB36409B2596B0B06E0239D4038EC30@BYAPR12MB3640.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-18T16:40:21.849Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5a38802a-e38a-4a9a-71ea-08d8a3739d0a
x-ms-traffictypediagnostic: MWHPR12MB1629:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB162932793BB3F6401BFEE243F9C30@MWHPR12MB1629.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1D+NVcF7uBzYvacwwy0BPVV8dMzjLosCKUOUDh3FIUetpoo78+jIGamr5TrcbeWqQMM693C/AJQ8hGCEU06YoMJ3aOLBGuu51mDc3bJ4cTFnmowduWpxKaOWTgFHvXgx3e5OLrwmgMQgkSeHb2UtyhE4iA7dFAS1j25w3LlAGqWORvTC35h4UK0Bz1dl/fgEHmzASWvbYACWzC1BO3WzMA60zSx6hyVBL7/HiQ1pSbXHZpiVyKAIRWKVtG60Drmm39ecVEAVh499d8V7T+tB/lBMTQGbzTF6tfOAcRUeDoC8pic5TAOyIdtNPCH2tqTioXqgZ60VwvHC62cP1ejcvA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4554.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(76116006)(55016002)(66446008)(52536014)(86362001)(71200400001)(26005)(316002)(53546011)(66556008)(64756008)(8936002)(478600001)(186003)(9686003)(4326008)(6506007)(5660300002)(83380400001)(2906002)(33656002)(7696005)(6636002)(110136005)(19627235002)(66476007)(19627405001)(66946007)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?/66asdtwbP0EHX6APejYfaFkLP19PCwB3P39mkKIrEQLs478eH8nbv83?=
 =?Windows-1252?Q?BZ8+c8NwfG8KRx3v9kRRx7oDD7FLrXEkYaorX22tE/oFA9Lay0VZ9kj4?=
 =?Windows-1252?Q?8fFDkN957y8adyPrH9lhqj/hjZuwMm+VCnL4sN2UHJbyhw0oDyntQVPu?=
 =?Windows-1252?Q?r2LTwC/CiHlFel3qanoEpkaN4iE3s3zaQeG71hexg7OPp5RZsvjScrx3?=
 =?Windows-1252?Q?hN+jO41iM19qX4Ti28i5Wz4jzhZaIkzvooNKkrmgvwSeZreq4eYfrALj?=
 =?Windows-1252?Q?he0NoVTv70TWuPo7BpMFGlH7U4XZ9t/8J5Zf1AsCzxRZxjzhmOVLYpVm?=
 =?Windows-1252?Q?hjscEY2TCJxJ0CQhNhrzn5b81uZ2e0beM+hRuHCOywtUmQ78866Er4it?=
 =?Windows-1252?Q?MwmNnugAnn4aEEsdAFxj4SjuYBorfLcvhtKLfNA8DPSPEBLZEZcbQvyg?=
 =?Windows-1252?Q?ee0CG1dCXX5DNY8xMAqE4ZosvRlDQ5Ee5fu0XrnSM7+nf5+1ieDw0FUa?=
 =?Windows-1252?Q?Irmr3N8DddW4zMsdxG3A2ZbG44cwldqd3kQSQWqYXlWR+HU0rtFxk7XQ?=
 =?Windows-1252?Q?wHjtJSsHv3TzrFkhB395fXxGjvkW9JivPI3So3hAQQcTfz05WXPFueN7?=
 =?Windows-1252?Q?SHNSrdEuBlmiWaSccfLjFnOErf49kLMeHpqF9T0otwzURdWhpZRH0YLr?=
 =?Windows-1252?Q?ysXVJ6Y2jKh2lR6bG7KwA8lIKnKvb54fcxBIYnxHF8Pzp9JLHoAiCVRJ?=
 =?Windows-1252?Q?ic3cwxjINqYi25cfMQ4CguJimmyAGRqRxR0CJlYGFPrx8r0LnD68I/fY?=
 =?Windows-1252?Q?lSIzVNSBki017jAXqrCw6d42ID+DnJycwMpLhVGYiuotDih3t1A7kXq3?=
 =?Windows-1252?Q?SdvefnW08C7aAQx/S46GMQMgcuG4TgpbNT/aELExlTqMDsoWPUgMBa2B?=
 =?Windows-1252?Q?7StoqYDRML2kGRTiLyz9SIQT4wmgfymtOQRNe9eX8g79KqlKkIrtbWin?=
 =?Windows-1252?Q?WYXo1t8Md2N3h2VJ3xgFPefcE3XjT7fX6/bRCby9+F/ocGuxvGA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4554.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a38802a-e38a-4a9a-71ea-08d8a3739d0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2020 16:40:22.3442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6pwARf8ONuwiYx2nyZlmHkE3d5O4HIMol0Ex3ygV40SwsL+9/D3YR0QxSSb5W8PO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1629
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
Content-Type: multipart/mixed; boundary="===============1593500393=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1593500393==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB45542B6FF86591E78D4C5235F9C30MW3PR12MB4554namp_"

--_000_MW3PR12MB45542B6FF86591E78D4C5235F9C30MW3PR12MB4554namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Hi Kenneth,

The patches currently have the Kconfig so make sure to enable that first.

And dc_allow_idle_optimizations() will be called when all the vblank irqs a=
re off. On Ubuntu, this will happen after the desktop is idle for a few sec=
onds.

Bhawan
________________________________
From: Feng, Kenneth <Kenneth.Feng@amd.com>
Sent: December 18, 2020 12:46 AM
To: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Deucher, Alexander <Ale=
xander.Deucher@amd.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/display: enable idle optimizations for lin=
ux (MALL stutter)


[AMD Public Use]


[AMD Public Use]



Hi Bhawanpreet,

With the two patches, I still can=92t see that dc_allow_idle_optimizations(=
struct dc *dc, bool allow) is called with allow =3D true after modprobe and=
 startx.

Is there anything else missing?



Best Regards

Kenneth



From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lakha, B=
hawanpreet
Sent: Friday, December 18, 2020 1:42 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Kazlauskas, Nicholas <N=
icholas.Kazlauskas@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/amd/display: enable idle optimizations for lin=
ux (MALL stutter)



[AMD Public Use]



[CAUTION: External Email]

[AMD Public Use]



Actually, I will drop the guards and if we see issues related to this, we c=
an block it.



Bhawan

________________________________

From: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com<mailto:Bhawanpreet.Lakh=
a@amd.com>>
Sent: December 17, 2020 12:32 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com<mailto:Nichola=
s.Kazlauskas@amd.com>>
Cc: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: Re: [PATCH 2/2] drm/amd/display: enable idle optimizations for lin=
ux (MALL stutter)



I would but MALL is not fully validated so it might cause underflow issues =
if we keep it enabled by default. I can create a feature flag mask if that =
helps?



Bhawan

________________________________

From: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deuche=
r@amd.com>>
Sent: December 17, 2020 12:04 PM
To: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com<mailto:Bhawanpreet.Lakha@=
amd.com>>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com<mailto:Nichola=
s.Kazlauskas@amd.com>>
Cc: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: Re: [PATCH 2/2] drm/amd/display: enable idle optimizations for lin=
ux (MALL stutter)



[AMD Public Use]



Can we drop the Kconfig?  With that, the series is:

Acked-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deucher@=
amd.com>>

________________________________

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com<mailto:Bhawanpreet.Lakha=
@amd.com>>
Sent: Thursday, December 17, 2020 11:54 AM
To: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com<mailto:Nicholas.Kazla=
uskas@amd.com>>; Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexa=
nder.Deucher@amd.com>>
Cc: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Lakha, =
Bhawanpreet <Bhawanpreet.Lakha@amd.com<mailto:Bhawanpreet.Lakha@amd.com>>; =
Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com<mailto:Nicholas.Kazlauska=
s@amd.com>>
Subject: [PATCH 2/2] drm/amd/display: enable idle optimizations for linux (=
MALL stutter)



[Why]
We can only use this feature when the display is idle. When active vblank
irq count is 0 we know all the displays are idle.

[How]
-Add a active vblank irq counter
-Update the counter when we enable/disable vblank irq
-if vblank irq count is 0 we can consider mall stutter

Change-Id: Ib1e14a84ee2e8c6e057072128693449665012584
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com<mailto:Bhawanpr=
eet.Lakha@amd.com>>
Acked-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deucher@=
amd.com>>
Reviewed-by: Nick Kazlauskas <Nicholas.Kazlauskas@amd.com<mailto:Nicholas.K=
azlauskas@amd.com>>
---
 drivers/gpu/drm/amd/display/Kconfig           |  6 +++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 +++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  9 ++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +++
 4 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/disp=
lay/Kconfig
index 797b5d4b43e5..2444e664c7ee 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -23,6 +23,12 @@ config DRM_AMD_DC_HDCP
         help
           Choose this option if you want to support HDCP authentication.

+config DRM_AMD_DC_MALL
+       bool "Enable MALL support"
+       depends on DRM_AMD_DC
+       help
+         Choose this option if you want to support MALL
+
 config DRM_AMD_DC_SI
         bool "AMD DC support for Southern Islands ASICs"
         default n
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a78ec16418b3..080f2a52cfed 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5479,6 +5479,7 @@ static inline int dm_set_vblank(struct drm_crtc *crtc=
, bool enable)
         struct amdgpu_crtc *acrtc =3D to_amdgpu_crtc(crtc);
         struct amdgpu_device *adev =3D drm_to_adev(crtc->dev);
         struct dm_crtc_state *acrtc_state =3D to_dm_crtc_state(crtc->state=
);
+       struct amdgpu_display_manager *dm =3D &adev->dm;
         int rc =3D 0;

         if (enable) {
@@ -5494,7 +5495,28 @@ static inline int dm_set_vblank(struct drm_crtc *crt=
c, bool enable)
                 return rc;

         irq_source =3D IRQ_TYPE_VBLANK + acrtc->otg_inst;
+#if defined(CONFIG_DRM_AMD_DC_MALL)
+
+       if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
+               return -EBUSY;
+
+       mutex_lock(&dm->dc_lock);
+
+       if (enable)
+               dm->active_vblank_irq_count++;
+       else
+               dm->active_vblank_irq_count--;
+
+       dc_allow_idle_optimizations(
+               adev->dm.dc, dm->active_vblank_irq_count =3D=3D 0 ? true : =
false);
+
+       DRM_DEBUG_DRIVER("Allow idle optimizations (MALL): %d\n", dm->activ=
e_vblank_irq_count =3D=3D 0);
+       mutex_unlock(&dm->dc_lock);
+
+       return 0;
+#else
         return dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EB=
USY;
+#endif
 }

 static int dm_enable_vblank(struct drm_crtc *crtc)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 251af783f6b1..cab44bbd2e35 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -336,6 +336,15 @@ struct amdgpu_display_manager {
          */
         const struct gpu_info_soc_bounding_box_v1_0 *soc_bounding_box;

+#if defined(CONFIG_DRM_AMD_DC_MALL)
+       /**
+        * @active_vblank_irq_count
+        *
+        * number of currently active vblank irqs
+        */
+       uint32_t active_vblank_irq_count;
+#endif
+
 #ifdef CONFIG_DEBUG_FS
         /* set the crc calculation window*/
         struct drm_property *crc_win_x_start_property;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/disp=
lay/dc/dc.h
index 33642566bcb2..9d245033eb3d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -504,6 +504,9 @@ struct dc_debug_options {
         bool dmcub_emulation;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
         bool disable_idle_power_optimizations;
+#endif
+#ifdef CONFIG_DRM_AMD_DC_MALL
+       unsigned int mall_size_override;
 #endif
         bool dmub_command_table; /* for testing only */
         struct dc_bw_validation_profile bw_val_profile;
--
2.25.1

--_000_MW3PR12MB45542B6FF86591E78D4C5235F9C30MW3PR12MB4554namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size:12pt">Hi Kenneth,<br>
<br>
<span style=3D"font-size:12pt">The patches currently have the Kconfig so ma=
ke sure to enable that first.</span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size:12pt"><span style=3D"font-size:12pt"></span><br>
</span><span style=3D"font-size:12pt">And dc_allow_idle_optimizations() wil=
l be called when all the vblank irqs are off. On Ubuntu, this will happen a=
fter the desktop is idle for a few seconds.
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Bhawan<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Feng, Kenneth &lt;Ken=
neth.Feng@amd.com&gt;<br>
<b>Sent:</b> December 18, 2020 12:46 AM<br>
<b>To:</b> Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; Deucher, A=
lexander &lt;Alexander.Deucher@amd.com&gt;; Kazlauskas, Nicholas &lt;Nichol=
as.Kazlauskas@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amd/display: enable idle optimizations =
for linux (MALL stutter)</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:DengXian}
@font-face
	{font-family:Calibri}
@font-face
	{}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:#0563C1;
	text-decoration:underline}
span.x_EmailStyle18
	{font-family:"Calibri",sans-serif;
	color:windowtext}
p.x_msipheader251902e5, li.x_msipheader251902e5, div.x_msipheader251902e5
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:b=
reak-word">
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#317100=
; margin:15pt">
[AMD Public Use]<br>
</p>
<br>
<div>
<div class=3D"x_WordSection1">
<p class=3D"x_msipheader251902e5" style=3D"margin:0in"><span style=3D"font-=
size:10.0pt; font-family:&quot;Arial&quot;,sans-serif; color:#317100">[AMD =
Public Use]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt">Hi Bhawanpreet,</=
span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt">With the two patc=
hes, I still can=92t see that dc_allow_idle_optimizations(struct dc *dc, bo=
ol allow) is called with allow =3D true after modprobe and startx.</span></=
p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt">Is there anything=
 else missing?</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt">&nbsp;</span></p>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt">Best Regards</spa=
n></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt">Kenneth</span></p=
>
</div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt">&nbsp;</span></p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.fre=
edesktop.org&gt;
<b>On Behalf Of </b>Lakha, Bhawanpreet<br>
<b>Sent:</b> Friday, December 18, 2020 1:42 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kazlauskas=
, Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amd/display: enable idle optimizations =
for linux (MALL stutter)</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:#317100">[AMD Public Use]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<p class=3D"x_MsoNormal">[CAUTION: External Email] </p>
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:#317100">[AMD Public Use]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">Actu=
ally, I will drop the guards and if we see issues related to this, we can b=
lock it.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">Bhaw=
an</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"color:black">From:</span></b><sp=
an style=3D"color:black"> Lakha, Bhawanpreet &lt;<a href=3D"mailto:Bhawanpr=
eet.Lakha@amd.com">Bhawanpreet.Lakha@amd.com</a>&gt;<br>
<b>Sent:</b> December 17, 2020 12:32 PM<br>
<b>To:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;; Kazlauskas, Nicholas &lt;<a href=3D"=
mailto:Nicholas.Kazlauskas@amd.com">Nicholas.Kazlauskas@amd.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amd/display: enable idle optimizations =
for linux (MALL stutter)</span>
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">I wo=
uld but MALL is not fully validated so it might cause underflow issues if w=
e keep it enabled by default. I can create a feature flag mask if that help=
s?</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">Bhaw=
an</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"color:black">From:</span></b><sp=
an style=3D"color:black"> Deucher, Alexander &lt;<a href=3D"mailto:Alexande=
r.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Sent:</b> December 17, 2020 12:04 PM<br>
<b>To:</b> Lakha, Bhawanpreet &lt;<a href=3D"mailto:Bhawanpreet.Lakha@amd.c=
om">Bhawanpreet.Lakha@amd.com</a>&gt;; Kazlauskas, Nicholas &lt;<a href=3D"=
mailto:Nicholas.Kazlauskas@amd.com">Nicholas.Kazlauskas@amd.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amd/display: enable idle optimizations =
for linux (MALL stutter)</span>
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:#317100">[AMD Public Use]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">Can =
we drop the Kconfig?&nbsp; With that, the series is:</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">Acke=
d-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com">alexand=
er.deucher@amd.com</a>&gt;</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_x_x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"color:black">From:</span></b><sp=
an style=3D"color:black"> Bhawanpreet Lakha &lt;<a href=3D"mailto:Bhawanpre=
et.Lakha@amd.com">Bhawanpreet.Lakha@amd.com</a>&gt;<br>
<b>Sent:</b> Thursday, December 17, 2020 11:54 AM<br>
<b>To:</b> Kazlauskas, Nicholas &lt;<a href=3D"mailto:Nicholas.Kazlauskas@a=
md.com">Nicholas.Kazlauskas@amd.com</a>&gt;; Deucher, Alexander &lt;<a href=
=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;; Lakha, Bhawanpreet &lt;<a href=3D"mailt=
o:Bhawanpreet.Lakha@amd.com">Bhawanpreet.Lakha@amd.com</a>&gt;;
 Kazlauskas, Nicholas &lt;<a href=3D"mailto:Nicholas.Kazlauskas@amd.com">Ni=
cholas.Kazlauskas@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amd/display: enable idle optimizations for =
linux (MALL stutter)</span>
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin-bottom:12.0pt">[Why]<br>
We can only use this feature when the display is idle. When active vblank<b=
r>
irq count is 0 we know all the displays are idle.<br>
<br>
[How]<br>
-Add a active vblank irq counter<br>
-Update the counter when we enable/disable vblank irq<br>
-if vblank irq count is 0 we can consider mall stutter<br>
<br>
Change-Id: Ib1e14a84ee2e8c6e057072128693449665012584<br>
Signed-off-by: Bhawanpreet Lakha &lt;<a href=3D"mailto:Bhawanpreet.Lakha@am=
d.com">Bhawanpreet.Lakha@amd.com</a>&gt;<br>
Acked-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com">ale=
xander.deucher@amd.com</a>&gt;<br>
Reviewed-by: Nick Kazlauskas &lt;<a href=3D"mailto:Nicholas.Kazlauskas@amd.=
com">Nicholas.Kazlauskas@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 +++++<br>
&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 ++++++++++++++++++=
+<br>
&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |&nbsp; 9 ++++++++<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dc.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 +++<br>
&nbsp;4 files changed, 40 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/disp=
lay/Kconfig<br>
index 797b5d4b43e5..2444e664c7ee 100644<br>
--- a/drivers/gpu/drm/amd/display/Kconfig<br>
+++ b/drivers/gpu/drm/amd/display/Kconfig<br>
@@ -23,6 +23,12 @@ config DRM_AMD_DC_HDCP<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Choose this op=
tion if you want to support HDCP authentication.<br>
&nbsp;<br>
+config DRM_AMD_DC_MALL<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;Enable MALL support&quot;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on DRM_AMD_DC<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Choose this option if you=
 want to support MALL<br>
+<br>
&nbsp;config DRM_AMD_DC_SI<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;AMD DC support =
for Southern Islands ASICs&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default n<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index a78ec16418b3..080f2a52cfed 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -5479,6 +5479,7 @@ static inline int dm_set_vblank(struct drm_crtc *crtc=
, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_crtc *acrtc =
=3D to_amdgpu_crtc(crtc);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D drm_to_adev(crtc-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dm_crtc_state *acrt=
c_state =3D to_dm_crtc_state(crtc-&gt;state);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_display_manager *dm =3D=
 &amp;adev-&gt;dm;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int rc =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
@@ -5494,7 +5495,28 @@ static inline int dm_set_vblank(struct drm_crtc *crt=
c, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return rc;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; irq_source =3D IRQ_TYPE_VB=
LANK + acrtc-&gt;otg_inst;<br>
+#if defined(CONFIG_DRM_AMD_DC_MALL)<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dc_interrupt_set(adev-&gt;dm.dc,=
 irq_source, enable))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EBUSY;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;dm-&gt;dc_lock);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dm-&gt;active_vblank_irq_count++;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dm-&gt;active_vblank_irq_count--;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_allow_idle_optimizations(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;dm.dc, dm-&gt;active_vblank_irq_count =3D=3D 0 ? true :=
 false);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_DRIVER(&quot;Allow idle opt=
imizations (MALL): %d\n&quot;, dm-&gt;active_vblank_irq_count =3D=3D 0);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;dm-&gt;dc_lock);<br=
>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+#else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return dc_interrupt_set(ad=
ev-&gt;dm.dc, irq_source, enable) ? 0 : -EBUSY;<br>
+#endif<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int dm_enable_vblank(struct drm_crtc *crtc)<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
index 251af783f6b1..cab44bbd2e35 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
@@ -336,6 +336,15 @@ struct amdgpu_display_manager {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct gpu_info_soc_=
bounding_box_v1_0 *soc_bounding_box;<br>
&nbsp;<br>
+#if defined(CONFIG_DRM_AMD_DC_MALL)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @active_vblank_irq_count<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * number of currently active vb=
lank irqs<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t active_vblank_irq_count;<br>
+#endif<br>
+<br>
&nbsp;#ifdef CONFIG_DEBUG_FS<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set the crc calculation=
 window*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_property *crc_w=
in_x_start_property;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/disp=
lay/dc/dc.h<br>
index 33642566bcb2..9d245033eb3d 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dc.h<br>
+++ b/drivers/gpu/drm/amd/display/dc/dc.h<br>
@@ -504,6 +504,9 @@ struct dc_debug_options {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool dmcub_emulation;<br>
&nbsp;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool disable_idle_power_op=
timizations;<br>
+#endif<br>
+#ifdef CONFIG_DRM_AMD_DC_MALL<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int mall_size_override;<br>
&nbsp;#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool dmub_command_table; /=
* for testing only */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_bw_validation_pr=
ofile bw_val_profile;<br>
-- <br>
2.25.1</p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MW3PR12MB45542B6FF86591E78D4C5235F9C30MW3PR12MB4554namp_--

--===============1593500393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1593500393==--
