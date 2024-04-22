Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E26C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 18:56:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB956112CF5;
	Mon, 22 Apr 2024 18:56:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zeJbhSeU";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A64FE112CF5
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 18:56:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIaceqKD24Yt5w54cP0FCbfTqIy1sCGNnyaBPRaEXsN0VQDDeDqXctqFk1bBbHhkMo6gaI7Q3wAhkERysnLEfx9WL2eCpGn7OIcGv+V9kakP4T/fHAj3ZAX5qidoH+e8XBKoO704CjKvWwQ1IocGR0EzY+Fv47RshkYQsImGcLAs7USHg7BSuDDdRnqTyTshF0MGwchaArt50x2iQGK89QWNhqZO6EMKNppELVB8GZCS5zOXvF7fgVbJKWALag5cY/puOyOYKEmBuCZMbaCXYUD0Br33zIoreLDh9HKvd+c4QMhkLqc2OzqdAAgDsKxzpnpszJitqWskHsMNoysvhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3YrK6ZUC/6DSCxQThGgf6hs7uRwavEG4rvOPjxBrvU=;
 b=bHFD/tiHCED/oi1haKzyBvn1Zbh967fYs5C2LpVeKGDTyNlBBHcqrVCaEPIiMevlVJPfQOqaUWiXdLAgCe4UWIDD+W5yQ8PA9VuO8lthnDomvQp+d0riLfl0Lu5b4Jzv4rv1M1oWQRs1q0l4IKnjSz4gzSayiCu2JphP9kD6VhaYzWplujwIS8ppQ1EQ7CU+06gF55n+mWrXgmrQmq+dlnVksuBvCbVKtCatWEAUt3nuY+Za+WhB/Qg0DDdGGbi1VsQPuK+QzOqBdR0Lto5wyzXx1uCm0Xyto3sK5lwEh9xpL+hJ3QbdyDmoNAbO0DOR/EBWrZN/09iXsw/Sd74Dfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3YrK6ZUC/6DSCxQThGgf6hs7uRwavEG4rvOPjxBrvU=;
 b=zeJbhSeUNViZbXRGT+ZP58EGib7C1YeQdtUmVHrnTzP+xmFUSjF/IXtiquqxDaCeLDrWN8prubIcWmgm/ZdSXUtWpsSkxOjh8sy+d4vmf+Tus5wxEgHEV3PYKYyVunCUdMRtDKIxsdD9LvR7BH23O90WjotTyXr+H0oPmDrsEx4=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by BY5PR12MB4099.namprd12.prod.outlook.com (2603:10b6:a03:20f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 18:56:20 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::832a:d65b:6251:4d6e]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::832a:d65b:6251:4d6e%3]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 18:56:19 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: add a spinlock to wb allocation
Thread-Topic: [PATCH 1/2] drm/amdgpu: add a spinlock to wb allocation
Thread-Index: AQHalMKyF+A87znOXkOsCas1/R10KrF0o7Yw
Date: Mon, 22 Apr 2024 18:56:19 +0000
Message-ID: <CH0PR12MB5372BAFCBBB5EB7DA0B28E6EF4122@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20240422143738.322710-1-alexander.deucher@amd.com>
In-Reply-To: <20240422143738.322710-1-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=42e4a0d8-3f6c-497a-8cb5-6d60256e0d7f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-22T18:55:17Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|BY5PR12MB4099:EE_
x-ms-office365-filtering-correlation-id: 87ed4aed-b6bf-409d-76cf-08dc62fde59f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?buYPSuvvkCk8AD0pDg6kqifEawMaViR28Y2rzhf4N6WR7WbTZwnSH0MHwjuD?=
 =?us-ascii?Q?lkmq3PLGR01UmcpSqbdRSvOptYsFNsxEJDXZUC+ANKov0Ffw77TU59Q806H5?=
 =?us-ascii?Q?SXNUrROK3Btd+YQBTtuQBAXTEa7GVjVuo5wY2djuJMgyYYnQ00HGYQe+h8Xa?=
 =?us-ascii?Q?cr5/UUNxnN40rhVB50ZMnxHWlZMLlMHn1zpTm8bEKSRZqa/3rt04iSjdRfNo?=
 =?us-ascii?Q?8O7JxoUfnMzql7kBhJJyoa4LPHD0h5WPGgHWWQbAyaCd8ZyHrSU1ar9NwxED?=
 =?us-ascii?Q?MowqpzZjYFl8h+buT6TRIx5QeKyQ6qiITxqpqMPK5ZWSzq6xV6GBSC2op6DL?=
 =?us-ascii?Q?XlmeRazUmnCbUww4AqF03Dog6Acqh2PoQyKs7rhTVJOUtHawTjKp0aCroJZa?=
 =?us-ascii?Q?X4FfJZBplz1rAwhwdn5GiDkGFE1dN/Y3CQIC1c9aQaxlLKsRkC4EHhmikPT/?=
 =?us-ascii?Q?9f/ywgpf37FVoapilf08NmR3FqxUOoYes5LDYGiNPATnTtqUWwYsoTUtggtx?=
 =?us-ascii?Q?h6f3dpl4GapJpA8ponYjSrhb6HvxDGG3Yz/oGt6P7v7JctdfFAVthAHEqqyu?=
 =?us-ascii?Q?cEEYIPT2BjWXTe0pjBHUchWewJRj85e81qVOAMSyrN3xv5yo/hLfK15M63xn?=
 =?us-ascii?Q?JVD4VIK/FI5pBxUKcjoNmd3Rbkr72hSVj3foK6YovftVJHfiP2/vFuoIjcr9?=
 =?us-ascii?Q?yuprBUvwOHf3BSW+tUr4aQt5M4Ue4wJXNbPYCo7dJJJ09CRA3xl76YwQA0T9?=
 =?us-ascii?Q?APl9k2A+5RYws4snvPBDmJqv3+Gw0vspjUMlPoAQYfG6Rln35KsQBB7D83lF?=
 =?us-ascii?Q?s/tRsnSN5KIRR/fhGQiuqy8iWlUnH53D+zRPCI1Qt+10AbZdrcy9YAQLcGZn?=
 =?us-ascii?Q?ETpJckcywvYlZxqLRo2B++K9j62yE7rllCyqmuX2LfWy+9EVKrdVku13cTdd?=
 =?us-ascii?Q?QVNzDGOf1pKtpJZLnL+E+tuC77tyhTDn2mTHdQs55PdPsKNnm55p7WRG8YQ6?=
 =?us-ascii?Q?b5LQLfQy0JPG/+hLItDTUqoTJkK1jr72ZMiD1NukN12l5dFv8iteFI/N8/6A?=
 =?us-ascii?Q?qEQv9CCInB1jwc/nsIbdQMk+Vc1AcChKuV6lU9+TXKl8U995Ysg67BU140W5?=
 =?us-ascii?Q?8P2iee78CcFSIKLcBKtqaXZb8PCPB/A2s0wwXgCQR8SWDBNJuE/g5LSA7hQH?=
 =?us-ascii?Q?RPwJc72Dx0VzpsUfJvzHEhRopHwjD9HEqslfFbW7w5IO471QBK4XM/1GqsF1?=
 =?us-ascii?Q?tXyT+wmeJryTWMTcIoBPgN0ipeWZYvmocLOpeBm9+mUgXeCKFp52PPfWx451?=
 =?us-ascii?Q?AKrjVePdLNRHgKH2/DQnVVL91rlv+dqRm1jHnjNJuGoFIw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/yfBk/j22JULQAomuUSda17ANXFJpMfFRaUGeaApGkvocUwcL7l6eIE0EEJQ?=
 =?us-ascii?Q?Eq8x6txRHKA9q5bMfTK7R3lblCxBTZSs9cBavCU4t/hyaUtymRpFuFXA/Gtp?=
 =?us-ascii?Q?yKXHI8wddm9DDe2Amk6tjJ4egquI+EIwbkwW/neDbwZPl0YNn2SOrhtFD9XZ?=
 =?us-ascii?Q?6Db5NWc5Jci39RSXyG8bfUe5k34WeCVa6WuYEMsSEKSIQeSETKvXSn8IA9UI?=
 =?us-ascii?Q?frGu2ae0q7c77LYMh/ptBJbCiRP+2F3buUMDZfb2hMJIy0V0QNQnWFqueegG?=
 =?us-ascii?Q?7UXAJO6TbXFEmqCsluQsv9dSIu2BsRhLET/zcbtkx68cxOdIDDZgk0Enhk9a?=
 =?us-ascii?Q?Z217GDhAkbS7OYtv2jo3xEaekyUEsw3Jpvtl6aGCIwFwo3UjRQ0c8hBflRUY?=
 =?us-ascii?Q?Q3hNy6aD8VbZxeWNrWqmouD+Eq1cIRxuswKI6tuO5rEaADMqwQitHxj1REfN?=
 =?us-ascii?Q?5SjR1K7i95xQ/qZ8rrPix2LsJpvDRpqRhrc0Sm57n9cSOuHwhVdMvqqhBnNk?=
 =?us-ascii?Q?XFKLYp6gpoX1QRLHk+HmNeDpKraQ223ouEVABrIBZH66Lj9VqSkmu2/1p3Vm?=
 =?us-ascii?Q?A+tjkMAj8W39LVinhw1Uu4rKKkf9vgEPRH9Jby/zw2YDhzsguU/5c5csJ3pg?=
 =?us-ascii?Q?BdQeT/1ZWuwmeIRuXk8zeLiMz9xQARkNHW1JC9ubePRWX1W/nDhrBqmn1Nod?=
 =?us-ascii?Q?itdO9YA9FMSBFfJ54dyagn1QbTOhpVH+Q41/ci/GbbbM0krkok2O2Rr7fzww?=
 =?us-ascii?Q?9PQYtG8yrgxCE7AWRHUwRMeWWkmwTLeduAu7DNbQ6AUTRJtm7GF98qPyz7/T?=
 =?us-ascii?Q?wjCwXEXPBpDTf72o2rWVj3pje+tB6pTlVfcAZHv6yKiuMbjnCeI+cNv5j922?=
 =?us-ascii?Q?p1XYHE/NFx3kesvFIqwwxilQyO54ZtTY6+1YPInVQ+bN/eJqiXSPjNQcxhd6?=
 =?us-ascii?Q?vZaz/SmFAOaDJSrw8cAdu4Tmp08wlDh+gZVWGgsknohAv1g7qyWbpSbWbp9X?=
 =?us-ascii?Q?d0FL5Sbo19MZjNBHztnaazE1ItLPgccU0q7ioO4/46tOXGJc/qGYCpTGjKxi?=
 =?us-ascii?Q?NSm0dXhfmNkGU0XP3MaTqFQb0nEtb89SP5FfgaSXO0as8l/vurgOpBTUUTxK?=
 =?us-ascii?Q?qR9jrsksGaRQDCw3MLMHCGqrwi2m057pmF8K/SIVac4hUtw2nr+YxbAfVCUe?=
 =?us-ascii?Q?5tnvsmIIY41sQXr3znzTezmbf8UXyds2U3D5sufqOyWCLzlwLx4LLmf/aWrz?=
 =?us-ascii?Q?RpiTAx6aN8gFS++UdToVmxQNmjqs47FMSIApExti0V1FxV12+mhCVWihgf8W?=
 =?us-ascii?Q?koj74OqgSwFRG/VOx+jsq8LWMHL27PrEc/7/5N8NtNBvID7YjjS6lqThqoNC?=
 =?us-ascii?Q?0P+IZj3tUfVTmwRVxfHORTWPHuY+hUQCaPeOEGQyKFS9lfW/LKNZjRciXhWL?=
 =?us-ascii?Q?uZlEkuoQQiyCnvZOrEmqsP3gb3tRfpZw3fCHgjxRlpvRLpC3Nizs7cie3FTM?=
 =?us-ascii?Q?OCWkMSUI1ao1K5JbhKSgd9XdgR+5tIzSV4wMOxG2vlYUXUgufGB4uiv+EAOg?=
 =?us-ascii?Q?RUZNPnQ69bIUjWWYMeo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ed4aed-b6bf-409d-76cf-08dc62fde59f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 18:56:19.7873 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FNxJIML2s6w7ILhSB6Viwb7WLTr5PMwEoTY9DGQzz0Xgq2FxNdGoWl42Fman9ScVCPx7y4FI3GpHDLd+N7zsxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4099
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

[AMD Official Use Only - General]

These two patches Looks good to me .

Reviewed by Shaoyun.liu <shaoyunl@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Monday, April 22, 2024 10:38 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add a spinlock to wb allocation

As we use wb slots more dynamically, we need to lock access to avoid racing=
 on allocation or free.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index cac0ca64367b..f87d53e183c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -502,6 +502,7 @@ struct amdgpu_wb {
        uint64_t                gpu_addr;
        u32                     num_wb; /* Number of wb slots actually rese=
rved for amdgpu. */
        unsigned long           used[DIV_ROUND_UP(AMDGPU_MAX_WB, BITS_PER_L=
ONG)];
+       spinlock_t              lock;
 };

 int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb); diff --git =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/a=
mdgpu_device.c
index f8a34db5d9e3..869256394136 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1482,13 +1482,17 @@ static int amdgpu_device_wb_init(struct amdgpu_devi=
ce *adev)
  */
 int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb)  {
-       unsigned long offset =3D find_first_zero_bit(adev->wb.used, adev->w=
b.num_wb);
+       unsigned long flags, offset;

+       spin_lock_irqsave(&adev->wb.lock, flags);
+       offset =3D find_first_zero_bit(adev->wb.used, adev->wb.num_wb);
        if (offset < adev->wb.num_wb) {
                __set_bit(offset, adev->wb.used);
+               spin_unlock_irqrestore(&adev->wb.lock, flags);
                *wb =3D offset << 3; /* convert to dw offset */
                return 0;
        } else {
+               spin_unlock_irqrestore(&adev->wb.lock, flags);
                return -EINVAL;
        }
 }
@@ -1503,9 +1507,13 @@ int amdgpu_device_wb_get(struct amdgpu_device *adev,=
 u32 *wb)
  */
 void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)  {
+       unsigned long flags;
+
        wb >>=3D 3;
+       spin_lock_irqsave(&adev->wb.lock, flags);
        if (wb < adev->wb.num_wb)
                __clear_bit(wb, adev->wb.used);
+       spin_unlock_irqrestore(&adev->wb.lock, flags);
 }

 /**
@@ -4061,6 +4069,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        spin_lock_init(&adev->se_cac_idx_lock);
        spin_lock_init(&adev->audio_endpt_idx_lock);
        spin_lock_init(&adev->mm_stats.lock);
+       spin_lock_init(&adev->wb.lock);

        INIT_LIST_HEAD(&adev->shadow_list);
        mutex_init(&adev->shadow_list_lock);
--
2.44.0

