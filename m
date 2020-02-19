Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAFFC34047
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 11:52:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D10E20658
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 11:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i0DE9/Nc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D10E20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58D326E5AE;
	Wed, 19 Feb 2020 11:52:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5DEB6E5AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 11:52:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+Veg0nJJcG5cpmibY5hTT7wEdiuLlinVxV1xEUofQwM70pxLsxWFG9ZPwesQTL21RKBrTeDYNAyX0izbG/V8Eq0dTga9jBvpqnDttGlWTpN4wjEoe0tSQRrtGv9xJiT6uSUsB9l0Algg1wXUjDOuHDiR89ngRbluQyvMaiWsceeqk0wkjZRZ8IZc6oOwuyD6t94uAlqfHl4GMJpEsF8wCaLyzsW5OuOPXr4HrsuUFTsKgOoReILYsWKWNmBxK1ZE3SVzFFNGknlbMzLw2KnFPHErsCUEwmQSY7hQQ4XDUZiGufx1LSEOgRPqN6nofNmOGGeC2czo6YdrP45+81XFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vqK0zBowVreLFcaj/VcnhBta6xoBnTPqFlIz6/OCU4=;
 b=JodB9pztf4aZjn/hvwm7uWPmkqOG9oEnilT7i+wvMmRVmcuM1230/a3JGmjbBBh46aEBLcA38QawC6sOO3KNnDxto8NAIw5HifkhGEi3a6A7CgwMV5ko9VaErLPeizUnQhmFlc56s2MfyIGST96hvk7Bp50LvFF4F+cKqbRGmzrrND+QIgXmoSXdPwuTgruB96igCFP7mklauYwJfyI2ax5TlnzpO6HMBiqhLnmmTkOrOKtSBdS8HHWdoz0Xw0JiwUsYd141tT/Utkf1YYrT3auytZJc/+dHqgZ+VJqRkHtSs29A9sv6Y8uvPrlJgavYwfQiF70DVu/k7I88pqkkrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vqK0zBowVreLFcaj/VcnhBta6xoBnTPqFlIz6/OCU4=;
 b=i0DE9/NchEqJBz0SX3fE2Yw3WGKsZlIoyV6Dc7DtPO8p2YRwfkpMtewJEADLGPhLdR/RHNXTDEMfMpCS9pnfNE1yimegyuNjKyztHyqw4KnUcC28UrH0+vTk6iVeeOXndtvxjs0p8a3PajvDK8HLO/gcRlljRZtsjc4epQDhjlg=
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (20.178.244.160) by
 MN2PR12MB3198.namprd12.prod.outlook.com (20.179.82.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.29; Wed, 19 Feb 2020 11:52:28 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::b93c:2786:619:c02d]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::b93c:2786:619:c02d%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 11:52:28 +0000
From: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
To: "StDenis, Tom" <Tom.StDenis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH umr] fix field names for INDIRECT_BUFFER_CONST/CIK for
 gfx9/gfx10
Thread-Topic: [PATCH umr] fix field names for INDIRECT_BUFFER_CONST/CIK for
 gfx9/gfx10
Thread-Index: AQHV5xd+Ntz0MJRW4UmbwOxACRmzbagiZ4yAgAAAT4o=
Date: Wed, 19 Feb 2020 11:52:28 +0000
Message-ID: <MN2PR12MB30873A5C272C091E32D9A6FD89100@MN2PR12MB3087.namprd12.prod.outlook.com>
References: <20200219112629.6154-1-xiaojie.yuan@amd.com>,
 <15c10f68-2b50-b9c5-ad13-a80cea90ba89@amd.com>
In-Reply-To: <15c10f68-2b50-b9c5-ad13-a80cea90ba89@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-19T11:52:31.237Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xiaojie.Yuan@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f064ec5-7b84-49f4-88a5-08d7b5323215
x-ms-traffictypediagnostic: MN2PR12MB3198:|MN2PR12MB3198:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB319860E673B0AD2B273956F989100@MN2PR12MB3198.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:765;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(189003)(199004)(7696005)(71200400001)(66946007)(478600001)(91956017)(76116006)(66556008)(66476007)(66446008)(64756008)(186003)(26005)(2906002)(5660300002)(52536014)(86362001)(8936002)(8676002)(81156014)(81166006)(316002)(6506007)(33656002)(9686003)(53546011)(55016002)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3198;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AZ5UbdUGlkktssl6jovlh1OzR3n0lJOZWxmVB/l8MF7DnquCUIUGszSgpsJ0i+1E9hGUcP/57nuMPINqvkVtk85JOaFUZqnSzkcuoNC173x9+4BNjNahlO/uj26WixTCn7hD9QkqfuXaXJSHQSH3DoTXmYxwmQRz2XgyKR3bzB9FvrEyaVei3rbACUddG4L/J2dVfdXKNy2BM2Z8yCHpRwjXmrWqzB1j9tRowdq6faeXLQXUaMx89PTrFXGBEDdFgmgXQ2z51D5bxT/48iTFiexRo6fXZ9t03ekSpJG4l26Du4XpbyBGD/Ib2KaGrgM9W+hpC22r5Ix8lhVWFQ8Vw0v8Rq3VD3kxM6Y+vRQY7UF36whryzPU0mHA40+2GhC1FVyRbAcnyksB21dL9FE0C5kUh/gcMtZuevEAI6+lkIOZBPExYoAcNQthwj7A64GS
x-ms-exchange-antispam-messagedata: g/HzCwtKMmy4qjHjdiDf/7KnGFVl9dCUGe9blK41P0sa+nAy/1EkWD+VbmgJr4IJZovhLln8yhpsoMLmU9JP5Qa9NJcqkwvaYkl9eMKqA+vsYT6l5dORbJlaQDderFCZhbW9JFsdAp7oeYmwhEQC5w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f064ec5-7b84-49f4-88a5-08d7b5323215
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 11:52:28.8009 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KErGQJWnBscbqe5nbAQyJtc7sPcWMw902EXQUUqwB7fZy8F4kRzj8Mt8s6Pvoa4Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3198
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Sure, I'll send v2 soon.

BR,
Xiaojie

________________________________________
From: StDenis, Tom <Tom.StDenis@amd.com>
Sent: Wednesday, February 19, 2020 7:51 PM
To: Yuan, Xiaojie; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH umr] fix field names for INDIRECT_BUFFER_CONST/CIK for gfx9/gfx10

Yup, my bad.  We also need to fix the streaming version (line 432 of
src/lib/umr_pm4_decode_opcodes.c).  Would you like to incorporate this
into this patch?  Otherwise I can do it separately.

Thanks,

Tom

On 2020-02-19 6:26 a.m., Xiaojie Yuan wrote:
> field names for INDIRECT_BUFFER_CONST/CIK of gfx9/gfx10 are the same.
> fields like OFFLOAD_POLLING and VALID are defined in mec's
> INDIRECT_BUFFER packet, so not applicable here.
>
> Signed-off-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
> ---
>   src/lib/ring_decode.c | 23 +++++++----------------
>   1 file changed, 7 insertions(+), 16 deletions(-)
>
> diff --git a/src/lib/ring_decode.c b/src/lib/ring_decode.c
> index 250dfd7..fa44f27 100644
> --- a/src/lib/ring_decode.c
> +++ b/src/lib/ring_decode.c
> @@ -617,22 +617,13 @@ static void print_decode_pm4_pkt3(struct umr_asic *asic, struct umr_ring_decoder
>                               case 2: printf("IB_SIZE:%s%lu%s, VMID: %s%lu%s", BLUE, BITS(ib, 0, 20), RST, BLUE, BITS(ib, 24, 28), RST);
>                                       decoder->pm4.next_ib_state.ib_size = BITS(ib, 0, 20) * 4;
>                                       decoder->pm4.next_ib_state.ib_vmid = decoder->next_ib_info.vmid ? decoder->next_ib_info.vmid : BITS(ib, 24, 28);
> -                                     if (decoder->pm4.cur_opcode == 0x33) {
> -                                             if (asic->family >= FAMILY_NV) {
> -                                                     printf(", CHAIN: %s%u%s, PRE_ENA: %s%u%s, CACHE_POLICY: %s%u%s, PRE_RESUME: %s%u%s PRIV: %s%u%s",
> -                                                                BLUE, (unsigned)BITS(ib, 20, 21), RST,
> -                                                                BLUE, (unsigned)BITS(ib, 21, 22), RST,
> -                                                                BLUE, (unsigned)BITS(ib, 28, 30), RST,
> -                                                                BLUE, (unsigned)BITS(ib, 30, 31), RST,
> -                                                                BLUE, (unsigned)BITS(ib, 31, 32), RST);
> -                                             } else if (asic->family >= FAMILY_AI) {
> -                                                     printf(", CHAIN: %s%u%s, OFFLOAD_POLLING: %s%u%s, VALID: %s%u%s, CACHE_POLICY: %s%u%s PRIV: %s%u%s",
> -                                                                BLUE, (unsigned)BITS(ib, 20, 21), RST,
> -                                                                BLUE, (unsigned)BITS(ib, 21, 22), RST,
> -                                                                BLUE, (unsigned)BITS(ib, 23, 24), RST,
> -                                                                BLUE, (unsigned)BITS(ib, 28, 30), RST,
> -                                                                BLUE, (unsigned)BITS(ib, 31, 32), RST);
> -                                             }
> +                                     if (asic->family >= FAMILY_AI) {
> +                                             printf(", CHAIN: %s%u%s, PRE_ENA: %s%u%s, CACHE_POLICY: %s%u%s, PRE_RESUME: %s%u%s PRIV: %s%u%s",
> +                                                        BLUE, (unsigned)BITS(ib, 20, 21), RST,
> +                                                        BLUE, (unsigned)BITS(ib, 21, 22), RST,
> +                                                        BLUE, (unsigned)BITS(ib, 28, 30), RST,
> +                                                        BLUE, (unsigned)BITS(ib, 30, 31), RST,
> +                                                        BLUE, (unsigned)BITS(ib, 31, 32), RST);
>                                       }
>                                       if (!asic->options.no_follow_ib) {
>                                               if (umr_read_vram(asic, decoder->pm4.next_ib_state.ib_vmid,
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
