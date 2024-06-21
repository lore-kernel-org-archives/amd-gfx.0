Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C56C27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jun 2024 06:38:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F44110E9EB;
	Fri, 21 Jun 2024 06:38:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e6yT7NzC";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3379310E9EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jun 2024 06:38:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hvildv9WWengnSFQeZp2sbTCm8gVkrVaiq1kMORLkbFVFg4XKHlFkzw91IaCnWp8Enn/MMdcifc3acNj0KC1O0dpFMUhZYEGG95sauGbYabTtJe53fvkDcj8/cfuZJwG1Tiq0d4tw4d8OltkKnTWEkxIsmFSZP9+if9kxmZuwGk7HSoVErBu00QOzX2bw6O+2r+Xg7DHITgubSl8xlZBaVqm/HapbyQs2sfEhcxdFHV05MGJfneXXhnICmE0cYyuPg3ui3UYxjNDoQu23IwMn3nrgxOm1lMoBvlI+9o8MHz5wgzpxn2S1XmZpP1m6mWfUaj5xjVvPbLx96eU34WooQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcAPrSqmpx2LHCfHZvHfI6GQOWZGr+BX1/Qpsof+I4M=;
 b=IepzsZnn4NBzoIYYVe1ND86AbNfyDiBpLmdhdqK+YjvVeEDZc+CUSB3QqJFhXk+xeFqmO5fGL9evUUDGDtUbHglygOkDLC9zxS6h3kmPm0hzk67aX7X9OPsnyukDhcBbANxb+UVczN04e+vRKXoEt3oOvN+I/CFAw4A6V03Cbg+n7OL+bs4+vI+M1mXj1NgZCXn6KOU0bsViUdBdV5cvYndZySx1fxrwuX5mrzzkUQNv993YU6cp3b7qmmACUyoIYIGt/2d2FxfPGSpXc/Un5uybDNSy95SgJDRMTdWOsRkmCjpIx7LxsiF7uCTqK+QrugcOYRrzw7bIlom9FYvJ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcAPrSqmpx2LHCfHZvHfI6GQOWZGr+BX1/Qpsof+I4M=;
 b=e6yT7NzCEih7Kd3M3O/h2PoOwHewbsZcQueQDX8X7OBDnof8/wkoUvybrQgjFB8zy84EIq7tjYY1HwMIAocTSjdk/OUt/eNazraqwQCTTK8eU1RSuSaYevbFlT+ZC6zP2njjs+PwExRXvIpyWc1Fl39q1sxGOPnrCpZ4ntlu7u0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Fri, 21 Jun
 2024 06:38:28 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 06:38:28 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH V2 4/4] drm/amdgpu: add gpu reset check and exception
 handling
Thread-Topic: [PATCH V2 4/4] drm/amdgpu: add gpu reset check and exception
 handling
Thread-Index: AQHawtSAMkJQ6MJY4kSNxwWc+cjk5rHRxYTw
Date: Fri, 21 Jun 2024 06:38:28 +0000
Message-ID: <BN9PR12MB5257C08646703BBCC79BCD2BFCC92@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240620054020.434523-1-YiPeng.Chai@amd.com>
 <20240620054020.434523-4-YiPeng.Chai@amd.com>
In-Reply-To: <20240620054020.434523-4-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=58791ef1-41fe-4d07-af6c-5401b122891e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-21T06:38:13Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS0PR12MB8366:EE_
x-ms-office365-filtering-correlation-id: e1c7aa14-5fa8-428a-b04f-08dc91bcc2a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?G1MYx8UBUhSUoyFbmI3tqwH9ZE7FpjaSsTzUuHrXCfxvePIeifax2zErrAxU?=
 =?us-ascii?Q?LSgdTqq79w2wp9TV0S5F02mEMeJ0U6ybIWl9yzfFXS/w86jUl9w+u3MVKmEg?=
 =?us-ascii?Q?jcYianuI27Z5AcMwngIVqEb+Vy19Bx0kjpklMxuC8nacVp2cw7v6ZeoM20Xe?=
 =?us-ascii?Q?JH75v2+2dWgsITu7TRffj7VuuZbgrMxFUIkpudUmGEXXbxuEQiwXwxBfLD33?=
 =?us-ascii?Q?8e7GCjBmAj06w0bozhyy/EAqXMho8gadIKXFF4o9x5OwSGxtd4r9A6DB1N1y?=
 =?us-ascii?Q?f8unHu5OSJChkf10TCRX4uwvwJ/YJmRNdmgTQ2KHef2tmdG8Kh4V+WsKHjkG?=
 =?us-ascii?Q?INZZ+XzuU6Cf0TzY+W5RGB7//0ORRRY1rKhTS2HZj5NhJ9oTkobxkItkr5Iu?=
 =?us-ascii?Q?LObeO260FQn/c0p13fZc/FI+OSytmgwwdoXXz6ZJ+2nU6JLfjuiYqHaYEUui?=
 =?us-ascii?Q?GmqoKVqSaqxDgd9g4BVlYlx5kZgKo4VdVMrg04sqNBDxbI8XW6eKtZaa0GOQ?=
 =?us-ascii?Q?/2MlewNjANh0uCeXrSnzKSXAvX1Mi/fmz5AAviRT2ztNT9m5hCj2Q5TWb/HW?=
 =?us-ascii?Q?bk5hJabra+TIM/WUtaSccT2AgV58xCf2hLVDhdr5Il9A6F4s1nEDZ8yMqLhf?=
 =?us-ascii?Q?R8Rc3YaHIHJh7C8Ked9+Ij3J93tmV+Hn1/CcuBMk8afRSJbXJ3c/kqGT6C2I?=
 =?us-ascii?Q?PhhVKxHp2xeY86sgJ/cv8hk22LKKbAAVse13O7S87tC9NWOZQFHu8M/ZRboz?=
 =?us-ascii?Q?sGNgyyn4jHhgk1KP3kEXA8DpdKN6NxCTWByYwA3q8QKOkPqzw5fqZwO6KiLC?=
 =?us-ascii?Q?JSlA7A3l3jrOwpbVUdmDF/59xKgkcnA0Xy4Z1vCTC7hzuJGqqI3AkhsAxpsW?=
 =?us-ascii?Q?4EhvgX7xZQTf0ZPbM7rRAYxj1DzrgOjuZTC7t4TPOGVVsdteUp7OIVgv0NOa?=
 =?us-ascii?Q?Gcd5J9mQT4PDdl3k6EYnfeCWlJ7z1YaenrWdIt/ywrb7+WduwG97X05YVoZG?=
 =?us-ascii?Q?biYFE06AVL3i5gVlRP9k557k/xzt9mlWIlGWQlHG0g4hEVfWmIH5OdyIRVpw?=
 =?us-ascii?Q?Ve2ynmNhhkkjvsryD2p/l1ZGzA2Fuw/FSYaBbHRkIimw2rlLteXlI/qZBizw?=
 =?us-ascii?Q?oQDf0QAn1HQqqi1+tom5c9MupHjzdnNX0I19JHC//DZd0eKdQdL6OuOlNQfu?=
 =?us-ascii?Q?l2PbiJFiBTkTOmsmEvBzViF+R2V/XtfM3ZwYx5RObY4OaJIsNbfCHvUd4T7g?=
 =?us-ascii?Q?EaBsu4cF4Sl4vjN0t67m++ZsSihH5nEHd5R3bHunNWThs260/hR3/6BpI3zI?=
 =?us-ascii?Q?HapXH8eH3aDBjFbXnALnt2rNUtnE2q0br28TDrDih6pR6lx5nmzqK6EM1OhC?=
 =?us-ascii?Q?bgdOIss=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PfraCa1h329Q93T9+m8gUFYiPAUns6hXovzRtBZltsiU/calmtvmMJCWWiCz?=
 =?us-ascii?Q?pO+Mhol9rc/Djzl/tI2WxRvwtBjdV4wLwq2n6wHFVR2GGBy+37CpFuqzNHb2?=
 =?us-ascii?Q?WXBsNAjqlD1Hyqko1e34J7GCaIxh8ZMyZjbQmd52zZHRnkwnRkjhb2o8U2I9?=
 =?us-ascii?Q?rQtW9vl1O7xlGq+GdeXrfkgW70k1cOh3x+QNCpAzDZGDrfhCR6g7++LGFweR?=
 =?us-ascii?Q?pwCOIcSvE8prsFRbrGk3UW8k8ZL49PMCUBRitEM2GOB1IMqcRwtZS3PDLmyb?=
 =?us-ascii?Q?E8Hvybs93QB6lALWAklQlL9DlJXln1FIH6o4Xj33dO6DxMAHjxdlpS56hdKn?=
 =?us-ascii?Q?Au3fCKhlbjwgh/jWF0cuIfnLM2rY+jb5HiQfkkcrvKDUdcexjfHKC+Cz6Pad?=
 =?us-ascii?Q?zjsvQUok9TqeeBRmKUuj8c7BsRN2nMf8UJmfL/XEeXCBgqO447X+lyibUNEu?=
 =?us-ascii?Q?1zEzDgTsw70eazFaWlZksbQ6eV7mC8z44jPmLCKy4mhACs69RnngJltHbmyc?=
 =?us-ascii?Q?bfj0fWYo5KPxDQTCOVKPbfjz6kspTHnVvGGaOc6btihm7cacrYfLLnoMb9nU?=
 =?us-ascii?Q?Twf8WNkgwDO4vrJ5mmiagIRYMCchD/8TAaskDwKvqWg+uiQFSHbB4Mp41u5o?=
 =?us-ascii?Q?DjejBc/tlKtDICxwuWgVPMwugc04R4hWKA6THCBEP1ViIN4ZUzjbSTMDUoUx?=
 =?us-ascii?Q?OlBxyH9f8okZrqtvrejNsw5EkoxOxVAqsU8Am8H77Y4JBDgwg0XyjBJBr+ks?=
 =?us-ascii?Q?KQbxqAbw0XxYA/4fDS6w31M6UF9S+xWd/JNTU7brLbNUqSVR+W4Vxy8WjOwg?=
 =?us-ascii?Q?kpkoWff4tovx4QHT6OO8BXYeLTRNBZHlSrWNQUb2fM4pgImkiu2pTchmaq9r?=
 =?us-ascii?Q?7nwdiZ3sCFEiBgFxGweTtdacXhpORoVX38psIJ0h0kTHJK3gdcdQ5JryhN+/?=
 =?us-ascii?Q?We5Zw16B6sowA857kjmFbMUv7vgY59SncRV/cJWfksFlRSZV3AAbS5Rpv/vq?=
 =?us-ascii?Q?6U9pTnUA917uIZe2/RBvN/1C4J9Vnl488feFuCRuOEudlAl6bNMClVHdNoJF?=
 =?us-ascii?Q?9D+MwESYvc9QyI+K0sHP6dymPtlHII9bvV1s/fO4OUAn36GVS08NdWelkAnX?=
 =?us-ascii?Q?uyp3N8JssWW3g93ymTCTHg1+aIicCtyvip2wENhKYPiFF+6D6BZRSOrRwLxq?=
 =?us-ascii?Q?kq7sjz9/3K7ypIWusDus4IlNLHD+vSSEzBd9NoWLtkNaD5DANE/iH3o1Yiqv?=
 =?us-ascii?Q?XFrs30EWweFVy2E7tboQOVN5SmANYJeqSePbikqgg4tVOUKhT34V4w3b18hN?=
 =?us-ascii?Q?ngV/KDkxXX5fIjWb0EGGyvsX23RIUgNLPpzLVy0oNgV0YUPvdYerGoxf6T23?=
 =?us-ascii?Q?u8I25apRw+XIN+tK8Uf/G79G8ggVFQZdIo5arWHce+bTFUei9WGQRVaSYhig?=
 =?us-ascii?Q?UVfiLI9v0m13mZlcwpCa7JkWft7irW5n6HerKI9FvXV17Z45Yk2Fx4UGwcx0?=
 =?us-ascii?Q?Qe1jRyBD5XgznjsCHP972K4rZmrfkKxunolmUOzmM1MY+9X1IDhYqbMNkm0t?=
 =?us-ascii?Q?LsUEoaHfmuIoolZPjdDjQ5EEkc3Y4Ct+3Eoz96v8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c7aa14-5fa8-428a-b04f-08dc91bcc2a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 06:38:28.5070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QWok34zXOtyPpcgTWeyIExR5H1xmUS6MG6f5Yev8xE2AaR6pPcMlbXV1DmRhhTeZi2smmLWhnBoDhWPDJ4JF7A==
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
Subject: [PATCH V2 4/4] drm/amdgpu: add gpu reset check and exception handl=
ing

Add gpu reset check and exception handling for page retirement.

v2:
  Clear poison consumption messages cached in fifo after non mode-1 reset.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 52 +++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index a4030dc12a1c..ce7c7723e626 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1384,10 +1384,15 @@ int amdgpu_ras_query_error_status(struct amdgpu_dev=
ice *adev, struct ras_query_i
        memset(&qctx, 0, sizeof(qctx));
        qctx.event_id =3D amdgpu_ras_acquire_event_id(adev, amdgpu_ras_intr=
_triggered() ?
                                                   RAS_EVENT_TYPE_ISR : RAS=
_EVENT_TYPE_INVALID);
+
+       if (!down_read_trylock(&adev->reset_domain->sem))
+               return -EIO;
+
        ret =3D amdgpu_ras_query_error_status_helper(adev, info,
                                                   &err_data,
                                                   &qctx,
                                                   error_query_mode);
+       up_read(&adev->reset_domain->sem);
        if (ret)
                goto out_fini_err_data;

@@ -2916,6 +2921,14 @@ static int amdgpu_ras_poison_creation_handler(struct=
 amdgpu_device *adev,
        return 0;
 }

+static void amdgpu_ras_clear_poison_fifo(struct amdgpu_device *adev) {
+       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+       struct ras_poison_msg msg;
+
+       while (kfifo_get(&con->poison_fifo, &msg)); }
+
 static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *ade=
v,
                        uint32_t msg_count, uint32_t *gpu_reset)  { @@ -294=
6,12 +2959,20 @@ static int amdgpu_ras_poison_consumption_handler(struct am=
dgpu_device *adev,
                else
                        reset =3D reset_flags;

+               /* If gpu reset is ongoing, not need to reset gpu again */
+               if (!down_read_trylock(&adev->reset_domain->sem))
+                       return -EIO;
+               up_read(&adev->reset_domain->sem);
+
                flush_delayed_work(&con->page_retirement_dwork);

                con->gpu_reset_flags |=3D reset;
                amdgpu_ras_reset_gpu(adev);

                *gpu_reset =3D reset;
+
+               /* Wait for gpu recovery to complete */
+               flush_work(&con->recovery_work);
        }

        return 0;
@@ -3000,6 +3021,37 @@ static int amdgpu_ras_page_retirement_thread(void *p=
aram)
                        }
                }

+               if ((ret =3D=3D -EIO) || (gpu_reset =3D=3D AMDGPU_RAS_GPU_R=
ESET_MODE1_RESET)) {
+                       /* gpu mode-1 reset is ongoing or just completed ra=
s mode-1 reset */
+                       /* Clear poison creation request */
+                       atomic_set(&con->poison_creation_count, 0);
+
+                       /* Clear poison fifo */
+                       amdgpu_ras_clear_poison_fifo(adev);
+
+                       /* Clear all poison requests*/
+                       atomic_set(&con->page_retirement_req_cnt, 0);
+
+                       if (ret =3D=3D -EIO) {
+                               /* Wait for mode-1 reset to complete */
+                               down_read(&adev->reset_domain->sem);
+                               up_read(&adev->reset_domain->sem);
+                       }
+
+                       /* Wake up work to save bad pages to eeprom */
+                       schedule_delayed_work(&con->page_retirement_dwork, =
0);
+               } else if (gpu_reset) {
+                       /* gpu just completed mode-2 reset or other reset *=
/
+                       /* Clear poison consumption messages cached in fifo=
 */
+                       msg_count =3D kfifo_len(&con->poison_fifo);
+                       if (msg_count) {
+                               amdgpu_ras_clear_poison_fifo(adev);
+                               atomic_sub(msg_count, &con->page_retirement=
_req_cnt);
+                       }
+
+                       /* Wake up work to save bad pages to eeprom */
+                       schedule_delayed_work(&con->page_retirement_dwork, =
0);
+               }
 #else
         dev_info(adev->dev, "Start processing page retirement. request:%d\=
n",
                     atomic_read(&con->page_retirement_req_cnt));
--
2.34.1

