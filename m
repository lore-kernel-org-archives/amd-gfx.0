Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF160C25B6B
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Oct 2023 01:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A46E610E8F3;
	Fri, 27 Oct 2023 01:04:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1E5410E8F3
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 01:04:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErGXJJNwjPF+ZInmfOv1PZyeyJsTempr3jcHNhUFwPRG17VF5bOt00rHwyhSAJy+wJmf4GthDglRi2sw3HiNrWzjJkO+hMZabbhGuBOT3u0RAs7bg6SABKxkIOf80CgIbUDrVGUgPjsn7YjnQYMZQColKw5td3wJBNj3AoR4HMaoxKJmBe0/zvt0GZbi/lMJ/+L1FaEvZkbPdYSeIzELbat3FXT4Ld0WcpysEh6Yyr1LCgF/l5H4mPpLEOzIOlu9P80unJ/esHhaq09MrNnounKPMA3wUF3kUfHmjxpVPivjjQFxn5gRlVTIsh34QlSxINBWcFex+Ai08BxzA3wlDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAREVxD1FCsDCptzX0PqoKjkfxIk+KZryFj/gh7YDIw=;
 b=JQe9mKQIMwP9Hwtq4B0e0MPmttLA4rg6qhUfKFlw+30oRpZCsh6l6UOPCWlQ9wWtOazreDBWvhFI0AeXfbs/VHK423DkqmijgTHBJxZEkihhSYIsPkkq9AK0S0pdwQ1gol6o/8jSFnMX8iCWLU07tX1NH+4VLT2OYzyIGDMd/8IVVBWWwPAagxDfDd4nWsejzaiiMuWQd6FVjcIc7BAsAPKnLyGaY4iiZSSdtEFx1Xnd1p4Oh6CSbrTbPVeWzkWsllJGediUVhQG4mod853mQNpK+poUusWEdhciRqD0+2yj1c9egpnYzxZ3V8PbhZacnHd89KNrCpg0SkoIRo5Lbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAREVxD1FCsDCptzX0PqoKjkfxIk+KZryFj/gh7YDIw=;
 b=T0Ld+EW+VjtxeX3p0shf5AeKuWAuDCk7rObBwP7mpj5BuBVfAb3fNNcFZa39mhFB67dI10GyrDJF+48G1pjWngP+z4Woh0n9iVjxlSVptCaqnqVRDKvNb39KRgYNSH9iNwZf53v7F65miLnPDL4vx7Gi2DGqiMc9f/t/G/gOUDc=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 01:04:38 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b%3]) with mapi id 15.20.6907.030; Fri, 27 Oct 2023
 01:04:37 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: fix S/G display enablement
Thread-Topic: [PATCH] drm/amd/display: fix S/G display enablement
Thread-Index: AQHaCDH8SCGHe0cjwkuxw6yfQgrfz7Bc0pDg
Date: Fri, 27 Oct 2023 01:04:37 +0000
Message-ID: <CY5PR12MB63693FCBC0435C60510D3A35C1DCA@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20231026172914.31796-1-hamza.mahfooz@amd.com>
In-Reply-To: <20231026172914.31796-1-hamza.mahfooz@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9684fb49-cb86-4939-a585-a381455bd27e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-27T01:04:03Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|CH2PR12MB4167:EE_
x-ms-office365-filtering-correlation-id: 2f6b5a51-07ca-4b9c-7d81-08dbd688b119
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FiIsaK+yhUYaGU1FOOzxtU/ULzItV6oTgRgNEy0SW4rYYab5ZIePW2uSYTPNnOIbjxKFE+ME3BeRQOGA2JMBC8BROIrU5YSEMxOx5vMO2NCVk2WxizubzGA7MiTtRqz1IFi1Au4b/jLrICuuNeUNEidFjTzRBz8bKBiLXxQa1AR+GYXwyF7XCJzDyqgdNxUn0/ZI4g6JoM7zQy+uanlZ0P5qWHnxlbq45jyF5f34+CpRWV5y2uk1C1C78T5LHPAw6hzDPq0uJnjy/QD2uNidnIbGkeMWdiIfQu5HWN5ONSguOMIPvsO6JDSYie9+o0xnsVuBLA5LlVwZI6Rew0p/31BPPOM6SYJoUTA9XhvE/2PbFkYEH8Wf7f7H8t95IJv1atAMzykGPatdPk9kfv6FZr7EJ3LX8zXj0MqDmJ7nE8zS+Huvm69VWLGPnCFDkBPbLtaaknR+sv9I3b3EZzsKCmBVgv+zRWZI24CEjaLCXvxAuDbJiIOUQ+4xIODYSoYOreYz+POn2jn/SKnHgZRgvEL/uTgWgyevxVzpFsTcYlRuTM1V1ctGwio52zot9xL9uLUgBd3o6eHE5aB2Q9Ar2b3GiU7uxYMSCHee9eT9DHHzTiQUW6xecYTavJ5Tg9r9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(376002)(346002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(122000001)(26005)(55016003)(66946007)(38100700002)(83380400001)(52536014)(478600001)(2906002)(64756008)(41300700001)(110136005)(8936002)(54906003)(8676002)(76116006)(6506007)(4326008)(33656002)(86362001)(316002)(7696005)(66476007)(71200400001)(66446008)(53546011)(5660300002)(66556008)(38070700009)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GLBd0e3KV2SI8aPzvynXidU36JaL/bHbcn9Z6gccJxEucT7mHql2dueHFUI2?=
 =?us-ascii?Q?gPuI5pSU+dQtCtSGRLuCOSM4RyV3Yh4gqEA/TjGshL5J07L3a0ePFhOScNjR?=
 =?us-ascii?Q?nGTthG9SEh8tMA2iKxFAQrtCdZfgmu8rGjFvSlpQctNp1tow9dTfyPSsfuik?=
 =?us-ascii?Q?adthGR5iGUbZrCvSUKREBCsJlJgZ2ZBhJ1J+5DGeT77udPIfJKoIGgpnmopZ?=
 =?us-ascii?Q?ZrYsBgTRnz9Pln+P84EB/Rcl78oZKOQCV3acCBohW/FFOYeZc0rQVYOeCYuu?=
 =?us-ascii?Q?dugbd2fZWcg33ThFDijgzNRYQveMAHhyfca7A1P37g+AWpwTkN5JvMKlS7WE?=
 =?us-ascii?Q?TtV0HgOwrDozfS1jlhNKEN6p2pMlEl7nheCHEldJYR1rgoZ/pXhJSpBM+VXv?=
 =?us-ascii?Q?+65m7PPl9YZYUPpS28vheIdpety23pWJPomMCxzOM+gKQ5tZlGqJcnD5Zw1m?=
 =?us-ascii?Q?Av6jVmamAejcaOQUlSjS/hdPHx1NsKCk/ZaNOzKiQaVrKKpDWts5X5YRVKub?=
 =?us-ascii?Q?6MXAlJEY6NTWuwZeBJHMJ+GsHqbvgONQA858qsP+kdO2/hsL4G950NFYbRoh?=
 =?us-ascii?Q?c74mROVaSJFH63xhY/F+6SFc9udh76FmaPv1jTBv8HhkkAdzvK3HAFtyggEV?=
 =?us-ascii?Q?zvxXLEif5JWlqKUdAAlrUnqm2cdfeH6d4NnXgJO6uWpdWclFRcSyO5dc53Nn?=
 =?us-ascii?Q?20NStAXFmkHKNdLohj3YCOfdUcx4YQ6BS6VP1nQ07CdVXSHamDPI26BM+bhy?=
 =?us-ascii?Q?yGeomysgJCIX+GakcecFite9f83lgbX3MKOa3pPeL+NL9OSiILI9FQOOV+DF?=
 =?us-ascii?Q?5iteG5sbHdndPYLjHm6x3je6GLF5+gpV9bSPp2F+2YxIHS6DYPiGCcVVvZ0x?=
 =?us-ascii?Q?VVXRGKvxSBunLBxYIWevqb8Cv1i2u5eLCDVMPbzrshhEG4gdJcc1ikiI+/S2?=
 =?us-ascii?Q?uMDeEhsOVZxeacXHVYy2BiTdtueSB7MLYfHF0EaGPHgwOR2LMDfMS3FKqEAn?=
 =?us-ascii?Q?nEknedW4XSxoh6E535BqXnE8LYEK7j4q9ilalnETrrHsn6DJ5fYyh/V6+q3s?=
 =?us-ascii?Q?Y0D1pnWuAVBSKJ4J+HreuhI8HYWiN3nNlZABjROXw5zMLQ1TY+TU4s84Xi4k?=
 =?us-ascii?Q?Dfy4o0ekx6neag0TrE5TSwSUGYDuutkHkE+CTjf+FaHxtf/pkMh0soA8SZvx?=
 =?us-ascii?Q?GsaYb4jQtHoozqCPQg/qz1HfsuA2zIOjywNEGR3Jo38lP+eIjAsF3SMIzmMd?=
 =?us-ascii?Q?7HJy/zJ0IAf4zzCUgj4vCyb0M+SpvOwT1zJuwjAhVuBup/l34V6cxF0Sztb+?=
 =?us-ascii?Q?xIjU7+ruEtGK98EoeLeHSkZp3WlIuNuzPfLmJlJ5Q9O1ttB6o0f+ksOxQzMn?=
 =?us-ascii?Q?gkcX0EQwiF0AZCFcDiryJ17+CSq0SL6DoHJDt2pmAyZm+BAoQZdUIX/o8KC1?=
 =?us-ascii?Q?liXwilMLQn5Adxxo7/soEqelN1Bz82cNNIPhDd8XsA66+76b42M+7QKMFxkL?=
 =?us-ascii?Q?7QNhBG1Dau+ZobqI03doIeJDqnE5W/wvDQXd4n/SUKMCHbyEt/Pnya5vMqvY?=
 =?us-ascii?Q?nYssWcJ/zgxpUwyPh9g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6b5a51-07ca-4b9c-7d81-08dbd688b119
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 01:04:37.7793 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6b1xe8IIYvO5YpSjevBwXsbwdg0jXAEH7CMa9kxOS1xpdha+KeDU37vpjCkoBBgd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167
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
Cc: "Broadworth, Mark" <Mark.Broadworth@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

This patch is:

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

Best Regards,
Yifan

-----Original Message-----
From: Mahfooz, Hamza <Hamza.Mahfooz@amd.com>
Sent: Friday, October 27, 2023 1:29 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Deucher, Alexander <Alexander=
.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Li, Sun pe=
ng (Leo) <Sunpeng.Li@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Siqueir=
a, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza <Hamza.Mahfooz@amd.co=
m>; Broadworth, Mark <Mark.Broadworth@amd.com>
Subject: [PATCH] drm/amd/display: fix S/G display enablement

An assignment statement was reversed during a refactor which effectively di=
sabled S/G display outright. Since, we use
adev->mode_info.gpu_vm_support to indicate to the rest of the driver
that S/G display should be enabled and currently it is always set to false.=
 So, to fix this set adev->mode_info.gpu_vm_support's value to that of init=
_data.flags.gpu_vm_support.

Fixes: d059c2ec6a23 ("drm/amd/display: enable S/G display for for recent AP=
Us by default")
Reported-by: Mark Broadworth <mark.broadworth@amd.com>
Tested-by: Mark Broadworth <mark.broadworth@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 781d04eda3d4..adbeb2c897b5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1641,7 +1641,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
                init_data.flags.gpu_vm_support =3D (amdgpu_sg_display !=3D =
0) && (adev->flags & AMD_IS_APU);
        }

-       init_data.flags.gpu_vm_support =3D adev->mode_info.gpu_vm_support;
+       adev->mode_info.gpu_vm_support =3D init_data.flags.gpu_vm_support;

        if (amdgpu_dc_feature_mask & DC_FBC_MASK)
                init_data.flags.fbc_support =3D true;
--
2.42.0

