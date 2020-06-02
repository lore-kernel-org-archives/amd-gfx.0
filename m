Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04E6C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 06:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B165D20734
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 06:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NmTQjCIw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B165D20734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64CAB6E149;
	Tue,  2 Jun 2020 06:18:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 478AF6E149
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 06:18:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8AumBmoZ0UUCmWtlm86C8+9caiQoTWzMQa9tV9weXZn7o4hNlZXkmxL8vHEV8xmDUF6fsyDOkx/SNHSUhvCwrYoEJcb+dK0chbn9WfkXzPnqClM5Y+72qMkvam1/0UQoM5WOMlIyj3K7QQZhvJhKmHpBv0+Qmwbmb+G5czETlUASXeIA7hvl94X33DBfJLQBqcvw/x0NzwoAvFxQfjzV1G0TpU39RBPFf2mPAF1q5ThgiAhA5iICl5/h135LwNvII2xALuaYyVke8mw3ptyF61KZ9uQbbSGhgjqqtml/0fRfttgmm0CQUdhRoCzdWxdJsFKlHifWAUY7TdQhWE+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzxuCV4DBuhEief6zQZJtT60Vi82hd6hEeqJJnXfsbM=;
 b=ekBBSdaiSAGxILOvdKMTD2j8wAhNLNYJjSvj1TyZNQRNoRAuTwwrPUtXn5l+JXw/JfVOLfKO6KQQqXMuWhRtxrY+jG4UYIXU71u8gOmK0HuVI/WgagoMfHZzahtlWjxnUk31Ny2MOgqVYzt7PqkFVnjbOq5DuRzSub5o2Z7myY4XlZYI2cV2YODVVPkx/4niF0NDhmp9AUtHbKhpwFY9vsiXZ2kuyduhW2v4NSl+233BeUOQpPKjuOP1ZlHXwlLEgRqfAZK43rSSAp9rzzeOIYnPWjiZaWDtelJLmtv7LKAWNGNcglrJaqT0+5GTGC+WRj1fOgzqR75h4RfKSHPgPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzxuCV4DBuhEief6zQZJtT60Vi82hd6hEeqJJnXfsbM=;
 b=NmTQjCIwEHIo4ITzzRj6RrYdJy2qPWq3gnPgyFi5QA6+RzWgqj5/NrSpxuar/Omf/4t6GyG0bAyS62dScyYMVIz0VYMk1k7Tuf90mNGZZ5xkn2C7dsK7UO6vZB79NmAFhWl8xDQ/1CjVbW/QIJmPHVIxGkb4ULX9iIw58FbP6CE=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1365.namprd12.prod.outlook.com (2603:10b6:903:43::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 06:18:24 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc%8]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 06:18:24 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove RAS's useless code
Thread-Topic: [PATCH] drm/amdgpu: remove RAS's useless code
Thread-Index: AQHWOKLXjDmkphIP80ChN633NxbdxajE2D2AgAAAexA=
Date: Tue, 2 Jun 2020 06:18:24 +0000
Message-ID: <CY4PR12MB128766A90EC0D20CBAF2141EF18B0@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200602055811.21651-1-guchun.chen@amd.com>
 <BYAPR12MB2888870B105218BF323FB9BCB08B0@BYAPR12MB2888.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB2888870B105218BF323FB9BCB08B0@BYAPR12MB2888.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-02T06:07:27Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=41208b3e-ff26-40db-aef8-00000c5ea4ce;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-06-02T06:18:21Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: baac870f-8b8c-4af6-840b-000013f8553d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ae7c6b48-484f-425d-16d5-08d806bcc184
x-ms-traffictypediagnostic: CY4PR12MB1365:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1365E5FD9C0964017D70D547F18B0@CY4PR12MB1365.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AW1SgtRJeb+LUcKxkgb1JvHuNpxKjyorVO6oOQu7m7bN6kvSbZhAcKR+6zrGBvNU4zy0bq1HBfZRwk1KZZuwPx0tKisBK7SWTGYIQZew6dO6izoJCp68E+PnI33s0OjrAq3xGlfJdGnUzO1+oIU/Zy9b6LpeGnCTd6WbFr6K/R07FkaxGjGKf/7607zTJkFZuwuWf5uzzI1fMJKZCr9tCi+qfZiKouqssvW+Hy5yDls0sCHPXNSsDzJuMwM/gJRr0/67npoT16nInw/mQtuVhp3k5nZPIEVvjijnwg26XHxnLeOTMqB3KixWc+iDxqTD7M0HKMzyXfbuDS9nvfODkA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(6636002)(2906002)(86362001)(71200400001)(316002)(9686003)(5660300002)(110136005)(55016002)(64756008)(66476007)(66446008)(66556008)(26005)(478600001)(186003)(7696005)(66946007)(76116006)(6506007)(53546011)(8936002)(83380400001)(33656002)(52536014)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ts0o/Dw04bxZdHw9FkDK/knC5sTWJ3I5CRXz26TMJnZPBJq9NZYwJN1vYzDlGcMCrqgH1DzUnXy188uLMrgmD9Vcn7BjXnDgSTx4qBqWVfjc1it8txpruMiwlai8n3rcpL5zSTgzKvy/GtWCXnXn0kiNpWZb+yY3jadzBxblB1+okl2oLdzuk6VuQkB2A8kA/f4w8ZlTS5NWj9SWw/RTYzvH8y9UzcgiIQ+l1X0d5labCWby3l3IEFgN96s7qRRKqsY08GAUlyIUTyD91BkFejlqtKoGtLHjd8t6oibSoN2XUZJHq2DlWGxwMd1trmrTFx3nHFZzarnVjTBkgEmhP/X3tu3Awjq5s2g9Q7KL5QEuU2ZxYJwSukX/HDZACdevTNk2cBnlCQCoVtmlmzZvejPQerxy6SSG/yhgIhncWkHoKHawzj1Pq1sPhAotkAi5r+sF4/RfQGsFTJn/wbh7uFCqCVTuLOECg3ywcVi5dvKT6hE3nOyQnImWYRf33bEN
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7c6b48-484f-425d-16d5-08d806bcc184
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 06:18:24.2103 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yUO9B8wqCqQJmM+u347ae5fo+4neP+qkcCCUsQw757bGn3qJXnaVn2Q25vlCU8P4UtHiS29FpCmarrkzbwcY0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1365
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
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Exactly Tao.
When hw_support capability is aligned with AMDGPU_RAS_BLOCK_MASK by and operation, sw_support capability is calculated on top of hw_support value and amdgpu_ras_mask accordingly.

Regards,
Guchun

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com> 
Sent: Tuesday, June 2, 2020 2:12 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Clements, John <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove RAS's useless code

[AMD Public Use]

I think the real reason is we have " *hw_supported &= AMDGPU_RAS_BLOCK_MASK;" already, but the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: 2020年6月2日 13:58
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking 
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Dennis 
> <Dennis.Li@amd.com>; Clements, John <John.Clements@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH] drm/amdgpu: remove RAS's useless code
> 
> Module parameter amdgpu_ras_mask has been involved in the calculation 
> of ras support capability, so drop this redundant code.
> 
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 79bb05d791bc..337bf2da7bdc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1902,8 +1902,6 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>  			goto err_out;
>  	}
> 
> -	amdgpu_ras_mask &= AMDGPU_RAS_BLOCK_MASK;
> -
>  	if (amdgpu_ras_fs_init(adev)) {
>  		r = -EINVAL;
>  		goto err_out;
> --
> 2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
