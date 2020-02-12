Return-Path: <SRS0=l6GN=4A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14936C2BA83
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 07:26:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D646E2082F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 07:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lreFMkWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D646E2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 728266E8DE;
	Wed, 12 Feb 2020 07:26:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60CAD6E8DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 07:26:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joWEqVE7avGmisSngef4cCom4jygFtqnyRrQsIl1uY4uykjFkibfpZzr9QMLMjyxx0QVC4HQBQPSCbs49Ji/fLzIoflC8cnD5ij8AeGJN4FSb21E81heglBmq/0ENlECLER+x6YrQQ1ljzGn/7YrdDTyXvOwGsdD6+GsH4zRpQOd48yT8Tz5KitvKBJYBupgNZlj/P/n52BH9dY/90KdxsNXl1Bj7BS9M3ayfgI9g9NkEA1WsgXxzYXKGU9wx/30qWM4BlqZiPcAWY6BaNXoaOxQNKLk+JNJfFfXSZVLacWlCfz9izKKaxFSX928IBFpsI0xzaxYJczbvc3gbgsuwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4kNSuhOelx3XeRPUrdZkzZ3IMA0SXS1VegjOCNUe44=;
 b=ibFeYAR/jWk/vS0n6JAPqdaCKNpJFZk+DV4iapTirsRbx4GnT7Bur2Afdz++b7+wfGNQtuY56SB8KhctLKvyXTHS52q0YAiM9tfGDgfYljXoVU4hveKS6HtSC9cra79aLsT4FH9wz9maJeTsSE8lIXfXuNplYDWlLwArfqjq9Ea0eGWzplm5Uh+iR7M7GZnYzE3DhkhSnevPSx3XHojsQufg6IIXNOyILBgED+I/ZmbaJO3cZVsYyKUORvnx+ACPMUYggjDplatZJRe7de0cORsywnDVkSgvxe5FcPfaSlHvosEMX9z5KblQS8vJfCt8xLOqm7LedF28i1SH3UoSpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4kNSuhOelx3XeRPUrdZkzZ3IMA0SXS1VegjOCNUe44=;
 b=lreFMkWZAvjuf57Q/7OjxVQQsVQeLWZqnRXX1MCO1bMBUwrGUAOgqrqNHR11w4AJU30LuvMY8an+xBN4S9T47FKOi6naJajN+Y+Bkyt4HHIJUKiZlQOlwPfFeJ01jratKOKeAZvucdJ6KElae0AapuvI4iqyPSdZxlp68p4RfMc=
Received: from BN8PR12MB3329.namprd12.prod.outlook.com (20.178.208.93) by
 BN8PR12MB3588.namprd12.prod.outlook.com (20.178.210.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.25; Wed, 12 Feb 2020 07:26:46 +0000
Received: from BN8PR12MB3329.namprd12.prod.outlook.com
 ([fe80::1cbf:1b1e:ad9c:c83b]) by BN8PR12MB3329.namprd12.prod.outlook.com
 ([fe80::1cbf:1b1e:ad9c:c83b%4]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 07:26:46 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/soc15: fix xclk for raven
Thread-Topic: [PATCH] drm/amdgpu/soc15: fix xclk for raven
Thread-Index: AQHV4XDV9c6ky2WDeU2xKkkZPZVp76gXKH/w
Date: Wed, 12 Feb 2020 07:26:46 +0000
Message-ID: <BN8PR12MB3329E5A56A34734D7AF5451DE41B0@BN8PR12MB3329.namprd12.prod.outlook.com>
References: <20200212065054.1144314-1-alexander.deucher@amd.com>
In-Reply-To: <20200212065054.1144314-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d9570165-294b-4a59-252e-08d7af8ceae8
x-ms-traffictypediagnostic: BN8PR12MB3588:|BN8PR12MB3588:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB3588D0EC3AD1C761CA297A5BE41B0@BN8PR12MB3588.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(189003)(199004)(478600001)(76116006)(71200400001)(66446008)(66946007)(66476007)(26005)(66556008)(64756008)(4326008)(316002)(2906002)(966005)(186003)(9686003)(8676002)(86362001)(33656002)(52536014)(45080400002)(55016002)(7696005)(81166006)(110136005)(8936002)(81156014)(5660300002)(6506007)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3588;
 H:BN8PR12MB3329.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OZdCpaHBPOfQs1tPdmx8vzO4TMQCXuLDEVpgFXrC6VHblRRTdfI/pNSaHtz7glMfFgTE+4Xe11kkQKvDBZqKvgKtjwmhY7Bh8gcX6gTu+1i9U1sB1Q2jwNgyZEvMopWRzns6UwSegAsvomKScgWKaKBL7SHhQ7maDB6+kDRzy5xSbISOl5MoMiboP3mdDKPKOrFzEtjqzMWmxmXeNwDkbWAXItg92I8JPqQpyetShIIuFCSt/IRiFlYa0swW1MIaZ9emebntaiSskFAT3pADAMj3twBMjiPfl5kwP/pYnbD7EMMDOJRlA9xJizbhCWAv7ygk5ZMdYH5AHB0+FwIxKTlCoEzjyx56X4xBp1Zw0577YQjv/vUhHmgYQo2GQloWUVWlBZXl+9oNSvO0CN77VN7xpShu4T24AQ+5o6Z+9O24/G3PjJF/RpxWaWyJB/TIpgZK+Iv1FKSEcCINAMxeOyYhsGsind2dTYSo7L0XNPC18TKRASxvUzJTQEmK9nfoj5NMXklsWtwQUMs0Olp6UafXtJSNuX8esDISWc7x+ZnspSXo6FfIbzzpcsd+TK5mntPOcsosYA3vfHoqx2A1ItuGNfCRElGywh6/7BvK65lzdB3HImQWaEPrcBhSvbLw
x-ms-exchange-antispam-messagedata: kjRXy4BOBodj0i9yPs8Kcpl4q1bjA8imiOw9rB5dBEn0Nt2HKVQQ99HhzzZ0HDRT0ZYcoMrjnBNvTsMxlzOXWyWtm/gtkPZo3CJW/2CXkcZiQ5+7iQw5/mWLwJslvyg3p0Oq8/8CunsgF7Wj0qltJA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9570165-294b-4a59-252e-08d7af8ceae8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 07:26:46.6469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R62iybuWCJltIQwnkt53yjyIVnhu1pw5R2Sc2vt+czToVc3v/AeV361ufCnP5z/4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3588
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

Acked-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Wednesday, February 12, 2020 2:51 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/soc15: fix xclk for raven
> 
> It's 25 Mhz (refclk / 4).  This fixes the interpretation
> of the rlc clock counter.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 15f3424a1ff7..2b488dfb2f21 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -272,7 +272,12 @@ static u32 soc15_get_config_memsize(struct
> amdgpu_device *adev)
> 
>  static u32 soc15_get_xclk(struct amdgpu_device *adev)
>  {
> -	return adev->clock.spll.reference_freq;
> +	u32 reference_clock = adev->clock.spll.reference_freq;
> +
> +	if (adev->asic_type == CHIP_RAVEN)
> +		return reference_clock / 4;
> +
> +	return reference_clock;
>  }
> 
> 
> --
> 2.24.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cc6edc950af7441901
> e4308d7af87f4a9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
> 7170870805268030&amp;sdata=CCDroHD1H5m8ak0zsCg4KXi3Sf6f8yVY31xdM
> 0wcyzw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
