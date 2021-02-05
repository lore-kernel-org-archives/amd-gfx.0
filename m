Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5039C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 06:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EC0C64E27
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 06:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC0C64E27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F6836E19A;
	Fri,  5 Feb 2021 06:08:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDDFA6E1BD
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Feb 2021 06:08:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMKGDBHP1u/76NmXaLT+2HjEucpYkiL8Bs7I5x6EYOFnLfRNWEBcGYqXeVY7zlK3OgzYGGncKdKZz6hsxRmNWcfw4io52Y1fcWH9YfQZBw58jKlKbQ/zCgmVW/CE9EZgaB6xQCV5M5Ikj6hyIVkawd6Kgs/3e1xxExTKSCw+6q8SrVUfxfzsh7EY+5VqU5bHHSXOwaBOhG2q85IKWZmXtji+t33cdWJqq2W+piT01XhksVyJMqY5xtZ8pN4Y+Da0wcT6eZ/FzfLB/FzK0rtxSPt3/CWoZYigVkw5B7S3FfgtWXyxZ3wYE4m1X4fq7Aga4QT5AsWs7hgus62H1g/Chw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPsE/yKOncs6lsmRqHQ5V41RMd1g4VRhiA0lAC3n3lo=;
 b=b08Rk1+l9VEoWAx0m0p5AKDt6E215ELkoAyLIHm/gc8lfF7ay1+YFhnxB862HFlPQTBqi+jW2356EphOlDJCCUTYC0hxULPs5Iub+aR1snOv0t3US7vJ581+yyDKqLniGy7VUWyl0DCxL9SWxOf0hJLmXvwaBeN/+wFewxcCkbHDqIIdN+30XOegn7oxaOk5rjAgyB+VYxdNrTMtaHo7wB6wEJp7Vmkl+o+x8rueE1EGcC2n5lqg7fdsYXsM859ng+WQY1x2TKLZrGe3z5o3gd7GNP2sc5fuETsjbEcGOncVu8ZQreW6ml2EzDn3KyZaYSa/C5q6FObt8JYV4DJexQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPsE/yKOncs6lsmRqHQ5V41RMd1g4VRhiA0lAC3n3lo=;
 b=aWWbZKf7hGNsWK6TOChJQ1MkqLB9kW9BbLc1SdyWbAnlwM1SPZL01UtCAzRRyLIpV5VzPiQEhmnAJ4BmBabbqk/u8jlAsECST2EzO6WmUm/VnlOI7h3DX5TffAfjL7ggL6ZNyZGla/E2iYgF2rth5mBnXoM/POKXcI7FcNjk1z0=
Received: from BN7PR12MB2692.namprd12.prod.outlook.com (2603:10b6:408:2a::10)
 by BN6PR1201MB0164.namprd12.prod.outlook.com (2603:10b6:405:4e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Fri, 5 Feb
 2021 06:08:29 +0000
Received: from BN7PR12MB2692.namprd12.prod.outlook.com
 ([fe80::ad58:45e1:d143:b248]) by BN7PR12MB2692.namprd12.prod.outlook.com
 ([fe80::ad58:45e1:d143:b248%6]) with mapi id 15.20.3805.033; Fri, 5 Feb 2021
 06:08:29 +0000
From: "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu: use runpm flag rather than fbcon for kfd
 runtime suspend (v2)
Thread-Topic: [PATCH 2/3] drm/amdgpu: use runpm flag rather than fbcon for kfd
 runtime suspend (v2)
Thread-Index: AQHW+zEHa4WDaJBByUax8HuyfI4rAKpJE9IA
Date: Fri, 5 Feb 2021 06:08:29 +0000
Message-ID: <BN7PR12MB2692FD0C8B6AF2A4CE1903ACFEB29@BN7PR12MB2692.namprd12.prod.outlook.com>
References: <20210204200450.1900-1-alexander.deucher@amd.com>
In-Reply-To: <20210204200450.1900-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-05T06:08:27Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=51583eb6-83ad-462b-a872-e0f91d76e6f1;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48471d8a-e579-456a-70b3-08d8c99c7565
x-ms-traffictypediagnostic: BN6PR1201MB0164:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1201MB0164BC999ADF8FF2575D5774FEB29@BN6PR1201MB0164.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1qtolnf54dCp1cM9zFbsVkg49iRmXWJgWEoTOPPkG2P8cDadLajG6VBQGX3WTfR6HHDWeXkj87PYGvnBakFTt6qwrucPQpku7W65ClTJ/0JnShQWcnuLSwjA7g1+FbBFVYGQ2/ls0557J4ZmKH66pPthOu9dvpX5S1bZnc+UQ2c0U95xrxbndGunWy0pqYc5oi8p3nEgDHmZ2aOtSHlQ1uakiKpL7puPD042XgUsFdwD2GF5Uu+BvUkYhO8fsiBH9xqv9bVkzHHKV1y4Lt3cKnMh8pOZw4jS8/nzIEYFoAHIpx7Y5DLAryRVQV+OUSbGi2PprGCIUOK2GKBZQMyNSXIAFxGrQvI36p7Fqs3oPK3swBvzfBnJ6ZWopndiWEc1+2VphuZ7jpyzSA5k2Wkwi3pi7J1votHzjlaqIRtUQ253AfpaTk1Paw4SOk6iIILJ8kvY8n0DBhaPmFT76GzZW2/O6+sjoEiDIbvRN1AMyfTJHKidOqX+FQeal+gX+Fm3KA9QRlqGfYpDJ8YFMwjiRU0BGx/wjwODKErqzU2KuXND/7cdbiygBH26XPLFrMN4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2692.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(316002)(7696005)(26005)(966005)(186003)(110136005)(71200400001)(15650500001)(4326008)(83380400001)(53546011)(86362001)(6506007)(8936002)(52536014)(2906002)(478600001)(8676002)(55016002)(9686003)(5660300002)(64756008)(76116006)(33656002)(66446008)(66556008)(45080400002)(66476007)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LFb58swJpeTldzmARy/+fS6WgsIQsLR1cKmXKCCAhz3FS514owub7luphb5i?=
 =?us-ascii?Q?D68BYZtM02R+zyHEjq+zW19UhOI8DUbITDqbj7fUmYJOhQRq2GHZihGqNNl/?=
 =?us-ascii?Q?41k3rXcTc1o8+kV+tvq8KWR0dfJjenNGhbQ0RFGjvj1c9ZhJdul1ZyxXJcWG?=
 =?us-ascii?Q?g9dm2MVtaO6w/rW8ERB50Dp1uQgYQ5IP/lxcWt0QcVKBrynelSYb9GML8WBR?=
 =?us-ascii?Q?37/Yqw1pKrJGWgghF43xqXd3KMwJxLhPVe7fgO5Yv7cPAtaGAoyGtPCc9k81?=
 =?us-ascii?Q?rxgisJrCadCVxoRcc93d84wzhirtWe/Q7dUkxO9LwRRVbZa8yGcd4E3JiaLn?=
 =?us-ascii?Q?N56EQwun9GwTuhwHiNX2veBuj66xKR3w2U2rWD5UuzsgrPJIWOFWm+/beryj?=
 =?us-ascii?Q?9hk7wqXkMRb2oMhW1iC0Kg3Dg5OfUaq/tsPdkcUepIpH+Y0bztQS9bqEs5Pk?=
 =?us-ascii?Q?WhkGKMf0o/4l59XG5RXCZFoxpe7BFA0oAoFkTQEEXlYKjG42qwip/Bq3fFRI?=
 =?us-ascii?Q?1aIOn9SHHa7Xm8+HzAcYHivLWfw+caxMRIhLiU9XFScyQ/IOS38RJdEGM4xB?=
 =?us-ascii?Q?IEYQOIoAQFRo+Yn98/E3gDl9cCJx7nMdmmuDJAGTYTNPvAw9kTOcPflfoxdX?=
 =?us-ascii?Q?Efmc5rW++6dyQgw1ceopqOeGGwT4K/SyCWHZrdw/TAHZKNZpoAJaWqFHc01C?=
 =?us-ascii?Q?gnqAj78zWrwl+hnAnhdmcwQvTtLdakBIHbmDujIej7jSlOKrKxb75AhS4uRC?=
 =?us-ascii?Q?JHA/GSsGT5nE7Y5BgeQ3Tu3Tm8tLMM1HY2oQS+GayFGAOrrTVANVsckluXA9?=
 =?us-ascii?Q?0OGuQuUDOWK1WRy8mo09CGCNBW+w3WeSjxLsOnoK6Rqxa/aCjAR68V1QfrXI?=
 =?us-ascii?Q?K0T4mt0SZaluYh/SFK4xL+ws+SJ+kFRNYRgaiNDuV82Q25JJCetKlJyuTZuu?=
 =?us-ascii?Q?+oe/qnGQ4V55fD+iLJbQudA5e9gQ/8Wm5Lva+8APwpo32uJvMUTpC1yYnDsl?=
 =?us-ascii?Q?ZX+gnxyEzmqRhlSXB31wv0bHxYo2CMRXWBKGzIO0etf1g1pLk7k95dg+GfHg?=
 =?us-ascii?Q?Xq8TCsNSgBMlWWBkn3CHFSBQKL4e7mueS1LCEZsc5mPQ+MuDGRHGtSnPmV9R?=
 =?us-ascii?Q?enDwxq3tMPtIFvf+Ndi72muT7KiKMwlA0uIkDunS+BWQFXvBlbqgz4jZrVSZ?=
 =?us-ascii?Q?JH+stXE+4NaTAUuIVsWvluxy8WAkB1J+PQt2ZrGcRR5xYIh/WLSNSJyO8gUS?=
 =?us-ascii?Q?tCCHf6GvrKMLPwqU8QwnpWXebdVaa+Qb8w4ndxEhEwiX38dWxHgSDpiwIs9p?=
 =?us-ascii?Q?E/v9NVocfNfwwx9x/gv3tgAl?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2692.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48471d8a-e579-456a-70b3-08d8c99c7565
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2021 06:08:29.3209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cREpZWfO7s3R2TAJROC7Bf0rttcjDhBvOODb7ks4NCYk1ZUpSzRRtO9DNWkqq2gDfmOJnEJ1dyq8K19MYpYygA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0164
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, February 4, 2021 3:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: use runpm flag rather than fbcon for kfd runtime suspend (v2)

[CAUTION: External Email]

the flag used by kfd is not actually related to fbcon, it just happens to align.  Use the runpm flag instead so that we can decouple it from the fbcon flag.

v2: fix resume as well

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0ee6514ee55c..b7ebd424bbc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3734,7 +3734,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)

        r = amdgpu_device_ip_suspend_phase1(adev);

-       amdgpu_amdkfd_suspend(adev, !fbcon);
+       amdgpu_amdkfd_suspend(adev, adev->in_runpm);

        /* evict vram memory */
        amdgpu_bo_evict_vram(adev);
@@ -3818,7 +3818,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
                        }
                }
        }
-       r = amdgpu_amdkfd_resume(adev, !fbcon);
+       r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
        if (r)
                return r;

--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Crajneesh.bhardwaj%40amd.com%7C9c0a731196964976779a08d8c9482859%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637480659048145725%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=SYs%2FSx9iZmQemW3IcKm7z3Kv5QQQVwjOA7b5idtxE%2Fk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
