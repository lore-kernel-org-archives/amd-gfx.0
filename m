Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC7ACFA466
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Nov 2025 14:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01BFE10E2D1;
	Mon, 24 Nov 2025 14:55:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0D0MbCFO";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012038.outbound.protection.outlook.com
 [40.93.195.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 397D810E2D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Nov 2025 14:55:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ablPJ0efXEdsBodqrrGwk76ZKO21Mq7hm/3kaekLx+8vpyLnVsHfp7oj0OMRsEoMV0dh+0x7JpBIdEokqlkvuu0k47oO6zlMe31BYa03mYyTiyxrnHYBTvvEJaCbRf9M5ez7zH0pG7dHGvO41fNu35lJCBdGhDKqBkL1vZqpWCwjhydHKQBOUH86cVF2r57H3Pa15/rm1vXxaOqy6Vb8eFZQS8bS8GlXO5Kn1pCI3RCxOp0vnzVfgZvCZoecFpqTH402w8V1t29HxcgTTsAuRLkgdyamRXhc4n7jc2AdRsxDpwLLz9VWMZTFqYTzxAL+2CDFv4fU98r3WnBur/56fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7k8KVGBH1PrtQejlLtpKWSSnLldoZlptjDFmj3nbMCc=;
 b=RM+PMW9RYEbHubxSIFnkL/OO/y3ZVpqx26RI43B/8C+UzVIcUcAESk/dLXlnCUh+rnOZIkAEPTsKqpDayuLw65hjtz5KaLdFaoYGVCp50FF0cFfTnSLZInJf1csQxmEBAiEIaOlKi3tcZ0EDZgcn+bKuKLoWmE96lFvpaP9HUxGm8LqR2+ilt9GZQEEX+CwhJQ5n2uv7yiqUa9Z4rVcNGtr8kg537ura73EfAcGT/+zVcUHNnagWUsK60Y30v2z9Fh47zYNN38zz5GoJYDI6LrDh9BmuH1UxrCPXrMv4OfavI+w9BJiFfLpnTjwR1/ku9SAqSFhlBxB8LuariGZ55w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7k8KVGBH1PrtQejlLtpKWSSnLldoZlptjDFmj3nbMCc=;
 b=0D0MbCFOFAk+soKsWN/2xTZYD0MJSaEUbSIQ3DI7VW6ExPtJVe1JjaDJXSI/CjA6RIYHlRmcfUAnLVa69zPRPAcSB1I/k4pdNX6tr25Tlh6TjOHhMfLWVdZAEapcjXCP2iBT3M7cH1FsE/234TEqHesKSbI03CvF010n2ex4lZk=
Received: from PH7PR12MB6561.namprd12.prod.outlook.com (2603:10b6:510:213::12)
 by CY8PR12MB7313.namprd12.prod.outlook.com (2603:10b6:930:53::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 14:55:44 +0000
Received: from PH7PR12MB6561.namprd12.prod.outlook.com
 ([fe80::78f3:7e6b:4d7c:5b3b]) by PH7PR12MB6561.namprd12.prod.outlook.com
 ([fe80::78f3:7e6b:4d7c:5b3b%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 14:55:44 +0000
From: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v4] drm/amdkfd: Use huge page size to check split svm
 range alignment
Thread-Topic: [PATCH v4] drm/amdkfd: Use huge page size to check split svm
 range alignment
Thread-Index: AQHcWjU9HzE+8MNvnEKBLJUWW3PI9rUB8EoQ
Date: Mon, 24 Nov 2025 14:55:44 +0000
Message-ID: <PH7PR12MB65616F59BBE5CB4A4DCD34A5E3D0A@PH7PR12MB6561.namprd12.prod.outlook.com>
References: <20251120155043.2770609-1-xiaogang.chen@amd.com>
In-Reply-To: <20251120155043.2770609-1-xiaogang.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-24T14:55:19.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6561:EE_|CY8PR12MB7313:EE_
x-ms-office365-filtering-correlation-id: 69d80bf9-f61c-4fbc-d3a5-08de2b698b77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?JoTWKFFyAJ5JrmMlx+/7AzPhWhzWFNoZ+T/XBDYKtVa0qQ1xqvxM0ujGXjxi?=
 =?us-ascii?Q?d7JE68k1Xv2UA+/H0bmJIpwKsYVqm/m9tEqkXJQamA4VH21Qflc5dI0n3Qkt?=
 =?us-ascii?Q?2L5Kxp2QI8IVbmU6JlvEYZMS+zg5G65/d8ToQ4FkFY2xUCiAy2RmWe32oqYG?=
 =?us-ascii?Q?kD2o4ZvhZ8ihjyAciKEr6Wk2wXcQrX6Y9nrtr7cBbC0OyeFRxMBJt43IXnnL?=
 =?us-ascii?Q?tefHYdffE1xViBtRc+KbNbOz4lWMfJQs/HmfVlIURd81aKkTqrQRVKRAOwNg?=
 =?us-ascii?Q?HzMjDWjJgxD9xd0lyPvlIoAOzknCBKYAQTXugByniObRwpShXR9h6lx6iP/v?=
 =?us-ascii?Q?v2VDdBp32YjIqNYZHT2ny+SyZdTdQf60rKXX721djUMXUrba2dckKfV9yF+3?=
 =?us-ascii?Q?hV30tMW/z2Z+OyBofEBdF6tOP5rYm+d+aoXogCFI/QbYNBBHSb5n59CvkmiF?=
 =?us-ascii?Q?TkytO3EyXEelNbKDn1PZH6Z9+bcYn1mv3W0gZBGBpHY78bk65oITmaqhb2kn?=
 =?us-ascii?Q?+lw1rzApbTfwxg4feAb0BNeYcA1pSTaVk91P+YbUhAIYUjCn89RUWRmPEe/d?=
 =?us-ascii?Q?hce7YCJ4EshDljtgIai1yh/Lc3BySR3/dUfFDPwI1vzAxWTHUjsanl/YY4dL?=
 =?us-ascii?Q?eNtwm4s1zhSFxfJ0EX/HA1w4SfaFJojCPIXNmXPw9CKeC2nhultipOIUhz5k?=
 =?us-ascii?Q?Ls8Us5ImhV2DFz94qzuCuIgRIhB0slgHcHXchF/hO7ZRnszGzhDnpdl/4pcc?=
 =?us-ascii?Q?ii0tAjDsAlEqCa5jUAjqkPenee220fnlZkEQwRqE5/xaXWvPBdCyxANSpkHn?=
 =?us-ascii?Q?+Idbqfo3TziK96jqpnAUvTwPtRUkMl+Zs1EHhQufWsYQszdzm+R1eNEiplVL?=
 =?us-ascii?Q?RM+pOeq2oVYH3g2DkBah9Lp0/n7lCOrVd2Y75CwxII8lhx9d2qPKTQdqsT1G?=
 =?us-ascii?Q?mpIuOiR/U3A3fGpmlbnPIASBltkCKskVbzGvJhauCVYlwU5iRLq7Fa77C18j?=
 =?us-ascii?Q?8zXd9QDVVp7G7LNQ3hHEx0lheR+j+WQ2IP8PiZ9PSmwlrqo98uiteqwAj3oo?=
 =?us-ascii?Q?yHvqgci2vC1SVAcIqtWwDgMDicNDPijQIhP5N04rzLvlAqwaMVuB9RXHh7wP?=
 =?us-ascii?Q?jSFWF9O++Be2iQVPoJK8gStmPZeE+R+HW6yjOGybstFNmEbGdvYk0rWMXjA0?=
 =?us-ascii?Q?GyQN5M0w+5waVqwSiS/X8K5Er99Tv7sR58Z5jiR7fWTyyZJm6MK7seEUlVk3?=
 =?us-ascii?Q?hnF4Xv3B5MCOWmR5RaPAiO4mGZc0LqQnSaI3S9SM7fhVNAg4g6W4nuuamh0i?=
 =?us-ascii?Q?qgVmhwq9ekXkHIg7amTFAnBjw5jbwVmNEL+pXEiFCyCfz4Ld6F3Hwjp88xNV?=
 =?us-ascii?Q?q+//MNUTvREs4Z0DCZceNiFLg1lQ1VToM3V6upl2MESzjdr9ToTcx/oMehip?=
 =?us-ascii?Q?nsiWAhoADN2BYrIIfKT03w9e540Y3nqyaxcsZW+CWp+s2i8iCwhvvaH7403z?=
 =?us-ascii?Q?vMEFStPR/Vwu5KRBw5y7766EPznOKxgCA4xx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6561.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NN0PITrpbaLEeTyUEUj+YDtrnEL8lLKeT04T/YFdvyq/MqbwmAFyEYueNbG4?=
 =?us-ascii?Q?Ydvj6vGK7F2BHqokAyoGFr8kPAoaxqWsudOlbJkxpRPcuEgUqULkfpc5SYg+?=
 =?us-ascii?Q?nqPZETpMlBVAEIOg5LYbCwYloDfs6m99+OSFhPiwysEhHgT0d0ZwCi5pYCj8?=
 =?us-ascii?Q?yVDjbWMDm66zZ3hDehejJX/gRPU8wrMM15LExHtxsjbNlVpPnqB/Cw3RZU54?=
 =?us-ascii?Q?UpEHl/8DcjYLbCOcWFM6Cfi5HitSH/8FQtA+dhCKJPzblIkyk8FqVB004wJy?=
 =?us-ascii?Q?2mE20pyipny9WTKYa2Pk5NXp75t3WDSaF4xz1r9goP6NeaX8YuPaujcFsWjP?=
 =?us-ascii?Q?QOHgKe+m1igMORFhEAnnWsanppDv6acLbGBYOWH83ttGmaUPmiFJ2/3/Rrjb?=
 =?us-ascii?Q?X8LsO725Ar0fF8CivrkBfClCBSpvyhMP1ZVSdwx/9ikaY1L5JPVxrbMRw0bp?=
 =?us-ascii?Q?jMGeUWCIDutvtHKxzICN7kLonURZkZNjK81/N9BpXphcvvGoDjEb1DyNsi+T?=
 =?us-ascii?Q?/P8nXEkQB4K8bFt5KlxhqnvEXhpbktF/dN7/6DmXy9hNZLC7Jf5AYnbv+Xyk?=
 =?us-ascii?Q?BmFRO9x1XCQOkrR6VDZQHSk6/4oDM0KbAEs0MFBIfXK3+DxDnKkxNsU7p5cc?=
 =?us-ascii?Q?sVLB+AmdiV7ExT5LScSYb4M2/EG7s2q6BVYoxZ0S3/H2TmVl+T9eXnZnG13r?=
 =?us-ascii?Q?20K0D6D/yv8tkgwL1TJiYBnPVjm5Mesvpgin1YktoJOiH4C/WoRRgMhgIpN2?=
 =?us-ascii?Q?rzUfu1EVigmunglLIa492l+YqrbLn81f7IpUaKk84wzW2XMd+gQoVnE3m9ag?=
 =?us-ascii?Q?wgR/Okb4ts6r7i8JM0SjLWedJUZ+9Tz9lhBiAja2Q05OUb++42cvVsHhN5+c?=
 =?us-ascii?Q?onz36/qMG6oUODmv3zOSn+4nbLf0FT05iwFkF1dztKJEIl40sPwaD4p1nrwu?=
 =?us-ascii?Q?OZjydhiRx6C8VcmNiZ8mLKiAy3JwUrIXeftMIvJkg6/Y87orQsKcwoVrEhip?=
 =?us-ascii?Q?lPiTnMG7HPiwMjJWTWV4/h+CnhZnB5wy4+ZeB6wGz51Jzpnn5RK12IuNeOdP?=
 =?us-ascii?Q?0EXdZQf+3R8v4/yizCQ7Bk7acuDcAPEkZNyGILVlflX5Ps9drCwTzKWtbaKF?=
 =?us-ascii?Q?rJ46jpJzoDr/wordgh0TOLaqpnjQiopoHpPTnOYo5lt6ExLmKGgVM9511Fwx?=
 =?us-ascii?Q?oZLmoFatDhRR7RXvnIA1daUFI6DmCYtp1qAhswuhUWhT8sHoR9x+f9SZ90X6?=
 =?us-ascii?Q?LOBa4xh6bqcc9NrTSnoFqZI9jgjWax2vDxcLQc5ZQ29Zxz+IAPxP11Wa/nPL?=
 =?us-ascii?Q?CEx1i6zxzexXVvCC9YQtFMOvWd2ldZswDl5UUVv4+jfjFA5ex0HiLnuy6FFV?=
 =?us-ascii?Q?jhsgzyaIoWfjIbZmKylOD56xYCKBDlYJxYuaUjsJdkHS0oACyG2q34XHYNu+?=
 =?us-ascii?Q?tIMCtamelwlycnyjYYeGNXuCkQLmAmD3dIPQBDx1O2X7Ieix4Lqz4xOpWNHu?=
 =?us-ascii?Q?XYVjMKHkeTPs9y8c7tsRgr3eSV/q+hnhejBo6svb8q2FLcj4uT2HldHaQEe6?=
 =?us-ascii?Q?f+BTvdhhRLay4ztZzfg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6561.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d80bf9-f61c-4fbc-d3a5-08de2b698b77
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 14:55:44.4521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 14CLzhatLMzFYIe50b+h7Uxx4FtFIjatoFETOwHkxAeOB54DnDxRPockuSl2QdkK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7313
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

ping

-----Original Message-----
From: Xiaogang.Chen <xiaogang.chen@amd.com>
Sent: Thursday, November 20, 2025 9:51 AM
To: amd-gfx@lists.freedesktop.org
Cc: Chen, Xiaogang <Xiaogang.Chen@amd.com>
Subject: [PATCH v4] drm/amdkfd: Use huge page size to check split svm range=
 alignment

From: Xiaogang Chen <xiaogang.chen@amd.com>

Fixes: 7ef6b2d4b7e5 (drm/amdkfd: remap unaligned svm ranges that have split=
)

When split svm ranges that have been mapped using huge page should use huge=
 page size(2MB) to check split range alignment, not prange->granularity tha=
t means migration granularity.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 46 +++++++++++++++++++---------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index 521c14c7a789..7fe9d569d416 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1144,30 +1144,48 @@ static int
 svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
                     struct list_head *insert_list, struct list_head *remap=
_list)  {
+       unsigned long last_align_down =3D ALIGN_DOWN(prange->last, 512);
+       unsigned long start_align =3D ALIGN(prange->start, 512);
+       bool huge_page_mapping =3D last_align_down > start_align;
        struct svm_range *tail =3D NULL;
-       int r =3D svm_range_split(prange, prange->start, new_last, &tail);
+       int r;

-       if (!r) {
-               list_add(&tail->list, insert_list);
-               if (!IS_ALIGNED(new_last + 1, 1UL << prange->granularity))
-                       list_add(&tail->update_list, remap_list);
-       }
-       return r;
+       r =3D svm_range_split(prange, prange->start, new_last, &tail);
+
+       if (r)
+               return r;
+
+       list_add(&tail->list, insert_list);
+
+       if (huge_page_mapping && tail->start > start_align &&
+           tail->start < last_align_down && (!IS_ALIGNED(tail->start, 512)=
))
+               list_add(&tail->update_list, remap_list);
+
+       return 0;
 }

 static int
 svm_range_split_head(struct svm_range *prange, uint64_t new_start,
                     struct list_head *insert_list, struct list_head *remap=
_list)  {
+       unsigned long last_align_down =3D ALIGN_DOWN(prange->last, 512);
+       unsigned long start_align =3D ALIGN(prange->start, 512);
+       bool huge_page_mapping =3D last_align_down > start_align;
        struct svm_range *head =3D NULL;
-       int r =3D svm_range_split(prange, new_start, prange->last, &head);
+       int r;

-       if (!r) {
-               list_add(&head->list, insert_list);
-               if (!IS_ALIGNED(new_start, 1UL << prange->granularity))
-                       list_add(&head->update_list, remap_list);
-       }
-       return r;
+       r =3D svm_range_split(prange, new_start, prange->last, &head);
+
+       if (r)
+               return r;
+
+       list_add(&head->list, insert_list);
+
+       if (huge_page_mapping && head->last > start_align &&
+           head->last < last_align_down && (!IS_ALIGNED(head->last, 512)))
+               list_add(&head->update_list, remap_list);
+
+       return 0;
 }

 static void
--
2.34.1

