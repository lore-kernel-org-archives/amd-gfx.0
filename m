Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD30C47258
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 03:06:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 576FD10E0DF;
	Thu, 18 Jan 2024 03:06:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 302D110E0ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 03:06:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2tkS6B81ooLRRejjlFiYD1jWWvKpNdJCWo1h18qdoXAUzfmVVnJG5LQcKJS84Iibgx0C+OqYgUdABF6Iy18kAlw+kZFgiqK3mslGhyXWDRxbS9vvkCpSyNAqLZcqy12oxODv42cdfSm0bJmvCMSGyUSdujR0bQhFmiaLVfvFj/JqAf3uJt1ngFlreB5lFs86FyTQYkAOcHs2HXXlMXOFEQjbkYaEqVAoFVrU2+r85qlfofsELGng4KfNbEq9EFClH/O4w7IFLu181AgnEiJjT7Mm+5Qed1wmmMI+KIph7rmb4PFCL+A9zyFYSZk32dFqH/KY/LXR1rFbJTo+1nWDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1X7ypQOz80MP/rvrjRy76YGS2VXqr02Pb4ixk6Ue6Q=;
 b=D6oNCP/RaZ6Zn184QgYPex7abDJ//7eXqn2/4fbaGgQba9TSnMINedcCnmt+XQ5TIky34Unz+ZOBUWeNlJOwqtKbiWVyjuSC9m7i2Zh+sBBa+zq6UuADjOcoLM/JkM+RMUgZm+lgk3YWEfuMF0m2QJxG0GvN+K5jzKD6+SRVsJyN4rU+eiiPOpfpISOhRa5xLR4BgITlZIT8wrR9VF05/MyGE9wPE+vLczMV0oeJ9b/AkgEa3M/bjGxEClZARE5mv2IuRUEP2M7xAiwzvk28o+GRCEI6bPOf/5AYiQFBUJsbaPH+pAgxnRONH9UgcuHA3ICj8VP9eP1JZ5WPwXvy2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1X7ypQOz80MP/rvrjRy76YGS2VXqr02Pb4ixk6Ue6Q=;
 b=NHyRr1m5AE/2xMsdbnNNrmYcgDNjjxi7A6qDTo2RNl8CbDXhn5YCB6YxMKPrC7LzXeuzgv9S/S3kolpSD34gEKPNXKJtAB9VKNLvtpvt/+yHB9J8Goam83jmqIuE7vxNdTKPovuSaQHAH6cG9pwzaLA9XNgtQk/JmM9BymDXIcI=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by PH7PR12MB7260.namprd12.prod.outlook.com (2603:10b6:510:208::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 03:06:15 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::2c41:8d9b:d594:6865]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::2c41:8d9b:d594:6865%6]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 03:06:15 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/5] drm/amdgpu: Use asynchronous polling to handle
 umc_v12_0 poisoning
Thread-Topic: [PATCH 3/5] drm/amdgpu: Use asynchronous polling to handle
 umc_v12_0 poisoning
Thread-Index: AQHaSFT6B9zku1ReLkynpX1GrevUtbDd5x2AgAD3DCA=
Date: Thu, 18 Jan 2024 03:06:15 +0000
Message-ID: <CH2PR12MB42155CF07B811857D84D73AAFC712@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240116082034.1739848-1-YiPeng.Chai@amd.com>
 <20240116082034.1739848-3-YiPeng.Chai@amd.com>
 <BN9PR12MB5257AD82E9E43586C082320CFC722@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257AD82E9E43586C082320CFC722@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7042d7fa-7e6f-48c5-8149-7ac607d94b99;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-17T11:24:04Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|PH7PR12MB7260:EE_
x-ms-office365-filtering-correlation-id: 3498efd9-2f03-44c9-6ad6-08dc17d26f18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3OFVhzw25CWK/xbxRL8apOU7v+/CjFJcDeT7BXUqgYWnDhdyaodDM4XPDTfIUz+XZePVY4X9Vy4d2eee3iODJsOYchnXjTs9SqkL4fN31T35zkxtaloaN5rcTkyNribLd5HKUHfmzPOmORwp5DDl4S6HhcCDTnGGFX3pJeDLldoPHhDaOe2GOR+jWHk9J8GwT8xqnoOWQOHJoFL+dpUs5TjiW1hT4IbYR+zOiT4tIXGoE1dICFHZ2nArsPuxsihT1m9bQxKJAySJZH5xe+6aIShfHASFZk1pvHjZM9rDCLs1UbyB2g/DBMVu94jZVA7G2yTofP8d7yg52wGrWnNLA8Tckckv6nAfa5CYPeWHh1FUXo0A7wmiCbOJOF0EgMcnZDYHrROb+s1N+YS9bKJpEnH5dsUu8GDZchuYB5UHQlybIur07K1DognjXajBh8eWKDJ76Qviw5zvLJejPawOnOWKHpY5AWe07fak9qYVPt/px0fbP7YNjtgkTORdBc0nTGYvTA9uWs3guXXFEdz+BQXrUXb6Huz12lc2XD30AlmPA/tkZ+ZkeoUF1024xewIHoUBbyRMQNqI6/w9gUOrmfgqSdgO+oh8JUtRNLjeJ+vKftgeplZPRla/p+T1bDCo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(136003)(366004)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(5660300002)(2906002)(8676002)(66476007)(4326008)(8936002)(30864003)(52536014)(316002)(110136005)(66446008)(76116006)(66946007)(55016003)(64756008)(66556008)(54906003)(478600001)(6506007)(7696005)(71200400001)(966005)(9686003)(83380400001)(26005)(41300700001)(38070700009)(122000001)(33656002)(38100700002)(86362001)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AxKdFliaHp+gDbCnZmJDga+qHgvnsfi4oeWATg/R4sOMQFA6ib4QJ2AmORDx?=
 =?us-ascii?Q?6I5z277E0jDl85TvjsNr1QgqFM/TLTUZ2v/1Rc8aCsVcCFgGVPMRuODc3I7Y?=
 =?us-ascii?Q?5t74jIkNkqXuG9nrVLKbLzWfNONFzKYzr1gJeX2ZTRjL/JdUOl3d0iqnjImF?=
 =?us-ascii?Q?0s1qWMdhOWKxGdFrOiku+waUT+zSQbM5iZ5+a8j+xhVpPVNykMHxRvTdxQVc?=
 =?us-ascii?Q?OiJg00yR7Pf5UzDCoxUG3drsLxiFF4kksaohvTF/3AzqLyGlTZqFf7azPsrz?=
 =?us-ascii?Q?edxA0mOEAHnk8lzgpXBmB6C9jQqItnkzDQlHigVNvkC+80MlLgfQXfz8zpIG?=
 =?us-ascii?Q?Ba1e3VS42Uu68pYnsIaGdNRiM8yNMbjo0ZVv48wfAtboLrYiJGJdA0omTXM2?=
 =?us-ascii?Q?0jKGEsGx9Pmc5D6N3TIyhde1pA59QWD+Kn6OswiIGMRcTe6K/6wNzc2FwXJi?=
 =?us-ascii?Q?JkCkUGZypa5pMEO1ne4hZbLy7lHUTIQrY0/uLpF6CU+QqzWIvQfdEczh8QB9?=
 =?us-ascii?Q?kjbOaV87voDB1tk004iJTKsIWnr/OikQxNqhmXVQVki1nteTNndboWOc8aV1?=
 =?us-ascii?Q?JQOTsgrmJjkfHmVaZJ9jk4T0gpd06RE6kdQfvkAl+Yv02+APn/gFiDgke06s?=
 =?us-ascii?Q?naES6nHmiCML+k0J+IRwXblLAlKhVIZtYiwmjGm0/IaUGkO0Thf2JPdzVIgv?=
 =?us-ascii?Q?Lq+B3s9u8yvYCUR59C9xEStPdp7ofqRX7n0m4DWp36y/YXqZkGGIToy8RBr8?=
 =?us-ascii?Q?J+va7+Ta3+4tkhgUMbRc1WhjpQC+VYhTX/zspAY51Upqog6hOLciaqwVEzWY?=
 =?us-ascii?Q?xm7VyDCZ5N28/yXRHDT+bQcaNRiRHJOJ0CsxVkiyn+auarCZBNpAfGvUIXHs?=
 =?us-ascii?Q?SrSMWfbXZ5fWm9a70lWC/y8JY8VxZe8s+S1DiXbUD9TuDhw/M54GOcUUSPdV?=
 =?us-ascii?Q?1/JYXdGD3+31Q5uifW8rp2DyswtLNIRSB/wHr01Da1LPu1aoznZ6ynUGzRMg?=
 =?us-ascii?Q?lyAFKJIMD2gx1ZdGC0GY8bfHLCVc/Wk1nXem5ihB/nXUoQQK5g0yuOBXbz1C?=
 =?us-ascii?Q?+gsTI8HVpvsYyI+9TYQy5G57woBUTjgKdijnOuoVpN9Jmq7EuJi092I7NvYl?=
 =?us-ascii?Q?3UPR/MrTRjI2l878v0QjwFdDY9S8sYbiyBktA0OT5/pkVjCPICwFWFJVMoaA?=
 =?us-ascii?Q?N46bDeQB3+uQE/7/DIzh4QQ/55U9RGVejqNlCUbgxRkkBrnmVgqVs1WEdzNh?=
 =?us-ascii?Q?9z9QVz1EJDYwRt4s5w4B2mrG5PI/XovrNz++PrSe8N1t7nhxLtlEitVmJiTK?=
 =?us-ascii?Q?jYpNaWip/VjeSCodvVK+bLEghxJzoB4D4gOlyhci5XCM1BShHpKSS+Dvuw1G?=
 =?us-ascii?Q?EITRXpJVjCXkS3Hbuvy3NgQuozQo2mw4ApcbjQ5MSALR0qi39CYxRIrvTf6z?=
 =?us-ascii?Q?IL7pCX5bRV5PdWOv6N/vY920xCELfzo8NvV4N2Mgs3h0Fcmf3vfLXpQt6FzT?=
 =?us-ascii?Q?qlR1xUQuJIsgjIHmUwOO57ZHWofm8CtCoJSvQgbxocDrbh18qnBaYeajmF9j?=
 =?us-ascii?Q?4FLKmK+3/t/GqNqXTHg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH2PR12MB42155CF07B811857D84D73AAFC712CH2PR12MB4215namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3498efd9-2f03-44c9-6ad6-08dc17d26f18
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 03:06:15.3914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rnyfzXAbiRP9hyd3bX2a22BGMGUa002f/3yG2e2MfVhVuZnlAjix8ScKkOanDMI84mL84+G9x6Gx5SQM/2Vyww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7260
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH2PR12MB42155CF07B811857D84D73AAFC712CH2PR12MB4215namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]


-----------------
Best Regards,
Thomas


_____________________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Wednesday, January 17, 2024 7:54 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang,=
 Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: RE: [PATCH 3/5] drm/amdgpu: Use asynchronous polling to handle umc=
_v12_0 poisoning


[AMD Official Use Only - General]



Please check my comments inline

Regards,
Hawking

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>
Sent: Tuesday, January 16, 2024 16:21
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Chai, Thomas <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>; Zhang, =
Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Zhou1, Tao <=
Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Li, Candice <Candice.Li@amd.c=
om<mailto:Candice.Li@amd.com>>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com<m=
ailto:KevinYang.Wang@amd.com>>; Yang, Stanley <Stanley.Yang@amd.com<mailto:=
Stanley.Yang@amd.com>>; Chai, Thomas <YiPeng.Chai@amd.com<mailto:YiPeng.Cha=
i@amd.com>>
Subject: [PATCH 3/5] drm/amdgpu: Use asynchronous polling to handle umc_v12=
_0 poisoning

Use asynchronous polling to handle umc_v12_0 poisoning.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>=
>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 143 +++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |   3 +
 3 files changed, 120 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 856206e95842..44929281840e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -118,6 +118,8 @@ const char *get_ras_block_str(struct ras_common_if *ras=
_block)
 /* typical ECC bad page rate is 1 bad page per 100MB VRAM */
 #define RAS_BAD_PAGE_COVER              (100 * 1024 * 1024ULL)

+#define MAX_UMC_POISON_POLLING_TIME_ASYNC  100  //ms
+
 enum amdgpu_ras_retire_page_reservation {
        AMDGPU_RAS_RETIRE_PAGE_RESERVED,
        AMDGPU_RAS_RETIRE_PAGE_PENDING,
@@ -2670,6 +2672,9 @@ static int amdgpu_ras_page_retirement_thread(void *pa=
ram)
                        atomic_read(&con->page_retirement_req_cnt));

                atomic_dec(&con->page_retirement_req_cnt);
+
+               amdgpu_umc_poison_retire_page_polling_timeout(adev,
+                               false, MAX_UMC_POISON_POLLING_TIME_ASYNC);
        }

        return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index 9d1cf41cf483..2dde29cb807d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -23,6 +23,7 @@

 #include "amdgpu.h"
 #include "umc_v6_7.h"
+#define MAX_UMC_POISON_POLLING_TIME_SYNC   20  //ms

 static int amdgpu_umc_convert_error_address(struct amdgpu_device *adev,
                                    struct ras_err_data *err_data, uint64_t=
 err_addr, @@ -85,17 +86,14 @@ int amdgpu_umc_page_retirement_mca(struct am=
dgpu_device *adev,
        return ret;
 }

-static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
-               void *ras_error_status,
-               struct amdgpu_iv_entry *entry,
-               bool reset)
+static void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
+                       void *ras_error_status)
 {
        struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_=
status;
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
        int ret =3D 0;
        unsigned long err_count;
-
-       kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
+       mutex_lock(&con->page_retirement_lock);
        ret =3D amdgpu_dpm_get_ecc_info(adev, (void *)&(con->umc_ecc));
        if (ret =3D=3D -EOPNOTSUPP) {
                if (adev->umc.ras && adev->umc.ras->ras_block.hw_ops && @@ =
-163,19 +161,86 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_d=
evice *adev,
                                con->update_channel_flag =3D false;
                        }
                }
-
-               if (reset) {
-                       /* use mode-2 reset for poison consumption */
-                       if (!entry)
-                               con->gpu_reset_flags |=3D AMDGPU_RAS_GPU_RE=
SET_MODE2_RESET;
-                       amdgpu_ras_reset_gpu(adev);
-               }
        }

        kfree(err_data->err_addr);
+
+       mutex_unlock(&con->page_retirement_lock);
+}
+
+static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
+               void *ras_error_status,
+               struct amdgpu_iv_entry *entry,
+               bool reset)
+{
+       struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_=
status;
+       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+
+       kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
+       amdgpu_umc_handle_bad_pages(adev, ras_error_status);
+
+       if (err_data->ue_count && reset) {
+               /* use mode-2 reset for poison consumption */
+               if (!entry)
+                       con->gpu_reset_flags |=3D AMDGPU_RAS_GPU_RESET_MODE=
2_RESET;

>[Hawking]: Shall we do further check on con->poison_supported flag to deci=
de issuing mode-2 or mode-1.
[thomas] This "gpu reset" code is not belong to page retirement range,  but=
 reuse old code.  About how to reset gpu, we can do it with  another patch =
in  future.

+               amdgpu_ras_reset_gpu(adev);
+       }
+
        return AMDGPU_RAS_SUCCESS;
 }

+int amdgpu_umc_poison_retire_page_polling_timeout(struct amdgpu_device *ad=
ev,
+                       bool reset, uint32_t timeout_ms)
[Hawking] int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *ade=
v, boot reset, uint32_t timeout_ms)
[thomas] OK

+{
+       struct ras_err_data err_data;
+       struct ras_common_if head =3D {
+               .block =3D AMDGPU_RAS_BLOCK__UMC,
+       };
+       struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &head);
+       uint32_t timeout =3D timeout_ms;
+
+       memset(&err_data, 0, sizeof(err_data));
+       amdgpu_ras_error_data_init(&err_data);
+
+       do {
+
+               amdgpu_umc_handle_bad_pages(adev, &err_data);
+
+               if (timeout && !err_data.de_count) {
+                       msleep(1);
+                       timeout--;
+               }
+
+       } while (timeout && !err_data.de_count);
+
+       if (!timeout)
+               dev_warn(adev->dev, "Page retirment executed, but did not f=
ind bad
+pages\n");

[Hawking] dev_warn (adev->dev, "can't find bad pages\n");
[thomas] OK

+
+       if (err_data.de_count)
+               dev_info(adev->dev, "Page retirment: ue:%ld, ce:%ld, de:%ld=
\n",
+                               err_data.ue_count, err_data.ce_count, err_d=
ata.de_count);

[Hawking] dev_info(adev->dev, "%ld new deferred hardware errors detected\n"=
, err_data.de_count)
[thomas] OK

+
+       if (obj) {
+               obj->err_data.ue_count +=3D err_data.ue_count;
+               obj->err_data.ce_count +=3D err_data.ce_count;
+               obj->err_data.de_count +=3D err_data.de_count;
+       }
+
+       amdgpu_ras_error_data_fini(&err_data);
+
+       kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
+
+       if (reset) {
+               struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+
+               /* use mode-2 reset for poison consumption */
+               con->gpu_reset_flags |=3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;

[Hawking]: Shall we do further check on con->poison_supported flag to decid=
e issuing mode-2 or mode-1.
[thomas] This "gpu reset" code is not belong to page retirement range, but =
reuse old code.  About how to reset gpu, we can do it with  another patch i=
n  future.


+               amdgpu_ras_reset_gpu(adev);
+       }
+
+       return 0;
+}
+
 int amdgpu_umc_poison_handler(struct amdgpu_device *adev, bool reset)  {
        int ret =3D AMDGPU_RAS_SUCCESS;
@@ -193,25 +258,41 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *a=
dev, bool reset)
        }

        if (!amdgpu_sriov_vf(adev)) {
-               struct ras_err_data err_data;
-               struct ras_common_if head =3D {
-                       .block =3D AMDGPU_RAS_BLOCK__UMC,
-               };
-               struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &head=
);
-
-               ret =3D amdgpu_ras_error_data_init(&err_data);
-               if (ret)
-                       return ret;
-
-               ret =3D amdgpu_umc_do_page_retirement(adev, &err_data, NULL=
, reset);
-
-               if (ret =3D=3D AMDGPU_RAS_SUCCESS && obj) {
-                       obj->err_data.ue_count +=3D err_data.ue_count;
-                       obj->err_data.ce_count +=3D err_data.ce_count;
-                       obj->err_data.de_count +=3D err_data.de_count;
-               }
+               if (amdgpu_ip_version(adev, UMC_HWIP, 0) !=3D IP_VERSION(12=
, 0, 0)) {
[Hawking]: if (amdgpu_ip_version(adev, UMC_HWIP, 0) < IP_VERSION(12, 0, 0))=
 {
[thomas] OK


+                       struct ras_err_data err_data;
+                       struct ras_common_if head =3D {
+                               .block =3D AMDGPU_RAS_BLOCK__UMC,
+                       };
+                       struct ras_manager *obj =3D amdgpu_ras_find_obj(ade=
v, &head);
+
+                       ret =3D amdgpu_ras_error_data_init(&err_data);
+                       if (ret)
+                               return ret;
+
+                       ret =3D amdgpu_umc_do_page_retirement(adev, &err_da=
ta, NULL, reset);

-               amdgpu_ras_error_data_fini(&err_data);
+                       if (ret =3D=3D AMDGPU_RAS_SUCCESS && obj) {
+                               obj->err_data.ue_count +=3D err_data.ue_cou=
nt;
+                               obj->err_data.ce_count +=3D err_data.ce_cou=
nt;
+                               obj->err_data.de_count +=3D err_data.de_cou=
nt;
+                       }
+
+                       amdgpu_ras_error_data_fini(&err_data);
+               } else {
+                       if (reset) {
+                               amdgpu_umc_poison_retire_page_polling_timeo=
ut(adev,
+                                                       reset, MAX_UMC_POIS=
ON_POLLING_TIME_SYNC);
+                       } else {
+                               struct amdgpu_ras *con =3D amdgpu_ras_get_c=
ontext(adev);
+
+                               dev_info(adev->dev, "Page retirement pendin=
g request count: %d\n",
+                               atomic_read(&con->page_retirement_req_cnt))=
;

[Hawking]: might remove the printed message here.
[thomas] OK


+
+                               atomic_inc(&con->page_retirement_req_cnt);
+
+                               wake_up(&con->page_retirement_wq);
+                       }
+               }
        } else {
                if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
                        adev->virt.ops->ras_poison_handler(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.h
index 417a6726c71b..ee487adce7e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -118,4 +118,7 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device=
 *adev,

 int amdgpu_umc_loop_channels(struct amdgpu_device *adev,
                        umc_func func, void *data);
+
+int amdgpu_umc_poison_retire_page_polling_timeout(struct amdgpu_device *ad=
ev,
+                       bool reset, uint32_t timeout_ms);
 #endif
--
2.34.1


--_000_CH2PR12MB42155CF07B811857D84D73AAFC712CH2PR12MB4215namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Arial" size=3D"2"><span style=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">[AM=
D Official Use Only - General]<br>

</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>

</span></font></div>
<a name=3D"_MailEndCompose"></a>
<div><font face=3D"DengXian" size=3D"2"><span style=3D"font-size:11pt;">&nb=
sp;</span></font></div>
<div><font face=3D"DengXian" size=3D"2"><span style=3D"font-size:11pt;">&nb=
sp;</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"DengXian" size=3D"2"><span style=3D"font-size:11pt;">---=
--------------</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Best=
 Regards,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Thom=
as</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"DengXian" size=3D"2"><span style=3D"font-size:11pt;">___=
__________________________________________<br>

<b>From:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt; <br>

<b>Sent:</b> Wednesday, January 17, 2024 7:54 PM<br>

<b>To:</b> Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>

<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Li, Candice &lt;Candice.Li=
@amd.com&gt;; Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; Yang, Stanl=
ey &lt;Stanley.Yang@amd.com&gt;<br>

<b>Subject:</b> RE: [PATCH 3/5] drm/amdgpu: Use asynchronous polling to han=
dle umc_v12_0 poisoning</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div style=3D"padding-right:5pt;padding-left:5pt;"><font face=3D"Arial" col=
or=3D"blue">[AMD Official Use Only - General]<br>

</font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;"><br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">Please check my comments inline</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">Regards,<br>

Hawking</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----<br>

From: Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com"><font color=
=3D"#0563C1"><u>YiPeng.Chai@amd.com</u></font></a>&gt;
<br>

Sent: Tuesday, January 16, 2024 16:21<br>

To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org"><font color=3D"#0563C1=
"><u>amd-gfx@lists.freedesktop.org</u></font></a><br>

Cc: Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com"><font color=3D"=
#0563C1"><u>YiPeng.Chai@amd.com</u></font></a>&gt;; Zhang, Hawking &lt;<a h=
ref=3D"mailto:Hawking.Zhang@amd.com"><font color=3D"#0563C1"><u>Hawking.Zha=
ng@amd.com</u></font></a>&gt;; Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@a=
md.com"><font color=3D"#0563C1"><u>Tao.Zhou1@amd.com</u></font></a>&gt;;
Li, Candice &lt;<a href=3D"mailto:Candice.Li@amd.com"><font color=3D"#0563C=
1"><u>Candice.Li@amd.com</u></font></a>&gt;; Wang, Yang(Kevin) &lt;<a href=
=3D"mailto:KevinYang.Wang@amd.com"><font color=3D"#0563C1"><u>KevinYang.Wan=
g@amd.com</u></font></a>&gt;; Yang, Stanley &lt;<a href=3D"mailto:Stanley.Y=
ang@amd.com"><font color=3D"#0563C1"><u>Stanley.Yang@amd.com</u></font></a>=
&gt;;
Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com"><font color=3D"#056=
3C1"><u>YiPeng.Chai@amd.com</u></font></a>&gt;<br>

Subject: [PATCH 3/5] drm/amdgpu: Use asynchronous polling to handle umc_v12=
_0 poisoning</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Use =
asynchronous polling to handle umc_v12_0 poisoning.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: YiPeng Chai &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPeng.Ch=
ai@amd.com</a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_ras.c |&nbsp;&nbsp; 5 +</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 143 +++++++++++++++++++-----</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_umc.h |&nbsp;&nbsp; 3 +</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> 3 f=
iles changed, 120 insertions(+), 31 deletions(-)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 856206e95842..44929281840e 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
118,6 +118,8 @@ const char *get_ras_block_str(struct ras_common_if *ras_blo=
ck)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> /* =
typical ECC bad page rate is 1 bad page per 100MB VRAM */</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #de=
fine RAS_BAD_PAGE_COVER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; (100 * 1024 * 1024ULL)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine MAX_UMC_POISON_POLLING_TIME_ASYNC&nbsp; 100&nbsp; //ms</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> enu=
m amdgpu_ras_retire_page_reservation {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_RAS_RETIRE_PAGE_RESERVE=
D,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_RAS_RETIRE_PAGE_PENDING=
,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
2670,6 +2672,9 @@ static int amdgpu_ras_page_retirement_thread(void *param)=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_re=
ad(&amp;con-&gt;page_retirement_req_cnt));</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; atomic_dec(&amp;con-&gt;page_retirement_req_cnt);</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_umc_poison_retire_page_polling_timeout(adev,</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; false, MAX_UMC_POISON_POLLING_TIME_ASYNC);</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_umc.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 9d1cf41cf483..2dde29cb807d 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
23,6 +23,7 @@</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #in=
clude &quot;amdgpu.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #in=
clude &quot;umc_v6_7.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine MAX_UMC_POISON_POLLING_TIME_SYNC&nbsp;&nbsp; 20&nbsp; //ms</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> sta=
tic int amdgpu_umc_convert_error_address(struct amdgpu_device *adev,</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_e=
rr_data *err_data, uint64_t err_addr, @@ -85,17 +86,14 @@ int amdgpu_umc_pa=
ge_retirement_mca(struct amdgpu_device *adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-sta=
tic int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; void *ras_error_status,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; struct amdgpu_iv_entry *entry,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; bool reset)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *ras_error_stat=
us)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> {</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_err_data *err_data =
=3D (struct ras_err_data *)ras_error_status;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *con =3D amd=
gpu_ras_get_context(adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long err_count;</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kgd2kfd_set_sram_ecc_flag(adev-&gt;kfd.de=
v);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;con-&gt;page_retirement_l=
ock);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_dpm_get_ecc_inf=
o(adev, (void *)&amp;(con-&gt;umc_ecc));</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret =3D=3D -EOPNOTSUPP) {<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (adev-&gt;umc.ras &amp;&amp; adev-&gt;umc.ras-&gt;ras_=
block.hw_ops &amp;&amp; @@ -163,19 +161,86 @@ static int amdgpu_umc_do_page=
_retirement(struct amdgpu_device *adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; con-&gt;update_channel_flag =3D fals=
e;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (reset) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* use mode-2 reset =
for poison consumption */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!entry)</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; con-&gt;gpu_reset_flags |=3D AMDGPU_RAS_GPU_RES=
ET_MODE2_RESET;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_reset_gpu=
(adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(err_data-&gt;err_addr);<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;con-&gt;page_retirement=
_lock);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; void *ras_error_status,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; struct amdgpu_iv_entry *entry,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; bool reset)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+{</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_err_data *err_data =3D (struct=
 ras_err_data *)ras_error_status;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *con =3D amdgpu_ras_get=
_context(adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kgd2kfd_set_sram_ecc_flag(adev-&gt;kfd.de=
v);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_umc_handle_bad_pages(adev, ras_err=
or_status);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err_data-&gt;ue_count &amp;&amp; rese=
t) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* use mode-2 reset for poison consumption */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (!entry)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; con-&gt;gpu_reset_fl=
ags |=3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
<font color=3D"#2F5496">[Hawking]: Shall we do further check on con-&gt;poi=
son_supported flag to decide issuing mode-2 or mode-1.</font></span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[tho=
mas] This &#8220;gpu reset&#8221; code is not belong to page retirement ran=
ge,&nbsp; but reuse old code.&nbsp; About how to reset gpu<font face=3D"Den=
gXian">,</font> we can do it with&nbsp; another patch in&nbsp; future.</spa=
n></font></div>
<div><font face=3D"Times New Roman" size=3D"2" color=3D"#2F5496"><span styl=
e=3D"font-size:11pt;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_ras_reset_gpu(adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return AMDGPU_RAS_SUCCESS;</sp=
an></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 amdgpu_umc_poison_retire_page_polling_timeout(struct amdgpu_device *adev,<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool reset, uint32_t=
 timeout_ms)</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">[Hawking] int amdgpu_umc_bad_page_polling_timeout(struct amdg=
pu_device *adev, boot reset, uint32_t timeout_ms)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[tho=
mas] OK</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+{</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_err_data err_data;</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_common_if head =3D {</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; .block =3D AMDGPU_RAS_BLOCK__UMC,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_manager *obj =3D amdgpu_ras_fi=
nd_obj(adev, &amp;head);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t timeout =3D timeout_ms;</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;err_data, 0, sizeof(err_data)=
);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_error_data_init(&amp;err_data)=
;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_umc_handle_bad_pages(adev, &amp;err_data);</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (timeout &amp;&amp; !err_data.de_count) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(1);</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout--;</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (timeout &amp;&amp; !err_data.de_=
count);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!timeout)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; dev_warn(adev-&gt;dev, &quot;Page retirment executed, but did not fi=
nd bad </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+pag=
es\n&quot;);</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">[Hawking] dev_warn (adev-&gt;dev, &#8220;can&#8217;t find bad=
 pages\n&#8221;);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[tho=
mas] OK</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2" color=3D"#2F5496"><span styl=
e=3D"font-size:11pt;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err_data.de_count)</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; dev_info(adev-&gt;dev, &quot;Page retirment: ue:%ld, ce:%ld, de:%ld\=
n&quot;,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; err_data.ue_count, err_data.ce_count, err_data.=
de_count);</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">[Hawking] dev_info(adev-&gt;dev, &#8220;%ld new deferred hard=
ware errors detected\n&#8221;, err_data.de_count)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[tho=
mas] OK</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (obj) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; obj-&gt;err_data.ue_count +=3D err_data.ue_count;</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; obj-&gt;err_data.ce_count +=3D err_data.ce_count;</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; obj-&gt;err_data.de_count +=3D err_data.de_count;</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_error_data_fini(&amp;err_data)=
;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kgd2kfd_set_sram_ecc_flag(adev-&gt;kfd.de=
v);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (reset) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* use mode-2 reset for poison consumption */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; con-&gt;gpu_reset_flags |=3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;</span=
></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">[Hawking]: Shall we do further check on con-&gt;poison_suppor=
ted flag to decide issuing mode-2 or mode-1.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[tho=
mas] This &#8220;gpu reset&#8221; code is not belong to page retirement ran=
ge<font face=3D"DengXian">,</font> but reuse old code.&nbsp; About how to r=
eset gpu<font face=3D"DengXian">,</font> we can do it with&nbsp;
another patch in&nbsp; future.</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_ras_reset_gpu(adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> int=
 amdgpu_umc_poison_handler(struct amdgpu_device *adev, bool reset)&nbsp; {<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D AMDGPU_RAS_SUCCESS=
;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
193,25 +258,41 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *adev,=
 bool reset)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; struct ras_err_data err_data;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; struct ras_common_if head =3D {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .block =3D AMDGPU_RA=
S_BLOCK__UMC,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; };</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &amp;head);</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ret =3D amdgpu_ras_error_data_init(&amp;err_data);</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ret =3D amdgpu_umc_do_page_retirement(adev, &amp;err_data, NULL, res=
et);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (ret =3D=3D AMDGPU_RAS_SUCCESS &amp;&amp; obj) {</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; obj-&gt;err_data.ue_=
count +=3D err_data.ue_count;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; obj-&gt;err_data.ce_=
count +=3D err_data.ce_count;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; obj-&gt;err_data.de_=
count +=3D err_data.de_count;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (amdgpu_ip_version(adev, UMC_HWIP, 0) !=3D IP_VERSION(12, 0, 0)) =
{</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">[Hawking]: if (amdgpu_ip_version(adev, UMC_HWIP, 0) &lt; IP_V=
ERSION(12, 0, 0)) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[tho=
mas] OK</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_err_data =
err_data;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_common_if=
 head =3D {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; .block =3D AMDGPU_RAS_BLOCK__UMC,</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_manager *=
obj =3D amdgpu_ras_find_obj(adev, &amp;head);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_ras_e=
rror_data_init(&amp;err_data);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_umc_d=
o_page_retirement(adev, &amp;err_data, NULL, reset);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_ras_error_data_fini(&amp;err_data);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret =3D=3D AMDGP=
U_RAS_SUCCESS &amp;&amp; obj) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; obj-&gt;err_data.ue_count +=3D err_data.ue_coun=
t;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; obj-&gt;err_data.ce_count +=3D err_data.ce_coun=
t;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; obj-&gt;err_data.de_count +=3D err_data.de_coun=
t;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_error_dat=
a_fini(&amp;err_data);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; } else {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (reset) {</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_umc_poison_retire_page_polling_timeout(a=
dev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; reset, MAX_UMC_POISON_POLLING_TIME_SYNC);</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *con =3D amdgpu_ras_get_conte=
xt(adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;Page retirement pe=
nding request count: %d\n&quot;,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_read(&amp;con-&gt;page_retirement_req_cn=
t));</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">[Hawking]: might remove the printed message here.</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[tho=
mas] OK</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_inc(&amp;con-&gt;page_retirement_req_cnt=
);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; wake_up(&amp;con-&gt;page_retirement_wq);</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (adev-&gt;virt.ops &amp;&amp; adev-&gt;virt.ops-&gt;ra=
s_poison_handler)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;=
virt.ops-&gt;ras_poison_handler(adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_umc.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 417a6726c71b..ee487adce7e4 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
118,4 +118,7 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device *ad=
ev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> int=
 amdgpu_umc_loop_channels(struct amdgpu_device *adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_func =
func, void *data);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 amdgpu_umc_poison_retire_page_polling_timeout(struct amdgpu_device *adev,<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool reset, uint32_t=
 timeout_ms);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #en=
dif</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.34=
.1</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
</span></font>
</body>
</html>

--_000_CH2PR12MB42155CF07B811857D84D73AAFC712CH2PR12MB4215namp_--
