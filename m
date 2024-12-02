Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07214D49795
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 03:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8081210E285;
	Mon,  2 Dec 2024 03:40:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C4Q1/4YQ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0178010E285
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 03:40:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PolQTq70wIReugSs0mvAXnOgVMuq/NjexoStKCd9hmtACBbkIYN3lLMOmSrQQTWI6Pe8rOwr9g2bCg3/uIMoKYqsIAJshU3LwwU14xKUokfnAin5DhFqJyJDq6btMtJ6uglOTDxtCyg0Qrlg1iW8qWFOfK23XwKT1MkOKGSFMXqs/nA/pXOVHHNCwFNySLyR6lukuDG8VMWzZ8WKMoUQpMbnLNK0aAcWzyreoDOOPZE72UQ+Rf9AChTfpaPkYlsVelH7XWGU4OT+0SDSZdnZa7txJzfa1KcV33zo97UPkFIuGJF+teFl1BtYoa8eH9FwMZe0j6Ua40CzFygGPG26dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ACGXkDc8ZYv4tpfwIwYlrPDHBSFEhnae1avGqNRBJ8=;
 b=gCu166SUxDJb1LO4zJu/IgPmvpXL4yO00a3du+O3QFdiTv1Q3leE+nZNBwzvXvg0QjDw0Ab8HtvO6p+lgCtH4dTjg6qFvABCGkXp4zwsiTuwn3vywyES9GheWVQqFghBZvnfjjuvbE22gmBNhUZpUQv8tJcUrM+eHTtycc5ah3UxhYpfDhv4yaulvAnU+r1hNLInIY+a4SfFg26GYZETMGvBFUoJyZWh9Ke8lRoFSDBxywEYgS1v/5NmC2hidKaIHx8wwSVmKS9HbkmFRZa9kja64PNFUC4pXliC3d6yx3Ne/9YLW8iPTmHqFlUlrFFWkUMs+QQe9FYdo2EPgtYtWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ACGXkDc8ZYv4tpfwIwYlrPDHBSFEhnae1avGqNRBJ8=;
 b=C4Q1/4YQB0q2clv1ZUTStsNf/5S8f6Ay3gCdByHRmWEWm9QXu5uV7Jogr+aAjdxG5+zHixdpt9TBcOG/S1bfQROauHWlLCGaJ4y9ph/x2wkKBjPOkYsxjWNApS09QGju0xKvyCN/B3kZj8QPOoVE/oPdP98J2tQP8QezKxc1HoE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH3PR12MB8234.namprd12.prod.outlook.com (2603:10b6:610:125::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 03:40:40 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 03:40:40 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Su, Joe" <Jinzhou.Su@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: return error when eeprom checksum failed
Thread-Topic: [PATCH] drm/amdgpu: return error when eeprom checksum failed
Thread-Index: AQHbRGqiQXj2QmMYNU+ivPRmewJzhbLSTqPA
Date: Mon, 2 Dec 2024 03:40:39 +0000
Message-ID: <BN9PR12MB5257A5F971E2EEEC2B2B9F18FC352@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20241202033001.5585-1-jinzhou.su@amd.com>
In-Reply-To: <20241202033001.5585-1-jinzhou.su@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ef690ff8-d098-4223-914c-8a97b096ccce;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-02T03:39:05Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH3PR12MB8234:EE_
x-ms-office365-filtering-correlation-id: 290a95d8-5df9-4afc-49f8-08dd12831770
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?BAHoBI+xYxJrqLiwJ4mcMOqQKCjRAtNGtZeV8xp/HMAVv87HHH2IS8pTyoaW?=
 =?us-ascii?Q?l5XVHvrFDPA1/SocOrrr7FqiFZvB/Iw4h9DdKiuzFpKj/mtcf+gyOel8Znsn?=
 =?us-ascii?Q?ilkCOyd/lOy5xZy0ssnGvQEn1A3ME2YlaZkDaPceREC6z+TwJTHG/O08Os9A?=
 =?us-ascii?Q?iUqN726nCYS0CkhdyN1c3TTQ9DHEqdNkuQrIYjORZQlHK8YZDDhyc3+88DQ6?=
 =?us-ascii?Q?G6ad/A4HMyL68C2sVTIViVBIeeLRGyBUenk0ksJNZrzgUdRDA7twd5J5+Xyo?=
 =?us-ascii?Q?EObJoAHJDbyaj7UaTcgOB+MN/1oQvQAECAqEQqCCED7qmtJX7BvUA39F66aK?=
 =?us-ascii?Q?yyd0f+c64PsjCdwAiTAeEBhhpRKDfoZD1OUZo7J+cAJrIMT/mldMyx0P/7nc?=
 =?us-ascii?Q?vwpD1jqCZT5rm7U+Oj8GP4FN8hAoBKQWbuOGiWiYkh0cIbrT21WXUhPn+LGC?=
 =?us-ascii?Q?8Q5ivnl+NPepbe+ewKSe7Z0mKjnnEPZBFRhbm+jIFDettAkWHIxaIs5vuY4r?=
 =?us-ascii?Q?7LjCp6M8HcZOzqGm7UwqdDBeXDRTlb0iwHIaYc884RO4ZYJn7EVLNK6VCN07?=
 =?us-ascii?Q?yCFtVfZSOFSBpCF3AZ5huJh0XPd3wrZraIi9bbAiFm1uLn0KeStqzyTw8QpR?=
 =?us-ascii?Q?lfUMHHr5ZgXmuNQjnFF+szS3MRJy7zpxnSDmPQXr02fgP+QbbIhHQSzHq0FW?=
 =?us-ascii?Q?LtKGDNQFHJuG68/3r5s4ypNpGSoZlTS78qeHquNx0yE7c8xZnvvwYjRpRN/W?=
 =?us-ascii?Q?XSFODXMD37QwEcvdH0sThTue1tmMESiOBb3pkEAPayrese/HJmyLVB3DJN0R?=
 =?us-ascii?Q?q0dwOH9yr3FoTAmryZgJxZRFAUgvRKsmLAv0vsEGC3Oklc3YT0GaNt2Sgz2j?=
 =?us-ascii?Q?sFuouylm4JOAhxi6FwWVqmcSniBV0JyHC98/kGWIbzVbhN9PCRsHGDMLqZOx?=
 =?us-ascii?Q?woFiRKvDe7fYoZvf9oyL2XNFG0YdiVg2Ce5UieFMVgTTJLLNRHuzzcqbKSf9?=
 =?us-ascii?Q?naM4m4tVL8jnkwsNySo8uKZk0dmQDDFzezi9tFfJ9COhVTjdUt1gqNMkEuIi?=
 =?us-ascii?Q?pbRssBEejqgh9hvZVXRjBEBhl/ZUvXmQNanXCXZTiXy2/N2qGo5Cq31TY2QQ?=
 =?us-ascii?Q?NcEALqn9X29auwKpcXn8hu9SwFu9oQe1/iMLeJLZMaf8TVGVyhKsHWnJdrAT?=
 =?us-ascii?Q?UuUNoIJdNazxq9ILnHQ7ClHToF6/mTGHgk0V9guMO2YikKHHXAXXRfaerhKd?=
 =?us-ascii?Q?0Cp4C1oyuJmVh+93rgYKz8g6xwBsMMgZR1Imw/sUsleTEuzUg1pSISODiWD2?=
 =?us-ascii?Q?RfCXmFBOF9IuPXjDf/dPAcc3fzzN+O2CmqfbTfKMKBABVECvuaGL+zWb5Tyy?=
 =?us-ascii?Q?90RazFAMeQmqZMFSBO3SmZFmrtPcP1p2eFRxSHzoN7lP5k5JYQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DpPoPHtkUk25K/aINwmOqIeFikOdYh+V4/yuI4P1UjPtF02KIN10GQJPK3hU?=
 =?us-ascii?Q?fMVuQDDcID/oaCw3zZumrRUnynwxucSbwaFivNgvotyLweRVSBv3zeg/pjGb?=
 =?us-ascii?Q?saL0yXX+vtGW9dmQECiW8Vn4AZHhBxIL63lPGof7/SAaMIYPN8MO4Inc6e9f?=
 =?us-ascii?Q?gfDm+UfQbNxQV0BZx1korhk97O/1mJQQCrjh5PgMSvlYEYIPwKZGCRLu8zst?=
 =?us-ascii?Q?MzTZNL1z9v3C9U3Yq4kwPx554SfPhNAKmvdPEt8etSL9fgkHCPGyXefdqPzt?=
 =?us-ascii?Q?NX3EmSLZNFf92I6stJ1CVV9ATes5kNzzxSzbBvrCg6Fd5sJp1o5YM5futExq?=
 =?us-ascii?Q?xlgyoJjwsAYT8E7TPCpoH86JsJEPBGZO56VjgKaiW4c+NVq4SQbKKSKQ552j?=
 =?us-ascii?Q?g+frT02qWEcS62Xmk1qjbYLAm2RM13Yu4M1y7gxHcLm+PLYJ+n3FINbERjp7?=
 =?us-ascii?Q?6CLqSi51Uf01pFKF43h8iCAF3zhLoOnQfVXXwI8EWJmVBZpL7t4yBHmq6iWl?=
 =?us-ascii?Q?L03fVJsolDMrRITBRunElLMzkMbQe2GwHS3qj37oecrXxtd5NRIN9Xc+SfUR?=
 =?us-ascii?Q?qbM5v3/8qRUKzOzM/48IPkw6mO6rxOCnl5mFUFnYa2/8RgD7cTSuQ/L8q1C3?=
 =?us-ascii?Q?/jYE54yxVLE+Jdw/hr77u5sziH21dJjXoLuzWln8Eeko1swnyMnvh/eI4175?=
 =?us-ascii?Q?P2fvcSkhK18zra8CGiM2L3edoRhOr4ULyU0Bm/kEnZmfgXztAN0QtLN3QVv5?=
 =?us-ascii?Q?LdiviwWmoSuMxHe9vyGpDIto2sgSO4zh4LCuFqQquy1Mf9NQBVa/NgpjJWRH?=
 =?us-ascii?Q?UlJ4Xq/Yd4BNeJDHCoXeYABzPiRujuEze8HgoVmxaFuvZkyUbgFK2C000kpL?=
 =?us-ascii?Q?tI5XXUQ0G2IFBcANfw7qMYQqW1nZCjeOTrZym6KDJUh0KPtM4i6V5LSVEpRK?=
 =?us-ascii?Q?LVFYRCz12tIfROJrX+jZ6V7nZ5UdW+KR32Kfibmz18iCPOfe2ZHe+U7Sd7Yb?=
 =?us-ascii?Q?DBBHEJNOBi0EBfu9Ig+K4HV86k2F8sqvukXGLjDi97YDmoMzQhvpFxm8vNSq?=
 =?us-ascii?Q?62282v8uegJQmI+LNZq3iCa3ptGxA6EE0Pt9QapDi8tGoymFcAc9T8Lueh4h?=
 =?us-ascii?Q?InGChc/kom5U59d9BF49v8m2REe57cR2XnMgvzaT6Wn0TjMWHsqzFH3u7uO7?=
 =?us-ascii?Q?alUq4HZCrsSJPPQjxaXp1DuVds6SLFMHbCKJw2HtkKz8XPBdBMJMUnO9XMMN?=
 =?us-ascii?Q?0AALQHi61lsGO/1OeRwV7VkDyJxKGAdq7KT8ZXfXokmoXlMU1jCL1wBd8DGo?=
 =?us-ascii?Q?5xvCgUsAxuGGjsjzH9pUSefHJs56opW/Hl4GralTKmH8cnm43Dk8mIdQQ5hA?=
 =?us-ascii?Q?jFqMFXH9XSPa5X1MlIVZfbeWzWrHjUAeSd6UKEo+uYMkIhQ6K5Y5CNSh9ajK?=
 =?us-ascii?Q?e5DIuHbY9jG/CLcvtRg+oLPwy8mOq1eo/G4qjZu+9BQW/9zt0x0Ic+5cSvus?=
 =?us-ascii?Q?0TElsmPuX0I2KgCVi8f/JGCxG2rjkQ992ZUA0Xc0RmvX/qpSdWuAa0XyR4Zz?=
 =?us-ascii?Q?I23GiidSfN6ySUQAZKA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 290a95d8-5df9-4afc-49f8-08dd12831770
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 03:40:39.9418 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Y49EG7Pyr8dfs+6iDN4OqrfOvPtozrJmsJLlbUXk0q+lTW1aGk/w7Cd9bRowGByNNGSF3l4Lk4HhuPsno6CdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8234
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

Please replace DRM_ERROR with dev_err. Other than that, the patch looks goo=
d to me.

Regards,
Hawking

-----Original Message-----
From: Su, Joe <Jinzhou.Su@amd.com>
Sent: Monday, December 2, 2024 11:30 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd=
.com>; Su, Joe <Jinzhou.Su@amd.com>
Subject: [PATCH] drm/amdgpu: return error when eeprom checksum failed

Return eeprom table checksum error result, otherwise it might be overwritte=
n by next call.

Signed-off-by: Jinzhou Su <jinzhou.su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index f4a9e15389ae..19fe2a4cba46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1412,9 +1412,11 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_=
control *control)
                }

                res =3D __verify_ras_table_checksum(control);
-               if (res)
+               if (res) {
                        DRM_ERROR("RAS Table incorrect checksum or error:%d=
\n",
                                  res);
+                       return -EINVAL;
+               }
                if (ras->bad_page_cnt_threshold > control->ras_num_recs) {
                        /* This means that, the threshold was increased sin=
ce
                         * the last time the system was booted, and now,
--
2.43.0

