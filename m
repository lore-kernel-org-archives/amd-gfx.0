Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349ACC48297
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 19:58:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5430112DBE;
	Tue,  6 Feb 2024 19:58:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qTFaEjov";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5289610E652
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 19:58:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=famar0hwp9nioz/GiTp8zbgpcyzbaXIYgodGLwC19S9bexM5hn5ybCVvSeOD3O+RW+3FtsHETm0g6Ch8M897r2dAx9qGR7P0eoPLcd2d65xx49nmtjuvJ3doHgZvJD5DvU/v9/RfJURFoHbywEU/vtPSADvsVtlmrtX/vL5zFjjSit9m0rgy13E+wzvKze2kgdrpiLt85i9OCvGzEbKfLWYE292H6SvFrVn2fuyBm/ii0JikkGKW2jtifcklwftWrL4dzBhpUlRIdLy40z5DdxyzlAVZ/rt+URKhdjC6108iHuM9VVbbH3anwM+mJI3T1kqEq3H8K8660eUoEcC3rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wqHGmOKv4wKUnSwmOOhLHSG0krG04p5lfRmHrA3TKo=;
 b=fpXC49kszroGulboEek7G/D+usAVBLrGJfFjYSAC82ME+49cU1WNOuPY2qz8nf+Di7Lv5C9awL7/yCU7cLSPNnbkTFaJymwbYm+0PZan38sn2ppOvshK7M9d+oZiiKD3a6a+0+QtHmOAGUTAMDgdqMw0PhK+9QWFW+NWfXjoKjjuosMVMVXIQG8peR07H6rggRx14BzVmZtW6uLBFtCDFkR6zuI3uJ2+pGHHQAiXvrkNxBBuvFgz4c/UkQKMmeDaW1mD6uf8Bav6z3RN0T/pCdHoF9xM0P8ofbyTXQa/d4GGTGxECX9XyuGb5U8r8Y0Dj+Jo3yH5g5BT1EqfM/IIFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wqHGmOKv4wKUnSwmOOhLHSG0krG04p5lfRmHrA3TKo=;
 b=qTFaEjovlobFF1L+rMk1/P1qlVEsZNFtcg8AsthjEfi5uDnC553R6RUeTOmeic+6DuwXNs1DbyYBsjqQjjrQ6yOd+R/DS0In2yxlXnLV0sWHxHTgiXzA/V4zukt0NMYApox8J8KsxESd4tiWHNO67hjx47qt+UVyxkpk3UIPZI4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by IA1PR12MB9061.namprd12.prod.outlook.com (2603:10b6:208:3ab::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 19:58:39 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52%7]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 19:58:39 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Morichetti, Laurent" <Laurent.Morichetti@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "jay.cornwall.six@amd.com" <jay.cornwall.six@amd.com>, "Six, Lancelot"
 <Lancelot.Six@amd.com>, "Cornwall, Jay" <Jay.Cornwall@amd.com>
Subject: Re: [PATCH v2] amdkfd: pass debug exceptions to second-level trap
 handler
Thread-Topic: [PATCH v2] amdkfd: pass debug exceptions to second-level trap
 handler
Thread-Index: AQHaVVZn8L++X+opH0+mQO3NlQIwYbD9wvXo
Date: Tue, 6 Feb 2024 19:58:39 +0000
Message-ID: <BL1PR12MB51445E95DC8E0591C52F5DAEF7462@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <c0621e89-8f69-7b18-92fb-37c91c678760@amd.com>
 <20240201213334.1275083-1-laurent.morichetti@amd.com>
In-Reply-To: <20240201213334.1275083-1-laurent.morichetti@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-06T19:58:38.798Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|IA1PR12MB9061:EE_
x-ms-office365-filtering-correlation-id: f1d8ecc6-2c7c-45d7-a1e2-08dc274e032d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jr4rP0SVMw328W49z5Mn7BXOSc3tLTWc648yKjDdT9YXhvvrY3r5f9UqVn5kFzYVATMxBD2p5dIMeWu3PAnKyOXE3RpcO9kreerMozlFZk3kc2IuZUo1Oz2OymPbjn7Myr9rde7HT0jM/L+6Dll16l0G7Mb0TFqLht400s23Yvts7GrDw8P2KjyS0xaAYhSxAi57x0ZfiNfiQ4gTHqq375F0oFLGQMy4b3YRRIVgSwtywq/iMa8yjj9H4C9kvOWhsKTRv0ySFKDhNiZEwRPFMCtwSkfy7ttubTESkj5ubhdetXjp27w8rTYKGA4uCp94CVNcI2xmuuDuNDdQVJiYbhiOdIQ6ecTy2elVI8s/jXhgZLV9nc0Z/bsNt8XbevcSUfxEmCbeBM6feTRg4QlPErC7zoVBBUqK8AuG+5ZecjfEV7lNG/Y4nKl9yqHt2kVuJCA9TxFkfcmtvJwE1OTh38n7XJ/s0+iIAdAPIqvLn+j10cUa4iWuLeiN0w/nL4GIeOd8YAYGRBYvEnhTb2N4g3o3Q4OcDJAMxzQOvzMz7fISljYwg83NOs08JWLJUIfEnKnULB7bZdtApK3kEb5a705UDQ862aE6oi0wd3oPMa2oP8OxPAcFzvoWkERUoYB7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(5660300002)(41300700001)(4326008)(91956017)(66476007)(8676002)(66556008)(8936002)(76116006)(66946007)(316002)(54906003)(110136005)(52536014)(64756008)(66446008)(38070700009)(2906002)(6506007)(7696005)(53546011)(83380400001)(26005)(33656002)(122000001)(19627405001)(55016003)(9686003)(71200400001)(38100700002)(86362001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4K1W37QEiyPoAlvgKkWfgoN5wKpfCJXXVBG9fhqp5FucRyCezfsZXkIPjRvB?=
 =?us-ascii?Q?loYFcWYTa3ncvewQusLGFqaLu22f24qj5A3W9gHkjUUf9gEUsigbCeBoPPn2?=
 =?us-ascii?Q?fwCIEJIrvUJ9O9VA3b0BLlVlEop1iXbWrxIbtfeXxtfArWXOIv6jnyGIbWoy?=
 =?us-ascii?Q?whKrm62ZXVeFxDwNFKWjf39iDwvXpMqpJTsDa7mN7D48hTjLqnSxdgW7PiFy?=
 =?us-ascii?Q?ccqGEM8dukPajffk/Zr5DfNstYDhagYw0v0+lVWEMeFlPH+mwkIBuR35q3vc?=
 =?us-ascii?Q?UW4tB29IDb1UlxA+U44SskdvMO03icA3iqCMiU0e4YPQ1zkmRPCpe9JPcXAA?=
 =?us-ascii?Q?ixJppOLGgO5+bUxKMpkXSwr+wiBcyt7KudlJkpg4KP+TS9lPmxvU9HvfH2Ck?=
 =?us-ascii?Q?li2nxfARjO6rkRwqFSWaVbewaCUD43mFm5dfVX/0qkUC7PAbupIVXdQ7txW7?=
 =?us-ascii?Q?/88CtFj+TuHD7XUyDariapHjE5UV52pO6KAs68k4XzRVA8q6yvFcPXPghtCM?=
 =?us-ascii?Q?H+MNu0N6yZ0YQAdaV3iBwajoYELy++N8luv9AZnuISLIGzOGu6acYPCjGKWn?=
 =?us-ascii?Q?5rB2sozdE4/m3YO4b0MD6a6HAQyEZgIlpxYqAKO0qM03MuPNELzmF5E0lous?=
 =?us-ascii?Q?GNy7z7o4bBNYEomh2HcbM3OnN4HZdOh/cfHCarBIrC+30HcpCzjJ5BikyQ2X?=
 =?us-ascii?Q?J+mcCa8Y5NUuwQnaTR4LyYwQmQHfUnAnCkCDIZdQ0q9LryFiCSRYMlRz+G+u?=
 =?us-ascii?Q?fg5eligsUceqqoXzj2lCJDrY7LkgzzFvY1V5shyiFUkzLVBTPDn8UM7ng4Ec?=
 =?us-ascii?Q?EtZ//+q5lFr2l9HCJLxvHkxQ2kCjTwPwb2GLlIgunnW7hR6AVGFtV2H41hTD?=
 =?us-ascii?Q?6aQzRRrHMBJCrbPP2/73W9ZTvMDMgZT/hBGwkQMF+YO1OLsxp/cxr+nSx0lW?=
 =?us-ascii?Q?6WPltFZtpgM6yz9N48meF+7JKpL02BYV32frxT6y+a9fJBOGKq0BuSpucOig?=
 =?us-ascii?Q?B6AYuHRGQesa52bz2SsjWlmN/2z/9IzAlYHNEDp4yk0tZmhhfCsKzb3fIg3x?=
 =?us-ascii?Q?Gz0dkH1FAjb/peUyqJhPmfjQ6c+llO0SRwIRaAIV4WNQD9YHlruC0iOCXNhb?=
 =?us-ascii?Q?+a3L7hMIUTs8oTx9glFfOBuvn+nvaWj7Yxnrbw1pI/WfiT+m6+8wBdlH3Puc?=
 =?us-ascii?Q?+ou5DpuJTD1ty6eJol/rrIbjCaoYqLa7vhjjBylFJPEImCaRhRdIzfHCWbEf?=
 =?us-ascii?Q?6XgOy4qqXhfrEKfBcBdj9QPAo/UdSxdOAahlQgWTw45rs+8i/N7QsGOqq6+c?=
 =?us-ascii?Q?10SJcXansfVOcjSBjBdNYqJn03rg4RGWwGJfMIG2zoDl3sK0DVghcObHYOoM?=
 =?us-ascii?Q?/VeIfChoMFtVmoF6qBGk8Q2iB1dxX4m3QmUMfgaAXyQT0bRWR9L6tf5UHrjA?=
 =?us-ascii?Q?l0TmuX0c17ulFzvkA40ycHutWptMzBgW/EkKe5eyGuBdFg7ERERQTcdJj3BG?=
 =?us-ascii?Q?x5p1m71jQyPAW9ClCHp2npRNlBy0BVtUOjpO3V3MXOsgVF6VwfoNctPOw+Y3?=
 =?us-ascii?Q?JkvtksRIwHIDNwWUg94=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51445E95DC8E0591C52F5DAEF7462BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d8ecc6-2c7c-45d7-a1e2-08dc274e032d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 19:58:39.3708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hccQTLpR7L8c7oW/foL4SExpxvOhmPEtV9Q4T+uI2+yoXEmvSr7eLXqXnilvSSSaOhjVmx2aqNZvF7icVwN+7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9061
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

--_000_BL1PR12MB51445E95DC8E0591C52F5DAEF7462BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Laurent =
Morichetti <laurent.morichetti@amd.com>
Sent: Thursday, February 1, 2024 4:33 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: jay.cornwall.six@amd.com <jay.cornwall.six@amd.com>; Morichetti, Lauren=
t <Laurent.Morichetti@amd.com>; Six, Lancelot <Lancelot.Six@amd.com>; Cornw=
all, Jay <Jay.Cornwall@amd.com>
Subject: [PATCH v2] amdkfd: pass debug exceptions to second-level trap hand=
ler

Call the 2nd level trap handler if the cwsr handler is entered with any
one of wave_start, wave_end, or trap_after_inst exceptions.

Signed-off-by: Laurent Morichetti <laurent.morichetti@amd.com>
Tested-by: Lancelot Six <lancelot.six@amd.com>
Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h  |  2 +-
 .../drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm  | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/d=
rm/amd/amdkfd/cwsr_trap_handler.h
index d1caaf0e6a7c..2e9b64edb8d2 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -2518,7 +2518,7 @@ static const uint32_t cwsr_trap_gfx11_hex[] =3D {
         0x8b6eff7b, 0x00000400,
         0xbfa20045, 0xbf830010,
         0xb8fbf803, 0xbfa0fffa,
-       0x8b6eff7b, 0x00000900,
+       0x8b6eff7b, 0x00160900,
         0xbfa20015, 0x8b6eff7b,
         0x000071ff, 0xbfa10008,
         0x8b6fff7b, 0x00007080,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drive=
rs/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
index 71b3dc0c7363..7568ff3af978 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
@@ -81,6 +81,11 @@ var SQ_WAVE_TRAPSTS_POST_SAVECTX_SHIFT               =3D=
 11
 var SQ_WAVE_TRAPSTS_POST_SAVECTX_SIZE           =3D 21
 var SQ_WAVE_TRAPSTS_ILLEGAL_INST_MASK           =3D 0x800
 var SQ_WAVE_TRAPSTS_EXCP_HI_MASK                =3D 0x7000
+#if ASIC_FAMILY >=3D CHIP_PLUM_BONITO
+var SQ_WAVE_TRAPSTS_WAVE_START_MASK            =3D 0x20000
+var SQ_WAVE_TRAPSTS_WAVE_END_MASK              =3D 0x40000
+var SQ_WAVE_TRAPSTS_TRAP_AFTER_INST_MASK       =3D 0x100000
+#endif

 var SQ_WAVE_MODE_EXCP_EN_SHIFT                  =3D 12
 var SQ_WAVE_MODE_EXCP_EN_ADDR_WATCH_SHIFT       =3D 19
@@ -92,6 +97,16 @@ var SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK    =3D 0x003F8=
000

 var SQ_WAVE_MODE_DEBUG_EN_MASK                  =3D 0x800

+#if ASIC_FAMILY < CHIP_PLUM_BONITO
+var S_TRAPSTS_NON_MASKABLE_EXCP_MASK           =3D SQ_WAVE_TRAPSTS_MEM_VIO=
L_MASK|SQ_WAVE_TRAPSTS_ILLEGAL_INST_MASK
+#else
+var S_TRAPSTS_NON_MASKABLE_EXCP_MASK           =3D SQ_WAVE_TRAPSTS_MEM_VIO=
L_MASK         |\
+                                                 SQ_WAVE_TRAPSTS_ILLEGAL_I=
NST_MASK      |\
+                                                 SQ_WAVE_TRAPSTS_WAVE_STAR=
T_MASK        |\
+                                                 SQ_WAVE_TRAPSTS_WAVE_END_=
MASK          |\
+                                                 SQ_WAVE_TRAPSTS_TRAP_AFTE=
R_INST_MASK
+#endif
+
 // bits [31:24] unused by SPI debug data
 var TTMP11_SAVE_REPLAY_W64H_SHIFT               =3D 31
 var TTMP11_SAVE_REPLAY_W64H_MASK                =3D 0x80000000
@@ -224,7 +239,7 @@ L_NOT_HALTED:
         // Check non-maskable exceptions. memory_violation, illegal_instru=
ction
         // and xnack_error exceptions always cause the wave to enter the t=
rap
         // handler.
-       s_and_b32       ttmp2, s_save_trapsts, SQ_WAVE_TRAPSTS_MEM_VIOL_MAS=
K|SQ_WAVE_TRAPSTS_ILLEGAL_INST_MASK
+       s_and_b32       ttmp2, s_save_trapsts, S_TRAPSTS_NON_MASKABLE_EXCP_=
MASK
         s_cbranch_scc1  L_FETCH_2ND_TRAP

         // Check for maskable exceptions in trapsts.excp and trapsts.excp_=
hi.

base-commit: c4b562a17829454713e45219fa754be1bfda9004
--
2.25.1


--_000_BL1PR12MB51445E95DC8E0591C52F5DAEF7462BL1PR12MB5144namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Laurent Morichetti &lt;lauren=
t.morichetti@amd.com&gt;<br>
<b>Sent:</b> Thursday, February 1, 2024 4:33 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> jay.cornwall.six@amd.com &lt;jay.cornwall.six@amd.com&gt;; Moric=
hetti, Laurent &lt;Laurent.Morichetti@amd.com&gt;; Six, Lancelot &lt;Lancel=
ot.Six@amd.com&gt;; Cornwall, Jay &lt;Jay.Cornwall@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2] amdkfd: pass debug exceptions to second-level tr=
ap handler</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Call the 2nd level trap handler if the cwsr handle=
r is entered with any<br>
one of wave_start, wave_end, or trap_after_inst exceptions.<br>
<br>
Signed-off-by: Laurent Morichetti &lt;laurent.morichetti@amd.com&gt;<br>
Tested-by: Lancelot Six &lt;lancelot.six@amd.com&gt;<br>
Reviewed-by: Jay Cornwall &lt;jay.cornwall@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h&nbsp; |&nbsp; 2 +-<br>
&nbsp;.../drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm&nbsp; | 17 +++++++++++=
+++++-<br>
&nbsp;2 files changed, 17 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/d=
rm/amd/amdkfd/cwsr_trap_handler.h<br>
index d1caaf0e6a7c..2e9b64edb8d2 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h<br>
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h<br>
@@ -2518,7 +2518,7 @@ static const uint32_t cwsr_trap_gfx11_hex[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b6eff7b, 0x00000400,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20045, 0xbf830010,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb8fbf803, 0xbfa0fffa,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b6eff7b, 0x00000900,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b6eff7b, 0x00160900,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xbfa20015, 0x8b6eff7b,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000071ff, 0xbfa10008,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8b6fff7b, 0x00007080,<br=
>
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drive=
rs/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm<br>
index 71b3dc0c7363..7568ff3af978 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm<br>
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm<br>
@@ -81,6 +81,11 @@ var SQ_WAVE_TRAPSTS_POST_SAVECTX_SHIFT&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 11<b=
r>
&nbsp;var SQ_WAVE_TRAPSTS_POST_SAVECTX_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 21<br>
&nbsp;var SQ_WAVE_TRAPSTS_ILLEGAL_INST_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x800<br>
&nbsp;var SQ_WAVE_TRAPSTS_EXCP_HI_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x7000<br>
+#if ASIC_FAMILY &gt;=3D CHIP_PLUM_BONITO<br>
+var SQ_WAVE_TRAPSTS_WAVE_START_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x20000<br>
+var SQ_WAVE_TRAPSTS_WAVE_END_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x40000<br>
+var SQ_WAVE_TRAPSTS_TRAP_AFTER_INST_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; =3D 0x100000<br>
+#endif<br>
&nbsp;<br>
&nbsp;var SQ_WAVE_MODE_EXCP_EN_SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 12<br>
&nbsp;var SQ_WAVE_MODE_EXCP_EN_ADDR_WATCH_SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D 19<br>
@@ -92,6 +97,16 @@ var SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK&nbsp;&nbsp;&nb=
sp; =3D 0x003F8000<br>
&nbsp;<br>
&nbsp;var SQ_WAVE_MODE_DEBUG_EN_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x800<b=
r>
&nbsp;<br>
+#if ASIC_FAMILY &lt; CHIP_PLUM_BONITO<br>
+var S_TRAPSTS_NON_MASKABLE_EXCP_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =3D SQ_WAVE_TRAPSTS_MEM_VIOL_MASK|SQ_WAVE_TRAPSTS_IL=
LEGAL_INST_MASK<br>
+#else<br>
+var S_TRAPSTS_NON_MASKABLE_EXCP_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =3D SQ_WAVE_TRAPSTS_MEM_VIOL_MASK&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |\<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SQ_WAVE_TR=
APSTS_ILLEGAL_INST_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |\<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SQ_WAVE_TR=
APSTS_WAVE_START_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |\<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SQ_WAVE_TR=
APSTS_WAVE_END_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
\<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SQ_WAVE_TR=
APSTS_TRAP_AFTER_INST_MASK<br>
+#endif<br>
+<br>
&nbsp;// bits [31:24] unused by SPI debug data<br>
&nbsp;var TTMP11_SAVE_REPLAY_W64H_SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 31<br>
&nbsp;var TTMP11_SAVE_REPLAY_W64H_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x80000000<br>
@@ -224,7 +239,7 @@ L_NOT_HALTED:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Check non-maskable exce=
ptions. memory_violation, illegal_instruction<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // and xnack_error excepti=
ons always cause the wave to enter the trap<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // handler.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; ttmp2, s_save_trapsts, SQ_WAVE_TRAPSTS_MEM_VIOL_MASK|SQ_WAVE_TRAPS=
TS_ILLEGAL_INST_MASK<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; ttmp2, s_save_trapsts, S_TRAPSTS_NON_MASKABLE_EXCP_MASK<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc1&nbsp; L_FET=
CH_2ND_TRAP<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Check for maskable exce=
ptions in trapsts.excp and trapsts.excp_hi.<br>
<br>
base-commit: c4b562a17829454713e45219fa754be1bfda9004<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51445E95DC8E0591C52F5DAEF7462BL1PR12MB5144namp_--
