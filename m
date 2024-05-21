Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC947C25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 07:56:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C309E10E3D0;
	Tue, 21 May 2024 07:56:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z3qAtL2Z";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A64710E3D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 07:56:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVXne6Ae93umyUgGysuEC7uHABbdkPBn7JZCCCssH83ewboj15K6E5WrjzHWJMqntH8ZK12WUWCH/bRBnvI1xaXxds6LC7sbr5st8We56bjIPdkrAd/lTndZz9HDbawGy6cLsu93WFsf7sZOd1KIeZPAxF98S1mYhEdLwwcEBago8R5INVOR9UVoF01Ps3dAv/jamQcS48+9oLMYYziw2ZwPVBYeK9nCVbrM00hZp5UU7UAb0VujLQN5+uYc0M3BfG4JO/ZhJ6zzmStavGxgHcW1TTIPgzkI/9AKREJszZY/S7vLQDMEWXsIAbFptdjITbOjKEh4vWWO4GAuplOqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wykMpzlL8zJr1Arbp1twAubstCcXJTx5rFhUPfGTJSk=;
 b=WmiL1RNuO29hZtYxoiIyBqzHhQ7Hzu6hk1IoacUDTEJMe/8sRXF7NJSMj7SaE/b2iYPxbyxAspMP2+eod+uW1uQuVb4xpAQlBWFHHb654BTq/YeEPyFuZAq3VZwIMz53BJjzoP1Sy1zcFNem9J8w9+D3HfAaU6nxdFWReUKLqAa8IGi/imBJ3Lz9dMzN1/su7Veyv42rfOGF6Cn9aTpCk3wdoHvtF2WM+tsQrRKMqn/l9YnEVNQfH2VssazDywmlTzslYrqfAJPtEzD0+7AokQ5T2hWlkx0lX+g4LWAhvxviu+vVDMB/X8KYvXhXsRb4TBIqUkbZNk+A1TrIeCzBJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wykMpzlL8zJr1Arbp1twAubstCcXJTx5rFhUPfGTJSk=;
 b=z3qAtL2ZIAP/oZcp0By6FiXZcS5UYtCgpZBMyxL6jzvsdbyl6o8c4teevA00cS++iS1TZZ4+rI4NCOUrMaqM7kIkfo6ycIt35NmyD6IsEJNdgAuWP0TYwBh+IUvea0etZ0kAlGlouVjLvUYXQZUt6a+hhz2x2RlU/LC3ulwIbUo=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB5770.namprd12.prod.outlook.com (2603:10b6:8:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 07:56:42 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 07:56:42 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: use u32 for buf size in __amdgpu_eeprom_xfer
Thread-Topic: [PATCH] drm/amdgpu: use u32 for buf size in __amdgpu_eeprom_xfer
Thread-Index: AQHaqy192FwQ0+nD9EaGkVpGP0TeebGhUmLQ
Date: Tue, 21 May 2024 07:56:42 +0000
Message-ID: <BN9PR12MB52572F6274C05020F6E565BEFCEA2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240521031724.2612-1-tao.zhou1@amd.com>
In-Reply-To: <20240521031724.2612-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bc458c89-348a-424b-b716-c0069b4af47e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-21T07:56:21Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB5770:EE_
x-ms-office365-filtering-correlation-id: 91c89915-4e24-49c6-a09d-08dc796b8db9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?UtkBN7wuHqYP7nL0TCrpM/bFAXfzsC9cespbrbTuzsWwM4yQ+EabcJTE8SVU?=
 =?us-ascii?Q?NlIBPqGCeeY6dcNJW3zNJZelQAj1hdawJr9khcNL2NGrZAHoOqQeTS0InEHO?=
 =?us-ascii?Q?SOEUhd+7bKkQrbBMuS5IsQKy+TOfNC4DpgDIsf8u7xSZ2/HE9cu0yCCyG0FL?=
 =?us-ascii?Q?wP3UCVuxu0DWIyUvJmwEEKOOhVvUPgnevLGSnfnny9iH/U9EZptn3pfmQne9?=
 =?us-ascii?Q?f/Tb0P5msuzlAMKfExwydOAPdqzUcneTQ7pFoHbgrTzEefpZgUUZT/oS90w/?=
 =?us-ascii?Q?ScJjawRQs6DUEhILvu3lyiKA8k13Qk7oHVcVs3Ia9SamqDvrTwCPmewdre1G?=
 =?us-ascii?Q?I/hzndVaPtpelDoqN51NtULHDQBBkZix/xczJUsuMl/avLNMbOUjzJ8hvq3P?=
 =?us-ascii?Q?6jl9JStF6SgHZFWVr+/4RiLkFxVg2iiHI1h4H/Vd0JjBY7UEkYyHF1STPH/6?=
 =?us-ascii?Q?ob5C+JOE/Rgau0QO6EsRuelCAcjzhdTfX7s9DV47xPQsk3ZGrl2YZu1cTezD?=
 =?us-ascii?Q?IPi+KITFHw61yAbo4iRUTOmYDGAHZs7FBRWB3iZ9/jAT+N1WZ6GQJ0ZgG2b1?=
 =?us-ascii?Q?5/itefZGbuqvRIsw6F/fIlN4pNGjLq8mig4vNytRFAh2CYJtCYe1rus0OiES?=
 =?us-ascii?Q?b7Cl6WmIC16CYWVnMrEssoRzxZFOISpKGeRq3GFNpeHtVgPTVaSv3cDIrRLP?=
 =?us-ascii?Q?fNBNvUcSJx5C5h6JBzvTGErCnEerqkQQAYuO0XyfycV33e4PDH3x5MVsUIS6?=
 =?us-ascii?Q?LYyZ7L4aZs16tymBjSD9Rc2A+ja4o4ZljbQF0hueosdyDr2kr/1LZ4XnePEa?=
 =?us-ascii?Q?0jGlpztIuS2fU9RNhAAhli1qrzZRH+zIWauS6trv4bs01SK9WsIH0WNiNinw?=
 =?us-ascii?Q?HsBSWZrUwiLIJzsY0caUADnLSunvXoRADY6CMp4jvwIE7MI2TUCj2AVbHInV?=
 =?us-ascii?Q?QtRx/sT+jh6rk5k6z92LMwAxftfSEjM9yuhXbi46jRdDkwEAyfrUh6etcCAz?=
 =?us-ascii?Q?RrorHxI8Zmd/IQCrIIwWHHj3FGJFc8N0K8Z0P3SKkSVroHJXhsin7aSKpoX9?=
 =?us-ascii?Q?4W8lVna8bSIQ/5DPSUbA2bPVxLmL42609ehvTNq6kBJFUHg/5+bhlh7n/5tS?=
 =?us-ascii?Q?tvQZBOK7WSdGkbJyEQtQG3/COV/SYRnMDg6ioNAxXWHkv8tYHt2tU+pMlC/9?=
 =?us-ascii?Q?eGxXSctKIea9DYFz72NKO5dJamnENDIhy/D+G4eHpTbR3b95hGpSwsLDdsn2?=
 =?us-ascii?Q?ckO6UyhDJeoqyowwyhZXAZOHM/D/U4xpU+xybCMhX4Ld8drURnEPSdY5Ng7J?=
 =?us-ascii?Q?A6h6QHBPVHUofZBSlfih5jsY?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tCLP+rzkPYmBbXXVXZ8KLNCrFtypvgQu/H1JW8Hx3wiGGqJpKIXLFYeGU/SC?=
 =?us-ascii?Q?4fv9Es7ydbjV9jg9wGYXXTNw8ZObcJzQWtPkUn1+pGGTQ4oDPxm00m74WBbu?=
 =?us-ascii?Q?I5zDK6i10hp+ngMu/rdEtr10fY8PYU2PYeUfA/0RdqhL0xcXTd6hDPx/boAg?=
 =?us-ascii?Q?vKvRv075+/gEtAQbgR/P5JDcZ6cv3a+DvlATtiOzpb/BUPkRPeLm8L5Hlwo+?=
 =?us-ascii?Q?QPHWCXoZxt+2eVNONxj5RtILgiQkh5Adl8taRaIt3PlA0ymr8yHdRz6TcsPs?=
 =?us-ascii?Q?ltmveZr0Sepqsindb7zQ9pzlqaILxdUdjPiTfgBB8hfehaaQ0LPyIsnoULLx?=
 =?us-ascii?Q?oMwzc1xWY+psiL2UGfqny3LhUP25KW1s75U9Mn9AgonyGBLxKc5oELJVzLYX?=
 =?us-ascii?Q?JZnEsFV71I+agioDzvx4nAOjQ8zoAuzSCPM3eu56hu48/jEDf056JAbb5mY2?=
 =?us-ascii?Q?jbNoyCll6/3vdwXBXPaTMlBFDyEzt185tY7WhIT6khX8WoLFUpiz9BjQtNKa?=
 =?us-ascii?Q?X9xap5wWrUDJee0ZWp+NlPclMaz7UlJgc9EkxdQnZRA/3KJ3XV1jemsurTmd?=
 =?us-ascii?Q?6dRwa/BWfTSeBcreTpw9KIVF8zp1uMoQRXIZ+KUHHkqBl2tXgtMYFwRaO5M2?=
 =?us-ascii?Q?fy/xqjzTKErbMf6Vdj+KJzt5ZSizAh9eh0DH7AUqc2kk7YVXxZdDG/Bqh2GG?=
 =?us-ascii?Q?yNlLZtlOg7S0MOL0DMT40q8Ma8KBX/JuuRVu0QBA/IcJBHeyZcNKYJIuZAL6?=
 =?us-ascii?Q?oYJPVPmg84puqY0o2aK5CpHLww2L1Dto2PkuZyC2kN9PElZ7w/meVkE2Qw6c?=
 =?us-ascii?Q?/wlqOyOU4JUm6UxJQflfqCfJlJik1pOXk9MRF4ZLW5U9KAkT358tuSqQVQa3?=
 =?us-ascii?Q?pM3dc6htkJHRCKIdHnXDdLA29QTsmercZ6wMkLpProRymVFsPYJO1vnyTKd3?=
 =?us-ascii?Q?gOi/jS8KE1W/nEZItZbdGKieVRA67YTXIpKccXMyHV10cb2S1Z6Cikz0TKOO?=
 =?us-ascii?Q?FVFnQMIPWM+tdMLapT9ELhrqCr9Rd6mNzFQHzJXhh1f+ygzYhI+ASHbgjWQC?=
 =?us-ascii?Q?HjvdRbOOVMKUPG6iV4Svg+S8KrDugrUfhsbVwCWLmDxBoOMPFDt6dCDFZGav?=
 =?us-ascii?Q?67v+3gFrttoqwH5ovCLioOkp2uZB0jD5p2u1SHfCLOUAATkLxYX9IFYUa+vk?=
 =?us-ascii?Q?+QBcomFO0391xlVJTICmGD0mycnIP0Mx80t4Ev4GEjCpOGjzhJ3HhfouKtp6?=
 =?us-ascii?Q?Bq/LC5TkwSjy4qT0iqeTA4TjQJMd+558LfzxFKVoHh4iVcEhEJxiHIcd45ph?=
 =?us-ascii?Q?nM8F/kiT+ZKgyeQzPj8SPYihTVpSHgkvXc+4P+BjPMjIUW3zPFQIGUxVLgEx?=
 =?us-ascii?Q?SEV1KtRZ01EgXEEEDCZpqM3S8o0hbub+zwHrP97BsR7JYWnG4z10/TcaBBaf?=
 =?us-ascii?Q?x5lENE3fL/jnxEBP0907fJ6dcAnVRXqGpJEtr9H9aAvny87w7cvbsiCpLaCM?=
 =?us-ascii?Q?lnR+pQlO3vmLHkJB2P7ccjwXILq0htLUZrQXwqakLUe/sHTktWw87pPHSWUp?=
 =?us-ascii?Q?wiOmf4DEKW87PY64IbRn/bplhXUCrHMCqW4Xb7au?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c89915-4e24-49c6-a09d-08dc796b8db9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 07:56:42.5907 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vCpqdisjmLr6ZKdDglGAInzHsQun52Xm6sQAwDngupnJ0hg6+ZGBqR5BBonM3KD/IqpfLcVIfKaJoc8Jk3Ya6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5770
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Tuesday, May 21, 2024 11:17
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: use u32 for buf size in __amdgpu_eeprom_xfer

And also make sure the the value of msg[1].len should be in the range of u1=
6.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_eeprom.c
index 09a34c7258e2..35fee3e8cde2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
@@ -90,7 +90,7 @@
 #define MAKE_I2C_ADDR(_aa) ((0xA << 3) | (((_aa) >> 16) & 0xF))

 static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_a=
ddr,
-                               u8 *eeprom_buf, u16 buf_size, bool read)
+                               u8 *eeprom_buf, u32 buf_size, bool read)
 {
        u8 eeprom_offset_buf[EEPROM_OFFSET_SIZE];
        struct i2c_msg msgs[] =3D {
@@ -133,15 +133,15 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter *i=
2c_adap, u32 eeprom_addr,
                         * cycle begins. This is implied for the
                         * "i2c_transfer()" abstraction.
                         */
-                       len =3D min(EEPROM_PAGE_SIZE - (eeprom_addr &
-                                                     EEPROM_PAGE_MASK),
-                                 (u32)buf_size);
+                       len =3D min(EEPROM_PAGE_SIZE - (eeprom_addr & EEPRO=
M_PAGE_MASK),
+                                       buf_size);
                } else {
                        /* Reading from the EEPROM has no limitation
                         * on the number of bytes read from the EEPROM
                         * device--they are simply sequenced out.
+                        * Keep in mind that i2c_msg.len is u16 type.
                         */
-                       len =3D buf_size;
+                       len =3D min(U16_MAX, buf_size);
                }
                msgs[1].len =3D len;
                msgs[1].buf =3D eeprom_buf;
--
2.34.1

