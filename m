Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78922CD1288
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Apr 2024 00:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1A0010E35A;
	Tue,  2 Apr 2024 00:42:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wClvsoLN";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2121.outbound.protection.outlook.com [40.107.244.121])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ED3910E35A
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Apr 2024 00:42:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8RF9cdt3NVUzCovvJlfYSbf/R67nlRsu5hDIIkGU4dCLuX87JBDBol4JHCOaCSJrIMDRFTwPpsQ0keQAW9oG4DZWJLKN+H/XXK9KebnIgwFmOu+EB+XSPONRHmw2Mun8+UqZBNhZp7LG/Tok4OUov0HSJk/AZjsODEOPL6wR9raNlv6ZOY/wllsFBCx8UwJLfGiYzMvhAazy1BbXUlCdtvIevZg0BtJp79B65bL/k+GxEXuTJKPL272HiuUDfdZN+t2qOIeYpInNeQuy5SPfDoq+2zCpCN8ENxcchWisfIrnCSFOnmQqvJyQhXcceuveMhhbHTc9iZpB0e8HKWqPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATGYhxbpBKU0QXt+7+KQ3e8o44l0ezU4PFkycsJVarw=;
 b=Tu89fKErUENV9SQFqcZR3Sw4452yQtQizpTXRqEUht6GeCOUnp1kMClf1q92/qugsSNTwbjAPUX9gz82SqjNXm34b15/dfViq0TmokYH+7CFe0VIn9emcOhO9+3p/ApaYfen03hDu9j/Hz7gjqrK7XH6YMAoqedjUz6YRfZUACGQZOE6c4v5kFT7Johzf+PcOaQ4359WFBM0Nig6OWj3M+0WMot0C5EMvw7PVIpGmislai7BoO/XGYg+p0EBFMY2GvO9O92Y1qYOtQG+PmyZETiR7qRfeyD9X0wf3AZjOgKABlJI5gZE1lbd6hRqCtJDIee83RbRrSAUhmIkePlFzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATGYhxbpBKU0QXt+7+KQ3e8o44l0ezU4PFkycsJVarw=;
 b=wClvsoLNaWAjubl9ojLKB0okSr/b4KBJjkebOxQUhaALAax+3qBSq9Gk+c5UC8K2sQ9uDqcEeGTVMekNGfELrV6R9vEbNq7mM4aWb31tf/Plo90zJf0ZhfiSrShnP6Ls5hlTuGkb+oM8Cg9EpcF0JH39Ro0kMESLhezww4ngE5w=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 00:42:51 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::832a:d65b:6251:4d6e]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::832a:d65b:6251:4d6e%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 00:42:51 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/mes11: print MES opcodes rather than numbers
Thread-Topic: [PATCH] drm/amdgpu/mes11: print MES opcodes rather than numbers
Thread-Index: AQHagqrTviw+lpMVoUG2IT9CoGEqFLFUJisQ
Date: Tue, 2 Apr 2024 00:42:51 +0000
Message-ID: <CH0PR12MB53727F41E0D147A9EEAF23A2F43E2@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20240330140129.18824-1-alexander.deucher@amd.com>
In-Reply-To: <20240330140129.18824-1-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=03d876bb-0ab9-4478-9d64-34c60a2aa8c7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-02T00:36:07Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|SA1PR12MB7368:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MAF2c8BsVbEKnnZXLvQKsXFMTyqwB+HgMdJQ7CtBTw8fp2qJNfPNnN/Q01SxNJnpfoEtQl5zMvJ9TnF1oUkSF6oMEKU/Kyjwn6JjLBKxLFW2gZCqtYbhwgQH1zKmh1RbJytO82mhTvlBoQX1l+2unHE6HflvinRc89+WIYStjd0nug6Z90g63DmbOLZx8MEQmnFCfLDcbq4C0MTleKzrQx5eY91gA5k5aLdEbdgphC+EIaAL8A+gAb3ImoGZXRfzq+QeTQ0VHYw3GMTZftYhRK9/Qal/VVMgdRJp0Q/5wQgsmk7Dm/uTV2DI6I0lProXvd+1wZ4sMeCeBJ4pI8hzIzMpuFE28FOTQr2tjizeKeyCVJNqmOHNJ3+vps22nI0iugWqv4v3ZnABOL6O28AtmLAHVzt4Lxi63a42oAEqQvm9Bq0BEjqTQozF58QF9QnEhnWUkaLRlmvjTTuooXVNXXUL8g6gXbyxFTwNm9VQEc79Dx0dWpw0YqEEr80T8ctNeDUdWqlP8X6de0I67Zdpw0N4sauQwONwulyp+o7Ju6qm8U0NPpF/nSJSi+iXzJXM4mCcYg7JQa5ONP7iwg0ZbTyts9cJ0loVBXTo/lSQEPuzk0m0Bn3NLnt65J5pgQHM7UmLScQcwkQ7QsNRV5orZQG7eKU4XX1pFvY7LW88qqI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eZXW5R3d0y3XQ+SMaahcyP4COrZcmQapVDJf9P9bEYSLHYaIcXwBWf2CAVhQ?=
 =?us-ascii?Q?fG0H88f7COAmSCb0Rlnihz5Hu+bqgcfHSxNZl631Xjyz96dVM/4u+0cIuyQN?=
 =?us-ascii?Q?tNEM5CX8j1gK7vM/c+rftsc+52yGyaJ+f3lH033KNUXsse02KFRrUvXI0G7r?=
 =?us-ascii?Q?Hj/o5JeBdYe+OItTJ/cCpARTaDWZoHiDVmOVFLM+GvuUp1eW5OvYF6oDNhag?=
 =?us-ascii?Q?poQ6dM5QZqQCiJXQaVowMig7wuDTMai2kRPaeDkYQ7ln/TNMJgZuTb5QvafA?=
 =?us-ascii?Q?7imtp2fPQb41cKwZEn4fLoFnOmhn0U/tPW4c1lkqW+Fhz4HvYIss7yGkT2tP?=
 =?us-ascii?Q?bMk2YsXsJ9+S1l430F6pnyzTokcvDOppbbB0QhL26BU5oPF15lYO6melFRFH?=
 =?us-ascii?Q?sxM0IX1IA7pCO12xd/sbPXpUpNc5Fth7DhO5mwXzfW+rLdMJSBU7GNwFvo+L?=
 =?us-ascii?Q?p9VaAfDfKxmzQOP2LxXBEyqNwFZ6Ei0cQ3S6lBVIYXwlNCDZAS/DsGki/7yk?=
 =?us-ascii?Q?MUmlQYIwfpoCjaN6kYpb4NYaB/ZWLXkQQggzHMSzfWVlpzLjPVwAMpTSprE7?=
 =?us-ascii?Q?B61wiGAryNCUc4HSGFgi221rgup1bzmrSJE6v+UqY4R9dyzee2ipXPqJoZOk?=
 =?us-ascii?Q?7+lRBj8kL0DoLvSZ5PQtDZENvSqTQMWYZpAxInwytL3gPvoU0l2PNM856bVJ?=
 =?us-ascii?Q?AfuGpJ+33Zkqa9eF3Iv/vHg0cg9OM6qZuwvZ4w7Vk7BS481qC8PHaj3r9P+3?=
 =?us-ascii?Q?E3Y4IRnvmC2DsxEGDRHMFdTY5ldgbf6JyE61X4ry1wYOGJWUjoo3FPC6kxd/?=
 =?us-ascii?Q?5x8x1mRPXEQQzyQ1xbselSf/wUgq0WpxXOmCtw1BZNhAFaQj7kGtcH4/H9GI?=
 =?us-ascii?Q?lGjN/g/nE6w5DSs1STRZatmlEHobf5Psw2tIIGW1SmM5cMHZYPVjrtSvXbC1?=
 =?us-ascii?Q?gyjnHQ3bt7DGzZP/wtAfFUKfaYfqJ8ePngagezDAZPerVEIc0cLX1z3aSFSF?=
 =?us-ascii?Q?ZALiT+wL1Ay9WGhIewZ95EkeoF26mgID07nUc0IbvEKNu02hKK8ymanduJLd?=
 =?us-ascii?Q?Woy67ZVJzE0pIUHavLyUsFt/0rZFOxaXH+2FDp1mFdozxlV2uA5nh9+wE3oQ?=
 =?us-ascii?Q?SKS4srOhj7sB3B/GB47xpkF+9+4PAL2Ef6JK4/Sw0YcdzrYZPdnzC5zejEHv?=
 =?us-ascii?Q?AhYW3Jogqk3Cp/bClIOJ6z58H38lSfUV2q1sppmuMnLoAEB4ASLPc/LssodD?=
 =?us-ascii?Q?4E6OkEzVC5cmRP7+aCcMGErrrydnR4oCXmx8H15yJ26G1AAFCfKxYVMFVUsJ?=
 =?us-ascii?Q?ChZNlMQ1i9jhVljnOP3dMDprHt1J7fYrh7tF+a4FuWCnDXkTJEGYNtJX3ZFT?=
 =?us-ascii?Q?V/Kju3PjJNmc93c7SlSE4FpWedEzZxuInzEhlgUifFmMXnJpTugxgohBJWUF?=
 =?us-ascii?Q?Puuv6Rtt/bXtGeR2PQr8Drpq/bekW+4vnZyicZI6smqQJM0qjRkCPJzvyKOs?=
 =?us-ascii?Q?FHdBRyTeqTgOf0+6bOwy8t2tQhIr1Ok83mGn7h51ToupSLmeZCqXI0QA61FR?=
 =?us-ascii?Q?wAw/35HbZljRAFaCd+w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c220435-2c22-48a6-5d97-08dc52add3cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 00:42:51.6080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kkR+QUCO394U+3Da3hrjR2I4/weBHsMQPnXdU1Sw5i9mk05XWRzdbIO50mBr8kECSOAxL5irZf9KGo+ByyttPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7368
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

Comments inline

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Saturday, March 30, 2024 10:01 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/mes11: print MES opcodes rather than numbers

Makes it easier to review the logs when there are MES errors.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 65 ++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 072c478665ade..73a4bb0f5ba0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -100,19 +100,51 @@ static const struct amdgpu_ring_funcs mes_v11_0_ring_=
funcs =3D {
        .insert_nop =3D amdgpu_ring_insert_nop,
 };

+static const char *mes_v11_0_opcodes[] =3D {
+       "MES_SCH_API_SET_HW_RSRC",
+       "MES_SCH_API_SET_SCHEDULING_CONFIG",
+       "MES_SCH_API_ADD_QUEUE"
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
        signed long timeout =3D adev->usec_timeout;

+       if (x_pkt->header.opcode >=3D MES_SCH_API_MAX)
+               return -EINVAL;
+
        if (amdgpu_emu_mode) {
                timeout *=3D 100;
        } else if (amdgpu_sriov_vf(adev)) {
@@ -135,13 +167,38 @@ static int mes_v11_0_submit_pkt_and_poll_completion(s=
truct amdgpu_mes *mes,
        amdgpu_ring_commit(ring);
        spin_unlock_irqrestore(&mes->ring_lock, fl
-       DRM_DEBUG("MES msg=3D%d was emitted\n", x_pkt->header.opcode);
+       if (x_pkt->header.opcode =3D=3D MES_SCH_API_MISC) {
+               if (x_pkt->opcode <=3D ARRAY_SIZE(mes_v11_0_misc_opcodes))
+                       dev_err(adev->dev, "MES msg=3D%s (%s) was emitted\n=
",

[shaoyunl]  Shouldn't  we  use DRM_DEBUG  for valid  condition ?

Regards
Shaoyun.liu

+                               mes_v11_0_opcodes[x_pkt->header.opcode],
+                               mes_v11_0_misc_opcodes[x_pkt->opcode]);
+               else
+                       dev_err(adev->dev, "MES msg=3D%s (%d) was emitted\n=
",
+                               mes_v11_0_opcodes[x_pkt->header.opcode],
+                               x_pkt->opcode);
+       } else if (x_pkt->header.opcode < ARRAY_SIZE(mes_v11_0_opcodes))
+               dev_err(adev->dev, "MES msg=3D%s was emitted\n",
+                       mes_v11_0_opcodes[x_pkt->header.opcode]);
+       else
+               dev_err(adev->dev, "MES msg=3D%d was emitted\n", x_pkt->hea=
der.opcode);

        r =3D amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
                      timeout);
        if (r < 1) {
-               DRM_ERROR("MES failed to response msg=3D%d\n",
-                         x_pkt->header.opcode);
+               if (x_pkt->header.opcode =3D=3D MES_SCH_API_MISC) {
+                       if (x_pkt->opcode <=3D ARRAY_SIZE(mes_v11_0_misc_op=
codes))
+                               dev_err(adev->dev, "MES failed to response =
msg=3D%s (%s)\n",
+                                       mes_v11_0_opcodes[x_pkt->header.opc=
ode],
+                                       mes_v11_0_misc_opcodes[x_pkt->opcod=
e]);
+                       else
+                               dev_err(adev->dev, "MES failed to response =
msg=3D%s (%d)\n",
+                                       mes_v11_0_opcodes[x_pkt->header.opc=
ode], x_pkt->opcode);
+               } else if (x_pkt->header.opcode < ARRAY_SIZE(mes_v11_0_opco=
des))
+                       dev_err(adev->dev, "MES failed to response msg=3D%s=
\n",
+                               mes_v11_0_opcodes[x_pkt->header.opcode]);
+               else
+                       dev_err(adev->dev, "MES failed to response msg=3D%d=
\n",
+                               x_pkt->header.opcode);

                while (halt_if_hws_hang)
                        schedule();
--
2.44.0

