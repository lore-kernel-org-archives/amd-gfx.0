Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE88C83F2C
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 06:32:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E42BB10E43E;
	Tue,  5 Sep 2023 06:32:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4B3F10E438
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 06:32:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gC1bWcGR4VLwMw6dnorZQu/MT2eLF7o5RNByumCmuc3Vy6W7V8iwPsUtrTGO7c8D8r4fORo0U5jA7EUqr8HC0hT4dpFZ5qbQCdwoBGEWAklU3us513gINNEqmRbhXdcLyxPyiJq9zvn0nAEqGxe0xB2MoKYhHTQ+5j73yVWSVoMx4IIsapRIGQWTgpheONVrZjfubGCYYLmVjL39C2G6iaMeit10t+etCrCPnF09xGX6E6mdfHYmIGBF8+gecoafuJqP2/3b8mh9S8YUPpL28mSgHcdaKjXlfcUfSqrygDrHAtINiWSRl3vLVKrcBzaVqa/rZ1xyjzCj3pm/RTTJWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmYDTGRvcX3Fyxadsd3xTMZUt6pOX/HHRkKp3pkZ5aY=;
 b=nVkreiGEmNysbE0bkcGV7nW9nnef4kdVuG3q6b4+Gks2G5zcwxXLpZSsdXc3ud77XG6caUicYHbYtPGpO54idnCphntQV8yT4gQbj3Uh/8OBKm/AvHCjViONTJDT62d8nCdglZvM+iAzmC6LDS8JxnhvqyLGEOLtPoh5pEG+iHwGAlJN+y+JZ3UP5NO7pKDe6WtALbxzpCMVsiVNmzzWQ6RCeWH2C9/V/qcjvZQNbHw+SsPDaT2bDWsIPbrx3Q3MOijBZc1Zvvp7FXaiwn+kVXU2WVYLa0qkfzdhGG4jt0hjLvQrafbsNwfZZvCXiKJJYVtRbsvfsbT8vVBrXuhojA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmYDTGRvcX3Fyxadsd3xTMZUt6pOX/HHRkKp3pkZ5aY=;
 b=XTqlp7nBFQFUsUHG/1lxN1mSJeL037dOXmdkhSCifi8sQiVcRiDZqvRL4hjscmfxDyaaeUOaVM8/wpYLR5yj6O6TQ7BB0WpQ5PplDik5knSoEKxYW8DjLJDrcsUkiOwjGwn/5l8gvFxeqr62+D8k/setI858nAaXtz9d+ZIh9DM=
Received: from DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) by
 SJ2PR12MB8954.namprd12.prod.outlook.com (2603:10b6:a03:541::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.33; Tue, 5 Sep 2023 06:32:52 +0000
Received: from DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::3ad:d87e:b2a3:db27]) by DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::3ad:d87e:b2a3:db27%7]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 06:32:52 +0000
From: "Chiu, Solomon" <Solomon.Chiu@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: fix incompatible types in conditional
 expression
Thread-Topic: [PATCH] drm/amdgpu: fix incompatible types in conditional
 expression
Thread-Index: AQHZ3ueIoei+jyhGwEW5hdLXtv3Pa7ALx4en
Date: Tue, 5 Sep 2023 06:32:52 +0000
Message-ID: <DM6PR12MB26045A49DD75A3DA73CED2AF97E8A@DM6PR12MB2604.namprd12.prod.outlook.com>
References: <20230904042259.3070136-1-Lang.Yu@amd.com>
In-Reply-To: <20230904042259.3070136-1-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-05T06:32:51.108Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2604:EE_|SJ2PR12MB8954:EE_
x-ms-office365-filtering-correlation-id: 5e4492b9-f381-4865-244d-08dbadd9ee7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ow3oByicLg6zwLTmbAkAZshJO2qvarcmL87kOKtIbsllnfpgjQI0cZc2+NnVXWjTzKGgjV3k8WUiOI4oxtcsnFAYbXsur9fi4/S06QvF1b2yUNo+/4yqbHvlW1sfPFL5vTrEbg850Ow/LQmH3BuOj/OByIVeB8jGWxLMV4KFgfe8I/bvMhpPJG5lnPKC8y2V2Wr11ind5rA+tXqwOewwrEQEZxfI0WaxlAc89Fgsm+1BdQXmQgW9AlQQ+8PB/4Yw1TBe866KlTACQItL/XVzq8Tq+n6UNK2LI9CyR0OhW0GwEnmfFiue/614VWdmLsMac1TLM93EuodWXKWJsFGYRr63VbXuhy/c9RvEfRp/yTmIA1FbSNIKn/wpmlx1nD638aS3UTExC9lQyn7SxKKiozm6pet51NERhwhV5LO6ypKosBb+COD9MOisSJeP7V00TbCNmwUhFfrttH35qlAQ+LB1RNyDTW3g+Jb5VjoMYpxL1VpyW+MzUyHBmyv4CsdoZSADmwaWCHVxic06IwQhLYsl55nncHIpUHvyTLEIQd1s8i1Z4cpmvtQSaeL0SczdQX3kroPvt+Gl0XkXg2z4XV27x6+wtih3giIVzdi6ZZ8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2604.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(1800799009)(451199024)(186009)(52536014)(8936002)(54906003)(110136005)(64756008)(316002)(8676002)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(55016003)(166002)(122000001)(6506007)(7696005)(53546011)(9686003)(41300700001)(26005)(83380400001)(5660300002)(71200400001)(40265005)(91956017)(478600001)(966005)(19627405001)(2906002)(86362001)(38100700002)(38070700005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7m9/3CLhV8smnn33Dd7mDpXxbqmnPlp5IOeiiPzn2/FZylgj2xW9jT3Np7gA?=
 =?us-ascii?Q?PoykvcmJ9dGXcMBU1dNAaFutIyzgIuMxlPSm8iePBQaO5yWGIDQk/WmnfEag?=
 =?us-ascii?Q?xfm3UnD8sUm+GJgEKkoLgK4jtjxQiPy2hAO2fb4AgG8FYpIHZUCjEFtah2VR?=
 =?us-ascii?Q?i8754AqbLH9QB/Ls84/9jO2p4BPZC/1o72fWcpIyyMzJv/AhAt/xD95WefcF?=
 =?us-ascii?Q?4V/RUjCpzKFL8FftCDeK0ZSt593dXe7jVJ6AdNOeCFUs1AfKo3lXWqZxMmdN?=
 =?us-ascii?Q?/IMEW6XOsJS+vk2rZlwb9loA5vL2ytOD3LEqIg6U0jBi6eM0k3kZcwQQy/+d?=
 =?us-ascii?Q?0io6R7z9zszVVyN5A6H1UFCEd0+t+M7gNvkgoQGeYoAN5kFKW0MQ7i81ITBZ?=
 =?us-ascii?Q?JLS6gtlsa7fJdUp5HUPsgpMSFRniL5N2tX1Zvd1cCPenlt9K60Bzq/iMYDD2?=
 =?us-ascii?Q?dfMWy3CmrZelErft5+D8gKys6utCVzUe8JV7vXIXkZ1QkScara0d1uxcEetw?=
 =?us-ascii?Q?Bt39VC6WquiXhPuChzwUbpt6xSMLPPo5pYAC9okibkt8bYXt3p/lhsueeafT?=
 =?us-ascii?Q?cNjlNRXHskvV0jei1cPSOwx4+M/smSNg6LKEtj4S1KSQyyOcbsgdNtNUa+Tz?=
 =?us-ascii?Q?Jsnmb1Jk17i3f6IDb/UvB23/AZg8O/iPO43jOTseZ//TVgumph0pJyHI6mOQ?=
 =?us-ascii?Q?3NYYitac3oBsVfh8itu62iHMBrrFYCkRp0WqiBvbjtcmRPZN/JgwdMb6X7BL?=
 =?us-ascii?Q?hi8cAEJDOty/PGy1kR1r9Wp4V2yAb895HQzq6RvnpsjkJfjVJjpHBu5l0qJa?=
 =?us-ascii?Q?jBy626tff81VzIsT3ffxBV2wy1+1sNyvP3ZFvW1BuMVPgtrKcd1DdNPi19C+?=
 =?us-ascii?Q?VXksGrKI2v4Az5VX5ZVnGd0dufUrn8M1QqkRDtYktWJ8HXkx5LOzh92kWiiC?=
 =?us-ascii?Q?sZBiDSiadjb8nCRlt6rck8Wcae8cKx72FPSIS95PgCI7neKejGrUPPBbUD0E?=
 =?us-ascii?Q?as53O55hsjAkAvAvJQ9H3Z3XJK2iHd6HRb/RPkrMcNfYvF80erj4hyHjw+JC?=
 =?us-ascii?Q?EkmZ7CC/TAauYcSl052nU9IAxJI/p3YliqggHsJhUB8whbuX4h7BaRF+5IIN?=
 =?us-ascii?Q?zLLf6WTWvByrq3eputuVG1vj5FgSGVcrTvQCq9OPvjjpCM5z80btwXX/ql8M?=
 =?us-ascii?Q?SsqWE9OPLe63W4SvEfJeCROEWsYZJG3PodQyNJf2psGs8irFLcMw6wabXcNY?=
 =?us-ascii?Q?IdV40dnYHlhRVdOqgG8weadoetU4qczbpt+YmxvAUJLIh8r92Xy9mToyFmR9?=
 =?us-ascii?Q?NIQa+0XLk7BU3S77IwBqEcsIs9Dsw+pLY01+ixP0ymwsuKVYrhFiZJO96j2B?=
 =?us-ascii?Q?JZb8fQcnq5yNpeVAqtDhKuNZ5NVUW/akNclL6+IxHTaDR1lYYHeRx4Qk4P4J?=
 =?us-ascii?Q?SbrJ/GUCFJxkrRjJI6Ihi1rT9XBxJuRa29/8FAZY4GoNs7mqf5yLQBD8Cjbc?=
 =?us-ascii?Q?0E+m1yDEbY0mIyoWCxWWNh9WFA08SFhP9hQsiaroH8WSLOWAuIVzRlgqijF5?=
 =?us-ascii?Q?LT1l00bxnbumC4PYJwQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB26045A49DD75A3DA73CED2AF97E8ADM6PR12MB2604namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4492b9-f381-4865-244d-08dbadd9ee7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 06:32:52.3805 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7X/VhpjZ+ZQicU0VbRfFuu9imZpqWaetZnp4NNLGcQda+qySmxu1LaCwpPxtLKq8UQNMnYIaOtTnpy6fIXZu9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8954
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB26045A49DD75A3DA73CED2AF97E8ADM6PR12MB2604namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]


Looks good to me.


Series is:

Reviewed-by: Solomon Chiu <solomon.chiu@amd.com>

________________________________
From: Yu, Lang <Lang.Yu@amd.com>
Sent: Monday, September 4, 2023 12:22 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chiu, Solomon <Solomon.=
Chiu@amd.com>; Yu, Lang <Lang.Yu@amd.com>; kernel test robot <lkp@intel.com=
>
Subject: [PATCH] drm/amdgpu: fix incompatible types in conditional expressi=
on

Fixes: ab041551f4a7 ("drm/amdgpu: add VPE 6.1.0 support")

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202309020608.FwP8QMht-lkp@intel=
.com
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h | 2 +-
 drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c   | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vpe.h
index b590205d6a28..29d56f7ae4a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
@@ -31,7 +31,7 @@ struct amdgpu_vpe;

 struct vpe_funcs {
         uint32_t (*get_reg_offset)(struct amdgpu_vpe *vpe, uint32_t inst, =
uint32_t offset);
-       void (*set_regs)(struct amdgpu_vpe *vpe);
+       int (*set_regs)(struct amdgpu_vpe *vpe);
         int (*irq_init)(struct amdgpu_vpe *vpe);
         int (*init_microcode)(struct amdgpu_vpe *vpe);
         int (*load_microcode)(struct amdgpu_vpe *vpe);
diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c b/drivers/gpu/drm/amd/am=
dgpu/vpe_v6_1.c
index 1259b150dc96..756f39348dd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
@@ -254,13 +254,15 @@ static int vpe_v6_1_process_trap_irq(struct amdgpu_de=
vice *adev,
         return 0;
 }

-static void vpe_v6_1_set_regs(struct amdgpu_vpe *vpe)
+static int vpe_v6_1_set_regs(struct amdgpu_vpe *vpe)
 {
         vpe->regs.queue0_rb_rptr_lo =3D regVPEC_QUEUE0_RB_RPTR;
         vpe->regs.queue0_rb_rptr_hi =3D regVPEC_QUEUE0_RB_RPTR_HI;
         vpe->regs.queue0_rb_wptr_lo =3D regVPEC_QUEUE0_RB_WPTR;
         vpe->regs.queue0_rb_wptr_hi =3D regVPEC_QUEUE0_RB_WPTR_HI;
         vpe->regs.queue0_preempt =3D regVPEC_QUEUE0_PREEMPT;
+
+       return 0;
 }

 static const struct vpe_funcs vpe_v6_1_funcs =3D {
--
2.25.1


--_000_DM6PR12MB26045A49DD75A3DA73CED2AF97E8ADM6PR12MB2604namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<p style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; margin-top:=
 0px; margin-bottom: 0px; background-color: rgb(255, 255, 255);" class=3D"C=
ontentPasted0">
Looks good to me.</p>
<p style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; margin-top:=
 0px; margin-bottom: 0px; background-color: rgb(255, 255, 255);" class=3D"C=
ontentPasted0">
<br>
</p>
<p style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; margin-top:=
 0px; margin-bottom: 0px; background-color: rgb(255, 255, 255);" class=3D"C=
ontentPasted0">
Series is:</p>
<p style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; margin-top:=
 0px; margin-bottom: 0px; background-color: rgb(255, 255, 255);" class=3D"C=
ontentPasted0">
Reviewed-by: Solomon Chiu &lt;solomon.chiu@amd.com&gt;</p>
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Yu, Lang &lt;Lang.Yu@=
amd.com&gt;<br>
<b>Sent:</b> Monday, September 4, 2023 12:22 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chiu, Solo=
mon &lt;Solomon.Chiu@amd.com&gt;; Yu, Lang &lt;Lang.Yu@amd.com&gt;; kernel =
test robot &lt;lkp@intel.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix incompatible types in conditional e=
xpression</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fixes: ab041551f4a7 (&quot;drm/amdgpu: add VPE 6.1=
.0 support&quot;)<br>
<br>
Signed-off-by: Lang Yu &lt;Lang.Yu@amd.com&gt;<br>
Reported-by: kernel test robot &lt;lkp@intel.com&gt;<br>
Link: <a href=3D"https://lore.kernel.org/oe-kbuild-all/202309020608.FwP8QMh=
t-lkp@intel.com">
https://lore.kernel.org/oe-kbuild-all/202309020608.FwP8QMht-lkp@intel.com</=
a><br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h | 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c&nbsp;&nbsp; | 4 +++-<br>
&nbsp;2 files changed, 4 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vpe.h<br>
index b590205d6a28..29d56f7ae4a9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h<br>
@@ -31,7 +31,7 @@ struct amdgpu_vpe;<br>
&nbsp;<br>
&nbsp;struct vpe_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t (*get_reg_offset)=
(struct amdgpu_vpe *vpe, uint32_t inst, uint32_t offset);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*set_regs)(struct amdgpu_vpe *v=
pe);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_regs)(struct amdgpu_vpe *vp=
e);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*irq_init)(struct amd=
gpu_vpe *vpe);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*init_microcode)(stru=
ct amdgpu_vpe *vpe);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*load_microcode)(stru=
ct amdgpu_vpe *vpe);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c b/drivers/gpu/drm/amd/am=
dgpu/vpe_v6_1.c<br>
index 1259b150dc96..756f39348dd9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c<br>
@@ -254,13 +254,15 @@ static int vpe_v6_1_process_trap_irq(struct amdgpu_de=
vice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static void vpe_v6_1_set_regs(struct amdgpu_vpe *vpe)<br>
+static int vpe_v6_1_set_regs(struct amdgpu_vpe *vpe)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vpe-&gt;regs.queue0_rb_rpt=
r_lo =3D regVPEC_QUEUE0_RB_RPTR;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vpe-&gt;regs.queue0_rb_rpt=
r_hi =3D regVPEC_QUEUE0_RB_RPTR_HI;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vpe-&gt;regs.queue0_rb_wpt=
r_lo =3D regVPEC_QUEUE0_RB_WPTR;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vpe-&gt;regs.queue0_rb_wpt=
r_hi =3D regVPEC_QUEUE0_RB_WPTR_HI;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vpe-&gt;regs.queue0_preemp=
t =3D regVPEC_QUEUE0_PREEMPT;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static const struct vpe_funcs vpe_v6_1_funcs =3D {<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB26045A49DD75A3DA73CED2AF97E8ADM6PR12MB2604namp_--
