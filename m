Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFC9C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 06:28:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7452A10E407;
	Mon, 14 Mar 2022 06:28:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C93F10E407
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 06:28:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9P2MFCxfQ2eooTHUbBOZPEzqTgYokt9XlnIwRVAM1jhuVgUYhfGO23UVLFfAZDHMlPHwPJgQegICHriVCUc95L5sHlc1/3Rk427gyLIfscQeyQCKfKxTe0pf//lDTJttBH+rO/P/hDzgXBfQSbXNrSqSu7gODRcxqh5smslThgnOF5LV+oZmOrOTzM1HvCpNUfbpNGL0oJGv+opwY2bTTqVfA9WQ1QtR6LIaT2o5r/pjn8eZ7EuLkrfZNCd4I8KCPzOEmRvM9MnmgZ8HoQEjIKterAuPmd5LlVBC0gtpiJx6dLVihHNJu0DrjvLYRC8UX65myyCBZOcPG7YMrqSlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkptvmRCk2nz5GfpY3Q7+ieKfeMCFBav0iKARs4N/lI=;
 b=GDGDK2DNpFl2Ch3ZgJBRMjPwP7OM/STdyY8PnZy+BJqrX+f8EjZ9PBOzu+D9qgv/cEZjxonfZjcfDb3kRsBx0C2gwqt2wI6jIPONveHFlJLIqWNJxxua5w6rrCY9W4upWVtUMfRGJ/L/EChqQ8DxZryMlV8bnE1udKKWUeVcyMnG82hLRWwByQyAOUYMbLWd6Ro6r3Vx9loZ+vz92FQ8yXxSmioyaj0rso4uHPet+lMNq2REBam9oYFaQNHck3EFDuuaec4wdE1JF7DK+oUfVRXqfiKvXdzqSw4QCXUo7OVDx0CS+ojRtDS8GG+7J3AQJoYmZl61a570UpNIOV4Nzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkptvmRCk2nz5GfpY3Q7+ieKfeMCFBav0iKARs4N/lI=;
 b=aeZAuH3EbWk/7LMZjRr5Jy3AyC3fGWp9e80cyuM6h4XF2h169lXNJZFA/nH9QrIDjDe37JPvoYPyxYk0x7wCckb2SMF+7GWdZZ/AAg/CPzBEp8Ivuwv41Zuu1L3cUyO8oN1v6xngSqNeIKNk0SDQtU0zwNYeOjKN5DGHTzoN22U=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by BN6PR12MB1635.namprd12.prod.outlook.com (2603:10b6:405:3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Mon, 14 Mar
 2022 06:28:48 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 06:28:48 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fixed the warnings reported by kernel test
 robot
Thread-Topic: [PATCH] drm/amdgpu: fixed the warnings reported by kernel test
 robot
Thread-Index: AQHYN2e/UOuuvHrsX02KGZtiv7tR2ay+agGA
Date: Mon, 14 Mar 2022 06:28:48 +0000
Message-ID: <DM5PR12MB177083EF87DF35009A324855B00F9@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220314055221.3100329-1-YiPeng.Chai@amd.com>
In-Reply-To: <20220314055221.3100329-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-14T06:26:18Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7d504ef8-09d9-4bcc-8875-7c4522e08a63;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-14T06:28:45Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 52bd72f7-c738-41a2-8971-e178b54ba0e2
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b8d25a1-1b0d-4837-7c89-08da0583e62a
x-ms-traffictypediagnostic: BN6PR12MB1635:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1635BBFCC1027E4CBF0A53CBB00F9@BN6PR12MB1635.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zr6RjiLOj2ZXw51wIswwkR8ZusAB4x5TPg75rYlB6BcH2DGeNtFAEdeVBz5gpaLC1XHSqqWkL4t17FYPp04i994doySsP/mWHNX88hMS4EKzwVTVLqj1ZH+iTxpi3jDy21sv40qXeHLAsoNX9SJZ9XbayEbbzv0FDZpxS4RdNrk1w3VPfYCUYyGne0yOiL/2krRwuTTvrVYKRd2fxee2DaRAGcX4VVfB1PWmcgR4WW5pqFiER23VRK1TThwtkMJyrj3gSSCXUtv+bpx6TKlZ3mrbYHb6oVz/LcKxRdcFsyj964b2HfhK4jx18WyStwP0G5RckGYHy4S5IrIjM/2y7CYvI13WHu4HbMQAEsoPb7zqEG2k02edbwMyCkg6H2mvv0CCj/fDM66INhKUCp15tvqYVUd2kKoLOYq/j/qOQVFLQBkaBCbPw2dFeNlKxajNicgIM6AO46MAzYoOp3hvd+fc4+NKljXGJMmu/pqoYrecfOumhPCcs06HEYmCuK6pmEVz26VUaHbroWq/y6+c2RwTOQmPXLeFLR5ePhJGI1OKRzI1L0MaiqqcpWTy1uGUFy9qCl1yFQV6aM19wwbvYSBNzcgK59Iz6+s4mCsK4a/OClSqtkB6foRP/q/VuSasKABQd/pcXtsaExBleZenXUzqtJ9Aw+AOhrP7sHVU09bcwUJ2oGv1IxDjk5Jpmict/aIJI9h41gkyJNTlpuEWCg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(8676002)(33656002)(38070700005)(38100700002)(4326008)(5660300002)(64756008)(66446008)(66476007)(86362001)(52536014)(66556008)(66946007)(76116006)(122000001)(110136005)(55016003)(508600001)(54906003)(316002)(53546011)(83380400001)(26005)(186003)(71200400001)(6506007)(7696005)(9686003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7Jn8BcL/9HzdfKO74k93G1r72m+RNjmgKxPCnaQsErIWns7vLNrD582AHLEX?=
 =?us-ascii?Q?x1agaF++sfhV476SdZjvtNvMpOs4bLd74w34bfXAF7S8sOTnKYtYY4MW3lsQ?=
 =?us-ascii?Q?XAIz+jqdugFrq9Ysbv7aOSIdFDVAbwZjuKWuPQD5tOYwuUa6KFwPpYpG9UbE?=
 =?us-ascii?Q?c30+LKQsyenPMBDpPDITEYq6XHsoWVKw17Krpc+PHz5+ZcCGTR+b7m10rHrX?=
 =?us-ascii?Q?3Enp2M9H6mvZWUI8CqAYViooUzyD4k0JTGy+IOeq7qXLmp41K03URBdGMxVo?=
 =?us-ascii?Q?uX/TTiivqMEZfsN5GI/7mGS86GoGsFDmr2hMtVmTOO5nwbR8AWw4GuadxfHX?=
 =?us-ascii?Q?NHJcduFzJw8juyu5CyM3jO3Gon+jJxQFekAxi/HrXC58rJbjjP4RsJHci9wx?=
 =?us-ascii?Q?6oTGCTyymfUOhtpkUZ9HQtAHaiGTe8Urepy31ldiBOAINt0G8eBZG9Fvi/S8?=
 =?us-ascii?Q?FMdUESLigCKLNO+SC8CESCw/8FFNYAr9WIOt5K/+DO5winGyysuqWtjtS2cB?=
 =?us-ascii?Q?d67qSsWcdvL/tlZYKT7+Z3oOYziT3YSc7OhzbG35Fa2AkiGPPR/8oImEBWum?=
 =?us-ascii?Q?8XM9dzSw/jj58DQVQmu1Dpw9Q01qvWBMpLli5PEkfVlQAW4w9y+acuvIeFvB?=
 =?us-ascii?Q?EvQhXIgba4D4qBbGnasWzLAfuyeMI0YbtU6+NBArl5sqKRHBLbiXlFDAD1fX?=
 =?us-ascii?Q?0l1/BHVkxp+tc87lOuJhVNdKvru3fUGhgf074ROM+y1PlFLUGe8VpD7bhx2Q?=
 =?us-ascii?Q?BReTuE2gn/9gTGMOf61ippj5VGZFZi+jQ0EOR9YgSfqqkfDeJh/0qehPKiOg?=
 =?us-ascii?Q?jqQ3juv48JLw3vJGhCsUuHEBTVXzFmtNc7IifKfbepXd/+ceqA5i3ktOZCyY?=
 =?us-ascii?Q?2tY0IoHo0/COx6OT6iz7V2eexE5/g/yWhzoJApWO3cZLh7uVSswfeN/irYsq?=
 =?us-ascii?Q?cdPmDnalsIfRt5JgUD0p6bG+ySCtQPTGxisRh9JDoaSgaVfMybXAO07R6cgl?=
 =?us-ascii?Q?PfYaeENP2RS537q/LDOXnPUqDvzXAgsLthtMrESVinExUDWRxyQkUXtGJWRz?=
 =?us-ascii?Q?93l1wt0Yt3VaMDcmTrplGc0+5mjeiU8a3LuvpLOowt/hCZaQ2FVIJ3ezRlL6?=
 =?us-ascii?Q?nqLVL2eKyvqbSuku65ViED7puXwokLudTRFAnDNhVlSffOoFhrJ+C9QDE9Kz?=
 =?us-ascii?Q?pKNN0qnUB2hqf7K2gweWxu6GwUQVh7wYETyxszWoNSTuvQVfsJs3QI6K+WOq?=
 =?us-ascii?Q?h/pcLCCkvkKfxx9yuuPbitTddtXGJVb7QJ34Pw2ifZbmIAokNP4fdS/+Jfya?=
 =?us-ascii?Q?H5cSamnU5TsJaw8/YmXIYrVQygMQMCYMDFzGFn5JvrhokJG+F/XpdwwW71p/?=
 =?us-ascii?Q?nY4seo44YDJ+eJ7SagimnGMMabH9JxatVNiWh2zH/DfID9PKpXj8h72sJ5oA?=
 =?us-ascii?Q?+9JiaIrZ5wVaZeNF0SrxRlzfsuCzK46G?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8d25a1-1b0d-4837-7c89-08da0583e62a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 06:28:48.5495 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adbqfZRydR1dDG/8Oi7PBijKKuXVo6+lpeQprxY9nViAmhP7WpRuyiixd/EpgUaF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1635
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Monday, March 14, 2022 1:52 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH] drm/amdgpu: fixed the warnings reported by kernel test r=
obot
>=20
> The reported warnings are as follows:
>   1.warning:no-previous-prototype-for-amdgpu_hdp_ras_fini.
>   2.warning:no-previous-prototype-for-amdgpu_mmhub_ras_fini.
>=20
> Amdgpu_hdp_ras_fini and amdgpu_mmhub_ras_fini are unused in the code,
> they are the only functions in amdgpu_hdp.c and amdgpu_mmhub.c. After
> removing these two functions, both amdgpu_hdp.c and amdgpu_mmhub.c are
> empty, so these two files can be deleted to fix the warning.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile       |  4 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c   | 30 -----------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c | 30 -----------------------
>  3 files changed, 2 insertions(+), 62 deletions(-)  delete mode 100644
> drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
>  delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
> b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 5dfe08cb045e..40e2c6e2df79 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -53,11 +53,11 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_kms.o \
>  	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
>  	amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o
> amdgpu_virt.o \
>  	amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
> -	amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o amdgpu_mmhub.o \
> +	amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o \
>  	amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.o amdgpu_vm_cpu.o \
>  	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o
> amdgpu_nbio.o \
>  	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o
> amdgpu_rap.o \
> -	amdgpu_fw_attestation.o amdgpu_securedisplay.o amdgpu_hdp.o \
> +	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>  	amdgpu_eeprom.o amdgpu_mca.o
>=20
>  amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> deleted file mode 100644
> index 3f3d92e16c2e..000000000000
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -/*
> - * Copyright 2021 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining=
 a
> - * copy of this software and associated documentation files (the "Softwa=
re"),
> - * to deal in the Software without restriction, including without limita=
tion
> - * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be includ=
ed in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> DAMAGES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - */
> -
> -#include "amdgpu.h"
> -#include "amdgpu_ras.h"
> -
> -void amdgpu_hdp_ras_fini(struct amdgpu_device *adev, struct ras_common_i=
f
> *ras_block) -{
> -
> -}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
> deleted file mode 100644
> index 8f2fa247d605..000000000000
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -/*
> - * Copyright 2019 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining=
 a
> - * copy of this software and associated documentation files (the "Softwa=
re"),
> - * to deal in the Software without restriction, including without limita=
tion
> - * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be includ=
ed in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> DAMAGES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - */
> -
> -#include "amdgpu.h"
> -#include "amdgpu_ras.h"
> -
> -void amdgpu_mmhub_ras_fini(struct amdgpu_device *adev, struct
> ras_common_if *ras_block) -{
> -
> -}
> --
> 2.25.1
