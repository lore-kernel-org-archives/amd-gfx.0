Return-Path: <SRS0=bUVd=KS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88DDC47080
	for <amd-gfx@archiver.kernel.org>; Sun, 23 May 2021 11:41:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7420B610A6
	for <amd-gfx@archiver.kernel.org>; Sun, 23 May 2021 11:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7420B610A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA7556E233;
	Sun, 23 May 2021 11:41:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 964DA6E233
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 May 2021 11:41:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUzd4nBgVJKlOhuNLb2e6GcRN5v0FubNmBSGJ+YH4BZtEevaQv4FV7gAkyaJl635cV0tiuNiziNVWy5gUuYTcFqm0FOIscaiypJojS+fyH184HbaHTAJ+MEQ2FD86UJzNYeXxumNfSsodjKtdGclg4Z8pnFWa0V15+730pugutbGh5hIWohX58uTQNrl4SLhjF/IyVhYYaY5UdWUuD/cy14ZoOnoJ80nKn81FNqk3Wi2XHMbq2keDVBKvv9Fnxdo6AcI8zQjiukIkx/saWHsZwuo/ElYZnmLScsL5nITLuC4J7yQ4EqbE5I6dzG9bq7mtpov40n3Lu7VY3ODOTCR0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vjd5UE1BbPyeO5Hv1Zxp+HYzTUvi860zRlQYSn2zj/A=;
 b=XR7HL9e9pq2nc3EHWNZz5RuFRZu1SMHBhzAerEP44m1ztNhBxkUKQBc3nVi+5WxVBWlnlY8RiKOXje2WDwAYuDQ/PT5r4eudtsH+4z7zORh+DhK9pDKEzx8Voxiat409Cpw1JseCBSijEfqT5DwOf12fKEzfikqjJYxObMR4t45p0CDdr6RxwRcFxzpHNA2r8jiCR4gcCD+oU36lcFLzUO7IvVWjiJRzxvAArqnA8VnkHqK/N269Q4w6My/CvtONde+psgvcFZ01JsrbnMUPVExZLp0XJ1/ddysPWzncNXKdF4Q0a1wNZq88wSdkCzaY5u03CAT83lX6GEVcnbY6yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vjd5UE1BbPyeO5Hv1Zxp+HYzTUvi860zRlQYSn2zj/A=;
 b=u9PKJUN/LJcohmxgLQ5zzshsNqG+aJJu3GM+aHoDHTCfl3MrLm8IARSZJkq2P86ykBjSWdmhT0iml7cvZqDeXVAoyOvzT0uCYgnFxiBexyRhA5faCE7QA+O3+WzS2+88XINJhV1O9nN5vHIx47xga0knIX7xwRRwrw1WArNA1Vs=
Received: from DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) by
 DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.26; Sun, 23 May 2021 11:41:39 +0000
Received: from DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::3c63:9408:f8c:ee96]) by DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::3c63:9408:f8c:ee96%3]) with mapi id 15.20.4150.027; Sun, 23 May 2021
 11:41:39 +0000
From: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, Alex Deucher <alexdeucher@gmail.com>, 
 "Zhao, Victor" <Victor.Zhao@amd.com>
Subject: RE: [PATCH v5 09/10] drm/amdgpu: Use PSP to program IH_RB_CNTL*
 registers
Thread-Topic: [PATCH v5 09/10] drm/amdgpu: Use PSP to program IH_RB_CNTL*
 registers
Thread-Index: AQHXSypx0BE9sQzOsku4FQjmjcajXqrrvzGAgAH4rBCAAAQWAIADPZ4g
Date: Sun, 23 May 2021 11:41:39 +0000
Message-ID: <DM8PR12MB5478B20C437DD138880C1B61F8279@DM8PR12MB5478.namprd12.prod.outlook.com>
References: <20210517143910.2125-1-PengJu.Zhou@amd.com>
 <20210517143910.2125-9-PengJu.Zhou@amd.com>
 <CADnq5_OB+F3yeN9=nJjnvnAV6ePevL6Rz1NYhERJFUJ3s1sCJw@mail.gmail.com>
 <DM8PR12MB5478E96B03A4B7FDF9263092F8299@DM8PR12MB5478.namprd12.prod.outlook.com>
 <PH0PR12MB54173F1759D9D6FAA290DB568F299@PH0PR12MB5417.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54173F1759D9D6FAA290DB568F299@PH0PR12MB5417.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-23T11:41:31Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=3d920038-f703-48ec-8236-aea1423c4249;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: drm-next
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [223.166.164.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5b35e26-ad8e-4b73-bcec-08d91ddfba94
x-ms-traffictypediagnostic: DM4PR12MB5229:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5229162C8EACCA08B7428C01F8279@DM4PR12MB5229.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ejEBSvaxN0QZFtTNP5kBTkzaR1M0PZ4EaOzCdZ+pWkRgTsCOtkY4kCb+LTBuCEcazNVDNEs6fhvLvk1DFmTodtU67UrbU8r0EC2SJcqMbyTusA89pcewDZ2m5VTVptn2YHqQ0duYfNWG2ZeyXvuRJ1AhMUJmyf2unxKi0sZZO0gNKIYYUDDqIvuxA1wzLP94Y7nYe/SfA3U7nVOG/ZcPAEMvlETIxHV/t3M68kJnZ4j1L4eGd94qI23PjlBEPClGTR+g5gOyCRYXX3AKhHWJm4w4peAvbPOnzrU4BVwjrtw3fjYtWFprWqtTk47xnssIfQs6055QX88PPMjqWRNmUPTBPdAT9d3aKYOw4kdqstclO2Vnun0fwiLObUhivz2f1HOTA3HqGNxICY9YOuCeEh9Ss4jg1LKkJ33NugrpQ7csmy1XcAXK6fqFX09gDnw/vkBoogUIYJP+7VLd7F+Zj7p1wLkXFO3auxZH3CNTHu/cEgAYkanIsqykXRFAsNFbEKym/kukyb2TMwo4a4Lw8YZSBU+npZU67n74D4OCnLOeg6pmcY+7rIo/H1AwsP3IDBEabB8e47tkW40aSS5MaVfapWaFaMm+NYBt669dD9SmJq1WJ9aHIFPRm9IDJBxaCLGdpoK3eAzhEK0GCPOF7ozPxiDJXBb3y7tGQ6EBwxLH5e2ulwO6x9g+TAIwHxR9B3+sXeeQNXQ2JayWCfdJ01sJp8uJ5qqqPhUXEW6b/dc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5478.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(8936002)(38100700002)(86362001)(76116006)(478600001)(33656002)(7696005)(83380400001)(8676002)(55016002)(186003)(45080400002)(66476007)(66556008)(64756008)(66446008)(4326008)(66946007)(6636002)(52536014)(110136005)(316002)(53546011)(71200400001)(966005)(84040400003)(9686003)(5660300002)(2906002)(122000001)(6506007)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Zu1t/3RmdIttdz5IqH0FQ4rI/KIEsl65KZU1JrHXJV1CkUAfz2VbFvi9NSRn?=
 =?us-ascii?Q?Rh9I63Yznikg1Cve+S5dTFYNskiN8eAZMm6zDY3ieQuqYMg/v4vACQOQ3hD9?=
 =?us-ascii?Q?0OWp4dHtkWlmk9AEnNzZX8ZAr/lPPPRNcY06TCrmaefSWiraBnBBu/P3ZpCe?=
 =?us-ascii?Q?LYa9XXZY1nh+h5e9FhOvrlxMjwkvQ92jzwyK7C/Q/e4k2P9VcCH6ZJN3uIpT?=
 =?us-ascii?Q?XwAQKvYpYcw+8swqCzDTgFfmpRYConoPFK+iE/jE/WpK1HRkc3cUJTr/OnLk?=
 =?us-ascii?Q?K8sl7M3bXFWk2A4s1J5/572t+TEM17fCjUTvEAsnmB6Y0shpuDLWNZdJspFt?=
 =?us-ascii?Q?SeWG4D9v8GKb0jVXpE5xGoT3oBnLZr2IDoXaogwVBvIIwqboGAe5llTZFmIX?=
 =?us-ascii?Q?sIkZwmfR5+5yD19MTV2unpVxAmrpebAbilBD2ZhkU86O4+JxMnZoLCTj4N0P?=
 =?us-ascii?Q?nqqBUJoeHwU2iKkYT6ZPhRp80+/bubyAxrgcvogfHkwyeL3/EOYthbREWtSr?=
 =?us-ascii?Q?5fBMmo1OcTqrvzHBX/BeY8pUv2pdbT5wulryp5y3VtvIGQBvYZRmAPuqM9xs?=
 =?us-ascii?Q?twcxTniOEPWLSZn8BHmI1nRkxKr3oFpSpp9hTZNP7aiMxJyN5l7B8qVM4UAP?=
 =?us-ascii?Q?02NG3yXZzobP5GACIbynUFyZfKqk8vQYfxJXuoQVFPFcTAv1BqhaQtu5vp+i?=
 =?us-ascii?Q?mnoiiqsNsOBAT3aB4v2H+FHDtOrUDJ7JX62J9aJy4j+fftOlChbTKZ9e+hAy?=
 =?us-ascii?Q?0KW2Fq1byMZLw+yQJh0P/TCHzY9CJ35KxLYwFl05SVkwBPwI8x3WEKskxG20?=
 =?us-ascii?Q?d/e1NLByQ16H8ACykIZZG9w5pMAH1Hz22CkPtD6gTrhMloo4QWPLVGGw2n8f?=
 =?us-ascii?Q?JWAQBtxqLbhVcalDAym+ihDZhlfL7dBv6/7mGzNFaAHGEWoN3VKK3B9e371s?=
 =?us-ascii?Q?P3Th+9zNiEb76k37157TViX7Gb+C9AZ2D/8sFXtu1xnRHLgAwtddsUYQsPSw?=
 =?us-ascii?Q?Sab4VLjrzkrQe5202Lziw8oFedQ/XBPXeNS5CtkA+3sJx49My3OUA3BHmB9N?=
 =?us-ascii?Q?Um3jUMS9uC4Tq4tbxBQnyn80L2Dru3kEGr1mLjoNjTrZgBkbFmiLo3xapAax?=
 =?us-ascii?Q?FswifpEoBnU5oV1dITvsaB7vNKDEdyQTsm40t0W5wY+SQXsFMhOk0dpHrf6P?=
 =?us-ascii?Q?XL+spDAFYIPXw331G1nUpJOos9h1hNPmWVnlApl+WRrVTPgNldBvpgPFGlz2?=
 =?us-ascii?Q?rjahH9eMI58/fBcVfdYQg96F/n9635DfTKflzdmPIPvgT4EiomKnV27jgrLj?=
 =?us-ascii?Q?wD9KbGyxgchy4L9H707IimeE?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b35e26-ad8e-4b73-bcec-08d91ddfba94
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2021 11:41:39.3982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cpBrvjqQtBhZVVu3KF6OY6ykcBn/sV4byLfHbHSmlRxy9jCndLlB6PpoMxjnwUFDEXnG6qCkRkhZLCiJADs8nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5229
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Alex/Emily
I noticed our team member have merged this patch, so discard this one.


---------------------------------------------------------------------- 
BW
Pengju Zhou



> -----Original Message-----
> From: Deng, Emily <Emily.Deng@amd.com>
> Sent: Friday, May 21, 2021 6:08 PM
> To: Zhou, Peng Ju <PengJu.Zhou@amd.com>; Alex Deucher
> <alexdeucher@gmail.com>; Zhao, Victor <Victor.Zhao@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: RE: [PATCH v5 09/10] drm/amdgpu: Use PSP to program
> IH_RB_CNTL* registers
> 
> Hi Pengju,
>      You'd better only switch for sriov.
> 
> Best wishes
> Emily Deng
> 
> >-----Original Message-----
> >From: Zhou, Peng Ju <PengJu.Zhou@amd.com>
> >Sent: Friday, May 21, 2021 5:58 PM
> >To: Alex Deucher <alexdeucher@gmail.com>; Zhao, Victor
> ><Victor.Zhao@amd.com>; Deng, Emily <Emily.Deng@amd.com>
> >Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> >Subject: RE: [PATCH v5 09/10] drm/amdgpu: Use PSP to program
> >IH_RB_CNTL* registers
> >
> >[AMD Official Use Only - Internal Distribution Only]
> >
> >Hi @Zhao, Victor/@Deng, Emily
> >
> >Can you help to answer Alex's question,?
> >Because this patch originally from @Zhao, Victor, it's hard for me to
> >explain the question.
> >
> >Alex's question:
> >> > --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> >> > +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> >> > @@ -845,8 +845,8 @@ int nv_set_ip_blocks(struct amdgpu_device
> *adev)
> >> >         case CHIP_NAVI12:
> >> >                 amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
> >> >                 amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
> >> > -               amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
> >> >                 amdgpu_device_ip_block_add(adev,
> >> > &psp_v11_0_ip_block);
> >> > +               amdgpu_device_ip_block_add(adev,
> >> > + &navi10_ih_ip_block);
> >>
> >> Is it safe to change the order like this on bare metal?  Please look
> >> at what was done for vega and sienna cichlid.  Something like that is
> >> probably
> >a better bet.
> >
> >
> >----------------------------------------------------------------------
> >BW
> >Pengju Zhou
> >
> >
> >
> >
> >> -----Original Message-----
> >> From: Alex Deucher <alexdeucher@gmail.com>
> >> Sent: Thursday, May 20, 2021 11:47 AM
> >> To: Zhou, Peng Ju <PengJu.Zhou@amd.com>
> >> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhao, Victor
> >> <Victor.Zhao@amd.com>
> >> Subject: Re: [PATCH v5 09/10] drm/amdgpu: Use PSP to program
> >> IH_RB_CNTL* registers
> >>
> >> On Mon, May 17, 2021 at 10:39 AM Peng Ju Zhou
> <PengJu.Zhou@amd.com>
> >> wrote:
> >> >
> >> > use psp to program IH_RB_CNTL* if indirect access for ih enabled in
> >> > SRIOV environment.
> >> >
> >> > Signed-off-by: Victor <Victor.Zhao@amd.com>
> >> > Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> >> > ---
> >> >  drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 19 +++++++++++++++++--
> >> >  drivers/gpu/drm/amd/amdgpu/nv.c        |  2 +-
> >> >  2 files changed, 18 insertions(+), 3 deletions(-)
> >> >
> >> > diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> >> > b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> >> > index f4e4040bbd25..2e69cf8db072 100644
> >> > --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> >> > +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> >> > @@ -151,7 +151,14 @@ static int
> >> > navi10_ih_toggle_ring_interrupts(struct
> >> amdgpu_device *adev,
> >> >         /* enable_intr field is only valid in ring0 */
> >> >         if (ih == &adev->irq.ih)
> >> >                 tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR,
> (enable ?
> >> 1 : 0));
> >> > -       WREG32(ih_regs->ih_rb_cntl, tmp);
> >> > +       if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev))
> {
> >> > +               if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
> >> > +                       DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
> >> > +                       return -ETIMEDOUT;
> >> > +               }
> >> > +       } else {
> >> > +               WREG32(ih_regs->ih_rb_cntl, tmp);
> >> > +       }
> >> >
> >> >         if (enable) {
> >> >                 ih->enabled = true; @@ -261,7 +268,15 @@ static int
> >> > navi10_ih_enable_ring(struct
> >> amdgpu_device *adev,
> >> >                 tmp = REG_SET_FIELD(tmp, IH_RB_CNTL,
> >> WPTR_OVERFLOW_ENABLE, 0);
> >> >                 tmp = REG_SET_FIELD(tmp, IH_RB_CNTL,
> >> > RB_FULL_DRAIN_ENABLE,
> >> 1);
> >> >         }
> >> > -       WREG32(ih_regs->ih_rb_cntl, tmp);
> >> > +
> >> > +       if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev))
> {
> >> > +               if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
> >> > +                       DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
> >> > +                       return -ETIMEDOUT;
> >> > +               }
> >> > +       } else {
> >> > +               WREG32(ih_regs->ih_rb_cntl, tmp);
> >> > +       }
> >> >
> >> >         if (ih == &adev->irq.ih) {
> >> >                 /* set the ih ring 0 writeback address whether it's
> >> > enabled or not */ diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
> >> > b/drivers/gpu/drm/amd/amdgpu/nv.c index
> a9ad28fb55b3..b9c9c4d4606c
> >> > 100644
> >> > --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> >> > +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> >> > @@ -845,8 +845,8 @@ int nv_set_ip_blocks(struct amdgpu_device
> *adev)
> >> >         case CHIP_NAVI12:
> >> >                 amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
> >> >                 amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
> >> > -               amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
> >> >                 amdgpu_device_ip_block_add(adev,
> >> > &psp_v11_0_ip_block);
> >> > +               amdgpu_device_ip_block_add(adev,
> >> > + &navi10_ih_ip_block);
> >>
> >> Is it safe to change the order like this on bare metal?  Please look
> >> at what was done for vega and sienna cichlid.  Something like that is
> probably a better bet.
> >>
> >> Alex
> >>
> >>
> >> >                 if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
> >> >                         amdgpu_device_ip_block_add(adev,
> &smu_v11_0_ip_block);
> >> >                 if (adev->enable_virtual_display ||
> >> > amdgpu_sriov_vf(adev))
> >> > --
> >> > 2.17.1
> >> >
> >> > _______________________________________________
> >> > amd-gfx mailing list
> >> > amd-gfx@lists.freedesktop.org
> >> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fl
> >> > ist
> >> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> >> gfx&amp;data=04%7C01%7CPe
> >> >
> >>
> ngJu.Zhou%40amd.com%7Cabc8d955fb1f4deb9ce108d91b41ecbb%7C3dd89
> >> 61fe4884
> >> >
> >>
> e608e11a82d994e183d%7C0%7C0%7C637570792232990999%7CUnknown%7
> >> CTWFpbGZsb
> >> >
> >>
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> >> %3D%
> >> >
> >>
> 7C1000&amp;sdata=HyDcZjT3c6mY%2F%2FYdjMuW1T%2FRUIzqX5kK9vaYus
> >> mZJxI%3D&
> >> > amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
