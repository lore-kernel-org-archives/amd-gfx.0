Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700D3C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jul 2022 03:25:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F398B112648;
	Wed, 20 Jul 2022 03:25:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 088FF89948
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jul 2022 03:25:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwBha4o89OTwWdIDE2aydVQcOorduTWyGfAA52V3AqrFVgsUtuKXe+uiV0I3VMzpc0ykZ971XZ38ytno88bzJHMwr/Y4l6rKdDERQwsaGYgnQf9WbTAwogc1XqoT4fPRiLJgaVe4jfk9/xqPk5+yjJYtelzJhZrSL0xRXvwREC3g20BM4B0XuaqKxR/vGL6HNgQ7/KOT+9yiNI1CNxeenYFiDqL5j8CkW930xRIZcltU/JPZwb8NtELw7zfHVI7GIto+eayXhENI7aXIgdzVF8BzdcbcuNmwtvUavaViOrZjL69d5AgEELE3kBzg82fDg6lMWDTeEOCHrjFEwHJSlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6N3YbgWoQfS/RIB6sq5IGPsZmNAF7NA2/mJzCJVxbU=;
 b=PotoL3F/JzfkCkvy4QXazb5MVQRSVv/pgWD6mxGKQVmHBSKreao2TCZKwIReikLNVax5DIyNvfSxjqfRX3rMws564ExLRxA5wbfSmYoaEpH+B4m6ITpNmGITiAWo22n7Rm7NtE2vs1znhJWQqcEDEVTO+NkP7FgM5JGNg0drHyNFw0x9TSV+kWK8F08Tzit5TMsBms5r++dJQwysWwQnNV8IBx+6utCK3zUKa1cot3kXBcXPAsckPxwJqovcM4hCqsPlkk2eOPfzRO5eYrE1WEGRsllfIBmGnrtY/IuVzXCCXBayOEvUBE5o+7OB9vDR1+IuiiXZlna/2bolOVM/7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6N3YbgWoQfS/RIB6sq5IGPsZmNAF7NA2/mJzCJVxbU=;
 b=XbrhExXMrL0nvYD+wAbRNq4/NP2hVdNE4bDCLxOVWN46amX0N0ikTIRRL4hs3B5KtZgP4RNl6nlNGU/elxmt3EIeGEN+5ZhCEKjL6Op45fm+ol/KhyGdBEXXQO/8Lp5zIzkIqnxL1qorI7qCg5YXsczC8Zs+o62o40upSDG7Eh8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH2PR12MB4263.namprd12.prod.outlook.com (2603:10b6:610:a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Wed, 20 Jul
 2022 03:25:33 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe%9]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 03:25:33 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/pm/swsmu: add ras eeprom i2c function for smu13
 v13_0_0
Thread-Topic: [PATCH] drm/pm/swsmu: add ras eeprom i2c function for smu13
 v13_0_0
Thread-Index: AQHYm+OCM68al2P9yESYc5j0PS7hka2GmN/g
Date: Wed, 20 Jul 2022 03:25:32 +0000
Message-ID: <BN9PR12MB5257B1A6449B44A3958FD7D3FC8E9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220720024925.9640-1-YiPeng.Chai@amd.com>
In-Reply-To: <20220720024925.9640-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-20T03:25:30Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c7ef7e00-35a5-4cf9-9a74-65b92bf615aa;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5689023f-1004-49a4-0a23-08da69ff8125
x-ms-traffictypediagnostic: CH2PR12MB4263:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mClwCEUCSi8TZ8kAaKLC6Jx2CUBQDuRFRZvElSTCvTsxgp48h+IcuBHZpf2lo2RZBesij8VgLRcv8KKHwvlkuW/xYZHEB9DqCJhMgwMHTHJoe3MWXAHN+j2PEkjR5ZBxcSDEWJM8S7gCY0A9pyzW+Xrjz4qvBP1+3uH14UQ7zCIEwoXRnk8xV/Ar5St9OKI+qADs1rFCaEUhRcRdOTFlM+nmW5QoCk9R3nqbiG3vKFf52KNpQ7J4RbPxdA+5bgy2DxYImUutWjHSKTaDUwFe94HETJ5LL3aTzm4CuCxy4ibGAx0SKznHwoD4T39eJVQqrdHvY5eJGYNu3r3eogCTx3zYKLEiEQkxh62GRlLmivdLW8ZiTCZwLpE39hgHez1CcMj4Xz0qvUq471y6Cl6HzdIvTdZSSZvef2FoyzbZC3f8re36rnbn6TgcxsXsJVOttoOY0Dp/aRRKFOUGLRavOUAciroNP9BTM3szLAGQFcflwnT26aTV8uYuUspVgxNWDmjqWO7ZwCYey81ni0Td43JJ8lLDgEVWdnX6Yn3Td/fnmwLZgA4v7j22APzCr+lcQY2P55a4mAfUjIy81ZD1SL6XpW68cr7iRB0GRfuwEQdtpcDVTw5Keq8vxSU7XV1enSDHC/ySwoz65XdE8n2Abey6mA323Yd/xFzweEyGGb6PzZ4/Em6b9QhS0RcSrD9H+RSOFcCmJbiWj7dXH31W0BqM5oZ7xXYRvfHgUPBtfRftvwKdQ+9H6F6EkJ3/AqRGMVYw1LIosiJRaKJa0yAMeIWmjoH0AX4XerlWEQJps2chB+v7UoK/N4zTgkh5rPiVMo07VWjTVvZ3npV6k103MQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(55016003)(186003)(5660300002)(76116006)(8936002)(52536014)(6506007)(83380400001)(7696005)(41300700001)(71200400001)(53546011)(9686003)(478600001)(26005)(122000001)(110136005)(54906003)(86362001)(33656002)(66946007)(4326008)(66446008)(2906002)(64756008)(8676002)(38100700002)(66476007)(66556008)(316002)(38070700005)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tmT3+77bRuo6B2AB3OcdFjLDwEqwE/v/MrmOm5EYFjz7BEktiXCeYlGI3WtQ?=
 =?us-ascii?Q?v02k/QisPa1CI4FGcSZ/crwBV3gbpOeLNfIdd6a7jtZyKd5dfxPfTmDNk39/?=
 =?us-ascii?Q?uIwNdXRvdjeAwhSZ91UeGIrNv6/FHv4iQwNTYKou6dHrSKslOtMDBqtCiRyP?=
 =?us-ascii?Q?HO1I9v8rZatB6fz3tGm5kBuCZHi/ik0ff6ffd7eyfCFuVqgTn+0lCUWVfPNp?=
 =?us-ascii?Q?5irE5iWUZVA33c5UtVPHkHyA/ia/onalZ1Wn/9QnHq05GWuAFoLRuz8dTz0P?=
 =?us-ascii?Q?pf4dFNu3vpnIUXlWd3XUD81TBiP6WnV1Jgja5ZBNA+6nw5nOWnTUZ4JHhu36?=
 =?us-ascii?Q?iyGYTstFWE8+hvCcj75XS5zsFZoRVo0VhGx2ydPVuhJ3g0D1e5TKddPtJy4R?=
 =?us-ascii?Q?L8qO4gMPBSuSuJll5Tsjq8oWI7Pl8V1YUWJdwQ4csD/RZBDhoY/sideLg7Gg?=
 =?us-ascii?Q?kO9FSnk3TWbXPpK0IqJ+ANu2jkIXw29gyx8+UqiBbA29IkdLFwDCVDTRlmpM?=
 =?us-ascii?Q?aAwVqz0jdQD80p/EppWPXIYTiqBBsZ+8SeO2FTwPebVCMAXzcRjcHIjq6Aq5?=
 =?us-ascii?Q?QTLhWFMTexgEwPGz2DpVvfAne7IvlJGJ4FggTKvX460DoeHFQ9e3RQxJru8U?=
 =?us-ascii?Q?YrzpX/uejNRpw8MjGcAPk6UWrLptpbar6aavWek+78Ymybfjd6b2LHxPmqi3?=
 =?us-ascii?Q?tglBVhqhwRMljNM43EDE4wqE5Z0ryOrA9iR8LosjC7jJ3c8OMnbkMkByX9Tg?=
 =?us-ascii?Q?viRE6foPm/93u4PtvR8/y9uN+5DOhICdhjZHb6nZaw777mT6iZkyHH8siEZs?=
 =?us-ascii?Q?FBZ+AFoUJQRij+Fr3o81mksIuLVcE+Cx6z8b2+/IvSip9TJZg4iy+idspoI8?=
 =?us-ascii?Q?h0lBEJGNi/T6gTKRHiPoit3zDjs7j3q7BJrkC4V0p/dWrS548otozseUc7FJ?=
 =?us-ascii?Q?D/Jl2kyBRjGRX8UIEreNf4rJNE85Byvau5kNEaWnrkbvjFKPnAnt3R6CkywD?=
 =?us-ascii?Q?DhobBpO+GDVAnwBTy6HZZY2HnYAgs9+slArEMi2aA1b5iHxfJc+OmOsqvw+K?=
 =?us-ascii?Q?EBgkET58vPzyACR+AlTuB0Ox8KW1vNdat9/yut2uTdhgoSNGaLXyHqz/u7kb?=
 =?us-ascii?Q?00besqSnYiSL4V5fE9Lj+L2hgtnJgIX1zsXT0u85xXVHd5tWQxhZqMQKCPCA?=
 =?us-ascii?Q?guXmE9mNOTJyighmzZBF14dKB6s2pwu1cNofj1BUaaN8QXe3S62Z7j5fq9hF?=
 =?us-ascii?Q?0noHg1xbJJCwekEC9hQN3hoyJhXlpmL8XTecLCkr0TtQCz+4czN4ieJgODA+?=
 =?us-ascii?Q?kxldhWsMOM8CCDCc+gb1l9tS+JKhwcG4hgjLOK82EwJkwSDW8B+uN5eUb8uh?=
 =?us-ascii?Q?ppNcDG5W6PnquQXYEFBhUf0geu2Yw3mIQcnQ/xmpZPZmCBhvRGickMDxxj9Z?=
 =?us-ascii?Q?A7mWJldkTK1+NLpeR96sAEdlMF2EmqcXcjGNJiIuX/TkKPYKXZxX8GzYXvVI?=
 =?us-ascii?Q?S3I6BUD1wQUKO6gESgU5Fv/16VJyk6nB7zMri+La1ez3Jbqx6H/7ayAnUY3L?=
 =?us-ascii?Q?siy0d742m1h/pexvB5/ZdcNRDJ3/w+u635QpsvQb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5689023f-1004-49a4-0a23-08da69ff8125
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 03:25:33.0142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qrLBSL2VzjrRkx1v30CaPgmP1deTBXRWijHdkmXGxyQvrqRmrxz4kIp1EL6jH2yge7A86tA8Dzh6EjRRZTHZCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4263
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

Reviewed-by: Hawing Zhang <Hawking.Zhang@amd.com>

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
