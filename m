Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92352C19776
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 07:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7B2B10E874;
	Wed, 26 Feb 2025 07:59:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WgYwBL9V";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9C0410E872
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 07:59:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZ0XUk+ofBbyZ7jKpRhaTlM+ezn8sBxUVbvXpsgMn5xqtP9s/j9mWzVy2OHbDP8aaN8JWSR0aMrvUau30o2Q9r7fSqyD7ocDMkj6vYV1STovzYF4KenQvEF/XkUl/WWfEoX0I40r2NLZ2aQfBNwd7JTvROuI7ghJ9zUsS3SD0MuweelKOWqp/Dt/VJz8DsRKF6PK9JU2/Xbd+lfgFDKNxNuu6wyVJ7FAmeQCR8NVH1Z6dlHsVFw1BgKpOqa9ZbI7VRKt+oQ8laedc01XRbB5mlfe4q2FP7EncrRfTE66XUUy8Bnj7vKYeAsPiM1mH9pV1v8mRwTdgIgti7OAZyJbVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAZLRZA+OA9uSY+v4DkCIG2tGucIOQk+lceIF0a6ZP0=;
 b=w+WMYuz2NZF+uowM42AGCEnzlRG/YsE91QQMY/kdC4+cs2fuHo0v2Oe/rkN89YLbdLm4DmGJiNoRT4uJoqEWJK5+omKCZoiOJkMX1raZSa/iKbkA+SvMdi8f+YwHcy31Xoyr27taY/C7n0UH2rDcGBy0PrmYEKrILJQCF/OTAoMr4hdwqPDYSPCGxFPMSBgcNsx9tTsZ9D4AFsyUsw8w8KjPwJVdD9nps/aKy05cRMxdd2neS1nbkFbIJk5s485OhsShjdMk5Y6D4/SoHgzJbUhRDDtYWwgR4RvIT37HuXfMaS8r7oViCc9/m1ouf5uYsD0ljDWj2/T034Jp7YHvtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAZLRZA+OA9uSY+v4DkCIG2tGucIOQk+lceIF0a6ZP0=;
 b=WgYwBL9V8VcdaONHQhRu3uzLVyf3MnpDx1Xh6ubnkyHaPolLgT2w+rOLZ6pWoh2Kd1ilMz2SLnTX1/h9ilk5VN/eJ+g1VMVqrKCfgQX0y2FYcryuruTmpL7lW1Bmhgh0cVMxUhmmfvoxRcAKWzN4ePw92DLLWYpPJZd5UtKNqAE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 07:59:16 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 07:59:16 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Decode deferred error type in aca bank parser
Thread-Topic: [PATCH] drm/amdgpu: Decode deferred error type in aca bank parser
Thread-Index: AQHbiCL/s1NSMQ0XE0Oe7Po2hRTGzbNZOE1Q
Date: Wed, 26 Feb 2025 07:59:16 +0000
Message-ID: <BN9PR12MB525722FCA1395560708D73CAFCC22@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250226074913.59576-1-xiang.liu@amd.com>
In-Reply-To: <20250226074913.59576-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=0b1a62d3-d052-4673-bb5d-d68966e12226;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-26T07:58:57Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BY5PR12MB4305:EE_
x-ms-office365-filtering-correlation-id: 4ae653f3-3e5b-47f2-0269-08dd563b776c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?b3UAkx5PST3gcP+qtSRDXW7ctosu35S1GJOIiMUm+u7VeM44Wub6JF7Vmg+F?=
 =?us-ascii?Q?AHw4Tl2vTCXy+AKqShIeNTE1Us6Yb3CWvqtiuvYUhinSpd8ccOY+CXDjrTP+?=
 =?us-ascii?Q?FECzk2vw9nLgP5m3pyFfqBMYcxbgIoqNF+Liu9njdc/kdyGPI9LZMkpMC20R?=
 =?us-ascii?Q?B4YEmWuvFqsWKd3+syynu1suV4PRl+ubOzoM5wP9n9bdtpizYRWNP5nuMSLQ?=
 =?us-ascii?Q?svlQSJhQLHcuN5mWIgmoY41vNMttjMHEU8kEbzkODXF5p9iXw2AwYu6HXUe4?=
 =?us-ascii?Q?jIwO2D/wHKzm/OnLAceCfFe0ePnOKeWTrACyeVg/M3iotMsdc3J1i/QML0aa?=
 =?us-ascii?Q?MkJe3gBRPOQONy7mSq+DHaTdqbqqyU6oU4oCzhyf0bmnRJslfZyREYQInRhH?=
 =?us-ascii?Q?OEh0xG3qfPO6fkSwH5UDm/VcCDFa+uQMKdc8rPwt4Z0Wg2nxZBN2SHMZaU/q?=
 =?us-ascii?Q?lmVLrF5glZcGjkt06rdLHirvzSDPXtPqNDp4Ek80A90ftsoAEoybRsF9IWmx?=
 =?us-ascii?Q?YiHh7Lx0rUSvbyBwO9afa5GDuY+WBLX9qFxvjLYDnIxnpE7qYu9CDJscjeJQ?=
 =?us-ascii?Q?c77yicOh6UbF0uJQr9HHYB2Ig2V+BagMhBJu6Zlvbn70F5LM3U3vHqf6CbTw?=
 =?us-ascii?Q?0KE2iI7rHGvz0yynW5xCt50f0/A0v6woBfWuudFWqnJruZ/SjwEJtJ7ti0Dk?=
 =?us-ascii?Q?q4LXH+rl9MiCoKfNTS4Sjgt8EoPdYvYw6bzVBdLeSjSW6ZSEvtGFod9Jb/Kd?=
 =?us-ascii?Q?N2Aj6R1QTewp8qXGDo8Fbxp7DTzquDB3tzk3co1oLRtyJpySuMnw0MhVxaeb?=
 =?us-ascii?Q?xPyjorVljZGz3ADpp3kyEDKY4bmPf8krRIFOszfI1je81sxpQMhH9qetT0m2?=
 =?us-ascii?Q?SdNd9OMfJU5gUMa2PcWHoysHEMkxXSHtDUZFCGTsbmaalp/nXPjt1oPs2nh8?=
 =?us-ascii?Q?DZNaq9p0VKjvTCtaOXfL2QdinqUtNHATChXoJucn9MVkC/Z/WWvcWYUhWJ0z?=
 =?us-ascii?Q?1eqhrGHPTTQDdiPzEKW6GUqxGtEn3/PSEjC8Kej0NCW/GMPUirdrF3zh6bis?=
 =?us-ascii?Q?2AmaLp9kwl9+RFk2cDHoG77hLG9mdeUOywQsR8XE82Dywjaqv5NM/Q0Nca4f?=
 =?us-ascii?Q?r95GWy2qMtUW829hrXIzvE3hNB4pF4C830+oP1suKOpGuH+/6iKRx3mvUjhO?=
 =?us-ascii?Q?UiVaokH4Ot+cunpb4JQyltZcKUHJO25Z5he3zEvAN7G7wKi0Sh9TYH0NGS0h?=
 =?us-ascii?Q?Y+rTFhC/GCdtDKqOBi8V1pUSD1X9TeEiaYUjrNd/IBpIN5wnzQX52ocf43jX?=
 =?us-ascii?Q?gK5flLr1iEj8GcFbZIHL59Bm8I8BXrrjHSNNXnteWXU1BCtIBLFQM2vGIlcF?=
 =?us-ascii?Q?fkVJ3NHbXrayaxdmBlmc1eHsT4cCpwvpaJaVpZm6obsCYAQ+lmNiFO1Mzalb?=
 =?us-ascii?Q?49ZUxx1IvL731HqXLDUkH3R/dV9z6imC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JqVmE/qqKj3peHWNQgdNR4e6z8IKRbl0O06/QD8Cx8wDZaaFQcbMQ5iskE10?=
 =?us-ascii?Q?pxHT5B6lD3Lf0neGoe32r3uybNrMbL8YEKxtsV6oJ4QFhS6lwcf5yC3iK+dT?=
 =?us-ascii?Q?YA2iRdamZLOCXDEQOHos3LpYTLWajKFJ6synQaXroM0B+CI/PaumFPZcS8gx?=
 =?us-ascii?Q?XK4s9lXqQ0LHKU4RA1E/+DUBJ1u9PlTbjBOK7HAkjILCu2X6+u0gkJ9PczvF?=
 =?us-ascii?Q?L1mnEEr0xd6ODkdmW6AtxOvpbrdKNsj8NXhh+KCdcepocx8HvDHrMNyjus3y?=
 =?us-ascii?Q?qDyjCsPlt66Umc3z1Sw8L9QW+jBUl4kTll7O1BmKtoyM0FAP/WA8p+v/i3Z3?=
 =?us-ascii?Q?pTy+GlHafsFr2aXvI6a50dY/ZOHGEB4hbfrk/Pc853Cwv4pmNDdSauBlszYW?=
 =?us-ascii?Q?818kNCVoSvqrmuxj0+8yBdQV74vZd8eTabzDtMiQm5vuz7GT1nTmPPgn4LYw?=
 =?us-ascii?Q?mJOlxKH2E1dFCz3mecJV0Y1V4tqYjfelRZTY8E4MlhZr4h2oaNMsuswZZG2j?=
 =?us-ascii?Q?uG7x7dmy2Ep6jswMgAh26OwU/dVSyhJ0Pn8SPI+MaPoShmmhgoDXlJ8Xi13f?=
 =?us-ascii?Q?RR+zj42ultDIuC+MjW3ttzn474JJxO4fY7N8bA72Qq0Pd/XM+Ez/+s59Xt7/?=
 =?us-ascii?Q?PObWViqcD/ykJHwsHeAiZt09uORh0Muw7zPj6MM1GF/Ke2HayMde20+FQeYh?=
 =?us-ascii?Q?edm2xOZAdJLa0cKEWRFdKxRr+EskXrTA07bl3rxa/ntLgEgl0U7iLjWjsjaJ?=
 =?us-ascii?Q?mxGvWWAjgxkPmIrBjoM4m17rbIpILCGRptFvnYsWij8kP48/Pola1L/zy3PY?=
 =?us-ascii?Q?iU3wVHjdjqSj1Bx0vp1OO8JTWG9lun0lP4NbbOavrbEthQAVtX89H0BiX1Ax?=
 =?us-ascii?Q?wDom1+q+rSHbUM8vLXGk8B6UkZkv1hw+7J7YlHX2v1/5EJu7iACRLuLwx5YG?=
 =?us-ascii?Q?PkqU/fiTPc4wnBx282CQi2J7hZoRHruy57cQqPvBhZI5GVE28MyeR5GtGJ+g?=
 =?us-ascii?Q?JVLib9AWR3Rn0NJgWHjj8Ygz7OAMHEtS1Lny4I+8YYVtJpU+JXvWTZBDDPEQ?=
 =?us-ascii?Q?xQswpW2cYHR1c5rx/l0RRKDP4kX7hXtT1sJkbg6JnZ7Iz0Ar+flDXA70VC1U?=
 =?us-ascii?Q?VJAgF2CBb7rbKu4m/s01Z83VtRDGU9tu+dmNt6yFr/wTfoeLxXn7QeliIvCx?=
 =?us-ascii?Q?jkeQPNHIJnss37DQHEEXR5qaGzTIpNtqbaURt5BLLwQ1fQ/yLTW9StrN+u2D?=
 =?us-ascii?Q?j+kz5m3FUZsvP9H81AE6aLAS+WXKqFn9eDagIldjXIW7LIGcUXPY26M1bISh?=
 =?us-ascii?Q?0qKiARSij1ypJbv0XHqaDFhd1Wfjcj4SXseTuMPHYrkCsi6s/hP/MJfkhMgd?=
 =?us-ascii?Q?XJ71vsODaP/OYM+kiGjLsXSH70gYGk3e8A985N2xKrSNJ9JhdkQ3avbddJ4z?=
 =?us-ascii?Q?83lgSzb5s+wCjJuSYphFDv7PJ9MBQvD/z0mFHEFlV0nlwD2gOCmaBudwn7Vb?=
 =?us-ascii?Q?PMypChqA+PqwNp/ID1NK9n5lbfajtxcrf6xhVZ6AiOLI6empB37fUkK44D9i?=
 =?us-ascii?Q?/hT2rxCjlieXTzqOU8Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae653f3-3e5b-47f2-0269-08dd563b776c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 07:59:16.2891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V9ShwdW10pmVNs9Ib9ybG/oW5FqZoJI3PLUV9uYviLKHwwsBIPZ1sWiQhdMrQysl/OUtqMAlASmm6YG+NubwXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Wednesday, February 26, 2025 15:49
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Decode deferred error type in aca bank parser

In the case of poison inband log, the error type need to be specified by ch=
ecking the deferred or poison bit of status register.

v2: check both deferred and poison bit

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h  | 6 ++++++  drivers/gpu/drm/amd/a=
mdgpu/amdgpu_xgmi.c | 4 ++--  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 5 =
+++--  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 4 ++--  drivers/gpu/drm/a=
md/amdgpu/mmhub_v1_8.c  | 4 ++--  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c =
| 4 ++--  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 4 ++--
 7 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.h
index b84a3489b116..6f62e5d80ed6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -76,6 +76,12 @@ struct ras_query_context;
 #define mmSMNAID_XCD1_MCA_SMU          0x38430400      /* SMN AID XCD1 */
 #define mmSMNXCD_XCD0_MCA_SMU          0x40430400      /* SMN XCD XCD0 */

+#define ACA_BANK_ERR_CE_DE_DECODE(bank)                                  \
+       ((ACA_REG__STATUS__POISON((bank)->regs[ACA_REG_IDX_STATUS]) ||   \
+         ACA_REG__STATUS__DEFERRED((bank)->regs[ACA_REG_IDX_STATUS])) ? \
+               ACA_ERROR_TYPE_DEFERRED :                                \
+               ACA_ERROR_TYPE_CE)
+
 enum aca_reg_idx {
        ACA_REG_IDX_CTL                 =3D 0,
        ACA_REG_IDX_STATUS              =3D 1,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 49da137d42c9..c313c2cf6969 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1169,8 +1169,8 @@ static int xgmi_v6_4_0_aca_bank_parser(struct aca_han=
dle *handle, struct aca_ban
                break;
        case ACA_SMU_TYPE_CE:
                count =3D ext_error_code =3D=3D 6 ? count : 0ULL;
-               bank->aca_err_type =3D ACA_ERROR_TYPE_CE;
-               ret =3D aca_error_cache_log_bank_error(handle, &info, ACA_E=
RROR_TYPE_CE, count);
+               bank->aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);
+               ret =3D aca_error_cache_log_bank_error(handle, &info,
+bank->aca_err_type, count);
                break;
        default:
                return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 50eb856249d5..87add6274b98 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -883,9 +883,10 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handl=
e *handle,
                                                     ACA_ERROR_TYPE_UE, 1UL=
L);
                break;
        case ACA_SMU_TYPE_CE:
-               bank->aca_err_type =3D ACA_ERROR_TYPE_CE;
+               bank->aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);
                ret =3D aca_error_cache_log_bank_error(handle, &info,
-                                                    ACA_ERROR_TYPE_CE, ACA=
_REG__MISC0__ERRCNT(misc0));
+                                                    bank->aca_err_type,
+                                                    ACA_REG__MISC0__ERRCNT=
(misc0));
                break;
        default:
                return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v4_0_3.c
index b8f06e9c9e62..1fcab0ef21c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1332,8 +1332,8 @@ static int jpeg_v4_0_3_aca_bank_parser(struct aca_han=
dle *handle, struct aca_ban
                                                     1ULL);
                break;
        case ACA_SMU_TYPE_CE:
-               bank->aca_err_type =3D ACA_ERROR_TYPE_CE;
-               ret =3D aca_error_cache_log_bank_error(handle, &info, ACA_E=
RROR_TYPE_CE,
+               bank->aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);
+               ret =3D aca_error_cache_log_bank_error(handle, &info,
+bank->aca_err_type,
                                                     ACA_REG__MISC0__ERRCNT=
(misc0));
                break;
        default:
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_8.c
index 58d22f0d5a68..a54e7b929295 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -751,8 +751,8 @@ static int mmhub_v1_8_aca_bank_parser(struct aca_handle=
 *handle, struct aca_bank
                                                     1ULL);
                break;
        case ACA_SMU_TYPE_CE:
-               bank->aca_err_type =3D ACA_ERROR_TYPE_CE;
-               ret =3D aca_error_cache_log_bank_error(handle, &info, ACA_E=
RROR_TYPE_CE,
+               bank->aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);
+               ret =3D aca_error_cache_log_bank_error(handle, &info,
+bank->aca_err_type,
                                                     ACA_REG__MISC0__ERRCNT=
(misc0));
                break;
        default:
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index ba43c8f46f45..5636f473c3d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2529,8 +2529,8 @@ static int sdma_v4_4_2_aca_bank_parser(struct aca_han=
dle *handle, struct aca_ban
                                                     1ULL);
                break;
        case ACA_SMU_TYPE_CE:
-               bank->aca_err_type =3D ACA_ERROR_TYPE_CE;
-               ret =3D aca_error_cache_log_bank_error(handle, &info, ACA_E=
RROR_TYPE_CE,
+               bank->aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);
+               ret =3D aca_error_cache_log_bank_error(handle, &info,
+bank->aca_err_type,
                                                     ACA_REG__MISC0__ERRCNT=
(misc0));
                break;
        default:
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0_3.c
index 2681c40704a1..20f6bd9255db 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1963,8 +1963,8 @@ static int vcn_v4_0_3_aca_bank_parser(struct aca_hand=
le *handle, struct aca_bank
                                                     1ULL);
                break;
        case ACA_SMU_TYPE_CE:
-               bank->aca_err_type =3D ACA_ERROR_TYPE_CE;
-               ret =3D aca_error_cache_log_bank_error(handle, &info, ACA_E=
RROR_TYPE_CE,
+               bank->aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);
+               ret =3D aca_error_cache_log_bank_error(handle, &info,
+bank->aca_err_type,
                                                     ACA_REG__MISC0__ERRCNT=
(misc0));
                break;
        default:
--
2.34.1

