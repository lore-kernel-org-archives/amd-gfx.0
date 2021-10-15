Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9320DC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 07:50:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F4CC6115C
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 07:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5F4CC6115C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1D276ECEF;
	Fri, 15 Oct 2021 07:50:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA63A6ECEF
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 07:50:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dl8EMpOTCJIvsZ4dDzYRr/EgAWbL4kHwOs30E89V+mtlZUJqFmL73wunuNFDq0YQLo+mvjkow8uEcShIH+dmTa6TALLTY10QVflIe/3oc8NyZ8wkVRi/Zii+sVQ7iO27PTOvrY7eG6Sqiu1H4/HX2+wiYuZJRmKGws6I8eDG5Enp+SS1uIdCOTjDoKT1E8YUi/f2QNkqCTC2Nq3bexMFQ2DjN7lCdzzAnHjiJjytXMEu0qezpwctTAyjJXwsGntuQArdbTG2fenqIMYSaU7u8UDlawYcdO1SjDILf6eiTgbWuQ/AXQb0Jof8MMY0PxPDPA4PIAOsZUTk0Ou9B0oQZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUlwo1Cw2mfrdYqV2WQxGEVW1E15kmf5AWCwO/m0pCA=;
 b=CW2ReJeFEpj4ywETUExJwNy/eB1bPwQ3adpZBWxJoNGDV3n2NsM5EnBzLKCBGTT5jITRvSELCExPy6e8ukcESK0WIefqOwKQ12VAnu7obdjlS9jXhknvGsd4rY69MAoWTNWhqNLN9r3lJFQx3aqb0lh2bxywnAGGzP6Ksapdp2wz/JyFb8waSa0mALTJ8AH/CePGg3OSrcxIr+vp4MfRsd8qcIQVePAHtInUi4D61lMdzigMNYJW9N7Az1knPzlmEd73Nrt23h3j8f51o6/G+ZnxWRbNBZRzcNhXe4OGHuLPZU2klClDzLIGmBL18ixH8+nnxVsg3PSh+UFLE3og+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUlwo1Cw2mfrdYqV2WQxGEVW1E15kmf5AWCwO/m0pCA=;
 b=rGK+N1j34dvQdcAqQi6mPEKqXT0A9H6mTxfCVs2Fi2zxVWXkcMErwVeYks5lmLO2FWehasjBANqwkIpUFb2XX5CYM+pOT29AmonqcyLDyEFnaJsKsB5V5qHRQMUhHATzovEqCZdOJw4Fr7n+KQosiXomdsL8ZbqgD2Rxn2ZxXJQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5100.namprd12.prod.outlook.com (2603:10b6:408:119::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 15 Oct
 2021 07:50:14 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4%7]) with mapi id 15.20.4608.016; Fri, 15 Oct 2021
 07:50:14 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: load PSP RL in resume path
Thread-Topic: [PATCH] drm/amdgpu: load PSP RL in resume path
Thread-Index: AQHXwZaLg16EN3FU20KGdJvhsxnR2avTr1QA
Date: Fri, 15 Oct 2021 07:50:14 +0000
Message-ID: <BN9PR12MB525797ACD40C2C04899E6547FCB99@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20211015072819.17036-1-tao.zhou1@amd.com>
In-Reply-To: <20211015072819.17036-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-15T07:50:12Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7f7ddedc-ebb3-4446-91f6-18801905cf39;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83c4d140-1658-4c0b-9b6c-08d98fb06c6a
x-ms-traffictypediagnostic: BN9PR12MB5100:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5100CE15A882170E900E7D5AFCB99@BN9PR12MB5100.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qlr/XJP7pP1BTfLD3D5zmlkEB09FRQ+5gNjB0pSnmd+bSL70gPzxKPiTlEXJ3FZFecJ1ajzM5WsrTTo0F5v+tN1zptuQ9CHX+08hKDpyV9AHUGC8MSHALUmq0UL6AwAoel9VpYDNsXqjzqAGNgKn4xQgfZuI3SraiI7U/80EijwaEmWaU9rQkc8Nk+OGrr1AqfRq9LUx2i5mccQuzb9nZSe46sYaj/aGQMGTGv35JL18APEratYKF+qrih3gvwaiW21D8tHh3n3zYYny8cTrxfZY50CkaSDbZj8FBbe8puDrQpbz0ymgpsxWGjBDOVssnk92x+DJHrGop11jIixdAM6YxMfVywtiTQTVuSZ/ubVqAVMxqBRpP2I1+kOuXZOylkd9bvR9C5xELAyK0h5WJ4QOk81bf0XDYQg49TPdLO3e0MOb2RTV0vUSLbl8J/L5eRl4tUGdqlQu6OGfHQsCUCkVREOXuVPr5+K/9iV/oKwsmxG+97/B6W0ggCfKsFqpkoGZC6+ySkmuREcQcgSTG18+VlpTybXNzbqDgrTDMEBinR/FBr5m6X2t+iaQ+0ttaJhQGLQWiVO07jJaRIJzNL/9jpGA9cZcuQkx0gu381vHoHaXaiQzEmc4JBtN5vq25bINZHJ04uR66jngEiAs1142fmPVwIrJIbVKrJQVG5Frcq9b5HlR1M9mc9AJ5Kx4w+Z+8K8HDrE93zC5ux9AMQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(6636002)(66446008)(64756008)(8676002)(66556008)(38070700005)(66476007)(8936002)(76116006)(4326008)(66946007)(86362001)(33656002)(508600001)(71200400001)(316002)(52536014)(38100700002)(110136005)(55016002)(5660300002)(186003)(9686003)(2906002)(122000001)(6506007)(53546011)(83380400001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/LIcU9YoFoT64O+LaMCNluI33KKifhs8zMgLGMVJEmlcEK7qFWPlSht+Jve4?=
 =?us-ascii?Q?9O0orMtx0e2FaUoFr+Qv/EESOy4KT11Qk0PKB6rvlAyQPIjrFP+6beeBMhay?=
 =?us-ascii?Q?oQxbeG3biQUtC6IQAbeFBT1mjtd0IsKwjHfDvjDiE/TDnTSSAXE5OqOjx2Vl?=
 =?us-ascii?Q?NnJ44OXJIxmhPHIxm3tl3Oc45ZB1HivPXGRd78gSnH7TKJruLAuDEzSGWkpZ?=
 =?us-ascii?Q?S1pAS9FoBS+FlohIQeDafUlmyC8qDNruTczZNiFxAuQm3zJYV/xeZ6VNH8PN?=
 =?us-ascii?Q?pv+F1dq25LZx5EzNhcwIA+96XXPYyYuT2Hzt6QCuhJw/NoK0zGgNLdPic+76?=
 =?us-ascii?Q?CxOKGGsEIzqwiWjYX0scJFjfHjNnIKRu+9qYH+tvSrsO9fPs2adMP+4VV8cN?=
 =?us-ascii?Q?X694xBUwiQ7c6YCML8E9dbqlfulOWeGJlaz/YFa3LPVsgYqG+gVwz2790QWc?=
 =?us-ascii?Q?alUu4IbhhtRRdxfkJXrvL/NOHM9c8TJkeV3kjGp0ctZFs5uw+fjh4Oh0f+zx?=
 =?us-ascii?Q?Av/MD2T9Os2GxRl52U7fUSt7JgzPL5dmw5lfxTbOxjx+HYmr0d27TcEq3Zxm?=
 =?us-ascii?Q?++rvwh6pHPVMwAHBAhNagY9jo5rmif4AdeRHHbxwj62dBdKGjtKhwMlA6/sw?=
 =?us-ascii?Q?Ed2sDsHGqGNuiYhYtQk7OgXvWC1gZ8/5oTVpZYjBFBMh5VLcoAVZeQSElVLC?=
 =?us-ascii?Q?+VERVkknlswFa5dNc22k/a1RYbqlQy56MZwgRjk9Gcd1J5bXIDOY6RczqXSP?=
 =?us-ascii?Q?Al//dkEga7H7L7uBE0pxAdU+OXE1ItNdhkkc/hoToxj8f8KDt/Ol7eF4Q7/b?=
 =?us-ascii?Q?Aq5vQ7J4ycqMm+UV5pi64ZyN2WcK5FBX3pTwZd2kbbZir7TPLs4bmzLJLjig?=
 =?us-ascii?Q?0P+v2Kxw8wUwefxoKQJOrMFCLTYsnpvo0v3tvi58YimOGAZaWrcXx1bpj7QJ?=
 =?us-ascii?Q?lnprIkDkXaMT0oXIzFLEA1Ie36437Nbzjiannk3EwdoWt3l44j8MQbzKhav5?=
 =?us-ascii?Q?/xxgxyJ17xpIaUIxo/oE56a7qvQwO0sFbnXOZqEXaqMYPK+2VIwhrxdoC4Qe?=
 =?us-ascii?Q?1H9/QgSPW+8ULpzbC0rtMBF5AfP57tvCGPnYw/zRLJokCMHsPVFE4X4S7lbu?=
 =?us-ascii?Q?OkSASOUmD2TPj8RLUR4zjGq8KQ0wpNCTdeThnmQCYN7LgvOkDFSQV1G+A0k+?=
 =?us-ascii?Q?QJIMYYJAyqe6znNQsYZepNDFQsCGMNMKVL0wRzjo5o63vpMAD+b6ARg3Is6D?=
 =?us-ascii?Q?2x0AyArTY6yXpZNLr/D02DC8zP8f+qnwXLLwz3UVdssZ10hVHmRgpwkeHl+k?=
 =?us-ascii?Q?jkjEG1BrpiDJa0+5TQoKWRkx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c4d140-1658-4c0b-9b6c-08d98fb06c6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 07:50:14.4363 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rps09jLEpn24V03GqscQiqA+rBkO6hgNdqn2EVLy3lymtqEJ0uvLa2aaZMOC7n8H5pRsw3aTJn03ZxB7MQqncA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5100
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Friday, October 15, 2021 15:28
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Clements, John <John.Clements@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: load PSP RL in resume path

Some registers' access will fail without PSP RL after resume.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 2bfe0682e0e6..88274c254c76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2623,6 +2623,12 @@ static int psp_resume(void *handle)
 		goto failed;
 	}
=20
+	ret =3D psp_rl_load(adev);
+	if (ret) {
+		dev_err(adev->dev, "PSP load RL failed!\n");
+		goto failed;
+	}
+
 	if (adev->gmc.xgmi.num_physical_nodes > 1) {
 		ret =3D psp_xgmi_initialize(psp, false, true);
 		/* Warning the XGMI seesion initialize failure
--=20
2.17.1
