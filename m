Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF11C3DA4A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 02:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF73D10E3A8;
	Tue, 20 Aug 2024 02:57:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SqTE34V8";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0681B10E3A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 02:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WlB7LgA6mGX4DRvOOZgWaiWD1RiSosLCEBDrlC/L6P1mIksolQEGBh0I6OmWH8JVlDzVUqjMAZV4ZtegTmnRr2LIfL6ymPlzxoeiew4mknQxYCGv++n0taRMrVbSDcCWOYoT5DgcFxIuSNHpp4fvyRQ3VQzXHlx91lW3kJRvMSCsNEcILmvAJ3OfUQVdYov6gH8Ljw5qyC7wKmkVTevpI8dVUVxmHxHuk/FZ4r2l9F8cRMoQRIL8WrzmZQXm/no1dvehMa/kqe0sn+KB0TXpIL209Pacu+W7oQ3+PFhRJtVvg41mx1R19zSS0nT7qi0CmiJekiQDHgTIv4hieEck2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9B1gQWG58ul6IexTrIXGbTxj5Uw49rOTsbaINaatWRc=;
 b=iNiJuMh5PqRCBWFMu5PTPoDV0421ZyyyM5r7iSagDSEnWCSKHu1BpsWzRcZAuDM46NBSluMfKAPZwq54AeolTRb4hiHwcGCYI5IpTPOeeTuZtwBZO4/RMwWo5Nm0frjlU3guGlm9dNiieSbK6rtkDlmnGnCV+zTUO722OTPaRkKYuIJSVUI7YCtWZdpYuwn+VoNKW+NW4KppTQuwjjZHi7uCI8vY5byQ2YtFqsiaD0gb0Ieub5cpdAmLzZWtoCnTwE4lKihLaQILvkORDcSBXW2l43hvuiSbdU8Or743jsHXUj1AJzMgRwVInSGddtIPbK53s6KV2TT2eL7gVB3T+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9B1gQWG58ul6IexTrIXGbTxj5Uw49rOTsbaINaatWRc=;
 b=SqTE34V8cW/zTzW/tiiig9MrYSKnFWgWATALDzRy+gMOO1tnmBNnyT2p8CYhQxbxmKeWBG3jc3yM7ktxmC4aVbA5iXmw4KoNuKdi3KrKFx8mzmZZ9JilqaOTG5jHVo6O5stw7M5+Nkm+U37P9opRkVcE5F/AJkkhqhk+EkcZgG4=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CY8PR12MB7659.namprd12.prod.outlook.com (2603:10b6:930:9f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 20 Aug
 2024 02:57:38 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 02:57:38 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Fan, Shikang"
 <Shikang.Fan@amd.com>
Subject: RE: [PATCH 1/3] drm/amdkfd: Check int source id for utcl2 poison event
Thread-Topic: [PATCH 1/3] drm/amdkfd: Check int source id for utcl2 poison
 event
Thread-Index: AQHa8kqNVVYOa9GwTk2rhggSWjmUXrIvdGsQ
Date: Tue, 20 Aug 2024 02:57:38 +0000
Message-ID: <PH7PR12MB87960A384F9D5F7D38D69B80B08D2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240819151437.13808-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240819151437.13808-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a94c8450-4242-4b14-9bf2-d9b6cce30dc4;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-20T02:56:05Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CY8PR12MB7659:EE_
x-ms-office365-filtering-correlation-id: f5481fa6-f1b9-4bf1-3cfb-08dcc0c3d9da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?kswFIVrx7YjaGjGhseGQXHmBO8QpPun+/xY3Xg1AYHsR6STazdOhe1Hnj86C?=
 =?us-ascii?Q?K0sBx9ROhEgJ25xjkaJ0PBTerV5FF/hp5rv2zJhDxuTmxnlWc0Ac67ieRyrp?=
 =?us-ascii?Q?iJR1JIKyV1JK5GSeF2nTI9LPhBpXHcq6v+fvX8532h2MhaAa0evWa7Lz2MRy?=
 =?us-ascii?Q?6wVp7wYGmHBoAwt16cprqFfJyzCCKu3IIsx4cV1Hs4kKoXOSF3kYDdC8J2oh?=
 =?us-ascii?Q?1YNY2xaGd2tHd8cIPSqdqTeqZ0EYycGbZGNFKxGzjEdisi3NeFms6CPTxdXp?=
 =?us-ascii?Q?Iw6pHEK4GZmB+7juqZj75K131PhLLCdd7IKRtKzUSa2ES92Elb3twhdGiun2?=
 =?us-ascii?Q?hQRnsDf5oRkCk1y9YO/Wcwwu0lVpK4tI0ga4wM5BwIbkw28BQpuUVEIHp7rs?=
 =?us-ascii?Q?xmRn9nLCGvkckIXwgbP9mGDNeR3oxygfJpmflFzjK9/JkcCU8RAbT+Akm1bi?=
 =?us-ascii?Q?qvqadHSBUboXWXHBwflERScrzHhn0uN0NbqBHpmUsDoKgDbZ0SkGZ5NeNt1T?=
 =?us-ascii?Q?h/cq0K33VAjU6s/d+yHiUsdgbQvXOuQnp77db8wCJQKw1zdi1RngmIPtUxa0?=
 =?us-ascii?Q?e3/T0zbJMBdexZucDe1KDRA7dIe43ljpn19di5ww1NQGt8peR5Oj2okhpXu2?=
 =?us-ascii?Q?K2xW2xtNXx2pMuvlfb1JdAo2ZJnazfYfbere4/6wQ4sGvvdHQRzYxBFOKYcP?=
 =?us-ascii?Q?cOTow8dzOPTzIzSYTlIeSiUGOXXsVECDKDf74nMn9zCRhgK8TsvuHR9yOnLa?=
 =?us-ascii?Q?Wbn0MxbE9MmOlA6MvcTCG76ey/fPUA1SOb9X7lG1/FFJ26i2SC5/4vNNcptD?=
 =?us-ascii?Q?GG596dufKK9NB5PzcaNbg0sJRqJoELFptn2Fc41TVMRms4dhRlx1eoF8uaVm?=
 =?us-ascii?Q?d/BfF7jlkfikmti3hLi8b9kUlhGhZyLpqDYSRUgsrR3YWLSQ/k1tbJQbNLJK?=
 =?us-ascii?Q?xPAZAiP/UHuhmdj8DjkB+PtGM1PiQKEVtGrhNt9on+Cl8l0DS21c3NRNS+NA?=
 =?us-ascii?Q?xFyUGX+7pv6y+NpiVeo7ASceyNoGxjRC0mu9fCDJoRvknUghSl7j2Ygs+t86?=
 =?us-ascii?Q?ygcwoXKqwrgf/H3mdME/LHJpJwubR/TKHC8pa47/qx+Hh5biAa6Qb3uAUSUP?=
 =?us-ascii?Q?6jPRv1gEB50ipjkxIfidfb5UsBZLwWipMkQz6QO2MvoSkWtJIF+n7f7J81s+?=
 =?us-ascii?Q?hVTphEKi9sGQ8nojMzUxO9Jvp9ZaGpDmSgkEDwwr0l/+gXn0ADKPFy/MjR/Z?=
 =?us-ascii?Q?Z4g7PgNaUZhI+iETbHDG/6QjAq4qi4rBtsLlFu4AzMg9Rmw9pL7TP3CW/5ql?=
 =?us-ascii?Q?ty9MKFsgyADj+XLbpf2L3N62qYc5NDYkWe5/ewq5Ix2Ymj91vn95N2Xvda9d?=
 =?us-ascii?Q?7cSje4imfnMoRHrrQ1LaI8OsAdp16T+mSjog9u8vmJya9JiA8Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QBVc5keWXJCeL2rWAdY5g4PaS8VgAxYOwLIFXXMv5GKI4Wffl/gMB/uVMh7a?=
 =?us-ascii?Q?V9/wx/4V1tIldymDcJ3pcDCYenPSwA831rR3NogkGAA79ROiFadfVJW8EHg0?=
 =?us-ascii?Q?1rlwPuoNZ73p48gkiev2IQJzr/vByuYuYmXWX7z5T3JNPhmHXAprfkgmDPOC?=
 =?us-ascii?Q?xqHVmkq+ji+BM5iBVx5JlB1VHyeermhrb0WNffdcQJEod5/s5+Mmn9SDuWc8?=
 =?us-ascii?Q?19oyZIImcf//vmx8aaSnihvCQjh//GL8PwuOBQCsnROg6ApMK+ID2fGucFyl?=
 =?us-ascii?Q?3vMiL81Xi20Oe1CfgCFkxev4ONCEOlTSNyxvQNXyYmlj+vEQmoSfQc9S9j6x?=
 =?us-ascii?Q?RoKmPzdkU3Oxc9i4Go7aU11lu1EsQnguut6z2e2eQj2phsuPUMSp9wxx+IgQ?=
 =?us-ascii?Q?XCvl4tJEfyJuMfOcmr0iaGYE+WCPbdWqYB/mXr0Dk1/W4oiveOJL/ptuK7c/?=
 =?us-ascii?Q?KLk2RqnlSsA64kL5GTy5g94+aoOmn7SvkcSYk1K9BpULGk2XSQouuw6FQhck?=
 =?us-ascii?Q?9J3VB22tPGIyRlwi4eOHDVD1CuXbTJAyLJa+ASwXQyq7OtEn7EJZyykborT6?=
 =?us-ascii?Q?kXjRZ7FgepQtyateSKp0rZEqwSHYPYNay1ztZKavpgPbDHnaEbR/DhIHb7IQ?=
 =?us-ascii?Q?xIzAoV9hXNbGBKUnzjSlG2qy/4ihsCmyY01X+mG2SABl3GHhpIB/EFS1m4be?=
 =?us-ascii?Q?GQix6phIFUmjByinCsDqCg+43wt3a9vlniCJQnWDkZxmO09OO6hYhFeV34SX?=
 =?us-ascii?Q?xJuwmKv0HihGFitOlM1Hrh0FsYHHTGqWDoFHaAQ2iRKR2hk8vT8WJMDVsiMy?=
 =?us-ascii?Q?wgfnuM0QDREOniud105kzS/XHTAF0zjMETnluqIckEpw3uNWuzpDNrAiuVCc?=
 =?us-ascii?Q?oixxxg42cfELNg75tk/Dj6CI/NAZ4tCvmi25AJoYD2fBP/2pbImc8EbMi+oP?=
 =?us-ascii?Q?fjXvNarAhIh24z8L5X3b1mVDP7cGMJV93huE7wd28hwPnrlFMBLfycovPs+m?=
 =?us-ascii?Q?CWkTgJtgzrdRuUZcHtp3xtphEm6bmpx2eRwasv60OY277qYhMyPHFxDHvjOG?=
 =?us-ascii?Q?Omt5c44k8V1/D2JzIGdOoUQhGkDD1BqxphI265v6cMR/K6tg18SrGjOdOVun?=
 =?us-ascii?Q?jVi9SvFRlyHY9BfQH51i90mpBI5UbOR2IFqoR1XMrrnqSwU/igTVU2eORuYF?=
 =?us-ascii?Q?f0VcWy33qx8WJtt3xL7R39nc+ncn+0nLt9bNDMfRMw89W9PnG4wXyCMpBQ2k?=
 =?us-ascii?Q?UGPzNjNTMIMm5qAET1PWs061ZDzwHEhSOQvrUUZlUK6WSL1oKjpQSfe8rN6D?=
 =?us-ascii?Q?Osv1lYF0pVGq2bAEgCFjJusTeRXJFowUyxN59JRJfTdc7hujS9qK19WbK36S?=
 =?us-ascii?Q?AwrF1bWqhJgZJ7GMuQf3wB+kdtb1v01bXeiesmhxOozqJv2ylrAkyUlqMQ1N?=
 =?us-ascii?Q?+oHxDZHoqM08LPpPNajjuy+ZBw0WNheqIFvsUTh95U2i7Yg4cw3EHWgwubUr?=
 =?us-ascii?Q?tlYq4uU1+oALrzRBi9v85sSB3+icYoCu7Md1R5ty0HdD2FGTCzTLvUoOwqUi?=
 =?us-ascii?Q?pX1AfO8BfG1s4jMgTBM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5481fa6-f1b9-4bf1-3cfb-08dcc0c3d9da
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 02:57:38.5600 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7wHrqAFfDAnjgigVdjQucXhUz+vK9/fAOquCRcWSNPWbNtOzw5JCfewhQvAl4H3J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7659
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

> -----Original Message-----
> From: Hawking Zhang <Hawking.Zhang@amd.com>
> Sent: Monday, August 19, 2024 11:15 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Fan, Shikang
> <Shikang.Fan@amd.com>
> Subject: [PATCH 1/3] drm/amdkfd: Check int source id for utcl2 poison eve=
nt
>
> Traditional utcl2 fault_status polling does not work in SRIOV environment=
. The
> polling of fault status register from guest side will be dropped by hardw=
are.
>
> Driver should switch to check utcl2 interrupt source id to identify utcl2=
 poison
> event. It is set to 1 when poisoned data interrupts are signaled.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 3 +--
>  drivers/gpu/drm/amd/amdkfd/soc15_int.h          | 1 +
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index a9c3580be8c9..1196dccbe6bc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -448,8 +448,7 @@ static void event_interrupt_wq_v9(struct kfd_node *de=
v,
>               if (vmid_type && client_id =3D=3D SOC15_IH_CLIENTID_VMC)
>                       hub_inst =3D node_id / 4;
>
> -             if (amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev,
> -                                     hub_inst, vmid_type)) {

[Tao] the node_id, vmid_type and hub_inst can be also dropped.

> +             if (source_id =3D=3D SOC15_INTSRC_VMC_UTCL2_POISON) {
>                       event_interrupt_poison_consumption_v9(dev, pasid,
> client_id);
>                       return;
>               }
> diff --git a/drivers/gpu/drm/amd/amdkfd/soc15_int.h
> b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
> index 10138676f27f..e5c0205f2618 100644
> --- a/drivers/gpu/drm/amd/amdkfd/soc15_int.h
> +++ b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
> @@ -29,6 +29,7 @@
>  #define SOC15_INTSRC_CP_BAD_OPCODE   183
>  #define SOC15_INTSRC_SQ_INTERRUPT_MSG        239
>  #define SOC15_INTSRC_VMC_FAULT               0
> +#define SOC15_INTSRC_VMC_UTCL2_POISON        1
>  #define SOC15_INTSRC_SDMA_TRAP               224
>  #define SOC15_INTSRC_SDMA_ECC                220
>  #define SOC21_INTSRC_SDMA_TRAP               49
> --
> 2.17.1

