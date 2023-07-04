Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95078EB64DA
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jul 2023 15:51:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C5D210E1A8;
	Tue,  4 Jul 2023 15:51:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C6CE10E1A8
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jul 2023 15:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoMNtQN9FN5QzNIBneeFNxlL8atJZbO55KhgJRbkVU3cJscroIoP/UOBgJL/EORpqbCB2/Oqwwrl4vW9d/DBFQrOpj6EccEPlr1219XramiI88IqLzH/7xD6tTUY0BrldTz4cVbApqLkkq2O5pfjCAJShsOKF0uOTkW+QKfseVN7OHd1+50JWzcFrOz85ljtBoLjhJRqCNGVCFD6Ybcz8v00iPKIevjRnW42yidLKv5y5ZMnw8PZU/u3oHv/OLGrD+pFYNS/7Ei9LxNK2RzJiRoGGgZQKBBZRV5cQkSN+Fqza6N0RxBPkG2CLl5V6KlIATxbMFLgdOyUcaPnuJ8D6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pd9bRSDYIETGQp4pDK5vbW4BDZBLOT+1QRnDtRrsxJo=;
 b=ZrLNhgVPM0rs4sTpaqHzwfXL+tjgsXfzFt1IyrpCDQH9o2bq1R/bziwm0IZUV2WEhm6ybD6y+ydYVca3CPy2Akp+/V4rPmBopVIYluY8EEImJ9PiEgnUp2d65J8K9D89vi6FUOSFUJIC68WP92Me1kynbGLP8/sAhKcITSKL1awqYCsVLMTGlTcTyLtadO53eRunKosXLK+NfIJ3bG/nIS/8WT+zsBth8xu/Hy/2OMHc56nMXg8ylI/Jwi1hehEBOPvCe+5dYQWgs5sP4vnkZLP3A/PDJNfitRdfN8eMSfH13p9ra0e0AQdFdfFG9lcZkRulW8/3BDcwki5WoKnHWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pd9bRSDYIETGQp4pDK5vbW4BDZBLOT+1QRnDtRrsxJo=;
 b=ho5TCTPo58vItI/0ViRYZrDTsMGhV+yIHZvFIgdSsTe9OjYDCEd+Sl+MxXSU7kqeAamkZ881TSeYM9fT9NEPY8/VdBvilX6IauDz+mzKSoInpw1Mps2aiGoBVvAJNKOMSiNDN+TR8y3pj5/6N7ss21Dq5OQi+v7K8UAntzGLYDc=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by BL0PR12MB5011.namprd12.prod.outlook.com (2603:10b6:208:1c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Tue, 4 Jul
 2023 15:51:08 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e%3]) with mapi id 15.20.6565.016; Tue, 4 Jul 2023
 15:51:08 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/5] drm/amdkfd: add multi-process debugging support for
 GC v9.4.3
Thread-Topic: [PATCH 2/5] drm/amdkfd: add multi-process debugging support for
 GC v9.4.3
Thread-Index: AQHZqgbcbsXFU1X/V0m0DiXqIyL8oK+px5tw
Date: Tue, 4 Jul 2023 15:51:08 +0000
Message-ID: <CY8PR12MB7435B6224EC339A008C42334852EA@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20230628212323.248650-1-jinhuieric.huang@amd.com>
 <20230628212323.248650-3-jinhuieric.huang@amd.com>
In-Reply-To: <20230628212323.248650-3-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=56208191-be68-4bfa-b1ce-79af136c8fcc;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-04T15:43:07Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|BL0PR12MB5011:EE_
x-ms-office365-filtering-correlation-id: 08d7275d-05b7-47c6-c14d-08db7ca67bd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YctbnuZxLIE1ISbk3++WZoDUydrW3EFmRbaKZUcO6GyGzp7teHxJPRdKr+xEfbxi/vZvvfhoUAmbAemxx4XVvjsx8zn5zBM3rdGyT+NowAsjHuSYIIQ7cNGTb9TF0101bApsmxJKyYck61dSTCpxgKkARge2wNHLpRDlOpLI85D0BMlRIBBYvnsscvz9CH7vA6nsIc13APcDlKm4GPkqbYCtC5AJp/bsfxHPyto3nj0mwho1jmIfzM/+yWqZH5A0nDqvk/DJF4/Y7uNIr3fghLb73P3sXB2KJFmOGfOTwEzzsdO+cKxravoSz8P+GvbpIynbdgM6/X4r7d2JGOdgw+fp8qGsfbOQ8DqFaquW3bH6CF58S0PadduDFFOCrgTSEbX6zD3No8IEzpYczjU8x+Wg/K94/c+83WEUxNdsfCQ2sUmEYyTLpNuttK5v0SmArPjHnjFkGqTqA6uViUGxPbyg8gJVfh8cDVdarVVM9UIn2PBUwgSNcm89qCHlpYx8JuY9uPTMlfLCjfRG1Tn18upFNTh+zq9RspUcYzPM5hdHM/p/yRB2rXGAeL4g4NWR9fnRsR/aGRByK6UggVgp/rGpAP3+LY9XVjEjXDVD5JTUs4hML+paGgs/7sxyFRRh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(41300700001)(8936002)(8676002)(52536014)(110136005)(71200400001)(7696005)(55016003)(316002)(5660300002)(2906002)(4326008)(64756008)(66446008)(66476007)(66556008)(76116006)(33656002)(478600001)(38100700002)(38070700005)(186003)(86362001)(66946007)(122000001)(83380400001)(6506007)(53546011)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oRG3kdzCSQRxx2IwX+4TuZRHv0cbC6LeVc2UmWRvDAGe1+yCCr0ZZ8TPXqne?=
 =?us-ascii?Q?L+yhE+Otq2yFlQKptTiv8FSaw1OUvK3hsItNYjWheoPqwOpgCTsK5+FsulTY?=
 =?us-ascii?Q?dM0H6fSMkJvxMXxjhbS6JBw/CEPFL7OkANiflXWXzMyAbLHJnWStSzebmVJd?=
 =?us-ascii?Q?fmgLlevDWkvXWHjvcYvl7Mgbc9qVyQu5M+oRm7MSbSH+MZdulHd4YxBgqGSC?=
 =?us-ascii?Q?DO9O8t8Pt0fZNYw0dFgYYBK1w0aQT57aoOEp9OSY76XpuqRgYXXbvWnkanyx?=
 =?us-ascii?Q?sIyW9ux8UDqSD2oRItzZSsO4IMho9esmSkFPnrjQo7Ebky/Y8WheJpMIGuHD?=
 =?us-ascii?Q?Tzbk51azE8SdRJq8/c734KziZXzIlI2B49E+SmvxuN1GtfSiLyu8RJ2IxI7f?=
 =?us-ascii?Q?VDpEIYHG3/uvmTiHUOWuaU2IlI8x2jdoLxmMRCzIP9JI1JAd6ang078ScUsv?=
 =?us-ascii?Q?RfiXimtBZeQF3F4aeINhvl21GV9y7kPkjBcgk4QzcTS/dycJKPz210ofvO8c?=
 =?us-ascii?Q?2pi7LXFz9HKlL0xnkmXIgO5EZjEuJTkHwsyko//I3VVUgU3EfWDLatwrplCS?=
 =?us-ascii?Q?i4RZQt6gcwMi/73KLha7fTwWjiswtV/6kT3aRwz0sPpj8BnCVOPN1z/TxL0j?=
 =?us-ascii?Q?ga/RaX3Kfb6eCbjVhoqnuyr0Lw+ww502Az1fomHpO9uVATyTa2ufSK2PhyKd?=
 =?us-ascii?Q?ATKxuENa1DJYzUEu9D0zeVfoCwsXpnDHq8UgGypJlRFT0UYXHpYHEM9z4aEX?=
 =?us-ascii?Q?94XdIHRUttQVA/Dynv9jG/TF3CeW7F7HfhLxZN4b7PJi9F+Fk4Kh8jpIH5El?=
 =?us-ascii?Q?PGsvQi3AT+CEjlprM+avBsDtCRhL4WJ4Nnglbq3V2efMXVSGIj4UHK5AogVc?=
 =?us-ascii?Q?qBTqXN+GHWDAlxTQM0GnKvI1wmcilLUoAdMgeDZl+RWMUlez94kKVch/kRQG?=
 =?us-ascii?Q?zp9CHkEkIwlcO1/TSdKq2FqidT2I7unlSfP8XgpgYrpj4uDkVFchJ/go7M3i?=
 =?us-ascii?Q?+VqVi1mKJItaENxn48p3Asgc7cpI80K2ohyeKarMysT98xXDLshu1KznNnmp?=
 =?us-ascii?Q?r3+DidMNJYrhVHFSe9bU6r6LH+USpP/IkeU6x55OG746K3kbRTEuIzRRkrW0?=
 =?us-ascii?Q?AewWsKTxC/DKDLRWpPgaCH94fJmfOMtAD5f+xc3UwzLI0USL8gB2nXzLvX8X?=
 =?us-ascii?Q?jgdHbz1kczN8PyDEmF5rYlfkC5zMfBXpHdA0n7XjQCLAu/VDDi1lVdUf+1om?=
 =?us-ascii?Q?/YIU1jM1qNHE+1dLThmuqA8jXiNFIhWie5BPk8boUfCl4QHRPoYM1T3k5asG?=
 =?us-ascii?Q?6csyPSM5+Ta2Cakcc0gnhYpxR4r4gnNn0IWdZQS9aykmPN/6S93Aw2zUcpn4?=
 =?us-ascii?Q?QpnfB8N2s87bddyKo7rz+wQFHZAtZO3TmMUe7Zuakb0t9EPL0Usto3QeIb3o?=
 =?us-ascii?Q?t7i+ig4enViqDKJmPGR9RrQQeX0qtCa8Cwm3PMyUAWb3T/hE13pPsBcBkuWF?=
 =?us-ascii?Q?ksgCltG1Y8X+PpAvMBEPWlWHj2KwBXwzPM3LeatiFZmmQIYEdTuhE3ud8JlO?=
 =?us-ascii?Q?jJETIMfvT6w1/Db8tzAqlCrBH6a+7Tx4kKHLsXP9PtNMvXrglHHytNBNXhxc?=
 =?us-ascii?Q?VviBFtTNWA59uXDGX+rXOHs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d7275d-05b7-47c6-c14d-08db7ca67bd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 15:51:08.6499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: blwwp2ryv42jEsdB1QJBab6oyKTRYZIOjXTjwSxk96sDTiFv4kjoJsKNkuXu5ovY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5011
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Sent: Wednesday, June 28, 2023 5:23 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
> Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Subject: [PATCH 2/5] drm/amdkfd: add multi-process debugging support for
> GC v9.4.3
>
> From: Jonathan Kim <jonathan.kim@amd.com>
>
> Similar to GC v9.4.2, GC v9.4.3 should use the 5-Dword extended
> MAP_PROCESS packet to support multi-process debugging.  Update the
> mutli-process debug support list so that the KFD updates the runlist
> on debug mode setting and that it allocates enough GTT memory during
> KFD device initialization.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> index a289e59ceb79..a0afc6a7b6c4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> @@ -76,8 +76,9 @@ int kfd_dbg_send_exception_to_runtime(struct
> kfd_process *p,
>
>  static inline bool kfd_dbg_is_per_vmid_supported(struct kfd_node *dev)
>  {
> -     return KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 2) ||
> -            KFD_GC_VERSION(dev) >=3D IP_VERSION(11, 0, 0);
> +     return (KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 2) ||
> +             KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 3) ||
> +             KFD_GC_VERSION(dev) >=3D IP_VERSION(11, 0, 0));
>  }

This should probably be the last patch in the series since the rest of the =
series is required to enable debugging correctly.
Also did we ever close on enabling the trap temporaries regardless of debug=
 mode?
IIRC, core dump will require this to capture consistent wave data.
That should probably be done in this patch since this check will also trigg=
er the ttmp setup call on process creation.

Thanks,

Jon

>
>  void debug_event_write_work_handler(struct work_struct *work);
> --
> 2.34.1

