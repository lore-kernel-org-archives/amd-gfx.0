Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D20C3ABDA
	for <amd-gfx@archiver.kernel.org>; Tue, 20 May 2025 05:10:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AEC210E092;
	Tue, 20 May 2025 05:10:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ltdWmdlm";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32CE510E092
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 May 2025 05:10:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eh5Ge5w/+9PyPVtyV1ojLfTdkVzrnrKsvjUN+PipvVTJqG9heP28oBLkCrYa5hwsc2Gps5drlPtZt8RlnyWiKhngzpdSoM8X3r+LSsqeQlYWLK1dECyUOo0bDbV63cMqbZozmYNbZYkvnOSEFtLYrvjPQ4un8pltxO1X5utfMYk72uWRwrx4w9iixw9ICNDBnDXmMPbhhNlumoAbRtUy3Okt74WR6aJJCWnwbciIa5DeSuKUsZ8VOHC1JkGZRm9CBpeauPCAAenU0QvTJpULwgPLO5HdwL2Xwpc+m8/fIYFRb7XtL+ctkeGxOgGrdnnNIcg3OBKS/lrqRfnd5X92Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0rtJuGvo/JqV0NARBp6iAWPYCVrUP3HRMRgm4eb5RY=;
 b=h3gNpYsGoRyTLILd28aZKlakmwiYTer6HJdsBt6sY8nRU4ExpFvVONP4lQoElrl78DIPISKk+YLSwj14V8bIKKqL8NEi6skp03x/A45/qz8QH7rk+MJBZn53tzfUS3moyyBHqfOeEDXJrT8XoqJ3/YdN6JsqB7+9YyWKGtRZ6Iz66CNWf41OBuOCEFxcc1fJfEVj0JT5n016b8RwSVV5DuX1vwB69Q+JC/dZYCx2Sjeor6wv89oWvWCkaYmm3+uTAUEfPJcIPBfdtLhap09kR7RzOENzPlJAnttmjK6tIzVUrNaGOrahgX6CqVeQUe/lv09wSQKdMyxEUrob1e41IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0rtJuGvo/JqV0NARBp6iAWPYCVrUP3HRMRgm4eb5RY=;
 b=ltdWmdlmATv+mbXDG1Ix5snZVsQq6WsoV5Mkr2z5acXul2Y/ts9r5ZOJ795PDTnyBA5Xum8i2L15xp7rT+/pnOr+CYtsX9D2OXSOEo7GPLhIIWK1+IIoeHigso1a3O4e2cylIVhZtu/gm+Voclvgsm/Lqcm2bLmFghl/ZxSEcbk=
Received: from DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) by
 SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 05:10:53 +0000
Received: from DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba]) by DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba%7]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 05:10:53 +0000
From: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang, GuoQing (Sam)"
 <GuoQing.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>, "Ma, Qing (Mark)"
 <Qing.Ma@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Deng, Emily"
 <Emily.Deng@amd.com>
Subject: Re: [PATCH v6 3/4] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Thread-Topic: [PATCH v6 3/4] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Thread-Index: AQHbyJcs4MJaW6/wr0qotfWV8KGndLPZ+q8AgAGFFAA=
Date: Tue, 20 May 2025 05:10:46 +0000
Message-ID: <4f3c7a86-c89a-429d-8ec1-5db7a0d12c6c@amd.com>
References: <20250519082038.21459-1-guoqing.zhang@amd.com>
 <20250519082038.21459-4-guoqing.zhang@amd.com>
 <e75c26e4-8011-4e49-9e2d-d354dcf7358b@amd.com>
In-Reply-To: <e75c26e4-8011-4e49-9e2d-d354dcf7358b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: DM4PR12MB5937.namprd12.prod.outlook.com
 (15.20.8746.028)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5937:EE_|SJ1PR12MB6339:EE_
x-ms-office365-filtering-correlation-id: 5ea3b8a9-be60-4550-eabd-08dd975cb1e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?MXggbP96jrWYjIN5yB5TFgasIEqnYgsPlXJycxGKT1xNM4wjP3wSLNyNg9?=
 =?iso-8859-1?Q?6ycMSbltFx2nuO/oikKuR+Xvc0YFVjJ971VLMwc8IEcQfILFrNz8tkmMkf?=
 =?iso-8859-1?Q?daggaHmT5Yi2dyvfu6jDRqlnZCoC4M+gids9dqt1KNHwzoQgtB8we/0l0x?=
 =?iso-8859-1?Q?1ZfaWiS8h3g85F8YjSelWMRBfUGH7SrM6rA5HjLYkhqEAr5sQlDU0J7HBh?=
 =?iso-8859-1?Q?mSlcgjxDs3W8uLDeu5DFl0T4f05x7PX1dV/YByppbeEu/qrvAae6ShwCpa?=
 =?iso-8859-1?Q?i5A8zQUzppXmuo8lBJC7G+zV26z8PL0Zy7jQ2Ibj6CrnLpFf73vt3fTzxX?=
 =?iso-8859-1?Q?x3pZ7rK/3WwjRXmvQYszU69+NiDWC5V44t9Ac4frxE6M/rLPCwNxOK4/TO?=
 =?iso-8859-1?Q?rz/bhu0gGJNfw1D1j9hPAP8u5qFS/4LvJzTEiGWghqfKVC86ZbPqcCp5gV?=
 =?iso-8859-1?Q?OewBKniobsrB3D5gCCO/xRqOUpoA4kPunknDxPWc5vPLSfzX0sLk0Vs/M7?=
 =?iso-8859-1?Q?tnVOaRTown1vYtr1AH2I0syKdQkJccVemC6NSsxj8CcHH9qxXXn3W7SVaT?=
 =?iso-8859-1?Q?XqOhV32nm1A+wRVWFH8XnCZnVIUHReqeXmbcRypJML04rE1n8E59HN2JjF?=
 =?iso-8859-1?Q?OzSKSw0bQfPcbpa5qFqfB15no/EyXaz2+0h9v/fE9Dgzveha9/cUG+GHvJ?=
 =?iso-8859-1?Q?5ORnIEvQ0OXRb1mE+P7Mj7ay8PQPdN6egZo2iO4tlEPkFhVg2+GC0oDste?=
 =?iso-8859-1?Q?bDeSvcItHJwUF3V75mcvyqBDmiyfrvO2WEpo8m4hfz2fiK81WfYGuoqnSH?=
 =?iso-8859-1?Q?DDpUb0+qiL0fE/wrQ1qsUJSJ3jmZDc/CUZ1T4/czz6WQ1ahbUHfxaRmksL?=
 =?iso-8859-1?Q?voOT0eFuvB7C4HCxomeoTD2i370DyYc5gYhGEynwkuyW79wlxi+RjQntX6?=
 =?iso-8859-1?Q?zjPzMydQO8c2MVZj5q73pCE+8YBTz2zNjhKyEKE0gijPY1Eg6qTc8hu9Di?=
 =?iso-8859-1?Q?I18E36eXZ03lNEQ9eiU4J1inD09evWj82ZCm/Aj4YLVgmgOmF1Vj9DPM27?=
 =?iso-8859-1?Q?MhbMEnPlpegFveQXy/9NlU8CDemzNKvpXvmvQTHilsi1AqAXaa0zu9d92A?=
 =?iso-8859-1?Q?l7A7PjMJOSagacu0A0XizL8+oMwMMBgdTDmVMDfdr2ll4ok470NYiF7XW3?=
 =?iso-8859-1?Q?dJXSUTclyx5qZC+z00USxLzrgsyDuR+qoyzaIoqHchzwIreJuocxxJk2JL?=
 =?iso-8859-1?Q?B7hADE8b855XQ1eBUhJwYYBZvPxf3T/iPOpTkZLgybmEetTIKh9u9/1s9V?=
 =?iso-8859-1?Q?hW4F7W0+j0Lze6cJyH5xq9aiM7R3PkilR3eZ8UsuHLWXClXnM+PRSeTvq+?=
 =?iso-8859-1?Q?pfnrnDnCZ5cg656O7EF9kmsIWzg7LRhtxbcfMOZhBT7qgaXkJ/CIhBZVcA?=
 =?iso-8859-1?Q?hPsTMAQPWvW3Ia2ji3Nf1MRXDQNrsvcVHTZe8bA2iIs3DCJNLuqHoV5STP?=
 =?iso-8859-1?Q?SkMhw+mLfib40HBPUtmPz7x3CKNLMoG65FbguPv6/pvA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5937.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zSYJtpzs+f2gmWW8JK9u76ThY1C96lYwo/TFR7RoRcv023bLGPel2quy3U?=
 =?iso-8859-1?Q?CGELv1VQYrzSNC9HNXFWGFKClenIaXr6lOm+0nnYtYUm8jrhAFhVqHSeGk?=
 =?iso-8859-1?Q?9GvnSdxIJg6reOxqIsxK0CRYik8CrU+2b6pCX71mRYh5I/Ud4JgJjRMBbL?=
 =?iso-8859-1?Q?rcazvfsx88J5K5n+Y//onEkpoMbwpAOpLkx53A8tUu2TN65mZ0sZzWveF2?=
 =?iso-8859-1?Q?RtgWPMXH05y0lRDSAHy5ugg68qTjb/fN8bmwrpDFw5duMoMKUIttVN6f9d?=
 =?iso-8859-1?Q?yYKL1zToINsVpw/oxuMcu/jTRyWQKxmRlHQ0ub5ZofOogA+eNJLBbhSusC?=
 =?iso-8859-1?Q?WN+uhllp2TK17dyZwZUOurvko05YJMML5RRdPVIF3GtzWnQbWZV/8tUnlN?=
 =?iso-8859-1?Q?RVSvHvcvQ4xM8168Iyc5HcbziM73DNfr3P37IiYby6I/XDpW3KPUoPs1EE?=
 =?iso-8859-1?Q?AmLG0+WH4FRKo59aoOmaJrtRs/aWuxIRL81EhglitFLCUt8SmUIhzV2Sl3?=
 =?iso-8859-1?Q?sMmRmdsz6Ojw3/Q3trzWUgzo2vN+lVaJIICo3hUjIohEJJwwGKbQqI1W0x?=
 =?iso-8859-1?Q?NvaR2CKY8EtfgIUXbVUZgbJqk/trOMcHNm+0xM6PDOAp8erBms5a98Mqsr?=
 =?iso-8859-1?Q?4u1tMtiuxl80+DZBf5EYWxxu0k+b+UuZTizyAOzqi54aOKjzDWmrJPM6wP?=
 =?iso-8859-1?Q?sSOOCz08qq7Ot01cgEgLR0lp4b7LcOrLOWilH7gNHg52LIm0f3DUuF6CYO?=
 =?iso-8859-1?Q?FA0Ga1Ng2j9CXlxk68p2woEgWpPPXGu0Y6HdIR6T01Isfr5AT1DzI0/KsO?=
 =?iso-8859-1?Q?0L/rSZLGcdEhWr2gePyr4wvs1DPBpBQ3+iopB3m9ZC99gBNdsu3A4h3Ed/?=
 =?iso-8859-1?Q?2ktdUZzfjxmGiKf5jqNU+dTG9xJZ9uBb4eDMgCJ4ZFseUz4+BlKMRHvyXP?=
 =?iso-8859-1?Q?Z6jifhJBsdWWB6gXj6WMgapJ1Q/ouhE81Xu7o/XeZ1STa88Rmu+dymuJaU?=
 =?iso-8859-1?Q?8dYz625OcCeaCg9YxP9foPb7ODsMCQp8AURM141b7QHh/gqKFc+9kQlzTT?=
 =?iso-8859-1?Q?apjoclMIb54Ihr8zoCTuGHC7cf63bpIUkV2I0erfvQK7UWuFfxAjHHwLPB?=
 =?iso-8859-1?Q?EB5lzOi/wSVDvWs0XRgI+qQAYKYeBrqtQwNyIzWpZdcxP/D0UHaAZdRY8H?=
 =?iso-8859-1?Q?OmSvm7bm1y6xnTtstn9ELI1ccuw3yGMxAN6oB27uFvGiRt9GFjr6oAVU+V?=
 =?iso-8859-1?Q?5NeeivQOgqI40Vl1AqYKfKi3RgwZir9aKLW64BkumbpgzwxYTO1rSQ1MgA?=
 =?iso-8859-1?Q?XqBFwgtlnrltRGQ92nqAJFJxMEX7m5wBx4sl/kbdEjKkikeuQvHFjSPy/I?=
 =?iso-8859-1?Q?Q9wtr5zSO7jka0prBa0aULgD6j8+2+kRquv8hYrrRd+V/+F4rv1j4pU5aR?=
 =?iso-8859-1?Q?CgpHpbg+7rZbl8TvHUPu2wchWkvXYPq07sqgF7W/urbTTUbjztNEOizKS7?=
 =?iso-8859-1?Q?BywceBTcXdZmCdP+Wp4BSjABm+di58u/nTR/hLWslkVkzGp4xiKIdKUuQe?=
 =?iso-8859-1?Q?KC9OCwx3l4lpthfthZETm61e6GGgjuaXiJ/k9OEreYtUdDLyecYRkcWk5A?=
 =?iso-8859-1?Q?W/nGSZy6/nXUQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_4f3c7a86c89a429d8ec15db7a0d12c6camdcom_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea3b8a9-be60-4550-eabd-08dd975cb1e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 05:10:53.3357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W2SMt6afgL4kZb56jx8NlS3dffwPaW9T4bx4tiGeKwa/CFbkrmXA6/P8dnLelJrfsKi9ucJdthei0v37TECEVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6339
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

--_000_4f3c7a86c89a429d8ec15db7a0d12c6camdcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


On 2025/5/19 21:57, Christian K=F6nig wrote:
> On 5/19/25 10:20, Samuel Zhang wrote:
>> When switching to new GPU index after hibernation and then resume,
>> VRAM offset of each VRAM BO will be changed, and the cached gpu
>> addresses needed to updated.
>>
>> This is to enable pdb0 and switch to use pdb0-based virtual gpu
>> address by default in amdgpu_bo_create_reserved(). since the virtual
>> addresses do not change, this can avoid the need to update all
>> cached gpu addresses all over the codebase.
>>
>> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 32 ++++++++++++++++++------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
>>   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 10 +++++---
>>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  |  6 +++--
>>   5 files changed, 37 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_gmc.c
>> index d1fa5e8e3937..265d6c777af5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -38,6 +38,8 @@
>>   #include <drm/drm_drv.h>
>>   #include <drm/ttm/ttm_tt.h>
>>
>> +static const u64 four_gb =3D 0x100000000ULL;
>> +
>>   /**
>>    * amdgpu_gmc_pdb0_alloc - allocate vram for pdb0
>>    *
>> @@ -249,15 +251,24 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_devic=
e *adev, struct amdgpu_gmc *mc
>>   {
>>       u64 hive_vram_start =3D 0;
>>       u64 hive_vram_end =3D mc->xgmi.node_segment_size * mc->xgmi.num_ph=
ysical_nodes - 1;
>> -    mc->vram_start =3D mc->xgmi.node_segment_size * mc->xgmi.physical_n=
ode_id;
>> -    mc->vram_end =3D mc->vram_start + mc->xgmi.node_segment_size - 1;
>> -    mc->gart_start =3D hive_vram_end + 1;
>> +
>> +    if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
>> +            /* set mc->vram_start to 0 to switch the returned GPU addre=
ss of
>> +             * amdgpu_bo_create_reserved() from FB aperture to GART ape=
rture.
>> +             */
>> +            amdgpu_gmc_vram_location(adev, mc, 0);
> This function does a lot more than just setting mc->vram_start and mc->vr=
am_end.
>
> You should probably just update the two setting and not call amdgpu_gmc_v=
ram_location() at all.

I tried only setting mc->vram_start and mc->vram_end. But KMD load will
fail with following error logs.

[  329.314346] amdgpu 0000:09:00.0: amdgpu: VRAM: 196288M
0x0000000000000000 - 0x0000002FEBFFFFFF (196288M used)
[  329.314348] amdgpu 0000:09:00.0: amdgpu: GART: 512M
0x0000018000000000 - 0x000001801FFFFFFF
[  329.314385] [drm] Detected VRAM RAM=3D196288M, BAR=3D262144M
[  329.314386] [drm] RAM width 8192bits HBM
[  329.314546] amdgpu 0000:09:00.0: amdgpu: (-22) failed to allocate
kernel bo
[  329.315013] [drm:amdgpu_device_init [amdgpu]] *ERROR* sw_init of IP
block <gmc_v9_0> failed -22
[  329.315846] amdgpu 0000:09:00.0: amdgpu: amdgpu_device_ip_init failed


It seems like setting mc->visible_vram_size and mc->visible_vram_size
fields are also needed. In this case call amdgpu_gmc_vram_location() is
better than inline the logic, I think.


>
>> +    } else {
>> +            mc->vram_start =3D mc->xgmi.node_segment_size * mc->xgmi.ph=
ysical_node_id;
>> +            mc->vram_end =3D mc->vram_start + mc->xgmi.node_segment_siz=
e - 1;
>> +            dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%ll=
uM used)\n",
>> +                            mc->mc_vram_size >> 20, mc->vram_start,
>> +                            mc->vram_end, mc->real_vram_size >> 20);
>> +    }
>> +    /* node_segment_size may not 4GB aligned on SRIOV, align up is need=
ed. */
>> +    mc->gart_start =3D ALIGN(hive_vram_end + 1, four_gb);
>>       mc->gart_end =3D mc->gart_start + mc->gart_size - 1;
>>       mc->fb_start =3D hive_vram_start;
>>       mc->fb_end =3D hive_vram_end;
>> -    dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)=
\n",
>> -                    mc->mc_vram_size >> 20, mc->vram_start,
>> -                    mc->vram_end, mc->real_vram_size >> 20);
>>       dev_info(adev->dev, "GART: %lluM 0x%016llX - 0x%016llX\n",
>>                       mc->gart_size >> 20, mc->gart_start, mc->gart_end)=
;
>>   }
>> @@ -276,7 +287,6 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device =
*adev, struct amdgpu_gmc *mc
>>   void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgp=
u_gmc *mc,
>>                             enum amdgpu_gart_placement gart_placement)
>>   {
>> -    const uint64_t four_gb =3D 0x100000000ULL;
>>       u64 size_af, size_bf;
>>       /*To avoid the hole, limit the max mc address to AMDGPU_GMC_HOLE_S=
TART*/
>>       u64 max_mc_address =3D min(adev->gmc.mc_mask, AMDGPU_GMC_HOLE_STAR=
T - 1);
>> @@ -1068,6 +1078,14 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *a=
dev)
>>       flags |=3D AMDGPU_PTE_FRAG((adev->gmc.vmid0_page_table_block_size =
+ 9*1));
>>       flags |=3D AMDGPU_PDE_PTE_FLAG(adev);
>>
>> +    if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
>> +            /* always start from current device so that the GART addres=
s can keep
>> +             * consistent when hibernate-resume with different GPUs.
>> +             */
>> +            vram_addr =3D adev->vm_manager.vram_base_offset;
>> +            vram_end =3D vram_addr + vram_size;
>> +    }
>> +
>>       /* The first n PDE0 entries are used as PTE,
>>        * pointing to vram
>>        */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_gmc.h
>> index bd7fc123b8f9..46fac7ca7dfa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> @@ -307,6 +307,7 @@ struct amdgpu_gmc {
>>       struct amdgpu_bo                *pdb0_bo;
>>       /* CPU kmapped address of pdb0*/
>>       void                            *ptr_pdb0;
>> +    bool pdb0_enabled;
> This isn't needed, just always check (adev->gmc.xgmi.connected_to_cpu || =
amdgpu_virt_xgmi_migrate_enabled(adev)), make a function for that if necess=
ary.

Ok, I will update it in the next patch version.


>
>>
>>       /* MALL size */
>>       u64 mall_size;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/=
amd/amdgpu/gfxhub_v1_2.c
>> index cb25f7f0dfc1..e6165f6d0763 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
>> @@ -180,7 +180,7 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct amd=
gpu_device *adev,
>>               /* In the case squeezing vram into GART aperture, we don't=
 use
>>                * FB aperture and AGP aperture. Disable them.
>>                */
>> -            if (adev->gmc.pdb0_bo) {
>> +            if (adev->gmc.pdb0_bo && !amdgpu_virt_xgmi_migrate_enabled(=
adev)) {
>>                       WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCA=
TION_TOP, 0);
>>                       WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCA=
TION_BASE, 0x00FFFFFF);
>>                       WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_AGP_TOP=
, 0);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v9_0.c
>> index 59385da80185..04fb99c64b37 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -1682,6 +1682,8 @@ static int gmc_v9_0_early_init(struct amdgpu_ip_bl=
ock *ip_block)
>>               adev->gmc.private_aperture_start + (4ULL << 30) - 1;
>>       adev->gmc.noretry_flags =3D AMDGPU_VM_NORETRY_FLAGS_TF;
>>
>> +    adev->gmc.pdb0_enabled =3D adev->gmc.xgmi.connected_to_cpu ||
>> +            amdgpu_virt_xgmi_migrate_enabled(adev);
>>       return 0;
>>   }
>>
>> @@ -1726,7 +1728,7 @@ static void gmc_v9_0_vram_gtt_location(struct amdg=
pu_device *adev,
>>
>>       /* add the xgmi offset of the physical node */
>>       base +=3D adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_se=
gment_size;
>> -    if (adev->gmc.xgmi.connected_to_cpu) {
>> +    if (adev->gmc.pdb0_enabled) {
>>               amdgpu_gmc_sysvm_location(adev, mc);
>>       } else {
>>               amdgpu_gmc_vram_location(adev, mc, base);
>> @@ -1841,7 +1843,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device=
 *adev)
>>               return 0;
>>       }
>>
>> -    if (adev->gmc.xgmi.connected_to_cpu) {
>> +    if (adev->gmc.pdb0_enabled) {
>>               adev->gmc.vmid0_page_table_depth =3D 1;
>>               adev->gmc.vmid0_page_table_block_size =3D 12;
>>       } else {
>> @@ -1867,7 +1869,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device=
 *adev)
>>               if (r)
>>                       return r;
>>
>> -            if (adev->gmc.xgmi.connected_to_cpu)
>> +            if (adev->gmc.pdb0_enabled)
>>                       r =3D amdgpu_gmc_pdb0_alloc(adev);
>>       }
>>
>> @@ -2372,7 +2374,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_devi=
ce *adev)
>>   {
>>       int r;
>>
>> -    if (adev->gmc.xgmi.connected_to_cpu)
>> +    if (adev->gmc.pdb0_enabled)
>>               amdgpu_gmc_init_pdb0(adev);
>>
>>       if (adev->gart.bo =3D=3D NULL) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/a=
md/amdgpu/mmhub_v1_8.c
>> index 84cde1239ee4..18e80aa78aff 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
>> @@ -45,8 +45,10 @@ static u64 mmhub_v1_8_get_fb_location(struct amdgpu_d=
evice *adev)
>>       top &=3D MC_VM_FB_LOCATION_TOP__FB_TOP_MASK;
>>       top <<=3D 24;
>>
>> -    adev->gmc.fb_start =3D base;
>> -    adev->gmc.fb_end =3D top;
>> +    if (!amdgpu_virt_xgmi_migrate_enabled(adev)) {
>> +            adev->gmc.fb_start =3D base;
>> +            adev->gmc.fb_end =3D top;
>> +    }
> We should probably avoid calling this in the first place.
>
> The function gmc_v9_0_vram_gtt_location() should probably be adjusted.

mmhub_v1_8_get_fb_location() is called by the new
amdgpu_bo_fb_aper_addr() as well, not just gmc_v9_0_vram_gtt_location().
mmhub_v1_8_get_fb_location() is supposed to be a query api according to
its name. having such side effect is very surprising.

Another approach is set the right fb_start and fb_end in the new
amdgpu_virt_resume(), like updating vram_base_offset.

Which approach do you prefer? Or any better suggestions? Thank you.


Regards
Sam



>
> Regards,
> Christian.
>
>>
>>       return base;
>>   }

--_000_4f3c7a86c89a429d8ec15db7a0d12c6camdcom_
Content-Type: text/html; charset="iso-8859-1"
Content-ID: <B53F8ADD4C87674BADA1E6A02A83C988@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-CN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<div>
<p class=3D"MsoNormal"><br>
On 2025/5/19 21:57, Christian K=F6nig wrote:<br>
&gt; On 5/19/25 10:20, Samuel Zhang wrote:<br>
&gt;&gt; When switching to new GPU index after hibernation and then resume,=
<br>
&gt;&gt; VRAM offset of each VRAM BO will be changed, and the cached gpu<br=
>
&gt;&gt; addresses needed to updated.<br>
&gt;&gt;<br>
&gt;&gt; This is to enable pdb0 and switch to use pdb0-based virtual gpu<br=
>
&gt;&gt; address by default in amdgpu_bo_create_reserved(). since the virtu=
al<br>
&gt;&gt; addresses do not change, this can avoid the need to update all<br>
&gt;&gt; cached gpu addresses all over the codebase.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Emily Deng &lt;Emily.Deng@amd.com&gt;<br>
&gt;&gt; Signed-off-by: Samuel Zhang &lt;guoqing.zhang@amd.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c&nbsp; | 32 +++=
+++++++++++++++------<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h&nbsp; |&nbsp; =
1 +<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c |&nbsp; 2 +-<=
br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp=
; | 10 +++++---<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c&nbsp; |&nbsp; =
6 +++--<br>
&gt;&gt;&nbsp;&nbsp; 5 files changed, 37 insertions(+), 14 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt;&gt; index d1fa5e8e3937..265d6c777af5 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt;&gt; @@ -38,6 +38,8 @@<br>
&gt;&gt;&nbsp;&nbsp; #include &lt;drm/drm_drv.h&gt;<br>
&gt;&gt;&nbsp;&nbsp; #include &lt;drm/ttm/ttm_tt.h&gt;<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; +static const u64 four_gb =3D 0x100000000ULL;<br>
&gt;&gt; +<br>
&gt;&gt;&nbsp;&nbsp; /**<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; * amdgpu_gmc_pdb0_alloc - allocate vram for pdb0=
<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&gt; @@ -249,15 +251,24 @@ void amdgpu_gmc_sysvm_location(struct amdgpu=
_device *adev, struct amdgpu_gmc *mc<br>
&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 hive_vram_start =3D 0;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 hive_vram_end =3D mc-&gt;x=
gmi.node_segment_size * mc-&gt;xgmi.num_physical_nodes - 1;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; mc-&gt;vram_start =3D mc-&gt;xgmi.node_segment=
_size * mc-&gt;xgmi.physical_node_id;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; mc-&gt;vram_end =3D mc-&gt;vram_start + mc-&gt=
;xgmi.node_segment_size - 1;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; mc-&gt;gart_start =3D hive_vram_end + 1;<br>
&gt;&gt; +<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; if (amdgpu_virt_xgmi_migrate_enabled(adev)) {<=
br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /* set mc-&gt;vram_start to 0 to switch the returned GPU address of<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; * amdgpu_bo_create_reserved() from FB aperture to GART aperture.<br=
>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; amdgpu_gmc_vram_location(adev, mc, 0);<br>
&gt; This function does a lot more than just setting mc-&gt;vram_start and =
mc-&gt;vram_end.<br>
&gt;<br>
&gt; You should probably just update the two setting and not call amdgpu_gm=
c_vram_location() at all.<br>
<br>
I tried only setting mc-&gt;vram_start and mc-&gt;vram_end. But KMD load wi=
ll <br>
fail with following error logs.<br>
<br>
[&nbsp; 329.314346] amdgpu 0000:09:00.0: amdgpu: VRAM: 196288M <br>
0x0000000000000000 - 0x0000002FEBFFFFFF (196288M used)<br>
[&nbsp; 329.314348] amdgpu 0000:09:00.0: amdgpu: GART: 512M <br>
0x0000018000000000 - 0x000001801FFFFFFF<br>
[&nbsp; 329.314385] [drm] Detected VRAM RAM=3D196288M, BAR=3D262144M<br>
[&nbsp; 329.314386] [drm] RAM width 8192bits HBM<br>
[&nbsp; 329.314546] amdgpu 0000:09:00.0: amdgpu: (-22) failed to allocate <=
br>
kernel bo<br>
[&nbsp; 329.315013] [drm:amdgpu_device_init [amdgpu]] *ERROR* sw_init of IP=
 <br>
block &lt;gmc_v9_0&gt; failed -22<br>
[&nbsp; 329.315846] amdgpu 0000:09:00.0: amdgpu: amdgpu_device_ip_init fail=
ed<br>
<br>
<br>
It seems like setting mc-&gt;visible_vram_size and mc-&gt;visible_vram_size=
 <br>
fields are also needed. In this case call amdgpu_gmc_vram_location() is <br=
>
better than inline the logic, I think.<br>
<br>
<br>
&gt;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; mc-&gt;vram_start =3D mc-&gt;xgmi.node_segment_size * mc-&gt;xgmi.physica=
l_node_id;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; mc-&gt;vram_end =3D mc-&gt;vram_start + mc-&gt;xgmi.node_segment_size - 1=
;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; dev_info(adev-&gt;dev, &quot;VRAM: %lluM 0x%016llX - 0x%016llX (%lluM use=
d)\n&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; mc-&gt;mc_vram_size &gt;&gt; 20, mc-&gt;vram_start,<=
br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; mc-&gt;vram_end, mc-&gt;real_vram_size &gt;&gt; 20);=
<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; /* node_segment_size may not 4GB aligned on SR=
IOV, align up is needed. */<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; mc-&gt;gart_start =3D ALIGN(hive_vram_end + 1,=
 four_gb);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;gart_end =3D mc-&gt;gar=
t_start + mc-&gt;gart_size - 1;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;fb_start =3D hive_vram_=
start;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;fb_end =3D hive_vram_en=
d;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;VRAM: %lluM 0x%01=
6llX - 0x%016llX (%lluM used)\n&quot;,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;mc_vram_size &gt;&=
gt; 20, mc-&gt;vram_start,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;vram_end, mc-&gt;r=
eal_vram_size &gt;&gt; 20);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;G=
ART: %lluM 0x%016llX - 0x%016llX\n&quot;,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;ga=
rt_size &gt;&gt; 20, mc-&gt;gart_start, mc-&gt;gart_end);<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt; @@ -276,7 +287,6 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_d=
evice *adev, struct amdgpu_gmc *mc<br>
&gt;&gt;&nbsp;&nbsp; void amdgpu_gmc_gart_location(struct amdgpu_device *ad=
ev, struct amdgpu_gmc *mc,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_gart_placement gart_placement)<br>
&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; const uint64_t four_gb =3D 0x100000000ULL;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 size_af, size_bf;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*To avoid the hole, limit the=
 max mc address to AMDGPU_GMC_HOLE_START*/<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 max_mc_address =3D min(ade=
v-&gt;gmc.mc_mask, AMDGPU_GMC_HOLE_START - 1);<br>
&gt;&gt; @@ -1068,6 +1078,14 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_dev=
ice *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags |=3D AMDGPU_PTE_FRAG((ad=
ev-&gt;gmc.vmid0_page_table_block_size + 9*1));<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags |=3D AMDGPU_PDE_PTE_FLAG=
(adev);<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; if (amdgpu_virt_xgmi_migrate_enabled(adev)) {<=
br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /* always start from current device so that the GART address can keep<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; * consistent when hibernate-resume with different GPUs.<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; */<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; vram_addr =3D adev-&gt;vm_manager.vram_base_offset;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; vram_end =3D vram_addr + vram_size;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; +<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The first n PDE0 entries ar=
e used as PTE,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * pointing to vram<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt;&gt; index bd7fc123b8f9..46fac7ca7dfa 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt;&gt; @@ -307,6 +307,7 @@ struct amdgpu_gmc {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; *pdb0_bo;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* CPU kmapped address of pdb0=
*/<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ptr_pdb0;<br=
>
&gt;&gt; +&nbsp;&nbsp;&nbsp; bool pdb0_enabled;<br>
&gt; This isn't needed, just always check (adev-&gt;gmc.xgmi.connected_to_c=
pu || amdgpu_virt_xgmi_migrate_enabled(adev)), make a function for that if =
necessary.<br>
<br>
Ok, I will update it in the next patch version.<br>
<br>
<br>
&gt;<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* MALL size */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 mall_size;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gp=
u/drm/amd/amdgpu/gfxhub_v1_2.c<br>
&gt;&gt; index cb25f7f0dfc1..e6165f6d0763 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c<br>
&gt;&gt; @@ -180,7 +180,7 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(stru=
ct amdgpu_device *adev,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; /* In the case squeezing vram into GART aperture, we don'=
t use<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; * FB aperture and AGP aperture. Disable them.<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (adev-&gt;gmc.pdb0_bo) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (adev-&gt;gmc.pdb0_bo &amp;&amp; !amdgpu_virt_xgmi_migrate_enabled(ade=
v)) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SO=
C15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_TOP, 0);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SO=
C15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SO=
C15(GC, GET_INST(GC, i), regMC_VM_AGP_TOP, 0);<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/d=
rm/amd/amdgpu/gmc_v9_0.c<br>
&gt;&gt; index 59385da80185..04fb99c64b37 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt;&gt; @@ -1682,6 +1682,8 @@ static int gmc_v9_0_early_init(struct amdgpu=
_ip_block *ip_block)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; adev-&gt;gmc.private_aperture_start + (4ULL &lt;&lt; 30) =
- 1;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.noretry_flags =3D=
 AMDGPU_VM_NORETRY_FLAGS_TF;<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; adev-&gt;gmc.pdb0_enabled =3D adev-&gt;gmc.xgm=
i.connected_to_cpu ||<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; amdgpu_virt_xgmi_migrate_enabled(adev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; @@ -1726,7 +1728,7 @@ static void gmc_v9_0_vram_gtt_location(struc=
t amdgpu_device *adev,<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* add the xgmi offset of the =
physical node */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; base +=3D adev-&gt;gmc.xgmi.ph=
ysical_node_id * adev-&gt;gmc.xgmi.node_segment_size;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to_cpu) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.pdb0_enabled) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; amdgpu_gmc_sysvm_location(adev, mc);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; amdgpu_gmc_vram_location(adev, mc, base);<br>
&gt;&gt; @@ -1841,7 +1843,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_=
device *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to_cpu) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.pdb0_enabled) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; adev-&gt;gmc.vmid0_page_table_depth =3D 1;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; adev-&gt;gmc.vmid0_page_table_block_size =3D 12;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt; @@ -1867,7 +1869,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_=
device *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;=
<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (adev-&gt;gmc.xgmi.connected_to_cpu)<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (adev-&gt;gmc.pdb0_enabled)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amd=
gpu_gmc_pdb0_alloc(adev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; @@ -2372,7 +2374,7 @@ static int gmc_v9_0_gart_enable(struct amdgp=
u_device *adev)<br>
&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to_cpu)<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.pdb0_enabled)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; amdgpu_gmc_init_pdb0(adev);<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gart.bo =3D=3D NU=
LL) {<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu=
/drm/amd/amdgpu/mmhub_v1_8.c<br>
&gt;&gt; index 84cde1239ee4..18e80aa78aff 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c<br>
&gt;&gt; @@ -45,8 +45,10 @@ static u64 mmhub_v1_8_get_fb_location(struct am=
dgpu_device *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; top &amp;=3D MC_VM_FB_LOCATION=
_TOP__FB_TOP_MASK;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; top &lt;&lt;=3D 24;<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; adev-&gt;gmc.fb_start =3D base;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; adev-&gt;gmc.fb_end =3D top;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; if (!amdgpu_virt_xgmi_migrate_enabled(adev)) {=
<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;gmc.fb_start =3D base;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;gmc.fb_end =3D top;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; We should probably avoid calling this in the first place.<br>
&gt;<br>
&gt; The function gmc_v9_0_vram_gtt_location() should probably be adjusted.=
<br>
<br>
mmhub_v1_8_get_fb_location() is called by the new <br>
amdgpu_bo_fb_aper_addr() as well, not just gmc_v9_0_vram_gtt_location().<br=
>
mmhub_v1_8_get_fb_location() is supposed to be a query api according to <br=
>
its name. having such side effect is very surprising.<br>
<br>
Another approach is set the right fb_start and fb_end in the new <br>
amdgpu_virt_resume(), like updating vram_base_offset.<br>
<br>
Which approach do you prefer? Or any better suggestions? Thank you.<br>
<br>
<br>
Regards<br>
Sam<br>
<br>
<br>
<br>
&gt;<br>
&gt; Regards,<br>
&gt; Christian.<br>
&gt;<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return base;<br>
&gt;&gt;&nbsp;&nbsp; }<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_4f3c7a86c89a429d8ec15db7a0d12c6camdcom_--
