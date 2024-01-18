Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445E7C47258
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 02:38:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3034410E105;
	Thu, 18 Jan 2024 02:38:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A157D10E105
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 02:38:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAswJt/7/VPOWj0xpD6kYKE4HRpnxJSeS6LcXaLzLOa4c8jiJa9+83aWH7hxhL88kZXvGpcaUCBTDT0Y+ALzazL9J5lbh7boPH18pLr0AskxZfmpd1fhHbEVWkvjs6l4QSxnadyZieCMbatc0ZurH84FIVeS4zCz2O38oUXYt9J148+or8fvZ0B4Ub5yjh1VNGYel9nvjEJCiGGrv74vgia1cPluw/cgayC7qId2D4XqqU/QgsBKkrYxOhtu27wTkhQOlb70wYfeGZ/k+i7TYXRpElrdpeYnebB7nJdYBckj4GXeJUWsd3/7DWPK/meikywhDxc7nrEEFvUjeKr46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJ29dXlk75ya3TuAjDdllSnNMxZyBBvz4c5QPV5DtlE=;
 b=fo3T24hmE1x2tpitM2kTHy2QeKlwMKdZ3qU3CUCjTR7JwMmGyxKeu7p/ZkrBpenb31pGYdkZ6VRcj4wus9VLWSIxD5kw2gxIz9OPwwSjzvGlWGhlOvl5uFrKu57+68dg1z4WHncSRzYwCY+tNKg9oHaLle4kgd5KkiNNnOxsLi0X1TvfLgTEKw59aovqGrcINxIHl8feMXrrjSbFvPa3KHSVJ1tDJDAfgJ5qMyKM3PwxlRFa1Ld6M4aJFtb/P9iaQYWxj0fsac6TKUDEGoKGa2pKllsogJRD5OfZhRRA3pSNwfMXfvHIhISHtokeWQ70PbQ2Sw2xaIunOKT+s+kksQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJ29dXlk75ya3TuAjDdllSnNMxZyBBvz4c5QPV5DtlE=;
 b=ZjniHXf2nKGHHwePRKYpneWTKnuZLkSlCkRCEJ8FS0JgzCCxjyLCtsUh3kdQj8OtoWoP5O9qbkEi/AQYy6TuB1zPTfC6SqNqkrouYsfG8RCCjhwKf+mnEphAGJ0/PdM+yGm3t/oCrmVac7VPYT+5M/j0c+GcTXvMg+Gi87Jzj/w=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by SJ1PR12MB6241.namprd12.prod.outlook.com (2603:10b6:a03:458::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Thu, 18 Jan
 2024 02:38:22 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::2c41:8d9b:d594:6865]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::2c41:8d9b:d594:6865%6]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 02:38:22 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdgpu: Add log info for umc_v12_0 and smu_v13_0_6
Thread-Topic: [PATCH 1/5] drm/amdgpu: Add log info for umc_v12_0 and
 smu_v13_0_6
Thread-Index: AQHaSFT4X0kvFAN36E6tmf5WhZQ3QrDd2zkAgAAH8gCAAPruQA==
Date: Thu, 18 Jan 2024 02:38:22 +0000
Message-ID: <CH2PR12MB4215F39AB7E80B8E90CAEFB6FC712@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240116082034.1739848-1-YiPeng.Chai@amd.com>
 <BN9PR12MB525769654D72081918DEC822FC722@BN9PR12MB5257.namprd12.prod.outlook.com>
 <BN9PR12MB525743F76BCCE9CFB6598A66FC722@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525743F76BCCE9CFB6598A66FC722@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0b419208-df91-42f7-9c5f-36641ae16d59;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-17T08:54:30Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|SJ1PR12MB6241:EE_
x-ms-office365-filtering-correlation-id: 3e38238b-95b9-4ea0-9912-08dc17ce89e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ASUMvoGv7qKJifYOtb4SMrC7qeM6JIn3OboZeAIqd0u2h//bcP0hBEeEVQXCbKmd+V94s7H2NM5ePEheriwjEqv1GF/geHFwQkCmDegmvdNyVdVLxr3fOJwxq3Cuaf8VFFMQVH8Lbtp18lK8tuIYbswhR1xofBq1sKCEPpDkQQA/Y5A3MC0T7uT9U1rQ+Oa3pCDNz6dKimniS9u9CDX3a58Nsqs/1ikz4xipxaTxGERpf1CBB5RMuxXr5wFeQMqZUJWaksbKpZ43D2kMT0IJLaqn9rxn+l8kvKky00ONzBKzkzZLkToLn1vI5lV5hfewOakEf90YRNWTOaEZ1g9JjaMGC6sakNa1WCwLfPjlzbZFWuIKOTDHamr4WZ5AFU6X+cYpQhkMChs3iapuKdOz89Ct48bEpiebvXl84CKQAH7Juj0+QJAGM3HLe8zO1C5GASHpdEA/qL0U/hVyRNEQYF/Tul39Cu/ZYUXauekeo8OSb13TZu0kA6ScmM/IG+lpVPQdoI6o0echDo6Tof6/ywjf3TEkxjuQmKWRqlir9LPaKgaifT9EncqIr+3cWWBorxCb7sVEVWTgvLhUQpX0n1gT+G1LX/Ret/5p+6RLo+iweOzo1H00vN0BLlcwtCeD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(396003)(39860400002)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(7696005)(53546011)(26005)(9686003)(6506007)(33656002)(478600001)(316002)(66946007)(8936002)(71200400001)(52536014)(38100700002)(4326008)(66556008)(76116006)(66446008)(66476007)(8676002)(54906003)(64756008)(83380400001)(122000001)(86362001)(5660300002)(38070700009)(2906002)(110136005)(55016003)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KWrKIjzKLhgX6bJb4HxCIz4IQKfI+kbhgN/wV5VjXpRidCUbfcOkWSoOR49g?=
 =?us-ascii?Q?dhhZa9z1x9RzDzPPfdmSz4kzGSIU/PtcCyDvT9dbUMN37+jXlCyPKQAx7OHz?=
 =?us-ascii?Q?A896VjVALAq7IWqzXcWC2FPn50F6rJd7fD7NvRr/I8hlPLPCP142g4q1LIzk?=
 =?us-ascii?Q?t2EH1Q6KpMpDBCYqsKJsy8r5Fz0HiYsDWQNQ8tGzsdnLPfxvUtyCR9Vi0no2?=
 =?us-ascii?Q?3QKzrsCzfSxyDhzxoLbipPDIfNPBkJx+qsjEU+TbwEYhbLzSXkfD9W3zg0KI?=
 =?us-ascii?Q?YV/g/aEED1pUasdXqMIfnKK+f6kAZneZYUY1Fbr0A3FV4EDGIjbvMzLh+PB/?=
 =?us-ascii?Q?k8E9Ud5v+NrC7lQRbfKtiBp0q3TG55wctbJfwIOmZE4VGrykvXFrdUAQscGc?=
 =?us-ascii?Q?3Exsg/C9uEEWuevu22tC4IMejdD3u+iRdxTnnYVGqYsS7+VZ/gHo7GkpQukZ?=
 =?us-ascii?Q?AXsugcmYf0AUL6hkf5/nybk1uxW1DAhUyDYQ2CUad9q4shkB5PBGhd7R7vQc?=
 =?us-ascii?Q?INaFC6Qp1ggNXzvOKiSymI0C4YNgcxoi4z/nd8iG4AupRMoyjTbwurHezeuj?=
 =?us-ascii?Q?6BRBYo0++gXRR3uXpo79jJ9GiY3JpgIZAIWJz2L0qp8PNFkZrMXdsvoBzCkx?=
 =?us-ascii?Q?8kossrnQZL3eG5B7zRLUf1MUCuMgOv8IXhZI0IzhZOYvSSosQ+hTaLmUZ6jM?=
 =?us-ascii?Q?gCiAW22/ahuOgIzS5mWbCSns2uKYx1IUV5OW/r3h/rHgQ91KRowy1Tv5ZAxf?=
 =?us-ascii?Q?WtRwgiYM+tjX9d5u1P8lXdPAZeD2M/yo1BK3lpp+DmDj7c0awuKKeiTY52t5?=
 =?us-ascii?Q?RwWzwT13LffVmkUMrE+DHsEHBxriAPKknn2QjBVOR61uqIj/v99WjiCWDOLg?=
 =?us-ascii?Q?Qlh30UyzlvryernQQC0uTOFTYqFbR/NdR3YCUVJdqO0u4LM+94m8BKrFdCTW?=
 =?us-ascii?Q?59yEj/E3zJZQaiSJucjUiJf1f0BBySkR+kCRTQfU/7bSIjOYmTJhVQqc/4Nt?=
 =?us-ascii?Q?lHT52huQ+uLxpgk95E5JNA1uKm0u36r6faeys3w8kNOuiRsuY/03ZfhduxGz?=
 =?us-ascii?Q?30Tg6zDmN0LFE067ktks6fPkUAWE8TBCWZXBgzO9o6x9S7yTSMfsfzzjzMtn?=
 =?us-ascii?Q?Yluh4pKbewxd3up1htw/HelO2gG/maDVTmYAfYGo/O4LeXDpD5deM621HZ01?=
 =?us-ascii?Q?1EMxMUuvglEomaiUYZRkMDVeCL09KPK5mFqLMcWti5+CfWtQJzn4MKaxRdWg?=
 =?us-ascii?Q?O4JDq+aE9pmoHaF7Ygom/d/2tJr77M0JRkjWGzKJ1O4SyG8aoY99bcM+qFpd?=
 =?us-ascii?Q?YoSiEOtAUQ5javmGc29fi6dCxCwTTVSwxz5gBZrD8QiogoOeWT1hvrhD4RMU?=
 =?us-ascii?Q?GskJ+ypvdxqWwjIU4xbho5UqMm0YwwLvRXywlPtp8srPwSIcoIWvFmtz3C+P?=
 =?us-ascii?Q?aASdAjUxWBwk9D0Jv0J/DxioAJUp/6Zy/8GfY+C3KI4F2P2/fcu6o5HtoxTF?=
 =?us-ascii?Q?BTIgvx+H30hfvajN8KXala1/H6zwHUbf09y6vJtJ07DfFMMhPtvdTPtfqOwS?=
 =?us-ascii?Q?e6/vb3kFzWsSiUgB3vY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e38238b-95b9-4ea0-9912-08dc17ce89e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 02:38:22.3700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t/VkRaO/qp//3gAaq+VRWoGBSZ0zRYL/pq41vxJR6CV2vCOqznP6l2b2mrgoQKfcrluqeEAPSYYHqSCEk5H6mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6241
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

OK


-----------------
Best Regards,
Thomas

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Wednesday, January 17, 2024 7:40 PM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; W=
ang, Yang(Kevin) <KevinYang.Wang@amd.com>; Li, Candice <Candice.Li@amd.com>
Subject: RE: [PATCH 1/5] drm/amdgpu: Add log info for umc_v12_0 and smu_v13=
_0_6

[AMD Official Use Only - General]

Please ignore my first comment. It doesn't necessarily associated with sock=
et  id in UMC MCA status log at this stage.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, H=
awking
Sent: Wednesday, January 17, 2024 19:12
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; W=
ang, Yang(Kevin) <KevinYang.Wang@amd.com>; Li, Candice <Candice.Li@amd.com>
Subject: RE: [PATCH 1/5] drm/amdgpu: Add log info for umc_v12_0 and smu_v13=
_0_6

[AMD Official Use Only - General]

[AMD Official Use Only - General]

+       dev_info(adev->dev,
+               "MCA_UMC_STATUS(0x%llx): Val:%llu, Poison:%llu, Deferred:%l=
lu, PCC:%llu, UC:%llu, TCC:%llu\n",
+               mc_umc_status,

Please also print out socket id for UMC MCA status.

+       dev_info(smu->adev->dev, "MSG %s(%d) query %s MCA count result:%u\n=
",
+               (msg =3D=3D SMU_MSG_QueryValidMcaCeCount) ?
+                       "SMU_MSG_QueryValidMcaCeCount" : "SMU_MSG_QueryVali=
dMcaCount",
+               msg,
+               (msg =3D=3D SMU_MSG_QueryValidMcaCeCount) ? "CE" : "UE",
+               *count);
+

This seems redundant or was added for debugging purpose. We can drop this p=
rint since there is log to cover failures.

Regards,
Hawking


-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Tuesday, January 16, 2024 16:21
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang=
, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: Add log info for umc_v12_0 and smu_v13_0_6

Add log info for umc_v12_0 and smu_v13_0_6.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c              | 11 +++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_events.c             |  6 +++++-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    | 13 +++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 6423dca5b777..fa2168f1d3bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -91,6 +91,17 @@ static void umc_v12_0_reset_error_count(struct amdgpu_de=
vice *adev)

 bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t mc_u=
mc_status)  {
+       dev_info(adev->dev,
+               "MCA_UMC_STATUS(0x%llx): Val:%llu, Poison:%llu, Deferred:%l=
lu, PCC:%llu, UC:%llu, TCC:%llu\n",
+               mc_umc_status,
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, V=
al),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, P=
oison),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, D=
eferred),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, P=
CC),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, U=
C),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, T=
CC)
+       );
+
        return (amdgpu_ras_is_poison_mode_supported(adev) &&
                (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, =
Val) =3D=3D 1) &&
                (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, =
Deferred) =3D=3D 1)); diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c =
b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 11923964ce9a..51bb98db5d7a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1297,8 +1297,10 @@ void kfd_signal_poison_consumed_event(struct kfd_nod=
e *dev, u32 pasid)
        uint32_t id =3D KFD_FIRST_NONSIGNAL_EVENT_ID;
        int user_gpu_id;

-       if (!p)
+       if (!p) {
+               dev_warn(dev->adev->dev, "Not find process with pasid:%d\n"=
, pasid);
                return; /* Presumably process exited. */
+       }

        user_gpu_id =3D kfd_process_get_user_gpu_id(p, dev->id);
        if (unlikely(user_gpu_id =3D=3D -EINVAL)) { @@ -1334,6 +1336,8 @@ v=
oid kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
                }
        }

+       dev_warn(dev->adev->dev, "Send SIGBUS to process %s(pasid:%d)\n",
+               p->lead_thread->comm, pasid);
        rcu_read_unlock();

        /* user application will handle SIGBUS signal */ diff --git a/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/sw=
smu/smu13/smu_v13_0_6_ppt.c
index 952a983da49a..cee8ee5afcb6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2406,10 +2406,23 @@ static int smu_v13_0_6_get_valid_mca_count(struct s=
mu_context *smu, enum amdgpu_

        ret =3D smu_cmn_send_smc_msg(smu, msg, count);
        if (ret) {
+               dev_err(smu->adev->dev, "%s(%d) failed to query %s MCA coun=
t, ret:%d\n",
+                       (msg =3D=3D SMU_MSG_QueryValidMcaCeCount) ?
+                               "SMU_MSG_QueryValidMcaCeCount" : "SMU_MSG_Q=
ueryValidMcaCount",
+                       msg,
+                       (msg =3D=3D SMU_MSG_QueryValidMcaCeCount) ? "CE" : =
"UE",
+                       ret);
                *count =3D 0;
                return ret;
        }

+       dev_info(smu->adev->dev, "MSG %s(%d) query %s MCA count result:%u\n=
",
+               (msg =3D=3D SMU_MSG_QueryValidMcaCeCount) ?
+                       "SMU_MSG_QueryValidMcaCeCount" : "SMU_MSG_QueryVali=
dMcaCount",
+               msg,
+               (msg =3D=3D SMU_MSG_QueryValidMcaCeCount) ? "CE" : "UE",
+               *count);
+
        return 0;
 }

--
2.34.1


