Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22249C5DF81
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 01:34:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BB8B10E042;
	Fri, 21 Aug 2026 01:34:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fxRjt0OM";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012070.outbound.protection.outlook.com
 [40.93.195.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 798EC10E042
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 01:34:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdllvYy7C27uYUK5iMpjmnZTgLb/cyXt8XyZ6KorVuq/At8ULFos5Ps7asxmAIUsV5CRlpRk2JhWU2FYpQ8YAanuef+7MbIafDPQRgmdkLO+U3kty9sn3Crro1597iSDMjz2XDCLoYItllspd/hUj3NBDiQXYgK8eG/iYXh5Mk8EwVPwl046hSO40nFfbgwZ2Y1lHQqD0vyPo3YusPb0f/3eJK7XWYDM3fMnrP39+eBQ/TgtOFasj+QKJczi94zJDTqy9F/i0+uuc1knunUYFTKweDnVkaR7KgJAiABkTdyoJJR15OuZdblT3hGiNqPZSLi/Z2nlqAxrbw7Kfa5XBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlRgR7qailWuQJcpZDU3Twejej83oitPeIAFMVhVQAo=;
 b=o9EfabG9gl2xdyykF3mFwxd68cCy6zTszGqEVGJTmEaQ6g1J46OyJuVm77USImJwvfTe5LMUYgrzgMIXwZ8OzOe7YAnvjc1dEGgTsqfTx0gBkbPAMRyW2ywBzyvAESmXL4wxG1K8wKW/OBc/I8fESzO+YM8Drwznp8Us+aUdw8GTAzhgKrGtbwoISEC3av7ixRT4sT/MF7dLrx4riDhsVzKyxvXYcUp5NB6yG0T1+s6Fl94pa3e+dz4ee9lzBiRNSyE3i7+v+yJVIdHkOn9jrOLgLLK73nec0l2+ZAtJAhSqi+nSr7vSjUANiL2AIhjXQwvj9jW0u76kvkycm5iXmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlRgR7qailWuQJcpZDU3Twejej83oitPeIAFMVhVQAo=;
 b=fxRjt0OMZewE2aHtBRIkSjeqjyM0KQAkWD37HPSvOd6ziALxEBXkSgiDgmfIX5409vVc8VVQixearTHt4BiMySzySESWt+QeJzrefBIJh5gQlEwc2giABUSPQimvrcclpdklpI9Q+v2/gfAVrvNiF1TXt71bNDDKF6LUVaeTrgQ=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Fri, 21 Aug
 2026 01:34:35 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 01:34:35 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Lin, Amber" <Amber.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Set queue reset method for GC 12.1
Thread-Topic: [PATCH 2/2] drm/amdgpu: Set queue reset method for GC 12.1
Thread-Index: AQHdMLgyFiUocAZ5sUKGw0cafiTkzbantt+w
Date: Fri, 21 Aug 2026 01:34:34 +0000
Message-ID: <DM4PR12MB51528B0FEBDEBAB288359587E3A32@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260820152504.1160822-1-amber.lin@amd.com>
 <20260820152504.1160822-2-amber.lin@amd.com>
In-Reply-To: <20260820152504.1160822-2-amber.lin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-21T01:26:57.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SA1PR12MB7104:EE_
x-ms-office365-filtering-correlation-id: 0f14d43e-b05d-4e1e-4b3f-08deff245b49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|56012099006|22082099003|38070700021|6133799003|11063799006|10067099003|4143699003;
x-microsoft-antispam-message-info: s054y7hL2wbOTkjTE7jq+q/KfZkuNv4zvGwfsBShWfUVYMtC231BhfErhbGi8ewUQTsgIa2c4mDTjdbDBuPwXcSPxW/HN3KLZlwYYa6RnhwMwZ1ZRit/gUprmcqxSgvBh3CoXcEm+TmOZGI9KG6Oacn49kzVOl7Py6vY1MNPbMvWWk6XOwRogIHAoQVm/vtX7Lifyjsdhp/NoHbea30x+SOoWRvuR+Mm5U0vPhDalJ+/ztkcTYYotFgdecAX/gMl9e+APHJtim7iu3AfySRjhxFEnLupJYoXi8IaZX7DdpM+B5Hs673Bcf21po3dPhGG5SB6ODwHErfzXCCpqDT2EHDYQZCzX4ci7tu2on0r4HGcn2PaAdJL0vHfnkYiq/IzNV3JjQACHxqllhZFPwoLya/XcNPJQaeQpFbjKwB956JWPLAuliZKTnhD9vYG96ZKyDx8m3Jkwooj4UpwDJoDCnM9YSa9TRhJ4HmiKVi+8jKQtHLXgHzv3atFADeU/f/VSqCWsKi/Q8bq9BMhsu4YuJmiUGgD80Dz2PLc4vfGMQCY7UGnFwwH5syH48KwnlJThrcU6LJNswrKqATg3sT5SLHDrOEUpVyxGQWbLu4t4ME6XRcGcfjTtqpgmFxDlo9V/9YjmW8b95tp/Gbv/m2KAuF+sa8izC+TvA27GikKyZIh9Sfd0Fwnnl/yOkWdyeB7yT5eJQ9wuKeOi1IgvuK9F4jLUzJ0L8jzcOs2qe8BluQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(56012099006)(22082099003)(38070700021)(6133799003)(11063799006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f4UsmmEZy1LvWvMfSWBeMK02CQs1+PNwfnC50wtk/nHUlQeuY6is1lndovw+?=
 =?us-ascii?Q?bqUKfFQtkATGuDHsssPdBbDrM5eWzJtWrsfOwd9pWZGjCLV6RPCnPvQXa6WM?=
 =?us-ascii?Q?p/sR39C/JM5KF/kSNnGAcW0hFnT4eLwsk3Z9n9Q84KeYLZaOe5F7orI5/OQL?=
 =?us-ascii?Q?KQrfbbjg2lvkjzuenVOGB3UzaTmI2zllgKvUz0LipQULtNtZRvFAPk6PTaOc?=
 =?us-ascii?Q?H0pvUAQZ/JhVtqioot8lt8hcM//polWlX8kbP0p6dSwCT4QlnfBnryPB8hwA?=
 =?us-ascii?Q?VHfUbV4lzRkT/KN4KtNCROdgrLmADRgnexigwnmHkQBE+cMqzWEVdhurSbfV?=
 =?us-ascii?Q?2js/2/NlKMsjgHpznDTH1o99s/AZFYMXeRjd6Psl3e+6R9W6eWPQdCoZf3gn?=
 =?us-ascii?Q?rYOBH6AzE64xDxwe2GftP/fHiL0D747UOHIw19gtbcZ7IrBXOgT255AXzj6X?=
 =?us-ascii?Q?ySyzeU36+JdayLPQ6aGnIC79Dh1Tx/wZQigk2lupCsPSZ+1LdiFKRlqcYjf8?=
 =?us-ascii?Q?iuELVfGQIHBps4pJVPz0wehQUdtUD7Uxz7+gAN/gVjsYESG48ekP/hqoRLk8?=
 =?us-ascii?Q?R3dUt4OwkqIXb5QIj/C/+kkl++Rp10y2Rk2OqaGcRrR36AIGiRbgzZL/9Mm9?=
 =?us-ascii?Q?tl1uCAA5j2rfsE+rladpB9UAVNdczw7GOYS3iKqajdwOypuM5NdFaaGoVV/9?=
 =?us-ascii?Q?sU2BCua4fkHkC9LBj8/+DkfHBk1PARHQudJ4BA59+Q3Djlw7chtUumuMN5Ih?=
 =?us-ascii?Q?oBHZlkgNOW4nNi6Q/HO9oW03aLvWUafMSHtm096t0F2ZhPJMhF8/PP4rAFd0?=
 =?us-ascii?Q?EYfxmHJYOyqzeWwrJITONzuoB+krh0Rv/xFXCt+M/yyeBzpw5TpAws9Mbopd?=
 =?us-ascii?Q?b2U4zjj5Zsc/Ci9OlLxWMbM7UQj9IsmzPly8QckjHOFFbfc3di0bXUC2F93Y?=
 =?us-ascii?Q?Zf5k2IXGVBP84990HHnuiNxWMb9fWVCcI/rqeDu/bieUecvekP9aFLLu3gB7?=
 =?us-ascii?Q?4rET1VNwuIXHUlMMq+I3/jECBjuGRY4itIGQBGumLLs56h7JLfKexXnFG3X1?=
 =?us-ascii?Q?WeEZn9qmRJv4e26H5lE3ij/PTfepaokV5UHCoIsnVG9k3h4zKpn3v81BxDGH?=
 =?us-ascii?Q?zaxWfoI/STwa9P50ZNHp8/KMTO4OzS3SHtk7w/qAiNazkq2HXXNl09x+5omz?=
 =?us-ascii?Q?fXfErCh793BRtXh1NwY6rjJh/J//X53zna5irKGGJ4UoScfOfZGI/XyBfWK5?=
 =?us-ascii?Q?OC/yHdKb9DNaufZ45h4GH/yfB0kp5QUK4hHWth9Zf0ZY7pCeNWWoa5Kpncia?=
 =?us-ascii?Q?WzQHZQGEIjk167lYVIFfcNyTZpjOQnmAKi5BAwsKURFB/e7I0SrzzwjW9bp1?=
 =?us-ascii?Q?t6cZJEou+LN3UYCXLf9NZ9ndM8Lc4wwAdIf9qaD4BOXkx+LJvsBiPva+301X?=
 =?us-ascii?Q?DOcvxfDcHZlKywfGPd6O9+tXmj4NsbPbxmTrf04fzRyr2xbWmaVp1MMesUIY?=
 =?us-ascii?Q?Ig4n/N9jAT5MdS8yC3cpZHuNJeY/+eH1ZkoNPVnA6jvhEr35uOng9i//1PPu?=
 =?us-ascii?Q?mUFSKnOnlShXZi6W69dWOvDuGGXnDm2smKw1jcEY9F2i7hc3fI/c6fxIq16W?=
 =?us-ascii?Q?rEvQXeU7S2Dgutpfk/3hbkaBGl4PObrGat3ODeA7TpJiidqmEn7iLgkX/VzY?=
 =?us-ascii?Q?UOqapFhVBENXx+cLGy+S5kAg7cPRxN0QBPXpny0UMxiRvXB5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f14d43e-b05d-4e1e-4b3f-08deff245b49
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 01:34:34.8390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nMxKe8HgfpSCBYKQiP8/GrSPmUmPGcYu+h7SjnHwQz1tu6zul/swV28axgpwrBSsk0Mm8XV06pihfmSVzgA7qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104
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

AMD General

> -----Original Message-----
> From: Lin, Amber <Amber.Lin@amd.com>
> Sent: Thursday, August 20, 2026 11:25 PM
> To: amd-gfx@lists.freedesktop.org; Liu, Shaoyun <Shaoyun.Liu@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Cc: Lin, Amber <Amber.Lin@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: Set queue reset method for GC 12.1
>
> Explicitely set use_mmio_for_reset=3Dfalse in gfx_v12_1_sw_init for using=
 MES to
> perform queue/pipe reset
>
> Signed-off-by: Amber Lin <amber.lin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index 9dd7a3335719..97f4da7b7607 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -1560,6 +1560,9 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block
> *ip_block)
>
>       gfx_v12_1_alloc_ip_dump(adev);
>
> +     adev->gfx.me.use_mmio_for_reset =3D false;
> +     adev->gfx.mec.use_mmio_for_reset =3D false;
> +

The MES firmware already supports queue/pipeline reset, right? Do I need to=
 check the MES firmware version before switching to MES?
Apart form that, the series is Review-by:Jesse Zhang <Jesse.Zhang@amd.com>

Thanks
Jesse

>       mutex_init(&adev->gfx.mec.reset_mutex);
>
>       return 0;
> --
> 2.43.0

