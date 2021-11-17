Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7908FC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 03:08:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF6A61B48
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 03:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2EF6A61B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A88F089DD8;
	Wed, 17 Nov 2021 03:08:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A9AE89DC9
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 03:08:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGLDKVCcIOkaEspByjF4pg6uEp3qwamIGng1sg7mcjM0AwJsenOEmklyYrutxVJI7PKiSZqkMe5n6jFproWLF02tI4BEgpje6IWQzEjOkhJsjIdkn8zc0ppl+fx4yuaYiABnE94ey7Kbj5qlUMdpggIVLV6dzrdHtlojMoLfYXNdMMAN7d0lbppUBtymFYzpJSefzHjqSC8FuWKBhjXX9BpLcQJz2+YsRbn41LzrwCEWleguk6iQCUfGmqm7qrnKP3n3yAMKQ1oMaM/WDpd/D4hMBH45x0/ZVMPB8UOBkFwfaqOZfrJ7oHPdMq+XkmmZwx6ls6/FVsiHRpwx9D1nzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHJY596NqULu0JQzmoDGUBvZhnHjn8USGfoEEllQixA=;
 b=M6e9hl6iP+SNdhl8iRMR6uLBURzrpugkD4sn3QsC2hDa+CXSH7TmpRDDXjS5CiEydHkfIYbWB1sz2AOnac6t9rZ5sJG5uziTcRJRnfnjmnkT3NdVZTZyf1eoHDGruQR75s7iyshawSxrfllGEe7bqVtXhyZpIi/jC/vJKe7le9PJDU3nl0/aagYm0o8qklQOi84mQoIXCyTLEl1cq/kG0Ntnn5nBtCM9zFOt1TY6mTCNhD56F31b+mx46jYZEcIdPW9QHmN9o3Kl0BT1eBCIDWByeDtqfg5fr3FMdq8S3b3UXURO5u4anG3aIO6HQhT2lG1hs+O+kmVY0/n9AnCkMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHJY596NqULu0JQzmoDGUBvZhnHjn8USGfoEEllQixA=;
 b=ZH21XsdzKBHKWLScFEggf0bCEQupc4oy4L0le9sRUnSK1VAZUrrFOhPAQNxKBRdswwS2Iid7l6kWnnic3Ojiq6lYgFzltrZS0T+Jq069A1UQ/19mPfrrg0HUOyp0FcIuvXp5WdhqPxRTWdVvDcY/N3aLfUjxyHaTLxx0GxUajWg=
Received: from DM6PR12MB4649.namprd12.prod.outlook.com (2603:10b6:5:1d1::32)
 by DM5PR12MB1737.namprd12.prod.outlook.com (2603:10b6:3:10e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Wed, 17 Nov
 2021 03:08:01 +0000
Received: from DM6PR12MB4649.namprd12.prod.outlook.com
 ([fe80::74c2:af5f:57cc:90d8]) by DM6PR12MB4649.namprd12.prod.outlook.com
 ([fe80::74c2:af5f:57cc:90d8%3]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 03:08:01 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add recovery_lock to save bad pages function
Thread-Topic: [PATCH] drm/amdgpu: Add recovery_lock to save bad pages function
Thread-Index: AQHX2sBFR5rMzgWJc028XAAHB/OUsawF0e+AgAE3WrA=
Date: Wed, 17 Nov 2021 03:08:01 +0000
Message-ID: <DM6PR12MB4649B835E6A801C8EA055105919A9@DM6PR12MB4649.namprd12.prod.outlook.com>
References: <20211116080146.3183-1-candice.li@amd.com>
 <DM6PR12MB4650F622273174D5E09B0A9EB0999@DM6PR12MB4650.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4650F622273174D5E09B0A9EB0999@DM6PR12MB4650.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-17T03:05:24Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6d8e04a3-9476-4324-b33f-6f355aa8f42f;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-11-17T03:07:59Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 7fd5840d-0431-44a2-ae88-73f73ac9d9bd
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56d078cd-a96a-4c19-152b-08d9a9777761
x-ms-traffictypediagnostic: DM5PR12MB1737:
x-microsoft-antispam-prvs: <DM5PR12MB173742064AAD02D08BDA98BC919A9@DM5PR12MB1737.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Enxk8/iqJTszDLzcXmvg5OUYzdxZdayZNlu4yqSv6y00E/tfaheDQ6TLL2Ru2H9meCP6laVGoztZ76vVk+eSCdl3jKpJra5OAJGPMyIBfKRC3qh0yAi0by7SwMcX14x9XY4qNBqztOWGvOUj4K8dQiBRe8aPRHU2Aji7kMl4QSMZGSgJBcQxsA4NgxjBodhYlWxeRQsX0TEM7NVYxly0+i4XGew3Cbvql1IQqbROT+/bYj9V0ObI4pbpJLkiEI4mOHBWx3MXK0/o4c4IpXzfmkdRfIKhVn/PRGGOYorEj1RJqgJU1OSI9LLV0P9FvakWF1xSUkgmEAdjwxcTqiblU+QEhsdSSZ5ArCIV10BkMdK+M5AaaHw9UxRjiMq1ZvaMLbAcyH+rZoKD3yMTl7TvNJ3Tje3epO5Y857o/dLIi1G/TyCpAgxeEtiGGOXnxt9iMQqYM6zFEu6cs/KC8dO7zIsswrvjUQJBTCLGyV+8/ywoQp2aJCDljH/59ARDucv+6vBlYEKmTcDSGn9HNRhnSDqJ8iLa/3FOoU61IcHGuynBhTs13pGtWlW35Gso1l5RhBsNOgj4gvEExiYALLEeXCqD1Sl59NnwwzLFlTEOzKaJb2UBy0ZE3dx/RnjEjrmJZGpy+JkT0Fw7PFgJfc7biDbuHoCxYRVC+dP6oxPXjFZBRdk8T7d4GE9+wqzjOz+CF4u7ciH+8ZDNuctZbVsxMA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4649.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(7696005)(52536014)(4326008)(86362001)(186003)(66946007)(316002)(38070700005)(53546011)(66556008)(66476007)(76116006)(508600001)(83380400001)(64756008)(5660300002)(8676002)(26005)(8936002)(71200400001)(33656002)(66446008)(122000001)(2906002)(55016002)(38100700002)(6506007)(9686003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u/kBnhQZzv+FDf8COqmZps3FoxzXfg+Ms8wmxD9XBGOs6m2lWv/0iMxR8yoL?=
 =?us-ascii?Q?zmsh3MrTiBFM159NO/85HGq25F85TYgOTvfI67LOZ2PXKQVVmzHyjZQXXg6a?=
 =?us-ascii?Q?iSuG14h8UctEVA4sUmFRsxddwm6XeIFoefVpAU+HFiLOhoUiuxlPQreBKtDt?=
 =?us-ascii?Q?BbDMmuHQKvgJmRDdjCkEd4AL2t8c3Ca3/oaJKuWsxLZTN64jncan7HwXRVKO?=
 =?us-ascii?Q?TPLTmidWwwSWtVC2XRZpqFTLcq9vYoQlUK9rrTSCDDKW290OPoAMeWc8pgpv?=
 =?us-ascii?Q?jIkApQE5ee32BCHMS18W25MPZmUnMAKc2hBSutkpFvnXeSNpFT4urSCqEXFX?=
 =?us-ascii?Q?Yee00NZaYWJB0wYtpdQ83UAsBgvZdeLTNnLNA8qXGUDwioJeQOIsxG/sH2T0?=
 =?us-ascii?Q?FS+f5J20uWDbqPBjcYeSmrhT7MgZBXckqIgyA9YJ0Kmr7O0FTyaIb8ZX16c2?=
 =?us-ascii?Q?Jwe6Ydgho1YG8gMLTRphVa6Wem8t9uFZo1/tlIkTAp5iDwiNchZX/XHHyLas?=
 =?us-ascii?Q?9RgLzQIG3Upa6PsiMSsqE9T5YEPhAWEBl+MhoFr4pkMgoVnYuZ8JLp8LLLeQ?=
 =?us-ascii?Q?k1wViaK48xA6ZrWKv7RWN1I+LfWicY+lpIRM/DhBN2qEZ0lsnb/VjUZvhI8W?=
 =?us-ascii?Q?8mL0J2KTEEf9DY6RDl5sPNMG4w3Caygo22TgJ9hqNpSTRRqGmx55/nJQ6Ymx?=
 =?us-ascii?Q?W8+otqC6COrJpulZVtsWnPOjUjRs/zcTJB+EMs5HKAxO740oVDpaw6qc87LQ?=
 =?us-ascii?Q?yQRT/QIdM4nZd5F4yRNMtmoVvrAxhodQkm4pP6RhJmZyWy72iU4VN5719fHI?=
 =?us-ascii?Q?KAJLNMLTdZ0axqHWeMY025rHJKOAZlUUyi9iFwjxSary/BQySrLmTYB9zm49?=
 =?us-ascii?Q?/t8teNpIyJMQxYS+VCTNtZUWZiHQFbTAPrIYbONiBGVbUXAoCYuxj+Z1Sq5R?=
 =?us-ascii?Q?+CMHnj73IlWJ77hgwHVzNSpJXxqyNFDkXGMCvFACvjdydAFt2y4kBcsEHpyO?=
 =?us-ascii?Q?CVd2m11VB67w4bIN6VWkEtA3tCKufhfrcaotvsB7e8Id+20+ih9y5VL5ZlgD?=
 =?us-ascii?Q?WlKPfF0tjBUVMWy/6FDmUM70XQfyx8lSfHnTLceGDxIwPmQafoKSnxDHNOFf?=
 =?us-ascii?Q?zvh9gFj5jOQDW2bk+Njf1ZZxDqSHE6olBN2fWImqKeYw7moU/GL/Tg3ngC0M?=
 =?us-ascii?Q?BwZFnovaZ22sdnlg0/pcoHKAHeWbk5dGrkM0fFzepCRQMoZhUTVNKP5hjPg1?=
 =?us-ascii?Q?/gJr0VAvI2LrPousVd+M5Y6G8FaM623ADwxnOb7MU+byWc0kugUsp/+Vn3l0?=
 =?us-ascii?Q?2EXGMosjw2FWTQFVwIHt28CgXiZ3o8amOcT0pvG5lXMe1VOqGQgs0iDIqn0c?=
 =?us-ascii?Q?f2dkD1hmq4UTZ36liQcY1CR+ffxCPcFUYgq61GR18hNflDGoFAQcsyexLR12?=
 =?us-ascii?Q?Tm0Hz7xTTVecoi8NLrZnHqVz1EAhSY5pm1ooHviJPGzMJcx5syE11ayP6HSx?=
 =?us-ascii?Q?mNzuEhb80qhJSgNhCQIuxgtuXvCbS1h/wX7rWF2PpQWGyzpNpJ8EFVcHbQsx?=
 =?us-ascii?Q?CzO6Kwp7hU2YktLeC28=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4649.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d078cd-a96a-4c19-152b-08d9a9777761
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2021 03:08:01.7559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kde0TXaQyFO0v+TfmRDlhe5TaJ9pbDNAuDN5hsf/MeXJQJ2f8QsLG2wECgytF6uf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1737
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
Cc: "Clements, John" <John.Clements@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Thanks for the review, Tao. Updated the position for unlocking.

Fix race condition failure during UMC UE injection.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 08133de21fdd63..53b957a5b9a65c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1935,9 +1935,11 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *=
adev)
        if (!con || !con->eh_data)
                return 0;

+       mutex_lock(&con->recovery_lock);
        control =3D &con->eeprom_control;
        data =3D con->eh_data;
        save_count =3D data->count - control->ras_num_recs;
+       mutex_unlock(&con->recovery_lock);
        /* only new entries are saved */
        if (save_count > 0) {
                if (amdgpu_ras_eeprom_append(control,
--
2.17.1



Thanks,
Candice

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Tuesday, November 16, 2021 4:27 PM
To: Li, Candice <Candice.Li@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Clements, John <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add recovery_lock to save bad pages functi=
on

[AMD Official Use Only]

> -----Original Message-----
> From: Li, Candice <Candice.Li@amd.com>
> Sent: Tuesday, November 16, 2021 4:02 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Clements, John <John.Clements@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>
> Subject: [PATCH] drm/amdgpu: Add recovery_lock to save bad pages function
>
> Fix race condition failure during UMC UE injection.
>
> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 08133de21fdd63..711b5fb26d47d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1931,10 +1931,12 @@ int amdgpu_ras_save_bad_pages(struct
> amdgpu_device *adev)
>       struct ras_err_handler_data *data;
>       struct amdgpu_ras_eeprom_control *control;
>       int save_count;
> +     int ret =3D 0;
>
>       if (!con || !con->eh_data)
>               return 0;
>
> +     mutex_lock(&con->recovery_lock);
>       control =3D &con->eeprom_control;
>       data =3D con->eh_data;
>       save_count =3D data->count - control->ras_num_recs; @@ -1944,13

[Tao] Since recovery_lock is dedicated to protecting eh_data, can we unlock=
 it here?

> +1946,16 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev)
>                                            &data->bps[control->ras_num_re=
cs],
>                                            save_count)) {
>                       dev_err(adev->dev, "Failed to save EEPROM table
> data!");
> -                     return -EIO;
> +                     ret =3D -EIO;
> +                     goto out;
>               }
>
>               dev_info(adev->dev, "Saved %d pages to EEPROM table.\n",
> save_count);
>       }
>
> -     return 0;
> +out:
> +     mutex_unlock(&con->recovery_lock);
> +     return ret;
>  }
>
>  /*
> --
> 2.17.1

