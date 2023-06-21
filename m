Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70742EB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 04:12:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0F6A10E3AA;
	Wed, 21 Jun 2023 04:12:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6A5810E3AA
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 04:12:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFBryIWM2EHSGIqyp9vWLLI2XVuxtLBuUerBze9fHdM4/Tp2fjBFQasoWkaMZjgDrVhA3dexYjHdrsnCWOwr6ZFOLuaFFmaSNOzhNItY7cKoJn/6OyK1OHa1K2+FyKyfwMWl/EMPE35n5NtXB6a1IHqcogFoQVs8mc3vys6wiCJ39RkA8SsvTsKfn4SC6PiGz4AJmVG5uma0DkS/sq9PL0HIvHLrwWxl+nnvnyLLqQrd9UxdQi+/gwdUpgZ3Ov2bV5Oc2Db63EEo+KxSF3pUuDG4VhesOeafvRFnDVcRIUFI/7/Y3kwcuk1+C5tSU80DSdH2jLFNwZe/Y7eHOswZew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sH2nBdwEQufnG1LQ3Ei73sqCf7c0F3vEzBTCY9tz/Bc=;
 b=I1DNvp9fLFUENnuJKiFb2BUlinDkEqzX5ofXVjUKcvx2f4bEFOHpbiOf3qif3W9qiuBh3kYN3YcgckqbNh0PMouXPCuhV1iTBrSReRRbHFhqu/6txgWLXr1gQ+i2duv87ux7+Y7DjCn1t6dRIYkRc+G4R0dwCYjQRrdnfXSFf6pM3ExcMq+Ft/Vh4KJHKIZJZ8LTldjGf2Sv9eASqvK6aCrsQnX69GrIehNGtYtHaCf1dmPiGc9D5uz5erC+NtFQJKkdVwGJXW/x78Eu2Vqq0DWfa+DPubABa7ZLpjzCHpxE613u5UXMliogpb107zKCJxH4eBeNSkTdOXbqXazvQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sH2nBdwEQufnG1LQ3Ei73sqCf7c0F3vEzBTCY9tz/Bc=;
 b=K+JCc8KuAf5H01MEAhAiRS8tbe0Arx5x9vDuq9e6ZXPCQclUMem8wxtYx5nLxwP3b07lbKcBFxSRZz3vnroQVbDOKwA206Cd1HwxZ5Bd038VBjt83227r+Iz15pLMd7MBP+zGoDy51nComnVx+xkW8IY4ETZRAcntxHnch/9J4A=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH8PR12MB7027.namprd12.prod.outlook.com (2603:10b6:510:1be::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Wed, 21 Jun
 2023 04:12:21 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0%4]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 04:12:21 +0000
Content-Type: multipart/mixed;
 boundary="_000_BYAPR12MB46148161BB006E0FEE1EA355975DABYAPR12MB4614namp_"
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Yang, WenYou" <WenYou.Yang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Vangogh: Add new gpu_metrics_v2_4 to acquire
 gpu_metrics
Thread-Topic: [PATCH] drm/amd/pm: Vangogh: Add new gpu_metrics_v2_4 to acquire
 gpu_metrics
Thread-Index: AQHZlCnSboQ+1mU0yUyOCrjgCJtXKK+Uw7Rw
Date: Wed, 21 Jun 2023 04:12:21 +0000
Message-ID: <BYAPR12MB46148161BB006E0FEE1EA355975DA@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20230601013826.265885-1-WenYou.Yang@amd.com>
In-Reply-To: <20230601013826.265885-1-WenYou.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: <BYAPR12MB46148161BB006E0FEE1EA355975DA@BYAPR12MB4614.namprd12.prod.outlook.com>
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=70c81621-f39a-4e17-b8da-de9740f05dd0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-21T04:08:21Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4614:EE_|PH8PR12MB7027:EE_
x-ms-office365-filtering-correlation-id: 91c04f1f-532a-4082-c3ac-08db720db5ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N8Y24KkwKcLvVZBMHp4vGtZPCj9CDDsNXqwYhBYXuJcRCfX6DJgdUYBNXtFefyZjIgGeuid8Q8Cs9U5JFYRVCtGD4ISujUpazUksZMtyoCh4blnTeRPPqiBw4si7vxHmxbgbwnsU6QyjkfBrHMhvGzHMkWNDbLmpAS9mZm0CAylkI4DwfvsBxQMFrSafFac3AExzllUIvbs/Aa0vdOAwcx7ddpNdsOajmlyOehQytvmf0IeLWbq9L0Xa1M3xoG0/ICYDcVAZaVfh+CFMG+folQ+qLFwrxC7CXmUaflGgaqe2Xa31MR9ztU3FAR3Or2Qz6/KvKU+9NevI07joLlCcx5SICgK9wy5iTK0vQmhp3vy735xrXzqOgWOCMEBIYnrSV/c0M2HZ9EZe4pcUuWrG34+FixGVL2FToNudu+J07E6wgy7+tEUbswfWZy1g1PLnNxLjIDC5gBIjNII/nl8nqp6kvkA5xnwdXdKQpp6dxqC5cPj/jkf/Sz+Pl8DjEVjsm2VRiyTO5Pxhi262dotM5I1gcSH4Gv8vZPcY4BrAdtcB11Hq6daM8Xjt3ITSuIWh9Caw97yN44m18U1xX7id6nFPG5slBH8zdZkqdfytvjFG6nrPTBs1HWIij+fkoNirDUc6CSOeXFIAflxbCUuTnnHGhz6qPRvdJsvsJHXLfp8vYMKaU6MqXUk7fQfiAAl3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(38070700005)(41300700001)(5660300002)(52536014)(8676002)(8936002)(2906002)(33656002)(55016003)(86362001)(9686003)(6506007)(53546011)(26005)(54906003)(186003)(110136005)(478600001)(7696005)(71200400001)(66556008)(64756008)(76116006)(66446008)(6636002)(122000001)(66476007)(921005)(4326008)(66946007)(316002)(38100700002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DcrUavYgUZyN7Oo8eznr40nv9lG52f52TtQAh2NBhbg+T+XWOzLpLwQnHFpX?=
 =?us-ascii?Q?cH+OZQv8MBek50k+FSaBAJj7HUsBDdp1s5D2GFZLSYzrljvBkZdlIAZo/N8F?=
 =?us-ascii?Q?Zewggk6ehHPO4A0AAV5h+QBIGtWADFRMJLTOmCZylv3f7IeUiGzEDN0ruaq5?=
 =?us-ascii?Q?U4Jsx9syksU34/X3ZkXIPpGBfVaL9CLLInDyhHPkzateqbJl48y+Ul+M5h5B?=
 =?us-ascii?Q?JU2ckKtvgCfwYKGwx6a7jR2ao03BkRMsksv307hFMQgPhPRktf+M7W13MrMt?=
 =?us-ascii?Q?gDAwANtXg+p1UhZ8TvZCezIpOmVBgB8tT9XwreqjCepf+SAa+ssYoV4lpbZq?=
 =?us-ascii?Q?VgYWzMmsL0GSZUJqbN6CFPtLG3z0+YacstIcGuIFaRN8GmzLn3x70b0ih0dQ?=
 =?us-ascii?Q?gffeaM4kUjMMlkxQPlsW24WL0uhvL0zDqqV0DJ5OxF/I695P2+k9B5EBD5PD?=
 =?us-ascii?Q?LF94wKyNVQY7RApWmyUzOqz43w2G1oeJ35Z78EL7+ocRdKCpCp4z8ukQknCq?=
 =?us-ascii?Q?O1dKK9EAAQbt7M/uyXn/avJuba20XNebgOqmFaU877GtHfkar3vmX2z2aD/9?=
 =?us-ascii?Q?eFj15vgMnroOTYUxcsV85ClyP7ezym0PhDECi0NzprGWR2qnpjcJkpH0v8Yv?=
 =?us-ascii?Q?OxhV1wMxXsJEUWAVrlqWMbLYSt5XMCYLVKx3HUV5kpeRn0W790LLcXw15i/4?=
 =?us-ascii?Q?iK1ql1eyhnJOpqzDxMOUFQ+49G0s2joaviLh1tTIE0MmI8LsV6Xn+Cg/L/ok?=
 =?us-ascii?Q?UM/FY6SSw4tCqg055EBK8WjVeTL6v/cgkicU1sQgtkfAl885UJ0UW+vs4++2?=
 =?us-ascii?Q?l+Sul8kELnIKV6SD9mA8zoUWZclZBOTBCJbqLs9Oz+bdA/m9BZFQCao5Kh20?=
 =?us-ascii?Q?TueN68O9SwxzZ1qg0TGF45K3DsKBv/iC0KwqGgGHSOYDorgmlxf0mDj0deMq?=
 =?us-ascii?Q?s4LNxR/vCAUEv2b44Le2KHgEsZJPyKtiN10D3l1WXeXrK3GqKAFHDJyUwR9N?=
 =?us-ascii?Q?BVa8Pu+cnBvyM3aYvRdua1IQORqTW1YbfYJ+O6aYgyflVn1TZO94zWNaO8FB?=
 =?us-ascii?Q?WAiSNwVKkk1QhrupajCnJs96lGCrDI+rNV6/y5Fv4H6yOSCI5k0alJ0RBo7a?=
 =?us-ascii?Q?irq4FDYuxIw7vB/YNbOGbm1AxveaB5b+t+txa/BMpxAtj8FKrKZ3maDIDYdR?=
 =?us-ascii?Q?cJqTWl6Sy4bT2X3stgGRsyL4fEM+OmpY31f3g1l3l/yStY63PztynueCIjwp?=
 =?us-ascii?Q?ha1Y3sIX1yRUs0tyIsnT1rBhNUEmkeAysLP4BHbUd0MzKF6u+dW2oyyJEUKl?=
 =?us-ascii?Q?HAG+ljlJwSiyUSFpIi7kF8lWkacARObQJKS2cqqCG4+xB9nuz+HbNNFf1HBP?=
 =?us-ascii?Q?3QJ2huLSqSgI+BHS12iGXubbYufC1DmyZo83Nr9eb0iUeGuwatfQFMqIijv0?=
 =?us-ascii?Q?5XbN2Lhef7gmyzXCvGLqPX9nunoZbSkIEh1U1GjvrIPuvI83Sx+hurjn1ppf?=
 =?us-ascii?Q?qx5uriZAhiGNTh4WC4HBsP8R6/OoePEywAQT8tIFi6jzJx/bOF5h2RTBk5OQ?=
 =?us-ascii?Q?NwL/jF9N6XCfpRnzZa0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c04f1f-532a-4082-c3ac-08db720db5ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 04:12:21.0943 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V327KqENJ58vk95x18TXKQHvJEckXHSyyqkTY9seehaH1luZhqRqcRFzt2JXSsqn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7027
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Yang, 
 WenYou" <WenYou.Yang@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Liang, 
 Richard qi" <Richardqi.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BYAPR12MB46148161BB006E0FEE1EA355975DABYAPR12MB4614namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Could you add the expected units of voltage/current in 2.4 metrics structur=
e? Is it mV/mA or mV/A?

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Wenyou Y=
ang
Sent: Thursday, June 1, 2023 7:08 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Limonciello, Mario <Mar=
io.Limonciello@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Pan,=
 Xinhui <Xinhui.Pan@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Cc: linux-kernel@vger.kernel.org; dri-devel@lists.freedesktop.org; Yang, We=
nYou <WenYou.Yang@amd.com>; amd-gfx@lists.freedesktop.org; Yuan, Perry <Per=
ry.Yuan@amd.com>; Liang, Richard qi <Richardqi.Liang@amd.com>
Subject: [PATCH] drm/amd/pm: Vangogh: Add new gpu_metrics_v2_4 to acquire g=
pu_metrics

To acquire the voltage and current info from gpu_metrics interface, but gpu=
_metrics_v2_3 doesn't contain them, and to be backward compatible, add new =
gpu_metrics_v2_4 structure.

Acked-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  69 +++++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 109 ++++++++++++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   3 +
 3 files changed, 172 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index 9f542f6e19ed..0f37dafafcf9 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -892,4 +892,73 @@ struct gpu_metrics_v2_3 {
        uint16_t                        average_temperature_core[8]; // ave=
rage CPU core temperature on APUs
        uint16_t                        average_temperature_l3[2];
 };
+
+struct gpu_metrics_v2_4 {
+       struct metrics_table_header     common_header;
+
+       /* Temperature */
+       uint16_t                        temperature_gfx;
+       uint16_t                        temperature_soc;
+       uint16_t                        temperature_core[8];
+       uint16_t                        temperature_l3[2];
+
+       /* Utilization */
+       uint16_t                        average_gfx_activity;
+       uint16_t                        average_mm_activity;
+
+       /* Driver attached timestamp (in ns) */
+       uint64_t                        system_clock_counter;
+
+       /* Power/Energy */
+       uint16_t                        average_socket_power;
+       uint16_t                        average_cpu_power;
+       uint16_t                        average_soc_power;
+       uint16_t                        average_gfx_power;
+       uint16_t                        average_core_power[8];
+
+       /* Average clocks */
+       uint16_t                        average_gfxclk_frequency;
+       uint16_t                        average_socclk_frequency;
+       uint16_t                        average_uclk_frequency;
+       uint16_t                        average_fclk_frequency;
+       uint16_t                        average_vclk_frequency;
+       uint16_t                        average_dclk_frequency;
+
+       /* Current clocks */
+       uint16_t                        current_gfxclk;
+       uint16_t                        current_socclk;
+       uint16_t                        current_uclk;
+       uint16_t                        current_fclk;
+       uint16_t                        current_vclk;
+       uint16_t                        current_dclk;
+       uint16_t                        current_coreclk[8];
+       uint16_t                        current_l3clk[2];
+
+       /* Throttle status (ASIC dependent) */
+       uint32_t                        throttle_status;
+
+       /* Fans */
+       uint16_t                        fan_pwm;
+
+       uint16_t                        padding[3];
+
+       /* Throttle status (ASIC independent) */
+       uint64_t                        indep_throttle_status;
+
+       /* Average Temperature */
+       uint16_t                        average_temperature_gfx;
+       uint16_t                        average_temperature_soc;
+       uint16_t                        average_temperature_core[8];
+       uint16_t                        average_temperature_l3[2];
+
+       /* Power/Voltage */
+       uint16_t                        average_cpu_voltage;
+       uint16_t                        average_soc_voltage;
+       uint16_t                        average_gfx_voltage;
+
+       /* Power/Current */
+       uint16_t                        average_cpu_current;
+       uint16_t                        average_soc_current;
+       uint16_t                        average_gfx_current;
+};
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 067b4e0b026c..185d0b50ee8e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1854,6 +1854,86 @@ static ssize_t vangogh_get_gpu_metrics_v2_3(struct s=
mu_context *smu,
        return sizeof(struct gpu_metrics_v2_3);  }

+static ssize_t vangogh_get_gpu_metrics_v2_4(struct smu_context *smu,
+                                           void **table)
+{
+       SmuMetrics_t metrics;
+       struct smu_table_context *smu_table =3D &smu->smu_table;
+       struct gpu_metrics_v2_4 *gpu_metrics =3D
+                               (struct gpu_metrics_v2_4 *)smu_table->gpu_m=
etrics_table;
+       int ret =3D 0;
+
+       ret =3D smu_cmn_get_metrics_table(smu, &metrics, true);
+       if (ret)
+               return ret;
+
+       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 4);
+
+       gpu_metrics->temperature_gfx =3D metrics.Current.GfxTemperature;
+       gpu_metrics->temperature_soc =3D metrics.Current.SocTemperature;
+       memcpy(&gpu_metrics->temperature_core[0],
+              &metrics.Current.CoreTemperature[0],
+              sizeof(uint16_t) * 4);
+       gpu_metrics->temperature_l3[0] =3D metrics.Current.L3Temperature[0]=
;
+
+       gpu_metrics->average_temperature_gfx =3D metrics.Average.GfxTempera=
ture;
+       gpu_metrics->average_temperature_soc =3D metrics.Average.SocTempera=
ture;
+       memcpy(&gpu_metrics->average_temperature_core[0],
+              &metrics.Average.CoreTemperature[0],
+              sizeof(uint16_t) * 4);
+       gpu_metrics->average_temperature_l3[0] =3D
+metrics.Average.L3Temperature[0];
+
+       gpu_metrics->average_gfx_activity =3D metrics.Current.GfxActivity;
+       gpu_metrics->average_mm_activity =3D metrics.Current.UvdActivity;
+
+       gpu_metrics->average_socket_power =3D metrics.Current.CurrentSocket=
Power;
+       gpu_metrics->average_cpu_power =3D metrics.Current.Power[0];
+       gpu_metrics->average_soc_power =3D metrics.Current.Power[1];
+       gpu_metrics->average_gfx_power =3D metrics.Current.Power[2];
+
+       gpu_metrics->average_cpu_voltage =3D metrics.Current.Voltage[0];
+       gpu_metrics->average_soc_voltage =3D metrics.Current.Voltage[1];
+       gpu_metrics->average_gfx_voltage =3D metrics.Current.Voltage[2];
+
+       gpu_metrics->average_cpu_current =3D metrics.Current.Current[0];
+       gpu_metrics->average_soc_current =3D metrics.Current.Current[1];
+       gpu_metrics->average_gfx_current =3D metrics.Current.Current[2];
+
+       memcpy(&gpu_metrics->average_core_power[0],
+              &metrics.Average.CorePower[0],
+              sizeof(uint16_t) * 4);
+
+       gpu_metrics->average_gfxclk_frequency =3D metrics.Average.GfxclkFre=
quency;
+       gpu_metrics->average_socclk_frequency =3D metrics.Average.SocclkFre=
quency;
+       gpu_metrics->average_uclk_frequency =3D metrics.Average.MemclkFrequ=
ency;
+       gpu_metrics->average_fclk_frequency =3D metrics.Average.MemclkFrequ=
ency;
+       gpu_metrics->average_vclk_frequency =3D metrics.Average.VclkFrequen=
cy;
+       gpu_metrics->average_dclk_frequency =3D metrics.Average.DclkFrequen=
cy;
+
+       gpu_metrics->current_gfxclk =3D metrics.Current.GfxclkFrequency;
+       gpu_metrics->current_socclk =3D metrics.Current.SocclkFrequency;
+       gpu_metrics->current_uclk =3D metrics.Current.MemclkFrequency;
+       gpu_metrics->current_fclk =3D metrics.Current.MemclkFrequency;
+       gpu_metrics->current_vclk =3D metrics.Current.VclkFrequency;
+       gpu_metrics->current_dclk =3D metrics.Current.DclkFrequency;
+
+       memcpy(&gpu_metrics->current_coreclk[0],
+              &metrics.Current.CoreFrequency[0],
+              sizeof(uint16_t) * 4);
+       gpu_metrics->current_l3clk[0] =3D metrics.Current.L3Frequency[0];
+
+       gpu_metrics->throttle_status =3D metrics.Current.ThrottlerStatus;
+       gpu_metrics->indep_throttle_status =3D
+                       smu_cmn_get_indep_throttler_status(metrics.Current.=
ThrottlerStatus,
+                                                          vangogh_throttle=
r_map);
+
+       gpu_metrics->system_clock_counter =3D ktime_get_boottime_ns();
+
+       *table =3D (void *)gpu_metrics;
+
+       return sizeof(struct gpu_metrics_v2_4); }
+
 static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
                                      void **table)
 {
@@ -1923,23 +2003,34 @@ static ssize_t vangogh_common_get_gpu_metrics(struc=
t smu_context *smu,  {
        uint32_t if_version;
        uint32_t smu_version;
+       uint32_t smu_program;
+       uint32_t fw_version;
        int ret =3D 0;

        ret =3D smu_cmn_get_smc_version(smu, &if_version, &smu_version);
-       if (ret) {
+       if (ret)
                return ret;
-       }

-       if (smu_version >=3D 0x043F3E00) {
-               if (if_version < 0x3)
-                       ret =3D vangogh_get_legacy_gpu_metrics_v2_3(smu, ta=
ble);
+       smu_program =3D (smu_version >> 24) & 0xff;
+       fw_version =3D smu_version & 0xffffff;
+       if (smu_program =3D=3D 6) {
+               if (fw_version >=3D 0x3F0800)
+                       ret =3D vangogh_get_gpu_metrics_v2_4(smu, table);
                else
                        ret =3D vangogh_get_gpu_metrics_v2_3(smu, table);
+
        } else {
-               if (if_version < 0x3)
-                       ret =3D vangogh_get_legacy_gpu_metrics(smu, table);
-               else
-                       ret =3D vangogh_get_gpu_metrics(smu, table);
+               if (smu_version >=3D 0x043F3E00) {
+                       if (if_version < 0x3)
+                               ret =3D vangogh_get_legacy_gpu_metrics_v2_3=
(smu, table);
+                       else
+                               ret =3D vangogh_get_gpu_metrics_v2_3(smu, t=
able);
+               } else {
+                       if (if_version < 0x3)
+                               ret =3D vangogh_get_legacy_gpu_metrics(smu,=
 table);
+                       else
+                               ret =3D vangogh_get_gpu_metrics(smu, table)=
;
+               }
        }

        return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index 3ecb900e6ecd..cee5e32b4ff9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -996,6 +996,9 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t=
 frev, uint8_t crev)
        case METRICS_VERSION(2, 3):
                structure_size =3D sizeof(struct gpu_metrics_v2_3);
                break;
+       case METRICS_VERSION(2, 4):
+               structure_size =3D sizeof(struct gpu_metrics_v2_4);
+               break;
        default:
                return;
        }
--
2.39.2


--_000_BYAPR12MB46148161BB006E0FEE1EA355975DABYAPR12MB4614namp_
Content-Disposition: attachment; filename="winmail.dat"
Content-Transfer-Encoding: base64
Content-Type: application/ms-tnef; name="winmail.dat"

eJ8+ImMlAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEJgAEAIQAAADlDN0REMjlD
NDNENjA0NDg4RTU0RjcyNkNBQkQ1MTUyADwHAQ2ABAACAAAAAgACAAEFgAMADgAAAOcHBgAVAAQA
DAAVAAMAMQEBIIADAA4AAADnBwYAFQAEAAwAFQADADEBAQiABwAYAAAASVBNLk1pY3Jvc29mdCBN
YWlsLk5vdGUAMQgBBIABAFEAAABSRTogW1BBVENIXSBkcm0vYW1kL3BtOiBWYW5nb2doOiBBZGQg
bmV3IGdwdV9tZXRyaWNzX3YyXzQgdG8gYWNxdWlyZSBncHVfbWV0cmljcwAFHAEDkAYArEcAAGoA
AAACAX8AAQAAAFEAAAA8QllBUFIxMk1CNDYxNDgxNjFCQjAwNkUwRkVFMUVBMzU1OTc1REFAQllB
UFIxMk1CNDYxNC5uYW1wcmQxMi5wcm9kLm91dGxvb2suY29tPgAAAAALAB8OAAAAAAIBCRABAAAA
TA8AAEgPAAD2MwAATFpGdRHSn8BhAApmYmlkBAAAY2PAcGcxMjUyAP4DQ/B0ZXh0AfcCpAPjAgAE
Y2gKwHNldDAg7wdtAoMAUBFNMgqABrQCgJZ9CoAIyDsJYjE5DsC/CcMWcgoyFnECgBViKgmwcwnw
BJBhdAWyDlADYHOibwGAIEV4EcFuGDBdBlJ2BJAXtgIQcgDAdH0IUG4aMRAgBcAFoBtkZJogA1Ig
ECIXslx2CJDkd2sLgGQ1HVME8AdADRdwMApxF/Jia21rBnMBkAAgIEJNX0LgRUdJTn0K/AHxC/AA
MiBbQU1EIE9nASAOUAcxIFUSACHgbkBseSAtIEcYQ2zoXVxsC4BlCoEjxAhRimwcYHkIYCBhZBxg
bHRoGeAQMHAFkBxCdc0DAHQEIBkwIHYG8AGQuRgwL2MIcAlwAjAgC4CgIDIuNCAHgHQFEGZjBCAf
YHJ1JfAIcGU4PyBJBCAmYCgwVi+cbUEmkAXAKdFBPyO8FlQZoR9QLCO1TGlqqm8jvC0tkk8FEGcL
gHUiUU0HkHMnES2TI7VGBQNhOiUgbWQtZ2ZoeCA8MAUtBuAmQGPNB5BAI8AfYHMuA1AJ4EkBAHNr
GJBwLgWwZ9Y+IrEfsGUR0GwmsCHw7CBXCfAk8lkZsSO1BmAPAjAv4CuQCHBzZGF52CwgSiZAGeAx
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
AEwAYQB6AGEAcgBAAGEAbQBkAC4AYwBvAG0AAAAAAB8A5V8BAAAALgAAAHMAaQBwADoAbABpAGoA
bwAuAGwAYQB6AGEAcgBAAGEAbQBkAC4AYwBvAG0AAAAAAB8AGgwBAAAAGAAAAEwAYQB6AGEAcgAs
ACAATABpAGoAbwAAAB8AHwwBAAAAJgAAAEwAaQBqAG8ALgBMAGEAegBhAHIAQABhAG0AZAAuAGMA
bwBtAAAAAAAfAB4MAQAAAAoAAABTAE0AVABQAAAAAAACARkMAQAAAGAAAAAAAAAAgSsfpL6jEBmd
bgDdAQ9UAgAAAIBMAGEAegBhAHIALAAgAEwAaQBqAG8AAABTAE0AVABQAAAATABpAGoAbwAuAEwA
YQB6AGEAcgBAAGEAbQBkAC4AYwBvAG0AAAAfAAFdAQAAACYAAABMAGkAagBvAC4ATABhAHoAYQBy
AEAAYQBtAGQALgBjAG8AbQAAAAAACwBAOgEAAAAfABoAAQAAABIAAABJAFAATQAuAE4AbwB0AGUA
AAAAAAMA8T8JBAAACwBAOgEAAAADAP0/5AQAAAIBCzABAAAAEAAAAJx90pxD1gRIjlT3Jsq9UVID
ABcAAQAAAEAAOQCAgCOT9qPZAUAACDAMTC2T9qPZAQsAKQAAAAAAHwDZPwEAAAAAAgAAQwBvAHUA
bABkACAAeQBvAHUAIABhAGQAZAAgAHQAaABlACAAZQB4AHAAZQBjAHQAZQBkACAAdQBuAGkAdABz
ACAAbwBmACAAdgBvAGwAdABhAGcAZQAvAGMAdQByAHIAZQBuAHQAIABpAG4AIAAyAC4ANAAgAG0A
ZQB0AHIAaQBjAHMAIABzAHQAcgB1AGMAdAB1AHIAZQA/ACAASQBzACAAaQB0ACAAbQBWAC8AbQBB
ACAAbwByACAAbQBWAC8AQQA/AA0ACgANAAoAVABoAGEAbgBrAHMALAANAAoATABpAGoAbwANAAoA
DQAKAC0ALQAtAC0ALQBPAHIAaQBnAGkAbgBhAGwAIABNAGUAcwBzAGEAZwBlAC0ALQAtAC0ALQAN
AAoARgByAG8AbQA6ACAAYQBtAGQALQBnAGYAeAAgADwAYQBtAGQALQBnAGYAeAAtAGIAbwB1AG4A
YwBlAHMAQABsAGkAcwB0AHMALgBmAHIAZQBlAGQAZQBzAGsAdABvAHAALgBvAHIAZwA+ACAATwBu
ACAAQgBlAGgAYQBsAGYAIABPAGYAIABXAGUAbgB5AG8AdQAgAFkAYQBuAGcADQAKAFMAZQBuAHQA
OgAgAFQAaAB1AHIAcwBkAGEAeQAsACAASgB1AG4AZQAgADEALAAgADIAMAAyADMAAAALAACACCAG
AAAAAADAAAAAAAAARgAAAAAUhQAAAAAAAAsAIwAAAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAA
HgAAAGEAYwBjAGUAcAB0AGwAYQBuAGcAdQBhAGcAZQAAAAAAAQAAAAwAAABlAG4ALQBVAFMAAAAD
AACACCAGAAAAAADAAAAAAAAARgEAAAAyAAAARQB4AGMAaABhAG4AZwBlAEEAcABwAGwAaQBjAGEA
dABpAG8AbgBGAGwAYQBnAHMAAAAAACAAAABIAACACCAGAAAAAADAAAAAAAAARgEAAAAiAAAATgBl
AHQAdwBvAHIAawBNAGUAcwBzAGEAZwBlAEkAZAAAAAAAH0/AkSpTgkDDrAjbcg21rB8AAIATj/JB
9IMUQaWE7ttaawv/AQAAABYAAABDAGwAaQBlAG4AdABJAG4AZgBvAAAAAAABAAAAKgAAAEMAbABp
AGUAbgB0AD0ATQBTAEUAeABjAGgAYQBuAGcAZQBSAFAAQwAAAAAAHwAAgIYDAgAAAAAAwAAAAAAA
AEYBAAAAGAAAAG0AcwBpAHAAXwBsAGEAYgBlAGwAcwAAAAEAAAAABAAATQBTAEkAUABfAEwAYQBi
AGUAbABfADQAMwA0ADIAMwAxADQAZQAtADAAZABmADQALQA0AGIANQA4AC0AOAA0AGIAZgAtADMA
OABiAGUAZAA2ADEANwAwAGEAMABmAF8AQQBjAHQAaQBvAG4ASQBkAD0ANwAwAGMAOAAxADYAMgAx
AC0AZgAzADkAYQAtADQAZQAxADcALQBiADgAZABhAC0AZABlADkANwA0ADAAZgAwADUAZABkADAA
OwBNAFMASQBQAF8ATABhAGIAZQBsAF8ANAAzADQAMgAzADEANABlAC0AMABkAGYANAAtADQAYgA1
ADgALQA4ADQAYgBmAC0AMwA4AGIAZQBkADYAMQA3ADAAYQAwAGYAXwBDAG8AbgB0AGUAbgB0AEIA
aQB0AHMAPQAwADsATQBTAEkAUABfAEwAYQBiAGUAbABfADQAMwA0ADIAMwAxADQAZQAtADAAZABm
ADQALQA0AGIANQA4AC0AOAA0AGIAZgAtADMAOABiAGUAZAA2ADEANwAwAGEAMABmAF8ARQBuAGEA
YgBsAGUAZAA9AHQAcgB1AGUAOwBNAFMASQBQAF8ATABhAGIAZQBsAF8ANAAzADQAMgAzADEANABl
AC0AMABkAGYANAAtADQAYgA1ADgALQA4ADQAYgBmAC0AMwA4AGIAZQBkADYAMQA3ADAAYQAwAGYA
XwBNAGUAdABoAG8AZAA9AFMAdABhAG4AZABhAHIAZAA7AE0AUwBJAFAAXwBMAGEAYgBlAGwAXwA0
ADMANAAyADMAMQA0AGUALQAwAGQAZgA0AC0ANABiADUAOAAtADgANABiAGYALQAzADgAYgBlAGQA
NgAxADcAMABhADAAZgBfAE4AYQBtAGUAPQBHAGUAbgBlAHIAYQBsADsATQBTAEkAUABfAEwAYQBi
AGUAbABfADQAMwA0ADIAMwAxADQAZQAtADAAZABmADQALQA0AGIANQA4AC0AOAA0AGIAZgAtADMA
OABiAGUAZAA2ADEANwAwAGEAMABmAF8AUwBlAHQARABhAHQAZQA9ADIAMAAyADMALQAwADYALQAy
ADEAVAAwADQAOgAwADgAOgAyADEAWgA7AE0AUwBJAFAAXwBMAGEAYgBlAGwAXwA0ADMANAAyADMA
MQA0AGUALQAwAGQAZgA0AC0ANABiADUAOAAtADgANABiAGYALQAzADgAYgBlAGQANgAxADcAMABh
ADAAZgBfAFMAaQB0AGUASQBkAD0AMwBkAGQAOAA5ADYAMQBmAC0AZQA0ADgAOAAtADQAZQA2ADAA
LQA4AGUAMQAxAC0AYQA4ADIAZAA5ADkANABlADEAOAAzAGQAOwAAAEgAAIBrxT9AMM3FR4b47enj
WgIrAQAAABwAAABNAFMASQBQAEwAYQBiAGUAbABHAHUAaQBkAAAATjFCQ/QNWEuEvzi+1hcKDx8A
+j8BAAAAGAAAAEwAYQB6AGEAcgAsACAATABpAGoAbwAAAAsAAIAIIAYAAAAAAMAAAAAAAABGAAAA
AAaFAAAAAAAAHwA3AAEAAACiAAAAUgBFADoAIABbAFAAQQBUAEMASABdACAAZAByAG0ALwBhAG0A
ZAAvAHAAbQA6ACAAVgBhAG4AZwBvAGcAaAA6ACAAQQBkAGQAIABuAGUAdwAgAGcAcAB1AF8AbQBl
AHQAcgBpAGMAcwBfAHYAMgBfADQAIAB0AG8AIABhAGMAcQB1AGkAcgBlACAAZwBwAHUAXwBtAGUA
dAByAGkAYwBzAAAAAAAfAD0AAQAAAAoAAABSAEUAOgAgAAAAAAADADYAAAAAAAMALgAAAAAAHwBC
EAEAAABcAAAAPAAyADAAMgAzADAANgAwADEAMAAxADMAOAAyADYALgAyADYANQA4ADgANQAtADEA
LQBXAGUAbgBZAG8AdQAuAFkAYQBuAGcAQABhAG0AZAAuAGMAbwBtAD4AAAACAXEAAQAAABsAAAAB
AdmUKdJuhD7WZTTJTI4KuOAIm1cor5TDtHAAHwBwAAEAAACaAAAAWwBQAEEAVABDAEgAXQAgAGQA
cgBtAC8AYQBtAGQALwBwAG0AOgAgAFYAYQBuAGcAbwBnAGgAOgAgAEEAZABkACAAbgBlAHcAIABn
AHAAdQBfAG0AZQB0AHIAaQBjAHMAXwB2ADIAXwA0ACAAdABvACAAYQBjAHEAdQBpAHIAZQAgAGcA
cAB1AF8AbQBlAHQAcgBpAGMAcwAAAAAAHwA1EAEAAACiAAAAPABCAFkAQQBQAFIAMQAyAE0AQgA0
ADYAMQA0ADgAMQA2ADEAQgBCADAAMAA2AEUAMABGAEUARQAxAEUAQQAzADUANQA5ADcANQBEAEEA
QABCAFkAQQBQAFIAMQAyAE0AQgA0ADYAMQA0AC4AbgBhAG0AcAByAGQAMQAyAC4AcAByAG8AZAAu
AG8AdQB0AGwAbwBvAGsALgBjAG8AbQA+AAAAAAAfADkQAQAAAFwAAAA8ADIAMAAyADMAMAA2ADAA
MQAwADEAMwA4ADIANgAuADIANgA1ADgAOAA1AC0AMQAtAFcAZQBuAFkAbwB1AC4AWQBhAG4AZwBA
AGEAbQBkAC4AYwBvAG0APgAAAAMA3j+fTgAACwAAgAggBgAAAAAAwAAAAAAAAEYAAAAAA4UAAAAA
AAADAACACCAGAAAAAADAAAAAAAAARgAAAAABhQAAAAAAAAMAgBD/////AwATEgAAAAACAQCAE4/y
QfSDFEGlhO7bWmsL/wEAAAAuAAAASABlAGEAZABlAHIAQgBvAGQAeQBGAHIAYQBnAG0AZQBuAHQA
TABpAHMAdAAAAAAAAQAAADYAAAABAAoAAAAEAAAAAQAAABQAAAAAAAAAAAAAAHcAAAAAAAAAFAAA
AAAAAAAJAwAA/////wAAAAAAAAsAAIATj/JB9IMUQaWE7ttaawv/AQAAABwAAABIAGEAcwBRAHUA
bwB0AGUAZABUAGUAeAB0AAAAAQAAAAsAAIATj/JB9IMUQaWE7ttaawv/AQAAACgAAABJAHMAUQB1
AG8AdABlAGQAVABlAHgAdABDAGgAYQBuAGcAZQBkAAAAAQAAAAIBAIATj/JB9IMUQaWE7ttaawv/
AQAAAEAAAABDAG8AbgB2AGUAcgBzAGEAdABpAG8AbgBUAHIAZQBlAFAAYQByAGUAbgB0AFIAZQBj
AG8AcgBkAEsAZQB5AAAAAQAAAC4AAAAAAAAAVMF8pmNzpUKY4bmKZA4duwEAVvLpa+S+nUG8U0Ef
wrAQDwAHFIe2XAAAAABAAAcwA7jCkvaj2QELAAIAAQAAAAMAJgAAAAAACwArAAAAAAALAAYMAAAA
AAIBEDABAAAARgAAAAAAAABUwXymY3OlQpjhuYpkDh27BwDAJOEqqLOjQoHvndV7+2eHAAACh3O8
AABW8ulr5L6dQbxTQR/CsBAPAASSSylpAAAAAAIBEzABAAAAEAAAAG6EPtZlNMlMjgq44AibVygC
ARQwAQAAAAwAAAA/AgAAe7rVwkMAAAADAFszAQAAAAMAWjYAAAAAAwBoNg0AAAALAPo2AQAAAB8A
+D8BAAAAGAAAAEwAYQB6AGEAcgAsACAATABpAGoAbwAAAB8AIkABAAAABgAAAEUAWAAAAAAAHwAj
QAEAAAACAQAALwBPAD0ARQBYAEMASABBAE4ARwBFAEwAQQBCAFMALwBPAFUAPQBFAFgAQwBIAEEA
TgBHAEUAIABBAEQATQBJAE4ASQBTAFQAUgBBAFQASQBWAEUAIABHAFIATwBVAFAAIAAoAEYAWQBE
AEkAQgBPAEgARgAyADMAUwBQAEQATABUACkALwBDAE4APQBSAEUAQwBJAFAASQBFAE4AVABTAC8A
QwBOAD0ARgA4AEYAMgA1ADkAOABGADkAMQAwADMANAA2AEQAMQA4ADEANgAzAEMAOAA4ADYAQgA3
ADUAMQA5ADIANQAyAC0ATABBAFoAQQBSACwAIABMAEkASgBPAAAAAAAfACRAAQAAAAYAAABFAFgA
AAAAAB8AJUABAAAAAgEAAC8ATwA9AEUAWABDAEgAQQBOAEcARQBMAEEAQgBTAC8ATwBVAD0ARQBY
AEMASABBAE4ARwBFACAAQQBEAE0ASQBOAEkAUwBUAFIAQQBUAEkAVgBFACAARwBSAE8AVQBQACAA
KABGAFkARABJAEIATwBIAEYAMgAzAFMAUABEAEwAVAApAC8AQwBOAD0AUgBFAEMASQBQAEkARQBO
AFQAUwAvAEMATgA9AEYAOABGADIANQA5ADgARgA5ADEAMAAzADQANgBEADEAOAAxADYAMwBDADgA
OAA2AEIANwA1ADEAOQAyADUAMgAtAEwAQQBaAEEAUgAsACAATABJAEoATwAAAAAAHwAwQAEAAAAY
AAAATABhAHoAYQByACwAIABMAGkAagBvAAAAHwAxQAEAAAAYAAAATABhAHoAYQByACwAIABMAGkA
agBvAAAAHwA4QAEAAAAYAAAATABhAHoAYQByACwAIABMAGkAagBvAAAAHwA5QAEAAAAYAAAATABh
AHoAYQByACwAIABMAGkAagBvAAAAAwBZQAAAAAADAFpAAAAAAAMAN1ABAAAAAwAJWQEAAAAfAApd
AQAAACYAAABMAGkAagBvAC4ATABhAHoAYQByAEAAYQBtAGQALgBjAG8AbQAAAAAAHwALXQEAAAAm
AAAATABpAGoAbwAuAEwAYQB6AGEAcgBAAGEAbQBkAC4AYwBvAG0AAAAAAAIBFV0BAAAAEgAAAAIf
ltg9iORgTo4RqC2ZThg9AQAAAgEWXQEAAAASAAAAAh+W2D2I5GBOjhGoLZlOGD0BAAADAACACCAG
AAAAAADAAAAAAAAARgAAAAAQhQAAAAAAAAsAAIAIIAYAAAAAAMAAAAAAAABGAAAAAA6FAAAAAAAA
AwAAgAggBgAAAAAAwAAAAAAAAEYAAAAAGIUAAAAAAAALAACACCAGAAAAAADAAAAAAAAARgAAAACC
hQAAAAAAAB8AAIAfpOszqHouQr57eeGpjlSzAQAAADgAAABDAG8AbgB2AGUAcgBzAGEAdABpAG8A
bgBJAG4AZABlAHgAVAByAGEAYwBrAGkAbgBnAEUAeAAAAAEAAADuAQAASQBJAD0AWwBDAEkARAA9
AGQANgAzAGUAOAA0ADYAZQAtADMANAA2ADUALQA0AGMAYwA5AC0AOABlADAAYQAtAGIAOABlADAA
MAA4ADkAYgA1ADcAMgA4ADsASQBEAFgASABFAEEARAA9ADAAMQBEADkAOQA0ADIAOQBEADIAOwBJ
AEQAWABDAE8AVQBOAFQAPQAyAF0AOwBTAEIATQBJAEQAPQAzADMAOwBTADEAPQA8ADIAMAAyADMA
MAA2ADAAMQAwADEAMwA4ADIANgAuADIANgA1ADgAOAA1AC0AMQAtAFcAZQBuAFkAbwB1AC4AWQBh
AG4AZwBAAGEAbQBkAC4AYwBvAG0APgA7AFIAVABQAD0ARABpAHIAZQBjAHQAQwBoAGkAbABkADsA
VABEAE4APQBSAGUAbQBvAHYAZQBkADsAVABGAFIAPQBQAGEAcgB0AGkAYwBpAHAAYQBuAHQAQwBo
AGEAbgBnAGUAZAA7AFYAZQByAHMAaQBvAG4APQBWAGUAcgBzAGkAbwBuACAAMQA1AC4AMgAwACAA
KABCAHUAaQBsAGQAIAA2ADUAMAAwAC4AMAApACwAIABTAHQAYQBnAGUAPQBIADEALAAgAFQAQwA7
AFUAUAA9ADUAMAA7AEQAUAA9ADEAAAAAAB8AAIAIIAYAAAAAAMAAAAAAAABGAAAAANiFAAABAAAA
EgAAAEkAUABNAC4ATgBvAHQAZQAAAAAACwAAgFDjYwvMnNARvNsAgF/MzgQBAAAAJgAAAEkAcwBQ
AGUAcgBtAGEAbgBlAG4AdABGAGEAaQBsAHUAcgBlAAAAAAAAAAAAAwAAgFDjYwvMnNARvNsAgF/M
zgQBAAAAJAAAAEkAbgBkAGUAeABpAG4AZwBFAHIAcgBvAHIAQwBvAGQAZQAAABsAAAAfAACAUONj
C8yc0BG82wCAX8zOBAEAAAAqAAAASQBuAGQAZQB4AGkAbgBnAEUAcgByAG8AcgBNAGUAcwBzAGEA
ZwBlAAAAAAABAAAAcAAAAEkAbgBkAGUAeABpAG4AZwAgAFAAZQBuAGQAaQBuAGcAIAB3AGgAaQBs
AGUAIABCAGkAZwBGAHUAbgBuAGUAbABQAE8ASQBJAHMAVQBwAFQAbwBEAGEAdABlACAAaQBzACAA
ZgBhAGwAcwBlAC4AAAACAQCACCAGAAAAAADAAAAAAAAARgEAAAA2AAAASQBuAFQAcgBhAG4AcwBp
AHQATQBlAHMAcwBhAGcAZQBDAG8AcgByAGUAbABhAHQAbwByAAAAAAABAAAAEAAAAHhz361icZNN
uDL6Pxb9JyYDAA00/T8AAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAAC4AAABhAHUAdABoAGUAbgB0
AGkAYwBhAHQAaQBvAG4ALQByAGUAcwB1AGwAdABzAAAAAAABAAAAsgAAAGQAawBpAG0APQBuAG8A
bgBlACAAKABtAGUAcwBzAGEAZwBlACAAbgBvAHQAIABzAGkAZwBuAGUAZAApACAAaABlAGEAZABl
AHIALgBkAD0AbgBvAG4AZQA7AGQAbQBhAHIAYwA9AG4AbwBuAGUAIABhAGMAdABpAG8AbgA9AG4A
bwBuAGUAIABoAGUAYQBkAGUAcgAuAGYAcgBvAG0APQBhAG0AZAAuAGMAbwBtADsAAAAAAB8AAICG
AwIAAAAAAMAAAAAAAABGAQAAACAAAAB4AC0AbQBzAC0AaABhAHMALQBhAHQAdABhAGMAaAAAAAEA
AAACAAAAAAAAAB8AAIBrxT9AMM3FR4b47enjWgIrAQAAABIAAABNAEkAUABMAGEAYgBlAGwAAAAA
AAEAAADMAQAAWwB7ACIAaQBkACIAOgAiADQAMwA0ADIAMwAxADQAZQAtADAAZABmADQALQA0AGIA
NQA4AC0AOAA0AGIAZgAtADMAOABiAGUAZAA2ADEANwAwAGEAMABmACIALAAiAHQAaQAiADoAIgAz
AGQAZAA4ADkANgAxAGYALQBlADQAOAA4AC0ANABlADYAMAAtADgAZQAxADEALQBhADgAMgBkADkA
OQA0AGUAMQA4ADMAZAAiACwAIgBwAGkAIgA6ACIAMAAwADAAMAAwADAAMAAwAC0AMAAwADAAMAAt
ADAAMAAwADAALQAwADAAMAAwAC0AMAAwADAAMAAwADAAMAAwADAAMAAwADAAIgAsACIAbgBtACIA
OgAiAEcAZQBuAGUAcgBhAGwAIgAsACIAYQBjACIAOgAwACwAIgBvAHAAIgA6ADEALAAiAGMAdAAi
ADoAIgAyADAAMgAzAC0AMAA2AC0AMgAxAFQAMAA0ADoAMAA4ADoAMgAxAFoAIgAsACIAbQB0ACIA
OgAiADAAMAAwADEALQAwADEALQAwADEAVAAwADAAOgAwADAAOgAwADAAIgAsACIAdQBjACIAOgBu
AHUAbABsAH0AXQAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAAC4AAAB4AC0AbQBzAC0AcAB1AGIA
bABpAGMAdAByAGEAZgBmAGkAYwB0AHkAcABlAAAAAAABAAAADAAAAEUAbQBhAGkAbAAAAB8AAICG
AwIAAAAAAMAAAAAAAABGAQAAADYAAAB4AC0AbQBzAC0AdAByAGEAZgBmAGkAYwB0AHkAcABlAGQA
aQBhAGcAbgBvAHMAdABpAGMAAAAAAAEAAABIAAAAQgBZAEEAUABSADEAMgBNAEIANAA2ADEANAA6
AEUARQBfAHwAUABIADgAUABSADEAMgBNAEIANwAwADIANwA6AEUARQBfAAAAHwAAgIYDAgAAAAAA
wAAAAAAAAEYBAAAAUAAAAHgALQBtAHMALQBvAGYAZgBpAGMAZQAzADYANQAtAGYAaQBsAHQAZQBy
AGkAbgBnAC0AYwBvAHIAcgBlAGwAYQB0AGkAbwBuAC0AaQBkAAAAAQAAAEoAAAA5ADEAYwAwADQA
ZgAxAGYALQA1ADMAMgBhAC0ANAAwADgAMgAtAGMAMwBhAGMALQAwADgAZABiADcAMgAwAGQAYgA1
AGEAYwAAAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAAOAAAAHgALQBtAHMALQBlAHgAYwBoAGEA
bgBnAGUALQBzAGUAbgBkAGUAcgBhAGQAYwBoAGUAYwBrAAAAAQAAAAQAAAAxAAAAHwAAgIYDAgAA
AAAAwAAAAAAAAEYBAAAAOgAAAHgALQBtAHMALQBlAHgAYwBoAGEAbgBnAGUALQBhAG4AdABpAHMA
cABhAG0ALQByAGUAbABhAHkAAAAAAAEAAAAEAAAAMAAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAA
ACoAAAB4AC0AbQBpAGMAcgBvAHMAbwBmAHQALQBhAG4AdABpAHMAcABhAG0AAAAAAAEAAAAOAAAA
QgBDAEwAOgAwADsAAAAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAAEQAAAB4AC0AbQBpAGMAcgBv
AHMAbwBmAHQALQBhAG4AdABpAHMAcABhAG0ALQBtAGUAcwBzAGEAZwBlAC0AaQBuAGYAbwAAAAEA
AACCBQAATgA4AFkAMgA0AEsAawB3AEsAYwBMAHYAVgBaAEIATQBIAHAANAB2AEcAdABaAFAAQwBq
ADkAQwBEAEQAcwBOAFgAcQB3AFkAaABCAFkAWAB1AEoAYwBSAEMAZgBYADYARABKAGcAZABVAFkA
QgBOAFgAdABGAGUAZgB5AFoAagBJAGcARwBlAHUAaQBkADgAUQA4AEMAcwA5AFUANQBKAEYAWQBS
AFYAQwB0AEcARAA0AEkAUwB1AGoAVQBwAGEAegBVAGsAcwBaAE0AdAB5AG8AQwBoADQAYgBsAG4A
VABlAFIAUABQAHEAaQBCAHcANABzAGkANwB2AHgASABtAHgAYgBnAGIAdwBuAHMAVQA2AFEAeQBq
AGsAZgBCAHIASABNAGgAdgBHAHoASABNAGsAVwBOAEQAYgBMAG0AcABBAFMAOQBtAFoAbQAwAEMA
QQB5AGwAawBJADQARAB3AGYAdgBzAEIAeABRAE0ARgByAFMAYQBmAEYAYQBjADMAQQBFAHgAegBs
AGwAVQBJAHYAYgBzAC8AQQBhADAAdgBkAE8AQQB3AGMAeAA3AGQAZABwAE4AZABzAE8AYQBqAG0A
bAB5AE8AZQBoAFEAeQB0AHYAbQBmADAASQBlAEwAVwBiAHEAOQBMADAAWABhADEATQAzAHgAbwBH
ADAALwBJAEMAWQBEAGMAVgBBAFoAYQBWAGYAaAArAEMARgBNAEcAKwBmAG8AbABRACsAcQBMAEYA
dwByAHgAQwA3AEMAWABtAFUAYQBmAGwARwBnAGEAcQBlADIAWABhADMAMQBNAFIAOQB6AHQAVQAz
AEYAQQBSADMATwByADIAUQB6ADYALwBLAHYASwBVACsAOQBOAGUAdgBJADAANwBqAG8ATABsAEMA
YwB4ADUAUwBJAEMAZwBLADkAdwB5ADUAaQBUAEsAMAB2AFEAbQBoAHAAMwB2AHkANwAzADUAeABy
AFgAegBxAE8AZwBXAE8AQwBNAEUAQgBJAFkAbgByAFMAVgAvAGMAMABNADIASABaADkARQBaAGUA
NABwAGMAVQB1AFcAcgBHADMANAArAEYAaQB4AEcAVgBMADIARgBUAG8ATgB1AGQAdQArAEoAMAA3
AEUANgB3AGcAeQA3ACsAdABFAFUAYgBzAHcAZgBXAFoAeQAxAGcAMQBQAEwAbgBOAHgATABqAEkA
RABDADUAZwBCAEkAagBOAEkASQAvAG4AbAA4AG4AcQBwADYAawB2AGsAQQA1AHgAbgB3AGQAWABk
AEsAUQBwAHAANgBkAHgAcQBDADUAYwBQAGoALwBqAGsAZgAvAFMAegArAFAAbAA4AEQAagBFAFYA
agBzAG0AMgBWAFIAaQB5AFQATwA1AFAAeABoAGkAMgA2ADIAZABvAHQATQA1AEkAMQBnAGMAUwBI
ADQARwB2ADgAdgBaAFAAYwBZADQAQgByAEEAZAB0AGMAQgAxADEASABxADYAZABhAE0AOABYAGoA
dAAzAEkAVABTAHUASQBXAGgAOQBDAGEAdwA5ADcAeQBOADQANABtADEAOABVADEAeABYADcAaQBk
ADYAbgBGAFAARwA1AHMAbABCAEgAOAB6AGQAWgBrAHEAZABmAHkAdAB2AGoARgBHADYAbgByAFAA
VABCAHMAMQBIAFcASQBpAGoAKwBmAGsAbwBOAGkAcgBEAFUAYwA2AEMAUwBPAGUAWABGAEkAQQBm
AGwAeABiAEMAVQB1AFQAbgBuAEgARwBoAHoANgBxAFAAUgB2AGQASgBzAHYAcwBKAEgAWABMAGYA
cAA4AHYAWQBNAEsAYQBVADYATQBxAFgAVQBrADcAZgBRAGYAaQBBAEEAbAAzAAAAAAAfAACAhgMC
AAAAAADAAAAAAAAARgEAAAA4AAAAeAAtAGYAbwByAGUAZgByAG8AbgB0AC0AYQBuAHQAaQBzAHAA
YQBtAC0AcgBlAHAAbwByAHQAAAABAAAAWgQAAEMASQBQADoAMgA1ADUALgAyADUANQAuADIANQA1
AC4AMgA1ADUAOwBDAFQAUgBZADoAOwBMAEEATgBHADoAZQBuADsAUwBDAEwAOgAxADsAUwBSAFYA
OgA7AEkAUABWADoATgBMAEkAOwBTAEYAVgA6AE4AUwBQAE0AOwBIADoAQgBZAEEAUABSADEAMgBN
AEIANAA2ADEANAAuAG4AYQBtAHAAcgBkADEAMgAuAHAAcgBvAGQALgBvAHUAdABsAG8AbwBrAC4A
YwBvAG0AOwBQAFQAUgA6ADsAQwBBAFQAOgBOAE8ATgBFADsAUwBGAFMAOgAoADEAMwAyADMAMAAw
ADIAOAApACgANAA2ADMANgAwADAAOQApACgAMwA5ADYAMAAwADMAKQAoADMAOQA4ADYAMAA0ADAA
MAAwADAAMgApACgAMwA0ADYAMAAwADIAKQAoADMANwA2ADAAMAAyACkAKAAxADMANgAwADAAMwAp
ACgAMwA2ADYAMAAwADQAKQAoADQANQAxADEAOQA5ADAAMgAxACkAKAAzADgAMAA3ADAANwAwADAA
MAAwADUAKQAoADQAMQAzADAAMAA3ADAAMAAwADAAMQApACgANQA2ADYAMAAzADAAMAAwADAAMgAp
ACgANQAyADUAMwA2ADAAMQA0ACkAKAA4ADYANwA2ADAAMAAyACkAKAA4ADkAMwA2ADAAMAAyACkA
KAAyADkAMAA2ADAAMAAyACkAKAAzADMANgA1ADYAMAAwADIAKQAoADUANQAwADEANgAwADAAMwAp
ACgAOAA2ADMANgAyADAAMAAxACkAKAA5ADYAOAA2ADAAMAAzACkAKAA2ADUAMAA2ADAAMAA3ACkA
KAA1ADMANQA0ADYAMAAxADEAKQAoADIANgAwADAANQApACgANQA0ADkAMAA2ADAAMAAzACkAKAAx
ADgANgAwADAAMwApACgAMQAxADAAMQAzADYAMAAwADUAKQAoADQANwA4ADYAMAAwADAAMAAxACkA
KAA3ADYAOQA2ADAAMAA1ACkAKAA3ADEAMgAwADAANAAwADAAMAAwADEAKQAoADYANgA1ADUANgAw
ADAAOAApACgANgA0ADcANQA2ADAAMAA4ACkAKAA3ADYAMQAxADYAMAAwADYAKQAoADYANgA0ADQA
NgAwADAAOAApACgANgA2ADMANgAwADAAMgApACgAMQAyADIAMAAwADAAMAAwADEAKQAoADYANgA0
ADcANgAwADAANwApACgAOQAyADEAMAAwADUAKQAoADQAMwAyADYAMAAwADgAKQAoADYANgA5ADQA
NgAwADAANwApACgAMwAxADYAMAAwADIAKQAoADMAOAAxADAAMAA3ADAAMAAwADAAMgApACgAOAAz
ADMAOAAwADQAMAAwADAAMAAxACkAOwBEAEkAUgA6AE8AVQBUADsAUwBGAFAAOgAxADEAMAAxADsA
AAAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAAFwAAAB4AC0AbQBzAC0AZQB4AGMAaABhAG4AZwBl
AC0AYQBuAHQAaQBzAHAAYQBtAC0AbQBlAHMAcwBhAGcAZQBkAGEAdABhAC0AYwBoAHUAbgBrAGMA
bwB1AG4AdAAAAAEAAAAEAAAAMQAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAAEoAAAB4AC0AbQBz
AC0AZQB4AGMAaABhAG4AZwBlAC0AYQBuAHQAaQBzAHAAYQBtAC0AbQBlAHMAcwBhAGcAZQBkAGEA
dABhAC0AMAAAAAAAAQAAAFoMAABEAGMAcgBVAGEAdgBZAGcAVQBaAHkATgA3AE8AbwA4AGUAegBu
AHIANAAwAG4AdgA5AGwARwA1ADIAZgA1ADIAVAB0AFEAQQBoADIATgBCAGgAYgBnACsAVAArAFgA
VwBPAHoATABwAEwAdwBRAG4ASABGAHAAWABjAEgAKwBPAFoAUQB2ADgATQBCAGUAawA1ADAAawAr
AEYAUwBhAEIAQQBKAGoANwBIAFUAcwBCAEQAZABwADEAcwA1AEQAMgBHAEYAWgBMAFMAWQB6AHIA
bABqAHYAQgBrAFoAZABsAEkAQQBaAG8ALwBOADgARgBaAGUAdwBnAGcAawA2AGUAaABIAFAATwA0
AEEAMABBAEEAVgA1AGgAKwBRAEIASQBHAHQAVwBBAEQARgBSAE0ASgBMAFQATwBtAEMAWgB5AGwA
dgAzAGYANwBJAGUAVQBpAEcAegBFAEQATgAwAHIAdQBhAHEANQBVADQASgBzAHgAOQBzAHkAawBz
AFUAMwA0AC8AWAAzAFoAawBYAEkAUABwAEcAQgBmAFYAYQBMADkAQwBMAEwASQBuAEQAeQBoAEgA
UABrAHoAYQB0AGUAcQBiAEoAbAA0ADgAeQArAFUAbAArAE0ANQBoADUAQgBKAFUAMgBjAGsASwB0
AHYAZwBDAGYAdwBZAEsARwB3AHgANgBhADcAagBSADIAYQBvADAAMwBCAGsAUgBNAHMAawBzAHYA
MwAwADcAaABGAE0AUQBnAFAAaABQAFIAawB0AGYAKwBNADcAVwAxADMATQByAE0AdABnAEQAQQB3
AEEATgB0AFgAZwArAHAAMQBVAGgAWgA4AFQAdgBaAEMAZQB6AEkAcABPAG0AVgBCAGcAQgA4AHQA
VAA5AFgAdwByAGUAcQBqAEMAZQBwAGYAKwBTAEEAYQArAHMAcwBZAG8AVgA0AGwAcABiAFoAcQBW
AGcAWQBXAHoATQBtAHMATAAwAEcAUwBaAFUASgBxAGIATgA2AEMARgBQAHQATABHADMAegAwACsA
WQBhAGMAcwB0AEkAYwBHAHUASQBGAGEAUgBOADgARwBtAHoATABuADMAeAA3ADAAYgAwAGkAaAAw
AGQAUQBnAGYAZgBlAGEATQA0AGsAVQBqAE0ATQBsAGsAeABRAFAAbABzAFcAMgA0AFcATAAwAHUA
aAB2AEwAMAB6AEQAcQBxAFYAMABEAEoANQBPAHgARgAvAEkANgA5ADUAUAAyACsAawA5AEIANQBF
AEIARAA1AFAARABMAEYAOQA0AHcASwB5AE4AVgBRAFkANwBSAEEAcABXAG0AeQBVAHoATwBxAHoA
NAAzAHcAMgBHADEAbwBlAEoAMwA1AFoANwA4AEUATAA3ACsAbwBjAFIAZABLAEMAcABDAHAANAB6
ADgAdQBrAFEAawBuAEMAcQBPADEAZABLAEsAOQBFAEEAQQBRAGIAdAA3AE0ALwB1AHkAWABuAC8A
YQB2AEoAdQBiAGEAMgAwAFgATgBlAGIAZwBPAHEAbQBGAGEAVQA4ADcANwBHAHQASABmAGsAYQBy
ADMAdgBtAFgAMgB6ADIAYQBEAC8AOQBlAEYAagAxADUAdgBnAE0AbgByAG8ATwBUAFkAVQB4AGMA
cwBWADgANQBDAGwAeQBQADcAZQB6AHkAbQAwAFAAaABEAEUAQwBpADAATgB6AHAAcgBHAFcAUgAy
AHEAbgBwAGoAYwBKAGsAcABIADAAdgA4AFkAdgBPAHgAaABWADEAdwBNAHgAWABzAEoARQBVAFcA
QQBWAHIAbABxAFcATQBiAEwAWQBTAHQANQBYAE0AQwBZAEwAVgBLAHgAMwBIAFUAVgA1AGsAcABl
AFIAbgAwAFcANwA5ADAATABMAGMAWAB3ADEANQBpAC8ANABpAEsAMQBxAGwAMQBlAHkAaABuAEoA
TwBwAHEAegBEAHgATQBPAFUARgBRACsANAA5AEcAMABzADIAagBvAGEAdgBpAEwAaAAxAHQAVABJ
AEUAMABNAG0ASQA4AEwAcwBWADYAWABuACsAQwBnAC8ATAAvAG8AawBVAE0ALwBGAFkANgBTAFMA
dwA0AHQAQwBxAGcAMAA1ADUARQBCAEsAOABXAGoAVgBlAFQATAA2AHYALwBjAGcAawBpAGMAVQAx
AHMAUQBnAHQAawBmAEEAbAA4ADgANQBVAEoAMABVAFcAKwB2AHMANAArACsAMgBsACsAUwB1AGwA
OABrAEUATABuAEkASwBWADYAUwBEADkAbQBBADgAegBvAFUAVwBaAGMAbABaAEIATwBUAEIAQwBK
AGIAcQBMAHMAOQBPAHoAKwBiAGQAQQAvAG0AOQBCAFoARgBRAEMAYQBvADUASwBoADIAMABUAHUA
ZQBOADYAOABPADkAUwB3AHgAegBaADEAcQBnADAAVABHAEYANAA1AEsAMwBEAHMASwBCAHYALwBp
AEMAMABLAHcAcQBHAGcARwBIAFMATwBZAEQAbwByAGcAbQBsAHgAZgAwAG0ARABqADAAZABlAE0A
cQBzADQATABOAHgAUgAvAHYAQwBBAFUARQB2ADIAYgA0ADQATABlADIASwBIAGcARQBzAFoASgBQ
AHkASwB0AGkATgAxADAARAAzAGwAMQBXAFgAZQBYAHIASwAzAEcAcQBLAEEARgBIAEQASgB5AFUA
dwBSADkATgBCAFYAYQA4AFAAdQArAGMAbgBCAHYAeQBNADMAYQBZAHYAUgBkAHUAYQAxAEkAUQBP
AFIAcQBUAFcAMQBZAGIAZgBZAEoAKwBPADYAYQBZAGcAeQBmAGwAVgBuADEAVABaAE8AOQA0AHoA
VwBOAGEATwA4AEYAQgBXAEEAaQBTAE4AdwBWAEsAawBrADEAUQBoAHIAdQBwAGEAagBDAG4ASgBz
ADkANgBsAEcAQwByAEQASQArAHIATgBWADYALwB5ADUARgB2ADQASAA2AHkATwBTAEMASQA1AGsA
MABhAGwASgAwAFIAQgBvADcAYQBpAHIAcQA0AEYARABZAHUAeABJAHcANwB2AEIALwBZAE4AYgBP
AEcAYgBtADEAQQB4AHYAZQBhAEIANQBiACsAdAArAHQAeABhAC8AQgBNAHAAeABBAHQAagA4AEYA
SwByAEsAWgAzAG0AYQBEAEkARABZAGQAUgBjAEoAcQBUAFcAbAA2AFMAeQA0AGIAVAAyAFgAMwBz
AHQAZwBHAFIAcwB5AEwANABmAEUATQArAE8AbQBwAFkAMwAxAGYAMwBnADEAbAAzAGwALwB5AFMA
dABZADYAMwBQAHoAdAB5AG4AdQBlAEMASQBqAHcAcABoAGEAMQBZADMAcwBJAFgAMQB5AFIAVQBz
ADAAdAB5AEkAcwBuAFQAMQByAEIAaABOAFUARQBtAGsAZQBBAHkAcwBMAFAANABCAEgAYgBVAGQA
MABNAHoASwBGADYAdQArAGQAVwAyAG8AeQB5AEoARQBVAEsAbABIAEEARwArAGwAagBsAEoAdwBT
AGkAeQBVAFMARgBwAEkAaQA3AGsARgA4AGwAVwBrAGEAYwBBAFIATwBiAFEASgBLAFMAMgBjAHEA
cQBDAEcANAArAHgAQgA5AG4AdQB6ACsASABiAE4ATgBGAGYAMQBIAEIAUAAzAFEASgAyAGgAdQBM
AFMAcQBTAGcASQArAEIASABTADEAMgBpAEcAWAB1AGIAYgBZAHUAZgBDADEARABtAHkAWgBvADgA
MwBOAHIAOQBlAGIAMABpAFUAZQBHAHUAdwBhAHQAZgBRAEYATQBxAEkAaQBqAHYAMAA1AFgAYgBO
ADIATABoAGUAZgA3AGcAbQB5AHoAWABDAHYARwBMAHEAUABYADkAbgB1AG4AbwBaAGIAUwBrAEkA
RQBoADEAVQAxAEcAagB2AHIASQBQAHUAdgBJADgAMwBTAHgAKwBoAHUAcgBqAG4AMQBwAHAAZgBx
AHgANQB1AHIAaQBaAEEAaABpAEcATgBUAGgANABXAEMANABIAEIAcwBQADgAUgA2AC8ATwBvAGUA
UABFAHkAdwBBAFEAVAA4AHQASQBGAGkANgBqAHoASgB4AC8AYgBPAEYANQBoADIAUgBUAEIAawA1
AE8AUQBOAHcATAAvAGoARgA5AE4ANgBYAEMAZgBwAFIAbgB6AFoAYQAwAD0AAAAAAIqR

--_000_BYAPR12MB46148161BB006E0FEE1EA355975DABYAPR12MB4614namp_--
