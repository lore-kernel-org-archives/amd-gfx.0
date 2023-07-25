Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A673AC0015E
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 07:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3438E10E3A8;
	Tue, 25 Jul 2023 07:31:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71E1410E3A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 07:31:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTK6RkFY9Slbk1hOFJ13OKW5AXITwT894KzrD3C5Hr+JUF/Xz1xB5cTnnqL+KGAsXcyUmw774WqfqTZmgpuNCdokIoKi3dwyHuFms6+eQGfmy8yazSrxUe1uiMabiWpJ8hariBGJloHgKfMexOAhcSBKiPl/9PE5LZDKWcieb6+mR6tNcADYDWdymfEMYfrQb45VtG+M0CRLRsArIbASBNBz6r5Wqb6LrZXlPyddqWGxy88EISITjNnlzhQq0b3NzU7X/wztEEvYlzxf5SOyCUzV95K3C/W9mOIszMB/7+ohu3rFrHh2txJ5IEOhF/P62+lle3bihLpMYEfe4lYYCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R96eJpDvw/2WhoSHxwcQqxjrOz9KklNnvFTIlqgwF1c=;
 b=NrkEpaDjOW/v9lPYa0aFiw9GljuuACG5VglVKWAsBK7FtIL0sOx8lWoQBJAYv6yrLg4bR7RGlrwFLSxLqEMUNAso3whC3Rj67b0JZ8IZFN8UwCgD9Wu3m7bnQe7OfqluBJDUaP7jYLCL3HNmOcycVwAOBccO4qigMc+WE6pTAYwJC9Tp8CYIwtl0kdrrWrEI97wSrcA9jXez7P4ulWEAcjZv7CBW3Hzh3b65dHjlf0SxlUsI0tdLDVis1gn1Hpwsd98nBpdv1bK8H8V5Rlnu/xvFkkcYxPbpb0Gq2VHegugzf1GRXJudRQGYi0LRUShJy+FtCTPuuq4+J6inwViwgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R96eJpDvw/2WhoSHxwcQqxjrOz9KklNnvFTIlqgwF1c=;
 b=O6tEyji9K0uMMx8VdpMnxIi1VkbS+7vleHc2GrNsljDFdRrwvUke4aRNF/4quBEJ52/m1VG2A4q8qdhT0OwslWRtKEYet86yr83hA3F92UNL3IsA+Gm4CX+43u/57Z5YKs95uxLvDkt9C1GF3lq3QT7LLCwoV/k8pZY6R6nHFjs=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Tue, 25 Jul 2023 07:31:45 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::c363:292a:63cc:ccf4]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::c363:292a:63cc:ccf4%3]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 07:31:44 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Restore HQD persistent state register
Thread-Topic: [PATCH] drm/amdgpu: Restore HQD persistent state register
Thread-Index: AQHZvrtRS7Hph8dIaEqzH+MDKYnQsK/J+y0AgAAbZnA=
Date: Tue, 25 Jul 2023 07:31:44 +0000
Message-ID: <DS7PR12MB6071A03BEDB9E315CCCD1C8C8E03A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20230725054554.3188083-1-lijo.lazar@amd.com>
 <BN9PR12MB5257B87F32FCDE34AE5A4A44FC03A@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257B87F32FCDE34AE5A4A44FC03A@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a5d44ce7-5c5d-40b5-aed4-faaf0a6b99e6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-25T05:53:00Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|LV2PR12MB5726:EE_
x-ms-office365-filtering-correlation-id: 99d13211-c571-400b-5f7d-08db8ce132ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SB/iwFQWNpqiWBB82IWFtjnnmoTfsLs1P92ot7PUKLy5k+NXEJJM8uJLYiIWl5xiwkcm37nvI90lOp/ngbx5H7EupUbh4qADQpcgyNCp8lYAyBKsQR0pBZftl8IhnzqTELVyoPNmxL9M67Ft0DzBA3MWtGBtEPifMl/6rKE1KMmnWqMny3J9++W3pHc/bEn+gxgE7tVNPUKj/AchpXMa/KGZfw66Ty+mA94m2kZJSEf271khcnLWoGJNpxq9AzhssKkGBVBesS7WPn3UFsUWmPbu1Vng9smdGQWfl6yhsOyzpIiTeHn4FfKbKTHxdMIQ4lqcn7a/laG16+7bBLT00fnKoUdCDzYSoRk1rjxjcqozKZWMenVHHqqmb4dBt+nB99r1GvNlbzrq7Th6GrABcjnmRkg+T8h/I3WN+DlaMdCpcCX/hxsq6BSg0QQiLO05xarLHlJgUckSIPWGb/K94mNY/kQnSE3i4a3wWWdW6Q5emyOl92BFtKAbLCxWbZWrKeju3DJFNWg4B3B+o3jmpgQZ1GeVg2iuNe7wC0XIpuvMxRVJ2/jFydRY2kr6j8VScb7pJi0+ogTD9DOsFWU2TTSBwWInhk5xKAvaczVt3e3ufffh54ZNK/pMT4vVweGJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199021)(33656002)(38070700005)(86362001)(38100700002)(122000001)(66476007)(64756008)(316002)(4326008)(110136005)(478600001)(41300700001)(66946007)(76116006)(5660300002)(52536014)(8936002)(8676002)(9686003)(7696005)(2906002)(186003)(6506007)(71200400001)(26005)(66446008)(66556008)(55016003)(83380400001)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fn1jBDk3v6zOIv66CQZvx8DYRbyARFzLITlOg1uOskDJUrMORyZIGStMIKcz?=
 =?us-ascii?Q?QD34LBjHdCNxZUIt8VfHEpOgImTLZGEyf1KeMi61EcVDqict4IF4q+iZ4BE8?=
 =?us-ascii?Q?BjVvVPMF4xZa0I0P1maBAzPYJz9i89GX02fcwdzPgqN/Q3eH173R0juBK6Gg?=
 =?us-ascii?Q?RRGVNCzqfLKEZXSIrOjqNzGQGnRzuAfKz0swAeKkrhoP6cxJcfiYumvHqdX6?=
 =?us-ascii?Q?DIH2MIKSltYo2QS3aAKOmcpjzKJpSeU6cOeeCFglgVDNKK3boDbm/Qhg6XzG?=
 =?us-ascii?Q?OfJVF2L6QB9CK8QRXNDFWVAh5fd5h535Y68P+KMkObZK8KmZuh3ZaVMZyZ4X?=
 =?us-ascii?Q?sjTffjHcUYeFxPmvlPT9BcBLr9Fsn4mpxCyMUqL3TtZ1EEsJgMAPKQ501FIO?=
 =?us-ascii?Q?INyN2yCJ8cr26YwAQ1wvWO6SQdAuTEM1bCSu/aTodZH2SFbEw1gPSfUZSq1M?=
 =?us-ascii?Q?sfPa0RMcGAgOePz9ZoCLfvP+iTw9o0p02XOu2xqI1KY2K74Ba6d7RvlFSfHn?=
 =?us-ascii?Q?i5trGocn2XIfO9hxPricMmlWOkw0KJvIMrFmUxPaWQ3fbW5SSxZhLAEh/aoR?=
 =?us-ascii?Q?+amqjt/Ij4NZBuejuIwhPfDhIXbST54JVLiuYa6e+3eDNCHKNeSxs2dAP+0V?=
 =?us-ascii?Q?7bKSjJ6uh4JPnSmcINUCJK4qlZD9FA9U7Ea60qsRU2GgBV2LB0EuhKUAI5Ek?=
 =?us-ascii?Q?wUDNvg5VTQ4dhIRU+GV11upfYs/hMHok0BkfsP66S8xPdpOyCirbiyvpvAdP?=
 =?us-ascii?Q?h1qb2dUGY1s5HINnjSfwJexqz2DAHNZg7+TR6sBkW4dkWLZtz3mH6Dx5CpTk?=
 =?us-ascii?Q?VvgnIyP4UqCV7mS1ExzuzlINgQNM0jLpy2fATAMMAYTpXwD+hANjHYbUoWz+?=
 =?us-ascii?Q?pa8ONGUuGe/bfA/XFeXR5Oc3ZiNSfLEEBuD2zjT2XPVZM4mGtj4xc2ofTnbX?=
 =?us-ascii?Q?lAN1ap9TXJb7YFs3rtzhbvFM3fjta9mrHko5dgVQ8z952/J9qnIjE++GdReD?=
 =?us-ascii?Q?9oir+tUVCGEet4LyzRQfrtFceCUbwLL5S9vmN7CYCMkkdpi4UsZ9N0evgWOu?=
 =?us-ascii?Q?bHcfqQ0xHu0MM4V4+7b61VIt9EpGQFtPGHHndEOmXrl719gHk5hYP1MFzcF3?=
 =?us-ascii?Q?iw1SkcdC9CqmD7bIrrapg+5jWNjFjvFC0bzwE2SBB2zi/FgnJC98hyVuVskG?=
 =?us-ascii?Q?nj4S9KpZMZxGhc+EnG4b8wm3qTpG2XiCNFp0MlbT00mVWvYKF1TexO8/dEU7?=
 =?us-ascii?Q?q59dkyAE6MsU7292hE9lrOd/Ba9XVC5Gz4eT8J2c5OVi3uNxCF3Y2ejI/aER?=
 =?us-ascii?Q?wgcvZONeNYAOD7JwTp148EkpQ5WBF/yWZh71rt/vfYEwo0fgXD5ssHKckJco?=
 =?us-ascii?Q?HwrPne4Gc1hAqRN2qOUhgmGqGCiymq9Pft27db7xbM3hZ14u/jJ2KjAJYtkM?=
 =?us-ascii?Q?VI54PFSaYVKMDhHuFvxuyn/AK1Ak7WRBzeZblmPyN5W9vOWiopvyJ3+AKWq7?=
 =?us-ascii?Q?r0jkZ8VP7Q3KaA5FDuyW2ZjKKlE3y8px/ThHccUHAsFY9niG6w9shhk2sWJi?=
 =?us-ascii?Q?qM9LRH7fi7duc6nf3Qg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d13211-c571-400b-5f7d-08db8ce132ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 07:31:44.8597 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0qRxIUGorCiLSSAoMvPb8Hj0sBymAHkFEKgW5F7A+FkUQwJD7tPO2rhk+Rz759Cnp4h5ZMYwwRJB3peJs57BRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Tuesday, July 25, 2023 11:23 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal=
@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Restore HQD persistent state register

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, July 25, 2023 13:46
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Restore HQD persistent state register

On GFX v9.4.3, compute queue MQD is populated using the values in HQD persi=
stent state register. Hence don't clear the values on module unload, instea=
d restore it to the default reset value so that MQD is initialized correctl=
y during next module load. In particular, preload flag needs to be set on c=
ompute queue MQD, otherwise it could cause uninitialized values being used =
at device reset state resulting in EDC.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 8b361aa87d01..306dc6533397 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -46,6 +46,7 @@ MODULE_FIRMWARE("amdgpu/gc_9_4_3_rlc.bin");
 #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L

 #define GOLDEN_GB_ADDR_CONFIG 0x2a114042
+#define CP_HQD_PERSISTENT_STATE_DEFAULT 0xbe05301

 struct amdgpu_gfx_ras gfx_v9_4_3_ras;

@@ -1726,7 +1727,7 @@ static int gfx_v9_4_3_xcc_q_fini_register(struct amdg=
pu_ring *ring,

        WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_IQ_TIMER, 0);
        WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_IB_CONTROL, 0)=
;
-       WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PERSISTENT_STA=
TE, 0);
+       WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id),
+regCP_HQD_PERSISTENT_STATE, CP_HQD_PERSISTENT_STATE_DEFAULT);
        WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_DOORBELL_CO=
NTROL, 0x40000000);
        WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_DOORBELL_CO=
NTROL, 0);
        WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_RPTR, 0);
--
2.25.1


