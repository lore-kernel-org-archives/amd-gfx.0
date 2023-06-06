Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D9EC77B73
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 10:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C272F10E32E;
	Tue,  6 Jun 2023 10:27:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6820010E1AF
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 10:27:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R77JhMYSCWwwethr2GqynY61OyGQofP/ODcixO4NIjaWNp05H4efdKuZE5oyf6qCVz84qzdTWNNDhYn6AobQcRMa+SFSQ8QTSuJala1GgUPszccGdFZO3liexR04ndjggjuhkDCteDMsDRREEptCf7x42aM+Ge3itVZ2l4M+UNqYpix0dCVr4u2hfX2cfYIv3r+HgeZWpcuhDJSUWjJgLR9ea1uQ2ZwM2RuWHrosW0U+QpOlFbitTNPBESaeQ4/N+u7fV4GY9PquyV3O1zevp828JrE1wwU4vUPy37+bIpTtZRA0PBMDmcycoqkeVFNaiAwAls+hN8TI4FVkK1OBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NumXFPD/LbEN+0m6RB/Ta7krPx2shkHxsio3OnVb8RQ=;
 b=YDn0B87r4I+HOjxjALVCWFL2uToIRZEce3rttf1iFdupV/pErxRtO0yhR3pLQj6ScFQ3sEKFfWT2xnNypKsxNbonISur1ckJcy/gDFsiQee4vSyX5BrGT1C57z5pyHVxULd2hKh6wkILPbstkACE5ZH0pyUSCbgztvP4dpIKoSjjz1dWGcG2mfTSO4IiNh0kjxIlO8pJjky3ADJXG1z3Ap+hrodYtyVnSh8AFwxWPbbEKQFNaBTlzF0lCsJxd0n3C1Fijuel16gGxppJajRVNqDmYhmLHjdY/E0dFn/5bRIKzexwmQxuVY74ucU8YGzO0xsHiO2Hn6x7I7HVSHHqEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NumXFPD/LbEN+0m6RB/Ta7krPx2shkHxsio3OnVb8RQ=;
 b=kmVMbfivdOZSLez+sb9xd1FJEtLhocPSzbaJ88G4KLohUebpwE4iBniMIunUlWW2BoJw2+m+dLvfetel386LMo7soiAM/RK/hjzZCjb2TYNmrqtDidfAAj3wTCACD7dSSwVg/2DKPb+r1rnX1tU4b5msMRYhCVTNg4XwHNshbwc=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 10:27:15 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3b3e:f956:cef7:7584]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3b3e:f956:cef7:7584%4]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 10:27:14 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Subject: RE: [PATCH] drm/amd/pm: Fix memory some memory corruption
Thread-Topic: [PATCH] drm/amd/pm: Fix memory some memory corruption
Thread-Index: AQHZmFGjqDh2QdG/uUq78+XqYSvVo699kf7Q
Date: Tue, 6 Jun 2023 10:27:14 +0000
Message-ID: <DM6PR12MB26192FFABF329682D9001C3BE452A@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <ZH7vaonsPEHJpy1j@moroto>
In-Reply-To: <ZH7vaonsPEHJpy1j@moroto>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4b5cddc1-42ac-47ec-b7fa-45001eca9dd4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-06T10:26:11Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|IA1PR12MB6484:EE_
x-ms-office365-filtering-correlation-id: 49dff242-20c9-4cab-9fc7-08db6678988d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tRUTXBr4SuZTS+XFABDswcvYVCC2mGqI5dZMWwrnmBSc8QuOvoeo/q4EUJ92fVFPnpAa/Nxjb+WOQtPwaWmaTk5nrXB1DHrZ2j1ItF63K1op0azFE0fJNeZacf58cgN2j7QqeFA6qhUyDtB7zAK9LNeVAaPZnCXIlTDS7kc2u2G5/WAfQfuUFH60+JNrwSF7bVIGGSN0bE8KiXAtchV4eunbLVrqs8fEEpCFm+4nyg5z8bFezVhGgXMeH443tMQVGeos8DMLWszxGIy2q8xPY7YvaSB6dbjeELhvukYmlgxtU80d3ePiu8JUDplM+4QLfVEypIpi8Kb2+vDMZ/L5Cz8zGsXo8RiJccLYy+qQF5J5Uvv0PjlRzn1RFobfNp3O9R5U9Jc3srT94G8DsAoGJh52qrnt9gsO4mmhR7A5HDSI7YrzcwL38goZfjjuLul+mz+y0zK9KOeL/tcnulQQz7g8QuOor0nocwandayYI0QPB+zSV+u0AIecNetL7QxFZKLRmVeTun+Yf1cJcI8TJ4qbYKprtj9Jj8i9RvSrYbKsFeWsOOInvA6SeNbY0zCdq2pZ/yNeLrEjN68AFF4m9RJQDdvNmkft1klIEjRJNx1HkyHVYpFELdEozFe7czVZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199021)(8676002)(8936002)(7696005)(478600001)(54906003)(55016003)(41300700001)(52536014)(6506007)(5660300002)(316002)(66446008)(26005)(4326008)(64756008)(66556008)(66476007)(6916009)(71200400001)(76116006)(66946007)(9686003)(53546011)(186003)(83380400001)(2906002)(122000001)(38100700002)(86362001)(33656002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gIj9gV3PPP7l8NB99oQxM5mzRi1UpPIGpSBh2skjsHpS44pBzLFmx4XTESMV?=
 =?us-ascii?Q?fAzfMkXnAvXV+KxWaSqxyvQKlTMQhHdNa58UeZCLShJi/AbrrBleWtYdz9h+?=
 =?us-ascii?Q?AnSWVIycwnp45kZMQalD1HlCXPj6A58ntekxCHwyxXRjRObU5g09ujXUVL17?=
 =?us-ascii?Q?Ip78WMems48iSvQFziJxScg3ZfJKUeDYSEtKTubCbBLCzEjiiKCa33fMEnpb?=
 =?us-ascii?Q?bAQNjXrhPnEkW596Uz6pph8WG18Jx4ZODawfzq5KFMRWTTa6SDQ5xmR+e/Uw?=
 =?us-ascii?Q?6HBOPJYdAykUxOZYMvoGs1uBel779rKavvVjjW303isC1AwrLm4bpMoBTXkR?=
 =?us-ascii?Q?sUgj6B1hhgjJr0g9ORarlW/4dbM/2M/FvWozApJceLFMi+o09GSyc4/+HbeA?=
 =?us-ascii?Q?vCbifYUBZNTSBCuqutgaqCBauCTmw61l7NId+IvdIT1f+bnnmuRxCNzmxgYI?=
 =?us-ascii?Q?Qa7I06nyVKP5WTGzL99xxIjpEKmomGEmvsFm+wiVSVagi0Y9DkxcJluSkuMl?=
 =?us-ascii?Q?7UrUm7s4xJj85oinJPJ6LR5SaMjogTYadtTGEjaYSxqe8r+BW1zGYvTSRZaR?=
 =?us-ascii?Q?weDe1oDM/Vh9UmSa+FKsqyGPBM84P5RYc17VJsOwA0W0MNqkNBqFDKQFLNY+?=
 =?us-ascii?Q?LsWtcneIRm4OiKlgYAi2MDx/eVoqnRxkLhSXHjcWQ0qsFxNTsgq2tsfajaIB?=
 =?us-ascii?Q?vMhz+ACBLxnK1frY4BXOJ41gnMt5JLlfcaRviAShbFVcd1Wt4p+RoUMEe4JT?=
 =?us-ascii?Q?LzHrzIsTJi3vfTO/1g9yL5FRZtABANoC54tw+f+0faORr7mYd2/VCO2jNmDf?=
 =?us-ascii?Q?TJqh0smP9leX9z/sMfurLd4vE22bephOAIbQp9SlCX2+Hnz0aCaj0RlMNyEj?=
 =?us-ascii?Q?bTGLwa2aRHYKMGZordziteZt7RVaz9fNP5TW7hp1iBjqSK5Rc5Og38PBoCAB?=
 =?us-ascii?Q?CBGGf9v0r6fHtienqG/7YkPLGNphrYoijPtcROFITQ7ryORzq7KRYArKk/Z4?=
 =?us-ascii?Q?Hp8eUhkO4/2Pf++kg7sOX2BNgtXuxDt3jmclcOTqCj2gaD/e6S8NxEAash7p?=
 =?us-ascii?Q?AXML1Iv6r2R+3R4oiFhCSsBsq3q5B7jz2ozCxp++dX9iegNm2kVOyY/7YRvL?=
 =?us-ascii?Q?1c6iIheGQTvPPa75wmw+4BQjvV9Jk5N0b5Y948WGZNjPpGhyhgczTk8qIZDS?=
 =?us-ascii?Q?n2hgse3HQNBNxKpr4zPY7sCgFuCU36CmH5NV/coOxKyaWuTXaNApAYfOwyLg?=
 =?us-ascii?Q?K5uo6Ep3FfjLktO32YHHSVn1fzkBAaPd2qae2AyZhsW9qa4blfCeBhA9Jjdw?=
 =?us-ascii?Q?Th2mZ5P2S+4dW9OZfLLDllkaZLL+gY6d8zyj/xoJ5s/pBqA4BnI48GMmuRDB?=
 =?us-ascii?Q?6wI0BU9tCu4yx0YaTV2i10WhVe+p3yGiYx6NYO0bK2Qpk/5tZ7gEGXzrejZm?=
 =?us-ascii?Q?05lt4u/eaTIrDsSmaBcexVXD3o+LXLAY/D+r+H4tBtqQUYAFACp6H/zjQ/WF?=
 =?us-ascii?Q?O+bHxwpFTL5TuG+Pjmed0dYCstCPUR2W/sClBBZjx1RqsiaU2OklJJASx8kk?=
 =?us-ascii?Q?T+Ghg3/YkILgL0SqzjI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49dff242-20c9-4cab-9fc7-08db6678988d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 10:27:14.4145 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: COk4aPMo4g7dc5/HiX7qL2gLOJ0OeyKk+xn1tCdN/IOb2ZLbg/DXYJ0K6eYN5Jf3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484
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
Cc: "Zhang, Horatio" <Hongkun.Zhang@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>,
 "Feng, 
 Kenneth" <Kenneth.Feng@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chai, 
 Thomas" <YiPeng.Chai@amd.com>, Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 David Airlie <airlied@gmail.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Thanks for catching this.
Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@linaro.org>
> Sent: Tuesday, June 6, 2023 4:34 PM
> To: Quan, Evan <Evan.Quan@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David
> Airlie <airlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>; Lazar, Lijo
> <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Feng,
> Kenneth <Kenneth.Feng@amd.com>; Li, Candice <Candice.Li@amd.com>;
> Chai, Thomas <YiPeng.Chai@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Zhang, Horatio <Hongkun.Zhang@amd.com>;
> amd-gfx@lists.freedesktop.org; kernel-janitors@vger.kernel.org
> Subject: [PATCH] drm/amd/pm: Fix memory some memory corruption
>
> The "od_table" is a pointer to a large struct, but this code is doing poi=
nter
> math as if it were pointing to bytes.  It results in writing far outside =
the struct.
>
> Fixes: f0a0c659fb96 ("drm/amd/pm: fulfill the OD support for SMU13.0.0")
> Fixes: e3afa4f988b3 ("drm/amd/pm: fulfill the OD support for SMU13.0.7")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 4 ++--
> drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 5ac5ea770c1c..413e592f0ed6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -1535,7 +1535,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct
> smu_context *smu,
>                * settings. Thus we do not cache it.
>                */
>               offset_of_featurectrlmask =3D offsetof(OverDriveTable_t,
> FeatureCtrlMask);
> -             if (memcmp(od_table + offset_of_featurectrlmask,
> +             if (memcmp((u8 *)od_table + offset_of_featurectrlmask,
>                          table_context->user_overdrive_table +
> offset_of_featurectrlmask,
>                          sizeof(OverDriveTableExternal_t) -
> offset_of_featurectrlmask)) {
>                       smu_v13_0_0_dump_od_table(smu, od_table); @@ -
> 1548,7 +1548,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct
> smu_context *smu,
>
>                       od_table->OverDriveTable.FeatureCtrlMask =3D 0;
>                       memcpy(table_context->user_overdrive_table +
> offset_of_featurectrlmask,
> -                            od_table + offset_of_featurectrlmask,
> +                            (u8 *)od_table + offset_of_featurectrlmask,
>                              sizeof(OverDriveTableExternal_t) -
> offset_of_featurectrlmask);
>
>                       if (!memcmp(table_context->user_overdrive_table,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 0bd086360efa..cda4e818aab7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -1524,7 +1524,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct
> smu_context *smu,
>                * settings. Thus we do not cache it.
>                */
>               offset_of_featurectrlmask =3D offsetof(OverDriveTable_t,
> FeatureCtrlMask);
> -             if (memcmp(od_table + offset_of_featurectrlmask,
> +             if (memcmp((u8 *)od_table + offset_of_featurectrlmask,
>                          table_context->user_overdrive_table +
> offset_of_featurectrlmask,
>                          sizeof(OverDriveTableExternal_t) -
> offset_of_featurectrlmask)) {
>                       smu_v13_0_7_dump_od_table(smu, od_table); @@ -
> 1537,7 +1537,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct
> smu_context *smu,
>
>                       od_table->OverDriveTable.FeatureCtrlMask =3D 0;
>                       memcpy(table_context->user_overdrive_table +
> offset_of_featurectrlmask,
> -                            od_table + offset_of_featurectrlmask,
> +                            (u8 *)od_table + offset_of_featurectrlmask,
>                              sizeof(OverDriveTableExternal_t) -
> offset_of_featurectrlmask);
>
>                       if (!memcmp(table_context->user_overdrive_table,
> --
> 2.39.2

