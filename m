Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578B2CAC582
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 11:44:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0BBC10E1B3;
	Fri, 12 Sep 2025 11:44:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G7Yu5WQh";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6CB110E1B3
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 11:44:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8mMAzB8Qsg7Li+vWLwoNa9evhQaJgeM1rWCkmZpkutwK6jWUCuZofzAtQBaBb76ZRJqhtrjmj2kCCJ+sD7C2+hYG6TTdO/9ZZoEl+T0/2BmYf6I/SH1sPPoh8h4b6sKpJXRloIHTXk5sKpTDvqlQ0SpvoUcsjVfZVPis+I9WG3iEBdux5y6CERX2uQewVjlXbZtnyy/VnVHuFqMXWvbyfK4M0Sk39UsD+W4A238udbnP5eHLgKkOXEKaguyuJjyCFnUbkvLZVkEQBC7FGOdLnoLnHpq3XfKuyofakpQCq3NOCWS/cXIZOnBrUQTH2vLcRk/KaRZqLSkN2iR7+VGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQXN0y4so/Dr5lTN7JLLemvOQiO0mxCnCE0xpRRhyeQ=;
 b=KNMyJvtKlhbvbrTR792Q3JUbrsqJFu6lNuvZW4lFQngy1yfXZMBaDhLXOYvqZvKjTSdJzFYR9cOy8wfN7UCHhQu+TQfxbE2eWSurd7mli6pge93jpdTrxl2Wl97oPzclkaDfMGvpSIGGDptp5VH7LzX057nPcl0ZZqnv+ShtnuJNZ5lHHLfj9tp8/g+JeJTjGfHq6Dgg/jXzFJbfCagcx2NYLUiM4ZOxPxMst5zg7HlYenzq9g77/NZC3CiKjA3f4WFgTPkpX3E7v7xxkDbgDpLxLn1iyvzL2exnvjeZlVXYvn0qEjrigODfSdK1hlASCv9Oszz1P1z92CetSm9pKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQXN0y4so/Dr5lTN7JLLemvOQiO0mxCnCE0xpRRhyeQ=;
 b=G7Yu5WQhz+C91sfx/fKOzK/e11GyOGdR80mNS58VjVMOB8R0uHGExWwXv4ERpJD6teTXx2eRzIHFkEgDakQJWw4WQ/XQaZOCBV871CeTHpQ4DagozBCIQFtH537jUrL0KzKhH2W5yuUp7NA7iwv0vkbkHdXqgHskwN9HwuDWOiE=
Received: from CY5PR12MB6081.namprd12.prod.outlook.com (2603:10b6:930:2b::15)
 by CH3PR12MB9284.namprd12.prod.outlook.com (2603:10b6:610:1c7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 11:44:33 +0000
Received: from CY5PR12MB6081.namprd12.prod.outlook.com
 ([fe80::4d96:5711:76db:6e37]) by CY5PR12MB6081.namprd12.prod.outlook.com
 ([fe80::4d96:5711:76db:6e37%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 11:44:33 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v3 0/7] Add field encoding to gpu metrics fields
Thread-Topic: [PATCH v3 0/7] Add field encoding to gpu metrics fields
Thread-Index: AQHcIU2UhbEL3BfKNkKjiQSaovMY8bSPco2w
Date: Fri, 12 Sep 2025 11:44:33 +0000
Message-ID: <CY5PR12MB6081C78C2C259675A7C7525B8E08A@CY5PR12MB6081.namprd12.prod.outlook.com>
References: <20250909054933.2911159-1-lijo.lazar@amd.com>
In-Reply-To: <20250909054933.2911159-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-12T11:44:21.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6081:EE_|CH3PR12MB9284:EE_
x-ms-office365-filtering-correlation-id: da92f905-d633-4cd8-8068-08ddf1f1be01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?rc19VpRxYSGXUW+uSogaolQgncQZlq54LUMdGayy0t6+EDtYoYw+FtENrOpC?=
 =?us-ascii?Q?3au/jWUpdlSePckqRp0sZFTf6rr/DXxMVg9CEIdXVQWUzzniazd4KVxHLNB0?=
 =?us-ascii?Q?NcJBEx+BRXx/rnsDVPuQrF3RFgob+nSEAhCKCwAEgkZxgDxlpvqIeMzbLFJx?=
 =?us-ascii?Q?FL+sJYO2kUjcH2FnxEgihucHFG7PHUdMyW+ixElIb2/kl8k+53EQ1Kc+6pJf?=
 =?us-ascii?Q?B8qmHd/Cu/DeAxn2ik5u2tau71oxQQo503T7S3dt/tv4eB83KEv62oWSiukf?=
 =?us-ascii?Q?eMP4xdt3xEB0BUX6pRKD657VABXYObrNK9KJOO+DhzQ0pcvSpyHbVhRBVP6J?=
 =?us-ascii?Q?TJzT7juiC+zMAV0ChO4oT7YPxnWh4XZ+OeK8tTzkwnEaMdeRUApI4Pioawzi?=
 =?us-ascii?Q?4L4VmbXfyXhN+2bjr5wiLSEDRNAt0F/edHbU05H5YvtfVNr6DpiJI5zy0tbH?=
 =?us-ascii?Q?1At8tVyTuZfB4i0DGmGiTnRmWq3iDg3EiYLT9cjJ1pU5J05Df0J1ldh4BiYk?=
 =?us-ascii?Q?QmZf8YfmoXWE9HlWvaYIZFoQIiFgaDD2oT9EF+zJ3UIV7ea/qtGb5pj++BIv?=
 =?us-ascii?Q?apkWfDijOhveYQvuhqHcbNhbi9FfeHOo8WGkO94K2S7qzR8vFN1eW/LSVn4i?=
 =?us-ascii?Q?KyOeF52T7DrLqAwsefXG1CP4kng7tl/WVBqw+hF+MfG6K8pGJDgfIfiSRtrh?=
 =?us-ascii?Q?LLnwqDeZCOLlsdOvjZ4IAd+9Ky2qLllDVp+t7eTk2L0joPB9wQBoH5gEbuRk?=
 =?us-ascii?Q?bWM0Xl0HhciSz97xVvvSHrDaevPVpsKvcHnXj6DIDLbsffdzma94TA3xWYHZ?=
 =?us-ascii?Q?1bzs707nQAgPzonbaxmFo7sbKV1M1SxYR9TNvtr9Jy4guH8IFSQp+IYgM2Yq?=
 =?us-ascii?Q?UM0wERZV6dfn2nprtwaQeA04d0D1x58oEhCcd6gvfmUJqLeohVhvcKr7vWlF?=
 =?us-ascii?Q?6MbPDyt9rPeSfQzOF6cttNX6seF26sek3oZuLC2Q8qK1NEHz5j+hVA7UJWc3?=
 =?us-ascii?Q?ued672Dgevw5LbLVNbmoy63AQB57YR8kVwgqq7gKe+La9mwvqC/fbIaXSQl8?=
 =?us-ascii?Q?pQhJBDqxA1cbEQZgNBSIHj7SNw3zVpHwtKMY2EzuM+kQmGZwXKxLFsnwqV63?=
 =?us-ascii?Q?POTCeoBu2yNsgtfEKqFAGOdhsudCxpQyGuzLPQvTsWdCcimorM/QKNT2op5l?=
 =?us-ascii?Q?wVSXbAMmLKdOBv/amgug3FWfbvJeNRCuvlca6d/hmxFXjOR5CzYlbzTHZ1PP?=
 =?us-ascii?Q?eUz/A3fFbYdBXsdEu0oE7M6C4spmd3U8ps/+fI6r4+gy1kYmcL13F+ZJJIqk?=
 =?us-ascii?Q?ky0Py57VGoGlzxrNxpJyc3uhWfJfnu+XUT2z18vC6Lh1iqhTjUcR2ZZZYlaD?=
 =?us-ascii?Q?Ju+KQGByjVtNyhREWDppnPeWrwQP0EWmYiS2hB4BLjmXKk8xwQGuzR3Y9EU/?=
 =?us-ascii?Q?7cUG4FpzNcCZT9qqDBYAPpl8rQtQGpPBJj+6W0FwndWITv9q1bYqcsbs5YDh?=
 =?us-ascii?Q?CzxWEpip2ypyh6Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6081.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/aRzhPs/NC2vgqAJFK7h5rM+/zhbYYw54YoORkCe9jErpHl9lQDSTyEiTWvX?=
 =?us-ascii?Q?7cXfMTdlOWiZsDRNWpyWdF9U45tK9AY8p3ejcuE9JADSONHlUCRENojhylKh?=
 =?us-ascii?Q?8y1yOCHquB3eJB2EZHBib2ndiEWSl0UgGGGqim7KI+5HSqSAhVv9dUnZnmi7?=
 =?us-ascii?Q?oKj51t/b+MR8VZzbdsF1XNPBC0SEbmvWa/lCO2dJjiprqjaXnxNRsXbR963V?=
 =?us-ascii?Q?ND5dByuICFsin6tnFZhajKsjjmCVcQb/wEcFoO5x9EZkmAhW+wURVyZtWs3f?=
 =?us-ascii?Q?S25Kj0ormz0f5kwXfpW8e7jBMWww0pe3U5w246Qhrzo83TcMSiV1oFA0t3kK?=
 =?us-ascii?Q?ZVcNfoxAcwIzsJ1kOKoZMBYhaDv57felNUkrm7hJWnsbHZjAUjiTk8pqsyL6?=
 =?us-ascii?Q?QUvkstYIatf5mWRQaGaMoBSBHtxa9mqj2zjPWEHV+wTdfs3gQGRPXYoONgho?=
 =?us-ascii?Q?Cm8pb4t8hQ+lTDkCUvKPpbPR7SmDykoBJ/HrdkLFQk9YgLnYEMm5l+VnnVkF?=
 =?us-ascii?Q?Vyp0ix+LsKig3t/tWJc4lAdToLEtuaN9P9po9tz5hRO9EXcDzcNh6hCQmSex?=
 =?us-ascii?Q?FvTJLRqXlXJREeTyxtqfm5ZIPF3GuWojrCbecYNqSblUlEVpMLWPAhcEnIbl?=
 =?us-ascii?Q?KpcqYbS6O+FJOIq7c3uWcWE4PEXRFvNGZuF4n0j29B58la4VisarUnb3sL9a?=
 =?us-ascii?Q?8JTcHd5BitBe1fW8rfj8BXMmQWqYiQt6wFre1EEbewuOjcc+5TGysCWf7Tp6?=
 =?us-ascii?Q?WMGRP9xoWuYxys6eD8AxD3jBKTvnNrQtPDKxj5bHyY4/niejJuLIwqyfjmF1?=
 =?us-ascii?Q?D4t5Lm4nbwQvzeDnuhSv0Z3n69Bi2wKcu+Anqbr7GOl8ke9pg+t/mPeZ/KOo?=
 =?us-ascii?Q?vDOSxTWKxie50mNn+6UoLeuVS8VCwD6zo+YZvg4gZEmk6PDnv9fEKFG1kQkE?=
 =?us-ascii?Q?zmwZGJrxn/Vf3DRUAl8y36X2CkBWS2qtabVD2nyuLd6p48zvFXUZyOSLTnBD?=
 =?us-ascii?Q?Dx9caq9k3l5zPjaxVqg3tGifSWTRnSgvLR5JXL265Vb8krWWT9k+Bl61vtbD?=
 =?us-ascii?Q?pjV6UB0thW+EQonj4kFXUQv2pquf+Po+xykuAKEIQvAJWFToRVOgAYQrhn94?=
 =?us-ascii?Q?BxaS4hhlIXta/VfkzMFj7fc30yw2rlx2OxQltglzaPFkiwO+OtioGZ7dm9oV?=
 =?us-ascii?Q?9zvKMyk9igeuc9I2W85ZxY0MmxfusIn4IbMppnpT/j/7lsnaZUBDFyc6v3EB?=
 =?us-ascii?Q?VziO57OBGHl7q6ISoSldxyNDLsDJuVrRFkiuYXz7lVHC+pS4l3pb0uM9YUag?=
 =?us-ascii?Q?BFLuNlEOwImRnAnF7yoUVRfVgp0xZKfmFIHJaEgI/MVMLlSlJgIBVScgPBo5?=
 =?us-ascii?Q?OxexLIoEn0zQOWPgTBtWx5d6kPyV6hO/6NE1ZKdML3SbcVgZ/NgbTvp4aTL/?=
 =?us-ascii?Q?tl6KHa0gENAYDXjUTMGolHiRlzW/+TV3Yhitwj62s5Q6NwF47spJxfz3XzmT?=
 =?us-ascii?Q?VraN5r/NqdECRJC9cC5xs9M+SLAjfSEuN4Yh4pyocbgoqNODFeaJD9BNaJxs?=
 =?us-ascii?Q?x+LNKOFhhduDHmxirAg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6081.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da92f905-d633-4cd8-8068-08ddf1f1be01
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 11:44:33.3414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +tHxVwsBeznRgxdvjK2CtgAPYDgWLOAdx8LX8jUpw8A/q72v5Fsk9PoYVyrOzcqcPzkAu1tx0laLx/E6JFuBiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9284
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

[AMD Official Use Only - AMD Internal Distribution Only]

Series is

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, September 9, 2025 11:18 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH v3 0/7] Add field encoding to gpu metrics fields

Currently, gpu_metrics is exported a binary blob with the defintion provide=
d by means of a structure and version. Though providing the version works w=
ell for backward compatiblity, it doesn't work the other way for tools like=
 amd-smi. Installing a driver with a newer definition of gpu_metrics someti=
mes could break compatibility with the older version of amd-smi. Even if ne=
wer fields are added towards the end, a change in datatype of existing fiel=
d or an increase of size in an array element will break the compatiblity.

To address this, add field encoding before each metrics field. Each field i=
s designated an attribute id, and along with that the type (only integral o=
nes are used currently), unit and number of instances are encoded. Thus an =
older amd-smi tool may skip any unknown attribute field, and move to the ne=
xt attribute. This encoding scheme doesn't take care of elements that are n=
ot valid always - say member_field[3] is not valid under certain conditions=
 in an array member member_field[10]. Hence this still keeps the design of =
having all invalid elements initialized to 0xFFs.

Lijo Lazar (7):
  drm/amdgpu/pm: Add definition for gpu_metrics v1.9
  drm/amd/pm: Add helper functions for gpu metrics
  drm/amd/pm: Use gpu metrics 1.9 for SMUv13.0.6
  drm/amd/pm: Use gpu metrics 1.9 for SMUv13.0.12
  drm/amd/pm: Add schema v1.1 for parition metrics
  drm/amd/pm: Update SMUv13.0.6 partition metrics
  drm/amd/pm: Update SMUv13.0.12 partition metrics

 .../gpu/drm/amd/include/kgd_pp_interface.h    | 123 ++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c |  94 +++++------  .../drm/a=
md/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 140 ++++++++--------  .../drm/amd/pm=
/swsmu/smu13/smu_v13_0_6_ppt.h  | 156 +++++++++++++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  62 +++++++
 5 files changed, 450 insertions(+), 125 deletions(-)

--
2.49.0

