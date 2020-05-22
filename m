Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D41C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 05:45:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17DF12072C
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 05:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3qfa7hKc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DF12072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9D4E6E046;
	Fri, 22 May 2020 05:45:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A770D6E046
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 05:45:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvhO8bZoyhf8PBxbCQnbM/1DAUGLSHr+hhlTyhNSHpZbmUabvj8EwUg9v2XwP+sJEn7zYcCV+XKwghG0H6slCv7jdQwKhKN4/SBqKo1mzrkCYZsSafUZEHhD3b05vxXc+DYX7k5UvnhL743o89BAidU9F4aLOKmUIZHeiJSo+Lw8JGtB72LR44RPu7GcQPTP5a1hByqLAYWiI+y4D/0KXuCDF4gH97iA9Hf8dAkr/+Ec7jhOvUVhrvyir3nPAtUIJYBYxzMC4HGE7KYc4+WgtUyMrfxlN+rv5U4YPRlYLtc/sZhY7BX4siZEssnjgBHPPcrkW8VaYgeKjgYaicdXlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syeZ7R6guOHA3Y1WOSkyFSSDgqceIaKH3MIEhDaESiA=;
 b=lcxyHwuvIQtwh7RHaIJdZrXwXkDC52r7MgFVk/diVCTonPJlwlKwjmBLC2tCFVKdasLRRUDPgT38MY1dswkldCtrsJyhhmbHtX0GpS8VceQrzdz8+WyYg3fb7Hr3Y8ZCX63SFWHQ2dfp0rHhRg7p+Ub4vU1s0VFiGp5+u2NIIu4VBnPJqh3ogibTB7953vm3sOCjBmmauhHWps7ghhM1U4yk2eITuwu97uGcpsD7HFGP7e/4x841QWHbNZiRmoDHHSat6ZoJvEYZBoLqjgsLgErzHt1VqjXLZ9L/uBcKVwDlgdrE2h1B95HCxiZ2Yz/pWHpOQZpGSpSHl0QAsJBJAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syeZ7R6guOHA3Y1WOSkyFSSDgqceIaKH3MIEhDaESiA=;
 b=3qfa7hKcOsA1KGlHDjegsBg/uozhgKuXGRdABQJV5oR09d8QfRBNnorXKvWZh3v6WH8ghi44tZVGpaf9OhrNBTOCwK1dHJ/ByfKMfhHwdU/UinaH9cZ/6FnehMVXtbf51WxMX9iH7CD7Uh71hyk5ENz5kISsu5iQxR4UZ5IYwsM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3340.namprd12.prod.outlook.com (2603:10b6:5:3d::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.24; Fri, 22 May 2020 05:45:51 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3000.022; Fri, 22 May 2020
 05:45:51 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/7] drm/amdgpu/sdma4: add renoir to powergating setup
Thread-Topic: [PATCH 1/7] drm/amdgpu/sdma4: add renoir to powergating setup
Thread-Index: AQHWLfRuwai0GU7ZDEeUIfbDb3CSYqiymPeAgAEDfYA=
Date: Fri, 22 May 2020 05:45:50 +0000
Message-ID: <DM6PR12MB261962BC5DB4B4176EE29A70E4B40@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200519154426.1752937-1-alexander.deucher@amd.com>
 <CADnq5_Pig-WxhqAb9tFWWRKj9Jo2_Ye-hj04XB6Udu7W=v-+PA@mail.gmail.com>
In-Reply-To: <CADnq5_Pig-WxhqAb9tFWWRKj9Jo2_Ye-hj04XB6Udu7W=v-+PA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d388c846-d715-4fad-aad3-00003ee563bd;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-22T05:45:22Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b5a6d164-329c-4a98-69a4-08d7fe1362b4
x-ms-traffictypediagnostic: DM6PR12MB3340:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB334047D1B72D8985327FD7E4E4B40@DM6PR12MB3340.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:403;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Iz861Y2Znqq/FrA/kst8eLsteS2q4S8LCa7HQuhdAeJiKEs69UvO7ptuBuGH9FM8dcrr4dBRRc6on15jvos7Sr6FrV6XqfrlMvanVFOXN+xZ3MJjqhwspoui/RkzNuvWFRF5XOx67PyY/JXIOGpSNN/jsmcvIsFMql25ZCi+4xmXqZKBKnvw7oW0wfT+t1doAhBk09EH42gacFwUxTnullKa5HL9tLtk3uunsPQLgNXT3bRhkMbvaVgFwQBPDy1qRa+vjCPbaCi8HmoY2Cdo5yYfMBGuVUygcKPazTrbIalAGvz752P3VA6inzAld5Jhvu6db67fNCRtoE44JsUyocarASHi2RSBKC/BelYhVEE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(52536014)(66446008)(8936002)(86362001)(66476007)(66946007)(76116006)(66556008)(33656002)(4326008)(9686003)(64756008)(55016002)(53546011)(6506007)(71200400001)(8676002)(45080400002)(110136005)(966005)(316002)(26005)(186003)(478600001)(2906002)(5660300002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: aFHWmcIGO89CEQTK9nA13vip2CfvbQfoR3dM4durV7TK+/ITt1/rdhlqNXDONjOGmuGQDbBWqPo2dV9jvJFc5/kF+lSdUJcfaLcJtvWSBPHiO9hrZsV5LVTeOpcn8l8KfMmYCtRioOAG1hmeLHcRLpjSFaBmvbQUZMLTQAwzXls9ve+fhttrwBz5aqwb2xrYZwi4XS2WLNS08X8XejT3ze2iOpSCDLNWsMdfYnHAA+C+eMpMqu3qB03CGj1zYOs0Ke21MMaAAsBOUKGpVMlmh9pctFoKi7Jj5+JJPUcmoCW8L/UDrw8p3AkLJMGma/0xg035vuTDa0RppHFr5APAefn9FNrkjeid7J4Wejc2VOtlYFbSdd3nIwkwccBZdu3JTp3i8T2jxajTFthPjfQ8tqNXit3iFWj3JHQgCQ6/gElV8Ra9HuycA8/WNjCN4yoYq03WD/fE7tJduSjONcghybP6ZBkP2m7QhaES1iFPalSRYftBElE486toCG5ft3YK
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a6d164-329c-4a98-69a4-08d7fe1362b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 05:45:50.8269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D6h3fl3M1mCRy4GPJYgSQjRD59SnV78tP7SmGgiSq1jETZ0YLlrtHcfXzljpcJ0t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3340
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

Series is reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, May 21, 2020 10:17 PM
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 1/7] drm/amdgpu/sdma4: add renoir to powergating setup

Ping on this series?

Alex

On Tue, May 19, 2020 at 11:44 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Looks like renoir should be handled here as well.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>
> Can someone test this on renoir?
>
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 9077507b425a..a8cad03b1c42 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2203,6 +2203,7 @@ static int sdma_v4_0_set_powergating_state(void *handle,
>
>         switch (adev->asic_type) {
>         case CHIP_RAVEN:
> +       case CHIP_RENOIR:
>                 sdma_v4_1_update_power_gating(adev,
>                                 state == AMD_PG_STATE_GATE ? true : false);
>                 break;
> --
> 2.25.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C318853dc869c41a81b8f08d7fd919b67%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637256674158399008&amp;sdata=8wJnYwuJbMYQTMCMRUzUE0W2XeSQ239x44Hh5bRXXOE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
