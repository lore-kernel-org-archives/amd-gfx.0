Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D46C77B7C
	for <amd-gfx@archiver.kernel.org>; Fri, 12 May 2023 01:20:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A78DB10E096;
	Fri, 12 May 2023 01:20:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A2AB10E096
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 01:20:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ees9LQAyTwYKPe8tJiYZIzd64o710znfcodZScUJGTrlyGnkeJ7hdTptITyxSkR8z9F8Xm6jsLL4YQ4qYB3vcOHHopl0c4ksd0QoDnteaiO+Q40UkbIRL1+Ne4NblF8IZpV+ZgwWePjQjcPYVwOa0fxjnaSzEI3E5kP42UO883EbRHtGkmz0ar3NZCXTfm1KmdUFstxYKC4uKp72zYG82Nh0u0gRNPXzNSm8xRWJfIdWjYsuJxtWwJa7UWmKHYBbQZkDWdB2R8xdVcuTNvUUflmDWvhVC3h3FndgjALclJ4UX5I1GydRm8SNjnor4HJ21eS5I9FEsgdM9L10mio9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LZLw62TuYDs6di8pYT0JpRELoqdx7cnl+IKqdXrWIk=;
 b=hvWv8kQYXB0IBqy94Uh8YXnzL9TbWJl5ZXlA7suD2DhgRfD2C+LeSyHDptXacLlLXTBZ7z4ucXSxy35TAmW6L73ZCbJqZAL+iCm9/2f0C39BB+BDLTsJRJ3UDL16b7KBmzBwPqJLx7xQ14+nLhvuAJ8mlDrblIsCD3XnMk96NwiawGHfiWtmLPkwQ7iVzC95YXMkquvQHeVmDMJlpNAcW7hzEi6CTt9iW7qiXYr+XQiOKNTYJUfFidqmMoeTjBCdJKScK/PrG3I1j8fiRSAghMdZBIDmJWk1K2zKlIa/CwPvUgBixh29v/fo5wgnlHQaftz30t9998Ovf7L9jW/Kxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LZLw62TuYDs6di8pYT0JpRELoqdx7cnl+IKqdXrWIk=;
 b=Gwh/fxfqRHVRHiogz262xMAEXtGn18JclR/myLoHCV56ipcKQDkoepFGaBXonCyMYQKAgsmWpTMWBKpvYtjEK1bmFn+Ayrwd/iNrc0kvCcMWVbW7/Dvt7wvLiIWylQ8AMecaY0TDNGYO9F/k2Tzxq8/nrdZqrfSFuUUtypRojqA=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by BL0PR12MB4916.namprd12.prod.outlook.com (2603:10b6:208:1ce::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Fri, 12 May
 2023 01:20:17 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::a619:b94c:f2d7:26a3]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::a619:b94c:f2d7:26a3%3]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 01:20:17 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan"
 <Evan.Quan@amd.com>, "Wang, Chester" <shansheng.wang@amd.com>
Subject: drm/amdgpu: Differentiate between Raven2 and Raven/Picasso according
 to revision id.
Thread-Topic: drm/amdgpu: Differentiate between Raven2 and Raven/Picasso
 according to revision id.
Thread-Index: AdmEb+gL1/In7di/QSyIA1p4r67D/g==
Date: Fri, 12 May 2023 01:20:17 +0000
Message-ID: <DM4PR12MB5152E2B7372CFB31CAA0F546E3759@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-12T01:20:15Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=98d39b11-35ef-4a8b-980f-c9b98bb353d5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-05-12T01:20:15Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 337adecd-fcc4-4f05-981d-56086fafb49f
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|BL0PR12MB4916:EE_
x-ms-office365-filtering-correlation-id: 3d4945a3-2482-4d25-f059-08db52870be9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TIm5hwToZoKL4kzkz0UX63W9Cn6cAz2Jo8/2ELyIEKQzKcXC/m3qR6tIfSXrJiEw7yhsn4GjZth6rEGJq7wFh89JJJzHt+JR5648aAHvp/Qav5+j6WxbEezk+2r/xSWdr/3jC2e4pURDWbnTGBxXlRxRolq/GB2IaQLGru7/VPLPBzIv+dQYY1rbuOcq5FAp+x96aIv4qZJ8otenWI2VZkWYAhoA1sWljNT3HAXDRrPBPfGsTaUhUiTrc9QkYJG/xoDdlzecOF+3OiyTu6Zr887ZQLPTnqmSHvhm3sPV3/DaGMuoGYYLmwfRcMKn1Fy2C9j1OFiX8Q4NRVgqhz45zBNkjZlq+3IoIXH2ks79ibbmoFslevNVfd0FwSc1jwa33YhOtWo4NdZM1n/TiEnXcrctswsxJ5kIM03HGvU/Qrt9/rtYy329BmreqKXHpPj+dVSvdw8DQMSK6dyjwbyN4ZK2TTP1ymsyKSpL+ycrlcCXjSxR8M22Ho0FKIgziXvmwlh+0JBjRmk6cjUhbfOH83q9FjLE4DySyLQlKegV5pdPQ/NpJaAdsHhnup2okW+xWtnny5PHLxRHzh6ap1/S7/A1FLFI4cTwswZwgYKk67ROZDnNhbPLCB3Gdi8PFK2I
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199021)(122000001)(38100700002)(38070700005)(33656002)(86362001)(9686003)(8936002)(8676002)(7696005)(478600001)(6506007)(26005)(5660300002)(52536014)(55016003)(66946007)(64756008)(4326008)(6636002)(186003)(2906002)(316002)(83380400001)(66556008)(71200400001)(110136005)(66446008)(76116006)(66476007)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wRq1QHcpbUQZHJiUWKI+88ESaxstma/v8FjN/IvBB65W94iC3eKo5Jvz7e/x?=
 =?us-ascii?Q?iQUnYTpui+0iw1gkSkM7tXYUW/qz23iNW3S8SN3QZrFnhk2CyOxkb3P+3LHY?=
 =?us-ascii?Q?OE66Tz9MXqjVuvghNcTXEJqLzRw9pGOwVL//LoWfOLfznlgPUr/U63JxitjC?=
 =?us-ascii?Q?P/2bLrsWmZZBYOZNiOXIf5b8JUgb2ZE2JzEo8KQIduGQxPNqwou2P+O9iBtO?=
 =?us-ascii?Q?o3XhglCnKdtu4QXkGASw62WEpf47D2fMiwNUdrb22Ws5SlHml/SAROt89TG1?=
 =?us-ascii?Q?qgraE0wulW38tOdAuyHk84NpKskBcdVuYSzKeCrJ0tn97a3GWD24f+x96PIi?=
 =?us-ascii?Q?nFr8ndNRx/D0DW83yV1S1ZeLePsUDhbn+gVm59vnlYg6Hgs04jnEYBgwtqTS?=
 =?us-ascii?Q?duKkMeQgiBoYLjgoobQXGlWvAd6gpi3dAPUddM+2UpBJDikHp+AuTnSJgPQq?=
 =?us-ascii?Q?HvhAS9gP2lKVZ8x7uMKxXZ95ObesQG9S9rxWRhrmSVpwbaIGalu/L2KD5+aH?=
 =?us-ascii?Q?KAiIFxxG4k1vgT/9FEa69pYwU1zcbhj0VrYVVA6A9TOGH0TLRPlTrNlWp4TZ?=
 =?us-ascii?Q?tv32Yv2FXqAEkGaTB4jTU3woREx/IY1TRcvOUKmVcYN4QMFdEihtJ9UyPkJ9?=
 =?us-ascii?Q?qHovdPxP6urqEpuxqgjNUJmuTUnhumxd+EcdT4oFovKZPpcZuDFIleTq86k/?=
 =?us-ascii?Q?HY+Df/Mol5fCvsdz9PvduMFyd4jhIU9r40LepsuJB59YItokmgZ2SYIemAc7?=
 =?us-ascii?Q?UWUCJ/LpJJf+pfKDRD1yItqFFwYLG2kbIeDLSysepb25RAETYpr3MsNd5CXO?=
 =?us-ascii?Q?mBzR0mVjgMTNV/9yl6DCxHmWR28jOWnG66oLB53c+L1ViWwRYXqdfYxFpXet?=
 =?us-ascii?Q?lxt3cikxQxJ/D9tAhWmOaRuJKfSG2H7kgm/aefDQFl/kyCbMlfbVnPKdklKE?=
 =?us-ascii?Q?Bj+2K9KwcsUj7irEjbY/yPE8kBm+mDF3DBzlo7vzXwDUE36Sg7C5crOTt2Dt?=
 =?us-ascii?Q?6kee4ygV3p2zCAz0VFQ+o9R7PVQK2E/1bEZER4ZAgRY62qAHcIyOk9T8IFTR?=
 =?us-ascii?Q?uYNDG7LXO6U6eblIKbT3/4py8QK6KOlazOQ7awDEJrUvSNTvE7CCWEWP33N6?=
 =?us-ascii?Q?8RypslfxdClmAv67HghQBANWC+VMFij8fYASnNqlKmAAW4NNXcObYDxhW1Po?=
 =?us-ascii?Q?+Ye11hmMLT6lCzdsCUuEKrmQC72hxli/Zp10sKJEzPD1YdyEdUzPQK4Cns5/?=
 =?us-ascii?Q?9Wxodys6AhxkbQ6YLu3SEG2GBZ0YLLucP23IAIfQksDmpjGM0K//x9fm2GFg?=
 =?us-ascii?Q?aZxE5EJUNc5VBpFoInAmqJhfrf9Dk8IFVTmd1tk1D2XGFbMglEwBWL72JXvh?=
 =?us-ascii?Q?P/T45tsHTtV0sO1UMXBelH7xTJ7v72MLx9aYG/AiPmQt7hrNcQJsc+0QSjQd?=
 =?us-ascii?Q?lKePD6rviNSqA7TtqooQYW2BH3vyU9bRo6NrEh68+HLvejREchdmh6PmU5OG?=
 =?us-ascii?Q?Gv+ia5oZK/RAVwqGEJGuYpRs/vpFlkepLM7mUlJY5A+qOyBcYe1BP3gWMA16?=
 =?us-ascii?Q?X6m5Nf50TV41Nhz/IgA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5152E2B7372CFB31CAA0F546E3759DM4PR12MB5152namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4945a3-2482-4d25-f059-08db52870be9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 01:20:17.6783 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: veOgHMgqEk4k/FkrLeW7IccdRfGYpq9HX4dspikGE9EBrSaqEloq4CVWUMnYTme5CYY+OzDCxnDK+t8AxyDE6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4916
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB5152E2B7372CFB31CAA0F546E3759DM4PR12MB5152namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]


drm/amdgpu: Differentiate between Raven2 and Raven/Picasso according to rev=
ision id.



    Due to the raven2 and raven/picasso maybe have the same GC_HWIP version=
.

    So differentiate them by revision id.



    Signed-off-by: shanshengwang <shansheng.wang@amd.com<mailto:shansheng.w=
ang@amd.com>>

    Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com<mailto:Jesse.Zhang@amd.=
com>>



diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c

index e093e83ae739..1f4edfb96636 100644

--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c

+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c

@@ -4000,30 +4000,27 @@ static uint64_t gfx_v9_0_get_gpu_clock_counter(stru=
ct amdgpu_device *adev)

                clock =3D clock_lo | (clock_hi << 32ULL);

                break;

        case IP_VERSION(9, 1, 0):

+       case IP_VERSION(9, 2, 2):

                preempt_disable();

-               clock_hi =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT=
_UPPER_Raven);

-               clock_lo =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT=
_LOWER_Raven);

-               hi_check =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT=
_UPPER_Raven);

-               /* The PWR TSC clock frequency is 100MHz, which sets 32-bit=
 carry over

-                * roughly every 42 seconds.

-                */

-               if (hi_check !=3D clock_hi) {

+               if (adev->rev_id >=3D 0x8)

+               {

+                       clock_hi =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_T=
SC_COUNT_UPPER_Raven2);

+                       clock_lo =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_T=
SC_COUNT_LOWER_Raven2);

+                       hi_check =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_T=
SC_COUNT_UPPER_Raven2);

+               }else{

+                       clock_hi =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_T=
SC_COUNT_UPPER_Raven);

                        clock_lo =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_T=
SC_COUNT_LOWER_Raven);

-                       clock_hi =3D hi_check;

+                       hi_check =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_T=
SC_COUNT_UPPER_Raven);

                }

-               preempt_enable();

-               clock =3D clock_lo | (clock_hi << 32ULL);

-               break;

-       case IP_VERSION(9, 2, 2):

-               preempt_disable();

-               clock_hi =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT=
_UPPER_Raven2);

-               clock_lo =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT=
_LOWER_Raven2);

-               hi_check =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT=
_UPPER_Raven2);

                /* The PWR TSC clock frequency is 100MHz, which sets 32-bit=
 carry over

-                * roughly every 42 seconds.

-                */

+               * roughly every 42 seconds.

+               */

                if (hi_check !=3D clock_hi) {

-                       clock_lo =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_T=
SC_COUNT_LOWER_Raven2);

+                       if (adev->rev_id >=3D 0x8) {

+                               clock_lo =3D RREG32_SOC15_NO_KIQ(PWR, 0, mm=
GOLDEN_TSC_COUNT_LOWER_Raven2);

+                       }else{

+                               clock_lo =3D RREG32_SOC15_NO_KIQ(PWR, 0, mm=
GOLDEN_TSC_COUNT_LOWER_Raven);

+                       }

                        clock_hi =3D hi_check;

                }

                preempt_enable();


--_000_DM4PR12MB5152E2B7372CFB31CAA0F546E3759DM4PR12MB5152namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p class=3D"msipheaderdf3d92d6" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0000FF">[AMD Official Use O=
nly - General]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"xmsonormal">drm/amdgpu: Differentiate between Raven2 and Raven/=
Picasso according to revision id.<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp; Due to the raven2 and raven/pica=
sso maybe have the same GC_HWIP version.<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp; So differentiate them by revisio=
n id.<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp; Signed-off-by: shanshengwang &lt=
;<a href=3D"mailto:shansheng.wang@amd.com">shansheng.wang@amd.com</a>&gt;<o=
:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp; Signed-off-by: Jesse Zhang &lt;<=
a href=3D"mailto:Jesse.Zhang@amd.com">Jesse.Zhang@amd.com</a>&gt;<o:p></o:p=
></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c =
b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<o:p></o:p></p>
<p class=3D"xmsonormal">index e093e83ae739..1f4edfb96636 100644<o:p></o:p><=
/p>
<p class=3D"xmsonormal">--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<o:p></o=
:p></p>
<p class=3D"xmsonormal">+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<o:p></o=
:p></p>
<p class=3D"xmsonormal">@@ -4000,30 +4000,27 @@ static uint64_t gfx_v9_0_ge=
t_gpu_clock_counter(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock =3D clock_lo | (clock_hi &lt;=
&lt; 32ULL);<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_=
VERSION(9, 1, 0):<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSI=
ON(9, 2, 2):<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; preempt_disable();<o:p></o:p></p>
<p class=3D"xmsonormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock_hi =3D RREG32_SOC15_NO_KIQ(PWR, 0,=
 mmGOLDEN_TSC_COUNT_UPPER_Raven);<o:p></o:p></p>
<p class=3D"xmsonormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock_lo =3D RREG32_SOC15_NO_KIQ(PWR, 0,=
 mmGOLDEN_TSC_COUNT_LOWER_Raven);<o:p></o:p></p>
<p class=3D"xmsonormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hi_check =3D RREG32_SOC15_NO_KIQ(PWR, 0,=
 mmGOLDEN_TSC_COUNT_UPPER_Raven);<o:p></o:p></p>
<p class=3D"xmsonormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The PWR TSC clock frequency is 100MHz=
, which sets 32-bit carry over<o:p></o:p></p>
<p class=3D"xmsonormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * roughly every 42 seconds.<o:p></=
o:p></p>
<p class=3D"xmsonormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"xmsonormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hi_check !=3D clock_hi) {<o:p></o:p>=
</p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;rev_id &gt;=3D 0x8)<o:p></o=
:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; clock_hi =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_UPPER_R=
aven2);<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; clock_lo =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_LOWER_R=
aven2);<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p;&nbsp;hi_check =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_UPPER_R=
aven2);<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }else{<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; clock_hi =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_UPPER_R=
aven);<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; clock_lo =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_LO=
WER_Raven);<o:p></o:p></p>
<p class=3D"xmsonormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; clock_hi =3D hi_check;<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; hi_check =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_UPPER_R=
aven);<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"xmsonormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; preempt_enable();<o:p></o:p></p>
<p class=3D"xmsonormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock =3D clock_lo | (clock_hi &lt;&lt; =
32ULL);<o:p></o:p></p>
<p class=3D"xmsonormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"xmsonormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSI=
ON(9, 2, 2):<o:p></o:p></p>
<p class=3D"xmsonormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; preempt_disable();<o:p></o:p></p>
<p class=3D"xmsonormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock_hi =3D RREG32_SOC15_NO_KIQ(PWR, 0,=
 mmGOLDEN_TSC_COUNT_UPPER_Raven2);<o:p></o:p></p>
<p class=3D"xmsonormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock_lo =3D RREG32_SOC15_NO_KIQ(PWR, 0,=
 mmGOLDEN_TSC_COUNT_LOWER_Raven2);<o:p></o:p></p>
<p class=3D"xmsonormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hi_check =3D RREG32_SOC15_NO_KIQ(PWR, 0,=
 mmGOLDEN_TSC_COUNT_UPPER_Raven2);<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The PWR TSC clock frequency is 1=
00MHz, which sets 32-bit carry over<o:p></o:p></p>
<p class=3D"xmsonormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * roughly every 42 seconds.<o:p></=
o:p></p>
<p class=3D"xmsonormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * roughly every 42 seconds.<o:p></o:p></=
p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hi_check !=3D clock_hi) {<o:p><=
/o:p></p>
<p class=3D"xmsonormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; clock_lo =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_LOWER_R=
aven2);<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (adev-&gt;rev_id &gt;=3D 0x8) {<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock_lo =3D RREG32=
_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_LOWER_Raven2);<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;}else{<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock_lo =3D RREG32=
_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_LOWER_Raven);<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; clock_hi =3D hi_check;<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; preempt_enable();<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DM4PR12MB5152E2B7372CFB31CAA0F546E3759DM4PR12MB5152namp_--
