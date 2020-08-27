Return-Path: <SRS0=3ay0=CF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F9AC433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 06:58:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C99522B4E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 06:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="P61lCty4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C99522B4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F94B6EB31;
	Thu, 27 Aug 2020 06:57:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 388466EB31
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2020 06:57:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7Rz8393+9rJwTPhRmKpLMPeY1435G1vchw5A026qZ8/lS9OteUdDxQILkN5djhk9MjGlHeDPdVp6c22FlrEVMqelrjKft0isxFimsrXcVtBlOBaZ00vJV/qbn8TvmGFiVdL7CIYJtO/Am0jLP143ZtSA15A4DCKBGiACFfEM8ifexh/2bvsEmDgvhmDLcUoRozPAPiZ6uFPs6lUm3iNpHRLc0cweCMhdPDObugtVHhrgSDMF0agyCVXWye7T1XqBCKa191YyR6DnbAdnOMoOpSJKYfInJ8lWF4GG6rKxKp+x7WJiGEx6Z1PK5OQtqE1lffR77k7QDrVErspba9fAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWCx4DcM8k5tQmFhV9++mvzJUknfY36Xk7+k4txhqFY=;
 b=RsHcVvCl+oG+CuzXQbH7gC47Bk82QjtTEL7OPVTHI4NsUSoJWi3n3qp8yJqRl720301ZshMnVxYiT1JvsMh7J4/K/IsG8CtRClHsrv3Az5a/u+8F03h47Ww/S1slncNU0JxQEKa5TQ8VvwbFjzc4xgyuyaw83OAPnHSsap/QJTOZSFHWjno49ju02ZgyCzAOnk6JXqjiK+yauZuC49vzt90+/YCiQ3Cm1sLIWO8m0aJ7zTD+Vqks51myXpq+J6eY+FqnodI/HORgg0zrQJg+GC/+knGNGybh8ZziVHqOqgH8HibvKecUU9Sws2dMKV4O+0ZgGuRzKqzJkiJ1DJyMlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWCx4DcM8k5tQmFhV9++mvzJUknfY36Xk7+k4txhqFY=;
 b=P61lCty4P4eWxCCeh6a/9X0PeUewb9R2hnhKUFWR7EOv650JTD6QhU4lsYSD51QS674fyNvdtHxNkVq708N+gAz63RlXqNBYA0b0HEzzf13ZqXBF4lILc7YA674UxP8DYVeBRHZeLMmsY9d+cVKCSI0Ri973n3A5JA0XtHjB+h8=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB2789.namprd12.prod.outlook.com (2603:10b6:a03:72::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 27 Aug
 2020 06:57:53 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07%8]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 06:57:52 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: simplify hw status clear/set logic
Thread-Topic: [PATCH] drm/amdgpu: simplify hw status clear/set logic
Thread-Index: AQHWfBprKktFlLaQ/k24+YpC89uxHKlLhH6AgAAB5iA=
Date: Thu, 27 Aug 2020 06:57:52 +0000
Message-ID: <BY5PR12MB41151925B042FB3C3B3DD62C8F550@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20200827023219.6650-1-Jiawei.Gu@amd.com>
 <DM6PR12MB417014368B684A34A3C99520F8550@DM6PR12MB4170.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB417014368B684A34A3C99520F8550@DM6PR12MB4170.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-27T06:50:01Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=724a8b40-6d1b-41ba-be1a-00003b5b51ba;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ab6af0ce-fb69-401e-cb76-08d84a56849b
x-ms-traffictypediagnostic: BYAPR12MB2789:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2789E2F9EB79E4D66FDBEE918F550@BYAPR12MB2789.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:309;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zvzP0jObrjbRBQ4keFKBCt5Xhype0cTcYgTi1nb2gM8C4NbdKMohiGyGEO2ZMe9z+bMuLr+mFjI9Ce+e6mLri6OwxqaQelTskFcnUIO3vWtLN7AsG6m25udg5IFkpQFFRDc1v3kjppK+iIz8yWWKAaVdAb7Puno+lVHttHvD/RemGzhzs2i4+WGm1tYNdvIorBOhcK7EPWdJS4WhHWomesNc3wmnHWBTRMfm5mHlMy/k8NNzd0XbQ74L/AY9wDa96+Cxe4awVQnsdY7sNFr57/E4Rs3SXqvBgkow/0dSFzxx2GoqVoSrW0YeREZ1eCVGzi6UKkmvyCP7L4uYOVGvtyEvi9axpDv7hUcSeMoEHS0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(8936002)(76116006)(8676002)(7696005)(110136005)(9686003)(83380400001)(4326008)(86362001)(5660300002)(186003)(316002)(26005)(52536014)(45080400002)(55016002)(6506007)(66946007)(66446008)(64756008)(66556008)(66476007)(33656002)(71200400001)(2906002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: wjHB/68pgE5CilUCO78kcU13H6sRbM9xQI8mZw9RDEgPv2vCJN+/KHRtxCgFuypONFXTy25ctVQkQGnosllNMhpT5GmiiWlYm80GwgRPWLebzOl3oZ2upMV3b6mdpMoNlwao8EW7QvwYp6lPCS96ZEfQC0U9TqY+pj1FPgciYDSV2izY83iUhX/1BFVNi4xp7CxH5QcqH/A+y3/SNz9D0wBbrhyJzKHjOgEHY+jH/S11GDv592yFohdVucFKzkDmP8KMH2OlHI6NCmE2KS6XgUXionusE7MHkP+c4D+Hgxd8yEWsonO9cIv8dG/bV7g7zRYAyWUEes5H9OLwaFBZ0o3RCS8NXBPo1gUPMlrOipmRg7KpW2dUJQ2CwX0R5xYb741fXJXZ+B4eV/5jcBW7TvRe2uMk7ES8+ERHHyMyKynJORTvxTSDp4+w/sFKCjOPVlHnU71PSUdQFU+S9sGI8Vj+1uenIgOBp2GhtsjknIVNS+s0TnmgfcsnaKHGZAKGwILKMyczm3heuhDjdd4wKKeW7+OyMY8tSwbSrnJrhf6phyM7AdPb4g75GtIKnPnfntMa7IEC4y8QvA7I9Fmo1hpsmd4l3MmMteA5EI3kLfyBtu9B3Jmb4vIhLDusYpXkgr1yfI+HDxs5hF6nhQBZ3Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6af0ce-fb69-401e-cb76-08d84a56849b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2020 06:57:52.3498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Brko2NJzPWNewvWAZHR+BHej4sNkJppfYcm4u4Ea2dn7vclNgdO3om7f4QZmLAqK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2789
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
Cc: "Gu, JiaWei \(Will\)" <JiaWei.Gu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Emily.Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Gu,
>JiaWei (Will)
>Sent: Thursday, August 27, 2020 2:50 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
>Subject: RE: [PATCH] drm/amdgpu: simplify hw status clear/set logic
>
>[AMD Official Use Only - Internal Distribution Only]
>
>Ping...
>
>-----Original Message-----
>From: Jiawei <Jiawei.Gu@amd.com>
>Sent: Thursday, August 27, 2020 10:32 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
>Subject: [PATCH] drm/amdgpu: simplify hw status clear/set logic
>
>Optimize code to iterate less loops in
>amdgpu_device_ip_reinit_early_sriov()
>
>Signed-off-by: Jiawei <Jiawei.Gu@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 ++++++-------
> 1 file changed, 6 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index 8f37f9f99105..696a61cc3ac6 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -2598,17 +2598,16 @@ static int
>amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
> 		AMD_IP_BLOCK_TYPE_IH,
> 	};
>
>-	for (i = 0; i < adev->num_ip_blocks; i++)
>-		adev->ip_blocks[i].status.hw = false;
>-
>-	for (i = 0; i < ARRAY_SIZE(ip_order); i++) {
>+	for (i = 0; i < adev->num_ip_blocks; i++) {
> 		int j;
> 		struct amdgpu_ip_block *block;
>
>-		for (j = 0; j < adev->num_ip_blocks; j++) {
>-			block = &adev->ip_blocks[j];
>+		block = &adev->ip_blocks[i];
>+		block->status.hw = false;
>
>-			if (block->version->type != ip_order[i] ||
>+		for (j = 0; j < ARRAY_SIZE(ip_order); j++) {
>+
>+			if (block->version->type != ip_order[j] ||
> 				!block->status.valid)
> 				continue;
>
>--
>2.17.1
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.free
>desktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=02%7C01%7CEmily.Deng%40amd.com%7Cd49aeebc6337454ad
>be508d84a558474%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
>37341078483894286&amp;sdata=ORgvulljLZNfexMcXZCXi4JEmz3J357Oxa%2B
>GxYW3%2FSo%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
