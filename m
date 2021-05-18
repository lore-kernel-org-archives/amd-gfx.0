Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D475AC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 17:50:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9383461154
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 17:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9383461154
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0D336EC53;
	Tue, 18 May 2021 17:50:04 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2083.outbound.protection.outlook.com [40.107.212.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93AE36EC53
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 17:50:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxYEp63TheRODgKh9fbiZbxI5mhmAe2n2V/xFQfR1mxtvzhYLG4TAbAoCIqHKd8BEPMxWLnE8Mm6kLh8ko83iQRDOWXDawKqqJJDY/DRsD1T+H2KiB8pO2uM0ZDRoE0/J17OQLZzTSO3Kc/2moNR5g043QTxIPYpDak9SxbOuWytZj2sdg8k5A55DL0i2+uYvAmP+JV7DhA6v7nCPR2VHyJZDvqmFinxP+fR/aDkIVscBtzr2ZgqOnskfyjlm6+ZKFTZlzm0iz9Y8O167vX9jGapCnKqpoQqVJXc4qlyiIdZJTB8W8/Kq3082q9DbAO3vi4l1efqXN9dXBiNarucxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tkgSUTuzVWAwOkG15tM+5HKfUhQg9SltzPvy87PBwk=;
 b=PZqyaknpzS8ZDypNDWSqZkaHwTp3ntPkz0QAyP79LRGrgeZ3asO4olMHd3SfirZBlJams6YFW35HjjeVqg22/SelM4HXz3mckQNoXw7e/+7Axz1QO0q+noomX/P/HF27Sfldbi07/j3jpPTKZQJ4Gl0fomGFTqeYeh5B75sCVRdb0/TYciOiJRpk3+Q7P04uV2wlbr9B/TiXbYs1iQaNNa4fKUxigleUWXL2O1/WqzlW0Q51EwHGvJMDb+A7eAEDdPxgEB3UT0x5TH+ROOPGCCCaGy6eKM7whu9mmx00HudY+wj78VGJftbbQQWBXbiXnmg1ZRs9bt8j3fYn81mtBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tkgSUTuzVWAwOkG15tM+5HKfUhQg9SltzPvy87PBwk=;
 b=i6jJ2+q8MB8ih++BdKx+hoDL1+T1cgN0nVnYrxQmYdzqDkuZuB6fZpImebA7EVRBYC4xS2W+oNtQmRLC/VnxbilT7U4s02iLo98MfFpdG7ejYFMYiWfafqBLWioHRLS6mCCtgogylWfJxhceybtGp2m+QBrSfw2VqduOHk6/m3s=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Tue, 18 May
 2021 17:49:59 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 17:49:59 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Zhu, James" <James.Zhu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: stop touching sched.ready in the backend
Thread-Topic: [PATCH] drm/amdgpu: stop touching sched.ready in the backend
Thread-Index: AQHXS/2ct0xIalWpL0ak1EHxAziO3KrphF5n
Date: Tue, 18 May 2021 17:49:59 +0000
Message-ID: <MN2PR12MB4488B84BB7AD1F45B127D2CCF72C9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210518155058.5646-1-christian.koenig@amd.com>
In-Reply-To: <20210518155058.5646-1-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-05-18T17:49:58.799Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [204.111.139.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6af5c5fe-2ba7-4957-391d-08d91a255b15
x-ms-traffictypediagnostic: MN2PR12MB4269:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB426984026285DADA03E54747F72C9@MN2PR12MB4269.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FOe/PQ8e9Kupp2YNyzmrqqdQL3s9b7StW7P3WGYblMu6TCi5WGOQPGnLn2iBFkAZ/sM9fYR5kd/WqnAq9p0GfnhDKVa2XiGNSveKo8LZIvOKR2v0dO0Q20FU7zhaasWY9iHUCIKesUe4I/5ij5mb0h7dOCI4n3jnbcTIZuStGv6xMKls1cek96qX8CT/j4uJBib+W43WQDgucxjwBcE7ME7bRx6It2dCyulu+HjCCV6Fws05xJxfGaMGBcngdx3eIaipoeK2FFtxpo0TVL7aEhCMcBUZEPvfYwnb+xuURgYC16wHUUiMq97SvqQ+GQ1XRz1YW39KxyoZ85US3qyaD0bgmlpfTGPeX+QTIkt9/PCxPjL7C/q3lvFKrfAbwgg/TSfRMn7Z4BycLCPYsb5vLmYRYopPri+0ZXlNpZPOE3PrG6+cwZc4SMpFEeQyGNTSayjX/y1yeEnmKNPpXkT+m0ONYMlBJkK5OV8E/baiQhTMmFURnOSj0Av9tR8itg/uQ1zDwVEc/DWtoZJnEfVKpv6daOSbjuVPPz9B01uOI5vXXVROdAmWcI7arvYN27yC57OBxODNf+uzaiJml1FTJuTflSUPoqmyRulIzXpYzqNOAYJoJx474ITDWGFOVi2LNyfGGFlxJJ7Zj6JsfAZ2vw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(53546011)(52536014)(6506007)(38100700002)(19627405001)(76116006)(83380400001)(4326008)(26005)(122000001)(86362001)(71200400001)(9686003)(7696005)(66946007)(166002)(55016002)(110136005)(45080400002)(66446008)(8936002)(64756008)(5660300002)(478600001)(2906002)(966005)(66476007)(8676002)(316002)(66556008)(6636002)(186003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?rQOR1dkREeRV+Cvckow7L/9OptaiS1SEnl9c1TwI1qzJV8xYmrQAMV0PM9?=
 =?iso-8859-1?Q?kIoesbRsOr9TsCoXY2r/Y09/GSFk9wPdTw4fW0YbEEHpQqFvad5DKV5ygK?=
 =?iso-8859-1?Q?xqFRcINNx1eLPOX/Ypi1/Flk6NfeUUUIkZAzi5qTtpcB39nOaCLUf98/LL?=
 =?iso-8859-1?Q?AZHT1rHFd/xHGllmqOPfE6b9TxDLhGTjqGYjYIIm0+e2K6ISwCkvO6a3fg?=
 =?iso-8859-1?Q?H7EUUzVupvKtnOj47075oNWlz++bT9oGDBpG09FQtZS2MIqdxaAS+KZkns?=
 =?iso-8859-1?Q?wFoKlSpbOPTbW2zYI8D40L+L+Li+8nqUClpJpii0CuwXzRX1cpZpD/aBlH?=
 =?iso-8859-1?Q?5y+OS4xCFZ5ZnwGh4zq7MLzKa9VRqpaB8o+mrOJijNPPy2qYzhxGZiqpsH?=
 =?iso-8859-1?Q?ix6qzueYa6L5JG3dIwL8kC6GQR/9THTDiQ3dzbuozkKfS4mMX0tJ2DZCYB?=
 =?iso-8859-1?Q?ZdQz7lf7lgGoCPXpRunTN6XdEZvNp98LaB5mNNTGGAoYmKXHs8NEG2Xfa6?=
 =?iso-8859-1?Q?YzGDmcMPDz6p4GsVhxsPZdqCiw/LSGf4Sobov7Tb/EEAChKRWpwsTFwZOh?=
 =?iso-8859-1?Q?OuT7jkS4hscQrXV5slzTYfuOxUfAaWYi1WT60DnKDEUqEhTJWDH5JY7wzI?=
 =?iso-8859-1?Q?BT654aLX3Kz9gHQiPqLlHp2yHjfCcoMJre/ifmimRzgFcwWvizVR2IkyDl?=
 =?iso-8859-1?Q?L5thSCK4WF1TS4Sh3amLNeIPzKx9ipeVahcm+YBUg1hL21V9R6XzURlWTl?=
 =?iso-8859-1?Q?N3dYfh7e7I/fPYZHdWD9HHKBJ9rEj1mwyZ85ydL0bd2B4Pae629XOvg64E?=
 =?iso-8859-1?Q?Axue+jhFSBZQ5+wDoREj95RfMrjGLGb8pFODUUh0t/Tj78SLL7mQ47FW2g?=
 =?iso-8859-1?Q?mlnFoOvoHvVE2dUrmj6Mmd1hljoBhzhdUEKt+3132Qk58I/gHRGTMWO64W?=
 =?iso-8859-1?Q?Rzk+naPXzmCRfyuy2e1obr392kyttqv+XRXS1nDGocgUpRhRHn2cZEAzHa?=
 =?iso-8859-1?Q?umJqbT06F/tVMdXyvLXNGzJbFtMKo7OWqGTt1EzOc4j4kMS8bYzCsk5I11?=
 =?iso-8859-1?Q?/jK/FAZx0ixfMLZUAC0ieV68WiTnlCPdZGlDXa+fRNe/cBHmzfSRyADUgA?=
 =?iso-8859-1?Q?SxIVy3rEbxV4suWv7yJ89JDYeQfGe22/kuiDEu7p5hnOTc9nbweKcwhp7c?=
 =?iso-8859-1?Q?EXIKul3PRPDRC2AgaSkpVOwAz6PplbNvk6ZI19Q3bLfA52/ST+aoXWOFLK?=
 =?iso-8859-1?Q?87EUcixoZE/CALDAOlgmeFWV7YG2FtiO1ABX6oNWL8ceNWnfkqFfHS7gk2?=
 =?iso-8859-1?Q?TPgtODjVcfgIQFHipNRU1RnEIgfrjgXzsSR51gTs510TQBfv1Fl/VLgjJD?=
 =?iso-8859-1?Q?v1n1/GQKdE?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af5c5fe-2ba7-4957-391d-08d91a255b15
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2021 17:49:59.3138 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nBfBIKrr/7LG16XAIpeunDYt8etYTZOQAPWW6HNf4so0NQZ2sAn2Kuh5KqBwRAXK4O8rFld7+oqWGEtwP+deaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============2059698867=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2059698867==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488B84BB7AD1F45B127D2CCF72C9MN2PR12MB4488namp_"

--_000_MN2PR12MB4488B84BB7AD1F45B127D2CCF72C9MN2PR12MB4488namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Tuesday, May 18, 2021 11:50 AM
To: Zhu, James <James.Zhu@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: stop touching sched.ready in the backend

This unfortunately comes up in regular intervals and breaks
GPU reset for the engine in question.

The sched.ready flag controls if an engine can't get working
during hw_init, but should never be set to false during hw_fini.

Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 2 --
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 2 --
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 5 -----
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c  | 6 ------
 4 files changed, 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/a=
mdgpu/jpeg_v2_5.c
index 83531997aeba..938ef4ce5b76 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -198,8 +198,6 @@ static int jpeg_v2_5_hw_fini(void *handle)
                 if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
                       RREG32_SOC15(JPEG, i, mmUVD_JRBC_STATUS))
                         jpeg_v2_5_set_powergating_state(adev, AMD_PG_STATE=
_GATE);
-
-               ring->sched.ready =3D false;
         }

         return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/a=
mdgpu/jpeg_v3_0.c
index de5dfcfb3859..94be35357f7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -166,8 +166,6 @@ static int jpeg_v3_0_hw_fini(void *handle)
               RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
                 jpeg_v3_0_set_powergating_state(adev, AMD_PG_STATE_GATE);

-       ring->sched.ready =3D false;
-
         return 0;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c
index 7c4e0586e26d..2d5d07c80307 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -497,11 +497,6 @@ static void sdma_v5_2_gfx_stop(struct amdgpu_device *a=
dev)
                 ib_cntl =3D REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_E=
NABLE, 0);
                 WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CN=
TL), ib_cntl);
         }
-
-       sdma0->sched.ready =3D false;
-       sdma1->sched.ready =3D false;
-       sdma2->sched.ready =3D false;
-       sdma3->sched.ready =3D false;
 }

 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c
index cf165ab5dd26..b512acf0e95f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -388,12 +388,6 @@ static int vcn_v3_0_hw_fini(void *handle)
                                 vcn_v3_0_set_powergating_state(adev, AMD_P=
G_STATE_GATE);
                         }
                 }
-               ring->sched.ready =3D false;
-
-               for (j =3D 0; j < adev->vcn.num_enc_rings; ++j) {
-                       ring =3D &adev->vcn.inst[i].ring_enc[j];
-                       ring->sched.ready =3D false;
-               }
         }

         return 0;
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C78a0f564e73c4efd395308d91a14bddf%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637569498651314067%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DpM8%2B5Vp5bU4GkxbEVmm%2FfNBo9TBVNLSNjGnynfnNbn8%3D&amp;reserved=3D0

--_000_MN2PR12MB4488B84BB7AD1F45B127D2CCF72C9MN2PR12MB4488namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Christian K=F6nig &lt;ckoenig=
.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Tuesday, May 18, 2021 11:50 AM<br>
<b>To:</b> Zhu, James &lt;James.Zhu@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: stop touching sched.ready in the backen=
d</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This unfortunately comes up in regular intervals a=
nd breaks<br>
GPU reset for the engine in question.<br>
<br>
The sched.ready flag controls if an engine can't get working<br>
during hw_init, but should never be set to false during hw_fini.<br>
<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 2 --<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 2 --<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 5 -----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c&nbsp; | 6 ------<br>
&nbsp;4 files changed, 15 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/a=
mdgpu/jpeg_v2_5.c<br>
index 83531997aeba..938ef4ce5b76 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c<br>
@@ -198,8 +198,6 @@ static int jpeg_v2_5_hw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;jpeg.cur_state !=3D AMD_PG_STATE_GATE &a=
mp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RREG32_SOC15(JPEG=
, i, mmUVD_JRBC_STATUS))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; jpeg_=
v2_5_set_powergating_state(adev, AMD_PG_STATE_GATE);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ring-&gt;sched.ready =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/a=
mdgpu/jpeg_v3_0.c<br>
index de5dfcfb3859..94be35357f7d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c<br>
@@ -166,8 +166,6 @@ static int jpeg_v3_0_hw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; jpeg_v3_0_set_powergating_state(adev, AMD_PG_STATE_GA=
TE);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready =3D false;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c<br>
index 7c4e0586e26d..2d5d07c80307 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c<br>
@@ -497,11 +497,6 @@ static void sdma_v5_2_gfx_stop(struct amdgpu_device *a=
dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ib_cntl =3D REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL,=
 IB_ENABLE, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_=
IB_CNTL), ib_cntl);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma0-&gt;sched.ready =3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma1-&gt;sched.ready =3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma2-&gt;sched.ready =3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma3-&gt;sched.ready =3D false;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c<br>
index cf165ab5dd26..b512acf0e95f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
@@ -388,12 +388,6 @@ static int vcn_v3_0_hw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_v3_0_set_powergating_state(a=
dev, AMD_PG_STATE_GATE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ring-&gt;sched.ready =3D false;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (j =3D 0; j &lt; adev-&gt;vcn.num_enc_rings; ++j) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =3D &amp;ad=
ev-&gt;vcn.inst[i].ring_enc[j];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;sched.r=
eady =3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C78a0f564e73c4efd395308d91a14bddf%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637569498651314067%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DpM8%2B5Vp5bU4GkxbEVmm%2FfNBo9TBVNLSNjGnynfnNbn8%3D&a=
mp;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3D=
https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;=
data=3D04%7C01%7Calexander.deucher%40amd.com%7C78a0f564e73c4efd395308d91a14=
bddf%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637569498651314067%7CUnkn=
own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV=
CI6Mn0%3D%7C1000&amp;amp;sdata=3DpM8%2B5Vp5bU4GkxbEVmm%2FfNBo9TBVNLSNjGnynf=
nNbn8%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488B84BB7AD1F45B127D2CCF72C9MN2PR12MB4488namp_--

--===============2059698867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2059698867==--
