Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B5BCA0FFF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Sep 2025 14:36:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A738F10E478;
	Mon,  1 Sep 2025 14:36:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qbXKK9Iz";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B45AC10E477
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Sep 2025 14:36:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xi/QR0PmCUMG9fMGEUVB5M3ihXjQfQknnl130NsYqxF1Fes/mRCmKIaqaxbvupN5ly9htznA0RPryVtNZ54btaSv1ALuBgswN00uGGGQYcDNF24CB3va137VShp80OM8GgxFLFsOgLEcp2sMNxVGeeTki0Up7FG48vM76re98QUNc/JMw4SrPzFbTUXmK1Po46Zncnbg+6+aphf8OVKAdcgbk7cS/EfN26uNrcHYKYEAQf57TgmxhEza+aCIph5oEg91S/4P91pDmI4B7tEgYiu7JQXFRbZf+II0QKyQBdsxmhgGI1DeHYCkiEvgBjbWlqoLtQSbdNQB89Xum2HpKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZrEQSmJPUIAiAKDD+uO/RjE+3VmhucRImxETldhdbw=;
 b=GQnEt0GoRwRu1i0y29BZGqVhFK/f3nG7CYj3DpM7UkZlohDD1b5K4vgLValbkTxeX9u1dfpr4ydoql/Cx7ge6Xdkv1nISmsPRDDvLfILaTesY5wxYM/X6T6AyCRf8pvcuKHUWbpT40opEy/OD8ZNjdoXdv5ra998xkZNkB5w2JngoI1YzkYDlag6LkHKTQy9dBh/1t8rg6sWAo/IHyNYlqeaZotn/TFzcm5clEs3JnsdTvypP/NPYuBIb/Zirt8WsvaAxHsWtwLD61HCbuuU33PiNyb85K6+E7IkQlFGWD9o7WNA+VbAvxJaizuaTw9633c9iG4np0ebwnFVQuKd3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZrEQSmJPUIAiAKDD+uO/RjE+3VmhucRImxETldhdbw=;
 b=qbXKK9Iz+aK0bn2aVt15+uj1DJYWhRhn67XzE8MqtCoRGHVpeyDQPWOMMhIpiTXpo0zPJabXqDzKlJFdP4u9+cHeud4jaSgNO1wUhqd1QG+IfPKXkaAYepM5hsCbbEISTg9cu+PsQCktXViQvHcjklVlae59E/KTUK61aC+imLE=
Received: from CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21)
 by MN0PR12MB6341.namprd12.prod.outlook.com (2603:10b6:208:3c2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 14:36:22 +0000
Received: from CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::542:90bb:6ae5:a2b]) by CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::542:90bb:6ae5:a2b%6]) with mapi id 15.20.9052.024; Mon, 1 Sep 2025
 14:36:21 +0000
From: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Gande,
 Shravan kumar" <Shravankumar.Gande@amd.com>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Introduce VF critical region check for
 RAS poison injection
Thread-Topic: [PATCH 1/2] drm/amdgpu: Introduce VF critical region check for
 RAS poison injection
Thread-Index: AQHcEMnH+GwezBmZUkiRyQD1KAChEbR+eLx+
Date: Mon, 1 Sep 2025 14:36:21 +0000
Message-ID: <CY5PR12MB63452616CEE6C924FF8DD702FA07A@CY5PR12MB6345.namprd12.prod.outlook.com>
References: <20250819052548.124897-1-xiang.liu@amd.com>
In-Reply-To: <20250819052548.124897-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-01T14:36:16.769Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6345:EE_|MN0PR12MB6341:EE_
x-ms-office365-filtering-correlation-id: a02d9eff-1e9d-420d-7ee3-08dde964eb6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?yP0sNsoLLLoAyeSnSRFl7Iiv8augNmPnse9k2YhTl6IJ0CM8N9BENMVuYxXv?=
 =?us-ascii?Q?ZqLksQNNwluX6P58H0BrdHmw8L3VrEZpVEEBCWYY/CcR5svQ2zaqNsyuB+Nw?=
 =?us-ascii?Q?KQ5Zsjq/Rm6JF/g+WMC8ClNz8NaI02Q9Hcbx37FUgYWZTT8PfOI1sBH8r1Of?=
 =?us-ascii?Q?cWcIoq8yz0oeuHnyHWmd5t2V2kCjAafkTyzGcqF2EK7p97UXI6TgFqdpW/zd?=
 =?us-ascii?Q?r/ajBrcIhiyihk3esTCeGQesYYe/pOZ2do3Mgya/pUA4Rv9wtfHQrbZXTaGF?=
 =?us-ascii?Q?wArZJStLOBR4LucDVcl3+4RG00kIleo2+H17sdE4slfzdr0dcSd7ufOI9bRo?=
 =?us-ascii?Q?1IDKBbztiK85U2H4HB5/q/PmbXYXD6JQmSx1bl9IU1odAn64y9/bBwRf+3xC?=
 =?us-ascii?Q?XBCorSpnDk2gv2/H30zmX0cWBghpRmCeCWw2v2jYKpZl7Dm1RbW2XJhXJvV5?=
 =?us-ascii?Q?dBRLSQNWQALDTRUPy1bnwps3uTfckUWO4RSus73SgE50bslQmRiZTk0Hhbx9?=
 =?us-ascii?Q?rrxNBlfOuVNMkOV/iXRwbpsQcMi9noezfsN3P4e187VhElhPBT+AAP2pV4tJ?=
 =?us-ascii?Q?sL/tRr2oSLqben4hOKmhqCXRjKoEvZsFcwwA+6NfJsmSifnjtk8v9zmt+D8N?=
 =?us-ascii?Q?VzWZkuMhmzY6eFuxLD06VxLyC0jwtHzOKp++5hnEMedccM21iY57CPWa1QfU?=
 =?us-ascii?Q?dX32SP9xt2Jvh4diZxi92gqZsp3rQQf6+JFhEd7n6rJ4c8xWHB4+9Xw0l0FY?=
 =?us-ascii?Q?YiChHchjPvjInQ+/g7uWUm5TL07vXHx5Db0dB3pIeHjaY3mJtYhX2iY55y3T?=
 =?us-ascii?Q?S/tVR86EH9CVdZGuTqfuICkbKDNUy8AGsnF6duwZudQ49OU/MlWfdFDvazR2?=
 =?us-ascii?Q?xiePo70h/rhBvS6CpG6LMKsvr6740eRYVTbwmGW5HtWY1Clg0k8RtnnwSi4E?=
 =?us-ascii?Q?HlAtB9WhdF7380AT5PliGV2b2UhfgeGWvnrpmB69ziUg2mOWaWrUvTW79MW/?=
 =?us-ascii?Q?rAkHthHKkTxqXvfqiIusyV054UUJeEOYB5AIa4bTPjgSbFay71Ybj+UN3N6v?=
 =?us-ascii?Q?LSl2jpPbGJbzmnje9EfEIbjwDT5utoGjnzhjnq38clV1s7nbI3ad3nfqjBGa?=
 =?us-ascii?Q?3zWTQ159qnwf69R0cz9NCcQXgu7Uez6nZsCb3vL2n6gv7G802IdfL3V9w1a7?=
 =?us-ascii?Q?Km1ATvtYBWyQItx2vV/9HNgFfuoPfnluIx4GCAQdedFc+v6jo/2f/xbokdh1?=
 =?us-ascii?Q?BPoK5f8XAd4ChMx05snOxqEgMyrQzne2y3JNmu4/qTMn43Eg+wdUZXF3xwdF?=
 =?us-ascii?Q?EMXyx4Dao9JdpDwDdwdIePTGOi3qNYvU9Vq8GNG0XcfKf9qOP4vatzo6bYto?=
 =?us-ascii?Q?ETZ+zGowVIq5p9PW64QC44DzikkOZB2ExMcOpJrUNOpTJEdz8kWvU6X+UkaF?=
 =?us-ascii?Q?WAeau821z9xcZ7kcwbff4zPNesxnkCf1NywWfK/5Zrwm390pq4M6Z31KvdrK?=
 =?us-ascii?Q?FTbHLcZNp2qziAY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6345.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aEfNXQyODCzsLPlfZUOlNj8PyapbyfT/SptzME2ExO+ol8khnz29QiYeIhuG?=
 =?us-ascii?Q?lwBkpdgWpTJjO2fYKnYqHi3JzpZ39pI2N9DDSv7KKj/F2mhiChlrNfCiPJfj?=
 =?us-ascii?Q?Hcg0J9M6eCA7OmW5Q0G2W/XPQR6Kcdgu2bJsnqdcwCe4wKF3RUek+i9qaj+u?=
 =?us-ascii?Q?DtCon9dYdnfGPFlvzdDwgapfQybsaY7LcqPsgJS0qjaWtLd8/wabQeEFVtHI?=
 =?us-ascii?Q?p9hO1XJJe1fDfzb6fWeGxPxVncJVkjyr9HWcQWu+BWP2uIk+bOweKBHp8MF9?=
 =?us-ascii?Q?CgjA+uaSWw+NrexZgIr6pH6hf74f1IzMqOwzURXSPOwRcwlsnMxJWM6Nzz/s?=
 =?us-ascii?Q?RSH4CtqCYx804C0BebC5a8mwyMT4RMo1NfIPjo1qeLTfo2fWCXgFIoO03f1r?=
 =?us-ascii?Q?cfZuSQZggHxtDPKKu7krfDRon76gT3lggMsG5bbQByTNoOnNtwtGSvrRxnIB?=
 =?us-ascii?Q?gZcFC4eBEt1CdAtomGXTNwYmpRFENHsCHujqBstk4yhLygV3Nh+P37Joj5+F?=
 =?us-ascii?Q?kBBKSBXaRhrdRRy3N71DF7xNKgLtKucSy2WSo1w7geskM1nnHqdlzeyqHJEH?=
 =?us-ascii?Q?ZnMjGoi5hrUx08uSJC9CrHacUdu49vvBeV2aVxcp2Ri841D1nDdlGM90C9Dh?=
 =?us-ascii?Q?sElsiOjmCXIOEVJ6c2HQbTtlj+B241BB24QO4OUKQLhzsiK83WH4jiDW2Wlc?=
 =?us-ascii?Q?JObGdi8xhPNp7XO+lud6rEUs1eds0xMuU7vFNi9Gw2nmrH8SH6gmqbGjpaKt?=
 =?us-ascii?Q?R5OvbJbn2TRa8ADfF3vWJXCxWKTZDmwhdtgBtxKdjL3nizyUkNKhLIwl+zMt?=
 =?us-ascii?Q?6MCVow1yBxlTLS5T3CEFxxbkHQQNUKD8PKwQllFAAWnH3NkOhr9ylM+EvKV8?=
 =?us-ascii?Q?EYBL5kVJaoYbCkFerVlFhtgnSBTTVfPj7+bzk1fWdTjtWx0u+FZLHRuDTuTx?=
 =?us-ascii?Q?JykMWNrGsgfvFKPC0VAAp+aK0QCSHasbTVFr3Ji22h8tnWlks1yS3T/4Tld3?=
 =?us-ascii?Q?vlI9P2/57b1mr9nDC4iX9cw1Fg/MXne2IvEQ6F5sxbNggfgtsRRNJFSQ1jHX?=
 =?us-ascii?Q?HKBahn27akbvAkZvWiqaJxOw5YKVkX4iyS1L668q7cLwrMoDbPprI1KV/YSC?=
 =?us-ascii?Q?oKQGsFLKqpYeRAxsN46P+PQRQ+T0uoVIJnFOuxxNUWkNbIibRzjfGqtsmNFT?=
 =?us-ascii?Q?Zq486Z0ZJRg8LDg0PvNlIXlMrRr6U5OrqEHWL+jw2FHUt2rDady2I1II5p6N?=
 =?us-ascii?Q?dM/Uu6sjx0RO4eRs2OtX6eCY83jZLqw+83/sGk606p8dSh4AZ47g/Yk2w9r4?=
 =?us-ascii?Q?Hf1fYcGRd+IX8aEFFIc8R7bI9KnaYNJ0LZS3I1qq1+9TjugOqZknHt76FzwS?=
 =?us-ascii?Q?rEmtfaLjsAsPSK4K/5Lz5yn0nqNZYaFAOReFj22N/UuzfaQznWlMNSkHIHnd?=
 =?us-ascii?Q?ImJCAfLsJ6VS0ckuAydlqXUCy39/ecPC31CgDPuCUvaEmCnS0b6e2UVjZLxB?=
 =?us-ascii?Q?8kSpbRhCmaVOX5v4mkitUbjN9HhCWNu4jzJRZdinmPPh0R1u38JHoDuU9F+A?=
 =?us-ascii?Q?ucny5VQw9n39U60tdvg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB63452616CEE6C924FF8DD702FA07ACY5PR12MB6345namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6345.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a02d9eff-1e9d-420d-7ee3-08dde964eb6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 14:36:21.2084 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s8KqHMC8j0f/+qu7fzSigaD/ka+uwCtKVKZyJt81wE0O/ECTZ0BLlxiMIgjK1gf6+C+kGrL3IK2/dhJL9aV9Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6341
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

--_000_CY5PR12MB63452616CEE6C924FF8DD702FA07ACY5PR12MB6345namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

+ @Gande, Shravan kumar<mailto:Shravankumar.Gande@amd.com>

Hi Shravan,

Could you please help review the code at your convenience?


Regards,

Liu, Xiang

________________________________
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Tuesday, August 19, 2025 1:25 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; =
Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Introduce VF critical region check for RAS=
 poison injection

The SRIOV guest send requet to host to check whether the poison
injection address is in VF critical region or not via mabox.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 55 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  5 ++
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c       | 14 ++++++
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h       |  2 +
 5 files changed, 79 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 13f0cdeb59c4..3328ab63376b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -828,11 +828,14 @@ static void amdgpu_virt_init_ras(struct amdgpu_device=
 *adev)
 {
         ratelimit_state_init(&adev->virt.ras.ras_error_cnt_rs, 5 * HZ, 1);
         ratelimit_state_init(&adev->virt.ras.ras_cper_dump_rs, 5 * HZ, 1);
+       ratelimit_state_init(&adev->virt.ras.ras_chk_criti_rs, 5 * HZ, 1);

         ratelimit_set_flags(&adev->virt.ras.ras_error_cnt_rs,
                             RATELIMIT_MSG_ON_RELEASE);
         ratelimit_set_flags(&adev->virt.ras.ras_cper_dump_rs,
                             RATELIMIT_MSG_ON_RELEASE);
+       ratelimit_set_flags(&adev->virt.ras.ras_chk_criti_rs,
+                           RATELIMIT_MSG_ON_RELEASE);

         mutex_init(&adev->virt.ras.ras_telemetry_mutex);

@@ -1501,3 +1504,55 @@ void amdgpu_virt_request_bad_pages(struct amdgpu_dev=
ice *adev)
         if (virt->ops && virt->ops->req_bad_pages)
                 virt->ops->req_bad_pages(adev);
 }
+
+static int amdgpu_virt_cache_chk_criti_hit(struct amdgpu_device *adev,
+                                          struct amdsriov_ras_telemetry *h=
ost_telemetry,
+                                          bool *hit)
+{
+       struct amd_sriov_ras_chk_criti *tmp =3D NULL;
+       uint32_t checksum, used_size;
+
+       checksum =3D host_telemetry->header.checksum;
+       used_size =3D host_telemetry->header.used_size;
+
+       if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
+               return 0;
+
+       tmp =3D kmemdup(&host_telemetry->body.chk_criti, used_size, GFP_KER=
NEL);
+       if (!tmp)
+               return -ENOMEM;
+
+       if (checksum !=3D amd_sriov_msg_checksum(tmp, used_size, 0, 0))
+               goto out;
+
+       if (hit)
+               *hit =3D tmp->hit ? true : false;
+
+out:
+       kfree(tmp);
+
+       return 0;
+}
+
+int amdgpu_virt_check_vf_critical_region(struct amdgpu_device *adev, u64 a=
ddr, bool *hit)
+{
+       struct amdgpu_virt *virt =3D &adev->virt;
+       int r =3D -EPERM;
+
+       if (!virt->ops || !virt->ops->req_ras_chk_criti)
+               return -EOPNOTSUPP;
+
+       /* Host allows 15 ras telemetry requests per 60 seconds. Afterwhich=
, the Host
+        * will ignore incoming guest messages. Ratelimit the guest message=
s to
+        * prevent guest self DOS.
+        */
+       if (__ratelimit(&virt->ras.ras_chk_criti_rs)) {
+               mutex_lock(&virt->ras.ras_telemetry_mutex);
+               if (!virt->ops->req_ras_chk_criti(adev, addr))
+                       r =3D amdgpu_virt_cache_chk_criti_hit(
+                               adev, virt->fw_reserve.ras_telemetry, hit);
+               mutex_unlock(&virt->ras.ras_telemetry_mutex);
+       }
+
+       return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h
index 3da3ebb1d9a1..6ca83abd7a4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -98,6 +98,7 @@ struct amdgpu_virt_ops {
         int (*req_ras_err_count)(struct amdgpu_device *adev);
         int (*req_ras_cper_dump)(struct amdgpu_device *adev, u64 vf_rptr);
         int (*req_bad_pages)(struct amdgpu_device *adev);
+       int (*req_ras_chk_criti)(struct amdgpu_device *adev, u64 addr);
 };

 /*
@@ -252,6 +253,7 @@ struct amdgpu_virt_ras_err_handler_data {
 struct amdgpu_virt_ras {
         struct ratelimit_state ras_error_cnt_rs;
         struct ratelimit_state ras_cper_dump_rs;
+       struct ratelimit_state ras_chk_criti_rs;
         struct mutex ras_telemetry_mutex;
         uint64_t cper_rptr;
 };
@@ -447,4 +449,5 @@ int amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_=
device *adev);
 bool amdgpu_virt_ras_telemetry_block_en(struct amdgpu_device *adev,
                                         enum amdgpu_ras_block block);
 void amdgpu_virt_request_bad_pages(struct amdgpu_device *adev);
+int amdgpu_virt_check_vf_critical_region(struct amdgpu_device *adev, u64 a=
ddr, bool *hit);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/=
amd/amdgpu/amdgv_sriovmsg.h
index 33edad1f9dcd..3a79ed7d8031 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -405,12 +405,17 @@ struct amd_sriov_ras_cper_dump {
         uint32_t buf[];
 };

+struct amd_sriov_ras_chk_criti {
+       uint32_t hit;
+};
+
 struct amdsriov_ras_telemetry {
         struct amd_sriov_ras_telemetry_header header;

         union {
                 struct amd_sriov_ras_telemetry_error_count error_count;
                 struct amd_sriov_ras_cper_dump cper_dump;
+               struct amd_sriov_ras_chk_criti chk_criti;
         } body;
 };

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.c
index f6d8597452ed..00c5db336c0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -205,6 +205,9 @@ static int xgpu_nv_send_access_requests_with_param(stru=
ct amdgpu_device *adev,
         case IDH_REQ_RAS_BAD_PAGES:
                 event =3D IDH_RAS_BAD_PAGES_READY;
                 break;
+       case IDH_REQ_RAS_CHK_CRITI:
+               event =3D IDH_REQ_RAS_CHK_CRITI_READY;
+               break;
         default:
                 break;
         }
@@ -535,6 +538,16 @@ static int xgpu_nv_req_ras_bad_pages(struct amdgpu_dev=
ice *adev)
         return xgpu_nv_send_access_requests(adev, IDH_REQ_RAS_BAD_PAGES);
 }

+static int xgpu_nv_check_vf_critical_region(struct amdgpu_device *adev, u6=
4 addr)
+{
+       uint32_t addr_hi, addr_lo;
+
+       addr_hi =3D (uint32_t)(addr >> 32);
+       addr_lo =3D (uint32_t)(addr & 0xFFFFFFFF);
+       return xgpu_nv_send_access_requests_with_param(
+               adev, IDH_REQ_RAS_CHK_CRITI, addr_hi, addr_lo, 0);
+}
+
 const struct amdgpu_virt_ops xgpu_nv_virt_ops =3D {
         .req_full_gpu   =3D xgpu_nv_request_full_gpu_access,
         .rel_full_gpu   =3D xgpu_nv_release_full_gpu_access,
@@ -548,4 +561,5 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops =3D {
         .req_ras_err_count =3D xgpu_nv_req_ras_err_count,
         .req_ras_cper_dump =3D xgpu_nv_req_ras_cper_dump,
         .req_bad_pages =3D xgpu_nv_req_ras_bad_pages,
+       .req_ras_chk_criti =3D xgpu_nv_check_vf_critical_region
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.h
index 5808689562cc..c1083e5e41e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -43,6 +43,7 @@ enum idh_request {
         IDH_REQ_RAS_ERROR_COUNT =3D 203,
         IDH_REQ_RAS_CPER_DUMP =3D 204,
         IDH_REQ_RAS_BAD_PAGES =3D 205,
+       IDH_REQ_RAS_CHK_CRITI =3D 206
 };

 enum idh_event {
@@ -62,6 +63,7 @@ enum idh_event {
         IDH_RAS_BAD_PAGES_READY =3D 15,
         IDH_RAS_BAD_PAGES_NOTIFICATION =3D 16,
         IDH_UNRECOV_ERR_NOTIFICATION =3D 17,
+       IDH_REQ_RAS_CHK_CRITI_READY =3D 18,

         IDH_TEXT_MESSAGE =3D 255,
 };
--
2.34.1


--_000_CY5PR12MB63452616CEE6C924FF8DD702FA07ACY5PR12MB6345namp_
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
<div style=3D"background-color: rgb(255, 255, 255); margin: 0px;" class=3D"=
elementToProof">
<div style=3D"text-align: left; text-indent: 0px; margin-left: 5pt; font-fa=
mily: Calibri; font-size: 10pt; color: rgb(0, 0, 255);" class=3D"elementToP=
roof">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<div style=3D"text-align: left; font-family: Calibri; font-size: 11pt;" cla=
ss=3D"elementToProof">
<br>
</div>
<div style=3D"text-align: left; text-indent: 0px; font-family: Calibri; fon=
t-size: 11pt;" class=3D"elementToProof">
<span style=3D"color: rgb(36, 36, 36);">+ </span><span style=3D"color: rgb(=
43, 87, 154); background-color: rgb(225, 223, 221);"><a style=3D"margin: 0p=
x;" data-linkindex=3D"1" title=3D"mailto:Shravankumar.Gande@amd.com" class=
=3D"OWAAutoLink" id=3D"OWA76fbee0a-554c-4c21-1a09-23e49b70ceb3" href=3D"mai=
lto:Shravankumar.Gande@amd.com">@Gande,
 Shravan kumar</a></span></div>
</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri; font-size: 11pt; color: rgb=
(36, 36, 36);" class=3D"elementToProof">
&nbsp;</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri; font-size: 11pt; color: rgb=
(36, 36, 36);" class=3D"elementToProof">
Hi Shravan,</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri; font-size: 11pt; color: rgb=
(36, 36, 36);" class=3D"elementToProof">
&nbsp;</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri; font-size: 11pt; color: rgb=
(36, 36, 36);" class=3D"elementToProof">
Could you please help review the code at your convenience?</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<p style=3D"text-align: left; text-indent: 0px; background-color: white; ma=
rgin: 0px;" class=3D"elementToProof">
<span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt=
; color: black;">Regards,</span></p>
<p style=3D"text-align: left; text-indent: 0px; background-color: white; ma=
rgin-top: 0px; margin-bottom: 0px;" class=3D"elementToProof">
<span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt=
; color: rgb(36, 36, 36);">Liu, Xiang</span></p>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liu, Xiang(Dean) &lt;=
Xiang.Liu@amd.com&gt;<br>
<b>Sent:</b> Tuesday, August 19, 2025 1:25 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao=
.Zhou1@amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;; Chai, Thoma=
s &lt;YiPeng.Chai@amd.com&gt;; Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;<b=
r>
<b>Subject:</b> [PATCH 1/2] drm/amdgpu: Introduce VF critical region check =
for RAS poison injection</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The SRIOV guest send requet to host to check wheth=
er the poison<br>
injection address is in VF critical region or not via mabox.<br>
<br>
Signed-off-by: Xiang Liu &lt;xiang.liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c&nbsp;&nbsp;&nbsp; | 55 +++++=
++++++++++++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h&nbsp;&nbsp;&nbsp; |&nbsp; 3 =
++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |&nbsp; 5 ++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; | 14 ++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; |&nbsp; 2 +<br>
&nbsp;5 files changed, 79 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c<br>
index 13f0cdeb59c4..3328ab63376b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
@@ -828,11 +828,14 @@ static void amdgpu_virt_init_ras(struct amdgpu_device=
 *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ratelimit_state_init(&amp;=
adev-&gt;virt.ras.ras_error_cnt_rs, 5 * HZ, 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ratelimit_state_init(&amp;=
adev-&gt;virt.ras.ras_cper_dump_rs, 5 * HZ, 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ratelimit_state_init(&amp;adev-&gt;vi=
rt.ras.ras_chk_criti_rs, 5 * HZ, 1);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ratelimit_set_flags(&amp;a=
dev-&gt;virt.ras.ras_error_cnt_rs,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; RATELIMIT_MSG_ON_RELEASE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ratelimit_set_flags(&amp;a=
dev-&gt;virt.ras.ras_cper_dump_rs,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; RATELIMIT_MSG_ON_RELEASE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ratelimit_set_flags(&amp;adev-&gt;vir=
t.ras.ras_chk_criti_rs,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; RATELIMIT_MSG_ON_RELEASE);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;v=
irt.ras.ras_telemetry_mutex);<br>
&nbsp;<br>
@@ -1501,3 +1504,55 @@ void amdgpu_virt_request_bad_pages(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (virt-&gt;ops &amp;&amp=
; virt-&gt;ops-&gt;req_bad_pages)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; virt-&gt;ops-&gt;req_bad_pages(adev);<br>
&nbsp;}<br>
+<br>
+static int amdgpu_virt_cache_chk_criti_hit(struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; struct amdsriov_ras_telemetry *host_telemetry,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; bool *hit)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_sriov_ras_chk_criti *tmp =
=3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t checksum, used_size;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; checksum =3D host_telemetry-&gt;heade=
r.checksum;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; used_size =3D host_telemetry-&gt;head=
er.used_size;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (used_size &gt; (AMD_SRIOV_RAS_TEL=
EMETRY_SIZE_KB &lt;&lt; 10))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D kmemdup(&amp;host_telemetry-&=
gt;body.chk_criti, used_size, GFP_KERNEL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!tmp)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOMEM;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (checksum !=3D amd_sriov_msg_check=
sum(tmp, used_size, 0, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hit)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *hit =3D tmp-&gt;hit ? true : false;<br>
+<br>
+out:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(tmp);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
+int amdgpu_virt_check_vf_critical_region(struct amdgpu_device *adev, u64 a=
ddr, bool *hit)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_virt *virt =3D &amp;ade=
v-&gt;virt;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D -EPERM;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!virt-&gt;ops || !virt-&gt;ops-&g=
t;req_ras_chk_criti)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EOPNOTSUPP;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Host allows 15 ras telemetry reque=
sts per 60 seconds. Afterwhich, the Host<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * will ignore incoming guest me=
ssages. Ratelimit the guest messages to<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * prevent guest self DOS.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (__ratelimit(&amp;virt-&gt;ras.ras=
_chk_criti_rs)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mutex_lock(&amp;virt-&gt;ras.ras_telemetry_mutex);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!virt-&gt;ops-&gt;req_ras_chk_criti(adev, addr))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vir=
t_cache_chk_criti_hit(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev, virt-&gt;fw_reserve.ras_telemetry, hi=
t);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mutex_unlock(&amp;virt-&gt;ras.ras_telemetry_mutex);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
+}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h<br>
index 3da3ebb1d9a1..6ca83abd7a4f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
@@ -98,6 +98,7 @@ struct amdgpu_virt_ops {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*req_ras_err_count)(s=
truct amdgpu_device *adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*req_ras_cper_dump)(s=
truct amdgpu_device *adev, u64 vf_rptr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*req_bad_pages)(struc=
t amdgpu_device *adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*req_ras_chk_criti)(struct amdgp=
u_device *adev, u64 addr);<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;/*<br>
@@ -252,6 +253,7 @@ struct amdgpu_virt_ras_err_handler_data {<br>
&nbsp;struct amdgpu_virt_ras {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ratelimit_state ras=
_error_cnt_rs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ratelimit_state ras=
_cper_dump_rs;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ratelimit_state ras_chk_criti_=
rs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex ras_telemetry=
_mutex;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t cper_rptr;<br>
&nbsp;};<br>
@@ -447,4 +449,5 @@ int amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_=
device *adev);<br>
&nbsp;bool amdgpu_virt_ras_telemetry_block_en(struct amdgpu_device *adev,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enum amdgpu_ras_block block);<br>
&nbsp;void amdgpu_virt_request_bad_pages(struct amdgpu_device *adev);<br>
+int amdgpu_virt_check_vf_critical_region(struct amdgpu_device *adev, u64 a=
ddr, bool *hit);<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/=
amd/amdgpu/amdgv_sriovmsg.h<br>
index 33edad1f9dcd..3a79ed7d8031 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h<br>
@@ -405,12 +405,17 @@ struct amd_sriov_ras_cper_dump {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t buf[];<br>
&nbsp;};<br>
&nbsp;<br>
+struct amd_sriov_ras_chk_criti {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hit;<br>
+};<br>
+<br>
&nbsp;struct amdsriov_ras_telemetry {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_sriov_ras_telem=
etry_header header;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amd_sriov_ras_telemetry_error_count error_coun=
t;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amd_sriov_ras_cper_dump cper_dump;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct amd_sriov_ras_chk_criti chk_criti;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } body;<br>
&nbsp;};<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.c<br>
index f6d8597452ed..00c5db336c0e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c<br>
@@ -205,6 +205,9 @@ static int xgpu_nv_send_access_requests_with_param(stru=
ct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IDH_REQ_RAS_BAD_PAGES=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; event =3D IDH_RAS_BAD_PAGES_READY;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IDH_REQ_RAS_CHK_CRITI:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; event =3D IDH_REQ_RAS_CHK_CRITI_READY;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -535,6 +538,16 @@ static int xgpu_nv_req_ras_bad_pages(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return xgpu_nv_send_access=
_requests(adev, IDH_REQ_RAS_BAD_PAGES);<br>
&nbsp;}<br>
&nbsp;<br>
+static int xgpu_nv_check_vf_critical_region(struct amdgpu_device *adev, u6=
4 addr)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t addr_hi, addr_lo;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr_hi =3D (uint32_t)(addr &gt;&gt; =
32);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr_lo =3D (uint32_t)(addr &amp; 0xF=
FFFFFFF);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return xgpu_nv_send_access_requests_w=
ith_param(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev, IDH_REQ_RAS_CHK_CRITI, addr_hi, addr_lo, 0);<br>
+}<br>
+<br>
&nbsp;const struct amdgpu_virt_ops xgpu_nv_virt_ops =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .req_full_gpu&nbsp;&nbsp; =
=3D xgpu_nv_request_full_gpu_access,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .rel_full_gpu&nbsp;&nbsp; =
=3D xgpu_nv_release_full_gpu_access,<br>
@@ -548,4 +561,5 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .req_ras_err_count =3D xgp=
u_nv_req_ras_err_count,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .req_ras_cper_dump =3D xgp=
u_nv_req_ras_cper_dump,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .req_bad_pages =3D xgpu_nv=
_req_ras_bad_pages,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .req_ras_chk_criti =3D xgpu_nv_check_=
vf_critical_region<br>
&nbsp;};<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.h<br>
index 5808689562cc..c1083e5e41e0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h<br>
@@ -43,6 +43,7 @@ enum idh_request {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IDH_REQ_RAS_ERROR_COUNT =
=3D 203,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IDH_REQ_RAS_CPER_DUMP =3D =
204,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IDH_REQ_RAS_BAD_PAGES =3D =
205,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IDH_REQ_RAS_CHK_CRITI =3D 206<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;enum idh_event {<br>
@@ -62,6 +63,7 @@ enum idh_event {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IDH_RAS_BAD_PAGES_READY =
=3D 15,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IDH_RAS_BAD_PAGES_NOTIFICA=
TION =3D 16,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IDH_UNRECOV_ERR_NOTIFICATI=
ON =3D 17,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IDH_REQ_RAS_CHK_CRITI_READY =3D 18,<b=
r>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IDH_TEXT_MESSAGE =3D 255,<=
br>
&nbsp;};<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CY5PR12MB63452616CEE6C924FF8DD702FA07ACY5PR12MB6345namp_--
