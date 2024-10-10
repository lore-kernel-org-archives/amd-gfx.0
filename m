Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20F7CFC5EB
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Oct 2024 18:31:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D6AD10E0CD;
	Thu, 10 Oct 2024 18:31:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rBTDBMPy";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E029010E0CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 18:31:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRNgiTG7odHY7cNOEZDOPqSbXRsbqQXCG5hR3ibMlkbydWk1mnxdGH3cl86pQCDdWpVJZCYiDjRCGc0crwNMFZzYHzchM+4Fg5j1tCJGtALjangSLMplXPZzMuSAxjKhDLEfeTufdVis7l4dpS7RPE7hO1a4c4nHChHIevqIAbAmZA7YGPboAYvTAazp6Rbw6x5hNYblmAzaQGPbR4naiClUzFLRc2V/RV94yXzWcCqVYBJQcttGi7Wd5t2NIrkMSt7MJ/PgWScoyHgoEyrOdjjws5JXaBvo7wYHTPwprMp0pYHsbl9mT1z0b/cD7AUeL376Fena9qQGYUzvUVMP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yW9Sn3bezAjJM/c+8XD2FkHOUlAidAwYEvUxi0DZg2w=;
 b=APiyk/ze8jS9tC7FhPbyoTZbrHM0pjP58Aqt0Crb0flfp1cBgpw/5gC0jgus/JiFoRGi4dizPh6CVxs5tcrukOOEi/c22oBpdJMupi6XjKSmWB/kiT+b00oE4yERVRvHeDg5HWHaQv15GfeC2zCmiV1fQbNld0d6n2MfkSxCZ5Z9hMQDYxuU0OdvNnPvepR8CFwMYYtfQm1yy3SurKXqTRSZ+yU5vHHbQ61BSwkYKcoVBWr+vpT0EJfyC8oKIIAx4nZwXmxX3LXTDUHCikbiTo/zD7FEaSTRbN7DJKISZyzXq5feDhVw/rWsduQ1f8h4P+Po611duAnJRH1Y6z9hqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yW9Sn3bezAjJM/c+8XD2FkHOUlAidAwYEvUxi0DZg2w=;
 b=rBTDBMPy31keLlEmn+qmjEg8XDQ80eZIL8LEJeowY7sPHuGCvc3WnofbnAlxbob7JBmVZShhTxwx++IJUdgmGInGobppXB3QP5FKNNlbQGBf2Xgb8gpXTnaKw780lRIYNDZmkWcqnncRWgKqYofPm8t3U6RJ5UvhLfNYQVmPAjU=
Received: from DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) by
 BY5PR12MB4225.namprd12.prod.outlook.com (2603:10b6:a03:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 18:31:13 +0000
Received: from DS7PR12MB8321.namprd12.prod.outlook.com
 ([fe80::5a8:7f31:78b8:c41d]) by DS7PR12MB8321.namprd12.prod.outlook.com
 ([fe80::5a8:7f31:78b8:c41d%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 18:31:13 +0000
From: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Bhardwaj, Rajneesh"
 <Rajneesh.Bhardwaj@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Wait for reset on init completion
Thread-Topic: [PATCH] drm/amdgpu: Wait for reset on init completion
Thread-Index: AQHbGJv1NLd50BuHPUylyddO+AMWqbKAUnpA
Date: Thu, 10 Oct 2024 18:31:13 +0000
Message-ID: <DS7PR12MB8321009C2D685E230F1B7793E3782@DS7PR12MB8321.namprd12.prod.outlook.com>
References: <20241007093302.2962223-1-lijo.lazar@amd.com>
In-Reply-To: <20241007093302.2962223-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=56af07d8-99ad-4b52-b553-7428bbcae1d8;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-10T18:25:56Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB8321:EE_|BY5PR12MB4225:EE_
x-ms-office365-filtering-correlation-id: 92c3f844-5233-44f0-6408-08dce959b837
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?coTpWHbbJZEGyzj9kyL4Jdw5wtH8mbz6phOF6HL+i429syzpo2cJ99DnUA?=
 =?iso-8859-1?Q?TDlW/0hIYDtrwEMP6Ws4tgsmShXLNL6VXl/2Z017+H0Jcvhv5N04JHP13G?=
 =?iso-8859-1?Q?cGpjYCOEOfA8iL6fZxz5fzh4C0nCFehfRDp+Hzg47+IG0AgHs0yH0+5PBo?=
 =?iso-8859-1?Q?90IkJua0ojmqowl2lAb/FpxmKwfcGSdgMzvSpcGf/af6t5ORxC9lhQ6Ex5?=
 =?iso-8859-1?Q?8fn7oDLWaq+KoO57/HfoKRPPGJMd8cfzlTIO5JOi1RBntnUSRtJ3SooiGr?=
 =?iso-8859-1?Q?Rd16RWsp5Wg3w7VqGwaH50BGnVOaN6ZPz8xp+upilKR66v0GPqwuj93GkE?=
 =?iso-8859-1?Q?42B4GPkIpQSoWqOUZQFd8NE6AN75jZDD6fe83xew6rCq5Wol2cAnFUOcCx?=
 =?iso-8859-1?Q?2W+WF4W90CJs6MJbW1q3msJ2pJHIcDan9L+pvtxPsnjKWHgOKhTfJHFuJ1?=
 =?iso-8859-1?Q?EVSIGLuFJ2TMLV5kdvLIpD64owT2ci/8G0VWAgLxT5og2eMRp7O6ZOtPQm?=
 =?iso-8859-1?Q?+tu3XAd3MfD5u+1fb82owANrr1odrFQBjcAOTBvA2rQUXxKFzHkQAzJIbL?=
 =?iso-8859-1?Q?dc5RYj84aH4gfVqHzR0Glh2ZwBv4uvH0lMlv//aB8m6NSH41+fcRKiqNOT?=
 =?iso-8859-1?Q?vPlH9X0qsiRra+g+iBSStEYw02+j/5ZiCYZ4ZE+G5eOhIhYGIR/ldR2VGX?=
 =?iso-8859-1?Q?pRPJ/Sf+5CpVy+IVfJOvmcy6Xvn5OkOGAKBnjUqypabWR65SnoPpq/ilMz?=
 =?iso-8859-1?Q?HcfU6Aobs69yBf4LYJjD9tshjooDxayjV7/D/k/mZ8NLmw3wjuyLxoBcn7?=
 =?iso-8859-1?Q?BJaCn4J/3K5J86p6bdDaXlXrJrh+qwn5xAVNUIhMVcy2X5Tq38cb5MUGhb?=
 =?iso-8859-1?Q?PsXsrC/FVophwhaOoEc8TN1bi40u1EpgdvCoa1qpQxtK/FBP8rv8IsjFw0?=
 =?iso-8859-1?Q?VPYXKsO68eHeK5bu0JJL95vANjMzgX/eYWAozGjGmPXseFbo53AZ+UCwdd?=
 =?iso-8859-1?Q?xaXvpjNBxlVOwmC2m4KriOVWbHePwNUNZ4HDWW1CXVDTxnEGboiPgI8EHl?=
 =?iso-8859-1?Q?pSnRJOardewtUPyZy54Wq1EetlObSkuIr75A4fbsF37etG+BOeVhQZDHDL?=
 =?iso-8859-1?Q?PdkhoI881IoiOBoNdT8QkGfDylsgwvndWuthhP/KAMpSX1Z6EdWgGlYgjJ?=
 =?iso-8859-1?Q?nwnY1iFUE9KFRguCDZTo7QQA6Ntnd/rwwXC/NbvlDIxzkCIeidDgIPNqlM?=
 =?iso-8859-1?Q?5e1PfcTKkA0fRdy6CWxwBRSCudQP4wW0hIi14yamTDsPRO7IdxhYt/MhGh?=
 =?iso-8859-1?Q?qvgwR8BHgUXgk1B7yyWtrAX+JBtQ4s7UEMPpwzndMNkxbn8lOYIfGHlGOC?=
 =?iso-8859-1?Q?/QIuVcA31LZygn6vx2pcHKlufazr9sUQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB8321.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QH69Vk6UeniSCSRBRkcwl7QCF/kp4QzAHC/OQEYxHvoZk/grAXtlfbDj/H?=
 =?iso-8859-1?Q?8S5+HvC+MsyoJz/Wrt/8ugkvfFiDYakedgmZh+5b8MIHg8ecteQp/jTWMS?=
 =?iso-8859-1?Q?dwf/jwZq4ZSyQcNYWWUfZdXnUauZaMFM8YRZE2bmgw3Bcfo1N7+o0MIpCL?=
 =?iso-8859-1?Q?77wg84RQPY/ZJ5ZSWfTB5/TPwznhROcz0Ubykz3Zrg5Z73XSzRwZThQtLx?=
 =?iso-8859-1?Q?dsCwC5Zrb1AiyZCz5NbIqn95DqLSlONYQGHLYJh9Hk5K5Af9/NjZ67n3Kr?=
 =?iso-8859-1?Q?OCN57/LOOfN7JGOGA5FjTwNnGsUzmubuNIuce78dKJEdsqJ2B4G8Zwnzff?=
 =?iso-8859-1?Q?I2dT1FCIhBOXAZN2tt7KH5tZSaYTvxut0wDsw4uKpqPDYrULRyNSy6czca?=
 =?iso-8859-1?Q?DFccFOfBQfKXZXdlvK0HP7pEdxeF9coT6VOmTRXsy6HYoxhxFr15IXcqM6?=
 =?iso-8859-1?Q?fGmoU20i0Cu+Y2bZTqzgZGT0TZgStkHmDUMXLgFuiD8KjwJXUphuz9iWOU?=
 =?iso-8859-1?Q?vU+XipF1WT3TV2We/oUgnvuxaNxv0OiiEGG+KRv0vGkmp1X/NZeM86vxP5?=
 =?iso-8859-1?Q?ANmuD676IdW/+S8e4bkQAGnn4l/ZhsqzbaqdOeAGnI0Mu6ZIw8H+5CiQGx?=
 =?iso-8859-1?Q?5f2WAgydyIGHn6UdytreqmefoFxpBvGE4k0noSt7uW6DraXWoN49ZsdJR0?=
 =?iso-8859-1?Q?soNrYFiLNX7OP7pQtpCR4yusWu+egtFnZLHBvY+l3/GQ6EHKu4Agl9b69h?=
 =?iso-8859-1?Q?I9tiql2fbxyOpbiz+vbit8GdGyvVHadQCGQqbvlILO9b7Rhqvj9dFfB4FJ?=
 =?iso-8859-1?Q?8TdxWtMN2ziBQKX+SEivlxxk3yPymhgi2Z1iHrIJ0Y4S96WoYeV5vxrTyJ?=
 =?iso-8859-1?Q?hskVuk6VPM8CzKwCK8mGFc0zg1SpTbahp8VRBhrTKLE5TLUAZhaSpyA0E9?=
 =?iso-8859-1?Q?V00ngLJBhAieLCOglF1soxTAXCj1MaUg5sr3R4mAgez+yVDE+t8LdTIUfJ?=
 =?iso-8859-1?Q?v61gXejt9UPlnfkNbL1s1B2TAZcYerFXg0tEVeENox8t5U9C80I6iw8c/k?=
 =?iso-8859-1?Q?Fo0mxcf/l2JvpQ49gkViP2k2xWKpfXS7F92s5AcK52V02AuX59neUvuwfv?=
 =?iso-8859-1?Q?sbMyoybXKjpj/9ZtsmU8DXMlzAV5PPHNnGQdfAWcmn8aZazfORCrtcSo5u?=
 =?iso-8859-1?Q?0Z6HMJ987wYgZIWhGnLKzoTh/xhUCXTTIgex5TI//zcGvG4+YbLZm1GH5o?=
 =?iso-8859-1?Q?+4mmWAqrpAFhWnOOoIUpBwLWtyOEfJMdUcodse5f6032HmwIOgjKD+7EwM?=
 =?iso-8859-1?Q?1Isnyr3IDUe3hJYj8VGxXum7Al0FE5yIg0RPqV45Sf5/K6oSdc+AXCswKG?=
 =?iso-8859-1?Q?mbCBs25rM5dftwR6V5jNqOKPde9ET8yKb5mrdmlX1qDND9IhK5DHZSUVdR?=
 =?iso-8859-1?Q?uGXgDwQ/0fgkY+tQiazfB/evdi4+T73PRc2gVpMuu/7U3gd7AZMiSa24Bm?=
 =?iso-8859-1?Q?UL9DlphUq3Og96NckQwGa8N7osx01xYlkYhp2GG6tvaBg8dLnWi5RNylou?=
 =?iso-8859-1?Q?gFidR0GcJ4ghOBlbVDmO7PopV90uxXJFIVNVnJ+qPdCkBnDHRdqFwlVqnz?=
 =?iso-8859-1?Q?QabULHiA1uKv4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8321.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c3f844-5233-44f0-6408-08dce959b837
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 18:31:13.1184 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uPPGFDY9KkFJP3W+SJovFyp10lZjYY8Y49ezsm7KCdqTg7fyRf8hqPMYfpgx9eGMaC6o1r/Hqio4Iaql6n695Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4225
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

Reviewed-by: Ramesh Errabolu <ramesh.errabolu@amd.com>

Regards,
Ramesh

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, October 7, 2024 4:33 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Bhardwaj, Rajneesh <Rajneesh.Bhardwaj@amd.com>; Errabolu, =
Ramesh <Ramesh.Errabolu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>
Subject: [PATCH] drm/amdgpu: Wait for reset on init completion

When reset on initialization is requested, wait for the reset to finish.
In cases where module is loaded after boot, this makes sure all initializat=
ion work is done after a successful return of modprobe.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 6532b7530a5c..8e697273d2ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1554,6 +1554,7 @@ static void amdgpu_xgmi_schedule_reset_on_init(struct=
 amdgpu_hive_info *hive)  int amdgpu_xgmi_reset_on_init(struct amdgpu_devic=
e *adev)  {
        struct amdgpu_hive_info *hive;
+       bool reset_scheduled;
        int num_devs;

        hive =3D amdgpu_get_xgmi_hive(adev);
@@ -1562,12 +1563,18 @@ int amdgpu_xgmi_reset_on_init(struct amdgpu_device =
*adev)

        mutex_lock(&hive->hive_lock);
        num_devs =3D atomic_read(&hive->number_devices);
-       if (num_devs =3D=3D adev->gmc.xgmi.num_physical_nodes)
+       reset_scheduled =3D false;
+       if (num_devs =3D=3D adev->gmc.xgmi.num_physical_nodes) {
                amdgpu_xgmi_schedule_reset_on_init(hive);
+               reset_scheduled =3D true;
+       }

        mutex_unlock(&hive->hive_lock);
        amdgpu_put_xgmi_hive(hive);

+       if (reset_scheduled)
+               flush_work(&hive->reset_on_init_work);
+
        return 0;
 }

--
2.25.1

