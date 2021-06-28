Return-Path: <SRS0=DKNW=LW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF48AC2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 14:43:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A572261D7D
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 14:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A572261D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E7DC89BD2;
	Mon, 28 Jun 2021 14:43:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF7DE89BD2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 14:43:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGbop6erKZJMTTL9iW++NzdQkzOzWpUfdkq5n+MSD+9CGfZr21Mvh9OGIMtRiCTBoPIviheOiE48EYdredzg7iYAJrtSqOQqipM2qqbUbwBHXbc+L6NCKmbxdiDaxU5ItboIXn+1hCjCg2yPlnf/w9ovDnzx57uP3KFTj0jQQlnY0xt1r/l80IAMt7BcoBuoP5Ygt/cdtDf2LTbYFdNMPWgpPZ0tMOukCvpscYPLsspdy7FtDLTa1yGMvuAAQ/01nmWT3wXWU35UfbRto/UN6XmzBUKmlO54GccjycrdKAdsAXi2B4UmxXauY6OCV87SecjVUJzIthL2DJGVmKWBbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TamdNKToy+F0noz6B+ga/J70xaqBTk+OWlxrUSiJoU=;
 b=QBJApg+5pr4mnmlDrPpxYu9PRTK86l+whDEfRyiEr3a7O3L/K71sAf9YSwXc1uEXKrQlQ5NB+aFrfNCMSfkadLFYkxD3YEOfDz4nDV6lGlZ1PPNohMbbuvRX/eL7S5+Wmdn1L7o9mjIBQT+XC5c8kSDoJDH1KT6VBzWvAB6Btz1j+hGpTSciqRfD3+6Ekt974XhzxNMAIUystEjLd4DZZExEOyMAXVX0JJM64Zjr3QclZyzZwl2PlOy8fzhdD1jSlTjlvSOqbLGOhns6e2ikHdIsqzjf/hdO7/++HU5S59iwRzhrVfuh8LlR7UlJcJdo2WmmAjhG0k8XaKERM/t28w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TamdNKToy+F0noz6B+ga/J70xaqBTk+OWlxrUSiJoU=;
 b=CxtRA/qtWEKPg4RL1Uk9to7Lo0GZ4/kQc5efrGNTC1wQTTWZMzYe6iSFZg0tvJdd7Ck71b8CJ2+5VAtFcTAaXvq3DEQu3gDU3mhjATJl18ejcvyL5KjjgHvlmA/AY3FD/LuErfur4GEH0SpKuXIn0Ma7H+d7zVKwcarZrFtBOes=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5460.namprd12.prod.outlook.com (2603:10b6:5:357::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Mon, 28 Jun
 2021 14:43:32 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::c8f7:5e9d:ca99:1dbb]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::c8f7:5e9d:ca99:1dbb%7]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 14:43:32 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: add non-aligned address supported in
 amdgpu_device_vram_access()
Thread-Topic: [PATCH] drm/amdgpu: add non-aligned address supported in
 amdgpu_device_vram_access()
Thread-Index: AQHXaXGaEI5Aoz2VL0q/jnCOT5QlsKspe7KAgAAE91I=
Date: Mon, 28 Jun 2021 14:43:32 +0000
Message-ID: <CO6PR12MB54736D0FD916C1F0C3F0C42FA2039@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20210625032409.15715-1-kevin1.wang@amd.com>,
 <878b44fb-a768-6bc2-2873-b7a75fc5ee1e@gmail.com>
In-Reply-To: <878b44fb-a768-6bc2-2873-b7a75fc5ee1e@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-28T14:43:32.091Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD-Official
 Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [112.65.12.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28b478a7-f747-4469-f19c-08d93a431a52
x-ms-traffictypediagnostic: CO6PR12MB5460:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB5460A453DBBF19BB86CEABCAA2039@CO6PR12MB5460.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FSUPGRcQ+NK+TXQsiVLwKhPkJE0/LXITN8I79PzNhkaz9Qp9Ta4/EYh1g612m5mobgPtUnXTHF4qVvFKukYKccol/GmtinA32vRESp0TOAbYcWxKMY3OElpw2I8DZeNfDjTTPzqlSunKqsI+F3yl4DXw2fcdF7QjqJ8lGZmytIMplf4RQZhBx6PcKUF8qap3JEaW8YaTuDgMt63YufAUuK+VHjaZT4Q10ugRA2GJjNFnLlyH4W5p3CLjoTtQNSQwIWEz3uAZyWVRkCVMB3OdH7HjZBNaWYQVfVNzkiR7K8XT6X2DzEx4gzQ/mtth7mL5oNkMoignA5RNMvt05dCv5g2pGCSYIydGOs+qHfZiK3bRZX3TrTlKKAe+aDid/Le22nPJncx+5Uqu0scGlZpgAblrX5rL4OQ0qUaI4vR3LnC2K8F//sriu4jVHC8t7+TfAwMSdA3bHoy/SGL9br6ZtbE/ivdHBs3S3YmBRwEWsRPnAZ2HQydR+9/+sujlrjvROEGIlaGxms9jN3d9kz9eXnItxv2Rxa5rR2p50M/O+9OCRK1DbpFY0B2g0VEGitingJSO+r/jdqHaljZlJdG0MR9rhG4j30knAITTroCk6JepXl8vcTXk17PDn17uMjr9YVBwVsS6HlxmWUHqBnCd1w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(52536014)(66446008)(64756008)(66556008)(66946007)(2906002)(66476007)(4326008)(33656002)(110136005)(6506007)(91956017)(26005)(122000001)(5660300002)(186003)(8676002)(498600001)(71200400001)(54906003)(53546011)(19627405001)(76116006)(83380400001)(66574015)(55016002)(9686003)(86362001)(7696005)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?L74bkf30JxCIrP0CYiVOiU3SloLEKUREtgoaFURr1K2cUjPyW2D0lxveO2?=
 =?iso-8859-1?Q?w5Y7gpulOcm6A1XLNHTqjz7Dqvws3Y2GHctsXoeo2NXX9CpXoSq5GTBklG?=
 =?iso-8859-1?Q?Hnx1JU63hMqwrq8l6PixVzVffRlZpcmE1TXWk2Mzl39xFqzrh3SL0M6+Hk?=
 =?iso-8859-1?Q?ym2vc3Ibw7GdWSN5TlI3V1Dg6A4nwT4EygFolRyeAfRbBrk5UKKZHY+OHo?=
 =?iso-8859-1?Q?Czzl+rK91ztQ3w72/54jmPZOMp6JmterBmnuWVwzYjW7lOktKWhvKRa3Jk?=
 =?iso-8859-1?Q?9ykrZDaq1fsL3ijFUleuAZ150LbnotPVk77bn80MiN/f7KuptGMZMWndHa?=
 =?iso-8859-1?Q?dmlczgJv6oyZw4/uFhkq5Ykc6Z1bBJTzcKh5lWCgR82SRJiJ1Y2sIU8GG1?=
 =?iso-8859-1?Q?vYfesefNsjkVgbjV+MTa3UtENQNi/mOUSEVLAYqL4NkyFb2xMH3Rk+wETL?=
 =?iso-8859-1?Q?rGsB/87NHmK1fokOhpxIXpzGtrm2gGsgjSEcfxOP4o9OPZgFFkUxusnsNB?=
 =?iso-8859-1?Q?Rmhjw0AwRxxsoqsC4ITdMh68x7atlqzFmoKGQGGg6WfS8oM77iIF9+mOp5?=
 =?iso-8859-1?Q?cyhktqPO1KvzKaMzC3JtMX4TpQ4oFeLocnPdnLrO5KjLOoGVz3EQ87GLMU?=
 =?iso-8859-1?Q?A4cv8W6xBu4nyhRrLbXm+CZkycsjjp7C8SoYeD3vcAakGo+T+tdIYGgpH7?=
 =?iso-8859-1?Q?bodgQetPBM4othKhi71ApVkQhkKaOOcvrm0mdsmuUmtaf8W57q232Ci3nX?=
 =?iso-8859-1?Q?5HSqYAOv9AzD5Nrt/05zxoiBsomzV9XDhPLLRif6kDBgOpWFOLwbTspKtb?=
 =?iso-8859-1?Q?nbn6xuHRhaYZxYlpsBvewzc0OowK6QiaFAApPrbaWf7zn++q6I5THqYQUr?=
 =?iso-8859-1?Q?8Sd0ZZkdPPH9xwxkPdp8eQgygWnbNtlcGkUBg/W7AObUaTR+dpnNhKka+5?=
 =?iso-8859-1?Q?C+SD/7wKhGGXDZYRIIdMxveEpLNcmqud2RjiLDLYv4iEGHBao9kF8L8A1m?=
 =?iso-8859-1?Q?sXGFGe4olFdJhG5mTFfoUr57Di76qLKdS6P7EbORmTqIK8g73X4vkeDiZZ?=
 =?iso-8859-1?Q?2mCXbOfHMGMCvrZfHGlrEzZwVogCt6/4v26ARfaVMt5eJJGyvbftPmrQ6V?=
 =?iso-8859-1?Q?DegYGGX7mxYNSgRQDbBKaAxcerGQnAeuk15AdjyvuZLmhiO07aoEEUR2oc?=
 =?iso-8859-1?Q?K9vKBTQqPHu8dTkqApmdSowFeaBLicoznlQA5SnQ3w4Q6ecE0sEu666XQa?=
 =?iso-8859-1?Q?0QR+mcLj1X5FGOCacv5OvbO1faSCjYtB0mQH/GEi0EmXLLexPTaLTFZLs9?=
 =?iso-8859-1?Q?Z9d6xuAHYDGOwrufTt5L7+uRlbxenpdHttyBCv2S6jFU/kM=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b478a7-f747-4469-f19c-08d93a431a52
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 14:43:32.6358 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iIRtImIHMAzqPnnT557hMI43RNgyF21oYRCq2LItE1CirId2UYBzuqqhKy+DSmSk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5460
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Min, 
 Frank" <Frank.Min@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0462250875=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0462250875==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CO6PR12MB54736D0FD916C1F0C3F0C42FA2039CO6PR12MB5473namp_"

--_000_CO6PR12MB54736D0FD916C1F0C3F0C42FA2039CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Hi Chris,

amdgpu_ttm_access_memory(struct ttm_buffer_object *bo, unsigned long offset=
, void *buf, int len,  int write)

the above function will be called from kernel side (likes 'get_user_pages' =
code path),  and the function should accept non-aligned addresses.
without this patch, this function will be using MM_INDEX/DATA to handle ali=
gned address whether in visible memory or not.
for this kind of case , I think the driver should check whether VRAM apertu=
re works first, then using MM_INDEX/DATA as a backup option.

for this patch, I only extend amdgpu_device_vram_access() function to suppo=
rt un-aligned case, and the new function is fully compatible with the old c=
ode logic.
I can't understand why you give a NAK about this patch, I think it's a good=
 optimization, how do you think?
thanks.

Best Regards,
Kevin
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Monday, June 28, 2021 10:10 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add non-aligned address supported in amdgp=
u_device_vram_access()

Am 25.06.21 um 05:24 schrieb Kevin Wang:
> 1. add non-aligned address support in amdgpu_device_vram_access()
> 2. reduce duplicate code in amdgpu_ttm_access_memory()
>
> because the MM_INDEX{HI}/DATA are protected register, it is not working
> in sriov environment when mmio protect feature is enabled (in some asics)=
,
> and the old function amdgpu_ttm_access_memory() will force using MM_INDEX=
/DATA
> to handle non-aligned address by default, it will cause the register(MM_D=
ATA)
> is always return 0.
>
> with the patch, the memory will be accessed in the aper way first.
> (in visible memory or enable pcie large-bar feature), then using
> MM_INDEX{HI}/MM_DATA to access rest vram memroy.

Well NAK to the whole approach.

The amdgpu_device_vram_access() are intentionally *NOT* using the VRAM
aperture nor providing byte wise access.

And yes that this doesn't work under SRIOV is completely intentional as
well.

What we could do is to use the aperture in amdgpu_ttm_access_memory()
for unaligned access if that is indeed a problem.

Regards,
Christian.


>
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 69 ++++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 42 ++-----------
>   3 files changed, 58 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index d14b4968a026..8095d9a9c857 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1103,7 +1103,7 @@ void amdgpu_device_fini(struct amdgpu_device *adev)=
;
>   int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);
>
>   void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
> -                            uint32_t *buf, size_t size, bool write);
> +                            void *buf, size_t size, bool write);
>   uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
>                            uint32_t reg, uint32_t acc_flags);
>   void amdgpu_device_wreg(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index e6702d136a6d..2047e3c2b365 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -280,6 +280,54 @@ bool amdgpu_device_supports_smart_shift(struct drm_d=
evice *dev)
>                amdgpu_acpi_is_power_shift_control_supported());
>   }
>
> +static inline void amdgpu_device_vram_mmio_align_access_locked(struct am=
dgpu_device *adev, loff_t pos,
> +                                                            uint32_t *va=
lue, bool write)
> +{
> +     BUG_ON(!IS_ALIGNED(pos, 4));
> +
> +     WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);
> +     WREG32_NO_KIQ(mmMM_INDEX_HI, pos >> 31);
> +     if (write)
> +             WREG32_NO_KIQ(mmMM_DATA, *value);
> +     else
> +             *value =3D RREG32_NO_KIQ(mmMM_DATA);
> +}
> +
> +static void amdgpu_device_vram_mmio_access_locked(struct amdgpu_device *=
adev, loff_t pos,
> +                                               void *buf, size_t size, b=
ool write)
> +{
> +     while (size) {
> +             uint64_t aligned_pos =3D ALIGN_DOWN(pos, 4);
> +             uint64_t bytes =3D 4 - (pos & 0x3);
> +             uint32_t shift =3D (pos & 0x3) * 8;
> +             uint32_t mask =3D 0xffffffff << shift;
> +             uint32_t value =3D 0;
> +
> +             if (size < bytes) {
> +                     mask &=3D 0xffffffff >> (bytes - size) * 8;
> +                     bytes =3D size;
> +             }
> +
> +             if (mask !=3D 0xffffffff) {
> +                     amdgpu_device_vram_mmio_align_access_locked(adev, a=
ligned_pos, &value, false);
> +                     if (write) {
> +                             value &=3D ~mask;
> +                             value |=3D (*(uint32_t *)buf << shift) & ma=
sk;
> +                             amdgpu_device_vram_mmio_align_access_locked=
(adev, aligned_pos, &value, true);
> +                     } else {
> +                             value =3D (value & mask) >> shift;
> +                             memcpy(buf, &value, bytes);
> +                     }
> +             } else {
> +                     amdgpu_device_vram_mmio_align_access_locked(adev, a=
ligned_pos, buf, write);
> +             }
> +
> +             pos +=3D bytes;
> +             buf +=3D bytes;
> +             size -=3D bytes;
> +     }
> +}
> +
>   /*
>    * VRAM access helper functions
>    */
> @@ -294,13 +342,11 @@ bool amdgpu_device_supports_smart_shift(struct drm_=
device *dev)
>    * @write: true - write to vram, otherwise - read from vram
>    */
>   void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
> -                            uint32_t *buf, size_t size, bool write)
> +                            void *buf, size_t size, bool write)
>   {
>        unsigned long flags;
> -     uint32_t hi =3D ~0;
>        uint64_t last;
>
> -
>   #ifdef CONFIG_64BIT
>        last =3D min(pos + size, adev->gmc.visible_vram_size);
>        if (last > pos) {
> @@ -321,25 +367,12 @@ void amdgpu_device_vram_access(struct amdgpu_device=
 *adev, loff_t pos,
>                        return;
>
>                pos +=3D count;
> -             buf +=3D count / 4;
> +             buf +=3D count;
>                size -=3D count;
>        }
>   #endif
> -
>        spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> -     for (last =3D pos + size; pos < last; pos +=3D 4) {
> -             uint32_t tmp =3D pos >> 31;
> -
> -             WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);
> -             if (tmp !=3D hi) {
> -                     WREG32_NO_KIQ(mmMM_INDEX_HI, tmp);
> -                     hi =3D tmp;
> -             }
> -             if (write)
> -                     WREG32_NO_KIQ(mmMM_DATA, *buf++);
> -             else
> -                     *buf++ =3D RREG32_NO_KIQ(mmMM_DATA);
> -     }
> +     amdgpu_device_vram_mmio_access_locked(adev, pos, buf, size, write);
>        spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
>   }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 6297363ab740..cf5b8bdc2dd3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1430,8 +1430,6 @@ static int amdgpu_ttm_access_memory(struct ttm_buff=
er_object *bo,
>        struct amdgpu_bo *abo =3D ttm_to_amdgpu_bo(bo);
>        struct amdgpu_device *adev =3D amdgpu_ttm_adev(abo->tbo.bdev);
>        struct amdgpu_res_cursor cursor;
> -     unsigned long flags;
> -     uint32_t value =3D 0;
>        int ret =3D 0;
>
>        if (bo->mem.mem_type !=3D TTM_PL_VRAM)
> @@ -1439,41 +1437,13 @@ static int amdgpu_ttm_access_memory(struct ttm_bu=
ffer_object *bo,
>
>        amdgpu_res_first(&bo->mem, offset, len, &cursor);
>        while (cursor.remaining) {
> -             uint64_t aligned_pos =3D cursor.start & ~(uint64_t)3;
> -             uint64_t bytes =3D 4 - (cursor.start & 3);
> -             uint32_t shift =3D (cursor.start & 3) * 8;
> -             uint32_t mask =3D 0xffffffff << shift;
> -
> -             if (cursor.size < bytes) {
> -                     mask &=3D 0xffffffff >> (bytes - cursor.size) * 8;
> -                     bytes =3D cursor.size;
> -             }
> +             amdgpu_device_vram_access(adev, cursor.start,
> +                                       buf, cursor.size,
> +                                       write);
>
> -             if (mask !=3D 0xffffffff) {
> -                     spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> -                     WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)aligned_pos) |=
 0x80000000);
> -                     WREG32_NO_KIQ(mmMM_INDEX_HI, aligned_pos >> 31);
> -                     value =3D RREG32_NO_KIQ(mmMM_DATA);
> -                     if (write) {
> -                             value &=3D ~mask;
> -                             value |=3D (*(uint32_t *)buf << shift) & ma=
sk;
> -                             WREG32_NO_KIQ(mmMM_DATA, value);
> -                     }
> -                     spin_unlock_irqrestore(&adev->mmio_idx_lock, flags)=
;
> -                     if (!write) {
> -                             value =3D (value & mask) >> shift;
> -                             memcpy(buf, &value, bytes);
> -                     }
> -             } else {
> -                     bytes =3D cursor.size & ~0x3ULL;
> -                     amdgpu_device_vram_access(adev, cursor.start,
> -                                               (uint32_t *)buf, bytes,
> -                                               write);
> -             }
> -
> -             ret +=3D bytes;
> -             buf =3D (uint8_t *)buf + bytes;
> -             amdgpu_res_next(&cursor, bytes);
> +             ret +=3D cursor.size;
> +             buf +=3D cursor.size;
> +             amdgpu_res_next(&cursor, cursor.size);
>        }
>
>        return ret;


--_000_CO6PR12MB54736D0FD916C1F0C3F0C42FA2039CO6PR12MB5473namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui web (west =
european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfont, r=
oboto, &quot;helvetica neue&quot;, sans-serif; font-size: 12pt; color: rgb(=
50, 49, 48); background-color: rgba(0, 0, 0, 0);">Hi Chris,</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui web (west =
european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfont, r=
oboto, &quot;helvetica neue&quot;, sans-serif; font-size: 12pt; color: rgb(=
50, 49, 48); background-color: rgba(0, 0, 0, 0);">amdgpu_ttm_access_memory(=
struct
 ttm_buffer_object *bo, unsigned long offset, void *buf, int len,&nbsp;</sp=
an><span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui web (we=
st european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfont=
, roboto, &quot;helvetica neue&quot;, sans-serif; font-size: 12pt; color: r=
gb(50, 49, 48); background-color: rgba(0, 0, 0, 0);">&nbsp;int
 write) &nbsp;</span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui web (west =
european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfont, r=
oboto, &quot;helvetica neue&quot;, sans-serif; font-size: 12pt; color: rgb(=
50, 49, 48); background-color: rgba(0, 0, 0, 0);">the above function will
 be called from kernel side (likes 'get_user_pages' code path),&nbsp; and t=
he function should</span><span style=3D"font-family: &quot;segoe ui&quot;, =
&quot;segoe ui web (west european)&quot;, &quot;segoe ui&quot;, -apple-syst=
em, blinkmacsystemfont, roboto, &quot;helvetica neue&quot;, sans-serif; fon=
t-size: 12pt; color: rgb(50, 49, 48); background-color: rgba(0, 0, 0, 0);">=
&nbsp;accept
 non-aligned addresses.</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui web (west =
european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfont, r=
oboto, &quot;helvetica neue&quot;, sans-serif; font-size: 12pt; color: rgb(=
50, 49, 48); background-color: rgba(0, 0, 0, 0);">without this patch, this
 function will be using MM_INDEX/DATA to handle aligned address whether&nbs=
p;</span><span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui w=
eb (west european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsyst=
emfont, roboto, &quot;helvetica neue&quot;, sans-serif; font-size: 12pt; co=
lor: rgb(50, 49, 48); background-color: rgba(0, 0, 0, 0);">in
 visible memory or not.</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
</div>
<div><span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui web (=
west european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfo=
nt, roboto, &quot;helvetica neue&quot;, sans-serif; font-size: 12pt; color:=
 rgb(50, 49, 48); background-color: rgba(0, 0, 0, 0);">for this kind of cas=
e
 , I think the driver should check whether VRAM aperture works first, then =
using MM_INDEX/DATA a</span><span style=3D"font-family: &quot;segoe ui&quot=
;, &quot;segoe ui web (west european)&quot;, &quot;segoe ui&quot;, -apple-s=
ystem, blinkmacsystemfont, roboto, &quot;helvetica neue&quot;, sans-serif; =
font-size: 12pt; color: rgb(50, 49, 48); background-color: rgba(0, 0, 0, 0)=
;">s
 a backup option.</span></div>
<div><br>
</div>
<div><span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui web (=
west european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfo=
nt, roboto, &quot;helvetica neue&quot;, sans-serif; font-size: 12pt; color:=
 rgb(50, 49, 48); background-color: rgba(0, 0, 0, 0);">for this patch, I on=
ly
 extend amdgpu_device_vram_access() function to support un-aligned case, </=
span><span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui web (=
west european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfo=
nt, roboto, &quot;helvetica neue&quot;, sans-serif; font-size: 12pt; color:=
 rgb(50, 49, 48); background-color: rgba(0, 0, 0, 0);">and
 the new function is fully compatible with the old code logic.</span></div>
<div><span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui web (=
west european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfo=
nt, roboto, &quot;helvetica neue&quot;, sans-serif; font-size: 12pt; color:=
 rgb(50, 49, 48); background-color: rgba(0, 0, 0, 0);">I can't understand
 why you give a NAK about this patch, </span><span style=3D"font-family: &q=
uot;segoe ui&quot;, &quot;segoe ui web (west european)&quot;, &quot;segoe u=
i&quot;, -apple-system, blinkmacsystemfont, roboto, &quot;helvetica neue&qu=
ot;, sans-serif; font-size: 12pt; color: rgb(50, 49, 48); background-color:=
 rgba(0, 0, 0, 0);">I
 think it's a good optimization, how do you think?</span></div>
<div><span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui web (=
west european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfo=
nt, roboto, &quot;helvetica neue&quot;, sans-serif; font-size: 12pt; color:=
 rgb(50, 49, 48); background-color: rgba(0, 0, 0, 0);">thanks.</span></div>
<div><br>
</div>
<div><span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui web (=
west european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfo=
nt, roboto, &quot;helvetica neue&quot;, sans-serif; font-size: 12pt; color:=
 rgb(50, 49, 48); background-color: rgba(0, 0, 0, 0);">Best Regards,</span>=
</div>
<div><span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui web (=
west european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfo=
nt, roboto, &quot;helvetica neue&quot;, sans-serif; font-size: 12pt; color:=
 rgb(50, 49, 48); background-color: rgba(0, 0, 0, 0);">Kevin</span><br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Monday, June 28, 2021 10:10 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: add non-aligned address supported i=
n amdgpu_device_vram_access()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Am 25.06.21 um 05:24 schrieb Kevin Wang:<br>
&gt; 1. add non-aligned address support in amdgpu_device_vram_access()<br>
&gt; 2. reduce duplicate code in amdgpu_ttm_access_memory()<br>
&gt;<br>
&gt; because the MM_INDEX{HI}/DATA are protected register, it is not workin=
g<br>
&gt; in sriov environment when mmio protect feature is enabled (in some asi=
cs),<br>
&gt; and the old function amdgpu_ttm_access_memory() will force using MM_IN=
DEX/DATA<br>
&gt; to handle non-aligned address by default, it will cause the register(M=
M_DATA)<br>
&gt; is always return 0.<br>
&gt;<br>
&gt; with the patch, the memory will be accessed in the aper way first.<br>
&gt; (in visible memory or enable pcie large-bar feature), then using<br>
&gt; MM_INDEX{HI}/MM_DATA to access rest vram memroy.<br>
<br>
Well NAK to the whole approach.<br>
<br>
The amdgpu_device_vram_access() are intentionally *NOT* using the VRAM <br>
aperture nor providing byte wise access.<br>
<br>
And yes that this doesn't work under SRIOV is completely intentional as <br=
>
well.<br>
<br>
What we could do is to use the aperture in amdgpu_ttm_access_memory() <br>
for unaligned access if that is indeed a problem.<br>
<br>
Regards,<br>
Christian.<br>
<br>
<br>
&gt;<br>
&gt; Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 69 ++++++++++=
++++++------<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;&nbsp; =
| 42 ++-----------<br>
&gt;&nbsp;&nbsp; 3 files changed, 58 insertions(+), 55 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index d14b4968a026..8095d9a9c857 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -1103,7 +1103,7 @@ void amdgpu_device_fini(struct amdgpu_device *ad=
ev);<br>
&gt;&nbsp;&nbsp; int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);<=
br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; void amdgpu_device_vram_access(struct amdgpu_device *adev,=
 loff_t pos,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; uint32_t *buf, size_t size, bool write);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; void *buf, size_t size, bool write);<br>
&gt;&nbsp;&nbsp; uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; uint32_t reg, uint32_t acc_flags);<br>
&gt;&nbsp;&nbsp; void amdgpu_device_wreg(struct amdgpu_device *adev,<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index e6702d136a6d..2047e3c2b365 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -280,6 +280,54 @@ bool amdgpu_device_supports_smart_shift(struct dr=
m_device *dev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_acpi_is_power_shift_control_supported());<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +static inline void amdgpu_device_vram_mmio_align_access_locked(struct=
 amdgpu_device *adev, loff_t pos,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *valu=
e, bool write)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(!IS_ALIGNED(pos, 4));<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | =
0x80000000);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; WREG32_NO_KIQ(mmMM_INDEX_HI, pos &gt;&gt; 31=
);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (write)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_NO_KIQ(mmMM_DATA, *value);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *value =3D RREG32_NO_KIQ(mmMM_DATA);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void amdgpu_device_vram_mmio_access_locked(struct amdgpu_devic=
e *adev, loff_t pos,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *buf, size_t=
 size, bool write)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; while (size) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t aligned_pos =3D ALIGN_DOWN(pos, 4);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t bytes =3D 4 - (pos &amp; 0x3);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t shift =3D (pos &amp; 0x3) * 8;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t mask =3D 0xffffffff &lt;&lt; shift;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t value =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (size &lt; bytes) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mask &amp;=3D 0xfffffff=
f &gt;&gt; (bytes - size) * 8;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bytes =3D size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (mask !=3D 0xffffffff) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_vram_mmio=
_align_access_locked(adev, aligned_pos, &amp;value, false);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (write) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; value &amp;=3D ~mask;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; value |=3D (*(uint32_t *)buf &lt;&lt; shift) &amp;=
 mask;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_vram_mmio_align_access_locked(adev, =
aligned_pos, &amp;value, true);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; value =3D (value &amp; mask) &gt;&gt; shift;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; memcpy(buf, &amp;value, bytes);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_vram_mmio=
_align_access_locked(adev, aligned_pos, buf, write);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pos +=3D bytes;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; buf +=3D bytes;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; size -=3D bytes;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp; * VRAM access helper functions<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt; @@ -294,13 +342,11 @@ bool amdgpu_device_supports_smart_shift(struct d=
rm_device *dev)<br>
&gt;&nbsp;&nbsp;&nbsp; * @write: true - write to vram, otherwise - read fro=
m vram<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; void amdgpu_device_vram_access(struct amdgpu_device *adev,=
 loff_t pos,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; uint32_t *buf, size_t size, bool write)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; void *buf, size_t size, bool write)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hi =3D ~0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t last;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -<br>
&gt;&nbsp;&nbsp; #ifdef CONFIG_64BIT<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last =3D min(pos + size, ade=
v-&gt;gmc.visible_vram_size);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (last &gt; pos) {<br>
&gt; @@ -321,25 +367,12 @@ void amdgpu_device_vram_access(struct amdgpu_dev=
ice *adev, loff_t pos,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;=
<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pos +=3D count;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; buf +=3D count / 4;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; buf +=3D count;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; size -=3D count;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;adev-=
&gt;mmio_idx_lock, flags);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; for (last =3D pos + size; pos &lt; last; pos=
 +=3D 4) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t tmp =3D pos &gt;&gt; 31;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (tmp !=3D hi) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_NO_KIQ(mmMM_INDE=
X_HI, tmp);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hi =3D tmp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (write)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_NO_KIQ(mmMM_DATA=
, *buf++);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *buf++ =3D RREG32_NO_KI=
Q(mmMM_DATA);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_vram_mmio_access_locked(adev, =
pos, buf, size, write);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock_irqrestore(&amp;=
adev-&gt;mmio_idx_lock, flags);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ttm.c<br>
&gt; index 6297363ab740..cf5b8bdc2dd3 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt; @@ -1430,8 +1430,6 @@ static int amdgpu_ttm_access_memory(struct ttm_b=
uffer_object *bo,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *abo =3D tt=
m_to_amdgpu_bo(bo);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D amdgpu_ttm_adev(abo-&gt;tbo.bdev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_res_cursor cur=
sor;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo-&gt;mem.mem_type !=3D=
 TTM_PL_VRAM)<br>
&gt; @@ -1439,41 +1437,13 @@ static int amdgpu_ttm_access_memory(struct ttm=
_buffer_object *bo,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_first(&amp;bo-&gt=
;mem, offset, len, &amp;cursor);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (cursor.remaining) {<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t aligned_pos =3D cursor.start &amp; ~(uint64_t)3;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t bytes =3D 4 - (cursor.start &amp; 3);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t shift =3D (cursor.start &amp; 3) * 8;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t mask =3D 0xffffffff &lt;&lt; shift;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (cursor.size &lt; bytes) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mask &amp;=3D 0xfffffff=
f &gt;&gt; (bytes - cursor.size) * 8;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bytes =3D cursor.size;<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_device_vram_access(adev, cursor.start,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; buf, cursor.size,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; write);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (mask !=3D 0xffffffff) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;=
adev-&gt;mmio_idx_lock, flags);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_NO_KIQ(mmMM_INDE=
X, ((uint32_t)aligned_pos) | 0x80000000);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_NO_KIQ(mmMM_INDE=
X_HI, aligned_pos &gt;&gt; 31);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D RREG32_NO_KIQ=
(mmMM_DATA);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (write) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; value &amp;=3D ~mask;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; value |=3D (*(uint32_t *)buf &lt;&lt; shift) &amp;=
 mask;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; WREG32_NO_KIQ(mmMM_DATA, value);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock_irqrestore(=
&amp;adev-&gt;mmio_idx_lock, flags);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!write) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; value =3D (value &amp; mask) &gt;&gt; shift;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; memcpy(buf, &amp;value, bytes);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bytes =3D cursor.size &=
amp; ~0x3ULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_vram_acce=
ss(adev, cursor.start,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint32_t *)buf, =
bytes,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret +=3D bytes;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; buf =3D (uint8_t *)buf + bytes;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_res_next(&amp;cursor, bytes);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret +=3D cursor.size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; buf +=3D cursor.size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_res_next(&amp;cursor, cursor.size);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB54736D0FD916C1F0C3F0C42FA2039CO6PR12MB5473namp_--

--===============0462250875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0462250875==--
