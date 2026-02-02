Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32877E7FDF3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 23:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD19310E038;
	Mon,  2 Feb 2026 23:33:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n25y1iI+";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012010.outbound.protection.outlook.com [52.101.53.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7A7510E038
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 23:33:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Er3VTNY6oTMh3IzFNyRQMVQimMo2nG9o+Q1+17C+fC0A1/6ydgg6N72iS+PiqH6wB1nQbVKBwSNdekKyqEkuVY39R270qQdN6qxQNQ0LUiku2UfUt1FufWuiLwpmD4wAXRk9yYNpLUVo0+O5XBJgiLPYO6SznrCpAjnRlHJktk13HlrglWNodDFJjk7UzeHledh3HmguleUtwXbjubflYCQePU2lWsaLK/GeCTKAwPMeDjAoZ3ZS3m2a+yhPywu/zeJWQWHP16RFOX0AvczNnVduTopu01MMnpKXAFHo3Bm0N1YgpcOyfbeNNqYXskueEQqffSJl5PpO1y92o2hDdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BY3HfIPY3IuIWleNoxG5JAilYVYiSpjwoyJSSbsV1sw=;
 b=lYIejftEGgYcLswa+tqAP7Fjr+qO0ZSqnnj/WEmsVVabTA05dVrN9EQzm2DPDCqJ17Nc+ihEk8YO57lR0RMjbohUQNf8lnPegTqV5LLjPCzQ+IifzNV0r6q+NYpZQcCPrXqVLa4pjW312LRxJF0YLBFhMwHLJ3vy3s7O4g15eLi8NHllve3CIwhVYJbDohakSEbW3kwWa4YWjBNKUHjxLGumfVPuR7iq33bXxM3VH09uHoxCt6vu8yR1lRSssNHZP3/ezBvXabR0NfdmP9FyFtxGAeQWXJ3X0KOYmjFlKqTd/xju2MSByJVBC1yj6/fq3Ul3L0sysgRPVsMXBGgXLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BY3HfIPY3IuIWleNoxG5JAilYVYiSpjwoyJSSbsV1sw=;
 b=n25y1iI+NNbFpjH5hWTpvf8ZcFCTcAt7H1tG2ygeVc7mwBt7Eld/SEm+zcpb1AOmHGQ55oMt5MW2kw6okn0CGc2ptr/N4trGlqWh3OoepVlhep1/sMNi2TcoxjEfEP6i4y0YWWzQastW6Qmgr7vCCYwwz6jxGgzgBDWv4TbKXkI=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SA1PR12MB8988.namprd12.prod.outlook.com (2603:10b6:806:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 23:33:34 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.9564.013; Mon, 2 Feb 2026
 23:33:34 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v4 6/6] drm/amdgpu: add MODIFY operation for compute queues
Thread-Topic: [PATCH v4 6/6] drm/amdgpu: add MODIFY operation for compute
 queues
Thread-Index: AQHckEVHRHxct1PWu02aVf3q8DhZ3LVwGAHQ
Date: Mon, 2 Feb 2026 23:33:34 +0000
Message-ID: <DM4PR12MB5152536EEEFD47570B3301D1E39AA@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260128105847.2898288-1-Jesse.Zhang@amd.com>
 <20260128105847.2898288-6-Jesse.Zhang@amd.com>
In-Reply-To: <20260128105847.2898288-6-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-02T23:33:02.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SA1PR12MB8988:EE_
x-ms-office365-filtering-correlation-id: ff8bcef8-6966-4bc5-4df9-08de62b37b89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?+oGoN/NEcsWoWrQiPEn+P2AaLyPIds9YRiZFZ8M2PmKKs0yGI3Y/1KhgKXN9?=
 =?us-ascii?Q?oq5Pujk9cpK2d8YB2pJCjMNFoRve+ar37VLYps5DmSfy5DhY8IM2PCnGGnrx?=
 =?us-ascii?Q?FtD/PU9krQL1mUvYJttT2UwGxthRCzNcoqZhH7jcNp+I72NfB2G4TFJjggSo?=
 =?us-ascii?Q?zk8I0Jro3lwDnVLMTdiK5XLL3vkJ+uLbZ6D5E8vb7hhaz51C2BYPZHYb4jFN?=
 =?us-ascii?Q?SaAePGXTZwXzv5c+O54/S4obegZhrU+rMXeMnqxksMarjfjDMPWLyT6OdcgE?=
 =?us-ascii?Q?+5FG0ckhCwTNXZIpqx1eGB35nUd1XzazAavHhphVF7avuPSWOIl3AqBh9Rrk?=
 =?us-ascii?Q?4fmvy/9lieSsI12tldhneWQtPY9BEHY5JgXNn5dwE6c3PcgBwLFbBuW/2Mqb?=
 =?us-ascii?Q?C9eCIc4zH2ZY83jOyvndt7kj3PIrd93hgKfEuK0QOxkEPbpUqef5rjqU4CFV?=
 =?us-ascii?Q?bhvb6BL6EZGdMaT9QSNbvSUYyfV2JwlBAmNo55NTTWNe1ZGutSfNQ2BeIipY?=
 =?us-ascii?Q?SpXgEAp0d7LjRWnSiKibLhRqfakXWpPyGT6fKWk+BwReKzCRqVvhMHKqfvkK?=
 =?us-ascii?Q?HI7jJPFFos3wZrYLk8Ow8dD8Z9iZWo25UyosTYlLyZOABPqzBZJnHBB524Da?=
 =?us-ascii?Q?EDX047tZs8cSa8nNmXgRyQizC3SEHP+0Zs8ZMk9Aq6IDGq4lkFHv9v10BYJA?=
 =?us-ascii?Q?4aBEQxLDX4NEcIECsqr421V5Q+ljSZEikZ7JdaEFSZOs+x+qp7ddrF80eAa5?=
 =?us-ascii?Q?gQeua+n4usuh7b9wDSul2QNbr+rLev7DycgIWhoNZxaYgO1SozlU9agATi7L?=
 =?us-ascii?Q?LDUA0WlqA/shZYbT1VThLX66Wmlh8p489x0lv84LJTz5uhrbl5H8XzozKjta?=
 =?us-ascii?Q?BQIoutFgGZ8JHFotnel0F4BEMrXqva1WPZLwQ5KbOO2RkjV1qZlbecAtlUdo?=
 =?us-ascii?Q?DM0LtimnqXmKNH8JWjxY0oh0skW+xhnwbdvdWN8QfHqbkfStP13sR6+pkYn6?=
 =?us-ascii?Q?N98jQsqwc3H1Ai8+XOJVwFOuQJ7YQaaFv6stkeX7m/USCb0ZozHQ//owWy5P?=
 =?us-ascii?Q?kOuKROlOHLyNZLBd3IMAB8NQy8iasrJFTYnbtg5MRjn8Uzl8MTuUbSlk8nzn?=
 =?us-ascii?Q?Uff1K1WD/cMqdqJU5rnHowgNkHWKSCvwUfTVTGawVLot31WAJh1R2gEfvd8Z?=
 =?us-ascii?Q?zNIp7T3O6WR2MSmCJum9DacbHxPUbRt17MNoEWIqkop3yXFKF8tnUYTxqjUj?=
 =?us-ascii?Q?gl07iI0ZbgWqwPZU479KMPcA1qLMsiAZo+RwGm7MhflFlKYDJFgGlhc2Qc5d?=
 =?us-ascii?Q?IH67gJ5kzrnGYeSvsed1UA6S2m5lKQLTcZSex3rl4esrt6Lh29DhnnSuQV2G?=
 =?us-ascii?Q?XmpCXnU1yBCQrMm0Ptecp89ZHRtpUXBu5yPSwBc02sEBNUy4tptwK3nVooN/?=
 =?us-ascii?Q?I/8VKvtLJriAfwT3NsojIf40lwKC4Je+S/hHufqP0miRATD52Nk7JunnC0O/?=
 =?us-ascii?Q?De2++ZKYDBaR8aYFuE+zIETi/yNCwJ0LszYoOhUVoGxCrjpnXZDzotQudbi5?=
 =?us-ascii?Q?CvBsVIOLdwnjaq+SECcvgG10nqC/B8JfZPsXu63sYcLhYtvm71/rRtHLfkKX?=
 =?us-ascii?Q?dIFYrYdGWevUeBuBccyM5Lk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EtnFKSGnSEgRmauQz0yBqfBkOrQRkMV2dAgdh+VB10VxQawZZkW3V05/i5VT?=
 =?us-ascii?Q?WGP0JTflzCwLECWKYQWcihxsQBSfNMtQnNYyX6W6rQ8RSrNyVKrwWiZ6NzAH?=
 =?us-ascii?Q?2XC0+o6UmMzcXIE+4+yebO4uPPhTbZMag9fqCQySkDyayBdqL49A2d6uRAja?=
 =?us-ascii?Q?G+pbNFOMn7OnYg3yZggVQnOnDykePGRhjXW5d6JNoYL4FhAydTbJE4D39TPY?=
 =?us-ascii?Q?dNJ0f0Fbhl3r0zdPksHO7hMQXxnIjH89GoLAVG7vqn7D+3yM8CGiOGwrouAt?=
 =?us-ascii?Q?jDtSHwrCjb7HZOkRxbKQ6zuJ/+REgT50BDgdX9woWybfZMsvc5bGjRa1999D?=
 =?us-ascii?Q?XjR1K4AxEWhW4Xt2Hsu+x8RjVKgp6nhseu4L3Dv+Lr2wnamuMFFVFBsK3138?=
 =?us-ascii?Q?+1wovcbFZ8ZdRErqO25bYvCGTTho4ipTwkKJx+78PiMe1RGXRCASza1bZROw?=
 =?us-ascii?Q?h2kVLDlM2cUHN4yQ/njbQX1N+tfaGBP1yfbfs80dbHJj9YGafBROXTay1DH0?=
 =?us-ascii?Q?hbeOYdx7xz3s1khdLQegmMrX39zE5VhZJuA9aWxsrcFl8+nCi9gqvOfYRJ4R?=
 =?us-ascii?Q?hAhSf/SUaug7d1Q+BhUBEo3ytJOc6oHDuCWcm/IsDBb5q4U7f0sXsBnjPJpf?=
 =?us-ascii?Q?HUde61sfvTe4FuMFsn6hjk9kjzRhCYj9TyyrwHuSH1LAUDHaHsT7bhvD5jF3?=
 =?us-ascii?Q?wzYQ5viRw5X/sDGuX3EqwlEN3Z6o+vJYvUN1+pdpQLmc5HOU2J0sKPYesFVn?=
 =?us-ascii?Q?ErpAoFSP6JP3a0s2tKSC0ll5dYpd829iO2le5Grc1ru2OQcQZInxJk7TvFFA?=
 =?us-ascii?Q?xV8yPZBEDJdWNpsNEKBVopsyeG+x3ECQmtTYEa8iqmhkgoFjhZl2qiJcq4Wm?=
 =?us-ascii?Q?EsV05z70N1e9ulKhKIxDJD795tafRVc0QiXoxtlp3Vuzp3yVI66Ph+m889n0?=
 =?us-ascii?Q?SzAEph4OEtuUOorl6CJ0CiysdgNmDvydnnr5cRcI7y4bH3bgK9va1lMnS/di?=
 =?us-ascii?Q?JFCsW2hiB3P/6KdvJBuRZrdQUsozQPhf1eHTZRIjaeoCCgmFcQwmlhXDw2A9?=
 =?us-ascii?Q?93CXO0NNWpy0FJdVbXwNrtXTAJtffpIBzkZ1cIHpkPq703JSmYIS2TaYrFgU?=
 =?us-ascii?Q?RvhkVtZjRUClMyLyL4UmbQ+rrKPFhuwa/+sltdCVkaYQrD5ToeUSCrRYs8ij?=
 =?us-ascii?Q?FcuSRrUhtEFH4EndYbpjsYgZaGiAkj0avv3fq5X0+nbx6PM1m1ObTnrEJdjy?=
 =?us-ascii?Q?4E+N3Ge4yWLZFm9QzJd8uBz/VH3m269aupXpvhPieAHdi5r5B/Yl4z4XOo6n?=
 =?us-ascii?Q?F14m1NUsJYv2y8YxGefvFQWShYZGgQC7c2TvOq7KElkPdNgSQQTVhFdZsP5x?=
 =?us-ascii?Q?7pe42E1+fJP+TpFTtj0RhFh3pGVBwLZor902q8PFZDipJKf2K91NNwQ9gOaM?=
 =?us-ascii?Q?aJojDlGxwLIuP3H31gouNc/N3wRTzOPc6QRA0QI7LjQOktzDFFYO4FUPmbCR?=
 =?us-ascii?Q?lFLaJwXXP09GRbrn1Z2EIiDA6BgkkCFM2Heoh2ZqW3brG/X0PDrHsRsnO9Ud?=
 =?us-ascii?Q?XGdvWar05KqrnJ544ALHh3xNGjzq7I3vfTGFNltTpDMzjKZghnJgNzZUloxR?=
 =?us-ascii?Q?830qJ0WhAUtRV9Xo8zvSrr3zy/mFZp5Ry2AMIDZ9d6MJsvlyfrYPdil2cG8c?=
 =?us-ascii?Q?T7/SwPbwU9DiT4UMywXHRU+x4TG7/1WgQt5x5kHhpJYW5S0b?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8bcef8-6966-4bc5-4df9-08de62b37b89
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 23:33:34.4126 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mSZfzl6ye7w7WwEjWelqfB4u6GPp8U/ern++rgyB1L4hEWdqwXoaiNmSKfgxACGiZ4iA7UnErTUbm1gzt5mhTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8988
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

Ping...

> -----Original Message-----
> From: Jesse.Zhang <Jesse.Zhang@amd.com>
> Sent: Wednesday, January 28, 2026 6:58 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH v4 6/6] drm/amdgpu: add MODIFY operation for compute queu=
es
>
> Implement the AMDGPU_USERQ_OP_MODIFY ioctl operation to enable runtime
> updates of compute queues.
>
> v2: move queue size validate to a separate patch
>     remove the check for AMDGPU_HW_IP_COMPUTE  (Alex)
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 61
> +++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  3
> ++
>  include/uapi/drm/amdgpu_drm.h             |  1 +
>  3 files changed, 65 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 256ceca6d429..3003aba22e1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -837,6 +837,7 @@ static int amdgpu_userq_input_args_validate(struct
> drm_device *dev,
>
>       switch (args->in.op) {
>       case AMDGPU_USERQ_OP_CREATE:
> +     case AMDGPU_USERQ_OP_MODIFY:
>               if (args->in.flags &
> ~(AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK |
>
> AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE))
>                       return -EINVAL;
> @@ -901,6 +902,60 @@ bool amdgpu_userq_enabled(struct drm_device *dev)
>       return false;
>  }
>
> +static int amdgpu_modify_queue(struct drm_file *filp, union
> +drm_amdgpu_userq *args) {
> +     struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> +     struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
> +     struct amdgpu_device *adev =3D uq_mgr->adev;
> +     struct amdgpu_usermode_queue *queue;
> +     const struct amdgpu_userq_funcs *userq_funcs;
> +     int r;
> +
> +     mutex_lock(&uq_mgr->userq_mutex);
> +     queue =3D amdgpu_userq_find(uq_mgr, args->in.queue_id);
> +     if (!queue) {
> +             drm_file_err(uq_mgr->file, "Queue %u not found\n", args-
> >in.queue_id);
> +             r =3D -EINVAL;
> +             goto unlock;
> +     }
> +
> +     userq_funcs =3D adev->userq_funcs[queue->queue_type];
> +
> +     /*
> +      * Unmap the queue if it's mapped or preempted to ensure a clean up=
date.
> +      * If the queue is already unmapped or hung, we skip this step.
> +      */
> +     if (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED ||
> +         queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED) {
> +             r =3D amdgpu_userq_unmap_helper(queue);
> +             if (r) {
> +                     drm_file_err(uq_mgr->file, "Failed to unmap queue %=
llu\n",
> +                                     queue->doorbell_index);
> +                     goto unlock;
> +             }
> +     }
> +
> +     r =3D userq_funcs->mqd_update(queue, &args->in);
> +     if (r)
> +             goto unlock;
> +     /*
> +      * If the queue is considered active (has valid size, address, and
> percentage),
> +      * we attempt to map it. This effectively starts the queue or resta=
rts it
> +      * if it was previously running.
> +      */
> +     if (AMDGPU_USERQ_IS_ACTIVE(queue)) {
> +             r =3D amdgpu_userq_map_helper(queue);
> +             if (r)
> +                     drm_file_err(uq_mgr->file, "Failed to remap queue %=
llu after
> update\n",
> +                             queue->doorbell_index);
> +     }
> +
> +unlock:
> +     mutex_unlock(&uq_mgr->userq_mutex);
> +
> +     return r;
> +}
> +
>  int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>                      struct drm_file *filp)
>  {
> @@ -920,6 +975,12 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void
> *data,
>                       drm_file_err(filp, "Failed to create usermode queue=
\n");
>               break;
>
> +
> +     case AMDGPU_USERQ_OP_MODIFY:
> +             r =3D amdgpu_modify_queue(filp, args);
> +             if (r)
> +                     drm_file_err(filp, "Failed to modify usermode queue=
\n");
> +             break;
>       case AMDGPU_USERQ_OP_FREE:
>               r =3D amdgpu_userq_destroy(filp, args->in.queue_id);
>               if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 833468b58603..7cd1ea94e368 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -31,6 +31,9 @@
>  #define to_ev_fence(f) container_of(f, struct amdgpu_eviction_fence, bas=
e)
> #define uq_mgr_to_fpriv(u) container_of(u, struct amdgpu_fpriv, userq_mgr=
)
> #define work_to_uq_mgr(w, name) container_of(w, struct amdgpu_userq_mgr,
> name)
> +#define AMDGPU_USERQ_IS_ACTIVE(q) ((q)->userq_prop->queue_size > 0 &&
> \
> +                           (q)->userq_prop->hqd_base_gpu_addr !=3D 0 && =
 \
> +                           (q)->userq_prop->queue_percentage > 0)
>
>  enum amdgpu_userq_state {
>       AMDGPU_USERQ_STATE_UNMAPPED =3D 0,
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h index
> c52949ea8c1e..aa9b31578c6b 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -330,6 +330,7 @@ union drm_amdgpu_ctx {
>  /* user queue IOCTL operations */
>  #define AMDGPU_USERQ_OP_CREATE       1
>  #define AMDGPU_USERQ_OP_FREE 2
> +#define AMDGPU_USERQ_OP_MODIFY 3
>
>  /* queue priority levels */
>  /* low < normal low < normal high < high */
> --
> 2.49.0

