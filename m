Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63992ECD6C5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Feb 2026 16:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF9B110E629;
	Wed, 11 Feb 2026 16:33:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sYHcMgPW";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012069.outbound.protection.outlook.com
 [40.107.200.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C27D110E629
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Feb 2026 16:33:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQLiAFT2+rbO8iU/+cImb9rP8Kk4lEkepRVtpGPaVeHQUkEURv6Y8w3NHZj7Mx4DWRosIo/AHjniMDb+1SRBahh/71f6UwXSDPgU5hxjvL2wliC8OzqVRXn0k6gAASEcnL8wZZs7dpe5cqJw/mqhl5mT1rtxDj2amkFNCap+n27HuPx2yT8axOLslyOFsASyZP1Mv1SPvTMlWfrLpHqUOKJX7INnakyt4Pd0nDo6FrmZMTMuzzzKY/bK+d3JWRpLqoCC2agA4T3f5NO5iFN3Ro/gCS12yLjGf8BhE3dG1v4pL16csOdpklmyZq3eiC5u5CsvVyWA7ErH6BABaS+JHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4ZcZbAWlhYSqB2GwApANM0HPhliKOGTKpUz6/p7KS8=;
 b=p1ldc6XSACVblDMaokNM5Nh8jR9IaSg4rctaxDyGmtxXg0xRl55FF1X0+Tk9WCB66iXC1bbE2aMvySHDxcXMW7qKOPuyNW/tCzp7BzBdKIJBQk51YlOd+LBqR8JlQmUfSnP36cSC7F0mhyKGRh7+1BrPRqaBpAVfL+k9hiXrZFK7/YZjb/ouE8FXyzZzsRRN1PaF5gooOaavYCM28nIY2q5Zxij7+r/sBKI/8KsHtbnc49suEVKj7C3atx7dVsIjLoMfeRy2ASDrNdfv+EZ0Axk5DjbJUaWwFCdbhf39Qo9ZLJYReMxrKpUqVtJ46WZP5d4lE1R/KalZ+dwYc1CEoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4ZcZbAWlhYSqB2GwApANM0HPhliKOGTKpUz6/p7KS8=;
 b=sYHcMgPWU/HwDNtbN61j1NTFfCPO1wyQyOifaZUP4NWu/zLBSCki+itsmHutqPk49RtYvphasDWtI/CkZiz+2Lyjvrk+BXAM9QoTqq7EDXKMiWfHnP5/x6gNAVAsr1AGJnq3yG3QOn+eFmBjZ3xFkBjkgEGtPT5biROSc9wSrZE=
Received: from SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d5) by PH8PR12MB7159.namprd12.prod.outlook.com
 (2603:10b6:510:229::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 16:33:24 +0000
Received: from SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 ([fe80::9af1:998b:f375:a619]) by SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 ([fe80::9af1:998b:f375:a619%7]) with mapi id 15.20.9587.013; Wed, 11 Feb 2026
 16:33:24 +0000
From: "Clement, Sunday" <Sunday.Clement@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Russell,
 Kent" <Kent.Russell@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Remove dead kernel queue cleanup code
Thread-Topic: [PATCH] drm/amdkfd: Remove dead kernel queue cleanup code
Thread-Index: AQHcmgXhFiYcz0vi5Eu0ND3Kc5SVkrV9tANw
Date: Wed, 11 Feb 2026 16:33:24 +0000
Message-ID: <SA5PPF8ECEC29A92B453E46AA58D26E32CF9F63A@SA5PPF8ECEC29A9.namprd12.prod.outlook.com>
References: <20260209205112.674894-1-Sunday.Clement@amd.com>
In-Reply-To: <20260209205112.674894-1-Sunday.Clement@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-11T16:32:35.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA5PPF8ECEC29A9:EE_|PH8PR12MB7159:EE_
x-ms-office365-filtering-correlation-id: 2e7f7ce4-8f62-4c09-cc85-08de698b4723
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?9rp606kfaVXZaYK2Z5V+9NlaxKegk6XMz392ODQB1UPdUqCa/G4kzA7JiUi8?=
 =?us-ascii?Q?5e92ss94l3o+AErtSqBwip42NkUZB4EvpOkwcK9vLuQ8+PisyTUTj4TYbAGc?=
 =?us-ascii?Q?KAJ3jpE3p/A2d8zlQRrBlx/7v32o9arK48o03CxTZegadqpzLk3BILjXw9la?=
 =?us-ascii?Q?j2Jbu7HtrfjNJCd/c32IIZeJe6Q6lU1tNt31DuWqQpS6XizdJP59PfWKLNqq?=
 =?us-ascii?Q?yUw9eUgS1hHBR2MmD4vBaPYaDz9mCKLH1JaUMNgaQpPI4Fsh4Vd+dmrtiZ/n?=
 =?us-ascii?Q?C69dFPDlD2dOCK6PrqvZkKGphdlLMpIVXrHUwtW6YAIDhUBfMG+Gy8WFTXvD?=
 =?us-ascii?Q?RN/VTCN3uoVeMMIiGHrUcnygm/aY7gAWjW4CoIeYt8xDML16Llt/+7qBzFuG?=
 =?us-ascii?Q?qhKkS+PFB1rswtpr5v8QyU1HiIEe+xjNzGyRCPt+1U1Qjr5himfRPaCXGk7M?=
 =?us-ascii?Q?udQmzEjgW6Hi/dAJETRXjvUjoRer5DUi88WpHHpj+V5YettvYEzN6BjCd1jk?=
 =?us-ascii?Q?K/eYkK75KyK0XLuVcthcS/yr5oZqmkVlQw1Et1krr9RCQU9e9KGt+8xWxwmA?=
 =?us-ascii?Q?G3f4oMJuH+OWeszSbypYCACqUM5N5bJZzucriovES+dTziY13MFxDzl7FH0k?=
 =?us-ascii?Q?iMZj1CKzWkd9FM3vBbji73DIOoi9ki2mbykH0fmbqpAIvc5FzjnhfcxYlPcx?=
 =?us-ascii?Q?MEz7knrQ5RaMt+4lU1/EK5H4nKYC6vlfNCmz7BKNXJg20Lsk3fX1o5UKoHZo?=
 =?us-ascii?Q?FgazIWHxlX3CoE3eMCS2vgNonrOllcM4R1TKFVSbEhQ+ZoCEY53tUSw3obmi?=
 =?us-ascii?Q?gjCX3eQeKnh0oayiv5ZOCY1D/3Z3cPvEyrF5d1lCofKf3/1jxdK9G/B70bIL?=
 =?us-ascii?Q?n4tvvq6AoEdgmdRCE6lorYw4BfK0f9K8otpUbtDi1hPXnKfTqSeAvVQZNe6y?=
 =?us-ascii?Q?q+ofQdff45RzTQaNDhDmMunV/Hhx/sPc7qVtGu3GbIgXPixX9Z4PnfN7hlD4?=
 =?us-ascii?Q?suZPLc54uC9mWcO4SvsSGKWY6LI1U2vFz94wxXHY9sm7NaHZGiA+SRnBnZex?=
 =?us-ascii?Q?xfcaeFB/3dmHn8coNqAbIkT2idPgMo59tE/Z56wrruM30yVWvaE9n7+u2m7d?=
 =?us-ascii?Q?mA8vDK3rEpGgc6Tj2NdaQTqbhtYYQhvWVksdWRV6t+qCJniDDRmfnrooqS+5?=
 =?us-ascii?Q?yVM87pmm+XcYlP9qTny9K+pY5f0ER8SXm3ReVtl9uJcrElJQGsGisx9VsDcx?=
 =?us-ascii?Q?gHWPNdmNAtcjCIhvqTTKPMP86Q94f3myLaz+rnvJsRTRG5qBWyu+s51OifOr?=
 =?us-ascii?Q?Vl/Lwh8LVJsIoByTlNuwm/Te1FLRgGcz7xsl93ySby2UbZdgJMCqmRlrhUIG?=
 =?us-ascii?Q?W3x3QYxMIPvR0XFp6x3QB7CYp9NdHt6JQUrNaJ5EH9Jsngq4Afwf9rQr59ku?=
 =?us-ascii?Q?IRlBRWYaQLKUS1pXV+4GZv/r0mCTeRdb9wGmVVh0chlIjHFTesfNQIsGPJOr?=
 =?us-ascii?Q?kppZuNqgr+yJQ33FTHcU1lYPLAjYcuU2h4W33BYmTdNzxWcqoePYQEH1Dwbp?=
 =?us-ascii?Q?IdDHVlHe6KjQTWukz0VTFfrqlfnA77c2yXnJUnrJtgRkqNEhofIvcPRLBUBE?=
 =?us-ascii?Q?ovJnbVUE3aP8d0dBJc4TQgE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA5PPF8ECEC29A9.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BNqEyRI7uNU8hJfZQBQVSfZsHRRbV9IEnrNbM9+Q2fSAM0YecmXcMQncyYcn?=
 =?us-ascii?Q?sjjQWwe03VxTW9/HUueh/PY2xR2dsnwdla2FYLb0QfhjArBoObAWe0WQWAgq?=
 =?us-ascii?Q?dVJ7/yUS4TkOqsmB9t76kzMexsuS4yvW1JThaybhcippl4kmtTsR4imI4ewR?=
 =?us-ascii?Q?TZP5mK7RqIGTylx30Laa4O35acWMwdil6c8+BIEJPwiWeSJGt/n4aqrKQ78q?=
 =?us-ascii?Q?5VnRoIzs2xtueLpackmFob0tX2UqFk3GCSdeHnBjOEJ6tay+f1pDb9G9D1mG?=
 =?us-ascii?Q?6pxPpoQbh+1q/LlrOR1hMXoha4o8ilTnV9B8qkiOQTRPzLAD1Y0E8q5UD/V/?=
 =?us-ascii?Q?xNnRmodr0E7KUid/hBbQfhlhzbylo/RVtcw9N5DHYm12noLAaMMRH4p3HEtv?=
 =?us-ascii?Q?cnzSyoAYAI0MM37kmgRaLiwuqsjKdpFlfSEUD1Fo5xtPae8vmRN0xpxDTJ1M?=
 =?us-ascii?Q?gfUE4Rd5CHmgKNC55g031eZ0HjB8oYriDpQoJayMdj5d1bN0MG+YNqH6jKPx?=
 =?us-ascii?Q?ZBVQcjX4VsLM79/qgcn7bLr8x8rjedSR0dHtr7b2Qmqxi8Bl1iBKPFZMgHvS?=
 =?us-ascii?Q?ms/C7nhGmF6C9vfWvvfYU//cZS3xptsokLQ4zqzrTpgdrBYgNz41b3N7r3NC?=
 =?us-ascii?Q?PXFjkNqyWdl4NFEAgTbLjIvvP+h1BJWgTdPWy0lbYfW0y7HS0eO38Nv5EEuU?=
 =?us-ascii?Q?ZfMZlqqRlQk9nuiPikRF5BMHd67vpCZfjwbAYunwjKHo8KLzmsr0AmfjwyT+?=
 =?us-ascii?Q?JAEk/NB5rLgZ/lEFTvPEKp3xuZZWBm01Iz6DiNGcsdYnwFU6f6kqHPc+HLVo?=
 =?us-ascii?Q?Ik8LLmMooJUd/puQfH7AKMeHto1geiEh/6A/xqIQ9kojSpv7pDJZ7Q6Oy02P?=
 =?us-ascii?Q?GTHdM1GV2DTya48awAuslkF3K1jDV8E4bri1iVPcU2HCzcYN1kEGCVl1u6OY?=
 =?us-ascii?Q?+y816kaijP+A9C3sS+OPBHHx/olQjU75lYWr0TTZMrRgWQSTpazdxVwf5/lN?=
 =?us-ascii?Q?u9hjDGr83oKvj5YxJvARJHDaiVRQJBT5U2RCrrwfwi5zs09sh4R+kJWzMLJg?=
 =?us-ascii?Q?9u251loFuYb5UPLuX+0fBDmwx2Aibivob/uwqlpT4/lj8PL+jk7ys4+cvBRG?=
 =?us-ascii?Q?6r5pCukwed1SqMyv21x8zlVx3zVHnAMig/VGvYOWFfcQJH9wLNItgdtlsoaO?=
 =?us-ascii?Q?0dkkwo7iMsh47kzxyuhy7Xs29Ai8jaqWU6FUBMUCHuJJrBQ13uMCxO+8SqS5?=
 =?us-ascii?Q?YRsumtbdMVSjbB1kknjAdWTOke3Q4c/5PJObodgeS1NGa5iSTZGgtlp4yCgJ?=
 =?us-ascii?Q?8jOgUU20GK3obfYfBx5I1cFGFdW+HuCuk1DU+VCys4QR39QQkiyZ4lOpMNlQ?=
 =?us-ascii?Q?TL5eBaDw+YcqydhfFtrvifV1vaFPKV3a+5PO9DwKcoXqzN9FA0aBP90dt4mE?=
 =?us-ascii?Q?uKQSSsn+b7hhGkjXXMIMfD/TFmOoSEE8KiUpXAZ/oTDB9br4m3QHKXlR/pPu?=
 =?us-ascii?Q?d6Vgaf2hu6IMzmkg8fFVbCrHn+MOXVIZIBsIYDdPJVDVKLxA12U7PPHQrqXM?=
 =?us-ascii?Q?JES8g5/AUIAt5/jICWUp1ddln+OkU1UY4npeQZT16FIyfzMpnLrGEN3YR5fv?=
 =?us-ascii?Q?zeDDxXs6NKfKydylKuO2ML5lTQ2NDupuloCPDWy/i8MTRJq4PcnwVY6YVQfg?=
 =?us-ascii?Q?9lEnDdJba0b8WeP+m3CX5hZaEn42ToOFraEIlrzh/LymByoa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF8ECEC29A9.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7f7ce4-8f62-4c09-cc85-08de698b4723
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 16:33:24.8015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4zTRpBJPVRZY0afqq8y6T2xrDm2ep5HGH3FFuKRrRt18CudAuMbc0wXyFEPUDvVmH3Vhf1nq7x69bDHQe1nmgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159
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

Ping

> -----Original Message-----
> From: Clement, Sunday <Sunday.Clement@amd.com>
> Sent: Monday, February 9, 2026 3:51 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Russell, Ke=
nt
> <Kent.Russell@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Clement=
,
> Sunday <Sunday.Clement@amd.com>
> Subject: [PATCH] drm/amdkfd: Remove dead kernel queue cleanup code
>
> Remove leftover kernel queue (kq) cleanup code from pqm_create_queue() th=
at
> has been dead since DIQ creation was removed from this function.
> local variable kq was initialized to NULL but never actually used in the =
function.
>
> Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 449be58e884c..6d47ef5069b4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -319,7 +319,6 @@ int pqm_create_queue(struct process_queue_manager
> *pqm,
>       struct kfd_process_device *pdd;
>       struct queue *q;
>       struct process_queue_node *pqn;
> -     struct kernel_queue *kq;
>       enum kfd_queue_type type =3D properties->type;
>       unsigned int max_queues =3D 127; /* HWS limit */
>
> @@ -333,7 +332,6 @@ int pqm_create_queue(struct process_queue_manager
> *pqm,
>               max_queues =3D 255;
>
>       q =3D NULL;
> -     kq =3D NULL;
>
>       pdd =3D kfd_get_process_device_data(dev, pqm->process);
>       if (!pdd) {
> @@ -477,8 +475,6 @@ int pqm_create_queue(struct process_queue_manager
> *pqm,
>
>  err_create_queue:
>       uninit_queue(q);
> -     if (kq)
> -             kernel_queue_uninit(kq);
>       kfree(pqn);
>  err_allocate_pqn:
>       /* check if queues list is empty unregister process from device */
> --
> 2.43.0

