Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E568DC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 02:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A95B60FE7
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 02:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A95B60FE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C70D16E171;
	Wed, 19 May 2021 02:41:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64DBC6E171
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 02:41:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTWRtpmcmy5FlShzcjLVoLHBNLXfrJWoW9YrYnOM1AtMLw8rg7Da/7NclaNhh+6p7P8KvYmbLo1FOBDEaHqzooayzQvuwA9k8vmEz3YASxkTnmzic6uKTKuGkWehPeaZXImDRoHBXlfsgcx4idmC/0fdwgEHgjInYWIdDlY7enoO6QmXNecrPxmaqNX2k+7i3wdkMPz5aZBSFcfT7AFGG8d1bq4PjORY1HtunCHqYag/DBf+vFGHiJ3nSQMTYd3j59YZpSdJYJgqbV+NU3JmpqShtnmxNEVWfz3MtSPCAmnXwM2Rmz25rjZflqr6QzKEYbVZFTXeV9hlHUYKsX0S6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agsSvDW84FTceVawR4avtAM/X7vrHu12d2b98CjGAQo=;
 b=oQnNPDGV5H8LREl77ycphNoXgXmaWxx7Ylhi97F+re1TsXoE0+KWmNsJys4qFibsad42HdvToGtKrHYIiMe4aS9XMaDu5Eq/sU2qKpvgf3bAYELcchggdcCLflyC1+xlTM5YnZcKGluqpkJA2kgsgxo/7vwM6pugfNsCxP+hW3HTiQSKokI2OKDskcMvFWs8gGbU3wVJB+ru1P633tWGFwFyp3Nlcmnd06N7oABmxdG9Q4NINL23jJwfFaysI518XMd7zizp9KLvqUPOcJigg2eclMhGNhoHBgjsR1YEW7d0DgOOIqWFRHQxE0VyE7hUymfmQR9L6sgszbxO3+spMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agsSvDW84FTceVawR4avtAM/X7vrHu12d2b98CjGAQo=;
 b=lqTNbGLJBKIgeFPAfvJ3emjjzGirryagm/Yc8K9uPF5Y06o7nqin6GeDeNV5DDVFmdr+jqSKQwFltN+0fZKrDVyRbJKZ2OiDAXR5mnh09maTtaqtQrJdl2XzbFrk+MrvDIqTgl2yEDq4J3bWw23TrkF/V58yUYaNqz0zR+GthvQ=
Received: from CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17)
 by CH0PR12MB5204.namprd12.prod.outlook.com (2603:10b6:610:bb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 02:41:43 +0000
Received: from CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::a1d1:38a:2086:b5b]) by CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::a1d1:38a:2086:b5b%3]) with mapi id 15.20.4129.032; Wed, 19 May 2021
 02:41:42 +0000
From: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
To: "StDenis, Tom" <Tom.StDenis@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Nieto, David M" <David.Nieto@amd.com>,
 "maraeo@gmail.com" <maraeo@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add vbios info ioctl interface
Thread-Topic: [PATCH] drm/amdgpu: Add vbios info ioctl interface
Thread-Index: AQHXS9+nZ16zyHed7UewCZhFKBxS46rpJ7PwgAAQuoCAAAJ7AIAA3EfQ
Date: Wed, 19 May 2021 02:41:42 +0000
Message-ID: <CH0PR12MB5156C835F4B80F4504B0E98AF82B9@CH0PR12MB5156.namprd12.prod.outlook.com>
References: <20210518121628.9811-1-Jiawei.Gu@amd.com>
 <CH0PR12MB51560CD55134762EF8FE19E0F82C9@CH0PR12MB5156.namprd12.prod.outlook.com>,
 <1ec97d1f-aaa3-46c1-b702-378879e67cc5@amd.com>
 <DM6PR12MB3547CE479C026EF6D7F8A26CF72C9@DM6PR12MB3547.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3547CE479C026EF6D7F8A26CF72C9@DM6PR12MB3547.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-19T02:41:35Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 189e1b74-ba05-4765-d84a-08d91a6fa31a
x-ms-traffictypediagnostic: CH0PR12MB5204:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB52043A14745C7D6E1465EDC2F82B9@CH0PR12MB5204.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 41wYnP1eP38RQla/XzhL5X/a6cnd66+VhxcivzjtZcgOyEeuQYiZ0mza+BccRJ7+DzeYhfjYGcY7N0+e6AusRGSFCwxFncD2qpa34Vjm/yLZKCQa/urMB2bGzspNW7V9gW9Cy+d+6JpY2TWe0N3DZRZIAHHH19IDWIB3WIihWNngiQRL5fkA5cchTnOOQ3HKAUgVUnGBhhBK44f3NIdovc1T/++kwG08L0j3zeQv+3wq/RtP/kHxhls5+lPAH4fRUqucXJjvrHMfjDhfY2TaaNIpxv5ZUCuIqYa6u3xlFus1HowbiTPArueLrKPDRUsVIqQcCyiWOlICszxTwgUoC6jqCmtEVYse9gsc5ZLfkXBniBZuWbUJW7ARiAS2OfLQWbpbRRwGhY2ekbQGzBrPe6qzU58fp/gbtcP6K61vDq6lP3P9RPGWht6LWPx3VTZ6lswOxacE37QOSWH7f0Twq/QwUAeTC1OT4XpvVdgrAwZEt80WhkzGfQx/ZOoLCxfFInhkY27TcOCClGj+PHuwgmLyEMr9ssPrzK0R7vjlbrxLxRKxnhJcJIGAyx9JrFpvsMmovc8/xX/gYbSbNZLlkPr8X8o4HSSt0Xoy8rizCi4UWjksXA8G4JOuDR/ZbkNQTS7zJYEf7wcpQYdxwXiqS/xx40WYMffPA8VCnNOkcmbC8ej38kx12qtOafvoRr3h
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(136003)(376002)(396003)(366004)(38100700002)(110136005)(122000001)(66946007)(478600001)(64756008)(66556008)(316002)(66476007)(45080400002)(76116006)(66446008)(83380400001)(33656002)(86362001)(4326008)(5660300002)(9686003)(26005)(53546011)(6636002)(921005)(30864003)(186003)(7696005)(52536014)(55016002)(8676002)(2906002)(71200400001)(66574015)(6506007)(966005)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?KRYEyTyIzY6kIqDXkIIg73csu/p9vDOTpU5oJKBZBp9hZMb6fx0e49zYSV?=
 =?iso-8859-1?Q?HYwwVdJi9ti0ER/Vg8Ag3pb6gEC1EP53q28+tNjjrY+qSiO4iFSXLOhVbg?=
 =?iso-8859-1?Q?9MGDvQ2P8FFTxtpdCh+oYcLzJo17cz4TYt8cVteWpsahjJtSwscIe0Pbw3?=
 =?iso-8859-1?Q?5Ra2vOl7PRUZDqh7BJOu8o89vxZDXBuC7u87TwTZzw4wKbfrTvrvDhm+kQ?=
 =?iso-8859-1?Q?3x7emRqVdzWs5e0NQV8TtK1tzSpOSZx/wUJk+mZK82n4N2jEvsnXDtTU8a?=
 =?iso-8859-1?Q?Ho3OC6+WLygsCiw5u3JalzQAa0R44flNx2/0Ydh1IKGvDMXubq4EmPnE5x?=
 =?iso-8859-1?Q?b4Cnfl6m1lFparSufx0MBhjV1wHNncFri2oilIX4JIgX1/EVNxufSL0nRD?=
 =?iso-8859-1?Q?BXQA+f9GSwtA03h3IM4P5Wtf4If2Jr7oWH82neDQO8jSq10yhlauLRN1rH?=
 =?iso-8859-1?Q?U9ME4WRN4j1rQB9fbSLMWLZfA6B85I3cEc9LlWouXfaWDR/eQV6sOQrThx?=
 =?iso-8859-1?Q?TiKZ5v4TdZAAbdvDyaH1nJqgsl+TFJd+YrC4cL9GwRa2LUZwvubQ/WmG5Z?=
 =?iso-8859-1?Q?ZIMDJycm/FmuZihI7Cn7P4nOUOMwLXrPeGpeQ20ME2am1g0O5MDsu52ioG?=
 =?iso-8859-1?Q?CfS0wIQ6PbhNRwNzrvfPYeikI300HS0P4osIxLVtgmwJO1QvpN7OFIb//Q?=
 =?iso-8859-1?Q?0FR7GsvmN3GI6HVlAouwtRjrRZTvM8Kmx4PrWPEqIWzd4OIpPVWOmpTtnF?=
 =?iso-8859-1?Q?z/unuj3cCQSoTpI0t0jMO8sW2uwbX3TkoAFigKyhnLOw1pOwWW/YdQTzxE?=
 =?iso-8859-1?Q?75UpsDdxjAIqSUQLP+vQUwiQLLcWqIdS+ns1DBI+RVGPoKJFomL3Es43Om?=
 =?iso-8859-1?Q?nqv/T4jJizTrlFYjJ1DbpJ9rsMl8f4NPAZIauQO01VfoJFYp+Q6IfVYKV3?=
 =?iso-8859-1?Q?AOBSxPTVJyDHJxFhlgK+zf2641rsFoC51h+yGC6IzMSPnL2BoV8KI1ALcY?=
 =?iso-8859-1?Q?rVRr2DOptF+biTxa1jHwSfNHY9mac/1q9dD6KBagNdL5sHKv99leJMMYcP?=
 =?iso-8859-1?Q?dAdh9PfUh/orfhPO7fDPrqiR1KRv0CSA3RtxbZ6lwxvf4vJTBF4hIJ11gi?=
 =?iso-8859-1?Q?TmMhX12XJ007sbXsHxOfwSOssdJl7RAMxv1UbuLl8/MGRzDgZEyM/+wNdb?=
 =?iso-8859-1?Q?Y9EgHWS6Yi54sGpPVwctciksztURleN9YDb2g8gwSNeItaNhU+IJZvZDkP?=
 =?iso-8859-1?Q?ZdIp3IpSB9JjMgAoIqexiV9+4zucNzIB435mRTY12ixnu5FDpc0d/Y4q6v?=
 =?iso-8859-1?Q?pKm4uzO30erhTtgmL2CtdCzjMsoNe1JOnaSYIpe+lO6/FXZMZQt5rxTSON?=
 =?iso-8859-1?Q?tRScpfErWO?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 189e1b74-ba05-4765-d84a-08d91a6fa31a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 02:41:42.7722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Va3uV89IHeSNuSV9UPUhsp+NCMmr2BDPjhC3CLolGZon+H/AP7TW3MeD38a1+HYYhSCfpfcPby7C1HW25lJoBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5204
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Thanks Tom's suggestion.
I'm fine to replace ioctl with sysfs.

Hi all, how about this sysfs alternative?

And if it's a must to insist on ioctl, is there any Mesa expert to help pro=
vide the patch?

Best regards,
Jiawei


-----Original Message-----
From: StDenis, Tom <Tom.StDenis@amd.com> =

Sent: Tuesday, May 18, 2021 9:26 PM
To: Koenig, Christian <Christian.Koenig@amd.com>; Gu, JiaWei (Will) <JiaWei=
.Gu@amd.com>; amd-gfx@lists.freedesktop.org; Nieto, David M <David.Nieto@am=
d.com>; maraeo@gmail.com; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface

[AMD Official Use Only - Internal Distribution Only]

If changing the ioctl is an issue why not just use sysfs?  umr already make=
s uses of all three for it's purposes so it's fine by me for either.

Tom

________________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Christia=
n K=F6nig <christian.koenig@amd.com>
Sent: Tuesday, May 18, 2021 09:17
To: Gu, JiaWei (Will); amd-gfx@lists.freedesktop.org; Nieto, David M; marae=
o@gmail.com; Deucher, Alexander
Cc: Deng, Emily
Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface

Well not an expert on that stuff, but looks like that should work for me.

Question is can you provide a patch to use that information in Mesa as well=
? Umr might be sufficient as well as justification for upstreaming, but I w=
ant to be better save than sorry.

Unless Marek has a better idea maybe add the vbios version to the string re=
turned by GLX_MESA_query_renderer or something like that.

Thanks,
Christian.

Am 18.05.21 um 14:19 schrieb Gu, JiaWei (Will):
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi all,
>
> Please help confirm that we're all fine with this new struct in uapi in t=
his V3 patch:
>
> +struct drm_amdgpu_info_vbios {
> +     __u8 name[64];
> +     __u8 vbios_pn[64];
> +     __u32 version;
> +     __u8 vbios_ver_str[32];
> +     __u8 date[32];
> +};
>
> Best regards,
> Jiawei
>
> -----Original Message-----
> From: Jiawei Gu <Jiawei.Gu@amd.com>
> Sent: Tuesday, May 18, 2021 8:16 PM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian =

> <Christian.Koenig@amd.com>; Nieto, David M <David.Nieto@amd.com>; =

> maraeo@gmail.com; Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Deng, Emily <Emily.Deng@amd.com>; Gu, JiaWei (Will) =

> <JiaWei.Gu@amd.com>
> Subject: [PATCH] drm/amdgpu: Add vbios info ioctl interface
>
> Add AMDGPU_INFO_VBIOS_INFO subquery id for detailed vbios info.
>
> Provides a way for the user application to get the VBIOS information with=
out having to parse the binary.
> It is useful for the user to be able to display in a simple way the VBIOS=
 version in their system if they happen to encounter an issue.
>
> V2:
> Use numeric serial.
> Parse and expose vbios version string.
>
> V3:
> Remove redundant data in drm_amdgpu_info_vbios struct.
>
> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  15 ++
>   drivers/gpu/drm/amd/amdgpu/atom.c          | 172 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/atom.h          |  10 ++
>   drivers/gpu/drm/amd/include/atomfirmware.h |   5 +
>   include/uapi/drm/amdgpu_drm.h              |  10 ++
>   5 files changed, 212 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c =

> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 8d12e474745a..524e4fe5efe8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -861,6 +861,21 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *=
data, struct drm_file *filp)
>                                           min((size_t)size, (size_t)(bios=
_size - bios_offset)))
>                                       ? -EFAULT : 0;
>               }
> +             case AMDGPU_INFO_VBIOS_INFO: {
> +                     struct drm_amdgpu_info_vbios vbios_info =3D {};
> +                     struct atom_context *atom_context;
> +
> +                     atom_context =3D adev->mode_info.atom_context;
> +                     memcpy(vbios_info.name, atom_context->name, sizeof(=
atom_context->name));
> +                     memcpy(vbios_info.vbios_pn, atom_context->vbios_pn,=
 sizeof(atom_context->vbios_pn));
> +                     vbios_info.version =3D atom_context->version;
> +                     memcpy(vbios_info.vbios_ver_str, atom_context->vbio=
s_ver_str,
> +                                             sizeof(atom_context->vbios_=
ver_str));
> +                     memcpy(vbios_info.date, atom_context->date, =

> +sizeof(atom_context->date));
> +
> +                     return copy_to_user(out, &vbios_info,
> +                                             min((size_t)size, sizeof(vb=
ios_info))) ? -EFAULT : 0;
> +             }
>               default:
>                       DRM_DEBUG_KMS("Invalid request %d\n",
>                                       info->vbios_info.type); diff =

> --git a/drivers/gpu/drm/amd/amdgpu/atom.c =

> b/drivers/gpu/drm/amd/amdgpu/atom.c
> index 3dcb8b32f48b..6fa2229b7229 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -31,6 +31,7 @@
>
>   #define ATOM_DEBUG
>
> +#include "atomfirmware.h"
>   #include "atom.h"
>   #include "atom-names.h"
>   #include "atom-bits.h"
> @@ -1299,12 +1300,168 @@ static void atom_index_iio(struct atom_context *=
ctx, int base)
>       }
>   }
>
> +static void atom_get_vbios_name(struct atom_context *ctx) {
> +     unsigned char *p_rom;
> +     unsigned char str_num;
> +     unsigned short off_to_vbios_str;
> +     unsigned char *c_ptr;
> +     int name_size;
> +     int i;
> +
> +     const char *na =3D "--N/A--";
> +     char *back;
> +
> +     p_rom =3D ctx->bios;
> +
> +     str_num =3D *(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS);
> +     if (str_num !=3D 0) {
> +             off_to_vbios_str =3D
> +                     *(unsigned short *)(p_rom + =

> + OFFSET_TO_GET_ATOMBIOS_STRING_START);
> +
> +             c_ptr =3D (unsigned char *)(p_rom + off_to_vbios_str);
> +     } else {
> +             /* do not know where to find name */
> +             memcpy(ctx->name, na, 7);
> +             ctx->name[7] =3D 0;
> +             return;
> +     }
> +
> +     /*
> +      * skip the atombios strings, usually 4
> +      * 1st is P/N, 2nd is ASIC, 3rd is PCI type, 4th is Memory type
> +      */
> +     for (i =3D 0; i < str_num; i++) {
> +             while (*c_ptr !=3D 0)
> +                     c_ptr++;
> +             c_ptr++;
> +     }
> +
> +     /* skip the following 2 chars: 0x0D 0x0A */
> +     c_ptr +=3D 2;
> +
> +     name_size =3D strnlen(c_ptr, STRLEN_LONG - 1);
> +     memcpy(ctx->name, c_ptr, name_size);
> +     back =3D ctx->name + name_size;
> +     while ((*--back) =3D=3D ' ')
> +             ;
> +     *(back + 1) =3D '\0';
> +}
> +
> +static void atom_get_vbios_date(struct atom_context *ctx) {
> +     unsigned char *p_rom;
> +     unsigned char *date_in_rom;
> +
> +     p_rom =3D ctx->bios;
> +
> +     date_in_rom =3D p_rom + OFFSET_TO_VBIOS_DATE;
> +
> +     ctx->date[0] =3D '2';
> +     ctx->date[1] =3D '0';
> +     ctx->date[2] =3D date_in_rom[6];
> +     ctx->date[3] =3D date_in_rom[7];
> +     ctx->date[4] =3D '/';
> +     ctx->date[5] =3D date_in_rom[0];
> +     ctx->date[6] =3D date_in_rom[1];
> +     ctx->date[7] =3D '/';
> +     ctx->date[8] =3D date_in_rom[3];
> +     ctx->date[9] =3D date_in_rom[4];
> +     ctx->date[10] =3D ' ';
> +     ctx->date[11] =3D date_in_rom[9];
> +     ctx->date[12] =3D date_in_rom[10];
> +     ctx->date[13] =3D date_in_rom[11];
> +     ctx->date[14] =3D date_in_rom[12];
> +     ctx->date[15] =3D date_in_rom[13];
> +     ctx->date[16] =3D '\0';
> +}
> +
> +static unsigned char *atom_find_str_in_rom(struct atom_context *ctx, cha=
r *str, int start,
> +                                        int end, int maxlen) {
> +     unsigned long str_off;
> +     unsigned char *p_rom;
> +     unsigned short str_len;
> +
> +     str_off =3D 0;
> +     str_len =3D strnlen(str, maxlen);
> +     p_rom =3D ctx->bios;
> +
> +     for (; start <=3D end; ++start) {
> +             for (str_off =3D 0; str_off < str_len; ++str_off) {
> +                     if (str[str_off] !=3D *(p_rom + start + str_off))
> +                             break;
> +             }
> +
> +             if (str_off =3D=3D str_len || str[str_off] =3D=3D 0)
> +                     return p_rom + start;
> +     }
> +     return NULL;
> +}
> +
> +static void atom_get_vbios_pn(struct atom_context *ctx) {
> +     unsigned char *p_rom;
> +     unsigned short off_to_vbios_str;
> +     unsigned char *vbios_str;
> +     int count;
> +
> +     off_to_vbios_str =3D 0;
> +     p_rom =3D ctx->bios;
> +
> +     if (*(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS) !=3D 0) {
> +             off_to_vbios_str =3D
> +                     *(unsigned short *)(p_rom + =

> + OFFSET_TO_GET_ATOMBIOS_STRING_START);
> +
> +             vbios_str =3D (unsigned char *)(p_rom + off_to_vbios_str);
> +     } else {
> +             vbios_str =3D p_rom + OFFSET_TO_VBIOS_PART_NUMBER;
> +     }
> +
> +     if (*vbios_str =3D=3D 0) {
> +             vbios_str =3D atom_find_str_in_rom(ctx, BIOS_ATOM_PREFIX, 3=
, 1024, 64);
> +             if (vbios_str =3D=3D NULL)
> +                     vbios_str +=3D sizeof(BIOS_ATOM_PREFIX) - 1;
> +     }
> +     if (vbios_str !=3D NULL && *vbios_str =3D=3D 0)
> +             vbios_str++;
> +
> +     if (vbios_str !=3D NULL) {
> +             count =3D 0;
> +             while ((count < BIOS_STRING_LENGTH) && vbios_str[count] >=
=3D ' ' &&
> +                    vbios_str[count] <=3D 'z') {
> +                     ctx->vbios_pn[count] =3D vbios_str[count];
> +                     count++;
> +             }
> +
> +             ctx->vbios_pn[count] =3D 0;
> +     }
> +}
> +
> +static void atom_get_vbios_version(struct atom_context *ctx) {
> +     unsigned char *vbios_ver;
> +
> +     /* find anchor ATOMBIOSBK-AMD */
> +     vbios_ver =3D atom_find_str_in_rom(ctx, BIOS_VERSION_PREFIX, 3, 102=
4, 64);
> +     if (vbios_ver !=3D NULL) {
> +             /* skip ATOMBIOSBK-AMD VER */
> +             vbios_ver +=3D 18;
> +             memcpy(ctx->vbios_ver_str, vbios_ver, STRLEN_NORMAL);
> +     } else {
> +             ctx->vbios_ver_str[0] =3D '\0';
> +     }
> +}
> +
>   struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bi=
os)  {
>       int base;
>       struct atom_context *ctx =3D
>           kzalloc(sizeof(struct atom_context), GFP_KERNEL);
>       char *str;
> +     struct _ATOM_ROM_HEADER *atom_rom_header;
> +     struct _ATOM_MASTER_DATA_TABLE *master_table;
> +     struct _ATOM_FIRMWARE_INFO *atom_fw_info;
>       u16 idx;
>
>       if (!ctx)
> @@ -1353,6 +1510,21 @@ struct atom_context *amdgpu_atom_parse(struct card=
_info *card, void *bios)
>               strlcpy(ctx->vbios_version, str, sizeof(ctx->vbios_version)=
);
>       }
>
> +     atom_rom_header =3D (struct _ATOM_ROM_HEADER *)CSTR(base);
> +     if (atom_rom_header->usMasterDataTableOffset !=3D 0) {
> +             master_table =3D (struct _ATOM_MASTER_DATA_TABLE *)
> +                             CSTR(atom_rom_header->usMasterDataTableOffs=
et);
> +             if (master_table->ListOfDataTables.FirmwareInfo !=3D 0) {
> +                     atom_fw_info =3D (struct _ATOM_FIRMWARE_INFO *)
> +                                     CSTR(master_table->ListOfDataTables=
.FirmwareInfo);
> +                     ctx->version =3D atom_fw_info->ulFirmwareRevision;
> +             }
> +     }
> +
> +     atom_get_vbios_name(ctx);
> +     atom_get_vbios_pn(ctx);
> +     atom_get_vbios_date(ctx);
> +     atom_get_vbios_version(ctx);
>
>       return ctx;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h =

> b/drivers/gpu/drm/amd/amdgpu/atom.h
> index d279759cab47..0c1839824520 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.h
> @@ -112,6 +112,10 @@ struct drm_device;
>   #define ATOM_IO_SYSIO               2
>   #define ATOM_IO_IIO         0x80
>
> +#define STRLEN_NORMAL                32
> +#define STRLEN_LONG          64
> +#define STRLEN_VERYLONG              254
> +
>   struct card_info {
>       struct drm_device *dev;
>       void (* reg_write)(struct card_info *, uint32_t, uint32_t);   /*  f=
illed by driver */
> @@ -140,6 +144,12 @@ struct atom_context {
>       uint32_t *scratch;
>       int scratch_size_bytes;
>       char vbios_version[20];
> +
> +     uint8_t name[STRLEN_LONG];
> +     uint8_t vbios_pn[STRLEN_LONG];
> +     uint32_t version;
> +     uint8_t vbios_ver_str[STRLEN_NORMAL];
> +     uint8_t date[STRLEN_NORMAL];
>   };
>
>   extern int amdgpu_atom_debug;
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h =

> b/drivers/gpu/drm/amd/include/atomfirmware.h
> index 275468e4be60..28deecc2f990 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -197,6 +197,9 @@ enum atom_dp_vs_preemph_def{
>     DP_VS_LEVEL0_PREEMPH_LEVEL3 =3D 0x18,
>   };
>
> +#define BIOS_ATOM_PREFIX   "ATOMBIOS"
> +#define BIOS_VERSION_PREFIX  "ATOMBIOSBK-AMD"
> +#define BIOS_STRING_LENGTH 43
>
>   /*
>   enum atom_string_def{
> @@ -215,6 +218,8 @@ enum atombios_image_offset{
>     MAXSIZE_OF_ATOMBIOS_ASIC_BUS_MEM_TYPE      =3D 20,  /*including the t=
erminator 0x0!*/
>     OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS   =3D 0x2f,
>     OFFSET_TO_GET_ATOMBIOS_STRING_START        =3D 0x6e,
> +  OFFSET_TO_VBIOS_PART_NUMBER                =3D 0x80,
> +  OFFSET_TO_VBIOS_DATE                       =3D 0x50,
>   };
>
>   =

> /*********************************************************************
> ******* diff --git a/include/uapi/drm/amdgpu_drm.h =

> b/include/uapi/drm/amdgpu_drm.h index 9169df7fadee..155fd9918b4d =

> 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -756,6 +756,8 @@ struct drm_amdgpu_cs_chunk_data {
>       #define AMDGPU_INFO_VBIOS_SIZE          0x1
>       /* Subquery id: Query vbios image */
>       #define AMDGPU_INFO_VBIOS_IMAGE         0x2
> +     /* Subquery id: Query vbios info */
> +     #define AMDGPU_INFO_VBIOS_INFO          0x3
>   /* Query UVD handles */
>   #define AMDGPU_INFO_NUM_HANDLES                     0x1C
>   /* Query sensor related information */ @@ -949,6 +951,14 @@ struct =

> drm_amdgpu_info_firmware {
>       __u32 feature;
>   };
>
> +struct drm_amdgpu_info_vbios {
> +     __u8 name[64];
> +     __u8 vbios_pn[64];
> +     __u32 version;
> +     __u8 vbios_ver_str[32];
> +     __u8 date[32];
> +};
> +
>   #define AMDGPU_VRAM_TYPE_UNKNOWN 0
>   #define AMDGPU_VRAM_TYPE_GDDR1 1
>   #define AMDGPU_VRAM_TYPE_DDR2  2
> --
> 2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Ctom.stde=
nis%40amd.com%7C332524597a5e42ad491908d919ff414f%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637569406377960645%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DZF=
BUbqu1VjvQkpnQ4Wy6Q4XE9CB2IcFltOq3Iv12F7U%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
