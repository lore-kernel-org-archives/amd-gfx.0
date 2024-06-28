Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1569CC2BBCA
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jun 2024 08:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6612310E143;
	Fri, 28 Jun 2024 08:10:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AEKB6eYf";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 128AF10E163
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jun 2024 08:10:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nt6Ezca2kdmWsOy/egTX/M7NBEIxtcd1sf2ARCC57fr1lc8ikbt97cW//bRTYEPGPzEGnUNsHgfy+tt+u+SmBJWm6wBJ5M8CO/2FiJra6SqBIfo/9rXu8crVWT8OfrK7NTq9uvnzpZ73hDPrPvug6sT/VO34dUWLAx/jJZLC1iyZLVeV+aY/at0Q7NfPWoYrwH+1g29FTjiXOwtDb9ys65abYSmStVfTsMyDQCDbrftg0vIcWGog0VgqeoF+mj10bKY0YyXM1jtIomgALy7wS+aB02kApITBmEDfDco3q7VW36UV373/WFMJfb19OijG1MwxiOwKLuxTp0W15nwx4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytzD9+62lSakutfTU3OnqOgSI3TxJf3/Ib3q2k4lWHY=;
 b=Zbs0lVf3CGQ6TpnXrsMpAFMgatHb3Ny4o+knf0OFBW4GOM7s4z35Vj2kJNthKqldIPHPfLQhq4FNyOxlyBUTaEBdE9W1oc77Ymmqa/4Kxu0z6vUzAXqKnSR7oCabRvWw4t3ko5QQoEdSmwsfJhmEkCvQ9bH3KYSZ02c8p0A9epxE2BrqcHg1jBETjQfZCqFeLWaBNudeACdPsxK7M4QM3mJ8PoBNyXBf3hvlyQxpqKFXBtWM39onisZeAbezomM/koVtZxK33CB/1QX4Hk4z+DQv9Wn3FVqS5s0usqxjHD3E+otz0ageySk1KihHqsq9SMR73r7UVW91El4XPyLU0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytzD9+62lSakutfTU3OnqOgSI3TxJf3/Ib3q2k4lWHY=;
 b=AEKB6eYfIa3DkmB363Hi7dfDuJsDKgoBHF08P6yaUKmagN/d2viM07QlGmHoHFNuDHj2mb+kmmxVsxDaddhUQdFxvPov/rpFlbFLICWeLacadOwtVzi9CSVKzJJb6iFlQvOBgCrLRtDTuwlzboeefg4PW2/69GppCZIG64Dmbpw=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.36; Fri, 28 Jun
 2024 08:10:25 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%6]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 08:10:25 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: sysfs node disable query error count during
 gpu reset
Thread-Topic: [PATCH] drm/amdgpu: sysfs node disable query error count during
 gpu reset
Thread-Index: AQHayS00p0D+0RqT2UuwBrcrZHKSPbHcyU2AgAAJkuA=
Date: Fri, 28 Jun 2024 08:10:25 +0000
Message-ID: <CH2PR12MB42154E697D36D2A1A70A22DCFCD02@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240628073112.1291140-1-YiPeng.Chai@amd.com>
 <PH7PR12MB5997516A4A160F9ED9B0A82D82D02@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB5997516A4A160F9ED9B0A82D82D02@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bac958f2-e0b7-480e-bff7-f07776c82694;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-28T07:34:49Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|DM6PR12MB4417:EE_
x-ms-office365-filtering-correlation-id: d3db4429-8076-4356-63af-08dc9749c3c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?IRjtjoJPe21YWIPV02pG8Aj3S6LuP+zNWIqV1bYuzVAXZ1W7R3jCP9+nqKp/?=
 =?us-ascii?Q?Bsmh8mHU3vR/+s/5tt3iA0b1WMXKfOETEDUWQJABuMrP+TPF8xbYSk5wkFSR?=
 =?us-ascii?Q?zMk/GWCWa5TDKgWlq1CBjEABbANdJmY39MEtd3NG6Qx7V+bwS3d6uKfmh7W0?=
 =?us-ascii?Q?+MPPuBcAIaFg/w4i1Evson7BgNcE+Nm+fAgHe0afqIp6+hGSAu/7i59aixyd?=
 =?us-ascii?Q?pfo1tgMhxYjQ9av394Gd95N+0ovs21Y6c2LfkO1BUTqOs+wBTFwYfpjcx36B?=
 =?us-ascii?Q?w5WNlBT4cZEs6zCJkeMMPAAeZEzwVw3Tu8iIIvcpEXiKea75SuKNe7ukHo7T?=
 =?us-ascii?Q?oGRBEayN0fAYJIFgBuW+H0w6t927wzF7Ml0VH//xs0ukGY5rufpjgMI+uKCz?=
 =?us-ascii?Q?DTaxm8CgGBMXQ5siWxg2RWIADaVc69nZuFq6VtHXEie+eRVPqJPAZpGbYh+S?=
 =?us-ascii?Q?QbVuRwQH5Wx4v0eUEQhOATE8qtdzXeP3Ufn/cibX5d//M4OHgPTWgvVa6JUV?=
 =?us-ascii?Q?fP4DO2CRJqF0x8OWJvp8EJHZ4aA5yahBj5pPF4mqC9Iz4iGDOC3oTS97Emd1?=
 =?us-ascii?Q?eGGTxwRthCGzUUsyQqF7LPY0ouSXZn0+GkIvA53cQBXAm7yxSG+qFVawIgrM?=
 =?us-ascii?Q?ZoOsQegDGZfWrFXZ2WU/1JYm/+mqUGXt/mZayjAr2wCQbqdLOWicvu1r6tWG?=
 =?us-ascii?Q?BegkWkqycLiLy3CpTEL4+wLNuCefY3k/GS/cTY8wyr6Jhzt0VL8wrL9VsBQQ?=
 =?us-ascii?Q?DjhKLsxhjvxscw90yFPos9n6hwHG9YLa9ErELHyawcnTq+ZKzeRuaQeK1N+r?=
 =?us-ascii?Q?bqZuPPAneX6oIp13eSBvinNJf5te6qY4WTkcUddeDYg0VkWkeuVORmcO9f+s?=
 =?us-ascii?Q?3WfneJh+LwjASEYzg3upI2AIfZRZQEhUFJW5Ckla21SHfSbCyhQh0kDAY3sP?=
 =?us-ascii?Q?4NLOCRPFHdu2khx1A+9HUKFRtvfFwxYhMOLTutN/knojB2wzkrRyGMAkJ5rb?=
 =?us-ascii?Q?hYGlhqeDJdx88ZoBzWcd25MGaOVqdOhIvZhHcMXwg28C3dZZ2+WuLztKtg/k?=
 =?us-ascii?Q?isBdZx41JLh7FEeOD4osx5JMzQVbFZQR13W9ZlNmWqo+S07YG68Qc0WMqMa6?=
 =?us-ascii?Q?xpdGfwuTFfJ4U+GcR/t6rumfVAgfHQm++RzGY8lQIpT4L2ZeX2+sW6SqWNQk?=
 =?us-ascii?Q?wDD6xGJ36rZcty5a0J2LouEUVh1AvLjMx3PPIRP0+2tCDrYHbs4och0vpxnE?=
 =?us-ascii?Q?C5t2zmjq5YUwr7AMUrjqiveyJl64UI69nWLNQIMzgxrP/5dyqYfMrFoJNsY/?=
 =?us-ascii?Q?D/bI8XyfUckVvwu/liL+8beH6cnKYKtdCu/InYvFQAXHjGw47Ktr10D88ihh?=
 =?us-ascii?Q?9DLW2M/xMEAWMcI/4ATRg5PxMSymGVZ1ZyTFw3MqHVa7xOZXXA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qMB4uiqTl1UfQsLF9CV/sjl1di6a098p+jupThsq7Ok3Ej+MqXJx8Rl5Qc36?=
 =?us-ascii?Q?npy0GCeo1m43Sc4kAehkDRV5pMB8Z7xZa89ryJXcJ4sg8dIgZPcb/Y0VPhGT?=
 =?us-ascii?Q?UCatZPufokqIoVYbKtivh404NgaYQZE6cf3s8k32gU8hEBZIgtxxyPUHpn1n?=
 =?us-ascii?Q?0Tr5+9ZoHeHIRPcPr9/65Hy8sFgyP5LfaVFxZJwV9qHqYID1s8kyWzVT2x/V?=
 =?us-ascii?Q?GTnEE0pGh3TKFBL2Ymmh6xio1v6G5NleYHBYwDRu9QT0ugTIB/RPhHjE+Vub?=
 =?us-ascii?Q?7N8ja/wSvRIotVjQsSN5oc3Vgq9Xae4UC1buPxV1lhezDFZjBhzcjo+S1aMJ?=
 =?us-ascii?Q?2YTVq7U840Hh0OKudGUiTgMwO7DoC9FLvDQboIkrIwE+Injya57qrvxd2K3T?=
 =?us-ascii?Q?A/tiAFpKsD5dR3VMlEZhKomhZ7WACDnpYjEin1e8enBBnfEfzhJHTnArGN57?=
 =?us-ascii?Q?cjAQIyYyQmvSYVUQgfORc1lFU4CPx98brtHwvxJPQ7T2ZA5gIzRn5FxUUqx8?=
 =?us-ascii?Q?OAR+wYQ6i605kMHZPgK4taDoimhN2Vn2kc88nPaTrzrgg2kR54x57fyBTONx?=
 =?us-ascii?Q?MEc0QaliETmJeQybpMr7DzbOX8/KUOidnjNI8zCPdrN9n7i5GOIoqGG/uYTa?=
 =?us-ascii?Q?pj/vbyyvHAlUOVtrc5eGghyg3tGnF4CznJ+XN7A3NBUlRd3i3iVG9GvbQAwc?=
 =?us-ascii?Q?m7zveTm2KZ6gsgWeab6/X7J3MThtphARaO5imBEWrG70N7Sc8wVN6j/YABcd?=
 =?us-ascii?Q?FLqEze60q82udhkeuel9nn8XIxlySEEauVYCqfc3/OKOuZT3EdOlmvpZ4e+j?=
 =?us-ascii?Q?wP5BCf4RJl5BFlrWm/H0jyW1dsR+ifey0bcgIjHrnNgU8Tw+Jc1uKhSuqeLI?=
 =?us-ascii?Q?bq0jMr/i67LLFtxBD5clATE4cJhKazHPi0uq9JenUm7S1bCIm52UAY0DkXUv?=
 =?us-ascii?Q?HyRfC9vaK8+F0KJiyyDp31h0Lx0T6RKBHpVVeV9AXC9JhHZFH1qos9RgDIWa?=
 =?us-ascii?Q?v2QfmLF9lrKyeTXGpOf4T03lQatl7Qk6mOlfXxZbT78YkgRAOZWa4gmUWFAd?=
 =?us-ascii?Q?SjZ3gbAnX8OyAo/WYvg5f6pYMQY+a3y/Wq88d2/L+0Vg35Md31UleSVeaviH?=
 =?us-ascii?Q?R/o6Vo4s6X8eary7hqyLday+qShxdogYa/QGc/1ijJcRCicrSZfszHXa9WoT?=
 =?us-ascii?Q?5Lim/Q+XLasj4EBXflzE/Gr3RG0K+3EbbUx6SOwM6mB+9YTUwe293/WVHth0?=
 =?us-ascii?Q?5nOwf5sg3+V+h0ZWpAvmZyCL8OIgzxmmP+2Q4Ko3rKa8jZJcPujt+COAJnOK?=
 =?us-ascii?Q?fv4/Bs/kawWO3+LyziY83cMDPeq8Ao+mleoX+tuUNRy8Bpr5OmrqsCfy6oe+?=
 =?us-ascii?Q?t+Qcv/pPDqUAzUNtP6QsMpQh2REBPCVBA9ly66blNTjH/dDvLzr0haiUgGvd?=
 =?us-ascii?Q?54gSlCfzK2JaeSZPFaOVzGihTJ83Jmx2xSQDkhsovaPUC2iD2cIqzXA1Juy5?=
 =?us-ascii?Q?eM5D0XieqODtL1yqYURQ+4tz+MEWwsG1do723u/o2Oplx1r4yqkJMREFoR4p?=
 =?us-ascii?Q?X9ZcpmFrtsICQ6Jc5fI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3db4429-8076-4356-63af-08dc9749c3c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 08:10:25.2415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GXxp3WL6tlfyYIOwzxg+S1Iq8jjHbD/YK75NJ8zrTBkeuuSvAmbP4PTXgIHiHah9lz/02Ug+iCFlGHCvXCd6/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417
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

OK


-----------------
Best Regards,
Thomas

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, June 28, 2024 3:36 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: sysfs node disable query error count durin=
g gpu reset

[AMD Official Use Only - AMD Internal Distribution Only]

it is better to apply changes on both ACA and MCA path.

Best Regards,
Kevin

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Friday, June 28, 2024 3:31 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com=
>
Subject: [PATCH] drm/amdgpu: sysfs node disable query error count during gp=
u reset

Sysfs node disable query error count during gpu reset.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index ac7ded01dad0..ab2e11e1639e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -619,6 +619,7 @@ static const struct file_operations amdgpu_ras_debugfs_=
eeprom_ops =3D {  static ssize_t amdgpu_ras_sysfs_read(struct device *dev,
                struct device_attribute *attr, char *buf)  {
+       int ret;
        struct ras_manager *obj =3D container_of(attr, struct ras_manager, =
sysfs_attr);
        struct ras_query_if info =3D {
                .head =3D obj->head,
@@ -627,7 +628,10 @@ static ssize_t amdgpu_ras_sysfs_read(struct device *de=
v,
        if (!amdgpu_ras_get_error_query_ready(obj->adev))
                return sysfs_emit(buf, "Query currently inaccessible\n");

-       if (amdgpu_ras_query_error_status(obj->adev, &info))
+       ret =3D amdgpu_ras_query_error_status(obj->adev, &info);
+       if (ret =3D=3D -EIO) /* gpu reset is ongoing */
+               return sysfs_emit(buf, "Query currently inaccessible\n");
+       else if (ret)
                return -EINVAL;

        if (amdgpu_ip_version(obj->adev, MP0_HWIP, 0) !=3D IP_VERSION(11, 0=
, 2) &&
--
2.34.1


