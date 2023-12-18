Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE82C35274
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Dec 2023 18:23:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E323E10E2B8;
	Mon, 18 Dec 2023 18:23:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2C1F10E293
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Dec 2023 18:21:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U99KI7t2VWk++BLUEFn+Oc2xuYyaDJ4I+i+CYU6WJWnCzGv9kB09UcmE6ftIUoimc87+qvNe/tkykSDbHL52VgwO3CJm9NUamUEJcYjvuJjj88Lc3W1zXElZ3HaoSzvz3RmCH8YcW28NiFt3qVvqqLnIX6PPB1SbAzfCdEhDK2B2M5KwkcCN5hqUsA+uuW3t+8TOwt821TTJOSq+WImM04ThLJDF1279ahjWWLbywlVQhpCJqKlfxLIogGNafK/84V4cvqaN27KnMF+44M4b3FygTOBt1PE9Q9bB+zjvsadLD60PCnrLtaaJz/h6N2/S7AM4Fj92D0jBIN1SaBudDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUYKbN6H639z/3aQR8jkv8LvDHmHmXATeaASaFEz1vs=;
 b=ZTuHcq2LnZDaJQJZM3n6NsQCR8W6l81ed2yngbI2Z5nKu3gy+Vzg6Ef60hHrtDnGRD27qFjJCw/QBj4lVKZNcZlsBnLLOYCS3pmwzcRghOjdOVcXemeF3ip7F9MiwcWIZAfYvZtXrqjf3Am3LSgFSt5l7xieWLGGh5UzgctbqMQ/VLx1ouIPsrHg6tBXsrrWEy0KzJwZtmfMSAZlHEE3V60DVppfD7IX9IhE/vLWHOdOs/EoIea//Ksoi0P0QM2BzmWELR7OwM0Nqpy1EmhEMRUOjWCc9hJxTsJcfC5e3oTZdIBpFsgCfaQ2b+esS4NDEFHSIMmczg1Tu63Iw+zgdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUYKbN6H639z/3aQR8jkv8LvDHmHmXATeaASaFEz1vs=;
 b=4c1iiNHmEy8/xRvF7vO+hmGnTXrv66ygGesbyxCJXvkFJ1FD7+0OlIz61R2ljGrv7T8JjLql2xJwLmVXMCKPcO0BCjaLA0L+KcqZ3AkgvOxZGn7ZVQpVglZtum9dqtqcmDu4StZ8Wy+dopbYvM5xRbZC4O5a6vO38wmcdw38vm8=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 14:20:45 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::7092:c19b:bd71:3b0c]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::7092:c19b:bd71:3b0c%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 14:20:45 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Fix ecc irq enable/disable unpaired
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: Fix ecc irq enable/disable
 unpaired
Thread-Index: AQHaL3bNMVaSv6swNUS7uM8CuTxRhLCuoaUAgAAhQZCAADwBgIAAHAog
Date: Mon, 18 Dec 2023 14:20:45 +0000
Message-ID: <PH7PR12MB798864E5903B7F4E928D715C9A90A@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20231215164952.449464-1-Stanley.Yang@amd.com>
 <BN9PR12MB525719E4C88CFB696CEC22BDFC90A@BN9PR12MB5257.namprd12.prod.outlook.com>
 <PH7PR12MB798809C2517604E5CADE7D889A90A@PH7PR12MB7988.namprd12.prod.outlook.com>
 <BN9PR12MB5257777C2BBB262B1EC2CAA1FC90A@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257777C2BBB262B1EC2CAA1FC90A@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fda94616-97d2-4cd6-b9ee-05b1d8b817e4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-18T07:02:05Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|CY5PR12MB6624:EE_
x-ms-office365-filtering-correlation-id: b97dad6e-c487-456e-a40e-08dbffd48618
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I32EHhRmE8ZFPskqkpH7DMiKkpVdg51t4nnVDMKC3XTutUPESCe4fKSSaQs4aRGXXddr2GGEC7yOAi2B9U20g0O5uC8HSDoAU2ytc1+7JtT1+EQYEf0G/JF+8I8opm/tIT3tm5PPz2nNZFhZmp0CvqnDZ77dKnL6Edax/KjsaUMtMTLLz6FwUkylgR4NA9CCTNdAa66evXlDAsGt5+GMjmACVAz/5pwF8oAnTOfefwt1xC8YrB5lZbx9AeW0Up3C8SS7lnQYknyzNiAdR7ueJwiQOCshkMQm7qXB2orsmo/nwCVhB0X6QI8frtulQvlyv38+DTfed5859+BmjhgLWGHFwQMa/Te1dYdxl69JXVDCV1Y7ia+Jt7Gcrpt4/rsYP712al4C7Ct6u+3ht+hNPruim4lsV7d+OGcTV31kTwWU+wQ82IvTL3PhmKOUOVJVXHSAlZYB3NVHe1gwA1pJOiMo7HL4O1y5DF63ienZ824N98qQoUfsoXpilxok69ZO72nEGms9mO9f32jeHVdHc9myvJwDhLKJo7qpm48H3ZKhePv24fmJOkTe0ycCbVNTel8igatCRI54LQ/dzeu8dc6pHDWKZkmNtHkTwKFvc/CX9InBZYFQv6RVcu24c7hbdzP7b+ubje/EIAbyNy7ajqoS6y1XGpcPqL6v7kYB/jY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(346002)(376002)(396003)(136003)(230173577357003)(230922051799003)(230273577357003)(186009)(64100799003)(451199024)(1800799012)(38070700009)(55016003)(66946007)(66446008)(64756008)(76116006)(66476007)(66556008)(122000001)(38100700002)(33656002)(86362001)(26005)(83380400001)(9686003)(53546011)(6506007)(7696005)(2906002)(316002)(8676002)(110136005)(8936002)(71200400001)(478600001)(41300700001)(5660300002)(4326008)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z9UxplvJ4vY9JBzqrzutD0oC4nu6lJhd4tIaeeFZ7WWHcnYho5I53hAgDVTi?=
 =?us-ascii?Q?sBp6L7P9sr8Dw2xYhPe0Pt0oTidPHMGvn0LKR8Vy49qn+YX9Y2CsBkjk0SCb?=
 =?us-ascii?Q?xIIBS/gS3h/D+ib+D1wbN39Nc/QeFU7tuyWZvhl4LVonJ7yJKfUeyrSIRitG?=
 =?us-ascii?Q?8UvG6A4K8FhJOZ8ec3BTSmTHGbdbQJbaK44z7z9M3tI2Rk4Ib72C5kjQqVUX?=
 =?us-ascii?Q?5rSBjBDLwkuUC8a/DHUypXeg++98BwPU9iVEfnxaUJglXXgYERxc785Jhvbs?=
 =?us-ascii?Q?/W1LEGyScMsMduGZDPBtzY5ipeRlT0pm3jUCLbQCB5nWXrJ3EaTLEqnvk4RC?=
 =?us-ascii?Q?xCEflPNde1WuYcOxHqe7NYm1XFJ1XpalVJwIA2vsG1XHHCrWqANScQZ/mFM4?=
 =?us-ascii?Q?iNmzEZDvntk3SHgtiIl54yYQ/MlLS/rX1JB9Pb9D01UuHzzH8+P07DfNG2jL?=
 =?us-ascii?Q?s5OBdzB+eJUePKay2sVo367GrKTfXAoTB1nDnPLLH4/gAYqZ7qxbxoFAETmD?=
 =?us-ascii?Q?ohCfO+Ruy6v8/2O5fWJvhTMQAyqzxjYjGhFzOA8c1UIdWL6g43M4aXFPMEQR?=
 =?us-ascii?Q?cy23/d8bk1YQGhFemgqg6spAl/OcWhtX/GlN/Sav0l5h023mZxjVEvc2jLtf?=
 =?us-ascii?Q?we1xH5mbNWXSATqI3vh0/PgS8DX6C99Rw5Ox3YCpgph/L+rfN3DC6vilX1bt?=
 =?us-ascii?Q?grKnnCFpvAx008mmpG2+VzoUJQ5lsFlFoS0hQcoQjbhrvgK5+PnkI6xY0MiM?=
 =?us-ascii?Q?+x0OaXIUD0A4f2plR4pUwa2wweE5yZV/2nM9UzA++sbGx3n7A45fN8+9xvx9?=
 =?us-ascii?Q?UfTl/VLwzZRGB54Ii258s/GZVCdQkhE71ZTqncloGOKG/yeeHJTuki+GHPjK?=
 =?us-ascii?Q?j1e1oYjvynzM5q+j4XZk6PxlsNKOuxAyYfOGoWs41yEWFgX98r3hDNZda6Ma?=
 =?us-ascii?Q?NFL8Rso1WUlwc7hFk42AR0/Ek6hePaBmkn2JqhcM8EGctBvA75sXf6P9aH8M?=
 =?us-ascii?Q?WNNcYic4RcPlSZVPBULXB07+ph7f/5ersJN95DrCkGrNgZFVS9obqGSkUMsh?=
 =?us-ascii?Q?ZZOgbNt1jRc6WVvV30KgShtJzQ1gHuIwcE5btmOvOKqJ6y56xilgri+3VpOC?=
 =?us-ascii?Q?VhU5Br+ZwldIBM0F9cFqTTyRRHy2GePp0tYO+BoffCPNLf3hkjHGjwKBhJSn?=
 =?us-ascii?Q?1W2mJ8FO5B1L/srrWNedtEjVu8cmHf8lhLTBxT6rKZFrwgGkLPSwIXrx/8j8?=
 =?us-ascii?Q?ytkpPYIOuAo3AwzEudc8uZyBMKP8gXWiUdTH2le8aog5WH26bSvnhlQALAR7?=
 =?us-ascii?Q?klSHtXWQ7e2K5jH2JGikbG4MOqNwQ+o9g2ZMWVO9b3xl5u43U3cUgjF5glrN?=
 =?us-ascii?Q?efDKs0+Xb3JipUK7I2/zDu79PNQsn36BcJ3VtdumZGiaXsx/aKzjOIgMoCt7?=
 =?us-ascii?Q?3BT4CQ1CFK08wHiF8Uend+oQiVKRca+umPJam51etwkFuCAI3y2CNKvrMMCD?=
 =?us-ascii?Q?hG8HoNZWwPFJR7zx9ZTMt3L7UKms4P3VQCdZ4iSb2d+P/8id/fPnxjoa43Gm?=
 =?us-ascii?Q?piCikHetuiyHw4O3uL8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97dad6e-c487-456e-a40e-08dbffd48618
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 14:20:45.0635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LxezFffI3mphRys/nwcUZ0krmhbfst5GZWOX9/TCZi3RAYNv8RLqVDon8/NAtI9GkCLSrSIJgXz6WprH0QfzwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6624
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Yes, we can only call gfx/sdma ras late init in aldebaran_mode2_restore_ip,=
 will update.

Regards,
Stanley
> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Monday, December 18, 2023 8:37 PM
> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH Review 1/1] drm/amdgpu: Fix ecc irq enable/disable
> unpaired
>
> [AMD Official Use Only - General]
>
> In such case, can we call amdgpu_gfx_ras_late_init and
> amdgpu_sdma_ras_late_init in aldebaran_mode2_restore_ip?
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: Yang, Stanley <Stanley.Yang@amd.com>
> Sent: Monday, December 18, 2023 17:30
> To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-
> gfx@lists.freedesktop.org
> Subject: RE: [PATCH Review 1/1] drm/amdgpu: Fix ecc irq enable/disable
> unpaired
>
> [AMD Official Use Only - General]
>
> For mode2 reset, only call SDMA/GFX suspend to disable SDMA/GFX ecc_irq,
> driver just need enable SDMA/GFX ecc_irq during resume process.
> Think about below scenario on aqua vanjaram, user modprobe amdgpu with
> reset_method=3D3, driver will do GPU recovery if the SDMA uncorrectable e=
rror
> is triggered, It's difficult to distinguish whether need resume gmc ecc_i=
rq, nbio
> ras_controller_irq, nbio ras_err_event_athub_irq since driver do full gpu
> reset.
>
> Regards,
> Stanley
> > -----Original Message-----
> > From: Zhang, Hawking <Hawking.Zhang@amd.com>
> > Sent: Monday, December 18, 2023 3:03 PM
> > To: Yang, Stanley <Stanley.Yang@amd.com>;
> > amd-gfx@lists.freedesktop.org
> > Cc: Yang, Stanley <Stanley.Yang@amd.com>
> > Subject: RE: [PATCH Review 1/1] drm/amdgpu: Fix ecc irq enable/disable
> > unpaired
> >
> > [AMD Official Use Only - General]
> >
> > Can we put the irq resume in amdgpu_ras_resume?
> >
> > Regards,
> > Hawking
> >
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Stanley.Yang
> > Sent: Saturday, December 16, 2023 00:50
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Yang, Stanley <Stanley.Yang@amd.com>
> > Subject: [PATCH Review 1/1] drm/amdgpu: Fix ecc irq enable/disable
> > unpaired
> >
> > The ecc_irq is disabled while GPU mode2 reset suspending process, but
> > not be enabled during GPU mode2 reset resume process.
> >
> > Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/aldebaran.c  |  6 ++++
> > drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 37
> > +++++++++++++++++++++++++
> > drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
> > drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  3 ++
> > drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  4 +++
> >  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  3 ++
> >  6 files changed, 54 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> > b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> > index 02f4c6f9d4f6..ba9238a93064 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> > @@ -358,6 +358,12 @@ aldebaran_mode2_restore_hwcontext(struct
> > amdgpu_reset_control *reset_ctl,
> >                 /* Resume RAS */
> >                 amdgpu_ras_resume(tmp_adev);
> >
> > +               r =3D amdgpu_ras_late_resume(tmp_adev);
> > +               if (r) {
> > +                       dev_err(tmp_adev->dev, "amdgpu_ras_late_resume
> > failed %d\n", r);
> > +                       goto end;
> > +               }
> > +
> >                 /* Update PSP FW topology after reset */
> >                 if (reset_context->hive &&
> >                     tmp_adev->gmc.xgmi.num_physical_nodes > 1) diff
> > --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > index 8a04fb6c7c1f..318e77c493f2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > @@ -3164,6 +3164,43 @@ int amdgpu_ras_late_init(struct amdgpu_device
> > *adev)
> >         return 0;
> >  }
> >
> > +/* Handle mode 2 reset, resume ecc irq state */ int
> > +amdgpu_ras_late_resume(struct amdgpu_device *adev) {
> > +       struct amdgpu_ras_block_list *node, *tmp;
> > +       struct amdgpu_ras_block_object *obj;
> > +       int r;
> > +
> > +       /* Guest side doesn't need init ras feature */
> > +       if (amdgpu_sriov_vf(adev))
> > +               return 0;
> > +
> > +       list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
> > +               if (!node->ras_obj) {
> > +                       dev_warn(adev->dev, "Warning: abnormal ras list=
 node.\n");
> > +                       continue;
> > +               }
> > +
> > +               obj =3D node->ras_obj;
> > +
> > +               if (!(obj->ras_comm.block =3D=3D AMDGPU_RAS_BLOCK__SDMA=
 ||
> > +                         obj->ras_comm.block =3D=3D AMDGPU_RAS_BLOCK__=
GFX))
> > +                       continue;
> > +
> > +               if (obj->ras_late_init) {
> > +                       r =3D obj->ras_late_init(adev, &obj->ras_comm);
> > +                       if (r) {
> > +                               dev_err(adev->dev, "%s failed to execut=
e ras_late_init!
> > ret:%d\n",
> > +                                       obj->ras_comm.name, r);
> > +                               return r;
> > +                       }
> > +               } else
> > +                       amdgpu_ras_block_late_init_default(adev, &obj->=
ras_comm);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  /* do some fini work before IP fini as dependence */  int
> > amdgpu_ras_pre_fini(struct amdgpu_device *adev)  { diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > index 6a941eb8fb8f..5c1ffc5a6899 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > @@ -693,6 +693,7 @@ amdgpu_ras_error_to_ta(enum
> amdgpu_ras_error_type
> > error) {
> >  /* called in ip_init and ip_fini */
> >  int amdgpu_ras_init(struct amdgpu_device *adev);  int
> > amdgpu_ras_late_init(struct amdgpu_device *adev);
> > +int amdgpu_ras_late_resume(struct amdgpu_device *adev);
> >  int amdgpu_ras_fini(struct amdgpu_device *adev);  int
> > amdgpu_ras_pre_fini(struct amdgpu_device *adev);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > index 09cbca596bb5..b93a0baeb2d3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > @@ -1043,6 +1043,9 @@ static int gmc_v10_0_hw_fini(void *handle)
> >
> >         amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
> >
> > +       if (adev->gmc.ecc_irq.funcs)
> > +               amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
> > +
> >         return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> > index 416f3e4f0438..e633e60850b3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> > @@ -941,6 +941,10 @@ static int gmc_v11_0_hw_fini(void *handle)
> >         }
> >
> >         amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
> > +
> > +       if (adev->gmc.ecc_irq.funcs)
> > +               amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
> > +
> >         gmc_v11_0_gart_disable(adev);
> >
> >         return 0;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > index 205db28a9803..8ac4d5b7fb37 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > @@ -2388,6 +2388,9 @@ static int gmc_v9_0_hw_fini(void *handle)
> >
> >         amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
> >
> > +       if (adev->gmc.ecc_irq.funcs)
> > +               amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
> > +
> >         return 0;
> >  }
> >
> > --
> > 2.25.1
> >
>
>

