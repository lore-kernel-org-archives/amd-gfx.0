Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F73E7719A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 01:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B01DA10E40A;
	Fri, 10 Jan 2025 01:49:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TZ/lvqr9";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 067BF10E162
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 01:49:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSVPZgqKG1tFXRQ47r1I8pm5hz9IMyrd5EcVkspS6Ue0oX+D8cGY4Lp9SrpsLW+uHvUp8ImvOaNabmaflRhzcLfnYql1ZocSORLIKZoBMJs46GvIAoOKnk9Es83W6egDZCNowORB9DVVo7Tlhl1fimnJXubKdINl7R4krgLC9m40+17fqZxJPfnNIibv+DiWbUnaeEjoyTCIBuhOjookdJglAHuE4ndmGQOPy6drIvXAUQGbDJdZIx+OqQEpgAxrEYB2A/WoTHJvxXVrpaHywcsd67l0bSGpFQGBAAmzMhySWU8uP2MYk/TgmG2xzdrvEykIhQ6j0fFWlD4BZXuwCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2staEM9lvFBY4QVVOgrJRHXFeXxFqhYdQftB8WPzhx0=;
 b=KRQ1FyFg25NKCBVAk8ARuieYssiOaGWE7/RthVnKlV+zAYYqyjfjMLFNAg/eJvUBYjud5aq7GH7ff13OBnTcOdCy1XT1SzGdH2Wz2w7n/VYr2XXd4aOO4h/0TG0q4TmXFM4JCNOLFNe5vjxt++Jez5YJDI+6L9m2KHl3/jnZqr72axO/z9/7d3WsjiLjKBstvLPA7zR7uM9cwfXom6McCpGjX1HJ8JG1RvnZm7qtyXcOHas+RMTirxTmRmNUejzysu/tKWRpVRdXxA9DGP9Xv/6Y4dFigdMV+auJitPy3UZIrQdlKTh9JO9J06SWfyx8pqE+67dK/6YK+eoF9GCPoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2staEM9lvFBY4QVVOgrJRHXFeXxFqhYdQftB8WPzhx0=;
 b=TZ/lvqr9li8dpG5SK+ZblomZovoy59HA1satktKzrttthEE+4j0XaxtJyr2dXZAyx9k/LyPIdPymCpJo0jdJEuKmg812v0O2cl0d+seuBMR3GhUCioF0SRWwJJ905RVsY9XsQsvDMX/enAjysro5doN+tmVUxdzem+cOkU5QR9M=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by PH7PR12MB5950.namprd12.prod.outlook.com (2603:10b6:510:1d9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 01:49:14 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%4]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 01:49:14 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: disable gfxoff with the compute workload on
 gfx12
Thread-Topic: [PATCH] drm/amdgpu: disable gfxoff with the compute workload on
 gfx12
Thread-Index: AQHbYnALFhdScJp2/kS+hsOTB9+rJrMPPr3Q
Date: Fri, 10 Jan 2025 01:49:14 +0000
Message-ID: <PH7PR12MB599782EB0198573B9C2EAFD8821C2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250109082524.11102-1-kenneth.feng@amd.com>
In-Reply-To: <20250109082524.11102-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=51c5fab6-acad-426b-860f-ef505f2dc228;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-10T01:48:55Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|PH7PR12MB5950:EE_
x-ms-office365-filtering-correlation-id: 49dd9a6a-c8ef-4906-3dde-08dd3118fce0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?7va7tp4AIg1onizz3snGvvB6Qrgkj9j4PpwdgUcOx+ugqIL9WniklcHmQNTo?=
 =?us-ascii?Q?ibh3ycA+ssWzInFgKTkSHXdGglghSelsAl3tBXtNJ5MpOfOOtNQbcAWsSWAQ?=
 =?us-ascii?Q?I9TxdFvBDBXIxPlM1Jq8R3odglEaI7++ryKguYYg/snbTxNim9qQF0h2E3k5?=
 =?us-ascii?Q?FR0a/vzELSoDotU7AE9sEkXWMU+bQ99eVetEz027FUWc7fGb9LxZmcYq3STR?=
 =?us-ascii?Q?2BmMJ6u1bqlskr4QP50P2O7oLWQ8QRVNbBpY6ohlreQZ2Vtlhik5+ZNTvejO?=
 =?us-ascii?Q?AZpEvTkN+4tMeeDPC2LNXibmc4tqwG6u81RzZXa+WDvHABT6OiSHHLDJ36G/?=
 =?us-ascii?Q?EA5eSs0s5XO9XJbzKwYF+4trhPjIjr8NtvvXZFSfV68GQLE+ZJC1m/GjtZes?=
 =?us-ascii?Q?I6EC0eMLL1nAncUGATJ8Ie3Fnw7gTVKVuN/fa6prmzk/beg7HOImWi30pS1g?=
 =?us-ascii?Q?zJV91V8hpBx3FnufJQbeDSoS5pJHIXJ93n5YbaQY9ID59UXYUk5SXZujhrv8?=
 =?us-ascii?Q?O4OCyqCoxbBOlNQOAdZZuBUcCXuJ9VJ5VsXBWZ0Hmgb2lT7qqaN2lFeT8YAw?=
 =?us-ascii?Q?ycBoKGGJZa56/ZD9W5yCx98tFqboyffsdHBe5BRKZl1QytrkSpkhOYSfH0dt?=
 =?us-ascii?Q?PmKLsyeKyd69D1m5Ze+kymPIL/DiXMC0yVUh06P5ZDBBywYmNK08JXJQnS0G?=
 =?us-ascii?Q?v7Z1yPO88lVEI0MS8TysXvdZ9BrXgyAvduus24Vv+Yq87IULkZSNoh6b5XGG?=
 =?us-ascii?Q?NcJBY1mHPlXGNTJIuHHSy8I7rwE62pAxiRRFtF+6+6bdanLoK14Lf3GbSRFW?=
 =?us-ascii?Q?FTvJSwxLbo6MDTvLMByiRryK9HG/UhJK2KM2z/cOLz4orkEZ9cGKphrER/ic?=
 =?us-ascii?Q?yB9DUgjcNOzAHHTUKPhSe2cT4npJ4sOmMFt5iY6QYJYLdAt3ifWMjejT7osM?=
 =?us-ascii?Q?q/4e/XkfqpBec6ZGSIN5UQQx6wmaINP8vE5YUWTTPrGPzqjwRCdLqSWpKRhZ?=
 =?us-ascii?Q?Fmmhfamj9Y73l5a9VMz7MMMD7i64CuukQd/v6322koKF/iU9jtW8Rj/3OTA0?=
 =?us-ascii?Q?6xdl7276n/AMVfAqswWgv24kBqC1v7BmQqgI/EL7IH+40uth3h7jSCLgLyuV?=
 =?us-ascii?Q?8odelFimV++A07zCVcNpTWkGdY9IDrW2zqZwGK4vc4yK/PRwNVgtGWNWEFj1?=
 =?us-ascii?Q?P3OxDDMuMW57C4ac9d/7CCUHwKmu9OtJY3+Cw0aOfKSuxgecPJo5bVVV4Rli?=
 =?us-ascii?Q?4YjwaL0W+PCZKKbKTIGRAXUsI1CA2vPaYW37CFnqLOmBMoflEZDLK34Wf26t?=
 =?us-ascii?Q?dzwgId3oR/zhxuduNQQ7oAMzlvDG97bBwDLPV8qDWjmd8etNjBb1YqUNfwql?=
 =?us-ascii?Q?2Fcb0ojUldYR8iUpl4ZtU8C0xAPv2BFIiU+E8ADTJMEnwt1eSQA7SGQ+AnNq?=
 =?us-ascii?Q?PCS/GWaBJJu8QIdS9cYuOwO74d/J9ozt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PlwlJpabsAuz/FeRbcsvZjvp6v4E8pI8Ca5Z/wkhBLPFqfkFvDkjwesKL3RH?=
 =?us-ascii?Q?J8WXJ8P6LbHNeppfjlhN8P+R9JwikZHkjp/hfuhlWGc5IlTUxBAi54d+C8yj?=
 =?us-ascii?Q?GawDfEesNbwe52BBwtgXf9OBanTSLwKO/3mHaKIEdNGGf0uXSVeYxz9ads6c?=
 =?us-ascii?Q?/M7WHnqPmMCObv/Zy864vffAQysMmT3ZgS6fThbtRIW3j/KHzCWayDfSObmw?=
 =?us-ascii?Q?lcvfvCnjZR/uubovtJxr4defsb0kx+h6R731AZt0ZU8C75gLd9p4o+7hfopJ?=
 =?us-ascii?Q?xble8PbzZ+ZdryauzGyQCR+zZ38tBkLig6sPwEFGtlfWfrKUqFEGwYcpGLuI?=
 =?us-ascii?Q?D/Zkz7Mg6Yh8IbwXmLdlJFmLzi5yjeIOEUehBOqxH8rHAwjyxgePf3wiPynZ?=
 =?us-ascii?Q?nGzxRVie6+lWjVH1kJ6YBPJHElmiVZONMuEaNajH9rXWk+AqiontLSNze7lA?=
 =?us-ascii?Q?No7gp6/d0Ndg1+vPGc+tiyatucyjGFXQu59We4/2t1GoleNJNOOptcFFBgcK?=
 =?us-ascii?Q?fQYDx7wc050VMybEkaKr5b3S34Z2VjV3fA9kb5qSmDjVQ7D205/VKW5RG9AH?=
 =?us-ascii?Q?/ukkxeFcqN8yB858azyLAXnmixJy88Xoz+4w1l1lx33GzJRbxPSYmUJOVqCg?=
 =?us-ascii?Q?6FRR0kavc7JT3xyjsakJ8JYHzhKR4DOYDUTbqnt3/Uk17j3IsqaBYdKP2b4r?=
 =?us-ascii?Q?rlVrF2CiX6hfoNGtPItGjC1xcE5zY60p6Njn1MgnOBsVxwrRo0zt2LE1YoE8?=
 =?us-ascii?Q?N65RIrZQiMMy9kZG4S2c/IbrbVZLzUC0cIrixQWGtmW8M5kq/83mZkdhvMFn?=
 =?us-ascii?Q?qrIoPJ3FmO6n/yBKt6+cu55VDwcUfHsD8U7jQx+8fkgcOEo8ts+dSUtrywuy?=
 =?us-ascii?Q?4Qxo+IYoWF5uRJlOHs37QdYhnzv1PStmoBM+xNFMpZOhqQpawim0fSuM3aNM?=
 =?us-ascii?Q?1FLceI6iABFIurKCf4F0V7GR0gOgNm8OA4B/S78ytR6QY940qB1bOYofnt4e?=
 =?us-ascii?Q?lfyJ93UEqSkN2Wb96jfj4uY8YkITMMRFWQop7CqKUnFl5YkFoWkYDmSe6cDC?=
 =?us-ascii?Q?YBQVLS9iAvIcoH/lk5LOqnlogmyGos/82pQ71vDSbEO34r9GFQl8mwlpuPKq?=
 =?us-ascii?Q?1NekmJvOdqfQELula6xFNk38Z91AQiMRfl0YB93s02V++HvlS1u+7OlhYCUf?=
 =?us-ascii?Q?vQtmK8f+Tlepsau7wzRitcJJj5ccOK4LTr0ZkCLhb2hZ0LI3rHuEPqzLCcVv?=
 =?us-ascii?Q?jNao+bV5CCv+7+7c8ka7Kp0U60hbc8m7JNVFXnr8YrSz0mpFdP4kU0OsxuYN?=
 =?us-ascii?Q?AlauN01h35XT6MA85zNb2UAVZzXFE60diJ+ERFyfZbJPPqeIEM3juHhgGcqP?=
 =?us-ascii?Q?85Ir4FC1lENxNHzBZgM6949Iu0A2YNz7VvFXT3Xzo24MBDsQEvuemN794vpj?=
 =?us-ascii?Q?8RaA/BhAseutWs2zKWkpj5GXXjvcKayuqVvDQR3G/9Y5kRxXtRSDI4qps6vt?=
 =?us-ascii?Q?HSb7vTD0A4vMYaeei5F2yJsmNrPD9GoRXp5glQ+nUOJr+xN31qqo3UT61ZKh?=
 =?us-ascii?Q?b6RCUPEEdstG9XT9Rek=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49dd9a6a-c8ef-4906-3dde-08dd3118fce0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 01:49:14.7936 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BcnXcPx2nyeEDviELjPBRB0K3eLUc8Ll7YTRQ2DO6MiJk7GSRghKF8tSrdS+rHPc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5950
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Thursday, January 9, 2025 16:25
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng=
@amd.com>
Subject: [PATCH] drm/amdgpu: disable gfxoff with the compute workload on gf=
x12

Disable gfxoff with the compute workload on gfx12. This is a workaround for=
 the opencl test failure.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 2e5732dfd425..e4cf25c47509 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -715,8 +715,10 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev=
,  void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idl=
e)  {
        enum amd_powergating_state state =3D idle ? AMD_PG_STATE_GATE : AMD=
_PG_STATE_UNGATE;
-       if (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =3D=3D 11 &=
&
-           ((adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK) <=3D 64)) {
+       if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =3D=3D 11 =
&&
+           ((adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK) <=3D 64)) ||
+               (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =3D=3D=
 12 &&
+           ((adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK) > 0x6C))) {
                pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabled");
                amdgpu_gfx_off_ctrl(adev, idle);
        } else if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =3D=
=3D 9) &&
--
2.34.1

