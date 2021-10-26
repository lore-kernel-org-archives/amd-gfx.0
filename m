Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AC2C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 11:02:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43BF260EC0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 11:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 43BF260EC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBEFD89C8D;
	Tue, 26 Oct 2021 11:02:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B7AF89C8D
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 11:02:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+I/HjE/yo0PHEaQTYVObVFhSO1B55EA9vTgNXLATuWoKBqNjgevhoslR2CBGB41WToHYcmj8pO0/9jd295AL9TblReizMEmBmmN5k4D4GVEml1P6KcKPCqyF7O9UapJK5b7Hw7O/ALTtrOeChE2z5bF/mZkYZk7GeBSFeP2NX8BDsG7OYHDuIK2h+c8kWs3wRBMyJuE9FlWhyQYsuCX3RDpTxJy6IWqgB0PTlS+Wih3SGleIcBhXRNqd14kteGwV+W8vZvCMzjo4slXeUntZoV1DqAXRSkwuXs//4+dlLYeN3gNuu4CAerrQrPNtu9cosAj25/06hEeEs9EQi8YXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9k39LGUyNkQEbRA6tPpFsKjXxOUu8htKU9GRq5ll0Tk=;
 b=G0Z86ndAbF0oCpwN5VKYxvKvxH3H+Gl3dIr8ACK4Gx/icA4NJAODlkEe5zj6F3kQKrtAFdxGvogklq6TKNNPrKKbn+MZc3LgApj+gvQlYE8DghAUVC7Wq90VeGnLN0JwtEziU6ZeMQzvCVJAgtILtrEvCNv2TpeBnVXRhQcyhftS63l5DpsRQpdHHCb9oLorKw9+b4Q+25DH0hWJnLFo/pKDwiZ3LzSdlsdgmmpnNS2Z+R5VcCo9NZysVyVmUTzRKTlP8/DcG6LNdT7PfLMXDot572KRZIcEru0fXQoyXvfOEdkzN7ZFEtuijNZpqlZ1Pfv782HSy5O/WGrk6JuS1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9k39LGUyNkQEbRA6tPpFsKjXxOUu8htKU9GRq5ll0Tk=;
 b=ezgInuwvfdvoaHXSrX8VZjs5P9ogl9xOOxHjvmZcm5T5pYGwGkbYcsLvuKMJDh1Lo3yIE9xCgKyQyNJSpTysbVLMmBBBrp5TC42OGe3Kl5C+kYdLH4X+gjYVYPIB7pHFt1MoqfymFZo8eHl0z+WkYMWwPVBhNWKAprdD4I8ZknY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5097.namprd12.prod.outlook.com (2603:10b6:408:136::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Tue, 26 Oct
 2021 11:02:49 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::49b2:d5a0:7a71:eb8e]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::49b2:d5a0:7a71:eb8e%4]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 11:02:49 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove GPRs init for ALDEBARAN in gpu reset
 (v2)
Thread-Topic: [PATCH] drm/amdgpu: remove GPRs init for ALDEBARAN in gpu reset
 (v2)
Thread-Index: AQHXylTRALVUiFlRKkKoRjC+hYBCOKvlHOIQ
Date: Tue, 26 Oct 2021 11:02:49 +0000
Message-ID: <BN9PR12MB52571B3A80E34651FE7641D3FC849@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20211026103235.18489-1-tao.zhou1@amd.com>
In-Reply-To: <20211026103235.18489-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-26T11:02:47Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=02ab65b7-326d-42cc-bcd0-474a233d4c91;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e52c59a2-1a7a-4bd4-fc5a-08d998702642
x-ms-traffictypediagnostic: BN9PR12MB5097:
x-microsoft-antispam-prvs: <BN9PR12MB50970673CF6C74051F057669FC849@BN9PR12MB5097.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JhAptnWhVAYVP3otlhSfW3XWNpeQ8Utrn+mw8VmuIBy0RtExVU2m7AJmSxjGo/AWJybwJ7cdFcZf5Y3PMVeigJoOKNc/q04a+H5ovtg1gayX6JVY7Cm6eGBST7Te4wMIrSYEbJGTn5BUoYr3E/q7SfKPhuqBjfqrT6qSCavRksyef6CoCKlHGILq7TCqrvDPVRD6loAwXSc1MPzw/TZ+BA9NidF2tU4CyIcD4xeeUjWgUcp2psEm+yATRtouVfD1oy4NwoDKGGtvzecp02+Z5NS2TKSiX6wth1y1F/uApSMB9bHO27oL5Iy040KX+1y87Neq5vFsEVsiXluEfdwHil1/xJnshvurq0ONw3IwlJverZMvb6qWrSLQGNmnVnccEHOJ063dl8evLC8bme463ocqGhr5Cv2/0JxcX1IhzREGQDfySMfKG1J+J9LsHt/tY3k3u2FsCgawyEjFWt66O3//8kz9FkDWyXqgKgNX5rHR+Nq6NlhSZebhtsJib3TC4bJmIjlWAYTfRo4d5J3OX0+JGq2WVsIPeHRnqwd6K5BqcJJFcM/1NMBwuadHA1Vcq1Pov/1i13ZRjSmn+8wD7p56jsIBfPuSAw/7cYgYJNh8zqxptbfssGCYFpgDmB2C8eW7yej8okcb5QrqiBN4azYL2pbki16E5f9IoOtHkeRbK3eyzyzIme5ccCuWqimigmJGdVCB/DDfsxOmTlrkrA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(6506007)(110136005)(66476007)(64756008)(66556008)(316002)(8676002)(8936002)(26005)(186003)(38070700005)(33656002)(9686003)(7696005)(66446008)(122000001)(83380400001)(2906002)(71200400001)(5660300002)(86362001)(52536014)(55016002)(508600001)(38100700002)(66946007)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jWJls/Efz+TBcYqoED5vQc/GuN1O9RtDI3aS2H3B5qvllJNxPI1aVlh0Zh1I?=
 =?us-ascii?Q?5EQk+zRXZdlyLh9moB+gA/ZxmE0Iom95NpWp0wXE90+cpV45ln2xvSOA5QUt?=
 =?us-ascii?Q?ZCA14vaAYwtcKQ+JXrFKobS5hEVLJOVJ4nKYQ1ZQ1YwoWpKpaHFRTpJGn82d?=
 =?us-ascii?Q?KQbHN3cBN42/im8ezj/JlAp2LQuKISRx+Q+b/jrlfm8v2kW/iHcxuTtjWknY?=
 =?us-ascii?Q?MXoFA1GbB/JL+Y52IPFskKeALs1RseVw6os+tr3OcF3dJl+GIsk5kXQDLYSe?=
 =?us-ascii?Q?qIwdLYEqR2NDRmwnKSc7FFeMvjcLARZicX/I7I0gagOf2go26ZEtNkUAKRyB?=
 =?us-ascii?Q?3wikp7Dsg4t4MkQq/GwdrEv9wWG3TSowf+kvPVzrERl7vEGdRwx+QyAtr4cl?=
 =?us-ascii?Q?kQaAhOnFEEaijnFcI6bQ5Yy+4B0kH8jexDAS3wLsaj6Td2Bbinxv43MJRRxQ?=
 =?us-ascii?Q?qZH9oEiWN/gjt2BFLu2fkjMReGC7xV3x9HPBcXyf+YNVJdexOlS78J45TZ5Y?=
 =?us-ascii?Q?77DUtOA0yQqjbZsRTyOUbIrB+ERSz8NXBDzwXpYlhveek1BFvlUaB2AVpMSI?=
 =?us-ascii?Q?fEeMHE5eZdWtlcBR1KLGnMBhDePYpQuGzObB690Vx+GYP2lB5EBT5wp1Co+d?=
 =?us-ascii?Q?eYD9hLy/f0nc5sCBlfShFqQYjded2A7S0P1PCZGCeAqsuojWFzOVV0MD/qlD?=
 =?us-ascii?Q?fgYnT0qs9KcQFgqGQQVHvi20p8P9x/Su/xHyk7a8uE18ccFi+lp8LW9W7UcE?=
 =?us-ascii?Q?VyvfEDh9MEyBQSzKzQCdTd3JfKpYWkqrriXTCGJNF5xKP8zoNrJxwAbDzguE?=
 =?us-ascii?Q?vqAFftXCyOyRNgrnkK7l0j5MmNbosBabOd6RjFIhCnv/2Auo2xpUfGcRnF1p?=
 =?us-ascii?Q?GNOGogUWWg8FAyvfVASNtELvXTTsUs+3wPFvLpCocyqCKnyt/NooTYuS7j7u?=
 =?us-ascii?Q?jd32XmESUAvVGbf47qZVVlbF7KiCjL5yIOeCWvi49DYoMjfgBqlsnrPci6+8?=
 =?us-ascii?Q?fhcfNFkSrnchNArH5OJ6Fewg4P42uRYm1LCOt1pXzyZ21Itoy7wNOuW2VByS?=
 =?us-ascii?Q?++RJqk4r/Cljf6Frx9ZMv+ZxJ4RINDBAi8+n8tuZcf36Y12wqSM4t5C1ohzD?=
 =?us-ascii?Q?C7CkhGrDv4gCvINsFHl439uqSlru24zUNtYbyYQ+a8Pi1etJx/naDU0Oqo0r?=
 =?us-ascii?Q?1KAkv/tMEPwTe3UC3KibcPz21ZuPhKfp0jQXmAZ4aJO3n2TpulblY5M5WHAY?=
 =?us-ascii?Q?5l2CbM2AkOps28SdI/ftDsy4RWtbb2+RlEzFQugey3O+3q695GJ6OAGZO7SM?=
 =?us-ascii?Q?dNu322bVzmhOBxw98TiifxWe+5SYQMKSxVS0wDbv8uYA3GUSH9wWA2SYgUpt?=
 =?us-ascii?Q?1aVOyP6AcwIiq940MsnTIgE7bANez6fCnK7ruNhT0eQayh3/i7UBJTz+2TXe?=
 =?us-ascii?Q?x4Jt2ZqI8Qn36JUQQU8UOEE+7jPtIOhPmoAyhyDs0aXYpFY3BPoPbwptwAVm?=
 =?us-ascii?Q?b24WQZ0M96gy0EuFc4Q+vueKot6XGFgAlRLpxlPz4g1bXWTqYIcZxVFv2ljz?=
 =?us-ascii?Q?RqKnY1iZDKDjiMbHLVnfcO+IqyxIM6U9+wXiEY7o1DG5pc373pLJHsPcTzEu?=
 =?us-ascii?Q?IaVkAjSIPm7e7leYyzOuAKU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52c59a2-1a7a-4bd4-fc5a-08d998702642
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 11:02:49.3517 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q6OoTvPUfsLXsfeFneaZ8pSBVETIngz1/SHYk6NCCuP+bjuNMJS8EEApOpIYXN5PViVsaBtCYhgR30Esonpwuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5097
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

S3/S4 needs re-run the shader. So let's just skip mode-1 reset.

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Tuesday, October 26, 2021 18:33
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: remove GPRs init for ALDEBARAN in gpu reset (v=
2)

Remove GPRs init for ALDEBARAN in gpu reset temporarily, will add the init =
once the algorithm is stable.

v2: Only remove GPRs init in gpu reset.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_2.c
index 24852a24cc58..9d0f4f1026cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -706,9 +706,9 @@ int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_dev=
ice *adev)
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
 		return 0;
=20
-	/* Workaround for some CU settings, skip GPRs init.
-	   Will remove it once GPRs init algorithm works for all CU settings */
-	if (adev->gfx.cu_info.bitmap[1][1] =3D=3D 0x3f7f)
+	/* Workaround for ALDEBARAN, skip GPRs init in GPU reset.
+	   Will remove it once GPRs init algorithm works for all CU settings. */
+	if (adev->in_suspend || amdgpu_in_reset(adev))
 		return 0;
=20
 	gfx_v9_4_2_do_sgprs_init(adev);
--
2.17.1
