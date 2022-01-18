Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74453C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 02:17:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A26C1128B3;
	Tue, 18 Jan 2022 02:17:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 574E01128B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 02:17:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/jKHOBfANHX0aV3VFu4WTUOLp+QCldxk+oV/zDNeM6cgLjwUsptI7rUIuDzG1HUzyArbDi+ByMAUA7vvjG+l/bdT72HNEJ9FfYcbyvOWJ+qaPPX3+q8X1FLy+lf92MWS2wHaNx2IZw4LQAE+0nvwtjEpbGQH+itRHB+wXvVQccvGxazvX25hsv21GOMtPZUWzO9Wcvr03Q977SflJQnjRaXUc6k6OoVWBvYZ6HA6JJLyqZaxnCg5+Dk3kbeNO/cUBtSRU8NyrsJruVNa861uT6XgJRT05RXbeOhcd/o0SEUsVesHiwqRlveXQIJkapI03XLD8lLON/4tahkpfUV5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5uK+pnDxYieb6zI4NEcVXDW7zOFYxGfZ7QSsv+nlH4=;
 b=iWRfg1wR3ecEndQGZ0k7Uxb/ST9FjbyBCyOOmsujaOIPtyF6YhvcqKdRNLgufxOSJvqoeCq3vLXLb7bgez6pqBAgHY6BssQjG9wkRkVn9loB2BbB5kCYuW/O52I2ZwQUhkU3VE7pGQAo7nTbtVtPT7mYFxJ6h1CWiRrlW6aUnkTbtj95A8BML1iigXaFwYi+bYJZduy+lTjOUVuU0n6sZwc4dYi+WGTD7CEat4A4SuUkYxAwlsLCodL5fA4k2KjUFiRPDzX0JAxXcNmxH1lpb6QaG0JPlwUYhrRYnY1K4fxaw1bsZI6UqWMZDz2OaxNLL1fZecu5oiZNBxg2C7HsfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5uK+pnDxYieb6zI4NEcVXDW7zOFYxGfZ7QSsv+nlH4=;
 b=5r4YMgy4gMkobe97vCmbv9pS9KMaE6Kg6cbUSMzkmHnP9R/mJgfXVO63RTtmwpU8kWCA4dgaDz391zaeTTm/+ii7QdGrSSBIzlxaigF+JAyh4tAGjmgWGRP7kHp79grRirdXiuEHxE7gIrYxeEPGOlNBbFEURyKPrrv5Fq9TN4o=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 CH0PR12MB5026.namprd12.prod.outlook.com (2603:10b6:610:e1::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.9; Tue, 18 Jan 2022 02:17:40 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::1500:4b8c:efd6:672]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::1500:4b8c:efd6:672%4]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 02:17:40 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix build up and tear down of debug vram
 access bounce buffer
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix build up and tear down of debug vram
 access bounce buffer
Thread-Index: AQHYC/wB4n/uUjOCA0eOf90imw9wI6xoClJw
Date: Tue, 18 Jan 2022 02:17:40 +0000
Message-ID: <DM5PR12MB2469D98F143BD6A627F0FF1CF1589@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220117234307.3820143-1-jonathan.kim@amd.com>
In-Reply-To: <20220117234307.3820143-1-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-18T02:14:42Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7e3c329d-860f-4bff-91eb-e30a4f33d6fd;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-18T02:17:37Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 884712f6-4452-4ff5-b27a-2ecee7a70ea3
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ba45744-5d07-4eac-37c0-08d9da28b431
x-ms-traffictypediagnostic: CH0PR12MB5026:EE_
x-microsoft-antispam-prvs: <CH0PR12MB5026744F23A11C408A3E44CBF1589@CH0PR12MB5026.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QB/c+zWMoWMSajwwi72mHgDeX/4pXZAPxo/JfI0vhLc8FnLUA+su17KBNj/efRAlrJkBdv/28rtJnGuE/tDHlgqcCW29Pjc7jRAid7LMml7RdARAcI6ZLFaavnTlpHfkS3IekDHZN7ZpSPFPEDnxO3uLjmY0hNMV65a80D2yQBuLgM3ZyG13DdhUEFehAwpSQkLNX9V+9hB1hj+R0BR2AZnRhUeANz1pweXxSXuB5eh03sFmQ33IJAZx6JlGLlBbE+0rHa7Zte+fbGNyHWG5g8OGDSS61MKsOGVOvUwBKlW4BwqEx6CM8H1w9OCPHYLVkK4uD5jNW7zVZC3uo40frkgXPKnd5BFmw9T12v7rjWPn62/3smkYs5kfzdDx1+Dobe+dMEqd5lo7NG9ZqQ9AlC0M7ZLKfUk+aq0BdNe6TJdkqKeOukZ8LpVxU63+0dKWAnB4uXxrJGHZ4StDQkHAjwnLe4C9OqDsbJjfcQ85sF67XzTkrJc8td0/ccxcvPp0/0usNlJBUYUvVyPbdHYY82lPGtnAbnBeER35TaboOCFsmR1PbPHKvvUQKddDTuQj3Oondm6OseVUlX7FOOlrjVhbhdLfFjurY/3NW0AQjs3/A0r0wJTc+bPiJ5p9Ju5Vk5EeC2FpxocqzCr534Z4huZ6y+PghlE0WDcWdCcY/AjOqwPbh1cnA1I9F0NVIfW1cmADH52OaEvSqEDrACqaiw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(110136005)(52536014)(186003)(66556008)(316002)(38100700002)(76116006)(54906003)(7696005)(55016003)(66946007)(508600001)(86362001)(122000001)(53546011)(83380400001)(6506007)(64756008)(4326008)(38070700005)(9686003)(8936002)(71200400001)(8676002)(2906002)(26005)(66446008)(66476007)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zfr0FcTrfa040CxDNOeq6xjIoFElJCzopNhljJMzuQgFTbcsy6GER6yUNIz0?=
 =?us-ascii?Q?wOj+NTXvm7PmKa3bdI3BYQi0A2Ef8HJiqoctFpM1UdlO3uF/toMkrMIQw8YS?=
 =?us-ascii?Q?phhfdqJHfzKTd7RzDyuXFUQPvx/5ZdFStnRfMCfD/tgry9JOhIB52zIJns5q?=
 =?us-ascii?Q?QvjYFcxZUrI0oU2TtifV4P7q031Ng9+aUPyGeVtFM2WEuo8b+WlPl6FFM4oj?=
 =?us-ascii?Q?1+IM3ioyE0dy/pxu8IxlEE2gR6MTRCg/Qwepv9PTlOcpHahYnPL0OGOawQsQ?=
 =?us-ascii?Q?0NWQ+tgksRBqF8ha6eJ0yg3AViMZgF818Cq+r1K5SzMEptVMVDZODSS2KT8C?=
 =?us-ascii?Q?+PSCSsgDwX3P4vfyJvzH44befYyj3ifOuynN+8pXP+KnOwkMJcN2ZwvwQkQL?=
 =?us-ascii?Q?6X47bsFqN9Gbc2bt2Rz1T86JH3ngunCl3wFAvNrhCrqOz1MINyjfSKbdvNxv?=
 =?us-ascii?Q?ynK/NjoimUnffwzHO7fXiRKf76bvfH8jrOVdngdjZ+D/kqHni22qAcOIeNG4?=
 =?us-ascii?Q?0vbzUyA1vHR9TB7lpjtIvrOW1A7KxTMpSNZzQllASdzEm6TPJvL66lhJ6S1F?=
 =?us-ascii?Q?vbiMM1izBhmrT5MWL6QUwNp7JWeIUCASNlTJZM0TUZU4tV782wVn/7WLts4k?=
 =?us-ascii?Q?WC5MUWk8kCnuVWnlH9GiD211N2E3BXqB7JiZ3iqShLfxnDBHVV+ORKG2MCm7?=
 =?us-ascii?Q?a8sJkfj16h6boXSmVMskGyamS9dT5419VENBns4ntAoN16jgPo1PAwbmrvkP?=
 =?us-ascii?Q?MfnvOTWSxeXmXHtharly1GR3kHh5Q1LTnsfVs9f7/y+uvgxHo6UWDKtlZHZN?=
 =?us-ascii?Q?SFdNX2W+x4iElKvrvHBsJOArvPiHA3UXsDXYmlM3Ih+YnwsOySpp6CcO970F?=
 =?us-ascii?Q?14KcoZdE6N0RVWvSK51OT9jaRtKX4/34CN75P2+jB3ujuqelKJxDnVBUu0Xn?=
 =?us-ascii?Q?VynTdL1xOaAdSZlU37eyBQ45ujdmfZyUpCbzjWLGDhdXJLhl5wc3qIBxUgGQ?=
 =?us-ascii?Q?r4wAnUmv8ylenkEF7zxHmX1u4U7KW2QhtjpjGc7PWuLwtQrnD2US9X34CQcw?=
 =?us-ascii?Q?w2GtjsYzFO2UhHbXPepdTR7UNfkqVzph5NVo7fhjUbZLu5t74IZd58K9sd+b?=
 =?us-ascii?Q?kx9Ib3Q+GYmPsxru/sM0kiDNp76xxUMLceC6zwgTR8HozbBXQKZKHaY/Hyin?=
 =?us-ascii?Q?KkVzQgSJ04uMzddAy0ko3A+wO3lnis5xcWYuVomWlHQCg8+HgbF2bfWoh1Sv?=
 =?us-ascii?Q?UnxbIY9VsGMPmLoPmXYDqNW2GKGz3i1w03EkO3FtWvDaagqTaUrmBGZv+52l?=
 =?us-ascii?Q?op/1hW82e5DmYW1Q/RBtgbSY5KJn0MFtnpVsGqGMQHK3BZmFKc7bKbjxz6H1?=
 =?us-ascii?Q?BOUlS6Kc8nQTBoSmLiVloW6FLRHXqt1xf6C+HOkeQPYRbmZwH4ULy1VIUD5Y?=
 =?us-ascii?Q?CiicW3DqAsYKvKirE0PQgALj20kHMaDuuoG17pa2zbbaLXQGjAK0vv8Inh/N?=
 =?us-ascii?Q?lz6DTaQu0uPEhVF2/Lmmpr6Xfqyzq6cvn/kBWQssY8wrGYFLLaIE6/WNy99F?=
 =?us-ascii?Q?XgkPzd8JPL1gfiVNkgIsvjf1FQadi8o2XsrSRR3HPkstUkzV6MX2R3cJMGjZ?=
 =?us-ascii?Q?gZdmq+zmXaXS0YJRgssv1cI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba45744-5d07-4eac-37c0-08d9da28b431
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 02:17:40.4432 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eRHpnPIFamOXs37XPufhmYi5VkDkzNLfB8gNTPvDYnJlc3wg2uGvqKkMsNYC1hIJ7BngquJvsPHe3feGj9hRow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5026
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Thanks for your quick fix, Jonathan.

I wonder if it's better to encapsulate the bo creation into a function and =
put the function definition in amdgpu_sdma or amdgpu_ttm?

Regards,
Guchun

-----Original Message-----
From: Kim, Jonathan <Jonathan.Kim@amd.com>=20
Sent: Tuesday, January 18, 2022 7:43 AM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian <Christian.=
Koenig@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Kim, Jonathan <Jonatha=
n.Kim@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: fix build up and tear down of debug vram a=
ccess bounce buffer

Move the debug sdma vram bounce buffer GART map on device init after when G=
ART is ready to avoid warnings and non-access to SDMA.

Also move bounce buffer tear down after the memory manager has flushed queu=
ed work for safety.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  8 --------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index da3348fa7b0e..099460d15258 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2378,6 +2378,13 @@ static int amdgpu_device_ip_init(struct amdgpu_devic=
e *adev)
 	if (r)
 		goto init_failed;
=20
+	/* GTT bounce buffer for debug vram access over sdma. */
+	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
+				AMDGPU_GEM_DOMAIN_GTT,
+				&adev->mman.sdma_access_bo, NULL,
+				&adev->mman.sdma_access_ptr))
+		DRM_WARN("Debug VRAM access will use slowpath MM access\n");
+
 	/*
 	 * retired pages will be loaded from eeprom and reserved here,
 	 * it should be called after amdgpu_device_ip_hw_init_phase2  since @@ -3=
872,6 +3879,10 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	}
 	adev->shutdown =3D true;
=20
+	/* remove debug vram sdma access bounce buffer. */
+	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
+					&adev->mman.sdma_access_ptr);
+
 	/* make sure IB test finished before entering exclusive mode
 	 * to avoid preemption on IB test
 	 * */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index b489cd8abe31..6178ae7ba624 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1855,12 +1855,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
=20
-	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
-				AMDGPU_GEM_DOMAIN_GTT,
-				&adev->mman.sdma_access_bo, NULL,
-				adev->mman.sdma_access_ptr))
-		DRM_WARN("Debug VRAM access will use slowpath MM access\n");
-
 	return 0;
 }
=20
@@ -1901,8 +1895,6 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
 	ttm_device_fini(&adev->mman.bdev);
 	adev->mman.initialized =3D false;
-	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
-					&adev->mman.sdma_access_ptr);
 	DRM_INFO("amdgpu: ttm finalized\n");
 }
=20
--
2.25.1
