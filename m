Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5CDD3B7F6
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 21:12:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6BBA10E20F;
	Tue,  9 Dec 2025 21:12:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u9IUVZJN";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5A3810E20F
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 21:12:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYPdS3QN7oqjkxRlXUlg0ufLSNe03TpjI0erhPPlzHcWlewIUJxML8g+XSNZv3o+wes6xaLhFu/dUOKFG36Iyv3YO8CCJrSYKSLstR+adTdQnG877iFtrPEj4YT2xrcPBvaMXqGqY0Jr4u6khhRJFRjoMa6lBWts1Widyjy0qR/nCQajE0app8EVqqiqkusksr3YrRE/vU+A41w16ZprbOSznIQEVxiXrOFCsbta/cyqJJmoq3o7HIN1YrHgAdv/mR2sEXzdKPYGo0jYIsUHtPJO5MY9WIaol2/siSDrpBy8bLRoQf5Eci4d8C149EUu1ibrjv417OwokOn3M15PCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByzWKzkbn6024SKcf2Hyf8qKcvCrGMz/elyHnJsvKtA=;
 b=B2/pIAM3l5XebD83/iYWTkdRzxBqXSv7+Xd/R4RRobxoYBHoBnZuFOKe8iTaC2EvStZeu+F8BVPbSSgpYPLWMiUZ02Flp7KTRJCg1DKnsIxlvXJg1KPgNMZw3BSKABv5x2tlztUCKGzBhDBUQsPbvznWJIxfuYt5Wuncr1UKx5o8CVdnI1hHeHJSzW9m6s6EAZ3xBizPa3qjKGHf08ulaH7rOcYXJ5jXbu0qcVtelPix8L3DuxRDSnNEf7lxuxd+kIYAwGax2DOyxWgyF/8DM8//MBSp+IXutcQEEBLN+uazwb6lFcy36AmQsO+O4G55OYYuXnGdXOn/D+NoUWMr1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByzWKzkbn6024SKcf2Hyf8qKcvCrGMz/elyHnJsvKtA=;
 b=u9IUVZJNdIpaM+WkkEnoSLSkjDiC8IDJIeX2vIx8+BPiysO/VtFjNvULbtx1MiTlu3fK/GB4NDEFIkgnt0y1Cg/uKIaTxW9nGeXt94darrCAcB0ggvEFFJTBu1qhETpbi3rcSdA6ljeHrgkpI3qST6FwMMZkwfsBWtBx+KtFyhI=
Received: from PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7)
 by DS0PR12MB7852.namprd12.prod.outlook.com (2603:10b6:8:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Tue, 9 Dec
 2025 21:12:27 +0000
Received: from PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a]) by PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a%4]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 21:12:27 +0000
From: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Unreserve bo if queue update failed
Thread-Topic: [PATCH] drm/amdkfd: Unreserve bo if queue update failed
Thread-Index: AQHcaUudtMHwsAsClE2PRfH1A5B9t7UZy78g
Date: Tue, 9 Dec 2025 21:12:27 +0000
Message-ID: <PH7PR12MB6657801478598B60D469B4A6FDA3A@PH7PR12MB6657.namprd12.prod.outlook.com>
References: <20251209203657.440714-1-Philip.Yang@amd.com>
In-Reply-To: <20251209203657.440714-1-Philip.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-09T21:02:46.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6657:EE_|DS0PR12MB7852:EE_
x-ms-office365-filtering-correlation-id: f9564c04-92ff-446e-6fa1-08de3767a7ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?UNnhQZknaeKaYHWFXlgwPZU6iTgtDdsvQ10jNjtkgxT8IKmFmk/iZWvY+Sp7?=
 =?us-ascii?Q?86dS8M9H0qHEQ7uVqTW6bCwcONAre1FZvf6hZ0r4uYz8lbK87f3tQJ2wNPC4?=
 =?us-ascii?Q?0A2GA0DtoZl3qGLnFnVFLeQALOg32E+G/QtLWzVB14viaHyxZVaYUESxkrJv?=
 =?us-ascii?Q?BqVHG4BvMQ6ku83cllTV3VGJXnJlhyaHJVIzx1B4Ap2QD5veF8H5u5BZqO8V?=
 =?us-ascii?Q?FG82ZcNxAuMID2fWLz5qGJODLIbdebxPq2cEQcft0/jODcnaISawu1fCsgOE?=
 =?us-ascii?Q?0Z3Ft3wdFen+/xlvFigPNkaHeInoYNjoAA9CdG34APTW1nSgOKVBtjRXu3rl?=
 =?us-ascii?Q?Tmthaaf/txtX0DwrIdUGZb9/ZYNmzjl1YUD2Kw4v0fHdulk6MFzzegLDzlTG?=
 =?us-ascii?Q?YEHG2StCGmAmYgrS7H59GoCaWM1YXI02Ms0r8Hukl+oSV8zRFFMZ4JGHkqTq?=
 =?us-ascii?Q?TV9I1DXteFYcgo5N8HNrIGl66ejumX4FtaxTtyE5B9SEpB7XJFdKnhKoVAw5?=
 =?us-ascii?Q?gEoCXfbpmDCI/0/bD9u3xvXV1gTKNlQzmRTLhGc1348NrthRqBbQgcg4uAiy?=
 =?us-ascii?Q?JGeZaxOohZk0LRBaOOlCK0v3jJPQCoUnYUQNQx+WFmtku3c7qZlsJulxtgnf?=
 =?us-ascii?Q?20ZaNbqTWeC/sZCKFzGp7rBSC+arD/zg2m7HlveNWJ0cdfSqs9OtNzxwZxeB?=
 =?us-ascii?Q?Y+2ZAm7AO9q9JP13344Jlxqf55LAqW2bSVgeFY2sMkutSKvtuhXAGXNrQ/I8?=
 =?us-ascii?Q?dnTgqdoYOfAMqxc3ukaFQgQ3A0ioOeQZiceqTxywblSDHhS+e8atN3GIO4w1?=
 =?us-ascii?Q?sHa5KiT+xN7MCGSMNa1ZoYK+4fkVx6lGxRteb2AC47ieqvEMzArmL6R+XtVG?=
 =?us-ascii?Q?BILhMnBAH4+2zJYV6g3pbCbPz1FKLWGBe0j+EFsKn9+gw9ivaPHSbHJojrxv?=
 =?us-ascii?Q?AD4MtlxNrUpZUNxWeUnI2uG7rD467OaaUmRocxXIkOSlbCmwpsVgEXK0JYWZ?=
 =?us-ascii?Q?oJIm0RdMTS3gNlG4D79P4hDHbtITsgPz/6E+PxQa56spKVdiWsqf/Fn+38pO?=
 =?us-ascii?Q?tIFF67X+I4+VYykw35xxad8z+0FIzf4jg/aZMPlfcAw95voZ2JNSvoU5u4zg?=
 =?us-ascii?Q?Hh03FcdnvQ84pvNFpMCQI/JTDk3HTxVOdipuKjXqnbgk1nlOszCXPkHpAVnU?=
 =?us-ascii?Q?cMJh1/BAF+ytsnd2FNsEJIFj5bVIMlqap5mbrMz4eZ3K5NMX+1ApfAmDAxuh?=
 =?us-ascii?Q?PpQqIn1MKfAoxwFDWAAziMV/e5ZbvfMojjEoVCAerCr8tcr7F7itZCv9PPQ3?=
 =?us-ascii?Q?yKuVaojufBgSNdHXsrZ9I7qi/PnPpu5/Q2zdyZW2OsulVaDUec6H/x/4TgVt?=
 =?us-ascii?Q?Ky3kGyGtfwIjKJn/xhSjFcLECpUqPPOCUMPBH0hMisku9sXpQcDHJixEiH+B?=
 =?us-ascii?Q?6HMbgvsbvRC/z1XxmgwIzdjCMcMwdjQ4TCHTGwnsLWIFzQ9vFVy7KlOedMT+?=
 =?us-ascii?Q?xLTQvo0bFSf7198bqYwylhAvC/qpWRDyOY7z?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6657.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bc43ZwPWgOiUek9e/L7EKAo0BihXwl+bAKD7LscywVlMVPofY8AbAK2aVpHX?=
 =?us-ascii?Q?AojLJvL8nQEXY3buD5GyxqHa/i8xWK89qCuLCNFJRfmxWzJs3dsF/NaEjpS/?=
 =?us-ascii?Q?auIvl1g99ln1mAFxyax676MTzX8hN9octz37OGm14KyC8pDJMJQ5hgcmQSMh?=
 =?us-ascii?Q?uzLdoVqIO87szn+1rNtYPKGDKYCmqruhbOHCVKnc56VukyVib+pBYyw4LzkI?=
 =?us-ascii?Q?tC1qTlouZsvOOFfx7gm2Xcb2Z4t5T5/uJgw5rw7g87+GkJBvxr9Ed78SiSqs?=
 =?us-ascii?Q?jmDy6O3YGHF3qV0h0kIptLje7bMq2jAP7lbKb7S9zKnK96WBU5ZZZTj8Y3Pk?=
 =?us-ascii?Q?uR+kwHZMENKprU8xHMVH03wfoK1FXv9RNwxRSr/YV83TPMVxGUa5TeSP523N?=
 =?us-ascii?Q?sOIJoDha71bIW9MHAdx5PI1FOjTcxkHsw5vELUe+9ZAH34Q2T056/pHOK4DQ?=
 =?us-ascii?Q?5cHmqFgruXpqZzznYZSS4P0ScsVailiAq/9CQc/xMgDo/VJU1+dU0KSFbePU?=
 =?us-ascii?Q?19JPNIi/Dt99/p7Mz6+dmDi7+08ZanCFhpvev1MsUDtmyrv26y77JI9bzr6j?=
 =?us-ascii?Q?3ATbm2WuGpA14WQeadxl+mOazOzSUbyGYWFJoWfMcP4DnJ2GBMe68A/my5qR?=
 =?us-ascii?Q?YROn7TJHYP84oA5ga3pRJtjkSp2mDXBMmhOoOieAiAPY+4xvWgjc3S0mLB3u?=
 =?us-ascii?Q?wpGvYhfjgjQRoAUbn2FfTHxCbpU06ZapW6QaUVhiiVsNh1VUFgNmm0Y5Hcqy?=
 =?us-ascii?Q?XUrLowgIkKeRDrCNdRd5S/V/sUdwIGtGo6EMAz0gjtZZeWmxLf2Qum4b+gYH?=
 =?us-ascii?Q?rK/dN4Uglj+2O7QdtFrYOhiP53oPufm32oqoNOqdGQN/4Ng/sDdN+myx21o6?=
 =?us-ascii?Q?5xuh7Nn4vGPiFAVNL5a8/mgdb4BmRzSSgdTBJBTKZ0hakMxKnXLjJxW2hcBn?=
 =?us-ascii?Q?VEZTX5mfxazJbArqerJOSCG6L1ouhgJqRhWBxpUhkGgFxKM759Tdh5xjFHhP?=
 =?us-ascii?Q?rIcDrHp2dHbUOfuWVMorGCcL1EE5OZhrHyaZ0F9gmC+041efXa15jw67TW7t?=
 =?us-ascii?Q?fNeVLUnBTO3Mk5cUMb47O1vVawypqzPj1FACGfMopTJ/7U/bnUIpb6XtmMa4?=
 =?us-ascii?Q?JHTok9hbAT2Zm1qeEKHzxJA8/8xs8MMON+0aY+K+smzKptgCwFY88RNJtH47?=
 =?us-ascii?Q?3UiFzyRrs/4Gxk75xynQ/vqhMptRrW2Qq2PwqggoqFa51bjBKaQ3HsIrGaEu?=
 =?us-ascii?Q?TyWYZR3qkW9rKLhEBD0G9CPpTJ62hkehZRqHyEaNukHJCPofRjlRY0G3v+zC?=
 =?us-ascii?Q?51xPenb2NFpIb0LmTzeSbtlN/v2uvt7TRmCn8hxFxGoLwb1dVyRPcKNNWrsl?=
 =?us-ascii?Q?1hAta4yI5MRRFzuaZV3f0deCXZRvT+DzGAm8FU/pbhCpKHzUT1ybB+v/myNl?=
 =?us-ascii?Q?XwSVkKbytI8zjrx1aizi91t2FVIP7CpLfE7PoVsp+cWQR3aArj1u5/UlyFL7?=
 =?us-ascii?Q?v/+YQH/dRerrgefEpw7zAIFYLZf7d5d2E7P+44+GITSNsYzwY5c0MNDYuslj?=
 =?us-ascii?Q?/r1oDysJNFtz2Ax3xxA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9564c04-92ff-446e-6fa1-08de3767a7ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2025 21:12:27.1448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RwHs9koeSkuXWWsMbQlcVEgRSLC7smThi53IlGsAb+woh1RNhwXSO5VpRx6gQv1e5X3Q5ZID8ZRJAxarGBk9Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7852
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

Reviewed-by: Alex Sierra <alex.sierra@amd.com>

> -----Original Message-----
> From: Yang, Philip <Philip.Yang@amd.com>
> Sent: Tuesday, December 9, 2025 2:37 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Sierra Guiza, Alejandro (Alex) <Alex.Sierra@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Yang, Philip <Philip.Yang@amd.com>
> Subject: [PATCH] drm/amdkfd: Unreserve bo if queue update failed
>
> Error handling path should unreserve bo then return failed.
>
> Fixes: 305cd109b761 ("drm/amdkfd: Validate user queue update")
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 232103742712..6babdf025359 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -592,6 +592,7 @@ int pqm_update_queue_properties(struct
> process_queue_manager *pqm,
>                                        p->queue_size)) {
>                       pr_debug("ring buf 0x%llx size 0x%llx not mapped on
> GPU\n",
>                                p->queue_address, p->queue_size);
> +                     amdgpu_bo_unreserve(vm->root.bo);
>                       return -EFAULT;
>               }
>
> --
> 2.50.1

