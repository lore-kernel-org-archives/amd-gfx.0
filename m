Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4596C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 15:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C88210F3C2;
	Fri, 22 Apr 2022 15:03:03 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2079.outbound.protection.outlook.com [40.107.100.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0668C10F3C8
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 15:03:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5ZxtaMiUUUxVTFa74OyEukqz4f8u8Fxq/c7e1OjG+wvd6yKus5xKvDfh8pLil2upgo66vT+I6kgz54fv1qk7Mp6voufy709FBWpDqobbQgrwImd9acQ+wRXmRL2OaaFK/5uuG69UmR4Xrtkn7AMYSDPY6N2pQAPcXaGLSKfrR7NQawn/aF4Ea2b+ODdW1Y/QLMXLUkD/yyP/WBUVjl70a2lV9chUwRpDa9gX6P6cHtvLmCZLQgw4R+5/q2jgNGdv4XQ+h2vz2KIqWOOfTIeoooR8Ef2EURh4WHkI12niAmaerGVv65QUCXoEnKOZGGZ3bxX9oM2k7mpTLRzqlc7hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqWIjk+C9ZvyQ73NorC0l8OeyDwHlfBWFrff7H++A1M=;
 b=HPOVx4NOe5rY+HZlg9AICihhedNzaZ4zUt3oD3cleeq6Eyk4i5v9jVNyWjBqIW2z23ZnpQSI9+RBpoi27pggKuHP4V1DCSYUN/kWUAxS3VpuTFS/yd0WC7BCCAKdtr3iPpWy3B+UzhmnNgRQte/S2aJWNh1rHDUYCEIoDdh3jVxMYtvISJ8Xsn0qRNmEOwgYnVtEM9BesTT129yUvveXB0umqMw+VKgKNYLWOu+sUQPF9+FafIqDUGlZH+kJeVxtWuPw4kPtmbgtggjoIpDEDYhvRKN4tRIQTVotNBAqUzI59+HfyoCA4bBxNSDSt+iEzzHUqxhrR2chEATSacQ9Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqWIjk+C9ZvyQ73NorC0l8OeyDwHlfBWFrff7H++A1M=;
 b=ZO3EKjBbkOmnXKDUN9V/yhsk2N3cNhOjSVKwcvGI8/uTRxIqS1PmdnvaBQf+SBsz8v4OtgwYTCnXmhNoWzvyALhl0C5wpTWZ1zACbqkxKv4QiyGPFyLEliFVsNpk5g2i92zXBD/lap+/fRmyQOkr0ruGgFdnKtfthMVD7EXQDQg=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by BY5PR12MB5510.namprd12.prod.outlook.com (2603:10b6:a03:1d2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 15:02:59 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::8da2:e9e9:647f:df81]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::8da2:e9e9:647f:df81%3]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 15:02:59 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Yu, David" <David.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Ta fw needs to be loaded for SRIOV aldebaran
Thread-Topic: [PATCH] drm/amdgpu: Ta fw needs to be loaded for SRIOV aldebaran
Thread-Index: AQHYVll3Hjxl610ihU2a5GTN72yIB6z8Bt/w
Date: Fri, 22 Apr 2022 15:02:59 +0000
Message-ID: <CH0PR12MB5372C51A2C16A01634FF988CF4F79@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20220422145822.3628-1-David.Yu@amd.com>
In-Reply-To: <20220422145822.3628-1-David.Yu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-22T15:02:57Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=5d39e4c0-de9f-44d7-be2a-74ca329e1eb3;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-04-22T15:02:57Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 70e6ed27-00a1-4d5b-86ac-cdcb5c43ed4b
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfb95543-057c-4749-e84a-08da247130b8
x-ms-traffictypediagnostic: BY5PR12MB5510:EE_
x-microsoft-antispam-prvs: <BY5PR12MB551059E6F44762AE9FBAD5ABF4F79@BY5PR12MB5510.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /o2txWD277Nke/Zfu4QGY0Cn38NIRjIXWOiZollEFIlYGCgagZUSemE6pgBo9wV/xXv7H7aQn460UFygc/rcxUxx5QMLvvPlvJeimJODDY8yOGihZY1RSNdsD0DWMLXjfQlpgn/xMWChWzMmAgmpi8iCs3/rzF8vdFIhPrvDFWi+Hot/tcxOZ2PMFQ7ttUpU0P84ICx/Ee59jq6ZSoDrOykd/zhui53NrWrxLseiD9fjL/1h8XQPuTKHXna2rVHERyGUcwwILMpJ9AUk/D6UfksNBzdeDC+R0dp6u7vExIdAW4R9aJggto9d79DHoTYAUe8cD8XW7cJM+piEvmArXbkTILZeeCc+bEcShQXmTrExnZamKGWI3bKjh5/Yte8bWVDGq0gQ4xpzFPf0PNbHTwawZ8AE4a1G80c8QXBRk58qeMs2OsA4YuuwirXsPgGVDleigUatauM/1rbj7yGbD/IPn18sxTs0r2YQZwhkiDWWR21Cw+JiFegQUphWg9LUjh5ez8LoMFnTRO8AJu6pGUaLr3zaaP6e1GzBS5k3Ec2s+Gu3TRWh3uhNupLBl6Jz1bN8zRkR0cI3wHa1j+ueSMIUwgNMdcr3mTzYOLAJm7YXktL2xglMqMqHJIK5LwBUDkfaqJ4nfKwBwhtEvORSpv303FFPcg90x2rtM3iFbdQbrqaJGstsNHEaQ+B/s6RiTEh1b8ZabnmdELTlrVYnRQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(38100700002)(86362001)(122000001)(33656002)(8676002)(66446008)(66556008)(64756008)(66476007)(4326008)(110136005)(316002)(508600001)(5660300002)(2906002)(52536014)(71200400001)(8936002)(76116006)(66946007)(55016003)(186003)(83380400001)(6506007)(53546011)(7696005)(9686003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?obIOyV/4Qp4IpxWGw7srDTXL/qTK5Bef3Nm1D3zXMlEem0gFXHpJyaNIQ9X1?=
 =?us-ascii?Q?MJi97CWn+Npq3VBXiWhC+9FChFcvMUeml9Ja3SSXTF+7RbVb6MG4NGG9yrHc?=
 =?us-ascii?Q?TeE65RveqpvSK6KDxDw+jWrLuHr2MWVQE4jpZRHZ2tAkUmszp4A43Y9/lRc4?=
 =?us-ascii?Q?knULT5FgunCKsHGUQtyCvgVh8fQ6yMdOOHW3LanBXzBJKYKZd6fDy8lyjqBV?=
 =?us-ascii?Q?2TRD67bsRtFxjIhx81XW+CtMmR1C7SffGMbGle+L1c+wI2qjAEFot3UyOdpL?=
 =?us-ascii?Q?VwQbUlTEve8i4OhH4poiAEZ8/xYrWcIHLh84lxydZPGPAoacZzWbFh4bijL2?=
 =?us-ascii?Q?pCoPiViO49Xpkt6b3x8BPE8Xd3r8N4kkUvbvgU6ZA1yilqayYMqZqrCbaAiJ?=
 =?us-ascii?Q?MdY/O7Y7LEFHe6k7tCsNGfOKEIRXSFHJzPIsl7CQTLQHWuP3LWQv4duIAwak?=
 =?us-ascii?Q?7xDkypnUAzF/J0xlqFWl+EImYYMwV6pLww6ij7qBNhEOJ+ARnHJxLlePmM7Z?=
 =?us-ascii?Q?R71S/073zy8IXbSYAMZWzc7gT9mOft5kOuA4oshi0rzxufaGRpK7C1ByrGKm?=
 =?us-ascii?Q?ASXI9LwsGz1D+pdZUhhuq29heNFlQJd8zxJxfci808SLjntcpZuoJGU+LUQ2?=
 =?us-ascii?Q?HjOHYLLiNNhPUlPBd4crQ5Uq9ENy8UjcOjXmUUiNL/HrznuxxzvsxFfLb53y?=
 =?us-ascii?Q?CeGHFn1/kQFNwNfM2yJ1ZGxaOyuCER7T1kKCcVVDTboJFuIoyItG94HjeJwo?=
 =?us-ascii?Q?wezeYwVh2hb81jVeqL81n2iqSJkOvEH+kEgPjufx1obcdt0aSu/nVxOXYqHN?=
 =?us-ascii?Q?dLbk4hF62ZalmfQi3lslhZAzEdncKwTuwi/+XNxKZz5yQanvoUPfmzt/qvIG?=
 =?us-ascii?Q?vGdQMAtYHg5Sjcd6xcb0Ny6Wd1zjrH2A/Q7LkqjZiraQc85ANemFyQ5yz5Pi?=
 =?us-ascii?Q?ciLRfewMaYKH8vOtwph2iqZ2zWf/KiOAksSgOd44eoAZ1Hlm8WC/tzPrEYM6?=
 =?us-ascii?Q?i1ynSuYtC+4PnuuCjpSA7y+bbbleUNA97f+H1nDe9TxXkXj2HjIJp50d62J5?=
 =?us-ascii?Q?AIRrY8c3hpYoJvSUwnJaas1Yve+3cFUpgj0WR2zNQoDp/yP+UZ4KlH0xLeuB?=
 =?us-ascii?Q?B1jl+UjLbECU7IDjL1UfhhBmQCuIQkOAuINBaM+snxly91Mw1ZdHPjsAxkFB?=
 =?us-ascii?Q?OjaZqmQ7wjsu7NNiEw3TxuEyoIKcNJXIKmn1Q3TLnl30i/Sq5b0A7s1i/23P?=
 =?us-ascii?Q?hbU4pnZaHRy4xF3ASMCCKLGM22gWLfvmqLs0Wt5NZSRHJiiSJ0CBgOHjdY9i?=
 =?us-ascii?Q?Azyhjmjkg9dzvl6pZUtgtJ6l8nyGv22BnPrX7JVt7RLPiBgKnPxPLXHhX0mC?=
 =?us-ascii?Q?Laa7Bp7HSRJqzFvJdYjgokvPN0yVX3FotoTvBnHZaa3KvxfSMZ5VHnQqblsL?=
 =?us-ascii?Q?pIafIZ/eT8zxN7KAeaGqtamqULvN6TSQ+3IUPG4CeBe0Ikla9jfvlD4zVh+S?=
 =?us-ascii?Q?gmXIKv6dxz5azKz6ADmg7Ma3l3+6l6yCYFdUqEOghsVuwTHa+ZDD3/aRJ3E9?=
 =?us-ascii?Q?ursNWe14LfU0soF36+MnnYIwVE/Ay0y1fPdLXOBysHKVwfgpzB0umWRmTxO1?=
 =?us-ascii?Q?QIQ9b/qL/tKep+OtLcn2StRFSVufQPVbUTITaEx20wg0iYSz2LuXKytNKbI8?=
 =?us-ascii?Q?wuRjKoDWym7pGcSNwooqwM+iCKLgNAjRAu4pEqTSGcu2R6fA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb95543-057c-4749-e84a-08da247130b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 15:02:59.3206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3FkDofzls1Ljo9ZJE5DtcH8W7CSC56ba5vaWtFYGCuenTi0gGCyJnpqjNLZHqHUtQrb7VPr6yaf5QQJEDh6HJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5510
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
Cc: "Yu, David" <David.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Please add some  more  info  in the description to explain  why we need to =
add TA in SRIOV guest  .=20

Regard
Shaoyun.liu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David Yu
Sent: Friday, April 22, 2022 10:58 AM
To: amd-gfx@lists.freedesktop.org
Cc: Yu, David <David.Yu@amd.com>
Subject: [PATCH] drm/amdgpu: Ta fw needs to be loaded for SRIOV aldebaran

Load ta fw during psp_init_sriov_microcode to enable XGMI

Signed-off-by: David Yu <David.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index f6527aa19238..895251f42853 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -275,7 +275,8 @@ static int psp_init_sriov_microcode(struct psp_context =
*psp)
 		ret =3D psp_init_cap_microcode(psp, "sienna_cichlid");
 		break;
 	case IP_VERSION(13, 0, 2):
-		ret =3D psp_init_cap_microcode(psp, "aldebaran");
+		ret =3D psp_init_ta_microcode(psp, "aldebaran");
+		ret &=3D psp_init_cap_microcode(psp, "aldebaran");
 		break;
 	default:
 		BUG();
--=20
2.25.1
