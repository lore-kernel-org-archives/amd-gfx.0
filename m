Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8895EC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 08:15:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01A7410E590;
	Mon, 29 Apr 2024 08:15:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gC5RSC2S";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2A9710E590
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 08:15:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQn0TtcYybWSdUNTZ0WcY7m5+bHI+plKbLPc477JrzVjnS8cK93pHhLJlmGXrelj4jLE8koYkO0JysUGGWLOIknzisX6fOjKobPz7nZkTDmW5DareEmcPZyzou+6t9xqfpnWwCAu9j62vdjBKgTsTMIjlA8N3NqK+5F/ynnyohHsfpDjVbhq8MRV1Lj5VfXuvD6Vug0sq6wUGGh6v1czEFiNMIA5zjqG57Ts8LXrftxUfVmCvrGf6rHZGc0cyvAjBNzkhrZW63PbsKMNjnWfptTxGIGxfVUeJ5UUtj2/be/RbQ5fgafW6h1eEWS++2uzxbSEAhVuhvvHoXcxDrPLdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aT4mAHrIrbMC47UZrzX+n9TvfBUXL9Rv6hxLAcLD0c=;
 b=ecKlzC+oW74GdDQ9h+OfNHdzc0TDXjERknwp7DxO4ZJ3rb4X76F58PyCRAkNJ06C5Hafbt4BU2YibrDYzBLsRKLthlDJ4oamor3S7V5gS/wYoVrVC8gaSDxlHthLdnuVYu1tEbbwvcV6ES72mDeWqaPge9cmjIlnTzkoj3KkG1neFU6ybXl7hRyrURF+tKZnoZCCkVLxcr2NV/cbgpkmh8Snbb4KtSaDJ5NFyMwlZuewYQbFotbWDgxoD9nC54HRw2p03ITcvpo4d7Zec7sKIW+ZuUv4NS/PtwPnNQTADE7FTGzQOcHCWku1jLGbjz0jR2Ed5bTygbl98J+meQA/Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aT4mAHrIrbMC47UZrzX+n9TvfBUXL9Rv6hxLAcLD0c=;
 b=gC5RSC2Suko1PyIndMIvCLdBb125S27lF6UD8kTR1ao7GKibst4G1PjGgteffMyGk8nTybwMWG6Ep/k5xT4oegMotxmgktdF7vAR4xcV2l863ZhlDZoskSGHQMbEUjNbjpHk+hi9XEuL3EVJRqO+zVOXvrdEnZlkLMeto+mVM4U=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 IA1PR12MB8077.namprd12.prod.outlook.com (2603:10b6:208:3f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 08:15:16 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::b088:86ad:44e7:a075]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::b088:86ad:44e7:a075%7]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 08:15:16 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, GuoQing (Sam)"
 <GuoQing.Zhang@amd.com>
CC: "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>, "Aldabagh, Maad"
 <Maad.Aldabagh@amd.com>, "Ma, Qing (Mark)" <Qing.Ma@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/amdgpu: use the default reset for ras recovery
Thread-Topic: [PATCH 2/2] drm/amd/amdgpu: use the default reset for ras
 recovery
Thread-Index: AQHamgdH8C+QpXQhDkegr1Uk0YVyK7F+5pzQ
Date: Mon, 29 Apr 2024 08:15:16 +0000
Message-ID: <DM4PR12MB51656C0277435B3DB92BBE608E1B2@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20240429073132.12611-1-kenneth.feng@amd.com>
 <20240429073132.12611-2-kenneth.feng@amd.com>
In-Reply-To: <20240429073132.12611-2-kenneth.feng@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-Mentions: GuoQing.Zhang@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=07675754-7a5b-40da-b917-d6cb309fa858;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-29T08:15:01Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|IA1PR12MB8077:EE_
x-ms-office365-filtering-correlation-id: d289868d-52c9-4cd1-e7a9-08dc68248076
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Ptq4BOQPsU52rZDrTTGF8yOUQGCVPrrdkgAb2xcp8OY1OIcM44eLK38Gi880?=
 =?us-ascii?Q?UVOuh6lcqw06w/I7pKHa7jK7KwmXqJ+WAXrYTL3PCFPI8M3uNpX1UVCtN+WR?=
 =?us-ascii?Q?XX+v4nvNQsdcpDTjiEnVoK7+foCeKyXrMpzDHqambv7vq/g6PIJzx/Blz2G8?=
 =?us-ascii?Q?ioTy2k6k3TG+p0zyY1rt22dy9Kz43UqDTYD3em+RVNbvLP2pESCuyiwlb8B0?=
 =?us-ascii?Q?Mo0DOjE8bh+ZfoLMrF6lWn3w+otCoLhDlNAZvvSRwYnWS9UdddWltjUc/rhC?=
 =?us-ascii?Q?3kW3EIWE5GZcJzqHvvnc1wFDSRiSbjaa0B4Lu+udLB0H7cyPfFpAlkN77hKP?=
 =?us-ascii?Q?GeWKi5yzF2uyZ5ia5puSbzBg9tACobHuW9Qw6ZZxIUSf7IGsGjWs5nFhSpNa?=
 =?us-ascii?Q?sNpt3iMnb9Gm5R7piLTfysayHDfqfxlZfyM9rS6I4oRQ7l68lKKCMPplOSF9?=
 =?us-ascii?Q?XOJAOJxWzItxnT6KlZvQUc3rnM1ksUshS3FrlARu+6ZrcR6MnYTYaNWyTIO8?=
 =?us-ascii?Q?jYoPgJ9GKQK36kQwWDWqH3SZ7OfH6PvrDHJlDCVdy6HF5F1fADi73OPglYL7?=
 =?us-ascii?Q?04nON0nObL83PKI9vlXEM9kVkpaoDgWrcGNKX4M/MlgSMjLXnEkk8P7mZMr5?=
 =?us-ascii?Q?EDu8ETP68g7HVGZeIiOat4GSySoYrIKNOt2e+vlkIxm0sPkC9RvWqguzw2O1?=
 =?us-ascii?Q?sQjU9dk6dK1atCqaJGZleeE1QCGY2epzEV5ZzelKmdBtVo0sen8cQGXmutVk?=
 =?us-ascii?Q?Fy1QwQv1XKreJdCrh1lQV0GRSCSGM4mu3DstVtKZt6tr3t00iU/ACC1zTuHH?=
 =?us-ascii?Q?196iL3g3pOSnHfd/Zfp7I0s/8ihG85HUOgOtqb5e8Srz+n/28cTcSWTod+GP?=
 =?us-ascii?Q?6TQBV5VpJ1U8KFeGqL4rI7ZfEwl+ojHmlQefg8pJakftYsNqNAm3KrsOwtf7?=
 =?us-ascii?Q?B9Jj78yQrOhx5GSXJkYORmm2rNkWCcnpbOtdeADz98ve4CtWfRtRt+bsFAMG?=
 =?us-ascii?Q?wUFQK6MecqS6F9uU34bzrFCbBNrs4FHSCke9qFFJHZHmTiDW7TlM6+ddsu0g?=
 =?us-ascii?Q?ipa4oRp7Mym627zmMwzJkz8g/mBhmJBKLTs4Syy8idOWYJ9v3aI4MxY38zKJ?=
 =?us-ascii?Q?VydPE2ksUNHdzlf4cJ0T7dJUvQSusiywmJU+yQEZpKvlQHCH7ikRsl+8w/ly?=
 =?us-ascii?Q?RXlFzvD5Oz+syK+krEzkB6tP8QynYo62GlgTkgmRiCWwcPseUcCOPA3gVuRz?=
 =?us-ascii?Q?QrDufT9I3QlVj78I3TEflyYOFe/frPpX6CziL27bmQaEWfBulV3LpATXyldk?=
 =?us-ascii?Q?1Av8uHbYsVU0/KJhOqqskMGvb8ej6tFDeJm8SYVKWytRng=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pJEu0+RdSX5SPknoQD17tzio9FYsFn7Urj2n69TfWBJ2+AtstU1CKH+q0otg?=
 =?us-ascii?Q?tGCNunPG1LSYStbdq6SaobomOo4vauwD9q7+tLfVgGxM38JbijLHxTwJMOQS?=
 =?us-ascii?Q?KKDfVo0/owlEd8eKOeaG3uov6/5eDGZd3UrhqapVBVcreeYhMp9hJWpGhutf?=
 =?us-ascii?Q?uKI2Z4n7LWVJ0Gyw8W77INJs3G5ohDH6X4wT1HB2XsGolItZ6WUbwJawld6/?=
 =?us-ascii?Q?/v1khHXPrAqiz2gz6g1kqxmyyUx/+6CnMxc5XqAl1X8NXxIgoKFmdro4edhi?=
 =?us-ascii?Q?lISYnhZkrSNTBcYxm81yPLbPReuKeBQhzQR3gEmZq+hP8t2oJNTNwyMG7yuA?=
 =?us-ascii?Q?qWix2ak+0qtKvgTzKcs2LH9gTqlI/wgdm5ZVm/ck7hGJglWlGc4c7nqD4WBd?=
 =?us-ascii?Q?36eWtaBzEvhPMlaMGoXAE+MhoNo5lGzBzNYl77toB1cQB6hIESUmRAW7Hgj9?=
 =?us-ascii?Q?N7HLVK2V+a2ue+fpNyIqm7PKMtw6yFw+FjNAXsjJWgKnIJhZu13wPzxhPYuO?=
 =?us-ascii?Q?T3YZbJyBKz3qu3CKvxqp4KtRbOlZK91kurRTVKyZ+y/8TWTpIDWtJzcLc8En?=
 =?us-ascii?Q?//p1HfyV6KzncU1u2n00o2pTUufYaak9EFVX/pHVFbjjvizsIKEQ06Izb02d?=
 =?us-ascii?Q?zFX2Izt3g0NVEzhA+x4nE7ywQiX0UNdP4rYYB4e9o5wq0rA5fFn4X/WW23Ko?=
 =?us-ascii?Q?vy+dIynZXUv+KkTUWHdZaBkpgVmWvB/7HM6/D5/xKgq+cWKF86VmmOtumuMS?=
 =?us-ascii?Q?5TGOezgg2NMS3f+0Mn92yBhpBQFJHjdM4A2ZDZACgxVtlxqheAjRmPqJLfDI?=
 =?us-ascii?Q?YzoC0SeUnzU33BskkzpQwhKmmDPkR2PpPF8HF1lqOewNLkz5u6QQvsWBFxfS?=
 =?us-ascii?Q?k0VX7yemEWNbQCPPrjfO0E8vWcGPWEyBlqap5jCPpkip/w1duvUWm962B8vz?=
 =?us-ascii?Q?TFIvgabl+wfFgjEby2o4QfgY6mAIrzYjCefocjfTRK4qUMhn8PgQD1Q7t0da?=
 =?us-ascii?Q?RyJps/TM8C7/wX0fF6C7Kc3fPGqRAIHXnnjMnMvG39PO5d/FLIi9silx607K?=
 =?us-ascii?Q?/layrZOaxt4comZy5KGsbovRfpkBV/QOUUePB6RgND9X9Jg2vVv4wjjvDpqJ?=
 =?us-ascii?Q?Rw9BouybD38we2sV7IwCtAUoCppqIUCXASEmc2gAqTzScm/yVwf1c3yDunvL?=
 =?us-ascii?Q?4C44MZgsxGbF/HdStuZtSVbwnIUwAsXASS7QICYQj+ZSYiIn/9WE/Jbs0ALd?=
 =?us-ascii?Q?VBgj+pPGQNL9GVJg+RIhYYyb64fyQl8fMoqaTFfbSf4y1CDhcAeAAzgEuuQl?=
 =?us-ascii?Q?RW4uMK0rcsMkIFS10VPCIvYA6z1K25LRpzzLZnV7Du82S6lZFVriu5x/k86G?=
 =?us-ascii?Q?lYibic9InyFPCy+a7BKqgs2nTY1ka+q6An59B3JM/j5qi8GXnrXO51PyQgoA?=
 =?us-ascii?Q?PFY1X3qC/iWh7ojIYXYl8Rc7+WywnhUKFLo4Tk2oXl9cu1XdzLNzgCy+JYS5?=
 =?us-ascii?Q?v4kiBpWQY/Rw4MGoLs6x58BcXwupPg46ftvnekFl4OxuEYlgoUx/NpNwwLMe?=
 =?us-ascii?Q?AK8+EII6FbauccVttjw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d289868d-52c9-4cd1-e7a9-08dc68248076
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 08:15:16.2689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Qpx+HYc8unVYoi05dyEEYi99dTJ+VvfobWadrjA2ZYkYbJh9/37MVtjMwpI29/t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8077
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

+@Zhang, GuoQing (Sam)

-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Monday, April 29, 2024 3:32 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Owen(SRDC) <Owen.Zhang2@amd.com>; Aldabagh, Maad <Maad.Aldabagh@=
amd.com>; Ma, Qing (Mark) <Qing.Ma@amd.com>; Feng, Kenneth <Kenneth.Feng@am=
d.com>
Subject: [PATCH 2/2] drm/amd/amdgpu: use the default reset for ras recovery

use the default reset for ras recovery

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index a037e8fba29f..f92b2c4f0d5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2437,6 +2437,7 @@ static void amdgpu_ras_do_recovery(struct work_struct=
 *work)
        struct amdgpu_device *adev =3D ras->adev;
        struct list_head device_list, *device_list_handle =3D  NULL;
        struct amdgpu_hive_info *hive =3D amdgpu_get_xgmi_hive(adev);
+       int save_reset_method =3D amdgpu_reset_method;

        if (hive) {
                atomic_set(&hive->ras_recovery, 1);
@@ -2501,7 +2502,13 @@ static void amdgpu_ras_do_recovery(struct work_struc=
t *work)
                        }
                }

+               if (amdgpu_gpu_recovery =3D=3D 2)
+                       amdgpu_reset_method =3D -1;
+
                amdgpu_device_gpu_recover(ras->adev, NULL, &reset_context);
+
+               if (amdgpu_gpu_recovery =3D=3D 2)
+                       amdgpu_reset_method =3D save_reset_method;
        }
        atomic_set(&ras->in_recovery, 0);
        if (hive) {
--
2.34.1

