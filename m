Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9052C433E3
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 09:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A4792145D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 09:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1EM7+hWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A4792145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28DE26E2C0;
	Tue, 14 Jul 2020 09:12:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A66A96E2C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 09:12:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NibQEYzg6eVYycgn05b7QlkyD6OZdThM32o1N891K4WECeMhFtVCKIXxe/BnyJ5BuHmXWzdBUUAzDCUf6COCE2VftvjzT/s8uOjgaGNz29QtO4fZj0nX50LKTfGbpyOq5wRo0fIEdr46myQl1EUWhR5XFeGt7wBNvVO67uzf08rHMe7hhnpYj9V3XBkpd8q3xcm/TIe/unLB5L1PlJqiCHj6zCguACQ4PHuXvb7W/FNmhPD7fANTg/WsFTuhmiaHFssElDCiny8YWk+Q1G0rdkMzNH1UwlEI5mnb9dHvF6fmmwCtcRc6WjebXAlbYWX4MQcxKUYSQjtx2y9zS0ohkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqFcqrRMWLWumI5dN3ISw+iZt4P6zVfQJpV8DdX32/I=;
 b=d+q8ncE9sC3iAGnh+K4Aexhq17mKgu5bFiqmGJngU0UdwRNiT88hfgg9+EhjadzbLIBK/C4hxGbCYGEiGrUqJVzf6CnSQwzXm4d0XuyPCpkhWkzxQAyU+KxvdBX0Pjq0Dfp0DhGBPeXbFGI1m3/JxZynSFCGuRYf6FHl7gDd+ruZbEo0scGLjALVaolBaOwaIbu91TKmDGmXX56+NU0wwr31Ep55Yu3nMHNkgTEfgvcU2m21ZLme/WuucYmQM15NYIY29Kxi5m9rMZWszhyOgjICwM7L3Wau4lB1OBFA6RRp2Yu7zr2XEQBiX+vDMnCb0kkwE89eGvGmRQU46ROgYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqFcqrRMWLWumI5dN3ISw+iZt4P6zVfQJpV8DdX32/I=;
 b=1EM7+hWujml7yilOJQ6yClJZvJeru/FbKhkoGX42uwcFTfwLmcgWt4WySv4323LJyqz4/+S4RQhAaiOfQdx+S77/D1pVohK0tnj0PT+yWszmXFab4+kSw6Yee5NEKvlXr0w0yLtyiWcPwl/hF0J/ZshkTtbSPeQvgdfmtKGdTqQ=
Received: from MW2PR12MB2586.namprd12.prod.outlook.com (2603:10b6:907:11::21)
 by MWHPR12MB1661.namprd12.prod.outlook.com (2603:10b6:301:3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.25; Tue, 14 Jul
 2020 09:12:03 +0000
Received: from MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::693d:7e71:3a0d:b6d4]) by MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::693d:7e71:3a0d:b6d4%7]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 09:12:03 +0000
From: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu/sdma5: fix wptr overwritten in ->get_wptr()
Thread-Topic: [PATCH] drm/amdgpu/sdma5: fix wptr overwritten in ->get_wptr()
Thread-Index: AQHWWbYd3i0/4OkELEqXiByyl/MSAKkGw0AAgAAGn2c=
Date: Tue, 14 Jul 2020 09:12:02 +0000
Message-ID: <MW2PR12MB2586663B058478061AE3F92A89610@MW2PR12MB2586.namprd12.prod.outlook.com>
References: <20200714080924.3722-1-xiaojie.yuan@amd.com>,
 <7d2c7482-6182-613b-42db-4076e468a3d4@gmail.com>
In-Reply-To: <7d2c7482-6182-613b-42db-4076e468a3d4@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-14T09:12:02.387Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac0a4036-87aa-4e77-a330-08d827d5f8ff
x-ms-traffictypediagnostic: MWHPR12MB1661:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB16613BD17A37D2F7C54CB50689610@MWHPR12MB1661.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zc80YV5ufVOew5b84Hk3kuQa/kTfNtGUTn9deBVbRiSgFKW33MkfwhZf0NkKA7/ZFbH5AYKjaBncF7hWg/sx0sEJWwVu8qF31fPanieyftuqS/8qEVuRW4vDih7mpaHQTdCcCBZKqxT/FtsZNSLD96gZ+1e2Noz5RNc+e2noV6O33DZ2BEKfYSygSU5TE92pJ3jUBXAS1rXBm2Pi5XsE3M4i8nOwZYf5ko3DpXsaI+F20SCEtqwDmja9AoYH0SMppiWfah7FDIKLAUYeBUfRqLIOeycvJKHfFssJ8O81PaqWrUPICsUIF/lE/yGosqXDvANWDAz9IrnqS6uf0PGebB+lTHojRXjQ6VNcGGnzSL+BOOtiB3RuMyk3jJQm3mIb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2586.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(6506007)(86362001)(53546011)(110136005)(26005)(4326008)(71200400001)(83380400001)(186003)(316002)(2906002)(7696005)(8936002)(52536014)(478600001)(8676002)(6636002)(9686003)(91956017)(66556008)(66946007)(64756008)(66446008)(55016002)(5660300002)(66476007)(33656002)(76116006)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: demwWedyCsjwWPnjthshtHAwRn3LFqKsjYOBJc4HoYIiiHDtNijWL3T7X9sXdRtvWEIIMDZmR1n6f+0l+PK9ZfnvBHtdYh0FjDVNB0wMd8ZpEYByp3jZtyVOZ3bqiCp5Xzzy4nVNyPYxJAXTQhXSO1vVhvJ6b9+yoKlp/hGLG5KjGNykSmqtdZ1In5R4zjItChRnCmk94CBtGGwepWJSaz4Mq2+TH9FqDyH4R9SHaOEwv5JQ4ncQ4DkxW8EZFv/y3BwyRzGCYYj4aByDDZCi+lQyqSbTSf/y10nJq13edY3OFY5SeKGROLkCptyyErIyANKeyPo9uO5SFGSj3xr1cg1SsRA75eFEvd5q0iMhPynHqUiDjUuQdH0E35j7bE6xnYvXGBYiaVN7y2ON+T1x+UgLzuUvrjW2KuKIVikD3cixXtSZM6ZbOS73DvA9VEcc7JrFU5+r96doCr9eNuD31U7JKvvy8MWTkfdyAq0Qmzc=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2586.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0a4036-87aa-4e77-a330-08d827d5f8ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 09:12:02.9976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F2vJMF02kpqlfPuB/+6xFoMoq4zJv8Ft4ZGw2cefwjkeVZaVWjZgWFGHiw+tCRrp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1661
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
Cc: "Ma, Le" <Le.Ma@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

The logic in sdma2.4, sdma3 and sdma4 look fine.
I sent v2 to add fix for sdma5.2 as well.

BR,
Xiaojie

________________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Tuesday, July 14, 2020 4:47 PM
To: Yuan, Xiaojie; amd-gfx@lists.freedesktop.org
Cc: Ma, Le
Subject: Re: [PATCH] drm/amdgpu/sdma5: fix wptr overwritten in ->get_wptr()

Am 14.07.20 um 10:09 schrieb Xiaojie Yuan:
> "u64 *wptr" points to the the wptr value in write back buffer and
> "*wptr =3D (*wptr) >> 2;" results in the value being overwritten each time
> when ->get_wptr() is called.
>
> umr uses /sys/kernel/debug/dri/0/amdgpu_ring_sdma0 to get rptr/wptr and
> decode ring content and it is affected by this issue.
>
> fix and simplify the logic similar as sdma_v4_0_ring_get_wptr().
>
> Suggested-by: Le Ma <le.ma@amd.com>
> Signed-off-by: Xiaojie Yuan <xiaojie.yuan@amd.com>

Nice, catch. I'm wondering how this code ever came to be.

Patch is Reviewed-by: Christian K=F6nig <christian.koenig@amd.com>

Can you please double check that we don't have that nonsense in
sdma_v4_0 or even older as well?

Thanks,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 26 ++++++++------------------
>   1 file changed, 8 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_0.c
> index abb0ab653b10..e2232dd12d8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -315,30 +315,20 @@ static uint64_t sdma_v5_0_ring_get_rptr(struct amdg=
pu_ring *ring)
>   static uint64_t sdma_v5_0_ring_get_wptr(struct amdgpu_ring *ring)
>   {
>       struct amdgpu_device *adev =3D ring->adev;
> -     u64 *wptr =3D NULL;
> -     uint64_t local_wptr =3D 0;
> +     u64 wptr;
>
>       if (ring->use_doorbell) {
>               /* XXX check if swapping is necessary on BE */
> -             wptr =3D ((u64 *)&adev->wb.wb[ring->wptr_offs]);
> -             DRM_DEBUG("wptr/doorbell before shift =3D=3D 0x%016llx\n", =
*wptr);
> -             *wptr =3D (*wptr) >> 2;
> -             DRM_DEBUG("wptr/doorbell after shift =3D=3D 0x%016llx\n", *=
wptr);
> +             wptr =3D READ_ONCE(*((u64 *)&adev->wb.wb[ring->wptr_offs]));
> +             DRM_DEBUG("wptr/doorbell before shift =3D=3D 0x%016llx\n", =
wptr);
>       } else {
> -             u32 lowbit, highbit;
> -
> -             wptr =3D &local_wptr;
> -             lowbit =3D RREG32(sdma_v5_0_get_reg_offset(adev, ring->me, =
mmSDMA0_GFX_RB_WPTR)) >> 2;
> -             highbit =3D RREG32(sdma_v5_0_get_reg_offset(adev, ring->me,=
 mmSDMA0_GFX_RB_WPTR_HI)) >> 2;
> -
> -             DRM_DEBUG("wptr [%i]high=3D=3D 0x%08x low=3D=3D0x%08x\n",
> -                             ring->me, highbit, lowbit);
> -             *wptr =3D highbit;
> -             *wptr =3D (*wptr) << 32;
> -             *wptr |=3D lowbit;
> +             wptr =3D RREG32(sdma_v5_0_get_reg_offset(adev, ring->me, mm=
SDMA0_GFX_RB_WPTR_HI));
> +             wptr =3D wptr << 32;
> +             wptr |=3D RREG32(sdma_v5_0_get_reg_offset(adev, ring->me, m=
mSDMA0_GFX_RB_WPTR));
> +             DRM_DEBUG("wptr before shift [%i] wptr =3D=3D 0x%016llx\n",=
 ring->me, wptr);
>       }
>
> -     return *wptr;
> +     return wptr >> 2;
>   }
>
>   /**

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
