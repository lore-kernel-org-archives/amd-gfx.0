Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A419C27C6E
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Jun 2024 02:08:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9722A10E155;
	Sat, 15 Jun 2024 02:08:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mAVvBCVk";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F25BF10E155
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Jun 2024 02:08:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDpTEQH7oC8w3/I7xm8uHPDDXm5QjbB5QFWzOSZ6FX1sdZ/ZOstggak3/A3gucU5dY4Iqyt3umoWRQsay7daPwc97/EKV8R74wy7UJe6tO/KrYR2+gQpXZ6LL4485wX/tSWuW6bzSMg2GfH6lEJQkyJ4g69YaHSX6vnkYdvuALraJOQw9CLkEDmksrkhdDR9d656RS3i5pLzwHDt0ym3IbYWQpn+WrYteOYEV6iZXWIk7liFsIqGtooEj6z6z8mmoJEeloLsj050nogcuo47aasdibmWhS6PS7XW7GDPFRuXanxa5uyhXwBav52PNTcAMQqT6SbcLNMjK/528MzZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxPRtzsOuBq2A1fltBHmXCzQ8Z+YfwZb8oHbByk/RD4=;
 b=MfgAhZdSJTH6jsNpybCJ6gch9e4wPT+mJXw7/bZF5z5zPgg0w8vdAUaQssx+Y4a5kL+LtsddEggNCYa4woGn645FaW+QoJ0ObCk43VmxqKgtJIBG7xsbaEnqYDFMaA5w8EY/3916p47jX2/3qu2TQxfZcwVQv6QqUvoPOs3SNj8z4Qoc+xFPTrbJcO9zUFa8zvOTF+GesMrgOSqsoeWfKWUmBYXjifk7VNUru6uJ14aOQ0GVjgw159jZg9JQxpxDH37cVAjpI3u0Ya8Rl3HKp39ln0MVyG0tYae0aVj1BAWgpu5+8l8T9b+kqO3q0knY1tMPYpv7pxo4x7oW0nF2Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxPRtzsOuBq2A1fltBHmXCzQ8Z+YfwZb8oHbByk/RD4=;
 b=mAVvBCVkx2SU3YUS0GGfnHUxa2vuH+kxCidcWmRP4KfAk4Vr+lI+Id7cU3/iGHQSvZNiSM+cpQqNSy1bpg0dPY9c1s766MbnPnf8aCfYEYNtoyB8iKWkX/FacMCRJcJH0YRm8bozivKDHMGJJC+NvPi8jORl+y+9Tvb+v9jEi+I=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB6932.namprd12.prod.outlook.com (2603:10b6:806:260::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Sat, 15 Jun
 2024 02:08:44 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7677.021; Sat, 15 Jun 2024
 02:08:44 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Jian, Jane" <Jane.Jian@amd.com>, "Chang, HaiJun" <HaiJun.Chang@amd.com>, 
 "Zhao, Victor" <Victor.Zhao@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: keep init xcc0 for all xccs under sriov
Thread-Topic: [PATCH] drm/amdgpu: keep init xcc0 for all xccs under sriov
Thread-Index: AQHavkt2NLlChGqX20uecpQQBUsJvrHHJXkAgADvdi4=
Date: Sat, 15 Jun 2024 02:08:43 +0000
Message-ID: <DS0PR12MB780478C3B4C8DBC2E973191497C32@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20240614111022.236072-1-Jane.Jian@amd.com>
 <2bf881e2-9db1-47f8-b8ec-dee5dd7a295e@amd.com>
In-Reply-To: <2bf881e2-9db1-47f8-b8ec-dee5dd7a295e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-15T02:07:24.0915620Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|SN7PR12MB6932:EE_
x-ms-office365-filtering-correlation-id: 416e84a5-1496-4384-eb59-08dc8ce01574
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?4rCo3GJGWZ5s5NLCrbgnP4R8qT2r1fCsA47nE2OqcYVK5tBv6KyAPJoHXhi+?=
 =?us-ascii?Q?N2k2OLK95fWRSiyJqQb19tykKdwGmo43XTxOxsPaTMEhyq7FL/v7McCkvjvI?=
 =?us-ascii?Q?uLn8+pf78UjUoCZvArGpiMQ6y3P+i+WY4dH4i4x+s54xO4pzgoazPVSf28Eb?=
 =?us-ascii?Q?jyVIscRdywpWLTbB1WAwCRxJ4lLafLZTLiVpWO30plFlzHqJcwnEel3/+idF?=
 =?us-ascii?Q?+bGsJJeoCDTm0bjcjdPthYotDyBUWNQfrrnTo/pAD9ztnzifAIRBV16DTeSz?=
 =?us-ascii?Q?IYnWrvY54ecUvqEh4VzhO/ta34WktKlxEvmN6oQWzyHrisKPUlM1kcFKLk3o?=
 =?us-ascii?Q?Vxr9s3oG3K7u7MfDVd52BmXdqW4iZrQolFCFXPY1fItIrMsZCEVKyvbiI3Hz?=
 =?us-ascii?Q?8MucEpB006I0ZtByzqOCvlnPWeSZOskTNRxyEkhl63w/51ZrX4j9cZRtxNwP?=
 =?us-ascii?Q?8nyKvrWvjHjhlM3JyymDxaWaXwojBW90ejHdCj+dN/Coe9LKTFBmX9e0Q0zX?=
 =?us-ascii?Q?VH3au5OOOV2MeJWdAmqHMA5n/7ouGpfI3aPoHwGnCr3PWnslLAzfyavg1LTE?=
 =?us-ascii?Q?04VH7Qf33uhIilQeoZQRwCe4XvaAtc6wBQwa4uRDLwo+iW8bY1Sa7IuMLw0M?=
 =?us-ascii?Q?/iAzQkB3afqKZ9tktJ3+KB9V3/+qADsPICHCGcFVlet9K2rPCXiJAp6Zg594?=
 =?us-ascii?Q?BZjlkojFBFsUv9yiBEOkNlm4s1n8tgfhpfq9mWxJiBudt/poA8q758q4Vmfz?=
 =?us-ascii?Q?7xa5DKnzpChgIK8nvfAz610OuEbKJlsmMcMKZ6b+XF2R5kkgN3k/K9bxcXpi?=
 =?us-ascii?Q?UsrCJONOd4M4wboOqKbZmBeBJ++RikYPptHtsKW10koJC1NrURN6x0EDFb3E?=
 =?us-ascii?Q?vTojVx0eCJiFoVhYUzcrQ22pee4ZYxWcRUiekANlblScV5cfZlkYSPCITHmf?=
 =?us-ascii?Q?Kk3wRRZhsDbO/4TCPHc/GrUqD8t5neHtYk+d3A2O1vAKbNHpuw32hg4fBIu6?=
 =?us-ascii?Q?QOqMkVqgJmO1M1IBEnnWwWKTMQWLrgdR625niOZNTbYwt7e4u82S4qgQE3P+?=
 =?us-ascii?Q?h67m1xWrW6e9s1QA+EGFgZeXA6oNQcw+0Ahz6GvBZVezNy977BgrTm7u+DMO?=
 =?us-ascii?Q?MzwIutREjSYPzk2p3yhp5etJI9tlXC3M4CvBMrTse710S8bxAbxC7PVW+bat?=
 =?us-ascii?Q?N0UmOIeaFzNy8EMBPoFxUCquFQ6/BOJ0IU9G8wKHDlXsCarn0+tqVcs+zr0X?=
 =?us-ascii?Q?auG8BR6EYFvU4qpOSpL4ACeBzD6LINVxWToqLBQvTtjyRkYGlcAmCQmwu62U?=
 =?us-ascii?Q?bZv+L928nqLyYvsxv9sJDAn7qDVPnOqCYHO0I0qx5OS/ynw3BPdeAiTV0B2/?=
 =?us-ascii?Q?BM4HRgo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UKawG0B4fbifqZOT2dKNUjIik5v2a+CHoESBkuQzrUv51nwNoiqE5Spy0YXM?=
 =?us-ascii?Q?sncKHvTQrBe8RHerzjrc7V06EWngPROMpS4sNGvSHxP2CUFdXJfSyXCaUCxX?=
 =?us-ascii?Q?pcSaFN23UPzMEAMxmDlcQJ6PIWSVOa685zYblcHTPDTlyZtFh7dd+cfZVIha?=
 =?us-ascii?Q?fawEg4Du+zuWcM3kCjW8KI+fKuVbZuGwyWqMA4DQ++FjDc91KKRwaS5XXsvD?=
 =?us-ascii?Q?JAUDN/CjrDn5DOIIho8qrjWE7BlFsjvcUh3mYH99BwZIkn0OpctRteaGNSOT?=
 =?us-ascii?Q?vxGgV020N+0GNlqcQ+Prv9MWNvPRpaT9niqAF+c5Pd3IsYowknqyezGUxqXk?=
 =?us-ascii?Q?u9xDtPUO4c43TYwyVh0D7/F3hV+zoqBFyyq7QqXlam6gd6zDEkOpik+tuJ/h?=
 =?us-ascii?Q?XqPD6ObKIyvkhvwMkt70E3fUBqsZrAwAarrdni4LqJs2RIqTwJvzp8jbFsK6?=
 =?us-ascii?Q?w94BUmqqqpkxnmCHwJRG0762hzkXH4gyi03PlVMTxlRWQIkCopSAFuxrTMJx?=
 =?us-ascii?Q?wItxBtpElTxZrB3UJLX/WdJETTFc/82ae8fM/8zY+iTtp9tV9VcZsvN8Plpt?=
 =?us-ascii?Q?t2KP3igbYTFeLbPacSIU1gCswBbM68MNo1kyKdocrC9gYQO2fsIOvxkSSoHR?=
 =?us-ascii?Q?zr8jCJwSW3eSLiuLHD3fbI4fKK3VXdpoclRbEHuj72Dhf+UWuJCPAD0R7J58?=
 =?us-ascii?Q?ybJgYrgpUj/dRzQvEYzcHFn0xtM+t64axxJ1ZWxuB89gHazzQLHYVTuVJnl5?=
 =?us-ascii?Q?Gctt6YmTIY0Bv16M098Y5glosOLpzIhdS8EW92Z3RXhJroABO+xy9vfnnB3V?=
 =?us-ascii?Q?xlxKBo3aCR/zf5iaT1qs28D+3cxzxldDpOaINkF/vr2NSJdU8jFjd7L4AN/K?=
 =?us-ascii?Q?VJpwVH1g8j0lPGCKfTLIbe57+X9T517Z11TkaKAQicQmejwvxI41IeW9IOGL?=
 =?us-ascii?Q?yIcFCplJbvzRPm/roKSliOrK4eZyF/2gKpSFPznlYxV5nCoO+aZ1kBXLmZga?=
 =?us-ascii?Q?3kJBIbUQ+BAJf4bsifLZ3MWUfcmRksVbxmpow15GN2yQBk2Tj8nGjjG4s+Yn?=
 =?us-ascii?Q?PIjttG9tAIGU5ry8Xv3NA+q++hMFME9rIMrOuX79VDBBoD/JAp+T/J6UGGIp?=
 =?us-ascii?Q?Evb/MvTyyiZLSfInZyjld75gYWnEQ0REO6IimXNE35VWJbqB5VqmOFqoIJD9?=
 =?us-ascii?Q?CkGb4IRs3TUonCfbKAbHPRUVfofmuYwC+6v7y4tS75EAOfrVUH3ZRkZ4r70d?=
 =?us-ascii?Q?IhCIg3vmKo0LkWRdf6DEMlLbaRhWZ+M1VUA6tNx7VGihSY7xIixvmD+q68CU?=
 =?us-ascii?Q?pial3PdfXAQcWbWBJmYssh71RltQdvyMNkntW+xerfWymP+7JEJPEsLNTp7l?=
 =?us-ascii?Q?r+WRvYE/Js15kZ4Xd0xtWfMMD55m4AP615Zt6ezDgTckYXHBPCK2vW0We/oB?=
 =?us-ascii?Q?sd7K0nNUoI4Aut598/EqUKGzh0pcO6mu/sxWCwX7efc2H/tHxCOSwNBu8sY7?=
 =?us-ascii?Q?fRBcKb0KVmi1n4mT0eReKANlL0M0qZauCySQ0bJWJ/ZwjuP1mwzohmN62zyh?=
 =?us-ascii?Q?XLZybkUt0HIYYPVonrlCCE/3Kg/RNufpDdkdSAJ2?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR12MB780478C3B4C8DBC2E973191497C32DS0PR12MB7804namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416e84a5-1496-4384-eb59-08dc8ce01574
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2024 02:08:43.9980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DeRwDepST+vrb2/bi7RP7PFeWYDOrCtWWG6M/FO4h03s5+0103ao3AwsGN+O1qkg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6932
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

--_000_DS0PR12MB780478C3B4C8DBC2E973191497C32DS0PR12MB7804namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Never mind, bit 16 and above is probably because of dword aligned offset.

Any reason not to do this in kiq/rlc based writes to normalise all?

Thanks,
Lijo
________________________________
From: Lazar, Lijo
Sent: Friday, June 14, 2024 5:20:30 PM
To: Jian, Jane <Jane.Jian@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>; Z=
hao, Victor <Victor.Zhao@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: keep init xcc0 for all xccs under sriov



On 6/14/2024 4:40 PM, Jane Jian wrote:
> [WHY]
> sriov has the higher bit violation when flushing tlb
>
> [HOW]
> for sriov only init XCC0(lower 16-bit) for all XCCs to avoid higher bit v=
iolation
> since kiq ring is always local, local address without XCC ID is enough to=
 be sent to the XCC KIQ
>

The description is incorrect.

Bits 18:20 represent xcc id. To guarantee all paths pass a local
address, you should just strip bits 18:20 in kiq/rlcg read/write
functions rather than here.

Thanks,
Lijo

> Signed-off-by: Jane Jian <Jane.Jian@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/a=
md/amdgpu/gfxhub_v1_2.c
> index e14acab5cceb..4e38a66a52f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> @@ -537,29 +537,36 @@ static void gfxhub_v1_2_xcc_init(struct amdgpu_devi=
ce *adev, uint32_t xcc_mask)
>  {
>        struct amdgpu_vmhub *hub;
>        int i;
> +     uint32_t gc_index;
>
>        for_each_inst(i, xcc_mask) {
>                hub =3D &adev->vmhub[AMDGPU_GFXHUB(i)];
>
> +             /* for sriov only init XCC0(lower 16-bit) to avoid higher b=
it violation */
> +             if (amdgpu_sriov_vf(adev))
> +                     gc_index =3D 0;
> +             else
> +                     gc_index =3D GET_INST(GC, i);
> +
>                hub->ctx0_ptb_addr_lo32 =3D
> -                     SOC15_REG_OFFSET(GC, GET_INST(GC, i),
> +                     SOC15_REG_OFFSET(GC, gc_index,
>                                regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32);
>                hub->ctx0_ptb_addr_hi32 =3D
> -                     SOC15_REG_OFFSET(GC, GET_INST(GC, i),
> +                     SOC15_REG_OFFSET(GC, gc_index,
>                                regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32);
>                hub->vm_inv_eng0_sem =3D
> -                     SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_INVALID=
ATE_ENG0_SEM);
> +                     SOC15_REG_OFFSET(GC, gc_index, regVM_INVALIDATE_ENG=
0_SEM);
>                hub->vm_inv_eng0_req =3D
> -                     SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_INVALID=
ATE_ENG0_REQ);
> +                     SOC15_REG_OFFSET(GC, gc_index, regVM_INVALIDATE_ENG=
0_REQ);
>                hub->vm_inv_eng0_ack =3D
> -                     SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_INVALID=
ATE_ENG0_ACK);
> +                     SOC15_REG_OFFSET(GC, gc_index, regVM_INVALIDATE_ENG=
0_ACK);
>                hub->vm_context0_cntl =3D
> -                     SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_CONTEXT=
0_CNTL);
> +                     SOC15_REG_OFFSET(GC, gc_index, regVM_CONTEXT0_CNTL)=
;
>                hub->vm_l2_pro_fault_status =3D
> -                     SOC15_REG_OFFSET(GC, GET_INST(GC, i),
> +                     SOC15_REG_OFFSET(GC, gc_index,
>                                regVM_L2_PROTECTION_FAULT_STATUS);
>                hub->vm_l2_pro_fault_cntl =3D
> -                     SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_L2_PROT=
ECTION_FAULT_CNTL);
> +                     SOC15_REG_OFFSET(GC, gc_index, regVM_L2_PROTECTION_=
FAULT_CNTL);
>
>                hub->ctx_distance =3D regVM_CONTEXT1_CNTL -
>                                regVM_CONTEXT0_CNTL;

--_000_DS0PR12MB780478C3B4C8DBC2E973191497C32DS0PR12MB7804namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div dir=3D"auto">Never mind, bit 16 and above is probably because of dword=
 aligned offset.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Any reason not to do this in kiq/rlc based writes to norm=
alise all?</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
<div dir=3D"auto">Thanks,</div>
<div dir=3D"auto">Lijo</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo<br>
<b>Sent:</b> Friday, June 14, 2024 5:20:30 PM<br>
<b>To:</b> Jian, Jane &lt;Jane.Jian@amd.com&gt;; Chang, HaiJun &lt;HaiJun.C=
hang@amd.com&gt;; Zhao, Victor &lt;Victor.Zhao@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: keep init xcc0 for all xccs under s=
riov</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
On 6/14/2024 4:40 PM, Jane Jian wrote:<br>
&gt; [WHY]<br>
&gt; sriov has the higher bit violation when flushing tlb<br>
&gt; <br>
&gt; [HOW]<br>
&gt; for sriov only init XCC0(lower 16-bit) for all XCCs to avoid higher bi=
t violation<br>
&gt; since kiq ring is always local, local address without XCC ID is enough=
 to be sent to the XCC KIQ<br>
&gt; <br>
<br>
The description is incorrect.<br>
<br>
Bits 18:20 represent xcc id. To guarantee all paths pass a local<br>
address, you should just strip bits 18:20 in kiq/rlcg read/write<br>
functions rather than here.<br>
<br>
Thanks,<br>
Lijo<br>
<br>
&gt; Signed-off-by: Jane Jian &lt;Jane.Jian@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 23 +++++++++++++++---=
-----<br>
&gt;&nbsp; 1 file changed, 15 insertions(+), 8 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/dr=
m/amd/amdgpu/gfxhub_v1_2.c<br>
&gt; index e14acab5cceb..4e38a66a52f4 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c<br>
&gt; @@ -537,29 +537,36 @@ static void gfxhub_v1_2_xcc_init(struct amdgpu_d=
evice *adev, uint32_t xcc_mask)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vmhub *hub;<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gc_index;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_inst(i, xcc_mask) {=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hub =3D &amp;adev-&gt;vmhub[AMDGPU_GFXHUB(i)];<br>
&gt;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* for sriov only init XCC0(lower 16-bit) to avoid higher bit violation=
 */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (amdgpu_sriov_vf(adev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_index =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_index =3D GET_INST(G=
C, i);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hub-&gt;ctx0_ptb_addr_lo32 =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, GE=
T_INST(GC, i),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, gc=
_index,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regVM_CONTEXT0_PAGE_TABLE_BASE_ADD=
R_LO32);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hub-&gt;ctx0_ptb_addr_hi32 =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, GE=
T_INST(GC, i),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, gc=
_index,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regVM_CONTEXT0_PAGE_TABLE_BASE_ADD=
R_HI32);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hub-&gt;vm_inv_eng0_sem =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, GE=
T_INST(GC, i), regVM_INVALIDATE_ENG0_SEM);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, gc=
_index, regVM_INVALIDATE_ENG0_SEM);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hub-&gt;vm_inv_eng0_req =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, GE=
T_INST(GC, i), regVM_INVALIDATE_ENG0_REQ);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, gc=
_index, regVM_INVALIDATE_ENG0_REQ);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hub-&gt;vm_inv_eng0_ack =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, GE=
T_INST(GC, i), regVM_INVALIDATE_ENG0_ACK);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, gc=
_index, regVM_INVALIDATE_ENG0_ACK);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hub-&gt;vm_context0_cntl =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, GE=
T_INST(GC, i), regVM_CONTEXT0_CNTL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, gc=
_index, regVM_CONTEXT0_CNTL);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hub-&gt;vm_l2_pro_fault_status =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, GE=
T_INST(GC, i),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, gc=
_index,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regVM_L2_PROTECTION_FAULT_STATUS);=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hub-&gt;vm_l2_pro_fault_cntl =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, GE=
T_INST(GC, i), regVM_L2_PROTECTION_FAULT_CNTL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, gc=
_index, regVM_L2_PROTECTION_FAULT_CNTL);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hub-&gt;ctx_distance =3D regVM_CONTEXT1_CNTL -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regVM_CONTEXT0_CNTL;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DS0PR12MB780478C3B4C8DBC2E973191497C32DS0PR12MB7804namp_--
