Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE05C30653
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jul 2024 03:40:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12EBE10E178;
	Thu,  4 Jul 2024 03:40:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IaUj/Een";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98A3010E178
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jul 2024 03:40:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmtT/GUwCAXxLBiL09hbe/2Ckjk6ZOhLEaMnV9mpItEsxU+kOiFUpQovwRVp4AazngnefSeShXJ5AnbeJKcyYhMyWdB+BrLD+qoqCA/Ay/HD2BVb7mjFR8GGGdksmmBpIt+rcmkjWzgQ/jfNkO5vObyULYVMnqohXDAJG1ZVOV7W4dJ+JaUMDamROpxXGDeFSGgGfh1Dr4OpH1F4BApipWEySxRa323sNMecIKV89Xg9ANC80/W9jKo87QSzEqSKsLcyJdo0Td7Q68/ISjyG7DjMMpRUywnBGUG6kp+VRFdgiYkn5VMeOOJGfX3X3ZPl2Fyu48+ZTmqPxbPtOC791A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0pwZNsuZjojvFO3RWoA1LtgKT9dqQRhm+me1wf6KWc=;
 b=EJC/LO/rTBzwDcbTU2gy+m2L3GKIlxIntkfzCr1Owapb/8O4bsiVJqaSJD2iF7+uFb/a11S7kvOWhj1Hnw2wrg2Cq9iPDsxXhAd6XCToAulb6hZifPDsfNo2UrxcWyd9IYp7eL18e1XrmH3nWYIYq86DKqkfUjwpWIEXsO+BiTiWKYyX9lYVhK8h7ieKLydUyFVVOxMDFprNfrHw8YKfU1sWD4k3viAMBXasNNg/9314ADVj2lZ1/sLHgBrh8ik0b48ARP84yZDeh+lbYX2p0r9IHEvdXe4trcF+IxOY8rdf67GAchzAn2sGCjzMqZNlrJqdgGoslSvBus3USqT2Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0pwZNsuZjojvFO3RWoA1LtgKT9dqQRhm+me1wf6KWc=;
 b=IaUj/EennQ4F4fWERmsnTAjnLCJ4GdbKZiOVDqaiZdnfCevk+IKgwOYjff9IjjaUz5smAHIuOR9VrX6Mf1A80o0k5dfRgzqtSUziPLisXHeDdUsRTEsQRA/OmaOdA08kLlx8seKLSenZVj1qzU7PPkc/RldUZ5ToB6+sVLBtaJA=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DM4PR12MB7741.namprd12.prod.outlook.com (2603:10b6:8:103::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 03:40:00 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 03:40:00 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: timely save bad pages to eeprom after gpu
 ras reset is complete
Thread-Topic: [PATCH 2/2] drm/amdgpu: timely save bad pages to eeprom after
 gpu ras reset is complete
Thread-Index: AQHazST0kG4bz8Zcd0a0fE5NBQX8qbHl7CPA
Date: Thu, 4 Jul 2024 03:40:00 +0000
Message-ID: <PH7PR12MB8796A71B78569E3D10D68ACDB0DE2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240703084127.478058-1-YiPeng.Chai@amd.com>
 <20240703084127.478058-2-YiPeng.Chai@amd.com>
In-Reply-To: <20240703084127.478058-2-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=9ed1d75c-486d-4d3b-87ee-ad91d615dda1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-04T03:35:27Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DM4PR12MB7741:EE_
x-ms-office365-filtering-correlation-id: 4aeb21cf-e628-4bff-3ad3-08dc9bdafbb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?7Rv+fNFLpO0VUzgeOhCYOmlhjey/5aLzCaNyDwhJ6+eBXNDh+2zkF0ZLUmxP?=
 =?us-ascii?Q?qcLgitZytBnhKS+4BC3Jw5OnKQxYd40I9KDk5OurgkmChMCKaUod7G+gH8AR?=
 =?us-ascii?Q?eywYHQURTcQ558UmW8BSpqh5LegMN2KVYuz9aB+vNjcIeLk6f18n/LJk3krg?=
 =?us-ascii?Q?NM2JSvja8WemgjNt0u+pApVRsvzfQtMB6G0Y2G5DP8RsN3u2Z5PyJael6D8j?=
 =?us-ascii?Q?NCZj+w5ustdq89YwYxH0NGi4G0SANxDTrztTysgtkgzkzQD6vpXINFV5gdzx?=
 =?us-ascii?Q?BwMmJQwf4SU9FgxkiePqSEOHrBbtiEBhjHH2UprO98qT/CJSxM6FraM1CwOi?=
 =?us-ascii?Q?fEOR2Z91jtnQGPVPYvxJtVRntB041jzIv/cE+EK5sms1qfm0h1ESmgHS2ghb?=
 =?us-ascii?Q?LIZDV3WlnAEEQgVGfUnQ4rP57Ler3XFIHAnMCN3OHRWYWwBlxyPNUwIWVJyp?=
 =?us-ascii?Q?n33ORzdyreBwQEvYlcKWxQTxGl2Ou2vvsKIJHOc8r2bbnowq/MGz19M+2NKP?=
 =?us-ascii?Q?q85ya1XJ4bgzhmcTyPVOp4Wyi0jPmgeNEcvC2XZVJoSmzUReAK45UbCwr2Oj?=
 =?us-ascii?Q?plXhsodoSzSjbiGrkZZxixjizqcbhq2+5aZXUeJhUcJUlBNXzc5yqSg0NZBk?=
 =?us-ascii?Q?q4Mqa8Qp7HiPOpjLE4Ybv3rReMI8+nJg2I5ytxPsCkgYbBpVxlYils+7umps?=
 =?us-ascii?Q?x2qVQfe/2G+bEHqJBHyiNNkLox3gQxIxEzbGuDzw7vGzWRavSmLW2Av0Nhyo?=
 =?us-ascii?Q?OdSafB7DtvW3AcNnU2Mrf8DggZ+FygNV59PCn04z7H2+7TalA0ztAkABQkvE?=
 =?us-ascii?Q?n5SNKnH1RHpBjPj4bq2jjJFY/2nw3BnX0B5XsX2vBzLXONKj5nYqZ3lGn/9p?=
 =?us-ascii?Q?sH5XH2XeL+oTCqxiRanSWBlfatdHBhuKu9Q9CT6VaO0gexT/3uKNlM12xlYw?=
 =?us-ascii?Q?xatM/T45rs3j3hJPTP9KbSW3wbgf17q2A/+0d6vFqc/Yk42YisDpeNHbseV2?=
 =?us-ascii?Q?fFMXqG48JzPxF3FwcqkOKQ/wZt3/dODvMKbdQnbpSblic88durXQRRzNe9qW?=
 =?us-ascii?Q?/jMMILhwV0bzuLIRmhl+1fhZJ+VGSQHKcWH9Yi+Fkra8TNdzDjcsCGyIUbA+?=
 =?us-ascii?Q?PF6XyNjadPemoyfFkSjZ8Ff/rLFtVkfBzDlrufp04pedLXCzwfBm/5mlh2Xu?=
 =?us-ascii?Q?0np3GXaTZ9WeXZFt0K7Es1aVclr/9lcFntoOda1tPFEPknGtk5GossUWRu4A?=
 =?us-ascii?Q?YwUSA5fB8i2lc/2vSILo00yxGmwcO2QpEtSq2SemXVKmDBhDjBf0qD/9DhpO?=
 =?us-ascii?Q?0P/I43tW/vW0j6G2/Qun03/MdaLvrUMiN3tTSGuG+gF1wrIKryvGiA3LKg1q?=
 =?us-ascii?Q?e+MjRs6V8joBDeXLFQoZLYammjy6zXl4xOZaydrKwj3KLfH2Ag=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rHnhPGx8kTo1HODtPvCSpesWQ/Ybc5G/hqH1l8VXNbCwy/2gwLMjllHBDQR7?=
 =?us-ascii?Q?MYo+iwweZiGhllggDY+UA+VWbLRSxxLxzwwGT9PlDQ2lR0Nn4pbr+u1K5sUM?=
 =?us-ascii?Q?JPeswoiXjYAZWd+FEVz5nnstUB8nkyAfhrXB5D82lVzbWwVSsopyPv4lemDA?=
 =?us-ascii?Q?ukA0PTfn6eGRuLFDdf/GI05VD6J3AdiHTVkw8diimnlqzjK9zPh9HeN0QdBx?=
 =?us-ascii?Q?eYqxopIujiETIWXhYVhGMKW7msMSt8XKWMfCcMIVsW8yfYyGWrG/2Uv2n5lu?=
 =?us-ascii?Q?HsfGqBjCPRnMcop77XrxfQ4p4A4hFlMnHcPnvhHcNCx2FzW/NNz2ZuDN5w+B?=
 =?us-ascii?Q?a4riyeJrk+Pcrc1wd6n1CLHGCLdDxUm7pZTQzbgbmx1QBdg+DP+7sszdZ/v+?=
 =?us-ascii?Q?n9G3dEC1fY/98RVRo3jeE7rMNsy8iDcjSjLanTK/RmoXt8KNIhMC85qkMHck?=
 =?us-ascii?Q?BmNaM0wvM9ho4fqTIjUwucIiGf+HEYUDn8adf6B5lr1/03hOOZvofXThx6mN?=
 =?us-ascii?Q?VpJPG1Ucl9n9KLdk0I6K5bIguWlqBafausnYQVYe7ozMNd1bfQbI1amTFAFK?=
 =?us-ascii?Q?kRIAgoPc4VlqElBR6+Tl8UYU9+2wwYyOY3HvK3T2nPXC9VMMgXIl7P8nuGbp?=
 =?us-ascii?Q?65tX52XxRlORAmfxILA37OLamDz56ensi12znXEfn0RtfbgcJpI9RoO5sGuX?=
 =?us-ascii?Q?i5Tq+Oq1mJnUwur31avR4hxIxapyci6cWIIfF3L4KBaxupcaCAMSpvNN2QTa?=
 =?us-ascii?Q?dXD+EPLVnw3hf4OGVmRyZB3jQsCJHC+I0tsV0S8fphPUYJSFMJ32FtVyAlyq?=
 =?us-ascii?Q?kc+0izVgtwPgWJe7T1x71WiIY6a2LfWk3ZI1rDXdwSDw6bVRNeUlj2YcaxUl?=
 =?us-ascii?Q?vP5vpK4j9X2xcpamR0FpewRg7djMiiS9cb2AXcsStItfUudoMmzv6gM1O2at?=
 =?us-ascii?Q?7P0Fnxsxe0qrqj7HM8Z2H+uqLpcaEtt93LvlR93m4dQVq8v4RvghGSDt4dPs?=
 =?us-ascii?Q?Ym+39ADtLtLiBJ45EDGPZO1MZsWtd++pkg/YNKnFtYt+uKXyrwpETt4xmuuq?=
 =?us-ascii?Q?fZsyqwxYyLIyfCiLj0Va85dmpcUOaKLZUeaPQmJpQhlElKmLDgdvRMnxMLnj?=
 =?us-ascii?Q?y7O1UUi0icVIIb5RhDIqvqChpVcUe8iCqXY7LgY8z8Dw2wgp+1zjUxDfQxkG?=
 =?us-ascii?Q?zem43CLQmsNER9qnYrazP02j5QnrRiVnSinzcZJ71IGOXKI4bFpOiUtVx08G?=
 =?us-ascii?Q?uUFtrWHSID+9I3ikq7kg1Fwl4aZ7Fd8Z+wG8i8adtFSfC6dXSXhPx18VA/Sj?=
 =?us-ascii?Q?XDKj0b5eiOVO25kxQeZCKeXngTQIREww0Q7HTF+Phj4J4JY4SnwK1yLTF4xH?=
 =?us-ascii?Q?rCVPQlzXqKYpcXgJFBQHCbKBdqaDDDLLyBkSWfm2Q0MCf7pLjlbKe6qq+143?=
 =?us-ascii?Q?xpvHqQNg9r0tvlQkXIDr1AgWoEYJ3MCkJssMaTln3X5B5azSojUJkycV5I7P?=
 =?us-ascii?Q?v9VRJclXssEriQ4AhD89U9usv8Fy5Wr24JyRLKla5V+AI1z5Un1hz4iCybry?=
 =?us-ascii?Q?XTi2BIueHx0Rv3I2RAY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aeb21cf-e628-4bff-3ad3-08dc9bdafbb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 03:40:00.7701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PXwzYmC8F0pknFcrDac+7uj/7auO3i9o6Wnjq07hJgOVM/WAz6ZTAwvfloi84Fc0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7741
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

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, July 3, 2024 4:41 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: timely save bad pages to eeprom after gp=
u ras
> reset is complete
>
> The problem case is as follows:
> 1. GPU A triggers a gpu ras reset, and GPU A drives
>    GPU B to also perform a gpu ras reset.
> 2. After gpu B ras reset started, gpu B queried a DE
>    data. Since the DE data was queried in the ras reset
>    thread instead of the page retirement thread, bad
>    page retirement work would not be triggered. Then
>    even if all gpu resets are completed, the bad pages
>    will be cached in RAM until GPU B's bad page retirement
>    work is triggered again and then saved to eeprom.

[Tao] can we add this description to code comment?

>
> This patch can save the bad pages to eeprom in time after gpu ras reset i=
s
> complete.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 14 +++++++++++++-
> drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  |  6 ++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 1b6f5b26957b..b6e047a354a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2844,8 +2844,20 @@ static void amdgpu_ras_do_page_retirement(struct
> work_struct *work)
>       struct ras_err_data err_data;
>       unsigned long err_cnt;
>
> -     if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev))
> +     if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) {
> +             int ret;
> +
> +             mutex_lock(&con->umc_ecc_log.lock);
> +             ret =3D radix_tree_tagged(&con->umc_ecc_log.de_page_tree,
> +                                     UMC_ECC_NEW_DETECTED_TAG);
> +             mutex_unlock(&con->umc_ecc_log.lock);
> +
> +             /* If gpu reset is not completed, schedule delayed work aga=
in */
> +             if (ret)
> +                     schedule_delayed_work(&con-
> >page_retirement_dwork,
> +
>       msecs_to_jiffies(AMDGPU_RAS_RETIRE_PAGE_INTERVAL * 3));

[Tao] this section of code can be put in a function to make code reusable.

>               return;
> +     }
>
>       amdgpu_ras_error_data_init(&err_data);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> index 0faa21d8a7b4..7bdba5532adb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> @@ -29,6 +29,7 @@
>  #include "mp/mp_13_0_6_sh_mask.h"
>
>  #define MAX_ECC_NUM_PER_RETIREMENT  32
> +#define DELAYED_TIME_FOR_GPU_RESET  1000  //ms
>
>  static inline uint64_t get_umc_v12_0_reg_offset(struct amdgpu_device *ad=
ev,
>                                           uint32_t node_inst,
> @@ -568,6 +569,11 @@ static int umc_v12_0_update_ecc_status(struct
> amdgpu_device *adev,
>
>       con->umc_ecc_log.de_queried_count++;
>
> +     /* Try to retire the bad pages detected after gpu ras reset started=
 */
> +     if (amdgpu_ras_in_recovery(adev))
> +             schedule_delayed_work(&con->page_retirement_dwork,
> +                     msecs_to_jiffies(DELAYED_TIME_FOR_GPU_RESET));
> +
>       return 0;
>  }
>
> --
> 2.34.1

