Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622DAC43334
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jul 2022 18:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 918B3112A9E;
	Tue,  5 Jul 2022 18:43:05 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B767112A9D
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jul 2022 18:43:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaQKHqNXnmuZqmyIVGUY5IQRg7wP4ayJvwJCqiqAzMWuyLJCsmljTK995kx4A86iyeH18FPpG5yTtC88vqSuSQqbiaGvLOhswxCj1ZZao7fibZ/460satND3GMiN5SUVHbeTLxeAGFkPLj/cTLrknJ1CCpCyqVfNwWlJ+vrFPNno+Q9nda3KeEBLVsjMqe3TwBdPMcD/UIdf1XL56VME+cS4b603TeZ/89fdVVTsM4smzk70CHVkV1uWpu8k7iziiNi+3irJFI4dlAwfXoqVaFuWIF5eFWcGcUAnKAfmAk94JjhEOJKMTqt3wuVlwxYERxnsEK3sX2XuMZT4z50wJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piR1Pt/PvhTzDT6fX6TetErZAuEEQCQlutjUfoeTFHs=;
 b=JDAP+LBzXHBb1t0O7b7cGDw4jM4Y3deai++aqrO9QT74wDRsb7zuqek0hGjt2J5gl8DpYpx/Opm+5t1gsCtJz+YoxFHvS31pzlgaaNfphqUFXAUqxGJrJq07TZohNbtjfEZLpQUTN61l/EvwsLIdfYBdGKW47T5hcdX6ZBq+TtCiwYdSsP/JMPelo75bTUlDony7gvU56mg3OtsCpWL21GiT6Sycpfxf2QOhV0R+bmqQvM+IKQ1v0peAsmlmwWPC7hpJCGvSylrzKxoqa3I9WzCvSLWbBlAMgI1W+kJ99eUaBUha5lJA6ySkl0gJYu4KpmJa3pcHNn/4uw9Ek2Dy8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piR1Pt/PvhTzDT6fX6TetErZAuEEQCQlutjUfoeTFHs=;
 b=vDWb7fhXJRuY9GYfycMGSIQ+3Cd6TnGj229ugEi9UZ0uih2Gs7IDHv27eIgrz+OT4Bve+X6ZKftWsk4eFoBGZBQTIL8qE09TNtIQGRkA0vXMpSl5k1x+80XFl67CXP3hWBegAKEQuCraiRAIBT/+8jTWEkx98yvdNzrGue4DpFY=
Received: from SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 18:43:02 +0000
Received: from SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::9c23:c629:349e:3716]) by SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::9c23:c629:349e:3716%6]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 18:43:02 +0000
From: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To: =?iso-8859-1?Q?Ma=EDra_Canal?= <mairacanal@riseup.net>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
Subject: RE: [PATCH] drm/amdkfd: Fix warnings from static analyzer Smatch
Thread-Topic: [PATCH] drm/amdkfd: Fix warnings from static analyzer Smatch
Thread-Index: AQHYi9pLBicOyKjvuUm+VC9RdMuVH61nBxKAgAkc/fA=
Date: Tue, 5 Jul 2022 18:43:02 +0000
Message-ID: <SN1PR12MB25751134F0CE41B60779DE26E3819@SN1PR12MB2575.namprd12.prod.outlook.com>
References: <20220629170419.364255-1-Ramesh.Errabolu@amd.com>
 <cff8f7f0-bcda-b804-0737-411c71ec9b77@riseup.net>
In-Reply-To: <cff8f7f0-bcda-b804-0737-411c71ec9b77@riseup.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-05T18:34:38Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=66f08583-419d-4b0e-86bc-ea025a5f5111;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-05T18:43:00Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: a4d31456-0dbf-4330-8330-622d37a9fffb
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 438f3a55-d0e7-440a-4c31-08da5eb63128
x-ms-traffictypediagnostic: SA0PR12MB4446:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TUMrBD2ZDuYNoHkGDEpeNc8BhANXoTnjsrdgfkO0hk7DF7bP5ZE9Hv04QDeZRBmlsgE5pAEdKEFCYbnHqOjTpv4b8GQdKDNDwZbAbGvGQmAVI2n/3O2st0WEviATYal2W9Yf6xDjun/y5/UWB2sL72fc9hJZEgNZRJURiH8Wu0hD2iqXfDAY6Vbx5h2bmoqRJgZpUvIRzo/uB+Zisgu6tqakUGcr5t0AS2rwHCR18jEE92vZ9REVIqTWC4wcQDlUHr4Jmh4+ZVya8jmz3ET1aSzrXxqVVZqC39/QJqnciHGzyO4LZEDseFY+NjW6wsSlLAT04vmezeF8ZayhlE8joEhVY/2bOXNVf8L4ACcij5608RztrCI3JLI1a1CSWE2EClzNZiI4Vsujg7YT7qHPhXKPKGnzfrlspl60ygG0WLC1KQuohixwBc6oM53qCjxbC/aIRBft9UYRRXBUNfmzCRibKlSihCK2sW8tnin7DcgDvUevrMydVQl9PuEEApe1yN35Tp1mQmEgSKrmKASqqSboTE6wgHbV6BCT9D01PVXAYuRlJMtb778SXwXOTNGJwGB0UjGQBMUVelVWd1emvBAa/wgI+LtVFJ6kWbadpZfzTZRcPAKn0ZJyeXqJt4ztdxS+UojnOu0nUK5neXDlKW7Z/wzlZpupzv/7Y93Zo2sHaQaFmDbTjB1ZzEykZa303QODhkHEE1zbs+ghOtIsrjbvKbuPJNhDj8WE9BJQgDNRQZvBQoo+5LdQ8DnEsGVdJX9693XPD8vd5T0ynXqkn5TiYTvjIT/IaoCgdlbjfBJrJ6ZT2wkWh5LaleMIDMBES9u7qSbjb6jirq5mvZYzXxVaftgYuS3mPL6ZFlsPIVc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2575.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(83380400001)(186003)(66574015)(71200400001)(33656002)(76116006)(66946007)(66556008)(66476007)(64756008)(8676002)(66446008)(478600001)(52536014)(86362001)(966005)(8936002)(5660300002)(26005)(38070700005)(122000001)(9686003)(38100700002)(41300700001)(55016003)(53546011)(2906002)(7696005)(6506007)(110136005)(316002)(45080400002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hdPl38t+HifqcytcFZrGYO450d+L2Vassq6aqBbg79f5LNkjzpP6anvksl?=
 =?iso-8859-1?Q?4CvCr0RgTz5crMx+HwKfN2oPUFAKzgV+fSstWt2YO91G+UgOlP+wf2h9di?=
 =?iso-8859-1?Q?B7z8QfBhd9ViyNitErUJ42ajTl55MgqlMspmGDrYuvppQ2dOhCmhmB0jae?=
 =?iso-8859-1?Q?WohN7LRq2o49bSDsi1etf+c2S1mdOU/r6qN3/obV4BYSBdS2KjY3pCeDRS?=
 =?iso-8859-1?Q?mNBC7LfVQ5GFat9rnOEl0kMsI/i2WO/5imYOmKmckQ6xvxbWZEHOmSYy8e?=
 =?iso-8859-1?Q?9EYXX1vqzmV4NxlTBbsUVqMlDBjjT4nb3/QRVgpERhnt9U/OH+R0zBWIsg?=
 =?iso-8859-1?Q?rHKUSykIkQWQdZTC6Mc1UoG05lTRTOe3S/0N5VOUJfV/nuY/+0cJMwNfHU?=
 =?iso-8859-1?Q?M9pc2MShr0n9fKvdwRii/1Qy8F+AQyHRiQYMC4VqpLKQRyKbmr8omUy4lR?=
 =?iso-8859-1?Q?v+0Hca4vMAC+agKR7vbYfVCz8OGDKflM5xMly8nPjlG1iU1neLaDsDnuvW?=
 =?iso-8859-1?Q?Y5iIipI3PhSCHWHfCQOIs66Wfndmlr/z8famvydHzsMw2hdUQGsLXjgU9H?=
 =?iso-8859-1?Q?9zxEYt7pkfr4wbcNl6V5mwVKUMBBVptQt1XcCV216F1jho8FID+GwZhiF7?=
 =?iso-8859-1?Q?XNIm8hln2zIxcIeGW2n3EsUb4nSwTj+ib1fKeKNsBtcuo9jOQ/vtsxps1Q?=
 =?iso-8859-1?Q?utWVenw1c8EzB7YoolRV4O8Hao05M+I5bhhXX4ET+jYji7n9dAZD4j0HM1?=
 =?iso-8859-1?Q?IbyHNCZU2JA30s8VH+WA8OQfrSbnyTROkOOpFoGs9rsQhFFLE030Gieaf8?=
 =?iso-8859-1?Q?R7Or5c9eOKfKsiLqQPLMwGvImV9CJWRqPNMAQgh880+bS/X6rd0qXJ+EhY?=
 =?iso-8859-1?Q?VSO/IxTlWxvlKE3o5YKbTy87VYta4bopMZ43OWWrAqyHblDwWrCKD+sB0L?=
 =?iso-8859-1?Q?QUVgQM08fX2qeLfXfPxJDTFyLvVPeA49YIXGElCzPP5Plv8wHy9ZopS9/y?=
 =?iso-8859-1?Q?QiAydruMk9QEBpIfXtxQgNf2M9vWTM4tbIgY4iCdAyWWDJAOOO2f8RaEdv?=
 =?iso-8859-1?Q?kwTPAunIfGxQbSP+6Ml66F3XPfZtNudF63G9nLWZArsrcW6+9p+avf4Ij2?=
 =?iso-8859-1?Q?WcyoIdEGeS68lqwxCOKKLeIoN7Od1rv9HXFtlrrnKLRiXQ1sRoHGQOPj8H?=
 =?iso-8859-1?Q?ta9GGWffapWEH5oYoRS5I34E7V61LV7lgUD72nzRUiqF0WH+eazRs0bbJ1?=
 =?iso-8859-1?Q?E2IdUBbHGguo5OiniUGiS2tIYsLJT9FdeinNtY44Kh8ZW7NT/TNBMfNzJT?=
 =?iso-8859-1?Q?Sj18AjpGeWcaHFrA04TDT9sZbhdqoZIR3AFw/0UNZA6I/AoDD8LXlkCz7J?=
 =?iso-8859-1?Q?W69G3Tu22jZsURANscN/qw5vpT9zAaWc2jxZumbimF7tJgS/SnSqoG86A3?=
 =?iso-8859-1?Q?dPk0fTKBHeBNdUOt2VRfUM7JGRTEsMP5mBDP8Uk/MfkUyy8I6/sYbFr5z8?=
 =?iso-8859-1?Q?0h7rRYnDaGUi42UlYKx2RY6MPSO9gGs64VkYkZaZvX+9d2/VHE3SC2fH15?=
 =?iso-8859-1?Q?WJ6YTk2aWQGzh4cY2o1eVzmbMh5mujSc5G9qxgjg5yAC284WMSArcl03cp?=
 =?iso-8859-1?Q?sbi+mwHe7vuvU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2575.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 438f3a55-d0e7-440a-4c31-08da5eb63128
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 18:43:02.7504 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZL86bgMM+FSKb9nvc7wn65hURFy2L6RAnOFSo+bQg4SZIbxcKeefX6ml3kFprMg7DJ4geadf1ZerzY1SXjQ87w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
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

Maira,

Thanks for taking time to review. I understand the request to tag the patch=
 as version 2. However I don't follow your comments on "Fixes" block. Looki=
ng at the git log of the branch I see many "Fixes" block that precede the "=
Signed-off-by" statement.

Could you provide an example.

Regards,
Ramesh

-----Original Message-----
From: Ma=EDra Canal <mairacanal@riseup.net>=20
Sent: Wednesday, June 29, 2022 6:25 PM
To: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>; amd-gfx@lists.freedesktop.o=
rg; dan.carpenter@oracle.com
Subject: Re: [PATCH] drm/amdkfd: Fix warnings from static analyzer Smatch

[CAUTION: External Email]

Hi Ramesh,

On 6/29/22 14:04, Ramesh Errabolu wrote:
> The patch fixes couple of warnings, as reported by Smatch a static=20
> analyzer.
>
> Fixes: 40d6aa758b13 ("drm/amdkfd: Extend KFD device topology to=20
> surface peer-to-peer links")>
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1428 kfd_create_indir=
ect_link_prop() warn: iterator used outside loop: 'cpu_link'
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1462=20
> kfd_create_indirect_link_prop() error: we previously assumed 'cpu_dev'=20
> could be null (see line 1420)
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1516 kfd_add_peer_pro=
p() warn: iterator used outside loop: 'iolink3'
>

Usually, the Fixes tag would go here, after the commit message.

> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---

As this is a v2 PATCH, it would be nice to have a small changelog here, des=
cribing what has changed between the v1 and v2 versions of the patch.
Also, you can mark the patch as v2 with git send-email by adding the flag -=
v2. More on the canonical patch format can be seen in [1].

[1]
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdocs.ke=
rnel.org%2Fprocess%2Fsubmitting-patches.html%23the-canonical-patch-format&a=
mp;data=3D05%7C01%7CRamesh.Errabolu%40amd.com%7Cc54753a9471843cc9d1f08da5a2=
6898d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637921418813227961%7CUnk=
nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX=
VCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DPAc5A8z2EvJAOUiY378K9XyVBCKewQNsSNCr=
9pB3Ias%3D&amp;reserved=3D0

Best Regards,
- Ma=EDra Canal

>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 34=20
> +++++++++++------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c=20
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 25990bec600d..ca4825e555b7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1417,15 +1417,15 @@ static int=20
> kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
>
>               /* find CPU <-->  CPU links */
>               cpu_dev =3D kfd_topology_device_by_proximity_domain(i);
> -             if (cpu_dev) {
> -                     list_for_each_entry(cpu_link,
> -                                     &cpu_dev->io_link_props, list) {
> -                             if (cpu_link->node_to =3D=3D gpu_link->node=
_to)
> -                                     break;
> -                     }
> -             }
> +             if (!cpu_dev)
> +                     continue;
> +
> +             list_for_each_entry(cpu_link, &cpu_dev->io_link_props, list=
)
> +                     if (cpu_link->node_to =3D=3D gpu_link->node_to)
> +                             break;
>
> -             if (cpu_link->node_to !=3D gpu_link->node_to)
> +             /* Ensures we didn't exit from list search with no hits */
> +             if (list_entry_is_head(cpu_link,=20
> + &cpu_dev->io_link_props, list))
>                       return -ENOMEM;
>
>               /* CPU <--> CPU <--> GPU, GPU node*/ @@ -1510,16=20
> +1510,16 @@ static int kfd_add_peer_prop(struct kfd_topology_device *kdev=
,
>               cpu_dev =3D kfd_topology_device_by_proximity_domain(iolink1=
->node_to);
>               if (cpu_dev) {
>                       list_for_each_entry(iolink3, &cpu_dev->io_link_prop=
s, list)
> -                             if (iolink3->node_to =3D=3D iolink2->node_t=
o)
> +                             if (iolink3->node_to =3D=3D iolink2->node_t=
o) {
> +                                     props->weight +=3D iolink3->weight;
> +                                     props->min_latency +=3D iolink3->mi=
n_latency;
> +                                     props->max_latency +=3D iolink3->ma=
x_latency;
> +                                     props->min_bandwidth =3D min(props-=
>min_bandwidth,
> +                                                                     iol=
ink3->min_bandwidth);
> +                                     props->max_bandwidth =3D min(props-=
>max_bandwidth,
> +                                                                    =20
> + iolink3->max_bandwidth);
>                                       break;
> -
> -                     props->weight +=3D iolink3->weight;
> -                     props->min_latency +=3D iolink3->min_latency;
> -                     props->max_latency +=3D iolink3->max_latency;
> -                     props->min_bandwidth =3D min(props->min_bandwidth,
> -                                                     iolink3->min_bandwi=
dth);
> -                     props->max_bandwidth =3D min(props->max_bandwidth,
> -                                                     iolink3->max_bandwi=
dth);
> +                             }
>               } else {
>                       WARN(1, "CPU node not found");
>               }
