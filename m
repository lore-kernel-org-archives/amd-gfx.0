Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9E1C27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jun 2024 06:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0593210EA03;
	Fri, 21 Jun 2024 06:41:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aYT6CSmm";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 491B210EA03
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jun 2024 06:41:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XepxGXVOZ1/QXrZOL7oD9JjtjLeMQpbjbipSabj9BHagdy9ZFYSfwTJ5Kfh4gpJPFpIk2PC92T/T2Tpgxrs3+YMY+5HArQLEn4p2VutpY83FOCsKWwi5rIIEolifAS1fntgG5AB8/BCk/62Wv5SKOLfaFNBn/WLfZE9rVUE60C8aUJK+VE9Xpgt11vQLwQbeanPoG0mXflvXNXrAkaU7LGAHhYIygBZmSkoi5dIAdVrExLdwAe9gzgHVsM3kUMEoHWs0mHakMhI41U18zDsuBj52vYy5hDJFVB6To6UBEHd7fVsNtKrIvpWf6LeOUhHLjaV9y3mdjb1nhmKREb19/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otXZPWRWcxcE/UYFn8NXBY79CbuR7XKShcESuECnLgQ=;
 b=ap2dqq2I8SsxTnezCpIRFvQ0ru+M3ef36tZmypaPfyNBRVpszOYG5jYUD+mSHN0oYAPyzyAUdIL1X7I5g3Ac2joznxbmNxKktShhn5aSdNGS6j+ocdAg5njatrkHN/1qimHBdWuweN9S/VKiZbRVdjFSYgh/aLlMNLZL1qnyWvdVECGaJnUrcbmniwMjhZeQxK4a/FuiAEXpunEazIxrcR3W7zZwqubmLh17KjTHJvzTJ4R6+7+pYJobwFTEiwP0At8AvIUDmK9KFQTNP2FyIHyOtUQXovtTDMx0Gm40BSWv1ghRMBaqdU3PQJVNqqkUMLrcud4gkj6SseuqimPZaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otXZPWRWcxcE/UYFn8NXBY79CbuR7XKShcESuECnLgQ=;
 b=aYT6CSmm+BaP3Bsc30Gze45iQcglqQG52kSCu46maRXNgMk32Q8X7cWUsSeJza/SKO7OrW0fGa2rEe5doQNJjulYvirzNUhM8kOtFoEatra/5FE/dbTZF0yBII7HVruLmpbSdR14iBf9iTEfBtifIc/24j2cxlx0l1vlM0JGSjQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Fri, 21 Jun
 2024 06:41:28 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 06:41:28 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH V2 2/4] drm/amdgpu: refine poison creation interrupt
 handler
Thread-Topic: [PATCH V2 2/4] drm/amdgpu: refine poison creation interrupt
 handler
Thread-Index: AQHawtR9zJzZCAggUke5SWL4668mw7HRxlZg
Date: Fri, 21 Jun 2024 06:41:28 +0000
Message-ID: <BN9PR12MB52570396ACB7874D0954AE50FCC92@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240620054020.434523-1-YiPeng.Chai@amd.com>
 <20240620054020.434523-2-YiPeng.Chai@amd.com>
In-Reply-To: <20240620054020.434523-2-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=06e42892-ff4b-45da-99ce-40eb11a0a0f9;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-21T06:41:08Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS0PR12MB8366:EE_
x-ms-office365-filtering-correlation-id: 693ee5ab-8f67-4b31-bee2-08dc91bd2ddd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?o8dkYCe08x7RfaH6Jbb520+nPgFVLp/As9z5WEZGfgBjWQgE6pAeF4HmEyp3?=
 =?us-ascii?Q?NGh3rZJANAdieTw6z+mg8manJ+vxWetu67UKFzXG2Lt/DYXF2YrzbguIlVAr?=
 =?us-ascii?Q?inyzg/bWCy4RLXc1RtxR2PGOSkPn47GG5Idu6oPS2SNL3WZrp1FLz1w6hVNu?=
 =?us-ascii?Q?Z7VyIOorG6HQioyGAMjzw9GfQ59XiZlv2qIC7eGXNeD3YZ4FvF3fg3kF58T5?=
 =?us-ascii?Q?P0F1dDyXxYyscFG2K61xPzhPLyG9OeFgNDPzMC9w8hoj51VLS8hudHg2FT3n?=
 =?us-ascii?Q?56HYOcTilMYKcxRlnZBg4ud0UWYKWjN/m3yDgnVbAEGKMjQlM1/3amEzSl+G?=
 =?us-ascii?Q?KIzIue6lbhai6AjU4M31Ip8fLGz8HpedCfDRO60GQDzm+Dn118o2hVgmZHLn?=
 =?us-ascii?Q?lXj6R7fdtH7Bdk/4OT86UOaski4eXbAI8wBVkBm4GgntuzszC1n+v6NG/vAf?=
 =?us-ascii?Q?2WhrigdSJcqEGyzHwC1LK3se8oBaWcW8kWGovD//mr07oVTvTWY/d+YC5Ysu?=
 =?us-ascii?Q?QeXzKYl9RLZqktLTjHCm4Y6lqM2YtRkmsWexCRxweouTj7yxMZSHY3P2yQ+v?=
 =?us-ascii?Q?1Cv2BB2Y1M66f8XkpLFum99b+6JqJDqG0GCzsoDZ4hqLEKgekoATschSpRbW?=
 =?us-ascii?Q?D88FPSwn69JnDUk054yvllPH5QzNzNWB7vq4CN8TvTdXCJf4J8lQhIjyeY3S?=
 =?us-ascii?Q?lU7gclgiBX4MBU69alLo+xbQXth9o/1VPJIeAb/pAeqq69CfYO6yfaewqVmw?=
 =?us-ascii?Q?cwaQoidRjRHUbzrGTmrqMaLIVeXTcAHRYsOx7EV1JPC2IHh6PUkBxkUOzHQl?=
 =?us-ascii?Q?3dkcJVNjFNee9LYZdcB569EAPPd9STBFU7iCJmjj59wMwKH4FuGtWdEsECUq?=
 =?us-ascii?Q?wswZ9/QZvAMv7dZQY4HREkE7cP7dooQLjWS3gMwltw8YrWxN5Vce1dgWKaTs?=
 =?us-ascii?Q?OE1s2ocbSZo198AZfDcD+JjViU+p2kFBSnRzvtXEjyRjkvWV5OF1XFKjRGIm?=
 =?us-ascii?Q?n/fYbzD2/dz4AEkkhhXWasJHiAOThHxMcGwBOENdOASitSgNqFWkaoTWqZDK?=
 =?us-ascii?Q?AQqIKW8LvkGBypftaZiC4MVgnbK9c8XVaL5/m8ac7JU3Pixvq9+y0jWkgz8F?=
 =?us-ascii?Q?fbiAVLZWykTIvDo0EVHy/84oM0+2iJI/ZnzCphtPwoeUMIgtXk7S/XUbSh4C?=
 =?us-ascii?Q?BRW1PFKxbOzmESKZ2k0d2ILAUIHgmX6QQfuJ7ID1Xp9AJ3CXX6wvbbz/WmWZ?=
 =?us-ascii?Q?cvokM+lrNP96l8v1esqn+i8n2ETvqDqXmmVGxW8+83M1YaJLxPcf9t9aP3+G?=
 =?us-ascii?Q?H2RZw0VkIPVMzUcjbGiBwdfC4boiXX3bHs60ZFUWRWDIQiik7yhzVIUXri7h?=
 =?us-ascii?Q?w4bDSbQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/40F5pwBWyYwxQ1J0arB5jENIfdd6yQInDuwnBoAVXnVHvXLGD+A2rVsZrNU?=
 =?us-ascii?Q?fr1YzuFnooBi4VinVFMXi4bYCc7tteGMeewg+1xuVmPzFA7OriERCSd9UGZ9?=
 =?us-ascii?Q?TqWp6c3RESFPOC5/sO6QYyNtSgnL4uOyv+3yw2le6yxOm1MNwc931ZQjb4oI?=
 =?us-ascii?Q?xnk2n/31ubJrOYvzVslqfMohOKuAYEYJkMOu/lcjfXPst7YE7dpNEhxP9YPL?=
 =?us-ascii?Q?z8+jEjfzAt5AYaeoqPJw/ZwsOGscoyzklH9kovAAW7m8sapo8roeZ0LO4KgU?=
 =?us-ascii?Q?r1w1B/7YbpAIhhIFaCvuoMf6r4g7ylOg+ajgJPO3TZ8vYoa0PqCe8gDloKnV?=
 =?us-ascii?Q?dkwpq7Cr1cYNk7qFhCCQYCGyOs82O5hpmJEXkfarmyehHCBTAKeulEbJcF5H?=
 =?us-ascii?Q?gxg5My+bnfgzpFyL4FMeRh3zfkHRK34sqGO3JrqY9a9wOAPpVS7oYyIZ6Ia8?=
 =?us-ascii?Q?EE5+BJMgJKzDOcmdaCfnCFd1tTOvVPT/exjVz266T5kOO/QXkaKvf42d4KHG?=
 =?us-ascii?Q?acJ5cBLnuLnE0s5vCC+o7xoDmhuZOqMGeBoEg6AxHEKYM4sFnFJXfzE5Iuw4?=
 =?us-ascii?Q?7gsmsOECLDe0D3KdyLFC3h+Qji+kbVJBxEdkSoCOX7z4Fxx3ZT2Umov8M9Yu?=
 =?us-ascii?Q?kDYnZmCsHHh+LnPA9PJmbcEhKDWQ5qTyZzTo1RBLSIiuXjfgFwDsrp5t8R7a?=
 =?us-ascii?Q?YO3oMRRMZDQQf+H5PGPnOkCgiZulbfDArzSMBzQT11rf86QyOSukl1YeROOO?=
 =?us-ascii?Q?nHWFOQPf/+2DhtySG17JwtdZSYl6Ovms2oP48hyq/hJcNARJSmsiuxAHyHWB?=
 =?us-ascii?Q?ZqZms5J94kBsYkf5RQJGAggalojGlzaD2yqOSMBmibabi+0nfcedMMAKFxJ8?=
 =?us-ascii?Q?KhPR7uY2Ld1ETZpDMwoFZwB/M4Agdi4Xka7m3NGOBgSZlqMtNVgoLHBoGxiU?=
 =?us-ascii?Q?B8hKDf2tAlmpmLUFOHHLlBqv8DrcUe2SR6RidxFiM6Fpbs6/exanRVBAfj9L?=
 =?us-ascii?Q?7N6AgB2HfwvPmOIdMtCZzV5Fih8VLRr7fbv9FfgZtRORoa5IKjmZEniTXpDH?=
 =?us-ascii?Q?LpQXGYHtD2DkvHLLA22e+9e0tPBM7poKt97SZmcdPKYbLkmmfcTsPqIMp9jo?=
 =?us-ascii?Q?hy+surhn34IZQon3aeEpNOeyO3oX+FEZhif22vyHyrVdvdNkpOFVb1AaJDxu?=
 =?us-ascii?Q?mTRyVTuMlTQlJbKtGk/RMWfJaB8f7pGBAlgrOZdVNrz0KdAv/3NbWuXsxEuR?=
 =?us-ascii?Q?YIFo4+VauM3bWXSc7nQu6nL67f0aQj1RzLyJbsVGRlqC/6SyRHOp75kq18Km?=
 =?us-ascii?Q?1Ps/pvCwn7DxZtkov+8iWKCHJh0SSwetYNNtMm6FsvPZbaUXsj0BG6+73wes?=
 =?us-ascii?Q?Bij3RICpRYushwBSWdIGes4O4pvRcWc3VjbOBxRUkudRGoluUFqjQUR8z+0H?=
 =?us-ascii?Q?ELk+7bAaWCu0P4+RBhOD5a/o/3UGc7hRfT051nEj8AfN4jZNisCAvH7YfVKb?=
 =?us-ascii?Q?R6gbPrqjPtFkpNB6gx4pyjiBa1OxS9Q6xGkEZoQ23YFgaUK9EOIUIJ6cz8wv?=
 =?us-ascii?Q?vEtco/IdGWfh7XynipHqVJzGBK+3mg0YHEyJTlgy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 693ee5ab-8f67-4b31-bee2-08dc91bd2ddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 06:41:28.3708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sZfzX++erTClpw0+6+eRLApwfpBmQQgEkOaC0G6O0mYz+FOv4qtj8YGAoloCJk53LDA3N9jBqSWLZmdpdgOCVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366
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
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Thursday, June 20, 2024 13:40
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com=
>
Subject: [PATCH V2 2/4] drm/amdgpu: refine poison creation interrupt handle=
r

In order to apply to the case where a large number of ras poison interrupts=
:
1. Change to use variable to record poison creation
   requests to avoid fifo full.
2. Prioritize handling poison creation requests
   instead of following the order of requests
   received by the driver.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 37 ++++++++++++-------------  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index f674e34037b6..308348b4644f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2106,10 +2106,8 @@ static void amdgpu_ras_interrupt_poison_creation_han=
dler(struct ras_manager *obj
        if (amdgpu_ip_version(obj->adev, UMC_HWIP, 0) >=3D IP_VERSION(12, 0=
, 0)) {
                struct amdgpu_ras *con =3D amdgpu_ras_get_context(obj->adev=
);

-               amdgpu_ras_put_poison_req(obj->adev,
-                       AMDGPU_RAS_BLOCK__UMC, 0, NULL, NULL, false);
-
                atomic_inc(&con->page_retirement_req_cnt);
+               atomic_inc(&con->poison_creation_count);

                wake_up(&con->page_retirement_wq);
        }
@@ -2945,6 +2943,8 @@ static int amdgpu_ras_page_retirement_thread(void *pa=
ram)  {
        struct amdgpu_device *adev =3D (struct amdgpu_device *)param;
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+       uint32_t poison_creation_count;
+       int ret;
        struct ras_poison_msg poison_msg;
        enum amdgpu_ras_block ras_block;
        bool poison_creation_is_handled =3D false; @@ -2958,7 +2958,18 @@ s=
tatic int amdgpu_ras_page_retirement_thread(void *param)
                if (kthread_should_stop())
                        break;

-               atomic_dec(&con->page_retirement_req_cnt);
+
+               do {
+                       poison_creation_count =3D atomic_read(&con->poison_=
creation_count);
+                       ret =3D amdgpu_ras_poison_creation_handler(adev, po=
ison_creation_count);
+                       if (ret =3D=3D -EIO)
+                               break;
+
+                       if (poison_creation_count) {
+                               atomic_sub(poison_creation_count, &con->poi=
son_creation_count);
+                               atomic_sub(poison_creation_count, &con->pag=
e_retirement_req_cnt);
+                       }
+               } while (atomic_read(&con->poison_creation_count));

 #ifdef HAVE_KFIFO_PUT_NON_POINTER
                if (!amdgpu_ras_get_poison_req(adev, &poison_msg)) @@ -2969=
,24 +2980,8 @@ static int amdgpu_ras_page_retirement_thread(void *param)
                dev_dbg(adev->dev, "Start processing ras block %s(%d)\n",
                                ras_block_str(ras_block), ras_block);

-               if (ras_block =3D=3D AMDGPU_RAS_BLOCK__UMC) {
-                       amdgpu_ras_poison_creation_handler(adev,
-                               MAX_UMC_POISON_POLLING_TIME_ASYNC);
-                       poison_creation_is_handled =3D true;
-               } else {
-                       /* poison_creation_is_handled:
-                        *   false: no poison creation interrupt, but it ha=
s poison
-                        *          consumption interrupt.
-                        *   true: It has poison creation interrupt at the =
beginning,
-                        *         but it has no poison creation interrupt =
later.
-                        */
-                       amdgpu_ras_poison_creation_handler(adev,
-                                       poison_creation_is_handled ?
-                                       0 : MAX_UMC_POISON_POLLING_TIME_ASY=
NC);

                        amdgpu_ras_poison_consumption_handler(adev, &poison=
_msg);
-                       poison_creation_is_handled =3D false;
-               }
 #else
         dev_info(adev->dev, "Start processing page retirement. request:%d\=
n",
                     atomic_read(&con->page_retirement_req_cnt));
@@ -3066,6 +3061,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *ad=
ev)
        mutex_init(&con->page_retirement_lock);
        init_waitqueue_head(&con->page_retirement_wq);
        atomic_set(&con->page_retirement_req_cnt, 0);
+       atomic_set(&con->poison_creation_count, 0);
        con->page_retirement_thread =3D
                kthread_run(amdgpu_ras_page_retirement_thread, adev, "umc_p=
age_retirement");
        if (IS_ERR(con->page_retirement_thread)) { @@ -3117,6 +3113,7 @@ st=
atic int amdgpu_ras_recovery_fini(struct amdgpu_device *adev)
                kthread_stop(con->page_retirement_thread);

        atomic_set(&con->page_retirement_req_cnt, 0);
+       atomic_set(&con->poison_creation_count, 0);

        mutex_destroy(&con->page_rsv_lock);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 748bbac666e6..0fa1148e6642 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -532,6 +532,7 @@ struct amdgpu_ras {
        wait_queue_head_t page_retirement_wq;
        struct mutex page_retirement_lock;
        atomic_t page_retirement_req_cnt;
+       atomic_t poison_creation_count;
        struct mutex page_rsv_lock;
        DECLARE_KFIFO(poison_fifo, struct ras_poison_msg, 128);
        struct ras_ecc_log_info  umc_ecc_log;
--
2.34.1

