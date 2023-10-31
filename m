Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B416CC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 11:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5024610E474;
	Tue, 31 Oct 2023 11:23:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06AF910E474
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 11:23:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUsW9yZSeUIEgqu/uPUPe7AshDuICB7yBnowoA0LtCwIonaOY/oIGk0Fr9aUwXnmed7WN9XKVPGmE/3TPGIHAMO4BiMv9Gi62y8v/tjvKqPyWamMVSNK4sOW0y0JeVq59FLS++UJ42eydD/UC5785kLyyk0rJowlAjbWRLPmz4CP4GMh5/I1XMDHvKeEwgfW0QTVO9I4Fv1al1NyBVHDfOhXNbA5hocV5RV5eGAqZZfTA9RL++PPfUZuDAzkseruC+aAU2iM5yjLFyFtjAVDrDFexn3JEO14w324NfF0E5vIoDZRRvpq8FZPx+Mik3KxvUBXY7DcQEfXM7xbJsOMnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoW1z5bBWMvZMb24hJbD3EYYJVaUUCq+YkcB2ZZWGnA=;
 b=UCaRM98nG+CAtvSCf2cvsl+0gaIM/vK17V99akZvrciA/6kS/3LtuJQzmVATUB/kWWER6ZdSqnj9zJRaoRzJvTqx9PI8BIN9eAvoaMs58BP/CbHU+Y0/4ecSozQpjgI395bvkcEEAaIln1WJ2q/Q9tvesTMN9b6ph711p2xi9whK6R+9NVqaBLzbdU6tQ/D8hR1AIKgUAXfb1AJD9zcqLSL74CEyA2SoxT7/gO6uKMYIkLEsr2ocYVAf8XiLqamAspGVeFn8LIqgCwbYZiHnjnwMPx6ysu2q9GNTcwlgescBbEpZRJr1vBmEbjVJIQve4FoegKWA31QOLg1dxrdkQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoW1z5bBWMvZMb24hJbD3EYYJVaUUCq+YkcB2ZZWGnA=;
 b=SOGx6blf0t79jjsy8BTUOa7rtTkUiSygMbvCIrBojVTc6M3+QmT3EkZlgSNP2mTdbgSrjjLC9Fu9d8F9T6cCBeEpAP7/aQ+AkMW6hlXzANlRqHcljlHlzQLg8VqSAGhoAdlHNXkosYClT7MHePWbkit0P13R0McwYhwQAPFD3Zg=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SN7PR12MB7024.namprd12.prod.outlook.com (2603:10b6:806:26e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 11:23:44 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::fe76:c56e:1243:ba57]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::fe76:c56e:1243:ba57%5]) with mapi id 15.20.6933.026; Tue, 31 Oct 2023
 11:23:44 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: handle extra UE register entries for gfx
 v9_4_3
Thread-Topic: [PATCH] drm/amdgpu: handle extra UE register entries for gfx
 v9_4_3
Thread-Index: AQHaC8kh9NagYIDqM0u7/atL+I5c+bBju9gAgAADvNA=
Date: Tue, 31 Oct 2023 11:23:44 +0000
Message-ID: <PH7PR12MB8796406903024E198EB0E360B0A0A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20231031070843.16461-1-tao.zhou1@amd.com>
 <PH7PR12MB7988ADEFB5BC31503519DD609AA0A@PH7PR12MB7988.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB7988ADEFB5BC31503519DD609AA0A@PH7PR12MB7988.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5ad06575-70ce-4e12-851d-13b02d3ad229;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-31T11:00:34Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SN7PR12MB7024:EE_
x-ms-office365-filtering-correlation-id: b174c249-9eef-42ba-46d7-08dbda03d7a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q5d+89vtF9GPUOg8+3BnSRUzR0sNvw/QwfmjqGkFg/pZ/EH+AvKAhGBRB6OVZdywEbc1zwLbc7r3ESydZpKpayvkIeMhybISfPGoLlt2yQffOYmth51O1e/T9VVPurfVylXhlSmjHA6Uvi8pYpUHdmuxALOuMXh1MKZSEg47hEMgGU3BSq1NfOLjCv9KHMvADyS4FH+ML83OgvCqlb+E3Ptu1MAxciVPFyIQ9s4Ij8A7vtayX6n0d+xWGlCVt5TXSu5rjqnRLQcLMXEbGP9btmMbMi+HLbIeE1zsppU9d9Cm5Ls3wADuvfiolgZT/O7XnQpGs88BPgFo19LB+a/Bk0c5ik4gk7PikwahmBfWspXLm/vWkkejAJUFf8zgYh4hHtkRatUGQlvjL0b0YfHyzCblDIqxJVQDUWmKRNuZpq25aWlF6wWxl6QR5IDj6GVXFDCW4UMGvqswK/4qnjNBuOp9SOuwmoTKnoMANOcblJD+lyH/PatRViws1gzStE9B2k+4ZOyRk/CKLroEwpasIQsKr81sHSSXIaJBIo8sKpFJKacwpoB0Q+L1eGejoOTIVwah/Vwq0k35s/y0Na/8U/924ce0CSMYKccsTm5YJUc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(55016003)(9686003)(26005)(478600001)(71200400001)(7696005)(6506007)(83380400001)(2906002)(110136005)(41300700001)(76116006)(66946007)(66556008)(4326008)(52536014)(53546011)(8676002)(64756008)(316002)(66476007)(5660300002)(66446008)(8936002)(38070700009)(38100700002)(122000001)(86362001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?594Oe24J+9UWsIYLzlsB0w6NBVBEHFGIe1JaCjpGmY5PWh7CpKLWGPVNIXlE?=
 =?us-ascii?Q?O1DIuVA+WbAXESoGJP0J+gZwkCeu59wz2GEulQo7LyTVcDeiCL3JxzxTTUD4?=
 =?us-ascii?Q?hx4CeK88dt1SnvzLgqCT8Y7pvJYTOYqAy4uY/Ug1Ypsob+DiMthsd6+aKxCM?=
 =?us-ascii?Q?2tHruwUO1N0ybJ6cIRqDcs0X+HmjH+1mQZfbm9YDzib4rsVuZGXGRNCPlGDP?=
 =?us-ascii?Q?1ZQxxv2EyIN5B9B0/g3bBuO36IG4KqBDM8cW7jralJ9IXTmNJPOS7zE9xaSX?=
 =?us-ascii?Q?E63xoGNYcPnMBfBHBJxwe6BBJW6w5gxizM/HBuvCN5tOHVOlQimGNz9Mzr2v?=
 =?us-ascii?Q?65H4/ttVX5TYYePqayGm5fuAHxl61yE4QAYIcUiq9fwxIfYU4jamKZlIn4AH?=
 =?us-ascii?Q?XJZenvRfkruN31Il2YjjKvTgv0YCP1rxRa/mG4inZrM8zBWcccknNgmSoAiL?=
 =?us-ascii?Q?NjRKTea4WCXx2jukAx0XXlEyH419qcNoh5qHA2bTG9g/Xe3ZyaHgeFaw904N?=
 =?us-ascii?Q?NxKznmbX6fjf/BiXe4tGXCK7DufMZVGHpxxp20X0XLonNPlc759AyENa0D6a?=
 =?us-ascii?Q?sY2k6ZrZWgZZgYrodajOtVa8QoyWr/yTvUWLHZ0AOXRP1RWwtQHUbbHO5SfU?=
 =?us-ascii?Q?2GRAX31/fadac0muwrgUO0JBX7erMrEty9pYa3eAO1m2tOUyR6SF/ezjqeig?=
 =?us-ascii?Q?px5BTyvGPTs5fncPWcbvgFXUr3lcXJoFprYVLmZyM/EqXD17LxN1fGme/Pjp?=
 =?us-ascii?Q?9Vqn43kWbSwQjLZ3d8q7ZiK+BqOJ3rfLYAdmDpGoHK3sM/pxwd4jnT9OWOxh?=
 =?us-ascii?Q?ZC1rCGh4N24VV/R5RPk47xwUp+zJa6IP6WqB13ORzvP0sfd+zEolFrk6lLWW?=
 =?us-ascii?Q?XlQUvaHn3NfO2QOGpGuvFr5eioR1QjQrziRgJXsX1sx4WUEkUZwVH5iUTALT?=
 =?us-ascii?Q?tJnTP3LLeab4/VsXiseAJiiBnB3HN6GDXx3yI8XxG23bfwS2tNMYgSUCHbc1?=
 =?us-ascii?Q?MGEfOqT0a9vk4nEEemZv/C32azDfTooDkLwefaCRBeOKt0aVBWD6tJUmaRfZ?=
 =?us-ascii?Q?I5WUhbdtAtBvLCFP9JdO0/5JfPAz86R08p4jsOPLFewlknRHrxvNlouMtnX5?=
 =?us-ascii?Q?8Ygg57ky7Qz51vr/mfZrNLWJKwjabFua4Kn3DUKDvI+N2E1cSkyAt0+6S4DL?=
 =?us-ascii?Q?lgQQmnn6y6Hgi5X88yIhZvpJ871EyYThMzSXY6TXLEFcU8VTO6MIYyxda0Xn?=
 =?us-ascii?Q?rWAsyOCr1/HaNvuBDaS7Q0Z3KHWWWEi7knibr2azJPNrSQo04XjfXWpCycop?=
 =?us-ascii?Q?R2eF5o9PIV4Jd4h9Ts9hc5YgyuMCHtnvIWyEyIMntffLVRQMcZsiTjs43Nxx?=
 =?us-ascii?Q?9wYGSH1zwpIyGE9K4NMjdUd8Ey7fGqixpFdz0+p8db6Wj7WE6rhBaxyDU7OZ?=
 =?us-ascii?Q?uMgyNbB+U8Oc+PbByRWnNVJIBh5Y9MDgWqTRD2ASTu3/NLOxvS02ZwzY1md/?=
 =?us-ascii?Q?TOvdAQQ1W7xb+2JFBsXE9ySdTt3QPOMw9YQ47G2rEn8PuuVTuzS7abDulPtB?=
 =?us-ascii?Q?W7sr16MEMLf7nMvAkBU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b174c249-9eef-42ba-46d7-08dbda03d7a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 11:23:44.0233 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l9WmW9QYViAgNs35ZicZlplzZtKxop/wrhdn77QlVNwmGQKT2NcSBkJPvzFTHY3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7024
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

In fact, the UE list has only one extra entry compared with CE list.
The code structure of handling CE and UE list one by one is more simple. Th=
e current approach has less loop cycles, either way is fine to me.

Regards,
Tao

> -----Original Message-----
> From: Yang, Stanley <Stanley.Yang@amd.com>
> Sent: Tuesday, October 31, 2023 7:02 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: handle extra UE register entries for gfx
> v9_4_3
>
> [AMD Official Use Only - General]
>
> Is it better to handle CE and UE list separately?
> Anyway Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>
>
> Regards,
> Stanley
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao
> > Zhou
> > Sent: Tuesday, October 31, 2023 3:09 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>
> > Subject: [PATCH] drm/amdgpu: handle extra UE register entries for gfx
> > v9_4_3
> >
> > The UE registe list is larger than CE list.
> >
> > Reported-by: yipeng.chai@amd.com
> > Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 38
> > +++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > index 41bbabd9ad4d..046ae95b366a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > @@ -3799,6 +3799,27 @@ static void
> > gfx_v9_4_3_inst_query_ras_err_count(struct amdgpu_device *adev,
> >               }
> >       }
> >
> > +     /* handle extra register entries of UE */
> > +     for (; i < ARRAY_SIZE(gfx_v9_4_3_ue_reg_list); i++) {
> > +             for (j =3D 0; j < gfx_v9_4_3_ue_reg_list[i].se_num; j++) =
{
> > +                     for (k =3D 0; k <
> > gfx_v9_4_3_ue_reg_list[i].reg_entry.reg_inst; k++) {
> > +                             /* no need to select if instance number i=
s 1 */
> > +                             if (gfx_v9_4_3_ue_reg_list[i].se_num > 1
> > + ||
> > +
> >       gfx_v9_4_3_ue_reg_list[i].reg_entry.reg_inst > 1)
> > +
> > + gfx_v9_4_3_xcc_select_se_sh(adev, j,
> > 0, k, xcc_id);
> > +
> > +
> >       amdgpu_ras_inst_query_ras_error_count(adev,
> > +
> >       &(gfx_v9_4_3_ue_reg_list[i].reg_entry),
> > +                                     1,
> > +
> >       gfx_v9_4_3_ras_mem_list_array[gfx_v9_4_3_ue_reg_list[i].mem_id_t
> > ype].mem_id_ent,
> > +
> >       gfx_v9_4_3_ras_mem_list_array[gfx_v9_4_3_ue_reg_list[i].mem_id_t
> > ype].size,
> > +                                     GET_INST(GC, xcc_id),
> > +
> >       AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
> > +                                     &ue_count);
> > +                     }
> > +             }
> > +     }
> > +
> >       gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xfffff=
fff,
> >                       xcc_id);
> >       mutex_unlock(&adev->grbm_idx_mutex);
> > @@ -3838,6 +3859,23 @@ static void
> > gfx_v9_4_3_inst_reset_ras_err_count(struct amdgpu_device *adev,
> >               }
> >       }
> >
> > +     /* handle extra register entries of UE */
> > +     for (; i < ARRAY_SIZE(gfx_v9_4_3_ue_reg_list); i++) {
> > +             for (j =3D 0; j < gfx_v9_4_3_ue_reg_list[i].se_num; j++) =
{
> > +                     for (k =3D 0; k <
> > gfx_v9_4_3_ue_reg_list[i].reg_entry.reg_inst; k++) {
> > +                             /* no need to select if instance number i=
s 1 */
> > +                             if (gfx_v9_4_3_ue_reg_list[i].se_num > 1
> > + ||
> > +
> >       gfx_v9_4_3_ue_reg_list[i].reg_entry.reg_inst > 1)
> > +
> > + gfx_v9_4_3_xcc_select_se_sh(adev, j,
> > 0, k, xcc_id);
> > +
> > +
> >       amdgpu_ras_inst_reset_ras_error_count(adev,
> > +
> >       &(gfx_v9_4_3_ue_reg_list[i].reg_entry),
> > +                                     1,
> > +                                     GET_INST(GC, xcc_id));
> > +                     }
> > +             }
> > +     }
> > +
> >       gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xfffff=
fff,
> >                       xcc_id);
> >       mutex_unlock(&adev->grbm_idx_mutex);
> > --
> > 2.35.1
>

