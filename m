Return-Path: <SRS0=AKuh=J7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F48FC433B4
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 14:30:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11EB3610A5
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 14:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11EB3610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF14C6EB0F;
	Tue,  4 May 2021 14:30:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DC8F6EB0F
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 May 2021 14:30:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWBbxk8W7uOWSqe9/QGy405GU9HRruc03DtoFumsQQHaNtE0OZeLhtRJhIriyJGGvF/koHDZ07RX8bdEAsPldybDj+Bcw/O1ajBfjzA9kvi7aP7AAXMBauGRGvyUjd9NHMbSwLmhuj1QcRblLk5A/rbnr9ByY1H7+vH7WjQF7AHbrR3umIXGb0dXgF2mU6rIVHZHzK68HYAfFhjqDbYe9HbRtBWDwdZ/Vf5yfVQleyeIgSSU3f41DLI0jr4FKiYALYm7mNbrunUwkgLItqc0QU1DgflPPShmFu2C5cwntQvB8J0e4rGVeFtnMld1+AhszFRzNJRZeFPLMP000gYXsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxnZZafWzCPmTVqYW4v1TPZskIwN9jZ4YuNi9RGeDM4=;
 b=Bttc9RxTMjKInMPeK4i2T5GyMVS70I6HN3VYSUidp5Jy0LS3MpfsH/zYgj08sKcHjuMml/8HieYey8lKfmoGEm2/C/g1lulEBMKeNeZNSkHgP1AbRUgH1IyjnVbfzH15/bUfa/xICUB+/tlxP499bszg20tzYMSDRAr+RZvv34oXoiAqmVJek6cw89as6uOevLJyjBIQDOeheXD4LDIelop/B27rZNlQVvu0gY2GEiM9omtjOrDrBi0CloKEdDCWaE9xfpbCbUU7mkfNDZwHsY4cGCbzU0ovfgfvVwm6qNz3T9loh7GJ5Z17c/3aQ71xZ9ydtbUEigvIpTPZ2BiL1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxnZZafWzCPmTVqYW4v1TPZskIwN9jZ4YuNi9RGeDM4=;
 b=jz7yNzkoAfa4Ub8r6DS7obtHAbO/0odZlPIKy3uFyr+3aG+l1dfSsQW2yBN+Y5o7pdRMCD93XnvTnd7u75cXm4EXDtF2Ae6xsKh6384wqtQynlZcNUIRBSDtG85jN73TApc6D5wNucNoZ4mBm+XSQrCs8hwQAXfZ9r6kDG5JHRY=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by BL0PR12MB2515.namprd12.prod.outlook.com (2603:10b6:207:40::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Tue, 4 May
 2021 14:30:20 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::b83b:b880:25cc:c1b9]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::b83b:b880:25cc:c1b9%8]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 14:30:20 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: add ACPI SRAT parsing for topology
Thread-Topic: [PATCH] drm/amdkfd: add ACPI SRAT parsing for topology
Thread-Index: AQHXPEDkmcu6EZNVCUG6NeTIImqf/KrS+adggABplwCAAAc01g==
Date: Tue, 4 May 2021 14:30:19 +0000
Message-ID: <MN2PR12MB45495C464A09AB31CE635986975A9@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210428151154.28317-1-jinhuieric.huang@amd.com>
 <MN2PR12MB4549A0F3CDC8BF13CF2D115A975A9@MN2PR12MB4549.namprd12.prod.outlook.com>,
 <39a370c3-35e5-64b3-716f-20fbcdec49e8@amd.com>
In-Reply-To: <39a370c3-35e5-64b3-716f-20fbcdec49e8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-04T14:26:31.0524565Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [106.208.104.142]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2737817f-9173-4188-4efe-08d90f09250a
x-ms-traffictypediagnostic: BL0PR12MB2515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB25159B1735785CAA7C715CD0975A9@BL0PR12MB2515.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nnp//nvhJYlH/oEuHHJzfuehzLizHykj8HsP3UQXCQjXbTtHU3PEtWJuj2eky0vDb/bv9JbSfcaRpBnlLhbzC66LEWt8oT8OxEOq+3Lw1FMxm+Erd2G96Ti3fD9NueLlKZcj0AjLWDYK1/y023Obmn7NT3Jw/WTXBy2yi9Ma4fZ1azf0kw3nnSnZHunU2gZmLUiWAzgHwBYI6v9OSoU33wUOP2YT/0hGXhlUY39dtvNX7tq1pj8AOBQWFMxJb6uc4/+aPE7JbdNas5OUrQ1IF4kmiVL47NBAIFxcWqOi0xy3vL8WnS9/vyYehcFYjz0enuHEAfEwvJuyph9+Bskzr0VPCHoRn/Z9Em9C0Dp9DEL4FW5+Nwrjna3bNyA58bKIibdg/js8jFPiRWc/jpVWzsOTeV3KQa+ohgnqTxu6W8TRE8vYj8vLIG1m5LIJPBQfs3smc+zWU1VNn4TTrSYNHhsrdrUT7o+tOba5Om8Bwsl184ZvyNk17NDb/0agDHrEEvWSXDFPGmuPjWvXCheoPdqgxrbHL7W4eUbXx1X78XEZv+dVWaRQJe0MTdP8TeU6vxshLV1A+zqN8sYJPxCj7GDBwdib2aptCZMEv9NRVoF7G42yTV8h5zPHbePLPOEf7DAp7JZLPqLEaA8v6bcwAA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39850400004)(166002)(64756008)(478600001)(26005)(45080400002)(122000001)(2906002)(52536014)(71200400001)(83380400001)(66946007)(66556008)(55016002)(5660300002)(76116006)(6506007)(7696005)(33656002)(316002)(91956017)(8936002)(53546011)(38100700002)(186003)(966005)(8676002)(66446008)(86362001)(66476007)(9686003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rfKWC2aIJtPUGwEA6p+Uiz4EP2jC23kDLmvj6Kvr+dvzIJ0WkJBtNzJ7L/8M?=
 =?us-ascii?Q?xJuPyo+A3xkjoMVZZMbWHasVBEgU1ZwN/zpBm+DWtfNaQzCqWfSndoY5mSTk?=
 =?us-ascii?Q?wlaT+fFmlViZZ4DVz+3317OeEEl79l2dgIssEJxNKV5xD5GvWQCoMflSv1RK?=
 =?us-ascii?Q?kS7w4NcLG7GdyiBQ7zj7CGS7QrQBprNNSD4Avoeebw7bDpP3KDfuX0DCAOuQ?=
 =?us-ascii?Q?Y47raeZB+2rqZzuIOS32FLFg7X2TNWizli3tUG1wjHlkJZ+TTQtKO+oUa978?=
 =?us-ascii?Q?TNvN2n1ah93/48SuZFWVIBelZ5em/9cGNbf1Lb9u0lbT+QhGrLjMElyy6xtC?=
 =?us-ascii?Q?1U32kp+PeSHUVpvmsb/ZTOLDIOMbXOtdvz+03XzpwStxRevvmU+KDxj59dNb?=
 =?us-ascii?Q?tN/AVzfb38GOqAJi+DUE4uzwnVTQi7JXzuVLOEap3nP3vMGtz1F2MRKsvaUG?=
 =?us-ascii?Q?uwGeHo9VtiaGN+/4CNu5sZTeypNC7vSnR/jxLCD6Fl8g8xlIP5iqRgUh4zxz?=
 =?us-ascii?Q?XigJQ2c+EAdphk4BxQQscGeg1FtJDo4bO185AYaXAoulOBZxxfhNlHf3RXPO?=
 =?us-ascii?Q?eYKsT/tyT3OEfGjC9snWqEov6lYlEwECiheLg9dAtzAAgqjJrwFwebdURNee?=
 =?us-ascii?Q?T/AHGhcWSrejIqGur28mIUJE9kEaKohulDgSSiS0x9w3/zzqBRpzAFKJ7Qtp?=
 =?us-ascii?Q?p29WrwDRZlqKNOBDki3aDvIJ4K6dbm6AShHTSTbdBmp+3SR5u0AkAYuEl5by?=
 =?us-ascii?Q?/h3laiOh6piQ/ax+rzh4j06GMLuk9qT4EZCAotel/sJScCXEqUVp/esSb+2b?=
 =?us-ascii?Q?ZniBqrbw/Ncfq/n7LRgCJvJlgFp2dPkDMMmJfM8EEhG0NOf7k3vbgIc2UuPz?=
 =?us-ascii?Q?S1SY2ZbdRTYUuUAgi2p8+SbjdCzW1/4URSSRmiLmIoIEZhQXdI3O+JFn42oA?=
 =?us-ascii?Q?yB7eDXy9aV4m8FLTBC9Wq+f9Jy+tR5QwmNOpX8S+XX9bUPMTBqdE1UIZ1W/P?=
 =?us-ascii?Q?Mdm5hAPVTfzbX+PLFkw3yi5HbV+Gujv04kNQnbRHs3jjwaOpKhJ47KZr4W2t?=
 =?us-ascii?Q?OV1HcCSRSpE9l/dJfzDHMpOfl6yMcCbs7DYPz2pSBdhrxgWhiB/PKRETVhth?=
 =?us-ascii?Q?yYzCpLdsVJEEiuAXJD1OQ6bqWT2azNlui96eDv3PY7CNlSeOs84wgO47p17y?=
 =?us-ascii?Q?/aRxd+nWJxHbSryTm8Ejd/bLMX9z1kGhvo51Q+MttbGQL0vQAf/cr0kj/mjw?=
 =?us-ascii?Q?2FO9hPUyoEnSYaH1GrgWsNRzc1X6Doty4aA1hd13A2mIWHc16WTf0E5eI8Zo?=
 =?us-ascii?Q?AGIx87bl+pNhSZk1G37u/IHU+byPqV597vlNhjXgXCAmpg=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2737817f-9173-4188-4efe-08d90f09250a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2021 14:30:19.8906 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0gKDQsRSUKWPJoZE4skj21uy+bTJjAT9WdxSd7VvNmsU3i16wBiGptWd71MS2zoY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2515
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
Content-Type: multipart/mixed; boundary="===============1334488481=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1334488481==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB45495C464A09AB31CE635986975A9MN2PR12MB4549namp_"

--_000_MN2PR12MB45495C464A09AB31CE635986975A9MN2PR12MB4549namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Converting using pxm_to_node and then comparing against pxm value looks a b=
it odd. Shouldn't the comparsion be between equals - node to node or pxm to=
 pxm?

Thanks,
Lijo
________________________________
From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
Sent: Tuesday, May 4, 2021 7:30:44 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: add ACPI SRAT parsing for topology

Like I answer Oak's question,
"For GCD parsing, the relation of GCD to CCD is defined by AMD, generic
parsing in srat.c is considering a GCD as a new numa node which is not
suitable for our need."

GCD's pxm domain will get a wrong numa node which may be bigger than CCD
domains, so I have to do a sanity check to correct it.

Regards,
Eric

On 2021-05-04 3:46 a.m., Lazar, Lijo wrote:
> [AMD Public Use]
>
>> *numa_node > max_pxm
> Why numa node number is compared to a proximity domain? Since you are alr=
eady using pxm_to_node() API, assume that should take care.
>
> That also will avoid parsing ACPI_SRAT_TYPE_CPU_AFFINITY structs.
>
> Thanks,
> Lijo
>
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Eric H=
uang
> Sent: Wednesday, April 28, 2021 8:42 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Subject: [PATCH] drm/amdkfd: add ACPI SRAT parsing for topology
>
> In NPS4 BIOS we need to find the closest numa node when creating topology=
 io link between cpu and gpu, if PCI driver doesn't set it.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 94 ++++++++++++++++++++++++++-
>   1 file changed, 91 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_crat.c
> index 38d45711675f..57518136c7d7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1759,6 +1759,87 @@ static int kfd_fill_gpu_memory_affinity(int *avail=
_size,
>        return 0;
>   }
>
> +#ifdef CONFIG_ACPI
> +static void kfd_find_numa_node_in_srat(struct kfd_dev *kdev,
> +             int *numa_node)
> +{
> +     struct acpi_table_header *table_header =3D NULL;
> +     struct acpi_subtable_header *sub_header =3D NULL;
> +     unsigned long table_end, subtable_len;
> +     u32 pci_id =3D pci_domain_nr(kdev->pdev->bus) << 16 |
> +                     pci_dev_id(kdev->pdev);
> +     u32 bdf;
> +     acpi_status status;
> +     struct acpi_srat_cpu_affinity *cpu;
> +     struct acpi_srat_generic_affinity *gpu;
> +     int pxm =3D 0, max_pxm =3D 0;
> +     bool found =3D false;
> +
> +     /* Fetch the SRAT table from ACPI */
> +     status =3D acpi_get_table(ACPI_SIG_SRAT, 0, &table_header);
> +     if (status =3D=3D AE_NOT_FOUND) {
> +             pr_warn("SRAT table not found\n");
> +             return;
> +     } else if (ACPI_FAILURE(status)) {
> +             const char *err =3D acpi_format_exception(status);
> +             pr_err("SRAT table error: %s\n", err);
> +             return;
> +     }
> +
> +     table_end =3D (unsigned long)table_header + table_header->length;
> +
> +     /* Parse all entries looking for a match. */
> +
> +     sub_header =3D (struct acpi_subtable_header *)
> +                     ((unsigned long)table_header +
> +                     sizeof(struct acpi_table_srat));
> +     subtable_len =3D sub_header->length;
> +
> +     while (((unsigned long)sub_header) + subtable_len  < table_end) {
> +             /*
> +              * If length is 0, break from this loop to avoid
> +              * infinite loop.
> +              */
> +             if (subtable_len =3D=3D 0) {
> +                     pr_err("SRAT invalid zero length\n");
> +                     break;
> +             }
> +
> +             switch (sub_header->type) {
> +             case ACPI_SRAT_TYPE_CPU_AFFINITY:
> +                     cpu =3D (struct acpi_srat_cpu_affinity *)sub_header=
;
> +                     pxm =3D *((u32 *)cpu->proximity_domain_hi) << 8 |
> +                                     cpu->proximity_domain_lo;
> +                     if (pxm > max_pxm)
> +                             max_pxm =3D pxm;
> +                     break;
> +             case ACPI_SRAT_TYPE_GENERIC_AFFINITY:
> +                     gpu =3D (struct acpi_srat_generic_affinity *)sub_he=
ader;
> +                     bdf =3D *((u16 *)(&gpu->device_handle[0])) << 16 |
> +                                     *((u16 *)(&gpu->device_handle[2]));
> +                     if (bdf =3D=3D pci_id) {
> +                             found =3D true;
> +                             *numa_node =3D pxm_to_node(gpu->proximity_d=
omain);
> +                     }
> +                     break;
> +             default:
> +                     break;
> +             }
> +
> +             if (found)
> +                     break;
> +
> +             sub_header =3D (struct acpi_subtable_header *)
> +                             ((unsigned long)sub_header + subtable_len);
> +             subtable_len =3D sub_header->length;
> +     }
> +
> +     /* workaround bad cpu-gpu binding case */
> +     if (found && (*numa_node < 0 || *numa_node > max_pxm))
> +             *numa_node =3D 0;
> +}
> +#endif
> +
>   /* kfd_fill_gpu_direct_io_link - Fill in direct io link from GPU
>    * to its NUMA node
>    *  @avail_size: Available size in the memory
> @@ -1774,6 +1855,9 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *=
avail_size,
>                        uint32_t proximity_domain)
>   {
>        struct amdgpu_device *adev =3D (struct amdgpu_device *)kdev->kgd;
> +#ifdef CONFIG_NUMA
> +     int numa_node =3D 0;
> +#endif
>
>        *avail_size -=3D sizeof(struct crat_subtype_iolink);
>        if (*avail_size < 0)
> @@ -1805,9 +1889,13 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int =
*avail_size,
>
>        sub_type_hdr->proximity_domain_from =3D proximity_domain;  #ifdef =
CONFIG_NUMA
> -     if (kdev->pdev->dev.numa_node =3D=3D NUMA_NO_NODE)
> -             sub_type_hdr->proximity_domain_to =3D 0;
> -     else
> +     if (kdev->pdev->dev.numa_node =3D=3D NUMA_NO_NODE) { #ifdef CONFIG_=
ACPI
> +             kfd_find_numa_node_in_srat(kdev, &numa_node); #endif
> +             sub_type_hdr->proximity_domain_to =3D numa_node;
> +             set_dev_node(&kdev->pdev->dev, numa_node);
> +     } else
>                sub_type_hdr->proximity_domain_to =3D kdev->pdev->dev.numa=
_node;  #else
>        sub_type_hdr->proximity_domain_to =3D 0;
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Clijo.l=
azar%40amd.com%7C96808a6aab7b40861eeb08d90a580524%7C3dd8961fe4884e608e11a82=
d994e183d%7C0%7C0%7C637552195438132467%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w=
LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Di=
pBmGTX%2Fokto1zRuQ8jlDA8p%2B8BOjHZa5WGGKNJszEY%3D&amp;reserved=3D0


--_000_MN2PR12MB45495C464A09AB31CE635986975A9MN2PR12MB4549namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Converting using pxm_to_node and then comparing against pxm value looks a b=
it odd. Shouldn't the comparsion be between equals - node to node or pxm to=
 pxm?</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Huang, JinHuiEric &lt=
;JinHuiEric.Huang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, May 4, 2021 7:30:44 PM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdkfd: add ACPI SRAT parsing for topology<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Like I answer Oak's question,<br>
&quot;For GCD parsing, the relation of GCD to CCD is defined by AMD, generi=
c <br>
parsing in srat.c is considering a GCD as a new numa node which is not <br>
suitable for our need.&quot;<br>
<br>
GCD's pxm domain will get a wrong numa node which may be bigger than CCD <b=
r>
domains, so I have to do a sanity check to correct it.<br>
<br>
Regards,<br>
Eric<br>
<br>
On 2021-05-04 3:46 a.m., Lazar, Lijo wrote:<br>
&gt; [AMD Public Use]<br>
&gt;<br>
&gt;&gt; *numa_node &gt; max_pxm<br>
&gt; Why numa node number is compared to a proximity domain? Since you are =
already using pxm_to_node() API, assume that should take care.<br>
&gt;<br>
&gt; That also will avoid parsing ACPI_SRAT_TYPE_CPU_AFFINITY structs.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Lijo<br>
&gt;<br>
&gt;<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf =
Of Eric Huang<br>
&gt; Sent: Wednesday, April 28, 2021 8:42 PM<br>
&gt; To: amd-gfx@lists.freedesktop.org<br>
&gt; Cc: Huang, JinHuiEric &lt;JinHuiEric.Huang@amd.com&gt;<br>
&gt; Subject: [PATCH] drm/amdkfd: add ACPI SRAT parsing for topology<br>
&gt;<br>
&gt; In NPS4 BIOS we need to find the closest numa node when creating topol=
ogy io link between cpu and gpu, if PCI driver doesn't set it.<br>
&gt;<br>
&gt; Signed-off-by: Eric Huang &lt;jinhuieric.huang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 94 +++++++++++++++=
+++++++++++-<br>
&gt;&nbsp;&nbsp; 1 file changed, 91 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_crat.c<br>
&gt; index 38d45711675f..57518136c7d7 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
&gt; @@ -1759,6 +1759,87 @@ static int kfd_fill_gpu_memory_affinity(int *av=
ail_size,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +#ifdef CONFIG_ACPI<br>
&gt; +static void kfd_find_numa_node_in_srat(struct kfd_dev *kdev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; int *numa_node)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct acpi_table_header *table_header =3D N=
ULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct acpi_subtable_header *sub_header =3D =
NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned long table_end, subtable_len;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u32 pci_id =3D pci_domain_nr(kdev-&gt;pdev-&=
gt;bus) &lt;&lt; 16 |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_dev_id(kdev-&gt;pde=
v);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u32 bdf;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; acpi_status status;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct acpi_srat_cpu_affinity *cpu;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct acpi_srat_generic_affinity *gpu;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int pxm =3D 0, max_pxm =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool found =3D false;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Fetch the SRAT table from ACPI */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; status =3D acpi_get_table(ACPI_SIG_SRAT, 0, =
&amp;table_header);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (status =3D=3D AE_NOT_FOUND) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pr_warn(&quot;SRAT table not found\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else if (ACPI_FAILURE(status)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; const char *err =3D acpi_format_exception(status);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pr_err(&quot;SRAT table error: %s\n&quot;, err);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; table_end =3D (unsigned long)table_header + =
table_header-&gt;length;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Parse all entries looking for a match. */=
<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; sub_header =3D (struct acpi_subtable_header =
*)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((unsigned long)table_h=
eader +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct acpi_tabl=
e_srat));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; subtable_len =3D sub_header-&gt;length;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; while (((unsigned long)sub_header) + subtabl=
e_len&nbsp; &lt; table_end) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /*<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * If length is 0, break from this loop to avoid<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * infinite loop.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (subtable_len =3D=3D 0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;SRAT inval=
id zero length\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; switch (sub_header-&gt;type) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case ACPI_SRAT_TYPE_CPU_AFFINITY:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu =3D (struct acpi_sr=
at_cpu_affinity *)sub_header;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pxm =3D *((u32 *)cpu-&g=
t;proximity_domain_hi) &lt;&lt; 8 |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp=
u-&gt;proximity_domain_lo;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pxm &gt; max_pxm)<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; max_pxm =3D pxm;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case ACPI_SRAT_TYPE_GENERIC_AFFINITY:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu =3D (struct acpi_sr=
at_generic_affinity *)sub_header;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bdf =3D *((u16 *)(&amp;=
gpu-&gt;device_handle[0])) &lt;&lt; 16 |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(=
(u16 *)(&amp;gpu-&gt;device_handle[2]));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bdf =3D=3D pci_id) =
{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; found =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; *numa_node =3D pxm_to_node(gpu-&gt;proximity_domai=
n);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; default:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (found)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; sub_header =3D (struct acpi_subtable_header *)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; ((unsigned long)sub_header + subtable_len);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; subtable_len =3D sub_header-&gt;length;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* workaround bad cpu-gpu binding case */<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (found &amp;&amp; (*numa_node &lt; 0 || *=
numa_node &gt; max_pxm))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *numa_node =3D 0;<br>
&gt; +}<br>
&gt; +#endif<br>
&gt; +<br>
&gt;&nbsp;&nbsp; /* kfd_fill_gpu_direct_io_link - Fill in direct io link fr=
om GPU<br>
&gt;&nbsp;&nbsp;&nbsp; * to its NUMA node<br>
&gt;&nbsp;&nbsp;&nbsp; *&nbsp; @avail_size: Available size in the memory<br=
>
&gt; @@ -1774,6 +1855,9 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(in=
t *avail_size,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_=
t proximity_domain)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D (struct amdgpu_device *)kdev-&gt;kgd;<br>
&gt; +#ifdef CONFIG_NUMA<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int numa_node =3D 0;<br>
&gt; +#endif<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *avail_size -=3D sizeof(stru=
ct crat_subtype_iolink);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*avail_size &lt; 0)<br>
&gt; @@ -1805,9 +1889,13 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(i=
nt *avail_size,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sub_type_hdr-&gt;proximity_d=
omain_from =3D proximity_domain;&nbsp; #ifdef CONFIG_NUMA<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (kdev-&gt;pdev-&gt;dev.numa_node =3D=3D N=
UMA_NO_NODE)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; sub_type_hdr-&gt;proximity_domain_to =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (kdev-&gt;pdev-&gt;dev.numa_node =3D=3D N=
UMA_NO_NODE) { #ifdef CONFIG_ACPI<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfd_find_numa_node_in_srat(kdev, &amp;numa_node); #endif<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; sub_type_hdr-&gt;proximity_domain_to =3D numa_node;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; set_dev_node(&amp;kdev-&gt;pdev-&gt;dev, numa_node);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; sub_type_hdr-&gt;proximity_domain_to =3D kdev-&gt;pdev-=
&gt;dev.numa_node;&nbsp; #else<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sub_type_hdr-&gt;proximity_d=
omain_to =3D 0;<br>
&gt; --<br>
&gt; 2.17.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx@lists.freedesktop.org<br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Clijo.lazar%40amd.com%7C96808a6aab7b40861eeb08d90a580524%7C3dd8=
961fe4884e608e11a82d994e183d%7C0%7C0%7C637552195438132467%7CUnknown%7CTWFpb=
GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7=
C1000&amp;amp;sdata=3DipBmGTX%2Fokto1zRuQ8jlDA8p%2B8BOjHZa5WGGKNJszEY%3D&am=
p;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C01%7Clijo=
.lazar%40amd.com%7C96808a6aab7b40861eeb08d90a580524%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637552195438132467%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sda=
ta=3DipBmGTX%2Fokto1zRuQ8jlDA8p%2B8BOjHZa5WGGKNJszEY%3D&amp;amp;reserved=3D=
0</a><br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB45495C464A09AB31CE635986975A9MN2PR12MB4549namp_--

--===============1334488481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1334488481==--
