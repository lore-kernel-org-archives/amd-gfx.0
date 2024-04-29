Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135E8C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 13:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CFFE10FED6;
	Mon, 29 Apr 2024 13:49:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FXHcWBSp";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7468910FECC
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 13:49:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihwCHBnaYnMljZ2z/3tpgsplfmxrEaLVr+5qEk6sEy3DIzhZB46u0iMwd2iHn1YddC5rfh+3ZmBvmOvMjsxGa1PAOTyrOuRHDdcSFWORb7nmunxKDrv9rYmbb90hPFE3E0/ut7fOpZBXPpe3yLRO47E/JvgnMcmOaApPPePcKFemJxakzWAYf9NVDLRwFI5yXmUEd8KJtTCKXwr+AJzFLw6pT+phz4JAy9fkxEaEus0Y2MQ4LM/H7AKu0NAwft11nMKaKE31MCNbLMT94yBTtuI3qY3Ss/GOF960R1WtnN2CypAamJfXHs1UvT9l5aTMc14JbTTfkgQX14L96HCzTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+mg0q1g96AlA0ZuQeB+Mo+m9K4/Z5ppGNK/xdaokMU=;
 b=jVm61yEIpoGfp4C7YXIJHywMKkd6VVMZGJ7x8JHw8CR3eh3K4xTuf2BDjMH6fds0HPU1AS24TyVqvV0IF4/X/w67jdIBi3ySDAFj0VT1LtBV8gID9wKmntWX07Ab2Gny/uzhNwyi9Bq+TNS1HBU2yIu1iDWGwK3TtPuiyF+jLWxU62khJTMGJS2cvcJ2ULOmJOJqtuaKVqO58yMXo5Z0P3tJAT/qMfiTPI10xbWowp9lwEvhjv1LAxXnx0SYXCjLghaj8XNwhYC29WzcINe6XkG0nMfu5swwiaWawNCgUh/Mt5X4aAGNV/qQX2mCKUJbNkFJDPS4/1EsLeaqqjal4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+mg0q1g96AlA0ZuQeB+Mo+m9K4/Z5ppGNK/xdaokMU=;
 b=FXHcWBSp8PNpbHjqUdea+0sEvkxwnsVp8sdC07cJGVcZ4Xz3ebRN6HpUOH2KVAjL0f7h/4IIaqp1/ChPpL7uc4gs2EPqcnFxhdaxl4uxLmz+N4dLDxChHRDF+g4s5PKQ6Lb+2LEPSO9VolkamtXlM3A+KTt41WDrtyr8Q7iAVFw=
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by DS0PR12MB9059.namprd12.prod.outlook.com (2603:10b6:8:c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 13:49:02 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::daf7:af35:c454:4c1a]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::daf7:af35:c454:4c1a%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 13:49:02 +0000
From: "Jiang, Sonny" <Sonny.Jiang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v3] drm/amdgpu: IB test encode test package change for VCN5
Thread-Topic: [PATCH v3] drm/amdgpu: IB test encode test package change for
 VCN5
Thread-Index: AQHal0y5jYAkLzWwX06e/WdK29BgQ7F5aupJgAXebpU=
Date: Mon, 29 Apr 2024 13:49:02 +0000
Message-ID: <BL1PR12MB5126895C8370BD0317F06EA0FD1B2@BL1PR12MB5126.namprd12.prod.outlook.com>
References: <20240425201058.3240622-1-sonny.jiang@amd.com>
 <BL1PR12MB5126C7B6431803722AC813A8FD172@BL1PR12MB5126.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5126C7B6431803722AC813A8FD172@BL1PR12MB5126.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-29T13:49:01.605Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5126:EE_|DS0PR12MB9059:EE_
x-ms-office365-filtering-correlation-id: 06ab3913-28c4-47ea-6b09-08dc685320c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?g1+0/z9M1MF3X4o9r6Olkmd3KFzifiWqp0cSsuFY4qO1nHS3ALAq6Lc5vus2?=
 =?us-ascii?Q?N6I5KoBBNhxFGIIoq9+16ziC7woQIgQABFPEWfE5mKO3adnNCO0C4sa8fGM0?=
 =?us-ascii?Q?JD6i53gU4P1yn37TVX7glGdyPjp9OQuZ3/4RbU26Mf7b88dqSi4Zs2OqB9Vq?=
 =?us-ascii?Q?CdOHZKx9tFNqhsapINVQI/djkNpA6dD/SYXfor7y7lv+ug6yU8pmrAe5cbg2?=
 =?us-ascii?Q?TwjpXUF+S+bcJm+1HfHAeZNb5bRGWBaA3PF4am4xTrSmOh8uBs66R3jj81Yw?=
 =?us-ascii?Q?SjwGJIq+p+G2vlYu2st/uuX3E/fqamr/H8Opa81Qo/1T9SOBYS9uEo5UH6JF?=
 =?us-ascii?Q?DRfQQD0/fxAxlsG5Hpw6DpFO/ABxz4eqpkEZcJxworVJKuSbs2nGUXyQLJhw?=
 =?us-ascii?Q?8yFhrTnXqZTqqLvCia21dfDeVS/Fc3jjACnmZzoj7kGJKaAI6G/Dc9vT+p/i?=
 =?us-ascii?Q?iwRLqsIYyA4LY8xYoKlJ9/BiUPhzQAgcw8DXIlLeMJFGn0GPk2+kWepOQTlc?=
 =?us-ascii?Q?ekTSNjCJcoavCh16EuhuHCSikKGYriPokKClOstzpuTczygpMay6w0vmR5ZI?=
 =?us-ascii?Q?IZ0k4PZrdH1uiqhVoOW7YnsvwuokQgChNpVx0JuUWT/dipo558gyZej6K5wK?=
 =?us-ascii?Q?9/qC3SZ8JHRJQ8k+sV91ZcVtr5a/o5Fduj4MFmvXu20/+FhVDGQluodP+x6Q?=
 =?us-ascii?Q?3yKh9M50yRi0bnS+d4VLP6TM4pDMxb5mSjK38J1SARzxRivLIvY8/auRtdLi?=
 =?us-ascii?Q?2bj991srOsCifAJkagQG49WxN9c15avKUPaxPrhnEg31DIZYqEF7TTQUXfzL?=
 =?us-ascii?Q?F3pr0hHxaoiKnF/pRHvS0BXF60w8wd6aNBN3Nfn9PihJEsVzP14MdFeoV6kp?=
 =?us-ascii?Q?XkUdVFFFsWQ1I1s3qpZybJGXGOGvI4r6C9On7lh74h0ArnEMqTiWuJXRxOom?=
 =?us-ascii?Q?6wISDEfqOizfbfehrWSegz6Eg0mHAJYUKjx18opK7xqUeoZ74fcWlhMCsTPg?=
 =?us-ascii?Q?aHhG1z/Rui1teKIbZ+zIdUAwDMxlHuaym1RMsoiQjl3ELNM0J5DxbmwiWvF+?=
 =?us-ascii?Q?22xi2wAeche9xVYXpdMLF2pfvIw/eh+uSJhS/GfYv2B76AvPA7pQgS2WX0jk?=
 =?us-ascii?Q?do/h0wPr1jZA9A6FE4n7fyoHOD6Zh+VJ+bgXM5ulDjLc/mVuXtkgXtspuQ6K?=
 =?us-ascii?Q?EEyfCu1eaPKvN8bG0X+aVxS0mosZObZN9UHT0d+djxZgpGHRtmRXy59mTIdX?=
 =?us-ascii?Q?yMq+6P5gmblNLeZ/P59jDP1va6eioAmclOhhb8vOPNNgDZlcSq54Q0xugWE2?=
 =?us-ascii?Q?YKz9udNrL9QrXgKkomHtT6Q1?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9bBxFrKrvFtEqC4TcT9wvFYIagQG6LYzwvASUUjEEF768YSTHYKZtqhAgsE+?=
 =?us-ascii?Q?CzH8cZXVMSDSw6U/W9Uv3W/XBA4XpVpaC6KvCVJpXILyhy405dCRxYb8SUkQ?=
 =?us-ascii?Q?2SLqwvd7MbaPEfiE2gMpiZUp5cVEaZjm5G+bBaUmWcBb6mUbJC3I4pqO/avF?=
 =?us-ascii?Q?v0KVUoeeO6OqSPMnSn74FokyAPpSc2Tmac+guDyhocwZfQ/Y9Lq5oMb+JnBg?=
 =?us-ascii?Q?jHcecb7Iz38u7u4HfNsx+YdtEDSOrKy+XV290lhVC/3Z/m05pl4NAhBnYZeT?=
 =?us-ascii?Q?BaAsVSBiPvnpfnk9cg4A9q9ZzfGy0AUPkVm4KdZd7+M4S64rr0YSVlyD0t3H?=
 =?us-ascii?Q?KUTQuPkA6BBCEPGVxsvVgtnlva1uwkGTj1xcuDfn6MuUo/VzjeSlUPzR1Hm5?=
 =?us-ascii?Q?GzLpKPO30/j3vXVNMSdhphhJFVgMEM5z0ehBhYYAz9ccJm7FKUEM9rlFI0uw?=
 =?us-ascii?Q?EaFDkwnOKb8nxdTAcAYXdLE9cCkXL00pRWPlLPI+OfY+FUbe4UYm2++SH3i2?=
 =?us-ascii?Q?r0NW2npGEWMI6doTygy2jdmgFtE7Iy64l49K4ra/uJ6xpDD8nzg5dmcRTOl5?=
 =?us-ascii?Q?18KkBKcA31IRexwTeaAKvq0AqkrGCwSQBCY9eTN+1hHHRSi1v/xIKY3NGjE1?=
 =?us-ascii?Q?ZuLK1WZWjRv7D2JQX1+4EPVZWGVQd9TznRxICqhbcvSxNTpO0njR2Kh3lEZk?=
 =?us-ascii?Q?EFcNbq7cpPuBb6rUy/U71zzVkMwgRXauCu4nTOBE+cNM1tZaFPhXyvTaM4KP?=
 =?us-ascii?Q?os07ARg2uU6d39pDYWeg7Yx1z/o56dbtTlPtr2iGAL9jI0ngyetYYi5sAxnm?=
 =?us-ascii?Q?zg0tyhKh31kjjo7318C/u3NfBC5cGyGZrRCy15ieAP2kOApRxmENwDZjmZKN?=
 =?us-ascii?Q?fzCjkyctQgA7PlrDzf+eUTxfE/7aBidxADW1k6Tfejd4qYJnu9oqkhp87PP8?=
 =?us-ascii?Q?OefldvcZR6FYPeejzJdgT+ol3+/fa8QHEwUlL6Ere1Q+jgSUFEzG4s+QpqqN?=
 =?us-ascii?Q?bku4XdupP7uNuO5iyKpc0Fo7zP6ov7FZO+iw9W4Gc1XmCx4kSsakgxkmKrBn?=
 =?us-ascii?Q?HdWTRrAg789uAXTag1h4Ns0O3q3Ay6x1SwLmXWlK2I7nvQFB2ya1FBU+GMHR?=
 =?us-ascii?Q?VXrTNCBL4OGtqmxQDjSBugI4cTU411g41t6mPWTpX0uqTDbeWruwzjCz2xGj?=
 =?us-ascii?Q?9A7Sc3zCcSV5jIDagR+z7Ke+HVgTYkk104YW0SouFD1TTrepwHZ5oa2uoTQb?=
 =?us-ascii?Q?Kk5fmbCnfXeu8yMWzz7uqfXW4qmbq+1YCMJamgnrx4Y99UQWowGNZ+l+cV5a?=
 =?us-ascii?Q?bbQ4y+e70/sEPylZsrP0kwb5g5Eh3rBc3o9NG1gG/YOr7s4yO/28vuBGr0y7?=
 =?us-ascii?Q?1vpZaOVtf6AKV0g40SRjzstHlfpszahjjM4TAGtRfnTTga7er7alcuUss9HR?=
 =?us-ascii?Q?71ySFBWb6aV5d9z5clt/EAer43xaVNhoEWYq6snj1MhmmliwIud5/x/bjQ1T?=
 =?us-ascii?Q?SgQGGhE2ZzAiBjpcYOdnrp4gLRo+zmKLUF/6eQ0aUaHBRGQHZENndZ+TEC9q?=
 =?us-ascii?Q?1HT3s7SduKmAQ+ZWTHM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5126895C8370BD0317F06EA0FD1B2BL1PR12MB5126namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ab3913-28c4-47ea-6b09-08dc685320c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 13:49:02.0778 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MvB3aCKoigDtVpJ1A4Q9Ykq+m6/7v9tkOhgZoMBcUUs1uot3oiXOvVmwovZrp/SqrYWCElsmAiaqEcjQwOZQcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9059
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

--_000_BL1PR12MB5126895C8370BD0317F06EA0FD1B2BL1PR12MB5126namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Ping.

Sonny
________________________________
From: Jiang, Sonny <Sonny.Jiang@amd.com>
Sent: Thursday, April 25, 2024 4:12 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v3] drm/amdgpu: IB test encode test package change for =
VCN5

By tests, I didn't find error on VCN1 to VCN4.

Thanks,
Sonny

________________________________
From: Jiang, Sonny <Sonny.Jiang@amd.com>
Sent: Thursday, April 25, 2024 4:10 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Jiang, Sonny <Sonny.Jiang@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>
Subject: [PATCH v3] drm/amdgpu: IB test encode test package change for VCN5

From: Sonny Jiang <sonjiang@amd.com>

VCN5 session info package interface changed

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
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


--_000_BL1PR12MB5126895C8370BD0317F06EA0FD1B2BL1PR12MB5126namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Ping.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sonny</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Jiang, Sonny &lt;Sonn=
y.Jiang@amd.com&gt;<br>
<b>Sent:</b> Thursday, April 25, 2024 4:12 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> Re: [PATCH v3] drm/amdgpu: IB test encode test package chan=
ge for VCN5</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
By tests, I didn't find error on VCN1 to VCN4.</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Thanks,</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Sonny</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Jiang, Sonny &lt;So=
nny.Jiang@amd.com&gt;<br>
<b>Sent:</b> Thursday, April 25, 2024 4:10 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Jiang, Sonny &lt;Sonny.Jiang@amd.com&gt;; Jiang, Sonny &lt;Sonny=
.Jiang@amd.com&gt;<br>
<b>Subject:</b> [PATCH v3] drm/amdgpu: IB test encode test package change f=
or VCN5</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">From: Sonny Jiang &lt;sonjiang@amd.com&gt;<br>
<br>
VCN5 session info package interface changed<br>
<br>
Signed-off-by: Sonny Jiang &lt;sonny.jiang@amd.com&gt;<br>
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
2.43.2<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB5126895C8370BD0317F06EA0FD1B2BL1PR12MB5126namp_--
