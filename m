Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A793C47258
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jan 2024 08:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACDC910E20F;
	Thu, 25 Jan 2024 08:53:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3020610E20F
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 08:53:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Spzbhxi4O+utHCbsTEvOrMbwQFEorA4o1N4aukU8H60s8OuGQ9wneu77DZU13dUzSs5R0tERo10LkIZpKAwCsJ7KH7W+wni/ofFwtIWQNanYCovVdEGPtdYQSFnnzBTw+zoqk6PT7Tj9WYSiVt0kTrezxFVy8a1U/+UokAt2xp7bjc2zViXnz920YdXCpnaWZBil+AeqlnYG8FL2JLSABFBtn6+cMlwoHDayKvl3vhw04ndXz7LHesqasWWRRk1py6DPmJZkajQkKNh0XIA94ymKphSQhTsGm7jD3tvSg25VqBBf2tN2jmZp5ZiVvIsBiQKHmc6D6S2qhpwjoWT7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmuQR1+XecJImv3JYlY/xLDQdaMnWWW/q6PapfEA1S8=;
 b=nHF5xCbuewHoDF3vHrKoQZJsUszMVu874Xje4wMqkoW2Q5Y4pH3G+I1Ksm6VB0pNPjn7osA5h2qTEAxYB68Zf9vCeiFAdJ18GznBj8FT4RydbIJB/2b40ggcBrN40uSpbR7gRqX8cQvf7HYeYzE/rh63sZxnk+1wDGL8MvBexf1zEDw+1pnGeMmrAj6oOERSOyY3wqQCHWU2pXDMpnqdoMWsXBWk4CeOmu/1td7boTvYNpRVaUcjAJF+ukOlco1FZu42Q2QZLQtwEUqu+DUP9tnTpNGwJSUo/erelfXVJOPZaiWEtY0d9tjEIH1/LlP5/XPM9xnJAGNBKuWOoRAm7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmuQR1+XecJImv3JYlY/xLDQdaMnWWW/q6PapfEA1S8=;
 b=iV2MpCPC1E02Owyb6IC/12Mm5H7gFgZaQZrdAxYeg1HP6mBF93xPpVjQ6bvaD2cZIFBIOzQw10rTXLNEdDRfJvwRqtiScMPkIlkF1aGM4+77RUuDE6BmEOBtZdtdN0k1DwKId2EFi6Yloe/TVR+ct3eGNbP9joNIEDHihyVAEps=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by PH7PR12MB7354.namprd12.prod.outlook.com (2603:10b6:510:20d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 08:53:07 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790%5]) with mapi id 15.20.7228.023; Thu, 25 Jan 2024
 08:53:07 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3] drm/amdgpu/pm: Use macro definitions in the smu IH
 process function
Thread-Topic: [PATCH v3] drm/amdgpu/pm: Use macro definitions in the smu IH
 process function
Thread-Index: AQHaT2uW7C0RqtK2vkWRRwFdLBaMk7DqON5A
Date: Thu, 25 Jan 2024 08:53:07 +0000
Message-ID: <PH7PR12MB5997BA87000E4286F30B56C8827A2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240125085018.1119071-1-Jun.Ma2@amd.com>
In-Reply-To: <20240125085018.1119071-1-Jun.Ma2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9f37b1ce-7b84-4a77-9cab-b1282b62be35;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-25T08:52:41Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|PH7PR12MB7354:EE_
x-ms-office365-filtering-correlation-id: 6f4f1b06-855d-463f-58bd-08dc1d830d29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6NNxXC7ceLmvfQSqIuErvCzL/6sJNAa2nH+RIT1sPKHMCPDtiGcudS9w2kUsn4LAcRppXmZENE5/oRgG83gUECZYHVDrKGFPp+9tzmTguWNv16KMWyjJ1NQRNxk9i1iGsiZ7FnGvaJPrs+BuKCXtpiN/H+Q3nt1qEkP3HZvvysCPVUolKHFWnvQWFRJvnmIlK+aHt3g4dehkotceDHMSNYihyBulUqfPZrfwdw6FH5Sq7v5I/P/WyVznhft43ZaAvOqz1IGEx0kfCV0/Iq7AMUwXHy/jvkKOldOEaYUknAqvdNhwZ1xnzX5tXMLI4FjyNfWsDVzhEfgOPlI62fSwuhBylfnelWaFvIevsLA+HzalDolFaf9dvHU8+9b+2nPMaFKh99YDZIVEBgfHp+CBL5f7PmQP1i724WXcj5wSe0ww+F92cdMrHEn0YrlTlVyPsDZxoCVV6F//JO3zLma3gmGPrJucFDII5URKCzc7h2eZbPBAso5YFZq3bDdFUkUisW1IHmLbfH4XfwbW1X5ytZ22wGdgneHpXVF5rik3eju4/eijJwmji1cFqhYT3jhyihUKBbNwARMvtN7NquHuqmuJZURbEvf2NYU2lvF0HfdwhttVskgM66MmKVLOKVmb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(136003)(39860400002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(41300700001)(83380400001)(52536014)(9686003)(38100700002)(26005)(122000001)(8676002)(4326008)(8936002)(5660300002)(66446008)(2906002)(478600001)(6506007)(7696005)(53546011)(71200400001)(66476007)(66556008)(54906003)(64756008)(76116006)(66946007)(316002)(110136005)(38070700009)(33656002)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ErjVCewXEMeGFTfX3mQteW+atvNDsBuUHPfQAAVrxWjupTRZuQBBgkvYFYag?=
 =?us-ascii?Q?n7ajjlnGw38X6+Gj6xzV0ImOJHkDZTPtgDZ8/XPI90m/LlOAU8IvTSbewDuL?=
 =?us-ascii?Q?D7kjTAwE6gS1ZCR+iQKt4MNhELo5UUQ6JsavFXybVEeT/xa7V2k3K3JqJ5cH?=
 =?us-ascii?Q?Y9UPYcgwneqhUv8+dLfxOkXggJUICa3GQYJ47gvM85gdh/tTr1qLWVOcIU/G?=
 =?us-ascii?Q?rcTfSFVlJ0/UMeT9gz0xKPbohG56Q/X/QO8kUEaZ3B1oELDQH7xun1kzaDpr?=
 =?us-ascii?Q?z4WWrxm1Xo7br9XaV04LPLr2JJ6zPfebOtFIKkUjt0j54fUyxkdUrtvlv7jN?=
 =?us-ascii?Q?f3L1FM6W550t8VRcz2t+DaC0lvJuL5jqA3H71RYoXNhGuJ1Py/W74wOV4JzM?=
 =?us-ascii?Q?rtWA+Srci5ohv+NKDSDPWMyAIdMyI+Ab0W/9GNwYuaqoipJM0A7uu7c4SxDG?=
 =?us-ascii?Q?ZcoyMB9rkOT3ovrUzv9MqBApqmVaKlBdT1cYmN8bFsW0RFCrm7fDJEkfDHXT?=
 =?us-ascii?Q?oThmcnuVDMYDiDWtO14Db0+7UgWMjNixxILlqW9ZmDfm7hCdi+IRKwfmPtyD?=
 =?us-ascii?Q?gE7HQS5hKuRyCAlDdG+o9XMN3iDesQwCX6v2roJ9QuTZZQkVxmV81z94LgI/?=
 =?us-ascii?Q?dmFS40HPxLI9KK6zH4N5hVsI0wKY28CFF4KJaANAhUI2+pfQN5BbY6XS1/2h?=
 =?us-ascii?Q?Q/YgjDcDrcmOfLIqmnQmHT5ZEeWZ7RZr+O4F99t6NHcoxfQRIEsJH8DtyqoX?=
 =?us-ascii?Q?9iR8xUfoYBIwAYlDmBSgniFCXmJbmjicQyap/mtGCYCSTSJxu3k3GnjzsRYM?=
 =?us-ascii?Q?NWZrB9BiJIDAQdv8rftn4ZoCLJuI6/PQiqGh3J7bXPHcqVji3p2z7Re2kFy8?=
 =?us-ascii?Q?ZkBk5CRsk4VQlvECH5U6/n5Fhyr3u5gyVYWboTNJR9gMgimtuNbUKd1diyOF?=
 =?us-ascii?Q?qz3mylc7gijyDMDEH2/6/mqcU/kadWcx1msh2FYPcJJG2Fgz5YK8E5CsQrkD?=
 =?us-ascii?Q?VEloorGHR9HbtksxhEo1zmLiqHoekMj+98N5e1ao5NHy2tixWXkdrL9ECkIJ?=
 =?us-ascii?Q?NZ7JMK/OMpsJ+TzNTlvKMoII+VuvCeuwA4cQjhQn8k42CVsggenWbLHn48WE?=
 =?us-ascii?Q?SrvEUZEjfd388LkVEGTVD4OGezyA3WyLJ3mpMNLd2oGe05yzxmP2rQWZLe9b?=
 =?us-ascii?Q?f+nfsavvvX9IA9dYNV/qUyT4C1T3ll4wTMqTnfOB3nGfC4BVsu0sIPlSxE01?=
 =?us-ascii?Q?vNi7u1Z0nEYURlOYvaw0tPBjzy7EgSBGHcfgwJEDm2dJyY+fr0CBX9BgTU7z?=
 =?us-ascii?Q?hWF/U9Ho3AlX9V9bgP/ripLHc6pb5Q9hZGenEmyvxOfZcv4g5OKJcG3e8DZY?=
 =?us-ascii?Q?88iLzOjxMU/ZPI4ggIkIZ6nLCG1mGej+sjHbTRIJ09VGHVH8HLNvfgYGxXcp?=
 =?us-ascii?Q?QYINTUVSR96RDF0ovgHeoSskXFw6DtbUUKeBy/u5bxU6bN3WqGQaQrsbZNzY?=
 =?us-ascii?Q?ArYFEmNAXSoQl0u3cFi8FU0md0AAVknLz4FMcx+r7VRg71qQCeu5nL6Sox4K?=
 =?us-ascii?Q?m1eFqfZLk3crNC28e3Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4f1b06-855d-463f-58bd-08dc1d830d29
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 08:53:07.8268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7GxN5L3gfVkUlQYjLKSXFx1G4c10RJQ5mFoX9CAMpJ7FnPE8Aju5HWYhD5pEtyCU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7354
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Ma, Jun <Jun.Ma2@amd.com>
Sent: Thursday, January 25, 2024 4:50 PM
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>;=
 Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYa=
ng.Wang@amd.com>; Ma, Jun <Jun.Ma2@amd.com>
Subject: [PATCH v3] drm/amdgpu/pm: Use macro definitions in the smu IH proc=
ess function

Replace the hard-coded numbers with macro definition

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
v3:
- Add new SMU_IH_INTERRUPT_* macros for smu, keeping the original macro def=
initions in sync with pmfw (kevin)
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 10 +++++-----  drivers/gp=
u/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 14 +++++++-------  drivers/gpu/drm/a=
md/pm/swsmu/smu14/smu_v14_0.c |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h         | 10 ++++++++++
 4 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c
index fbeb31bf9e48..f6545093bfc1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1432,24 +1432,24 @@ static int smu_v11_0_irq_process(struct amdgpu_devi=
ce *adev,
                dev_emerg(adev->dev, "ERROR: System is going to shutdown du=
e to GPU HW CTF!\n");
                orderly_poweroff(true);
        } else if (client_id =3D=3D SOC15_IH_CLIENTID_MP1) {
-               if (src_id =3D=3D 0xfe) {
+               if (src_id =3D=3D SMU_IH_INTERRUPT_ID_TO_DRIVER) {
                        /* ACK SMUToHost interrupt */
                        data =3D RREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_C=
TRL);
                        data =3D REG_SET_FIELD(data, MP1_SMN_IH_SW_INT_CTRL=
, INT_ACK, 1);
                        WREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL, data=
);

                        switch (ctxid) {
-                       case 0x3:
+                       case SMU_IH_INTERRUPT_CONTEXT_ID_AC:
                                dev_dbg(adev->dev, "Switched to AC mode!\n"=
);
                                schedule_work(&smu->interrupt_work);
                                adev->pm.ac_power =3D true;
                                break;
-                       case 0x4:
+                       case SMU_IH_INTERRUPT_CONTEXT_ID_DC:
                                dev_dbg(adev->dev, "Switched to DC mode!\n"=
);
                                schedule_work(&smu->interrupt_work);
                                adev->pm.ac_power =3D false;
                                break;
-                       case 0x7:
+                       case SMU_IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING=
:
                                /*
                                 * Increment the throttle interrupt counter
                                 */
@@ -1508,7 +1508,7 @@ int smu_v11_0_register_irq_handler(struct smu_context=
 *smu)
                return ret;

        ret =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
-                               0xfe,
+                               SMU_IH_INTERRUPT_ID_TO_DRIVER,
                                irq_src);
        if (ret)
                return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 1db74c0b5257..c13364830500 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1368,24 +1368,24 @@ static int smu_v13_0_irq_process(struct amdgpu_devi=
ce *adev,
                dev_emerg(adev->dev, "ERROR: System is going to shutdown du=
e to GPU HW CTF!\n");
                orderly_poweroff(true);
        } else if (client_id =3D=3D SOC15_IH_CLIENTID_MP1) {
-               if (src_id =3D=3D 0xfe) {
+               if (src_id =3D=3D SMU_IH_INTERRUPT_ID_TO_DRIVER) {
                        /* ACK SMUToHost interrupt */
                        data =3D RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_=
CTRL);
                        data =3D REG_SET_FIELD(data, MP1_SMN_IH_SW_INT_CTRL=
, INT_ACK, 1);
                        WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL, dat=
a);

                        switch (ctxid) {
-                       case 0x3:
+                       case SMU_IH_INTERRUPT_CONTEXT_ID_AC:
                                dev_dbg(adev->dev, "Switched to AC mode!\n"=
);
                                smu_v13_0_ack_ac_dc_interrupt(smu);
                                adev->pm.ac_power =3D true;
                                break;
-                       case 0x4:
+                       case SMU_IH_INTERRUPT_CONTEXT_ID_DC:
                                dev_dbg(adev->dev, "Switched to DC mode!\n"=
);
                                smu_v13_0_ack_ac_dc_interrupt(smu);
                                adev->pm.ac_power =3D false;
                                break;
-                       case 0x7:
+                       case SMU_IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING=
:
                                /*
                                 * Increment the throttle interrupt counter
                                 */
@@ -1398,7 +1398,7 @@ static int smu_v13_0_irq_process(struct amdgpu_device=
 *adev,
                                        schedule_work(&smu->throttling_logg=
ing_work);

                                break;
-                       case 0x8:
+                       case SMU_IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL:
                                high =3D smu->thermal_range.software_shutdo=
wn_temp +
                                        smu->thermal_range.software_shutdow=
n_temp_offset;
                                high =3D min_t(typeof(high),
@@ -1415,7 +1415,7 @@ static int smu_v13_0_irq_process(struct amdgpu_device=
 *adev,
                                data =3D data & (~THM_THERMAL_INT_CTRL__THE=
RM_TRIGGER_MASK_MASK);
                                WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTR=
L, data);
                                break;
-                       case 0x9:
+                       case SMU_IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY:
                                high =3D min_t(typeof(high),
                                             SMU_THERMAL_MAXIMUM_ALERT_TEMP=
,
                                             smu->thermal_range.software_sh=
utdown_temp);
@@ -1476,7 +1476,7 @@ int smu_v13_0_register_irq_handler(struct smu_context=
 *smu)
                return ret;

        ret =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
-                               0xfe,
+                               SMU_IH_INTERRUPT_ID_TO_DRIVER,
                                irq_src);
        if (ret)
                return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu14/smu_v14_0.c
index 4894f7ee737b..2aa7e9945a0b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -892,7 +892,7 @@ int smu_v14_0_register_irq_handler(struct smu_context *=
smu)
        // TODO: THM related

        ret =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
-                               0xfe,
+                               SMU_IH_INTERRUPT_ID_TO_DRIVER,
                                irq_src);
        if (ret)
                return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h
index cc590e27d88a..81bfce1406e5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -30,6 +30,16 @@
 #define FDO_PWM_MODE_STATIC  1
 #define FDO_PWM_MODE_STATIC_RPM 5

+#define SMU_IH_INTERRUPT_ID_TO_DRIVER                   0xFE
+#define SMU_IH_INTERRUPT_CONTEXT_ID_BACO                0x2
+#define SMU_IH_INTERRUPT_CONTEXT_ID_AC                  0x3
+#define SMU_IH_INTERRUPT_CONTEXT_ID_DC                  0x4
+#define SMU_IH_INTERRUPT_CONTEXT_ID_AUDIO_D0            0x5
+#define SMU_IH_INTERRUPT_CONTEXT_ID_AUDIO_D3            0x6
+#define SMU_IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
+#define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
+#define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
+
 extern const int link_speed[];

 /* Helper to Convert from PCIE Gen 1/2/3/4/5/6 to 0.1 GT/s speed units */
--
2.34.1

