Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EFBC32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 17:44:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2982310E521;
	Wed, 28 Sep 2022 17:44:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B48B110E521
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 17:44:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYc6wnhqRNhhJ1/LAPZjcBDb3BwaURAYzLv/iRrQinFx8Y0n+BgHs20OTmFth+dl/nEsJNz6HQ59KRV2RHwtK8auV5BYNQ5/VRwr4GIdeAmUOca7hB4dCF7VdZ/kShb6Np78vSZIyEpbgsH2hemZkuyDkU5X69KTk6LKmptnpNknTu/5y6iUL0OtLtEFZ+GqGAzyRj1FZaQkQ1IlzHjPQ6Xz1Vf/Jy05WPyA/8UlcCNVL/xKUsfAOoyQWSiYGkManVPE92EIvWi/1OndTntWfH59fF7CxeY0usk56z7ZjiLNEQFSWKj7BRMPsUNACvuL78kuK9eKsyJ/VkX9MR0d6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OisIYZewLatg0LahT5tg5EG58n0n5Oq8JjVYDtuo20=;
 b=ggDF41IHitZINqzO8Agon6ZR17e/zGkCr4Ymfhq/tcyqWFR/dTW8DQ6zt/CTM6ssnQZ2pQ+OhpbPsXkytzcYDYkW22o6XAM/qPmeQkHTBYd+vazcCRjs+cClEitw27ICVF1iIPONC0zlr7DDHae637TVuUFSkTdYGZl+BVVlCWgOnFs/ljeOUbEev9wNwinwKc0VKtCIJ4dgsKlkL/T+sEy/GM+oHSinvbqd46bMKx3RgdfRzU0X89nswImja/kMDjvDZaBAUE0eAR0/sKrinVjkJLmYatftTuOmYqz2yGRH5h5Fc0miC/efrq7Gumd4Wi3Pt8Byu55YaTBKAsI9Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OisIYZewLatg0LahT5tg5EG58n0n5Oq8JjVYDtuo20=;
 b=d5ihBixzDBAt22u6QBf7FGCVQ6f2T5pBX8IzRbRkk9SB5jdJpBkIos5meAeXSJlv23Dmg79Hke9Evf0wf324g0L0GuLFTspyHY4s1fehiN1o6SwznjIarmLzb5dkucjZ0/iBGiUQZzXwzTqM/NXcT8QfBQR7GeJA0asw3dInWl4=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by DS0PR12MB6582.namprd12.prod.outlook.com (2603:10b6:8:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 17:44:34 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::e11a:acb9:a1d0:e3a4]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::e11a:acb9:a1d0:e3a4%8]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 17:44:34 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Chander, Vignesh" <Vignesh.Chander@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Skip put_reset_domain if it doesnt exist
Thread-Topic: [PATCH] drm/amdgpu: Skip put_reset_domain if it doesnt exist
Thread-Index: AQHY02D9FDldjwcG8kmlxxk1hGfvXK31G1cw
Date: Wed, 28 Sep 2022 17:44:34 +0000
Message-ID: <CH0PR12MB5372CCA0BCE183DA8D1B7994F4549@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20220928173733.12457-1-Vignesh.Chander@amd.com>
In-Reply-To: <20220928173733.12457-1-Vignesh.Chander@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6733c387-6f54-4d95-b6d9-50fc7644a966;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-28T17:37:58Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|DS0PR12MB6582:EE_
x-ms-office365-filtering-correlation-id: 10a9672d-0baa-4f33-6695-08daa1791af9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z+7pW8gZmznkhTdJ5HaIvT/W9vFCehEebDyzic6v6RZd1GiXd5G8aJrO3b0pozvED0Bx1p2MkpzrzTPlEGjWPwiu9An/ktyxRgYm9O4YGwLpMOjKgh0emdDXzsklmXjG0Gn+CK5QGz021maKaK0/TxMizxIeivGbUFXZr4UjiELQGPC+YRA2aasqy7IAAHZj5vnbg/5Hw79ZEkBR9TXJoV2//76QL8Aa9vi31kMs7ELH2LIQF7YBQpx20N9MBV6jYnJgSa9OUHDEZHDl91V7WLEy7PcqdbNm1HBFz/QazZVRwL9k9aDhVuH8r7dAr6oW6CraFpAFccDkIYwLml/wQXTFb26fOmHz4gEVBu+4eQ6D/durz0XxT8Ce1Dszo2s8mS5sbAipQPj5NpdCejSaL2ff1ek7Yqs70fk+J6c5OCr0Igp6izyUcMUfGtlmLIWsumcy1ACoQbWmsSmZxTdbwSP+rPlGZDSiaVkyCE/LlbbpglJheqZPd4ioDvmynOMiNAWmmFYtQlIeD+7aeOZpE7TVaX7zB9Hy8GMwcU+a9eyojON7EIqKRiK3U6ZaDCFieAtHObAhQLXOkXMOfzXucmf+G7w63970McEsS7tNvWiDB+jjEy6XvJ2GL7UqwaxH48/Yj6Bw6NSNoiMm/mDJpDXojYbr+wVqxcJK8vc6L6Heqlo1mQgefcrdvUqZKnNfy+fBujrsPw9HoGIFLSK13h+eiqASoqsVL1QYtRPqrL6Su5sS9RIA4MceDn4aygmJhNL1JrhjO/xxq1vLTxro5g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199015)(316002)(71200400001)(478600001)(110136005)(86362001)(38100700002)(186003)(83380400001)(53546011)(26005)(55016003)(9686003)(7696005)(6506007)(38070700005)(122000001)(2906002)(76116006)(5660300002)(33656002)(52536014)(66946007)(66476007)(41300700001)(66556008)(64756008)(8676002)(8936002)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YXodOkrNoH+MtriwsSi/6HSZXMOf7pYadlk9aa+AM1uD3yI6CF6+C/Hm08xo?=
 =?us-ascii?Q?aruUxgOHR1q+dBDYqMVMwwNtFGD/eKPtvKFDSG6Ci/uZM8A4N7gVVDMOxGD+?=
 =?us-ascii?Q?lW9syY7DMvZBflsclRgdNcXLiGp5zUNDXxBzvoX6chlPniGY6dlJn4kh841e?=
 =?us-ascii?Q?smpSrsr5ZZq57bvS66DzP7uQZ8acw6VvsGFCXAOHkZblhqE6zg1zYjMGMKLX?=
 =?us-ascii?Q?4vmVb1Mwy6jua1cBuN6AKR3LBWB1khcVICKMyugj1eo9nzIbII87uXHuEDCF?=
 =?us-ascii?Q?S4ZleUAj3s52KMeD+gftHfiUaJDHJOrQY6v6T/8JFkL2KGHu1zz0Ycy39Da3?=
 =?us-ascii?Q?Hwsoa9uEDP/EZt7ZWtKBwPyNMEk7z9qZxCJwyzBeJUDo/JrFCoiFT9Wax0VE?=
 =?us-ascii?Q?7Rdla3/6ejrNB1cSHJfhxVPjMMMUqMZv8jSCLd037K4rRbKD+2zxOPrDG/ID?=
 =?us-ascii?Q?xfmHU4Fj/ZLVWodLUE9452N0XyBya7Qs5OaHKAUn49+jkvfTrI6DczkNvxuz?=
 =?us-ascii?Q?35ThYBZApo+GEAkdKrnrMLYXFKSu0HGk5XLU3QoRHMh0VxT4h99XzJQASneG?=
 =?us-ascii?Q?t3qnnXeiv9m2DfimM90JfoUeeqCOHaP17qNLms1VCFSOSYe5w2CzYLaesY4X?=
 =?us-ascii?Q?ORXxYiZgGkT3kjfiXP5jL6+lWsIYVE2hAcT3vaGR2MwtxsC66ekwXXq45NrW?=
 =?us-ascii?Q?YarKiRoeHnTgaWTqQJO26fMeg8PVFQ1CVzA6Td0mF62RVd9rjhN7B/bZt5Pa?=
 =?us-ascii?Q?pyCzHGSwvlDkfXhD1k7R3eFQpSz4Jp1wgVz1ssJEplBzFt6b88lplrQ4qkHR?=
 =?us-ascii?Q?T+mhebjRYw5P69ad3EQ6XGBf0FAW1Ovhp9hajwM6o+1fayoInLQCYpqmzjfW?=
 =?us-ascii?Q?xno+np6W0nofarWFWUs1qb1Cn9vKQO3xIbcHbN3ZAusUCarH+utZVAOSaSbe?=
 =?us-ascii?Q?uFZlvBHlo1oz6ns7uB6dbVJ6jFsDemYdaXgw3kuMHXBbFVBeUyC76JqR98us?=
 =?us-ascii?Q?9fFoGfmo7futjAS8VgnPf7YtF7YLs9MiM/U+a7UHFKdfLTc22LCLxCtgQEnj?=
 =?us-ascii?Q?OvlCvhBH1xkiaxXyKfbhSpzUiK6gnLv2NF2e65vlDZni3d+TfRlz8jKrAlwr?=
 =?us-ascii?Q?CkuqovsvhjiLFJg40nOd45HVAIGrCEj/EZra1CKWHdtrlOU+zTqvE5aCFcm6?=
 =?us-ascii?Q?Btaa9b04QI/IAeaaqNH8oEv2HCe7pBn9n01takjt/TjtlMZ/R6RxXX95eT8k?=
 =?us-ascii?Q?7lxBLXhqP9O/84skgwk+36tTNjCAUj83SGx/C8HGAHcdB5BzB0PT16DX2JHn?=
 =?us-ascii?Q?kdnTpFFyhqi36JfMIHzCsfFXczONIOVGo1AHjrXFmzKAZcFXq1nKVH8aYX/y?=
 =?us-ascii?Q?3cuJxR9IXz/GgsRnKM4ANIvDxrvY5EHu+JBwdTNOR+kMN+OyFAT0SJ4cCN7k?=
 =?us-ascii?Q?qm3j6S1PS8AjCOQpLdO2DRww6xd2gYVRjAZN05EUfLRAaOop/YR1j7R16ucj?=
 =?us-ascii?Q?ohb6dzwI6J88/gS0UoOnGuVT4HZ6tOS7SrbiTnCjDITHubt8gLF/ctQNzkrf?=
 =?us-ascii?Q?LryAEEQPrsY+6g2hGIM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a9672d-0baa-4f33-6695-08daa1791af9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 17:44:34.1701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tDgHCL6FudKrXs51iOlbe0zUXexS1jI78DPv7u3+VQIeXteUhDkQl9QG66o5S4Y50AA0/OMgZkDqYLYI8sbyVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582
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

[AMD Official Use Only - General]

Please add description like under sriov xgmi configuration , the hive reset=
 is handled by host driver , hive->reset_domain  is not been  in initialize=
d  so  need to skip it .

Regards
Shaoyun.liu


-----Original Message-----
From: Chander, Vignesh <Vignesh.Chander@amd.com>
Sent: Wednesday, September 28, 2022 1:38 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>; Chander, Vignesh <Vignesh.Chander@a=
md.com>
Subject: [PATCH] drm/amdgpu: Skip put_reset_domain if it doesnt exist

Change-Id: Ifd6121fb94db3fadaa1dee61d35699abe1259409
Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 47159e9a0884..80fb6ef929e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -217,7 +217,8 @@ static void amdgpu_xgmi_hive_release(struct kobject *ko=
bj)
        struct amdgpu_hive_info *hive =3D container_of(
                kobj, struct amdgpu_hive_info, kobj);

-       amdgpu_reset_put_reset_domain(hive->reset_domain);
+       if (hive->reset_domain)
+               amdgpu_reset_put_reset_domain(hive->reset_domain);
        hive->reset_domain =3D NULL;

        mutex_destroy(&hive->hive_lock);
--
2.25.1

