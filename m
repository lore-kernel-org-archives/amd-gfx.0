Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7A5C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 07:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0126910F257;
	Fri, 21 Aug 2026 07:23:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CBXV5LPl";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012010.outbound.protection.outlook.com
 [40.107.200.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C38D10F257
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 07:23:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yh1XhLPqrfLcoEhKwG/JfrWmhLfhiddsTK0K6VFtpYuLcaB61ArxsohhK+W85o5cp/A0pz5XlyPNcsDGqBTjMOKPX66YZfBL+RWbarB92kfp6xpfHHeYBvsXoAMfmQWcFyLKZtMMEJ09F2iByFD1+xVzgtrhTFVHQVkh27dk8nHPAmfzzs6pAQ/WieI8T3HPBmUlhMJU9ErQCBElR+VTkgv8D9KGjiD7GOkEo4HyFE8SMSdQKw0vG/r64rVhsxLlICNQx+RSg1JaZFO6ZW3hha5OOoafmOV3ieRdOJN+J815Q1K46Xa9kZnAn0UGbgfGVuNVz3KNJszXHMKCtdL1FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIK1jBg+2NBMo1Zcy+Nioi+JAwjGOXRyy30zeEmotxc=;
 b=MC+8BqZOa3GTPFsweMFLrxlMXEJC1lgEd3qDwUMEMGwj3fefxAJD1AW4cTIrYfvdKchpepbt1w/i1j2NaCBw6PyZksuAj8tkAigvv6AOUPHncnbATdqgU/K8UXJwlnS7JSo6eXXDOf24Kh8WAPZKp/7mMF76MAXJYlsPsfpsdRq0+heQGGUaPEALlvmL852ra0uX+S0JmgMl4bsuF6awTpk3IH6NKGYpdUODLzkMlzT30zujH70Ac9YUKpu1Zh8yzc3VVx4vSnK8q6PJQgdj34dE6MuU2bnGbxmqZ/r0vWQwYR9HP7LiFdnbO748/flVZrwBAPnk0gF7+HeKJR0BpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIK1jBg+2NBMo1Zcy+Nioi+JAwjGOXRyy30zeEmotxc=;
 b=CBXV5LPlkwxOSqPCjPuxuhm06R+Ol1n9zugEcoiZ6LQ5ReL9BHGlX21IcNl7zdraOJtfsxMYLTCjuG6naxvn29Dv0R5ADwVHVAPIA3FnQlZZ+Ug614AXW/W0A0NgS/6uPQd696SDuNb888zhfyWswvhSSoD5fJf7FFj+EA42fJY=
Received: from BYAPR12MB3192.namprd12.prod.outlook.com (2603:10b6:a03:139::14)
 by CH3PR12MB7715.namprd12.prod.outlook.com (2603:10b6:610:151::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 07:23:08 +0000
Received: from BYAPR12MB3192.namprd12.prod.outlook.com
 ([fe80::b4a2:3223:31a2:ab7a]) by BYAPR12MB3192.namprd12.prod.outlook.com
 ([fe80::b4a2:3223:31a2:ab7a%4]) with mapi id 15.21.0315.016; Fri, 21 Aug 2026
 07:23:08 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, 
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Liu,
 Xiang(Dean)" <Xiang.Liu@amd.com>
Subject: RE: [PATCH] drm/amd/ras: keep the established socket id layout on
 older parts
Thread-Topic: [PATCH] drm/amd/ras: keep the established socket id layout on
 older parts
Thread-Index: AQHdMR9jFyEDBjc/4kilUGgfos5oOraoGVww
Date: Fri, 21 Aug 2026 07:23:08 +0000
Message-ID: <BYAPR12MB3192CFDFACE171E46AB3C23EFCA32@BYAPR12MB3192.namprd12.prod.outlook.com>
References: <20260821034358.1487515-1-xiang.liu@amd.com>
In-Reply-To: <20260821034358.1487515-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-21T07:22:20.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3192:EE_|CH3PR12MB7715:EE_
x-ms-office365-filtering-correlation-id: 56ea5dac-7523-45cf-3a6a-08deff550c93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|38070700021|56012099006|10067099003|11063799006|6133799003;
x-microsoft-antispam-message-info: k9ToNrKXSgLu/j4b2iSRhltQAXP0TRpG3M6U8mVybqjO7JEpkDDED4PKX1F2naVNf+n09Cc1qhz2QMEkDSzbKBVRq/XGS9+4w3C6Mytbd2cAE9DQTdsSJZoWxSKiBk+/xeMXbhyhA567f+fMHxTOf0yOf3mHFnSY0EV4xjCAyAYiy9JrOjigrJdzYRI39usoG+kOYPU4QaCLnS6yLDAHbvN9C67LEXTd5B5y5A5kD9XTPvUdYuEpFL2Ajsyhm44SKkNfxmvPgXsuawhOkHgRKq3Ex39LvWvQTQ1w7Zb8PbWPhGCjwDzL3oD1D6r4p7i2ibkZ6X+zgjBAzBObPwQA81C2JGD5z7VWkQBjq/LokOykJiQipgTOe6gPeeWVPvN9HlIJU2uS+rMMic2OhYLv5Gn3PdqGkb7bP9LqAO1xkA9aKTXaw93xdCgoXi9NKFdnT+h5nHsp20Cn3IOTzeLG39RS7KCQ6TDml6lb6h9PKrOVM+uMVzd8MGYaVHz7UpnvYwyz6i6TbRQt6ZuTAzEZONDoPLe5NNSN2W1XPUQCni2SLO3CfTVijDKTBu0ofw2JdnDfE1SgFoY9Bq7OygBRmTct4f7VkRzB6hORcfZ/35Nxpo/4QmJXkl84XvZjSDJL8cgmY9opJPpky4Ji5gPABum6/QpjaW0U2I/JGNzDb9gtKpCC3n60SwbYlsByyeclkelO+VC7oQKz/ZIeLb/Crx0XT2pPuPAnHU6m053sdpo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(38070700021)(56012099006)(10067099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TU4jMpYQeeARPpbN1zc7OMC4deJqmYoNyUWAf+yYbnmglSbT4YmBzxWJgkB8?=
 =?us-ascii?Q?FYERgdwf92doDyciVkyAIC/fl1nJl6XVr2WfIJrCVkwvNoBLgy57wGuAiefU?=
 =?us-ascii?Q?ozn5MVlnkx0MsWgDBqnOPD9rd5ZhM5ei5004Z7uUzmygPGg86KnZ9cipPBuW?=
 =?us-ascii?Q?krI7wukrudZ5afrXB+QtFo4B8unQXSIgev7TPBVE8N0GBVuKqPmOzHa2N4eV?=
 =?us-ascii?Q?vXSrmuxvlWOL8LoV2b79XhTo1FBrcNATTgF80EgZ0U4VCb+TCr5K+bsm+vHb?=
 =?us-ascii?Q?gp1DLhhhvVLlkP87YXpgkCfSbg2B5aAdUY7pCO+F7qNpg5zNZNfpNYQguiJ2?=
 =?us-ascii?Q?FSqjD77MXEmWF0H8mQDc6z4uxcFBoB/VwxvBQcUZ8FYeviXT5Zn0Pr5lyOE4?=
 =?us-ascii?Q?uHwxNDnZTsHbKXQN1XjE4TPtirK/JKa08nSoyE/PMB0k7/RKhioJ5AZmDNaM?=
 =?us-ascii?Q?QMTuwJz85ZBY6McuGlsHZqkMAVc+lUwFpfYgxttjglcH8VT42HQsu0bwtvW9?=
 =?us-ascii?Q?6HcpcOznk/t95T9oJ7vHJOZBqPrOuF0ww+J7NI8it9Rpg1DUHPiDU1I8mcxf?=
 =?us-ascii?Q?W0/6w4v7GYq/DnvtuZern7AuajRufeQRTTr8UxYG1lQt9kXQa2oBDei7NGKv?=
 =?us-ascii?Q?t9yoDPpjngGA7QqBUqk0g5q+JPAbfP0/ZJMxAGKrglUYIp12iq7O54WAsl3p?=
 =?us-ascii?Q?qfTs2XGxRunriwJRgdPQtTIA6vnJArVZ2jR6D2ySYh+P19FKEvI4BgckyP4a?=
 =?us-ascii?Q?04EjqBKS79t+6cUUqeUOWfz+z8SAcTt4/TJnVNi2/OcsdD7h+qnqH6TCqmSA?=
 =?us-ascii?Q?t5o6LjYnhMKXeMsp4bl4CQz/gOgLKq+eHVmZDcdnVoaetAjvHS7LAbazRhO0?=
 =?us-ascii?Q?IkdkadKOK/RDLrFHJU8j0GJ8etxnKzHLcqBPjvR3wI3B5ntuJ3pB/uPPEQyg?=
 =?us-ascii?Q?BD1BNcgAZATZC9/fMGpx97bL6andQtIqJH04U1W6nXgnBCCQZPKe+AEAr/tN?=
 =?us-ascii?Q?DcjqxN/SqGJkYzYJ2ZAWgR87zy8HVkkao7XriCmCAWrMjpivDc+rlOH7K4DG?=
 =?us-ascii?Q?T3Hw4UQmgKl+bgW9ltoacdXoq+0/2jjWlSdXRHnx89ET9CgEDtVneHtl8FkE?=
 =?us-ascii?Q?sUQtQN1h+Y8i4P91IBroNFrQQpy2YuUstVLeZ6MnlYbJGe4ssg+1tYUO+gdN?=
 =?us-ascii?Q?NQsBmYdOXGjzm1m+hzAKVGOHPm2qC5D4xD5MLM8csUfuDqgFdneTzKBynJNg?=
 =?us-ascii?Q?WetLjCyxS3SeGBbZbo42CY07dUzW0vFgaEhFcnC3bdiH0kvuMU6c5SZZf6iu?=
 =?us-ascii?Q?V0LH46i5MlIqcE2ZTW9ygy9bzVWcJaD1jw8PUJEHxFg91KSp6V9GhQJNS53/?=
 =?us-ascii?Q?o1FSImhOTwB3gQJ8XKhhwgrL8exbAeifzWJ/8MRwlGB3w2ottLPja3gQRGzH?=
 =?us-ascii?Q?e6tGwvYv/XI6D7D0RcguItOAYh39sxggfke+kyp/hhMlkTlqDFYgS42U1QTT?=
 =?us-ascii?Q?CWCyJln0HBeDUX4y3cHm6pbZPSnwP/PyPwP1eMlHpELhyDR1/7P/JhUxEagK?=
 =?us-ascii?Q?EQI6tsVkl+ChJNkoAWuUak6BNczh3RuUzFtnl0mkcOzvbu1G96SBr+f65R5B?=
 =?us-ascii?Q?UHxdN+ahVKMaKLoG6sre0S2M9NO7D4jR/ter11yspb9/wDWsFLsj1RYaQry0?=
 =?us-ascii?Q?SXh+XOABBTbWcW/7rdsQ/h1zuBboReiR7PLpNaDdl4D5RNEo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ea5dac-7523-45cf-3a6a-08deff550c93
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 07:23:08.1134 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 31MHLF7AkLNWluNcgtvoRIvfixO+WrE4zJkcwXkyCrpIxafvCQS+uEdDD9NrJkJEmPLCiqeRWs9YBibdsmfuGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7715
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

AMD General

Please update the inline comments when you commit the patch. Thank you

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Xiang Li=
u
Sent: Friday, August 21, 2026 11:44 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; =
Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH] drm/amd/ras: keep the established socket id layout on olde=
r parts

The socket id is exported through the ras "features" sysfs node in bits[31:=
29] of a 32 bit mask, but the RAS capability mask is 64 bit and reports it =
in bits[62:60]. Tools parsing the node into a 32 bit variable read block ca=
pability bits instead, which are identical across a hive, so XGMI injection=
 resolves every WAFL sub block to the first device and the RAS TA rejects i=
t with RAS_TA_STATUS__ERROR_PCS_STATE_HANG.

Keep building the 32 bit layout from the same capability mask on parts rele=
ased before the 64 bit one, and stop assigning the multi bit
adev->ras_enabled to the single bit en field.

Fixes: 6ae383bdf282 ("drm/amdgpu: Support obtaining ras capabilities")
Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index d168e5d54d87..34de9daa6124 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -5065,16 +5065,27 @@ uint64_t amdgpu_uniras_get_ras_caps(struct amdgpu_d=
evice *adev)
        struct ras_cmd_get_ras_cap_req req =3D {0};
        struct ras_cmd_get_ras_cap_rsp rsp =3D {0};
        union ras_feature feature =3D {0};
+       u32 socket_id =3D 0;

        if (amdgpu_ras_mgr_handle_ras_cmd(adev, RAS_CMD__GET_RAS_CAP,
                        &req, sizeof(struct ras_cmd_get_ras_cap_req),
                        &rsp, sizeof(struct ras_cmd_get_ras_cap_rsp)))
                return 0;

-       feature.block_mask =3D rsp.ras_block_mask;
-       feature.en =3D adev->ras_enabled;
        if (adev->smuio.funcs && adev->smuio.funcs->get_socket_id)
-               feature.tag =3D adev->smuio.funcs->get_socket_id(adev);
+               socket_id =3D adev->smuio.funcs->get_socket_id(adev);
+
+       /* The wide layout spends bits[55:0] on block bits and so relocates=
 the
+        * socket id. Older parts have to keep the 32 bit one every tool in=
 the
+        * field parses today, socket id in bits[31:29] included.
+        */
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(12, 1, 0))
+               return AMDGPU_RAS_GET_FEATURES(lower_32_bits(rsp.ras_block_=
mask)) |
+                      (socket_id << AMDGPU_RAS_FEATURES_SOCKETID_SHIFT);
+
+       feature.block_mask =3D rsp.ras_block_mask;
+       feature.en =3D !!adev->ras_enabled;
+       feature.tag =3D socket_id;

        return feature.value;
 }
--
2.34.1

