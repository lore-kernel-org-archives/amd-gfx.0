Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D721C7EE39
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jun 2025 07:12:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0FBF10E39D;
	Mon, 30 Jun 2025 07:12:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ap7ILFuh";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79B4C10E39D
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 07:12:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoIIvpM4atkPkQ3OFT/d751RwXasXTtwKrKiznf8nX7bIBdbXQ1dGvGy/eoC+q0J6nbTREwa72NFh0/3haLo3DFPHs37qlN0eVIhz8jGJHhL2qd/AdDMeSAnQv6l0wXEEuGB0PtrKrXhDXXvl3XKhkCifvG2P39U3Dcu9woGMsiC6pslPPacLWZMZGswMQzHNBJbFbFT16AiB4on/j8jKnU76vHl8WGf2iO0UopsipA0tL4S8vtPSKe4+RmFS4e5ESRcntv6UMVRUbmefej7KkCZ/JwqvwXW70DOH4dvKbqOqXEItt1auqTM4sNlmXuPKY5tye6tyqqXyg69dnK+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxKp/WQlWrHY8lzDyZAFY7V1qjOFWS/jCghVZ6jQnog=;
 b=X7qdlNJue5E+JoM6ZwN8ATisWpPirWv640b3RrxJEbgXtLhOiQ7/n1/ggMuE0BzBg2owRrq7a+71SaDYQp1E7PW6Sm3utLUyDWStqZJnk7aA9qC3Snno3YX2Mr5utP7aBNxqiFqvOdupPGMBbdkng2cmanx/HJDd1euUOUQWQwfH0CQcBEPAtbBEc+83BB3rmaI4GDakDo8KHKQ/+cRb3R7bNGpGy2yZtB3/XKRatM0Q4SoBTtuMjVhQeiQa2uVgz3A4si9cYOHsYpN+w5ITaPuUslsNfhaST/b9cAotQGBV7zZhh+jvb5WpjVVqM6Z54gp16PFNudCti6VlXYOjkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxKp/WQlWrHY8lzDyZAFY7V1qjOFWS/jCghVZ6jQnog=;
 b=Ap7ILFuhzKYFGmDcOP8t/XwadcXOBGiKkNzMA61lQcUoTcTguK4LIojDu2nFxHrDNLn5mdsASVwQkybqEJ/2ZV5gat0YtE52lOffNpAwwLM/1NnQyBngOL9EoAZBFz09SiK8ufPELjXztEOJ+TuQRn28Bv5I6ZdKRIqVu7NFx0g=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS0PR12MB8019.namprd12.prod.outlook.com (2603:10b6:8:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 30 Jun
 2025 07:12:31 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 07:12:31 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Remove useless timeout error message
Thread-Topic: [PATCH] drm/amdgpu: Remove useless timeout error message
Thread-Index: AQHb6Yvg6UrqDQbGdkSm2rLTyP23g7QbSYRQ
Date: Mon, 30 Jun 2025 07:12:31 +0000
Message-ID: <BN9PR12MB525772AA1AE3FC20C647D45AFC46A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250630065417.3534309-1-YiPeng.Chai@amd.com>
In-Reply-To: <20250630065417.3534309-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-30T07:12:14.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS0PR12MB8019:EE_
x-ms-office365-filtering-correlation-id: c48cc206-03d7-4fcf-e2ce-08ddb7a57ad6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?dBetVlzw9pTn9+ndY0nZGTXV4Av8HlbQULyXxMaBafbohLxbHm2V+jxdhkGW?=
 =?us-ascii?Q?JwFAjxju7dLZ9dphF787bpoFFIJS66rrIYmXzjR7ALLtz/dA5rcQIXglPWPU?=
 =?us-ascii?Q?GG2j+Np+vZyOdqyOHp90JrU1QV9VCy0oI8yKuBMwGpzv2VKLCvdY9/22rjyV?=
 =?us-ascii?Q?CFQqovwZcuQn6rU6suAwIFnZliNDiBKadPcM/Z2oDa8HxJm9FZ3Gv5kk2B2C?=
 =?us-ascii?Q?i828ToilqBylZPBe/2tpmD6G+NV54cUIUem8KGy8fe27y5n0C/c4COwCDauq?=
 =?us-ascii?Q?hqrg9fOVg9WR3P/PciSBBTEBShUruxP97hQXoa79p0bn7yMLxolQWvC17xuC?=
 =?us-ascii?Q?zVZAFbRpFkK89h2U9RWiwDsx8u03Yr5SgOdIP8eP+5SrBM5KtJpWOhTJftcB?=
 =?us-ascii?Q?NEpwOLvQRy0L2rLPkz0I2PdpFQYJ3sI7oHoSze+TONm+9SzprRX0kZOP2hxQ?=
 =?us-ascii?Q?NfSubEmjBmghOSGyrCaE0alsNOJq6T5iCqgwkeb+s00Z9SYNrAyfS85j2TMw?=
 =?us-ascii?Q?Pewrnll3kwskKk/na8pv84P6hiBExDtebuaJ2a/1JdVYWq6mZFfCLypNTRwY?=
 =?us-ascii?Q?Zpxwkwh68V+MIWsmhECTH1N5zRNWW9eNK0N7K1KQhGemTX22oFkhEuXL+nY0?=
 =?us-ascii?Q?KUJPo13UtduyCZsJYPE5D6561e+TRuxbkFSPHKdx7NUwaWEvFsd3JpuXpa9G?=
 =?us-ascii?Q?f3lKJkgfNCJIxOSNV+R/JDQLFFk+GWvmyWg/KXqT4bAwuiQqHhwFG+nBHIU6?=
 =?us-ascii?Q?2oentdYIzS+jlJXp7rm3Is8bWqTJFPMnWCE2R1G5t2zBaryOy9q2Ibn0aJCS?=
 =?us-ascii?Q?oGewPKqq/64zdrq7jcSjNjHHR4raE4f+IIQXWYv06u1bo98N+Qj81lX0CHAD?=
 =?us-ascii?Q?irg52dNcN6jwT2vVzyPPV9zEnWeBTuJbGp1DCKQbCGl41fp6eDIfvBGExrxv?=
 =?us-ascii?Q?j8uw0hDoyhZDM8s2FyvKLXlHPCqBHahETyp46k1cAI+FIdMVdi9ioJD6YTMT?=
 =?us-ascii?Q?mTJugPrsDcXSFlYzY2F6G06qiJOWzR14XZcllULZVg6sZzX7yx5FEmajY2UR?=
 =?us-ascii?Q?c/6UHznBXCg5JOQNnlwLpFcIsVnQ1oxeel5I3TqvtQzVrqYp0ySgMEn5W6EC?=
 =?us-ascii?Q?Lp8/m51lGoQNHve7Wy7uOnaBsAxPSzLaV2iWuqiqr2pQsapeav0PJkPlKZax?=
 =?us-ascii?Q?n0K0Ye82xbh9G/tYSChvThNE97E0sp3ZJWaWI0ZXYIk0B5MhUanqjw9Gz3/m?=
 =?us-ascii?Q?Ezs5uQ7A5nCJShMeOZ9KgMZ8nzAT/pL+Aj1GJ6pKRiiHziljjLpcRmmKp0L8?=
 =?us-ascii?Q?tCyDWKAcUqiwN5YZw0m6NORdzF4yhBNNac07BYEiAiQcAvKTwFfINK9JcUIT?=
 =?us-ascii?Q?ybezkaQcSRFqaN/HC/N1vvm5MyQINTVhZOZ5vzrLbCHeZ5Iwh6ouyTGWxxWH?=
 =?us-ascii?Q?BqgGEutRjGUeG7AwwKaXpcJpaE6poBN6CQdK15fOvNOR8G+g8H5m3HgshakZ?=
 =?us-ascii?Q?JBfMG8MwgnWXxoQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SMEFOs0JvFjAr3yWLiXib3rt6Obpycwx5MEoY4KYcQ2Wyg0uBnCrANy0Pu32?=
 =?us-ascii?Q?xoqSonLjxjR9mFZM7/+japqKzgde4QXrgiNGR8tMdUD2suK/ks2yN5NvYTqt?=
 =?us-ascii?Q?7NsCB9QotOGZ1DTeMee9doshDVsubBeu5iS0jBEsncRVGG4ser4zQPh8kll5?=
 =?us-ascii?Q?VJ/l26qJVeic5kGntSo7AERmkwItl0HKrUwYkGIgBp1/zh8iYc2E0jkiZHzG?=
 =?us-ascii?Q?vkwL4RCeQBzGtCnnzuB9zQbviirKsr+WyACOZAEra0dXtEkZIQnTrbm2DxgR?=
 =?us-ascii?Q?ymcPmqsNBth8UkUgrfEUA9vl7kDCb6tHgNdfhpPHex/iKKzPHhBBGYQ8xgo/?=
 =?us-ascii?Q?zxkBNelMtu0gFeAvigrQPqcLeLOaVKicljgIKBG4TVKt5TZybz/RmQygJuFF?=
 =?us-ascii?Q?JvVuhjaE/vbSAa1aFETb3J7gVZbkHFbOml0yNUzGStoWL6zsF03Xz5I/mKat?=
 =?us-ascii?Q?qeYb/hQZk0yNJrSw0q6j8FL2P+Ck96XJho+/VMPpibe2K0w6KylEcTA2Y+I0?=
 =?us-ascii?Q?JTiiBmBMhQhzOLjWoZi+8bZyooV7kre7rXUK2zxZKbcqwj1VovdghpCCjWLB?=
 =?us-ascii?Q?QgjC8/Z0kIr4mgUfA+3P2WOYEmAO3cVOmbdzNw0pBQBJS0o3RlrbKTtIDT1/?=
 =?us-ascii?Q?3KPOyJMcP+pmBC+61hhnSX1NkFoJOtj65YWdW3rqEZk4l2yfp43KpzJK63YB?=
 =?us-ascii?Q?irZvVa6sW0mTB8ureV+DQaa19poINlDLyrHvSMaSAKho7H0aqcHlaNv13OeV?=
 =?us-ascii?Q?tdo9tYQyL3U19UHFm7JZbp34JIzn4WPCyGDj+KR0Hjm+jz8lOUOEzLkjCQg2?=
 =?us-ascii?Q?jPFlLQ5mZqMfe/y9LYt9OO91V3uPFnRkcl+0K7UQPuwd3R1jGelMbXAV/GSe?=
 =?us-ascii?Q?4q8YSvmHiPOHQb17Xd/G9BZnZH1hekKHSIE/xZQxh9/zQX8vcYb0uRHxscOi?=
 =?us-ascii?Q?Qz55ibApWQ9WFl8WyEPO1QR+T4/0x6vTR0envghlInfGyF++JBH9fFDNyHVO?=
 =?us-ascii?Q?Bwux7FQEqYGoTzPO30CbH3J751yK2BI3eznLY6SBkILU5tofbVF0uomhP32L?=
 =?us-ascii?Q?42SZ6yvrb5h4nJ7g9Kd7FgA2MevZryySsKVrhjx5fVYv8GRwcQ45IU6Ljc/U?=
 =?us-ascii?Q?8oLjAXiXJfxHM8yh8NoQZflhxnvcmzV+XIe74v2ujFOMG1M9wtOFpVGr2c8m?=
 =?us-ascii?Q?SomDV8bTj+dZxGSO70a4YQ/FR3GqbI6vVwOoaWh6i7sJEBk0LL0fX8Gk6qre?=
 =?us-ascii?Q?ez8cvuCDnQfwMwWzcxBHyVhJdFcJOLCNWnvA9KFNPpwifVuyYqUs7K8k1h39?=
 =?us-ascii?Q?Pnu+dUgcQ2YZu3M4gxlRntsM0asBXZ0h5jI6iD1FZNC9JTQNzaJJdKlSqTK5?=
 =?us-ascii?Q?VIBIYWzN65xF02V7/ngrCtJaISFHGbyKK9GfPENRwfy4RlgN+SE2s/AX/kRG?=
 =?us-ascii?Q?96gi7jYbWOyMBx4WwIg9E9f/XSAxUP6M+F3+DzZBATKJMDpZlGF82uNo4rVQ?=
 =?us-ascii?Q?11LeB4M6Qu1ljbDuXdSZTnOjq6bFICyaz/i48kCmQi7j5AFRDGPi3xPCUUnv?=
 =?us-ascii?Q?FU7fBH/yRWE6KdWTBP0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c48cc206-03d7-4fcf-e2ce-08ddb7a57ad6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 07:12:31.4234 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aoZn5qMBaEOEdxN5tWTFvtrUDqROh3ynavnCUkVj71YPEPtIBeAFM3Mp4KBi7qm6XwHmlYOaxeh9Xn2OwLVIog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8019
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
Sent: Monday, June 30, 2025 14:54
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; =
Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: Remove useless timeout error message

The timeout is only used to interrupt polling and not need to print a error=
 message.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 514b56e5d8ba..daab4414df50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3304,7 +3304,6 @@ static int amdgpu_ras_poison_creation_handler(struct =
amdgpu_device *adev,
        uint64_t de_queried_count;
        uint32_t new_detect_count, total_detect_count;
        uint32_t need_query_count =3D poison_creation_count;
-       bool query_data_timeout =3D false;
        enum ras_event_type type =3D RAS_EVENT_TYPE_POISON_CREATION;

        memset(&info, 0, sizeof(info));
@@ -3333,21 +3332,13 @@ static int amdgpu_ras_poison_creation_handler(struc=
t amdgpu_device *adev,
                                timeout =3D MAX_UMC_POISON_POLLING_TIME_ASY=
NC;

                        if (timeout) {
-                               if (!--timeout) {
-                                       query_data_timeout =3D true;
+                               if (!--timeout)
                                        break;
-                               }
                                msleep(1);
                        }
                }
        } while (total_detect_count < need_query_count);

-       if (query_data_timeout) {
-               dev_warn(adev->dev, "Can't find deferred error! count: %u\n=
",
-                       (need_query_count - total_detect_count));
-               return -ENOENT;
-       }
-
        if (total_detect_count)
                schedule_delayed_work(&ras->page_retirement_dwork, 0);

--
2.34.1

