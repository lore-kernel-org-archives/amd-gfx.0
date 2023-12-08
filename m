Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92936C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 22:08:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C25EF10EB42;
	Fri,  8 Dec 2023 22:08:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CB6410EB42
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 22:08:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMz7AvSwE1AUBroYab+4oPD37Ua1d6mTJd9ssIXk0+i8yn290bt367m8aI6lkKJ6jkbWC6xx6jUc0Zka1iGZz+TCtydqQGqrJT5C5R6kgGRzyWdLCN4H+fKqQMMDiARqNQ2bHrmpcIpnSndnYlMSD7nh2snYi53qJrQXR+HudEPgTqGqFF/QZXNelhgoafAv1iHU9HlqRQeoOC6TodXaLoTeW/YDSkXLj5Z1sLHqZGWeAE/0kEqetMhSkUb0twaSUAplJC/f4Y2bSXaaWYxHrT7zoJYBiUIUqPVXiCUZvawL6BMBwHyteZ4OcqWQkN6RcaDKptkSb66wsH/291YNvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+xccKA7oynR/jlXck4LGDeO6eBqRJzmS3MuKauLfmo=;
 b=N0SYCxvhbkuNwR3StAm6Jc9Qc9oHHbHFjK2VpIX7Wu/R/SF2PjWNHoU7rjjNOeXl9D1JPFCWRO4USV5Nu7b7/zAavFeWjtJWrgygdTNy6ViJo0aTJyx4IVh5EhtPELsEQl3zoFZR/0k+FVQH8oY47n8Yc+r1Wn6maVo9UyUHs8PvHYV+ni28FXSyh82KG+0ac2WOTUOs04XcBYmYH0MHybLgsCEKVCV8dXKxcUXZFU4EWfrS0/DKXzgi4AZ13vLZl4ikR3CevtpLbmS9KHCEQD5hds3+sDmethE2SRXmABbLg8+gt1WKvLdU1KSyWpQ3dO0LG1t3o1PSALDClUpDzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+xccKA7oynR/jlXck4LGDeO6eBqRJzmS3MuKauLfmo=;
 b=WmRZVvZkPIzAXHSWSQbGL6e7eDadxObKlHoiRcHT1ij01cbztLpjdEQjpMBoIBwWTBl1kLTeXk4VWzw7zX16VzrRf02v21ynsY1F/LBAjQg3zp/4k2b7sVc3jvHnuUU7qsWaWoKVQNJ7iBxlIO7QVqpyhHHk4LGnWUEqGmdI8CM=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 22:08:38 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::26b:275e:95a8:c54a]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::26b:275e:95a8:c54a%3]) with mapi id 15.20.7025.022; Fri, 8 Dec 2023
 22:08:38 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Chander, Vignesh" <Vignesh.Chander@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: xgmi_fill_topology_info
Thread-Topic: [PATCH] drm/amdgpu: xgmi_fill_topology_info
Thread-Index: AQHaKW9z0FZKxjvHNUiMahTWlKQnObCf8t6g
Date: Fri, 8 Dec 2023 22:08:38 +0000
Message-ID: <CY8PR12MB7435AFC5054F3B0132849E60858AA@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20231208004211.3720802-1-Vignesh.Chander@amd.com>
In-Reply-To: <20231208004211.3720802-1-Vignesh.Chander@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e91fb063-77d3-419a-aaff-f0369279b5a1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-12-08T22:08:16Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|SJ1PR12MB6169:EE_
x-ms-office365-filtering-correlation-id: 2b154483-6cc6-4699-9cfe-08dbf83a3adc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dkLwaAvvuGBmNIFqxIAsfqSEtfRXk435dC37rqDlXrbIcvuDfmNmnWJusGRCRrw2sgO2Xmbv2JkqBs2Xp+nopDgXE6ZNdluGae1m3LzA4driH0jAEiGwOd9wPM/hlsDP8zF2NR7+snGUBtSwVTSw2wME3YOWPNyqi83IBF8Sev7XDctu6Vy3hnsN184LE5UyIZbd8c9qP1md7tg8eA8oBDcnuptkv8zZir35D59hDkXn53bo1EEQkeMVnSU0nlXntHgQEHBMLbUQPpu9jpcBLXnEogbWLZi+cAFjRHKSAMRu/1WZ/VbXck37FlrbnU8X/B2k98XcgYqCmjeoG5K6gi403dGTnLZGUVC1Ep2NeafzIRSLUoMe79DXVfAw/fm93jPaz2BAxjMsBnhjSBrkV2/jyjvyuvHoKZbLrTmLK9SHoNnnNEdLe1CZzoIg8MOOH5M38lYUxtCaW8SPu5iWbW+3/uj4AqAWGr84etePU18fj+wzel1Ln6CxtkkyGQ6LIg23/ICnZh5j0xtiDPZquxySmoMEr2fp4eBwWg0T5nY+vVnxiSRWNWwPTawkS2q2c5CHb8RxImm0WhAALWILEm72B72GXf/gVZ7XKnj6NVR6LHMsIm/aHdfaFCXToe99
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(136003)(376002)(366004)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(33656002)(38070700009)(55016003)(53546011)(26005)(71200400001)(7696005)(6506007)(478600001)(4326008)(8676002)(5660300002)(8936002)(110136005)(66946007)(316002)(9686003)(52536014)(66556008)(66476007)(66446008)(64756008)(54906003)(76116006)(2906002)(41300700001)(122000001)(38100700002)(83380400001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SaiHKVB/tRo8Y7CNCoP33mt/GrxHT8DW5RLk0BXLKLPBDenhiDc/cSpVF3qq?=
 =?us-ascii?Q?8DYUeHCL86qE0cEVhIHmZgZglWrF8Y/mQ9/qm/XTjjncpaWRuJeEdT5+gsej?=
 =?us-ascii?Q?lAHeP8C7znM+9nH2jWOJzj7L25yursi17bZUDQIbIcrP7sZB/+4n6ydkN6tZ?=
 =?us-ascii?Q?iexPUCc4GOmgEna5xMdVyALYbzMubBnhg+eOW2uYIgK4mdpTZ/PXpMXbYrKu?=
 =?us-ascii?Q?vNHOg77XL2p7stifX0GTWUBsnkydSEZJoQbIhCpJwWO/UajV5K0pilQI3v7l?=
 =?us-ascii?Q?ZZlkJznvUqJ29UB2IEAK2diFsRu26c/Ez95BjdH6ONNG4XXWc22XQzAieUZT?=
 =?us-ascii?Q?25XdilMJ03UI9hq9hTV4XH8Pw8YL2WbqKrrcz/XfavCoJVXEpGEAfl4z9Gj1?=
 =?us-ascii?Q?TS7c0dHfAqzx6SQnQvCEa9TDzGiMZ3yIX0YO3Rfp8cnGgSet6eoxuSf8FysJ?=
 =?us-ascii?Q?OkY4WWjO8soCL5D8heaHL92j4/jKM2PoX6ptmW13pNqCqPDzFIuBVjmGm31W?=
 =?us-ascii?Q?NjWJksrZCx6pxri9yaVure+4PhFXtCrSUL/62KuHuBfLwsiIf5b21Fr1Skjn?=
 =?us-ascii?Q?iEjDpFrqrzaSgInZSdxhXbi86A1ylofzbU8a1oHdMGH59lVLsuuym0grl11Z?=
 =?us-ascii?Q?d0qn5lz7UvRRw53v/8D+2LX4xzFMTmGxfvZcR45eAbnTKEdOnwis/exg1Q4k?=
 =?us-ascii?Q?+1WuyAIF1pt6g9fBEsxgpfhPQVlMABwQYWPEJYxP+d+w7j2kfbPZ9T7+Dufu?=
 =?us-ascii?Q?moymvfopRlhNsWGW7ynaVgs/mq+HOsIm8wzia5tGtgjBRIzei4wwg9HoYrIO?=
 =?us-ascii?Q?2IeAoZ8ZmosnqNRhFVEiEYQg5FrUVyLRRt65ELtZTIMIabbXdW/YSP/dthpS?=
 =?us-ascii?Q?dbfxSlizDw6uQUmMxbiBuOoDBT1uqR7XGJuf/vn7gakuBYGvwtoglkdCCV9j?=
 =?us-ascii?Q?t7hUimgs13UrG0Lfe63q7cHJxS9odNzaCbrBIEGs+mKZ5tTU1GqGtws+Qfea?=
 =?us-ascii?Q?CxqYMI+b+IVeJ8F42D3OOXVaAh6Ksn5jed+LI57eSj/crGzzmvByaCLpaLtM?=
 =?us-ascii?Q?scvVQTxLvCFNawizUY4iR8PouQzSJ2BXXHzILe7PDt7cuL+yUpykwKZOAwnt?=
 =?us-ascii?Q?NcdR2d1H4pIa+gBJWxRv1dKYrwDnMQktsdfTSPniHTfAa/ci0785H27PoGxd?=
 =?us-ascii?Q?FGNd6r+XcAcW2u9LgCmzbQBHqXhCPgSQVnegqPw1O6fifqx+MAjpuhB7TLlg?=
 =?us-ascii?Q?kbQrC8bdafOe94UUoXmoKOrBaiXBVSLMk0dJHEFmpvxFmzfuHaqj8wfs0y9E?=
 =?us-ascii?Q?AIN686KRfaY6iFkyDEztnYcH7X7pvL5mE9VzNHcXsv7B7qDshuKDmqNBWfKQ?=
 =?us-ascii?Q?wV6KLki057xgB9cJg7ZLX9ILYqUDwPzUfNUryPganVZH/MVVo4mBMJb0et88?=
 =?us-ascii?Q?1AR4h/fFGzysDr2NJZryVheys6qRIN0xyXgjMKm0BnxyYVWqDTsrVg/Me/Kz?=
 =?us-ascii?Q?JxKSbBrRE5maDXYKV3oPwKCaQxD+wXLelliOFVAwB72W7igH8aX2B0WEOSyQ?=
 =?us-ascii?Q?q6mHcUc3uNcU2gEF82c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b154483-6cc6-4699-9cfe-08dbf83a3adc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 22:08:38.2162 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VpQrhgOxri7jKwtUqSzFiEbwZy86cUqv9PdvpIg1Cl3KcOgc5HRH9kxqZliavIkZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Luo, Zhigang" <Zhigang.Luo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: Chander, Vignesh <Vignesh.Chander@amd.com>
> Sent: Thursday, December 7, 2023 7:42 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Luo, Zhigang
> <Zhigang.Luo@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>;
> Chander, Vignesh <Vignesh.Chander@amd.com>
> Subject: [PATCH] drm/amdgpu: xgmi_fill_topology_info
>
> 1. Use the mirrored topology info to fill links for VF.
> The new solution is required to simplify and optimize host driver logic.
> Only use the new solution for VFs that support full duplex and
> extended_peer_link_info otherwise the info would be incomplete.
>
> 2. avoid calling extended_link_info on VF as its not supported
>
> Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>

Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  |  4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 58
> ++++++++++++++++++++----
>  2 files changed, 52 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index a21045d018f2..1bf975b8d083 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1433,8 +1433,8 @@ int psp_xgmi_get_topology_info(struct
> psp_context *psp,
>                        get_extended_data) ||
>                       amdgpu_ip_version(psp->adev, MP0_HWIP, 0) =3D=3D
>                               IP_VERSION(13, 0, 6);
> -             bool ta_port_num_support =3D psp-
> >xgmi_context.xgmi_ta_caps &
> -
>       EXTEND_PEER_LINK_INFO_CMD_FLAG;
> +             bool ta_port_num_support =3D amdgpu_sriov_vf(psp->adev) ?
> 0 :
> +                             psp->xgmi_context.xgmi_ta_caps &
> EXTEND_PEER_LINK_INFO_CMD_FLAG;
>
>               /* popluate the shared output buffer rather than the cmd
> input buffer
>                * with node_ids as the input for GET_PEER_LINKS command
> execution.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 44d8c1a11e1b..dd82d73daed6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -823,6 +823,28 @@ static int
> amdgpu_xgmi_initialize_hive_get_data_partition(struct amdgpu_hive_inf
>       return 0;
>  }
>
> +void amdgpu_xgmi_fill_topology_info(struct amdgpu_device *adev,
> +     struct amdgpu_device *peer_adev)
> +{
> +     struct psp_xgmi_topology_info *top_info =3D &adev-
> >psp.xgmi_context.top_info;
> +     struct psp_xgmi_topology_info *peer_info =3D &peer_adev-
> >psp.xgmi_context.top_info;
> +
> +     for (int i =3D 0; i < peer_info->num_nodes; i++) {
> +             if (peer_info->nodes[i].node_id =3D=3D adev->gmc.xgmi.node_=
id)
> {
> +                     for (int j =3D 0; j < top_info->num_nodes; j++) {
> +                             if (top_info->nodes[j].node_id =3D=3D peer_=
adev-
> >gmc.xgmi.node_id) {
> +                                     peer_info->nodes[i].num_hops =3D
> top_info->nodes[j].num_hops;
> +                                     peer_info-
> >nodes[i].is_sharing_enabled =3D
> +                                                     top_info-
> >nodes[j].is_sharing_enabled;
> +                                     peer_info->nodes[i].num_links =3D
> +                                                     top_info-
> >nodes[j].num_links;
> +                                     return;
> +                             }
> +                     }
> +             }
> +     }
> +}
> +
>  int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>  {
>       struct psp_xgmi_topology_info *top_info;
> @@ -897,18 +919,38 @@ int amdgpu_xgmi_add_device(struct
> amdgpu_device *adev)
>                               goto exit_unlock;
>               }
>
> -             /* get latest topology info for each device from psp */
> -             list_for_each_entry(tmp_adev, &hive->device_list,
> gmc.xgmi.head) {
> -                     ret =3D psp_xgmi_get_topology_info(&tmp_adev->psp,
> count,
> -                                     &tmp_adev-
> >psp.xgmi_context.top_info, false);
> +             if (amdgpu_sriov_vf(adev) &&
> +                     psp->xgmi_context.xgmi_ta_caps &
> EXTEND_PEER_LINK_INFO_CMD_FLAG) {
> +                     /* only get topology for VF being init if it can
> support full duplex */
> +                     ret =3D psp_xgmi_get_topology_info(&adev->psp,
> count,
> +                                             &adev-
> >psp.xgmi_context.top_info, false);
>                       if (ret) {
> -                             dev_err(tmp_adev->dev,
> +                             dev_err(adev->dev,
>                                       "XGMI: Get topology failure on
> device %llx, hive %llx, ret %d",
> -                                     tmp_adev->gmc.xgmi.node_id,
> -                                     tmp_adev->gmc.xgmi.hive_id, ret);
> -                             /* To do : continue with some node failed o=
r
> disable the whole hive */
> +                                     adev->gmc.xgmi.node_id,
> +                                     adev->gmc.xgmi.hive_id, ret);
> +                             /* To do: continue with some node failed or
> disable the whole hive*/
>                               goto exit_unlock;
>                       }
> +
> +                     /* fill the topology info for peers instead of gett=
ing
> from PSP */
> +                     list_for_each_entry(tmp_adev, &hive->device_list,
> gmc.xgmi.head) {
> +                             amdgpu_xgmi_fill_topology_info(adev,
> tmp_adev);
> +                     }
> +             } else {
> +                     /* get latest topology info for each device from ps=
p
> */
> +                     list_for_each_entry(tmp_adev, &hive->device_list,
> gmc.xgmi.head) {
> +                             ret =3D
> psp_xgmi_get_topology_info(&tmp_adev->psp, count,
> +                                     &tmp_adev-
> >psp.xgmi_context.top_info, false);
> +                             if (ret) {
> +                                     dev_err(tmp_adev->dev,
> +                                             "XGMI: Get topology failure
> on device %llx, hive %llx, ret %d",
> +                                             tmp_adev-
> >gmc.xgmi.node_id,
> +                                             tmp_adev-
> >gmc.xgmi.hive_id, ret);
> +                                     /* To do : continue with some node
> failed or disable the whole hive */
> +                                     goto exit_unlock;
> +                             }
> +                     }
>               }
>
>               /* get topology again for hives that support extended data
> */
>
> base-commit: 44cb338138f7670ce2e1f8b9ef14e32c6ace282c
> --
> 2.25.1

