Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908EEC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 16:49:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD1D173E69;
	Wed,  8 Dec 2021 16:49:54 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2048.outbound.protection.outlook.com [40.107.101.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43DCB73E69
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 16:49:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4TDFNg8KhxLDXpooHLrGo9/lKRR+9zDuZCYwbgpah4LvjoytCTz96+bTHIgOdWM3gZE1LvKJMSQJSVuFFcJA+mXuKjDZVbZ/kUKW2FDJDTD+xda3VeNa442Nw+gfTbb4XDEyclmJ1/Cyyn7JSP6CmhMlkVjRGSX3H9E/VZwXwekbkeYZ3wLhyydta9+Nj69T2qj1tvWEpFUgiWz5DD4sIdQMtik6o0hJacLHVHy6V1Kpmb2ioDkoNftnU3dB0OIylpcXwxlDyqWoZDmrMYNYndRuaeWy+b8rMcFw5pzNDc9fxwSlRdWiXv7X0ZxfCxfy13yXaFMoGTNWNc/o1wnrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nh6TdkbRT/3hhIOOSd8+8zA8r100GbsnteCqi/TI63I=;
 b=S8Km+UUEs+lEWnugdASuUNi6TNCV1W+1NZr3B6OMlkuy2Pph2Ey43NUUI0t7MVM8cqbHN8cdReNZIecU9wzZ+JOxV0Y59cJLy5oUZBhlqNdDjldTsDNOeB43ldq+5RGI29nF54yU7BG/0m7hfLGCj7I7ZBP+TOSksfwyN33OhElHG5zhXSI0iuBl8pSVE+K3oIvVOPm7/9HMmq2Uu6hTkigtwGf8Fyy+92D0f09SPCaFnjnEZRPCqtxZCmHcG4Dk3jqIV/rBasQqg6HhX/696ZuLgLkIEW+19FCXUJYqYtlE167H5Tkpy8O/R7+FX2NYXSpQAKBb9DGgGJojbmo+4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nh6TdkbRT/3hhIOOSd8+8zA8r100GbsnteCqi/TI63I=;
 b=xLwtqCA52WyqL4FdL1ODze3iZLEOe1wi3nAuF2hmwoNWRwgaUeW4fGYyCq7aS1KSEjKjwQxNmKu//GKbTGNG5mFD8UZgdYl9CxbBr4TdRy20BFDEhaVndlaJmLLveDtMyZwk+MOtL0ILQyEgCiP9w5e9Vr4eT1ZiIbW3eVkiVZc=
Received: from DM6PR12MB2858.namprd12.prod.outlook.com (2603:10b6:5:182::21)
 by DM6PR12MB2809.namprd12.prod.outlook.com (2603:10b6:5:4a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Wed, 8 Dec
 2021 16:34:33 +0000
Received: from DM6PR12MB2858.namprd12.prod.outlook.com
 ([fe80::74bb:cb46:f4ef:73e4]) by DM6PR12MB2858.namprd12.prod.outlook.com
 ([fe80::74bb:cb46:f4ef:73e4%3]) with mapi id 15.20.4755.021; Wed, 8 Dec 2021
 16:34:33 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdkfd: Make KFD support on Hawaii experimental
Thread-Topic: [PATCH 2/2] drm/amdkfd: Make KFD support on Hawaii experimental
Thread-Index: AQHX7A1D/28r3xCsIEqMTvrjAhdvfqwoyr0A
Date: Wed, 8 Dec 2021 16:34:33 +0000
Message-ID: <DM6PR12MB28581A2B98772FCA4FDF01FC856F9@DM6PR12MB2858.namprd12.prod.outlook.com>
References: <20211208082531.918062-1-Felix.Kuehling@amd.com>
 <20211208082531.918062-2-Felix.Kuehling@amd.com>
In-Reply-To: <20211208082531.918062-2-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f5b1c2cf-a7a1-4f44-8efd-bfe18c4b403e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-08T16:34:07Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 034fc682-4db4-4378-fcc3-08d9ba689d9b
x-ms-traffictypediagnostic: DM6PR12MB2809:EE_
x-microsoft-antispam-prvs: <DM6PR12MB28093F60CC7C1CE5C446B900856F9@DM6PR12MB2809.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EptP22v99cMfwneNDdlJ+tec0+hVwQAbJANe47d8GueBb9bZuRz4NSpjjkQa+3xDbsu8UZK0QgQJy0/Fi4nt6EFF31qWcUWZ7ylNgAJYk6twcizAa38TDNdUiXlqLKtnxinqYcLfdEyxx/F8ikdTne3Vb/zLWdpTEswZrwQkYMocKDvuGXDlcEZWfncBdjZ6/TLLGWbvzdK8ZLVVdfaIJDMaTyzI8CiI9vIJOGS2/qyVYdWZDJX6skMO9ouvi5CxrVIv0/yoRMlub382rPNQhUFOMjgSSPg4mctJDuMNzoKVptE6gPh+rrOxqnYoCzH+O254+X++cexVvifyFwBBIRNoCMDPLtDTogEtMfZHpxz/DJvJZlkP4bfKVd9NojnVNZJH+3O2PK0BLylMYN/W6egTh5fz9jLtjjRqcJ2qWGtIltDpRu3hUcKf3HuY1gcxYaqUS1ELIs6x4XFJUiLT9aNSxKzO96w1UM9khrZCxaa+UIwxAAWBQqs4yYXwpTlparvl3PJXEVh7IHikwTOMmQELU+aHFQ+6iLbNzbCdDPSChjpH/qDW4Xl1bYA4wuAvb+RoYxnC6WPze2eyezmwSVasWO+MRrcnMk6El1HEZz2fBfXiu0pJchm4rkDJsafC3YIViG9hlHZjvpaNOfpO3AyJLxwcX7B96qg0EtXr/8IGpWsIWAcmlDtBXOZtcTiGyAZ344wAM5zycqw5C9neKQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2858.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(9686003)(76116006)(66946007)(53546011)(33656002)(52536014)(66476007)(5660300002)(8676002)(6506007)(64756008)(55016003)(66556008)(66446008)(2906002)(86362001)(26005)(122000001)(71200400001)(508600001)(38100700002)(8936002)(38070700005)(83380400001)(110136005)(7696005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?so0ti0U50Q7hL6HNMnDvGOy2DQLSYYqM3zBaEMOWQrVnkuU5zeQ2Cbme5VO/?=
 =?us-ascii?Q?rOzDXj+8ZOxVpjq8a5zvAvA19pRomTWQdC4enhqiQxinjwmNkdnL/rGYBKcS?=
 =?us-ascii?Q?0wx9oSp0ZAtOiTVk+MOkYpHguLf3L8TZJl172TjcHsJUS4JcY8Sigfz3EN1U?=
 =?us-ascii?Q?4lSnh8QnNWh8M5eOVqXs90tsMhKPG9V4C9Zqfp08bMKZW5sFVoWsTst+Hwk3?=
 =?us-ascii?Q?GUru/ciWN6EI3X+dSRoxw//wioybm7XOJouF/VX6StcSJmGJdaM1XvuTXuRL?=
 =?us-ascii?Q?yqdxOuBPkm7E5CZc1zEYgpMWtQxwlNnTZuhJm89abAsasQzhH2ec32b3BPqR?=
 =?us-ascii?Q?Za+UD5nceO0As6OkEA4fYrPj1mBs608XUwi/VcWEnrHAJxnRWJKaMODSZqaM?=
 =?us-ascii?Q?9IB27cxEvl58AjgRAQUK5UoiM75wLJzIiYgJ92183XfclXfPeoSYx/lmcNzK?=
 =?us-ascii?Q?blPIhiZrtxr/AzBBr/5bg3B2fp0Es8LmA8LTwxiNQHzoivSt7xdVpBl+nP0P?=
 =?us-ascii?Q?SnP0laVxrmXY28IvreyflgjBGVP6jizyMxsX1Zd2j2DjHa0qPqs7OJYHtqn/?=
 =?us-ascii?Q?Z977iP17TYKYzBarcDwdQzJyZxJXNWssSl2+Y+6vsmgEX9Bw8t7mh2iRqZae?=
 =?us-ascii?Q?byfUW8X0+gkolvB/SdmlZ+C9cbs/zGVLyGzP0qYxl6TjjiXeHAiQ3jXOU/hq?=
 =?us-ascii?Q?OrXnpjE9nb9fK5opZ3lRUHpRCqXuvdqTg3rRDfCN6gi0PpXDJ0gecTNxlqkk?=
 =?us-ascii?Q?FI+j0HifBjvjEyqMTRT/m3Ko6mUxuBDecklhWIZ1eHbqZWbf2AeBIW8RYP5t?=
 =?us-ascii?Q?wn4Sv3EMirpGDcHqRj2dcgxg8KLHAf7k32C/XJF1ZhiVmH+SMDLHWcpZgNou?=
 =?us-ascii?Q?1YmArZEAaH0YY0M2RgDRCjV1aQ28hUQISPhbgpezpnnG2WUCsHI9/dYvHwkE?=
 =?us-ascii?Q?BDxj/a4QxJISCcByw9DrV9xvFj4Bp3zMhy1VXYKfKiDqnDRn+UmH7t7+8Q1e?=
 =?us-ascii?Q?2AJ1XhAMCWEAaeXSldaBTl7QNT0N8K9eGRnVaeHcl6WpXIw9YuAMFipgSdkp?=
 =?us-ascii?Q?lmNkMCrqBc+xexeiBdN30bXfL1uOLm3AcqhqVAqMAXmgvZ/H8ng58CKgs9dH?=
 =?us-ascii?Q?d6WBQVqK7s8gtjxjgNGPd1Wjag7c+W5o5vZv9B4SyzMcTwp35Kjp52Lv39Dv?=
 =?us-ascii?Q?6tL+0cfNKJDIhDsoHvHG6pB4iTjhMO1KI2LWHYZQLnKTcSSuMqKD9ZK9GjhH?=
 =?us-ascii?Q?qVtRTzwtpSNv8LUMzrE/09dZikO58ScLbhFRw7Hdvlvnr0xUpT6zLvkGLE3m?=
 =?us-ascii?Q?qX6G9KMdXpAhQiIyreY8zp1uCeaQk8TmTEHwauVejdNbmbF6Q/oMkPd/FsTk?=
 =?us-ascii?Q?dvkbSBxgv473beRtTIKZ0CqT/4QaB4aV3Gxi/on2ZWpf/3QXBJQciHO9Gdlg?=
 =?us-ascii?Q?6/6zN1YV3JbWAI8CdWlps5/JiCa5Syvhfti86UdYkmvm5ix9MbrrodCLaqNS?=
 =?us-ascii?Q?2g4+kdZAZq8YRGK66YrVYEDM2kVvb5xyyY1oAumOz1CAGggcyVJfr5Iz6USc?=
 =?us-ascii?Q?PcWDekxjlgS1Thf6rCCW4vgDUmWWi8jIiyghkDJtZIvT06/RkMzkwhpGkg8+?=
 =?us-ascii?Q?1mdt4KK7sYqDr05nvUSETY4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2858.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034fc682-4db4-4378-fcc3-08d9ba689d9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 16:34:33.1697 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K3t+Bq6gFw8sn3AfM4JGrboI2KK9IOzFEEAJVYV8pvaqfrjVkXvTIRaggp26dENCnTt3umHMkJ3nmzufoMrkTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2809
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

[AMD Official Use Only]

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix =
Kuehling
> Sent: Wednesday, December 8, 2021 3:26 AM
> To: amd-gfx@lists.freedesktop.org
> Subject: [PATCH 2/2] drm/amdkfd: Make KFD support on Hawaii experimental
>
> Hawaii support is mostly untested these days. ROCm user mode also
> depends on custom firmware for AQL packet processing, that was never
> pushed upstream due to quality regressions in graphics driver testing.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 267668b96456..facc28f58c1f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -147,7 +147,11 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *=
adev, bool
> vf)
>  #ifdef CONFIG_DRM_AMDGPU_CIK
>       case CHIP_HAWAII:
>               gfx_target_version =3D 70001;
> -             if (!vf)
> +             if (!amdgpu_exp_hw_support)
> +                     pr_info(
> +     "KFD support on Hawaii is experimental. See modparam exp_hw_support=
\n"
> +                             );
> +             else if (!vf)
>                       f2g =3D &gfx_v7_kfd2kgd;
>               break;
>  #endif
> --
> 2.32.0

