Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BF0C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 04:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCC3320899
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 04:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sQ50pUUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCC3320899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5232A6EA04;
	Thu, 18 Jun 2020 04:10:43 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760073.outbound.protection.outlook.com [40.107.76.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AFAA6EA04
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 04:10:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNaX2F/sJirxMSBYlfzbhv0mh+T+4tK/waYR3mtSbvOcsK9meZeeiUTCYA78Otsu819LZGGcBemerBYHc5Aqnq7wgRlF5pm/OYLyKcXSBEYiJQuQIaO7opynVGirG4uWAT+dj8gFmClz/rVQNKn2l9xyk3SzMcdZcRrfB44eeGAc0BINOfKToYXteWjURAyvrxJJ+37a6zCeK01MFIs9QGoOXQ//z7VpqWimjB5HdK9tyUdf+qjZPtAEJdah88L3NNYWMPv5k+CS8XbCDpgzWhzt6TIcTCaYBPMEYJgvP9raoTh7o3OH7gAv4kSviuySiactLhVPqRxMbu6c6dWHvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuGef/giHaGQZDXYERwWFe67XFboJtgeOZ6YToQNCrc=;
 b=UHS3PqQ5haiIzKOnmTq7/W8z68KkMJLwJWgZwBp+vvrrxCpOFQ5z23p3eEEH7eqf+9Lq0GfucSSTVqCVI5xbuuMQhVBRIMDIaed2yOMOi3jbPMO/zV5exs/vkx1qtbT1adeQqa7SHJuaCC1OL4IZFV2MkBJAMZBUC7IfrYHKID4MxwpzM2Bbf0JJQINwHXBmxfVtuUKMAoRFmztab+IZDMnCn33xsqaMw+VfGKD8cGIvFLegqfiqOvzpODMVnon7izPOkXcnVZRjPczyqglAuiLsQnDXY8uDnI0ZzdZnczi2vu11FxXKd1gUhjcTp5qopI5t+eMm1viPHHm9xMaNVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuGef/giHaGQZDXYERwWFe67XFboJtgeOZ6YToQNCrc=;
 b=sQ50pUUEHLSlx4p6ry/FPCtj0LvqeNSDHzvF/rfBMGykTgfIhXV1Prf6QivDCdnQaKwQt1IeiUBvl1jmTbMcL2gUBN7KdP0zXNFg3dMTEu6uPzq8i7CU/+Cs0vdVUQNVBysiLEBfy4gfc5dndVsrltlvOEeZ4y+MJYCFniWYFc4=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3770.namprd12.prod.outlook.com (2603:10b6:5:1c4::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.23; Thu, 18 Jun 2020 04:10:38 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3088.029; Thu, 18 Jun 2020
 04:10:38 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/powerplay: declare driver if version mismatch as
 "warning" explicitly
Thread-Topic: [PATCH] drm/amd/powerplay: declare driver if version mismatch as
 "warning" explicitly
Thread-Index: AQHWRIvyTKHkhmxQ2UGjOTT546FXS6jdT7uAgABxFPA=
Date: Thu, 18 Jun 2020 04:10:38 +0000
Message-ID: <DM6PR12MB2619647D47307D7A2B215608E49B0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200617094431.11411-1-evan.quan@amd.com>
 <CADnq5_OjBoiO9jOcHLccs8wdSvVWz9rWA=tfm_9p3Ctye_6Nhg@mail.gmail.com>
In-Reply-To: <CADnq5_OjBoiO9jOcHLccs8wdSvVWz9rWA=tfm_9p3Ctye_6Nhg@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=62d561e7-fcd4-4232-a83d-0000337b4fd6;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-18T04:00:06Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0111eb00-1731-46d6-8b80-08d8133d8ec4
x-ms-traffictypediagnostic: DM6PR12MB3770:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3770C7482C8AACDD04CBB308E49B0@DM6PR12MB3770.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:71;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ffkuKxCTeKMboVeABIx/y2e0Jv4YvVMvp7yxnfwmVBfIKC1QyAyacWxc7q0Xmj8yEL7Edo29a8J+s6KG0KAI9F8IYB0oB51hGNvsvMhDFhMGQSjGp8xnhNr+eXFjHfjZ4Gb/Y2mMT2v58QgWVmvDEA7RHGO30iE1cvVpZwl4izcXnP0JIczpSxCJrqbhVn4nfAUSer7WHCJfx7Id2E6TNbXNBnlWCOA+mphGUZajJ92bFr9bIIy8leqGSFe4EQ1nuCIB+MOF9gE//18xPSwchSIPEandwVQg2gUkT3wmwTbytdtg6ojcSO235NTBXqLnknrUyEoAQtlbc7EVWL62M2JULOIWbqupbD18ezF/uPk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(53546011)(6506007)(5660300002)(33656002)(26005)(52536014)(76116006)(966005)(8936002)(7696005)(4326008)(55016002)(186003)(66446008)(66476007)(66946007)(66556008)(64756008)(478600001)(8676002)(45080400002)(54906003)(2906002)(83380400001)(9686003)(316002)(86362001)(6916009)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: JAwUlvj7AwCeYz6R07KvZ6P3tot1OWjehsL7bM0jIcrQ1ecrYYtmtLnkbhcbbfD/rtcOE+k6sHdEt7kzwLPCTH8zeV4i5ABDVgmCJ8i+cFs2fFro788zhQksvKWUXtXb+cpBWbwXpaI/PjWF5anLjbp1lNC/N91lcV9WZ6hTJ8PeXGdDU80T150Zuvkw3wjy1A8sS7b97O79KXVvDCTxRaXbqpNHj5AAIp+u0rxRjUPntrvbT3Cpo6920dOuvA2m0yFDI63nVkdakep3xe6b/bdY597etiDqngHBtMpG/l4qNzUODEF2KGs0DucIdnLXVd67OTKfzEmAl31zv7D89ZkDJ2rruHTNsep8qOVnbNW05aCzWp7l3nBKEmfMx+lfsQU4X6JhTjK6OqLLMrUroLpaBwGtceG62Z2iTs70XPGs9tRCHPyACmS9eCx5DsL5dVoJx4VDt2rceGL49HQT6O/1bQp4hYcxyT2PgYpUzuCKAVZs4CgFjs4wMMDuoKQL
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0111eb00-1731-46d6-8b80-08d8133d8ec4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 04:10:38.0374 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bZABNY6xhjSOdoNa21xBx58dLZo76ibbEDY+5EUDmC2QXzLgIF9TJF7Lnq9PqLP1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3770
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kumar,
 Pramendra" <Pramendra.Kumar@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Alex,

This was raised by Pramendra. He got plenty of questions from customer about this.
The customer saw these mismatch messages and did not know whether it's an indication of some critical error.
The mismatch messages were update to be prefixed with "warning". So that it get customer reminded but not scared.
Any better idea?

BR,
Evan
-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Thursday, June 18, 2020 5:15 AM
To: Quan, Evan <Evan.Quan@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>; Kumar, Pramendra <Pramendra.Kumar@amd.com>
Subject: Re: [PATCH] drm/amd/powerplay: declare driver if version mismatch as "warning" explicitly

On Wed, Jun 17, 2020 at 5:45 AM Evan Quan <evan.quan@amd.com> wrote:
>
> So that user knows it's just a warning and can be safely ignored.

I'm not sure I follow this logic.  I think a warning would cause more concern than just printing it as info.  Why would you ignore a warning?

Alex

>
> Change-Id: Ic518ec3eb68c6bd6682e6131e32cfe90843341ff
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 2bcb8d16f1b7..22eabc10ea8e 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -318,11 +318,11 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
>          * of halt driver loading.
>          */
>         if (if_version != smu->smc_driver_if_version) {
> -               dev_info(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
> +               dev_warn(smu->adev->dev, "warning: smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
>                         "smu fw version = 0x%08x (%d.%d.%d)\n",
>                         smu->smc_driver_if_version, if_version,
>                         smu_version, smu_major, smu_minor, smu_debug);
> -               dev_warn(smu->adev->dev, "SMU driver if version not matched\n");
> +               dev_warn(smu->adev->dev, "warning: SMU driver if
> + version not matched\n");
>         }
>
>         return ret;
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cev
> an.quan%40amd.com%7Cefaab1a492c9408cacf208d8130393ca%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637280253365573223&amp;sdata=REs2QnFT0V1gX
> yti8Ws4wn4hhcpMDvpd4mf8WEVUEk4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
