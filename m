Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A57CC54EBE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 03:11:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5588310E1A5;
	Fri, 13 Jan 2023 03:11:27 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 253F410E1A5
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 03:11:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBTAVbbS6qYzsRHFZv88wSjR4LryrsVxZ/VFbTKm6XGp7r2AKVK9ArOHKzYTObCdTguFL3SazT1FZYB7USb/76mWHMQ/ifxUkC6wC1FC/QEiArb1Yfj/jgCxkxJQ5+mnlmCNql9fOVX5kQ9LGCJeKSrObCeEaSTxwUrUDZfDzEWbHzjA7+OPyNyYIUAoqr8dQ83iMPO5lMXhbX37St94DyJixkTldyhI8Jw8oo+RaE0y65KRf7nWdKaemBuqAN51NXbed/8OPFm3AxvnWvB8GcNGomfLejYB3CHBYpcesxfoAwnrO5Imdrf/kH13DkJ80g9APgyPpWoM70RSX94jBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wxh/FynqBrqVu1Cn4JscUZqxgfioK7Dz79WGv03DyWU=;
 b=ANDkM/akWi1R5w+vbBx4Icx+GdNELvNdYG371yZZM8Rpg1EsB7k85c5z70x+AJUp+mDhK786lEFMQWacDTHxdk/ASmgAyi2f2wY9HWBfiKLMuinG0RErR/3igdL6l7+kZc0y8+6Q7m+qXuTz6RZJRXsioKji0+MSdgoE55//UAOBPXs1xrwPjBmrF1xD3ydfL3i15LEi5A2ounQEerewxVbS6ZxFYDYoBPPCAp2Yy8Y5P0mor3YspZICAGUPIwlgbI87VN3K4DgmqGGqC/E+IEwfpHQ5e+eku0Gp+lwdrePuZz9gmUzqIpRzMKEC1tkc9YkpJEmhO/dW6qNxUDZXhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wxh/FynqBrqVu1Cn4JscUZqxgfioK7Dz79WGv03DyWU=;
 b=E4P+s/an/7p1TmSRWgK6N2Wh5i0NDau7e9ofADybMnKVobkq/1kXB55HK3pPEt4OGPoedj2+9saj230SFOLkfvcET/T7ASAomGU6OgOlHzBYlAo0Or9r3RJOdk4/QY8LwwV29T6cW6T+rEtSrOpqghlDhAIkTe130cGzHe0fMdE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 03:11:21 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::27cd:5a5c:4713:83f5]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::27cd:5a5c:4713:83f5%4]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 03:11:21 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Support RAS fatal error mode1 reset on smu
 v13_0_0 and v13_0_10
Thread-Topic: [PATCH] drm/amd/pm: Support RAS fatal error mode1 reset on smu
 v13_0_0 and v13_0_10
Thread-Index: AQHZJvhyl7PJq4DvF0eNUMawvcxKla6bqzFQ
Date: Fri, 13 Jan 2023 03:11:21 +0000
Message-ID: <BN9PR12MB5257B918E04E9D6EA552489DFCC29@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230113023956.18405-1-candice.li@amd.com>
In-Reply-To: <20230113023956.18405-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f363dfe2-ea8c-48cf-9105-e8edf3e0958d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-13T03:10:19Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM6PR12MB4402:EE_
x-ms-office365-filtering-correlation-id: 8b6013d7-9c1e-465a-a2da-08daf513d8b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jIZIXVzy5omJHwe2H5J7eTm9RN3gq/WE+/kFRL9AtMiDHexOMVOLzu+yR5wHOM+xDFHKE+j4YmLN1S/5Xo0n8ObTAoXlQBdoPvDOtDrfSm3d/KdVg3Wwwx6yzkZRh+/6D+AoT1ydq+E8d9oc2ifVweQKandERuK5WiGbR+7aSmhOu1tZdNW2J5klCw34gA6goAM+N4fuHZuSp050olGm4x197kA1y0dj7gK3csyR4M+dGEfJ3PGjLSFcAQ3k25RYewdtr0+S7UwQCebO3Vloqtg8MSnxfwEj5RFGOsCcPbmvL3797FUFR/5dSeS+JLgVwp+OveApWtJWAvWkAZR62OBcGTiWTYnXUh8cW2VssyNPs72HzbHBwoe+fYks3lhFRiHlhNo8TzOOlDyjYFu4jh9UzWMdIUj90Do8fx4fcF5aXaBGXIVhKT6PpA/7rYoujA5YlDX3nY4aMxdl9+tawgTmR1AjnAXkTfKkC+HCONs8MRzuB8G9DrX83BTefG7ro6IWNLZc0MN5UUEt7xY9HM2ni6h7TQ9H7FcVxB9p9EMMzfVZHrKrWJjfT//0KPiVvB4NQ5AHhxCH60o6tPZmldeNxd1RuayTWruOFfyNfgjuRPVoN0gX+9A+mL80SFJbDiYvKJorCRIfno0vfXLAi5wYpjnY4D9eRKLVDdmN9WApboUTgaA1JtLseEi40ZOhpawviNL6eqWbXLTJ4HSlXg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199015)(52536014)(5660300002)(8936002)(41300700001)(316002)(76116006)(66946007)(2906002)(66556008)(110136005)(4326008)(8676002)(64756008)(66476007)(66446008)(71200400001)(7696005)(478600001)(122000001)(38100700002)(186003)(26005)(9686003)(53546011)(6506007)(33656002)(55016003)(38070700005)(86362001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lGect1p0iiuq7+fpY2/kG86SoM1y9nkakDQbvNN9ZCmZgPqlIzqNDUJ4rWsN?=
 =?us-ascii?Q?ax0TkYdUR0DVNqTFKEuot2Y8udO7Bnh3RRETNnOSl5L7i9nrwMbkyf8VU7p+?=
 =?us-ascii?Q?EOxo+Gxj5IlzhuG4hJKr5Q4eoe9QKThcZzMFk9H13Be9eujY5YbmxZ9BZQz9?=
 =?us-ascii?Q?s86Euj8yMsDC3G2228lMs/xNGnduuw7v54gWnKhwiFVSiZ3pwgyJQY6mhaZh?=
 =?us-ascii?Q?hOq8HU1ff2rU3N2svzIaY1ivBdCfBttA3owv4h2daVHUREhRGM147zvBjAsX?=
 =?us-ascii?Q?UWBOohL4TmRoBnYUxXdVBtDSATQ/xK/mouwatxYXIU/x0jFpb+HO3V9ByD4h?=
 =?us-ascii?Q?ASpf1ftLeCK5krzm1v6JIyfZJPleWpjgi2BkAX/TywBd30FIdvhjxcO8XWfy?=
 =?us-ascii?Q?lzA+vZJiPJgIBeTfS9lMQt7ldOEY/BhPfNeAoHsvdJSJY3fWCmMjjTfa+MYf?=
 =?us-ascii?Q?D9j/m9rLaEaAvPvpKh8vCP8a6CkqIQGTlMZqvveBrS14MxGyFNgpruRc4fd5?=
 =?us-ascii?Q?k80G0j2jr9O5RZ2/4fkWRvvH/J7Ie9R3u/Y7HxAhhNkVz1tX8TUkMupBIKjU?=
 =?us-ascii?Q?JwjhdzNoxc5rRMa7jSgXOR2fgvyl6CwR2E+uoNmB6uV5zeaxe5XCtpKFYCpl?=
 =?us-ascii?Q?5+bPEp+4c77SBQBa4uRE3HSeymmKKQFxv8d6m8zEfnyfKp2sRTzc4JUl/+nk?=
 =?us-ascii?Q?lGCH6kt1aIp9VKlJWXsS6J9Kg7J/keYzttMoiFOZICLkPOFYEayysUd1NBaW?=
 =?us-ascii?Q?zXMaW/UbXitWnaWVHTqBOh50j3hGIPb6WldwDRGzqDglUvw5ae0mqrz9CmaM?=
 =?us-ascii?Q?lhQdUXL9C9bunLRSBKaaQrs58EX66XifzX8KuEizrjWCvpdMZcY7zOtw6V0/?=
 =?us-ascii?Q?mP4fgL7oea8A5tal3Zjwz0jQPFkJETomCGsg6twUOrdKA4/+iDyOweTpVTfC?=
 =?us-ascii?Q?TD4BbV8cohZTv9cJZMnxMrZqccIbsXUOF/JOK93hR+voz3ZfPs3IP5BIJkka?=
 =?us-ascii?Q?85LlETF2kLjq06YOul64TIV/+bhxxlZkfqEu/pqsw0lMOwpI7lIbcs24V2id?=
 =?us-ascii?Q?GxFLXFpYS7NuLGxYusNhIIyWE7HVNqwVP6TrA9V3OjpeNhOvYwqjphsCaRPI?=
 =?us-ascii?Q?9FzrBgpqDuFVH5O9kY8D13VTQSafwm7odlcblL9d4zynbWAVihFPUAGw5vzS?=
 =?us-ascii?Q?A1dOwjrtyFgHcKWrKcS4kWlhGYGRQ9tYaOAAyYe9kCbPJQLBuIqhZGjstSl5?=
 =?us-ascii?Q?t2vOosNDXtcpDZSXBCa14Qw4Qo+8kB5TKrK0Mx7B7ojkMnXz3k7dOspVvd6T?=
 =?us-ascii?Q?1QQO0yfyMcxUx3EgQXw/P8094GUp7q4t3NPZI1qXPxDEtQiWERDhtI+jdD9c?=
 =?us-ascii?Q?k+OzVLB312P9W9/xpNuh/QPO5M2Ldcw/mkYeB937RZJ4vwdXE3hVHpsumYCb?=
 =?us-ascii?Q?5II5pwbe3KeCtPoohEnIK3/hKQ2JwBEGdWpm+zN1K61bWszCb3Rd0UOxI8Hp?=
 =?us-ascii?Q?nzGYACA2lAXEI9l6EG+NF1SblSTRRTlOOHHNxbim81smZFQPnz9ao2uZn7ke?=
 =?us-ascii?Q?ChwN9i7CB+1764O1wBuLWfKihAWfx1OpoJbWO+Vv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6013d7-9c1e-465a-a2da-08daf513d8b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 03:11:21.4949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wib9MoIRU36mVBVcEUFIf/Gv3K9Sn39j8xeTLrWOFP6ISKj1PmIhroF9LSNCy/XVD0rHmUfnSSTRf7AH7OlPHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Friday, January 13, 2023 10:40
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amd/pm: Support RAS fatal error mode1 reset on smu v13=
_0_0 and v13_0_10

Support RAS fatal error mode1 reset on smu v13_0_0 and v13_0_10.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 42 +++++++++++++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  6 +++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  3 ++
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 969e5f96554015..d0cdc578344d8d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1904,15 +1904,51 @@ static int smu_v13_0_0_set_df_cstate(struct smu_con=
text *smu,
                                               NULL);
 }

+static void smu_v13_0_0_set_mode1_reset_param(struct smu_context *smu,
+                                               uint32_t supported_version,
+                                               uint32_t *param)
+{
+       uint32_t smu_version;
+       struct amdgpu_device *adev =3D smu->adev;
+       struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
+
+       smu_cmn_get_smc_version(smu, NULL, &smu_version);
+
+       if ((smu_version >=3D supported_version) &&
+                       ras && atomic_read(&ras->in_recovery))
+               /* Set RAS fatal error reset flag */
+               *param =3D 1 << 16;
+       else
+               *param =3D 0;
+}
+
 static int smu_v13_0_0_mode1_reset(struct smu_context *smu)  {
        int ret;
+       uint32_t param;
        struct amdgpu_device *adev =3D smu->adev;

-       if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 10))
-               ret =3D smu_cmn_send_debug_smc_msg(smu, DEBUGSMC_MSG_Mode1R=
eset);
-       else
+       switch (adev->ip_versions[MP1_HWIP][0]) {
+       case IP_VERSION(13, 0, 0):
+               /* SMU 13_0_0 PMFW supports RAS fatal error reset from 78.7=
7 */
+               smu_v13_0_0_set_mode1_reset_param(smu, 0x004e4d00, &param);
+
+               ret =3D smu_cmn_send_smc_msg_with_param(smu,
+                                               SMU_MSG_Mode1Reset, param, =
NULL);
+               break;
+
+       case IP_VERSION(13, 0, 10):
+               /* SMU 13_0_10 PMFW supports RAS fatal error reset from 80.=
28 */
+               smu_v13_0_0_set_mode1_reset_param(smu, 0x00501c00, &param);
+
+               ret =3D smu_cmn_send_debug_smc_msg_with_param(smu,
+                                               DEBUGSMC_MSG_Mode1Reset, pa=
ram);
+               break;
+
+       default:
                ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL)=
;
+               break;
+       }

        if (!ret)
                msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index 768b6e7dbd7719..d5abafc5a68201 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -404,6 +404,12 @@ int smu_cmn_send_debug_smc_msg(struct smu_context *smu=
,
        return __smu_cmn_send_debug_msg(smu, msg, 0);  }

+int smu_cmn_send_debug_smc_msg_with_param(struct smu_context *smu,
+                        uint32_t msg, uint32_t param)
+{
+       return __smu_cmn_send_debug_msg(smu, msg, param); }
+
 int smu_cmn_to_asic_specific_index(struct smu_context *smu,
                                   enum smu_cmn2asic_mapping_type type,
                                   uint32_t index)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h
index f82cf76dd3a474..d7cd358a53bdcd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -45,6 +45,9 @@ int smu_cmn_send_smc_msg(struct smu_context *smu,  int sm=
u_cmn_send_debug_smc_msg(struct smu_context *smu,
                         uint32_t msg);

+int smu_cmn_send_debug_smc_msg_with_param(struct smu_context *smu,
+                        uint32_t msg, uint32_t param);
+
 int smu_cmn_wait_for_response(struct smu_context *smu);

 int smu_cmn_to_asic_specific_index(struct smu_context *smu,
--
2.17.1

