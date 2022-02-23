Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84279C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Feb 2022 02:27:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2088710E142;
	Wed, 23 Feb 2022 02:27:36 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2057.outbound.protection.outlook.com [40.107.96.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E146310E142
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 02:27:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/g6bMltqwTc2hq1GPSkWSWrAM7DkALndS1CnnESJE9Pu6IQnZeimMYQ6EXs8q12DzqpQtqytGVDmlyUlqAM2axjNA+0DMsEuSP+v2bymKO1c0Nu/AncBqjATWkHEufBj91gerxE22UUjaAKOor8kJShReAYV5kjHXpYjpZW47NlnV3e9XIbIGvvjTABK7Vh9eCnwmkbWMrIZPavsvdwfqXMBLLHUg87mRY90yM2O3c1XUoKMmeZRm5YF+r6MAcVnO6cegx05M8WDXEIwXzJQWL0n2JYSJJbjFq2dPv3866gZwN1illzB2YTmkyWMFQf/8DaDZ9q6kqjOHX0Wu5/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IK0QXSfe6lwrrq4srhpQsn2EDGkZE8fbDZca/UAIukM=;
 b=RIQ/EXdShcGJJPSbFWlxaOc56CWB2pzIFTfOBpivpxh/XcQ5BUdOhAyhF5TbjY9KYCtCO0Y6d2JR7okhXZrIC61FKV899H0Bm+142pmTOIDHQroO0bM2kxY8OMElk+Vkjl7Jfh3L4W1dleWNdi2JGV2h7s0SYuvwuzymPpympMXHoDU3Gta2QaxM89PL/Qu3iXLJmkSL98N/E88Z8kOFjDjgOndIrXWs98DYvmxtwJkh7GUZAKNNon5yOCutesj3TsfVLgFt46DsJCTjImfai7wzhkg7uvxSkeIZPi2zfco/bXQfCoFcQlzwme2yTiTMHbJeAT+IOczXJC1RQryePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IK0QXSfe6lwrrq4srhpQsn2EDGkZE8fbDZca/UAIukM=;
 b=fYWOR3z3KBrmuui0RIfZFqy9jto7NjMwLegfP9wuM59IUUSq8J8rc8k+0SMVOdXDKUKp1rqlO3RwqoG0mvjqBUJj3q8QqcGYxXQt9G5sSgK6IHNBJOE+k79AztP8XhM151/hsI+RLqAiJK2unmeDeWYwtUJ78iwaeqbZoRhYakQ=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 BY5PR12MB4819.namprd12.prod.outlook.com (2603:10b6:a03:1fd::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Wed, 23 Feb
 2022 02:27:31 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::612d:cd2a:369b:17c6]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::612d:cd2a:369b:17c6%6]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 02:27:31 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix typo in amdgpu_discovery.c
Thread-Topic: [PATCH] drm/amdgpu: fix typo in amdgpu_discovery.c
Thread-Index: AQHYKC7BAEamIYOuSkW7P9xtuhpvIqygaV5g
Date: Wed, 23 Feb 2022 02:27:31 +0000
Message-ID: <DM5PR12MB24696DCDAEB01C1CE5F075E5F13C9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220222205643.1372087-1-alexander.deucher@amd.com>
In-Reply-To: <20220222205643.1372087-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce3ee2c3-7ea3-457a-9c08-08d9f6740b63
x-ms-traffictypediagnostic: BY5PR12MB4819:EE_
x-microsoft-antispam-prvs: <BY5PR12MB4819B5A789487CCBC3BCFCA2F13C9@BY5PR12MB4819.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: znEU9L9hQ94BTAIIePeAMPdqWNTEDozGpuQcTSYtjCvSOp88XiNkPKrLIv2FUs45AkHhd4cGnEXj73/EZvQrz41thABpX8rtApg0uuPHRK3P4glmpcgIICvCrcekGpSceYYnQYHm7QvMKEXoOTCkAfT9Tef9qfzF0g8SFi7UWlRpu1sv0+jUfbzU1j31GxqsmgSgmIOqKcli6t39SDfk9CGFRahtgMpqusjhBlp/X3QVVISS9rw8QX7fBNT/3PD8X1H8QpE7mUNxpamUrLBpEaL++rNSF0fnCFyEBs659beFfx+FRURKJqp2p5KX7zbfecxFSLv/mgqf8QrRWmst0qI2wxp7gX906jPVgMv4qeMPJB9DbMaoukMG767vxXhNFbZHHXcXh9dQs8zHJHhVgC9lcUlhG2biaG6qfcnpcE5INLUwkjlEdiokQuvbakyHxPZ4Rj0Dek0qsk8++TkArCiD7Fd6qBTDpyGl532HKkOR2feaLc9CC+zn+AI5FxyNT63L440yEsThPIosfw2re0uIcKOlyPPREZqSQEXF/GAZfIyI9XerUGA/NBRqElPaINZqU+wuQwvhCCNGhlXwhDkIPdejmd8x6CVS9KKxMabWkzUAfbuX8fxwLgl/LcefsazsARQo852tEvKlWJT+Ui6oj8PbPyxJ5Kjc5dAp61QQi8Oy90FjGlV9j9OponqDBLUdEeIoQKqAgjjNU1V2TA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(66946007)(26005)(316002)(76116006)(9686003)(53546011)(7696005)(8676002)(4326008)(38100700002)(64756008)(66476007)(2906002)(186003)(66446008)(66556008)(83380400001)(5660300002)(8936002)(110136005)(122000001)(33656002)(508600001)(55016003)(52536014)(71200400001)(6506007)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ioTzKOuhxKJjgdn4qApg5XpSLkrlo5Kajau1hpMc+mZYKomHoe8Taq+uVJXS?=
 =?us-ascii?Q?Fsa4qTrr1rywWvuq1wl2HoydaoPONDeiWMbvIb5a8u6f5oW1mz1YT5bu7Vyq?=
 =?us-ascii?Q?RbN+sPlA0OYI0K4eUGAvUE1ZGVhnvHhFS/Hir+kSBwlXe6aCjeTtiRbXReoD?=
 =?us-ascii?Q?wiUdFWnBN0vROgPgfOE6VjZblBwzwvGKeLCnRuNr5GGegmpREFhiJpyYVN2/?=
 =?us-ascii?Q?97TOIHkhXs3UOis578ebkDlHeIt9K6O4+pV040D/inUdc1hEh3Cbz883FpV0?=
 =?us-ascii?Q?uCjnWVqbBBxf4i43JdsGzjF8JG1YF0ProDkYwVIk3+0V2dqjdQgfhTzYnQ1D?=
 =?us-ascii?Q?F9BKYoY+dQi+qMXDVF3V4zxCFaC6vmEOCkpqLhfmg8gYuZ5yV7/lE7OAYLa5?=
 =?us-ascii?Q?5gpaX2n20NqsW2jkyZPER+aC3USzGh9OBR4nn0Mcq2sSJPx7D8Nvadq/EQVW?=
 =?us-ascii?Q?I5fW8z3Qm7xEklRtBbThMmaEWIpHwC5kFmpxC1xp1GAYHeko7SHiwTGPpUWg?=
 =?us-ascii?Q?rpTr1aTZAekzsRQn1M9Jc1roLMJX/Z4jJz5zrPir8N3NDD4rzUV0cdvVO1TC?=
 =?us-ascii?Q?dFy7LyultLYtMuGFsPnyvZQEuBbtyuGWaJNiEw+0cuyaKgM3Rwr7xMxfDqPG?=
 =?us-ascii?Q?wVHA8gtv94l3KyEZjQRi/AARx4zo7yyG2slnvwd7OfKXS6d7q5Wnubw1Cx81?=
 =?us-ascii?Q?qrxya4JFp+ATG0S40p+3kI/O9YMTF6yo3wFaDDs2Iiol68s7GmXFMLh5F/bS?=
 =?us-ascii?Q?DYsRwIKqdeB3jnbVj5y5EMc5fP2HjA5RxFTVKq0D+gxmC30Gv2n2HgineG8I?=
 =?us-ascii?Q?r8ZJ0Gz8hZXaJVUXAak5+ZzjzUHFurGom8OMMVzpy6pzmKJI+4+XWzr7GGKS?=
 =?us-ascii?Q?PtvQJOlUEK06KeoJ+GT+8a2n9Y4JLqPgc7HEuCyK7/f9TF/zEsNXMMhk9Ltt?=
 =?us-ascii?Q?RnOLEcKQy9GSFdQcKNBJo/Dc70TVcqm84VxFIvC3rGpD9ZTZ6NHdku4+M2Ol?=
 =?us-ascii?Q?XGqRMp/22Fx3lc6XN+fl/DZVt07D2vSTC0mGTzPSVo90mIAus2I6eYYYpImE?=
 =?us-ascii?Q?HapLfejgBRz3Hhujnwl+qVLR9AgBwr294D0RopAtYokNU/wom5rMNqfwUCZP?=
 =?us-ascii?Q?xsOCHwmyRWErGzi+DQor+WZ6Kmm3ICTPivXI37+9JvJ0TiPQsLk2ZOAmqAd4?=
 =?us-ascii?Q?1W2Xhq4k+OYGbrfsij3SoFeQU4FlTY3M/d+oPedcNc9BlrxRYZ3OaNiNYtXS?=
 =?us-ascii?Q?v+yLfzVaPPm4Sz7raG5wwTskTmh6mBt1eKPXb+2VuZJ5KNAuDbNRuUm7XRZP?=
 =?us-ascii?Q?22RpgvkresPCu7zaiABDi9DyaYvqwkKsHNCYP70bH2587HdlYnfHnT4pkI7k?=
 =?us-ascii?Q?MBDIiUVbqhskpl8A42o3yntJ1YPTMXsyw9hrnGoOBh+iZjJXEsQjSF2OjEHt?=
 =?us-ascii?Q?2PAIDlhAmILWQf/J21mVE+RXZ9MH7jXHpdiAh8gMJh35N/qm285ueICbEYbu?=
 =?us-ascii?Q?L+GA3/pdAKXG44ly3+/dnaqdbE9/TlRLum1+nnYbI0lkU/lZ5eDyfyF4EIu8?=
 =?us-ascii?Q?Or84F29TJ7jxHLmoCJRlyRI5+qmg08+2u46I+vOais+mG8GtUBdYZJwVuNCd?=
 =?us-ascii?Q?bdfOGJ9ktG86rkxeARSBfGs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3ee2c3-7ea3-457a-9c08-08d9f6740b63
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 02:27:31.6415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EcG72SdRaA1u+SSYw4Ejxpm0qWHpcjTDDbD/48DwJEoscdLYMtqMDW1FPRGrmzmcNo6rEuLKmXDCvzGZlk8IGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4819
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

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, February 23, 2022 4:57 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix typo in amdgpu_discovery.c

disocvery -> discovery

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 2e0ff1ace6fc..e4fcbb385a62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -435,8 +435,8 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(st=
ruct amdgpu_device *adev,
 	}
 }
=20
-static void amdgpu_disocvery_read_from_harvest_table(struct amdgpu_device =
*adev,
-						uint32_t *vcn_harvest_count)
+static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device =
*adev,
+						     uint32_t *vcn_harvest_count)
 {
 	struct binary_header *bhdr;
 	struct harvest_table *harvest_info;
@@ -1140,7 +1140,7 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device=
 *adev)
 			amdgpu_discovery_read_harvest_bit_per_ip(adev,
 				&vcn_harvest_count);
 	} else {
-		amdgpu_disocvery_read_from_harvest_table(adev,
+		amdgpu_discovery_read_from_harvest_table(adev,
 			&vcn_harvest_count);
 	}
=20
--=20
2.35.1

