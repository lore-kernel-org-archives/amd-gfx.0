Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A6CEE57DF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Sep 2023 07:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2683210E11E;
	Mon, 11 Sep 2023 07:58:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87A8110E11E
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Sep 2023 07:58:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YatmcpccKxgIDownHpAk8FVZIM0wyRslW40p9joLSSFrPB+i95OkwFeAx67HzOoC6CKBgiPCyaJEXHaqTikYnSIiiFjiPsoCQH5MJiifaaZtVDyqOLS/o0qGd6kLKhpxWRbP4ScWcraZCdc4Jthpm/P5rEF9iFN5e2d/4xTmJxHddJi+eKDRw/icMQ3vGpY5V7CSDL0UVnShAoMWkYIenWggofSTG0vfSXzxn22bcVnLQeMFci18YwodAsJu7r2L+SU3X4x9QADvGze8gRR8GgnYoT07Z3wCcKB8Ty2PbgsipFPEE0GHxz8fmIYMQbHUn5sGRxaL1Zu+G3cwYlNLSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoBxVUo0HxJMiyv/DGWZSKb38PMmADfoPodFCQ2Qr2g=;
 b=H0G6rj5jjHrZ3c3LMGkiVvop+klBCSAnYrVr1X2IZnfDCiQG1J4LqiF2xyJlXbHG+2z3/AoshgYRTk2VdQoQGpasMF1QixCCRffgdWCBaAXpoRW7QLc7/B7WYtsWJQ0SAY3B4fSKCXBiwLVw0M1UJam0a8vTxrX92ebEQlj7bRmIEBejbpz4p5tGB13xa7z4oA7Y53r6Mkm7mt3cQiMNDsVE9PcSiuS1CXHRwxUkMQlr4slf5rxWuH950lOJRAgzAMRLClQyYFTZqfkSaRDa42oLmafnh2x3cUDK5w1SDGeYihPOb1PpBH5Y7SUeBAmXbHiAtwLJXIC+EL0qNgLD7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoBxVUo0HxJMiyv/DGWZSKb38PMmADfoPodFCQ2Qr2g=;
 b=t0tuUsWjGbzIbAY5yCXEMcxBhQORildiaRILQE5a4//IrtaxqTJqJJS8W5/hUWP69HHU1AtS97GoymGqT7Ti0KfKY5U3JPlvCa46jBn3nEYVKcJbn93s6WnMwVFdeO68p3fXpjzE0t16HZ3XzFIDc1wYDPv/Xrj7MnoPXKaSUP8=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 07:58:12 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::c363:292a:63cc:ccf4]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::c363:292a:63cc:ccf4%3]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 07:58:11 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Restore partition mode after reset
Thread-Topic: [PATCH] drm/amdgpu: Restore partition mode after reset
Thread-Index: AQHZ4kDTk5SElkr9JkS25pLHCwdjhbAVRi0Q
Date: Mon, 11 Sep 2023 07:58:11 +0000
Message-ID: <DS7PR12MB60715D9BCBE7B13A3C3DF00C8EF2A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20230908103942.995604-1-lijo.lazar@amd.com>
In-Reply-To: <20230908103942.995604-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=587420c3-dd11-448f-9ea7-1c2fc59637c9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-11T07:55:33Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|IA1PR12MB6307:EE_
x-ms-office365-filtering-correlation-id: 77e5246b-8e92-46b8-5062-08dbb29cd813
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kCZNF3oGUCpyyFD/SMrXG+0v9HvyBje0/+6IHAlFV+LE1vz04Rq8FnTFjHyI8BJx1emDJoIi/tzZIgJpGIfhDEfYWgJ1UzVBZNqwme0pUp6EuM0PYhMAChPMqgJc+3XehqnkRWNZXaOpL6SAa1cbKp9LalinyNLy84Mai4Q5upISoFmj1lVkIOdk5l0MxTZhY2IbdqbgnKxGGxJClxEYXuMXoP7NSRdAjpbM1QMeQDPR9r/TMEE8Umwk5YuFfYUHdudpwTNKss+ZyJRbwv4VQbuNbgo7Dhl5ppoti+DUGIC3FteSnSWnMED9MqMtb6ti/pQf88TdpMDSZzjnF4KZHHcB5Wm4ho6up0lAymiaRo03dK98bjTm4taIX1l9+ehQhyQPzSDgcKvHe1Y79SdQ7zLeQcU/Z26Vfcz5nQEHb2ZIMr8llt7INiwPK+aZtMaEgihWhk/l5ZZxLW0O3iqX6fiZrsSgclsyI+DkuOdJKexBuyArftPuEGDZ+ZWkoDe1U9Z9s8f/s/SYAKZ3O4X3lH/cjyM4yx9xXpviJAMQjO/500B8g5sX740svDKjeaA8h5zgZY1Kk0GxgDt4pwfKxZQ8EJ0p2I75Z06ekLmUah2IvXIIxTxd0xQ63wGSiNo4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(396003)(376002)(136003)(346002)(1800799009)(451199024)(186009)(8676002)(8936002)(4326008)(41300700001)(110136005)(66556008)(54906003)(64756008)(52536014)(5660300002)(66476007)(76116006)(316002)(66946007)(66446008)(2906002)(122000001)(38070700005)(38100700002)(83380400001)(55016003)(9686003)(53546011)(26005)(86362001)(33656002)(71200400001)(6506007)(478600001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VMLX39fKKB+2dkYqZf9aqWPbHptkna+uj5ch5290lMucA6Yth+7p4ZEunxER?=
 =?us-ascii?Q?Nmbbe536meT7EUYR46IqeurzHA5Y4mPcU4s3Mfe7HwBOMOeUBtQnLDaxoHv1?=
 =?us-ascii?Q?7DVDUAhBeFYif8tnBtua7R7qvHXNjeZJktmvJjdObwjFJPtNjbrzMtTHpJ/m?=
 =?us-ascii?Q?P71oLiMVIUBlUs+WtX8mfpRJFTjBOrnoz/SrFEHYqt8LSo7e25KF/S7NHWne?=
 =?us-ascii?Q?mBNqx+8e5iy6WdvCIg/CJYPmOe20SXpJhd+5aYZhJtnoh2iZll0/sw2CCHHR?=
 =?us-ascii?Q?rCq1TftN9uv5jE5QLRitpiVp7aKcAG+fqO+xgJHFNhWyeuLFtET5jIAY7bBC?=
 =?us-ascii?Q?IbiknYuMZvb95mn9aupDVVpr3RV2HH4D91ay817L0hBmcuIzIJf309Zog4Td?=
 =?us-ascii?Q?3uhD69l7CcZPtGAtNcPYHAVyk3QXNEFO+D+7eJwjZjze1RaLT/yAEhJMmwT7?=
 =?us-ascii?Q?nX+YKkIn3gjz88FKGFdxgyOosUoKUOFKj3QYqgglAXCUVr032FlYsDUhGhZf?=
 =?us-ascii?Q?vC5E/pAc/7LYg/rn2NHggldLd+UimxYdamej0UxSAvYAbEu4Fk4LDsV+K9dG?=
 =?us-ascii?Q?JhiwOj1vi7RkGqzU7Bx9ae/yT13wogcxYnJkHpB43lpjDcYtdWSxczjKOsVi?=
 =?us-ascii?Q?GtYcGY64vZ0gpUmit53Nihu6MV/Q75rfeyEC/+Bwlf9H6DnvKa0mj+ncStIv?=
 =?us-ascii?Q?z0o+drHwYrTuIbb1WKrvi0vZDJpSH+TOTeiQgMQBCv72RSSeLbbTeBs951zw?=
 =?us-ascii?Q?Ot+VYVeNpEVZ//TxihDv4Z36uOQt+76DecpC6hQdJxasvHhe4ehZJqpN6UCY?=
 =?us-ascii?Q?32FzgbbrrM1ADcbIDFHaJoCar3qkqVv1GQ7QVTJfD/c+ryE+ZI/ryN3vBqkA?=
 =?us-ascii?Q?sFWGVMaE6nYJnw9vzX1ABaPCZ8b8aqwXvdOUmlZkm/C64lss9RvWbypjjLdv?=
 =?us-ascii?Q?LjPBU06sNRxWwh8Z0m379JcQ0zm1KbAEnqs8OWkqhj3tIpQWNtZ2Rw11E1KC?=
 =?us-ascii?Q?aYQBSz5JhVTU434FFxtNASFls96sYRyJ12t8hpde/5uohYVWGF+NvXrdfkL1?=
 =?us-ascii?Q?8RV0VeSBtpF82QNbWNJeekbBZa5vS0d1hIHOG/t2MlwXSLsBZpA4HvEv8D6C?=
 =?us-ascii?Q?wlsHVsN2g6Ke/wTr5Q6KHze64rEMohd7Qikp3yvKktxnCyMJyJ9pqGgQEtnu?=
 =?us-ascii?Q?oYSaYxbRLXwhugQoTqbheAfzFW2vI5qioaGNHgE4bj+/XMcT00zMYJPCzy/l?=
 =?us-ascii?Q?hoafRLeaqqUJyuxdwoMEwH2da0eCdcs07HquFzqWdLMVMC0SfXJ3J3u5dw4P?=
 =?us-ascii?Q?SaPeaFeLEIs4yrSKuuHn6jJ3pw+RhfaGEn1vhvSWEA9ZeoHkqaRFPiGI7h1Q?=
 =?us-ascii?Q?CcQzfoQl1qDvrAPrO5bg70jO1jLbopGQuOW4xwRHye5HpCviQKIoZnaT/328?=
 =?us-ascii?Q?bn1Fe0kWnHB8QfCOr3Kwc9J8KT86dJ/dBON4uH4m/qzbfcmx/fUzy2p71iE5?=
 =?us-ascii?Q?DqA2hiEqyan9nBFHXxeLixwy/B+TjJBNu4xoPS2/9G5wN3Epj2j6ZTR74h94?=
 =?us-ascii?Q?TNaID8B320vaSuMVTwY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e5246b-8e92-46b8-5062-08dbb29cd813
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 07:58:11.2624 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U9w/7EjWE+Ej5pmTAMf7+Y9C7thgW6IjJgNI7F26/wa1ltw/UyK/vRgY2WgBKe3q9X7TZPQ+B4D4uX6BG7hy8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6307
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Tested-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, September 8, 2023 4:10 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Restore partition mode after reset

On a full device reset, PSP FW gets unloaded. Hence restore the partition m=
ode by placing a new request.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 28 ++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c |  2 +-
 4 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 5f32e8d4f3d3..5d2b6a7c5f6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5115,6 +5115,11 @@ int amdgpu_do_asic_reset(struct list_head *device_li=
st_handle,
                                if (r)
                                        return r;

+                               r =3D amdgpu_xcp_restore_partition_mode(
+                                       tmp_adev->xcp_mgr);
+                               if (r)
+                                       goto out;
+
                                r =3D amdgpu_device_ip_resume_phase2(tmp_ad=
ev);
                                if (r)
                                        goto out;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_xcp.c
index 565a1fa436d4..2b99eed5ba19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -163,16 +163,11 @@ int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, i=
nt num_xcps, int mode)
        return 0;
 }

-int amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, int m=
ode)
+static int __amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_m=
gr,
+                                             int mode)
 {
        int ret, curr_mode, num_xcps =3D 0;

-       if (!xcp_mgr || mode =3D=3D AMDGPU_XCP_MODE_NONE)
-               return -EINVAL;
-
-       if (xcp_mgr->mode =3D=3D mode)
-               return 0;
-
        if (!xcp_mgr->funcs || !xcp_mgr->funcs->switch_partition_mode)
                return 0;

@@ -201,6 +196,25 @@ int amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp=
_mgr *xcp_mgr, int mode)
        return ret;
 }

+int amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
+int mode) {
+       if (!xcp_mgr || mode =3D=3D AMDGPU_XCP_MODE_NONE)
+               return -EINVAL;
+
+       if (xcp_mgr->mode =3D=3D mode)
+               return 0;
+
+       return __amdgpu_xcp_switch_partition_mode(xcp_mgr, mode); }
+
+int amdgpu_xcp_restore_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr) {
+       if (!xcp_mgr || xcp_mgr->mode =3D=3D AMDGPU_XCP_MODE_NONE)
+               return 0;
+
+       return __amdgpu_xcp_switch_partition_mode(xcp_mgr, xcp_mgr->mode); =
}
+
 int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, u32 fl=
ags)  {
        int mode;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_xcp.h
index 9a1036aeec2a..90138bc5f03d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -129,6 +129,7 @@ int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, int=
 init_mode,  int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xc=
ps, int mode);  int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *=
xcp_mgr, u32 flags);  int amdgpu_xcp_switch_partition_mode(struct amdgpu_xc=
p_mgr *xcp_mgr, int mode);
+int amdgpu_xcp_restore_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr);
 int amdgpu_xcp_get_partition(struct amdgpu_xcp_mgr *xcp_mgr,
                             enum AMDGPU_XCP_IP_BLOCK ip, int instance);

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/a=
md/amdgpu/aqua_vanjaram.c
index d0fc62784e82..3f715e7fe1a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -500,7 +500,7 @@ static int aqua_vanjaram_switch_partition_mode(struct a=
mdgpu_xcp_mgr *xcp_mgr,
                return -EINVAL;
        }

-       if (adev->kfd.init_complete)
+       if (adev->kfd.init_complete && !amdgpu_in_reset(adev))
                flags |=3D AMDGPU_XCP_OPS_KFD;

        if (flags & AMDGPU_XCP_OPS_KFD) {
--
2.25.1

