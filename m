Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8555AC3ABB6
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 20:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFBC510E121;
	Mon,  5 May 2025 20:16:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cqvV595D";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B56F10E121
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 May 2025 20:16:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bP5XT6Q44e2KB9hUJZvJjKmU0u4Ke7i24YcjSndL7Dy/B53Iinef5MS8MthcxNDDJdAR8nWXO+QbMjTMjDy45mCdmoNKD6wyUkrtUaJcc2Nyow0MowqtQTmH/MpJL7m/L6EBqsGobRMGLdtV1SbqTIel8GjJpfodBdxj1WwMmgWU4Q5HlJKTYAZasndUGxogGBEfbA5HOeL1sR85LDjwbOTw4zA/WQOrlcg2J9EOPcp+DOj2rRsG7tbWbmIfKemQAMXyEVVskXc3ULDN28GRhQIIx5q2PaVsvOIg/5tsezl5cnOqqTjylsstV6A13FwU7GYAn4jKFdSOp9Rkvphgnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7kXdUuvlsdGRfZ+alZ+0I5hDeNFGLXGQxvGqlGt1sM=;
 b=SXwCjgzeui+tOQvGy97Jhyu9aYiRAJPFR85AI6cqDWbwRKHejSawyqEs0bEk78r6zyPw2UXHvmCSHl2RlwZb8ihJiOHCzWuPEgDN8krrZ9N+OlZP/yjTOUruWTk2l8gRonacfy7Z2MsSbrf9zkFScuEN/gCsNvV4qE92Lwiun7GdGdQGo+BwSWzUfQJbb42oQ/66XLAh35jWxsZGvrCB706BPcMVwjfKLVNIIvDl7gIOFcXxpE2ZBgkX3GNvRJFhK8ss98gI8ew7DLoM7+we2ir5pF21OWql2JfMq1If6/XLFbcg8gyKbPjVElEtCvqHsO/6gaHuZJvz0Q6lXUIXZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7kXdUuvlsdGRfZ+alZ+0I5hDeNFGLXGQxvGqlGt1sM=;
 b=cqvV595DpY/nPZQ07UIU6WhOIzdnS8wM4mkJ0UisL9k+v/vecYY7daGbMI9kKzR78fyFFOTgiH+mK0zGuOV+R81q/T7hmpiRGlPvKtCJfFZeGECfm00zshbTRHWp2wtERCXSUSBo6fmwTzpqzZGowgzHDkKvzG1bT/pHyusXdEU=
Received: from CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14)
 by SJ5PPF000ACABD1.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::984) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 5 May
 2025 20:16:14 +0000
Received: from CY8PR12MB7657.namprd12.prod.outlook.com
 ([fe80::dc50:9698:ac9a:b44b]) by CY8PR12MB7657.namprd12.prod.outlook.com
 ([fe80::dc50:9698:ac9a:b44b%5]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 20:16:14 +0000
From: "Gande, Shravan kumar" <Shravankumar.Gande@amd.com>
To: "Pan, Ellen" <Yunru.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>, "Rehman, Ahmad"
 <Ahmad.Rehman@amd.com>, "Chan, Hing Pong" <Jeffrey.Chan@amd.com>, "Luo,
 Zhigang" <Zhigang.Luo@amd.com>, "Skvortsov, Victor"
 <Victor.Skvortsov@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: Implement unrecoverable error message
 handling for VFs
Thread-Topic: [PATCH 4/4] drm/amdgpu: Implement unrecoverable error message
 handling for VFs
Thread-Index: AQHbuU9wmSlOidJY5kivvIa6n1RHsLPEgnFw
Date: Mon, 5 May 2025 20:16:14 +0000
Message-ID: <CY8PR12MB76574F622363838E625C65B48B8E2@CY8PR12MB7657.namprd12.prod.outlook.com>
References: <20250429214057.93114-1-yunru.pan@amd.com>
In-Reply-To: <20250429214057.93114-1-yunru.pan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=2fd63363-1850-4944-a0b6-d5f42b856ba9;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-05T20:16:05Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7657:EE_|SJ5PPF000ACABD1:EE_
x-ms-office365-filtering-correlation-id: b5453c9f-36b1-4ab6-ca0b-08dd8c11af78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?htqohMwByDlFwe5Iwv2Kc0P/OoJV2TpguSsTGOi4+EFOG7TNNReRB6UbCCtG?=
 =?us-ascii?Q?nQANXsYkvWU2ZERCCVY2MkMufq5Me/V38tvZcPEF17xJSrk1VNr6+sIqq6pX?=
 =?us-ascii?Q?cRHkN1GWJedCOvbTE2tv3feYDQQ+pYdZiypwrL2V+wRshdiaQMHUl4LkAsxl?=
 =?us-ascii?Q?HMzzOILJydtPaIUeZZgsth0UorB0XVy72INKBTdGLAzTXxmnWlPQKp9xgiou?=
 =?us-ascii?Q?JqtJ+ZaTOUWCvC3Kxos0XoVw/INIDFnbB7HuJSAsRnlW2/RFBO6Etu70RU31?=
 =?us-ascii?Q?k5TV2oXcM6xysbNTeDYy2i0fAeQ5HX2b+vtdzHf53VxFLOaLtDchs1T+MOp+?=
 =?us-ascii?Q?Bs2LMKEEqrJmV2YTAILI7fAKC1777nI83H2+SbSaNBV2cphPAJ+GbThKNI3k?=
 =?us-ascii?Q?UOrqgQ8JvZud5EIytjOCoXbZDRo6o0U1YVB7+xGGCcJMSKX7l8bywGVrUzJR?=
 =?us-ascii?Q?ih3atlfvjjjjsAnevWPThvWqzFbU2xAyGwdPqH50vwF4ssTBbBd2RH5E0Jd5?=
 =?us-ascii?Q?ZmEwrPFgBaiPq7VPPZP/ar/kOGoumDP5pZRzVhpct/4XFRO8fGnwpjkNWAEO?=
 =?us-ascii?Q?uyHxeDRRF0+rRR1Yf7bSYHMST8eTl92Kyy7yoyMcDjMDl1Gd7L6YgzMJJTrU?=
 =?us-ascii?Q?+Rg2CsQRQrAJFG2ATBX2OPxdM1yLPB6dS3p0og6jCEWyGBz0Z0OK8A3v1Fxs?=
 =?us-ascii?Q?b2JNiDFopqH2pFJYmYr3/ZUM41tOMHZdfn+7STuGEnbkMh6xjFWs/hshYIqR?=
 =?us-ascii?Q?SjSr0twuH+9SXDXU+DnPkzqT01eOLj5ZB7No2u1S0x29pQorseOOzzJMaVeH?=
 =?us-ascii?Q?FSef9ww4IPTESk46XxRDWnHoEyfflax47a0JSW8KfGNHYbBKDEoKIKYU9ryj?=
 =?us-ascii?Q?QCgeU1NwiZVdE5pkglicvne158rd4BvIltEqbSvCeuqxv7wWjM4La/G2jaSa?=
 =?us-ascii?Q?7J88b5LGkVw3tLIF1kqr1z3KefcIH3dy3v3CW3Mn6KV4TkRg2dHzirFHVMD8?=
 =?us-ascii?Q?Z57HA0fyXlXY5sgRs8AghOUv3+BPjN9iTM8TILcYuON1JUnlFwPNSx/8Uo/H?=
 =?us-ascii?Q?thyaXj+L1brpVpqzfsBbC7ckF5NHiXiHha18KMOUzaGaUQVYZh6oHxBKnVko?=
 =?us-ascii?Q?Ksxx/2ipgyTCiVZeZsm+GboQRkdKmbudWAgIJAl0lOuCBu7jN/LoID821kkX?=
 =?us-ascii?Q?ApSpyLV0CwN2AUqry66ckL1VYHLhhslXSS9nLQqQZkeIMPOQivPp6TfOazM4?=
 =?us-ascii?Q?paASulRi1G6c95cmZOCydkYzUHizPlYxdeTtvfegsrJ5A6DcAUTrN9g/tlmX?=
 =?us-ascii?Q?gcKenSwt+ibYgX1lxq9jsU4iEFfxkdGsBLaC9BThzr7FMHcz2rIST3AhhtpE?=
 =?us-ascii?Q?H7gqK911+oFwnhSG6by0wQZStakhatJ6cEAou0Mry3XcN+t0qSFWJGBa6OH9?=
 =?us-ascii?Q?vSFq3nmBQy5qsvbT/6/BfyIbatxiBV6h2bw5jAg0XA7s8AhorJKWb1HlVJTH?=
 =?us-ascii?Q?Uj44ljyw1w4EQpU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7657.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?18RJI6DTXzvW1Tz6EVrmNbqJcwx3GQev6KmWFQHpheX8duYJfrVYrrHOduKO?=
 =?us-ascii?Q?3lk9oQGNPyR979fbuRvlniWx407YENe30vztn3tpj9g9wcW1xisLVS+dMG7q?=
 =?us-ascii?Q?qV25Zl4QBM/oDaww/5swzOA7sf+BRONJNba1180DhSSsdxcOZ62b/YlACwYr?=
 =?us-ascii?Q?WINan8w/eyUh3osBtqW/g3yJGTFEKHfbOyURqadhCv8cBAH71MFVITuHuM1v?=
 =?us-ascii?Q?D5upAK4P4jP2xkLKs2bBU6FFFKxEr8WMGBUcPRYjNzBo26qXk1B1QV56Z+Q7?=
 =?us-ascii?Q?zz2FhV5z5QH+r6TJ+4qXJjJHYE5V0YOSSxYBBTA4MBnrrMUmpXMVFqXX2TQS?=
 =?us-ascii?Q?vwL5BNkGJSFakcv+4r8ejfEN9zPpUxQ44tkZyPMbGA1j8j4rj8v5Jc7VJz31?=
 =?us-ascii?Q?VRfi9nDhTN/RPPQJ7LDC8ivoyGUnJvFo9wBzX6vaSx6bF/dIQ8OJZTf7EBHy?=
 =?us-ascii?Q?KFGW7CFD0p7OY7tyJkNMpZytiSWII1sWUgaHCqawJeTfNP7axdYPKe+dKUDC?=
 =?us-ascii?Q?xpkQFSY8bFTRUTfoc3Mpy7V46RE9tu1IqhByC7Imm/8LgwIiMJfSA+vlN5nq?=
 =?us-ascii?Q?R53k11eOaApduOF9lBqWFAQX0c5cgwD/aDvX6hc2uq5oT12h6Uk05VCWN3qn?=
 =?us-ascii?Q?egOfD6JEM2FMACjjDiYMZmhPgXsOksZNoSrOtLssF6ye5qsLhVsmB1v2M4qC?=
 =?us-ascii?Q?AuBhpCflf/wUOgaB6dBSve4yx0k/2Xcu0s9LCBIbPLfDHAKrk0G3BgIIZ6t2?=
 =?us-ascii?Q?ow0C3FXLIx1+0+/82XENnM8azD8lNBjVRLERIdtm0amEZs3D0VD6P+r96XJ5?=
 =?us-ascii?Q?oj3RoRD6HbkA+5FQ/pwnXKf12m46D25nLhsJyRQgYeKAsX4SXYA01yOjV5Xj?=
 =?us-ascii?Q?BC23Hln0L2r0KRpU3sPPVqjgnER9g7bhb7IeFpSSYdfsgOzTB/59To/UB0Gz?=
 =?us-ascii?Q?2pKSNeZnCZMQOubwyFLipJhSzts4ywb05fkHoPkZTfZ09kYApV87zwk8/iyd?=
 =?us-ascii?Q?7K4fSViJnIFWUI9oR1ocWVXFOp7Wz7zShhnEmQCkm8gc6EKKKQyhg3NMZuuf?=
 =?us-ascii?Q?xWZBIwN6y3QFSGa/83wBJnxySTRbLlrYt4T19j6pcY+Pnjo5fS7Ha10WGXkO?=
 =?us-ascii?Q?qx34imT8SygDSuwle7lrL8/t6CYh//tPtKEizzSjfjk8zKoXaeGbl74RMAP9?=
 =?us-ascii?Q?6rl789OT8zSUL1vCNfBNJoFqlcxpxlI9B0yj+e6ozpseaeoxVbT1ZkNStJ+4?=
 =?us-ascii?Q?oX82BLeeZmlSzidy694UM5rAxv0+wZ9Z5TrUGLfhH3V250hvXEnqkeyDF07I?=
 =?us-ascii?Q?kMywwIjJH3ZqaDyxO38wsqB11Vc4kQj2kovd7DRF9bMldQpYT0n+2NXPUKeg?=
 =?us-ascii?Q?xK9kPa+iNcktvtJei2GkdFsysGb9hqNGORdTxEJ+/FQx9QfEbB9Cz1sVwzu/?=
 =?us-ascii?Q?x++tS7JpHOL7uPUwiSu79SejqGZHGqiI9XPaAteuJtdjt+p0eQkysoqCVpVo?=
 =?us-ascii?Q?HjUgjMQ4jpsUtrMwkBkdKEghEexK76zxzlp16x/1+lpu6lm0VzIeJFLPLbZm?=
 =?us-ascii?Q?8SQUn978K+YtlVa0Sdo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5453c9f-36b1-4ab6-ca0b-08dd8c11af78
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 20:16:14.2471 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1/JwW1n+A0j5+w/IRbtpDlGroUjOE3HtM0vaotkTtzJrtw9+ZwnXxi9XadplMHz4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF000ACABD1
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

[AMD Official Use Only - AMD Internal Distribution Only]

Looks good.

Reviewed-by: Shravan Kumar Gande <Shravankumar.Gande@amd.com>

Thanks,
Shravan

-----Original Message-----
From: Pan, Ellen <Yunru.Pan@amd.com>
Sent: Tuesday, April 29, 2025 5:41 PM
To: amd-gfx@lists.freedesktop.org
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>; Rehman, Ahmad <Ahmad.Rehm=
an@amd.com>; Chan, Hing Pong <Jeffrey.Chan@amd.com>; Gande, Shravan kumar <=
Shravankumar.Gande@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.com>; Pan, Ellen=
 <Yunru.Pan@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Implement unrecoverable error message hand=
ling for VFs

This notification may arrive in VF mailbox while polling for response from =
another event.

This patches covers the following scenarios:

- If VF is already in RMA state, then do not attempt to contact the host.
  Host will ignore the VF after sending the notification.

- If the notification is detected during polling, then set the RMA status,
  and return error to caller.

- If the notification arrives by interrupt, then set the RMA status and
  queue a reset.  This reset will fail and VF will stop runtime services.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 ++++
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      | 17 +++++++++--
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      | 34 ++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h      |  1 +
 5 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index fe68ba9997ae..0e9ff74d6b6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6152,6 +6152,11 @@ static int amdgpu_device_asic_reset(struct amdgpu_de=
vice *adev,
        /* Actual ASIC resets if needed.*/
        /* Host driver will handle XGMI hive reset for SRIOV */
        if (amdgpu_sriov_vf(adev)) {
+
+               /* Bail out of reset early */
+               if (amdgpu_ras_is_rma(adev))
+                       return -ENODEV;
+
                if (amdgpu_ras_get_fed_status(adev) || amdgpu_virt_rcvd_ras=
_interrupt(adev)) {
                        dev_dbg(adev->dev, "Detected RAS error, wait for FL=
R completion\n");
                        amdgpu_ras_set_fed(adev, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_ai.c
index f2a74aa76b56..48101a34e049 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -324,6 +324,7 @@ static int xgpu_ai_mailbox_rcv_irq(struct amdgpu_device=
 *adev,
                                   struct amdgpu_iv_entry *entry)
 {
        enum idh_event event =3D xgpu_ai_mailbox_peek_msg(adev);
+       struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);

        switch (event) {
        case IDH_RAS_BAD_PAGES_NOTIFICATION:
@@ -331,12 +332,22 @@ static int xgpu_ai_mailbox_rcv_irq(struct amdgpu_devi=
ce *adev,
                if (amdgpu_sriov_runtime(adev))
                        schedule_work(&adev->virt.bad_pages_work);
                break;
+       case IDH_UNRECOV_ERR_NOTIFICATION:
+               xgpu_ai_mailbox_send_ack(adev);
+               ras->is_rma =3D true;
+               dev_err(adev->dev, "VF is in an unrecoverable state. Runtim=
e Services are halted.\n");
+               if (amdgpu_sriov_runtime(adev))
+                       WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset=
_domain,
+                                       &adev->virt.flr_work),
+                                       "Failed to queue work! at %s",
+                                       __func__);
+               break;
        case IDH_FLR_NOTIFICATION:
                if (amdgpu_sriov_runtime(adev))
                        WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset=
_domain,
-                                                               &adev->virt=
.flr_work),
-                                 "Failed to queue work! at %s",
-                                 __func__);
+                                               &adev->virt.flr_work),
+                                       "Failed to queue work! at %s",
+                                       __func__);
                break;
        case IDH_QUERY_ALIVE:
                xgpu_ai_mailbox_send_ack(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_ai.h
index efb452ad1700..874b9f8f9804 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
@@ -57,6 +57,7 @@ enum idh_event {
        IDH_RAS_ERROR_DETECTED,
        IDH_RAS_BAD_PAGES_READY =3D 15,
        IDH_RAS_BAD_PAGES_NOTIFICATION =3D 16,
+       IDH_UNRECOV_ERR_NOTIFICATION =3D 17,
        IDH_TEXT_MESSAGE =3D 255,
 };

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.c
index 74a50c0036ef..32ccb625025b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -67,6 +67,8 @@ static int xgpu_nv_mailbox_rcv_msg(struct amdgpu_device *=
adev,
        reg =3D RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW0);
        if (reg =3D=3D IDH_FAIL)
                r =3D -EINVAL;
+       if (reg =3D=3D IDH_UNRECOV_ERR_NOTIFICATION)
+               r =3D -ENODEV;
        else if (reg !=3D event)
                return -ENOENT;

@@ -103,6 +105,7 @@ static int xgpu_nv_poll_msg(struct amdgpu_device *adev,=
 enum idh_event event)  {
        int r;
        uint64_t timeout, now;
+       struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);

        now =3D (uint64_t)ktime_to_ms(ktime_get());
        timeout =3D now + NV_MAILBOX_POLL_MSG_TIMEDOUT; @@ -110,8 +113,16 @=
@ static int xgpu_nv_poll_msg(struct amdgpu_device *adev, enum idh_event ev=
ent)
        do {
                r =3D xgpu_nv_mailbox_rcv_msg(adev, event);
                if (!r) {
-                       dev_dbg(adev->dev, "rcv_msg 0x%x after %llu ms\n", =
event, NV_MAILBOX_POLL_MSG_TIMEDOUT - timeout + now);
+                       dev_dbg(adev->dev, "rcv_msg 0x%x after %llu ms\n",
+                                       event, NV_MAILBOX_POLL_MSG_TIMEDOUT=
 - timeout + now);
                        return 0;
+               } else if (r =3D=3D -ENODEV) {
+                       if (!amdgpu_ras_is_rma(adev)) {
+                               ras->is_rma =3D true;
+                               dev_err(adev->dev, "VF is in an unrecoverab=
le state. "
+                                               "Runtime Services are halte=
d.\n");
+                       }
+                       return r;
                }

                msleep(10);
@@ -166,6 +177,10 @@ static int xgpu_nv_send_access_requests_with_param(str=
uct amdgpu_device *adev,
        enum idh_event event =3D -1;

 send_request:
+
+       if (amdgpu_ras_is_rma(adev))
+               return -ENODEV;
+
        xgpu_nv_mailbox_trans_msg(adev, req, data1, data2, data3);

        switch (req) {
@@ -323,6 +338,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct=
 *work)  {
        struct amdgpu_virt *virt =3D container_of(work, struct amdgpu_virt,=
 flr_work);
        struct amdgpu_device *adev =3D container_of(virt, struct amdgpu_dev=
ice, virt);
+       struct amdgpu_reset_context reset_context =3D { 0 };

        amdgpu_virt_fini_data_exchange(adev);

@@ -333,8 +349,6 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct=
 *work)
                adev->gfx_timeout =3D=3D MAX_SCHEDULE_TIMEOUT ||
                adev->compute_timeout =3D=3D MAX_SCHEDULE_TIMEOUT ||
                adev->video_timeout =3D=3D MAX_SCHEDULE_TIMEOUT)) {
-               struct amdgpu_reset_context reset_context;
-               memset(&reset_context, 0, sizeof(reset_context));

                reset_context.method =3D AMD_RESET_METHOD_NONE;
                reset_context.reset_req_dev =3D adev;
@@ -380,6 +394,7 @@ static int xgpu_nv_mailbox_rcv_irq(struct amdgpu_device=
 *adev,
                                   struct amdgpu_iv_entry *entry)
 {
        enum idh_event event =3D xgpu_nv_mailbox_peek_msg(adev);
+       struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);

        switch (event) {
        case IDH_RAS_BAD_PAGES_NOTIFICATION:
@@ -387,6 +402,19 @@ static int xgpu_nv_mailbox_rcv_irq(struct amdgpu_devic=
e *adev,
                if (amdgpu_sriov_runtime(adev))
                        schedule_work(&adev->virt.bad_pages_work);
                break;
+       case IDH_UNRECOV_ERR_NOTIFICATION:
+               xgpu_nv_mailbox_send_ack(adev);
+               if (!amdgpu_ras_is_rma(adev)) {
+                       ras->is_rma =3D true;
+                       dev_err(adev->dev, "VF is in an unrecoverable state=
. Runtime Services are halted.\n");
+               }
+
+               if (amdgpu_sriov_runtime(adev))
+                       WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset=
_domain,
+                                               &adev->virt.flr_work),
+                                       "Failed to queue work! at %s",
+                                       __func__);
+               break;
        case IDH_FLR_NOTIFICATION:
                if (amdgpu_sriov_runtime(adev))
                        WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset=
_domain,
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.h
index 6d292a537c1b..5808689562cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -61,6 +61,7 @@ enum idh_event {
        IDH_RAS_CPER_DUMP_READY =3D 14,
        IDH_RAS_BAD_PAGES_READY =3D 15,
        IDH_RAS_BAD_PAGES_NOTIFICATION =3D 16,
+       IDH_UNRECOV_ERR_NOTIFICATION =3D 17,

        IDH_TEXT_MESSAGE =3D 255,
 };
--
2.34.1

