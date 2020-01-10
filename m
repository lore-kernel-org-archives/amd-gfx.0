Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854B0C32771
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 03:15:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5056720673
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 03:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tnrS5wPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5056720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07A0489CB3;
	Fri, 10 Jan 2020 03:15:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F88989CAD
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 03:15:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NR/Uq8flpVk/F6+XolZtIYUaLuKQEK5SgY7+DuyOcnCZgxp+xAE+N2VQeTckXTa3eTlX9Bx9u6iiLRf8UKfNaye1TrqoW9H/4tPQBZDgypHBMpz5g0xn+bdpqLHeVwwWwt7e+OZirdqaqYDTQXXtEjD4o9gpuKIKJpsReP1lIK4x+qPBnewUVj6v2U3GJ59mYk2rXDjDQivyZU7GtBBqN9UjEmjODJ+Wd4RErs3tX13+tpGMEwDDpbB4vtO/a1wByZVa99YEtKU0aSeY+1aYJwxESG/dqN7h5diwtxglZSGbyEHoQvZZGHjeiQG2XQ6ixu38rM3H0G2t7p/g64w9LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ic1jy+x5qJ/NSoX2ej/bYv7Qhm5SXCef/SBbb0B0uL0=;
 b=O4j7EwbvdmiY/M3F2jODDScUW+MIsECuEAuzfzdEL8fmAgLD7hvslNBXCh2Ac+kUKG4/9graywX72vE1NniOAZlckRgXW4Qv4FM4SmbRckUxi4JJPqxIBQA3FKazTVkR8NY9vQ8E7RIuKEOhRqrzwYCpKCmGTS9SqIm3BZ8ZygDvwUEhKM9N4UxtFeoVmPiizUoomrwzgcI5xqZTHmGXp8bxlS4ntst8JkQj0AIkkL4ue1WBX+ScRcAGNlS1OXd++zyk6V2bT/U9dz5m40rsoykon9Ujmty+olH/Z5ZSEVstSUpxAeQC+9aqPMcWqVQTV4i8/PTPILTSAMeB7bdYEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ic1jy+x5qJ/NSoX2ej/bYv7Qhm5SXCef/SBbb0B0uL0=;
 b=tnrS5wPi3Fow2NWxVt6eXDIFjB5cRY8DEUetL4smoi0TyvCoCoGUwVpu1wraqLqxZUkP8Zxq7sIandrEwLifRZ7eT/rFjiCt1xrhkOn2ptB+pgIepDSGXPqhQ5RInPfIcOMxD5O8iBX3L9lbwMSCixkxU1ltuyHoo+JMB50s+XQ=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3680.namprd12.prod.outlook.com (10.255.238.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 03:15:13 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2623.013; Fri, 10 Jan 2020
 03:15:13 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/psp: declare navi1x ta firmware
Thread-Topic: [PATCH] drm/amdgpu/psp: declare navi1x ta firmware
Thread-Index: AQHVx0TNhLw2PsfZCUWXXMkO9QSy7KfjOchQ
Date: Fri, 10 Jan 2020 03:15:13 +0000
Message-ID: <MN2PR12MB33443850DFFA86BC92052F64E4380@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200109233005.28657-1-alexander.deucher@amd.com>
In-Reply-To: <20200109233005.28657-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=feef3815-6882-4656-9d7f-0000cd0c2273;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-10T03:15:09Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ec4988f-06ea-47f6-1102-08d7957b4f45
x-ms-traffictypediagnostic: MN2PR12MB3680:|MN2PR12MB3680:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB36800059C5344C524F40C3BBE4380@MN2PR12MB3680.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 02788FF38E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(13464003)(189003)(199004)(5660300002)(478600001)(45080400002)(8676002)(53546011)(7696005)(4326008)(26005)(6506007)(186003)(33656002)(81156014)(110136005)(66946007)(966005)(2906002)(81166006)(52536014)(55016002)(66446008)(71200400001)(76116006)(86362001)(64756008)(9686003)(66556008)(66476007)(316002)(8936002)(32563001)(357404004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3680;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Y7R9k14fSUgUn12CF5lVOIL/coGNb6uw5xx/8mJbTuuPGmKk98pxr3vAI53PVuDklBAOhqP0eyZf5vDuC905HIzu9cYR2Rq/18Oknjpw72KhHXtTUxW7GjDaylgineYLYMW/iFgPyYOqmc6RAKbD3ccYns63rN82gfQ0nA+uGl3m6K3vEoQmCOqUvcluzHM4y9Dk6MB8EPC59yFDt9nVw6elYPqDU6BM6wzjAww6dPLLFgfK7ibhdRtxO2eJCydELieYY5qAKuI7hqLuytcSavhtMtjV1mDLYJs9mZd888n2UBvgyEsHvAz8F3jRp0G/WwwsHUbY9jVunWFmnrbbjxPmpwumppACoYfdw/TEmlmNXfQWB8ocDin0a5Ctd9Xjno86xN9kTdhSQutaairtJcudA2mj8B71NqMliN8dideyCIHLuJTYQ9509li0BTnWEENnnRfn+ftu5PtKrQle07zDmKSxh4nHYTy9KfXc4UQt+QI27b3DuhL3YfyD1ATn5nLkU86jrq8nA+pa+gyHUfYD2R/+jUkFpLwZTi/jmikEDrDgLuMfMGaia6OZZGWafA0rsA+0YTBlonceL818w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec4988f-06ea-47f6-1102-08d7957b4f45
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2020 03:15:13.8877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZuIMXOqQAdx0rK6ADZXWtSJGZ2z7e/fM1cf4MionQGZuk8NYii/K8srAbuKqZh4V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3680
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

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Friday, January 10, 2020 7:30 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/psp: declare navi1x ta firmware
> 
> So that it gets included in the initrd.  At the moment this is optional firmware
> that contains support for HDCP.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index a57f3d737677..685dd9754c67 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -43,10 +43,13 @@ MODULE_FIRMWARE("amdgpu/vega20_asd.bin");
>  MODULE_FIRMWARE("amdgpu/vega20_ta.bin");
>  MODULE_FIRMWARE("amdgpu/navi10_sos.bin");
>  MODULE_FIRMWARE("amdgpu/navi10_asd.bin");
> +MODULE_FIRMWARE("amdgpu/navi10_ta.bin");
>  MODULE_FIRMWARE("amdgpu/navi14_sos.bin");
>  MODULE_FIRMWARE("amdgpu/navi14_asd.bin");
> +MODULE_FIRMWARE("amdgpu/navi14_ta.bin");
>  MODULE_FIRMWARE("amdgpu/navi12_sos.bin");
>  MODULE_FIRMWARE("amdgpu/navi12_asd.bin");
> +MODULE_FIRMWARE("amdgpu/navi12_ta.bin");
>  MODULE_FIRMWARE("amdgpu/arcturus_sos.bin");
>  MODULE_FIRMWARE("amdgpu/arcturus_asd.bin");
>  MODULE_FIRMWARE("amdgpu/arcturus_ta.bin");
> --
> 2.24.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.free
> desktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C1a539defb7ee40f4983
> 608d7955be1e6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6371
> 42094391961865&amp;sdata=0ZW%2F7y%2Fq9xC8z3l3mCpFL0yeKa0ghG3kDo
> ZCZtlFi2U%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
