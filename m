Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32541CA0FF2
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 10:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDC5D10E73E;
	Wed,  3 Sep 2025 10:19:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hqBHwkse";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0D5710E201
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 10:19:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQ2PVFNk6SKJqbN+6MNzmVl1Wz0/tsbThlxUgps99d0GwIuChX9xGSv34bk1il3UCuY/S5EeTjHJgPmB/S0cDVS1ZT/fnnDjMbxMahjPTGtBgCWlRgdMtd1C0bEQ+k9WMSRTFjO2diZEPDUhOnEh0XOnaJ2dsy8tTnHUg8+uFUy0DwAD+6gbmAckJuhVuSwrdIkkg5rOnJ5TtZH9ADK6bV/T58ENa0ie7PmEEb0ZxPP0ouOu9phO35ldbMQ08Cb49agM0lkgsjHWNgdGrM3+qlHkAPvWs9cTZN2roakiR7sAVTgSTqaW6Swz08eb+DCrPKo2qxGPJyOO5NhaQt7zvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzLXzaK1JREusxKLwVaRbyNq9+UOkONbWX9DUwmUqFg=;
 b=crt6h9pKCnd5sdrmH8WuSwQXp6z29K6hm45bY7fx1yHrZUXLunaRl97zfbpF72OxcZm97DIkiaJxpQfNqMJojV9mPooF/t6Aqo6qWDGUBm+qaMMO0CrCH0o0R6bZdD0178wP0iRxUxc/bo+S3US8lL73LTARxbcWoUywZA7AYThXMWeB8dexUuztHaEhYRFItaig9V6TsJL2r9ZZM2hBBFFScviz/Xs6FEipT4TqPRx8f6pWOVLXQBcKwpLY/6obMb7ZA0kYIobDSeEAHFso77aITDMcRwwKK9uzMrhLmUHjiXEhi+Wb+j0Ru1V7i61ZQqze1So8HsmbB8P3Tq0J2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzLXzaK1JREusxKLwVaRbyNq9+UOkONbWX9DUwmUqFg=;
 b=hqBHwksetI4YdjdHQHFrYlt3Tor5+gkOh1QWA6Vmxi6cYt1OWu2/ow6CRhzFXkUPmnvAheddn10FaYWvrGAJFxyZEfpe5USm4kK2MpHRZq4Rfz/GlRdRGm5l/NW/yQopXd3KGFOmSFZOvuWtwfln+lSouOLWmY53VAReK/Ek4dE=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH8PR12MB8430.namprd12.prod.outlook.com (2603:10b6:510:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 10:19:49 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 10:19:48 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH v2] drm/amd/pm: refine amdgpu pm sysfs node error code
Thread-Topic: [PATCH v2] drm/amd/pm: refine amdgpu pm sysfs node error code
Thread-Index: AQHcHKqrZ6yrIprImkaeJ0ovOUkPsrSBPxCA
Date: Wed, 3 Sep 2025 10:19:48 +0000
Message-ID: <DS0PR12MB780497CFC9F6699F7217E7189701A@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250903081331.1359048-1-kevinyang.wang@amd.com>
In-Reply-To: <20250903081331.1359048-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-03T10:19:41.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|PH8PR12MB8430:EE_
x-ms-office365-filtering-correlation-id: 1002452a-c49c-4da6-9b99-08ddead369ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Hx41O+buhQh+mGLP0d+VAKWeJVmljj9lc7E91jVDiEY74p+QNIOZKo4nnDPZ?=
 =?us-ascii?Q?sgEho88IJR5SHDOnZGOH0zO4dsS9ieuLq0BgI608tEFmWDKwnWL987DU5QeO?=
 =?us-ascii?Q?5IKTY61KcdV47wLrjY9b/TlS+xMLgmDScoRzLcDnt0tIel1vzzWIxILZcdsS?=
 =?us-ascii?Q?HfZxIzqfhJjJbTXcWz0ckovcTAYa98SJ95kQR/IfSQVlu9XeaK7tvYmSexw1?=
 =?us-ascii?Q?jljw6Gfp+jvI0Q94PYkKroMcpSZlDA7wYKeXvIZtWmyjvk0StQu2FLgzfB61?=
 =?us-ascii?Q?sgIf4hzmfD9Na/J5TDCkbjKG18XcQp3/PlkNhdo9YN5FJW/jnqMEizmOGnI3?=
 =?us-ascii?Q?8yIqkhCc9sQslbMJC9LAa6AZtGP0BeUOvjq2GWZ5slurCw/dotNncTU3Brna?=
 =?us-ascii?Q?dZybHdg1Vcva9WplEC7XmNLChmE7U2jciTn4Y95hiSol3C8huW2xiJ3acmdC?=
 =?us-ascii?Q?wnXzpfNDj19v/WOi1sr9eZ6hiZg2RcoXK3wqqrR+xl01Q1Jm3kEa9SPLPRh6?=
 =?us-ascii?Q?vEZq17WEzLfCJZHD6gnlCo/IBNGaF6D1Z1/xyqKXJVjX1r8UVBK30qHLaKer?=
 =?us-ascii?Q?bHce2JzkVDUNw/pjd57g3dytW/+AsBdP5QqLPuMmR0jO1CHINV1ldmMLkNyl?=
 =?us-ascii?Q?pVl0hwxunQj8UGAxvn3StoyjbOIIKayC7vz03VmwBvGYJFzB2Ri0MrreLzAV?=
 =?us-ascii?Q?LsU4RwLypoQIJvImckf8DXrQWArwVeN5yKmOoxPSiIwz0yErn9PlYTd70F7U?=
 =?us-ascii?Q?EyUy3m4/6ALqOQTNm1QssckIUrv6mjiFp91bs9OrHvR7oSZ06SF33T2kQR+b?=
 =?us-ascii?Q?2it0I+5f0sRUMCtnDQimpigSyQHaCdgkG+ZtwD7dk55HPq/VB/OyzJrwk/N8?=
 =?us-ascii?Q?SuEsmLcyf2hva9noEF/WZ14PKK0LeGOoqpe7haVKpzDXv/LRA7bwFRyGFGFl?=
 =?us-ascii?Q?paU+ICB9syyXDyRZvDHniwboI+TTAokr+BoG58ZCbZe6dfEK7WIevGR/G5DD?=
 =?us-ascii?Q?GUUjuoJCg5N+MJnZpp9+iLdtpFeANtHZLD0S+r4e4VQYigQvVyPlqbBwkrYP?=
 =?us-ascii?Q?ipJM3QCTw1TB+gi8IxYsGDCKdneoCSdrnQOoCFCWPdfJlFk908A2VyAU+rnm?=
 =?us-ascii?Q?TLWjypwR/weSiXmvcPB8jnEU8NPfG71GzR7kjdpwAd3+Ejv4Jlu4zeL3DHsR?=
 =?us-ascii?Q?w0/0pWT7Oh6Q5k8t6wAz3t3QNx89+BnHhL5Kl+ZyhOXYaSAw2wlXHmY/qErQ?=
 =?us-ascii?Q?3dbypYMvUMJloGwB7Q+gCkg3jCHyKZHkRfqOtvsS5YTmn0J3Qnc9CRosN3zw?=
 =?us-ascii?Q?GtpqXiQTNbn/dB0CGCZLlsl7sIxIu0uPv78QJXygYI1RFRLBNS+p5d09gfWF?=
 =?us-ascii?Q?XKdQxQU3KLK55uEzF8zGdW1j0FqnArgYisDHYvgzP5wc1gq+08mevRJuJtno?=
 =?us-ascii?Q?pu2zjkh+DMH+yZvYbLl+2SkoiAoqKPIwj0P0YHlmcAI9T9UyZ94j5iiqr0RD?=
 =?us-ascii?Q?VR5PXD9DBRqD/hM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1PPXwljvLgf6zKkMqSdQYxb1kt7OdwrWkCf3gWYWCl+uQGJf1A62zHETJsMb?=
 =?us-ascii?Q?mvOo9rsgPgQCbY1au9XQgeWfLDWiFDrZTBrUKjQ9YnQxrtDdu8rFlU/QTpkD?=
 =?us-ascii?Q?n5trd07w9j35KdM4vUOOFtnsJQ0r6+G9wnvCF4fe9XXAMAWj2mU4Sl5zRq5C?=
 =?us-ascii?Q?L7LBaKeSODB3adtgVjidjUsRgBo7kCttR0VA9gO6Cy5Q20TCIAbCDwLxQKdu?=
 =?us-ascii?Q?DbpQa+Du9ulcyQQ63BJTwsghsQWqeNhQkntKaFky94Uh/1A83OUtFVMbJeVh?=
 =?us-ascii?Q?IlrHBQsOBz7ZZqP3J7Q1T87moimYysImuXjo7EAW6RM0fBJVrhHjIIf+zRss?=
 =?us-ascii?Q?q+8HdlgkdOF1YZjwiEBrIZSV96sBRC2cSHIP+dh8zwC4lBjqnkQVNtGID0/+?=
 =?us-ascii?Q?320TPDcnDk5CNB0Ta2Zpq+YHvugZP6z8XEl2IEmVvyzxVTJPidggu4NGuDCS?=
 =?us-ascii?Q?71L66KqKaaElRdo5U79qvUzfaa6UT/dgFBrSBepYV5MRnYsHXZT7b1QXbVkZ?=
 =?us-ascii?Q?8s+d7wvmDBs7gz+2Xf+bTfNkobH+yOPDMHJrfS/XVXnHl+0ytQ1Q7kARh4bt?=
 =?us-ascii?Q?Pdv5asqk9zlO7HY+USr8oKXFrcxRzmMrpSmnBW6h/ktINWVGbu1VpXx1McX1?=
 =?us-ascii?Q?HDa1BPX1KCrvXjojVQsWpHG1c2C4ZfqFuw8wdYBi5NIhaC/1rrXoo1qd25yo?=
 =?us-ascii?Q?Couhx5+wkoBJ4z+5/kE/Mgjkxe5af8+/AnxRQdVHXp/82YpFx+v2q1KoSlct?=
 =?us-ascii?Q?4TjLO+D8x1i9L0iuxA8Ho0EDUp3hG+3ApXaNdHoU/eSgmyqQa07umLZdjTcQ?=
 =?us-ascii?Q?YvR0LBF5tIVC3YVqrCCApC1RLnDuqoOOH+c9xleAZ4+XtQx5oeXkdzP7NW6i?=
 =?us-ascii?Q?B/xyXi5mLvD2td/E5x0EZ6vE6dx3EtQC1hy8Cux4xRtU/ZludKM7QOwy7NjQ?=
 =?us-ascii?Q?MeKVBaGB6V420zr0mCQosqY5MO6cTzMU5vwU9jD4CBkIp5LZcM1ulXBgpx7q?=
 =?us-ascii?Q?jLrIzWxtdYfA7m361ka8MK2m9w4KXtkOGtG+CakqZwQWrtOuUYw6wny40hS1?=
 =?us-ascii?Q?QJXOU0nFFKY1+Lc38QLjYNazn9Xb/2WVQ4XZPJrJiyTo8lUJRQ3c4eHnRJ3L?=
 =?us-ascii?Q?6Zgef9jcZXCMj/S0BYIR5lBPa+fjLZHM+ZqT964mz8iHar6MjgE0sj7Xl4W0?=
 =?us-ascii?Q?fA+U9F60zSOXM82SIL6Y6xoR9m1N22m05SlByfQ59Pu9E1V+fVbLlVfQ1Slx?=
 =?us-ascii?Q?ezXKAojoIVdYrToTQUXCpmFvmWQ7mKY2ZfMdHpFc+fIhrdB6a1Yj6YtPZ0Cc?=
 =?us-ascii?Q?3e1FYjlbc3GkTrScrpLj+6TpmXSZzpYUC2J1ad58a1qbGQI9g26oV4Mi4wbc?=
 =?us-ascii?Q?iiOLtBIihFSSPbOgNmLGHtJLGF46j80cpot1pri5WqxqkHfzZbY5v+0F7pMi?=
 =?us-ascii?Q?5wPvF3348C3Hw4396l3oCRsYTP9D1MKU7csGl2m2WIN9xohydIVzgAzUc3fN?=
 =?us-ascii?Q?LxvzRqimcsZRsXMbj0ASitc6s9Cq0eLrZM1XJNabzuU0YBJFTu3GbmIZd9PV?=
 =?us-ascii?Q?0SPxZ0t9E5hMr4ujJe4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1002452a-c49c-4da6-9b99-08ddead369ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 10:19:48.8079 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RDNuURcOv7NAkjsHbqFk3wG2+fDg6QqW17oUyRcmyZ0GOHSLOOe8ZH6tMd4wBmpm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430
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

[Public]

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, September 3, 2025 1:44 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: [PATCH v2] drm/amd/pm: refine amdgpu pm sysfs node error code

v1:
Returns different error codes based on the scenario to help the user app un=
derstand the AMDGPU device status when an exception occurs.

v2:
change -NODEV to -EBUSY.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 0906bff864cb..c2095fce694f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -110,9 +110,10 @@ static int amdgpu_pm_dev_state_check(struct amdgpu_dev=
ice *adev, bool runpm)
        bool runpm_check =3D runpm ? adev->in_runpm : false;

        if (amdgpu_in_reset(adev))
-               return -EPERM;
+               return -EBUSY;
+
        if (adev->in_suspend && !runpm_check)
-               return -EPERM;
+               return -EBUSY;

        return 0;
 }
--
2.34.1

