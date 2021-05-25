Return-Path: <SRS0=WUpi=KU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7F7C2B9F8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 07:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C43426128B
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 07:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43426128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57C366E932;
	Tue, 25 May 2021 07:42:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C3646E932
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 May 2021 07:42:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAGkiqlwJ6hkGV7OPH5schLvbdxiNYFn2B/XkAiPYM+3mTKza7bZJac42HPihj/97EpV6Z+Wi5V0mpQdeLFqzOl64zeC/UT5g7R0o15fLru5lBPO9COgYVlwGWSVv2Q9fZ0RpnT/z9Ygq6MTn6Ix641hewwIJBK1o+3HwbVu/+Z8HU+WTkJv0WOlhEWE9upYBRKwo71lOsKRoqHA3/TRW1hCHbQPRkssa/Zp8EJEQXj8KKgIS35feaXiWpavHBrKafYL343m03W0Cea+FYOViG0MelnFwRxLbGJWALfk+jNgsowEd1FwLxwWLbImnPlDZOrnzIYzPVgXZg05cGYfLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFq3e1onrpdOrsGr+limO6YDKzX44kWICprt/TENd6E=;
 b=FKQtXeLgTa0lkHNeh49omypLIEn4JUtRli9nZ8pcf2r0/6ons8j2aoUvTs9DltWb2ltsmMxP8mE+e1DJ/2RqaO1BrZVzJ9+3l0nxnB9l6tn0zFHeFPtZdbL8XiJsMgNdBg910et2Hmv+WjqCBGfpnvKJfNFCxogXKi63yyXJmdV7jKMTnPgN7eRK5nmz1L3DZCd5Y2/OqSmBhMGZV0OfCF1zrNDzwiPFbLT9dTAD8Nl4DQCIwbbfDSYewxGNgmiGLcn2Na7kQI/gzXLqZuZKh407K6JQzzNBoPLT+yf/Ls2OcG6hiNfTw5bOWhFgsz2DOqqMNXQysAeMswK132jgwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFq3e1onrpdOrsGr+limO6YDKzX44kWICprt/TENd6E=;
 b=2xCCmZcqMYOIkDhILeUgAwC4bna8527WCX6D9o+Fjz47EHd5PCFCYEAywTgOdJUktG02o9LQXfjDjYUtUkYKTovGMJdO+rIsrzx97D1INrN4fL5WwqEbiLj/O0Pz9DloneyOY21vBhPFq74EbIFOpMxhWbBvSaVTMf43FVg3d44=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1413.namprd12.prod.outlook.com (2603:10b6:903:39::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 07:42:04 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::50b1:6f8a:9b37:8835]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::50b1:6f8a:9b37:8835%4]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 07:42:04 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Song, Asher" <Asher.Song@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add judgement for dc support
Thread-Topic: [PATCH] drm/amdgpu: add judgement for dc support
Thread-Index: AQHXURrsMJcuZJBPDEWq/uiVIwyD2qrz0JHA
Date: Tue, 25 May 2021 07:42:04 +0000
Message-ID: <CY4PR12MB12877AB9450C7E0A1CD98A1CF1259@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210525040304.294667-1-Asher.Song@amd.com>
In-Reply-To: <20210525040304.294667-1-Asher.Song@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-25T07:42:01Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=3cf4d632-9e74-4ce4-95ab-f9ad0eed0344;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66b59d1a-c23c-4203-8f67-08d91f509727
x-ms-traffictypediagnostic: CY4PR12MB1413:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB14134FBA39457FB61C438443F1259@CY4PR12MB1413.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xg3G3Tpv9aLGB4h5tkkxTkzVc9i83sGQSp6zF+1AwKLUlr/yr4QZW4dfRmwHWKD2xP0kSpHoikj8SMfdLoMZGdYO9nTPHRk3ijH4eGfM7pfPu1s1SHVq7UQAfqdcSNxkHV0/QLtjHOqnltZ6f/OrKuo7U5XhCVfAXibbq1LFwcqm5S4O0IGe20cNaCg/7CbPkNw/RhOc/+EnX3xJeSAUPTGLCROOA2pkgLjWY7CGe0iQh9kBIa4Cq4p3iZvhDZaZ7oBaDFikDgv8TYOjQIzZjQFqdp4ZXFLRLmpfHNqlqlz3pyIqxSLDmR82neNphC3Q3KKmW8Y2C7RFmtC01vSGIdEQ2jogNAaVYS+IciLdyvl3CfjRl5cRBakWTdFFs7tgjlDoE3+Lfh3EWaQBT3i9sN1yVHTUT6G+OTN/q/ESj6kAYYC5nKMXcvfbGVEyl57ZZInbVKpMJi9NJFFqBtuBYAssPrSoKN1Y2Hkzfx4w91asy9OOnjqTye5b9Q4z9T0+6bfaM/EpGLQltBLaQE32ZISleVKs1g5JrQwfZ7sR3vMz7vsdrdbzCBgcmqdKhciA/dolY1/G00XCJl+P1pDS00PH+3LQpPRcWHF9UCLtGEEU6peVYH6uhgRmnb90/68uRjom9eiKHBwdn44RI2z29g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(76116006)(66446008)(66556008)(66946007)(52536014)(66476007)(64756008)(55016002)(26005)(33656002)(45080400002)(9686003)(8936002)(71200400001)(110136005)(54906003)(5660300002)(316002)(6506007)(7696005)(53546011)(966005)(122000001)(83380400001)(38100700002)(86362001)(4326008)(478600001)(8676002)(186003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3xWCvioPEEkUKLTX8/tjYUIhSWdHqYMeE45ic0Cvgu0VqgDO29QyObybuBfe?=
 =?us-ascii?Q?o2eV5QPejh+2yRnZOKEAmCwCnW/Yt+CNCPn4Vl1guzUqd7jN2x83eudzd1E0?=
 =?us-ascii?Q?4niXy4hhjlxCXGwkFN8k1p/hRHD/7fRO4npA0omU/uCqlLAQj1VVd9QQMApo?=
 =?us-ascii?Q?PoxnbDxNDwzvQX/2M9KiDGghbaSJYIB3XaMImIe4WYLIG5T81mQXnbQnUcYR?=
 =?us-ascii?Q?Ej9Zimzv7/S9uwuPEBGEHLKazAiEG3FBbzOVOJMfP4RO663LVw5Yyt8SN8DZ?=
 =?us-ascii?Q?2DYBZYJ+9gE8Iv0xFrlBLqj6EVSiJ0n3JItqgPsO9WBClD3PX9YE9mBXeeWe?=
 =?us-ascii?Q?n4CgSWmz2d9jdt7OCCsDZKq11RnlLcXAWbKqjhkt45yJUXcwPD17o6EDvgAu?=
 =?us-ascii?Q?EcEs0ttezxVzxf5ePXppUANR9D0MdYDyf1hVBsxwLRLLp9O6sXFxy5AxXoUg?=
 =?us-ascii?Q?VRREN83A+0EaYaaGxZrmsesg2hVfPk0bCy9+sUo0lMRNGLwUmZhSIqhrJeOQ?=
 =?us-ascii?Q?pmMy90SNi+vQRCGZolrEkXsOwBKuV0ZDa8370ZRUjSG3tzRMDZyGH4O6h6uP?=
 =?us-ascii?Q?BKiHQtRu0wUb75XyPZWWtQ7Pqq1MdB8IQOK3NkSR3t4yp8D+BZfMA21frnku?=
 =?us-ascii?Q?uvGhIdK25R+ic1ANdDyGKppWkDDvO0SHcrg8Ul/tu9tWf+8l93PvyCYAkt/J?=
 =?us-ascii?Q?s4OmvEIrat18SgXQ8ecxAcbOCWV0Owv01tLw8oUzC8+0r2BaxwlBIEKjZZ5E?=
 =?us-ascii?Q?Cafy/igu6PNzFMfYluyk4+4NyU39vvsQiQihiycG/6j8DzLy6fyRuCaMoraT?=
 =?us-ascii?Q?O/DM6LdsWrb+bcSUhfSnAk3V+MYBb6tNZ+B/4hV251WjbDjArbRAAT7PgHnQ?=
 =?us-ascii?Q?xn7ftYXBYfIYyRWlvWV7PJJiOZoF9mRKHSGxzP5MrHe90Ixx538i8Sn8iFBw?=
 =?us-ascii?Q?jW6hL5wglG28PXv9RTKWMGsFtaPwaXcEytTahYXIRClyckRUQK2SijJOL9ZL?=
 =?us-ascii?Q?YUV+cgUOQ2vxzNVYyZ+cnn8dqGude1tJCtgMspl2Wv+gcE90tVhqDfvptKV1?=
 =?us-ascii?Q?Z7snguNWbHYWflZ3qyM/M+p6uUXXbFV58Tqg8W8p6fMiodf/VeUMYg4DQvSm?=
 =?us-ascii?Q?bIiNxj6x+zFlI4XOkqHpc1FqOMGvb9uCX5si+OkMUPfgor4F0HofydSpoaeY?=
 =?us-ascii?Q?xRdf6e7QwHaie9ByYmKDs8Jyc9nGni9e+o1spfCKaef8hrmsdpERJ8USNw1p?=
 =?us-ascii?Q?1Q+TYPrAKLo7+E0FmyHcylitJXoEIMmuER3aGEyPswhFz5ltD6Gbi7aY39vm?=
 =?us-ascii?Q?9XfhI84LePR2Rkq1mRw8vAvL?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b59d1a-c23c-4203-8f67-08d91f509727
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 07:42:04.1773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jFYFyVEAkjRD9i1EYYCuRXC0Zh4vp7nn0HgGIvawrCr1Qe9DvZuw75r2ukfUEE1GNKALGQFKdpBoXJQyoQJFkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1413
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
Cc: "Gao, Likun" <Likun.Gao@amd.com>, "Song, Asher" <Asher.Song@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Asher Song
Sent: Tuesday, May 25, 2021 12:03 PM
To: amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>; Song, Asher <Asher.Song@amd.com>
Subject: [PATCH] drm/amdgpu: add judgement for dc support

Drop DC initialization when DCN is harvested in VBIOS. The way doesn't affect virtual display ip initialization.

Signed-off-by: Likun Gao  <Likun.Gao@amd.com>
Signed-off-by: Asher Song <Asher.Song@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8848e2b9bef9..148da7ca5d55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3122,7 +3122,9 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
  */
 bool amdgpu_device_has_dc_support(struct amdgpu_device *adev)  {
-	if (amdgpu_sriov_vf(adev) || adev->enable_virtual_display)
+	if (amdgpu_sriov_vf(adev) || 
+	    adev->enable_virtual_display ||
+	    (adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK))
 		return false;
 
 	return amdgpu_device_asic_has_dc_support(adev->asic_type);
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C5eb77a59b5464e32a9bd08d91f320d33%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637575122105724763%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=AfI8xHK0tGLZCKdiNF%2BBSkw7X94mkbhiSJw2JyTK61E%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
