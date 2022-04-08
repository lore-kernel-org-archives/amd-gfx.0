Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD427C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 10:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BB6C10EEED;
	Fri,  8 Apr 2022 10:50:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FE9E10EEED
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 10:50:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5uI+cexuP78c+ggxip85nyi6QyUSOM7KKzorYDHtRrmY3PBH/27Km58mzl1YEnnj2fd0FnJj2Nu4M+SF8S7ZxOyLA3uEeRuaWKE9yKaZCm8SLuRY1Nm8aFTC2YJ6JRPPLhfoul797N2aj1TZKREm/+NKKgfcL57cJttKwUtPnqK0ei2fxqmSnkyzrnAGKDSRz1/Ffs5WQyqRwNvkyBXXZAgUCez22bxP5mgNnyqrDLiHjRfNyuVHFZwUwIDlIE19LalgsAPYj4xRdRh7YOdIIJaNguQ96Sh67uhzXC1JCABPLDLHO9iWH0j9Xb+ZECHnxVCM0+aifVQaMIXVnOSsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+/nXRBcD4DTFei/S+FuQ4hJh8UrfmOjNSNc6vpJPdE=;
 b=d+SCB2zfxJss7CLzuP0aMHSP3hn6Ie/EGGtyJhZoplJ0B+244f1LdX+POWlIi1ckEwxOSlRMr2VTUdR1aO3WbdlHRUq+uMgrEHHCP1B3quK5JHMoO/FTnGlvSSnvYCk2JiF9mJ/DS0srE3bh+2gZ3yaFxwynKTpanmsFDc8RHA3G2KLxAqf74ROEwMqSNlouEdlPJ+993GszWJ1rE53iAp0fIQOC+OxQWC0Ht1yt3o5y3kzobC1eC2ddWbXvCQnwOKpr+d880va6R0L9Eplb5huy6RhYYmaAoAqhdvu67Q2cW+BuwQNcVsrzPG2tY72UxjqXj8SHQ4ImKwKzk+FMkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+/nXRBcD4DTFei/S+FuQ4hJh8UrfmOjNSNc6vpJPdE=;
 b=ij+ye87tD/2vVnd8je2YXOKyh0sR0AkSJwc07vUl56FCaZtyQY5YQsAhP+F6p4Ar026cx3xix8QxhtXHlzkvYRPWGZHe2UBsaUYOUqUHB7D6KEvtKOZ8nlaCDO/Qk0f9DmooNuPgIfVdmyZhzXZGIXcBqhqFMmMs7i+SYSD5MVE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB4715.namprd12.prod.outlook.com (2603:10b6:5:36::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 10:50:20 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::a561:6b71:55fa:ed2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::a561:6b71:55fa:ed2d%7]) with mapi id 15.20.5144.026; Fri, 8 Apr 2022
 10:50:20 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Use flexible array member
Thread-Topic: [PATCH v2] drm/amdgpu: Use flexible array member
Thread-Index: AQHYSzB08Uig6yYIGkWcQyYEoOii0Kzl1m1g
Date: Fri, 8 Apr 2022 10:50:19 +0000
Message-ID: <BN9PR12MB5257BE16BC0B6C09798675A7FCE99@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220408100710.211593-1-lijo.lazar@amd.com>
In-Reply-To: <20220408100710.211593-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=8a280bf4-9b2b-48b0-99ca-c5a935b667fa;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-08T10:50:04Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd24013f-a0a1-4215-e7dd-08da194d9346
x-ms-traffictypediagnostic: DM6PR12MB4715:EE_
x-microsoft-antispam-prvs: <DM6PR12MB47158B663F5439E720A92FFFFCE99@DM6PR12MB4715.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1OcWrkEcgG4FmzXjWfdX6CLSgHftKdq4UGDMy7vBEsT9BxcoOYiSx8GnUKJOXeQ1cTT+EtY6pTDe+gBNXzGUaIMMNdpJXub7aaGzbAyaMNpqu9qfayUNZpJDUOYd0HzwA8+9hr7dCJZH2gOHZIigVnrsYE9me7uIXUU8HL21ybV/ELTI11wZTEj4p7KN7nMHVX7KbjJvyQbYGH2nKdJKUIHwCCAxjRX1NT4W5FGy/ZrECr8IEjbTSLkTIFU6tlI3U7GlZLVQtyzqKTkhgFHQxXwMi1dYxELtj0Q1hA6clQyUAGxYBRUUFuOTzzC6VkLgisF/OsUlePStLTlfls9XWJkCmfC+N2g5PURllp+PPO2/TluOqIzrsrXnYajMQ65+gEuAwlVBKoyheookPYMb2hP19OFED1uAoZTcbRbNilUTqG18WdWh2MWyKpup/t9CQDQRIxxYrRbSGH2QoQg4Iu+G2LAtb+3F/gc/jqLpjclIZZ82CckJf0aG08TLsWf2Ts5Yr69F+MhY6XgQPbSDYNmRE9CEvxv5j2v67TVyRldjB7DcXRubRuKy91EDTBrxEjLjdn//uvmcTfmtk47DPaqHznkU/d3rK1GYyIKoRaTIgu5Ri3jUS5qTq+yLiQKhFgyXYUlvSDF9r/KLdlvHoZNLyHXhrnVsZgheodwL/Hp4UisPf0ClRd8ojg4op1GMuPuHFB+YDl+Is9bYgzZnqZThKiR0gkjhKrza89xTru0zxgzZxbzApX71JZe6R/6Tfxa09e4EHD7n+KtQEPi8JgdNFXtcE+s99sfVxce8osA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(7696005)(52536014)(38070700005)(8936002)(122000001)(38100700002)(316002)(5660300002)(26005)(110136005)(186003)(508600001)(966005)(9686003)(71200400001)(53546011)(4326008)(8676002)(83380400001)(64756008)(66476007)(66556008)(66946007)(66446008)(86362001)(33656002)(2906002)(55016003)(76116006)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JJjjjdwXEKAQYTA361JNMThuMZaQ/EfLMv3S6uFh07NMR/35RejyegRWCsMV?=
 =?us-ascii?Q?4N1gr9lo8rhHkXaGoYTU5Xs6k57IaMbtneZfDM4kzK6Ne3r1yUNcp2PD4hi3?=
 =?us-ascii?Q?QdIsuNMhrQrL7VPOBdNskyVDT1oYiJBzKIKtIisaA3ZLjyUp/SPAg+hb4UL2?=
 =?us-ascii?Q?fEmwr+Tb5EirqFgGeURL2fZEAeM3p5M+zMny5SlRH7Ca2p4z3gFpFbyQKUbl?=
 =?us-ascii?Q?7qnNJ3IwQzPWg3gR7AFH9O7UN5mZrDd2ymH0bwPeODqwlxbUl2roQlL7OCn/?=
 =?us-ascii?Q?PrHc/eOmi9A84jCV8a5cWrFTzsIaPGxqQwr9Z8GgOrPNld8VDywCQCForSUd?=
 =?us-ascii?Q?sT0CQLPPCKlKsuZ72imOVNtk3DSB1vooyu1Vfo3dmkWJORw/eLMoxoAxO+F4?=
 =?us-ascii?Q?pgxp5UNgHPPMpn1FjCdZU2F+1zIubw0QkZHcX2jhgV5uFduYgCNbNi83tHPD?=
 =?us-ascii?Q?AdlhHD0optqfHxlXu43sY5jdWL1QJmHzbn+2eb8gGYAxC11DSkWa9nHKF0f5?=
 =?us-ascii?Q?3Ay6P6vNvpAC0s4ZHiYZVvCVgwPktlouyYh2Fd4vQeuwslg3BrNA05/ottnK?=
 =?us-ascii?Q?pTweG3/7z7RloScjVnrjcb3L+ZkOrFyKxjN3TeRgO4xIfYj3OlUlXry0edtO?=
 =?us-ascii?Q?LS23tbI7pL78AJiw6y1Cb+vc9dyk6ZDpFkrtE71BhSk57Kh/FQvyPGoEqlhb?=
 =?us-ascii?Q?ON+YSabYcOV5RkxRxh8uUb7S+943NgjAZJsO5mveCCFzSyn5MiU8i5aa/Bz5?=
 =?us-ascii?Q?jh2CbzU8GL6J5G+4bNkovUhg58HPbjT/eIWweWG6cSFL2z92H2ip5vrM3soi?=
 =?us-ascii?Q?sytMfpGRVa0bb3sdKONvCveaQ39jjLvuRmicMdS1tflnhUsFvpxS4EcOMzTR?=
 =?us-ascii?Q?OnwTuLK/Om4GKonm1/bBIT8NARY1FRoFUwe2/66z9l+4x3vPrFOKaj2ywLdY?=
 =?us-ascii?Q?jKDaT6lXu+umBWRplpAfyyQR8B//3rZ3Hsv22/Zz+5kisMQnCscvxbR6tVYJ?=
 =?us-ascii?Q?f1GL7fU72+v41JJRchnGyb9AxWoj+KlTi6JdsN5bP8OCyJgLb6xg9UgakH7/?=
 =?us-ascii?Q?2vHbZxU/QkHLLHsIM4jOUGCKyKMJUJLa7sUIjny3e+fpH/wQIlnrJ+tTaW61?=
 =?us-ascii?Q?N4TmR5CxzBYfWy36gyuca53SDYLVv00ujnX+PcVIScWUlQEsmbEDswoA6UKc?=
 =?us-ascii?Q?0x6wtGnZpbl5A72ATLWLoHLQgRfyt2rraM1cumzgZaV0YI7Zi6d0xhv1k5Yj?=
 =?us-ascii?Q?KspP6+59HfjWrf1iGxnJv/a4C3NHkJhw3KOx3p2gZ7R61dXmpenk1B4DVw44?=
 =?us-ascii?Q?JQg6magVMuQpJbVlNFddg/uKAGYpDKPggp6rtFbcPRagn+pahgMGGAcQzjgd?=
 =?us-ascii?Q?sPMz8q6gzIGrnT6gueQJetrWXucavbsWWR6nfpc0YYCJR7EAx8/RlnXHf9+j?=
 =?us-ascii?Q?GVFkp3h5OjqptmoqrqouIHNmlnDvtHZmm5lfjd0q2hsDTQZbbueEt3fXBojY?=
 =?us-ascii?Q?nZrl0+ENMbrE/ZpS2TfKP8Pfb9r+YnPyKQEKsP5s5r6H+659tDLqfuv2lIP5?=
 =?us-ascii?Q?mtd195RazkH7KdTVicWRSnuTAEzHwEz8vnHTOXLWwfNWLspQGND4h+SFUUf2?=
 =?us-ascii?Q?WUY2RV5REVe6OolO87G9ThjzlqSODDNZsbWqJ+wxcNHAfaeajAzCxUnklNMU?=
 =?us-ascii?Q?e7zhPKWvxEH9HbWo6r9/kYhm/WYWZqBiTPYkFQ3DJgIx0DovNrxsGR0CRxZV?=
 =?us-ascii?Q?QfY2tszDFQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd24013f-a0a1-4215-e7dd-08da194d9346
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 10:50:19.9952 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x0LuHlhN5KT+xF6PNVQu6oQu8gpBHTMVSL/Cym05dvRqwgTK+Ed5NJD+79t0+RYc7a8lUGqMA8DUfhzvM0cBMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4715
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, April 8, 2022 18:07
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH v2] drm/amdgpu: Use flexible array member

Use flexible array member in ip discovery struct as recommended[1].

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-len=
gth-and-one-element-arrays

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 v2 : Use struct_size (Christian)

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
 drivers/gpu/drm/amd/include/discovery.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 5a182288391b..766006a075ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -430,7 +430,7 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(st=
ruct amdgpu_device *adev,
                                 }
                         }
 next_ip:
-                       ip_offset +=3D sizeof(*ip) + 4 * (ip->num_base_addr=
ess - 1);
+                       ip_offset +=3D struct_size(ip, base_address, ip->nu=
m_base_address);
                }
        }
 }
diff --git a/drivers/gpu/drm/amd/include/discovery.h b/drivers/gpu/drm/amd/=
include/discovery.h
index a486769b66c6..b25026c3ec96 100644
--- a/drivers/gpu/drm/amd/include/discovery.h
+++ b/drivers/gpu/drm/amd/include/discovery.h
@@ -93,7 +93,7 @@ typedef struct ip
        uint8_t harvest : 4;      /* Harvest */
        uint8_t reserved : 4;     /* Placeholder field */
 #endif
-       uint32_t base_address[1]; /* variable number of Addresses */
+       uint32_t base_address[]; /* variable number of Addresses */
 } ip;

 typedef struct die_header
--
2.25.1

