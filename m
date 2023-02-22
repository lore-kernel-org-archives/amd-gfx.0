Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA4BC64EC7
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 06:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8F6310E3B5;
	Wed, 22 Feb 2023 06:41:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D192E10E3A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 06:41:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jk5NhrJiT5hHG0y94gB2Ik9zTueJrJO+U96fRAYldxEk86gApt9r0ggNYVIgqB3C2hftNg14+riZyPERBZkWBeDmJM3Ia/8UpqwJ0UCzAYhZ85lAlh2q216zoIgiibc/wwdDAfM1Q3O3GXKmUl3VO/Ovt3E5B4CrreMfoiq44puWkoLf9h5XzwlI2xCtS6LxE0OEOAk8KOqGpgccoD83e1RZDpt+ZKewBu54B1d76HAwcAqOA6jUqxrqkJXk7kNaSezjQALGQMY4hzTKrR/DN8TU31uKrzCmRIKPoto8Rkr8OdmiFNUEbY6gPYxWweT0kXbMQY+rv1a5mDjMcGm8+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BIjc9QaFCVB7DcOoHADwrOL3dy2Yb5rznH9MraP96g=;
 b=c+NdudL9/7bke9U0Qnw9bWRU+nSHYx3FrV+zLGyyn/evqavmieWYYP2Oe6uV931geyK7n7E97m1hZCwbubgc4tag+qSAlUkr2GcZ/uGD15Xvi4NsH/JM1EEfcpxhlAPnbWIuJ+73UQT4IB30c4R1t3K4Sh3a4LmpqIB3kYPwdpahTt5yVNboNzKET1h16hMqLRezs2lyyAh4iZINrt7aDI1uQBGr5QtgL/QbaeZm/XpZdemrAYFayhyx5q2cIHSxtDYe6Ss9IUiIH1Yka2tc72AArfO+6eMApk3VZeQ04bCxfm0B9RTHA8Kl4JaUMHEgmFYwRmahs8b7eV6cpfTVvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BIjc9QaFCVB7DcOoHADwrOL3dy2Yb5rznH9MraP96g=;
 b=H/sAnlthKd/WZ3KypcHFuf6hEleYsaM157s4ejf9HSHc4LOh+U7whV3KK4YZNl6lDtly191/YLAqbEfolcrvsocrtpApU8ADhBHvjmT8QA5t0fpAUkfyUmURsDkFmgVfEXJLEET8ZISoPTwvFAzJD1kalszVHbiJOT675e5h98I=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by CH0PR12MB8507.namprd12.prod.outlook.com (2603:10b6:610:189::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Wed, 22 Feb
 2023 06:41:19 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8%7]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 06:41:19 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: exclude duplicate pages from UMC RAS UE
 count
Thread-Topic: [PATCH 2/2] drm/amdgpu: exclude duplicate pages from UMC RAS UE
 count
Thread-Index: AQHZRNnfhJWXn21AxkWfj0feUwkryq7aR/uAgAA9IfA=
Date: Wed, 22 Feb 2023 06:41:19 +0000
Message-ID: <BL1PR12MB533424F6C5BD4E7BEC2D9A1A9AAA9@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20230220031717.18738-1-tao.zhou1@amd.com>
 <20230220031717.18738-2-tao.zhou1@amd.com>
 <DM5PR12MB1770DDC217BC1558684F97A6B0AA9@DM5PR12MB1770.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1770DDC217BC1558684F97A6B0AA9@DM5PR12MB1770.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-22T06:41:15Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=83daadb7-21b4-4d9e-a24c-0ba42181f1b9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-02-22T06:41:15Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 671b8906-dcd3-41cb-ba7e-b4bd794b8229
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_|CH0PR12MB8507:EE_
x-ms-office365-filtering-correlation-id: 4275003b-3c06-42cd-80ed-08db149fce37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EmMaz+ZpYM1tR0QGiBw0b7fY01GZL8wA0d6EXtogk/b8gHzT94ct5ALt0/CpkzOazEAc7dwGueL1Ojw0RMxrgArzXLo/sfALNvgKIkgOhRLZFD90I56Km3IcRFeoEv1lavJT7ceNG4iAAIBlyjWE1V6cE+0xHX5LAO8MUExYu2yK4p7mdmDnZ9UgQT4F2gijx7UTegLz+6vqxhnputSwqK67HjlNEze99+dcWVJezdlk00Y88SugLmdYQbjbULafRZdNIIPliySLOdFtsSyVD4tShtRkGCcHAAMYMh+kTl5lJgP09YpiztK7ew1Eybf2lGw1jrPtsRs4TAg86ygqnRxXkjcIDAdKTGLO78FOYjMSUuu6YK8Txd9TUudGNGWdqA+V5pRQdw5lWo21lZ+sD1Ml0waKCi3HAJhzYcVrgoHABTFDQYiM1h2S3lChvUmj5tlxJqyC4ZtCDww7Xjjrg1vvVX8GYFtqPAxyqXXmbVxkWyqX3aYGbhJy899a6jBeh3v/PW+W10mDkX+Gmawtg2y911AHX4skySMCUubkRKMRdCpL0GJlcLji0lm5KyOiMblM+PxI4SUjH+7zLTmKVE153XCR9lqfSCSr+rvGFXvdamHTvL2+j4gKLk2qJ9AjkZ+fnLTmkH8h32mZ7fsgwosxkp9u4y1JiMlpHzNI5MQI2KjN+vGerJ0GsSCqKu2ajYuztUgdDhE3tqgRSLj0JqghEa5CHoz8XLdEpHWla/k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199018)(38100700002)(921005)(122000001)(83380400001)(86362001)(55016003)(8936002)(66556008)(6636002)(64756008)(110136005)(8676002)(5660300002)(71200400001)(38070700005)(7696005)(478600001)(33656002)(316002)(41300700001)(66476007)(53546011)(66946007)(66446008)(52536014)(76116006)(186003)(26005)(9686003)(6506007)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rMyO4g460SykjZviGaM1G7aECKdeeK0Rbe11QeurRQg/jPmt6+YU1T+FLq3W?=
 =?us-ascii?Q?X6aFrdL2CHIDXHhQQhF0OJqtRa7FWaqzgieu6CDgyXQPvRSjkOLt4SCZMx1S?=
 =?us-ascii?Q?vFdkEtgAxx6HigqGDDE3qNcdiGKIuLBOslBa2vTw59jbZKPSqTZUUngFmtk5?=
 =?us-ascii?Q?+sZBtq0U2IwqnMuAvugzpYsPfK0PJFDSY1TaPtggWFI9DXPIY/qkf+W7GMN3?=
 =?us-ascii?Q?v9SaEe66fYckHoa9iQIWBUTVyQdNbQ5+Sd3XyZXJc7wMcSjhWvgJUy4udqkp?=
 =?us-ascii?Q?6Y18ocW55sWOqJlLhKy9WDD90FqGxj10rVUfJxe/GIP7a7OujfmIzgHGgCHc?=
 =?us-ascii?Q?okMOg5VasHkjOM6cheCz7ZV7Ic5zKLajLfCgzBYBHrJAGQMbraCsEwhiAzeh?=
 =?us-ascii?Q?Tbih+VFALNlHY/08GR63BG629HP3zpHHglLGaJuEp78ofqw/SM+LsfeogUjL?=
 =?us-ascii?Q?PPHOpgF8mkH1xNNi9VQMSDBsIUNCN6iK+fDVt/2Gu4nG2AQcKgiZD3LUyJP+?=
 =?us-ascii?Q?gIwKBEx76fhdBxo7rLLBczAryeNDVSObrPypfrN5e8q8IRwUehLoPze3Vd/e?=
 =?us-ascii?Q?IBNgwInQlj7kaWV8olfkK3PfjJp+37089aSL1gTkBgjuJe/y2d3VBfNxpH/f?=
 =?us-ascii?Q?+YW92Kka00aLzjAF3G/XwBsv0cEn5XzeyWHSqnNVttOkKF28mWg5v0qztjsG?=
 =?us-ascii?Q?CXodoGxarnvY8uNekz3nvGZDNq5iZgTKJxRjYzOp6WZ4JuxNlCyccfMCMOvz?=
 =?us-ascii?Q?SDnRhCKyKz0akugZlq7SD6+8SnUTTDUXgyxVs7kGSY63TLmd2xBUPYsG7oB0?=
 =?us-ascii?Q?1t672i/1lGIbskEoWYkPuJPGRdl46UNJgBE3TG0iCt03ZqW5MZsdzJM/iJ6n?=
 =?us-ascii?Q?m1vSehBiJZRDtHsBS9L8b6gssmwhtEFZHeYB2DbR/mydNAw8HZFHradiNBpV?=
 =?us-ascii?Q?Wbj7pV77phScuzgFF0bx8PP4hEwY3E0xtKjJ/DMtS1F7Hxlhv4s/uvk6ziJ0?=
 =?us-ascii?Q?mHy8RpXxIpy9RfuPkdjBBFbO5Nn+vtlUgkEv7VWRYImNwToZv/rQvf+4kOyW?=
 =?us-ascii?Q?Vi5VLqW/H9WrFc1qJp+2JIOh3VxxcOsv1haZOMdv0030ZUzat+XNnugCCizR?=
 =?us-ascii?Q?wOINQEIaid94E3yLM7V00Jl2b06KyTqp7TIoJmE3tFz6Jlw0kYGEc9am5eDn?=
 =?us-ascii?Q?v/7ziYDjeNbev5cWaPWUua51ExGE+lueRLmH3EwsXWXRY3ekJmoFay2D2DDJ?=
 =?us-ascii?Q?+2EbYot9F1847tNRrVjx7k0IRySlLOCcMljmeL3dh1XHWo3aX2PcfOdKEC5I?=
 =?us-ascii?Q?QeLXrwtjintZ9H1qfpaFqxiQh/hIwKHZHwisDDRCg6/v1BvA2fsGmaojyjw9?=
 =?us-ascii?Q?IwinRFonp4drKEkUM7pkkmrJD+PlwIKOMH0ASa2w+1qG3TL3gRr2EsudNHip?=
 =?us-ascii?Q?SEHhGVtBq/ipbdXjr8KJ9lBly/kUPn93f7pOdDULmRQqTy/gHk4ECLViT9d9?=
 =?us-ascii?Q?aBMjqGSX+mL42a/u7d+MwGwGTcYcHhC1REeXm8PZ+ksvNBpjVE85FEGYG+Pg?=
 =?us-ascii?Q?kG48qPTVonPz74Hgf6JHTIeinn8LaYACxyyqhXv4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4275003b-3c06-42cd-80ed-08db149fce37
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 06:41:19.4844 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: opLT0Dm8H1TBznDdbWaGTSoT3LrNkI5IAMbPkNg+jCpQXr/c5Qs7bYJs/chD4xYqRKwc+K67DybNl9UImblOAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8507
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

Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Wednesday, February 22, 2023 10:53 AM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>; Lazar,
> Lijo <Lijo.Lazar@amd.com>
> Subject: RE: [PATCH 2/2] drm/amdgpu: exclude duplicate pages from UMC
> RAS UE count
>=20
> Ping...
>=20
> > -----Original Message-----
> > From: Zhou1, Tao <Tao.Zhou1@amd.com>
> > Sent: Monday, February 20, 2023 11:17 AM
> > To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> > <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>;
> Chai,
> > Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>;
> Lazar,
> > Lijo <Lijo.Lazar@amd.com>
> > Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> > Subject: [PATCH 2/2] drm/amdgpu: exclude duplicate pages from UMC RAS
> > UE count
> >
> > If a UMC bad page is reserved but not freed by an application, the
> > application may trigger uncorrectable error repeatly by accessing the p=
age.
> >
> > v2: add specific function to do the check.
> > v3: remove duplicate pages, calculate new added bad page number.
> > v4: reuse save_bad_pages to calculate new added bad page number.
> >
> > Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 16 +++++++++++++---
> > drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  3 ++-
> > drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c |  5 +++--
> >  3 files changed, 18 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > index 6e543558386d..5c02c6c9f773 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > @@ -176,7 +176,7 @@ static int amdgpu_reserve_page_direct(struct
> > amdgpu_device *adev, uint64_t addre
> >  	if (amdgpu_bad_page_threshold !=3D 0) {
> >  		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
> >  					 err_data.err_addr_cnt);
> > -		amdgpu_ras_save_bad_pages(adev);
> > +		amdgpu_ras_save_bad_pages(adev, NULL);
> >  	}
> >
> >  	dev_warn(adev->dev, "WARNING: THIS IS ONLY FOR TEST PURPOSES
> AND
> > WILL CORRUPT RAS EEPROM\n"); @@ -2084,22 +2084,32 @@ int
> > amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
> >  /*
> >   * write error record array to eeprom, the function should be
> >   * protected by recovery_lock
> > + * new_cnt: new added UE count, excluding reserved bad pages, can be
> > + NULL
> >   */
> > -int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev)
> > +int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
> > +		unsigned long *new_cnt)
> >  {
> >  	struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> >  	struct ras_err_handler_data *data;
> >  	struct amdgpu_ras_eeprom_control *control;
> >  	int save_count;
> >
> > -	if (!con || !con->eh_data)
> > +	if (!con || !con->eh_data) {
> > +		if (new_cnt)
> > +			*new_cnt =3D 0;
> > +
> >  		return 0;
> > +	}
> >
> >  	mutex_lock(&con->recovery_lock);
> >  	control =3D &con->eeprom_control;
> >  	data =3D con->eh_data;
> >  	save_count =3D data->count - control->ras_num_recs;
> >  	mutex_unlock(&con->recovery_lock);
> > +
> > +	if (new_cnt)
> > +		*new_cnt =3D save_count / adev->umc.retire_unit;
> > +
> >  	/* only new entries are saved */
> >  	if (save_count > 0) {
> >  		if (amdgpu_ras_eeprom_append(control,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > index f2ad999993f6..ef38f4c93df0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > @@ -547,7 +547,8 @@ int amdgpu_ras_query_error_count(struct
> > amdgpu_device *adev,  int amdgpu_ras_add_bad_pages(struct
> > amdgpu_device *adev,
> >  		struct eeprom_table_record *bps, int pages);
> >
> > -int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev);
> > +int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
> > +		unsigned long *new_cnt);
> >
> >  static inline enum ta_ras_block
> >  amdgpu_ras_block_to_ta(enum amdgpu_ras_block block) { diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > index 1c7fcb4f2380..7c6fc3214339 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > @@ -68,7 +68,7 @@ int amdgpu_umc_page_retirement_mca(struct
> > amdgpu_device *adev,
> >  	if (amdgpu_bad_page_threshold !=3D 0) {
> >  		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
> >  						err_data.err_addr_cnt);
> > -		amdgpu_ras_save_bad_pages(adev);
> > +		amdgpu_ras_save_bad_pages(adev, NULL);
> >  	}
> >
> >  out:
> > @@ -147,7 +147,8 @@ static int amdgpu_umc_do_page_retirement(struct
> > amdgpu_device *adev,
> >  			err_data->err_addr_cnt) {
> >  			amdgpu_ras_add_bad_pages(adev, err_data-
> >err_addr,
> >  						err_data->err_addr_cnt);
> > -			amdgpu_ras_save_bad_pages(adev);
> > +
> > +			amdgpu_ras_save_bad_pages(adev, &(err_data-
> > >ue_count));
> >
> >  			amdgpu_dpm_send_hbm_bad_pages_num(adev,
> con-
> > >eeprom_control.ras_num_recs);
> >
> > --
> > 2.35.1
