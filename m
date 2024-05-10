Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E0FC25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 06:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9491D10E0FE;
	Fri, 10 May 2024 06:20:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bUPA01Jb";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EA8310E0FE
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 06:20:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiI3LyJmIGZEUrbr6QOXMCpxnjfHyW62dxPlMMGXcss1ygnMsehcMTocdTyA062kUwHoLrvlmmBhL8AsdJEACVophaT+DBlyedNOqjiwrp7A2ptX76o7aGSGFOWNLS95ywAM8Z92Ew+SlVlCyZHX3L6yMFD2Wozc4efqlJLbhoauwOAZG1B+0X/c/ne0L2bhQix28sDgBf1/KJCKjS4/JcWC9UYbEyzzapSdRkzhtwg9ZaoQ+AQ1aO1Py1PoCmAl469zTeMBYY1e8Jp12Cm7GQLQRex9jLk1o2ltTp9QMithqi1Qwv2afLhlIuhrk46CxZxGlKc8fTz0wW9fiwsIMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nm9d30lHl58XOZltA46WpyIcLpL+mG3nhXfIpdeGWp4=;
 b=VjWHg0yFd14YUcCkILynd6fBDJ/kGkfZonxvdF7/Zl71ud9BHLXUV7UcPwj3xBuDkXNo2vD6wymWl5eh9Ygqrmqih2sLQJLN42LDPJpii2kdbdip+9sr3bkjTlPt3kyutUZNti92JYStn6v8UjlzOqE+8/UayoNC8FQghnpBChMkqNgsd8Maj1Atizypza6EFTKGC4QNsx2XrcY7qolVAwqLhj/HYrWKadiE6l0/oLUORvDOQc07pl+GQ1qoAQ+5IA52GjyrcoXn746ONaso4xMRF6AhIJ6iYvxRoEUmXlrwKRacnyJlqXf9UumUHS5SJkFGf2M96Uk++hOuMqDd5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nm9d30lHl58XOZltA46WpyIcLpL+mG3nhXfIpdeGWp4=;
 b=bUPA01JbUd1TKzPVejnMGkAQ5oJueiooEMqksAJODdtNpO7E5/LI6vvL52WekvvofL5GwvahN5j61s6FNko+y0+8bXYnRoylLUYx74od3NMzS+75GFO4rZPBsWLapDAHXz139Evtv8DS7DVJv4FdfDW3PRcdeb0H+y1RVR4EzEA=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Fri, 10 May
 2024 06:20:49 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 06:20:48 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 03/22] drm/amdgpu: fix the waring dereferencing hive
Thread-Topic: [PATCH 03/22] drm/amdgpu: fix the waring dereferencing hive
Thread-Index: AQHaooUWllrvZbNvSk6ot5oDN2Y7XrGP8z2w
Date: Fri, 10 May 2024 06:20:48 +0000
Message-ID: <CH3PR12MB8074F8C59B77E50F74B388DAF6E72@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-3-jesse.zhang@amd.com>
In-Reply-To: <20240510025038.3488381-3-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e4ccaa40-fa2c-4462-814e-2af0b0c177ca;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T05:37:25Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|MW4PR12MB7309:EE_
x-ms-office365-filtering-correlation-id: e5df9573-1bfa-49b2-69e3-08dc70b9554f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?IwztJNOdP9HkUy41mik/Y/Yoo4EXKRgs/FhZsClr+eikkPE0B7a6UJMnue?=
 =?iso-8859-1?Q?4ElYlh88Z5NLdTXH/4gMADus4rG/EUxH5+VGr5paXHNg1+f+uTX5TVckbJ?=
 =?iso-8859-1?Q?TDdyRAxq3hP5RFYkbOErMe2Tvtt4ECjZc3iXFQ9LjXc5qUoOQkUhfuZ43M?=
 =?iso-8859-1?Q?CEzcr6RgVs3GIbstotNnUyGfdKgOV+148zfe7Os2LBEYEWJ3mj1WG3ihwa?=
 =?iso-8859-1?Q?UF6I4oNJPDZxH8Df+qheLy5jIJOTNU94wcTIgI6brMZogWE5jkMT2ayinL?=
 =?iso-8859-1?Q?7lrDebP1EfNNTvZPJN9AAHsfFJujwO+bSB/4tWgrMJTmnRI1D+XGNeW0Wc?=
 =?iso-8859-1?Q?KgP3u1u15KC8yL8ZCi0LHQmPMGeBzv/ESn1Plate6WM/DqY6v/siiGar+q?=
 =?iso-8859-1?Q?KqZOQZ1OkXBnXs+3n5+i7xws6cj386+4+ppAOzN4nDoDiI0SdWtf2Ge6mE?=
 =?iso-8859-1?Q?ACUnpl7kuZHOTwFRITH0GiN431hUBViQOY0hegX6brSz61KVmETUz8blW8?=
 =?iso-8859-1?Q?1nfcAiUG2IA5qq5JaE/eDLmZmTYnQLX/7Qc1BsMKH7qZmRtdH72dtmttan?=
 =?iso-8859-1?Q?sMBz3cazwtr+8ASNTn7X5U2+VuV7WWtySsSUJf6H1yPfUohKmJxVNpyaDc?=
 =?iso-8859-1?Q?44VmoZ8FedHIXIXo2QYOlRBa332aaBqr9p/Jx8Q5Zzik9mvpk5PJ/ZEjTP?=
 =?iso-8859-1?Q?g1KoEmUgSRvXHpM9TtShIhaYAB9SXAUKDMiAB1dQG4mRZTrBQHKTVFtBNj?=
 =?iso-8859-1?Q?2G3EosljfeOOBjj9estja9OfQPvPCCU5BcxfjH2j4uNCodx5+ZHarzkjg2?=
 =?iso-8859-1?Q?V1lrCfMklmUcipF9TIVGHnfW7ypB6dYmKTnzP/yJGLGCs/jkFMXxy+2+tx?=
 =?iso-8859-1?Q?JYPLMmXiyiaP2pyFnSyjCwEJDGOrYXqQT5xlMzYd0MtyTCCDWF+y/gBdaX?=
 =?iso-8859-1?Q?t8GBybOnWpyswF2zSwKy3q68L80MP5AdGSXqdmZevtiSmbovGz96PXAfjc?=
 =?iso-8859-1?Q?Gp6HGmIK5psio8s+3kcAA27E/0tv6TYdYWFZgE0qvZjwn/gqOgpW3Szpmn?=
 =?iso-8859-1?Q?p0ePBXtW/QMIyVPmd/Rix4KCnvPagzEu3403Sgl4YiWqO/O5NqXDaTDCcr?=
 =?iso-8859-1?Q?GTqKgUXFatKMZon4UxzrsoU9ziwmUbQDPoOFN4ib4pYl0f1q8/7U037FEQ?=
 =?iso-8859-1?Q?APh8xOn6L6PSzXWKX11VEGKIl1LWYNrpomE/ZCjsJofqTpbaFmvVtVrevZ?=
 =?iso-8859-1?Q?T1FCL5eRI+jTrpYofs+7ceOQUEs2UjwjKJIxWwkXUM1BPbyy5VH4Uo1mKb?=
 =?iso-8859-1?Q?KXUv1V9R6DosXRWr/imYs/nrjFRZvYaEA+b6VQBNNKQWfRhL9AAPkVMDPg?=
 =?iso-8859-1?Q?/wDJ4iU3JmzlnjBOS9gMJnXojV4C47ww=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?paK7Acz1spG7LPEzdBq4XpCp4r0bUFYfTk/V0IDIm0LgPp4dcTQe2nW26z?=
 =?iso-8859-1?Q?WjbBn7BgOxhKk69Sp9geRXhOqv/6NzMVJWLdIioEhTbjVG2+fC124mt/WD?=
 =?iso-8859-1?Q?3U4BtDW4X+gwx39r6qk16hMosEPY2jakH++jIrbiLcMji5zrh/T4D5V/th?=
 =?iso-8859-1?Q?MfZ4IP23yquYAe8NoGqqZV1X54UpQJM1pNkBgVGSdfIm5T79YMFlxbn/bp?=
 =?iso-8859-1?Q?fkr2wZY7ZFX/IRB8CAet5F8nvyvkXdQCdB6cCkPyhHYxq5jNa3Deg0zcTd?=
 =?iso-8859-1?Q?zSDf3BAagvwE04OwV5MdlutvzuumKbdVE5b/g+IvQptFH0f+LJnnXpuzqg?=
 =?iso-8859-1?Q?25Hq6uSp2iLM2uxdv8M+L5bLlKx6T2W+y7rMZPBJxhky8SDDXdI47dOilR?=
 =?iso-8859-1?Q?FZ6NYn4+9sRohfRT25+vfg88gDEtFnU+KMqW61jLGwGIEjAsMkow3+ZlSf?=
 =?iso-8859-1?Q?2/VXJAXt0wYORfMhKmfVoY/1GQfW5UTYqT4RCYDgujw7A4Wb8l2HmaaRPr?=
 =?iso-8859-1?Q?Q8ASEAO/gSxb0p7asl4F/3IYMGuk/Gwbdc+3nKGsbxrNLYicCKvhO1yJ4d?=
 =?iso-8859-1?Q?VBS8OvCbflZBF5QLUvEAE1sYzgrYONHgsP0j7Koll9+AfFVcuCaNU2KufK?=
 =?iso-8859-1?Q?iuUYKFA1ZNyXkjXDwcz7hy2TmJsAQFhRSsRocp8sbNUo/F6HW1P/KfZ0gc?=
 =?iso-8859-1?Q?9WikAazi/zjNFIP/gC2c/TEMCDTUOSxX46j3slTwMIwFbaUu5xgJC33ipj?=
 =?iso-8859-1?Q?uNgKYG/mZ+QgsPxvCHqUeW3DoTo0OtWZjhrQnYOG2fMrqHZg68vl/SKW7N?=
 =?iso-8859-1?Q?0XQONujRTpm8KrgnCNympPXMz9RgfKQGnR8W8Dwx65KVZu4xLPPo+I0pIx?=
 =?iso-8859-1?Q?8116JhYysUQsyWvtWnrNJWwLF4CvfNjpETeRkzQ5pO67MI0Hhn35otzg66?=
 =?iso-8859-1?Q?MqOd3hwXGbqD1Soyp9/AZHanrA4zL96jJWgmp47rb/fIg0v6sX248BsjIh?=
 =?iso-8859-1?Q?8+TaorZgNCHKfEVNNvgFLt9WzXTJHA2n6cKnRJndXviDdTHDnxbrf4myST?=
 =?iso-8859-1?Q?yEvE5VEQV7Aqz5fsh2qw0ubDcFMENk5QvCAW6XQYVRyNjvc9yeWEQxNsQW?=
 =?iso-8859-1?Q?pFCUriU8MnRzVFRD2fDv1izC4/PJbP2iv/o9neOtsFV7/GAgBpcq9EnhKH?=
 =?iso-8859-1?Q?gMUkK6qZhr7UO+4H8+0f8lyek66axuAIR7xmyHGBa+rAb79uLa+Lj8sUXA?=
 =?iso-8859-1?Q?Li7xcO1unbGfIecVrw3Ix5rq2NdFQdL/TaJXgyLve9CWtddVbog6ebB4NC?=
 =?iso-8859-1?Q?dMD3qe5gUAK9x95Vhlb2Et4Ge017migtGgVbp6hHR4ufpu9nH3rKW6FzaK?=
 =?iso-8859-1?Q?MyI/ZvstVWD74NcX6bARyuNj0NYGBo+mSMMzp6joyZz3r85n8LYkh64pS+?=
 =?iso-8859-1?Q?BP5Y6w4QsWZTJ4oq0CErMuZAysYwR00t/DHPzU65dYrMjBQbv2jL2zh/ob?=
 =?iso-8859-1?Q?VZukpDtih48Hc7rO2uGiH6p3jNLznAUOFbf5pXG3PdZFuGnsOLIYm2x6Ja?=
 =?iso-8859-1?Q?1+upOQYFVRTEljGKva/viBPvHIMtRvyD/2O/z3Klh46Vbr7IDelwxTEZNd?=
 =?iso-8859-1?Q?gvC8qNpu12tnM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5df9573-1bfa-49b2-69e3-08dc70b9554f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 06:20:48.2055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJDzpHsVPVwVvd8B+vkAGxLZopCWvN4gkkLMi5dH7RKvJppbh0Ht3Hm4sLfuhRqNJpFRokQOQJpnoEVYxtdXPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7309
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

This patch is,

Reviewed-by: Tim Huang <Tim.Huang@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse
> Zhang
> Sent: Friday, May 10, 2024 10:50 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 03/22] drm/amdgpu: fix the waring dereferencing hive
>
> Check the amdgpu_hive_info *hive that maybe is NULL.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 37820dd03cab..5a648a657dc6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1362,6 +1362,9 @@ static void psp_xgmi_reflect_topology_info(struct
> psp_context *psp,
>       uint8_t dst_num_links =3D node_info.num_links;
>
>       hive =3D amdgpu_get_xgmi_hive(psp->adev);
> +     if (WARN_ON(!hive))
> +             return;
> +
>       list_for_each_entry(mirror_adev, &hive->device_list, gmc.xgmi.head)=
 {
>               struct psp_xgmi_topology_info *mirror_top_info;
>               int j;
> --
> 2.25.1

