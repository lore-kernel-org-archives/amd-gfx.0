Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B85C46CD3
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Dec 2023 18:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C1D110E29C;
	Mon, 18 Dec 2023 18:20:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0D0310E28E
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Dec 2023 18:20:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfMxFTlK2LSyB6jkHEkRgSjWemHjfz1bnILOpZU7xbN+mKMA9lOQS7WjJz5OUIQjm5bXjXX6LJpU8DWhJik7zZ/F4aJmZRGU1Hpg4nUWbKf6zETxNhUVizUEOc9aFP/QqwROT8qF7b3x+V7TKAeYBNWynOa8TB0nCNl/JME+Z0mQBS5HiADa89h1riShZAtDJ34BnUXsEiC/aj3qGRq70UL7eBmmXfQdgqeMkTh84HgUoJU06phaeLNtFh/YldTJh1KLFfAtyBdYcrpiHlmZgrEizLddUbAXx/x/S5+u9wQHs6ehiGPJ9Aguo4m9zumVO72Re+M33AgSt1oNj++trw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYgkYDdXQFJYojBH84juZ8HD9wO1tWhUzNj/PjwnZ0U=;
 b=MVIPBtkSqcVBKnGfKXmPv2x/s+RZPA3NJSXBkuthUltTgSBFmwrll6IkmblIXcqabThwJtlsel4pkH6o/U5R0UWU80ncQ/ymSUkaHKhr/pqPBW5jo6+uYnA73IvMopt1Rz4VZEi6pYTlwyRV+sU1dLQ469TpWZJVRTmmlvUzkC2JLJwTCk3ZH0NhLfrBhk57J4x6qCyEPMxzDluf7VAhXeFYaQZpIeKPVhT2iFbL+j5f9/d0AvupKjc1OuOXHh1PAl40yDAn9wvdxmn+57ZKsr69gXb8WCM1N4vLZjMhtil/s7th1G3YoH1LQtwHmiyzsKYWYky/Wp9CBTQHnORn3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYgkYDdXQFJYojBH84juZ8HD9wO1tWhUzNj/PjwnZ0U=;
 b=tfc/X8Kd6+P5U81a4k4hGWzON5B7HOBloMhwZlrj1kWPL+SrCO3YuSXua0cDhzyFYraj+YbTIZ8EYBQswIOxTZkN81LRQsd7nFdmAYTsfj+DwjVWrOkxEFu1fHTXz7qU7dmnWuR8PSbP0uzMvaBVcNHSuPVDVLqBKc9Xr6aAUy0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by LV8PR12MB9335.namprd12.prod.outlook.com (2603:10b6:408:1fc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 12:37:09 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 12:37:09 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Fix ecc irq enable/disable unpaired
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: Fix ecc irq enable/disable
 unpaired
Thread-Index: AQHaL3bQnlofGxcWqUO57M5Dij3/kbCuoUrwgAApXwCAADOkUA==
Date: Mon, 18 Dec 2023 12:37:09 +0000
Message-ID: <BN9PR12MB5257777C2BBB262B1EC2CAA1FC90A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231215164952.449464-1-Stanley.Yang@amd.com>
 <BN9PR12MB525719E4C88CFB696CEC22BDFC90A@BN9PR12MB5257.namprd12.prod.outlook.com>
 <PH7PR12MB798809C2517604E5CADE7D889A90A@PH7PR12MB7988.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB798809C2517604E5CADE7D889A90A@PH7PR12MB7988.namprd12.prod.outlook.com>
Accept-Language: en-US
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
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|LV8PR12MB9335:EE_
x-ms-office365-filtering-correlation-id: 94bac6d7-bdfb-4f66-3265-08dbffc60d3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LJONn0CGq444NnZBssGJ7E+qQRye/uRSa1sJUGR5uT6CTHr6zfkHqmTrk/XQq1qIcpe6n5j2v4Czz7zsM8Xbp7fOJQiOV0gQCMDTWnmPXm2MykXQvdYF+RmkPA4SxVtTFkhJzPvOFEj8im7mfO6oqnpUrA6sz0S4zzwfJTy02EKnff5TCHJpzDhU8YppDqJvy0UHDLEMiXm0v8O+aJjmH3o6buOoJXUue1fQmPtDDd7lT1gevfh7VjKB7jFOwGrft8tF0Me3K6TE8WtiLDbVpJ0L1dXfog9xDHVjKJmSmVpBbHCcSUColRVb/ECphSDm7F+wjuWt06YFMUjnwZEmrCDxlqv5/c+zIcWt/tx2dzhVZ2CcI8X+4+UY6RbSELeGv7tcpr98QGKgqaeaZQq6ZXRC4id5/buXeEXWxHT6dDEF7v2cQPqqhUpPxh446TP87DGXQzu3MxS3W607KN2G62upTgINGfnVpSfkK7BmhlWdPtjLDOzu1hdrzJAh5ygCHB1lLFxBw468suxHlP79CZFlL1ci/SGKy7XtyBIwp4kPzekaVzOyXRlNa3hMCf7/LTgV58m19pA6tUTlKVsdiTIjvXQrgIbzgWvUgyNU+34/0Vp1KobBJ8eFNOS509DXFHki+AhvA9vYGtFuPF/9y6T3Y52Ga2J1TZ6NL+mrAG8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(26005)(71200400001)(7696005)(6506007)(53546011)(9686003)(5660300002)(83380400001)(478600001)(2906002)(8676002)(8936002)(110136005)(66446008)(76116006)(64756008)(66476007)(66556008)(66946007)(316002)(52536014)(41300700001)(122000001)(38100700002)(38070700009)(33656002)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MvEt6ZCIsfSZWczoSmmLqA30/quqRuaXWlJ9ibIOS1Q5nKATVG2M9PT5JvxC?=
 =?us-ascii?Q?fIYWJsXTccy20PYt8da4p0s5RUVMUXLYBje4JqLNM/Q+cZRb4unifrQL5v/I?=
 =?us-ascii?Q?PUIiwfLsvf053qBf3XUM26oebt0HAKKYnlcn9wyeomr6Gux9XbJfZKhMvatc?=
 =?us-ascii?Q?8OzlnPoyJjEUOBMa2buCWGYG5kl7Fx3DV0SaFy38CPIG20oBjkCrlEmsWNIo?=
 =?us-ascii?Q?pNEhyrGisWUrg3VTcHR+xbUtfiWzZDJ+ceY94stUwP4iAgcN2g1+PlZwX1uw?=
 =?us-ascii?Q?eiync/I1GF2TAJAIBQ8QudmevXHiES2g5uyufEBwViuNUVWlWqI9mws1EXHC?=
 =?us-ascii?Q?KATSZq/XOKfR5M3qA/ZHK7mXrKO0xJLrxOMncsm5v18R1UBTj9kp1KWXSzX7?=
 =?us-ascii?Q?X2KfcUXdNDiKBA9MALOdZ63yFigVu5uQXoD+/vrjjufvhOGy9q0TRaeg2IeC?=
 =?us-ascii?Q?IelW/baVRDTGokBwlG+AoaejzTODCk03yyNflKZyCuqp6kQJTNVpJBCRB5tb?=
 =?us-ascii?Q?gYmJAvbuoLmNOvooeMbZx9hTKmBa3/9V3Au8HfL8a6zptTB4Nvb3Z3A+iClb?=
 =?us-ascii?Q?5qNX05hbb1rvd/zP7B9WCXd5Vjvnh6gby7IND0miNcbo/fEOXJKEjmaM3SPQ?=
 =?us-ascii?Q?agCSVT0aDLv1nPaEcln6Hl6tq84mAx6z2LIfw/PIaakunpIoTtiPWkvq1XOj?=
 =?us-ascii?Q?BAdIe5Pbxm0zvFXQvZqs1XU2s/Bh8t6aZxChLPsgxnY2jvP80UW56nppUd5s?=
 =?us-ascii?Q?hs1Z/Tdd9Ql3ZYKo4oqbU1JxUkJoF8RZmQJjYBuW4P01BCyjPIMQ15zs+wyW?=
 =?us-ascii?Q?VCdmU17L+HIx+3yC8Gt3Xl22zGsXCJwKTm2SEQse577eAltJbFZsaP6KNp9i?=
 =?us-ascii?Q?/u10y6i8+OLomv++RYO8qCz0GDn+DToD2kAsKJoaXganQNAufedotf7Pm4kL?=
 =?us-ascii?Q?GSLw6Nsyb4gCgIkRir1W8afqo8M3E3W8chFRKPbEeXDHBVs3zFmO/6IXDnek?=
 =?us-ascii?Q?1q8WsMzCh01m/GBHwUXyam+Tr/X+Vmo539TUzUQPOKX/4eV1u/nd5T1rqZPS?=
 =?us-ascii?Q?MmfShuWWGIl3FcPkncdRVMqNotOctvEEK7TvT4D2qLBVEitRkfiGTFRBveDx?=
 =?us-ascii?Q?EyolPG98ek4VGv8tMdV3QmbAYTDSUR09pWmyO1JwLU69D0XjMuSSEFLul8Hv?=
 =?us-ascii?Q?kXRqqd1eINjq9GzgSeLKfKfds/kaY64B6rjgla889CJM3X4gIUHRULWiu0pS?=
 =?us-ascii?Q?M0JA63gj9v5q8co+Le7YN2fwifCH+VBKgxd0wkedE/Z2o2HUNmvQBADSWFZG?=
 =?us-ascii?Q?0l7iw7V2yB+4kGgf9AJ7GryjwF+UGZdUXMMiHZ7CjVwuNMLqj8vYACmcgTAF?=
 =?us-ascii?Q?Rz8bFXrpYW9k7rwyxhJkfZrEwzF7sNf+wZOa4bCeMrUWmKH9NoJxkP1yF+eo?=
 =?us-ascii?Q?i8CqAO5CMyli6jwkTPGGLHXxRXq/WZrWIOXLfKIj0u44rP2/vFi+SFxqmO/Z?=
 =?us-ascii?Q?owS90r8HSTqZEELgiQTJvHf/QFtWcEfdRGo+BhPuhanMzoRFNSKT/3uuvYG4?=
 =?us-ascii?Q?AIs8oQZd7ucNt5Kr9pQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bac6d7-bdfb-4f66-3265-08dbffc60d3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 12:37:09.3647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yxn3h5GzV7zLgNcdpi3A3bXOLDkF7j7iT/UtZA69BCv3rct7U3qrwMo65mq5JmKGNv1yMIbWePvjmoyO8ymBeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9335
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

In such case, can we call amdgpu_gfx_ras_late_init and amdgpu_sdma_ras_late=
_init in aldebaran_mode2_restore_ip?

Regards,
Hawking

-----Original Message-----
From: Yang, Stanley <Stanley.Yang@amd.com>
Sent: Monday, December 18, 2023 17:30
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Fix ecc irq enable/disable unpa=
ired

[AMD Official Use Only - General]

For mode2 reset, only call SDMA/GFX suspend to disable SDMA/GFX ecc_irq, dr=
iver just need enable SDMA/GFX ecc_irq during resume process.
Think about below scenario on aqua vanjaram, user modprobe amdgpu with rese=
t_method=3D3, driver will do GPU recovery if the SDMA uncorrectable error i=
s triggered, It's difficult to distinguish whether need resume gmc ecc_irq,=
 nbio ras_controller_irq, nbio ras_err_event_athub_irq since driver do full=
 gpu reset.

Regards,
Stanley
> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Monday, December 18, 2023 3:03 PM
> To: Yang, Stanley <Stanley.Yang@amd.com>;
> amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH Review 1/1] drm/amdgpu: Fix ecc irq enable/disable
> unpaired
>
> [AMD Official Use Only - General]
>
> Can we put the irq resume in amdgpu_ras_resume?
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Stanley.Yang
> Sent: Saturday, December 16, 2023 00:50
> To: amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: Fix ecc irq enable/disable
> unpaired
>
> The ecc_irq is disabled while GPU mode2 reset suspending process, but
> not be enabled during GPU mode2 reset resume process.
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/aldebaran.c  |  6 ++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 37
> +++++++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
> drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  3 ++
> drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  4 +++
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  3 ++
>  6 files changed, 54 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> index 02f4c6f9d4f6..ba9238a93064 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> @@ -358,6 +358,12 @@ aldebaran_mode2_restore_hwcontext(struct
> amdgpu_reset_control *reset_ctl,
>                 /* Resume RAS */
>                 amdgpu_ras_resume(tmp_adev);
>
> +               r =3D amdgpu_ras_late_resume(tmp_adev);
> +               if (r) {
> +                       dev_err(tmp_adev->dev, "amdgpu_ras_late_resume
> failed %d\n", r);
> +                       goto end;
> +               }
> +
>                 /* Update PSP FW topology after reset */
>                 if (reset_context->hive &&
>                     tmp_adev->gmc.xgmi.num_physical_nodes > 1) diff
> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 8a04fb6c7c1f..318e77c493f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3164,6 +3164,43 @@ int amdgpu_ras_late_init(struct amdgpu_device
> *adev)
>         return 0;
>  }
>
> +/* Handle mode 2 reset, resume ecc irq state */ int
> +amdgpu_ras_late_resume(struct amdgpu_device *adev) {
> +       struct amdgpu_ras_block_list *node, *tmp;
> +       struct amdgpu_ras_block_object *obj;
> +       int r;
> +
> +       /* Guest side doesn't need init ras feature */
> +       if (amdgpu_sriov_vf(adev))
> +               return 0;
> +
> +       list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
> +               if (!node->ras_obj) {
> +                       dev_warn(adev->dev, "Warning: abnormal ras list n=
ode.\n");
> +                       continue;
> +               }
> +
> +               obj =3D node->ras_obj;
> +
> +               if (!(obj->ras_comm.block =3D=3D AMDGPU_RAS_BLOCK__SDMA |=
|
> +                         obj->ras_comm.block =3D=3D AMDGPU_RAS_BLOCK__GF=
X))
> +                       continue;
> +
> +               if (obj->ras_late_init) {
> +                       r =3D obj->ras_late_init(adev, &obj->ras_comm);
> +                       if (r) {
> +                               dev_err(adev->dev, "%s failed to execute =
ras_late_init!
> ret:%d\n",
> +                                       obj->ras_comm.name, r);
> +                               return r;
> +                       }
> +               } else
> +                       amdgpu_ras_block_late_init_default(adev, &obj->ra=
s_comm);
> +       }
> +
> +       return 0;
> +}
> +
>  /* do some fini work before IP fini as dependence */  int
> amdgpu_ras_pre_fini(struct amdgpu_device *adev)  { diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 6a941eb8fb8f..5c1ffc5a6899 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -693,6 +693,7 @@ amdgpu_ras_error_to_ta(enum amdgpu_ras_error_type
> error) {
>  /* called in ip_init and ip_fini */
>  int amdgpu_ras_init(struct amdgpu_device *adev);  int
> amdgpu_ras_late_init(struct amdgpu_device *adev);
> +int amdgpu_ras_late_resume(struct amdgpu_device *adev);
>  int amdgpu_ras_fini(struct amdgpu_device *adev);  int
> amdgpu_ras_pre_fini(struct amdgpu_device *adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 09cbca596bb5..b93a0baeb2d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -1043,6 +1043,9 @@ static int gmc_v10_0_hw_fini(void *handle)
>
>         amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
>
> +       if (adev->gmc.ecc_irq.funcs)
> +               amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
> +
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 416f3e4f0438..e633e60850b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -941,6 +941,10 @@ static int gmc_v11_0_hw_fini(void *handle)
>         }
>
>         amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
> +
> +       if (adev->gmc.ecc_irq.funcs)
> +               amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
> +
>         gmc_v11_0_gart_disable(adev);
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 205db28a9803..8ac4d5b7fb37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2388,6 +2388,9 @@ static int gmc_v9_0_hw_fini(void *handle)
>
>         amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
>
> +       if (adev->gmc.ecc_irq.funcs)
> +               amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
> +
>         return 0;
>  }
>
> --
> 2.25.1
>


