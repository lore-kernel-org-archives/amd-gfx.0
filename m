Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB57C02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 08:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9579610E1BB;
	Wed,  5 Feb 2025 08:59:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k3sbJLS/";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 884DF10E070
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 08:55:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=En7p2SGi1xBTPdzTsKFKmhueLoAcBJ18T4D4WwP2XUGB5DuvPoU/NY/p0XymzZe3UCxUx1dY4V7Sih6bNVjJihlQ1Vs5DN/g22xUFBwoc6nqo7EvhxoQI7/qt1zakuDaABGTIE9j8Zb654FzMvJzy/8aCJTe5qg6eD+ubpqjkO+b6F7VGEA0P7JxAnoGZQoHKdTsTUtbidQoyoPLtkfAAyhF41x0zAmQMiIErvuTSCKNxEDfgd0yh07uTNFB34r4Q0Hxcg57OHrNrf3bTe1pSf5QP+/QhMXaaCrEeUfB0fhyORKyFehyg9Ofb9VEYIKQBGzQC7UlVUe/UZzPhJGz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0MN57wqd/43FAs8VF7bDs5tALmgaH5xog3OSjIyt2c=;
 b=Z1phB3JHuA+XGzTbNotqiOMd1vkybuhIrCHGFo4sUUVIG+WV/NO4nOBog3+NlBaARn5fFRoqDolGnrunizBXUrQbuouagGZwRKYQzIGBXXshrUHYezfU7q0VsMpO603/XUukiyOkfZ22x1ySlRAqL/fouelU/hCEcs+5PS1NdixTAe2tgXWgsv4FqJA8gkJ+ZVSZst6pt1fIHaQk+wR+yOkoBVpm8ozeqC0r9rfncpjx9ExHo1Cyx5wxROSf57JP7KG3zT7YMpZ6z/29XsI/vMzaOYPArT5ih7YVznY1jh/vbDBi9QJ7kBeZPD/mrU37WItw3GlZWaGoRvLNOvcvSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0MN57wqd/43FAs8VF7bDs5tALmgaH5xog3OSjIyt2c=;
 b=k3sbJLS/ItbODoz5eKpCFNdzyO30ODFAtQFOgquM34Cf+qEj+AD6bpLkAV1Odcs7JuOVaO0ZtPEo6zVsS1srzbdzyu9kp0yQkc/ecb8bhEb5wYE6VDjkBJIyGwE8X+CDh/zppGoN2Ch/Hwx41cKbqmoCRQNiuJH4huEQcNYRl6Y=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 SN7PR12MB6670.namprd12.prod.outlook.com (2603:10b6:806:26e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 08:55:38 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%5]) with mapi id 15.20.8422.009; Wed, 5 Feb 2025
 08:55:38 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: refine smu send msg debug log format
Thread-Topic: [PATCH] drm/amdgpu: refine smu send msg debug log format
Thread-Index: AQHbd6Kvp+7s3nkdoE2bjkjo2IpgJ7M4aA7Q
Date: Wed, 5 Feb 2025 08:55:37 +0000
Message-ID: <DM4PR12MB5165021F81A683B7B54B869F8EF72@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20250205075035.2170125-1-kevinyang.wang@amd.com>
In-Reply-To: <20250205075035.2170125-1-kevinyang.wang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=9dc731fc-2069-498c-a3f7-f80153ec7abc;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-05T08:55:11Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|SN7PR12MB6670:EE_
x-ms-office365-filtering-correlation-id: c21d926e-b046-40ea-c8f6-08dd45c2dc5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?jNP9f3rm6hxwYfAVj83Yxe7rrpUKWPdIdhpSOtdcVgc9c7Ks5p2gwEshupoC?=
 =?us-ascii?Q?2HiTIkNOrQwiqbipdClbTVJE22HiRjPs/8VL9H4RHvlTM71mPf95Q5fbdcUH?=
 =?us-ascii?Q?q+iKhgvA2YBKuIss/edTBn2GqPNKS/itv8dRNSqqWru/oWPV1hDsK4ZouFoz?=
 =?us-ascii?Q?vkJ5fJsKMxWw4r27Ck0umno+InHCz6447MSFtOT8r8ZOrm/f8afe1Rlm8dmQ?=
 =?us-ascii?Q?VB0Sm0UZ9iaiFbXVen6UWnLtoJIz69FbeC6yK+LgJfOlyUk5kqz8XNq88Je+?=
 =?us-ascii?Q?0dPtK/djMa14Q4u6avi3+ATtUNT/iSJETdaOr3U863+1p286sb5nE6XJCEUy?=
 =?us-ascii?Q?uTkGlRPr/wD3l5LgS74fgHTON2WWHd/QCzZdwx8oRBweQSPlAd7bFjuXxbEX?=
 =?us-ascii?Q?BM+S9Ipa0WeX+hjqOajfJaK6ssQzdk5h6vIKi/IqZHV3vsyogngJaGd9ySnP?=
 =?us-ascii?Q?aXJ81gDTUEwm0joJnxA5qWQJGusa2HAf/SGQtcxDxmLf8gGbOQ+odgChrmxj?=
 =?us-ascii?Q?VNurN0LYIIDbZVxDjDV3O8TfRBpSNV8Y5mrRS95mCasV/f+xS3ImYQUYVUn0?=
 =?us-ascii?Q?AhitLKq4VNVNP5X/mjA5R8u/CMocVL4JBBL7biGMVpq/oSjNzmIuFuS5GFB0?=
 =?us-ascii?Q?xBz7sLue6Fx1jG5M6X6cI9W3LEJ3vCaD1ijDtVa3Xh3mnmsJJecqO+VqSxyk?=
 =?us-ascii?Q?OzrPsOGwphiRoKur92BKrp3wjOLFNkOrVG6fPQyVroc9ElcL3VClAmBEVjc1?=
 =?us-ascii?Q?7sYSiOaYdLWedK+i/KNRyfmSK6BA7c0qHhzGjP/Fww+Kp0wAfWYMNAFRrEqB?=
 =?us-ascii?Q?mho/lOKberTXzNgo8OKRGab7NiK7uO81fzQMKgFsGXGK090crnHHT6hAqh84?=
 =?us-ascii?Q?ySWGARzkDqURL3tSW3JXb8c94GoAIZ65CAUqD/BXgcuWGl8lO1HHMXyJFfUw?=
 =?us-ascii?Q?K9Vdq5GrdrVn9FfNorqlVHzw7VMRbpoftFQLC6TvhVoDotdKpVSIL8905A19?=
 =?us-ascii?Q?twutYSc54rsJpod7lTGDAcFbRvShPNkIof5YYdSsQ78MA0UNwHzGQsqYhmAT?=
 =?us-ascii?Q?bkhYeC6Vk5a8wqGkcKEirClnXG6+UQHrO9uDTYALVXDTHR541RZQbr1rMqdM?=
 =?us-ascii?Q?NbsvwiUa4y4vCzHZlz2JnoL4QTgZ6K5VXBu2/3SiuA+kUCqii38uT7z/TTiU?=
 =?us-ascii?Q?yTipcUhnNE2p5k96jW7FPVNvueSOYqnKWcMwsEL07a/8MH0x5Vq+88899b5J?=
 =?us-ascii?Q?uDmpMujqOtAiqN+C/wTePtgbRU8fjQxMeLnLxyq7RxSr4urI+XYUzqgVG4Bo?=
 =?us-ascii?Q?cid4mKK72BD+aipq2FZT9HqQDqttjIxrrNeXuI4Ju+Yo1E+MzQLa4pNCaH7C?=
 =?us-ascii?Q?S74HIqH+iPWzJEYMeLEkLHAT8z/F+ejKpINNVPfJHDWsfCzX0jLifeyxbSsh?=
 =?us-ascii?Q?12ZWeOxPgY1QlUY08Sa3RHM+o9PJ/6eJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?040C0w4nyw4qpbKVrE8XOn3kTnEanJgW2HgkQBmIeOg8/Uib71VFzSVWs4E3?=
 =?us-ascii?Q?OYRnElR0QGU8TJLMhUhOzDC3YIgfQZbgUtOCkgkRakKn1gxdDenT0WRHGxRo?=
 =?us-ascii?Q?6bGBrIR5zDIxVRNmtJm4p6NHOxz/E5rNjkFAWFZEk+oYY9rABlvfraGIe8L7?=
 =?us-ascii?Q?Dt8nVTj4hEuAIwppg4QqUPpASY9cBWiwXJddiddD4jNTIc/KF14t0P8tcgDa?=
 =?us-ascii?Q?M4ucmvWor/MaE7Z6g0wuMApdDIessMyiyuL8Y+ZlIMcjN1L9B/w12VvUYSzy?=
 =?us-ascii?Q?Pw4kwt6lJyJxUa0UkP1CGgo6UOBVW+gwVEy+EpvTQF/u3JyrhdYhLERrjxU5?=
 =?us-ascii?Q?wn9AuuSLZDiUMUEB54T3k8cl4Xjv1c+avJFVVNQUJ6C2FFeNnl2Ii112y/e0?=
 =?us-ascii?Q?eCi0lSYGFikKZ2kUx3gcZ1aWZFkVWB7s3qzfM1ckPpGXrB5LvbIOi6ufd9Zr?=
 =?us-ascii?Q?5GEh6fIptp1JiXbMtn/SJ3ygHcsMvqfVvXBNQ06tjwNFQyD0RbBoqQdAaFO5?=
 =?us-ascii?Q?IYJtHCZgVM282Z//sz7CswgcmlFxP7Kfq+Dh3KUyFjPVjStmIFRZYMeo5Kya?=
 =?us-ascii?Q?B56q78WLzTM9dWDLDYsFeW67voEgDjWbU5vlTWIGZv7uarMa/8k8J9RdNLcr?=
 =?us-ascii?Q?HgUTx+xofQ+j9m4k7MGK16ON9l7o8611xLLxHhJ4ikUJW2yRgZhmgZXxJOVx?=
 =?us-ascii?Q?KJy2VFkn3gsliNqIJP3J+8n9byfUKAvGlzpECXpQWfc+/8uoq8+e4R174k36?=
 =?us-ascii?Q?GxprFdMe14D2/kv5R4WIuZjzpE0U32/e3LFrK/Y2z7sX8e14JQs4oeMLZIPw?=
 =?us-ascii?Q?oFZpRMVGqDp3GpIqAidiWPEMJ542UdA4z4U7+PI8yeVT6xpGVXFBRBBEwrH0?=
 =?us-ascii?Q?NiDvjwtMTI/BTL5g8TFmUoL06ylJNHjVPdcQ0WxY2m8DeR3CclCCBIyYHaPb?=
 =?us-ascii?Q?WnOSYxP/rYtuYfd1NqWRggV0xJw4YHNgTnQWAhbj8XEOLkS0zP95xyuWmtvj?=
 =?us-ascii?Q?uSQh89wlIpiCl0QW1FGnDgoCWvcbk/GvhnBUj6arAIigNuwZ2SPfMPlGzdPO?=
 =?us-ascii?Q?F46qwZbSvMDSYGAFBnNf486lk8dccoJcZeTLydu/cY6QqMTFkbPM5svU7vvN?=
 =?us-ascii?Q?LaEnEZrihh5bJR4mKrxWZ9ue76e45k/N68c7i8Oy35TTP6FjavfzEY+gMICp?=
 =?us-ascii?Q?gLQPue767Z9wzYRRjQGFzADyPDQe9XDIRxEBPxPLr2Vrh4s+pc1jf3xVFieW?=
 =?us-ascii?Q?iRIK5S5YOVOJ97dbyVZdNTuZdKmRCWIXT7QFA3/SO8k1RuG6MALptnFXkLu2?=
 =?us-ascii?Q?493aaGM3ESGOSCWhtcnm9bMWyZpoac6HI0BKpXgyMdlA4XB2WyYzI6J8SCGZ?=
 =?us-ascii?Q?ocicfW/1zC8tpCVOwit/zqX5RI08XWoSqrQKmBepAazNuhoffTnGf4Jo7UsZ?=
 =?us-ascii?Q?g1E2henb6M4VIBGzeXXGAawOYvN8eBgH5R+M05veRmkh5FCgj+UFs3rhDLWx?=
 =?us-ascii?Q?Gs1pAQ1hfTSrUq1W7a3ZA7/CpuIrKFXSNXMbcDbJnh/O3lSGQeRFbrj4JmVK?=
 =?us-ascii?Q?MZpGVZui+Sxx2uFy5Oc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c21d926e-b046-40ea-c8f6-08dd45c2dc5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 08:55:37.8863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oIOYWA4LOK6g/JNN1ruEpnAKqlPRxCnhkB2ZeoEp4eqz44ZiqpDaZnvCbD9+56R5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6670
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

Reviewed-by: Kenneth Feng kenneth.feng@amd.com


-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, February 5, 2025 3:51 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amdgpu: refine smu send msg debug log format

remove unnecessary line breaks.

[   51.280860] amdgpu 0000:24:00.0: amdgpu: smu send message: GetEnabledSmu=
FeaturesHigh(13) param: 0x00000000, resp: 0x00000001,                      =
  readval: 0x00003763

Fixes: a364c014a2c1 ("drm/amd/pm: enable amdgpu smu send message log")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index 9f55207ea9bc..d834d134ad2b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -459,8 +459,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context =
*smu,
        }
        if (read_arg) {
                smu_cmn_read_arg(smu, read_arg);
-               dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x,=
 resp: 0x%08x,\
-                       readval: 0x%08x\n",
+               dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x,=
 resp: 0x%08x, readval: 0x%08x\n",
                        smu_get_message_name(smu, msg), index, param, reg, =
*read_arg);
        } else {
                dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x,=
 resp: 0x%08x\n",
--
2.34.1

