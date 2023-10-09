Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD3BE95A91
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 15:08:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A68B10E27B;
	Mon,  9 Oct 2023 15:08:29 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE1EA10E27B
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 15:08:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTIGkoHnGkq+YYcxF49pgTSisai1ay3L6z/DXzEjxS9LZsWnrr378tCB9E/eMUm2KySCPPTyWD2xzt96w/ZzNIqrSF2g7MayxT4IQ5+NcpIlNR3fAAok926q9XQGoHNOo5HM6elXX5jizeReGY5+1VHMlORv85WZ4MOu2tLKx+cPaWKN1LHrOcjrtnc1hFF9iWAjV+sx6jmPtgivZwfb2ukPVCI32IeJ//63CBkMcutvMD4ZkEocS9OJJgq8fpND9gKqtvz9o0W9ZC2DjxvWed86H9kHS+o3pXe/QC4YlSAMMqQJtQSZXtN4oCijyg9lSmUv2qs45d/iavahELBybg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yxg1PU/6kF03up4HEY3drrWkSJJCXWPUY47ObaFdILk=;
 b=EXoOyMGVlrVUA1vXxCprRU8xoZdPxjXzCftDChRnnfW6LgNz6PucFPr9vl03OCkfNxYoZ13/j9yO426fcCTD1VMoVr6OBSAGSrkskCI9yHm5XLnN1rXzTsXaadiKh71bwNe+jR35lx2PwHaUFBANQDEMrJUCQ1ctG3RlNTes3eYwE0+Gjegw7cJEGpx/t3u0ZQxVp0HC/+eBg6foC+7+HqLf2BehhqN6Gg+z/RvVr/NbrTw+zJFuVQqdtscwIZW1gaCWqWEP8jgqUAy3na/E18/QVsrOGLmF99aupGN102dgKHaa4ev8JOLXEq/KjatFRsO2Yf7f8nlEkubwMv9cGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yxg1PU/6kF03up4HEY3drrWkSJJCXWPUY47ObaFdILk=;
 b=ngjn64KKFdw6kACFW/cD2x7HrZyABJRIq/A8YuccW/0AYpIiK3GwS8GgX6NztZ4n3uO64XieT7y82fiCafOBgF8uPnk8B5W8Sc64u+bJpeqoQ9qCLgkdF4cb0Eb7W2meKdCsvnECy1b4RmvxswJlfkPvfzU1hYvnEuQsNnjybDg=
Received: from DM6PR12MB2697.namprd12.prod.outlook.com (2603:10b6:5:49::18) by
 BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 15:08:24 +0000
Received: from DM6PR12MB2697.namprd12.prod.outlook.com
 ([fe80::82a:c688:3c6:ee34]) by DM6PR12MB2697.namprd12.prod.outlook.com
 ([fe80::82a:c688:3c6:ee34%7]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 15:08:24 +0000
From: "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu/umsch: enable doorbell for umsch
Thread-Topic: [PATCH 3/3] drm/amdgpu/umsch: enable doorbell for umsch
Thread-Index: AQHZ+PvfoKs7VwfPhEekn6s1yyBrZrBBkt4Q
Date: Mon, 9 Oct 2023 15:08:24 +0000
Message-ID: <DM6PR12MB2697A8BEC17548174E803157FACEA@DM6PR12MB2697.namprd12.prod.outlook.com>
References: <20231007085402.67350-1-Lang.Yu@amd.com>
 <20231007085402.67350-3-Lang.Yu@amd.com>
In-Reply-To: <20231007085402.67350-3-Lang.Yu@amd.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5950a578-bc74-4a9f-a12f-1dabbfd60a04;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-09T15:08:11Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2697:EE_|BY5PR12MB4885:EE_
x-ms-office365-filtering-correlation-id: bee8833b-96fc-4347-6071-08dbc8d99565
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0fMXutWKJBPl7ybR62ribWecpVLiCrWMw05TvX8LdSeBH9Q8SDjjERskcDgCdUOiuPewe1O+ojbPEwEV52utgy58sZjMKYOQiqmgnGTz2VLoWPS+M/oUq71kG6J7vyRHL0GNTV7mCSA0SG6nQ2BMSR6ylq8y4RlZUQ36nwzS337xRvmbovOP1lfJ9H5eCuSdDI6f6HHo4O+zF9KmEvyRkirR6Z8eSiQ+MPHxn/4xD9YsfDC5CTekezsdfY/w816DCnoA8gLIicvTi2HHMfLcrmil1v0ApGeFxgjAISB11wrXD3wYz+b2iK3FkBGcNa4vNbpBK+Iuaoc33clh5tD13VrdowTRjE5lntqknApy95bWl4GlJQin2PFVF+aTzKr+7YilLomWIjtIDgSmcYvZs7AWhNj50bsyH9Vm8MYgmjaUsf9cwY5uXhEGFbtrSMaLLeygkEGB95hLzrWW7sv2IrFL3N2ogbO5ohVc+B8IInKn18p5X/BjbgLA5JMQs/eIlryTk67f/RROAWDE8/QLUiqvpF8zHGgbkyNY15x+U/Hmb6FPKQPbC6ZK30PrAFE5Frj+1ByO3fNBjz7wF3TS8qWHXRZLiMpMZ2bcbcIFdonNAzdu/Mfj4zN3za+oOAP+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(86362001)(38100700002)(38070700005)(33656002)(122000001)(55016003)(2906002)(53546011)(9686003)(478600001)(41300700001)(52536014)(71200400001)(5660300002)(8936002)(8676002)(7696005)(4326008)(83380400001)(6506007)(66476007)(64756008)(66556008)(66446008)(76116006)(54906003)(110136005)(66946007)(316002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?seexKD0V6+aRehcPXlQlYAEs36t19fqacfKk3yWaqJ0kLk0c24DRHWuBrEmI?=
 =?us-ascii?Q?JEiFPqUNVacKE8eB7zyhGlrn2YJemfAl6xQyFmQAceX48qrE9/dvaoIjc42S?=
 =?us-ascii?Q?HBd15H0kvHEharZKqKQOfSHUCyv0EJwOQP3IESrSG/gQ+SIHJl5cjjVkzdXK?=
 =?us-ascii?Q?vc3k+QeYEp1w2pgRR8z5xyaF78IbCDm5nTOInMNLc6wIi8SbxQRsZDPMewTK?=
 =?us-ascii?Q?3VMtucJ9c6u1+8MVKlLKYVkpyxuT4PMkH8CjCyI04nQ1yNdgN/pJaYZSgbA1?=
 =?us-ascii?Q?9uwWsTIIyaXdIaSJrjIy4NhJedqe519G/sw+kT3xqTwG1cLFHCesxLVeTtkQ?=
 =?us-ascii?Q?elXYSmgtCZQyUns+S7kPKq3TRzvRqVFbzFsWHHo3H9v+F/RJINtteHEtYgvf?=
 =?us-ascii?Q?M6n411g77KLfTgmvppoI1sFYcG37wLQi16G5AQWxl6SFVuNEjO9zR6HNRiwL?=
 =?us-ascii?Q?nMNanA6s090Q/3BU6y9/EfKYUfqDLphe7rFXDMcR7uegXyMrvWHEi7iih92a?=
 =?us-ascii?Q?2fRdctI1xFVzP6i+jxbI9OINixC+2yxblxRFvHNI6HoxScDvZ+vAha8NR6B4?=
 =?us-ascii?Q?DOcuhMSlbA3kDjSk5ETEIg2rDz81nHYC/8gEtqOskDgrB2boA5RSpIaGS0Fw?=
 =?us-ascii?Q?OKl68AHenL/zHp3/JBVuok/k89h7M9S7TI9WwPYYp3CATWd4AjKVBqlM724i?=
 =?us-ascii?Q?6E/hWqD3BttbQtjkOMdXYsl35tTd+D04/cFx+9NE0p6bBLi70Q0XaAxdsD/E?=
 =?us-ascii?Q?nqtVLVvNmUfkc9BnPFTFOVuPG5crEu55ogudBT4SbMDghUgSJGRH2KJlXapV?=
 =?us-ascii?Q?NBlrNqU8pX5Cye2tYIuNjYBuRbOcoEitA4WOVL9sZZuoUombAJuR/7bUIE9p?=
 =?us-ascii?Q?r6pETTDVZIucld0KgddZpWsxpI770JTQmbgP06bz+6/arlmENWUJRTpm+bHC?=
 =?us-ascii?Q?lpbdaWcgMCRPxLBYU24wgou82U5OabdP6WOwFxesO8G0/+p8LjC1ZvE1kX9z?=
 =?us-ascii?Q?xnDw1tnmVXyYVpiHLBpNb+jp9FaZf9juCks4w1XrJAdqZtircDfIUMBuXtu7?=
 =?us-ascii?Q?Cdn0xaiggfFoboC+Fa0QGVETawlHJ2EjJ340bSt00yEy6Zv7JJl4hJysUk2B?=
 =?us-ascii?Q?WCq40fsOTCYUGZQmJUqceSOShFXCVEFiOd9eqz0pMy+9YpJfUhFS0z5c0ec3?=
 =?us-ascii?Q?yY48RZ49PM7tsJYE9ZsjTbUhCkDQHGN+waxwie8WUy3cZNKSFVSroAHrgK4l?=
 =?us-ascii?Q?91LLVIUBmihc7BDmOqaW8A0nkqPmyO/6kFYcl5zB86Nm/cZ2spPZWhwXFoz7?=
 =?us-ascii?Q?yiUEOMvUYdw5qiw16iQAPZDXSdqkofliA96lFgdEuvVfXy4OWxuIxc/TRWaw?=
 =?us-ascii?Q?XVoFW3S73rNTeSq8gAbEGQN2r34/YkU8/Z62qwlJx1SvpQDGDs1vIMCpaWY0?=
 =?us-ascii?Q?vav/iHrc9/ojQSzmzg9SOca2rri4xEKuo94eJVqVeNkDwiT8cPvFN/cY2f8n?=
 =?us-ascii?Q?kLCgqdRL9gBzjU0aJB4vN0d4NWotXrkb/DRF/BxRHd857IVsgObC0aSVodJ9?=
 =?us-ascii?Q?7WZ/HrRD1VasqPOsm7U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee8833b-96fc-4347-6071-08dbc8d99565
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 15:08:24.2696 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BKS1STALgl4iPJw7qJykBEqLj2tS4GI+Dy0WBhic/Zgm11Pt9NW0O2me0Hxhco7rIdiPUO2svOUoFUBoTjgWwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4885
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
 Yifan" <Yifan1.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.c=
om>

-Veera

-----Original Message-----
From: Yu, Lang <Lang.Yu@amd.com>
Sent: Saturday, October 7, 2023 2:24 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Gopalakrishnan, Veerabadhran (Veera) <Veerabadhran.Gopalakris=
hnan@amd.com>; Yu, Lang <Lang.Yu@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/umsch: enable doorbell for umsch

Program vcn_doorbell_range with vcn_ring0_1.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c   | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_umsch_mm.c
index 9d89c4186989..4bd076e9e367 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -554,7 +554,7 @@ int amdgpu_umsch_mm_ring_init(struct amdgpu_umsch_mm *u=
msch)
        struct amdgpu_ring *ring =3D &umsch->ring;

        ring->vm_hub =3D AMDGPU_MMHUB0(0);
-       ring->use_doorbell =3D 0;
+       ring->use_doorbell =3D true;
        ring->no_scheduler =3D true;
        ring->doorbell_index =3D (AMDGPU_NAVI10_DOORBELL64_VCN0_1 << 1) + 6=
;

diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c b/drivers/gpu/drm/a=
md/amdgpu/umsch_mm_v4_0.c
index 7e79954c833b..17c73aaa1e82 100644
--- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
@@ -217,7 +217,8 @@ static int umsch_mm_v4_0_ring_start(struct amdgpu_umsch=
_mm *umsch)
        data =3D REG_SET_FIELD(data, VCN_UMSCH_RB_DB_CTRL, EN, 1);
        WREG32_SOC15(VCN, 0, regVCN_UMSCH_RB_DB_CTRL, data);

-       adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell, ring=
->doorbell_index, 0);
+       adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+               (adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);

        WREG32_SOC15(VCN, 0, regVCN_UMSCH_RB_BASE_LO, lower_32_bits(ring->g=
pu_addr));
        WREG32_SOC15(VCN, 0, regVCN_UMSCH_RB_BASE_HI, upper_32_bits(ring->g=
pu_addr));
--
2.25.1

