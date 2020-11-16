Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2F7C56202
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 02:46:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 048F4206E0
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 02:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EgffTZAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 048F4206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59E1889EA6;
	Mon, 16 Nov 2020 02:46:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7096189EA6
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 02:46:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIFAnzJdLtRhTp1+TXJ2KzPl4L4GraqOR1/bI/2PG3BHr+TnWqfPKptYLp17Nmvd4IBAmvbLC3fQWU4In2ByYVZ8VNg4rM1Zqiq4f8p7LYsj2VkAJD+f4cxMk3nF+1EK3DWHw1B8/g+0gqZ4L5VbCg6FkNN7Mrtmmwhf8kIxp3JdNUJKSXUA19X/FxtJevENJwVlHK+emIuNegBM/HgZBQ3LaHkDAvTZYNh/m/qB1ePz9f+ZW6AsnlHU6v84BKKYxwA9TdiaByfkx3vptugmW3ev62+sF5lkKPjeiGJaBmIR/w2MLE+bckaTNbWIzybX1DkqOcNBRADdLv7vSKgkyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVuJMROPu5tZDSyGTVkVqp8/NgL82FlMxRe3XctJsoU=;
 b=EhaGqpq4gU/yEibQQDX6+Bfq1eIrkNwzGLx1mX86ZTxBepaJzANI73hG+0ehIvaNfxEIbKORH/c1lyFj3Lw1Mt9PJyFTWpexxEWGwOben9Aei36IljtIjDz2A+e2F9NbK0DXfEcsLpDGwcikkiGnrnlYx+XWTpOHeQE/FBqAEDz36BrikltbtAacrUYa5NgnpwgSGpmmUotuYbqbsEZvAnFgu16UdHB3yswEkw1CttP89kL02/jM4PSrI9yuu5n59SD+T7PmwiiV1WUhx4Wb9IRsN8BZ1dr7v7ZsyhLdhhHh4g4RNfxk0HO+0GSKG9q2AGh2SbwkMTMeLQHaJCBgDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVuJMROPu5tZDSyGTVkVqp8/NgL82FlMxRe3XctJsoU=;
 b=EgffTZAiaAqeiaX5wzH9jRp6cMSoFEJCH80Tre61VYaY2RGNe77tedsr7aeLGHMQG85DlTAvb7rfE4uKRwOqHEhEZnwjOpxX4l4x/yI+5ICQGBHLybRBkLGadcZ9kdE99TK4eX6u8fqjylskbIEseBqEk9+shFCRXNFHZU11ffQ=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BY5PR12MB4935.namprd12.prod.outlook.com (2603:10b6:a03:1d9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 02:46:17 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::9866:32dc:79cb:d695]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::9866:32dc:79cb:d695%7]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 02:46:17 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/powerplay/smu10: drop unused variable
Thread-Topic: [PATCH 2/2] drm/amdgpu/powerplay/smu10: drop unused variable
Thread-Index: AQHWuf1Jfi4sbDJRuEGnHdPsPJUHt6nKEE3w
Date: Mon, 16 Nov 2020 02:46:17 +0000
Message-ID: <BYAPR12MB32388F132319230B04E181F4FBE30@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <20201113204037.978207-1-alexander.deucher@amd.com>
 <20201113204037.978207-2-alexander.deucher@amd.com>
In-Reply-To: <20201113204037.978207-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f206f057-b583-4a71-95ac-a353ff1e63dc;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-16T02:42:36Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 23cf17e2-eef8-4768-95f4-08d889d9cac2
x-ms-traffictypediagnostic: BY5PR12MB4935:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB493519FE814D73B8BE8C01B5FBE30@BY5PR12MB4935.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DKItCXoaaz3uA0UlEjGxnngQjyCfNeFbi8kNAHHLMbcKcf6vsdN8K5rSTljFlgW3MtNCsoGX2s5enrwE8LiK62wxiBtUdEECV1iY3EpEFqqjnXyzzovCL1m5wW/UV83Jd4lmp9QLIxC8gY+4yczuQvLf9cex1Ov62z9/9LbRj9ffvO8peuLX0b0h9evvmFm9TEisaRf7JrbnrqPDmOrMWG4B2AP1NwmePxvX3US4oD+0AD14RoqRQGmot0DDP2MTBBGQaWCfiWJOgOpMqIRojVrkqXRviXg7I5ZgzEqqpaiWKCYLDJK16D50P7cb0GofnWgBjB/hpdPEIr7StB9CU66yHt09jjPyjhQRBFjl4MibJJ+zwn544nq/FViYwoUyPiMQ6xUHWJUfx0k3YEotcA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(52536014)(5660300002)(71200400001)(86362001)(76116006)(66946007)(4326008)(26005)(64756008)(7696005)(6506007)(186003)(66446008)(33656002)(2906002)(53546011)(66476007)(66556008)(55016002)(9686003)(316002)(110136005)(966005)(8676002)(478600001)(83380400001)(45080400002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 7aHOF4AFl3T+6LVQZCDzF8W6SF99SLB1aBLIKayS/yBUrUIXlouaY1U3n3S5nPTQGo/sr1AZqaYFZdXnQbLZNXRrm/xo6I83j4CFCjQjn54HNaiNiwU9jAVYF5rBnaTmWXtPJAlEqUp9FcH/R/s0BNiClHHHXKJ3bZdWviuUExxuL+M8U6w/qga/llVJbnVlCjVVQHX6YLPnwIeJtqKpz+/iTLu8W7OabhX50J/ycOG+lA477hf0ajnRwCCh3fd0wEkCj+1TR5EA8ekV4FSKin8lQWqnVorrTHr6v7sC8+VSfRusmcLzhnLxJojUqC2oDZ06uUQ19H3G1qXkc9pD9ih2q/3hYHXm20c++zu8EjJuzHEZd2vCDv/CBcqNTxqXS9CEXCO9x2UFABlln1YA67aeZCE54MTrZMsHzh2Q61f460/AYDm4IzWJ4RwOSNsDERAU1xXbR9/6xQohy+Dl5ruzK3MGJb0oOp+L0xJ5YuARHow0JHbyt2dom07zaqf/Bnb+PLce+rlVXHDdEEsKFCadTuvFnFKeYOV9tRpg08t4pWwW3aW0Njan7XGWjT9EYbqNr3Yr9Hlpa2fwu8lARyspG+0DoQymIABVxz0o49ruynbgFRCGOIGVW0SgPSGOQbNFqf7BgXEzP0zda3MdC9YfTKOPW1u4zP6bsNGlcD75jD0Ine3fxGCHnFc22TLNwm9Dr3cNJp+gRT7KqPO22zDIj62JAto5rTukkqhifSujTa3t0zIMocg8p3TUShmggyYd1OoQOyx3WN6ks/V8jlk5uBK3ethy/qD8xIhPpCiuNvWfZI6czMbn5fBGPeSP66M4y952k6/DILitX9fvshTavX9mPZf5j3PRkTP1U+HdrFU+Xovps2m3DVCJhvN6oa1VQxrjnuJeT4tBbBbOAg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23cf17e2-eef8-4768-95f4-08d889d9cac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 02:46:17.5143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xz8j9V/exD8Yjf+47XF5AmKtQn89y3NnmdoMev6pryQELdm9zJ2RQgxQ+l3AFk9d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4935
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

Thanks help handle this and that should be also handled in my last patch series sent out.
Sorry for this rebase splash error and will take care on this.

Thanks,
Prike
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Saturday, November 14, 2020 4:41 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu/powerplay/smu10: drop unused variable
>
> Never used so drop it.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index 50308a5573e4..04226b1544e4 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1441,8 +1441,6 @@ static int smu10_set_fine_grain_clk_vol(struct
> pp_hwmgr *hwmgr,
>
>  static int smu10_gfx_state_change(struct pp_hwmgr *hwmgr, uint32_t state)
> {
> -struct amdgpu_device *adev = hwmgr->adev;
> -
>  smum_send_msg_to_smc_with_parameter(hwmgr,
> PPSMC_MSG_GpuChangeState, state, NULL);
>
>  return 0;
> --
> 2.25.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
> reedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7CPrike.Liang%40amd.com%7Caf1fc360bf2b415a6
> 6f708d888146937%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
> 37408968554801059%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat
> a=AXA1E00WPiiOvYqJLcFCZbhLndwFn8T%2BqximgzLo2%2FQ%3D&amp;reser
> ved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
