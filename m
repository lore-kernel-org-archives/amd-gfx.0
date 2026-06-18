Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82798CD98F2
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 21:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC9B410F3F7;
	Thu, 18 Jun 2026 21:03:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WT8WUBnU";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011052.outbound.protection.outlook.com [40.107.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E502F10F3F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 21:03:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNrpbxLXf6jUgL+uddZXP3UcbzjoT9YEb3pEtoKTxuwEodIAIZbMlkdUrnk7evznZ3PtECDKKao/nLQaUKROzDs8IDH0adsoa8EqqzYu9wd6g4CJyw+fwQ/sj7b9Iw3AOEq0g7BYnEhjj0dvOLDL4rH6ftEzeHOtc1zr1CYl5pUhjFDKo/OlOexj6NX6BM926pFl1E64kaSE4bg2Cclw8Ed4JhvR8IkgZwXDtWSlHOCvmj+ejhP2dOQHpWEna4wtwcuh1IhNRqU1ncjuI0KP+kwf8eOTNpVqHGUS8I2rgRSJkQ8d1RzQf7WddXWDqURwtbhB+UBCLnhjOTVchHXfNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FW4k3V0w9m+iK4NAdbL8GMRDh/lTC5Q194e9s3zIueM=;
 b=ew3YhWRMjupqL34+M2Dd+K4kWlJrNA09iMhO5Mj8GR6h40Ou5q8i2LpeL778cW/StH8GmBNrfohqxbNQstA+WZWYUFbHkis5mmMSzAU+LB0Cz+QhK63y6gEOjuisq3s8axmhXSBQD0hF/qEj6tK/PxwsD2mGWc5nDZGGQn2h/Vc22gbTPjpH+2xxMsEhE1WWuck6bh6YR2B/98j0eROJihjmje8+Uoo/grFxA3KQMHrAzw0PJz3PRnTUpBy4diW7ONAVWzXc7ob6NKbR5s5cM0tTXScloFahWfhH+VIcF5/Ljda2mEJ5s5QKAlGWh8q051bOwyZiHoizyT/8vsCNkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FW4k3V0w9m+iK4NAdbL8GMRDh/lTC5Q194e9s3zIueM=;
 b=WT8WUBnUCaohMw5swCyHYQKEgK8Go+P476v+wjmHygyTNRP7ujcTBhD+tfNpTTneGlhkZ9Gnv9NELDPR//Tid4R+RUljW/iiw5sCCQY9GuDqWHv5luKv0+c0BJONGYIrLx0HKTY0hPPdgRGcWleT/ESxQ8JFIyfbKslOqVRRUrg=
Received: from IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7)
 by DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 21:03:16 +0000
Received: from IA1PR12MB8190.namprd12.prod.outlook.com
 ([fe80::c581:f5cc:c58f:c5de]) by IA1PR12MB8190.namprd12.prod.outlook.com
 ([fe80::c581:f5cc:c58f:c5de%4]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 21:03:15 +0000
From: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: amd-gfx Digest, Vol 121, Issue 338
Thread-Topic: amd-gfx Digest, Vol 121, Issue 338
Thread-Index: AQHc/SKuY6dgn9A2Uk6NStVUaOWuILZE0VYc
Date: Thu, 18 Jun 2026 21:03:15 +0000
Message-ID: <IA1PR12MB8190C3F5E4F6AC264F84E97481E32@IA1PR12MB8190.namprd12.prod.outlook.com>
References: <mailman.14403.1781567822.6458.amd-gfx@lists.freedesktop.org>
In-Reply-To: <mailman.14403.1781567822.6458.amd-gfx@lists.freedesktop.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-18T21:03:14.950Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB8190:EE_|DS0PR12MB8197:EE_
x-ms-office365-filtering-correlation-id: 6b3ae1c2-936e-47c4-6d7a-08decd7d043f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|4022899009|376014|366016|6049299003|56012099006|11063799006|6133799003|22082099003|18002099003|8096899003|38070700021|4013099003|13003099007|4053099003;
x-microsoft-antispam-message-info: t7WbHiYk6lL7OETJe7R2jNHtXM8oUdLVHJO13ryKNunV/BWSEP65LKbMiOtRBIWcZKC5rkjzZE0BOuN5T6vyiyJJW0JkrOClugJihYUSZlo4FDS5kJftaUMKcPqjNXzemPYFRkfY3/gx9YlKvC9DVMnPrXe1Oi5tgvfYkSW4yi8HCQk72GqTQkuXAjAxO15YLL/0VqaMzmdzwhE8UuAdR3Pce155FpVWrdobRhNtGdbebC064R3/KpzfyJYN+0qe4nryEKV+/vF50gXWyPRs57r1U8LAI0JIF0JirMdBXXCQ2cJWYZa6rl+tJn1tR3E0H0/nd//I5cohwMmIPfWHiBOiGuSCTNlHTq2lFEvKf4t23DBd7tCSx6C5oeGcdO5VIaUH9/iwhZj4GnkiiprHZ4u6hSjvkV0FcUFzb1pqaPjgnsWapvxPpKdG/XgPThvzuGgk3lUgsRNMsXtm7Qy7UXlU8I4GHZAnQXGMWqmISpTF7QLmmVXMtg3M/D7HGV7W55PQUOGsukhQm7kNmj+SR9yzdeX22BzQxkgEaPAJE/lWnr40KZwHom7BPYlPdrTPVRfZG5IAmfsgecU9cApuCkOXEkSPKED/J6CjvVGqk6YjtxFX2BOlxYMqL8EBNNRCWT+68cQqOKdXjUW92gq/wdnPs6QUFtrvzaqdFOoIpgpiLkbtyVeqmIwf8vvzRBS0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8190.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(4022899009)(376014)(366016)(6049299003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(8096899003)(38070700021)(4013099003)(13003099007)(4053099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?k9x6dku7dVxV2bsd0WTKrWmq/ZmyOpeHFZTA4JEzzZ9rOPnQPl1U89es10?=
 =?iso-8859-1?Q?/egR+hBZ7Ep8j/RgB15wTdAhiPnYsAZchNBAT0B6sIWOy026U6/OX9HhDE?=
 =?iso-8859-1?Q?IjLi1HoVnRX4KhTXFvI40K0jSmUp+E06qDd2rRi5H0gtx2ZUDJ9XjWAZWR?=
 =?iso-8859-1?Q?9wXtkljVv2PX28SFKX9gDPhYUS+LnQol/GOVo/DgAi+qIel79FV2QI3Nzx?=
 =?iso-8859-1?Q?amC6DMca1ZPvNMrPIxebnR8FMR2rQHpH5OYBEKr9v93q5wCuEY8SsGBKos?=
 =?iso-8859-1?Q?j9Gy3ZiB+0BYjahfbnQgnOZGldFdJYfRmaAa2NsZKkfHCAxz/Vi0yJu3RA?=
 =?iso-8859-1?Q?lYZWtwKqbz1BcQpbcvSOxCG5g+z+cIjFxI1gV7tR0VvyHghdTgpUv9FgyX?=
 =?iso-8859-1?Q?227M0hhQA4vesoASwxf9psNZ5JzH9Pr549G7NFuUB/+YUjhfSnuqaMD34i?=
 =?iso-8859-1?Q?W41MmP4MT5uWEB0BkBVnPYobBVqG9HiYT6EDFnN3/RKRlGYqmnGH5Z0c44?=
 =?iso-8859-1?Q?0AaUwkzdly2AF2/Z+/Ae4cC4LZB07DchTQCN4PcVKdLiPcuiHWlZGRcxQv?=
 =?iso-8859-1?Q?Z+I4aKwuDzwPDlzo2m84npRDsM7sP3VxemsUsITG0YgFW2Jrb0bvxrPK7C?=
 =?iso-8859-1?Q?62M0swbUsfGJiN09mf7z66ikmSwTPtKEaokGGI9eeur/SvDS6C2ANzmNaT?=
 =?iso-8859-1?Q?uXtO2u79ycnkMH4DjFnzWQetZ2D7k9vktuiqU/eXIEci8+g8myHOBp3u8X?=
 =?iso-8859-1?Q?W3fT3VfYVoZ5lLYOqu5x2IbS3sKaw5+UubtIrW6vYzdwLOca+RN7cpdamX?=
 =?iso-8859-1?Q?cHS2UoqGfzeBTynPsqw+esQ2rc3+gbAhisUIqgYTyxQB9bmx+BJAhpCdCG?=
 =?iso-8859-1?Q?464HZM3VFrn606rM8uhn/uRCpAjHSwUzS0x+6ltJIABSzoyObKhORo+AQI?=
 =?iso-8859-1?Q?ogYvLsVBj9n4aps6dxOmESWk7M9FBv1KrvDz8FhgjGpBJtoLd3PprtnAQ5?=
 =?iso-8859-1?Q?4s6L2kkPYWoReEYIlcJpAveadlpUsFmE7zw0LRNSHGVOzZbGKHf78LHSCP?=
 =?iso-8859-1?Q?vegBx5chpJ9giRUyOiwSJlB+Xhjfemk1brL4dFDIjs+gMYvjd3FQ1Hkxeq?=
 =?iso-8859-1?Q?W+Dz0O25+869FvjnWYMtG0yDyDlzZ6pB1Kpyd3cIP3QhCXIl70oAMyz7u8?=
 =?iso-8859-1?Q?71B3ANGKx/GsZFjVj5eJMBal5U42ByBvq93VXko3/WF2f4F2t27pbsSUGj?=
 =?iso-8859-1?Q?b0M55yVRMSIU8xyhRE0vK1xc+wk2al9avKjojr9Slm0fDhyHJu0+2opr1C?=
 =?iso-8859-1?Q?DF+sjZvIUge4PcNcDGSApQObA/Nsk9/KRCBzo38Lq9LcmFdn8R5scNrk2N?=
 =?iso-8859-1?Q?Y4h2sYLqFukl2/H0OpVFjbUuqgF9kvOqIVr61N5HwcgcfcIu45/YNXotQo?=
 =?iso-8859-1?Q?4tSAU/pPu7yXQ3x7sMTrmhiuk08AgecEJVbnvtK+BDp5RGrEHcISbXws0p?=
 =?iso-8859-1?Q?2trvrH683HfUybb83QqYUGtXu4KBSg+dxAYFl9dmVU2mUjQLaeUOo7sAO3?=
 =?iso-8859-1?Q?exRE/oYhmZkPiqWu8ntRk0sf3iYKHxvKfZWqYkTlRV+4B2Z55qxSmeRb84?=
 =?iso-8859-1?Q?LNZrLv3nXxGVbMjYFok0WI3NtfbWzdbjhoCMn5GjioN0MvKUZlkzYwoeUR?=
 =?iso-8859-1?Q?Sg/Urtv32yKxsum9XD0MmdSZdVE3b3oF4Vvkx+ggrh5EK/AuhQv46T2D6p?=
 =?iso-8859-1?Q?wLodsOKCzsHxgTBUZ703m998gT9Xbt+m+U71skgu76aAu5?=
Content-Type: multipart/related;
 boundary="_004_IA1PR12MB8190C3F5E4F6AC264F84E97481E32IA1PR12MB8190namp_";
 type="multipart/alternative"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8190.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3ae1c2-936e-47c4-6d7a-08decd7d043f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 21:03:15.8680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YD0RCvW0s/X5iy2E9STeVqxUrQZN118AM+A84d7mHFiu6xEzrkaN1p32V9FdUMizZtLG0ROygneVWIBcG8yuuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197
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

--_004_IA1PR12MB8190C3F5E4F6AC264F84E97481E32IA1PR12MB8190namp_
Content-Type: multipart/alternative;
	boundary="_000_IA1PR12MB8190C3F5E4F6AC264F84E97481E32IA1PR12MB8190namp_"

--_000_IA1PR12MB8190C3F5E4F6AC264F84E97481E32IA1PR12MB8190namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

AMD General



[cid:2c6f3620-b025-462f-af2f-0047ca6305af]<https://outlook.office.com/bookw=
ithme/user/5be71e58d07c492d97048217b901df8e@amd.com?anonymous&ep=3DowaSlots=
EmailSignature>

The entire series of patches (replace BUG_ON() with
      WARN_ON()  looks good to me.
Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of amd-gfx-=
request@lists.freedesktop.org <amd-gfx-request@lists.freedesktop.org>
Sent: Monday, June 15, 2026 7:57 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: amd-gfx Digest, Vol 121, Issue 338

Send amd-gfx mailing list submissions to
        amd-gfx@lists.freedesktop.org

To subscribe or unsubscribe via the World Wide Web, visit
        https://lists.freedesktop.org/mailman/listinfo/amd-gfx
or, via email, send a message with subject or body 'help' to
        amd-gfx-request@lists.freedesktop.org

You can reach the person managing the list at
        amd-gfx-owner@lists.freedesktop.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of amd-gfx digest..."


Today's Topics:

   1. [PATCH 01/43] drm/amdgpu/gfx8: replace BUG_ON() with
      WARN_ON() (Alex Deucher)
   2. [PATCH 04/43] drm/amdgpu/gfx10: replace BUG_ON() with
      WARN_ON() (Alex Deucher)
   3. [PATCH 06/43] drm/amdgpu/gfx12: replace BUG_ON() with
      WARN_ON() (Alex Deucher)
   4. [PATCH 10/43] drm/amdgpu/sdma5.2: replace BUG_ON() with
      WARN_ON() (Alex Deucher)


----------------------------------------------------------------------

Message: 1
Date: Mon, 15 Jun 2026 19:56:03 -0400
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/43] drm/amdgpu/gfx8: replace BUG_ON() with
        WARN_ON()
Message-ID: <20260615235645.737189-1-alexander.deucher@amd.com>
Content-Type: text/plain

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c
index 130196859ff3f..70ba81e6b4d43 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6256,9 +6256,6 @@ static void gfx_v8_0_ring_emit_fence_compute(struct a=
mdgpu_ring *ring,
 static void gfx_v8_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 add=
r,
                                          u64 seq, unsigned int flags)
 {
-       /* we only allocate 32bit for each seq wb address */
-       BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
-
         /* write fence seq to the "addr" */
         amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
         amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
--
2.54.0



------------------------------

Message: 2
Date: Mon, 15 Jun 2026 19:56:06 -0400
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/43] drm/amdgpu/gfx10: replace BUG_ON() with
        WARN_ON()
Message-ID: <20260615235645.737189-4-alexander.deucher@amd.com>
Content-Type: text/plain

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index e99d17cd43e57..544d6aafb11a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4022,7 +4022,7 @@ static void gfx_v10_0_wait_reg_mem(struct amdgpu_ring=
 *ring, int eng_sel,
                            WAIT_REG_MEM_ENGINE(eng_sel)));

         if (mem_space)
-               BUG_ON(addr0 & 0x3); /* Dword align */
+               WARN_ON(addr0 & 0x3); /* Dword align */
         amdgpu_ring_write(ring, addr0);
         amdgpu_ring_write(ring, addr1);
         amdgpu_ring_write(ring, ref);
@@ -8661,7 +8661,7 @@ static void gfx_v10_0_ring_emit_ib_gfx(struct amdgpu_=
ring *ring,
         }

         amdgpu_ring_write(ring, header);
-       BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+       WARN_ON(ib->gpu_addr & 0x3); /* Dword align */
         amdgpu_ring_write(ring,
 #ifdef __BIG_ENDIAN
                 (2 << 0) |
@@ -8696,7 +8696,7 @@ static void gfx_v10_0_ring_emit_ib_compute(struct amd=
gpu_ring *ring,
         }

         amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
-       BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+       WARN_ON(ib->gpu_addr & 0x3); /* Dword align */
         amdgpu_ring_write(ring,
 #ifdef __BIG_ENDIAN
                                 (2 << 0) |
@@ -8729,9 +8729,9 @@ static void gfx_v10_0_ring_emit_fence(struct amdgpu_r=
ing *ring, u64 addr,
          * aligned if only send 32bit data low (discard data high)
          */
         if (write64bit)
-               BUG_ON(addr & 0x7);
+               WARN_ON(addr & 0x7);
         else
-               BUG_ON(addr & 0x3);
+               WARN_ON(addr & 0x3);
         amdgpu_ring_write(ring, lower_32_bits(addr));
         amdgpu_ring_write(ring, upper_32_bits(addr));
         amdgpu_ring_write(ring, lower_32_bits(seq));
@@ -8779,9 +8779,6 @@ static void gfx_v10_0_ring_emit_fence_kiq(struct amdg=
pu_ring *ring, u64 addr,
 {
         struct amdgpu_device *adev =3D ring->adev;

-       /* we only allocate 32bit for each seq wb address */
-       BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
-
         /* write fence seq to the "addr" */
         amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
         amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
--
2.54.0



------------------------------

Message: 3
Date: Mon, 15 Jun 2026 19:56:08 -0400
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/43] drm/amdgpu/gfx12: replace BUG_ON() with
        WARN_ON()
Message-ID: <20260615235645.737189-6-alexander.deucher@amd.com>
Content-Type: text/plain

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c
index 09f2ccfbf6804..a5ae91af9ef0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -440,7 +440,7 @@ static void gfx_v12_0_wait_reg_mem(struct amdgpu_ring *=
ring, int eng_sel,
                            WAIT_REG_MEM_ENGINE(eng_sel)));

         if (mem_space)
-               BUG_ON(addr0 & 0x3); /* Dword align */
+               WARN_ON(addr0 & 0x3); /* Dword align */
         amdgpu_ring_write(ring, addr0);
         amdgpu_ring_write(ring, addr1);
         amdgpu_ring_write(ring, ref);
@@ -4509,7 +4509,7 @@ static void gfx_v12_0_ring_emit_ib_gfx(struct amdgpu_=
ring *ring,
         control |=3D ib->length_dw | (vmid << 24);

         amdgpu_ring_write(ring, header);
-       BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+       WARN_ON(ib->gpu_addr & 0x3); /* Dword align */
         amdgpu_ring_write(ring,
 #ifdef __BIG_ENDIAN
                 (2 << 0) |
@@ -4528,7 +4528,7 @@ static void gfx_v12_0_ring_emit_ib_compute(struct amd=
gpu_ring *ring,
         u32 control =3D INDIRECT_BUFFER_VALID | ib->length_dw | (vmid << 2=
4);

         amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
-       BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+       WARN_ON(ib->gpu_addr & 0x3); /* Dword align */
         amdgpu_ring_write(ring,
 #ifdef __BIG_ENDIAN
                                 (2 << 0) |
@@ -4559,9 +4559,9 @@ static void gfx_v12_0_ring_emit_fence(struct amdgpu_r=
ing *ring, u64 addr,
          * aligned if only send 32bit data low (discard data high)
          */
         if (write64bit)
-               BUG_ON(addr & 0x7);
+               WARN_ON(addr & 0x7);
         else
-               BUG_ON(addr & 0x3);
+               WARN_ON(addr & 0x3);
         amdgpu_ring_write(ring, lower_32_bits(addr));
         amdgpu_ring_write(ring, upper_32_bits(addr));
         amdgpu_ring_write(ring, lower_32_bits(seq));
@@ -4609,9 +4609,6 @@ static void gfx_v12_0_ring_emit_fence_kiq(struct amdg=
pu_ring *ring, u64 addr,
 {
         struct amdgpu_device *adev =3D ring->adev;

-       /* we only allocate 32bit for each seq wb address */
-       BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
-
         /* write fence seq to the "addr" */
         amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
         amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
--
2.54.0



------------------------------

Message: 4
Date: Mon, 15 Jun 2026 19:56:12 -0400
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/43] drm/amdgpu/sdma5.2: replace BUG_ON() with
        WARN_ON()
Message-ID: <20260615235645.737189-10-alexander.deucher@amd.com>
Content-Type: text/plain

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c
index 520a7ac94dfd3..d379c58ac8227 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -377,7 +377,7 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_rin=
g *ring, u64 addr, u64 se
         amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_FENCE) |
                           SDMA_PKT_FENCE_HEADER_MTYPE(0x3)); /* Ucached(UC=
) */
         /* zero in first two bits */
-       BUG_ON(addr & 0x3);
+       WARN_ON(addr & 0x3);
         amdgpu_ring_write(ring, lower_32_bits(addr));
         amdgpu_ring_write(ring, upper_32_bits(addr));
         amdgpu_ring_write(ring, lower_32_bits(seq));
@@ -388,7 +388,7 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_rin=
g *ring, u64 addr, u64 se
                 amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_FENCE) =
|
                                   SDMA_PKT_FENCE_HEADER_MTYPE(0x3));
                 /* zero in first two bits */
-               BUG_ON(addr & 0x3);
+               WARN_ON(addr & 0x3);
                 amdgpu_ring_write(ring, lower_32_bits(addr));
                 amdgpu_ring_write(ring, upper_32_bits(addr));
                 amdgpu_ring_write(ring, upper_32_bits(seq));
--
2.54.0



------------------------------

Subject: Digest Footer

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx


------------------------------

End of amd-gfx Digest, Vol 121, Issue 338
*****************************************

--_000_IA1PR12MB8190C3F5E4F6AC264F84E97481E32IA1PR12MB8190namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature" class=3D"elementToProof">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<table id=3D"pbpsiglinktable">
<tbody>
<tr>
<td>
<div class=3D"elementToProof"><a href=3D"https://outlook.office.com/bookwit=
hme/user/5be71e58d07c492d97048217b901df8e@amd.com?anonymous&amp;ep=3DowaSlo=
tsEmailSignature" id=3D"OWAaacfe420-9e38-5c4d-528c-5b0ae50037bf" class=3D"O=
WAAutoLink"><img id=3D"image_0" data-outlook-trace=3D"F:1|T:1" src=3D"cid:2=
c6f3620-b025-462f-af2f-0047ca6305af"></a></div>
</td>
<td></td>
<td>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
</td>
<td></td>
</tr>
</tbody>
</table>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
The entire series of patches (replace BUG_ON() with</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON()&nbsp; looks good to me.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Vitaly Prosyak &lt;vitaly.prosyak@amd.com&gt;</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; on =
behalf of amd-gfx-request@lists.freedesktop.org &lt;amd-gfx-request@lists.f=
reedesktop.org&gt;<br>
<b>Sent:</b>&nbsp;Monday, June 15, 2026 7:57 PM<br>
<b>To:</b>&nbsp;amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;<br>
<b>Subject:</b>&nbsp;amd-gfx Digest, Vol 121, Issue 338</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">Send amd-gfx mailing list submissions to<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx@lists.freedesktop.org<br=
>
<br>
To subscribe or unsubscribe via the World Wide Web, visit<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://lists.freedes=
ktop.org/mailman/listinfo/amd-gfx" id=3D"OWA57a47a8f-db22-7952-78b8-648b291=
10026" class=3D"OWAAutoLink" data-auth=3D"NotApplicable">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
or, via email, send a message with subject or body 'help' to<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx-request@lists.freedeskto=
p.org<br>
<br>
You can reach the person managing the list at<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx-owner@lists.freedesktop.=
org<br>
<br>
When replying, please edit your Subject line so it is more specific<br>
than &quot;Re: Contents of amd-gfx digest...&quot;<br>
<br>
<br>
Today's Topics:<br>
<br>
&nbsp;&nbsp; 1. [PATCH 01/43] drm/amdgpu/gfx8: replace BUG_ON() with<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON() (Alex Deucher)<br>
&nbsp;&nbsp; 2. [PATCH 04/43] drm/amdgpu/gfx10: replace BUG_ON() with<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON() (Alex Deucher)<br>
&nbsp;&nbsp; 3. [PATCH 06/43] drm/amdgpu/gfx12: replace BUG_ON() with<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON() (Alex Deucher)<br>
&nbsp;&nbsp; 4. [PATCH 10/43] drm/amdgpu/sdma5.2: replace BUG_ON() with<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON() (Alex Deucher)<br>
<br>
<br>
----------------------------------------------------------------------<br>
<br>
Message: 1<br>
Date: Mon, 15 Jun 2026 19:56:03 -0400<br>
From: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
To: &lt;amd-gfx@lists.freedesktop.org&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Subject: [PATCH 01/43] drm/amdgpu/gfx8: replace BUG_ON() with<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON()<br>
Message-ID: &lt;20260615235645.737189-1-alexander.deucher@amd.com&gt;<br>
Content-Type: text/plain<br>
<br>
There's no need to crash the kernel for these cases.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 3 ---<br>
&nbsp;1 file changed, 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c<br>
index 130196859ff3f..70ba81e6b4d43 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
@@ -6256,9 +6256,6 @@ static void gfx_v8_0_ring_emit_fence_compute(struct a=
mdgpu_ring *ring,<br>
&nbsp;static void gfx_v8_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u6=
4 addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; u64 seq, unsigned int flags)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* we only allocate 32bit for each se=
q wb address */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(flags &amp; AMDGPU_FENCE_FLAG_=
64BIT);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* write fence seq to the =
&quot;addr&quot; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PA=
CKET3(PACKET3_WRITE_DATA, 3));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, (W=
RITE_DATA_ENGINE_SEL(0) |<br>
--<br>
2.54.0<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 2<br>
Date: Mon, 15 Jun 2026 19:56:06 -0400<br>
From: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
To: &lt;amd-gfx@lists.freedesktop.org&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Subject: [PATCH 04/43] drm/amdgpu/gfx10: replace BUG_ON() with<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON()<br>
Message-ID: &lt;20260615235645.737189-4-alexander.deucher@amd.com&gt;<br>
Content-Type: text/plain<br>
<br>
There's no need to crash the kernel for these cases.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 13 +++++--------<br>
&nbsp;1 file changed, 5 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index e99d17cd43e57..544d6aafb11a5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -4022,7 +4022,7 @@ static void gfx_v10_0_wait_reg_mem(struct amdgpu_ring=
 *ring, int eng_sel,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; WAIT_REG_MEM_ENGINE(eng_sel)));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mem_space)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; BUG_ON(addr0 &amp; 0x3); /* Dword align */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WARN_ON(addr0 &amp; 0x3); /* Dword align */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, ad=
dr0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, ad=
dr1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, re=
f);<br>
@@ -8661,7 +8661,7 @@ static void gfx_v10_0_ring_emit_ib_gfx(struct amdgpu_=
ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, he=
ader);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(ib-&gt;gpu_addr &amp; 0x3); /*=
 Dword align */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(ib-&gt;gpu_addr &amp; 0x3); /=
* Dword align */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring,<br=
>
&nbsp;#ifdef __BIG_ENDIAN<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (2 &lt;&lt; 0) |<br>
@@ -8696,7 +8696,7 @@ static void gfx_v10_0_ring_emit_ib_compute(struct amd=
gpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PA=
CKET3(PACKET3_INDIRECT_BUFFER, 2));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(ib-&gt;gpu_addr &amp; 0x3); /*=
 Dword align */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(ib-&gt;gpu_addr &amp; 0x3); /=
* Dword align */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring,<br=
>
&nbsp;#ifdef __BIG_ENDIAN<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (2 &lt;&lt; 0) |<br>
@@ -8729,9 +8729,9 @@ static void gfx_v10_0_ring_emit_fence(struct amdgpu_r=
ing *ring, u64 addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * aligned if only se=
nd 32bit data low (discard data high)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (write64bit)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; BUG_ON(addr &amp; 0x7);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WARN_ON(addr &amp; 0x7);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; BUG_ON(addr &amp; 0x3);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WARN_ON(addr &amp; 0x3);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, lo=
wer_32_bits(addr));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, up=
per_32_bits(addr));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, lo=
wer_32_bits(seq));<br>
@@ -8779,9 +8779,6 @@ static void gfx_v10_0_ring_emit_fence_kiq(struct amdg=
pu_ring *ring, u64 addr,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ring-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* we only allocate 32bit for each se=
q wb address */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(flags &amp; AMDGPU_FENCE_FLAG_=
64BIT);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* write fence seq to the =
&quot;addr&quot; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PA=
CKET3(PACKET3_WRITE_DATA, 3));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, (W=
RITE_DATA_ENGINE_SEL(0) |<br>
--<br>
2.54.0<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 3<br>
Date: Mon, 15 Jun 2026 19:56:08 -0400<br>
From: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
To: &lt;amd-gfx@lists.freedesktop.org&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Subject: [PATCH 06/43] drm/amdgpu/gfx12: replace BUG_ON() with<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON()<br>
Message-ID: &lt;20260615235645.737189-6-alexander.deucher@amd.com&gt;<br>
Content-Type: text/plain<br>
<br>
There's no need to crash the kernel for these cases.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 13 +++++--------<br>
&nbsp;1 file changed, 5 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c<br>
index 09f2ccfbf6804..a5ae91af9ef0f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
@@ -440,7 +440,7 @@ static void gfx_v12_0_wait_reg_mem(struct amdgpu_ring *=
ring, int eng_sel,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; WAIT_REG_MEM_ENGINE(eng_sel)));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mem_space)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; BUG_ON(addr0 &amp; 0x3); /* Dword align */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WARN_ON(addr0 &amp; 0x3); /* Dword align */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, ad=
dr0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, ad=
dr1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, re=
f);<br>
@@ -4509,7 +4509,7 @@ static void gfx_v12_0_ring_emit_ib_gfx(struct amdgpu_=
ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control |=3D ib-&gt;length=
_dw | (vmid &lt;&lt; 24);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, he=
ader);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(ib-&gt;gpu_addr &amp; 0x3); /*=
 Dword align */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(ib-&gt;gpu_addr &amp; 0x3); /=
* Dword align */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring,<br=
>
&nbsp;#ifdef __BIG_ENDIAN<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (2 &lt;&lt; 0) |<br>
@@ -4528,7 +4528,7 @@ static void gfx_v12_0_ring_emit_ib_compute(struct amd=
gpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 control =3D INDIRECT_B=
UFFER_VALID | ib-&gt;length_dw | (vmid &lt;&lt; 24);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PA=
CKET3(PACKET3_INDIRECT_BUFFER, 2));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(ib-&gt;gpu_addr &amp; 0x3); /*=
 Dword align */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(ib-&gt;gpu_addr &amp; 0x3); /=
* Dword align */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring,<br=
>
&nbsp;#ifdef __BIG_ENDIAN<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (2 &lt;&lt; 0) |<br>
@@ -4559,9 +4559,9 @@ static void gfx_v12_0_ring_emit_fence(struct amdgpu_r=
ing *ring, u64 addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * aligned if only se=
nd 32bit data low (discard data high)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (write64bit)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; BUG_ON(addr &amp; 0x7);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WARN_ON(addr &amp; 0x7);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; BUG_ON(addr &amp; 0x3);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WARN_ON(addr &amp; 0x3);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, lo=
wer_32_bits(addr));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, up=
per_32_bits(addr));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, lo=
wer_32_bits(seq));<br>
@@ -4609,9 +4609,6 @@ static void gfx_v12_0_ring_emit_fence_kiq(struct amdg=
pu_ring *ring, u64 addr,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ring-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* we only allocate 32bit for each se=
q wb address */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(flags &amp; AMDGPU_FENCE_FLAG_=
64BIT);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* write fence seq to the =
&quot;addr&quot; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PA=
CKET3(PACKET3_WRITE_DATA, 3));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, (W=
RITE_DATA_ENGINE_SEL(0) |<br>
--<br>
2.54.0<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 4<br>
Date: Mon, 15 Jun 2026 19:56:12 -0400<br>
From: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
To: &lt;amd-gfx@lists.freedesktop.org&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Subject: [PATCH 10/43] drm/amdgpu/sdma5.2: replace BUG_ON() with<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON()<br>
Message-ID: &lt;20260615235645.737189-10-alexander.deucher@amd.com&gt;<br>
Content-Type: text/plain<br>
<br>
There's no need to crash the kernel for these cases.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++--<br>
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c<br>
index 520a7ac94dfd3..d379c58ac8227 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c<br>
@@ -377,7 +377,7 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_rin=
g *ring, u64 addr, u64 se<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, SD=
MA_PKT_HEADER_OP(SDMA_OP_FENCE) |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; SDMA_PKT_FENCE_HEADER_MTYPE(0x3)); /* Ucached(UC) */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* zero in first two bits =
*/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(addr &amp; 0x3);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(addr &amp; 0x3);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, lo=
wer_32_bits(addr));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, up=
per_32_bits(addr));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, lo=
wer_32_bits(seq));<br>
@@ -388,7 +388,7 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_rin=
g *ring, u64 addr, u64 se<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_FE=
NCE) |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDMA_PKT_FENCE_HEADE=
R_MTYPE(0x3));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* zero in first two bits */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; BUG_ON(addr &amp; 0x3);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WARN_ON(addr &amp; 0x3);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, lower_32_bits(addr));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, upper_32_bits(addr));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, upper_32_bits(seq));<br>
--<br>
2.54.0<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Subject: Digest Footer<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"OW=
A4d7e9ff9-08e7-5296-e1e3-e8b575d3e4fb" class=3D"OWAAutoLink" data-auth=3D"N=
otApplicable">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br=
>
<br>
<br>
------------------------------<br>
<br>
End of amd-gfx Digest, Vol 121, Issue 338<br>
*****************************************</div>
</body>
</html>

--_000_IA1PR12MB8190C3F5E4F6AC264F84E97481E32IA1PR12MB8190namp_--

--_004_IA1PR12MB8190C3F5E4F6AC264F84E97481E32IA1PR12MB8190namp_
Content-Type: image/png; name="Outlook-hjpgb34h.png"
Content-Description: Outlook-hjpgb34h.png
Content-Disposition: inline; filename="Outlook-hjpgb34h.png"; size=528;
	creation-date="Thu, 18 Jun 2026 21:03:15 GMT";
	modification-date="Thu, 18 Jun 2026 21:03:15 GMT"
Content-ID: <2c6f3620-b025-462f-af2f-0047ca6305af>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAAAXNSR0IArs4c6QAAAcpJREFUOE9j
ZAABr6aJDHqhuQwMDIxgPrHg19d3DLP91Bk+P3sD08IIN2x1hjPDy7NXiDWL4T8nM0NA33wGWRMP
hg5NJgYGhv8gvYwMFdf/MYAMu3twP9GGISssv/qLYVdzMsP5FYthBv5nmO2pyfDzzVuyDEw/eJ3h
xNyJDEenNSMMJMskJE2Hp9YxHJ2CZOBUM1GGz5/hAUuS+UVnXjOcXDCJygbOm4TqZUpcGDJjJcPz
S1eoYyAvrzDD58/vGRgY/iHSYcX1/wykupBXWpghe89reEbY0RjNcGHFMkQsk2pgwYkXDBz84iiR
16EJzmWghE26C8uv/mZgZGJBM5AZ5HXyDPRo7GMwCCuEG/jj40uGCRYS5LsQpNM6q4TBOLqE4emF
gwxrs8NRI2WynSTD19cvSErQOBQzMhSdecvw8vophqWxngQNBCWTrBMvMMIPpnF7dQQjA6+UCEP2
3tcM//7+Zvjx8QNOQydZizFk7bvNwCepgs9iWIHKyGAYEcPALaQEUQwq3mBplQmi5siUBoa0bRcZ
hBT18Bj4n7QSWlhGmiF19xOcBh6aVEyagSCTQEEUNf8Ag6CcFjyn/Pz8hmF9cQjDg8MHAaiKxp0e
iZJ4AAAAAElFTkSuQmCC

--_004_IA1PR12MB8190C3F5E4F6AC264F84E97481E32IA1PR12MB8190namp_--
