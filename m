Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33FEC001CC
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 14:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EC9011357D;
	Wed, 17 Apr 2024 14:16:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fa2TjLND";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 971F111357D
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 14:16:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LN0p2EtigZ/T1RPRLf6+IOD9OLL9EE2NsK0+bNl8Ehvqe+D1hQGYCd0DaYr+/c4seVSkVHAZBG8xGeQPGR7UYNUi491YPR5gJVJfV0O5X+dGdQVIaakuSMhc6WCSiAcXtzyoDF3yK7cL/sscujF7gfNEpCJLNtpF6UfiduPie7Yr/5Pa/8HlM08R5CL1JtgJDhpvVUwK/veMT4XGCyT2oL3/cUT41/ChwPte6Qs30yb6lNREd1OTlJ6Opn5OhHSKFN/Yw/CumZCnmmuKBYgFR12Sbn/LFj3EstVjukMCDjhdiJViFW3gTb8pEB/DBfKaFPhMjeh6ZK42LzS7DuEkRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaoqD6vwXBmZ6STubmulelSSj2VaGlNr5jEytFVMkqE=;
 b=iltEu1WQwTSPbvqjsxxoYE/3nlmn75UerOpXZ/nTEZtmdT9MJwG34PJt3JtjqRnQaZA2/sNnFe4cp4i/NFEMlLsyLujcn3piVDcRp+UEAMhU38RvnYOx857Y1sG24lHdJUXxO/t6fUZ7k1zMbUSbIQZTAyvIjYX9OPV1OakXLwVozGb5BswowKKElg7ArLyve1lp96+X1Bik4msJeiCHiqaO/nucUbJsK25q66kzQ0AeCkEFyRl0ZI884nCSlOd6SlCInRW5QncLQq4OKnzOUz1nD7vopB2PjgRBDjV+J1TQs3D/gzk19K/zRh/yWJ52JAaTP09+BxU821ezY5invA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaoqD6vwXBmZ6STubmulelSSj2VaGlNr5jEytFVMkqE=;
 b=fa2TjLNDzNa9chgGEN6/YWVp8l7wMibhtS3haVhNKtyt1f/HRFTo0enNWqA3iui8kxjXv03IJSxgxN9h25h4cRcklOkQTOiIEY6UcFt0Q+8xOc6C/1xmkAr4skFjR5zOx2yiuuPbjT5/EI2XKps9Opa6O3qjC9kHalUz9K5anHo=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by MW4PR12MB6683.namprd12.prod.outlook.com (2603:10b6:303:1e2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 14:16:43 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::ffd9:2592:5d85:ef60]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::ffd9:2592:5d85:ef60%3]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 14:16:43 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Chen, Horace" <Horace.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Xiao, Jack" <Jack.Xiao@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Chang, HaiJun" <HaiJun.Chang@amd.com>, Leo Liu
 <leo.liiu@amd.com>, "Liu, Jenny (Jing)" <Jenny-Jing.Liu@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu/mes11: print MES opcodes rather than
 numbers
Thread-Topic: [PATCH 1/3] drm/amdgpu/mes11: print MES opcodes rather than
 numbers
Thread-Index: AQHakLrLHvD5rfxyO0mmBAGq4TzOz7FsgftA
Date: Wed, 17 Apr 2024 14:16:42 +0000
Message-ID: <CY8PR12MB70998B0D08AF14200370C7568C0F2@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20240417113025.2886905-1-horace.chen@amd.com>
In-Reply-To: <20240417113025.2886905-1-horace.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=67683e75-6c77-4be7-9aeb-1f08043141c7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-17T14:15:37Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|MW4PR12MB6683:EE_
x-ms-office365-filtering-correlation-id: 97e2ef12-3760-426d-fc78-08dc5ee901a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: grCo0m6v45c9pB/nUpAyQesCaCMAGOLZ5Uji1yiPvNU+QJlvuyf/o9oEn5hLZgbHd8Vcx/aUeLSpbfP3XcLKGEKmUTlEB4hv3jDpFaZSlWzUtARXMAf+GgPEVKdq1tIEVZSgg6UGiu/s9uEAFU9eqmqEa9aqCq0b5i/MVnPgo0Jc9HSmcPcpix+8NxZRx0QdXUuSHm/hXRJE2P1fGyNipqoCRKB9e5qY02OHtSWMxwPEHpSFXiU5XXCkJleJUOuqUlzo3XeR0s01sb7rtj7VDhakanIrCK2mquvhaenbMeCVGv9pzs2fPaO6DSyeV4I8RLQbNE4QOyHdbyrvwISRIxbwn8i4L5wy2LUMUtHHEi+Ger4ro2jszCZNNYmTiJaqvZiko8YB34pjjfzfttEhoBkvS0YoXiBYIx0LOCEg95qWbO1tZm5v22OGGMQ3Twzq65p/O0w7mj1YGDchI9yzBkWxJK/Y2EZxzkF2V/Lqf2LABmgtFtbvslenZuKkqG9QTBwCvcum+82qWd23R4/O/A/DG03zns91qiip3LAtsC5tQfnV+04Tims9DadsR8bfxDdlwaDffHf98mEIIRE8+HY6pwZCP/7ZEeEzzt+UyKmgL4U2+1OV3qPfmy+KK+OFJ21wzHkX3bWUV68o10vm5i2rRK+yy5ylK14PrKgwDxsrnfgTVlzd5fV2CcaB4XQqN52AguWI843TkIBXlbWXII0V21YYGwHj2sHtcAc/3TU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dYShly0/x/fuso6AqCszU0t3UltF4UgsDN4k+IwOGwxQZpAofG0+atk8CgvG?=
 =?us-ascii?Q?lonyu5QhMC7MOCZGwcEGxj5husAoXfFN2xkiGesHIRsQW3ANvDc0NWroW8l6?=
 =?us-ascii?Q?aHcd/EqJSb8QKz9Rtjg3D/+a5blAZNjPeus5dw5O1NGe0Vlcqm9gpWoXN9kz?=
 =?us-ascii?Q?auLxc15/1YfhEcuqX9T5V3OUaYtrflB3FnrrrgMNXhxIAvh6WTfPR+wQRTZn?=
 =?us-ascii?Q?iPrn7nGRAyAjopvV5CTMKVljugbQ+V3B9o/iQcyCkRgCUwHDQ80PLAkxvGQU?=
 =?us-ascii?Q?zHoDp8lKfkCPWmcUEHUTYjvculRZ9kTOMmWoyo3qSWchenkflnSt//qlseGD?=
 =?us-ascii?Q?F8LriRj3YZxvrQ1RxFkAGeAW346A2DjBLlJgjcOU3pelqDvmN+keh3gew/UF?=
 =?us-ascii?Q?wM1dhwNaC0dgHpjMAvITnfm2GrWXY4EY7HbQGmKOF5hpBRVe4WAHb66AWqmB?=
 =?us-ascii?Q?oG1Pp3JkQogu/41qBtG7m/uWyIPYeYDD1Ry9aIlne3IRXjirtnVOnI7HxrIK?=
 =?us-ascii?Q?BVXFUxBcoJ2y2nuewyND1FGCg1iCk3Q/seYGuZM1K04F8a9kZ7nT9a0mUcsn?=
 =?us-ascii?Q?ItCFGoLEdchu8byLte3E1X3A2aJi9nw7WkbuNMKFzEKC22f2gtXNY3tf0ONs?=
 =?us-ascii?Q?HUFUFcGdXFUcpSAulf8YL3Qabq9YBes1hjjvzODVC+6aoTfcbqy6I3FJhQx5?=
 =?us-ascii?Q?cLymyHT8LNfU7GP7AZh6EZ0ykzp7O44O/wHH4GH0n6OzG/RuOeLUOWqPMA3w?=
 =?us-ascii?Q?arGD1dKLFumrVXJcaSVKA5NDm7M3b4lSU9bW0RRiJdenZno26/JxUeHX6dR6?=
 =?us-ascii?Q?2l9Y2k5aGvH/Sc1ldh4IorwJC3uivyJ0LEfGUwYKfmJXkZomFiFa9NRJAx0J?=
 =?us-ascii?Q?eNkVMDkGDS62N0IaR6n9n0yolmJVF6ds6ZolD6G2xjHjFtYyPPH1xybYhYNQ?=
 =?us-ascii?Q?WxYj0CP6GVmlHRnT0Auc6HclbnI8f9eez8EYslbMpMTqr7jQXZRtqY7ET8Xg?=
 =?us-ascii?Q?Gb5dkQ4FOPqCATqETKgh90aSHMUqvbH30k8D5mIcKj6TZ7GX5R5f9dcjKBZf?=
 =?us-ascii?Q?+u0w3vfrcVliQY40zrOrm58ezScQHT52tgY1vAqSkV6fn6+uC4Q1wrzYEjGd?=
 =?us-ascii?Q?lUlWFK5Zj2fjcZ8k3D8ATHIBSAFvHP+3owP/NZ/PDq7laYvfLE4C4fkNTvdT?=
 =?us-ascii?Q?AqU1eEtvs+vqkR9hxrOqju0kOpZ9irV5NUu+YeAAPAjCJcZgtpXGWX6W+nuf?=
 =?us-ascii?Q?02g+GkVPJNeJMAFWL2LcVujxO50NYKcUHnnJenvr/hKj5Ax3oSvGTpHK56Mf?=
 =?us-ascii?Q?aN27RAVOwLVPBV2ZmDe/42GEqAjFP64b1Q0EfEnBvfTGDOrWLiYhWvsvly9S?=
 =?us-ascii?Q?upyssTJFsUQlPJH/bps2Ib6jqqzvuaniUPlCn3xypzNL5PlMmhP/4GEkV2P0?=
 =?us-ascii?Q?oxQ5G0LzVRYJhD2ZkV4eYJfH+sxqFpLeh2ZuXQy485krZPptZrDttz/X/gpu?=
 =?us-ascii?Q?4c1IvxLzHM+f3ZSJDM5JKeQ6nOMurJykh/E/fPE5LgOMELPZDXLXuV5QYJYu?=
 =?us-ascii?Q?tohPDJUtll/K36FGNAo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e2ef12-3760-426d-fc78-08dc5ee901a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 14:16:42.7207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5uSNb7DkhWf7+vEx9SFdj3t3zmy0jF6vpJJs/czmm5DkkMznHVSE3rnB2qy5YqzQLYZQzrIPYzWhI/y1yDMxVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6683
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

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Horace C=
hen
Sent: Wednesday, April 17, 2024 7:30 AM
To: amd-gfx@lists.freedesktop.org
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>; Kuehling, Felix <Felix.K=
uehling@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Koenig, Christian <Ch=
ristian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xi=
ao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, =
Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Chang, HaiJun <Hai=
Jun.Chang@amd.com>; Leo Liu <leo.liiu@amd.com>; Liu, Jenny (Jing) <Jenny-Ji=
ng.Liu@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/mes11: print MES opcodes rather than number=
s

From: Alex Deucher <alexander.deucher@amd.com>

Makes it easier to review the logs when there are MES
errors.

v2: use dbg for emitted, add helpers for fetching strings

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 78 ++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 81833395324a..784343fb7470 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -100,18 +100,72 @@ static const struct amdgpu_ring_funcs mes_v11_0_ring_=
funcs =3D {
        .insert_nop =3D amdgpu_ring_insert_nop,
 };

+static const char *mes_v11_0_opcodes[] =3D {
+       "MES_SCH_API_SET_HW_RSRC",
+       "MES_SCH_API_SET_SCHEDULING_CONFIG",
+       "MES_SCH_API_ADD_QUEUE"

"commas are missing for bunch of defines"

+       "MES_SCH_API_REMOVE_QUEUE"
+       "MES_SCH_API_PERFORM_YIELD"
+       "MES_SCH_API_SET_GANG_PRIORITY_LEVEL"
+       "MES_SCH_API_SUSPEND"
+       "MES_SCH_API_RESUME"
+       "MES_SCH_API_RESET"
+       "MES_SCH_API_SET_LOG_BUFFER"
+       "MES_SCH_API_CHANGE_GANG_PRORITY"
+       "MES_SCH_API_QUERY_SCHEDULER_STATUS"
+       "MES_SCH_API_PROGRAM_GDS"
+       "MES_SCH_API_SET_DEBUG_VMID"
+       "MES_SCH_API_MISC"
+       "MES_SCH_API_UPDATE_ROOT_PAGE_TABLE"
+       "MES_SCH_API_AMD_LOG"
+};
+
+static const char *mes_v11_0_misc_opcodes[] =3D {
+       "MESAPI_MISC__WRITE_REG",
+       "MESAPI_MISC__INV_GART",
+       "MESAPI_MISC__QUERY_STATUS",
+       "MESAPI_MISC__READ_REG",
+       "MESAPI_MISC__WAIT_REG_MEM",
+       "MESAPI_MISC__SET_SHADER_DEBUGGER",
+};
+
+static const char *mes_v11_0_get_op_string(union MESAPI__MISC *x_pkt)
+{
+       const char *op_str =3D NULL;
+
+       if (x_pkt->header.opcode < ARRAY_SIZE(mes_v11_0_opcodes))
+               op_str =3D mes_v11_0_opcodes[x_pkt->header.opcode];
+
+       return op_str;
+}
+
+static const char *mes_v11_0_get_misc_op_string(union MESAPI__MISC *x_pkt)
+{
+       const char *op_str =3D NULL;
+
+       if ((x_pkt->header.opcode =3D=3D MES_SCH_API_MISC) &&
+           (x_pkt->opcode <=3D ARRAY_SIZE(mes_v11_0_misc_opcodes)))
+               op_str =3D mes_v11_0_misc_opcodes[x_pkt->opcode];
+
+       return op_str;
+}
+
 static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes=
,
                                                    void *pkt, int size,
                                                    int api_status_off)
 {
        int ndw =3D size / 4;
        signed long r;
-       union MESAPI__ADD_QUEUE *x_pkt =3D pkt;
+       union MESAPI__MISC *x_pkt =3D pkt;
        struct MES_API_STATUS *api_status;
        struct amdgpu_device *adev =3D mes->adev;
        struct amdgpu_ring *ring =3D &mes->ring;
        unsigned long flags;
        signed long timeout =3D 3000000; /* 3000 ms */
+       const char *op_str, *misc_op_str;
+
+       if (x_pkt->header.opcode >=3D MES_SCH_API_MAX)
+               return -EINVAL;

        if (amdgpu_emu_mode) {
                timeout *=3D 100;
@@ -135,13 +189,29 @@ static int mes_v11_0_submit_pkt_and_poll_completion(s=
truct amdgpu_mes *mes,
        amdgpu_ring_commit(ring);
        spin_unlock_irqrestore(&mes->ring_lock, flags);

-       DRM_DEBUG("MES msg=3D%d was emitted\n", x_pkt->header.opcode);
+       op_str =3D mes_v11_0_get_op_string(x_pkt);
+       misc_op_str =3D mes_v11_0_get_misc_op_string(x_pkt);
+
+       if (misc_op_str)
+               dev_dbg(adev->dev, "MES msg=3D%s (%s) was emitted\n", op_st=
r, misc_op_str);
+       else if (op_str)
+               dev_dbg(adev->dev, "MES msg=3D%s was emitted\n", op_str);
+       else
+               dev_dbg(adev->dev, "MES msg=3D%d was emitted\n", x_pkt->hea=
der.opcode);

        r =3D amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
                      timeout);
        if (r < 1) {
-               DRM_ERROR("MES failed to response msg=3D%d\n",
-                         x_pkt->header.opcode);
+
+               if (misc_op_str)
+                       dev_err(adev->dev, "MES failed to respond to msg=3D=
%s (%s)\n",
+                               op_str, misc_op_str);
+               else if (op_str)
+                       dev_err(adev->dev, "MES failed to respond to msg=3D=
%s\n",
+                               op_str);
+               else
+                       dev_err(adev->dev, "MES failed to respond to msg=3D=
%d\n",
+                               x_pkt->header.opcode);

                while (halt_if_hws_hang)
                        schedule();
--
2.34.1

