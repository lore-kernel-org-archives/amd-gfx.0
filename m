Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05027C61DB9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 22:23:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4957610E062;
	Fri, 28 Aug 2026 22:23:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ygAApivx";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAF2810E062
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 22:23:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckfiZk4R+44yPe3/jZEVcn1sfiKfkAhKN9FhxJ6SXATf3eqif+zhzVDKA+GsZc/YWrtSxLzV5l4UUOWR1qsSY3TyKQchVbFxXR47jyHDSk/nePmPRx+bgeqs+7FRQk5l00aaOIvWM+wHHD8yURBRBoidi5hbXY1r4ry4xAHep9RZuXGFrTkljOGUMWgYDBVW77/BrhhnFwnw5IquwPKhxmmS+vuIlCz/sOyrrXt12SV9hAP94v62MGIMCwkbgfbj8FCRwHAehRUbUaKVosn8Nc7R2YLJxHV4eXV0wS4GBtfs1b763PLnSH/7EExnzJBwUvRs0ewoFD+cnlGdAf0X8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YksMr1YE9gr410Rsvz/6vCVRPxfW4icXXdeqHHKYoY=;
 b=zHvRzuLtnQ3dmOLoxNtCY5HC2YcecLcWWtpXJlusa9H1rv1a+10mvW8eD8/ra8lovUAr4tZ9/oCpMA59he1uBdqmk5QY3/pT7D8vOW7MlbzZV2NVxZsvPRFheQeQVaxnpm9yTvVQACqIb0ojHmhjSnKpHZwcK9hKkBaeakIkqDf5JzTlGMd6ny/mbWVkxOE+SY4bnBsg4tUYuL3L2UUN/HfGc6Y833DIYep7D/OZMwsDA2tsNkN2Zh+lVwe6CnDb36t5tUqhv5qHXcvD+m7tH8nVSlJTF2c0iuB2fDNXeACiLPGdnY7Mkz1HYO4kZwogXsL7gXd8HVOHUdohc2t8Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YksMr1YE9gr410Rsvz/6vCVRPxfW4icXXdeqHHKYoY=;
 b=ygAApivxfp2Gw4WHS4++fYUNGgj8plIYryaAguMitvgbnCZo0mK1SnGS3V2HVnbxBJOYSlI7drOnJ+Rx0+zyquPMhNZoGUANbjpI2JXp0rxPWQ72K/u5E33un50jhYHc1vRmejaQtQoAvJ1g8qT2L20AXRRZ2r2Kd4aWQYgL1jo=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by CY3PR12MB9629.namprd12.prod.outlook.com (2603:10b6:930:101::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Fri, 28 Aug
 2026 22:23:00 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 22:23:00 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdkfd: mark queues as reset after a full GPU reset
Thread-Topic: [PATCH v2] drm/amdkfd: mark queues as reset after a full GPU
 reset
Thread-Index: AQHdNsC0bBxFs5gIW0WsM0mBnRfRJra0CXFA
Date: Fri, 28 Aug 2026 22:23:00 +0000
Message-ID: <BN9PR12MB51469A928D7A83D6AA044574F7AC2@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260820105537.3138777-1-YuanShang.Mao@amd.com>
 <20260828074145.257673-1-YuanShang.Mao@amd.com>
In-Reply-To: <20260828074145.257673-1-YuanShang.Mao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-08-28T22:20:56.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|CY3PR12MB9629:EE_
x-ms-office365-filtering-correlation-id: 076096a3-593d-466e-bd8e-08df0552eb30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|10067099003|5023799004|22082099003|18002099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: emVbIUqfSRpX3vkmTEkn2PXbyEOm+BvLwoHRrv18Xl64QvQAQrJAKULFMAXOfZeKHI0Oe4uH4MvfRricicprdqGA4icFuo4E7DGW6KmqPaAhov059TBx2KJSLfTep2ppJVtuWATaCKpxvF+P/iCyIR228BQm5jLPx7TGm9vrMZvQhRmcMOJpUqh9FT+ZLNbwnnso0Xam8W3oEb0L3x+xfowxlR83bRqKFs3gG50+zRRriOU22PR2ehJVhXTfjxIetOL5sdEeXjmi7b9JzBFmO4LJ9t8i0JiVWv9yRoyEseP6L0uoEClsfeKs1RSW7fHEC3qfLhq8KLTtxABVGRYn1ix+/+JF1EIaTJrP5uoHYjnVpBJhJcfj4uan6qtlr9eMp8nClx2PdEv2uj5QMXQD+bWatHcXGcEAmC17EvtJFZdeA15NBWJuZugHBdoVgOy8piCZVBtyr2s3/Grwi++5973YKuEgcomClCGURkG6MhOxKnzg3ZF0eKENWRzPIUXnnF2SFT3e/YQ8GrJGFUJTRupKKH/jn5A/yG2EwlVYp/dPiXJLZvsVgoXBTOzKtn5iI4+rKNecb2qmiFR2AxK7cDNooKU+Fus2dracUyZSBBKu+59u52ZWFGjoCLRQfNxYWo/EJc034k9013+wF1BjMBL3pAh7/V80SC+TRKpVRLJe6Vcp7Oh+rVaIImhMwoFJXSW8CXyNk7d5s4TqGFoqad0wOND01fCjsEMj4862Z18=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(10067099003)(5023799004)(22082099003)(18002099003)(4143699003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0wm2mQvL3G3aNBXlclfLwXg8y1OGXRmWt9lsh5bxXUjXHDBGI41GFwSeXI2v?=
 =?us-ascii?Q?mUK34WYdJNw3SfQBJr4vJllEd6AAlV2wAYacy6RmPvKeq3/P5oTSbHxZHZ7e?=
 =?us-ascii?Q?EWrh/lk1LdGXFZy+TOFDohOQvFnShi2G0fpg4EQxz9FJ8SxcK0q6MQvzh9iL?=
 =?us-ascii?Q?MwLG6JL97/y4BPzwqzURVtER3aD/bYNKIPRKkkc5WZ2QAzMfV3wpXGHNVPsL?=
 =?us-ascii?Q?0Jou/1sE1KJdkEFfFSVOp3OHmv3dZzlo7IsUSXOcNFDgHRSbxFv10x3khSfS?=
 =?us-ascii?Q?BAJl8cTSE+DqKPV7MWZNLzCIVprd/MBjK3/xU9p7dBrUTWraTRk5m+VH5+uq?=
 =?us-ascii?Q?Sn29cwJPYvaYdhix6GWPBlUT3K2FtG1fv6lov/N41sBHuS0D6VWAUimnG7cx?=
 =?us-ascii?Q?fv6VAAgMh2TXBn5Tv9AuzSaP0/tRHaeC45dMwQQviNQ3wvKrb34L7CqoFACR?=
 =?us-ascii?Q?IRg0/r+YOuank49dBccuIuuUj88xGoAB5NxeegFcMPzz3dj3tlbjNCC4OGFY?=
 =?us-ascii?Q?Zg3FCHD0dJvUF+OsITbF2PmZeV7f6X+76SypNRrJyxQcwkDDun9vPy+kGExr?=
 =?us-ascii?Q?4ZNn4e+DRPthhcMYD4k01EDu8akvSIgq8YX4DHgfHA+eQ7GjjsN0eQXxGa4U?=
 =?us-ascii?Q?W/H41FSgDwrwv+oBzb7OO9G6O41XuU9OIOMHpN6tHjyHx/5bjTtqnhEAN/q0?=
 =?us-ascii?Q?gXzohQX6Ln6kcv8F/xmkxIQ7QeNv9U/Q6Qv6jqGPJ5rAX+VI5voo3ljw5vta?=
 =?us-ascii?Q?7vb5WikefOTkC0baz7fjxD3b4UfCG6ITVHnn+24pN67918Z0aFLb/TAJ6Pe5?=
 =?us-ascii?Q?oUVmESlk3Enad2hftinv1bFJOPKndS8/Jb8exlJwt/PnZOq6ybTu/oW6SojS?=
 =?us-ascii?Q?eI/sA0xLh3jqURIvDmKWcI4n8XrVANpBDkvPFzg/9O+HrHoIyukLlijI6pSz?=
 =?us-ascii?Q?gSkC/JtwrQqc4tUN5hbQusSuttRwT2Swx9RjnhKFjqbym6SZKBR9/GyPO+gB?=
 =?us-ascii?Q?EJD5PbopdegfmkvNO4cecYw6kEZRX0PKJylk9JBHFij3JhjPM7V/+e+WWoJv?=
 =?us-ascii?Q?z40ceIo7Ak/nAAZVS5wQ2KPgaFzAT/hhkhxOS74zvzQeEjCphs/NfnVMREzB?=
 =?us-ascii?Q?/8zUA/mPEb6Q1ZiVfKjjp9CryRZleGx4yMpQKVnIPoxhaOOljPlYSvnfJPD+?=
 =?us-ascii?Q?euOHC9AIkj9gy7nXqN9p3vxpjRNocmy23yyHHQ5cu1K7+Bok/PXSgff4k/XC?=
 =?us-ascii?Q?sdabjKL/zBqRL3JXHIHiv0s5EAumwyzjz2PeBWlxD4m794HSuYYV09buwsRb?=
 =?us-ascii?Q?dJUDyjhT6LMbzUUAvgemzP7i/+7MnoNfylWn6RZBr803jpJFDIM63PVntHKU?=
 =?us-ascii?Q?gAwXIUvCqzeoEulalWGlJNNhFqysvkoB1y2dutTAKurj/7yjKRQ3I1/kvCag?=
 =?us-ascii?Q?fgEkwU39iev0YMTMDnwadLIunI7pJvhDLu7lIzXiojxLXtAkX4jOJCpTtFYC?=
 =?us-ascii?Q?ELFoaRLRpqh6tzUiF+OEhP7bYoKEkFMlAwWsFhkWRQZ4p8AWXwdVTN9oColW?=
 =?us-ascii?Q?Ovtnm1QrMz18DIuFmUJcmca4VN/PFexDjJ8iVIcybtkPcrGx30dY5mnzQDV6?=
 =?us-ascii?Q?AeHlvxfddS+2kSaoCbuGX6ZNQKVIXXoydh7niYNXUTcaoB3Sz6FjVNf1yOQM?=
 =?us-ascii?Q?RhUFxLSW7ModXajWoFt54SPnzOERIrf3ZcN/5Sbhovz4dWHK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076096a3-593d-466e-bd8e-08df0552eb30
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 22:23:00.0991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wKQkFIDbh0/YsMBnzWyMaka2spoJiD+NNEhUhBxGk7Kj2an8XrhApVINw4QYqU9YhrpnQ4VZQI3gd2Qym6O6Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9629
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

Public

> -----Original Message-----
> From: YuanShang Mao (River) <YuanShang.Mao@amd.com>
> Sent: Friday, August 28, 2026 3:42 AM
> To: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; amd-
> gfx@lists.freedesktop.org
> Subject: [PATCH v2] drm/amdkfd: mark queues as reset after a full GPU res=
et
>
> During a GPU reset, evict_process_queues_cpsch() calls remove_queue_mes()
> per queue, which fails with -EIO because the recovery path already holds =
the
> reset domain write lock. The loop aborts on the first queue, leaving the =
rest
> with is_active still set while the reset wipes the MES queue table.
>
> When the process later exits, process_termination_cpsch() sends
> REMOVE_QUEUE for doorbells MES no longer knows about. MES rejects
> them, the driver reports it as a timeout and concludes MES is unrecoverab=
le,
> so it requests another GPU reset.
>
>   Failed to evict queue 2
>   GPU reset(1) succeeded!
>   failed to remove queue from MES, doorbell=3D0x1002
>   MES might be in unrecoverable state, issue a GPU reset
>   GPU reset begin!. Source:  3
>
> Mark every queue as reset in kgd2kfd_post_reset(). This clears is_active,
> corrects the queue counts and sets is_reset so the queue is skipped later=
.
>
> Add a verbose argument to set_queue_as_reset() so the full reset path doe=
s
> not log a message for every queue.
>
> Signed-off-by: YuanShang <YuanShang.Mao@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v2:
>  - drop the enable_mes check and mark queues on KIQ as well
>    (Suggested-by: Alex Deucher <alexander.deucher@amd.com>)
>  - add a verbose argument to set_queue_as_reset() so the full reset path
>    does not log a message for every queue
>
> KIQ does not hit this bug. Its evict loop has no fallible call in it, so =
the loop
> always runs to completion and every queue ends up with is_active clear,
> leaving nothing for process teardown to send. Marking on KIQ is still wor=
th
> doing: after a reset the queues are gone on both schedulers, and is_reset
> states that, while is_active =3D=3D false only means "do not schedule it =
now" and is
> cleared again on restore.
>
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  3 ++
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 36
> +++++++++++++++----  .../drm/amd/amdkfd/kfd_device_queue_manager.h |
> 1 +
>  3 files changed, 33 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 586e640f13dc..84bc04c4a55c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1033,6 +1033,9 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
>       if (!kfd->init_complete)
>               return 0;
>
> +     for (i =3D 0; i < kfd->num_nodes; i++)
> +             kfd_dqm_set_queues_as_reset(kfd->nodes[i]->dqm);
> +
>       for (i =3D 0; i < kfd->num_nodes; i++) {
>               ret =3D kfd_resume(kfd->nodes[i]);
>               if (ret)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index a23384571193..350dcb8c21cb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -75,7 +75,7 @@ static int reset_queues_on_hws_hang(struct
> device_queue_manager *dqm, bool is_sd  static struct queue
> *find_queue_by_doorbell_offset(struct device_queue_manager *dqm,
>                                                  u32 doorbell_offset);
>  static void set_queue_as_reset(struct device_queue_manager *dqm, struct
> queue *q,
> -                            struct qcm_process_device *qpd);
> +                            struct qcm_process_device *qpd, bool verbose=
);
>  static int reset_queues_mes(struct device_queue_manager *dqm, struct
> queue *q);
>
>  static inline
> @@ -433,7 +433,7 @@ static int reset_queue_mes(struct
> device_queue_manager *dqm, struct queue *q,
>               return r;
>       /* Proceed remove_queue with reset=3Dtrue */
>       remove_queue_mes_on_reset_option(dqm, q, &pdd->qpd, true,
> true);
> -     set_queue_as_reset(dqm, q, &pdd->qpd);
> +     set_queue_as_reset(dqm, q, &pdd->qpd, true);
>       return 0;
>  }
>
> @@ -2369,12 +2369,14 @@ static int map_queues_cpsch(struct
> device_queue_manager *dqm)  }
>
>  static void set_queue_as_reset(struct device_queue_manager *dqm, struct
> queue *q,
> -                            struct qcm_process_device *qpd)
> +                            struct qcm_process_device *qpd, bool verbose=
)
>  {
>       struct kfd_process_device *pdd =3D qpd_to_pdd(qpd);
>
> -     dev_err(dqm->dev->adev->dev, "queue id 0x%0x at pasid %d is
> reset\n",
> -             q->properties.queue_id, pdd->process->lead_thread->pid);
> +     if (verbose)
> +             dev_err(dqm->dev->adev->dev,
> +                     "queue id 0x%0x at pasid %d is reset\n",
> +                     q->properties.queue_id, pdd->process->lead_thread-
> >pid);
>
>       pdd->has_reset_queue =3D true;
>       q->properties.is_reset =3D true;
> @@ -2384,6 +2386,26 @@ static void set_queue_as_reset(struct
> device_queue_manager *dqm, struct queue *q
>       }
>  }
>
> +void kfd_dqm_set_queues_as_reset(struct device_queue_manager *dqm) {
> +     struct device_process_node *cur;
> +     struct qcm_process_device *qpd;
> +     struct queue *q;
> +
> +     dqm_lock(dqm);
> +     if (dqm->processes_count)
> +             dev_warn(dqm->dev->adev->dev,
> +                      "GPU reset: queues of %d process(es) are no longer
> usable\n",
> +                      dqm->processes_count);
> +
> +     list_for_each_entry(cur, &dqm->queues, list) {
> +             qpd =3D cur->qpd;
> +             list_for_each_entry(q, &qpd->queues_list, list)
> +                     set_queue_as_reset(dqm, q, qpd, false);
> +     }
> +     dqm_unlock(dqm);
> +}
> +
>  static int detect_queue_hang(struct device_queue_manager *dqm)  {
>       int i;
> @@ -2499,7 +2521,7 @@ static int reset_hung_queues(struct
> device_queue_manager *dqm)
>                       goto reset_fail;
>               }
>
> -             set_queue_as_reset(dqm, q, &pdd->qpd);
> +             set_queue_as_reset(dqm, q, &pdd->qpd, true);
>               reset_count++;
>       }
>
> @@ -2546,7 +2568,7 @@ static bool set_sdma_queue_as_reset(struct
> device_queue_manager *dqm,
>                       if ((q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA =
||
>                            q->properties.type =3D=3D
> KFD_QUEUE_TYPE_SDMA_XGMI) &&
>                            q->properties.doorbell_off =3D=3D doorbell_off=
) {
> -                             set_queue_as_reset(dqm, q, qpd);
> +                             set_queue_as_reset(dqm, q, qpd, true);
>                               return true;
>                       }
>               }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index c9f9f7a87111..8ddde9f75541 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -333,6 +333,7 @@ int debug_refresh_runlist(struct
> device_queue_manager *dqm);  bool kfd_dqm_is_queue_in_process(struct
> device_queue_manager *dqm,
>                                struct qcm_process_device *qpd,
>                                int doorbell_off, u32 *queue_format);
> +void kfd_dqm_set_queues_as_reset(struct device_queue_manager *dqm);
>  int kfd_reset_queue_mes(struct device_queue_manager *dqm, int
> queue_type,
>                       int pipe, int queue, unsigned int db);  size_t
> mqd_size_from_queue_type(struct device_queue_manager *dqm,
> --
> 2.25.1

