Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3235CCFA03
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 10:07:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9464E10E86D;
	Thu,  6 Nov 2025 10:07:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iygXEfB1";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAD2410E86D
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 10:07:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8eEc4A12AS/68znQI0Nwpf7HOSkV2ZgiAy7lJy0vLUbdXbciRUeeGp2M0Hl8MGa4BLq7QI3jDntzNy49997k5Z3O665KzxLv6BKG1uRYpu1+ItHennnsGF6IljpD0WnkbXdvc+wgOmOWW4dD39BlrTqv5BcSWs0cF+ZVolBteV/a3qAFo32rrMy/b/pdYfZZ0aolYLhbDuqlsQ/Ehrc64QF+1mHzQEM2l3BHDgSO8W1xKYsTrBLncTNU84BGJOaHKvsCSe/qAuXXsPwtdnw0P5WnbTDJE7uFGcy1lcEiclcQyYofx8m468stuNHB4AjMlxhoPBVlLOzK2qdNvYQ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Y4MM0qN6hzPyIQbyZF8Pq+VhEwn7/5BeOZs9VFDzfY=;
 b=Y9+UzatcE8hZVX9JkO2OLIxpyqv3OTu9XumPlr9iAxxedAK0q+XBx707yiiR7cwO+nPx6VM7Ifq8NECdWt7KlcGK2LBc4A4cq5NxrqlZDKl0dmwfusdld1ylmo3hFUmcsiFq23T3wG6RCVJFM/7rjAS2zZkI77zxDoJaTHNEcLsaJZMIzJkiYhX5cZsX73KZfA1gP1nCcL0M8mIg5gibxYZ6AI1Ra9WZn9EOSGXn3aLMGICqwRMrBDNGc18vsT1OmwjGgpPvzFdgjkVfeogs5DOPPFU8qKNFHngooPKb789mM7SWAvWXF/gviOpvUsAr7u9Syl5Fo5xtuAHS/RwIAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Y4MM0qN6hzPyIQbyZF8Pq+VhEwn7/5BeOZs9VFDzfY=;
 b=iygXEfB1X90st/ubGyt0U4sGJeYecZ7WnTYvhcfh3kFh9x16GgX8vWaVWTXcd6p8FTv9Yq0dEz/g3t/MQ/kEHDt44qCTcWYOU4YgtiYhEODMmFeH+OS8D+MnOvlUZ2GJacv/XSBn69ydnO1k05Q0UmGtv9tSOqQMvC6Ql/CyNLo=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 10:07:51 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 10:07:51 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: optimize timeout implemention in
 ras_eeprom_update_record_num
Thread-Topic: [PATCH] drm/amdgpu: optimize timeout implemention in
 ras_eeprom_update_record_num
Thread-Index: AQHcTvnkgaTDY17O1kOOEHcZxavCbbTla5lw
Date: Thu, 6 Nov 2025 10:07:51 +0000
Message-ID: <BN9PR12MB52578A7B6DD84AC3F01041D5FCC2A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20251106084622.1431571-1-tao.zhou1@amd.com>
In-Reply-To: <20251106084622.1431571-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-06T10:04:44.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BL3PR12MB6569:EE_
x-ms-office365-filtering-correlation-id: 7f6a8353-6494-4b47-eb99-08de1d1c585d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?D80fgyEu43HJiv7ughDK6E++88MylmLVo3vk3SBg91mIPhmJHCzZYqRnhqBy?=
 =?us-ascii?Q?6F+tHhrxhWEM8Ps4oRMWQtm04eZF18azjC+hcLXQrZUKjdonVx+P9E7gXZiy?=
 =?us-ascii?Q?5Mo0rTER49rEOKFSIocy+WI1vbfunG4sbEL3hpxjf004ZDGEOBTz4zHhkgmP?=
 =?us-ascii?Q?qObv64Mv/SVz3kMB27thMAKEvHVwZ42GAXaV1R68RXDTzhHDXgFxFiu8dW6t?=
 =?us-ascii?Q?vKObNpyRaldg4FB29cbhktMV7xjq4tr4O8vatc5uKJsyYSntHsInGUQcngTA?=
 =?us-ascii?Q?N0eyWrXi8nbTTzJoQy6wxriV8l1iJzktsFM0RhXM416sIEam/ODpqrQdLslh?=
 =?us-ascii?Q?Fd+R4XOTiqnImGLZJlVocatYVCOfnpInsFoIAjYDu3c+lwlImLlDKVICs7N/?=
 =?us-ascii?Q?duAKzuRkgC9lAaE9eqp4YVQDzOljPtfskH+CIlrtcrwfpPcxcR88GGhGDpxL?=
 =?us-ascii?Q?rl/fZVvItwSgPEjqboEu973G4fWSacos1tHanyh3XJsDbLUvxarW0dOiMx15?=
 =?us-ascii?Q?kfThIrZML7zYgaHT94P+SO9sOoET9ZX8waPbKu+GVU1GH/1PmtrbL17ytuvT?=
 =?us-ascii?Q?CH100l+ocAF6FDBAJQTH44SHbXPf5N42kc7W/k0MEo1iNSAJQajuz94eqpAn?=
 =?us-ascii?Q?dVwL8MfmoPtiG+fawppp0xK9lKRN3w7Thf9I+1To1cbCSu2/uy41cZ0Ve4e1?=
 =?us-ascii?Q?oTfzQNcUufvux3qmoq8Cn32TygBZEIVwJEp6IJ20HR3x/VQQGOikvszGwSI9?=
 =?us-ascii?Q?CYLDN5ndzV0+JEsvmcjhC7jLpxfCWc+Cb1vHL4iCcpthTzhkml+22YvpQD1z?=
 =?us-ascii?Q?9WQTovyCaAipF3Av0h9C3EvFe8sDSNjLF8Jx+101RDnX5mu5AT7Uq53J7u/T?=
 =?us-ascii?Q?1LVJBI6l3RzdADPJQW0DwKRC24FCv1ggylr3yvPMHefbqVbtMp8Fu2111Ls1?=
 =?us-ascii?Q?vSvys+ANHjlgLT2aPGH5CYabfHEqEGUOgJ8d2pXjZ1b+PTPFz0bF/gMOWAEs?=
 =?us-ascii?Q?MYkCUwLUueFNsBYbmsF4NjrjudIB+0F9Jss6W3n0vgWQL96HSxg+ZtfGHcnu?=
 =?us-ascii?Q?rAjGeVSkwAJdVaJrzYggOrdRMPGDOvJWDC/iTYywLMrRwqMJbS+HXH+0qIk+?=
 =?us-ascii?Q?M076zGlPS7f5O7FBWAClOld6xVBop3AsmA4zGUqo0SGciG/63vxkG1qllP8B?=
 =?us-ascii?Q?0NZ5AW+cg5/3pfHTzCYrDNgUAMIwB3fqwx+B5LsE0jpuChohR3hS/fHzwfpw?=
 =?us-ascii?Q?VmNciOwpVJHnB70p6j0S39ylPUT22hQon01fO2alj1iNJnduM5vHTO49PNoN?=
 =?us-ascii?Q?i3uEwomtL5U37eKkyejwnXAIF7xT/3aTwOVvUhfISvVFtQUIsZdeTOvfqMML?=
 =?us-ascii?Q?PX2bJY1A0RthQNfwz/PCGj/rE1oDfpNrbtqoa3xix1PVCqS6H+Zbam+V2yB9?=
 =?us-ascii?Q?zXBs0fLJZ8We/2vr3YKDv6bM1VsCQa77iO85/PTkbjO8P9ECOpgfXHK1+5jo?=
 =?us-ascii?Q?FhMHTpgmJx9gcGytsQjvxjS/48H0+mYHnOgf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uM2eeSzQ+ZhqWVflkFdkeW7vnawzkHUuRQS7mMqtCqyP1uI6uqpwk6AmGq9X?=
 =?us-ascii?Q?I5pg8s3z0oTi7ZhOw7HB6NsC5zypl4beMXbUagICJhQX2O/8vSr+NkLEBmet?=
 =?us-ascii?Q?BMOkoh6mcfq8oieO6QbAdsJ1+LHVYXi3cuYkUHp+pnPhzy2RN9GQuVzIwdif?=
 =?us-ascii?Q?gpw16k8SMCdTQ6gWs9wjIVa/b7h7SHmQqwRyP3YMdT3WVAIxQqjsCehPUgh5?=
 =?us-ascii?Q?ly7sfiOVQ9GUEb8Bm0zwSxTGapNtaVsWOJz1nktTL01/5MxEn9UZJVoR+rdW?=
 =?us-ascii?Q?3zAzUbHpSlvFK8CI0xVNWRpAST01jY2Wg6CtZxi60vBJqS/H7BV4y2yoh9kS?=
 =?us-ascii?Q?kITazXcH8B/A687JokQezduw2+HpkJbAepYx6VXOeL3U20njPBTOWMqzsz6D?=
 =?us-ascii?Q?q9hNdGj4uyrNKePHqslNHlCDhux4vN+WdkkxyfP3VFrl8Ha35aqdtiODtr40?=
 =?us-ascii?Q?cFedG9w93uQjCamiLmNXSWzfff01qIAO0+yWtfBQHDQToUmvzCOXsAfjP8v4?=
 =?us-ascii?Q?nXFA0ijdBG91Et7L1EB9f89SP1y2qyog52ssXutCYZY3GePPBZcM6+eZtIyU?=
 =?us-ascii?Q?tG6PDomLzEjPMOZK1XT4+WhaUiRlaeLgH7MsjP+RKwYIMYQOZbCiJh1ACKC9?=
 =?us-ascii?Q?CR5WBpiyCyYMXOJWCEp254JLiJ0nuYoVHC1uPMG3fbnUx1b2BRSG/4742ltF?=
 =?us-ascii?Q?b1UYg48mMVlO0/Olqrgdl6NIs5q2tsVJudzvMo+kuXkzje+p4WaDaxQqvlaJ?=
 =?us-ascii?Q?xl5YQRtEj3YU7W8/yvDJh3LcGZOTfQysrzJ1cB/+nVO/+oEB3woz15rpZ5yN?=
 =?us-ascii?Q?JgeoZ58tV1TgdNJdViGIVehIC0QEvhoK1prMSzUbjpu19TrsHPZMZ4Z0LtH5?=
 =?us-ascii?Q?aZJLtf1G29+vql/gKnhmLRxaSAI4Rsishhm7G8TR9Jx1OZQ4CkJjR2h2tywh?=
 =?us-ascii?Q?1jM4sErxnkuCVgkONwVXdja5CgaI24Ha392LdJI7YKTivM3mBmKyMls+kidq?=
 =?us-ascii?Q?nDFWxH7e3NhQ+slrTknV7UXA9Vg4VDNed9rUra50Yc3odLHVr9bcY/HbBlnm?=
 =?us-ascii?Q?t1dXR5lJ631PF7++F+7zcv2Jc3If0HOHn+C6PrIjkrowF3UTNoqKuCT5XjSu?=
 =?us-ascii?Q?+aqNNqUMH0jC+CTtjj34t9ldtBuPid2B9SLIhe2AcqsEck7mTn2suU0t4A4K?=
 =?us-ascii?Q?jb9FCZo7JNtu9I+FbNiVN4cYCH/iGNkemYd5f/p7mL4LvSWYvDxKws5PxuFV?=
 =?us-ascii?Q?PCydjw4dvmdyr9nv2t0eoZCd8CKvmsB9cUMtDCNoFNcHSwDUSaH7DXB6affD?=
 =?us-ascii?Q?8tBMnTRjENW1FqvqeyWZzeBftTyjAgqfmUWOdm32abH741E4adb19a4OYsev?=
 =?us-ascii?Q?yeolj3CkrexKcAD4ElWilA3+Zq7yQ1SkxjdKqLaBEwKr1nebOWR5dqUkUiJr?=
 =?us-ascii?Q?QcjFPfhAAHC85rYLsi0/ScHBGk0ueNeRaJT27VO16gykWq80ncVVV7i0zPfI?=
 =?us-ascii?Q?KMAD8xAjdMztk5hOvI2UPLg6ZHUh39t0sWVCApTbRuPILL6t5097x/ma+DH9?=
 =?us-ascii?Q?t6/PyTgvN02jDicE81w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6a8353-6494-4b47-eb99-08de1d1c585d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 10:07:51.1806 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YTB1ntaV7T8MZm9Oi9qYrmmXeupOuLEOiyQS2Bm5ANSn4KovDR514Jhzy9edX/ezpJlh/TgpnNtn+aictC122Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569
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

I recommend defining a macro for this timeout setting

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Thursday, November 6, 2025 16:46
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: optimize timeout implemention in ras_eeprom_up=
date_record_num

The busy status returned by ras_eeprom_update_record_num may not be an erro=
r, increase timeout to exclude false busy status. Also add more comments to=
 make the code readable.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index 99aa1908833d..ff9f86d5ef15 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -874,7 +874,7 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eepro=
m_control *control)  int amdgpu_ras_eeprom_update_record_num(struct amdgpu_=
ras_eeprom_control *control)  {
        struct amdgpu_device *adev =3D to_amdgpu_device(control);
-       int ret, timeout =3D 1000;
+       int ret, retry =3D 20;

        if (!amdgpu_ras_smu_eeprom_supported(adev))
                return 0;
@@ -882,17 +882,23 @@ int amdgpu_ras_eeprom_update_record_num(struct amdgpu=
_ras_eeprom_control *contro
        control->ras_num_recs_old =3D control->ras_num_recs;

        do {
+               /* 1000ms timeout is long enough, smu_get_badpage_count won=
't
+                * return -EBUSY before timeout.
+                */
                ret =3D amdgpu_ras_smu_get_badpage_count(adev,
-                       &(control->ras_num_recs), 12);
+                       &(control->ras_num_recs), 1000);
                if (!ret &&
                    (control->ras_num_recs_old =3D=3D control->ras_num_recs=
)) {
-                       /* record number update in PMFW needs some time */
+                       /* record number update in PMFW needs some time,
+                        * smu_get_badpage_count may return immediately wit=
hout
+                        * count update, sleep for a while and retry again.
+                        */
                        msleep(50);
-                       timeout -=3D 50;
+                       retry--;
                } else {
                        break;
                }
-       } while (timeout);
+       } while (retry);

        /* no update of record number is not a real failure,
         * don't print warning here
--
2.34.1

