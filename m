Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9254CC5478C
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Feb 2024 16:26:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 017A310EC5A;
	Fri, 23 Feb 2024 16:26:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zgkLX9cr";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C24EE10EC5A
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Feb 2024 16:26:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K54HS5aD3cVmqB5qnVHnFPCE8S3QUida7KVL38LAQRhAqWHWRmAQN7JgzFazTe7rJ5q3960Ty82zodLLCsxxXz88M29itgf+t+vKZpW1D1XePXQjGZgKyymY9RmEB1TzDd72RgTd2gmbt2km+1D+POXg6zb9uOIOxlqq1eFRa4t/5sc7UVkNWgSAPMul0LhXbOZX7vv14UgJyJn/Wac7pE1PoFv3ZC5fi5rBR1yq0LNj0vwDnfvW62En2aXd0cLyIXLe69MiZjvZI/JF5oQ9sCfE0Dv+L909jU0dHqOhdKmnLpgZZnzHoCHbqXbI7YLl51NFgM1O70jB2fldmbEiVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxj/IRkq1Ns2AdVcahQFmqZtm6ZpIDvbXwP5gTRprkU=;
 b=KcLnXXJI5fRlezNFv7xJyZXckpMGke9yayrCZnaWhDIobSaWFCy6HRp0gFsYexoaIh426dBXHiZbKMpa+KnM9PQJj4YptSw375kNFxgMtQwTCzxYDtlX7Ytqma/23eXTjIZiZKqCB8lHNpk871PDf6TJIRu17cBnixjlsYTMMf98fFqJdlKGl1i1HwTfR7D8H32qmZk+IANYGVq2az+CzQKUumgp7aKwaBd912xJVZxt7C/f6jRv3n5HcQFZSDHYeD3QtY0m5tyUkk9ODcdqxSFcMJ+n2+DciphnRjfdQ+AEcJJfyk3UasaRgF2QHBATL8X+8f0XRbroVD9kTTZ3tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxj/IRkq1Ns2AdVcahQFmqZtm6ZpIDvbXwP5gTRprkU=;
 b=zgkLX9cr3d2eLR4MVM48NJLLy6awDZ13HOzFDFWBVqioBntjzmg14rrh69nDYqOLam+jnjfHuPEqQbLKsbiyOBwQgssGc2dq/j03rZeVORYCSeFNLGOWj0iLRQC0Vlj9iK1/ttkI4zNxyR3mQF4noQV3DyrUc4C+IMk2hJwx2iY=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 16:26:25 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::2b86:edd8:2dbc:41cb]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::2b86:edd8:2dbc:41cb%5]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 16:26:25 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Poag, Charis" <Charis.Poag@amd.com>, "Cheung,
 Donald" <donald.cheung@amd.com>, "Yat Sin, David" <David.YatSin@amd.com>,
 "Chaudhary, Jatin Jaikishan" <JatinJaikishan.Chaudhary@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Add partition id field to location_id
Thread-Topic: [PATCH] drm/amdkfd: Add partition id field to location_id
Thread-Index: AQHaZgtZNUkO0RFwZUqDhfEYzemGC7EYHcpg
Date: Fri, 23 Feb 2024 16:26:24 +0000
Message-ID: <CY8PR12MB74354221448F758A6F13FF2C85552@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20240223034926.151031-1-lijo.lazar@amd.com>
In-Reply-To: <20240223034926.151031-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7f70ed94-3a74-4548-a3b0-069fa05486cf;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-02-23T16:26:14Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|MN2PR12MB4111:EE_
x-ms-office365-filtering-correlation-id: 10447493-f825-4140-e4f2-08dc348c2de6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xUvryYA/pUEt9J5or9qMcJlGPzkEqPyiwPikChjB9T88EkKxM3PdzrUWCpc3k5dc2GvsjerMEtYkd3sOF/XATalmCw51NtIcfZm74H/nnH5MDzu3HcuqpWAAgBHycmBQbmH0z+dueuhkdZ/4BcnVNNwpAl6eB/ulJ2aU76DWQ3U0cXbHLBwQ41rYFXfQnsMnoHVjF13YLvz138puWusAp3q8JLB+bJP+qY3gBkIy4/JHB6ZMZJxRcX57a9NUaImszDFaQLkOcVGmUojTBnxt8VgAHG49wKCd1+Y1Otjkn5GqMDAYx/RlkNdyI8HHuI8cWoTLAUVOcETTafUgbaRxavrhWErK3d7YNtJYc/6LY14X+/DNIF717g0S8YIrBLwUHnL5hnsnlF4vJR5RiLbxl4+d/Le1TYZJ79RKsP2OGVogKa1zaloEhUez2ZYAu6hh0OGD6It9XBOEdV2mIx9t+PpO43+URVMkT86+Q8Vpxu/jgl2cdg3U+maHku0sVRnRQPvLeOGPTu7ZIlKpo9TaZMU3BoSWZX7HPQxIFZ4tyfSXoPsfHdqRM9ZRvDFOMqeqzP23dXqOCTE7qQyaxM3zfF5kSdnCy5mzst7cNlDapDSNaKoFs77uFA6oy1RbduG7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0vXDIBInJSU/pP5KicboJY4V9DBktm1lQNJnTh3gCKoYze6836OgBVx02i49?=
 =?us-ascii?Q?EwKjpCSZF0fdPbc5lcUH8n9y1ugxpp1jepPN/Tf5lwffGXC5Uz9PTFE8ep/G?=
 =?us-ascii?Q?LfFV+rOI4iHy8jUKc+GoliOgUrdee+qW6URkH9EqwnQu/6blacQSZ3JvOky1?=
 =?us-ascii?Q?rwiya0c+Me2hHDVvVfACZLG2n7WaVnPlPDFpBf8lpwFKZve2qS8KNSe9kaiD?=
 =?us-ascii?Q?zAfzfhuxHIDETqmS3UmUD5//eztV41RwHulFHXcAabkG2tvRzSk2dXapuCVs?=
 =?us-ascii?Q?i3UzPBnZ7Z3V3MDpgmwAobFEcaEcBbDA2+m/aZqly3+t2a1wdSnakjtgSUa2?=
 =?us-ascii?Q?r8tMf2T/JXeT0TdThPYQ7ec1dlEEicF2WJZJ+QGGAGFSdxaJc858Li/XrctB?=
 =?us-ascii?Q?G36ahj6rdZyg5FBzPrYi2PUL1fvSlGdWlYurE00QDe2KqnZc1d7ixtl+Q8KB?=
 =?us-ascii?Q?NrZGge/+69+Gt9xuipB98NFTRJL8R0MK7wlyswPc1ngCTMaN9yEqfs6oBSnP?=
 =?us-ascii?Q?qIByuIO9dDfhpkiloLCMPjRmZ/R0OqF0oYffQ+5PREtGIo7zoAgTXLSinqxl?=
 =?us-ascii?Q?NNnKQLjF18XHvVMHMCyvZoc5mN+SJQYYmDCCNyRMEgaTe23KbCMcOX+vVg43?=
 =?us-ascii?Q?LLXUDNmuQiCNSHQ/C9wy2CEPENS3x2/ftMApVE8W9F6/8x4Fx3jtOceJPqiE?=
 =?us-ascii?Q?rzKPVAiRlZKe7A2CewN9jQIsoVjYUKwe9rw8K6VSuaPOc/wWlEubdzzK7gbX?=
 =?us-ascii?Q?OBUfvdk0/fEVPuH/X/ERNjTsJ9RPhWl7DSzF6Q8vtGUZ0tlgnafUn3TdM2Vw?=
 =?us-ascii?Q?P3N70FatOmGVeM+b0IyehpJi0fH1kvyLJKKJta/2sIx0W1vCbWPkzKoKdlGH?=
 =?us-ascii?Q?6RlSnBNwKD+s6HTvuXo5+12crg8Db4L8bfeLToEed9skIGPd05YDESyHunqR?=
 =?us-ascii?Q?gbKtykthr5mnlWpf8t1CYekDf8KwmlurHtvRe/Au3SdlyyaRy2hSo6O9QR3t?=
 =?us-ascii?Q?K/6gA9aQxQAfCMxKKnDNo6mfYyvaJt+MFFe6qhvC32LCWGfZEbrNNM//AMJn?=
 =?us-ascii?Q?28bOKrTONmaWZC4ScmwysftH8jTCliFxicT54H4eTY0tOmpn4ROfnBDvAD1/?=
 =?us-ascii?Q?DFdGw+zWBbeaoBWFlp3PkXVjpkqeTAxFMq0xBqX5DCndFdBMhZ2oJUR/mYsN?=
 =?us-ascii?Q?KtI9jMgf+GDYr3w3dSfuMOYLG33LrrL39HHVY6YAFlQoGiG8f2srLZuEtrvx?=
 =?us-ascii?Q?bfcjNCj0s2Js4y8kbtZsTH+kUrG7dNmniaHPbmYZn+WYTuxbpLiDTq8bwbc5?=
 =?us-ascii?Q?IeWC78G+ZOR50LPW0adE+zbQ428kU8Rn1RbPBen3175OYPSFvLwb0odZC8I8?=
 =?us-ascii?Q?v1zhBtfPMLy3jeP5bjzUIikutlUcLRD6u9ckM1urWcpZqprw8F/yXeRnBDkg?=
 =?us-ascii?Q?qeYd6vb/T4sAXZkso5/b7jx/Tssmmq2ldz3BFa2ZVYZUccOF6ytWTlWkGzur?=
 =?us-ascii?Q?ve1zoytIrX8uCal3d5vKGMcPGrVjWJipiMV/uKS0C8R49fJynyJoIZIZhJsi?=
 =?us-ascii?Q?bdI+XNduucgB0ZD1XGk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10447493-f825-4140-e4f2-08dc348c2de6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 16:26:24.9643 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FCXrQHGijpfnvjq32QCL2DkBDRPDlDNDlquPN4X7m5Pw+lyb0HgZY0lzpoer0jF9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
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

[Public]

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, February 22, 2024 10:49 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>;
> Poag, Charis <Charis.Poag@amd.com>; Cheung, Donald
> <donald.cheung@amd.com>; Yat Sin, David <David.YatSin@amd.com>;
> Chaudhary, Jatin Jaikishan <JatinJaikishan.Chaudhary@amd.com>
> Subject: [PATCH] drm/amdkfd: Add partition id field to location_id
>
> On devices which have multi-partition nodes, keep partition id in
> location_id[31:28].
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index aee2fcab241f..0da747d52975 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1997,8 +1997,9 @@ int kfd_topology_add_device(struct kfd_node
> *gpu)
>                       HSA_CAP_ASIC_REVISION_MASK);
>
>       dev->node_props.location_id =3D pci_dev_id(gpu->adev->pdev);
> -     if (KFD_GC_VERSION(dev->gpu->kfd) =3D=3D IP_VERSION(9, 4, 3))
> -             dev->node_props.location_id |=3D dev->gpu->node_id;
> +     /* On multi-partition nodes, node id =3D location_id[31:28] */
> +     if (gpu->kfd->num_nodes > 1)
> +             dev->node_props.location_id |=3D (dev->gpu->node_id << 28);
>
>       dev->node_props.domain =3D pci_domain_nr(gpu->adev->pdev->bus);
>       dev->node_props.max_engine_clk_fcompute =3D
> --
> 2.25.1

