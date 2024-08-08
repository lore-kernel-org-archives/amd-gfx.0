Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C0CC52D73
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 21:36:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37FCB10E820;
	Thu,  8 Aug 2024 21:36:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zZYxgPHO";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3EEA10E820
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 21:36:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKMyo/tJXmGS/bYRlxiDa+W6sLYU8sTNi0H76qswWrYv/h2Nv6Rvdze+AQBsDa/avMojOK8td83k9xON8e5lafg3bzjKC+CdQohnOjZ2DGStm7uDFElfJugJrLfvX21YPFLACJhomgGnuQekZipXhdNSZlEup48fJqsu/GpQp+O4GAg7dn4zbXoB7+VqtomeRFLpppISxgfTcOYYg035mIYfDbaKB0ckiGSrybo1HEAlCGLHPiepx0KJ4/NQHw5FF0/wJFcCU98s7myC5VKRuCXEPzTmUnqRpyLuXK2qzGba9OXYjIokgRrQaGB8zXv5c41GdsNHHJkJ52BMYAnQAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6IBZcn9462yE86sQjX+/S0NXswGGXdCp/y6tr+jrWI=;
 b=TKd39kf4AzrkSJzsUsrl8Kq/bUpSnd/ht2tv2f5alRozMzSwJCMgt9jSIKDhpb3iQc+0nygca/z1SnQCMvKEWPz3IhehQrgT+tHaASsuTiDoAS+1nDAsXA2H4XskSSUFlEmxN2A7N1Xwae+vWHT3M5I5gNebUQFNV7/G93NK1cYh8Hal2pF9PeUjQrT3LPH0LzCwZreif7xJ2Q9H3lwf4AyIKTFMOvN9zRjHt9Mc0+eXbkuHActPWzRoqy2kzdqUcoX9s3PzvLaT7e3BZdR5VDU1yblgRCAPoPcOfX3N8q3MN2ltoIY09G0jfVm6dAEL60BESNvsWV+Ar3wLLs1PLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6IBZcn9462yE86sQjX+/S0NXswGGXdCp/y6tr+jrWI=;
 b=zZYxgPHOIfPJg4lSQp0NYn0TQeXkpkxGSXvu170QJq4XqEaZLJdBehgkrmWsDSj//L6WkbiBJ1160fkyrCUq8CSLmtMUIkntDSvh0E4BKdBybWZa+qIG/zdYVuIFwOF/QT9nINEWQwa7cpV7R9/2Rnda8MpDQhVwzPuVBR52Fpo=
Received: from PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18)
 by CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Thu, 8 Aug
 2024 21:36:02 +0000
Received: from PH7PR12MB6420.namprd12.prod.outlook.com
 ([fe80::e0e7:bd76:e99:43af]) by PH7PR12MB6420.namprd12.prod.outlook.com
 ([fe80::e0e7:bd76:e99:43af%5]) with mapi id 15.20.7849.014; Thu, 8 Aug 2024
 21:36:02 +0000
From: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: Re: amd-gfx Digest, Vol 98, Issue 341
Thread-Topic: amd-gfx Digest, Vol 98, Issue 341
Thread-Index: AQHa3rCn3G5FzMWux0yUxViTdOZsyLId+C2I
Date: Thu, 8 Aug 2024 21:36:02 +0000
Message-ID: <PH7PR12MB64209ED7115C483713E4350B81B92@PH7PR12MB6420.namprd12.prod.outlook.com>
References: <mailman.1050.1721925321.1129.amd-gfx@lists.freedesktop.org>
In-Reply-To: <mailman.1050.1721925321.1129.amd-gfx@lists.freedesktop.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-08T21:36:02.015Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6420:EE_|CH2PR12MB4071:EE_
x-ms-office365-filtering-correlation-id: 9ae85ea7-e58e-4c99-5442-08dcb7f219e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|4022899009|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?3Tt+KaVmw5GTGYgQPBmGQsFLwds60vHjBqgrAPYxzbuTNpPnPE0rUcNyqMfR?=
 =?us-ascii?Q?mK8s2W5IHT4plhBxz9FJi9IqTLH0LlI5RbEMr9gOZvMupu72lgARqUoj0aVw?=
 =?us-ascii?Q?lE+//IlJyYxFWKEIxY8vuvZO4dNrLdjtKxaRTLQoysBG7UlsbuVc0b8/x0DQ?=
 =?us-ascii?Q?o1PNaecknosBZaoPGk8bvTcyNTzrXGl2KpXIPVK0c3B8M7Fo43XGO6Ggn6yD?=
 =?us-ascii?Q?TqmG5Le1LJbJtrUKAAF7PUleUOwawO1EJCoP697J0MYD9O4Pb7t+ODiag/5f?=
 =?us-ascii?Q?HSGbUEvBWdVz9dESygiQhGtNutZXKqlZAC/0YYtrgLFE1fNB0se0PGVbqaos?=
 =?us-ascii?Q?OR/lDk2k+x6VvTsEF0VlcIxupA+aPCr2R0xYiG5LSr42v0H3Ag4Iwc5kgyNz?=
 =?us-ascii?Q?ViHfrCSrWB6lqkrm004sJiUAyDKJDL5dI8BR6uFgmwYeYhRo0+kQBU1h/mBR?=
 =?us-ascii?Q?QyKCD6ZqRX7uiLD7kguFG4FuA+uFpJlTVHuyaepDFXvylnlVgNSC14/iJAVm?=
 =?us-ascii?Q?x01xtQ3jXL1cKABs8W5Bf+AFlv7EE4FvMh+y1qyGy2/jhQU2oMYrEH7Dq7Yr?=
 =?us-ascii?Q?dn7y43/RgFks1MawjB4Hj0R2UKoWGaoyM6dYPo4gGQjVrLr08bHciSRKM9V5?=
 =?us-ascii?Q?gym6cwvez3Mt5jR+6IgcpzgUZk7tBtDN+7LrtKLetb5a5OH9V6mSq8zgtW/2?=
 =?us-ascii?Q?4J9nO8n9nf9u9nFtjDix7acMpH76XtXt0segQtnuQKgcDFbuc7UIb1P3Z5OH?=
 =?us-ascii?Q?iiKoL3jdwdLSqAkpxmJ56/kGY1t8/bt26v7TvbpHGvdokVt1+AXGZCdeui1m?=
 =?us-ascii?Q?oPfSxw16xgz+4KkS3zgsLt4BsjBp2MIj8gky3ocs/GIv4xp+KRKH59tpM8Pq?=
 =?us-ascii?Q?YEQVDryOZb3u6huBIAW6LvR9b2lG81SJuPemqXnVkymzIkH8QRDhimKiTtnh?=
 =?us-ascii?Q?L9fudPROwEiGCXq2ZJSSXIhs5vyFOSpqz02Wb2YFjKqH+bJiHKhkuf6B0B+R?=
 =?us-ascii?Q?bQuvLOPc8xvDX93X1omahCgPpBXtRo5u3z6pfD9kop/Kb/c7kDGFJAPeqMdV?=
 =?us-ascii?Q?of+eFdX96PWNPSiRk/uJnjkSsIkgdkabIQljBHAbnQBnrgQGh3f5QacDt+7h?=
 =?us-ascii?Q?ZiMgVM/Vhx6QhNpde7dpx/mzYMbtzCAv/SgHN+JU50LdNxu6HmKHIT9LxY8M?=
 =?us-ascii?Q?e5rVHMjEm2ldqdgZ1RPjaUbr/YC0ikC1BskQmf0hGoZ/a3Ld/bZ2HqjcHFTh?=
 =?us-ascii?Q?ZT+Gva4b4IjSzFu4Mi6zIMXk7rM1cLFq4xGDVZ61eI/yi6y/CiV5YKlF9R2o?=
 =?us-ascii?Q?S4DRIOo0k9YeV5PCqFTxU550dgwyCboSN5rLiSfFAHDrOcI8e8NKa4npDI7Z?=
 =?us-ascii?Q?M3Huhg8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6420.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(4022899009)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9i3BEwq6iYwELe+vi86d9zd4qD9WizXKztTuW+q3YCPLtZUyreTK3JHWKXkK?=
 =?us-ascii?Q?0G8pYG2HmTgccgTkZpGInrVRrbHTHI++YiBb92qBoP4LOxfcOVDbDroqO7f0?=
 =?us-ascii?Q?fLe+CoQ/W8PVFuZdIu8+JOhRX+z6PtsdTPJzwowqH7X2FQZxo8niFZVHNcKP?=
 =?us-ascii?Q?ybxChoQjJSULwLIDGzGB7B0o+Tq+K1l3AMaLXm9TK7SYm4DbaIuhEX+A0wmZ?=
 =?us-ascii?Q?4OQC36xjO7Ou58mdVkiA19RdMGQCemKQlgWwq3yQALqsteCCvsVQgTEl5oHv?=
 =?us-ascii?Q?kQ+lkd88k787gpazmFxP0Jw8iu0A0WnQhuW6kal8UyHgdelRJA5gZ+qLdlsO?=
 =?us-ascii?Q?Z9RmS2kEhOo02ABGXSbp0H9M93gYvMilEwp1s+gdItFCAZUDg5D8pZRlKsK9?=
 =?us-ascii?Q?p6kSQHMVnnz3+tYZ14ZLmbUBon13ZxGb7DWddFVt6s5LFuVtPZZ4UfYGUy5p?=
 =?us-ascii?Q?NdCX/Agv1n+3q/OyS5fQHpZigtNXOONW1Psn50/fOCDLodD2wQHguqxTIqTk?=
 =?us-ascii?Q?XlcSPesVMjyNJi2l3OLYPnsUlvDn3n81F+tS9kXqKGd8ZrwIoi5/horldIzC?=
 =?us-ascii?Q?NH1BhebdxaCbpFkJ932Yfl7a5FRTB+AaX7tYGpYUxFxI0Gn0gUMpd4Be4Vuo?=
 =?us-ascii?Q?ktxIcXxKlbxsb0buRiYj5z/+cYTklQdzIMAdRNrpjiEQlyuq97KQ7m6ghLil?=
 =?us-ascii?Q?68nhX7cxWJHp/lQDBXI03za8sD0GxwkrVJPK2qUNZ8Ogdv4o1PmFu79h91+5?=
 =?us-ascii?Q?Iyporz4d5OIb68oHHjlNZb/F2He4+Cp3FI9FSbRfAsuCCvQAF6nVc8USORJp?=
 =?us-ascii?Q?ewN0iRaR0xdQzq7LTTfeMtzQ0hmkDJH6vAApii0t1S3cQyzcFfPFS+cCVX1V?=
 =?us-ascii?Q?aHbIpfW5z+ZQOYkX8ABkx1FU3CubFivrbiI/0fl9mHwPlFHZ3x4UKplkXt3y?=
 =?us-ascii?Q?fti1je30Ery4t6HhuzV0RS4NtXF48/qJzHYOZZe+9LNQ3TlLgui2OKpUFgtx?=
 =?us-ascii?Q?8vyVeggg0v727T3l6uMH4GkxbqhFOFQGljl3TxRapwGyszzU+9Q6o/3eoQJs?=
 =?us-ascii?Q?IleJnPtSWLtG6moVWdor/paiWgi77wLhBHgPkt34eLMy8JvfJ4ZVFHuCx7Pj?=
 =?us-ascii?Q?NugbFEJbc2rsZRWNI500KErTObFoafAtFsmqw/ldk6DfXHbMegTB0MEovjHv?=
 =?us-ascii?Q?d2N9lWvcSEaQF91EYF19eFi1MNKyb3J+Kes6pVyyiDsr4RJJEBZ4xs4QiYhR?=
 =?us-ascii?Q?SScwIuW+eKCescYngZiKG7/BMQKnlzjWOojnciEfFTcWwZN+IlZP4bT/A6El?=
 =?us-ascii?Q?A/SXGDb68kiNSr2FLHRgotHdUomNj1VKckdKcU033NrEupGvU0XaRKj7XNUh?=
 =?us-ascii?Q?o/YTqMb1AtbdBj5cVPnEHp3Q5jfODTsM1gqEG2H0yUdajPqxoXMdC1auLNCR?=
 =?us-ascii?Q?mqyXSceg4d3Rnu1yMwhXSQm9DZHtZNRVN6Y2+cAlKRp3gSs5yLZSKy+lgfC5?=
 =?us-ascii?Q?2NFxUTITNZycBl2ivWLTEruQthy+/Xu+MsZxaj45DU3ilu9kknccQZvZn0jR?=
 =?us-ascii?Q?E2SLQdzx+r4ekBs5HZw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB64209ED7115C483713E4350B81B92PH7PR12MB6420namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6420.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae85ea7-e58e-4c99-5442-08dcb7f219e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 21:36:02.3829 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qEaqROxWUveIF4Sbx2g73IQKSwjhYghgipW2eHdvs+I1HE/DyNHYCEOZsaNjGLzPg4pKeBAhFdmV+RmWJ/u1XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071
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

--_000_PH7PR12MB64209ED7115C483713E4350B81B92PH7PR12MB6420namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Acked-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
The entire series of patches [0-53 ] for gfx 7, 8, 9, 11 and compute gfx 10=
, 12
 queue/pipe reset was tested using the new IGT test, amd_queue_reset, which=
 has been merged upstream.
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of amd-gfx-=
request@lists.freedesktop.org <amd-gfx-request@lists.freedesktop.org>
Sent: Thursday, July 25, 2024 12:35 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: amd-gfx Digest, Vol 98, Issue 341

Send amd-gfx mailing list submissions to
        amd-gfx@lists.freedesktop.org

To subscribe or unsubscribe via the World Wide Web, visit
        https://lists.freedesktop.org/mailman/listinfo/amd-gfx
or, via email, send a message with subject or body 'help' to
        amd-gfx-request@lists.freedesktop.org

You can reach the person managing the list at
        amd-gfx-owner@lists.freedesktop.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of amd-gfx digest..."


Today's Topics:

   1. Re: [PATCH V2 00/53] GC per queue reset (Alex Deucher)
   2. Re: [PATCH v4 01/11] drm/amd/display: clean unused variables
      for hdmi freesync parser (Alex Hung)
   3. Re: [PATCH 1/2] drm/sched: Add error code parameter to
      drm_sched_start (Alex Deucher)
   4. Re: [PATCH v4 02/11] drm/amd/display: switch
      amdgpu_dm_connector to use struct drm_edid (Alex Hung)


----------------------------------------------------------------------

Message: 1
Date: Thu, 25 Jul 2024 11:29:14 -0400
From: Alex Deucher <alexdeucher@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH V2 00/53] GC per queue reset
Message-ID:
        <CADnq5_NWdzoTVOuCEOFMhC0GF+26=3D2z8nknADXyiLxmAs9fTzQ@mail.gmail.c=
om>
Content-Type: text/plain; charset=3D"UTF-8"

On Thu, Jul 25, 2024 at 11:20?AM Alex Deucher <alexander.deucher@amd.com> w=
rote:
>
> This adds preliminary support for GC per queue reset.  In this
> case, only the jobs currently in the queue are lost.  If this
> fails, we fall back to a full adapter reset.
>
> V2: Fix fallbacks to full adapter reset
>     RLC safemode cleanup
>     Preliminary support for older GPUs

Forgot to add a git link as well:
https://gitlab.freedesktop.org/agd5f/linux/-/tree/amd-staging-drm-next-queu=
e-reset?ref_type=3Dheads

Alex

>
> Alex Deucher (38):
>   drm/amdgpu/gfx10: handle SDMA in KIQ map/unmap
>   drm/amdgpu/mes11: handle second gfx pipe
>   drm/amdgpu/mes: add API for legacy queue reset
>   drm/amdgpu/mes11: add API for legacy queue reset
>   drm/amdgpu/mes12: add API for legacy queue reset
>   drm/amdgpu/mes: add API for user queue reset
>   drm/amdgpu/mes11: add API for user queue reset
>   drm/amdgpu/mes12: add API for user queue reset
>   drm/amdgpu: add new ring reset callback
>   drm/amdgpu: add per ring reset support (v5)
>   drm/amdgpu/gfx11: add ring reset callbacks
>   drm/amdgpu/gfx11: rename gfx_v11_0_gfx_init_queue()
>   drm/amdgpu/gfx10: add ring reset callbacks
>   drm/amdgpu/gfx10: rework reset sequence
>   drm/amdgpu/gfx9: add ring reset callback
>   drm/amdgpu/gfx9.4.3: add ring reset callback
>   drm/amdgpu/gfx12: add ring reset callbacks
>   drm/amdgpu/gfx12: fallback to driver reset compute queue directly
>   drm/amdgpu/gfx11: enter safe mode before touching CP_INT_CNTL
>   drm/amdgpu/gfx11: add a mutex for the gfx semaphore
>   drm/amdgpu/gfx11: export gfx_v11_0_request_gfx_index_mutex()
>   drm/amdgpu/gfx9: per queue reset only on bare metal
>   drm/amdgpu/gfx10: per queue reset only on bare metal
>   drm/amdgpu/gfx11: per queue reset only on bare metal
>   drm/amdgpu/gfx12: per queue reset only on bare metal
>   drm/amdgpu/gfx9: add ring reset callback for gfx
>   drm/amdgpu/gfx8: add ring reset callback for gfx
>   drm/amdgpu/gfx7: add ring reset callback for gfx
>   drm/amdgpu/gfx9: use proper rlc safe mode helpers
>   drm/amdgpu/gfx9.4.3: use proper rlc safe mode helpers
>   drm/amdgpu/gfx10: use proper rlc safe mode helpers
>   drm/amdgpu/gfx11: use proper rlc safe mode helpers
>   drm/amdgpu/gfx12: use proper rlc safe mode helpers
>   drm/amdgpu/gfx12: use rlc safe mode for soft recovery
>   drm/amdgpu/gfx11: use rlc safe mode for soft recovery
>   drm/amdgpu/gfx10: use rlc safe mode for soft recovery
>   drm/amdgpu/gfx9.4.3: use rlc safe mode for soft recovery
>   drm/amdgpu/gfx9: use rlc safe mode for soft recovery
>
> Jiadong Zhu (13):
>   drm/amdgpu/gfx11: wait for reset done before remap
>   drm/amdgpu/gfx10: remap queue after reset successfully
>   drm/amdgpu/gfx10: wait for reset done before remap
>   drm/amdgpu/gfx9: remap queue after reset successfully
>   drm/amdgpu/gfx9: wait for reset done before remap
>   drm/amdgpu/gfx9.4.3: remap queue after reset successfully
>   drm/amdgpu/gfx_9.4.3: wait for reset done before remap
>   drm/amdgpu/gfx: add a new kiq_pm4_funcs callback for reset_hw_queue
>   drm/amdgpu/gfx9: implement reset_hw_queue for gfx9
>   drm/amdgpu/gfx9.4.3: implement reset_hw_queue for gfx9.4.3
>   drm/amdgpu/mes: modify mes api for mmio queue reset
>   drm/amdgpu/mes: implement amdgpu_mes_reset_hw_queue_mmio
>   drm/amdgpu/mes11: implement mmio queue reset for gfx11
>
> Prike Liang (2):
>   drm/amdgpu: increase the reset counter for the queue reset
>   drm/amdgpu/gfx11: fallback to driver reset compute queue directly (v2)
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |   6 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  20 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    |  88 ++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |  37 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   2 +
>  drivers/gpu/drm/amd/amdgpu/cikd.h          |   1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 251 +++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 127 +++++++++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.h     |   3 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 103 ++++++++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      |  76 ++++++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  75 +++++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 179 ++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 132 ++++++++++-
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c     | 134 +++++++++++
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c     |  54 +++++
>  drivers/gpu/drm/amd/amdgpu/nvd.h           |   2 +
>  drivers/gpu/drm/amd/amdgpu/vid.h           |   1 +
>  19 files changed, 1243 insertions(+), 49 deletions(-)
>
> --
> 2.45.2
>


------------------------------

Message: 2
Date: Thu, 25 Jul 2024 10:23:36 -0600
From: Alex Hung <alex.hung@amd.com>
To: Melissa Wen <mwen@igalia.com>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc: Mario Limonciello <mario.limonciello@amd.com>, Jani Nikula
        <jani.nikula@linux.intel.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
Subject: Re: [PATCH v4 01/11] drm/amd/display: clean unused variables
        for hdmi freesync parser
Message-ID: <b0017268-5651-4031-901e-45e64319d537@amd.com>
Content-Type: text/plain; charset=3DUTF-8; format=3Dflowed

Hi Melissa,

There are no commit messages in this patch.

Also, do you think this can be merged with Patch 5 "drm/amd/display:
remove redundant freesync parser for  DP"?

On 2024-07-05 21:35, Melissa Wen wrote:
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 98cf523a629e..1dfa7ec9af35 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -12108,9 +12108,6 @@ void amdgpu_dm_update_freesync_caps(struct drm_co=
nnector *connector,
>        } else if (edid && sink->sink_signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_=
A) {
>                i =3D parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb=
_info);
>                if (i >=3D 0 && vsdb_info.freesync_supported) {
> -                     timing  =3D &edid->detailed_timings[i];
> -                     data    =3D &timing->data.other_data;
> -
>                        amdgpu_dm_connector->min_vfreq =3D vsdb_info.min_r=
efresh_rate_hz;
>                        amdgpu_dm_connector->max_vfreq =3D vsdb_info.max_r=
efresh_rate_hz;
>                        if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_con=
nector->min_vfreq > 10)


------------------------------

Message: 3
Date: Thu, 25 Jul 2024 12:30:07 -0400
From: Alex Deucher <alexdeucher@gmail.com>
To: vitaly.prosyak@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        jesse.zhang@amd.com
Subject: Re: [PATCH 1/2] drm/sched: Add error code parameter to
        drm_sched_start
Message-ID:
        <CADnq5_NPmHX_1j9xifr-wk3VjB5j5_inmrrP8JknQ-49A2UqwA@mail.gmail.com=
>
Content-Type: text/plain; charset=3D"UTF-8"

On Wed, Jul 24, 2024 at 11:30?PM <vitaly.prosyak@amd.com> wrote:
>
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>
> The current implementation of drm_sched_start uses a hardcoded -ECANCELED=
 to dispose of a job when
> the parent/hw fence is NULL. This results in drm_sched_job_done being cal=
led with -ECANCELED for
> each job with a NULL parent in the pending list, making it difficult to d=
istinguish between recovery
> methods, whether a queue reset or a full GPU reset was used.
>
> To improve this, we first try a soft recovery for timeout jobs and use th=
e error code -ENODATA.
> If soft recovery fails, we proceed with a queue reset, where the error co=
de remains -ENODATA for
> the job. Finally, for a full GPU reset, we use error codes -ECANCELED or =
-ETIME. This patch adds
> an error code parameter to drm_sched_start, allowing us to differentiate =
between queue reset and
> GPU reset failures. This enables user mode and test applications to valid=
ate the expected
> correctness of the requested operation. After a successful queue reset, t=
he only way to continue
> normal operation is to call drm_sched_job_done with the specific error co=
de -ENODATA.
>
> v1: Initial implementation by Jesse utilized amdgpu_device_lock_reset_dom=
ain and
>     amdgpu_device_unlock_reset_domain to allow user mode to track the que=
ue reset status and distinguish
>     between queue reset and GPU reset.
> v2: Christian suggested using the error codes -ENODATA for queue reset an=
d -ECANCELED or -ETIME for GPU
>     reset, returned to amdgpu_cs_wait_ioctl.
> v3: To meet the requirements, we introduce a new function drm_sched_start=
_ex with an additional parameter
>     to set dma_fence_set_error, allowing us to handle the specific error =
codes appropriately and dispose
>     of bad jobs with the selected error code depending on whether it was =
a queue reset or GPU reset.
> v4: Alex suggested using a new name, drm_sched_start_with_recovery_error,=
 which more accurately describes
>     the function's purpose. Additionally, it was recommended to add docum=
entation details about the new method.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> ---
>  drivers/gpu/drm/scheduler/sched_main.c | 30 +++++++++++++++++++++++---
>  include/drm/gpu_scheduler.h            |  1 +
>  2 files changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index 7e90c9f95611..c42449358b3f 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -671,13 +671,24 @@ void drm_sched_stop(struct drm_gpu_scheduler *sched=
, struct drm_sched_job *bad)
>  EXPORT_SYMBOL(drm_sched_stop);
>
>  /**
> - * drm_sched_start - recover jobs after a reset
> + * drm_sched_start_with_recovery_error - recover jobs after a reset with
> + * custom error
>   *
>   * @sched: scheduler instance
>   * @full_recovery: proceed with complete sched restart
> + * @error : err code for set dma_fence_set_error
> + *
> + * Starts the scheduler and allows setting a custom dma_fence_set_error,
> + * which can be used to identify the recovery mechanism actually used.
>   *
> + * For example:
> + * - If a soft or queue reset was used, dma_fence_set_error is set to -E=
NODATA.
> + * - If an entire GPU reset was used, the error code is set to -ECANCELE=
D.
> + *
> + * This approach enables user mode and test applications to know which
> + * recovery method was used for a given bad job.
>   */
> -void drm_sched_start(struct drm_gpu_scheduler *sched, bool full_recovery=
)
> +void drm_sched_start_with_recovery_error(struct drm_gpu_scheduler *sched=
, bool full_recovery, int error)
>  {
>         struct drm_sched_job *s_job, *tmp;
>         int r;
> @@ -704,7 +715,7 @@ void drm_sched_start(struct drm_gpu_scheduler *sched,=
 bool full_recovery)
>                                 DRM_DEV_ERROR(sched->dev, "fence add call=
back failed (%d)\n",
>                                           r);
>                 } else
> -                       drm_sched_job_done(s_job, -ECANCELED);
> +                       drm_sched_job_done(s_job, error);
>         }
>
>         if (full_recovery)
> @@ -712,6 +723,19 @@ void drm_sched_start(struct drm_gpu_scheduler *sched=
, bool full_recovery)
>
>         drm_sched_wqueue_start(sched);
>  }
> +EXPORT_SYMBOL(drm_sched_start_with_recovery_error);
> +
> +/**
> + * drm_sched_start - recover jobs after a reset
> + *
> + * @sched: scheduler instance
> + * @full_recovery: proceed with complete sched restart
> + *
> + */
> +void drm_sched_start(struct drm_gpu_scheduler *sched, bool full_recovery=
)
> +{
> +       drm_sched_start_with_recovery_error(sched, full_recovery, -ECANCE=
LED);
> +}
>  EXPORT_SYMBOL(drm_sched_start);
>
>  /**
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 5acc64954a88..444fa6761590 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -580,6 +580,7 @@ void drm_sched_wqueue_stop(struct drm_gpu_scheduler *=
sched);
>  void drm_sched_wqueue_start(struct drm_gpu_scheduler *sched);
>  void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_jo=
b *bad);
>  void drm_sched_start(struct drm_gpu_scheduler *sched, bool full_recovery=
);
> +void drm_sched_start_ex(struct drm_gpu_scheduler *sched, bool full_recov=
ery, int error);

drm_sched_start_with_recovery_error()

Alex

>  void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched);
>  void drm_sched_increase_karma(struct drm_sched_job *bad);
>  void drm_sched_reset_karma(struct drm_sched_job *bad);
> --
> 2.25.1
>


------------------------------

Message: 4
Date: Thu, 25 Jul 2024 10:35:07 -0600
From: Alex Hung <alex.hung@amd.com>
To: Melissa Wen <mwen@igalia.com>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc: Mario Limonciello <mario.limonciello@amd.com>, Jani Nikula
        <jani.nikula@linux.intel.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
Subject: Re: [PATCH v4 02/11] drm/amd/display: switch
        amdgpu_dm_connector to use struct drm_edid
Message-ID: <d1cce2ee-f12b-4d37-8729-5ff22cb64550@amd.com>
Content-Type: text/plain; charset=3DUTF-8; format=3Dflowed

Please see inline comments.

On 2024-07-05 21:35, Melissa Wen wrote:
> Replace raw edid handling (struct edid) with the opaque EDID type
> (struct drm_edid) on amdgpu_dm_connector for consistency. It may also
> prevent mismatch of approaches in different parts of the driver code.
> Working in progress. It was only exercised with IGT tests.
>
> v2: use const to fix warnings (Alex Hung)
> v3: fix general protection fault on mst
> v4: rename edid to drm_edid in amdgpu_connector (Jani)
>      call drm_edid_connector_update to clear edid in case of NULL (Jani)
>      keep setting NULL instead of free drm_edid (Jani)
>      check drm_edid not NULL, instead of valid (Jani)
>
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 106 +++++++++---------
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   4 +-
>   .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  13 ++-
>   .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  32 +++---
>   4 files changed, 79 insertions(+), 76 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1dfa7ec9af35..49b8c5b00728 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3408,7 +3408,7 @@ void amdgpu_dm_update_connector_after_detect(
>                        aconnector->dc_sink =3D sink;
>                        dc_sink_retain(aconnector->dc_sink);
>                        amdgpu_dm_update_freesync_caps(connector,
> -                                     aconnector->edid);
> +                                     aconnector->drm_edid);
>                } else {
>                        amdgpu_dm_update_freesync_caps(connector, NULL);
>                        if (!aconnector->dc_sink) {
> @@ -3467,18 +3467,20 @@ void amdgpu_dm_update_connector_after_detect(
>                aconnector->dc_sink =3D sink;
>                dc_sink_retain(aconnector->dc_sink);
>                if (sink->dc_edid.length =3D=3D 0) {
> -                     aconnector->edid =3D NULL;
> +                     aconnector->drm_edid =3D NULL;
>                        if (aconnector->dc_link->aux_mode) {
>                                drm_dp_cec_unset_edid(
>                                        &aconnector->dm_dp_aux.aux);
>                        }
>                } else {
> -                     aconnector->edid =3D
> -                             (struct edid *)sink->dc_edid.raw_edid;
> +                     const struct edid *edid =3D (const struct edid *)si=
nk->dc_edid.raw_edid;
> +                     aconnector->drm_edid =3D drm_edid_alloc(edid, sink-=
>dc_edid.length);
> +                     drm_edid_connector_update(connector, aconnector->dr=
m_edid);
>
> +                     /* FIXME: Get rid of drm_edid_raw() */
>                        if (aconnector->dc_link->aux_mode)
>                                drm_dp_cec_set_edid(&aconnector->dm_dp_aux=
.aux,
> -                                                 aconnector->edid);
Why not pass edid but drm_edid_raw(aconnector->drm_edid)?

> +                                                 drm_edid_raw(aconnector=
->drm_edid));
>                }
>
>                if (!aconnector->timing_requested) {
> @@ -3489,17 +3491,18 @@ void amdgpu_dm_update_connector_after_detect(
>                                        "failed to create aconnector->requ=
ested_timing\n");
>                }
>
> -             drm_connector_update_edid_property(connector, aconnector->e=
did);
> -             amdgpu_dm_update_freesync_caps(connector, aconnector->edid)=
;
> +             drm_edid_connector_update(connector, aconnector->drm_edid);
> +             amdgpu_dm_update_freesync_caps(connector, aconnector->drm_e=
did);
>                update_connector_ext_caps(aconnector);
>        } else {
>                drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
>                amdgpu_dm_update_freesync_caps(connector, NULL);
> -             drm_connector_update_edid_property(connector, NULL);
> +             drm_edid_connector_update(connector, NULL);
>                aconnector->num_modes =3D 0;
>                dc_sink_release(aconnector->dc_sink);
>                aconnector->dc_sink =3D NULL;
> -             aconnector->edid =3D NULL;
> +             drm_edid_free(aconnector->drm_edid);
> +             aconnector->drm_edid =3D NULL;
>                kfree(aconnector->timing_requested);
>                aconnector->timing_requested =3D NULL;
>                /* Set CP to DESIRED if it was ENABLED, so we can re-enabl=
e it again on hotplug */
> @@ -7002,13 +7005,7 @@ static void amdgpu_dm_connector_funcs_force(struct=
 drm_connector *connector)
>        struct amdgpu_dm_connector *aconnector =3D to_amdgpu_dm_connector(=
connector);
>        struct dc_link *dc_link =3D aconnector->dc_link;
>        struct dc_sink *dc_em_sink =3D aconnector->dc_em_sink;
> -     struct edid *edid;
> -     struct i2c_adapter *ddc;
> -
> -     if (dc_link && dc_link->aux_mode)
> -             ddc =3D &aconnector->dm_dp_aux.aux.ddc;
> -     else
> -             ddc =3D &aconnector->i2c->base;
> +     const struct drm_edid *drm_edid;
>
>        /*
>         * Note: drm_get_edid gets edid in the following order:
> @@ -7016,18 +7013,20 @@ static void amdgpu_dm_connector_funcs_force(struc=
t drm_connector *connector)
>         * 2) firmware EDID if set via edid_firmware module parameter
>         * 3) regular DDC read.
>         */
> -     edid =3D drm_get_edid(connector, ddc);
drm_get_edid() is removed here, and thhe above comments should be
removed as well.

> -     if (!edid) {
> +     drm_edid =3D drm_edid_read(connector);
> +     drm_edid_connector_update(connector, drm_edid);
> +     if (!drm_edid) {
>                DRM_ERROR("No EDID found on connector: %s.\n", connector->=
name);
>                return;
>        }
>
> -     aconnector->edid =3D edid;
> -
> +     aconnector->drm_edid =3D drm_edid;
>        /* Update emulated (virtual) sink's EDID */
>        if (dc_em_sink && dc_link) {
> +             const struct edid *edid =3D drm_edid_raw(drm_edid); // FIXM=
E: Get rid of drm_edid_raw()
> +
>                memset(&dc_em_sink->edid_caps, 0, sizeof(struct dc_edid_ca=
ps));
> -             memmove(dc_em_sink->dc_edid.raw_edid, edid, (edid->extensio=
ns + 1) * EDID_LENGTH);
> +             memmove(dc_em_sink->dc_edid.raw_edid, (uint8_t *)edid, (edi=
d->extensions + 1) * EDID_LENGTH);

is casting to (uint8 *) necessary?

>                dm_helpers_parse_edid_caps(
>                        dc_link,
>                        &dc_em_sink->dc_edid,
> @@ -7057,18 +7056,12 @@ static int get_modes(struct drm_connector *connec=
tor)
>   static void create_eml_sink(struct amdgpu_dm_connector *aconnector)
>   {
>        struct drm_connector *connector =3D &aconnector->base;
> -     struct dc_link *dc_link =3D aconnector->dc_link;
>        struct dc_sink_init_data init_params =3D {
>                        .link =3D aconnector->dc_link,
>                        .sink_signal =3D SIGNAL_TYPE_VIRTUAL
>        };
> -     struct edid *edid;
> -     struct i2c_adapter *ddc;
> -
> -     if (dc_link->aux_mode)
> -             ddc =3D &aconnector->dm_dp_aux.aux.ddc;
> -     else
> -             ddc =3D &aconnector->i2c->base;
> +     const struct drm_edid *drm_edid;
> +     const struct edid *edid;
>
>        /*
>         * Note: drm_get_edid gets edid in the following order:
> @@ -7076,17 +7069,19 @@ static void create_eml_sink(struct amdgpu_dm_conn=
ector *aconnector)
>         * 2) firmware EDID if set via edid_firmware module parameter
>         * 3) regular DDC read.
>         */
> -     edid =3D drm_get_edid(connector, ddc);

drm_get_edid() is removed here, and thhe above comments should be
removed as well.

> -     if (!edid) {
> +     drm_edid =3D drm_edid_read(connector);
> +     drm_edid_connector_update(connector, drm_edid);
> +     if (!drm_edid) {
>                DRM_ERROR("No EDID found on connector: %s.\n", connector->=
name);
>                return;
>        }
>
> -     if (drm_detect_hdmi_monitor(edid))
> +     if (connector->display_info.is_hdmi)
>                init_params.sink_signal =3D SIGNAL_TYPE_HDMI_TYPE_A;
>
> -     aconnector->edid =3D edid;
> +     aconnector->drm_edid =3D drm_edid;
>
> +     edid =3D drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw(=
)
>        aconnector->dc_em_sink =3D dc_link_add_remote_sink(
>                aconnector->dc_link,
>                (uint8_t *)edid,
> @@ -7770,16 +7765,16 @@ static void amdgpu_set_panel_orientation(struct d=
rm_connector *connector)
>   }
>
>   static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *con=
nector,
> -                                           struct edid *edid)
> +                                           const struct drm_edid *drm_ed=
id)
>   {
>        struct amdgpu_dm_connector *amdgpu_dm_connector =3D
>                        to_amdgpu_dm_connector(connector);
>
> -     if (edid) {
> +     if (drm_edid) {
>                /* empty probed_modes */
>                INIT_LIST_HEAD(&connector->probed_modes);
>                amdgpu_dm_connector->num_modes =3D
> -                             drm_add_edid_modes(connector, edid);
> +                             drm_edid_connector_add_modes(connector);
>
>                /* sorting the probed modes before calling function
>                 * amdgpu_dm_get_native_mode() since EDID can have
> @@ -7793,10 +7788,10 @@ static void amdgpu_dm_connector_ddc_get_modes(str=
uct drm_connector *connector,
>                amdgpu_dm_get_native_mode(connector);
>
>                /* Freesync capabilities are reset by calling
> -              * drm_add_edid_modes() and need to be
> +              * drm_edid_connector_add_modes() and need to be
>                 * restored here.
>                 */
> -             amdgpu_dm_update_freesync_caps(connector, edid);
> +             amdgpu_dm_update_freesync_caps(connector, drm_edid);
>        } else {
>                amdgpu_dm_connector->num_modes =3D 0;
>        }
> @@ -7892,12 +7887,12 @@ static uint add_fs_modes(struct amdgpu_dm_connect=
or *aconnector)
>   }
>
>   static void amdgpu_dm_connector_add_freesync_modes(struct drm_connector=
 *connector,
> -                                                struct edid *edid)
> +                                                const struct drm_edid *d=
rm_edid)
>   {
>        struct amdgpu_dm_connector *amdgpu_dm_connector =3D
>                to_amdgpu_dm_connector(connector);
>
> -     if (!(amdgpu_freesync_vid_mode && edid))
> +     if (!(amdgpu_freesync_vid_mode && drm_edid))
>                return;
>
>        if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfre=
q > 10)
> @@ -7910,24 +7905,24 @@ static int amdgpu_dm_connector_get_modes(struct d=
rm_connector *connector)
>        struct amdgpu_dm_connector *amdgpu_dm_connector =3D
>                        to_amdgpu_dm_connector(connector);
>        struct drm_encoder *encoder;
> -     struct edid *edid =3D amdgpu_dm_connector->edid;
> +     const struct drm_edid *drm_edid =3D amdgpu_dm_connector->drm_edid;
>        struct dc_link_settings *verified_link_cap =3D
>                        &amdgpu_dm_connector->dc_link->verified_link_cap;
>        const struct dc *dc =3D amdgpu_dm_connector->dc_link->dc;
>
>        encoder =3D amdgpu_dm_connector_to_encoder(connector);
>
> -     if (!drm_edid_is_valid(edid)) {
> +     if (!drm_edid) {
>                amdgpu_dm_connector->num_modes =3D
>                                drm_add_modes_noedid(connector, 640, 480);
>                if (dc->link_srv->dp_get_encoding_format(verified_link_cap=
) =3D=3D DP_128b_132b_ENCODING)
>                        amdgpu_dm_connector->num_modes +=3D
>                                drm_add_modes_noedid(connector, 1920, 1080=
);
>        } else {
> -             amdgpu_dm_connector_ddc_get_modes(connector, edid);
> +             amdgpu_dm_connector_ddc_get_modes(connector, drm_edid);
>                if (encoder)
>                        amdgpu_dm_connector_add_common_modes(encoder, conn=
ector);
> -             amdgpu_dm_connector_add_freesync_modes(connector, edid);
> +             amdgpu_dm_connector_add_freesync_modes(connector, drm_edid)=
;
>        }
>        amdgpu_dm_fbc_init(connector);
>
> @@ -11867,7 +11862,7 @@ static bool parse_edid_cea(struct amdgpu_dm_conne=
ctor *aconnector,
>   }
>
>   static void parse_edid_displayid_vrr(struct drm_connector *connector,
> -             struct edid *edid)
> +                                  const struct edid *edid)
>   {
>        u8 *edid_ext =3D NULL;
>        int i;
> @@ -11910,7 +11905,7 @@ static void parse_edid_displayid_vrr(struct drm_c=
onnector *connector,
>   }
>
>   static int parse_amd_vsdb(struct amdgpu_dm_connector *aconnector,
> -                       struct edid *edid, struct amdgpu_hdmi_vsdb_info *=
vsdb_info)
> +                       const struct edid *edid, struct amdgpu_hdmi_vsdb_=
info *vsdb_info)
>   {
>        u8 *edid_ext =3D NULL;
>        int i;
> @@ -11945,7 +11940,8 @@ static int parse_amd_vsdb(struct amdgpu_dm_connec=
tor *aconnector,
>   }
>
>   static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
> -             struct edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)
> +                            const struct edid *edid,
> +                            struct amdgpu_hdmi_vsdb_info *vsdb_info)
>   {
>        u8 *edid_ext =3D NULL;
>        int i;
> @@ -11987,19 +11983,19 @@ static int parse_hdmi_amd_vsdb(struct amdgpu_dm=
_connector *aconnector,
>    * FreeSync parameters.
>    */
>   void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
> -                                 struct edid *edid)
> +                                 const struct drm_edid *drm_edid)
>   {
>        int i =3D 0;
> -     struct detailed_timing *timing;
> -     struct detailed_non_pixel *data;
> -     struct detailed_data_monitor_range *range;
> +     const struct detailed_timing *timing;
> +     const struct detailed_non_pixel *data;
> +     const struct detailed_data_monitor_range *range;
>        struct amdgpu_dm_connector *amdgpu_dm_connector =3D
>                        to_amdgpu_dm_connector(connector);
>        struct dm_connector_state *dm_con_state =3D NULL;
>        struct dc_sink *sink;
> -
>        struct amdgpu_device *adev =3D drm_to_adev(connector->dev);
>        struct amdgpu_hdmi_vsdb_info vsdb_info =3D {0};
> +     const struct edid *edid;
>        bool freesync_capable =3D false;
>        enum adaptive_sync_type as_type =3D ADAPTIVE_SYNC_TYPE_NONE;
>
> @@ -12012,7 +12008,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_co=
nnector *connector,
>                amdgpu_dm_connector->dc_sink :
>                amdgpu_dm_connector->dc_em_sink;
>
> -     if (!edid || !sink) {
> +     if (!drm_edid || !sink) {
>                dm_con_state =3D to_dm_connector_state(connector->state);
>
>                amdgpu_dm_connector->min_vfreq =3D 0;
> @@ -12029,6 +12025,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_co=
nnector *connector,
>        if (!adev->dm.freesync_module)
>                goto update;
>
> +     edid =3D drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw(=
)
> +
>        /* Some eDP panels only have the refresh rate range info in Displa=
yID */
>        if ((connector->display_info.monitor_range.min_vfreq =3D=3D 0 ||
>             connector->display_info.monitor_range.max_vfreq =3D=3D 0))
> @@ -12105,7 +12103,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_co=
nnector *connector,
>                        amdgpu_dm_connector->as_type =3D ADAPTIVE_SYNC_TYP=
E_EDP;
>                }
>
> -     } else if (edid && sink->sink_signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A=
) {
> +     } else if (drm_edid && sink->sink_signal =3D=3D SIGNAL_TYPE_HDMI_TY=
PE_A) {
>                i =3D parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb=
_info);
>                if (i >=3D 0 && vsdb_info.freesync_supported) {
>                        amdgpu_dm_connector->min_vfreq =3D vsdb_info.min_r=
efresh_rate_hz;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 5fd1b6b44577..2aff4c4b76de 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -658,7 +658,7 @@ struct amdgpu_dm_connector {
>
>        /* we need to mind the EDID between detect
>           and get modes due to analog/digital/tvencoder */
> -     struct edid *edid;
> +     const struct drm_edid *drm_edid;
>
>        /* shared with amdgpu */
>        struct amdgpu_hpd hpd;
> @@ -936,7 +936,7 @@ void dm_restore_drm_connector_state(struct drm_device=
 *dev,
>                                    struct drm_connector *connector);
>
>   void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
> -                                     struct edid *edid);
> +                                 const struct drm_edid *drm_edid);
>
>   void amdgpu_dm_trigger_timing_sync(struct drm_device *dev);
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index b490ae67b6be..be72f14f5429 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -897,7 +897,8 @@ enum dc_edid_status dm_helpers_read_local_edid(
>        struct i2c_adapter *ddc;
>        int retry =3D 3;
>        enum dc_edid_status edid_status;
> -     struct edid *edid;
> +     const struct drm_edid *drm_edid;
> +     const struct edid *edid;
>
>        if (link->aux_mode)
>                ddc =3D &aconnector->dm_dp_aux.aux.ddc;
> @@ -909,25 +910,27 @@ enum dc_edid_status dm_helpers_read_local_edid(
>         */
>        do {
>
> -             edid =3D drm_get_edid(&aconnector->base, ddc);
> +             drm_edid =3D drm_edid_read_ddc(connector, ddc);
> +             drm_edid_connector_update(connector, drm_edid);
>
>                /* DP Compliance Test 4.2.2.6 */
>                if (link->aux_mode && connector->edid_corrupt)
>                        drm_dp_send_real_edid_checksum(&aconnector->dm_dp_=
aux.aux, connector->real_edid_checksum);
>
> -             if (!edid && connector->edid_corrupt) {
> +             if (!drm_edid && connector->edid_corrupt) {
>                        connector->edid_corrupt =3D false;
>                        return EDID_BAD_CHECKSUM;
>                }
>
> -             if (!edid)
> +             if (!drm_edid)
>                        return EDID_NO_RESPONSE;
>
> +             edid =3D drm_edid_raw(drm_edid); // FIXME: Get rid of drm_e=
did_raw()
>                sink->dc_edid.length =3D EDID_LENGTH * (edid->extensions +=
 1);
>                memmove(sink->dc_edid.raw_edid, (uint8_t *)edid, sink->dc_=
edid.length);
>
>                /* We don't need the original edid anymore */
> -             kfree(edid);
> +             drm_edid_free(drm_edid);
>
>                edid_status =3D dm_helpers_parse_edid_caps(
>                                                link,
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 5442da90f508..b0d307e5dd72 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -129,7 +129,7 @@ dm_dp_mst_connector_destroy(struct drm_connector *con=
nector)
>                dc_sink_release(aconnector->dc_sink);
>        }
>
> -     kfree(aconnector->edid);
> +     drm_edid_free(aconnector->drm_edid);
>
>        drm_connector_cleanup(connector);
>        drm_dp_mst_put_port_malloc(aconnector->mst_output_port);
> @@ -182,7 +182,7 @@ amdgpu_dm_mst_connector_early_unregister(struct drm_c=
onnector *connector)
>
>                dc_sink_release(dc_sink);
>                aconnector->dc_sink =3D NULL;
> -             aconnector->edid =3D NULL;
> +             aconnector->drm_edid =3D NULL;
>                aconnector->dsc_aux =3D NULL;
>                port->passthrough_aux =3D NULL;
>        }
> @@ -302,16 +302,16 @@ static int dm_dp_mst_get_modes(struct drm_connector=
 *connector)
>        if (!aconnector)
>                return drm_add_edid_modes(connector, NULL);
>
> -     if (!aconnector->edid) {
> -             struct edid *edid;
> +     if (!aconnector->drm_edid) {
> +             const struct drm_edid *drm_edid;
>
> -             edid =3D drm_dp_mst_get_edid(connector, &aconnector->mst_ro=
ot->mst_mgr, aconnector->mst_output_port);
> +             drm_edid =3D drm_dp_mst_edid_read(connector, &aconnector->m=
st_root->mst_mgr, aconnector->mst_output_port);
>
> -             if (!edid) {
> +             if (!drm_edid) {
>                        amdgpu_dm_set_mst_status(&aconnector->mst_status,
>                        MST_REMOTE_EDID, false);
>
> -                     drm_connector_update_edid_property(
> +                     drm_edid_connector_update(
>                                &aconnector->base,
>                                NULL);
>
> @@ -345,7 +345,7 @@ static int dm_dp_mst_get_modes(struct drm_connector *=
connector)
>                        return ret;
>                }
>
> -             aconnector->edid =3D edid;
> +             aconnector->drm_edid =3D drm_edid;
>                amdgpu_dm_set_mst_status(&aconnector->mst_status,
>                        MST_REMOTE_EDID, true);
>        }
> @@ -360,10 +360,13 @@ static int dm_dp_mst_get_modes(struct drm_connector=
 *connector)
>                struct dc_sink_init_data init_params =3D {
>                                .link =3D aconnector->dc_link,
>                                .sink_signal =3D SIGNAL_TYPE_DISPLAY_PORT_=
MST };
> +             const struct edid *edid;
> +
> +             edid =3D drm_edid_raw(aconnector->drm_edid); // FIXME: Get =
rid of drm_edid_raw()
>                dc_sink =3D dc_link_add_remote_sink(
>                        aconnector->dc_link,
> -                     (uint8_t *)aconnector->edid,
> -                     (aconnector->edid->extensions + 1) * EDID_LENGTH,
> +                     (uint8_t *)edid,
> +                     (edid->extensions + 1) * EDID_LENGTH,
>                        &init_params);
>
>                if (!dc_sink) {
> @@ -405,7 +408,7 @@ static int dm_dp_mst_get_modes(struct drm_connector *=
connector)
>
>                if (aconnector->dc_sink) {
>                        amdgpu_dm_update_freesync_caps(
> -                                     connector, aconnector->edid);
> +                                     connector, aconnector->drm_edid);
>
>   #if defined(CONFIG_DRM_AMD_DC_FP)
>                        if (!validate_dsc_caps_on_connector(aconnector))
> @@ -419,10 +422,9 @@ static int dm_dp_mst_get_modes(struct drm_connector =
*connector)
>                }
>        }
>
> -     drm_connector_update_edid_property(
> -                                     &aconnector->base, aconnector->edid=
);
> +     drm_edid_connector_update(&aconnector->base, aconnector->drm_edid);
>
> -     ret =3D drm_add_edid_modes(connector, aconnector->edid);
> +     ret =3D drm_edid_connector_add_modes(connector);
>
>        return ret;
>   }
> @@ -500,7 +502,7 @@ dm_dp_mst_detect(struct drm_connector *connector,
>
>                dc_sink_release(aconnector->dc_sink);
>                aconnector->dc_sink =3D NULL;
> -             aconnector->edid =3D NULL;
> +             aconnector->drm_edid =3D NULL;
>                aconnector->dsc_aux =3D NULL;
>                port->passthrough_aux =3D NULL;
>


------------------------------

Subject: Digest Footer

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx


------------------------------

End of amd-gfx Digest, Vol 98, Issue 341
****************************************

--_000_PH7PR12MB64209ED7115C483713E4350B81B92PH7PR12MB6420namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Acked-by: Vitaly Prosyak &lt;vitaly.prosyak@amd.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The entire series of patches [0-53 ] for gfx 7, 8, 9, 11 and compute gfx 10=
, 12</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;queue/pipe reset was tested using the new IGT test, amd_queue_reset, =
which has been merged upstream.</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of amd-gfx-request@lists.freedes=
ktop.org &lt;amd-gfx-request@lists.freedesktop.org&gt;<br>
<b>Sent:</b> Thursday, July 25, 2024 12:35 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> amd-gfx Digest, Vol 98, Issue 341</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Send amd-gfx mailing list submissions to<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx@lists.freedesktop.org<br=
>
<br>
To subscribe or unsubscribe via the World Wide Web, visit<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://lists.freedes=
ktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a><br>
or, via email, send a message with subject or body 'help' to<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx-request@lists.freedeskto=
p.org<br>
<br>
You can reach the person managing the list at<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx-owner@lists.freedesktop.=
org<br>
<br>
When replying, please edit your Subject line so it is more specific<br>
than &quot;Re: Contents of amd-gfx digest...&quot;<br>
<br>
<br>
Today's Topics:<br>
<br>
&nbsp;&nbsp; 1. Re: [PATCH V2 00/53] GC per queue reset (Alex Deucher)<br>
&nbsp;&nbsp; 2. Re: [PATCH v4 01/11] drm/amd/display: clean unused variable=
s<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for hdmi freesync parser (Alex Hung)<br>
&nbsp;&nbsp; 3. Re: [PATCH 1/2] drm/sched: Add error code parameter to<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_start (Alex Deucher)<br>
&nbsp;&nbsp; 4. Re: [PATCH v4 02/11] drm/amd/display: switch<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dm_connector to use struct drm_edid (=
Alex Hung)<br>
<br>
<br>
----------------------------------------------------------------------<br>
<br>
Message: 1<br>
Date: Thu, 25 Jul 2024 11:29:14 -0400<br>
From: Alex Deucher &lt;alexdeucher@gmail.com&gt;<br>
To: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Cc: amd-gfx@lists.freedesktop.org<br>
Subject: Re: [PATCH V2 00/53] GC per queue reset<br>
Message-ID:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;CADnq5_NWdzoTVOuCEOFMhC0GF+2=
6=3D2z8nknADXyiLxmAs9fTzQ@mail.gmail.com&gt;<br>
Content-Type: text/plain; charset=3D&quot;UTF-8&quot;<br>
<br>
On Thu, Jul 25, 2024 at 11:20?AM Alex Deucher &lt;alexander.deucher@amd.com=
&gt; wrote:<br>
&gt;<br>
&gt; This adds preliminary support for GC per queue reset.&nbsp; In this<br=
>
&gt; case, only the jobs currently in the queue are lost.&nbsp; If this<br>
&gt; fails, we fall back to a full adapter reset.<br>
&gt;<br>
&gt; V2: Fix fallbacks to full adapter reset<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; RLC safemode cleanup<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Preliminary support for older GPUs<br>
<br>
Forgot to add a git link as well:<br>
<a href=3D"https://gitlab.freedesktop.org/agd5f/linux/-/tree/amd-staging-dr=
m-next-queue-reset?ref_type=3Dheads">https://gitlab.freedesktop.org/agd5f/l=
inux/-/tree/amd-staging-drm-next-queue-reset?ref_type=3Dheads</a><br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; Alex Deucher (38):<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx10: handle SDMA in KIQ map/unmap<br>
&gt;&nbsp;&nbsp; drm/amdgpu/mes11: handle second gfx pipe<br>
&gt;&nbsp;&nbsp; drm/amdgpu/mes: add API for legacy queue reset<br>
&gt;&nbsp;&nbsp; drm/amdgpu/mes11: add API for legacy queue reset<br>
&gt;&nbsp;&nbsp; drm/amdgpu/mes12: add API for legacy queue reset<br>
&gt;&nbsp;&nbsp; drm/amdgpu/mes: add API for user queue reset<br>
&gt;&nbsp;&nbsp; drm/amdgpu/mes11: add API for user queue reset<br>
&gt;&nbsp;&nbsp; drm/amdgpu/mes12: add API for user queue reset<br>
&gt;&nbsp;&nbsp; drm/amdgpu: add new ring reset callback<br>
&gt;&nbsp;&nbsp; drm/amdgpu: add per ring reset support (v5)<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx11: add ring reset callbacks<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx11: rename gfx_v11_0_gfx_init_queue()<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx10: add ring reset callbacks<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx10: rework reset sequence<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx9: add ring reset callback<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx9.4.3: add ring reset callback<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx12: add ring reset callbacks<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx12: fallback to driver reset compute queue d=
irectly<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx11: enter safe mode before touching CP_INT_C=
NTL<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx11: add a mutex for the gfx semaphore<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx11: export gfx_v11_0_request_gfx_index_mutex=
()<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx9: per queue reset only on bare metal<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx10: per queue reset only on bare metal<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx11: per queue reset only on bare metal<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx12: per queue reset only on bare metal<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx9: add ring reset callback for gfx<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx8: add ring reset callback for gfx<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx7: add ring reset callback for gfx<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx9: use proper rlc safe mode helpers<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx9.4.3: use proper rlc safe mode helpers<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx10: use proper rlc safe mode helpers<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx11: use proper rlc safe mode helpers<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx12: use proper rlc safe mode helpers<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx12: use rlc safe mode for soft recovery<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx11: use rlc safe mode for soft recovery<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx10: use rlc safe mode for soft recovery<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx9.4.3: use rlc safe mode for soft recovery<b=
r>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx9: use rlc safe mode for soft recovery<br>
&gt;<br>
&gt; Jiadong Zhu (13):<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx11: wait for reset done before remap<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx10: remap queue after reset successfully<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx10: wait for reset done before remap<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx9: remap queue after reset successfully<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx9: wait for reset done before remap<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx9.4.3: remap queue after reset successfully<=
br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx_9.4.3: wait for reset done before remap<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx: add a new kiq_pm4_funcs callback for reset=
_hw_queue<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx9: implement reset_hw_queue for gfx9<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx9.4.3: implement reset_hw_queue for gfx9.4.3=
<br>
&gt;&nbsp;&nbsp; drm/amdgpu/mes: modify mes api for mmio queue reset<br>
&gt;&nbsp;&nbsp; drm/amdgpu/mes: implement amdgpu_mes_reset_hw_queue_mmio<b=
r>
&gt;&nbsp;&nbsp; drm/amdgpu/mes11: implement mmio queue reset for gfx11<br>
&gt;<br>
&gt; Prike Liang (2):<br>
&gt;&nbsp;&nbsp; drm/amdgpu: increase the reset counter for the queue reset=
<br>
&gt;&nbsp;&nbsp; drm/amdgpu/gfx11: fallback to driver reset compute queue d=
irectly (v2)<br>
&gt;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |&nbsp;&nbsp; 1 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h&nbsp;&nbsp;&nbsp; |&nbsp=
;&nbsp; 6 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_job.c&nbsp;&nbsp;&nbsp; |&nbsp=
; 20 ++<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c&nbsp;&nbsp;&nbsp; |&nbsp=
; 88 ++++++++<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h&nbsp;&nbsp;&nbsp; |&nbsp=
; 37 +++<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h&nbsp;&nbsp; |&nbsp;&nbs=
p; 2 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/cikd.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp; |=
 251 +++++++++++++++++++--<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp; |=
 127 +++++++++--<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v11_0.h&nbsp;&nbsp;&nbsp;&nbsp; |=
&nbsp;&nbsp; 3 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c&nbsp;&nbsp;&nbsp;&nbsp; |=
 103 ++++++++-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; |&nbsp; 76 ++++++-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; |&nbsp; 75 +++++-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; | 179 ++++++++++++++-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c&nbsp;&nbsp;&nbsp; | 132 =
++++++++++-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/mes_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp; |=
 134 +++++++++++<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/mes_v12_0.c&nbsp;&nbsp;&nbsp;&nbsp; |=
&nbsp; 54 +++++<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/nvd.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/vid.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +<br>
&gt;&nbsp; 19 files changed, 1243 insertions(+), 49 deletions(-)<br>
&gt;<br>
&gt; --<br>
&gt; 2.45.2<br>
&gt;<br>
<br>
<br>
------------------------------<br>
<br>
Message: 2<br>
Date: Thu, 25 Jul 2024 10:23:36 -0600<br>
From: Alex Hung &lt;alex.hung@amd.com&gt;<br>
To: Melissa Wen &lt;mwen@igalia.com&gt;, harry.wentland@amd.com,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sunpeng.li@amd.com, Rodrigo.Siqu=
eira@amd.com,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alexander.deucher@amd.com, chris=
tian.koenig@amd.com,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Xinhui.Pan@amd.com, airlied@gmai=
l.com, daniel@ffwll.ch<br>
Cc: Mario Limonciello &lt;mario.limonciello@amd.com&gt;, Jani Nikula<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;jani.nikula@linux.intel.com&=
gt;, amd-gfx@lists.freedesktop.org,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dri-devel@lists.freedesktop.org,=
 kernel-dev@igalia.com<br>
Subject: Re: [PATCH v4 01/11] drm/amd/display: clean unused variables<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for hdmi freesync parser<br>
Message-ID: &lt;b0017268-5651-4031-901e-45e64319d537@amd.com&gt;<br>
Content-Type: text/plain; charset=3DUTF-8; format=3Dflowed<br>
<br>
Hi Melissa,<br>
<br>
There are no commit messages in this patch.<br>
<br>
Also, do you think this can be merged with Patch 5 &quot;drm/amd/display: <=
br>
remove redundant freesync parser for&nbsp; DP&quot;?<br>
<br>
On 2024-07-05 21:35, Melissa Wen wrote:<br>
&gt; Signed-off-by: Melissa Wen &lt;mwen@igalia.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ---<=
br>
&gt;&nbsp;&nbsp; 1 file changed, 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index 98cf523a629e..1dfa7ec9af35 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -12108,9 +12108,6 @@ void amdgpu_dm_update_freesync_caps(struct drm=
_connector *connector,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (edid &amp;&amp; s=
ink-&gt;sink_signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; i =3D parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &a=
mp;vsdb_info);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (i &gt;=3D 0 &amp;&amp; vsdb_info.freesync_supported=
) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timing&nbsp; =3D &amp;e=
did-&gt;detailed_timings[i];<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data&nbsp;&nbsp;&nbsp; =
=3D &amp;timing-&gt;data.other_data;<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
dm_connector-&gt;min_vfreq =3D vsdb_info.min_refresh_rate_hz;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
dm_connector-&gt;max_vfreq =3D vsdb_info.max_refresh_rate_hz;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amd=
gpu_dm_connector-&gt;max_vfreq - amdgpu_dm_connector-&gt;min_vfreq &gt; 10)=
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 3<br>
Date: Thu, 25 Jul 2024 12:30:07 -0400<br>
From: Alex Deucher &lt;alexdeucher@gmail.com&gt;<br>
To: vitaly.prosyak@amd.com<br>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alexander.deucher@amd.com, chris=
tian.koenig@amd.com,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; jesse.zhang@amd.com<br>
Subject: Re: [PATCH 1/2] drm/sched: Add error code parameter to<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_start<br>
Message-ID:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;CADnq5_NPmHX_1j9xifr-wk3VjB5=
j5_inmrrP8JknQ-49A2UqwA@mail.gmail.com&gt;<br>
Content-Type: text/plain; charset=3D&quot;UTF-8&quot;<br>
<br>
On Wed, Jul 24, 2024 at 11:30?PM &lt;vitaly.prosyak@amd.com&gt; wrote:<br>
&gt;<br>
&gt; From: Vitaly Prosyak &lt;vitaly.prosyak@amd.com&gt;<br>
&gt;<br>
&gt; The current implementation of drm_sched_start uses a hardcoded -ECANCE=
LED to dispose of a job when<br>
&gt; the parent/hw fence is NULL. This results in drm_sched_job_done being =
called with -ECANCELED for<br>
&gt; each job with a NULL parent in the pending list, making it difficult t=
o distinguish between recovery<br>
&gt; methods, whether a queue reset or a full GPU reset was used.<br>
&gt;<br>
&gt; To improve this, we first try a soft recovery for timeout jobs and use=
 the error code -ENODATA.<br>
&gt; If soft recovery fails, we proceed with a queue reset, where the error=
 code remains -ENODATA for<br>
&gt; the job. Finally, for a full GPU reset, we use error codes -ECANCELED =
or -ETIME. This patch adds<br>
&gt; an error code parameter to drm_sched_start, allowing us to differentia=
te between queue reset and<br>
&gt; GPU reset failures. This enables user mode and test applications to va=
lidate the expected<br>
&gt; correctness of the requested operation. After a successful queue reset=
, the only way to continue<br>
&gt; normal operation is to call drm_sched_job_done with the specific error=
 code -ENODATA.<br>
&gt;<br>
&gt; v1: Initial implementation by Jesse utilized amdgpu_device_lock_reset_=
domain and<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_unlock_reset_domain to allow use=
r mode to track the queue reset status and distinguish<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; between queue reset and GPU reset.<br>
&gt; v2: Christian suggested using the error codes -ENODATA for queue reset=
 and -ECANCELED or -ETIME for GPU<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; reset, returned to amdgpu_cs_wait_ioctl.<br>
&gt; v3: To meet the requirements, we introduce a new function drm_sched_st=
art_ex with an additional parameter<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; to set dma_fence_set_error, allowing us to han=
dle the specific error codes appropriately and dispose<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; of bad jobs with the selected error code depen=
ding on whether it was a queue reset or GPU reset.<br>
&gt; v4: Alex suggested using a new name, drm_sched_start_with_recovery_err=
or, which more accurately describes<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; the function's purpose. Additionally, it was r=
ecommended to add documentation details about the new method.<br>
&gt;<br>
&gt; Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; Cc: Christian Koenig &lt;christian.koenig@amd.com&gt;<br>
&gt; Signed-off-by: Jesse Zhang &lt;Jesse.Zhang@amd.com&gt;<br>
&gt; Signed-off-by: Vitaly Prosyak &lt;vitaly.prosyak@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/scheduler/sched_main.c | 30 ++++++++++++++++++++=
+++---<br>
&gt;&nbsp; include/drm/gpu_scheduler.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +<br>
&gt;&nbsp; 2 files changed, 28 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/=
scheduler/sched_main.c<br>
&gt; index 7e90c9f95611..c42449358b3f 100644<br>
&gt; --- a/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt; +++ b/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt; @@ -671,13 +671,24 @@ void drm_sched_stop(struct drm_gpu_scheduler *sc=
hed, struct drm_sched_job *bad)<br>
&gt;&nbsp; EXPORT_SYMBOL(drm_sched_stop);<br>
&gt;<br>
&gt;&nbsp; /**<br>
&gt; - * drm_sched_start - recover jobs after a reset<br>
&gt; + * drm_sched_start_with_recovery_error - recover jobs after a reset w=
ith<br>
&gt; + * custom error<br>
&gt;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp; * @sched: scheduler instance<br>
&gt;&nbsp;&nbsp; * @full_recovery: proceed with complete sched restart<br>
&gt; + * @error : err code for set dma_fence_set_error<br>
&gt; + *<br>
&gt; + * Starts the scheduler and allows setting a custom dma_fence_set_err=
or,<br>
&gt; + * which can be used to identify the recovery mechanism actually used=
.<br>
&gt;&nbsp;&nbsp; *<br>
&gt; + * For example:<br>
&gt; + * - If a soft or queue reset was used, dma_fence_set_error is set to=
 -ENODATA.<br>
&gt; + * - If an entire GPU reset was used, the error code is set to -ECANC=
ELED.<br>
&gt; + *<br>
&gt; + * This approach enables user mode and test applications to know whic=
h<br>
&gt; + * recovery method was used for a given bad job.<br>
&gt;&nbsp;&nbsp; */<br>
&gt; -void drm_sched_start(struct drm_gpu_scheduler *sched, bool full_recov=
ery)<br>
&gt; +void drm_sched_start_with_recovery_error(struct drm_gpu_scheduler *sc=
hed, bool full_recovery, int error)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *=
s_job, *tmp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt; @@ -704,7 +715,7 @@ void drm_sched_start(struct drm_gpu_scheduler *sch=
ed, bool full_recovery)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEV_ERROR(sched-&gt;dev,=
 &quot;fence add callback failed (%d)\n&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_j=
ob_done(s_job, -ECANCELED);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_j=
ob_done(s_job, error);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (full_recovery)<br>
&gt; @@ -712,6 +723,19 @@ void drm_sched_start(struct drm_gpu_scheduler *sc=
hed, bool full_recovery)<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_wqueue_start=
(sched);<br>
&gt;&nbsp; }<br>
&gt; +EXPORT_SYMBOL(drm_sched_start_with_recovery_error);<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * drm_sched_start - recover jobs after a reset<br>
&gt; + *<br>
&gt; + * @sched: scheduler instance<br>
&gt; + * @full_recovery: proceed with complete sched restart<br>
&gt; + *<br>
&gt; + */<br>
&gt; +void drm_sched_start(struct drm_gpu_scheduler *sched, bool full_recov=
ery)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_start_with_recovery_er=
ror(sched, full_recovery, -ECANCELED);<br>
&gt; +}<br>
&gt;&nbsp; EXPORT_SYMBOL(drm_sched_start);<br>
&gt;<br>
&gt;&nbsp; /**<br>
&gt; diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h=
<br>
&gt; index 5acc64954a88..444fa6761590 100644<br>
&gt; --- a/include/drm/gpu_scheduler.h<br>
&gt; +++ b/include/drm/gpu_scheduler.h<br>
&gt; @@ -580,6 +580,7 @@ void drm_sched_wqueue_stop(struct drm_gpu_schedule=
r *sched);<br>
&gt;&nbsp; void drm_sched_wqueue_start(struct drm_gpu_scheduler *sched);<br=
>
&gt;&nbsp; void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_=
sched_job *bad);<br>
&gt;&nbsp; void drm_sched_start(struct drm_gpu_scheduler *sched, bool full_=
recovery);<br>
&gt; +void drm_sched_start_ex(struct drm_gpu_scheduler *sched, bool full_re=
covery, int error);<br>
<br>
drm_sched_start_with_recovery_error()<br>
<br>
Alex<br>
<br>
&gt;&nbsp; void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched);<b=
r>
&gt;&nbsp; void drm_sched_increase_karma(struct drm_sched_job *bad);<br>
&gt;&nbsp; void drm_sched_reset_karma(struct drm_sched_job *bad);<br>
&gt; --<br>
&gt; 2.25.1<br>
&gt;<br>
<br>
<br>
------------------------------<br>
<br>
Message: 4<br>
Date: Thu, 25 Jul 2024 10:35:07 -0600<br>
From: Alex Hung &lt;alex.hung@amd.com&gt;<br>
To: Melissa Wen &lt;mwen@igalia.com&gt;, harry.wentland@amd.com,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sunpeng.li@amd.com, Rodrigo.Siqu=
eira@amd.com,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alexander.deucher@amd.com, chris=
tian.koenig@amd.com,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Xinhui.Pan@amd.com, airlied@gmai=
l.com, daniel@ffwll.ch<br>
Cc: Mario Limonciello &lt;mario.limonciello@amd.com&gt;, Jani Nikula<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;jani.nikula@linux.intel.com&=
gt;, amd-gfx@lists.freedesktop.org,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dri-devel@lists.freedesktop.org,=
 kernel-dev@igalia.com<br>
Subject: Re: [PATCH v4 02/11] drm/amd/display: switch<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dm_connector to use struc=
t drm_edid<br>
Message-ID: &lt;d1cce2ee-f12b-4d37-8729-5ff22cb64550@amd.com&gt;<br>
Content-Type: text/plain; charset=3DUTF-8; format=3Dflowed<br>
<br>
Please see inline comments.<br>
<br>
On 2024-07-05 21:35, Melissa Wen wrote:<br>
&gt; Replace raw edid handling (struct edid) with the opaque EDID type<br>
&gt; (struct drm_edid) on amdgpu_dm_connector for consistency. It may also<=
br>
&gt; prevent mismatch of approaches in different parts of the driver code.<=
br>
&gt; Working in progress. It was only exercised with IGT tests.<br>
&gt; <br>
&gt; v2: use const to fix warnings (Alex Hung)<br>
&gt; v3: fix general protection fault on mst<br>
&gt; v4: rename edid to drm_edid in amdgpu_connector (Jani)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; call drm_edid_connector_update to clear =
edid in case of NULL (Jani)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; keep setting NULL instead of free drm_ed=
id (Jani)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; check drm_edid not NULL, instead of vali=
d (Jani)<br>
&gt; <br>
&gt; Signed-off-by: Melissa Wen &lt;mwen@igalia.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 106 ++++++=
+++---------<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |&nbsp;&nbsp=
; 4 +-<br>
&gt;&nbsp;&nbsp; .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |&nbsp; 13 +=
+-<br>
&gt;&nbsp;&nbsp; .../display/amdgpu_dm/amdgpu_dm_mst_types.c&nbsp;&nbsp; |&=
nbsp; 32 +++---<br>
&gt;&nbsp;&nbsp; 4 files changed, 79 insertions(+), 76 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index 1dfa7ec9af35..49b8c5b00728 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -3408,7 +3408,7 @@ void amdgpu_dm_update_connector_after_detect(<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aconnec=
tor-&gt;dc_sink =3D sink;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_sink=
_retain(aconnector-&gt;dc_sink);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
dm_update_freesync_caps(connector,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ac=
onnector-&gt;edid);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ac=
onnector-&gt;drm_edid);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
dm_update_freesync_caps(connector, NULL);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ac=
onnector-&gt;dc_sink) {<br>
&gt; @@ -3467,18 +3467,20 @@ void amdgpu_dm_update_connector_after_detect(<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aconnector-&gt;dc_sink =3D sink;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dc_sink_retain(aconnector-&gt;dc_sink);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (sink-&gt;dc_edid.length =3D=3D 0) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aconnector-&gt;edid =3D=
 NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aconnector-&gt;drm_edid=
 =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (aco=
nnector-&gt;dc_link-&gt;aux_mode) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_dp_cec_unset_edid(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; &amp;aconnector-&gt;dm_dp_aux.aux);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aconnector-&gt;edid =3D=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; (struct edid *)sink-&gt;dc_edid.raw_edid;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct edid *edid=
 =3D (const struct edid *)sink-&gt;dc_edid.raw_edid;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aconnector-&gt;drm_edid=
 =3D drm_edid_alloc(edid, sink-&gt;dc_edid.length);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_edid_connector_upda=
te(connector, aconnector-&gt;drm_edid);<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* FIXME: Get rid of dr=
m_edid_raw() */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (aco=
nnector-&gt;dc_link-&gt;aux_mode)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_dp_cec_set_edid(&amp;aconnecto=
r-&gt;dm_dp_aux.aux,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aconn=
ector-&gt;edid);<br>
Why not pass edid but drm_edid_raw(aconnector-&gt;drm_edid)?<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_e=
did_raw(aconnector-&gt;drm_edid));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!aconnector-&gt;timing_requested) {<br>
&gt; @@ -3489,17 +3491,18 @@ void amdgpu_dm_update_connector_after_detect(<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; &quot;failed to create aconnector-&gt;requested_timing\n&quot=
;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; drm_connector_update_edid_property(connector, aconnector-&gt;edid);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_dm_update_freesync_caps(connector, aconnector-&gt;edid);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; drm_edid_connector_update(connector, aconnector-&gt;drm_edid);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_dm_update_freesync_caps(connector, aconnector-&gt;drm_edid);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; update_connector_ext_caps(aconnector);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; drm_dp_cec_unset_edid(&amp;aconnector-&gt;dm_dp_aux.aux=
);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_dm_update_freesync_caps(connector, NULL);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; drm_connector_update_edid_property(connector, NULL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; drm_edid_connector_update(connector, NULL);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aconnector-&gt;num_modes =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dc_sink_release(aconnector-&gt;dc_sink);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aconnector-&gt;dc_sink =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; aconnector-&gt;edid =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; drm_edid_free(aconnector-&gt;drm_edid);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; aconnector-&gt;drm_edid =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; kfree(aconnector-&gt;timing_requested);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aconnector-&gt;timing_requested =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* Set CP to DESIRED if it was ENABLED, so we can re-en=
able it again on hotplug */<br>
&gt; @@ -7002,13 +7005,7 @@ static void amdgpu_dm_connector_funcs_force(str=
uct drm_connector *connector)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_dm_connector *=
aconnector =3D to_amdgpu_dm_connector(connector);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_link *dc_link =3D =
aconnector-&gt;dc_link;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_sink *dc_em_sink =
=3D aconnector-&gt;dc_em_sink;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct edid *edid;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_adapter *ddc;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (dc_link &amp;&amp; dc_link-&gt;aux_mode)=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ddc =3D &amp;aconnector-&gt;dm_dp_aux.aux.ddc;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ddc =3D &amp;aconnector-&gt;i2c-&gt;base;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const struct drm_edid *drm_edid;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Note: drm_get_edid g=
ets edid in the following order:<br>
&gt; @@ -7016,18 +7013,20 @@ static void amdgpu_dm_connector_funcs_force(st=
ruct drm_connector *connector)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 2) firmware EDID if =
set via edid_firmware module parameter<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 3) regular DDC read.=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; edid =3D drm_get_edid(connector, ddc);<br>
drm_get_edid() is removed here, and thhe above comments should be <br>
removed as well.<br>
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!edid) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; drm_edid =3D drm_edid_read(connector);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; drm_edid_connector_update(connector, drm_edi=
d);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!drm_edid) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;No EDID found on connector: %s.\n&quot;=
, connector-&gt;name);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; aconnector-&gt;edid =3D edid;<br>
&gt; -<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; aconnector-&gt;drm_edid =3D drm_edid;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Update emulated (virtual)=
 sink's EDID */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc_em_sink &amp;&amp; dc=
_link) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; const struct edid *edid =3D drm_edid_raw(drm_edid); // FIXME: Get rid o=
f drm_edid_raw()<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; memset(&amp;dc_em_sink-&gt;edid_caps, 0, sizeof(struct =
dc_edid_caps));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; memmove(dc_em_sink-&gt;dc_edid.raw_edid, edid, (edid-&gt;extensions + 1=
) * EDID_LENGTH);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; memmove(dc_em_sink-&gt;dc_edid.raw_edid, (uint8_t *)edid, (edid-&gt;ext=
ensions + 1) * EDID_LENGTH);<br>
<br>
is casting to (uint8 *) necessary?<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dm_helpers_parse_edid_caps(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_link=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dc=
_em_sink-&gt;dc_edid,<br>
&gt; @@ -7057,18 +7056,12 @@ static int get_modes(struct drm_connector *con=
nector)<br>
&gt;&nbsp;&nbsp; static void create_eml_sink(struct amdgpu_dm_connector *ac=
onnector)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_connector *connec=
tor =3D &amp;aconnector-&gt;base;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct dc_link *dc_link =3D aconnector-&gt;d=
c_link;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_sink_init_data ini=
t_params =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .link =
=3D aconnector-&gt;dc_link,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .sink_s=
ignal =3D SIGNAL_TYPE_VIRTUAL<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct edid *edid;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_adapter *ddc;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (dc_link-&gt;aux_mode)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ddc =3D &amp;aconnector-&gt;dm_dp_aux.aux.ddc;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ddc =3D &amp;aconnector-&gt;i2c-&gt;base;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const struct drm_edid *drm_edid;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const struct edid *edid;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Note: drm_get_edid g=
ets edid in the following order:<br>
&gt; @@ -7076,17 +7069,19 @@ static void create_eml_sink(struct amdgpu_dm_c=
onnector *aconnector)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 2) firmware EDID if =
set via edid_firmware module parameter<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 3) regular DDC read.=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; edid =3D drm_get_edid(connector, ddc);<br>
<br>
drm_get_edid() is removed here, and thhe above comments should be <br>
removed as well.<br>
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!edid) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; drm_edid =3D drm_edid_read(connector);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; drm_edid_connector_update(connector, drm_edi=
d);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!drm_edid) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;No EDID found on connector: %s.\n&quot;=
, connector-&gt;name);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (drm_detect_hdmi_monitor(edid))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (connector-&gt;display_info.is_hdmi)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; init_params.sink_signal =3D SIGNAL_TYPE_HDMI_TYPE_A;<br=
>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; aconnector-&gt;edid =3D edid;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; aconnector-&gt;drm_edid =3D drm_edid;<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; edid =3D drm_edid_raw(drm_edid); // FIXME: G=
et rid of drm_edid_raw()<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aconnector-&gt;dc_em_sink =
=3D dc_link_add_remote_sink(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aconnector-&gt;dc_link,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (uint8_t *)edid,<br>
&gt; @@ -7770,16 +7765,16 @@ static void amdgpu_set_panel_orientation(struc=
t drm_connector *connector)<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void amdgpu_dm_connector_ddc_get_modes(struct drm_c=
onnector *connector,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct edid *edid)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct drm_edid *drm_edid)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_dm_connector *=
amdgpu_dm_connector =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to_amdg=
pu_dm_connector(connector);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (edid) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (drm_edid) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* empty probed_modes */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;connector-&gt;probed_modes);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_dm_connector-&gt;num_modes =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; drm_add_edid_modes(connector, edid);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; drm_edid_connector_add_modes(connector);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* sorting the probed modes before calling function<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * amdgpu_dm_get_native_mode() since EDID can have=
<br>
&gt; @@ -7793,10 +7788,10 @@ static void amdgpu_dm_connector_ddc_get_modes(=
struct drm_connector *connector,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_dm_get_native_mode(connector);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* Freesync capabilities are reset by calling<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * drm_add_edid_modes() and need to be<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * drm_edid_connector_add_modes() and need to be<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * restored here.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_dm_update_freesync_caps(connector, edid);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_dm_update_freesync_caps(connector, drm_edid);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_dm_connector-&gt;num_modes =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -7892,12 +7887,12 @@ static uint add_fs_modes(struct amdgpu_dm_conn=
ector *aconnector)<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void amdgpu_dm_connector_add_freesync_modes(struct =
drm_connector *connector,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct edid=
 *edid)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struc=
t drm_edid *drm_edid)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_dm_connector *=
amdgpu_dm_connector =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; to_amdgpu_dm_connector(connector);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!(amdgpu_freesync_vid_mode &amp;&amp; ed=
id))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!(amdgpu_freesync_vid_mode &amp;&amp; dr=
m_edid))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_dm_connector-&gt;=
max_vfreq - amdgpu_dm_connector-&gt;min_vfreq &gt; 10)<br>
&gt; @@ -7910,24 +7905,24 @@ static int amdgpu_dm_connector_get_modes(struc=
t drm_connector *connector)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_dm_connector *=
amdgpu_dm_connector =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to_amdg=
pu_dm_connector(connector);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_encoder *encoder;=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct edid *edid =3D amdgpu_dm_connector-&g=
t;edid;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const struct drm_edid *drm_edid =3D amdgpu_d=
m_connector-&gt;drm_edid;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_link_settings *ver=
ified_link_cap =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;am=
dgpu_dm_connector-&gt;dc_link-&gt;verified_link_cap;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dc *dc =3D amdg=
pu_dm_connector-&gt;dc_link-&gt;dc;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; encoder =3D amdgpu_dm_connec=
tor_to_encoder(connector);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!drm_edid_is_valid(edid)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!drm_edid) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_dm_connector-&gt;num_modes =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_add_modes_noedid(connector, 64=
0, 480);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (dc-&gt;link_srv-&gt;dp_get_encoding_format(verified=
_link_cap) =3D=3D DP_128b_132b_ENCODING)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
dm_connector-&gt;num_modes +=3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_add_modes_noedid(connector, 19=
20, 1080);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_dm_connector_ddc_get_modes(connector, edid);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_dm_connector_ddc_get_modes(connector, drm_edid);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (encoder)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
dm_connector_add_common_modes(encoder, connector);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_dm_connector_add_freesync_modes(connector, edid);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_dm_connector_add_freesync_modes(connector, drm_edid);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dm_fbc_init(connector=
);<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -11867,7 +11862,7 @@ static bool parse_edid_cea(struct amdgpu_dm_co=
nnector *aconnector,<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void parse_edid_displayid_vrr(struct drm_connector =
*connector,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; struct edid *edid)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct edid *e=
did)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 *edid_ext =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; @@ -11910,7 +11905,7 @@ static void parse_edid_displayid_vrr(struct dr=
m_connector *connector,<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static int parse_amd_vsdb(struct amdgpu_dm_connector *acon=
nector,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct edid=
 *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struc=
t edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 *edid_ext =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; @@ -11945,7 +11940,8 @@ static int parse_amd_vsdb(struct amdgpu_dm_con=
nector *aconnector,<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector =
*aconnector,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; struct edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; const struct edid *edid,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; struct amdgpu_hdmi_vsdb_info *vsdb_info)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 *edid_ext =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; @@ -11987,19 +11983,19 @@ static int parse_hdmi_amd_vsdb(struct amdgpu=
_dm_connector *aconnector,<br>
&gt;&nbsp;&nbsp;&nbsp; * FreeSync parameters.<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; void amdgpu_dm_update_freesync_caps(struct drm_connector *=
connector,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct edid *edid)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct drm_edid *drm=
_edid)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct detailed_timing *timing;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct detailed_non_pixel *data;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct detailed_data_monitor_range *range;<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const struct detailed_timing *timing;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const struct detailed_non_pixel *data;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const struct detailed_data_monitor_range *ra=
nge;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_dm_connector *=
amdgpu_dm_connector =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to_amdg=
pu_dm_connector(connector);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dm_connector_state *d=
m_con_state =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_sink *sink;<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D drm_to_adev(connector-&gt;dev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_hdmi_vsdb_info=
 vsdb_info =3D {0};<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const struct edid *edid;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool freesync_capable =3D fa=
lse;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum adaptive_sync_type as_t=
ype =3D ADAPTIVE_SYNC_TYPE_NONE;<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -12012,7 +12008,7 @@ void amdgpu_dm_update_freesync_caps(struct drm=
_connector *connector,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_dm_connector-&gt;dc_sink :<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_dm_connector-&gt;dc_em_sink;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!edid || !sink) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!drm_edid || !sink) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dm_con_state =3D to_dm_connector_state(connector-&gt;st=
ate);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_dm_connector-&gt;min_vfreq =3D 0;<br>
&gt; @@ -12029,6 +12025,8 @@ void amdgpu_dm_update_freesync_caps(struct drm=
_connector *connector,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;dm.freesync_mo=
dule)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto update;<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; edid =3D drm_edid_raw(drm_edid); // FIXME: G=
et rid of drm_edid_raw()<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Some eDP panels only have=
 the refresh rate range info in DisplayID */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((connector-&gt;display_i=
nfo.monitor_range.min_vfreq =3D=3D 0 ||<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; connector-&gt;display_info.monitor_range.max_vfreq =3D=3D 0))<br>
&gt; @@ -12105,7 +12103,7 @@ void amdgpu_dm_update_freesync_caps(struct drm=
_connector *connector,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
dm_connector-&gt;as_type =3D ADAPTIVE_SYNC_TYPE_EDP;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else if (edid &amp;&amp; sink-&gt;sink_sig=
nal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else if (drm_edid &amp;&amp; sink-&gt;sink=
_signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; i =3D parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &a=
mp;vsdb_info);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (i &gt;=3D 0 &amp;&amp; vsdb_info.freesync_supported=
) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
dm_connector-&gt;min_vfreq =3D vsdb_info.min_refresh_rate_hz;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
&gt; index 5fd1b6b44577..2aff4c4b76de 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
&gt; @@ -658,7 +658,7 @@ struct amdgpu_dm_connector {<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* we need to mind the EDID =
between detect<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; and get mo=
des due to analog/digital/tvencoder */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct edid *edid;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const struct drm_edid *drm_edid;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* shared with amdgpu */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_hpd hpd;<br>
&gt; @@ -936,7 +936,7 @@ void dm_restore_drm_connector_state(struct drm_dev=
ice *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm=
_connector *connector);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; void amdgpu_dm_update_freesync_caps(struct drm_connector *=
connector,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; st=
ruct edid *edid);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct drm_edid *drm=
_edid);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; void amdgpu_dm_trigger_timing_sync(struct drm_device *dev)=
;<br>
&gt;&nbsp;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c=
 b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c<br>
&gt; index b490ae67b6be..be72f14f5429 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c<br>
&gt; @@ -897,7 +897,8 @@ enum dc_edid_status dm_helpers_read_local_edid(<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_adapter *ddc;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retry =3D 3;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum dc_edid_status edid_sta=
tus;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct edid *edid;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const struct drm_edid *drm_edid;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const struct edid *edid;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (link-&gt;aux_mode)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ddc =3D &amp;aconnector-&gt;dm_dp_aux.aux.ddc;<br>
&gt; @@ -909,25 +910,27 @@ enum dc_edid_status dm_helpers_read_local_edid(<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; edid =3D drm_get_edid(&amp;aconnector-&gt;base, ddc);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; drm_edid =3D drm_edid_read_ddc(connector, ddc);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; drm_edid_connector_update(connector, drm_edid);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* DP Compliance Test 4.2.2.6 */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (link-&gt;aux_mode &amp;&amp; connector-&gt;edid_cor=
rupt)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_dp_=
send_real_edid_checksum(&amp;aconnector-&gt;dm_dp_aux.aux, connector-&gt;re=
al_edid_checksum);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!edid &amp;&amp; connector-&gt;edid_corrupt) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!drm_edid &amp;&amp; connector-&gt;edid_corrupt) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; connect=
or-&gt;edid_corrupt =3D false;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
EDID_BAD_CHECKSUM;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!edid)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!drm_edid)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
EDID_NO_RESPONSE;<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; edid =3D drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw()<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; sink-&gt;dc_edid.length =3D EDID_LENGTH * (edid-&gt;ext=
ensions + 1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; memmove(sink-&gt;dc_edid.raw_edid, (uint8_t *)edid, sin=
k-&gt;dc_edid.length);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* We don't need the original edid anymore */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfree(edid);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; drm_edid_free(drm_edid);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; edid_status =3D dm_helpers_parse_edid_caps(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; link,<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types=
.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c<br>
&gt; index 5442da90f508..b0d307e5dd72 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c<br>
&gt; @@ -129,7 +129,7 @@ dm_dp_mst_connector_destroy(struct drm_connector *=
connector)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dc_sink_release(aconnector-&gt;dc_sink);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; kfree(aconnector-&gt;edid);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; drm_edid_free(aconnector-&gt;drm_edid);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_connector_cleanup(connec=
tor);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_dp_mst_put_port_malloc(a=
connector-&gt;mst_output_port);<br>
&gt; @@ -182,7 +182,7 @@ amdgpu_dm_mst_connector_early_unregister(struct dr=
m_connector *connector)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dc_sink_release(dc_sink);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aconnector-&gt;dc_sink =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; aconnector-&gt;edid =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; aconnector-&gt;drm_edid =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aconnector-&gt;dsc_aux =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; port-&gt;passthrough_aux =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -302,16 +302,16 @@ static int dm_dp_mst_get_modes(struct drm_connec=
tor *connector)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!aconnector)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return drm_add_edid_modes(connector, NULL);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!aconnector-&gt;edid) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; struct edid *edid;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!aconnector-&gt;drm_edid) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; const struct drm_edid *drm_edid;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; edid =3D drm_dp_mst_get_edid(connector, &amp;aconnector-&gt;mst_root-&g=
t;mst_mgr, aconnector-&gt;mst_output_port);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; drm_edid =3D drm_dp_mst_edid_read(connector, &amp;aconnector-&gt;mst_ro=
ot-&gt;mst_mgr, aconnector-&gt;mst_output_port);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!edid) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!drm_edid) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
dm_set_mst_status(&amp;aconnector-&gt;mst_status,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MST_REM=
OTE_EDID, false);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_connector_update_ed=
id_property(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_edid_connector_upda=
te(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;aconnector-&gt;base,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL);<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -345,7 +345,7 @@ static int dm_dp_mst_get_modes(struct drm_connecto=
r *connector)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; aconnector-&gt;edid =3D edid;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; aconnector-&gt;drm_edid =3D drm_edid;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_dm_set_mst_status(&amp;aconnector-&gt;mst_status=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MST_REM=
OTE_EDID, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -360,10 +360,13 @@ static int dm_dp_mst_get_modes(struct drm_connec=
tor *connector)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct dc_sink_init_data init_params =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .link =3D aconnector-&gt;dc_link,<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .sink_signal =3D SIGNAL_TYPE_DISPL=
AY_PORT_MST };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; const struct edid *edid;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; edid =3D drm_edid_raw(aconnector-&gt;drm_edid); // FIXME: Get rid of dr=
m_edid_raw()<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dc_sink =3D dc_link_add_remote_sink(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aconnec=
tor-&gt;dc_link,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint8_t *)aconnector-&=
gt;edid,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (aconnector-&gt;edid-&g=
t;extensions + 1) * EDID_LENGTH,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint8_t *)edid,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (edid-&gt;extensions + =
1) * EDID_LENGTH,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;in=
it_params);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!dc_sink) {<br>
&gt; @@ -405,7 +408,7 @@ static int dm_dp_mst_get_modes(struct drm_connecto=
r *connector)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (aconnector-&gt;dc_sink) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
dm_update_freesync_caps(<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; co=
nnector, aconnector-&gt;edid);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; co=
nnector, aconnector-&gt;drm_edid);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #if defined(CONFIG_DRM_AMD_DC_FP)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!va=
lidate_dsc_caps_on_connector(aconnector))<br>
&gt; @@ -419,10 +422,9 @@ static int dm_dp_mst_get_modes(struct drm_connect=
or *connector)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; drm_connector_update_edid_property(<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &a=
mp;aconnector-&gt;base, aconnector-&gt;edid);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; drm_edid_connector_update(&amp;aconnector-&g=
t;base, aconnector-&gt;drm_edid);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ret =3D drm_add_edid_modes(connector, aconne=
ctor-&gt;edid);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ret =3D drm_edid_connector_add_modes(connect=
or);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; @@ -500,7 +502,7 @@ dm_dp_mst_detect(struct drm_connector *connector,<=
br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dc_sink_release(aconnector-&gt;dc_sink);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aconnector-&gt;dc_sink =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; aconnector-&gt;edid =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; aconnector-&gt;drm_edid =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aconnector-&gt;dsc_aux =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; port-&gt;passthrough_aux =3D NULL;<br>
&gt;&nbsp;&nbsp; <br>
<br>
<br>
------------------------------<br>
<br>
Subject: Digest Footer<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
<br>
<br>
------------------------------<br>
<br>
End of amd-gfx Digest, Vol 98, Issue 341<br>
****************************************<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_PH7PR12MB64209ED7115C483713E4350B81B92PH7PR12MB6420namp_--
