Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D527C25B79
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 06:13:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DB3F10E6D4;
	Wed, 22 May 2024 06:13:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pti+INTF";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B52FB10E6D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 06:13:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vo0qf6on1GqOi0OswVGnIVOW/LTRsTF/5dxD70SWv11ZK3vOyhaq/vYKD3hEg6WVEuIOmAg9AQJujzPZZkQf//dTFzSTB56df7dYf6xkPTs7pPieiCGoDk/i1iPgedm2NYsISQRanp5aBHXDvDU7XOlXYqhIwq2b5e4sYcZnkqaszl8GCdOrlqV2uqoRUwNwEHbuuYybnoqB9PohZP7qIzC2e7tM+oN7AgBD9k2DAVxbA/Rjgq+KpFO/DBFVZoko3m1LfdYPvrYkVuoXqJwTfyzgjdkeHMEaXxuPTPR8AfjmZyWuRuY5aOQl1j/x0+A8hX6wrM2Mh/axElBeJkgM+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8O+U2mDV0GHrCevRWglCgyUsw1czOUwe7RMk+PZDR3M=;
 b=axhPbD7vOHuAz0TGMbNQoOKL0XGUPyBMm7vWVNyjzAOYs0dwT+7EFr36sycxTfiPmsKHXwSZgw+1pGdLpsX0eJUKhbcv+MHDoApJxInoXtZI1+7STKsxpJLE4eh1pJuz1ZinApgHDH+G+ZyXyf/pn5jXST3ZXOo3q6y8IefuIYtnTYOhc4cmOhETyQ/blVO3C5vYQjxwHylspb5UAetk+qnh5B2v1zr27QErJyH4au5bo6+4bYvpvKYLmjeLV9tmRY0x1OuXgf+Shl37V1ZohkfPg02v7pVZhSM4FSs1e8l9vG+9KHOA6VDXCz4xjxYPujPlATEBxACIe4YNtsKFTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8O+U2mDV0GHrCevRWglCgyUsw1czOUwe7RMk+PZDR3M=;
 b=Pti+INTFHpQHfexdhV+KlXlypUEuDNpuAjyynR02gYeH88gjduP2nlU20wwFjZTie1lB9bMX0OjE/pSCEJFxIaakYaTj+z2LorSWyG0b6QEJ4qd2drUE9iPOy29DYlg4OHA2nbya5MDOHT5Qbz69jGS/8EztFhB6FEKEv92n5qc=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.34; Wed, 22 May 2024 06:13:30 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 06:13:30 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Zhao, Victor" <Victor.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: fix the inst passed to
 amdgpu_virt_rlcg_reg_rw
Thread-Topic: [PATCH] drm/amd/amdgpu: fix the inst passed to
 amdgpu_virt_rlcg_reg_rw
Thread-Index: AQHaqs/tm6zJh5HjfkauUF+cW5/utbGiwFEAgAAHLCA=
Date: Wed, 22 May 2024 06:13:30 +0000
Message-ID: <DS0PR12MB7804346B9171556B29C8B9D097EB2@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20240520160757.2557051-1-Victor.Zhao@amd.com>
 <DM6PR12MB43409CC6639FE333B7E424D0FAEB2@DM6PR12MB4340.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB43409CC6639FE333B7E424D0FAEB2@DM6PR12MB4340.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a08673dc-bbc2-44c5-9a91-fa39bc6284db;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-22T05:42:42Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|SA3PR12MB7924:EE_
x-ms-office365-filtering-correlation-id: d71223e6-eb03-4806-3c8c-08dc7a264d3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?1f+L/5s1CwGjVTqaW4h75uHYuDZoBUo3/bvJkecv2MqOtyUJiyyNm0TtNzbP?=
 =?us-ascii?Q?bJYemHvQVU6qQ8NIhWCyZxuoD0NdM5JZqp7rpXwZJN4qAUi7IyOuNOTr2/lz?=
 =?us-ascii?Q?gtUOzpTpoBlAl+hV4XYdNekgrXeXlZPSUYX5hBgGpQLjZyHZhlTQKCrut1+Q?=
 =?us-ascii?Q?AjRPjbq9zpPX03RLsGQ2DZQo8S5U/7dbpDntAap1emU1ZYepySQGBV2RMtdA?=
 =?us-ascii?Q?Jf9SmTF7jDcvjaBYZ5cvn9Duu68K4YMo3KZ6YDRCioCGyFk+hFtLphZJRAA4?=
 =?us-ascii?Q?NS0gmeM6rj3drfIImgS5DLu4crysPCIY4eVqVCtPXwg6CpC/KrgrpQG8PHgx?=
 =?us-ascii?Q?obes/dPwLmTsBUiYe2d+GIvXkiRaqwls5w4UovuKk0n9CE31bIyIXcupLwCt?=
 =?us-ascii?Q?i40zZmewaeRMcDVHwz6ru90XmCvrKRgEasMO0AGlFrCcuIiz0tlMZLjhBtMk?=
 =?us-ascii?Q?GQ7F6igZwA2DVg3EkmXQCtUer0d26ve30HXEBjsLuZI9KyYEjPwvzo/QeH6J?=
 =?us-ascii?Q?a++ke4r49wGDKzGXEQr/ZQKbDY8r4VwWKSJdLOO6/6MSYTpL/BgarOwhAkan?=
 =?us-ascii?Q?EaqrpmA0VNMcsZgufm8KbtKmcYOJ76Xw7kbbFtr6/6idD8O5oAg7cFra1ox7?=
 =?us-ascii?Q?AVI1dMHls/VAoUvZQJxv6/NvqxYjK7ybDWXf2iMyBD1ju765KZcaWMY/A6K4?=
 =?us-ascii?Q?8ON6zxcyXTK0BUCzkEc+NBjG3QKuQCc+AM1YI5vW2WKt+PZxgvr05zbRrP00?=
 =?us-ascii?Q?pM2TC0bisnvC9d0gloxQD2tjN11ubTrlfVCf0/6YRfCgM2pMOW9YY8cmP/zb?=
 =?us-ascii?Q?eFz2r8hmBpHix2bUmi3YcxD5OFArXdkk3as03qb8cHfMu9LHUxt7J51LsrbN?=
 =?us-ascii?Q?yo7j4WjB6H0/OSXVBlo2wLAANTYqnQ4z91+6/fddrfhAIFjzOfnJzkwV/PSn?=
 =?us-ascii?Q?YxNB+tf2rUFRjTXLQWtb0lC2zQXLAfcynJoxtV9bMWpT0e6u7NB32oGuABzr?=
 =?us-ascii?Q?muWSEg9HsVYWmqljInqOT/mdxMy5hXEE3kpu/HcIflUFiqcw0Wn7eLsCALj6?=
 =?us-ascii?Q?rxS9Xa/JEZOSoNsHl7r+HYQ9qr79KdpUGiclVMlJMVSN3AUKxNgvvXLLPraG?=
 =?us-ascii?Q?2CRrx5hZ+6OKBbYHx0x61ki1mwHA2KJarbUCFNYlVz6v2M7wprl+SQE2Qi4I?=
 =?us-ascii?Q?zZajlcgrHCxp+G+xd4nQHT0mwTkrh0dUF+qQ6zOG3bijWUA1aiH1TCRgMOD6?=
 =?us-ascii?Q?ZDsF8o9MxU6VhyJdPit0wQWqUsyrgDduv1pCRqE8jmumvWLoZi0rfLpVcZ3n?=
 =?us-ascii?Q?8hWeQqmnz0bbJ58MhhF4Fcu4tgl4CZCX0cf6LSFeCc+DEg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?by0KZe/9ZTO+iWRszq/KeUiX96bFaAk5qgyJpwLImHcYZ/lFjvHOHWbWBB4S?=
 =?us-ascii?Q?MNsWviiVIqxvkYPFwrwKsK29rCS9+1tSMZOfP+pBmcgfytjc/usVpqbnCLGY?=
 =?us-ascii?Q?eAkM84+5OwqlB7bdI1rI+r5yyRmyLe6MM7z4/IEmUe+lwlmKGJNG171Utnwu?=
 =?us-ascii?Q?zti5C3s2iN9f52vn1ngb0zmZx6MQX3ihV2dflcUXGjkWgCSKNPwPctBRBmib?=
 =?us-ascii?Q?1Lg96z3v3KIGCYaP8Fyhyv4zoW1cIZC2RLumcc1yma33OaDzq3JHN4UqlN2Q?=
 =?us-ascii?Q?/7LC+MWOLx1rrEwC0AkQLxvy/liK8aXN4UikjiRq3SqL0TDxb/GG6rYlapSg?=
 =?us-ascii?Q?BnnWEZmqM7waA32Dg7TbywjzVwPWXwwhk7lbIcF2TNtJoGZ2skqqMnd6FeCT?=
 =?us-ascii?Q?gvubYJt9Qtc06c1gK5C5h/hsHIQlcL1Ins+ZFIT8gbUfigFhBWM3E/kTBR/G?=
 =?us-ascii?Q?ovgRkb3528HPKHav0xg7t5RXAGKD5yiaUy11fJt49N8xUcqC2aOTx3UamPGW?=
 =?us-ascii?Q?uOtVGV6kNS56A32g5P7658NXLvzQir3wX6/F7IGSFmtvo8Fn3hcil4R/pPXC?=
 =?us-ascii?Q?/iammDydNblTEDnbpswcsGGoaUBQ6/XbZJzTRPD6FbLt/bRVG3rDA61y179l?=
 =?us-ascii?Q?RRP/nDLbBGATUgjOPWtypGSoC6SNb1iTdMJ9qFOWYTHci4sLT9XQJOBovxb+?=
 =?us-ascii?Q?d0zomdfg8xxQ1k0WpFwXeS08fuEudvVW4C0mP5J8WPuODSJu71pwKyKdOyM4?=
 =?us-ascii?Q?PnA33obu15t+EMLHpC0oF+tNW0asFaPuDPoxJsi6xWnFQsuXUNTz0xVZ+2zb?=
 =?us-ascii?Q?JVRjd+j55kQlHyN5CZYDjPWXfpNfDlRbjG4RTsZzv8W8s5dqiYQm/MKDONHn?=
 =?us-ascii?Q?yu8YwBvqy/nB4aqzoAOxbbdRPO9WSdi1jXOkXXzOFzgaz+eyVQHXj1w24nrG?=
 =?us-ascii?Q?CUbD3a2xfwDVS5E6sVKW3qldhHvSufabHfPKDTAMyXZm5NpDW/vlrutWSd3u?=
 =?us-ascii?Q?jf6iu6idMtnpOB/05zyFwH0NOThnxMqMiJkF3zQ3n0zSEu0TZYQrope12Zj1?=
 =?us-ascii?Q?vCdeY4uyGjKvIPo5UUP5ighZh1uLk581+qq1d79/rW7bFoh5o0cFCqh/0uSQ?=
 =?us-ascii?Q?l3Q0wc4kmmtq1bKUEya5RrRUBRKnWNLVHGoRCYCEZb6EKyLNDljm4wcP3edR?=
 =?us-ascii?Q?tA5Jv5l2Cg4I92fwryBNHQ62PHztCvUyK3pcgewbEW8pS6+aF0FKtVb5G9C/?=
 =?us-ascii?Q?Zofk8UyptozMpI7YPskGhQe6M/FS1KPN/gv1VdfWAB+Bn2r4SJPfKYIp9tJX?=
 =?us-ascii?Q?NVDUE3avn4Hltx7HmTvsQ3Yvb+DD7L9YsMQlkW24IeTQl++QBdDgFzlUKr9P?=
 =?us-ascii?Q?/39kqVDqyl1RxMJ1DMU+/tTqbaiQ2JD11L6BywOK7A39irOwiTBu5+1YbISS?=
 =?us-ascii?Q?PYJxcrf5tx8SJWmYWl08WrmcmM3H2E1jsQ7fllgjVCFdbZFJ+iwZdX+Y6MbY?=
 =?us-ascii?Q?3ES4O8u9NoJ/av+rYPueh90Bobfil2JwD9Oh0KPMBw3yWpL7G5eC6DijJqww?=
 =?us-ascii?Q?9siAHW/DQuYD7uozlrs=3D?=
Content-Type: multipart/mixed;
 boundary="_002_DS0PR12MB7804346B9171556B29C8B9D097EB2DS0PR12MB7804namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71223e6-eb03-4806-3c8c-08dc7a264d3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 06:13:30.2689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DsR/+1AfdWmeaDBDcRlaqVnWSbgFxRUtrkI2hN/BHE3yLTYCjt/oT7xtEN6lgU6q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924
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

--_002_DS0PR12MB7804346B9171556B29C8B9D097EB2DS0PR12MB7804namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Victor,

Could you check if an approach like the attached one helps?

Thanks,
Lijo
-----Original Message-----
From: Zhao, Victor <Victor.Zhao@amd.com>
Sent: Wednesday, May 22, 2024 11:13 AM
To: Zhao, Victor <Victor.Zhao@amd.com>; amd-gfx@lists.freedesktop.org; Laza=
r, Lijo <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: fix the inst passed to amdgpu_virt_rlc=
g_reg_rw

[AMD Official Use Only - AMD Internal Distribution Only]

Hi @Lazar, Lijo,

Can you help review this?

Thanks,
Victor

-----Original Message-----
From: Victor Zhao <Victor.Zhao@amd.com>
Sent: Tuesday, May 21, 2024 12:08 AM
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>
Subject: [PATCH] drm/amd/amdgpu: fix the inst passed to amdgpu_virt_rlcg_re=
g_rw

the inst passed to amdgpu_virt_rlcg_reg_rw should be physical instance.
Fix the miss matched code.

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 18 +++++++++---------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index e72e774d17e6..e74789691070 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -679,7 +679,7 @@ uint32_t amdgpu_device_xcc_rreg(struct amdgpu_device *a=
dev,
                    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags,
                                                         GC_HWIP, false,
                                                         &rlcg_flag)) {
-                       ret =3D amdgpu_virt_rlcg_reg_rw(adev, reg, 0, rlcg_=
flag, xcc_id);
+                       ret =3D amdgpu_virt_rlcg_reg_rw(adev, reg, 0,
+rlcg_flag, GET_INST(GC, xcc_id));
                } else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
                    amdgpu_sriov_runtime(adev) &&
                    down_read_trylock(&adev->reset_domain->sem)) { @@ -810,=
7 +810,7 @@ void amdgpu_device_xcc_wreg(struct amdgpu_device *adev,
                    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags,
                                                         GC_HWIP, true,
                                                         &rlcg_flag)) {
-                       amdgpu_virt_rlcg_reg_rw(adev, reg, v, rlcg_flag, xc=
c_id);
+                       amdgpu_virt_rlcg_reg_rw(adev, reg, v, rlcg_flag,
+GET_INST(GC, xcc_id));
                } else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
                    amdgpu_sriov_runtime(adev) &&
                    down_read_trylock(&adev->reset_domain->sem)) { diff --g=
it a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc=
_v9_0.c
index 094c08cb98e7..350f6b6676f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -844,7 +844,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device=
 *adev, uint32_t vmid,
        ack =3D hub->vm_inv_eng0_ack + hub->eng_distance * eng;

        if (vmhub >=3D AMDGPU_MMHUB0(0))
-               inst =3D GET_INST(GC, 0);
+               inst =3D 0;
        else
                inst =3D vmhub;

@@ -876,9 +876,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device=
 *adev, uint32_t vmid,
                for (j =3D 0; j < adev->usec_timeout; j++) {
                        /* a read return value of 1 means semaphore acquire=
 */
                        if (vmhub >=3D AMDGPU_MMHUB0(0))
-                               tmp =3D RREG32_SOC15_IP_NO_KIQ(MMHUB, sem, =
inst);
+                               tmp =3D RREG32_SOC15_IP_NO_KIQ(MMHUB, sem,
+ GET_INST(GC, inst));
                        else
-                               tmp =3D RREG32_SOC15_IP_NO_KIQ(GC, sem, ins=
t);
+                               tmp =3D RREG32_SOC15_IP_NO_KIQ(GC, sem,
+ GET_INST(GC, inst));
                        if (tmp & 0x1)
                                break;
                        udelay(1);
@@ -889,9 +889,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device=
 *adev, uint32_t vmid,
        }

        if (vmhub >=3D AMDGPU_MMHUB0(0))
-               WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, inst);
+               WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, GET_INST(GC,
+ inst));
        else
-               WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, inst);
+               WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, GET_INST(GC,
+ inst));

        /*
         * Issue a dummy read to wait for the ACK register to @@ -904,9 +90=
4,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint3=
2_t vmid,

        for (j =3D 0; j < adev->usec_timeout; j++) {
                if (vmhub >=3D AMDGPU_MMHUB0(0))
-                       tmp =3D RREG32_SOC15_IP_NO_KIQ(MMHUB, ack, inst);
+                       tmp =3D RREG32_SOC15_IP_NO_KIQ(MMHUB, ack,
+ GET_INST(GC, inst));
                else
-                       tmp =3D RREG32_SOC15_IP_NO_KIQ(GC, ack, inst);
+                       tmp =3D RREG32_SOC15_IP_NO_KIQ(GC, ack,
+ GET_INST(GC, inst));
                if (tmp & (1 << vmid))
                        break;
                udelay(1);
@@ -919,9 +919,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device=
 *adev, uint32_t vmid,
                 * write with 0 means semaphore release
                 */
                if (vmhub >=3D AMDGPU_MMHUB0(0))
-                       WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0, inst);
+                       WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0,
+ GET_INST(GC, inst));
                else
-                       WREG32_SOC15_IP_NO_KIQ(GC, sem, 0, inst);
+                       WREG32_SOC15_IP_NO_KIQ(GC, sem, 0, GET_INST(GC,
+ inst));
        }

        spin_unlock(&adev->gmc.invalidate_lock);
--
2.34.1



--_002_DS0PR12MB7804346B9171556B29C8B9D097EB2DS0PR12MB7804namp_
Content-Type: application/octet-stream; name="virt_rlcg.patch"
Content-Description: virt_rlcg.patch
Content-Disposition: attachment; filename="virt_rlcg.patch"; size=1850;
	creation-date="Wed, 22 May 2024 06:09:27 GMT";
	modification-date="Wed, 22 May 2024 06:13:29 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jCmluZGV4IDNkNWY1OGU3NmYy
ZC4uNzRlNmY3NzViYzljIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdmlydC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0
LmMKQEAgLTk3Miw3ICs5NzIsNyBAQCB1MzIgYW1kZ3B1X3ZpcnRfcmxjZ19yZWdfcncoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHUzMiBvZmZzZXQsIHUzMiB2LCB1MzIgZgogCQlyZXR1cm4g
MDsKIAl9CiAKLQlpZiAoYWRldi0+Z2Z4LnhjY19tYXNrICYmICgoKDEgPDwgeGNjX2lkKSAmIGFk
ZXYtPmdmeC54Y2NfbWFzaykgPT0gMCkpIHsKKwlpZiAoeGNjX2lkID4gTlVNX1hDQyhhZGV2LT5n
ZngueGNjX21hc2spID09IDApIHsKIAkJZGV2X2VycihhZGV2LT5kZXYsICJpbnZhbGlkIHhjY1xu
Iik7CiAJCXJldHVybiAwOwogCX0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92OV80XzMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV80XzMu
YwppbmRleCAyNDIwN2M2ZjQxYWMuLmRmNzVlODc3MGFjMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzRfMy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92OV80XzMuYwpAQCAtMTE5OSw3ICsxMTk5LDcgQEAgc3RhdGljIHZvaWQgZ2Z4
X3Y5XzRfM19pbml0X3JsY2dfcmVnX2FjY2Vzc19jdHJsKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQogCiAJbnVtX3hjYyA9IE5VTV9YQ0MoYWRldi0+Z2Z4LnhjY19tYXNrKTsKIAlmb3IgKHhj
Y19pZCA9IDA7IHhjY19pZCA8IG51bV94Y2M7IHhjY19pZCsrKSB7Ci0JCXJlZ19hY2Nlc3NfY3Ry
bCA9ICZhZGV2LT5nZngucmxjLnJlZ19hY2Nlc3NfY3RybFtHRVRfSU5TVChHQywgeGNjX2lkKV07
CisJCXJlZ19hY2Nlc3NfY3RybCA9ICZhZGV2LT5nZngucmxjLnJlZ19hY2Nlc3NfY3RybFt4Y2Nf
aWRdOwogCQlyZWdfYWNjZXNzX2N0cmwtPnNjcmF0Y2hfcmVnMCA9IFNPQzE1X1JFR19PRkZTRVQo
R0MsIEdFVF9JTlNUKEdDLCB4Y2NfaWQpLCByZWdTQ1JBVENIX1JFRzApOwogCQlyZWdfYWNjZXNz
X2N0cmwtPnNjcmF0Y2hfcmVnMSA9IFNPQzE1X1JFR19PRkZTRVQoR0MsIEdFVF9JTlNUKEdDLCB4
Y2NfaWQpLCByZWdTQ1JBVENIX1JFRzEpOwogCQlyZWdfYWNjZXNzX2N0cmwtPnNjcmF0Y2hfcmVn
MiA9IFNPQzE1X1JFR19PRkZTRVQoR0MsIEdFVF9JTlNUKEdDLCB4Y2NfaWQpLCByZWdTQ1JBVENI
X1JFRzIpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKaW5kZXggOWYwNzVjOGNj
ZGNkLi5kNTc0YzY0YTE2ZjYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dtY192OV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwpA
QCAtODQ0LDcgKzg0NCw3IEBAIHN0YXRpYyB2b2lkIGdtY192OV8wX2ZsdXNoX2dwdV90bGIoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IHZtaWQsCiAJYWNrID0gaHViLT52bV9p
bnZfZW5nMF9hY2sgKyBodWItPmVuZ19kaXN0YW5jZSAqIGVuZzsKIAogCWlmICh2bWh1YiA+PSBB
TURHUFVfTU1IVUIwKDApKQotCQlpbnN0ID0gR0VUX0lOU1QoR0MsIDApOworCQlpbnN0ID0gMDsK
IAllbHNlCiAJCWluc3QgPSB2bWh1YjsKIAo=

--_002_DS0PR12MB7804346B9171556B29C8B9D097EB2DS0PR12MB7804namp_--
