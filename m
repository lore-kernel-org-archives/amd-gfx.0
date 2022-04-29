Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53608C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 02:44:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBFE110EB8A;
	Fri, 29 Apr 2022 02:43:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2567510EB8A
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 02:43:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boEybhzkMe8mTDpBqWdINWc2AcfVbh5oD9s3XgqT3lOcJvPEjdG56aA0QdrVCHkaeNjeTB4VSEGmPrJD5/BGBf1xOD78C0Xh2EYAIxZLLWJ/e8V90nVDS66MswK/B/kj8WnoS09Vs0fItoObcCCwNkD96Wc4kLL6598ErMnmLj9DI3kc/JbxxeGhvf1PrD09vDjiVSQJlZtqMU0oTqOJuKBDBqCh2iKKXsyjBLgz4eeNJCrdumCiJ0He5ugL4Ta3wdZ6GpNgOMFbTKdoeJg740znrQ+Gyko6QIchXWW7qNuL4ednNMk9dsgLlpBwo4soKz6SUlK3cEn61+T5YNTzfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeSa5Omt8Q6AcITiLUNCdHGuzBc1jFtmpxp5KIox+k4=;
 b=i1OyXCXBJQPBNdoFcv0mNmQNRHEP6jtcuXxASMhrgankHzwjS84Sx52+/V50PAleQlHetQMqMUtYFfsRwFdg0YoBlSmfr7rBjOZgUxn6k1F+jhbdSjlMq+it24YAer+CkWLtjdRZE8LeX7xMeCGOsQVGlPZ067RLdZGs7XbzBOslRDvYl3rcLKw1Z6jXCCJlgS5oNy/iywoWLvJP6PC+br3BZfcYKekY5eXeQaVCN6Z8SLdUzk1lfZ4rn7XbT/Rz/U/U0SpC0SrEKWtjgDTpLymTw+H9Q/BZ/Zl+gKPKLXHvjRP4mDQjQ7YpK2CQzE1nL11GTpJFxb1qWNV1rdxhow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeSa5Omt8Q6AcITiLUNCdHGuzBc1jFtmpxp5KIox+k4=;
 b=nRzhlHEIlqRfvW8v+g6ivGTVICaX0pkK3HEbZpVjyqBs25td8u1xHUJmYX1VQmrevZMjeLdQYahrNOFEHaEOv0VzpQE5uAEGQ7EwMcZIFtR9HSQJbAHQaVCArWsDq0DKu+m9GafEFPCB4AzaNiODD7q6NeMyqRv9V/SqaSqCjis=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN2PR12MB3552.namprd12.prod.outlook.com (2603:10b6:208:ab::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 02:43:56 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da%7]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 02:43:56 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/5] drm/amdgpu/psp: drop load/unload/init_shared_buf
 wrappers
Thread-Topic: [PATCH 2/5] drm/amdgpu/psp: drop load/unload/init_shared_buf
 wrappers
Thread-Index: AQHYW00b6hSE32Va+U6FWoOl7pgxYq0GL0Qw
Date: Fri, 29 Apr 2022 02:43:56 +0000
Message-ID: <BN9PR12MB5257F0C9B507C7051C4E565EFCFC9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220428221231.1030104-1-alexander.deucher@amd.com>
 <20220428221231.1030104-2-alexander.deucher@amd.com>
In-Reply-To: <20220428221231.1030104-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=80e1ad32-c38d-481f-bd60-5d867da81670;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-04-29T02:43:41Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6e48241-9379-43ef-044b-08da298a1b73
x-ms-traffictypediagnostic: MN2PR12MB3552:EE_
x-microsoft-antispam-prvs: <MN2PR12MB355214A814A354B03E42DDBEFCFC9@MN2PR12MB3552.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wK3QTrF4DPRiDUigTOCT0PL7/mnhmZw7rz1aM7VXV0P8m3sWd4LQjJajFdC/mIetIuplp2H0ISCwP3beYaxq6CBW8a4+iY+Eq4Ri5WL1ax7xMIYSb0uthW56q1Fxz9g9++9DyN8FUHJ4wEjOFxSKKoWdiEvm0UkBp/k47qJfrruJtP5zsLBw0+xknfwz6LwEqm0rsoKmH6uYFI2eAtFzv8OvDNrIAQB2BzXjmdN0pRs02t2vQ3YZU7jVDQ7cXU/o2XKaXQgpKUXjZz/qdIUxLhFmGC7oq9aHfGWIU3fNQBdVwm3RFt8RrbLZT3mYos0xjLaaLR/nIKHjoYGHu0qzL3Ph6bzIwuZQQXKkQZ87xov0389a8Lub1xzShghVB7+SHK6yw0Ezp0ZiBlhRy5jG7CeZMwzu7437Aub5lYnEFB1oa4FIBcGPYA1DVZILac5hUQEFWsEt3fEpUCIIxT87AEsgTJl6AQr/xa+4I6c/jLE0wEYgrd+nlYT7Xc2R95QJZjztsrY0CTrkhxa0+nGqujgGIjTw3DFCp4xQSPIkOPNINbgFEAAsQoT0sdnIXi7c0N6znnUtZFQdd0ypBEbJhHUlbs4PaD8W+N9HfLrWsldMXqdlOL1Sq+y2iI8zAB792gLhE373mPJwJm8Ry8QudT4dDxCbuGpDK34TBU0sOiLpJnHmTKOyvLAORdNB8UlZHm2soA+jbfEhAgNMWfVjLw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(122000001)(2906002)(71200400001)(8936002)(5660300002)(38100700002)(186003)(316002)(6506007)(7696005)(33656002)(55016003)(53546011)(66556008)(66476007)(38070700005)(4326008)(8676002)(9686003)(64756008)(86362001)(76116006)(52536014)(66946007)(66446008)(110136005)(83380400001)(30864003)(26005)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t1ixp/gdzfxNcp7y9saxagRUvlXbLQoG4zwFhEbtsCWX+hrF85AuVxoZ0kms?=
 =?us-ascii?Q?D1G3MX2N3eXVkUw7qOX1qxzJ3D+K536Tg3Hh6iUHUZGhSewszKmSrKBi3A4c?=
 =?us-ascii?Q?tLfMG16OeXfqJmbv+Yu52xpxcQbzOIA1MaBIonhyRkiD1h7M7sX06VaE4CIS?=
 =?us-ascii?Q?craZmBNKiMAzHHTS8LlU31D3uf5bxhPfe8A/LcB+nCjreeM7i0f+eF6YZMXS?=
 =?us-ascii?Q?bqGa7IK5gmHkzmieWBLlAmtOAEBgN9q6RYU5q+vDvQNeL60v2SbeMFoqL5M2?=
 =?us-ascii?Q?gYR8XCWA3SMjXZpxQpIG56ZwYQFj6T97kJ9QUScWyB2ZHazY6zsHlFnpI/Hk?=
 =?us-ascii?Q?J0LvERbyoumA2U5NhOeX37hX+zF/pbpkDiS4/K4TuDqAh1WRGFBANNnBmiP0?=
 =?us-ascii?Q?buzHQAlfB9Rx8etGDJNRO1H0eybm1Lpzylj/A8ax7+Z6TTSYafvL6Hm/23Sy?=
 =?us-ascii?Q?J4jDoWhSvm8adqofj2u9A6lg7dOPKbChlNm47WAlEVNbE41xUwZ8o3aaa9vb?=
 =?us-ascii?Q?yoNbQrZPJy4LnQuCnAWZb3/Wdsu9ED/LRF3kuKfXyjqVFn90s48TQC1TX0kc?=
 =?us-ascii?Q?kmFe9O2kLdzRz2/6VqGovSXX7Hl8ltimj5yXJslcF9p1+aZ6fLQn4xXZuQg4?=
 =?us-ascii?Q?TvEJWiSVExoYWj8zuh/8jBTs4c9subPTp+rE/jAP1x0ZWmVSIn1bjNPpuDWA?=
 =?us-ascii?Q?jhA1b93MHL3Iv6m+/fm0len+d2WSzZx90tw1ta2VF+6uXeWFI80SUNA5ntJ7?=
 =?us-ascii?Q?Sp1aH8zSAi5Q7Is6quc/29eWptqLSJRpqlaOUASlD/ZHUAKgnRX4bUIEYJdy?=
 =?us-ascii?Q?b5ojI1L3VR7CHZkjckUT+G2hxpNpt7dltO4qlvF3QtYbF7hWhpzLpiW8DkXv?=
 =?us-ascii?Q?key7xKAqlxe0OvMXIg5GDxvvgyJft5mO8lHjnQkeLFYjr/Lb9yvWr012W+aN?=
 =?us-ascii?Q?pJehzEDCc4M15ZUERzaMiVyoA868/DaDkkji0YBSLlx0GI2GuvfCnMJaONpt?=
 =?us-ascii?Q?BQKbhRhoO3gdLM4EKPf901UVEk9MZOHLYJuavqy13/VprqbJPtdxdWFXRhQq?=
 =?us-ascii?Q?dnt0ikv14IWLLQIysUeQWAM25IMB66WQnQDyAjIGqcEDu+tt3/oNSrhdmT3V?=
 =?us-ascii?Q?mP6B6RjwI3kGX8CuyG70ROrqO2Ml3KyT9x4N+KEttG89XrK5Dsr2CRXi41KF?=
 =?us-ascii?Q?EuooftEMbWLGrlzxgh+vPBxrFr5vxUWaj0L7NMy+Nz4nRlmbjTPSy1KM1sfl?=
 =?us-ascii?Q?HI10NEAKRtFsLUQDbImMGrIgr39VBmrVLWn0v5IcMdZIylS+5H00dij4+AzK?=
 =?us-ascii?Q?j8piSZFAf+1YoeNV8/+0CvI0UNx3T/hF95eVPFkh8omAUjozcFzrDuxQ5UQZ?=
 =?us-ascii?Q?/0Uf9qyHo/PUwE7AFIP+xF1Rff2W3/1qZ9TwrNqoSNMJBKyF/je9qSFH3lvu?=
 =?us-ascii?Q?MRZKRf8gFv9bmrXbhNFoXsMeVB1CLftUEKow8rFnolhSLl0SVYEHRCUtQz7z?=
 =?us-ascii?Q?822FcTNdmJQgiBqstjbQo4KA6WAaC8gIfvql4sefCQlREH0Z1R3aj49m6Cef?=
 =?us-ascii?Q?OZs1AOG9yKUzK6M76Bxcdt3c9COJf+q6BB0AEfjKha9suV1BvvhSjvz1KoBn?=
 =?us-ascii?Q?GZEIfk1KnplfASWetAEZAxn6aXjHoEM8E3vJhOlzdECvsFnU3u8fwYYjWFgj?=
 =?us-ascii?Q?j76sGimzwGGGNCqgLMdeYJeFEOxFbiUzf5O6r/x1Rp4s6cDJ0/cxtqlC72+E?=
 =?us-ascii?Q?PUf6kEGDog=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e48241-9379-43ef-044b-08da298a1b73
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 02:43:56.8938 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gb4SPDNcVZyvxRdAS/F9wY0t1wI/PKcVqdrElteHR4hZHXAtdm2pTKLx+UcFTTwF/jVs+7kBDbnROyLIj7OLqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3552
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, April 29, 2022 06:12
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/5] drm/amdgpu/psp: drop load/unload/init_shared_buf wrapp=
ers

Just call the load/unload/init_shared_buf functions directly.  Makes the co=
de easier to follow.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 143 ++++--------------------
 1 file changed, 21 insertions(+), 122 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 0787f2e36f2a..e9dc83641c71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -866,11 +866,6 @@ static int psp_rl_load(struct amdgpu_device *adev)
        return ret;
 }

-static int psp_asd_load(struct psp_context *psp) -{
-       return psp_ta_load(psp, &psp->asd_context);
-}
-
 static int psp_asd_initialize(struct psp_context *psp)  {
        int ret;
@@ -886,7 +881,7 @@ static int psp_asd_initialize(struct psp_context *psp)
        psp->asd_context.mem_context.shared_mem_size =3D PSP_ASD_SHARED_MEM=
_SIZE;
        psp->asd_context.ta_load_type                =3D GFX_CMD_ID_LOAD_AS=
D;

-       ret =3D psp_asd_load(psp);
+       ret =3D psp_ta_load(psp, &psp->asd_context);
        if (!ret)
                psp->asd_context.initialized =3D true;

@@ -914,11 +909,6 @@ int psp_ta_unload(struct psp_context *psp, struct ta_c=
ontext *context)
        return ret;
 }

-static int psp_asd_unload(struct psp_context *psp) -{
-       return psp_ta_unload(psp, &psp->asd_context);
-}
-
 static int psp_asd_terminate(struct psp_context *psp)  {
        int ret;
@@ -929,8 +919,7 @@ static int psp_asd_terminate(struct psp_context *psp)
        if (!psp->asd_context.initialized)
                return 0;

-       ret =3D psp_asd_unload(psp);
-
+       ret =3D psp_ta_unload(psp, &psp->asd_context);
        if (!ret)
                psp->asd_context.initialized =3D false;

@@ -1002,11 +991,6 @@ void psp_ta_free_shared_buf(struct ta_mem_context *me=
m_ctx)
                              &mem_ctx->shared_buf);
 }

-static int psp_xgmi_init_shared_buf(struct psp_context *psp) -{
-       return psp_ta_init_shared_buf(psp, &psp->xgmi_context.context.mem_c=
ontext);
-}
-
 static void psp_prep_ta_invoke_indirect_cmd_buf(struct psp_gfx_cmd_resp *c=
md,
                                       uint32_t ta_cmd_id,
                                       struct ta_context *context)
@@ -1097,16 +1081,6 @@ int psp_ta_load(struct psp_context *psp, struct ta_c=
ontext *context)
        return ret;
 }

-static int psp_xgmi_load(struct psp_context *psp) -{
-       return psp_ta_load(psp, &psp->xgmi_context.context);
-}
-
-static int psp_xgmi_unload(struct psp_context *psp) -{
-       return psp_ta_unload(psp, &psp->xgmi_context.context);
-}
-
 int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id)  {
        return psp_ta_invoke(psp, ta_cmd_id, &psp->xgmi_context.context); @=
@ -1126,7 +1100,7 @@ int psp_xgmi_terminate(struct psp_context *psp)
        if (!psp->xgmi_context.context.initialized)
                return 0;

-       ret =3D psp_xgmi_unload(psp);
+       ret =3D psp_ta_unload(psp, &psp->xgmi_context.context);
        if (ret)
                return ret;

@@ -1155,13 +1129,13 @@ int psp_xgmi_initialize(struct psp_context *psp, bo=
ol set_extended_data, bool lo
        psp->xgmi_context.context.ta_load_type =3D GFX_CMD_ID_LOAD_TA;

        if (!psp->xgmi_context.context.initialized) {
-               ret =3D psp_xgmi_init_shared_buf(psp);
+               ret =3D psp_ta_init_shared_buf(psp,
+&psp->xgmi_context.context.mem_context);
                if (ret)
                        return ret;
        }

        /* Load XGMI TA */
-       ret =3D psp_xgmi_load(psp);
+       ret =3D psp_ta_load(psp, &psp->xgmi_context.context);
        if (!ret)
                psp->xgmi_context.context.initialized =3D true;
        else
@@ -1384,21 +1358,6 @@ int psp_xgmi_set_topology_info(struct psp_context *p=
sp,  }

 // ras begin
-static int psp_ras_init_shared_buf(struct psp_context *psp) -{
-       return psp_ta_init_shared_buf(psp, &psp->ras_context.context.mem_co=
ntext);
-}
-
-static int psp_ras_load(struct psp_context *psp) -{
-       return psp_ta_load(psp, &psp->ras_context.context);
-}
-
-static int psp_ras_unload(struct psp_context *psp) -{
-       return psp_ta_unload(psp, &psp->ras_context.context);
-}
-
 static void psp_ras_ta_check_status(struct psp_context *psp)  {
        struct ta_ras_shared_memory *ras_cmd =3D @@ -1506,7 +1465,7 @@ int =
psp_ras_terminate(struct psp_context *psp)
        if (!psp->ras_context.context.initialized)
                return 0;

-       ret =3D psp_ras_unload(psp);
+       ret =3D psp_ta_unload(psp, &psp->ras_context.context);
        if (ret)
                return ret;

@@ -1582,7 +1541,7 @@ static int psp_ras_initialize(struct psp_context *psp=
)
        psp->ras_context.context.ta_load_type =3D GFX_CMD_ID_LOAD_TA;

        if (!psp->ras_context.context.initialized) {
-               ret =3D psp_ras_init_shared_buf(psp);
+               ret =3D psp_ta_init_shared_buf(psp,
+&psp->ras_context.context.mem_context);
                if (ret)
                        return ret;
        }
@@ -1595,7 +1554,7 @@ static int psp_ras_initialize(struct psp_context *psp=
)
        if (!adev->gmc.xgmi.connected_to_cpu)
                ras_cmd->ras_in_message.init_flags.dgpu_mode =3D 1;

-       ret =3D psp_ras_load(psp);
+       ret =3D psp_ta_load(psp, &psp->ras_context.context);

        if (!ret && !ras_cmd->ras_status)
                psp->ras_context.context.initialized =3D true; @@ -1642,16 =
+1601,6 @@ int psp_ras_trigger_error(struct psp_context *psp,  // ras end

 // HDCP start
-static int psp_hdcp_init_shared_buf(struct psp_context *psp) -{
-       return psp_ta_init_shared_buf(psp, &psp->hdcp_context.context.mem_c=
ontext);
-}
-
-static int psp_hdcp_load(struct psp_context *psp) -{
-       return psp_ta_load(psp, &psp->hdcp_context.context);
-}
-
 static int psp_hdcp_initialize(struct psp_context *psp)  {
        int ret;
@@ -1672,12 +1621,12 @@ static int psp_hdcp_initialize(struct psp_context *=
psp)
        psp->hdcp_context.context.ta_load_type =3D GFX_CMD_ID_LOAD_TA;

        if (!psp->hdcp_context.context.initialized) {
-               ret =3D psp_hdcp_init_shared_buf(psp);
+               ret =3D psp_ta_init_shared_buf(psp,
+&psp->hdcp_context.context.mem_context);
                if (ret)
                        return ret;
        }

-       ret =3D psp_hdcp_load(psp);
+       ret =3D psp_ta_load(psp, &psp->hdcp_context.context);
        if (!ret) {
                psp->hdcp_context.context.initialized =3D true;
                mutex_init(&psp->hdcp_context.mutex);
@@ -1686,11 +1635,6 @@ static int psp_hdcp_initialize(struct psp_context *p=
sp)
        return ret;
 }

-static int psp_hdcp_unload(struct psp_context *psp) -{
-       return psp_ta_unload(psp, &psp->hdcp_context.context);
-}
-
 int psp_hdcp_invoke(struct psp_context *psp, uint32_t ta_cmd_id)  {
        /*
@@ -1719,7 +1663,7 @@ static int psp_hdcp_terminate(struct psp_context *psp=
)
                        return 0;
        }

-       ret =3D psp_hdcp_unload(psp);
+       ret =3D psp_ta_unload(psp, &psp->hdcp_context.context);
        if (ret)
                return ret;

@@ -1734,16 +1678,6 @@ static int psp_hdcp_terminate(struct psp_context *ps=
p)  // HDCP end

 // DTM start
-static int psp_dtm_init_shared_buf(struct psp_context *psp) -{
-       return psp_ta_init_shared_buf(psp, &psp->dtm_context.context.mem_co=
ntext);
-}
-
-static int psp_dtm_load(struct psp_context *psp) -{
-       return psp_ta_load(psp, &psp->dtm_context.context);
-}
-
 static int psp_dtm_initialize(struct psp_context *psp)  {
        int ret;
@@ -1764,12 +1698,12 @@ static int psp_dtm_initialize(struct psp_context *p=
sp)
        psp->dtm_context.context.ta_load_type =3D GFX_CMD_ID_LOAD_TA;

        if (!psp->dtm_context.context.initialized) {
-               ret =3D psp_dtm_init_shared_buf(psp);
+               ret =3D psp_ta_init_shared_buf(psp,
+&psp->dtm_context.context.mem_context);
                if (ret)
                        return ret;
        }

-       ret =3D psp_dtm_load(psp);
+       ret =3D psp_ta_load(psp, &psp->dtm_context.context);
        if (!ret) {
                psp->dtm_context.context.initialized =3D true;
                mutex_init(&psp->dtm_context.mutex);
@@ -1778,11 +1712,6 @@ static int psp_dtm_initialize(struct psp_context *ps=
p)
        return ret;
 }

-static int psp_dtm_unload(struct psp_context *psp) -{
-       return psp_ta_unload(psp, &psp->dtm_context.context);
-}
-
 int psp_dtm_invoke(struct psp_context *psp, uint32_t ta_cmd_id)  {
        /*
@@ -1811,7 +1740,7 @@ static int psp_dtm_terminate(struct psp_context *psp)
                        return 0;
        }

-       ret =3D psp_dtm_unload(psp);
+       ret =3D psp_ta_unload(psp, &psp->dtm_context.context);
        if (ret)
                return ret;

@@ -1826,21 +1755,6 @@ static int psp_dtm_terminate(struct psp_context *psp=
)  // DTM end

 // RAP start
-static int psp_rap_init_shared_buf(struct psp_context *psp) -{
-       return psp_ta_init_shared_buf(psp, &psp->rap_context.context.mem_co=
ntext);
-}
-
-static int psp_rap_load(struct psp_context *psp) -{
-       return psp_ta_load(psp, &psp->rap_context.context);
-}
-
-static int psp_rap_unload(struct psp_context *psp) -{
-       return psp_ta_unload(psp, &psp->rap_context.context);
-}
-
 static int psp_rap_initialize(struct psp_context *psp)  {
        int ret;
@@ -1862,12 +1776,12 @@ static int psp_rap_initialize(struct psp_context *p=
sp)
        psp->rap_context.context.ta_load_type =3D GFX_CMD_ID_LOAD_TA;

        if (!psp->rap_context.context.initialized) {
-               ret =3D psp_rap_init_shared_buf(psp);
+               ret =3D psp_ta_init_shared_buf(psp,
+&psp->rap_context.context.mem_context);
                if (ret)
                        return ret;
        }

-       ret =3D psp_rap_load(psp);
+       ret =3D psp_ta_load(psp, &psp->rap_context.context);
        if (!ret) {
                psp->rap_context.context.initialized =3D true;
                mutex_init(&psp->rap_context.mutex);
@@ -1894,7 +1808,7 @@ static int psp_rap_terminate(struct psp_context *psp)
        if (!psp->rap_context.context.initialized)
                return 0;

-       ret =3D psp_rap_unload(psp);
+       ret =3D psp_ta_unload(psp, &psp->rap_context.context);

        psp->rap_context.context.initialized =3D false;

@@ -1940,22 +1854,6 @@ int psp_rap_invoke(struct psp_context *psp, uint32_t=
 ta_cmd_id, enum ta_rap_stat  // RAP end

 /* securedisplay start */
-static int psp_securedisplay_init_shared_buf(struct psp_context *psp) -{
-       return psp_ta_init_shared_buf(
-               psp, &psp->securedisplay_context.context.mem_context);
-}
-
-static int psp_securedisplay_load(struct psp_context *psp) -{
-       return psp_ta_load(psp, &psp->securedisplay_context.context);
-}
-
-static int psp_securedisplay_unload(struct psp_context *psp) -{
-       return psp_ta_unload(psp, &psp->securedisplay_context.context);
-}
-
 static int psp_securedisplay_initialize(struct psp_context *psp)  {
        int ret;
@@ -1978,12 +1876,13 @@ static int psp_securedisplay_initialize(struct psp_=
context *psp)
        psp->securedisplay_context.context.ta_load_type =3D GFX_CMD_ID_LOAD=
_TA;

        if (!psp->securedisplay_context.context.initialized) {
-               ret =3D psp_securedisplay_init_shared_buf(psp);
+               ret =3D psp_ta_init_shared_buf(psp,
+                                            &psp->securedisplay_context.co=
ntext.mem_context);
                if (ret)
                        return ret;
        }

-       ret =3D psp_securedisplay_load(psp);
+       ret =3D psp_ta_load(psp, &psp->securedisplay_context.context);
        if (!ret) {
                psp->securedisplay_context.context.initialized =3D true;
                mutex_init(&psp->securedisplay_context.mutex);
@@ -2022,7 +1921,7 @@ static int psp_securedisplay_terminate(struct psp_con=
text *psp)
        if (!psp->securedisplay_context.context.initialized)
                return 0;

-       ret =3D psp_securedisplay_unload(psp);
+       ret =3D psp_ta_unload(psp, &psp->securedisplay_context.context);
        if (ret)
                return ret;

--
2.35.1

