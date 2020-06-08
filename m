Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE762C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 07:40:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98ED5206A4
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 07:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="U4Q9B3L/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98ED5206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F7AF6E0E1;
	Mon,  8 Jun 2020 07:40:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C38756E0E1
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 07:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOYmm8PBg3eNXGO2EqqnjAt92R/+xoiVbcGWBeHxx+PWmviLKJNyeQ87NtszNS9SgPXzmMLB0yZ73+0XynNX7s8N4E7XW+klvG1jUexjh4rvww6uIca4KPdC0LQ2/kQlMXyA+CRBD2ZtNs2UVlxY/madilyj52cs/don9mVR9cu0beRnvMZFzNd8+jKJih0Yi3klS1KETGfP2JgPwUlnOszXXA4h9areGivqlFekx3w2vBeyUKjJ/b84nhK6QIkl0j62QPJMAlozDvmlfytH4NG5wQiyv9YmQ2p+d/x4C36pbsGzBnFvqkipu1BYwHKia7RhxySeBoT32TNueV7Q3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vu0YV6+aaOQlq6tlBkjmtpbexBbL9QfJbfShrLCcpeQ=;
 b=JqH32UtfJlvZ5IrukTQ5+qdP9+UGGCCaR6YbHY7Ro02/gEgDN0g+BRB/oT4O74FSWQr7obp3GvWeKx4fFWtjM7yUQgNnTkiksL1GkN1QU2sMf2bW8B63hc4uP8qcwaQNrf4nfEfwH9jZlJXr6+Ee49TppFuGkgfP1lpKYGavlFddWKuGS1uFxE0bW7QZdrMT/IKlZSmn5qY+Kmb8TFr72w1KsY/mD7j6Aiq0/7XL5ETWzcasJLC2h5QL+BMqh79WwZVw6aLrANblYMyLuPRXigXRiIy4jIyN3s7Kvb9HDwqTNyFGtp0jOkd8RLwnr+njguoECOsh1KflNUsetaousg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vu0YV6+aaOQlq6tlBkjmtpbexBbL9QfJbfShrLCcpeQ=;
 b=U4Q9B3L/7EX0sPKqhzDYIc2lNh1ouW8pCyahQnh6EKUsICEZ5AqFyy/qNouU8wUaAgodBK0tS54jcky4Zgcf7N/78cx8hEAlNlJPmzpU85OpCrqJFznVxTfl1gxkSy56pvfLpM/ZxhcHQKksz+NhG7qk2X/Y5Vofyo55tiUMf04=
Received: from BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 by BY5PR12MB4242.namprd12.prod.outlook.com (2603:10b6:a03:203::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 07:40:18 +0000
Received: from BY5PR12MB4307.namprd12.prod.outlook.com
 ([fe80::2c8e:6202:8066:9e8]) by BY5PR12MB4307.namprd12.prod.outlook.com
 ([fe80::2c8e:6202:8066:9e8%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 07:40:18 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/soc15: fix using ip discovery tables on renoir
 (v2)
Thread-Topic: [PATCH] drm/amdgpu/soc15: fix using ip discovery tables on
 renoir (v2)
Thread-Index: AQHWO0+tXoWcuny65kuY37gMpF4t4KjOMhJwgAAnAfA=
Date: Mon, 8 Jun 2020 07:40:18 +0000
Message-ID: <BY5PR12MB43076F4F7BE58E001DCABFEFFB850@BY5PR12MB4307.namprd12.prod.outlook.com>
References: <20200605154029.118736-1-alexander.deucher@amd.com>
 <BY5PR12MB43073DD83173ACFC0A67F4D0FB850@BY5PR12MB4307.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB43073DD83173ACFC0A67F4D0FB850@BY5PR12MB4307.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f58f55a6-09d6-49f1-9a1d-00001e553bcb;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-08T05:19:13Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da33cb66-88ad-4b85-1a9f-08d80b7f313f
x-ms-traffictypediagnostic: BY5PR12MB4242:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB424259860D8CB91C3127C2CDFB850@BY5PR12MB4242.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZHBa1PmDeOTO28RZZwNmtjVtlmtYr9pFALKS0TUIsnR/gMR7voyB6WQzJIBu1niUMXaquJi/qw3KypNBTbKS4y9cFxhRanT1s4XfBNRHEYXNojBb1Nym1pF+se0bZNGJxZLgHHu+vWPcn3lsH/JjsdM0XcTUoY3hL1iasHNkIZtP0Ro/HUh4k72qLS9AQlwhu1AiGof67E2wiGmgry44+SPZmuVI6d9oO1RmLafHTI+NqCa4C0C16V+oK+2DmMfjYEzyKFLhvGJOcsAhFDfC+p3s+DOhNGteWjFr4U0TakT7NE3IOQD+Sm0reF9rB2SM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4307.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(71200400001)(2906002)(316002)(186003)(6506007)(26005)(5660300002)(76116006)(52536014)(55016002)(66946007)(66476007)(66446008)(66556008)(9686003)(53546011)(110136005)(64756008)(7696005)(8676002)(4326008)(478600001)(2940100002)(86362001)(33656002)(83380400001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: iG8FaHgWdB/9tIiJaRkk3sNo6HTFuC2fdwaBio/nKr0dhaQA8LuHmQNgrgpA0wMf3o4qgY5zuD2gi+Tb2KVDqaRjyTJeV0HqN6pZi/My3rx0VijAI1c1IE+Si43lvG2o6m4fbO+RlUYlKjsF55yMK0jH72hbqTFg8GFDo5YQ44zHs8bS88LgYuS1KRx0LwA8aF45URSmbi91rdYeEpm98vYJZn2OkQnKxtmnm1UZ8qyZuoz55bjozg8Qq01pB2xwM20+unK71I2cRPj8NvK99S28Fk95p9jkAafaJmCBbvwsiwbQVL9u9pc29QumFYLx9bqGt5DQWVcVpxvtPenY5AztriEEdkTHi0R8KuBJ6ypx5oEMphDdtDeJ6MoHXnevzi5pmxEOdQs8xPPGWAJ9HG/6GopgQ9HQjsjelx4pzS8OQrdX/m29Fjm6d276dHstLvi2Z5FNHLmF5s3ZIAaUhDW8e7/OGx5Gd/jLGkL/AFveX5+ZXCcU6iP4rEb/Cnqd
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da33cb66-88ad-4b85-1a9f-08d80b7f313f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 07:40:18.7617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tUZc+M1YbB8R4qFHbu48QuSK7ybwoGSiKhHZIeXmdq+89bF2X2GcjXaISqb0xAhJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242
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

Regards the gpu info inquire failed during start X, have sent a following fix for the issue.

drm/amdgpu/soc15: fix nullptr issue in soc15_read_register() for reg base accessing

> -----Original Message-----
> From: Liang, Prike
> Sent: Monday, June 8, 2020 2:00 PM
> To: Alex Deucher <alexdeucher@gmail.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH] drm/amdgpu/soc15: fix using ip discovery tables on
> renoir (v2)
>
> According to reg_offset assignment in amdgpu_discovery_reg_base_init() the
> reg_offset is calculated as IP base address pointer therefore PWR IP base
> should be map to adev->reg_offset[SMUIO_HWIP][0] + 1. Moreover, not
> sure whether can use/need  the mapped address to access
> PWR_MISC_CNTL_STATUS for controlling  the GFX CGPG in Renoir.
>
> Base on the above modify the PWR IP access  nullptr issue should can be fix,
> but should hold on this patch since  start X will be occur other nullptr issue
> during amdgpu_info_ioctl().
>
> Thanks,
> Prike
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Friday, June 5, 2020 11:40 PM
> > To: amd-gfx@lists.freedesktop.org; Liang, Prike <Prike.Liang@amd.com>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: [PATCH] drm/amdgpu/soc15: fix using ip discovery tables on
> > renoir
> > (v2)
> >
> > The PWR block moved into SMUIO, so the ip discovery table doesn't have
> > an entry for PWR, but the register has the same absolute offset, so
> > just patch up the offsets after updating the offsets from the IP discovery
> table.
> >
> > v2: PWR became SMUIO block 1.  fix the mapping.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/soc15.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> > b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > index 623745b2d8b3..dd17a8422111 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > @@ -686,6 +686,9 @@ int soc15_set_ip_blocks(struct amdgpu_device
> *adev)
> >  DRM_WARN("failed to init reg base from ip
> discovery table, "
> >   "fallback to legacy init method\n");
> >  vega10_reg_base_init(adev);
> > +} else {
> > +/* PWR block was merged into SMUIO on
> > renoir and became SMUIO block 1 */
> > +adev->reg_offset[PWR_HWIP][0] = adev-
> > >reg_offset[SMUIO_HWIP][1];
> >  }
> >  }
> >  break;
> > --
> > 2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
