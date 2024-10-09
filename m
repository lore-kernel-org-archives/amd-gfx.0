Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB34CF043B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 04:30:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 967F910E21C;
	Wed,  9 Oct 2024 04:30:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yKlF9KhV";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F309510E21C
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 04:30:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6B2Orui3KwzFWV3KCDIHi+c+epB9/Ow3iHiceQ1ssYSFg6s+Cv/Wwe0+hPlOi2IZykKkmQTc744fac+VaMibb90xs6KStWgKhEuIm8FTxCUALElbsQngs+WCSgTCRSzmQyMvVlQfmLfF3lIDDdNAu1xDm8U90YSAOsh6F4dSuIeRFqcUO98kESOhEbBT9XvfjaSlmzaGlT5MwNLMhvjh7+lbLew75OmYfLctjmEW0zUMla+mklUzNCK1EUc16OSd1oE4Nm7Kzxknu+gsUAJCHM5JQFccXP6/2DX0fmfPVZpZb3cj0UgkA+iYs1CgPlwp5HP7nyWGjQ3stckmt5VOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZiL/wdTBqrQksQmyfo5Vk83S3xXn6C0u7j2Io0u5Ow=;
 b=EXY0FsLMjQIkY7JUCjIuL7X/RgShYJjNjUIdNp0pjWsZv3ZBsGdrKHwOQqSiUl3/Qojb7+4G05WV9Xs9uvUpUbJ0pH1TmrYz8RkgLGvUJxOjrtILqka9XSowGCAR/NxQwSAXre1tTwU1YdjaN+Cvjp5mXkhTXDm5U0hh4uG7dvEzOlnQiow9YJCLYmKM/fIx4O4J4JCLH5LCtet503TS0uywAr+OEkfUAq95NsCmUkieqjNlXVBVlQlYfHw3azFNU4VBGhJDBRgr1gIX/jRXDVJ1E6sUm7M7FhU0MX+aT7ry04M79TbSMdCqhd8lCtUPvwBgBUusVDNDbAiJ+9rW0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZiL/wdTBqrQksQmyfo5Vk83S3xXn6C0u7j2Io0u5Ow=;
 b=yKlF9KhVrl9stzYhAcxQOiszzV0llZj8kYu8ByMr2bpQWaOgI+xYSxMMXwq4twMqpQQCZYqGNPTkXm8iJoQT6SGhmlInmaEcKf1wLm9BGdVu8hFJl9uexWzTCOFjAFDdmR3D+e5Nkfx5fKbVkZ//I1QBF1FKy6NriNQGqFtOXYI=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 IA1PR12MB6580.namprd12.prod.outlook.com (2603:10b6:208:3a0::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.23; Wed, 9 Oct 2024 04:30:02 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%5]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 04:30:02 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
CC: "Ma, Le" <Le.Ma@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Poag, Charis" <Charis.Poag@amd.com>,
 "Cheung, Donald" <donald.cheung@amd.com>, "Khatir, Sepehr"
 <sepehr.khatir@amd.com>, "Oliveira, Daniel" <Daniel.Oliveira@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: Update SMUv13.0.6 PMFW headers
Thread-Topic: [PATCH 1/2] drm/amd/pm: Update SMUv13.0.6 PMFW headers
Thread-Index: AQHbFm5ImiNUkW6siEmRu31cxpHu67J92uHg
Date: Wed, 9 Oct 2024 04:30:01 +0000
Message-ID: <DS7PR12MB60712485AC1CA8DBBE7ABF238E7F2@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20241004150102.327639-1-asad.kamal@amd.com>
In-Reply-To: <20241004150102.327639-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c61b49b1-5561-4ea9-9f1c-f9b9dbee281f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-09T04:29:46Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|IA1PR12MB6580:EE_
x-ms-office365-filtering-correlation-id: f303ba6d-c422-476f-09e2-08dce81b0aa7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?qUkQcfeCc5CvNmjCyHnUQFE9w1oe+0Vwqb4uRdDoH2Nlpgf8J1uDntMVNIe1?=
 =?us-ascii?Q?GZp+wjPWQWyH3lhv7SIFRO9POoP5VtoOds2isI1fm92mj68DBSNK3we5yp4U?=
 =?us-ascii?Q?r3oTw4xURO/Jzty2XvtxeloPBzQUlNpIVXQGyC4ZQaJepFbmuVzabUFkxuh0?=
 =?us-ascii?Q?E3MP0VTZgwReL2CIxwStFSRn4TvvuvVNstEkNd1tlRWovO9ovQUnpnt+4zgN?=
 =?us-ascii?Q?01jg53b+Qf/n/36BQZ1Dk8YUJedtw4UVd33S7RqnsK2VGME/enjrsZfA7taC?=
 =?us-ascii?Q?O7ZsVMHBpfSusqLaxoBD/Kod9EhFBB5PYg+xPM7JBOBqO9jFh0KIwd9p47YX?=
 =?us-ascii?Q?tmbeCU89CGlamSKeR+dAyCzsFT99d+0f1+x5da651xlKmkKszAh/Txj+qEqK?=
 =?us-ascii?Q?HHnoNCQzt81aiViTrbYrgC9Dn8xPWePKv6EhS93NEEPOWK2+NI+gYXTmnqxH?=
 =?us-ascii?Q?3KuSky0gQoYbROUKRGyKHBSLImHflkqNTlOA2f7ng2A4E/AEtNJPcfSP8dcJ?=
 =?us-ascii?Q?fmWRCgPhcKSKwyD8os3CMPQKzasTdZB/z0G13/pX8TJProqWAf1QuQRUyooA?=
 =?us-ascii?Q?lQwPEDbKrwX0hJEQGRafuO1lx2mGKni2q1KfgRHCGfiZw56/SyZxrPPoMGQl?=
 =?us-ascii?Q?FnK/3leZxgAbogKAqDGz8tPBdfwcuH9IpQsL14Sv5NLEL6joDh7s3zypFn46?=
 =?us-ascii?Q?Jm5g+Ptu9AHPh5Y+8z8gcFg7nxQ3Uj7l2W6IRPy3h7xHRg++IY/NJsjmajvA?=
 =?us-ascii?Q?/6rW13G29zKM87VXpRIu1MMJju6MSyYiz/NlZ6RXRpQ0SqoRC5/nucdMZBgk?=
 =?us-ascii?Q?y1DvafqfSXnTExWP6n17V1XQU3WypxUeIpzmrkh+ore5GgptfLa8lre2itDG?=
 =?us-ascii?Q?fHCVL09qoF+B0xmwziP+/9XiBNkXSUxj6X5DezzIOQ4IUHpA1Hj0p0sT/Gh+?=
 =?us-ascii?Q?Imy2lCsJb2wREt7X9fbIVWSKAVlFSJluyxMqe6yODhHurxLWa/ATKWWkj/Ei?=
 =?us-ascii?Q?LxArQI7fVTZ4ukeCDc7tfezot64AxUEVsFdbwYd25vAh1ia/NvUJ0v/ySHZr?=
 =?us-ascii?Q?uqqAqbhqGbxGVf6vZf6Ib3taHRswXZW1CxCiRxWDdXbe3qmuWmRQ0VuG2ka/?=
 =?us-ascii?Q?Jbcv8cnQqUyF0JkVShNhYes4IEDpaL8pgqBwac03YMJ6fTybo0N8MgtfhAur?=
 =?us-ascii?Q?zDFZ685466cr2ReJoDzJJI3mqegofUVS5bEmpzBZ1CiHMLfo4moiaqUbFfYS?=
 =?us-ascii?Q?MctVUxJ8U3t9STSKK58WuFS1AVIouCo3wi1Fom2dmaGb1GxJpXu4cMWAg8xp?=
 =?us-ascii?Q?F0TVi+8ZexRn8nJo9vdOAukbC7t4JrKMc3c5YQpu+1dykw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n50+0HE+Ga5FUUHePiU6iFZw6iKpSjbHX0Wiynuv/ofCfeZSsq+biOQmYNif?=
 =?us-ascii?Q?cqhLhGSff3sk2Bg4SZwEMFKBXSWC3C7LNYZyW64jGJyL43d2gHEQHVUNVDR+?=
 =?us-ascii?Q?kulsZwMHikmPvs/UD+HhonQgvWuYS0jf/fuGsaJPOyXZJOUZ6kxzFUEDffup?=
 =?us-ascii?Q?5hZ4kZxYSGhnnnxTmW2v2Pj75AcN75wtZsxXoe0oxmKQnVfMX+XU2pmKRE5x?=
 =?us-ascii?Q?C31YIX4ycn0GzqojNcD4JDpExjRhmPY9JAHULclegZzyA/Mnn6yITjANSLu5?=
 =?us-ascii?Q?lJZerqR9WSBFQRVT7OEjtDtRdkxDQswTVZ3pb2FBk9NuamckvRngHY8p5t+z?=
 =?us-ascii?Q?i/kxR9g7gpMI0rXdXuNm8RVfJ0LIJN6hINM8Vc6DHqWbjgonnBBH/0Om49QO?=
 =?us-ascii?Q?slLX9LACEk2aPXiOvI1JRYXNzQ6CRuoSTbhYMJU0s30UjV4c6WgbytaF5/qX?=
 =?us-ascii?Q?6QKxr0fWc0jVayr9s5tsMTuBbgx0CdchKFWRtCFrqzmKyrZmAiTAKothFSr7?=
 =?us-ascii?Q?pPQ0/N0UA28uJydZKWqkJUzYCfKwGvT6J6Zm9QfIACSjOrJsCMovDjhD+4/r?=
 =?us-ascii?Q?pooHrGhFwYYwngl30f32lvdpLDVnZHXMSHFZiqi2jozRQYuxHYJoxeQlnW4L?=
 =?us-ascii?Q?GObshnlAf/MO0jPGV5maCgQiZTX2YHlQGVUfOlChuDtvnctkomCVW4plVlWd?=
 =?us-ascii?Q?691OwGmUipWOjAWQKUF5zkj6k5+jAmSCASD42F9iYyA4kjavNAXDx6fzf9/g?=
 =?us-ascii?Q?cOcvSiuPvDe9J8gKM6YftPWk0iBLwU4uguHARVFwz/jmUr0/NBgMqppySfBI?=
 =?us-ascii?Q?331q4SBVXqnmuImDKPKRrmaCms4TwSWyKw8Almti9NW3EmmwrJbJY//Dbxqw?=
 =?us-ascii?Q?SgeOzFG41cqvtXgoSzlFgNT/Q6L5vP+8tnUy9ItyuE5f25bEd4NXLVVyiCd7?=
 =?us-ascii?Q?1l6rE5lbHb0KJUMvkYmVZnKFrb1rrFchyvHw7ELhrWO+bIRH1ohAEgJ7gDk+?=
 =?us-ascii?Q?20Lf0JuqEfUq+vMtGq1WLolJGcxIeZq+/F+AwNXGLX5T7vEhAwAQ64nUCO8r?=
 =?us-ascii?Q?nEIsRmbqTre7xO5mhIpFw0LcJNp8kkdCDLGiGJUOaRqjyrZ6iazR+UuDTim9?=
 =?us-ascii?Q?tUWiFVi3yNsfarIurNDGKzdfv2Kwe6QQSBFFxL3SptrhCN2+QHsAKU4L7+NG?=
 =?us-ascii?Q?TSw5AzDhCb9uin1jhwsyJJCN3H3eB9i6wqeqnfs/lIF9locSrg/iGsD+jMgF?=
 =?us-ascii?Q?XnQhJcb2mq+M9GyfjgTAd/HMTwXKXsr0tC4irGFRjqeIX0afggdLUrX72DOA?=
 =?us-ascii?Q?VnnQDCDs1mBfH1ImuZNcQrgBPHGOfiM3l5jCy+jrAhlzbKfUpjrWMadqsJpx?=
 =?us-ascii?Q?dc9x9kqT22P9k1R+v92AaX/jP+J4vev3U50flqEpbvoRiqKmTOzHgR23y65W?=
 =?us-ascii?Q?K68GlZnLWdMKg3OpCscFo5jHhr/hiQfoKzSHOB682uNXuoNhJ1of6S7aH6ef?=
 =?us-ascii?Q?JR/6uKa749Oh5E884z4wXNT0f689mKGRyof7KnBh2kvu7F9yv+IysXQmdBl6?=
 =?us-ascii?Q?CEwbbm6k7nPGnfq2Uvc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f303ba6d-c422-476f-09e2-08dce81b0aa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 04:30:01.9620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AUh28Mm/5DMpnptnUjqdJQQm52g8U8hYqng+MyYHn/4YlbfAGgW4HBgF9fFYqdS3osV2YlSrv7U/Vtj2VvoStQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6580
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

Ping

-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Friday, October 4, 2024 8:31 PM
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Ma, Le <Le.Ma@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Zhang, =
Morris <Shiwu.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Poag, Chari=
s <Charis.Poag@amd.com>; Cheung, Donald <donald.cheung@amd.com>; Khatir, Se=
pehr <sepehr.khatir@amd.com>; Oliveira, Daniel <Daniel.Oliveira@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: Update SMUv13.0.6 PMFW headers

Update pmfw headers for smuv13.0.6 to version 0xE

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h b/=
drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
index 822c6425d90e..0f96b8c59a0e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
@@ -123,7 +123,7 @@ typedef enum {
   VOLTAGE_GUARDBAND_COUNT
 } GFX_GUARDBAND_e;

-#define SMU_METRICS_TABLE_VERSION 0xD
+#define SMU_METRICS_TABLE_VERSION 0xE

 typedef struct __attribute__((packed, aligned(4))) {
   uint32_t AccumulationCounter;
@@ -231,6 +231,9 @@ typedef struct __attribute__((packed, aligned(4))) {
   // PER XCD ACTIVITY
   uint32_t GfxBusy[8];
   uint64_t GfxBusyAcc[8];
+
+  //PCIE BW Data and error count
+  uint32_t PCIeOtherEndRecoveryAcc;       // The Pcie counter itself is ac=
cumulated
 } MetricsTableX_t;

 typedef struct __attribute__((packed, aligned(4))) {
--
2.46.0

