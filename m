Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEA6C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 01:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C674F23380
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 01:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C674F23380
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E8A389C6E;
	Fri,  8 Jan 2021 01:45:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B42B389C6E
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 01:45:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ds9SrKFR+fMHacrMBdhf1PBAQvEx/brqERtSqy4S1stq9KZr4ZxWGSD/63Zs0qMD8M0yQpS7jFOtmpH3WcXEu14FnElND9eWiHAloFHvVjXbmU8pKOt32eauhIXFOcgJkZAmahzD86bt1XTCJrTr5MYYmV2JzhL4k65AtCD+F4KN36xkugS2qbNUrgbZaWolNP5FAXfP9OO2SbU2rDE22CG/1Bx+1qyj+gkNel1LBbCX/EeyA3LXJ9LyOCGjWewjhw75nZTf96Lw/Hyj1k5UZUQm5wsnNLvqBeeROnijG2XoTpPt6hHyGPq1ce9VOtfdmQ0yD9e+EUP9iMrhjDRhXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fpHqEKP1n4cF67ygP8yRZVJEa/W3jSxf1BDxFia64w=;
 b=Pdijlzbs/RjH29kAQzQdLMjOdXuqHQk+VAOeCUffG0BJn1IBrLnVv4nGipIrsSPmdRW9jzmnZ+GAQJPp2vFw7ztBpDUyQNKT80lKivzqoNHkfob27+67vvXKmpYRfhVrCZ8/LQFLTsxtbhZm3wwtuUDa4OrPr3AFJR7aH77XOrXAQPbYlzbYy6z6LeelnYC4Qp+t2fPmOZmoFf7J2tiKk1EUzCue6xJ+NrOLheB5lQWm7CjGv2oPIkrHKiFJ3iVeWFRsbN5NsROUaeliEMkCiPPCgSWIZ8E2u0WaALNdCN7KJBB9qUurpXXz6E+73IGTg8lxLkl0bOVks8XPw1S1cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fpHqEKP1n4cF67ygP8yRZVJEa/W3jSxf1BDxFia64w=;
 b=IlvCjtExYvJNevNTyWLqoD08vKp9ga3O5vSeYOA2Jp5vpgU677RYUwaCgeli+FPt24FTzWTGnhYovZOfb/rxQIHs3rDQe8wZ27isk8jSYk32ZFSSHC6IivWU/cY3m7ZLU/9NGQ1Ab1Vc4R2a+1ioqK9smJh0jW47e7VnXLf97Yk=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 8 Jan
 2021 01:45:48 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145%5]) with mapi id 15.20.3742.006; Fri, 8 Jan 2021
 01:45:48 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu:Limit the resolution for virtual_display
Thread-Topic: [PATCH v2] drm/amdgpu:Limit the resolution for virtual_display
Thread-Index: AQHW5KVRqTF27MuwQkGt+AIkPIfolKoc9qJg
Date: Fri, 8 Jan 2021 01:45:48 +0000
Message-ID: <BY5PR12MB4115BE023BAF8FE53E2070158FAE0@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210107032927.660772-1-Emily.Deng@amd.com>
In-Reply-To: <20210107032927.660772-1-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=58b130fb-a0dd-4767-b6cc-c4c1dea15862;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-08T01:45:37Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d2b9616e-7645-4549-ab3f-08d8b3771f97
x-ms-traffictypediagnostic: BY5PR12MB4307:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB430758D2A2103162EDCA21588FAE0@BY5PR12MB4307.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uy5hdJBu/5CywPY/iuCB4gOygAgbDET3okh827RU7xhGsD1v4P7hgoTJOwhYPTvq751muTRju0uKZzrUZK0/qLYLY4/NKff3aehSBwSbCWIfGQn4H69q9G54ABClFinrrs/43bqXc1l3HZMCVihjBb+rauJkd8TVpG5BiX1qBjQPQZA/RPqoDaAXdKoPksQhoc3uHzzT1qGE2EaTBmzv1YCZouUQIZ02t8a0sB+8Y3tDOCM2e1H0BwRW9PDwPp1krhYkKgjxaBm+d7kdvCoSFphRN5d89JLJ40Rf/C68/vYgEOAcp2UWLmkyrt7cXQwhOFf/c4KNwfTSn3bVmdQNfzwDt5/bqqu4KtxyLF5F4AtGWKXTV7XMUmQlzOB780BPNvhpLJKD5OWjNX/RYE3bRg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(8676002)(83380400001)(9686003)(186003)(26005)(86362001)(6506007)(55016002)(8936002)(110136005)(7696005)(5660300002)(2906002)(33656002)(478600001)(66476007)(52536014)(64756008)(66946007)(66556008)(66446008)(76116006)(71200400001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pFewadZbp0RRPX9wQ7gWPpe7CRqPFWznN/DXeO/DErAR3lAfZEVzHrT0EeFM?=
 =?us-ascii?Q?bK1aPpt/prdoB9CTfLy996srI3thNsCvgWsHNU7Z3cZW138FsIBhtMHvBOlT?=
 =?us-ascii?Q?LcJaGQziAfU43cNB6lngC/PjK9cIyOOiPnfyYRf8zp5Dnt70X3pfqFj5betk?=
 =?us-ascii?Q?QC+Wf5N45D5rbfigwFOrms0UUAcISRGeMabxRrTWrpYreVhgFW8rTAqoxrE0?=
 =?us-ascii?Q?A/+VOhnPrQ7DzsvjpsPF2tLR/pJ+h6hOTzyVGfXoZivRN+fkHrAwqwWmTK8O?=
 =?us-ascii?Q?QFuys11lgOyfbnXZ1Kq/d7iQ1n4PBHsTe2M15cSOZPdkKEIWRYjHYen8UQ6O?=
 =?us-ascii?Q?XPsnfCwpF6gypogsIiF7DRVb5L88Z6FDFuNndveAak+65QznKuTHLeYFtcBi?=
 =?us-ascii?Q?wI6HpjaIVXJvJ47umOeGELpZfOW3flRdKnCyUQ5P8Qqo4fpGeh+l88+4BZPI?=
 =?us-ascii?Q?3OXdR/7eg30Ts2Uk1PcIqZ9k/9E4LJ87+CNgwEahduySSkQ2Ek9TYaznZLxj?=
 =?us-ascii?Q?KgEyRESqNXIkDHEOdZahHpdriKjPCznVSUpluq44E+5PABbTIIKqISdafpav?=
 =?us-ascii?Q?d25Zit8Xyuy8Ch0qf7baqBYbYzXU0MKxxmpK7nHUPkbrr7Hc/A/nqtIYGZnV?=
 =?us-ascii?Q?VOT6YECNppewmzkFq5uuAG2BjMmnAGjB+FlLg1XzxltBcXEWBBT69+lOuBm5?=
 =?us-ascii?Q?GrnmlCKEdmk5tHMt+O8OG23ahD3Wa+BgqilesANf9Kn+aHvFn5bT3Qga/RB+?=
 =?us-ascii?Q?9TfFeLW8CHDWlrXn8stxsdhaE8Ib3mTBFUwixCKxKHvHMgkApFEhDP5kbjCd?=
 =?us-ascii?Q?Eok7syGUbX0KMEHm/HwX3E0xiwI96b44JB665pgMI/CErZs7e0irS/DFI3DQ?=
 =?us-ascii?Q?BqryKJGDiFyvJc2GTdH06sXc1wiLDUqed4qUWKLyx5/+//4p5z8h3b7PAFBc?=
 =?us-ascii?Q?syVpWN1nZQWWN+iEgouNDxJTpO3eEB35qY6XBYyWnag5y1jqFhV4SBHNJJmI?=
 =?us-ascii?Q?Voq7?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b9616e-7645-4549-ab3f-08d8b3771f97
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 01:45:48.4970 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YQEpQ/8MA1df5dA7zT/+vsvFC29lvJnyz3asLImxgRzelAhyGZKkdRRkw2o9AvDn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Ping ......

Best wishes
Emily Deng



>-----Original Message-----
>From: Emily Deng <Emily.Deng@amd.com>
>Sent: Thursday, January 7, 2021 11:29 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH v2] drm/amdgpu:Limit the resolution for virtual_display
>
>From: "Emily.Deng" <Emily.Deng@amd.com>
>
>Limit the resolution not bigger than 16384, which means
>dev->mode_info.num_crtc * common_modes[i].w not bigger than 16384.
>
>v2:
>  Refine the code
>
>Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>index 2b16c8faca34..fd2b3a6dfd60 100644
>--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>@@ -319,6 +319,7 @@ dce_virtual_encoder(struct drm_connector
>*connector)  static int dce_virtual_get_modes(struct drm_connector
>*connector)  {
> struct drm_device *dev = connector->dev;
>+struct amdgpu_device *adev = dev->dev_private;
> struct drm_display_mode *mode = NULL;
> unsigned i;
> static const struct mode_size {
>@@ -350,8 +351,10 @@ static int dce_virtual_get_modes(struct
>drm_connector *connector)
> };
>
> for (i = 0; i < ARRAY_SIZE(common_modes); i++) {
>-mode = drm_cvt_mode(dev, common_modes[i].w,
>common_modes[i].h, 60, false, false, false);
>-drm_mode_probed_add(connector, mode);
>+if (adev->mode_info.num_crtc * common_modes[i].w <=
>16384) {
>+mode = drm_cvt_mode(dev, common_modes[i].w,
>common_modes[i].h, 60, false, false, false);
>+drm_mode_probed_add(connector, mode);
>+}
> }
>
> return 0;
>--
>2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
