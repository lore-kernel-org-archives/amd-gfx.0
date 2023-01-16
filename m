Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53403C46467
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jan 2023 01:03:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBBC310E119;
	Mon, 16 Jan 2023 01:03:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2854D10E119
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 01:03:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+G2Mw225FCoQLSIw9OL85jMQlFA2srm/cohcdbuwuImty9sQbnL+5NeHGqW5abgkIcAAo4UUgUsh2JB3RZ8oTRQqJuNT1EtWdSUz+oPF6xROc29esBri720V21oKEP1Q7TNolPHBg/bygBSto6MIwDBdTUjrpRY7K+8m+O/AkKernkAencjdNjvoxjJ9c0acySsob2fFSIhKCijOrZ/j0jG8D7xXfnr6JQmABys4JN8L8ODS7HQJvWLhfkDrzbdECPVT+f/CgtMsRmgDLxgfGURRT4BQYvunZKWYrGUgx+j1C5EP6FCWy+bD/HCEjGOxPIzDR78SDHOj3vOq7tcWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnKmohdJ3Je7KzOsYsjXCVpijTmH+lidYW0jIEwGh7w=;
 b=DREqx1aoL3hKrxeUqk1gtwqkhzvTDXPldq7DpHVAhuAhE6d+B2o5u7IDQ5B1yXKw9eywK6Xr+l7s1xJMeVnSihuBvyQBhh3KNdYs8jjAslK31w9Hh2Jqxum0fhBdmxJ+bNoqITFbOsXdai68JiiazaVARhNWsYjrCmwe8hjA6Gz3lZNMyAHIW2bVoUGOk7IIwjE1gRFmeLrJ8sbNTV8ZAERRQlp4IwYQGaefDAf1a0RqEgBomJRsQj3p7VL5PJnQk5LbmYxAONgUWibk7KUOqbwRh/g3d155Ik9DkLBkZ8SLlwrnCnsGnEA+eB8xe/P/ICL3NYQWnfyvtAdKwGUQdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnKmohdJ3Je7KzOsYsjXCVpijTmH+lidYW0jIEwGh7w=;
 b=v4fOfI9gbTNZDZJhefdFA32Nmc9PQM1dcIZd4B6QJJG3FlXPWryMqrUgDm9AxtsTf/1av5rG4gCj9CjuIxPP3NuoZ2Ocyc4W2LhMguW+2atNxz6ctkUWtn0McI+xGhm/Gv5M+iXPETqEUt/JGy4xb02ic873Mk/L9sSloMnG+DY=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.19; Mon, 16 Jan 2023 01:03:17 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::956e:e4cf:6a8d:3f13]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::956e:e4cf:6a8d:3f13%7]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 01:03:17 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/pm: update hwmon power documentation
Thread-Topic: [PATCH 2/2] drm/amdgpu/pm: update hwmon power documentation
Thread-Index: AQHZJqJvJDvtOQf81kWzICbUupduJq6gP1RA
Date: Mon, 16 Jan 2023 01:03:17 +0000
Message-ID: <BL1PR12MB5237DAB61F49CFE50C3AF34FF0C19@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20230112162443.603552-1-alexander.deucher@amd.com>
 <20230112162443.603552-2-alexander.deucher@amd.com>
In-Reply-To: <20230112162443.603552-2-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4cf3863b-1e3e-4676-be1e-0737c27323f6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-16T01:03:09Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5237:EE_|DS7PR12MB6144:EE_
x-ms-office365-filtering-correlation-id: 82e95205-8b55-469b-bfc3-08daf75d73f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oanzWByyM/T+f9+OkImprHCi4RnxKU+hlHR8R8f+4adkzxA5EyWi6pjcucahOOkR8eN+bBA09C0F+fHHN/5RS0LwMvigT+d+6tVjajtcAW77EmQHzVgHyA8uArUmWpmYujXk6QREAxE9bsZpiZOa9AoWPwMaGaZMQfjFohDSgWTj4vZEdprVLzKZHx+HumM+OM07WYc0pZJfwpgI6nF0joPobSFNrfIyp71zoCQ0uSPlPdYoePMpA1ZFcyVSrrPRsYXdnJNiJHqJp3sdvMtObkGt2zmtF058ns0YN2lSIH/bxeo30rGzNg0ChXkjBlhPs03cUXRZC8buzc1bbJud6hgFnMpxd0e5JZxiRhwFL0Z9VPiF1iU8c27IQou9mUpeTsh5j/8oCN2vjggac+gzjCBRMp03I69I6NW7rbn3IbVjLxO6PKSZ5YMWuBbco0P5+Go1AZgf0xsfwVas3JV2dlUr/x1zIrROSliu2Sp8aiKvib0Y0WLeKu8NTdO05tGBeRdl5xx7jH+dPUMBbJIcm0l10uTQ8WT2wOht/ps6PrzJOL4HaQHj1N/hzQ7EhtQv1bsTif7C6H+yCmDuZaOpN9KciAWoUe0gvRK+HDQRWjwsYf0dS9M/oB2Bh63DiR7Qy7SDP75Hgv1SQY5Tp4AczrVNG4gbZlFl5Wj7qevVRC4HsgHwKzfveTReWegOMZKS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199015)(8936002)(52536014)(8676002)(76116006)(41300700001)(66476007)(38070700005)(4326008)(66946007)(64756008)(66446008)(66556008)(316002)(15650500001)(2906002)(33656002)(5660300002)(110136005)(9686003)(26005)(71200400001)(7696005)(86362001)(478600001)(53546011)(6506007)(55016003)(186003)(122000001)(38100700002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HNxiwcvthTZXzZFStyWcO0zmE6Knfb6Y2ElPJP/Mi1/3lNebseDFp9iMqSxi?=
 =?us-ascii?Q?Q4A92JW2w2H3yD02oHAYURFcq+ArCJeLLbVsCjsK0qtN2aYNNl9zj7zWeYWV?=
 =?us-ascii?Q?alr2qjqWRjhpZ0k1oVafZgzuzUVrGZvFk5hZoW54/1J9FCi2DkEDWaTNOQds?=
 =?us-ascii?Q?iM5BiopJ6GabpKt5rVS0mKmRArlSSFS7hm8a26Sbukv/TLPgRjoj5fLgz+tS?=
 =?us-ascii?Q?ArROpKATX4qdOEzffT/NVjJz+66/UJ1SpYLhjJUQG871Y6YRAhBDqbMxCMaV?=
 =?us-ascii?Q?HH7xAPrKfpSPY4h/ShLg95QsLdwsCY1CSuRc94IIyCKfg9ykEglJLdNBAwHP?=
 =?us-ascii?Q?5Z0DYA2xgGytZXcUQyqe9es8pJwXB9efv49Emx6D7ZweWabZ1YoMxpM2fs4S?=
 =?us-ascii?Q?3xXuUfAPOGATgCll5udCE6xc/HsCrpIaK7BYD7jN0sTxn0vf3g7jCe1dCtcB?=
 =?us-ascii?Q?eXI43TlFDBU6krqylzMpnSg8e95gDAv5xuJPoYTNERJ7PY1v9EQvok8PDBq7?=
 =?us-ascii?Q?+QwOAHE9zhf66QFRrFpzfv9KvATptLOtsPCeBpb0cIQ14md3Npc3i9x7MSLH?=
 =?us-ascii?Q?+vevSYB9O0bJbzE7SBvNpIuQgKjfvgYISO+NeaXxdhLnyXMmtZNm3QKIbSk7?=
 =?us-ascii?Q?eqNRYZ6Eq5YszuIgbS+jsUhHFfZq9GfmiM8OloceNYGFz/oYe0SR7UGfLnjZ?=
 =?us-ascii?Q?kx592PVCIaGbzeTa1Kl1HACUPwxGTLAL7rl5zMBSBWbsjJRutaSgqNMp8Ay9?=
 =?us-ascii?Q?oUmLrEzSOTFaDUpHQzMGnuLCGoUf7HpR4o+WeGkPWk0+h+KQMya4I54pzCft?=
 =?us-ascii?Q?z4OvciOtbLzK7c6iIQwVXrWQ1KCW+5m8sEEb0q5+qQi2u6mx2Yqh7QWsz5PH?=
 =?us-ascii?Q?3D73MD2Mx8SvYCdwgWDGZt89r9e/DksF/t6tI9g9D63Lrf6QPPcvVv/OT19F?=
 =?us-ascii?Q?p8SiDnLRLWNw3usA8yPvzz3KSq2KNfP/wD2tb5fEqSWhvLcRGRNCltsel2xf?=
 =?us-ascii?Q?2HojvS15+NnEQT2CHXh7ToBs56XIfvN0rczG5xFWAE8KQkw51LpigvL4UyJV?=
 =?us-ascii?Q?i2nV1Pm1OxdaV2/3Su0jWl4426JqDp3D2x3oxi5eH8RYvgnh8ZFBvfAPdvlR?=
 =?us-ascii?Q?jDVLArFzve8OY8jqppLDIXwJZ/N5p/EtawMDdpTV9QQPZDc/48cECe+xlgwn?=
 =?us-ascii?Q?Sqw/9u9YQ6qDe77qj1Tps6rtV87xHN+yh+UcnBBQdzAEwQntlgOppSGiJzTc?=
 =?us-ascii?Q?LFg57eZ7kaF/BluPIauvt2U+ERkvG7y4YOOxRYS/lhb1ApvjfbrKTWvbOAhG?=
 =?us-ascii?Q?F1HSWBOq5Dvvjj8wzaOofVuFSomOoa974DEud2gZ/mQPAYKKf75+AkgPY8uB?=
 =?us-ascii?Q?YFtkJyWMJDD3CjxabvJ2TOi4pT3cL4VSlcH/I2/X4fko3xz0r0+drAiopGLP?=
 =?us-ascii?Q?Q6zkYw/Nua+4hUULNVS0/wAdmJH5nHQ0ofqW9ebwnjRiluwZhXhN3WIXvSFY?=
 =?us-ascii?Q?U6t4kBlxUoYYabisJw31J/xQYyd4lG3ITJ5krXpEBSqJVdcHiTUFzB7Y5Toc?=
 =?us-ascii?Q?RyuhEIRnd10OKMSCj2Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e95205-8b55-469b-bfc3-08daf75d73f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 01:03:17.5578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HGYhv4SKqnCw0cbchsznxBR5jqPP2FNVktaGRUxQnW9nsQohsyb95dcQ1Mdj7KkE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Aaron Liu <aaron.liu@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Friday, January 13, 2023 12:25 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu/pm: update hwmon power documentation
>
> Power reporting is socket power.  On APUs this includes the CPU.  Update =
the
> documentation to clarify this.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 236657eece47..76b9ec64ca50 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3059,7 +3059,7 @@ static ssize_t
> amdgpu_hwmon_show_mclk_label(struct device *dev,
>   *
>   * hwmon interfaces for GPU power:
>   *
> - * - power1_average: average power used by the GPU in microWatts
> + * - power1_average: average power used by the SoC in microWatts.  On AP=
Us
> this includes the CPU.
>   *
>   * - power1_cap_min: minimum cap supported in microWatts
>   *
> --
> 2.39.0

