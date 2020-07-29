Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4719C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 04:37:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D2E92070B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 04:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FQ+O/aWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2E92070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C49B66E435;
	Wed, 29 Jul 2020 04:37:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10EFB6E435
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 04:37:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ET7H0ur74DuC9ZyW9cuvekgC3IU3w3xgDWfCNBAzu0GMfly3F7WDCPHlpTHkEvTkErOpWTnDQ5wX3WsBf50qWxcazpZm7SFBnChTIvKD8XKJlEV20DvpqmOUJdGiwBvQnWxa1ty/EpCSU9kl5bUvjyZvydIfGQDT+UOoPVYEIdwPlEwYCEdfpiaJvGYTBVc537l4qzqRFBBj3W7Nabv7HAGj8RkQOnZdBVAch1OFa86hrtorlFoJLdlhB7Kkdo5d9lgZFyaTk6Svjt9ouw47z7Jy1+pwJMQzfjPvB6fXPoj1FKIr9Srp74MvQsHdiOogWjjsh0Z/1Gwl6oaGPg0wmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWOhpIUjxSRsMxMiGj/oFIh6N1DV70cn8ZQgh1z3syQ=;
 b=TFVwQdfNU+O3/L5nrH/9L/ln6RJ4vojU5a9Z00IHrI6rgVv2LYO2tkYaSJDchHVIHs4HzXSwZ0zJYZ1bTOcig1Y0y76Avxzkkats1uOX7tfZ7GyAFnNphC2quQUqJ5EagkBG7E9N1jGUhvFa+kXrftddc5heX7vEFPuxQzhxscunCa+6TptS/zXd0vTKFA9oiTO+L5ctIU2syIcGyT7s6C/udOh8PUlYEqj3mw+Z/kscb5zHxIK1i0bbKb/5yxZzqGr+RxBNBzuThY82jJHGXeF9vohZy28tCro2qLs4x5AifSom6vFAE3ZztqI5ZWtUbj45aOSlRaHh04phQWLyUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWOhpIUjxSRsMxMiGj/oFIh6N1DV70cn8ZQgh1z3syQ=;
 b=FQ+O/aWUnNirBFzhy+ehMBnGia6b8M/az9MFwwbLRw2MWb0r524GbGojDvZsg91LqAK0Cxv3VGocAM2etDCFsydX7gf5zd03Xk8kVyCViF6/wueZtLNP3KUTXiVIX1Ev2Hq44VQtftWz85acdnSFKGm4MktFdwjRZW274EPn+GQ=
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BYAPR12MB2614.namprd12.prod.outlook.com (2603:10b6:a03:6b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Wed, 29 Jul
 2020 04:36:57 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::f8df:794c:7431:2440]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::f8df:794c:7431:2440%7]) with mapi id 15.20.3216.034; Wed, 29 Jul 2020
 04:36:57 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: update GC golden setting for navy_flounder
Thread-Topic: [PATCH] drm/amdgpu: update GC golden setting for navy_flounder
Thread-Index: AQHWZV0ZNT9AIrDHNUeRj/TRCPKMrqkd+NiA
Date: Wed, 29 Jul 2020 04:36:57 +0000
Message-ID: <BYAPR12MB28882FD19DF5EA8CCE7CC388B0700@BYAPR12MB2888.namprd12.prod.outlook.com>
References: <20200729040224.4832-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200729040224.4832-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a6a5986b-9f3a-423d-9c6e-00005286005a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-29T04:36:12Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db52845a-ba98-4a21-c790-08d833790700
x-ms-traffictypediagnostic: BYAPR12MB2614:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB261437DC028C4CA605D62480B0700@BYAPR12MB2614.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TCieraMlgD5GK0Ucilbr2n572c1ucvMKxROCdNWLH2fhvRrlgayd/iDVral4AEB9AxVhcGb4MNV8kZ68Wi0uRj24oaj4/+HNxqj0VrfLaJr5QKvbB3jDxSpSl/fI/Y+yyeDGFaSKlHDzmFarCUOweQt9ScyTSRVWQ0CAQ83ST/FMbZjky082HcYI/DSqItgdU3kjOtf2fSQVPZ78VGhWk/FPelAXuLWcmqjfJh2DlxtFCzaJea91qTuS0yMnmghnGj2cSTkh8hBWsysjlM1y0BpEH1KC3Ve0H5SVmbL7g8Lr5F2Pf+DfWvAbFsV6i1Ey
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(83380400001)(9686003)(8676002)(5660300002)(52536014)(4326008)(33656002)(86362001)(186003)(15650500001)(8936002)(26005)(2906002)(66946007)(478600001)(110136005)(55016002)(316002)(76116006)(71200400001)(7696005)(53546011)(66476007)(66446008)(64756008)(66556008)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: QXmf3/phf3ZIAlEcCG7oTxl8H7HbJ7IcToidfvV8JaMkiOKONWWycFBc8YGIopvigrPvYMQiS16R7tsDtLs3ci1KRVWDa5+fK8dRPdZ4WTGrUEcGZQYNo2vxRp2pu9iLoPLk9hpg+0qD0rgI/pm5RK4UMK2KuBmakhcAiLyqt3xxGB2fEgmMsGkGDpXYq4LRAA+934j0K8L0V3n/KnbuR/In9xzXvX7Fnphn49ZWqb2H5VoZb9WiZbXkZV/L7h78U9ane8uzhBDXpbNphPoURjWc2g2wCaGxXncLi4HM1VnJQw3/sN0IQ7+84rRyRFnfrvRLCGxDE7w4qbYDiym0AkbPgtZE4MGmnz7v3ihFBkLGa4bNqRK91GIsS7JI/v3Nq4C6T34k5+4/imA0dVC+es6cAeDDKds/2ESIEwi0VxeC4OXEbNGwIT9dKr3VRtbuOBce+AgFp+1G+haS109BMX7GCm1v74inFKf6SlY3ChMtDsApXI1GFNlI0F9RZ9cM
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db52845a-ba98-4a21-c790-08d833790700
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 04:36:57.2387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AR1OjaqFS0LrZ9EVIKKJBfjwXwRdLHCLZ+Fufwg9FTrldUsi/wQwZBPmT7zBRJMj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2614
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
Cc: "Chen, Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Jiansong Chen <Jiansong.Chen@amd.com>
> Sent: Wednesday, July 29, 2020 12:02 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chen, Jiansong (Simon)
> <Jiansong.Chen@amd.com>
> Subject: [PATCH] drm/amdgpu: update GC golden setting for navy_flounder
>
> Update GC golden setting for navy_flounder.
>
> Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
> Change-Id: Ia7e82616b0be48f397c73b015823ac10ef907f08
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index db9f1e89a0f8..ca16f01956d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3127,7 +3127,7 @@ static const struct soc15_reg_golden
> golden_settings_gc_10_3_2[] =
>  SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA0_CLK_CTRL,
> 0xff7f0fff, 0x30000100),
>  SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA1_CLK_CTRL,
> 0xff7f0fff, 0x7e000100),
>  SOC15_REG_GOLDEN_VALUE(GC, 0, mmCPF_GCR_CNTL, 0x0007ffff,
> 0x0000c000),
> -SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff,
> 0x00000200),
> +SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff,
> 0x00000280),
>  SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff,
> 0x00800000),
>  SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_EXCEPTION_CONTROL,
> 0x7fff0f1f, 0x00b80000),
>  SOC15_REG_GOLDEN_VALUE(GC, 0,
> mmGCR_GENERAL_CNTL_Sienna_Cichlid, 0x1ff1ffff, 0x00000500), @@ -3158,7
> +3158,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_2[]
> =
>  SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER7_SELECT,
> 0xf0f001ff, 0x00000000),
>  SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER8_SELECT,
> 0xf0f001ff, 0x00000000),
>  SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER9_SELECT,
> 0xf0f001ff, 0x00000000),
> -SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xffffffff,
> 0x010b0000),
> +SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff,
> 0x01030000),
>  SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffbfffff,
> 0x00a00000),
>  SOC15_REG_GOLDEN_VALUE(GC, 0, mmVGT_GS_MAX_WAVE_ID,
> 0x00000fff, 0x000003ff)  };
> --
> 2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
