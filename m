Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBBF1073CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 13:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A58B10E661;
	Wed,  8 Apr 2026 13:36:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LZI05xZO";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012050.outbound.protection.outlook.com
 [40.107.200.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDE2510E65F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 13:36:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LeFEzlSHeRFhdHuSnw+iPSZpbHu/sM+A398YLPqEJG3OZc37hG3piw9udZsJQHWc65z8tauRlmiorh4tSL8+xXgdve6yetzfjWk9FNUyYxgw7vSiHa8LzjjaC0gM31iSqyEQ65xQ6ZUNxjRCtUgGL4Al+vw/hZZYHV6Zy5bMjDSAwrQ6LcJPbiet5J/JnrAIFdqODi0SQ6K4SilM/zIxbMNtoqU6bPSmURQLITnyRA9dEaE0GcOGgNg49P0KbYNRS7pWzOlkWvESI30ofTZNdKqZGvyjONvrjBkO3+vKPF+wA4BTwzOK9r7e7SZRVhA2CNNPz9VECNtBULZzNTNE9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3m/K8KqdJ+llfvqqR4rmFoM6g2GdI51P+sAyV5g3oE4=;
 b=lY1iruJxf48kywI5lkqPvjKq0LTdGfQHtSLI+ZebfvMbZ/nTQ3QN149eTO9eUEsa9gXV5bXd/HI130ZKFKLxEkDrTlPziVp5WTo8etXtORY53n+NpJ6MMGdS3skirSn3Az4qzQoMRR9zGURo8WgVLnPilbILEHX9S03ibiPXgsc2+pYy2hGuD2ZH3igda8iw++OIbNdzH87gJecrgScdw3ImdIvVJTgeopY5A2A3x8t0xcuWOne11g27NgbL69zxpOc6Hyn4icu8GRytRUCmD82ddxtKSztgj8p5v6waCz9hgysa05KCDtnj2K9Fui6N+nhOqKLb9NF2mCSVN8KQ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3m/K8KqdJ+llfvqqR4rmFoM6g2GdI51P+sAyV5g3oE4=;
 b=LZI05xZOiaItALMUVxHsUCJNkJ36cJI/ug4rzTDH7sZLsLvnbSX9LKOZ7EtAC2KzfOwCir+00Ip/flkKJFRW+UkcGkZZvTX4x5BOj3ZC/lQcIj/qKn4sFIxitB4IwwLKFOptgvzTrvYSfuqzyVP5sqTp96EcHmqf/ZJg6mY74OU=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Wed, 8 Apr
 2026 13:36:31 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::2201:99d6:c63e:3d2a]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::2201:99d6:c63e:3d2a%4]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 13:36:31 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Cheng, Benjamin" <Benjamin.Cheng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Liu, Leo" <Leo.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wu, David" <David.Wu3@amd.com>, "Cheng, Benjamin" <Benjamin.Cheng@amd.com>
Subject: RE: [PATCH v3 1/3] drm/amdgpu/vcn: Move RDECODE_* to amdgpu_vcn.h
Thread-Topic: [PATCH v3 1/3] drm/amdgpu/vcn: Move RDECODE_* to amdgpu_vcn.h
Thread-Index: AQHcx1bgtZaFrboH3kK4cYfG5fAOkbXVKrXw
Date: Wed, 8 Apr 2026 13:36:31 +0000
Message-ID: <SJ1PR12MB6194EC1B80876F02C5971A56955BA@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20260408125426.2118644-1-benjamin.cheng@amd.com>
In-Reply-To: <20260408125426.2118644-1-benjamin.cheng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-08T13:36:24.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|DM6PR12MB4234:EE_
x-ms-office365-filtering-correlation-id: cf762091-7350-4a04-0bc5-08de9573d805
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: Y/u/4hz/bDPlzXuo7hCzAGW4LUtr3Wc3X3Kn+kEoVKqtnmbQp7E7i35G4ywELfVoZ9uGyZSExbtrKvKiEXR6x5oXad7jv1Lz81tMCPDzRdccbNQ9TI1rEtLS/zMXIeIkQFCY/pEGExrxeoh9H5rof7G6p9rrv4YJAX90UbbsWrgPEu6mFiKvXiZvtPtuEqmPOQULhIlWxIFdkrygJjTaBHFXtA/AAGpQegioAclP9+AfYBhFzQmDIAB58jAJY+jZFwNDB9VbeLay2mmAZAzNR0VNqEZIpcCS19yxI7Ld7TbNx2//X31jvfYUWNjp9sw1SU5dYZjJcKcSvWkKw+zuYFnHCWpJ1xzYiaQRTON2hVZBfwEokUjVhPARsSKNI6wuJ7lXi7EBBTAPwHxPRkG2vSQofl830cEpgt4+wo7fWIs0jeTY55RuGVtdZf+v8KmMoCVIbY0W2B0Dn/5hm2topTw7PQr3TuyJeuCBmppEh2WJoUD4H6a0BdH+XY3XRWj85ZczwjFxobb5NWpQm7grRXmodQnfleavcrnX487A7FKk9BudEFsQkBzbAFzuRPuS10rZeqsHwKBe7PfcpvxWeDJqqVP/28wIYH0Gxlv7mp80Ys3q9cLEwq9GPIscar4wWaGXhq3n/n/QPT0uhvsKM8GL248OqRL9Kq9jGpwGHF0OGfl9B1V+OHz40HAss8newLztZ8cKP3V/J/ZnaZvvFzrSCD8WFWvrNT3x27i9Fm4aSRvDlSlaAEg0+J+Kb7wEx4DKw3BzmvZnALc0ypOIbcY1G39rIs1tXl3O+CTURjM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AmkMuM+zV0ZV76cDtQSUjoq21LP9zNLigwWLFLLfVadlocdde2n1q8311SCT?=
 =?us-ascii?Q?EnD276EOMc3ijfp/F4UZ2Lezl+bSXk24330Gy5ShOfXQHRfMrN+brjDlQsMc?=
 =?us-ascii?Q?GxzSNZvRT8EkNPCcTcfOwdl4UY729RIhFMvODimIU1sJ4wepnntuW61wT0B5?=
 =?us-ascii?Q?HVI9jzUaHVWNSydtjIYM2WXE4qJl/Zou2SqfNFHYRwXehN4V5qiUwyW9Nv78?=
 =?us-ascii?Q?VfNPlKgOl/lhHzCYGvEHWZqQ0TvBvlS7tptSu813ARy7kXgn8TkEt4bbVW4P?=
 =?us-ascii?Q?QJqpim0jRGWZtyZ78eCUM/xm48E2zWW+mGwyFFhhCpPQ/SSA9/SzNC1205jp?=
 =?us-ascii?Q?6Z3XhLpfI9iDHCqeCxzKB3UXch64dBgV82a7pADBN9NluEf1QXLbPevQcwEK?=
 =?us-ascii?Q?1VnHH7edbmkHHFLgsEwLsISo0kb9IfwYICdQkHTR2CRC+MqeNo6QMgp26RYi?=
 =?us-ascii?Q?Ezw5DEcuUrOGqPLLwsykpQEyZpBkKo/Wfli/MMg/9uSkjYpZTvTTCynMKGuh?=
 =?us-ascii?Q?3tRxcrUCsalnAIXEy0dKuWZhPB+ywEpUEKPqzjajcT7yeIhP8k2XTCphPURN?=
 =?us-ascii?Q?+P9cBm+2ZCqGgV7fhE2q7Zr5ACHbePuyZIBK8YMRzNObddDOky4/JO0W9ylD?=
 =?us-ascii?Q?ifYwzvlfbuIs69ZEuYixGQp+pSLp3CvAO4+16ECKS8tz+LAWlUI+v0kKH9RQ?=
 =?us-ascii?Q?x2h8ZKWWFLwKQ35cE20S+j85cuvTCRFLr7hXh5oNpHV4NvxcdSZ4p31t/pdT?=
 =?us-ascii?Q?Uxs0OQ+P6fXGSHMBATjrjO0EjuWL1Xjz2yOExexhMCnj06lzPoY6aBPgqHYd?=
 =?us-ascii?Q?rFFmKdu6IWLJaG43Tnc+X8CptkY6G5GW/8rJu9Hp0nM41xYFoMAp/gbBCoQ8?=
 =?us-ascii?Q?02fu9v8WBFucHB80rGORnhBMiYLSn+LuqFvnTAeD+Uy1VpftRtxEqaaH+tsL?=
 =?us-ascii?Q?+ohBl5pWWxPzuLdpx4z8Vx+9ZHZNg19wbOwED3VXSM2ABpb7yO5zVQOVyfy8?=
 =?us-ascii?Q?atN5w3mZLIj47wWaGwDbvcMSiJJ71JRkklNhsB/Hbm9hJJzUwWwd+Mp4ahn4?=
 =?us-ascii?Q?vj7yvL4w21YxdJum+xpb3FH88rZYD07amt/Coc+Gk6AM5U4mR+SbWoKVrJrS?=
 =?us-ascii?Q?hlFblij39r1yTgX048Xr5zabffIOdgGcFrJpDNmUUO1JTi9ZXXiQH0nMGCPB?=
 =?us-ascii?Q?56ysaQa/SPqTy/pFlv+1lgXUv6uP5jPPEZuyxWolVSEJFUYSccpnetjR7P6U?=
 =?us-ascii?Q?AmWjJ2kfw/Y429aUBX/FkGCxhF2xnhsMy4Kf4ctOAy8kyHta2oy7fekBi3Bb?=
 =?us-ascii?Q?EWP3jSr9a+93Ad+fPCRPFhY057+QWpgZ/fITsL2i09N9N1EPTG5b5XQXygv5?=
 =?us-ascii?Q?Kks398c9/7EFo4Ghok7M5iJXgc7+hrOoGHCIKDJtLPadz9NmvDDkZ3gqkSY3?=
 =?us-ascii?Q?1dRR8pvigvopRI73cgE7WTN7EJRe36XAaDFKRC2E7FroLE4SFxsatzIsN8Gr?=
 =?us-ascii?Q?hsPImX3fJbmoHvVZDPREVmkMDxCuTSdN/5EHKLNoxbGGNQEWKq9UGYp94cF0?=
 =?us-ascii?Q?UMo28iADxWTpQR85WgjHbvL++4q8iqVdd8PapGBflQ0xbrWkR3FdTp0SObQW?=
 =?us-ascii?Q?hPsTQf4R0TzlWO53yQbn+7ri9PZ0PBRkjWMmzb/+yYuI6fZ5fJlOSG+rt7FP?=
 =?us-ascii?Q?l91vs3Kqa30GnM0+pnb0F/ZWq+YQQ7Bya4RctqG2nLgZvRPA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf762091-7350-4a04-0bc5-08de9573d805
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 13:36:31.0954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YcsKDwe56xhsAhkMgwv23BQBCk6grWZpwdFYroBf4uW93HpPlzj9ak439aOhk8DZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234
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

Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>

Thanks,
Ruijing

-----Original Message-----
From: Benjamin Cheng <benjamin.cheng@amd.com>
Sent: Wednesday, April 8, 2026 8:54 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Liu, Leo <Leo.Liu@amd.com>; amd-gfx@lists.freedeskto=
p.org
Cc: Wu, David <David.Wu3@amd.com>; Dong, Ruijing <Ruijing.Dong@amd.com>; Ch=
eng, Benjamin <Benjamin.Cheng@amd.com>
Subject: [PATCH v3 1/3] drm/amdgpu/vcn: Move RDECODE_* to amdgpu_vcn.h

These defines can be shared. Move them and prefix with VCN_DEC_ instead.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
v3: Renamed to VCN_DEC_

 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 3 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 7 ++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 7 ++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 3 ---
 4 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.h
index 82624b44e661..e72687246235 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -57,6 +57,9 @@
 #define VCN_DEC_SW_CMD_REG_WRITE       0x0000000b
 #define VCN_DEC_SW_CMD_REG_WAIT                0x0000000c

+#define VCN_DEC_MSG_CREATE             0x00000000
+#define VCN_DEC_MESSAGE_CREATE         0x00000001
+
 #define VCN_ENC_CMD_NO_OP              0x00000000
 #define VCN_ENC_CMD_END                0x00000001
 #define VCN_ENC_CMD_IB                 0x00000002
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c
index 6fb4fcdbba4f..64531ad56c48 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -58,9 +58,6 @@
 #define VCN_INSTANCES_SIENNA_CICHLID                           2
 #define DEC_SW_RING_ENABLED                                    FALSE

-#define RDECODE_MSG_CREATE                                     0x00000000
-#define RDECODE_MESSAGE_CREATE                                 0x00000001
-
 static const struct amdgpu_hwip_reg_entry vcn_reg_list_3_0[] =3D {
        SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_POWER_STATUS),
        SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_STATUS), @@ -1957,7 +1954,7 @@ st=
atic int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *jo=
b,
                goto out;
        }

-       if (msg[3] !=3D RDECODE_MSG_CREATE)
+       if (msg[3] !=3D VCN_DEC_MSG_CREATE)
                goto out;

        len_dw =3D msg[1] / 4;
@@ -1973,7 +1970,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *=
p, struct amdgpu_job *job,
        for (i =3D 0, msg =3D &msg[6]; i < num_buffers; ++i, msg +=3D 4) {
                uint32_t offset, size, *create;

-               if (msg[0] !=3D RDECODE_MESSAGE_CREATE)
+               if (msg[0] !=3D VCN_DEC_MESSAGE_CREATE)
                        continue;

                offset =3D msg[1];
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v4_0.c
index 5dec92691f73..a89e316a4add 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -50,9 +50,6 @@

 #define VCN_HARVEST_MMSCH                                                 =
             0

-#define RDECODE_MSG_CREATE                                                =
     0x00000000
-#define RDECODE_MESSAGE_CREATE                                            =
     0x00000001
-
 static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0[] =3D {
        SOC15_REG_ENTRY_STR(VCN, 0, regUVD_POWER_STATUS),
        SOC15_REG_ENTRY_STR(VCN, 0, regUVD_STATUS), @@ -1874,7 +1871,7 @@ s=
tatic int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *j=
ob,
                goto out;
        }

-       if (msg[3] !=3D RDECODE_MSG_CREATE)
+       if (msg[3] !=3D VCN_DEC_MSG_CREATE)
                goto out;

        len_dw =3D msg[1] / 4;
@@ -1890,7 +1887,7 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *=
p, struct amdgpu_job *job,
        for (i =3D 0, msg =3D &msg[6]; i < num_buffers; ++i, msg +=3D 4) {
                uint32_t offset, size, *create;

-               if (msg[0] !=3D RDECODE_MESSAGE_CREATE)
+               if (msg[0] !=3D VCN_DEC_MESSAGE_CREATE)
                        continue;

                offset =3D msg[1];
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0_5.c
index 1f6a22983c0d..cbbc02d68695 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -50,9 +50,6 @@

 #define VCN_HARVEST_MMSCH                                                 =
     0

-#define RDECODE_MSG_CREATE                                                =
     0x00000000
-#define RDECODE_MESSAGE_CREATE                                         0x0=
0000001
-
 static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_5[] =3D {
        SOC15_REG_ENTRY_STR(VCN, 0, regUVD_POWER_STATUS),
        SOC15_REG_ENTRY_STR(VCN, 0, regUVD_STATUS),
--
2.53.0

