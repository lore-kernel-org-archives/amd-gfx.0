Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E80C47074
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 03:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C772510E150;
	Mon,  8 Jan 2024 03:31:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ECDF10E178
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 03:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkwC1jCwBGIvh03qIodwPJOGUi5bsg3nUl3PoQ9yoQ5v1tqj20mQQTu7xQqh1rsTjr3jnSUwJbiGw9XC9S5zH34qyvstRpbl+E3Ao7dfTfRdV4BDu415Xp0t70uaGUYxmgdNV/5IqRVEgQ8/3C2ecI9P7PTh5JYsvozY5hs9fPRpcjpEuWGgIVL/+dhar+sjAQ/gwCOqeLPddZF8hnXfERXCGakQpWkPg0Tpm48hbqLNQyD7X6j4iWsv9hfTipp8Kz45rmz5/3Azzr/vyVAkVsvmc9axwrvrWXEIkHeB5gdamRUzos4L4swa+m/438u3CGxxfpPwbvAPdAond6uq6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSKOUhE0jLpcAfBt7MDyXPuFLXNhGiVX4VxltH1ggG4=;
 b=nvRMaVycEUc3zmykWJ/2haa98sd60aUeCaNaOLNbc+2ZiYRcLL6q1e80Si/CWrVibjvMrdPk8ldZVP0OjEyJBMgXHpQS0LqJYjcCdUHPb4x1qFUo/qAYcjo5BSTfBNXzDHboaYDAHGCIf3bRfnmCO+tD2dP+OxXsfAZn5JIhmhSNEOFuIMjyTS1Cb8Co13Otr50pN+3wjZw3Bb9sDoCd0BvkCJhqHx6nFl5IDcHahBj/KXmKQ8s51jOU8i4n6BNq1LDMgbY2GtuEq19ywDIfh9eVTUcTSF1XIvFuAVpVnBQwuMrQaFL3OGrc+vQlQFKqapO/+YZZOlsTO2TmXMAFyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSKOUhE0jLpcAfBt7MDyXPuFLXNhGiVX4VxltH1ggG4=;
 b=cWnDl0fqgZhXK36mXy6dyQhobZBJDAzC2XUvWbNW8ZbBn5domufDMEE3g6iLTHnGoMHZHQ4kiYB8SEsDsWUk/5ShBS3zr2Pg51bz2aB+M63/QfLEcGaiktqWjODnx89ho/La27BxgmbpQ9AY1SPAo7KKfyuViZcfAnV3a/mayRo=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by CY5PR12MB9054.namprd12.prod.outlook.com (2603:10b6:930:36::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 03:31:10 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::368e:e9e0:1dba:9aa4]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::368e:e9e0:1dba:9aa4%6]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 03:31:10 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2] drm/amdgpu: correct the cu count for gfx v11
Thread-Topic: [PATCH V2] drm/amdgpu: correct the cu count for gfx v11
Thread-Index: AQHaQeFRaUEMLqFzH0etopJY2/QugLDPQjWg
Date: Mon, 8 Jan 2024 03:31:10 +0000
Message-ID: <DM4PR12MB51816E07F4B21259693F789FEF6B2@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20240108031752.3897754-1-likun.gao@amd.com>
In-Reply-To: <20240108031752.3897754-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0c4482dd-8f5e-49a7-b84e-08e37fcdad42;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-08T03:30:10Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|CY5PR12MB9054:EE_
x-ms-office365-filtering-correlation-id: 18059284-fa26-4852-a6dc-08dc0ffa41fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8LuZe+0/5hdwoJMChV4J85n1DEYU8QPmVwXzvvBprzMtq2p+K2oH6nc/suLnAAMlJYy6EDxokHSHbqS/JIRgKGv8AlL/kMF5h6DLjEq9C7D32W8r+hrwFOa+71wU0YIWL2LWAodeg+z6vqFqHCqb8NxbusoDRjrZtd3QH2D0Xz5oikHPxQ8j5sRxbzXBLMJRo2bxdHuXbmFRq/YtqI0VZC4HshAkLpZpu/uIVIIJzvjDYxisBrGB0x/hS8A0fneC9E+lHadEhpitW/kxutyaZPWGNIMf+te5o2f7VOmA+08xVO1xHAEJhVh8LhAbxsMZJ+METjYtb67gwTZmYGYxTU28wfyl/pYibdn7OHzPrMsDj+VmuJJwbTORdIgpQzNd9Jv2zg8VeZULDfROEcHPTe2pjGcEFbwh/Pne7Rpgc7u2EYiFpVnPSLC8YPollTOtCtfqR/z7pU0BwegXKg12XdbQncHCOrWb7CjIfgpteSkeCQK52CKXIPM917g0RD1M8TqVbTrnFQj/EjVtxtT7cEmNhwhhIHikuua0HnPPWWZt3mr/8JPZeBm3mEpGzmfWzff7cITn5UAtxja5lNxiU4vo6hjndMrhFsl/5ob2d5U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2906002)(38100700002)(122000001)(4744005)(5660300002)(38070700009)(86362001)(41300700001)(316002)(8676002)(8936002)(9686003)(55016003)(76116006)(66556008)(66946007)(66446008)(6916009)(66476007)(64756008)(478600001)(7696005)(83380400001)(6506007)(71200400001)(33656002)(52536014)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lot6spD+pssNu11Zq09oIof9KaxWKuUyRU+4ww3v+Tr7oswTL8EXtfjJfwxx?=
 =?us-ascii?Q?Rds/SAUeQ6QBzi2ej8/QLLRBzcga8d5B9sc7Mc6SZNC8qroCJ1FjuzICpaoh?=
 =?us-ascii?Q?xAlbnU2GwDNM6/r3SCMoqWT+s4vClWCJd/TFX/YcaEoQxlK7j/JpxetAa51J?=
 =?us-ascii?Q?K6sGYJrc2upz7e+3PL3EHaNknT5VCYyPdUmNKKsUYsNITkmoibq38GGArzct?=
 =?us-ascii?Q?Yhqxq6MkoqSa6YQSEV/ATzvuUjjWVI6/RTemcXC05WhYGIKV121CPSecasvg?=
 =?us-ascii?Q?SoH4RLay1l9utqdV44a9M9F/37ULg//ciD8GZsMdfLMro2h+k+CmRaaX7GpG?=
 =?us-ascii?Q?c0F6WWoh2g34jyEqXhazAIH9caDqN+d2+WrcnfHG/2EN8HZ5pH4DF15K9VJo?=
 =?us-ascii?Q?FHktpFsEiYtWaiaIMp78cgt8q4cRC9p4x5F4hNLVTTOiA+tMQsyWs2/gguEc?=
 =?us-ascii?Q?kFDk3kie4KfU99nRPNWJuB1ZzpB0F0jJf727Kb3Kza1f+jL1u571ErildblZ?=
 =?us-ascii?Q?wb21cC1lxQq6EgeKhKcZ9ehY0Eoxi4sRg1m89YNS52IX/ow76C72H2+VzBnd?=
 =?us-ascii?Q?o4rd2S7HGEmvVojJAYgrEy5H5CJoYc88mW7fb81Skg6YIxQAXc3tLPl67hP+?=
 =?us-ascii?Q?tg19J69RxCfzcK4QGQoQY23Ef3LHi1lP+S1bep3oG1L4qfS2SMZwNudnd0JH?=
 =?us-ascii?Q?EhECp89CYWqTuS66ETCQWKT3Fgazcsod22ctfOSN4VXtRetfmE0AiPoqOj8p?=
 =?us-ascii?Q?lgWd1tLzLB7Dzxn6U0hbj0ieztBgGw/YF9Wi319EwWMrvieNHlCPJf9IBrL9?=
 =?us-ascii?Q?Zv8pIEU+3j25iSZfZQugu5ekCC7YSbK9jmrpbAlXgxWp6H2/g87wWOdS0844?=
 =?us-ascii?Q?Sxw88/QUp/oMQF4iWcS2qn+EF+62j1sa0J1Vw1vv0sSuRjhQv7GO16i36jDc?=
 =?us-ascii?Q?VBHzMOxYO4dWXNXucGEAC1eqNikLSq9oXnbunJyvFYXZShvScijD+fA4AeRC?=
 =?us-ascii?Q?YTbA1rykxCFmAFA8oZA+H4lT+2/feDm7VgyAlIUbAjJqLPXywytHsa2sGtYW?=
 =?us-ascii?Q?LM+REYfqNdcL7FBBa0PQj0voyi0hyEYZmJlJyy5CWiecun0KUr2H47ih6eSF?=
 =?us-ascii?Q?ZtOdX5S3qBvlQn99SrCAZ80NRmasP9n2NBllkDbkCdhiieaqDyWEVtjrND3f?=
 =?us-ascii?Q?kCW3qJtuCziLCMkg5MtE8WUsIbM324vpRoCjJpVoN0/BsoDp0faWtBIP5kDH?=
 =?us-ascii?Q?PZQ2bsqfCsI1Wdymn0jtJX9YIkcx5RSrtsxCghGgbwSzG5D5iEdlz7gHqJn/?=
 =?us-ascii?Q?2IhUdCQ4SMSHoxw6hN9lRSjkz26MNHSvSEqsDqUUjg2Eei9+ro3noOxACzkD?=
 =?us-ascii?Q?ZJJ7bVAh2EOLxbNzYIAu/UqN/FvbrTQ9L2+sfi+ZcO+DjYfJEFS4xA7TkHj7?=
 =?us-ascii?Q?FA3x2Z5es55XLsygLLgZLskbcaPkKBF/JsMp3sTiMazSCo6YZ+4d45ZzxYSh?=
 =?us-ascii?Q?5fPBVqWFQ9AkiddfowUegefhKPqZgi+f+N3PmNzArh2awy8LcEm5pw8ySQ?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18059284-fa26-4852-a6dc-08dc0ffa41fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 03:31:10.2809 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TR6cS5Ym+qpW4OvAxLr8KD+BkeCn3BZrQMRQYX1HL4OJzKuRDybXbWB4rsxmeXE+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9054
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

From: Likun Gao <Likun.Gao@amd.com>

Correct the algorithm of active CU to skip disabled sa for gfx v11.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 2fbcd9765980..c7242877d5d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6383,6 +6383,9 @@ static int gfx_v11_0_get_cu_info(struct amdgpu_device=
 *adev,
        mutex_lock(&adev->grbm_idx_mutex);
        for (i =3D 0; i < adev->gfx.config.max_shader_engines; i++) {
                for (j =3D 0; j < adev->gfx.config.max_sh_per_se; j++) {
+                       bitmap =3D i * adev->gfx.config.max_sh_per_se + j;
+                       if (!((gfx_v11_0_get_sa_active_bitmap(adev) >> bitm=
ap) & 1))
+                               continue;
                        mask =3D 1;
                        counter =3D 0;
                        gfx_v11_0_select_se_sh(adev, i, j, 0xffffffff, 0);
--
2.34.1

