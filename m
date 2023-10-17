Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82443CDB482
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 11:41:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 238B610E03E;
	Tue, 17 Oct 2023 11:41:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98EF710E03E
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 11:40:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPVRUV0FOa7glnYmHW1ZzAStOGSJ91Bcnr992hY4fzzWH/pDKanaP5AZDZtt0dGyDXOtApKBuuDFMTaurW75cjG/mk7o2W/qC+jWZv6Jy/9c7+agtZwiUh8uV6kXUhJ29u/3EG84hKkoYNINn9ii0TC96qcgO2OPw9QYSt5JPpGJoOcXNWpHjQtQ4INj/Aew/wJeZobp6bIGM7J84BM0/54KOlk/ztVlpYl/oH9rMdn9LB1chws/MtaaP6JmEIP+LrHAKUp/oaer3V921XajAJMO6BMcT4mMPk75maqVVrMhi9O1qnJonbq2BFIyAUP42qcygfUmym3U0BeDKMykdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diQfSlpzpF/+vGL+eyfXwX6mTs48kupHm0Ny3ghmuZA=;
 b=dPs8Zuc+0dwES2o5+NymSOtmHnqDx1vLA2UASbinuGRdjkcSyXyhXr3xfE3xzctqJAdmXrzujZ1em/NuD2/fBnABTpUnQRxocEwbNCQHMkBMeTjcEzrbfAQ+Dmb6Xz2s8C/ao2lmp4MgG5HLNN9rQeqx2hFr08+bKvTDSb9mBeLk8udCCHzfEKaFas14WUqd4zLX80dKKTFtz8qmhteVqOsD4Aq35C/Grsejbs7drOmc5w3N16SbHLY/zSQmTkGfvatDlAFo/fMxSPUQ0QV8i4jgkPo8RzrkJMKTzs3GEs2bnEpREFE6GJrkqo0Iz4OCfFeIQnmTB6sldbM1sk0V/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diQfSlpzpF/+vGL+eyfXwX6mTs48kupHm0Ny3ghmuZA=;
 b=NHHXzSV1o7b7zVbu84qkp/PXvkQ6roJxR88fnGN381DFdoYXQ9YjA7ImGg6BPi0lgWNPtmDMM7jSyiDgJwpyCMYIiU4rIUtFgDlGUY0r2uHWkeDOK+W1zTnSkTChY5tCE0EUr/lOB1BqLEKtQ/RLUtGrs/7dNdKOBbO+K9zPvfk=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by MN6PR12MB8471.namprd12.prod.outlook.com (2603:10b6:208:473::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 11:40:57 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd%5]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 11:40:56 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add clockgating support for NBIO v7.7.1
Thread-Topic: [PATCH] drm/amdgpu: add clockgating support for NBIO v7.7.1
Thread-Index: AQHaAOH42+DXrkT1bUuJiKSVFWIiwbBN21Zw
Date: Tue, 17 Oct 2023 11:40:56 +0000
Message-ID: <CY5PR12MB6369F40DDCEDFAA818BB0DB5C1D6A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20231017100857.2419826-1-li.ma@amd.com>
In-Reply-To: <20231017100857.2419826-1-li.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=586f0c4c-a6a7-4e1e-9dc6-b818c467e462;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-17T11:39:13Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|MN6PR12MB8471:EE_
x-ms-office365-filtering-correlation-id: b030f6fd-e336-4d1f-8e8c-08dbcf05ed5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e9ECuGVOeuGnBPuAfnmQkeoQUQtegIqwBmcFHnX+0rklefML3cRQXrgnoYgRKeh4CHjB65cyNw0Nab8mpkNX74Gvzdy3E80AodPSVlG3FUDN5fbRR2zAAmylqOI+7Ie1jnKO/Pj+/j6DwPCEeeZ0GCHflQi628CdASZ+pApUWGtDqlrFfZQW9e+I/B7oymm4fnVXArQOk0D6inZ0eUulsNSf4wgvkFiKLHGPJoDSo77X+evxHttMDGXRPEDVwxmdzfIc1E2BeRojmymQEAY4CziEj4yQQAkNDLLgCcKBrc8DfZKDDuGz1BYaGs2mkKw+thlCItcvF3evZjTfOY5xpjYp8RgwnOX/tBg5bYdrEFmiDyV2gX3BntcIEGuh3uQHzHJojipw2x3udGZeByXVXNTSbgsSiGZP0FUD1q4jmV3a+mcZYqUXqPQIt34q3D553CKOcQ89tzpC70jB92kSVdUBecy4ZrzM3YpyaXQzaJ5DNMHCJKRgVF7HHyf3/cbzj3KpNo6nxIUJm7bn8oZ9o640UH2k2AT3iTiZG2wFjWfq2mhgPfMKeKOoEqj6+XKCdINb87OtDL5w6RZ9bwgU6iCf5eyTZORUv+U4v+PYZaTvU9/4lGkpPb15O+J70loe
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(136003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(55016003)(53546011)(122000001)(38070700005)(38100700002)(83380400001)(33656002)(26005)(7696005)(6506007)(2906002)(64756008)(66476007)(66446008)(316002)(76116006)(478600001)(66946007)(66556008)(110136005)(86362001)(41300700001)(71200400001)(9686003)(8936002)(8676002)(52536014)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hsq0t1GL43PwxXsWX80/R8WIPlK9I6xUFrcCPEOQ2on7ZN9MmDGJDIifz1VX?=
 =?us-ascii?Q?9eB9Z9MZufaxT9FGzwjWVVSIwsmt1Xgr3iFbQmx8UvKBdGvG6g9YoyPHYT4u?=
 =?us-ascii?Q?6tzKlM35/bvbDKM9cZpViC046zq5IIQF9Y4ugOCpCx9j5Y73wRnHbaO2r8+S?=
 =?us-ascii?Q?5g7gEdbulIFvN9iwYhevB1kJzqaSgzgl7tAhbHs/KHXQG/akpPPf0Imra+z8?=
 =?us-ascii?Q?fwPEgKQ0r38I0i8cBa3RWN6EB4D2vPP1I+KWZcGzbKaCxVPoaWHFuyUte0HX?=
 =?us-ascii?Q?ojAnp64ZpSE5ZXMLphLXqCuqthJ7b3Dksz0HO16aitpzQXS5njda6DBeDS4k?=
 =?us-ascii?Q?X549zCT7SjQJeTYGHg7sIDFZB41QhAj2lfP92pi0K+Q2/Jdt0jRXre11zK7Y?=
 =?us-ascii?Q?f8q3Snwe9l6jPsrMVHbYEzcMqHULWrj3f4Pt253IEEUE99kHEdxFEQPgEAhU?=
 =?us-ascii?Q?2b7hISWnsXI72S1UUiFf9ofTgVXQFH7xOobVmxk8w2pIMEHeiQJjlftpUiGg?=
 =?us-ascii?Q?BlBLFyjOHatLN8TPrFi+5XHv4QHeedLyWRTFw1PLdFgX8rthybJ3BJIaDlgJ?=
 =?us-ascii?Q?jX1LtWHE5UGhUmwegnoClIcCTe1ZWiv7SFwSQ1DBCA30ONl4uTBSEW9wVSE/?=
 =?us-ascii?Q?4wO5Ms+swrG/8RptfCq7A+sDyRSNxiWdVXfvKPAmQPVjdKtljTfm+5UnwlPd?=
 =?us-ascii?Q?k+MZxmrL4LocN5GlyyL1UKj8jg8MQTPoBMSyDIJZSNE29QTm4BgCXW1TLsHH?=
 =?us-ascii?Q?/SK4w86fX4Oa04XTaNeWciqlHFNnHkoFvltZqihYBGo2f/blLDDFHjiyYd/y?=
 =?us-ascii?Q?5K/0pkxcpUsyqWzCUVw6Qd1A8/0HbFudFzi2D+cRlmxvyul5D8++dobytUDx?=
 =?us-ascii?Q?AJHD3yb85aycHd2eibjWKwUqf1P2jCq7Vm04UMc0Nro/nFtv6OZcE6nqJtre?=
 =?us-ascii?Q?U7nzfbUF94qo8NwC195kgkyOueQSdTx6qhL7ZtJf8eBqFjm1AcNi4vfR9PEH?=
 =?us-ascii?Q?/+UXDzSI2dc3POCxo9mKbycbD4QRpxJrB4vDJIOs6A6WaMLSJAztylUevgbk?=
 =?us-ascii?Q?TbrSHTClmK7A0xVHdDKVbFZgeOmUX3uO4m8e3MnLsbEzf4/tP95EWCAV+d8L?=
 =?us-ascii?Q?QNrtN0jtqWJDrZszKaKHhCS9ILEX9cEBWEG5oAxsuRqu+Q8gA8K6IzqBV/Ji?=
 =?us-ascii?Q?JMN4lm+JE5iu13u67hiE2u/nl3jmwrIrHVpZYfV0w5NC2znBiIUY+Lnpq8uW?=
 =?us-ascii?Q?r4rIuwJv7uqsENWE6c6b0lrEqCc1gkViEYfy3BGwDoZwt6mdWmoaLLZdQWRW?=
 =?us-ascii?Q?e0M/3L82DczlIMOlG1DQoda6zyj0EbxrZIHmyx/80iRj3kGtPGQIDWX/ODPY?=
 =?us-ascii?Q?Hs7VGJ3+7drgwjzHXETnjXgCTnCluVKLVdyiRR+kf/pkwLfjfmBvRZcT2LN0?=
 =?us-ascii?Q?hkW4HG93/ErzwZnA8iNXQh/S0S+1iIToCNJgtpYrERqwHQYXH7zCGYMpyzWf?=
 =?us-ascii?Q?9I43pnhNRdXsN3nLe2P5rizEOtludeW8D8ni6wZYda1O2vPuhLfAgWESpBvF?=
 =?us-ascii?Q?zO8Ent1ZpejBU8RDdSM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b030f6fd-e336-4d1f-8e8c-08dbcf05ed5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 11:40:56.6505 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2F273qjsbCHDxOzztUnNDB99PNbKO1FO0JoLujxkZYhWXHW9sNxrY8tXNmk/PT0X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8471
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
Cc: "Huang, Tim" <Tim.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Please separate feature enabling and code cleaning to two patches. With tha=
t fixed this patch is :

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: Ma, Li <Li.Ma@amd.com>
Sent: Tuesday, October 17, 2023 6:09 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Yifan <Yifan1.Zhang@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Ma=
, Li <Li.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: add clockgating support for NBIO v7.7.1

add clockgating support for NBIO ip 7.7.1 and modify if condition.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/soc21.c     | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_7.c
index def89379b51a..4df1055e640a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
@@ -254,7 +254,7 @@ static void nbio_v7_7_update_medium_grain_clock_gating(=
struct amdgpu_device *ade  {
        uint32_t def, data;

-       if (enable && !(adev->cg_flags & AMD_CG_SUPPORT_BIF_MGCG))
+       if (!(adev->cg_flags & AMD_CG_SUPPORT_BIF_MGCG))
                return;

        def =3D data =3D RREG32_SOC15(NBIO, 0, regBIF0_CPM_CONTROL); @@ -28=
3,7 +283,7 @@ static void nbio_v7_7_update_medium_grain_light_sleep(struct =
amdgpu_device *adev  {
        uint32_t def, data;

-       if (enable && !(adev->cg_flags & AMD_CG_SUPPORT_BIF_LS))
+       if (!(adev->cg_flags & AMD_CG_SUPPORT_BIF_LS))
                return;

        def =3D data =3D RREG32_SOC15(NBIO, 0, regBIF0_PCIE_CNTL2); diff --=
git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21=
.c
index df7462cec6ab..3ab188067d84 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -863,6 +863,7 @@ static int soc21_common_set_clockgating_state(void *han=
dle,
        case IP_VERSION(4, 3, 0):
        case IP_VERSION(4, 3, 1):
        case IP_VERSION(7, 7, 0):
+       case IP_VERSION(7, 7, 1):
                adev->nbio.funcs->update_medium_grain_clock_gating(adev,
                                state =3D=3D AMD_CG_STATE_GATE);
                adev->nbio.funcs->update_medium_grain_light_sleep(adev,
--
2.25.1

