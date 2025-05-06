Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F366BC3ABBF
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 08:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9649C10E5C2;
	Tue,  6 May 2025 08:49:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jTrDGkum";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B648510E5C2
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 08:49:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9SW6hNG6J3cbbaW5xsQeRD8BU6tlur9TheZVrr3IEOiD5bUg8OJmMH9PH452otMJSmvItdu9YHFw5auaM0dC0xxP0AgmE1ZPAIlKn7qSnQTpoafKyOyAeNwYpVdKw/C7AQTZbz4QhPp89zXA0+xrGMJIhXCFwOv7ouBpGvbm7rQeuXqFwC1vtJzIg25cTrZ0UoK2wT+/f4G9YKZBPKw5qj9/o50FRqwkwDqtVBFcgsj7UbfW42BEdEBAod4NvtQJvoH6PwNObW9h0hRaH7BRv/6B92Oih/G+f1FZS3lJnPDIRDC9sCj+uaGbBBPqDeOpVVG//Wl+5bGta7oJDfPvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtBEQj3gFhm9eXcbHTplkflv2ebZDe7FmghpsVcATKY=;
 b=ytHQd2KzFIZqUDdjUVEZb2F1O0ArcRx0YDHopHoe42V8UOq/Qv1QT5Rapn3Q9OWBdgsiJRhu/fqmldeZ4vn/rlSdLvXCInqMah0sWA56sB40K1HIwFsRDaEir8LFouiUsbSBVB6pDKT2WX98pt9wXW/6zE6YL6U3INEa9RpFhgY1fGi6ka7yJTJV7VCAipP18BfZOFYBMk0wCVsbKMxiUTabCIpUBmzOzGk/YUqaZ9CkPJ8NE/0SXgwsdDxuZ+Y2dO7v1h0iXQYPtst7CamyDtzufEFCxmHqm4JwUJy/Hdh87eqwWUUnyX6XEC2XNUxwJM5cayhG+22Pe5Dx4wb3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtBEQj3gFhm9eXcbHTplkflv2ebZDe7FmghpsVcATKY=;
 b=jTrDGkumOTBj0AFGM4w7KRQZhHlJDpjxcTrQ2Q13tu+SvbhfiR00QmLDei+zZXAjuOrZFK/WZFxxJOSVhijxRac1T9Ine8tI0K25+yMeDSNf8clBSwJyos3Pk45fy0j9XVFfGQ2+h5mQKIHk08N9PHBAQUpFMylNpfams8BpkQs=
Received: from DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) by
 IA0PR12MB8908.namprd12.prod.outlook.com (2603:10b6:208:48a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Tue, 6 May
 2025 08:49:36 +0000
Received: from DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba]) by DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba%7]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 08:49:36 +0000
From: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Jiang Liu <gerry@linux.alibaba.com>, "Zhang, Owen(SRDC)"
 <Owen.Zhang2@amd.com>, "Ma, Qing (Mark)" <Qing.Ma@amd.com>
Subject: Re: [PATCH v2 2/3] drm/amdgpu: update GPU addresses for SMU and PSP
Thread-Topic: [PATCH v2 2/3] drm/amdgpu: update GPU addresses for SMU and PSP
Thread-Index: AQHbublOZV6ZGRQkska+PUYvIhNgKrO8KauAgAkarbU=
Date: Tue, 6 May 2025 08:49:30 +0000
Message-ID: <DM4PR12MB59375EF7DA8EDD89E1AF31A3E5892@DM4PR12MB5937.namprd12.prod.outlook.com>
References: <20250430101638.649274-1-guoqing.zhang@amd.com>
 <20250430101638.649274-3-guoqing.zhang@amd.com>
 <487f0345-3ff8-43c7-b26d-03e815c2d1f8@amd.com>
In-Reply-To: <487f0345-3ff8-43c7-b26d-03e815c2d1f8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-06T07:53:03.6238051Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5937:EE_|IA0PR12MB8908:EE_
x-ms-office365-filtering-correlation-id: 1cb053e5-28f5-4342-dcc2-08dd8c7aee28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?RxarBA16CHG/VUyyVzFVrw3+4NNZURqbA7YybScazmKJon+VnHkni3gGtlxK?=
 =?us-ascii?Q?6iT0YVhHgy+0dNvCzUUdqcyKAibV/GybFfe3AmucdMVLklPUAgafUJT4dXEH?=
 =?us-ascii?Q?qrP4a1lOinD5Rc+BCOJSGnLkKPdiZPyS70cuREKvH334S1mj8QNu6h9eh8GM?=
 =?us-ascii?Q?uKudRwxfq1y0MIR8P0eZikuc6C0QXAeBwiw4klhy4GGsoDvgWGUqTE9/lti8?=
 =?us-ascii?Q?Abb2Jp+c5VgixeBJF7cWYAchn/M156yTvng0OBanLV1oJTdcDcAcZ2yMzSbx?=
 =?us-ascii?Q?/I5EmEpZUXwTpkKOSCdp2qoP9YWZVU1Oh2+nAC24YGB+yjs2LI8f1DrCigt9?=
 =?us-ascii?Q?HaMo9+VxyFIHsx7Xv1ihnHXR+c9dtELBUPUve18lbLo5FxeIw1VHlqEeK9cW?=
 =?us-ascii?Q?6FZ337roQMTq5tX7OEP/Qtc5dQ5WTY4u9g611ceRM2hA0rGB0NlZKX2Fb79s?=
 =?us-ascii?Q?QItAk1BgrkejbZvrAJ5OALL3vLwAd98TB56CbkDCYJG9iezUeoYpB/n5tOl6?=
 =?us-ascii?Q?67uY/31C6H8awCf6wAVFZMNOi6PPYhkvIrXoH/srfWwceqfnLK8TUkDehgxX?=
 =?us-ascii?Q?A02qghTAB8wd5WAphyljRTf0VMHgvAW6HSQQwgDdUBgAQTvfWUBWH+d5384I?=
 =?us-ascii?Q?ZcbMP67x2xKJXtJ7z6GOJPRemwDbI8+OvDhmDfsAokZIgrd1D99Fa8a9P/ob?=
 =?us-ascii?Q?1nyDXnJep5CYMheHQcb4poI4Zg35aUwMdameXD3pAgY6aQGULNoSov6vLkoL?=
 =?us-ascii?Q?KpdJaK7/NTXWLTYmQdLJSbtkr4dr57m4to39A+77yRJ6UsYMy2afNZ02tP3G?=
 =?us-ascii?Q?3eiY2Xzv6EHzvS1ZVE7NgwqjFliQz59wQP0jdryQ/spdhloovkD4FwdpTIDC?=
 =?us-ascii?Q?MscCM5WhX0s+ne8VWFx8988joVomRAnGaljmCwzWN3fmRUc77VJSY6oNBOaC?=
 =?us-ascii?Q?huSwJ29O9nr5GqaEBVVfxIgYH/40Y1A7MomJ4t5snczkUjh9+g1YIMJAXeNU?=
 =?us-ascii?Q?UyrUEtCwpgefTvKujCRGW8SV3xQ6R1DfDWwmksWwqxs6wSWUk5ZLrsATAScl?=
 =?us-ascii?Q?Cn3RJk4cB26rY2seULMm6+WBscBqxIBXn6OepZbAP/QXvHIVMLiDZ9h4J9xi?=
 =?us-ascii?Q?mjE8fSIMZpgtYBZjLJ9MnnF/VfdzAVScWGPkPsYH6dLQpLQaS+Y+9ouAoFh8?=
 =?us-ascii?Q?BiiFqiGpXSQce4l+/gwnWUmwSC6SWUELNMFSYGfyseIR1JS78Y6eH8OoVTIo?=
 =?us-ascii?Q?a9s9DR4sIEsNQI5hlPTIDEQHYobr8rb0p7UGuzqWKK6d4aCpBhD3zq7l1juD?=
 =?us-ascii?Q?alDIO3LGNvzTLsZCRtqrxzes7EsxKOTi4Du2yUD+0V9g0LX2Abp4X+hP38ZE?=
 =?us-ascii?Q?FmqLucaJuzKMSOpBkMmDN6vNUAEuLJpR35RZPf2xPFZEeMuW4YaL8UsQx9HJ?=
 =?us-ascii?Q?SsGXeqXTa38oc6E5NzxYmCc1m1uIhnaC8Q8yo5ELjPqDp2RbWGRsnrdUICf1?=
 =?us-ascii?Q?1VksTLNIMHPJNOY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5937.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fViJHp0AnWDfB2kepYLVRjqpHimXykxDgt54Rsa4SliJ4AZkMyTPGm+tlmzM?=
 =?us-ascii?Q?TRo20QVcis3hEl4ERvhAZ+NMqiUBxW7bVq8zZZuxUos9qRw0JGAwmZgY2zbr?=
 =?us-ascii?Q?lqod/40/322UvVDQreZNFUmkhFHP/WYAcDG644faE1kNW/YeD4vH4tp31YUj?=
 =?us-ascii?Q?pk/6WYP9webKzA8nMnHoU7u6mV4KEM6u90kQzsHP64dws0xGh8MSAnDjEtuF?=
 =?us-ascii?Q?BvhcLXRRVjETbLJcw+Bye6gbqaghSh3Mt15I7MqpHy4hQs0rA8WdlndWNh5U?=
 =?us-ascii?Q?g/c7BVxyhkpOVawqH5F0e+KUiJyZH6H6j524OqtoDZXLrcSA8I+OfYiZPsbz?=
 =?us-ascii?Q?LALj0E8PkvTaeX4Ol+RpUJMc+WysZo6Z4XKHvgbvzWkXy7AfHZqRr8v/7D55?=
 =?us-ascii?Q?vWGVjIeqUCo7V9CpIDiZk6+IaDo1V9q4d3LZ1SxUmU4f1L63Q9Xiu4XWtBSb?=
 =?us-ascii?Q?IoeJo/H3gqjSCFviI7UJpNQKM2iuXMueSNVMSSHkkmpu6eT5KB7/3j8oRVj7?=
 =?us-ascii?Q?hmJPmgK3WLGy93VxwJaP37XnsKBWW1mfYUjbxiCy0Lq1Tr1rJF87xRA7HIYQ?=
 =?us-ascii?Q?9Fn7ky6ut1qvHUgI2VPlewAIMETKprqAUweqSsHu2KVPYlBYFrUh3gCrymmU?=
 =?us-ascii?Q?M8sIpmmFja0MmsrFr1zsFxQatZbNRiuqcqpZKpFs0N+PwVjXHlMS7VWtZmAx?=
 =?us-ascii?Q?G+Ul1pFZ+NVXOz8UU0Ejja+FpIGRz8viBBTPT6TTSYqfenqouuTa3jd4SweK?=
 =?us-ascii?Q?DEi2C7Di+76FCHSqq9LXlp9+GWqNVYdcZ7uLHXBEVnTlVhcNmUWtTqT7IGCA?=
 =?us-ascii?Q?hWAbjfzwN/UUeWg7bOzOPKqbdNrZvodkp58BGieRVhCvQbvjChk11Gev6bf9?=
 =?us-ascii?Q?ygySHXpu1NEpq7xzhbCtqiECXs80HEr5S0ECxOxhgkjpI1oxuoA0Mo0tVQF1?=
 =?us-ascii?Q?GZlcwjJeO1wPY81LfzLf2NL0vnGYvdEghpzG66Z3N0oWVkTcO4U3QWwx6cLb?=
 =?us-ascii?Q?oU5hM5aGcRp0oRoAQq9vMdDywfXQFw1T//0hepWhIYhKunn9lCwK+T4Xtt8D?=
 =?us-ascii?Q?Z8wKRCavCN1pGRjtXWUdCuk+Vv7XLn50kXHQR16CUhWk+YiMiso+f3iS1sVk?=
 =?us-ascii?Q?tYveI5xz4yD4X+gdF0T3ujzkSBI7PsCZo7+qTOAMEwdqsuydJ4AFVe5HfAwV?=
 =?us-ascii?Q?Z04H5t8BRE3wHAc9dpkh+/Z2kg/gko2SRMMLF84qDSn9L1O9bdIweYsS4aMT?=
 =?us-ascii?Q?0YtS0FkXiddZXP0KwQprFYSOi1SQWuti55jfmrRpuh+DAUZFb40HB4tEKIOI?=
 =?us-ascii?Q?Pcdp5ffDMdOhKd3mrUu4xe+e+ewbGe29g/kBgq5fyT4aTknfvn4Cba5WwVgB?=
 =?us-ascii?Q?L8UhqNtYenSjysmRqiLQb6RGduDF7bClJV3jRSMz/nAMK/I6WpBZG71lj1wK?=
 =?us-ascii?Q?uJ6rpiEhzVWeKgqnM2ViS3mDJStWFK95KGjr2+XQZ9igLFAs/B/641sb12FY?=
 =?us-ascii?Q?36CADzoV5b7PD9UUQfwkArNtQEPgnopNRwnpA4DZMsTNzDP6NLqBXRNShcl2?=
 =?us-ascii?Q?UHIvwSelIkygM41BDZI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB59375EF7DA8EDD89E1AF31A3E5892DM4PR12MB5937namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb053e5-28f5-4342-dcc2-08dd8c7aee28
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 08:49:36.5399 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aPxY47EhT/siIn/CLhq95WAYl6un81VSyxOhao9w8l1PtV5IGyGi6mHxPgsyZ8i/uqZ2wYNXvSCbBQOCllX7oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8908
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

--_000_DM4PR12MB59375EF7DA8EDD89E1AF31A3E5892DM4PR12MB5937namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

> > @@ -1210,6 +1212,9 @@ static void psp_prep_ta_load_cmd_buf(struct psp_g=
fx_cmd_resp *cmd,
> >        cmd->cmd.cmd_load_ta.app_phy_addr_hi    =3D upper_32_bits(ta_bin=
_mc);
> >        cmd->cmd.cmd_load_ta.app_len            =3D context->bin_desc.si=
ze_bytes;
> >
> > +     if (context->mem_context.shared_bo)
> > +             context->mem_context.shared_mc_addr =3D amdgpu_bo_fb_aper=
_addr(context->mem_context.shared_bo);
> > +
>
> Rather put this into the psp_prep_ta_load_cmd_buf() function and remove t=
he shared_mc_addr member.
>
> Please double check other similar cases as well.

Removing of these members are easy to change and test, since they are used =
in one c file. I can make one refactoring patch for each removal.
- ta_mem_context.shared_mc_addr
- amdgpu_firmware.fw_buf_mc
- psp_context.tmr_mc_addr
- psp_context.cmd_buf_mc_addr
- dummy_read_1_table->mc_address

Removing of these members will involve changes in multiple PSP and SMU vers=
ion files. For versions that MI308 don't use, I don't have the environment =
to test the changes. Should I remove them as well? @Koenig, Christian<mailt=
o:Christian.Koenig@amd.com>
- psp->fw_pri_mc_addr
- psp->fence_buf_mc_addr
- psp->km_ring.ring_mem_mc_addr
- driver_table->mc_address
- pm_status_table->mc_address

Thanks
Sam

From: Koenig, Christian <Christian.Koenig@amd.com>
Date: Wednesday, April 30, 2025 at 20:51
To: Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com>, amd-gfx@lists.freedesktop=
.org <amd-gfx@lists.freedesktop.org>
Cc: Zhao, Victor <Victor.Zhao@amd.com>, Chang, HaiJun <HaiJun.Chang@amd.com=
>, Deucher, Alexander <Alexander.Deucher@amd.com>, Jiang Liu <gerry@linux.a=
libaba.com>
Subject: Re: [PATCH v2 2/3] drm/amdgpu: update GPU addresses for SMU and PS=
P
On 4/30/25 12:16, Samuel Zhang wrote:
> add amdgpu_bo_fb_aper_addr() and update the cached GPU addresses to use
> the FB aperture address for SMU and PSP.
>
> 2 reasons for this change:
> 1. when pdb0 is enabled, gpu addr from amdgpu_bo_create_kernel() is GART
> aperture address, it is not compatible with SMU and PSP, it need to updat=
ed
> to use FB aperture address.
> 2. Since FB aperture address will change after switching to new GPU
> index after hibernation, it need to be updated after resume.
>
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 18 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 22 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c  |  3 +++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 17 +++++++++++++++++
>  7 files changed, 63 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index a2abddf3c110..ef6eaddc2ccb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -209,6 +209,7 @@ void amdgpu_gmc_vram_location(struct amdgpu_device *a=
dev, struct amdgpu_gmc *mc,
>        uint64_t vis_limit =3D (uint64_t)amdgpu_vis_vram_limit << 20;
>        uint64_t limit =3D (uint64_t)amdgpu_vram_limit << 20;
>
> +     mc->vram_offset =3D base;
>        mc->vram_start =3D base;
>        mc->vram_end =3D mc->vram_start + mc->mc_vram_size - 1;
>        if (limit < mc->real_vram_size)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.h
> index bd7fc123b8f9..291d96168a57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -251,6 +251,7 @@ struct amdgpu_gmc {
>         */
>        u64                     vram_start;
>        u64                     vram_end;
> +     u64                     vram_offset;


Please don't add any new fields here. We should already have all the necess=
ary information in that structure.


>        /* FB region , it's same as local vram region in single GPU, in XG=
MI
>         * configuration, this region covers all GPUs in the same hive ,
>         * each GPU in the hive has the same view of this FB region .
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index 4e794d546b61..ca29270f66d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1513,6 +1513,24 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
>        return amdgpu_bo_gpu_offset_no_check(bo);
>  }
>
> +/**
> + * amdgpu_bo_fb_aper_addr - return FB aperture GPU offset of the VRAM bo
> + * @bo:      amdgpu VRAM buffer object for which we query the offset
> + *
> + * Returns:
> + * current FB aperture GPU offset of the object.
> + */
> +u64 amdgpu_bo_fb_aper_addr(struct amdgpu_bo *bo)
> +{
> +     struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
> +     uint64_t offset;
> +
> +     WARN_ON_ONCE(bo->tbo.resource->mem_type !=3D TTM_PL_VRAM);
> +
> +     offset =3D (bo->tbo.resource->start << PAGE_SHIFT) + adev->gmc.vram=
_offset;

Rather use fb_base + XGMI hive index here.

> +     return amdgpu_gmc_sign_extend(offset);
> +}
> +
>  /**
>   * amdgpu_bo_gpu_offset_no_check - return GPU offset of bo
>   * @bo:      amdgpu object for which we query the offset
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.h
> index dcce362bfad3..c8a63e38f5d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -320,6 +320,7 @@ int amdgpu_bo_sync_wait_resv(struct amdgpu_device *ad=
ev, struct dma_resv *resv,
>                             bool intr);
>  int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
>  u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
> +u64 amdgpu_bo_fb_aper_addr(struct amdgpu_bo *bo);
>  u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
>  uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo);
>  uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index e1e658a97b36..bdab40b42983 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -871,6 +871,8 @@ static int psp_tmr_init(struct psp_context *psp)
>                                              &psp->tmr_bo, &psp->tmr_mc_a=
ddr,
>                                              pptr);
>        }
> +     if (psp->tmr_bo)
> +             psp->tmr_mc_addr =3D amdgpu_bo_fb_aper_addr(psp->tmr_bo);
>
>        return ret;
>  }
> @@ -1210,6 +1212,9 @@ static void psp_prep_ta_load_cmd_buf(struct psp_gfx=
_cmd_resp *cmd,
>        cmd->cmd.cmd_load_ta.app_phy_addr_hi    =3D upper_32_bits(ta_bin_m=
c);
>        cmd->cmd.cmd_load_ta.app_len            =3D context->bin_desc.size=
_bytes;
>
> +     if (context->mem_context.shared_bo)
> +             context->mem_context.shared_mc_addr =3D amdgpu_bo_fb_aper_a=
ddr(context->mem_context.shared_bo);
> +

Rather put this into the psp_prep_ta_load_cmd_buf() function and remove the=
 shared_mc_addr member.

Please double check other similar cases as well.

Apart from that this looks rather good to me,
Christian.


>        cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_lo =3D
>                lower_32_bits(context->mem_context.shared_mc_addr);
>        cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_hi =3D
> @@ -2336,11 +2341,26 @@ bool amdgpu_psp_tos_reload_needed(struct amdgpu_d=
evice *adev)
>        return false;
>  }
>
> +static void psp_update_gpu_addresses(struct amdgpu_device *adev)
> +{
> +     struct psp_context *psp =3D &adev->psp;
> +
> +     if (psp->cmd_buf_bo && psp->cmd_buf_mem) {
> +             psp->fw_pri_mc_addr =3D amdgpu_bo_fb_aper_addr(psp->fw_pri_=
bo);
> +             psp->fence_buf_mc_addr =3D amdgpu_bo_fb_aper_addr(psp->fenc=
e_buf_bo);
> +             psp->cmd_buf_mc_addr =3D amdgpu_bo_fb_aper_addr(psp->cmd_bu=
f_bo);
> +     }
> +     if (adev->firmware.rbuf && psp->km_ring.ring_mem)
> +             psp->km_ring.ring_mem_mc_addr =3D amdgpu_bo_fb_aper_addr(ad=
ev->firmware.rbuf);
> +}
> +
>  static int psp_hw_start(struct psp_context *psp)
>  {
>        struct amdgpu_device *adev =3D psp->adev;
>        int ret;
>
> +     psp_update_gpu_addresses(adev);
> +
>        if (!amdgpu_sriov_vf(adev)) {
>                if ((is_psp_fw_valid(psp->kdb)) &&
>                    (psp->funcs->bootloader_load_kdb !=3D NULL)) {
> @@ -3976,6 +3996,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct de=
vice *dev,
>        memcpy_toio(fw_pri_cpu_addr, usbc_pd_fw->data, usbc_pd_fw->size);
>
>        mutex_lock(&adev->psp.mutex);
> +     fw_pri_mc_addr =3D amdgpu_bo_fb_aper_addr(fw_buf_bo);
>        ret =3D psp_load_usbc_pd_fw(&adev->psp, fw_pri_mc_addr);
>        mutex_unlock(&adev->psp.mutex);
>
> @@ -4085,6 +4106,7 @@ static ssize_t amdgpu_psp_vbflash_read(struct file =
*filp, struct kobject *kobj,
>        memcpy_toio(fw_pri_cpu_addr, adev->psp.vbflash_tmp_buf, adev->psp.=
vbflash_image_size);
>
>        mutex_lock(&adev->psp.mutex);
> +     fw_pri_mc_addr =3D amdgpu_bo_fb_aper_addr(fw_buf_bo);
>        ret =3D psp_update_spirom(&adev->psp, fw_pri_mc_addr);
>        mutex_unlock(&adev->psp.mutex);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ucode.c
> index 3d9e9fdc10b4..f3b56c219e7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1152,6 +1152,9 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *adev=
)
>                adev->firmware.max_ucodes =3D AMDGPU_UCODE_ID_MAXIMUM;
>        }
>
> +     if (adev->firmware.fw_buf)
> +             adev->firmware.fw_buf_mc =3D amdgpu_bo_fb_aper_addr(adev->f=
irmware.fw_buf);
> +
>        for (i =3D 0; i < adev->firmware.max_ucodes; i++) {
>                ucode =3D &adev->firmware.ucode[i];
>                if (ucode->fw) {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index 315b0856bf02..dfdda98cf0c5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1000,6 +1000,21 @@ static int smu_fini_fb_allocations(struct smu_cont=
ext *smu)
>        return 0;
>  }
>
> +static void smu_update_gpu_addresses(struct smu_context *smu)
> +{
> +     struct smu_table_context *smu_table =3D &smu->smu_table;
> +     struct smu_table *pm_status_table =3D smu_table->tables + SMU_TABLE=
_PMSTATUSLOG;
> +     struct smu_table *driver_table =3D &(smu_table->driver_table);
> +     struct smu_table *dummy_read_1_table =3D &smu_table->dummy_read_1_t=
able;
> +
> +     if (pm_status_table->bo)
> +             pm_status_table->mc_address =3D amdgpu_bo_fb_aper_addr(pm_s=
tatus_table->bo);
> +     if (driver_table->bo)
> +             driver_table->mc_address =3D amdgpu_bo_fb_aper_addr(driver_=
table->bo);
> +     if (dummy_read_1_table->bo)
> +             dummy_read_1_table->mc_address =3D amdgpu_bo_fb_aper_addr(d=
ummy_read_1_table->bo);
> +}
> +
>  /**
>   * smu_alloc_memory_pool - allocate memory pool in the system memory
>   *
> @@ -1789,6 +1804,8 @@ static int smu_start_smc_engine(struct smu_context =
*smu)
>        struct amdgpu_device *adev =3D smu->adev;
>        int ret =3D 0;
>
> +     smu_update_gpu_addresses(smu);
> +
>        smu->smc_fw_state =3D SMU_FW_INIT;
>
>        if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP) {

--_000_DM4PR12MB59375EF7DA8EDD89E1AF31A3E5892DM4PR12MB5937namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-CN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -1210,6 +1212,9 @@ static void psp_prep_ta_load_cmd_buf(s=
truct psp_gfx_cmd_resp *cmd,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_lo=
ad_ta.app_phy_addr_hi&nbsp;&nbsp;&nbsp; =3D upper_32_bits(ta_bin_mc);<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_lo=
ad_ta.app_len&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =3D context-&gt;bin_desc.size_bytes;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (context-&gt;mem_context.shared=
_bo)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; context-&gt;mem_context.shared_mc_addr =3D amdgpu_bo_fb_aper_=
addr(context-&gt;mem_context.shared_bo);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; Rather put this into the psp_prep_ta_load_cmd_buf() function and =
remove the shared_mc_addr member.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; Please double check other similar cases as well.<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Removing of these members are easy to change and test, =
since they are used in one c file. I can make one refactoring patch for eac=
h removal.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">- ta_mem_context.shared_mc_addr<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">- amdgpu_firmware.fw_buf_mc<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">- psp_context.tmr_mc_addr<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">- psp_context.cmd_buf_mc_addr<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">- dummy_read_1_table-&gt;mc_address<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Removing of these members will involve changes in multi=
ple PSP and SMU version files. For versions that MI308 don't use, I don't h=
ave the environment to test the changes. Should
 I remove them as well? <a id=3D"OWAAM15AC2FC7572B7247A4F02F1FD462F32A" hre=
f=3D"mailto:Christian.Koenig@amd.com">
<span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decoration:non=
e">@Koenig, Christian</span></a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">- psp-&gt;fw_pri_mc_addr<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">- psp-&gt;fence_buf_mc_addr<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">- psp-&gt;km_ring.ring_mem_mc_addr<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">- driver_table-&gt;mc_address<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">- pm_status_table-&gt;mc_address<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Thanks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Sam<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">From:
</span></b><span style=3D"font-size:12.0pt;font-family:&quot;Aptos&quot;,sa=
ns-serif;color:black">Koenig, Christian &lt;Christian.Koenig@amd.com&gt;<br=
>
<b>Date: </b>Wednesday, April 30, 2025 at 20:51<br>
<b>To: </b>Zhang, GuoQing (Sam) &lt;GuoQing.Zhang@amd.com&gt;, amd-gfx@list=
s.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc: </b>Zhao, Victor &lt;Victor.Zhao@amd.com&gt;, Chang, HaiJun &lt;HaiJ=
un.Chang@amd.com&gt;, Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;,=
 Jiang Liu &lt;gerry@linux.alibaba.com&gt;<br>
<b>Subject: </b>Re: [PATCH v2 2/3] drm/amdgpu: update GPU addresses for SMU=
 and PSP<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">On 4/30/25 12:16, Sam=
uel Zhang wrote:<br>
&gt; add amdgpu_bo_fb_aper_addr() and update the cached GPU addresses to us=
e<br>
&gt; the FB aperture address for SMU and PSP.<br>
&gt; <br>
&gt; 2 reasons for this change:<br>
&gt; 1. when pdb0 is enabled, gpu addr from amdgpu_bo_create_kernel() is GA=
RT<br>
&gt; aperture address, it is not compatible with SMU and PSP, it need to up=
dated<br>
&gt; to use FB aperture address.<br>
&gt; 2. Since FB aperture address will change after switching to new GPU<br=
>
&gt; index after hibernation, it need to be updated after resume.<br>
&gt; <br>
&gt; Signed-off-by: Jiang Liu &lt;gerry@linux.alibaba.com&gt;<br>
&gt; Signed-off-by: Samuel Zhang &lt;guoqing.zhang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c&nbsp;&nbsp;&nbsp; |&nbsp=
; 1 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h&nbsp;&nbsp;&nbsp; |&nbsp=
; 1 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 18 ++++++++++++++++=
++<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |&nbsp; 1 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c&nbsp;&nbsp;&nbsp; | 22 +=
+++++++++++++++++++++<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c&nbsp; |&nbsp; 3 +++<br=
>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp; | 17 +++++++++++=
++++++<br>
&gt;&nbsp; 7 files changed, 63 insertions(+)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gmc.c<br>
&gt; index a2abddf3c110..ef6eaddc2ccb 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt; @@ -209,6 +209,7 @@ void amdgpu_gmc_vram_location(struct amdgpu_device=
 *adev, struct amdgpu_gmc *mc,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t vis_limit =3D (uint=
64_t)amdgpu_vis_vram_limit &lt;&lt; 20;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t limit =3D (uint64_t=
)amdgpu_vram_limit &lt;&lt; 20;<br>
&gt;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;vram_offset =3D base;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;vram_start =3D base;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;vram_end =3D mc-&gt;v=
ram_start + mc-&gt;mc_vram_size - 1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (limit &lt; mc-&gt;real_v=
ram_size)<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gmc.h<br>
&gt; index bd7fc123b8f9..291d96168a57 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt; @@ -251,6 +251,7 @@ struct amdgpu_gmc {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; vram_start;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; vram_end;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; vram_offset;<br>
<br>
<br>
Please don't add any new fields here. We should already have all the necess=
ary information in that structure.<br>
<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* FB region , it's same as =
local vram region in single GPU, in XGMI<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * configuration, this =
region covers all GPUs in the same hive ,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * each GPU in the hive=
 has the same view of this FB region .<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_object.c<br>
&gt; index 4e794d546b61..ca29270f66d1 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; @@ -1513,6 +1513,24 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_bo_gpu_offset_=
no_check(bo);<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; +/**<br>
&gt; + * amdgpu_bo_fb_aper_addr - return FB aperture GPU offset of the VRAM=
 bo<br>
&gt; + * @bo:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu VRAM buffer object for w=
hich we query the offset<br>
&gt; + *<br>
&gt; + * Returns:<br>
&gt; + * current FB aperture GPU offset of the object.<br>
&gt; + */<br>
&gt; +u64 amdgpu_bo_fb_aper_addr(struct amdgpu_bo *bo)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D amdgpu_ttm_ad=
ev(bo-&gt;tbo.bdev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint64_t offset;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON_ONCE(bo-&gt;tbo.resource-&gt;mem_typ=
e !=3D TTM_PL_VRAM);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; offset =3D (bo-&gt;tbo.resource-&gt;start &l=
t;&lt; PAGE_SHIFT) + adev-&gt;gmc.vram_offset;<br>
<br>
Rather use fb_base + XGMI hive index here.<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_gmc_sign_extend(offset);<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; /**<br>
&gt;&nbsp;&nbsp; * amdgpu_bo_gpu_offset_no_check - return GPU offset of bo<=
br>
&gt;&nbsp;&nbsp; * @bo:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu object for whi=
ch we query the offset<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_object.h<br>
&gt; index dcce362bfad3..c8a63e38f5d9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
&gt; @@ -320,6 +320,7 @@ int amdgpu_bo_sync_wait_resv(struct amdgpu_device =
*adev, struct dma_resv *resv,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; bool intr);<br>
&gt;&nbsp; int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool =
intr);<br>
&gt;&nbsp; u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);<br>
&gt; +u64 amdgpu_bo_fb_aper_addr(struct amdgpu_bo *bo);<br>
&gt;&nbsp; u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);<br>
&gt;&nbsp; uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo);<br=
>
&gt;&nbsp; uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *ad=
ev,<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_psp.c<br>
&gt; index e1e658a97b36..bdab40b42983 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&gt; @@ -871,6 +871,8 @@ static int psp_tmr_init(struct psp_context *psp)<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;tmr_bo, &amp=
;psp-&gt;tmr_mc_addr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pptr);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (psp-&gt;tmr_bo)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; psp-&gt;tmr_mc_addr =3D amdgpu_bo_fb_aper_addr(psp-&gt;tmr_bo);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt; @@ -1210,6 +1212,9 @@ static void psp_prep_ta_load_cmd_buf(struct psp_=
gfx_cmd_resp *cmd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ta.app_=
phy_addr_hi&nbsp;&nbsp;&nbsp; =3D upper_32_bits(ta_bin_mc);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ta.app_=
len&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D c=
ontext-&gt;bin_desc.size_bytes;<br>
&gt;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (context-&gt;mem_context.shared_bo)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; context-&gt;mem_context.shared_mc_addr =3D amdgpu_bo_fb_aper_addr(conte=
xt-&gt;mem_context.shared_bo);<br>
&gt; +<br>
<br>
Rather put this into the psp_prep_ta_load_cmd_buf() function and remove the=
 shared_mc_addr member.<br>
<br>
Please double check other similar cases as well.<br>
<br>
Apart from that this looks rather good to me,<br>
Christian.<br>
<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ta.cmd_=
buf_phy_addr_lo =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; lower_32_bits(context-&gt;mem_context.shared_mc_addr);<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ta.cmd_=
buf_phy_addr_hi =3D<br>
&gt; @@ -2336,11 +2341,26 @@ bool amdgpu_psp_tos_reload_needed(struct amdgp=
u_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; +static void psp_update_gpu_addresses(struct amdgpu_device *adev)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct psp_context *psp =3D &amp;adev-&gt;ps=
p;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (psp-&gt;cmd_buf_bo &amp;&amp; psp-&gt;cm=
d_buf_mem) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; psp-&gt;fw_pri_mc_addr =3D amdgpu_bo_fb_aper_addr(psp-&gt;fw_pri_bo);<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; psp-&gt;fence_buf_mc_addr =3D amdgpu_bo_fb_aper_addr(psp-&gt;fence_buf_=
bo);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; psp-&gt;cmd_buf_mc_addr =3D amdgpu_bo_fb_aper_addr(psp-&gt;cmd_buf_bo);=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.rbuf &amp;&amp; psp-&g=
t;km_ring.ring_mem)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; psp-&gt;km_ring.ring_mem_mc_addr =3D amdgpu_bo_fb_aper_addr(adev-&gt;fi=
rmware.rbuf);<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; static int psp_hw_start(struct psp_context *psp)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D psp-&gt;adev;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; psp_update_gpu_addresses(adev);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) =
{<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if ((is_psp_fw_valid(psp-&gt;kdb)) &amp;&amp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (psp-&gt;funcs-&gt;bootloader_l=
oad_kdb !=3D NULL)) {<br>
&gt; @@ -3976,6 +3996,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct=
 device *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_toio(fw_pri_cpu_addr,=
 usbc_pd_fw-&gt;data, usbc_pd_fw-&gt;size);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;psp=
.mutex);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; fw_pri_mc_addr =3D amdgpu_bo_fb_aper_addr(fw=
_buf_bo);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_load_usbc_pd_fw(=
&amp;adev-&gt;psp, fw_pri_mc_addr);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;p=
sp.mutex);<br>
&gt;&nbsp; <br>
&gt; @@ -4085,6 +4106,7 @@ static ssize_t amdgpu_psp_vbflash_read(struct fi=
le *filp, struct kobject *kobj,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_toio(fw_pri_cpu_addr,=
 adev-&gt;psp.vbflash_tmp_buf, adev-&gt;psp.vbflash_image_size);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;psp=
.mutex);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; fw_pri_mc_addr =3D amdgpu_bo_fb_aper_addr(fw=
_buf_bo);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_update_spirom(&a=
mp;adev-&gt;psp, fw_pri_mc_addr);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;p=
sp.mutex);<br>
&gt;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ucode.c<br>
&gt; index 3d9e9fdc10b4..f3b56c219e7e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c<br>
&gt; @@ -1152,6 +1152,9 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *a=
dev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.max_ucodes =3D AMDGPU_UCODE_ID_MAXIMU=
M;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.fw_buf)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;firmware.fw_buf_mc =3D amdgpu_bo_fb_aper_addr(adev-&gt;firmwar=
e.fw_buf);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&g=
t;firmware.max_ucodes; i++) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ucode =3D &amp;adev-&gt;firmware.ucode[i];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ucode-&gt;fw) {<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/d=
rm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; index 315b0856bf02..dfdda98cf0c5 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; @@ -1000,6 +1000,21 @@ static int smu_fini_fb_allocations(struct smu_c=
ontext *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; +static void smu_update_gpu_addresses(struct smu_context *smu)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *smu_table =3D &amp=
;smu-&gt;smu_table;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table *pm_status_table =3D smu_ta=
ble-&gt;tables + SMU_TABLE_PMSTATUSLOG;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table *driver_table =3D &amp;(smu=
_table-&gt;driver_table);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table *dummy_read_1_table =3D &am=
p;smu_table-&gt;dummy_read_1_table;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (pm_status_table-&gt;bo)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pm_status_table-&gt;mc_address =3D amdgpu_bo_fb_aper_addr(pm_status_tab=
le-&gt;bo);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (driver_table-&gt;bo)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; driver_table-&gt;mc_address =3D amdgpu_bo_fb_aper_addr(driver_table-&gt=
;bo);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (dummy_read_1_table-&gt;bo)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dummy_read_1_table-&gt;mc_address =3D amdgpu_bo_fb_aper_addr(dummy_read=
_1_table-&gt;bo);<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; /**<br>
&gt;&nbsp;&nbsp; * smu_alloc_memory_pool - allocate memory pool in the syst=
em memory<br>
&gt;&nbsp;&nbsp; *<br>
&gt; @@ -1789,6 +1804,8 @@ static int smu_start_smc_engine(struct smu_conte=
xt *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D smu-&gt;adev;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; smu_update_gpu_addresses(smu);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smc_fw_state =3D SMU=
_FW_INIT;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_t=
ype !=3D AMDGPU_FW_LOAD_PSP) {</p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB59375EF7DA8EDD89E1AF31A3E5892DM4PR12MB5937namp_--
