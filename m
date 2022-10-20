Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C814C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 09:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23BE110E4A4;
	Thu, 20 Oct 2022 09:12:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0832010E538
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 09:12:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7+DN7kZXduzDax1dhQShi1t3dV0FRoXfchKwjpEHTTWIjnPbNsbuZvZuoNzkOtO+GlPrMLs5TVVKA+l4tATk/CtVQQpf6mYrPx46RCo4O+K503Jx0IVmDl5KJlnGI16D0HFKIt5/N/VAYr3hTl3hsk+VQqFIWqOj4smNB14HST6TQU+HjjzF5BtH6FqGpbrPAfE3hQGn4sFR8qOq9mG1ILkNz20nZxBtQynLsQ9fap1q7pMKYuANZq5kHqnYdM5TT59JxxYAAH9y4JlxC/igxdcCjpj872A+4m5WreSeHL1xHYhBms76UCB8QIoJJB565Hew9y0gkpIwgCy1uzZzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFu5gfClEAcUIzqeVLVcZV9E/2UaDPk7oo9WLvoHFeE=;
 b=nDXNECkJJ/DlXY7ottbfTGfZ8fuy7atWEeMwAuCszQMcL+OAcqq9AHfQxiB64+v3oymu+IriN/h2RP2Hb2k0WPgGjYpX6wTmN0ldmwKqo02YX6AvYHUVT5k8/PWJ428CsjdZ3gfLE/BJW8Q8U60day1vQjyT/Wm0LgcD3Ytbt3qmso1gpVTP77z+y+jYRQp/B3Bi/w+08gJTi+g2OflMAgJaJUtznImom74EQCxaP0MD1u2Yt2UA2UgWZW2Jg70+oHw7fVknJbHdV6y7gTwDeEOjbYnGFn1a9VXsUwvWcFsq9ySHX59ZRwfPV4PHUPiUDCs+coN4Dx4/m1rMHtTrUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFu5gfClEAcUIzqeVLVcZV9E/2UaDPk7oo9WLvoHFeE=;
 b=kU2tsdtQPAIesF8EmliaVEWU/BfWl2pv4JnfNcPrgqNZBDJM+D5LBcIfCNh//jCEe3lxQNEFjfDlkZ95AT5dI0A07oTCU+o2305iqtYsmz8woOT0ta6Z2S5gOBV4Jifncw77al6YwWXCrapmX+Og444ZLJFftrFVXS+VrTz9ovs=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB7113.namprd12.prod.outlook.com (2603:10b6:510:1ec::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Thu, 20 Oct
 2022 09:12:45 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::8bd7:b65c:13f4:9b]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::8bd7:b65c:13f4:9b%7]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 09:12:45 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: add RAS page retirement functions for MCA
Thread-Topic: [PATCH 1/4] drm/amdgpu: add RAS page retirement functions for MCA
Thread-Index: AQHY45KJoZXNP2qgnkmS8JxqkkhKgq4W+OoA
Date: Thu, 20 Oct 2022 09:12:45 +0000
Message-ID: <BN9PR12MB5257D39D5568891CABB09B62FC2A9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20221019081150.31773-1-tao.zhou1@amd.com>
In-Reply-To: <20221019081150.31773-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-20T09:12:42Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7f91dd3d-e8a5-41ea-b651-e89e88c8c2c5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB7113:EE_
x-ms-office365-filtering-correlation-id: 3f56721f-e502-4d29-b3ce-08dab27b4055
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EUUC4PxF0TPhJx13orxh1W8c7XWfhV6tE73oexqMMwr0w2MQ496Ehd6tlcn48nQ6Hci8/rBQyOiTf6yIacH+PC7/xZ4uVgeiA/W5k2i3ogb9iIZxh+JxgFw35sorvOX9gIGIdb0RQlxVnj6nBg0D9bPgWAPuZOb5JtovD5zz2I/W6bRn+ZW4dCVnCEFcITmft9DeOe3ntzIh1YJ832oOKlZDLPWvNKd9Jqx4wP9bzCOruyr4wclHTPenkz90kKoQcOKDtS/EiO8GUJlPOW541mXBNdQNcIb2AoL812hS3g9bC9sRRFpIxAFGXuhP3xPqRsRGxmBfwU6e3ROHbDgWWy9s7FQ19phDD+MyiN3uPkRdZ71mhsclOpF0NtTssH2MpW2vsNtP0ydYtw4gFN0OlALVvmYr6Icn6Cky7qzfHz9Of/XlzvqNPIjlxC1R5pfrgFGLY1jyhm4y2gKI1Z8nBo8yCKt0FFRaFu9M0HrKk0qpdDIhJU8of2dVA6JIqR4ix1TwIRdVEe0HFb/TlXv5Gw6BivE4dWNEoHKZrGXcSsJSKeWe9sBWs0qufWdXtnEkyE3BmkEdeExuMyARwRgYrhKt8k1VFZDNHOo+Uz1xKTtGgk3UZlSZwJNwBpyC0Wbq3DeW/FCWPqXf4/81FN7Dg3t+MekW8K+DGKCi+st3ezqFLhfM8epEa2cf8AvG/N4UtASBcjL2mZe2IZQvxIVGHa286eCJ7W7/dNmh6nxHITPJt4Sz6TOLNb1usQnQawjZsMEnsyAPviPaLfZ2y9U9tw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199015)(478600001)(86362001)(71200400001)(38070700005)(38100700002)(83380400001)(33656002)(316002)(6636002)(52536014)(8936002)(55016003)(2906002)(110136005)(122000001)(53546011)(8676002)(66556008)(64756008)(76116006)(9686003)(41300700001)(7696005)(6506007)(66446008)(66476007)(186003)(26005)(66946007)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?busQrwzXc4OAnxHQyRymah+X8No2vKMSwz01OKtYnzEHAzNW+ChNR+lCeEqa?=
 =?us-ascii?Q?H4Zc0XZrbSPY3qY3GuhhyUvHCbo6z+/SLefZgr9HlCgbbPhHPHC1dSJL5ceR?=
 =?us-ascii?Q?zxbSPe14Mu0Ijvt+dEPXXVSxLF6rYCWltPdL0+hI+QJ7NB1qJuoSFXtuq5cc?=
 =?us-ascii?Q?D78dPiUxYLSq6YymXPxVGGrisqeaoYQAN+JKQZKVMtsnBpKB8Z06v9/VvnUm?=
 =?us-ascii?Q?9GYjcF8JtqQs3w3AH6f21zp8NtavDVQ16YffedBsslvyuGdWHZuSiwDlw6Lh?=
 =?us-ascii?Q?gOu12XuG3e+ui8PudfpKkg8ytrt3lcVRGANOLbWvIvf0JLElCkzgOVBM1RTe?=
 =?us-ascii?Q?BLkI2L7ycriB5uE6gLf0sOqYSvG4KIBZLaArFa9XniqxeKwgn9+DDPLbyaCH?=
 =?us-ascii?Q?ShsQEUf1UYfzmBdvbGGvvaVXT+BrdFCGKYw1K8TcONfXjz0yal7yMezuezlH?=
 =?us-ascii?Q?OtLQ4jEpzC+4z9W1WCUpzgxdDXB6+8kHz2rZwCzVsTnKQ3pydT1Spvq8Jj72?=
 =?us-ascii?Q?2TbxMRGAYCmCrVDfndk3bfCgqpSZW1GTZNLGz1K929pfVtZfAjlXNQyxA3gR?=
 =?us-ascii?Q?u7LtWgyJayCG3Vmnfl6lmWfrHOTbjZsLxV6xIAFaC6MwGE3kbvwWz63uJus5?=
 =?us-ascii?Q?HNLkxS2M7bAYKXyKfwxAuLHHZ+MYD2KNIUItx8HuuPjLXIOFTrtEWQjVAnZc?=
 =?us-ascii?Q?ZiO9xNg0YAOI0rd+IkTFRIZYwRKKkoVg9KmqWPQRl3e1ZqDplCunMQ0+zj/3?=
 =?us-ascii?Q?CGdrjtEZ9evE7ynEJurkAKlFxXVyBABf1/v9VHvmS5mDxk1LI9OQisgKmdcH?=
 =?us-ascii?Q?vLms6gJm05cWYiAeEs+RtQp9BkaVM015CF/otM28JEuLKRxtZq7FjvJFjjgZ?=
 =?us-ascii?Q?9lTMxFD4ySMmn1/1jxqGo904zYYjK4X71Sf/jGTln+DGwpP2UT1VrEycgR9Y?=
 =?us-ascii?Q?ArV5pugaOK2gul/uLjcKM7kCo4YYYhKn2DCbVzsiDKVgJqvvRcV4jubfH1nI?=
 =?us-ascii?Q?AfmoqYx1VFTLI1bB+Cl0w6lIx06tdu4w34A++6JgnVvZRMgVuXMLpnL3LM3x?=
 =?us-ascii?Q?Rz+FudSvXDFaAC1teT4l8I0kYqEJ5racEpm1y14GHzb6yqcMwwLN1/ObGey3?=
 =?us-ascii?Q?Iz7rszPxs8SJjzfWAWHYHqaX164CyAQlxThhzWaB0ZE73OP+Y2psxiCA6kQN?=
 =?us-ascii?Q?2RYTRsAHqr93Zl3OgMWElhI2OrbYM60jl8F0LDXJGaI2vmxYqeQy3GGIiLDm?=
 =?us-ascii?Q?kWlkorzE2ILXNQUsmHVtmusB96J7sQBLQTJpX5hHplblNdK9Tf3eKi9GZyAi?=
 =?us-ascii?Q?RGCODcaY3lCFJ0Q6tiaL5gnaedY+9aA5S7UvPDXupEZKPXcnSP7W1gkwIoi+?=
 =?us-ascii?Q?Yctc1U0sr3IEF2yCuL18pcMcfE9LHeOAyLLNY7Mov25nIedhgSY7zL/Iljuj?=
 =?us-ascii?Q?09bIKm53ngTthYiOzEJnI+FPwBNg9fKcXT88kj+08ec0JU6DTRxhTnLbsKBz?=
 =?us-ascii?Q?h1XMZTtD/GIDOiXV9bhAC14Pj6GRgtbd2PlxJlfiL7VeZFCYqpYoSS0ERvmA?=
 =?us-ascii?Q?F7aZMavfUJfoHDmxI5NKtEwOSc2AJ02ujb02+//R?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f56721f-e502-4d29-b3ce-08dab27b4055
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 09:12:45.6270 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oNjjpIVHd4qdiGb968faayEJfT8FiQJ2xMK8pmSmPR6EWSQpRJxAI5bAhpyH5Zb888fTBveLkW1MX0OtSqMHuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7113
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

+static int amdgpu_umc_poison_handler_mca(struct amdgpu_device *adev,
+		struct ras_err_data *err_data, bool reset)


+	if (adev->gmc.xgmi.connected_to_cpu) {
+		ret =3D amdgpu_umc_poison_handler_mca(adev, ras_error_status, reset);

The input parameters "reset" and "err_data" can be dropped since amdgpu_umc=
_poison_handler_mca is dedicated to MCA platform

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Wednesday, October 19, 2022 16:12
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; L=
i, Candice <Candice.Li@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: add RAS page retirement functions for MCA

Define page retirement functions for MCA platform.

v2: remove page retirement handling from MCA poison handler,
    let MCA notifier do page retirement.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 67 +++++++++++++++++++++++++  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  2 +
 2 files changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index aad3c8b4c810..9494fa14db9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -22,6 +22,73 @@
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
+	/* MCA poison handler is only responsible for GPU reset,
+	 * let MCA notifier do page retirement.
+	 */
+	if (reset) {
+		kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
+		amdgpu_ras_reset_gpu(adev);
+	}
+
+	return AMDGPU_RAS_SUCCESS;
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
--
2.35.1
