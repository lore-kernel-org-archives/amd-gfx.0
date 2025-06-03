Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FFDC5AD49
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 18:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3867010E62E;
	Tue,  3 Jun 2025 18:15:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GvIOGx/y";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9C7410E62E
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 18:14:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLGU/FNtDay0s6fLR35Lq2f7uZNAuFeqzJcDh3KqEDU19EhYjf5dDiqY6WSuLw8eBhNI7uAQH+QRzpZmGahqaqr/XdaBct+VfU38/PtdhnPmrYo6XUepSralM8oUvttj2guwkXmD7QqPKW4a3e89QXfx6DIVUa5/KNAhL8tPZr9NmNkRaQmajNi8MB7Vhx/ech/4FRxLMDshMkAcp7jmF5ozp3qpRR21Jli+VenoaT/RjGoFCdoyPV0zoXKBtMx2fw+8mYk+tJlPfR0yskVikZUBR1LU0dbPuFc6+zvivHD4iInsyTQTmZpCgKHZSFj5El92sNJplUvjCabM321ArQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tt582PTMlKSQG0JCzo6D47I7Yoy3c0WBllQkA1MI7H4=;
 b=G3H2KQNIKN/ebLXnh24Ux0+XMJEtKwt2g2xfXKTUS/fnAneeuhPS6CdMbxzGgrUwEG9XwNJKQQ+J8VxIN4xOKHtptqVuhgliRbJMGPneCN3kbZLkdG76pOH4qDMGA/XQR7yMCtmdUgiADXgNIrphsTv6O7JfyDvewfNrAWod7s9Z9GxMVr/vDXd09Ib3A+appWweyNGeD/GFTOou5Z2DsbxDTmIX8pkVkVkHjdD2y2P4zjp+GBdYI6PZOPqK+xCfWkL053B6swA090i3z2Wxlow/6vUErWwPYYPnHuXYPq21IYHvmYO/9i0TtVV224PAa8aTtXFgbY2sWOcZ+1p+hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tt582PTMlKSQG0JCzo6D47I7Yoy3c0WBllQkA1MI7H4=;
 b=GvIOGx/y1mdbUAbOnVPJAxbJVfEExb6sz+caiPE0UOVw8dDyAfx8uzjtLmAplHqxReoUziCf2N22gZQ8x9R3wGE4jV1lhs0V6WiGPEHOeJSiBdchhve9p8xUvKU2fPMHF6Tww3gYK1YUPgdCzbKrQG2FeE59vAsvz3HY9C73IJk=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Tue, 3 Jun
 2025 18:14:51 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8769.031; Tue, 3 Jun 2025
 18:14:50 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Move SDMA queue reset capability check to
 node_show
Thread-Topic: [PATCH] drm/amdkfd: Move SDMA queue reset capability check to
 node_show
Thread-Index: AQHb1DVom72Fq6t/RkmAW+gK7I0M57PxvOxw
Date: Tue, 3 Jun 2025 18:14:50 +0000
Message-ID: <CY8PR12MB743595502095AF1DF7E79AA9856DA@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250603031249.3727405-1-Jesse.Zhang@amd.com>
In-Reply-To: <20250603031249.3727405-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=1cce3a15-1ded-4851-a712-29088cd8809d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-03T18:13:09Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|LV2PR12MB5990:EE_
x-ms-office365-filtering-correlation-id: b2a96d3b-7e40-478d-3a1c-08dda2ca87ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?OyKuBMMelECyEo2AjELGX1ZvZSwfVrpOCwfix//WgKtNB0KElV9Ii8ykwYYC?=
 =?us-ascii?Q?C04MKf520QE2LVtvvBAHDu8Q4cyYtuDAYIpmQ5SaoUjhX7H7TnCF7CNW6M5o?=
 =?us-ascii?Q?r28Lo98LOv8HgTx9ZULEdzrMC1NSCBJd+VWOneNlGRkIQFcPkUpU5/jCKTlR?=
 =?us-ascii?Q?Qv1RxuWcRvFU3M5bvxZ7Sjc2hFccoSoIyQYONiyGd9DsglJG8loccVlstdZu?=
 =?us-ascii?Q?9c8KK4cXgmD9uThYXmdI7/Ng3QbwG3+LII+Ap1Muv5cS7bfOMQoy8pm9/MiM?=
 =?us-ascii?Q?ntW1FsMOZZEj4mLvronh0xY825MyYYigFEeIbQRvdipy2q/jTQE2OAzZSBtI?=
 =?us-ascii?Q?n3LRvb+2ERGORvQpdSpuMa+2zs+Eb9NaPBu5orElnk/FKrH/7UHrVYv06iqH?=
 =?us-ascii?Q?MP8ZHBciOx7vBkjwotAca5ULb0ielO3McWCpL2eyH82THSOQ59/QG82jYKPO?=
 =?us-ascii?Q?BdMkVLHLdK9/kakz1qhYY1Bkc8LEzuiWz5h4gTt9eRlZt/7IR7qV9c1TxuCS?=
 =?us-ascii?Q?0AYwLteZ1oWDGx8+j0M3eAjeTeh2cBHQ2gpysN/jkKm5HOmFi0Q0rbtu7rfU?=
 =?us-ascii?Q?/CxBSE0P1ZtHSAtZb0ahYAoORXoKSP9uhgBK+4dbC0coUQpGYzyMKx/KsyLf?=
 =?us-ascii?Q?npuneSj4l0ahb7256KK2IigDlhBHgi5mQnVzNU3vQcKPGGEtYKa78Mm2oQUt?=
 =?us-ascii?Q?hMJqnO2RQC4YDW1Fnx7/oGmTzV5Tj9tpDvF0PsJL5U3U+0rjlkefuM+CcXBh?=
 =?us-ascii?Q?dPSioX2O4JAhs4ljtC9rN82gR+hVG1MiHtTUXgGv5VI8eMZN2vWBg/5wXZrD?=
 =?us-ascii?Q?NVqKVQi9t4cVcaAGgiIDRIVjNaiDTx7WssmiXaCnLRC83CXK7idggOkmTtEP?=
 =?us-ascii?Q?h3HLzKkpUXNKrhJTHmi14mhW6koxI9iufDSNyPN3L3qXh/p8uEUHLSOfW8GR?=
 =?us-ascii?Q?gXyjXGGi0sC6bpxB5MdKbBkE2dIcax+J/DfIh/irX402i/d1ObLR7v5j3d57?=
 =?us-ascii?Q?Gr7FrNYieylVVUmeAE8ezXagqSgrouBJiHd066LzPibJkeoqPFCcuBktH0r+?=
 =?us-ascii?Q?h8wXeO7VxcVlld6PU7wyJYVFz3fRmQDnk996tWKq4vf/rjCqW5zNQuLfsnUZ?=
 =?us-ascii?Q?3tYEiHVD0si+tslIP2jAXvBpNH9snQ1u0E3tyGZl/QwhpZUk7mFSfaBnyclh?=
 =?us-ascii?Q?nKI/DiDa5NlawwgHgkKupwgjjuKQLxJaUUfd82RFCqamC481GH3905+gLR3D?=
 =?us-ascii?Q?Zj63+rdE84cdnBr1ExtbnHolVA/FgNUbYM3Gwsoc5VrFQf+ysHfKFCHx/IL6?=
 =?us-ascii?Q?fb8aPGYFjXp2yjo0vZC2MYP/2lF99uN2pC7n3n+uEKgEs2aZKPKtFQn4wbgY?=
 =?us-ascii?Q?0+7BCSplhocV9EjqZs9CFx4NIBFAVrV9BBSXLsprDvejlrsI7OqEEyUWleCq?=
 =?us-ascii?Q?aedMxZ6sAHesRVkKF/TXdFSl7hxvj/CvU2rTSiT4BNcsr0p+3WSPniKpyzeQ?=
 =?us-ascii?Q?03TLmU4+UB2Zrxw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nsh6RNfInUg3rQ4uyATnaffJ8NMem11uhv2HrvenmRcQQgIjsr9wqPbjfjV2?=
 =?us-ascii?Q?oI2QnqbpGYI2LTRAaUd9CxqOGHGNk6WeK2NIJpz1yI+Y2zjGvGK6owtP3p3m?=
 =?us-ascii?Q?ZRD2Y+gHOpkOzIMnznB5ANOg7SXoZjKfartnsSIk92z6CXUTo/Mw118zK/Ay?=
 =?us-ascii?Q?cvpGAm4Y9iQ8+1zxl/aFDWeCdUbY5QQX5up4C7N65B7b4UmUm5bRgdRUA4aH?=
 =?us-ascii?Q?7stB9AWnp6GsrR/ENw2/I/XnPkU6wuyh0JzRzn+wYIrKh9MjR2xFnpwiSsqw?=
 =?us-ascii?Q?Dhc68g+KDhtsAsrMjWcRvFeJZ+b5f8WEOdq2/FaxA2n+nk7AI3zxEIcFeBGy?=
 =?us-ascii?Q?C8CZaRQI0bx1UT4ZoIV9kGd08YoD0QbqBsOIGCynZ9j5G0pbkQv9fbrHZBik?=
 =?us-ascii?Q?ASF+YyINyIK7p0aqMZdOvNt6FBeP/Tnc15q7Ok2QOz61A4qgubSZrK3Mxb7D?=
 =?us-ascii?Q?p6VN2Bd7pgqtXmaKQTjVlG4OpSdt3SRF6dfEj2b0T3QPtZu6RhEAAUvwIK8I?=
 =?us-ascii?Q?uJyRbCaAkm2UD/9LyAnRE1oApVWHVa0m5pULgvvWMdH6DTJDq8exUH+NOGQD?=
 =?us-ascii?Q?0SpO+p/z74fehWLXgT1oMWTOlgdQgisfCn3b6SbBiyy3/Ey748icjNVFnvyl?=
 =?us-ascii?Q?nceFyA0JQXTlJ+/iri6qQX2HnZbIGCpb6GJ4E1tRjp2+3jsm6kUUcfWR5mhd?=
 =?us-ascii?Q?AefDCE9pGcYCRmlJo+P6PeT47IPfGa0d/kicSXuQ2ctgeo71tZnrPmV7YIus?=
 =?us-ascii?Q?mTTy2gb51yVxC5YD1It6sF4gnW+Qj7ujaZESCQpVmisRwllvxROqPTtFpa88?=
 =?us-ascii?Q?Z262U4SH36cj03V5lTg1eaT49gq8A9cmDoTRfT57hdIz/6g4hnf/BrOhrfh1?=
 =?us-ascii?Q?IzaS2z9gBU1PzFCgyIg5pTDsiEvFG3wRPi8iUCdWG0y4QlA59Xdj4/zF09AH?=
 =?us-ascii?Q?KcfIFlsWbKITl6wod1LWIaCMSPpMtAGrjIQlkQ9eUZz4k1UFmQmdHgzoKhAJ?=
 =?us-ascii?Q?piCfqjY9b2GJhotkk7NU/P+ev5YYgnmeLBqMQR8oNgd+FtjvEwpBERKUA1OV?=
 =?us-ascii?Q?EzMroGmtr8+9Gs2kTUkQXATVYONv45JpW2JBmD+DzXFNW2i19hR908+4UTYL?=
 =?us-ascii?Q?MX7RlNT02mET6oHPYVIUMLAbLRjRFfMF1xxhg+XIh9e6qZcOEASgouzhthrZ?=
 =?us-ascii?Q?DdGYP1JejNZof3YLemvfuZpeHjZV0RU720rBjqIh/wmVtv7zWtSn/7v2h7nB?=
 =?us-ascii?Q?zi+hCA7dk8eLO/m8xvoN7qoPgncodIkxVtT5OSYE5lf1sm3MOHadVt2B3/cw?=
 =?us-ascii?Q?xpHi1Tx+LmTVPa+4vAG0ZP+zTnHUfBtNfGlz/HkSigOyN6z+HFt2t1GpgIW+?=
 =?us-ascii?Q?LuwAxXbJjq24DYVkn7ymspaVjP8lFfR2i69YZwyW/99p3X3180dXzMbrVSb8?=
 =?us-ascii?Q?uy6kaIwwa7LN4adkDmY4p5lGo7XD3fGOuglRll3pXR6SatShdzZyEVf94rxp?=
 =?us-ascii?Q?Wq+HebMPVzpVP4HAqM28B1qc/CLps+u5ELvCravot1Gf5Rg+SgNDXHgdP3rC?=
 =?us-ascii?Q?zuvo800USABCK8ifK5c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a96d3b-7e40-478d-3a1c-08dda2ca87ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 18:14:50.1673 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/5IqgaJPCcpnkSGRztkkqE9Sc3sk92lzFyyZU6haPMJP8mV8FVMe6xGYwng+wck
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5990
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

[Public]

> -----Original Message-----
> From: Jesse.Zhang <Jesse.Zhang@amd.com>
> Sent: Monday, June 2, 2025 11:09 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Kim=
,
> Jonathan <Jonathan.Kim@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH] drm/amdkfd: Move SDMA queue reset capability check to
> node_show
>
> Relocate the per-SDMA queue reset capability check from
> kfd_topology_set_capabilities() to node_show() to ensure we read the
> latest value of sdma.supported_reset after all IP blocks are initialized.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index baa2374acdeb..e123952e9a74 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -510,6 +510,10 @@ static ssize_t node_show(struct kobject *kobj, struc=
t
> attribute *attr,
>                       dev->node_props.capability |=3D
>                                       HSA_CAP_AQL_QUEUE_DOUBLE_MAP;
>
> +             if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(10, 0, 0))
> +                     if (dev->gpu->adev->sdma.supported_reset &
> AMDGPU_RESET_TYPE_PER_QUEUE)

Thanks for the fix.
You can probably squash the nested ifs into a single if with a logical-AND =
check on both test conditions.
Please also tag the description with "Fixes:" before submission.
With that addressed:
Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

> +                             dev->node_props.capability2 |=3D
> HSA_CAP2_PER_SDMA_QUEUE_RESET_SUPPORTED;
> +
>               sysfs_show_32bit_prop(buffer, offs, "max_engine_clk_fcomput=
e",
>                       dev->node_props.max_engine_clk_fcompute);
>
> @@ -2008,8 +2012,6 @@ static void kfd_topology_set_capabilities(struct
> kfd_topology_device *dev)
>               if (!amdgpu_sriov_vf(dev->gpu->adev))
>                       dev->node_props.capability |=3D
> HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
>
> -             if (dev->gpu->adev->sdma.supported_reset &
> AMDGPU_RESET_TYPE_PER_QUEUE)
> -                     dev->node_props.capability2 |=3D
> HSA_CAP2_PER_SDMA_QUEUE_RESET_SUPPORTED;
>       } else {
>               dev->node_props.debug_prop |=3D
> HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10 |
>                                       HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
> --
> 2.49.0

