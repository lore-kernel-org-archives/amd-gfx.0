Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA87C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jul 2022 03:32:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AC4310FA69;
	Wed, 20 Jul 2022 03:32:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F55910F72F
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jul 2022 03:32:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOExpfEfYRREbdDie73DK6z/eojlOrdP8BPkWKrVB2Deb1LmVjucQlaado3kdCkHADJ2KhLsM6hQVDRly20Mj4rjw9opNdm0S7vccBS8wxVsiibfUl860rThtNpS3DqjbhhzTS/HecyirGK5ZLJSNYsv6d6es0RceQNdSkT26ERZIepHDake+iRnpDkKwyrJJWREj+8GATSnMAu3oA/+2OJJnF+7zACPGPpN7dOeua2J73dKVq45QSBptvPAfpGUTNauaqdyIM/PsKWJkhHFwZX93+l3Hg7O30tbDfT4qeDGJtcef+BQSGBJEUBfaDh3ELmJjY2jTdRzev3AoBLlcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CavXKEk5bN5uLyfMCRWdrVT+YxDr01hI5lSVd0+aCuU=;
 b=aJBXLrO0Zj6JIywFjIogT0I2AjwE7Msmt0pRmxMZN9NS6Q0dYmN6EPBThbwI4HLIw7GsIAbSr/cDwXVDEGMU2i6Gfc/bRPXK9oz2Xfz7VTt8fOKDkVuWeMlPxeRXqfO2XCnRhmzdtt95p5VVJZ8+ObE9Iib1P3R9CeEJkcxWqCKWapLL5gj7BiVDSoKs1tkCioil8/RO3Rl6kZNzVc5WVpWaiYbxiDhxxmIVzpsRUNGIdAJJN0jK0LOEjSlmkCFE7NgG9sWBPGgNpFfmr6SvxbJPwWXwopwqJMNzrkOY5VA36QXej3dOlEK7BYtloLPqG7UrnuKXjA1m6RlVqHWSag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CavXKEk5bN5uLyfMCRWdrVT+YxDr01hI5lSVd0+aCuU=;
 b=W/q4Sg00eIzZL2mGHPlcYlaRPqq2zEWOnUU9SVjgSU1xQGphwbqwF8l0BbUxx9EvGpf/gEnsnRlfNtIKUvBFLV1R5HYurkiDtCmnbyIudRbYTkbyXPSwr79Icn3cNa9Xi3OKakww0MBY4LIEp2Qpi7R0/nVHj6GRySk7120BQro=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB6009.namprd12.prod.outlook.com (2603:10b6:8:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Wed, 20 Jul
 2022 03:32:15 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe%9]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 03:32:15 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/pm/swsmu: add ras eeprom i2c function for smu13
 v13_0_0
Thread-Topic: [PATCH] drm/pm/swsmu: add ras eeprom i2c function for smu13
 v13_0_0
Thread-Index: AQHYm+OCM68al2P9yESYc5j0PS7hka2GmN/ggAAB4cA=
Date: Wed, 20 Jul 2022 03:32:15 +0000
Message-ID: <BN9PR12MB525765350C4D2311E6BA92E4FC8E9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220720024925.9640-1-YiPeng.Chai@amd.com>
 <BN9PR12MB5257B1A6449B44A3958FD7D3FC8E9@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257B1A6449B44A3958FD7D3FC8E9@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-20T03:32:13Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c7ef7e00-35a5-4cf9-9a74-65b92bf615aa;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 697d1aa6-f78d-4670-54c9-08da6a007110
x-ms-traffictypediagnostic: DM4PR12MB6009:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MckSyMK2b82uRe5lRVP4gKYcJnQ+f5QrYfFFwXC4HA63M8eZjnM4xYTA0CX/YJXbVU6eZVTFwiGxfUUCPe8cojZ1ont29G2Bun++aAvsY6G5m29vqAUizjmemcwifVRDNsaFbV/OhxuAv14Gkhep7FJlL3kONkIvVvHnDvoFj+ewRcAZDwPMR48r36rkSgu92J5PwWlov4t1xG0D7HaFgvCYD2+VNIrdffMzHp2QZBpFapYtFDyR25+xxjZwuDPE5v3UEiLQ03RQnkYToWf2vI85f54rCo4WLk3FEmqljQFe/AJiSCK8nDPxIEgZFjsCsPZQMGKd1DuOAFM4DK/kVbZleWH1mZwFvQkgMeMhpOgQxHLXg1wTcy5N55XIq+jFr3bHdq79E5ToBIjPqejo2SYtJK+tzCOvxBG1vyGjrijlafkr7mDk+Tf0acCZUYP6noDW91GlNImdvsEV7BHI5t3+JhhrbJ+fV/TnkC1e1Eqy2NgdWGkohqRjD61YFQ6fM5UaSt4grdpvjU6vu3aHn9PcJcVawDfbwTIe3BVLa/LDuJBJ+iqVuKhMIwd2/HwtvgEc7OJeWAAVSkSYV5zkgOtGnvB1MQ0nLqgmSl2XuWBinPT8NzeBLfZAKuUNcEbNj5GIknVZIcJALPEgZ5yMmoWd8UXBg5AgBqScxsuWZ7m2v2D8jOWm0z8kpZxi/dO92O9LpxHOLwb9xvH8G6RXJxsgD3V4fx0+g4Z06z1EIayo87KfP/VJujpMs91kJcsneqi63QJQ5VXIlm+dC4P0xl5BbQrwV89CuKVm1wma0tvxAhJXr8nhzZ0QcPLa4kNdQFSTGNjJp3be2CteL5evYg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(316002)(38100700002)(8936002)(66556008)(53546011)(55016003)(64756008)(86362001)(66946007)(52536014)(66476007)(83380400001)(5660300002)(7696005)(6506007)(66446008)(38070700005)(8676002)(4326008)(54906003)(110136005)(9686003)(76116006)(26005)(71200400001)(41300700001)(33656002)(478600001)(186003)(2940100002)(2906002)(122000001)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wXYYkXu5vlrQ3RAFAq5uz17fnFqYNSYCXmEOauP7vsA4tSlwD0+gRaT3tIWU?=
 =?us-ascii?Q?wgu02GXxkS5qOSjMo4zKCNW8PYmvawbx4l4ojK3f7wuwQB+yVwMpGVQc6qmo?=
 =?us-ascii?Q?gYARoBUUjAkwzXsjuzVGPBBMCS4whymUQZyY5BXb71iLTKZTVY+qUb2aE8iy?=
 =?us-ascii?Q?RTF/SGZvpi4357ohgrOk8NR4XBtFWtaPYZjEUqeBiwIwcCEtIPLJ1HiTo5hV?=
 =?us-ascii?Q?yKOXl5UhRKI2rwUdcnknTs1UyIK4qtTQAF9LMOfv76uiUJp/cxD80QD+yRTU?=
 =?us-ascii?Q?Q3rpdTjsorOCChzy1bp+maTlsxMn9nK7NNOPusttQyCWyM7+2CKuB09/GO/1?=
 =?us-ascii?Q?3cH6a1Jy4FyfxAX3k+T1amn+A/nl/rVagxzoiXOfxrcb3M5mVPDGqOqjK+5Y?=
 =?us-ascii?Q?wwChYPE8Xh0KbLF097fkJwFNnkC+/FV8KV95bfJQHTHWzBVrdzG/NJDeC7SM?=
 =?us-ascii?Q?vp27PLJ5LfzcqpfqWO5juBOWcNL6iRzcFWMiEkYzas/D4ri4l3enpAacG1D8?=
 =?us-ascii?Q?H+JAJ91MbPEqBsdmF3j8LZ6QUaM6plj5vm8ShUWQM2WWG3kY/bXx/rG1/k6A?=
 =?us-ascii?Q?up/N9T4zzOQgCrnxWwDl34khsCL5TQjF+cLyDKnh/OTu5OUi6wsLGInsfX1/?=
 =?us-ascii?Q?l4hq5oJpLFoDH/+Ruvh4LUxh49knxN/ojljlQjJMMB/fJ+/uhXtKBlyk0Aot?=
 =?us-ascii?Q?p1S0FX0uqfXP7iY4P73AmuBexLVYksA/trul0++mOJlxDXTUxHbyYal7sS4W?=
 =?us-ascii?Q?/pBuuFD02N2y2NIZ/LMKFY1bnG8+9W2pmNn+ERqSIYz9NPdnwuusDU5aiHAu?=
 =?us-ascii?Q?TAArYYdwbE0ViOE2ag1ieqCItVuz+6wLpJX0+rag/3VPdc3BrisHYfnWa49s?=
 =?us-ascii?Q?Dzau/t/zH19ANOLCcpdyusrvmT359GlooIyuRJaLH0dTI9b2/xafbzRzqXXm?=
 =?us-ascii?Q?T7rmAPPoZ0q4pncTgpd8lbDXb1nP7q7cG6ykD1fXSL3iHK6eseqRXxpW62yr?=
 =?us-ascii?Q?AOhsNNeqMxmyQcTndQSkfmmp6G2xoDiNfPdZcBuq1mCGeU+j9APTSlPuPq+v?=
 =?us-ascii?Q?GKBb7mDA+aLJQ+o7FjktLwYfWBwGe0K/pJ4ATJ8FdaasMl1sP7GefLl+Gmmd?=
 =?us-ascii?Q?3kPLN0SnrzTbm1wMczStUcn8abi4ciUxmxfNbJbKGujhfIoxk1HkOKuAvyL9?=
 =?us-ascii?Q?U18gSfcIFUwG2I7YKXV4EjAms0w/OYTstGCtnEFwvULAXXbEhVZISCWZJGVE?=
 =?us-ascii?Q?0Gl7+l4gv5R0MNgHfbpx9I1l6UzoFWEvnNlpdXUo46QbU3Xk50Wb+ywcHn2X?=
 =?us-ascii?Q?s7NmJQVDAPGTIPWG/FzdrgGd5WUse5p5OdyldTFiYKJC5KHvDFFX6KLUi5VG?=
 =?us-ascii?Q?ProhIUAKVgq/vLOVJfd13vc/XTCLiwm2g8eHDljXsiwFaLq3lbIYDKQmeRsc?=
 =?us-ascii?Q?bgssmzJ0lVq3WhYTydgdYRRH061tIvcEnr19yeiLp7+GCKW073GUq8G8LnnX?=
 =?us-ascii?Q?62eqzQCvqAFRuBMF2ROayXmsT8aMRSs23Ef3cmDsU36fHDyrXsUV3Z5+TWOs?=
 =?us-ascii?Q?DpEaQODWXLmwvvZ/5foCd7eMJiWNv8Dl8Q0Xb046?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 697d1aa6-f78d-4670-54c9-08da6a007110
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 03:32:15.5474 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LAR0uVQAcxhsLZhe7aw6S+IJJTBfk+3sWDF10aHhpIM+iVYXJj8qHRS1ID9G1hyMZzuJJYZ0vXARtEQVh+ykaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6009
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Fix typo.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, H=
awking
Sent: Wednesday, July 20, 2022 11:26
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhou1, Tao <Tao.Zhou1@a=
md.com>; Clements, John <John.Clements@amd.com>; Quan, Evan <Evan.Quan@amd.=
com>; Li, Candice <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/pm/swsmu: add ras eeprom i2c function for smu13 v1=
3_0_0

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>=20
Sent: Wednesday, July 20, 2022 10:49
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>=
; Li, Candice <Candice.Li@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Qua=
n, Evan <Evan.Quan@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/pm/swsmu: add ras eeprom i2c function for smu13 v13_0_=
0

Add ras eeprom i2c function for smu13 v13_0_0.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Acked-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 157 ++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index ce2fa04e3926..2b83191e8006 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -196,6 +196,7 @@ static struct cmn2asic_mapping smu_v13_0_0_table_map[SM=
U_TABLE_COUNT] =3D {
 	TAB_MAP(DRIVER_SMU_CONFIG),
 	TAB_MAP(ACTIVITY_MONITOR_COEFF),
 	[SMU_TABLE_COMBO_PPTABLE] =3D {1, TABLE_COMBO_PPTABLE},
+	TAB_MAP(I2C_COMMANDS),
 };
=20
 static struct cmn2asic_mapping smu_v13_0_0_pwr_src_map[SMU_POWER_SOURCE_CO=
UNT] =3D { @@ -1606,9 +1607,165 @@ static bool smu_v13_0_0_is_mode1_reset_s=
upported(struct smu_context *smu)
 	return true;
 }
=20
+static int smu_v13_0_0_i2c_xfer(struct i2c_adapter *i2c_adap,
+				   struct i2c_msg *msg, int num_msgs) {
+	struct amdgpu_smu_i2c_bus *smu_i2c =3D i2c_get_adapdata(i2c_adap);
+	struct amdgpu_device *adev =3D smu_i2c->adev;
+	struct smu_context *smu =3D adev->powerplay.pp_handle;
+	struct smu_table_context *smu_table =3D &smu->smu_table;
+	struct smu_table *table =3D &smu_table->driver_table;
+	SwI2cRequest_t *req, *res =3D (SwI2cRequest_t *)table->cpu_addr;
+	int i, j, r, c;
+	u16 dir;
+
+	if (!adev->pm.dpm_enabled)
+		return -EBUSY;
+
+	req =3D kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->I2CcontrollerPort =3D smu_i2c->port;
+	req->I2CSpeed =3D I2C_SPEED_FAST_400K;
+	req->SlaveAddress =3D msg[0].addr << 1; /* wants an 8-bit address */
+	dir =3D msg[0].flags & I2C_M_RD;
+
+	for (c =3D i =3D 0; i < num_msgs; i++) {
+		for (j =3D 0; j < msg[i].len; j++, c++) {
+			SwI2cCmd_t *cmd =3D &req->SwI2cCmds[c];
+
+			if (!(msg[i].flags & I2C_M_RD)) {
+				/* write */
+				cmd->CmdConfig |=3D CMDCONFIG_READWRITE_MASK;
+				cmd->ReadWriteData =3D msg[i].buf[j];
+			}
+
+			if ((dir ^ msg[i].flags) & I2C_M_RD) {
+				/* The direction changes.
+				 */
+				dir =3D msg[i].flags & I2C_M_RD;
+				cmd->CmdConfig |=3D CMDCONFIG_RESTART_MASK;
+			}
+
+			req->NumCmds++;
+
+			/*
+			 * Insert STOP if we are at the last byte of either last
+			 * message for the transaction or the client explicitly
+			 * requires a STOP at this particular message.
+			 */
+			if ((j =3D=3D msg[i].len - 1) &&
+			    ((i =3D=3D num_msgs - 1) || (msg[i].flags & I2C_M_STOP))) {
+				cmd->CmdConfig &=3D ~CMDCONFIG_RESTART_MASK;
+				cmd->CmdConfig |=3D CMDCONFIG_STOP_MASK;
+			}
+		}
+	}
+	mutex_lock(&adev->pm.mutex);
+	r =3D smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
+	mutex_unlock(&adev->pm.mutex);
+	if (r)
+		goto fail;
+
+	for (c =3D i =3D 0; i < num_msgs; i++) {
+		if (!(msg[i].flags & I2C_M_RD)) {
+			c +=3D msg[i].len;
+			continue;
+		}
+		for (j =3D 0; j < msg[i].len; j++, c++) {
+			SwI2cCmd_t *cmd =3D &res->SwI2cCmds[c];
+
+			msg[i].buf[j] =3D cmd->ReadWriteData;
+		}
+	}
+	r =3D num_msgs;
+fail:
+	kfree(req);
+	return r;
+}
+
+static u32 smu_v13_0_0_i2c_func(struct i2c_adapter *adap) {
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL; }
+
+static const struct i2c_algorithm smu_v13_0_0_i2c_algo =3D {
+	.master_xfer =3D smu_v13_0_0_i2c_xfer,
+	.functionality =3D smu_v13_0_0_i2c_func, };
+
+static const struct i2c_adapter_quirks smu_v13_0_0_i2c_control_quirks =3D =
{
+	.flags =3D I2C_AQ_COMB | I2C_AQ_COMB_SAME_ADDR | I2C_AQ_NO_ZERO_LEN,
+	.max_read_len  =3D MAX_SW_I2C_COMMANDS,
+	.max_write_len =3D MAX_SW_I2C_COMMANDS,
+	.max_comb_1st_msg_len =3D 2,
+	.max_comb_2nd_msg_len =3D MAX_SW_I2C_COMMANDS - 2, };
+
+static int smu_v13_0_0_i2c_control_init(struct smu_context *smu) {
+	struct amdgpu_device *adev =3D smu->adev;
+	int res, i;
+
+	for (i =3D 0; i < MAX_SMU_I2C_BUSES; i++) {
+		struct amdgpu_smu_i2c_bus *smu_i2c =3D &adev->pm.smu_i2c[i];
+		struct i2c_adapter *control =3D &smu_i2c->adapter;
+
+		smu_i2c->adev =3D adev;
+		smu_i2c->port =3D i;
+		mutex_init(&smu_i2c->mutex);
+		control->owner =3D THIS_MODULE;
+		control->class =3D I2C_CLASS_SPD;
+		control->dev.parent =3D &adev->pdev->dev;
+		control->algo =3D &smu_v13_0_0_i2c_algo;
+		snprintf(control->name, sizeof(control->name), "AMDGPU SMU %d", i);
+		control->quirks =3D &smu_v13_0_0_i2c_control_quirks;
+		i2c_set_adapdata(control, smu_i2c);
+
+		res =3D i2c_add_adapter(control);
+		if (res) {
+			DRM_ERROR("Failed to register hw i2c, err: %d\n", res);
+			goto Out_err;
+		}
+	}
+
+	/* assign the buses used for the FRU EEPROM and RAS EEPROM */
+	/* XXX ideally this would be something in a vbios data table */
+	adev->pm.ras_eeprom_i2c_bus =3D &adev->pm.smu_i2c[1].adapter;
+	adev->pm.fru_eeprom_i2c_bus =3D &adev->pm.smu_i2c[0].adapter;
+
+	return 0;
+Out_err:
+	for ( ; i >=3D 0; i--) {
+		struct amdgpu_smu_i2c_bus *smu_i2c =3D &adev->pm.smu_i2c[i];
+		struct i2c_adapter *control =3D &smu_i2c->adapter;
+
+		i2c_del_adapter(control);
+	}
+	return res;
+}
+
+static void smu_v13_0_0_i2c_control_fini(struct smu_context *smu) {
+	struct amdgpu_device *adev =3D smu->adev;
+	int i;
+
+	for (i =3D 0; i < MAX_SMU_I2C_BUSES; i++) {
+		struct amdgpu_smu_i2c_bus *smu_i2c =3D &adev->pm.smu_i2c[i];
+		struct i2c_adapter *control =3D &smu_i2c->adapter;
+
+		i2c_del_adapter(control);
+	}
+	adev->pm.ras_eeprom_i2c_bus =3D NULL;
+	adev->pm.fru_eeprom_i2c_bus =3D NULL;
+}
+
 static const struct pptable_funcs smu_v13_0_0_ppt_funcs =3D {
 	.get_allowed_feature_mask =3D smu_v13_0_0_get_allowed_feature_mask,
 	.set_default_dpm_table =3D smu_v13_0_0_set_default_dpm_table,
+	.i2c_init =3D smu_v13_0_0_i2c_control_init,
+	.i2c_fini =3D smu_v13_0_0_i2c_control_fini,
 	.is_dpm_running =3D smu_v13_0_0_is_dpm_running,
 	.dump_pptable =3D smu_v13_0_0_dump_pptable,
 	.init_microcode =3D smu_v13_0_init_microcode,
--
2.25.1
