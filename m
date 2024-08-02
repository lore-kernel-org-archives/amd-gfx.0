Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F992C3DA7F
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Aug 2024 06:27:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5046010E8E2;
	Fri,  2 Aug 2024 06:27:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5gQ072B0";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 540BA10E8E2
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Aug 2024 06:27:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIWlIOira0u/2oNh5x/wHT8BYE8QERDgutVJR7Qd2iAHs4o9/N8z+k8YU03xFG8YMzr+FluovIBX7ABVurwgfBRYIdmufC6awBXBJJFBmNemVUYceeO3l6PwhN6WYSlJdVxdyNw30One+z51YATxAMMZSQhGGx5HGGhDbodqDAgXHnajV2qwKD6hMNnUQldv2Y9bSJ+lMsIgSFf+fzPZu0pZsbUN7w506zkxFfUh+thG1491TOqrGWhPAklrefovnuUDDo76dvXbomcdsQepxHaksRIcx3H7wnlMH7bTQDsx/yFzfI9B4qzGiFaqswwhuN120cSVCZFmCqA1tfh29g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2izpzxyJEfrQ8QIx1JChQKFZo6lvgp2PrlVDx3+cvRg=;
 b=Ndhy7gttUhI9cyhHQos+CwZsaJdqIDtOmRbBivaqkibaQFZqYTOEmlaeYoiMGIGdmfBzzlsBOyMET+1soqU1tLIX7QEd1tiEHri6fcO5GitH7CbjFkYa7Z+SdN1NPpIjLUiXOHfAd8/Sbgcq9dFYxGGZoIap1JiIREV7DKatqkTkPt/7CUZqOxBlL4r4cklKMLN5OJtVtKPcrVTrsX3ptRCdWG+DSnvgcnwRxn7LlG4zkhezrLbaM3PtFcw0LJn4FHjouNlJulY4gh9Gjxqu1MhiJYs4WbjbIidmiDV6meHKonHku60Up8Jzjj3W+vbhKg3LqV8EbSgyBjEFtPcW0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2izpzxyJEfrQ8QIx1JChQKFZo6lvgp2PrlVDx3+cvRg=;
 b=5gQ072B0yEb4PzdihMT7PU565sm+B7+nDyHgDhObf4nz0HVBMC1Kc+vMlnSqcvgEhxmyJCW8w1UvbxmBn71blPqSrHB1QbPpxD3KTlntdA2sTVerupgaL/vGf2y+JQqJV6Y3tzgqvXn3lp6xqfIp4BMYYH/zrWm/oNhxICZ+ELU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ0PR12MB6880.namprd12.prod.outlook.com (2603:10b6:a03:485::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 2 Aug
 2024 06:27:47 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.7828.023; Fri, 2 Aug 2024
 06:27:46 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove RAS unused paramter 'err_addr'
Thread-Topic: [PATCH] drm/amdgpu: remove RAS unused paramter 'err_addr'
Thread-Index: AQHa5IKU2BGr0HIRs0Go76MijGpDObITgQ3w
Date: Fri, 2 Aug 2024 06:27:46 +0000
Message-ID: <BN9PR12MB5257CDFB2C1BE66B54B7E07CFCB32@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240802021844.2093879-1-kevinyang.wang@amd.com>
In-Reply-To: <20240802021844.2093879-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a679ca0b-93b2-4224-8a76-1c69628991fa;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-02T06:27:23Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ0PR12MB6880:EE_
x-ms-office365-filtering-correlation-id: c0c78844-b334-4817-e6bb-08dcb2bc3978
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?S7Rh3xmTIhWM8gJNoYjB7aocs/ZVRi6q5BhT7Md7DesZX19wYClIY2EInH2f?=
 =?us-ascii?Q?hDLlmV3KtOajjfrdDGo+avP6oyE6ewGNKXmBjtXeK5wcCjDu1wmPFmVHqKp9?=
 =?us-ascii?Q?kx3cw+WuDJ5EAmKaivgubbblLyah/6yeJ+lAswZHMcvkNa2905JCSLLCyzpa?=
 =?us-ascii?Q?1onhaMKKLm3h7mMieFGsTBueRayv845RCgv+VOmoob9coIg0rA2+CNjB24Ld?=
 =?us-ascii?Q?E4F8eFSqqZhjkf2foUuIUsZ0sHMe7yAmxSeoT5Dcw33HtUXPqv3dBueWpyLv?=
 =?us-ascii?Q?6lZKa99PT+FDLBB0XH4c0hEIefq5T5b3xqTme5h8igaE0MtT15GEQnym7kNd?=
 =?us-ascii?Q?a7hT3m0Sks8fYXubaP/JTylnuqdqSS6SVNWDzPIbdVR/+o/UpwPz3F7UtHqb?=
 =?us-ascii?Q?mtyIuFevtjZnkkPzYXy8ByZDCQU6x87u4CdI5zSwhxZwA12faQfb6jYWSDJ3?=
 =?us-ascii?Q?4q1GSpORRCWczmlodHWgtoVX/opDuu/y9g5V28Wvy0qCvNFtp++I1/vX46fU?=
 =?us-ascii?Q?S8U0iG9ljQvXOPTKLq6e5+g4UQPsDlQUZ7124Sjs0Nryl14+M6XoyJKsjYEz?=
 =?us-ascii?Q?eIqIGUJckn8yjlPtav6Iv3nAQo3DOV0uKls/8uMONgO98pUz5z4/h090wp3U?=
 =?us-ascii?Q?cuipY5kQBR6eyxKOGkUEFC+Hbob+Rx9p2xB3hn0/P8udrM5cjLBN52XlH/wv?=
 =?us-ascii?Q?LUUcsvd9KgUOWF8D/ss/UDd0wyxf4mm5NKywscjIcjw7zoPU8yj72l0HqHss?=
 =?us-ascii?Q?wUedD1RJYzrNKybL8oVF1LsvwAnbgGeF84de3Uod+BYvuOBkWa2F2FeqIo+L?=
 =?us-ascii?Q?ph8Safp1XYEgF5nFfMq8AB1to1a9FU/NieqAkaPvycN+wuwifEIY7RdE02Ve?=
 =?us-ascii?Q?67GzLUpnmPQVVxTpWu8cyHpxVRvelc+vBYvA7RF8sHWJ3veZNz+xTjlQQRFQ?=
 =?us-ascii?Q?zeEM0ZP07wKJCPTYFxBBcRmzgxqH+dwdpXvhQ4VBpUttWbm6p0LJQYX30hXC?=
 =?us-ascii?Q?cNcKHJjqRNcrEieVeEwd4kocbesgUH3vAbriY0yvknzKKRMdpnwEPuA7jog5?=
 =?us-ascii?Q?ZEA08SOVjrzGSeR1vLDE859PPjYLvRc+3wm4otGBSUOJrc0sIgUY30/Yu62t?=
 =?us-ascii?Q?eDMxP29S/V8n5u/YlSz8zynYkFYl0KUajD7Q1cWI8blzsivZPwBKCbDLQ+7p?=
 =?us-ascii?Q?dsdxU4M3nb3VBB/YcxqMzJwOmjUupHTyOKK8Rd3FljG+iVEgFEDUfqmyZp8l?=
 =?us-ascii?Q?Lsj6sNKvPFvyjTLLgGIwXdaihzeCW/Ggr5uNbCovZBu4nX46WPS5wE8lWq1V?=
 =?us-ascii?Q?bmstULpeDkSiUkCOxijCzzmAfFAj8A3INw+2fqxov3qCCv5xoAKIhFYWe0ur?=
 =?us-ascii?Q?Fni+2a+uvwkoB6W/dQEsatYje84T0194j/CpHRAfaVCmKZ8EqA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RBEvJJ3bltT8pCOmUNvdXM6PN0zBFES+kpsv469625+21dlSl0rdjs2tyg8U?=
 =?us-ascii?Q?X7SRwaGOvcEAQjtYdE03KV08Bvq2XUZlARgOQqdj1GQffZIbiw3+PIgWHDOO?=
 =?us-ascii?Q?gZ7BfEbO2rIReDT29WfzTBzaL9dDlRUepBuVgAweru1A1aeNAuHx9sFVmFX0?=
 =?us-ascii?Q?wQ99xMZXXOb0g+4EpVi3T+a9orMGgq5Zeo7KttyjkZq/vHOnZ34toP6WVqU2?=
 =?us-ascii?Q?oTbxAOMWN1ZV5BwwHT35d7e+2j9jeobo/qTK9thpWarBgPDKiZ64GoBrTiwC?=
 =?us-ascii?Q?Y8SGLI/NF0SRdY1WaNSBVDDBT5ZoOya0UeG9i5YRIOMGs5pJtCZLHgfG13OS?=
 =?us-ascii?Q?NDcB1yN0LWIngC7AGQsGw3nbR+xOX+G/42eeMQa7OFmZzr1tjnXZXTbqQlK0?=
 =?us-ascii?Q?0gO1vc49WC83BT9bP6CGjAGeN2bvMKdpiuD0PfvXhtFXoHNqPVjweHBTxCGI?=
 =?us-ascii?Q?XhbxvsfMbW3+g/OqTo9ETW7FhPf9ZggzcQWIxGaZ1RjvOVj39iEhUW3dhKYg?=
 =?us-ascii?Q?Pi6/52YsKAruzekrF0yTqpS+9+fFAgxTzxSTkf7A73FLekYBtZ5Bxf2IgK/i?=
 =?us-ascii?Q?qdNxQ7GcXvlKwuRc1XVEyhVJv8QXnPpgchp/tik8FOYJKl/Cx1mlpNvPt6G3?=
 =?us-ascii?Q?JmBWXJFYJcFWAgEhMIAd23wAjb81xL/8ML2MMkSMxRApd5s0NGx4YyzmYr5y?=
 =?us-ascii?Q?S0fa9q4R96wRf4Nau3PHeLRR/rTyouNSIBh6Yv46FSVdgOF+nOaH3ONg+1Qd?=
 =?us-ascii?Q?q3peAfIJZkjm/LDpw/YqRsXziXhKf4sjcbOIXv9sSXqyG75wVarlZdjuZcEk?=
 =?us-ascii?Q?JepWxxftS3q7JvpjcBAOTJoti0J5wx9liOIlJY1Sv6rL0xP6cqLZp37v9HXq?=
 =?us-ascii?Q?6IQvSkAtgQC3ymQMhBkbNNkmBLIzBgseFSRwAfnDmZg7nI+J2dKOVRDsSY1+?=
 =?us-ascii?Q?wcwcXATAWuQT56g1oJEymTJbURadPioC2HferF53TdAiUzIOAhUEQgjCxGQd?=
 =?us-ascii?Q?v8oVY/719bpfog2AikU/adaXtLJ4B1FfoYhMXj3hJbDhdv+0bSbK45ISVB7A?=
 =?us-ascii?Q?6+RAvbBkcWcib6wcV+0RFM1XXZeTG/KSmZp3p2HC43AdsuqcZm03i/DPicEL?=
 =?us-ascii?Q?59LbNoIBPp4s4dZMl72vxPEnmSe245YD4xAcpnhMXiKplHh8fOkUo9o8Oots?=
 =?us-ascii?Q?cR2w2ksHe8/3R+kQYZjvdxBs8wag+ZXefv8aJy0VNDk7hN/lLuIhAnO9KB0E?=
 =?us-ascii?Q?AOcV/0YbX6uvf1Rvhwa3JFJuL0hg4RcTPSaPh53nMDdfHa+8bW5pmHmpi/Yv?=
 =?us-ascii?Q?S6qO98X59CFLSauh4tOC5EeBIeHZ0tV5OlIWdfdkE4GNJXG50h3X3SUGgV7j?=
 =?us-ascii?Q?InedhaI4SEeUlHPCgoW8azHRJhUheLjakO5xkKXKh4AiwqNGe4HbkcKAzK18?=
 =?us-ascii?Q?dlXcDbABUj/zJd8+zYKXa3yfNvcGgir1gXnS2kiS2pX+D8qeP+jfdxfH+FKt?=
 =?us-ascii?Q?YTWBDIePQBwYt8wxOBzQ1e9oa8LWijfoOikvbaHDO0JPm8SwaPP7wrwwzvBd?=
 =?us-ascii?Q?4HJaS5oAQ+wSWbBNlW8a7aYtt9fSqXizDEeJbyTB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c78844-b334-4817-e6bb-08dcb2bc3978
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2024 06:27:46.7310 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JBY6MnSGl2qdZeGDmxAJyHyN/feh8Q/TFas1k7caO7zVMuxUTX6dIYddB7ntV/Pc8G7st3I6qaZJsG2LwJTf6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6880
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Friday, August 2, 2024 10:19
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: remove RAS unused paramter 'err_addr'

- amdgpu_ras_error_statistic_ue_count()
- amdgpu_ras_error_statistic_ce_count()
- amdgpu_ras_error_statistic_de_count()

The parameter 'err_addr' is no longer used since following patch.
Fixes: efc4009da0dc ("drm/amdgpu: Remove unused code")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c  |  6 +++---  drivers/gpu/drm/amd/=
amdgpu/amdgpu_mca.c  | 14 +++-----------  drivers/gpu/drm/amd/amdgpu/amdgpu=
_ras.c  | 18 +++++++++---------  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h  |=
 12 ++++++------  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c |  4 ++--  drive=
rs/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  4 ++--  drivers/gpu/drm/amd/amdgpu/m=
mhub_v1_8.c  |  4 ++--  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c   |  6 +++---
 9 files changed, 31 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
index 19158cc30f31..929095a2e088 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -453,13 +453,13 @@ static int aca_log_aca_error_data(struct aca_bank_err=
or *bank_error, enum aca_er

        switch (type) {
        case ACA_ERROR_TYPE_UE:
-               amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, NU=
LL, count);
+               amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, co=
unt);
                break;
        case ACA_ERROR_TYPE_CE:
-               amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, NU=
LL, count);
+               amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, co=
unt);
                break;
        case ACA_ERROR_TYPE_DEFERRED:
-               amdgpu_ras_error_statistic_de_count(err_data, &mcm_info, NU=
LL, count);
+               amdgpu_ras_error_statistic_de_count(err_data, &mcm_info, co=
unt);
                break;
        default:
                break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mca.c
index 2542bd7aa7c7..18ee60378727 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -396,7 +396,6 @@ static int amdgpu_mca_smu_parse_mca_error_count(struct =
amdgpu_device *adev, enum  static int amdgpu_mca_dispatch_mca_set(struct am=
dgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type ty=
pe,
                                       struct mca_bank_set *mca_set, struct=
 ras_err_data *err_data)  {
-       struct ras_err_addr err_addr;
        struct amdgpu_smuio_mcm_config_info mcm_info;
        struct mca_bank_node *node, *tmp;
        struct mca_bank_entry *entry;
@@ -421,27 +420,20 @@ static int amdgpu_mca_dispatch_mca_set(struct amdgpu_=
device *adev, enum amdgpu_r
                        continue;

                memset(&mcm_info, 0, sizeof(mcm_info));
-               memset(&err_addr, 0, sizeof(err_addr));

                mcm_info.socket_id =3D entry->info.socket_id;
                mcm_info.die_id =3D entry->info.aid;

-               if (blk =3D=3D AMDGPU_RAS_BLOCK__UMC) {
-                       err_addr.err_status =3D entry->regs[MCA_REG_IDX_STA=
TUS];
-                       err_addr.err_ipid =3D entry->regs[MCA_REG_IDX_IPID]=
;
-                       err_addr.err_addr =3D entry->regs[MCA_REG_IDX_ADDR]=
;
-               }
-
                if (type =3D=3D AMDGPU_MCA_ERROR_TYPE_UE) {
                        amdgpu_ras_error_statistic_ue_count(err_data,
-                                                           &mcm_info, &err=
_addr, (uint64_t)count);
+                                                           &mcm_info, (uin=
t64_t)count);
                } else {
                        if (amdgpu_mca_is_deferred_error(adev, entry->regs[=
MCA_REG_IDX_STATUS]))
                                amdgpu_ras_error_statistic_de_count(err_dat=
a,
-                                                                   &mcm_in=
fo, &err_addr, (uint64_t)count);
+                                                                   &mcm_in=
fo, (uint64_t)count);
                        else
                                amdgpu_ras_error_statistic_ce_count(err_dat=
a,
-                                                                   &mcm_in=
fo, &err_addr, (uint64_t)count);
+                                                                   &mcm_in=
fo, (uint64_t)count);
                }

                amdgpu_mca_bank_set_remove_node(mca_set, node); diff --git =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdg=
pu_ras.c
index 0fb2d9285834..d9546a756542 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1223,11 +1223,11 @@ static void amdgpu_rasmgr_error_data_statistic_upda=
te(struct ras_manager *obj, s
                for_each_ras_error(err_node, err_data) {
                        err_info =3D &err_node->err_info;
                        amdgpu_ras_error_statistic_de_count(&obj->err_data,
-                                       &err_info->mcm_info, NULL, err_info=
->de_count);
+                                       &err_info->mcm_info, err_info->de_c=
ount);
                        amdgpu_ras_error_statistic_ce_count(&obj->err_data,
-                                       &err_info->mcm_info, NULL, err_info=
->ce_count);
+                                       &err_info->mcm_info, err_info->ce_c=
ount);
                        amdgpu_ras_error_statistic_ue_count(&obj->err_data,
-                                       &err_info->mcm_info, NULL, err_info=
->ue_count);
+                                       &err_info->mcm_info, err_info->ue_c=
ount);
                }
        } else {
                /* for legacy asic path which doesn't has error source info=
 */ @@ -4618,8 +4618,8 @@ static struct ras_err_info *amdgpu_ras_error_get_=
info(struct ras_err_data *err_d  }

 int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_data,
-               struct amdgpu_smuio_mcm_config_info *mcm_info,
-               struct ras_err_addr *err_addr, u64 count)
+                                       struct amdgpu_smuio_mcm_config_info=
 *mcm_info,
+                                       u64 count)
 {
        struct ras_err_info *err_info;

@@ -4640,8 +4640,8 @@ int amdgpu_ras_error_statistic_ue_count(struct ras_er=
r_data *err_data,  }

 int amdgpu_ras_error_statistic_ce_count(struct ras_err_data *err_data,
-               struct amdgpu_smuio_mcm_config_info *mcm_info,
-               struct ras_err_addr *err_addr, u64 count)
+                                       struct amdgpu_smuio_mcm_config_info=
 *mcm_info,
+                                       u64 count)
 {
        struct ras_err_info *err_info;

@@ -4662,8 +4662,8 @@ int amdgpu_ras_error_statistic_ce_count(struct ras_er=
r_data *err_data,  }

 int amdgpu_ras_error_statistic_de_count(struct ras_err_data *err_data,
-               struct amdgpu_smuio_mcm_config_info *mcm_info,
-               struct ras_err_addr *err_addr, u64 count)
+                                       struct amdgpu_smuio_mcm_config_info=
 *mcm_info,
+                                       u64 count)
 {
        struct ras_err_info *err_info;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 7ddd13d5c06b..ad75359dfda5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -937,14 +937,14 @@ void amdgpu_ras_inst_reset_ras_error_count(struct amd=
gpu_device *adev,  int amdgpu_ras_error_data_init(struct ras_err_data *err_=
data);  void amdgpu_ras_error_data_fini(struct ras_err_data *err_data);  in=
t amdgpu_ras_error_statistic_ce_count(struct ras_err_data *err_data,
-               struct amdgpu_smuio_mcm_config_info *mcm_info,
-               struct ras_err_addr *err_addr, u64 count);
+                                       struct amdgpu_smuio_mcm_config_info=
 *mcm_info,
+                                       u64 count);
 int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_data,
-               struct amdgpu_smuio_mcm_config_info *mcm_info,
-               struct ras_err_addr *err_addr, u64 count);
+                                       struct amdgpu_smuio_mcm_config_info=
 *mcm_info,
+                                       u64 count);
 int amdgpu_ras_error_statistic_de_count(struct ras_err_data *err_data,
-               struct amdgpu_smuio_mcm_config_info *mcm_info,
-               struct ras_err_addr *err_addr, u64 count);
+                                       struct amdgpu_smuio_mcm_config_info=
 *mcm_info,
+                                       u64 count);
 void amdgpu_ras_query_boot_status(struct amdgpu_device *adev, u32 num_inst=
ances);  int amdgpu_ras_bind_aca(struct amdgpu_device *adev, enum amdgpu_ra=
s_block blk,
                               const struct aca_info *aca_info, void *data)=
; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_xgmi.c
index 821ba2309dec..7de449fae1e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1389,10 +1389,10 @@ static void __xgmi_v6_4_0_query_error_count(struct =
amdgpu_device *adev, struct a

        switch (xgmi_v6_4_0_pcs_mca_get_error_type(adev, status)) {
        case ACA_ERROR_TYPE_UE:
-               amdgpu_ras_error_statistic_ue_count(err_data, mcm_info, NUL=
L, 1ULL);
+               amdgpu_ras_error_statistic_ue_count(err_data, mcm_info, 1UL=
L);
                break;
        case ACA_ERROR_TYPE_CE:
-               amdgpu_ras_error_statistic_ce_count(err_data, mcm_info, NUL=
L, 1ULL);
+               amdgpu_ras_error_statistic_ce_count(err_data, mcm_info, 1UL=
L);
                break;
        default:
                break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 98fe6c40da64..673926d3c6d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4075,8 +4075,8 @@ static void gfx_v9_4_3_inst_query_ras_err_count(struc=
t amdgpu_device *adev,
        /* the caller should make sure initialize value of
         * err_data->ue_count and err_data->ce_count
         */
-       amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, NULL, ue_c=
ount);
-       amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, NULL, ce_c=
ount);
+       amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, ue_count);
+       amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, ce_count);
 }

 static void gfx_v9_4_3_inst_reset_ras_err_count(struct amdgpu_device *adev=
, diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/am=
d/amdgpu/mmhub_v1_8.c
index 621761a17ac7..915203b91c5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -670,8 +670,8 @@ static void mmhub_v1_8_inst_query_ras_error_count(struc=
t amdgpu_device *adev,
                                        AMDGPU_RAS_ERROR__MULTI_UNCORRECTAB=
LE,
                                        &ue_count);

-       amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, NULL, ce_c=
ount);
-       amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, NULL, ue_c=
ount);
+       amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, ce_count);
+       amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, ue_count);
 }

 static void mmhub_v1_8_query_ras_error_count(struct amdgpu_device *adev, d=
iff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/=
amdgpu/sdma_v4_4_2.c
index 9d4091175d29..57f16c09abfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2243,7 +2243,7 @@ static void sdma_v4_4_2_inst_query_ras_error_count(st=
ruct amdgpu_device *adev,
                                        AMDGPU_RAS_ERROR__MULTI_UNCORRECTAB=
LE,
                                        &ue_count);

-       amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, NULL, ue_c=
ount);
+       amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, ue_count);
 }

 static void sdma_v4_4_2_query_ras_error_count(struct amdgpu_device *adev, =
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 0e6c3ce3ea8f..1a8ea834efa6 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -157,9 +157,9 @@ static int umc_v12_0_query_error_count(struct amdgpu_de=
vice *adev,
        umc_v12_0_query_error_count_per_type(adev, umc_reg_offset,
                                            &de_count, umc_v12_0_is_deferre=
d_error);

-       amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, NULL, ue_c=
ount);
-       amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, NULL, ce_c=
ount);
-       amdgpu_ras_error_statistic_de_count(err_data, &mcm_info, NULL, de_c=
ount);
+       amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, ue_count);
+       amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, ce_count);
+       amdgpu_ras_error_statistic_de_count(err_data, &mcm_info, de_count);

        return 0;
 }
--
2.34.1

