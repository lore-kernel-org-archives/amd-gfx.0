Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE195C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 01:44:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A2C523380
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 01:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2C523380
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D37656E5BD;
	Fri,  8 Jan 2021 01:44:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A5266E5BD
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 01:44:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GblzxZRYA8jlyM14uLBF0ZgVEJG7SHRi3507HLKydXGVFHerW8P65IpMoJyc0lANLMZmqluFe/kpfEgucJ10eacyhF9Oq1Z6vihRWRxtiY8jH/+ciwiED+n6Mmd1fNV/JGHB4ScniZIqoNtxMLSrALmKQvjysCv46YYP7tV2+TLAUNoqUdau2PNeW3QLAhSrDi5A3GWKLjQx5AsNAjNLkcG8B8TQ6lxGRGDj878bGj3Oq4ItZVDap9H5dWMRh54ulD1ppEAw7fEKG/0kD8ebIZENSEA4WkyXWM25+u8TuQBGqkEhDSyr6nQwmucXiqbkVpb2QGSKHOstQJElKAZ23w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7XshZZMfXjaIly+eNo0HKVmFEngirN+n6zBoaMXYco=;
 b=H8cZgCmfwAebhTjV0rTNcLObzkwMKpnA30DveE4PxxoEFlM63HByKB1JmTpPjz9iViqtTvmVuwjFigRD73aa/ZC8aa4WR/pLsen0etyvSWJyEcgn4hRCpZHch0jURHxuQbPaYIdx14gNK3hhi5Rk8cSOS61FacFANzJYLlW1pv6tOr8CRnzkdZCes8gEDMdfJJbzk9H8rhsMJVn2HOPRUFKJmoCVycX0+jzDgbWVFzECUY8SJ/Di5uZZJOs8ydLI/RLkXEBlm+PHub5W+ZSml0S/TXSOEn9xFDPSP4NFwQaAEWizde0dUk+YOEQlGIl54BFuYwaLHbWvQSdHUH3mAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7XshZZMfXjaIly+eNo0HKVmFEngirN+n6zBoaMXYco=;
 b=mEaf6msgnO00ZS6OAo76ayoTuA1Puo/UQe9W5Xnpn1rusrTs5uUqndfWmX+uzfYtRITCakgQ1DyQLFvXNinmgZAbS4Wc4CBKDdsCxQNyjD2vGuJEPtEYjnXG+AhW2iLQm4b0uG9rQo7NLva00qix9XvTVxB/4KWL/Fe5HPTQi9g=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB4853.namprd12.prod.outlook.com (2603:10b6:a03:1da::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 8 Jan
 2021 01:44:30 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145%5]) with mapi id 15.20.3742.006; Fri, 8 Jan 2021
 01:44:30 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Decrease compute timeout to 10 s for sriov
 multiple VF
Thread-Topic: [PATCH] drm/amdgpu: Decrease compute timeout to 10 s for sriov
 multiple VF
Thread-Index: AQHW5J/RTcuq/S8bY0arSpLWrFIfsaoc9k9w
Date: Fri, 8 Jan 2021 01:44:30 +0000
Message-ID: <BY5PR12MB411557242C60A9968C8D9D2F8FAE0@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210107024958.605344-1-Emily.Deng@amd.com>
In-Reply-To: <20210107024958.605344-1-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d449a776-8953-4592-81c6-8d9dce7d85ce;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-08T01:44:18Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6b8b9e93-07fd-4380-9015-08d8b376f0df
x-ms-traffictypediagnostic: BY5PR12MB4853:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB48532F2EC5EC966AEB406C538FAE0@BY5PR12MB4853.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:862;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HdotMbax8nwRmzFa5e+FIB3005kYsjCwBidBlcAfszL6s2ypgEIG806hsp5YYwalqBZLPHWD0QNZuZrZl26jA1Ldoj4XT1vKZdYF51xb7pQoCSe2OTZYFTvUeTRGrfGlqnhAZABnNOjlaS5AE4qRgHDl3yqhj292/1p8t2x/OwcqWQ5B85BAhuGrTzwdaQNQPbHgElOlLZLL+AHBqBj8cjr/JXwGQL+iYyC5D+NoRx/IXlBL6IY8LYFGcPi9KAL2yab91apBftqqL0ek+Vt4XXhAaLhf2LTKya3hExdX9safYQUllLqex36GSRu+LLSRyBh6kepQYRVGGuFs1QD14X6MCCP8Xwf4jxFvSDqr8cY2/ZnKG+NLRK0PtjaYlsj61MRepi00+SHPCqeKqB4QGNq2k6B3fIqkFJrxYA6HGYr+prNR6pVsF06v/MaVyDXVvRSmwNJKko8U4OpPVXtaGA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(86362001)(186003)(66446008)(110136005)(26005)(8676002)(316002)(478600001)(33656002)(9686003)(2906002)(5660300002)(45080400002)(64756008)(76116006)(66946007)(8936002)(71200400001)(66476007)(66556008)(7696005)(6506007)(55016002)(52536014)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Qj0/fzObSKTTyWsK4DXUstPUVimfjKozSxzMR/pasa3Vb0M8rvwY2QXUyTw/?=
 =?us-ascii?Q?FnxW+84I+RMizNYxO6YOmQSWBHtZbQ0QCcNPHLgCTAKUZBwyhCRPgtVB7fsg?=
 =?us-ascii?Q?wm3wFbtLlYMiqvkT/jseBa/7zSG7MHGXdvwVIBCMcVol/k5gaIq/pZjFrxVd?=
 =?us-ascii?Q?86ygSijMbRESQMsSbaXn3hR2fD/QjCWXtVBj6lWYrqxkjJnGGHOxLdXWiNPH?=
 =?us-ascii?Q?D+trDHIC6FlANH2tKf9yqB1uQGySiheA2+QhN1w8VpYcq7rJLSC26m8zqkDr?=
 =?us-ascii?Q?utglycPa1Uq48ZfQZElzQgyQtcXSWLu0uFCzI+R+gaIphhi+o+MOtBdcMeGy?=
 =?us-ascii?Q?eG6azMWBJtg5HNj/O2kalaizrSTjCnru4hD8QbW4pSE8SkmDq3a9KOgl6zeY?=
 =?us-ascii?Q?JWZj5KO7+hti0WgSYEfIXNHnq16tzMoSv2ZBOTtkfkf/YV7l4i2ZBLdDKYXy?=
 =?us-ascii?Q?9vi+Q/SnxE9xCe9mrkJiGXXuvh+PminljPVR0dO4x5mwgxXWk2KZ+K0D3y8j?=
 =?us-ascii?Q?r0rj3vCyhlDLu1gJQGeniimYhMIvxE1NXQoCDCqFtYkV9kUtbWtq0dbP3VOp?=
 =?us-ascii?Q?eH/ok/ZLVixAygLt9+YsW5o8YmWX25KSlNT9YPwYVcU++Z+I7PepQ9TY42iG?=
 =?us-ascii?Q?Hf5NkAFIInVEsfWyGQkWan6wgLbnPHhhIYmtHyk65Y/09zCO3mNHtgw0Zful?=
 =?us-ascii?Q?xJX2rIwTGNPc53J1MiNCbB/PhojzmMnH1OOLdlfipyUIPbTVXb4/1siW3a3v?=
 =?us-ascii?Q?W/+RJkEpttvx8Pk6vFQPgZCD2CizdUBkb1RjQkbwjEF0yxtHc2plGFl3hHGm?=
 =?us-ascii?Q?5h1RyZjxlcmL91gyNsSTtZuocXbve/sGt8htiAaD65uis1Pnlm6wA58swZj7?=
 =?us-ascii?Q?FWpUBe2u6VPlTn04bfb0xWlkZnGVs33AMdigZsjIh9Qq6LPjJ4qu1ul1f70/?=
 =?us-ascii?Q?2s5LgVY1uWOGAzO3aromvF7/Dkr6OqiVgd/U0vBxfQtpLl3NQJa4dsrONHsp?=
 =?us-ascii?Q?PrZR?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8b9e93-07fd-4380-9015-08d8b376f0df
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 01:44:30.0685 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m8dWCss/ARBsmmTFyLdVYgYCpiXvqDg8LNTiLIEEweqQyI1ouquKV7vG88S2FikE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4853
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
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily
>Deng
>Sent: Thursday, January 7, 2021 10:50 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH] drm/amdgpu: Decrease compute timeout to 10 s for sriov
>multiple VF
>
>From: "Emily.Deng" <Emily.Deng@amd.com>
>
>For multiple VF, after engine hang,as host driver will first encounter FLR, so
>has no meanning to set compute to 60s.
>
>Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index 5527c549db82..ce07b9b975ff 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -3133,7 +3133,10 @@ static int
>amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
>  */
> adev->gfx_timeout = msecs_to_jiffies(10000);
> adev->sdma_timeout = adev->video_timeout = adev->gfx_timeout;
>-if (amdgpu_sriov_vf(adev) || amdgpu_passthrough(adev))
>+if (amdgpu_sriov_vf(adev))
>+adev->compute_timeout =
>amdgpu_sriov_is_pp_one_vf(adev) ?
>+msecs_to_jiffies(60000) :
>msecs_to_jiffies(10000)
>+else if (amdgpu_passthrough(adev))
> adev->compute_timeout =  msecs_to_jiffies(60000);
> else
> adev->compute_timeout = MAX_SCHEDULE_TIMEOUT;
>--
>2.25.1
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
>reedesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=04%7C01%7CEmily.Deng%40amd.com%7C29287057e1d84e2
>e912708d8b2b6f196%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7
>C637455846125410803%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
>MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sda
>ta=YsS0ylgUl2p2vXWbYftPBoFn59xdKKOpBdTVoxbOE2Y%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
