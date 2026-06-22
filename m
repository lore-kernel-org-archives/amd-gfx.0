Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5979CDB475
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58F2910E512;
	Mon, 22 Jun 2026 08:08:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lOFhcj4a";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012055.outbound.protection.outlook.com [52.101.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5825C10E512
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:08:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4JA9YCI/trMwy0DCr4RjfWkARHdb0XbNbcKbRi1HHsovGfrq7AnTT7sMuBtwufWv9L9PR+MAkD/OYYLOXOhF1MSt4/0BM5DcxXeQH9ADlNRcbJXepSwTLXT8qUO2sWlXZKnHOOFiGlghRYoFUAIsTj3K0wPMCGq3FVgErs+ggMyZgtnEQtbgj0o4pybmHykEbOzcdRgb/OvU4xNNdOdhQ4LVWdVluvD2fxrnGVjq5Jt/Fsr1vk+3o7c6mw/5wCIJvm3C3Bd0aChxw6cUAmC7W1ARZL1wt5FCRR+X4bKMA/i4UiDfoquRBmTdXL9k7S9VKhJrjLYdhzAkVC+YXE/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHIR8jT43MgVpztVO5Q5juPsEbR334nJRB78awqfFS4=;
 b=mWjkg3Knu6iGROHdRohkmw65RqYJwyoEnuXf3mX9ciFM6LqcA065IqVOkkrE7BgEHQQIeMVXidPcRaxki6V0gYpRRnBfVZjlwQ2euEwfdn9F2KqTBR4tWzgH4/yE7RbS15IMj5PpbjYZxuXknK/hM5lBPgRIz64O3JzP+rwh3A/XhfCxQvJqgcjjTYV94MvHgmwsOBRD59bOUuY/kf9tyfrtWW+VQDHKmdD3Mg/upZNChFTQBIS+UsFMNUcObc/hUhOVL7hkcNChlnyMxD+ME+3UYgWEgLuIglBOP4bKJtk4ZD2JLDb3yNc5i4LKq7wyYlSMWPNGF3O0enzpuPbHWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHIR8jT43MgVpztVO5Q5juPsEbR334nJRB78awqfFS4=;
 b=lOFhcj4acuGyq46sp0yh+xVEsqiH5qFAdaUgv8WaNZB4ufu7GZPma3RhF/Sjz/gFt24YbNykBj95sELvBC6pyMeEtippNgfNxd8aCtfpq27o0ekKPdoT3nsmgX7/xybfosq+6J2s3Jz5Cf8T3u2SRGbTvTEQ29+dgfdM/7auyaM=
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6)
 by IA0PPF84D37DD5C.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 08:08:24 +0000
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::9e49:aeba:9265:f46e]) by SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::9e49:aeba:9265:f46e%3]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 08:08:24 +0000
From: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: Re: [PATCH v1 1/2] drm/amd/ras: add set_debug_mode function for uniras
Thread-Topic: [PATCH v1 1/2] drm/amd/ras: add set_debug_mode function for
 uniras
Thread-Index: AQHdAgKsRbAmgwhyvEy6GSzIIRERjLZKM/kAgAAD1A4=
Date: Mon, 22 Jun 2026 08:08:24 +0000
Message-ID: <SJ0PR12MB69670E557C61C779C12A6FD59DEF2@SJ0PR12MB6967.namprd12.prod.outlook.com>
References: <cover.1782103766.git.cesun102@amd.com>
 <eea07a6f8d3a846baeea3e6d27f4d3d092fc643f.1782103766.git.cesun102@amd.com>
 <BN9PR12MB5257AB1AD7FC9FF16D51891FFCEF2@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257AB1AD7FC9FF16D51891FFCEF2@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-22T08:08:23.702Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6967:EE_|IA0PPF84D37DD5C:EE_
x-ms-office365-filtering-correlation-id: 458bfc6e-b173-492c-758a-08ded0356ed7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|38070700021|18002099003|22082099003|8096899003|6133799003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: 02VMLcKCv0yKigCjJJbdJBcYiQ927U490Gdub1ULH9rav8dejlhJR6yg+i5NO73eUaUbA+jKI9rH1uXS9NobLKUyP3ksPDXXyw/9VTQD5bLbvVZpUFyr2IUgw3bLryK5ip5YP0VuEwg1h03mGSIXmTCUcqXwUvvuHBBqmaG7UQCNee79T6apr6omQ31Rl0jDgBeox9Fmtk/NySUEmbVesLlPstLgOcXgBYfH638KN+uNf/CqJNDIualF1gkFkIjuRCCyXSI1NJga5qnVu+tz/k/qb3Mx9kNUT35HT1GSge4J84HsOdGaETA5pMMJ+gZDY95636gXmAG/7PQWZBAyLYGJK41UEn7DUWZ0rv1+YM+LeTpKZxTZ1H6dFL/NYwVVDLXIJvnK/YXoRlj4Wq2QqHjkfeBLk14GRxqpD6L4yrwphs61Xslcloiku6rNR4eCaIgg4I6bDhjf4aeFAXCdn+f/A9YfUM6+CTEX7BJiVi+yB+xBpSGjsH2g5aM40YgXk1zgzZry0+VvTSS4fc1kqV5tqn0KiE8tscCddC+9Tbm8xo+BZ1Hmu2jLGx6cbxuCQWGrt3PbHfMIjOS0Y4X+PcAzghsyWC50hr0S6I+QFOUXux8aa54ug09AJtT7LYuZ2Xk7txHi1/ZD68AV+k4fTCCxxKhPEE04cVpjqBQN+P8sZBi6J2acOTvVkecZmJoWoTAiRohxSMbWvjNuMbPKwPTFD9Q7GUDGOJjo5/Jtb5w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6967.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(18002099003)(22082099003)(8096899003)(6133799003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U+SxO8Qcbtsj6r1Pnrl1KR8v0CJ9Mjjg4/2a5reznjL3zXeiyZXpZzVuenVt?=
 =?us-ascii?Q?n3dGNqzSxoKW2Ewc3eV6sWvGf+UFiWCAttldFJ5Aq5KUrGUNUR70KKrHAcW5?=
 =?us-ascii?Q?m97qy3CPxCG/bqS09GwAm6GunhHY+zvg0srUd0PcJAwP21P97Q1dl8eD7bXn?=
 =?us-ascii?Q?ZI5fMCLc25D1+NaEaWNx7JSAHXUNKGKeue9CNH0LLM9UhsEE4zfmFSlg3ifZ?=
 =?us-ascii?Q?ODM3v4uFUFAQnXHxcw157BGhLrUjef1W9DPdxuLSdyaNd4xWnPQPOnKJaFhI?=
 =?us-ascii?Q?svbghoW8QAuOwe4Fq8HOghg0Z8axD2VQYzI63PpwjZ/XaLIMhUWe/OWJPZ5s?=
 =?us-ascii?Q?bEalew8PPr88Z9RRnmBUCg/2f1c5TWqw8bfgen1fENde+Oc4vTKnEzLbWfCd?=
 =?us-ascii?Q?y243IpRaMCJ4HNvhBxsSb+oBfI6YtT3osDvlbW3hk+0oEryAKty/kK5FoJz/?=
 =?us-ascii?Q?T9utrYhxalJNEx28QgrFah4FV0fK/Zc89tWL2hg8IfHeUNtXD86SQaoQoR3z?=
 =?us-ascii?Q?H7kWNKBfW9myuJxc6KeIWDt3LM58Yswh0mFfbhgr+bZ+lpwaXul/PHPR94Rw?=
 =?us-ascii?Q?ms8Zi7AaaZNTdUqjpOe78PU2od03uDlKJFUqkaxqAkmCVC/OZ7HiUr41+bKY?=
 =?us-ascii?Q?zFJpYWg2XaZZzlacGU6uhv4yBqeaEbAWlUugmvV8YiR0Z+/n18pXOp3l71vF?=
 =?us-ascii?Q?fFnFUV6HMldsOMfgB18965veispoaGcZdwkvfmr9Xf71E/FHdFntKuledReR?=
 =?us-ascii?Q?B2sQn7A1isG/sQyiJ7Jhc+aaITy5vx8y5ADb7uYdn6O3NJ4oKeIK2nyc1zr8?=
 =?us-ascii?Q?PNuNq1hcDs+hK1GjpGeJPELhFyELeLIRQzicdnEcAB0So6qE/fx8/DUo2TAX?=
 =?us-ascii?Q?yduTjtbz10YXF+w7lPm0T2E6Wo2SrmvRuS9YU4Z0Xxry3iYr4naBXCiVfYYH?=
 =?us-ascii?Q?ZIU7m/CRrV6wmyBVPXMjODfjFD5nYpyeYF3ckqvAUZoO3FAqlEt0Rp8puROV?=
 =?us-ascii?Q?MWXxW29emRFPGrhVtbXXm7zB9uUI4ekRR1bh+UhCQXmKfz7JiPDgPCHjbT5P?=
 =?us-ascii?Q?GYqFrZSDwNPfnohtDFWTdyjJ7vOamBlaXouTpt8is50SblyQ1agqke4WeGre?=
 =?us-ascii?Q?zMm1f+WtdHtBs7r9avcpSFzb0RGqaEaajtWfxwO8sGpkXGFo4kTJ7hA36XbL?=
 =?us-ascii?Q?4xbUV/YEJBM4NEOhP3OfucaIPDODUGtr038oTry7jcaqtnQsq5hDlsN/obPl?=
 =?us-ascii?Q?3UGPhWyBEAwkQXSdDXz2Lvc/1C8sTUkOu1o8yj9KUGULSIp7JhqK8n3oguVy?=
 =?us-ascii?Q?9nZ/KjSJzXvosKtvDoNdFTcCfOUV8xcKI2Gxzu6TEyvf/qBfFRGHowAukYVf?=
 =?us-ascii?Q?RhtjzC9tVNA87wfRgPMBbnR2yQ1qDLfmx9GtE7luwj6dltCEy0MoEnyBlxIK?=
 =?us-ascii?Q?CztvBRWPXoesLUxL+orIvCuKJsOyQZxj8/S1Q1TIyWLkTv0joG21a5vnOxjc?=
 =?us-ascii?Q?5GwUuN16HPb+KBC4xYs70kKKVwujSPYqC75YkKlVKxEjj79/KX95mj1K6h60?=
 =?us-ascii?Q?Cw4uNl/M8Fgiv7SVLcfRDifs/Hu1L2qyRmnPN7p8ibBh+K9idrFTQBgaLCe6?=
 =?us-ascii?Q?CXNzyVpnmyGfyWME8FFxLFZQwN6qkqKWuOyIG/e/S8S2+oTkgYJguxeCw7Gk?=
 =?us-ascii?Q?4kIHlgdXWmRqYcZXH+y3Nnp5eO/dTSxLC7JK5WmvcSxigdO1?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB69670E557C61C779C12A6FD59DEF2SJ0PR12MB6967namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6967.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 458bfc6e-b173-492c-758a-08ded0356ed7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 08:08:24.3865 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AD0nxn4ixZ9T8UabWfajsBvgtS6qCyJo5Pw2k0FpLXedGSCwLiQeszcKi4DYkiCZuQzIJXHJmBjfN+AT4sbewA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF84D37DD5C
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

--_000_SJ0PR12MB69670E557C61C779C12A6FD59DEF2SJ0PR12MB6967namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Hi Hawking,

Thanks for the review,I will revise ras_mp1_set_debug_mode with below fix i=
n v2 patch set:
1. Add validation for mp1->ip_func and mp1->ip_func->set_debug_mode
2. Return -ENOTSUPP error code if the callback is missing


Regards,
Sun,Ce
________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Monday, June 22, 2026 3:51 PM
To: Sun, Ce(Overlord) <Ce.Sun@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Sun=
, Ce(Overlord) <Ce.Sun@amd.com>
Subject: RE: [PATCH v1 1/2] drm/amd/ras: add set_debug_mode function for un=
iras

AMD General

+int ras_mp1_set_debug_mode(struct ras_core_context *ras_core,bool
+enable) {
+       struct ras_mp1 *mp1 =3D &ras_core->ras_mp1;
+
+       return mp1->ip_func->set_debug_mode(ras_core, enable); }
+

Please check the availability of set_debug_mode call as it is not a mandato=
ry function for all generations

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ce Sun
Sent: Monday, June 22, 2026 12:50 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH v1 1/2] drm/amd/ras: add set_debug_mode function for uniras

add set_debug_mode function for uniras

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 10 ++++++++++  drivers/=
gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h |  1 +
 .../drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c   | 14 ++++++++++++++
 drivers/gpu/drm/amd/ras/rascore/ras.h            |  3 +++
 drivers/gpu/drm/amd/ras/rascore/ras_core.c       |  5 +++++
 drivers/gpu/drm/amd/ras/rascore/ras_mp1.c        | 16 +++++++++++++++-
 drivers/gpu/drm/amd/ras/rascore/ras_mp1.h        |  3 +++
 drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c  | 13 +++++++++++++
 8 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index f627a97797ed..2ce7b88544c3 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -773,3 +773,13 @@ int amdgpu_ras_mgr_lookup_bad_pages_in_a_row(struct am=
dgpu_device *adev,
        return ras_core_convert_soc_pa_to_cur_nps_pages(ras_mgr->ras_core,
                        addr, nps_page_addr, max_page_count);  }
+
+int amdgpu_ras_mgr_set_debug_mode(struct amdgpu_device *adev, bool
+enable) {
+       struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_context(adev)=
;
+
+       if (!ras_mgr || !ras_mgr->ras_core || !ras_mgr->ras_is_ready)
+               return false;
+
+       return ras_core_set_debug_mode(ras_mgr->ras_core, enable); }
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
index 4f44a917d48b..a757ec15125e 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
@@ -84,4 +84,5 @@ int amdgpu_ras_mgr_pre_reset(struct amdgpu_device *adev);=
  int amdgpu_ras_mgr_post_reset(struct amdgpu_device *adev);  int amdgpu_ra=
s_mgr_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
                uint64_t addr, uint64_t *nps_page_addr, uint32_t max_page_c=
ount);
+int amdgpu_ras_mgr_set_debug_mode(struct amdgpu_device *adev, bool
+enable);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c b/drive=
rs/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
index 2098f24d4940..ee59184f7eee 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
@@ -24,6 +24,7 @@
 #include "amdgpu_smu.h"
 #include "amdgpu_reset.h"
 #include "amdgpu_ras_mp1_v13_0.h"
+#include "smu13_driver_if_v13_0_6.h"

 #define RAS_MP1_MSG_QueryValidMcaCeCount  0x3A
 #define RAS_MP1_MSG_McaBankCeDumpDW       0x3B
@@ -131,10 +132,23 @@ static int mp1_v13_0_get_ras_enabled_mask(struct ras_=
core_context *ras_core,
        return ret;
 }

+static int mp1_v13_0_set_debug_mode(struct ras_core_context *ras_core,
+bool enable) {
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->de=
v;
+       int ret;
+       u32 smu_msg =3D SMU_MSG_ClearMcaOnRead;
+
+       ret =3D amdgpu_smu_ras_send_msg(adev, smu_msg,
+                                     enable ? 0 : ClearMcaOnRead_UE_FLAG_M=
ASK | ClearMcaOnRead_CE_POLL_MASK,
+                                     NULL);
+       return ret;
+}
+
 const struct ras_mp1_sys_func amdgpu_ras_mp1_sys_func_v13_0 =3D {
        .mp1_get_valid_bank_count =3D mp1_v13_0_get_valid_bank_count,
        .mp1_dump_valid_bank =3D mp1_v13_0_dump_valid_bank,
        .mp1_send_eeprom_msg =3D mp1_v13_0_eeprom_send_msg,
        .mp1_get_ras_enabled_mask =3D mp1_v13_0_get_ras_enabled_mask,
+       .mp1_set_debug_mode =3D mp1_v13_0_set_debug_mode,
 };

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ra=
s/rascore/ras.h
index 5869bad978b0..371d1061d8f4 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -167,6 +167,7 @@ struct ras_mp1_sys_func {
                        enum ras_fw_eeprom_cmd index, uint32_t param, uint3=
2_t *read_arg);
        int (*mp1_get_ras_enabled_mask)(struct ras_core_context *ras_core,
                        uint64_t *enabled_mask);
+       int (*mp1_set_debug_mode)(struct ras_core_context *ras_core, bool
+enable);
 };

 struct ras_eeprom_sys_func {
@@ -400,4 +401,6 @@ int ras_core_get_device_system_info(struct ras_core_con=
text *ras_core,  int ras_core_convert_soc_pa_to_cur_nps_pages(struct ras_co=
re_context *ras_core,
                uint64_t soc_pa, uint64_t *page_pfn, uint32_t max_pages);  =
int ras_core_check_address_sanity(struct ras_core_context *ras_core, uint64=
_t addr);
+
+int ras_core_set_debug_mode(struct ras_core_context *ras_core,bool
+enable);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/a=
md/ras/rascore/ras_core.c
index 61d100b074b9..08e17a83ad5b 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -151,6 +151,11 @@ bool ras_core_gpu_is_rma(struct ras_core_context *ras_=
core)
        return ras_core->is_rma;
 }

+int ras_core_set_debug_mode(struct ras_core_context *ras_core, bool
+enable) {
+       return ras_mp1_set_debug_mode(ras_core, enable); }
+
 static int ras_core_seqno_fifo_write(struct ras_core_context *ras_core,
                enum ras_seqno_fifo fifo_type, uint64_t seqno)  { diff --gi=
t a/drivers/gpu/drm/amd/ras/rascore/ras_mp1.c b/drivers/gpu/drm/amd/ras/ras=
core/ras_mp1.c
index f3321df85021..15b605a23aa5 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_mp1.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_mp1.c
@@ -59,9 +59,17 @@ int ras_mp1_dump_bank(struct ras_core_context *ras_core,
        return mp1->ip_func->dump_valid_bank(ras_core, type, idx, reg_idx, =
val);  }

+int ras_mp1_set_debug_mode(struct ras_core_context *ras_core,bool
+enable) {
+       struct ras_mp1 *mp1 =3D &ras_core->ras_mp1;
+
+       return mp1->ip_func->set_debug_mode(ras_core, enable); }
+
 int ras_mp1_hw_init(struct ras_core_context *ras_core)  {
        struct ras_mp1 *mp1 =3D &ras_core->ras_mp1;
+       int ret =3D 0;

        mp1->mp1_ip_version =3D ras_core->config->mp1_ip_version;
        mp1->sys_func =3D ras_core->config->mp1_cfg.mp1_sys_fn;
@@ -71,8 +79,14 @@ int ras_mp1_hw_init(struct ras_core_context *ras_core)
        }

        mp1->ip_func =3D ras_mp1_get_ip_funcs(ras_core, mp1->mp1_ip_version=
);
+       if (!mp1->ip_func)
+               return -EINVAL;
+
+       ret =3D ras_mp1_set_debug_mode(ras_core, false);
+       if (ret)
+               return -EINVAL;

-       return mp1->ip_func ? RAS_CORE_OK : -EINVAL;
+       return ret;
 }

 int ras_mp1_hw_fini(struct ras_core_context *ras_core) diff --git a/driver=
s/gpu/drm/amd/ras/rascore/ras_mp1.h b/drivers/gpu/drm/amd/ras/rascore/ras_m=
p1.h
index de1d08286f41..0b618f6b8b9e 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_mp1.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_mp1.h
@@ -31,6 +31,7 @@ struct ras_mp1_ip_func {
                        enum ras_err_type type, u32 *count);
        int (*dump_valid_bank)(struct ras_core_context *ras_core,
                enum ras_err_type type, u32 idx, u32 reg_idx, u64 *val);
+       int (*set_debug_mode)(struct ras_core_context *ras_core,bool enable=
);
 };

 struct ras_mp1 {
@@ -47,4 +48,6 @@ int ras_mp1_get_bank_count(struct ras_core_context *ras_c=
ore,

 int ras_mp1_dump_bank(struct ras_core_context *ras_core,
                u32 ecc_type, u32 idx, u32 reg_idx, u64 *val);
+
+int ras_mp1_set_debug_mode(struct ras_core_context *ras_core,bool
+enable);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c b/drivers/gpu/=
drm/amd/ras/rascore/ras_mp1_v13_0.c
index 310d39fc816b..1fcfc1995ad3 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c
@@ -99,7 +99,20 @@ static int mp1_v13_0_dump_bank(struct ras_core_context *=
ras_core,
        return sys_func->mp1_dump_valid_bank(ras_core, msg, idx, reg_idx, v=
al);  }

+static int mp1_v13_0_set_debug_mode(struct ras_core_context *ras_core,
+bool enable) {
+       struct ras_mp1 *mp1 =3D &ras_core->ras_mp1;
+       const struct ras_mp1_sys_func *sys_func =3D mp1->sys_func;
+
+       if (!sys_func || !sys_func->mp1_set_debug_mode)
+               return -RAS_CORE_NOT_SUPPORTED;
+
+       return sys_func->mp1_set_debug_mode(ras_core, enable); }
+
+
 const struct ras_mp1_ip_func mp1_ras_func_v13_0 =3D {
        .get_valid_bank_count =3D mp1_v13_0_get_bank_count,
        .dump_valid_bank =3D mp1_v13_0_dump_bank,
+       .set_debug_mode =3D mp1_v13_0_set_debug_mode,
 };
--
2.34.1


--_000_SJ0PR12MB69670E557C61C779C12A6FD59DEF2SJ0PR12MB6967namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi Hawking,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks for the review,I will revise ras_mp1_set_debug_mode with below fix i=
n v2 patch set:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
1. Add validation for mp1-&gt;ip_func and mp1-&gt;ip_func-&gt;set_debug_mod=
e</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
2. Return -ENOTSUPP error code if the callback is missing</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sun,Ce</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Hawking &lt;Ha=
wking.Zhang@amd.com&gt;<br>
<b>Sent:</b> Monday, June 22, 2026 3:51 PM<br>
<b>To:</b> Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; Zhou1, Tao &lt;Tao.Zho=
u1@amd.com&gt;; Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH v1 1/2] drm/amd/ras: add set_debug_mode function=
 for uniras</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">AMD General<br>
<br>
+int ras_mp1_set_debug_mode(struct ras_core_context *ras_core,bool<br>
+enable) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_mp1 *mp1 =3D &amp;ras_core=
-&gt;ras_mp1;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return mp1-&gt;ip_func-&gt;set_debug_=
mode(ras_core, enable); }<br>
+<br>
<br>
Please check the availability of set_debug_mode call as it is not a mandato=
ry function for all generations<br>
<br>
Regards,<br>
Hawking<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Ce=
 Sun<br>
Sent: Monday, June 22, 2026 12:50 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Chai, Thomas &lt;YiPeng.C=
hai@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Sun, Ce(Overlord) &l=
t;Ce.Sun@amd.com&gt;<br>
Subject: [PATCH v1 1/2] drm/amd/ras: add set_debug_mode function for uniras=
<br>
<br>
add set_debug_mode function for uniras<br>
<br>
Signed-off-by: Ce Sun &lt;cesun102@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 10 ++++++++++&nbsp=
; drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h |&nbsp; 1 +<br>
&nbsp;.../drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c&nbsp;&nbsp; | 14 +++++=
+++++++++<br>
&nbsp;drivers/gpu/drm/amd/ras/rascore/ras.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 +++<br>
&nbsp;drivers/gpu/drm/amd/ras/rascore/ras_core.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; |&nbsp; 5 +++++<br>
&nbsp;drivers/gpu/drm/amd/ras/rascore/ras_mp1.c&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; | 16 +++++++++++++++-<br>
&nbsp;drivers/gpu/drm/amd/ras/rascore/ras_mp1.h&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; |&nbsp; 3 +++<br>
&nbsp;drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c&nbsp; | 13 ++++++++++=
+++<br>
&nbsp;8 files changed, 64 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c<br>
index f627a97797ed..2ce7b88544c3 100644<br>
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c<br>
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c<br>
@@ -773,3 +773,13 @@ int amdgpu_ras_mgr_lookup_bad_pages_in_a_row(struct am=
dgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ras_core_convert_soc_pa_t=
o_cur_nps_pages(ras_mgr-&gt;ras_core,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr, nps_p=
age_addr, max_page_count);&nbsp; }<br>
+<br>
+int amdgpu_ras_mgr_set_debug_mode(struct amdgpu_device *adev, bool<br>
+enable) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras_mgr *ras_mgr =3D am=
dgpu_ras_mgr_get_context(adev);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ras_mgr || !ras_mgr-&gt;ras_core=
 || !ras_mgr-&gt;ras_is_ready)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ras_core_set_debug_mode(ras_mg=
r-&gt;ras_core, enable); }<br>
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h<br>
index 4f44a917d48b..a757ec15125e 100644<br>
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h<br>
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h<br>
@@ -84,4 +84,5 @@ int amdgpu_ras_mgr_pre_reset(struct amdgpu_device *adev);=
&nbsp; int amdgpu_ras_mgr_post_reset(struct amdgpu_device *adev);&nbsp; int=
 amdgpu_ras_mgr_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint64_t addr, uint64_t *nps_page_addr, uint32_t max_page_c=
ount);<br>
+int amdgpu_ras_mgr_set_debug_mode(struct amdgpu_device *adev, bool<br>
+enable);<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c b/drive=
rs/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c<br>
index 2098f24d4940..ee59184f7eee 100644<br>
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c<br>
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c<br>
@@ -24,6 +24,7 @@<br>
&nbsp;#include &quot;amdgpu_smu.h&quot;<br>
&nbsp;#include &quot;amdgpu_reset.h&quot;<br>
&nbsp;#include &quot;amdgpu_ras_mp1_v13_0.h&quot;<br>
+#include &quot;smu13_driver_if_v13_0_6.h&quot;<br>
<br>
&nbsp;#define RAS_MP1_MSG_QueryValidMcaCeCount&nbsp; 0x3A<br>
&nbsp;#define RAS_MP1_MSG_McaBankCeDumpDW&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0x3B<br>
@@ -131,10 +132,23 @@ static int mp1_v13_0_get_ras_enabled_mask(struct ras_=
core_context *ras_core,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
<br>
+static int mp1_v13_0_set_debug_mode(struct ras_core_context *ras_core,<br>
+bool enable) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struc=
t amdgpu_device *)ras_core-&gt;dev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 smu_msg =3D SMU_MSG_ClearMcaOnRea=
d;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_smu_ras_send_msg(adev,=
 smu_msg,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enable =
? 0 : ClearMcaOnRead_UE_FLAG_MASK | ClearMcaOnRead_CE_POLL_MASK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
&nbsp;const struct ras_mp1_sys_func amdgpu_ras_mp1_sys_func_v13_0 =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mp1_get_valid_bank_count =3D mp=
1_v13_0_get_valid_bank_count,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mp1_dump_valid_bank =3D mp1_v13=
_0_dump_valid_bank,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mp1_send_eeprom_msg =3D mp1_v13=
_0_eeprom_send_msg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mp1_get_ras_enabled_mask =3D mp=
1_v13_0_get_ras_enabled_mask,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mp1_set_debug_mode =3D mp1_v13_0_set=
_debug_mode,<br>
&nbsp;};<br>
<br>
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ra=
s/rascore/ras.h<br>
index 5869bad978b0..371d1061d8f4 100644<br>
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h<br>
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h<br>
@@ -167,6 +167,7 @@ struct ras_mp1_sys_func {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum ras_fw=
_eeprom_cmd index, uint32_t param, uint32_t *read_arg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*mp1_get_ras_enabled_mask)(=
struct ras_core_context *ras_core,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *e=
nabled_mask);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*mp1_set_debug_mode)(struct ras_=
core_context *ras_core, bool<br>
+enable);<br>
&nbsp;};<br>
<br>
&nbsp;struct ras_eeprom_sys_func {<br>
@@ -400,4 +401,6 @@ int ras_core_get_device_system_info(struct ras_core_con=
text *ras_core,&nbsp; int ras_core_convert_soc_pa_to_cur_nps_pages(struct r=
as_core_context *ras_core,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint64_t soc_pa, uint64_t *page_pfn, uint32_t max_pages);&n=
bsp; int ras_core_check_address_sanity(struct ras_core_context *ras_core, u=
int64_t addr);<br>
+<br>
+int ras_core_set_debug_mode(struct ras_core_context *ras_core,bool<br>
+enable);<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/a=
md/ras/rascore/ras_core.c<br>
index 61d100b074b9..08e17a83ad5b 100644<br>
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c<br>
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c<br>
@@ -151,6 +151,11 @@ bool ras_core_gpu_is_rma(struct ras_core_context *ras_=
core)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ras_core-&gt;is_rma;<br>
&nbsp;}<br>
<br>
+int ras_core_set_debug_mode(struct ras_core_context *ras_core, bool<br>
+enable) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ras_mp1_set_debug_mode(ras_cor=
e, enable); }<br>
+<br>
&nbsp;static int ras_core_seqno_fifo_write(struct ras_core_context *ras_cor=
e,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enum ras_seqno_fifo fifo_type, uint64_t seqno)&nbsp; { diff=
 --git a/drivers/gpu/drm/amd/ras/rascore/ras_mp1.c b/drivers/gpu/drm/amd/ra=
s/rascore/ras_mp1.c<br>
index f3321df85021..15b605a23aa5 100644<br>
--- a/drivers/gpu/drm/amd/ras/rascore/ras_mp1.c<br>
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_mp1.c<br>
@@ -59,9 +59,17 @@ int ras_mp1_dump_bank(struct ras_core_context *ras_core,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return mp1-&gt;ip_func-&gt;dump_=
valid_bank(ras_core, type, idx, reg_idx, val);&nbsp; }<br>
<br>
+int ras_mp1_set_debug_mode(struct ras_core_context *ras_core,bool<br>
+enable) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_mp1 *mp1 =3D &amp;ras_core=
-&gt;ras_mp1;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return mp1-&gt;ip_func-&gt;set_debug_=
mode(ras_core, enable); }<br>
+<br>
&nbsp;int ras_mp1_hw_init(struct ras_core_context *ras_core)&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_mp1 *mp1 =3D &amp;ras=
_core-&gt;ras_mp1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mp1-&gt;mp1_ip_version =3D ras_c=
ore-&gt;config-&gt;mp1_ip_version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mp1-&gt;sys_func =3D ras_core-&g=
t;config-&gt;mp1_cfg.mp1_sys_fn;<br>
@@ -71,8 +79,14 @@ int ras_mp1_hw_init(struct ras_core_context *ras_core)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mp1-&gt;ip_func =3D ras_mp1_get_=
ip_funcs(ras_core, mp1-&gt;mp1_ip_version);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!mp1-&gt;ip_func)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D ras_mp1_set_debug_mode(ras_co=
re, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return mp1-&gt;ip_func ? RAS_CORE_OK =
: -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
<br>
&nbsp;int ras_mp1_hw_fini(struct ras_core_context *ras_core) diff --git a/d=
rivers/gpu/drm/amd/ras/rascore/ras_mp1.h b/drivers/gpu/drm/amd/ras/rascore/=
ras_mp1.h<br>
index de1d08286f41..0b618f6b8b9e 100644<br>
--- a/drivers/gpu/drm/amd/ras/rascore/ras_mp1.h<br>
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_mp1.h<br>
@@ -31,6 +31,7 @@ struct ras_mp1_ip_func {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum ras_er=
r_type type, u32 *count);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*dump_valid_bank)(struct ra=
s_core_context *ras_core,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enum ras_err_type type, u32 idx, u32 reg_idx, u64 *val);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_debug_mode)(struct ras_core=
_context *ras_core,bool enable);<br>
&nbsp;};<br>
<br>
&nbsp;struct ras_mp1 {<br>
@@ -47,4 +48,6 @@ int ras_mp1_get_bank_count(struct ras_core_context *ras_c=
ore,<br>
<br>
&nbsp;int ras_mp1_dump_bank(struct ras_core_context *ras_core,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; u32 ecc_type, u32 idx, u32 reg_idx, u64 *val);<br>
+<br>
+int ras_mp1_set_debug_mode(struct ras_core_context *ras_core,bool<br>
+enable);<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c b/drivers/gpu/=
drm/amd/ras/rascore/ras_mp1_v13_0.c<br>
index 310d39fc816b..1fcfc1995ad3 100644<br>
--- a/drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c<br>
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_mp1_v13_0.c<br>
@@ -99,7 +99,20 @@ static int mp1_v13_0_dump_bank(struct ras_core_context *=
ras_core,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sys_func-&gt;mp1_dump_val=
id_bank(ras_core, msg, idx, reg_idx, val);&nbsp; }<br>
<br>
+static int mp1_v13_0_set_debug_mode(struct ras_core_context *ras_core,<br>
+bool enable) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_mp1 *mp1 =3D &amp;ras_core=
-&gt;ras_mp1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct ras_mp1_sys_func *sys_fu=
nc =3D mp1-&gt;sys_func;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!sys_func || !sys_func-&gt;mp1_se=
t_debug_mode)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -RAS_CORE_NOT_SUPPORTED;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sys_func-&gt;mp1_set_debug_mod=
e(ras_core, enable); }<br>
+<br>
+<br>
&nbsp;const struct ras_mp1_ip_func mp1_ras_func_v13_0 =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_valid_bank_count =3D mp1_v1=
3_0_get_bank_count,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dump_valid_bank =3D mp1_v13_0_d=
ump_bank,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_debug_mode =3D mp1_v13_0_set_deb=
ug_mode,<br>
&nbsp;};<br>
--<br>
2.34.1<br>
<br>
</span></font></div>
</span></font></div>
</body>
</html>

--_000_SJ0PR12MB69670E557C61C779C12A6FD59DEF2SJ0PR12MB6967namp_--
