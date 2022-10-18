Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55F0C4167D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 12:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77EF310EF29;
	Tue, 18 Oct 2022 12:00:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB89910E7DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 12:00:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/mx5Kh7RN8Hq/P2p6O8eJPjIJ4INSonnFNiaIeOR7qweRL2Qqz/PzOl6Gj7RYD7Om0iisFAxKyaBo+0/5h9Y8yIqlccUT1pRO5seeO078W+pHupLKv77wD4mw36vQTWlUADkvu7zrpajffTSsRXkHeNrPv4eawrXQhaGdimtt1qHYipCSO828/nrhD6NtfbEwnP1P2LmhMcykfoFOGkPBn/sqHMZ64nTy3qFjYEJT4u3iB8VC5TutXbRQI6KQsVseKg48UHhheEKpW6Wds0XzSHmBX5O9C/L6OPmaBSMSkKD5ZTphpk77+Y/VLAXjgFtuV8oF0R3qX98QANLJ2ijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpwEmiKFvlagaBNto32a3Z8ONG8UKPTs5po671kZoVQ=;
 b=ofdFB8FE8or1snMCU0CqdDUm59Z40mt2jRZ48gZKaycHjJODx1bArjrGcV+cr7YrGvgWv1NXb+0nxk7hjDEWe0REgUiezkBU6/uX+OCn7eHTWRmfDrXAxXJO7cv3jmypuvTbQ67b55zLmIvxpGglSgqU/0rpIEC6fQEXHnoRh9kRYNkBbQ0P2kEQyGtIfBx8exUiib/pAjh4kTzZUKuDrvITvMBY6GzZSLtygTJpBWfXYTzogXIQwy+quS6lR3mkmrp5ldZZuqVommIpAblIKIjWYoMngnktBVHEuUaR7HH//Q+RpzbTosMf0HRgEdt1pp/5OWG2o9HHezekb2zU8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpwEmiKFvlagaBNto32a3Z8ONG8UKPTs5po671kZoVQ=;
 b=XIybhaBpFUmj6ZjnZV3+HReEMabwEIHeVAoG159addEXL3ulFkXZawhKnCLlESNAlt4lzKqPNk49+e0klMDonYE1kJaT9YBRs9QniqZq7EnuqwxcvOEv12zKArFPrlRLoK+aRGkPECKiZ4CfNhdc/aGTS9YEghP+1BIAF8Hosq4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 18 Oct
 2022 12:00:10 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::8bd7:b65c:13f4:9b]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::8bd7:b65c:13f4:9b%7]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 12:00:10 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: add RAS page retirement functions for MCA
Thread-Topic: [PATCH 1/4] drm/amdgpu: add RAS page retirement functions for MCA
Thread-Index: AQHY4swz9DktYLmRp0q5uP58o7qQOK4UCrhw
Date: Tue, 18 Oct 2022 12:00:10 +0000
Message-ID: <BN9PR12MB5257208364273EA4D1A44880FC289@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20221018083200.15597-1-tao.zhou1@amd.com>
In-Reply-To: <20221018083200.15597-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-18T12:00:08Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7c54ca06-8896-428a-9055-a71c360a333a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ1PR12MB6121:EE_
x-ms-office365-filtering-correlation-id: 14baa5c7-049b-4f55-0a98-08dab1004eb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ne9MWDJm7/2IlkxCIbR9Sp/27OWZWJjhxjsboy+BpapewBGLSvjFU9Uu+ZcGAvIb1Yol1kb9/GjDBxlXh+uNkcgQrtXCiQRfcvogY7OJ94JHbEXHGBaqyrBVsJtO4j/9YC7EmF3Z1xn7e5W+oEqhGuYkzyPOKtlxBxsfXrsZP2JsskzRMdSnRXRPIZBe1uRhuEaQYMfn+5DNa9ohjvQrik6m7S0tIBRoRlyepGfcTmxuOM/h6lcqj68J+id8iUWcoH9DRXJH7RMhFRt/9Uf0UHdduYRPI6ubE7y5bk6q3mY6Fsbe/JI38mcIrjtMvlxyPxHK7bfi+QEMzJcKMXY6gMvFz0ifq7UXzrhiUuf9K7pIKhc4v8JBQIfqH+CEjo21YcSxhqafXUl3Rbj2X7bEjFlR2G2A6v5R7axaraCLzdsiQ7+vBh8EgmZmRShjWYxJAeYH6PdMPW/R3/NCs7iP/GLtYEBrIMrCvIAVJG99UGwo0+dzHvr7ZGRA9DgM3DhJCV1/eohpBbgaV0p0s7EJNRoAt62fxulBR0ESuPdocPkfNFXYxo0/O5K/yNwTJgHFDQpqRZAkyO9iWgzBVyK8rsicEoGiemCeimrYErwgD3U1TBcINeZzt3N2vOp5ipk7+6ZJskPVSvr550Dtl4S0vKGIXAtp8ipDJm9dWP4pLVprWxBiXXd+x7vulsc0ZMmQMHD5USEIsnIoJJlCyNgeR7RK9Ept9zeXNF4bnJirOia7kQAMVbL7buNzGpuvwdoeAS5AK8cUgb1MGYaIav4QuA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199015)(86362001)(33656002)(38070700005)(122000001)(38100700002)(2906002)(83380400001)(55016003)(5660300002)(7696005)(6506007)(53546011)(9686003)(186003)(26005)(6636002)(8936002)(316002)(71200400001)(478600001)(110136005)(76116006)(66556008)(66476007)(66446008)(64756008)(8676002)(66946007)(41300700001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g0oConkXvNPkn2DAjhzjvQfSpmloWf5YmaW15ycLlY0r2FQH0VbL2aOTvQ5J?=
 =?us-ascii?Q?vKWqz96mX67aWpixoK1Maf6HIjPVAppSuqjSkepM5v8o57bWHxiJgFVUE1wE?=
 =?us-ascii?Q?ADz28TLrmX7G5RhF8dHlHs/WHjYXT4ottNbHFxSFJDKiaWSweGYEzQSaNs11?=
 =?us-ascii?Q?Dhng705r2rxtQqSny6wQamIdfke9Kh0nkN1YvxKjV2tzKVSaWfstoI2h8KBr?=
 =?us-ascii?Q?l+QwKgk9nP7D+0pqf0OcfwmhIMUCZ3I4t0UI+d6hwO1PbeyNeTWuxlXotoTJ?=
 =?us-ascii?Q?bow65hqMOi9SMa0sLA877cUlEjwGH9IkeSqGEno36Lbpj9sLp0i71el/kNgB?=
 =?us-ascii?Q?q1oqSdKGFQOrWlQYj7pnb7/blghGNy0y5bzq4oxgSWghkgE4rPvekHzgEJ71?=
 =?us-ascii?Q?prgrW5ftHmZxLUwT5RjzyZgK2a8xhGEDDuIeI5ClEyn3x1OnTiHqKgGDxKzf?=
 =?us-ascii?Q?vmqpc3r4a2LS5DeWn+Id7jOl2ufNGUN3oRd27uXfTvvObI7xXYiMorGRkBbj?=
 =?us-ascii?Q?XPUC3VPr5lChmUGFwP0LPJFIuNvyOQlus26zapKXxSlal8xFi7vwi+mtpPuh?=
 =?us-ascii?Q?2t2+Qbl5814EvUI7Y67xr/PuezcXoLn1L/OsDXDMeLrEsCR0U7NWnYqd9dEX?=
 =?us-ascii?Q?80ZvHJER+Sf0grD33741HaKGFgZM7rCSHqYTrms9jng03l2shZAVcED0YmMQ?=
 =?us-ascii?Q?HqzUEWMyMOkz44sG1WJARr/uh1Hzmj19IEOMHog2C+fR9VPDUi03TiSm4RgV?=
 =?us-ascii?Q?xzk2VxIiJ4aH28KBQlf7Ru1uImbwctcna0E8ojz93+/enr215nfk4ihI902+?=
 =?us-ascii?Q?PYDNyOZxiPo8RERYr0xH+msZ+aS8iNFRSFzPSPwNpQJ7ZJ0+W6yR6ki4zV1U?=
 =?us-ascii?Q?zs2XYRDmN74IZ+eVPt5lGe/r5wqLxw1YfqzkLnPrqL/QTgZaY0Ql4UTlm10T?=
 =?us-ascii?Q?YOQ/NnsMSH0l6eQmJI4AOQRdOOxCW93CwvgU1Mz1R5c1/cvNTwZuc2NPSYab?=
 =?us-ascii?Q?Vo5s/rmXe7fCc2C7VtzRd0OfHPULTghMBWS3jRk8JbIDJKoOCqqAU5Jx7rbS?=
 =?us-ascii?Q?gLZCIdhkd9lZjtrZFyPqymLqkmSU77ZzBM5eZBM6nqAmWwrUQBvi4SID6GJl?=
 =?us-ascii?Q?VYM2vylLyUuUuGMkwq18Cc4nXsRLwdoYlhvR0MKx3ET7VJcSE8qYc5/xpKFO?=
 =?us-ascii?Q?dxvCWd78aGMQJhwhv2TBQ9RwxLkjElYWTQeTG0QRZDK/Z00KypVnA9pX56V3?=
 =?us-ascii?Q?yUoJWIN759+5upCeLOkCfPPDxBFNiFD28E8M0FaRzzLeRmRCKycoOwLvXyEy?=
 =?us-ascii?Q?E20Yaq4Bn3GIApEVr4rdjnZzZNtfR3LdIQqfKPhCixoD+xQdqZvjnecavW72?=
 =?us-ascii?Q?9isa1jLdUFpg6RCZI7aoCBNYlvJ1qIlitU33ezg8jUVCeG+s7rqbUXOVoyv+?=
 =?us-ascii?Q?Br7SAQSVI2eZGwQUP2QkyUUVo1gB9Jpg4F6hKCtlN7xm7NPcn5lzmVvkX/db?=
 =?us-ascii?Q?JPv1FoYIHDIW4Z28JmMz1wvqV/+a4p65Rsvu5CgPls4lRlvl/Zbwz+VjDgGK?=
 =?us-ascii?Q?oPZrzd94EqzvkGaDus8WifC7IfsMthuM+PCzAOWu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14baa5c7-049b-4f55-0a98-08dab1004eb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 12:00:10.4794 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M8Ybq42bE4sOw3FuY+gpN7zAyqR3WjTSFuAfgWJ/DS2ywI1nmgukl1rg0hnTMAjUFmo6s0JaR2QReTXFdpBSZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6121
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

[AMD Official Use Only - General]

Thinking about it more, I'm leaning toward *not* touching MCA_STATUS in poi=
son consumption handler on MCA (A + A) platform.

As discussed earlier, the asynchronous access between MCA driver and GPU dr=
iver introduces the risk to break the message queue of bad address because =
of the nature of MCA.

We shall keep GPU driver away from any MCA operation. When poison is consum=
ed, GPU driver is *only* responsible for unmap_queue, or mode-2 recovery as=
 fallback, and only monitor MCA notifier for the bad page address retiremen=
t. I guess we don't want trigger MCA reset and let MCA notifier report 0.

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Tuesday, October 18, 2022 16:32
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; L=
i, Candice <Candice.Li@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: add RAS page retirement functions for MCA

Define page retirement functions for MCA platform.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 112 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |   2 +
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.h   |   2 +
 4 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index aad3c8b4c810..e97b1bd343ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -22,6 +22,118 @@
  */
=20
 #include "amdgpu.h"
+#include "umc_v6_7.h"
+
+static int amdgpu_umc_convert_error_address(struct amdgpu_device *adev,
+				    struct ras_err_data *err_data, uint64_t err_addr,
+				    uint32_t ch_inst, uint32_t umc_inst) {
+	switch (adev->ip_versions[UMC_HWIP][0]) {
+	case IP_VERSION(6, 7, 0):
+		umc_v6_7_convert_error_address(adev,
+				err_data, err_addr, ch_inst, umc_inst);
+		break;
+	default:
+		dev_warn(adev->dev,
+			 "UMC address to Physical address translation is not supported\n");
+		return AMDGPU_RAS_FAIL;
+	}
+
+	return AMDGPU_RAS_SUCCESS;
+}
+
+static int amdgpu_umc_ecc_info_query_error_address(struct amdgpu_device *a=
dev,
+					     struct ras_err_data *err_data) {
+	switch (adev->ip_versions[UMC_HWIP][0]) {
+	case IP_VERSION(6, 7, 0):
+		umc_v6_7_ecc_info_query_ras_error_address(adev,
+				err_data);
+		break;
+	default:
+		dev_warn(adev->dev,
+			 "UMC error address query is not supported\n");
+		return AMDGPU_RAS_FAIL;
+	}
+
+	return AMDGPU_RAS_SUCCESS;
+}
+
+int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
+			uint64_t err_addr, uint32_t ch_inst, uint32_t umc_inst) {
+	struct ras_err_data err_data =3D {0, 0, 0, NULL};
+	int ret =3D AMDGPU_RAS_FAIL;
+
+	err_data.err_addr =3D
+		kcalloc(adev->umc.max_ras_err_cnt_per_query,
+			sizeof(struct eeprom_table_record), GFP_KERNEL);
+	if (!err_data.err_addr) {
+		dev_warn(adev->dev,
+			"Failed to alloc memory for umc error record in MCA notifier!\n");
+		return AMDGPU_RAS_FAIL;
+	}
+
+	/*
+	 * Translate UMC channel address to Physical address
+	 */
+	ret =3D amdgpu_umc_convert_error_address(adev, &err_data, err_addr,
+					ch_inst, umc_inst);
+	if (ret)
+		goto out;
+
+	if (amdgpu_bad_page_threshold !=3D 0) {
+		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
+						err_data.err_addr_cnt);
+		amdgpu_ras_save_bad_pages(adev);
+	}
+
+out:
+	kfree(err_data.err_addr);
+	return ret;
+}
+
+static int amdgpu_umc_poison_handler_mca(struct amdgpu_device *adev,
+		struct ras_err_data *err_data, bool reset) {
+	int ret =3D AMDGPU_RAS_FAIL;
+
+	err_data->err_addr =3D
+		kcalloc(adev->umc.max_ras_err_cnt_per_query,
+			sizeof(struct eeprom_table_record), GFP_KERNEL);
+	if (!err_data->err_addr) {
+		dev_warn(adev->dev,
+			"Failed to alloc memory for MCA RAS poison handler!\n");
+		goto out2;
+	}
+
+	/*
+	 * Translate UMC channel address to Physical address
+	 */
+	ret =3D amdgpu_umc_ecc_info_query_error_address(adev, err_data);
+	if (ret)
+		goto out1;
+
+	if (amdgpu_bad_page_threshold !=3D 0) {
+		amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
+						err_data->err_addr_cnt);
+		amdgpu_ras_save_bad_pages(adev);
+	}
+
+out1:
+	kfree(err_data->err_addr);
+out2:
+	/* trigger gpu reset even error count is 0 for CPU MCA RAS,
+	 * MCA notifier is responsible for page retirement if error
+	 * count can't be queried in poison handler.
+	 */
+	if (reset) {
+		kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
+		amdgpu_ras_reset_gpu(adev);
+	}
+
+	return ret;
+}
=20
 static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 		void *ras_error_status,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.h
index 3629d8f292ef..659a10de29c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -98,4 +98,6 @@ void amdgpu_umc_fill_error_record(struct ras_err_data *er=
r_data,  int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 		void *ras_error_status,
 		struct amdgpu_iv_entry *entry);
+int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
+			uint64_t err_addr, uint32_t ch_inst, uint32_t umc_inst);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/am=
dgpu/umc_v6_7.c
index 72fd963f178b..b0da50d03af6 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -252,7 +252,7 @@ static void umc_v6_7_ecc_info_query_error_address(struc=
t amdgpu_device *adev,
 	}
 }
=20
-static void umc_v6_7_ecc_info_query_ras_error_address(struct amdgpu_device=
 *adev,
+void umc_v6_7_ecc_info_query_ras_error_address(struct amdgpu_device=20
+*adev,
 					     void *ras_error_status)
 {
 	struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_status=
; diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h b/drivers/gpu/drm/amd/=
amdgpu/umc_v6_7.h
index 105245d5b6e5..24382e9e5814 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
@@ -74,4 +74,6 @@ extern const uint32_t
 void umc_v6_7_convert_error_address(struct amdgpu_device *adev,
                                     struct ras_err_data *err_data, uint64_=
t err_addr,
                                     uint32_t ch_inst, uint32_t umc_inst);
+void umc_v6_7_ecc_info_query_ras_error_address(struct amdgpu_device *adev,
+					     void *ras_error_status);
 #endif
--
2.35.1
