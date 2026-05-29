Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68419CD4F54
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 13:15:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03F4010E192;
	Fri, 29 May 2026 13:15:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lFDqTeQD";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 811F310FEF7
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 13:15:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZzTrQneY+8A3U8RUhaDvbN+bkIUUL1+q8HO6B1QENCT4WdqMfGN1MLPtLjvR9nxCsftxzlonxILG+mFMugYPuDlJ3ayCG4RhljgFfEVdQJqJRdVocoojI7CpR4D+p0ma3YSDgg8vXxa+CIuTsmZV9GRpV9jeVAj8i1yqJOx/8GBDMBsBtvwZcE4cWxlD2gpfZKqhUWa4cugpb9TAOl9H5bHR/yZH4poCw44kfpbUPpm3jNFsRetLJys5I+08D4gZucE0dKneOoNI7QhBxJls5ZlGBc6NxPtGTTgNCpz1F95ZoeOJK+C46l7p0bL6TzXYEBcwVKr2z1HoS7UXdA9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcepKRcmVja3BwDcQEKPwVAFyKdSsRaIc78H8dQMlrg=;
 b=sFNrZhtxSHwjexoGvtck2WCjFsq+fIDOC/J/EF6xLWM2UmA17qfC9nMhntwf7WtCoql6zPNyQHVQ7dnKSuXoh3aZVsX+0JDme8ibdXaxQe28LeKHX8LLtMOLUMcbzhAewoNVYQiKLV2gJEYTj8abt1chZo2ZdeViycnp7Ko2RZD7Exg174rew0tkUpaow18rwmyuTtVPqyWbeEkOSkNtNv/HAUrVAe+huwniw3tdDnOmjzSYth0R7RoXK1SlwsF8iVFYDfH2K98KxOD30CRX6EJovKoAn/KNO6TJ4REnE8GoIyNQcmYa2/45u86U1/V3Xy3gcfthNt9cEFjlGSnhuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcepKRcmVja3BwDcQEKPwVAFyKdSsRaIc78H8dQMlrg=;
 b=lFDqTeQDSvH3n/vydXpFeLXqk6pDADR0ZV2PIsayoHsxMpEwLwhAk6h1ttROaSLrjEIEDv3NGOc5cwc4mWg0XtdZXAZVgefuSYO2d4awTSol0MC3SW6ox3JdRgl/2028xYBkpHPLe2vO41krLJB9ts6QRIeaBs9XzWoCVavIoBQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA1PR12MB7640.namprd12.prod.outlook.com (2603:10b6:208:424::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 13:15:25 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 13:15:25 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: Use strscpy in profile mode parsing
Thread-Topic: [PATCH 1/2] drm/amd/pm: Use strscpy in profile mode parsing
Thread-Index: AQHc707vpiPcrUix3U+PjXJqi5f8abYk+39w
Date: Fri, 29 May 2026 13:15:25 +0000
Message-ID: <BN9PR12MB5257E688041F8E333592F547FC162@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260529093820.1134317-1-lijo.lazar@amd.com>
In-Reply-To: <20260529093820.1134317-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-29T13:14:18.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA1PR12MB7640:EE_
x-ms-office365-filtering-correlation-id: 56596134-b64c-4118-651b-08debd845899
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|22082099003|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info: gtNNRW3E35MUBCsHopim4OzR2uD6coNVto9KwLroFStQ+T/rj4YJ6RPGxtqQTs3gKeih6sKrVG1LuiZ9QWFLFrs3HlWml0nuogcGqQlYoEoINEWKBv1X4JFWR4Xi7nyzAGVy2USDOnXfwSJmU6oIolIQ2eDFkXcb6PYn6NZ462HNMcjpl6O1UX3H7VgEF95BWpmZGF6M1u6y0XMcTZySBFT8jmLy66rIG0GrqMiKjmshBV0SQOQcfzg6KgdTSuElHWphPUy8FVDTD5G0hglYKCtpVTDPUYt7WuCn6nHl0GQs0fHoExHZUdxqYE1L5YHF/5wiVz+ji1U3m/cq4lsucT1n84rZ18r5apAJ4RAI7kgBStS2y02xSILOGBL/IuciTYy4o4/yAwX43ZjPPKYzWNFZVbHXgAPrA+txDSs1FW4WMC+KwFzxbYovZBO+ojQkrzlulz3pGreAB87ufYHC52qHnQC8vEqjzTZtcvIsdqrYVKYx43BlhlnJEr8u7DP9D47spurKfC/SpZz5Ml8MWoTSPSlIjRVD7j/CeHGj2X+d73hg6k1NUG7HCPBMNmnPd94X2PGZgm9rSxqpmIvYwsV9eG7l42UQyYy1y+8E23xQ9A0z7bdXtKshDS8h6B3fSXicmovDKcy4bgBjcM+swGLlTeoq7XshO+dh2I0Fk5F921tJ5nefONOA+DywnxgGaOcZvLanF7DOtXZ4QwurANGgpVceWvDNlunEe/+s0goc96SjxEVMbY5wrH6dqOtn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jDAu3Xh5MBO7o0ILkRDGG1pckYDoNJwYzi0TXY3vdesXyLWiSJuUAiyBYNpe?=
 =?us-ascii?Q?BjoO+0JkJaEroSwxc0eWNqpU0ELtTn19prOP2Tr8LruwqjGipZim4M5UcMV0?=
 =?us-ascii?Q?dPQ+BMxR5bXi6Zb3U7bLR1TmdfpzzYgdB9CuPmYEJgeBsMJjrLlrqFnIvMEW?=
 =?us-ascii?Q?70AzVTB+BUg9t7tD8jSitgA+rNgACqrnVOXB2RDzvlesOLnO0eliiJIJfHkG?=
 =?us-ascii?Q?7hPK43cfroezKpWyB9kaUOMw/9ZLmWrc+dMlLR1ugDoRthM89kfHJOctr8CP?=
 =?us-ascii?Q?jDA1sZ3S9wL7AFhZB+slXFK5yNoBDkZD6CwvxaB6HKQsjHCKa/ieDIDjaZgI?=
 =?us-ascii?Q?4NCWvW82dVdrIskHilimJrlUEpEgyyxugIo+QbRW9+/AedOTQNTvabZzvEqF?=
 =?us-ascii?Q?D3f8t/2IrKhXoJGTTZhiii4SHkLNutHkmVMOEFghyRseruxPnrIljBaABp9H?=
 =?us-ascii?Q?qDCpJQUbix9PGwbKYAc5+lsyQ97pK4oESYB0Z5T27VU2P7+BVbZ2Vz+bJMav?=
 =?us-ascii?Q?Jp+l9HGYIMPbx4shBmCAJ/UBWNmjLcWcDq7vSPgfvPjnCo1aVBx/bno0mPpK?=
 =?us-ascii?Q?dLHfYgEI6N1hDIlloxclJbMZ2b10lqsz+hc1OuG3ynr7VND/+bVSJ/eqJv5w?=
 =?us-ascii?Q?z+6cL6fGOsQXLpu7faa32Ms5P2xJuT94eWHosJTZec+PXaDDjtKhQG7jbzVc?=
 =?us-ascii?Q?0O6j4Jd9UT/j4LV1czx8mXfi9m1Y80+5ElJR59lNmLGgQ9ewTQwBJnWlQCc8?=
 =?us-ascii?Q?HOsWUL0beenrCmQPcryCSIUTwWEanAKCSqSc4qm49iZuKVRx54ZU8vCddFjq?=
 =?us-ascii?Q?7BVYgceD7WSsyhbzCaKQcG3LCxJSN9LzCTcHNaIYuW9Dufsvj7UJFfBWdH5W?=
 =?us-ascii?Q?1BBD38qJrRC6yJfyyf6Kfo5lsGpyvwu/BdgHk/NR6bA9JCOqgscxosC5aPlP?=
 =?us-ascii?Q?8YVgD/kAOaSZKlP+2ml5J/fx/RtSPAJt2aTG9cHE79RW3kR91xhwKniAix/8?=
 =?us-ascii?Q?OTW+EnomzZ+QE3/Al0IPXfOlQc/delMNmH2F7kQ/v6ji/SWMIOf28pGCHX4g?=
 =?us-ascii?Q?CPDxK+lA5U86o4vw216M9BmLyuj7BleYvP5CQYQ9bQItMwiHo0HHFle369N5?=
 =?us-ascii?Q?jXVnqBnjcSIYPaGxUL+BUQGWudzmq1GY0ZsbPO5YuUxmZU6b+gH7uyVIsAhE?=
 =?us-ascii?Q?balxEbTSjcBrzG6IgFxi/kgUbVgYsrfWyn+FqLxWmAtGrpW6uMq7DFiPH847?=
 =?us-ascii?Q?voCCYhkhsw0IvbLrpNRbeVNxzRSYaHnz1AmbYHOWDgpURyPAL78KTg2Nqy7I?=
 =?us-ascii?Q?Ih0Vrq3P9KxDvYF4VDkSWkIN5rckXSHFJQBMeX3eeFgnScLRLa4yMTZ7o7VC?=
 =?us-ascii?Q?7/rvFCJgnH5ZYFowV04jD5Vg8Ve1qQh3thISwKTBRATlATx8VezzEPty0bF9?=
 =?us-ascii?Q?su+kZUoVOlwyRjDNmnqf/ihTixFL4WsdquaealKJsqj8aEZ+NRnyvzHwSdLQ?=
 =?us-ascii?Q?sociQGOXmpnge6iACHDHf7cX7vWDqkL5VI3oYDSkToYzKFHFyz6gunAZ1+35?=
 =?us-ascii?Q?DNW8bYRK/eOFZYVkYjAaBvpRpGVI2zh8P1PUfNy4Qea+AE/PkNxGHgdtA2sg?=
 =?us-ascii?Q?yfPzn44p7nWEg9ODFrY1us5Gcep3laTE0mV5kWX3HBINfP9LJI9RiUTHNJIb?=
 =?us-ascii?Q?UX2DKmuNEniyIsmScxGBHdusxi8pbbKrErTaAcE75qlch59u?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56596134-b64c-4118-651b-08debd845899
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 13:15:25.2247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E2eq8rQpGUHYOBd5AN+Fm9l7N+QM9Ro+B4QYytYRHJKE3RFCZH0fHxNCJ1+La5g5FjDMLMN8/5Siefh/5YlQRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7640
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

AMD General

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, May 29, 2026 5:38 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: Use strscpy in profile mode parsing

Use strscpy to copy the buffer which makes it explicit that a valid NULL te=
rminated string gets copied. Also, make it explicit that the source buffer =
can be copied safely to the temporary buffer by checking against its size.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 450ecb188aed..ebe0b320ca4f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1375,26 +1375,22 @@ static ssize_t amdgpu_set_pp_power_profile_mode(str=
uct device *dev,
        long parameter[64];
        char *sub_str, buf_cpy[128];
        char *tmp_str;
-       uint32_t i =3D 0;
        char tmp[2];
        long int profile_mode =3D 0;
        const char delimiter[3] =3D {' ', '\n', '\0'};
-       size_t len;

-       tmp[0] =3D *(buf);
+       tmp[0] =3D *(buf++);
        tmp[1] =3D '\0';
        ret =3D kstrtol(tmp, 0, &profile_mode);
        if (ret)
                return -EINVAL;

        if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
-               if (count < 2 || count > 127)
+               if (count < 2 || count > sizeof(buf_cpy))
                        return -EINVAL;
-               while (isspace(*++buf))
-                       i++;
-               len =3D count - 1 - i;
-               memcpy(buf_cpy, buf, len);
-               buf_cpy[len] =3D '\0';
+               while (isspace(*buf))
+                       buf++;
+               strscpy(buf_cpy, buf, sizeof(buf_cpy));
                tmp_str =3D buf_cpy;
                while ((sub_str =3D strsep(&tmp_str, delimiter)) !=3D NULL)=
 {
                        if (strlen(sub_str) =3D=3D 0)
--
2.49.0

