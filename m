Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99157EE20B8
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 16:24:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 137D110E83A;
	Fri,  6 Feb 2026 16:24:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XFYyAyJX";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010042.outbound.protection.outlook.com [52.101.85.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E14410E825
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 16:24:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xeqgbM+U+X/uE0XIFv8b5OOjz0Uiclhe4Oe9TuLYCYeijol0xtM1cNl50UxOUT9UmhAkxD/+6nniITwKZl/TFjFnWA9EqPyq+Au74Y5M8fpss6RDsKVRIhkpfFgyXN6SJ6fT/JDsIJXwrjR4gnKFMWeTyhEiHr54skSTChSIrZN83vbxZodgQ5UDj3bOId/yj24PwVLXlTueAn9lc4vxUMWzhzyQZGDm3WIJy52/Blf+cTEW/B0WLzVLVpHd80WrxeSscUpL/1gdOI9u7Ze0R9WtDdzbPkXW2itErCs6x9dUCnB0MkYRcs06VelWIR9QIMl67zbFTskMgRQRAolm9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5APQEUGtJkekwrSQuQEx4TgWJekLXqGQZ5YHNm/Ab8=;
 b=VEZIP7/qYC7nSwV2m8rS3X+RD9TFgikeEWLcboNsSAUhC41As23IwIJIkh+bAxHKvie4M24jc4f/x7fB3zznsSfywspoa9B0N7hw/fxrKYa/pBsSVcMpoW2CHMeyBPliogpCCbpbcdzDhtqYpQHgF2Unf4StKzd4giRe8hT8N+2ypqKZB4d8vOqtvZOjahc7MDV9tQJC7T5i8bhFvrq+VakR2rpz9oTyoAjKQIj9kgZiZblSSI2MTL4tBb5YIZ2ZJZLti5eExoSIb83eZ1F5IQv30W/JuRoXbAwRRTpSn5a7Ok7OT1oSA0zIVOpWgQZUvmc3Ff3iYn9QTN8xDP7qKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5APQEUGtJkekwrSQuQEx4TgWJekLXqGQZ5YHNm/Ab8=;
 b=XFYyAyJXtGt1EXykSo/OZsEAMrNTponLL0nsd+O4cFcmZ5Ljnv6Hl2jSiNNLGGGHlqGDvjAZJHjmwWgyBch9RxfhqJLwGRlFQAwqKaqoux2bBMFz/BNWC0F5HPc9c0K259oUJM+iFmJ6QW9bvTMfUd4atbZe1LaOQD2dYGoI9Co=
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13)
 by SA1PR12MB999085.namprd12.prod.outlook.com (2603:10b6:806:4a2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 16:23:58 +0000
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957]) by SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957%6]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 16:23:58 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Clement, Sunday" <Sunday.Clement@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Russell, Kent" <Kent.Russell@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Fix Null Pointer Derefernce
Thread-Topic: [PATCH] drm/amdkfd: Fix Null Pointer Derefernce
Thread-Index: AQHcl4DSeW8iuBIFh0mIZHjQrqgfcbV12tPw
Date: Fri, 6 Feb 2026 16:23:58 +0000
Message-ID: <SJ2PR12MB865030C83D7CDDFE3DBBC43A8C66A@SJ2PR12MB8650.namprd12.prod.outlook.com>
References: <20260206155337.654477-1-Sunday.Clement@amd.com>
In-Reply-To: <20260206155337.654477-1-Sunday.Clement@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-02-06T16:23:57.957Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=1;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8650:EE_|SA1PR12MB999085:EE_
x-ms-office365-filtering-correlation-id: 95ef6912-4971-4e99-cd03-08de659c215d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?J+nJjiKEUSV/gK6NNvOGPCBP7lwvwL4xzRBcIdyhwx53eFQB/PdATm7gJBNi?=
 =?us-ascii?Q?WnwslRfhfkOwdj7RDtBKIaXMe+ZjxvsMXOjwFyFdVl54tyQIlqFtRC573XEZ?=
 =?us-ascii?Q?+jtu5KNzV3sumZxH+Id+pNTeOnB5oGc3KtFyTjuDYSmXiL+W59bSo5i5QKl4?=
 =?us-ascii?Q?aDV2brSTtYXrQL5U7tMEqH1Y6C7+GbUBXWsb6QLrto9gn7skztb/599ZJ0xA?=
 =?us-ascii?Q?yTr6vU6XF2ACOGXVm5rr/Je9WV4bwj+2Hvut63uZq9MyAIt8KPzm+dT5OLIC?=
 =?us-ascii?Q?und/HqCXoTmJbT3cI0vTJVGSyKOpO1LTXbPTBfSWTsXRLdjKdNmrpY/IdSsf?=
 =?us-ascii?Q?BFn4wBIt4kkwZ/MYab5y/528rpcOpJS/FaT4itT4CEPoY9ScKiyoQzhmpaLd?=
 =?us-ascii?Q?AVu5oS5aOJu+7Yx6nxEHFv9ErRsG+OKKuFozAvsJgjIlYnJej+rYIDAJvxPd?=
 =?us-ascii?Q?ZQof5HOwSxd/920hBJf+WMAk3m2ZIupSGr6IvqsEu1Hz8l/aS5FDkliDjKAL?=
 =?us-ascii?Q?5u3n2xRTJweJHfA+5jJWd4s32cwpVE/kZEMlPmeuWi1ppcac780IdvKNkogF?=
 =?us-ascii?Q?Y2D7Y06hQAvrwbhWg6QdhZBawM9HTZ5ZMuXV71p3Mp83KBapHh+ZGC5fSKb7?=
 =?us-ascii?Q?4ZzDgX2cmhGJ9FbQ//UFejV7PDoE4ZIGUlR/eMhOx6t+SA4VAaVi2A9LpHZU?=
 =?us-ascii?Q?29jy7RxycLpij4wrEmjNcG3BBt/P6ao7qXA2rTxZM+tc8kbtJCeiyKRCel3h?=
 =?us-ascii?Q?LqQlct329MlW7bCNUXqBmth/qBjL1qljV6WF2lFzefU4oFoiP7TO2n1YJ+ln?=
 =?us-ascii?Q?39I2ZtQnGzjmNmX9nuRt27wqOvs2hRhTXUTNN0I9QLAkBlMFRwnwImzgTqJe?=
 =?us-ascii?Q?Ya+d7RnkB44S6ebJAFS6HlzqUpeVz4xttMGN2+288u8LhPBi9iUIKyy4wuJT?=
 =?us-ascii?Q?wK4Yfn10py66AhEO91+rkAJZyGnGlcWCP2lYEoWlfkg+oQehwKCZ2335INu6?=
 =?us-ascii?Q?/uJceThkLevvHKhCWhzdzuSULximdNqDevuK58+Sg713kDZ2UCaOgL2TFdvx?=
 =?us-ascii?Q?IRKkqGi8US9PV5BOsmCrSR9dMlCMaGoYqmY0WWY4HYO3mqx2RT8L7bVNM2HU?=
 =?us-ascii?Q?fU9+ZWKRXmYeeo0YG+QgG3X9Jl/8uo/bM7C7oF5ncnOhI2pJsDNyrm2PGLGZ?=
 =?us-ascii?Q?knjmxpXLFluivCijtTzcEKQA9GJj4nOKLhCdpnlY5PQVi6IxdnM1Kc9/1ET2?=
 =?us-ascii?Q?H1HaRdRVQXYRCMV8TwoGwIzzm9yxPvTInuYv/03E9a+ynY5eSjqEKWrIUqN8?=
 =?us-ascii?Q?niW+WFgtwvny023J2QJncw1Vv8/LrDbea/kklVwBa8OOooccyNEmuVToFBDr?=
 =?us-ascii?Q?StawgHxXYhfUbRMTr9DCnvysaFpYvpAmQ520b9UwJhVAHOlvHTq5adooJRCi?=
 =?us-ascii?Q?y2Fo2EZFwVT5FzSr7KmMe8SXiTPIkyQuculBEyNFWzaNZHflssnhP0WpmyJI?=
 =?us-ascii?Q?8ezgZo7SUWaKTEWncC+vhz9Q656ifAKXPMNGZ+M16rlFXyTsxCNx+FC/zCEV?=
 =?us-ascii?Q?8DkmW34vxVdMUVG0mYti11EnoSWSs/o/PT1xo4JZnrT0VaGA21QqY8iKmGnU?=
 =?us-ascii?Q?vr5cE/q6OWY1XqPwWKfb6uc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wa2pJLUaMdQcRCb5CwdDxi23TflvfR32ip/1SA9VfxsNpr9WcyTG6Bj/ZosE?=
 =?us-ascii?Q?iD8SEJZf4y6atyyomd7oGr1YNMtfUP+aJKG5k0aArmLLtavdIEnnvFeUb4Jn?=
 =?us-ascii?Q?xN8qI/d/JntmwDJMrEvImkgGvsWwxLpy8qqEtjIj5Oyyevi7wWXuJWM5BnIA?=
 =?us-ascii?Q?0jmxu2SyS6uaZKvPs4wI54JHB2CbjgE3kb1lobfYVIBP/+R1jI0hc0ND3QKS?=
 =?us-ascii?Q?rbFrpfxvpykpjA9wpycgD5oObifk/2QWxxX6fObLvibFun8ibVAV3UQktDn9?=
 =?us-ascii?Q?RkOPNkG6BjkMm+jiZkZ5ee141/yPHhtkEPThTViiGTdvNTY9tXnqOGRAr86b?=
 =?us-ascii?Q?FVI0UvlRUakXbpuNdtlyN14lz4dgd3ksl5Bdm10912x9aLnQcfZv4CoK9+/4?=
 =?us-ascii?Q?d/xijGHA+mdKIdP9pToDgTT3EMdDVNUh7iQXiORcisBO8C+rCm6JDII3jLWS?=
 =?us-ascii?Q?vxJidFrWW8aLqmVwv93+GCklaPKJDkA5jbZE+EMR3ngTDDgitv5r+njpzZ6A?=
 =?us-ascii?Q?JfFgHTVJd15COfFBTm+GMgzgk5nzqJ1dgUhe4AGOJhekbyHvMCutK0oEaEC8?=
 =?us-ascii?Q?QWJTM+d+flceESsktWUmUdHvlc5QTm6OD+cxM7xeFs0FLkKYZarMglM7ykU1?=
 =?us-ascii?Q?RikYwdseWawVtgR03SFujPz4YEtJtrVZneWqUpMhU6QoDOpWm9L59lBkYqvj?=
 =?us-ascii?Q?6grv+p7TRk8QL3orINPZJ7AM+dOWpPbb2wpINbaNOSXFhv0+V/A92z6h3Xxw?=
 =?us-ascii?Q?nQy6cQvzfFFVWl6gW65CDbjQoBh4ZSS7qnPawJDuNS+F1huNgT5xVBpokTLj?=
 =?us-ascii?Q?qqiL0Oi7YqjVVuQT2AKUB9Q/Qelng4DcoFdJzzxlNu1di/hDSAHvyv/bFGsw?=
 =?us-ascii?Q?EMRPWnHpwBKVMMvcqyVrKD886rMxNlGe42TlLy38UOWdznqBvexr6dAHjR2l?=
 =?us-ascii?Q?lvpgoaXt3bC/tuLuzxY4aDyZWwZNr5f+BLGETgn2WSrHW0uyP+A/P4FoRTh0?=
 =?us-ascii?Q?EtGSc4fBtSB7oh4+1xYMAkyB/xdNIC23S7gdQkUa1y4NXoscSM+wH731D/E6?=
 =?us-ascii?Q?5n6J5EZz+idENY306YfZNAj/NDVs0Jio/KWYeZlMj8EwoatrJi1kHhxf88/u?=
 =?us-ascii?Q?fcp1EoqSeqo+d8aRpUHr50xgcZN7rCtPQUsDfwC7wTLCCyy3coPcWsZUkH2a?=
 =?us-ascii?Q?tzDm3pg3bQw75hwGYOZ5AtA8uAoibPtgPGIDTlmR9hJZUbnkgAbvsK6dDW+d?=
 =?us-ascii?Q?rrF6YSzKZo0z5AidtPutHNLjErnM2tdHFHZonXaoSBsxeJXSvKRjPBLFRVAw?=
 =?us-ascii?Q?yeyx/5nS1LpgRwGv+TUpNtscfESuGc9CJb1Ocn0zJGHFnsi1iEuASJ3LxWLA?=
 =?us-ascii?Q?Q1Luhs63QC2rpirDpjFlC/VT1k0w8YmnDQuTs2qtLwcIoIH6wjROSgbiq2vi?=
 =?us-ascii?Q?/5jHwjV+acP2rQ/MXb6aXN2VtpAcxph/z4zheF6pMn5kWShya/KQSWwjG/53?=
 =?us-ascii?Q?BzVL4U8BaLQxJgKw7+iFrZK0XjWg5b7BJGRe+QRY1+U55Cfbe7Fio2D2vFsU?=
 =?us-ascii?Q?Ft2IMs1r8k7Y3bTq3IK3OF/tdoDPWFi4E0daTf6TptAGbVKVprn9/h6Xp7/W?=
 =?us-ascii?Q?kpY2aQo3VXdfKQViwPXDwqadA72hnljQJb+rTt3W5OMGnG0ydLvwaAtkMkGk?=
 =?us-ascii?Q?5w1JrdznsPXAkETEXYh/A8fE0vAyWir330CTlZwcRMqOAmYT?=
Content-Type: multipart/alternative;
 boundary="_000_SJ2PR12MB865030C83D7CDDFE3DBBC43A8C66ASJ2PR12MB8650namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ef6912-4971-4e99-cd03-08de659c215d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 16:23:58.2058 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZYQtQlDiisou/BBtqujBONKwUv3A7NiPM5D7O3W/A0cj9fsZBY7928jj0OK7h9DMi591udJ0GCArMkpznXGLow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999085
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

--_000_SJ2PR12MB865030C83D7CDDFE3DBBC43A8C66ASJ2PR12MB8650namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

________________________________
From: Clement, Sunday <Sunday.Clement@amd.com>
Sent: Friday, February 6, 2026 10:53 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Russell, Kent=
 <Kent.Russell@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Clement,=
 Sunday <Sunday.Clement@amd.com>
Subject: [PATCH] drm/amdkfd: Fix Null Pointer Derefernce

It doesn't really makes sense to dereference the kfd_process pointer
then check if its null right after, the order of the instructions has
been changed to address this and properly check for a null pointer.

Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c
index 732ad1224a61..1db565442c48 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3170,11 +3170,11 @@ static int kfd_ioctl_create_process(struct file *fi=
lep, struct kfd_process *p, v
         struct kfd_process *process;
         int ret;

-       /* Each FD owns only one kfd_process */
-       if (p->context_id !=3D KFD_CONTEXT_ID_PRIMARY)
+       if (!filep->private_data || !p)
                 return -EINVAL;

-       if (!filep->private_data || !p)
+       /* Each FD owns only one kfd_process */
+       if (p->context_id !=3D KFD_CONTEXT_ID_PRIMARY)
                 return -EINVAL;

         mutex_lock(&kfd_processes_mutex);
--
2.43.0


--_000_SJ2PR12MB865030C83D7CDDFE3DBBC43A8C66ASJ2PR12MB8650namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 128, 0)=
; margin-left: 5pt; font-size: 10pt;">
[Public]</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Harish Kasiviswanathan &lt;Harish.Kasiviswanathan@amd.com&gt;<=
/div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Clement, Sunday &lt;S=
unday.Clement@amd.com&gt;<br>
<b>Sent:</b> Friday, February 6, 2026 10:53 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Kasiviswanathan, Harish &lt;Harish.Kasiviswanathan@amd.com&gt;; =
Russell, Kent &lt;Kent.Russell@amd.com&gt;; Kuehling, Felix &lt;Felix.Kuehl=
ing@amd.com&gt;; Clement, Sunday &lt;Sunday.Clement@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: Fix Null Pointer Derefernce</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">It doesn't really makes sense to dereference the k=
fd_process pointer<br>
then check if its null right after, the order of the instructions has<br>
been changed to address this and properly check for a null pointer.<br>
<br>
Signed-off-by: Sunday Clement &lt;Sunday.Clement@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 +++---<br>
&nbsp;1 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c<br>
index 732ad1224a61..1db565442c48 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
@@ -3170,11 +3170,11 @@ static int kfd_ioctl_create_process(struct file *fi=
lep, struct kfd_process *p, v<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *proces=
s;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Each FD owns only one kfd_process =
*/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p-&gt;context_id !=3D KFD_CONTEXT=
_ID_PRIMARY)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!filep-&gt;private_data || !p)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!filep-&gt;private_data || !p)<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Each FD owns only one kfd_process =
*/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p-&gt;context_id !=3D KFD_CONTEXT=
_ID_PRIMARY)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;kfd_proces=
ses_mutex);<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ2PR12MB865030C83D7CDDFE3DBBC43A8C66ASJ2PR12MB8650namp_--
