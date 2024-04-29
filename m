Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD49C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 18:20:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3370B10F8C4;
	Mon, 29 Apr 2024 18:20:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Rl7yBy6";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D65F710F8C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 18:20:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tm0T6VVCTLRetbszJGKzaMFjb9jPpE8NhlahtE68Oe8enmAUC36KEZVqNkpdT4mCJXD7z0Q0FnC7sHs+zfRvXxzjclJF90pc2PMpeIXMmlkZsBpieEHZ/LRxw3uDwQCZ8j54FjDogE+aDswfZ7jnuL+7+e5a6b8qbIpZJWWBE/o9w8kwdesCo+3DJP1yJN7UuhJeN1vQmUA98SyfQDzFVwtByafj3Cs3C+BKinuQ1d4tDvw+B+INjQDKMemtanrj5LAgMtkxpP5lfXM8PhaNjYapiR/4Sy5D2fOuOljD17m1GCGUomZj51s6g5+teTTIcLzBC5ZZxJcRv2yKJYXnWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ackWk6SH46Q7/bcLuvJ8GMS08ovO8j2e+N7Tvc5/gX0=;
 b=YimIMUrp8lLYugh7e5i7f/Y6Fc8nBRPcGJ2MBEVKznFgAXQCMuLByLwy3R4bXjLyZR53ADz5BXgT07UhvlCrKG+lfBMtAbWmHK1k/DHRczTx7Z6W/bk+7wMcyV5Bdlqv5I4rwUV94ylq0eA0WKjjXXEq1zxfxxZOxLaFrKOvEzD1jRPsOa6o1TFmEivPrRNWpZCpsKwmGW2xHwjT4gTIDc4Om1QErBkWa4oZnTqAMt1UqjGSmnmT/8I4m4s+UhFzC9+e7iw5KaMIwewkYYZy6wQgR7JOXWVtVKUf0cvWuTbozMW5anESZbGOYaqcZZ7prwB6tKFtqiDU1IH7xczPAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ackWk6SH46Q7/bcLuvJ8GMS08ovO8j2e+N7Tvc5/gX0=;
 b=5Rl7yBy6EZduGccjpgcBaHVkNyPivns51aa48BRn+tG1DJSQbzIp7cCeLGfYTO/ale9n7ybOmx90qTfjoEg/L7emLYH5lhHFeEPOBgZ/TO8ICMJ/EyY0hAxM8crm551db+QQMTgSWardhLmPOUYLn/NadqecBkSyj1hzqUg1caU=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by SN7PR12MB7853.namprd12.prod.outlook.com (2603:10b6:806:348::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Mon, 29 Apr
 2024 18:20:38 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9%3]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 18:20:38 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Jiang, Sonny" <Sonny.Jiang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3] drm/amdgpu: IB test encode test package change for VCN5
Thread-Topic: [PATCH v3] drm/amdgpu: IB test encode test package change for
 VCN5
Thread-Index: AQHal0y9HOINMYeaOkS8kwPziCEB5bF5ax0AgAXeRQCAAEvYcA==
Date: Mon, 29 Apr 2024 18:20:38 +0000
Message-ID: <SJ1PR12MB6194FB67B213BCCB425210AB951B2@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20240425201058.3240622-1-sonny.jiang@amd.com>
 <BL1PR12MB5126C7B6431803722AC813A8FD172@BL1PR12MB5126.namprd12.prod.outlook.com>
 <BL1PR12MB5126895C8370BD0317F06EA0FD1B2@BL1PR12MB5126.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5126895C8370BD0317F06EA0FD1B2@BL1PR12MB5126.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-29T13:49:01.605Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|SN7PR12MB7853:EE_
x-ms-office365-filtering-correlation-id: 7353bc12-1d7e-4969-8fa3-08dc6879124a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?0nsrJZ/4tQCR4vK1IVoF54g7uqC3GE41+8f+Sk5DxWUOsIiRghMgeLkWP7/L?=
 =?us-ascii?Q?kEGx9N6wE08k4lyhTykAL5GkTs/D+6PJh4ZiKmOlbnVUdc62z9Zf9ERLZKGM?=
 =?us-ascii?Q?hEKB5LAmfsiG0q4M0wwndvywfsoOuUd2u1b6CJgf/D0yRGF2A7OfyPbSP8gL?=
 =?us-ascii?Q?eG9Wpn5G9yt9fih9KENcZfQBP46PS0vgZXFf3eRvMYVVQ+79yaUAEih6Mhbe?=
 =?us-ascii?Q?xhb1dr3g49hjwwLMTycw9AYRbUydic47sZW8dhjE+qgYYAMESe24FsAVV9nk?=
 =?us-ascii?Q?SXVL7bqp79uHwcfCmVw5nF1+o2kslQnLHL9AZTgkssdmsJnKJXgUJBl7cT6h?=
 =?us-ascii?Q?dH+2NPI62DhmQ1v4qAFiMxTz2SN1kw35iuih170jVSNm+orivmCgtoUZx3Ec?=
 =?us-ascii?Q?/ef1VYT5LpyjvoeVQcg95lgq227+PODbRfeYUIUCoubqKOivtGivXnAAgmwy?=
 =?us-ascii?Q?mDgRJJgyeF/TsGEOyUqiBTJo48fBZ+AgFvCvEvz1vUg65ADg6j+YcUl7/K20?=
 =?us-ascii?Q?NAf6qnEp+1gxNDXoL0m4grwivoVb6PBcvQhIcZXJ7gpmDJbh7EFPxCikMs80?=
 =?us-ascii?Q?ZeRgYIqVfpiIvJnkUoi04SKx0yb+64E2BgXTU7A8u4kcMp4YkiSyc1z3zzp4?=
 =?us-ascii?Q?CmC2ln2x9NvrHTlvQcDt0T/3tcJL1Gx9n5K4xEtrxThOn+5DY/lBwp0rBWEG?=
 =?us-ascii?Q?URMttlNszfCP2NeDuG7MAMih0OghSLu9spB/AZwCoXRu94dGVO/vhGtnOsBq?=
 =?us-ascii?Q?Jzj6UnWVqEfSUksoYwbJe3EPiAbIdNacNgfDSzWe365TdLkyVA3uM+0q/ufF?=
 =?us-ascii?Q?/6CukrWE5BQbiHIsVSVgjzj1jzpQpWxSnE7JO6jCKlFzIYH6lrigejIXFm8M?=
 =?us-ascii?Q?yzw7ua7wtRXX0ljqqmLW/UjLdaUoupt4DuHcVH2SvskgQqwhOO5VEZhVhi7w?=
 =?us-ascii?Q?+MtuHUMP3ITMCtoQyZffCImXPgPxUqwOCxnVG3uJ+tVr/4kee2ZroC/hJsQZ?=
 =?us-ascii?Q?ojTNwMOWRbR6N4OrFor5Yv2peA5MUcpwYANmKv3OMsPsniau71a0Dq0K6Xxl?=
 =?us-ascii?Q?tZKs1evAgGPzNHFvTza3jkWslwxxuDgPKu9Z+Z9hmlqDybR2KoRZJ2l9cbQD?=
 =?us-ascii?Q?jkcicdwzlByWsbeOaw9P7bXBCMoBaX6cJaGb07qY9aHEJ7y6lPgIu2+A3j3s?=
 =?us-ascii?Q?M8kjDB+NLZz4lmH2XqFDU5LFBY1E2zJNRB3NbKCz+AtyitKzdRaWqKpKNWgT?=
 =?us-ascii?Q?lhJum+jNoQk8/DmNJ94yxOpGIvEWx7u7Lkmk7GYPRMkCbKyGhX2gNYkkHRUF?=
 =?us-ascii?Q?9yGh5LFTJVfcHQ4pHc0VT33SH61fWU1R7Y3CzuRCNGEoaQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VuEKuUKkyM6PvVDmCYOnVOErDgHB+pT6QItqw3pQgSOhGxLCBj5NZ0gA8Fql?=
 =?us-ascii?Q?i9ERDV+kYxChLuQeSpOQujy65yauzWH82QAzUJeCHUoYrefNNV3v3nJdsV5E?=
 =?us-ascii?Q?0E1wXWDhNKYsjf5XsvqL8hUiLHLiMyXAszfPISXSv+1TPv+q/SXSx6GMqsch?=
 =?us-ascii?Q?U0rsApF6FtBhKQrXWOoM0VbHkE0yG2vNNSrnM9RteMdRmagPv4f5Vn5N9SKR?=
 =?us-ascii?Q?31Tnl/7kZToxoj9sYXDvrJFATOWhNvvV0kZrhtVGTJ1Jm//J2nWuUAZC+rO6?=
 =?us-ascii?Q?7RF9MIctTVZJ3mKk9OL8gt9Ql7JenVDnC606L1RTYOxofZAFGsj6gcLf+Y2b?=
 =?us-ascii?Q?2aq/37Nv2Kl8jAmcs72ijqoZ2m4irXPRlcTW47qKP8hRe3VxI8SlSvrXzpLh?=
 =?us-ascii?Q?vOvO0XQ3sWQCP0Ihv408jQOkGlLpoa2AMx9sauiutBz1QWEV2+smFJDejeDm?=
 =?us-ascii?Q?DRBCZQ+wWwyvy8D3uwxiqkIhtKkebdYfnCsQObvGEkfm+UxyvTr/Q9AVHSTb?=
 =?us-ascii?Q?KC5MboePKVcoBwnvkZUfnsNckjMrXtptZ+nDKroVXe4aR3d12EV3jSyradb6?=
 =?us-ascii?Q?VUzaglRUiVfjfHfxqsvDbZQyp6962KpfBEspx3LCq4wO8LDpIfZgn/SD5tS8?=
 =?us-ascii?Q?WTAAHM026aRwwETSLMVlna4ccELiNhXnmJPZ5OErBRmwYSASMp4unkyEOp04?=
 =?us-ascii?Q?2A6bxN2yLhiZ2BmZOTLYTF4HkY+EGPuljrx83IC0gLvF0X9qbgRkG3ED9BhX?=
 =?us-ascii?Q?sGdK+44dPcOZH7nckxJ4bZPuIyHlhe/gkZ2lEdmnoF/S1rVaJv8REVrWDmmS?=
 =?us-ascii?Q?MoIo3OzEPx8qdod9zoQBq8bijRd1k9/mA70FVf+t+TBktbTpbHtZ3d9wbltA?=
 =?us-ascii?Q?cEOn/FSqMr/vNp1Zg+Tb+cjUxv72BjLZLPpuiqy+lqtwZ0I5cMICNvq8MdwT?=
 =?us-ascii?Q?tbUjFs3j+jwWg39h/TvqSZsa3UyY+HVrewyOpvXLVIbNol/jGtFN40Y6iKFX?=
 =?us-ascii?Q?kK7gg0U49jh3wl3UaamZpI+zDE4GNsgNLGHr7Z3jBUmVsHBUTMOolOnmDi+V?=
 =?us-ascii?Q?ETjkJoCLb2Xw+jcP0F9IZzqDygteXaOZPVPCObzGFMgHi9aZSdmOmjzXjsuG?=
 =?us-ascii?Q?xmOyvPyqHPBTKsfUvSD+QrYcCoOphXf9IRFTS7zn5eS2nF19zt5ABw2qc4Ai?=
 =?us-ascii?Q?2hRLJFDz9EvOyzApYTTKjoQu/+Bldk57cKZXP3t0pBb/yL/o8cK4HSjruTuY?=
 =?us-ascii?Q?2GhxgQuLviVRcsP0hYZM2eK9k3W5NnNpsszZDEUlzNjcsUme+rIukfswuj2v?=
 =?us-ascii?Q?VkcwCThd11pwcjm9KHxNLl8o432n1tSz+YAiWPZ8PaOPwI15wL3PaQjUbJCu?=
 =?us-ascii?Q?bf5l6FhuD1FdUvBSC+4VKKgpunw0sccpSlqq/m16RzkJMQcSBzg8aGuYckXn?=
 =?us-ascii?Q?edHNk5Hap7IQPh6QVpPTk+/1xqsG3Vikzxe30TioEaD5/2lc7IniTDtjEMqj?=
 =?us-ascii?Q?4GRM8XhE0l1j3qKb+wxRiDslQAELAKDONhV0cEg7fKhx8Vnwtw1YjubYY4kH?=
 =?us-ascii?Q?SduKwbHzDnQ8CKF8DBg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SJ1PR12MB6194FB67B213BCCB425210AB951B2SJ1PR12MB6194namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7353bc12-1d7e-4969-8fa3-08dc6879124a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 18:20:38.6887 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GGuR8jxhUFuqaltLd/kqA7x2cXLYFBsILs12bvdRAsCjDvJ3rQMui4/yo7J39Psj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7853
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

--_000_SJ1PR12MB6194FB67B213BCCB425210AB951B2SJ1PR12MB6194namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Ruijing Dong ruijing.dong@amd.com<mailto:ruijing.dong@amd.com>

Thanks,
Ruijing

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jiang, S=
onny
Sent: Monday, April 29, 2024 9:49 AM
To: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3] drm/amdgpu: IB test encode test package change for =
VCN5


[AMD Official Use Only - General]


[AMD Official Use Only - General]

Ping.

Sonny
________________________________
From: Jiang, Sonny <Sonny.Jiang@amd.com<mailto:Sonny.Jiang@amd.com>>
Sent: Thursday, April 25, 2024 4:12 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: Re: [PATCH v3] drm/amdgpu: IB test encode test package change for =
VCN5

By tests, I didn't find error on VCN1 to VCN4.

Thanks,
Sonny

________________________________
From: Jiang, Sonny <Sonny.Jiang@amd.com<mailto:Sonny.Jiang@amd.com>>
Sent: Thursday, April 25, 2024 4:10 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Jiang, Sonny <Sonny.Jiang@amd.com<mailto:Sonny.Jiang@amd.com>>; Jiang, =
Sonny <Sonny.Jiang@amd.com<mailto:Sonny.Jiang@amd.com>>
Subject: [PATCH v3] drm/amdgpu: IB test encode test package change for VCN5

From: Sonny Jiang <sonjiang@amd.com<mailto:sonjiang@amd.com>>

VCN5 session info package interface changed

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com<mailto:sonny.jiang@amd.com>=
>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index 677eb141554e..b89605b400c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -885,7 +885,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_=
ring *ring, uint32_t hand
         ib->ptr[ib->length_dw++] =3D handle;
         ib->ptr[ib->length_dw++] =3D upper_32_bits(addr);
         ib->ptr[ib->length_dw++] =3D addr;
-       ib->ptr[ib->length_dw++] =3D 0x0000000b;
+       ib->ptr[ib->length_dw++] =3D 0x00000000;

         ib->ptr[ib->length_dw++] =3D 0x00000014;
         ib->ptr[ib->length_dw++] =3D 0x00000002; /* task info */
@@ -952,7 +952,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu=
_ring *ring, uint32_t han
         ib->ptr[ib->length_dw++] =3D handle;
         ib->ptr[ib->length_dw++] =3D upper_32_bits(addr);
         ib->ptr[ib->length_dw++] =3D addr;
-       ib->ptr[ib->length_dw++] =3D 0x0000000b;
+       ib->ptr[ib->length_dw++] =3D 0x00000000;

         ib->ptr[ib->length_dw++] =3D 0x00000014;
         ib->ptr[ib->length_dw++] =3D 0x00000002;
--
2.43.2

--_000_SJ1PR12MB6194FB67B213BCCB425210AB951B2SJ1PR12MB6194namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:m=3D"http://sc=
hemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-=
html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Reviewed-by: Ruijing Dong <a href=3D"mailto:ruijing.=
dong@amd.com">
ruijing.dong@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Ruijing<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Jiang, Sonny<br>
<b>Sent:</b> Monday, April 29, 2024 9:49 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH v3] drm/amdgpu: IB test encode test package chan=
ge for VCN5<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only - General]<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only - General]<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:black">Ping.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:black">Sonny<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Jiang, Sonny &lt;<a href=3D"mailto:Sonny.Jiang@amd.=
com">Sonny.Jiang@amd.com</a>&gt;<br>
<b>Sent:</b> Thursday, April 25, 2024 4:12 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Subject:</b> Re: [PATCH v3] drm/amdgpu: IB test encode test package chan=
ge for VCN5</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:black">By tests, I didn't find error on VCN1 to =
VCN4.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:black">Thanks,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:black">Sonny<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Jiang, Sonny &lt;<a href=3D"mailto:Sonny.Jiang@amd.=
com">Sonny.Jiang@amd.com</a>&gt;<br>
<b>Sent:</b> Thursday, April 25, 2024 4:10 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Jiang, Sonny &lt;<a href=3D"mailto:Sonny.Jiang@amd.com">Sonny.Ji=
ang@amd.com</a>&gt;; Jiang, Sonny &lt;<a href=3D"mailto:Sonny.Jiang@amd.com=
">Sonny.Jiang@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH v3] drm/amdgpu: IB test encode test package change f=
or VCN5</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">From: Sonny Jiang &lt=
;<a href=3D"mailto:sonjiang@amd.com">sonjiang@amd.com</a>&gt;<br>
<br>
VCN5 session info package interface changed<br>
<br>
Signed-off-by: Sonny Jiang &lt;<a href=3D"mailto:sonny.jiang@amd.com">sonny=
.jiang@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 4 ++--<br>
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c<br>
index 677eb141554e..b89605b400c0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
@@ -885,7 +885,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_=
ring *ring, uint32_t hand<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_d=
w++] =3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_d=
w++] =3D upper_32_bits(addr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_d=
w++] =3D addr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =3D 0x=
0000000b;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =3D 0x=
00000000;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_d=
w++] =3D 0x00000014;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_d=
w++] =3D 0x00000002; /* task info */<br>
@@ -952,7 +952,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu=
_ring *ring, uint32_t han<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_d=
w++] =3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_d=
w++] =3D upper_32_bits(addr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_d=
w++] =3D addr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =3D 0x=
0000000b;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =3D 0x=
00000000;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_d=
w++] =3D 0x00000014;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_d=
w++] =3D 0x00000002;<br>
-- <br>
2.43.2<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_SJ1PR12MB6194FB67B213BCCB425210AB951B2SJ1PR12MB6194namp_--
