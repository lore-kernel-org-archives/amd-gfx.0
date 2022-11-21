Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D1FC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 02:02:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D09410E0A5;
	Mon, 21 Nov 2022 02:02:54 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB48E10E0A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 02:02:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOCk6t23oE9+oLYptMKYCke3G4OyTZSytZSzg9w0Xt5ynZ04Zycw3terTunHjPUN/zr5J/WuWUlBSvTuwfcFvrzVogwN3vUzlbT77kkcKu2ZlyLUinedjiAmQUcQC+ts4ncUO2BOAq3E8uHTAfieHANFBbeICYii8k1rq4db4dJ7llVNSM1tH0tAId+APLdmfcmr1wcebPLjVsbSOUjssg+mzMsbQJnSrQNDaX2jmgfDnu2UmglNBV/3PN49fwWBMe9mcm13LlWXx/hEFAPYh38iim1pKyjuPFBQ7AW6aqXQVcM3ZtotvRr67frTqQqmbKkwxMSYsly55Zkdc0GV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sVJ7+4h0Qo7pnRWamCUCRPMhid8t3ohLMKC4UhcTNY=;
 b=HkgEU7hWFOW245qoqtZqQl00GKlH/rLNQrImyOZf0zKuSmRXei3RgN1dYPQAPUA7ag4mOiIM3D17gBW1z0qPnU4aiKcwMr20hhZ9uU3St8EE3x/DELs3pYw7nysBmh+4fr0kiz12guy5I0uPoACevPDEylyAdh8mexNXn3BKyerYUOlLTzoHa1qJXGxF3QuNsC9eCkfmD1KT2YGJtEg6vEI42WwvvOdZBPYdyv3TCvp4L4ZU0ZT1jT2iQGCFYhv6b/YcdzSGd0vJO3lD4ONjs2ALUX7GhYJkPMUqD5SO14S9uYuup+utpwuq84oDh5kD8aIn4O94GRfnQvJBpDNqrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sVJ7+4h0Qo7pnRWamCUCRPMhid8t3ohLMKC4UhcTNY=;
 b=B6eD9rIXG0WK0lA5TTqzmC3q4ABd6UEHu1Zqi5LEjdyWte5829f30EmIOZXzB5uIqQ1svql0CmIqkqTa3BWsxbGX7C3SusvHcfG+WT4NRlx1PHhAT50pGAWPccT1nMKmkmz6lZWuV3unZvssiNtKqCcAdR/ZoBwLOzwBxO7DxZA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CO6PR12MB5410.namprd12.prod.outlook.com (2603:10b6:5:35b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Mon, 21 Nov
 2022 02:02:48 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::22d5:676b:e089:b677]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::22d5:676b:e089:b677%8]) with mapi id 15.20.5813.018; Mon, 21 Nov 2022
 02:02:48 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Enable bad memory page/channel recording
 support for smu v13_0_0
Thread-Topic: [PATCH] drm/amd/pm: Enable bad memory page/channel recording
 support for smu v13_0_0
Thread-Index: AQHY+9FnhNdhbk9e60uyi3eCbz4s6a5Iovqg
Date: Mon, 21 Nov 2022 02:02:48 +0000
Message-ID: <BN9PR12MB52570AFB2489973F3651A46BFC0A9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20221119044209.3881428-1-candice.li@amd.com>
In-Reply-To: <20221119044209.3881428-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=13a58078-3bc6-43b4-b885-ad5ad743af40;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-21T02:02:28Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CO6PR12MB5410:EE_
x-ms-office365-filtering-correlation-id: aabe1e96-ea90-4866-73ed-08dacb647d3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jeEnGizB3KCZPLn8lVmCr8Q1RXP3zLh+4Z7s6rfDkW/ZIk5gaxwe8syBPFTChY53DEWz1rXOOPNwGkEeAI7m2n9AjCuNytGaf8w/yy25rlmyyDcGMSrHJvi9nckC1Ukbt7T0oM7HYpQL01j211EcQxhHCtl2jABh2sXS/aZqOtNW/vP+2AEZihoeZDVak/+KNaXEu1mMx0xLWJH6jPzbHH7hjy7q3puxbcHtYvS+YjYfczXgi4G0CUEVr3DqF+PL0Is1iEOHGaL7dtKYoZIydulWhR32ndoHyuw+E98LGhhO539zh7NMI14g77M3QIO6glBqHugrwcg/oI8Nc4EMrneW5vZ1kxH5PBuVsPJFER2iSacRhZRGEzLplAMx49to2x7G3JB+myLhWZcJkE4iQxhzHUDozVo519Z2jgB3iu7AzyGzFsdsnNmqYxeF7/3Oa2iPuBIJLhEotk9v0uo0LUDjtGLnyZaO33DI8YOq5DBfDjbyf80qOUBwAbU4kHhW4UOArGZpi4vV8VFWq/qHDx7qVoGW4tkQ1qvYb9hnFGfK4Ou8HygBvmycmjkfuxcw7NlKNXF11jHguZRfu986ktAWJTQgjuQnkBXsO4ohXLOsCOavHuXu1Eq3sQGPYXSv/rD+qRqQhvOf0EUlKo6nF5KpP07LLwDULbcnfVdw+eYYAqUvos+EWFSaSvBAkKYuSy4Sg9Uxmx6NHng613t02w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199015)(66476007)(66946007)(8676002)(64756008)(86362001)(66556008)(66446008)(4326008)(76116006)(316002)(5660300002)(38070700005)(52536014)(8936002)(9686003)(33656002)(2906002)(478600001)(6506007)(53546011)(7696005)(186003)(41300700001)(26005)(83380400001)(122000001)(55016003)(38100700002)(71200400001)(110136005)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7UJIdxw6lgCSKjJtN1uoV28Ig2NEjO66YZwBAyRWtwvTMVQJRrKCquYqXjTx?=
 =?us-ascii?Q?XuZiMyEafDvmw/Xyz+kKPK2tsD7crMwiqrJWkGy4p0HAjKmPqmUM9fcyq6OT?=
 =?us-ascii?Q?DUvl0km8XdRa5KNlBSGO4eVkSL290kvClZwvgy2Se2x5RVsDObkpYS8dWnvb?=
 =?us-ascii?Q?/CzMn6PA9wmMG0vhCN4O/z6dho6NPLk4QD82Pao2RdagLLyUCnGVjUQbDEzT?=
 =?us-ascii?Q?Qpzsz1oZz9AwAh2g1QVLvY3FTyBrpnfunvrNYsAuH+jOC/Wmv1+jHaaAcig9?=
 =?us-ascii?Q?4FIiCh7m/pDQWEgBFvxfZiDeoI4NLK+kYxQ5g8OMy55likUFAPCyutpUl9yb?=
 =?us-ascii?Q?h3S1j7t1mitUleE1vX2pMUmQw4cGd+xFmV1hLmcHp8xVr80Pv1xh6gzjYAxG?=
 =?us-ascii?Q?kOpfmdfpkWaTUZJ3jFl9ZTac94gA9CtF1OZeyTWcU9y9TH1ileH9pUuQLk8m?=
 =?us-ascii?Q?C8tpIwATedr07gobXivjWbREb9yHbB5CzYgrzJlQsyWJesca9SgxCLM572ZB?=
 =?us-ascii?Q?EU3TQmZ8taFrf9uA7Mg1MjOssDO49Es0b56D+eXtF/7dmEqGvaym38NN//tf?=
 =?us-ascii?Q?sOepFVWnVuiKU6B9NrEkAPzuN+eTu9sK4IPmpnpBUR/9IyP+TFcT9aIMGA6Y?=
 =?us-ascii?Q?sHJf5ZEslXUvV4dSDPQ7gFHOQD6ekt/coFT1pHY1UPeq+Bt3SaQ/VmexmU+K?=
 =?us-ascii?Q?RbVhNgs9Wd796g/Mbtgv0b/l7+6aUg8BGchSVbgQCZ6jZj8I6mZA6DXKm9Pj?=
 =?us-ascii?Q?LXmg10PzwkmfOuzN3usWXbPd+uVpE1BrXBDEsZIV1fUcDr2KAYc/ihJxiAey?=
 =?us-ascii?Q?V4lOygFgaTIZL6ARYnub8NGvqkLW5ML1t3dfiHTe6X2HFpZbRZMchRAj2zxZ?=
 =?us-ascii?Q?L7qAFEfGT1aDvmkZ3Vom91+ZMUx9/CObirAjlN+lTJeu3RmyEQHi6LlfTRMf?=
 =?us-ascii?Q?g6bPtxf5SBs5TQQTfIaWTj+AD/mtVvGLZ1p1M73AhrbNG9/AfLiqfKrtVNVI?=
 =?us-ascii?Q?vY2azmyH1bw7CqskcgxlbL7AwEAp2cIktwUPNdC5NI4Nyv+fc0B/5dcEmiTp?=
 =?us-ascii?Q?iSpcKAzZDqBHelgzDlsDSlbcIglCw0Z5k9ovQNEqX/WgM4728Bfe/uPdiva4?=
 =?us-ascii?Q?GL98nT5uirDazdj4droyHhWogRWrIPivWZ0kCJpeicUfgDi0jUKxI0mb+qOX?=
 =?us-ascii?Q?jmLo+eucBrqARhzMaJG45ItcCDfD85cIBlOg3Bc+Rx5A6hNGK+TOLxKOV/1e?=
 =?us-ascii?Q?/vX8nMaAJBm/ry/otBHT2oUd/9DeUlAGKu74Nz+aFJJ8C/9bFHHAxm+Bk8zP?=
 =?us-ascii?Q?PFeY88/JRhtDD3YojemBDJZFuBobRQcKDrOqyYaD4E+2zPMMZCJbpRhz4IfW?=
 =?us-ascii?Q?+JnTWpfw90oZ1fzMSTcUpKN/P4YAA7GKaGHuEo3tZKE49sQMYsBmsfakDmh8?=
 =?us-ascii?Q?1WE9n6T7fGbth4tFUQTFUiHMLP6wQK1xjdmV4lFYHcpPkt6w1p0oGNSTU529?=
 =?us-ascii?Q?om7wzQiXoejDzGG3UM71AWQVMxqIkkczw1ERnXv6knjGUTPmRIjn+sTMWr7g?=
 =?us-ascii?Q?YWM5CKafpmrOWw0jKXQZv1QhbwaXM7zwOehoO1a/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aabe1e96-ea90-4866-73ed-08dacb647d3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 02:02:48.4512 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uDnil3GCG33FfcRbfFdz/ocLQyzA5bvMxgJLggTfMLPA2fqYtnHRPPJL19cAhBHMmX1hJljBK3hZsVZquNiqmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5410
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
Cc: "Li, Candice" <Candice.Li@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Saturday, November 19, 2022 12:42
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/pm: Enable bad memory page/channel recording suppo=
rt for smu v13_0_0

Send message to SMU to update bad memory page and bad channel info.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h  |  8 +++-  drivers/gpu/drm/a=
md/pm/swsmu/inc/smu_types.h  |  4 +-  .../drm/amd/pm/swsmu/smu13/smu_v13_0_=
0_ppt.c  | 39 +++++++++++++++++++
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h b=
/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
index 9ebb8f39732a0e..8b8266890a1002 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
@@ -131,7 +131,13 @@
 #define PPSMC_MSG_EnableAudioStutterWA           0x44
 #define PPSMC_MSG_PowerUpUmsch                   0x45
 #define PPSMC_MSG_PowerDownUmsch                 0x46
-#define PPSMC_Message_Count                      0x47
+#define PPSMC_MSG_SetDcsArch                     0x47
+#define PPSMC_MSG_TriggerVFFLR                   0x48
+#define PPSMC_MSG_SetNumBadMemoryPagesRetired    0x49
+#define PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel 0x4A
+#define PPSMC_MSG_SetPriorityDeltaGain           0x4B
+#define PPSMC_MSG_AllowIHHostInterrupt           0x4C
+#define PPSMC_Message_Count                      0x4D

 //Debug Dump Message
 #define DEBUGSMC_MSG_TestMessage                    0x1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_types.h
index 58098b82df660c..a4e3425b1027c2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -239,7 +239,9 @@
        __SMU_DUMMY_MAP(DriverMode2Reset), \
        __SMU_DUMMY_MAP(GetGfxOffStatus),                \
        __SMU_DUMMY_MAP(GetGfxOffEntryCount),            \
-       __SMU_DUMMY_MAP(LogGfxOffResidency),
+       __SMU_DUMMY_MAP(LogGfxOffResidency),                    \
+       __SMU_DUMMY_MAP(SetNumBadMemoryPagesRetired),           \
+       __SMU_DUMMY_MAP(SetBadMemoryPagesRetiredFlagsPerChannel),

 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)  SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 5bcb61f77e4193..87d7c66e49ef28 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -141,6 +141,9 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_=
map[SMU_MSG_MAX_COUNT] =3D
        MSG_MAP(PrepareMp1ForUnload,            PPSMC_MSG_PrepareMp1ForUnlo=
ad,         0),
        MSG_MAP(DFCstateControl,                PPSMC_MSG_SetExternalClient=
DfCstateAllow, 0),
        MSG_MAP(ArmD3,                          PPSMC_MSG_ArmD3,           =
            0),
+       MSG_MAP(SetNumBadMemoryPagesRetired,    PPSMC_MSG_SetNumBadMemoryPa=
gesRetired,   0),
+       MSG_MAP(SetBadMemoryPagesRetiredFlagsPerChannel,
+                           PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChann=
el,   0),
 };

 static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] =3D { @@=
 -1838,6 +1841,40 @@ static void smu_v13_0_0_set_smu_mailbox_registers(stru=
ct smu_context *smu)
        smu->debug_resp_reg =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_5=
4);  }

+static int smu_v13_0_0_smu_send_bad_mem_page_num(struct smu_context *smu,
+               uint32_t size)
+{
+       int ret =3D 0;
+
+       /* message SMU to update the bad page number on SMUBUS */
+       ret =3D smu_cmn_send_smc_msg_with_param(smu,
+                                         SMU_MSG_SetNumBadMemoryPagesRetir=
ed,
+                                         size, NULL);
+       if (ret)
+               dev_err(smu->adev->dev,
+                         "[%s] failed to message SMU to update bad memory =
pages number\n",
+                         __func__);
+
+       return ret;
+}
+
+static int smu_v13_0_0_send_bad_mem_channel_flag(struct smu_context *smu,
+               uint32_t size)
+{
+       int ret =3D 0;
+
+       /* message SMU to update the bad channel info on SMUBUS */
+       ret =3D smu_cmn_send_smc_msg_with_param(smu,
+                                 SMU_MSG_SetBadMemoryPagesRetiredFlagsPerC=
hannel,
+                                 size, NULL);
+       if (ret)
+               dev_err(smu->adev->dev,
+                         "[%s] failed to message SMU to update bad memory =
pages channel info\n",
+                         __func__);
+
+       return ret;
+}
+
 static const struct pptable_funcs smu_v13_0_0_ppt_funcs =3D {
        .get_allowed_feature_mask =3D smu_v13_0_0_get_allowed_feature_mask,
        .set_default_dpm_table =3D smu_v13_0_0_set_default_dpm_table,
@@ -1908,6 +1945,8 @@ static const struct pptable_funcs smu_v13_0_0_ppt_fun=
cs =3D {
        .mode1_reset =3D smu_v13_0_0_mode1_reset,
        .set_mp1_state =3D smu_v13_0_0_set_mp1_state,
        .set_df_cstate =3D smu_v13_0_0_set_df_cstate,
+       .send_hbm_bad_pages_num =3D smu_v13_0_0_smu_send_bad_mem_page_num,
+       .send_hbm_bad_channel_flag =3D smu_v13_0_0_send_bad_mem_channel_fla=
g,
 };

 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
--
2.25.1

