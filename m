Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F29FEB64D9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jun 2023 05:32:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBA2910E290;
	Tue, 27 Jun 2023 05:32:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E10610E28F
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jun 2023 05:32:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbRRLnJ/TMQZFX9QoXtiOj7cYhZ7guzlE67HQBYU+kApoDavrI+oWrq1X5LzKqTtgfMEiuYmbvgSvdX9iVbql7s/ovtV9mzU9Vw+F9PkrkeNGtFdA99GRqig+mfgL8oCLxFuX0nRN/1pLF8ok88kQmLa8g2ybPPE/2ghIabOuEvohe38jcjwJuZ3PIt/Sg8+jyy3ehdNA/5P2jE679SWt2werEp7usz4U5XmvsW1QewLjQjsIJCzzkbR1UMxR//GO98MCTKxurmoDoy7nuiTTAOhIYhcnhfAi6mdWBD5OKYtx3wiGq+ar4bPnoBrBIE/YSsSiGasCtCEUDziRrRnHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zk+pkzMKuJR0RgwfSat7UNhjfas2kBoLGLHL90k8qTc=;
 b=IqlXz5beiZ3SqJcLjaPNgAUZHtJXuso00vwnqfL+8zAGk0NGVrXDJwtLDtUv5F5y2Jo0EzEiJh9avSxHwEu/slNPI/vS4fpeQuUWftOkLFy7OoWHHYoPDPX49sCF8/XHj8nvtBBy3gOVtnGSPHJfs2RrZrVRayguotYYdPoMY76vU0ra2R0zwYmjvOMkdQxMOO2EeOvPEN3M5R5+t4qGzxAw4DkSyLLM1GDvNcf4Q7C0Ic8xdMMJdF28hRzNphmEUa29/Ltiadwjh56m8bqiQq/lHyCCb43hLCATypKV68gHZsc8EQGmNUViMvHKsPGpjlW8F8mUoS+TNpT/f6HuRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zk+pkzMKuJR0RgwfSat7UNhjfas2kBoLGLHL90k8qTc=;
 b=a3M7d6scIbtwXGg1SdUlXaFQwzDkwQ+bkTqd//d1bN1SbE6kDYAq4/vggXrPzmIDiMYrYQ70MXiBZ+EuitqXdAmY27fchTcP5Km+mO01QMu++Sh4mj0dUqQHqQ6EdGWdjizq/IfDaZW8iRE8vCZ8NeTODKbMME6lKNkMMxb2M2Q=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM8PR12MB5496.namprd12.prod.outlook.com (2603:10b6:8:38::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 05:32:17 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27%5]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 05:32:17 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Add GFX v9.4.3 unique id to sysfs
Thread-Topic: [PATCH] drm/amd/pm: Add GFX v9.4.3 unique id to sysfs
Thread-Index: AQHZpEMEztPc9ZQiBUy+4/5JJ4arMK+eGh6AgAAOvfA=
Date: Tue, 27 Jun 2023 05:32:17 +0000
Message-ID: <BN9PR12MB5257746BD100A07944361E41FC27A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230621131914.2116641-1-lijo.lazar@amd.com>
 <BYAPR12MB4614E4E053F51FFC8D5F2C7A9727A@BYAPR12MB4614.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB4614E4E053F51FFC8D5F2C7A9727A@BYAPR12MB4614.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0bc71f14-eb86-409c-9834-6a1eba6ca5f3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-27T04:39:06Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM8PR12MB5496:EE_
x-ms-office365-filtering-correlation-id: fca5c917-587a-439c-e25d-08db76cfded0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hMgC5IXRg8pPYIsGkYV9Neb2+X+S7yp7E9OabKamaSN3PyLSm5GzjZMpbb4Im8mSC0IajGSqkb/shZws3pK7jCuqhD59uLaLFSWvBVyfQdyO5S4tDn72t7NyCIa4qQot3rKGjmifTYZ+Cn6BNfFdrpdBOL8I7fUh2pZVZV8S5B09eq0+6IKKAfz+3QMen9kiTFJ1rOYdQsYQOONrsMwoWlnIcFqm8xWjEPy9NMObvLG78RoxSEhT8BuGtoBgnrNg2tBmFX6uqGKxkoadx5vKuWXChruQwPx3Z9tm0uwFKe41sMOtOx3svSRJFwakIIRPZ78+LAbF1sQnnzCe2DxuhmcO3JqCj9s19mqOQyhKUp02y1qOgmeFFIDxbfA2B5PmX4oZZgolEWZdoVvbDS2xV7eKBKFH/FOZyKrpE3YDTYm64xiJO+R9mNgYJC+azWKJ6HuF8g2CdmM3X56iPe0/0vCC/yPz9/nWxidmc2W9luHWVXl2VUs22OM5dRZZXYsaA/3NqaVWysejyAtkD3hLo+YfkAZZyGcqahgRSKyzd6i1i2YaAUoi2j9DFmp6H1YNBDkdGvsfXI86uGxMEOl3JCKCOTiDNUS1XrRRDT+S+dU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199021)(66446008)(53546011)(33656002)(52536014)(5660300002)(64756008)(66476007)(41300700001)(8936002)(8676002)(66556008)(86362001)(38100700002)(76116006)(316002)(4326008)(122000001)(55016003)(66946007)(38070700005)(9686003)(26005)(2906002)(478600001)(186003)(6506007)(7696005)(71200400001)(54906003)(110136005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F7hLguSfiTOg0JDI0pPsNFcFvYQ8+1sxLMjTPH97hR/gZ0fODFM6krXByQUu?=
 =?us-ascii?Q?9ACjreNeO6AKADYU5ZAKRIgSCzZfMId42vA28hpayk6KEHUYp0c7Eb1SGo29?=
 =?us-ascii?Q?3CR4eTavztZnvsz6bIjYPWlx3ftlQmtIecALkYO5XqtgZcThU0HNpf93Y/kZ?=
 =?us-ascii?Q?zlJB2myZ8xCMZjo63amDQ+6TCKHvisGH6j+s03sfa19hOcUQD2bYRXN8S4dH?=
 =?us-ascii?Q?lp3WHGCf3bvJECBBly2ndcUtzpaydARaEtMYdeQ5UtXVRusFXHH5+8KA3PBQ?=
 =?us-ascii?Q?YBWuwWwlIxtsJlEOWhr/u+6C6e+eWvxhxie6+R+EWYkY0f3qqNV++b0kYtgd?=
 =?us-ascii?Q?dMehAwoJi8vIt7fV6a5sZ7OUC9Py8+zqsMcjVhj3Thdl6VLAQRWBOS9Y+oow?=
 =?us-ascii?Q?Jp2RUFxCTU8at5IkQU7zhtkxX29a035xsfRqGrrkP35n6T7UDMlXQcdHSSCr?=
 =?us-ascii?Q?WXp8z5nLv2XzWN/Lgv2vJfXdlxQelyx5qL2+CCvC4cjb8VAO/CNnyAiZ0sGN?=
 =?us-ascii?Q?PGdwjm7FlvFpVdYLtsaqWAKM+YZroUmkOr7xe9xWyBjJCKBJ9O2z8qUVtwg1?=
 =?us-ascii?Q?GmnCpCyK4uwfHIMQbxARxfYn7WGTN+oGMCM0nPNvBr2gfAaBN5t1aXFN9Qd+?=
 =?us-ascii?Q?6VPOv2/oGejtInpDa14nE7zp+gNfgKX0byskaJSsMJjbJ4+VDHsgzSoZflog?=
 =?us-ascii?Q?aPqCi/bvr51q/DiYl9TnBohRKIB1IcGgZaET/DzG6lH1f7HbPyszuCIKRodJ?=
 =?us-ascii?Q?wPUL1wElQJd3M+OrhPHH44RE8yynXyWt34elw8sMW+atpF0FJEAWLnIpcKJ5?=
 =?us-ascii?Q?IywUG6KgVVkQKU0xMr6QQUWYy1BaTfGDKCmy/2MTY/bCm5XyPwDgeeQHSGxr?=
 =?us-ascii?Q?RSrb1poRdPgoNca3xhZ6oNVgJDoeNPpDM8gmc9dqNBVwvfbKoOA4qb77+CyE?=
 =?us-ascii?Q?ayy6jp1L8dztiUY5UPi9HbEGmyOCwkg9JdwoVcN2w2Jplz/Qw4xz6JyVJn9R?=
 =?us-ascii?Q?vb0S0NHYI8dkSf+FRMGpgbjTfed+RcsCuSOjzhrl/eWDylTraqRON0cLYI12?=
 =?us-ascii?Q?oMVZ4FtVHeP5kl3S3MOUXHho1okdDyXhT34Y37gpgoxd0leyc54jIl/GQi95?=
 =?us-ascii?Q?aMQO6K5z2eUnqf9pwfyo75YPPXurmQQ7gPTuUaFxCoC6OMaY0FzZqunHcp1l?=
 =?us-ascii?Q?ekA409T1FEgGJFQWVaW+mlY5BDNULMScTR5YfxYwUiHBs66kz6/tCtacSUyX?=
 =?us-ascii?Q?X4te9lVCSQ0CV+J3BBDX885J6JKGWxypGzJIupl+lyPeHqH/POwO8HU8MPKl?=
 =?us-ascii?Q?VFTa/FzQqe3ThwtXQtYOWATz1yXO3A+42DRNdGViJu5Nd6dsmfxkhIDvczyh?=
 =?us-ascii?Q?xlflI10Ktpgm7nIJLF7TNXUyde9mGvJAWedTeG6v5s10a5yFIOROAokhjQiA?=
 =?us-ascii?Q?4HY9q8rGxN815OtbYTHUlX0towV+w0I6IjQGMt/H/3Y/Jz8qFaVCHhW2S7Zs?=
 =?us-ascii?Q?leGBgYKHBa5l1vRhpwC4MFeamoquE0OO9/XufOrU6oS4oZvwbTBwF4Ktz6sR?=
 =?us-ascii?Q?Hh+do2HoOCo/6UuperQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca5c917-587a-439c-e25d-08db76cfded0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 05:32:17.1129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0v7DX/Hg1a6rrEeJl35WbK11AvmwpostApSzNFq+MHbE4yhkXLSqfAy06qUSgfWPPwgkgq4ZEk09F2+vdvUjLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5496
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Kamal,
 Asad" <Asad.Kamal@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, June 27, 2023 12:39
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Ma, Le <Le.Ma@amd.com>;=
 Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Kamal, Asad <Asa=
d.Kamal@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Add GFX v9.4.3 unique id to sysfs

[AMD Official Use Only - General]

<ping>

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Wednesday, June 21, 2023 6:49 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Ma, Le <Le.Ma@amd.com>;=
 Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Kamal, Asad <Asa=
d.Kamal@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amd/pm: Add GFX v9.4.3 unique id to sysfs

Expose unique id of GFX v9.4.3 ASICs as device attribute.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 386ccf11e657..9ec51f50fc52 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2072,6 +2072,7 @@ static int default_attr_update(struct amdgpu_device *=
adev, struct amdgpu_device_
                case IP_VERSION(9, 4, 0):
                case IP_VERSION(9, 4, 1):
                case IP_VERSION(9, 4, 2):
+               case IP_VERSION(9, 4, 3):
                case IP_VERSION(10, 3, 0):
                case IP_VERSION(11, 0, 0):
                case IP_VERSION(11, 0, 1):
--
2.25.1


