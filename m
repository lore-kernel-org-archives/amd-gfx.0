Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8745CEE49A6
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Aug 2023 01:25:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3E9010E16C;
	Mon, 21 Aug 2023 01:25:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D1DC10E16C
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Aug 2023 01:25:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eebfuGWcdTw5VMzZWU64SgL5+aIwqy1Ef1s0/JOOGSHQXMudHgNHEQ37AzR5vaynRoGUhTnSBJPmVVh0VR4QnjgP50c4LFSCGywlonOsKPWfs2LoeIhRa7rlDn+4MqXF2dksx8Fopj1TBbrT8pStdAAHt6L5gqZ/WsW38jgvURWTfXzxW8fNJ5QM+TfGTnNLk2ZAXR14nEbnRARvNXVy4ivFCbIR3xCZbfwjZI5fkqguyZFVs+/KGqe7leFlU0CFwbNWpa5E2zb9+0gXAgExRSCRn7N8U07UmHiVFWADKWKoMZyCf1fRbfeAfxEYyxZsK8R880FLOr/CxAKp1caYlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgZdy3hQcqLXwb0MVHnKQ9/zRS0qLhHenSBb5xp+tx8=;
 b=h3vQJ5VaXRXAuwNLPrTDKCcUBNoW96jjiLSiGMClyhoCFojhtKZxvnwzWoUxlP9W6NwJJHMxbyHpi6lU529Eu3WMd69RH++aCvArypzszD4cM2dl+90cmGYfcXWmAR76dc4+u5ojOGPHe/emYCBM71PSTqCDthfrgLYsRh5IXUETDbKOEE3Tgbk2naaCvjSef4SndT8XcCgKS3m2KF8xjprZiw9r3DrXU6u9pz200+gT3fnYKmRs4yI2BPBaNAeAKgRBLQkxMN6Y2GEqURoTt/euMx6AwTgxHYsKwzGdG1kXIqfKQYk66NWzzgjbgDZTNS/701Moq+Xw5z2PYCKMsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgZdy3hQcqLXwb0MVHnKQ9/zRS0qLhHenSBb5xp+tx8=;
 b=2MXIpCKQebf2JJCalJYRb9On5eIaK4hg01nT7ZpSZ19Xx6MB9fQzoAZu9eYlcCmLXYPh1oiedDFBUDGdIfPNr/fDKlxg1R0pZGSPJzD8Tu2URwB8yHgH4g5jDC/9BarRwULz/nfIRXkVhIN56GG6SzHofgT7Cprcj0UfONZVc+0=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 CH3PR12MB9453.namprd12.prod.outlook.com (2603:10b6:610:1c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 01:25:31 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225%3]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 01:25:31 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: fix debugfs pm_info output
Thread-Topic: [PATCH] drm/amd/pm: fix debugfs pm_info output
Thread-Index: AQHZ0gkfWTUBKbNK3ka2waoNFl7ekK/z+IDA
Date: Mon, 21 Aug 2023 01:25:31 +0000
Message-ID: <DM5PR12MB246956A65C137CD1BB2E6A5AF11EA@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230818192035.10756-1-alexander.deucher@amd.com>
In-Reply-To: <20230818192035.10756-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=51a7d218-40d7-4a2d-9157-a76065ad6996;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-08-21T01:25:24Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|CH3PR12MB9453:EE_
x-ms-office365-filtering-correlation-id: fda325ba-6c5e-4901-54c9-08dba1e5826b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fjq2MeHUtkmW3ASjK1fACiIs0vUFPSydW5RzYshM26De8idHe67B3/+Cp14x2e7mSJdIudwqjKotm1Op1Jz4fkCvfgXXqbS6hHJR5Z6iqo3iZTEIog/cZ3jv/u7b4xOuj4iOgEVQXrrj84RcdDND6PByKWXpw/TH3TSMmRE9EAvGNjDGd8XLGwitogO6O9489Qzx4XtN1Q5ggH6jJ8E/7MSsOFm9XqFsJdSjultg6Q3I8sOcw2afFoCkhHUPAGgIwic9ckPk5B2Una/jFDZOfSS7CSdLKIB7Zjaaw/caHi9M5Zv5r+XEqppPVxjvDaLjiYEDpmhK+uwDh+ilz7iOwFPBPwDVeTy08eTWAuIk0XjSk0ZgqWSqzP8+Z/K3AAr5yjzZiDHhnz8CWqxIn/7VW5H+LjWnMyUuY6b/rCjmRDSbSbhktftYHTmL8eg4cYnpldEzUqOylSTtp2HIAXODcFZA5nRSQbbjZ3Fu6oeODqFzowU3xnuuHMv+Jr3EWXcXimvLEO5z0IMlRLFf5ul20Z3rRheZLLwaRIHmln1JqviJ+Fyk2MLWp6ofsJT+ZpZ4d36WM3Ye5Nl5YJOTPSpz/iDBRSNuGIoR1hsu1ycmQdM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(186009)(1800799009)(451199024)(66446008)(66476007)(64756008)(76116006)(66556008)(66946007)(316002)(9686003)(110136005)(8676002)(8936002)(4326008)(41300700001)(122000001)(478600001)(71200400001)(55016003)(38070700005)(7696005)(38100700002)(53546011)(6506007)(2906002)(83380400001)(86362001)(5660300002)(33656002)(26005)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tQka1EcEQNCxWDndN6L3mUYFNU1FG1rsMjAvOKKaDaw8KNSI2s6+0fgOkUXC?=
 =?us-ascii?Q?9s3TWTYzkWpIKSc7qzYoep71XEib97xSfOx/P1vDTzZSEahe7XWC9UK1x9Bv?=
 =?us-ascii?Q?oOs7nldEyzUxAuyEjowAGZ6y0HmS44JhPSUF4VvhlJys8hI6TXqXJ5D/pHyk?=
 =?us-ascii?Q?3G7801gfKqWZiN4IqoWmJCM75eMeElYzQzvc/Z9VTtiz8Lyd0/iqG4xdylL0?=
 =?us-ascii?Q?015tYkhEybYM9eUpSjF0DdHAUd7up0bFmgfHpBkOii/0JNEH/uCs4vyGwbNY?=
 =?us-ascii?Q?ULOtkY3rCsnhEQuX1yJPOk3hC9MX+XG3qqC2OW6szSm0tQgFquA+TNbVxKs8?=
 =?us-ascii?Q?hNkR4/Kf+binsQzx3kIhesjUunoIhl29Gnnkj2EFaPhx0K8AcDMKrlxh5smf?=
 =?us-ascii?Q?TCX1+7ta5h9mEIUE/GgPTM5+PHa/9duIAv5SKrex50Mz8ObB631PC4JzPyZq?=
 =?us-ascii?Q?E6QEQu92S3qE7rGsupzOUuzAPuMYy0hzxJzdFKmT3qxdkd2To1LqZlkONYj0?=
 =?us-ascii?Q?7olwADngr35N6o0CvTvOx5LTHOU0Kmp26aMHDAvAglLgYYIj+rtDJ+tmMZDb?=
 =?us-ascii?Q?psm91TT0S81Y7TES0hWDfjfnDU+mthWboWtJSF2HC4gtVnX/i4oj4GOdvn7L?=
 =?us-ascii?Q?8/ME/pvCF+1JuZdZTOgWtXTFT+Nx99gKd0JzeMLEH94wuWhZe2XT9evpEcXZ?=
 =?us-ascii?Q?VihsH/pajCQEhgN18QkbWu1qm4pIR5wCfLQtfyykWHxj8z0CeEhxmDa+HI4V?=
 =?us-ascii?Q?I4UUEs1W07Mj7i2xqluRQk+MLW6PX8eMdJVCgd5+sl1JmUgRgvitS7+PIwcP?=
 =?us-ascii?Q?yxlYQEwjjcFIQa0YwjAaF4kyCmGcFGDT+Gt35aYUw6wenelXBxOTbb8po30Z?=
 =?us-ascii?Q?GnunLqcxdZzsweGIX1p3Op/EngAdj8UEpzdmHj90NccZuewFivBoRa+NPFYN?=
 =?us-ascii?Q?01BUClAad1dJw09Z9u4bevY9OcE96o19jfFoRmCeKKZwgxIoIRX0Rld4rnGv?=
 =?us-ascii?Q?nQ0ECmouQ403GmsSAbgv8SYP11i1b/762obFkAj2C7uSYeHdsisBBKJI6opd?=
 =?us-ascii?Q?AZ4OfCVQW34jD8+I0oy9RlnDcyL9X7ma8htJ6/N2x+J7/fh/3m3HxYWGq9fK?=
 =?us-ascii?Q?LCp6yxdu8vpA4oKfi+il7NpLVP2qRwQ9WokbsTOU2qk53Kb77ug55JFhM+V6?=
 =?us-ascii?Q?CQ8jbc/6kudb7QdXCCQYLbJsL3ZXtuOa5nXDCo1jVIteukQfiErS0xjQ1RB1?=
 =?us-ascii?Q?xB52HsjTqWzhsjvu56RXW25s10LZeu8x5+PlO1zl317VAF5Rtq8SzRsUmpg/?=
 =?us-ascii?Q?ROPrxqhVqTw+W4i759lUAP+mEZtfuQLl353umU6B4gZcLbifJXsipBd9m8RL?=
 =?us-ascii?Q?mFE7A6OJDn50D86bv7fuSnjRcN7DqwrpmAl9Sz64IQmvTp5n5x8ATkOJYkXx?=
 =?us-ascii?Q?7217IWTRu+YeSGisqosqXlcA0R7W+2n5kJ2vtWUgZtrUQ/vF+t1j2Vo3psoK?=
 =?us-ascii?Q?b69Na5Gjx3yCSt34I1NwMNKOlqIn9r3fdMm7KK3LqT3cf3DZ0fjFOSldCmuh?=
 =?us-ascii?Q?dec09TeiMyiQ/k5h8/o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda325ba-6c5e-4901-54c9-08dba1e5826b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 01:25:31.0338 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3KyGcNFoc+jvOFRBNKtxivxFR7Adi8H+oL2zMnyEpkwdQPkPsDIt43sOEi7/SNBFDkh2fMX0WefquDi9x2CamQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9453
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

[Public]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Saturday, August 19, 2023 3:21 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amd/pm: fix debugfs pm_info output
>
> Print both input and avg power.
>
> Fixes: 47f1724db4fe ("drm/amd: Introduce
> `AMDGPU_PP_SENSOR_GPU_INPUT_POWER`")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 5b1d73b00ef7..1c3745b3ca85 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3471,6 +3471,9 @@ static int amdgpu_debugfs_pm_info_pp(struct
> seq_file *m, struct amdgpu_device *a
>       size =3D sizeof(uint32_t);
>       if (!amdgpu_dpm_read_sensor(adev,
> AMDGPU_PP_SENSOR_GPU_AVG_POWER, (void *)&query, &size))
>               seq_printf(m, "\t%u.%u W (average GPU)\n", query >> 8,
> query & 0xff);
> +     size =3D sizeof(uint32_t);
> +     if (!amdgpu_dpm_read_sensor(adev,
> AMDGPU_PP_SENSOR_GPU_INPUT_POWER, (void *)&query, &size))
> +             seq_printf(m, "\t%u.%u W (current GPU)\n", query >> 8,
> query & 0xff);
>       size =3D sizeof(value);
>       seq_printf(m, "\n");
>
> --
> 2.41.0

